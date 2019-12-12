---
title: Understanding and Using Common Similarity Measures
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

Statistical measures of similarity allow scholars to think computationally about how alike or different their objects of studies may be, and these measures are the building blocks of many other clustering and classification techniques. This tutorial will talk through the advantages and disadvantages of three of the most common distance measures: city block or "Manhattan" distance, Euclidean distance, and cosine distance. It will also show you how to calculate these distances using the SciPy library in Python.

# Preparation

## Suggested Prior Skills

Though this lesson is primarily geared toward understanding the underlying principles of these calculations, it does assume some familiarity with the Python programming language. Code for this tutorial is written in Python3.6 and uses the Pandas (v0.25.3) and SciPy (v1.3.3) libraries to calculate distances, though it's possible to calculate these same distances using other libraries and other programming languages. I recommend you work through some of [the *Programming Historian* Python lessons](https://programminghistorian.org/en/lessons/introduction-and-installation) if you are not already familiar with Python.

## Installation and Setup

You will need to install Python3 as well as the SciPy and Pandas libraries. The easiest way to do this is through the [Anaconda Distribution](https://www.anaconda.com/distribution/), which includes both SciPy and Pandas. For more information about installing Anaconda, see the [full documentation](https://docs.anaconda.com/anaconda/).

## Lesson Dataset

You can run these distance measures on almost any data set that uses numerical features to describe specific data samples (more on that in a moment). For the purposes of this tutorial, you will use the results of a [TF-IDF analysis](https://programminghistorian.org/en/lessons/analyzing-documents-with-tfidf) that I ran on a selection of 143 texts from the [*EarlyPrint* project](https://earlyprint.org/), a project (of which I am a collaborator) that has linguistically-annotated and corrected [EEBO-TCP](https://earlyprint.org/intros/intro-to-eebo-tcp.html) texts. TF-IDF, which stands for Term Frequency–Inverse Document Frequency, is a weighting system that assigns a value to every word in a text based on the relationship between the number of times a word appears in that text (its term frequency) and the number of texts it appears in through the whole corpus (its document frequency). It is often used as an initial heuristic for a word's distinctiveness and can give the researcher more information than a simple word count.

Begin by [downloading the CSV file of TF-IDF results](assets/common-similarity-measures/1666_tfidf.csv). You can see the step-by-step instructions for how I created these results in [a tutorial on the *EarlyPrint* site](https://earlyprint.org/notebooks/tf_idf.html). To understand exactly what TF-IDF is and what calculating it entails, see Matthew J. Lavin's [Analyzing Documents with TF-IDF](https://programminghistorian.org/en/lessons/analyzing-documents-with-tfidf).

# What is Similarity or Distance?

## Samples and Features

We'll begin with an example. Let's say you have two texts, the first sentences of Jane Austen's *Pride and Prejudice* and of Edith Wharton's *Ethan Frome*, respectively. You can label your two texts `austen` and `wharton`. In Python, they would look like this:

```py
austen = "It is a truth universally acknowledged, that a single man in possession of a good fortune must be in want of a wife."

wharton = "I had the story, bit by bit, from various people, and, as generally happens in such cases, each time it was a different story. "
```

So `austen` and `wharton` are your two data **samples**, the units of information about which you'd like to know more. These two samples have lots of **features**, attributes of the data samples that we can measure and represent numerically. The number of words in each sentence could be one feature; the number of characters could be another. So could the number of nouns in each sentence, if you chose to measure that, or the frequency of certain vowel sounds. The features you choose will depend on the nature of your research question.

The text example is a helpful illustration, but it's important to remember that these are abstract categories. Samples and features could be anything. A sample could be a bird species, for example, and a measured feature of that sample could be average wingspan. You can have as many samples and as many features as you want: though you'd ultimately come up against limits in computing power, the mathematical principles will work regardless of the number of features and samples you are dealing with.

Returning to the Austen and Wharton example, you can use individual wordcounts as features. Consider the frequencies of the word "a" and the word "in" in your two samples. You could construct a chart of the counts like so:

|  | a | in |
| --------- | --------- | --------- |
| austen | 4 | 2 |
| wharton | 1 | 1 |

Later, you'll use the TF-IDF data set mentioned in the previous section, and like this very small sample data set, the TF-IDF data includes columns (features) that are individual words and rows (samples) for specific texts. The main differences are that the values refer to TF-IDF results (which are extrapolations from the raw term frequency used above) and that there are columns for every single word in the corpus. As you're about to see, despite these differences, distance measures are available via the same calculations. Here's a glimpse of what those samples and features will look like:

{% include figure.html filename="tfidf_sample.png" caption="A screenshot of the sample TF-IDF data set." %}

## The Cartesian Coordinate System

Once you've chosen samples and measured some features of those samples, you can represent that data in a wide variety of ways. One of the oldest and most common is the [Cartesian coordinate system](https://en.wikipedia.org/wiki/Cartesian_coordinate_system), which you may remember from algebra and geometry. This system allows you to represent numerical features as *coordinates*, typically in 2-dimensional space. The data table above could be represented like this:

{% include figure.html filename="datapoints.jpg" caption="'austen' and 'wharton' samples represented as data points." %}

On this graph, our `austen` and `wharton` samples are each represented as **data points** along two **axes** or **dimensions**. The horizontal x-axis represents the values for the word "in" and the vertical y-axis represents the values for the word "a." Though it may look simple, this representation allows us to imagine a *spatial relationship* between **data points** based on their **features**, and this spatial relationship, what we're calling similarity or distance, can tell you something about which **samples** are alike.

Here's where it gets cool. You can represent two **features** as two **dimensions** and visualize your **samples** using the Cartesian coordinate system. Naturally you could also visualize our samples in three dimensions if you had three features. If you had four or more features, you couldn't *visualize* the samples anymore: for how could you create a four-dimensional graph? But it doesn't matter, because **no matter how many features or dimensions you have, you can still calculate distance in the same way**. If you're working with word frequencies, as we are here, you can have as many **features**/**dimensions** as you do words in a text. From here forward, the examples of distance measures will use two dimensions, but when you calculate distance with Python later in this tutorial, you'll calculate over thousands of dimensions using the same equations.

## Distance and Similarity

Now you've taken your **samples** and rendered them as points in space. As a way of understanding how these two points are related to each other, you might ask: how far apart or close together are these two points? The answer to how "how far apart are these points" is their **distance**, and the answer to "how close together are these points" is their **similarity**.

It may seem redundant to use both terms, and indeed these concepts are usually reciprocally related (i.e. distance is merely the opposite of similarity and vice versa). But I bring them both up for a simple reason: out in the world you are likely to encounter both terms, and you would do well not to mix them up. When you are measuring by distance, **the most closely related points will have the lowest distance**, but when you are measuring by similarity, **the most closely related points will have the highest similarity**. For the most part you will encounter distance rather than similarity, but I hope you will remember this caution if you encounter a program or algorithm that outputs similarity instead. (And see the Cosine Distance/Similarity section for more on this distinction.)

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

And that's it! City block distance is useful because it employs simple arithmetic. You could add a third coordinate, call it "z," or as many additional dimensions as you like for each point, and still calculate city block distance fairly easily.

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

But note that you're dealing with **similarity** here and not **distance**. The highest value, one, is reserved for the two points that are *most* close together, while the lowest value, zero, is reserved for the two points that are the *least* close together. This is the exact opposite of **Euclidean distance**, in which the lowest values describe the points *closest* together. To remedy this confusion, most programming environments calculate **cosine distance** by simply subtracting the **cosine similarity** from one. So **cosine distance** is simply $$1 - cos(\theta)$$. In your example, the **cosine distance** would be:

$$1 - 0.95 = 0.05$$

This low **cosine distance** is more easily comparable to the **Euclidean distance** you calculated above, but it tells you the same thing as the **cosine similarity** result above: that the `austen` and `wharton` samples, when represented only by the number of times they each use the words "a" and "in," are fairly similar to one another.

# How To Know Which Distance Measure To Use

These measures aren't at all the same thing, and they yield quite different results. Yet they're all types of **distance**, ways of describing the relationship between two data samples. This illustrates the fact that, even at a very basic level, the decisions you make as an investigator can have an outsized effect on your results.

In this case, the decision you must make is: "How do I measure the relationship between two points?" The answer to that question depends on the nature of the data you start with and on what you're trying to find out.

As you saw in the previous section, **city block distance** and **Euclidean distance** are similar because they are both concerned with the lengths of lines between two points. This makes them more interchangeable. In most cases, **Euclidean distance** will be preferable over **city block** because it is more direct in its measurement of a straight line between two points.

**Cosine distance** is another story. The choice between **Euclidean** and **cosine** distance is an important one, particularly for those of you who are working with data derived from text. I've already illustrated that **cosine distance** is only concerned with the orientation of two points and not with their exact placement. This means that **cosine distance** is much less effected by **magnitude**, or how large your numbers are.

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

Now that you understand city block, Euclidean, and cosine distance, you're ready to calculate these measures using Python. As your example data, you'll use the [pre-calculated TF-IDF results](assets/common-similarity-measures/1666_tfidf.csv) that were created in the [*EarlyPrint* TF-IDF tutorial](https://earlyprint.org/notebooks/tf_idf.html). If you need a refresher on TF-IDF, refer to Lavin's [Programming Historian tutorial](https://programminghistorian.org/en/lessons/analyzing-documents-with-tfidf) on the topic.

To begin, you'll need to import the Pandas and SciPy libraries that you acquired in the Setup and Installation section above. Create a new blank file in your text editor of choice, and name it `similarity.py`. (You can also download my [complete version of this script](assets/common-similarity-measures/similarity.py).) At the top of the file type:

```py
import pandas as pd
from scipy.spatial.distance import pdist, squareform
```

The first thing you'll want to do is open the CSV as a Pandas DataFrame object. (The `1666_tfidf.csv` file will need to be in the same folder as `similarity.py` for this to work.) On the next line of your file, type:

```py
tfidf_results = pd.read_csv('1666_tfidf.csv', index_col=0)
```

This part may take a few minutes, since the CSV is very large. It has a column for every word that appears in these texts: that's almost 175,000 columns! You need to add `index_col=0` so that Pandas knows to treat the farthest left column as the filename indices and not as separate values.

Once you've loaded your data into a DataFrame, you're ready to begin calculating distances. This comprises two steps: first you calculate the distances, and then you must expand the results into a "squareform" matrix so that they're easier to read and process.[^4] The distance function in SciPy is called `pdist` and the squareform function is called `squareform`. **Euclidean distance** is the default output of `pdist`, so you'll use that one first. To calculate distances you simply call the `pdist` function on your DataFrame by typing `pdist(tfidf_results)`. To get the squareform results, you can wrap that entire thing in the `squareform` results: `squareform(pdist(tfidf_results))`. And to make this more readable, you'll want to put it all into a new DataFrame. On the next line of your file, type:

```py
euclidean_distances = pd.DataFrame(squareform(pdist(tfidf_results)), index=tfidf_results.index, columns=tfidf_results.index)
print(euclidean_distances)
```

You need to declare, as you can see above, that the `index` variable for the rows and the `column` variable will both be the same as the index of the original DataFrame. Stop now, save this file, and run it from the command line by navigating to the appropriate directory in your Terminal application and typing `python3 similarity.py`. The script will print a matrix of the **Euclidean distances** between every text in the dataset!

In this "matrix," which is really just a table of numbers, the rows and columns are the same. Each row represents a single XML document from *EarlyPrint*, and the columns represent exactly the same documents. The value in every cell is the distance between the text from that row and the text from that column. That's why there will be a diagonal line of zeroes through the center of your matrix: where every text is compared to itself, the distance value is zero.

*EarlyPrint* XML documents are corrected and annotated versions of XML documents from [the Early English Books Online–Text Creation Partnership](https://earlyprint.org/intros/intro-to-eebo-tcp.html), which includes a document for almost every book printed in England between 1473 and 1700. This sample dataset includes all the texts published in 1666—the ones that are currently publically available (the rest will be available after January 2020). What the matrix is showing you, then, is the relationships among books printed in England in 1666. This includes texts from a variety of different genres on all sorts of topics: religious texts and political treatises and literary works, to name a few. One thing a researcher might want to know right away with a text corpus as thematically diverse as this one is: is there a computational way to determine the kinds of similarity that a reader cares about? When you calculate the distances among two scientific texts and a philosophical tract, will the results "make sense" to an expert reader? You'll try to answer that question in the exercise that follows.

There's a lot you could do with this table of distances beyond simply sorting it in the way you will do here. You could use it as an input for an unsupervised clustering of the texts into groups, and you could use the same measures to drive a machine learning model. If you wanted to simply understand these results better, you could create a heatmap of this table itself, either in Python or by exporting this table as a CSV and visualizing it elsewhere.

As an example, let's take a look at the five texts most similar to Margaret Cavendish's *Observations upon Experimental Philosophy*, published together with *The Blazing World*, which is part of this dataset under the ID number `A53049`. The first part of this book is a scientific treatise, and the second part is a literary text, a proto–science fiction work. By comparing distances, you might hope to find books that are either thematically or structurally similar to Cavendish's: either scientific and literary texts (rather than religious works, for instance) or texts that are similarly split into two long, prose sections (rather than poetry collections, for instance).

Let's see what texts **Euclidean distance** says are similar to Cavendish's book. You can do this using Pandas's `nsmallest` function. Remove the line that says `print(euclidean_distances)`, and in its place type:

```py
print(euclidean_distances.nsmallest(6, 'A53049')['A53049'])
```

Why six instead of five? Because this is a symmetrical, "square" matrix, one of the possible results is always the same text. Since we know that any text's distance to itself is zero, it will certainly come up in our results. We need five more in addition to that one, so six total.

The results you get should look like this:

```
A53049      0.000000
A56381    543.547256
A39714    544.688434
A42820    545.438972
A67572    549.532687
A67762    549.972655
```

Your results will only contain the Text Creation Partnership ID numbers, but here are the titles that correspond to the five texts listed:

>"An account of the nature and extent of the divine dominion & goodnesse especially as they refer to the Origenian hypothesis concerning the preexistence of souls together with a special account of the vanity and groundlesness of the hypothesis it self : being a second letter written to his much honoured friend and kinsman, Mr. Nath. Bisbie / by Sam. Parker ..."
>
>"A farrago of several pieces being a supplement to his poems, characters, heroick pourtraits, letters, and other discourses formerly published by him / newly written by Richard Flecknoe."
>
>"A philosophical endeavour towards the defence of the being of vvitches and apparitions. In a letter to the much honoured, Robert Hunt, esq; by a member of the Royal Society."
>
>"A sermon preached before the peers, in the abby-church at Westminster October 10, MDCLXVI / by Seth Lord Bishop of Exon."
>
>"No wicked man a wise man, true wisdom described the excellency of spiritual, experimental, and saving knowledge, above all humane wisdom and learning ... / by R. Younge ..."

There doesn't seem to be a lot that connects these texts to Cavendish's scientific treatise and prose fiction work. Rather than concluding that TF-IDF scores cannot tell you anything about the relation between printed books in the year 1666, you would do better to first try some different distance measures.

You can do this in exactly the way you calculated **Euclidean distance**, but with a parameter that specifies the type of distance you want to use. On the next lines of your file, type:

```py
cityblock_distances = pd.DataFrame(squareform(pdist(tfidf_results, metric='cityblock')), index=tfidf_results.index, columns=tfidf_results.index)

print(cityblock_distances.nsmallest(6, 'A53049')['A53049'])
```

When you run the script this time, it will calculate the six nearest texts by **Euclidean distance** again, followed by the six nearest texts by **city block distance**. The results for **city block distance** will be:

```
A53049        0.000000
A61600    40079.849963
A64258    40090.040148
A23770    40097.627167
A35851    40110.045217
A54070    40127.751571
```

You'll notice that these results are completely different from the ones before, simply because **city block distance** measures differently. The titles of these five texts are:

>"A sermon preached before the honourable House of Commons at St. Margarets Westminster, Octob. 10, 1666 being the fast-day appointed for the late dreadfull fire in the city of London / by Edward Stillingfleet ..."
>
>"A loving exhortation to all kings, princes, potentates, bishops and people in the whole Christendom wherein is a distinction betwixt the true and false teachers ... / written by Thomas Taylor."
>
>"A sermon preach'd before the King, Decemb. 31, 1665, at Christ-Church in Oxford by R. Allestree ..."
>
>"The word of the Lord to his church and holy assembly regenerated and born again of the righteous seed, which the Lord hath blessed : to whom this is sent to be carefully and distinctly read, in the fear of the Lord, when they are met together, in the light of the convenant of the most high God."
>
>"To friends in England, Ireland, Scotland, Holland, New-England, Barbado's, or any where else where the Lord God shall order this to come, in the tender spirit of life and love, greeting"

At first glance, this doesn't look much better than **Euclidean distance**. A few of the texts are religious in nature, but a very large proportion of *EarlyPrint* texts involve the topic of religion. Your next step is to see if **cosine distance** is any better than these other two.

On the next line of your file, type:

```py
cosine_distances = pd.DataFrame(squareform(pdist(tfidf_results, metric='cosine')), index=tfidf_results.index, columns=tfidf_results.index)

print(cosine_distances.nsmallest(6, 'A53049')['A53049'])
```

The script will now output the top six texts for all three distance measures. The results for **cosine distance** should look like this:

```
A53049    0.000000
A29017    0.571785
A28171    0.604471
A57484    0.621786
A60482    0.636766
A56381    0.638818
```

Right away you'll notice a big difference. Because **cosine distances** are scaled from 0 to 1 (see the previous section for an explanation of why this is the case), we can tell not only what the closest samples are, but *how* close they are.[^5] All of the closest 5 texts have a cosine distance greater than 0.5, which means none of them are all *that* close to Cavendish's text. This is helpful to know and puts some of the previous results into context. It may be that there aren't many books that are similar to Cavendish's published in 1666, at least in terms of the TF-IDF scores for interesting words. As a next step, you may want to choose different features to get a better sense of text similarity.

In the meantime, the titles of the texts that **cosine distance** identified are:

>"The origine of formes and qualities, (according to the corpuscular philosophy) illustrated by considerations and experiments (written formerly by way of notes upon an essay about nitre) by ... Robert Boyle ..."
>
>"The common principiles of Christian religion clearly proved and singularly improved, or, A practical catechism wherein some of the most concerning-foundations of our faith are solidely laid down, and that doctrine, which is according to godliness, sweetly, yet pungently pressed home and most satisfyingly handled / by that worthy and faithful servant of Jesus Christ, Mr. Hew Binning ..."
>
>"The history of the Caribby-islands, viz, Barbados, St Christophers, St Vincents, Martinico, Dominico, Barbouthos, Monserrat, Mevis, Antego, &c in all XXVIII in two books : the first containing the natural, the second, the moral history of those islands : illustrated with several pieces of sculpture representing the most considerable rarities therein described : with a Caribbian vocabulary / rendred into English by John Davies ..."
>
>"Gerochomia vasilike King Solomons portraiture of old age : wherein is contained a sacred anatomy both of soul and body, and a perfect account of the infirmities of age, incident to them both : and all those mystical and ænigmatical symptomes expressed in the six former verses of the 12th chapter of Ecclesiastes, are here paraphrased upon and made plain and easie to a mean capacity / by John Smith ..."
>
>"An account of the nature and extent of the divine dominion & goodnesse especially as they refer to the Origenian hypothesis concerning the preexistence of souls together with a special account of the vanity and groundlesness of the hypothesis it self : being a second letter written to his much honoured friend and kinsman, Mr. Nath. Bisbie / by Sam. Parker ..."

With the caveat that we already know that none of these texts are *too* close to Cavendish's, this does seem like a more uniform set. Though some of the main topics are far-reaching, each of these texts takes the form of a treatise or detailed description, with philosophical and moral reflections, accounts of distant places, and interests in the soul and the body. As you might expect, because **cosine distance** is more focused on comparing the proportions of features within individual samples, its results were slightly better for this text corpus (even if limiting the corpus to a single year gave you less-than-ideal results).

Finally, you might notice that the fifth text listed by **cosine distance** is the first text listed by **Euclidean distance**. This suggests that while not the ideal distance measure in this case, **Euclidean distance** was on the right track, even if it didn't capture all the similarity you were looking for.

It's crucial to note that this exploratory investigation into text similarity didn't give you a lot of definitive answers. Instead it raises many interesting questions. Which words (features) caused these specific books (samples) to manifest as similar to one another? What does it mean to say that two texts are "similar" according to TF-IDF scores rather than raw word counts or some other feature set? What else can we learn about the texts that appeared in proximity to Cavendish's? Like many computational methods, distance measures provide you with a way to ask new and interesting questions of your data, and initial results like these can lead you down new research paths.

# Next Steps

I hope this tutorial gave you a more concrete understanding of basic distance measures as well as a handle on when to choose one over the other. In the future you may be using these measures in the same way you did above: to look at the most similar samples in a large data set. But it's even more likely that you'll encounter distance measures as a near-invisible part of a larger data mining approach. For example, [**k-means clustering**](https://en.wikipedia.org/wiki/K-means_clustering) uses **Euclidean distance** by default to determine groups or clusters in a large dataset. Understanding the pros and cons of distance measures could help you to better understand and use a method like **k-means clustering**. Or perhaps more importantly, a good foundation in understanding distance measures might help you to assess and evaluate someone else's digital work more accurately.

Distance measures are a good first step to investigating your data, but a choice between the three different metrics described above---or the many other available distance measures---is never neutral. Understanding the advantages and trade-offs of each can make you a more insightful researcher and help you better understand your data.

[^1]: I rounded this result to the nearest hundredth place to make it more readable.

[^2]: A similarity lower than 0 is indeed possible. If you move to another quadrant of the graph, two points could have a 180 degree orientation, and then their cosine similarity would be -1. But because you can't have negative wordcounts (our basis for this entire exercise), you'll never have a point outside this quadrant.

[^3]: Once again, I've done some rounding in the final two steps to make this operation more readable.

[^4]: SciPy's `pdist` function outputs what's called a "sparse matrix" to save space and processing power. This is fine if you're using this as part of a pipeline for another purpose, but we want the "squareform" matrix so that we can see all the results. It's called "squareform" because the columns and rows are the same, so the matrix is symmetrical, or square.

[^5]: It's certainly possible to scale the results of Euclidean or city block distance as well, but it's not done by default.
