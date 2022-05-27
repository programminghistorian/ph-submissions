---
title: Scalable Reading of Structured Data
collection: lessons
layout: lesson
slug: scalable-reading-of-structured-data
date:
translation_date:
authors:
- Max Odsbjerg Pedersen 1
- Josephine Møller Jensen 2
- Victor Harbo Johnston 3
- Alexander Ulrich Thygelsen 4
- Helle Strandgaard Jensen 5
reviewers:
editors:
translator:
translation-editor:
translation-reviewer:
original:
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/419
difficulty: 2
activity: [analyzing]
topics: [api]
abstract: In this lesson, you will be introduced to 'scalable reading' and how to apply this workflow to your analysis of structured data.
---

# Table of Contents

{% include toc.html %}

--

# Lesson Structure
In this lesson, we introduce a workflow for scalable reading of structured data. The lesson is structured in two parallel tracks: 
1. A general track, suggesting a way to work analytically with structured data where distant reading of a large dataset is used as context for a close reading of distinctive datapoints. 
2. An example track, in which we use simple functions in the programming language R to analyze Twitter data. 
Combining these two tracks, we show how scalable reading can be used to analyze a wide variety of structured data. Our suggested scalable reading workflow includes two types of distant readings that will help explore and analyze overall features in large data sets (chronologically and in relation to binary structures), plus a way of using distant reading to select individual data points for close reading in a systematic and reproducible manner.

# Lesson Aims
Having completed this lesson readers will be able to:
* Set up a workflow where exploratory, distant reading is used as a context that guides the selection of individual data points for close reading 
* Employ exploratory analyses to find patterns in structured data
* Apply and combine basic filtering and arranging functions in R (if you have no or little knowledge of R, we recommend looking at the lesson [R Basics with Tabular Data](https://programminghistorian.org/en/lessons/r-basics-with-tabular-data))

# Scalable Reading, a Gateway for Newcomers to Digital Methods
The combination of close and distant reading introduced in this lesson is meant as a gateway into digital methods for students and academics who are new to incorporating computational thinking in their work. When connecting distant reading of large datasets to close reading of single data points, we create a bridge between computational methods and hand-curated methods commonly used in humanities subjects. In our experience, scalable reading - where the analysis of the entire data sets represents a set of contexts for the close reading - eases the difficulties newcomers might experience in asking questions of their material which can be explored and answered using computational thinking. The reproducible way of selecting individual cases for closer inspection speaks, for instance, directly to central questions within the discipline of history and sociology regarding the relationship between a general context and a case study. 

# The Scalable Reading 
We originally used the workflow presented below to analyze the remembrance of the American children’s television program *Sesame Street* on Twitter. We used the combined close and distant reading to find out how certain events generated discussion of *Sesame Street’s* history, which Twitter-users dominated the discourse about *Sesame Street’s* history, and which parts of the show's history they emphasised. Our example below also uses a small dataset related to tweets about *Sesame Street*. However, the same analytical framework can also be used to analyze many other kinds of structured data. To demonstrate the applicability of the workflow to other kinds of data, we discuss how it could be applied to a set of structured data from the digitized collections held by the National Gallery of Denmark. The data from the National Gallery is very different from the Twitter data used in the lesson's example track, but the general idea of using distant reading to contextualize close reading works equally well as with the Twitter data. 

The workflow for scalable reading of structured data we suggest below has three steps: 
1. **Chronological exploration of a dataset.** <br>This step suggests a chronological exploration of a dataset. In the Twitter dataset, we explore how a specific phenomenon gains traction on the platform during a certain period of time. Had we worked on data from the National Gallery, we could have analyzed the timely distribution of their collections e.g. according to acquisition year or when artworks were made.
 
2. **Exploring a dataset by creating binary-analytical categories.** <br> This step suggests using a dataset's existing metadata categories to create questions of a binary nature, in other words questions which can be answered with a yes/no or true/false logic. We use this creation of a binary-analytical structure as a way to analyze some of the dataset's overall trends. In the Twitter dataset, we explore the use of hashtags (versus lack of use); the distribution of tweets on verified versus non-verified accounts; and the interaction level of these two types of accounts. Had we worked on data from the National Gallery we could have used the registered meta-data on artwork type, gender and nationality to explore the collection's representation of Danish versus international artists; paintings versus non-paintings; or artists registered as female and unknown versus artists registered as male, etc.  

3. **Systematic selection of single datapoints for close reading** <br>This step suggests a systematic and reproducible way of selecting single datapoints for close reading. In the Twitter dataset, we selected for close reading the 20 most commonly liked tweets. Had we worked on data from the National Gallery it could, for instance, be the top 20 most exhibited, borrowed, or annotated items.  

Below, the three steps are explained in general terms as well as specifically using our Twitter example. 

# Data and Prerequisites
If you want to reproduce the analysis we present below, using not only the overall conceptual framework but also the code, we assume that you already have a dataset containing twitter data in a JSON format. If you don't have a dataset you can acquire one in the following ways: 

1. Using one of Twitter’s APIs, e.g. their freely available so-called "Essential" API which we used to retrieve the dataset used in the example (see more about APIs this section to the [Introduction to Populating a Website with API Data](https://programminghistorian.org/en/lessons/introduction-to-populating-a-website-with-api-data#what-is-application-programming-interface-api)). This link will take you to [Twitter's API options](https://developer.twitter.com/en/docs/twitter-api/getting-started/about-twitter-api) 
2. Using the [Beginner's Guide to Twitter Data](https://programminghistorian.org/en/lessons/beginners-guide-to-twitter-data) from the Programming Historian. But rather than choosing a CSV output, choose a JSON.

In R, you work with packages, each adding numerous functionalities to the core functions of R. In this example the relevant packages are the following: rtweet, tidyverse, lubridate and jsonlite. To install packages in R see this section of lesson [Basic Text Processing in R](https://programminghistorian.org/en/lessons/basic-text-processing-in-r#package-set-up). To use the packages in R they have to be loaded with the `library()` function as below:

    library(rtweet)
    library(tidyverse)
    library(lubridate)
    library(jsonlite)
    

To follow the coding examples, make sure you have installed and loaded
the following packages in R:

### tidyverse

The package “tidyverse” is an umbrella package loading several libraries
that are all handy in terms of working with data. For further
information on and learning to use tidyverse see
<https://www.tidyverse.org>.[^1]


### lubridate

The package lubridate is used for handling different date formats in R
and doing operations on them. The package in from the same group behind
the package “tidyverse”, but is not a core package in the “tidyverse”.[^2]


### jsonlite

The package “jsonlite” is for handling the dataformat Javascript Object
Notation (json), which is a format used for exchanging data on the
internet. For more information on the jsonlite-package see
<https://cran.r-project.org/web/packages/jsonlite/index.html>[^3]

If you already have a JSON file containing your twitter data, you can
use the `fromJSON`-function in the "jsonlite"-package to upload the data
into your R environment.

## Acquiring a small test dataset on the go

### rtweet

The package “rtweet” is an implementation of calls designed to collect
and organize Twitter data via Twitter’s REST and stream Application
Program Interfaces (API), which can be found at the following URL:
<https://developer.twitter.com/en/docs>.[^4]

If you have not already acquired some Twitter data and wish to follow
the coding examples step-by-step, you can use your twitter account and
the `search_tweets()`-function from the “rtweet”-package to import
twitter data into your R environment. This will return up to 18000
tweets from the past 10 days. The data will be structured in the form of a "dataframe". Much like a spreadsheet, a dataframe organizes your data into a 2-dimensional table of rows and columns.
By copying the code chunk below, you will be able to generate a
dataframe based on a free-text search on the term “sesamestreet” to follow our example.

    sesamestreet_data <- search_tweets(q = "sesamestreet", n = 18000)


# Step 1: Chronological exploration of a Dataset 
Exploring a dataset’s chronological dimensions can facilitate the first analytical review of your data. In case you are studying a single phenomenon’s evolvement over time (like our interest in specific events that spurred discussions around *Sesame Street*), understanding how this phenomenon gained traction and/or how interest dwindled can be revealing as to it significance. It can be the first step in understanding how all of the collected data relates to the phenomenon over time. Your interest in timely dispersion could also relate not to an event but rather to a dataset’s total distribution based on a set of categories. For instance, in case you were working on data from the National Gallery, you might want to explore the distribution of its collections according to different periods in art history to which are represented the most or the least. Knowledge of the timely dispersion of the overall dataset can help contextualize the individual datapoints selected for close reading in step 3, because it will give you an idea of how a specific datapoint's relation to the chronology of the entire dataset compares to that of all the other datapoints.


## Example of a dataset's timely dispersion: Twitter data

In this example, you are interested in how much *Sesame Street* is talked about on Twitter during a given period of time. We also want to know how many tweets used the official hashtag "\#sesamestreet" during this period.


In the following, we start of with some data processing before moving on
to the actual visualisation. What you are asking the data here is
a two-piece question:

-   First of you want to know the dispersion of the tweets over time.
-   Second, you want to know how many of these contain a the hashtag
    "\#sesamestreet".

Especially the last question needs some data wranglig before it is
possible to answer it. The process here is to create a new column which
has the value "TRUE" if the tweet contains the hashtag and FALSE if not.
This is done with the `mutate()`-function, which creates a new column
called "has\_sesame\_ht". To put the TRUE/FALSE-values in this column we
use the `str_detect()`-function. This function is told that it is
detecting on the column "text", which contains the tweet. Next it is
told what it is detecting. Here we use the `regex()`-function within
`str_detect()` and by doing that we can specify that we are interested
in all variants of the hashtag (eg \#SesameStreet, \#Sesamestreet,
\#sesamestreet, \#SESAMESTREET, etc.). This is achieved by setting
"ignore\_case = TRUE" in the `regex()`-function which applies a regular expression to your data.
Regular expressions can be seen as an extendend search-and-replace function. if you want to explore regular expressions further you can read more in the article 
[Understanding Regular Expressions](https://programminghistorian.org/en/lessons/understanding-regular-expressions).

The next step is another `mutate()`-function, where we create a new
column "date". This column will contain just the date of the tweets
instead of the entire timestamp from Twitter that not only contains the
date, but also the hour, minute and second of the tweet. This is
obtained with the `date()`-function from the "lubridate"-packages, which
is told that it should extract the date from the "created\_at"-column.  
Lastly we use the `count`-function from the "tidyverse"-package to count
TRUE/FALSE-values in the “has\_sesame\_ht”-column per day in the data set. The function `%>%` will be explained in more detail in the next example. 

    sesamestreet_data %>% 
      mutate(has_sesame_ht = str_detect(text, regex("#sesamestreet", ignore_case = TRUE))) %>% 
      mutate(date = date(created_at)) %>% 
      count(date, has_sesame_ht)
      
<!-- tsk -->
 
    ## # A tibble: 20 x 3
    ##    date       has_sesame_ht     n
    ##    <date>     <lgl>         <int>
    ##  1 2021-12-04 FALSE            99
    ##  2 2021-12-04 TRUE             17
    ##  3 2021-12-05 FALSE           165
    ##  4 2021-12-05 TRUE             53
    ##  5 2021-12-06 FALSE           373
    ##  6 2021-12-06 TRUE             62
    ##  7 2021-12-07 FALSE           265
    ##  8 2021-12-07 TRUE             86
    ##  9 2021-12-08 FALSE           187
    ## 10 2021-12-08 TRUE             93
    ## 11 2021-12-09 FALSE           150
    ## 12 2021-12-09 TRUE             55
    ## 13 2021-12-10 FALSE           142
    ## 14 2021-12-10 TRUE             59
    ## 15 2021-12-11 FALSE           196
    ## 16 2021-12-11 TRUE             41
    ## 17 2021-12-12 FALSE           255
    ## 18 2021-12-12 TRUE             44
    ## 19 2021-12-13 FALSE            55
    ## 20 2021-12-13 TRUE             35

Please beware that your data will look slightly different, as it was not collected on the same date as ours and the conversation about *Sesame Street* represented in your dataset will be different from what it was just prior to 13th December where we collected the data for our example.

You are now going to visualise your results. In the code below, we have
appended the code for the visualisation to the four lines of code above
that transforms the data to our interest in exploring the chronology of tweets with and without the official hashtag "\#sesamestreet".  
To pick up where we left in the previous code chunk, we continue with the
`ggplot()`-function, which is the graphics package of the “tidyverse”.
This function is told that it should put date on the x-axis and the
counted number of TRUE/FALSE-values on the y-axis. The next line of the
creation of the visualisation is `geom_line()`,where we specify
"linetype=has\_sesame\_ht", thus creating two lines for; one for
TRUE and one for FALSE.

The lines of code following the `geom_line()` argument tweaks the
aesthetics of the visualisation. `scale_linetype()`tells R, what the
lines should be labeled as. `scale_x_date()` and `scale_y_continuous()`
changes the looks of the x- and y-axis, respectively. At last, the
`labs()` and `guides()` arguments are used to create descriptive text on
the visualisation.

Remember to change the titles in the code below to match your specific dataset (as we wrote above, you are probably not doing this on the 13th December 2021). You'll find the titles under `labs()`.

    sesamestreet_data%>% 
      mutate(has_sesame_ht = str_detect(text, regex("#sesamestreet", ignore_case = TRUE))) %>% 
      mutate(date = date(created_at)) %>% 
      count(date, has_sesame_ht) %>% 
      ggplot(aes(date, n)) +
      geom_line(aes(linetype=has_sesame_ht)) +
      scale_linetype(labels = c("No #sesamestreet", "#sesamestreet")) +
      scale_x_date(date_breaks = "1 day", date_labels = "%b %d") +
      scale_y_continuous(breaks = seq(0, 400, by = 50)) +
      theme(axis.text.x=element_text(angle=40, hjust=1)) +
      labs(title = "Figure 1 - Daily tweets dispersed on whether or not they\ncontain #sesamestreet", y="Number of Tweets", x="Day", subtitle = "Period: 4 december 2021 - 13 december 2021", caption = "Total number of tweets: 2.413") +
      guides(linetype = guide_legend(title = "Whether or not the\ntweet contains \n#sesamestreet"))

{% include figure.html filename="scalable-reading-of-structured-data-1.png" caption="NEEDS CAPTION" %}

You should now have a graph depicting the timely dispersion of tweets in
your dataset. We will now proceed with the binary exploration of some of your dataset's distinctive features.

# Step 2: Exploring a dataset by creating binary-analytical categories
Using a binary logic to explore a dataset can be a first and, compared to other digital methods, relatively simple way to get at important relations in your dataset. Binary relations are easy to count using computer code and can reveal systematic and defining structures in your data. In our case, we were interested in the power relations on Twitter and in the public sphere more generally. We, therefore, explored the differences between so-called verified and non-verified accounts, as verified accounts are marked as such due to their public status outside of the platform. You might be interested in how many tweets were retweets or originals. In both cases you can use the existing metadata registered for the dataset to create a question that can be answered using a binary logic (does the tweet come from a verified account yes or no; is the tweet a retweet yes or no?). Or, suppose you were working with data from the National Gallery. In that case, you might want to explore gender bias in the collections and whether the institution has favoured aquireing artworks by people who are registerede as male in their catalogue. In this case you could arrange your dataset to be able to count if an artist is registered as male or not? If you were interest in the collections distribution of Danish versus international artists, the data could be arranged in a binary structure that allowed you to ask if the artists are registered as Danish or not. 

The binary relations can form a context for your close reading of datapoints selected in step 3. Knowing the distribution of data in two categories will also enable you to establish a single datapoint’s representativity vis-à-vis this category's distribution in the entire dataset. For instance, if you in step 3 chose to work on the 20 most commonly liked tweets, you would be able to see that even if there were many tweets from verified accounts in this select pool, these accounts were not well represented in the overall dataset; the 20 most liked tweets you have selected are thus not representative of the tweets from most accounts in your dataset, they represent a small, but much "liked" percentage. Or, if you choose to work on the top 20 displayed artworks in a dataset from the National Gallery, a binary exploration of Danish versus non-Danish artists might enable to see that even if the top 20 most displayed works were all painted by international artists, these artists were otherwise poorly represented in the National Gallery's collections overall.
 

## Example of a binary exploration: Twitter data

In this example, you are interested in exploring the distribution of verified versus non-verified accounts tweeting about *Sesame Street*.

In this first example of data processing you will take each step of it
to show the logic of the pipe (`%>%`) in R. Once you get a hold of this
idea the remainder of the data processing will be easier to read and
understand. The overall goal of this section is to find out how the
tweets disperse on non-verified and verified accounts and visualize the
result.

Using the pipe `%>%` you pass the data on downwards - the data is
flowing through the pipe like water! Here you pour the data to the
`count`-function and ask it to count on the column "verified" that holds
two values. Either it has "TRUE", then the account is verfied, or it
has "FALSE" - then it isn’t.

    sesamestreet_data %>% 
      count(verified)

<!-- tsk -->

    ## # A tibble: 2 x 2
    ##   verified     n
    ## * <lgl>    <int>
    ## 1 FALSE     2368
    ## 2 TRUE        64

So now you have the count - but it would make more sense to have these
figures in percentage. Therefore our next step will be adding another
pipe and a piece of code creating a new column holding the number of
total tweets in our dataset, this is necessary for calculating the
percentage later. You get the total number of tweets by using the
`nrow()`-function that returns the number of rows from a dataframe. In our
dataset one row = one tweet:

    sesamestreet_data %>% 
      count(verified) %>% 
      mutate(total = nrow(sesamestreet_data))

<!-- tsk -->

    ## # A tibble: 2 x 3
    ##   verified     n total
    ## * <lgl>    <int> <int>
    ## 1 FALSE     2368  2432
    ## 2 TRUE        64  2432

Using another pipe you now create a new column called "percentage" where
you calculate and store the percentage of the dispersion between
verified and non-verified tweets:

    sesamestreet_data %>% 
      count(verified) %>% 
      mutate(total = nrow(sesamestreet_data)) %>% 
      mutate(pct = (n / total) * 100)

<!-- tsk -->

    ## # A tibble: 2 x 4
    ##   verified     n total   pct
    ## * <lgl>    <int> <int> <dbl>
    ## 1 FALSE     2368  2432 97.4 
    ## 2 TRUE        64  2432  2.63

The next step is to visualize this result. Here you use the
"ggplot2"-package to create a column chart:

In contrast to the earlier visualisations which showed tweets over time
you now use the `geom_col`-function in order to create columns. When you start working in ggplot the pipe(`%>%`) is replaced by a `+`.

    sesamestreet_data %>% 
      count(verified) %>% 
      mutate(total = nrow(sesamestreet_data)) %>% 
      mutate(pct = (n / total) * 100) %>% 
      ggplot(aes(x = verified, y = pct)) +
      geom_col() +
      scale_x_discrete(labels=c("FALSE" = "Not Verified", "TRUE" = "Verified"))+
          labs(x = "Verified status",
          y = "Percentage",
          title = "Figure 2 - Percentage of tweets coming from verified and non-verified\naccounts in the sesamestreet-dataset",
          subtitle = "Period: 4 December 2021 - 13 December 2021", 
          caption = "Total number of tweets: 2435") + 
      theme(axis.text.y = element_text(angle = 14, hjust = 1))

{% include figure.html filename="scalable-reading-of-structured-data-2.png" caption="NEEDS CAPTION" %}

### Interaction with verified versus non-verified accounts

In this part of the example you want to investigate how much people interact with tweets from verified accounts versus tweets from non-verified accounts. We have chosen to count likes as a way to measure interaction in this example. Contrasting the interaction level of these two account types will help you estimate whether the less represented verified accounts hold much power dispite their low representation overall because people interact a lot more with their tweets than the tweets from non-verified accounts. 

In the code below, you group the dataset based on each tweet's verified
status. After using the grouping function all operations afterward will
be done groupwise. In other words all the tweets coming from non
verified-accounts and all the tweets coming from verified accounts will
be treated as groups. The next step is to use the summarise-function to
calculate the mean (gns) of "favorite\_count" for within tweets from
non-verified and verified accounts ("favorite" is the dataset's name for "like").

    sesamestreet_data %>% 
      group_by(verified) %>% 
      summarise(gns = mean(favorite_count))

<!-- tsk -->

    ## # A tibble: 2 x 2
    ##   verified     gns
    ## * <lgl>      <dbl>
    ## 1 FALSE      0.892
    ## 2 TRUE     114.

In this next step you add the result from above to a dataframe and with
a new column "interaction" where you specify that it is
"favorite\_count"

    interactions <- sesamestreet_data %>% 
      group_by(verified) %>% 
      summarise(gns = mean(favorite_count)) %>% 
      mutate(interaction = "favorite_count")

This way you get a dataframe with the means of the different
interactions which makes it possible to pass it on to the ggplot-package
for visualisation, which is done below. The visualisation looks alot
like the previous bar charts, but the difference here is `facet_wrap`,
which creates three bar charts for each type of interaction:

    interactions  %>% 
      ggplot(aes(x = verified, y = gns)) +
      geom_col() +
      facet_wrap(~interaction, nrow = 1) +
      labs(title = "Figure 4 - Means of different interaction count dispersed on the verified\nstatus in the sesammestreet dataset",
           subtitle = "Period: Period: 4 December 2021 - 13 December 2021",
           caption = "Total number of tweets: 2411",
           x = "Verified status",
           y = "Average of engagements counts") +
      scale_x_discrete(labels=c("FALSE" = "Not Verified", "TRUE" = "Verified"))

{% include figure.html filename="scalable-reading-of-structured-data-3.png" caption="NEEDS CAPTION" %}

# Step 3: Reproducible and Systematic Selection of datapoints for Close Reading
One of the great advantages of combining close and distant reading is the possibility it presents for making a systematic and reproducible selection of datapoints for close reading. When you have explored your dataset with two different kinds of distant readings in step 1 and step 2, you can use these insights to systematically select specific datapoints for a closer reading. A close reading will enable you to further unpack and explore interesting trends in your data and chosen phenomena, or other features of interest, to investigate in depth. 

How many datapoints you choose to close read will be dependent on what phenomena you are researching, how much time you have, and how complex the data is. For instance, analysing individual artwork might be much more time-consuming than reading individual tweet, but it of course depends on your purpose. It is, therefore, important that you are systematic in your selection of datapoints in order to ensure compliance with your research questions. In our case, we wanted to know more about how the top-liked tweets represented *Sesame Street*; how did they talk about the show and its history, did they link to other media, and how was the show represented visually, for instance with pictures, links to videos, memes, etc? Knowing the interesting relationship between the little representation, but high interaction level of tweets from verified accounts, we wanted to do a close reading of the top 20 liked tweets not only overall, but also from the top 20 non-verified accounts to see if these were different in the way they talked about the show and its history. We chose the top 20 because this seemed like a task we could actually manage within the time we had at our disposal.   

If you were working on data from the National Gallery, you might want to select the top 5 or 10 most displayed or borrowed artworks from Danish and international artists, to further investigate their differences or commonalities doing a close reading of their artists, type of artwork, motive, content, size, a period in art history, etc.  


## Example of reproducible and systematic selection for close reading: Twitter data
In this example you are interested in selecting the top 20 liked tweets overall. Knowing that many of these tweets probably are from verified accounts, you also want to select the top 20 tweets from non-verified accounts to be able to compare and contrast the two categories.  

To examine original tweets only, we start by filtering away all the
tweets that are "retweets."

At the top right corner of the R Studios interface, you will find your R "Global Environment" containing the dataframe *sesamestreet\_data*. By clicking the dataframe, you will be able to view the rows and columns containing your twitter data. Looking to the column "is\_retweet", you will see that this column indicates whether a tweet is a retweet by the values TRUE or FALSE. 

Going back to your R Markdown, you are now able to use the `filter`-function to retain all rows stating that the tweet is not a retweet.
You then arrange the remaining tweets by the tweets’ favorite count
which is found in the "favorite\_count" column.

Both the `filter`-function and the `arrange`-function come from the
dplyr package which is part of tidyverse.

    sesamestreet_data %>% 
      filter(is_retweet == FALSE) %>% 
      arrange(desc(favorite_count))
(Output removed because of privacy reasons) 

As you can see in the Global Environment, your data *sesamestreet\_data*
has a total of 2435 observations (the number will vary depending on when you collected your data). After running the chunk of code, you
can now read off your returned dataframe how many unique tweets your dataset contains. In our example it was 852, remember yours will vary.  

Looking at the column "favorite\_count", you can now observe how many likes your top-20 lies above. In our example the top-20 had a count above 50. These numbers
are variables that changes when you choose to reproduce this example
by yourself. Be sure to check these numbers.

### Creating a new dataset of the top 20 most liked tweets (verified and non-verfied accounts)

As you now know that the minimum "favorite\_count" value is 50, you add a
second `filter`-function to our previous code chunk which retains all
rows with a "favorite\_count" value over 50.

As you have now captured the top 20 most liked tweets, you can now
create a new dataset called
*sesamestreet\_data\_favorite\_count\_over\_50*.

    sesamestreet_data %>% 
      filter(is_retweet == FALSE) %>%
      filter(favorite_count > 50) %>% 
      arrange(desc(favorite_count)) -> sesamestreet_data_favorite_count_over_50

### Inspecting our new dafaframe 

To create a quick overview of our new dataset, you use the
`select`-function from the dplyr-package to isolate the variables you
wish to inspect. In this case, you wish to isolate the columns
favorite\_count, screen\_name, verified and text.

You then arrange them after their "favorite\_count" value by using the
`arrange`-function.

    sesamestreet_data_favorite_count_over_50 %>% 
      select(favorite_count, screen_name, verified, text) %>% 
      arrange(desc(favorite_count))
(Output removed because of privacy reasons) 

This code chunk returns a dataframe containing the previously stated
values. It is therefore much easier to inspect, than looking though the
whole dataset *sesamestreet\_data\_favorite\_count\_over\_50* in our
Global Environment.

### Exporting the new dataset as a JSON file

To export our new dataset out of our R environment and save it as a JSON
file, you use the `toJSON`-function from the jsonlite-package.

To make sure our data is stored as manageable and structured as
possible, all of our close reading data files are dubbed with the same
information:

1.  How many tweets/observations does the dataset contain.
2.  Which variablea is the data arranged after.
3.  Whether the tweets are from all types of accounts or just
    verified accounts.
4.  The year the data was produced.

<!-- -->

    Top_20_liked_tweets <- jsonlite::toJSON(sesamestreet_data_favorite_count_over_50)

After converting your data to a JSON file format, you are able to use
the `write`-function from base R to export the data and save it on
your machine.

    write(Top_20_liked_tweets, "Top_20_liked_tweets.json")

### Creating a new dataset of the top 20 most liked tweets (only non-verified accounts)

You now wish to see the top 20 most liked tweets by non-verified
accounts.

To do this, you follow the same workflow as before, but in our first
code chunk, you include an extra `filter`-function from the
"dplyr"-package which retains all rows with the value FALSE in the
verified column, thereby removing all tweets from our data which have
been produced by verified accounts.

    sesamestreet_data %>% 
      filter(is_retweet == FALSE) %>%
      filter(verified == FALSE) %>% 
      arrange(desc(favorite_count))
(Output removed because of privacy reasons)

Here you can observe how many of the total 2435 tweets that were not retweets and were created by non-verified accounts. In our example the count was 809. However, this number will not be the same, in your case. 

Looking again at the "favorite\_count" column, you can now observe how many likes you top-20 lies above. In our example the top-20 tweets from non-verified accounts had a count above 15. This time, 2 tweets share the 20th and 21th place. In this case you
therefore get the top 21 most liked tweets for this analysis.

You can now filter tweets that have been liked more than 15 times, and
arrange them from the most liked to the least, and create a new
dataset in our Global Environment called
*sesamestreet\_data\_favorite\_count\_over\_15\_non\_verified*.

    sesamestreet_data %>% 
      filter(is_retweet == FALSE) %>%
      filter(verified == FALSE) %>%
      filter(favorite_count > 8) %>% 
      arrange(desc(favorite_count)) -> sesamestreet_data_favorite_count_over_15_non_verified

### Inspecting our new dataframe (only non-verified)

We once again create a quick overview of our new dataset by using the
`select` and `arrange`-function as in before, and inspect our chosen
values in the returned dataframe.

    sesamestreet_data_favorite_count_over_15_non_verified %>% 
      select(favorite_count, screen_name, verified, text) %>% 
      arrange(desc(favorite_count))
<span style="color: green">(Output removed because of privacy reasons)</span>

### Exporting the new dataset as a JSON file

Once again you use the `toJSON`-function to export our data into a local
JSON file.

    Top_21_liked_tweets_non_verified <- jsonlite::toJSON(sesamestreet_data_favorite_count_over_15_non_verified)

    write(Top_21_liked_tweets_non_verified, "Top_21_liked_tweets_non_verified.json")

You should now have two JSON files stored in your designated directory,
ready to be loaded into another R Markdown for a close reading analysis,
or you can inspect the text column of the datasets in your current R
Global Environment.

You are now ready to copy the URL's from the dataframe and inspect the individual tweets on twitter. Remember to closely observe Twitter's "Terms and Agreements" and act accordingly. The agreement, for instance, means that you are not allowed to share your dataset with others except for as a list of tweet-ids; that off-twitter matching of  accounts and individuals need to follow very strict rules and has many limits; and that you are restrictied in various ways if you want to publish your data or cite tweets, etc.  

# Tips for working with Twitter Data
As mentioned in the beginning of this lesson, there are different ways of obtaining your data. This section of the lesson can help you apply the code from this lesson to data that have not been collected with the `rtweet`-package. 

If you have collected your data by following the lesson [Beginner's Guide to Twitter Data](https://programminghistorian.org/en/lessons/beginners-guide-to-twitter-data) you will discover that the date of tweets is shown in a way, which is noncompatible with the code from this lesson. To make the code compatible with data from *Beginner's Guide to Twitter Data* the date column has to be manipulated with regular expressions. These are quite complex and are used to tell the computer what part of the text in the column is to be understood as day, month, year and time of day:

    df %>% 
     mutate(date = str_replace(created_at, "^[A-Z][a-z]{2} ([A-Z][a-z]{2}) (\\d{2}) (\\d{2}:\\d{2}:\\d{2}) \\+0000 (\\d{4})",
                                 "\\4-\\1-\\2 \\3")) %>% 
     mutate(date = ymd_hms(date)) %>% 
     select(date, created_at, everything())

    df$Time <- format(as.POSIXct(df$date,format="%Y-%m-%d %H:%M:%S"),"%H:%M:%S")
    df$date <- format(as.POSIXct(df$date,format="%Y.%m-%d %H:%M:%S"),"%Y-%m-%d")

Some other columns that do not have the same names in our data as in the data extracted with the lesson *Beginner's Guide to Twitter Data* are our columns "verified" and "text" that are called "user.verified" and "full_text". Here you have two options. Either you change the code, so that everywhere "verified" or "text" occurs you write "user.verified" or "full_text" instead. Another approch is to change the column names in the dataframe, which can be done with the following code:

    df %>% 
     rename(verified = user.verified) %>% 
     rename(text = full_text) -> df
     
# References
[^1]: Hadley Wickham, Mara Averick, Jennifer Bryan, Winston Chang,
Lucy D’Agostino McGowan, Romain François, Garrett Grolemund,
Alex Hayes, Lionel Henry, Jim Hester, Max Kuhn, Thomas Lin
Pedersen, Evan Miller, Stephan Milton Bache, Kirill Müller,
Jeroen Ooms, David Robinson, Dana Paige Seidel, Vitalie Spinu,
Kohske Takahashi, Davis Vaughan, Claus Wilke, Kara Woo, and
Hiroaki Yutani (2019). “Welcome to the tidyverse.”
*Journal of Open Source Software*, 4(43), 1686, 1-6. doi: 10.21105/joss.01686

[^2]: Garrett Grolemund and Hadley Wickham (2011). "Dates and Times Made Easy with
lubridate." *Journal of Statistical Software*, 40(3), 1-25. www.jstatsoft.org/v40/i03/

[^3]: Ooms, Jeroen (2014). “The jsonlite Package: A Practical and Consistent Mapping
Between JSON Data and R Objects.” arXiv preprint arXiv:1403.2805. arxiv.org/abs/1403.2805

[^4]: Kearney, Michael W. (2019). "rtweet: Collecting and analyzing Twitter data.”
*Journal of Open Source Software*, 4(42), 1829, 1-3. doi: 10.21105/joss.01829.
