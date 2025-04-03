---
title: "Turning Data into Choropleth Maps with Python and Folium"
slug: data-into-choropleth-maps-with-python-and-folium
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Adam Porter
reviewers:
- Rob Nelson
- Felipe Valdez
editors:
- Nabeel Siddiqui
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/604
difficulty: 2
activity: TBC
topics: TBC
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
mathjax: true
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

[Choropleth Maps](https://en.wikipedia.org/wiki/Choropleth_map) are often used in the media to visualize information such as [Covid-19 infection/death rates](https://www.nytimes.com/interactive/2021/us/covid-cases.html#maps), or [education spending per pupil](https://www.reddit.com/r/MapPorn/comments/bc9jwu/us_education_spending_map/). They are especially useful for visualizing data that varies by region. Representing data in this way reveals patterns that might otherwise be hard to discern: noticing spatial patterns in a table of numbers, for example, would be extremely challenging. The Python programming language, combined with the Folium library, makes creating choropleth maps quick and easy, as this lesson will show. 

First, however, you need to make sure your data has been arranged properly. Unfortunately, 'properly arranged' data is not something one encounters in the real world. Thus, most of this lesson will demonstrate techniques used to organize data so that it will produce a useful choropleth map. This will include joining your data to 'shape files' that define [county](https://en.wikipedia.org/wiki/County_(United_States)) boundaries, which will allow you to create of a basic choropleth map. Because a basic choropleth map isn't always especially informative, this lesson will show you additional ways to manipulate the data to produce more meaningful maps.

### Other *Programming Historian* lessons

*Programming Historian* has several other lessons under the ['mapping' rubric](https://programminghistorian.org/en/lessons/?topic=mapping). These include an [introductions to Google Maps](https://programminghistorian.org/en/lessons/googlemaps-googleearth); several lessons on [QGIS](https://www.qgis.org/) explaining how to [install](https://programminghistorian.org/en/lessons/qgis-layers), add historical [georeferences](https://programminghistorian.org/en/lessons/georeferencing-qgis) and [create layers](https://programminghistorian.org/en/lessons/vector-layers-qgis); directions on [how to use Map Warper](https://programminghistorian.org/en/lessons/introduction-map-warper) to stretch historical maps to fit modern models; and [how to use Story Map JS](https://programminghistorian.org/en/lessons/displaying-georeferenced-map-knightlab-storymap-js) to create interactive stories that combine maps and images. 

The *Programming Historian* lesson closest to this one explains [how to create HTML web maps with Leaflet and Python](https://programminghistorian.org/en/lessons/mapping-with-python-leaflet). However, using Leaflet directly may be challenging for some users, since it requires an understanding of CSS and JavaScript. 

The advantage of this lesson is that the [Folium](https://python-visualization.github.io/folium/) library we'll use automates the creation of Leaflet maps. This will allow you to create a wide variety of interactive maps *without* needing to know JavaScript or CSS: you only need to know Python, which is somewhat easier. 

### Lesson Goals

At the end of the lesson you will be able to:
* Load several types of data from web sources
* Use Pandas/GeoPandas to create clean datasets that can be mapped
* Associate latitude/longitude points with county names, FIPS numbers, and geometry 'shapes'
* Create a basic choropleth map
* Reflect on some issues that map-designers need to consider, especially the problem of dealing with highly skewed data distributions
* Process numeric data to plot 'rates' of deaths, rather than 'numbers' of deaths ('population normalization')
* Enhance a basic Folium map with pop-up boxes that display specific data for each geographic region

The lesson uses data from the *[Washington Post](https://en.wikipedia.org/wiki/The_Washington_Post)*'s [Fatal Force database](https://github.com/washingtonpost/data-police-shootings), which is available to [download from _Programming Historian_'s GitHub repository](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/fatal-police-shootings-data.csv). The *Post* started the database in 2015, seeking to document every time a civilian encounter with a police officer ends in the death of the civilian. This data is neither reported nor collected systematically by any other body, so the *Post*'s work fills an important lacuna in understanding how police in the USA interact with the people around them.

My comments will reflect the data in the database as of June 2024. If you work with the data downloaded from _Programming Historian_'s repository, your visualizations should resemble those in this lesson. However, if you access the *Post*'s database directly at your time of reading, the numbers will be different. Tragically, I can confidently predict that these numbers will continue to increase. 

Before getting started, a few comments about the tools used in this lesson.

### Lesson Preqrequisites

#### Python, Pandas, and Geopandas

To get the most out of this lesson, you should have some experience with Python and Pandas.

Python is the most popular programming language ([1](https://www.zdnet.com/article/programming-languages-python-just-took-a-big-jump-forward/), [2](https://www.infoworld.com/article/3669232/python-popularity-still-soaring.html)). It is especially useful for [data scientists](https://www.makeuseof.com/why-is-python-popular-for-data-science/), or anyone interested in analyzing and visualizing data, because it comes with an enormous library of tools specifically for these applications. If you are unfamiliar with Python, you may find Kaggle's [Introduction to Python](https://www.kaggle.com/learn/python) tutorial helpful. *Programming Historian* also has a lesson on [Python Introduction and Installation](https://programminghistorian.org/en/lessons/introduction-and-installation).

Written in Python (and [C](https://en.wikipedia.org/wiki/C_(programming_language))), Pandas is a powerful package for data manipulation, analysis, and visualization. If you are unfamiliar with Pandas, you will find some basic *Programming Historian* lessons on [installing Pandas](https://programminghistorian.org/en/lessons/visualizing-with-bokeh),and [using Pandas to handle and analyze data](https://programminghistorian.org/en/lessons/crowdsourced-data-normalization-with-pandas). Kaggle also offers free [introduction to Pandas](https://www.kaggle.com/learn/pandas) lessons, and Pandas has its own useful [Getting Started tutorial](https://pandas.pydata.org/docs/getting_started/index.html). 

This lesson uses several Pandas methods, such as:
- [.describe()](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.describe.html)
- [.info()](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.info)
- [.sample()](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.sample.html)
- [.value_counts()](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.value_counts.html)
- [.merge()](https://pandas.pydata.org/docs/reference/api/pandas.merge.html)

[Geopandas](https://geopandas.org/en/stable/) extends Pandas' functionality by adding tools to make working with geospatial data easier. Notably, it adds some [shapely](https://shapely.readthedocs.io/en/stable/) datatypes to Pandas including the `point` and `geometry` datatypes. These facilitate working with geographic data: the `point` datatype can store latitude / longitude data; the `geometry` datatype can store points that define the shape of a state, county, congressional district, census tract, or other geographic region.

#### Folium

As mentioned above, the main software this lesson uses is [Folium](https://python-visualization.github.io/folium/), a Python library that makes it easy to create a wide variety of Leaflet maps. You won't need to work with HTML, CSS, or JavaScrip: everything can be done within the Python ecosystem. You will be able to specify a variety of different basemaps (terrain, street maps, colors) and display data using various visual markers, such as pins or circles. The color and size of these markers can then be customized based on your data. 

Folium has a useful [Getting Started guide](https://python-visualization.github.io/folium/latest/getting_started.html) that serves as an introduction to the library. In addition to these basic maps, Folium's advanced functions include creating cluster-maps and heat-maps.


#### Google Colab

According to Dombrowski, Gniady, and Kloster, Jupyter notebooks 'are increasingly replacing Microsoft Word as the default authoring environment for research,' in large part because they give 'equal weight' to prose and code.[^x] Although you can choose to install and use Jupyter notebooks on a computer, I prefer to go through [Google Colab](https://colab.research.google.com/), a system that implements Juypter notebooks [in the cloud](https://en.wikipedia.org/wiki/Cloud_computing). Working in the cloud allows you to access Jupyter notebooks from any computer or tablet that runs on a modern web browser. This means that you can access it anywhere, and you don't need to adapt instructions for your own operating system. Google Colab is fast and powerful: its virtual machines generally have around 12GB RAM and 23GB disk space. You don't need to be working on a powerful machine to use it. Designed for machine learning, Colab can even provide a virtual graphics card and/or a hardware accelerator. What's more, most of the libraries needed for this lesson are already part of Colab's very large collection of Python libraries. For all these reasons, I recommend using the Colab environment. (For a more detailed comparision between Colab and Jupyter, see the [Geeks for Geeks](https://www.geeksforgeeks.org/google-collab-vs-jupyter-notebook/) discussion of the two systems.)

This lesson only requires Colab's basic tier, which you can access for free with any Google account. Should you need it for future projects, you can always purchase more 'compute' later. Google has a helpful [Welcome to Colab](https://colab.research.google.com/notebooks/intro.ipynb) notebook that explains Colab's design goals and capabilities. It includes links on how to use Pandas, machine learning, and various sample notebooks.

##### Not using Colab?

While this lesson is written with Colab in mind, the code will still run on personal computers, even low-powered chromebooks. *Programming Historian*'s [Introduction to Jupyter Notebooks](https://programminghistorian.org/en/lessons/jupyter-notebooks) lesson explains how to install and use Jupyter notebooks on a variety of systems.

Personally, I use Microsoft's [Visual Studio Code](https://code.visualstudio.com/) because it:
- runs on a wide variety of different systems (Windows, Mac, Linux)
- supports Jupyter notebooks; can be used as an code editor / IDE for a wide variety of languages
- integrates well with Github
- and also supports text editing, including Markdown and Markdown previewing. 

Whether you are using Colab or another Jupyter notebook, you will find it easier to follow this lesson if you open the [notebook](https://nbviewer.org/github/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/data-into-choropleth-maps-with-python-and-folium.ipynb) containing the lesson's code. 

## Getting Started

### Import Libraries

To start the lesson, load the Python libraries and assign them their common aliases (`pd`, `gpd`, `np`):

```python
import pandas as pd
import geopandas as gpd
import folium
import numpy as np
```

## Get the Data

This lesson will show how to create a choropleth map using two data files:
* A file with the data to count and visualize: the _Fatal Force_ dataset
* A file with data about the shapes (in this case, counties) to draw on the map: the 'cartographic boundaries' file

Using Pandas, these datasets will be turned into dataframes (DF). In order for Folium to match records from one dataframe with the other, they need to share a common variable. The maps will be plotting county-level data, so the common variable will be the **Federal Information Processing Standard** (FIPS) [county code](https://en.wikipedia.org/wiki/FIPS_county_code). Many datasets of county-level data include the FIPS code, but unfortunately the *Fatal Force* database does not, so this lesson will first teach you how to add it. 

If the *cartographic boundary* file you were using was based on another boundary type (such as [census tracts](https://en.wikipedia.org/wiki/Census_tract), or [police precincts](https://en.wikipedia.org/wiki/Police_precinct)), the same basic steps would be followed – the map produced would simply reflect these different geometries instead.

### Fatal Force Data

The *Washington Post*'s Fatal Force dataset contains the data to be counted and visualized. The *Post* provides [documentation](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/fatal-force-database-README.md) about how this data is collected and recorded.

Pandas parses the data as it imports it. It is pretty good at recognizing 'string' (character) data and numeric data –importing them as `object` and `int64` or `float64` data types – but sometimes struggles with date-time fields. If you include the `parse_dates=` parameter, along with the name of the date column, it is more likely that Pandas will parse the date field correctly as a `datetime64` data type.

Th code block below imports the data. To follow along with the lesson's archived dataset, use the code as written. If you want to see the most up-to-date version of the data from the *Washington Post* instead, comment-out (with `#`) the first two lines, and un-comment the last two lines.

```python
ff_df = pd.read_csv('https://raw.githubusercontent.com/programminghistorian/ph-submissions/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/fatal-police-shootings-data.csv', parse_dates = ['date'])
# ff_df = pd.read_csv('https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv',
#                    parse_dates = ['date'])

```

#### Inspect the Data

Let's check the data with the `.info()` and `.sample()` methods:

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

In May 2024, there were over 9,600 records in the database.

The different data types include `object` (most variables are text data); `datetime64` (for the `date` variable); `float64` for numbers with decimals (latitute, longitude, age) and `int64` for integers (whole numbers). Finally, we have a few `bool` data types, in the columns marked with 'True' or 'False' boolean values.

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

You can use the latitude and longitude values to map the FIPS code to each record. What percent of the records have this data?

```python
print(ff_df['latitude'].notna().sum())

    7,496

ff_df['latitude'].notna().sum() / len(ff_df)

    0.8900340100999691
```

This shows that 7,496 rows contain latitude values, which is about 89% of all the records. 

If you wanted to use this data for a study or report, finding values for the missing data would be important. For example, the Google Maps API can provide latitude/longitude data from a street address. But since exploring these techniques goes beyond the goals of this lesson, the next line of code will create a smaller version of the dataframe that only includes rows with latitude/longitude data.

```python
ff_df = ff_df[ff_df['latitude'].notna()]
```

### County Geometry Data

To create the choropleth map, Folium needs a file that provides the geographic boundaries of the regions to be mapped. The [US Census](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html) provides a number of different cartographic boundary files: shape files for counties (at various resolutions), congressional districts, census tracts, and more. Many cities (such as [Chicago](https://www.chicago.gov/city/en/depts/dti/supp_info/geographic-information-systems.html)) also publish similar files for ward boundaries, police precincts, and so on.

We're going to use the Census website's `cb_2021_us_county_5m.zip` file, which is available to [download from the *Programming Historian* repository](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/cb_2021_us_county_5m.zip). Geopandas knows how to read the ZIP format and to extract the information it needs: 

```python
counties = gpd.read_file('https://raw.githubusercontent.com/programminghistorian/ph-submissions/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/cb_2021_us_county_5m.zip')

# counties = gpd.read_file("https://www2.census.gov/geo/tiger/GENZ2021/shp/cb_2021_us_county_5m.zip")
```

Let's check the counties data frame to make sure it has the information we're looking for:

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

Geopandas has imported the different fields in the correct format: all are `objects`, except for `ALAND` and `AWATER` (which record the area of the county that is land or water in square meters), and `geometry`, which is a special Geopandas data type.

The US Census bureau has [assigned numbers](https://www.census.gov/library/reference/code-lists/ansi.html) to each state (`STATEFP`) and county (`COUNTYFP`); these are combined into the five digit Federal Information Processing Standard (FIPS) county code (`GEOID` above). The next line of code will rename this column to **FIPS** – although this is not technically required, I find it easier to use the same column names in different tables if they contain the same data. 

```python
counties = counties.rename(columns={'GEOID':'FIPS'})
```

The second column which Folium needs is the `geometry` column. As can be seen in the `.sample()` output, each row of this column is of the `polygon` data type, comprised of the set of latitude and longitude points that define the shape of a county.

Just for fun, pick a county you're familiar with and see what it looks like:

```python
counties[(counties['NAME']=='Suffolk') & (counties['STUSPS']=='MA')].plot()
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-01.png" alt="Image of Suffolk county, MA" caption="Figure 1. GeoPandas' geometry can handle the oddly-shaped Suffolk County, MA." %}

The only columns needed in the `counties` dataframe are `FIPS`, `NAME`, and `geometry`, so the next code block creates a simplified version containing only these columns:

```python
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

### Matching the Data

To map the FIPS values from the `counties` dataframe to the Fatal Force dataframe, you can use the special GeoPandas method [spatial join](https://geopandas.org/en/stable/docs/user_guide/mergingdata.html), which is syntatically similar to a Pandas [join](https://www.geeksforgeeks.org/different-types-of-joins-in-pandas/). But where the latter only matches values from one dataframe to values in another, the spatial join examines coordinate values, matches them to geographic region data, and returns the associated FIPS code.

To prepare to execute the spatial join, you will create a new field in the Fatal Force dataframe to combine the latitude and longitude columns into a single `point` data type. (`point` is a special data type added by Geopandas.)

Note that the method to create the new variable is `.points_from_xy`, so **longitude** (x) must be specified *before* **latitude** (y), contrary to the standard way in which map coordinates are referenced.

Additionally, you need to tell GeoPandas which [coordinate reference system (CRS)](https://pro.arcgis.com/en/pro-app/latest/help/mapping/properties/coordinate-systems-and-projections.htm) to use. The CRS is a type of mathematical model that describes how latitude and longitude data (points on the surface of a sphere) are presented on a flat surface. For this lesson, the most important thing to know is that both dataframes need to use the same CRS before being joined.

The next code block ties all this together. It:
1. Uses GeoPandas (`gpd`) to add a **points** column to the Fatal Force dataframe and tells it to use a specific CRS
2. Uses GeoPandas to convert the Fatal Force dataframe from a Pandas to a GeoPandas dataframes
3. Converts the `counties` dataframe to the same CRS 

```python
ff_df['points'] = gpd.points_from_xy(ff_df.longitude, ff_df.latitude, crs="EPSG:4326")
ff_df = gpd.GeoDataFrame(data=ff_df,geometry='points')

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

This is a lot of preparation, but now that the two dataframes are properly set up, you can use the spatial join to add FIPS data to each row of the Fatal Force dataframe.

The next code block will use `geopandas.sjoin()` to create a new version of the Fatal Force dataframe. `left_df` and `right_df` specify which two dataframes are to be matched, and `how=` tells GeoPandas that it should treat the left dataframe as primary. This means that it will add the matching data from the right dataframe to the left.

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

### Counting the Data by County

Now that the Fatal Force dataframe is ready, Folium makes it easy to draw a map.

The first map you'll try will count the number of times people have been killed by police officers in each county and produce a choropleth map that shows, via color and shading, which counties have larger or smaller kill counts.

To do this, you can simply use the `.value_counts()` method on the `FIPS` column. Since each record in the `ff_df` represents one person killed by a police officer, counting the number of times each county FIPS number appears in the dataframe will report the number of people killed in that given county.

The code below executes the `.value_counts()` method on the FIPS column. Because `.value_counts()` returns a series, the `.reset_index()` method will turn the series into a dataframe. The new dataframe is then assigned to `map_df`, the variable name that will be used in the mapping process.

```python
map_df = ff_df[['FIPS']].value_counts().reset_index()
map_df
```

|     |FIPS  |count |
|:----|:-----|:-----|
|0    |06037 |302   |
|1    |04013 |200   |
|.....|......|......|
|1520 |29083 |1     |
|1521 |56029 |1     |

Length: 1522, dtype: int64

This shows that around 50% (1,522 of 3,234) of counties in the USA have had at least one instance of a police officer killing someone.

Note: While this works in Colab using Pandas version 2.2.2, older versions of Pandas may name the count column **0**. In this case, just rename the column:

```python
map_df.rename(columns={0:'count'})
```

## Create the Map

To draw a map, Folium needs to initalize a `folium.Map` object. It will do this repeatedly, so the code block belows creates a function to do so.

To ensure the map is initially located over the center of the continential USA, the `location=` parameter tells Folium to use `center = [40,-96]` – a set of coordinate values – as the middle of the map. Because I find the default zoom level (`zoom_start = 10`) too large to show the continental USA well, the zoom level is set to 5 in the function below. (You can check Folium's [default values](https://python-visualization.github.io/folium/modules.html) for many of its parameters.)

Folium requires you to attribute specific map tiles (the underlying visual representation of the map). It supports a wide array of tiles: see the [Leaflet gallery](https://leaflet-extras.github.io/leaflet-providers/preview/) for examples, along with values for `tiles=` and `attr=`.


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

To initialize the map, the next line calls the function and assign the data to the new `baseMap` variable:

```python
baseMap = initMap()
```

Folium then processes the data and adds it to the map:

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

The maps created by Folium are interactive: you can zoom in and out, and move the map around (using your mouse) to examine the area(s) in which you are most interested.

Before explaining why the colors on this map are so uniform (and thus not terribly useful), a brief description of the parameters that are being passed to the choropleth method will be helpful:

Here's the code with line numbers for analysis:

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

* Line 1 calls the `folium.Choropleth()` method and line 12 adds it to the map object initalized earlier. The method plots a GeoJSON overlay on the baseMap.
* Line 2 (`geo_data =`) identifies the GeoJSON source of the geographic geometries to be plotted. This is the `counties` dataframe downloaded from the US Census bureau.
* Line 3 (`data =`) identifies the source of the data to be analyzed and plotted. This is the `map_df` dataframe (counting the number of kills above 0 in each county), pulled from the Fatal Force dataframe (`ff_df`).
* Line 4 (`key_on =`) identifies the field in the GeoJSON data that will be bound (or linked) to the data from the `map_df`. As noted earlier, Folium needs a common column between both dataframes. In this case, this is the `FIPS` column.
* Line 5 is required because the data source is a dataframe. The `column =` parameter tells Folium which columns in the DF to use.
  * The first list element is the variable that should be matched with the `key_on=` value.
  * The second element is the variable to be used to draw the choropleth map's colors.
* Line 6 (`bins =`) specifies how many [bins](https://en.wikipedia.org/wiki/Data_binning) to sort the data values into. (The maximum number is limited by the number of colors in the color palette selected. This is often 9.)
* Line 7 (`fill_color=`) specifies the color palette to use. Folium's documentation identifes following built-in palettes: ‘BuGn’, ‘BuPu’, ‘GnBu’, ‘OrRd’, ‘PuBu’, ‘PuBuGn’, ‘PuRd’, ‘RdPu’, ‘YlGn’, ‘YlGnBu’, ‘YlOrBr’, and ‘YlOrRd’.
* Lines 8 (`fill_opacity=`) and 9 (`line_opacity=`) specify how opaque the overlay should be. The values range from 0 (transparent) to 1 (completely opaque). I like being able to see through the color layer a bit, so I can see city names, highways, etc.
* Line 10 (`nan_fill_color=`) tells Folium which color to use for counties lacking data ([NaN](https://pandas.pydata.org/pandas-docs/stable/user_guide/missing_data.html) stands for 'not a number', which is what Pandas uses when missing data). This color should be distinct from the palette colors, so it is clear that data is missing.
* Line 11 (`legend_name=`) allows you to label the scale. This is optional but helpful, so people know what they're reading.

For a complete list of parameters, see the Choropleth documentation in [Folium](https://python-visualization.github.io/folium/modules.html?highlight=choro#folium.features.Choropleth)

## The Problem of Uneven Distribution of Data

As noted just above, this basic map (Figure 2) is not terribly informative... The whole United States consist of basically only two colors:
* The grey counties are those for which the *Post* have not recorded any cases of fatal police shootings; this is about 50% of the counties in the USA.
* Almost all the rest of the country is pale yellow, except for a few major urban areas, such as Los Angeles.

Why is this? The clue is to look at the scale, which varies from 0 to 342.

Pandas' [`.describe()`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.describe.html) method provides a useful summary of your data, including the mean, standard deviation, median, and quartile information:

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
1. At least 75% of these 1,596 counties have had 5 or fewer killings. Thus, there must be a few counties in the top quartile that have had many more killings.

A [boxplot](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.boxplot.html) is a useful tool for visualizing this distribution:

```python
map_df.boxplot(vert=False)
```
{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-03.png" alt="A horizontal box plot showing the data distribution of the number of people killed by police in US counties" caption="Figure 3. Distribution of police killings per county." %}

Although imperfect, this allows us to see that there are fewer than ten counties in which police have killed more than ~75 civilians.

Folium does not handle such uneven data distributions very well. Its basic algorithm divides the data range into a number of equally sized 'bins'. This is set to 9 (in Line 6 above), so each bin is about 38 units wide ($$342 / 9 = 38$$).

* Bin 1 (0 - 38) contains almost all the data (since 75% of all all values are 5 or less).
* Bin 2 (38 - 76) contains almost all the remaining data, judging by the boxplot in Figure 3.
* Bin 3 (76 - 114) has a handful of cases
* Bin 4 (114 - 152) has 2 cases
* Bin 5 (152 - 190) has 0 cases
* Bin 6 (190 - 228) has 1 case
* Bins 7 and 8 (228 - 304) has 0 cases
* Bin 9 (304 - 342) has 1 case

Because the scale needs to cover all cases (0 to 342 killings), when the vast majority of cases are contained in just one or two bins, the map becomes somewhat uninformative: bins 4 - 9 are shown, but represent only 4 counties combined.

There are solutions to this problem, but none are ideal; some work better with some distributions of data than others. Mapmakers may need to experiment to see what map works best for a given set of data.

### Solution #1: Fisher-Jenks algorithm

Folium allows you to specify `use_jenks = True` to the choropleth algorithm, which will automatically calculate 'natural breaks' in the data. Folium's [documentation says](https://python-visualization.github.io/folium/modules.html?highlight=choro#folium.features.Choropleth) 'this is useful when your data is unevenly distributed.'

To use this parameter, Folium relies on the [jenkspy](https://pypi.org/project/jenkspy/) library. jenkspy is not part of Colab's standard collection of libraries, so you must install with the `pip` command. Colab (following the Jupyter notebook convention) allows you to issue terminal commands by prefixing the command with an exclaimation point:


```python
! pip install jenkspy
```

Note: Installing a library in this way makes it available immediately but, unlike installing it on your local computer – where it remains available until uninstalled – Colab will erase it between sessions. So, each time you want to use a library that is not part of Colab's standard set, you will need to install it again.

Now that the jenkspy library is installed, you can pass the `use_jenks` parameter to Folium and redraw the map:

```python
baseMap = initMap()
 # If the map variable isn't re-initialized, Folium will add a new set of choropleth data
 # on top of the old data.

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
        use_jenks = True # <-- this is the new parameter being passed to Folium
        ).add_to(baseMap)

baseMap
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-04.png" alt="A choropleth map of the US showing how the Fisher-Jenks algorithm creates different bins of data" caption="Figure 4. The map colorized by the Fisher-Jenks algorithm." %}

This is already an improvement: the map shows a better range of contrasts. A higher number of counties outside the Southwest where police have killed several people (Florida, the Northwest, etc.)  are now visible.

However, the scale is almost impossible to read! The algorithm correctly found natural breaks – most of the values are less than 76 – but at the lower end of the scale the numbers are illegible.

### Solution #2: Create a Logarithm Scale-Value

Logarithmic scales are useful when the data is not normally distributed. The [definition of a logarithm](http://www.mclph.umn.edu/mathrefresh/logs3.html) is $$b^r = a$$ or $$log_b a = r$$. That is, the log value is the **exponent** $$r$$ to which the base number $$b$$ should be raised to equal the original value $$a$$.

For base 10, this is easy to calculate: 

- $$10 = 10^1$$ so $$\log_{10}(10) = 1$$
- $$100 = 10^2$$ so $$\log_{10}(100) = 2$$

Thus, using a base 10 logarithm, each time a log value increase by 1, the original value increases 10 times. The most familiar example of a $$log_10$$ scale is probably the [Richter scale](https://en.wikipedia.org/wiki/Richter_magnitude_scale), used to measure earthquakes.

Since most counties count under 5 killings, their $$log_10$$ value would be between 0 and 1. The highest values (up to 302) have a $$log_10$$ value between 2 and 3 (that is, between the original values are between $$10^2$$ and $$10^3$$).

You can easily add a $$log_10$$ scale variable using [numpy](https://numpy.org/)'s `.log10()` method to create a column called `MapScale`. (You imported `numpy`/`np` at the beginning of the lesson.)

```python
    map_df['MapScale'] = np.log10(map_df['count'])
```

#### Solution #2a: Displaying a Logarithm Scale

The problem with a log scale is that most people won't know know to interpret it: what is the original value of 1.5 or 1.8 on a $$log_10$$ scale?

Even people who remember the definition of logarithm (that is, that the when the scale says 1.5, they recall that this means the non-log value is $$10^{1.5}$$), if they don't have a calculator, won't be able to convert the log values to the original number!

Unfortunately, Folium doesn't have a built-in way to address this problem. What you can do is import a method from the branca library and use some JavaScript to create a new scale.

For the purposes of this tutorial and its learning goals, you do not need to know the specifics of the added code. It simply replaces log values with non-log values. (I did not write it; rather, [Kota7](https://github.com/kota7) provided this solution in the [Folium Github issues discussion board](https://github.com/python-visualization/folium/issues/1374).)

Here's the full code with the fragment included:

```python
baseMap = initMap()

cp = folium.Choropleth( #<== you need to create a new variable (here, 'cp' for choropleth) used by branca to access the data
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

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-05.png" alt="The map colorized with log-values, but with a scale that shows non-log values" caption="Figure 5. The map colorized with a log scale, with non-log values on the scale." %}

Note that the log values on the scale have been converted to the original (non-log) values. Although the bins are back to equal size, their values now increase exponentially.

## Normalizing Population Data

This map (Figure 5) demonstrates a common characteristic of urban maps: the data tends to correlate closely with population centers. The counties with the largest number of police killings of civilians are those with large populations (Los Angeles, CA; Cook, IL; Dade, FL; etc.). The same trend would arise for maps showing ocurrences of swine flu (correlated with hog farms), corn leaf blight (correlated with regions that grow corn), etc.

This is why choropleth maps are often better when they visual ratios rather than raw values: for example, the number of cases per 100,000 population. Converting the data from values to ratios is called 'normalizing' data. 

### Get county-level population statistics

To normalize the population data, your dataset needs to include county-by-county population statistics.

Looking through the available [US Census Bureau datasets](https://www.census.gov/data/datasets.html), I found that the [co_est2019-alldata.csv](https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.csv) contains this [information](https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.pdf). Pandas' `.read_csv()` method allows you to specify which columns to import with the `usecols` parameter. In this case, you only need `STATE`,`COUNTY`, and `POPESTIMATE2019` (I selected 2019 because the *Post*'s data extends from 2015 to present; 2019 is roughly in the middle of that time frame).

Note: Depending on the research question/goal, it may be problematic to group several years of data together: there may have been significant population shifts over this decade in certain counties. Thus, it might be more methodologically sound to analyze data annually or to find the mean value of each county's population over the years studied to use as the denominator in the calculation below. Finding the mean value for the population of each county would not be difficult, but seems unnecessary for the purpose of this lesson.

```python
#url = 'https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.csv'
url = 'https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/data-into-choropleth-maps-with-python-and-folium/co-est2019-alldata.csv'

pop_df = pd.read_csv(url,
                     usecols = ['STATE','COUNTY','POPESTIMATE2019'],
                     encoding = "ISO-8859-1")
pop_df.info()

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
```

Note that this file does not use the very common `utf-8` encoding scheme; I needed to specify the `"ISO-8859-1"` to avoid an `UnicodeDecodeError`.).

In the earlier `counties` dataframe, the FIPS varible was an `object` (string) data type. In this dataframe, Pandas imported `STATE` and `COUNTY` as integers. Let's combine these values into the FIPS county code. The code block below:

1. Converts the numbers to string values with [.astype(str)](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.astype.html)
2. Adds leading zeros with [.str.zfill](https://www.geeksforgeeks.org/python-pandas-series-str-zfill/)(2)
3. Combines the two variables to create a string type `FIPS` column

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

This dataframe includes population statistics for both entire states (county code 000) and individual counties (county code 001 and up). Row 0 reports the total population for state **01** (Alabama), while Row 1 reports the population for county **001** of Alabama (Autauga).

Since the dataframes we've used so far don't include the state rows (FIPS county code XX-000), these totals will be ignored by Pandas when it merges this dataframe. 

#### Add County-Level Population Statistics to the Map dataframe

To add these county-level population numbers, the [merge](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.merge.html) method lets you add the data from `pop_df` to `map_df`, matching on the **FIPS** column and using the left dataframe (that is, `map_df`) as primary.

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

The snippet of `map_df` above shows that it contains all the columns you've added so far in this lesson. At this point, the only columns you need are **FIPS**, **count**, and **POPESTIMATE2019**, so you could decide to tidy it up a bit – but as it's a relatively small dataframe (around 3,100 rows), there isn't a pressing reason to do so.

#### Calculate the 'Rate' of People Killed

You can use the code below to calculate the '[rate](https://en.wikipedia.org/wiki/Rate_(mathematics))' of people killed per 100,000 people. It divides the kill **count** variable by the county population over 100,000, and stores it in the new column **count_per_100k**:

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

### Re-draw the Map with Rates instead of Numbers of people killed

Now, you're ready to plot the rate of police killing per 100,000 people in each county. The only change required to the Folium code is to modify the `columns=[ ]` parameter to specify that it should use `count_per_100K` as the variable to colorize the map:

```python
baseMap = initMap()

cp = folium.Choropleth(
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','count_per_100K'], # <= change the variable to use on the map
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

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-06.png" alt="A map showing the number of police killings per 100K population" caption="Figure 06. The rate of police killings per 100K." %}

Now, high population counties (like Los Angeles and Cook) don't appear so bad. Instead, low population counties with a single shooting are shown in dark red.

[Earlier](#The-Problem-of-Uneven-Distribution-of-Data), you saw that the distribution of the `count` variable was wildly uneven. Is `count_per_100K` any better?

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

Again, there is a high number of outliers. Since this is another uneven distribution, using a log scale may result in a more normal distribution.

```python
map_df['MapScale'] = np.log10(map_df['count_per_100K'])
map_df.boxplot(column=['MapScale'],vert=False)
```

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-08.png" alt="A boxplot showing the distrubtion of police killings per 100K population using a log-scale" caption="Figure 08. Box plot of police killings per 100K using a log scale." %}

This conversion transforms a skewed distribution into a more normal distribution of log values.

To plot the log values on the map instead, you only need to make another small adjustement the Folium code so that is maps the `MapScale` variable. Below, I've also added the code to display the log values on the scale:

```python
baseMap = initMap()

folium.Choropleth(
        geo_data = counties,
        data = map_df,
        columns = ['FIPS','MapScale'], # <= change to use MapScale as basis for colors
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

Normalizing the data dramatically changes the appearance of the map. The initial visualization suggested that the problem of police killing civilians was limited to a few counties, generally those with large populations. But when the data is normalized, it police killings of civilians seem far more widespread. The counties with the highest rates of killings are those with lower population numbers. Trying to illustrate this issue with charts or tables would not be nearly as effective.

## Add an Information Box to the Map

In the process of creating the map above, you created vartious useful pieces of information: the number of people killed in each county by police, the county population, the rate of people killed, etc. Folium allows you to display such information in a floating box (using `folium.GeoJsonTooltip()`) that will show as the user moves their cursor over the map. This is very helpful, especially when examining areas one may not be familiar with – but it is a little complicated to get set up correctly.

When Folium creates a choropleth map, it generates underlying GeoJSON data about each geographic region. You can see this data by saving it to a variable:

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

The [JSON](https://stackoverflow.blog/2022/06/02/a-beginners-guide-to-json-the-data-format-for-the-internet/) data format is a standard way of sending information around the internet. Users familiar with Python will notice that it resembles a list of nested dictionary values. The example above shows that county `properties` are `key`:`value` pairs. County 0's `FIPS` key has a value of 01059; its `NAME` key has the value 'Franklin'.

### Add data to the Choropleth map's property dictionary

Unfortunately, the GeoJSON data above doesn't currently hold all the information you've generated so far. You can add it by iteratively selecting the desired information in the `map_df` dataframe and adding it to the GeoJSON properties dictionary. Here's how to do this:

1. Create a `map_data_lookup` dataframe that copies the `map_df`, using FIPS as its index. This will facilitate extracting data from the `map_df` (count of deaths, population, etc.) to be added to the GeoJSON data.
2. Iterate over the GeoJSON data and add new property variables using data the from `map_df`.

In the code below, I've added line numbers to clarify the subsequent explanation:

```python
1. map_data_lookup = map_df.set_index('FIPS')

2. for row in cp.geojson.data['features']:
3.   try:
4.       row['properties']['count'] = f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.0f}"
5.   except KeyError:
6.      row['properties']['count'] = 'No police killings reported'
```

- Line 1 creates a dataframe from `map_df` and sets its index to the `FIPS` code. This is important because the GeoJSON data includes `FIPS` information. The code therefore uses it to find corresponding data in the `map_df` dataframe.

- Line 2 iterates over the GeoJSON data, examining the data for each county.

- Line 4 is where all the work happens, so let's look at it closely: 

`row['properties']['count']` adds the `count` key to the `properties` dictionary.

`f"{(map_data_lookup.loc[row['properties']['FIPS'],'count']):.0f}"` assigns the value to this key.

To understand this code, let's read it from the inside out:
* [`.loc`](https://www.geeksforgeeks.org/python-pandas-dataframe-loc/) returns a value from a dataframe based on its `index value` and `column name`. In its simplist form, it looks like `value = df.loc[index,col]`.
* Because `map_data_lookup`'s index is the `FIPS` code, if you supply a `FIPS` and a column name (`'count'`), Pandas will search the table for the corresponding FIPS number and return the number in the `count` column.
* As it iterates over the rows in the GeoJSON data, the `row['properties']['FIPS']` will supply the `FIPS` value for which to search.

At this point, `map_data_lookup.loc[row['properties']['FIPS'],'count']` has tried to find the `count` value for every given `FIPS`. If found, it is returned as an integer. However, to display it properly, you need to convert it to a string, by wrapping the value in an f-string and specifying no decimals: (`f"{count:.0f}"`).

- The `try:` and `except:` statements in lines 3 and 5 prevent the program from terminating if it encounters a `KeyError`, which happens when no data is found by `.loc[]`. Since the GeoJSON data includes values for all the counties in the US, but `map_data_lookup` only includes values for counties with 1 or more killings, about 50% of the `.loc[]` searches will return no data – causing `KeyError`s!

- Line 6 gives a default value ("No police killings reported") when an error is encountered.

Now that you've fully updated Folium's GeoJSON data, you can call the `folium.GeoJsonTooltip()` method. This will allow you to display values from the property dictionary, and let you specify 'aliases': the text you want to display in your tool tip box.

Finally, you update the `cp.geojson` variable, which Folium will use to create the new map.

```python
folium.GeoJsonTooltip(['NAME','count'],
                      aliases=['County:','Num of Police Killings:']).add_to(cp.geojson)
```

Here is a code example collating every step described in this section: 

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

### Add multiple data elements to the "property" dictionary

In the example just above, you only report the number of police killings – but this technique can show multiple variables at once. In the next example, you create an information box that displays: 
* The county (already in the `cp.GeoJson` properties dictionary)
* The county's population
* The number of people killed by police
* The number of deaths per 100K population (these three variables still need to be added to the `cp.GeoJson` properties dictionary)

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

{% include figure.html filename="en-or-data-into-choropleth-maps-with-python-and-folium-10.gif" alt="A second animated map showing a more complex set of data displayed with the Tooltip plugin" caption="Figure 10. The Tooltip plugin displays multiple variables in a floating information box." %}

Despite its complexity, adding the floating information box dramatically improves the user experience of exploring your map – so do give it a try.

## Saving Maps

You cna easily save your maps as HTML files with the `.save()` method. 

```python
baseMap.save('PoliceKillingsOfCivilians.html')
```

These files can be shared with other people, who can open them in a browser and then zoom, pan, and examine individual county statistics by hovering their cursor over the map.

Note that this code saves the file to the Colab virtual drive. Remember: **Everything on the virtual drive will disappear** when the Colab session is closed.

You can see the files you've saved to your virtual drive by clicking on the file folder in the left margin of the browser window. Hover your cursor over the file and select _Download_ to save the file to your local hard-drive's default download folder.

## Conclusion

Choropleth maps are an excellent tool for discovering and demonstrating patterns in data that might be otherwise hard to discern.

My grandfather, who worked at the US Census bureau, loved to pore over the tables of [The Statistical Abstract of the United States](https://www.census.gov/library/publications/time-series/statistical_abstracts.html). But tables of data are hard for people to understand: charts that visualize the data are more helpful, as Alberto Cairo argues in [*How Charts Lie*](https://www.amazon.com/How-Charts-Lie-Getting-Information/dp/1324001569).

Maps are an excellent way to visualize data that has a geographic component. [Wired](https://www.wired.com/story/is-us-leaning-red-or-blue-election-maps/) describes how [Kenneth Field](https://carto.maps.arcgis.com/home/user.html?user=cartogeek) produced a [gallery](https://carto.maps.arcgis.com/apps/MinimalGallery/index.html?appid=b3d1fe0e8814480993ff5ad8d0c62c32#) of different maps representing the 2016 US electoral results. US election maps are often colored in simple blue and red, showing which party carried a state or county. But most regions are not *all* red or *all* blue: most are shades of purple, as Field's gallery shows. Choropleth maps allow users to tell different, perhaps more nuanced, stories about data.

Choropleth maps may allow users to disern patterns in data that are otherwise difficult to observe. This is especially true for areas with arbitrary boundaries. Not knowing the edges of a police precinct, alderperson's ward, or census tract make it hard to interpret the meaning of all sorts of data (economic development, income, lead levels in the environment, life expectancy, etc.). But if that data is displayed in a choropleth map (or [a series of maps](https://www.chicagomag.com/news/there-is-one-map-of-chicago/)), one might notice correlations between variables that prompt additional investigation.

In short, choropleth maps are a powerful way to display data and inform readers about topics.

### Acknowledgments

Robert Nelson and Felipe Valdez provided very helpful feedback on drafts of this project. Alex Wermer-Colan helped guide me through the submission and review process. Nabeel Siddiqui's editorial assistance has been invaluable. Charlotte Chevrie and Anisa Hawes have been patient and helpful preparing this material for the *Programming Historian* website and shepherding me through the process. I appreciate everyone's assistance in improving this article; final responsibility, of course, remains mine. 
