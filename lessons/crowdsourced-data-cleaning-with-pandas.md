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

# Overview
Crowdsourcing is a way of outsourcing work by utilizing the input and contributions of people through an online platform. It is a way of collecting ideas, receiving input, or gathering data from the masses, the proverbial "crowd." There are [many reasons](https://link.springer.com/article/10.1007/s10796-015-9578-x) a project may choose to enlist crowdsourcing as a method to gather data and input. By using crowdsourcing, you enlist a diverse group of individuals, all with different skillsets and strengths. Crowdsourcing can be used for idea generation or even for data collection and text transcription or translation. Projects of this nature are increasing as organizations such as libraries strive to make their collections accessible online.

Data can be messy, especially when projects are crowdsourced. Even with the most rigorous submission guidelines, data collected in this manner inevitably contain variability. Working within Python and the pandas library with a dataset from the New York Public Library, you will learn the fundamentals of data cleaning and identify common issues when utilizing crowdsourced data.

At the end of the lesson you will:
  
* Understand challenges specific to working with crowdsourced data
* Demonstrate how to programmatically implement common data cleaning techniques
* Use pandas to remove unnecessary columns and organize your data

## Why use crowdsourcing?
In recent years, large-scale projects such as the [Squirrel Census](https://www.thesquirrelcensus.com/about) have been developed. In this example, a team of over 300 volunteers participated in research and data collection on Central Park's population of Eastern gray squirrels. International projects, such as [Penguin Watch](https://www.zooniverse.org/projects/penguintom79/penguin-watch), have come to fruition, as well. Members of the public classify different images of penguins to help identify environmental threats. These both represent instances where data is collected and analyzed on a massive scale and public assistance is necessary for completion.

While computation and programming methods are incredibly powerful, some jobs are only possible through human involvement.

### Things to consider...
When determining whether crowdsourcing a project is the best option for you, [consider these different factors](https://www.liberquarterly.eu/articles/10.18352/lq.9948/):

1. **What should you crowdsource?** There are many tasks such as data entry, data classification, transcription, or the brainstorming and collection of ideas that can be crowdsourced easily to individuals around the globe. Many minds with different ideas and skillsets can provide an effective way to approach tackling a specific endeavor.

2. **The scale of work.** Crowdsourced projects work best when there are smaller pieces that individuals can address on their own. Is this possible for the type of project in which you are invested?

3. **Does the work outweigh the benefits?** While useful and potentially cost-effective to outsource smaller projects and items to many individuals, you still need to spend time on your end compiling the collected information and, in many cases, cleaning the data. Depending on the scale of your project, this could be a massive undertaking and not always lead to people spending their time productively. As referenced in [Simper's article](https://www.liberquarterly.eu/articles/10.18352/lq.9948/), Google [announced a call](https://googleblog.blogspot.com/2009/09/announcing-project-10100-idea-themes.html) asking for public proposals. While receiving over 150,000 submissions, causing a long delay in response to individuals, only 16 projects were chosen for further consideration.

### Guidelines
When deciding to collect data using crowdsourcing methods, there are several things to keep in mind and guidelines to examine:

1. **Clarity:** The volunteers carrying out the crowdsourced tasks need to know their responsibilities. For projects focused more on idea generation, this might appear as guidelines, prompts, or questions. For data entry, transcription, or more by-the-book tasks, volunteers need to know exactly what they are being asked to submit (see Submission Guidelines below) and how. It is important for volunteers to know that their efforts actually are being utilized and are significant for the project at hand. This means including not just a description of the overall research being carried out but also why they are being asked for their assistance, what skills they can uniquely contribute that would lead to the success of the project.

2. **Manpower:** While outsourcing tasks and elements of projects potentially can be more efficient, there still is much work and effort that goes into carrying out crowdsourced research. People on the backend still need to review the information submitted. Even if done programmatically through processes such as data cleaning or analysis, time and additional manpower still is allocated to ensure everything is accurate. On large-scale projects, this can be quite the undertaking, and it is important to keep timelines for project advancement and completion realistic. 

    1. **Quality control:** Because there are more people handling, processing, or transcribing information in crowdsourced projects, it is imperative to direct a sufficent amount of manpower towards quality control. This is where familiarization with your data and the development of a data cleaning plan ahead of time will circumvent a headache. Step-by-step documentation or an automated process to compile, sort, and clean submitted data and information will help save time and expense in addition to contributing to better data management.

3. **Submission guidelines:**
    - **Naming conventions** - When working with data involving names, whether that be names of people or of organizations, you must specify how those names are expected to be written. Even Wikipedia, an organization that can be said to be built on the idea of using crowdsourcing to collect reference information, has [clearly stated guidelines](https://en.wikipedia.org/wiki/Wikipedia:Naming_conventions_(people)) for how names are meant to appear on their website and what to do when names do not fit the usual format. Naming conventions become particularly muddy when dealing with prefixes, suffixes, and titles. Regardless of how you choose to outline your naming guidelines, you should be clear on what you expect from those entering the information.
    - **Dates and times** - As referenced later in this lesson, dates and times can be written in a variety of ways depending on who you are or where you are in the world. While all conveying the same information to the human eye, dealing with differing date formats can be a headache for data cleaning purposes. Enforcing a specific date-time format, such as [ISO 8601](https://www.w3.org/TR/NOTE-datetime-970915), is recommended to standardize data entry.
    - **Special characters** - It is important to be clear, particularly when requiring data entry, whether special characters will be accepted. Special characters encode differently and can potentially cause difficulties when attempting to clean data. If not accepted, there are ways to restrict this during the entry phase, using regular expressions or other tools to force the validation of the entered phrases.
    - **Other guidelines** - Guidelines for submission can become increasingly specific. From how to format numbers to only allowing the use of specific punctuation, you can request volunteers adhere to many different criteria. However, no matter how strict your guidelines or your submission protocols, variability inevitably will be present in your collected data. That being said, there are ways to identify and normalize those instances.
    
## The New York Public Library (NYPL) Historical Menu Dataset
The NYPL possesses a digitized collection of approximately 45,000 menus, dating from the 1840s to today. This collection is made public through [What's on the menu?](http://menus.nypl.org/). Rather than relying on optical character recognition (OCR), a way of programmatically reading hand-written or printed documents into machine-searchable text, NYPL crowdsources transcription of the collection. This is due to the wide variation of handwritten text and complex fonts that make writing a universal code very difficult. Even if a universal code could be developed, the NYPL determined several aspects of each menu that could only be differentiable to the human eye.

Generated twice a month and available for public download, *What’s on the menu?* provides access to four distinct related datasets. While the one we will be utilizing during this tutorial lists each menu, including information about venues as well as dates, the other datasets are relational and focus on different elements of each menu. 

The `Dish.csv` dataset contains a list of each unique menu item, detailing how many times each dish appears across the collection, the years they first and last appear, and information about high and low prices. A dataset such as this would enable historians to analyze the popularity of different foods as well as their prospective prices over time. `MenuItem.csv`, the largest dataset in the bunch, uses the food IDs created in `Dish.csv` and relates them to their associated menus based on which page they appear. The third dataset, `MenuPage.csv`, connects the individual menu IDs created in `Menu.csv` with the page IDs from `MenuItem.csv` (the final dataset), ensuring that each dish and related page is linked with the correct menu. Viewed together, this group of datasets paints a unique and specific picture of history, centered around what people ate.

For the purposes of this tutorial, we will be cleaning the main dataset, [Menu.csv](/assets/crowdsourced-data-cleaning-with-pandas/Menu.csv). This dataset consists of 20 columns containing text, numbers, as well as dates, in addition to 17,546 rows, one for each menu currently or previously transcribed. This dataset contains information on completed transcriptions as well as ones still in process. A single row was added to the dataset by the author of this tutorial to simulate duplicate data.

Using the Python library, pandas, we will review how to:

* Remove unnecessary columns
* Find rows with missing data
* Identify and remove duplicate data
* Understand the complexity of dates

# Getting Started

## Prerequisites
This tutorial can be followed regardless of operating system. This tutorial was written using Python 3.7.4 as well as pandas version 0.25.1. Should you be working in Python 2 or have no previous experience working with Python, you will need to create a virtual Python 3 environment. Information on creating a virtual Python 3 environment can be found in another Programming Historian lesson, [Visualizing Data with Bokeh and Pandas](https://programminghistorian.org/en/lessons/visualizing-with-bokeh#creating-a-python-3-virtual-environment).

To install this specific version of pandas, use the following code:

```
pip install pandas==0.25.1
```

This tutorial assumes familiarity with the concept of data cleaning or tidy data.

## Why Pandas?
Pandas is a popular and powerful package used in Python communities for data manipulation and analysis. Pandas is capable of reading in and writing out a number of [different file types](https://pandas.pydata.org/pandas-docs/stable/user_guide/io.html), such as CSV, JSON, Excel, and Stata files.

# Exploring the NYPL Historical Menu Dataset

## Importing Packages and Reading Files
To begin, we will import the pandas package and load in our data. It is important to note that frequently, the pandas library is abbreviated as *pd*, including in the [official documentation](https://pandas.pydata.org/pandas-docs/stable/getting_started/index.html#getting-started).

```
import pandas as pd

df = pd.read_csv("Menu.csv")
df.head()
```

To "read in" our data, we will be calling in the `read_csv()` function, which will load our data into a pandas `DataFrame`, often abbreviated to *df*. The *df* essentially holds the columns and rows of our dataset. For this tutorial and keeping with convention, we will be using *df* to describe our DataFrame.

It is good practice to view the data just after reading it in to ensure that it read in properly and did so in the manner you were anticipating. While you are able to view the whole dataset, the function `df.head()` will allow you to view only the first five rows of your dataset.


## Removing Columns
After reading in a new file, it is helpful to learn a bit about your data. By running the function

```
df.columns 
```

we are able to see what columns are represented in the dataset (output below): 

```
Index(['id', 'name', 'sponsor', 'event', 'venue', 'place',
       'physical_description', 'occasion', 'notes', 'call_number', 'keywords',
       'language', 'date', 'location', 'location_type', 'currency',
       'currency_symbol', 'status', 'page_count', 'dish_count'],
      dtype='object')
```

This is a larger dataset, consisting of 20 columns total. At first glance, you may be able to determine which columns are unnecessary for future analysis.

For the purposes of this tutorial, let's say we want to remove any columns related to library-usage as well as any columns related to currency. To do this, we will create a variable (`dropped_col`) containing the columns we would like to remove. This variable is then passed to the `drop()` function, a built-in function in the pandas library that allows you to remove indicated columns or rows. By indicating that `inplace=True`, we are stating that we do not want a copy of the object, i.e. the columns, to be returned. In addition, `axis=1` informs the program that we are specifically looking at columns. This would be written as:

```
dropped_col = ['notes', 'call_number', 'currency', 'currency_symbol']
df.drop(dropped_col, inplace=True, axis=1)
```

No results will be returned, but by inputting

```
df.shape
```

we can see that our dataset now consists of 16 rows.

## Duplicates
On occasion, despite rigorous submission guidelines, duplicate data can slip into a final dataset. The statement

```
df[df.duplicated(keep=False)]
```

will identify any duplicate rows within your dataset. By indicating `keep=False`, we are creating a Boolean that will mark every duplicate as `True`, which will return any duplicate rows. 

The output (below), will display two duplicate rows:

```
id	name	sponsor	event	venue	place	physical_description	occasion	keywords	language	date	location	location_type	status	page_count	dish_count
12463	NaN	HOTEL EASTMAN	BREAKFAST	COMMERCIAL	HOT SPRINGS, AR	CARD; 4.75X7.5;	EASTER;	NaN	NaN	4/15/1900	Hotel Eastman	NaN	complete	2	67
12463	NaN	HOTEL EASTMAN	BREAKFAST	COMMERCIAL	HOT SPRINGS, AR	CARD; 4.75X7.5;	EASTER;	NaN	NaN	4/15/1900	Hotel Eastman	NaN	complete	2	67
```

It is possible to search for duplicates within specific columns, as well. For instance, if you were checking to see whether there were any duplicates in the ID column, as IDs are meant to be unique, you would use `df[df.duplicated(subset='id', keep=False)]`.

Once duplicate data are identified, it is only a matter of removing them from your dataset. The pandas built-in function `drop_duplicates` can be used to delete any duplicate rows.

```
df.drop_duplicates(inplace=True)
```

By indicating `inplace=True`, you ensure that you are keeping at least one of the duplicate entries in your final dataset.

## Missing Data
As stated previously, this dataset contains entries both completed as well as ones currently in progress. This means that there are records in our dataset that contain missing information. Cells where no information, including whitespace, is present is known as a `null value`. 

It is useful to see which columns in your dataset contain null values.

```
df.isnull().sum()
```

The results shown from this code, below, indicate that only 5 columns of our dataset are null-free: id, location, status, page_count, and dish_count. The other columns contain as few nulls as 586 or as many as the entire column.

```
id                          0
name                    14348
sponsor                  1561
event                    9391
venue                    9426
place                    9422
physical_description     2782
occasion                13754
keywords                17545
language                17545
date                      586
location                    0
location_type           17545
status                      0
page_count                  0
dish_count                  0
dtype: int64
```

### Removing Columns Based on Missing Data
It may be reasonable to assume that columns containing a majority of (or entirely) null values would not be useful for displaying in a final dataset used for analysis. Therefore, it is possible to remove all columns where a certain percentage or more of the entries within contain nulls. Pandas has a built-in function `df.dropna()` which will remove missing values from columns or rows.

For the purposes of this tutorial, let's assume we want to remove all columns where over 50% of the data contained possess nulls. The `thresh` parameter within the `df.dropna()` function allows you to specify either a given amount or a percentage of rows that meet your criteria, in this case 0.5 or 50%. By specifying `how='all'`, you are indicating you wish to drop the entire column. In addition, as stated previously, `axis=1` informs the program that we specifically are looking at columns.

```
menu = df.dropna(thresh=df.shape[0]*0.5,how='all',axis=1)
```

By using the `.shape` function again, we are able to see that only 8 columns remain.

### Removing Rows with Missing Data
While the columns have been dealt with, there still are records within our dataset that contain null values. In the case of this specific dataset, those rows containing a large amount of nulls may be for menus not yet transcribed. Depending on the type of analysis in which you wish to engage and whether you wish to capture nulls, it is not always necessary to remove all records containing missing information.

However, should you wish, to remove all rows that possess any null values within them, you would utilize the following function:

```
menu.dropna()
```

Once the code is run, you now see that our dataset has shrunk from 17,545 to 14,189 rows, leaving only the rows that contain full information. The first five rows appear as follows:

```
id	    sponsor	                      physical_description	      date	    location	                   status	page_count	dish_count
12463	  HOTEL EASTMAN	                  CARD; 4.75X7.5;	          4/15/1900	  Hotel Eastman	                 complete	2	          67
12464	  REPUBLICAN HOUSE	          CARD; ILLUS; COL; 7.0X9.0;	  4/15/1900	  Republican House	         complete	2	          34
12465	  NORDDEUTSCHER LLOYD BREMEN	  CARD; ILLU; COL; 5.5X8.0;	  4/16/1900	  Norddeutscher Lloyd Bremen	 complete	2	          84
12466	  NORDDEUTSCHER LLOYD BREMEN	  CARD; ILLU; COL; 5.5X8.0;	  4/16/1900	  Norddeutscher Lloyd Bremen	 complete	2	          63
12467	  NORDDEUTSCHER LLOYD BREMEN	  FOLDER; ILLU; COL; 5.5X7.5;	  4/16/1900	  Norddeutscher Lloyd Bremen	 complete	4	          33
```

## Dealing with Dates
Dates and datetimes are one of the most difficult data types to handle regarding cleaning, particularly if the data being collected is crowdsourced. This is one of the areas where possessing strict submission guidelines can improve overall data quality and cut down on the time and effort it takes to clean your data.

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

### Converting Datatype to Date
Once in a determined format, pandas possesses a function that can assist in date cleanup. If the dates in question possess a standardized specific order, the function `to_datetime()` can be used. This function will convert the *date* column from an object datatype to a date. Further [documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.to_datetime.html) specifies how to customize this function based on the unique date formats present in your dataset.

While powerful, this function also is potentially limiting, as the pandas library only recognizes dates within a [given period of time](http://pandas-docs.github.io/pandas-docs-travis/user_guide/timeseries.html#timestamp-limitations).

Once the datatype is converted, you would be able to run a series of other functions, such as checking to see whether all dates fall within the NYPL's specified range (1840s-present).

# Lesson Inspiration
This tutorial was inspired by a project performed by the author as a graduate student in 2018 at the University of Illinois' School of Information Sciences. The author, partnered with peers Daria Orlowska and Yuerong Hu, explored different ways of cleaning all 4 of the NYPL Historical Menus datasets. This tutorial expands on that project and further discusses crowdsourcing techniques.
