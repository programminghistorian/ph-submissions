---
title: "Understanding and Creating Word Embeddings"
collection: lessons
layout: lesson
slug: understanding-creating-word-embeddings
date: 2022-11-16
translation_date: LEAVE BLANK
authors:
  - Avery Blankenship
  - Sarah Connell
  - Quinn Dombrowski
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

# Understanding and Creating Word Embeddings

## Learning Outcomes

In this lesson, you will learn:

- What word embedding models and word vectors are, and what kinds of questions we can answer with them
- Considerations when putting together a corpus as the basis for word vectors
- How to create and interrogate word vectors using Python
- Limitations on word vectors as a methodology for answering common questions

## Prerequisites

This lesson involves running some Python code; a basic familiarity with Python would be helpful, but no particular technical expertise is required. The Programming Historian has a series of [introductory lessons on Python](https://programminghistorian.org/en/lessons/?topic=python&sortType=difficulty&sortOrder=asc) that you may wish to review. 

To run the code, you can use the a [Jupyter notebook for the lesson](https://github.com/NEU-DSG/wwp-public-code-share/blob/WordVectors_Avery/WordVectors/python/Word%20Vectors%20Programming%20Historian%20Tutorial.ipynb) on your own computer. If you're not familiar with Jupyter notebooks, you may wish to review the [Programming Historian lesson on the topic](https://programminghistorian.org/en/lessons/jupyter-notebooks).

### System requirements

This tutorial is written with Python usage in mind, though most of the wide concepts are applicable in both Python and R. We assume that you already have some basic knowledge of Python as well as an IDE installed on your computer and thus do not walk through how to download and install Python or the relevant libraries. The code included in this tutorial uses Python 3.8.3 and Gensim 4.2.0. Gensim is an open-source Python library developed by Radim Řehůřek which allows a corpus to be represented as vectors. The particular word vector implementation that Gensim uses is Word2Vec, which is an algorithm developed by Tomáš Mikolov in 2013 for representing words in vector space using a neural network. While much of the code will still be applicable across versions of both Python and Gensim, there may be some syntax adjustments necessary.

## Introduction

When are the astronomical associations for “revolution” supplanted by political ones? How do popular methods for cooking chicken change over time? How do the associations of words like “grace” or “love” change between prayers and romantic novels? Questions such as these are the type of humanistic inquiries that can be challenging to answer through traditional methods. However, word embeddings can be a good starting place for answering questions like these, due to their ability to quickly identify relationships between words. Word embeddings assign a set of numeric values to words in a corpus based on their contexts of use. Those sets of numeric values, or word vectors, allow us to measure the distance between words, which gives us a proxy for how words are used in similar ways or contexts. Scaled up to a whole corpus, word embeddings give us a view into the relationships between words or concepts from a time period, genre of writing, author, and so on. 

Unlike topic models, which rely on word usage to better understand *documents*, word embeddings are more concerned with how words across a whole a corpus are used. This emphasis on relationships and contextual usage make word embeddings uniquely equipped to tackle many questions that humanists may have about a particular corpus of texts. For example, with a word embedding model, you can ask your model to identify the list of top ten words that are semantically similar to the word “grace.” You can also ask your model to produce that same list, but this time remove the concept of “holy” from consideration. You can even ask your model to show you what the most similar words are in your corpus to the concept of “grace” and “holy” combined. The ability to perform basic math with concepts (though much more complicated math is happening under the hood) in order to ask really complicated questions of a corpus is one of the key benefits of using word embeddings for text analysis. 

Word embeddings require *a lot* of text in order to do a reasonable job representing these relationships—- you won’t get meaningful output if you use a couple of novels or a handful of historical documents. This is because of how the algorithm works: it makes predictions about the contexts in which words will appear based on how they are used in the corpus you use to train the model, so fewer words in the training corpus means that there will be less information for the model to learn from. That said, there is no absolute minimum number of words required to train a word embedding model; performance will vary depending on how the model is trained, what kinds of documents you are using, how many unique words appear in the corpus, and so on. If your purposes are exploratory, even a model trained on a fairly small corpus should still produce interesting results—and if you find that the model doesn't seem to make sense, that might mean you need to add more texts to your input corpus or adjust your settings for training the model. 

This lesson is designed to get you started with word embedding models: you will learn how to prepare your corpus, read it into your Python session, train a model, and perform some exploratory queries. There are many other potential research applications for trained models—for example, [this tutorial](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/en/drafts/originals/clustering-visualizing-word-embeddings.md) explains how to cluster and visualize documents using word embedding models. The Women Writers Project has also published a [series of tutorials in R and Python](https://github.com/NEU-DSG/wwp-public-code-share/tree/main/WordVectors) that cover the basics of running code, training and querying models, validating trained models, and producing exploratory visualizations.  

### Data

While word embeddings have been implemented in many different ways using varying algorithms, for this purposes of this lesson, we will be focusing on the Word2Vec algorithm, which has been used in a range of digital humanities and computational social science projects (see, for example, work by [Benjamin Schmidt](http://bookworm.benschmidt.org/posts/2015-10-25-Word-Embeddings.html), [Ryan Heuser](https://ryanheuser.org/word-vectors/), and [Laura Nelson](https://www.sciencedirect.com/science/article/abs/pii/S0304422X21000115?dgcid=author). This lesson also uses a relatively small corpus of nineteenth-century recipes as its case study. We chose this particular example to demonstrate some of the potential benefits of a corpus with a vocabulary that is so tightly constrained and to highlight some of the specific considerations for working with a small corpus. As such, this lesson is less concerned with providing an in-depth comparison of word embedding algorithms (though we may at times make reference to them) and more focused on providing you with some fundamental knowledge and core concepts which will equip you to further explore word embeddings models for your own research.


## Concepts

### About vectors

Word embedding models represent words through a series of numbers referred to as a *word vector*. A word vector represents the positioning of a word in some multi-dimensional space that represents words' relationships. Just like we could perform basic math on objects that we’ve mapped onto two-dimensional space (e.g. visualizations with an X and Y axis), we can perform slightly more complicated math on words mapped into multi-dimensional space.

A "vector" is not simply a point in space, like we find in two-dimensional visualizations, but a point in space that has both *magnitude* and *direction*. This means that vectors are less like isolated points and more lines that trace a path from some origin point to that vector's designated position in what is called *vector space*. Models created using word vectors, called *word embedding models*, use word vectors to capture the relationships between words based on how close words are to one another in that vector space. 

This may sound complicated and abstract, but let’s start with a kind of word vector that is more straightforward: a document-term matrix.

### Word counts and document-term matrices

One way of representing a corpus of texts is a *document-term matrix*: a giant table where each row represents a word, and each column represents a text in the corpus. The cells are filled with the count of that particular word in that specific text. If you include every single word in every single text as part of this matrix (including things like names, typos, and obscure words), you’ll have a table where most of the cells have a value of 0, because most of the words just don’t occur in most of the texts. This setup is called a *sparse vector representation*, because most of the vector for each word (the set of X numbers, where X is the number of texts in your corpus, representing the count of that word in each text) is empty. The matrix also becomes harder to work with as the number of words increases, filling the matrix with more and more 0’s – which is a problem, because you need lots of words to have enough data to start to meaningfully represent language.

The innovation of the common algorithms used to create embedding models  – such as Word2Vec – is that they represent relationships between words in a condensed, *dense* way, but each takes a different approach, with consequences for what we get out of the model. These algorithms use a process called *embedding* to make the vector smaller, which makes the model faster to train and work with. Instead of a vector with tens of thousands of dimensions (including information about the relationship of every unique word with every other unique word), these word embedding models typically use only a few hundred abstracted dimensions that nonetheless manage to capture the most essential information about how different groups of words are related.

### Word2vec

Word2vec was the first algorithm for creating word embedding models, and it remains one of the most popular. It is a predictive model, meaning that it works out the likelihood that a word would occur in a particular context (using the continuous bag of words, or CBOW, method), or the likelihood that a particular context would occur for a given word (with the skip-gram method). For this introduction, you don’t need to worry about the differences between these methods, but if you would like to learn more about how word embedding models are trained, there are many useful resources online, such as the [“Illustrated Word2vec”](https://jalammar.github.io/illustrated-word2vec/) guide by Jay Alammar. 

For instance, take this set of sentences with the word “milk” in the middle:

- Pour the milk into the
- Add 1c milk slowly while
- Set the milk aside to
- Bring the milk to a

Word2vec collects a sample of contexts around each word, throughout the corpus, along with contexts that don’t actually exist in the corpus:

- Colorless green milk sleeps furiously
- My horrible milk ate my 
- The idealistic milk meowed all

It then takes this data and uses it to train a neural network that can predict the words that are likely, and those that are unlikely, to appear around the word “milk”. A neural network consists of a set of weights that are constantly adjusted as the network is trained, in order to make the network more accurate in its predictions. At the end of training, the values of those weights become the dimensions of the word vectors in the embedding model.

Because of how it samples the text and trains the model, word2vec works well for identifying synonyms, and things that could be substituted in a particular context. Using this method, “juice” will probably end up being closer to “milk” than “cow”, because it’s more feasible to substitute “juice” than “cow” in a phrase like “Pour the \[word\] into the”.

Because word2vec samples skipgrams, you won’t end up with the same result every time. It may be worthwhile to run a word2vec model a few times to make sure you don’t get dramatically different results for the things you’re interested in as a result of different sampling. Especially if you’re looking to make a fine point of semantic shift over time, you need to take care to minimize random variation, for instance, by keeping random seeds the same and using the same skip-gram window.


### Understanding distance in vector space

If we understand these vectors as lines whose directionality and length reflects word associations in the corpus (as defined by the algorithm), then the more two vectors are going in the same direction for the same distance, the nearer they are.

There are different ways to measure "closeness"—cosine similarity is often used with word vectors (for more on methods for measuring distance, see this [tutorial](https://programminghistorian.org/en/lessons/common-similarity-measures)). Since a vector is really a line, that means when you are comparing two vectors from the same corpus, you are comparing two lines, each of which shares an origin point. Since those two lines are already connected at the origin point, in order to figure out how similar those words are, all we need to do is to connect their designated position in vector space with an additional line. And what shape does that then form? A triangle. The distance between these two vectors can then be calculated using the cosine of this new line, which is determined by subtracting the adjacent line by the hypotenuse. The larger this number is, the closer those two vectors are in vector space. For example, two words that are far from each other (say, "email" and "yeoman") might have a low cosine similarity of around 0.1, while two words that are near to each other (say "happy" and "joyful" or even "happy" and "sad") might have a higher cosine similarity of around 0.8.

What does closeness *mean* for this method? Words that are close in vector space are those that the model predicts are likely to be used in similar contexts-—it is often tempting to think of these as synonyms, but that's not always going to be the case. In fact, antonyms are often very close to each other in word2vec vector space. Words that are likely to be used in the same contexts might have some semantic relationship, but their relationship might also be structural or syntactic. For instance, if you have a collection of letters, you might find that "sincerely,"  "yours," and "warmly" are close because they all tend to be used in the salutations of letters. This doesn't mean that "yours" is a synonym for "warmly"! Along the same lines, days of the week and months of the year will often be very close in vector space—"friday" is very much not a synonym for "monday" but the words tend to get used in the same kinds of ways.

When you observe that words are close to each other in your models, you should think about what kinds of usages might be reinforcing this proximity—and return to your corpus to get a better understanding of how the language is being used.

### Going beyond distance to answer questions

Because word vectors represent natural language numerically, this means that it is possible to perform mathematical equations with them. Let's say for example that you wanted to ask your corpus the following question: "how do people in nineteenth-century novels use the word 'bread' when they aren't referring to food?" Using vector math allows us to present this very specific query to our model.

The equation that you might use to ask your corpus of nineteenth-century novels that exact question might be: bread - food = ?

Or to be even more precise, what if you wanted to ask: "how do people talk about bread in kitchens when they aren't referring to food?" That equation may look like: bread + kitchen - food = ?

The more complex the math you want to do with your word vectors, the larger the corpus you’ll likely need to get sensible results. While the concepts discussed thus far might seem pretty abstract, they are easier to understand once you start looking at specific examples. So, let’s now turn to a specific corpus and start running some code to train and query a Word2vec model. 

## Exploring 19th century American recipes

The corpus we are using in this tutorial is built from nineteenth-century American recipes. Nineteenth-century people thought about food differently than we do today. For example, since modern kitchen technology such as the refrigerator and the coal cook stove only became widely used towards the end of the century, cooks had to think about preserving ingredients and preparing them in ways that accommodated the uneven temperatures of wood burning stoves and employed low-waste techniques. While today, we enjoy the modern conveniences of instant cake mixes, microwaves, and electric refrigerators, nineteenth-century kitchens were much less equipped to handle food that could quickly go bad. As a result, many nineteenth-century cookbooks reflect this attitude towards cooking which prioritizes thriftiness and low-waste, though sections in cookbooks dedicated to more fanciful and recreational cooking increase substantially by the turn of the century. While today we have “stress-baking” and other forms of cooking just for fun, attitudes towards food were much more conservative and practical in the nineteenth century.

Since we know that nineteenth-century cooking differs quite a bit from our modern understanding of cooking, word embedding models allow us to pursue questions such as: “what does American cooking look like if you remove the more fanciful dishes such as ‘cake’ or more low-waste dishes and techniques such as ‘preserves’ or ‘salted’?” Since milk was difficult to keep, we can check what words are used in similar contexts to milk to see if that reveals potential substitutions. Our research question, then, for this lesson is: how does the language of our corpus reflect attitudes towards recreational cooking and the limited lifespan of perishable ingredients such as milk in the nineteenth century? Using some model queries, we will be able to retrieve a list of words that share a context, but with the absence of “milk,” pointing us to substitutions or even whole dishes which exclude the ingredient. Similarly, by seeing what words share contexts with dishes like cake, we can see how authors talk about cake—or even the dishes that are talked about in a similar way. This reveals the attitude within the texts of our corpus towards more recreational dishes. Pursuing these questions will allow us to unpack some of the complicated shifts in language and instruction that occurred in nineteenth-century kitchens.

### Corpus specs

The corpus we will be using for this lesson is an open-source collection of nineteenth-century recipes developed by Avery Blankenship and available through [Github](https://github.com/ViralTexts/nineteenth-century-recipes). It consists of one thousand individual recipes pulled from published, nineteenth-century cookbooks available in plain text format through [Project Gutenberg](https://www.gutenberg.org/). The file names for each recipe are based on the Project Gutenberg ID for the cookbook that the recipe is pulled from, as well as an abbreviated title. This corpus is much smaller than commonly recommended (with a million words being a lower starting point), but given a constrained vocabulary and a focused set of inquiries, you can still get meaningful results.


### Accessing the code and data

The first step in building the model is to identify the files you will be using as your corpus. The code below imports the Python libraries that we will be using, and then iterates through the files and sub-directories in a directory that you define, to identify the text files that make up your corpus. As an example for this lesson, we will be working with a collection of recipes sourced from cookbooks on Project Gutenberg. You can download the [Jupyter notebook]((https://github.com/NEU-DSG/wwp-public-code-share/blob/WordVectors_Avery/WordVectors/python/Word%20Vectors%20Programming%20Historian%20Tutorial.ipynb)) and the [corpus](https://github.com/ViralTexts/nineteenth-century-recipes) to train a model on your own computer.

### Preparing your corpus

```

# A good practice in programming is to place your import statements at the top of your code, and to keep them together

import re                                   # for regular expressions
import os                                   # to look up operating system-based info
import string                               # to do fancy things with strings
import glob                                 # to locate a specific file type
from pathlib import Path                    # to access files in other directories
import gensim                               # to access Word2Vec
from gensim.models import Word2Vec          # to access Gensim's flavor of Word2Vec
import pandas as pd                         # to sort and organize data
```


After we have our libraries loaded, we need to load our data into Python. It is a good idea to place your dataset somewhere it's easy to navigate to. For instance, you could place your data in a folder in your Documents folder or in the same repository as your code file. In either case, you will need to know the *file path* for the folder with your data. The code block below reads in the path to your corpus which should be a folder on your computer, iterates through that folder, pulls the text from each file, and stores it in a dictionary. This code is written to process a folder with plain text files (.txt). These files can be anywhere within this folder, including in sub-folders. This tutorial assumes that you are working with the sample corpus, but the code can also be adjusted to reflect a different corpus.

A few important things to note:

1. When you are inputting your file path, you should use the *entire* file path. For example, on a Windows computer, that file path might look something like: C:/users/admin/Documents/MY_FOLDER. On a Mac, the file path might be: /Users/admin/Documents/MY_FOLDER.

2. You can use *tab completion* to fill in your file paths. Within the quotation marks (don't delete these!), hit the tab key and it will bring up the folders and files at your specific location. You can enter ../ to go up a directory. Each time you enter ../ it will go up one folder level in your computer, and you can then use tab to check where you are. Once you get *up* to, say, your "Documents" folder, you can then use tab to go *down* into the folder with your files. Even if you are not used to filling in file paths, you can use this combination of tab and ../ to navigate to the folder with the files that you want to use.

3. You can use a file path to a folder full of different types of files, but this code is only going to look for *.txt files*. If you want to work with different file types, you'll have to change the "endswith(.txt)" call. However, keep in mind that these files should always contain some form of plain text. For example, a Word document or a PDF won't work with this code.

In the code block below, you will provide the file path for the sample corpus which you should have downloaded and saved somewhere easy for you to locate. The sample corpus can be downloaded from [Github](https://github.com/ViralTexts/nineteenth-century-recipes).

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

        
When we use textual data to train a model, the model builds what is called a "vocabulary." The vocabulary is all of the words that the model has been introduced to in the training process. This means that the model only knows about words that you have shown it. If your data includes misspellings or inconsistencies in capitalization, the model won't understand that these are mistakes. Think of the model as having complete trust in you—if you give it a bunch of words that are misspelled, the model will trust that you know what you're doing and understand those misspelled words to be "correct." These errors will then make asking the model questions about its vocabulary difficult; if a word is misspelled six different ways, the model has less data about how each spelling is used, and any query you make will only account for the spelling you use for the query.

It might seem that more regularization is always better, but that’s not necessarily the case. Decisions about regularization should take into account how spelling variations are operating in the input corpus, and should consider where original spellings and word usages might have implications for the interpretations that can be drawn from models trained on a corpus. For example, a collection might contain deliberate archaisms that are connected with poetic voice, which would be flattened in the regularized text. Nevertheless, regularization is worth considering, particularly for projects invested in exploring language usage over time: it might not be important whether the spelling is queen, quean, or queene, for a project studying discourse around queenship within a broad chronological frame. Some researchers, for example Cordell (2017) and Rawson and Muñoz (2019) advocate for more embracing of noise, emphasizing that textual noise can also be useful for some research. For this reason, "the cleaner the better" isn't necessarily the best approach depending on the types of questions you are asking of your data.

Regardless of how a project approaches more extensive regularizations, it is generally useful to lowercase all of the words in the input corpus and remove most punctuation. Projects can also make decisions about how to handle cases such as contractions, which might be treated as either one word or two, as well as commonly occurring word-pairings, such as olive oil, which can be tokenized so that the model will treat them as a single item. The code we include in this tutorial for cleaning text is a reasonable general-purpose starting point for cleaning English-language texts.

```

def clean_text(text):
    
    # Cleans the given text using regular expressions to split and lower-cased versions to create
    # a list of tokens for each text.
    # The function accepts a list of texts and returns a list of lists of tokens


    # lower case
    tokens = text.split()
    tokens = [t.lower() for t in tokens]
    
    # remove punctuation
    re_punc = re.compile('[%s]' % re.escape(string.punctuation))
    tokens = [re_punc.sub('', token) for token in tokens] 
    
    # only include tokens that aren't numbers
    tokens = [token for token in tokens if token.isalpha()]
    return tokens

# clean text from folder of text files, stored in the data variable
data_clean = []
for x in data:
    data_clean.append(clean_text(x))

# Check that the length of data and the length of data_clean are the same. Both numbers printed should be the same

print(len(data))
print(len(data_clean))

# check that the first item in data and the first item in data_clean are the same.
# both print statements should print the same word, with the data cleaning function applied in the second one

print(data[0].split()[0])
print(data_clean[0][0])

# check that the last item in data_clean and the last item in data are the same
# both print statements should print the same word, with the data cleaning function applied in the second one

print(data[0].split()[-1])
print(data_clean[0][-1])
```

### Model creation

To train a word2vec model, the code first extracts the vocabulary, then generates a random set of initial word vectors, improves their predictive power by changing the weights behind-the-scenes. In addition to the corpus selection and cleaning described above, there are certain points in the process where you can make configuration choices, known as *parameters*.

#### Understanding parameters

Almost as essential as the texts you select for your corpus are the "parameters" you choose  during the training process. You can think of the training process (where we take a corpus and create a model from it) as being sort of like an industrial operation:

- you take some raw materials and feed them into a big machine, and on the other end you get out some product
- and this hypothetical machine has a whole bunch of knobs and levers on it that you use to control the settings
- in our word vector model training, the parameters are those knobs and levers that control the training process
- depending on how you adjust them, you get differently trained models

These parameters will have significant impacts on the models that you produce. They control things like which specific algorithm to use in training, how to handle rare words in your corpus, and how many times the algorithm should pass through your corpus as it learns. 

There are no perfect parameters, no "one size fits all" approach you can take. The most effective parameters will depend on the length of your texts, the variety of the vocabulary within those texts, their languages and structures—and, of course, on what kinds of questions you want to investigate. Part of working with word vector models is testing different parameters to see how they impact your results, turning the knobs on that metaphorical industrial machine. Usually, it will work best to vary parameters one at a time, so you can dial in on how each is impacting the resulting model. A particular challenge of working with word vectors is just how much the parameters impact your results—if you are sharing your research, you will need to be able to explain how you chose the parameters that you did. This is why testing different parameters and looking at multiple models is so important.

### Making choices about parameters
Now we are going to move on to training our model. Word2Vec allows you to control a lot of how the training process works through parameters. Some of the parameters that may be of particular interest are:

**Sentences**
The sentences parameter is where you tell Word2Vec what data to train the model with. In our case, we are going to set this attribute to our cleaned textual data.

**Mincount** (minimum count)
Mincount is how many times a word has to appear in the dictionary in order for it to 'count' as a word in the model. The default value for mincount is 5. You may want to change this value depending on the size of your corpus, but in most cases, 5 is a reasonable minimum. Words that occur less frequently than that don’t have enough data to get you sensible results. 

**Window**
The window parameter lets you set the size of the "window" that is sliding along the text when the model is trained. The default is 5, which means that the window will look at five words total at a time: 2 words before the target word, the target word, and then 2 words after the target word. Both the words before and after the target words will be treated as part of the context of the target word. The larger the window, the more words you are including in that calculation of context—and there is no bonus for words directly before the target word, and no penalty for words farther away, as long as they are in the window. Everything in the contextual window is treated identically in terms of how it contributes to the context. Essentially, the window size impacts how far apart words are allowed to be and still be treated as relevant context.

**Workers**
The workers parameter represents how many "worker" threads you want processing your text at a time. The default setting for this parameter is 3. This parameter is optional.

**Epochs**
Like workers, the epoch parameter is optional. Basically, the number of epochs correlates to how many iterations over the text you want the model to be trained on. There is no rule for what number of epochs will work best. Generally, the more epochs you have the better, but sometimes too many epochs can actually decrease the quality of the model due to overfitting (e.g. your model learns the training data so well that it performs worse on any other data set). You may wish to try a few settings with this parameter in order (for instance, 5, 10, 50, and 100) to determine which will work best for your data.

**Sg** ("skip-gram")
The sg parameter tells the computer what training algorithm to use. The options are CBOW (continuous bag of words) or skip-gram. In order to select CBOW, you set sg to the value 0 and in order to select skip-gram, you set the sg value to 1. The best choice of training algorithm really depends on what your data looks like.

The code below will actually train the model, using some of the parameters discussed above: 

```

# train the model
model = Word2Vec(sentences=data_clean, window=5, min_count=3, workers=4, epochs=5, sg=1)

# save the model
model.save("word2vec.model")
```


### Exploratory queries

Word2Vec has a number of built-in functions that are quite powerful. These functions allow us to ask the model questions about how it understands the text that we have provided it.

```

# start by choosing a word and just checking if it's in your vocabulary to make sure the model works as expected
# set the word that we are checking for
word = "milk"

# if that word is in our vocabulary
if word in model.wv.key_to_index:
    
    # print a statement to let us know
    print("The word %s is in your model vocabulary" % word)

# otherwise, let us know that it isn't
else:
    print("%s is not in your model vocabulary" % word)
```
    
Now, let's walk through each of these function calls below. 

One important thing to remember is that the results you get from each of these function calls do not reflect words that are *definitionally* similar, but rather words that are used in the same *contexts*. This is an important distinction to keep in mind because while some of the words you'll get in your results are likely to have similar meanings, you may have a few words in there that seem confusing. Word2vec embeddings guess the context of a word based on the words that often appear around it. Having a weird word appear in your results does not indicate necessarily that something is wrong with your model or corpus but rather may reflect that those words are used in the same way in your corpus. It always helps to go back to your corpus and get a better sense of how the language is actually used in your texts.

**Most_similar** -- this function allows you to retrieve words that are similar to your chosen word. In this case, we are asking for the top ten words in our corpus that are contextually similar to the word "milk." If you want a longer list, change the number assigned to topn to the number of items you want in your list. 

```

# returns a list with the top ten words used in similar contexts to the word "milk"
model.wv.most_similar('milk', topn=10)
```

You can also provide the most\_similar function with more specific information about your word(s) of interest. In the code block below, you'll notice that one word (“recipe”) is tied to the positive parameter and the other (“milk”) is associated with negative. This call to most\_similar will return a list of words that are most contextually similar to "recipe" but not the word "milk."

```

# returns the top ten most similar words to "recipe" that are dissimilar from "milk"
model.wv.most_similar(positive = ["recipe"], negative=["milk"], topn=10)
```

You can also include more than one word in the positive parameter like below: 

```

# returns the top ten most similar words to both "recipe" and "milk"
model.wv.most_similar(positive = ["recipe", "milk"], topn=10)
```

**Similarity** -- this function will return a cosine similarity score for the two words you provide it; the higher the cosine similarity, the more similar those words are.

```

# returns a cosine similarity score for the two words you provide
model.wv.similarity("milk", "cream")
```

**Predict_output_word** -- this function will predict the next word likely to appear in a set of context words with the other words you provide. This function works by inferring the vector of an unseen word.

```

# returns a prediction for the other words in a sentence containing the words "flour," "eggs," and "cream"
model.predict_output_word([ "flour", "eggs", "cream"])
```

### Validation
Now that we have a working model and have explored some of its functionality, it is important to evaluate the model. Does the model respond well to the queries it should? Is the model making obvious mistakes?

Validation of word vector models is currently an unsolved problem—especially for humanities research applications and models trained on historical corpora. The test below provides a sample of one approach to testing a model: seeing how it performs with word pairs that are likely to have high cosine similarities. These word pairs will be very specific to the corpus being tested, and you would want to use many more pairs than are in this demonstration sample! This is meant to be an example of the kinds of testing that are used in model evaluation, and is not a substitute for more rigorous testing processes. 

There are other methods for conducting a model evaluation. For example, a popular method for evaluating a Word2Vec model is using the built in evaluate_word_analogies() function to evaluate syntactic analogies. You can also evaluate word pairs using the built in function evaluate_word_pairs() which comes with a default dataset of word pairs. You can read more about evaluating a model on Gensim's documentation [website](https://radimrehurek.com/gensim/auto_examples/tutorials/run_word2vec.html#evaluating).

```

dirpath = Path(r"../../WordVectors/python/").glob('*.model') #current directory plus only files that end in 'model' 
files = dirpath
model_list = [] # a list to hold the actual models
model_filenames = []  # the filepath for the models so we know where they came from

#this for loop looks for files that end with ".model" loads them, and then adds those to a list
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
             ("cake", "cupcake"),
             ("jam", "jelly"),
             ("reserve", "save"),
             ("bake", "cook")]
# these for loops will go through each list, the test word list and the models list, 
# and will run all the words through each model
# then the results will be added to a dataframe

# create an empty dataframe with the column headings we need
evaluation_results = pd.DataFrame(columns=['Model', 'Test Words', 'Cosine Similarity'])

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

# save the evaluation_results dataframe as a .csv called "word2vec_model_evaluation.csv" in our current directory
# if you want the .csv saved somewhere specific, include the filepath in the .to_csv() call
evaluation_results.to_csv('word2vec_model_evaluation.csv')
```

## Corpus considerations

Now that you've had a chance to explore training and querying a model using a sample corpus, you might begin considering applications of word embeddings to your own research. In thinking about whether word vectors are useful for you, it's important to consider whether you are trying to investigate the kinds of questions that can be revealed by looking at patterns in word usage across a large corpus. This means considering:

- Whether it is possible to assemble a corpus that can serve as a proxy for the phenomenon you would like to investigate—for example, if you are studying how early modern British historians distinguished their work from that of their medieval predecessors, you might assemble two corpora, one with medieval histories and another with early modern ones.
- Whether "relationships between words" is a useful heuristic for your research, and whether you can identify terms or groups of terms associated with the larger conceptual spaces you are studying. With our early modern history example, we might use words like "fiction," "lie," "falsehood," and so on to get at the conceptual space of inaccurate or untruthful accounts of the past, and then see how close these are to the terms associated with earlier histories (such as "monk," "medieval," "chronicler").  

Another important consideration for building your corpus is the composition of the texts inside. You should think about questions like:

- Are the texts in your corpus in a single language, or more than one? If multiple languages, what is their distribution? Keep in mind that if you have multiple languages, there’s no magical translation layer in the word vector creation: the information about the contexts of gato won’t merge with the contexts of cat. Having multiple languages in a corpus might get you meaningful and interesting results if you’re studying, for instance, novels from the US borderlands where code switching between languages can be a significant literary device, but putting a bunch of Spanish-only documents and a bunch of English-only documents together in a single corpus just gives you two sets of words that don’t co-occur with each other at best, or co-occur in misleading ways (e.g. a model can’t differentiate between “con” as a conjunction in Spanish and as a noun in English, so if your research question involves looking at English words related to crime, the vector for English “con” will be skewed by the identically-spelled word in Spanish.)
- Do your texts vary in other features, such as length, genre, or form? Be deliberate about what you’re including in your corpus and why: if you want to work on the language of 18th century poetry, and find that all your poems together don’t have enough of a word count to get decent results, don’t start adding 18th century novels without adjusting your research questions accordingly. When big tech companies create giant word embeddings to help with things like machine translation, they’re working with unimaginably large corpora, at a scale where factors like genre and form have little impact. However, the smaller your data, the more careful you need to be—especially when trying to make scholarly claims about the output.
- What principles will you use to scope your corpus—date, publisher, publication location, author, etc.? You should make sure that your selection principles match with the kinds of questions you want to investigate. This applies to computational text analysis in general, and no less so here, where you may be tempted to cast a wide net to get enough text. 
- If you are not selecting all possible texts from within your scoping parameters—and you very likely won't be—how will you ensure that the texts you do select are broadly representative of the full set of potential texts (or at least how can you make sure that there aren't serious imbalances in the texts you include)? Returning to our early modern history example, it would be problematic if a corpus of "17th-century histories" had 59 texts published in 1699 and one published in 1601. 

Overall, you should aim toward a balance in the salient features of the texts that you select (publication date, genre, publication location, language) and a close alignment between the texts in your corpus and the aims of your research. If you are comparing corpora, try to make sure that the only difference between them is the feature that you are investigating. Remember that word vectors are going to give you information about the relationships between words in a corpus—so the actual words that go into your corpora are crucial! 

## Corpus preparation

When you are preparing your corpus, bear in mind that the model is trained on *all* the words in your corpus—so you should make sure to only include the words that you want to form part of your analysis. This is to say, if you’re sourcing texts from Project Gutenberg, you will want to remove the project's own boilerplate at the beginning and end of the texts. However, if you’re primarily interested in the nouns in your texts, that doesn’t mean you should strip out all the other parts of speech: they provide useful contextual information when creating the word vectors.

Because the results depend so heavily on the input data, it’s crucial to include a data analysis phase early in a project. In fact, data preparation and analysis should be iterative: reviewing texts, identifying where the data needs to be adjusted, making those changes, reviewing the results, identifying additional changes, and so on. It is also important to implement a system for keeping track of all the changes you make to your texts.

Some common information types that are often included with digital texts will need to be removed for most projects, as we just saw with the example of Project Gutenberg metadata. Other language to consider removing includes: editorially-authored text (such as annotations or descriptions of images), page numbers, and labels. Removing these is preferable both because they are not likely to be of interest in most cases and also because they can artificially introduce distance between closely related terms when the model is trained. 

For other document features, the goals of the project will impact which would best be removed or kept. These include paratexts—such as indices, tables of contents, and advertisements—as well as features like stage directions. And finally, you may choose to manipulate the language of your documents directly, such as by regularizing or modernizing the spelling, correcting errors, or lemmatizing text. Note that if you make changes to the language of your documents, you will also want to maintain an unmodified corpus, so that you can investigate the impacts of your data manipulations. 

## Next steps

Here are some resources if you would like to learn more about word vectors:

-   The [Women Writers Vector Toolkit ](https://wwp.northeastern.edu/lab/wwvt/index.html)is a web interface for exploring word vectors, accompanied by glossaries, sources, case studies, and sample assignments. This toolkit includes links to a [GitHub repository with RMD walkthroughs](https://github.com/NEU-DSG/wwp-public-code-share/tree/main/WordVectors) with code for training word2vec models in R, as well as [download and resources on preparing text corpora](https://wwp.northeastern.edu/lab/wwvt/resources/downloads/index.html).
-   The [Women Writers Project Resources page](https://wwp.northeastern.edu/outreach/resources/index.html) has guides on: searching your corpus, corpus analysis and preparation, model validation and assessment, and other materials for working with word vectors.
- A Programming Historian lesson on [Clustering and Visualizing Documents using Word Embeddings](clustering-visualizing-word-embeddings)

## Acknowledgements

We would like to thank Mark Algee-Hewitt and Julia Flanders for their contributions to various aspects of this lesson.