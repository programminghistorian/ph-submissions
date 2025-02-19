---
title: "Visualizing Urban and Demographic Data in R with ggplot2"
slug: urban-demographic-data-r-ggplot2
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Igor Sosa Mayor
- Nabeel Siddiqui
reviewers:
- Forename Surname
- Forename Surname
editors:
- Giulia Osti
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/606
difficulty: 3
activity: TBC
topics: TBC
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

<<<<<<< HEAD
## Introduction

After World War II, European cities faced a monumental task: rebuilding not just their physical infrastructure but also their international relationships. One fascinating lens for examining this post-war reconstruction is [sister cities](https://en.wikipedia.org/wiki/Sister_city), formal partnerships between cities that developed in the post-war period to foster cross-border cooperation and understanding.

Sister-city relationships present historians with both an opportunity and a challenge. The opportunity lies in their potential to reveal post-war reconciliation and diplomacy patterns. The challenge comes from their scale and complexity - a single city might have dozens of partnerships formed across different decades, and we must analyze thousands of relationships when multiplied across hundreds of European cities. This is where data visualization becomes important for historical research. By converting these complex networks of sister-city relationships into visual patterns, we can explore questions difficult to answer through traditional methods alone: Did West German cities preferentially form partnerships with French cities as part of post-war reconciliation? Did the Iron Curtain create distinct patterns of sister-city relationships between Eastern and Western Europe? How did city size and geographic distance influence diplomatic connections?

The R package [ggplot2](http://ggplot2.tidyverse.org) provides powerful tools for investigating these and similar questions through data visualization. While spreadsheets and basic charts can obscure patterns, ggplot2's sophisticated visualization capabilities allow historians to more easily uncover hidden relationships in data. For example, scatter plots can reveal correlations between numerical variables like population sizes and geographic distances, bar plots can show the distribution of partnerships across different categories of cities, and histograms can expose patterns in demographic data that might otherwise remain invisible.

This tutorial differs from standard ggplot2 guides by focusing specifically on the needs of urban historians. Rather than using generic datasets, we'll work with historical data about sister-city relationships to demonstrate how visualization techniques can illuminate historical patterns and processes. Through this approach, you'll learn to create visualizations that reveal complex partnerships and make historical findings more accessible to a broader audience.

## Lesson Goals

By the end of this lesson, you should be able to do the following with the `ggplot2` package:

1. Create different types of plots to visualize urban and demographic data, including bar plots to show city relationships, histograms to display population distributions, and scatterplots to explore relationships between urban and demographic variables.
=======
## Introduction and Lesson Goals

Historians now increasingly face the task of gathering and analyzing data, and plots are important in visualizing that data. Using R and the powerful package [ggplot2](http://ggplot2.tidyverse.org/), we can create useful and beautiful plots to give a glance into our data and make it easier to communicate our findings to the public and a broader audience. 

By the end of this lesson, you should be able to do the following with the `ggplot2` package:

1. Create different types of plots: bar plots, histograms, boxplots, scatterplots, etc.
>>>>>>> 7c3b2730 (update local branch)

2. Manipulate the aesthetic of plots, such as colors or sizes.

3. Add meaningful labels to plots.

<<<<<<< HEAD
4. Create grids of plots for data comparison.

5. Create novel plots with ggplot2 extensions.

This tutorial assumes you have a rudimentary knowledge of R. The *Programming Historian* lessons [R Basics with Tabular Data](https://programminghistorian.org/en/lessons/r-basics-with-tabular-data) and [Data Wrangling and Management in R](https://programminghistorian.org/en/lessons/data_wrangling_and_management_in_R) are recommended if you do not have this background.

## Our Data: Sister Cities in Europe

In historical research, urban and demographic data are fundamental to understanding human societies' development. Urban data allows us to reconstruct the complex network relationships between cities. This encompasses everything from formal administrative connections, such as trade partnerships or political alliances, to informal relationships built through cultural exchange and population movement. Cities might be linked through trade routes, shared governance structures, or cultural institutions. The physical aspects of cities also form an important part of urban data: their geographic locations, proximity to other urban centers, and position within transportation networks influence how cities interact with one another.

Urban data also helps us understand the different roles cities play within broader social and economic systems. Some cities serve as administrative capitals, others as major ports facilitating international trade, and still others as industrial centers driving economic growth. These roles often shift over time as cities adapt to changing political, economic, and technological circumstances. 

Demographic data complements this urban analysis by revealing the human dimension of change. At its most basic level, demographic data tells us about population sizes and their fluctuations, but its true value lies in helping us understand the complex patterns of settlement and movement. Changes in population density reflect urbanization processes, economic opportunities, or responses to environmental challenges. Migration patterns revealed through demographic data illuminate everything from economic relationships between regions to the impact of political policies on population movement. The social and economic characteristics of populations—their age distributions, occupational patterns, and social structures—also provide a crucial context for understanding urban development.

Historians can combine these data types to investigate urban development and population dynamics. As mentioned earlier, we will look at [sister cities](https://en.wikipedia.org/wiki/Sister_city)—pairs of cities located in different countries with a partnership to promote cultural and commercial ties. The modern concept of sister cities was conceived after World War II to foster friendship and understanding between different cultures and to promote trade and tourism. These partnerships often involve student exchanges, business relationships, and cultural events. By examining these partnerships, we can assess if geographic proximity, shared language, or similar population size play a role in two cities establishing a relationship. We can also explore whether historical tensions or alliances, such as those between Germany, France, and Poland, or the shared linguistic heritage of Spanish-speaking cities in the Americas, shape these partnerships. Historians have looked more carefully at [these kinds of interactions in recent years](https://www.cambridge.org/core/journals/urban-history/issue/62C6F87B847CEFABB93598C340D8B144).

The first question that arises is: where can we get data about sister (or twinned) cities? One possibility is to draw from one of the biggest repositories of data in the world: [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page). Every single town in the world has a unique identifier and a page with all related information. For example, the page devoted to [London](https://www.wikidata.org/wiki/Q84) shows, among other data, a list of the “twinned administrative body.” Using the [SPARQL Protocol And RDF Query Language,](https://en.wikibooks.org/wiki/SPARQL) we can make queries against these data and extract information about towns associated with London.

For this tutorial, we have made different queries to extract data about towns and their sister cities from different countries in Europe. Through this, we created a dataset containing the following data: the name, country, population, and geographical coordinates of the "origin city" and the same data about the "destination city." We also calculated the distance between the two towns and added a boolean column indicating whether the "destination city" is in the European Union or not (all "origin cities" are in the European Union).

Our approach will be largely [exploratory](https://en.wikipedia.org/wiki/Exploratory_data_analysis), aiming to identify patterns, trends, and relationships in the data. We hope that we can uncover new insights and generate hypotheses for further research by doing so. You can download the dataset at [this link](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/urban-demographic-data-r-ggplot2/sistercities.csv).

## The advantages of ggplot2

The reasons we have chosen ggplot2 for this analysis are myriad. The package has many advantages over other possibilities:

1. It relies on a theoretical framework (detailed below) that assures your graphs meaningfully convey information, which is particularly important when working with complex urban and demographic datasets.
2. It is relatively simple to use while remaining powerful.
3. It creates publication-ready graphs.
4. It has [extensions](http://www.ggplot2-exts.org/) that the community has developed to enhance its possibilities, such as the addition of new functions, graphs, and themes.
5. ggplot2 is versatile in the types of data it can handle. It works with various data structures, including:
   * Numerical data (continuous and discrete)
   * Categorical data (factors and character strings)
   * Date and time data
   * Geographic coordinates
   * Text data

Creating graphics is a complicated issue since we need to take into account various aspects of our data: the information we want to convey, the graph type we want to convey that information (scatterplots, boxplots, histograms, and so on), the elements of the graph we wish to tweak (axes, transformation of variables, legends, etc.), and more. To streamline this, ggplot2 is based on a theoretical framework known as the [grammar of graphics](https://link.springer.com/book/10.1007/0-387-28695-0) (hence the gg in the name ggplot2), detailed by [Leland Wilkinson](https://en.wikipedia.org/wiki/Leland_Wilkinson). If all this sounds complicated at first, don't panic! You only need to know a little bit about the grammar to make your first graph.

In the grammar of graphics, all plots are composed of a series of seven interrelated layers:

1. Data: The material we will analyze for our visualization.

2. [Aesthetics](https://ggplot2.tidyverse.org/reference/index.html#aesthetics): The ways visual properties map onto so-called _geoms_ (Geometric Objects, see below). In most cases, this determines how we want to display our data (position, color, shape, fill, size, etc.)

3. [Scales](https://ggplot2.tidyverse.org/reference/index.html#scales): The mapping and normalization of data for visualization.

4. [Geometric Objects](https://ggplot2.tidyverse.org/reference/index.html#geoms) (_*geoms*_ in ggplot2 parlance): How we want to represent our data. In most cases, this determines the type of graph, such as a bar graph, line graph, or histogram.

5. [Statistics](https://ggplot2.tidyverse.org/reference/index.html#stats): Statistical calculations we may want to run our data before visualizing it.
=======
4. Create grids of plots for data comparison. 

5. Create novel plots with ggplot2 extensions.

This tutorial assumes you have a rudimentary knowledge of R. Programming Historian has lessons covering different topics, and we recommend beginning with Taryn Dewar's [R Basics with Tabular Data](https://programminghistorian.org/en/lessons/r-basics-with-tabular-data) and Nabeel Siddiqui's [Data Wrangling and Management in R](https://programminghistorian.org/en/lessons/data_wrangling_and_management_in_R) if you do not have this background.

Several data analysis methods exist, but we will concentrate on graphical representations in this tutorial. In R, we have three main possibilities for creating graphs: the [plotting functions](https://cran.r-project.org/doc/manuals/r-release/R-intro.html#Graphics) provided by the standard installation of R, the [lattice](http://lattice.r-forge.r-project.org/) package, and finally, [ggplot2](http://ggplot2.tidyverse.org/), created by [Hadley Wickham](http://hadley.nz/).

## The advantages of ggplot2

ggplot2 has many advantages over the other possibilities:

1. It relies on a theoretical framework (detailed below) that assures your graphs meaningfully convey information. 

2. It is relatively simple to use while remaining powerful. 

3. It creates publication-ready graphs.  

4. It has [extensions](http://www.ggplot2-exts.org/) that the community has developed to enhance its possibilities, such as the addition of new functions, graphs, and themes.

5. It can also be used to create maps (which is although not covered in this lesson).

Creating graphics is a complicated issue since we need to take into account various aspects of our data: the information we want to convey, what type of graph we want to convey that information (scatterplots, boxplots, histograms, and so on), the elements of the graph we wish to tweak (axes, transformation of variables, legends, etc.), and more. To provide a common framework, ggplot2 is based on a theoretical framework known as the [grammar of graphics](https://link.springer.com/book/10.1007/0-387-28695-0) (hence the gg in the name ggplot2), as detailed by [Leland Wilkinson](https://en.wikipedia.org/wiki/Leland_Wilkinson). If all this sounds complicated at first, don't panic! You only need to know a bit about the grammar to make your first graph.

The idea behind the grammar of graphics is that all plots are composed of a series of seven interrelated layers:

1. Data: The material we will use to analyze for our visualization.

2. [Aesthetics](https://ggplot2.tidyverse.org/reference/index.html#aesthetics): The ways that visual properties map onto so-called *geoms* (Geometric Objects, see below).  In most cases, this determines how we want to display our data (position, color, shape, fill, size, etc.)

3. [Scales](https://ggplot2.tidyverse.org/reference/index.html#scales): The mapping and normalization of data for visualization.

4. [Geometric Objects](https://ggplot2.tidyverse.org/reference/index.html#geoms) (*geoms* in ggplot2 parlance): The way we want to represent our data.  You can think of this as determining the type of graph you want, such as a bar graph, line graph, or histogram.

5. [Statistics](https://ggplot2.tidyverse.org/reference/index.html#stats): Statistical calculations we may want to run our data before visualizing it. 
>>>>>>> 7c3b2730 (update local branch)

6. [Facets](https://ggplot2.tidyverse.org/reference/index.html#facetting): The ability to categorize and divide data into multiple sub-graphs.

7. [Coordinate Systems](https://ggplot2.tidyverse.org/reference/index.html#coordinate-systems): Determines how ggplot2 positions different geoms on the plot. The most common coordinate system is the Cartesian coordinate system, but ggplot2 can also plot polar coordinates and spherical projections.

<<<<<<< HEAD
To begin using ggplot2, we need to install and load it. We recommend installing the [tidyverse](https://www.tidyverse.org), which contains ggplot2, a collection of R packages that work together to provide a consistent and efficient workflow for data manipulation, exploration, and visualization. At the core of the tidyverse philosophy is the concept of ["tidy data"](https://r4ds.had.co.nz/tidy-data.html), a standardized way of structuring data to make it easier to work with. In tidy data, each variable is a column, each observation is a row, and each type of observational unit is a table. This structure allows for a consistent and predictable way of working with data across different packages and functions within the tidyverse. For more details, see the book [_R for Data Science. Import, Tidy, Transform, Visualize and Model Data_](https://r4ds.hadley.nz/) written by Hadley Wickam and others.
=======
To use ggplot2, we need first to install and load it. We recommend installing the [tidyverse](https://www.tidyverse.org), which includes ggplot2. The tidyverse is a collection of R packages that work together to provide a consistent and efficient workflow for data manipulation, exploration, and visualization. At the core of the tidyverse philosophy is the concept of ["tidy data"](https://r4ds.had.co.nz/tidy-data.html), a standardized way of structuring data to make it easier to work with. In tidy data, each variable is a column, each observation is a row, and each type of observational unit is a table. This structure allows for a consistent and predictable way of working with data across different packages and functions within the tidyverse. It is brilliantly explained in the book *R for Data Science. Import, Tidy, Transform, Visualize and Model Data* written by Hadley Wickam and others and [is available online](https://r4ds.hadley.nz/).
>>>>>>> 7c3b2730 (update local branch)

```

install.packages("tidyverse")

library("tidyverse")

```

<<<<<<< HEAD
### Loading Data with readr

Before importing data, it is important to understand how it may be formatted. Common spreadsheet applications, such as Microsoft Excel or Apple Numbers, place data in a proprietary format. While there are packages to read in Excel data, such as [readxl](https://readxl.tidyverse.org/), it is recommended to use open formats, such as `.csv` (comma-separated values) or `.tsv` (tab-separated values), as they are compatible with a wider range of software tools and more likely to be readable in the future.

R has built-in commands for reading in these files, but we will use the package [readr](https://readr.tidyverse.org/) from the tidyverse ecosystem, which can read most common formats. For our analysis, we will be reading in a `.csv` file. Let’s go ahead and [download the dataset](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/urban-demographic-data-r-ggplot2/sistercities.csv) and place it in our project's current working directory. You will need to load the `readr` library if you did not load the tidyverse earlier. Next, we can use the [`read_csv()`](https://readr.tidyverse.org/reference/read_delim.html) with the file path. Let’s go ahead and place the dataset in our project’s current working directory.
=======
## Our Data: Sister Cities in Europe

For this tutorial, we will look at [sister cities](https://en.wikipedia.org/wiki/Sister_city) around the world. Sister cities are pairs of cities located in different countries with a partnership to promote cultural and commercial ties. The modern concept of sister cities was conceived after World War II to foster friendship and understanding between different cultures and to promote trade and tourism. These partnerships can often involve student exchanges, business relationships, and cultural events. As historians, we can leverage data on sister cities to explore new questions about international connections and their implications. By examining this data, we can investigate whether regional, cultural, economic, or religious factors influence the formation of sister-city partnerships. For instance, we can assess if geographic proximity, shared language, or similar population size play a role in the likelihood of two cities establishing a relationship. We can also explore whether historical tensions or alliances, such as those between Germany, France, and Poland, or the shared linguistic heritage of Spanish-speaking cities in the Americas, shape these partnerships. Historians are looking more carefully at this kind of interactions in the last years (see for instance the [https://www.cambridge.org/core/journals/urban-history/issue/62C6F87B847CEFABB93598C340D8B144](*Urban History*, Volume 51, Issue 4: *Twinned cities: reconciliation and reconstruction in Europe after 1945* , November 2024)).

 The first question which arises is: where can we get as historians data about sister (or twinned) cities? One possibility is to see into one of the biggest repositories of data in the world:[Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page). Every single town in the world has an unique identifier and a page with all related information. If you look for instance at the page devoted to [https://www.wikidata.org/wiki/Q84](London) you will see, among other data, a list of the 'twinned administrative body'. Using the [SPARQL Protocol And RDF Query Language](https://en.wikibooks.org/wiki/SPARQL) we can make queries against these data and extract information about the towns associated with London. 

 We have made a lot of different queries to extract data about towns and their sister cities from different countries in Europe. More precisely, we created a dataset containing the following data: the name, country, population and geographical coordinates of the "origin city" and the same data about the "destination city". We calculated also the distance between the two towns and we add a boolean column whether the "destination city" is also in the European Union or not (all "origin cities" are in the European Union).

Our approach will be largely [exploratory](https://en.wikipedia.org/wiki/Exploratory_data_analysis), aiming to identify patterns, trends, and relationships in the data. We hope that we can uncover new insights and generate hypotheses for further research by doing so. You can download the dataset at [this link](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/urban-demographic-data-r-ggplot2/sistercities.csv).

### Loading Data with readr

Before importing data, it is important to understand how it may be formatted. Common spreadsheet applications, such as Microsoft Excel or Apple Numbers, place data in a proprietary format.  While there are packages to read in Excel data, such as [readxl](https://readxl.tidyverse.org/), it is recommended to use open formats, such as `.csv` (comma-separated values) or `.tsv` (tab-separated values) whenever possible. This has the advantage of being more accessible and compatible with a wider range of software tools. Additionally, these formats are more likely to be readable in the future as they are not tied to any specific application or version.

R has built-in commands for reading in these files, but we will use the package [readr](https://readr.tidyverse.org/) from the tidyverse ecosystem. `readr` can read most of the common formats you will encounter. For our particular dataset, we will be reading in a `.csv` file. Let’s go ahead and [download the dataset](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/urban-demographic-data-r-ggplot2/sistercities.csv) and place it in our project's current working directory.  We will first need to load the readr library. Next, we can use the [`read_csv()`](https://readr.tidyverse.org/reference/read_delim.html) with the file path. Let’s go ahead and place the dataset in our project’s current working directory.
>>>>>>> 7c3b2730 (update local branch)

```

eudata<-read_csv("sistercities.csv")

```

Let's take a look at our data:

```

eudata

# A tibble: 13,081 x 15

[etc]

```

<<<<<<< HEAD
As you can see, the tidyverse converts our data to a "tibble" rather than a "data frame." Tibbles are a part of the tidyverse universe that serve the same function as data frames but make decisions on the backend about importation and how R displays the data. R is a relatively old language, and as a result, defaults that made sense during the original implementation are often less helpful now. Tibbles, unlike data frames, do not change variable names, convert the input type, or create row names. You can learn more about tibbles [here](https://r4ds.had.co.nz/tibbles.html). If this does not make sense, don't worry! In most cases, we can treat tibbles like data frames and easily convert between the two. If you need to convert your data frame to a tibble, use the `as_tibble()` function with the data frame's name as the parameter. Likewise, to convert back to a data frame, use the `as.data.frame()` function.

We will start by exploring the data of six EU countries: Germany, France, Poland, Hungary, Portugal, and Bulgaria (three Western European countries and three Eastern European countries). As you saw above, we have a tibble called "eudata" with six countries that contains 13081 rows with 12 variables.

The tibble contains comprehensive information combining urban and demographic data about sister city relationships. The urban data includes information about both origin and destination cities (`origincity`, `destinationcity`), their respective countries (`origincountry`, `destinationcountry`), and their geographical coordinates (`originlat`, `originlong`, `destinationlat`, `destinationlong`). We also have information about the distance between paired cities (`dist`) and their administrative relationship status (`eu`). For demographic analysis, we have population data for both origin and destination cities (`originpopulation`, `destinationpopulation`). This combination of urban data about city locations and relationships, together with demographic data about population sizes, allows us to explore how city characteristics and population patterns influence partnerships.

## Creating Our First Graph

Let's begin by exploring an urban pattern that connects to broader questions about European integration and international relations: Do European cities tend to form stronger sister-city relationships with cities in the same country, in other EU countries, or outside the EU? This question helps us understand not just sister city relationships but larger historical processes like post-war reconciliation, European identity development, and urban diplomacy's changing nature. Similar visualization techniques could be used to study other international relationships, such as trade partnerships, cultural exchanges, or diplomatic missions.
=======
As you can see, the tidyverse converts our data to a "tibble" rather than a "data frame." Tibbles are a part of the tidyverse universe that serve the same function as data frames but make decisions on the backend about importation and how R displays the data.

R is a relatively old language, and as a result, defaults that made sense during the original implementation are less helpful now. Tibbles, unlike data frames, do not change the name of variables, convert the type of input, or create row names. You can learn more about tibbles [here](https://r4ds.had.co.nz/tibbles.html). If this does not make sense, don't worry! In most cases, we can treat tibbles exactly like data frames and easily convert between the two. If you need to convert your data frame to a tibble, use the `as_tibble()` function with the data frame's name as the parameter. Likewise, to convert back to a data frame, use the `as.data.frame()` function.

We will start by exploring the data of six EU countries: Germany, France, Poland, Hungary, Portugal, and Bulgaria (three Western European countries and three Eastern European countries). As you saw above, we have a tibble called "eudata" with six countries that contains 13081 rows with 12 variables.

The tibble contains comprehensive information about sister city relationships. As already mentioned, for each pair of cities, we have data on the origin city (`origincity`) and its corresponding country (`origincountry`), along with its geographical coordinates (`originlat` and `originlong`) and population (`originpopulation`). Similarly, we have the same set of information for the destination city: the city name (`destinationcity`), country (`destinationcountry`), coordinates (`destinationlat` and `destinationlong`), and population (`destinationpopulation`).

In addition to the city-specific data, the tibble provides two more variables that offer insights into the nature of the sister-city relationships. The dist column indicates the distance between the two cities in kilometers, allowing us to explore the role of proximity in these partnerships. Lastly, the eu column is a categorical variable that informs us whether the destination city is located within the European Union or not, enabling us to investigate potential patterns related to the EU.

## Creating Our First Graph

Let's begin by exploring a specific question: Do European cities tend to form stronger sister-city relationships with cities in the same country, cities in other EU countries, or cities outside the EU? To investigate this, we can create a bar plot that visualizes the percentage of destination cities falling into these three categories.
>>>>>>> 7c3b2730 (update local branch)

In ggplot2, we begin with the following code:

```

ggplot(eudata, aes(x = typecountry)) +
<<<<<<< HEAD

geom_bar()
=======
   geom_bar()
>>>>>>> 7c3b2730 (update local branch)

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-01.png" alt="A bar graph showing the total count of destination cities that are domestic, EU, and non-EU" caption="Figure 1. Bar graph showing the total count of destination cities that are domestic, EU, and non-EU)" %}

<<<<<<< HEAD
The first parameter of the `ggplot()` function is the tibble or data frame containing the information we are exploring, while the second parameter reflects the “aesthetics” of the graph. As you may recall from earlier, "aesthetics" defines the variables in our data and how we want to map them to visual properties. These two are the basis of any plot.

The `geom()` (from geometries) layer tells ggplot2 the type of graph we want to produce. Since we want to create a barplot, we need the `geom_bar()` layer, which is done by adding the `+` command.

Understanding the `ggplot()` syntax can be tricky at first, but once it makes sense, you can see the power of the standardized grammar of graphics framework that underpins ggplot2. One way you can think of this grammar is to view the creation of plots like constructing a sentence. In our example, we told R: "Create a ggplot graph using the data in eudata and map the variable typecountry to x and add a layer called `geom_bar()`." This structure is relatively straightforward except for using [`aes()`](http://ggplot2.tidyverse.org/reference/aes.html). It is not a telling expression, but the idea is simple: we tell R to map variables in the data to visual properties (aesthetics) of geoms in the graph. Again, do not panic if you do not understand it completely. We will go into more depth later.

We now have our first plot! You may notice ggplot2 has made some decisions on its own: background color, font size of the labels, etc. The default settings are usually sufficient, but we can customize these aspects if needed.

Because we are working within a consistent syntax, we can modify our plots to look different or display different data. For instance, say we want percentages rather than raw counts. Using the following code, we create a new tibble that calculates the percentage and adds a new column named `perc` with the percentage values (again, see the [tutorial Data Wrangling and Managment in R](https://programminghistorian.org/lessons/data_wrangling_and_management_in_R) about dplyr for details if this code does not make sense to you). Once we have done so, we only need to make a few changes :
=======
The first parameter of the `ggplot()` function is the tibble or data frame containing the information we are exploring, while the second parameter reflects the “aesthetics” of the graph. Aesthetics, as you may recall from earlier, defines the variables in our data and how we want to map them to visual properties. These two are the basis of any plot.

The `geom()` (from geometries) layer tells ggplot2 the type of graph we want to produce. Since we want to create a barplot, we need the `geom_bar()` layer, which is done by adding the `+` command.

Understanding the `ggplot()` syntax can be tricky at first, but once it makes sense, you can see the power of the standardized grammar of graphics framework that underpins ggplot2. One way you can think of this grammar is to view the creation of plots like constructing a sentence. In our example, we told R: "Create a ggplot graph using the data in eudata and map the variable typecountry to x and add a layer called `geom_bar()`." This structure is straightforward except for using [`aes()`](http://ggplot2.tidyverse.org/reference/aes.html), which means in ggplot parlance aesthetics. It is not a telling expression, but the idea is simple: we tell R to map variables in the data to visual properties (aesthetics) of geoms in the graph. Again, do not panic if you do not understand it completely. We will go into more depth later.

We now have our first plot! You may notice that ggplot2 has made some decisions on its own: background color, font size of the labels, etc. The default settings are usually sufficient, but we can customize these aspects if needed.

Because we work within a consistent syntax, we can easily modify our plots to look different or display different data. For instance, let’s say we want to look at percentages rather than raw counts. Using the following code, we can create a new tibble that calculates the percentage and adds a new column named perc with the percentage values (again, see the [tutorial Data Wrangling and Managment in R](https://programminghistorian.org/lessons/data_wrangling_and_management_in_R) about dplyr for details if this code does not make sense to you). Once we have done so, we only need to make a few changes :
>>>>>>> 7c3b2730 (update local branch)

```

# Aggregate the data per type of country and add a new column with percentages

eudata.perc <- eudata %>%

<<<<<<< HEAD
group_by(typecountry) %>%

summarise(total = n()) %>%

mutate(perc = total/sum(total))

ggplot(data = eudata.perc, aes(x = typecountry, y = perc)) +

geom_bar(stat = "identity")
=======
   group_by(typecountry) %>%

   summarise(total = n()) %>%

   mutate(perc = total/sum(total))

ggplot(data = eudata.perc, aes(x = typecountry, y = perc)) +

   geom_bar(stat = "identity")
>>>>>>> 7c3b2730 (update local branch)

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-02.png" alt="Bar graph showing percentage of destination cities that are domestic, EU, and non-EU." caption="Figure 2. Bar graph showing percentage of destination cities that are domestic, EU, and non-EU" %}

<<<<<<< HEAD
There is an important difference between the first plot and this one. In the previous plot, ggplot2 counted the number of cities in every group. In our new plot, the tibble contains the values for the bars. This information is in the column perc, so we add `y = perc` as a parameter of `aes()`, but this is not enough. The tricky part is that by default, geom_bar() will use the parameter stat = "count." This means it will count how many times a value appears. In other words, it aggregates data for you. Since we already aggregated the data, we inform ggplot2 we have already calculated our values by using the parameter `stat = "identity"`.

We see most sister cities are in the EU. This could be due to geographical proximity, cultural similarities, or economic ties within the European Union. We can compare data by country of origin to look into this more. Once we have calculated the percentages for each country, we can visualize it in two ways. One, we can create a bar for every country. Two, we can make a separate graph for each country ('facetting' in ggplot2 parlance). For now, we will stick with the first approach.
=======
There is an important difference between the first plot and this one. In the previous plot, ggplot2 counted the number of cities in every group. In our new plot, the tibble contains the values for the bars. This information is in the column perc, so we add `y = perc` as a parameter of `aes()`, but this is not enough. The tricky part is that by default `geom_bar()` will use the parameter `stat = "count"`. This means that it will count how many times a value appears. In other words, it aggregates the data for you. Since the data is already aggregated, we inform ggplot2 that we have already calculated the values in the column by using the parameter `stat = "identity"`.

We see that most sister cities are in the EU. This could be due to geographical proximity, cultural similarities, or economic ties within the European Union. To look into this more, we can compare the data by country of origin. Once we have calculated the percentages for each country, we can visualize it in two ways. One, we can create a a bar for every country. Two, we can make a separate graph for each country ('facetting' in ggplot2 parlance). For now, we will stick with the first approach.
>>>>>>> 7c3b2730 (update local branch)

```

# We aggregate the data per country and type of country and add a new column with percentages

<<<<<<< HEAD
`eudata.perc.country` <- eudata %>%

group_by(origincountry, typecountry) %>%

summarise(total = n()) %>%

mutate(perc = total/sum(total))

ggplot(data = `eudata.perc.country`, aes(x = typecountry, y = perc, fill = origincountry)) +

geom_bar(stat = "identity", position="dodge")
=======
eudata.perc.country <- eudata %>%

   group_by(origincountry, typecountry) %>%

   summarise(total = n()) %>%

   mutate(perc = total/sum(total))

ggplot(data = eudata.perc.country, aes(x = typecountry, y = perc, fill = origincountry)) +

   geom_bar(stat = "identity", position="dodge")
>>>>>>> 7c3b2730 (update local branch)

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-03.png" alt="Bar graph showing the percentage of destination cities that are domestic, EU, and non-EU with aggregated data per country and type of country." caption="Figure 3. Bar graph showing the percentage of destination cities that are domestic, EU, and non-EU with aggregated data per country and type of country." %}

<<<<<<< HEAD
Again, we created a tibble that contained data aggregating per country and destination city type (EU, non-EU, etc.). We mapped the `origincountry` column to the fill aesthetic in the `ggplot()` command, which defines the color range of bars. We also added the parameter position to `geom_bar(`) so that the bars do not get stacked (which is the default) but are instead placed side by side.

Now that we have visualized urban relationships (partnerships between cities) and demographic patterns (population sizes), we can analyze how these two aspects of our data interact.

The bar plot reveals that most countries in our analysis, such as Germany, France, and Hungary, strongly prefer to establish sister city relationships with other European Union countries, with approximately 70-80% of their partnerships in the EU. However, two countries stand out as exceptions: Bulgaria and Portugal. The proportion of sister city relationships with EU and non-EU countries is roughly equal for these countries. This suggests that Bulgaria and Portugal have a more balanced approach to forming partnerships that involve actively engaging with cities outside the European Union.

In the case of Portugal, this more global outlook might be attributed to its colonial history. Portugal's extensive colonial past may have fostered long-lasting cultural, linguistic, and economic ties with cities in its former colonies, such as those in Brazil, Angola, and Mozambique.

As for Bulgaria, further investigation is needed to uncover the factors contributing to Bulgaria's relatively high percentage of non-EU sister city partnerships. Possible explanations include its geographic location at the edge of the European Union, its cultural and linguistic ties to countries in the Balkans and Eastern Europe, or its economic relationships with countries outside the EU.

While these initial observations provide a starting point for understanding relationship patterns, it is essential to delve deeper into each country's historical, cultural, and political context to comprehend the underlying reasons for these trends.

## Other Geoms: Histograms, Distribution Plots and Boxplots

We have seen the key syntax needed to operate ggplot2: adding layers and parameters to those layers. One of the most important layers is geoms. Using this layer is straightforward in ggplot2: every plot type has a geom that can be added to `ggplot()`. For [histograms](http://ggplot2.tidyverse.org/reference/geom_histogram.html), we have `geom_histogram()`, for [boxplots](http://ggplot2.tidyverse.org/reference/geom_boxplot.html) `geom_boxplot()`, for [violin plots](http://ggplot2.tidyverse.org/reference/geom_violin.html) `geom_violin()`, for [dotplots](http://ggplot2.tidyverse.org/reference/geom_dotplot.html) `geom_dotplot()`, for [scatterplot](http://ggplot2.tidyverse.org/reference/geom_point.html) `geom_point()`, and so on. Every command has parameters that let us configure aspects of the `geom()`, such as size and color.

To get practice with these geoms, let's create a histogram to visualize an important urban characteristic between sister cities. This spatial aspect of urban relationships can help us understand how geographic proximity influences city partnerships.
=======
Again, we created a new tibble that contained data aggregating per country and destination city type (EU, non-EU, etc).  We mapped the origincountry column to the fill aesthetic in the ggplot() command, which defines the color range of the bars. We also added the parameter position to `geom_bar(`) so that the bars do not get stacked (which is the default) but are instead placed side by side. Again, ggplot2 has chosen sensible defaults regarding colors and legend placement. 

Now that we have visualized the data, we can analyze the patterns and draw insights from the graph. The bar plot reveals that the majority of the countries in our analysis, such as Germany, France, and Hungary, strongly prefer to establish sister city relationships with other European Union countries. Approximately 70-80% of their partnerships are with cities in the EU.

However, two countries stand out as exceptions: Bulgaria and Portugal. The proportion of sister city relationships with EU and non-EU countries is roughly equal for these countries. This suggests that Bulgaria and Portugal have a more balanced approach to forming partnerships that involve actively engaging with cities outside the European Union.

In the case of Portugal, this more global outlook might be attributed to its colonial history. Portugal's extensive colonial past may have fostered long-lasting cultural, linguistic, and economic ties with cities in its former colonies, such as those in Brazil, Angola, and Mozambique. These historical connections could explain Portugal's higher proportion of sister city relationships with non-EU countries than other European nations.

As for Bulgaria, further investigation is needed to uncover the factors contributing to its relatively high percentage of non-EU sister city partnerships. Possible explanations could include its geographic location at the edge of the European Union, its cultural and linguistic ties to countries in the Balkans and Eastern Europe, or its economic relationships with countries outside the EU.

While these initial observations provide a starting point for understanding the patterns of sister-city relationships, it is essential to delve deeper into each country's historical, cultural, and political context to fully comprehend the underlying reasons for these trends.

## Other Geoms: Histograms, Distribution Plots and Boxplots

We have seen the key syntax needed to operate ggplot2: adding layers and parameters to those layers. One of the most important layers is the geoms. Using this layer is straightforward in ggplot2: every plot type has a geom that can be added to `ggplot()`. For [histograms](http://ggplot2.tidyverse.org/reference/geom_histogram.html), we have `geom_histogram()`, for [boxplots](http://ggplot2.tidyverse.org/reference/geom_boxplot.html) `geom_boxplot()`, for [violin plots](http://ggplot2.tidyverse.org/reference/geom_violin.html) `geom_violin()`, for [dotplots](http://ggplot2.tidyverse.org/reference/geom_dotplot.html) `geom_dotplot()`, for [scatterplot](http://ggplot2.tidyverse.org/reference/geom_point.html) `geom_point()`, and so on. Every command has parameters that let us configure aspects of the `geom()`, such as size and color.

To get practice with these geoms, let's create a histogram to visualize the distribution of the variable dist in our data, which represents the distance in kilometers between all of our sister cities. 
>>>>>>> 7c3b2730 (update local branch)

```

# Filter the data and visualize it

# Load tidyverse or dplyr, otherwise filter will throw an error!

eudata.filtered <- filter(eudata, dist < 5000)

ggplot(eudata.filtered, aes(x=dist)) + geom_histogram()

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-04.png" alt="Histogram showing distances (in log10) between sister cities." caption="Figure 4. Histogram showing distances (in log10) between sister cities." %}

<<<<<<< HEAD
As you see, we only needed to add `geom_histogram()` to create a histogram. However, making a good histogram involves determining a bin size that makes sense for the data. The bin size, also known as the interval or bandwidth, refers to the width of each bar. It determines how data is grouped and displayed. In the example histogram we created, ggplot2 displays a warning that it has defaulted our binwidth to 30 (`bins=30`) and recommends picking a better value. Explore the help page of [`geom_histogram()`](http://ggplot2.tidyverse.org/reference/geom_histogram.html) to look at more configuration possibilities.

However, even with this initial graph, we see the variable `dist` distribution is skewed with only a few cities far away. The skewness of this urban variable (`dist`) has implications for our analysis. It suggests that while most sister cities tend to be geographically close, there are exceptions where cities establish partnerships with far-off counterparts. 

We can use a [cumulative distribution function (ECDF)](https://en.wikipedia.org/wiki/Empirical_distribution_function) to gain additional insights into this urban pattern and better understand the spatial distribution of sister-city relationships. This type of plot shows us how urban connections are distributed across different distances. The ECDF can also assess whether the skewness observed is a genuine feature of the data or a result of bin size. If the ECDF shows a similar pattern of skewness, with a steep increase on the left and a more gradual increase on the right, it would confirm skewness is an inherent characteristic of the `dist` variable. In ggplot2, we can create an ECDF by adding the `stat_ecdf()` layer to our plot. Here's an example:
=======
As you see, we only needed to add the layer `geom_histogram()` to create a histogram. However, making a good histogram involves determining a bin size that makes sense for the data. The bin size, also known as the interval or bandwidth, refers to the width of each bar in the histogram. It determines how the data is grouped and displayed. In the example histogram we created, ggplot2 displays a warning that it has defaulted our binwidth to 30 (`bins=30`) and recommends picking a better value with binwidth. This suggests that the default bin size chosen by ggplot2 may not be optimal for our data, and we should consider adjusting it to create a more informative and meaningful histogram. Explore the help page of [`geom_histogram()`](http://ggplot2.tidyverse.org/reference/geom_histogram.html) to look at more configuration possibilities.

However, even with this initial graph though, we can see that the distribution of the variable dist is skewed with only a few cities far away. The skewness of the dist variable has important implications for our analysis. It suggests that while most sister cities tend to be geographically close, there are notable exceptions where cities establish partnerships with far-off counterparts. To understand why this is the case, we need further investigation. For instance, we could look into the specific characteristics of the cities involved in these long-distance partnerships, exploring the historical and contemporary contexts that have shaped these connections, and comparing them to the more common short-distance relationships.

We can use a [cumulative distribution function (ECDF)](https://en.wikipedia.org/wiki/Empirical_distribution_function) to gain additional insights into the distribution of the dist variable and help us better understand the skewness we observed in the histogram. This type of plot shows the proportion of data points that are less than or equal to a given value—in other words, the cumulative probability distribution of a variable. Through this, we can better understand the proportion of sister cities that fall within specific distance ranges. For example, we can easily determine the percentage of sister cities located within 1000 kilometers of each other or identify the median distance between sister cities.

The ECDF can also help us assess whether the skewness we observed in the histogram is a genuine feature of the data or a result of the chosen bin size. If the ECDF shows a similar pattern of skewness, with a steep increase on the left side and a more gradual increase on the right, it would confirm that the skewness is an inherent characteristic of the dist variable. In ggplot2, we can create an ECDF by adding the `stat_ecdf()` layer to our plot. Here's an example:
>>>>>>> 7c3b2730 (update local branch)

```

ggplot(eudata.filtered, aes(x=dist)) + stat_ecdf()

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-05.png" alt="ECDF Graph showing the distances between sister cities." caption="Figure 5. ECDF Graph showing the distances between sister cities." %}

<<<<<<< HEAD
Let's examine the ECDF plot we created using the unfiltered `eudata` data frame. The plot confirms our previous observation about the skewed distribution. Approximately 75% of the cities have sister-city relationships within a radius of around 1000 kilometers. Even more intriguing is that roughly 50% of the cities are connected to sister cities no more than 500 kilometers away.

Lastly, we will create a boxplot to compare how different countries structure their urban relationships across space. This visualization helps understand whether certain countries tend to form more localized urban networks while others maintain broader geographic connections. By comparing the distribution of distances, we can identify national patterns in how cities build their international relationships.
=======
Let's examine the ECDF plot we created using the unfiltered eudata data frame. The plot confirms our previous observation about the skewed distribution of distances between sister cities. Approximately 75% of the cities have sister-city relationships within a radius of around 1000 kilometers. This finding reinforces that geographic proximity plays a significant role in forming sister-city partnerships. Even more intriguing is that roughly 50% of the cities appear to be connected to sister cities that are no more than 500 kilometers away.

Lastly, we can create a boxplot to compare the distribution of distances between sister cities across different countries. We can then easily identify differences in the median distances, the spread of the data, and the presence of outliers for each country.  For example, if we observe that the boxplot for a particular country has a higher median distance and a larger spread than other countries, it would suggest that cities in that country are more likely to form partnerships with distant cities than others. On the other hand, if a country's boxplot shows a lower median distance and a smaller spread, it would indicate a tendency for cities in that country to establish relationships with closer cities than others.
>>>>>>> 7c3b2730 (update local branch)

```

ggplot(eudata.filtered, aes(x = origincountry, y = dist)) + geom_boxplot()

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-06.png" alt="Boxplots showing distances (in km) between sister cities of different countries." caption="Figure 6. Boxplots showing distances (in km) between sister cities of different countries." %}

<<<<<<< HEAD
The boxplot comparing the distances between sister cities across different countries reveals an interesting pattern for German cities. The plot shows German cities tend to establish sister-city relationships with cities geographically closer, as indicated by the lower median distance and smaller spread of the boxplot for Germany compared to other countries. This could reflect Germany's position as a central and well-connected country within Europe as its geographic location and strong economic ties with its neighbors could facilitate the formation of regional partnerships and encourage cities to seek out connections within a smaller radius.

## Advanced Manipulations Regarding the Look of Graphs

We played with different geoms but relied on ggplot2's decisions regarding the graph's look. However, we often want to change this for various reasons, such as improving readability, highlighting specific aspects of the data, or adhering to specific style guidelines. ggplot2 offers a wide range of customization options to fine-tune the appearance of our plots. To see how we can do this, we will start with a simple plot and build on it step by step.

Let's explore how demographic characteristics influence urban relationships by examining the relationship between sister cities' populations. This analysis connects to broader historical questions about how city size affects international influence, how urban hierarchies develop, and how demographic patterns shape cultural and economic exchanges. Similar approaches could be used to study historical questions about urbanization patterns, the development of metropolitan regions, or the relationship between population size and economic development.

We will begin by creating a scatterplot visualizing the population data for origin and destination cities. A scatterplot is a graph that uses dots or points to represent the values of two variables for each observation. In this case, each point on the scatterplot will represent a sister city pair, with the x-coordinate indicating the population of the origin city and the y-coordinate representing the population of the destination city. If we observe a clear positive trend, with points clustering along a diagonal line from the bottom left to the top right of the plot, it suggests that cities with similar populations form relationships.

Since `eudata` has many points, this could lead to overplotting. Therefore, we will use a random sample of 15% of the cities in our data frame with the function [`sample_frac()`](http://dplyr.tidyverse.org/reference/sample.html). We will also use the natural log of the population data to overcome skewness. Since we are looking at a random data selection, we must set a seed to ensure reproducibility. We can do this with the `set.seed()` function. This way, if you run the code again, you will get the same random sample.

```

=======
The boxplot comparing the distances between sister cities across different countries reveals an interesting pattern for German cities. The plot shows that German cities tend to establish sister-city relationships with cities that are geographically closer to them, as indicated by the lower median distance and smaller spread of the boxplot for Germany compared to other countries. This could reflect Germany's position as a central and well-connected country within Europe. Germany's geographic location and strong economic ties with its neighbors could facilitate the formation of regional partnerships and encourage cities to seek out connections within a smaller radius.

## Advanced Manipulations Regarding the Look of Graphs

We played with different geoms, but we often relied on decisions ggplot2 made regarding the look of the graph. However, we often want to change this for various reasons, such as improving readability, highlighting specific aspects of the data, or adhering to specific style guidelines. `ggplot2` offers a wide range of customization options to fine-tune the appearance of our plots. To see how we can do this, we will start with a simple plot and build on it step by step.

Let's explore the relationship between the populations of sister cities. Our dataset includes information on the population of both the origin and destination cities for each sister-city pair. This raises an interesting question: Is population a related variable in sister-city relationships? In other words, do smaller cities tend to form partnerships with other small cities, while larger cities are more likely to connect with other large cities?

To investigate this question, we can create a scatterplot that visualizes the population data for the origin and destination cities. A scatterplot is a graph that uses dots or points to represent the values of two variables for each observation in a dataset. In this case, each point on the scatterplot will represent a sister city pair, with the x-coordinate indicating the population of the origin city and the y-coordinate representing the population of the destination city. By examining the pattern of points on the scatterplot, we can gain insights into the relationship between the populations of sister cities. If we observe a clear positive trend, with points clustering along a diagonal line from the bottom left to the top right of the plot, it suggests that cities with similar population sizes form sister-city relationships. 

Since the data frame eudata has many points, this could lead to overplotting. Therefore, we will a random sample of 15% of the cities in our dataframe with the function [`sample_frac()`](http://dplyr.tidyverse.org/reference/sample.html). We also use the natural log of the population data to overcome skewness.

Since we are looking at a random selection of the data, we need to set a seed to ensure reproducibility. We can do this with the `set.seed()` function. Thus, if you run the code again, you will get the same random sample.

```
>>>>>>> 7c3b2730 (update local branch)
# Set seed to assure reproducibility

set.seed(123)

# We extract a random sample of 15% of the cities

eudata.sample <- sample_frac(eudata, 0.15)

# we create the plot

ggplot(data = eudata.sample,

<<<<<<< HEAD
aes(x = log(originpopulation),

y = log(destinationpopulation))) +

geom_point()
=======
      aes(x = log(originpopulation),

          y = log(destinationpopulation))) +

      geom_point()
>>>>>>> 7c3b2730 (update local branch)

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-07.png" alt="Scatterplot displaying the relationship of population (in log10) in 15% of the sister cities that were randomly selected." caption="Figure 7. Scatterplot displaying the relationship of the population (in log10) in the sister cities that were randomly selected." %}

<<<<<<< HEAD
Now that we have created a basic plot, we can explore how to change its look. We will begin by changing the size and color of the points to have static values. 
=======
Now that we have created a basic plot, we can explore how to change its look. We will begin by changing the size and color of the points to have static values. We could also map a column, allowing them to vary based on the data. 
>>>>>>> 7c3b2730 (update local branch)

```

ggplot(data = eudata.sample,

<<<<<<< HEAD
aes(x = log(originpopulation),

y = log(destinationpopulation))) +

geom_point(size = 3, color = "red")
=======
      aes(x = log(originpopulation),

          y = log(destinationpopulation))) +

      geom_point(size = 3, color = "red")
>>>>>>> 7c3b2730 (update local branch)

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-08.png" alt="Changing the size and color of the points of a scatterplot." caption="Figure 8. Changing the size and color of the points of a scatterplot." %}

As you can see, we passed the function `geom_point()` different arguments (`size` and `color`/`colour`). To find out other arguments that are available, you can visit the help page of `geom_point()` by typing `?geom_point` in R or here [online](http://ggplot2.tidyverse.org/reference/geom_point.html).

<<<<<<< HEAD
The plot looks a bit better, but we may want to add titles to the axes. Manipulating axes (and legends) is done by using the corresponding scales functions, which we will cover later on. But since changing the titles is a very common action, ggplot has a shorter command to achieve it: [`labs()`](http://ggplot2.tidyverse.org/reference/labs.html) (which stands for labels):
=======
The plot looks a bit better, but many things remain to improve. For instance, we can add titles to the axes. Manipulating axes (and legends) is done by using the corresponding scales functions, which we will cover later on. But since changing the titles is a very common action, ggplot has a shorter command to achieve it: [`labs()`](http://ggplot2.tidyverse.org/reference/labs.html) (which stands for labels):
>>>>>>> 7c3b2730 (update local branch)

```

ggplot(data = eudata.sample,

<<<<<<< HEAD
aes(x = log(originpopulation),

y = log(destinationpopulation))) +

geom_point(size = 3, color = "red") +

labs(title = "Population data of origin and destination city",

caption = "Data: [www.wikidata.org](http://www.wikidata.org)",

x = "Population of origin city (log)",

y = "Population of destination city (log)")
=======
      aes(x = log(originpopulation),

          y = log(destinationpopulation))) +

   geom_point(size = 3, color = "red") +

   labs(title = "Population data of origin and destination city",

        caption = "Data: www.wikidata.org",

        x = "Population of origin city (log)",

        y = "Population of destination city (log)")
>>>>>>> 7c3b2730 (update local branch)

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-09.png" alt="Scatterplot with added titles and caption using the labs() function." caption="Figure 9. Adding titles and caption with labs()." %}

Now that we are happy with our graph, we can save it:

```

ggsave("eudata.png")

# for getting a pdf

# ggsave("eudata.pdf")

```

This will create a [`.png`](https://en.wikipedia.org/wiki/Portable_Network_Graphics) file with the last plot we have constructed. The function `ggsave()` has [many parameters](http://ggplot2.tidyverse.org/reference/ggsave.html) you can also adjust if needed (dpi, height, width, format, etc.).

<<<<<<< HEAD
Sometimes, we want to enhance our graph by encoding additional information using different colors or shapes. This is particularly useful when we have categorical variables we want to visualize alongside the main variables of interest. In the scatterplot, we used static values for size and color. However, we can map these aesthetic properties to specific columns in our data to represent different categories.

For instance, say we want to color the points in our scatterplot to distinguish different relationships based on the destination city location. Our dataset has a categorical variable called `typecountry` , indicating whether the destination city is in the same country as the origin city, in another EU country, or a non-EU country. To incorporate this information, we map the typecountry variable to the color aesthetic by passing the `aes()` function to `geom_point()`:
=======
Sometimes, we may want to enhance our graph by encoding additional information using different colors or shapes. This is particularly useful when we have categorical variables in our data that we want to visualize alongside the main variables of interest. In the previous scatterplot example, we used static values for the size and color of the points. However, we can map these aesthetic properties to specific columns in our data to represent different categories.

For instance, let's say we want to color the points in our scatterplot to distinguish between different types of sister city relationships based on the location of the destination city. Our dataset has a categorical variable called typecountry that indicates whether the destination city is in the same country as the origin city, in another EU country, or in a non-EU country. To incorporate this information into our scatterplot, we can map the typecountry variable to the color aesthetic by passing the `aes()` function to `geom_point()`:
>>>>>>> 7c3b2730 (update local branch)

```

ggplot(data = eudata.sample,

<<<<<<< HEAD
aes(x = log(originpopulation),

y = log(destinationpopulation))) +

geom_point(size = 3, alpha = 0.7, aes( color = typecountry )) +

labs(title = "Population data of origin and destination city",

caption = "Data: [www.wikidata.org](http://www.wikidata.org)",

x = "Population of origin city (log)",

y = "Population of destination city (log)")
=======
      aes(x = log(originpopulation),

          y = log(destinationpopulation))) +

   geom_point(size = 3, alpha = 0.7, aes( color = typecountry )) +

   labs(title = "Population data of origin and destination city",

        caption = "Data: www.wikidata.org",

        x = "Population of origin city (log)",

        y = "Population of destination city (log)")
>>>>>>> 7c3b2730 (update local branch)

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-10.png" alt="Scatterplot using colors to distinguish different types of sister city relationships based on the location of the destination city." caption="Figure 10. Using colors in scatterplots for showing different countries." %}

<<<<<<< HEAD
Above, we did two major manipulations. First, we modified `geom_point()` by adding an argument: `aes(color = typecountry)`. Since there are too many points, we added the parameter alpha to make them transparent. Again, ggplot2 has selected sensible default colors and legends for the graph.

### Scales: Colors, Legends, and Axes

It's time to look at the scales function in ggplot2. Scales are crucial in determining how data is mapped to visual properties. They provide data transformation for position, size, color, and shape aesthetics. Additionally, scales define how aesthetics are displayed on the plot, including the range of values, the breaks or tick marks, and the labels.

In ggplot2, scales follow a naming convention consisting of three parts separated by underscores:
=======
Above, we did two major manipulations to this plot. First, we modified `geom_point()` by adding an argument: `aes(color = typecountry)`. Since there are too many points, we added the parameter alpha to make them transparent. Again, ggplot2 has selected sensible default colors and legends for the graph.

### Scales: Colors, Legends, and Axes

It's time to look at the scales function in ggplot2. Scales play a crucial role in determining how data values are mapped to a plot's visual properties. They control data transformation into position, size, color, and shape aesthetics. Additionally, scales define how these aesthetics are displayed on the plot, including the range of values, the breaks or tick marks, and the labels.

In ggplot2, scales follow a naming convention that consists of three parts separated by underscores:
>>>>>>> 7c3b2730 (update local branch)

1. The prefix "scale".

2. The name of the aesthetic being modified (e.g., color, shape, x, y).

2. The type of scale being applied (e.g., continuous, discrete, brewer).

For example, `scale_color_continuous()` is used to control the color aesthetic with a continuous scale, while `scale_shape_discrete()` is used to modify the shape aesthetic with a discrete scale.

<<<<<<< HEAD
One common use of scales is to change plot colors. We can manually specify colors using specific color values or predefined color scales. Let's store our previous plot in a variable to demonstrate this. This is a convenient way to create different versions of the same plot by modifying only certain aspects.
=======
One common use of scales is to change the colors of our plots. We can manually specify colors using specific color values or predefined color scales. Let's first store our previous plot in a variable to demonstrate this. This is a convenient way to create different versions of the same plot by modifying only certain aspects.
>>>>>>> 7c3b2730 (update local branch)

```

p1 <- ggplot(data = eudata.sample,

<<<<<<< HEAD
aes(x = log(originpopulation),

y = log(destinationpopulation))) +

geom_point(size = 3, alpha = 0.7, aes( color = typecountry )) +

labs(title = "Population data of origin and destination city",

caption = "Data: [www.wikidata.org](http://www.wikidata.org)",

x = "Population of origin city (log)",

y = "Population of destination city (log)")

```

Now that we have stored the plot in the variable `p1`, we can modify the color scale. To manually specify colors, we can use the `scale_color_manual()` function and provide a vector of color values. In this case, we will use colors that [R has already defined](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf). We can also use hexadecimal codes for specific colors. As you see, [`scale_colour_manual()`](http://ggplot2.tidyverse.org/reference/scale_manual.html) takes a compulsory argument (`values =`), namely a vector with the names of colors.
=======
      aes(x = log(originpopulation),

          y = log(destinationpopulation))) +

      geom_point(size = 3, alpha = 0.7, aes( color = typecountry )) +

      labs(title = "Population data of origin and destination city",

        caption = "Data: www.wikidata.org",

        x = "Population of origin city (log)",

        y = "Population of destination city (log)")

```

Now that we have stored the plot in the variable `p1`, we can easily modify the color scale. To manually specify colors, we can use the `scale_color_manual()` function and provide a vector of color values. In this case, we will use colors that [R has already defined](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf). We could also use hexadecimal codes for specific colors. As you see, [`scale_colour_manual()`](http://ggplot2.tidyverse.org/reference/scale_manual.html) takes a compulsory argument (`values =`), namely a vector with the names of colors.
>>>>>>> 7c3b2730 (update local branch)

```

p1 + scale_colour_manual(values = c("red", "blue", "green"))

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-11.png" alt="Scatter plot that uses scale_colour_manual() to change the colors of the scatterplot points." caption="Figure 11. Using scale_colour_manual() to change the colors of the scatterplot points." %}

<<<<<<< HEAD
In this way, we can create graphs with our preferred colors. However, using already defined color scales, such as the [color brewer palettes](http://colorbrewer2.org), when possible, is better. ggplot2 already has these [integrated](http://ggplot2.tidyverse.org/reference/scale_brewer.html) and a scale for using them (`scale_colour_brewer()`):
=======
In this way, we can create graphs with our preferred colors. But, it is better to use already defined color scales when possible, such as the [color brewer palettes](http://colorbrewer2.org/). ggplot2 has already these palettes [integrated](http://ggplot2.tidyverse.org/reference/scale_brewer.html) and a specific scale for using them (`scale_colour_brewer()`):
>>>>>>> 7c3b2730 (update local branch)

```

p1 + scale_colour_brewer(palette = "Dark2") # you can try others such as "Set1", "Accent", etc.

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-12.png" alt="Scatter plot that uses scale_colour_brewer() to change the colors of the scatterplot points." caption="Figure 12. Using scale_colour_brewer() to change the colors of the scatterplot points." %}

<<<<<<< HEAD
Let's look at a slightly different example. In the last graph, we used a qualitative variable (`typecountry`) with different colors. But what if we wanted to use a continuous variable such as the distance between cities (we will again use the log of the distance because of skewness). We want to use the intensity of red to represent distance:
=======
Let's look at a slightly different example. In the last graph, we used a qualitative variable (`typecountry`) with different colors. But, what if we wanted to use a continuous variable? Let's say we want to add information to our plot including the distance between the cities (we will again use the log of the distance because of skewness). We want to use the intensity of red to represent the distance:
>>>>>>> 7c3b2730 (update local branch)

```

p2 <- ggplot(data = eudata.sample,

<<<<<<< HEAD
aes(x = log(originpopulation),

y = log(destinationpopulation))) +

geom_point(size = 3, aes( color = log(dist) )) +

labs(title = "Population data of origin and destination city",

subtitle = "Colored by distance between cities",

caption = "Data: [www.wikidata.org](http://www.wikidata.org)",

x = "Population of origin city (log)",

y = "Population of destination city (log)")
=======
      aes(x = log(originpopulation),

          y = log(destinationpopulation))) +

      geom_point(size = 3, aes( color = log(dist) )) +

      labs(title = "Population data of origin and destination city",

        subtitle = "Colored by distance between cities",

        caption = "Data: www.wikidata.org",

        x = "Population of origin city (log)",

        y = "Population of destination city (log)")
>>>>>>> 7c3b2730 (update local branch)

p2

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-13.png" alt="Scatter plot showing population data of origin and destination city colored by distance between cities." caption="Figure 13. Population data of origin and destination city colored by distance between cities." %}

<<<<<<< HEAD
As you see, this graph has two problem:

1. Blue is the color used instead of red.

2. The scale is counterintuitive because smaller distances are represented by a darker blue, while we would expect shorter distances to be represented by lighter colors.

Using the appropriate scale function is crucial when working with different types of variables in ggplot2. It ensures that the visual representation of the data accurately reflects the nature of the variable and communicates the intended information.

In the previous example, we used a discrete color scale ([`scale_color_manual()`](http://ggplot2.tidyverse.org/reference/scale_manual.html)) to assign distinct colors to each level of a qualitative variable. This approach works well when dealing with categorical or factor variables, where each value represents a separate category or group. By assigning a unique color to each level, using [predefined R colors](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf) or hexadecimal codes, we can clearly distinguish between categories, highlighting their differences or similarities. However, using a discrete color scale may not be appropriate when working with continuous variables, such as distance. Continuous variables have a range of values within a certain interval. In such cases, using a gradient color scale is more suitable to represent the continuous nature of the data.

Gradient or continuous color scales assign colors to values based on a smooth transition between hues or shades. This allows for a more accurate representation of the continuous variable, as the gradual color change corresponds to the change in the variable's value. Using a gradient scale, we can visualize the distribution of values and identify patterns or trends in the data.

There are [several methods for creating gradient scales in ggplot2](http://ggplot2.tidyverse.org/reference/scale_gradient.html). For our purpose, we will use the `scale_colour_gradient()` function. This allows us to specify colors for the minimum and maximum values of the continuous variable, and ggplot2 automatically interpolates the colors for the intermediate values based on chosen gradient.

We can work with the p2 object created earlier and use the "+" operator to make modifications. We will map the `dist` variable, representing the distance between cities, to the color aesthetic using `color = dist` inside the `aes()` function. Next, we add the `scale_colour_gradient()` function to customize color gradient. We specify `low = "white"` to set the color for the lowest values of the dist variable to white and `high = "red3"` to set the highest values to dark red. This means lighter shades of red represent shorter distances, while darker shades represent longer distances.
=======
As you can see, there are two problems with this graph:

1. Blue is the color used instead of red, which is not what we intended.
2. The scale is counterintuitive because smaller distances are represented by a darker blue, while we would expect shorter distances to be represented by lighter colors.

Using the appropriate scale function is crucial when working with different types of variables in ggplot2. It ensures that the visual representation of the data accurately reflects the nature of the variable and effectively communicates the intended information to the viewer.

In the previous example, we used a discrete color scale (`scale_color_manual()`) to assign distinct colors to each level of a qualitative variable. This approach works well when dealing with categorical or factor variables, where each value represents a separate category or group. By assigning a unique color to each level, we can clearly distinguish between different categories and highlight their differences or similarities. However, using a discrete color scale may not be the most appropriate choice when working with continuous variables, such as distance between cities. Continuous variables have a range of values that can take on any value within a certain interval. In such cases, using a gradient color scale is more suitable to represent the continuous nature of the data.

Gradient or continuous color scales assign colors to values based on a smooth transition between different hues or shades. This allows for a more accurate representation of the continuous variable, as the gradual color change corresponds to the change in the variable's value. Using a gradient scale, we can visualize the distribution of values and identify patterns or trends in the data.

There are [several methods for creating gradient scales in ggplot2](http://ggplot2.tidyverse.org/reference/scale_gradient.html). For our purpose, we will use the `scale_colour_gradient()` function. This allows us to specify the colors for the minimum and maximum values of the continuous variable, and ggplot2 automatically interpolates the colors for the intermediate values based on the chosen gradient.

We can work with the p2 object created earlier and use the "+" operator to make modifications. We will map the `dist` variable, representing the distance between cities, to the color aesthetic using `color = dist` inside the `aes()` function. Next, we add the `scale_colour_gradient()` function to customize the color gradient. We specify `low = "white"` to set the color for the lowest values of the dist variable to white, and `high = "red3"` to set the color to a dark red for the highest values. This means that lighter shades of red will represent shorter distances, while darker shades of red will represent longer distances.
>>>>>>> 7c3b2730 (update local branch)

```

p2 + scale_colour_gradient(low = "white", high = "red3")

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-14.png" alt="Scatter plot showing population data of origin and destination city colored by distance between cities using scale_colour_gradient()" caption="Figure 14. Population data of origin and destination city colored by distance between cities using scale_colour_gradient()." %}

<<<<<<< HEAD
We can see small cities tend to establish relationships with cities that are not so distant, which is an interesting finding related to the patterns we explored earlier. In the previous sections, we examined the distribution of distances between sister cities using a histogram and an ECDF plot. These visualizations revealed that most sister-city relationships are characterized by short distances, with a significant proportion of cities connected to sister cities within a radius of 500 to 1000 kilometers. Consistent findings across different visualizations strengthen our confidence in the observed patterns and highlight the importance of considering city size and distance as key variables.

Building upon these insights, we will focus on modifying our scatterplot legend. As mentioned earlier, the legend is controlled by the scales function in ggplot2. By customizing it, we can improve interpretability and clarity, making it easier for readers to understand the conveyed information.

We will modify the legend by modifying the guide parameter within the `scale_colour_gradient()` function. The guide parameter specifies the legend's title, position, and orientation. We will also use the `guide_colorbar()` function to create a color bar legend representing the distance range between cities.
=======
We can see that small cities tend to establish relationships with cities that are not so distant is an interesting finding related to the patterns we explored earlier in the article. In the previous sections, we examined the distribution of distances between sister cities using a histogram and an ECDF plot. These visualizations revealed that most sister-city relationships are characterized by relatively short distances, with a significant proportion of cities being connected to sister cities within a radius of 500 to 1000 kilometers. Consistent findings across different visualizations strengthen our confidence in the observed patterns. It highlights the importance of considering city size and distance as key variables in analyzing sister city networks.

Building upon these insights, we will now focus on modifying the legend of our scatterplot. As mentioned earlier, the legend is controlled by the scales function in ggplot2. By customizing it, we can improve the interpretability and clarity of our visualization, making it easier for readers to understand the information being conveyed.

To modify the legend, we will use the guide parameter within the `scale_colour_gradient()` function. The guide parameter allows us to specify the appearance and behavior of the legend, such as its title, position, and orientation. In this case, we will use the `guide_colorbar()` function to create a color bar legend that represents the range of distances between sister cities.
>>>>>>> 7c3b2730 (update local branch)

```

p2 <- p2 + scale_colour_gradient(low = "white",

<<<<<<< HEAD
high = "red3",

guide = guide_colorbar(title = "Distance in log(km)",

direction = "horizontal",

title.position = "top"))
=======
                                high = "red3",

                                guide = guide_colorbar(title = "Distance in log(km)",

                                                 direction = "horizontal",

                                                 title.position = "top"))
>>>>>>> 7c3b2730 (update local branch)

p2

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-15.png" alt="Scatter plot showing population data of origin and destination city colored by distance between cities using scale_colour_gradient() and guide_colorbar()." caption="Figure 15. Population data of origin and destination city colored by the distance between cities using scale_colour_gradient() and guide_colorbar()." %}

<<<<<<< HEAD
### Faceting a Graph

Previously, we created a plot comparing cities and their relationships with domestic cities in EU and non-EU countries using different colors for each country. ggplot2 also allows you to split your data into different plots based on a variable. In ggplot2, this is called [facetting](http://ggplot2.tidyverse.org/reference/index.html#section-facetting). The simplest facetting function is `facet_wrap()`, but you can also look at the richer [`facet_grid()`](http://ggplot2.tidyverse.org/reference/facet_grid.html) for more options.

Using our previous dataframe `eudata.perc.country`, we facet our graphs by adding a `facet_wrap()` layer for each origin country:

```

ggplot(`eudata.perc.country`, aes(x = typecountry, y = perc)) +

geom_bar(stat = "identity") +

facet_wrap(~origincountry)
=======
In the provided code, we apply the `scale_colour_gradient()` function to the p2 object, which represents our scatterplot. The legend is controlled by the parameter [`guide`](http://ggplot2.tidyverse.org/reference/guides.html). We tell ggplot2 to use a [`guide_colorbar()`](http://ggplot2.tidyverse.org/reference/guide_colourbar.html) with the parameters for the title (caption, position, etc.).

### Faceting a Graph

Previously, we created a plot that compared cities and their relationships with domestic cities in EU countries and non-EU countries using different colors for each country. ggplot2 allows you to split your data into different plots based on a variable. In ggplot2, this is called [facetting](http://ggplot2.tidyverse.org/reference/index.html#section-facetting). The simplest facetting function is facet_wrap(), but you can also look at the richer [`facet_grid()`](http://ggplot2.tidyverse.org/reference/facet_grid.html) for more options. 

Using our previous dataframe `eudata.perc.country`, we can facet our graphs by adding a `facet_wrap()` layer in the following way to get a different graph for each origin country:

```

ggplot(eudata.perc.country, aes(x = typecountry, y = perc)) +

   geom_bar(stat = "identity") +

   facet_wrap(~origincountry)
>>>>>>> 7c3b2730 (update local branch)

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-16.png" alt="Faceted bar graphs using facet_wrap() where the bar graph for each country is displayed in a grid pattern." caption="Figure 16. Facetting a graph with facet_wrap()." %}

<<<<<<< HEAD
The formula `~origincountry` tells ggplot2 to split data based on the values of the `origincountry` variable and create a separate graph for each country. The resulting plot will display the bar graphs for each country in a grid layout. The tilde (`~`) operator is commonly used in R for formulas. In the context of `facet_wrap()`, however, it indicates the variable should be used to define the faceting structure.

### Themes: Changing Static Elements

Since modifying the appearance of graphs is crucial for effectively communicating urban and demographic patterns, ggplot2 provides themes to help customize our visualizations further. These themes help emphasize different aspects of our data, whether we're focusing on spatial relationships between cities or demographic patterns across regions.
=======
The formula `~origincountry` tells ggplot2 to split the data based on the values of the origincountry variable and create a separate graph for each country. The resulting plot will display the bar graphs for each country in a grid layout. The tilde (`~`) operator is commonly used in R for formulas. In the context of `facet_wrap()`, however, it indicates that the variable should be used to define the faceting structure.

### Themes: Changing Static Elements

Since modifying the appearance of graphs is a frequent task, ggplot2 also has themes. Themes are one of the most powerful and rich features of ggplot2, which makes it impossible to fully cover in this lesson. However, we will mention two aspects to get you started. First, ggplot2 comes with several [built-in themes](http://ggplot2.tidyverse.org/reference/ggtheme.html). The most common are `theme_grey()` (the default), `theme_bw()`, `theme_dark()`, and `theme_void()`. Second, you can easily create your own themes and use them in your plots.
>>>>>>> 7c3b2730 (update local branch)

Using a theme different from the default one is simple. We apply it as a new layer using the `+` operator:

```

<<<<<<< HEAD
p3 <- ggplot(`eudata.perc.country`, aes(x = typecountry, y = perc)) +

geom_bar(stat = "identity") +

facet_wrap(~origincountry)
=======
p3 <- ggplot(eudata.perc.country, aes(x = typecountry, y = perc)) +

    geom_bar(stat = "identity") +

       facet_wrap(~origincountry)
>>>>>>> 7c3b2730 (update local branch)

p3 + theme_bw()

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-17.png" alt="Faceted bar graph with changed static elements using the theme_bw() function." caption="Figure 17. Changing static elements using themes()." %}

<<<<<<< HEAD
Several packages add additional themes, such as [ggthemes](https://github.com/jrnold/ggthemes) or [ggtech](https://github.com/ricardo-bion/ggtech). In these, you will find themes such as `theme_excel` (a theme replicating the classic charts in Excel) and `theme_wsj` (a theme based on the plots in The Wall Street Journal). Often, users believe the "look" of a graph is more important than the data it represents. Consequently, they may make their graphs look like those in well-known publications. However, this is not always the best approach since the grammar of graphics specifies what elements of a graph are essential and how they map to data.

Thus, using themes from packages that consider this when changing features, such as through ggthemes is better. For instance, to mimic graphs created by _The Wall Street Journal_, we can do the following:
=======
Several packages add additional themes, such as [ggthemes](https://github.com/jrnold/ggthemes) or [ggtech](https://github.com/ricardo-bion/ggtech). In these, you will find themes such as `theme_excel` (a theme replicating the classic charts in Excel) and `theme_wsj` (a theme based on the plots in The Wall Street Journal). Often, users believe that the "look" of a graph is more important than the data it represents. Consequently, they may try to make their graphs look like those in well-known publications. However, this is not always the best approach since the grammar of graphics specifies what elements of a graph are essential and how they map to data.

Thus, using themes from packages that consider this when changing features, such as through ggthemes is better. For instance, to mimic graphs created by *The Wall Street Journal*, we can do the following:
>>>>>>> 7c3b2730 (update local branch)

```

install.packages("ggthemes")

library(ggthemes)

p3 + theme_wsj()

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-18.png" alt="Bar graph with changed static elements using the theme_wsj() function from the ggthemes package." caption="Figure 18. Changing static elements using another theme (the Wall Street Journal theme)." %}

### Extending ggplot2 with Other Packages

<<<<<<< HEAD
One of ggplot2's strengths is its extensive collection of [extensions](http://www.ggplot2-exts.org/) that enhance our analysis of urban and demographic patterns. These extensions create specialized visualizations like network graphs (useful for showing relationships between cities), time series graphs (for tracking demographic changes over time), and ridgeline plots (for comparing population distributions across different urban areas).

Let's explore an example that showcases how ggplot2 can be extended using additional packages to create more advanced and visually striking plots. In this case, we will create a ridgeline plot, also known as a joy plot, designed to visualize changes in distributions over time or across different categories. Ridgeline plots are particularly effective for comparing multiple distributions in a compact and aesthetically pleasing manner, as they create the impression of a mountain range.

To create a ridgeline plot, we leverage the capabilities of the ggridges package, which is an extension of ggplot2. This adds a new layer called `geom_density_ridges()` and a new theme `theme_ridges()`, which expands R's plotting possibilities.
=======
One of the strengths of ggplot2 is the massive amount of [extensions](http://www.ggplot2-exts.org/) that the community has written. With them, you can create [network graphs](https://briatte.github.io/ggnetwork/), [radar charts](https://github.com/ricardo-bion/ggradar), [time series graphs](https://github.com/AtherEnergy/ggTimeSeries), [ridgeline plots](https://cran.r-project.org/web/packages/ggridges/vignettes/introduction.html), and many more.

Let's explore an example that showcases how ggplot2 can be extended using additional packages to create more advanced and visually striking plots. In this case, we will create a ridgeline plot, also known as a joy plot, designed to visualize changes in distributions over time or across different categories. Ridgeline plots are particularly effective for comparing multiple distributions in a compact and aesthetically pleasing manner, as they create the impression of a mountain range.

To create a ridgeline plot, we will leverage the capabilities of the ggridges package, which is an extension of ggplot2. This adds a new layer called `geom_density_ridges()` and a new theme `theme_ridges()`, which expands R's plotting possibilities.
>>>>>>> 7c3b2730 (update local branch)

This code is simple enough (we use a log transformation due to the data's skewness):

```

install.packages("ggridges")

library(ggridges)

ggplot(eudata, aes(x=log(originpopulation), y = origincountry)) +

<<<<<<< HEAD
geom_density_ridges() +

theme_ridges() +

labs(title = "Population (log) of the origin cities",

caption = "Data: [www.wikidata.org](http://www.wikidata.org)",

x = "Population (log)",

y = "Country")
=======
    geom_density_ridges() +

    theme_ridges() +

    labs(title = "Population (log) of the origin cities",

         caption = "Data: www.wikidata.org",

         x = "Population (log)",

         y = "Country")
>>>>>>> 7c3b2730 (update local branch)

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-19.png" alt="Ridge plot showing the population (log) of different countries origins." caption="Figure 19. Extending ggplot2 with the package ggridges." %}

<<<<<<< HEAD
The graph reveals important demographic patterns across different urban centers. This visualization of population distributions shows how urban demographic patterns vary by country. For example, Poland and Portugal show distinct demographic profiles, with their urban centers tending toward larger population sizes, as indicated by the peaks on the right side of their respective density curves. 

## Conclusion

Through our analysis of sister-city relationships in Europe using ggplot2 and its extensions, we've demonstrated how different visualization techniques can reveal patterns in urban networks and demographic characteristics. The dataset allowed us to uncover several key insights: cities tend to form partnerships within a 500-1000 km radius, countries vary significantly in their preference for domestic versus international partnerships, and population size plays a role in partnership formation. 

However, this is just the tip of the iceberg of ggplot2's possibilities. With an extensive ecosystem of extensions and packages, ggplot2 offers endless opportunities for customization and adaptation to specific data visualization needs. Whether you're working with time series data, network graphs, or geospatial information, there's likely a ggplot2 extension that can help you create compelling and informative visualizations. As you continue to explore and work with ggplot2, remember that effective data visualization is an iterative process that requires experimentation, refinement, and a keen understanding of your audience and communication goals. By mastering the principles and techniques this tutorial covers, you will be well-equipped to create impactful visualizations that illuminate the stories hidden within your data.
=======
The graph shows that the population distributions of the origin cities vary across countries. The ridgeline plot reveals that some countries, such as Poland and Portugal, have origin cities with relatively large populations, as indicated by the peaks on the right side of their respective density curves. On the other hand, countries like Hungary and France have origin cities with smaller populations, resulting in density curves concentrated more towards the left side of the plot.

## Conclusion

We have now explored the powerful capabilities of ggplot2 and its extensions for creating informative and visually appealing data visualizations. Throughout this tutorial, we have delved into various aspects of data visualization, from basic plotting techniques to advanced customization options. We have seen how ggplot2 provides a flexible and intuitive framework for creating a wide range of plots, including bar plots, histograms, box plots, scatter plots, and more, that enable us to communicate patterns, relationships, and insights effectively within our data.

Throughout this tutorial, we have worked with a dataset on sister cities, which has provided us with a rich and fascinating glimpse into the world of international municipal partnerships. By exploring this data using the tools and techniques of ggplot2, we have uncovered a range of insights and patterns that shed light on the nature and dynamics of these unique relationships. Our dataset has allowed us to investigate questions such as the geographical distribution of sister cities, the role of distance and population size in shaping these partnerships, and the prevalence of different types of relationships (domestic, EU, non-EU) across various countries. We have seen how cities tend to form partnerships with other cities that are relatively close in proximity, with a significant proportion of sister cities located within a 500-1000 km radius. We have also observed interesting variations across countries, with some exhibiting a stronger preference for domestic partnerships while others display a more balanced mix of EU and non-EU connections.

However, this is just the tip of the iceberg of ggplot2's possibilities. With its extensive ecosystem of extensions and packages, ggplot2 offers endless opportunities for customization and adaptation to specific data visualization needs. Whether you're working with time series data, network graphs, or geospatial information, there's likely a ggplot2 extension that can help you create compelling and informative visualizations.

As you continue to explore and work with ggplot2, remember that effective data visualization is an iterative process that requires experimentation, refinement, and a keen understanding of your audience and communication goals. By mastering the principles and techniques covered in this tutorial, you will be well-equipped to create impactful visualizations that illuminate the stories hidden within your data.
>>>>>>> 7c3b2730 (update local branch)

## Additional Resources

To gain a better understanding of ggplot2, We recommend you take a look at some of the following sources to gain a more thorough understanding:

* The [official Site](https://ggplot2.tidyverse.org/) for ggplot2.

* Hadley Wickham's books [`ggplot2`: Elegant Graphics for Data Analysis](https://ggplot2-book.org/) and [R for Data Science](https://r4ds.had.co.nz/).

* Hadley Wickham's [original paper](https://www.tandfonline.com/doi/abs/10.1198/jcgs.2009.07098) on the grammar of graphics.

* The [original book](https://www.springer.com/gp/book/9780387245447) by Leland Wilkson on the Grammar of Graphics.

<<<<<<< HEAD
* [Tutorial on [r-statistics.co](http://r-statistics.co)](http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html) by Selva Prabhakaran.
=======
* [Tutorial on r-statistics.co](http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html) by Selva Prabhakaran.
>>>>>>> 7c3b2730 (update local branch)

* Video by Data Science Dojo on an [Introduction to Data Visualization with ggplot2](https://www.youtube.com/watch?v=NXjPcXx42Yc).

* UC Business Analytics [R Programming Guide](https://uc-r.github.io/ggplot_intro).

* Official ggplot2 [extensions page](https://www.ggplot2-exts.org/) and [accompanying gallery](http://www.ggplot2-exts.org/gallery/).

<<<<<<< HEAD
* R Project’s [overview of extending ggplot2](https://cran.r-project.org/web/packages/ggplot2/vignettes/extending-ggplot2.html).

* The [documentation](https://ggplot2.tidyverse.org/reference/) of the package provides a general overview.
=======
* R Project’s [overview of extending ](https://cran.r-project.org/web/packages//vignettes/extending-.html).

* The [documentation](http://docs.ggplot2.org/current/) of the package provides a general overview.
>>>>>>> 7c3b2730 (update local branch)

* The [Cookbook for R](http://www.cookbook-r.com/Graphs/) book (based on the work [R Graphics Cookbook. Practical Recipes for Visualizing Data](http://shop.oreilly.com/product/0636920023135.do) by Winston Chang).

* The R cheatsheet that you can find [here](https://www.rstudio.com/resources/cheatsheets/).

* To explore different gradient scales, see the following [documentation page](http://ggplot2.tidyverse.org/reference/scale_gradient.html).
<<<<<<< HEAD
=======

>>>>>>> 7c3b2730 (update local branch)
