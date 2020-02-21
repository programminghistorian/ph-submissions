---
title: Understanding and Using Common Similarity Measures for Text Analysis
collection: lessons
layout: lesson
slug:
date:
translation_date:
authors:
- John R. Ladd
reviewers:
-
editors:
- Brandon Walsh
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/275
difficulty:
activity:
topics:
abstract:
mathjax: true
---

{% include toc.html %}

# Overview

The first question many researchers want to ask after collecting data is how similar one data sample---a text, a person, an event---is to another. It's a very common question for humanists and critics of all kinds: given what you know about two things, how alike or how different are they? Non-computational assessments of similarity and difference form the basis of a lot of critical activity. The genre of a text, for example, can be determined by assessing that text's similarity to other texts already known to be part of the genre. And conversely, knowing that a certain text is very different from others in an established genre might open up productive new avenues for criticism. An object of study's uniqueness or sameness relative to another object or to a group can be a crucial factor in the scholarly practices of categorization and critical analysis.

Statistical measures of similarity allow scholars to think computationally about how alike or different their objects of studies may be, and these measures are the building blocks of many other clustering and classification techniques. In text analysis, the similarity of two texts can be assessed in its most basic form by representing each text as a series of word counts and calculating distance using those word counts as features. This tutorial will focus on the core concepts behind measuring distance among texts by talking through the advantages and disadvantages of three of the most common distance measures: city block or "Manhattan" distance, Euclidean distance, and cosine distance. It will discuss when to use one measure over another and also show you how to calculate these distances using the SciPy library in Python.

# Preparation

## Suggested Prior Skills

Though this lesson is primarily geared toward understanding the underlying principles of these calculations, it does assume some familiarity with the Python programming language. Code for this tutorial is written in Python3.6 and uses the Pandas (v0.25.3) and SciPy (v1.3.3) libraries to calculate distances, though it's possible to calculate these same distances using other libraries and other programming languages. For the text processing tasks, you will also use lxml (v4.3.2) and scikit-learn (v0.21.2). I recommend you work through some of [the *Programming Historian* Python lessons](https://programminghistorian.org/en/lessons/introduction-and-installation) if you are not already familiar with Python.

## Installation and Setup

You will need to install Python3 as well as the SciPy, Pandas, lxml, and scikit-learn libraries. The easiest way to do this is through the [Anaconda Distribution](https://www.anaconda.com/distribution/), which includes all of these libraries. For more information about installing Anaconda, see the [full documentation](https://docs.anaconda.com/anaconda/).

## Lesson Dataset

You can run these distance measures on almost any data set that uses numerical features to describe specific data samples (more on that in a moment). For the purposes of this tutorial, you will use a selection of 142 texts, all published in 1666, from the [*EarlyPrint* project](https://earlyprint.org/). This project (of which I am a collaborator) has linguistically-annotated and corrected [EEBO-TCP](https://earlyprint.org/intros/intro-to-eebo-tcp.html) texts.

Begin by [downloading the zipped set of XML files]({{ site.baseurl }}/assets/common-similarity-measures/1666_texts.zip). You'll follow a procedure, explained below, similar to the one in [this tutorial on the *EarlyPrint* site](https://earlyprint.org/notebooks/tf_idf.html), which converts *EarlyPrint* XML documents into a TF-IDF matrix. TF-IDF, which stands for Term Frequency–Inverse Document Frequency, is a weighting system that assigns a value to every word in a text based on the relationship between the number of times a word appears in that text (its term frequency) and the number of texts it appears in through the whole corpus (its document frequency). It is often used as an initial heuristic for a word's distinctiveness and can give the researcher more information than a simple word count. To understand exactly what TF-IDF is and what calculating it entails, see Matthew J. Lavin's [Analyzing Documents with TF-IDF](https://programminghistorian.org/en/lessons/analyzing-documents-with-tfidf).

# What is Similarity or Distance?

Similarity is a large umbrella term that covers a wide range of scores and measures for assessing the differences among various kinds of data. In fact, similarity refers to much more than one could cover in a single tutorial. For this lesson, you'll learn just one general type of similarity score that is particularly relevant to DH researchers in text analysis. The class of similarity covered below takes word-based features and measures the *similarity* among documents based on their *distance* from one another in Cartesian space: it determines the differences between texts based on their word counts. For more information, see the Distance and Similarity section, below.

## Samples and Features

Measuring distance or similarity first requires understanding your objects of study as **samples** and the parts of those objects you are measuring as **features**. For text analysis, samples are usually texts, but these are abstract categories. Samples and features can be anything. A sample could be a bird species, for example, and a measured feature of that sample could be average wingspan. You can have as many samples and as many features as you want: though you'd ultimately come up against limits in computing power, the mathematical principles will work regardless of the number of features and samples you are dealing with.

We'll begin with an example. Let's say you have two texts, the first sentences of Jane Austen's *Pride and Prejudice* and of Edith Wharton's *Ethan Frome*, respectively. You can label your two texts `austen` and `wharton`. In Python, they would look like this:

```py
austen = "It is a truth universally acknowledged, that a single man in possession of a good fortune must be in want of a wife."

wharton = "I had the story, bit by bit, from various people, and, as generally happens in such cases, each time it was a different story. "
```

So `austen` and `wharton` are your two data **samples**, the units of information about which you'd like to know more. These two samples have lots of **features**, attributes of the data samples that we can measure and represent numerically. The number of words in each sentence could be one feature; the number of characters could be another. So could the number of nouns in each sentence, if you chose to measure that, or the frequency of certain vowel sounds. The features you choose will depend on the nature of your research question.

For this example, you will use individual word counts as features. Consider the frequencies of the word "a" and the word "in" in your two samples. You could construct a chart of the counts like so:

|  | a | in |
| --------- | --------- | --------- |
| austen | 4 | 2 |
| wharton | 1 | 1 |

Later, you'll use the TF-IDF data set mentioned in the previous section, and like this very small sample data set, the TF-IDF data includes columns (features) that are individual words and rows (samples) for specific texts. The main differences are that the values refer to TF-IDF results (which are extrapolations from the raw term frequency used above) and that there are columns for 1000 words instead of 2. As you're about to see, despite these differences, distance measures are available via the same calculations. Here's a glimpse of what those samples and features will look like:

{% include figure.html filename="tfidf_sample.png" caption="A screenshot of the sample TF-IDF data set." %}

## The Cartesian Coordinate System

Once you've chosen samples and measured some features of those samples, you can represent that data in a wide variety of ways. One of the oldest and most common is the [Cartesian coordinate system](https://en.wikipedia.org/wiki/Cartesian_coordinate_system), which you may have learned about in introductory algebra and geometry. This system allows you to represent numerical features as *coordinates*, typically in 2-dimensional space. The data table above could be represented like this:

{% include figure.html filename="datapoints.jpg" caption="'austen' and 'wharton' samples represented as data points." %}

On this graph, the `austen` and `wharton` samples are each represented as **data points** along two axes, or dimensions. The horizontal x-axis represents the values for the word "in" and the vertical y-axis represents the values for the word "a." Though it may look simple, this representation allows us to imagine a spatial relationship between **data points** based on their **features**, and this spatial relationship, what we're calling similarity or distance, can tell you something about which **samples** are alike.

Here's where it gets cool. You can represent two **features** as two dimensions and visualize your **samples** using the Cartesian coordinate system. Naturally you could also visualize our samples in three dimensions if you had three features. If you had four or more features, you couldn't visualize the samples anymore: for how could you create a four-dimensional graph? But it doesn't matter, because *no matter how many features or dimensions you have, you can still calculate distance in the same way*. If you're working with word frequencies, as we are here, you can have as many **features**/dimensions as you do words in a text. From here forward, the examples of distance measures will use two dimensions, but when you calculate distance with Python later in this tutorial, you'll calculate over thousands of dimensions using the same equations.

## Distance and Similarity

Now you've taken your **samples** and rendered them as points in space. As a way of understanding how these two points are related to each other, you might ask: how far apart or close together are these two points? The answer to how "how far apart are these points" is their **distance**, and the answer to "how close together are these points" is their **similarity**. In addition to this distinction, **similarity**, as I mentioned above, can refer to a larger category of similarity scores, whereas **distance** usually refers to a more narrow category that measures difference in Cartesian space.

It may seem redundant or confusing to use both terms, but in text analysis these concepts are usually reciprocally related (i.e. distance is merely the opposite of similarity and vice versa). I bring them both up for a simple reason: out in the world you are likely to encounter both terms, sometimes used more or less interchangeably. When you are measuring by distance, **the most closely related points will have the lowest distance**, but when you are measuring by similarity, **the most closely related points will have the highest similarity**. For the most part you will encounter distance rather than similarity, but this may come in handy if you encounter a program or algorithm that outputs similarity instead. (And see the Cosine Distance/Similarity section for more on this distinction.)

You might think that calculating distance is as simple as drawing a line between these two points and calculating its length. And it can be! But in fact there are many, many ways to calculate the distance between two points in Cartesian space, and different distance measures are useful for different purposes. For instance, the SciPy `pdist` function that you'll use later on lists 22 distinct measures for distance. In this tutorial, you'll learn about three of the most common distance measures: **city block distance**, **Euclidean distance**, and **cosine distance**.

# Three Types of Distance/Similarity

## City Block (or Manhattan) Distance

The simplest way of calculating the distance between two points is, perhaps surprisingly, not to go in a straight line. The simplest way is to go horizontally and then vertically until you get from one point or the other. This is simpler because it only requires you to subtract rather than do more complicated calculations.

Your `wharton` sample is at point (1,1): its **x-coordinate** is one (its value for "in"), and its **y-coordinate** is one (its value for "a"). Your `austen` sample is at point (2,4): its x-coordinate is two, and its y-coordinate is four. We want to go "around the block" to calculate distance by looking at the differences between the x- and y-coordinates. The dotted line here shows what you're measuring:

{% include figure.html filename="cityblock.jpg" caption="The distance between 'austen' and 'wharton' points by 'city block' distance." %}

You can see here why it's called city block distance, or "Manhattan distance" if you prefer a more New York-centric pun. On this graph it's easy to tell that the length of the horizontal line is one and the length of the vertical line is three, which means the city block distance is four. But how would you abstract this measure? As I alluded to above, city block distance is the sum of the differences between the x- and y-coordinates. So for two points with any values (let's call them $$(x_1, y_1)$$ and $$(x_2, y_2)$$), the city block distance is calculated like so:

$$|x_2 - x_1| + |y_2 - y_1|$$

(The vertical bars you see are for *absolute value*; they ensure that even if $$x_1$$ is greater than $$x_2$$, your values are still positive.) Try it out with your two points (1,1) and (2,4):

$$|2 - 1| + |4 - 1| = |1| + |3| = 1 + 3 = 4$$

And that's it! You could add a third coordinate, call it "z," or as many additional dimensions as you like for each point, and still calculate city block distance fairly easily. Because city block distance is easy to understand and calculate, it's a good one to start with as you learn the general principles. But it's less useful for text analysis than the other two distance measures we're covering. And in most cases, you're likely to get better results using the next distance measure, **Euclidean distance**.

## Euclidean Distance

At this point I can imagine what you're thinking. Why should you care about "going around the block"? The shortest distance between two points is a straight line, after all.

**Euclidean distance**, named for the [geometric system attributed to the Greek mathematician Euclid](https://en.wikipedia.org/wiki/Euclidean_geometry), will allow you to measure the straight line. Look at the graph again, but this time with a line directly between the two points:

{% include figure.html filename="euclidean.jpg" caption="The distance between 'austen' and 'wharton' data points using Euclidean distance." %}

You'll notice I left in the city block lines. If we want to measure the distance of the line ("c") between our two points, you can think about that line as the [**hypotenuse**](https://en.wikipedia.org/wiki/Hypotenuse) of a right triangle, where the other two sides ("a" and "b") are the city block lines from our last distance measurement.

You calculate the length of the line "c" in terms of "a" and "b" using the [Pythagorean theorem](https://en.wikipedia.org/wiki/Pythagorean_theorem):

$$a^2 + b^2 = c^2$$

or:

$$c = \sqrt[]{a^2 + b^2}$$

We know that the values of a and b are the differences between x- and y-coordinates, so the full formula for **Euclidean distance** can be written like so:

$$\sqrt[]{(x_2 - x_1)^2 + (y_2 - y_1)^2}$$

If you put the `austen` and `wharton` points into this formula, you get:

$$\sqrt[]{(2 - 1)^2 + (4 - 1)^2} = \sqrt[]{1^2 + 3^2} = \sqrt[]{1 + 9} = \sqrt[]{10} = 3.16$$[^1]

The Euclidean distance result is, as you might expect, a little less than the city block distance. Each measure tells you something about how the two points are related, but each also tells you something *different* because its underlying theory about what "distance" means is different. One isn't inherently better than the other, but it's important to know that **distance** isn't a set fact: the distance between two points can be quite different depending on how you define distance in the first place.

## Cosine Similarity and Cosine Distance

To emphasize this point, the final similarity/distance measure you will learn here, [**cosine similarity**](https://en.wikipedia.org/wiki/Cosine_similarity), is very different from the other two. It is more concerned with the *orientation* of the two points in space than it is with their exact distance from one another.

If you draw a line from the **origin**---the point on the graph at the coordinates (0, 0)---to each point, you can identify an angle, $$\theta$$, between the two points, like so:

{% include figure.html filename="cosine.jpg" caption="The angle between the 'austen' and 'wharton' data points, from which you will take the cosine." %}

The **cosine similarity** between the two points is simply the cosine of this angle. [**Cosine**](https://en.wikipedia.org/wiki/Trigonometric_functions#cos) is a trigonometric function that, in this case, helps you describe the orientation of two points. If two points were 90 degrees apart, that is if they were on the x-axis and y-axis of this graph as far away from each other as they can be in this [graph quadrant](https://en.wikipedia.org/wiki/Cartesian_coordinate_system), their cosine similarity would be zero, because $$cos(90) = 0$$. If two points were zero degrees apart, that is if they existed along the same line, their cosine similarity would one, because $$cos(0) = 1$$.

Cosine provides you with a ready-made scale for similarity. Points that have the same orientation have a similarity of one, the highest possible. Points that have 90 degree orientations have a similarity of zero, the lowest possible.[^2] Any other value will be somewhere in between.

You needn't worry very much about how to calculate **cosine similarity** algebraically. Any programming environment will calculate it for you. But it's possible to determine the cosine similarity by beginning only with the coordinates of two points, $$(x_1, y_1)$$ and $$(x_2, y_2)$$, like so:

$$cos(\theta) = (x_1x_2 + y_1y_2)/(\sqrt[]{x_1^2 + y_1^2}\sqrt[]{x_2^2 + y_2^2})$$

If you enter in your two `austen` and `wharton` coordinates, you get:

$$(1\times2 + 1\times4)/(\sqrt[]{1^2 + 1^2}\sqrt[]{2^2 + 4^2}) = 6/(\sqrt[]{2}\sqrt[]{20}) = 6/6.32 = 0.95$$[^3]

The **cosine similarity** of our `austen` sample to our `wharton` sample is quite high, almost one. This is borne out by looking at the graph, on which we can see that the angle $$\theta$$ is fairly small. Because the two points are closely oriented, their **cosine similarity** is high. To put it another way: according to the measures you've seen so far, these two texts are pretty similar to one another.

But note that you're dealing with **similarity** here and not **distance**. The highest value, one, is reserved for the two points that are most close together, while the lowest value, zero, is reserved for the two points that are the least close together. This is the exact opposite of **Euclidean distance**, in which the lowest values describe the points closest together. To remedy this confusion, most programming environments calculate **cosine distance** by simply subtracting the **cosine similarity** from one. So **cosine distance** is simply $$1 - cos(\theta)$$. In your example, the **cosine distance** would be:

$$1 - 0.95 = 0.05$$

This low **cosine distance** is more easily comparable to the **Euclidean distance** you calculated above, but it tells you the same thing as the **cosine similarity** result above: that the `austen` and `wharton` samples, when represented only by the number of times they each use the words "a" and "in," are fairly similar to one another.

# How To Know Which Distance Measure To Use

These measures aren't at all the same thing, and they yield quite different results. Yet they're all types of **distance**, ways of describing the relationship between two data samples. This illustrates the fact that, even at a very basic level, the decisions you make as an investigator can have an outsized effect on your results.

In this case, the decision you must make is: "How do I measure the relationship between two points?" The answer to that question depends on the nature of the data you start with and on what you're trying to find out.

As you saw in the previous section, **city block distance** and **Euclidean distance** are similar because they are both concerned with the lengths of lines between two points. This makes them more interchangeable. In most cases, **Euclidean distance** will be preferable over **city block** because it is more direct in its measurement of a straight line between two points.

**Cosine distance** is another story. The choice between **Euclidean** and **cosine** distance is an important one, especially when working with data derived from text. I've already illustrated that **cosine distance** is only concerned with the orientation of two points and not with their exact placement. This means that **cosine distance** is much less effected by **magnitude**, or how large your numbers are.

To illustrate this, say for example that your points are (1,2) and (2,4) (instead of the (1,1) and (2,4) you used in the last section). The internal relationship within the two sets of coordinates is the same: a ratio of 1:2. But the points aren't identical: the second set of coordinates has twice the **magnitude** of the first.

The **Euclidean distance** between these two points is:

$$\sqrt[]{(2 - 1)^2 + (4 - 2)^2} = \sqrt[]{1^2 + 2^2} = \sqrt[]{1 + 4} = \sqrt[]{5} = 2.24$$

But their **cosine similarity** is:

$$(1\times2 + 2\times4)/(\sqrt[]{1^2 + 2^2}\sqrt[]{2^2 + 4^2}) = 10/(\sqrt[]{5}\sqrt[]{20}) = 10/\sqrt[]{100} = 10/10 = 1$$

So their **cosine distance** is:

$$1 - 1 = 0$$

Where **Euclidean distance** is concerned, these points have a little distance from one another. While in terms of **cosine distance**, these two points are not at all distant. This is because **Euclidean distance** accounts for **magnitude** while **cosine distance** does not. Another way of putting this is that **cosine distance** measures whether the relationship *among your various features* is the same, regardless of *how much* of any one thing is present. This would be true if one of your points was (1,2) and the other was (300,600) as well.

**Cosine distance** is sometimes very good for text-related data. Often texts are of very different lengths. If words have vastly different counts but exist in the text in roughly the same proportion, **cosine distance** won't worry about the raw counts, only their proportional relationships to each other. Otherwise, as with **Euclidean distance** you might wind up saying something like, "All the long texts are similar, and all the the short texts are similar." With text, it's often better to use the distance measure that disregards differences in **magnitude** and focuses on the proportions of features.

However, if you know your sample texts are all roughly the same size (or if you have subdivided all your texts into equally-sized "chunks," a common pre-processing step), you might prefer to account for relatively small differences in **magnitude** by using **Euclidean distance**. And for non-text data where the size of the sample is unlikely to effect the features, **Euclidean distance** is sometimes preferred.

There's no one clear answer for which distance measure to choose. As you've learned, it's highly dependent on your data and your research question. That's why it's important to know your data well before you start out. And if you're stacking other methods---like clustering or a machine learning algorithm---on top of distance measures, you'll certainly want to understand the distinction between distance measures and the ways a choice of one over the other may effect your results down the line.

# Calculating Distance in Python

Now that you understand city block, Euclidean, and cosine distance, you're ready to calculate these measures using Python. As your example data, you'll use the [pre-calculated TF-IDF results]({{ site.baseurl }}/assets/common-similarity-measures/common-similarity-measures.zip) that were created in the [*EarlyPrint* TF-IDF tutorial](https://earlyprint.org/notebooks/tf_idf.html). If you need a refresher on TF-IDF, refer to Lavin's [Programming Historian tutorial](https://programminghistorian.org/en/lessons/analyzing-documents-with-tfidf) on the topic.

## Preparing the Documents

To begin, you'll need to import the libraries (Pandas, SciPy, lxml, and scikit-learn) that you acquired in the Setup and Installation section above, as well as a few built-in libraries. Create a new blank file in your text editor of choice, and name it `similarity.py`. (You can also download my [complete version of this script]({{ site.baseurl }}/assets/common-similarity-measures/similarity.py).) At the top of the file, type:

```py
# The external libraries
import pandas as pd
from scipy.spatial.distance import pdist, squareform
from lxml import etree
from sklearn.feature_extraction.text import TfidfTransformer

# The built-in libraries
import glob, csv
from collections import Counter
```

The first thing you'll want to do is open the XML documents, count their words, and put them into an easy-to-process form, as a Pandas DataFrame object. First, unzip the files you downloaded and place it in a new subfolder inside folder in which you will work, perhaps called "1666_texts". (The directory `1666_texts/` file will need to be in the same folder as `similarity.py` for this to function.) In the next few lines, I am following the procedure outlined in [this *EarlyPrint* tutorial](https://earlyprint.org/notebooks/tf_idf.html); you can refer there for a more detailed explanation of the setup. On the next line of your file, type:

```py
# Use the glob library to open all the XML files
files = glob.glob('1666_texts/*.xml')

all_words = [] # An empty list to put the words from each text
filekeys = [] # An empty list to keep track of filenames
for f in files: # Loop through each file
    filekeys.append(f.split("/")[-1].split(".")[0]) # Add the file ID to the list
    with open(f, 'r') as ep_file: # Open each file
        xml = etree.fromstring(ep_file.read().encode('utf8')) # Read the file, encode it properly, and load it as an etree object
        # Now we can use lxml to find all the w tags
        # Get regularized spellings, but eliminate any instances
        # where a missing word causes a〈◊〉symbol to appear
        words = [w.get('reg', w.text) for w in xml.findall('.//{*}w') if w.text != '〈◊〉']
        # Then we add these results to a master list
        all_words.append(words)
```

This part may take a few minutes, since the XML files take a bit longer to process than plain text. Thanks to the tokenized *EarlyPrint* documents, you now have a series of lists that contain every word in each document.

## Counting Words and Calculating TF-IDF

The next step is to count up all the words in each document, and to put those counts into a DataFrame that will be easier to work with later on. You'll use the Counter class and pandas library that you imported at the top of the file. On the next line, type:

```py
# Count the words in each sub-list individually
all_counted_by_doc = [Counter(a) for a in all_words]
# Create a dataframe, using the file keys you saved above
df = pd.DataFrame(all_counted_by_doc, index=filekeys).fillna(0)
```

The resulting DataFrame treats each document as a row and has a column for every word that appears in these texts: that's almost 175,000 columns! It would take a long time to calculate over every single word, and many of the words in this list only appear one or two times in the entire corpus. For our purposes right now, low-frequency words won't give that much additional information. Most of the difference between these texts is contained in how they use the highest frequency words. To make your calculations faster and simpler, you can limit the DataFrame to just the 1000 most frequent words. To do that, you must first identify those words by counting words not by their frequency in individual documents, but by their frequency across the entire corpus. On the next line of your file, type:

```py
# Use the sum() function to flatten your list of lists
# into one giant list. Then, use Counter to count the words.
all_counted_by_corpus = Counter(list(sum(all_words, [])))
# Counter lets you ask for the most common words.
# It returns both words and counts, so just take the words.
top_1000 = [a[0] for a in all_counted_by_corpus.most_common(1000)]

# Now you can filter your DataFrame using this list
df = df.filter(items=top_1000)
```

Now you have a DataFrame with a more manageable one thousand columns. You could calculate your distances based on these counts. Those calculations would work exactly like the ones with our `austen` and `wharton` example, except with 1000 features instead of 2. (If you'd like to try this, swap out `tfidf_results` with `df` in the code below.) But we can transform those simple word counts into a score that takes into account a word's presence in the entire corpus. That score is called TF-IDF, which as I mentioned above stands for Term Frequency–Inverse Document Frequency and is a heuristic for understanding a word's distinctiveness. You can use scikit-learn to calculate TF-IDF. A more complete explanation of this process can be found in [Matt Lavin's tutorial on TF-IDF](https://programminghistorian.org/en/lessons/analyzing-documents-with-tfidf). On the next line of your file, type:

```py
# First we need to create an "instance" of the transformer, with the proper settings.
# We need to make sure that normalization is turned off
tfidf = TfidfTransformer(norm=None, sublinear_tf=True)
# I am choosing to turn on sublinear term frequency scaling, which takes the log of
# term frequencies and can help to de-emphasize function words like pronouns and articles.
# You might make a different choice depending on your corpus.

# Once we've created the instance, we can "transform" our counts
results = tfidf.fit_transform(df)

# Make results readable using Pandas
tfidf_results = pd.DataFrame(results.toarray(), index=df.index, columns=df.columns)
```

This returns a DataFrame with the same number of rows and columns as your word counts DataFrame, but the values in this data are the TF-IDF scores for each word in each text. Now that you have this, you're ready to begin calculating distances.

## Calculating Distance using SciPy

Calculating distance in SciPy comprises two steps: first you calculate the distances, and then you must expand the results into a "squareform" matrix so that they're easier to read and process.[^4] The distance function in SciPy is called `pdist` and the squareform function is called `squareform`. **Euclidean distance** is the default output of `pdist`, so you'll use that one first. To calculate distances you simply call the `pdist` function on your DataFrame by typing `pdist(tfidf_results)`. To get the squareform results, you can wrap that entire thing in the `squareform` results: `squareform(pdist(tfidf_results))`. And to make this more readable, you'll want to put it all into a new DataFrame. On the next line of your file, type:

```py
euclidean_distances = pd.DataFrame(squareform(pdist(tfidf_results)), index=tfidf_results.index, columns=tfidf_results.index)
print(euclidean_distances)
```

You need to declare, as you can see above, that the `index` variable for the rows and the `column` variable will both be the same as the index of the original DataFrame. Stop now, save this file, and run it from the command line by navigating to the appropriate directory in your Terminal application and typing `python3 similarity.py`. The script will print a matrix of the **Euclidean distances** between every text in the dataset!

In this "matrix," which is really just a table of numbers, the rows and columns are the same. Each row represents a single XML document from *EarlyPrint*, and the columns represent exactly the same documents. The value in every cell is the distance between the text from that row and the text from that column. That's why there will be a diagonal line of zeroes through the center of your matrix: where every text is compared to itself, the distance value is zero.

*EarlyPrint* XML documents are corrected and annotated versions of XML documents from [the Early English Books Online–Text Creation Partnership](https://earlyprint.org/intros/intro-to-eebo-tcp.html), which includes a document for almost every book printed in England between 1473 and 1700. This sample dataset includes all the texts published in 1666—the ones that are currently publically available (the rest will be available after January 2020). What the matrix is showing you, then, is the relationships among books printed in England in 1666. This includes texts from a variety of different genres on all sorts of topics: religious texts and political treatises and literary works, to name a few. One thing a researcher might want to know right away with a text corpus as thematically diverse as this one is: is there a computational way to determine the kinds of similarity that a reader cares about? When you calculate the distances among two scientific texts and a philosophical tract, will the results "make sense" to an expert reader? You'll try to answer that question in the exercise that follows.

There's a lot you could do with this table of distances beyond simply sorting it in the way you will do here. You could use it as an input for an unsupervised clustering of the texts into groups, and you could use the same measures to drive a machine learning model. If you wanted to simply understand these results better, you could create a heatmap of this table itself, either in Python or by exporting this table as a CSV and visualizing it elsewhere.

As an example, let's take a look at the five texts most similar to Robert Boyle's *Hydrostatical paradoxes made out by new experiments*, and which is part of this dataset under the ID number `A28989`. The book is a scientific treatise and one of two works Boyle published in 1666. By comparing distances, you might hope to find books that are either thematically or structurally similar to Boyle's: either scientific texts (rather than religious works, for instance) or texts that have similar prose sections (rather than poetry collections or plays, for instance).

Let's see what texts **Euclidean distance** says are similar to Boyle's book. You can do this using Pandas's `nsmallest` function. Remove the line that says `print(euclidean_distances)`, and in its place type:

```py
print(euclidean_distances.nsmallest(6, 'A28989')['A28989'])
```

Why six instead of five? Because this is a symmetrical, "square" matrix, one of the possible results is always the same text. Since we know that any text's distance to itself is zero, it will certainly come up in our results. We need five more in addition to that one, so six total.

The results you get should look like this:

```
A28989     0.000000
A29017    73.627957
A62436    79.951447
A43020    82.644734
A56390    82.879041
A42820    84.448654
```

Your results will only contain the Text Creation Partnership ID numbers, but you can look up those file keys in this [metadata table on the *EarlyPrint* site](https://earlyprint.org/download/). (You could also download the metadata for the texts printed in 1666 as a CSV and process it in Python alongside your results, but that is outside the scope of this lesson.) Here are the authors, titles, and subject keywords that correspond to the five texts listed:

```
A29017  Boyle, Robert, 1627-1691.	The origine of formes and qualities, (according to the corpuscular philosophy) illustrated by considerations and experiments (written formerly by way of notes upon an essay about nitre) by ... Robert Boyle ...	Matter -- Constitution -- Early works to 1800. Light, Corpuscular theory of -- Early works to 1800.
A62436  Thomson, George, 17th cent.	Loimotomia, or, The pest anatomized in these following particulars, Viz. 1. The material cause of the pest, 2. The efficient cause of the pest, 3. The subject part of the pest, 4. The signs of the pest, 5. An historical account of the dissections of a pestilential body by the author, and the consequences thereof, 6. Reflections and observations on the fore-said dissection, 7. Directions preservative and curative against the pest : together with the authors apology against the calumnies of the Galenists, and a word to Mr. Nath. Hodges, concerning his late Vindiciae medicinae / by George Thomson.	Hodges, Nathaniel, 1629-1688. -- Vindiciae medicinae et medicorum. Plague.
A43020  Harvey, Gideon, 1640?-1700?	Morbus anglicus: or, The anatomy of consumptions Containing the nature, causes, subject, progress, change, signes, prognosticks, preservatives; and several methods of curing all consumptions, coughs, and spitting of blood. With remarkable observations touching the same diseases. To which are added, some brief discourses of melancholy, madness, and distraction occasioned by love. Together with certain new remarques touching the scurvy and ulcers of the lungs. The like never before published. By Gideon Harvey, M.D.	Tuberculosis -- Early works to 1800.
A56390  Parker, Samuel, 1640-1688.	A free and impartial censure of the Platonick philosophie being a letter written to his much honoured friend Mr. N.B. / by Sam. Parker.	Platonists. Empiricism -- Early works to 1800.
A42820  Glanvill, Joseph, 1636-1680.	A philosophical endeavour towards the defence of the being of vvitches and apparitions. In a letter to the much honoured, Robert Hunt, esq; by a member of the Royal Society.	Witchcraft -- England -- Early works to 1800.
```

There's some initial success on this list. The first text is Boyle's other published work from 1666, which suggests that our features are succesfully finding texts that a human would recognize as similar. The next two texts, George Thomson's on plague and Gideon Harvey's on tuberculosis, are both recognizably scientific and clearly related to Boyle's. But the next two seem to stray from the topic a bit. Samuel Parker's reflection on Plato and empiricism and Joseph Glanvill's text about witchcraft written for the science-focused Royal Society both probably use similar scientific language, but neither seems to be exactly what a researcher would want to find when searching for similar texts. The next question to ask is: can **cosine distance** get better results with the same data?

You can calculate **cosine distance** in exactly the way you calculated **Euclidean distance**, but with a parameter that specifies the type of distance you want to use. On the next lines of your file, type:

```py
cosine_distances = pd.DataFrame(squareform(pdist(tfidf_results, metric='cosine')), index=tfidf_results.index, columns=tfidf_results.index)

print(cosine_distances.nsmallest(6, 'A28989')['A28989'])
```

The script will now output the top six texts for both Euclidean distance and cosine distance. (You could calculate city block distance by using `metric='cityblock'`, but the results are unlikely be substantially different from Euclidean distance.) The results for **cosine distance** should look like this:

```
A28989    0.000000
A29017    0.108424
A43020    0.180408
A62436    0.183249
A53049    0.184745
A60482    0.197873
```

Right away you'll notice a big difference. Because **cosine distances** are scaled from 0 to 1 (see the previous section for an explanation of why this is the case), we can tell not only what the closest samples are, but *how* close they are.[^5] All of the closest 5 texts have a cosine distance greater than 0.2, which means most of them are *pretty* close to Boyle's text. This is helpful to know and puts some of the previous results into context.

Here is some metadata for the texts that **cosine distance** identified:

```
A29017  Boyle, Robert, 1627-1691.	The origine of formes and qualities, (according to the corpuscular philosophy) illustrated by considerations and experiments (written formerly by way of notes upon an essay about nitre) by ... Robert Boyle ...	Matter -- Constitution -- Early works to 1800. Light, Corpuscular theory of -- Early works to 1800.
A43020  Harvey, Gideon, 1640?-1700?	Morbus anglicus: or, The anatomy of consumptions Containing the nature, causes, subject, progress, change, signes, prognosticks, preservatives; and several methods of curing all consumptions, coughs, and spitting of blood. With remarkable observations touching the same diseases. To which are added, some brief discourses of melancholy, madness, and distraction occasioned by love. Together with certain new remarques touching the scurvy and ulcers of the lungs. The like never before published. By Gideon Harvey, M.D.	Tuberculosis -- Early works to 1800.
A62436  Thomson, George, 17th cent.	Loimotomia, or, The pest anatomized in these following particulars, Viz. 1. The material cause of the pest, 2. The efficient cause of the pest, 3. The subject part of the pest, 4. The signs of the pest, 5. An historical account of the dissections of a pestilential body by the author, and the consequences thereof, 6. Reflections and observations on the fore-said dissection, 7. Directions preservative and curative against the pest : together with the authors apology against the calumnies of the Galenists, and a word to Mr. Nath. Hodges, concerning his late Vindiciae medicinae / by George Thomson.	Hodges, Nathaniel, 1629-1688. -- Vindiciae medicinae et medicorum. Plague.
A53049  Newcastle, Margaret Cavendish, Duchess of, 1624?-1674.	Observations upon experimental philosophy to which is added The description of a new blazing world / written by the thrice noble, illustrious, and excellent princesse, the Duchess of Newcastle.	Philosophy, English -- 17th century. Voyages, Imaginary.
A60482  Smith, John, 1630-1679.	Gērochomia vasilikē King Solomons portraiture of old age : wherein is contained a sacred anatomy both of soul and body, and a perfect account of the infirmities of age, incident to them both : and all those mystical and ænigmatical symptomes expressed in the six former verses of the 12th chapter of Ecclesiastes, are here paraphrased upon and made plain and easie to a mean capacity / by John Smith ...	Bible. -- O.T. -- Ecclesiastes XII, 1-6 -- Paraphrases, English.
```

The first three texts in the list are the same as before, and that's good news, especially in the case of Boyle's other text, which you would expect to be first regardless of the measure. Gideon and Thomson are reversed in this list, though, suggesting perhaps that **Euclidean distance** was picking up on a similarity between Thomson and Boyle that had more to do with **magnitude** (i.e. the texts were similar lengths) than it did with their contents (i.e. words used in similar proportions).

The final two texts are also more relevant to Boyle's. Margaret Cavendish's *Observations upon experimental philosophy* (experimental philosophy and natural philosophy were alternative terms for early scientific thought) fits in well here.[^6] And though John Smith's *Gērochomia vasilikē* is a reflection on the book of Ecclesiastes, it's equally concerned with questions of anatomy and aging. As you might expect, because **cosine distance** is more focused on comparing the proportions of features within individual samples, its results were slightly better for this text corpus. But **Euclidean distance** was on the right track, even if it didn't capture all the similarity you were looking for. If as a next step you expanded these lists out to ten texts, you'd likely see even more difference between results for the two distance measures.

It's crucial to note that this exploratory investigation into text similarity didn't give you a lot of definitive answers. Instead it raises many interesting questions. Which words (features) caused these specific books (samples) to manifest as similar to one another? What does it mean to say that two texts are "similar" according to TF-IDF scores rather than raw word counts or some other feature set? What else can we learn about the texts that appeared in proximity to Boyle's? Like many computational methods, distance measures provide you with a way to ask new and interesting questions of your data, and initial results like these can lead you down new research paths.

# Next Steps

I hope this tutorial gave you a more concrete understanding of basic distance measures as well as a handle on when to choose one over the other. In the future you may be using these measures in the same way you did above: to look at the most similar samples in a large data set. But it's even more likely that you'll encounter distance measures as a near-invisible part of a larger data mining approach. For example, [**k-means clustering**](https://en.wikipedia.org/wiki/K-means_clustering) uses **Euclidean distance** by default to determine groups or clusters in a large dataset. Understanding the pros and cons of distance measures could help you to better understand and use a method like **k-means clustering**. Or perhaps more importantly, a good foundation in understanding distance measures might help you to assess and evaluate someone else's digital work more accurately.

Distance measures are a good first step to investigating your data, but a choice between the three different metrics described above---or the many other available distance measures---is never neutral. Understanding the advantages and trade-offs of each can make you a more insightful researcher and help you better understand your data.

[^1]: I rounded this result to the nearest hundredth place to make it more readable.

[^2]: A similarity lower than 0 is indeed possible. If you move to another quadrant of the graph, two points could have a 180 degree orientation, and then their cosine similarity would be -1. But because you can't have negative word counts (our basis for this entire exercise), you'll never have a point outside this quadrant.

[^3]: Once again, I've done some rounding in the final two steps to make this operation more readable.

[^4]: SciPy's `pdist` function outputs what's called a "sparse matrix" to save space and processing power. This is fine if you're using this as part of a pipeline for another purpose, but we want the "squareform" matrix so that we can see all the results. It's called "squareform" because the columns and rows are the same, so the matrix is symmetrical, or square.

[^5]: It's certainly possible to scale the results of Euclidean or city block distance as well, but it's not done by default.

[^6]: This book also contains Cavendish's proto-science fiction novel *The Blazing World*, and it could be interesting to investigate the similarities within different parts of the book.
