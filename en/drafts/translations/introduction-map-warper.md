---
title:
   Introduction to Map Warper
date:YYYY-MM-DD
translation_date: 2022-04-4
authors:
- Anthony Picón Rodríguez
- Miguel Cuadros
editor:
- Antonio Rojas Castro
reviewers:
- José Luis Losada
- Riva Quiroga
translators:
- Lorena Gauthereau
- Erica Hayes
- Mia Partlow
translation-editor:
- Alex Wermer-Colan
translation-reviewer:
- TBD
- TBD
layout: lesson
review-ticket: 426
difficulty: 2
original: es/publicadas/originales/introduccion-map-warper.md
activity: mapping
topics: [mapping]
abstract: "This lesson introduces you how to use Map Warper."
avatar_alt:
doi: TBD
---

{% include toc.html %}

# Introduction to Map Warper

# Map Warper Tool
Developed by Tim Waters, [Map Warper](https://mapwarper.net/) is an open-source georeferencing service, written in Ruby on Rails; the application lets users upload scanned maps and georeference them against OpenStreetMap. It allows the georeferencing and visualization of geographic areas without the need to install software. The tool is implemented in various digital projects across the world and used by many professionals who are not necessarily experts in the field of cartography.

Map Warper was designed to georeference historical maps (world maps, portolan charts, nautical charts, topographic charts, architectural blueprints, geographical charts), aerial photographs, and other cartographic materials contained in cultural heritage collections. In this sense, the tool allows the user to generate georeferenced materials for working on desktop rasters or online (Map Server) in order to link to geographic information systems (QGIS, JOSM, ArcGIS, Google Earth, World Map, and others). The tool’s collaborative settings also help to decentralize and streamline georeferencing processes, cataloging and visualization.

Thanks to these characteristics, the tool is useful for researchers, professors, and students, as well as for institutions that are developing digitization, visualization, and cartographic experimentation processes for their collections or for the development of spatial humanities, such as the [New York Public Library](https://digitalcollections.nypl.org/collections/lane/maps-atlases), [Library of Congress](https://www.loc.gov/maps/collections/), [David Rumsey Map Collection](https://www.davidrumsey.com/), and the [British Library](https://www.bl.uk/subjects/maps).[^1]
[^1]: Spanish-language resources include Biblioteca Nacional de Colombia’s Mapoteca Digital, [Cartografía de Bogotá](http://cartografia.bogotaendocumentos.com/) de la Universidad Nacional de Colombia, and [Paisajes coloniales: redibujando los territorios andinos en el siglo XVII](https://paisajescoloniales.com/) de la Universidad de los Andes (Colombia).

# Lesson Goals
Global trends have been profoundly marked by technological development and a marked epistemological shift that focuses on spatiality, which, in turn, has influenced the fields of Social Sciences and Humanities. Technology has expanded research and visualization possibilities, thereby changing the ways we can think about and interpret the past. As a result, MapWarper is both product and producer of these technological relationships that generate and expand new interpretations.

[Georeferencing](https://en.wikipedia.org/wiki/Georeferencing) is the process of assigning geographic coordinates to a scanned map or raster image. Many historians georeference maps to study how places have changed over time. In this lesson, we will take you through the steps to align geographic coordinates to a scanned historical map and show you how to export your georeferenced map.

This lesson was conceived as the first component of a larger module oriented toward the usage of digital tools for georeferencing, vectorization, extraction, organization, and experimentation with geographic data in archival bibliography and cartography digitized by different institutes (archives, libraries, museums).

In this tutorial you will georeference an 1860 map of [North Carolina and South Carolina](https://bit.ly/3464cFd) from the David Rumsey Map Collection.[^2]
[^2]: The original Spanish tutorial uses a 1933 coffee map of the Republic of Colombia from Mapoteca Digital de la Biblioteca Nacional de Colombia, published by the Federación Nacional de Cafeteros de Colombia (National Federation Colombian Coffee Growers). This lesson substitutes the map in order to provide English-speaking users with a map with  geographical locations in English.

Before you begin georeferencing a scanned map, it is important to understand the locations depicted on the map, as well as the historic context of map’s creation. Not all historic maps are good candidates for georeferencing. The map must include enough information to allow the user to confidently assign latitude and longitude coordinates or align it with a GIS map using physical features. Often, you will need to research the location of historic places and features that no longer exist, and make an informed decision to identify its proper placement. Some maps may not have enough geographic information, and may become so warped when georeferenced that they become illegible or inaccurate.

The [scale](https://en.wikipedia.org/wiki/Scale_(map)), resolution, and [projection](https://en.wikipedia.org/wiki/Map_projection) of a scanned map are also important considerations when choosing a historic map to georeference. Small scale maps are generally not well suited for highly detailed georeferencing and may cause problems with representing exact feature locations. When selecting or scanning a historic map for georeferencing, it is best to use a map that has been scanned at a high resolution (300 dpi or greater), so you can easily see the features on the map when zooming in and out. It is also best practice to use the same projection as the historic map in order to minimize distortion. Georeferencing a map in the wrong projection can create a mismatch between the historical and current maps, stretching the lines, shapes, and the distance between objects. Map Warper, the tool used in this tutorial, does not provide an option to re-project your map data; if you are unable to achieve a legible map, or if you are measuring distance, you may need to use a more advanced GIS software, such as QGIS which will allow you to specify the map projections. For more details on best practices for georeferencing, see [Esri’s list of recommendations](https://www.esri.com/esri-news/arcuser/spring-2014/~/media/Files/Pdfs/news/arcuser/0314/seven-best-practices.pdf).

Some guiding questions to ask are:
-What location is represented in the historical map/cartographic image?
-What were some of the changes that have taken place since it was created?
-Do you recognize any current geographical reference points?
-What is the correct orientation of the image?

In this tutorial, you will work with Map Warper to create a georeferenced historical map and overlay it on top of a modern basemap in order to publish and interact with it on the web.

This tutorial complements other Programming Historian lessons that reference the use of Geographic Information Systems (GIS) for spatial analysis: [Georeferencing in QGIS 2.0](https://programminghistorian.org/en/lessons/georeferencing-qgis) and [Intro to Google Maps and Google Earth](https://programminghistorian.org/en/lessons/googlemaps-googleearth). In addition to learning the necessary technical steps for georeferencing antique maps, this lesson will serve as an introduction to the study of cultural heritage cartography and their potential in historical research.

# Getting Started
## Create an Account
Using your favorite browser, navigate to [https://mapwarper.net](https://mapwarper.net) and click on the “Create Account” tab in the upper right hand corner of the window. Type in the corresponding information in the form. You can choose to log in using your Facebook, OpenstreetMap or GitHub account to facilitate the registration process.

![Map Warper sign up form](https://i.imgur.com/MXAKDDx.gif "Map Warper sign up form gif")

## Upload Map
On the Home page, click the green button labeled “Upload Map” to import your scanned map to Map Warper directly from your local file or linked from an online repository via a corresponding URL. During this step you can also start adding metadata to the material you will georeference.

Toward the bottom of the screen, click on the Choose File button under “Upload an image file.” Navigate to the NC_SC.jpg map that you downloaded to your computer and click Create.

*Note: Every filename in Map Warper must be unique, so you will need to give the image a new file name once you have downloaded the map to your computer, such as NC_SC_Map_yourlastname.jpg.*

## Edit
The next screen asks for descriptive information that will make the map easier to find (also known as [metadata](https://en.wikipedia.org/wiki/Metadata)). The metadata field is also accessible via the Metadata tab. While only the Title field is required, it is generally best practice to provide as much information as possible, so other users can learn more about the source of your scanned map you are georeferencing. Fill in the metadata based on the information provided to you about the historical map that you’re working with. For the North Carolina and South Carolina map, you can find the map’s metadata beside the map on the [David Rumsey Map Collection’s website](https://bit.ly/3464cFd). Due to the collaborative and collective nature of Map Warper, we recommend that you include the following metadata:
-Title: Title and registration number. This organizes the information to make it easier to find the map in its original repository.
-Description: Reference for the cartographic image.
-Issue Year: Year in which the map was created or published.
-Tags: 3-5 keywords that describe the map.
-Subject Area: Typology for the cartographic material.
-Source: URL for the document visualization.
-Place of publication: Location that the document was published or created.
-Scale: Numerical scale.
-Metadata Projection: Cartographic projection.

# Georeferencing your map with Map Warper

*You will start by uploading a map and georeferencing it using Map Warper. Map Warper has a variety of export options, including [WMS](https://en.wikipedia.org/wiki/Web_Map_Service) URL, [Tiles](https://en.wikipedia.org/wiki/Tiled_web_map), [GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) or [KML](https://en.wikipedia.org/wiki/Keyhole_Markup_Language) file. If you would like to display your georeferenced map online, see the Programming Historian tutorial "Displaying a Georeferenced Maps in Story Map JS."*

## Map Visualization
This tab will display the visualization of the attached georeferenced map or cartographic document. The navigation tools include the option to zoom in and move.

Users will find it helpful to identify the types of points to georeference (urban and natural locations, jurisdictions, roads, etc.) as well as the different resources that can be used to cross reference and to supplement the information provided (statistics, governmental reports, personal documents, or even cartographic images created before or after the one used for this visualization). These considerations are very useful for research development, since the digital visualization should help to facilitate the critical interpretation of the material. This is especially evident in the use of maps that contain cultural heritage information (for example, trade routes, shifting borders, natural resources, etc.).

The interface is organized into the following tabs:
-Show: displays only your map image
-Edit: allows you to edit the descriptive text (metadata)
-Rectify: used for the georeferencing itself
-Align: a useful tool if you are stitching together multiple maps
-Preview: shows your map on top of a modern basemap
-Export: gives you a variety of export options and formats

## Georeference your map
In this section, you will georeference the uploaded map. Click on the “Rectify” tab; here you will find two windows: on the left is the uploaded map; on the right is the OpenStreetMap base map (this is the layer that provides the reference points for your upload map image). Below these windows, you will find the “Control Panel,” which allows you to fine-tune your control points, and see their level of accuracy.

![Layer icon](https://mapwarper.net/assets/openlayers/theme/dark/layer_switcher_maximize.png): *Layer* allows you to select a base layer from either OpenStreetMap or Mapbox Satellite. It also includes the *Overlay* function that allows you to superimpose your working map image (the North Carolina and South Carolina example or your own image) after confirming the georeference.

![basemap icon](https://programminghistorian.org/images/introduccion-map-warper/add%20custom%20base%20map.png): *Add Custom Basemap* in the right box allows you to add another custom base layer in XYZ Tiles format (such as OpenStreetMap, Google Maps, Bing, CARTO, ESRI, Stamen, and other layers). You can also add the following georeferenced maps from Map Warper:
Google Maps: https://mt1.google.com/vt/lyrs=r&x={x}&y={y}&z={z}
Google Satellite: http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}
Bing Satellite: http://ecn.t3.tiles.virtualearth.net/tiles/a{q}.jpeg?g=0&dir=dir_n’
CARTO dark: http://a.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png
Stamen Watercolor: http://tile.stamen.com/watercolor/{z}/{x}/{y}.jpg

![Control point icon](https://programminghistorian.org/images/introduccion-map-warper/add%20control%20point.gif)*Add control point*, available in both boxes, allows you to add control points that associate points on the uploaded or selected map to the predetermined base layer.

![Move control point icon](https://programminghistorian.org/images/introduccion-map-warper/move%20control%20point.gif)*Move Control Point* permits you to move or relocate the control points and add them to both windows.

![Move around map icon](https://i.imgur.com/qltUq7S.gif)*Move Around Map* lets you explore the maps in both windows without having to assign or move any control points. This is helpful in verifying the assigned control points.

The lock between the two windows helps guide the assignment and movement of the control points. The ![Zoom lock icon](https://programminghistorian.org/images/introduccion-map-warper/Candado_cerrado.png)*Zoom lock*  option allows you to zoom in on the maps in both windows simultaneously. This is useful to place and verify the control points. Clicking on the lock again will unlock it. The ![Pan icon](https://programminghistorian.org/images/introduccion-map-warper/lock_open.png)*Pan* function allows you to pan to different sections of the images, separately.

*Keyboard shortcuts* provides quick access to the following:
-*p*: Keyboard activates *Add Control Point* ![Add control point icon](https://programminghistorian.org/images/introduccion-map-warper/add%20control%20point.gif)
-*d*: Keyboard activates  *Move Control Point* ![Move control point icon](https://programminghistorian.org/images/introduccion-map-warper/move%20control%20point.gif)
-*m*: Keyboard activates  *Move Around Map* ![Move around map icon](https://i.imgur.com/qltUq7S.gif)
-*q*: Keyboard adds a control point in your cursor location.
-*a*: Keyboard adds a control point in your cursor location in both windows.
-*Enter*: Keyboard replaces the mouse click *Add Control Point* to confirm the position of the pin.

Clicking on *Control Points* in the Control Panel displays a table with the location values (X, Y coordinates and latitude, longitude) for the control points that you have assigned. You can delete points here or edit latitude and longitude.

This table also includes a section that defines the geometric error value, caused by the georeferencing the historic map document. This calculates the error value of each point according to a weighted average, and classifies the error in blue (low error), yellow (some error), or red (significant error). (See the note about the way the RMS error is calculated, below.)

Download points as CSV, displayed below the table allows you to download the table as a Comma Separated Values (CSV) file. This file is useful for importing this data into other applications that read this type of information. This file can also be a form of digital preservation for processing the archival map’s georeferenced data.

By clicking on *Add Control Point Manually* you can add a control point with X, Y coordinates and on the original image to the base map layer with longitude and latitude. If you know the geographic coordinates, this can facilitate aligning control points on the base layer with higher accuracy.

*Add Control Points from CSV* allows you to upload a <mark>.csv</mark> (Comma separated values) file to automate the georeferencing process. The first row of the <mark>.csv</mark> file must contain the Control Points table headers. The proceeding rows should contain data for the X, Y coordinates for the image (X,Y) and the destination (Lon,Lat), separated by commas.

The following <mark>.csv</mark> example contains four columns, labeled as ‘x’, ‘y’, ‘lon’ y ‘lat’ and four rows, including the headings. This is the same file as the one downloaded using the ![csv icon](https://mapwarper.net/assets/csv-20x25-6bb4f7d2df14b1f8031eac9c98523bdf.png) button.

x,y,lon,lat
3765.7477558347,1290.9407540395,-81.6339111296,36.5890683701
6424.7889362654,3307.9939407561,-77.8738403289,34.2299708101
7824.94456912,1323.6674147237,-75.9979248017,36.5184659884

1. Click on the Rectify tab.
2. Take a moment to move the map on the right to the North Carolina and South Carolina region. The arrows at the top of the screen move the map slightly to the North, South, East, and West and are useful when you need to make small adjustments to the map. You can zoom in and out with the slider or with your trackpad/mouse. To move around a map, click the hand icon.
3. Once you feel comfortable moving around in the maps, select your first control point. Start from the historic map and choose a location–for example, a city–that will be relatively easy to find.
4. Then, click the green control point marker on the modern map and find the same location to match them up.
5. If you do not click the Add Control Point button, the next time you click on a map, the control point you added will move. This functionality gives you the flexibility to adjust your points while adding them, but can be confusing if you don’t realize that your point has moved because you didn’t click Add Control Point.
6. Add at least 4 or 5 points. Spread them out across your historic map–focusing on state borders, rivers, county lines, and major cities is a good strategy. If you need to delete a control point, click on “Control Points” in the Control Panel below the map.
7. Selecting Control Points will display all of the points you have added, and allow you to delete any points that you want to re-do. You can also change latitude and longitude points manually.

*Note: You will see there is an Error value for each control point. Map Warper uses the [Root Mean Square error calculation (RMS)](https://en.wikipedia.org/wiki/Root-mean-square_deviation) to evaluate the transformation of the different control points. The RMS error provides a rough guide to how consistent your control points are to one another with reference to the map’s transformation and it assesses how distorted your map will be. High RMS error values indicate that your control points are less consistent with one another in comparison to a low RMS error value. It is generally recommended that you keep your error values low and replace or remove control points with high values. While the RMS error provides a good way to assess the transformation’s accuracy, you should always reevaluate how well your scanned map matches up to the GIS modern map. For more information about the RMS error, please see Esri’s section on interpreting the root mean square error in their [Overview of georeferencing](https://pro.arcgis.com/en/pro-app/help/data/imagery/overview-of-georeferencing.htm#ESRI_SECTION1_61F70AE3AC6C47559B3C03C74F093505).*

8. When you have enough points and think they are distributed well across your historic map, click Warp Image! at the bottom of the page. Georeferencing maps takes practice. You may find that your rectified map creates an unreadable warped map. We encourage you to try steps 7-9 again, taking into account best practices for georeferencing mentioned above, such as identifying major cities, roads, streams, and rivers that you can identify with confidence.
9. You will now see the map layered on top of the OpenStreetMap.
10. You can choose to view a satellite image basemap or the regular OpenStreetMap layer we’ve been using.
11. Click the Preview tab for a larger view of the georeferenced map. Changing the transparency using the slider can give you a sense of how accurate your georeferencing has been applied.

##Cropping
The *Crop* tab allows you to crop a section of the uploaded map. This is useful for dividing maps into composites. The visualization window integrates the following actions:  
![Move around map icon](https://i.imgur.com/qltUq7S.gif): *Move around Map*
![Polygon icon](https://i.imgur.com/AcjK6gG.gif): *Draw new polygon to mask*
![Delete a polygon icon](https://i.imgur.com/gcXUDga.gif)*Delete a polygon*

Draw around the area you wish you keep. Then to apply the mask to the map, click “Mask Map!”

## Align
The *Align* tab allows you to organize several maps into a mosaic. This tool is good for connecting fragmented maps, aerial photographs, and other fragmented cartographic documents. Click “align map” to align the images.
![Align image](https://i.imgur.com/qd3j7pw.gif)

## Previsualization
This tab allows you to visualize the results of your work in the *Rectify* step. This is useful to continue the georeferencing step.  The visualization window also integrates the same tools: move, zoom, transparency, and *layer* ![Layer icon](https://mapwarper.net/assets/openlayers/theme/dark/layer_switcher_maximize.png).

# Visualization
## Step 4: Export your map

*Note: The current version of Map Warper no longer includes the following formats for export: Tiles, Bibliographic Links, Bibliographic.*

The *Export* tab allows you to export the georeferenced map in different standard formats for Geographic Information System (GIS) visualization platforms. The exportable formats are grouped into three categories:
* Images: GeoTiff, rectified PNG. These formats aggregate geographic coordinates and a projection system onto the cartographic document, allowing the georeferenced document to be linked to a GIS application.  This format is recommended for working on computers without a stable Internet connection or no connection.
*Map Services: KML, WMS, Tiles. These geographic formats are similar to those of Images, but they can only be used on computers with an Internet connection.
*Ground Control Points: CSV. This category allows the downloading of the Control Points table created in the “Rectify” step. The table groups the control points between the raster image (historic map document) with the OpenStreetMap vectoral map. That is, it associates the X, Y coordinates with longitude, latitude, respectively.

The georeferenced image can have different functions/act differently due to the projection, the coordinate system, the elipsoide, and the datum used by the corresponding GIS platform.

12. You are now ready to export your map. Click the Export tab
13. Under Map Services, copy and paste the Tiles URL and save it to be used later in StoryMap JS. See the example URL below:
[https://mapwarper.net/maps/tile/40217/{z}/{x}/{y}.png](https://mapwarper.net/maps/tile/40217/{z}/{x}/{y}.png)

## Activity
The *Activity* tab maintains a summary of changes made to the map. The activity log includes the following fields: Time, User, Map, Activity summary, Version, and Further details. All users can monitor the change to the map. Additionally,  ![RSS feed icon](https://mapwarper.net/assets/feed-icon-14x14-c61922c8668fd4f58ea3660692ba7854.png)“RSS Feed” allows the user to download general information about all changes in <mark>.rss</mark> format.

*The georeferenced image can respond differently based on the projection, the coordinates, elipsoid, and datum used in the corresponding Geographic Information System.*

## Comments
The *Comments* tab allows users to aggregate comments about the map. This is an open channel that allows others to communicate with the user who shared the cartographic material. It is also a useful place to enrich the description and cataloging of the uploaded map. Make sure to click *add comment* to save.

# Final considerations
The technical steps learned in this lesson are useful not only for georeferencing historical maps, but also for reflecting on the distinct spatial relations between place, history, and subjects. It is also useful for connecting the digital map to data from other primary sources (official documents, statistics, photographs, testimonies, etc.). In this sense, the lesson is an introduction to the possibilities of the use of this type of material, the historical perspectives of the social dimensions that are also represented in the georeferenced object, and that will continue to stimulate the field of Spatial Humanities.

***
###About the authors
Anthony Picón Rodríguez is a researcher at the Laboratorio Digital de Arquitectura y Urbanismo at Universidad Nacional de Colombia, librarian at the Mapoteca Digital at Colombia's Biblioteca Nacional and a director at Razón Cartográfica.

Miguel Cuadros is a historian who studied at Universidad Industrial de de Santander and received his Master of Arts in History at the State University of New York. He teaches courses at the Universidad Industrial de Santander. His teaching and research experience include topics related to cartography and geography.
