---
title: Geocoding Historical Data using QGIS 
authors:
- Justin Colson
date: 2016-05-30
reviewers:
layout: default
---

# Lesson Goals

Historians often want to create maps of historical data, as well as using and manipulating historical maps. Many types of sources used by historians are inherently spatial:
- Census, population or taxation data
- Imports and exports
- Routes and itineraries

Mapping data such as these involves rendering spatial information which humans can understand (such as names of towns or counties) into a format that can be understood by GIS software: geometry relating to latitude and longitude - geodata. 

There is often confusion between processes of geocoding and georeferencing. 
- Georeferencing refers to placing visual elements, usually raster images such as satellite photographs, scans of old maps, or some types of vector image such as architectural or archaeological drawings, into geographical space. This involves specifying latitude, longitude and scale.
- Geocoding is the process of resolving addresses (or some other kind of spatial description) which form part of a dataset into points on a map. This gives the ability to view, analyse and query that dataset spatially.

Geocoding your data offers many advantages, such as being able to:
- Display your data as a map (whether it originated as a list, table, or prose)
- Analyse distances between locations in your data
- View and analyse geographical distribution within your data

# Lesson Structure

This lesson is divided into two main sections: 
- Part 1: Joining tables, which is a simple way of mapping simple summary data such as totals or averages
- Part 2: Geocoding full datasets, which maps each item of data to a location, allowing much more flexibility, detailed spatial analysis, and more interesting maps 

The processes described are manual, and can be modified and applied to almost any geographical or historical context. At the end of the tutorial there is a note on using automated geocoding tools which are available to work with modern addresses, but these are of limited relevance to historians. Remember that street names tend to change relatively frequently, either in terms of spelling or entirely. Administrative areas have changed relatively frequently and were sometimes used inconsistently in historical sources (e.g. Bristol in Gloucestershire, Somerset, City of Bristol, Avon?) and indeed places have moved between countries, and countries have changed in name and extent. Even town names have changed and are subject to linguistic ambiguities (e.g. *Lynn Episcopi*, Bishop's Lynn, Lynn, King's Lynn, Kings Lynn). For these reasons it is often better to avoid using automated online geocoding tools and create a gazetteer to suit the historical context which you are researching. 

# Getting Started

This tutorial assumes that you have installed QGIS version 2 or above and have followed the Programming Historian tutorial [Installing QGIS 2.0 and Adding Layers](http://programminghistorian.org/lessons/qgis-layers) by Jim Clifford, Josh MacFadyen and Daniel Macfarlane. 

The tutorial was prepared using QGIS 2.14 'Essen' on Mac OS X 10.11 – menus, windows, and options might appear slightly different on different platforms or versions, but it should not be difficult to translate any differences. At a few points in the tutorial reference is made to how these techniques could be applied using ArcGIS, which is the industry standard commercial GIS application, and is widely available at universities, but is not always superior to QGIS.

**NB** QGIS requires a range of additional supporting framework applications, such as GDAL. These are installed automatically on Microsoft Windows, but must be installed separately on other platforms. They are included in the `.dmg` download file for MacOS X, and must be installed first.

You will also need to use a relational database such as Microsoft Access or LibreOffice Base, or alternatively be very proficient with spreadsheets.

**NB** LibreOffice requires a full installation of Java in order to use the Base application. This is achieved most easily by downloading and installing the Java 8 Development Kit for your operating system from [Oracle](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html). The Java 8 Runtime Environment does NOT work with LibreOffice on Mac OS X 10.11. 

The tutorial will map the data extracted from Alumni Oxonienses in the Programming Historian lesson [Using Gazetteers to Extract Sets of Keywords from Free-Flowing Texts](http://programminghistorian.org/lessons/extracting-keywords) using publically available maps of English and Welsh historic counties. If you complete that tutorial first it will help you to understand the nature of the data which is being mapped here. This data is provided as both a full dataset and also a separate file which is a summary of the numbers of alumni from each county, created from the first file using an Excel PivotTable.

The_Dataset-Alum-Oxon-Jas1-Placenames.csv  
AlumniCounties.csv

# Part 1: Joining Tables and Maps

The simplest way of mapping historical data is to join a table of data to a layer of map features. This technique is commonly used  by historians to create a map depicting a set of descriptive statistics for a set of data, for instance the number of individuals within a group originating from each county, or the proportion of inhabitants of each county working in a certain industry. However, joining tables to features in GIS only works on a one-to-one basis (or at least only one-to-one relationships can be used to define the appearance of the map). This means that only one value can exist per map feature for each attribute: it is not possible, for example, to associate more than one individual with a county polygon. For this reason, joins are best suited to representing the results of analysis completed in a spreadsheet or database. 

In this short tutorial we will map the total numbers of early modern University of Oxford alumni from each county. The file `AlumniCounties.csv` contains a summary of the full dataset which has already been created using a PivotTable in Microsoft Excel. Take a look at this file using your spreadsheet software to look at the column titles and the nature of the data contained in it. 

*NB*: QGIS is very sensitive to correct formatting of CSV files (specifically the type of line breaks). If you have difficulties using a CSV file created using Microsoft Excel (especially Excel 2007 or 2011 for MacOS) try re-saving the CSV file using LibreOffice Calc or Excel 2016.

## Tutorial: Joining Tables and Maps

1.	Open QGIS (on a Windows computer you will probably have many options within the QGIS Start Menu folder – choose the 'QGIS Desktop' option – not 'QGIS Browser' or 'GRASS')
2.	Set up a new Project file in QGIS and save it in your choice of location.(*NB.* QGIS defaults to saving 'relative pathnames' which means that as long as you save all of your project files in the same folder or its subfolders, you can move it to a different location – e.g. on a USB stick. You can check this setting via the menu Project>Project Properties and the 'General' side tab)
3.	It is very important to set the Coordinate Reference System (CRS) to one that suits the data you will import, and the location you plan to map. Go to the menu `Project>Project Properties` and select the 'CRS' tab at the side. First select ‘Enable on the fly CRS transformation’ at the top of this window then use the filter box to find and select `OSGB 1936 / the British National Grid` with the authority ID `ESPG:27700` from under the projected coordinate systems heading.

There is an important distinction between Geographic Coordinate Systems, which simply define measurement units and the datum, and Projected Coordinate Systems, which also define the way in which the globe is ‘flattened’ onto a map. OSGB is available in both variants in QGIS, so choose the projected version to get a map in which the UK appears the shape you would expect.

4.	Download a Shapefile containing polygons of the historic counties of England and Wales from [http://www.county-borders.co.uk](http://www.county-borders.co.uk/) (choose definition A and the OS National Grid, and without detached portions of counties). Unzip the contents of the ZIP file in the same folder as your project file
5. Use the "Add Vector Layer" button (looks like a line graph) from the Manage Layers toolbar to select and add the Shapefile `UKDefinitionA.shp` from within the folder you’ve unzipped 

You should now see an outline map of British counties in a random colour. If you right-click on the name of this layer in the Layers Panel (shown by default on the bottom left) you can select `Open Attribute Table` to view the database properties already associated with each feature on the map. Notice that the name of each county is named in three different ways, the fullest of which is in the column called `NAME`, as well as two ID columns. We now need to join this to the alumni data that we want to map using the fact that the values in the `NAME` column are the same as those in one of the columns in our spreadsheet (they must be exactly the same for this to work).

6.	The file `AlumniCounties.csv` contains a summary of the alumni dataset created using a PivotTable in Microsoft Excel. Two named columns contain county names (this column is called `Row Labels`) and simple totals of individuals originating in those places.
7.	In QGIS select the `Add Delimited Text Layer` button from the Manage Layers toolbox (looks like a large comma symbol). Browse to locate the file and select `CSV` as file format and `No geometry (attribute only table)` under `Geometry definition`.
8.	In the Layers Panel right click on the map layer (probably called the same as the shapefile that you added: `UKDefinitionA`) and select `Properties`, and then choose the `Joins` tab on the left. Use the `+` button to create a join. 
9. In the pop-up window select the new table imported from the CSV file as the `Join layer` and in the `Join field` and `Target field` choose the columns in each which contain the same information (the county name). The `Join field` is `Row Labels` in this case, and the `Target field` is the field in the map layer’s attribute table which contains the corresponding information (in this case `NAME`). 
10.	You can check that this join has worked by right-clicking on the shapefile layer and choosing `Open Attribute Table`. Notice that `AlumiCounties_Count Place of Origin` has now appeared as one of the columns in the counties shape layer, along with the various codes and ID numbers that are part of the shapefile we downloaded.

{% include figure.html src="../images/geocoding-qgis/QGISFigure1.png" caption="The join fields to vector dialogue" %}

This data can now be shown on the map by changing the options in the the `Style` tab of layer properties. QGIS offers a very wide range of style options to convey the data associated with each map element in a graphical form. The most useful are `Graduated`, which allows you to map a colour gradient to a range of numerical values in your data, and `Categorised`, which allows you to assign colours or other visual styles to text values or numerical ranges in your tables. For data such as this, with many different values within a logical range, the `graduated` style of representation is appropriate; if there were just a limited range of potential values, these could be displayed more effectively using the `categorized` option. 

11.	In the Layers Panel right click on the map layer (probably called the same as the shapefile that you added: `UKDefinitionA`) and select Properties, and then choose the Style tab on the left.
12.	From the top dropdown box select the `Graduated` style
13.	Select the column `AlumiCounties_Count Place of Origin` in the second drop-down box. Click `classify` to instruct QGIS to analyse the values in this column and create a series of ranges and colour ramp reflecting the range in the data. This is set to `Equal Interval` classification by default, but you may wish to experiment with this and select a different number of classes, or a different method, such as quantiles. Clicking OK will colour your map.

{% include figure.html src="../images/geocoding-qgis/QGISFigure2.png" caption="The vector layer Styles tab showing classified values based on the field joined from the table" %}

14.	Examine the results of your map and think about what is actually being represented. Are the raw numbers of alumni, coloured according to the same classes, for very differently sized counties, helpful? 

You may wish to experiment with the Expression Builder (accessed via the &sum; symbol next to `Column` in `Properties>Style`) to normalise these values using other columns and values that are available to you. Ideally we might normalise by population, but in the absence of this data, you might experiment by using the `$area` property, which is intrinsic to polygon shape layers in GIS. The very simple expression needed to create a map colour ramp on this would be (note that the field name contains spaces, so needs to be contained within double quotation marks):

```text
"AlumniCounties_Count of Place of Origin" /  $area  
```

When you alter any of these settings within the graduated style page you will need to click `Classify` again to reassign colours to the numerical ranges in your data. If you don’t reclassify, you might find that the layer becomes invisible on your map.  

# Part 2: Geocoding Historical Data

Geocoding is a much more powerful technique than simple table joins because each and every line of your data remains visible and able to be analysed within the GIS software as an individual point on the map. Fundamentally the aim is to join each item of data to a pair of coordinates. Most historical data cannot be geocoded automatically using online tools or QGIS plugins. The geocoding process must therefore be carried out manually to match each data row with a location. This is a simple database operation joining (matching) your data with a gazetteer (a list of places with coordinates). Many gazetteers are available, but relatively few are suitable for use with historical data, for example, for England:

- [Association of British Counties Gazetteer](http://www.gazetteer.org.uk/index.php) (data available to purchase)
- [The Historical Gazetteer of England's Place Names](http://placenames.org.uk/index.php) allows you to geocode individual locations online only, but the same data is also available via an API: [Digital Exposure of English Place-Names](http://edina.ac.uk/unlock/places/deep.html) . A better interface is available for those with UK Higher Education logins at the [Survey of English Place-Names](https://epns.nottingham.ac.uk/browse)

If no gazetteer exists for the area or period that you are studying, you can make your own relatively simply by creating a point layer containing the information that you require within QGIS (potentially by combining information from other existing layers) and exporting that complete with XY coordinates.

## Tutorial: Geocoding with a Gazetteer

If you have not done part 1, follow the instructions above to set up a new Project file in QGIS, and set the Coordinate Reference System to `OSGB 1936/the British National Grid` with the authority ID `ESPG:27700` as a projected coordinate system using `Project>Project Properties>CRS`. Download a Shapefile containing polygons of the historic counties of England and Wales from [http://www.county-borders.co.uk/](http://www.county-borders.co.uk/) (choose definition A and the OS National Grid). 
1. Use `Add Vector Layer` to add a new copy of the Shapefile to a your project. (GIS software allows you to add the same Shapefile to your project as many times as you like and each instance will appear as a separate layer).
2.	Examine the data contained within the Shapefile by right-clicking on the name of the map in the Layers Panel and selecting `Open Attribute Table`. Notice that columns include various codes, the names of the counties, and abbreviations, but not any coordinates. A polygon is comprised of a whole sequence of coordinates defining its boundary points (nodes) therefore they are hidden from you.
3.	As we want to assign a single pair of coordinates to each row of our data, we need to generate suitable coordinates from our polygons by finding their centre points (centroids). It is easy to create a new layer of points from this polygon layer which will have a single pair of centroid coordinates for each county. Select `Vector>Geometry Tools>Polygon Centroids`. Select a new name for the resulting Shapefile such as `CountiesCentroids` and select `add to canvas`

{% include figure.html src="../images/geocoding-qgis/QGISFigure3.png" caption="The Polygon Centroids dialogue and result" %}

4. Right click on the new centroids layer in the layers panel and select `Save As` to export, and click the first dropdown marked `Format` and select the CSV (Comma separated values) format. 
- Ensure that you select the same CRS that has already been used in your project, and make a note of it. 
- Under `Layer Options` within the `Save vector layer as…` window ensure that Geometry is set to `AS_XY` – this will add extra columns to the beginning of the table containing the X and Y coordinates of each point. 

{% include figure.html src="../images/geocoding-qgis/QGISFigure4.png" caption="The save vector layer as dialog configured for CSV gazetteer export" %}

This data can now be matched against your existing data to complete the geocoding process. 

## Geocoding your Data Table

We can now create a composite table of these locations and the data from our original table. This is created by matching the name of the county in the 'place' field of the alumni table with its equivalent in the new gazetteer using a relational database. This tutorial assumes that you have many hundreds or thousands or rows of data (as we do in this tutorial), requiring an automated method. If you only have a few rows, or you have difficulties using these methods, it is possible to do it manually - see 'Geocoding your own Historical Data' below.

In simple scenarios (such as this one where we are only matching a single 'place' attribute – i.e. only 'county') it is possible to code your data to a gazetteer using the VLOOKUP function in Microsoft Excel (or equivalent spreadsheets) or even using the MMQGIS plugin within QGIS. However, in most practical scenarios you will probably wish to match  on several attributes simultaneously (town, county and country for instance – you would want to distinguish between Sudbury, Suffolk, England; Sudbury, Derbyshire, England; Sudbury, Middlesex, England; and Sudbury, Ontario, Canada). This can be achieved in a somewhat cumbersome way using the INDEX function in Excel, but is more practical, and extensible, in a relational database such as Microsoft Access or LibreOffice Base. 

This tutorial uses LibreOffice, which is an Open Source alternative to Microsoft Office and is available for Windows, Mac OS X and all variants of Linux etc (NB it requires a full Java installation). It includes a relational database application on all platforms, unlike Microsoft Access which is available only in the Windows version of Office. However, it is quite restricted in its functionality. If you use Microsoft Access, or are a very proficient spreadsheet user, please feel free replicate this process using your preferred software.

1. Open LibreOffice Base and create and save a new database project using the default settings.
2. Data can be imported into Base only by opening in LibreOffice Calc and copy-pasting the whole sheet. Load each CSV file (the Counties CSV file you just created and `The_Dataset-Alum-Oxon-Jas1-Placenames.csv` – which is the full output of the 'Using Gazetteers to Extract Sets of Keywords from Free-Flowing Texts' tutorial) and copy, move to LibreOffice Base and click paste. In the dialog that appears set a table name such as `Alumni` and choose `Definition and data` and `use first line as column names` and finally click `Create`. 
3. You will be prompted to create a primary key, which is a unique id number for each row, which you should accept. You may also get a warning about a value that is too long in one of the fields, which you can accept in this instance (but note that it means some records may get truncated).
4. Repeat for the second table and look at each to refresh yourself on the contents of the columns.

{% include figure.html src="../images/geocoding-qgis/QGISFigure5.png" caption="Copying a table into LibreOffice Base" %}

5. Go to the `Queries` pane and select `Create a Query using Design View` and add both tables so that you see small windows appear with lists of the field names in each table. Link the ‘Place of origin’ field in the alumni table to the `Name` field of the Counties table by dragging and dropping one field name onto the other.
6. Double click each field in the alumni table, which to adds it to the list of fields below (which define the structure of the table that you will get as the result of the query). Also add the `x` and `y` fields from the counties by double clicking them. This query now contains all of the data you need to be able to map your data. 

{% include figure.html src="../images/geocoding-qgis/QGISFigure6.png" caption="The query design completed in LibreOffice Base, showing the join between the tables and the grid detailing the fields that will show in the result" %}

7. Save and run the query. Once you are happy with the results close the query window and export the results as a CSV file, in LibreOffice Base this is done by dragging the query itself onto the first cell of a new LibreOffice Sheets spreadsheet and then choosing `Save As`, use the default settings and save the file as `GeocodedAlumni.csv`

## Troubleshooting Database Gazetteer Joins

*NB* While relational database queries such as this are very powerful in allowing you match multiple criteria simultaneously, they can also present misleading results if not checked carefully. Any data that is not matched will usually be ignored 'silently' (i.e. you will not see an error message, so it is important to check whether the total number of lines in your results matches that in your original data. 

If there are too few results, some values do not match. In this table, for example, `Place of origin` includes values such as 'London' and 'Germany', which do not match any of the places in the gazetteer that we created. You could either note that the lower number of results is correct, or try to compensate by either altering places of origin, or adding locations to your gazetteer manually. Changing the properties of the join between the two tables from `Inner Join` to `Right Join` will ensure that ALL records from the alumni table are returned, whether or not there is matching data from the gazetteer `counties` table (presuming that the alumni table is on the right). This is a very useful diagnostic step.

If there are too many results, then each row in one table is matching multiple rows in the other. This is actually quite common with gazetteers, as there are likely to be duplicate points with the same, or very similar, place names in many datasets. This is especially true of very high resolution gazetteers which might have many neighbourhoods within a town individually located, but it is the 'town' column that you might want to match against. To guard against stray duplicates like this, you can use database functions to ensure only a single result is returned from your gazetteer. If you encounter this problem you should first create a query which uses the `minimum` or `maximum` functions (called sum functions in Access) on the ID field of your gazetteer, together with the `group by` function on the name field of your gazetteer, to isolate only a single occurence of each place name. You can then treat this as a subquery and add it to your existing query and join the now unique ID field to the existing gazetteer field using an `Inner Join` to ensure only one occurrence of each place name is matched. 

## Adding Geocoded Data to QGIS

You can now return to QGIS and add the data back to your map, using the new X and Y columns to map the data onto the map.
1.	use the `Add Delimited Text Layer` button (large comma symbol) to add your new CSV file to your GIS project.
2. Notice that when you choose this CSV file the options `First record has field names` and `Geometry definition: point coordinates` are automatically enabled, and the fields `X` and `Y` are chosen in the drop-down fields for X and Y coordinates. 
3. Once you click OK you will be prompted to select the Coordinate Reference System for these coordinates. This should be the same as that which you chose when originally creating your project and exporting the gazetteer information: OSGB 1936 (EPSG:27700).
4. Click OK and your data should be instantly mapped onto your project. 

When you add data that has been geocoded as points in this way, you only initially see a single point in each location. Because each line of data has exactly the same coordinates, they overlap. 

There are several ways to depict this data in ways that are more meaningful, and in this regard QGIS has many advantages over the leading commercial software ArcGIS. This can be achieved by creating a new polygon layer containing a count (or sum, average etc) of points contained within each polygon (available via the menu `Vector>Analysis Tools>Points in Polygon` - this feature is known as a spatial join in ArcGIS). The result of this method would be essentially the same as summarising your data externally (in a database or spreadsheet) and then performing a table join. 

A more useful way of depicting the geocoded data is to use QGIS's advanced display styles such as Heatmap or Point Displacement (these features are laborious to replicate in ArcGIS, and involve creating 'representations' in parallel to layers). Point Displacement is probably the most appropriate way to explore this particular data. 
1.	In the Layers Panel again right-click on the map layer and select Layer properties then the `Style` tab. In the top dropdown select `Point Displacement`. 
2. Tweak the options to make a view that is clear and legible.`Concentric Rings` are probably clearer than `rings`, and remember the sizes remain constant regardless of the zoom level, so zoom in to see the results more clearly. 
3. Also explore the Heat Map style and think about when each of these two styles might be more appropriate. 

{% include figure.html src="../images/geocoding-qgis/QGISFigure7.png" caption="The layer properties Style tab, showing point displacement styles, depicting points that actually overlap at precisely the same location" %}

The advantage of using displaying your data using styles, rather than mapping a summary using a table join (as in part 1 of this tutorial), or creating a copy of your polygons containing a count of points that had been inside them,  is that the layer remains dynamic. By changing the definition query (`Layers Panel>Layer properties>General>Provider Feature Filter>Query Builder`) you can easily tweak and refine which records are mapped. For example, use the less than or greater than operators to define years and see if trends change over time, or use the SQL LIKE statement to query the ‘details’ column to filter particular colleges – did they tend to attract students from particular counties?

You have now completed the geocoding process, and can enjoy the advantages of being able to analyse this inherently spatial historical data in an spatial way. In a real world scenario, you would probably only geocode data which is more precise than simple county level, giving a good deal more analytical potential and making maps plotted more meaningful. Where you have data which can be geocoded to a high – and crucially consistent – level of precision, it is possible to conduct a wide range of geographical analyses such as measures of clustering or distances. 

## Geocoding your own Historical Data

The processes outlined here – matching using external queries – should be adaptable to a wide variety of scenarios wherever you can obtain or create a suitable gazetteer. Remember that your success will depend on the consistency and accuracy of your data. Ensure that the same conventions are followed in both your data and your gazetteer, especially with regard to punctuation (e.g. ‘Devon’ or ‘Devonshire’, ‘Hay-on-Wye’, or ‘Hay on Wye’ etc.) If you are lucky enough to have data which is presented in modern format (i.e. modern countries, streets or even postcodes), it is possible to use the much easier process of automated geocoding. See the section below. 

If you only have a small number of rows in your data, or if you are having difficulty standardising your location information in one field so that it can be geocoded using the methods in this tutorial, you should remember that it is possible to do this process manually. Simply use one of many online geocoding tools to manually find the X and Y coordinates for each row of your data directly into X and Y columns in your spreadsheet or database. Remember to note the coordinate system used by the tool you use to find these coordinates though (probably WGS1984)! If you have manually geocoded data like this, simply follow the instructions above from 'Adding Geocoded Data to QGIS'

# Postscript: Geocoding Modern Addresses

If you have data which contains present-day addresses (such as postal addresses using contemporary street names, post or ZIP codes, or higher-level descriptions such as town or county names that follow modern conventions) then geocoding is very easy, using online tools or tools that use online APIs. Remember that online geocoding is unlikely to work if any of these elements of an address are not consistent with the present day.

Major online mapping providers such as Google, Bing, and OpenStreetMap all offer API (Application Programming Interface) connections to their highly sophisticated geocoding tools. These are the same tools that power the map search features of these websites, so are very effective at making 'best guess' decisions on ambiguous or incomplete addresses. It is worth noting that when accessed via an API, rather than their normal website, it will be necessary to provide country names as part of the address.

- Google provides two web based tools that allow direct use of their geocoding tools as well as their cartography: Google MyMaps and Google Fusion Tables. Both allow the upload of spreadsheets containing address columns, which are automatically geocoded.
- Within QGIS these APIs are available to geocode data via a number of dedicated plugins. Currently (February 2016) the most popular and well supported of these is MMQGIS.

1. Install MMQGIS using the ‘Manage and Install Plugins’ tool
2. Once installed, a new MMQGIS menu appears in the menu bar. `Geocoding` is one of the menu options within this, and `GeoCode CSV using Google Maps / Open Street Map` within that. 
3. The `GeoCode CSV using Google Maps / Open Street Map` dialog allows you to load a data table from a CSV file and specify the columns that contain (street) address, city, state and country. These are then processed using the selected online service. Successful results are created as points in a new layer (in the specified shapefile). Rows from the table that are not matched are listed in a new CSV file that is also created.

{% include figure.html src="../images/geocoding-qgis/QGISFigure8.png" caption="The 'Web Service Geocode' dialog from the MMQGIS plugin" %}

















