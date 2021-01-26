---
title: K-Means Clustering with Scikit-Learn in Python
collection: lessons
layout: lesson
slug: k-means-clustering-with-scikit-learn-in-python
date: 2021-01-26
translation_date: LEAVE BLANK
mathjax: true
authors:
- Thomas Jurczyk
reviewers:
- LEAVE BLANK
editors:
- Alex Wermer-Colan
translation-editor:
- LEAVE BLANK
translation-reviewer:
- LEAVE BLANK
review-ticket: LEAVE BLANK
difficulty: LEAVE BLANK
activity: LEAVE BLANK
topics: LEAVE BLANK
abstract: LEAVE BLANK
---

{% include toc.html %}

# Introduction
This tutorial demonstrates how to apply k-means clustering in Python. K-Means is a popular clustering algorithm used to discover (hidden) structures in your data by revealing groups with similar features (see Patel 2019). We will implement the k-means algorithm with [scikit-learn](https://scikit-learn.org/stable/index.html), a widely used and well-documented machine learning library in Python. Also, scikit-learn has a huge community and offers smooth implementations of various machine learning algorithms. Once you have understood how to implement k-means with scikit-learn, you can easily use this knowledge to implement other machine learning algorithms with scikit-learn, too.

As an exemplary use case of k-means, we will work with a dataset including all the 1,611 contributors to [*Brill's New Pauly*](https://referenceworks.brillonline.com/browse/brill-s-new-pauly) (short DNP) listed on the official website. *Der Neue Pauly: Realenzyklopädie der Antike* (in English *Brill's New Pauly*) (1996–2002) is a well-known encyclopedia of the ancient world with contributions from influential international scholars. The original German version of the DNP has been translated into English (starting in 2002). *Brill's New Pauly*  is a successor of the famous German *Paulys Realencyclopädie der classischen Altertumswissenschaft* (1890–1980). The [online version of *Brill's New Pauly*](https://referenceworks.brillonline.com/browse/der-neue-pauly) is published by Brill and the print version by Metzler. The supplementary volumes have not been considered in this dataset. *Brill's New Pauly* is introduced on the official website as follows (see the links above):

> Brill´s New Pauly presents the current state of traditional and new areas of research and brings together specialist knowledge from leading scholars from all over the world.

The author data was collected from the official website using Python modules and libraries such as [requests](https://requests.readthedocs.io/en/master/), [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/), and [pandas](https://pandas.pydata.org/)[^1] and stored in a csv file named `DNP_authors.csv`. The dataset does neither quote nor reproduce any actual content from *Brill's New Pauly*.

You can download the dataset as well as a Jupyter notebook with the code we are writing in this tutorial from [my GitHub repository](https://github.com/thomjur/introduction_to_k-means_clustering_PH). Every single row in the `DNP_authors.csv` dataset contains an author name as an index and observations of the following three features (variables) for each author:

* The number of articles the authors contributed to.
* The approximate amount of text the authors wrote in the *DNP*.
* The location the authors were based when the DNP was published. 

Consequently, a single row of our dataset looks like this:

| author | articles | word_count | based_in |
|:-------|:--------:|:-------------:|:-----:|
|Fuhlow, Piotr| 2 | 24300 | Heidelberg |

This tutorial will demonstrate how k-means clustering can help us identify specific groups of authors in our data. In our *DNP* dataset, the k-means algorithm will try to build groups of authors that have contributed approximately the same number of articles and words to the encyclopedia. Thus, we will focus on two of the three features.

Looking and potential author clusters in our data can help us to measure individual scholars' impact on the establishment of authoritative knowledge in specific knowledge domains (such as ancient history). For instance, the existence of distinctive clusters of scholars divided into a majority that only contributed one or two articles and very few "power-contributors" could hint at a certain disbalance in the knowledge production.

# Prerequisites
To follow this tutorial, you should have some basic programming knowledge (preferably Python) and be familiar with central Python libraries, such as *pandas* or *matplotlib* (or their equivalents in other programming languages). I also assume that you have some basic knowledge of descriptive statistics. For instance, you should know what mean, standard deviation, and categorical/continuous variables are. If you don't, I will provide links for further reading or explanations on Wikipedia and other sources.

# Why K-Means Clustering?
You can choose between several clustering algorithms to analyze your data, such as k-means, [hierarchical clustering](https://stackabuse.com/hierarchical-clustering-with-python-and-scikit-learn/), and [DBSCAN](https://www.machinecurve.com/index.php/2020/12/09/performing-dbscan-clustering-with-python-and-scikit-learn/). We are using k-means clustering in this tutorial since it is a relatively easy to understand clustering algorithm with a fast runtime speed that still delivers decent results,[^2] making k-means an excellent model to start with. 

However, implementing other clustering algorithms can be pretty easy once you are familiar with the overall workflow of scikit-learn. Thus, if you decide to analyze your data with additional clustering algorithms, you can easily do so after finishing this tutorial. In general, it is often advisable to apply more than one clustering algorithm to get different perspectives on your data and to evaluate the results of each model.

## What is Clustering?
Clustering is part of the larger field of machine learning. Machine learning is the programming of a computer to learn from data without being explicitly programmed (see Géron 2019, 2). The field of machine learning can be separated into supervised, unsupervised, and reinforcement learning (see Géron 2019, 7-17).

**Supervised machine learning** uses labeled data to train machine learning algorithms to make accurate predictions for new data. A good example is a spam filter. You can train a supervised machine learning spam filter with a training set of emails that have manually been labeled as either "spam" or "not-spam." "Training" in this context means that the supervised machine learning spam filter tries to form a prediction model based on the labeled data. Once the supervised model has finished learning the patterns it found in the labeled data, it should ideally be able to accurately classify new and unlabeled data (in our example: labeling new emails as either "spam" or "not-spam"). One way to evaluate a supervised machine learning model's accuracy is to predict already labeled data and compare the machine learning model's output with the original labels. Among others, the model's accuracy depends on the amount and quality of the labeled data it has been trained on and its parameters (hyperparameter tuning). Thus, building a decent machine learning model involves a continuous loop of training, testing, and fine-tuning of the model's parameters. Common examples of supervised machine learning classifiers are k-nearest neighbors (KNN) and logistic regression.

**Unsupervised learning** mostly works with unlabeled data. Among others, unsupervised learning is used for anomaly detection, dimensionality reduction, and clustering. When applying unsupervised machine learning algorithms, we do not feed your model with prelabeled data to make predictions for new data. Instead, we want the model to look for potential structures in our data. A good example is the dataset in our tutorial: We are only passing our model the author table with the selected features, and we expect the model to show us where (potential) structures exist; in this case, we expect it to discover groups of authors that have written similar amounts of text and contributed approximately the same number of articles to the encyclopedia. 

**Reinforcement learning** is less important for us as humanities' scholars. Reinforcement learning consists of setting up an agent (for instance, a robot) that performs actions and is either rewarded or punished for their execution. The agent learns how to react to its environment based on the feedback it received from its former actions.

## How does Clustering work?

Since clustering algorithms belong to the field of unsupervised learning, they are usually applied when you are confronted with unlabeled and ideally unknown data, and you want your clustering algorithm to look for potential patterns (clusters) in that data. As explained in the section on unsupervised learning above, this is the case with our `DNP_authors.csv` dataset, which makes it a good example to explain how clustering generally works.

For example, let's have a look at a snippet from our `DNP_authors.csv` dataset that only shows the author names together with the number of articles they have contributed to:

|author|articles|
|:---|:----:|
|Winkle, Christian|11|
|Krebs, Christopher|3|
|Rathmann, Michael|13|
|Lammel, Hans Uwe|2|

Intuitively, one would assume that rows one and three, as well as two and four, belong together. And indeed, a clustering algorithm such as k-means proposes exactly these clusters A and B: 

|author|articles|clusters|
|:---|:----:|:----:|
|Winkle, Christian|11|A|
|Krebs, Christopher|3|B|
|Rathmann, Michael|13|A|
|Lammel, Hans Uwe|2|B|

Of course, this example is somewhat underwhelming, but imagine that you have a dataset with millions of entries and various features (articles, word counts, geographical location, age, titles, gender, home university, etc.). In this case, looking for potential clusters in the data based on multiple features will quickly become a tedious or even impossible task for an individual researcher.

# How Does K-Means Work?
The following overview of the k-means algorithm focuses on the so-called naive k-means clustering, meaning that the cluster centers (so-called *centroids*) are randomly initialized. However, the [scikit-learn implementation of k-means](https://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html) applied in this tutorial already includes many improvements to the original algorithm. For instance, instead of randomly distributing the initial cluster centers (*centroids*), the scikit-learn model uses a different approach called [k-means++](http://ilpubs.stanford.edu:8090/778/1/2006-13.pdf), which is a smarter way to distribute the initial *centroids*. However, the way *k-means++* works is beyond the scope of this tutorial, and I recommend to look at the link to the [Stanford paper](http://ilpubs.stanford.edu:8090/778/1/2006-13.pdf) by David Arthur and Sergei Vassilvitskii if you want to learn more about *k-means++*.

## The K-Means Algorithm
To explain how k-means works, let us go back to the snippet from our dataset.

|author|articles|
|:---|:----:|
|Winkle, Christian|11|
|Krebs, Christopher|3|
|Rathmann, Michael|13|
|Lammel, Hans Uwe|2|

To start with our k-means clustering, we first need to define the number of clusters we want to find in our data. Since you mostly don't know how many clusters exist in your data, choosing the appropriate initial number of clusters is already a tricky question. We we will come back to this problem, but let us first see how k-means generally functions. 

In our example, let us assume that we are looking for two clusters. The naive k-means algorithm will now initialize our model with two randomly distributed cluster centers. Since our data has only one dimension, let us assume that the cluster centers are initialized at positions 5 (centroid a) and 16 (centroid b). 

The main algorithm consists of two steps. The first step is to measure the distances between every data point and the current cluster centers (in our case, via [Euclidean distance](https://en.wikipedia.org/wiki/Euclidean_distance)). Since we are only working in a one-dimensional space ins this example, this comes down to the measurement of \\( \lvert \mathbf{p}-\mathbf{c} \rvert \\), where \\( \mathbf{p} \\) is the cluster center and \\( \mathbf{c} \\) a data point. After measuring the distances between each data point and the cluster centers, every data point is assigned to its nearest cluster center. Thus, in our example, entries one and three in the table are assigned to centroid b, and entries two and four to centroid a.

The second step consists of creating new cluster centers by calculating the [mean](https://en.wikipedia.org/wiki/Mean) of all the data points assigned to each cluster. Thus, the new cluster centers for the data points in our dataset would be located at position 12 (cluster a) and position 2.5 (cluster b).

After creating the new cluster centers, the algorithm starts again with the data points' reassignment to the newly created centroids. The algorithm stops once the centroids are more or less stable. In our example, this is already the case after the first iteration. The [Wikipedia entry on k-means clustering](https://en.wikipedia.org/wiki/K-means_clustering) provides helpful visualizations of this two-step process.

## How Many Clusters Should I Choose?
As indicated above, the question of how many cluster centers to choose is a tricky one. Usually, there is no one-size-fits-all solution to this problem. Yet, specific performance measures might help to select the right k value for your data. A good example that we will be using in this tutorial is the so-called "elbow method." The "elbow method" is based on measuring the inertia of the clusters for each k. In this context, inertia is defined as:

> Sum of squared distances of samples to their closest cluster center.[^3]

The inertia decreases with the number of clusters to the extreme that the inertia is zero when k is equal to the number of data points. But how could this help us find the right amount of clusters?  In an ideal world, you would expect the inertia to decrease more slowly from a certain k onwards, so that a (fictional) plot of the inertia/cluster relation would look like in Figure 1.

{% include figure.html filename="clustering-scikit-learn1.png" caption="Figure 1: Fictional example of inertia for k clusters." %}

In this plot, the "elbow" is found at four clusters, meaning that four clusters might be a reasonable trade-off between relatively low inertia (meaning the data points assigned to the clusters are not too far away from the centroids) and as few clusters as possible. Again, this method only provides you with an idea of where to start digging. The final decision is up to you and highly depends on your data and your research question. Figuring out the right amount of clusters should also be accompanied by other steps, such as plotting your data or looking at other statistics. We will see how inertia helps us to discover the right amount of clusters for our `DNP_authors.csv` dataset in the following application of k-means.

Now that we know how k-means generally works, let us apply k-means in the context of our dataset from *Brill's New Pauly*.

# Applying K-Means on the `DNP_authors.csv` Dataset from *Brill's New Pauly*

## Exploratory Data Analysis

Before starting with the clustering, let us first explore the data by loading *DNP_authors.csv* into Python with *pandas*.

```Python
import pandas as pd

# load the dataset that has been stored as .csv files in the same folder
# using the author names as index
df_authors = pd.read_csv("DNP_authors.csv", index_col=0)

# display dataset structure with the pandas .info() method
print(df_authors.info())

# show first 5 rows
print(df_authors.head(5))
```

Next, let us have a closer look at our data through the output of the *pandas* `info()` method.

```
<class 'pandas.core.frame.DataFrame'>
Index: 1611 entries, Eder, Walter (Berlin) to Stausberg, Michael
Data columns (total 3 columns):
 #   Column      Non-Null Count  Dtype 
---  ------      --------------  ----- 
 0   word_count  1611 non-null   int64 
 1   articles    1611 non-null   int64 
 2   based_in    1611 non-null   object
dtypes: int64(2), object(1)
memory usage: 50.3+ KB
```

The *pandas* dataframe `df_authors` includes 1,611 entries. As we can see, only the *word_count* and the *articles* columns include continuous data of type `integer` (that we can easily cast to `float`). In contrast, the other column (*based_in*) is of type `object` and represents a categorical value. Even though machine learning algorithms can handle categorical data[^4] and an integration of a cluster analysis of the author's locations makes sense for the broader research question, we will focus on the clustering of the continuous data in this tutorial for the sake of simplicity.

Let us continue with our analysis and look at the data distribution in the numeric columns with the *pandas* method `describe()`.

```Python
df_authors.describe()
```

The output of `df_authors.describe()` should look like this:

```
          word_count     articles
count    1611.000000  1611.000000
mean    12773.718187    13.015518
std     26277.073866    36.859652
min        12.000000     1.000000
25%      1745.000000     1.000000
50%      4429.000000     2.000000
75%     12209.500000     8.000000
max    433508.000000   557.000000
```

We can see that the standard deviation, as well as the mean values, vary greatly between both columns. When working with metrics such as Euclidean distance in the case of the k-means algorithm, different scales between the columns can become problematic. Thus, we should think about normalizing or standardizing the data before applying the clustering algorithm.

## Applying K-Means with Scikit-Learn
### Standardizing the Data
We apply scikit-learn's [`StandardScaler()`](https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.StandardScaler.html) to cast the mean of the columns to approximately zero and the standard deviation to one to account for the huge differences between the *word_count* and *articles* columns in `df_authors`. Afterwards, we proceed with instantiating k-means clustering with scikit-learn.

First, we need to import the classes and libraries that we want to apply during our analysis.

```Python
# clustering part
from sklearn.preprocessing import StandardScaler as SS
from sklearn.cluster import KMeans

# plotting libraries
import matplotlib.pyplot as plt
import seaborn as sns
```

Next, we initialize both our scaler and our k-means model. We leave the `StandardScaler()` parameters as default; however, we set the k-means `n_cluster` parameter to "3" and the `random_state` parameter to "42." The latter parameter allows us to reproduce our results.

```Python
kmeans = KMeans(n_cluster=3, random_state=42)
scaler = SS()
```  

Let us next standardize the numerical columns in `df_authors`. We are using the `fit_transform()` method of `StandardScaler()` that combines training the scaler (by figuring out the mean and standard deviation of the data) with the transformation of the data (casting mean to zero and standard deviation to one). Yet, we could also do this in two steps by first fitting the data to the model (by calling `fit()`) and then transforming it via `transform()`.

We save the scaled data in separate columns (*wc_scaled* and *articles_scaled*) of our copy of the `df_authors` frame. Note that we copy the original frame `df_authors` to `df_authors_cp` first, which is not necessary but something I like to do to keep an instance of the original data in our program. Finally, we check if everything looks like it should.

```Python
# scale the "word_count" and "articles" columns of df_authors
df_authors_cp = df_authors.copy()
scaled_columns = scaler.fit_transform(df_authors_cp[["word_count", "articles"]])
df_authors_cp["wc_scaled"] = scaled_columns[:,0]
df_authors_cp["articles_scaled"] = scaled_columns[:,1]
df_authors_cp.head(5)
``` 

### Clustering the Data
Now that both columns have approximately the same magnitude, we can finally start with the fun part by clustering our data! Note that we must only pass the standardized numerical columns to the k-means instance! After our k-means object has digested the data, we can save the assigned labels (cluster) in the model's `labels_` attribute in a separate column in our initial frame to check how the k-means algorithm has clustered our data. Voilà, that's all!

```Python
# clustering df_authors_cp
kmeans.fit(df_authors_cp[["wc_scaled", "articles_scaled"]])
df_authors_cp["clusters"] = kmeans.labels_
```

Next, let us plot and inspect the results with the plotting library *seaborn* (see Figure 2).[^5]

```Python
sns.scatterplot(x="articles", y="word_count", hue="clusters", data=df_authors_cp)
```

{% include figure.html filename="clustering-scikit-learn2.png" caption="Figure 2: Three clusters assigned by k-means." %}

That looks interesting. The cluster in the lower left part of the plot, as well as the two outliers in the upper right corner of the plot, are clearly visible. Interestingly, k-means does not regard the two outliers as an individual cluster. Instead, it puts the two outliers together with other data points that one would intuitively assign to the cluster with the number 1. Overall, this plot and the clusters demonstrate that there are, at least, three different clusters of contributors. The first cluster (cluster zero) includes the most data points, meaning that many authors only contributed few articles with a relatively short length. However, some authors (cluster 2) contributed a lot more than most of the others and could thus be regarded as much more influential.

Let us now have a closer look at cluster 2 via boolean indexing with *pandas*. The following command returns the rows of the third cluster (cluster 2), which include the authors with the highest word counts and the most articles.

```Python
df_authors_cp[df_authors_cp["clusters"] == 2]
```

Except for Fritz Graf, all top-contributors were or are still based in Germany, which shows the importance of German universities and scholars for *Brill's New Pauly* and poses the question of how far this encyclopedia represents an international view on ancient Greco-Roman history. Yet, the scholars in this list also point to certain pitfalls in our analysis. For instance, some of the authors in this list only appear in cluster 2 because they were co-authors of very long entries (such as entries that list all the known members of a particular Roman *gens*, including their biographies) to which they only contributed smaller parts. This underlines why automated methods such as clustering should always be interpreted carefully before jumping to any conclusions. 

### Choosing the Right Amount of Clusters (Elbow-Method)
We saw that the integration of the two outliers into cluster 2 seems to be somewhat ambiguous. Thus, let us now check with the help of the "elbow method" (see introduction) whether other cluster numbers might be worth considering in our analysis. In the following code snippet, we use the `KMeans().inertia_` attribute to append the inertia of five k-means objects trained with k cluster numbers between two and six. We then plot the results to look for an "elbow" in our plot.

The results are displayed in Figure 3. For the plotting part, note that the line with `sns.lineplot()` would usually be sufficient to inspect the data (however, do not pass the axes as an argument in this case). Yet, I have added some additional styling to avoid having messy x-ticks and missing ax-labels.

```Python
# elbow method
# preparing data for plotting
cluster_range = list(range(2,7))
inertia_list = []

for k in cluster_range:
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(df_authors_cp[["wc_scaled", "articles_scaled"]])
    inertia_list.append(kmeans.inertia_)

# plotting
fig = plt.figure(figsize=(7,7))
ax = fig.add_subplot(111)
sns.lineplot(y=inertia_list, x=cluster_range, ax=ax)
ax.set_xlabel("Clusters")
ax.set_ylabel("Inertia")
ax.set_xticks([2,3,4,5,6])

```

{% include figure.html filename="clustering-scikit-learn3.png" caption="Figure 3: Inertia for two to six clusters." %}

Our "elbow plot" in Figure 3 suggests four instead of three clusters. Thus, let us try and train another `KMeans()` instance, but this time using four instead of three clusters. The results of this step are displayed in Figure 4. With four clusters, the k-means algorithm has created a separate cluster with the two outliers in the upper right corner, as we expected in our previous evaluation of the k-means object with three clusters. Besides the two outliers, the major part of the data is now split into three clusters, representing a more reasonable grouping of the authors, at least according to the visual impression in the plot.

{% include figure.html filename="clustering-scikit-learn4.png" caption="Figure 4: Four clusters assigned by k-means." %}

## How to Proceed?
We could now continue our analysis by looking at possible geographical clusters in each of the clusters to either validate or falsify our previous hypothesis that German authors are much more present in the DNP compared to international contributors. Furthermore, we could examine which institutions are over- or under-represented in *Brill's New Pauly*.

In addition, we should also include a more critical assessment of the meaningfulness of such an estimation purely based on word counts and article numbers. Maybe some authors only contributed one or two articles but covered very broad and central topics, making them at least as influential as those authors who contributed a lot from a quantitative perspective. Again, answering these questions is beyond this tutorial's scope, but they show how important a critical evaluation of results delivered by machine learning algorithms is.

Lastly, we could add more layers to the clustering. Usually, it is a good idea to implement different clustering algorithms, such as hierarchical clustering and k-means, and to compare their results. Even though we have skipped this part in this tutorial, it should be pretty easy for you to add other algorithms now that you have understood how to work with scikit-learn.[^6] Once you are familiar with the single steps, you could also start creating pipelines and functions, making it much easier to automate the overall process.

# Summary
The examination of the `DNP_authors.csv` dataset provided decent results regarding the clustering of the authors into different groups. Yet, the discussion of the results also showed that there is always room for interpretation. Albeit this general ambiguity when applying machine learning algorithms, our analysis demonstrated that applying the k-means algorithm together with the "elbow method" can be a great addition to the exploratory data analysis. Besides, its results can also help to develop and empirically back up new research questions. In our example, we could see that most of the top-contributors were German or based in Germany, which somewhat questions the international value of *Brill's New Pauly* stated in the introduction on the official website. However, we also saw how fragile an analysis purely based on statistics is, for instance, due to misleading information in the data (high word count as co-author of long entries) and a lack of a critical reflection of the results (influence is not necessarily based on the amount of text a scholar has written).

Albeit these general issues when applying machine learning algorithms in the context of humanities-related research questions, I hope to have shown how easy clustering models can be implemented with Python. You only need to know fundamental Python concepts (such as for-loops) and implement libraries such as seaborn, pandas, and scikit-learn to create a powerful workflow of:

1. data exploration,
2. standardization,
3. applying the clustering algorithm(s),
4. evaluating the results & choosing the right k number,
5. and finally critically discussing the results.

# Bibliography
Géron, Aurélien (2019): Hands-on machine learning with Scikit-Learn, Keras, and TensorFlow. Concepts, tools, and techniques to build intelligent systems. Second edition: O'Reilly.  
Mitchell, Ryan (2018): Web scraping with Python. Collecting more data from the modern web. Second edition. Beijing, Boston, Farnham, Tokyo: Sebastopol; First edition: O'Reilly.  
Patel, Ankur A. (2019): Hands-on unsupervised learning using Python. How to build applied machine learning solutions from unlabeled data. First edition: O'Reilly.  


[^1]: For a good introduction to the use of *requests* and web scraping in general, see the corresponding articles on *The Programming Historian* such as [Introduction to BeautifulSoup](https://programminghistorian.org/en/lessons/intro-to-beautiful-soup) (last accessed: 2021-01-22) or books such as Mitchell 2018.

[^2]: Yet, there are certain cases where k-means clustering might fail to identify the clusters in your data. Thus, it is usually recommended to apply several clustering algorithms. A good illustration of the restrictions of k-means clustering can be seen in the examples under [this link]((https://scikit-learn.org/stable/auto_examples/cluster/plot_kmeans_assumptions.html#sphx-glr-auto-examples-cluster-plot-kmeans-assumptions-py) (last accessed: 2021-01-23)) to the scikit-learn website, particularly in the second plot in the first row.

[^3]: [Definition of inertia on scikit-learn](https://scikit-learn.org/stable/modules/clustering.html#k-means) (last accessed: 2021-01-23).

[^4]: For instance, through *One Hot Encoding*: See [this link to the Wikipedia article](https://en.wikipedia.org/wiki/One-hot) (last accessed: 2021-01-23) for more information.

[^5]: Seaborn is a great looking plotting library based on matplotlib. For more information, see this [link to the official seaborn website](https://seaborn.pydata.org/) (last accessed: 2021-01-23).

[^6]: For example, you could start looking under [this link](https://scikit-learn.org/stable/modules/clustering.html#:~:text=Clustering%20of%20unlabeled%20data%20can%20be%20performed%20with,of%20integer%20labels%20corresponding%20to%20the%20different%20clusters.) (last accessed: 2021-01-23) for more clustering algorithms provided by scikit-learn.
