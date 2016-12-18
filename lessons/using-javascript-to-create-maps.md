---
title: |
    Using JavaScript to create maps of correspondence
authors:
- Stephanie J. Richmond
- Tommy Tavenner
date: 2016-09-30
reviewers:
layout: default
---
# Using JavaScript to create maps of correspondence
## Introduction

The mapping software this lesson demonstrates grew out of a need to create a program that was easy to use and designed for the smaller and less uniform geospatial datasets used by historians. While working on a book manuscript on female abolitionists and early feminism in Britain and the United States, the question arose of how to determine the extent of transnational connections in women's antislavery work. We were interested not only in the number of letters that crossed the Atlantic, but also the specific locations the letters were sent from and to and how those international connections changed over time. To solve this problem, we decided to plot the correspondence of Boston-area abolitionist women on a map and do network analysis of women's correspondence, starting with a single woman's letters as a test project. When we set out to map nineteenth-century abolitionist Maria Weston Chapman's correspondence, there was already an easy way to do [network analysis](http://wcm1.web.rice.edu/mining-bpl-antislavery.html), but we struggled to find software to do the mapping portion of the project.[^1] To remedy this, we wrote a simple JavaScript mapping tool based on [Leaflet](http://leafletjs.com/) which allowed us to display correspondence networks on a browser-based map. This lesson explains not only how to write your own script (or adapt the one we wrote) for your own project, but also explores why creating your own tools is sometimes more effective than using commercially available software to analyze historical data.

Originally, when we set out to study Chapman's correspondence with digital tools, we intended to use [PostGIS](http://postgis.net/) and [Gephi](https://gephi.org/) to examine the geographic connections and to analyze the network itself. While cleaning the data, it quickly became clear that [PostGIS](http://postgis.net/) was not going to be the ideal tool for the geospatial analysis as it required re-loading all the data into the software every time a change was made. Chapman's correspondence data, obtained from the [Boston Public Library's Antislavery Collection available from the Internet Archive](https://archive.org/details/bplscas) and the [Digital Public Library of America (DPLA)](http://dp.la), required extensive cleaning to standardize and complete dates, names and locations. Many of the mistakes, misspellings and incorrect data points only became noticeable after the data was run through the software and a map generated, so having to reload all of the data from scratch was not a sustainable option. While cleaning the data, we began drafting the code for the JavaScript map, which allowed us to easily run the visualization on our local system using a local web server to catch problems and errors as we worked. The script we ended up writing also allows the map to be interactive, making it a more useful tool for research and discovery than a static visualization. Being able to easily update the map was also important as the Boston Public Library is not finished digitizing their antislavery collection and we hoped to expand the dataset to include the correspondence of other abolitionists if our test was successful. Creating our own tool allowed us the flexibility to adapt our project to the constraints of the data.

### Lesson Goals
* Propose a rationale for using simple code to make an interactive map.
* Explain the process of parsing, cleaning and formatting data for maps.
* Explore the analytical possibilities of mapping correspondence.

Note: This lesson requires using the command line (or Command Prompt), if you have never used a command line interface before, you might want to read [this getting started guide](http://dosprompt.info/) for the basics. You can use the built-in command line tool in your operating system for all of the tasks in this lesson.

### What is JavaScript?
JavaScript is a simple but versatile programming language that runs on every operating system and all Internet browsers. JavaScript programs can be run locally using a local web server or online using your browser, which makes is easy to test your data and script before making your project publicly available.  JavaScript is not the same as Java although they can be used for the same purpose. JavaScript is an open-source, object-oriented programming language, while Java is a proprietary object-oriented programming language owned by Sun Microsystems. Unlike Java, JavaScript does not require installing browser add-ons or special software, it runs in all Internet browsers.

### Why use JavaScript?
JavaScript is a very flexible programming language and it is also quite easy to learn, especially if you already know some HTML or CSS. JavaScript, along with CSS and HTML, is the language behind most simple functions on modern websites. JavaScript is set off from the HTML and CSS on a website by the script tag. If you want to learn basic JavaScript, there are many free tutorials available. [W3Schools.com](http://www.w3schools.com/js/default.asp) has a simple tutorial that may be helpful to go through if you choose to modify or write your own script. This tutorial will give you the information you need to revise the script we wrote to accommodate your data.

## Set Up
Before you begin, download the files from our [repository on Github.](https://github.com/ttavenner/correspondence-map) Do not change the folder structure when saving the files to your computer.

### Project Structure
The parser folder contains the script that downloads data from the DPLA. All the other files are part of the map. The `css` folder contains the code that explains how parts of the map look. The `js` folder contains the actual code that drives the map. The `jquery` and `leaflet` folders in each of these locations are third party tools that add functionality to the map. [Leaflet](http://leafletjs.com/) helps create the map and [jQuery](http://jqueryui.com/) makes it easy to add interactive elements like the time line. The other files are as follows:

* `controls.js` contains functions that handle the time line slider and filters.
* `data.js` contains functions that load and handle the initial formatting of the CSV file.
* `map.js` contains all the code which loads and displays the map layers, including filtering the layers in response to the controls.
* `sidebar.js` contains the code which displays detailed letter information in the sidebar when a line or point is clicked.

## Collecting Data
In order to do geospatial analysis on correspondence, you need several pieces of data about each letter. At the bare minimum, you need the sender, the recipient, the date, the sender's address, and the recipient's address. However, historians often have a lot more information about each piece of correspondence, including summaries of the content, key words, links to the letter in an online repository. Writing your own script allows you to display or access the other information about the letter within the interactive visualization as well as be able to display subsets of the data to help with your analysis. There are several ways to collect or compile data about correspondence. Many historians often have large databases listing correspondence details from their research or have entered research data into Endnote or [Zotero](http://zotero.org), and archival finding aids and digitized archival collections often contain much of the information needed for doing a geospatial analysis. This step of the lesson will explain how to extract the necessary data from digitized archival collections or finding aids available via an API.[^2]

Several APIs contain the metadata for the Boston Public Library's antislavery collection, including the Internet Archive and Digital Public Library of America. We chose to use the Digital Public Library of America's API because the DPLA uses a standardized format for the MARC data, while the data from the Internet Archive more closely mirrors the data on the original index cards created in the 1880s when the collection was compiled and indexed.[^3] As you are selecting your own data source, it is important to look at how the data is structured within the API and think about how that will affect the amount of data cleaning and hand-compiling you will be required to do to get enough data to generate a map of the correspondence set. The more detailed the address information in the raw metadata is, the less work you will have to do to get accurate and complete maps of the correspondence. Even with the standardized data from the DPLA, this project required extensive hand-compiling and cleaning before mapping could begin.

### Parsing Data
In order to get the metadata, you will need to access an API and then parse the returned data to extract the fields you want. Most APIs will provide far more metadata on each item than you really need. While you could store every piece of information about each letter contained in the API, that would result in a data file that is unwieldy at best and a source of performance problems at worst. There are any number of ways to work with an API, but, in general, the most flexible is through a programming language. The two most popular, and arguably easiest to learn programming languages for working with data are Python and JavaScript. We wrote our parsing script in JavaScript just for the simplicity of using the same language for both pieces of our project. Any language capable of accessing a web page is adequate for the purpose. Regardless of how you access the API, in most cases you will need an API key, which is a unique identifier that allows you to download data from an API. If required these will be provided by the same organization that provides the API and will be mentioned in their documentation.

#### Getting an API Key
 The directions for requesting an key from the DPLA can be found [here.](https://dp.la/info/developers/codex/policies/#get-a-key)  If you are using a PC, you will need to install [cURL,](https://curl.haxx.se/download.html) if you are a Mac or Linux user, cURL comes pre-installed and you can skip over the rest of this paragraph.  For PC users, use the Download Wizard to select the right package and download it, extract the files in the folder and move curl.exe into your "Program Files" folder (usually on the C:\ drive). Once the executable file is in the Program Files folder, right click on the "This PC" icon in Windows Explorer, click on "Advanced System Settings", go to the Advanced tab and open the Environment Variables. Go to System Variables and highlight "Path" and click the edit button. At the end of the existing path, type a semicolon and then the location of the curl.exe file (ie. ;C:\Program Files\curl) and then click apply and/or okay to close out all of the properties windows.

Open a command line and type the following text, replacing the sample email with your own email address:

```
curl -v -XPOST http://api.dp.la/v2/api_key/YOUR_EMAIL@example.com
```

The command line will post a response and the DPLA will then email your API key to you. Once you recieve it, you can continue.

#### Configure the Parser
The API key for the parsing script is stored in a separate configuration file named `config.json`. To create this file, copy and paste the code below into a text document (use Notepad or another plain text editor). Replace the text with your own key. Then save this file in the `parser` folder as `config.json`.

```
{
  "api_key": "fill in your key here"
}
```

As mentioned, the reason for writing a parsing script is to transform the raw metadata into something more specifically tailored to your purposes. After testing a few ideas, we decided to store the information in CSV (comma separated value) format. This format is both easily read by a computer program and easy to edit by hand. This allowed us to continue manipulating the data without having to re-format it for our map to read it. We could edit the file, save it, and the changes it would be immediately reflected on the map.

In the case of the DPLA, data is returned in [JSON](http://www.json.org/) format. This is common but not universal among APIs. The other common format you might see is a variety of XML. The differences between these formats is important, but beyond the scope of this lesson. The main goal of the parsing script is to request data, loop through each item in the returned list, pull out the desired fields, and then write those fields out to a file. In the case of the DPLA, the API also limits the number of records you can return with a given request (500 in this case). Given that we had over 1,000 letters, the script also needed to handle the job of "paging." This means that after processing one batch of 500 letters it would then request the next 500 and so on, until no more data was available. If you are using this script to parse data from another source you will need to adjust the code below in the `get-data.js` file in the `parser` folder to match the API parameters.

```
17 var baseUrl = 'http://api.dp.la/v2/items?'
18 var queryString = {
19   api_key: config.api_key,
20   sourceResource: {
21     subject: {
22       name: 'Maria Chapman'
23     }
24   },
25   page_size: 500,
26   page: 1
27 }
```

The `baseUrl` in the code above is the starting place for the API. No matter what data we request, it will start by visiting this URL. Each item in the `queryString` variable above is a parameter that will be passed to the DPLA API. The script translates the variable into the proper format before submitting it. If you want to use the DPLA API with different parameters this is where you would change them. For example, to search for a different person you would change the `name` field from 'Maria Chapman' to the name of your subject. For more detailed information on using the DPLA API and other fields available, see their [documentation](https://dp.la/info/developers/codex/requests/). You can also use this script to pull down several sets of files, just make sure you rename the letters.csv file before you run it for a different search or your earlier results will be erased.

#### Run the Parser
]To run the parser and get the returned CSV file, you will have to install [NodeJS.](https://nodejs.org/en/download/)  Download the installer for your operating system and install NodeJS following the prompts. After installing Node, you will need to install the project dependencies. Open a command line and navigate to the parser folder where the project is located. Run `npm install`. This will create a folder called `node_modules` and will install the libraries you need into it.[^4]

Open the folder where you downloaded the files from our Github repository. Create a file call `config.json` in the `parser` folder with the text below. Replace `[API Key]` with your DPLA API key.

```
   {
     "api_key": "[API Key]"
   }
```

Return to the command window and run `node get-data.js`. This will download the data into a file called letters.csv We have also included a set of sample data in the files on GitHub (letters-sample.csv) if you want to test out the map without having to clean data and add coordinates yourself.

### Cleaning Data and Identifying Coordinates

Once you have completed parsing the data, you will have a .csv file with the data you selected. Even if you are working with a relatively complete dataset, the data will need to be cleaned. Cleaning data means checking for accuracy, formatting, or adding missing data so that your visualization will be complete and without errors. There are a couple of very easy steps that will help identify errors and missing data in correspondence sets.  The first step that will help you find mistakes is to sort your entire data set by field and check for variations of spelling and punctuation, and standardize each name and other recurring information throughout the entire table. If you are following along with the data we provided, we have already standardized the data and you shouldn't find any variations in spelling, life dates or other information. If any fields in your data contain angle brackets, you will need to remove those brackets. Square brackets and parenthesis do not pose the same problem.

For most pre-twentieth-century correspondence collections, you will likely have to do a lot of hand-compiling of the location data. This is a time-consuming task but is worth the effort. For Chapman's correspondence, many of the letters did not  have their original envelopes or address pages attached, or their date lines did not contain a location and the origin of the letter could only be determined by the content or by checking other letters written by the same person on consecutive days. We also ran into a huge problem with mapping letters sent and received within the same city. Over one-third of the letters in Chapman's correspondence were both sent and received in Boston, Massachusetts and are therefore difficult to display with any meaning as we were not able to determine more specific addresses than the city for the majority of the intra-Boston letters. One solution to this is to pre-define different geographic points for letters sent and received within a specific city, which will at least allow you to display those letters on the map. We chose not to do this, as our project focused more on the international context of antislavery correspondence. Network analysis of the locations can help you to determine if this is going to be a significant problem with your dataset.

If you want to use the timeline function of the script, you will also need to check the date field and format the dates so they can be read by the script and complete any partial dates. Data in the date column not formatted MM/DD/YYYY may be mis-read or skipped by the script. Also, if you are using Excel to edit your CSV file, make sure you do not set the cell type to date or your data will be reformatted to a string of numbers that are not recognized as a date by the script (Note: Excel does not recognize dates before 1900).

Once you have identified all of the locations for the letters in your collection, you will need to convert the addresses to coordinates. The first step to this process is to create a master list of locations included in your dataset. To do this, copy the sent and received locations into single column in a new spreadsheet. Sort them alphabetically and then remove the duplicates (this is also a good way to find spelling or data entry errors if you had to do a lot of hand-compiling for the locations). Use this new list to do your coordinate search. There are many websites that allow you to search for coordinates, but most of them limit the number of searches you can request. If you need to search for several thousand locations, you may want to get an API key for the GPS search engine you decide to use, but for most correspondence sets, you will only end up looking up a few hundred locations even if you are mapping thousands of letters. We used [GPS Visualizer,](http://www.gpsvisualizer.com/geocoder/) which allows you to search Google Maps, Bing, and Map Quest. Simply paste the list of addresses you made into the input section of GPS Visualizer (99 at a time unless you get an API key), select the type of data (raw list, 1 address per line), select your search engine, and set the field separator output to comma. Click run and wait for your results. When the results appear in the second box on the screen, copy and paste them into the spreadsheet containing the list of addresses. Make sure you capture both pieces of each coordinate (latitude and longitude). Depending on the addresses in your dataset, you may find one of the search engines gives better results than the others. In our case, we found Bing to be the most accurate. You will need to double-check each location you find coordinates for to make sure they are correct by running them through the mapping script (we had several notable mistakes when a search returned coordinates for a street in Paris, France in the middle of Africa, and an estate in the suburbs of London, England in the American Midwest). You may have to do some manual location lookup by searching a map and finding the point yourself if you have any nonstandard street addresses or house names. We had to do this with one letter addressed from the middle of the Atlantic Ocean. You can use the Google Maps output button on the GPS Visualizer page to check your coordinates.

If your addresses are located in a city where street names have been changed or streets have been moved, you may also need to look up the modern street names or examine historic maps to determine the locations. As you work on determining locations, you will have to decide how important it is to your project to determine exact locations of historic addresses. If you are working on nineteenth- or twentieth-century American correspondence sets, resources like the [Sanborn insurance maps](http://sanborn.umi.com/) may help identify some addresses or confirm block numbering or other city planning changes that may have occurred.  

Once you have a master list of coordinates for each location, create two new columns in your CSV file (one for location sent and one for received) and enter the coordinates for each letter. We do not recommend just replacing the street address with the coordinates as that makes it more difficult to double check any locations that don't look quite right on the map. The mapping script also relies on those locations to label the points on the map where letters were sent and received. It also makes it more difficult to do any statistical or network analysis of geographic locations if you decide later that doing that analysis is necessary.


## Setting up the map
You can run the map on your website or just on your computer using a local web server, depending on how you intend to use the project. Choose how you plan to run the map and follow the directions to set up the map script.

### Website
If you have a website with FTP access, the easiest thing to do is copy all the files into this repository to your web server in a folder called something like `map`. The map then should be available on your website at that folder i.e. `http://www.yourdomain.com/map`

### Local web server
There are a number of ways to run a local web server, one of the easiest with Node is to use the `node-server` module.
1. Open a command line and nagivate to the folder where the project is located.
2. Run `npm install -g jitsu`
3. Run `jitsu install http-server`
4. Run `node bin/http-server`

There will now be a server running by default on port 8080. To visit the map open a browser and go to `http://localhost:8080`

If you chose to use the sample data we provided, rename 'sample-letters.csv' to 'letters.csv'.

To stop the server you will hit `Ctrl-C`. To start the server again, you don't need to download it again, just run `node bin/http-server`

## Configuring the Map
Mapping software uses several layers of information to create a map. The first layer is a simple grid of latitude and longitude. The second layer contains the information that displays the map itself. These are called vector tiles. Vector tiles are the information on roads or other geographical features you want to appear on your map plus the actual images used to render the map. These can be modern features or historical ones, depending on the tile set you use to display your information. For our project, we began with a basic set of map tiles from [MapBox](http:///www.mapbox.com). MapBox provides a number of different tile sets so that you can customize your map's appearance. You can use existing tiles or even design your own (what we ended up doing). The script is currently set up to use our custom map tiles, but you can edit the script to use other map tiles by changing the following section of `map.js` in the `js` folder to use your tiles. You are not limited to MapBox either, any tile server will work:

```
8 var tileURL = 'http://{s}.tiles.mapbox.com/v3/ttavenner.e7ef536d/{z}/{x}/{y}.png'
```

## Analysis
Although creating the map is a fun and educational experience in and of itself, it wasn't our main goal. Using geospatial software to analyze correspondence allows us to think about space and geography in ways that challenge historiographical assumptions about interactions between groups in different countries, raises questions of how travel impacts an individual's writing practices, and of how correspondence itself shapes our understanding of the past. These questions are part of the reason that digital historians have been so heavily interested in digital mapping projects, as Robertson points out in his essay in *Debates in Digital Humanities*.[^5] Mapping allows us to examine larger collections of data to look for patterns of movement, connections between particular areas, and shifts the the places and people individuals wrote to over time. This section will both explain how you can use the various functions of the map script we provided to analyze your data and give some preliminary results of our project.

Now that you have displayed your data on the map, you can adjust the various settings to use the interactive functions to analyze your data. By adjusting the date slider and player, you can examine how the correspondence network developed over time. If you click on each point on the map you can see the number of letters sent or received there and the list of letters will appear on the right side of the screen. The thickness of the lines connecting points also reflects the number of letters between those two places. You may decide after looking at your map that you need to add additional filters so you can analyze subsets of data (something we are continuing to work on).

To give you some idea of what you can discover about a historical figure or a group of individuals by mapping their correspondence, we will close this lesson with a short summary of our findings on our own project. By mapping Maria Weston Chapman's correspondence we found that geography is very important to understanding antislavery women's work. As antislavery women moved from place to place both within a city or region, as was pointed out by Chambers in her book on the Weston sisters, but also as they moved around the Atlantic world, their correspondents shifted.[^6] Those connections do not shift in the way you would think; Chapman was more likely to write to those who were geographically closer to her than she was to write to overseas correspondents. Chapman wrote and received more letters from her family and her Boston-area colleagues when she was in Boston than she did while in Paris. She wrote more often to British friends and colleagues while in Europe than to the other members of the Boston clique, with the exception of her sister Deborah Weston, who remained in Boston while she and sister Ann went abroad. As antislavery work became more international in the 1840s and 50s, Chapman's inner circle shifted with her own geographic location.

The map also raises questions about how travel shaped Chapman's activism. Her correspondence and engagement in antislavery activity increased rapidly after her return from Haiti, where she spent a winter nursing her husband, who was gravely ill with tuberculosis. Henry Chapman's death and her own exposure to post-revolutionary Haiti seem to have spurred her to greater reform efforts after 1842.  Her second overseas journey, a trip to Europe from 1848 to 1852, reshaped her connections with British abolitionists, many of whom she had been corresponding with since the early 1840s. Those letters became more frequent after her visit, and their contents also shifted. Chapman's own interests changed as a result of her visits, and her own career as a writer and organizer overtook her interest in the annual National Antislavery Bazaar after 1848.

## Summary and Next Steps
Now that you have an idea about what can be done with JavaScript as a programming language, you can modify the script we provided or create your own browser-based maps. These kinds of projects are great not only for doing academic historical analysis but also as tools for the classroom as well. Loading primary source sets into a map can give students new insight into how geography influenced historical actions and allow them to engage with materials in a new way. Students can also easily participate in building the datasets to drive the maps. A student intern assisted us in compiling the data for Chapman's correspondence.

## Endnotes
[^1]: Network analysis is often used in conjunction with geospatial analysis as it can provide analytical insight into the significance of locations and individuals and give a statistical confirmation of patterns seen in the visualizations created by geospatial analysis.

[^2]: A full discussion of APIs is beyond the scope of this lesson, however in general you may think of an API as a web address that returns raw data rather than HTML. It is designed to be machine-readable rather than human.

[^3]: See Lee V. Chambers, *The Weston Sisters: An American Abolitionist Family*, (Chapel Hill, University of North Carolina Press, 2015), 175

[^4]: If you are having permissions errors installing npm, check the solutions [on Stack Overflow.](http://stackoverflow.com/questions/16151018/npm-throws-error-without-sudo/24404451#24404451)

[^5]: Stephen Robertson, "The Differences between Digital Humanities and Digital History," Debates in the Digital Humanities, 2016. Matthew K. Gold and Lauren F. Klein, eds. (Minneapolis: University of Minnesota Press, 2016). Available Online: http://dhdebates.gc.cuny.edu/debates/text/76

[^6]: Chambers, *Weston Sisters*, Chapter 6.
