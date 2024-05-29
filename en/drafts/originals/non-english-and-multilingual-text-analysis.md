---
title: "Introduction to Text Analysis for Non-English and Multilingual Texts: Using NLTK, spaCy, and Stanza to Process a Text in French and Russian"
slug: non-english-and-multilingual-text-analysis
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Ian Goodale
reviewers:
- Forename Surname
- Forename Surname
editors:
- Laura Alice Chapot
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/612
difficulty:
activity:
topics:
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Lesson Goals

This lesson will provide an introduction on how to begin analyzing a corpus of non-English and/or multilingual text using Python. We will examine a multilingual text that includes both Russian and French, and show how you can perform three fundamental preprocessing steps that are widely used in text analysis (tokenization, part-of-speech tagging, and lemmatization) on a multilingual text. We will also look way ways to detect the languages present in a text.

We will go over the fundamentals of three commonly used packages for performing text analysis and natural language processing (NLP): the Natural Language Toolkit (NLTK), spaCy, and Stanza. We’ll review and compare the core features of the packages so you can become familiar with how they work and learn how to discern which tool is right for your specific use case and coding style. We will also show how to perform the preprocessing steps above using each of the three packages.

## Preparation
**Suggested Prior Skills**
This lesson is aimed at those who are unfamiliar with text analysis methods, particularly those who wish to apply those methods to multilingual corpora or texts not written in English. While prior knowledge of Python is not necessarily required, it will be helpful in understanding the basic structure of the code. Code for this tutorial is written in Python 3.10 and uses the NLTK (v3.8.1), spaCy(v3.7.4, and Stanza (v1.8.2) libraries to perform its text processing. [This lesson](https://programminghistorian.org/en/lessons/introduction-and-installation) from the Programming Historian will be helpful to read before completing this lesson if you are entirely new to Python.

**Installation and Setup**
You will need to install Python3 as well as the NLTK, spaCy, and Stanza libraries, which are all available through the [Python Package Index (PyPI)](https://pypi.org/). For more information about installing libraries using PyPI, see their [guide on installing packages](https://packaging.python.org/en/latest/tutorials/installing-packages/).

To install these packages, simply run these commands in your terminal:

```python
# install the packages, if you haven't already
pip install nltk
pip install spacy
pip install stanza
```

**Lesson Text File**
During the coding portion of the lesson, we will take an excerptof text from _War and Peace_ in the original Russian, which contains a substantial amount of French text, and show how to split it into sentences, detect the language of each sentence, and perform some simple analysis methods on the text. The text file we will be using contains an excerpt from the first book of the novel, and was sourced from Wikipedia. It can be downloaded [here](https://drive.google.com/file/d/1K5kmgqbNUFRDGD5it5foVHBgjJavdg5w/view?usp=sharing). This is the only textual resource you'll need to go through the lesson.


## Basics of Text Analysis and Working with Non-English and Multilingual Text

Computational text analysis is a broad term that encompasses a wide variety of approaches, methodologies, and tools that can be used to work with and analyze digital texts, from small-scale corpora and single texts to large amounts of textual data. Harnessing computational methods allows you to quickly perform tasks that are far more difficult to do without computational methods. Examples from other Programming Historian lessons include [Corpus Analysis with spaCy](https://programminghistorian.org/en/lessons/corpus-analysis-with-spacy), which looks at how to analyze a large corpus and explore meaningful trends in language patterns across a set of texts; [Introduction to Stylometry with Python](https://programminghistorian.org/en/lessons/introduction-to-stylometry-with-python), which shows how to perform stylometry, a form of exploratory data analysis based on natural language processing, to explore the authorship of texts with disputed authorship; and [Sentiment Analysis for Exploratory Data Analysis](https://programminghistorian.org/en/lessons/sentiment-analysis), which shows how to classify the sentiment of a text using a form of exploratory data analysis based on natural language processing.

### Key Steps and Concepts of Text Analysis Relevant to the Lesson
- Part-of-speech (POS) tagging
  - POS tagging involves marking each word of a text with its corresponding part-of-speech. POS taggers can use rule-based algorithms, following set definitions to infer the proper tag to attach to a word, or stochastic (probabalistic) approaches, in which the tagger calculates the probability of a given set of tags occurring and assigns them to an untrained text.
- Lemmatization
  - Lemmatization reduces a word to its root form, which is known as a "lemma." The lemmatized form of the word "coding," for example, would be "code." 
- Tokenization
  - Tokenization is the segmenting of a text into component parts, or tokens. These tokens can vary in size, but you will most commonly see texts tokenized into either words or sentences. 

These concepts are presented in this lesson as practical examples of how NLTK, spaCy, and Stanza handle these fundamental processing steps differently. We will also show how these steps can be applied to multilingual and non-English text.

### Multilingual Text
Supporting multilingualism in digital humanities work is an important step toward creating a more inclusive and representative community of DH scholarship that moves beyond anglocentric models of text analysis. Understanding and addressing the varied technical demands of specific languages and multilingual text is not only essential to work with these texts, but can help promote a burgeoning community of DH workers, researchers, and programmers who create work outside of a dominant anglocentric paradigm. As it stands, many of the resources available for learning computational methods of text analysis privilege English language texts and corpora, and omit information necessary to begin working with non-English source material.

Support from already existing tools for non-English languages is often lacking, but is improving in quality with the introduction of a greater quantity of high quality models for processing other languages. Still, many tutorials and tools you encounter will default to or emphasize English-language compatibility in their approaches. There are a number of things to consider when working with computational analysis of non-English text, many of them specific to the script your language(s) are written in. There are many assumptions that can be made when working with English language materials, such as the way word boundaries are defined, that we cannot make when working with other languages. Character-based languages often have properties that are not supported by many existing tools; the way Chinese handles word boundaries, for example, is very different than alphabet-based languages spoken in Europe. While NLTK, spaCy and Stanza all contain models that can navigate and parse the properties of these languages, you may have to adjust your approach and workflow to suit the individual needs of the language(s) and texts you are working with. This lesson will show how models can be applied to target specific languages within a text to maximize accuracy and avoid improperly or inaccruately parsing text. Thankfully, the widespread use of the Unicode Transformation Format – 8-bit (UTF-8) character encoding has made it quite easy to begin working programatically with non-English text. Unicode is the most commonly used encoding standard, and was designed to handle text from all of the world’s major writing systems. UTF-8 is one of the most common Unicode encodings, and the one that Python defaults to using for text. In this tutorial, we will be using UTF-8 by default when we work with our text in Python. 


While we will only be working with left-to-right scripts in this tutorial, it is worth mentioning that working with scripts that read right-to-left can require different technological approaches than those that read left-to-right, especially if they are embedded in a multilingual document that also contains left-to-right text. If you have a sentence in a right-to-left script in an otherwise left-to-right document, for instance, you will have to implement the Unicode Bidirectional Algorithm by placing a Right-to-Left Embedding character, u'\u202B', at the beginning of each right-to-left string, and a Pop Directional Formatting character, u'\u202C', at the end of each right-to-left string to return to producing left-to-right output. There are also special libraries that exist to support these scripts (e.g., [python-bidi](https://github.com/MeirKriheli/python-bidi), which is a pure Python implementation of the same algorithm mentioned above).


Detecting and engaging with the different languages in a single text is another issue that can be difficult to navigate, but we’ll go through some simple examples of how to do this in this tutorial. In your own work, it’s always best to thorough think through an approach before applying your methods to the text, considering how that approach suits your personal research or project-based needs. Being flexible and open to changing your workflow as you go is also helpful.


## Tools We’ll Cover:
We will use the tools below in this lesson, which were chosen due to their support for multilingual text analysis and NLP, robust user communities, and open source status. While all of the tools below are widely used and reliable, they each have diffrent strengths and features: they cover different languages, they use different syntax and data structures when interacting with them programatically, and each focus on slightly different use cases. By going over their main features and comparing how we interact with them in the coding portion of this lesson, you will be able to develop a basic familiarity with each package that can guide which one(s) you choose for your own projects.

### The Natural Language Toolkit (NLTK):

- [NLTK](https://www.nltk.org/index.html) is a suite of libraries for building Python programs to work with language data. Originally released in 2001, NLTK has excellent documentation and an active, engaged community of users that make it an excellent tool to learn and experiment with when beginning to work with text processing. More advanced users will find its wide variety of libraries and corpora useful, as well, and its structure makes it very easy to integrate into one’s own pipelines and workflows.
- It supports different numbers of languages for different tasks (it contains lists of stopwords for 23 languages, for example, but only has built-in support for word tokenization in 18 languages).
- For further reference, the [NLTK Book](https://www.nltk.org/book/) is an excellent reference, as is the official documentation linked above. The book and documentation are only available in English.

### spaCy:

- [spaCy](https://spacy.io/usage/spacy-101) has built-in support for a greater variety of languages than NLTK, with pretrained models of differing levels of complexity available for download. If you want to save time on processing speed you can use a smaller, less accurate model to perform something like part-of-speech tagging on a simple text, for example, rather than a more complex model that may return more accurate results but take longer to download and run. 
- spaCy is known for its high speed and efficient processing, and is often faster than NLTK and Stanza.
- Overall, spaCy focuses more on being a self-contained tool than NLTK. Rather than integrating NLTK with a separate visualization library such as [matplotlib](https://matplotlib.org/), for example, spaCy has its own visualization tools, such as [displaCy](https://demos.explosion.ai/displacy), that can be used in conjunction with its analysis tools to visualize your results.
- Documentation for spaCy is only available in English, but the library supports pipelines for 25 different languages. Over 20 more languages are also supported, but do not yet have pipelines (meaning only select features, such as stopwords, may be supported for those languages). For more information on supported languages, please consult [this documentation](https://spacy.io/usage/models#languages).

### Stanza:

- While often slower than NLTK and spaCy, [Stanza](https://stanfordnlp.github.io/stanza/#getting-started) has language models available not accessible through the other libraries. The package contains pretrained neural models supporting [70 languages](https://stanfordnlp.github.io/stanza/models.html#human-languages-supported-by-stanza). A full list of its models can be viewed [here](https://stanfordnlp.github.io/stanza/performance.html).
- Stanza was built with multilingual support in mind from the start, and working with text in different languages feels very intuitive and natural with the library’s syntax.
- Running a pipeline on a text is extremely simple, and allows you to access various aspects of a text—for example, parts-of-speech and lemmas—with minimal coding.
- Documentation for Stanza is only available in English.

To summarize, all three packages can be very effective tools for analyzing a text in a non-English language (or multiple languages), and it’s worth investigating each package’s syntax and capabilities to see which one best suits your individual needs for a given project.

## Sample Code and Exercises:

We will now go through sample code to demonstrate performing the same tasks using each package. We will take an excerpt of the text from _War and Peace_ (_Война и мир_) in the original Russian, which contains a substantial amount of French text, and show how to split it into sentences, detect the language of each sentence, and perform some simple analysis methods on the text.

The corpus was sourced from Wikipedia. The text file we will be using contains an excerpt from the first book of the novel, and can be downloaded [here](https://drive.google.com/file/d/1K5kmgqbNUFRDGD5it5foVHBgjJavdg5w/view?usp=sharing). This is the only textual resource you'll need to go through the lesson.

First, let's load our text file so we can use it with our analysis packages.

### Loading and Preparing the Text

First, let's load our text file so we can use it with our analysis packages. We'll open the file and assign it to the variable named "war_and_peace" so we can reference it later on. Then, we'll print the contents of the file to make sure it was read correctly. We are using a minimally pre-processed excerpt of the novel for the purposes of this tutorial.


```python
with open("sample_data/war_and_peace_excerpt.txt") as file:
    war_and_peace = file.read()
    print(war_and_peace)
```

Now, let's clean out the newline characters to make the text easier to work with computationally. We won't worry too much about thoroughly cleaning the text for the purposes of this tutorial, since we will primarily focus on our analysis methods rather than pre-processing. For a good introduction to preparing your text for multilingual analysis, please consult [this article.](https://modernlanguagesopen.org/articles/10.3828/mlo.v0i0.294)

We will replace all newlines (represented as a "\n" in the code) with a space (represented with a " "), assigning the cleaned text to a new variable named "cleaned_war_and_peace." Then we print it to check what we've done.


```python
cleaned_war_and_peace = war_and_peace.replace("\n", " ")
print(cleaned_war_and_peace)
```

Now that we've read the file, let's begin to process it. First, we import our packages (NLTK, spaCy, and Stanza) that we installed earlier in the lesson so that we can use them to begin working on the text.


```python
import nltk
import spacy
import stanza
```

Now that the libraries imported, let's perform sentence tokenization on the text. Tokenization is simply splitting a text into smaller units, such as sentences or words, and allows us to break the text down to work with it and analyze it more effectively. In this tutorial, we'll begin by tokenizing using NLTK, then detect each sentence's language.


There are different sentence tokenizers included in the NLTK package. NLTK recommends using the PunktSentenceTokenizer for a language specified by the user (see the following for more information: https://www.nltk.org/api/nltk.tokenize.html), but if working with multilingual text this may not be the best approach. If you have a piece of text containing multiple languages, as we do for this example, you will be applying a tokenization model trained to work with one language to all of the languages in your text (if we selected French, for instance, the model's methods for tokenizing French text would be applied to the other languages in our text, for which it may be less effective). For the purposes of this tutorial, we will use the sent_tokenize method built into NLTK without specifying a language, which will allow us to apply a basic tokenization algorithm that will work with both the Russian and French sentences in our example. For more advanced uses in which accuracy over a large body of text is important, it is preferable to apply the appropriate language models as appropriate.


```python
# first, let's install the 'punkt' resources required to use the tokenizer
import nltk
nltk.download('punkt')

# then we import the sent_tokenize method and apply it to our war_and_peace variable
from nltk.tokenize import sent_tokenize
nltk_sent_tokenized = sent_tokenize(cleaned_war_and_peace)
# if you were going to specify a language, the following syntax would be used: nltk_sent_tokenized = sent_tokenize(war_and_peace, language="russian")
```

The entire text is now accessible as a list of sentences within the variable nltk_sent_tokenized. Let's print three sentences we'll be working with: one entirely in Russian, one entirely in French, and one that is in both languages.


```python
# printing the Russian sentence at index 5 in our list of sentence
rus_sent = nltk_sent_tokenized[5]
print('Russian: ' + rus_sent)

# printing the French sentence at index 2
fre_sent = nltk_sent_tokenized[2]
print('French: ' + fre_sent)

# printing the sentence in both French and Russian at index 4
multi_sent = nltk_sent_tokenized[4]
print('Multilang: ' + multi_sent)
```

Now let's perform the same sentence tokenization using spaCy, grabbing the same sample of three sentences. As you can see, the syntax with spaCy is quite different. In addition to having a multilingual sentence tokenizer built in to the library, the list of sentences tokenized by the spaCy model is accessed by first applying the model to the text by calling the "nlp" method, then by accessing the tokenized sentences by assigning the doc.sents tokens to a list.


```python
# downloading our multilingual sentence tokenizer
!python -m spacy download xx_sent_ud_sm

# loading the multilingual sentence tokenizer we just downloaded
nlp = spacy.load("xx_sent_ud_sm")
# applying the spaCy model to our text variable
doc = nlp(cleaned_war_and_peace)

# assigning the tokenized sentences to a list so it's easier for us to manipulate them later
spacy_sentences = list(doc.sents)

# printing the sentences to our console
print(spacy_sentences)
```

Let's assign our sentences to variables, like we did with NLTK. spaCy returns its sentences not as strings, but as spaCy tokens. In order to print them as we did with the NLTK sentences above, we'll need to convert them to strings (for more information on built-in types in Python, such as strings and integers, please consult [this documentation](https://docs.python.org/3/library/stdtypes.html). This will allow us to concatenate them with the prefix identifying their language, as Python won't let us concatenate a string and a non-string type:


```python
# concatenating the Russian sentence and its language label
spacy_rus_sent = str(spacy_sentences[5])
print('Russian: ' + spacy_rus_sent)

# concatenating the French sentence and its language label
spacy_fre_sent = str(spacy_sentences[2])
print('French: ' + spacy_fre_sent)

# concenating the French and Russian sentence and its label
spacy_multi_sent = str(spacy_sentences[4])
print('Multilang: ' + spacy_multi_sent)
```

We can see above that both models tokenized the sentences in the same way, as the NLTK and spaCy indices (5, 2, and 4) match to the same sentences from the text. Now, let's perform the same operation with Stanza, using its built-in multilingual pipeline. Stanza uses pipelines to pre-load and chain up a series of processors, with each processor performing a specific NLP task (e.g., tokenization, dependency parsing, or named entity recognition). For more information on Stanza's pipelines, please consult [this documentation](https://stanfordnlp.github.io/stanza/getting_started.html).


```python
from stanza.pipeline.multilingual import MultilingualPipeline

# setting up our tokenizer pipeline
nlp = MultilingualPipeline(processors='tokenize')

# applying the pipeline to our text
doc = nlp(cleaned_war_and_peace)

# printing all sentences to see how they tokenized
print([sentence.text for sentence in doc.sentences])
```

Now, let's find the same sentences we did with NLTK and spaCy above. Like spaCy, Stanza converts its processed text to tokens that behave differently from strings.

First, let's add the sentence tokens to a list, converting them to strings. This makes it easier for us to look at specific sentences by their indices.


```python
# creating an empty list to append our sentences to
stanza_sentences = []

# iterating through the sentence tokens created by the tokenizer pipeline and appending to the list
for sentence in doc.sentences:
  stanza_sentences.append(sentence.text)

# printing our sentence that is only in Russian
stanza_rus_sent = str(stanza_sentences[5])
print('Russian: ' + stanza_rus_sent)

# printing our sentence that is only in French
stanza_fre_sent = str(stanza_sentences[2])
print('French: ' + stanza_fre_sent)

# printing our sentence in both French and Russian
stanza_multi_sent = str(stanza_sentences[4])
print('Multilang: ' + stanza_multi_sent)
```

### Automatically Detecting Different Languages

Now that we have three sentences to use as examples, we can begin to perform our analysis of each one. First, let's detect the language of each sentence computationally, starting with the monolingual examples.

NLTK includes a module called TextCat that supports language identification using the TextCat algorithm; for further information, please consult the documentation for the module [at this link](https://www.nltk.org/_modules/nltk/classify/textcat.html). Let's try the module on our sentences below.


```python
# downloading an NLTK corpus reader required by the TextCat module
nltk.download('crubadan')

# loading the TextCat package and applying it to each of our sentences
tcat = nltk.classify.textcat.TextCat()
rus_estimate = tcat.guess_language(rus_sent)
fre_estimate = tcat.guess_language(fre_sent)
multi_estimate = tcat.guess_language(multi_sent)

# printing the results
print(rus_estimate)
print(fre_estimate)
print(multi_estimate)
```

As we can see, TextCat correctly identified the Russian and French sentences. Since it can't output more than one language per sentence, it guessed Russian for our multilingual sentence. We'll examine other ways to handle language detection for multilingual sentences after we perform our sentence classification using spaCy and Stanza. Let's try spaCy first:


```python
# first, we install the spacy_langdetect package from the Python Package Index
pip install spacy_langdetect

# then we import it and use it to detect our languages
from spacy.language import Language
from spacy_langdetect import LanguageDetector

# setting up our language detector to work with spaCy
def get_lang_detector(nlp, name):
    return LanguageDetector()

# setting up our pipeline
Language.factory("language_detector", func=get_lang_detector)
nlp.add_pipe('language_detector', last=True)

# running the language detection on each sentence and printing the results
rus_doc = nlp(spacy_rus_sent)
print(rus_doc._.language)

fre_doc = nlp(spacy_fre_sent)
print(fre_doc._.language)

multi_doc = nlp(spacy_multi_sent)
print(multi_doc._.language)
```

We got similar, expected results with spaCy; note the confidence printed after the language guess is far lower for the multilingual sentence given that it contains more than one language. Now let's try Stanza, which has a built-in language identifier.


```python
# importing our models required for language detection
from stanza.models.common.doc import Document
from stanza.pipeline.core import Pipeline

# setting up our pipeline
nlp = Pipeline(lang="multilingual", processors="langid")

# specifying which sentences to run the detection on, then running the detection code
docs = [stanza_rus_sent, stanza_fre_sent, stanza_multi_sent]
docs = [Document([], text=text) for text in docs]
nlp(docs)

# printing the text of each sentence alongside the language estimates
print("\n".join(f"{doc.text}\t{doc.lang}" for doc in docs))
```

We can see that Stanza classified the final sentence as French, deviating from the other models.

For multilingual sentences, classifying both languages within the same sentence is not a simple problem to solve, and requires more granular analysis than a sentence-by-sentence approach. One method to detect all of the languages contained in a single sentence, for example, would be to break the sentence into its component words and then try to detect the language of each word--which will have questionable accuracy, given that we are only looking at one word at a time--and then group consecutive words of the same language within the string into new strings consisting only of one language. For this example, we can also detect non-Roman script and split the string into its component languages that way. Here is a simple implementation:


```python
# first, we split the sentence into its component words using the wordpunct_tokenize module
from nltk.tokenize import wordpunct_tokenize
tokenized_sent = wordpunct_tokenize(multi_sent)
```

Next, we check if each word contains Cyrillic characters, and split the string into two strings of Cyrillic and non-Cyrillic script. For simplicity's sake, we'll omit any punctuation in this example. We use a regular expression (a sequence of characters that specifies a match pattern in text) to detect Cyrillic characters; for more information on regular expressions, [this Programming Historian lesson](https://programminghistorian.org/en/lessons/understanding-regular-expressions) is a great resource.


```python
# importing the regex package so we can use a regular expression
import regex
# importing the string package to detect punctuation
from string import punctuation

# setting empty lists we will later populate with our words
cyrillic_words = []
latin_words = []
```

Next, we iterate through each word in our sentence and using regex to detect Cyrillic characters. If Cyrillic is found, we append the word to our cyrillic_words list; otherwise, we append the word to the Latin list. If a tokenized word is only punctuation, we continue without appending. We can then print our lists to see what has been appended.


```python
for word in tokenized_sent:
  if regex.search(r'\p{IsCyrillic}', word):
    cyrillic_words.append(word)
  else:
    if word in punctuation:
       continue
    else:
        latin_words.append(word)


print(cyrillic_words)
print(latin_words)
```

Finally, we can join our lists into strings so we can run the TextCat algorithm on them.


```python
# joining the lists into a string, with each word separated by a space (' ')
cyrillic_only_list = ' '.join(cyrillic_words)
latin_only_list = ' '.join(latin_words)

# now we use TextCat again to detect their languages
tcat = nltk.classify.textcat.TextCat()
multi_estimate_1 = tcat.guess_language(cyrillic_only_list)
multi_estimate_2 = tcat.guess_language(latin_only_list)

# printing our estimates
print(multi_estimate_1)
print(multi_estimate_2)
```

### Part-of-Speech Tagging

Now, let's perform part-of-speech tagging for our sentences using spaCy and Stanza.

NLTK does not support POS tagging on languages other than English out-of-the-box, but you can train your own model using a corpus to tag languages other than English. Documentation on the tagger, and how to train your own, can be found [here.](https://www.nltk.org/book/ch05.html#sec-n-gram-tagging)

Tagging our sentences with spaCy is very straightforward. Since we know we're working with Russian and French, we can download the appropriate spaCy models and use them to get the proper POS tags for the words in our sentences. The syntax remains the same regardless of which language model we use. We'll begin with French:


```python
# downloading our French model from spaCy
python -m spacy download fr_core_news_sm


# loading the corpus
nlp = spacy.load("fr_core_news_sm")

# applying the model
doc = nlp(spacy_fre_sent)

# printing the text of each word and its POS tag
for token in doc:
    print(token.text, token.pos_)

```

Now, we can do the same for our Russian sentence.


```python
# downloading our Russian corpus from spaCy
python -m spacy download ru_core_news_sm


# loading the corpus
nlp = spacy.load("ru_core_news_sm")

# applying the model
doc = nlp(spacy_rus_sent)

# printing the text of each word and its POS tag
for token in doc:
    print(token.text, token.pos_)
```

For multilingual text, we can use the words we generated earlier to tag each language separately, then join the words back into a complete sentence again.

Below, we split our sentence into Russian and French words as before, only this time we preserve the punctuation by appending any punctuation we encounter to the last list we appended to, preserving the proper placement of each punctuation mark (e.g., it will append a period to the word it should follow).


```python
# creating our blank lists to append to later
cyrillic_words = []
latin_words = []

# initializing a blank string to keep track of the last list we appended to
last_appended_list = ''

# iterating through our words and appending based on whether a Cyrillic character was detected
for word in tokenized_sent:
  if regex.search(r'\p{IsCyrillic}', word):
    cyrillic_words.append(word)
    # updating our string to track the list we appended a word to
    last_appended_list = 'cyr'
  else:
    # handling punctuation by appending it to our most recently used list
    if word in punctuation:
        if last_appended_list == 'cyr':
            cyrillic_words.append(word)
        elif last_appended_list == 'lat':
            latin_words.append(word)
    else:
        latin_words.append(word)
        last_appended_list = 'lat'

print(cyrillic_words)
print(latin_words)
```

We can then join these lists into strings to run our language detection on them. We'll use a regular expression to remove the extra whitespace before each punctuation mark that was created when we tokenized the sentence into words. This will preserve the punctuation as it was present in the original sentence.


```python
# joining the lists to strings
cyrillic_only_list = ' '.join(cyrillic_words)
latin_only_list = ' '.join(latin_words)

# using our regular expression to remove extra whitespace before the punctuation marks
cyr_no_extra_space = regex.sub(r'\s([?.!"](?:\s|$))', r'\1', cyrillic_only_list)
lat_no_extra_space = regex.sub(r'\s([?.!"](?:\s|$))', r'\1', latin_only_list)

# checking the results of the regular expression above
print(cyr_no_extra_space)
print(lat_no_extra_space)
```

Finally, we can tag each list of words using the appropriate language model.


```python
# loading and applying the model
nlp = spacy.load("fr_core_news_sm")
doc = nlp(lat_no_extra_space)

# printing the text of each word and its POS tag
for token in doc:
    print(token.text, token.pos_)

# and doing the same with our Russian sentence
nlp = spacy.load("ru_core_news_sm")
doc = nlp(cyr_no_extra_space)
print(doc.text)
for token in doc:
    print(token.text, token.pos_)
```

Now, let's perform POS tagging using Stanza. The syntax is quite straightforward; we'll start with French:


```python
# loading our pipeline and applying it to our sentence, specifying our language as French ('fr')
nlp = stanza.Pipeline(lang='fr', processors='tokenize,mwt,pos')
doc = nlp(stanza_fre_sent)

# printing our words and POS tags
print(*[f'word: {word.text}\tupos: {word.upos}' for sent in doc.sentences for word in sent.words], sep='\n')
```

And doing the same for our Russian sentence follows the same syntax:


```python
# loading our pipeline and applying it to our sentence, specifying our language as Russian ('ru')
nlp = stanza.Pipeline(lang='ru', processors='tokenize,pos')
doc = nlp(stanza_rus_sent)

# printing our words and POS tags
print(*[f'word: {word.text}\tupos: {word.upos}' for sent in doc.sentences for word in sent.words], sep='\n')
```

We'll now apply a simpler approach for the multilingual analysis than we did with spaCy, as Stanza's multilingual pipeline allows us to return POS tags with similar syntax to the examples above.


```python
# imports so we can use Stanza's MultilingualPipeline
from stanza.models.common.doc import Document
from stanza.pipeline.core import Pipeline
from stanza.pipeline.multilingual import MultilingualPipeline

# running the multilingual pipeline on our French, Russian, and multilingual sentences simultaneously
nlp = MultilingualPipeline(processors='tokenize,pos')
docs = [stanza_rus_sent, stanza_fre_sent, stanza_multi_sent]
nlp(docs)

# printing the results
print(*[f'word: {word.text}\tupos: {word.upos}' for sent in doc.sentences for word in sent.words], sep='\n')
```

### Lemmatization

Finally, let's perform lemmatization on our sentences using spaCy and Stanza (NLTK does not provide out-of-the-box lemmatization for non-English languages). Lemmatization is the process of grouping together the inflected forms of a word so they can be analysed as a single item, identified by the word's lemma, or dictionary form. The word "typed," for example, would be reduced to the lemma "type," removing the "-d" suffix to return the word to a more basic form.

spaCy does not have a single multingual lemmatization corpus, so we'll have to run separate models on our Russian and French text and split our multilingual sentence into its component parts again. For more info on lemmatization using spaCy, including a list of supported languages, visit spaCy's [lemmatizer documentation](https://spacy.io/api/lemmatizer).


```python
# loading and applying our French model
nlp = spacy.load("fr_core_news_sm")
doc = nlp(spacy_fre_sent)

# printing each word alongside its lemma
for token in doc:
    print(token, token.lemma_)

# loading and applying our Russian model
nlp = spacy.load("ru_core_news_sm")
doc = nlp(spacy_rus_sent)

# again printing each word alongside its lemma
for token in doc:
    print(token, token.lemma_)
```

For our multilingual sentence, we'll run each model on the chunks of text we split apart earlier. First we'll apply it to the Russian text:


```python
# loading and applying the model
nlp = spacy.load("ru_core_news_sm")
doc = nlp(cyr_no_extra_space)

# printing the words and their lemmas
for token in doc:
    print(token, token.lemma_)
```

And then the French text:


```python
# loading and applying the model
nlp = spacy.load("fr_core_news_sm")
doc = nlp(lat_no_extra_space)

# printing the words and their lemmas
for token in doc:
    print(token, token.lemma_)
```

And now we will do the same in Stanza. This syntax is very similar to the POS tagging with the multilingual pipeline we used earlier.


```python
# imports so we can run the multilingual pipeline
from stanza.models.common.doc import Document
from stanza.pipeline.core import Pipeline
from stanza.pipeline.multilingual import MultilingualPipeline

# adding the 'lemma' processor to the pipeline and running it on our sentences
nlp = MultilingualPipeline(processors='tokenize,lemma')
docs = [stanza_rus_sent, stanza_fre_sent, stanza_multi_sent]
nlped_docs = nlp(docs)

# iterating through each sentence's words and printing the lemmas
for doc in nlped_docs:
  lemmas = [word.lemma for t in doc.iter_tokens() for word in t.words]
  print(lemmas)
```


## Conclusion:

You now have a basic knowledge of each package that can help guide your use of the packages for your personal projects. You also have a basic understanding of how to approach non-English text using computational tools, and some strategies for working with multilingual text that will help you develop methodologies and strategies for applying your own workflows to analyzing other multilingual texts.

### Suggested Readings:

#### Related Programming Historian Lessons:

The following lessons can help with other important aspects of working with textual data that can be applied to non-English and multilingual texts.

- [Corpus Analysis with spaCy](https://programminghistorian.org/en/lessons/corpus-analysis-with-spacy)

  - This lesson is an in-depth look at analyzing a corpus using spaCy, and goes into details of spaCy’s capabilities and syntax we didn’t have time for in this lesson. This is a highly recommended read if you plan to use spaCy more in-depth for your work.

- [Normalizing Textual Data with Python](https://programminghistorian.org/en/lessons/normalizing-data)

  - This lesson explains various methods of data normalization using Python, and will be very useful for anyone who needs a primer on how to prepare their textual data for computational analysis.

#### Other resources about multilingual text analysis and DH:

- [Multilingual Digital Humanities](https://doi.org/10.4324/9781003393696)

  - A recently published book covering various topics and projects in the field of multilingual digital humanities, featuring a broad range of authors and geared toward an international audience. (Full disclosure: I have a chapter in this).

- [multilingualdh.org](https://multilingualdh.org/en/)

  - The homepage for the Multilingual DH group, a “loosely-organized international network of scholars using digital humanities tools and methods on languages other than English.” The group’s [GitHub repository](https://github.com/multilingual-dh) has helpful resources, as well, including [this bibliography](https://github.com/multilingual-dh/multilingual-dh-bibliography) and [this list of tools for multilingual NLP](https://github.com/multilingual-dh/nlp-resources).

<br/>
