---
title: Scraping Media Resources from Archived Web Pages on the Wayback Machine
slug: scraping-media-archived-web-wayback-machine
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Richard Lewei Huang
- Yufeng Zhao
reviewers:
- Robert St John Smith
- Astrid Van den Bossche
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


## A Table of Contents

{% include toc.html %}

--

## Lesson Introduction

In this lesson, you will learn how to scrape media resources from historical web pages preserved by the Internet Archive’s Wayback Machine.

As historians turn their attention to the 1990s and early 2000s, web archives are becoming increasingly valuable sources for historical research. While many web archives like the Wayback Machine let users view archived pages individually, researchers looking to perform computational or quantitative analysis may prefer accessing archived web content programmatically to bulk-download archived web pages and extract specific page elements for further analysis.

In this lesson, we will access the Wayback Machine programmatically to scrape media resources on archived web pages. In our case study, we will build a small dataset of [banner advertisements](https://en.wikipedia.org/wiki/Web_banner) appearing on home pages of popular Japanese-language websites in the month of May 2000. Such a dataset can be used to study the evolution of web design and advertising practices on the Japanese-language web in the 1990s-early 2000s. The techniques introduced in the lesson are generally comparable to standard web scraping techniques, but we will cover a number of challenges specific to scraping historical web pages archived on the Wayback Machine.

### Prerequisites

This lesson is intended for readers with an intermediate-level understanding of Python and web development. You should already be familiar with basic web scraping techniques using Python and BeautifulSoup, and have some experience working with web APIs. If you are new to Python and HTML, check out Programming Historian lessons on [Python](https://programminghistorian.org/en/lessons/introduction-and-installation) and [HTML](https://programminghistorian.org/en/lessons/viewing-html-files), and subsequent lessons in that series. The online textbook [Introduction to Cultural Analytics and Python](https://melaniewalsh.github.io/Intro-Cultural-Analytics/welcome.html) also offers an excellent [chapter on web scraping](https://melaniewalsh.github.io/Intro-Cultural-Analytics/04-Data-Collection/00-Data-Collection.html) for beginners.

Prior experience with the Wayback Machine will be helpful, though we will review relevant background information in the next section. That said, we recommend all readers review the subsection on "Recomposition of Archived Web Pages and Temporal Coherence" in the next section, as it covers some technical details about how the Wayback Machine serves archived web content that are important for understanding the scraping techniques introduced in this lesson.

While we will be scraping Japanese-language web content, Japanese knowledge is not required. Techniques introduced in the lesson can be easily adapted for content in other languages. 

Each code snippet in the case study part of the lesson is designed to be run in a separate cell in a [Jupyter notebook](https://programminghistorian.org/en/lessons/jupyter-notebooks), and they must be run in order of appearance. If you are not familiar with Jupyter notebooks, consult the Programming Historian lesson [Introduction to Jupyter Notebooks](https://programminghistorian.org/en/lessons/jupyter-notebooks). 

You can follow the lesson on any mainstream operating system. On Python, you will need to have the following libraries installed:

- [Requests](https://requests.readthedocs.io/en/latest/)
- [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/)
- [Tenacity](https://tenacity.readthedocs.io/en/latest/)

The lesson was created and tested on Python 3.10, with Requests 2.32.5, BeautifulSoup 4.11.1, and Tenacity 8.2.3. 

#### A note about Internet connection and code running time

You will need a decent Internet connection for scraping. Depending on your Internet connection speed, the scraping process in this lesson may take at least 15-25 minutes to complete. 

If you encounter connection issues during scraping, you should first check if the Wayback Machine itself is accessible to you by visiting [web.archive.org](https://web.archive.org). If the Wayback Machine itself is experiencing downtime, you should wait until the Wayback Machine is back online before attempting the lesson. You may check the [Wayback Machine's Mastodon account](https://mastodon.archive.org/@internetarchive) and [Downdetector](https://downdetector.com/status/internetarchive/) for official announcements and user reports about the Wayback Machine's status.

If the Wayback Machine is accessible to you but you are still having trouble running the code, you can try restarting your Python kernel for the notebook, switching to a different Internet connection, or using a service like [Cloudflare Warp](https://1.1.1.1/) or another commercial VPN service. 

### Ethical and Legal Concerns in Using Archived Web Data

Before we dive into the technical parts, it is important to consider ethical and legal issues in using web archives for research purposes. Much of the content archived on the Wayback Machine was created by users who could not have anticipated that it would be preserved and analyzed decades later. Some archived web content may have been created by children or other marginal groups, and may contain sensitive personal information. Scraping and reusing such content may cause unintentional harm to individuals whose data is being processed.[^1] In the case study, we will scrape banner ads appearing on the homepages of the most visited websites in Japan, which should entail minimal privacy risk since these ads and websites were designed for public display. 

It is also worth keeping in mind that archived web content was produced within specific cultural and historical contexts that may be difficult to recover if individual elements of the page is taken out of context and placed in a database. When designing your own projects, you should remain mindful of the context in which historical content was created, and strive to minimize potential harms. 

Copyright of archived web materials usually belongs to their original authors, but limited use of copyrighted materials is allowed for research and education purposes in many jurisdictions under Fair Use/Fair Dealing provisions in their copyright laws.[^2] You should always check local laws before reusing or publishing archived material. 

Lastly, large-scale scraping can strain the technical infrastructure of web archives. In the lesson, we will demonstrate how to reduce the potential impact of our scraping by implementing delays and using a Session object in the Requests library. When designing your own scraping projects, you should always strive to minimize your traffic footprint on the archive’s servers.

### Learning Outcomes

By the end of this lesson, you will be able to: 

- Check availability of archived versions of web content programmatically on the Wayback Machine.
- Batch download archived web content. 
- Identify and download embedded media resources on archived web pages.
- Understand Wayback Machine's recomposition process and evaluate temporal coherence of embedded media resources on archived web pages. 
- Understand technical limitations and ethical considerations in Wayback Machine scraping and using archived web content for historical research.

## Web Archiving Basics

Founded in 1996, the Internet Archive’s Wayback Machine is the world’s first web archive, and today it holds over one trillion web pages from around the world, publicly accessible at [web.archive.org](http://web.archive.org).[^3] The Wayback Machine proactively archives the web by running a **web crawler**, which is a program that systematically browses and downloads content on the web for preservation. The Wayback Machine archives all types of content on the web - not only web pages, but also images, PDFs, audio/video files, and so on. 

In the rest of the lesson, we will use the term **resource** to refer to any type of web content identified by a uniform resource locator (URL). We use the verb **capture** to refer to the act of saving a resource for inclusion in a web archive, and a resource that is captured at a particular point in time is referred to as an **archived snapshot** of the original web resource.[^4]

### APIs vs. Research Toolkits

There are different ways to access the Wayback Machine programmatically. In this lesson, we will use the Wayback Machine's [CDX Server API](https://github.com/internetarchive/wayback/tree/master/wayback-cdx-server). CDX stands for Capture Index, the metadata format used by the Wayback Machine to index archived web resources.[^5] The CDX Server API provides the same information accessible through the Wayback Machine's web interface in a tabular, machine-readable format. The Wayback Machine can also be queried through the [Wayback Availability JSON API](https://archive.org/help/wayback_api.php) and the [Memento Protocol API](https://ws-dl.blogspot.com/2013/07/2013-07-15-wayback-machine-upgrades.html), though the CDX Server API offers more types of information and filtering capabilities than the other two APIs. 

For large-scale projects involving hundreds or thousands of URLs, you should consider using Internet Archive’s [Archives Research Compute Hub](https://archive-it.org/arch/), which allows you to perform full-text search and data visualization tasks directly on large-scale web archive datasets hosted on the Internet Archive. However, researchers need to apply with the Internet Archive for access to this service. 

#### A Note about Web Scraping Libraries

In this lesson, we are going to use the [Requests](https://requests.readthedocs.io/en/latest/) library to download archived web content from the Wayback Machine. 

The Requests library is a simple and effective tool for making HTTP requests in Python, and it is apt for the pedagogical purposes in this lesson, but it has many limitations when it comes to processing complex web pages (we will see some of these limitations later on). Researchers interested in scraping complex web pages may want to consider using more powerful tools like [Playwright](https://playwright.dev/) and [Selenium](https://www.selenium.dev/), which can control a real web browser to render and scrape content from complex web pages. However, these tools are also more complicated to configure and use. 

### Recomposition of Archived Web Pages and Temporal Coherence

Web archive scholars have long emphasized that the web page snapshots displayed on the Wayback Machine are not necessarily identical to how pages originally appeared in the past, due to technical complexities in capturing and rendering web content.[^6] While a full discussion of these complexities is beyond the scope of this lesson, it is important to know that media elements embedded on archived web pages may have actually been captured on different dates than the page itself.

A web page consists of an HTML file plus embedded media files - such as images, scripts, and stylesheets - that are referenced in the HTML by their URLs. However, when capturing a web page for preservation, due to technical and network constraints, the Wayback Machine's crawler usually cannot capture all embedded resources on a web page simultaneously with the page itself. Therefore, when a user requests an archived web page snapshot, the Wayback Machine will deliver a "best effort" reconstruction of a web page by rewriting URLs in the archived HTML file so that each embedded resource loads from the closest available archived version on the Wayback Machine, based on the timestamp of the main HTML file. This process is known in web archive scholarship as **recomposition**.[^7] Sometimes, the Wayback Machine has to draw archived snapshots of embedded page resources captured months or even years away from the capture date of the web page itself, creating temporal inconsistencies that may complicate historical interpretation. 

In this lesson, we will learn how to evaluate whether an embedded resource is **temporally coherent** with the recomposed web page snapshot displaying it - that is, whether a user in the past visiting the original web page on the date of capture would likely have encountered the same version of the embedded resource that now appears on the recomposed page snapshot accessed through the Wayback Machine. 

### A Guided Example: The Archived Google Homepage

To better understand how the Wayback Machine serves archived web content, let us look at a real-life example: an archived snapshot of Google's home page, available at [https://web.archive.org/web/20000301105534/http://www.google.com/](https://web.archive.org/web/20000301105534/http://www.google.com/).

#### Anatomy of an Archived Web Snapshot URL

The URL of an archived snapshot of a web resource on the Wayback Machine follows this format:

```
https://web.archive.org/web/[timestamp][optional rewrite modifier]/[original URL]
```

- **Timestamp**: The exact point in time the archived web resource was captured, formatted in `yyyymmddhhmmss`. On the Wayback Machine, the timestamp is recorded in Coordinated Universal Time (UTC).
- **Rewrite modifier**: Controls how content is served from the Wayback Machine's server to the user. This example URL does not contain a rewrite modifier, but we will explain its role shortly.
- **Original URL**: The original URL of the archived web resource.

Therefore, the example URL tells the Wayback Machine to return an archived snapshot of **http://www.google.com** captured on **March 1, 2000, at 10:55:34 UTC**. 

#### URL Rewriting and Redirection

Load the example URL in your browser and use the inspector tool to examine the Google logo (on Chrome and Firefox, this can be done by right clicking the Google logo and clicking Inspect). You should see the following HTML code: 

```html
<img src="/web/20000301105534im_/http://google.com/images/Title_HomPg2.gif" width="600" height="130" border="0" usemap="#map1" alt="Google">
```

As you may have guessed, the Wayback Machine has rewritten the `src` attribute of this `<img>` tag in the original HTML to tell the browser to fetch an archived copy of `Title_HomPg2.gif` captured at **the same timestamp** as the archived web page. But what if no copy of `Title_HomPg2.gif` was captured on that exact point in time?

In that case, the Wayback Machine quietly redirects the request to the **closest available archived version** of that image file. You can observe the redirection by right clicking on the Google logo and open the image in a new browser tab, and you will see the new URL in your browser's address bar: 

```
https://web.archive.org/web/20000407103739im_/http://google.com/images/Title_HomPg2.gif
```

As the new URL indicates, the Google logo image was actually captured on April 7, 2000, which is more than a month after the web page snapshot itself was captured. 

#### Evaluating Temporal Coherence Through Analyzing HTTP Response Headers

Despite the difference in capture dates, this Google logo image captured on April 7, 2000 might have been the same logo that a user would have seen when accessing google.com on March 1, 2000. Is there a way to verify whether an archived media resource appearing on an archived web page snapshot captured at a given date really matches what users in the past would have seen on the page that day? 

Web archive scholars Scott G. Ainsworth, Michael L. Nelson, and Herbert Van de Sompel proposed a method to determine whether an archived on-page resource is *temporally coherent* with the web page it appears on by observing the [`Last-Modified` HTTP response header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Last-Modified) of archived resources.[^7] 

An [HTTP response header](https://developer.mozilla.org/en-US/docs/Glossary/Response_header) is a piece of metadata that a web server sends to a client (a browser, a crawler, or a scraping script) alongside with a web resource, providing contextual information about the resource being served. The `Last-Modified` header indicates the date and time a particular resource was last modified on the server. 

The Wayback Machine logs the `Last-Modified` header it receives when capturing resources from the live web, and it [passes the original](https://ws-dl.blogspot.com/2015/08/2015-08-28-original-header-replay.html) `Last-Modified` header under the name `x-archive-orig-last-modified` in the HTTP response headers of archived snapshots. 

While HTTP headers are normally not visible to users, we can use the command-line tool [curl](https://en.wikipedia.org/wiki/Curl) to get the value of the `x-archive-orig-last-modified` header of the redirected image snapshot. Linux and macOS users can run the following command in your terminal:  

```shell
curl -ksI "https://web.archive.org/web/20000407103739im_/http://google.com/images/Title_HomPg2.gif" | grep -i "x-archive-orig-last-modified"
```

Windows users can run the following command in your PowerShell: 

```powershell
curl.exe -ksI "https://web.archive.org/web/20000407103739im_/http://google.com/images/Title_HomPg2.gif" | Select-String -Pattern "x-archive-orig-last-modified"
```

The returned value should be a timestamp in the [HTTP Date header format](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Date):
```
x-archive-orig-last-modified: Tue, 29 Feb 2000 08:46:01 GMT
```

This header suggests that the image captured on April 7, 2000 was last modified on Google's server on February 29, 2000. Therefore, a user visiting Google on March 1, 2000 would likely have seen the same image as the one captured on April 7, 2000, and thus the image is *prima facie* temporally coherent with the snapshot. 

In addition to the `x-archive-orig-last-modified` header, the Wayback Machine also provides a special header named `memento-datetime` when serving a snapshot, which indicates the capture date of the snapshot. We can use curl again to retrieve the `memento-datetime` header of the Google logo snapshot. Linux and macOS users can run: 

```shell
curl -ksI "https://web.archive.org/web/20000407103739im_/http://google.com/images/Title_HomPg2.gif" | grep -i "memento-datetime"
```

Windows users can run: 

```powershell
curl.exe -ksI "https://web.archive.org/web/20000407103739im_/http://google.com/images/Title_HomPg2.gif" | Select-String -Pattern "memento-datetime"
```

You should see the following output: 

```
memento-datetime: Fri, 07 Apr 2000 10:37:39 GMT
```

The result matches the timestamp (`20000407103739`) in the URL of the archived image snapshot. In the sections to follow, you will learn how to access these headers in Python to calculate temporal coherence. 

#### Rewrite Modifiers

Return to the Google logo URL again:

```
https://web.archive.org/web/20000407103739im_/http://google.com/images/Title_HomPg2.gif
```

The part between the timestamp and the original URL (which is `im_` in the URL) is called a **rewrite modifier**.[^8] It tells the Wayback Machine how to serve the archived content. The `im_` modifier instructs the Wayback Machine to return an image file to be displayed on a web page snapshot. If you [access the snapshot of the Google logo without the modifier](https://web.archive.org/web/20000407103739/http://google.com/images/Title_HomPg2.gif) in your browser, the Wayback Machine will return the image alongside with a toolbar for users to navigate between different snapshots of the URL. 

Usually, rewrite modifiers are added by the Wayback Machine when rewriting URLs during recomposition. When we scrape the Wayback Machine, we can also use them to control how the Wayback Machine returns archived web content. 

In our case study, we will use the `im_` modifier to fetch images and the `id_` modifier to get raw HTML for analysis. 

A list of common rewrite modifiers are listed below for your reference[^9]: 

| Rewrite modifier            | Meaning                        |
| --------------- | ------------------------------- |
| `im_`, `oe_`    | Return most image, audio, and video files for display inside a web page. `oe_` is usually used for legacy embedded media formats like Flash and VRML.      |
| `id_`           | Return an archived HTML, CSS, or JavaScript file as-is, without rewriting internal URLs.     |
| `cs_`, `js_`    | Return a CSS or JavaScript file with internal URLs rewritten.   |
| `if_`, `fw_`    | Used originally by the Wayback Machine for displaying HTML content in `<iframe>` and `<frame>` elements. We can also manually apply either of them to retrieve a recomposed archived web page without the Wayback Machine toolbar showing. |

## Case Study: Building a Dataset of Historical Banner Ads Appearing on Popular Japanese Websites

In the rest of this lesson, we will build a dataset of banner ads appearing on popular Japanese-language websites in the year 2000 by scraping the Wayback Machine.

Banner ads are an early form of web advertising. Widely considered a visual and privacy nuisance, banner ads played an important role in shaping the visual landscape of the early commercial web.[^10]

A dataset of banner ads can be useful for researchers interested in the history of online advertising, visual culture of the early web, and the study of web archiving itself. In 2023, the authors of this lesson published a banner ad dataset containing 22,915 historical banner ads scraped from archived snapshots of more than 77,000 historical URLs.[^11] The dataset can be browsed on [Banner Depot 2000](https://banner-depot-2000.net), a website where visitors can search for banners by keyword, and compose found poetry using individual frames of banner ad images.

In this lesson, we will build a miniature version of that dataset focusing on Japanese-language banner ads. We will accomplish this in the following steps:
 - Getting a list of URLs of web pages to scrape banner ads from.
 - Accessing the Wayback Machine programmatically to check for available archived snapshots of the URLs.
 - Downloading archived web pages from the Wayback Machine.
 - Detecting and downloading banner ads from the downloaded web pages.
 - Evaluating temporal coherence of the downloaded banner ads.
 - Outputting the dataset.  

To follow the lesson, you need to download the lesson files [here](http://example.com/placeholder). You should unzip the downloaded file into a new directory, and create a Jupyter notebook in that directory for running the code snippets. 

Each Python code snippet in this lesson should be run in a separate cell in the Jupyter notebook in the order of appearance. We have also included a Jupyter notebook named `lesson-notebook.ipynb` that contains all code snippets in the lesson. 

### Getting a List of URLs

We will use a list of the top-50 most visited websites by home Internet users in Japan in May 2000 to scrape banner ads. The list was originally published by the Japanese media company Nikkei BP. It is cited and preserved in the appendix of a [2000 study of e-commerce websites in the United States and Japan](https://firstmonday.org/ojs/index.php/fm/article/view/802) by Internet researcher Kumiko Aoki, published on the open-access Internet research journal _First Monday_.[^12] 

For this lesson, we will download the last archived snapshot of each website’s home page captured in May 2000 and extract banner ads from them. A CSV file containing the list of websites is provided in the lesson files under the name `nikkeibp-may2000-abridged.csv`.

In the CSV file, we removed four websites that do not feature mainly Japanese-language content: microsoft.com (ranked #2), msn.com (ranked #9), real.com (ranked #44), and geocities.com (ranked #46). Following the original study and through manual observation of archived snapshots, we also removed nifty.ne.jp (ranked #6) and infoweb.ne.jp (ranked #11), because both redirected to nifty.com (ranked #5) in May 2000. This leaves us with 44 websites to scrape.

The CSV file is formatted as follows:

| rank | url             |
| ---- | --------------- |
| 1    | yahoo.co.jp     |
| 3    | biglobe.ne.jp   |
| 4    | geocities.co.jp |
| ...  | ...             |

### Accessing the Wayback Machine programmatically
#### Using the Wayback Machine CDX Server API

The base URL to access the CDX Server API is:

```
https://web.archive.org/cdx/search/cdx?url=[original URL of a web resource]
```

By default, the API returns all snapshots of the given URL along with their metadata, but you can use query parameters to format and filter the results. A full list of available parameters can be found on the API's [documentation page](https://github.com/internetarchive/wayback/tree/master/wayback-cdx-server) on the GitHub repository of the wayback project, which is the underlying software powering the Wayback Machine.

Let us use the API to fetch a list of snapshots of google.com. The Wayback Machine currently has [more than 18 million snapshots](https://web.archive.org/web/20010101000000*/google.com) archived of google.com. We can add the parameters `from`, `to`, `filter`, and `limit` to make the API return only the last five snapshots captured between May 1 and May 31, 2000 with the HTTP response status code `200` (we will talk about the meanings of HTTP response status codes below):

```
https://web.archive.org/cdx/search/cdx?url=google.com&from=20000501000000&to=20000531235959&filter=statuscode:200&limit=-5
```

You can click the link above to access the results of this request directly in your browser. The returned data is in a tabular format with the columns separated by spaces. Each line represents a snapshot of the URL. The first line looks like this:

```csv
com,google)/ 20000511233532 http://www.google.com:80/ text/html 200 GEXLB6VHTSJANXBP6HPHSZIZAK3KJZCU 1810
```

The default column order is:

```csv
"urlkey","timestamp","original","mimetype","statuscode","digest","length"
```

A detailed explanation of the meanings of the columns is available on the [documentation website](https://support.archive-it.org/hc/en-us/articles/115001790023-Access-Archive-It-s-Wayback-index-with-the-CDX-C-API) of Internet Archive's Archive-It service.[^13] The key columns we will use in this lesson are `timestamp` and `statuscode`.

The `timestamp` identifies the exact point in time a web resource was captured. It is the same timestamp you would see in a Wayback Machine URL. The example line therefore represents a snapshot of [http://google.com](http://www.google.com), captured on May 11, 2000, at 23:35:32 UTC. 

The `statuscode` represents the [HTTP response status code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status) received by the Wayback Machine's crawler from a web server when the crawler attempts to capture a resource from that server. 

HTTP response status codes are three-digit numbers sent by a web server to a client indicating the result of an HTTP request. The status code in the returned CDX data can reveal whether a resource was successfully captured by the crawler (usually indicated by a `200` status code, as in the example above). A `3XX` status code indicates a redirect, and a `4XX`/`5XX` status code generally indicates an unsuccessful request.

These status codes should be distinguished from the **status codes emitted by the CDX Server API**, which we will use later on to determine whether a CDX Server API query is successful; and the **status codes sent by the Wayback Machine's server when we scrape archived web content**, which we will use in conjunction with the HTTP response headers to determine whether the Wayback Machine has an archived snapshot of a web resource available for download, whether a URL is excluded from the Wayback Machine, and whether our scrape request is being temporarily blocked by the Wayback Machine. We will handle these status codes in the following sections. 

#### Dealing with Rate Limiting

The Wayback Machine employs rate limiting to prevent server overload from excessive requests. When you exceed rate limits, the Wayback Machine typically returns an HTTP `429` (Too Many Requests) status code for any request. This applies to requests for both the CDX Server API and archived web resources.[^14]

To avoid being rate-limited and reduce our impact on the Wayback Machine's server, we will add a delay between each request when scraping the Wayback Machine. However, if we still hit rate limits, we can use the Tenacity library to build a [decorator](https://docs.python.org/3/glossary.html#term-decorator) that helps us automatically retry failed requests.

In this lesson, we will use the following decorator in our subsequent code snippets. Add the following code to the first cell of your Jupyter notebook:

```python
import tenacity

retry = tenacity.retry(
    stop=tenacity.stop_after_attempt(12), 
    wait=tenacity.wait_exponential(multiplier=1, min=2, max=64)
)
```

You can apply the decorator by adding `@retry` before any function. The decorator automatically reruns the decorated function after a failure, with exponentially increasing wait times between attempts (starting at 2 seconds and up to 64 seconds). It stops after twelve attempts, then raises an exception. This should help you identify potential issues in your code or network connection.[^15]

#### Batch Querying the CDX Server API

Now, we will loop through the URLs in our list to retrieve a list of available snapshots. First, we read the URLs from the CSV file into a list named `urls_data`: 

```python
import csv
from pathlib import Path

csv_file = "nikkeibp-may2000-abridged.csv"

urls_data = []

with open(csv_file, mode='r', encoding='utf-8') as file:
    reader = csv.DictReader(file)
    urls_data = list(reader)
```

For the purposes of this lesson, we will only scrape the last snapshot of the home page of each website made between May 1, 2000 and May 31, 2000 with an HTTP status code `200` at capture, which indicates successful capture. We can build a simple function `download_cdx_data` to get information about available snapshots for a given `original_url`. 

Since we will make multiple requests to the same host, we use a `requests.Session()` object, which improves efficiency by reusing the underlying TCP connection.[^16]

In the function, we store the API parameters in `params`. A manual two-second delay is added to avoid triggering rate limits. 

The `response.raise_for_status()` line ensures that any HTTP status codes indicating an unsuccessful request (`4XX` and `5XX`) raise exceptions, which can then be handled by the `@retry` decorator we defined earlier. Note that the API returns an empty response with a `200` status code if the Wayback Machine does not have any archived snapshots of the URL requested with the filtering parameters applied. The API will return a `403` status code if a URL is excluded from the Wayback Machine (usually at the site owner's request). While you should not encounter any such URLs in this lesson, we make the `download_cdx_data` function handle this case gracefully by also returning an empty response. 

```python
import time
import requests

@retry
def download_cdx_data(session, original_url): 
    base = "https://web.archive.org/cdx/search/cdx"
    params = {
        "url": original_url,
        "from": 20000501000000,
        "to": 20000531235959,
        "filter": "statuscode:200",
        "limit": "-1"
    }
    response = session.get(base, params=params)
    time.sleep(2)
    print(f"Queried CDX Server API for {original_url}; received status code {response.status_code}")
    if response.status_code == 403:
        print(f"Received 403 for {original_url}. This URL may be excluded from the Wayback Machine. Returning empty response.")
        return ""
    response.raise_for_status()
    return response.text
```

Using the function, we loop through all URLs in `urls_data` to query the CDX Server API, and save the results to `data/urls/[website URL]/cdx.csv`. By creating a separate directory for each URL, we can easily adjust the code to save additional snapshots for each URL in the future if needed. The code also checks for and skips any files already downloaded, so you do not have to restart from the beginning if the process is interrupted. This process should take about 10-15 minutes to finish, depending on your computer’s Internet connection. 

```python
session = requests.Session()

for url in urls_data: 
    cdx_file_path = Path(f"data/urls/{url['url']}/cdx.csv")
    if cdx_file_path.exists():
        print(f"CDX data for {url['url']} already exists at {cdx_file_path}. Skipping.")
        continue

    cdx_data = download_cdx_data(session, url['url'])
    cdx_file_path.parent.mkdir(parents=True, exist_ok=True)
    with open(cdx_file_path, 'w', encoding='utf-8') as cdx_file:
        cdx_file.write(cdx_data)
    print(f"CDX data saved for {url['url']} at {cdx_file_path}")

session.close()
```

You should see a new directory named `data` created in your current directory (the directory where you put the notebook file). The directory structure of `data/` looks like this:

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

### Downloading Archived Web Pages from the Wayback Machine

#### Building a Download Function

Since we will later download banner ad files, and since both images and web pages can be accessed on the Wayback Machine using the same URL pattern, we will first build a download function that can handle both resource types.

In addition to downloading a snapshot, our function should also do the following:
 - Return HTTP response headers. As mentioned earlier, this would help us determine whether a banner ad image is temporally coherent with the web page snapshot containing it. Additionally, we will use the [HTTP header `Content-Type`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Type) to detect the file type of the downloaded content. 
 - Handle legacy character encoding. [Character encoding](https://en.wikipedia.org/wiki/Character_encoding) refers to how textual data is represented on computers. Early non-English web pages often used region-specific encodings that have since been superseded by [UTF-8](https://en.wikipedia.org/wiki/UTF-8), a universal encoding standard. When working with such pages, we often need to detect or specify the correct encoding to read text properly.
 - Handle download errors properly. We need to make sure that our function can throw an error if the download fails, to trigger a retry by the `@retry` decorator. This is a bit tricky, because unlike the CDX Server API, we cannot use HTTP status codes as the sole indicator for download success or failure when scraping archived snapshots from the Wayback Machine. The Wayback Machine currently returns [the same HTTP status code](https://github.com/edgi-govdata-archiving/wayback/issues/158) that its crawler encountered when capturing the original resource; at the same time, the Wayback Machine also returns a `404` status code for URLs with no archived snapshots available, a `403` status code for URLs excluded from the Wayback Machine, and a `429` status code for requests that are temporarily blocked by the Wayback Machine due to rate limits. We need to ensure that our `@retry` decorator only handles erroneous status codes like `429` and `503` (indicating server errors) emitted from the Wayback Machine, while erroneous status codes originating from the archived resource and `403`/`404` codes emitted due to lack of archived snapshots or URL exclusion on the Wayback Machine should be handled gracefully without triggering retry.

Below we define the function: 

```python
@retry
def download_archived_snapshot(session, original_url, timestamp, rewrite_modifier="id_", sleep=1, use_apparent_encoding=True):
    snapshot_url = f"https://web.archive.org/web/{timestamp}{rewrite_modifier}/{original_url}"
    print(f"Fetching archived snapshot for: {snapshot_url}")
    response = session.get(snapshot_url, stream=True) 
    print(f"Received response with status code: {response.status_code}")
    time.sleep(sleep)

    if "memento-datetime" in response.headers: 
        # the presence of the header indicates archived snapshot retrieval successful
        # we don't care about the status code in this case
        content_type = response.headers.get("Content-Type")
        if content_type and content_type.startswith("text"):
            if use_apparent_encoding:
                response.encoding = response.apparent_encoding
            return {
                "status_code": response.status_code,
                "payload": response.text,
                "headers": dict(response.headers)
            }
        else:
            return {
                "status_code": response.status_code,
                "payload": response.content,
                "headers": dict(response.headers)
            }
    else: 
        # missing `memento-datetime` header indicates archived snapshot retrieval unsuccessful
        # we check the status code to determine the reason for failure
        if response.status_code in [403, 404]:
            print(f"Received {response.status_code} for {snapshot_url}. This URL may be excluded from the Wayback Machine or have no archived snapshot available. Returning status code and headers only.")
            return {
                "status_code": response.status_code,
                "payload": None,
                "headers": dict(response.headers)
            }
        else:
            # for other status codes (like 429), raise an exception to trigger retry
            response.raise_for_status()
```

This function downloads an archived snapshot of the `original_url` at the specified `timestamp`. By default, the Requests library will follow redirects, which will allow the Wayback Machine to redirect us to the closest available snapshot of the `original_url` to a given `timestamp`. This replicates the URL redirection behavior on the Wayback Machine. Note that we set `stream=True` to avoid a bug that may be encountered when downloading a specific ad in our case study. This is not strictly necessary for downloading snaphots in general, and you can experiment with removing this parameter to see if it works for you.

The default rewrite modifier `id_` returns an archived HTML file as-is, without rewriting links. We also add a default one-second delay to avoid triggering the rate limits. 

Upon receiving the response, the function first checks for the presence of the `memento-datetime` header to determine whether we have managed to download an archived snapshot of the resource from the Wayback Machine. 

If the header is present, it means the download is _technically_ successful, and we can return the content and headers of the response. If the content is text-based (e.g. an HTML document), the function by default will attempt to [automatically detect its encoding](https://requests.readthedocs.io/en/latest/api/#requests.Response.apparent_encoding) using the Requests library's built-in property `apparent_encoding`. This usually solves encoding issues when processing non-English web pages, but the auto-detection result might not always be correct, and you may need to experiment with different encoding detection mechanisms in your own scraping project. 

The status code in this case comes from the archived snapshot itself, and can be used to evaluate the downloaded content. For example, if we downloaded an image with a status code `404` and with `memento-datetime` header present, it means that the original server reported the file missing at capture time, and likely returned a placeholder image. 

If the `memento-datetime` header is not present, we check whether the URL is excluded from the Wayback Machine (in which case it will emit a `403` status code), or the Wayback Machine has no archived snapshot available of the URL (in which case it will emit a `404` status code). For these cases, we return the status code and the headers only. For other status codes (like `429`), we raise an exception to trigger retry.

#### Downloading Web Page Snapshots

We now download each web page snapshot returned by the CDX Server API to `data/urls/[url]/[timestamp].html`. Since we only requested one snapshot for each URL in the API request, we can just take the first line of the returned CDX data to get the timestamp of the snapshot to download. The entire process may take 5-10 minutes to finish. 

```python
from pathlib import Path
import csv

session = requests.Session()

# find directories under data/urls not containing downloaded HTML files
url_dirs_to_download = [d for d in Path("data/urls").iterdir() if d.is_dir() and not any(f.suffix == ".html" for f in d.iterdir())]

for url_dir in url_dirs_to_download:
    cdx_file = url_dir / "cdx.csv"
    with open(cdx_file, 'r', encoding='utf-8') as file:
        reader = csv.reader(file, delimiter=' ')
        rows = list(reader)
        if len(rows) == 0:
            print(f"No snapshot found in {cdx_file}. Skipping.")
            continue
        # since we requested one snapshot for each URL, we can just take the first row
        first_row = rows[0]
        if first_row:
            url, timestamp = first_row[2], first_row[1]
            html_download = download_archived_snapshot(session, original_url=url, timestamp=timestamp)
            html_content = html_download['payload']
            html_file_path = cdx_file.parent / f"{timestamp}.html"
            with open(html_file_path, 'w', encoding='utf-8') as html_file:
                html_file.write(html_content)
            print(f"{url} @ {timestamp} saved to {html_file_path}")

session.close()
```

In the code, we loop through each directory under `data/urls/` that does not yet contain an HTML file and download the corresponding snapshot. We read the `cdx.csv` file under each of these directories to download the snapshot according to the file. Once the download finishes, your `data` directory structure should look like this:

```bash
- data/
  - urls/
    - 3web.ne.jp/
      - 20000520054559.html
      - cdx.csv
    - asahi-net.or.jp/
      - 20000520065032.html
      - cdx.csv
    - ...
```

In total, you should have downloaded 41 HTML files. Three URLs (sakura.ne.jp, dti.ne.jp, and isize.com) had no snapshots from May 2000. 

### Detecting Banner Ads by Dimension

After downloading the web page snapshots, we can start identifying banner ads within them. In this lesson, we use image dimensions as a proxy for banner ads.

In the 1990s and early 2000s, it was a common practice among web developers to specify `height` and `width` attributes in `<img>` elements to allow browsers to render web page layouts before the images fully loaded.[^17] Around the same time, advertisers and ad networks began standardizing banner ad dimensions.[^18] In the United States, this effort was spearheaded by the [Internet Advertising Bureau (today Interactive Advertising Bureau)](https://web.archive.org/web/19980211031202/http://www.iab.net/advertise/content/adstandards.html) beginning in 1996. In Japan, a similar standardization effort was started by the [Japan Internet Advertising Association (JIAA)](https://web.archive.org/web/20010218112916/http://www.jiaa.org/act/contents99_2.html) in the late 1990s. The JIAA has been releasing its own banner ad dimension recommendations, with some dimensions not included in the IAB recommendations. 

The convergence of these two practices enables us to identify banner ads programmatically by looking for `<img>` tags fitting one of the known banner ad dimensions. In the lesson files, there is a CSV file of recommended banner dimensions from both IAB and JIAA named `banner-ad-dimensions.csv`.[^19] The CSV file looks like this:

| width | height | iab_name        | jiaa_name     | jiaa_name_ja         |
| ----- | ------ | --------------- | ------------- | -------------------- |
| 88    | 31     | Micro Button    |               |                      |
| 120   | 240    | Vertical Banner |               |                      |
| 120   | 90     | Button 1        | Regular Badge | レギュラーバッジ        |
| ...   | ...    | ...             | ...           | ...                  |

In the following code, we will define a function named `extract_ad_tags` that will find all `<img>` tags in a given HTML file fitting one of the known banner ad dimensions. We also define an additional function named `ensure_absolute_url`. This function converts relative URLs sometimes found in `src` attributes of `<img>` tags into absolute URLs, which would aid us when downloading the ad image files. 

For each tag, we scrape the following information: 
 - original ad image file URL in the `src` attribute. 
 - the URL that the ad is linked to, found in the `href` attribute of its parent `<a>` element. The values in the `href` attributes might be useful for historians looking to collect web pages that banner ads pointed to. 
 - its [alt text](https://en.wikipedia.org/wiki/Alt_attribute) in the `alt` attribute. 

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
    base_url = f'http://{base_url}' if not base_url.startswith('http://') else base_url
    if not (urlparse(src).netloc):
        # If src is relative, make it absolute using the base URL
        src = urljoin(base_url, src)
    elif src.startswith('//'):
        # If src is protocol-relative, add the HTTP scheme
        src = f"http:{src}"
    return src

def extract_ad_tags(html_content, html_base_url, banner_dimensions):
    soup = BeautifulSoup(html_content, 'html.parser')
    img_tags = soup.find_all('img')
    
    extracted_ads = []

    for img in img_tags:
        w = img.get('width')
        h = img.get('height')
        try:
            width = int(w)
            height = int(h)
        except (TypeError, ValueError):
            continue  # skip non-numeric or missing dimensions

        for banner in banner_dimensions:
            if (width == int(banner['width']) and height == int(banner['height'])):
                src = img.get('src')
                src = ensure_absolute_url(src, html_base_url)
                ad_href = img.parent.get('href') if img.parent and img.parent.name == 'a' else None
                if ad_href:
                    ad_href = ensure_absolute_url(ad_href, html_base_url)
                alt = img.get('alt', '')
                extracted_ads.append({
                    'src': src,
                    'width': width,
                    'height': height,
                    'ad_href': ad_href,
                    'alt': alt
                })
                break  # stop checking once a match is found

    return extracted_ads
```

We can now use these functions to parse all downloaded HTML files. In the code below, we loop through all downloaded HTML files and analyze each file with the `extract_ad_tags` function. Information about each ad is added into the list `all_extracted_ad_tags`. We also add a unique numerical identifier to each detected tag, which will aid us when we download the image files.

```python
# Walk through the data directory and process each HTML file
html_files = Path("data/urls/").glob("*/*.html")

all_extracted_ad_tags = []

for html_file in html_files:
    timestamp = html_file.stem
    base_url = html_file.parent.name 
    print(f"Processing HTML file: {html_file} with timestamp: {timestamp}")
    # read the HTML content
    with open(html_file, 'r', encoding='utf-8') as file:
        html_content = file.read()
    extracted_ad_tags = extract_ad_tags(html_content, base_url, banner_dimensions)
    for ad in extracted_ad_tags:
        ad['web_page_snapshot_timestamp'] = timestamp
        ad['web_page_original_url'] = base_url
    all_extracted_ad_tags.extend(extracted_ad_tags)

# Add a unique identifier to each ad tag
for idx, ad in enumerate(all_extracted_ad_tags):
    ad['id'] = idx + 1
```

This process should only take a few seconds to finish. After running the code, you should have a list of dictionaries in `all_extracted_ad_tags`, with each dictionary containing information about a detected banner ad. If you want to, you can print out an item from the list:

```python
from pprint import pprint
pprint(all_extracted_ad_tags[0])
```

The output should look like this (note that you may not see the same ad as the one below): 
```python
{'ad_href': 'http://www.freecom.ne.jp/',
 'alt': 'freecom',
 'height': 60,
 'id': 1,
 'src': 'http://freeweb.ne.jp/img/comfree.gif',
 'web_page_original_url': 'freeweb.ne.jp',
 'web_page_snapshot_timestamp': '20000519230330',
 'width': 468}
```

### Downloading Archived Snapshots of Banner Ad Images

We will use the `download_archived_snapshot` function to download archived banner ad image files and evaluate their temporal coherence. 

First, we define a function for evaluating temporal coherence. The function compares the image capture date (in `memento-datetime` header), the image `Last-Modified` date, and the web page snapshot's timestamp to evaluate whether an image is temporally coherent with the web page snapshot. In the lesson, we will implement a simplified heuristic based on the Ainsworth et al. paper[^7]: 

| Comparison of dates                                          | Coherence evaluation result |
| -------------------------------------------------------------|-----------------------------|
| Image `Last-Modified` <= Web page snapshot timestamp <= Image capture date | Prima facie coherent |  
| Web page snapshot timestamp < Image `Last-Modified` < Image capture date | Prima facie violative |
| Image `Last-Modified` < Image capture date < web page snapshot timestamp| Possibly coherent |  
| No `Last-Modified` header (usually happens for images served from ad networks, as the networks usually serve a new ad each time the web page loads) | Probably violative |

Below we implement the heuristic:  

```python
from datetime import datetime

def calculate_coherence(image_capture_date, image_last_modified_date, web_page_snapshot_timestamp):
    if not image_last_modified_date:
        return "Probably Violative"
    try:
        image_capture_dt = datetime.strptime(image_capture_date, '%a, %d %b %Y %H:%M:%S %Z')
        image_last_modified_dt = datetime.strptime(image_last_modified_date, '%a, %d %b %Y %H:%M:%S %Z')
        web_page_snapshot_dt = datetime.strptime(web_page_snapshot_timestamp, '%Y%m%d%H%M%S')
    except ValueError as e:
        raise ValueError(f"Date parsing error: {e}")

    if image_last_modified_dt <= web_page_snapshot_dt <= image_capture_dt:
        return "Prima Facie Coherent"
    elif web_page_snapshot_dt < image_last_modified_dt < image_capture_dt:
        return "Prima Facie Violative"
    elif image_last_modified_dt < image_capture_dt < web_page_snapshot_dt:
        return "Possibly Coherent"
```

Now we can download the archived image file for each ad detected and calculate its temporal coherence. The image download process should take 5-10 minutes to finish, depending on your computer's Internet connection. 

The code below loops through each ad tag stored in `all_extracted_ad_tags` and tries to download the corresponding image snapshot and store its metadata. If the image tag has not been processed yet, the script calls the `download_archived_snapshot` function. The rewrite modifier `im_` tells the Wayback Machine to return the image exactly as it was archived. At the same time, the script sets up a dictionary called `image_data_output` to store useful metadata about the image. 

When a download is successful - that is, the server returns a `200` status code and the `Content-Type` header shows the file is an image - the script determines the correct file extension (such as `.gif`, `.jpg`, or `.png`) from the header and saves the file in `data/images/[ad tag id]/image.[ad file extension]`. After saving the file, it calculates whether the image is temporally coherent with the web page snapshot using the `calculate_coherence` function. The results are then stored in `image_data_output`.

If the download fails, the script still records the HTTP headers in `image_data_output` but does not save an image file. A failure might mean the Wayback Machine has not archived the ad, the ad is excluded from the Wayback Machine, or the server misleadingly reports success (HTTP 200 status code) while serving a non-image file such as an error page (sometimes called a “soft 404” [^20]). 

Finally, the script writes the `image_data_output` dictionary into a JSON file named `image-data.json` stored in `data/images/[ad id]/`. 

```python
import json

session = requests.Session()

for img_tag in all_extracted_ad_tags:
    id = img_tag.get('id')
    # check if the image has already been downloaded
    image_dir = Path(f"data/images/{id}/")
    image_data_path = image_dir / "image-data.json"
    
    if image_data_path.exists():
        print(f"Image data for ad ID {id} already exists at {image_data_path}.")
        continue

    src = img_tag['src']
    web_page_snapshot_timestamp = img_tag['web_page_snapshot_timestamp']

    download_image = download_archived_snapshot(session, src, web_page_snapshot_timestamp, rewrite_modifier="im_")

    headers = download_image["headers"]
    status_code = download_image["status_code"]
    content_type = headers.get("Content-Type", "")

    image_data_output = {
        "id": id,
        "image_src": src,
        "web_page_snapshot_timestamp": web_page_snapshot_timestamp,
        "web_page_original_url": img_tag.get('web_page_original_url'),
        "width": img_tag.get('width'),
        "height": img_tag.get('height'),
        "image_href": img_tag.get('ad_href'),
        "image_alt_text": img_tag.get('alt'),
        "image_snapshot_timestamp": None,
        "image_last_modified": None,
        "image_filetype": None,
        "status_code": status_code,
        "headers": headers,
        "coherence": None
    }
    
    if status_code == 200 and content_type.startswith("image"):
        image_filetype = content_type.split("/", 1)[-1] # this approach may not work for other file types
        image_file_path = image_dir / f"image.{image_filetype}"
        image_file_path.parent.mkdir(parents=True, exist_ok=True)

        image_data_output["image_filetype"] = image_filetype

        with open(image_file_path, "wb") as image_file:
            image_file.write(download_image["payload"])
        print(f"Image {id} downloaded and saved at {image_file_path}")

        # Retrieve headers for temporal coherence
        image_last_modified = headers.get("x-archive-orig-last-modified")
        image_capture_date = headers.get("memento-datetime")
        image_data_output["coherence"] = calculate_coherence(
            image_capture_date, image_last_modified, web_page_snapshot_timestamp
        )

        # Record parsed timestamps and filetype in yyyymmddhhmmss
        if image_capture_date:
            image_data_output["image_snapshot_timestamp"] = datetime.strptime(
                image_capture_date, "%a, %d %b %Y %H:%M:%S %Z"
            ).strftime("%Y%m%d%H%M%S")
        if image_last_modified:
            image_data_output["image_last_modified"] = datetime.strptime(
                image_last_modified, "%a, %d %b %Y %H:%M:%S %Z"
            ).strftime("%Y%m%d%H%M%S")
    else:
        print(f"Skipped ad ID {id}: status={status_code}, type={content_type!r}")

    # Save metadata regardless of download success
    image_data_path.parent.mkdir(parents=True, exist_ok=True)
    with open(image_data_path, "w", encoding="utf-8") as image_data_file:
        json.dump(image_data_output, image_data_file, ensure_ascii=False, indent=4)

session.close()
```

### Observations of the Downloaded Data

After the download process finishes, you will be able to find the images in the directory `data/images`. We can now consolidate all the `image-data.json` files we accumulated to gain aggregated insight into our dataset: 

```python
# consolidate the downloaded image data into a single JSON file
all_image_data = []
image_data_files = Path("data/images/").glob("*/image-data.json")
for image_data_file in image_data_files:
    with open(image_data_file, 'r', encoding='utf-8') as file:
        image_data = json.load(file)
        all_image_data.append(image_data)

# save consolidated image data to a single JSON file
with open('data/all_image_data.json', 'w', encoding='utf-8') as file:
    json.dump(all_image_data, file, ensure_ascii=False, indent=4)
```

The resulting aggregated JSON file can be found at `data/all_image_data.json`. Each object in the JSON file represents one detected `<img>` tag scraped from the downloaded HTML files fitting known ad dimensions, along with information about the snapshot of the ad image appearing on the recomposed web page snapshot from which the tag is scraped. 

In the lesson files, we included an HTML file named `banner-ad-explorer.html` that can display the content of the JSON file in a gallery format. To use the HTML file, open your terminal and switch to your current directory (the directory containing your notebook and the HTML file). Run the following command: 

```bash
python3 -m http.server 8000
```

Keep the terminal window open, and point your web browser to [http://localhost:8000/banner-ad-explorer.html](http://localhost:8000/banner-ad-explorer.html). The web page should display aggregated statistics about the scraped ads and the ad images themselves in a gallery format. 

We found 42 `<img>` tags matching known banner ad dimensions across 41 downloaded web page snapshots. The most common formats are 88 x 31 (25 ads), 468 x 60 (7 ads) and 224 x 33 pixels (6 ads). The popularity of the 224 x 33 format - a format included in the JIAA recommendations but not in the IAB recommendations - demonstrates the importance of adapting web scraping techniques to particular cultural and linguistic contexts. 

Most websites displayed ads hosted on their own domains or those of affiliated companies (e.g. biglobe.ne.jp showed an ad hosted on cplaza.ne.jp; both websites were owned by the company NEC; geocities.co.jp showed an ad hosted on Yahoo, which owned GeoCities). Only one website (goo.ne.jp) displayed ads from an external ad network (ad.jp.doubleclick.net), partially corroborating Aoki’s observation that Japanese websites of this period tended to display in-house ads.[^12] 

We were able to download archived snapshots of ad images for 32 out of all 42 detected image tags, but only 14 downloaded images are temporally coherent with the web page snapshots they appear on. The low temporal coherence rate demonstrates the need for researchers to take a more critical approach when interpreting recomposed archived web pages accessed via the Wayback Machine. Note that though we technically managed to download two out of the three ad images hosted on ad.jp.doubleclick.net, the two images were both 1 x 1 GIFs. Given the large difference between the images' capture date and the web page snapshots' capture date, the two images are likely placeholders served by the ad network for inactive ads. 

If your downloaded ad count does not match the results shown above, you should check the output of your code cells for potential download errors caused by network issues. It may also be possible that a website owner has requested the Wayback Machine to exclude archives of their site from public access after the lesson is published, in which case you may not be able to download the same number of ads as we did when we developed and tested the code. The lesson will be updated periodically to reflect such changes. 

### Limitations and Potential Improvements to the Scraping Code

#### Handling Redirects, JavaScript, and Frames

Some archived web pages we scraped included features that prevented us from scraping banner ads. For instance, the [snapshot of nikkeibp.co.jp](https://web.archive.org/web/20000528235554/nikkeibp.co.jp) from `20000528235554` uses a [meta refresh](https://en.wikipedia.org/wiki/Meta_refresh) to redirect users to another web page, while the [snapshot of msn.co.jp](https://web.archive.org/web/20000520075751/msn.co.jp) from `20000520075751` relies on client-side JavaScript for redirection - both redirection mechanisms cannot be detected by our scraper. Similarly, the [snapshot of tcup.com](https://web.archive.org/web/20000511234036/http://www.tcup.com/) from `20000511234036` is a web page containing `<frame>` elements, which was a [controversial web design technique](https://en.wikipedia.org/wiki/Frame_(World_Wide_Web)) popular in that era. To detect ads appearing on this web page, we would need to scrape each `<frame>` through the URL in its `src` attribute.

To better handle such cases, consider using a browser automation framework like [Selenium](https://www.selenium.dev/). However, these tools generally require more system resources and technical knowledge, and you should check whether following redirects or executing on-page redirects may introduce temporal inconsistencies. 

#### Detecting and Scraping Non-Image Media Formats from the Late 1990s and Early 2000s

We scraped only image-based ads in our lesson. However, web users in the 1990s and early 2000s may remember that many ads from that era were made using [Flash](https://en.wikipedia.org/wiki/Adobe_Flash), a proprietary web media format. By modifying the BeautifulSoup scraping criteria, you can easily scrape a wide range of media formats on the Wayback Machine, including Flash. The same techniques for CDX Server API querying and evaluating temporal coherence remain generally applicable across different media formats. 

In the late 1990s and early 2000s, two HTML tags were commonly used to embed non-image media: `<embed>` and `<object>`. These tags can be used to embed audio and video clips (e.g. MIDI, QuickTime, RealMedia, Windows Media), Flash/Shockwave content, Java applets, [VRML](https://en.wikipedia.org/wiki/VRML) worlds, PDF documents, and other plugin-based interactive media. 

During the [1990s browser wars](https://en.wikipedia.org/wiki/Browser_wars#First_browser_war_(1995%E2%80%932001)), `<embed>` was preferred by Netscape, while Microsoft and later W3C pushed the `<object>` tag as the standard container for web media. As a result, many web pages included both tags for cross-browser compatibility.[^21] The following is a [real-life example](https://web.archive.org/web/20010531235413id_/http://www.real.com/) illustrating how `<object>` and `<embed>` tags were often used together to load Flash content:

```html
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="523" height="223">
<param name="movie" value="http://images.real.com/pics/flash/star_big_us2985.swf">
<param name="play" value="true">
<param name="loop" value="false">
<param name="quality" value="best">
<embed src="http://images.real.com/pics/flash/star_big_us2985.swf" type="application/x-shockwave-flash" width="523" height="223" play="true" loop="false" quality="best" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" <="" embed=""></object>
```

In this example, the URL of the Flash movie appears in both the `<param name="movie">` tag under the parent `<object>` tag and the `src` attribute on the nested `<embed>` tag. During recomposition, the Wayback Machine will typically rewrite URLs of embedded media files with the `oe_` rewrite modifier, which you should also use when downloading these files. 

Keep in mind that many older media formats require emulation or specialized legacy software for playback on modern computers. The digital preservation activist organization ArchiveTeam maintains a [wiki of file formats](http://justsolve.archiveteam.org/wiki/Main_Page) that you may find useful for identifying obsolete or arcane file formats.

#### Deduplicating with Image File Hash and Using a Database to Manage Scraping

In our lesson, we only scraped one snapshot each for 44 historical URLs to look for banner ads. If we are scraping banner ads from a larger set of historical URLs, chances are you will encounter identical ads appearing on different web page snapshots across time. To reduce redundancy and obtain additional insights about how banner ads circulated across different websites or ad networks, you can calculate a unique [hash (such as MD5 or SHA1)](https://en.wikipedia.org/wiki/Hash_function) for each ad image as its ID. This would allow you to group, count, or map each image's occurrences across multiple pages and time periods.

Larger-scale scraping projects may also benefit from using a database like SQLite to manage scraping. Using a database can make it easier to track the scraping process and enable quicker and more complex queries of the scraped data. By using a database, you can create a more scalable and efficient workflow for large-scale projects.

## Concluding Remarks

You should now have a basic understanding of how the Wayback Machine works behind the scenes, which is crucial for developing a web archive scraping workflow that takes temporal coherence and other technical caveats into consideration. We also saw in the case study how knowledge about past web authoring practices can guide us in scraping web resources, and the importance of adapting our web scraping techniques according to localized web authoring conventions and contexts. 

Scraping archived web content is usually a process full of exceptions, surprises, and edge cases. As you develop your own workflows, it is important to balance efficiency with care: decide which trade-offs are acceptable for your research goals, design your scraping in ways that minimize unnecessary strain on the archive’s servers, and remain mindful of the ethical and legal implications of reusing and publishing archived materials.  

## Useful Resources

The [Python library wayback](https://github.com/edgi-govdata-archiving/wayback) packages a number of useful CDX Server API features into Python functions, which you can easily use in your own scraping projects.

The Memento Framework is a standardized HTTP-based protocol that adds a "datetime" dimension for serving web content. It also provides a technical vocabulary for web archive concepts. Memento support is available in many web archives, including the Wayback Machine. For more information, check out [RFC7089](https://datatracker.ietf.org/doc/html/rfc7089).

HTML reference books published in the late 1990s and early 2000s are incredibly helpful for understanding past web authoring practices. Many of these books are available to borrow in full text [on the Internet Archive](https://archive.org/search?query=subject%3A%22HTML+%28Document+markup+language%29%22). 

## Endnotes

[^1]: On ethical issues in using web archives for historical research, see Jimmy Lin, Ian Milligan, Douglas W. Oard, Nick Ruest, and Katie Shilton. "We could, but should we? Ethical considerations for providing access to GeoCities and other historical digital collections." In Proceedings of the 2020 Conference on Human Information Interaction and Retrieval, pp. 135-144. 2020. 

[^2]: For a collection of fair use/fair dealing laws around the globe, see Jonathan Band and Jonathan Gerafi. “THE FAIR USE/FAIR DEALING HANDBOOK.” Joint PIJIP/TLS Research Paper Series, November 1, 2024. https://digitalcommons.wcl.american.edu/research/141.

[^3]: The term "Wayback Machine" originally referred to the Internet Archive’s browsing service for its web archives. Today, the term is largely synonymous with the Internet Archive's web archive service itself, which is also how we will use the term in this lesson. The Internet Archive is one of the many organizations archiving the web. For a history of web archiving, see Ian Milligan, Averting the Digital Dark Age: How Archivists, Librarians, and Technologists Built the Web a Memory, 1st ed. (Baltimore: Johns Hopkins University Press, 2024).

[^4]: In this lesson, we follow the terminology on the Wayback Machine's interface to describe web archive concepts. The Wayback Machine sometimes uses the word "capture" as a noun, which is equivalent in meaning to "snapshot". For a more rigorous terminology of web archive concepts, see [RFC7089: HTTP Framework for Time-Based Access to Resource States -- Memento](https://www.rfc-editor.org/rfc/rfc7089.html).

[^5]: Sawood Alam and Mark Graham, “CDX Summary: Web Archival Collection Insights,” in Linking Theory and Practice of Digital Libraries: 26th International Conference on Theory and Practice of Digital Libraries (TPDL 2022), Padua, Italy, September 20–23, 2022, Proceedings (Cham: Springer-Verlag, 2022), 297–305, https://doi.org/10.1007/978-3-031-16802-4_25

[^6]: On technical limitations of web archives, see Niels Brügger, “Web History and Social Media,” in The SAGE Handbook of Social Media, ed. Jean Burgess, Alice Marwick, and Thomas Poell (London: SAGE, 2018), https://doi.org/10.4135/9781473984066; and Ian Milligan, History in the Age of Abundance?: How the Web Is Transforming Historical Research (Montreal; Kingston; London; Chicago: McGill-Queen’s University Press, 2019).

[^7]: Scott G. Ainsworth, Michael L. Nelson, and Herbert Van de Sompel, “A Framework for Evaluation of Composite Memento Temporal Coherence,” arXiv, October 5, 2014, https://doi.org/10.48550/arXiv.1402.0928. 

[^8]: The term "rewrite modifier" is taken from John Berlin, Mat Kelly, Michael L. Nelson, and Michele C. Weigle. "To re-experience the Web: a framework for the transformation and replay of archived Web pages." ACM Transactions on the Web 17, no. 4 (2023): 1-49. 

[^9]: See [pywb project documentation](https://pywb.readthedocs.io/en/latest/manual/rewriter.html) for a list of rewrite modifiers and their uses. pywb is the successor of the Wayback/OpenWayback software powering the Wayback Machine, but the information generally applies to the Wayback Machine as well. 

[^10]: For a history of banner ads and the ad network industry, see Matthew Crain, Profit over Privacy: How Surveillance Advertising Conquered the Internet (Minneapolis: University of Minnesota Press, 2021); and Robert W. Gehl “Standardizing Social Media: Technical Standards, the Interactive Advertising Bureau, and the Rise of Social Media Templates.” In Reverse Engineering Social Media: Software, Culture, and Political Economy in New Media Capitalism, 92–116. Temple University Press, 2014. 

[^11]: Richard Lewei Huang and Yufeng Zhao, “A Dataset of Late 1990s and Early 2000s Web Banner Ads on Chinese- and English-Language Web Pages,” Journal of Open Humanities Data 10, no. 1 (January 3, 2024), https://doi.org/10.5334/johd.164.

[^12]: Kumiko Aoki, “Cultural Differences in E-Commerce: A Comparison between the U.S. and Japan,” First Monday 5, no. 11 (November 5, 2000), https://doi.org/10.5210/fm.v5i11.802.

[^13]: The documentation is technically for Internet Archive's Archive-It service, but the information generally applies to the Wayback Machine as well. 

[^14]: The Wayback Machine's rate-limit thresholds are current not public, though there is a [GitHub issue](https://github.com/edgi-govdata-archiving/wayback/issues/137#issuecomment-1845803523) citing Internet Archive employees confirming the existence of rate limiting measures. Per the issue, the request frequency for the CDX Server API should be under 48 requests/min, and the request frequency for the main web archive should be under 480 requests/min. In the lesson, our request frequency is well below these thresholds.

[^15]: The parameters of the `@retry` decorator are set according to our experience when developing the lesson. You may need to adjust the parameters according to your own needs and the Wayback Machine's current rate-limiting measures. For more information, see [the Tenacity documentation](https://tenacity.readthedocs.io/en/latest/).

[^16]: For more information about sessions in Requests, see [the Requests documentation](https://requests.readthedocs.io/en/latest/user/advanced/#session-objects).

[^17]: Thomas A. Powell, “Chapter 5: HTML and Images,” in HTML: The Complete Reference, 3rd ed. (New York: Osborne/McGraw-Hill, 2001), 184.

[^18]: Ramon Lobato and Julian Thomas, “Formats and Formalization in Internet Advertising,” in Format Matters: Standards, Practices, and Politics in Media Cultures, ed. Marek Jancovic, Axel Volmar, and Alexandra Schneider (Lüneburg: meson press, 2020).

[^19]: The JIAA recommended ad dimensions list is adapted from Kenji Tada, Zukai Intānetto Kōkoku: Jitsumu ni kakasenai kihonteki na chishiki kara, kōka sokutei no saishin jōhō made [図解インターネット広告：実務にかかせない基本的な知識から、効果測定の最新情報まで] (Tokyo: Shōeisha, February 15, 2005). The IAB dimensions are from [https://web.archive.org/web/20000311040541/http://www.iab.net/iab_banner_standards/bannersizes.html](https://web.archive.org/web/20000311040541/http://www.iab.net/iab_banner_standards/bannersizes.html)

[^20]: Luis Meneses, Richard Furuta, and Frank Shipman. "Identifying “Soft 404” error pages: analyzing the lexical signatures of documents in distributed collections." In International Conference on Theory and Practice of Digital Libraries, pp. 197-208. Berlin, Heidelberg: Springer Berlin Heidelberg, 2012.

[^21]: Elizabeth Castro, “Chapter 17: Multimedia,” in HTML for the World Wide Web (Berkeley: Peachpit Press, 2003), 293–312.