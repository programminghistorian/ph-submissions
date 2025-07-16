---
title: "Lesson Title"
slug: scraping-media-archived-web-wayback-machine
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Richard Lewei Huang
- Yufeng Zhao
reviewers:
- Forename Surname
- Forename Surname
editors:
- Massimiliano Carloni
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/656
difficulty: 3
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}


## Lesson Introduction

In this lesson, you will learn how to scrape media resources from historical web pages preserved by the Internet Archive’s Wayback Machine.

As historians turn their attention to the 1990s and early 2000s - a period that saw rapid growth and mainstream adoption of the web - web archives are becoming increasingly valuable sources for historical research. While many web archives like the Wayback Machine provide a user-friendly interface for looking up archived web content by individual URLs, researchers looking to perform computational or quantitative analysis may prefer accessing archived web content programmatically in order to examine the archival availability of historical URLs, bulk download archived web pages, and extract specific page elements for further analysis.

In this lesson, we will use the Wayback Machine’s CDX Server API to scrape media resources on archived web pages. Our case study focuses on building a small dataset of banner advertisements appearing on home pages of popular Japanese-language websites in the month of May 2000. The techniques introduced in the lesson are generally comparable to standard web scraping procedures, but we will cover a number of challenges specific to scraping historical web pages archived on the Wayback Machine.

### Prerequisites

This lesson is intended for readers with an intermediate-level understanding of Python and HTML. You should already be familiar with basic web scraping using Python and BeautifulSoup, and have some experience working with web APIs. Prior experience in using the Wayback Machine will also be helpful, though we will review relevant background information in the next section.

If you are new to Python and HTML, you may want to consult _Programming Historian_ lessons on [Python](https://programminghistorian.org/en/lessons/introduction-and-installation) and [HTML](https://programminghistorian.org/en/lessons/viewing-html-files), and subsequent lessons in that series. You may also want to check out the lessons [Creating APIs with Python and Flask](https://programminghistorian.org/en/lessons/creating-apis-with-python-and-flask) and [Introduction to Populating a Website with API Data ](https://programminghistorian.org/en/lessons/introduction-to-populating-a-website-with-api-data) to familiarize yourself with basic concepts related to application programming interfaces (APIs). Another great beginner-friendly tutorial on web scraping is the online textbook [Introduction to Cultural Analytics and Python](https://melaniewalsh.github.io/Intro-Cultural-Analytics/04-Data-Collection/00-Data-Collection.html).

You can follow the lesson on any mainstream operating system you prefer, as long as you can get a recent version of Python installed on your operating system. On Python, you will need to have the following libraries installed:

- requests
- BeautifulSoup
- pillow
- tenacity

We recommend that you install [Anaconda](https://anaconda.org/), a distribution of Python specifically designed for data science research. A standard installation of Anaconda includes the first three libraries, and you can easily install tenacity by running `pip install tenacity`.

Each code snippet in the lesson can be run as a cell in a [Jupyter notebook](https://programminghistorian.org/en/lessons/jupyter-notebooks), but they must be run in order of appearance.

### Learning Outcomes

By the end of this lesson, you will learn:

- Using the Wayback Machine CDX Server API to check the archival availability of web content located at a given URL.
- Batch downloading archived web content from the Wayback Machine
- Identifying and downloading web media resources embedded in archived web pages, including images and multimedia content in historical formats, such as Flash and Shockwave.
- Identifying and calculating time skew of embedded media resources on archived web pages.
- Technical limitations and ethical considerations in scraping the Wayback Machine.

## Web Archiving Basics

Founded in 1996, the Internet Archive’s Wayback Machine is the world’s first web archive, and today it holds billions of web pages from around the world, publicly accessible through its website at [web.archive.org](http://web.archive.org).[^1] Given its founding date and the worldwide scope of its collection, the Wayback Machine is also the only place where some of the earliest web pages on the Internet may be found.

The Wayback Machine proactively archives the web by running a **web crawler**, which is a program that systematically browses and downloads content on the web to be archived. The Wayback Machine archives all types of content on the web - not only web pages, but also images, PDFs, audio and video files, and so on. 

In the rest of the lesson, we shall use the term **resource** to refer to any type of content on the web identified by a uniform resource locator (URL). We use the verb **capture** to refer to the act of saving a web resource for inclusion in the archive, and a web resource that is captured at a particular point in time is commonly referred to as an archived **snapshot**.[^2]

### Recomposition of archived web pages and "time skew"

Web archive scholars have long emphasized that web archives differs significantly from traditional archives, and archived web resources may not be identical to what existed online in the past. This is a result of a number of technical complexities involved in capturing and representing web content. While a comprehensive overview of these challenges is beyond the scope of this lesson[^3], one key issue that researchers should understand when scraping the Wayback Machine is time skew - the phenomenon where different elements on an archived web page appear to have been captured at different times from one another, or from the main HTML document itself.[^4]

Time skews happen because when archiving web pages, the Wayback Machine's crawler usually cannot capture all linked resources on the page at the same time. When the user requests to view an archived web page snapshot, the Wayback Machine will deliver a "best effort" reconstruction of a web page by rewriting links in the archived HTML file so that each embedded resource loads from the closest available archived version, based on the timestamp of the main HTML file. This reconstruction process, known in web archiving scholarship as **recomposition**[^5], allows the page to appear functional, but it may also introduce temporal mismatches between elements. These mismatches can span days, months, or even years, meaning that a single archived page may contain elements that never actually coexisted on the live web.

For researchers, time skews can complicate the work of interpreting an archived web page, and raises important questions about what exactly an archived web page represents. When scraping media resources from the Wayback Machine, it is important to identify and account for time skew, especially when temporal coherence is of importance.

### A Guided Example: The Archived Google Homepage

To better understand how web content is served on the Wayback Machine, and how time skew can arise, we can take a closer look at a real-life example: an archived snapshot of google.com on the Wayback Machine, avaialable at [https://web.archive.org/web/19981202230410/http://www.google.com/](https://web.archive.org/web/19981202230410/http://www.google.com/).


#### Anatomy of an Archived Web Snapshot URL

The URL of an archived snapshot of a web resource on the Wayback Machine follows the following format:

```
https://web.archive.org/web/[timestamp][optional request flag]/[original URL]
```

- **Timestamp**: The exact point in time when the archived web resource is captured, formatted in `yyyymmddhhmmss`. On the Wayback Machine, the timestamp is recorded in Coordinated Universal Time (UTC).
- **Request flag**: Controls how content is served from the Wayback Machine's server to the user. Not used in this example URL, but we will explain its role shortly.
- **Original URL**: The original URL of the archived web resource.

Therefore, the example URL tells the Wayback Machine to display an archived snapshot of **google.com** that was captured on **December 2, 1998, at 23:04:10 UTC**.

#### URL Rewriting

Now, open that URL in your browser. You will see the archived snapshot of Google.com displayed on your browser. Right-click the Google logo and click Inspect, you will see that the `<img>` tag for the Google logo looks like this:

```html
<img src="/web/19981202230410im_/http://www.google.com/google.jpg" />
```

As you may already have guessed, the Wayback Machine has rewritten the `src` attribute of the Google logo `<img>` element to tell the browser to fetch an archived copy of `google.jpg` from **the same timestamp** as the page. But what if no copy of `google.jpg` was captured on that exact point in time?

In that case, the Wayback Machine quietly redirects the request to the **closest available version**. In this example, the image actually loads from:

```
https://web.archive.org/web/19990504112211im_/http://www.google.com/google.jpg
```

You can observe the redirection behavior by right clicking on the Google logo and click Open Image in New Tab, and see the new URL in your browser's location bar. You can also check out the capture timestamp of each on-page resource by clicking "About this capture" on the Wayback Machine toolbar, which should show the same time difference.

The Google example shows a modest skew of a few months. In some cases, time skew can be far more extreme. For instance, this archived snapshot of [http://hudir.hungary.com](https://web.archive.org/web/19990202064014/http://hudir.hungary.com/) captured in February 1999 displays an advertisement promoting an event in November 2004, which is nearly 6 years out of date. The advertisement is not even the most time skewed element on the page, with two GIF images on the page captured over 17 years after the page itself. 

In the lesson, you will learn to detect time skewed elements on an archived web page programmatically.

#### Request Flags

Return to the Google logo URL again:

```
/web/19990117032727im_/http://www.google.com/google.jpg
```

The part between the timestamp and the original URL (which is `im_` in the URL) is called a **request flag**. [^6] It tells the Wayback Machine how to serve the archived content. Usually, request flags are automatically added during the recomposition process of an archived web page, but we may also add them manually for scraping purposes. 

| Flag            | Meaning                        |
| --------------- | ------------------------------- |
| `im_`           | Return most image, audio, and video files for display inside a web page.                                                                                                                                                    |
| `oe_`           | Similar to `im_`. Used for (usually legacy) embedded media like Flash, Shockwave, and VRML.                                                                                                                                   |
| `cs_`, `js_` | Used for rewriting internal URLs in CSS and JavaScript files. If you need unmodified versions, use the `id_` flag.     |
| `if_`, `_fw`    | Used for displaying content in `<iframe>` and `<frame>` elements. We can also manually apply either of them to retrieve a recomposed archived web page without the Wayback Machine toolbar showing. |
| `id_`           | Return an archived HTML, CSS, or JavaScript file as-is, without rewriting links (good for scraping)      |

In our case study, we will use the `id_` flag to get raw HTML for analysis, and the `im_` flag to fetch images.


## Identifying Media Content on Archived Web Pages from the 1990s - Early 2000s

Before we head into our case study, we will give a brief overview of how common types of web media are referenced in HTML, with specific attention to historical media formats and HTML authoring practices that you may encounter on archived web pages from the late 1990s and early 2000s. 

### Images

Images are inserted into a web page with the `<img>` tag, with the path to the image recorded in the `src` attribute of the `<img>` element. Many images also come with an `alt` attribute, which provides a textual description of the image known as [alt text](https://en.wikipedia.org/wiki/Alt_attribute), which is usually displayed when the image cannot be loaded, or if the user is using a screen reader. For researchers today, the alt text might be helpful to identify the intended content or function of an image when the original file is missing or when conducting textual analysis of archived pages.

In web pages from the 1990s and early 2000s, it was also a common practice to specify image height and width using `height` and `width` attributes in the `<img>` element. This allows browsers to finish rendering the layout of the web page even when the image is not fully loaded or if it fails to load [^7]. Researchers today may use the provided width and height information to find images fitting specific dimensions, which we will demonstrate in our case study. 

By default, the Wayback Machine will rewrite URLs of images with the `im_` request flag, which you should also use when downloading these files. 

### Media in Embed and Object Tags

`<embed>` and `<object>` are two HTML tags commonly used to add non-image media resources on web pages in the 1990s and early 2000s. Types of media resources supported by these tags include audio files (e.g. WAV, MP3, MIDI), video clips (e.g. MPEG, QuickTime, Windows Media), Flash/SWF animations, Shockwave content, Java applets, RealAudio/RealVideo, VRML, PDF documents, and other plugin-based interactive media. 

During the browser wars of the late 1990s, `<embed>` was preferred by Netscape while Microsoft and later W3C pushed the `<object>` tag as a standard container for web media content. As a result, many early web pages included both tags to ensure cross-browser compatibility.[^8] In practice, `height` and `width` attributes are also almost always defined in both tags. 

Finding out the path to the actual media file is relatively easy for both tags. The following is a [real-life example](https://web.archive.org/web/20040625234530/http://www.poly.edu:80/huss/idm/idmi.html) that uses nested `<object>` and `<embed>` tags to embed Shockwave content:

```html
<object
  classid="clsid:166B1BCA-3F9C-11CF-8075-444553540000"
  codebase="https://web.archive.org/web/20040625234530oe_/http://download.macromedia.com/pub/shockwave/cabs/director/sw.cab#version=8,5,0,0"
  width="800"
  height="600"
>
  <param name="src" value="idmi.dcr" />
  <param name="swStretchStyle" value="fill" />
  <param name="AutoStart" value="true" />
  <embed
    src="/web/20040625234530oe_/http://www.poly.edu/huss/idm/idmi.dcr"
    width="800"
    height="600"
    autostart="true"
    pluginspage="http://www.macromedia.com/shockwave/download/"
  />
</object>
```

In this example, the embedded Shockwave movie file is `idmi.dcr`, which is seen in both the `src` attribute on the `<embed>` tag and the corresponding `<param>` tag under the parent `<object>` tag. 

By default, the Wayback Machine will rewrite URLs of embedded media files with the `oe_` request flag, which you should also use when downloading these files. 

In most cases, file formats of embedded media files can be distinguished by their file extension as well as attributes such as `codebase` and `pluginspage` in `<object>` and `<embed>` tags. The data preservation activist organization ArchiveTeam maintains a [helpful wiki of file formats](http://justsolve.archiveteam.org/wiki/Main_Page) that you may find useful for identifying obsolete or arcane file formats.

## Case Study: Building a Dataset of Historical Banner Ads Appearing on Popular Japanese Websites

In the rest of this lesson, you will build a dataset of banner ads appearing on popular Japanese-language websites in the year 2000 by scraping the Wayback Machine.

Banner ads are an early form of graphical advertisement on the web. Though widely considered a visual and privacy nuisance, banner ads played an important role in shaping the visual landscape of the early commercial web.[^9]

A dataset of banner ads can be of use for researchers interested in the history of online advertising, visual culture of the early web, and the study of web archiving itself. However, there are very few systematic datasets of banner ads. In 2023, the authors of this lesson published a banner ad dataset containing 22,915 historical banner ads scraped from archived snapshots of more than 77,000 URLs, which are in turn collected from six printed "Internet directory" books published in mainland China and the United States between 1999 and 2001.[^10] The dataset can be browsed on [Banner Depot 2000](http://banner-depot-2000.net), a website where visitors can search for specific banners by keyword, and compose cut-up poetry using individual frames of banner ad images as verses.

In our case study, we will build a miniature version of that dataset. To do this, we will scrape archived snapshots of home pages of a small set of Japanese-language websites, detect and download banner ads appearing on these pages, and organize them into a structured dataset. For each ad file with a unique original URL, our dataset should provide the following information:

- A unique identifier of the banner ad (derived from its original URL)
- Dimensions of the banner ad (in pixels)
- Archived web page snapshots on which it appear; and for each appearance, we log:
  - the original URL of the web page, and the timestamp of its archived snapshot
  - the original URL of the banner ad, and the timestamp of its archived snapshot as shown on each archived web page snapshot containing it
  - the alt text of the banner ad if available
  - the original URL that the ad would have led the user to if clicked

### Getting a List of URLs to Scrape From

To begin with, we will need a list of popular Japanese-language web pages to scrape banner ads from. We will use a list of the top-50 most visited websites by home Internet users in Japan in May 2000, originally published by the Japanese media company Nikkei BP. The list is cited and preserved in the appendix of a [2000 study of e-commerce websites in the United States and Japan](https://firstmonday.org/ojs/index.php/fm/article/view/802) by Internet researcher Kumiko Aoki, published on the open-access Internet research journal First Monday.[^11] 

For the purposes of this study, we will download all unique archived snapshots of the home pages of these websites captured in May 2000, and extract banner ads from them. 

#### CSV File Structure

For your convenience, we prepared [a CSV file containing the list of websites](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/scraping-media-archived-web-wayback-machine/nikkeibp-may2000-abridged.csv) in advance. You can also download [a Python notebook containing all code snippets](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/scraping-media-archived-web-wayback-machine/scraping-media-archived-web-wayback-machine.ipynb) in the case study section.

In the CSV file, we removed four websites that do not feature Japanese-language content: microsoft.com (ranked #2), msn.com (ranked #9), real.com (ranked #44), and geocities.com (ranked #46). According to the original study and through manual observation of archived web pages, we also removed nifty.ne.jp (ranked #6) and infoweb.ne.jp (ranked #11), because the home pages of both websites redirected to nifty.com (ranked #5) in May 2000. This leaves us with 44 websites to scrape.

The CSV file is formatted as follows:

| rank | url             |
| ---- | --------------- |
| 1    | yahoo.co.jp     |
| 3    | biglobe.ne.jp   |
| 4    | geocities.co.jp |
| ...  | ...             |

### Getting started with accessing the Wayback Machine programmatically

#### APIs vs. Research Toolkits

There are different ways to access the Wayback Machine programmatically. In this lesson, we will use the Wayback Machine’s [CDX Server API](https://archive.org/developers/wayback-cdx-server.html), which allows us to see all available archived snapshots of a given URL on the Wayback Machine, along with metadata of these snapshots. In other words, it provides us with the same information accessible through the Wayback Machine’s web interface, but we can process the information programmatically using a language like Python. 

Aside from the CDX Server API, the Wayback Machine can also be queried through the [Wayback Availability JSON API](https://archive.org/help/wayback_api.php) and the [Memento Protocol API](https://ws-dl.blogspot.com/2013/07/2013-07-15-wayback-machine-upgrades.html). All three APIs are free to use, though the CDX Server API can return more types of information about the archived snapshots than the other two APIs. 

If your research involves a large number of URLs that makes manual scraping impractical, you may want to consider using an integrated web archive research toolkit such as the Internet Archive’s [Archives Research Compute Hub](https://archive-it.org/arch/). Researchers intending to use these toolkits generally need to have access to raw archived web content in WARC format or enter a partnership with an archiving organization such as the Internet Archive, but they can provide advanced features such as full-text search and data visualization.

#### Ethical Concerns in Using Archived Web Data

Before we start scraping, it is important to consider ethical issues involved in using web archives for research purposes. While much of the archived web is publicly accessible - and by default all data archived in web archives were technically publicly accessible when they were online - the accessibility should not be mistaken for unrestricted use. Researchers must remain mindful that the archived web contains a wide range of materials, some of which were never intended for large-scale harvesting or public scrutiny. Before publishing or redistributing any dataset or findings, researchers should carefully consider privacy implications, potential harms, and the historical context in which the content was originally created and archived. 

It should also be noted that large-scale scraping can strain the technical infrastructure of web archives like the Wayback Machine, which operates with limited funding and bandwidth. In the lesson, we will demonstrate a number of measures to reduce the network impact of our scraping. 

#### Using the Wayback Machine CDX Server API

You can query the CDX Server API in the same way as any REST API. The base URL to access the API is:

```bash
http://web.archive.org/cdx/search/cdx?url=[The URL you want to check available archived snapshots thereof]
```

By default, the API will return all archived snapshots of the URL. The CDX Server API provides a number of parameters to format and filter the results. A full list of available parameters that the CDX Server API accepts can be found [here](https://archive.org/developers/wayback-cdx-server.html#filtering).

In the example below, we use the API to retrieve a list of available snapshots of infoseek.co.jp, the Japanese version of the popular 1990s web search engine [Infoseek](https://en.wikipedia.org/wiki/Infoseek). The Wayback Machine indicates that it has more than 375,800 snapshots archived of infoseek.co.jp. In our request, we add the parameters `from`, `to`, and `filter` to make the API return only snapshots captured between May 1, 2000 and May 31, 2000 (formatted in the same `yymmddhhmmss` format as seen in archive snapshot URLs) with the HTTP status code `200` (more on this below):

```bash
http://web.archive.org/cdx/search/cdx?url=infoseek.co.jp&from=20000501000000&to=20000531235959&filter=statuscode:200
```

You may access the results of this API request by loading the above URL directly in your browser. The data returned is in a tabular format with the columns separated by space, and each line represents a snapshot of the URL. Our API request returned a total of seven lines, which is much easier for us to process.

Now let us turn to the data. The first line in the returned data looks like this:

```csv
jp,co,infoseek)/ 20000510114724 http://www.infoseek.co.jp:80/ text/html 200 6HSB5P3JZXTDXJMDKN7ZE35WVXYRALYH 6430
```

By default, the individual fields are separated with space, and the order of the columns is as follows:

```csv
"urlkey","timestamp","original","mimetype","statuscode","digest","length"
```

A detailed explanation of the meanings of the columns is available [here](https://support.archive-it.org/hc/en-us/articles/115001790023-Access-Archive-It-s-Wayback-index-with-the-CDX-C-API), but the key columns here that we wil use in our lesson are `timestamp`, `statuscode`, and `digest`.

The field `timestamp` identifies the exact point in time at which the web resource was captured. The timestamp is provided in the format of `yyyymmddhhmmss` in UTC timezone, which is identical to the timestamp format in snapshot URLs.

The line reproduced above therefore represents a snapshot of [http://www.infoseek.co.jp:80](http://www.infoseek.co.jp:80), captured on May 20, 2000, at 08:47:19 UTC time. 

The field `statuscode` represents the [HTTP response code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status) received by Wayback Machine’s crawler when it saved the page from the live web, which indicates whether a resource was captured successfully in a technical sense. A successful capture should have an HTTP response code `200`.

The field `digest` is a content “fingerprint” generated by the Wayback Machine. The `digest` can be used to detect if two snapshots contain identical content (even if captured at different times or at different URLs). In our case study, We will use `digest` to identify duplicate archived snapshots during scraping. 

#### Dealing with Rate Limiting

The Wayback Machine employs rate limiting to prevent server overload from excessive requests. When you exceed rate limits, the Wayback Machine may return an HTTP `429` (Too Many Requests) error. The Wayback Machine currently does not make its thresholds for rate limiting public, though there is a [GitHub issue](https://github.com/edgi-govdata-archiving/wayback/issues/137#issuecomment-1845803523) citing conversations with Internet Archive employees confirming the existence of rate limiting measures. Per the issue, you should keep your request frequency under the recommended thresholds below:

| API Endpoint                       | Rate Limit       |
| ---------------------------------- | ---------------- |
| `/cdx/*`                           | 48 requests/min  |
| `/web/[timestamp][request flag]/*` | 480 requests/min |


To ensure that our download requests stay within the rate limits, we will use the `time.sleep` function to add a delay between each request. However, if we still hit rate limits (this can happen occasionally), we can implement an [exponential backoff](https://en.wikipedia.org/wiki/Exponential_backoff) retry strategy using Python's ⁠tenacity library. This approach automatically retries failed requests with progressively longer delays between attempts, giving the server time to recover while ensuring temporary rate limits will not cause your script to fail immediately.

```python
import tenacity

def give_up_on_failure(retry_state):
    print(f"Giving up after {retry_state.attempt_number} attempts.")
    return "skip"  # Do not retry anymore

retry = tenacity.retry(
    stop=tenacity.stop_after_attempt(10), 
    wait=tenacity.wait_exponential(multiplier=1, min=2, max=32),
    retry_error_callback=give_up_on_failure
)
```

We will use the `@retry` decorator defined here in our subsequent code snippets.

#### Batch Querying the CDX Server API

We will use the CDX Server API to get a list of archived snapshots of each URL in our list, made between May 1, 2000 and May 31, 2000 with a HTTP response code `200`. We make a number of API parameters as parameters of the function, so that they can be easily adjusted. 

```python
import time
import requests
from urllib.parse import urlencode

@retry
def download_cdx_data(url, sleep=1.5, from_timestamp=None, to_timestamp=None, filters=None, collapse=None):
    params = [('url', url)]
    if from_timestamp:
        params.append(('from', from_timestamp))
    if to_timestamp:
        params.append(('to', to_timestamp))
    if collapse:
        params.append(('collapse', collapse))
    if filters:
        for filter_item in filters:
            params.append(('filter', filter_item))

    cdx_url = f"https://web.archive.org/cdx/search/cdx?{urlencode(params)}"
    print(f"CDX URL: {cdx_url}")

    print(f"Fetching CDX data for: {url}")
    response = requests.get(cdx_url)
    response.raise_for_status()
    time.sleep(sleep)
    
    if response.status_code == 200:
        return response.text
    else:
        raise Exception(f"Failed to fetch CDX data for {url}: {response.status_code}")
```

Now, we will loop through the URLs in our list to retrieve a list of available unique snapshots. To do this, in addition to the date and response code parameters, we add a parameter `collapse` and set its value to `digest` in our API request. This will make the API merge adjacent snapshots with the same `digest` together into the first snapshot.

```python
import csv
from pathlib import Path

csv_file = "nikkeibp-may2000-abridged.csv"

urls_data = []

with open(csv_file, mode='r', encoding='utf-8') as file:
    reader = csv.DictReader(file)
    urls_data = list(reader)

for url in urls_data: 
    # If the CDX data for the URL has already been downloaded, skip it.
    cdx_file_path = Path(f"data/urls/{url['url']}/cdx.csv")
    if cdx_file_path.exists():
        print(f"CDX data for {url['url']} already exists at {cdx_file_path}. Skipping download.")
        continue
    try:
        cdx_data = download_cdx_data(url['url'], from_timestamp="20000501000000", to_timestamp="20000531235959", filters=["statuscode:200"], collapse="digest")
        cdx_file_path.parent.mkdir(parents=True, exist_ok=True)
        with open(cdx_file_path, 'w', encoding='utf-8') as cdx_file:
            cdx_file.write(cdx_data)
        print(f"CDX data saved for {url['url']} at {cdx_file_path}")
    except Exception as e:
        print(f"Error fetching CDX data for {url['url']}: {e}")
```

The entire process should take about 10-20 minutes to finish. The code also checks for and skips any files already downloaded, so you do not have to restart from the beginning if the process is interrupted.

When the code finishes running, you should see a new directory named `data` created in your current directory (the directory where you put the notebook file). The directory structure inside `data` looks like this:

```bash
- data/
  - urls/
    - 3web.ne.jp/
      - cdx.csv
    - asahi-net.or.jp/
      - cdx.csv
    - ...
```

Each CSV file contains the CDX Server API response for a particular URL. Some CSV files might be empty, because the Wayback Machine does not have any snapshots of the URL captured in May 2000. In total, you should have downloaded 44 CSV files.

### Downloading archived web pages from the Wayback Machine

#### Building a download function with time skew and encoding detection capabilities

Since we will be downloading banner ad files afterwards, and since both banner ad files and web pages can be accessed on the Wayback Machine using the same URL pattern, we will first build a unified download function that can handle both types of resources.

In addition to downloading a snapshot, our download function should also have the following capabilities:

- Check for time skews. If we give our function the original URL of an image and a target timestamp, our function should be able to download the archived snapshot of the image captured closest to the target timestamp, and return the actual timestamp of the downloaded snapshot.
- Deal with HTTP errors. Our function should be able to handle situations where a URL is not archived by the Wayback Machine (in which case it will return an HTTP `404` error), if a URL is excluded from public access (in which case it will return an HTTP `403` error), or if we hit the rate limit (in which case it will return a HTTP `429` error).
- Handle legacy encoding. [Character encoding](https://en.wikipedia.org/wiki/Character_encoding) refers to the mechanism by which textual data is represented on computers. Early non-English web pages often used region-specific encoding standards that have since been superseded by [UTF-8](https://en.wikipedia.org/wiki/UTF-8), a universal encoding standard. However, when dealing with non-English web pages from the late 1990s and early 2000s, it is often necessary to specify page encoding so that its text could be read correctly.

Below, we construct a download function that accomplishes these goals:

```python
@retry
def download_archived_snapshot(url, timestamp, request_flag="id_", sleep=0.5):
    snapshot_url = f"https://web.archive.org/web/{timestamp}{request_flag}/{url}"
    print(f"Fetching archived snapshot for: {snapshot_url}")
    response = requests.get(snapshot_url, allow_redirects=True, stream=True)
    time.sleep(sleep)

    if response.status_code == 404 or response.status_code == 403: 
        return (response.status_code, None, response.headers, response.url)
    response.raise_for_status()

    # detect type of content
    content_type = response.headers.get("Content-Type")
    if (not content_type.startswith("text")):
        return (response.status_code, response.content, response.headers, response.url)
    
    # if the content is text, set the encoding to apparent encoding to ensure that the text is decoded correctly
    response.encoding = response.apparent_encoding
    return (response.status_code, response.text, response.headers, response.url)
```

In this function, we first attempt to download an archived snapshot of the `url` captured at the `timestamp`. If the download is successful, the function will return the HTTP status code, the downloaded content, the HTTP headers, and the final URL of the downloaded content, which we can use to check for time skew. 

The function also checks the `Content-Type` HTTP header to determine whether the content is text-based and detects encoding to ensure that text content (like HTML pages) could be read properly.

If it receives a `404` or `403` error, only the status code, HTTP headers, and the URL will be returned. For any other HTTP errors (like a `429` error), it will raise an exception, which should trigger tenacity to retry running the function after additional delays.

#### Downloading web page snapshots for each URL captured in May 2000

We now download each web page snapshot returned by the API. To do this, we loop through each CSV file to get a list of snapshots to download. 

Note that in the code below, we also do a manual round of deduplication by snapshot `digest`. This is because the parameter used in our API call `&collapse=digest` only merges adjacent snapshots with the same `digest`. By manually deduplicating here, we ensure that we only retrieve one web page snapshot for each unique `digest`.

```python
cdx_files = Path("data/urls/").glob("*/cdx.csv")
for cdx_file in cdx_files:
    print(f"Processing CDX file: {cdx_file}")
    snapshots = []
    with open(cdx_file, mode='r', encoding='utf-8') as file:
        reader = csv.reader(file, delimiter=" ")
        reader = list(reader)
        seen_digests = set()
        for row in reader:
            digest = row[5]
            if digest not in seen_digests:
                seen_digests.add(digest)
                snapshots.append(row)
    print(f"Found {len(snapshots)} unique snapshots in {cdx_file}")

    # Check if there are any snapshots already downloaded for this CDX file
    html_files_downloaded = list(cdx_file.parent.glob("*.html"))
    if html_files_downloaded:
        html_file_names = [file.stem for file in html_files_downloaded]
        snapshots = [snapshot for snapshot in snapshots if snapshot[1] not in html_file_names]
    print(f"Remaining snapshots to download: {len(snapshots)}")

    # Iterate through the snapshots
    for snapshot in snapshots:
        url, timestamp = snapshot[2], snapshot[1]
        print(f"Downloading snapshot for URL: {url} at timestamp: {timestamp}...")
        
        html_content = download_archived_snapshot(url, timestamp)
        if html_content == "skip":
            print(f"Skipping download for {url} at {timestamp} due to previous failure.")
            continue
        if html_content[0] != 200: # This is unlikely to happen, but if it does, we will raise an exception
            raise ValueError(f"Failed to download snapshot for {url} at {timestamp}: {html_content[0]}")
        # Save the HTML content to a file named after the timestamp of the snapshot
        html_file_path = cdx_file.parent / f"{timestamp}.html"
        
        with open(html_file_path, 'w', encoding='utf-8') as html_file:
            html_file.write(html_content[1])
        print(f"Snapshot saved at {html_file_path}")

```

The download process may take 15-30 minutes to finish, depending on your computer's Internet connection (you may have trouble downloading one snapshot of yahoo.co.jp captured at timestamp `20000504190238` due to a glitch on Wayback Machine's server, but you should have no trouble downloading other snapshots). At this point, your root directory structure should look like this:

```bash
- data/
  - urls/
    - 3web.ne.jp/
      - 20000511122128.html
      - cdx.csv
    - asahi-net.or.jp/
      - 20000510014515.html
      - 20000520065032.html
      - cdx.csv
    - ...
```

### Detecting and downloading banner ads on downloaded web page snapshots

#### Detecting banner ads by dimension

After downloading web page snapshots, we can start looking for banner ads in these snapshots. In this lesson, we will use banner ad dimensions as a proxy for banner ads.

As mentioned earlier, in the 1990s and early 2000s, it was a common practice to specify element height and width using `height` and `width` attributes in `<img>`, `<embed>`, and `<object>` tags, which are commonly used to display banner ads (Flash-based banner ads would appear in `<embed>` and `<object>` tags). Around the same time, advertisers and ad networks began efforts to standardize banner ad dimensions.[^12] In the United States, this standardization effort was spearheaded by the Internet Advertising Bureau (IAB), a trade organization which has been releasing recommendations for banner ad dimensions since 1996. In Japan, a similar standardization effort was started by the [Japan Internet Advertising Association (JIAA)](https://web.archive.org/web/20010218112916/http://www.jiaa.org/act/contents99_2.html) in the late 1990s. The JIAA has been releasing its own banner ad dimension recommendations, with some dimensions not included in the IAB list.

The convergence of these two practices enables us to identify likely banner ads programmatically by looking for `<img>`, `<embed>`, and `<object>` tags fitting one of the known banner ad dimensions. 

For your convenience, we have put the recommended banner ad dimensions released by the IAB and the JIAA in a CSV file named [`banner-ad-dimensions.csv`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/scraping-media-archived-web-wayback-machine/banner-ad-dimensions.csv).[^13]  The CSV file looks like this:

| width | height | iab_name        | jiaa_name     | jiaa_name_ja         |
| ----- | ------ | --------------- | ------------- | -------------------- |
| 88    | 31     | Micro Button    |               |                      |
| 120   | 240    | Vertical Banner |               |                      |
| 120   | 90     | Button 1        | Regular Badge | レギュラーバッジ        |
| ...   | ...    | ...             | ...           | ...                  |

In the following code, we will load `banner-ad-dimensions.csv`, and build a function named `extract_img_tags` that will use BeautifulSoup to find all `<img>` and `<embed>` elements in the downloaded HTML files fitting one the recommended banner ad sizes (we are not looking for `<object>` tags here since parsing it can make the sample code more complicated, and since in many cases they will appear alongside with an equivalent `<embed>` tag). 

For each tag, we scrape the following information: 
 - original ad file URL in the `src` attribute
 - its [alt text](https://en.wikipedia.org/wiki/Alt_attribute) in the `alt` attribute
 - (for images) the URL that it would have led the user to upon clicking, found in the `href` attribute of its parent `<a>` element.

```python
# load banner ad dimensions from banner-ad-dimensions.csv
with open('banner-ad-dimensions.csv', 'r') as file:
    reader = csv.DictReader(file)
    banner_dimensions = list(reader)  # Convert to list to read all rows

from urllib.parse import urlparse, urljoin
from bs4 import BeautifulSoup

def ensure_absolute_url(src, base_url):
    # Process the source URL to ensure it is absolute.
    # If the src is relative, it will be made absolute using the base URL.
    base_url = f'http://{base_url}' if not base_url.startswith(('http://')) else base_url
    if not (urlparse(src).netloc):
        # If src is relative, make it absolute using the base URL
        src = urljoin(base_url, src)
    elif src.startswith('//'):
        # If src is protocol-relative, add the HTTP scheme
        src = f"http:{src}"
    return src


def extract_ad_tags(html_content, html_base_url, banner_dimensions):

    soup = BeautifulSoup(html_content, 'html.parser')
    media_tags = soup.find_all('img') + soup.find_all('embed')
    
    extracted_ads = []

    for media in media_tags:
        width = media.get('width')
        height = media.get('height')

        if width and height:
            width = int(width)
            height = int(height)
            for banner in banner_dimensions:
                if (width == int(banner['width']) and height == int(banner['height'])):
                    src = media.get('src')
                    src = ensure_absolute_url(src, html_base_url)
                    # if media is an <img> tag, get the ad link
                    # If media is an <object> or <embed> tag, return None
                    ad_href = None
                    if media.name == 'img':
                        ad_href = media.parent.get('href') if media.parent.name == 'a' else None
                    if ad_href:
                        ad_href = ensure_absolute_url(ad_href, html_base_url)
                    # Append the extracted banner ad details to the list
                    extracted_ads.append({
                        'tag': media.name,
                        'src': src,
                        'width': width,
                        'height': height,
                        'ad_href': ad_href,
                        'alt': media.get('alt', ''),
                    })
                    break  # Stop checking once a match is found

    return extracted_ads
```

Now, we can use these functions to parse all HTML files downloaded to extract information about elements fitting the ad dimensions. In the following code, we will group the extracted ad image information by the images' original URL, and then calculate a MD5 hash of each original image URL to serve as a unique identifier of the URL.

[MD5](https://en.wikipedia.org/wiki/MD5) is a [hash function](https://en.wikipedia.org/wiki/Hash_function) that can generate a unique 32-character string for input data of any length. Hash functions like MD5 and SHA-1 (which is used to generate snapshot `digest`s) are often used to verify data integrity and enable easier retrieval of specific data in databases. 

In our case, we will be using MD5 hashes of image URLs to represent them when downloading the image files, because most image URLs contain characters like slashes `/` and questions marks `?` that most operating systems do not allow to be used as file names.

```python
# Walk through the data directory and process each HTML file
data_dir = Path("data")

all_extracted_ads = []

for html_file in data_dir.glob("*/**/*.html"):
    timestamp = html_file.stem
    base_url = html_file.parent.name 
    print(f"Processing HTML file: {html_file} with timestamp: {timestamp}")
    # read the HTML content
    with open(html_file, 'r', encoding='utf-8') as file:
        html_content = file.read()

    extracted_ads = extract_ad_tags(html_content, base_url, banner_dimensions)
    for ad in extracted_ads:
        ad['web_page_snapshot_timestamp'] = timestamp
        ad['web_page_original_url'] = base_url
    all_extracted_ads.extend(extracted_ads)

# organize the extracted ads dictionary by unique URLs
from collections import defaultdict
organized_ads = defaultdict(list)
for ad in all_extracted_ads:
    organized_ads[ad['src']].append(ad)
# print out the number of unique URLs
print(f"Number of unique ad URLs: {len(organized_ads)}")

import hashlib
def md5_hash(url):
    """Return the MD5 hash of the given URL."""
    return hashlib.md5(url.encode('utf-8')).hexdigest()

# Now, we can create the final organized structure
final_organized_ads = {}
for url, appearances in organized_ads.items():
    final_organized_ads[md5_hash(url)] = {
        "src": url,
        "appearances": appearances
    }

# remove the `src` key from each appearance, as it is redundant
for entry in final_organized_ads.values():
    for appearance in entry['appearances']:
        if 'src' in appearance:
            del appearance['src']

# Print out some statistics about the tags used to display the ads
tag_counts = defaultdict(int)
for ad in all_extracted_ads:
    tag_counts[ad['tag']] += 1
print("Tag counts:")
for tag, count in tag_counts.items():
    print(f"{tag}: {count}")

# Save the final organized ads to a JSON file
import json
organized_extracted_ads = "data/organized_extracted_ads.json"
with open(organized_extracted_ads, 'w', encoding='utf-8') as jsonfile:
    json.dump(final_organized_ads, jsonfile, ensure_ascii=False, indent=4)
print(f"Ads data saved to {organized_extracted_ads}")

```

This process should only take seconds to finish. Once it finishes, it prints out the total number of unique ad file original URLs, as well as the number of `<img>`, `<embed>`, and `object` tags found: 

```
Number of unique ad URLs: 91
Tag counts:
img: 212
Ads data saved to data/organized_extracted_ads.json
```

It seems that we found 91 unique ad URLs contained in 212 `<img>` tags fitting banner ad dimensions, but we found no `<embed>` tags fitting banner ad dimensions, which means that we found no Flash-based ads. 

You can open `data/organized_extracted_ads.json` to check the information extracted. The file represents a Python dictionary object, with each key representing the MD5 hash of original image URLs, and its value containing the original image URL (`src`) and its `appearances` across the downloaded HTML snapshots. 

A typical key-value pair in the JSON file should look like this:

```json
{   
    ...
    "806bb6f037542f8535592b077830e134": {
        "src": "http://rim.or.jp/img/my-banner.gif",
        "appearances": [
            {
                "tag": "img",
                "width": 88,
                "height": 31,
                "ad_href": "http://www.rim.or.jp/myserver/",
                "alt": "マイサーバ",
                "web_page_snapshot_timestamp": "20000511022115",
                "web_page_original_url": "rim.or.jp"
            },...
        ]
    },
    ...
}
```

#### Downloading archived snapshots of banner ad images

Now, we will use the `download_archived_snapshot` function and `data/organized_extracted_ads.json` to download one snapshot for each unique banner ad image URL at each of its appearances' `web_page_snapshot_timestamp`. By doing this, we utilize the Wayback Machine's redirection mechanism to find the closest available ad image snapshot at each web page snapshot's timestamp. 

```python
import re
from io import BytesIO
from PIL import Image, UnidentifiedImageError

# Load image metadata
with open("data/organized_extracted_ads.json", 'r', encoding='utf-8') as f:
    final_organized_ads = json.load(f)

def get_image_file_extension_and_dimension(image_bytes_io):
    try:
        with Image.open(image_bytes_io) as img:
            return f".{img.format.lower()}", *img.size
    except (UnidentifiedImageError, Exception):
        return '.unk', None, None

def extract_timestamp_from_url(url):
    match = re.search(r'/web/(\d{14})', url)
    return match.group(1) if match else None

def create_placeholder(path, content=""):
    Path(path).parent.mkdir(parents=True, exist_ok=True)
    with open(path, 'w') as f:
        f.write(content)

def skip_unavailable(ad_src_md5, timestamps, status_code):
    print(f"Skipping ad {ad_src_md5} due to status {status_code}.")
    for ts in timestamps:
        create_placeholder(f"data/ads/{ad_src_md5}/{ts}.{status_code}")

def save_ad(file_path, payload):
    Path(file_path).parent.mkdir(parents=True, exist_ok=True)
    with open(file_path, 'wb') as f:
        f.write(payload)

def download_one_ad_src(ad_data, ad_src_md5):
    src = ad_data['src']
    timestamps = [a['web_page_snapshot_timestamp'] for a in ad_data['appearances']]

    for appearance in ad_data['appearances']:
        ts = appearance['web_page_snapshot_timestamp']
        expected_w, expected_h = appearance.get('width'), appearance.get('height')
        if list(Path(f"data/ads/{ad_src_md5}").glob(f"{ts}*")):
            print(f"Already downloaded: {ad_src_md5} @ {ts}")
            continue

        print(f"Downloading {src} @ {ts}...")
        status, payload, headers, final_url = download_archived_snapshot(src, ts, "im_")
        print(f"Status: {status}, final URL: {final_url}")

        if status in [403, 404]:
            skip_unavailable(ad_src_md5, timestamps, status)
            break

        final_ts = extract_timestamp_from_url(final_url)
        if not isinstance(payload, bytes):
            create_placeholder(f"data/ads/{ad_src_md5}/{ts}-{final_ts}.not_bytes", str(payload))
            continue

        ext, actual_w, actual_h = get_image_file_extension_and_dimension(BytesIO(payload))
        if ext not in ['.jpg', '.jpeg', '.png', '.gif', '.bmp']:
            create_placeholder(f"data/ads/{ad_src_md5}/{ts}-{final_ts}.unsupported_file")
            continue
        
        if (actual_w, actual_h) != (expected_w, expected_h):
            print(f"Dimension mismatch: expected {expected_w}x{expected_h}, got {actual_w}x{actual_h}")
            save_ad(f"data/ads/{ad_src_md5}/{ts}-{final_ts}.{actual_w}x{actual_h}{ext}", payload)
        else:
            print(f"Saving {ad_src_md5} @ {ts}-{final_ts}{ext}")
            save_ad(f"data/ads/{ad_src_md5}/{ts}-{final_ts}{ext}", payload)

# Process all ads
for ad_src_md5, ad_data in final_organized_ads.items():
    download_one_ad_src(ad_data, ad_src_md5)
```

The code above divides Wayback Machine's response to our download request into several categories. First, it validates the HTTP response code - if a `404` or `403` error is received, then it will save a placeholder file for all recorded web page appearance timestamps. 

If it manages to download a file, it inspects the file to ensure it is a supported image format, checks dimensions against the expected dimensions previously scraped from the HTML files, and saves either a placeholder or the actual image file (renamed in the format of `{web_page_snapshot_timestamp}-{ad_snapshot_timestamp}{.actual image dimensions if different from dimensions in HTML}.{detected image format}`).

#### Writing scraping results out to a JSON file

After all the downloading is done, we will write the scraping results to a JSON file: 

```python

# read the JSON file organized_extracted_ads.json again
with open('data/organized_extracted_ads.json', 'r', encoding='utf-8') as jsonfile:
    final_organized_ads = json.load(jsonfile)

# loop through final_organized_ads and compute the MD5 hash of each ad file
for ad_src_md5, ad_data in final_organized_ads.items():
    appearances = ad_data['appearances']
    for appearance in appearances:
        web_page_snapshot_timestamp = appearance['web_page_snapshot_timestamp']
        # get the file name of the ad
        file_name = f"data/ads/{ad_src_md5}/{web_page_snapshot_timestamp}*"
        # Find the download file
        ad_files = list(Path(file_name).parent.glob(Path(file_name).name))
        ad_file = ad_files[0]

        # get the extension of the ad file
        ext = ad_file.suffix[1:]  # remove the leading dot
        appearance['ad_snapshot_timestamp'] = ad_file.name.split('-')[1][:14] if '-' in ad_file.name else None
        if ext in ['jpg', 'jpeg', 'png', 'gif', 'bmp'] and ad_file.name.count('.') == 1:
            appearance['ad_snapshot_status'] = "scraped"
            appearance['ad_snapshot_path'] = str(ad_file)
        else:
            # if the filename contains two dots, it means the file has mismatched dimensions
            if ad_file.name.count('.') == 2:
                appearance['ad_snapshot_status'] = "mismatched_dimensions"
                appearance['ad_snapshot_path'] = str(ad_file)
            else:
                appearance['ad_snapshot_status'] = ad_file.suffix[1:]  # use the extension as the status for 404 and 403 errors

with open('data/results.json', 'w', encoding='utf-8') as jsonfile:
    json.dump(final_organized_ads, jsonfile, ensure_ascii=False, indent=4)
```
Now, you should have a file called `results.json` saved under `data/`. A typical key-value pair in the JSON file should look like follows: 

```json
{...

"53ce99d7bc85e94228c9f774d54ae9e5": {
        "src": "http://img.yahoo.co.jp/adv/yahoo/20000117/pseat-b.gif",
        "appearances": [
            {
                "tag": "img",
                "width": 224,
                "height": 33,
                "ad_href": "http://jp.rd.yahoo.com/M=300025961.300311916.302007352.300001147/S=2075494237:N/A=300130501/R=0/?http://www.yahoo.co.jp/docs/info/visa/",
                "alt": "VISA",
                "web_page_snapshot_timestamp": "20000511110235",
                "web_page_original_url": "yahoo.co.jp",
                "ad_snapshot_timestamp": "20010604234910",
                "ad_snapshot_status": "scraped",
                "ad_snapshot_path": "data/ads/53ce99d7bc85e94228c9f774d54ae9e5/20000511110235-20010604234910.gif"
            }
        ]
    }
...
}

```

For your convenience, we have included a HTML file in the course files named [`banner-ads-visualization.html`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/scraping-media-archived-web-wayback-machine/banner-ads-visualization.html) that visualizes scraped banner ad data in `results.json`. To use the HTML file, start a local development server at the directory containing the HTML file (and make sure you have `results.json` ready under `data/`). You can do this in terminal by running 

```bash
python -m http.server 8000
```

Keep the terminal window open, and point your web browser to [http://localhost:8000](http://localhost:8000). You should be able to browse, filter, and search your scraped ads in a simple web interface. 

### Initial observations of the dataset

We identified 91 ads with unique URLs from archived web page snapshots of the home pages of the 44 most visited Japanese-language websites by home users in Japan in May 2000. All 91 ads are image-based ads. Among the 91 ads, the distribution of dimensions is as follows: 

```
Width x Height distribution:
224x33: 20
468x60: 26
88x31: 41
120x90: 1
120x60: 3
```

The 88 x 31 banner is the most popular banner format[^14], followed by 468 x 60 and 224 x 33. The popularity of the 224 x 33 format - a format included in the JIAA recommendations but not in the IAB recommendations - demonstrates the importance of adapting web scraping techniques to particular cultural and linguistic contexts. 

Most websites showed ads hosted on their own servers or on servers of advertisers directly. Only three websites (freeweb.ne.jp, justnet.ne.jp, and goo.ne.jp) displayed ads from ad networks (kansas.valueclick.ne.jp and ad.jp.doubleclick.net), which partially corroborate the observation made by Aoki in her study on the tendency of websites to feature their own banner ads. 

Of the 91 ads, we successfully scraped 47 images. Across all recorded appearances, the average time skew is 304.41 days, with a median skew of 108 days. While this range of skew is moderate and does not necessarily suggest that these ads might not have actually appeared on the web pages in the past, it underscores the importance of accounting for temporal discrepancies when analyzing archived web content. For researchers interested in how a web page looked and functioned at a specific moment in time, even small differences in capture dates between page elements can affect interpretations, particularly when examining time-sensitive material like advertisements, news, or dynamic user interfaces.

### Limitations and potential improvements to the scraping code

#### Deduplicating banner ads by file MD5

In our sample dataset, different ads are identified through their original URLs. In larger datasets, it may be worthwhile to compute a hash value (e.g., using MD5) for each downloaded ad image and group ads with identical hash values together. Doing so may reveal additional insights about how banner ads circulated across different websites or ad networks. This can help researchers trace patterns of advertising distribution and content reuse on the early web.

#### Optimizing the download workflow by using the CDX Server API

In our current dataset, each appearance of a banner ad on a different archived web page resolves to the same archived ad image file. This means we are repeatedly downloading the same image file multiple times under different filenames or URLs. A more efficient approach would be to first use the CDX Server API to retrieve a list of all archived snapshots of each ad image URL. We can then select and download only one copy of each unique image, choosing the version whose capture date is closest to each corresponding web page capture. This strategy reduces unnecessary HTTP requests and avoids redundant downloads.

#### Handling meta redirects, JavaScript, and frames

A number of web page snapshots we downloaded contain features that prevented us from scraping banner ad images. 

For example, if you visit the [snapshot of hi-ho.ne.jp](https://web.archive.org/web/20000519230050/http://www.hi-ho.ne.jp/) captured on `20000519230050`, you will be automatically redirected to an [snapshot of home.hi-ho.ne.jp](https://web.archive.org/web/20000520085014/http://home.hi-ho.ne.jp/), although the HTTP response code of the original snapshot is `200` (which does not indicate a redirect). By examining the HTML of the  snapshot, we can see that the page invokes a [meta refresh](https://en.wikipedia.org/wiki/Meta_refresh), where the user is redirected after the original page is loaded. 

In a similar case, a [snapshot of msn.co.jp](https://web.archive.org/web/20000520075751/msn.co.jp) captured on `20000519230050` uses client-side JavaScript to redirect the user to a particular version of its home page based on the user's browser, but the requests library cannot execute the on-page JavaScript, which prevented us from scraping ads appearing on the website. 

In another example, if you load the [archived snapshot of nikkei.co.jp](http://web.archive.org/web/20000511005201/http://www.nikkei.co.jp/) captured on `20000511005201` in your browser, you will see a banner ad at the bottom. However, the downloaded HTML file contain traces of neither the ad nor the main parts of the web page. This particular page is composed of `<frame>` elements, which is a [controversial but popular method](https://en.wikipedia.org/wiki/Frame_(World_Wide_Web)) for building web pages with complex layouts in the 1990s and early 2000s. A `<frame>`-based web page is essentially several web pages stitched together, with each appearing in its own `<frame>`. To retrieve content in `<frame>`s, we must download the web page URL recorded in the `src` attributes of each individual `<frame>`. 

To scrape these web pages properly, you can either adjust the downloading code so that these features can be deteted and dealt with properly, or you can use a browser automation framework like [Selenium](https://www.selenium.dev/) to use real browsers to load and scrape archive web page snapshots. However, these tools generally demand more system resources, and you need to check whether executing archived scripts and redirects introduces temporal inconsistencies to the web pages you are scraping. 

#### Using a database to manage scraping

In our case study, we use the file system to store downloaded snapshot data, data of the extracted banner ad tags, and the relationship between web page snapshots and ad image snapshots. While this allows us to directly view the downloaded data through the file manager, for larger projects this approach can be cumbersome. You may want to consider using a database like [SQLite](https://sqlite.org) to track your scraping.

Using a database provides several significant advantages over managing scraped data through custom folder structures. You can pause and resume scraping operations at any time without manually writing code to check the content already downloaded. A database also provides a unified interface to access all data relationships and metadata without traversing directory hierarchies, and querying and analyzing data can be done using standard SQL syntax. Tools like [DB Browser for SQLite](https://sqlitebrowser.org/) provide intuitive GUI interfaces to inspect and preview your scraped data during the scraping process.

In the course files, we include a brief guide and example notebook ([`sqlite.md`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/scraping-media-archived-web-wayback-machine/sqlite.md) and [`sqlite.ipynb`](https://nbviewer.org/github/programminghistorian/ph-submissions/blob/gh-pages/assets/scraping-media-archived-web-wayback-machine/sqlite.ipynb) that demonstrate implementing a Wayback Machine scraping project with SQLite. 

## Concluding remarks

You now should have a basic technical knowledge of how the Wayback Machine works behind the scene, which is crucial for developing a web archive scraping workflow that takes potential time skew and other technical caveats into consideration. We also saw in the case study how knowledge about past web authoring practices can guide us in scraping web resources, and the importance of adapting our web scraping techniques according to localized web authoring conventions and contexts. 

While we did not find any Flash-based ads in our sample URL dataset, the code provided in the lesson can easily be adapted to scraping all types of media resources on the Wayback Machine. By modifying the BeautifulSoup scraping criteria, you can easily extract archived Flash files, audio clips (e.g., MIDI), embedded video files, or even lesser-known formats like VRML. The same techniques for CDX Server API querying and identifying time skew by observing URL redirects remain applicable across these media types.

## Useful resources

The Python library wayback packages a number of useful CDX Server API features into Python functions: [https://github.com/edgi-govdata-archiving/wayback](https://github.com/edgi-govdata-archiving/wayback)

The Memento Framework is a standardized HTTP-based protocol that adds a “datetime” dimension to content negotiation. Memento support is available in many web archives, including the Wayback Machine. For more information, check out [RFC7089](https://datatracker.ietf.org/doc/html/rfc7089).

HTML reference books published in the late 1990s and early 2000s are incredibly helpful for today’s researchers to understand past web authoring practices. Some of the books are now available to borrow in full-text on the Internet Archive:

- [HTML Pocket Reference, Second Edition](https://archive.org/details/htmlpocketrefere00nied), written by Jennifer Niederst. Published by O'Reilly and Associates.
- [HTML: The Complete Reference, Third Edition](https://archive.org/details/htmlcompleterefe00powe_0/mode/2up), written by Thomas A. Powell. Published by Osborne/McGraw-Hill.


## Endnotes

[^1]: The Wayback Machine originally referred to only the service provided by the Internet Archive for users to browse its archived web content. Today, the term is largely synonymous with the Internet Archive's web archive service, which is also how we will use the term in this lesson. The Internet Archive is but one of the many organizations archiving information on the web worldwide. For a history of web archiving, see Milligan, Ian. Averting the Digital Dark Age: How Archivists, Librarians, and Technologists Built the Web a Memory. 1st ed. Baltimore: Johns Hopkins University Press, 2024.

[^2]: In this lesson, we try to use the same vocabulary to describe web archive concepts as those appearing on the Wayback Machine interface and [RFC7089: HTTP Framework for Time-Based Access to Resource States -- Memento](https://www.rfc-editor.org/rfc/rfc7089.html), although we avoid technical terms involving "memento" to ensure that the lesson could be followed by non-specialists. Note that the Wayback Machine sometimes also use the word "capture" as a noun, in which case it carries the same meaning as a "snapshot". 

[^3]: For more information about technical limitations of web archives, see Brügger, Niels. “Web History and Social Media.” In The SAGE Handbook of Social Media, edited by Jean Burgess, Alice Marwick, and Thomas Poell. 1 Oliver’s Yard, 55 City Road London EC1Y 1SP: SAGE Publications Ltd, 2018. https://doi.org/10.4135/9781473984066. See also Milligan, Ian. History in the Age of Abundance?: How the Web Is Transforming Historical Research. Montreal Kingston London Chicago: McGill-Queen’s University Press, 2019.

[^4]: The term temporal (in)coherence is used more often in technical web archive literature - for example, see Ainsworth, Scott G., Michael L. Nelson, and Herbert Van de Sompel. “A Framework for Evaluation of Composite Memento Temporal Coherence.” arXiv, October 5, 2014. https://doi.org/10.48550/arXiv.1402.0928. In the lesson, we use the term time skew, which is used by [workers at the Internet Archive](https://iawebarchiving.wordpress.com/2010/09/07/wayback-machine-web-archiving-open-thread-september-2010/), and in Ankerson, Megan Sapnar. “Read/Write the Digital Archive: Strategies for Historical Web Research.” In Digital Research Confidential, edited by Eszter Hargittai and Christian Sandvig, 29–54. The MIT Press, 2015. https://doi.org/10.7551/mitpress/9386.003.0004.

[^5]: Ainsworth, Scott G., Michael L. Nelson, and Herbert Van De Sompel. “Only One Out of Five Archived Web Pages Existed as Presented.” In Proceedings of the 26th ACM Conference on Hypertext & Social Media - HT ’15, 257–66. Guzelyurt, Northern Cyprus: ACM Press, 2015. https://doi.org/10.1145/2700171.2791044.

[^6]: There appears to be no consensus on the name of this part of archived snapshot URLs on the Wayback Machine. In this lesson, we call them "request flags," which is a term used in the [release notes](https://web.archive.org/web/20231221054022/https://archive-access.sourceforge.net/projects/wayback/release_notes.html) of the Wayback Machine software developed at the Internet Archive.

[^7]: Powell, Thomas A. “Chapter 5: HTML and Images.” In HTML: The Complete Reference, 3rd Edition. Osborne/McGraw-Hill, 2001.

[^8]: Castro, Elizabeth. “Chapter 17: Multimedia.” In HTML for the World Wide Web, 293–312. Peachpit Press, 2003.

[^9]: For a history of banner ads and the ad network industry, see Crain, Matthew. Profit over Privacy: How Surveillance Advertising Conquered the Internet. University of Minnesota Press, 2021.

[^10]: Huang, Richard Lewei, and Yufeng Zhao. “A Dataset of Late 1990s and Early 2000s Web Banner Ads on Chinese-and English-Language Web Pages.” Journal of Open Humanities Data 10, no. 1 (January 3, 2024). https://doi.org/10.5334/johd.164.

[^11]: Aoki, Kumiko. “Cultural Differences in E-Commerce: A Comparison between the U.S. and Japan.” First Monday 5, no. 11 (November 5, 2000). https://doi.org/10.5210/fm.v5i11.802.

[^12]: Lobato, Ramon, and Julian Thomas. “Formats and Formalization in Internet Advertising.” In Format Matters: Standards, Practices, and Politics in Media Cultures, edited by Marek Jancovic, Axel Volmar, and Alexandra Schneider. Lüneburg: Meson Press, 2020.

[^13]: The JIAA recommended ad dimensions list is adapted from Tada, Kenji. Zukai Intānetto Kōkoku: Jitsumu ni kakasenai kihonteki na chishiki kara, kōka sokutei no saishin jōhō made \[図解インターネット広告：実務にかかせない基本的な知識から、効果測定の最新情報まで\]. Tokyo: Shōeisha, February 15, 2005. The IAB dimensions are from [https://web.archive.org/web/20000311040541/http://www.iab.net/iab_banner_standards/bannersizes.html](https://web.archive.org/web/20000311040541/http://www.iab.net/iab_banner_standards/bannersizes.html)

[^14]: While the 88 x 31 dimension is technically not included in the JIAA recommendations, it is [one of the oldest established dimensions for Internet ads](https://ultrasciencelabs.com/lab-notes/why-we-are-still-using-88x31-buttons), and thus its popularity on the Japanese web is perhaps not surprising. 
