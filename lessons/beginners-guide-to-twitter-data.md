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
