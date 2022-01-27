---
title: |
    Wrangling Museum Collection Data with Pandas
authors:
- Richard Palmer
date: 2017-10-01
reviewers:
- Brandon Walsh
layout: lesson
---

# Wrangling Museum Collection Data with Pandas

## Assumptions

This lesson assumes you have access to a machine that you can run a Unix/Linux shell commands on and that you have permissions to install Python packages. Having a background in another programming language would also be helpful. If you need a place to start, I also recommend working through the Programming Historian’s excellent Python tutorials.

## Lesson Goals

  * Understanding the collection datasets made available by museums and the different ways they can be accessed programmatically (API, bulk download, GitHub)
  * A quick look at data tidying and how you can use Pandas to clean up a dataset
  * Understanding basic data analysis functionality available in Pandas and the art of wrangling data from museum datasets using it
  * Learning how to be a data detective exploring and comparing museum collection datasets 

## Introduction

Museums have been making their collections available online since the early days of the world wide web. This has taken three main forms. In the 1990s museum websites presented a subset (often 'highlight' objects) of their collection with accompanying images and some of the object's collection record data (supplied from an internal collection management system). This content was intended to be read by people, not programmes, and so was not easy for use with data analysis tools (although web scraping can sometimes retrieve the data). This form has developed over time from only providing a subset of the collections to now providing an entire museum collection viewable online.

The next form taken in the 2000s was providing APIs which allows for the programmatic querying of museum collection data to select data from objects matching a particular filter/query. This allows for dynamic subsets of data to be retrieved; this can then be combined with other datasets to run investigations, comparisons, visualisations, etc, between them, a starting point for 'distant reading' of collections data. However, the types of filtering/querying allowed is fixed by the API, so for example you may only be able to search on some of an objects fields, or you might not be able to combine filters together or retrieve more than a certain number of results. The resulting dataset is also often provided in a custom data format specific to that museum (based on how the data was catalogued in the collection management system).

The latest form in the 2010s has been full access to the collection data via compressed files containing the entire dataset (or broken down into subsets by department, object type, time period, etc). These can be downloaded from the institutions website or some versioning system such as GitHub. This allows for bulk download of the museum's collection data, from which the user can then perform the filtering/querying on the dataset as they wish using data analysis tools, without being constrained by the limits of an API. (The data initially remains in a custom format although could be converted by the user) 

The coming form for providing online collections data is expected to be the implementation of linked data to describe collections using standard vocabularies and identifiers shared across institutions, allowing for easier comparisons between datasets. This form has been desired for some time and whilst much underpinning work has been done on it, reliable and usable implementations have taken some time to develop. 

This tutorial will introduce you to accessing collections data an API and via direct access to datasets from three different museums & galleries (each with their own data formats):

  * Museum of Modern Art (MoMa), New York
  * Victoria & Albert Museum, London
  * Tate Collection (London, Liverpool, Cornwall)
  
Once we have found how we can retrieve this data we need some way to be able to explore and analyse it. There are many tools available for this, but for lesson we will be making using of Pandas.

## Pandas: A Quick Introduction

To quote from the [website](http://pandas.pydata.org/):

   pandas is an open source, BSD-licensed library providing high-performance, easy-to-use data structures and data analysis tools for the Python programming language.


## Pandas - The Bare Essentials

Data (in whatever state, we can worrying about tidying data later) is loaded into Pandas and is then made accessible as an array in one of two structures. These structures can either be a 1-dimensional 'Series' (consisting of one index column and one data column) or a 2-dimensional 'DataFrame' (consisting of multiple columns, possibly with multiple index columns). 

Most of Pandas' functionality consists of built in operations that let you manipulate, transform, or map your data stored these structures, producing as an output from an operation either a new Series/DataFrame or a modification of an existing DataFrame (of course, if the operation adds a second column to a Series structure we have automatically turned it into a DataFrame, as a Series structure only has one column). 

By running a series of operations on your input data, you can tidy up your data; run data analysis operations on it; export it in a different structure; visualise it in interesting ways; and archive it in the formats such as HDF for future speedy retrieval (without having to read it in again from the original data format and transform it) or use the Feathers format for data interchange with the [R](https://programminghistorian.org/lessons/basic-text-processing-in-r) statistical computing language. 

### Getting Setup

Comprehensive installation details are available from the Pandas [site](http://pandas.pydata.org/getpandas.html). For Python users, installation in a virtualenv using pip is recommended, assuming its supporting libraries are installed.

## Running Pandas

Once installed, pandas is imported in a python session or script as follows:


```python
import pandas as pd
```

You many also need to refer to some values made available by the numpy library used
by pandas, so it may be useful to import this:

```python
import numpy as np
```

## Reading in data

So now we have a data analysis library ready for use, we need some data to analyse. Let's start by using an API to retrieve some; in this case the Victoria & Albert Museum Collections [API](http://www.vam.ac.uk/api/) which allows us to search for a keyword and returns summary object information for those objects whose fields match. The results will be returned in JSON in a custom structure, so we first need to convert this into CSV to load it into Pandas:

```
curl -s http://www.vam.ac.uk/api/json/museumobject/search?q=pandas | jq -r '["id", "object", "title", "artist", "year_start", "place"], (.records[].fields | [.object_number,.object,.title,.artist,.year_start,.place]) | @csv' > pandas.csv
```

The above Unix shell command runs a API query for 'panda' related objects in the collections, which returns 10 matching records in JSON format (in its custom data structure). This data is then piped into the jq utility which converts the records into a standard CSV format for reading into Pandas (for more on this, see Matthew Lincoln's excellent introduction to [reshaping JSON & using JQ](http://programminghistorian.github.io/ph-submissions/lessons/json-and-jq.html) ) In this case, we instruct jq to pull out the fields 'object_number', 'object', 'title', 'artist', 'year_start' and 'place' from each object record. We also instruct jq to add the following column headers to the CSV file, which will aid Pandas in labeling the data when it reads it in:

```
id,object,title,artist,year_start,place
...
```

Pandas can read files in other format, but CSV tends to be the _'lingua franca_' of data analysis (what other data formats have a conference dedicated to them!).

Now let's try reading into Pandas our CSV file (with the headers and data) that we've created. You will notice we often give the variable a name including 'df', this helps us track which variables are DataFrames.


```python
df_objects = pd.read_csv("pandas.csv")
```

If the first line of your CSV file doesn't contain column headers, you can tell pandas this:


```python
df_objects = pd.read_csv("pandas.csv", header=None)
```

otherwise it will "eat" the first line of data and use it as column names. You can also set the headers yourself:


```python
df_objects = pd.read_csv("pandas.csv", names=['id','Object','Title','Artist','ProductionDateEarliest','Place'])
```

That should have worked without any output. If Pandas couldn't parse the CSV file it will tell you what caused the parse error.

We've saved the results of reading in the file into a DataFrame called df_objects. By default Pandas will create a DataFrame to store the data. As you will recall this is formed of one or more index columns (with an index either set by the user otherwise Pandas will create an automatically assigned incremental identifier (0, 1, 2, 3, etc) index) and one or more data columns. If the CSV file only contained one index column and one data column, we could use a Series structure instead by passing the squeeze argument, for example:

curl -s http://www.vam.ac.uk/api/json/museumobject/search?q=pandas | jq -r '["id", "artist"], (.records[].fields | [.object_number,.artist]) | @csv' > pandas-artist.csv

    series_artists = pd.read_csv("pandas-artist.csv", squeeze=True)

Later on we could turn that into a DataFrame if we now wanted this with:

    df_artists = pd.DataFrame(series_artists)


# Basic Operations

So now Pandas has read our data in, we can start to perform data operations on it. Let's go through some basics, starting with asking Pandas to tell us what it already knows about the size of the data:


```python
len(df_objects)
```

    10

or we can get some more detailed information:

```python
df_objects.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 10 entries, 0 to 9
    Data columns (total 6 columns):
    id            10 non-null object
    object        10 non-null object
    title         6 non-null object
    artist        10 non-null object
    year_start    0 non-null float64
    place         10 non-null object
    dtypes: float64(1), object(5)
    memory usage: 560.0+ bytes


```python
df_objects.shape
```

    (10, 6)

Which all tells us, as we would expect, Panda has found 6 columns (id, object, title, artist, year_start, place) and 10 data rows 

So, now we know Pandas has read the data in. Let's take a quick look at some of it.

The head() & tail() function work much like you would expect (especially if you are used to the Unix equivalents). They return (by default 5) rows of the data:


```python
df_objects.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>object</th>
      <th>title</th>
      <th>artist</th>
      <th>year_start</th>
      <th>place</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>O26744</td>
      <td>Card game</td>
      <td>pandas' party</td>
      <td>Unknown</td>
      <td>NaN</td>
      <td>England</td>
    </tr>
    <tr>
      <th>1</th>
      <td>O49687</td>
      <td>Set of soft toy pandas</td>
      <td>NaN</td>
      <td>Fiat</td>
      <td>NaN</td>
      <td>Asia</td>
    </tr>
    <tr>
      <th>2</th>
      <td>O1160896</td>
      <td>Sculpture</td>
      <td>Bruised</td>
      <td>Ji Ji</td>
      <td>NaN</td>
      <td>Shanghai</td>
    </tr>
    <tr>
      <th>3</th>
      <td>O1177173</td>
      <td>Sculpture</td>
      <td>Angry</td>
      <td>Ji Ji</td>
      <td>NaN</td>
      <td>Shanghai</td>
    </tr>
    <tr>
      <th>4</th>
      <td>O1363217</td>
      <td>Teddy bear</td>
      <td>Panda</td>
      <td>unknown</td>
      <td>NaN</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_objects.tail(3)
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>object</th>
      <th>title</th>
      <th>artist</th>
      <th>year_start</th>
      <th>place</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>7</th>
      <td>O1193257</td>
      <td>birthday cards</td>
      <td>NaN</td>
      <td>Hallmark Cards</td>
      <td>NaN</td>
      <td>Great Britain</td>
    </tr>
    <tr>
      <th>8</th>
      <td>O1152697</td>
      <td>Teddy bear</td>
      <td>NaN</td>
      <td>Schuco</td>
      <td>NaN</td>
      <td>Germany</td>
    </tr>
    <tr>
      <th>9</th>
      <td>O107238</td>
      <td>Print</td>
      <td>Slottizoo Panda</td>
      <td>Richards, Clifford</td>
      <td>NaN</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>



Or we can show a slice of the data by giving a range, for example to see rows 2 & 3:


```python
df_objects[2:4]
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>object</th>
      <th>title</th>
      <th>artist</th>
      <th>year_start</th>
      <th>place</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2</th>
      <td>O1160896</td>
      <td>Sculpture</td>
      <td>Bruised</td>
      <td>Ji Ji</td>
      <td>NaN</td>
      <td>Shanghai</td>
    </tr>
    <tr>
      <th>3</th>
      <td>O1177173</td>
      <td>Sculpture</td>
      <td>Angry</td>
      <td>Ji Ji</td>
      <td>NaN</td>
      <td>Shanghai</td>
    </tr>
  </tbody>
</table>
</div>



or slicing by a column across all rows


```python
df_objects['title']
```




    0      pandas' party
    1                NaN
    2            Bruised
    3              Angry
    4              Panda
    5           Jingjing
    6                NaN
    7                NaN
    8                NaN
    9    Slottizoo Panda
    Name: title, dtype: object



We can combine these slicing operations to pull out a particular column ('title') for a range of rows (3,4):


```python
df_objects['title'][3:5]
```


    3    Angry
    4    Panda
    Name: title, dtype: object



You will notice that all of the columns from the CSV file have been set as data columns, so the index column is created by Pandas as an incremental number from 0. We can set a different index column in various ways, at CSV reading time:

  df_objects = pd.read_csv("pandas.csv", index_col='id')
  
or afterwards we can add an index to an existing DataFrame

   df_objects.set_index('place')

## Data Tidying

### Removing blank values

Before we can start doing anything meaningful with the data we have read in, we need to get it into shape. First we should remove any rows that don't contain any meaningful values for our current use (i.e. those with entirely blank fields) by using the 'dropna' operation (we pass the inplace argument to stop it modifying the original variable and instead return a new variable with the result of the operation):


```python
df_objects_clean = df_objects.dropna(inplace=False)
len(df_objects_clean)
```




    0



This has thrown out any rows that have blank values (the definition of what is considered a blank value is configurable but defaults to 'NaN', see the na_values argument in the [docs](http://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_csv.html). In this case, all the rows have at least one field with a blank value, so we are left with no data.

A more useful data cleaning option is to tell Pandas which columns we really care about not being blank, and to allow the rest to be optional. For example we can always insist on having a title:


```python
df_objects_clean = df_objects.dropna(subset=['title'])
len(df_objects_clean)
```




    6



Now we have all the rows that have an title set, even if other columns in the same row are blank.

If we don't need to keep the original DataFrame (df_objects) we can avoid creating another variable by passing inplace=True instead to the function (incidently, this argument works in the same way for most Pandas operations). Pandas then modifies the original variable instead of returning a new one each time. 

To continue our data cleanup, we might want to remove any duplicate values. One way to carry this out is to create a filter than removes those rows that are duplicates. For example, Let's say we only want an artist to appear once in the list. We first need to get the list of artists:


```python
artists = df_objects['Artist']
artists.head()
```




    0                artist
    1    Richards, Clifford
    2                 Ji Ji
    3                 Ji Ji
    4                 Ji Ji
    Name: Artist, dtype: object



Now we ask Pandas to look for any duplicate values in this single column DataFrame using the 'duplicated' operation. This returns a new column of the same length as the input but consisting of boolean, with 'True' for a duplicate in the input list. We also pass the argument keep='first' to tell Pandas it should mark the first occurrence of a duplicated value as 'False' so we don't remove all occurrences (alternatively we could have passed keep='last' to retain the last occurrence, or keep=False to remove them all)


```python
non_duplicates_mask = artists.duplicated(keep='first')
non_duplicates_mask.head()
```




    0    False
    1    False
    2    False
    3     True
    4     True
    Name: Artist, dtype: bool



Now we have a list of duplicates, but it would be easier if we had a list of those rows we want to keep rather than those we want to remove, so we negate the list with the '~' operator:


```python
duplicates_mask = ~non_duplicates_mask
duplicates_mask.head()
```




    0     True
    1     True
    2     True
    3    False
    4    False
    Name: Artist, dtype: bool



Finally, we use this list to select from the DataFrame those rows to keep and the duplicate rows to remove:


```python
df_objects_nodup = df_objects[duplicates_mask]
df_objects_nodup.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th>0</th>
      <td>id</td>
      <td>object</td>
      <td>title</td>
      <td>artist</td>
      <td>year_start</td>
      <td>place</td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>O107238</td>
      <td>Print</td>
      <td>Slottizoo Panda</td>
      <td>Richards, Clifford</td>
      <td>1962</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2</th>
      <td>O1160896</td>
      <td>Sculpture</td>
      <td>Bruised; Hi, Panda</td>
      <td>Ji Ji</td>
      <td>2007</td>
      <td>Shanghai</td>
    </tr>
    <tr>
      <th>5</th>
      <td>O1261213</td>
      <td>Toy panda</td>
      <td>NaN</td>
      <td>Steiff</td>
      <td>1995</td>
      <td>Germany</td>
    </tr>
    <tr>
      <th>6</th>
      <td>O242160</td>
      <td>Poster</td>
      <td>Wildscreen 90</td>
      <td>Eckersley, Tom</td>
      <td>1990</td>
      <td>England</td>
    </tr>
  </tbody>
</table>
</div>



Now we only have one object from the artist 'Ji Ji'.

Of course we can chain all of these operations together in a one liner:


```python
df_objects_oneliner = df_objects[~df_objects['artist'].duplicated(keep='first')]
len(df_objects_oneliner)
```




    7



(If you ever need to remove duplicates from the index column, you will need the following instead)


```python
df_index_nodup = df_objects[~df_objects.index.duplicated(keep='first')]
len(df_index_nodup)
```




    14



### Filtering out unwanted values

If we only want to look at certain types of objects, we can filter out any rows that we are not interested in. For example if we only want to see Print objects we can do this:



```python
prints = df_objects[df_objects['object'] == "Print"]
prints.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>object</th>
      <th>title</th>
      <th>artist</th>
      <th>year_start</th>
      <th>place</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>9</th>
      <td>O107238</td>
      <td>Print</td>
      <td>Slottizoo Panda</td>
      <td>Richards, Clifford</td>
      <td>NaN</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>



We can also filter on a list of possible values using the 'isin' operator:


```python
object_types = ['Teddy bear', 'Print']
prints_and_posters = df_objects[df_objects.object.isin(object_types)]
prints_and_posters.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>object</th>
      <th>title</th>
      <th>artist</th>
      <th>year_start</th>
      <th>place</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>4</th>
      <td>O1363217</td>
      <td>Teddy bear</td>
      <td>Panda</td>
      <td>unknown</td>
      <td>NaN</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>8</th>
      <td>O1152697</td>
      <td>Teddy bear</td>
      <td>NaN</td>
      <td>Schuco</td>
      <td>NaN</td>
      <td>Germany</td>
    </tr>
    <tr>
      <th>9</th>
      <td>O107238</td>
      <td>Print</td>
      <td>Slottizoo Panda</td>
      <td>Richards, Clifford</td>
      <td>NaN</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>



Alternatively, we can keep everything that doesn't match by using the operator '~' to invert the results:


```python
object_types = ['Teddy bear', 'Print']
non_prints_and_posters = df_objects[~df_objects.object.isin(object_types)]
non_prints_and_posters.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>object</th>
      <th>title</th>
      <th>artist</th>
      <th>year_start</th>
      <th>place</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>O26744</td>
      <td>Card game</td>
      <td>pandas' party</td>
      <td>Unknown</td>
      <td>NaN</td>
      <td>England</td>
    </tr>
    <tr>
      <th>1</th>
      <td>O49687</td>
      <td>Set of soft toy pandas</td>
      <td>NaN</td>
      <td>Fiat</td>
      <td>NaN</td>
      <td>Asia</td>
    </tr>
    <tr>
      <th>2</th>
      <td>O1177173</td>
      <td>Sculpture</td>
      <td>Angry</td>
      <td>Ji Ji</td>
      <td>NaN</td>
      <td>Shanghai</td>
    </tr>
    <tr>
      <th>3</th>
      <td>O1160896</td>
      <td>Sculpture</td>
      <td>Bruised</td>
      <td>Ji Ji</td>
      <td>NaN</td>
      <td>Shanghai</td>
    </tr>
    <tr>
      <th>5</th>
      <td>O1154563</td>
      <td>Olympic Mascot</td>
      <td>Jingjing</td>
      <td>unknown</td>
      <td>NaN</td>
      <td>China</td>
    </tr>
  </tbody>
</table>
</div>



### Renaming columns

Columns in a dataframe can be easily renamed by assigning an array to the columns variable:


```python
df_objects.columns = ['VAMID', 'a', 'b', 'c', 'd', 'e']
df_objects.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>VAMID</th>
      <th>a</th>
      <th>b</th>
      <th>c</th>
      <th>d</th>
      <th>e</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>id</td>
      <td>object</td>
      <td>title</td>
      <td>artist</td>
      <td>year_start</td>
      <td>place</td>
    </tr>
    <tr>
      <th>1</th>
      <td>O107238</td>
      <td>Print</td>
      <td>Slottizoo Panda</td>
      <td>Richards, Clifford</td>
      <td>1962</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2</th>
      <td>O1160896</td>
      <td>Sculpture</td>
      <td>Bruised; Hi, Panda</td>
      <td>Ji Ji</td>
      <td>2007</td>
      <td>Shanghai</td>
    </tr>
    <tr>
      <th>3</th>
      <td>O1177172</td>
      <td>Sculpture</td>
      <td>Smiley; Hi, Panda</td>
      <td>Ji Ji</td>
      <td>2007</td>
      <td>Shanghai</td>
    </tr>
    <tr>
      <th>4</th>
      <td>O1177173</td>
      <td>Sculpture</td>
      <td>Angry; Hi, Panda</td>
      <td>Ji Ji</td>
      <td>2007</td>
      <td>Shanghai</td>
    </tr>
  </tbody>
</table>
</div>



### Dealing with Dates

Panda time & date handling is attuned to dealing with financial transactions; it's 64 bit datetime type can express time from the microsecond (starting from 1678) to 2262. For historical dates before then though, we have to make use of the Period type which can store the individual components of a date & time (e.g. year, month, day, hour, second, etc) without limit. However handling these types is slower than the native datetime, and you will need to instruct Pandas on how to create them from loading the dates from CSV. For example:


```python
def dt_parse(s):
    d,m,y = s.split('/')
    return pd.Period(year=int(y), month=int(m), day=int(d), freq='D')

df = pd.read_csv("historical_data.csv", parse_dates=[0], date_parser=dt_parse)

```

would process a file containing lines such as:

"05/12/1512",Cup,Unknown Maker,London

and turn the date field into a Period object. For more on dealing with historical (or dates in the distant future) see the manual http://pandas.pydata.org/pandas-docs/stable/timeseries.html#representing-out-of-bounds-spans

## Data Detective: Joining two museum collection datasets

At this point, we have enough Panda Fu to explore datasets and start to do some analysis. This time we will use
two museum collections data sets (from MoMa and Tate), both available as downloadable files on GitHub in CSV and JSON formats. The data sets contain overlapping details for artists held in both collections, with similar (but not identical!) titled columns for artist names, birth/death etc. 

We will try to join the datasets together based on the artist name, and then compare two related columns from 
each dataset to see if there are any differences of opinion.

The datasets are downloadable from here:

  * Tate - https://github.com/tategallery/collection
  * MoMa - https://github.com/MuseumofModernArt/collection

And can be retrieved with curl as before:

   curl -O https://raw.githubusercontent.com/tategallery/collection/master/artist_data.csv 
   curl -O https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/Artists.csv 
   
The Tate dataset has the following fields available:

    id,name,gender,dates,yearOfBirth,yearOfDeath,placeOfBirth,placeOfDeath,url

and MoMa has:

    ConstituentID,DisplayName,ArtistBio,Nationality,Gender,BeginDate,EndDate,Wiki QID,ULAN
    
Let's start by reading the data in:    


```python
    df_tate = pd.read_csv("artist_data.csv")
    df_tate.head(3)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>gender</th>
      <th>dates</th>
      <th>yearOfBirth</th>
      <th>yearOfDeath</th>
      <th>placeOfBirth</th>
      <th>placeOfDeath</th>
      <th>url</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10093</td>
      <td>Abakanowicz, Magdalena</td>
      <td>Female</td>
      <td>born 1930</td>
      <td>1930.0</td>
      <td>NaN</td>
      <td>Polska</td>
      <td>NaN</td>
      <td>http://www.tate.org.uk/art/artists/magdalena-a...</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0</td>
      <td>Abbey, Edwin Austin</td>
      <td>Male</td>
      <td>1852–1911</td>
      <td>1852.0</td>
      <td>1911.0</td>
      <td>Philadelphia, United States</td>
      <td>London, United Kingdom</td>
      <td>http://www.tate.org.uk/art/artists/edwin-austi...</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2756</td>
      <td>Abbott, Berenice</td>
      <td>Female</td>
      <td>1898–1991</td>
      <td>1898.0</td>
      <td>1991.0</td>
      <td>Springfield, United States</td>
      <td>Monson, United States</td>
      <td>http://www.tate.org.uk/art/artists/berenice-ab...</td>
    </tr>
  </tbody>
</table>
</div>



We can immediately see a problem with the yearofBirth/yearOfDeath fields, they've been parsed
as a floating number rather than an integer as we would expect for a year. This is
because Pandas cannot represent Not-a-Number (i.e. an unknown year) as an
integer (see [here](http://pandas.pydata.org/pandas-docs/stable/gotchas.html#nan-integer-na-values-and-na-type-promotions)) so instead it falls back on converting the whole column to a floating number allowing it to deal with the NaN values.

We can fix this by replacing the NaN float64 values with 0 using 'fillna', this lets us convert the column back to integer years using the 'astype' operator:


```python
df_tate['yearOfBirth'].fillna(0, inplace=True)
df_tate['yearOfBirth'] = df_tate['yearOfBirth'].astype(int)

df_tate['yearOfDeath'].fillna(0, inplace=True)
df_tate['yearOfDeath'] = df_tate['yearOfDeath'].astype(int)

df_tate.head(3)

```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>gender</th>
      <th>dates</th>
      <th>yearOfBirth</th>
      <th>yearOfDeath</th>
      <th>placeOfBirth</th>
      <th>placeOfDeath</th>
      <th>url</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10093</td>
      <td>Abakanowicz, Magdalena</td>
      <td>Female</td>
      <td>born 1930</td>
      <td>1930</td>
      <td>0</td>
      <td>Polska</td>
      <td>NaN</td>
      <td>http://www.tate.org.uk/art/artists/magdalena-a...</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0</td>
      <td>Abbey, Edwin Austin</td>
      <td>Male</td>
      <td>1852–1911</td>
      <td>1852</td>
      <td>1911</td>
      <td>Philadelphia, United States</td>
      <td>London, United Kingdom</td>
      <td>http://www.tate.org.uk/art/artists/edwin-austi...</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2756</td>
      <td>Abbott, Berenice</td>
      <td>Female</td>
      <td>1898–1991</td>
      <td>1898</td>
      <td>1991</td>
      <td>Springfield, United States</td>
      <td>Monson, United States</td>
      <td>http://www.tate.org.uk/art/artists/berenice-ab...</td>
    </tr>
  </tbody>
</table>
</div>



Next we read in the MoMa data:


```python
df_moma = pd.read_csv("Artists.csv")
df_moma.head(3)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>ConstituentID</th>
      <th>DisplayName</th>
      <th>ArtistBio</th>
      <th>Nationality</th>
      <th>Gender</th>
      <th>BeginDate</th>
      <th>EndDate</th>
      <th>Wiki QID</th>
      <th>ULAN</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Robert Arneson</td>
      <td>American, 1930–1992</td>
      <td>American</td>
      <td>Male</td>
      <td>1930</td>
      <td>1992</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Doroteo Arnaiz</td>
      <td>Spanish, born 1936</td>
      <td>Spanish</td>
      <td>Male</td>
      <td>1936</td>
      <td>0</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Bill Arnold</td>
      <td>American, born 1941</td>
      <td>American</td>
      <td>Male</td>
      <td>1941</td>
      <td>0</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>



We will have a problem with joining the rows between the datasets on artist names; as in the Tate data
names are given in the form "Surname, Firstname", whereas MoMa uses "Firstname Surname". We can fix this by doing a simple reverse of names on the Tate column (we will have to ignore for this example cases such as "Barret, George, Junior" but a more complex function could deal with this).

Our relatively simple lambda function is applied to each value in the 'name' column, performing some simple string manipulation (splitting the value apart - ", ", reversing the order - [::-1], then joining the string back together again with spaces - " ".join)


```python
df_tate['name2'] = df_tate['name'].apply(lambda x: " ".join(x.split(", ")[::-1]))
df_tate.head(3)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>gender</th>
      <th>dates</th>
      <th>yearOfBirth</th>
      <th>yearOfDeath</th>
      <th>placeOfBirth</th>
      <th>placeOfDeath</th>
      <th>url</th>
      <th>name2</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10093</td>
      <td>Abakanowicz, Magdalena</td>
      <td>Female</td>
      <td>born 1930</td>
      <td>1930</td>
      <td>0</td>
      <td>Polska</td>
      <td>NaN</td>
      <td>http://www.tate.org.uk/art/artists/magdalena-a...</td>
      <td>Magdalena Abakanowicz</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0</td>
      <td>Abbey, Edwin Austin</td>
      <td>Male</td>
      <td>1852–1911</td>
      <td>1852</td>
      <td>1911</td>
      <td>Philadelphia, United States</td>
      <td>London, United Kingdom</td>
      <td>http://www.tate.org.uk/art/artists/edwin-austi...</td>
      <td>Edwin Austin Abbey</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2756</td>
      <td>Abbott, Berenice</td>
      <td>Female</td>
      <td>1898–1991</td>
      <td>1898</td>
      <td>1991</td>
      <td>Springfield, United States</td>
      <td>Monson, United States</td>
      <td>http://www.tate.org.uk/art/artists/berenice-ab...</td>
      <td>Berenice Abbott</td>
    </tr>
  </tbody>
</table>
</div>



which mostly works, except for some values that should have been ignored e.g.

    "Young-Hae Chang Heavy Industries (Young-Hae Chang, Marc Voge)"

will become:

    Marc Voge) Young-Hae Chang Heavy Industries (Young-Hae Chang


But again we will ignore these for this example. 

We now have two datasets with an artist name column that should serve as a common value between the two datasets. However, there are still many variations in the spelling/spacing/transliteration/etc of artist names that will reduce the number of matches if we just do a simple string equality test. So instead we'll use
python's built in (in the difflib module) get_close_matches function, which given a string and an list of strings, returns the closest matches, with a configurable matching distance. We will assume the first artist match from the MoMa data is correct and replace the Tate artist name with it so both datasets have the same artist names in the same form. This process is fairly CPU intensive so will take some time to run


```python
import difflib
import numpy as np
    
def close_match(name):
 matches = difflib.get_close_matches(name, df_moma['DisplayName'], cutoff=0.9)
 if len(matches) > 0:
  return matches[0]
 else:
  return np.nan
    
df_tate['name2'] = df_tate['name2'].apply(lambda x: close_match(x))

df_tate.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>gender</th>
      <th>dates</th>
      <th>yearOfBirth</th>
      <th>yearOfDeath</th>
      <th>placeOfBirth</th>
      <th>placeOfDeath</th>
      <th>url</th>
      <th>name2</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10093</td>
      <td>Abakanowicz, Magdalena</td>
      <td>Female</td>
      <td>born 1930</td>
      <td>1930</td>
      <td>0</td>
      <td>Polska</td>
      <td>NaN</td>
      <td>http://www.tate.org.uk/art/artists/magdalena-a...</td>
      <td>Magdalena Abakanowicz</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0</td>
      <td>Abbey, Edwin Austin</td>
      <td>Male</td>
      <td>1852–1911</td>
      <td>1852</td>
      <td>1911</td>
      <td>Philadelphia, United States</td>
      <td>London, United Kingdom</td>
      <td>http://www.tate.org.uk/art/artists/edwin-austi...</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2756</td>
      <td>Abbott, Berenice</td>
      <td>Female</td>
      <td>1898–1991</td>
      <td>1898</td>
      <td>1991</td>
      <td>Springfield, United States</td>
      <td>Monson, United States</td>
      <td>http://www.tate.org.uk/art/artists/berenice-ab...</td>
      <td>Berenice Abbott</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>Abbott, Lemuel Francis</td>
      <td>Male</td>
      <td>1760–1803</td>
      <td>1760</td>
      <td>1803</td>
      <td>Leicestershire, United Kingdom</td>
      <td>London, United Kingdom</td>
      <td>http://www.tate.org.uk/art/artists/lemuel-fran...</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>622</td>
      <td>Abrahams, Ivor</td>
      <td>Male</td>
      <td>born 1935</td>
      <td>1935</td>
      <td>0</td>
      <td>Wigan, United Kingdom</td>
      <td>NaN</td>
      <td>http://www.tate.org.uk/art/artists/ivor-abraha...</td>
      <td>Ivor Abrahams</td>
    </tr>
  </tbody>
</table>
</div>




```python
len(df_tate)
```




    3532



(The cutoff value passed to get_close_matches controls how far away from the original string matches will be
found. Lowering this value will find more matches but increase the chances of them being incorrect.
A superior algorithm would be based on clearer understanding of name stemming instead of more general word distances.)

We then remove anything that didn't return any matches from the MoMa data:



```python
df_tate.dropna(subset=['name2'], inplace=True)
df_tate.head(5)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>gender</th>
      <th>dates</th>
      <th>yearOfBirth</th>
      <th>yearOfDeath</th>
      <th>placeOfBirth</th>
      <th>placeOfDeath</th>
      <th>url</th>
      <th>name2</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10093</td>
      <td>Abakanowicz, Magdalena</td>
      <td>Female</td>
      <td>born 1930</td>
      <td>1930</td>
      <td>0</td>
      <td>Polska</td>
      <td>NaN</td>
      <td>http://www.tate.org.uk/art/artists/magdalena-a...</td>
      <td>Magdalena Abakanowicz</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2756</td>
      <td>Abbott, Berenice</td>
      <td>Female</td>
      <td>1898–1991</td>
      <td>1898</td>
      <td>1991</td>
      <td>Springfield, United States</td>
      <td>Monson, United States</td>
      <td>http://www.tate.org.uk/art/artists/berenice-ab...</td>
      <td>Berenice Abbott</td>
    </tr>
    <tr>
      <th>4</th>
      <td>622</td>
      <td>Abrahams, Ivor</td>
      <td>Male</td>
      <td>born 1935</td>
      <td>1935</td>
      <td>0</td>
      <td>Wigan, United Kingdom</td>
      <td>NaN</td>
      <td>http://www.tate.org.uk/art/artists/ivor-abraha...</td>
      <td>Ivor Abrahams</td>
    </tr>
    <tr>
      <th>6</th>
      <td>9550</td>
      <td>Abts, Tomma</td>
      <td>Female</td>
      <td>born 1967</td>
      <td>1967</td>
      <td>0</td>
      <td>Kiel, Deutschland</td>
      <td>NaN</td>
      <td>http://www.tate.org.uk/art/artists/tomma-abts-...</td>
      <td>Tomma Abts</td>
    </tr>
    <tr>
      <th>7</th>
      <td>623</td>
      <td>Acconci, Vito</td>
      <td>Male</td>
      <td>born 1940</td>
      <td>1940</td>
      <td>0</td>
      <td>New York, United States</td>
      <td>NaN</td>
      <td>http://www.tate.org.uk/art/artists/vito-acconc...</td>
      <td>Vito Acconci</td>
    </tr>
  </tbody>
</table>
</div>




```python
len(df_tate)
```




    1176



We now have in the Tate DataFrame only those artists that occur in both data sets (or rather, 
have a matching name in both datasets, 'John Smith' in MoMa may be a different 
'John Smith' in the Tate but we cannot solve that in this example). Let's try merging them together on
the name. To do this we have to tell Pandas which fields we want to merge on, using the 'left_on' and 'right_on' arguments with the column names to use.



```python
df_museums = pd.merge(df_tate, df_moma, left_on='name2', right_on='DisplayName', how='left')
df_museums.head(1)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>gender</th>
      <th>dates</th>
      <th>yearOfBirth</th>
      <th>yearOfDeath</th>
      <th>placeOfBirth</th>
      <th>placeOfDeath</th>
      <th>url</th>
      <th>name2</th>
      <th>ConstituentID</th>
      <th>DisplayName</th>
      <th>ArtistBio</th>
      <th>Nationality</th>
      <th>Gender</th>
      <th>BeginDate</th>
      <th>EndDate</th>
      <th>Wiki QID</th>
      <th>ULAN</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10093</td>
      <td>Abakanowicz, Magdalena</td>
      <td>Female</td>
      <td>born 1930</td>
      <td>1930</td>
      <td>0</td>
      <td>Polska</td>
      <td>NaN</td>
      <td>http://www.tate.org.uk/art/artists/magdalena-a...</td>
      <td>Magdalena Abakanowicz</td>
      <td>38</td>
      <td>Magdalena Abakanowicz</td>
      <td>Polish, 1930–2017</td>
      <td>Polish</td>
      <td>Female</td>
      <td>1930</td>
      <td>2017</td>
      <td>Q158080</td>
      <td>500084577.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_museums.info()
```

    <class 'pandas.core.frame.DataFrame'>
    Int64Index: 1181 entries, 0 to 1180
    Data columns (total 19 columns):
    id               1181 non-null int64
    name             1181 non-null object
    gender           1165 non-null object
    dates            1176 non-null object
    yearOfBirth      1181 non-null int64
    yearOfDeath      1181 non-null int64
    placeOfBirth     1136 non-null object
    placeOfDeath     416 non-null object
    url              1181 non-null object
    name2            1181 non-null object
    ConstituentID    1181 non-null int64
    DisplayName      1181 non-null object
    ArtistBio        1172 non-null object
    Nationality      1165 non-null object
    Gender           1163 non-null object
    BeginDate        1181 non-null int64
    EndDate          1181 non-null int64
    Wiki QID         808 non-null object
    ULAN             796 non-null float64
    dtypes: float64(1), int64(6), object(12)
    memory usage: 184.5+ KB


Whilst this works, this creates a rather unwieldy dataset containing all the columns from both
datasets. For the moment's instead we will just pull out one column from each dataset for the merge:



```python
df_museums2 = df_museums[["name2", "yearOfBirth", "BeginDate"]]
df_museums2.head(1)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name2</th>
      <th>yearOfBirth</th>
      <th>BeginDate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Magdalena Abakanowicz</td>
      <td>1930</td>
      <td>1930</td>
    </tr>
  </tbody>
</table>
</div>



Likewise we could pull out other data columns. 

So let us now do some detective work and find artists birth dates that are only known in one dataset. To do this we use the 'query' operator to identify the relevant rows, first where only the MoMa data has an artists birth year:


```python
df_museums2 = df_museums[["name2", "yearOfBirth", "BeginDate"]].query('yearOfBirth > 0 and BeginDate == 0')
df_museums2.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name2</th>
      <th>yearOfBirth</th>
      <th>BeginDate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>5</th>
      <td>Norman Ackroyd</td>
      <td>1938</td>
      <td>0</td>
    </tr>
    <tr>
      <th>92</th>
      <td>Glen Baxter</td>
      <td>1944</td>
      <td>0</td>
    </tr>
    <tr>
      <th>106</th>
      <td>Anthony Benjamin</td>
      <td>1931</td>
      <td>0</td>
    </tr>
    <tr>
      <th>138</th>
      <td>Bart Boumans</td>
      <td>1940</td>
      <td>0</td>
    </tr>
    <tr>
      <th>145</th>
      <td>Martin Bradley</td>
      <td>1931</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>


and then likewise for those artists where only the Tate knows the birth year: 


```python
df_museums2 = df_museums[["name2", "yearOfBirth", "BeginDate"]].query('yearOfBirth == 0 and BeginDate > 0')
df_museums2.head()
```

<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name2</th>
      <th>yearOfBirth</th>
      <th>BeginDate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>489</th>
      <td>Gary Hincks</td>
      <td>0</td>
      <td>1949</td>
    </tr>
    <tr>
      <th>779</th>
      <td>John Newman</td>
      <td>0</td>
      <td>1952</td>
    </tr>
    <tr>
      <th>1154</th>
      <td>Christian Wolff</td>
      <td>0</td>
      <td>1934</td>
    </tr>
  </tbody>
</table>
</div>


There are many other comparisions that can be run between the two datasets which are left as an exercise for the reader.  

Thats it for an introduction to Pandas. Further information is aviable at the Pandas manual, including how dataframes can be visualised.
