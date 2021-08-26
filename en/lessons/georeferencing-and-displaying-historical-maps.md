---
title: Georeferencing and Displaying Historical Maps using Map Warper and StoryMap JS
collection: lessons
layout: lesson
slug: georeferencing-and-displaying-historical-maps
date: 2021-09-26
translation_date: [LEAVE BLANK]
authors:
- Erica Y. Hayes
- Mia Partlow
reviewers:
- [LEAVE BLANK]
editors:
- Alex Wermer-olan
translator:
- [FORENAME SURNAME 1]
translation-editor:
- [LEAVE BLANK]
translation-reviewer:
- [LEAVE BLANK]
original: [LEAVE BLANK]
review-ticket: [LEAVE BLANK]
difficulty: [LEAVE BLANK]
activity: [LEAVE BLANK]
topics: [LEAVE BLANK]
abstract: [LEAVE BLANK]
---

# Table of Contents

{% include toc.html %}

---

# Lesson Goals

Georeferencing is the process of assigning geographic coordinates to a scanned map or raster image. Many historians are now [georeferencing](https://en.wikipedia.org/wiki/Georeferencing) historical maps in order to study how places have changed over time. In this lesson, we will take you through the steps to align geographic coordinates to a scanned historical map and show you how to share your georeferenced map online using an interactive web-based mapping platform, StoryMap JS. While you may have already encountered the *Programming Historian* tutorial on [Georeferencing in QGIS 2.0](https://programminghistorian.org/en/lessons/georeferencing-qgis), we wanted to provide you with some examples of other entry-level georeferencing tools.

Before you begin georeferencing a scanned map, it is important to understand the locations depicted on the map, as well as the context of the creation of the historic map itself. Not all historic maps are good candidates for georeferencing. There must be enough information on the map to allow you to confidently assign latitude and longitude coordinates to it or align it with a GIS map using physical features. Often, you will need to research the location of historic places and features that no longer exist, and make an informed decision in order to identify its proper placement. Some maps may not have enough geographic information, and may become so warped when georeferenced that they are illegible or inaccurate.

{% include figure.html filename="mapwarper_warped.png" caption="A map too warped to be use effectively" %}

The [scale](https://en.wikipedia.org/wiki/Scale_(map)), resolution, and [projection](https://en.wikipedia.org/wiki/Map_projection) of a scanned map are also important considerations when choosing a historic map to georeference. Small scale maps are generally not well suited for highly detailed georeferencing and may cause problems with representing exact feature locations. When selecting or scanning a historic map for georeferencing, it is better to use a map that has been scanned at a high resolution (300 dpi or greater), so you can easily see the features on the map when zooming in and out. It is also best practice to use the same projection as the historic map in order to minimize distortion. Georeferencing a map in the wrong projection can create a mismatch between your historical and current maps, stretching the lines, shapes, and the distance between objects. Map Warper, the tool used in this tutorial, does not provide an option to re-project your map data; if you are unable to achieve a legible map, or if you are measuring distance, you may need to use a more advanced GIS software, such as QGIS which will allow you to specify the map projections. For more details on best practices for georeferencing, see [Esri’s list of recommendations](https://www.esri.com/esri-news/arcuser/spring-2014/~/media/Files/Pdfs/news/arcuser/0314/seven-best-practices.pdf).

In this tutorial, you will work with Map Warper and StoryMap JS to create a georeferenced historical map and overlay it on top of a modern basemap to be published and interacted with on the web. Developed by Tim Waters, [Map Warper](https://mapwarper.net/) is an open-source georeferencing service, written in Ruby on Rails; the application lets users upload scanned maps and georeference them against OpenStreetMap. [StoryMap JS](https://storymap.knightlab.com/) is an open-source tool from [Knight Lab](https://knightlab.northwestern.edu/?_ga=2.52850091.2022676985.1594049312-983442711.1568909419) at Northwestern University, which allows you to integrate historical and contemporary maps into interactive stories.  

# Getting Started: Georeferencing your map with Map Warper
*You will start by uploading a map and georeferencing it using the open source online tool Map Warper. Map Warper has a variety of export options, including [WMS](https://en.wikipedia.org/wiki/Web_Map_Service) URL, [Tiles](https://en.wikipedia.org/wiki/Tiled_web_map), and a [GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) or [KML](https://en.wikipedia.org/wiki/Keyhole_Markup_Language) file. For the purposes of this tutorial we will export the georeferenced map as a Tile layer and load it into StoryMap JS.*

## Step 1: Set up Map Warper and upload your map

1. For this tutorial, we will use an [1860 map of North Carolina and South Carolina](https://bit.ly/3464cFd) from the David Rumsey Map Collection.[^1] Export and download the Extra-Extra Large version.

    *Note: Every filename in Map Warper must be unique, so you will need to give the image a new file name once you have downloaded the map to your computer, such as NC_SC_Map_yourlastname.jpg.*

2. Go to [https://mapwarper.net](https://mapwarper.net) and create an account.

3. On the Home page, click the green button labeled Upload Map to import your scanned map to Map Warper.

4. The next screen is asking for descriptive information that will make the map easier to find (also known as [metadata](https://en.wikipedia.org/wiki/Metadata)). While only the Title field is required, it is generally best practice to provide as much information as possible, so other users can learn more about the source of your scanned map you are georeferencing. Fill in the metadata based on the information provided to you about the historical map that you’re working with. For the North Carolina and South Carolina map, you can find the map’s metadata beside the map on the [David Rumsey Map Collection's website](https://bit.ly/3464cFd).

5. Towards the bottom of the screen, click on the Choose File button under “Upload an image file.” Navigate to the NC_SC.jpg map that you downloaded to your computer and click Create.

## Step 2: Explore the Map Warper interface

You now have your map loaded into Map Warper. The interface is organized into the following tabs:

  * Show: displays only your map image
  * Edit: allows you to edit the descriptive text (metadata)
  * Rectify: used for the georeferencing itself
  * Align: a useful tool if you are stitching together multiple maps
  * Preview: shows your map on top of a modern basemap
  * Export: gives you a variety of export options and formats


{% include figure.html filename="mapwarper_showmap.png" caption="Map Warper interface" %}

## Step 3: Georeference your map

1. Click on the Rectify tab

2. Take a moment to move the map on the right to the North Carolina and South Carolina region. The arrows at the top of the screen move the map slightly to the North, South, East, and West and are useful when you need to make small adjustments to the map. You can zoom in and out with the slider or with your trackpad/mouse. To move around a map, click the hand icon.

3. Once you feel comfortable moving around in the maps, select your first control point. Start from the historic map and choose a location--for example, a city--that will be relatively easy to find.


4. Then, click the green control point marker on the modern map and find the same location to match them up.

{% include figure.html filename="mapwarper_controlpointsadded.png" caption="Match up your control points" %}

5. If you do not click the Add Control Point button, the next time you click on a map, the control point you added will move. This functionality gives you the flexibility to adjust your points while adding them, but can be confusing if you don’t realize that your point has moved because you didn’t click Add Control Point.

6. You need at least 4 or 5 points. Spread them out across your historic map--focusing on state borders, rivers, county lines, and major cities is a good strategy. If you need to delete a control point, click on “Control Points” in the Control Panel below the map.

{% include figure.html filename="mapwarper_controlpoints.png" caption="Select Control Points in the Control panel" %}

7. Selecting Control Points will display all of the points you have added, and enable you to delete any points that you want to re-do. You also have the option of changing the latitude and longitude manually.

{% include figure.html filename="mapwarper_controlpoints_rmserrordelete.png" caption="Deleting control points and the RMS error" %}

*Note: You will see there is an  Error value for each control point. Map Warper uses the [Root Mean Square error calculation (RMS)](https://en.wikipedia.org/wiki/Root-mean-square_deviation) to evaluate the transformation of the different control points. The RMS error provides a rough guide to how consistent your control points are to one another with reference to the map's transformation and it assesses how distorted your map will be. High RMS error values indicate that your control points are less consistent with one another in comparison to a low RMS error value. It is generally recommended that you keep your error values low and replace or remove control points with high values. While the RMS error provides a good way to assess the transformation's accuracy, you should always reevaluate how well your scanned map matches up to the GIS modern map. For more information about the RMS error, please see Esri's section on interpreting the root mean square error in their [Overview of georeferencing](https://pro.arcgis.com/en/pro-app/help/data/imagery/overview-of-georeferencing.htm#ESRI_SECTION1_61F70AE3AC6C47559B3C03C74F093505)*

8. When you have enough points and think they are distributed well across your historic map, click Warp Image! at the bottom of the page. Georeferencing maps takes practice. You may find that your rectified map creates an unreadable warped map. We encourage you to try steps 7-9 again, taking into account best practices for georeferencing mentioned above, such as identifying major cities, roads, streams, and rivers that you can identify with confidence.

{% include figure.html filename="mapwarper_warpbutton.png" caption="Click Warp Image! to rectify your map" %}

9. You will now see the map layered on top of the OpenStreetMap.

{% include figure.html filename="mapwarper_openstreetmap.png" caption="Georeferenced map in OpenStreetMap" %}

10. You can choose to view a satellite image basemap or the regular OpenStreetMap layer we’ve been using.

{% include figure.html filename="mapwarper_satellite.png" caption="Georeferenced map in satellite view" %}

11. Click the Preview tab for a larger view of the georeferenced map. Changing the transparency using the slider can give you a sense of how accurate your georeferencing has been applied.

{% include figure.html filename="mapwarper_preview.png" caption="Map Warper Preview" %}

## Step 4: Export your map

1. We are now ready to export our map.  Click the Export tab

2. Under Map Services, copy and paste the Tiles URL and save it to be used later in StoryMap JS. See the example URL below:

https://mapwarper.net/maps/tile/40217/{z}/{x}/{y}.png

# Displaying your georeferenced map in KnightLab’s StoryMap JS

*We will now move on to loading our georeferenced map into KnightLab’s Story Map JS.*

## Step 1: Accessing StoryMap JS

1. Go to [StoryMap JS](https://storymap.knightlab.com/) and select “Make a Map.”

{% include figure.html filename="StoryMapJS_MakeMap.png" caption="StoryMap JS: Make a StoryMap" %}


2. You will be prompted to login with a google account.  If you don’t have one, you can create one at [gmail.com](http://gmail.com).

{% include figure.html filename="StoryMapJS_GoogleSignin.png" caption="StoryMap JS: Sign In with Google" %}

3. Type in a title for your story map and click "Create"

{% include figure.html filename="StoryMapJS_Title_Create.png" caption="StoryMap JS: Add a title and click Create." %}

## Step 2: Adding your georeferenced map to Story Map JS

You will see a default black and white basemap in StoryMap JS. You will want to change out this basemap layer with your georeferenced historical map of North Carolina. To change the default basemap layer, select Options in the top left hand corner of the Story Map JS interface.

{% include figure.html filename="StoryMapJS_Default_Options.png" caption="StoryMap JS: Options" %}

In the drop down menu under Map Type, scroll down to “custom” and enter the Tiles URL: https://mapwarper.net/maps/tile/40217/{z}/{x}/{y}.png from your exported map in Map Warper to load in your georeferenced map.

{% include figure.html filename="StoryMapJS_MapType_Custom.png" caption="StoryMap JS: Map Type and custom URL" %}

Upon loading the georeferenced map into StoryMap JS, you will notice that the georeferenced map repeats and is tiny--what you’re seeing is the “tiled” effect of importing a tile layer that covers only a small portion of the globe.

{% include figure.html filename="StoryMapJS_TileLayer.png" caption="Imported tile layer of georeferenced map in StoryMap JS" %}


## Step 3: Add Slides in StoryMap JS

To remove the "tiled" view of your georeferenced map, click the Add Slide button on the left-hand side of your screen.  In the “Search for a location” box, type in North Carolina, United States. It should zoom in to the entire state, and the “tile” effect will go away.  You can zoom in and out to specify how you want the map to look.

{% include figure.html filename="StoryMapJS_NC_ZoomedIn.png" caption="StoryMap JS: Search 'North Carolina, United States'" %}

*Note: It might take StoryMap JS time to load your map. You should add at least four points to your map before previewing it, so the platform has time to adjust to the georeferenced map.*

1. Now add another new slide and enter Raleigh, North Carolina as the location. Type “Raleigh, NC” into the “Headline” box.

{% include figure.html filename="StoryMapJS_Raleigh.png" caption="StoryMap JS: Search 'North Carolina, United States'" %}

2. Do the same for Asheville, North Carolina; Chapel Hill, North Carolina; and Wilmington, North Carolina (each city should go on a separate slide).

{% include figure.html filename="StoryMapJS_Cities_Slides.png" caption="Add new slides for Asheville, NC, Chapel Hill, NC, and Wilmington, NC" %}

As you add points to the map, you can see how well you georeferenced your map and if StoryMap JS is able to find the locations you searched for and how well they are aligned with your georeferenced map.

# Conclusion

You have now completed this lesson. Knowing how to georeference maps means you can bring historic cartography into the present context and allow for new explorations of historic data. We encourage you to think about the classroom applications for georeferencing, as it is a wonderful exercise for increasing student understanding of geographic, cartographic methods, and the role of space and place in historical thinking. In this lesson we have shown you how to publish your georeferenced map with [StoryMap JS](https://storymap.knightlab.com/) but there are several online publication options, including [ArcGIS Online](https://www.arcgis.com/index.html), [MapBox](https://www.mapbox.com/), or more advanced tools such as [Leaflet](https://leafletjs.com/), for making custom web maps, or [QGIS Cloud](https://qgiscloud.com/), for publishing maps from [QGIS](https://www.qgis.org/en/site/) to the web.

# Endnotes

[^1]: Johnson, A.J. Johnson’s North and South Carolina by Johnson & Browning. No 26-27. Map. New York: Johnson and Browning. From David Rumsey Center, Historical Map Collection. [https://www.davidrumsey.com/luna/servlet/detail/RUMSEY~8~1~2505~310017:North-And-SouthCarolina?sort=Pub_List_No_InitialSort,Pub_Date,Pub_List_No,Series_No&qvq=q:1860%20North%20Carolina;sort:Pub_List_No_InitialSort,Pub_Date,Pub_List_No,Series_No;lc:RUMSEY~8~1&mi=7&trs=18](https://www.davidrumsey.com/luna/servlet/detail/RUMSEY~8~1~2505~310017:North-And-SouthCarolina?sort=Pub_List_No_InitialSort,Pub_Date,Pub_List_No,Series_No&qvq=q:1860%20North%20Carolina;sort:Pub_List_No_InitialSort,Pub_Date,Pub_List_No,Series_No;lc:RUMSEY~8~1&mi=7&trs=18) (accessed June 29, 2020).
