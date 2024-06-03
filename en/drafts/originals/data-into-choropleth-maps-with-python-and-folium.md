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
[Choropleth Maps](https://en.wikipedia.org/wiki/Choropleth_map) have become very familiar to us. They are commonly used to visualize information such as [Covid-19 infection/death rates](https://www.nytimes.com/interactive/2021/us/covid-cases.html#maps), [education spending per pupil](https://www.reddit.com/r/MapPorn/comments/bc9jwu/us_education_spending_map/), and other similar data.

Visualizing data in this way can reveal patterns that might otherwise be hard to discern; one might be able to understand some of this from tables of figures, but the spacial aspect might be overlooked. Thus, this type of map can be very useful to historians and other scholars.

This lesson will demonstrate how the Folium library can be used to create choropleth maps quickly and easily. However, while a basic map is easy to create, they often require some adjustments to be as informative as possible. The level of complexity will increase as we move through the lesson.

At the end of the lesson you will be able to:
* Load several types of data from web archives
* Know how to associate latitude/longitude points with county names, geography, and FIPS numbers
* Create a basic choropleth map
* Reflect on some issues that map-designers need to consider, especially the problem of dealing with non-normal distributions of data
* Know how to normalize data to plot data *rates* rather than data *values*
* Enhance a Folium map with titles, popup data, and mini-maps.


We will be exploring the *Washington Post*'s [Fatal Force](https://github.com/washingtonpost/data-police-shootings) database, which we've made available for you in this lesson's associated `assets` folder [here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/fatal-police-shootings-data.csv), hosted on _Programming Historian_'s own GitHub repository. Starting in 2015, the *Post* started the database, which seeks to document every time an encounter with a police officer ends in the death of the civilian. This data isn't collected or reported systematically, so the *Post*'s work fills an important lacuna in our understand of how police interact with the people around them.

My comments will reflect the data in the database as of June, 2024. Tragically, I can confidently predict that these numbers will continue to increase. If you work with the data in the `assets` folder, your visualizations should resemble those in this article. If you access the *Post*'s database, the numbers will be different.

### Folium
To create the maps, we will use [Folium](https://python-visualization.github.io/folium/), a Python library that automates creating Leaflet maps.

[Leaflet](https://leafletjs.com/) is a JavaScript library that faciliates the creation of interactive HTML maps. To use Leaflet one needs to know some CSS and JavaScript. For help with this, see the Programming Historian's article ["Web Mapping with Python and Leaflet"](https://programminghistorian.org/en/lessons/mapping-with-python-leaflet).

Folium makes it easy to create a wide variety of maps. For basic maps, the user doesn't need to work with HTML, CSS, or JavaScript: everything can be done within the Python ecosystem. Users can specify a variety of different basemaps (terrain, street maps, different colors) and display data with different markers, such as pins or circles. These can use different colors or sizes based on the data. Folium has a useful [Quickstart](https://python-visualization.github.io/folium/quickstart.html) that serves as an introduction to the library.

In addition to these basic maps, Folium offers advanced functions, such as creating cluster-maps and heat-maps. This lesson will explore how to create choropleth maps with Folium. 

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
This lesson was originally written in Google's [Colab](https://colab.research.google.com/) system. Colab allows users to create [Jupyter notebook](https://realpython.com/jupyter-notebook-introduction/)-like files that combine markdown text and Python cells.

Colab is very useful in the classroom, since it runs entirely on the web. Students can access Colab notebooks with any computer or tablet that runs a modren web-browser. This means that instructors don't need to write different instructions for Macs, PCs, Linux, Chromebooks, etc. The system is fast and powerful: the virtual machines generally have around 12GB RAM and 23GB disk space; designed for machine learning, it also allows users to add a graphics card / hardware accelerator (we won't be using this!). Since computation is done in the cloud, users don't need to have a powerful machine to use the system.

Colab includes a very large collection of Python libraries, as it is intended for data science and machine learning. In our lesson, most of our libraries are all part of the standard Colab system.

#### Not using Colab?

While this lesson was originally written with Colab in mind, the code will run on personal computers, even low-powered chromebooks. But users will need to install any missing libraries, including *Geopandas*, *Pandas*, *Folium*, *Numpy*, *Jenkspy*, or others.

To follow the lesson easily, users will also need to run a Jupyter notebook. Personally, I use Microsoft's [Visual Studio Code](https://code.visualstudio.com/) because it runs on a wide variety of different systems (Windows, Mac, Linux); supports Jupyter notebooks; can be used as an code editor / IDE for a wide variety of languages; integrates well with Github; and also supports text editing, including markdown and markdown previewing. There are other ways to install a Jupyter notebook on your system, such as the [Anaconda](https://www.anaconda.com/) software suite.

### Import Libraries
The first thing we will do is to load the necessary Python libraries and assign their common aliases (`pd` and `gpd`). As we call methods from the libraries, we will use these aliases instead of the full library name.


```python
import pandas as pd
import geopandas as gpd
import folium
```

## Get the Data

### Fatal Force Data
Before importing the data, I read the *Post*'s [documentation](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/fatal-force-database-README.md) about the datafields, so I know there is a `date` field.

Pandas tries to parse data as it imports it. It is pretty good at recognizing *string* (character) data and *numeric* data and imports them as `object` and `int64` or `float64` datatypes. But it struggles with date-time fields. If we include the keyword `parse_dates=` parameter, along with the name of the date column, Pandas will parse the date field and make it a `datetime64` datatype.

This code block imports the data. To follow along with the lesson, use the code as written. If you want to see the most up-to-date version of the data from the *Washington Post*, comment (`#`) out the first two lines and un-comment the lines for the WP's repo. The rest of this lesson uses the data from the *Programming Historian* website; if you use the data from the *Post*, the numbers will be different.

```python
 ff_df = pd.read_csv('https://raw.githubusercontent.com/programminghistorian/ph-submissions/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/fatal-police-shootings-data.csv',
                    parse_dates = ['date'])
# ff_df = pd.read_csv('https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv',
#                    parse_dates = ['date'])

```
**WILL THIS BE THE URL WHEN PUBLISHED? IF NOT, THIS WILL NEED TO BE EDITED LATER**

We will look at the fatal force dataframe (ff_df) to see what sort of data it has, to check the data types, and take a look at the sample data.


```python
ff_df.info()

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 9628 entries, 0 to 9628
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

<div class="table-wrapper" markdown="block">
    
| |id|date|threat_type|flee_status|armed_with|city|county|state|latitude|longitude|location_precision|name|age|gender|race|race_source|was_mental_illness_related|body_camera|agency_ids|
|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|
|4219|4641|2019-04-16|attack|car|vehicle|Fountain Inn|NaN|SC|34.689009|-82.195668|not_available|Chadwick Dale Martin Jr.|24.0|male|W|not_available|False|False|2463|
|6392|7610|2021-06-04|shoot|foot|gun|Braintree|NaN|MA|NaN|NaN|NaN|Andrew Homen|34.0|male|W|photo|False|False|1186|
|7711|8368|2022-08-30|threat|not|gun|Cedar Rapids|NaN|IA|41.924058|-91.677853|not_available|William Isaac Rich|22.0|male|NaN|NaN|False|True|872|
|4954|5571|2020-01-09|shoot|not|gun|Philadelphia|NaN|PA|40.013024|-75.082175|not_available|Claude Fain|47.0|male|B|not_available|True|False|671|
|947|1088|2015-12-14|threat|not|knife|Middle River|Baltimore|MD|39.304449|-76.371538|not_available|Jeffrey Gene Evans|52.0|male|W|not_available|True|False|128|

</div>

As of May, 2024 there were about 9,600 records in the database.

Most of our fields are `object` (which is what Pandas calls `string` or text) data. `date` is a `datetime` object. And there are numbers for the `latitude`,`longitude` and `age` fields.

If the lat/lon fields were not numbers, we would need to do some data cleaning to get them convered to `float`-type numbers. In Python a `float` is a number with decimal values; an `integer` is a whole number.

> This is an example of where the Pandas' parser isn't perfect: lat/lon should be `float`s but `age` should be an `int` since the `age` values are all whole numbers.

How many records lack latitude/longitude (lat/lon) data? What percent of the database is missing this information?

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

<div class="table-wrapper" markdown="block">

||id|date|threat_type|flee_status|armed_with|city|county|state|latitude|longitude|location_precision|name|age|gender|race|race_source|was_mental_illness_related|body_camera|agency_ids|
|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|
|0|3|2015-01-02|point|not|gun|Shelton|Mason|WA|47.246826|-123.121592|not_available|Tim Elliot|53.0|male|A|not_available|True|False|73|
|1|4|2015-01-02|point|not|gun|Aloha|Washington|OR|45.487421|-122.891696|not_available|Lewis Lee Lembke|47.0|male|W|not_available|False|False|70|
|2|5|2015-01-03|move|not|unarmed|Wichita|Sedgwick|KS|37.694766|-97.280554|not_available|John Paul Quintero|23.0|male|H|not_available|False|False|238|
|3|8|2015-01-04|point|not|replica|San Francisco|San Francisco|CA|37.762910|-122.422001|not_available|Matthew Hoffman|32.0|male|W|not_available|True|False|196|
|4|9|2015-01-04|point|not|other|Evans|Weld|CO|40.383937|-104.692261|not_available|Michael Rodriguez|39.0|male|H|not_available|False|False|473|
|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|
|8403|9145|2023-04-22|threat|NaN|gun|Bixby|Tulsa|OK|35.973205|-95.886596|address|NaN|48.0|male|NaN|NaN|False|False|2246|
|8404|9146|2023-04-22|threat|NaN|gun|Metairie|Jefferson|LA|29.990365|-90.188907|block|NaN|NaN|male|NaN|NaN|False|False|88|
|8406|9149|2023-04-22|shoot|NaN|gun|West Jordan|Salt Lake|UT|40.593788|-111.969553|address|NaN|NaN|male|NaN|NaN|False|False|751|
|8407|9144|2023-04-23|NaN|NaN|undetermined|Pineville|Rapides|LA|31.207175|-92.149489|block|NaN|NaN|NaN|NaN|NaN|False|False|21677|
|8408|9153|2023-04-23|attack|not|unknown|Shreveport|Caddo|LA|32.435405|-93.783105|intersection|Joseph Dewayne Taylor|33.0|male|B|public_record|False|False|772|

</div>

This shows that there are 7,496 rows that have latitude values. What percent of the whole DF is this?

We can find this by using the `len()` method. Python uses this to find the length of lists, dictionaries, and other collections of data. Pandas supports a version of this command, too.


```python
len(ff_df[ff_df['latitude'].notna()]) / len(ff_df)

    0.8900340100999691
```


About 89% of the records include lat/lon data. What do we do about the missing data?

With some work, we could add estimated locations. For example, many of the rows include either city or county information. We could find the center of these areas and add that lat/lon data to the DF. If we wanted to map exactly where a fatality ocurred, this wouldn't be useful, but for maps visualizing county-level data, this might suffice.

This work would be necessary if we wanted to use this data for a study or in a report. In our case, since we're just demonstrating how to use Folium, we won't dwell on the various methods one might use to add in the missing data. Instead, we will just create a smaller version of the DF that only includes rows with lat/lon data. We will use the same boolean mask to create our smaller DF.


```python
ff_df = ff_df[ff_df['latitude'].notna()]
```

### County Geometry Data
To create the choropleth map, we also need a file that provides the geographic boundaries for the regions we wish to map. In this case, since we are interested in county-level data, we need to get a data file that defines the county shapes. The [US Census](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html) has a number of different "cartographic boundary files". These include shape files for counties (at various resolutions), congressional districts, and others.

While these files are in the ZIP format, Geopandas knows how to read them and extract the information it needs. We can load these files directly from the Census' website, but we've also made `cb_2021_us_county_5m.zip` [available to download](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/cb_2021_us_county_5m.zip) from our repository.

```python
counties = gpd.read_file('https://raw.githubusercontent.com/programminghistorian/ph-submissions/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/cb_2021_us_county_5m.zip')

# counties = gpd.read_file("https://www2.census.gov/geo/tiger/GENZ2021/shp/cb_2021_us_county_5m.zip")
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

<div class="table-wrapper" markdown="block">

| |STATEFP|COUNTYFP|COUNTYNS|AFFGEOID|GEOID|NAME|NAMELSAD|STUSPS|STATE_NAME|LSAD|ALAND|AWATER|geometry|
|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|
|825|26|129|01623007|0500000US26129|26129|Ogemaw|Ogemaw County|MI|Michigan|06|1459466627|29641292|POLYGON ((-84.37064 44.50722, -83.88663 44.508...|
|245|17|017|00424210|0500000US17017|17017|Cass|Cass County|IL|Illinois|06|973198204|20569928|POLYGON ((-90.57179 39.89427, -90.55428 39.901...|
|2947|22|115|00559548|0500000US22115|22115|Vernon|Vernon Parish|LA|Louisiana|15|3436185697|35140841|POLYGON ((-93.56976 30.99671, -93.56798 31.001...|

</div>

Again, the different fields are already in the correct format: all are objects (which is what Pandas calls string/character data), except for `ALAND` and `AWATER` (which record the area of the county that is land and water in square meters), and `geometry` which is a special Geopandas datatype: *geometry*.

Because we are interested in visualizing the data by county, we need a unique identifier for each county. The US Census bureau has [assigned numbers](https://www.census.gov/library/reference/code-lists/ansi.html) to each state (`STATEFP`) and county (`COUNTYFP`); these are combined into a five digit *Federal Information Processing Series* (**FIPS**) code. In the above table, the FIPS column is called `GEOID`. We will rename this column below; while not required, I find it easier to use the came column names in different tables if they contain the same data. 

The other column that we need is the `geometry` column. As can be seen in the `.sample()` output, each row of this column has a bunch of points (latitude and longitude points) defining a polygon that corresponds to the shape of a county.

Just for fun, pick a county you're familiar with and see what it looks like:


```python
counties[(counties['NAME']=='Suffolk') & (counties['STUSPS']=='MA')].plot()
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-01.png" alt="Visual description of figure image" caption="Figure 1. Caption text to display" %}


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
    Int64Index: 8636 entries, 0 to 9629
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
Now that we have a DF with data (`ff_df`) and a DF with county geometries (`counties`) that share a common field (`FIPS`) we are ready to draw a map.

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


This shows that around 50% of counties in the USA have had at least one instance of a police officer killing someone.

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

| |FIPS|0|
|:----|:----|:----|
|0|06037|302|
|1|04013|200|
|2|48201|114|
|3|06071|95|
|4|32003|89|
|...|...|...|
|1517|29055|1|
|1518|29063|1|
|1519|29071|1|
|1520|29083|1|
|1521|56029|1|



## Draw the Map
To draw a map, we need to initalize a folium.Map object. Since we're going to be doing this multiple times in this notebook, I've created a little function that will initialize the map for us.

Folium requires attribution for map tiles (the underlying visual representation of the map). It supports a wide array of tiles; see the [Leaflet gallery](https://leaflet-extras.github.io/leaflet-providers/preview/) for examples, along with values for `tiles=` and `attr=`.

Folium has [default values](https://python-visualization.github.io/folium/modules.html) for many of its parameters, but we need to passs a value for the center of the map. I find the default zoom level (`zoom_start = 10`) is too large to show the continental USA well, so we will specify a different value.

The following code block initializes a map object, with the required attribution information, the center of the map, and a zoom level of 5. It returns a map object.


```python
def initMap():
    tiles = 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}'
    attr = 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ, TomTom, Intermap, iPC, USGS, FAO, NPS, NRCAN, GeoBase, Kadaster NL, Ordnance Survey, Esri Japan, METI, Esri China (Hong Kong), and the GIS User Community'

    center = [40,-96]

    map = folium.Map(location=center,
                zoom_start = 5,
                tiles = tiles,
                attr = attr)
    return map
```
To initialize the map, we call the function and assign the data to the `baseMap` variable.

```python
baseMap = initMap()
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
        ).add_to(baseMap)

baseMap # this displays the map
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-02.png" alt="Visual description of figure image" caption="Figure 2. Caption text to display" %}

**REPLACE THIS FIGURE 2 with New "00_InitialMap.gif"**


Folium creates interactive maps. Users can zoom in and out; using their mouse, they can move the map around to examine the area(s) in which they are most intersted. The image above 


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
12       ).add_to(baseMap)
```

* Line 1 calls the `folium.Choropleth()` method and line 12 adds it to the map that we initalized earlier. The method plots a GeoJSON overlay on the basemap.
* Line 2 (`geo_data=`) identifies the GeoJSON source of the geographic geometries to be plotted. This is the `counties` dataframe we downloaded from the US Census bureau.
* Line 3 (`key_on=`) identifies the field in the GeoJSON data that will be bound (or linked) to the data from the `map_df`: we need to have one column in common between our dataframes. In this case, it will be the `FIPS` column.
* Line 4 (`data=`) identifies the source of the data to be analyzed and plotted. This is the `map_df` dataframe that we created from the fatal force dataframe (`ff_df`).
* Line 5 is required because we're using a Pandas DF as the data source. This parameter tells Folium which columns in the DF specified by the `data=` parameter to use.
  * The first value is the column name that will be matched with the `key_on=` value.
  * The second field has the values to be used to draw the choropleth map's colors.
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

The clue is to look at the scale: it goes from zero to 342.

Let's look at our data a bit more. Pandas' [`.describe()`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.describe.html) method provides a useful summary of the data, including the mean, standard deviation, median, and quartile information.


```python
map_df.describe()
```

| |count|
|:----|:----|
|count|1596.000000|
|mean|5.406642|
|std|14.2966701|
|min|1.000000|
|25%|1.000000|
|50%|2.000000|
|75%|5.000000|
|max|342.000000|


This shows:
1. 1,596 counties (out of the 3,142 in the USA) have reported at least one police killing.
1. At least 75% of these counties have had 5 or fewer killings.
Thus, there must be a few counties in the top quartile that have had many more killings.

I find the easiest way to figure out what's going on with the data is to visualize it with a [boxplot](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.boxplot.html).
> Pandas could also display this as a histogram `(map_df.hist(bins=20))` but if the Y-scale is large (as it will be on this distribution of data), it can be very hard to see the outlying points on the right-side of the distribution. A `boxplot` shows these values better.

> The default boxplot is vertical, but since most monitors are landscape-orientation, when I'm displaying the data on my monitor, I prefer to make the boxplot horizontal. To display the boxplot vertically, omit the `vert=False` keyword.


```python
map_df.boxplot(vert=False)
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-03.png" alt="Visual description of figure image" caption="Figure 3. Caption text to display" %}


This allows us to see that there are fewer than ten counties where police have killed more than 75 civilians.

I frequently encounter this sort of challenge with the data when I want to draw a choropleth map. The problem is that Folium's algorithm divides the data range into an even number of 'bins' (specified in line 6 above).

In this case, I specified 9 bins, so each bin will be about 38 units wide ($342 / 9 = 38$).

* Bin 1 (0 - 38) will have almost all our data (since 75% of all all values are 5 or less).
* Bin 2 (38-76) will have almost all the rest of the data, judging by the boxplot
* Bin 3 (76-114) will have a handful of cases
* Bin 4 (114-152) will have 2 case
* Bin 5 (152-190) will have 0 cases
* Bin 6 (190-228) will have 1 case
* Bins 7 and 8 (228-304) will have 0 cases
* Bin 9 (304-342) will have one case

Because the scale needs to cover ALL cases, when the vast majority of cases are in one or two bins, the map is not terribly informative.

There are solutions to this problem, but none are ideal; some work better with some distributions of data than others and mapmakers may need to experiment to see what map works best for a given set of data.


### Solution #1: Fisher-Jenks algorithm
Folium allows users to pass a parameter to the choropleth algorithm that will automatically calculate "natural breaks" in the data; Folium's [documentation says](https://python-visualization.github.io/folium/modules.html?highlight=choro#folium.features.Choropleth) "this is useful when your data is uneavenly distributed."

Because the [jenkspy](https://pypi.org/project/jenkspy/) library is not part of Colab's standard collection of libraries, we will need to install it. Colab allows us to do this by running a `bash` command.

> The Unix/Linux terminal shell (or command line) is called [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)). iOS and Windows have similar terminal shell programs. Jupyter notebooks allow users to issue terminal commands by prefixing the command with an exclaimation point; Colab follows this convention.

The next code block shows how to install the jenksby library in Colab using the `pip` command.

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
baseMap = initMap()
 # we need to initialize the map again.
 # if we don't, it will add the new choropleth data on top of the old data
 # alternately, we could create a new map (baseMap_2 = ...)

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
        ).add_to(baseMap)

baseMap

```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-04.png" alt="Visual description of figure image" caption="Figure 4. Caption text to display" %}


This is an improvement: the map shows a better range of contrasts. We can see that there are a fair number of counties outside the Southwest where police have killed several people (Florida, the Northwest, etc.)

But the scale is almost impossible to read! The algorithm correctly found natural breaks -- most of the values are less than 76, but at the lower end of the scale the numbers are illigible.

### Solution #2: Create a scale-value variable
Rather than plotting the raw data, we could create a new variable to use for the color scale. Here's how to do this.

#### How to add a scale-value column
Our goal is to add a column to the `map_df` dataframe that will convert the values in the `PctTotPop` column to a new set of values to be used with the coloring/scale. We will call this new column `MapScale`.

For this example, I will assume we will cap the scale at 50. For each row in the dataframe, we will look at the county's value and leave it alone if it is less than 50; if it is over 50, we will set it to 50.

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
Now that we know how to add a new column of values for our scale, let's look at one example of how to implement this.

#### Create a Logarithm Scale-Value
Logarithm scales are very useful when the data has a wide distribution.

 The [definition of a logarithm](http://www.mclph.umn.edu/mathrefresh/logs3.html) is
$b^r = a$ or $log$<sub>b</sub>$a=r$.

That is, the log value is the **exponent** ($r$) that the base number ($b$) would be raised to equal the original value ($a$).

For base 10, this is easy to calculate:
>$10 = 10^1$ so $log$<sub>10</sub>$(10) =1$

>$100 = 10^2$ so $log$<sub>10</sub>$(100) =2$

Thus, using a base 10 logarithm, each time a log value increase by 1, the original value would increase 10 times. The most familiar example of a log scale is probably the [Richter scale](https://en.wikipedia.org/wiki/Richter_magnitude_scale), used to measure earthquakes.


For our current data, since most counties have fewer than 5 police killings, most counties will have a log value between $0$ and $1$. The biggest value (302) have a log value of between 2 and 3 (that is, between $10^2$ and $10^3$).

To add a scale variable with a log10.
1. We will need to import [numpy](https://numpy.org/), the standard library for scientific computing in Python. (Since numpy is included in Colab's collection of libraries, we do not need to install it with `pip`.)
2. We will then use numpy's `.log10()` method to create our new scale column. Because $log10(0)$ is undefined, when the `count` is zero, we need to manually set the `MapScale` value to zero. We will do this with `.apply()` and a lambda function.


```python
import numpy as np
map_df['MapScale'] = map_df['count'].apply(lambda x: np.log10(x) if x>0 else 0)

```

As we map the data again, we will remove the `use_jenks` parameter and change the column of data we want to use for the scale.


```python
baseMap = initMap()

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
        ).add_to(baseMap)

baseMap
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-05.png" alt="Visual description of figure image" caption="Figure 5. Caption text to display" %}


This is better than the earlier two: we can see more distinctions between the values on our map.

Unfortunately, the problem with a log scale is that **most people won't know know to interpret it** -- what is the non-log (original) value of 1.5 or 1.8 on a log scale?

Even if folks remember the definition of logrithm (that is, that the when the scale says 1.5, the original value is 10<sup>1.5</sup>), if they don't have a calculator, they won't be able to convert the log values to the original number!

Unfortunately, Folium doesn't have a built-in way to address this problem. Instead, we need to import a method from the `branca` library and use some JavaScript to create a new scale.

For the purposes of this tutorial and its learning goals, you do not ned to know the specifics of the following code. It simply replaces log values with non-log values. (I did not write it; rather, [Kota7](https://github.com/kota7) provided this solution in the [Folium Github issues discussion board](https://github.com/python-visualization/folium/issues/1374).)

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
To use this, we need to create a new variable (in the following example, it is **cp** (for **c**horo**p**leth), which the code above will access and modify.

Here's what the code looks like with this fragment included and the map that produced when it is run.

```python
baseMap = initMap()

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
        ).add_to(baseMap)

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

baseMap

```


{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-06.png" alt="Visual description of figure image" caption="Figure 6. Caption text to display" %}


Note that the log values on the scale have been converted to the original (non-log) values.  Note, too, that the bins equal size, but their values increase exponentially, in line with their log10 values.


#### Other Options
If these two options don't work, the map-maker may need to explore capping the values. Using the same `lambda` function as above, establish a maximum (cap) value for the color scale values. There are a variety of possible caps:
1. Look at the data and pick a value that seems to make sense, such as the 90% quintile.
1. Cap the value using the definition used by the [box plot algorithm](https://discovery.cs.illinois.edu/learn/Exploratory-Data-Analysis/Quartiles-and-Box-Plots/) to determine the length of the "whisker" (75% quartile +  $1.5 * IRQ$); values beyond the "whisker" are considered outliers.
1. Cap the value at the `mean + 3 * standard deviations`. In a normal distribution, this would typically cover [99.7%](https://en.wikipedia.org/wiki/68%E2%80%9395%E2%80%9399.7_rule) of all data values. Unfortunately, this data in not [normally distributed](https://en.wikipedia.org/wiki/Normal_distribution).

In short, if the data has a few extreme outliers that would otherwise compress the color scheme so much that it's not usefully intelligible, we may need to explore capping the data scale.

There may be instances where the problem is outliers on the left-side of the distribution; the same process would be followed, but in this case, we would be establishing a floor for the data. But we would follow the same process.

**Problem with Capping the Data**

There is one **HUGE** problem with capping the data: *it no longer actually reflects the data accurately*.

Even if only 5% of data is lumped together at the top of the scale, it may have a dramatic affect on the map's appearance. Map makers will need to think carefully about how to deal with the problem of unevenly distribute data and the best way to deal with it.

If we *must* cap the data, the mapmaker can help explain the data by adding a box that will show the actual values when the user puts their cursor over the county. I will explain how to do this below.

## The Cause of Uneven Distribution of Data and **Normalizing** Data

This map demonstrates a common characteristic of choropleth maps: the data tends to correlate closely with population centers. The counties with the largest number of police killings of civilians are those with large populations (Los Angeles, CA; Cook, IL; Dade, FL; etc.)

The same issue would be arise if we were mapping ocurrences of swine flu (correlated with hog farms), corn leaf blight (correlated with regions that grow corn), etc.

This is why choropleth maps often do not visualize *values* (that is, raw numbers). Instead, they visual *ratios* (the number of cases per 100,000 population). Converting the data from values to ratios is called **normalizing** data. 

To do this, we need to get a dataset that includes county-by-county population statistics that, ideally, include a FIPS code.

I found this data at the [US Census Bureau](https://www.census.gov/), which has a huge number of [datasets](https://www.census.gov/data/datasets.html) that it provides the public.

The full dataset is huge, but when I read the [documentation](https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.pdf), I realized I only needed three columns: `STATE`,`COUNTY`, and `POPESTIMATE2019`. (I selected 2019 because the *Post*'s data extends from 2015 to present; 2019 is roughly in the middle of that time frame).

Rather than loading the full database, Pandas allows us to specify specific columns to include with the `usecols` parameter. (Note that this file does not use the very common `utf-8` encoding scheme; I needed to specify the `"ISO-8859-1"` to avoid an `UnicodeDecodeError`.)

```python
pop_df = pd.read_csv('https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.csv',
                         usecols = ['STATE','COUNTY','POPESTIMATE2019'],
                         encoding = "ISO-8859-1")
pop_df.head()
```
| |STATE|COUNTY|POPESTIMATE2019|
|:----|:----|:----|:----|
|0|1|0|4903185|
|1|1|1|55869|
|2|1|3|223234|
|3|1|5|24686|
|4|1|7|22394|


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

The next code block does these three steps.

```python
pop_df['STATE'] = pop_df['STATE'].astype(str).str.zfill(2) # convert to string, and add leading zeros
pop_df['COUNTY'] = pop_df['COUNTY'].astype(str).str.zfill(3)
pop_df['FIPS'] = pop_df['STATE'] + pop_df['COUNTY'] # combine the state and county fields to create a FIPS
pop_df.head()

```

| |STATE|COUNTY|POPESTIMATE2019|FIPS|
|:----|:----|:----|:----|:----|
|0|01|000|4903185|01000|
|1|01|001|55869|01001|
|2|01|003|223234|01003|
|3|01|005|24686|01005|
|4|01|007|22394|01007|


This table includes population statistics for both entire states and individual counties.

State values can be identified because their county code (the last three digits) are $000$ but the county numbers start at $001$ and continue to cover all the counties in the state.

So the first row reports the total population for state $01$ (Alabama), while the second row reports the population for county $001$ in Alabama.

Since our earlier DFs don't include rows with a FIPS number of $XX000$ when we do a join/merge, the state figures will be ignored.

Let's do the [merge](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.merge.html), then we can calculate a _per capita_ number for police shootings.


```python
map_df = map_df.merge(pop_df, on = 'FIPS', how = 'left')
map_df.head()
```

| |FIPS|count|ScaleTotPop|MapScale|STATE|COUNTY|POPESTIMATE2019|
|:----|:----|:----|:----|:----|:----|:----|:----|
|0|06037|302|2.480007|25.0|06|037|10039107.0|
|1|04013|200|2.301030|25.0|04|013|4485414.0|
|2|48201|114|2.056905|25.0|48|201|4713325.0|
|3|06071|95|1.977724|25.0|06|071|2180085.0|
|4|32003|89|1.949390|25.0|32|003|2266715.0|


The map_df has all the columns we've added as we've worked through this notebook. We could tidy it up by deleting them, but there isn't a pressing reason to do so -- it's a relatively small DF (with around 3,100 rows).

For now, let's just add new column that calculates the number of police killings per 100K population.


```python
map_df['count_per_100K'] = map_df['count'] / (map_df['POPESTIMATE2019']/100000)
map_df.head()
```

<div class="table-wrapper" markdown="block">

| |FIPS|count|ScaleTotPop|MapScale|STATE|COUNTY|POPESTIMATE2019|count_per_100K|
|:----|:----|:----|:----|:----|:----|:----|:----|:----|
|0|06037|302|2.480007|25.0|06|037|10039107.0|3.008236|
|1|04013|200|2.301030|25.0|04|013|4485414.0|4.458897|
|2|48201|114|2.056905|25.0|48|201|4713325.0|2.418675|
|3|06071|95|1.977724|25.0|06|071|2180085.0|4.357628|
|4|32003|89|1.949390|25.0|32|003|2266715.0|3.926387|

</div>

Now, let's try mapping the data per 100K and how this affect the way the map looks.


```python
baseMap = initMap()

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
        ).add_to(baseMap)

baseMap
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-12.png" alt="Visual description of figure image" caption="Figure 12. Caption text to display" %}

**REPLACE THIS FIG12 with NEW "01_NormalizeMap.png"**

Suddenly, high population counties (like Los Angeles and Cook) don't look so bad. Instead, low population counties with a single shooting are highlighted.

We saw that the distribution of `count` was wildly non-normal. Is the `count_per_100K` any better?


```python
map_df['count_per_100K'].describe()

    count    1521.000000
    mean        5.496997
    std         6.162703
    min         0.179746
    25%         2.164490
    50%         3.813155
    75%         6.634455
    max        71.123755
    Name: count_per_100K, dtype: float64
```



```python
map_df.boxplot(column=['count_per_100K'],vert=False)
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-13.png" alt="Visual description of figure image" caption="Figure 13. Caption text to display" %}


Good gravy! There are a LOT of outliers. Since this is a VERY uneven distribution, let's try using a log scale again.



```python
map_df['MapScale'] = np.log10(map_df['count_per_100K'])
map_df.boxplot(column=['MapScale'],vert=False)
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-14.png" alt="Visual description of figure image" caption="Figure 14. Caption text to display" %}

With *this* distribution, using the log10 scale converts it to a far more normal distribution.

We will recycle the code from above to plot draw this data with a log scale, with the scale converted back to original values.


```python
baseMap = initMap()

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
        legend_name='Number of Fatal Police Shootings per 100K population (2015-present)'
        ).add_to(baseMap)

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

baseMap
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-15.png" alt="Visual description of figure image" caption="Figure 15. Caption text to display" %}

**REPLACE THIS FIG 15 with NEW "02_NormalizedLogMap.png"**

**Normalizing** the data dramatically changes the appearance of the map. Our initial visualization suggested that the problem of police killing civilians was limited to a few counties, generally those with large populations. But when the data is normalized, it appears police killings of civilians is far more widespread. The counties with the highest **rates** of killings are those with low populations, even if they have relatively few killings. Trying to illustrate this issue with charts or tables would not show the issue nearly so well.

## Improving Folium Maps

We know how to make a basic choropleth map with Folium. I will now show a few more advanced techniques that can enhance these data visualizations.

### Add a Floating Information Box
Folium allows map maker to add a box that displays information about the area below the cursor. This might be a county name, its population, or the number of people police offers killed.

To add the floating information box, we will use a Folium method called `folium.GeoJsonTooltip()`.

To use this method, we need look "under-the-hood" of Folium. When Folium creates a choropleth map, it generates data about each geographic region. To access it, we need to save the choropleth data to a variable. 

```python
baseMap = initMap()

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
        ).add_to(baseMap)

```

The new `cp` (**c**horo**p**leth) variable allows us to look at the underlying GeoJSON data. GeoJSON data looks like other JSON files: akin to a list of nested Python [dictionary](https://www.geeksforgeeks.org/python-dictionary/) entries.

Counties have  `properties` associated with them, stored in a dictonary. In the following example, you can see that the county `properties` are `key`:`value` pairs. For the first county, the **FIPS** key has a value of **'01059'**; the **NAME** key has a value of **'Franklin'**.
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

The `GeoJsonTooltip()` method allows us to extract and display data in the `properties` dictionary in the floating information box.

Unfortunately, as you can see from the above example, the GeoJSON data doesn't currently have the data we want to display. But we can add it by iterating over the GeoJSON data, finding the information in our `map_df` dataframe, and adding it to the GeoJSON properties dictionary. Here's how we can do this:
1. Create a `map_data_lookup` dataframe that uses FIPS as its index. This prepares things to allow us to search for each county's FIPS number and extract data from the `map_df` (count of deaths, population, etc.) to be added to the GeoJSON data.
1. Iterate over the GeoJSON data and add new property variables with data from the `map_df` dataframe.

Here's what the code looks like. I've added line numbers to faciliate my explanation of what is going on. (It's more complex than it looks!)

```python
1. map_data_lookup = map_df.set_index('FIPS')

2. for row in cp.geojson.data['features']:
3.   try:
4.       row['properties']['count'] = f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.0f}"
5.   except KeyError:
6.      row['properties']['count'] = 'No police killings reported'
```

Line 1 creates a dataframe from the `map_df` dataframe and sets its index to the `FIPS` code. This is important becuse -- as noted above -- the GeoJSON data for counties includes `FIPS` information. We will use the `FIPS` from the county data to find data from the `map_df` dataframe.

Line 2 iterates over GeoJSON data, looking at each `feature` (that is, each county).

Line 4 is where all the work happens, so let's look at it closely. 

`row['properties']['count']` adds a new **key** in `properties` dictionary called `count`.

The **value** that gets assigned to the key is the code to the right of the equals sign: `f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.0f}"`. 

To understand it, read it from the inside out:
* The [`.loc`](https://www.geeksforgeeks.org/python-pandas-dataframe-loc/) method returns a value from a dataframe when we specify the `index value` and `column name`. 
  * In its simplist form, it looks like this `value = df.loc[index,col]`
* Because the index of the `map_data_lookup` dataframe is the `FIPS` number, if we supply a `FIPS` and a column name (`'count'`), Pandas will search the table for the corresponding FIPS number and return the number in the `count` column.
* As we iterate over the rows in the GeoJSON data, the `row['properties']['FIPS']` will supply the `FIPS` value for which to search.

At this point, `map_data_lookup.loc[row['properties']['FIPS'],'count']` has tried to find the `count` value for the given `FIPS`. If found, it is returned as an integer. But we need it to be a string value, so it can be displayed properly. To convert it to a string, we wrap the value in an f-string and specify that it should not include decimals: (`f"{integer_value:.0f}"`)

Lines 3 and 5 prevent the program terminating when encounting a `KeyError` with `try:` and `except:` statements. What would cause a `KeyError`? If we use the `.loc[]` method and no data is found, Python will generate a `KeyError`. Since the GeoJSON data includes values for all the counties in the US, but the `map_data_lookup` dataframe will have values for only those counties in which a police officer has killed someone, we know that, for about 50% of the counties, there will be no data -- causing `KeyError`s. 

Line 6 provides a default value when an error is encountered: when no value is found in the `count` columns for a county, the value for that county is "No police killings reported"

<hr>

Once our GeoJSON data has been updated, we call the `folium.GeoJsonTooltip()` method. It takes a list of keys from the GeoJSON data's property dictionary: the values associated with these keys will be displayed. It also allows us to provide aliases, which is the text to be displayed in the tool tip box.

Finally, we tell Folium to save this information to `cp.geojson`, which it will interpret to create the map.

```python
folium.GeoJsonTooltip(['NAME','count'],
                      aliases=['County:','Num of Police Killings:']).add_to(cp.geojson)
```

Here's a code sample that includes the above matieral. We will take our prior map -- with normalized data and using a log scale -- and add the code to create the popup box. (Note that I have simplified the code below by removing the code to convert the numbers on the scale from log to non-log values.)


```python
baseMap = initMap()

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
        legend_name='Number of Fatal Police Shootings (2015-present) (log-scale)'
        ).add_to(baseMap)

map_data_lookup = map_df.set_index('FIPS')

for row in cp.geojson.data['features']:
  try:
      row['properties']['count'] = f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.0f}"
  except KeyError:
      row['properties']['count'] = 'No police killings reported'

folium.GeoJsonTooltip(['NAME','count'],aliases=['County:','N killed by Police:']).add_to(cp.geojson)

baseMap
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-09.png" alt="Visual description of figure image" caption="Figure 9. Caption text to display" %}

**Replace this Fig 09 with NEW "03_Infoboxa.gif"**

This above example just reports the number of police killings reported. But this technique can be used to show multiple variables. The next example creates an information box that displays 
* the name of the county (since this is already in the cp.GeoJson properties dictionary, it doesn't need to be added)
* the county's population (this variable, and the next two, are in the `map_data_lookup` dataframe; they need to be added to the cp.GeoJson properties dictionary)
* the number of people killed by police
* the number per 100K population

```python
baseMap = initMap()

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
        ).add_to(baseMap)

map_data_lookup = map_df.set_index('FIPS')

for row in cp.geojson.data['features']:
  try:
      row['properties']['count'] = f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.0f}"
  except KeyError:
      row['properties']['count'] = 'No police killings reported'
  try:
      row['properties']['count_per_100K'] = f"{map_data_lookup.loc[row['properties']['FIPS'],'count_per_100K']:.2f}" # present the data with 2 decimal places
  except KeyError:
      row['properties']['count_per_100K'] = 'No data'
  try:
      row['properties']['population'] = f"{map_data_lookup.loc[row['properties']['FIPS'],'POPESTIMATE2019']:,.0f}"
  except KeyError:
      row['properties']['population'] = 'No data'

folium.GeoJsonTooltip(['NAME','population','count','count_per_100K'],
                      aliases=['county:','population:','count:','per100K:']
                      ).add_to(cp.geojson)

baseMap
```

**ADD NEW IMAGE "04_InfoboxB.gif"**

Adding an information box is complex but it can help users enormously.

### Add a Mini Map
Since Folium allows users to zoom in and out and to move the map around, sometimes they might be unsure where they are. Folium helps with this by allowing a Minimap to be added to the corner of the main map.

We need to import Folium's `plugins` library and after that, adding the map is very easy.

I will demonstrate this in the next cell, just adding the Minimap to the previous map.



```python
from folium import plugins
minimap = plugins.MiniMap()
baseMap.add_child(minimap)

baseMap
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-10.png" alt="Visual description of figure image" caption="Figure 10. Caption text to display" %}

**REPLACE this image iwth NEW: "05_MinimapBox.png"**

### Add a Title
Adding a title to the Folium map is a little tricky. Let's look at how the code works before using it for our map.
1. Define the text to use as the title
1. Format the text with to be centered, bold, and 16 pixels tall in a line of HTML code.
1. Add the HTML code to the map.




```python
titleText = """Number of people killed by police in each county"""
title_html = '''
             <h4 align="center" style="font-size:16px"><b>{}</b></h4>
             '''.format(titleText)
baseMap.get_root().html.add_child(folium.Element(title_html))
```

Here's how this would look in the code


```python
baseMap = initMap()

titleText = """Number of people killed by police in each county"""
title_html = '''
             <h4 align="center" style="font-size:16px"><b>{}</b></h4>
             '''.format(titleText)
baseMap.get_root().html.add_child(folium.Element(title_html))

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
        ).add_to(baseMap)

baseMap
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-11.png" alt="Visual description of figure image" caption="Figure 11. Caption text to display" %}

**REPLACE this image iwth NEW: "06Title.png"**

Where you insert the code for the title will determine where it appears relative to the map.
* Placed before the `folium.Choropleth()` call, it will appear above the map.
* Placed afterwards, it will appear below the map.

### Saving Maps
Maps are saved as HTML files. They can be shared with other people, who can open them in a browser will have the ability to zoom, pan, and examine individual county statistics with by putting their cursor over different counties.

Folium allows us to save maps easily with the `.save()` method.


```python
baseMap.save('PoliceKillingsOfCivilians.html')
```

Note that this saves the file to the Colab virtual drive. Remember: **Everything on the virtual drive will disappear** when the Colab session is closed.

You can see the files you have saved to the virtual drive by clicking on the file folder in the left margin of the browser window. To save the file to your local drive, hover your cursor over the file and select "Download." This will download the file to your local hard-drive's default download folder.

Because Folium saves the maps as HTML documents, they can be added to websites or shared with other people, who can open them with a web-brower.


## Conclusion
Choropleth maps are an excellent tool for discovering patterns in data that might be otherwise hard to discern.

They have myrid uses: I've used them to examine how the Payroll Protection Act funds were allocated to religious groups by Congressional dictrict and by county. I discovered that the regions that benefited disproportinately were often those represented by politicians who typically decry "government handouts." Lower income counties also benefitted far more than higher income counties.

I've also used Folium to examine where bicycle accidents are reported in Chicago, mapping locations (what streets / intersections are most dangerous) and creating choropleth maps of the number of accidents in different city council wards and police precincts.

In short, Folium is an incredibly useful tool for mapping and visualizing data.


