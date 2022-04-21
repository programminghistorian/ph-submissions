---
title: "Clustering and Visualising Documents using  Word Embeddings"
collection: lessons
layout: lesson
slug: clustering-visualizing-word-embeddings
date: 2022-04-20
translation_date: LEAVE BLANK
authors:
  - Jonathan Reades
  - Jennie Williams
reviewers:
  - LEAVE BLANK
editors:
  - Alex Wermer-Colan
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

{% include toc.html %}

# Clustering and Visualising Documents using  Word Embeddings

## Learning Outcomes

1. The ability to generate custom word embeddings from a large corpus. In this tutorial we use a selection of nearly 50,000 records relating to U.K. PhD completions.
2. The ability to use dimensionality reduction techniques for visualisation and analysis purposes. In this tutorial we reduce the word embeddings from the data set to just 2 and 4 dimensions in order to make sense of the structure in the data.
3. The ability to use hierarchical clustering  to find and explore groups of similar documents within a large data set. In this tutorial we show how hierarchical clustering reproduces ‘expert knowledge’ from the data set in the form of the Dewey Decimal Classifications.

## Introduction

This tutorial will introduce you to word embeddings (WEs) and manifold learning, which are (relatively) recent techniques developed for processing text and performing dimensionality reduction on large data sets. Both are much more computationally demanding than their nearest predecessors—(very) broadly, [Latent Direchlect Analysis](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet) and [PCA](https://programminghistorian.org/en/lessons/clustering-with-scikit-learn-in-python#3-dimensionality-reduction-using-pca)—but the benefit is significantly more powerful methods for analysing both individual texts and whole corpora. Embeddings shift the focus from *raw content* to *terms in context*, and the publication of this technique—developed by researchers at Microsoft Research—in 2013 was the starting point of a series of radical improvements in the ability of computers to handle textual data at scale and to make large corpora *useful* and *accessible* to humans.

While the state-of-the-art has now surpassed the original word embedding technique, the training and energy costs of the latest techniques put them beyond the reach of today’s researchers (for now, at least). In contrast, WEs and manifold learning sit near the leading edge of what’s possible for a well-resourced researcher: this tutorial was written on a (virtualised) system with 4 CPUs, 20GB of RAM, and a Solid State Disk (SSD) drive, and we have included *rough* timings for each step based on those computing resources. With patience, it should be possible for readers to change the code in ways that allow you to ‘tweak’ our work or develop a framework for doing your own!

## Overview

The benefit of simple frequency-based analyses such as TF/IDF is that they are readily intelligible and fairly easy to calculate; however, they do not account for the *context* in which words occur except in a fairly crude way. A simple illustration of this problem is the case where two or more words—or terms—are used interchangeably (see what we did there?). Processing the corpus without recognising contextual similarity can cause documents to *appear* different simply because their authors had different usage preferences. More subtly, distinct disciplinary vocabularies—such as the way the term ‘network’ is used in the natural sciences and by social theorists—might also confound our overall understanding of a corpus if we rely *solely* on ‘bag of words’ approaches.

Embeddings allow us to represent both terms and documents as part of a shared ‘space’ in which the distance between any given pair of entities (documents or terms) tells us something about their relatedness. As the geographer Waldo Tobler once put it: “everything is related, but near things are more related than distant things…” (1970).

So how do we capture context?

This tutorial will introduce a *lot* of ideas, one after the other, and many readers may well end up feeling a little lost. The first thing to note is that this is entirely natural: while we’ve done our best to present these ideas in the simplest way we can, they are *not* easy concepts and we’ve taken a ‘first principles’ approach in which there is necessarily a lot to take in before much sense can be made of what is being done and why.

So let’s start with a brief overview:

- The importance of how texts are cleaned—do we stem or lemmatise? what minimum and maximum word frequences do we use as cut-offs—cannot be underestimated and we think it’s *essential* that you consider how the choices that we—and you—make here impact *everything* that comes afterwards. We filter out low- and high-frequency terms, like ‘analysis’ and ‘thesis’, that do not help us to distinguish *between* records but your own needs might be different!
- We then briefly discuss the Term Co-occurrence Matrix (TCM) because it underpins how ‘context’ can be learned by a computer. In most programming libraries you do *not* need to calculate this yourself, but some algorithms (*e.g.* R’s implementation of GloVe) *will* require you to call a function to do so before you can start to learn the word embeddings.
- The embedding process is ‘where the magic happens’ to produce useful word vectors that can be manipulated mathematically. We average the word vectors together to produce a document representation, but they also support adding/subtracting words from one another to explore relationships between terms (*King-Man+Woman…*).
- However, the embedding space is still ‘high-dimensional’ from the standpoint of most clustering algorithms, so we need to reduce this further to enable document-level analysis and visualisation. We highlight some of the potential drawbacks of linear PCA for this step and introduce non-linear manifold learning techniques, with a particular focus on UMAP because it preserves both global and local structure in the data.
- Finally, we show how hierarchical clustering is a more appropriate technique for our kind of work since its bottom-up approach to clustering allows us to flexibly ‘cut’ the data at multiple levels depending on need.

Let’s now put this understanding into practice…

## Case Study: E-Theses Online

The tutorial uses a long-running bibliographic corpus created by U.K. universities and supplied to the [British Library](https://www.bl.uk/) (BL) to enhance public access to doctoral research outputs. [*E-Theses Online*](https://ethos.bl.uk/) (EThOS, hereafter) provides metadata—including attributes such as Author, Title, Abstract, Keywords, and [Dewey Decimal Classification](https://en.wikipedia.org/wiki/Dewey_Decimal_Classification) (DDC)—about PhD completions at U.K. universities. In aggregate, [the data](https://bl.iro.bl.uk/catalog?locale=en&q=%22UK+Doctoral+Thesis+Metadata+from+EThOS%22&search_field=all_fields&sort=year_published_isi+desc&_ga=2.85833567.757719569.1646905901-495121888.1646905901) therefore provide a unique perspective on intellectual histories in Higher Education; however, most users’ interaction will be through individual document retrieved via the web interface shown in Figure 1.

**Figure 1. EThOS Web Interface for Individual Metadata Record**

![Figure 1. EThOS Screen Shot](./images/EThOS.png)

In the terminology of the British Library (BL), EThOS is ‘living knowledge’ (British Library 2015) which is constantly growing and, somewhat less frequently, gaining or losing attributes over time. The full data set of more than 500,000 records is available [via DOI](https://bl.iro.bl.uk/concern/datasets/c815b271-09be-4123-8156-405094429198). However, the Dewey Decimal Classification field is not normally provided as part of this distribution. We have therefore agreed with the BL to share a large subset of ca. 50,000 records that includes this attribute. This is not a random selection, we have attempted to select DDCs that should present a range of challenges for automated text-analysis and classification.

### Completeness

Table 1 shows the percentage of records for each field in the sample that contain data. While we have not verified that these all contain *useable* data it is nonetheless obvious that some, like Abstract and Institution (and, of course, Author and Title) are effectively complete, while others, such as Supervisor, Funder or DOI, are poorly populated at best. Across the *full* EThOS data set  the DDC is nowhere near as well-populated as in our selected sample (the same holds for some of the other fields), but that’s because we purposively chose records that would enable us to validate our approach against the expert-assigned label.

**Table 1. Completeness of Selected EThOS Metadata Attributes by Decade**

|           Attribute |     1980s |     1990s |      2000s |      2010s |    Overall |
| ------------------: | --------: | --------: | ---------: | ---------: | ---------: |
|              Author |       100 |       100 |        100 |        100 |        100 |
|               Title |       100 |       100 |        100 |        100 |        100 |
|            Abstract |       100 |       100 |        100 |        100 |        100 |
|            Keywords |        87 |        69 |         37 |         49 |         52 |
|                 DDC |       100 |       100 |        100 |        100 |        100 |
|         Institution |       100 |       100 |        100 |        100 |        100 |
|          Department |        46 |        33 |         31 |         53 |         45 |
|          Supervisor |        12 |         9 |         16 |         49 |         33 |
|  Subject Discipline |       100 |       100 |        100 |        100 |        100 |
|            Language |       100 |       100 |        100 |        100 |        100 |
|              Funder |         9 |         7 |          7 |         23 |         16 |
|                 DOI |         4 |         4 |          4 |         11 |          8 |
| **Count by Decade** | **3,583** | **6,931** | **11,249** | **26,980** | **48,743** |

### Selection

We have deliberately selected four topics at the ‘DDC2’ level (the ‘tens’ in the classification, see Table 2) on the basis that they would be a good test of the approach: Physics and Biology are distinct fields, but also overlap in increasingly complex ways in contemporary research; similarly, Economics is often thought of as distinct from the Social Sciences, but also necessarily overlaps to some extent. The division between the ‘hard’ and ‘soft’ sciences is also substantial, but Economics draws on elements of the hard sciences and there is a strong ‘soft’ component to healthcare that may show up in the Biology group. The count of theses from each DDC-group is shown below in Table 2, and note that the counts are (again, deliberately) unbalanced with one group dominating in each class.

**Table 2. Selected Records from EThOS Dataset**

| DDC1 Group                    | DDC2 Group                |      Count |
| :---------------------------- | :------------------------ | ---------: |
| **Science (500–599)**         |                           | **27,095** |
|                               | Biology (570–579)         |     18,418 |
|                               | Physics (530–539)         |      8,677 |
| **Social Sciences (300–399)** |                           | **21,648** |
|                               | Economics (330–339)       |     12,625 |
|                               | Social Sciences (300–309) |      9,023 |
| **Total**                     |                           | **48,743** |

Our objective is therefore to explore how well word embeddings capture one or more aspects of this structure: failure to reproduce these high-level distinctions would suggest significant shortcomings, while reproduction of finer-grained structure and enhanced document retrieval would suggest the added value of the embedding approach over TF/IDF and LDA analyses. We will be processing 48,743 records and will then compare our results against the librarian-assigned DDC to get a sense of how well the approach performs overall. While we focus in this tutorial on the overarching patterns in the data, the techniques shown can help, for instance, to fill in missing fields and identify possible mis-classifications.

## Prerequisites

This article should be seen as building on [Clustering with Scikit-Learn in Python](https://programminghistorian.org/en/lessons/clustering-with-scikit-learn-in-python) and if you are interested in implementing a word embedding approach in your own work then it will benefit you enormously to familiarise yourself with that tutorial *first*. Doing so will enable you to better-understand how embeddings allow us to approach text in a more nuanced—if necessarily more  intensive—way.

The most important differences between these tutorials are:

1. The use of word embeddings instead of term frequency approaches;
2. The use of manifold learning for dimensionality reduction and visualisation instead of linear decomposition;
3. The use of hierarchical clustering instead of *k*-means; and
4. The use of validation approaches commonly-found in Machine Learning.

Contrasting these two tutorials will allow you to develop a broader understanding of the Natural Language Processing (NLP) landscape. Extensions of this approach employing algorithms with names like BERT and RoBERTa further enhance our ability to work with corpora by disentangling—that is, providing distinct embeddings for—‘bank’ (a place that provides financial services) and ‘bank’ (the land at the side of a river). The approaches employed in this tutorial do not provide that level of disambiguation.

### Required Libraries

In addition to the default ‘data science’ libraries of `numpy`, `pandas`, and `seaborn`, you will need to install several more specialised libraries:

- For the derivation of Word Embeddings you will need `gensim`
- For the dimensionality reduction you will need `umap-learn`
- For the hierarchical clustering and visualisastion you will need `scipy`, `scikit-learn`,  `kneed`, `tabulate`, and `wordcloud`

Most of these area available via Anaconda Python’s `conda` channels and can be isntalled via, for example, `conda -c conda-forge install gensim`, but some may only have `pip` installers and will need to be installed using, for example, `pip install kneed`.

If you wish to save the intermediate files it will be necessary to install the feather format (`feather-format` for installation purposes) so that pandas can read/write feather files. Feathers are designed for fast data interchange between R and Python, and they’re good at preserving more complex data structures, such as lists, so that we don’t need to recreate them on each load or risk them being serialised (written to a file) incorrectly.

Two Docker images are also available:

1. A ‘large’ Docker image that includes all libraries used in cleaning and processing the data.
2. A ‘small’ Docker image that includes only those libraries needed to complete this tutorial.

Once these libraries are installed, we import them as follows:

```python
# Generally useful libs
import pandas as pd
import numpy as np
import random
import math
import ast
import os
import re

# For visualisation
%matplotlib inline # Assumes Jupyter notebook
import matplotlib.pyplot as plt
from matplotlib import cm
import seaborn as sns

# For word embeddings
from gensim.models.word2vec import Word2Vec

# For dimensionality reduction
import umap

# For hierarchical clustering
from scipy.cluster.hierarchy import dendrogram, linkage, fcluster, centroid
from kneed import KneeLocator
from sklearn.metrics import silhouette_score, silhouette_samples
from tabulate import tabulate

# For validation and visualisation
from sklearn.metrics import confusion_matrix, classification_report
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_extraction.text import CountVectorizer

from wordcloud import WordCloud
```

In our experience, it’s also helpful to specify a few a options that increase the replicability of the work and also allow us to skip computationally expensive steps by caching the outputs:

```python
# Set random seed
rs = 42

# Whether to load a cached model result
# to allow further exploration of model
# parameters later.
cache = True
```

As a final note, for the WordClouds I change the default Matplotlib font to one called “Liberation Sans Narrow” by finding the ‘font path’ (`fp`):

```python
fp = '/usr/share/fonts/truetype/liberation/LiberationSansNarrow-Regular.ttf'
```

You can find out the fonts available on *your* system using:

```python
import matplotlib.font_manager
matplotlib.font_manager.findSystemFonts(fontpaths=None, fontext='ttf')
```

### Load the Data

With the libraries loaded we’re now ready to begin:

```python
# Name of the file
fn = 'ph-tutorial-data-cleaned.csv.gz'

# See if the data has already been downloaded, and
# if not, download it from the web site. We save a
# copy locally so that you can run this tutorial
# offline and also spare the host the bandwidth costs
if os.path.exists(os.path.join('data',fn)):
  df = pd.read_csv(os.path.join('data',fn), low_memory=False, encoding="ISO-8859-1").set_index('EThOS_ID')
else:
  # We will look for/create a 'data' directory
  if not os.path.exists('data'):
    os.makedirs('data')

  # Download and save
  df = pd.read_csv(f'http://www.reades.com/{fn}', low_memory=False, encoding="ISO-8859-1").set_index('EThOS_ID')
  df.to_csv(os.path.join('data',fn), compression='gzip')

# Two initial data transformations
df['tokens'] = df.tokens.apply(ast.literal_eval)
df['YearGroup'] = df['Year'].apply(lambda x: str(math.floor(int(x)/10)*10)+'s')
```

This loads the EThOS sample into a new pandas data frame called `df` using a few options that may be new: we are not using the default encoding for text but the British Library’s default of `ISO-8859-1`, and we set `low_memory=False` so that the file is fully loaded before pandas attempts to infer the column type.

It’s also worth noting what `ast.literal_eval` does: it’s not possible to write a list directly into a CSV file, so pandas ‘interprets’ this into `"['policy', 'evaluation', 'macroeconometric', 'model', 'present', 'number', 'example', 'macroeconometric', ..., 'technique', 'new']"`. This is a list written *as a string* so we use the `ast` library to turn that back into a an actual list in the `tokens` column of the pandas data frame.

Let’s begin!

## Data Cleaning & Transformation

In common with many other types of quantitative analysis, the choices made during the data preparation phase are *crucial* to the downstream results. Entire tutorials could, and probably *should*, be written about how to make the ‘right’ choices—by which we mean the choices that best-support the kind of analysis you wish to undertake—but since that is not the focus of *this* tutorial we will not dwell on the process here. However, to support reproducibility and experimentation we have provided a full set of Jupyter notebooks so that you can adjust the settings and see how the outputs might—or might not—change as a result.

In other words, we have provided an entire pipeline for processing the EThOS corpus but will be focussing the tutorial on just the final stages in this pipeline: deriving the embeddings and exploring/clustering the results. But should you have the resources and motivation to explore further, then our [GitHub repository](XXX) seeks to support you in doing so! Briefly, we employed the following cleaning and transformation steps: 1) removal of ‘markup’, accents, possessives, punctuation, and quote-marks; 2) Named Entity Recognition (including of acronyms) and lemmatisation; 3) automated detection of bigrams and trigrams; 4) removal of very high- and very low-frequency terms. The input and output to this process are shown with randomly-selected examples in Table 3.

**Table 3. Selected Source and Cleaned Text Examples**

| EThOS ID | Source Text                                                  | Cleaned Text                                                 |
| :------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 658449   | The economic effects of resource extraction in developing countries. This thesis presents three core chapters examining different aspects of the relationship between natural resources and economic development. While addressing different questions they share several features in common: a concern with causal inference; overcoming the challenges of endogeneity between resource abundance and other characteristics of developing countries; and the use of new and novel datasets with spatially identified units of analysis. The work contributes to a rich and growing empirical literature seeking to deepen our understanding of the underlying mechanisms affecting the fortunes of resource-abundant countries. In the introductory chapter I discuss the extensive literature on this topic and in particular focus on the new generation of well-identified within-country studies, seeking to understand the empirical relationship between resources and economic development. Countries typically welcome the news of a resource discovery with joy and indeed, resource discoveries hold great economic potential. But what determines whether a country is resource rich or not? Is it more than just a chance finding, or good geology? In Chapter 2, entitled Institutions and the Location of Oil Exploration I present ... (continues) | economic effect resource extraction develop_country present_three core examine different_aspect relationship natural_resource economic_development address different question share several feature common concern causal inference overcome challenge endogeneity resource abundance characteristic develop_country use new novel datasets spatially identify unit_analysis work contribute rich grow empirical_literature seek deepen underlying_mechanism affect fortune resource abundant country introductory discuss extensive_literature topic particular_focus new_generation well identified within country study_seek empirical relationship resource economic_development countries typically welcome news resource discovery joy indeed resource discovery hold great economic potential determine_whether country resource rich chance finding good geology entitle institutions location oil exploration present |
| 529998   | Making sense of environmental governance : a study of e-waste in Malaysia. The nature of e-waste, which is environmentally disastrous but economically precious, calls for close policy attention at all levels of society, and between state and non-state actors. This thesis investigates the roles of state and non-state actors in e-waste governance in Malaysia. This is undertaken through analysis of e-waste governance, particularly focusing on the locally generated industrial and household e-waste, from the perspective of multiple actors, levels and modes of governance. From the perspective of multiple actors governance, this thesis recognises three main actors of e-waste governance in Malaysia Ã¢ÂÂ the state actor, and two types of non-state actors Ã¢ÂÂ the Private Sector Actors and the Civil Society Organisations. Although it appears theoretically simple to classify actors of governance into one of these categories, in practice the line separating these two categories is blurry. From the multiple modes perspective, empirical evidence from this research has shown that state and non-state actors are involved in four modes of governance Ã¢ÂÂ the hierarchical, persuasion, self-governance and co-governance mode; with the roles of state actors being more prominent in the hierarchical modes, ... (continues) | making_sense environmental_governance study waste malaysia nature waste environmentally disastrous economically precious call close policy attention level society state_non_state actor investigate_role state_non_state actor waste governance malaysia undertake analysis waste governance particularly focus locally generate industrial household waste perspective multiple actor level mode_governance perspective multiple actor governance recognise three_main actor waste governance malaysia state_actor two_type non_state_actor private sector actors civil society organisations although appear theoretically simple classify actor governance one category practice line separate two_category multiple mode perspective empirical_evidence show state_non_state actor_involve four mode_governance hierarchical persuasion self_governance governance mode role state_actor prominent hierarchical mode |
| 542308   | An exploratory study of the constructions of 'mental health' in the Afro Caribbean community in the United Kingdom. Afro Caribbean people living in the United Kingdom have historically been overrepresented in the 'mental health' system in in-patient units; they are also more likely to enter services through adverse routes such as the police or criminal justice system. There have been a number of explanations that have been postulated to account for Afro Caribbean people's over-representation and these have usually been concerned with services or views drawn from clinical samples. This research was interested in how the people themselves from the Afro Caribbean general population constructed 'mental health'. The present study involved interviewing ten people from the Afro Caribbean community about their understanding of 'mental health'. A critical realist epistemological position was taken and a post-structualist Foucauldian discourse analysis was used to analyse how participants constructed 'mental health', those who experience 'mental health' difficulties and attendant social practices. The analysis demonstrated that participants constructed 'mental health' by drawing on both biological and social explanations. They constructed the 'community' as 'misunderstood and 'problematic' in the gaze of the 'dominant population'. ... (continues) | exploratory_study construction mental_health caribbean community united_kingdom caribbean people_live united_kingdom historically mental_health system in_patient unit also likely enter service adverse route police criminal_justice_system number explanation postulate account caribbean people over_representation usually concern service view draw clinical_sample interested people caribbean general_population construct mental_health present_study involve interview_ten people caribbean community_mental health critical_realist epistemological_position take post foucauldian_discourse analysis use_analyse participant construct mental_health experience mental_health_difficulty attendant social_practice analysis participant construct mental_health draw biological social explanation construct community misunderstood problematic gaze dominant population |

Depending on your needs it may not make sense to apply all of these steps in your own work. As well, there is _some_ reason to think that embeddings are more robust than frequency-based approaches to ‘noise’ such as stop words and some of the standard cleaning steps are therefore less important. However, we have not yet found a clear or careful investigation of the impact that *each* of these steps has in isolation or in combination. Regardless, the output of these phases is a numerical representation of a text in which out-of-vocabulary terms are represented by `-1` and these are then dropped from the subsequent analysis.

## The Term Co-occurence Matrix

Historically (if an approach less than 20 years old can be said to be ‘historical’), and not least because of limitations in computer hardware, we treated documents as a single ‘bag of words’ in which order was irrelevant. To assess a document’s content we could look at the frequency of terms in the document (TF) and, if we wished to assess its distinctiveness, compare it to the corpus as a whole (IDF). The Term *Co*-occurence Matrix (TCM) is the means by which we unlock the potential of *context* in a corpus.

The TCM is simply a table—a very *big* table, as we’ll see in a moment—in which we record the results of scanning the corpus word-by-word while noting down the terms that come immediately before and/or after. Conceptually, every time we see the word ‘hat’ following the word ‘cat’, we can add 1 to the ‘cat/hat’ cell in the TCM. So when the scan of the corpus is complete, simply by looking across the ‘cat’ row until we reach the ‘hat’ column we know that ‘cat/hat’ cropped up, say, 27 times. We *also* now know that ‘cat/dark_matter’ was not found in the corpus at all. In aggregate, this matrix of captures which term combinations are *likely* and which ones *are not*.

The point of the TCM is to capture context in the corpus, but how *much* context is appropriate? What is the window around the target term over which context should be considered? The answer depends on the type of text you’re working with. If we only look ahead then we are in the realm of *predictive* applications: given *this* word, what words are likely to come next? If we only look behind then we are in the realm of *corrective* applications: given *this* word, what words are likely to have preceded it? We take a *symmetric* approach that considers both pre- and post-terms since that is the context upon which the rest of the analysis depends. For completeness, we should also note that the window can be weighted such that adjacent terms within the window ‘count’ for more than distant terms within the window.

## The Word Embedding

Because it records literally every *possible* word combination, the TCM has two major drawbacks: high dimensionality and extreme sparsity. If there are 5,000 words in the corpus, there are 25 *million* entries in the TCM because the overall size is the square of the number of terms. A corpus of 25,000 terms generates a TCM of more than 6 *billion* entries even though the vast majority of these entries will be zeroes because, in practice, many words never co-occur! Even for modern super-computers matrices of this size are something of a challenge. Indeed, one of the principal benefits of more aggressive data cleaning earlier in the analysis is the reduction in size of the TCM.

### How it works

What the embedding phase of ‘Word Embedding’ (WE) process does is to work out how best to *embed* this very high-dimensional space ($$m \times m$$) into a much lower-dimensional one ($$m \times n$$, where $$n << m$$​). The embedding captures the essence of the relationships between terms observed in the TCM in a much more condensed manner: most embeddings use between 100 and 300 dimensions (*i.e.* from 25,000 $\times$ 25,000 down to 25,000 $\times$ 300) and will contain few, if any, zeroes. We now have much low(er) dimensionality *and* sparsity; you may see this termed a ‘dense vector’ or ‘dense representation’.

What made the development of Word Embeddings so exciting is that they are derived in a way that supports mathematical operations. The formulation of this in the seminal paper by Mikolov *et al*. (2013) is:

> King – Man + Woman $\approx$ Queen

While the maths is complex (and we won’t pretend to understand it fully), we can easily imagine that King/he/man and Queen/she/woman will be found in similar contexts in a set of source documents, and the embedding algorithm can therefore learn this relationship through statistical association rather than needing to be taught this explicitly. This outcome opens the way to finding synonyms and more complex relationships in an automated way: King and Emperor are likely to be ‘closer’ to one another in the embedding-space than, say, King and Peasant.

### Configuring the process

Using the list of tokens in the data frame, we can get a sense of the size of the vocabulary we're working with using [this approach](https://stackoverflow.com/a/38896116/4041902). Estimating the ‘right’ number of dimensions to choose for the word embedding phase is a lot trickier: the examples we've found produce *_very_* different results since they vary between the square and fourth root of the vocabulary size. Google's [TensorFlow developers](https://developers.googleblog.com/2017/11/introducing-tensorflow-feature-columns.html) recommend $\sqrt[4]{d}$, while [Wikipedia](https://en.wikipedia.org/wiki/Word2vec#Dimensionality) indicates "between 100 and 1,000" (/ht to [Tom Hale](https://stackoverflow.com/a/55412509/4041902)). This appears to be an [area of active research](https://aclanthology.org/D19-1369.pdf) commercially (and see also [this paper](https://aclanthology.org/I17-2006/)), but working this out in code is far beyond the scope of this tutorial so this code is intended to offer a *sense* of the range from which you might want to choose:

```python
vocab = (list(set([a for b in df.tokens for a in b])))
print(f"Data set has a vocabulary of {len(vocab):,} words")
print(f"An upper estimate of necessary vector size is {math.floor(len(vocab)**0.5)} dimensions.")
print(f"A lower estimate of the vector size is {math.ceil(len(vocab)**0.25)} dimensions.")
```

The initial training phase—in which a neural network ‘learns’ the word embeddings—can be quite expensive computationally. As a result, many users simply download *pre*-trained embeddings derived by major institutions and corporations; these will have been developed with an enormous vocabulary to capture a wide range of variations in usage and meaning. Pre-trained embeddings are available for both generic and specific language domains so, for instance, ones generated from social media sources *should* outperform generic embeddings on, say, Twitter-oriented applications. For domain-specific applications, such as our data set of abstracts, researchers are likely to obtain better results by training *their own* embeddings on the actual data, and that is what we do here.

We use the following parameters:

```python
dims = 100
print(f"You've chosen {dims} dimensions.")

window = 5
print(f"You've chosen a window of size {window}.")
```

We *also* set minimum vocabulary threshold (words exceeding the maximum were filtered out earlier in the cleaning phase) such that words that appear *too* infrequently do not have embeddings calculated. Rather than choose a hard floor, we condition this on the size of the data set:

```python
min_v_freq  = 0.0005 # Don't keep words appearing less than 0.05% frequency
min_v_count = math.ceil(min_v_freq * df.shape[0])
print(f"With a minimum frequency of {min_v_freq} and data set of size {df.shape[0]:,} the minimum vocab frequency is {min_v_count:,}")
```

This outputs: `With a minimum frequency of 0.0005 and data set of size 48,694 the minimum vocab frequency is 25`.

### Creating a model

Because the process of calculating Word Embeddings is so expensive, we use a caching approach in which a model can be *reloaded* if the input parameters are the same as a previous run of the model. This means that you don’t need to worry about ‘losing your work’ or keeping Python running for as long as it takes you to you complete the tutorial. You can expect generating a Word2Vec model to take ***up to 15 minutes**.

```
python
%%time

print(f"Word2Vec model has dimensionality of {dims} and window of {window}")

# m_nm == model name and note re-use of dims and window parameters
m_nm = os.path.join('data',f"word2vec-d{dims}-w{window}.model")

if cache==True and os.path.isfile(m_nm):
    # If we're using the cache and the file exists...
    print(f"  Loading existing word2vec model...")
    model = Word2Vec.load(m_nm)
    print(f"    Model loaded from {m_nm}")
else:
    print(f"  Creating new word2vec model...")
    print(f"    Mininum vocabulary frequency is {min_v_count}")
    print(f"    Window size is {window}")
    print(f"    Dimensionality is {dims}")

    # Note issues with full reproducibility with multiple workers: https://radimrehurek.com/gensim/models/doc2vec.html
    # See: https://radimrehurek.com/gensim/auto_examples/tutorials/run_word2vec.html
    # And: https://radimrehurek.com/gensim/models/word2vec.html#pretrained-models

    # Note that 'iter' is being deprecated in favour of epochs so this parameter
    # name is likely to change and trigger an error in the near future
    model = Word2Vec(sentences=df.tokens.values.tolist(), size=dims, window=window, iter=200, min_count=min_v_count, seed=rs, workers=4)
    model.save(m_nm)
    print(f"    Model saved to {m_nm}")
```

If you are concerned with *full replicability* at the finest scale, then please also note that you need to **change the number of `workers`** from 4 to 1: this is because more than one worker means the process is running in parallel and you cannot guarantee that documents/words will be passed to the modelling process in the *_same order_* every time. If you use multiple workers then the results should be *_consistent_* but not *_exactly the same_* from run to run. Of course, running with only one worker will also multiple the model run time by four!

### Sample output

Table 4 below shows two things: 1) the first 3 dimensions of the 100 dimensions generated by the word embedding process for *every* term in our selected corpus; 2) the seven *closest* terms in that embedding space to the randomly-chosen term. To be clear about what this shows: these ‘similar’ words can be found in similar contexts to the target word. In other words, ‘FTSE’ tends to appear in similar contexts to ‘London Stock Exchange’ and ‘CERN’ in similar contexts to ‘[Particle] Accelerator’. If we had included, for instance, documents relating to the design of cars then the 7 most similar terms to accelerator might include ‘brake’ and ‘indicator’; that’s because Word Embeddings aren’t learning *meaning*, they’re learning context. The fact that the same term is used in two quite different contexts—because: different meaning—is irrelevant. Some newer algorithms, however, *would* distinguish between these two contexts but these are harder to train.

**Table 4. Illustration of word embedding outputs and similarity**

|                    Term |     Dim 1 |     Dim 2 |     Dim 3 | Top 7 Similar                                                |
| ----------------------: | --------: | --------: | --------: | ------------------------------------------------------------ |
|             accelerator | -2.597380 |  0.562458 |  3.047121 | beam, cern, facility, spectrometer, beam_energy, linac, clic |
|     tourism_development |  2.015669 | -3.138925 | -1.353550 | tourism, sustainable_development, ecotourism, sustainable_tourism, social_sustainability, biodiversity_conservation, eia |
|   london_stock_exchange |  0.516811 | -0.935569 |  1.090004 | ipo, ftse, stock_market, announcement, lse, repurchase, future_market |
|   staphylococcus_aureus | -2.645318 |  1.231575 | -1.765407 | aureus, pseudomonas_aeruginosa, salmonella, bacterial, streptococcus, escherichia_coli, jejuni |
| national_health_service |  1.782367 | -2.309419 | -2.430357 | nhs, public_sector, emergency, public_health, developed_world, workforce, hospital |



Here are the top-10 most similar words for an array of other terms, demonstrating the extent to which they allow us to identify ‘relatedness’ across a range of disciplines based on the context in which terms are used. The first three terms in Table 5 stress that this is not about the computer developing some underlying understanding of ‘salmon are like rainbow trout’ and ‘Einstein developed the theory of relativity’ but a context-based substitutability based on the window size and weighting that we specified when developing the word embeddings.

**Table 5. Selected Terms and their Top-10 Most Similar**

| Term                                 | Top 10 Similar                                               |
| :----------------------------------- | ------------------------------------------------------------ |
| einstein                             | field_equation, gravity, scalar_field, equation, relativity, gauge_theory, string_theory, quantum_field_theory, non_abelian, minkowski |
| colorectal_cancer                    | cancer, breast_cancer, prostate_cancer, ovarian_cancer, type_diabetes, leukaemia, leukaemic, human_cancer, malignant, brca1 |
| atlantic_salmon                      | salmo, fish, rainbow_trout, salar, salmonid, salmon, oncorhynchus, brown_trout, mykiss, freshwater |
| new_keynesian                        | open_economy, dsge_model, optimal_monetary, dsge, indirect_inference, partial_equilibrium, return_scale, small_open_economy, financial_friction, cge |
| land_use_change                      | land_use, change_climate, environmental_change, vegetation_change, biodiversity, habitat_fragmentation, rainfall, agricultural_intensification, cl... |
| semi_structured                      | semi_structured_interview, interview, participant_observation, in_depth_interview, interview_conduct, interview_focus, focus_group, focus_group_di... |
| influenza_virus                      | virus, viruses, influenza, viral, viral_rna, adenovirus, rna, herpesvirus, norovirus, rna_virus |
| north_east_england                   | group_young, mixed_race, east_midlands, town, experience, britain, old, england, north_of_england, birmingham |
| built_environment                    | build_environment, quality_life, city, urban_form, informal_settlement, urban, social_sustainability, physical_activity, energy_supply, sustainabl... |
| information_communication_technology | ict, icts, communication_technology, information_technology, new_medium, internet, telecommunication, digital_technology, knowledge_economy, techn... |
| urban_regeneration                   | regeneration, urban_development, city, initiative, planning_policy, urban, cultural_policy, urban_design, urban_policy, public_policy |
| gravitational_wave_detector          | interferometer, gravitational_wave, astronomical, detector, device, laser, semiconductor_laser, collimation, lasers, ultra_low |
| cultural_heritage                    | heritage, cultural, landscape, contemporary, national_identity, buddhist, tourism, community, modernisation, intangible |
| cultural_capital                     | bourdieuas, bourdieu, cultural, literary, symbolic, social_capital, solidarity, elite, assert, habitus |

So it is contextual component of embeddings that allows us to begin to draw out connections—to both ideas and people—that would otherwise remain implicit in a text. Certainly, they would be invisible—or buried in the statistical noise—to LDA or TF/IDF approaches. Combined with other types of relations (*e.g.* citation networks or co-authorship patterns) then much deeper structures within academia (or any other corpus) will emerge. Indeed, the potency of expert-led processing and embedding was demonstrated by Tshitoyan *et al.* (2019), who analyse over 3 million materials science abstracts and are able to *anticipate* the discovery of new materials by a year or more! While such applications may be few and far between, as a marker of just how far we have come with our ability to mine patterns from text this is extraordinarily exciting.

### From Words to Documents

The most stunningly counter-intuitive finding (to us, at least) from research with word2vec is that it is possible to *average* together the individual Word Embeddings for all of the terms in a document and obtain a *useful* representation of the document as a whole. The magic of the resulting ‘average document embedding’ is that common words that are found in many documents effectively cancel each other out, so that what remains is a ‘signal’ of distinctive word choices. So even in a corpus where *everyone* is writing about, say, French medieval poetry or computer programming, the *really* popular turns-of-phrase affect *every* document equally, while the distinctive parts (*e.g.* is it about Python, C, or Java?) act to group similarly distinctive documents together.

We use two functions to help us perform this step:

```python
# Looks up the vector for a given word, returning NaN
# if the record's not found. So vlkp == vector lookup
def vlkp(w:str, m:Word2Vec) -> np.ndarray:
    try:
        return m.wv[w]
    except KeyError:
        return np.nan

# Derives the average (mean) embedding for the document
# based on the retrieved word vectors. So we iterate over
# the tokens and use vlkp to lookup the vector.
def avg_embedding(t:list, m:Word2Vec):
    vecs = [y for y in [vlkp(x, model) for x in t if x != -1] if not np.isnan(y).all()]
    if len(vecs)==0:
        return np.nan
    else:
        return np.mean(np.stack(vecs, axis=0), axis=0)

print(f"Populating df.word_vec field")
df[f'word_vec'] = df.tokens.apply(avg_embedding, args=(model,))    
```

So this block of code takes the `model` created in the previous code block and passes it as an argument to the `avg_embedding` function (to calculate an *average embedding*) that we apply to the `tokens` field of *every* record in the data frame. The `avg_embedding` function will use the model to look up the vector corresponding to each word (`vlkp` == ‘vector lookup’) and then averages the result by stacking the vectors so that we get a value for every dimension (`np.mean(np.stack(vecs, ...))`).

If you are interested *primarily* in document similarity then it is possible to improve on this approach using a dedicated [Document Embedding](https://radimrehurek.com/gensim/models/doc2vec.html) algorithm instead. That said, we’ve often found these results to be less intuitive that the ones derived from word embeddings.

<div style=“border: dotted 3px red; background-color: rgb(255,225,225); padding: 15px”>
  <b style="color:red">This is a possible break-point in the tutorial but then, in my opinion, would require adding a <i>bit</i> of experimentation with the word embeddings in order to show how they are useful <i>in and of themselves</i>.</b>
</div>

## Manifold Learning

So the process presented so far generates a data set that, in our case, is roughly 50,000 rows by 150 columns. In principle, we could now explore relationships between terms and documents within this ‘embedding space’; however, even though we’ve radically reduced the number of dimensions (columns of data), we’re still working in space that is impossible to visualise. This presents two problems:

- First, the ‘[curse of dimensionality](https://en.wikipedia.org/wiki/Curse_of_dimensionality)’ inflates the distances between elements because the Euclidean distance is measured $\sqrt \sum[x_{i}^2 + x_{j}^2 +...]$ and all those $x^2$ really add up; and
- Second, many clustering algorithms—and traditional *k*-means is a good exemplar of this—perform poorly in exactly these types of high-dimensional environments.

*One* way to address this is to select a clustering algorithm *designed* for high-dimensional spaces: [Spherical *k*-means](https://pypi.org/project/soyclustering/) would be one solution because it uses cosine distance. The more usual response, however, is to further reduce the dimensionality of the data using Principal Components Analysis (PCA): up to a point, principal components are fairly easy to calculate even for large data sets and their ‘meaning’ is well-understood. But the output of PCA is both linear *and* results in a loss of information because only a proportion of the observed variance in the data is retained. We keep the ‘highlights’, if you will, and potentially lose subtle but important differences at the finer scale because they look like ‘noise’.

In the 2nd case study from the [Clustering with Scikit-Learn in Python](https://programminghistorian.org/en/lessons/clustering-with-scikit-learn-in-python#second-case-study-clustering-textual-data) tutorial we see exactly this issue: PCA is applied to TF/IDF-transformed abstracts from the [Religion](https://perma.cc/P4VN-6K9K) journal as precursor to grouping similar articles together. The tutorial correctl identifies issues with the suitability of the approach and suggests different clustering approaches and further experimentation with the input parameters to improve the weak results. However, our [replication of that analysis](./03-Comparing_Approaches.ipynb) shows that the first ten principal components account for just 12% of the variance observed in the data. In other words 88% of the variation in the data is being lost, so it’s hardly surprising that there is little explanatory power to the poorly-fitted clusters.

### How it works

In contrast to PCA, manifold learning techniques such as [t-SNE](https://en.wikipedia.org/wiki/T-distributed_stochastic_neighbor_embedding) (t-distributed Stochastic Neighbour Embedding) and [UMAP](https://en.wikipedia.org/wiki/Nonlinear_dimensionality_reduction#Uniform_manifold_approximation_and_projection) (Uniform Manifold Approximation and Projection) embed the higher-dimensional space into a lower-dimensional one in its entirety. t-SNE aseeks to maximise *visibility*, sacrificing global structure in the interests of making local structure visible, while UMAP seeks to preserve both local *and* global structure, making it more useful as a precursor to clustering. Figure 2 shows what the *Religion* data ‘looks like’ when UMAP is used to project the transformed data down into just 2 dimensions. The colours show the clusters assigned by following the tutorial’s approach of applying PCA and then the DBSCAN clustering algorithm.

**Figure 2. UMAP embedding of *Religion* journal abstracts**

![UMAP Output](./images/UMAP_Output.png)

To be clear, we should not imagine that what we *see* after UMAP reduction is how the data actually *is*: unlike PCA, changing the parameters can change the embedding space produced. But what this does allow us to see is that, realistically, 4 clusters is not—as was noted in the original tutorial—a particularly good choice. Thanks to UMAP, we can *also* see that tweaking parameters for DBSCAN is unlikely to help either: using a TF/IDF representation the data simply isn’t structured in a way that is likely to permit a small number of natural clusters to emerge.

### Configuring the process

UMAP offers several distance measures for performing dimensionality reduction. We have used `euclidean` since the later results seem robust, but many NLP applications use `cosine` similarity and this might provide good results. `manhatta`n distance could also be worth exploring!

```python
dmeasure = 'euclidean'
rdims    = 4 # r-dims == Reduced dimensionality
print(f"UMAP dimensionality reduction to {rdims} dimensions with '{dmeasure}' distance measure.")
```

You can also see that we’ve selected four dimensions as the target manifold output: so we’ve further reduced the ‘problem space’ from 100 dimensions to just 4!

### Reducing dimensionality

Because we’ve stored the original tokens and averaged embeddings as list-type columns, we need to do a tiny bit more work to make these columns useable by the various libraries. For UMAP, we need to convert the `word_vec` column into a data frame in its own right using `x_from_df`. Here, each embedding dimension because a new columns `V{dimension_number}` (so V1…V100) and the index is the `EThOS_ID` so that we can eventually link the results back to the original data.

```python
# Assumes that there is a column that contains the
# document embedding as an array/list that needs to be
# extracted to a new data frame
def x_from_df(df:pd.DataFrame, col:str='Embedding') -> pd.DataFrame:
    cols = ['E'+str(x) for x in np.arange(0,len(df[col].iloc[0]))]
    return pd.DataFrame(df[col].tolist(), columns=cols, index=df.index)

X = x_from_df(df, col='word_vec')

# Create a UMAP 'reducer'
reducer = umap.UMAP(
    n_neighbors=25,
    min_dist=0.01,
    n_components=rdims,
    random_state=rs)

# Reduces our feature vectors for each thesis down to n dimensions
X_embedded = reducer.fit_transform(X)

# Create a dictionary that is easily converted into a pandas df
embedded_dict = {}
for i in range(0,X_embedded.shape[1]):
    embedded_dict[f"Dim {i+1}"] = X_embedded[:,i] # D{dimension_num} (Dim 1...Dim n)

# dfe == df embedded from the dictionary
dfe = pd.DataFrame(embedded_dict, index=df.index)
del(embedded_dict)

dfe.head(3)
```

Note that UMAP uses a `fit_transform` syntax that is deliberately similar to [Scikit-Learn](https://scikit-learn.org/stable/)’s, because it is intended to fill a gap in the algorithms on offer for dimensionality reduction. The process takes a variable amount of time depending on the output dimensions and input data, but will normally take about 1 minute with this sample. Regardless, the output of `dfe` show a much-reduced dimensionality:

| EThOS_ID | Dim 1     | Dim 2    | Dim 3    | Dim 4    |
| -------- | --------- | -------- | -------- | -------- |
| 232827   | 0.058840  | 2.542224 | 7.520219 | 3.605985 |
| 232829   | 0.654654  | 3.075455 | 6.966126 | 6.365264 |
| 232830   | -0.680860 | 2.477436 | 6.685958 | 1.501117 |

At this dimensionality most clustering algorithms will perform well, though great care should be taken in interpreting the apparent distance between clusters following this type of dimensionality reduction. We finish this stage by merging the resulting 4-dimensional embedded data frame (`dfe`) with the original EThOS sample (`df`):

```python
projected = df.join(dfe).sort_values(by=['ddc1','ddc2'])
print(projected.columns.values)
```

### Visualising the results

The best way to get a sense of how well the Word Embedding process performs in conjunction with UMAP dimensionality reduction is to make a plot that projects the 150-dimensional document embeddings down to just 2 dimensions for visualisation. Figure 3 shows two views of the data coloured by the DDC1 and DDC2 groups, respectively. It’s clear that the vocabularies of the social and physical sciences—at least, those that we selected here—differ significantly.

**Figure 3. UMAP embedding of selected EThOS data coloured by assigned DDC**

![Visualisation of 4D space by DDC](./images/DDC_Plot.png)

More promisingly, there also appears to be a clear overarching distinction *within* each of these high-level groups: Social Sciences appear to separate well from Economics, and the same holds for Physics and Biology. That said, there _are_ nearly 50,000 points on each plot, so there is also a high risk of overplotting in which two or more points occupy the same coordinates with only the top-most being visible. Of particular interest, however, are the areas where the DDC classification does *not* appear to align: the Economics/Biology interface is intriguing (and plotting the theses by decade shows that this effect is relatively recent), as are the areas where the level-2 classes overlap on the second subplot (*e.g.* the linkage between Physics and Biology).

Reducing the embeddings to just two dimensions would really helpful for visualisation purposes, but for further analysis a (slightly) higher number of dimensions will allow more of the underlying variation in the data to be preserved, increasing the separability of any clusters. Here we come to the trade-offs surrounding dimensionality: too many and we suffer the curse of dimensionality, too few and we lose the distinctiveness of the clusters! In practice, we have found 4–8 dimensions to be a good range for avoiding the issues associated with too few, or too many, dimensions.

## Hierarchical Clustering

On both a practical and a philosophical level we feel that a [hierarchical clustering](https://docs.scipy.org/doc/scipy/reference/cluster.hierarchy.html) approach is more analytically relevant to what we are doing with our PhD abstracts. First, while we might broadly agree on a the existence of a high-level distinction between, say, the interests of Historians and Computer Scientists, the reality of academic disciplines is much messier: what are we do with historians *of* Computer Science? Is digital humanities ‘like’ other humanities or does it have distinctive features that position it somewhere between the Humanities and Computer Science?

### How it works

Hierarchical clustering takes a ‘bottom-up’ approach: every document starts in its own cluster of size one. Next, we merge the two *closest* observations in the entire data set to create a cluster of size two. We then look for the *next closest* pair of observations, include in our consideration the centroid of the cluster that we created in the preceding step. In this way we progressively join observations to clusters and, ultimately, clusters to clusters, such that we end up with everything in one mega-cluster containing all observations. This generates a tree of relationships that we can ‘cut’ at different levels: delving down branches in order to investigate relations at a finer scale but also able to see where and when clusters merged to form larger groups.

### Configuring the process

Hierarchical clustering has relatively few parameters: as with other approaches there is a choice of distance measures and, depending on the metric chosen, a ‘method’. Because we’ve used a manifold learning approach to dimensionality reduction it is **not** appropriate to employ metrics that make strong assumptions about relationships between the data (*e.g.* cosine-based clustering would no longer work). Again, a mixture of experimentation and reading indicates that `euclidean` distance with `Ward’s` cluster quality measures is best:

```python
Z = linkage(projected[[x for x in projected.columns if x.startswith('Dim ')]], method='ward', metric='euclidean')
```

This takes about 4 minutes. Notice how we’re dynamically pulling the dimensions out of the `projected` data frame: this means that if you change the target number of dimensions during the manifold learning stage from 4 to some other number the clustering code requires no changes.

`Z` is effectively a ‘tree’ that can be cut at any level and, intuitively, in Figure 4 it is easy to trace the differences observed in Figure 3 (above) in a more subtle way: at the top level the strongest difference remains the Social/Natural Sciences division, but in principle Biology and Physics are, from an embedding standpoint, *more* dissimilar than Economics and Social Science, and there is also a strong suggestion of some large splits just beneath this level. The number of observations in each of the clusters at the bottom of Figure 4 is given in parentheses; a number without parentheses would mean an original observation index.

**Figure 4. Top of EThOS dendrogram showing last 100 clusters**

![Cluster Dendrogram (truncated)](./images/Dendrogram-euclidean-100.png)

Although the dendrogram shows a top-down view, recall that this is _not_ how the clustering was performed. To develop a slightly more nuanced sense of what has happened it is helpful to peek inside the `Z` object and we can look at what happened on 1$^{st}$, 10,000$^{th}$, c.46,000$^{th}$, and final iterations of the algorithm. On the first iteration, observations 24,351 and 26,744 were merged into a cluster of size 2 ($\sum c_{i}, c_{j}$) because the distance ($d$) between them was effectively 0.000. On the last iteration, clusters 97,384 and 97,385 were merged  to create one cluster of 48,694 records. That is the ‘link’ shown at the very top of the dendrogram.

**Table 6. Selections from hierarhical linkage object showing cluster merges at various iterations**

| Iteration | $c_{i}$ | $c_{j}$ |  $d_{ij}$ | $\sum{c_{i},c_{j}}$ |
| --------: | ------: | ------: | --------: | ------------------: |
|         0 |  24,351 |  26,744 |     0.000 |                   2 |
|    10,000 |  34,987 |  39,085 |     0.044 |                   2 |
|    46,693 |  92,778 |  93,832 |     0.799 |                  26 |
|    48,692 |  97,384 |  97,385 | 1,483.851 |              48,694 |

So at iteration 0 observations 24,351 and 26,744 are merged into a cluster of size 2. At iteration 10,000 we’re performing another merge of individual observations (though this does not mean that larger merges haven’t already occurred!). Iteration 46,693 is a merge of two clusters to form a larger cluster of 26 observations: we can see this because $c_{i}$ and $c_{j}$ *both* have higher indices than there are data points in the sample. Notice too how the merge distance $d_{ij}$ is increasing, to the point where, by the final step, the distance is enormous compared to the first or ten-thousandth steps.

### Sample output

The output above was created by manually interrogating the `Z` clustering matrix:

```python
table = []

# Take the 1st, 10000th, '-2000th', and '-1st' observations
for i in [0, 10000, -2000, -1]:
    r = list(Z[i])
    r.insert(0,(i if i >= 0 else len(Z)+i))
    table.append(r)
    table[-1][1] = int(table[-1][1])
    table[-1][2] = int(table[-1][2])
    table[-1][4] = int(table[-1][4])

display(
    tabulate(table,
             headers=["Iteration","$c_{i}$","$c_{j}$","$d_{ij}$","$\sum{c_{i},c_{j}}$"],
             floatfmt='0.3f', tablefmt='html'))
```

With luck, this will help the dendrogram to make more sense, and it also provides an intuition as to how we can work with `Z` to output any number of desired clusters, cutting the tree at 2, 4, 20, … 10,000!

## Validation

One of the challenges in text classification and analysis is having a suitable baseline against which to compare results. The gold standard for this is one generated by human experts: if our automated analysis produces broadly the same results then we would consider that a ‘good result’. Fortunately, we *do* have just such an expert classification in the EThOS Data: the [Dewey Decimal Classification](https://en.wikipedia.org/wiki/List_of_Dewey_Decimal_classes) assigned by the researcher’s institution at the point of submission.

We’ve already shown the DDC classification of the selected documents above, so this section is about exploring how well the automated outputs match up against the expert inputs. One of the standard approaches in Machine Learning to quantifying the performance of a classifier model is the [Confusion Matrix](https://en.wikipedia.org/wiki/Confusion_matrix) in which:

> Each row of the [matrix](https://en.wikipedia.org/wiki/Matrix_(mathematics)) represents the instances in an actual class while each column represents the instances in a predicted class

So if the model works well, meaning that the predicted class is largely the same as the actual class, then we should have entries _only_ on the diagonal where the row and column classes are the same.  

To support this analysis we have a set of functions that work for any number of clusters. Rather than just referring to 'cluster 1' or 'cluster 20' this gives each cluster a name based on the dominant category (which we work out in a separate function) given by the DDC name. This is why we need to pass in the DDC 'level'.
```python
# Label the clusters in a data fraame -- note assumption
# about how the cluster field in the data frame is named.
def label_clusters(src_df:pd.DataFrame, clusterings:np.ndarray, ddc_level:int=1):

    # How many clusters?
    num_clusters = clusterings.max()

    # Turn the clustering result into a data frame
    tmp = pd.DataFrame({f'Cluster_{num_clusters}':clusterings}, index=src_df.index)

    # Join it to the source
    joined_df = src_df.join(tmp, how='inner')

    # Get the labels for each cluster and attach
    # it as a new column to the data frame
    labels = get_dominant_cat(joined_df, clusterings.max(), ddc_level)
    joined_df[f'Cluster_Name_{num_clusters}'] = joined_df[f'Cluster_{num_clusters}'].apply(lambda x: labels[x])

    return joined_df
```

We can use the DDC to give a working name to each cluster based on the modal DDC class. If you had an equally split cluster then this could be unstable and, at the limit, you could have a class that has well under 10% of the total observations in a cluster _still_ driving the name of the cluster. This should be relatively uncommon but care should be taken in interpreting the results. Note that we also have to deal with the issue that a DDC category might dominate more than one cluster: to deal with this we add a number to duplicate labels (e.g. History 1, History 2, ...)
```python
# Give a working name to each cluster
# based on the modal DDC class.
def get_dominant_cat(clustered_df:pd.DataFrame, num_clusters:int, ddc_level:int=1):
    labels = {} # Final labels
    struct = {} # Structure of clusters

    # First, work out the dominant group in each cluster
    # and note that together with the cluster number --
    # this gives us a dict with key==dominant group and
    # then one or more cluster numbers from the output
    # above.
    for cl in range(1,num_clusters+1):

        # Identify the dominant 'domain' (i.e. group by
        # DDC description) using the value counts result.
        dom     = clustered_df[clustered_df[f'Cluster_{num_clusters}']==cl][f'ddc{ddc_level}'].value_counts().index[0]
        print(f"Cluster {cl} dominated by {dom} theses.")

        if struct.get(dom) == None:
            struct[dom] = []

        struct[dom].append(cl)

    # Next, flip this around so that we create useful
    # cluster labels for each cluster. Since we can have
    # more than one cluster dominated by the same group
    # we have to increment them (e.g. History 1, History 2)
    for g in struct.keys():
        if len(struct[g])==1:
            labels[struct[g][0]]=g
            #print(f'{g} maps to Cluster {struct[g][0]}')
        else:
            for s in range(0,len(struct[g])):
                labels[struct[g][s]]=f'{g} {s+1}'
                #print(f'{g} {s+1} maps to Cluster {struct[g][s]}')
    return labels
```

We also need to be able to create a silhouette plot for an arbitrary number of clusters — this code is fairly straightforward, we just moved it to a function to allow us to reproduce several different silhouette plots rather than duplicating the code.
```python
# Create a silhouette plot for an arbitrary number of clusters.
def plt_silhouette(src_df:pd.DataFrame, clusterings:np.ndarray) -> plt:

    # We don't know how many clusters there are until we ask
    num_clusters = clusterings.max()
    # Get the silhouette values for each observation
    sample_silhouette_values = silhouette_samples(src_df, clusterings)

    # Generate a colormap based on the number of clusters
    scale = cm.get_cmap(get_scale_nm(num_clusters)).colors

    # Create the figure
    fig, ax = plt.subplots(1,1,figsize=(10,7));
    y_lower = 10
    mx = clusterings.min()

    for cl in range(1,clusterings.max()+1):

        # Aggregate the silhouette scores for samples belonging to
        # cluster i, and sort them.
        ith_cluster_silhouette_values = sample_silhouette_values[clusterings==cl]
        ith_cluster_silhouette_values.sort() # Note, returns None!
        y_upper = y_lower + ith_cluster_silhouette_values.shape[0]

        ax.fill_betweenx(
            np.arange(y_lower, y_upper),
            0,
            ith_cluster_silhouette_values,
            facecolor=scale[cl],
            edgecolor=scale[cl],
            alpha=1.0,
        )

        # Label the silhouette plots with their cluster numbers at the middle
        ax.annotate(f'Cluster {cl}',
            xy=(np.min(sample_silhouette_values), y_lower + 0.5 * ith_cluster_silhouette_values.shape[0]),
            textcoords='data', horizontalalignment='left', verticalalignment='top')

        # Compute the new y_lower for next plot
        y_lower = y_upper + 10  # 10 for the 0 samples

    ax.set_title(f"Silhouette Plot for {num_clusters} Clusters", fontsize=14);
    ax.set_xlabel("Silhouette coefficient values")
    ax.set_ylabel("")
    ax.set_yticks([])  # Clear the y-axis labels / ticks

    return ax
```

Finally, we also need to create a colormap for a given number of clusters. We use the qualitative scales (tab10, tab20) where possible since the number of the cluster has no meaning (Cluster 4 and 5 are not 'closer' than Cluster 4 and 14). We can generate a colormap for more than 20 clusters but we'd suggest that this is going to be very hard to interpret meaningfully.
```python
# Create a colormap for a given number of clusters.
def get_scale_nm(num_clusters:int):
    if num_clusters <= 10:
        return 'tab10'
    elif num_clusters <= 20:
        return 'tab20'
    else:
        print("More than 20 clusters, this is hard to render meaningfully!")
        cmap = cm.get_cmap('Spectral', num_clusters)
        return cmap(np.linspace(0,1,cmap.N))
```

With these functions we can now produce a set of outputs that will allow us to understand the quality of the hierarchical clustering output in greater detail.

### 2 Clusters

As a first step, the easiest thing to test is how well hierarchical clustering separates the Science/Social Science split that provided the core rationale for our sample selection. So at this level we are working with just 2 well-separated clusters (look back to Figure 3) and we’d expect a strong result:

```python
num_clusters = 2
ddc_level = 1
```

We now make use of the functions above, but first have to extract a ‘clustering’ from the `Z` object using `fcluster`, the desired number of clusters (`num_clusters`) and a criterion (we want `maxclust` which means produce exactly `num_clusters`):

```python
# Extract {num_clusters} from the Z object
clusterings  = fcluster(Z, num_clusters, criterion='maxclust')

# Plot silhouette
ax = plt_silhouette(projected[[x for x in projected.columns if x.startswith('Dim ')]], clusterings)
f = ax.get_figure()
# Uncomment to save the output
#plt.savefig(os.path.join('data',f'Silhouette-c{num_clusters}.png'), dpi=150)
plt.show();

# Label clusters and add to df
clustered_df = label_clusters(projected, clusterings, ddc_level=ddc_level)
```

The silhouette plot shows largely what we’d expect:

![2-Cluster Silhouette Plot](./images/Silhouette-c2.png)

#### Confusion matrix

But we can also investigate this result in a more nuanced way using something called the Confusion Matrix and Classifiction Report. Recall that the DDC plot in Figure 3 shows some Social Science theses clearly mapped on to the Science-like space. Here we make use of the derived cluster label to compare the DDC label to the cluster-derived one!

```python
# Classification report gives a (statistical) sense of power (TP/TN/FP/FN)
print(classification_report(clustered_df[f'ddc{ddc_level}'], clustered_df[f'Cluster_Name_{num_clusters}']))

# A confusion matrix is basically a cross-tab without totals,
# which I think are nice to add
pd.crosstab(columns=clustered_df[f'Cluster_Name_{num_clusters}'],
            index=clustered_df[f'ddc{ddc_level}'],
            margins=True, margins_name='Total')
```

At the top level, the expert-assigned DDC and automated cluster values line up extraordinarily well:

**Table 7. Confusion matrix for top-level DDC classes and clusters**

|                         | Science Cluster | Social Sciences Cluster | Total  |
| ----------------------: | --------------: | ----------------------: | ------ |
|         **Science DDC** |          26,591 |                     479 | 27,070 |
| **Social Sciences DDC** |             676 |                  20,948 | 21,624 |
|               **Total** |          27,267 |                  21,427 | 48,694 |

In other words, just 1.8% of the records classified as ‘Science’ were misclassified as Social Sciences in our automated analysis ($479/27,070$), and 3.1% of theses classified by librarians as being from the Social Sciences were assigned to the Science cluster ($676/21,624$).

#### Classification report

The confusion matrix can then be used as the basis for calculating [precision and recall](https://en.wikipedia.org/wiki/Precision_and_recall) values. Precision is $T_{P} / (T_{P}+F_{P})$, where $T_{P}$ is the number of correctly-predicted observations (true positives), and $F_{P}$ is the number of incorrectly-predicted observations (false positives) in that class. Recall measures something slightly different: $T_{P}/(T_{P}+F_{N})$ where $F_{N}$ is the number of observations  falsely  assigned to *other* classs (false negatives). For the 2-cluster formulation above this yields a precision and recall (averaged over the two classes) of 0.98. Accuracy is calculated as $(T_{P} + T_{N})/(T_{P} + T_{N} + F_{P} + F_{N})$ and is also 0.98.

|                 | precision | recall | f1-score | support |
| --------------- | --------- | ------ | -------- | ------- |
| Science         | 0.98      | 0.98   | 0.98     | 27070   |
| Social sciences | 0.98      | 0.97   | 0.97     | 21624   |
| accuracy        |           |        | 0.98     | 48694   |
| macro avg       | 0.98      | 0.98   | 0.98     | 48694   |
| weighted avg    | 0.98      | 0.98   | 0.98     | 48694   |

In short: using nothing more than a short abstract and title for a PhD thesis we’ve been able to correctly classify them into Social and Physical sciences with 98% accuracy!

### 4 Clusters

What happens as we begin to drill down into the DDC classes? At the next step we have 4 classes: Biology, Economics, Social Sciences, and Physics. We will skip the code, but you could simply copy+paste the the preceding code block in order to generate the outputs.

```python
num_clusters = 4
ddc_level = 2
```

In the confusion matrix we are again looking for values that are ‘off’ the diagonal as an indicator of poor or declining clustering performance:

**Table 8. Confusion matrix for 2nd level DDC classes and clusters**

|            Expert Class | Biology Cluster | Economics Cluster | Physics Cluster | Social sciences Cluster | Total  |
| ----------------------: | --------------: | ----------------: | --------------: | ----------------------: | ------ |
|         **Biology DDC** |          17,498 |               214 |             514 |                     178 | 18,404 |
|       **Economics DDC** |             417 |            11,063 |              79 |                   1,050 | 12,609 |
| **Social sciences DDC** |             230 |                45 |           8,349 |                      42 | 8,666  |
|         **Physics DDC** |             165 |             1,880 |              15 |                   6,955 | 9,015  |
|               **Total** |          18,310 |            13,202 |           8,957 |                   8,225 | 48,694 |

Clearly, clustering is still performing well: although accuracy has fallen to 0.90 with average precision and recall of 0.89, Biology and Phyics are more readily distinguished with precision of 0.96 and 0.95, and recall of 0.93 and 0.96, respectively. This squares nicely with the intuition developed from looking at the UMAP embedding in Figure 3 above where we saw much greater overlap between the selected social science DDCs than the selected science DDCs. This effect neatly encapsulates one of the advantages to this approach: the visualisation, clustering, and validation results all reinforce one another, giving us confidence that what we’re seeing isn’t simply an artefact of the data or sheer good luck.

### Are the experts ‘wrong’?

Ordinarily, we’d take the expert classification as the defining measure of our results: if the expert labelled the observation as $x$ then $x$ it is! However, in the case of a PhD thesis it’s worth questioning the assumption that it is the *algorithm* that is incorrect! Let’s put it another way: we are assuming that time-pressured, resource-constrained librarians will be able to glance at an abstract and *always* select the most appropriate DDC. Moreover, in a real-world situation the ‘expert’ might be influenced by ‘extraneous’ factors such as the department in which the PhD student is enroled or the history of DDCs assigned by an institution.

So while most Machine Learning research would treat the ‘off-diagonals’ as an error to be solved, we might reasonably ask whether these theses have been correctly classified in the first place. Although there are more strictly [‘correct’ ways to perform class-based TF/IDF analyses](https://github.com/MaartenGr/cTFIDF/blob/master/ctfidf.py), we can get a sense of what distinguishes the theses that were ‘misclassified’ by comparing their vocabularies to those where the DDC and cluster assignment align. This can be done using a TF/IDF vectoriser where we `fit` the vectoriser on the DDC-corpus (_e.g._ all observations classed as Biology), and then transform the observations assigned to *other* Clusters (_e.g._ those records that we clustered with Physics, Economics, and the Social Sciences instead).

For this we need to recover the tokens from earlier:

```python
df = pd.read_csv(os.path.join('data','ph-tutorial-data-embeddings.csv.gz')).set_index('EThOS_ID')
df['tokens'] = df.tokens.apply(ast.literal_eval)
```

We then find it easier to create a ‘misclassified’ data frame:

```python
misc = fdf[fdf[f'ddc{ddc_level}'] != fdf[f'Cluster_Name_{num_clusters}']]

print(f"There are {misc.shape[0]:,} ({(misc.shape[0]/fdf.shape[0])*100:0.1f}%) 'misclassified' theses.")
print()
misc.groupby(by=f'ddc{ddc_level}')[f'Cluster_Name_{num_clusters}'].value_counts()
```

This produces:

```bash
There are 4,829 (9.9%) 'misclassified' theses.

ddc2             Cluster_Name_4
Biology          Physics             514
                 Economics           214
                 Social sciences     178
Economics        Social sciences    1050
                 Biology             417
                 Physics              79
Physics          Biology             230
                 Economics            45
                 Social sciences      42
Social sciences  Economics          1880
                 Biology             165
                 Physics              15
```

From this we can also produce word clouds using a TF/IDF vectoriser. This approach is less technically sophisticated and robust than the one set out in Maarten Grootendorst's [CTFIDF](https://github.com/MaartenGr/cTFIDF/blob/master/ctfidf.py) module (as developed in [topic modelling with BERT](https://towardsdatascience.com/topic-modeling-with-bert-779f7db187e6) and [class-based TF/IDF](https://towardsdatascience.com/creating-a-class-based-tf-idf-with-scikit-learn-caea7b15b858)), but it saves having to install *_another_* module and produces output that is easier to align with the needs of the WordCloud library.

```python
tfidfs = {}

# A few basic stopwords that crop up a _lot_ despite earlier filtering
stopw = ['study','examine','analysis','system','use','design','model','data','within']

# We're working with the tokens so there's no n-gram range
vec = TfidfVectorizer(use_idf=True, ngram_range=(1,1), smooth_idf=True, stop_words=stopw)

for d in fdf[f'ddc{ddc_level}'].unique():

    print(f"Examining {d} DDC")
    tfidfs[d] = []

    # All records classified under this DDC
    ddc_df = fdf[fdf[f'ddc{ddc_level}']==d].copy()

    # Those records that are part of this DDC
    # but were clustered with *another* group
    # going by the dominant class in that cluster.
    sub_df = misc[misc[f'ddc{ddc_level}']==d].copy()

    print(f"  ddc_df: {ddc_df.shape[0]:>7,}")
    print(f"  sub_df: {sub_df.shape[0]:>7,}")
    print(f"  remain: {ddc_df[~ddc_df.index.isin(misc.index)].shape[0]:>7,}")

    print(f"  {(sub_df.shape[0]/ddc_df.shape[0])*100:0.1f}% of {d} PhDs were clustered in other disciplines.")

    # This removes the 'Biology 2', 'Biology 1' distinction for example.
    # You would normally only encounter this working with DDC3.
    sub_df.loc[:,'Cluster Name'] = sub_df[f'Cluster_Name_{num_clusters}'].str.replace("\s\d+$","",regex=True)

    # Convert tokens back to string
    # And fit the corpus using IDF
    corpus  = ddc_df.tokens.str.join(' ').fillna(' ').values
    vec.fit(corpus)

    # One image per DDC Category
    f,axes = plt.subplots(1, len(sub_df['Cluster Name'].unique()), figsize=(14,5))

    for i, cl in enumerate(sub_df['Cluster Name'].unique()):

        sub_cdf = sub_df[sub_df['Cluster Name']==cl]
        print(f"  PhDs classified as {cl} ({sub_cdf.shape[0]:,})")

        tcorpus = vec.transform(sub_cdf.tokens.str.join(' ').fillna(' ').values)

        tfidf   = pd.DataFrame.from_records(tcorpus.toarray(), index=sub_cdf.index, columns=vec.get_feature_names_out())
        tfterms = tfidf.T.sum(axis=1)

        tfidfs[d].append(
            pd.DataFrame(
              {f"{cl} Term":  tfterms.sort_values(ascending=False).index,
               f"{cl} Value": tfterms.sort_values(ascending=False).values}
            )
        )

        #print(tfterms.sort_values(ascending=False).head(5))
        #print()

        Cloud = WordCloud(background_color=None, mode='RGBA', relative_scaling=0.5, font_path=fp)

        ax = axes.flatten()[i]
        ax.set_title(f"{d} clustered with {cl} ($n$={sub_cdf.shape[0]:,})")
        ax.imshow(Cloud.generate_from_frequencies(tfterms))
        ax.axis("off")

    plt.tight_layout()
    # Uncomment to save the output
    #plt.savefig(os.path.join('images',f"DDC_Cloud-c{num_clusters}-ddc{d}-tfidf.png"), dpi=150)
    plt.show()

print("Done.")
```

With four DDCs we have 12 plots in total: one for each misclassification pairing. While the TF/IDF plots are not, in and of themselves conclusive with respect to the assignment of any _one_ thesis, it does help us to get to grips with the aggregate differences: in each case we see vocabularies from another discipline (*e.g.* the physics of energy) employed in the service of the DDC-assigned discipline (*e.g.* Economics).

**Figure 5. TF/IDF word clouds for ‘misclassified’ theses by DDC1 group**![Misclassified Biology DDC](./images/DDC_Cloud-c4-ddcBiology-tfidf.png)

![Misclassified Economics DDC](./images/DDC_Cloud-c4-ddcEconomics-tfidf.png)

![Misclassified Physics DDC](./images/DDC_Cloud-c4-ddcPhysics-tfidf.png)

![Misclassified Social Science DDC](./images/DDC_Cloud-c4-ddcSocial sciences-tfidf.png)

### 15 Clusters

Finally, we can also give the clustering process greater importance and simply use the DDC as support for labelling the resulting outputs. Taking the same approach as above, we compare a cluster to the overall corpus in order to make sense of how it differs from the ‘baseline’ distribution of words. As with the [PCA tutorial](https://programminghistorian.org/en/lessons/clustering-with-scikit-learn-in-python#3-dimensionality-reduction-using-pca), we use a [scree plot](https://programminghistorian.org/en/lessons/clustering-with-scikit-learn-in-python#3-dimensionality-reduction-using-pca) (the code for this is available in [GitHub]()) to work out the optimal number of clusters though, as we’ve seen, expert opinion could equally easily generate a viable configuration. The combination of the scree plot and [`kneed`](https://kneed.readthedocs.io/en/stable/) utility pointed to an optimal clustering in the range of 13–18, so we opted for 15 clusters and assigned each cluster the name of its *dominant* DDC3 group.

In some cases this automated approach yields more than one cluster with the same dominant DDC: Biochemistry and Physics dominate 3 clusters each, while ‘Culture and Institutions’ and ‘Financial Economics’ (amongst others) each only predominate in one. The word clouds give a sense of how these clusters differ in terms of content though, obviously, some care should be taken in assuming clear separation between, for example, ‘Production 1’ and ‘Production 2’ in terms of content. We don’t show the code for this analysis here, but it’s available in the source notebook [on GitHub]().

**Figure 6. TF/IDF word clouds for 15-cluster classification (name from dominant DDC3 group)**

![15 Cluster Result](./images/Word_Cloud-c15-tfidf.png)

The hierarchical approach means, of course, that we can further unpack these results by selecting the Biochemistry 2 cluster and exploring what characterises the documents in that cluster as well as how it maps (or doesn’t) on to the expert classification. We could use the `Z` linkage object to separate out documents that are a poor fit for a cluster from those that are not, to examine how a cluster evolves over time, or to trace the contours of a sub-field based on its footprint in the embedded projection. This opens up exciting new opportunities for future work…

## Summary

We hope that this tutorial has illustrated some of the potential power of combining the word embedding algorithm with recent developments in manifold learning. In our work with the British Library, we expect these outputs to advance both our own research and the mission of the BL in useful ways:

1. **Filling in missing metadata**: because of the way the data was created, many of the records in the BL’s EThOS data set lack DDC values and keywords. The WE+UMAP approach allows us to *suggest* what those missing values might be! We can, for instance, use the dominant DDC from an unlabelled observation’s cluster to achieve this for missing DDCs, and the class- or document-based TF/IDF to suggest keywords.
2. **Suggesting similar works**: the BL’s current search tool uses stemming and simple expression matching to search for works matching the user’s query. While using singular terms to retrieve related documents is not as straightforward as one might imagine, asking the computer to find documents similar to *a selected target* (_i.e._ find me similar works… as offered by Google) would significantly enhance the utility of the resource to researchers in all disciplines.
3. **Examining the spread of knowledge**: although we have not made use of the publication date and institutional fields in this tutorial, we are using these in conjunction with word2vec and other models to examine links between how and where new ideas arise, and how and when they spread geographically within disciplines. Our expectation is that this will show significant disciplinary and geographical variation—even within the U.K.—and we hope to start reporting our findings in the near future.

## Bibliography & Other Readings

### Other Relevant Tutorials

Other relevant tutorials include:

- [Analyzing Documents with TF-IDF](https://programminghistorian.org/en/lessons/analyzing-documents-with-tfidf)
- [Introduction to Jupyter Notebooks](https://programminghistorian.org/en/lessons/jupyter-notebooks)
- [Corpus Analysis with Antconc](https://programminghistorian.org/en/lessons/corpus-analysis-with-antconc)
- [Installing Python Modules with `pip`](https://programminghistorian.org/en/lessons/installing-python-modules-pip)
- [Keywords in Context (Using *n*-grams) with Python](https://programminghistorian.org/en/lessons/keywords-in-context-using-n-grams)

### Bibliography

- British Library (2015), *Living Knowledge*, British Library, URL: &lt; https://www.bl.uk/britishlibrary/~/media/bl/global/projects/living-knowledge/documents/living-knowledge-the-british-library-2015-2023.pdf &gt;.
- Mikolov, T. and Yih, S. W. and Zweig, G. (2013), “Linguistic Regularities in Continuous Space Word Representations”, *Proceedings of the 2013 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies (NAACL-HLT-2013)*, URL: &lt; https://www.microsoft.com/en-us/research/publication/linguistic-regularities-in-continuous-space-word-representations/ &gt;
- Tobler, W. R. (1970), “A computer movie simulating urban growth in the Detroit region”, *Economic Geography*, 46:234–240.
- Tshitoyan, V. and Dagdelen, J. and Weston, L. and Dunn, A. and Rong, Z. and Kononova, O. and Persson, K. A. and Ceder, G. and Jain, A. (2019), “Unsupervised word embeddings capture latent knowledge from materials science literature”, *Nature* 571:95–98.
