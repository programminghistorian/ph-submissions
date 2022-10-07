---
title: "Scraping the UK Web Archive with Boilerpipe"
collection: lessons
layout: lesson
slug: scraping-the-uk-web-archive-with-boilerpipe
date: 2022-MM-DD
authors:
- Caio Mello
- Martin Steer
reviewers:
- Forename Surname
- Forename Surname
editor:
- Liz Fischer
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/514
difficulty: TBC
activity: TBC
topics: [TBC]
abstract: This lesson will teach you how to collect and build a corpus of news articles stored by the UK Web Archive (UKWA). The tutorial will focus on how to use SHINE search engine, a UKWA web interface, to download a list of URLs, how to extract the pages' text using Boilerpipe (a Python library for web scraping), how to clean the results (deduplicate and filter only the relevant texts for analysis) and finally how to store and manage the resulting text corpus adequately.
doi: TBC
---

{% include toc.html %}


### Lesson Goals

This lesson aims to teach you how to create a corpus containing articles from websites archived by the UK Web Archive. The objective is constructing a dataset that can be used to study the web of the past as a historical source. For this particular lesson, we use as a case-study the news media coverage of 2012 London's Olympic legacy. The method however can be applied to many different case studies and using the UK Web Archive as our source works particularly well for the study of the British press.

By the end of the lesson, you will be able to:

- Understand and estimate the value and cost of creating useful data sets.
- Find relevant (open access) content for research in the UK Web Archive using SHINE.
- Use Boilerpipe in a Jupyter Notebook to extract texts from URLs.
- Clean, filter and manage the data acquired from web archives.
- Understand the errors and data inconsistencies encountered and some examples of pragmatic solutions to these common problems

### Prerequisites

The setup, usage and reproduction steps below all assume that you have a terminal emulator, such as Terminal (macOS), Terminator (Linux) or PuTTY (Windows), installed on your computer, a basic knowledge of the command line and are familiar with using Jupyter notebooks.

The Programming Historian prerequisite lessons are:

* Ian Milligan and James Baker, "Introduction to the Bash Command Line," *Programming Historian* 3 (2014), https://doi.org/10.46430/phen0037.
* Quinn Dombrowski, Tassie Gniady, and David Kloster, "Introduction to Jupyter Notebooks," *Programming Historian* 8 (2019), https://doi.org/10.46430/phen0087.

The lesson also requires the following software pre-installed on your computer:

| Requirement                                      | Version used by the project |
| :----------------------------------------------- | --------------------------: |
| [Python 3](https://www.python.org/)              |                       3.9.8 |
| Jupyter lab                                      |                       XXXXX |
| [Pandas](https://pandas.pydata.org/)             |                       1.4.2 |
| [boilerpy3](https://pypi.org/project/boilerpy3/) |                       1.0.6 |


To maintain consistent development environment across different computers, we used [Pyenv](https://github.com/pyenv/pyenv) to manage Python version, and [Pipenv](https://pipenv.pypa.io/en/latest/) to create a virtual enviroment provisioned with specific versions of Python dependencies. This repository includes `.python-version` and `Pipfile` files which can be used to reproduce the virtual enviroment we used in this project (see [Reproduction Steps](#reproduction-steps) below).

<br />

## Case study: The media coverage of London 2012 Olympics legacy.

Olympic legacy is an interesting and challenging case study because it refers to a specific discussion around the broad topic ‘Olympics’. Every four years, a different city around the world is chosen to host the Summer Olympic and Paralympic Games. As soon as the host city is chosen, international and local press start to publish news articles to highlight the its possible legacies. Although initially focused on the expectations about the future, the coverage can last for years. Often after the Olympics, the press focused especially on checking whether the promised goals were achieved.

The Olympic legacy is one of the strongest arguments used by cities and the International Olympic Committee (IOC) to justify the huge investiment of resources for the event, and is therefore commonly associated with positive outcomes. However, Olympic legacy can be understood as:

>'planned and unplanned, positive and negative, intangible and tangible structures created through a sport event that remain after the event’ (Gratton and Preuss, 2008, p. 1924).

By creating this corpus, you will be able to use it for a variety of data analyses, such as tracking the sentiment of news or applying topic modelling to the corpus.

<br />


##  Using the UK Webarchive as a data source

Finding content in web archives is not an easy task. It is particularly hard to extract news articles that cover the legacy of the Olympics instead of texts covering the Olympics in general (such as news about competitions). Being able to quickly search and evaluate the results is a crucial step for determining the initial query used to gather articles.

[SHINE](https://www.webarchive.org.uk/shine) is a search tool to explore data from .uk websites stored by the UK Web Archive. SHINE was developed by the [Big UK Data Arts and Humanities project](https://buddah.projects.history.ac.uk/) funded by the UK Arts and Humanities Research Council. The data available in SHINE was obtained from the Internet Archive, and contains webpages crawled between 1996 until April 2013. Although a big part of the content of the UK Web Archive can only be accessed inside the British Library, SHINE is open and its metadata can be consulted online. This makes SHINE a great tool for quantitative studies, as the avaiability allows researchers to explore the UK Web Archive and download the metadata in a variaty of ways.

{% include figure.html filename="SHINE-homepage.png" alt="Visual description of figure image" caption="Figure 1. UK Web Archive SHINE homepage" %}

*The UK Web Archive's SHINE search prototype*

<br />

## Searching for news articles in SHINE

In this section, you will learn how to search for content in SHINE and, at the end, you should be able to download a .csv file with a list of URLs to be scraped later.

{% include figure.html filename="SHINE-search-prototype.png" alt="Visual description of figure image" caption="Figure 2. UK Web Archive SHINE search prototype" %}

*The SHINE Search page*



Let's follow these steps:

- Go to SHINE's [search page](https://www.webarchive.org.uk/shine/search?facet.sort=index&tab=results) and search for: "Olympic legacy" London. You must use quotation marks for "Olympic legacy" as both words should appear together in the results. *[Access the [SHINE Search Tips](https://www.webarchive.org.uk/shine/search/tips) page for more info on how SHINE search can be used]*.

{% include figure.html filename="SHINE-search-Olympic-legacy.png" alt="Visual description of figure image" caption="Figure 3. SHINE search results for 'Olympic legacy'" %}


*SHINE search results for 'Olympic legacy'*




- On the left hand side, there will be a list of customisation tools that can be used to refine your search. Let's choose for the purpose of this lesson a specific `“Crawl year”` and `“Domain”` as follows:
  - Crawl year: 2013 (so we can get news articles covering the legacy after the 2012 Olympics)
  - Domain: guardian.co.uk

* In the blue box below the search button, you can see your query. Under results, you find the number of webpages encountered for your query. This combination of filters should display approximately 2235 search results.

{% include figure.html filename="SHINE-search-filter-2013-guardian.png" alt="Visual description of figure image" caption="Figure 4. SHINE search parameters" %}


- Click the `“CSV”` option in the results header and choose to export a `“Full” ` version of the spreadsheet containing your search results.

<div class="alert alert-warning">
> SHINE just provides .csv files with maximum of 20,000 results. If your search contains more than this, try to narrow down your query. You can reduce, for example, the time frame or write a more specific keyword search, and download and cobmine multiple results lists yourself.
</div>

Now, open the spreadsheet you just downloaded in a text editor (we are using [Sublime text](https://www.sublimetext.com/) in the screenshot below) and let's take a minute to look at how the data is structured:

{% include figure.html filename="SHINE-CSV-export.png" alt="Visual description of figure image" caption="Figure 5. CSV export of SHINE search results for 'Olympic legacy'" %}

In the first 2 rows, you will find [embedded provenance metadata](https://ardc.edu.au/resources/working-with-data/data-provenance/) for the SHINE search query which produced this data file. The first line is a description of the data source: the British Library, and the second line contains details about the query which we used.

The third line contains the headers of the columns that organise the data in the spreadsheet. This is where the data begins, and when we perform the next step to deduplicate the URL's, we will need our algorithm to skip over the embedded provenance metadata to work with the tabular data.

<br />




## Deduplication of source data

Among the 3,000 webpages resulting from the search in SHINE, many of them are potential duplicates, as mentioned above. In this section, we will identify duplicated results and remove then from the spreadsheet.

If you take a look again at the spreadsheet, you will see that there are many columns with different data types:

```
Title, Host, Public Suffix, Crawl Year, Content Type, Content Language, 
Crawl Date, URL, Wayback Date, URL
```

For this research, we are mostly interested in columns 8, 9 and 10. Namely, the archived webpage snapshot URL  (named `URL`), the datestamp of when the page was captured (named `Wayback Date`) and the original web URL (also named `URL`).

To perform deduplication we will use a python library for data manipulation and analysis called [Pandas](https://programminghistorian.org/en/lessons/crowdsourced-data-normalization-with-pandas#importing-packages-and-reading-files). To install and import pandas using a Jupyter Notebook, run the following code:

```python
!pip install pandas
import pandas as pd
```

*NB: The exclamation mark at the start of a line in a notebook cell will run that line as if it were being run in the a terminal window. You will not need to run the first line in your notebook cell if you already have the Pandas python library installed on your computer.*

Remember, the spreadsheet contains provenance metadata in the first 2 rows. Pandas usually expects the first row of a spreadsheet to be the column names, but the [`read_csv()`](https://pandas.pydata.org/docs/reference/api/pandas.read_csv.html) documentation has an argument to change this behaviour according to the structure of specific files. The argument called `skiprows` allows us to skip over the provenance metadata when we load the CSV. Let's try:

```python
shinedata = pd.read_csv('./data/export.csv', skiprows=2)

# In jupyter notebooks, putting the name of a variable on the last line
# of the cell will show that variable below the cell. This helps to inspect
# the values and structures of the variables your algorithms are working on.
shinedata.head()
```

{% include figure.html filename="pandas-raw-dataframe.png" alt="Visual description of figure image" caption="Figure 6. Raw dataframe in pandas" %}


**Renaming the columns**

We personally prefer to remove the spaces between the words in column names (instead of 'Crawl Year', we want 'Crawl_Year') as this can sometimes cause wierd problems when working with CSV data formatting. We also noticed from inspecting the data in a text editor that there were two columns called URL. It will help us to rename the two `URL` columns with unique names, and so let's use Pandas to transform `shinelist.columns` into the names we prefer.

```python
cols = shinedata.columns.to_list()
cols = [c.strip().replace(' ', '_') for c in cols]
cols
```

And we can see that pandas has automatically made the names of the duplicate URL columns unique, by calling them  `URL` and `URL.1` columns.

```python
cols[7] = 'Archive_URL'  # change item 8 in the list
cols[-1] = 'Original_URL'  # change the last item in the list
shinedata.columns = cols  # Assign the list of column names to the dataframe
```

You can now visualise your new Data Frame by running `shinedata` in a new cell.

{% include figure.html filename="shinelist-dataframe-renamed.png" alt="Visual description of figure image" caption="Figure 7. Dataframe with the columns renamed" %}


To find duplicates, what we want is the URL of the archived version of the webpage for the single most recent row for each unique URL.

The next step to get the data into the write format would be selecting only those columns that will be relevant for us. In this case, columns 8, 9 and 10, namely, the URL of the archived page, the datestamp of when the page was captured and the original URL. By running the following code, you will be able to update the DataFrame `shinedata` with a new version having just these 3 columns:

```python
shinedata = shinedata[['Crawl_Date', 'Archive_URL', 'Original_URL']]
```
To perform the deduplication, we are going to use Pandas DataFrame function `drop_duplicates()`. Using this function you can opt whether to keep the 'first' or the 'last' duplicated item. In the code below, we decided to get the first URL to appear in the (newly renamed) column 'Original_URL'. We will drop duplicates using this column because every time a webpage is archived, a different webarchive URL is generated with the date and time of archival.

```python
shinedata = shinedata.drop_duplicates(subset='Original_URL', keep='first')
```
After running the code above, you can check how many columns and rows remain in your DataFrame by running:

```python
shinedata.info()
```

The spreadsheet had 3,000 rows at the beginning and after deduplication only 361 unique webpages remain. 



**Deeper data cleaning**

Before we move on to the articles extraction it is important to filter the URLs and remove some that do not contain an article. Many of them are actually RSS-XML feeds. We'll do this by simply checking if the final characters of the URL are 'rss'. And instead of a python for loop we will use a python list comprehension to do this in a single line.

First, create a list using the DataFrame column 'Original_URL' and then remove the URLs ending with 'rss':

```python
urls = shinedata.Archive_URL
urls = [url for url in urls if url.endswith('rss') == False]
```

This leaves us with 177 unique newspaper article URL's.

<br />

## Web Scraping using Boilerpipe

Extracting information from web pages can be a hard task. The main reason is that websites have different ways to store they content in the HTML file. When it comes to scraping articles, the main problem is that usually there will be lots of noise in the page that should be ignored such as sidebars, navigation elements, users comments or even advertisement.

Boilerpipe is a python library developed to detect and remove these adjacent information and keep only the main textual content of a web page. The reason to use Boilerpipe is that besides its good performance in removing "clutter" around the articles, it deals very well with the variety of HTML structures presented in different websites. This is particularly relevant when working with the archived web, as the HTML of the collected web pages have been changing considerably over the last decades.

To install Boilerpipe using Jupyter Notebook and import the article's extractor run the following piece:

```python
!pip install boilerpy3
from boilerpy3 import extractors
```

Extracting now an article from a URL is simple. You can try to scrape from a single random URL (let's get the one in position 55) using the following code:
```python
extractor = extractors.ArticleExtractor()
content = extractor.get_content_from_url(urls[55])

content  # View what Boilerpipe returned
```

In the next sections, we will apply this to every single URL. But first we need to think about how to store all this data.

### Choosing filenames

We have already made the list of unique URLs and removed the RSS feeds. When we scrape the news articles we are going to have to save them to files somewhere. We need to choose how to name the files usefully.

Converting the URLs into filenames can be tricky as the URLs in our list contain characters which are not appropriate for filenames. There are plenty of techniques to solve this issue, but the most basic is to simply replace the problematic characters with a character which is appropriate for filesystems.

In this tutorial we will replace colons, slashes and fullstops with the underscore character, and we will build this as a python function and test it out.

```python
# Replace characters in a URL with filesystem safe characters. Returns a string.

def filenameFromUrl(url):
    return url.replace("http://", "").replace("https://", "").replace(".", "_").replace("/", "_")
```
Now we can test how it works by running the function in the first 5 URLs. By using 'url[27:] we are defining that we want the result to start from the 27th character. This means that the first part of the Archived_URL will be removed (http://web.archive.org/web/)'

```python
# Test it out on the first 5 URL's in our list.
for url in urls[:5]:
    print(filenameFromUrl(url[27:]))
```

### Where to save our corpus

> For more detailed information about structuring and managing your research data, see the Programming Historian tutorial on [Preserving your research data](https://programminghistorian.org/en/lessons/preserving-your-research-data).


Now we have a clean list of URLs which we want to scrape from the UK Web archive and a way to turn the URLs into filenames. Before we start scraping, we next need to decide where we are going to save the data and in what sort of directory structure.

For this lesson, let's save it in the data directory, next to this notebook, and create a subdirectory in there called 'corpus'. Each file inside the corpus will correspond to a single scraped newspaper article's text.

```
│ # webscraping tutorial project directory
├── README.md      <- This lesson document.
├── README.ipynb   <- The juypter notebook of this lesson's code.
├── data           <- Where we store this project's data files.
│   └── corpus     <- Where we will store this project's harvested text files.
└── assets
    └── images     <- Images and screenshots used in this lesson.
```

The name of these files will be generated by the function `filenameFromUrl()` which we wrote earlier. Let's check if the directory is there and make it if it is not:

```python
import os

corpusdir = './data/corpus'

if not os.path.exists(corpusdir):
    os.mkdir(corpusdir)
```



### How long is scraping 361 URL's going to take?

Calculating how much time a piece of code will need to run can be easy thanks to Jupyter Notebook's magic command `%%time`. By running this command at the beginning of the cell, Jupyter will return the approximate time required:

```python
%%time

extractor = extractors.ArticleExtractor()
content = extractor.get_content_from_url(urls[0])
```
Each time you run this code, time is slightly different. By manually copying the wall time in seconds to scrape just one URL, you can calculate the duration for the entire corpus:

```
len(urls) * 3.74 / 60
```
Our result was around 8 minutes. Not too bad. That's one URL request to the webarchive each few seconds, which is polite enough. If you calculate the same for 20,000 URLs the result is approximately 20 hours!  If yo are paid as a data scientist you might get £300/day, so at 8 hours labor per day, it would cost £750. When you measure the compute time as if it were human labor, you can start to see why carefully curated and prepared data has such a high value. And why efficient data management skills are so valuable for businesses and research.

<div class="alert alert-warning">
Be aware that scraping 361 web pages of this kind can produce approximately 599.26g of CO2. That's the same weight as 1.2 pints of milk. 20,000 URLs would be roughly 33.2kg, and so our digital impact begins to add up.
</p></p>Hopefully you are able to see why it is important to consider minimal computing and sustainable and efficient approaches when designing and crafting your digital research project methods.

You can estimate a website carbon footprint using <a href= "https://www.websitecarbon.com/"> Website Carbon</a> calculator.
</div>

### Efficient and 'polite' web scraping

If the total time required to harvest your webarchive data is one thing for yourself to consider, it follows that the frequency and rate at which your computer is requesting URL's is one other thing to consider, not for yourself but for other people.

So we need to consider situations such as:

- your internet connection goes down after 5 hours and you need to restart your scrape;
- when you realise you needed to scrape the title and date from the articles, and now you need to re-scrape your whole corpus again;
- if the UK webarchive throttles your super fast internet connection because your computer keeps harvesting 30 URLs each second, and slowing their servers down for other researchers who are wanting to use it.

Addressing these unforeseen situations takes a combination of 'caching' and 'concurrency' and you will find it useful to understand these computational principles and incorporate them into your algorithms. In the case of scraping algorithms, we can accommodate both of these ideas, in different ratios according to your specific situation.

Most of the time, we work from home or the office and need to be considerate of others on the Internet. This is where caching your harvesting progress can help. If you scrape data more slowly, over many hours or days, you'll be able to continue video meetings or Netflix watching without problems. The key to slowing down your scraper is making sure you can restart from where you stop. For example, if you lose power, it will be nice to know you can pick up your data scraping from where you stopped.

Now we have learnt the components and considerations of webscraping, it is time to start pulling these together into our scraping algorithm.

### Scraping all pages

To scrape all the pages we will have to write a `for loop`. This way, for each URL in our list of URLs, we will create a new file in the directory and scrape the article from the webpage. The code should be written in a way that, in case you need to restart scraping, it does not scrape again the same URL. For this, we will use the `if condition`. This means that, if file is not already in directory, then the code can continue running and create a new file.

We will also include two `print` information that will be useful to track the code outputs. The first one will inform that the URL is being scraped. The second will inform that the scraping was already done before, in case you are running the code for the second time on the same list of URLs.

The piece of code to perform these steps can be seen below:

```python
for url in urls:
    filename = os.path.join(corpusdir, filenameFromUrl(url)) + '.txt'
    if not os.path.exists(filename):
        with open(filename, 'w', encoding='utf8') as f:
            print('Scraping... {}'.format(url))
            extractor = extractors.ArticleExtractor()
            content = extractor.get_content_from_url(url)
            f.write(content)
    else:
        print('Already scraped... {}'.format(url))
```

Although Boilerpipe performs very well for most web pages it is not perfect. Some errors might appear while running the piece of code above. It is important to be aware and prevent these errors to stop your process.

One of the common errors encountered while running this code is `Warning: SAX input contains nested A elements`. This usually happens due to the presence of invalid `<a>` tags in the website's HTML. But it doesn't stop the algorithm. It still returns some content until it finds the invalid `<a>` tags on the page.

While this problem can be ignored, as it is not stopping the code, others need to be handled in a different way. To solve the issue in a practical way, we will collect a list of URLs that Boilerpipe could not extract the article and save in a new file. This way, you can investigate why it happened by looking at the pages and, if you consider that their content is still relevant for your corpus, you can try a different web scraper. You can find other Programming Historian tutorials on web scraping [here](https://programminghistorian.org/en/lessons/?topic=web-scraping).

Now, let's first create a file where we will store the errors messages with the problematic URLs:
```python
errorlog = 'error.log'
```
We have now to add a `try`/`except` function to our code. This way it will try to scrape the article from the URL and, if it is not possible due to some error, it will `print` an error message saying 'Exception of type...' where the type of error will be described and then we append the error to the file `errorlog`. This way, besides having the articles in your corpus, you have also a list to keep track of possible errors found while performing web scraping.

The entire code with the errors handling solution is described below:


```python
errorlog = 'error.log'

for url in urls:
    filename = os.path.join(corpusdir, filenameFromUrl(url)) + '.txt'
    if not os.path.exists(filename):
        try:
            with open(filename, 'w', encoding='utf8') as f:
                print('Scraping... {}'.format(url))
                extractor = extractors.ArticleExtractor()
                content = extractor.get_content_from_url(url)
                f.write(content)

        except Exception as ex:
            errormsg = 'Exception of type {} on... {}\n'.format(type(ex).__name__, url)
            print(errormsg)
            with open(errorlog, 'a', encoding='utf8') as errlog:
                # note we are opening this file with the 'a' status, 
                # which means append to existing if we opened it with 'w'
                # which is much more common, that would overwrite the file.
                errlog.write(errormsg)

    else:
        print('Already scraped... {}'.format(url))
```

<br />

## Are the articles still relevant? 

After scraping the articles it is important to check if they include the initial words searched on SHINE. It is possible that these words were located in the peripheral locations of the webpage. Therefore, they were not mentioned in the main body text and were probably removed by Boilerpipe.

```python
import re

# Let's first create a new directory called 'filtered_corpus' where the
# files originated from the 'corpus' directory will be stored after filtered. 
corpusdir = './data/corpus'
filteredcorpusdir = './data/filtered_corpus'

if not os.path.exists(filteredcorpusdir):
    os.mkdir(filteredcorpusdir)


items = ['legacy', 'Legacy']


# For every text file in the 'corpusdir', if file contain the words 
# in the list of items, copy and paste to the new directory 'filteredcorpusdir'.
# Also, print whether the words were found or not in each text file and 
# how many times they are cited. 
for filename in os.listdir(corpusdir):
    if filename.endswith(".txt"):
        with open(os.path.join(corpusdir + filename), 'r', encoding='utf-8') as myfile:
            content = myfile.read()

            for i in items:
                lis = re.findall(i, content)
                if len(lis)==0:
                    print(filename,'Not found')
                    
                elif len(lis)==1:
                    print(filename,'Found once')
                    with open(os.path.join(filteredcorpusdir, filename + '.txt'), 'w', encoding='utf-8') as file1:
                        file1.write(content)
                        
                elif len(lis)==2:
                    print(filename,'Found twice')
                    with open(os.path.join(filteredcorpusdir, filename + '.txt'), 'w', encoding='utf-8') as file1:
                        file1.write(content)
                        
                else:
                    print(filename,'Found', len(lis), 'times')
                    with open(os.path.join(filteredcorpusdir, filename + '.txt'), 'w', encoding='utf-8') as file1:
                        file1.write(content)
```

Now you have your harvested and filterd text corpus composed of approx. 33 unique news articles mentioning the words 'Olympic legacy' and 'London' published by the Guardian in 2013 and archived by the UK Web Archive. You can perform many different analysis in the texts using Natural Language Processing techniques. Some of them have already a Programming Historian tutorial that can be found [here](https://programminghistorian.org/en/lessons/?activity=analyzing).

<br />


## Acknowledgments

We would like to thank Jason Webber, web archiving engagement and liaison manager at the British Library and Professor Jane Winters, director of the [Digital Humanities Research Hub](https://www.sas.ac.uk/digital-humanities) at the School of Advanced Study for the valuable contibutions to this lesson. The methods described here were developed under the [project CLEOPATRA](https://cleopatra-project.eu/), funded by the European Union’s Horizon 2020 research and innovation programme under the Marie Skłodowska-Curie grant agreement no. 812997.

<br />

## Works Cited

Gratton, C., & Preuss, H. (2008). Maximizing Olympic Impacts by Building Up Legacies. The International Journal of the History of Sport, 25(14), 1922–1938. https://doi.org/10.1080/09523360802439023

Ian Milligan and James Baker, "Introduction to the Bash Command Line," Programming Historian 3 (2014), https://doi.org/10.46430/phen0037.

JISC and the Internet Archive (2013). JISC UK Web Domain Dataset (1996-2013). The British Library. https://doi.org/10.5259/ukwa.ds.2/1

Quinn Dombrowski, Tassie Gniady, and David Kloster, "Introduction to Jupyter Notebooks," Programming Historian 8 (2019), https://doi.org/10.46430/phen0087.

<br />

## About the author

Caio Mello is a PhD student in Digital Humanities at the School of Advanced Study, University of London. His main research interests lie in the field of digital methods, Natural Language Processing techniques, data visualisation, media studies, urban studies and digital activism.

Martin Steer is Techincal Lead in the Digital Humanities Research Hub at the School of Advanced Study, University of London. He works with humanities and social media data, data infrastructure, web archives and fiction.


<br />

## Suggested Citation

Caio Mello & Martin Steer, "Web scraping of news articles from the UK Web Archive using Boilerpipe" The Programming Historian (2022), https://doi.org/XXXXXX.
