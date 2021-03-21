---
title: "Visualizing data with R and ggplot2"
date: '2018-03-16'
difficulty: 4
layout: default
reviewers:
- ~
authors: Igor Sosa Mayor and Nabeel Siddiqui
---

# Introduction, Lesson Goals and Data

Gathering and analyzing data are important tasks historians now face, and plots are an important instrument in visualizing this data. Using R and the powerful package [ggplot2](http://ggplot2.tidyverse.org/), we can create useful, beautiful plots to see inside our data and publish our findings.

By the end of this lesson, you will be able to do the following with ggplot2: 

1. Create different types of plots: barplots, histograms, boxplots, scatterplots, etc.
2. Manipulate the aesthetic of plots, such as colors or sizes.
3. Add meaningful labels to plots.
4. Create grids of plots to compare data.
5. Create new types of plots with ggplot2 extensions.

In order to follow this tutorial, you should have rudimentary knowledge of R. The Programming Historian has lessons covering different topics. We recommend beginning with Taryn Dewar's [R Basics with Tabular Data](https://programminghistorian.org/en/lessons/r-basics-with-tabular-data) and Nabeel Siddiqui's [Data Wrangling and Management in R](https://programminghistorian.org/en/lessons/data_wrangling_and_management_in_R).

## ggplot2: General Overview 

There are several ways to analyze prepared data, but in this tutorial, we will concentrate on graphical representation. In R, there are three possibilities for creating graphs: the [plotting functions](https://stat.ethz.ch/R-manual/R-devel/library/graphics/html/plot.html) provided by the standard installation of R, the package [lattice](http://lattice.r-forge.r-project.org/), and finally [ggplot2](http://ggplot2.tidyverse.org/), created by [Hadley Wickham ](http://hadley.nz/).

Why should you use ggplot2 over these other possiblities? If you plan to work with R, ggplot2 has many advantages:

1. It is powerful and simple to use.
2. It creates beautiful, publication-ready graphs.
3. It has [extensions](http://www.ggplot2-exts.org/) that the community continously develops to enhance the possibilities of ggplot2, such as adding new functions, graphs, and themes.
4. It can create geographic maps.

Creating graphics is a complicated issue. We have to take into account various aspects of our data: the information we want to convey, how to display this information (scatterplots, boxplots, histogramms, and so on), the aspects of a plot that we can adapt (axes, transformation of variables, legends, etc.), and more. To provide a common framework, ggplot2 is based on a theoretical book which proposes a _[grammar of graphics](https://www.amazon.com/Grammar-Graphics-Statistics-Computing/dp/0387245448/ref=as_li_ss_tl?ie=UTF8&qid=1477928463&sr=8-1&keywords=the+grammar+of+graphics&linkCode=sl1&tag=ggplot2-20&linkId=f0130e557161b83fbe97ba0e9175c431)_ (hence the _gg_ in the name ggplot2) written by [Leland Wilkinson](https://en.wikipedia.org/wiki/Leland_Wilkinson). But, don't panic! You don't have to know anything about the grammar but the core idea, which is that plots are made of independent components that can be composed in a myriad of ways.

There is plenty of information about ggplot2 on the web, but we recommend:

1. The book written by the author himself, which is available for [free online](https://github.com/hadley/ggplot2-book)) and as a [printed copy](http://www.springer.com/br/book/9783319242750). 
2. The [documentation](http://docs.ggplot2.org/current/) of the package that provides a general overview.
3. The [Cookbook for R](http://www.cookbook-r.com/Graphs/) book (based on the work _[R Graphics Cookbook. Practical Recipes for Visualizing Data](http://shop.oreilly.com/product/0636920023135.do)_ by Winston Chang).
4. The R cheatsheet that you can find [here](https://www.rstudio.com/resources/cheatsheets/).
5. For a more detailed overview of how R implements the grammar of graphics, read Hadley Wickham's [original paper](https://www.tandfonline.com/doi/abs/10.1198/jcgs.2009.07098). 

As mentioned above, the idea behind the grammar of graphics is that all plots are composed of a series of interrelated layers we can manipulate to create visualizations. It divides plots into seven elements:

1. Data: The material we will analyze for our visualization.
2. Aesthetics: The mapping of visual properties to geoms.  In most cases, this determines how we want to display our data (position, color, shape, fill, size, etc.)
3. Scales: The mapping and normalization of data for the purposes of our visualization.
4. Geometric Objects: The way we want to represent our data.  For all intensive purposes, you can think of this as determining the type of graph you want, such as bar graph, line graph, or histogram.
5. Statistics: Further statistical analysis on our data we can conduct while visualizing it.
6. Facets: The ability to categorize and divide data into multiple graphs.
7. Coordinate systems: Determines how we map different positions onto our visualization. The most common coordinate system is the Cartesian coordinate system, but ggplot2 can also plot polar coordinates and spherical projections. 

# Installing GGPlot2

To use ggplot2, we have to install and load it. We recommend installing the [tidyverse](https://www.tidyverse.org) metapackage, which includes ggplot2. The tidyverse provides a group of libraries that work together in a unified structure and philosophy.

```
install.packages("tidyverse")
library("tidyverse")
```

# Sister cities in Europe

We will look at [sister cities](https://en.wikipedia.org/wiki/Sister_city) around the world. As historians, we can ask new questions about economic, religious, and cultural relationships by examining this data. For instance, are German cities related to French or Polish cities, maybe as an attempt to overcome deep historical tensions? Do Spanish cities create more relationships to other Spanish-speaking American cities? Do small cities (<10000 population) also have such relationships? Are European Union cities related to other European Union cities? Do cities in former communist countries have more relationships with other communist countries? 

## Loading Data with readr

Before importing data, it is important to understand the ways it may be formatted. Common spreadsheet applications, such as Microsoft Excel or Apple Numbers, place data in a proprietary format.  While there are packages to read in Excel data, such as [readxl](https://readxl.tidyverse.org/), it is recommended to use open formats, such as CSV (comma-separated values) or TSV (tab-separated values). R has built in commands for reading in these files, but we will use the package [readr](https://readr.tidyverse.org/) from the tidyverse ecosystem.

readr can read most of the common formats you will encounter, but we will be reading in a csv file. Lets go ahead and download the dataset and place it in the current working directory of your project.  Load the readr library and read in the csv using the [read_csv()](https://readr.tidyverse.org/reference/read_delim.html) function.

```
eudata<-read_csv("sistercities.csv")
```

Let's take a look at our data:

```
eudata
# A tibble: 13,081 x 12
[etc]

```

As you can see, the tidyverse converts our data to a "tibble" rather than a "data frame". Tibbles are a part of the tidyverse universe that serve the same function as data frames but make decisions on the backend regarding importation and displaying the data.

R is a relatively old language, and as a result, defaults that made sense during the original implementation are less helpful now. Tibbles, unlike data frames, do not change the name of variables, convert the type of input, or create row names. You can learn more about tibbles [here](https://r4ds.had.co.nz/tibbles.html). If this does not make sense, don't worry! In most cases, we can treat tibbles exactly like data frames. If you need to convert your data frame to a tibble, use the `as_tibble()` function with the name of the data frame as the parameter. Likewise, to convert back to a data frame, use the `as.data.frame()` function. 

We will use the data of six EU-countries: Germany, France, Poland, Hungary, Portugal, Bulgaria (three Western Europian countries and three Eastern Europian countries). As you can see, we have a tibble called "eudata" with six countries. There are 13081 rows with 12 variables.

The following information is present in the tibble: the "origin city", that is the city whose sister cities we are looking for (in the column origincityLabel), the country (origincountry), the coordinates (in originlat and originlong) and the population (originpopulation). The same information is present for the sister city. Moreover we have two other columns: column dist indicates the distance between the two cities (in km) and the categorial column eu that informs us whether the "destination city" is in the EU or not.

# Creating a bar graph

Let's begin with a small example. An interesting question we can ask our data is whether european cities have more profound relationships with cities in the same country, in other EU countries, or other countries in the world. We can inspect this question graphically by plotting a bar graph to show which percentage of destination cities are in the same country, how many in other EU-country, and how many are outside the EU. In ggplot2, we begin with the following code:

```
ggplot(eudata, aes(x = typecountry)) + geom_bar() 
```
![plot01](images/visualizing-data-with-r-and-ggplot2/plot01.png)

The first parameter of the ggplot() function is the tibble or data frame containing the information we are exploring. The second parameter reflects the “aesthetics” of the graph. Aesthetics, as you may recall from earlier, defines the variables in our data and how we want to map them to visual properties. These two layers are the basis of any plot, but we still need to tweak a variety of visualizations.

The `geom()` (from _geometries_) layer tells ggplot2 the type of graph we want to produce. Since we want to create a barplot, we need the `geom_bar()` layer. Adding layers is achieved by the `+` command.

Gaining an understanding of the `ggplot()` syntax can be tricky at first, but once it makes sense, you see the power of ggplot2. One trick to learn ggplot2 is to think about the creation of plots like the construction of sentences. In our example, we told R the following: "create a ggplot graph using the data in `eudata` and map the variable `typecountry` to x and add a layer of `geom_bar()`". This structure is straightforward except for the use of [aes()](http://ggplot2.tidyverse.org/reference/aes.html), which means in ggplot parlance _aesthetics_. It is not a telling expression, but the idea is simple: we tell R that it has to map variables in the data to visual properties (aesthetics) of geoms in the graph. Again, do not panic if you do not understand it completely. We will go into more depth later.

Now we have our first plot with ggplot2! You may notice that ggplot2 has taken some decisions on its own: background color, fontsize of the labels, etc. Later on in the tutorial, we will see how to improve the quality and appearance of the plot.

Although it is a start, our plot does not convey all the information we wanted. It only represents the raw count rather than the percentages. There are several ways to fix this, but the easiest one is to transform our data. Using the following code, we create a new tibble that aggregates the data per type of country and adds a new column named `perc` with the percentage values (again: see the [tutorial](https://programminghistorian.org/lessons/data_wrangling_and_management_in_R) about `dplyr` for details):

```
# we aggregate the data per type of country and add a new column with percentages
eudata.perc <- eudata %>%
   group_by(typecountry) %>%
   summarise(total = n()) %>%
   mutate(perc = total/sum(total))

ggplot(data = eudata.perc, aes(x = typecountry, y = perc)) +
   geom_bar(stat = "identity")
```
![plot02](images/visualizing-data-with-r-and-ggplot2/plot02.png)

There is an important difference between the first plot and this one. In the previous plot, ggplot2 counted  the number of cities in every group (in the original dataframe, this is not present). In our new plot, the tibble contains the values for the bars. This information is in the column `perc`, so we add `y = perc` as a parameter of `aes()`, but this is not enough. The tricky part is that by default `geom_bar()` will use the parameter `stat = "count"`. This means that it will count how many times a value appears. In other words, it aggregates the data for you. Since the data is already aggregated, we  just inform ggplot2 that the values are there by passing the parameter `stat = "identity"`. 

With this graph, we can still not compare countries. We can achieve our goals by two means: by using a bar for every country or by making a graph for each country (`facetting` in ggplot2 parlance). Let's see  how to create a plot which splits the information per country:


```
# we aggregate the data per country and type of country and add a new column with percentages
eudata.perc.country <- eudata %>%
   group_by(origincountry, typecountry) %>%
   summarise(total = n()) %>%
   mutate(perc = total/sum(total))

ggplot(data = eudata.perc.country, aes(x = typecountry, y = perc, fill = origincountry)) +
   geom_bar(stat = "identity", position="dodge")
```
![plot03](images/visualizing-data-with-r-and-ggplot2/plot03.png)

Again, we need to manipulate the data to the form we want by aggregating per country and type (EU, non-EU, etc).  We passed a new parameter to the `ggplot()` command named `fill` that indicates the column for different bars. We also add the parameter `position` to `geom_bar()` so that the bars do not get stacked (which is the default) but are instead placed side by side. By using `fill`, ggplot2 has chosen colors for the columns of the graph according to the countries. 

Finally, we can analyze our data. As we can see, most countries analyzed have strong relationships with other EU countries with around 70-80% having this relationship (Germany, France, Hungary,...). Two countries, Bulgaria and Portugal, have as many relationships with EU as with non-EU countries. Perhaps, this is related to the colonial past (in the case of Portugal), but we have to investigate further. 


# Other Geoms: Histograms, Distribution Plots and Boxplots

We have seen the key syntax needed to operarate ggplot2: adding layers and adding parameters to those layers. One of the most important layers is the `geoms`. Using this layer is straightforward in ggplot2: every plot type has a `geom` which can be added to `ggplot()`. For [histograms](http://ggplot2.tidyverse.org/reference/geom_histogram.html), we have `geom_histogram()`, for [boxplots](http://ggplot2.tidyverse.org/reference/geom_boxplot.html) `geom_boxplot()`, for [violin plots](http://ggplot2.tidyverse.org/reference/geom_violin.html) `geom_violin()`, for [dotplots](http://ggplot2.tidyverse.org/reference/geom_dotplot.html) `geom_dotplot()`, for [scatterplot](http://ggplot2.tidyverse.org/reference/geom_point.html) `geom_point()`, and so on. Every command has parameters that let us configure aspects of the `geom()`,such as size of the points, and colors. 


Let's examine the distribution of the variable `dist` in our data representing the distance (in kilometers) between sister cities. We will compare distance distribution by using a boxplot. Now, we can tentatilvely answer whether cities in the six analyzed countries have relations with cities in their proximity or not. 


The distribution of the variable `dist` is skewed, since some (~900 of 13000) of the cities are far away. This leads to an uninformative histogram. We can take `log10(dist)` as our variable or filter to exclude values above 5000kms. None of these methods is ideal, but as far as we know, we are operating with manipulated data making it less problematic. Take a look at the simple code: 

```
# we filter the data. Remember that you have to
# load tidyverse or dplyr, otherwise filter will throw an error
eudata.filtered <- filter(eudata, dist < 5000)

ggplot(eudata.filtered, aes(x=dist)) + geom_histogram()
```
![plot04](images/visualizing-data-with-r-and-ggplot2/plot04.png)


As you see, we have to add the layer `geom_histogram()`. However, making a good histogram is not easy. ggplot2 displays a warning that it has defaulted our binwidth to 30 (`bins=30`) and recommends to pick a better value with `binwidth`. Explore the help page of [geom_histogram()](http://ggplot2.tidyverse.org/reference/geom_histogram.html) to look at more possibilities for configuration.


What about the data? The plot shows that most sister cities are in a radius of c.1000kms. But, maybe this is a distortion caused by our manipulation of the data. A [cumulative distribution function](https://en.wikipedia.org/wiki/Cumulative_distribution_function) (ECDF) provides a visualisation of this issue. In ggplot2, we achieve it with this command: 

```
ggplot(eudata, aes(x=dist)) + stat_ecdf()
```
![plot05](images/visualizing-data-with-r-and-ggplot2/plot05.png)

We again use our non-filtered data (the dataframe `eudata`) and confirm our previous observation, since approximately 75% of the cities are in a radius of c.1000kms. Even more interesting: ~50% seem to be related to cities which are not further than 500kms away.


Finally, we use a boxplot to determine differences among countries. In other words, whether cities of some countries tend to establish relationships with distant or close cities: 

```
ggplot(eudata, aes(x = origincountry, y = dist)) + geom_boxplot()
```
![plot06](images/visualizing-data-with-r-and-ggplot2/plot06.png)

The plot shows that German cities have a tendency to establish sister cities in their proximity. If you do an [ANOVA](https://en.wikipedia.org/wiki/Analysis_of_variance) test, you will see that the differences between countries are statistically significant. It is up to you as a historian to explore explanations for this fact. 

## Manipulating the Look of Graphs

We have played with different `geoms`, but we did not change the aesthetic decisions ggplot2 made for us. It's time to take a look at the`scales` function. Let's begin with a small example which we will modify. Our data contains the population of both the origin and destination cities. We could be interested in knowing whether population is a related variable. Put another way, are small/big cities more often related to cities in their population range? We can use a [scatterplot](https://en.wikipedia.org/wiki/Scatter_plot) showing population data for both cities:


```
# we extract a random sample of 15% of the cities
eudata.sample <- sample_frac(eudata, 0.15)


# we create the plot
ggplot(data = eudata.sample,
      aes(x = log(originpopulation),
          y = log(destinationpopulation))) +
      geom_point()
```
![plot07](images/visualizing-data-with-r-and-ggplot2/plot07.png)

Since the dataframe `eudata` has many points, this leads to overplotting. Therefore, we select a random sample of 15% of the cities in our dataframe with the function [sample_frac()](http://dplyr.tidyverse.org/reference/sample.html). We also use the natural log of the population data to overcome skewness.

But, we want to make changes to the graph adding information. There are three different elements worth looking at:

1. Every ggplot2 function (eg. `geom_point()`) can take arguments to modify concrete aspects, 
2. `scales` control how variables are mapped from the data to the plot. This affects axes, legends, etc.
3. `themes` refer to the 'static' elements of the plot: the background's elements (color, lines, etc.), the fontsize, etc. 

We will begin with a transformation: we want to change the size and the color of the points:


```
ggplot(data = eudata.sample,
      aes(x = log(originpopulation),
          y = log(destinationpopulation))) +
      geom_point(size = 3, color = "red")
```
![plot08](images/visualizing-data-with-r-and-ggplot2/plot08.png)

As you can see, we can do this easily: every function can take paramaters that influence how the function works. In this case, we passed the function `geom_point()` different arguments (`size` and `color` or `colour`). To find out other arguments that are avalaible, you can visit the help page of `geom_point()` by typing `?geom_point` in R or here [online](http://ggplot2.tidyverse.org/reference/geom_point.html).


The plot looks a bit better, but there are still a lot of things to improve. For instance, we want to add titles to the axes. Manipulating axes (and legends) is done by using the corresponding `scales` functions, which we will cover later on. But since changing the titles is a very common action, ggplot has a shorter command to achieve it: [labs()](http://ggplot2.tidyverse.org/reference/labs.html) (which stands for _labels_):

```
ggplot(data = eudata.sample,
      aes(x = log(originpopulation),
          y = log(destinationpopulation))) +
   geom_point(size = 3, color = "red") +
   labs(title = "Population data of origin and destination city",
        caption = "Data: www.wikidata.org",
        x = "Population of origin city (log)",
        y = "Population of destination city (log)")
```
![plot09](images/visualizing-data-with-r-and-ggplot2/plot09.png)

If we are happy with our graph, we can save it:

```
ggsave("eudata.png")

# for getting a pdf
# ggsave("eudata.pdf")
```

This will create a [PNG](https://en.wikipedia.org/wiki/Portable_Network_Graphics) file with the last plot we have constructed. The function `ggsave()` has [many parameters](http://ggplot2.tidyverse.org/reference/ggsave.html) you can adjust (dpi, height, width, format, etc.).

In many cases, we may also want to add information to the graph using different colors (or shapes). For instance, we could color the points of our previous scatterplot to represent different types of cities (in the same country, in a EU-country or in a non-EU-country):


```
ggplot(data = eudata.sample,
      aes(x = log(originpopulation),
          y = log(destinationpopulation))) +
   geom_point(size = 3, alpha = 0.7, aes( color = typecountry )) +
   labs(title = "Population data of origin and destination city",
        caption = "Data: www.wikidata.org",
        x = "Population of origin city (log)",
        y = "Population of destination city (log)")

```
![plot10](images/visualizing-data-with-r-and-ggplot2/plot10.png)

We did two major manipulations to this plot. First,we modified `geom_point()` by adding an argument: `aes(color = typecountry)`. You may be wondering why we use `aes()` and not just `color = typecountry` without putting it inside of `aes()`? You can try it on your own (you will get an error). The reason is that, by using `aes()`, we are telling ggplot2 that it needs to map the argument color to the variable `typecountry`. Put more simply: we let ggplot2 know that `typecountry` is a variable of the data we are using. Inside `aes()`, we could have chosen another aspect, for instance the shape and relate it to a variable with `aes(shape = typecountry)`.

Since there are too many points, we have also added the parameter `alpha` to make them transparent. ggplot2 has again made decisions for us by selecting default colors and a legend to the graph.

# Scales: Colors, Legends, and Axes

We can modify colors and legend with scale. Scales provide tools that let us read the plot: the axes and legends. Scales may be the least intuitive element of ggplot2. The naming scheme for scales is made up of three pieces separated by a “_” character:

1. scales.
2. the name of the aesthetic (e.g., colour, shape or x).
3. the name of the scale (e.g., continuous, discrete, brewer).

Let's take a look at it with our previous graph. In our last graph, we control three different scales: 

1. `scales_x_continuous()`, which controls the data of the x-axis (when `x` is continuous).
2. `scales_y_continuous()`, which controls the data of y-axis (when `y` is continuous).
3. `scales_colour`, which controls the color(s) used.

We can change the colors of our graphs by manually passing colors or using a predefined color scala.

First, we store our graph in a varible to make it reusable, changing only some aspects. This is a very convenient way of ggplot2 to make different versions of the same graph:


```
p1 <- ggplot(data = eudata.sample,
      aes(x = log(originpopulation),
          y = log(destinationpopulation))) +
      geom_point(size = 3, alpha = 0.7, aes( color = typecountry )) +
      labs(title = "Population data of origin and destination city",
        caption = "Data: www.wikidata.org",
        x = "Population of origin city (log)",
        y = "Population of destination city (log)")
```

Now, we can add the colors using `scale_colour_manual()`. In this case, we use colors which are [R has already defined](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf). We could also use hexadecimal codes for specific colors. As you see, [scale_colour_manual()](http://ggplot2.tidyverse.org/reference/scale_manual.html) takes a compulsory argument (`values =`), namely a vector with the names of colors. 

```
p1 + scale_colour_manual(values = c("red", "blue", "green"))
```
![plot11](images/visualizing-data-with-r-and-ggplot2/plot11.png)

In this way, we can create graphs with our preferred colors. But, it is better to use already defined colors scalas when possible, such as the [color brewer palettes](http://colorbrewer2.org/). ggplot2 has already these palettes [integrated](http://ggplot2.tidyverse.org/reference/scale_brewer.html) and a specific `scale` for using them (`scale_colour_brewer()`):

```
p1 + scale_colour_brewer(palette = "Dark2") # you can try others such as "Set1", "Accent", etc.
```
![plot12](images/visualizing-data-with-r-and-ggplot2/plot12.png)

Let's look at a slightly different example. In the last graph, we used a qualitative variable (`typecountry`) with different colors. But, what if we wanted to use a continuous variable? Let's say we want to add information to our plot including the distance between the cities (we again use the log of the distance because of skewness). We want to use the intensity of red to represent the distance to represent the distance:


```
p2 <- ggplot(data = eudata.sample,
      aes(x = log(originpopulation),
          y = log(destinationpopulation))) +
      geom_point(size = 3, aes( color = log(dist) )) +
      labs(title = "Population data of origin and destination city",
        subtitle = "Colored by distance between cities",
        caption = "Data: www.wikidata.org",
        x = "Population of origin city (log)",
        y = "Population of destination city (log)")

p2
```
![plot13](images/visualizing-data-with-r-and-ggplot2/plot13.png)

As you can see, there are two problems with this graph: 

1. Blue is the used color and not red,
2. The scala is unconvincing since smaller distances are represented by a darker blue. 

We need to use scales again but in this case with another function. ggplot2 does not use discrete colors (that is, one color for every distinct value of the qualitative variable), but only a single gradiented color. For this reason, the scale we want to use deals with gradients. There are [several methods for doing this](http://ggplot2.tidyverse.org/reference/scale_gradient.html). We will use `scale_colour_gradient`. We can define the low and the high value of the gradient: 


```
p2 + scale_colour_gradient(low = "white", high = "red3")
```
![plot14](images/visualizing-data-with-r-and-ggplot2/plot14.png)

Different gradient scales (`scales_colour_gradient2` and `scales_colour_gradientn`) have different possibilities. We encourage you to explore them by looking at the [documentation page](http://ggplot2.tidyverse.org/reference/scale_gradient.html). 

As you can see from the plot, small cities tend to establish relationships with cities which are not so distant.

Finally, we will modify the legend, which, as mentioned earlier, is (as we have already mentioned) controlled by the scales:

```
p2 <- p2 + scale_colour_gradient(low = "white",
                                high = "red3",
                                guide = guide_colorbar(title = "Distance in log(km)",
                                                 direction = "horizontal",
                                                 title.position = "top"))
 
p2
```
![plot15](images/visualizing-data-with-r-and-ggplot2/plot15.png)

The legend is controlled by the parameter [guide](http://ggplot2.tidyverse.org/reference/guides.html). We tell ggplot2 to use a [guide_colorbar()](http://ggplot2.tidyverse.org/reference/guide_colourbar.html) with the parameters for the title (caption, position, etc.). 


# Faceting a Graph

Previously, we created a plot which compared cities and their relationships with cities in EU countries, non-EU countries using different colors for each country. ggplot2 also provides an effective way to create plots that include information splitted by categories (space, time, and so). We can represent the same data, but in graphs we separate per country. ggplot2 has powerful possibilities, which are summarised under the label _[facetting](http://ggplot2.tidyverse.org/reference/index.html#section-facetting)_. The most simple facetting function is [facet_wrap()](http://ggplot2.tidyverse.org/reference/facet_wrap.html), but you can also take a look at the richer [facet_grid()](http://ggplot2.tidyverse.org/reference/facet_grid.html).

Using our previous dataframe `eudata.perc.country`, we can add a layer in the following way:

```
ggplot(eudata.perc.country, aes(x = typecountry, y = perc)) +
   geom_bar(stat = "identity") +
   facet_wrap(~origincountry)
```
![plot16](images/visualizing-data-with-r-and-ggplot2/plot16.png)

We have added `facet_wrap(~origincountry)` layer to the previous command. This tells ggplot2 to create one graph per country. The `~` operator is important to note as R uses it for formulae. We can also control the number of rows and columns in the grid.


# Themes: Changing Static Elements 

Since modifying the appearance of graphs is a frequent task, ggplot2 also has `themes`. `themes` are one of the most powerful and rich features of ggplot2, which makes it impossible to fully cover in this lesson. However, we will mention two aspects to get you started. First, ggplot2 comes with a number of [built-in themes](http://ggplot2.tidyverse.org/reference/ggtheme.html). The most common are `theme_grey()` (the default), `theme_bw()`, `theme_dark()`, and `theme_void()`. Second, that you can easily create you own themes and use them in your plots. 

Using a theme diffent from the default one is simple. We apply it as a new layer using the `+` operator: 

```
p3 <- ggplot(eudata.perc.country, aes(x = typecountry, y = perc)) +
    geom_bar(stat = "identity") +
       facet_wrap(~origincountry)

p3 + theme_bw()
```
![plot17](images/visualizing-data-with-r-and-ggplot2/plot17.png)

Several packages add additional themes, such as [ggthemes](https://github.com/jrnold/ggthemes) or [ggtech](https://github.com/ricardo-bion/ggtech). In these, you will find themes such as `theme_excel` (a theme replicating the classic charts in Excel) and `theme_wsj` (a theme based on the plots in the _The Wall Street Journal_). To use *The Wall Street Journal Theme*, for example, we do the following:


```
install.packages("ggthemes")
library(ggthemes)

p3 + theme_wsj()
```
![plot18](images/visualizing-data-with-r-and-ggplot2/plot18.png)


# Extending ggplot2 with Other Packages

One of the strengths of ggplot2 is the massive [extensions](http://www.ggplot2-exts.org/) that the community has written. With them, you can create [network graphs](https://briatte.github.io/ggnetwork/), [radar charts](https://github.com/ricardo-bion/ggradar), [time series graphs](https://github.com/AtherEnergy/ggTimeSeries),  [ridgeline plots],(https://cran.r-project.org/web/packages/ggridges/vignettes/introduction.html) and many more. 

We will make a ridgeline plot to create the impression of a mountain range. These help visualize changes in distributions over time or space. In particular, we will visualize the population data of the origin cities. This code is simple enough (we use a log-transformation due to the data's skewness):


```
install.packages("ggridges")
library(ggridges)

ggplot(eudata, aes(x=log(originpopulation), y = origincountry)) +
    geom_density_ridges() +
    theme_ridges() +
    labs(title = "Population (log) of the origin cities",
         caption = "Data: www.wikidata.org",
         x = "Population (log)",
         y = "Country")
```

![plot19](images/visualizing-data-with-r-and-ggplot2/plot19.png)

The library `ggridges` adds a new layer `geom_density_ridges()` and a new theme `theme_ridges()` which expands R's plotting possibilities. 


# Additional Resource

This tutorial is just the tip of the iceberg of ggplot2's possibilities. We recommend you take a look at some of the following sources to gain a more thorough understanding:

* The [official Site](https://ggplot2.tidyverse.org/) for ggplot2.
* Hadley Wickham's books [ggplot2: Elegant Graphics for Data Analysis](https://ggplot2-book.org/) and [R for Data Science](https://r4ds.had.co.nz/).
* Hadley Wickham's [original paper](https://www.tandfonline.com/doi/abs/10.1198/jcgs.2009.07098) on the grammar of graphics.
* The [original book](https://www.springer.com/gp/book/9780387245447) by Leland Wilkson on the Grammar of Graphics.
* [Tutorial on r-statistics.co](http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html) by Selva Prabhakaran .
* Video by Data Science Dojo on an [Introduction to Data Visualization with ggplot2](https://www.youtube.com/watch?v=NXjPcXx42Yc).
* UC Business Analytics [R Programming Guide](https://uc-r.github.io/ggplot_intro).

For more ways to expand ggplot2, take a look at the resources below.

* Official ggplot2 [extensions page](https://www.ggplot2-exts.org/) and [accompanying gallery](http://www.ggplot2-exts.org/gallery/)

* R Project’s [overview of extending ggplot2](https://cran.r-project.org/web/packages/ggplot2/vignettes/extending-ggplot2.html)

