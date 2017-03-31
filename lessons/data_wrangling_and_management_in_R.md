---
title: Data Wrangling and Management in R
authors:
- Nabeel Siddiqui
date: 2017-03-30
reviewers:
layout: default
---

## Introduction

Data you find "in the wild" will rarely be in the format necessary for
analysis, and you will need to manipulate your data before exploring the
questions you are interested in. This can often take more time than
doing the analysis itself! In this tutorial, we will learn some of the
basics of data manipulation and wrangling in R by focusing on the
[dplyr](https://cran.r-project.org/web/packages/dplyr/index.html)
package created by [Hadley Wickham](http://hadley.nz/). This package
provides libraries and tools that makes it easy to manipulate data.
Along the way, we will also gain experience in working with data frames
in R, using the pipe operator, and developing an understanding of data
organization.

## Lesson Goals

By the end of this lesson, you will:

1.  Have a solid foundation of how data frames work in R.
2.  Know the basics of how to organize data to be "tidy" and why this
    is important.
3.  Understand the dplyr package and use it to manipulate and
    wrangle data.
4.  Become acquainted with the pipe operator in R and how it can assist
    you in creating more readable code and avoiding complicated
    looping statements.
5.  Learn to work through some basic examples of data manipulation to
    gain a foundation in exploratory data analysis.

## Assumptions

This lesson makes a few assumptions about your understanding of R. If
you have not completed the [R Basics with Tabular
Data](http://programminghistorian.org/lessons/r-basics-with-tabular-data)
lesson, I suggest you complete that first. Having a background in a
another programming language will also be beneficial, since I only
briefly cover issues such as looping and conditional statements. I
recommend you work through the *Programming Historian's* excellent
Python tutorials, if you need a place to start.

## Dependencies

Make sure that you have the [latest version of
R](https://cran.rstudio.com/) and the [latest version of R
Studio](https://www.rstudio.com/products/rstudio/download/) installed
for your respective platform. In addition, we are going to go ahead and
load the "tidyverse"(dplyr is a part of this) and "historydata"
libraries:

```r
    # Install historydata and tidyverse libraries
    # Do not worry if this takes a while

    > install.packages("historydata")
    > install.packages("tidyverse")

    # Load historydata and tidyverse libraries

    > library(historydata)
    > library(tidyverse)
```

## Why R?

R is not the best language for everything. It is designed specifically
for exploratory data analysis or advanced statistical modeling, and if
your needs are more simple, it may be easier to use spreadsheet software
that you may already be familiar with. Nonetheless, R has numerous
advantages compared to things like Google Sheets and Excel that are
beneficial to historians:

1.  R can be used to work with non-numerical data. This is particularly
    important for historians who often analyze textual and visual data.
2.  R provides more granular control over visualizations making it
    easier to share work with other scholars.
3.  R is fast and specifically meant for working with large data sets.
4.  R makes it easy to make your work reproducable allowing other
    scholars to also benefit from it.
5.  R makes it quick and efficient to clean and manipulate your data.

## What is a Data Frame?

The most common data type in R is a data frame. While not a perfect
example, it is sometimes helpful to think of data frames like
spreadsheets. Similar to matrices, data frames are two dimensional, but
unlike matrices, they can contain different types of vectors.

If you did the [previous lesson on
R](http://programminghistorian.org/lessons/r-basics-with-tabular-data),
you have already been working with data frames with the mtcars data
without even knowing it. Lets go ahead and look at mtcars again. Because
it is a sample data set built into R, we can go ahead and load it
without reading it from an external source:

```r
    > data(mtcars)
```

If you do not remember, this data set contains the values of 32
different cars from 1974's *Motor Trend US magazine*. We can confirm
that this is a data frame by running the class() function on mtcars:

```r
    > class(mtcars)

    ## [1] "data.frame"
```

Lets also look at mtcars in the console:

```r
    > mtcars

    ##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
    ## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
    ## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
    ## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
    ## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
    ## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
    ## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
    ## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
    ## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
    ## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
    ## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
    ## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
    ## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
    ## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
    ## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
    ## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
    ## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
    ## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
    ## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
    ## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
    ## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
    ## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
    ## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
    ## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
    ## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
    ## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

Each row of the data frame represents a unique car. The names of the
cars are placed as "row names," which are similar to column headers.
Here is a rough breakdown of what the other ten variables represent:


<table>
<thead>
<tr class="odd">
<th>variable</th>
<th align="even">data</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>mpg</td>
<td align="left">miles per gallon</td>
</tr>
<tr class="even">
<td>cyl</td>
<td align="left">number of cylinders</td>
</tr>
<tr class="odd">
<td>disp</td>
<td align="left">displacement in cubic inches</td>
</tr>
<tr class="even">
<td>hp</td>
<td align="left">horsepower</td>
</tr>
<tr class="odd">
<td>drat</td>
<td align="left">rear axle ratio</td>
</tr>
<tr class="even">
<td>wt</td>
<td align="left">weight (1000lbs)</td>
</tr>
<tr class="odd">
<td>qsec</td>
<td align="left">1/4 mile time</td>
</tr>
<tr class="even">
<td>vs</td>
<td align="left">V(0) or Straight Engine(1)</td>
</tr>
<tr class="odd">
<td>am</td>
<td align="left">automatic (0) or manual(1) transmission</td>
</tr>
<tr class="even">
<td>gear</td>
<td align="left">number of forward gears</td>
</tr>
<tr class="odd">
<td>carb</td>
<td align="left">number of carburetors</td>
</tr>
</tbody>
</table>

We can access any of the columns by affixing the name of the data frame
with a $ and the name of the column. For instance, to get all the mpg
values for mtcars:

```r
    > mtcars$mpg

    ##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2
    ## [15] 10.4 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4
    ## [29] 15.8 19.7 15.0 21.4
```

We can also get the value of a data frame by placing row and column in
brackets separated by a comma. For example, to get the number of
cylinder of the Mazda RX4, we can type:

```r
    > mtcars[1,2]

    ## [1] 6
```

Sometimes, it is quicker to view the top six rows to get a quick
overview of what is in the data frame. We can do this with the head()
function:

```r
    > head(mtcars)

    ##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

We can also see the last six rows with the tail() function:

```r
    > tail(mtcars)

    ##                 mpg cyl  disp  hp drat    wt qsec vs am gear carb
    ## Porsche 914-2  26.0   4 120.3  91 4.43 2.140 16.7  0  1    5    2
    ## Lotus Europa   30.4   4  95.1 113 3.77 1.513 16.9  1  1    5    2
    ## Ford Pantera L 15.8   8 351.0 264 4.22 3.170 14.5  0  1    5    4
    ## Ferrari Dino   19.7   6 145.0 175 3.62 2.770 15.5  0  1    5    6
    ## Maserati Bora  15.0   8 301.0 335 3.54 3.570 14.6  0  1    5    8
    ## Volvo 142E     21.4   4 121.0 109 4.11 2.780 18.6  1  1    4    2
```

## What is Tidy Data and the Tidyverse?

If you work in the humanities, you probably have a system to organize
and retrieve your research. Maybe you are using a popular digital system
like [Zotero](https://www.zotero.org/) or
[Mendeley](https://www.mendeley.com/). Or, perhaps you are more
traditional and use note cards or some other analog system. Similarly,
you need to think about how to organize your data to make it easier to
work with in R. One common organizational framework is to make your data
"tidy."

According to [Hadley Wickham](http://hadley.nz/), data is "tidy" when it
meets three key criterias:

1.  Each observation is in a row.
2.  Each variable is in a column.
3.  Each value has its own cell.

Maintaining this philosophy allows you to recognize organized data from
unorganized data. Of course, not all data needs to be stored in a "tidy"
format. For instance, data that is textually heavy is more commonly
stored in a corpus, although you can also [work with it in a tidy
format](http://tidytextmining.com/). It is up to you to determine the
best way to organize data.

One of the key benefits of keeping your data tidy is that we can use the
packages in the "tidyverse" to manipulate them. All the packages in the
tidyverse are created by [Hadley Wickham](http://hadley.nz/), a prolific
statistician, author, programmer, and theorist.

## Pipe Operator

Before beginning to work with our data, we should go over the pipe
operator (%&gt;%) in R. The pipe operator is part of the
[magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html)
package created by [Stefan Milton Bache](http://stefanbache.dk/) and
[Hadley Wickham](http://hadley.nz/) and is included in the tidyverse.

If you are familiar with other programming languages, you have probably
seen looping and conditional statements. In R, you will find that
looping is becoming increasingly less common due to the pipe operator.
The syntax may seem a little intimidating at first, but once you learn
it, you will find that it makes your code a lot more readable by
avoiding nested statements.

The pipe operator allows you to pass what is to the left of the pipe as
the first variable in a function specified on the right. Don't worry if
this is a little confusing right now. It will be a lot easier to
understand with some examples.

Lets say that we are interested in getting the sqrt of each value in mpg
and then summing all the square roots before getting the mean.
Obviously, this isn't a useful measurement, but it demonstrates how R
code can quickly become hard to read. Normally, we would nest the
statements:

```r
    > mean(sum(sqrt(mtcars$mpg)))

    ## [1] 141.9126
```

As you can see, with enough nested commands, it can be difficult to
remember how many parenthesis you need. To mitigate this, some people
create temporary vectors in between each function call:

```r
    # Get square root of all the mpg values of mtcars and store in temporary variable 

    > sqrt_mpg_vector<-sqrt(mtcars$mpg)

    # Get sum of all the sqrts of the temporary variable

    > sum_sqrt_mpg_vector<-sum(sqrt_mpg_vector)

    # Get mean of the temporary variable

    > mean_sum_sqrt_mpg_vector<-mean(sum_sqrt_mpg_vector)

    # Display the mean

    > mean_sum_sqrt_mpg_vector

    ## [1] 141.9126
```

Although you get the same answer, this is a lot more readable. However,
it can quickly clutter your workspace if you forget to delete the
temporary vectors. The pipe operator does all this for you. Here is the
same code using the pipe operator:

```r
    > mtcars$mpg%>%sqrt%>%sum%>%mean

    ## [1] 141.9126
```

You could have written this on multiple lines but you need to make sure
that you put the operator at the end of the line:

```r
    > mtcars$mpg%>%
        sqrt%>%
        sum%>%
        mean

    ## [1] 141.9126
```

It is important to note that the vectors or data frames that the pipe
operator creates are discarded after the operation is complete. If you
want to store them, you should pass them to a new variable:

```r
    > permanent_sqrt_and_sum_mtcars_vector <- mtcars$mpg%>%sqrt%>%sum%>%mean
    > permanent_sqrt_and_sum_mtcars_vector 

    ## [1] 141.9126
```

## We Need a New Dataset

Now that we have an understanding of data frames and the pipe operator,
we are ready to begin manipulating our data. Unfortunately, for
historians, there are only a few easily available datasets--perhaps you
can help change this by making yours available to the public! We are
going to rely on the [history
data](https://www.google.com/search?q=cran%20historydata) package
created by [Lincoln Mullen](http://lincolnmullen.com/).

This packages contains samples of historical datasets. Specifically, we
are going to work with the early\_colleges dataset that contains
information about colleges founded before 1848. Lets load the data and
view it:

```r
    > data(early_colleges)
    > early_colleges

    ## # A tibble: 65 × 6
    ##                   college         original_name          city state
    ##                     <chr>                 <chr>         <chr> <chr>
    ## 1                 Harvard                  <NA>     Cambridge    MA
    ## 2        William and Mary                  <NA>  Williamsburg    VA
    ## 3                    Yale                  <NA>     New Haven    CT
    ## 4  Pennsylvania, Univ. of                  <NA>  Philadelphia    PA
    ## 5               Princeton College of New Jersey     Princeton    NJ
    ## 6                Columbia        King's College      New York    NY
    ## 7                   Brown                  <NA>    Providence    RI
    ## 8                 Rutgers       Queen's College New Brunswick    NJ
    ## 9               Dartmouth                  <NA>       Hanover    NH
    ## 10   Charleston, Coll. Of                  <NA>    Charleston    SC
    ## # ... with 55 more rows, and 2 more variables: established <int>,
    ## #   sponsorship <chr>
```

As you can see, this dataset contains the name of the college, its
original name, the city and state it was founded, when the college was
established, and its sponsorship. As we discussed earlier, before we can
work with a dataset. It is important to think about how to organize the
data. Lets see if any of our data is not in a "tidy" format. Do you see
any cells that do not match the three critireia for tidy data?

If you guessed the sponsorship of Harvard, you are correct. In addition
to noting the original sponsorship, it also mentions that it changed
sponsorship in 1805. Usually, you want to keep as much information about
your data that you can, but for the purposes of this tutorial, we are
going to change the column to only have the original sponsorship:

```r
    > early_colleges[1,6] <- "Congregational"
    > early_colleges

    ## # A tibble: 65 × 6
    ##                   college         original_name          city state
    ##                     <chr>                 <chr>         <chr> <chr>
    ## 1                 Harvard                  <NA>     Cambridge    MA
    ## 2        William and Mary                  <NA>  Williamsburg    VA
    ## 3                    Yale                  <NA>     New Haven    CT
    ## 4  Pennsylvania, Univ. of                  <NA>  Philadelphia    PA
    ## 5               Princeton College of New Jersey     Princeton    NJ
    ## 6                Columbia        King's College      New York    NY
    ## 7                   Brown                  <NA>    Providence    RI
    ## 8                 Rutgers       Queen's College New Brunswick    NJ
    ## 9               Dartmouth                  <NA>       Hanover    NH
    ## 10   Charleston, Coll. Of                  <NA>    Charleston    SC
    ## # ... with 55 more rows, and 2 more variables: established <int>,
    ## #   sponsorship <chr>
```

Now that we have our data in a tidy format, we can shape it through the
dplyr package.

## What is Dplyr?

[Dplyr](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
is another part of the tidyverse that provides functions for
manipulating and transforming your data. Each function corresponds to a
verb, with the five key verbs being filter, select, arrange, mutate, and
summarise--dplyr uses the British spelling. We will go through each of
them individually to see how they work in practice.

For most of these functions, you will use conditional operators to
choose what data you want to work with. R has most of the common
conditional operators:

<table>
<thead>
<tr class="odd">
<th>conditional</th>
<th class="even">meaning</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>&gt;</td>
<td align="left">greater than</td>
</tr>
<tr class="even">
<td>&lt;</td>
<td align="left">less than</td>
</tr>
<tr class="odd">
<td>&lt;=</td>
<td align="left">less than or equal to</td>
</tr>
<tr class="even">
<td>&gt;=</td>
<td align="left">greater than or equal to</td>
</tr>
<tr class="odd">
<td>==</td>
<td align="left">equals</td>
</tr>
<tr class="even">
<td>!=</td>
<td align="left">not equals</td>
</tr>
<tr class="odd">
<td>!</td>
<td align="left">negation</td>
</tr>
<tr class="even">
<td>||</td>
<td align="left">or (for logical values)</td>
</tr>
<tr class="odd">
<td>&amp;&amp;</td>
<td align="left">and (for logical values)</td>
</tr>
<tr class="even">
<td>&amp;</td>
<td align="left">and (for logical vectors)</td>
</tr>
<tr class="odd">
<td>|</td>
<td align="left">or (for logical vectors)</td>
</tr>
</tbody>
</table>

### Select

If we look at the early\_colleges data, we can see that there are a lot
of NA's in the original names column. NA signifies that the data is not
available, and we may want to view our data with this column removed.
Dplyr's select() function allows us to this. It takes the data frame you
want to manipulate as the first argument and a list signifying what
columns you would like to keep:

```r
    # Remove the original names column using select()
    # Note that you do not have to append the column name with a $ to the end of early_colleges since  
    # dplyr automatically assumes that a "," represents AND 

    > select(early_colleges, college, city, state, established, sponsorship)

    ## # A tibble: 65 × 5
    ##                   college          city state established
    ##                     <chr>         <chr> <chr>       <int>
    ## 1                 Harvard     Cambridge    MA        1636
    ## 2        William and Mary  Williamsburg    VA        1693
    ## 3                    Yale     New Haven    CT        1701
    ## 4  Pennsylvania, Univ. of  Philadelphia    PA        1740
    ## 5               Princeton     Princeton    NJ        1746
    ## 6                Columbia      New York    NY        1754
    ## 7                   Brown    Providence    RI        1765
    ## 8                 Rutgers New Brunswick    NJ        1766
    ## 9               Dartmouth       Hanover    NH        1769
    ## 10   Charleston, Coll. Of    Charleston    SC        1770
    ## # ... with 55 more rows, and 1 more variables: sponsorship <chr>
```

Lets also go ahead and see how to write this using the pipe operator
(%&gt;%):

```r
    > early_colleges%>%
        select(college, city, state, established, sponsorship)

    ## # A tibble: 65 × 5
    ##                   college          city state established
    ##                     <chr>         <chr> <chr>       <int>
    ## 1                 Harvard     Cambridge    MA        1636
    ## 2        William and Mary  Williamsburg    VA        1693
    ## 3                    Yale     New Haven    CT        1701
    ## 4  Pennsylvania, Univ. of  Philadelphia    PA        1740
    ## 5               Princeton     Princeton    NJ        1746
    ## 6                Columbia      New York    NY        1754
    ## 7                   Brown    Providence    RI        1765
    ## 8                 Rutgers New Brunswick    NJ        1766
    ## 9               Dartmouth       Hanover    NH        1769
    ## 10   Charleston, Coll. Of    Charleston    SC        1770
    ## # ... with 55 more rows, and 1 more variables: sponsorship <chr>
```

Referencing each of the columns that we want to keep just to get rid of
one is a little tedous. We can use the minus symbol(-) to demonstrate
that we want to remove a column.

```r
    > early_colleges%>%
        select(-original_name)

    ## # A tibble: 65 × 5
    ##                   college          city state established
    ##                     <chr>         <chr> <chr>       <int>
    ## 1                 Harvard     Cambridge    MA        1636
    ## 2        William and Mary  Williamsburg    VA        1693
    ## 3                    Yale     New Haven    CT        1701
    ## 4  Pennsylvania, Univ. of  Philadelphia    PA        1740
    ## 5               Princeton     Princeton    NJ        1746
    ## 6                Columbia      New York    NY        1754
    ## 7                   Brown    Providence    RI        1765
    ## 8                 Rutgers New Brunswick    NJ        1766
    ## 9               Dartmouth       Hanover    NH        1769
    ## 10   Charleston, Coll. Of    Charleston    SC        1770
    ## # ... with 55 more rows, and 1 more variables: sponsorship <chr>
```

### Filter

The filter() function does the same thing as the select function but
rather than choosing the column name, we can use it to pass a
conditional about a row. For instance, we can view all the colleges that
existed before the turn of the century:

```r
    > early_colleges%>%
        filter(established < 1800)

    ## # A tibble: 20 × 6
    ##                     college         original_name           city state
    ##                       <chr>                 <chr>          <chr> <chr>
    ## 1                   Harvard                  <NA>      Cambridge    MA
    ## 2          William and Mary                  <NA>   Williamsburg    VA
    ## 3                      Yale                  <NA>      New Haven    CT
    ## 4    Pennsylvania, Univ. of                  <NA>   Philadelphia    PA
    ## 5                 Princeton College of New Jersey      Princeton    NJ
    ## 6                  Columbia        King's College       New York    NY
    ## 7                     Brown                  <NA>     Providence    RI
    ## 8                   Rutgers       Queen's College  New Brunswick    NJ
    ## 9                 Dartmouth                  <NA>        Hanover    NH
    ## 10     Charleston, Coll. Of                  <NA>     Charleston    SC
    ## 11           Hampden-Sydney                  <NA> Hampden-Sydney    VA
    ## 12             Transylvania                  <NA>      Lexington    KY
    ## 13        Georgia, Univ. of                  <NA>         Athens    GA
    ## 14               Georgetown                  <NA>     Washington    DC
    ## 15 North Carolina, Univ. of                  <NA>    Chapel Hill    NC
    ## 16        Vermont, Univ. of                  <NA>     Burlington    VT
    ## 17                 Williams                  <NA>   Williamstown    MA
    ## 18      Tennessee, Univ. of        Blount College      Knoxville    TN
    ## 19            Union College                  <NA>    Schenectady    NY
    ## 20                 Marietta                  <NA>       Marietta    OH
    ## # ... with 2 more variables: established <int>, sponsorship <chr>
```

### Mutate

The mutate command allows you to add a column to your data frame. Right
now, we have the city and state in two separate columns. We can use the
paste command to combine two strings and specify a seperator. Lets place
them in a single column called "location":

```r
    > early_colleges%>%mutate(location=paste(city,state,sep=","))

    ## # A tibble: 65 × 7
    ##                   college         original_name          city state
    ##                     <chr>                 <chr>         <chr> <chr>
    ## 1                 Harvard                  <NA>     Cambridge    MA
    ## 2        William and Mary                  <NA>  Williamsburg    VA
    ## 3                    Yale                  <NA>     New Haven    CT
    ## 4  Pennsylvania, Univ. of                  <NA>  Philadelphia    PA
    ## 5               Princeton College of New Jersey     Princeton    NJ
    ## 6                Columbia        King's College      New York    NY
    ## 7                   Brown                  <NA>    Providence    RI
    ## 8                 Rutgers       Queen's College New Brunswick    NJ
    ## 9               Dartmouth                  <NA>       Hanover    NH
    ## 10   Charleston, Coll. Of                  <NA>    Charleston    SC
    ## # ... with 55 more rows, and 3 more variables: established <int>,
    ## #   sponsorship <chr>, location <chr>
```

Again, you need to remember that dplyr does not save the data or
manipulate the original. Instead, it creates a temporary data frame at
each step. If you want to keep it, you need to create a permanent
variable:

```r
    > early_colleges_with_location <- early_colleges%>%
        mutate(location=paste(city, state, sep=","))
        
    # View the new tibble with the location added 
    > early_colleges_with_location

    ## # A tibble: 65 × 7
    ##                   college         original_name          city state
    ##                     <chr>                 <chr>         <chr> <chr>
    ## 1                 Harvard                  <NA>     Cambridge    MA
    ## 2        William and Mary                  <NA>  Williamsburg    VA
    ## 3                    Yale                  <NA>     New Haven    CT
    ## 4  Pennsylvania, Univ. of                  <NA>  Philadelphia    PA
    ## 5               Princeton College of New Jersey     Princeton    NJ
    ## 6                Columbia        King's College      New York    NY
    ## 7                   Brown                  <NA>    Providence    RI
    ## 8                 Rutgers       Queen's College New Brunswick    NJ
    ## 9               Dartmouth                  <NA>       Hanover    NH
    ## 10   Charleston, Coll. Of                  <NA>    Charleston    SC
    ## # ... with 55 more rows, and 3 more variables: established <int>,
    ## #   sponsorship <chr>, location <chr>
```

### Arrange

The arrange() function allows us to order our columns in a new way.
Currently, the colleges are organized by year in ascending order. Lets
place them in descending order of establishment from the Civil War:

```r
    > early_colleges %>% 
        arrange(desc(established))

    ## # A tibble: 65 × 6
    ##                  college original_name        city state established
    ##                    <chr>         <chr>       <chr> <chr>       <int>
    ## 1    Wisconsin, Univ. of          <NA>     Madison    WI        1848
    ## 2                Earlham          <NA>    Richmond    IN        1847
    ## 3                 Beloit          <NA>      Beloit    WI        1846
    ## 4               Bucknell          <NA>   Lewisburg    PA        1846
    ## 5               Grinnell          <NA>    Grinnell    IA        1846
    ## 6            Mount Union          <NA>    Alliance    OH        1846
    ## 7    Louisiana, Univ. of          <NA> New Orleans    LA        1845
    ## 8     U.S. Naval Academy          <NA>   Annapolis    MD        1845
    ## 9  Mississipps, Univ. of          <NA>      Oxford    MI        1844
    ## 10            Holy Cross          <NA>  Worchester    MA        1843
    ## # ... with 55 more rows, and 1 more variables: sponsorship <chr>
```

### Summarise

The last key function in dplyr is summarise()--note the British
spelling. Summarise() takes a function or operation, and is usually used
to create a data frame that contains summary statistics for plotting. We
will use it to calculate the average year that colleges before 1848 were
founded:

```r
    > early_colleges%>%summarise(mean(established))

    ## # A tibble: 1 × 1
    ##   `mean(established)`
    ##                 <dbl>
    ## 1            1809.831
```

## Conclusion

This tutorial should put you well on the way to thinking about how to
organize and manipulate your data in R. Later, you will probably want to
share your results by visualizing your data. I recommend that you begin
looking at the [ggplot2](http://www.ggplot2.org) package for a set of
tools that work well with dplyr. In addition, you may want to take
examine some of the other functions that come with dplyr to hone your
skills. Either way, this should provide a good foundation to build on
and covers a lot of the common problems you will encounter.
