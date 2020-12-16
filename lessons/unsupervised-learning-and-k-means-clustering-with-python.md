---
title: Unsupervised Learning and K-Means Clustering with Python
collection: lessons
layout: lesson
slug: unsupervised-learning-and-k-means-clustering-with-python
date: BLANK FOR NOW
authors: Thomas Jurczyk
reviewers:
- BLANK FOR NOW
- BLANK FOR NOW
- BLANK FOR NOW
editors:
review-ticket: [LEAVE BLANK]
difficulty: [LEAVE BLANK]
activity: [LEAVE BLANK]
topics: [LEAVE BLANK]
abstract: [LEAVE BLANK]
---

{% include toc.html %}

# Introduction
This article introduces unsupervised learning with k-means, a popular clustering algorithm that will be implemented with scikit-learn (short sklearn) in Python. Clustering is an approach to group objects according to their similarity (see [@Patel.2019]). It helps to find or confirm structures in your data, regardless of whether you are working in science or humanities. In this tutorial, I will apply the k-means clustering algorithm to look for groups of authors in [*Brill's New Pauly*](https://referenceworks.brillonline.com/browse/brill-s-new-pauly), an academic encyclopedia of the ancient world.

## Introducing the case study
The case study in this tutorial is an example of applying clustering algorithms as part of a broader research question. Clustering algorithms can help receive a first impression of (unknown) structures in your data. In this tutorial, we want to find clusters of authors in *Brill's New Pauly* based on the number of entries and the amount of text they wrote. This question is important to measure individual scholars' impact on the establishment of authoritative knowledge in specific knowledge domains (such as ancient history). For instance, do all authors have approximately contributed the same amount of entries and text to the encyclopedia? Or are there distinctive clusters of scholars divided into those who only contributed one or two articles and the "power-contributors" who wrote extensively more?

Even though we will only briefly cover this part in the tutorial, an interesting follow-up question that could also be answered with clustering algorithms is related to potential geographical clusters in *Brill's New Pauly* according to the authors' home universities. How far correlate these geographical clusters with the author clusters based on the number of contributions and the text amount? Combining these examinations might help identify geographical clusters of "power-contributors" and academic institutions that significantly impact the legitimization and establishment of knowledge due to their immense contributions.

Yet, this tutorial's focus lies on developing strategies to apply clustering algorithms and only to a lesser extent on the concrete research question mentioned above. However, by using these algorithms, we will discover that they already contribute significant parts to a potential answer to these questions, although only a more encompassing investigation can provide a final answer. This broader investigation would also need to include other (non-computational) methods, which lies beyond the scope of this tutorial.

## Why k-means clustering?
We are using k-means clustering in this tutorial since it is one of the easier to understand clustering algorithms. This makes it an excellent first model to start our journey into unsupervised learning. Albeit its relatively straightforward approach, k-means works pretty well in many cases. However, if you want to use other clustering algorithms, this tutorial can still be relevant for you. Implementing the algorithms with Python's scikit-learn library allows you to quickly exchange the k-means instance with a different clustering algorithm such as DBSCAN. Consequently, this tutorial provides a workflow in which using the k-means clustering algorithm is only one possible choice. If you want to use a different algorithm instead, simply exchange the parts in the code where we implement the scikit-learn's k-means algorithm with another clustering algorithm.[^1] Besides, it is often advisable to train and test more than one machine learning algorithm to evaluate which one works best. Of course, you can also combine them (which is called ensemble learning). However, to make things easier, we will focus on using k-means in this tutorial.

# Prerequisits
## Python
To follow this tutorial, you should have some basic programming knowledge (preferably Python) and be familiar with central Python libraries, such as *pandas* or *matplotlib* (or their equivalents in other programming languages). Even though I will briefly explain the general ideas behind supervised and unsupervised machine learning, it might be helpful to have some previous knowledge about machine learning, too.[^2] Lastly, I assume that you have some basic statistical knowledge. For instance, you should know what mean, standard deviation, and categorical/continuous variables are. If not, I recommend looking up these terms on [wikipedia.org](https://www.wikipedia.org/) whenever you stumble upon a concept that you do not know, but that seems to be necessary for you to follow this tutorial.

## Unsupervised machine learning (clustering)
Machine learning is the programming of a computer to learn from data without being explicitly programmed (see [@Geron.2019, 2]). Among other classifications, the field of machine learning can be separated into supervised, unsupervised, and reinforcement learning (see [@Geron.2019, 7ff.]). Due to the ongoing hype regarding artificial intelligence (of which machine learning is a subset), one can find an abundance of literature with great introductions to supervised and unsupervised machine learning, the two subfields of machine learning that are most relevant for us as humanities scholars. Given the existing literature, I will only provide short definitions of the terminology essential to understand this tutorial and refer to selected articles and books for detailed explanations.[^3]

**Supervised machine learning** uses labeled data to train machine learning algorithms to make accurate predictions for new data. A good example is a spam filter. You can train a supervised machine learning spam filter with a training set of emails that have manually been labeled as either "spam" or "not-spam." "Training" in this context means that the supervised machine learning spam filter tries to form a prediction model based on the labeled data. Once the supervised model has finished learning the patterns it found in the labeled data, it should ideally be able to accurately classify new and unlabeled data (in our example: labeling emails as either "spam" or "not-spam"). One way to evaluate a supervised machine learning model's accuracy is to predict already labeled data and compare the machine learning model's output with the original labels. Among others, the model's accuracy depends on the amount and quality of the labeled data it has been trained on and its parameters (hyperparameter tuning). Thus, building a decent machine learning model involves a continuous loop of training, testing, and fine-tuning of the model's parameters. Common examples of supervised machine learning classifiers are k-nearest neighbors (KNN) and logistic regression.

**Unsupervised learning** mostly works with unlabeled data. Among others, unsupervised learning is used for anomaly detection, dimensionality reduction, and clustering. In this tutorial, we will focus on clustering. Clustering means that you have (lots of) unlabeled and ideally unknown data, and you want your unsupervised learning clustering instance to look for potential patterns (clusters) in the data. For example, let's say you have the following dataset with unlabeled data:

|Index|Height (m)|
|:---|:----:|
|mount_everest|8848|
|burj_khalifa|828|
|aconcagua|6961|
|shanghai_tower|632|

Intuitively, one would assume that rows 1 and 3, as well as 2 and 4, belong together. And indeed, a clustering algorithm such as k-means proposes exactly these clusters A and B that correspond to "mountains" and "skyscrapers": 

|Index|Height (m)|Cluster|
|:---|:----:|:----:|
|1|8848|A|
|2|828|B|
|3|6961|A|
|4|632|B|

Our clustering algorithm figured out that Mount Everest and the Aconcagua, as well as the Shanghai Tower and the Burj Khalifa, are relatively close to each other regarding their heights, at least when compared with the members of the other group. Of course, this example is somewhat underwhelming, but imagine that you have a dataset with millions of entries and features (height, weight, color, material, geographical location, etc.). In this case, looking for potential clusters in the data might become a tedious or even impossible task for an individual researcher. Under these circumstances, applying a clustering algorithm might be a reasonable approach.

### Different clustering algorithms and general remarks
In order to cluster your data, there are different clustering algorithms that you can apply, such as k-means, hierarchical clustering, DBSCAN, and others. This tutorial focuses on k-means since k-means is one of the easier to understand algorithms that still provides decent results. Before explaining how k-means works and how to apply it in the context of the case study, I would like to make two general comments.

The first comment concerns the choice of machine learning models in both supervised and unsupervised learning contexts. There is a great variety of very complex machine learning and deep learning models out there. Yet, I usually recommend starting with the simpler ones and first try to familiarize yourself with them before continuing with more complex solutions, even if the more complex models might outperform the simpler ones. My question usually is: Where and why am I applying machine learning? Am I trying to develop a cutting-edge natural language model supposed to be *the new thing* in translation studies? Or am I using machine learning models as one tool in my exploratory data analysis? At least for me, the answer is usually b). Thus, I prefer having a vague idea of how the models work to evaluate their results, even if my approach cannot compete with the newest deep learning solutions. Furthermore, applying less complex models does not necessarily mean that you get bad results. Most of the time, the results from simpler models such as k-nearest neighbors, logistic regression, or k-means clustering are more than sufficient to get better insights into your data. 

My second comment concerns the overall approach of unsupervised learning in the humanities. There are undisputably certain contexts such as topic modeling, feature reduction, or several natural language processing (NLP) tasks where unsupervised learning really shines. For example, an excellent article on *The Programming Historian* unter this [LINK](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet) demonstrates the power of topic modeling, which is an approach that also belongs to the field of *unsupervised learning*.[^4]

Yet, I would argue that we in our daily work as humanities scholars usually know our data quite well before even applying clustering algorithms. We are often working with digitized versions of our sources that we already know from other contexts, we manually design the features we are interested in (word counts, geographical locations, etc.), and we also explore our data with other quantitative and qualitative methods. Throughout this data acquisition and cleaning process and the exploratory data analysis, we usually have already gained a decent understanding of our data.

The clustering then serves as one among many other tools that we employ in our exploratory data analysis. Using unsupervised techniques in this context still provides valid and sometimes even unexpected results. Still, it certainly has nothing to do with the idea that we feed a clustering algorithm with new and unlabeled data that we have never seen before. It often either supports or rejects a hypothesis that we already had before clustering the data, or it gives us a hint where to look further.

Furthermore, similar to the training loop described in the context of supervised machine learning classifiers, applying clustering algorithms also demands a continuous recalibration of the model parameters and an evaluation of its results. Thus, the term "unsupervised" is somewhat misleading because you, as a researcher, supervise the model all the time.

# Introduction to K-Means Clustering
Together with hierarchical clustering, k-means clustering is undoubtedly among the most popular clustering algorithms. Therefore, it is often used in introductions to unsupervised machine learning. Among others, its popularity comes from k-means' straightforward approach that is relatively easy to understand, its runtime speed, and the fact that it delivers decent results in many cases.[^5]

The following overview of the k-means algorithm focuses on the so-called "naive k-means clustering." However, the scikit-learn implementation of k-means applied in this tutorial already includes many improvements to the original algorithm. For instance, instead of randomly distributing the initial cluster centers, the scikit-learn model uses a different approach called "k-means++."[^6]

## How does k-means work?
The principal idea behind naive k-means is to start with k initial and randomly distributed cluster centers (so-called centroids) in your data, where k is the number of clusters that have to be chosen by the researcher (see below). The main algorithm consists of two steps. The first step is to calculate the distances between every data point and the current cluster centers (for instance, via Euclidean distance). The second step consists of calculating the new cluster centers.[^7] After the second step, the algorithm starts again with the first step by reassigning the data points to the newly created centroids. The algorithm stops once the centroids are more or less stable. The Wikipedia entry on k-means clustering under this [LINK](https://en.wikipedia.org/wiki/K-means_clustering) (last accessed: 25.11.2020) provides helpful visualizations of this two-step process. 

## How many clusters should I choose?
This is a tricky question, since the number of clusters highly depends on your data and your research question. Thus, there is no one-size-fits-all answer. Yet, specific performance measures might help you select the right k value for your data, for instance the so-called "elbow method" and the silhouette score. We will focus on the "elbow method" in this tutorial. The "elbow method" is based on measuring the inertia of your clusters for each k. Inertia in this context is defined as:

> Sum of squared distances of samples to their closest cluster center.[^8]

The inertia decreases with the number of clusters to the extreme that the inertia is zero when k is equal to the number of data points. But how could this help us find the right amount of clusters?  In an ideal world, you would expect the inertia to decrease more slowly from a certain k onwards so that a (fictional) plot of the inertia/cluster relation would look like in figure \ref{image_1}.

![Fictional example of inertia for k clusters \label{image_1}](elbow_plot.png)

In this plot, the "elbow" is found at four clusters, meaning that four clusters might be a reasonable trade-off between relatively low inertia (meaning the data points assigned to the clusters are not too far away from the centroids) and as few clusters as possible. Again, this method only provides you with an idea of where to start digging. The final decision is up to you and highly depends on your data and your research question. Figuring out the right amount of clusters should also be accompanied by other steps, such as plotting your data or looking at other statistics.

Now that we know how k-means generally works, let us apply k-means in the context of our dataset from *Brill's New Pauly*.

# Applying K-Means on a Dataset from *Brill's New Pauly*

## Introduction of the data: *Brill's New Pauly* (DNP)
Instead of using one of the educational datasets that are usually applied in introductions to machine learning, such as the MNIST dataset[^9] or the IRIS dataset[^10], I have decided to use one of my datasets. The *DNP_authors.csv* data that we will be using is related to the broader research question about the impact of academic institutions and scholars on establishing and legitimizing knowledge in certain academic fields (see the introduction of this tutorial). Choosing one of my datasets provides an example of where clustering might be useful in a historian's everyday work instead of discussing a sample from a completely different domain. Furthermore, it also demonstrates that real-world data is often messy and does not necessarily include the structures or perfect clustering one usually expects as a result from clustering algorithms. Yet, if you want to use more established datasets for your first steps into the world of (unsupervised) machine learning, the UCI Machine Learning Repository[^11] and the Kaggle website[^12] are usually good places to start searching.  

The dataset *DNP_authors.csv* that we will be analyzing in this tutorial is based on the entries in *Der Neue Pauly: Realenzyklopädie der Antike* (in English *Brill's New Pauly*) (1996–2002). *Brill's New Pauly* is, at least in German academia, a well-known encyclopedia of the ancient world with contributions from influential scholars from all over the world. The original German version of the DNP has been translated into English (starting in 2002). *Brill's New Pauly*  is a successor of the famous German *Paulys Realencyclopädie der classischen Altertumswissenschaft* (1890–1980). The online version of *Brill's New Pauly* is published by Brill[^13] and the print version by Metzler. Several supplementary volumes have not been considered in this dataset. *Brill's New Pauly* is introduced on the official website (see the links in the footnotes) as follows:

> Brill´s New Pauly presents the current state of traditional and new areas of research and brings together specialist knowledge from leading scholars from all over the world.

The dataset *DNP_authors.csv* that we are examining here lists the following features that were collected from the official website[^14]:

- the names of all authors who have contributed to the encyclopedia
- the summarized word counts of their articles in *Brill's New Pauly*
- the number of entries that list them as (co-)authors
- the region/city where the authors were based when *Brill's New Pauly* was first published

The data was collected using Python modules and libraries such as *requests*, *BeautifulSoup*, and *pandas*.[^15] It does neither quote nor reproduce any actual content from *Brill's New Pauly*.

You can download the dataset as well as a Jupyter notebook with the code we are writing in this tutorial from my GitHub repository.[^16]

## Exploratory data analysis

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

The *pandas* dataframe `df_authors` includes 1,611 entries. As we can see, only the *word_count* and the *articles* columns include continuous data of type `integer` (that we can easily cast to `float`). In contrast, the other column (*based_in*) is of type `object` and represents a categorical value. Even though machine learning algorithms can handle categorical data[^17] and an integration of a cluster analysis of the author's locations makes sense for the broader research question, we will mostly focus on the clustering of the continuous data in this tutorial. This restriction is necessary since this tutorial should primarily provide a first overview of how clustering works and where you can apply it. Integrating a cluster analysis of categorical values and combining it with the analysis of the continuous values would overload this tutorial, which is focused on how k-means works and where to apply it.

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

Even though it is common practice when working with scikit-learn, we will *not* use a pipeline to chain the single steps of data standardization and model training in this tutorial. Going through the whole process step by step makes it easier to follow along if you have never used scikit-learn before. We will also forego writing a function that wraps everything up. Of course, you are encouraged to do so when writing your code, not least because it makes things much easier if you want to be able to change individual parts in your pipeline (such as the scaler or the clustering algorithm).

## Standardizing the data and applying k-means with scikit-learn
We apply scikit-learn's `StandardScaler()` to cast the mean of the columns to approximately zero and the standard deviation to one to account for the huge differences between the *word_count* and *articles* columns in `df_authors`.[^18] Afterwards, we proceed with instantiating k-means clustering with scikit-learn.

First, we need to import the classes and libraries that we want to apply during our analysis.

```Python
# clustering part
from sklearn.preprocessing import StandardScaler as SS
from sklearn.cluster import KMeans

# plotting libraries
import matplotlib.pyplot as plt
import seaborn as sns
```

Next, we initialize both our scaler and our k-means model. We leave the `StandardScaler()` parameters as default; however, we set the k-means `n_cluster` parameter to "3" and the `random_state` parameter to "42". The latter parameter allows us to reproduce our results.

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

Now that both columns have approximately the same magnitude, we can finally start with the fun part by clustering our data! Note that we must only pass the standardized numerical columns to the k-means instance! After our k-means object has digested the data, we can save the assigned labels (cluster) in the model's `labels_` attribute in a separate column in our initial frame to check how the k-means algorithm has clustered our data. Voilà, that's all!

```Python
# clustering df_authors_cp
kmeans.fit(df_authors_cp[["wc_scaled", "articles_scaled"]])
df_authors_cp["clusters"] = kmeans.labels_
```

Next, let us plot and inspect the results with the plotting library *seaborn* (see figure \ref{image_2}).[^19]

```Python
sns.scatterplot(x="articles", y="word_count", hue="clusters", data=df_authors_cp)
```

![df_authors_cp three clusters assigned by k-means. \label{image_2}](results_1.png)

That looks interesting. The cluster in the lower left part of the plot, as well as the two outliers in the upper right corner of the plot, are clearly visible. Interestingly, k-means does not regard the two outliers as an individual cluster. Instead, it puts the two outliers together with other data points that one would intuitively assign to the cluster with the number 1. Overall, this plot and the clusters demonstrate that there are, at least, three different clusters of contributors. The first cluster (cluster zero) includes the most data points, meaning that many authors only contributed few articles with a relatively short length. However, some authors (cluster 2) contributed a lot more than most of the others and could thus be regarded as much more influential.

Let us now have a closer look at cluster 2 via boolean indexing with *pandas*. The following command returns the rows of the third cluster (cluster 2), which include the authors with the highest word counts and the most articles.

```Python
df_authors_cp[df_authors_cp["clusters"] == 2]
```

Except for Fritz Graf, all top-contributors were or are still based in Germany, which shows the importance of German universities and scholars for *Brill's New Pauly* and poses the question of how far this encyclopedia represents an international view on ancient Greco-Roman history. Yet, the scholars in this list also point to certain pitfalls in our analysis. For instance, some of the authors in this list only appear in cluster 2 because they were co-authors of very long entries (such as entries that list all the known members of a particular Roman *gens*, including their biographies) to which they only contributed smaller parts. This underlines why automated methods such as clustering should always be interpreted carefully before jumping to any conclusions. 

We saw that the integration of the two outliers into cluster 2 seems to be somewhat ambiguous. Thus, let us now check with the help of the "elbow method" (see introduction) whether other cluster numbers might be worth considering in our analysis. In the following code snippet, we use the `KMeans().inertia_` attribute to append the inertia of five k-means objects trained with k cluster numbers between two and six. We then plot the results to look for an "elbow" in our plot.

The results are displayed in figure \ref{image_3}. For the plotting part, note that the line with `sns.lineplot()` would usually be sufficient to inspect the data (however, do not pass the axes as an argument in this case). Yet, I have added some additional styling to avoid having messy x-ticks and missing ax-labels.

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
![Inertia for 2 to 6 clusters \label{image_3}](elbow_plot_authors.png)

Our "elbow plot" in figure \ref{image_3} suggests four instead of three clusters. Thus, let us try and train another `KMeans()` instance, but this time using four instead of three clusters. The results of this step are displayed in figure \ref{image_4}. With four clusters, the k-means algorithm has created a separate cluster with the two outliers in the upper right corner, as we expected in our previous evaluation of the k-means object with three clusters. Besides the two outliers, the major part of the data is now split into three clusters, representing a more reasonable grouping of the authors, at least according to the visual impression in the plot.

![df_authors_cp fours clusters assigned by k-means. \label{image_4}](results_2.png)

We could now continue our analysis by looking at possible geographical clusters in each of the clusters to either validate or falsify our previous hypothesis that German authors are much more present in the DNP compared to international contributors. Furthermore, we could examine which institutions are over- or under-represented in *Brill's New Pauly*. In addition, we would also need to include a more critical assessment of the meaningfulness of such an estimation purely based on word counts and article numbers. Maybe some authors only contributed one or two articles but covered very broad and central topics, making them at least as influential as those authors who contributed a lot from a quantitative perspective. Again, answering these questions is beyond this tutorial's scope, but they show how important a critical evaluation of results delivered by machine learning algorithms is.      

# Summary
The examination of the *DNP_authors.csv* dataset provided decent results regarding the clustering of the authors into different groups. Yet, the discussion of the results also showed that there is always room for interpretation. Albeit this general ambiguity when applying machine learning algorithms, our analysis demonstrated that applying the k-means algorithm together with the "elbow method" can be a great addition to the exploratory data analysis. In addition, its results can also help to develop and empirically back up new research questions. In our example, we could see that most of the top-contributors were German or based in Germany, which somewhat questions the international value of *Brill's New Pauly* stated in the introduction on the official website. However, we also saw how fragile an analysis purely based on statistics is, for instance, due to misleading information in the data (high word count as co-author of long entries) and a lack of a critical reflection of the results (influence is not necessarily based on the amount of text a scholar has written).

Albeit these general issues when applying machine learning algorithms in the context of humanities-related research questions, I hope to have shown how easy clustering models can be implemented with Python. You only need to know fundamental Python concepts (such as for-loops) and implement libraries such as seaborn, pandas, and scikit-learn to create a powerful workflow of:

a) data exploration,
b) standardization,
c) applying the clustering algorithm(s),
d) evaluating the results & choosing the right k number,
e) and finally critically discussing the results.

How could we proceed from here?

Of course, we could and actually should add more layers to the clustering. Usually, it is a good idea to implement different clustering algorithms, such as hierarchical clustering and k-means, and to compare their results. Even though we have skipped this part in this tutorial, it should be pretty easy for us to add other algorithms now that we have understood how to work with scikit-learn.[^20]

Also, we could look for more features for our clustering algorithms in the data. In the case of the dataset used in this tutorial, the next step could be to group the data with respect to the authors' home institutions and search for geographical clusters. This means that we would have to integrate categorial values as well, which is possible but needs further processing, particularly when using categorical and continuous values together. 

Once you are familiar with the single steps, you could also start creating pipelines and functions, making it much easier to automate the overall process.

Finally, you should not forget that clustering is usually not the final step of your analysis, but only one tool helping you better understand your data. Thus, the best way to start practicing and to figure out how clustering might help you is to look for a dataset from your area of expertise and to start working on it with clustering algorithms.

# Bibliography

[^1]: A good overview of clustering algorithms in scikit-learn can be found in the official scikit-learn documentation under this [LINK](https://scikit-learn.org/stable/modules/clustering.html) (last accessed: 25.11.2020).

[^2]: I highly recommend the book *Hands-on machine learning with Scikit-Learn, Keras, and TensorFlow* [@Geron.2019]. Another good introduction to (un-)supervised learning can be found in the the article "Supervised Classification—The Naive Bayesian Returns to the Old Bailey" by Vilja Hulden on the *Programming Historian* website under this [LINK](https://programminghistorian.org/en/lessons/naive-bayesian#machine-learning) (last accessed: 25.11.2020).

[^3]: Again, I highly recommend the book by [@Geron.2019] and here particularly the first chapter on "The Machine Learning Landscape." You can also find thorough introductions in the other tutorials on *The Programming Historian* that deal with machine learning. For instance, the article on supervised machine learning by Vilja Hulden under this [LINK](https://programminghistorian.org/en/lessons/naive-bayesian) (last accessed: 21. July 2020) includes a great introduction of what (un-)supervised machine learning is.

[^4]: "Topic Modeling and MALLET" [LINK to the article on the Programming Historian website](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet) (last accessed: 21. July 2020).

[^5]: Yet, there are certain cases where k-means clustering might fail to identify the clusters in your data. Thus, it is usually recommended to apply several clustering algorithms. A good illustration of the restrictions of k-means clustering can be seen in the examples under the following link to the scikit-learn website, particularly the second plot in the first row: [LINK](https://scikit-learn.org/stable/auto_examples/cluster/plot_kmeans_assumptions.html#sphx-glr-auto-examples-cluster-plot-kmeans-assumptions-py) (last accessed: 21. July 2020).

[^6]: For more information, see the official documentation under [this LINK](https://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html) (last accessed: 21. July 2020).

[^7]: Usually by calculating the mean of all the data points assigned to the cluster.

[^8]: [LINK to scitkit-learn KMeans implementation](https://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html) (last accessed: 21. July 2020).

[^9]: [LINK MNIST dataset on Wikipedia](https://en.wikipedia.org/wiki/MNIST_database) (last accessed: 25.11.2020).

[^10]: [LINK IRIS dataset on Wikipedia](https://en.wikipedia.org/wiki/Iris_flower_data_set) (last accessed: 25.11.2020).

[^11]: [LINK UCI machine learning repositories](http://archive.ics.uci.edu/ml/index.php) (last accessed: 21. July 2020).

[^12]: [LINK Kaggle datasets](https://www.kaggle.com/datasets) (last accessed: 21. July 2020).

[^13]: [LINK DNP](https://referenceworks.brillonline.com/browse/der-neue-pauly) (last accessed: 21. July 2020).

[^14]: See footnotes above. Also note that you need to pay if your instituion does not provide access to the site.

[^15]: For a good introduction to the use of *requests* and web scraping in general, see the corresponding articles on *The Programming Historian* such as [LINK to Introduction to BeautifulSoup](https://programminghistorian.org/en/lessons/intro-to-beautiful-soup) (last accessed: 21. July 2020) or books such as *Web scraping with Python* [@Mitchell.2018].

[^16]: [LINK to my GitHub repository](https://github.com/thomjur/introduction_to_k-means_clustering_PH) (last accessed: 25.11.2020).

[^17]: For instance, through *One Hot Encoding* (see [LINK to the Wikipedia article](https://en.wikipedia.org/wiki/One-hot) (last accessed: 21. July 2020) for more information).

[^18]: [LINK to the scikit-learn documentation of the `StandardScaler()` class](https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.StandardScaler.html) (last accessed: 21. July 2020).

[^19]: Seaborn is a great looking plotting library based on matplotlib. For more information, see this [LINK to the official seaborn website](https://seaborn.pydata.org/) (last accessed: 25.11.2020).

[^20]: For example, you could start looking under [this LINK](https://scikit-learn.org/stable/modules/clustering.html#:~:text=Clustering%20of%20unlabeled%20data%20can%20be%20performed%20with,of%20integer%20labels%20corresponding%20to%20the%20different%20clusters.) (lasct accessed: 25.11.2020) for more clustering algorithms provided by scikit-learn.