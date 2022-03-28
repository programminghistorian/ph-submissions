---
title: Making an Interactive Web Application with R and Shiny  
collection: lessons  
layout: lesson  
authors:
- Ryan, Yann Ciarán
---

## Introduction

The outputs from typical analyses in digital history or digital humanities projects are most often static, for example derived tables of data resulting from a statistical analysis, or the plots and maps found in published articles and books. In some cases a research output might include dynamic elements, such as a zoomable map or animated plot, but in order for them to be genuinely interactive---i.e. to change or recalculate in response to inputs from a user---more specialist skills are usually required. Where these kinds of outputs are produced, they are often outsourced to a third-party specialist in a dynamic web-based programming language such as Javascript.

[Graphical User Interfaces (GUI)](https://en.wikipedia.org/wiki/Graphical_user_interface) and interactive elements can help to make certain types of data-driven scholarly work more accessible or readable. To give a simple example, historians working with large-scale data often want to show the change in some variable over time. An interactive map with an adjustable timeline is in some cases easier to read and allows for more granularity than a series of static maps. Allowing a user to set the parameters of the visualisation can help to avoid some of the bias often found in data visualisations using time series (for example, arbitrarily drawing one map per decade).

Many research projects have interactive elements as outputs, for example the [Tudor Networks of Power](https://tudornetworks.net/) visualisation of the networks in the Tudor State Papers, this interactive [Press Tracer](https://livingwithmachines.ac.uk/press-tracer-visualise-newspaper-lineage/), or (to give an example using Shiny), the [GeoNewsMiner](https://utrecht-university.shinyapps.io/GeoNewsMiner), which displays geocoded place mentions in a corpus of newspapers. Interactive applications can be useful tools for archivists: researchers at the National Archives UK have [created an app](https://nationalarchives.shinyapps.io/DiAGRAM/) which assesses the risk level in a digital collection, through a series of questions answered by a user.

Another typical use-case for interactive applications is to provide an easier way to explore your own dataset, without ever intending for the application itself to be made publicly available. One might simply use it to find interesting patterns or as a starting point for further research. In this way interactivity can be particularly useful in helping explore and find patterns within large-scale datasets.

There are a number of ways one could approach the development of interactive visualisations similar to the examples above. One is to learn a web-based language such as Javascript. A second option would be to use existing web-based tools, either general ones like [Tableau](https://www.tableau.com/) and [Rawgraphs](https://rawgraphs.io/), or ones with a more specific purpose such as [Palladio](https://hdlab.stanford.edu/palladio/) or [Gephi](https://gephi.org/). A third approach might be to use [Jupyter notebooks](https://jupyter.org/) which allow you to share interactive code, and even, with some [additional packages](https://ipywidgets.readthedocs.io/en/stable/user_guide.html), create a user interface.

A fourth approach is to use a library for making interactive applications with a GUI for a general-purpose programming language, such as [Bokeh](https://docs.bokeh.org/en/latest/) or [Dash](https://plotly.com/dash/) for Python, or, as used in this tutorial, [Shiny](https://shiny.rstudio.com/) for R. Both Python and R are open source, widely-used, versatile programming languages, with active communities and a huge range of third-party packages. There are many circumstances where it makes sense to use these as the basis for interactive applications. In essence, these packages act as interactive interfaces to the programming language, allowing for the creation of sliders, selectors, and so forth, which can be then used as inputs to dynamically change bits of code. In most cases, they require no technical expertise from the end-user.

The advantage to this approach is that creating Shiny applications is *relatively* simple if you already know R, and R's entire range of libraries and features can be harnessed by Shiny. In some circumstances this might be preferable to learning a new web-based language (such as D3 or Javascript), from scratch. If you have experience with R and just a little knowledge of Shiny, you can create very complex and useful applications, covering everything from maps, to network analysis, to [machine learning models](https://vnijs.shinyapps.io/radiant/) or full dashboards with lots of functionality. If you can program it with R, you can probably make it interactive with Shiny. The process to create a Shiny user interface (UI) is very flexible and easy to customise, meaning it is straightforward to make an application in a format that could be embedded into a project website using iframes: see the [*Mapping the Gay Guides*](https://www.mappingthegayguides.org/map/) project for one example.

There are some drawbacks worth considering. For those who have no intention of using a language like R in other aspects of their work, learning it just to produce Shiny apps may be overkill. Shiny is open source and free to use, but by far the easiest way to publish your finished application to the web is using a service called shinyapps.io (publishing is not covered in this tutorial). Shinyapps.io ia a commercial product which has a free tier with a limited number of hours of use (25), and after that you'll need to pay a monthly fee. You *can* run Shiny on your own server (or through something like [Amazon Web Services](https://www.charlesbordet.com/en/guide-shiny-aws/)), but it's quite an involved process and requires some pretty advanced knowledge of configuring web servers. You should bear this in mind if you are thinking about using Shiny for a public-facing output, particularly if you think it might have lots of traffic and heavy use.

## Lesson Aims

### What you'll learn

-   How to create a basic Shiny application.
-   You'll understand the basic principles of reactive programming.
-   You'll be familiar with the basic construction of a Shiny web page user interface.

### What you won't learn

-   how to publish your application to the web.
-   Basic coding with the R language or the other packages used, other than just enough to create the Shiny application. If you're a complete beginner to R, it might be useful to familiarise yourself with that first. Moreover, if you have not used R and your only goal is to make interactive visualisations, there may be another, easier way to do it.

## Suggested Prior Skills

-   A basic knowledge of R, particularly using the [tidyverse](https://programminghistorian.org/en/lessons/data_wrangling_and_management_in_R), would be very useful.

## Historical Background

The national library of the United Kingdom, the [British Library](https://www.bl.uk/), holds by far the largest collection of British and Irish newspapers in the world. The earliest serial news publication in its collection is from 1621, and it continues to collect to this day. Tracing the metadata of this collection is a way for historians to chart the growth and change in the press over time and through different regions, as well as understand more about the Library's collection itself. The data might even indicate something about the changing demographics and industrialisation of Britain as well as changes in communication technology (trains and then telegraphs made it possible to have regional and local presses).

The newspaper industry (and therefore the collection) grew from a tiny number of titles published in London in the early seventeenth century to a flourishing weekly and daily provincial press in the eighteenth, and then a very large local press in the nineteenth and twentieth centuries. For much of the eighteenth century, a tax was added to every copy of a newspaper making them expensive and only available to the elite. In the following century this was repealed, and the press began---albeit slowly---to reflect the aspirations and diversity of the country and its various regions more fully. The application you'll create in this tutorial---an interactive map of published titles, controlled by a user-selected time slider---is a useful way to visualise these changes.

## The Data

You'll need to download a [title-level list of British and Irish newspapers](https://bl.iro.bl.uk/concern/datasets/7da47fac-a759-49e2-a95a-26d49004eba8?locale=en) before getting started on the tutorial. The dataset has been produced by the British Library and is published on their institutional repository. It contains metadata taken from the Library's catalogue, of every newspaper published in Britain and Ireland up until the year 2019, a total of about 24,000 titles. There is more information available in a published data paper.[^1] The file is available in two formats: either a .zip file containing a .csv and a readme, or as an Excel spreadsheet. Download the zip file, and unzip it.

Alternatively, you can downlad a copy of the dataset used in this tutorial [here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/shiny-leaflet-newspaper-map-tutorial-data/BritishAndIrishNewspapersTitleList_20191118.csv).

[^1]: Yann Ryan and Luke McKernan, “Converting the British Library’s Catalogue of British and Irish Newspapers into a Public Domain Dataset: Processes and Applications,” Journal of Open Humanities Data 7, no. 0 (January 22, 2021): 1, https://doi.org/10.5334/johd.23.

Once this is done take a look at the dataset itself (you can open it in R, a spreadsheet program or a text editor). The .csv file (`BritishAndIrishNewspapersTitleList_20191118.csv`) contains a number of fields for each title, including the name of the publication, subsequent and previous title names, several fields for geographic coverage, the first and last dates held, and some other information.

It's worth reading the `README` file which comes along with the zip file. This says that there are several fields provided for geographic coverage, because the records have been catalogued over a long period of time and cataloguing standards and conventions have changed. The purpose here is to map the newspapers at a geographic point level, i.e at the level of village, town, or city, rather than county or country. There are two potentially relevant fields where we might find the relevant geographic points to map: 'place_of_publication' and 'coverage_city'. These seem like different things (a newspaper could be published in one place but have geographic coverage over another, perhaps if the former didn't have a suitable newspaper press), but that's not how they've been used by cataloguers in practice. The `README` file says that the latter (coverage_city) contains more complete data, so that is the one you'll use to map the titles.

The other two fields of interest are the first and last dates held. The readme also tells us that the library does not have complete coverage, though it has most titles from 1840s onwards, and effectively all titles from 1869 when Legal Deposit[^2] was introduced. This means that the collection does not necessarily have all issues of a newspaper *between* the first and last dates held by the Library. In this tutorial, you'll create an interactive slider which will allow a user to choose a start and an end date. This could be used to filter the data in one of two ways: either to every newspaper published *at some point* between those two dates, or it could map every newspaper *first* published between the dates. For simplicity (and because in the former scenario, it would over-represent the Library's collections), in this tutorial you'll do the latter.

[^2]: Legal Deposit was a mechanism by which publishers were obliged to give the British Museum (and subsequently the British Library) a copy of any book produced, including newspapers.

## Making an Application Using Shiny

To demonstrate how Shiny works, in this tutorial you will take this dataset of newspaper publication places and dates and turn it into a basic interactive application. This application will contain an interactive slider allowing a user to select and drag a date range, which will automatically update an interactive map of points. In total there are five short coding tasks your application will need to carry out:

-   Load the two necessary datasets.
-   Create a user interface
-   Create a 'reactive' dataset of places, a count of their appearances, and their geographic coordinates.
-   Turn this into a special geographic dataset called a simple features object
-   Create an interactive map using another R library called [Leaflet](https://rstudio.github.io/leaflet/).

Before getting to this however, you need to set up the correct environment and create a new Shiny application.

## Setting up your Coding Environment

### Install R and Rstudio

You should install the [latest versions of R](https://cran.rstudio.com/) and [Rstudio](https://www.rstudio.com/products/rstudio/download/) on your local machine to complete this lesson. R has a very popular (though separate) IDE (Integrated Development Environment) called RStudio, which is often used alongside R as it provides a large set of features to make coding in the language more convenient.You'll use this IDE throughout the lesson, but the lesson can be completed without it.

Previous Programming Historian lessons have covered [working with R](https://programminghistorian.org/en/lessons/r-basics-with-tabular-data) and [working with the tidyverse](https://programminghistorian.org/en/lessons/data_wrangling_and_management_in_R). It would be useful to go through these lesson beforehand, to learn the basics of installing R and using the tidyverse for data wrangling. However, the amount of coding is very minimal, so you can follow the lesson without it.

### Create a new RStudio Project

Once you have a working copy of R and Rstudio, load the latter and create a new project to work on your application. To ensure that there are no conflicts between different versions of packages, it is recommended to first set up a virtual environment for your project. This can be done by ticking the 'Use renv with the project' checkbox in the 'Create A Project' dialogue window. Once the project is loaded, activate the virtual environment using the command `renv::activate()`. 

Before you continue, you need to make sure you have the four packages necessary to complete the tutorial. If you don't have them installed already, you can do so with the code in the block below. You can run this in the R console or in a separate R script, but they shouldn't be written into the `app.R` script you're about to create.

```
install.packages('shiny')
install.packages('leaflet')
install.packages('sf')
install.packages('tidyverse')

```

## Create an Empty Shiny Application

### Set up an Application Folder

A Shiny application is made by creating a script file called `app.R`. It's good practice to put all the necessary files for the application in their own folder, within the RStudio project. Do this by creating a new folder called 'newspaper-app' within the RStudio project. First, put the files you downloaded into the new folder (`BritishAndIrishNewspapersTitleList_20191118.csv` and `newspaper_coordinates.csv`).

### Make app.R

With RStudio open, click file-\> new file -\> R Script. Use the menu or command/ctrl + s to save the file. Navigate to the new folder you've just created, and save the file there, entering `app.R` as the file name. You should now have the following files in the folder you just created:

{% include figure.html filename="shiny-leaflet-newspaper-map-tutorial-1.png" caption="Figure 1. Screenshot of application folder showing the files needed." %}

### Load the relevant libraries

<div class="alert alert-warning">
It's important to note that, unlike many tutorials, the code you're about to enter will not work if run line-by-line, but only when the `app.R` script itself is run from within RStudio.
</div>

The first thing the app will need to do is prepare and load the data. This is done within the `app.R` script, but outside the UI and server elements you'll create in a moment. First, load all the libraries you need to use:

```
library(tidyverse)
library(shiny)
library(sf)
library(leaflet)
```

Next, the app should load the title list and save it as a dataframe called `newspapers`. Add the following line to your app.R script, which should be displayed in the top-left panel of RStudio. Note that because the working directory is different to your app directory, these commands will only work when you run the app itself.

```
newspapers = read_csv('BritishAndIrishNewspapersTitleList_20191118.csv')
```

To map the data, each place needs a set of lat/long geographic coordinates. The title list does not contain this information, but a dataset covering the majority of newspapers is available separately [here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/shiny-leaflet-newspaper-map-tutorial-data/newspaper_coordinates.csv). Download this file of coordinates, and add it to your app.R script:

```
coordinates = read_csv('newspaper_coordinates.csv')
```

Both of these datasets contain a column `coverage_city`, which the app will use as a key later to join, or merge, the two datasets, matching each place to its correct coordinates.

To turn this into a Shiny application, this `app.R` script needs three elements:

-   The **ui**, where the visual appearance of the app will be stored.

-   The **server**, which will contain the code used.

-   The command to run the application itself.

Next you'll create each of these in turn.

### Create an Empty UI Element

The UI is an element which will contain a number of special Shiny commands to define how the application will look. Generally, you specify a page type, and the various components of the UI are nested within this first element: first, a layout type, within that the specific layout elements; and finally within these, the various components of the app itself.

The one you'll use is called `fluidPage()`, a page---which dynamically resizes depending on the size of the browser window---containing a fluid layout of rows which in turn contain columns. There are other page options for Shiny: those with some web design experience might be familiar with the [bootstrap](https://getbootstrap.com/docs/4.0/layout/grid/) format, which can be used with the command `bootstrapPage()`, to create complicated designs for an application, based on a 12-column grid.

The first step is to create all the basic elements needed for an app, before later filling them with the required components. To start with, make a blank ui element by setting the variable `ui` to the element `fluidPage()`, with the following code in your `app.R` script:

```
ui = fluidPage()
```

### Create the Server Element

Next up is the server part. The server is created as an R function with two arguments, `input` and `output` (you don't need to worry about what the input and output arguments do for now, as long as they are there).[^3] In R a function is made using the command `function(){}`, specifying the arguments in parentheses, and then the function code between curly braces. All the code for the logic of the application will live between these two curly braces.

[^3]: The server object is actually a list with all the inputs stored in the first element, called input, and all the outputs stored in the second element, called output.

Specify the server part using the following code:

```
server = function(input, output){}
```

Finally, add the command to run the application itself. This is another special Shiny command, `shinyApp()`, with the ui and server items you've just made as arguments.

shinyApp(ui, server)

The full `app.R` file should now contain the following lines:

```
library(tidyverse)
library(shiny)
library(sf)
library(leaflet)

newspapers = read_csv('BritishAndIrishNewspapersTitleList_20191118.csv')

coordinates = read_csv('newspaper_coordinates.csv')

ui = fluidPage()
server = function(input, output){}
shinyApp(ui, server)
```

### Test Your New Application

Once you have created these items, resave the `app.R` file. RStudio will now recognise it as a Shiny application, and the icons at the top of the panel will change, giving a 'Run App' option. If you click this, it will run the application in a new window using the RStudio in-built browser.

{% include figure.html filename="shiny-leaflet-newspaper-map-tutorial-2.png" caption="Figure 2: Screenshot of the control panel with the Run App button highlighted." %}

Unsurprisingly, the application is just a blank web page for now. You'll also notice that while the app is running you can't use run any code in RStudio: the console shows up as 'busy'. You'll need to close the application to start using R again. You can also use the 'open in browser' option to try out the app in your default browser.

## Coding the Application

### Shiny and Reactive Programming

Shiny is based around a concept called [*reactivity*](https://en.wikipedia.org/wiki/Reactive_programming). Usually, when coding, we set a variable to a specific value, say `x = 5`. In *reactive programming*, the variable is dependent on a changing input, usually set by a user (from a text slider or drop down list, for example). The code 'listens' for changes to these reactive variables and every time these special variables change, any output they are used in automatically updates.

However, this updating only happens within **reactive contexts**. Shiny has three important reactive contexts: `render*` functions, which are used to create R objects and display them in the app, `observe({})`, and `reactive({})`. In this tutorial you'll use reactivity to create a summarised dataframe of newspaper titles and their dates, which updates dynamically based on a user input of dates. Elsewhere in your app, you'll use a `render*` function to display a map which will listen for changes to this reactive dataframe and update itself when any is found.

### Designing the User Interface

Next, you'll need to fill the `ui` element with the components necessary to display the app. Within the `fluidPage()` object, create a second object, `sidebarLayout()`:

```
ui = fluidPage( sidebarLayout() )
```

Next, populate this with specific parts of the webpage, components called `sidebarPanel()` and `mainPanel()`. Do this by placing them within `sidebarLayout()`.

<div class="alert alert-warning">
Because shiny UI code often ends up with lots of nested parentheses, splitting them across two lines like in the code chunk below can make it easier to read — but it's not necessary for the code to work.
</div>

The full ui element should now look like this:

```
ui = fluidPage(
sidebarLayout(
sidebarPanel = sidebarPanel(

),
mainPanel = mainPanel(

)
)
)
```

#### Add a 'Widget': the sliderInput Control

In Shiny, users update values using various interactive, customisable controls known as 'widgets'.The full list can be found in the [Shiny widget gallery](http://shiny.rstudio.com/gallery/widget-gallery.html). The widget you're going to use is called `sliderInput()`. This will display an interactive sliding bar with a large number of options, such as the minimum, maximum and starting value(s). You can also set the step and format of the numbers (type `?sliderInput` in the console to get a full list of options and explanations). Here you'll make one with a minimum year of 1620 (the first data point in the title list), and a maximum of 2019 (the last).

The starting value can be a single number, or a vector of two numbers. If the latter is used, the slider will be double-sided, with a first and second value. This is what we want to use, so that a user can specify a range of years rather than a single one.

The following code will create a slider with two draggable ends, set by default to 1700 and 1750:

```
sliderInput('years', 'Years', min = 1621, max = 2000, value = c(1700, 1750))
```

Your full `app.R` script should now look like this:

```
library(tidyverse)
library(shiny)
library(sf)
library(leaflet)

newspapers = read_csv('BritishAndIrishNewspapersTitleList_20191118.csv')

coordinates = read_csv('newspaper_coordinates.csv')

ui = fluidPage(

sidebarLayout(sidebarPanel = sidebarPanel(

sliderInput('years', 'Years', min = 1621, max = 2000, value = c(1700, 1750))

),

mainPanel = mainPanel()



)

)

server = function(input, output){}

shinyApp(ui, server)
```

At this point, run the application to see how the slider looks. You should see a grey panel on the left (the sidebar panel), containing the slider widget. If you hover over the slider, you'll notice that you can drag each end (to select a range size) and you can also drag the middle (which will move the entire slider over a window of the selected range size).

{% include figure.html filename="shiny-leaflet-newspaper-map-tutorial-3.gif" caption="Figure 3. Animated gif demonstrating the functionality of the slider input widget." %}

#### Put the leafletOutput in the mainPanel Element

In Shiny, you need to let the UI know it should display an output (some kind of R element, such as a table of data or a plot, or something as simple as a line of text) created in the server code. This is done by creating an element in the ui from the `*Output` family of commands. Each R element you can display in Shiny has its own `*Output` command: here, you'll use `leafletOutput()`, which tells the UI to create a leaflet map. `leafletOutput` has one required argument: its label. This label will be used to match the UI element to the actual map object you'll create in the server code later. Set this label as 'map'. You can optionally set the width and height with `width =` and `height =`.

The full app should now look like this:

```
library(tidyverse)
library(shiny)
library(sf)
library(leaflet)

newspapers = read_csv('BritishAndIrishNewspapersTitleList_20191118.csv')

coordinates = read_csv('newspaper_coordinates.csv')

ui = fluidPage(

sidebarLayout(sidebarPanel = sidebarPanel(

sliderInput('years', 'Years', min = 1621, max = 2000, value = c(1700, 1750))
),

mainPanel = mainPanel(

leafletOutput('map')

)



)

)

server = function(input, output){

}

shinyApp(ui = ui, server = server)
```

### Creating the Server Logic

Next you need to write the logic to create the object which will be displayed in the UI. This has two parts. First, you'll create a *reactive element*, which, as explained above, is a special object which will listen for changes to the user input, and remake itself as necessary. Second, you'll create an *output* which will contain the interactive map itself.

#### Create the reactive for the leaflet map

First, create the reactive element. In this case it will be a special type of geographic dataset called a *simple features object*. This format has been covered in a previous *Programming Historian* lesson, ['Using Geospatial Data to Inform Historical Research in R'](https://programminghistorian.org/en/lessons/geospatial-data-analysis). Whenever the user changes the variables in the date slider in any way, it'll run through a set of commands:

-   Filter the title list to the relevant set of dates.

-   Make a count of the number of times each place occurs in this filtered list.

-   Match the places to a set of coordinates using a join.

-   Convert the result into a simple features object.

To create a reactive object called `map_df`, use the code `map_df = reactive({})`, within the server component.

Next, within the curly braces, enter the code which will create the reactive object. Filter the newspapers dataset using the tidyverse command `filter()`, using the values from the `sliderInput` widget. These are accessed using `input$LABELNAME`, which in this case is `input$years`, though there is a further complication to note. Remember you set the value of the sliderInput to a vector of length two, so that a range could be selected? The two numbers of this range are stored in `input$years[1]` and `input$years[2]`. These are the values which you need to access in order to filter the data. The data should be filtered to include all records with a first date larger than the first value and smaller than the second. The code to do so is this:

```
map_df = reactive({

newspapers %>% 
filter(first_year_held > input$years[1] & first_year_held < input$years[2])

})
```

Next, `count()` on this filtered dataset to produce a dataframe of each city and a tally of the times they occur (you can specify the name of the new column containing the tallies with the argument `name =`):

```
map_df = reactive({

newspapers %>% 
filter(first_year_held > input$years[1] & first_year_held < input$years[2]) %>%
count(coverage_city, name = 'titles')

})
```

Join the coordinates dataframe to the counts dataframe using `left_join()`. You should specify the key on which to join, which is `coverage_city`. There are a small number of newspaper titles without lat/long coordinates, which would cause an error when creating the geographic object. Filter these out:

```
map_df = reactive({

newspapers %>% 
filter(first_year_held > input$years[1] & first_year_held < input$years[2]) %>%
count(coverage_city, name = 'titles') %>% 
left_join(coordinates, by = 'coverage_city') %>%
filter(!is.na(lat) & !is.na(lng))

})
```

Finally, turn it into a simple features object, using `st_as_sf()`. To do this, specify the lat/long coordinates columns it should use using `coords`, and then use `st_set_crs` to set a coordinate reference system.[^4]

[^4]: Because there are various ways to transform a globe into a 2D representation, displaying geographic data correctly requires setting a coordinate reference system. 4326 is a commonly-used one for worldwide geographic data.

```
map_df = reactive({

newspapers %>% 
filter(first_year_held > input$years[1] & first_year_held < input$years[2]) %>%
count(coverage_city, name = 'titles') %>%
filter(!is.na(lng) & !is.na(lat)) %>% 
st_as_sf(coords = c('lng', 'lat')) %>% 
st_set_crs(4326)

})
```

This simple features dataframe can be accessed in any reactive context by Shiny using `map_df()` and can be used by multiple outputs at once: for example you could build an app which displays both a map and a bar chart, each using the same reactive object.

#### Create the Leaflet Map

The last thing to do is to create the map itself. This is done using the library `leaflet`, which allows for interactive, zoomable maps. It works particularly well with Shiny. A few things are important here.

In Shiny, you create reactivity by connecting **inputs** to **outputs**. **Inputs**, in this context, are the variables adjusted by the user. Remember the `sliderInput()` you created in the UI above, with the label 'years'? We've already seen that the value for it is stored by Shiny in the variable `input$years`. **Outputs** are the R expressions which tell Shiny what to display in the UI and are created, in the server, with the variable name `output$*`. Outputs need to be matched to a ui `*Output` element. Again, in the UI you created a leaflet output with the label `map` using the code `leafletOutput('map')`. This should be matched to an output in the server named `output$map`.

This `output$map` variable in turn should be set to to a Shiny **render\*** function, which tells Shiny what kind of object is to be rendered in the UI. The one we need is called `renderLeaflet`, which tells the ui to output a map created by the leaflet library. The `renderLeaflet` object has both parentheses and curly braces, just like the reactive object. So, to set the output called `map` to an empty leaflet map, add the following line to your app.R script, somewhere within the curly braces of the server object:

```
output$map = renderLeaflet({

})
```

The leaflet map itself will be created within this. It's done by first adding the function `leaflet()`. Next, add the default tiles (the zoomable map images) using `addTiles()`. Next, set the default map position and zoom to Britain and Ireland using the command `setView(lng = -5, lat = 54, zoom = 5)`:

```
leaflet() %>%
addTiles() %>%
setView(lng = -5, lat = 54, zoom = 5) 
```

#### Add Points to the Map

It's time to run the application again. All being well, you should see an interactive map of Britain and Ireland to the right of the slider. You can zoom and scroll it, though not much else. It needs to be populated with points representing the count of titles from each place.

{% include figure.html filename="shiny-leaflet-newspaper-map-tutorial-4.png" caption="Figure 4. Screenshot of the application with leaflet map and slider input widget." %}

To do this, use the command `addCircleMarkers()`, which adds a graphical layer of circles to the leaflet map, with coordinates taken from a geographic data object. Specify that `addCircleMarkers` should use the reactive dataframe, with the argument  `data = map_df()`. Each time the application notices a change to this reactive object, it will redraw the map with the new data. Here you can also set the radius of the circles to correspond to the column containing the count of titles for each place, using `radius = ~sqrt(titles)`. We use the square root, because that makes the area of the circles correctly proportional to the count. The full code for the leaflet map should look like this:

```
leaflet() %>% 
addTiles() %>% 
setView(lng = -5, lat = 54, zoom = 5) %>%  
addCircleMarkers(data = map_df(), radius = ~sqrt(titles))
```

And the entire app.R script should now look like this:

```
library(tidyverse)
library(shiny)
library(sf)
library(leaflet)

newspapers = read_csv('BritishAndIrishNewspapersTitleList_20191118.csv')

coordinates = read_csv('newspaper_coordinates.csv')

ui = fluidPage(

sidebarLayout(sidebarPanel = sidebarPanel(

sliderInput('years', 'Years', min = 1621, max = 2000, value = c(1700, 1750))),

mainPanel = mainPanel(

leafletOutput('map')

)



)

)

server = function(input, output){

map_df = reactive({

newspapers %>% 
filter(first_date_held > input$years[1] & first_date_held < input$years[2]) %>%
count(coverage_city, name = 'titles') %>% 
left_join(coordinates, by = 'coverage_city')%>% 
filter(!is.na(lng) & !is.na(lat)) %>% 
st_as_sf(coords = c('lng', 'lat')) %>% 
st_set_crs(4326)

})

output$map = renderLeaflet({

leaflet() %>% 
addTiles() %>% 
setView(lng = -5, lat = 54, zoom = 5) %>%  
addCircleMarkers(data = map_df(), radius = ~sqrt(titles))

})




}

shinyApp(ui = ui, server = server)
```

### Test the Application

It's time to run the application again. Now, there should be variously-sized circles dotted across the map. Try moving or dragging the sliders - the map should update with every change. Congratulations, you've made your first Shiny app!

{% include figure.html filename="shiny-leaflet-newspaper-map-tutorial-5.gif" caption="Figure 5. Animated gif demonstrating the leaflet map updating as the values in the slider input widget are changed." %}

## Improving the Application

To learn more about Shiny and Leaflet, you could try adding some of the following features to your application:

-   First, add an additional user input to filter the map data. Using another widget, `selectInput`, you could allow a user to display data from just one of the four countries in the title list. Type `?selectInput` into the console to get help on the parameters you need to set in order to do this correctly. Additional inputs can be placed under the existing sliderInput, separated by a comma.
-   Add some elements to the leaflet map. A full list of options can be found using `?circleMarkers` in RStudio. For example you can add a label to the points with `label = coverage_city`.
-   You'll notice that every time you move the slider, the entire map redraws and resets its view, which isn't very elegant. This can be fixed using another function called `leafletProxy`. In essence, create an empty leaflet map (without the circleMarkers) as above. Then in another reactive context, `observe`, you'll add the code to redraw the changing parts of the map, using `leafletProxy`. The instructions to do this can be found [here](https://rstudio.github.io/leaflet/shiny.html).

## Conclusion  

Interactive visualisations can be dismissed as gimmicky, but in fact can help to bring new insights to historical data. In this tutorial we made use of some powerful R packages, such as the Tidyverse and Leaflet, and were able to use these in an interactive environment, rather than having to prepare all the data in advance. This relatively low barrier to entry makes it easy to create quick applications which can make working with large-scale data less painful. Shiny applications are also a useful way to share some of the benefits of the programming capabilities of R with a non-technical audience or project team members. It's relatively easy to create an application that would allow a user to do their own data analysis with R, without have to actually code or use the command line.  
