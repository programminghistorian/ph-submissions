---
title: Introduction to Geospatial Percent Change Analysis Using R and RStudio
collection: lessons
layout: lesson
slug: geospatial-percent-change-r
date: 2019-09-18
authors:
- Cameron Riopelle
- Jorge Quintela Fernandez
reviewers:
- tbd
editors:
- Zoe LeBlanc
review-ticket: 
- tbd
difficulty: 
- tbd
activity: 
- tbd
topics: 
- tbd
abstract: 
- tbd
---

{% include toc.html %}

# Introduction to Geospatial Percent Change Analysis Using R and RStudio

## Abstract

This lesson illustrates how geospatial health trends change over time using the open source software programs R and RStudio, focusing on the process of visualizing percent change in obesity incidence across a three-year period. The example data is openly available yearly health data (2016, 2017, 2018) from the CDC 500 Cities website and shapefiles downloaded from the US Census Bureau and from the Miami Dade County Open Data Portal. Throughout the course of this lesson, you will make 11 maps which  illustrate trends from the merged yearly data, using obesity as our variable of interest. While the end result of the lesson is making maps of rate of change of obesity health indicators in the dataset, the lesson demonstrates a variety of processes, such as how to import shapefiles and tabular data, how to subset spatial data, how to join the spatial and health data, how to explore the data using geospatial statistical methods, and how to create simple thematic maps. Novice users to geospatial techniques will benefit from learning more about this example of the process of geospatial research in R.

## Introduction

Many historians and archival researchers find that spatial visualizations of how public data change over time can help contextualize their research for readers and interested members of the public. Often, they turn to census data and public health records as they are both comprehensive and readily available. For  examples of the use of GIS and related geospatial vizualization techniques throughout the humanities, an excellent reference resource is the [Historical GIS Clearinghouse and Forum](http://www.aag.org/cs/projects_and_programs/historical_gis_clearinghouse/hgis_projects_programs), hosted by the American Association of Geographers. This lesson introduces techniques for visualizing rates of change over time for a health indicator (obesity) using the open source statistical software R. While the deliverables from this lesson can be created using R, we recommend using RStudio for the function View(), which can make it easier for the reader to understand the contents of objects.

The proposed learning outcomes of the lesson are:

* Learning how to conduct geospatial analysis using R and RStudio
* Mapping socioeconomic data by census tracts
* Visualizing percent change across time

Our tutorial demonstrates how to use the R language to join census and geospatial data, as well as how to visualize trends over time using techniques of geospatial analysis in the open source program R. It is targeted to novice users and written in both English and Spanish languages. It would be beneficial to any historian, archival researcher, or humanities researcher who seeks ways to study change over time using open GIS techniques, or contextualize their research using public-access data.

The technical takeaways from using this lesson will be that readers will learn how to create a spatial polygon data frame in R by importing a shapefile, how to define its projection using package “rgdal,” how to read and merge .csv files with spatial polygon data frames, and finally how to make calculations and visualizations of selected indicators (thematic maps) using the package “tmap.” In addition, we demonstrate how to perform related procedures such as selecting spatial objects by attributes and by location using base R functions, and how to select and rename variables from tables and create new columns using the package “dplyr.”

## Case Study Description

In the past several years, the city of Miami, Florida, has undergone massive changes in terms of gentrification, climate change factors, and the existence of a possible real estate bubble. Miami, with an estimated population of 470,914 in 2018 according to the US Census Bureau,  is one of the least affordable cities to live in, particularly for renters and people living in poverty. Using the CDC 500 Cities datasets from 2016, 2017, and 2018, we use R to draw on three years of data to show how one health indicator (obesity) changes over time in this dynamic socio-historical context.

## Preparation

## Prerequisites:

* The reader should have an updated version of R. The current version of R is downloadable from https://www.r-project.org/. At the time of submission, the current version of R is 3.6.1.

* The reader should have an updated version of RStudio. RStudio is an open source GUI for R which also provides additional functionality. To download RStudio, go to https://www.rstudio.com/. RStudio requires that R is installed to run.

## Suggested prior skills:

* This lesson assumes that the reader has at least an intermediate knowledge of the R language. If the reader would like to gain or brush up on this knowledge prior to going through this lesson, we recommend using the [Programming with R](http://swcarpentry.github.io/r-novice-inflammation/) lessons from Software Carpentry. In addition, the reader should be aware of [spatial polygon data frames](https://www.rdocumentation.org/packages/sp/versions/1.3-1/topics/SpatialPolygonsDataFrame-class).

* This lesson assumes that the reader has at least an introductory knowledge of GIS concepts. The reader should be particularly aware of the [shapefile](http://desktop.arcgis.com/en/arcmap/10.6/manage-data/shapefiles/what-is-a-shapefile.htm) data format, geographic coordinate systems, and how [map projections](http://desktop.arcgis.com/en/arcmap/10.6/map/projections/what-are-map-projections.htm) work.

## Obtaining the Data

This lesson uses geospatial data (shapefiles) and tabular data (.csv files). The two shapefiles contain the Census Tracts of the State of Florida and the internal municipal boundaries of Miami Dade County, including the city of Miami. The .csv files contain data obtained by the CDC using small area estimation methods for 27 chronic disease measures for the 500 largest American cities from 2016, 2017, and 2018.

For this lesson to be successful, you should first download the file [City_Miami.zip](/assets/geospatial-percent-change-r/City_Miami.zip) and extract the contents to “c:\temp\City_Miami”.

For reference, the Census tract file for this lesson is available for download from the [Census website](https://www2.census.gov/geo/tiger/GENZ2017/shp/). The Miami-Dade County Municipal Coastal Boundary data is freely available from [arcgis.com](https://gis-mdc.opendata.arcgis.com/datasets/municipal-boundary). Please note that these files are prone to change and may not be the same as the lesson files. For this reason, we recommend using the lesson files in the .zip file.

If you need to know more about the health variables included in the .csv files you can consult the [Data Dictionary for the CDC 500 Cities dataset](https://www.cdc.gov/500cities/measure-definitions.htm).

## Procedure

Before starting with this section be sure to have downloaded and extracted all files from the [City_Miami.zip](/assets/geospatial-percent-change-r/City_Miami.zip) file to folder "c:\temp\City_Miami," or an equivalent directory for Mac, Linux, or Unix.

### Setting the working directory

The way file directories are specified in R can vary from Windows to Linux\Mac terminals. Our script is written for a Windows environment. Windows file directories use either a forward slash (/) or two backslashes (\\). Linux\Mac file directories use a single backslash (\).

In R, you can use the getwd() command to view your working directory, or the setwd() command to set your working directory. For more information, you can access the help file for getwd() and setwd() by running ?getwd() from the R terminal.

Set the working directory to the folder containing all data:

```setwd("c:\\temp\\City_Miami")```

### Loading polygon shapefile for Florida Census Tracts (2017)

To begin processing the data for analysis, we must first load a polygon shapefile containing the Florida Census Tracts (2017) data. This step requires having the package “rgdal” loaded for the function “readOGR” in the next line of code. “Rgdal” provides bindings to the Geospatial Data Abstraction Library and access to projection/transformation operations from the 'PROJ.4' library. Both 'GDAL' raster and 'OGR' vector map data can be imported  into R. “Rgdal” provides the primary data access engine for many applications, including ArcGIS, Google Earth, and GRASS. For more information on GDAL and rgdal visit [www.gdal.org](http://www.gdal.org) and the [rgdal page on r-project.org]( https://r-forge.r-project.org/projects/rgdal/).

```install.packages("rgdal") # R Geospatial Data Abstraction Library```
```library(rgdal)```

After “rgdal” is installed and loaded, we can import our Florida Census Tracts data.

```FLCT_2017 <- readOGR(dsn = "c:\\temp\\City_Miami", layer = "cb_2017_12_tract_500k")```

We are creating an object named “FLCT_2017,” which is a spatial polygon data frame, a class of spatial data that contains polygons with attributes.

### Projections and coordinate systems

In order to further establish spatial relationships between different spatial objects in this lesson, we have to be sure that they have the same projected coordinate system. The first step, then, is to find out if our polygon shapefile “FLCT_2017) is projected.

```is.projected(FLCT_2017)```

At the moment, the output returns the line “FALSE,” which means that the layer in the object is not projected.

To project a layer, we first need to know the name of the new projection or coordinate system that will be applied and its identifier or Well Known ID (WKID). In this case, the name will be NAD_1983_HARN_StatePlane_Florida_East_FIPS_0901 (Meters) and the
WKID is 2777. A list with the Well Known IDs for most used map projections can be obtained from [arcgis.com](https://pro.arcgis.com/en/pro-app/arcpy/classes/pdf/projected_coordinate_systems.pdf).

Once we have the WKID for the new projection or coordinate system, we must obtain its parameters (latitude and longitude of origin, the units of length: for instance meters or feet, among other important definitions). For WKID 2777 they can be obtained using the expression below:

```CRS("+init=epsg:2777")```

The output from the previous line returns the following CRS argument: “CRS arguments:

```+init=epsg:2777 + proj=tmerc +lat_0=24.33333333333333 +lon_0=-81 + k=0.999941177 + x_0=200000 +y_0=0 + ellps=GRS80 + towgs84=0,0,0,0,0,0,0 + units=m +no_defs.”```

These CRS arguments have to be inserted in a new expression to finally apply the new coordinate system or projection to our map containing the Florida census tracts:

```FLCT_2017_p <- spTransform(FLCT_2017, CRS( "+init=epsg:2777 + proj=tmerc + lat_0=24.33333333333333 + lon_0=-81 + k=0.999941177 + x_0=200000 +y_0=0 + ellps=GRS80 +towgs84=0,0,0,0,0,0,0 + units=m + no_defs" ))```

Once this is done, and the line is run, we can verify the new projection by executing:

```is.projected(FLCT_2017_p)```

The output returns the statement “TRUE.”

To verify that FLCT_2017_p contains the new parameters you can run the line:

```proj4string(FLCT_2017_p)```

The output returns the line "+init=epsg:2777 +proj=tmerc +lat_0=24.33333333333333 +lon_0=-81 +k=0.999941177 +x_0=200000 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs."

### Visualizing a Map of Census Tracts in the State of Florida

The goal of this section is to create a simple visualization of the census tracts in the state of Florida. For this visualization, the package “tmap” should be installed and loaded. Information about this package can be located in the [html vignette](https://cran.r-project.org/web/packages/tmap/vignettes/tmap-getstarted.html) and [pdf helpfile](https://cran.r-project.org/web/packages/tmap/tmap.pdf). “Tmap” is a package for the creation of thematic geographical maps. If a pop-up asks if you want to “install from sources the packages which needs compilation,” click “Yes” and wait for a fairly long installation process to be completed.

```install.packages("tmap") #Thematic Map```
```library(tmap)```

Now we can make our visualization of the census tracts in Florida.

```tm_shape(FLCT_2017_p) + tm_fill("green") + tm_borders(col="black") +tm_layout(frame=F,main.title="Florida Census Tracts (2017)", main.title.size = 1)```

{% include figure.html  filename="figure1.png"
caption="Figure 1: Map of Florida Census Tracts (2017)" %}

The option “tm_fill(“green”)” makes the map green; however, other colors can be chosen. Option tm_borders(col="black") draws the borders of the polygon in black. The last  option: “tm_layout(frame=F,main.title="Florida Census Tracts (2017)", main.title.size = 1)”  creates a title of relative size equal to 1.

You will experiment creating other types of maps in this lesson using other parameters  and  options. We recommend you to study the documentation for package tmap to be able to understand all the possibilities it brings to make thematic maps.

A list of basic colors in R used in this lesson can be obtained [here](
http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf).

### Subsetting to the City of Miami

In this section, we will reduce the scope of  our Florida tract data only to the census tracts that intersect the boundary of the city of Miami.

To examine the contents of the object “FLCT_2017_p” in a spreadsheet-style we can use the line:

```View(FLCT_2017_p)```

Note that there are several slots within the object FLCT_2017_p: "Data", "Polygons", and "Projection". If we expand the "Data" slot, we obtain a list of the non-spatial attributes imported with the shapefile. As you can see, there is no attribute showing to which city each census tract belongs. Because of this we cannot subset the data using a simple selection from the table. We will need to use a second map (shapefile) containing the boundaries of Miami-Dade County. You can now close the data window and go back to the script.

Importing the new boundary shapefile into an object named “MDC_Municipalities”:

```MDC_Municipalities<- readOGR(dsn = "c:\\temp\\City_Miami", layer = "Municipal_Coastal_Boundary")```

Checking if  the map is projected:

```proj4string(MDC_Municipalities)```

The map is not projected, so we will have to project it using the same coordinate system we used for the Florida census tracts, and create a new object called “MDC_Municipalities_p”:

```MDC_Municipalities_p<-spTransform(MDC_Municipalities,CRS( "+init=epsg:2777 +proj=tmerc +lat_0=24.33333333333333 +lon_0=-81 +k=0.999941177+x_0=200000 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"))```

Run the following lines to verify the new projection:

```is.projected(MDC_Municipalities_p)```
```proj4string(MDC_Municipalities_p)```

To make our second map, which is a map of the municipal boundaries of the City of Miami, run the line:

```tm_shape(MDC_Municipalities_p) +tm_fill("yellow3")+tm_borders(col="black")+tm_layout(frame=F,main.title = "Miami Dade County Municipalities", main.title.size = 1)```

{% include figure.html
  filename="figure2.png"
  caption="Figure 2. Map of Municipal Boundaries of Miami-Dade County"  %}

The map in Figure 2 contains all municipalities in Miami Dade County, but we only need the boundary of the City of Miami, which is only one of the municipalities within the map. For this purpose we can use the following “subset” expression, which keeps only the boundaries touching the edges of the City of Miami and created a new object (map) called City_Miami:

```City_Miami=subset(MDC_Municipalities_p, NAME=="MIAMI")```

Visualizing the result:

```tm_shape(City_Miami) +tm_fill("green")+ tm_borders(col="black") +tm_layout(frame=F,main.title="City of Miami Boundary", main.title.size = 1)```

{% include figure.html
  filename="figure3.png" caption="Figure 3. Map of Municipal Boundary of the City of Miami" %}

Until this moment we have been using the package tmap in "plot mode", which allows for the visualization of static maps. If we want to bring in additional context to this map, such as a basemap containing other layers like streets or imagery, we have to switch temporarily to "view mode", which allows the creation of interactive maps.

```tmap_mode("view")```

Once the above line is run, you can see that the output returns the line “tmap mode set to interactive viewing.” This will enable the use of basemaps. If we execute the visualization code under view mode, we can obtain an interactive map and be able to select between different basemaps such as "Esri.WorldImagery", "OpenStreetMap" and "Esri.WorldTopoMap".

To see an example of the boundary map with a certain transparency  in view mode with the basemap “Esri. WorldImagery,” run the line:

```tm_shape(City_Miami) +tm_fill("green", alpha=.3)+ tm_borders(col="black") +tm_layout(frame=F,main.title="City of Miami Boundary", main.title.size = 1,basemaps = "Esri.WorldImagery")```

{% include figure.html filename="figure4.png" caption="Figure 4. Boundary Map in View Mode" %}

One downside of the view mode is that it adds constraints when working with legends, so for the duration of this lesson we will work with the plot mode of the package “tmap.” In addition, a basemap is not important for the type of visualization that we are conducting as the output of this lesson.

```tmap_mode(“plot”)```

Once the above line has been run, the output returns “tmap mode set to plotting.”

Finally, we can select the census tracts that have at least one point in common with the City of Miami (there is an edge overlap) and save the results as a new map called “CT_City_Miami”:

```CT_City_Miami=FLCT_2017_p[City_Miami, ]```

The “CT_City_Miami” shapefile is the file we use for the ensuing visualization of obesity rate of change across time. To make the map, visualizing the resulting 117 Census Tracts within the City of Miami in green and the boundary of the City of Miami as a reference in red, run the following line:


```tm_shape(CT_City_Miami) +tm_fill("lightgreen")+ tm_borders(col="black") +tm_layout(main.title="Census Tracts in the City of Miami", main.title.size = 1)+tm_shape(City_Miami) + tm_borders(col="red", lwd=2)+tm_layout(frame=F,main.title="Census Tracts Intersecting the City of Miami", main.title.size = 1)```

A map is produced with red lines the City boundaries:

{% include figure.html filename="figure5.png" caption="Figure 5: Map of Miami Boundaries and Census Tracts" %}

If you wish to explore the structure of the object “CT_City_Miami,” you can run the line:

```View(CT_City_Miami)```

There are 117 polygons in the shapefile. Inside the data slot there is a column named GEOID that will be used later for joining the health data downloaded from the CDC. Close the preview.

### Importing and Merging the CDC Data

At this point you should have extracted all csv files from the CDC into our working directory. To import each of the CSV files into dataframes using the “read.csv()” function execute the following lines:

```CDC_500_cities_2016= read.csv("CDC_Data_2016.csv", fileEncoding="UTF-8-BOM")```
```CDC_500_cities_2017= read.csv("CDC_Data_2017.csv", fileEncoding="UTF-8-BOM")```
```CDC_500_cities_2018= read.csv("CDC_Data_2018.csv", fileEncoding="UTF-8-BOM")```

Next, we can review each of the three dataframes.

```View(CDC_500_cities_2016)```
```View(CDC_500_cities_2017)```
```View(CDC_500_cities_2018)```

When you are done, close each of the previews.

For this lesson, we are interested in representing how the prevalence of obesity changes in time. First, we must build our new data that contains each year’s obesity indicator as well as geospatial references. We need to select the relevant obesity variable from each of the dataframes, plus other variables that may provide context. Finally, we will merge them into a new map data file which will visualize the changes of obesity across the span of three years.

To do this, we first install and load the library “dplyr.” “Dplyr” is a package for working with data frame objects. For more information on “dplyr,” see the [html vignette](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html) and [pdf helpfile](https://cran.r-project.org/web/packages/dplyr/dplyr.pdf).

```install.packages("dplyr")```
```library(dplyr)```

For the 2016 “500 Cities” CDC data, we first select the columns we want to keep and store the selection as an object named “CDC_500_cities_sel_var_16”:

```CDC_500_cities_sel_var_16 = select(CDC_500_cities_2016,StateAbbr,PlaceName,PlaceFIPS,TractFIPS,Place_TractID,OBESITY_CrudePrev)```

Next, we rename the column “OBESITY_CrudePrev” to “OBESITY_2016” to indicate the year:

```colnames(CDC_500_cities_sel_var_16)[colnames(CDC_500_cities_sel_var_16)=="OBESITY_CrudePrev"] <- "OBESITY_2016"```

We repeat the same steps for the years 2017 and 2018:

```CDC_500_cities_sel_var_17 = select(CDC_500_cities_2017, Place_TractID,OBESITY_CrudePrev)```

```colnames(CDC_500_cities_sel_var_17)[colnames(CDC_500_cities_sel_var_17)=="OBESITY_CrudePrev"] <- "OBESITY_2017"```

```CDC_500_cities_sel_var_18 = select(CDC_500_cities_2018, Place_TractID,OBESITY_CrudePrev)```

```colnames(CDC_500_cities_sel_var_18)[colnames(CDC_500_cities_sel_var_18)=="OBESITY_CrudePrev"] <- "OBESITY_2018"```

Once the column names have been changed to reflect each year’s data, we merge each dataframe into master data frame called “CDC_three_years.” This takes two merge steps:

```CDC_2016_2017 <- merge(CDC_500_cities_sel_var_16,CDC_500_cities_sel_var_17, by="Place_TractID")```

```CDC_three_years <- merge(CDC_2016_2017,CDC_500_cities_sel_var_18, by="Place_TractID")```

The merged data frame contains 26,970 rows corresponding to the Census Tracts of the
500 Cities data for each of the three years.

Next, we must merge the Census Tracts of Miami (CT_City_Miami) with the three-year data from the CDC (CDC_three_years) and create a new spatial polygon dataframe (CT_City_Miami_Obesity). New columns are added only for the rows that
have a match (117 matches total):

```CT_City_Miami_Obesity <- merge(CT_City_Miami,CDC_three_years, by.x = "GEOID", by.y = "TractFIPS")```

The data slot now also contains the fields joined from the .csv table.

### Creating the Visualizations (Thematic maps)

In this section, we demonstrate how to construct a series of visualizations (thematic maps). First, we create visualizations for each year of obesity data which provide context, and then we create two visualizations of the change in obesity rates across the three-year period. The R function which we use to create the maps is “tm_shape,” a part of the package “tmap.” More information about the function “tm_shape” can be obtained by entering ?tm_shape into the R terminal to view the health file.

First, we map the prevalence of obesity in the City of Miami by census tract for each year.

**2016:**

```tm_shape(CT_City_Miami_Obesity) + tm_fill("OBESITY_2016", title="Prevalence of Obesity", textNA = "No Data", colorNA = "white", title.size=1, style="fixed", breaks=c(0,20,30,40,50), interval.closure = "left", labels=c("< 20%", "20.01 to 30%","30.01 to 40%","40.01 to 50%"), palette = c("gray80","gray60", "gray47","gray15")) + tm_borders(col="black") +  tm_layout(frame=F,main.title = "Prevalence of Obesity by Census Tracts in Miami, 2016", main.title.size = 1, legend.outside = TRUE, legend.outside.position = "right", legend.outside.size = .4, outer.margins = c(0.2,0,0,0))```

{% include figure.html filename="figure6.png" caption="Figure 6: Thematic Map. Prevalence of Obesity by Census Tract in 2016" %}

**2017:**

```tm_shape(CT_City_Miami_Obesity) + tm_fill("OBESITY_2017", title="Prevalence of Obesity", textNA = "No Data", colorNA = "white", title.size=1, style="fixed", breaks=c(0,20,30,40,50), interval.closure = "left", labels=c("< 20%", "20.01 to 30%","30.01 to 40%","40.01 to 50%"), palette = c("gray80","gray60", "gray47","gray15")) + tm_borders(col="black")+  tm_layout(frame=F,main.title = "Prevalence of Obesity by Census Tracts in Miami, 2017", main.title.size = 1, legend.outside = TRUE, legend.outside.position = "right", legend.outside.size = .4, outer.margins = c(0.2,0,0,0))```

{% include figure.html filename="figure7.png" caption="Figure 7: Thematic Map. Prevalence of Obesity by Census Tract in 2017" %}

**2018:**

```tm_shape(CT_City_Miami_Obesity) + tm_fill("OBESITY_2018", title="Prevalence of Obesity", textNA = "No Data", colorNA = "white", title.size=1, style="fixed", breaks=c(0,20,30,40,50), interval.closure = "left", labels=c("< 20%", "20.01 to 30%","30.01 to 40%","40.01 to 50%"), palette = c("gray80","gray60", "gray47","gray15")) + tm_borders(col="black") +  tm_layout(frame=F,main.title = "Prevalence of Obesity by Census Tracts in Miami, 2018", main.title.size = 1, legend.outside = TRUE, legend.outside.position = "right", legend.outside.size = .4, outer.margins = c(0.2,0,0,0))```

{% include figure.html filename="figure8.png" caption="Figure 8: Thematic Map. Prevalence of Obesity by Census Tract in 2018" %}

Observe that polygons represented in white are identified as “No Data”. These polygons, although they are present in the map because they intersected the boundary of the city of Miami at least in one point,  were not listed in the CDC tables. They are all in the periphery of the city.

All three maps can be presented in one image using the function “tmap_arrange.” To learn more about the function “tmap_arrange,” you can run “?tmap_arrange” in the R terminal to view the function’s help file.

In the following lines, several objects (thematic maps and a legend) are created using the same information. They are finally consolidated in a single layout, through the use of tmap_arrange:

**2016**:

```Ob2016 <- tm_shape(CT_City_Miami_Obesity) + tm_fill("OBESITY_2016", colorNA = "white",  style="fixed", breaks=c(0,20,30,40,50), palette = "BuGn") + tm_borders(col="black") + tm_layout(main.title="2016", main.title.size=.7, main.title.position="center", frame=F, legend.show = F)```

**2017**:

```Ob2017 <- tm_shape(CT_City_Miami_Obesity) + tm_fill("OBESITY_2017", colorNA = "white", style="fixed", breaks=c(0,20,30,40,50), palette = "BuGn") + tm_borders(col="black") + tm_layout(main.title="2016", main.title.size=.7, main.title.position="center", frame=F, legend.show = F)```

**2018**:

```Ob2018 <- tm_shape(CT_City_Miami_Obesity) + tm_fill("OBESITY_2018", colorNA = "white", style="fixed", breaks=c(0,20,30,40,50), palette = "BuGn") + tm_borders(col="black") + tm_layout(main.title="2016", main.title.size=.7, main.title.position="center", frame=F, legend.show = F)```

In the following code, which creates the legend, in the title, the "\n" creates a new line for the legend title. In this case, it aids in creating better legibility when all map objects are combined.

**Creating the legend object**:

```LegOb <- tm_shape(CT_City_Miami_Obesity)+ tm_fill("OBESITY_2018", title="PREVALENCE OF OBESITY\nIN MIAMI", size=.4, textNA = "No Data", colorNA = "white", style="fixed",breaks=c(0,20,30,40,50), labels=c("< 20%", "20.01 to 30%","30.01 to 40%","40.01 to 50%"),palette = "BuGn") + tm_borders(col="black") + tm_layout(legend.frame=F, legend.only =T, legend.position=c(0.45,0.2), scale=.9, title.position = c(0,0))```

**Combining the map objects and legend**:

```Obesity_All=tmap_arrange(LegOb,Ob2016,Ob2017,Ob2018,nrow = 2)```

```tm_layout(Obesity_All)```

{% include figure.html filename="figure9.png" caption="Figure 9: Prevalence of Obesity by Census Tract in 2016, 2017 and 2018" %}

For our final visualization, which is a calculation of the change in obesity rates comparing 2016 to 2018, we must first calculate the change in obesity and add this information into a new column called "Obesity_Change_2016_2018" in the dataframe:

```CT_City_Miami_Obesity$Obesity_Change_2016_2018<-CT_City_Miami_Obesity$OBESITY_2018-CT_City_Miami_Obesity$OBESITY_2016```

Now that this column has been created, we can map obesity change:

```tm_shape(CT_City_Miami_Obesity) + tm_fill("Obesity_Change_2016_2018", midpoint = NA,   palette=c("forestgreen","greenyellow","red"), textNA = "No Data", colorNA = "white", title="Percent change", title.size=1, style="fixed", breaks=c(-6,-2,0,1), labels=c("<-2%", "-2 to 0%",">0 (increase)")) + tm_borders("black") + tm_layout(main.title = "Change in the prevalence of Obesity 2016-2018", main.title.size = 1, legend.outside = TRUE, legend.outside.position = "right", legend.outside.size = .4)```

{% include figure.html filename="figure10.png" caption="Figure 10: Change in the Prevalence of Obesity from 2016 to 2018" %}

Observe that in most census tracts the prevalence of obesity has decreased more than 2% and only in three census tracts there has been an increase (in red).

One final map that we may wish to create provides additional context. The rate of change alone does not paint a full picture of obesity in Miami. One issue is that the rate of change does not tell us anything about the existing severity of obesity in each census tract. To create a map of rate of change that also depicts the rates of obesity in each tract, you can run the following code which depicts rates of change (2016-2018) against the prevalence of obesity in each tract in 2018:

```tm_shape(CT_City_Miami_Obesity) + tm_fill("OBESITY_2018", title="Prevalence of Obesity", textNA = "No Data", colorNA = "white", title.size=1, style="fixed", breaks=c(0,20,30,40,50), labels=c("< 20%", "21 to 30%","31 to 40%","41 to 50%"), palette = c("gray80","gray60", "gray47","gray15")) + tm_borders(col="black") + tm_shape(CT_City_Miami_Obesity) + tm_dots("Obesity_Change_2016_2018", textNA = "No Data", colorNA = "white", alpha=.7, breaks=c(-6,-2,0,1), size=.6, shape=22, border.col="black", palette=c("forestgreen","greenyellow","red"), labels=c("<-2%", "-2 to 0%",">0 (increase)"), title="Percent change", title.size=1, style="fixed") + tm_layout(frame=F, main.title = "Prevalence of Obesity by Census Tracts in Miami, 2018", main.title.size = 1, legend.outside = TRUE, legend.outside.size = .4, outer.margins = c(0.2,0,0,0))```

{% include figure.html
  filename="figure11.png"
  caption="Figure 11: Prevalence of Obesity by Census Tracts in Miami, 2018"
 %}

Finally, we may want to export our map file. For instance, we could save the final map in a .png format. First, let’s rerun the previous code but this time saving the map object as the object “Final_Map”:

```Final_Map <- tm_shape(CT_City_Miami_Obesity) + tm_fill("OBESITY_2018", title="Prevalence of Obesity", textNA = "No Data", colorNA = "white", title.size=1, style="fixed", breaks=c(0,20,30,40,50), labels=c("< 20%", "21 to 30%","31 to 40%","41 to 50%"), palette = c("gray80","gray60", "gray47","gray15")) + tm_borders(col="black") + tm_shape(CT_City_Miami_Obesity) + tm_dots("Obesity_Change_2016_2018", textNA = "No Data", colorNA = "white", alpha=.7, breaks=c(-6,-2,0,1), size=.4, shape=22, border.col="black", palette=c("forestgreen","greenyellow","red"), labels=c("<-2%", "-2 to 0%",">0 (increase)"), title="Percent change", title.size=1, style="fixed") + tm_layout(frame=F, main.title = "Prevalence of Obesity by Census Tracts in Miami, 2018", main.title.size = 1, legend.outside = TRUE, legend.outside.size = .4, outer.margins = c(0.2,0,0,0))```

```tmap_save(Final_Map, "final_map.png", width=1920, height=1080)```

The file “final_map.png” is now located within our working directory.

# Concluding thoughts

With this lesson, you have learned how to merge a .csv file with a spatial polygon data frame created from a shapefile, and how to construct 11 different maps based upon the data. If you want to include additional socioeconomic variables, such as income or education, they can be imported from additional sources and joined to the map based upon shared census tract attributes. To analyze additional health indicators, such as diabetes or asthma prevalence, they can be found in the original data sources. We intend this lesson to be a starting point for demonstrating how to begin using open-source geospatial data visualization techniques to help paint better pictures of how populations change over time.

## Endnotes

[^1] American Association of Geographers. "Historical GIS Clearinghouse and Forum." Accessed July 31, 2019. http://www.aag.org/cs/projects_and_programs/historical_gis_clearinghouse/hgis_projects_programs.

[^2] “500 Cities: Census Tract-Level Data (GIS Friendly Format), 2017 Release | Chronic Disease and Health Promotion Data & Indicators.” Accessed July 31, 2019. https://chronicdata.cdc.gov/500-Cities/500-Cities-Census-Tract-level-Data-GIS-Friendly-Fo/kucs-wizg.

[^3] “500 Cities: Local Data for Better Health, 2016 Release | Chronic Disease and Health Promotion Data & Indicators.” Accessed July 31, 2019. https://chronicdata.cdc.gov/500-Cities/500-Cities-Local-Data-for-Better-Health-2016-relea/9z78-nsfp.

[^4] “500 Cities: Local Data for Better Health, 2018 Release | Chronic Disease and Health Promotion Data & Indicators.” Accessed July 31, 2019. https://chronicdata.cdc.gov/500-Cities/500-Cities-Local-Data-for-Better-Health-2018-relea/6vp6-wxuq.

[^5] Brey, Alex. “Temporal Network Analysis with R.” Programming Historian, November 4, 2018. https://programminghistorian.org/en/lessons/temporal-network-analysis-with-r.

[^6] “Colors in R.” Accessed July 31, 2019. http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf.

[^7] ESRI. “ArcGIS 10.7.1and ArcGIS Pro 2.4 Projected Coordinate System Tables.” Accessed July 31, 2019. https://pro.arcgis.com/en/pro-app/arcpy/classes/pdf/projected_coordinate_systems.pdf.

[^8] Francois, Romain, Lionel Henry, and Kirill Muller. “Package ‘Dplyr.’” Accessed July 31, 2019. https://cran.r-project.org/web/packages/dplyr/dplyr.pdf.

[^9] “GDAL — GDAL Documentation.” Accessed July 31, 2019. https://gdal.org/.

[^10] “Index of /Geo/Tiger/GENZ2017/Shp.” Accessed July 31, 2019. https://www2.census.gov/geo/tiger/GENZ2017/shp/.

[^11] “Introduction to Dplyr.” Accessed July 31, 2019. https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html.

[^12] “Measure Definitions | 500 Cities,” April 16, 2019. https://www.cdc.gov/500cities/measure-definitions.htm.

[^13] “Municipal Boundary.” Accessed July 31, 2019. https://gis-mdc.opendata.arcgis.com/datasets/municipal-boundary.

[^14] “Programming with R.” Accessed July 31, 2019. http://swcarpentry.github.io/r-novice-inflammation/.

[^15] “R: The R Project for Statistical Computing.” Accessed July 31, 2019. https://www.r-project.org/.

[^16] “R-Forge: R Interface to GDAL, OGR and PROJ.4: Project Home.” Acessed July 31, 2019. https://r-forge.r-project.org/projects/rgdal/.

[^17] “RStudio.” RStudio. Accessed July 31, 2019. https://www.rstudio.com/.

[^18] “Shapefiles—ArcGIS Online Help | ArcGIS.” Accessed July 31, 2019. https://doc.arcgis.com/en/arcgis-online/reference/shapefiles.htm.

[^19] “SpatialPolygonsDataFrame-Class Function | R Documentation.” Accessed July 31, 2019. https://www.rdocumentation.org/packages/sp/versions/1.3-1/topics/SpatialPolygonsDataFrame-class.

[^20] Tennekes, Martijn. “Package ‘Tmap.’” Accessed July 31, 2019. https://cran.r-project.org/web/packages/tmap/tmap.pdf.

[^21] “Tmap: Get Started!” Accessed July 31, 2019. https://cran.r-project.org/web/packages/tmap/vignettes/tmap-getstarted.html.

[^22] “What Are Map Projections?—Help | ArcGIS for Desktop.” Accessed July 31, 2019. http://desktop.arcgis.com/en/arcmap/10.3/guide-books/map-projections/what-are-map-projections.htm.
