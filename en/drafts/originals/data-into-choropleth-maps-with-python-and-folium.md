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
difficulty: intermediate
activity: TBC
topics: TBC
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
mathjax: true
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

[Choropleth Maps](https://en.wikipedia.org/wiki/Choropleth_map) have become very familiar to us. They are commonly used to visualize information such as [Covid-19 infection/death rates](https://www.nytimes.com/interactive/2021/us/covid-cases.html#maps), [education spending per pupil](https://www.reddit.com/r/MapPorn/comments/bc9jwu/us_education_spending_map/), and other similar data.

Visualizing data in this way reveals patterns that might otherwise be hard to discern. Tables of numbers are generally hard to read, but noticing spacial patterns is even more challenging. Choropleth maps can be especially useful in visualizing data that varies by region.

The Python programming language and the Folium library makes creating choropleth maps quick and easy, as this lesson will show. But it is only easy once the data has been arranged properly.

Most of the time, "properly arranged" data is not what one encounters in the real world. Most of this lesson demonstrates techniques used to organize data so that it will produce a useful map. Initially, this means combining the data to be graphed with shape files that define the county boundaries, which will allow the creation of a basic choropleth map. Because the initial map isn't especially informative, this lesson will show additional ways to manipulate the data to produce more meaningful maps.

## Lesson Goals

At the end of the lesson you will be able to:
* Load several types of data from web archives
* Associate latitude/longitude points with county names, geography, and FIPS numbers
* Create a basic choropleth map
* Reflect on some issues that map-designers need to consider, especially the problem of dealing with non-normal distributions of data
* Data to plot data *rates* rather than data *values*
* Enhance a Folium map with titles, popup data, and mini-maps.

The lesson visualizes data from the *Washington Post*'s [Fatal Force](https://github.com/washingtonpost/data-police-shootings) database, which is available in this lesson's associated `assets` [folder](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/fatal-police-shootings-data.csv), hosted on _Programming Historian_'s GitHub repository. In 2015, the *Post* started the database, which seeks to document every time an encounter with a police officer ends in the death of the civilian. This data isn't collected or reported systematically, so the *Post*'s work fills an important lacuna in our understanding of how police interact with the people around them.

My comments will reflect the data in the database as of June 2024. Tragically, I can confidently predict that these numbers will continue to increase. If you work with the data in the `assets` folder, your visualizations should resemble those in this article. If you access the *Post*'s database, the numbers will be different.

Before getting started, a few comments about the tools used in this lesson.

### Folium

To create the maps, we will use [Folium](https://python-visualization.github.io/folium/), a Python library that automates creating Leaflet maps.

[Leaflet](https://leafletjs.com/) is a JavaScript library that faciliates the creation of interactive HTML maps. To use Leaflet one needs to know some CSS and JavaScript. For help with this, see the Programming Historian's article ["Web Mapping with Python and Leaflet"](https://programminghistorian.org/en/lessons/mapping-with-python-leaflet).

Folium makes it easy to create a wide variety of maps. For basic maps, the user doesn't need to work with HTML, CSS, or JavaScript: everything can be done within the Python ecosystem. Users can specify a variety of different basemaps (terrain, street maps, different colors) and display data with different markers, such as pins or circles. These can use different colors or sizes based on the data. 

Folium has a useful [Quickstart](https://python-visualization.github.io/folium/quickstart.html) that serves as an introduction to the library. In addition to these basic maps, Folium offers advanced functions, such as creating cluster-maps and heat-maps. This lesson will explore how to create choropleth maps with Folium. 

### Python, Pandas, and Geopandas

Python is the most popular programming language ([1](https://www.zdnet.com/article/programming-languages-python-just-took-a-big-jump-forward/), [2](https://www.infoworld.com/article/3669232/python-popularity-still-soaring.html)). It is especially useful for [data scientists](https://www.makeuseof.com/why-is-python-popular-for-data-science/) and others interested in analyzing data and visualizing data because it has an enormous library of tools specifically for these applications. This lesson assumes some proficency with Python, but I will explain things that might be unfamiliar.

[Pandas](https://pandas.pydata.org/) is a powerful package for data manipulation, analysis, and visualization. This lesson assumes also some proficency with Pandas, although when I do something interesting/confusing/advanced with it, I will explain what the system is doing.

There are several other Programming Historian lessons ([1](https://programminghistorian.org/en/lessons/visualizing-with-bokeh), [2](https://programminghistorian.org/en/lessons/crowdsourced-data-normalization-with-pandas)) that use Pandas. Pandas also includes a [Getting started](https://pandas.pydata.org/docs/getting_started/index.html) tutorial which may be useful.

Pandas has two basic data strutures: the `series` and the `dataframe`(often abbreviated as *DF*). A `series` is a one-dimensional array of data, akin to a column of data in a spreadsheet. A `dataframe` is similar to a spreadsheet: it has rows and columns of data. This lesson follows the common convention of using **DF** as an abbreviation for *dataframe*.

[Geopandas](https://geopandas.org/en/stable/) extends Pandas' functionality by adding tools to make working with geospatial data easier. Notably, it adds some [shapely](https://shapely.readthedocs.io/en/stable/) datatypes to Pandas that include `point` and `geometry`. These facilitate working with geographic data: the `point` datatype can store latitude / longitude data; the `geometry` datatype can store points that define the shape of a state, county, congressional district, census tract, or other geographic region.

### Google Colab

This lesson was originally written in Google's [Colab](https://colab.research.google.com/) system. Colab allows users to create [Jupyter notebook](https://realpython.com/jupyter-notebook-introduction/)-like files that combine markdown text and Python cells. Note that users must have a Google account to use Colab.

Colab is very useful in the classroom, since it runs entirely on the web. Students can access Colab notebooks with any computer or tablet that runs a modern web-browser. This means that instructors don't need to write different instructions for Macs, PCs, Linux, Chromebooks, etc. The system is fast and powerful: the virtual machines generally have around 12GB RAM and 23GB disk space; designed for machine learning, it also allows users to add a graphics card / hardware accelerator (we won't be using this!). Since computation is done in the cloud, users don't need to have a powerful machine to use the system.

Colab includes a very large collection of Python libraries, as it is intended for data science and machine learning. In our lesson, most of our libraries are all part of the standard Colab system.

#### Not using Colab?

While this lesson is written with Colab in mind, the code will run on personal computers, even low-powered chromebooks. But users will need to install any missing libraries, including *Geopandas*, *Pandas*, *Folium*, *Numpy*, *Jenkspy*, or others. I am not going to discuss installing these libraries, as instructions differ depending on the user's operating system (Apple, Windows, Linux, etc) and how they've installed Python on their system ([Conda vs Pip](https://www.anaconda.com/blog/understanding-conda-and-pip)). Users can find instructions on how to install these libraries by searching the web.

Non-Colab users will also need to be able to run a Jupyter notebook. Personally, I use Microsoft's [Visual Studio Code](https://code.visualstudio.com/) because it runs on a wide variety of different systems (Windows, Mac, Linux); supports Jupyter notebooks; can be used as an code editor / IDE for a wide variety of languages; integrates well with Github; and also supports text editing, including Markdown and Markdown previewing. There are other ways to install a Jupyter notebook on your system, such as the [Anaconda](https://www.anaconda.com/) software suite.

Whether using Colab or another Jupyter notebook, readers will find it easier to follow this lesson if they open the [notebook](https://nbviewer.org/github/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/data-into-choropleth-maps-with-python-and-folium.ipynb) containing the lesson's code. 

### Import Libraries

We start by loading the necessary Python libraries and assign their common aliases (`pd`, `gpd`, `np`). As you call methods from the libraries, you will use these aliases instead of the full library name.

```python
import pandas as pd
import geopandas as gpd
import folium
import numpy as np
```

## Get the Data

This lesson will show how to create a choropleth map using two data files:
* A file with the data we want to count and visualize
* A file with data about the shapes (in this case, counties) to draw on the map

### Fatal Force Data
The *Washington Post*'s "Fatal Force" data is the data to be counted and visualized. 

Before importing the data, you should read the *Post*'s [documentation](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/fatal-force-database-README.md) about the datafields, so you can get information on the `date` field.

Pandas tries to parse data as it imports it. It is pretty good at recognizing *string* (character) data and *numeric* data, importing them as `object` and `int64` or `float64` datatypes. But Pandas struggles with date-time fields. If we include the keyword `parse_dates=` parameter, along with the name of the date column, Pandas will parse the date field and make it a `datetime64` datatype.

This code block imports the data. To follow along with the lesson, use the code as written. 

```python
 ff_df = pd.read_csv('https://raw.githubusercontent.com/programminghistorian/ph-submissions/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/fatal-police-shootings-data.csv',
                    parse_dates = ['date'])
# ff_df = pd.read_csv('https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv',
#                    parse_dates = ['date'])

```
**WILL THIS BE THE URL WHEN PUBLISHED? IF NOT, THIS WILL NEED TO BE EDITED LATER**

If you want to see the most up-to-date version of the data from the *Washington Post*, comment (`#`) out the first two lines and un-comment the lines for the WP's repo. This lesson uses the data from the *Programming Historian* website; if you use the data from the *Post*, the numbers will be different.

## Inspect the Data

Next, you will look at the fatal force dataframe (ff_df) to see what sort of data it has, to check the data types, and look at the sample data.


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
     ...    
     16  was_mental_illness_related  8410 non-null   bool          
     17  body_camera                 8410 non-null   bool          
     18  agency_ids                  8409 non-null   object        
    dtypes: bool(2), datetime64[ns](1), float64(3), int64(1), object(12)
    memory usage: 1.1+ MB
```

```python
ff_df.sample(3)
```

<div class="table-wrapper" markdown="block">
    
| |id|date|threat_type|flee_status|armed_with|city|county|state|latitude|longitude|location_precision|name|age|gender|race|race_source|was_mental_illness_related|body_camera|agency_ids|
|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|:----|
|4219|4641|2019-04-16|attack|car|vehicle|Fountain Inn|NaN|SC|34.689009|-82.195668|not_available|Chadwick Dale Martin Jr.|24.0|male|W|not_available|False|False|2463|
|6392|7610|2021-06-04|shoot|foot|gun|Braintree|NaN|MA|NaN|NaN|NaN|Andrew Homen|34.0|male|W|photo|False|False|1186|
|7711|8368|2022-08-30|threat|not|gun|Cedar Rapids|NaN|IA|41.924058|-91.677853|not_available|William Isaac Rich|22.0|male|NaN|NaN|False|True|872|

</div>

As of May, 2024 there were about 9,600 records in the database.

The datatype for most of the variables are `object` (which is what Pandas calls `string` or text) data. The `date` variable is a `datetime` object. And there are numbers for the `latitude`,`longitude` and `age` fields.

If the lat/lon fields were not numbers, we would need to do some data cleaning to get them convered to `float`-type numbers. In Python a `float` is a number with decimal values; an `integer` is a whole number.

> This is an example of where the Pandas' parser isn't perfect: lat/lon should be `float`s but `age` should be an `int` since the `age` values are all whole numbers.

How many records have latitude/longitude (lat/lon) data? What percent of the database has this information?

```python
print(ff_df['latitude'].isna().sum())

    7,496

ff_df['latitude'].isna().sum() / len(ff_df)

    0.8900340100999691

```
This shows that there are 7,496 rows that have latitude values, which is about 89% of all the records. What should we do about the missing data?

With some work, you could add estimated locations. For example, many of the rows include either city or county information. You could find the center of these areas and add that lat/lon data to the DF. If you wanted to map exactly where a fatality ocurred, this wouldn't be useful, but for maps visualizing county-level data, this might suffice.

This work would be necessary if you wanted to use this data for a study or in a report. In our case, since we're just demonstrating how to use Folium, we won't dwell on the various methods one might use to add in the missing data. 

Instead, you will just create a smaller version of the DF that only includes rows with lat/lon data.


```python
ff_df = ff_df[ff_df['latitude'].notna()]
```

## County Geometry Data
To create the choropleth map, you also need a file that provides the geographic boundaries for the regions you wish to map. In this case, since we are interested in county-level data, we need to get a data file that defines the county shapes. The [US Census](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html) has a number of different "cartographic boundary files". These include shape files for counties (at various resolutions), congressional districts, and others.

While these files are in the ZIP format, Geopandas knows how to read them and extract the information it needs. We can load these files directly from the Census' website, but the `cb_2021_us_county_5m.zip` file is [available to download](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/cb_2021_us_county_5m.zip) from the *PH* repository.

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
     ...
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

Because we are interested in visualizing the data by county, we need a unique identifier for each county. The US Census bureau has [assigned numbers](https://www.census.gov/library/reference/code-lists/ansi.html) to each state (`STATEFP`) and county (`COUNTYFP`); these are combined into a five digit *Federal Information Processing Series* (**FIPS**) code. In the above table, the FIPS column is called `GEOID`. We will rename this column below; while not required, I find it easier to use the same column names in different tables if they contain the same data. 

The other column that we need is the `geometry` column. As can be seen in the `.sample()` output, each row of this column is a collection of latitude and longitude points that define a polygon that corresponds to the shape of a county.

Just for fun, pick a county you're familiar with and see what it looks like:


```python
counties[(counties['NAME']=='Suffolk') & (counties['STUSPS']=='MA')].plot()
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-01.png" alt="Image of Suffolk county, MA" caption="Figure 1. GeoPandas' geometry can handle the oddly-shaped Suffolk County, MA." %}


Since we don't need all the data in the `counties` dataframe, we will (a) rename the `GEOID` column to `FIPS` and (b) keep only columns we're interested in.


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

# Preparing the Data
Before we can create a choropleth map, we need to make sure we have a field common to both DFs. This will allow Folium to match the data from one DF with data in the other DF. 

Our goal is to add `FIPS` values to the Fatal Force dataframe. To do so, we will use a **spacial join** which allows users to add (or merge) data from one DF to another. The [spacial join](https://geopandas.org/en/stable/docs/user_guide/mergingdata.html) is a tool available in GeoPandas that is similar to Pandas' standard [joins](https://www.geeksforgeeks.org/different-types-of-joins-in-pandas/), except that instead of matching key values, spacial joins correlate rows based on location information. 

We will use a spacial join to match the lat/lon data in the Fatal Force DF to different counties, defined in the Counties DF.

To do so, we will create a new field in the Fatal Force DF, which will combine the data in the two lat/lon columns into a single `point` datatype. (`point` is a special datatype that Geopandas adds to the normal Pandas datatypes.)

> Note that the method to do this is `.points_from_xy`, so we need to specify the **longitude** *before* **latitude**, contrary to the standard way map coordinates are referenced.

As we do this, we need to specify a **coordinate reference system** [CRS](https://pro.arcgis.com/en/pro-app/latest/help/mapping/properties/coordinate-systems-and-projections.htm). The CRS is related the mathematical model that describes how lat/lon data (points on the surface of a sphere) is presented on a flat surface. For this lesson, the most important thing to know is that the dataframes need to use the same CRS before being joined.

Finally, we will convert the `ff_df` from a Pandas DF to a Geopandas DF.


```python
ff_df['points'] = gpd.points_from_xy(ff_df.longitude, ff_df.latitude, crs="EPSG:4326")
ff_df = gpd.GeoDataFrame(data=ff_df,geometry='points')
```

Since we need to make sure the two DFs use the same CRS, we will encode the `counties` with the same CRS we specify for the `points` field.

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

We specify `how=left` to tell Geopandas to use the `ff_df` as the main DF, to which we will add data from the `right_df` (=`counties`).

The end result will be the addition of FIPS values to the `ff_df`. (It will also add some fields we don't need, including the index number and county name from the `counties` DF; we can ignore these.)

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
     ...
     18  agency_ids                  7496 non-null   object        
     19  points                      7496 non-null   geometry      
     20  index_right                 7489 non-null   float64       
     21  FIPS                        7489 non-null   object        
     22  NAME                        7489 non-null   object        
    dtypes: bool(2), datetime64[ns](1), float64(4), geometry(1), int64(1), object(14)
    memory usage: 1.3+ MB
```
## Counting the Data by County
Now that we have a DF with data (`ff_df`) and a DF with county geometries (`counties`) that share a common field (`FIPS`) we are ready to draw a map.

For our first map, we will draw a map that uses colors and shading to show the number of cases of police killing civilians. We will create a new DF (`map_df`), which will summarize the data in the `ff_df` so we can create a choropleth map with it.

We can do this by simply doing a `.value_counts()` on the `FIPS` column. The `.reset_index()` method will turn the value_counts series back into a dataframe.

```python
map_df = ff_df[['FIPS']].value_counts().reset_index()
map_df
```

| |FIPS|count|
|:----|:----|:----|
|0|06037|302|
|1|04013|200|
|2|48201|114|
|...|...|...|
|1519|29071|1|
|1520|29083|1|
|1521|56029|1|
Length: 1522, dtype: int64

This shows that around 50% (1,522 of 3,234) of counties in the USA have had at least one instance of a police officer killing someone.

> Note: While this works in Colab using Pandas version 2.2.2, older versions of Pandas may name the column with the counts values **0**. In this case, rename the column:
```python
map_df.rename(columns={0:'count'})
```

## Draw the Map

To draw a map, we need to initalize a `folium.Map` object. Since we're going to be doing this multiple times in this notebook, I've created a little function that will initialize the map.

Folium requires attribution for map tiles (the underlying visual representation of the map). It supports a wide array of tiles; see the [Leaflet gallery](https://leaflet-extras.github.io/leaflet-providers/preview/) for examples, along with values for `tiles=` and `attr=`.

Folium has [default values](https://python-visualization.github.io/folium/modules.html) for many of its parameters. Because I find the default zoom level (`zoom_start = 10`) too large to show the continental USA well, the zoom level is set to 5.

The following code block defines a Python function that initializes a map object, with the required attribution information, the center of the map, and a zoom level of 5. It returns a `Map object`.

> Note: You do not need to be familiar with how Python creates and manipulates `object`s to use Folium or to follow this tutorial. It is an important topic for programmers and advanced users, but many people use these tools without delving deeply into Python's implementation of objects.

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
        key_on = 'feature.properties.FIPS',
        columns = ['FIPS','count'],
        bins = 9,
        fill_color='OrRd',
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings (2015-present)'
        ).add_to(baseMap)

baseMap # this displays the map
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-02.gif" alt="Map of the United States showing that map can be moved around and zoom in to see specific regions" caption="Figure 2. A basic interactive Folium choropleth map." %}

Folium creates interactive maps. Users can zoom in and out; using their mouse, they can move the map around to examine the area(s) in which they are most interested.

Before we talk about why this map is so uniform (and thus not terribly useful), let me briefly describe the different parameters that are being passed to the choropleth method. I've added line numbers to help with the explanation.

Here's the code:
```python
1 folium.Choropleth(
2        geo_data = counties,
3        data = map_df,
4        key_on = 'feature.properties.FIPS',        
5        columns = ['FIPS','count'],
6        bins = 9,
7        fill_color='OrRd',
8        fill_opacity=0.8,
9        line_opacity=0.2,
10       nan_fill_color = 'grey',
11       legend_name='Number of Fatal Police Shootings (2015-present)'
12       ).add_to(baseMap)
```

* Line 1 calls the `folium.Choropleth()` method and line 12 adds it to the map object initalized earlier. The method plots a GeoJSON overlay on the basemap.
* Line 2 (`geo_data=`) identifies the GeoJSON source of the geographic geometries to be plotted. This is the `counties` dataframe we downloaded from the US Census bureau.
* Line 3 (`data=`) identifies the source of the data to be analyzed and plotted. This is the `map_df` dataframe that we created from the fatal force dataframe (`ff_df`).
* Line 4 (`key_on=`) identifies the field in the GeoJSON data that will be bound (or linked) to the data from the `map_df`: we need to have one column in common between our dataframes. In this case, it will be the `FIPS` column.
* Line 5 is required because we're using a Pandas DF as the data source. The `data=` parameter tells Folium which columns in the DF to use.
  * The first list element is the variable that will be matched with the `key_on=` value.
  * The second element is the variable with the values to be used to draw the choropleth map's colors.
* Line 6 (`bins=`) specifies how many bins to sort the data values into. (The maximum number is limited by the number of colors in the color palette selected. This is often 9.)
* Line 7 (`fill_color=`) specifies the color palette to use. Folium's documentation identifes the following as built-in palettes: ‘BuGn’, ‘BuPu’, ‘GnBu’, ‘OrRd’, ‘PuBu’, ‘PuBuGn’, ‘PuRd’, ‘RdPu’, ‘YlGn’, ‘YlGnBu’, ‘YlOrBr’, and ‘YlOrRd’.
* Lines 8 (`fill_opacity=`) and 9 (`line_opacity=`) specify how opaque the overlay should be. The values range from 0 (transparent) to 1 (completely opaque). I like being able to see through the color layer a bit, so I can see city names, highways, etc.
* Line 10 (`nan_fill_color=`) tells Folium what color to use for counties lacking data ([NaN](https://pandas.pydata.org/pandas-docs/stable/user_guide/missing_data.html) = "not a number" which is what Pandas uses when missing data). This color should be distinctive from the color of the palette, so it is clear that data is missing.
* Line 11 (`legend_name=`) allows us to label the scale; this is optional but helpful, so people know what they're reading.

For a complete list of parameters, see the Choropleth documentation in [Folium](https://python-visualization.github.io/folium/modules.html?highlight=choro#folium.features.Choropleth)

## The Problem of Uneven Distribution of Data

As noted earlier, the basic map is not terribly informative: the whole US is basically one color:
* The grey counties are those for which the *Post* does not record any cases of fatal police shootings; this is about 50% of the counties in the USA.
* A few major urban areas, such as Los Angeles, have strong colors. But most non-grey counties are a pale-yellow color.

Why is this? 

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

> The default boxplot is vertical, but since most monitors are landscape-orientation, when I'm displaying the data on my monitor, I prefer to make the boxplot horizontal. To display the boxplot vertically, omit the `vert=False` keyword.


```python
map_df.boxplot(vert=False)
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-03.png" alt="A horizontal box plot showing the data distribution of the number of people killed by police in US counties" caption="Figure 3. Distribution of police killings per county." %}


This allows us to see that there are fewer than ten counties where police have killed more than 75 civilians.

Folium's algorithm does not handle data that has a few outlier values well. It divides the data range into an even number of 'bins' (specified in line 6 above).

In this case, I specified 9 bins, so each bin will be about 38 units wide ($$342 / 9 = 38$$).

* Bin 1 (0 - 38) will have almost all our data (since 75% of all all values are 5 or less).
* Bin 2 (38-76) will have almost all the rest of the data, judging by the boxplot
* Bin 3 (76-114) will have a handful of cases
* Bin 4 (114-152) will have 2 cases
* Bin 5 (152-190) will have 0 cases
* Bin 6 (190-228) will have 1 case
* Bins 7 and 8 (228-304) will have 0 cases
* Bin 9 (304-342) will have 1 case

Because the scale needs to cover ALL cases, when the vast majority of cases are in one or two bins, the map is not terribly informative: bins 4-9 exist but represent only 4 counties.

There are solutions to this problem, but none are ideal; some work better with some distributions of data than others. Mapmakers may need to experiment to see what map works best for a given set of data.


### Solution #1: Fisher-Jenks algorithm
Folium allows users to pass a parameter to the choropleth algorithm that will automatically calculate "natural breaks" in the data; Folium's [documentation says](https://python-visualization.github.io/folium/modules.html?highlight=choro#folium.features.Choropleth) "this is useful when your data is unevenly distributed."

Because the [jenkspy](https://pypi.org/project/jenkspy/) library is not part of Colab's standard collection of libraries, we will need to install it. 

> If you are using Colab, here's how to install a missing library. Colab, following the Jupyter notebook convention, allows users to issue terminal commands by prefixing the command with an exclaimation point. The next code block shows how to install the jenksby library in Colab using the `pip` command.

```python
! pip install jenkspy
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
        fill_opacity=0.8,
        line_opacity=0.2,
        nan_fill_color = 'grey',
        legend_name='Number of Fatal Police Shootings (2015-present)',
        use_jenks = True # <-- this is the new parameter we're passing to Folium
        ).add_to(baseMap)

baseMap
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-04.png" alt="A choropleth map of the US showing how the Fisher-Jenks algorithm creates different bins of data" caption="Figure 4. The map colorized by the Fisher-Jenks algorithm." %}


This is an improvement: the map shows a better range of contrasts. We can see that there are a fair number of counties outside the Southwest where police have killed several people (Florida, the Northwest, etc.)

But the scale is almost impossible to read! The algorithm correctly found natural breaks -- most of the values are less than 76, but at the lower end of the scale the numbers are illegible.

### Solution #2: Create a Logarithm Scale-Value

Logarithmic scales are useful when the data is not normally distributed.

 The [definition of a logarithm](http://www.mclph.umn.edu/mathrefresh/logs3.html) is $$b^r = a$$ or $$log_b a = r$$.

That is, the log value is the **exponent** $$r$$ that the base number $$b$$ would be raised to equal the original value $$a$$.

For base 10, this is easy to calculate: 

$$10 = 10^1$$ so $$\log_{10}(10) = 1$$

$$100 = 10^2$$ so $$\log_{10}(100) = 2$$

Thus, using a base 10 logarithm, each time a log value increase by 1, the original value would increase 10 times. The most familiar example of a log scale is probably the [Richter scale](https://en.wikipedia.org/wiki/Richter_magnitude_scale), used to measure earthquakes.


For our current data, since most counties have fewer than 5 police killings, most counties will have a log value between 0 and 1. The biggest value (302) have a log value of between 2 and 3 (that is, between $$10^2$$ and $$10^3$$).

To add a scale variable with a log10, we will use [numpy](https://numpy.org/)'s `.log10()` method to create our new scale column, called `MapScale`. (We imported `numpy` along with our other libraries at the beginning of the lesson.)

```python
    map_df['MapScale'] = np.log10(map_df['count'])
```

As we map the data again, we will remove the `use_jenks` parameter and change the column of data we want to use for the scale.

The problem with a log scale is that **most people won't know know to interpret it** -- what is the non-log (original) value of 1.5 or 1.8 on a log scale?

Even if folks remember the definition of logarithm (that is, that the when the scale says 1.5, they recall that this means the non-log value is $$10^{1.5}$$), if they don't have a calculator, they won't be able to convert the log values to the original number!

Unfortunately, Folium doesn't have a built-in way to address this problem. Instead, we need to import a method from the `branca` library and use some JavaScript to create a new scale.

For the purposes of this tutorial and its learning goals, you do not need to know the specifics of the following code. It simply replaces log values with non-log values. (I did not write it; rather, [Kota7](https://github.com/kota7) provided this solution in the [Folium Github issues discussion board](https://github.com/python-visualization/folium/issues/1374).)

```python
from branca.element import Element
e = Element("""
  var ticks = document.querySelectorAll('div.legend g.tick text')
  for(var i = 0; i < ticks.length; i++) {
    var value = parseFloat(ticks[i].textContent.replace(',', ''))
    var newvalue = Math.pow(10.0, value).toFixed(0).toString()
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
        columns = ['FIPS','MapScale'], # <== use the MapScale var for log values
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
    var newvalue = Math.pow(10.0, value).toFixed(0).toString()
    ticks[i].textContent = newvalue
  }
""")
colormap = cp.color_scale
html = colormap.get_root()
html.script.get_root().render()
html.script.add_child(e)

baseMap
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-05.png" alt="The map colorized with log-values, but with a scale that shows non-log values" caption="Figure 5. The map colorized with a log-scale, but with non-log values on the scale." %}

Note that the log values on the scale have been converted to the original (non-log) values.  Note, too, that the bins equal size, but their values increase exponentially, in line with their log10 values.

## The Cause of Uneven Distribution of Data and **Normalizing** Data

This map demonstrates a common characteristic of choropleth maps: the data tends to correlate closely with population centers. The counties with the largest number of police killings of civilians are those with large populations (Los Angeles, CA; Cook, IL; Dade, FL; etc.)

The same issue would arise if we were mapping ocurrences of swine flu (correlated with hog farms), corn leaf blight (correlated with regions that grow corn), etc.

This is why choropleth maps often do not visualize *values* (that is, raw numbers). Instead, they visual *ratios* (the number of cases per 100,000 population). Converting the data from values to ratios is called **normalizing** data. 

To do this, we need to get a dataset that includes county-by-county population statistics that, ideally, include a FIPS code.

I found this data at the [US Census Bureau](https://www.census.gov/), which has a huge number of [datasets](https://www.census.gov/data/datasets.html) that it provides the public.

The full dataset is huge, but when I read the [documentation](https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.pdf), I realized I only needed three columns: `STATE`,`COUNTY`, and `POPESTIMATE2019`. (I selected 2019 because the *Post*'s data extends from 2015 to present; 2019 is roughly in the middle of that time frame).

> Note: Depending on the research question / goal, it may be problematic to group several years of data together but to consider population data from a single year. It might be better to do this analysis year-by-year or to find the mean value of each county's population over the years studied to use as the denominator in the calculation below. Finding the mean value for the population of each county would not be difficult, but for the purpose of this lesson it seems unnecessarily complex.

Rather than loading the full database, Pandas allows us to specify specific columns to include with the `usecols` parameter. (Note that this file does not use the very common `utf-8` encoding scheme; I needed to specify the `"ISO-8859-1"` to avoid an `UnicodeDecodeError`.)

```python
#url = 'https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.csv'
url = 'https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/co-est2019-alldata.csv'

pop_df = pd.read_csv(url,
                     usecols = ['STATE','COUNTY','POPESTIMATE2019'],
                     encoding = "ISO-8859-1")
pop_df.head(3)
```
**[UPDATE CSV LINK TO JEKYLL BEFORE PUBLICATION]***

| |STATE|COUNTY|POPESTIMATE2019|
|:----|:----|:----|:----|
|0|1|0|4903185|
|1|1|1|55869|
|2|1|3|223234|

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

To join the DFs, the fields need to be the same datatype. The next code cell
1. Converts the numbers to string values -- with [.astype(str)](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.astype.html)
1. Adds leading zeros -- with .str.[zfill](https://www.geeksforgeeks.org/python-pandas-series-str-zfill/)(2)
1. Combines the two string variables to create a string `FIPS` column

The next code block does these three steps.

```python
pop_df['STATE'] = pop_df['STATE'].astype(str).str.zfill(2) # convert to string, and add leading zeros
pop_df['COUNTY'] = pop_df['COUNTY'].astype(str).str.zfill(3)
pop_df['FIPS'] = pop_df['STATE'] + pop_df['COUNTY'] # combine the state and county fields to create a FIPS
pop_df.head(3)

```

| |STATE|COUNTY|POPESTIMATE2019|FIPS|
|:----|:----|:----|:----|:----|
|0|01|000|4903185|01000|
|1|01|001|55869|01001|
|2|01|003|223234|01003|

This DF includes population statistics for both entire states and individual counties.

State-wide values can be identified in the FIPS column because their county code (the last three digits) are **000**. County-level values start at **001** and continue to cover all the counties in the state.

In the DF above, row 0 reports the total population for state **01** (Alabama), while the  row 1 reports the population for county **001** (Autauga) in Alabama.

Since our earlier DFs don't include rows with a FIPS number of ***XX*000** when we do a join/merge, the state figures will be ignored.

Let's do the [merge](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.merge.html), then we can calculate a _per capita_ number for police shootings.

```python
map_df = map_df.merge(pop_df, on = 'FIPS', how = 'left')
map_df.head(3)
```
<div class="table-wrapper" markdown="block">

| |FIPS|count|ScaleTotPop|MapScale|STATE|COUNTY|POPESTIMATE2019|
|:----|:----|:----|:----|:----|:----|:----|:----|
|0|06037|302|2.480007|25.0|06|037|10039107.0|
|1|04013|200|2.301030|25.0|04|013|4485414.0|
|2|48201|114|2.056905|25.0|48|201|4713325.0|

</div>

The map_df has all the columns we've added as we've worked through this notebook. We could tidy it up by deleting them, but there isn't a pressing reason to do so -- it's a relatively small DF (with around 3,100 rows).

For now, let's just add new column that calculates the number of police killings per 100K population.

```python
map_df['count_per_100K'] = map_df['count'] / (map_df['POPESTIMATE2019']/100000)
map_df.head(3))
```

<div class="table-wrapper" markdown="block">

| |FIPS|count|ScaleTotPop|MapScale|STATE|COUNTY|POPESTIMATE2019|count_per_100K|
|:----|:----|:----|:----|:----|:----|:----|:----|:----|
|0|06037|302|2.480007|25.0|06|037|10039107.0|3.008236|
|1|04013|200|2.301030|25.0|04|013|4485414.0|4.458897|
|2|48201|114|2.056905|25.0|48|201|4713325.0|2.418675|

</div>

Now, let's try mapping the data per 100K and how this affect the way the map is visualized.

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

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-06.png" alt="A map showing the number of police killings per 100K population" caption="Figure 06. The number of police killings per 100K population." %}

Suddenly, high population counties (like Los Angeles and Cook) don't look so bad. Instead, low population counties with a single shooting are highlighted.

Earlier, we saw that the distribution of `count` was wildly non-normal. Is the `count_per_100K` any better?

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

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-07.png" alt="A boxplot showing the distribution of police killings per 100K population" caption="Figure 07. The distribution of the number of police killings per 100K population." %}

Wow! There are a LOT of outliers. Since this is a VERY uneven distribution, let's try using a log scale again.

```python
map_df['MapScale'] = np.log10(map_df['count_per_100K'])
map_df.boxplot(column=['MapScale'],vert=False)
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-08.png" alt="A boxplot showing the distrubtion of police killings per 100K population using a log-scale" caption="Figure 08. The distribution of the number of police killings per 100K population using a log-scale." %}

This conversion transforms a skewed distribution into a more normal distribution of log values.

We will recycle the code from above to draw this data with a log scale, with the scale converted back to original values.

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
    var newvalue = Math.pow(10.0, value).toFixed(0).toString()
    ticks[i].textContent = newvalue
  }
""")
colormap = cp.color_scale # this finds the color scale in the cp variable
html = colormap.get_root()
html.script.get_root().render()
html.script.add_child(e)

baseMap
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-09.png" alt="A map of police killings per 100K population using a log-scale" caption="Figure 09. The number of police killings per-100K population using a log-scale." %}

**Normalizing** the data dramatically changes the appearance of the map. Our initial visualization suggested that the problem of police killing civilians was limited to a few counties, generally those with large populations. But when the data is normalized, it appears police killings of civilians is far more widespread. The counties with the highest **rates** of killings are those with low populations, even if they have relatively few killings. Trying to illustrate this issue with charts or tables would not show the issue nearly as well.

## Add a Floating Information Box

Folium allows map maker to add a box that displays information about the area below the cursor. This might be a county name, its population, or the number of people killed by police officers.

To add the floating information box, we will use a Folium method called `folium.GeoJsonTooltip()`.

To use this method, we need to look "under-the-hood" of Folium. When Folium creates a choropleth map, it generates data about each geographic region. To access it, we need to save the choropleth data to a variable. 

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
The new `cp` (**c**horo**p**leth) variable allows us to look at the underlying GeoJSON data. GeoJSON data is akin to a list of nested Python [dictionary](https://www.geeksforgeeks.org/python-dictionary/) entries.

Counties have  `properties` associated with them, stored in a dictonary. In the following example, you can see that the county `properties` are `key`:`value` pairs. For the first county, the **FIPS** key has a value of **'01059'**; the **NAME** key has a value of **'Franklin'**.
```python
[{'id': '0',
  'type': 'Feature',
  'properties': {'FIPS': '01059', 'NAME': 'Franklin'}, # <= dictionary of K/V pairs
  'geometry': {'type': 'Polygon',
   'coordinates': [[[-88.16591, 34.380926],
     [-88.165634, 34.383102],
     [-88.156292, 34.463214],
     [-88.139988, 34.581703],
     [-88.16591, 34.380926]]]},
  'bbox': [-88.173632, 34.304598, -87.529667, 34.581703]},
 {'id': '1',
  'type': 'Feature',
  'properties': {'FIPS': '06057', 'NAME': 'Nevada'}, # <= dictionary of K/V pairs
  'geometry': {'type': 'Polygon',
   'coordinates': [[[-121.27953, 39.230537],
     [-121.259182, 39.256421],
     [-121.266132, 39.272717],
     ...
```
The `GeoJsonTooltip()` method allows us to extract and display data in the `properties` dictionary in the floating information box.

Unfortunately, as you can see from the above example, the GeoJSON data doesn't currently have the data we want to display. But we can add it by iterating over the GeoJSON data, finding the information in our `map_df` dataframe, and adding it to the GeoJSON properties dictionary. Here's how to do this:
1. Create a `map_data_lookup` dataframe that uses FIPS as its index. This will facilitate searching for each county's FIPS number and extract data from the `map_df` (count of deaths, population, etc.) to be added to the GeoJSON data.
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

Line 1 creates a dataframe from the `map_df` dataframe and sets its index to the `FIPS` code. This is important because -- as noted above -- the GeoJSON data for counties includes `FIPS` information. We will use the `FIPS` from the county data to find data from the `map_df` dataframe.

Line 2 iterates over GeoJSON data, looking at each each county.

Line 4 is where all the work happens, so let's look at it closely. 

`row['properties']['count']` adds a new **key** called `count` to the `properties` dictionary.

The **value** that gets assigned to the key is the code to the right of the equals sign: `f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.0f}"`. 

To understand it, read it from the inside out:
* The [`.loc`](https://www.geeksforgeeks.org/python-pandas-dataframe-loc/) method returns a value from a dataframe when we specify the `index value` and `column name`. 
  * In its simplist form, it looks like this `value = df.loc[index,col]`.
* Because the index of the `map_data_lookup` dataframe is the `FIPS` number, if we supply a `FIPS` and a column name (`'count'`), Pandas will search the table for the corresponding FIPS number and return the number in the `count` column.
* As we iterate over the rows in the GeoJSON data, the `row['properties']['FIPS']` will supply the `FIPS` value for which to search.

At this point, `map_data_lookup.loc[row['properties']['FIPS'],'count']` has tried to find the `count` value for the given `FIPS`. If found, it is returned as an integer. But we need it to be a string value, so it can be displayed properly. To convert it to a string, we wrap the value in an f-string and specify that it should not include decimals: (`f"{integer_value:.0f}"`).

Lines 3 and 5 prevent the program terminating when encounting a `KeyError` with `try:` and `except:` statements. What would cause a `KeyError`? If we use the `.loc[]` method and no data is found, Python will generate a `KeyError`. Since the GeoJSON data includes values for all the counties in the US, but the `map_data_lookup` dataframe will have values for only those counties in which a police officer has killed someone, we know that, for about 50% of the counties, there will be no data -- causing `KeyError`s. 

Line 6 provides a default value when an error is encountered: when no value is found in the `count` columns for a county, the value for that county is "No police killings reported"

<hr>

Once our GeoJSON data has been updated, we call the `folium.GeoJsonTooltip()` method. This method allows values from the property dictionary to be displayed. It also allows us to provide aliases, which is the text to be displayed in the tool tip box.

Finally, we tell Folium to save this information to `cp.geojson`, which it will interpret to create the map.

```python
folium.GeoJsonTooltip(['NAME','count'],
                      aliases=['County:','Num of Police Killings:']).add_to(cp.geojson)
```

Here's a code sample that includes the above matieral. 

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

```
This above example just reports the number of police killings reported. But this technique can be used to show multiple variables. The next example creates an information box that displays: 
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

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-10.gif" alt="A second animated map showing a more complex set of data displayed with the Tooltip plugin" caption="Figure 10. The Tooltip plugin allows the display of variables." %}

Adding an information box is complex but it can help users enormously.

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

Choropleth maps are an excellent tool for discovering and demonstrating patterns in data that might be otherwise hard to discern.

My grandfather, who worked at the US Census bureau, loved to pore over the tables of [The Statistical Abstract of the United States](https://www.census.gov/library/publications/time-series/statistical_abstracts.html). But tables of data are hard for people to understand: charts that visualize the data are more helpful, as Alberto Cairo argues in [*How Charts Lie*](https://www.amazon.com/How-Charts-Lie-Getting-Information/dp/1324001569).

Maps are an excellent way to visualize data that has a geographic component. [Wired](https://www.wired.com/story/is-us-leaning-red-or-blue-election-maps/) describes how [Kenneth Field](https://carto.maps.arcgis.com/home/user.html?user=cartogeek) produced a [gallery](https://carto.maps.arcgis.com/apps/MinimalGallery/index.html?appid=b3d1fe0e8814480993ff5ad8d0c62c32#) of different maps representing the 2016 US electoral results. US election maps are often colored in simple blue and red, showing which party carried a state or county. But most regions are not *all* red or *all* blue: most are shades of purple, as Field's gallery shows. Choropleth maps allow users to tell different, perhaps more nuanced, stories about data.

Choropleth maps may allow users to disern patterns in data that are otherwise difficult to observe. This is especially true for areas with arbitrary boundaries. Not knowing the edges of a police precinct, alderperson's ward, or census tract make it hard to interpret the meaning of all sorts of data (economic development, income, lead levels in the environment, life expectancy, etc.). But if that data is displayed in a choropleth map (or [a series of maps](https://www.chicagomag.com/news/there-is-one-map-of-chicago/)), one might notice correlations between variables that prompt additional investigation.

In short, choropleth maps are a powerful way to  displaying data and informing readers about topics. But they can also be tools to discover patterns in data that are otherwise hard to observe.

## Acknowledgments

Robert Nelson and Felipe Valdez provided very helpful feedback on drafts of this project. Alex Wermer-Colan helped guide me through the submission and review process. Nabeel Siddiqui's editorial assistance has been invaluable. Charlotte Chevrie and Anisa Hawes have been patient and helpful preparing this material for the *PH* website and shepherding me through the process. I appreciate everyone's assistance in improving this article; final responsibility, of course, remains mine. 
