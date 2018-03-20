---
title: Visualizing data with R and ggplot2
authors:
- Igor Sosa Mayor 
date: 2018-03-16
reviewers:
- 
layout: default
difficulty: 4
---

# Introduction, lesson goals and data

Getting data and analyzing them is one of the most important tasks a historian has to face. Once you have your data, you have to analyze it. For this purpose plots are always an important instrument. Using R and the powerful package [ggplot2](http://ggplot2.tidyverse.org/) you can create useful, as well as beautiful plots to look inside your data and to publish in your work.

By the end of this lesson you will be able to do the following things with ggplot2: 

1. to create different types of plots: barplots, histograms, boxplots, scatterplots, etc.
2. to manipulate different options of your plots, such as colors or sizes 
3. to add meaningful labels to your plots 
4. to create grids of plots to compare data
6. to create new types of plots with ggplot2 extensions.

In order to follow this follow, you are supposed to have knowledge about R. PH has several lessons covering different topics [add refs!].

## Cities and their sister cities in Europe 

The analysis behind this tutorial is a very simple one. I was always fascinating by the fact that many cities have sister cities around the world. As a historian a lot of relevant questions arise out of this empirical fact. For instance, when did this phenomenon begin (probably in the 19th century)? Why are the reasons behind the whole phenomenon? And more concrete: which are the concrete reasons for a city to seek for such relationships (economic, religious, cultural)? Or even more concrete: are German cities related to French or Polish cities, maybe as a an attempt to overcome deep historical tensions? Have Spanish cities proportionally more relationships to the spanish-speaking American cities? Do small cities (<10000) have also such relationships? Are EU-cities more related to other EU-cities or is this aspect not relevant at all? Do cities of former communist countries have more relationships with other cities of the present Russia or other former communist countries? Many other questions could also be asked.

But: where do to get such data? [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page), the free and open knowledge base, is of course the best option, since it  has already this information which can be queried using [SPARQL](https://en.wikipedia.org/wiki/SPARQL) (a general and friendly introduction can be found [here](https://www.wikidata.org/wiki/Wikidata:A_beginner-friendly_course_for_SPARQL)). If you are interested in the complex queries used for doing it, you can find them [here](https://github.com/rogorido/sistercities/tree/master/sparql/queries). Exporting the results as CSV/TSV (comma/tab separated values) or JSON is the most simple solution to have them ready for further analysis in R. 

## Starting with R: getting and preparing the data

In the present tutorial we will use only the data of six EU-countries: Germany, France, Poland, Hungary, Portugal, Bulgaria (three of so-called Western Europe and three of so-called Eastern Europe). The data for these countries can be downloaded here (if you want to play with the raw data of all EU-countries you can find it here). 

You also can run the queries again changing, but be aware that the data you will download will not probably be exactly the same that you can find in the providad file, since the data in wikidata are continuously being updated. 

For this lesson, I recommend you that you create a directory in your computer for the project and inside another one called: `data`. Put the `tsv` file into this data directory, open R or Rstudio, make the project directory your working directory (with `setwd`) and then load the data into R. The code we will use can be found [here](code/code.R).

```{r}
# we load the data into a variable 
eudata <- read.csv("data/sistercities.tsv", header = T, sep = "\t")

# we inspect the data
str(eudata)
```

As you can see, we have a dataframe `eudata` with the data of the six countries. There are 13081 rows with 15 variables (if you have downloaded the data yourself, the number of rows can be different). The following information is present in the dataframe: the name of the "origin city", that is the city whose sister cities we are looking for (in the column `origincityLabel`), the country (`origincountry`), the coordinates (in `originlat` and `originlong`) and the population (`originpopulation`). The same information is present for the sister city. Moreover we have two other columns: column `dist` indicates the distance between the two cities (in km) and the categorial column `eu` informs us whether the "destination city" is in the EU or not. 

This data are however not complete and it is a good idea to add some information. We want to add two additional columns. The first one holds the information whether the sister city is in the same country as the origin city (`samecountry`). Additionally, we will create a column (`typecountry`) with a categorical variable with three values according to the fact of the sister city is in the same country, in a EU-country or in a non-EU-country.

I will not explain the details of these transformations. In order to manipulate data in R, we can use native functions of R (such as `ifelse()`) with functions provided by the package [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html) created by [Hadley Wickham ](http://hadley.nz/) (the author of ggplot2), which is included in the metapackage `tidyverse`. You can find a [good tutorial](https://programminghistorian.org/lessons/data_wrangling_and_management_in_R) about `dplyr` written by Nabeel Siddiqui. 

```{r}
install.packages("tidyverse")
library(tidyverse)

# we check whether the cities are in the same country and store the info
# in a new column which is then converted into a factor 
eudata$samecountry <- ifelse(as.character(eudata$origincountry) ==
                             as.character(eudata$destination_countryLabel), "same", "different")
eudata$samecountry <- as.factor(eudata$samecountry)

# we check whether both countries are in the EU and store the info 
# in a new column and then we convert the column into a factor 
# Note: you need at least dplyr version > 0.7 for this code to work!
eudata <- eudata %>% dplyr::mutate(typecountry = case_when(samecountry == "same" & eu == "EU" ~ "same",
                                             samecountry == "different" & eu == "EU" ~ "EU",
                                             samecountry == "different" & eu == "Non-EU" ~ "Non-EU"))
eudata$typecountry <- factor(eudata$typecountry)
```

If you do not want to follow these steps, you can download this dataframe [from here] and load it into R in this way:

```{r}
load("sistercities.Rdata")
```

# Graphics with ggplot2

There are several ways to analyze the data we have prepared, but in this tutorial we will concentrate on their graphical representation. In R there are three main possibilities to create graphs: the [plotting functions](https://stat.ethz.ch/R-manual/R-devel/library/graphics/html/plot.html) provided by the standard installation of R, the package [lattice](http://lattice.r-forge.r-project.org/), and finally [ggplot2](http://ggplot2.tidyverse.org/), created by [Hadley Wickham ](http://hadley.nz/).

## ggplot2: General aspects 

But why should you use ggplot2 at all? If you plan to work with R, ggplot2 has many advantages:

1. it is very powerful, but at the same time relatively simple, 
2. it creates beautiful publication-ready graphs,
3. it has a lot of [extensions](http://www.ggplot2-exts.org/) which are increasingly being developed by the community. They enhance the possibilities of ggplot2 by adding new functions, new types of graphs, new themes, etc.
4. it also has the possibility to create maps.

Creating good graphics is a complicated issue. You have to take into account many different aspects: the information you want to convey, the many possibilities of showing this information (scatterplots, boxplots, histogramms, and so on), the many aspects of a plot which can be adapted (axes, transformation of variables, legends, etc.), and so on. For this reason, ggplot2 is based on a theoretical book which proposes a so-called [*grammar of graphics*](https://www.amazon.com/Grammar-Graphics-Statistics-Computing/dp/0387245448/ref=as_li_ss_tl?ie=UTF8&qid=1477928463&sr=8-1&keywords=the+grammar+of+graphics&linkCode=sl1&tag=ggplot2-20&linkId=f0130e557161b83fbe97ba0e9175c431) (hence the *gg* in the name ggplot2) written by [Leland Wilkinson](https://en.wikipedia.org/wiki/Leland_Wilkinson). But, don't panic: you don't have to know anything about grammar. The main idea is that a plot is made up of a set of independent components that can be composed in many different ways. In brief we will see how to do it.

There is plenty of information about ggplot2 on the web, but I recommend you:

1. the best source of information is of course the book written by the author himself which has been recently [published](http://www.springer.com/br/book/9783319242750). The book is also available [online](https://github.com/hadley/ggplot2-book),
2. for a general overview of the package you can visit the [documentation](http://docs.ggplot2.org/current/) of the package,
3. very useful are also the webpage [Cookbook for R](http://www.cookbook-r.com/Graphs/) (based on the book [*R Graphics Cookbook. Practical Recipes for Visualizing Data*](http://shop.oreilly.com/product/0636920023135.do) by Winston Chang) and the cheatsheet you can find [here](https://www.rstudio.com/resources/cheatsheets/).

But, first of all, in order to use ggplot2 we have of course to install it. Actually I recommend to install the already mentioned metapackage [`tidyverse`](http://tidyverse.org/) which is a collection of packages written mainly by Hadley Wickham for doing most of the most operations with dataframes you will ever need ([`dplyr`](http://dplyr.tidyverse.org/), [`readr`](http://readr.tidyverse.org/), [`tidyr`](http://tidyr.tidyverse.org/), [`forcats`](http://forcats.tidyverse.org/), etc.). `ggplot2`is also included in the metapackage `tidyverse`.

```{r}
install.packages("tidyverse")
# or only ggplot2
# install.packages("ggplot2")
```

## A first example: a bar graph

Let's begin with a small example. An interesting aspect in our data relates to the question whether european cities have more profound relationships with cities in their same country, in other EU countries other elsewhere in the world.  Graphically we can inspect this aspect by plotting a bar graph to know which percentage of destination cities are in the same country, how many in other EU-country and how many outside the EU. In ggplot2 we could begin with the following code:

```{r}
ggplot(data = eudata, aes(x = typecountry))
```

If you press return now, you will be surprised: you will get an empty plot! Axes and plot area are there, but the data are not represented. This is however the expected behaviour. We have to tell ggplot2 which type of plot we want to create. That means: we need to add a layer to our plot. Adding different layers is the way to construct plots with ggplot2. In ggplot2 there are different types of layers. As we will see, there are plenty of different layers (and many more in packages which extend ggplot2 functionality). One crucial type is the so-called  `geom()` (from *geometries*) layer which tells ggplot2 which type of graph we actually want to produce. In our case since we want to create a barplot, we need the `geom_bar()` layer. Adding layers is a simple operation which is achieving by using the command `+`:

```{r}
ggplot(eudata, aes(x = typecountry)) + geom_bar() 
```
![plot10](images/plot10.png)

Let's take a look at the most important command in our example: `ggplot()` and its syntax which can be at the beginning a little strange.

A small trick to learn ggplot2 is to think about the creation of plots like the construction of sentences. In our example we are telling R the following: "create a ggplot graph using the data in `eudata` and map the variable `typecountry` to x and add a layer of `geom_bar()` ". As you can see, the structure is very straightforward, except for the use of [`aes()`](http://ggplot2.tidyverse.org/reference/aes.html), which means in ggplot parlance *aesthetics*. It is not maybe a very telling expression, but the idea is very simple: we tell R that it has to map variables in the data to visual properties (aesthetics) of geoms in the graph. Do not panic if you do not understand it completely by now. We will go into depth in brief.

Now we have our first plot with ggplot2. As you can see, ggplot2 has taken some decisions on its own: background color, fontsize of the labels, etc. I think you would like to improve the quality and appearance of the plot and later on in this tutorial we will see how to do it.

However, this plot does not convey the information we wanted, since it represents raw count data and not percentages. There are several ways to achieve it. One of them is transforming the data. Using the following code we create a new dataframe which aggregates the data per type of country and adds a new column named `perc` with the percentage values (again: see the [tutorial](https://programminghistorian.org/lessons/data_wrangling_and_management_in_R) about `dplyr` for details):

```{r}
# we aggregate the data per type of country and add a new column with percentages
eudata.perc <- eudata %>%
    group_by(typecountry) %>%
    summarise(total = n()) %>%
    mutate(perc = total/sum(total))

ggplot(data = eudata.perc, aes(x = typecountry, y = perc)) +
    geom_bar(stat = "identity")
```
![plot11](images/plot11.png)

There is an important difference between the first barplot and this one. In our previous plot ggplot2 counted itself the number of cities in every group (in the original dataframe this information is not present). But in this case our dataframe already contains the value ggplot2 must use for plotting the bars. Therefore we have to provide ggplot2 with the information where it can find this value. This information is in the column `perc`, so we add  `y = perc` as a parameter of `aes()`. But this is not enough. The tricky point is that per default `geom_bar()` uses internally the parameter `stat = "count"`. This means that, as already mentioned, it will count how many times a value appears (in other words: it aggregates the data for you). Having the data already aggregated, we have just to inform ggplot2 that the values are already there by passing the parameter `stat = "identity"`. 

Nevertheless, with this graph we can not compare countries. This could be achieved by two means: either by using a bar for every country or by making a graph for each country (`facetting` in ggplot2 parlance). Let see now how to create a plot which splits the information per country

```{r}
# we aggregate the data per country and type of country and add a new column with percentages
eudata.perc.country <- eudata %>%
    group_by(origincountry, typecountry) %>%
    summarise(total = n()) %>%
    mutate(perc = total/sum(total))

ggplot(data = eudata.perc.country, aes(x = typecountry, y = perc, fill = origincountry)) +
    geom_bar(stat = "identity", position="dodge")
```
![plot25](images/plot25.png)

Again, we have to manipulate the data to get it/them in the form we need, aggregating per country and per type of country (EU, non-EU, etc). But let's take a look at the command for the plot. We passed a new parameter to the `ggplot()` command, namely `fill` indicating the column we want to use for the different bars. And we add the parameter `position` to `geom_bar()`, to achieve that the bar do not get stacked (which is the default), but put side by side. By using `fill` ggplot2 has chosen some colors for use and has colorized the columns of the graph according to the countries. 

As for the results, we can see that most of the countries analyzed have strong relationships with other EU countries with around 70-80% (Germany, France, Hungary,...). However, two others, Bulgaria and Portugal, have so many relationships with EU as with non-EU countries, which is maybe related to the colonial past (in the case of Portugal). This will need of course further investigations. 

## Other `geom`s: histograms, distribution plots and boxplots

So far we have seen the two most important syntax aspects needed for operate with ggplot2: adding layers and adding parameters to these layers. As I have already mentioned, one of the most important type of layers are the so called `geom`s. Using these layers is pretty straightforward in ggplot2: every plot type has a `geom` which can be added to `ggplot()`. For [histograms](http://ggplot2.tidyverse.org/reference/geom_histogram.html) we have `geom_histogram()`, for [boxplots](http://ggplot2.tidyverse.org/reference/geom_boxplot.html) `geom_boxplot()`, for [violin plots](http://ggplot2.tidyverse.org/reference/geom_violin.html) `geom_violin()`, for [dotplots](http://ggplot2.tidyverse.org/reference/geom_dotplot.html) `geom_dotplot()`, for [scatterplot](http://ggplot2.tidyverse.org/reference/geom_point.html) `geom_point()`, and so on. Every command can have parameters which let us configure aspects of the `geom()` (size of the points, colors, and so on). 

We want now to take a lot at the distribution of the variable `dist` in our data, that is the distribution of the distances in kilometres of the sister cities. Doing so, we can analyze whether the cities with which the origin cities have a relationship are distant or not. We will then compare distributions of distances by using a boxplot to see differences between countries. We could so tentatively answer the question whether cities in the six analyzed countries tend to have relations with cities in their proximity or not. 

The distribution of the variable `dist` is very skewed, since some (~900 of 13000) of the cities are very far away. This leads to a histogram which is not very informative. We can either take `log10(dist)` as our variable, that is, using the logarithm of the value, or filter the data to exclude the values above 5000kms. Honestly speaking, none of these methods is really convincing, but as far as we know that we are operating with manipulated data it is not so dangerous. Let's take a look at the simple code: 

```{r}
# we filter the data. Remember that you have to
# load tidyverse or dplyr, otherwise filter will throw an error
eudata.filtered <- filter(eudata, dist < 5000)

ggplot(eudata.filtered, aes(x=dist)) + geom_histogram()
```
![plot23](images/plot23.png)

As you see, we have just to add the layer `geom_histogram()` and ggplot2 plots what we want. However, making a good histogram is not an easy issue. ggplot2 gives us a warning that it has used internally the parameter `bins=30` and recommends us to pick a better value with `binwidth`. I recommend you to take a look at the help page of [geom_histogram()](http://ggplot2.tidyverse.org/reference/geom_histogram.html) for the many possibilities of configuration.

But, what about the data? The plot shows us that most of the sister cities are in a radius of c.1000kms. But maybe this is a distortion caused by our manipulation of the data. A cumulative distribution function (ECDF) provides a visualisation of this issue. In ggplot2 we can achieve it with this simple command: 
```{r}
ggplot(eudata, aes(x=dist)) + stat_ecdf()
```
![plot22](images/plot22.png)

We use here again our non-filtered data (the dataframe `eudata`) and we confirm our previous observation, since more or less 75% of the cities are in a radius of c.1000kms. Even more: ~50% seem to be related to cities which are not further than 500kms away. 

Finally we can use a boxplot to see whether there are differences among countries. In other words, whether the cities of some countries tend to establish relationships with distant or close cities. Again doing this in ggplot2 is pretty easy: 
```{r}
ggplot(eudata, aes(x = origincountry, y = dist)) + geom_boxplot()
```
![plot24](images/plot24.png)

The plot shows that above all German cities have a tendency to look for sister cities in their proximity. If you do an ANOVA test you will see that the differences among the countries are statistically significant. It is up to you to think about hypotheses which could explain this fact. 

## Adding information to graphs (colors, shapes, etc.).

Til now we have played with different `geom`s, but we did not change the default aesthetic decisions that ggplot2 made for us. It's time to take a look at the important function `scales`. Let's begin with a small example which we will slowly modify. In our data we have the population of the origin city and the destination city. We could be interested in knowing whether population is a related variable, that is: are small/big cities more often related to cities in their population range? We can do this using a [scatterplot](https://en.wikipedia.org/wiki/Scatter_plot) showing both population data:

```{r}
# we extract a random sample of 15% of the cities
eudata.sample <- sample_frac(eudata, 0.15)

# we create the plot
ggplot(data = eudata.sample,
       aes(x = log(originpopulation),
           y = log(destinationpopulation))) +
       geom_point()
```
![plot1](images/plot1.png)

Two notes before continuing: since the dataframe `eudata` has many points, this leads to a so called overplotting (too many points). Therefore we select a random sample of 15% of the cities in our dataframe with the function [`sample_frac()`](http://dplyr.tidyverse.org/reference/sample.html) (in package `dplyr` ). Moreover we use the natural log of the population data to overcome the skewness of the data.

But we want to make changes to the graph adding information. There are three different elements which are worth looking at:

1. every ggplot2 function (eg. `geom_point()`) can take arguments to modify concrete  aspects, 
2. `scales` control the way variables are mapped from the data to the
   plot. This affects axes, legends, etc.
3. `themes` refer to the 'static' elements of the plot: the
   background's elements (color, lines, etc.), the fontsize, etc. 

We will begin with the most simple transformation: we want to change the size and the color of the points:

```{r}
ggplot(data = eudata.sample,
       aes(x = log(originpopulation),
           y = log(destinationpopulation))) +
       geom_point(size = 3, color = "red")
```

![plot2](images/plot2.png)

As you can see, this can easily be done: every function can get arguments which influence how the function makes its job. In this case, we pass to the function `geom_point()` different arguments (`size` and `color` or `colour`) which are straightforward. To find out which arguments are avalaible you can visit the help page of `geom_point()` by typing `?geom_point` in R or here [online](http://ggplot2.tidyverse.org/reference/geom_point.html).

The plot looks now a bit better, but there are still a lot of things to improve. For instance, we want to add titles to the axes. Manipulating axes (and legends) is done by using the corresponding `scales` functions which we will cover later on. But since changing the titles is a very common action, ggplot has a shorter command to achieve it: [`labs()`](http://ggplot2.tidyverse.org/reference/labs.html) (which stands for *labels*):

```{r}
ggplot(data = eudata.sample,
       aes(x = log(originpopulation),
           y = log(destinationpopulation))) +
    geom_point(size = 3, color = "red") +
    labs(title = "Population data of origin and destination city",
         caption = "Data: www.wikidata.org",
         x = "Population of origin city (log)",
         y = "Population of destination city (log)")
```

![plot3](images/plot3.png)

If we are happy with our graph we can save it with a simple command:

```{r}
ggsave("eudata.png")
# for getting a pdf
# ggsave("eudata.pdf")
```

This will create a [PNG](https://en.wikipedia.org/wiki/Portable_Network_Graphics) file with the last plot we have constructed. The function `ggsave()` has [many parameters](http://ggplot2.tidyverse.org/reference/ggsave.html) you can adjust (dpi, height, width, format, etc.).

But let us make other changes. In many cases we want to add information to the graph using different colors (or shapes) for every group. For instance we could color the points of our previous scatterplot using colors for the different types of cities (in the same country, in a EU-country or in a non-EU-country). Let's  create a first version of this new graph using the previous code: 

```{r}
ggplot(data = eudata.sample,
       aes(x = log(originpopulation),
           y = log(destinationpopulation))) +
    geom_point(size = 3, alpha = 0.7, aes( color = typecountry )) +
    labs(title = "Population data of origin and destination city",
         caption = "Data: www.wikidata.org",
         x = "Population of origin city (log)",
         y = "Population of destination city (log)")
```
![plot04](images/plot04.png)

Three aspects are here relevant:

  * we modify `geom_point()` adding an argument: `aes(color = typecountry)`. The tricky question is here: why do we use `aes()` and not just `color = typecountry` without putting it inside of `aes()`? You can try it on your own (you will get an error). The reason is very easy: using `aes()` we are telling ggplot2 that it has to map the argument `color` to the variable `typecountry`. In other words: we are telling ggplot2 that `typecountry` is a variable of the data we are using. Inside `aes()` we could have chosen another aspect, for instance the shape and relate it to a variable  with `aes(shape = typecountry)` (the plot does not look very good, so that I will not put it here),
  * since there are too many points I haved added the parameter `alpha` to make the points a little bit transparent,
  * ggplot2 has made some decisions for us: it selects colors on its own and it adds automatically a legend to the graph. 

## Scales: colors, legends, axes

But: how can we modify colors and legend? The so-called `scales` are your friend. Citing the ggplot2 book: "scales control the mapping from data to aesthetics. They take your data and turn it into something that you can see, like size, colour, position or shape". And at the same time, scales provide the tools that let you read the plot: the axes and legends. There are [many different scales](http://ggplot2.tidyverse.org/reference/#section-scales) you can use.

Admittedly, scales are maybe the least intuitive element in ggplot2. Noteworthing is the fact that the naming scheme for scales is made up of three pieces separated by “_“:

  1. scales,
  2. The name of the aesthetic (e.g., colour, shape or x),
  3. The name of the scale (e.g., continuous, discrete, brewer).

But let's take a look at it with our previous graph. In our last graph we can control 3 different scales: 

1. `scales_x_continuous()` which controls the data of the x-axis (when `x` is continuous),
2. `scales_y_continuous()` which controls the data of y-axis (when `y` is continuous),
3. `scales_colour`: which controls the color(s) used. 

We will take a look at the possibilities of changing colors. (Nevertheless I have to warn you: the selection of colors for graphs is by no means an easy task; there is a lot of theoretical work done on this). We could do several things: manually passing some colors or  using a predefined color scala.

First of all we store our graph in a varible to use it several times, changing only some aspects. This is a very convenient way of ggplot2 to make different versions of the same graph:

```{r}
p1 <- ggplot(data = eudata.sample,
       aes(x = log(originpopulation),
           y = log(destinationpopulation))) +
       geom_point(size = 3, alpha = 0.7, aes( color = typecountry )) +
       labs(title = "Population data of origin and destination city",
         caption = "Data: www.wikidata.org",
         x = "Population of origin city (log)",
         y = "Population of destination city (log)")
```

Now we can add manually the colors using `scale_colour_manual()`. In this case we use colors which are [already defined in R](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf), but we could also use hexadecimal codes for specific colors. As you see, [`scale_colour_manual()`](http://ggplot2.tidyverse.org/reference/scale_manual.html) takes a compulsory argument (`values =`), namely a vector with the names of colors. 

```{r}
p1 + scale_colour_manual(values = c("red", "blue", "green"))
```
![plot05](images/plot05.png)

In this way we can create graphs with our preferred colors. But often it is more recommendable to use already defined colors scalas, such as the [color brewer palettes](http://colorbrewer2.org/). ggplot2 has already these palettes [integrated](http://ggplot2.tidyverse.org/reference/scale_brewer.html) and a specific `scale` for using them (`scale_colour_brewer()`):

```{r}
p1 + scale_colour_brewer(palette = "Dark2") # you can try others such as "Set1", "Accent", etc.
```
![plot06](images/plot06.png)

But let's look at another slightly different example. In the last graph we used a qualitative variable (`typecountry`) with different colors. But what about a continuous variable? Let's say we want to add more information to our plot including the distance between the cities (we use again the log of the distance because of the skewness). We want to do it using the red color to signalise the distance. Its intensity should represent the distance. We could try the following code:

```{r}
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

![plot07](images/plot07.png)

As you can see, there are two problems with this graph: 

1. blue is the used color and not red,
2. the scala is not convincing since smaller distances are represented by the more dark blue. 

Again we need to use scales, but in this case another function. ggplot2 does not use in this case discrete colors (that is, one color for every distinct value of the qualitative variable), but only one color which is graduated. For this reason the scale we have to use is one which deals with gradients. There are [several for doing this](http://ggplot2.tidyverse.org/reference/scale_gradient.html). We will use `scale_colour_gradient`. We can define the low and the high value of the gradient: 

```{r}
p2 + scale_colour_gradient(low = "white", high = "red3")
```

![plot08](images/plot08.png)

Other scales with gradients (`scales_colour_gradient2` and `scales_colour_gradientn`) have other possibilities. I encourage you to explore them looking at the [documentation page](http://ggplot2.tidyverse.org/reference/scale_gradient.html). By the way: as you can see from the plot, small cities tend to establish relationships with cities which  are not so distant.

Finally we will slightly modify the legend, which is something (as I have already mentioned) which is controlled by the scales. We want to modify of course the terrible title of the legend and some of its parameters:

```{r}
p2 <- p2 + scale_colour_gradient(low = "white",
                                 high = "red3",
                                 guide = guide_colorbar(title = "Distance in log(km)",
                                                  direction = "horizontal",
                                                  title.position = "top"))
												  
p2
```
![plot09](images/plot09.png)

The legend is controlled by the parameter [`guide`](http://ggplot2.tidyverse.org/reference/guides.html). In this case we tell ggplot2 to use a [`guide_colorbar()`](http://ggplot2.tidyverse.org/reference/guide_colourbar.html) with the parameters you can see regarding the title (caption, position, etc.). 


## Faceting a graph 

Previously we create a plot which compared cities and their relationships with cities in EU countries, non-EU countries using different colors for each country. Nevertheless, ggplot2 provides also a very effective way to make plots which can include information splitted by categories (space, time, and so). We can so represent the same data, but in separated graphs per country. For doing this ggplot2 has powerful possibilities, which are summarised under the label [*facetting*](http://ggplot2.tidyverse.org/reference/index.html#section-facetting). The most simple facetting function is [`facet_wrap()`](http://ggplot2.tidyverse.org/reference/facet_wrap.html), but you can also take a look at the richer [`facet_grid()`](http://ggplot2.tidyverse.org/reference/facet_grid.html).

Using our previous dataframe `eudata.perc.country` we can add a new layer in the following way:
```{r}
ggplot(eudata.perc.country, aes(x = typecountry, y = perc)) +
    geom_bar(stat = "identity") +
    facet_wrap(~origincountry)
```
![plot13](images/plot13.png)

We have only added the layer `facet_wrap(~origincountry)` to the previous command. By doing so, we tell ggplot2 to create one graph per country. Important is the use of the operator `~` which is very often used in R for the so-called formulae. We can control for the number of rows and columns in the grid. As already mentioned, take a look at the rich documentation.

## Themes: changing static elements of the graphs

Modifying the appearance of the graph is also one of the most frequent requirements. This can be achieved in ggplot2 with the use of `themes` which control things like fonts, ticks, panel strips, and backgrounds. `themes` are one of the most powerful and rich features of ggplot2, which makes it impossible to treat here every aspect.I will only mention two aspects. First, the fact that ggplot2 comes with a number of [built-in themes](http://ggplot2.tidyverse.org/reference/ggtheme.html). The most important are `theme_grey()` (the default on), `theme_bw()`, `theme_dark()`, `theme_void()`, etc. Second, that you can easily create you own themes and use them in your plots. 

Using another theme diffent from the default one is again a very simple thing. We apply it as a new layer using `+`: 

```{r}
p3 <- ggplot(eudata.perc.country, aes(x = typecountry, y = perc)) +
     	geom_bar(stat = "identity") +
        facet_wrap(~origincountry)

p3 + theme_bw()
```
![plot14](images/plot14.png)

Several packages add additional themes to ggplot2. You can for instance install [`ggthemes`](https://github.com/jrnold/ggthemes) or [`ggtech`](https://github.com/ricardo-bion/ggtech) where you will find themes such as `theme_excel` (a theme replicating the classic ugly gray charts in Excel), `theme_wsj` (a theme based on the plots in the *The Wall Street Journal*), etc. For instance to use this last theme we just need to do the following: 

```{r}
install.packages("ggthemes")
library(ggthemes)

p3 + theme_wsj()
```
![plot15](images/plot15.png)

But more interesting is of course the possibility to modify yourself some aspects of the graph. There are two main possibilities: 

1. create your own theme, taking for instance the code of the existing ones and modifying the concrete aspects you are interested in. The definition of the default themes can be found [here](https://github.com/tidyverse/ggplot2/blob/master/R/theme-defaults.r). 
2. modify concrete aspects of the theme we are using. Unfortunately it is not possible in such a lesson to go into every single aspect which can be manipulated. [Here](http://ggplot2.tidyverse.org/reference/theme.html) you can find how many different arguments can be used (and see some examples): `panel.grid.major`, `panel.grid.minor`, `plot.background`, `legend.background`, `legend.margin`, and many others. 

## Extending ggplot2 with other packages

As already mentioned, one of the strengths of ggplot2 is the fact that a lot of [extensions](http://www.ggplot2-exts.org/) have been written in the last years. You can create with them [network graphs](https://briatte.github.io/ggnetwork/), [radar charts](https://github.com/ricardo-bion/ggradar), [time series graphs](https://github.com/AtherEnergy/ggTimeSeries), so called [ridgeline plots](https://cran.r-project.org/web/packages/ggridges/vignettes/introduction.html) and many more. Their use is incredibly easy. Let's see an example. 

We will make a so called ridgeline plot which create the impression of a mountain range. They can be quite useful for visualizing changes in distributions over time or space, if I may cite from the webpage of the project. We will visualize the population data of the origin cities. This simple code is enough (we use a log-transformation because of the skewness of the data):

```{r}
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
![plot26](images/plot26.png)

The library `ggridges` adds a new layer `geom_density_ridges()` and a new theme `theme_ridges()` which easily expand the possibilities of plotting data in R. 
