---
title: "Turning Data into Choropleth Maps with Python and Folium"
slug: data-into-choropleth-maps-with-python-and-folium
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Adam Porter
reviewers:
- Forename Surname
- Forename Surname
editors:
- Nabeel Siddiqui
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/604
difficulty: TBC
activity: TBC
topics: TBC
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction / Overview
[Choropleth Maps](https://en.wikipedia.org/wiki/Choropleth_map) have become very familiar to us. They are commonly used to visualize information such as [Covid-19 infection/death rates](https://coronavirus.jhu.edu/us-map), [education spending per pupil](https://www.reddit.com/r/MapPorn/comments/bc9jwu/us_education_spending_map/), and other similar data.

Visualizing data in this way can reveal patterns that might otherwise be hard to discern; one might be able to understand some of this from tables of figures, but the spacial aspect might be overlooked. Thus, this type of map can be very useful to historians and other scholars.

This lesson will demonstrate how the Folium library can be used to create choropleth maps quickly and easily. However, while a basic map is easy to create, they often require some adjustments to be as informative as possible. The level of complexity will increase as we move through the lesson. In an appendix, I included a discussion of how to normalize data (how to calculate "X per 100K population"); for many choropleth maps, this is an important step.

At the end of the lesson you will be able to:
* Load several types of data from web archives
* How to associate latitude/longitude points with county names, geography, and FIPS numbers
* Create a basic choropleth map
* Reflect on some issues that map-designers need to consider, especially the problem of dealing with non-normal distributions of data
* Enhance a Folium map with titles, popup data, and mini-maps.
* One issue with choropleth maps that display data about people is that this data tends to correlate closely with population centers; in the appendix, I will show how this issue can be addressed.

We will be exploring the *Washington Post*'s [Fatal Force](https://github.com/washingtonpost/data-police-shootings) database. Starting in 2015, the *Post* started the database, which seeks to document every time an encounter with a police officer ends in the death of the civilian. This data isn't collected or reported systematically, so the *Post*'s work fills an important lacuna in our understand of how police interact with the people around them.

My comments will reflect the data in the database as of April, 2023. Tragically, I can confidently predict that these numbers will continue to increase; when I write that 2023 has the lowest number of fatal encounters between police and civilians, it only reflects the situation in the first five months of the year.

### Folium
To create the maps, we will use Folium. [Folium](https://python-visualization.github.io/folium/) is a Python library that automates creating Leaflet maps.

[Leaflet](https://leafletjs.com/) is a JavaScript library that faciliates the creation of interactive HTML maps. To use Leaflet one needs to know some CSS and JavaScript, as Kim Pham describes in his Programming Historian article ["Web Mapping with Python and Leaflet"](https://programminghistorian.org/en/lessons/mapping-with-python-leaflet).

Folium makes it *much* easier to create Leaflet maps. For basic maps, the user doesn't need to work with HTML, CSS, or JavaScript: everything can be done within the Python ecosystem.

Folium's basic maps (putting pins / circles of various sizes and colors, cluster maps, and heat) on a map are very easy; this lesson will explore more advanced features: overlaying a map with a cloropleth map.

### Python, Pandas, and Geopandas
Python is the most popular programming language ([1](https://www.zdnet.com/article/programming-languages-python-just-took-a-big-jump-forward/), [2](https://www.infoworld.com/article/3669232/python-popularity-still-soaring.html)). It is especially useful for [data scientists](https://www.makeuseof.com/why-is-python-popular-for-data-science/) and others interested in analyzing data and visualizing data because it has an enormous library of tools specifically for these applications. This lesson assumes some proficency with Python, but I will explain things that might be unfamilar.

[Pandas](https://pandas.pydata.org/) is a powerful package for data manipulation, analysis, and visualization. This lesson assumes some proficency with Pandas, although when I do something interesting/confusing/advanced with it, I will explain what the system is doing.

There are several other Programming Historian lessons ([1](https://programminghistorian.org/en/lessons/visualizing-with-bokeh), [2](https://programminghistorian.org/en/lessons/crowdsourced-data-normalization-with-pandas)) that use Pandas. Pandas also includes a [Getting started](https://pandas.pydata.org/docs/getting_started/index.html) tutorial.

Pandas has two basic data strutures: the `series` and the `dataframe`(often abbreviated as *DF*.
* A dataframe is similar to a spreadsheet: it has rows and columns of data.
 * rows have index values (akin to the row numbers in a spreadsheet)
 * columns have column names (unlike a spreadsheet, which typically use letters for columns)

* A series is a single column in a dataframe (or in a spreadsheet).

[Geopandas](https://geopandas.org/en/stable/) is built on Pandas and adds extensions to make working with geospacial data easier. Notably, it adds some [shapely](https://shapely.readthedocs.io/en/stable/) datatypes to Pandas that include `point` and `geometry`.

### Colab
This lesson assumes that one is using Google's [Colab](https://colab.research.google.com/) system. Colab allows users to create [Jupyter notebook](https://realpython.com/jupyter-notebook-introduction/)-like files that combine markdown text and Python cells.

Colab is very useful in the classroom, since it runs entirely on the web. Students can access Colab notebooks with any computer or tablet that runs a modren web-browser. This means that instructors don't need to write different instructions for Macs, PCs, Linux, Chromebooks, etc. The system is fast and powerful: the virtual machines generally have around 12GB RAM and 23GB disk space; designed for machine learning, it also allows users to add a graphics card / hardware accelerator (we won't be using this!). Since computation is done in the cloud, users don't need to have a powerful machine to use the system.

Colab includes a very large collection of Python libraries, as it is intended for data science and machine learning. In our lesson, most of our libraries are all part of the standard Colab system. One exception is the `geopandas` library.

Colab allows users to install missing libraries with the `pip` command. As in other Jupyter systems, we can access the command line (bash) with an `!` mark.

Colab runs in the cloud. When we close the window, the Jupyter notebook will be saved, but unless data is saved to a users Google drive or to a local drive, it will disappear. This is also the case for libraries installed with `! pip`: they are available while the notebook executes, but need to be installed each time they are going to be accessed. (Unlike on a normal computer: when a library is installed with `pip`, it is saved to the drive and doesn't need to be reinstalled.)

Most of the libraries we will be using are part of Colab's default collection, but a couple are not. One of these is `geopandas`, so we will install it with the bash command `!pip install geopandas`.
> The Unix/Linux terminal shell (or command line) is called [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell). iOS and Windows have similar terminal shell programs. Jupyter notebooks allow users to issue terminal commands by prefixing the command with an exclaimation point; Colab follows this convention.

In the next cell, we will install `geopandas`. (Bash output tends to be prolix and not really necessary for this lesson. When I've cut it, this is noted with `<SNIP>`.)


```python
!pip install geopandas

    Looking in indexes: https://pypi.org/simple, https://us-python.pkg.dev/colab-wheels/public/simple/
    Collecting geopandas
      Downloading geopandas-0.12.2-py3-none-any.whl (1.1 MB)
    [2K     [90m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m1.1/1.1 MB[0m [31m14.3 MB/s[0m eta [36m0:00:00[0m
    [?25hCollecting fiona>=1.8
      Downloading Fiona-1.9.3-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (16.1 MB)
    [2K     [90m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m16.1/16.1 MB[0m [31m44.6 MB/s[0m eta [36m0:00:00[0m
    [?25hRequirement already satisfied: pandas>=1.0.0 in /usr/local/lib/python3.9/dist-packages (from geopandas) (1.5.3)

    <SNIP>

    Installing collected packages: pyproj, munch, cligj, click-plugins, fiona, geopandas
    Successfully installed click-plugins-1.1.1 cligj-0.7.2 fiona-1.9.3 geopandas-0.12.2 munch-2.5.0 pyproj-3.5.0
```

### Import Libraries
After we install geopandas, we're ready to import the libraries we will be using for this lesson.

Note that the libraries are loaded and assigned the library's common alias (`pd` and `gpd`). As we call methods from the libraries, we will use these aliases instead of the full library name.


```python
import pandas as pd
import geopandas as gpd
import folium
```

## Get the Data

### Fatal Force Data
Before importing the data, I read the *Post*'s [documentation](https://github.com/washingtonpost/data-police-shootings/tree/master/v2) about the datafields, so I know there is a `date` field.

Pandas tries to parse data as it imports it. It is pretty good at recognizing *string* (character) data and *numeric* data and imports them as `object` and `int64` or `float64` datatypes. But it struggles with date-time fields. If we include the keyword `parse_dates=` parameter, along with the name of the date column, Pandas will parse the date field and make it a `datetime64` datatype.


```python
ff_df = pd.read_csv('https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv',
                    parse_dates = ['date'])
```

We will look at the fatal force dataframe (ff_df) to see what sort of data it has, to check the data types, and take a look at the sample data.


```python
ff_df.info()

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 8410 entries, 0 to 8409
    Data columns (total 19 columns):
     #   Column                      Non-Null Count  Dtype         
    ---  ------                      --------------  -----         
     0   id                          8410 non-null   int64         
     1   date                        8410 non-null   datetime64[ns]
     2   threat_type                 8394 non-null   object        
     3   flee_status                 7323 non-null   object        
     4   armed_with                  8200 non-null   object        
     5   city                        8386 non-null   object        
     6   county                      3556 non-null   object        
     7   state                       8410 non-null   object        
     8   latitude                    7496 non-null   float64       
     9   longitude                   7496 non-null   float64       
     10  location_precision          7496 non-null   object        
     11  name                        7884 non-null   object        
     12  age                         7848 non-null   float64       
     13  gender                      8366 non-null   object        
     14  race                        7189 non-null   object        
     15  race_source                 7211 non-null   object        
     16  was_mental_illness_related  8410 non-null   bool          
     17  body_camera                 8410 non-null   bool          
     18  agency_ids                  8409 non-null   object        
    dtypes: bool(2), datetime64[ns](1), float64(3), int64(1), object(12)
    memory usage: 1.1+ MB
```

```python
ff_df.sample(5)
```
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>date</th>
      <th>threat_type</th>
      <th>flee_status</th>
      <th>armed_with</th>
      <th>city</th>
      <th>county</th>
      <th>state</th>
      <th>latitude</th>
      <th>longitude</th>
      <th>location_precision</th>
      <th>name</th>
      <th>age</th>
      <th>gender</th>
      <th>race</th>
      <th>race_source</th>
      <th>was_mental_illness_related</th>
      <th>body_camera</th>
      <th>agency_ids</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>4219</th>
      <td>4641</td>
      <td>2019-04-16</td>
      <td>attack</td>
      <td>car</td>
      <td>vehicle</td>
      <td>Fountain Inn</td>
      <td>NaN</td>
      <td>SC</td>
      <td>34.689009</td>
      <td>-82.195668</td>
      <td>not_available</td>
      <td>Chadwick Dale Martin Jr.</td>
      <td>24.0</td>
      <td>male</td>
      <td>W</td>
      <td>not_available</td>
      <td>False</td>
      <td>False</td>
      <td>2463</td>
    </tr>
    <tr>
      <th>6392</th>
      <td>7610</td>
      <td>2021-06-04</td>
      <td>shoot</td>
      <td>foot</td>
      <td>gun</td>
      <td>Braintree</td>
      <td>NaN</td>
      <td>MA</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>Andrew Homen</td>
      <td>34.0</td>
      <td>male</td>
      <td>W</td>
      <td>photo</td>
      <td>False</td>
      <td>False</td>
      <td>1186</td>
    </tr>
    <tr>
      <th>7711</th>
      <td>8368</td>
      <td>2022-08-30</td>
      <td>threat</td>
      <td>not</td>
      <td>gun</td>
      <td>Cedar Rapids</td>
      <td>NaN</td>
      <td>IA</td>
      <td>41.924058</td>
      <td>-91.677853</td>
      <td>not_available</td>
      <td>William Isaac Rich</td>
      <td>22.0</td>
      <td>male</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>False</td>
      <td>True</td>
      <td>872</td>
    </tr>
    <tr>
      <th>4954</th>
      <td>5571</td>
      <td>2020-01-09</td>
      <td>shoot</td>
      <td>not</td>
      <td>gun</td>
      <td>Philadelphia</td>
      <td>NaN</td>
      <td>PA</td>
      <td>40.013024</td>
      <td>-75.082175</td>
      <td>not_available</td>
      <td>Claude Fain</td>
      <td>47.0</td>
      <td>male</td>
      <td>B</td>
      <td>not_available</td>
      <td>True</td>
      <td>False</td>
      <td>671</td>
    </tr>
    <tr>
      <th>947</th>
      <td>1088</td>
      <td>2015-12-14</td>
      <td>threat</td>
      <td>not</td>
      <td>knife</td>
      <td>Middle River</td>
      <td>Baltimore</td>
      <td>MD</td>
      <td>39.304449</td>
      <td>-76.371538</td>
      <td>not_available</td>
      <td>Jeffrey Gene Evans</td>
      <td>52.0</td>
      <td>male</td>
      <td>W</td>
      <td>not_available</td>
      <td>True</td>
      <td>False</td>
      <td>128</td>
    </tr>
  </tbody>
</table>

As of April 26, there are 8,410 records in the database.

Most of our fields are `object` (which is what Pandas calls `string` or text) data. `date` is a `datetime` object. And there are numbers for the `latitude`,`longitude` and `age` fields.

If the lat/lon fields were not numbers, we would need to do some data cleaning to get them convered to `float`-type numbers. In Python a `float` is a number with decimal values; an `integer` is a whole number.

> This is an example of where the Pandas' parser isn't perfect: lat/lon should be `float`s but `age` should be an `int` since the `age` values are all whole numbers.

Of the 8,410 records, how many lacked latitude/longitude (lat/lon) data? What percent of the database is missing this information?

Pandas allows users to filter the DF by creating a [*boolean mask*](https://www.geeksforgeeks.org/boolean-indexing-in-pandas/).

We can test a single column for certain criteria; Pandas will create a list of boolean (`True`/`False`) values. The next cell tells Pandas to look at the `latitude` column and to find all the rows that do not contain a [`NaN`](https://pandas.pydata.org/pandas-docs/stable/user_guide/missing_data.html) value. (NaN = "not a number" which is what Pandas uses when missing data).



```python
ff_df['latitude'].notna()

    0        True
    1        True
    2        True
    3        True
    4        True
            ...  
    8405    False
    8406     True
    8407     True
    8408     True
    8409    False
    Name: latitude, Length: 8410, dtype: bool
```


We can use this boolean mask to extract only the rows in the DF that have a `True` value:


```python
ff_df[ff_df['latitude'].notna()]
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>date</th>
      <th>threat_type</th>
      <th>flee_status</th>
      <th>armed_with</th>
      <th>city</th>
      <th>county</th>
      <th>state</th>
      <th>latitude</th>
      <th>longitude</th>
      <th>location_precision</th>
      <th>name</th>
      <th>age</th>
      <th>gender</th>
      <th>race</th>
      <th>race_source</th>
      <th>was_mental_illness_related</th>
      <th>body_camera</th>
      <th>agency_ids</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>3</td>
      <td>2015-01-02</td>
      <td>point</td>
      <td>not</td>
      <td>gun</td>
      <td>Shelton</td>
      <td>Mason</td>
      <td>WA</td>
      <td>47.246826</td>
      <td>-123.121592</td>
      <td>not_available</td>
      <td>Tim Elliot</td>
      <td>53.0</td>
      <td>male</td>
      <td>A</td>
      <td>not_available</td>
      <td>True</td>
      <td>False</td>
      <td>73</td>
    </tr>
    <tr>
      <th>1</th>
      <td>4</td>
      <td>2015-01-02</td>
      <td>point</td>
      <td>not</td>
      <td>gun</td>
      <td>Aloha</td>
      <td>Washington</td>
      <td>OR</td>
      <td>45.487421</td>
      <td>-122.891696</td>
      <td>not_available</td>
      <td>Lewis Lee Lembke</td>
      <td>47.0</td>
      <td>male</td>
      <td>W</td>
      <td>not_available</td>
      <td>False</td>
      <td>False</td>
      <td>70</td>
    </tr>
    <tr>
      <th>2</th>
      <td>5</td>
      <td>2015-01-03</td>
      <td>move</td>
      <td>not</td>
      <td>unarmed</td>
      <td>Wichita</td>
      <td>Sedgwick</td>
      <td>KS</td>
      <td>37.694766</td>
      <td>-97.280554</td>
      <td>not_available</td>
      <td>John Paul Quintero</td>
      <td>23.0</td>
      <td>male</td>
      <td>H</td>
      <td>not_available</td>
      <td>False</td>
      <td>False</td>
      <td>238</td>
    </tr>
    <tr>
      <th>3</th>
      <td>8</td>
      <td>2015-01-04</td>
      <td>point</td>
      <td>not</td>
      <td>replica</td>
      <td>San Francisco</td>
      <td>San Francisco</td>
      <td>CA</td>
      <td>37.762910</td>
      <td>-122.422001</td>
      <td>not_available</td>
      <td>Matthew Hoffman</td>
      <td>32.0</td>
      <td>male</td>
      <td>W</td>
      <td>not_available</td>
      <td>True</td>
      <td>False</td>
      <td>196</td>
    </tr>
    <tr>
      <th>4</th>
      <td>9</td>
      <td>2015-01-04</td>
      <td>point</td>
      <td>not</td>
      <td>other</td>
      <td>Evans</td>
      <td>Weld</td>
      <td>CO</td>
      <td>40.383937</td>
      <td>-104.692261</td>
      <td>not_available</td>
      <td>Michael Rodriguez</td>
      <td>39.0</td>
      <td>male</td>
      <td>H</td>
      <td>not_available</td>
      <td>False</td>
      <td>False</td>
      <td>473</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>8403</th>
      <td>9145</td>
      <td>2023-04-22</td>
      <td>threat</td>
      <td>NaN</td>
      <td>gun</td>
      <td>Bixby</td>
      <td>Tulsa</td>
      <td>OK</td>
      <td>35.973205</td>
      <td>-95.886596</td>
      <td>address</td>
      <td>NaN</td>
      <td>48.0</td>
      <td>male</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>False</td>
      <td>False</td>
      <td>2246</td>
    </tr>
    <tr>
      <th>8404</th>
      <td>9146</td>
      <td>2023-04-22</td>
      <td>threat</td>
      <td>NaN</td>
      <td>gun</td>
      <td>Metairie</td>
      <td>Jefferson</td>
      <td>LA</td>
      <td>29.990365</td>
      <td>-90.188907</td>
      <td>block</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>male</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>False</td>
      <td>False</td>
      <td>88</td>
    </tr>
    <tr>
      <th>8406</th>
      <td>9149</td>
      <td>2023-04-22</td>
      <td>shoot</td>
      <td>NaN</td>
      <td>gun</td>
      <td>West Jordan</td>
      <td>Salt Lake</td>
      <td>UT</td>
      <td>40.593788</td>
      <td>-111.969553</td>
      <td>address</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>male</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>False</td>
      <td>False</td>
      <td>751</td>
    </tr>
    <tr>
      <th>8407</th>
      <td>9144</td>
      <td>2023-04-23</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>undetermined</td>
      <td>Pineville</td>
      <td>Rapides</td>
      <td>LA</td>
      <td>31.207175</td>
      <td>-92.149489</td>
      <td>block</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>False</td>
      <td>False</td>
      <td>21677</td>
    </tr>
    <tr>
      <th>8408</th>
      <td>9153</td>
      <td>2023-04-23</td>
      <td>attack</td>
      <td>not</td>
      <td>unknown</td>
      <td>Shreveport</td>
      <td>Caddo</td>
      <td>LA</td>
      <td>32.435405</td>
      <td>-93.783105</td>
      <td>intersection</td>
      <td>Joseph Dewayne Taylor</td>
      <td>33.0</td>
      <td>male</td>
      <td>B</td>
      <td>public_record</td>
      <td>False</td>
      <td>False</td>
      <td>772</td>
    </tr>
  </tbody>
</table>
<p>7496 rows × 19 columns</p>

This shows that there are 7,496 rows that have latitude values. What percent of the whole DF is this?

We can find this by using the `len()` method. Python uses this to find the length of lists, dictionaries, and other collections of data. Pandas supports a version of this command, too.


```python
len(ff_df[ff_df['latitude'].notna()]) / len(ff_df)

    0.8913198573127229
```


Almost 90% of the records include lat/lon data. What do we do about the missing data?

With some work, we could add estimated locations. For example, many of the rows include either city or county information. We could find the center of these areas and add that lat/lon data to the DF. If we wanted to map exactly where a fatality ocurred, this wouldn't be useful, but for maps visualizing county-level data, this might suffice.

This work would be necessary if we wanted to use this data for a study or in a report. In our case, since we're just demonstrating how to use Folium, we won't dwell on the various methods one might use to add in the missing data. Instead, we will just create a smaller version of the DF that only includes rows with lat/lon data. We will use the same boolean mask to create our smaller DF.


```python
ff_df = ff_df[ff_df['latitude'].notna()]
```

### County Geometry Data
To create the chloropleth map, we also need a file that provides the geographic boundaries for the regions we wish to map. In this case, since we are interested in county-level data, we need to get a data file that defines the county shapes. The [US Census](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html) has a number of different "cartographic boundary files". These include shape files for counties (at various resolutions), congressional districts, and others.

While these files are in the ZIP format, Geopandas knows how to read them and extract the information it needs. We can load these files directly from the Census' website.


```python
counties = gpd.read_file("https://www2.census.gov/geo/tiger/GENZ2021/shp/cb_2021_us_county_5m.zip")
```

Let's look at the counties DF to make sure it has the information we're looking for.

```python
counties.info()

    <class 'geopandas.geodataframe.GeoDataFrame'>
    RangeIndex: 3234 entries, 0 to 3233
    Data columns (total 13 columns):
     #   Column      Non-Null Count  Dtype   
    ---  ------      --------------  -----   
     0   STATEFP     3234 non-null   object  
     1   COUNTYFP    3234 non-null   object  
     2   COUNTYNS    3234 non-null   object  
     3   AFFGEOID    3234 non-null   object  
     4   GEOID       3234 non-null   object  
     5   NAME        3234 non-null   object  
     6   NAMELSAD    3234 non-null   object  
     7   STUSPS      3234 non-null   object  
     8   STATE_NAME  3234 non-null   object  
     9   LSAD        3234 non-null   object  
     10  ALAND       3234 non-null   int64   
     11  AWATER      3234 non-null   int64   
     12  geometry    3234 non-null   geometry
    dtypes: geometry(1), int64(2), object(10)
    memory usage: 328.6+ KB
```


```python
counties.sample(3)
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>STATEFP</th>
      <th>COUNTYFP</th>
      <th>COUNTYNS</th>
      <th>AFFGEOID</th>
      <th>GEOID</th>
      <th>NAME</th>
      <th>NAMELSAD</th>
      <th>STUSPS</th>
      <th>STATE_NAME</th>
      <th>LSAD</th>
      <th>ALAND</th>
      <th>AWATER</th>
      <th>geometry</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>825</th>
      <td>26</td>
      <td>129</td>
      <td>01623007</td>
      <td>0500000US26129</td>
      <td>26129</td>
      <td>Ogemaw</td>
      <td>Ogemaw County</td>
      <td>MI</td>
      <td>Michigan</td>
      <td>06</td>
      <td>1459466627</td>
      <td>29641292</td>
      <td>POLYGON ((-84.37064 44.50722, -83.88663 44.508...</td>
    </tr>
    <tr>
      <th>245</th>
      <td>17</td>
      <td>017</td>
      <td>00424210</td>
      <td>0500000US17017</td>
      <td>17017</td>
      <td>Cass</td>
      <td>Cass County</td>
      <td>IL</td>
      <td>Illinois</td>
      <td>06</td>
      <td>973198204</td>
      <td>20569928</td>
      <td>POLYGON ((-90.57179 39.89427, -90.55428 39.901...</td>
    </tr>
    <tr>
      <th>2947</th>
      <td>22</td>
      <td>115</td>
      <td>00559548</td>
      <td>0500000US22115</td>
      <td>22115</td>
      <td>Vernon</td>
      <td>Vernon Parish</td>
      <td>LA</td>
      <td>Louisiana</td>
      <td>15</td>
      <td>3436185697</td>
      <td>35140841</td>
      <td>POLYGON ((-93.56976 30.99671, -93.56798 31.001...</td>
    </tr>
  </tbody>
</table>


Again, the different fields are already in the correct format: all are objects, except for `ALAND` and `AWATER` (which record the area of the county that is land and water in square meters), and `geometry` which is a special Geopandas datatype: *geometry*.

We need the `FIPS` code, which we will use to match with data in the `ff_df`. Looking at the `.sample()` output, we can see that `STATEFP` and `COUNTYFP` have the state and county code numbers; they are combined in the `GEOID` column. It's not necessary for us to rename this field (we will tell Folium which field to match) but it will be clearer for us to use the same name for the same data in both our dataframes.

The other column that we need is the `geometry` column. As can be seen in the `.sample()` output, each row of this column has a bunch of points (latitude and longitude points) defining a polygon that corresponds to the shape of a county.

Just for fun, pick a county you're familiar with and see what it looks like:


```python
counties[(counties['NAME']=='Suffolk') & (counties['STUSPS']=='MA')].plot()
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-01.png" alt="Visual description of figure image" caption="Figure 1. Caption text to display" %}
![png](Images/PH_ChrorplethFatalForceDB_29_1.png)


Since we don't need all the data in the `counties` dataframe, we will
* rename the `GEOID` column to `FIPS` and
* keep only columns we're interested in.


```python
counties = counties.rename(columns={'GEOID':'FIPS'})
counties = counties[['FIPS','NAME','geometry']]
counties.info()

    <class 'geopandas.geodataframe.GeoDataFrame'>
    RangeIndex: 3234 entries, 0 to 3233
    Data columns (total 3 columns):
     #   Column    Non-Null Count  Dtype   
    ---  ------    --------------  -----   
     0   FIPS      3234 non-null   object  
     1   NAME      3234 non-null   object  
     2   geometry  3234 non-null   geometry
    dtypes: geometry(1), object(2)
    memory usage: 75.9+ KB
```

### Preparing the Data
Before we can create a choropleth map, we need to make sure we have a field common to both DFs. This will allow Folium to match the data from one DF with data in the other DF.

Pandas [supports a variety](https://www.geeksforgeeks.org/different-types-of-joins-in-pandas/) of ways to join (or merge) different DFs.

Geopandas allows [matching](https://geopandas.org/en/stable/docs/user_guide/mergingdata.html) to be based on the geographic `point` or `geometry` fields:
* is a point **in** the polygon defined in the `geometry` field?
* is a point **close** to another point or to the polygon?

We will use the first of these options: we want to match our lat/lon points to the county polygon data.

The *Post*'s database doesn't have a FIPS number, but since it includes lat/lon data, we can add it with `geopandas.sjoin()` method.

To do so, we will create a new `points` field in the dataframe, which will convert the data in the lat/lon columns into a single `point` datatype. (`point` is a special datatype that Geopandas adds to the normal Pandas datatypes.)

> Note that the method to do this is `.points_from_xy`, so we need to specify the **longitude** *before* **latitude**, contrary to the standard way map coordinates are referenced. (It would have been nice for map-makers and mathematicians to have standardized this ages ago!)

As we do this, we need to specify a [CRS](https://pro.arcgis.com/en/pro-app/latest/help/mapping/properties/coordinate-systems-and-projections.htm) (coordinate reference system).

Finally, we will convert the `ff_df` from a Pandas DF to a Geopandas DF.


```python
ff_df['points'] = gpd.points_from_xy(ff_df.longitude, ff_df.latitude, crs="EPSG:4326")
ff_df = gpd.GeoDataFrame(data=ff_df,geometry='points')
```

Since we need to make sure the two DFs use the same CRS so that the data will line up correctly, we will encode the `counties` with the same CRS we specify for the `points` field.



```python
counties = counties.to_crs('EPSG:4326')
counties.crs

    <Geographic 2D CRS: EPSG:4326>
    Name: WGS 84
    Axis Info [ellipsoidal]:
    - Lat[north]: Geodetic latitude (degree)
    - Lon[east]: Geodetic longitude (degree)
    Area of Use:
    - name: World.
    - bounds: (-180.0, -90.0, 180.0, 90.0)
    Datum: World Geodetic System 1984 ensemble
    - Ellipsoid: WGS 84
    - Prime Meridian: Greenwich
```


Now that our two DFs are encoded with the same CRS, we can do a `geopandas.sjoin()`.

The **.sjoin()** is a **spacial join** that merges the data from the two DFs. For each row, it will take the value in the `points` column and locate it in the `counties` dataframe's `geometry` column. Once found, it will return the FIPS value.

We need to specify the name of the two DFs (*left* and *right*) and specify how to do the `.sjoin()`.

We specify `how=left` to tell Geopandas to use the `ff_df` as the main DF, to which we will add data from the `right_df` (=`counties`).

The end result will be that we add the FIPS values to the `ff_df`. (It will also add some fields we don't need, including the index number and county name from the `counties` DF; we can ignore these.)


```python
ff_df = gpd.sjoin(left_df = ff_df,
                  right_df = counties,
                  how = 'left')

ff_df.info()

    <class 'geopandas.geodataframe.GeoDataFrame'>
    Int64Index: 7496 entries, 0 to 8408
    Data columns (total 23 columns):
     #   Column                      Non-Null Count  Dtype         
    ---  ------                      --------------  -----         
     0   id                          7496 non-null   int64         
     1   date                        7496 non-null   datetime64[ns]
     2   threat_type                 7487 non-null   object        
     3   flee_status                 6605 non-null   object        
     4   armed_with                  7299 non-null   object        
     5   city                        7489 non-null   object        
     6   county                      3480 non-null   object        
     7   state                       7496 non-null   object        
     8   latitude                    7496 non-null   float64       
     9   longitude                   7496 non-null   float64       
     10  location_precision          7496 non-null   object        
     11  name                        7078 non-null   object        
     12  age                         7040 non-null   float64       
     13  gender                      7462 non-null   object        
     14  race                        6492 non-null   object        
     15  race_source                 6510 non-null   object        
     16  was_mental_illness_related  7496 non-null   bool          
     17  body_camera                 7496 non-null   bool          
     18  agency_ids                  7496 non-null   object        
     19  points                      7496 non-null   geometry      
     20  index_right                 7489 non-null   float64       
     21  FIPS                        7489 non-null   object        
     22  NAME                        7489 non-null   object        
    dtypes: bool(2), datetime64[ns](1), float64(4), geometry(1), int64(1), object(14)
    memory usage: 1.3+ MB
```

## Define the Question
Now that we have (1) a DF with data (`ff_df`) and (2) a DF with county geometries (`counties`) that share a common field (`FIPS`) we are ready to draw a map.

What do we want to show?

For our first map, we will show which counties had the most instances of police killing civilians. We will create a new DF (`map_df`), which will summarize the data in the `ff_df` so we can create a choropleth map with it.

We can do this by simply doing a `value_counts()` on the `FIPS` column:


```python
map_df = ff_df[['FIPS']].value_counts()
map_df

    FIPS
    06037    302
    04013    200
    48201    114
    06071     95
    32003     89
            ...
    29055      1
    29063      1
    29071      1
    29083      1
    56029      1
    Length: 1522, dtype: int64
```


This shows that around 50% of counties in the USA have had at least one instance of someone being killed by a police officer.

Note: although I've called the variable `map_df`, it is actually a Pandas `series`.  This can be seen by using the `type()` command.

```python
type(map_df)

    pandas.core.series.Series
```

To convert it to a DF, we will reset the index:


```python
map_df = map_df.reset_index()
map_df
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>FIPS</th>
      <th>0</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>06037</td>
      <td>302</td>
    </tr>
    <tr>
      <th>1</th>
      <td>04013</td>
      <td>200</td>
    </tr>
    <tr>
      <th>2</th>
      <td>48201</td>
      <td>114</td>
    </tr>
    <tr>
      <th>3</th>
      <td>06071</td>
      <td>95</td>
    </tr>
    <tr>
      <th>4</th>
      <td>32003</td>
      <td>89</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1517</th>
      <td>29055</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1518</th>
      <td>29063</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1519</th>
      <td>29071</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1520</th>
      <td>29083</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1521</th>
      <td>56029</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
<p>1522 rows × 2 columns</p>

And we need to rename the `0` column to have a more informative name!

```python
map_df.rename(columns={0:'count'},inplace=True)
```

## Draw the Map
Folium makes it easy to create a wide variety of maps. Users can specify a variety of different basemaps (terrain, street maps, different colors) and display data with different markers, such as pins or circles. These can use different colors or sizes based on the data. Folium has a useful  [Quickstart](https://python-visualization.github.io/folium/quickstart.html) that serves as an introduction to the library.

We will be using Folium to create our choropleth map.

We first need to initialize a Map. Folium has [default values](https://python-visualization.github.io/folium/modules.html) for many of its parameters, but we need to passs a value for the center of the map. I find the default zoom level (`zoom_start = 10`) is too large to show the continental USA well, so we will specify these values:


```python
m = folium.Map(location=[40, -96], zoom_start=4)
```

Once we have inititalized the map, we can draw the map and display it.


```python
folium.Choropleth(
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','count'],
        key_on = 'feature.properties.FIPS',
        bins = 9,
        fill_color='OrRd',
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings (2015-present)'
        ).add_to(m)

m # this displays the map
```


Output hidden; open in https://colab.research.google.com to view.

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-02.png" alt="Visual description of figure image" caption="Figure 2. Caption text to display" %}
![png](Images/Map01.png)


Before we talk about why this map is so uniform (and thus not terribly useful), let me briefly describe the different parameters that are being passed to the choroplet method. I've added line numbers to help with the explanation.

Here's the code:
```python
1 folium.Choropleth(
2        geo_data = counties,
3        key_on = 'feature.properties.FIPS',
4        data = map_df,
5        columns = ['FIPS','count'],
6        bins = 9,
7        fill_color='OrRd',
8        fill_opacity=0.8,
9        line_opacity=0.2,
10       nan_fill_color = 'grey',
11       legend_name='Percent of county population that is affiliated with a congregration'
12       ).add_to(m)
```

* Line 1 calls the `folium.Choropleth()` method and line 12 adds it to the map that we initalized earlier. The method plots a GeoJSON overlay on the basemap.
* Line 2 (`geo_data=`) identifies the GeoJSON source of the geographic geometries to be plotted. This is the `counties` dataframe we downloaded from the US Census bureau.
* Line 3 (`key_on=`) identifies the field in the GeoJSON data that will be bound (or linked) to the data from the `map_df`: we need to have one column in common between our dataframes. In this case, it will be the `FIPS` column.
* Line 4 (`data=`) identifies the source of the data to be analyzed and plotted. This is the `map_df` dataframe that we created from the fatal force dataframe (`ff_df`).
* Line 5 is required because we're using a Pandas DF as the data source. This parameter tells Folium which columns in the DF specified by the `data=` parameter to use.
 * The first value is the column name that will be matched with the `key_on=` value.
 * The second field has the values to be used to draw the choropleth map's colors.
 * Note: the two data sources don't need to have the same name for the field/column, but the *data* needs to be in common. We could have left the US Census' name (GEOID) alone. If we had, these lines would look like this:

```python
2 geo_data = counties,
3 key_on = 'feature.properties.GEOID',
4 data = map_df,
5 columns = ['FIPS','count'],
```

 * While this would work, since the data is the same (`GEOID` data = `FIPS` data), I think it clearer to use the same name.
* Line 6 (`bins=`) specifies how many bins into which to sort the data values. (The maximum number is limited by the number of colors in the color palette selected. This is often 9.)
* Line 7 (`fill_color=`) specifies the color palette to use. Folium's documentation identifes the following as built-in palettes: ‘BuGn’, ‘BuPu’, ‘GnBu’, ‘OrRd’, ‘PuBu’, ‘PuBuGn’, ‘PuRd’, ‘RdPu’, ‘YlGn’, ‘YlGnBu’, ‘YlOrBr’, and ‘YlOrRd’.
* Lines 8 (`fill_opacity=`) and 9 (`line_opacity=`) specify how opaque the overlay should be. The values range from 0 (transparent) to 1 (completely opaque). I like being able to see through the color layer a bit, so I can see city names, highways, etc.
* Line 10 (`nan_fill_color=`) tells Folium what color to use for counties lacking data ([NaN](https://pandas.pydata.org/pandas-docs/stable/user_guide/missing_data.html) = "not a number" which is what Pandas uses when missing data). This color should be distinctive from the color of the palette, so it is clear that data is missing.
* Line 11 (`legend_name=`) allows us to label the scale; this is optional but helpful, so people know what they're reading.

For a complete list of parameters, see the Choropleth documentation in [Folium](https://python-visualization.github.io/folium/modules.html?highlight=choro#folium.features.Choropleth)

## The Problem of Uneven Distribution of Data

OK, back to our map. Why is the whole US is basically one color?

The grey counties are those for which the *Post* does not record any cases of fatal police shootings; this is about 50% of the counties in the USA.

But almost all the rest of the counties are a pale-yellow color. The exceptions are a few major urban areas (Chicago, Detroit, and Columbus, OH; the biggest exceptions are in the Southwest and, especially, Los Angeles.

This is not terribly helpful. Why is the whole country mostly one color?

The clue is to look at the scale: it goes from zero to 302.

Let's look at our data a bit more. Pandas' [`.describe()`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.describe.html) method provides a useful summary of the data, including the mean, standard deviation, median, and quartile information.


```python
map_df.describe()
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>1522.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>4.920499</td>
    </tr>
    <tr>
      <th>std</th>
      <td>12.691178</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>1.000000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>2.000000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>4.000000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>302.000000</td>
    </tr>
  </tbody>
</table>

This shows:
1. 1,522 counties (out of the 3,142 in the USA) have reported at least one police killing.
1. At least 75% of these counties have had 4 or fewer killings.
Thus, there must be a few counties in the top quartile that have had many more killings.

I find the easiest way to figure out what's going on with the data is to visualize it with a [boxplot](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.boxplot.html).
> Pandas could also display this as a histogram `(map_df.hist(bins=20))` but if the Y-scale is large (as it will be on this distribution of data), it can be very hard to see the outlying points on the right-side of the distribution. A `boxplot` shows these values better.

> The default boxplot is vertical, but since most monitors are landscape-orientation, when I'm displaying the data on my monitor, I prefer to make the boxplot horizontal. To display the boxplot vertically, omit the `vert=False` keyword.


```python
map_df.boxplot(vert=False)
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-03.png" alt="Visual description of figure image" caption="Figure 3. Caption text to display" %}
![png](Images/PH_ChrorplethFatalForceDB_57_1.png)


This allows us to see that there are only about six counties where police have killed more than 75 civilians.

I frequently encounter this sort of challenge with the data when I want to draw a choropleth map. The problem is that Folium's algorithm divides the data range into an even number of 'bins' (specified in line 6 above).

In this case, I specified 9 bins, so each bin will be about 33 units wide ($302 / 9 = 33.5$).

* Bin 1 (0 - 34) will have almost all our data (since 75% of all all values are 4 or less).
* Bin 2 (34-67) will have almost all the rest of the data, judging by the boxplot
* Bin 3 (68-100) will have a handful of cases
* Bin 4 (101-134) will have 1 case
* Bin 5 (135-167) will have 0 cases
* Bin 6 (168-201) will have 1 case
* Bins 7 and 8 (202-268) will have 0 cases
* Bin 9 (269-302) will have one case

Because the scale needs to cover ALL cases, when the vast majority of cases are in one or two bins, the map is not terribly informative.

There are solutions to this problem, but none are ideal; some work better with some distributions of data than others and mapmakers may need to experiment to see what map works best for a given set of data.


### Solution #1: Fisher-Jenks algorithm
Folium allows users to pass a parameter to the choropleth algorithm that will automatically calculate "natural breaks" in the data; Folium's [documentation says](https://python-visualization.github.io/folium/modules.html?highlight=choro#folium.features.Choropleth) "this is useful when your data is uneavenly distributed."

To use this, one needs to install the [jenkspy](https://pypi.org/project/jenkspy/) library. In Colab, this can be done by with a bash command to run pip and install the library (exactly as we installed GeoPandas above).


```python
! pip install jenkspy

    Looking in indexes: https://pypi.org/simple, https://us-python.pkg.dev/colab-wheels/public/simple/
    Collecting jenkspy
      Downloading jenkspy-0.3.2-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (524 kB)
    [2K     [90m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m524.0/524.0 kB[0m [31m13.8 MB/s[0m eta [36m0:00:00[0m
    [?25hRequirement already satisfied: numpy in /usr/local/lib/python3.9/dist-packages (from jenkspy) (1.22.4)
    Installing collected packages: jenkspy
    Successfully installed jenkspy-0.3.2
```

Now that the `jenkspy` library is installed, we can pass the parameter to Folium and redraw our map.


```python
 m = folium.Map(location=[40, -96], zoom_start=4)
 # we need to initialize the map again.
 # if we don't, it will add the new choropleth data on top of the old data
 # alternately, we could create a new map (m2 = ...)

folium.Choropleth(
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','count'],
        key_on = 'feature.properties.FIPS',
        bins = 9,
        fill_color='OrRd',
        use_jenks = True, # <-- this is the new parameter we're passing to Folium
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings (2015-present)'
        ).add_to(m)

m

```


    Output hidden; open in https://colab.research.google.com to view.

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-04.png" alt="Visual description of figure image" caption="Figure 4. Caption text to display" %}
![png](Images/Map02.png)


This is an improvement: the map shows a better range of contrasts. We can see that there are a fair number of counties outside the Southwest where police have killed several people (Florida, the Northwest, etc.)

But the scale is almost impossible to read! The algorithm correctly found natural breaks -- most of the values are less than 114, but especially at the lower end of the scale the numbers are illigible.

For some distributions, using the `use_jenks = True` parameter might work.

### Solution #2: Create a scale variable
Rather than plotting the data, we could create a different variable that we can use for the scale.

I will suggest three different ways to calculate a scale variable. Before I do so, let me explain how to do this in Pandas.

#### **How to add a scale-value column**
Our goal is to add a column to the `map_df` dataframe that will convert the values in the `PctTotPop` column to a new set of values to be used with the coloring/scale. We will call this new column `MapScale`.

For this explanation, I will assume that we will cap the scale at 50. For each row in the dataframe, we will look at the county's value and leave it alone if it is less than 50; if it is over 50, we will set it to 50.

In Python, a function to do this would look like this:
```python
def capValue(x):
  if x < 50:
    return x
  else:
    return 50
```

Pandas allows us apply this function to our data with the [`.apply()`](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.apply.html) method.

We provide the name of the new column (`map_df['MapScale']`) and tell Pandas to take the values from an existing column (`map_df['PctTotPop']`) and `.apply()` the function to populate the new column with values:
```python
map_df['MapScale'] = map_df['count'].apply(capValue)
```

The whole code block, then, would be this:
```python
def capValue(x):
  if x < 50:
    return x
  else:
    return 50

map_df['MapScale'] = map_df['count'].apply(capValue)
```

Alternately, we can achieve the same result with a  [lambda function](https://www.geeksforgeeks.org/python-lambda-anonymous-functions-filter-map-reduce/).

The lambda function is preferred because it is more compact but still easy to understand. A lambda function doesn't require defining a fuction (we we did with `capValue(x)` above. The lambda function can be run directly within the `.apply()` method.

Using the lambda function requires only one line:
```python
map_df['MapScale'] = map_df['count'].apply(lambda x: x if x<50 else 50)
```
Now that we know how to add a new column of values for our scale, let's look at a few options.

#### **Method 1: Use a Log Scale**
Log scales are very useful when the data has a wide distribution.

 The [definition of a logarithm](http://www.mclph.umn.edu/mathrefresh/logs3.html) is
$b^r = a$ or $log$<sub>b</sub>$a=r$.

That is, the log value is the **exponent** ($r$) that the base number ($b$) would be raised to equal the original value ($a$).

For base 10, this is easy to calculate:
>$10 = 10^1$ so $log$<sub>10</sub>$(10) =1$

>$100 = 10^2$ so $log$<sub>10</sub>$(100) =2$

Thus, using a base 10 logarithm, each time a log value increase by 1, the original value would increase 10 times. The most familiar example of a log scale is probably the [Richter scale](https://en.wikipedia.org/wiki/Richter_magnitude_scale), used to measure earthquakes.



For our current data, since most counties have fewer than 5 police killings, most counties will have a log value between $0$ and $1$. The biggest value (302) have a log value of between 2 and 3 (that is, between $10^2$ and $10^3$).

To add a scale variable with a log10.
1. We will need to import [numpy](https://numpy.org/), the standard library for scientific computing in Python. (Since numpy is included in Colab's collection of libraries, we need not install it with `pip`.)
2. We will then use numpy's `.log10()` method to create our new scale column. Because $log10(0)$ is undefined, when the `count` is zero, we need to manually set the `MapScale` value to zero. We will do this with `.apply()` and a lambda function.


```python
import numpy as np
map_df['MapScale'] = map_df['count'].apply(lambda x: np.log10(x) if x>0 else 0)

```

As we map the data again, we will remove the `use_jenks` parameter and change the column of data we want to use for the scale.


```python
 m = folium.Map(location=[40, -96], zoom_start=4)

folium.Choropleth(
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','MapScale'], # <== change the column to use for map colors
        key_on = 'feature.properties.FIPS',
        bins = 9,
        fill_color='OrRd',
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings (2015-present) (log scale)'
        ).add_to(m)

m
```


    Output hidden; open in https://colab.research.google.com to view.

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-05.png" alt="Visual description of figure image" caption="Figure 5. Caption text to display" %}
![png](Images/Map03.png)


This is better than the earlier two: we can see more distinctions between the values on our map.

Unfortunately, the problem for EVERY log scale is that **most people won't know know to interpret it** -- what is the non-log (original) value of 1.5 or 1.8 on a log scale?

Even if folks remember the definition of logrithm (that is, that the when the scale says 1.5, the original value is 10<sup>1.5</sup>), if they don't have a calculator, they won't be able to convert the log values to the original number!

Unfortunately, Folium doesn't have a built-in way to address this problem. Instead, we need to import the `branca` library and use some JavaScript to create a new scale.

Frankly, while I have a vague idea of what the following code does (while I haven't studied JavaScript, I can tell it's looping through the tick values and replacing log values with original values), it is also doing some stuff with HTML that I haven't dug into. [Kota7](https://github.com/kota7) provided this solution in the [Folium Github issues discussion board](https://github.com/python-visualization/folium/issues/1374).

```python
from branca.element import Element
e = Element("""
  var ticks = document.querySelectorAll('div.legend g.tick text')
  for(var i = 0; i < ticks.length; i++) {
    var value = parseFloat(ticks[i].textContent.replace(',', ''))
    var newvalue = Math.pow(10.0, value).toFixed(1).toString()
    ticks[i].textContent = newvalue
  }
""")
colormap = cp.color_scale
html = colormap.get_root()
html.script.get_root().render()
html.script.add_child(e)
```
To use this, we need to create a new variable (in the following example, it is **cp** (for **c**horo**p**leth), which is accessed by the code above.

Here's what the code looks like with this fragment included.

You can see that the scale on the map is correctly modified.


```python
m = folium.Map(location=[40, -96], zoom_start=4)

cp = folium.Choropleth( #<== cp is the variable that has been added
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','MapScale'],
        key_on = 'feature.properties.FIPS',
        bins = 9,
        fill_color='OrRd',
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings (2015-present) (log scale)'
        ).add_to(m)

from branca.element import Element
e = Element("""
  var ticks = document.querySelectorAll('div.legend g.tick text')
  for(var i = 0; i < ticks.length; i++) {
    var value = parseFloat(ticks[i].textContent.replace(',', ''))
    var newvalue = Math.pow(10.0, value).toFixed(1).toString()
    ticks[i].textContent = newvalue
  }
""")
colormap = cp.color_scale
html = colormap.get_root()
html.script.get_root().render()
html.script.add_child(e)

m

```


    Output hidden; open in https://colab.research.google.com to view.

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-06.png" alt="Visual description of figure image" caption="Figure 6. Caption text to display" %}
![png](Images/Map04.png)


Note that the log values on the scale have been converted to the original (non-log) values.  Note, too, that the bins are not equal size: they advance exponentially, in line with their log10 values.

#### **Method 2: Cap the Scale Manually**
We can cap the scale at some value. We could look at the boxplot (or the `.describe()` output) and decide to cap the scale at 25.

This is straightforward, so let's redefine our `MapScale` variable and re-draw the map.


```python
map_df['MapScale'] = map_df['count'].apply(lambda x: x if x<25 else 25)
```


```python
m = folium.Map(location=[40, -96], zoom_start=4)

folium.Choropleth(
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','MapScale'],
        key_on = 'feature.properties.FIPS',
        bins = 9,
        fill_color='OrRd',
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings (2015-present)'
        ).add_to(m)

m
```


    Output hidden; open in https://colab.research.google.com to view.

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-07.png" alt="Visual description of figure image" caption="Figure 7. Caption text to display" %}
![png](Images/Map05.png)


#### **Method 3: Cap the Scale Automatically**
In the prior case, we looked at the data's values and determined a "reasonable" cap value for the scale.

But looking at the data (however we do so) and picking a number that "looks good" is arbitrary and hard to explain / defend.

A more defensible method would be to set the cap at a value that could be determined automatically from the data. For example, we could set the cap at, say, the 95% quantile (or 97%<sup>th</sup> or 99%<sup>th</sup>). This would ensure the values for 95% of the data are correct; only the top 5% would be lumped together.

We can find the quantile value in a column of by using the [`.quantile()`](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.quantile.html) function.

To find the value at the 95th quantile for the `count` column of the `map_df` dataframe we would do the following:


```python
map_df.quantile(q=0.95,numeric_only=True)['count']

    17.0
```


This tells us that in 95% of all counties, police have killed 17 or fewer civilians.

Since we can use this formula on any DF, we can automate the selection of the `MapScale` variable:

```python
scale_cap = map_df.quantile(q=.95,numeric_only = True)['count']
map_df['MapScale'] = map_df['count'].apply(lambda x: x if x<scale_cap else scale_cap)
```

There are other ways to define the cap:
* We could cap the value using the definition used by the [box plot algorithm](https://discovery.cs.illinois.edu/learn/Exploratory-Data-Analysis/Quartiles-and-Box-Plots/) to determine the length of the "whisker" (75% quartile +  $1.5 * IRQ$); values beyond the "whisker" are considered outliers.
* Or we could cap the value at the mean + 3 * SD. In a normal distribution, this would typically cover [99.7%](https://en.wikipedia.org/wiki/68%E2%80%9395%E2%80%9399.7_rule) of all data values. Unfortunately, this data in not [normally distributed](https://en.wikipedia.org/wiki/Normal_distribution).

In short, if the data has a few extreme outliers that would otherwise compress the color scheme so much that it's not usefully intelligible, we may need to explore capping the data scale.

There may be instances where the problem is outliers on the left-side of the distribution; the same process would be followed, but in this case, we would be establishing a floor for the data. But we would follow the same process.

Let's set the cap to 98% and see how it affects the map's appearance.


```python
scale_cap = map_df.quantile(q=.98,numeric_only = True)['count']
map_df['MapScale'] = map_df['count'].apply(lambda x: x if x<scale_cap else scale_cap)

m = folium.Map(location=[40, -96], zoom_start=4)

folium.Choropleth(
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','MapScale'],
        key_on = 'feature.properties.FIPS',
        bins = 9,
        fill_color='OrRd',
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings (2015-present)'
        ).add_to(m)

m
```


    Output hidden; open in https://colab.research.google.com to view.
CHECK THIS MAP!

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-08.png" alt="Visual description of figure image" caption="Figure 8. Caption text to display" %}
![png](Images/Map06.png)

#### Problem with Capping the Data

There is one **HUGE** problem with capping the data: *it no longer actually reflects the data accurately*.

Even if only 3% of data is lumped together at the top of the scale, it has a dramatic affect on the map's appearance. You can see if if you compare the the map immediately above with the earlier maps.

Users will need to think carefully about how to deal with the problem of unevenly distribute data and the best way to deal with it.

If we *must* cap the data, the mapmaker can help explain the data by adding a box that will show the actual values when the user puts their cursor over the county. I will explain how to do this in the next section.

## Improving Folium Maps


### Add a Floating Information Box
Folium allows the user to add a pop-up box that can display information about an area (or point) when the cursor is moved over it.

If we have capped the scale (see above) we can use this to report the true value.

Even if we haven't capped the scale, this can help users, since the choropleth map shows bins of data: if a bin encompasses a range of, say 20 cases (or percent), we might want to know the actual value: 20% is very different than 39%.

To add the floating info box, we will use a Folium method called `folium.GeoJsonTooltip()`.

To use this method, we need to edit the underlying GeoJSON data. We will create the same choropleth map, but we will assign it to a variable name, so we can edit the GeoJSON data.


```python
m = folium.Map(location=[40, -96], zoom_start=4)

cp = folium.Choropleth( # <- add the 'cp' variable
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','MapScale'],
        key_on = 'feature.properties.FIPS',
        bins = 9,
        fill_color='OrRd',
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings (2015-present)'
        ).add_to(m)

```

The new `cp` (**c**horo**p**leth) variable allows us to look at the underlying GeoJSON data. GeoJSON data looks like other JSON files: akin to a list of nested Python [dictionary](https://www.geeksforgeeks.org/python-dictionary/) entries.

Counties are 'feature' types and have  properties associated with them such as a FIPS number and the county's name. Their geometry is also included in the data.
```python
[{'id': '0',
  'type': 'Feature',
  'properties': {'FIPS': '01059', 'NAME': 'Franklin'},
  'geometry': {'type': 'Polygon',
   'coordinates': [[[-88.16591, 34.380926],
     [-88.165634, 34.383102],
     [-88.156292, 34.463214],
     [-88.139988, 34.581703],
     [-87.529667, 34.567081],
     [-87.529722, 34.304598],
     [-87.634725, 34.306997],
     [-88.173632, 34.321054],
     [-88.16591, 34.380926]]]},
  'bbox': [-88.173632, 34.304598, -87.529667, 34.581703]},
 {'id': '1',
  'type': 'Feature',
  'properties': {'FIPS': '06057', 'NAME': 'Nevada'},
  'geometry': {'type': 'Polygon',
   'coordinates': [[[-121.27953, 39.230537],
     [-121.259182, 39.256421],
     [-121.266132, 39.272717],
     [-121.240146, 39.283997],
     [-121.220979, 39.282573],
     [-121.200146, 39.302375],
     [-121.206352, 39.316469],
     [-121.178977, 39.33856],
     ...
```


The GeoJsonTooltip() method allows us to extract and display data in the `properties` dictionary. Unfortunately, since the `count` data is found in the `map_df` dataframe, we need to add it to the GeoJSON properties dictionary.

We can do this by iterating over the GeoJSON data, finding the information in our `map_df` dataframe, and adding it to the GeoJSON properties dictionary. Here's how we can do this:
1. Create a `map_data_lookup` dataframe that uses FIPS as its index. This allows us to search for each county's FIPS number and return the PctTotPop value.
1. Iterate over the GeoJSON data and add a new property variable, with the data from the map_df table.

The next cell shows the code to do this:

```python
map_data_lookup = map_df.set_index('FIPS')

for row in cp.geojson.data['features']:
  try:
      row['properties']['count'] = f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.2f}"
  except KeyError:
      row['properties']['count'] = 'No police killings reported'
```

We iterate over all rows in the 'features' part of the GeoJSON data.

```python
for row in cp.geojson.data['features']
```
For each row, we add a new entry in the `properties` dictionary, with a new `key`/`value` pair. The `key` is `count` and the `value` we get from the `map_data_lookup` dataframe.

The magic happens in this line:
```python
row['properties']['count'] = f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.0f}"
```
Because this line is complex, I will explain it, bit by bit.

`row['properties']['count']` creates a new `key` in the `cp` variable's `properties` dictionary called `count`.  

We assign a `value` to the `key` by using the `.loc` method to find it in the `map_data_lookup` dataframe.

The [`.loc`](https://www.geeksforgeeks.org/python-pandas-dataframe-loc/) method returns a value from a dataframe when we specify the `index value` and `column name`:
```python
value = df.loc[index,col]
```
Since the `map_data_lookup` df uses FIPS numbers as its index, we can find `'count'` for a given FIPS value:
```python
value = map_data_lookup[desired_FIPS,'count']
```
The GeoJSON data has FIPS values for all counties. We pass the FIPS for which we want to find the value from the current row of GeoJSON data with this: `row['properties']['FIPS']`:
```python
value = map_data_lookup[row['properties']['FIPS'],'count']
```
We wrap the value in a f-string to format it as a string and to limit the number to 0 decimal places (since all the `count` values should be whole numbers):
```python
value = f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.0f}"
```
If the `.loc` method doesn't find the FIPS value in the `map_data_lookup` DF, it will stop execution and report a `KeyError`. The `try:` and `except:` statements keep the program from stopping and provide a default value when an error is encountered.  

Once our GeoJSON data has been updated, we call the `folium.GeoJsonTooltip()` method. It takes a list of keys from the GeoJSON data's property dictionary: the values associated with these keys will be displayed.

We can provide aliases, which is the text to be displayed in the tool tip box.

Finally, we tell Folium to save this information to `cp.geojson`, which it will interpret to create the map.



```python
folium.GeoJsonTooltip(['NAME','count'],
                      aliases=['County:','Num of Police Killings:']).add_to(cp.geojson)
```

We will take our prior map (with the data capped at 97% of cases) and add the code above to create the popup box.


```python
scale_cap = map_df.quantile(q=.97,numeric_only = True)['count']
map_df['MapScale'] = map_df['count'].apply(lambda x: x if x<scale_cap else scale_cap)

m = folium.Map(location=[40, -96], zoom_start=4)

cp = folium.Choropleth( #<== cp is the variable that has been added
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','MapScale'],
        key_on = 'feature.properties.FIPS',
        bins = 9,
        fill_color='OrRd',
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings (2015-present)'
        ).add_to(m)

map_data_lookup = map_df.set_index('FIPS')

for row in cp.geojson.data['features']:
  try:
      row['properties']['count'] = f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.0f}"
  except KeyError:
      row['properties']['count'] = 'No police killings reported'

folium.GeoJsonTooltip(['NAME','count'],aliases=['County:','N killed by Police:']).add_to(cp.geojson)

m
```


    Output hidden; open in https://colab.research.google.com to view.


{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-09.png" alt="Visual description of figure image" caption="Figure 9. Caption text to display" %}
![png](Images/Map07.png)

### Add a Mini Map
Since Folium allows users to zoom in and out and to move the map around, sometimes they might be unsure where they are. Folium helps with this by allowing a Minimap to be added to the corner of the main map.

We need to import Folium's `plugins` library and after that, adding the map is very easy.

I will demonstrate this in the next cell, just adding the Minimap to the previous map.



```python
from folium import plugins
minimap = plugins.MiniMap()
m.add_child(minimap)

m
```


    Output hidden; open in https://colab.research.google.com to view.

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-10.png" alt="Visual description of figure image" caption="Figure 10. Caption text to display" %}
![png](Images/Map08.png)

### Add a Title
Adding a title to the Folium map is a little tricky. Here's what the next cell does:
1. Define the text to use as the title
1. Format the text with to be centered, bold, and 16 pixels tall in a line of HTML code.
1. Add the HTML code to the map.




```python
titleText = """Number of people killed by police in each county"""
title_html = '''
             <h4 align="center" style="font-size:16px"><b>{}</b></h4>
             '''.format(titleText)
m.get_root().html.add_child(folium.Element(title_html))
```

Here's how this would look in the code


```python
scale_cap = map_df.quantile(q=.97,numeric_only = True)['count']
map_df['MapScale'] = map_df['count'].apply(lambda x: x if x<scale_cap else scale_cap)

m = folium.Map(location=[40, -96], zoom_start=4)

titleText = """Number of people killed by police in each county"""
title_html = '''
             <h4 align="center" style="font-size:16px"><b>{}</b></h4>
             '''.format(titleText)
m.get_root().html.add_child(folium.Element(title_html))

cp = folium.Choropleth(
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','MapScale'],
        key_on = 'feature.properties.FIPS',
        bins = 9,
        fill_color='OrRd',
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings (2015-present)'
        ).add_to(m)

map_data_lookup = map_df.set_index('FIPS')

for row in cp.geojson.data['features']:
  try:
      row['properties']['count'] = f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.0f}"
  except KeyError:
      row['properties']['count'] = 'No police killings reported'

folium.GeoJsonTooltip(['NAME','count'],aliases=['County:','N killed by Police:']).add_to(cp.geojson)

m
```


    Output hidden; open in https://colab.research.google.com to view.

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-11.png" alt="Visual description of figure image" caption="Figure 11. Caption text to display" %}
![png](Images/Map09.png)

Where you insert the code for the title will determine where it appears relative to the map.
* Placed before the `folium.Choropleth()` call, it will appear above the map.
* Placed afterwards, it will appear below the map.

### Saving Maps
Maps are saved as HTML files. They can be shared with other people, who can open them in a browser will have the ability to zoom, pan, and examine individual county statistics with by putting their cursor over different counties.

Folium allows us to save maps easily with the `.save()` method.


```python
m.save('PoliceKillingsOfCivilians.html')
```

Note that this saves the file to the Colab virtual drive. Remember: **Everything on the virtual drive will disappear** when the Colab session is closed.

You can see the files you have saved to the virtual drive by clicking on the file folder in the left margin of the browser window.

![image.png](data:image/png;base64,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)

To save the file to your local drive, hover your cursor over the file and select "Download." This will download the file to your local hard-drive's default download folder.

![image.png](data:image/png;base64,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)

Because Folium saves the maps as HTML documents, they can be added to websites or shared with other people, who can open them with a web-brower.


## Conclusion
Choropleth maps are an excellent tool for discovering patterns in data that might be otherwise hard to discern.

They have myrid uses: I've used them to examine how the Payroll Protection Act funds were allocated to religious groups by Congressional dictrict and by county. I discovered that the regions that benefited disproportinately were often those represented by politicians who typically decry "government handouts." Lower income counties also benefitted far more than higher income counties.

I've also used Folium to examine where bicycle accidents are reported in Chicago, mapping locations (what streets / intersections are most dangerous) and creating choropleth maps of the number of accidents in different city council wards and police precincts.

In short, Folium is an incredibly useful tool for mapping and visualizing data.

## Appendix
The following discussion isn't really about how to use Folium to draw maps. Rather, it is about how to create useful or meaningful maps and how we need to process data to achieve this goal.

### Normalizing Population Data
One issue with choropleth maps that display data about people is that this data tends to correlate closely with population centers. For example: during the Covid-19 pandemic, there were MANY more cases in Cook County, IL with a population of over 5 million, than in Hardin County, IL (pop. 3,900).

The same issue would be arise if we were mapping ocurrences of swine flu (correlated with hog farms), corn leaf blight (correlated with regions that grow corn), etc.

This is why choropleth maps often do not chart raw numbers (as we did above). It is often more appropriate to consider the number of cases per 100,000 population.

To do this, we need to get a dataset that includes county-by-county population statistics that, ideally, include a FIPS code.



I found this data at the [US Census Bureau](https://www.census.gov/), which has a huge number of [datasets](https://www.census.gov/data/datasets.html) that it provides the public.

The full dataset is huge, but when I read the [documentation](https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.pdf), I realized I only needed three columns: `STATE`,`COUNTY`, and `POPESTIMATE2019`. (I selected 2019 because the *Post*'s data extends from 2015 to present; 2019 is roughly in the middle of that time frame).

Rather than loading the full database, Pandas allows me to specify specific columns to include with the `usecols` parameter.


```python
pop_df = pd.read_csv('https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.csv',
                         usecols = ['STATE','COUNTY','POPESTIMATE2019'])

---------------------------------------------------------------------------

    UnicodeDecodeError                        Traceback (most recent call last)

    <ipython-input-75-909593c068cb> in <cell line: 1>()
    ----> 1 pop_df = pd.read_csv('https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.csv',
          2                          usecols = ['STATE','COUNTY','POPESTIMATE2019'])
          3 pop_df.head()

<SNIP>

    UnicodeDecodeError: 'utf-8' codec can't decode byte 0xf1 in position 253967: invalid continuation byte
```

Annoying -- `utf-8` is the most common encoding (and the default for Pandas when reading CSV files). But there are others. I Googled this and came up with a suggestion for a different encoding. I'll specify it and see if I can get around the error....


```python
pop_df = pd.read_csv('https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.csv',
                         usecols = ['STATE','COUNTY','POPESTIMATE2019'],
                         encoding = "ISO-8859-1")
pop_df.head()
```
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>STATE</th>
      <th>COUNTY</th>
      <th>POPESTIMATE2019</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>0</td>
      <td>4903185</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>1</td>
      <td>55869</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1</td>
      <td>3</td>
      <td>223234</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>5</td>
      <td>24686</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1</td>
      <td>7</td>
      <td>22394</td>
    </tr>
  </tbody>
</table>



```python
pop_df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 3193 entries, 0 to 3192
    Data columns (total 3 columns):
     #   Column           Non-Null Count  Dtype
    ---  ------           --------------  -----
     0   STATE            3193 non-null   int64
     1   COUNTY           3193 non-null   int64
     2   POPESTIMATE2019  3193 non-null   int64
    dtypes: int64(3)
    memory usage: 75.0 KB


In the other DFs, the FIPS is an `object` (=string) datatype. Here, they've been loaded as numbers (`int64`).

So I need
1. to convert them to a string -- with [.astype(str)](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.astype.html)
1. add leading zeros -- with .str.[zfill](https://www.geeksforgeeks.org/python-pandas-series-str-zfill/)(2)
1. Combine these two columns into a `FIPS` column


```python
pop_df['STATE'] = pop_df['STATE'].astype(str).str.zfill(2) # convert to string, and add leading zeros
pop_df['COUNTY'] = pop_df['COUNTY'].astype(str).str.zfill(3)
pop_df['FIPS'] = pop_df['STATE'] + pop_df['COUNTY'] # combine the state and county fields to create a FIPS
pop_df.head()

```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>STATE</th>
      <th>COUNTY</th>
      <th>POPESTIMATE2019</th>
      <th>FIPS</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>01</td>
      <td>000</td>
      <td>4903185</td>
      <td>01000</td>
    </tr>
    <tr>
      <th>1</th>
      <td>01</td>
      <td>001</td>
      <td>55869</td>
      <td>01001</td>
    </tr>
    <tr>
      <th>2</th>
      <td>01</td>
      <td>003</td>
      <td>223234</td>
      <td>01003</td>
    </tr>
    <tr>
      <th>3</th>
      <td>01</td>
      <td>005</td>
      <td>24686</td>
      <td>01005</td>
    </tr>
    <tr>
      <th>4</th>
      <td>01</td>
      <td>007</td>
      <td>22394</td>
      <td>01007</td>
    </tr>
  </tbody>
</table>

This table includes population stats for both entire states and individual counties.

State values can be identified because their county code (the last three digits) are $000$ but the county numbers start at $001$ and continue to cover all the counties in the state.

So the first row reports the total population for state $01$ (Alabama), while the second row reports the population for county $001$ in Alabama.

Since our earlier DFs don't include rows with a FIPS number of $XX000$ when we do a join/merge, the state figures will be ignored.

Let's do the [merge](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.merge.html), then we can calculate a _per capita_ number for police shootings.


```python
map_df = map_df.merge(pop_df, on = 'FIPS', how = 'left')
map_df.head()
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>FIPS</th>
      <th>count</th>
      <th>ScaleTotPop</th>
      <th>MapScale</th>
      <th>STATE</th>
      <th>COUNTY</th>
      <th>POPESTIMATE2019</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>06037</td>
      <td>302</td>
      <td>2.480007</td>
      <td>25.0</td>
      <td>06</td>
      <td>037</td>
      <td>10039107.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>04013</td>
      <td>200</td>
      <td>2.301030</td>
      <td>25.0</td>
      <td>04</td>
      <td>013</td>
      <td>4485414.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>48201</td>
      <td>114</td>
      <td>2.056905</td>
      <td>25.0</td>
      <td>48</td>
      <td>201</td>
      <td>4713325.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>06071</td>
      <td>95</td>
      <td>1.977724</td>
      <td>25.0</td>
      <td>06</td>
      <td>071</td>
      <td>2180085.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>32003</td>
      <td>89</td>
      <td>1.949390</td>
      <td>25.0</td>
      <td>32</td>
      <td>003</td>
      <td>2266715.0</td>
    </tr>
  </tbody>
</table>

The map_df has all the columns we've added as we've worked through this notebook. We could tidy it up by deleting them, but there isn't a pressing reason to do so -- it's a relatively small DF (with around 3,100 rows).

For now, let's just add new column that calculates the number of police killings per 100K population.


```python
map_df['count_per_100K'] = map_df['count'] / (map_df['POPESTIMATE2019']/100000)
map_df.head()
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>FIPS</th>
      <th>count</th>
      <th>ScaleTotPop</th>
      <th>MapScale</th>
      <th>STATE</th>
      <th>COUNTY</th>
      <th>POPESTIMATE2019</th>
      <th>count_per_100K</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>06037</td>
      <td>302</td>
      <td>2.480007</td>
      <td>25.0</td>
      <td>06</td>
      <td>037</td>
      <td>10039107.0</td>
      <td>3.008236</td>
    </tr>
    <tr>
      <th>1</th>
      <td>04013</td>
      <td>200</td>
      <td>2.301030</td>
      <td>25.0</td>
      <td>04</td>
      <td>013</td>
      <td>4485414.0</td>
      <td>4.458897</td>
    </tr>
    <tr>
      <th>2</th>
      <td>48201</td>
      <td>114</td>
      <td>2.056905</td>
      <td>25.0</td>
      <td>48</td>
      <td>201</td>
      <td>4713325.0</td>
      <td>2.418675</td>
    </tr>
    <tr>
      <th>3</th>
      <td>06071</td>
      <td>95</td>
      <td>1.977724</td>
      <td>25.0</td>
      <td>06</td>
      <td>071</td>
      <td>2180085.0</td>
      <td>4.357628</td>
    </tr>
    <tr>
      <th>4</th>
      <td>32003</td>
      <td>89</td>
      <td>1.949390</td>
      <td>25.0</td>
      <td>32</td>
      <td>003</td>
      <td>2266715.0</td>
      <td>3.926387</td>
    </tr>
  </tbody>
</table>

Now, let's try mapping the data per 100K and how this affect the way the map looks.


```python
m = folium.Map(location=[40, -96], zoom_start=4)

cp = folium.Choropleth(
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','count_per_100K'],
        key_on = 'feature.properties.FIPS',
        bins = 9,
        fill_color='OrRd',
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings (2015-present) (per 100K population)'
        ).add_to(m)

m
```


    Output hidden; open in https://colab.research.google.com to view.

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-12.png" alt="Visual description of figure image" caption="Figure 12. Caption text to display" %}
![png](Images/Map10.png)

Suddenly, high population counties (like Los Angeles and Cook) don't look so bad. Instead, low population counties with a single shooting are highlighted.

We saw that the distribution of `count` was wildly non-normal. Is the `count_per_100K` any better?


```python
map_df['count_per_100K'].describe()

    count    1521.000000
    mean        5.055039
    std         5.779924
    min         0.147392
    25%         1.938539
    50%         3.459609
    75%         6.044122
    max        71.123755
    Name: count_per_100K, dtype: float64
```



```python
map_df.boxplot(column=['count_per_100K'],vert=False)
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-13.png" alt="Visual description of figure image" caption="Figure 13. Caption text to display" %}
![png](Images/PH_ChrorplethFatalForceDB_123_1.png)



Good gravy! There are a LOT of outliers. Since this is a VERY uneven distribution, let's try using a log scale again.



```python
map_df['MapScale'] = np.log10(map_df['count_per_100K'])
map_df.boxplot(column=['MapScale'],vert=False)
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-14.png" alt="Visual description of figure image" caption="Figure 14. Caption text to display" %}
![png](Images/PH_ChrorplethFatalForceDB_125_1.png)



With *this* distribution, using the log10 scale converts it to a far more normal distribution.

We will recycle the code from above to plot draw this data with a log scale, with the scale converted back to original values.

We showed how to use the Tooltip function to show some data -- but we can use it to display any of the data in the map_df.

Finally, we'll add a title and the mini-map, too.


```python
m = folium.Map(location=[40, -96], zoom_start=4)

titleText = """Number of people killed by police in each county (per 100K population)"""
title_html = '''
             <h4 align="center" style="font-size:16px"><b>{}</b></h4>
             '''.format(titleText)
m.get_root().html.add_child(folium.Element(title_html))

cp = folium.Choropleth(
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','MapScale'],
        key_on = 'feature.properties.FIPS',
        bins = 9,
        fill_color='OrRd',
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings per 100K population (2015-present)'
        ).add_to(m)

map_data_lookup = map_df.set_index('FIPS')

for row in cp.geojson.data['features']:
  try:
      row['properties']['count'] = f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.0f}"
  except KeyError:
      row['properties']['count'] = 'No police killings reported'
  try:
      row['properties']['count_per_100K'] = f"{map_data_lookup.loc[row['properties']['FIPS'],'count_per_100K']:.2f}"
  except KeyError:
      row['properties']['count_per_100K'] = 'No data'
  try:
      row['properties']['population'] = f"{map_data_lookup.loc[row['properties']['FIPS'],'POPESTIMATE2019']:,.0f}"
  except KeyError:
      row['properties']['population'] = 'No data'

folium.GeoJsonTooltip(['NAME','population','count','count_per_100K'],
                      aliases=['county:','population:','count:','per100K:']
                      ).add_to(cp.geojson)

from branca.element import Element
e = Element("""
  var ticks = document.querySelectorAll('div.legend g.tick text')
  for(var i = 0; i < ticks.length; i++) {
    var value = parseFloat(ticks[i].textContent.replace(',', ''))
    var newvalue = Math.pow(10.0, value).toFixed(1).toString()
    ticks[i].textContent = newvalue
  }
""")
colormap = cp.color_scale # this finds the color scale in the cp variable
html = colormap.get_root()
html.script.get_root().render()
html.script.add_child(e)

from folium import plugins
minimap = plugins.MiniMap()
m.add_child(minimap)

m
```


    Output hidden; open in https://colab.research.google.com to view.

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-15.png" alt="Visual description of figure image" caption="Figure 15. Caption text to display" %}
![png](Images/Map11.png)

When we look at the number of police killings per 100K population, the map shifts considerably.

The earlier visualizations seemed to suggest the problem was mainly one of large cities, which have (by far) the largest number of incidents of police killing civilians.

A per-capita visualization suggests that the highest rates are in low population counties. For a county like Sedgwick, CO, NM (population 2,248) one police killing of a civilian means that it has a per100K rate of 44!

Using a log-scale with the per100K data shows that police killing civilians is a nation-wide problem. Visualizing the data in this manner might prompt reflection and questions:
* In a nation awash with guns, is an occasional police killing a civilian inevitable?
* (The Fatal Force database shows that about 80% of the people killed by police are armed with guns, so police have reason to fear people they encounter.)
* Should we be more concered about counties with high rates per 100K population OR those with high counts?

Normalizing the data allows it to be visualized differently and, perhaps, to compliexify how we consider the problem of police killing civilians.
