---
title: "Visualizing data with R and ggplot2"
collection: lessons
layout: lesson
slug: computer-vision-deep-learning-pt1
date: 2018-03-16
translation_date: LEAVE BLANK
authors: 
- Igor Sosa Mayor
- Nabeel Siddiqui
reviewers:
- LEAVE BLANK
editors:
- Zoe LeBlanc
translator:
- FORENAME SURNAME 1
- FORENAME SURNAME 2, etc
translation-editor:
- LEAVE BLANK
translation-reviewer:
- LEAVE BLANK
review-ticket: LEAVE BLANK
difficulty: LEAVE BLANK
activity: LEAVE BLANK
topics: LEAVE BLANK
abstract: LEAVE BLANK
mathjax: true
---

# Introduction, Lesson Goals and Data

Visualizing data is essential to disseminating research . Using R and the powerful [ggplot2](http://ggplot2.tidyverse.org/) package, this lesson looks at how to create useful, beautiful, and publication-ready plots for exploratory data analysis. By the end of this lesson, you will be able to do the following:

1.  Create different types of plots, such as bar plots, histograms, and scatter plots.
2.  Understand how to manipulate plot visuals, such as color and size, and know how they fit in with the underlying philosophy behind ggplot2.
3.  Add meaningful labels to plots.
4.  Create grids/facets of plots to compare data.
5.  Gain a foundation for how to extend ggplot2 with extensions.

In order to follow this tutorial, you should have rudimentary knowledge of R. We recommend you complete Taryn Dewar’s [R Basics with Tabular Data](https://programminghistorian.org/en/lessons/r-basics-with-tabular-data), Nabeel Siddiqui’s [Data Wrangling and Management in R](https://programminghistorian.org/en/lessons/data_wrangling_and_management_in_R), and Lauren Tilton and Taylor Arnold’s [Basic Text Processing in R](https://programminghistorian.org/en/lessons/basic-text-processing-in-r).

## ggplot2: General Overview

There are several ways to analyze data, but in this tutorial, we will concentrate on discerning data with graphical representations In R, there are numerous possibilities for creating graphs, both through base R’s [plotting function](https://stat.ethz.ch/R-manual/R-devel/library/graphics/html/plot.html) and packages like [lattice](http://lattice.r-forge.r-project.org/). Compared to these approaches, ggplot2 has a few key advantages:

1.  It is powerful and relatively easy to use.
2.  It creates beautiful, publication-ready graphs.
3.  It has extensions that the community continuously develops to enhance its possibilities.
4.  It has a core philosophical framework that assures that plots reflect information accurately.

Creating graphics is complicated. We need to take various decisions into account, such as the data set we want to base our plot on, the type of graph we wish to create (scatter plot, box plot, histogram, etc.), the specific visual elements of the graph (axes, legends, etc.), and more. To make these choices easier, ggplot2 draws on Leland Wilkinson’s work [The Grammar of Graphics](https://link.springer.com/book/10.1007/0-387-28695-0)(hence the gg in the name “ggplot2”). But, don’t panic! You don’t have to know anything about the grammar other than its core idea that plots are made up of independent components or “layers.” There are seven key layers. While this may seem like a lot, you will usually only work with a few since ggplot2 automatically provides sane defaults for the others. These layers are:

1.  Data: The data set we are hoping to analyze.
2.  Aesthetics: The term aesthetics itself often confuses new users. In everyday speech, aesthetics usually refer to anything visual. However, in ggplot2 it has a more narrow definition that refers to the mapping of fields/columns in our data to certain visual properties. In other words, you use aesthetics when there is a column in your data set that needs to be represented different way based on its values. In most cases, this will be something like position, color, shape, fill, or size.
3.  Scales: The transformation of our data from the the mappings to visual properties. For instance, if you have a categorical column and the aesthetics layer chooses color 1 for category 1 and color 2 for category 2, what are the actual colors?
4.  Geometric Objects: The objects that represent our data. For instance, how do we want to show each data point? Do we want a dot, a bar, or some other object? You can think of this as the base representation for your data while the aesthetics layer provides further tuning of these objects. For all intensive purposes, you can think of geometric objects as determining the type of graph you want, such as a bar graph, line graph, or histogram.
5.  Statistics: Statistical calculations needed before certain plots can be created. For instance, when we create a box plot, we need to have a five number summary. Rather than doing this manually, we can rely on the statistics layer. You normally do not have to explicitly state the statistics layer as most graph types will automatically calculate them when needed.
6.  Facets: The ability to categorize and divide data into multiple graphs.
7.  Coordinate systems: Determines how we transform different values onto our graph. The most common coordinate system is the Cartesian one, but ggplot2 can also plot polar coordinates and spherical projections.

While this may seem like a lot of layers, remember that ggplot2 automatically sets numerous defaults. As a result, you usually only need to specify three layers: data, aesthetics (remember these correspond to an actual column in your data set you want mapped visually), and geoms (usually represent the type of graph you want to create).

# Installing GGPlot2

To use ggplot2, we must first install and load it. We recommend installing the [tidyverse](https://www.tidyverse.org) meta package which includes ggplot2. The tidyverse provides a group of libraries that work together in a [unified structure and philosophy](https://tidyverse.tidyverse.org/articles/manifesto.html) and will help us structure our data.

```R
# Install tidyverse package if not already installed by removing comment from following line
#install.packages("tidyverse")
library("tidyverse")
```

# Sister cities in Europe

We will look at [sister cities](https://en.wikipedia.org/wiki/Sister_city) around the world. As historians, we might be interested in determining if German cities are related to French or Polish cities, perhaps as a way to overcome deep historical tensions? Do Spanish cities create more relationships to other Spanish-speaking American cities? Does the population of a city impact sister city relationships? Are European Union cities more likely to develop relationships with other European Union cities? Do cities in former communist countries have more relationships with other communist countries?

Research has [previously shown](https://arxiv.org/abs/1301.6900) that most sister city relationships are not dependent on distance. By
selecting a group of six countries (Bulgaria, France, Germany, Hungary, Poland, and Portugal), we will look to see if this pattern holds true for a these countries along with exploring if sister cities are more likely to develop relations with those that have similar populations.

## Loading Data with readr

Common spreadsheet applications, such as Microsoft Excel or Apple Numbers, place data in a proprietary format. While there are R packages that read Excel data, such as [readxl](https://readxl.tidyverse.org/), we recommend using open formats, such as CSV (comma-separated values) or TSV (tab-separated values) when possible. This is the format we have placed our data in. Download it and place it in the working directory of your project. R has built in commands for reading CSV and TSV files. However, we will use the [readr](https://readr.tidyverse.org/) package, which we already loaded when we called the tidyverse. This reads data into a tibble format rather than a data frame.

Tibbles are essential to the tidyverse and function similarly to data frames, but they make small decisions about how to import and display data. R is a relatively old language, and as a result, defaults that made sense during the original implementation are less helpful now. Unlike data frames, they do not treat strings as factors, convert input type, or create row names. You can learn more about [tibbles here](https://r4ds.had.co.nz/tibbles.html). If you do not have a background in R, the difference between tibbles and data frames may not make a lot of sense. Don’t worry! In most cases, you can treat tibbles exactly like data frames and easily switch between the two. To convert your tibble to a data frame, use the `as.data.frame()` function with the name of the tibble as the parameter. Likewise, to convert a data frame to a tibble, use the `as_tibble()` function.

We will use readr’s [read_csv()](https://readr.tidyverse.org/reference/read_delim.html) function to load our data. This function takes either a file path or URL as its argument and converts the file to a tibble.

```R
eudata<-read_csv("sistercities.csv")
eudata
```
    ## # A tibble: 13,081 × 12
    ##    origincityLabel origincountry originlat originlong originpopulation
    ##    <chr>           <chr>             <dbl>      <dbl>            <dbl>
    ##  1 Veliko Tarnovo  Bulgaria           43.1       25.6            71150
    ##  2 Pernik          Bulgaria           42.6       23.0            75191
    ##  3 Veliko Tarnovo  Bulgaria           43.1       25.6            71150
    ##  4 Obzor           Bulgaria           42.8       27.9             2125
    ##  5 Obzor           Bulgaria           42.8       27.9             2125
    ##  6 Balchik         Bulgaria           43.4       28.2            12913
    ##  7 Tryavna         Bulgaria           42.9       25.5             9831
    ##  8 Troyan          Bulgaria           42.9       24.7            22022
    ##  9 Sofia           Bulgaria           42.7       23.3          1286383
    ## 10 Dimitrovgrad    Bulgaria           42.1       25.6            38217
    ## # … with 13,071 more rows, and 7 more variables: sistercityLabel <chr>,
    ## #   destinationlat <dbl>, destinationlong <dbl>, destinationpopulation <dbl>,
    ## #   destination_countryLabel <chr>, dist <dbl>, eu <chr>

As you can see, we have 13081 rows with 12 variables. Our data focuses on six EU-countries: Germany, France, Poland, Hungary, Portugal, Bulgaria (three Western European countries and three Eastern European countries). The following information is also present for each country: the “origin city”, that is the city whose sister cities we are looking for (in the column `origincityLabel`), the country (`origincountry`), the coordinates (in `originlat` and `originlong`) and the population (`originpopulation`). The same information is also present for each of the sister cities. The `dist` column indicates the distance between the two cities (in km), and `eu` informs us whether the “destination city” is in the EU or not.

# Creating a bar graph

Let’s begin with a small example. We want to test whether European cities have more relationships with EU or non-EU countries. We can inspect this question graphically by plotting a bar graph. Run the following code:

```R
ggplot(data=eudata, mapping=aes(x = eu)) + 
    geom_bar() 
```

{% include figure.html filename="plot-1-1.png" alt="Bar graph showing that the count of EU sister countries is vastly larger than those for non-EU countries." caption="Figure 1: EU vs Non-EU Sister Cities" %}

As you can see, most of the sister cities are in the EU. You may wonder where ggplot2 got the counts for each of the values. This counting is done in the the statistics layer. As you may recall, this layer is often hidden (although you can make it explicit) and calculates statistical values, such as the counts, when necessary for a particular geom.

The first parameter of the ggplot() function represents the tibble or data frame we want to plot, and the second points to the “aesthetics” of the graph. Aesthetics, as you may recall from earlier, refers to the “mapping” of columns or a selection of columns. However, if we only use the `ggplot()` function, R will give us a blank graph. We need to also add a layer that defines the graph type. We can use the “+” operator to add this layer. Since we are creating a bar plot, we will add the `geom_bar()` layer.

In most cases, you will not see “data=” or “mapping=” in code online since the `ggplot()` function expects these to be the first two parameters. The following code will produce the same result:

```R
ggplot(eudata, aes(x = eu)) + 
    geom_bar() 
```

# Creating more advanced bar graphs

The syntax for ggplot2 can be tricky to get your head around at first, but as you practice, your understanding will grow. One trick is to think about the creation of plots like the construction of sentences. In our example, we told R the following: “create a ggplot2 graph using the data from `eudata` and map the variable `eu` to x. Finally, add a bar graph layer using `geom_bar()`”. We now have our first plot with ggplot2! You may notice that ggplot2 has made some default decisions about how the graph should look, such as its background color, the font size of the labels, and the color of the bars. Later on, we will see how to change the plot’s appearance in more depth, but if you are just beginning, we recommend sticking with the defaults.

Right now, our graph displays the raw count. What if we want to show the percentages? There are several ways to do this, but the easiest one is to add a column to our data. Using the following code, we group our data by country and add a new column named `perc` with the percentage values (again: see the [tutorial](https://programminghistorian.org/lessons/data_wrangling_and_management_in_R)about `dplyr` for details if the code below does not make sense).

Finally, we will use `geom_col()` rather than `geom_bar()` since the former allows us to use a y variable, while `geom_bar()` only provides a count for the x variable by default:

```R
# we aggregate the data per type of country and add a new column with percentages
eudata_perc <- eudata %>%
    group_by(eu) %>%
    summarise(total = n()) %>%
    mutate(perc = total/sum(total))

ggplot(eudata_perc, aes(x = eu, y = perc)) +
    geom_col()
```

{% include figure.html filename="plot-2-1.png" alt="Bar graph showing that the percetnage of EU sister countries is vastly larger than those for non-EU countries" caption="Figure 2: EU vs Non-EU Sister Cities Percentages" %}

Although this graph is a good start, we can still not compare countries easily. Ideally we want a bar for each country. To do this, we will pass a new column to the `aes()` function to map. Just as we mapped values to x and y, we can also map values to a “fill,” which represents the colors of the bars. Specifically, we want each bar to represent a different origin country so we will pass“origincountry” to the fill argument.

```R
# we aggregate the data per country and type of country and add a new column with percentages
eudata_perc_country <- eudata %>%
    group_by(origincountry, eu) %>%
    summarise(total = n()) %>%
    mutate(perc = total/sum(total))

ggplot(data = eudata_perc_country, aes(x = eu, y = perc, fill = origincountry)) +
    geom_col()
```

{% include figure.html filename="plot-3-1.png" alt="Bar graph showing EU and non-EU countries with different colors for each country. EU countries form the vast majority of sister cities for the six selected countries. Notably, the graph for each country is stacked on top of the other countries giving the illusion that the graph represents proportion." caption="Figure 3: EU vs Non-EU Sister Cities by Country Stacked" %}

Using `fill`, ggplot2 has made different colors for each of the columns in the graph. However this visualization is difficult to read because the bars are stacked on top of one another. Most individuals would likely see this as a graph that represents proportions. However, this is misleading. To fix this, we need add “position=‘dodge’” to `geom_col()` so that the bars do not get stacked on top of one another but are instead placed side by side.

```R
# we aggregate the data per country and type of country and add a new column with percentages
ggplot(data = eudata_perc_country, aes(x = eu, y = perc, fill = origincountry)) +
    geom_col(position="dodge")
```

{% include figure.html filename="plot-4-1.png" alt="Bar graph showing EU and non-EU countries with different colors for each country. EU countries form the vast majority of sister cities for the six selected countries. The issue where each country is stacked on top of the other countries giving the illusion that the graph represents proportion is fixed by having each country's bar side by side with the other ones." caption="Figure 4: Eu vs Non-EU Sister Cities by Country Side by Side" %}

Finally, we can analyze our data. As we see, most of the countries analyzed have strong relationships with other EU countries. Two countries, Bulgaria and Portugal, have just as many relationships with EU countries as with non-EU countries. Perhaps, this is related to their colonial past (in the case of Portugal), but we need to investigate these claims further.

# Other Geoms: Histograms, Distribution Plots and Boxplots

As you have seen, the key steps to creating visualizations in ggplot2 center around stacking layers and setting parameters to those layers. One of the most important types of layers are "geoms," as they usually correspond to the the type of graph we have. We have [geom_histogram()](http://ggplot2.tidyverse.org/reference/geom_histogram.html) for histograms, [geom_boxplot()](http://ggplot2.tidyverse.org/reference/geom_boxplot.html) for boxplots, [geom_violin()](http://ggplot2.tidyverse.org/reference/geom_violin.html) for violin plots, [geom_dotplot()](http://ggplot2.tidyverse.org/reference/geom_dotplot.html) for dotplots, and [geom_point()](http://ggplot2.tidyverse.org/reference/geom_point.html) for scatterplots.

Let’s use a histogram to examine the distribution of the variable `dist`representing the distance (in kilometers) between sister cities. Perhaps, we want to analyze whether cities in the six selected countries have relations with other cities in their proximity or not. The distribution of the variable `dist` is skewed with far away. This leads to a fairly uninformative histogram. We can take the `log10()` of our variable or filter to exclude values above 10000kms. None of these methods is ideal, but we will take the latter approach for simplicity:

```R
# we filter the data. Remember that you have to
# load tidyverse or dplyr, otherwise filter will throw an error
eudata_filtered <- eudata %>%  
    filter(dist < 10000)

ggplot(eudata_filtered, aes(x=dist)) + 
    geom_histogram()
```

{% include figure.html filename="plot-5-1.png" alt="Histogram showing the distribution of distance for all countries with values about 10000 kms excluded. The plot shows a heavy left skew." alt="Histogram showing the distribution of distance for all countries with values about 10000 kms excluded. The plot shows a heavy left skew." caption="Figure 5: Sister Cities Distance Histogram" %}

Again, to change the graph to a histogram, we only need to switch the last layer to `geom_histogram()`. ggplot2 displays a warning stating it has defaulted our bin width to thirty (`bins=30`) and recommends we pick a better value. Since we are only doing a simple exploratory analysis, this is less of a worry. When you work with other data, be sure to explore the help page of[geom_histogram()](http://ggplot2.tidyverse.org/reference/geom_histogram.html) to look at more possibilities for configuration.

What does this data show us? The plot makes evident that most sister cities are in a radius of approximately one thousand kilometers. However, this could be a distortion caused by the manipulation of our data. One way we can visualize and understand this distortion is through a [cumulative distribution function](https://en.wikipedia.org/wiki/Cumulative_distribution_function)(ECDF). In ggplot2, we can add this by using the `stat_ecdf()` layer:

```R
ggplot(eudata, aes(x=dist)) + 
    stat_ecdf()
```

{% include figure.html filename="plot-6-1.png" alt="A cumulative distribution function graph with almost one hundred percent of distances being below 10000kms" alt="A cumulative distribution function graph with almost one hundred percent of distances being below 10000kms" caption="Figure 6: Sister Cities Distance Cumulative Distribution Function" %}

From this plot, we see that approximately 75% of sister cities are in a radius of approximately one thousand kilometers. Even more interesting, approximately fifty percent seem to be less than five hundred kilometers away.

We can use a box plot to determine the spread of distance for sister cities in different countries. In other words, let’s determine if certain countries contain cities that are more likely to establish relationships with more distant cities:

```R
ggplot(eudata, aes(x = origincountry, y = dist)) + 
    geom_boxplot()
```

{% include figure.html filename="plot-7-1.png" alt="Box plot showing distance for each of the selected countries. Highlights that the countries maintain relationships with cities close to them. Out of all countries, Portugal has a higher median value." caption="Figure 7: Sister City Distance by Country Box Plot" %}

The plot shows that most countries establish sister cities in their proximity. If you do an [ANOVA](https://en.wikipedia.org/wiki/Analysis_of_variance) test, you will see that the differences between countries are statistically significant.

## Manipulating the Look of Graphs

So far, ggplot2 has made numerous default decisions about how our graphs should look. In most cases, these decisions are sensible, but as you learn more, you will likely want tighter control over your plots. Let’s begin with a small example. Let’s say we are interested in knowing how the population of the origin and destination cities impact the desire for sister relationships. For instance, do cities create more relationships with other cities within the same population range?

We can use a [scatterplot](https://en.wikipedia.org/wiki/Scatter_plot) to visualize our population data. Since the dataframe `eudata` has many points, this could potentially result in over plotting. Over plotting occurs when there is so much data that it is hard to gain insights from our plot. Therefore, we will select a random sample of fifteen percent of the cities in our data frame with the function [sample_frac()](http://dplyr.tidyverse.org/reference/sample.html). We are [setting a seed](https://www.rdocumentation.org/packages/simEd/versions/2.0.0/topics/set.seed) for reproducibility and will use the natural log of the population data to overcome skewness.

```R
# Set seed to 123. This can be any number but must be the same for those reproducing these results.
set.seed(123)

# we extract a random sample of 15% of the cities
eudata.sample <- sample_frac(eudata, 0.15)


# we create the plot
ggplot(data = eudata.sample,
        aes(x = log(originpopulation),
            y = log(destinationpopulation))) +
        geom_point()
```

{% include figure.html filename="plot-8-1.png" alt="Scatterplot showing population of origin city correlating positively with population of destination city. Each value is represented with a black dot." caption="Figure 8: Population of Origin City vs Destination City Scatter Plot" %}

We see that there is a general trend where the population of the origin city rises with the destination city. Even after selecting a random sample of fifteen cities, we may want to change the properties in our graph. For each geom layer, we can map additional aesthetics, and these will take priority over any mappings in the `ggplot()` function. When we discussed aesthetics earlier, we mentioned that these represent a column in our data set that is “mapped”. If we do not have an actual column for the mapping, we can also set a static value. These are set outside of the mapping call but follow a similar pattern. Be sure to understand the difference between setting values in mapping and outside of it as this is a common source of confusion.

To start, we will change the size and the color of the points. To find out all the arguments that are available, you can visit the help page of `geom_point()` by typing `?geom_point` in R or here [online](http://ggplot2.tidyverse.org/reference/geom_point.html).

```R
ggplot(data = eudata.sample,
        aes(x = log(originpopulation),
            y = log(destinationpopulation))) +
        geom_point(size = 3, color = "red")
```

{% include figure.html filename="plot-9-1.png" alt="Scatterplot showing population of origin city correlating positively with population of destination city. Each value is represented with a red dot of size 3." caption="Figure 9: Population of Origin City vs Destination City Scatter Plot with Adjusted Size and Color" %}

The plot looks a bit better, but there are still a lot of things to improve. For instance, we may want to add titles to the axes.
Manipulating axes (and legends) is done by using the corresponding `scales` functions, which we will cover later on. But since changing the titles is a very common action, ggplot has a shorter command to achieve it: [labs()](http://ggplot2.tidyverse.org/reference/labs.html) (which stands for *labels*):

```R
ggplot(data = eudata.sample,
        aes(x = log(originpopulation),
            y = log(destinationpopulation))) +
    geom_point(size = 3, color = "red") +
    labs(title = "Population data of origin and destination city",
        caption = "Data: www.wikidata.org",
        x = "Population of origin city (log)",
        y = "Population of destination city (log)")
```

{% include figure.html filename="plot-10-1.png" alt="Scatterplot showing population of origin city correlating positively with population of destination city. Each value is represented with a red dot of size 3. Labels and title have been added." caption="Figure 10: Population of Origin City vs Destination City Scatter Plot with Labels and Titles" %}

Although you may already know what your graph represents and believe that the data is self evident, it is always a good idea to add labels for your audience. If you are happy with your graph, you can save it using the `ggsave()` function. This will create a [PNG](https://en.wikipedia.org/wiki/Portable_Network_Graphics) file with the last plot you constructed. The function `ggsave()` has [many parameters](http://ggplot2.tidyverse.org/reference/ggsave.html) you can adjust to make it look exactly as you would like(dpi, height,width, format, etc.).

We can also mix mapping columns with the `aes()` function with static calls. For instance, we could color the points on our previous scatterplot to represent whether cities are in a EU-country or in a non-EU-country:

```R
ggplot(data = eudata.sample,
        aes(x = log(originpopulation),
            y = log(destinationpopulation))) +
    geom_point(size = 3, alpha = 0.7, aes( color = eu )) +
    labs(title = "Population data of origin and destination city",
        caption = "Data: www.wikidata.org",
        x = "Population of origin city (log)",
        y = "Population of destination city (log)")
```

{% include figure.html filename="plot-11-1.png" alt="Scatterplot showing population of origin city correlating positively with population of destination city. Each value is represented with a dot of size 3 with the color representing if the sister city is in the EU." caption="Figure 11: Population of Origin City vs Destination City Scatter Plot with Color Representing Sister City" %}

Since there are too many points, we have also added the parameter `alpha` to make the dots somewhat transparent. ggplot2 has again made the rest of the decisions for us by selecting default colors and legends for the graph.

# Scales: Colors, Legends, and Axes

We can modify the colors and legends ggplot2 chooses by default with scales. Let’s take a look at our previous graph and change some of the scales. The three most common scales are:

1.  `scales_x_continuous()`, which controls the data of the x-axis (when `x` is continuous).
2.  `scales_y_continuous()`, which controls the data of y-axis (when `y` is continuous).
3.  `scales_colour`, which controls the color(s) used. We can change the default colors ggplot2 uses by manually passing colors or using a predefined color scala.

First, we store our graph in a variable to make it reusable, changing only some aspects. This is a very convenient way of ggplot2 to make different versions of the same graph:

```R
p1 <- ggplot(data = eudata.sample,
        aes(x = log(originpopulation),
            y = log(destinationpopulation))) +
        geom_point(size = 3, alpha = 0.7, aes( color = eu )) +
        labs(title = "Population data of origin and destination city",
        caption = "Data: www.wikidata.org",
        x = "Population of origin city (log)",
        y = "Population of destination city (log)")
```

Now, we can add the colors using `scale_colour_manual()`. In this case, we use colors which [R has already defined](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf). We could also use hexadecimal codes for specific colors. As you see, [scale_colour_manual()](http://ggplot2.tidyverse.org/reference/scale_manual.html) takes a compulsory argument (`values =`) that contains a vector with the names of colors.

```R
p1 + scale_colour_manual(values = c("red", "blue"))
```

{% include figure.html filename="plot-13-1.png" alt="Scatterplot showing population of origin city correlating positively with population of destination city. Each value is represented with a dot of size 3 with the color representing if the sister city is in the EU. The colors red and blue are specifically chosen." caption="Figure 12: Population of Origin City vs Destination City Scatter Plot with Red and Blue Palette" %}

You should avoid choosing colors in this format. Unless you have expertise in this area, you can unwittingly choose values that are difficult to discern between or inaccessible to readers with color-blindness. It is better to use defined color scales when possible.Let’s use the [color brewer palettes](http://colorbrewer2.org/). ggplot2 already has these palettes [integrated](http://ggplot2.tidyverse.org/reference/scale_brewer.html) and a specific `scale` for using them (`scale_colour_brewer()`):

```R
p1 + scale_colour_brewer(palette = "Dark2") # you can try others such as "Set1", "Accent", etc.
```

{% include figure.html filename="plot-14-1.png" alt="Scatterplot showing population of origin city correlating positively with population of destination city. Each value is represented with a dot of size 3 with the color representing if the sister city is in the EU." caption="Figure 13: Population of Origin City vs Destination City Scatter Plot with Color Brewer" %}

Let’s look at a slightly different example. In the last graph, we used a categorical variable (`typecountry`) with different colors. But, what if we wanted to use a continuous variable? Let’s say we want to add information to our plot including the distance between the cities (we again use the log of the distance because of skewness). We want to use the intensity of the color red to represent the distance:

```R
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

{% include figure.html filename="plot-15-1.png" alt="Scatterplot showing population of origin city correlating positively with population of destination city. Each value is represented with a dot of size 3 with a darker blue gradient color representing smaller distance." caption="Figure 14: Population of Origin City vs Destination City Scatter Plot with Blue Gradient Representing Distance" %}

As you can see, there are two problems with this graph:

1.  Blue is the default color and not red.
2.  The scale range shows smaller distances in a darker color whereas most individuals would expect this to represent more distance.

We need to use scales again but in this case with another function. For continuous variables, ggplot2 does not use discrete colors (that is, one color for every distinct value of the variable), but instead a single gradient color. For this reason, the scale we want to use deals with gradients. There are [several methods for doing this](http://ggplot2.tidyverse.org/reference/scale_gradient.html). We will use `scale_colour_gradient` and define the low and the high value of the gradient:

```R
p2 + scale_colour_gradient(low = "white", high = "red3")
```

{% include figure.html filename="plot-16-1.png" alt="Scatterplot showing population of origin city correlating positively with population of destination city. Each value is represented with a dot of size 3 with a dark red color representing larger distance." caption="Figure 15: Population of Origin City vs Destination City Scatter Plot with Red Gradient Representing Distance" %}

Different gradient scales (`scales_colour_gradient2` and `scales_colour_gradientn`) have different possibilities. We encourage you to explore them by looking at the [documentation page](http://ggplot2.tidyverse.org/reference/scale_gradient.html).

As you can see from the plot, small cities tend to establish relationships with cities which are not so distant. Lets modify the
legends again, but this time using scales.

```R
p2 <- p2 + scale_colour_gradient(low = "white",
                                high = "red3",
                                guide = guide_colorbar(title = "Distance in log(km)",
                                                    direction = "horizontal",
                                                    title.position = "top"))
p2
```

{% include figure.html filename="plot-17-1.png" alt="Scatterplot showing population of origin city correlating positively with population of destination city. Each value is represented with a dot of size 3 with a darker red gradient color representing larger distance. The default legend title and direction have been changed." caption="Figure 16: Population of Origin City vs Destination City Scatter Plot with Legends Changed" %}

The legend is controlled by the parameter [guide](http://ggplot2.tidyverse.org/reference/guides.html). We tell ggplot2 to use [guide_colorbar()](http://ggplot2.tidyverse.org/reference/guide_colourbar.html) with the parameters for the title (caption, position, etc.).

# Faceting a Graph

Previously, we created a bar graph which compared cities and their relationships with cities in EU and non-EU countries by using different colors for each country. However, what if we want to explore certain relationships country by country? For this, we can use[faceting](http://ggplot2.tidyverse.org/reference/index.html#section-facetting). The most simple faceting function is [facet_wrap()](http://ggplot2.tidyverse.org/reference/facet_wrap.html). It takes the name of the column you want to use for faceting preceded by a “~”. Using our `eudata.perc.country` data frame, we can add a faceting layer as follows:

```R
ggplot(eudata_perc_country, aes(x = eu, y = perc)) +
    geom_col() +
    facet_wrap(~origincountry)
```

{% include figure.html filename="plot-18-1.png" alt="A grid of bar graphs showing the percentage of EU and non-EU sister cities. With the exception of Bulgaria, each graph shows that sister countries are more likely to be in EU countries." caption="Figure 17: EU vs Non-EU Sister Countries Facetted" %}

# Themes: Changing Static Elements

Sometimes, you may want to modify many visual properties of a graph at once. You can do this in ggplot2 with themes. Themes are one of the most powerful and rich features of ggplot2, which make it impossible to fully cover them in this lesson. However, we will mention two aspects to get you started. First, ggplot2 comes with a number of [built-in themes](http://ggplot2.tidyverse.org/reference/ggtheme.html). Second, you can easily create you own themes and use them in your plots.

Using a theme different from the default one is easy. We simply apply it as a new layer using the `+` operator.

```R
p3 <- ggplot(eudata_perc_country, aes(x = eu, y = perc)) +
    geom_col() +
    facet_wrap(~origincountry)

p3 + theme_bw()
```

{% include figure.html filename="plot-19-1.png" alt="A grid of bar graphs showing the percentage of EU and non-EU sister cities. With the exception of Bulgaria, each graph shows that sister countries are more likely to be in EU countries. A black and white theme is used." caption="Figure 18: EU vs Non-EU Sister Countries Facetted with Black and White Theme" %}

Several packages add additional themes, such as [ggthemes](https://github.com/jrnold/ggthemes) or [ggtech](https://github.com/ricardo-bion/ggtech). In these, you will find themes such as `theme_excel` (a theme replicating the classic charts in Excel) and `theme_wsj` (a theme based on the plots in the *The Wall Street Journal*). To use *The Wall Street Journal Theme*, for example, we can do the following:

```R
# Install ggthemes package if not already installed by removing comment from following line
# install.packages("ggthemes")
library(ggthemes)

p3 + theme_wsj()
```

{% include figure.html filename="plot-20-1.png" alt="A grid of bar graphs showing the percentage of EU and non-EU sister cities. With the exception of Bulgaria, each graph shows that sister countries are more likely to be in EU countries. A theme to make the graph look like those in the Wall Street is chosen." caption="Figure 19: EU vs Non-EU Sister Countries Facetted with WSJ Theme" %}

To set a default theme for all of your graphs, you can use the `theme_set()` function:

# Extending ggplot2 with Other Packages

One of the strengths of ggplot2 is the massive extensions that the community has written. With them, you can create [network graphs](https://briatte.github.io/ggnetwork/), [radar charts](https://github.com/ricardo-bion/ggradar), [time series
graphs](https://github.com/AtherEnergy/ggTimeSeries), [ridge line plots](https://cran.r-project.org/web/packages/ggridges/vignettes/introduction.html), and many more.

We will make a ridge line plot to create the impression of a mountain range to help you get the hang of extensions. These help visualize numerical data for a categorical variable. In particular, we will visualize the population data of the origin cities. We will add a new layer and theme from the ggridges package.

```R
# Install ggridges package if not already installed by removing comment from following line
# install.packages("ggridges")
library(ggridges)

# Plotted using log to avoid skewness

ggplot(eudata, aes(x=log(originpopulation), y = origincountry)) +
    geom_density_ridges() +
    theme_ridges() +
    labs(title = "Population (log) of the origin cities",
            caption = "Data: www.wikidata.org",
            x = "Population (log)",
            y = "Country")
```

{% include figure.html filename="plot-21-1.png" alt="A ridge plot showing the log population for each country." alt="A ridge plot showing the log population for each country." caption="Figure 20: Ridge Plot of Population for Each Country" %}

# Conclusion

Through our visualization of these six countries sister cities, we have found that most sister cities tend to be in close proximity to one another. In addition, they are more likely to establish sister relationships with those cities with similar populations. These two trends showcase that the six countries we chose (Bulgaria, France, Germany, Hungary, Poland, and Portugal) have sister cities that are likely bound by their cultural and social ties rather than attempts to truly draw connections with international neighbors. This breaks the pattern that [previous research](https://arxiv.org/abs/1301.6900) has found.

We can use this information as a starting point for further analysis. For instance, we may want to think about creating a geographical
representation of each of the cities or a network graph showing the most popular nodes. Luckily, with ggplot2, we can use the powerful extensions and general framework to take our research into new directions.

This tutorial is just the tip of the iceberg of ggplot2’s possibilities. We recommend you take a look at some of the following sources to gain a more thorough understanding:

-   The [official Site](https://ggplot2.tidyverse.org/) for ggplot2.
-   Hadley Wickham’s books [ggplot2: Elegant Graphics for Data Analysis](https://ggplot2-book.org/) and [R for Data Science](https://r4ds.had.co.nz/).
-   Hadley Wickham’s [original paper](https://www.tandfonline.com/doi/abs/10.1198/jcgs.2009.07098) on the grammar of graphics.
-   The [original book](https://www.springer.com/gp/book/9780387245447) by Leland Wilkson on the Grammar of Graphics.
-   [Tutorial on r-statistics.co](http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html) by Selva Prabhakaran .
-   Video by Data Science Dojo on an [Introduction to Data Visualization with ggplot2](https://www.youtube.com/watch?v=NXjPcXx42Yc).
-   UC Business Analytics [R Programming Guide](https://uc-r.github.io/ggplot_intro).
-   Two part [video tutorial](https://www.youtube.com/watch?v=h29g21z0a68) by Thomas Lin Pedersen
