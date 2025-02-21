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
- Justin Wigard
- Amanda Regan
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

## Introduction

After [World War II](https://en.wikipedia.org/wiki/World_War_II), European cities faced a monumental task: rebuilding not just their physical infrastructure but also their international relationships. One fascinating lens through which to examine this post-war reconstruction is [sister cities](https://en.wikipedia.org/wiki/Sister_city). These formal partnerships were developed between cities in the post-war period to foster cross-border cooperation and understanding.

Sister-city relationships present historians with both an opportunity and a challenge. The opportunity lies in their potential to reveal patterns of post-war reconciliation and diplomacy. The challenge comes from their scale and complexity: there are many hundreds of European cities to analyze, and each one might have formed dozens of partnerships across multiple decades. This case is a good example of how useful data visualization can be for historical research. By converting these complex networks of sister-city relationships into visual patterns, we can explore questions that are difficult to answer through traditional methods alone: 'Did cities of [West Germany](https://en.wikipedia.org/wiki/West_Germany) preferentially form partnerships with French cities as part of post-war reconciliation?' 'Did the [Iron Curtain](https://en.wikipedia.org/wiki/Iron_Curtain) create distinct patterns of sister-city relationships between Eastern and Western Europe?' 'How did city size and geographic distance influence diplomatic connections?'

The R package [ggplot2](http://ggplot2.tidyverse.org) provides powerful tools for investigating these and similar questions through data visualization. While spreadsheets and basic charts can obscure patterns, ggplot2's sophisticated visualization capabilities allow historians to easily uncover hidden relationships in data. For example, [scatter plots](https://en.wikipedia.org/wiki/Scatter_plot) can reveal correlations between numerical variables like population sizes and geographic distances, [bar charts](https://en.wikipedia.org/wiki/Bar_chart) can show the distribution of partnerships across different categories of cities, and [histograms](https://en.wikipedia.org/wiki/Histogram) can expose patterns in demographic data that might otherwise remain invisible.

This lesson differs from standard ggplot2 guides by focusing specifically on the needs of urban historians. Rather than using generic datasets, we'll work with historical data about sister-city relationships to demonstrate how visualization techniques can illuminate historical patterns and processes. Through this approach, you'll learn to create visualizations that reveal complex partnerships and make historical findings more accessible to a broader audience.

## Lesson Goals

By the end of this lesson, you should be able to do the following with the `ggplot2` package:

- Create different types of plots to visualize urban and demographic data, including bar charts to show relationships between cities, histograms to display population distributions, and scatter plots to explore relationships between different variables.
- Manipulate the appearance of plots, such as their color or size.
- Add meaningful labels to plots.
- Compare data across grids of plots.
- Create novel plots with ggplot2 extensions.

This tutorial assumes you have a rudimentary knowledge of R. The *Programming Historian* lessons [R Basics with Tabular Data](https://programminghistorian.org/en/lessons/r-basics-with-tabular-data) and [Data Wrangling and Management in R](https://programminghistorian.org/en/lessons/data_wrangling_and_management_in_R) are recommended if you do not have this background.

## Our Data: Sister Cities in Europe

Urban and demographic data are fundamental to understanding the developments of human societies. Urban data allows us to reconstruct the complex network of relationships between cities. This encompasses everything from formal administrative connections, such as trade partnerships or political alliances, to informal relationships built through cultural exchange and population movement. Cities might be linked through trade routes, shared governance structures, or cultural institutions. The physical characteristics of cities also form an important part of urban data: their geographic location, proximity to other urban centers, and position within transportation networks influence how cities interact with one another.

Urban data also helps us understand the different roles cities play within broader social and economic systems. Some cities serve as administrative capitals, others as major ports facilitating international trade, and still others as industrial centers driving economic growth. These roles often shift over time as cities adapt to changing political, economic, and technological circumstances. 

Demographic data complements this urban analysis by revealing the human dimension of change. At its most basic level, demographic data tells us about population sizes and their fluctuations, but its true value lies in helping us understand the complex patterns of movement and settlement. Changes in population density reflect urbanization processes, economic opportunities, or responses to environmental challenges. Migration patterns can illuminate economic relationships between regions, as well as the impact of political policies on population movement. The social and economic characteristics of populations — their age distributions, occupational patterns, and social structures — also provide a crucial context for understanding urban development.

Historians can combine these data types to investigate urban development and population dynamics. As mentioned above, we will be looking at [sister cities](https://en.wikipedia.org/wiki/Sister_city) – pairs of cities from different countries who have partnered to promote cultural and commercial ties. The modern concept of sister cities was conceived after World War II to foster friendship and understanding between different cultures and to promote trade and tourism. These partnerships often involve student exchanges, business relationships, and cultural events. By examining these partnerships, we can assess if geographic proximity, shared language, or similar population size play a role in two cities establishing a relationship. We can also explore whether historical tensions or alliances (such as those between Germany, France, and Poland) or shared linguistic heritage (for example between Spanish-speaking cities in the Americas) shape these partnerships. In recent years, historians have started to [investigate these kinds of interactions](https://www.cambridge.org/core/journals/urban-history/issue/62C6F87B847CEFABB93598C340D8B144) more closely.

The first question that arises is where to get data about sister cities. One possibility is to draw from one of the biggest repositories of data in the world: [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page). On Wikidata, every single town in the world has been assigned a unique identifier and its own page, containing a certain amount of information. For example, the page devoted to [London](https://www.wikidata.org/wiki/Q84) shows, among other data, a list of its 'twinned administrative bodies'. Using the [SPARQL Protocol And RDF Query Language,](https://en.wikibooks.org/wiki/SPARQL) we can query this data and extract information about the towns associated with London.

For the purposed of this lesson, we created different queries to extract data about European towns and their sister cities. Using this, we put together a dataset containing the following data: the name, country, population size, and geographical coordinates of both the 'origin city' and the 'destination city'. We also calculated the distance between the two cities, and added a [Boolean](https://en.wikipedia.org/wiki/Boolean_data_type) column indicating whether the destination city is in the European Union (EU) or not (all origin cities are in the EU).

Our approach will be largely [exploratory](https://en.wikipedia.org/wiki/Exploratory_data_analysis), aiming to identify patterns, trends, and relationships in the data. We hope that we can uncover new insights and generate hypotheses for further research by doing so. You can [download the dataset from _Programming Historian_'s repository](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/urban-demographic-data-r-ggplot2/sistercities.csv).

## The advantages of ggplot2

We have many reasons for chosing to use ggplot2 for this analysis. The package a great number of advantages when compared to other options.

- It relies on a theoretical framework (detailed below) that assures your graphs meaningfully convey information, which is particularly important when working with complex urban and demographic datasets.
- It is relatively simple to use while remaining powerful.
- It creates publication-ready graphs.
- It comes with community-developed [extensions](http://www.ggplot2-exts.org/) which further enhance its capabilities, such as additional functions, graphs, and themes.
- It is versatile, as it can handle various data structures, including:
   * Numerical data (continuous and discrete)
   * Categorical data (factors and character strings)
   * Date and time data
   * Geographic coordinates
   * Text data

Creating graphics is a complicated issue, since it prompts us to consider various aspects of our data: the information we want to convey, the graph type we want to use to convey that information (scatter plot, box plot, histogram, and so on), the elements of the graph we wish to tweak (axes, variables, legends), and more. ggplot2 is a helpful tool for streamlining these choices. If all this sounds complicated at first, don't panic! Based on a theoretical framework known as the [grammar of graphics](https://link.springer.com/book/10.1007/0-387-28695-0) (hence the 'gg' in the name ggplot2) detailed by [Leland Wilkinson](https://en.wikipedia.org/wiki/Leland_Wilkinson), ggplot2 is a helpful tool for streamlining these choices. You only need to know a little bit about the grammar to make your first graph.

In the grammar of graphics, all plots are composed of a series of seven interrelated layers:

1. Data: The material we will analyze for our visualization.
2. [Aesthetics](https://ggplot2.tidyverse.org/reference/index.html#aesthetics): The ways visual properties map onto so-called 'geoms' (see Geometric Objects below). In most cases, this determines how we want to display our data (position, color, shape, fill, size).
3. [Scales](https://ggplot2.tidyverse.org/reference/index.html#scales): The mapping and normalization of data for visualization.
4. [Geometric Objects](https://ggplot2.tidyverse.org/reference/index.html#geoms) (or 'geoms' in ggplot2 jargon): How we want to represent our data. In most cases, this determines the type of graph we use, such as a bar chart, line graph, or histogram.
5. [Statistics](https://ggplot2.tidyverse.org/reference/index.html#stats): Statistical calculations we may want to run on our data before visualizing it.
6. [Facets](https://ggplot2.tidyverse.org/reference/index.html#facetting): The ability to categorize and divide data into multiple sub-graphs.
7. [Coordinate Systems](https://ggplot2.tidyverse.org/reference/index.html#coordinate-systems): How ggplot2 positions different geoms on the plot. The most common coordinate system is the Cartesian coordinate system, but ggplot2 can also plot polar coordinates and spherical projections.

To begin using ggplot2, you need to install and load it. We recommend installing the [tidyverse](https://www.tidyverse.org), which contains ggplot2, a collection of R packages that work together to provide a consistent and efficient workflow for data manipulation, exploration, and visualization. At the core of the tidyverse philosophy is the concept of ['tidy data'](https://r4ds.had.co.nz/tidy-data.html), a standardized way of structuring data to make it easier to work with. In tidy data, each variable is a column, each observation is a row, and each type of observational unit is a table. This structure allows for a consistent and predictable way of working with data across different packages and functions within the tidyverse. For more details, see the book [_R for Data Science. Import, Tidy, Transform, Visualize and Model Data_](https://r4ds.hadley.nz/) written by Hadley Wickam and others.

```

install.packages("tidyverse")

library("tidyverse")

```

### Loading Data with readr

Before importing data, it is important to understand how it may be formatted. Common spreadsheet applications, such as Microsoft Excel or Apple Numbers, place data in a proprietary format. While there are packages that can read in Excel data, such as [readxl](https://readxl.tidyverse.org/), it is recommended to use open formats, such as `.csv` (comma-separated values) or `.tsv` (tab-separated values), as they are compatible with a wider range of software tools and more likely to remain readable in the future.

R has built-in commands for reading in these files, but we will use the package [readr](https://readr.tidyverse.org/) from the tidyverse ecosystem, which can read most common formats. For our analysis, we will be reading in a `.csv` file. Go ahead and [download the dataset](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/urban-demographic-data-r-ggplot2/sistercities.csv) and place it in your project's current working directory. You will need to load the `readr` library if you did not load the tidyverse earlier. Next, you can use [`read_csv()`](https://readr.tidyverse.org/reference/read_delim.html) with the file path.

```

eudata<-read_csv("sistercities.csv")

```

Now, take a look at the data:

```

eudata

# A tibble: 13,081 x 15

[etc]

```

The tidyverse converts our data to a 'tibble' rather than a 'data frame'. Tibbles are a part of the tidyverse universe that serve the same function as data frames, but make decisions on the backend about how to import and display the data with R. R is a relatively old programming language and, as a result, defaults that made sense during the original implementation are often less helpful now. Tibbles, unlike data frames, do not change variable names, convert the input type, or create row names. You can [learn more about tibbles here](https://r4ds.had.co.nz/tibbles.html). If this does not make sense, don't worry! In most cases, we can treat tibbles like data frames and easily convert between the two. If you need to convert your data frame to a tibble, use the `as_tibble()` function with the data frame's name as the parameter. Likewise, to convert back to a data frame, use the `as.data.frame()` function.

We will start by exploring the data for six EU countries: Germany, France, Portugal, Poland, Hungary, and Bulgaria (three Western European countries and three Eastern European countries). The tibble you saw above called `eudata` contains this data in 12 variables and 13081 rows.

The tibble contains comprehensive information combining urban and demographic data about sister city relationships. The urban data includes information about both origin and destination cities (`origincity`, `destinationcity`), their respective countries (`origincountry`, `destinationcountry`), and their geographical coordinates (`originlat`, `originlong`, `destinationlat`, `destinationlong`). It also contains information about the distance between paired cities (`dist`) and their administrative relationship status (`eu`). For demographic analysis, we have population data for both origin and destination cities (`originpopulation`, `destinationpopulation`). This combination of data types should allow us to explore how city characteristics and population patterns influence partnerships.

## Creating Your First Graph

Let's begin by exploring an urban pattern that connects to broader questions about European integration and international relations: do EU cities tend to form stronger sister city relationships with cities in the same country, in other EU countries, or outside the EU? Answering this question will help us understand not just sister city relationships but also larger historical processes like post-war reconciliation, European identity development, and urban diplomacy's changing nature. Similar visualization techniques could be used to study other international relationships, such as trade partnerships, cultural exchanges, or diplomatic missions.

Let's start by counting how many destination cities are either domestic (same country as origin city), in a different EU country, or in a non-EU country. Paste the following code into ggplot2:

```

ggplot(eudata, aes(x = typecountry)) +

geom_bar()

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-01.png" alt="A bar graph showing the total count of destination cities that are domestic, EU, and non-EU" caption="Figure 1. Bar graph showing the total count of destination cities that are domestic, EU, and non-EU." %}

The first parameter of the `ggplot()` function is the data (tibble or data frame) containing the information we are exploring, while the second parameter is the aesthetics of the graph. As you may recall from earlier, aesthetics define the variables in our data and how we want to map them to visual properties. These two are the basis of any plot.

The `geom()` layer tells ggplot2 what type of graph you want to produce. Since you want to create a barplot, you need the `geom_bar()` layer, which you can quickly set using the `+` command.

Understanding the `ggplot()` syntax can be tricky at first but, once it starts making sense, you will be able to see the power of the standardized framework that underpins ggplot2 (the grammar of graphics). One way to think of this grammar is to view creating plots like constructing a sentence. In our example, we told R: "Create a ggplot graph using the data in eudata, map the variable `typecountry` to x and add a layer called `geom_bar()`". This structure is relatively straightforward. [`aes()`](http://ggplot2.tidyverse.org/reference/aes.html) itself is not as self-explanatory, but the idea behind it is quite simple: it tells R to map certain variables in the data onto visual properties (aesthetics) of geoms in the graph. Again, do not panic if you do not understand it completely. We will go into more depth later.

You now have your first plot! You may notice that ggplot2 has made some decisions on its own: background color, font size of the labels, etc. The default settings are usually sufficient, but you can customize these aspects if you prefer.

Because ggplot2 works within a consistent syntax, you can easily modify your plots to look different, or display different data. For instance, say you wanted percentages rather than raw counts. Using the following code, you can create a new tibble that calculates the percentage and adds them under a new column named `perc` (again, see the lesson [Data Wrangling and Managment in R](https://programminghistorian.org/lessons/data_wrangling_and_management_in_R) about dplyr for details if this code does not make sense to you). Then, you only need to make a few changes to the code to display the new plot:

```

# Aggregate the data per type of country and add a new column with percentages

eudata.perc <- eudata %>%

group_by(typecountry) %>%

summarise(total = n()) %>%

mutate(perc = total/sum(total))

ggplot(data = eudata.perc, aes(x = typecountry, y = perc)) +

geom_bar(stat = "identity")

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-02.png" alt="Bar graph showing percentage of destination cities that are domestic, EU, and non-EU." caption="Figure 2. Bar graph showing percentage of destination cities that are domestic, EU, and non-EU." %}

There is an important difference between the first plot (Figure 1) and this one. In the previous plot, ggplot2 counted the number of cities in every group (domestic, EU, non-EU). In our new plot, the tibble already contained each bar's numerical value, stored in the **perc** column. This is why we specify `y = perc` as a parameter of `aes()`. The tricky part is that by default, `geom_bar()` will use the parameter `stat = "count"`. This means it will count how many times a value appears. In other words, it aggregates data for you. However, since you have already aggregated the data, you can inform ggplot2 that you have already calculated your values by using the parameter `stat = "identity"`.

Figure 2 shows that most sister cities are from a different EU country than the origin city (around 68%). This could be due to geographical proximity, cultural similarities, or economic ties within the European Union. We can get a more detailed look by adding in the data about the origin country to the visualization. We could decide to visualize this either by breaking down each bar into percentages by origin country (Figure 3), or by creating separate graphs for each origin country (this is called 'facetting' in ggplot2 lingo). Let's try the first approach:

```

# We aggregate the data per country and type of country and add a new column with percentages

`eudata.perc.country` <- eudata %>%

group_by(origincountry, typecountry) %>%

summarise(total = n()) %>%

mutate(perc = total/sum(total))

ggplot(data = `eudata.perc.country`, aes(x = typecountry, y = perc, fill = origincountry)) +

geom_bar(stat = "identity", position="dodge")

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-03.png" alt="Bar graph showing the percentage of destination cities that are domestic, EU, and non-EU with aggregated data per country and type of country." caption="Figure 3. Bar graph showing the percentage of destination cities that are domestic, EU, and non-EU with aggregated data per country and type of country." %}

For this plot (Figure 3), we created a tibble that aggregated data per origin country and destination city type (EU, non-EU, domestic). We mapped the `origincountry` column to the `fill` aesthetic in the `ggplot()` command, which defines the color range of the bars. We also added the `dodge` position to `geom_bar(`) so that the bars do not get stacked (which is the default), but are instead placed side by side.

Now that we have visualized urban relationships (partnerships between cities) and demographic patterns (population sizes), we can analyze how these two aspects of our data interact.

Figure 3 reveals that most countries in our analysis (Hungary, France, Poland and Germany) strongly prefer to establish sister city relationships with other European Union countries, with approximately 60-80% of their partnerships in the EU. However, both Bulgaria and Portugal differ from this trend. Both of these countries seem to have a roughly equal proportion of sister city relationships with EU and non-EU countries. This suggests that Bulgaria and Portugal have a more balanced approach towards forming partnerships that involves actively engaging with cities outside the European Union.

In the case of Portugal, this more global outlook might be attributed to its extensive colonial history which may have fostered long-lasting cultural, linguistic, and economic ties with cities in its former colonies, such as those in Brazil, Angola, and Mozambique.

As for Bulgaria, we would need further investigation to uncover the factors contributing to its relatively high percentage of non-EU sister city partnerships. Possible explanations include its geographic location at the edge of the European Union, its cultural and linguistic ties to countries in the Balkans and Eastern Europe, or its economic relationships with countries outside the EU.

While these initial observations provide a starting point for understanding relationship patterns, it is essential to delve deeper into each country's historical, cultural, and political context to comprehend the underlying reasons for these trends.

## Other Geoms: Histograms, Distribution Plots and Box Plots

We have seen the key syntax needed to operate ggplot2: creating layers and adding parameters to them. One of the most important layers is the geoms layer. Using it is quite straightforward: every plot type has an associated geom:
- `geom_histogram()` For [histograms](http://ggplot2.tidyverse.org/reference/geom_histogram.html)
- `geom_boxplot()` for [boxplots](http://ggplot2.tidyverse.org/reference/geom_boxplot.html)
- `geom_violin()` for [violin plots](http://ggplot2.tidyverse.org/reference/geom_violin.html)
- `geom_dotplot()` for [dotplots](http://ggplot2.tidyverse.org/reference/geom_dotplot.html)
- `geom_point()` for [scatterplot](http://ggplot2.tidyverse.org/reference/geom_point.html)
- [and so on](https://ggplot2.tidyverse.org/reference/#geoms).

We can configure various aspects of each of these `geom()` types, such as their size and color.

To get practice with these geoms, let's create a histogram to visualize an important urban characteristic between sister cities: the distance between them. This spatial aspect can help us understand how geographic proximity influences city partnerships.

```

# Filter the data and visualize it

# Load tidyverse or dplyr, otherwise filter will throw an error!

eudata.filtered <- filter(eudata, dist < 5000)

ggplot(eudata.filtered, aes(x=dist)) + geom_histogram()

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-04.png" alt="Histogram showing distances (in log10) between sister cities." caption="Figure 4. Histogram showing distances (in log10) between sister cities." %}

As shown by the code above, we only needed to add `geom_histogram()` to create a histogram. However, making an effective histogram involves a bit more work. It is important, for example, to determine a 'bin size' that makes sense for the data. The bin size, also known as the 'interval' or 'bandwidth', refers to the width of each bar, and determines how data is grouped and displayed along the x-axis. In the histogram created in Figure 4, ggplot2 defaulted to a binwidth of 30 (`bins=30`) – a warning message recommends picking a better value. You can explore more configuration possibilities in the [`geom_histogram()` documentation](http://ggplot2.tidyverse.org/reference/geom_histogram.html).

In this simple graph, the distribution of the `dist` variable appears rather skewed: very few destination cities are located far away from their origin city. This has implications for our analysis, as it suggests that while most sister cities tend to be geographically close, there are exceptions where cities establish partnerships with far-off counterparts. 

We can use a [cumulative distribution function (ECDF)](https://en.wikipedia.org/wiki/Empirical_distribution_function) to gain additional insights into this urban pattern and better understand the spatial distribution of sister city relationships. This type of plot shows us how urban connections are distributed across different distances. The ECDF can also assess whether the skewness observed is a genuine feature of the data or a result of bin size. If the ECDF shows a similar pattern of skewness, with a steep increase on the left and a more gradual increase on the right, it would confirm skewness is an inherent characteristic of the `dist` variable. In ggplot2, we can create an ECDF by adding the `stat_ecdf()` layer to our plot. Here's an example:

```

ggplot(eudata.filtered, aes(x=dist)) + stat_ecdf()

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-05.png" alt="ECDF Graph showing the distances between sister cities." caption="Figure 5. ECDF Graph showing the distances between sister cities." %}

Let's examine the ECDF plot created using the unfiltered `eudata` data frame: it confirms previous observations about the skewed distribution. Approximately 75% of cities have sister-city relationships within a radius of around 1000 kilometers. Even more intriguing is that roughly 50% of the cities are connected to sister cities no more than 500 kilometers away.

Lastly, we will create a box plot to compare how different countries structure their urban relationships across space. This visualization helps understand how certain countries tend to form more localized urban networks while others maintain broader geographic connections. By comparing the distribution of distances, we can identify national patterns in how cities build their international relationships.

```

ggplot(eudata.filtered, aes(x = origincountry, y = dist)) + geom_boxplot()

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-06.png" alt="Boxplots showing distances (in km) between sister cities of different countries." caption="Figure 6. Box plots showing distances (in km) between sister cities of different countries." %}

Figure 6 reveals an interesting pattern for German cities especially: it shows that they tend to establish sister-city relationships with cities that are geographically closer, as indicated by the lower median distance and smaller spread of the box compared to other countries. This could reflect Germany's position as a central and well-connected country within Europe as its geographic location and strong economic ties with its neighbors could encourage the formation of regional partnerships within a smaller radius.

## Advanced Manipulations to Graphs' Appearance

So far, you have relied on ggplot2's to automatically decide your graphs' appearance. However, you'll certainly encounter various reasons to adapt these choices, for example to improve readability, highlight specific aspects of the data, or adhere to specific style guidelines. ggplot2 offers a wide range of customization options to fine-tune the appearance of its plots. To learn how to do this, let's start with a simple plot and build on it step by step.

Let's explore how demographic characteristics influence urban relationships by examining the population size of sister cities. This analysis connects to broader historical questions about how city size affects international influence, how urban hierarchies develop, and how demographic patterns shape cultural and economic exchanges. Similar approaches could be used to study historical questions about urbanization patterns, the development of metropolitan regions, or the relationship between population size and economic development.

We will begin by creating a scatter plot of the population size for origin and destination cities. A scatter plot is a graph that uses dots or points to represent the intersecting values of two variables for each observation. In this case, each point on the scatterplot will represent a sister city pair, with the x-coordinate indicating the population of the origin city and the y-coordinate representing the population of the destination city. If we observe a clear positive trend, with points clustering along a diagonal line from the bottom left to the top right of the plot, it will suggest that cities tend to form relationships with other cities of similar population size.

Since `eudata` contains 13081 entries, using them all would lead to overplotting. Therefore, we will use a random sample of 15% of the cities in our data frame with the function [`sample_frac()`](http://dplyr.tidyverse.org/reference/sample.html). We will also work with the [natural logarithm](https://en.wikipedia.org/wiki/Natural_logarithm) of the population data to overcome skewness. Since we are looking at a random data selection, we must 'set a seed' to ensure reproducibility. This means that, if you run the code again, you will get the same random sample. You can do this with the `set.seed()` function:

```

# Set seed to assure reproducibility

set.seed(123)

# We extract a random sample of 15% of the cities

eudata.sample <- sample_frac(eudata, 0.15)

# we create the plot

ggplot(data = eudata.sample,

aes(x = log(originpopulation),

y = log(destinationpopulation))) +

geom_point()

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-07.png" alt="Scatter plot displaying the relationship of population (in log10) in 15% of the sister cities that were randomly selected." caption="Figure 7. Scatter plot displaying the relationship of the population (in log10) in randomly selected sister city pairs." %}

Now that you have created this basic plot, you start playing with its appearance. Let's begin by applying a fixed size and color to the points. 

```

ggplot(data = eudata.sample,

aes(x = log(originpopulation),

y = log(destinationpopulation))) +

geom_point(size = 3, color = "red")

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-08.png" alt="Changing the size and color of the points of a scatterplot." caption="Figure 8. Changing the size and color of the points in the scatter plot." %}

To discover other available arguments, you can visit the `geom_point()` function's [documentation](http://ggplot2.tidyverse.org/reference/geom_point.html), or simply type `?geom_point` in R.

The plot looks a bit better, but you may also want to add axis labels. Manipulating axes (and legends) is done by using the corresponding scales functions, which we will cover later on. But since changing the labels is a very common action, ggplot provides the shorter command [`labs()`](http://ggplot2.tidyverse.org/reference/labs.html) (which stands for labels):

```

ggplot(data = eudata.sample,

aes(x = log(originpopulation),

y = log(destinationpopulation))) +

geom_point(size = 3, color = "red") +

labs(title = "Population data of origin and destination city",

caption = "Data: [www.wikidata.org](http://www.wikidata.org)",

x = "Population of origin city (log)",

y = "Population of destination city (log)")

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-09.png" alt="Scatterplot with added titles and caption using the labs() function." caption="Figure 9. Adding labels and title." %}

Once you are happy with your graph, you can save it:

```

ggsave("eudata.png")

# for getting a pdf

# ggsave("eudata.pdf")

```

This will create a [`.png`](https://en.wikipedia.org/wiki/Portable_Network_Graphics) file of the last plot you constructed. The function `ggsave()` also comes with [many adjustable parameters](http://ggplot2.tidyverse.org/reference/ggsave.html) (dpi, height, width, format, and more).

You may sometimes want to enhance your graph by encoding additional information, using different colors or shapes. This is particularly useful if you want to represent [categorical variables](https://en.wikipedia.org/wiki/Categorical_variable) alongside the main variables of interest. In the scatter plot (Figure 8), you used static values to determine the size and color of the points. However, you could also map these aesthetic properties to specific columns in the data, in order to systematically visualize your different categories.

For instance, say you want to distinguish between the different sister city relationships by highlighting the type of destination country in each pair. Our dataset's `typecountry` variable is a categorical variable which indicates whether the destination city is in the same country as the origin city, in another EU country, or another non-EU country. To incorporate this information, you can map the `typecountry` variable to the `color` parameter by passing the `aes()` function to `geom_point()`:

```

ggplot(data = eudata.sample,

aes(x = log(originpopulation),

y = log(destinationpopulation))) +

geom_point(size = 3, alpha = 0.7, aes( color = typecountry )) +

labs(title = "Population data of origin and destination city",

caption = "Data: [www.wikidata.org](http://www.wikidata.org)",

x = "Population of origin city (log)",

y = "Population of destination city (log)")

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-10.png" alt="Scatterplot using colors to distinguish different types of sister city relationships based on the location of the destination city." caption="Figure 10. Using colors in scatterplots to visualize different country types." %}

The code above made two major manipulations. First, we modified `geom_point()` by adding an argument: `aes(color = typecountry)`. Since there are too many overlapping points, we used the parameter `alpha` to make them 70% transparent. Again, ggplot2 has selected sensible default colors and legends for the graph.

### Scales: Colors, Legends, and Axes

Next, we'll explore ggplot2's `scales` function. Scales are crucial for determining how data is mapped to visual properties. They provide data transformation for position, size, color, and shape aesthetics. Additionally, scales define how aesthetics are displayed on the plot, including the range of values, the breaks or tick marks, and the labels.

In ggplot2, scales follow a naming convention consisting of three parts separated by underscores:

1. The prefix `scale`.
2. The type of aesthetic being modified (color, shape, x, y, etc.).
3. The type of scale being applied (continuous, discrete, brewer).

For example, `scale_color_continuous()` controls the color aesthetic using a continuous scale, while `scale_shape_discrete()` modifies the shape aesthetic using a discrete scale.

One common use of scales is to change plot colors. You can manually specify colors using specific color values or predefined color scales. Before we do this, let's start by storing our previous plot in a variable `p1`: this is a convenient way to create different versions of the same plot by modifying only certain aspects.

```

p1 <- ggplot(data = eudata.sample,

aes(x = log(originpopulation),

y = log(destinationpopulation))) +

geom_point(size = 3, alpha = 0.7, aes( color = typecountry )) +

labs(title = "Population data of origin and destination city",

caption = "Data: [www.wikidata.org](http://www.wikidata.org)",

x = "Population of origin city (log)",

y = "Population of destination city (log)")

```

Now, you can easily modify the color scale. To manually specify colors, you can use the `scale_color_manual()` function and provide a vector of color values, using color names [defined by R](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf) or their hexadecimal codes. [`scale_colour_manual()`](http://ggplot2.tidyverse.org/reference/scale_manual.html) takes a compulsory argument (`values =`), namely a vector of the color names.

```

p1 + scale_colour_manual(values = c("red", "blue", "green"))

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-11.png" alt="Scatter plot that uses scale_colour_manual() to change the colors of the scatterplot points." caption="Figure 11. Using scale_colour_manual() to change the colors of the scatter plot points." %}

In this way, we can create graphs with our preferred colors. However, using already defined color scales, such as the [color brewer palettes](http://colorbrewer2.org), when possible, is better. ggplot2 already has these [integrated](http://ggplot2.tidyverse.org/reference/scale_brewer.html) and a scale for using them (`scale_colour_brewer()`):

```

p1 + scale_colour_brewer(palette = "Dark2") # you can try others such as "Set1", "Accent", etc.

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-12.png" alt="Scatter plot that uses scale_colour_brewer() to change the colors of the scatterplot points." caption="Figure 12. Using scale_colour_brewer() to change the colors of the scatterplot points." %}

Let's look at a slightly different example. In the last graph, we used a qualitative variable (`typecountry`) with different colors. But what if we wanted to use a continuous variable such as the distance between cities (we will again use the log of the distance because of skewness). We want to use the intensity of red to represent distance:

```

p2 <- ggplot(data = eudata.sample,

aes(x = log(originpopulation),

y = log(destinationpopulation))) +

geom_point(size = 3, aes( color = log(dist) )) +

labs(title = "Population data of origin and destination city",

subtitle = "Colored by distance between cities",

caption = "Data: [www.wikidata.org](http://www.wikidata.org)",

x = "Population of origin city (log)",

y = "Population of destination city (log)")

p2

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-13.png" alt="Scatter plot showing population data of origin and destination city colored by distance between cities." caption="Figure 13. Population data of origin and destination city colored by distance between cities." %}

As you see, this graph has two problem:

1. Blue is the color used instead of red.

2. The scale is counterintuitive because smaller distances are represented by a darker blue, while we would expect shorter distances to be represented by lighter colors.

Using the appropriate scale function is crucial when working with different types of variables in ggplot2. It ensures that the visual representation of the data accurately reflects the nature of the variable and communicates the intended information.

In the previous example, we used a discrete color scale ([`scale_color_manual()`](http://ggplot2.tidyverse.org/reference/scale_manual.html)) to assign distinct colors to each level of a qualitative variable. This approach works well when dealing with categorical or factor variables, where each value represents a separate category or group. By assigning a unique color to each level, using [predefined R colors](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf) or hexadecimal codes, we can clearly distinguish between categories, highlighting their differences or similarities. However, using a discrete color scale may not be appropriate when working with continuous variables, such as distance. Continuous variables have a range of values within a certain interval. In such cases, using a gradient color scale is more suitable to represent the continuous nature of the data.

Gradient or continuous color scales assign colors to values based on a smooth transition between hues or shades. This allows for a more accurate representation of the continuous variable, as the gradual color change corresponds to the change in the variable's value. Using a gradient scale, we can visualize the distribution of values and identify patterns or trends in the data.

There are [several methods for creating gradient scales in ggplot2](http://ggplot2.tidyverse.org/reference/scale_gradient.html). For our purpose, we will use the `scale_colour_gradient()` function. This allows us to specify colors for the minimum and maximum values of the continuous variable, and ggplot2 automatically interpolates the colors for the intermediate values based on chosen gradient.

We can work with the p2 object created earlier and use the "+" operator to make modifications. We will map the `dist` variable, representing the distance between cities, to the color aesthetic using `color = dist` inside the `aes()` function. Next, we add the `scale_colour_gradient()` function to customize color gradient. We specify `low = "white"` to set the color for the lowest values of the dist variable to white and `high = "red3"` to set the highest values to dark red. This means lighter shades of red represent shorter distances, while darker shades represent longer distances.

```

p2 + scale_colour_gradient(low = "white", high = "red3")

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-14.png" alt="Scatter plot showing population data of origin and destination city colored by distance between cities using scale_colour_gradient()" caption="Figure 14. Population data of origin and destination city colored by distance between cities using scale_colour_gradient()." %}

We can see small cities tend to establish relationships with cities that are not so distant, which is an interesting finding related to the patterns we explored earlier. In the previous sections, we examined the distribution of distances between sister cities using a histogram and an ECDF plot. These visualizations revealed that most sister-city relationships are characterized by short distances, with a significant proportion of cities connected to sister cities within a radius of 500 to 1000 kilometers. Consistent findings across different visualizations strengthen our confidence in the observed patterns and highlight the importance of considering city size and distance as key variables.

Building upon these insights, we will focus on modifying our scatterplot legend. As mentioned earlier, the legend is controlled by the scales function in ggplot2. By customizing it, we can improve interpretability and clarity, making it easier for readers to understand the conveyed information.

We will modify the legend by modifying the guide parameter within the `scale_colour_gradient()` function. The guide parameter specifies the legend's title, position, and orientation. We will also use the `guide_colorbar()` function to create a color bar legend representing the distance range between cities.

```

p2 <- p2 + scale_colour_gradient(low = "white",

high = "red3",

guide = guide_colorbar(title = "Distance in log(km)",

direction = "horizontal",

title.position = "top"))

p2

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-15.png" alt="Scatter plot showing population data of origin and destination city colored by distance between cities using scale_colour_gradient() and guide_colorbar()." caption="Figure 15. Population data of origin and destination city colored by the distance between cities using scale_colour_gradient() and guide_colorbar()." %}

### Faceting a Graph

Previously, we created a plot comparing cities and their relationships with domestic cities in EU and non-EU countries using different colors for each country. ggplot2 also allows you to split your data into different plots based on a variable. In ggplot2, this is called [facetting](http://ggplot2.tidyverse.org/reference/index.html#section-facetting). The simplest facetting function is `facet_wrap()`, but you can also look at the richer [`facet_grid()`](http://ggplot2.tidyverse.org/reference/facet_grid.html) for more options.

Using our previous dataframe `eudata.perc.country`, we facet our graphs by adding a `facet_wrap()` layer for each origin country:

```

ggplot(`eudata.perc.country`, aes(x = typecountry, y = perc)) +

geom_bar(stat = "identity") +

facet_wrap(~origincountry)

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-16.png" alt="Faceted bar graphs using facet_wrap() where the bar graph for each country is displayed in a grid pattern." caption="Figure 16. Facetting a graph with facet_wrap()." %}

The formula `~origincountry` tells ggplot2 to split data based on the values of the `origincountry` variable and create a separate graph for each country. The resulting plot will display the bar graphs for each country in a grid layout. The tilde (`~`) operator is commonly used in R for formulas. In the context of `facet_wrap()`, however, it indicates the variable should be used to define the faceting structure.

### Themes: Changing Static Elements

Since modifying the appearance of graphs is crucial for effectively communicating urban and demographic patterns, ggplot2 provides themes to help customize our visualizations further. These themes help emphasize different aspects of our data, whether we're focusing on spatial relationships between cities or demographic patterns across regions.

Using a theme different from the default one is simple. We apply it as a new layer using the `+` operator:

```

p3 <- ggplot(`eudata.perc.country`, aes(x = typecountry, y = perc)) +

geom_bar(stat = "identity") +

facet_wrap(~origincountry)

p3 + theme_bw()

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-17.png" alt="Faceted bar graph with changed static elements using the theme_bw() function." caption="Figure 17. Changing static elements using themes()." %}

Several packages add additional themes, such as [ggthemes](https://github.com/jrnold/ggthemes) or [ggtech](https://github.com/ricardo-bion/ggtech). In these, you will find themes such as `theme_excel` (a theme replicating the classic charts in Excel) and `theme_wsj` (a theme based on the plots in The Wall Street Journal). Often, users believe the "look" of a graph is more important than the data it represents. Consequently, they may make their graphs look like those in well-known publications. However, this is not always the best approach since the grammar of graphics specifies what elements of a graph are essential and how they map to data.

Thus, using themes from packages that consider this when changing features, such as through ggthemes is better. For instance, to mimic graphs created by _The Wall Street Journal_, we can do the following:

```

install.packages("ggthemes")

library(ggthemes)

p3 + theme_wsj()

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-18.png" alt="Bar graph with changed static elements using the theme_wsj() function from the ggthemes package." caption="Figure 18. Changing static elements using another theme (the Wall Street Journal theme)." %}

### Extending ggplot2 with Other Packages

One of ggplot2's strengths is its extensive collection of [extensions](http://www.ggplot2-exts.org/) that enhance our analysis of urban and demographic patterns. These extensions create specialized visualizations like network graphs (useful for showing relationships between cities), time series graphs (for tracking demographic changes over time), and ridgeline plots (for comparing population distributions across different urban areas).

Let's explore an example that showcases how ggplot2 can be extended using additional packages to create more advanced and visually striking plots. In this case, we will create a ridgeline plot, also known as a joy plot, designed to visualize changes in distributions over time or across different categories. Ridgeline plots are particularly effective for comparing multiple distributions in a compact and aesthetically pleasing manner, as they create the impression of a mountain range.

To create a ridgeline plot, we leverage the capabilities of the ggridges package, which is an extension of ggplot2. This adds a new layer called `geom_density_ridges()` and a new theme `theme_ridges()`, which expands R's plotting possibilities.

This code is simple enough (we use a log transformation due to the data's skewness):

```

install.packages("ggridges")

library(ggridges)

ggplot(eudata, aes(x=log(originpopulation), y = origincountry)) +

geom_density_ridges() +

theme_ridges() +

labs(title = "Population (log) of the origin cities",

caption = "Data: [www.wikidata.org](http://www.wikidata.org)",

x = "Population (log)",

y = "Country")

```

{% include figure.html filename="en-or-urban-demographic-data-r-ggplot2-19.png" alt="Ridge plot showing the population (log) of different countries origins." caption="Figure 19. Extending ggplot2 with the package ggridges." %}

The graph reveals important demographic patterns across different urban centers. This visualization of population distributions shows how urban demographic patterns vary by country. For example, Poland and Portugal show distinct demographic profiles, with their urban centers tending toward larger population sizes, as indicated by the peaks on the right side of their respective density curves. 

## Conclusion

Through our analysis of sister-city relationships in Europe using ggplot2 and its extensions, we've demonstrated how different visualization techniques can reveal patterns in urban networks and demographic characteristics. The dataset allowed us to uncover several key insights: cities tend to form partnerships within a 500-1000 km radius, countries vary significantly in their preference for domestic versus international partnerships, and population size plays a role in partnership formation. 

However, this is just the tip of the iceberg of ggplot2's possibilities. With an extensive ecosystem of extensions and packages, ggplot2 offers endless opportunities for customization and adaptation to specific data visualization needs. Whether you're working with time series data, network graphs, or geospatial information, there's likely a ggplot2 extension that can help you create compelling and informative visualizations. As you continue to explore and work with ggplot2, remember that effective data visualization is an iterative process that requires experimentation, refinement, and a keen understanding of your audience and communication goals. By mastering the principles and techniques this tutorial covers, you will be well-equipped to create impactful visualizations that illuminate the stories hidden within your data.

## Additional Resources

To gain a better understanding of ggplot2, We recommend you take a look at some of the following sources to gain a more thorough understanding:

* The [official Site](https://ggplot2.tidyverse.org/) for ggplot2.

* Hadley Wickham's books [`ggplot2`: Elegant Graphics for Data Analysis](https://ggplot2-book.org/) and [R for Data Science](https://r4ds.had.co.nz/).

* Hadley Wickham's [original paper](https://www.tandfonline.com/doi/abs/10.1198/jcgs.2009.07098) on the grammar of graphics.

* The [original book](https://www.springer.com/gp/book/9780387245447) by Leland Wilkson on the Grammar of Graphics.

* [Tutorial on [r-statistics.co](http://r-statistics.co)](http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html) by Selva Prabhakaran.

* Video by Data Science Dojo on an [Introduction to Data Visualization with ggplot2](https://www.youtube.com/watch?v=NXjPcXx42Yc).

* UC Business Analytics [R Programming Guide](https://uc-r.github.io/ggplot_intro).

* Official ggplot2 [extensions page](https://www.ggplot2-exts.org/) and [accompanying gallery](http://www.ggplot2-exts.org/gallery/).

* R Project’s [overview of extending ggplot2](https://cran.r-project.org/web/packages/ggplot2/vignettes/extending-ggplot2.html).

* The [documentation](https://ggplot2.tidyverse.org/reference/) of the package provides a general overview.

* The [Cookbook for R](http://www.cookbook-r.com/Graphs/) book (based on the work [R Graphics Cookbook. Practical Recipes for Visualizing Data](http://shop.oreilly.com/product/0636920023135.do) by Winston Chang).

* The R cheatsheet that you can find [here](https://www.rstudio.com/resources/cheatsheets/).

* To explore different gradient scales, see the following [documentation page](http://ggplot2.tidyverse.org/reference/scale_gradient.html).
