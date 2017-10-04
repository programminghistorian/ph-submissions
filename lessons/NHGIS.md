---
title: |
    Extracting History GIS Data from NHGIS
authors:
    - Eric Weinberg
date: 2017-06-30
reviewers:
layout: lesson
---

## Pre-requisites

## Lesson Goals

## Getting Started

## The Data
If you are looking nationally prior to 1990, the county-level data is often your best bet as more precise geographic levels had not been standardized. For some regions and cities, however, there are more precise levels and in some cases smaller than zipcodes. For this tutorial, we will use county level data. In general, it is best to use the smallest geographic region possible, but for historical research that often ends up being at the county level. In general, larger population centers have more detailed historical data, but rural areas were not completely covered until the 1990 census. For a more detailed description of the census regions and an interactive map see [NHGIS's discussion](https://www.nhgis.org/user-resources/data-availability#table-data)
NHGIS has tutorials on how to [select data in their system](https://www.nhgis.org/sites/www.nhgis.org/files/using_the_nhgis_data_finder.pdf) but the essence is that you must select the geographic level and years of interest. When selecting, keep in mind the decennial census years and modern census has more information available so it is most likely best to choose the year of the decennial census closest to your historical subject. You can then choose the data available.

NHGIS provides two data groupings that I put into two separate folders. One is the shapefiles that represents the geographic regions. The other is census characteristics. This data will be merged later, and will helps us understand characteristics of the time period and events that we are trying to better understand. They also provide a [how to document](https://www.nhgis.org/sites/www.nhgis.org/files/using_the_nhgis_data_finder.pdf).
### LOG IN
You must first log in to the system in order to get access. Once logged in, you will be brought to the data finder screen. From here you will see some filters that will help you choose the data you will download.
![Step1.png](../images/geospatial-data-analysis/Step1.png)
### STEP 2
My second step is ussally selecting geographic levels and for historical research at a national level, this is almost always county. To select county, I click GEOGRAPHIC LEVELS and click the plus under "COUNTY."
![Step2.png](../images/geospatial-data-analysis/Step2.png)
### STEP 3
The next step is to select the time period for the data of interest. While representative county shapefiles do not change much over time, the nature of the census and results do. In this example, I am choosing 1980 because it is a decennial year which will give us more data options. NHGIS is linked to other data sources on off years.
![Step3.png](../images/geospatial-data-analysis/Step3.png)
### STEP 4
After these steps, the data finder will list our filters we have selected. We could add additional filters. But I often begin selecting the data from the available tables which are listed below our filters. Below we can see, I have selected a few statistical variables that I think may be helpful for my research which I believe could provide insight into the nature of the events or geographies in which I am interested.
![Step4.png](../images/geospatial-data-analysis/Step4.png)
### STEP 5
We also need to ensure the shapefiles are included. In order to ensure, select the tab with labled GIS BOUNDRY FILES and select a county level boundary file.
![Step5.png](../images/geospatial-data-analysis/Step5.png)
Now Click CONTINUE on the DATA CART box.
![box.png](../images/geospatial-data-analysis/box.png)
### DOWNLOAD
From here we are able to download the files by clicking SUBMIT. It will take a few minutes for the service to compile the data. When it is finished, you will be provided two separate downloads. One will be the shapefile. The other the associated data files. I download these files and put them in a data folder inside the working directory of my R studio project.
![Step 6.png](../images/geospatial-data-analysis/Step6.png)

You will then be able to download two folders which contain the information you selected. One of these folders will contain the shapefiles that define the geographic regions of interest. The other contains extended census statistics for that geographic region based on your selections. This data will be merged later. But for now, I recommend creating a data directory in your working directory and dropping both folders there.
