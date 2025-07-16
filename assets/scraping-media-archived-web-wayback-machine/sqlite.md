# Using a SQLite database to manager scraping

In in the main lesson, we rely on the file system to store downloaded snapshot data, data of extracted `<img>` tags, and the relationship between web page snapshots and ad image snapshots. While this allows us to directly view the downloaded data through the file manager, for larger projects this approach can be cumbersome. You may want to consider using a lightweight relational database like [SQLite](https://www.sqlite.org/) to manage your scraping progress.

The following is a brief guide (corresponding to `sqlite.ipynb` in this folder) to using a SQLite database manage scraping media resources from archived web pages on the Wayback Machine. Namely, we will scrape all images featured on home pages of the 44 popular Japanese websites mentioned in our main lesson - not just images fitting known banner ad dimensions. This code here also covers scraping images in `<frame>`s.

## Define the shape of the data

Relational databases are based on the concept of tables, which are collections of related data. We will need to define the exact shape of the data we want to store in the database. Here are the SQL statements to create the tables we will need:

```sql
CREATE TABLE IF NOT EXISTS source_urls (url TEXT, has_queried_cdx BOOLEAN DEFAULT FALSE, PRIMARY KEY (url))
CREATE TABLE IF NOT EXISTS cdx_entries (urlkey TEXT, timestamp DATETIME, original TEXT, mimetype TEXT, statuscode INTEGER, digest TEXT, length INTEGER, is_source_url BOOLEAN, source_url TEXT NULL, has_scraped_for_resources BOOLEAN DEFAULT FALSE, PRIMARY KEY (original, timestamp, digest))
CREATE TABLE IF NOT EXISTS snapshot_files (digest TEXT, mimetype TEXT, statuscode INTEGER, length INTEGER, file BLOB, md5 TEXT, metadata TEXT, PRIMARY KEY (digest))
CREATE TABLE IF NOT EXISTS snapshot_resources (parent_url TEXT, parent_timestamp TEXT, parent_digest TEXT, child_tag TEXT, child_url TEXT, child_tag_attrs TEXT, child_digest TEXT, child_timestamp TEXT, PRIMARY KEY (parent_url, parent_timestamp, child_tag, child_url))
```

With these statements, we define four tables:

- `source_urls`: source urls of interest
- `cdx_entries`: CDX entries for the source urls and media resources of interest (e.g., the `src` of `<img>` tags and `<frame>` tags, etc.)
- `snapshot_files`: downloaded snapshot files of the source urls and resources
- `snapshot_resources`: identified resources from HTML and their parent-child relationship between the urls/resources and resources

In this guide, the term "resource" is used to refer all the potential items that could be identified from an HTML file. Subsequently, `snapshot_resource` contains both `<img>` and `<frame>` tags. Using a unified table to store all the identified resources from HTML is more flexible for future extensions, such as scraping resources from `<iframe>` or `<embed>` tags.

## Seed the database with source websites

We start with the `nikkeibp-may2000-abridged.csv` by copying the data into `source_websites` SQLite table. Then we will download the CDX data for all the websites, stored in the `cdx_entries` table. Lastly, we will download the snapshot HTML files for these URLs, stored in the `snapshot_files` table. The code re-uses the utility functions from the previous lesson, such as `retry` and `download_cdx_data`. Since the process is analogous to the previous lesson, the code is omitted here for brevity.

## Scraping resources of interest from snapshot files

The scraping process contains three main steps:

1. Identify resources of interest from the downloaded HTML files
2. Download CDX data for these resources
3. Download snapshot files of the resources based on the CDX data

In the case of recursively scraping images in HTML pages in `<frame>` tags, we will run these three steps in a loop. With each additional iteration, we are digging one level deeper into the `<frame>` hierarchy. Two loops would suffice for scraping images in most `<frame>` tags.

### Extract resources of interest

Similar to the previous lesson, we will construct both `extract_img_tags` and `extract_frame_tags` functions to extract the `<img>` and `<frame>` tags from the `html` files in the `snapshot_files` table.

```python
from bs4 import BeautifulSoup

def extract_img_tags(html_content, html_base_url):
    soup = BeautifulSoup(html_content, 'html.parser')
    extracted_imgs = []

    img_tags = soup.find_all('img', src=True)
    for img in img_tags:
        src = img.get('src')
        src = ensure_absolute_url(src, html_base_url)
        img['html_base_url'] = html_base_url
        ad_link = img.parent.get('href') if img.parent.name == 'a' else None
        if ad_link:
            ad_link = ensure_absolute_url(ad_link, html_base_url)
        attrs = img.attrs
        attrs["ad_link"] = ad_link
        extracted_imgs.append({
            "tag": "img",
            "url": src,
            "attrs": attrs
        })

    return extracted_imgs

def extract_frame_tags(html_content, html_base_url):
    soup = BeautifulSoup(html_content, 'html.parser')
    extracted_frames = []

    frame_tags = soup.find_all('frame', src=True)
    for frame in frame_tags:
        src = frame.get('src')
        src = ensure_absolute_url(src, html_base_url)
        extracted_frames.append({
            "tag": "frame",
            "url": src,
            "attrs": frame.attrs
        })

    return extracted_frames
```

Then, we will store both `<img>` and `<frame>` tags discovered in the `snapshot_resources` table, along with their parent's url, timestamp, and digest. Each row is initialized with all fields but `child_digest` and `child_timestamp`, which will be filled in the next step.

```python

import sqlite3, json
conn = sqlite3.connect("wm_scraping.db")

cursor = conn.execute(
    'SELECT * FROM cdx_entries JOIN snapshot_files ON cdx_entries.digest = snapshot_files.digest WHERE cdx_entries.mimetype="text/html"'
)

columns_names = [desc[0] for desc in cursor.description]
html_cdx_entries = [dict(zip(columns_names, row)) for row in cursor.fetchall()]
cursor.close()


print(f"Found {len(html_cdx_entries)} source urls to scrape resources for")

for html_cdx_entry in html_cdx_entries:
    original = html_cdx_entry['original']
    timestamp = html_cdx_entry['timestamp']
    print(f"Processing {original} at {timestamp}")
    file_blob = html_cdx_entry['file']
    extracted_imgs = extract_img_tags(file_blob, original)
    extracted_frames = extract_frame_tags(file_blob, original)
    try:
      for resource in extracted_imgs + extracted_frames:
          conn.execute(
              "INSERT OR IGNORE INTO snapshot_resources (parent_url, parent_timestamp, parent_digest, child_tag, child_url, child_tag_attrs) VALUES (?, ?, ?, ?, ?, ?)",
              (original, timestamp, html_cdx_entry['digest'], resource['tag'], resource['url'], json.dumps(resource['attrs']))
          )
      conn.execute(
          "UPDATE cdx_entries SET has_scraped_for_resources = TRUE WHERE original = ? AND timestamp = ?",
          (original, timestamp)
      )
    except Exception as e:
        print(f"Error processing {original} at {timestamp}: {e}")
        conn.rollback()
        continue
    finally:
        conn.commit()
conn.close()
```

### Download CDX data for resources

In this guide, instead of relying on Wayback Machine's redirection mechanism, we will use the CDX Server API to request the closest available snapshot of a resource at a given URL (`child_url` column in the table `snapshot_resources`) from the timestamp of the archived web page snapshot containing it (`parent_timestamp` column in the table `snapshot_resources`). We will use the `download_cdx_closest_data` function to download the CDX data.

```python
@retry
def download_cdx_closest_data(url, timestamp, sleep=1.5):
    time.sleep(sleep)
    cdx_url = f"https://web.archive.org/cdx/search/cdx?limit=1&url={url}&closest={timestamp}"
    print(f"CDX URL: {cdx_url}")
    response = requests.get(cdx_url)
    response.raise_for_status()

    rows = [row for row in response.text.strip().split("\n") if row]
    if len(rows) == 0:
        return None
    return rows[0]
```

Then, we will download the CDX data for resources whose CDX data has not been downloaded, identified by its missing `child_digest` and `child_timestamp` fields. After each download, we insert a new row into `cdx_entries` table, and update the `snapshot_resources` table with the found `child_digest` and `child_timestamp`.

```python
conn = sqlite3.connect("wm_scraping.db")
cursor = conn.execute(
    "SELECT * FROM snapshot_resources WHERE child_digest IS NULL ORDER BY child_tag, RANDOM()"
)
columns_names = [desc[0] for desc in cursor.description]
snapshot_resources_without_cdx = [dict(zip(columns_names, row)) for row in cursor.fetchall()]

cursor.close()

for snapshot_resource in snapshot_resources_without_cdx:
    parent_url = snapshot_resource["parent_url"]
    parent_timestamp = snapshot_resource["parent_timestamp"]
    parent_digest = snapshot_resource["parent_digest"]
    child_tag = snapshot_resource["child_tag"]
    child_url = snapshot_resource["child_url"]
    child_tag_attrs = snapshot_resource["child_tag_attrs"]

    cdx_entry = download_cdx_closest_data(child_url, parent_timestamp)
    if cdx_entry:
        try:
            cdx_entry = cdx_entry.split(" ")
            child_digest = cdx_entry[5]
            child_timestamp = cdx_entry[1]
            conn.execute(
                "UPDATE snapshot_resources SET child_digest = ?, child_timestamp = ? WHERE parent_url = ? AND parent_timestamp = ? AND child_tag = ? AND child_url = ?",
                (child_digest, child_timestamp, parent_url, parent_timestamp, child_tag, child_url)
            )

            conn.execute(
                "INSERT OR IGNORE INTO cdx_entries (urlkey, timestamp, original, mimetype, statuscode, digest, length, is_source_url, source_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                (cdx_entry[0], cdx_entry[1], cdx_entry[2], cdx_entry[3], cdx_entry[4], cdx_entry[5], cdx_entry[6], False, child_url)
            )
            print(f"Updated child digest for {parent_url} at {parent_timestamp} with {child_digest}")
        except Exception as e:
            print(f"Error updating child digest for {parent_url} at {parent_timestamp}: {e}")
            conn.rollback()
            continue
        finally:
            conn.commit()
    else:
        print(f"No CDX entry found for {child_url} at {parent_timestamp}")

conn.close()
```

Expect to spend a few hours to complete this step. It is time-consuming because:

- Different from the previous lesson, we are interested in all images, not just ones that fit the banner ad dimensions.
- The CDX Server API is slow at returning data.

## Downloading snapshot files for source websites

Lastly, given the `cdx_entries` table, we will download the snapshot files for the source websites.

After each image download, we further retrieve its metadata, such as the image size, animation properties, etc, for future analysis against the claimed attributes in the original `img` tag in the `child_tag_attrs` field from `snapshot_resources` table.

```python

from PIL import Image
from io import BytesIO

def check_banner_properties(width: int, height: int) -> dict:
    """Reference to the IAB and JIAA banner ad sizes in banner-ad-dimensions.csv"""
    IAB_SIZES = {
        (88, 31): "Micro Button",
        (120, 240): "Vertical Banner",
        (120, 90): "Button 1",
        (120, 60): "Button 2",
        (125, 125): "Square Button",
        (234, 60): "Half Banner",
        (392, 72): "Full Banner with Vertical Navigation Bar",
        (468, 60): "Full Banner",
    }

    JIAA_SIZES = {
        (120, 90): "Regular Badge",
        (120, 60): "Small Badge",
        (120, 600): "Regular Skyscraper",
        (125, 125): "Large Badge",
        (148, 800): "Large Skyscraper",
        (160, 600): "Wide Skyscraper",
        (200, 200): "Small Rectangle",
        (224, 33): "Small Banner",
        (300, 250): "Regular Rectangle",
        (336, 280): "Large Rectangle",
        (468, 60): "Regular Banner",
        (728, 90): "Large Banner",
    }

    iab_size = IAB_SIZES.get((width, height), None)
    jiaa_size = JIAA_SIZES.get((width, height), None)
    is_banner_ad = iab_size is not None or jiaa_size is not None
    return {
        "iab_size": iab_size,
        "jiaa_size": jiaa_size,
        "is_banner_ad": is_banner_ad,
    }

def get_image_metadata(image_bytes):
    metadata = {
        "width": None,
        "height": None,
        "size": None,
        "animated": None,
        "frame_count": None,
        "animation_duration": None,
        "loop_count": None,
        "iab_size": None,
        "jiaa_size": None,
        "corrupt": True,
    }
    try:
        bytes_io = BytesIO(image_bytes)
        with Image.open(bytes_io) as img:
            metadata = {
                "width": img.width,
                "height": img.height,
                "size": bytes_io.getbuffer().nbytes,
                "animated": False,
                "frame_count": 1,
                "animation_duration": 0,
                "loop_count": 0,
                "iab_size": None,
                "jiaa_size": None,
                "corrupt": False,
            }

            # Check for GIF animation
            if img.format == "GIF" and "duration" in img.info:
                try:
                    metadata["animated"] = True
                    metadata["frame_count"] = img.n_frames
                    metadata["animation_duration"] = (
                        img.info.get("duration", 0) * img.n_frames
                    )
                    metadata["loop_count"] = img.info.get("loop", 0)
                except (AttributeError, KeyError):
                    pass
            # Check if image is a banner ad
            banner_metadata = check_banner_properties(
                metadata["width"], metadata["height"]
            )

            metadata["iab_size"] = banner_metadata["iab_size"]
            metadata["jiaa_size"] = banner_metadata["jiaa_size"]
    except Exception as e:
        print(f"Error getting image metadata: {e}")

    return metadata
```

Here is the code to download the actual archived snapshots of the resources:

```python
import sqlite3
import hashlib
import json

conn = sqlite3.connect("wm_scraping.db")

cursor = conn.execute("SELECT * FROM cdx_entries WHERE is_source_url = FALSE AND digest NOT IN (SELECT digest FROM snapshot_files) GROUP BY digest ORDER BY RANDOM()")
column_names = [desc[0] for desc in cursor.description]
undownloaded_cdx_entries = [dict(zip(column_names, row)) for row in cursor.fetchall()]

print(f"Downloading {len(undownloaded_cdx_entries)} snapshot files")
cursor.close()

for cdx_entry in undownloaded_cdx_entries:
    original = cdx_entry['original']
    timestamp = cdx_entry['timestamp']
    digest = cdx_entry['digest']
    request_flag = "id_"

    is_mimetype_image = cdx_entry['mimetype'].startswith('image/') or cdx_entry['mimetype'].startswith('im')
    is_extension_image = original.endswith('.jpg') or original.endswith('.jpeg') or original.endswith('.png') or original.endswith('.gif') or original.endswith('.webp')
    is_image = is_mimetype_image or is_extension_image
    if is_image:
        request_flag = "im_"

    content = download_archived_snapshot(original, timestamp, request_flag=request_flag, sleep=0.5)
    if content == "skip":
        print(f"Skipping download for {original} at {timestamp} due to previous failure.")
        continue
    if content[0] != 200:
        print(f"Failed to download snapshot for {original} at {timestamp}: {content[0]}")
        continue

    if isinstance(content[1], str):
        file_bytes = content[1].encode('utf-8')
    else:
        file_bytes = content[1]

    md5 = hashlib.md5(file_bytes).hexdigest()
    if is_image:
        image_metadata = get_image_metadata(file_bytes)
    else:
        image_metadata = None
    try:
      conn.execute("INSERT INTO snapshot_files (digest, mimetype, statuscode, length, file, md5, metadata) VALUES (?, ?, ?, ?, ?, ?, ?)",
      (digest, content[2].get("Content-Type"), content[0], len(file_bytes), file_bytes, md5, json.dumps(image_metadata)))
      conn.execute("UPDATE cdx_entries SET has_scraped_for_resources = TRUE WHERE digest = ?", (digest,))
    except Exception as e:
        print(f"Error inserting snapshot file for {original} at {timestamp}: {e}")
        conn.rollback()
        continue
    finally:
      conn.commit()
    print(f"Downloaded snapshot for {original} at {timestamp}")

conn.close()
```

## Using a GUI to inspect the database

During the scraping process, you can use a GUI like [DB Browser for SQLite](https://sqlitebrowser.org/) to inspect the database. In our case, it's especially useful to preview the `snapshot_files` table, since the files don't exist in the file system.

## Analyzing the data with SQL

Using a SQL database grants us the flexibility to analyze the data with SQL queries, instead of bespoke Python code.

For example, we can run a concise query to check on the scraping progress:

```sql
SELECT
  (SELECT COUNT(*) FROM snapshot_resources WHERE child_digest IS NULL) as resource_without_cdx,
  (SELECT COUNT(*) FROM snapshot_resources) as total_resources,
  (SELECT COUNT(*) FROM cdx_entries WHERE digest NOT IN (SELECT digest FROM snapshot_files)) as undownloaded_cdx,
  (SELECT COUNT(*) FROM cdx_entries) as total_cdx;
```

We can also find images that are 468px wide and 60px high (the dimensions of a Full Banner in IAB standards) in the `snapshot_resources` table:

```sql
SELECT COUNT(*) FROM snapshot_resources WHERE child_tag = "img" AND json_extract(child_tag_attrs, '$.width') = "468" AND json_extract(child_tag_attrs, '$.height') = "60";
```
