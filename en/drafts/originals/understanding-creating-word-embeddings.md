---
title: "Understanding and Creating Word Embeddings"
slug: understanding-creating-word-embeddings
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
  - Avery Blankenship
  - Sarah Connell
  - Quinn Dombrowski
reviewers:
  - Anne Heyer
  - Ruben Ros
editors:
  - Yann Ryan
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/555
difficulty:
activity:
topics:
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Learning Outcomes

In this lesson, you will learn:

- What word embedding models and word vectors are, and what kinds of questions we can answer with them
- How to create and interrogate word vectors using Python
- What to consider when putting together the corpus you want to analyze using word vectors
- The limitations of word vectors as a methodology for answering common questions

## Prerequisites

This lesson involves running some Python code: a basic familiarity with Python would be helpful, but no particular technical expertise is required. _Programming Historian_ has a series of [introductory lessons on Python](https://programminghistorian.org/en/lessons/?topic=python&sortType=difficulty&sortOrder=asc) that you may wish to review. You could also see this very brief [introduction to Python](https://github.com/NEU-DSG/wwp-public-code-share/blob/main/WordVectors/python/python-fundamentals.ipynb) published by the [Women Writers Project](https://www.wwp.northeastern.edu/), aimed at getting started with word vector models.

To run the code, you can use the lesson's [Jupyter notebook](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/understanding-creating-word-embeddings/understanding-creating-word-embeddings.ipynb) on your own computer. If you're not familiar with Jupyter notebooks, you may wish to review _Programming Historian_'s [lesson on the topic](https://programminghistorian.org/en/lessons/jupyter-notebooks). If you prefer to download the notebook alongside a structured environment with folders for sample data and related files, you can also access [this release](https://github.com/NEU-DSG/wwp-public-code-share/releases).

### System requirements

This lesson is written with Python usage in mind, though most of the wider concepts are applicable in both Python and R. We assume that you already have some basic knowledge of Python as well as an [Integrated Development Environment](https://en.wikipedia.org/wiki/Integrated_development_environment) (IDE) — such as IDLE, Spyder, or Jupyter Notebooks — installed on your computer. Because of this, we do not walk through how to download and install Python or the relevant libraries. The code included in this tutorial uses Python 3.8.3 and Gensim 4.2.0. [Gensim](https://en.wikipedia.org/wiki/Gensim) is an open-source Python library developed by Radim Řehůřek which allows you to represent a corpus as vectors.

The particular word vector implementation used by Gensim is [word2vec](https://en.wikipedia.org/wiki/Word2vec), which is an algorithm developed in 2013 by Tomáš Mikolov and a team at Google to represent words in vector space, [released under an open-source Apache license](https://code.google.com/archive/p/word2vec/). While much of the code will still be applicable across versions of both Python and Gensim, there may be some syntax adjustments necessary.

## Introducing Word Embeddings

When was the astronomical concept of orbital _revolution_ supplanted by that of political uprising? How do popular methods for cooking chicken change over time? How do associations of words like _grace_ or _love_ vary between prayers and romance novels? Humanistic inquiries such as these that can prove to be challenging to answer through traditional methods like close reading.

However, by using word embeddings, we can quickly identify relationships between words and begin to answer these types of questions. Word embeddings assign numerical values to words in a text based on their relation to other words. These numerical representations, or 'word vectors', allow us to measure the distance between words and gain insight into how they are used in similar ways or contexts. Scaled up to a whole corpus, word embeddings can uncover relationships between words or concepts within an entire time period, genre of writing, or author's collected works.

Unlike [topic models](https://en.wikipedia.org/wiki/Topic_model), which rely on word frequency to better understand the general topic of a document, word embeddings are more concerned with how words are used across a whole corpus. This emphasis on relationships and contextual usage make word embeddings uniquely equipped to tackle many questions that humanists may have about a particular corpus of texts. For example, you can ask your word embedding model to identify the list of top ten words that are used in similar contexts as the word _grace_. You can also ask your model to produce that same list but, this time, removing the concept _holy_ from consideration. You can even ask your model to show you the words in your corpus most similar to the combined concept of _grace_ and _holy_. The ability to perform basic math with concepts (though much more complicated math is happening under the hood) in order to ask really complicated questions about a corpus is one of the key benefits of using word embeddings for textual analysis.

### Optimal Size of Corpora for Word Embeddings

Word embeddings require a lot of text in order to reasonably represent these relationships — you won’t get meaningful output if you use only a couple novels, or a handful of historical documents. The algorithm learns to predict the contexts in which words will appear based on the contexts it finds in the corpus it is trained on, so fewer words in the training corpus means less information to learn from.

That said, there is no absolute minimum number of words required to train a word embedding model. Performance will vary depending on how the model is trained, what kinds of documents you are using, how many unique words appear in the corpus, and a variety of other factors. Although smaller corpora can produce more unstable vectors,[^1] a smaller corpus may make more sense for the kinds of questions you're interested in. If your purposes are exploratory, even a model trained on a fairly small corpus should still produce interesting results — and if you find that the model doesn't seem to make sense, that might mean you need to add more texts to your input corpus, or adjust your settings for training the model.

## Lesson Goals

This lesson will have a more theoretical focus, designed to get you started with word embedding models. You will learn how to prepare your corpus, read it into your Python session, and train a model. You will explore how word vectors work, how to interpret them, and how to perform some exploratory queries using them. We will provide some introductory code to get you started with word vectors, but the main focus will be on equipping you with fundamental knowledge and core concepts to use word embedding models for your own research. This lesson uses as its case study a relatively small [corpus of nineteenth-century recipes](https://github.com/ViralTexts/nineteenth-century-recipes). We chose this particular case study to demonstrate some of the potential benefits of a corpus that is tightly constrained, as well as to highlight some of the specific considerations to keep in mind when working with a small corpus.

While word embeddings can be implemented in many different ways using varying algorithms, this lesson does not aim to provide an in-depth comparison of word embedding algorithms (though we may at times make reference to them). It will instead focus on the `word2vec` algorithm, which has been used in a range of digital humanities and computational social science projects.[^2] There are many potential research applications for trained models. For example, this advanced _Programming Historian_ [lesson on word embeddings](https://programminghistorian.org/en/lessons/clustering-visualizing-word-embeddings) explains how to cluster and visualize documents using word embedding models. The Women Writers Project has also published a [series of tutorials in R and Python](https://github.com/NEU-DSG/wwp-public-code-share/tree/main/WordVectors) that cover the basics of running code, training and querying models, validating trained models, and producing exploratory visualizations.

## Concepts

### About word vectors

Word embedding models represent words through a series of numbers referred to as a 'word vector'. A word vector represents the positioning of a word in multi-dimensional space. Just like we could perform basic math on objects that we’ve mapped onto two-dimensional space (e.g. visualizations with an X and Y axis), we can perform slightly more complicated math on words mapped onto multi-dimensional space.

A 'vector' is a point in space that has both 'magnitude' and 'direction.' This means that vectors are less like isolated points, and more like lines that trace a path from an origin point to that vector's designated position, in what is called a 'vector space.' Models created with word vectors, called 'word embedding models,' use word vectors to capture the relationships between words based on how close words are to one another in the vector space.

This may sound complicated and abstract, but let’s start with a kind of word vector that is more straightforward: a [document-term matrix](https://en.wikipedia.org/wiki/Document-term_matrix).

### Word counts and document-term matrices

One way of representing a corpus of texts is a 'document-term matrix': a large table in which each row represents a word, and each column represents a text in the corpus. The cells are filled with the count of that particular word in that specific text. If you include every single word in every single text as part of this matrix (including things like names, typos, and obscure words), you’ll have a table where most of the cells have a value of 0, because most of the words just don’t occur in most of the texts. This setup is called a 'sparse vector representation.' The matrix also becomes harder to work with as the number of words increases, filling the matrix with more and more 0s. This becomes problematic, because you need a large number of words to have  a sufficient amount of data, in order to meaningfully represent language.

The innovation of algorithms like word2vec is that they represent relationships between words in a 'dense' way. Different algorithms take different approaches, with consequences on the model's output, but all use a process called 'embedding' to make the vector smaller, and much faster. Instead of a vector with tens of thousands of dimensions (including information about the relationship of every unique word with every other unique word), these word embedding models typically use only a few hundred abstracted dimensions, which nonetheless manage to capture the most essential information about relations between different groups of words.

### word2vec

word2vec was the first algorithm invented for creating word embedding models, and it remains one of the most popular. It is a predictive model, meaning that it works out the likelihood that either 1) a word would occur in a particular context (using the Continuous Bag of Words (CBOW) method), or 2) the likelihood that a particular context would occur for a given word (with the skip-gram method).

For this introduction, you don’t need to worry about the differences between these methods. If you would like to learn more about how word embedding models are trained, there are many useful resources online, such as the ["Illustrated Word2vec"](https://jalammar.github.io/illustrated-word2vec/) guide by Jay Alammar. The two methods tend to perform equally well, but skip-gram often works better with smaller datasets and has better success representing less common words; by contrast, CBOW tends to perform better at representing more common words.

For instance, take this set of phrases with the word _milk_ in the middle:

- Pour the milk into the
- Add 1c milk slowly while
- Set the milk aside to
- Bring the milk to a

word2vec samples a variety of contexts around each word throughout the corpus, but also collects examples of contexts that do not exist for each word, known as 'negative sampling.' We can imagine examples generated using negative sampling might include:

- Colorless green milk sleeps furiously
- My horrible milk ate my
- The idealistic milk meowed all

It then takes this data and uses it to train a model that can predict the words that are likely, or unlikely, to appear around the word _milk_. Because the sampling is random, you will likely end up with a small amount of variation in your results if you run word2vec on a corpus multiple times. 

<div class="alert alert-info">
If you find that running word2vec multiple times gets you a large amount of variation, your corpus may be too small to meaningfully use word vectors.
</div>

The model learns a set of 'weights' (probabilities) which are constantly adjusted as the network is trained, in order to make the network more accurate in its predictions. At the end of training, the values of those weights become the dimensions of the word vectors in the embedding model.

word2vec works particularly well for identifying synonyms, or words that could be substituted in a particular context. In this sense, _juice_ will probably end up being closer to _milk_ than _cow_, because it’s more feasible to substitute _juice_ than _cow_ in a phrase like "Pour the \[_WORD_\] into the".

### Understanding distance in vector space

Recall that vectors have both a direction (where is it going?) and a length (how far does it go in that direction?). Both their direction and length reflect word associations in the corpus. If two vectors are going in the same direction, and have a similar length, that means that they are very close to each other in vector space, and they have a similar set of word associations.

There are different ways to measure 'closeness' of vectors, but 'cosine similarity' is a common method (for more examples of measuring distance, see [this tutorial](https://programminghistorian.org/en/lessons/common-similarity-measures) by _Programming Historian_). When you are comparing two vectors from the same corpus, you are comparing two lines that share an origin point. In order to figure out how similar those words are, all we need to do is to connect their designated position in vector space with an additional line, forming a triangle. The distance between the two vectors can then be calculated using the cosine of this new line (determined by subtracting the adjacent line by the hypotenuse). The larger this number, the closer those two vectors are in vector space. For example, two words that are far from each other (say, _email_ and _yeoman_) might have a low cosine similarity of around 0.1, while two words that are near to each other (say _happy_ and _joyful_ or even _happy_ and _sad_) might have a higher cosine similarity of around 0.8.

So, that's one way to measure closeness. But, what does closeness really mean for the purposes of textual analysis? Words that are close in vector space are those that the model predicts are likely to be used in similar contexts. It is often tempting to think of these as synonyms, but that's not always the case. In fact, antonyms are often very close to each other in word2vec vector space. Words that are likely to be used in the same contexts might have some semantic relationship, but their relationship might also be structural or syntactic. For instance, if you have a collection of letters, you might find that _sincerely_,  _yours_, _friend_, and _warmly_ are close because they all tend to be used in the salutations of letters. This doesn't mean that _friend_ is a synonym of _warmly_! Along the same lines, days of the week and months of the year will often be very close in vector space — _Friday_ is not a synonym for _Monday_ but the words tend to get used in the same contexts.

When you observe that words are close to each other in your models, you should return to your corpus to get a better understanding of how the ways in which language is being used might be reinforcing this proximity. .

### Using vector math to answer questions

Because word vectors represent natural language numerically, it becomes possible to perform mathematical equations with them. Let's say for example that you wanted to ask your corpus the following question: "How do people in nineteenth-century novels use the word _bread_ when they aren't referring to food?" Using vector math allows us to present this very specific query to our model.

The equation that you might use to ask your corpus of nineteenth-century novels that exact question might be: "bread - food = ?"

To be even more precise, what if you wanted to ask: "How do people talk about bread in kitchens when they aren't referring to food?" That equation may look like: "bread + kitchen - food = ?"

The more complex the maths you want to do with your word vectors, the larger the corpus you’ll likely need to get sensible results. While the concepts discussed thus far might seem pretty abstract, they are easier to understand once you start looking at specific examples. Let’s now turn to a specific corpus and start running some code to train and query a word2vec model.

## Exploring 19th century American recipes

The [corpus](https://github.com/ViralTexts/nineteenth-century-recipes) we are using in this lesson is built from nineteenth-century American recipes. Nineteenth-century people thought about food differently than we do today. Before modern kitchen technology like the refrigerator and the coal stove became widespread, cooks had to think about preserving ingredients and accommodating to the uneven temperatures of wood burning stoves. Without the modern conveniences of instant cake mixes, microwaves, and electric refrigerators, nineteenth-century kitchens were much less equipped to handle food that could quickly go bad. As a result, many nineteenth-century cookbooks prioritize thriftiness and low-waste, though sections dedicated to more fanciful and recreational cooking increase substantially by the turn of the century. Attitudes towards food were much more conservative and practical in the nineteenth century, compared to our forms of "stress-baking," or cooking just for fun.

Since we know that nineteenth-century cooking differs substantially from our modern understanding of cooking, word embedding models allow us to pursue questions such as: "What does American cooking look like if you remove the more fanciful dishes like 'cake,' or low-waste techniques like 'preserves' or 'salted'?" Since we know milk was difficult to preserve, we can check what words are used in similar contexts to "milk" to see if that reveals potential substitutions.

Our research question for this lesson is: "How does the language of our corpus reflect attitudes towards recreational cooking and the limited lifespan of perishable ingredients (such as milk) in the nineteenth century?" Using vector space model queries, we will be able to retrieve a list of words which do not include "milk" but do share its contexts, thus pointing us to possible substitutions. Similarly, by finding words which share contexts with dishes like "cake," we can see how authors talk about cake and find dishes that are talked about in a similar way. This will reveal the general attitude within our corpus towards more recreational dishes. Pursuing these questions will allow us to unpack some of the complicated shifts in language and instruction that occurred in nineteenth-century kitchens.

### Accessing the code and data

The first step in building the word embedding model is to identify the files you will be using as your corpus. The code below imports the Python libraries we will be using and iterates through the directory that you define to identify the text files that make up your corpus.

Wwe will be working with a corpus of 1,000 recipes sourced by Avery Blankenship from cookbooks on [Project Gutenberg](https://www.gutenberg.org/). The file names for each recipe are based on the Project Gutenberg ID for the cookbook from which the recipe is pulled, as well as an abbreviated title.

You can download this lesson's [Jupyter notebook](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/understanding-creating-word-embeddings/understanding-creating-word-embeddings.ipynb) and the [corpus](https://github.com/ViralTexts/nineteenth-century-recipes) to train a model on your own computer.

### Preparing your corpus

We start by importing all the Python libraries needed for this lesson. It is a good practice in programming to keep your import statements together at the top of your code. The code block below imports each library and explains its purpose in a comment.

You might need to install some of the libraries used in this tutorial. See [this lesson](https://programminghistorian.org/en/lessons/installing-python-modules-pip) for more information on installing external Python libraries.

```
import re                                   # for regular expressions
import os                                   # to look up operating system-based info
import string                               # to do fancy things with strings
import glob                                 # to locate a specific file type
from pathlib import Path                    # to access files in other directories
import gensim                               # to access Word2Vec
from gensim.models import Word2Vec          # to access Gensim's flavor of Word2Vec
import pandas as pd                         # to sort and organize data
```

Now that we have our libraries, we need to load our data into Python. You will need to store your dataset locally on your computer, ideally somewhere easy to navigate to. For instance, you could place your data in a folder in your `Documents` folder, or in the same repository as your code file. In either case, you will need to know the file path for that folder.

The code block below reads the path to your corpus, iterates through that folder, pulls the text from each file, and stores it in a dictionary. You will provide the file path for the sample [corpus](https://github.com/ViralTexts/nineteenth-century-recipes) which you should have downloaded from Github (the code can also be adjusted to reflect a different corpus). When you are inputting your file path, you should use the entire file path. For example, on a Windows computer, that file path might look something like: `C:/users/admin/Documents/MY_FOLDER`. On a Mac, the file path might be: `/Users/admin/Documents/MY_FOLDER`. Your files can be anywhere within this folder, including sub-folders: the code will loop through the folders and sub-folders in the filepath provided and look for all `.txt` files. (You can use a file path to a folder full of different types of files, but this code is only going to look for `.txt` files.)

<div class="alert alert-info">
If you want to work with different file types, you'll have to change the `endswith(.txt)` call. However, keep in mind that these files should always contain some form of plain text. For example, `.doc` or `pdf` won't work with this code. 
</div>

The code begins by first identifying those files and then reading them into memory:

```
dirpath = r'FILL IN YOUR FILE PATH HERE' # get file path (you should change this)
file_type = ".txt" # if your data is not in a plain text format, you can change this
filenames = []
data = []

 # this for loop will run through folders and subfolders looking for a specific file type
for root, dirs, files in os.walk(dirpath, topdown=False):
   # look through all the files in the given directory
   for name in files:
       if (root + os.sep + name).endswith(file_type):
           filenames.append(os.path.join(root, name))
   # look through all the directories
   for name in dirs:
       if (root + os.sep + name).endswith(file_type):
           filenames.append(os.path.join(root, name))

# this for loop then goes through the list of files, reads them, and then adds the text to a list
for filename in filenames:
    with open(filename) as afile:
        print(filename)
        data.append(afile.read()) # read the file and then add it to the list
        afile.close() # close the file when you're done
```

### Building your model's vocabulary

Using textual data to train a model builds what is called a 'vocabulary.' The vocabulary is all of the words that the model has processed during training. This means that the model only knows about words it has been shown. If your data includes misspellings or inconsistencies in capitalization, the model won't understand that these are mistakes. Think of the model as having complete trust in you: the model will believe any misspelled words to be correct. These errors will make asking the model questions about its vocabulary difficult: the model has less data about how each spelling is used, and any query you make will only account for the unique spelling used in that query.

It might seem that regularizing the misspellings is always helpful, but that’s not necessarily the case. Decisions about regularization should take into account how spelling variations operate in the corpus, and should consider how original spellings and word usages could affect the model's interpretations of the corpus. For example, a collection might contain deliberate archaisms connected to poetic voice, which would be flattened in the regularized text.

Nevertheless, regularization is worth considering, particularly for research projects exploring language usage over time: it might not be important whether the spelling is queen, quean, or queene, for a project studying discourse around queenship within a broad chronological frame. Some researchers advocate for more embracing of textual noise.[^3]

Regardless of your approach, it is generally useful to lowercase all of the words in the corpus and remove most punctuation. You can also make decisions about how to handle contractions (_can't_) and commonly occurring word-pairings (_olive oil_), which can be tokenized to be treated as either one or two objects.

Different tokenization modules will have different options for handling contractions, so you can choose a package or module that allows you to preprocess your texts to best match your corpus and research needs. For more on tokenizing text with Python, see this _Programming Historian_ [tutorial](https://programminghistorian.org/en/lessons/normalizing-data).

### Code for cleaning the corpus

The code we include in this lesson for cleaning text is a reasonable general-purpose starting point for cleaning English-language texts. By default, this code will remove punctuation using `string.punctuation` that comes with Python 3 and regular expressions. In Python 3, `string.punctuation` is equal to the following punctuation marks: ``` !"#$%&'()*+, -./:;<=>?@[\]^_`{|}~. ``` If you wanted to retain apostrophes, for example, you could replace `string.punctuation` in the code with a different string of punctuation marks which does not include apostrophes.

In the code below, the function `clean_text()` uses regular expressions to 'clean' our textual data. All this means is that the code is standardizing the format of the text (lower-casing, for example) and removing punctuation that may get in the way of the model's textual understanding. This process helps the model understand, for example, that _apple_ and _Apple_ are the same word. We also remove numbers from our textual data, since we are only interested in words. We end the function by checking that our cleaned data hasn't lost any words that we actually need, by making sure that the set of un-cleaned text data is the same length as the cleaned version.

```
def clean_text(text):

    # split and lower case
    tokens = text.split()
    tokens = [t.lower() for t in tokens]

    # remove punctuation
    re_punc = re.compile('[%s]' % re.escape(string.punctuation))
    tokens = [re_punc.sub('', token) for token in tokens]

    # remove numbers
    tokens = [token for token in tokens if token.isalpha()]
    return tokens

# clean text from folder
data_clean = []
for x in data:
    data_clean.append(clean_text(x))

# Confirm that number of clean texts is the same as original texts
print(len(data))
print(len(data_clean))

# Confirm the first cleaned text is the same as the first original text
print(data[0].split()[0])
print(data_clean[0][0])

# Confirm the last cleaned text is the same as the last original text
print(data[0].split()[-1])
print(data_clean[0][-1])
```

### Model creation

To train a word2vec model, the code first extracts the corpus vocabulary and generates from it a random set of initial word vectors. Then, it improves their predictive power by changing their weights, based on sampling contexts (where the word exists) and negative contexts (where the word doesn't exist).

#### Understanding parameters

In addition to the corpus selection and cleaning described above, at certain points in the process you can decide the configuration settings by adjusting what are known as 'parameters.' These are almost as essential as the texts you select for your corpus. You can think of the training process (where we take a corpus and create a model from it) as being sort of like an industrial operation:

- You take raw materials and feed them into a big machine which outputs a product on the other end
- This hypothetical machine has a whole bunch of knobs and levers on it that you use to control the settings (the parameters)
- Depending on how you adjust the parameters, you get back differently trained models

These parameters will have significant impact on the models you produce. They control things such as which specific algorithm to use in training, how to handle rare words in your corpus, and how many times the algorithm should pass through your corpus as it learns.

There is no 'one size fits all' approach. The most effective parameters will depend on the length of your texts, the variety of the vocabulary within those texts, their languages and structures — and, of course, on the kinds of questions you want to investigate. Part of working with word vector models is testing different parameters to see how they impact your results, or turning the knobs on that metaphorical industrial machine. 

Usually, it will work best to vary parameters one at a time, so you can observe how each one impacts the resulting model. A particular challenge of working with word vectors is just how much the parameters impact your results. If you are sharing your research, you will need to be able to explain how you chose the parameters that you used. This is why testing different parameters and looking at multiple models is so important.

### Making choices about parameters

Next, we are going to move on to training our model. Below are some parameters which may be of particular interest:

`Sentences`
The `sentences` parameter is where you tell word2vec what data to train the model with. In our case, we are going to set this attribute to our cleaned textual data.

`Mincount` (minimum count)
`Mincount` is how many times a word has to appear in the dictionary in order for it to 'count' as a word in the model. The default value for `mincount` is 5. You may want to change this value depending on the size of your corpus, but in most cases, 5 is a reasonable minimum. Words that occur less frequently than that don’t have enough data to get you sensible results.

`Window`
This lets you set the size of the `window` that is sliding along the text when the model is trained. The default is 5, which means that the window will look at five words at a time: two words before the target word, the target word, and then two words after the target word. Both the words before and after the target words will be treated as part of the context of the target word. The larger the window, the more words you are including in that calculation of contexts. As long as they are within the window, however, all words are treated indisciminately in terms of how relevant they are to the calculated context.

`Workers` (optional)
The `workers` parameter represents how many 'threads' you want processing your text at a time. The default setting for this parameter is 3. Increasing this parameter means that your model will train faster, but will also take up more of your computer’s processing power. If you are concerned about strain on your computer, leave this parameter at the default.

`Epochs` (optional)
The number of `epochs` signifies how many iterations over the text it will take to train the model. There is no rule for what number works best. Generally, the more `epochs` you have the better, but too many could actually decrease the quality of the model, due to 'overfitting' (your model learns the training data so well that it performs worse on any other data set). To determine what number of epochs will work best for your data, you may wish to experiment with a few settings (for example, 5, 10, 50, and 100).

`Sg` ('skip-gram')
The `sg` parameter tells the computer what training algorithm to use. The options are CBOW (Continuous Bag of Words) or skip-gram. In order to select CBOW, you set `sg` to the value 0 and, in order to select skip-gram, you set the `sg` value to 1. The best choice of training algorithm really depends on what your data looks like.

`Vector_size` (optional)
The `vector_size` parameter controls the dimensionality of the trained model, with a default value of 100 dimensions. Higher numbers of dimensions can make your model more precise, but will also increase both training time and the possibility of random errors.

Because word2vec samples the data before training, you won’t end up with the same result every time. It may be worthwhile to run a word2vec model a few times to make sure you don’t get dramatically different results for the things you’re interested. If you’re looking to make a fine point about shifts in language meaning or usage, you need to take special care to minimize random variation (for instance, by keeping random seeds the same and using the same skip-gram window).

The code below will actually train the model, using some of the parameters discussed above:

```
# train the model
model = Word2Vec(sentences=data_clean, window=5, min_count=3, workers=4, epochs=5, sg=1)

# save the model
model.save("word2vec.model")
```

## Analysis

### Exploratory queries

In the code below, we're going to begin by checking that the word we're examining is actually in the vocabulary of our model. This is a good first step, because it makes sure that the model actually contains the words we expect.

```
# check if a word exists in our vocabulary
word = "milk"

# if that word is in our vocabulary
if word in model.wv.key_to_index:

    # print a statement to let us know
    print("The word %s is in your model vocabulary" % word)

# otherwise, let us know that it isn't
else:
    print("%s is not in your model vocabulary" % word)
```

word2vec has a number of powerful built-in functions which allow us to ask the model questions about how it understands the provided text. Let's walk through each of these function calls below.

One important thing to remember is that the results you get from each of these function calls do not reflect words that have similar definitions, but rather words that are used in the same contexts. While some of the words you'll get in your results are likely to have similar meanings, your model may output a few strange or confusing words. This does not necessarily indicate that something is wrong with your model or corpus, but may reflect instead that these very different words are used in similar ways in your corpus. It always helps to go back to your corpus and get a better sense of how the language is actually used in your texts.

`most_similar`

This function allows you to retrieve words that are similar to your chosen word. In this case, we are asking for the top ten words in our corpus that are closest to the word _milk_. If you want a longer list, change the number assigned for `topn` to the desired number. The code below will return the ten words with the highest cosine similarities to the word _milk_ (or whatever other query term you supply). The higher the cosine similarity, the 'closer' the words are to your query term in vector space (remember that closeness in vector space means that words are used in the same kinds of contexts).

```
# returns a list with the top ten words used in similar contexts to the word "milk"
model.wv.most_similar('milk', topn=10)
```

You can also provide the `most_similar` function with more specific information about your word(s) of interest. In the code block below, you'll notice that one word (_recipe_) is tied to the positive parameter and the other (_milk_) is associated with negative. This call to `most_similar` will return a list of words that are most contextually similar to _recipe_, but not the word _milk_.

```
# returns the top ten most similar words to "recipe" that are dissimilar from "milk"
model.wv.most_similar(positive = ["recipe"], negative=["milk"], topn=10)
```

You can also include more than one word in the positive parameter, as shown below:

```
# returns the top ten most similar words to both "recipe" and "milk"
model.wv.most_similar(positive = ["recipe", "milk"], topn=10)
```

`similarity`

This function will return a cosine similarity score for the two words you provide it. The higher the cosine similarity, the more similar those words are.

```
# returns a cosine similarity score for the two words you provide
model.wv.similarity("milk", "cream")
```

`predict_output_word`

This function will predict the word most likely to appear from a set of context words, depending on the choice of words provided. This function works by inferring the vector of an unseen word.

```
# returns a prediction for the other words in a sentence containing the words "flour," "eggs," and "cream"
model.predict_output_word([ "flour", "eggs", "cream"])
```

### Validation

Now that we have explored some of its functionalities, it is important to evaluate our working model. Does it respond to our queries the way we would expect? Is it making obvious mistakes?

Validation of word vector models is currently an unsolved problem, especially for humanities research models trained on historical corpora. The test below provides a sample of one approach to testing a model, which involves seeing how well the model performs with word pairs that are likely to have high cosine similarities. This approach is just an example, and not a substitute for more rigorous testing processes. The word pairs will be very specific to the corpus being tested, and you would want to use many more pairs than are in this demonstration sample!

The code below evaluates the model first by opening the folder of models you provide, and identifying all files that are of type `.model`. Then, the code takes a list of test word pairs and calculates their cosine similarities. The word pairs are words that, as a human, you would expect to have high cosine similarity. Then, the code saves the cosine similarities for each word pair in each model in a `.csv` file for future reference.

If you were interested in adapting this code for your own models, you would want to select word pairs that make sense for the vocabulary of your corpus (for example, we've chosen recipe-related words we can reasonably expect to have high cosine similarities). Choosing to evaluate this particular model using words from a completely different field (e.g. looking for _boat_ and _ship_) would clearly not be effective, because those terms would not appear in this corpus at all, let alone in high enough frequencies. Which word pairs to choose is a matter of judgement and knowing your own corpus.

If you test out several pairs of similar words, and you find that their vectors are not close to each other in the model, you should check your corpus using your own eyes. Search for the words: how many times do each of the words appear in the corpus? Are they appearing in similar contexts? Is one appearing in many more contexts (or many more times) than the other? The example corpus for this lesson works, despite being quite small, because the texts belong to the fairly tightly-scoped domain of recipes from the same century. Nineteenth-century recipes from cookbooks are very different from twenty-first century recipes from the internet, so while using texts of both types in the same corpus would greatly expand the total vocabulary, you would also need to expand the corpus size in order to get enough examples of all the relevant words. If you test word pairs that should be similar and the cosine distance between them is high, you may need a larger corpus.

In this example, we find a set of models (filename ends in `.model`) in a specified directory, add them to a list, and then evaluate cosine distance for a set of test word pairs. We then add all the results to a dataframe.

<div class="alert alert-info">
There are other methods for conducting a model evaluation. For example, a popular method for evaluating a word2vec model is using the built in `evaluate_word_analogies()` function to evaluate syntactic analogies. You can also evaluate word pairs using the built in function `evaluate_word_pairs()` which comes with a default dataset of word pairs. You can read more about evaluating a model on Gensim's [documentation](https://radimrehurek.com/gensim/auto_examples/tutorials/run_word2vec.html#evaluating).
</div>

```
dirpath = Path(r"'FILL IN YOUR FILE PATH HERE’").glob('*.model')
files = dirpath
model_list = []
model_filenames = []

for filename in files:
    # turn the filename into a string and save it to "file_path"
    file_path = str(filename)
    print(file_path)
    # load the model with the file_path
    model = Word2Vec.load(file_path)
    # add the model to our mode_list
    model_list.append(model)
    # add the filepath to the model_filenames list
    model_filenames.append(file_path)

# test word pairs that we are going to use to evaluate the models
test_words = [("stir", "whisk"),
             ("cream", "milk"),
             ("cake", "muffin"),
             ("jam", "jelly"),
             ("reserve", "save"),
             ("bake", "cook")]

# create an empty dataframe with the column headings we need
evaluation_results = pd.DataFrame(columns=['Model', 'Test Words', 'Cosine Similarity'], dtype=object)

# iterate though the model_list
for i in range(len(model_list)):

    # for each model in model_list, test the tuple pairs
    for x in range(len(test_words)):

        # calculate the similarity score for each tuple
        similarity_score = model_list[i].wv.similarity(*test_words[x])

        # create a temporary dataframe with the test results
        df = [model_filenames[i], test_words[x], similarity_score]

        # add the temporary dataframe to our final dataframe
        evaluation_results.loc[x] = df

# save the evaluation_results dataframe as a .csv
# if you want the .csv saved somewhere specific, include the filepath in the .to_csv() call

evaluation_results.to_csv('word2vec_model_evaluation.csv')
```

The resulting `.csv` file contains a list of the models that were tested, the word pairs tested, and the cosine similarity for each word pair in that particular model. We've saved this file as a `.csv` for future reference, but you can also view the results inline by running the code below:

```
print(evaluation_results)
```

## Building a corpus for your own research

Now that you've had a chance to explore training and querying a model using a sample corpus, you might begin considering applications of word embeddings to your own research. In thinking about whether word vectors are useful for you, it's important to consider whether the kinds of questions you are trying to investigate can be answered by analyzing word usage patterns across a large corpus. This means considering the following issues:

- Is is possible to assemble a corpus that gives enough insight into the phenomenon you would like to investigate? For example, if you are studying how early modern British historians distinguished their work from that of their medieval predecessors, you might assemble two corpora: one of medieval histories, and another of early modern accounts.

- Are 'relationships between words' a useful heuristic for your research? Can you identify terms or groups of terms which represent the larger conceptual spaces you are studying? With our early modern history example, we might decide to see how closely words like _fiction_, _lie_ or _falsehood_ (suggesting untruthful accounts of the past) are associated to earlier histories (through terms such as _monk_, _medieval_ or _chronicler_).

Another important consideration for building your corpus is the composition of the texts. You should think about questions like:

- Are the texts in your corpus in a single language, or more than one? If multiple languages, what is their distribution? Keep in mind that if you have multiple languages, there’s no magical translation layer in the word vector creation: the information about the contexts of _gato_ (in Spanish) won’t merge with the contexts of _cat_ (in English). Mixing multiple languages in a corpus might get you meaningful and interesting results if you’re studying, for instance, novels from the US borderlands where code switching between languages can be a significant literary device. However, throwing Spanish-only documents and English-only documents together in a single corpus just gives you two sets of words that at best don’t co-occur with each other, and at worst give misleading results. For example, a model can’t differentiate between _con_ (with) as a conjunction in Spanish and _con_ (convict) as a noun in English. If your research question involves analyzing English words related to crime, the vector for English _con_ will be skewed by the identically-spelled Spanish word.

- Do your texts vary in other features, such as length, genre, or form? Be deliberate about what you’re including in your corpus and why: if you want to work on the language of eighteenth-century poetry, and find that all your poems together don’t have enough of a word count to get decent results, don’t start adding eighteenth-century novels without adjusting your research questions accordingly. When big tech companies create giant word embeddings to help with things like machine translation, they’re working with unimaginably large corpora, at a scale where factors like genre and form have little impact. However, the smaller your data, the more careful you need to be — especially when trying to make scholarly claims about the output.

- What principles will you use to scope your corpus—date, publisher, publication location, author? You should make sure that your selection principles match with the kinds of questions you want to investigate. This applies even when you may be tempted to cast a wide net to get enough text.

- If you are not selecting all possible texts within your scope parameters — which is very unlikely — how will you ensure that the texts you do select are broadly representative of the full set of potential texts? How can you at least make sure that there are no serious imbalances between the texts you include? Returning to our early modern history example, it would be problematic if a corpus of seventeenth-century histories consisted of 59 texts published in 1699 and one published in 1601.

Overall, you should aim toward a balance in the salient features of the texts that you select (publication date, genre, publication location, language) and a close alignment between the texts in your corpus and the aims of your research. If you are comparing corpora, make sure that the only difference between them is the feature that you are investigating. Remember that word vectors are going to give you information about the relationships between words — so the actual words that go into your corpora are crucial!

### Preparing the texts in your corpus

When you are preparing your corpus, bear in mind that the model is trained on all the words in your corpus. Because the results depend so heavily on the input data, be sure to include a data analysis phase early in your research to ensure you are only including the words your really want. In fact, data preparation and analysis should be an iterative process: review the texts, identify where the data needs to be adjusted, make those changes, review the results, identify additional changes, and so on. This makes it important to keep track of all the changes you make to your texts.

If you’re sourcing texts from Project Gutenberg, you will want to remove the project's own boilerplate description at the beginning and end of the texts. Other information to consider removing includes: editorially-authored text (such as annotations or descriptions of images), page numbers, and labels. Removing these features is preferable because they are not likely to be of interest and because they could skew the distances between related terms.

The goals of the project will impact which document features are best kept or removed. These include paratexts — such as indices, tables of contents, and advertisements — and features like stage directions. Finally, you may choose to manipulate the language of your documents directly, such as by regularizing or modernizing the spelling, correcting errors, or lemmatizing text. Note that if you make changes to the language of your documents, you will also want to maintain an unmodified corpus, so that you can investigate the impacts of your data manipulations.

### Training and querying a model

Once you have identified a corpus and prepared your texts, you can adapt the code above to train, query, and validate your model. Remember: this is an iterative process! You will likely need to make additional changes to your data and your parameters as you better understand what your model shows about the texts in your corpus. The more you experiment with your data and your models, the better you will understand how these methods can help you answer new kinds of questions, and the more prepared you will be to learn even more advanced applications of word vector models!

## Next steps

Now that you've learned how to build and analyze word embeddings, you can see _Programming Historian_'s related [Clustering and Visualizing Documents using Word Embeddings](https://programminghistorian.org/en/lessons/clustering-visualizing-word-embeddings) lesson to learn more advanced methods of analysis with word vectors.

Here are some other resources if you would like to learn more about word vectors:

- The Women Writers Project provides a full set of tutorials for training word vector models in Python, which can be downloaded with sample data from the WWP’s [Public Code Share GitHub repository](https://github.com/NEU-DSG/wwp-public-code-share/releases).
- The [Women Writers Vector Toolkit ](https://wwp.northeastern.edu/lab/wwvt/index.html)is a web interface for exploring word vectors, accompanied by glossaries, sources, case studies, and sample assignments. This toolkit includes links to a [GitHub repository with RMD walkthroughs](https://github.com/NEU-DSG/wwp-public-code-share/tree/main/WordVectors) with code for training word2vec models in R, as well as [downloadable resources on preparing text corpora](https://wwp.northeastern.edu/lab/wwvt/resources/downloads/index.html).
- The [Women Writers Project Resources page](https://wwp.northeastern.edu/outreach/resources/index.html) has guides on searching your corpus; corpus analysis and preparation; model validation and assessment, and more.

To get a better sense of how word vectors might be used in research and the classroom, you can see this [series of blog posts](https://wwp.northeastern.edu/blog/category/word-vectors/); see also this [annotated list of readings](https://www.wwp.northeastern.edu/lab/wwvt/resources/sources/index.html).

Below are individual readings and research projects that help to illuminate the applications of word vector models in humanistic research:

- Ryan Heuser's [Word Vectors in the Eighteenth Century](https://ryanheuser.org/word-vectors/) walks through a research project using word vector models to understand eighteenth-century conceptions of originality.
- Michael Gavin, Collin Jennings, Lauren Kersey, and Brad Pasanek. [Spaces of Meaning: Vector Semantics, Conceptual History, and Close Reading](https://dhdebates.gc.cuny.edu/read/untitled-f2acf72c-a469-49d8-be35-67f9ac1e3a60/section/4ce82b33-120f-423f-ba4c-40620913b305) explores how to use word embedding models to study concepts and their history.
- Laura Nelson, [Leveraging the alignment between machine learning and intersectionality: Using word embeddings to measure intersectional experiences of the nineteenth century U.S. South](https://www.sciencedirect.com/science/article/pii/S0304422X21000115?dgcid=author) considers ways of using word embedding models in deliberately intersectional research applications, working through an example project on racialized and gendered identities in the nineteenth-century U.S. South.
- Anouk Lang, [Spatial Dialectics: Pursuing Geospatial Imaginaries with Word Embedding Models and Mapping](https://modernismmodernity.org/forums/posts/spatial-dialectics) uses word embedding models to explore 'spatial imaginaries' in early twentieth-century Canadian periodicals, looking at gendered discourse and also at ways to combine results word embedding models with geospatial analysis.
- Siobhan Grayson, Maria Mulvany, Karen Wade, Gerardine Meaney, and Derek Greene, [Novel2Vec: Characterising 19th Century Fiction via Word Embeddings](https://graysons.github.io/pdfs/grayson2016novel2vec.pdf) explores the use of word embedding models to study narrative formations in 19th-century novels.

## Acknowledgements

We would like to thank Mark Algee-Hewitt and Julia Flanders for their contributions to various aspects of this lesson.

## References

[^1]: Indeed, Wevers and Koolen suggest that...... in Wevers, Melvin and Marijn Koolen. “Digital begriffsgeschichte: Tracing semantic change using word embeddings.” _Historical Methods: A Journal of Quantitative and Interdisciplinary History_ 53, no. 4 (2020), 226-243. https://doi.org/10.1080/01615440.2020.1760157

[^2]: See, for example, work by [Benjamin Schmidt](http://bookworm.benschmidt.org/posts/2015-10-25-Word-Embeddings.html), [Ryan Heuser](https://ryanheuser.org/word-vectors/), and [Laura Nelson](https://doi.org/10.1016/j.poetic.2021.101539)

[^3] for example Cordell (2017) and Rawson and Muñoz (2019) 
