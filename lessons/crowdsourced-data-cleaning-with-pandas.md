---
title: Crowdsourced-Data Cleaning with Python and Pandas
collection: lessons
layout: lesson
slug: crowdsourced-data-cleaning-with-pandas
date: LEAVE BLANK
authors:
- Halle Burns
reviewers:
- LEAVE BLANK
editors:
- Brandon Walsh
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/301
difficulty: LEAVE BLANK
activity: LEAVE BLANK
topics: LEAVE BLANK
abstract: LEAVE BLANK
---

{% include toc.html %}


# Crowdsourced-Data Cleaning with Python and Pandas

## Overview
Crowdsourcing is a way of outsourcing work by utilizing the input and contributions of people through an online platform. It is a way of collecting ideas, receiving input, or gathering data from the public, the proverbial "crowd." There are [many reasons](https://link.springer.com/article/10.1007/s10796-015-9578-x) a project may choose to enlist crowdsourcing as a method to gather data and input. By using crowdsourcing, you enlist a diverse group of individuals, all with different skillsets and strengths. Crowdsourcing can be used for idea generation or even for data collection and text transcription or translation. Projects of this nature are increasing as organizations such as libraries strive to make their collections accessible online.

Data can be messy, especially when projects are crowdsourced. Even with the most rigorous submission guidelines, data collected in this manner inevitably contains a certain level of variability. In this lesson, you will work with Python and the [pandas library](https://pandas.pydata.org/) with a dataset from the [New York Public Library](https://www.nypl.org/), will learn the fundamentals of data cleaning, and will identify common issues when utilizing crowdsourced data.

At the end of the lesson you will:
  
* Understand challenges specific to working with crowdsourced data
* Demonstrate how to programmatically implement common data cleaning techniques
* Use pandas to remove unnecessary columns and organize your data

### Why use crowdsourcing?
In recent years, large-scale projects such as the [Squirrel Census](https://www.thesquirrelcensus.com/about) have been developed. In this example, a team of over 300 volunteers participated in research and data collection on Central Park's population of Eastern gray squirrels. International projects, such as [Penguin Watch](https://www.zooniverse.org/projects/penguintom79/penguin-watch) on [Zooniverse](https://www.zooniverse.org/), have come to fruition, as well. Members of the public classify different images of penguins to help identify environmental threats. Zooniverse itself is an online platform for "people-powered research," enabling millions from around the globe to contribute to various research projects. These are all instances where data is collected and analyzed on a massive scale and public assistance is necessary for completion.

While computation and programming methods are incredibly powerful, some jobs only are possible through human involvement. Certain elements of transcription or identification are not feasible through programming alone, with humans better equipped to distinguish certain nuances and spot potential outliers. However, people can be asked to contribute to projects in larger ways, typically through competing in a context. An example of macrotasking, a type of crowdsourcing for larger, more specialized projects, is that of the [Netflix Prize](https://www.netflixprize.com/). The Netflix Prize called for individuals to develop an algorithm to better predict movie recommendations for viewers. In cases such as this, a reward or prize of some sort was awarded to the winning individuals.

It is important that those participating in crowdsourcing endeavors are compensated for their time. While with macro-projects, a competition system commonly is used, not everyone who enters will receive an award. In ["On the Ethics of Crowdsourced Research"](https://doi.org/10.1017/S104909651500116X) by Vanessa Williamson, it declares that many people participating in crowdsourced research (particularly Amazon's [Mechanical Turk](https://www.mturk.com/)) do not do this for fun in their spare time. Those contributing to this platform invest quite a bit of time, however, are paid very little, as crowdsourced labor is not a protected form of labor. Williamson suggests participating researchers "set a minimum wage for their own research" and encourages accountability, requiring industries to report the wages of workers compared to the number of hours invested. In addition, Williamson recommends organizations such as an [IRB](https://www.fda.gov/regulatory-information/search-fda-guidance-documents/institutional-review-board-irb-written-procedures) to create "guidelines for the employment of crowdsourced workers." When considering crowdsourcing for a project, addressing and implementing protocols to support and protect workers is a must.

#### Things to consider...
Crowdsourcing is not the best avenue for every project. For different types of projects, crowdsourcing methods [do not always produce the most accurate results](https://hbr.org/2019/12/why-crowdsourcing-often-leads-to-bad-ideas) and can lead to more effort sifting through responses than to actually answering a research question. Not everyone who participates as a researcher will have the same level of knowledge and experience, potentially leading to variation in the results. Additionally, as someone organizing crowdsourced research, you need to be cognizant of the time being invested and ensure that those participating are properly compensated. When determining whether crowdsourcing a project is the best option for you, consider these different factors, as outlined in ["How to Use Crowdsourcing Effectively: Guidelines and Examples"](https://www.liberquarterly.eu/articles/10.18352/lq.9948/), an article by Elena Simper:

1. **What should you crowdsource?** There are many tasks such as data entry, data classification, transcription, or the brainstorming and collection of ideas that can be crowdsourced easily to individuals around the globe. Many minds with different ideas and skillsets can provide an effective way to approach tackling a specific endeavor.

2. **What is the scale of the work?** Crowdsourced projects are most successful when there are smaller pieces that individuals can address on their own. Is this possible for the type of project in which you are invested?

3. **Does the work outweigh the benefits?** While useful and potentially cost-effective to outsource smaller projects and items to many individuals, you still need to spend time on your end compiling the collected information and, in many cases, cleaning the data. Depending on the scale of your project, this could be a massive undertaking and not always lead to people spending their time productively. As referenced in [Simper's article](https://www.liberquarterly.eu/articles/10.18352/lq.9948/), Google [announced a call](https://googleblog.blogspot.com/2009/09/announcing-project-10100-idea-themes.html) asking for public proposals. While receiving over 150,000 submissions, causing a long delay in response to individuals, only 16 projects were chosen for further consideration.

#### Guidelines
When deciding to collect data using crowdsourcing methods, there are several things to keep in mind and guidelines to examine. These are important not just for the protection of workers but for the quality control of the project as a whole.

1. **Clarity:** The volunteers carrying out the crowdsourced tasks need to know their responsibilities. For projects focused more on idea generation, this might appear as guidelines, prompts, or questions. For data entry, transcription, or more by-the-book tasks, volunteers need to know exactly what they are being asked to submit (see Submission Guidelines below) and how. It is important for volunteers to know that their efforts actually are being utilized and are significant for the project at hand. This means including not just a description of the overall research being carried out but also why they are being asked for their assistance, what skills they can uniquely contribute that would lead to the success of the project.

2. **Labor:** While outsourcing tasks and elements of projects potentially can be more efficient, there still is much work and effort that goes into carrying out crowdsourced research. People on the backend still need to review the information submitted. Even if done programmatically through processes such as data cleaning or analysis, time and additional labor still is allocated to ensure everything is accurate. On large-scale projects, this can be quite the undertaking, and it is important to keep timelines for project advancement and completion realistic. 

3. **Quality control:** Because there are more people handling, processing, or transcribing information in crowdsourced projects, it is imperative to direct a sufficient amount of labor towards quality control. This is where familiarization with your data and the development of a data cleaning plan ahead of time will circumvent a headache. Step-by-step documentation or an automated process to compile, sort, and clean submitted data and information will help save time and expense in addition to contributing to better data management. However, as will be discussed throughout this lesson, there is only so much control organizers can exert over a project and submitted data.

4. **Submission guidelines:**
    - **Naming conventions:** When working with data involving names, whether that be names of people or of organizations, you must specify how those names are expected to be written. Even Wikipedia, an organization that can be said to be built on the idea of using crowdsourcing to collect reference information, has [clearly stated guidelines](https://en.wikipedia.org/wiki/Wikipedia:Naming_conventions_(people)) for how names are meant to appear on their website and what to do when names do not fit the usual format. Naming conventions become particularly muddy when dealing with prefixes, suffixes, and titles. Regardless of how you choose to outline your naming guidelines, you should be clear on what you expect from those entering the information.
    - **Dates and times:** As referenced later in this lesson, dates and times can be written in a variety of ways depending on who you are or where you are in the world. While all conveying the same information to the human eye, dealing with differing date formats can be a headache for data cleaning purposes. Enforcing a specific date-time format, such as [ISO 8601](https://www.w3.org/TR/NOTE-datetime-970915), is recommended to standardize data entry.
    - **Special characters:** It is important to be clear, particularly when requiring data entry, whether [special characters](https://cs.stanford.edu/people/miles/iso8859.html#ISO-SPECIAL) will be accepted. Special characters encode differently and can potentially cause difficulties when attempting to clean data. Examples of special characters include ä (a lowercase a with an umlaut), fractions, or even currency symbols. If not accepted, there are ways to restrict this during the entry phase, using regular expressions or other tools to force the validation of the entered phrases.
    - **Other guidelines:** Guidelines for submission can become increasingly specific. From how to format numbers to only allowing the use of specific punctuation, you can request volunteers adhere to many different criteria. Using metadata standards, such as [Dublin Core](https://dublincore.org/) or [TEI](https://tei-c.org/) also can be used as a way to enforce consistency. However, no matter how strict your guidelines or your submission protocols, variability inevitably will be present in your collected data. That being said, there are ways to identify and normalize those instances.
    
### The New York Public Library (NYPL) Historical Menu Dataset
The NYPL possesses a digitized collection of approximately 45,000 menus, dating from the 1840s to today. This collection is made public through [What's on the menu?](http://menus.nypl.org/). Rather than relying on optical character recognition (OCR), a way of programmatically reading hand-written or printed documents into machine-searchable text, NYPL crowdsources transcription of the collection. While occasionally time saving, using methods such as OCR still does not guarantee accuracy and oftentimes require humans to check and correct the output. In addition, with the menus possessing a wide variation of handwritten text and complex fonts, writing a universal code to ensure the accuracy of the OCR is very difficult. Even if a universal code could be developed, the NYPL determined several aspects of each menu that could only be differentiable to the human eye.

Generated twice a month and available for public download, *What’s on the menu?* provides access to four distinct related datasets. While the dataset we will utilize during this tutorial lists each menu, including information about venues as well as dates, the other datasets are relational and focus on different elements of each menu. Detailing meals spanning over the past 150 years, this collection gives viewers a look at what people were eating as well as when, adding a new element to understanding history. The datasets curated by *What's on the menu?* include `Dish.csv`, `MenuItem.csv`, `MenuPage.csv`, and `Menu.csv`. More information, as well as access to the regularly updated datasets, can be found on the [project website](http://menus.nypl.org/data).

The `Dish.csv` dataset contains a list of each unique menu item, detailing how many times each dish appears across the collection, the years they first and last appear, and information about high and low prices. A dataset such as this would enable historians to analyze the popularity of different foods as well as their prospective prices over time. `MenuItem.csv`, the largest dataset in the bunch, uses the food IDs created in `Dish.csv` and relates them to their associated menus based on which page they appear. The third dataset, `MenuPage.csv`, connects the individual menu IDs created in `Menu.csv` with the page IDs from `MenuItem.csv` (the final dataset), ensuring that each dish and related page is linked with the correct menu. Viewed together, this group of datasets paints a unique and specific picture of history, centered around what people ate.

For the purposes of this tutorial, we will be cleaning the main dataset, [Menu.csv]({{ site.baseurl }}/assets/crowdsourced-data-cleaning-with-pandas/Menu.csv). This dataset consists of 20 columns containing text, numbers, as well as dates, in addition to 17,546 rows, one for each menu currently or previously transcribed. This dataset contains information on completed transcriptions as well as ones still in process. A single row was added to the dataset by the author of this tutorial to simulate duplicate data.

Using the Python library, pandas, we will review how to:

* Remove unnecessary columns
* Find rows with missing data
* Identify and remove duplicate data, something that can occur when many people are working on a singular project
* Understand the complexity of dates

## Getting Started

### Prerequisites
This tutorial can be followed regardless of operating system. This tutorial was written using Python 3.7.4 as well as pandas version 1.0.5 and assumes familiarity with Python and with either the command line or Jupyter Notebook. Should you have no previous experience working with Python, consider starting with ["Python Introduction and Installation"](https://programminghistorian.org/en/lessons/introduction-and-installation), as you'll need to have Python installed on your computer and be familiar with some basics. You will need to create a virtual Python 3 environment for this lesson. Information on creating a virtual Python 3 environment can be found in another Programming Historian lesson, ["Visualizing Data with Bokeh and Pandas"](https://programminghistorian.org/en/lessons/visualizing-with-bokeh#creating-a-python-3-virtual-environment).

To install this specific version of pandas, use the following code in your created virtual environment:

```
pip install pandas==1.0.5
```

If pandas is already installed on your machine, you can ensure you are using the most recent pandas release by running the following code in your terminal or command prompt:

```
pip install --upgrade pandas
```

Pandas is a popular and powerful package used in Python communities for data manipulation and analysis. Pandas is capable of reading in and writing out a number of [different file types](https://pandas.pydata.org/pandas-docs/stable/user_guide/io.html), such as CSV, JSON, Excel, and Stata files.

This tutorial assumes familiarity with the concept of [data cleaning](https://www.tableau.com/learn/articles/what-is-data-cleaning) (detecting and fixing or removing incorrect, or duplicate data) or [tidy data](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html) (ways of organizing data to improve analysis).

## Exploring the NYPL Historical Menu Dataset
With such an expansive dataset, there are a number of research questions that could be explored. For the purposes of this tutorial, we are interested in whether certain events (such as breakfast, lunch, or dinner) historically possessed more menu items than others. In addition, we can explore whether longer menus were more popular during specific times of year.

### Downloading the Dataset and Creating a Python File
To begin, we will create a directory as well as a blank Python file within. This Python file is where we will store and save our code. I have named this Python file `nypl-menu.py`. In addition, you will need to download and move the dataset, `[Menu.csv]({{ site.baseurl }}/assets/crowdsourced-data-cleaning-with-pandas/Menu.csv)`, into the same created directory. It is important that the downloaded .csv file and your .py file are both within the same directory, otherwise your code will not run as intended. Before running a new section of code, you must save your progress in your Python file.

When ready to run your code, using the command line or terminal, you will navigate to your newly created directory. Once in the directory, you will type `python nypl-menu.py` and then hit Enter.

If you prefer to run through this tutorial without needing to navigate the command line, a [Jupyter Notebook](https://jupyter.org/) file `[Crowdsourced-Data-with-Pandas.ipynb]({{ site.baseurl }}/assets/crowdsourced-data-cleaning-with-pandas/Crowdsourced-Data-with-Pandas.ipynb)` is available containing code from this lesson. Information on how to install and use Jupyter Notebooks can be found in the Programming Historian Lesson ["Introduction to Jupyter Notebooks"](https://programminghistorian.org/en/lessons/jupyter-notebooks).

### Importing Packages and Reading Files
First, within the .py file, we will import the pandas package and load in our data as follows:

```
import pandas as pd

df = pd.read_csv("Menu.csv")
print(df.head())
```

It is important to note that frequently, the pandas library is abbreviated as *pd*, including in the [official documentation](https://pandas.pydata.org/pandas-docs/stable/getting_started/index.html#getting-started). To "read in" our data, we will be calling in the `read_csv()` function, which will load our data into a pandas `DataFrame`, often abbreviated to *df*. The *df* essentially holds the columns and rows of our dataset. For this tutorial and keeping with convention, we will be using *df* to describe our DataFrame.

It is good practice to view the data just after reading it in to ensure that it read in properly and did so in the manner you were anticipating. While you are able to view the whole dataset by typing `print(df)`, the function `df.head()` will allow you to view only the first five rows of your dataset. Remember to save your .py file and then, to run it, navigate to your directory in the command line or terminal, type `python nypl-menu.py`, and hit Enter. The output will appear as follows:

```
      id name                     sponsor                 event  ... currency_symbol    status page_count dish_count
0  12463  NaN               HOTEL EASTMAN             BREAKFAST  ...             NaN  complete          2         67
1  12464  NaN            REPUBLICAN HOUSE              [DINNER]  ...             NaN  complete          2         34
2  12465  NaN  NORDDEUTSCHER LLOYD BREMEN  FRUHSTUCK/BREAKFAST;  ...             NaN  complete          2         84
3  12466  NaN  NORDDEUTSCHER LLOYD BREMEN                LUNCH;  ...             NaN  complete          2         63
4  12467  NaN  NORDDEUTSCHER LLOYD BREMEN               DINNER;  ...             NaN  complete          4         33

[5 rows x 20 columns]
```

Based on information in brackets at the bottom of the output, we are able to see that the first five rows of data are printed and that our dataset consists of twenty columns. The value `NaN`, appearing beneath the `name` and `currency_symbol` headers, indicates that there is no data stored within those cells. `NaN` stands for `Not a Number`, and is the "default missing value marker" for pandas, according to [documentation](https://pandas.pydata.org/pandas-docs/stable/user_guide/missing_data.html). While there are cases where `NaN`, or in this case null, values might indicate error and require further investigation, in the case of this dataset, it is an expected result. It is not unusual or specific to crowdsourced projects to find null values in your dataset. However, should you discover that a column contains mostly or entirely null values, it would be worth examining your source materials or data entry methods for cause.

### Removing Columns
After reading in a new file, it is helpful to learn a bit about your data. By adding the function `print(df.columns)` to your Python file, saving it, and then running it once more in the command line or terminal using `python nypl-menu.py`, you are able to see what columns are represented in the dataset (output below): 

```
Index(['id', 'name', 'sponsor', 'event', 'venue', 'place',
       'physical_description', 'occasion', 'notes', 'call_number', 'keywords',
       'language', 'date', 'location', 'location_type', 'currency',
       'currency_symbol', 'status', 'page_count', 'dish_count'],
      dtype='object')
```

This output displays a complete list of column headers, in order of appearance, from the `Menu.csv` dataset. Following the list, the `dtype`, or [data type](https://pbpython.com/pandas_dtypes.html), is indicated to be `object`. This means that the column headers are all strings or mixed, containing text or a combination of numbers and text. Knowing the data type informs what operations can be performed on certain data. For instance, if a data type is an `int` or a `float`, we would be able to use mathematical calculations on the indicated data, such as finding an average.

This is a larger dataset, consisting of 20 columns total. Based on our research questions, at first glance, you may be able to determine which columns are unnecessary for future analysis.

For the purposes of this tutorial, let's say we want to remove any columns related to library-usage as well as any columns related to currency, leaving only information related to venue, the date of event, the occasion, and the summed properties of each menu. To do this, we will create a variable (`dropped_col`) containing the columns we would like to remove. This variable is then passed to the `drop()` function, a built-in function in the pandas library that allows you to remove indicated columns or rows. By indicating that `inplace=True`, we are stating that we do not want a copy of the object, i.e. the columns, to be returned. In addition, `axis=1` informs the program that we are specifically looking at columns. This would be written in your Python file as:

```
dropped_col = ['notes', 'call_number', 'currency', 'currency_symbol', 'physical_description', 'status']
df.drop(dropped_col, inplace=True, axis=1)
```

If run in the command line or terminal again with `python nypl-menu.py`, no results will be returned. However, by adding the code

```
print(df.shape)
```

to your Python file and then running it with `python nypl-menu.py`, the result of `(17546, 14)` will be returned, and we can see that our dataset now consists of 14 columns. 

The function `df.shape` is a relatively new command in the pandas library. It will return the dimensions, in this case the number of rows and columns, represented in your dataframe. The command `df.shape` is very useful for tracking any dimensional changes made to a dataset, such as the removing of duplicates, columns, or rows.

At this point in the tutorial, your Python file should contain the following code:

```
import pandas as pd

df = pd.read_csv("Menu.csv")
print(df.head())

print(df.columns)

dropped_col = ['notes', 'call_number', 'currency', 'currency_symbol', 'physical_description', 'status']
df.drop(dropped_col, inplace=True, axis=1)

print(df.shape)
```

### Duplicates
On occasion, despite rigorous submission guidelines, duplicate data can slip into a final dataset. Particularly, when dealing with crowdsourced research such as translation or transcription, it is possible that more than one person addresses a specific element, leading to duplicates or even slight variations on the same idea. Adding the statement

```
print(df[df.duplicated(keep=False)])
```

to your Python file will identify any duplicate rows within your dataset. By indicating `keep=False`, we are creating a Boolean that will mark every duplicate as `True`, which will return any duplicate rows. 

When the file is run with `python nypl-menu.py`, the output (below), will display two duplicate rows:

```
          id name        sponsor      event       venue  ...       location location_type    status  page_count  dish_count
0      12463  NaN  HOTEL EASTMAN  BREAKFAST  COMMERCIAL  ...  Hotel Eastman           NaN  complete           2          67
17545  12463  NaN  HOTEL EASTMAN  BREAKFAST  COMMERCIAL  ...  Hotel Eastman           NaN  complete           2          67

[2 rows x 14 columns]
```

It is possible to search for duplicates within specific columns, as well. For instance, if you were checking to see whether there were any duplicates in the ID column, as IDs are meant to be unique, you would use `df[df.duplicated(subset='id', keep=False)]`.

Once duplicate data are identified, it is only a matter of removing them from your dataset. The pandas built-in function `drop_duplicates` can be used to delete any duplicate rows. Add the following function to your Python file and then run it in the command line with `python nypl-menu.py`:

```
df.drop_duplicates(inplace=True)
```

By indicating `inplace=True`, you ensure that you are keeping at least one of the duplicate entries in your final dataset.

By running `print(df.shape)` again, you will see that the original row count of 17546 has now become 17545.

At this point in the tutorial, your Python file should contain the following code:

```
import pandas as pd

df = pd.read_csv("Menu.csv")
print(df.head())

print(df.columns)

dropped_col = ['notes', 'call_number', 'currency', 'currency_symbol', 'physical_description', 'status']
df.drop(dropped_col, inplace=True, axis=1)

print(df.shape)

print(df[df.duplicated(keep=False)])

df.drop_duplicates(inplace=True)

print(df.shape)
```

### Missing Data
As stated previously, as this is an ongoing project, this dataset contains entries both completed as well as ones currently in progress. This means that there are records in our dataset that contain missing information. Cells where no information, including whitespace, is present is known as a `null value` and is shown as `NaN`. Sometimes, especially in larger research projects, you might need to present progress reports or a proof of concept as part of your preliminary research. This means that you would be pulling from an incomplete dataset, similar to the one with which we are working. Or, for instance, it might be that researchers are transcribing menus chronologically, therefore you have records for every menu but not data to possess said records. If you are interested in events tied to earlier dates but not later ones, it might be prudent to begin processing your collected data prior to the completion of the project.

It is useful to see which columns in your dataset contain null values. The function `df.isnull()` identifies null values cell by cell in your dataset, and, if run, will return your dataset populated by Booleans, with True meaning the cell is a null. While this might be interesting to view, a table populated entirely by True/False values is difficult to read and hard to interpret. By adding `.sum()` to the end of the function, Python will return an overview, the names of each column header alongside the total number of times a cell is marked True in each column. Therefore, by inputting the code

```
print(df.isnull().sum())
```

into your Python file and then running it with `python nypl-menu.py`, a report of column headers and the amount of nulls per column are returned, below.

```
id                   0
name             14348
sponsor           1561
event             9391
venue             9426
place             9422
occasion         13754
keywords         17545
language         17545
date               586
location             0
location_type    17545
page_count           0
dish_count           0
dtype: int64
```

These results indicate that only 4 columns of our dataset are null-free: `id`, `location`, `page_count`, and `dish_count`. The other columns contain as few nulls as 586 or as many as the entire column. These specific columns are likely null-free for several reasons. First, every menu being transcribed is required to have a unique identification number. Without an id number, it becomes near impossible to correctly differentiate every menu, increasing the likelihood of duplicates. The other 3 columns registering as null-free possess information that exists for every menu. Whether the data is collected automatically, through code, or input by transcribers, each menu will always contain a location for the meal as well as an exact number of pages and dishes included.

#### Removing Columns Based on Missing Data
It may be reasonable to assume that columns containing a majority of (or entirely) null values would not be useful for displaying in a final dataset used for analysis. Therefore, it is possible to remove all columns where a certain percentage or more of the entries within contain nulls. Pandas has a built-in function `df.dropna()` which will remove missing values from columns or rows.

For the purposes of this tutorial, let's assume we want to keep all columns where less than 25% of the data are nulls. We might make this decision for a number of reasons. If, out of over 17,000 entries, every cell in a column has been left blank, it is clear that column information was either universally not found or ultimately not presented to researchers performing the transcription in the user interface. Therefore, it would be unhelpful to continue to use those columns and their headers in further analysis. Additionally, it is clear from our research questions that we mostly are concerned with events, dates, and the contents of each menu. While the `event`, `venue`, and `place` columns contain a large amount of null values, the data contained is still potentially useful to our research question involving event types and menu items.

To identify which columns we would like to keep, we will create a new variable called `menu`. The function to be added to your Python file is as follows:

```
menu = df.dropna(thresh=df.shape[0]*0.25,how='all',axis=1)
```

The `thresh` parameter within the `df.dropna()` function allows you to specify either a given amount or a percentage of rows that meet your criteria, in this case 0.25 or 25%. By specifying `how='all'`, you are indicating you wish to drop the entire column. In addition, as stated previously, `axis=1` informs the program that we specifically are looking at columns.

By using the `.shape` function, this time adding `print(menu.shape)` in your Python file, the result of `(17545, 9)` is returned and we are able to see that only 9 columns remain. To check which columns remain, simply add `print(menu.columns)` to your file and run it with `python nypl-menu.py` to see

```
Index(['id', 'sponsor', 'event', 'venue', 'place', 'date', 'location',
       'page_count', 'dish_count'],
      dtype='object')
```

that the `name`, `occasion`, `keywords`, `language`, and `location_type` columns are now gone. At this point, your Python file should contain the following code:

```
import pandas as pd

df = pd.read_csv("Menu.csv")
print(df.head())

print(df.columns)

dropped_col = ['notes', 'call_number', 'currency', 'currency_symbol', 'physical_description', 'status']
df.drop(dropped_col, inplace=True, axis=1)

print(df.shape)

print(df[df.duplicated(keep=False)])

df.drop_duplicates(inplace=True)

print(df.shape)

print(df.isnull().sum())

menu = df.dropna(thresh=df.shape[0]*0.25,how='all',axis=1)

print(menu.shape)

print(menu.columns)
```

#### Removing Rows with Missing Data
While the columns have been dealt with, there still are records within our dataset that contain null values. In the case of this specific dataset, those rows containing a large number of nulls may be for menus not yet transcribed. Depending on the type of analysis in which you wish to engage and whether you wish to capture nulls, it is not always necessary to remove all records containing missing information. If nulls were important to our research, if we were interested in exploring whether there is a pattern between which types of events did or did not possess dates, we might wish to keep rows that include null values in the date column.

However, should you wish to remove all rows that contain any null values within them so you have a dataset with only complete data, you would utilize the following function:

```
print(menu.dropna())
```

Once the code is saved in the Python file and run in the command line or terminal using `python nypl-menu.py`, you now see that our dataset has shrunk from 17,545 to 7,236 rows, leaving only the rows that contain full information. The output appears as follows:

```
          id                                            sponsor  ... page_count dish_count
0      12463                                      HOTEL EASTMAN  ...          2         67
1      12464                                   REPUBLICAN HOUSE  ...          2         34
2      12465                         NORDDEUTSCHER LLOYD BREMEN  ...          2         84
3      12466                         NORDDEUTSCHER LLOYD BREMEN  ...          2         63
4      12467                         NORDDEUTSCHER LLOYD BREMEN  ...          4         33
...      ...                                                ...  ...        ...        ...
10212  27695  CONFRERIE DE LA CHAINE DES ROTISSEURS, NEW ORL...  ...          5         37
10213  27696  CONFRERIE DE LA CHAINE DES ROTISSEURS, GEORGIA...  ...          3         22
10214  27697                                  FRANKFURTER STUBB  ...          3         34
10215  27698                             HOTEL EUROPAISCHER HOF  ...          1         31

[7236 rows x 9 columns]
```

It is important to note that the function `df.dropna()` does not permanently remove any rows in your dataset. Should you now run `print(menu.shape)` again, you will see that your dataset still consists of 17,545 rows. The number of columns present will remain as 9, however, because we saved our first `df.dropna()` function in the "Removing Columns" section to the new variable, `menu`.

Now, your Python file should contain the following code:

```
import pandas as pd

df = pd.read_csv("Menu.csv")
print(df.head())

print(df.columns)

dropped_col = ['notes', 'call_number', 'currency', 'currency_symbol', 'physical_description', 'status']
df.drop(dropped_col, inplace=True, axis=1)

print(df.shape)

print(df[df.duplicated(keep=False)])

df.drop_duplicates(inplace=True)

print(df.shape)

print(df.isnull().sum())

menu = df.dropna(thresh=df.shape[0]*0.25,how='all',axis=1)

print(menu.shape)

print(menu.columns)

print(menu.dropna())
```

### Dealing with Dates
Dates and datetimes are one of the most difficult data types to handle regarding cleaning, particularly if the data being collected is crowdsourced. This is one of the areas where possessing strict submission guidelines can improve overall data quality and cut down on the time and effort it takes to clean your data. With one of the research questions focusing on exploring the length of menus correlating to the time of year, it is important that your date column can be properly and easily parsed in preparation for analysis, a process that is not always simple.

Depending on where you are in the world, dates are not always depicted the same. In the United States, it is common to indicate month/day/year, while in other parts of the world it could be day/month/year or even year/month/day. In addition, how people input dates might vary from person to person. Listed below are a variety of different ways someone can communicate the same date:

* January 8, 1970
* Jan 8, 1970
* 8 January 1970
* 1/8/1970
* 01/08/1970
* 1970-01-08
* Jan-08-1970

In addition, dates represented only as numbers possess an element of uncertainty. After all, does 1970-01-08 refer to the 8th of January or the 1st of August in the year 1970?

To offset this ambiguity, it should be recommended to require date- or time-based data entry to conform to a standard format, such as [ISO 8601](https://www.w3.org/TR/NOTE-datetime-970915). This potentially can be enforced during data entry by using underlying conditional code, such as regular expressions, to validate whether the data entered fits the required format.

#### Converting Datatype to Date
Once in a determined format, pandas possesses a function that can assist in date cleanup. If the dates in question show are in a standardized specific order, the function `to_datetime()` can be used. This function will convert the `date` column from an object datatype (meaning that the contents within the column consist of either text or numeric and non-numeric values) to a datetime (meaning that the contents within the column consist of specifically formatted date and time values) datatype. Further [documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.to_datetime.html) specifies how to customize this function based on the unique date formats present in your dataset.

While powerful, this function also is potentially limiting, as the pandas library only recognizes dates within a [given period of time](http://pandas-docs.github.io/pandas-docs-travis/user_guide/timeseries.html#timestamp-limitations). Due to how the datetime timestamps are calculated within the built-in function, pandas can only account for a timespan of approximately 584 years, with the minimum date being in the year 1677 and the maximum date being in the future, in the year 2262. Any dates outside this timeframe will produce an error. Therefore, for historically-based datasets with dates prior to 1677, the pandas library would not be an appropriate way to approach dealing with this conversion. An example of another way to approach date data cleaning would include using [regular expressions](https://www.oreilly.com/library/view/regular-expressions-cookbook/9781449327453/ch04s04.html).

Because of this limitation, any data entry errors related to the date would produce an error when the function is run. Our dataset contains several such errors. An example of this would be entry number 13112, where the date is entered as `0190-03-06`. This is most likely an example of an input error, not uncommon for transcription due to human mistake. This error is caught when entering the following code in your Python file and running it to convert the column datatype to date:

```
menu['date'] = pd.to_datetime(menu['date'], dayfirst = False, yearfirst = False)
```

This line of code specifies that we alter the `date` column in our dataframe by converting it to a datetime datatype. The specifications `dayfirst = False` and `yearfirst = False` are used to let the program know that our date formats are not standardized and that either the day or the year might appear first in our dataset. However, when run, our code will produce an error.

The error produced by this code will read `pandas._libs.tslibs.np_datetime.OutOfBoundsDatetime: Out of bounds nanosecond timestamp: 190-03-06 00:00:00`. The function has picked up on our out-of-range date and therefore has not completed converting the column into a datetime format.

While we then are able to programmatically find that date and replace it, this is an unreasonable approach for datasets containing a large amount of input errors. Enforcing guidelines upon data entry would be the best way to circumvent such an error from occurring in the first place. Should you decide to use pandas to implement the data cleaning process, requirements would involve ensuring that the dates being entered fall within pandas datetime range.

Once you have converted the column datatype to datetime, you would be able to run a series of other functions, such as checking to see whether all dates fall within the NYPL's specified range (1840s-present).

Finally, at the end of this lesson, your Python file should contain the following code:

```
import pandas as pd

df = pd.read_csv("Menu.csv")
print(df.head())

print(df.columns)

dropped_col = ['notes', 'call_number', 'currency', 'currency_symbol', 'physical_description', 'status']
df.drop(dropped_col, inplace=True, axis=1)

print(df.shape)

print(df[df.duplicated(keep=False)])

df.drop_duplicates(inplace=True)

print(df.shape)

print(df.isnull().sum())

menu = df.dropna(thresh=df.shape[0]*0.25,how='all',axis=1)

print(menu.shape)

print(menu.columns)

print(menu.dropna())

menu['date'] = pd.to_datetime(menu['date'], dayfirst = False, yearfirst = False)
```

## Conclusion
The process of cleaning your data is not always simple. Often with humanities data, the procedures used for cleaning in the social or natural sciences does not apply. In their piece, ["Against Cleaning"](http://curatingmenus.org/articles/against-cleaning/), authors Katie Rawson and Trevor Muñoz discuss what makes "cleaning" the NYPL menu datasets difficult. For instance, there were changes in spelling of different foods over time as well as various ways dishes and drinks were referenced, to properly reflect their period. To "clean" that data, to normalize it, essentially would diminish the historical context. In addition, as the authors discovered, it proved complex to distinguish "which variants in the names of dishes revealed new information (they) should account for in (their) own data, and which variants were simply accidents of transcription or typesetting." Methods typically employed to clean one's data no longer applied.

While collecting data through crowdsourced means can be a highly efficient tactic, cleaning humanities data can be a complicated task. In the case of Rawson and Muñoz, they found that even the concept of "data cleaning" no longer was accurate and the process could not be completed using the "usual" methods. Humanities data is unique. It is diverse. It is complex. And, in many cases, historical context is vital. While many techniques for cleaning, or even transcribing, can be carried out programmatically, computers are unable to provide or interpret the unique situations with ease. As discussed by Rawson and Muñoz, variability is not always a bad thing; it does not constitute as inherently "messy" but rather a diversity that should be preserved. Variability will be encountered, especially when data is crowdsourced. However, it is ultimately up to you to determine whether common cleaning practices are appropriate for your dataset as well as for the research questions you aim to explore.

## Lesson Inspiration
This tutorial was inspired by a project performed by the author as a graduate student in 2018 at the University of Illinois' School of Information Sciences. The author, partnered with peers Daria Orlowska and Yuerong Hu, explored different ways of cleaning all four of the NYPL Historical Menus datasets. This tutorial expands on that project and further discusses crowdsourcing techniques.
