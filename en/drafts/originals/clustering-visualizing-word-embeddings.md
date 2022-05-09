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

1. An appreciation of how computers convert words into vectors—called ‘word embeddings’—that capture the context in which words appear.
2. The ability to generate these word embeddings using the word2vec algorithm on a corpus of 50,000 PhD abstracts.
3. The ability to use dimensionality reduction to reveal structure in the data.
4. The ability to use hierarchical clustering  to group similar documents within the corpus.

## Introduction

This tutorial will introduce you to word embeddings (WEs) and manifold learning, which will help us to find and explore structure in a corpus of nearly 50,000 short texts using an  *unsupervised* approach: we do not make use of keywords or existing classifications, relying entirely on the title and abstract provided by a doctoral candidate’s home institution at the time they completed their research. Both techniques are much more computationally demanding than their predecessors—(very) broadly, [Latent Direchlect Analysis](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet) and [PCA](https://programminghistorian.org/en/lessons/clustering-with-scikit-learn-in-python#3-dimensionality-reduction-using-pca)—but the benefit is significantly more powerful methods for analysing both individual texts and whole corpora. 

A [standalone Jupyter notebook](https://github.com/jreades/ph-word-embeddings/blob/main/Embeddings.ipynb) that can be [run in Google Colab](https://colab.research.google.com/github/jreades/ph-word-embeddings/blob/main/Embeddings.ipynb) is available on [GitHub](https://github.com/jreades/ph-word-embeddings).

## Overview

Term Frequency/Inverse Document Frequency ([TF/IDF](https://en.wikipedia.org/wiki/Tf%E2%80%93idf)) analysis is a useful and intuitive way to tackle the problem of classifying documents based on their distinctive vocabularies. As detailed [in this Programming Historian tutorial](https://programminghistorian.org/en/lessons/analyzing-documents-with-tfidf#how-the-algorithm-works), we essentially divide the number of times a word appears in a document, by the inverse of the number of times the word appears in all documents in the corpus. Common words then end up with a TF/IDF score close to 0, while distinctive ones receive a score close to 1. 

We can arrange these into a term-document matrix: a table where each document is a row, and each term (or word, if your prefer) is a column. Documents that have similarly distinct vocabularies (*e.g.* those that talk about black holes or those that are about Bourdieu) will end with similar row values and that’s how we can group them together. TF/IDF is therefore a straightforward ‘bag of words’ approach: treating every word in isolation from its context makes it easy to calculate scores but hard to see connections. 

By throwing away the context, however, we lose the link that even a child might make between, say, “the King ruled for 20 years” and “the Queen ruled for 30 years”. Word embeddings — of which the word2vec algorithm used below is an example — capture that relationship because they incorporate information about the words that surround the ‘target’ (King or Queen). As it’s often put in tutorials on the method: ‘you shall know a word by the company it keeps’. Word embedding algorithms use this to inform how a term is converted to a vector (the ‘vec’ in word2vec); so instead of using a single number to ‘score’ a term, it is now represented by a much longer sequence of numbers which is common to the corpus. 

The vector encodes information about the term’s most frequently-used contexts, and this allows us to do all sorts of interesting things—finding synonyms, working out *mathematically* that a Queen is *like* a King, or grouping documents without keywords—that aren’t possible with the simpler frequency approaches such as TF/IDF. With that in mind, let’s review the lesson structure:

- The importance of how texts are cleaned cannot be underestimated and we think it’s *essential* that you consider how the choices that we—and you—make here impact *everything* that comes afterwards. We filter out low- and high-frequency terms that do not help us to distinguish *between* records but your own needs might be quite different!
- We briefly discuss the Term Co-occurrence Matrix (TCM) because it underpins how ‘context’ can be learned by a computer. In most programming libraries you do *not* need to calculate this yourself, but some algorithms (*e.g.* [R’s implementation of GloVe](https://cran.r-project.org/web/packages/text2vec/vignettes/glove.html)) *will* require you to call a function to do exactly this before you can start to learn the word embeddings.
- The embedding process is ‘where the magic happens’ to produce useful word vectors that can be manipulated mathematically. These support adding/subtracting words from one another to explore relationships between terms (e.g. *King-Man+Woman…*), but here we average the word vectors together to produce a document representation.
- However, the embedding space is still too ‘high-dimensional’ for most clustering algorithms, so we need to reduce this further using dimensionality reduction techniques. We introduce UMAP, which a kind of ‘manifold learning technique’ that out-performs Principal Components Analysis (PCA) for our purposes.
- Finally, we show how hierarchical clustering is a good choice for some types of text clustering problems because its bottom-up approach allows us to flexibly ‘cut’ the data at multiple levels.

Let’s now put this understanding into practice…

## Case Study: E-Theses Online

This tutorial uses a bibliographic corpus managed by the [British Library](https://www.bl.uk/) (BL) to enhance public access to doctoral research. [*E-Theses Online*](https://ethos.bl.uk/) (EThOS, hereafter) provides metadata—which is to say, data *about* a PhD, *not* the data *of* the PhD—such as Author, Title, Abstract, Keywords, [Dewey Decimal Classification](https://en.wikipedia.org/wiki/Dewey_Decimal_Classification) (DDC), etc. Most users of EThOS will search this metadata using the BL’s web interace and end up looking at individual documents (see Figure 1); however, in aggregate, [the data](https://bl.iro.bl.uk/catalog?locale=en&q=%22UK+Doctoral+Thesis+Metadata+from+EThOS%22&search_field=all_fields&sort=year_published_isi+desc&_ga=2.85833567.757719569.1646905901-495121888.1646905901) provide a unique perspective on U.K. Higher Education.

{% include figure.html filename="images/clustering-visualizing-word-embeddings/EThOS.png" caption="EThOS Web Interface for an Individual Metadata Record" %}

In the terminology of the BL, EThOS is ‘[living knowledge](https://www.bl.uk/britishlibrary/~/media/bl/global/projects/living-knowledge/documents/living-knowledge-the-british-library-2015-2023.pdf)’ (British Library 2015) which is to say that not only is constantly growing as students complete their research and become newly-minted PhDs, but it also constantly evolving in terms of what fields are captured and how reliably they are filled in by librarians at the student’s host institution (see ‘[Completeness](https://github.com/jreades/ph-word-embeddings/blob/main/Supplementary_Materials.md#completeness)’ in the [Supplementary Materials](https://github.com/jreades/ph-word-embeddings/blob/main/Supplementary_Materials.md)). The full data set currently stands at more than 500,000 records and is available for download [via DOI](https://bl.iro.bl.uk/concern/datasets/c815b271-09be-4123-8156-405094429198). 

### Selection

The Dewey Decimal Classification field, however, is not normally included and we have therefore agreed with the BL to share a large subset of ca. 50,000 records that includes this attribute. We did not pick these at random: we used the DDC to select a sample that we expected would challenge automated text-analysis and classification. So the data contain four ‘divisions’ from two ‘classes’: Physics and Biology from Science (DDC 500–599), and Economics and the Social Sciences from Social Sciences (DDC 300–399). The count of theses from each DDC-group is shown in Table 2, and note that the counts are (deliberately) unbalanced to some extent with one group dominating in each class.

**Table 2. Selected Records from EThOS Dataset**

| DDC1 Group (‘Class’)          | DDC2 Group (‘Division’)   |      Count |
| :---------------------------- | :------------------------ | ---------: |
| **Science (500–599)**         |                           | **27,095** |
|                               | Biology (570–579)         |     18,418 |
|                               | Physics (530–539)         |      8,677 |
| **Social Sciences (300–399)** |                           | **21,648** |
|                               | Economics (330–339)       |     12,625 |
|                               | Social Sciences (300–309) |      9,023 |
| **Total**                     |                           | **48,743** |

So if the clustering and visualisation that we do later in this lesson fail to reproduce any of the distinctions shown in Table 2, then this would suggest it’s better to stick with TF/IDF. But if, instead, we see that the computer is able to reproduce the finer-grained structure based on nothing more than a Title and Abstract, then that would suggest a significant improvement. 

## Prerequisites

This article can be seen as building on, and responding to, the [Clustering with Scikit-Learn in Python](https://programminghistorian.org/en/lessons/clustering-with-scikit-learn-in-python) tutorial available on this site. Like Thomas, we are interested in applying clustering algorithms with Python to textual data ‘in order to discover thematic groups’. Contrasting these two tutorials will allow you to develop a broader understanding of the Natural Language Processing (NLP) landscape, and the most important differences between these tutorials are:

1. The use of word2vec instead of TF/IDF;
2. The use of UMAP instead of PCA for dimensionality reduction; and
3. The use of hierarchical instead of *k*-means clustering.

These steps allow us to convert each document to a point that can be plotted on a graph and grouped together based on their proximity to other documents. 

### Required Libraries

We have provided a [Google Colab notebook](https://colab.research.google.com/github/jreades/ph-word-embeddings/blob/main/Embeddings.ipynb) that allows you to run all of the code in this tutorial without needing to install anything on your own computer. However, if you wish to run the code locally then, in addition to the core ‘data science’ libraries of `numpy`, `pandas`, and `seaborn`, you will need to install several more specialised libraries:

- For the derivation of Word Embeddings you will need [`gensim`](https://radimrehurek.com/gensim/)
- For the dimensionality reduction you will need [`umap-learn`](https://umap-learn.readthedocs.io/en/latest/)
- For the hierarchical clustering and visualisastion you will need [`scipy`](https://scipy.org/), [`scikit-learn`](https://scikit-learn.org/stable/),  [`kneed`](https://kneed.readthedocs.io/en/stable/), and [`wordcloud`](https://amueller.github.io/word_cloud/generated/wordcloud.WordCloud.html).
- The [`tabulate`](https://github.com/astanin/python-tabulate) library is required to run one block of code that produces a table, but this can be skipped without impacting the rest of the tutorial.

Most of these are available via Anaconda Python’s `conda` utility and can be installed via, for example, `conda -c conda-forge install gensim`, but some may only have `pip` installers and will need to be installed using, for example, `pip install kneed`.

If you are [using the standalone notebook](https://github.com/jreades/ph-word-embeddings/blob/main/Embeddings.ipynb) and wish to save the intermediate files then it will also be necessary to install `feather` ([feather-format`](https://github.com/wesm/feather) for installation purposes) so that pandas can read/write feather files. Feathers allow fast data interchange between R and Python, and they preserve data structures, such as lists, in a way that CSV files cannot. A [Docker](https://www.docker.com/) image is also available and instructions can be found [on GitHub](https://github.com/jreades/ph-word-embeddings/tree/main/docker). 

Once the libraries are installed, we import them as follows:

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
from sklearn.metrics import silhouette_score, silhouette_samples
from kneed import KneeLocator
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

For the WordClouds we change the default Matplotlib font to one called “Liberation Sans Narrow” by finding its ‘font path’ (`fp`) in our system:

```python
fp = '/usr/share/fonts/truetype/liberation/LiberationSansNarrow-Regular.ttf'
```

You can find out what fonts are available on *your* system using:

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

# An initial data transformation from text to tokens
df['tokens'] = df.tokens.apply(ast.literal_eval)
```

This loads the EThOS sample into a new pandas data frame called `df`. Note that we are not using the default unicode encoding for text but the British Library’s MARC export format of `ISO-8859-1`, and we also set `low_memory=False` so that the file is fully loaded before pandas attempts to infer the column type.

It’s also worth noting what `ast.literal_eval` does: you can’t write a list directly to a CSV file, so in preparing the data for the lesson the `tokens` list was ‘interpreted’ by pandas into `"['policy', 'evaluation', 'macroeconometric', 'model', 'present', 'number', 'example', 'macroeconometric', ..., 'technique', 'new']"`. This is a list written out *as a string*, so and the `ast` library turns that back into an actual list.

Let’s begin!

## Data Cleaning

The choices made during the data cleaning phase are *crucial* to the results, but these are rarely discussed in detail. There are almost never ‘right’ answers when cleaning textual data, just the choices that best-support the kind of analysis you wish to undertake. Since that is not the focus of *this* tutorial we cannot dwell on the process here but, briefly, we employed the following steps: 1) removal of HTML and other ‘markup’, accents, possessives, punctuation, and quote-marks; 2) Named Entity Recognition using `spacy`'s [`en_core_web_lg` library](https://spacy.io/usage/linguistic-features#named-entities) and detection of acronyms using custom code applied before the text was converted to lower case; 3) lemmatisation using `nltk`'s [`wordnet` lemmatiser](https://www.nltk.org/api/nltk.stem.wordnet.html); 4) automated detection of bigrams and trigrams using `gensim`'s [`phrases` library](https://radimrehurek.com/gensim/models/phrases.html); and 5) removal of very high- and very low-frequency terms. The input to, and output from, this process are shown for randomly-selected records in Table 3.

**Table 3. Selected Source and Cleaned Text Examples**

| Source Text                                                  | Cleaned Text                                                 |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| The economic effects of resource extraction in developing countries. This thesis presents three core chapters examining different aspects of the relationship between natural resources and economic development… | economic effect resource extraction develop_country present_three core examine different_aspect relationship natural_resource economic_development… |
| Making sense of environmental governance : a study of e-waste in Malaysia. The nature of e-waste, which is environmentally disastrous but economically precious, calls for close policy attention at all levels of society, and between state and non-state actors… | making_sense environmental_governance study waste malaysia nature waste environmentally disastrous economically precious call close policy attention level society state_non_state actor… |
| An exploratory study of the constructions of 'mental health' in the Afro Caribbean community in the United Kingdom. Afro Caribbean people living in the United Kingdom have historically been overrepresented in the 'mental health' system… | exploratory_study construction mental_health caribbean community united_kingdom caribbean people_live united_kingdom historically mental_health system… |

There is _some_ reason to think that embeddings are more robust to ‘noise’ from, for example, stop words so some of the standard cleaning steps may be less important; however, we have not yet found a clear or careful investigation of the impact that *each* of these steps has in isolation or in combination. Regardless, the output of cleaning is a numerical representation of a text in which out-of-vocabulary terms are represented by `-1` and are dropped from the subsequent analysis.

## The Term Co-occurence Matrix

The Term *Co*-occurence Matrix (TCM) is how we unlock the *context* in a corpus. The TCM is simply a table—a very *big* table, as we’ll see in a moment—in which we record the results of scanning the corpus word-by-word while noting down the terms that come immediately before and/or after. Conceptually, every time we see the word ‘hat’ following the word ‘cat’, we can add 1 to the ‘cat/hat’ cell in the TCM and so, when the scan is complete, simply by looking across the ‘cat’ row we can see that ‘cat/hat’ cropped up 27 times but ‘cat/dark_matter’ was not seen at all. 

We now need to be a little more precise about what we mean by ‘context’. Word embedding algorithms use a ‘window’ around the target word that we’re interested in: if it the window only shows terms that *follow* the target then we are in the realm of predictive applications like the ones that prompt you with “or Madam” as soon as you’ve written “Dear Sir”. If the window only shows words that preceded the target then we are in the realm of corrective applications like the ones that correct “meat” to “meet” when you add a “you” afterwards. 

We’re not interested in predicting or correcting terms, we’re interested in how those words are used in Titles and Abstracts to create distinctive disciplinary vocabularies. We therefore employ a *symmetric* window of size four (so four words before and four words after the target). For completeness, we should also note that the window can be ‘weighted’—meaning that adjacent terms within the window ‘count’ for more than distant terms within the window—but we’ve used an ‘unweighted’ approach.

## Word Embeddings with Word2Vec

The TCM shows us which term combinations are *likely* and which ones are *not* but, because it records literally every *possible* word combination, it has two major drawbacks: high dimensionality and extreme sparsity. If there are 5,000 words in the corpus, there are 25 *million* entries in the TCM because the overall size is the square of the number of terms. A corpus of 25,000 terms has a TCM of more than 6 *billion* entries even though the vast majority of these entries will be zeroes because many words never co-occur! Even for modern super-computers matrices of this size are a challenge, and one of the principal benefits of the data cleaning earlier is the reduction in size of the TCM.

### How it works

What the embedding phase of the word2vec algorithm does is to work out how best to *embed* this very high-dimensional TCM (<img alt="m by m matrix" src="https://render.githubusercontent.com/render/math?math={m \times m}" />, where <img alt="m" src="https://render.githubusercontent.com/render/math?math={m}" /> is the cleaned vocabulary) into a lower-dimensional one (<img alt="m by n matrix" src="https://render.githubusercontent.com/render/math?math={m \times n}" />). Since most embeddings use between 100 and 300 dimensions, *n* is a *lot* less than *m*. If we had a cleaned vocabulary of 25,000 terms, then the TCM would contain 625 million entries (25,000 squared) but the embedded space would have just 2.5–7.5 million entries.  We now have much low(er) dimensionality *and* sparsity, so you may also see this result termed a ‘dense vector’ or ‘dense representation’.

What made the development of Word Embeddings so exciting is that they are derived in a way that supports mathematical operations. The formulation of this in the seminal paper by [Mikolov *et al*. (2013)](https://www.microsoft.com/en-us/research/publication/linguistic-regularities-in-continuous-space-word-representations/) is:

> King – Man + Woman <img alt="approximately equal to" src="https://render.githubusercontent.com/render/math?math={\approx}" /> Queen

While the maths underlying this capability is complex (and we won’t pretend to understand it fully), we can easily imagine that King/he/man and Queen/she/woman will be found in similar contexts in a set of source documents, and the embedding algorithm can therefore learn this relationship through statistical association rather than needing to be taught it explicitly. This outcome opens the way to finding synonyms and more complex relationships in an automated way: King and Emperor are likely to be ‘closer’ to one another in the embedding-space than, say, King and Peasant.

### Configuring the process

Estimating the ‘right’ number of dimensions for word embeddings is tricky: the examples we've found vary between the square and fourth root of the vocabulary. Google's [TensorFlow developers](https://developers.googleblog.com/2017/11/introducing-tensorflow-feature-columns.html) recommend <img src="https://render.githubusercontent.com/render/math?math={\sqrt[4]{V}}" />, while [Wikipedia](https://en.wikipedia.org/wiki/Word2vec#Dimensionality) indicates "between 100 and 1,000" (/ht to [Tom Hale](https://stackoverflow.com/a/55412509/4041902)). This appears to be an [area of active research commercially](https://aclanthology.org/D19-1369.pdf) (and see also [this paper](https://aclanthology.org/I17-2006/)), but working this out is far beyond the scope of this tutorial! The code below is intended to offer a *sense* of the range from which you might want to choose:

```python
# https://stackoverflow.com/a/38896116/4041902
vocab = (list(set([a for b in df.tokens for a in b])))
print(f"Data set has a vocabulary of {len(vocab):,} words")
print(f"An upper estimate of necessary vector size is {math.floor(len(vocab)**0.5)} dimensions.")
print(f"A lower estimate of the vector size is {math.ceil(len(vocab)**0.25)} dimensions.")
```
You should get a suggested range between c.15 and 150.

The initial training phase—in which a neural network ‘learns’ the word embeddings—can be quite intensive. People with neither a lot time, nor a lot of text, to work with will download *pre*-trained embeddings (*e.g.* FastText's [English embeddings](https://fasttext.cc/docs/en/english-vectors.html) and Google's [newsgroup-trained ones](https://code.google.com/archive/p/word2vec/)); these will have been developed with an enormous vocabulary (*e.g.* GloVe's [Gigaword](https://nlp.stanford.edu/projects/glove/)) to capture a wide range of variations in usage and meaning. 

Pre-trained embeddings are available for both generic and specific language domains so, for instance, ones generated [from social media sources](https://zenodo.org/record/3237458#.YmI68vPMI-Q) *should* outperform generic embeddings for, say, Twitter analysis. For our data set of titles and abstracts, we think we’ll get better results by training our *own* embeddings because academic English differs from what you’ll find in most pre-trained embeddings.

We use the following parameters:

```python
dims = 100
print(f"You've chosen {dims} dimensions.")

window = 5
print(f"You've chosen a window of size {window}.")
```

We *also* set minimum vocabulary threshold (words exceeding the maximum were filtered out during the cleaning phase) but, rather than choose a hard floor, we condition this on the size of the data set:

```python
min_v_freq  = 0.0005 # Don't keep words appearing less than 0.05% frequency
min_v_count = math.ceil(min_v_freq * df.shape[0])
print(f"With a minimum frequency of {min_v_freq} and data set of size {df.shape[0]:,} the minimum vocab frequency is {min_v_count:,}")
```

This outputs: `With a minimum frequency of 0.0005 and data set of size 48,694 the minimum vocab frequency is 25`.

### Creating a model

Because the process of calculating Word Embeddings is so expensive, we use a caching approach in which a model can be *reloaded* if the input parameters are the same as a previous run of the model. This means that you don’t need to worry about ‘losing your work’ or keeping Python running for as long as it takes you to you complete the tutorial.

```python
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

    # You may need to change 'iter' to 'epochs' 
    # and 'size' to 'vector_size' -- it depends
    # which version of Gensim you have installed
    model = Word2Vec(sentences=df.tokens.values.tolist(), size=dims, window=window, iter=200, min_count=min_v_count, seed=rs, workers=4)
    model.save(m_nm)
    print(f"    Model saved to {m_nm}")
```

The resulting `model` provides tools for interacting with the word embedding: we can take a target word, like ‘accelerator’ and look up its 100-dimensional vector. We can ask for similar words and the model will use cosine similarity to create a list of the top-*n* nearest words (*i.e.* the terms that have similar vectors)! 

To be clear: ‘similar’ words are ones that can be found in similar contexts to the target word. So if we only have documents relating to Physics then ‘accelerator’ will have something to do with particle accelerators, but if we add in documents relating to driving a car then we might also find terms like ‘brake’ or ‘clutch’ in the most similar list. So the fact that the same term is used in two quite different contexts—because: different meaning—is irrelevant. Newer algorithms *can* distinguish between these two contexts, but these are harder to train.

### Sample output

Let’s make this a little more concrete. Table 4 shows two things for three randomly-selected terms: 1) the first 3 dimensions of the 100 dimensions generated by the word embedding process; 2) the five *closest* terms. The columns of numbers are meaningless to *us*, we just wanted to show you a *bit* of a word vector looks like, but they are *not* meaningless to the word2vec algorithm: using those 100 numerical columns it can tell you that IPO (Initial Public Offering), FTSE, and LSE (London Stock Exchange) are all used in similar contexts. You can find more examples of these relationships [in the Supplementary Materials](https://github.com/jreades/ph-word-embeddings/blob/main/Supplementary_Materials.md#additional-examples-of-embeddings). 

**Table 4. Illustration of word embedding outputs and similarity**

|                    Term |     Dim 1 |     Dim 2 |     Dim 3 | Top 7 Most Similar                                           |
| ----------------------: | --------: | --------: | --------: | ------------------------------------------------------------ |
|             accelerator | -2.597380 |  0.562458 |  3.047121 | beam, cern, facility, spectrometer, beam_energy              |
|   london_stock_exchange |  0.516811 | -0.935569 |  1.090004 | ipo, ftse, stock_market, announcement, lse                   |
| national_health_service |  1.782367 | -2.309419 | -2.430357 | nhs, public_sector, emergency, public_health, developed_world |

These types of connections would be invisible—or buried in the statistical noise—to LDA or TF/IDF approaches. The potency of an expert-led embedding was demonstrated by Tshitoyan *et al.* (2019), who analyse over 3 million materials science abstracts and are able to *anticipate* the discovery of new materials by a year or more! While such commercially valuable applications may be few and far between, as a marker of just how far we have come with our ability to mine patterns from text this is extraordinarily exciting.

### From Words to Documents

We now have a 100-dimensional vector for every word in the corpus and have shown how that enables us to find similar *terms*, but how does this help us to find similar *documents*? It turns out that it is possible to *average* together the term embeddings and obtain a *useful* representation of the document as a whole. The secret of the ‘average document embedding’ is that common words effectively cancel each other out like ‘noise’, so what remains is a ‘signal’ of distinctive word choices. Consequently, even in a corpus where *everyone* is writing about, say, French medieval poetry or computer programming, the common terms affect *every* document equally and will be ‘factored out’ naturally.

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

This block of code takes the `model` created in the previous code block and passes it as an argument to the `avg_embedding` function which we `apply` to the `tokens` attribute of *every* record in the data frame. The `avg_embedding` function will use the model to look up the vector corresponding to each word (`vlkp` == ‘vector lookup’) and then averages the result by stacking the vectors.

## Dimensionality Reduction with UMAP

Even *after* generating average embeddings for the corpus, we are still  working in a 'high-dimensional' space of 100 columns that presents two problems for our attemp to group documents together:

- First, the ‘[curse of dimensionality](https://en.wikipedia.org/wiki/Curse_of_dimensionality)’ inflates the distances between documents because the Euclidean distance between them is measured (<img alt="\sqrt \sum[x_{i}^2 + x_{j}^2 + ...]" src="https://render.githubusercontent.com/render/math?math={\sqrt \sum[x_{i}^2 + x_{j}^2 + ...] }" />) and all those <img alt="x^2" src="https://render.githubusercontent.com/render/math?math={x^2}" /> really add up; and
- Second, many clustering algorithms—and traditional *k*-means is a good exemple of this—perform poorly in *exactly* these types of environments.

*One* way to address this is to select a clustering algorithm *designed* for high-dimensional spaces: [Spherical *k*-means](https://pypi.org/project/soyclustering/) would be one solution, but the more usual response is to further reduce the dimensionality of the data. 

This workhorse tool for dimensionality reducation is Principal Components Analysis (see [this introduction](https://builtin.com/data-science/step-step-explanation-principal-component-analysis) and [this review](https://royalsocietypublishing.org/doi/10.1098/rsta.2015.0202) if the [tutorial](https://programminghistorian.org/en/lessons/clustering-with-scikit-learn-in-python#3-dimensionality-reduction-using-pca) is not enough). Up to a point, principal components are fairly easy to calculate even for large data sets and their ‘meaning’ is well-understood. But the output of PCA is both linear *and* results in a loss of information because only a proportion of the observed variance in the data is retained. We keep the ‘highlights’, if you will, and potentially lose subtle but important differences at the finer scale because they look like ‘noise’.

In the 2nd case study from the [Clustering with Scikit-Learn in Python](https://programminghistorian.org/en/lessons/clustering-with-scikit-learn-in-python#second-case-study-clustering-textual-data) tutorial we see exactly this issue: PCA is applied to TF/IDF-transformed abstracts from the [Religion](https://perma.cc/P4VN-6K9K) journal as precursor to clustering articles. The tutorial correctly identifies issues with the suitability of the approach and suggests different clustering approaches and further experimentation with the input parameters to improve the results. However, our [replication of that analysis](https://github.com/jreades/ph-word-embeddings/blob/main/Comparison_to_PCA.ipynb) shows that the first ten principal components account for just 12% of the variance observed in the data. In other words 88% of the variation in the data is being lost, so it’s hardly surprising that there is little explanatory power to the poorly-fitted clusters.

### How it works

In contrast, manifold learning techniques such as [UMAP](https://en.wikipedia.org/wiki/Nonlinear_dimensionality_reduction#Uniform_manifold_approximation_and_projection) (Uniform Manifold Approximation and Projection) embed the higher-dimensional space into a lower-dimensional one in its entirety. UMAP seeks to preserve both local *and* global structure, making it more useful as a precursor to clustering. Figure 2 shows what the *Religion* data ‘looks like’ when UMAP is used to project the transformed data down into just 2 dimensions. The colours show the clusters assigned by following the tutorial’s approach.

{% include figure.html filename="images/clustering-visualizing-word-embeddings/UMAP_Output.png" caption="UMAP embedding of Religion journal abstracts" %}

We should not imagine that what we *see* after UMAP reduction is how the data actually *is*, the data has been manipulated in a non-linear way and changing the parameters can change the embedding space produced. What this does allow us to see is that, realistically, tweaking parameters for the clustering algorithm is unlikely to improve the original results: the data simply isn’t structured in a way that will permit a small number of natural clusters to emerge.

### Configuring the process

UMAP offers several distance measures for performing dimensionality reduction. Common choices would be the Euclidean, cosine and, Manhattan distances. Where there is wide variation in the number of terms in documents, the cosine distance would be a good choice because it is unaffected by magnitude: very long documents essentially get 'more votes' and so their averaged vectors are often larger in magnitude than shorter documents. While our corpus has variation, fewer than 2% of the records might be considered 'extreme' in length so we've stuck with Euclidean distance.

```python
dmeasure = 'euclidean' # distance metric
rdims    = 4 # r-dims == Reduced dimensionality
print(f"UMAP dimensionality reduction to {rdims} dimensions with '{dmeasure}' distance measure.")
```

We’ve selected four dimensions as the target manifold output: so we’re now going from 100 dimensions down to just 4!

### Reducing dimensionality

Because we’ve stored the original tokens and averaged embeddings as list-type columns, we need to do a tiny bit more work to make these columns useable. We convert the `word_vec` column into a data frame in its own right using `x_from_df`. Here, each embedding dimension because a new columns `E{dimension_number}` (so E1...E100) and the index is the `EThOS_ID` so that we can link the results back to the data.

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

UMAP uses a `fit_transform` syntax that is similar to [Scikit-Learn](https://scikit-learn.org/stable/)’s because it is intended to fill a gap in that library. The process will **normally take about 1 minute** with this sample, and the output of `dfe` shows a much-reduced dimensionality:

| EThOS_ID | Dim 1     | Dim 2    | Dim 3    | Dim 4    |
| -------- | --------- | -------- | -------- | -------- |
| 232827   | 0.058840  | 2.542224 | 7.520219 | 3.605985 |
| 232829   | 0.654654  | 3.075455 | 6.966126 | 6.365264 |
| 232830   | -0.680860 | 2.477436 | 6.685958 | 1.501117 |

With limited dimensionality most clustering algorithms will perform well, and we finish by merging the 4-dimensional data frame (`dfe`) with the original EThOS sample (`df`):

```python
projected = df.join(dfe).sort_values(by=['ddc1','ddc2'])
print(projected.columns.values)
```

### Visualising the results

The best way to get a sense of whether this was all worth it is to make a plot of the first 2 dimensions: do we see any apparently important and natural groupings in the data. Figure 3 shows two views of the data coloured by the DDC1 and DDC2 groups, respectively. It’s clear that the vocabularies of the social and physical sciences—at least, those that we selected here—differ significantly, though we should note that there _are_ nearly 50,000 points on each plot, so there is a significant risk of overplotting (two or more points occupy the same coordinates) such that some overlap is potentially hidden.

{% include figure.html filename="images/clustering-visualizing-word-embeddings/DDC_Plot.png" caption="UMAP embedding of selected EThOS data coloured by assigned DDC" %}

 Of particular note are the areas where the DDC classification does *not* appear to align: the Economics/Biology interface is intriguing (and plotting the theses by decade shows that this effect is relatively recent), as is the linkage between Physics and Biology.

If we're only going to look at the first 2 UMAP'd dimensions then why did we opt for 4 above? We've found that a (slightly) higher number of dimensions will allow more of the underlying variation in the data to be preserved, increasing the separability of clusters. Here we come to the trade-offs surrounding dimensionality: too many and we suffer the curse of dimensionality, too few and we lose the distinctiveness of the clusters! In practice, we have found 4–8 dimensions to be a good range for avoiding the issues associated with too few, or too many, dimensions.

## Hierarchical Clustering

On both a practical and a philosophical level we feel that a [hierarchical clustering](https://docs.scipy.org/doc/scipy/reference/cluster.hierarchy.html) approach is more analytically relevant to what we are doing with our PhD abstracts. First, while all PhDs are, in some sense, related to one aother as they must build on (and distinguish themselves from) what has come before. We might also agree on the existence of a high-level distinction between, say, the interests of Historians and Computer Scientists, especially when it comes to how they write about their work!

### How it works

Hierarchical clustering takes a ‘bottom-up’ approach: every document starts in its own cluster of size 1. Next, we merge the two *closest* ‘clusters’ in the data set to create a cluster of size 2. We then look for the *next closest* pair of clusters, and this search includes the centroid of the cluster of size 2 that we created in the preceding step. We progressively join documents to clusters and, ultimately, clusters to clusters, such that we end up with everything in one mega-cluster containing the entire corpus. This generates a tree of relationships that we can ‘cut’ at different levels: delving down branches in order to investigate relations at a finer scale but also able to see where and when clusters merged to form larger groups.

### Configuring the process

Hierarchical clustering has relatively few parameters: as with other approaches there is a choice of distance measures and, depending on the metric chosen, a ‘method’. Because we’ve used a manifold learning approach to dimensionality reduction it is **not** appropriate to use a cosine-based approach here. A mixture of experimentation and reading indicated that Euclidean distance with Ward’s quality measure is best:

```python
Z = linkage(
      projected[[x for x in projected.columns if x.startswith('Dim ')]], 
      method='ward', metric='euclidean')
```

This takes **about 4 minutes**, but it *is* RAM-intensive and so on Google Colab you may need to downsample the data to about 50% of the corpus (code to do this is in the [notebook](https://github.com/jreades/ph-word-embeddings/blob/main/Embeddings.ipynb)). We use the prefix `Dim` to select columns out of the `projected` data frame so that if you change the number of dimensions the clustering code does not change.

`Z` is effectively a ‘tree’ that can be cut at any level, and in Figure 4 it is easy to intuit the differences observed in Figure 3 (above): the strongest difference remains the Social/Natural Sciences division, but Biology and Physics are, from an embedding standpoint, *more* dissimilar than Economics and Social Science. There is a strong suggestion of some large splits just beneath this level. The number of observations in each of the clusters at the bottom of Figure 4 is given in parentheses; a number without parentheses would mean an original document’s index.

{% include figure.html filename="images/clustering-visualizing-word-embeddings/Dendrogram-euclidean-100.png" caption="Top of EThOS dendrogram showing last 100 clusters" %}

The dendrogram shows a top-down view, but recall that this is _not_ how the clustering was performed. You can peek inside the `Z` object to see what happened on the 1st, 10,000th, c.46,000th, and final iterations of the algorithm. On the first iteration, observations 24,351 and 26,744 were merged into a cluster of size 2 (<img alt="sum of ci and cj" src="https://render.githubusercontent.com/render/math?math={\sum c_{i}, c_{j}}" />) because the distance (_d_) between them was effectively 0.000. Iteration 46,693 is a merge of two clusters to form a larger cluster of 26 observations: we know this because <img alt="ci" src="https://render.githubusercontent.com/render/math?math={c_{i}}" /> and <img alt="cj" src="https://render.githubusercontent.com/render/math?math={c_{j}}" /> *both* have higher indices than there are data points in the sample. On the last iteration, clusters 97,384 and 97,385 were merged  to create one cluster of 48,694 records. That is the ‘link’ shown at the very top of the dendrogram and it also has a very large <img alt="dij" src="https://render.githubusercontent.com/render/math?math={d_{ij}}" /> between clusters.

**Table 6. Selections from hierarhical linkage object showing cluster merges at various iterations**

| Iteration | <img alt="ci" src="https://render.githubusercontent.com/render/math?math={c_{i}}" /> | <img alt="cj" src="https://render.githubusercontent.com/render/math?math={c_{j}}" /> |  <img alt="dij" src="https://render.githubusercontent.com/render/math?math={d_{ij}}" /> | <img alt="sum ci and cj" src="https://render.githubusercontent.com/render/math?math={\sum{c_{i}, c_{j}}}" /> |
| --------: | ------: | ------: | --------: | ------------------: |
|         0 |  24,351 |  26,744 |     0.000 |                   2 |
|    10,000 |  34,987 |  39,085 |     0.044 |                   2 |
|    46,693 |  92,778 |  93,832 |     0.799 |                  26 |
|    48,692 |  97,384 |  97,385 | 1,483.851 |              48,694 |

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

With luck, this will help the dendrogram to make more sense, and it also provides an intuition as to how we can work with `Z` to output any number of desired clusters, cutting the tree at 2, 4,  … 10,000!

## Validation

One of the challenges in text and document classification is having a suitable baseline. The gold standard for this is one generated by human experts: if our automated analysis produces broadly the same categories as the experts then we would consider that a ‘good result’. The [Dewey Decimal Classification](https://en.wikipedia.org/wiki/List_of_Dewey_Decimal_classes), which is assigned by the researcher’s institution at the point of submission, provides just such a standard.

We’ve already shown the DDC classification of the selected documents above, so this section is about exploring how well the automated outputs match up against the expert inputs. To support this analysis we have a set of functions that will work for any number of clusters; using these, rather than referring to 'cluster 1' or 'cluster 20' we give each cluster a name based on the dominant DDC category (which we work out in a separate function).

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

So each cluster's label (or name) is based on the modal DDC class. This should work well in most cases, but note that if you had cluster that was 49.9% from one DDC and 50.1% from another then we wouldn’t consider this robust and so care should still be taken in interpreting the results. Note too that a DDC might dominate more than one cluster, so to deal with this we add a number to distinguish ‘duplicates’ (e.g. History 1, History 2, ...)
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

It’s also good practice to create a silhouette plot. This function allows us to reproduce a silhouette plot for any number of clusters.
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

Finally, we also need to create a colormap for any number of clusters. We use the qualitative scales (tab10, tab20) where possible since the value of the cluster has no meaning (Clusters 4 and 5 are not ‘closer’ than Clusters 4 and 14). We can generate a colormap for more than 20 clusters but this is going to be very hard to interpret.
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

As a first step, the easiest thing to test is how well we reproduce the Science/Social Science split that provided the core rationale for our sample selection. So at this level we are working with just 2 well-separated clusters (look back to Figure 3) and we’d expect a ‘good’ result:

```python
num_clusters = 2
ddc_level = 1
```

We make use of the functions above, but first have to extract a ‘clustering’ from the `Z` object using `fcluster`, the desired number of clusters (`num_clusters`) and a criterion (`maxclust` produces exactly `num_clusters`):

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

{% include figure.html filename="images/clustering-visualizing-word-embeddings/Silhouette-c2.png" caption="2-Cluster silhouette plot" %}

### 4 Clusters

At the next step we have 4 classes: Biology, Economics, Social Sciences, and Physics. The code is the same as the preceding code block to generate the outputs, only the parameters change.

```python
num_clusters = 4
ddc_level = 2
```

Note that whatever clustering you run *last* will end up stored in the `clustered_df` data frame. This matters when you investigate the classification below.

### Are the experts ‘wrong’?

Ordinarily, if the expert assigns label *x* to an observation then _x_ it is! However, in the case of a PhD thesis it’s worth questioning this assumption for a moment! Are time-pressured, resource-constrained librarians going to be able to glance at an abstract and *always* select the most appropriate DDC. And will they *never* be influenced by ‘extraneous’ factors such as the department in which the PhD student was enroled or the history of DDCs assigned by the institution.

So while most approaches would treat ‘misclassifications’ as an error to be solved, we might reasonably ask whether these theses have been correctly classified in the first place. To investigate thist further we first need to reload the tokens data:

```python
df = pd.read_feather(os.path.join('data','ph-tutorial-data-embeddings.feather')).set_index('EThOS_ID')

# Clustered_df will contain whatever clustering your
# ran *last* because it is always overwritten using
# the code above.
fdf = df.join(clustered_df, rsuffix='_dupe') # fdf = Full Data Frame
fdf.drop(columns=[x for x in fdf.columns if x.endswith('_dupe')], inplace=True) # Drop duplicate columns
```

We can create a ‘misclassified’ data frame:

```python
misc = fdf[fdf[f'ddc{ddc_level}'] != fdf[f'Cluster_Name_{num_clusters}']]

print(f"There are {misc.shape[0]:,} ({(misc.shape[0]/fdf.shape[0])*100:0.1f}%) 'misclassified' theses.")
print()
misc.groupby(by=f'ddc{ddc_level}')[f'Cluster_Name_{num_clusters}'].value_counts()
```

This produces a quick overview of misclassifications:

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

Although our approach is less technically sophisticated than the one set out in Maarten Grootendorst's [CTFIDF](https://github.com/MaartenGr/cTFIDF/blob/master/ctfidf.py) module (as developed in [topic modelling with BERT](https://towardsdatascience.com/topic-modeling-with-bert-779f7db187e6) and [class-based TF/IDF](https://towardsdatascience.com/creating-a-class-based-tf-idf-with-scikit-learn-caea7b15b858)), it saves having to install *_another_* module and produces output that is easier to align with the needs of the WordCloud library. We  `fit` a TF/IDF vectoriser on the DDC-corpus (_e.g._ all documents assigned to the Biology DDC), and then transform the documents assigned to the Physics, Economics, or the Social Sciences cluster instead.

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

With four DDCs we have 12 plots in total: one for each pairing. While the TF/IDF plots are not, in and of themselves conclusive with respect to the assignment of any _one_ thesis, it does help us to get to grips with the aggregate differences: in each case we see vocabularies from another discipline (*e.g.* the physics of energy) employed in the service of the DDC-assigned discipline (*e.g.* Economics).

{% include figure.html filename="images/clustering-visualizing-word-embeddings/DDC_Cloud-c4-ddcBiology-tfidf.png" caption="'Misclassified' theses from the Biology DDC" %}

{% include figure.html filename="images/clustering-visualizing-word-embeddings/DDC_Cloud-c4-ddcEconomics-tfidf.png" caption="'Misclassified' theses from the Economics DDC" %}

{% include figure.html filename="images/clustering-visualizing-word-embeddings/DDC_Cloud-c4-ddcPhysics-tfidf.png" caption="'Misclassified' theses from the Physics DDC" %}

{% include figure.html filename="images/clustering-visualizing-word-embeddings/DDC_Cloud-c4-ddcSocial sciences-tfidf.png" caption="'Misclassified' theses from the Social Sciences DDC" %}

### 15 Clusters

Finally, we can also give the clustering process greater importance and simply use the DDC as support for labelling the resulting outputs. To select an ‘optimal’ number of clusters we use a [scree plot](https://programminghistorian.org/en/lessons/clustering-with-scikit-learn-in-python#3-dimensionality-reduction-using-pca) (the code for this is available in [GitHub]()), though expert opinion is just as defensible. The combination of the scree plot and [`kneed`](https://kneed.readthedocs.io/en/stable/) utility pointed to a clustering in the range of 13–18, so we opted for 15 clusters and assigned each cluster the name of its *dominant* DDC3 group.

In some cases this automated approach yields more than one cluster with the same dominant DDC: Biochemistry and Physics dominate multiple clusters each, while ‘Culture and Institutions’ and ‘Financial Economics’ (amongst others) each only predominate in one. The word clouds give a *sense* of how these clusters differ in terms of content. In the interest of brevity we don’t show the code for this analysis here, but it’s also available [on GitHub](https://github.com/jreades/ph-word-embeddings/blob/main/Embeddings.ipynb).

{% include figure.html filename="images/clustering-visualizing-word-embeddings/Word_Cloud-c15-tfidf.png" caption="TF/IDF word clouds for 15-cluster classification (name from dominant DDC3 group)" %}

## Summary

We hope that this tutorial has illustrated some of the potential power of combining the word2vec algorithm with the UMAP dimensionality reduction approach. In our work with the British Library, we expect these outputs to advance both our own research and the mission of the BL in a few ways:

1. **Filling in missing metadata**: because of the way the data was created, many of the records in the BL’s EThOS data set lack DDC values and keywords. The WE+UMAP approach allows us to *suggest* what those missing values might be! We can, for instance, use the dominant DDC from an unlabelled observation’s cluster to assign the DDC, and the class- or document-based TF/IDF to suggest keywords.
2. **Suggesting similar works**: the BL’s current search tool uses stemming and simple pattern matching to search for works matching the user’s query. While using singular terms to retrieve related documents is not as straightforward as one might imagine, asking the computer to find documents similar to *a selected target* (_i.e._ find me similar dissertations…) would significantly enhance the utility of the resource to researchers in all disciplines.
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
