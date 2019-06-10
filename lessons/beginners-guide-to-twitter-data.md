---
title: |
    Beginner's Guide to Twitter Data
collection: lessons
layout: lesson
slug: beginners-guide-to-twitter-data
authors:
    - Brad Rittenhouse
    - Ximin Mi
    - Courtney Allen
layout: lesson

---

# Beginner's Guide to Twitter Data 


# Overview

In this guide, we'll show you easy methods for acquiring, hydrating, cleaning, and analyzing Twitter data.  While this walkthrough proposes a specific workflow that we think is suitable for students and researchers of all experience levels (it was originally conceived as a workshop for first-year undergraduates at Georgia Tech), we will note points in the process where other/more advanced techniques could be substituted. 

## TweetSets

First, we need to gather some data. George Washington University’s [TweetSets](https://tweetsets.library.gwu.edu/) allows you to create your own data queries from existing Twitter datasets. The datasets primarily focus on the biggest (US) geopolitical events of the last few years, but the TweetSets website states they are also open to queries regarding the construction of new datasets.  We chose TweetSets because it makes narrowing and cleaning your dataset very easy, but you could substitute any tool that gives you a set of dehydrated tweets, like Stanford’s [SNAP](https://snap.stanford.edu/data/) collections.  You could also work with the [Twitter API](https://developer.twitter.com/) directly, but this will require some coding.  Justin Littman, the creator of TweetSets, does a good job summarizing some of the higher-level ways of interacting with the API [here](https://gwu-libraries.github.io/sfm-ui/posts/2017-09-14-twitter-data).  

We find that the graphical, web-based nature of TweetSets, however, makes it ideal for learning this process.  That said, if you want to obtain a dehydrated dataset by other means, you can just start at the “Hydrating” section.

## Selecting a Dataset

{% include figure.html filename="tweetsets-home.png" caption="TweetSets start page" %}

If you’re using TweetSets, click “Get Started” and you’ll be able to see a list of all of their existing datasets. Clicking the name of each set will give you more information on the set, including its doi. 

When you have decided on the dataset(s) you  want to pull from, simply check the checkbox to the left.  You can choose as many as you’d like.  We’ve chosen two datasets focusing on Hurricanes Irma and Harvey, two major storms of the 2017 Atlantic Hurricane Season.  As you can see, this will give us just over 30 million tweets as is.  

{% include figure.html filename="dataset-selection.png" caption="Dataset Selection Page" %}

We’ll filter the dataset to make it easier to work with, but if you’re feeling confident in your data manipulation skills, you can download the whole thing.

## Filtering the Dataset with Parameters

On the parameters page, you have the option to limit your dataset by the tweet text content, hashtags used, mentions made, users who posted the tweets, users who are being replied to, the tweet type (original, quote, retweet, or reply), the timeframe during which the tweets were posted, or if they contain things like embedded images or geotags. 

{% include figure.html filename="parameters-1.png" caption="The "Parameters" page" %}

{% include figure.html filename="parameters-2.png" caption="Selecting all tweets that mention @realDonaldTrump." %}

As you can see above, we’ve chosen to limit our dataset by two parameters.  First, we want tweets that mention @realDonaldTrump and second, we want tweets that have geotags or location information.  This should give us a good view of who is talking about President Trump in these datasets, and where they are located.  You can imagine this kind of data would be good in analyzing how discourse around disasters forms both at ground zero and more broadly.  

{% include figure.html filename="parameters-3.png" caption="Selecting all geotagged tweets and the Action buttons section" %}

Once you have filled in your desired parameters, you have three options to proceed. "Preview" will give you a sample of the tweets based on your parameters, and, conveniently, the number of tweets your current parameters will return.  As you can see, the two parameters we chose have the added benefit of winnowing down the dataset from over thirty million tweets to just over five thousand: much more manageable.  This option is very helpful to make sure you are constructing a dataset that will work for your purposes before you actually go and download a bunch of data.  With more advanced tools, you usually have to download and hydrate your data before being able to figure out what is in it.

{% include figure.html filename="statistics.png" caption="Dataset Preview" %}

The "Create Dataset" option will freeze the parameters and create an exportable dataset.  "Start over" will reset your parameters and also return you to the dataset selection page. 
