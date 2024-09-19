---
title: "Analyzing Multilingual French and Russian Text using NLTK, spaCy, and Stanza"
slug: analyzing-multilingual-text-nltk-spacy-stanza
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

This lesson will provide an introduction on how to begin analyzing non-English and/or multilingual text using Python. We will examine a multilingual text that includes both Russian and French, and show how you can perform three fundamental preprocessing tasks that are widely used in text analysis (tokenization, part-of-speech tagging, and lemmatization) on a multilingual text. We will also look at ways to automatically detect the languages present in a text. 

We will show how to perform the tasks above using three commonly used packages for performing text analysis and natural language processing (NLP): the Natural Language Toolkit (NLTK), spaCy, and Stanza. In doing so, we’ll go over the fundamentals of these packages, and review and compare their core features so you can become familiar with how they work and learn how to discern which tool is right for your specific use case and coding style.

## Preparation
**Suggested Prior Skills**
This lesson is aimed at those who are unfamiliar with text analysis methods, particularly those who wish to apply those methods to multilingual corpora or texts not written in English. While prior knowledge of Python is not necessarily required, it will be helpful in understanding the basic structure of the code. Code for this tutorial is written in Python 3.10 and uses the NLTK (v3.8.1), spaCy(v3.7.4), and Stanza (v1.8.2) libraries to perform its text processing. [This lesson](https://programminghistorian.org/en/lessons/introduction-and-installation) from the Programming Historian will be helpful to read before completing this lesson if you are entirely new to Python.

**Installation and Setup**
You will need to install Python3 as well as the NLTK, spaCy, and Stanza libraries, which are all available through the [Python Package Index (PyPI)](https://pypi.org/). For more information about installing libraries using PyPI, see their [guide on installing packages](https://packaging.python.org/en/latest/tutorials/installing-packages/).

To install these packages, simply run these commands in your terminal:

```python
# install the packages, if you haven't already
pip install nltk
pip install spacy
pip install stanza
```


## Basics of Text Analysis and Working with Non-English and Multilingual Text

Computational text analysis is a broad term that encompasses a wide variety of approaches, methodologies, and tools that can be used to work with and analyze digital texts, from small-scale corpora and single texts to large amounts of textual data. Harnessing computational methods allows you to quickly perform tasks that are far more difficult to do without computational methods. For example, in this lesson we cover part-of-speech tagging. This method can be used to quickly identify all verbs and their associated subjects and objects across a corpus of texts which could then be used to develop analyses of agency and subjectivity in the corpus of text (as Dennis Tenen does in his article [“Distributed Agency in the Novel,”](https://muse.jhu.edu/article/898333/summary) for example). In addition to the methods we cover in this lesson, other commonly-performed tasks made easier by computation include sentiment analysis (which provides a quantitative assessment of the sentiment of a text, generally spanning a numerical scale indicating positivity or negativity) and named entity recognition (NER), which recognizes and classifies entities in a text into categories such as place names, person names, and so on. Sentiment analysis can be used for quickly determining the emotional valence of texts for comparative purposes; it is used in the article ["Digital Melville and Computational Methods in Literary Studies"](https://muse.jhu.edu/article/904374) by Dennis Mischke and Christopher Ohge, for example, to determine whether there was a noticeable difference in sentiment between Melville's substantive drafts of his works. An interesting application of named entity recognition was used by Katherine McDonough, Ludovic Moncla, and Matje van de Camp in their article ["Named entity recognition goes to old regime France:
geographic text analysis for early modern French corpora,"](https://doi.org/10.1080/13658816.2019.1620235) in which they describe their work to identify place names in early modern French texts using NER, providing a critical evaluation of NER technologies as they might be applied to their area of focus.

Examples from other Programming Historian lessons include [Corpus Analysis with spaCy](https://programminghistorian.org/en/lessons/corpus-analysis-with-spacy), which looks at how to analyze a large corpus and explore meaningful trends in language patterns across a set of texts; [Introduction to Stylometry with Python](https://programminghistorian.org/en/lessons/introduction-to-stylometry-with-python), which shows how to perform stylometry, a form of exploratory data analysis based on natural language processing, to explore the authorship of texts with disputed authorship; and [Sentiment Analysis for Exploratory Data Analysis](https://programminghistorian.org/en/lessons/sentiment-analysis), which shows how to classify the sentiment of a text using a form of exploratory data analysis based on natural language processing.

 Using text analysis methods first requires that we perform certain preprocessing tasks, which are necessary to prepare the text for computational analysis. These tasks can be especially important (and sometimes particularly challenging) when working with multilingual text.
 
For example, you might first need to turn your text into machine-readable text using methods such as optical character recognition (OCR), which extracts text from scanned images. OCR can work very well for many documents, but can give far less accurate results on other texts, such as handwritten script or documents that don't have clearly delineated text (e.g., a document with low contrast between the text and the paper it is printed on). This means that, depending on the languages and texts you work with and the quality of OCR method, you might need to “clean” your text - ie. correct the errors made by OCR - in order to use it in your analyses. For an introduction to OCR and cleaning see these Programming Historian lessons: [“OCR with Google Vision API and Tesseract"](https://programminghistorian.org/en/lessons/ocr-with-google-vision-and-tesseract), [“OCR and Machine Translation"](https://programminghistorian.org/en/lessons/OCR-and-Machine-Translation), and [“Cleaning OCR’d text with Regular Expressions"](https://programminghistorian.org/en/lessons/cleaning-ocrd-text-with-regular-expressions).

Once you have a clean text that is machine-readable, further tasks will be necessary in order to prepare the text for analysis. These are usually referred to as preprocessing tasks. These tasks can sometimes be implemented in their own right – for example, lemmatizing a text and analyzing the results can provide useful information – or they can be implemented as preliminary tasks for further analysis — for example, tokenizing a text prior to performing sentiment analysis. Yet again, however, preprocessing tasks can often involve particular challenges and considerations depending on the types of languages and texts you are working with.


### Key Steps and Concepts of Text Analysis Relevant to the Lesson

In this lesson, we focus on three key processing tasks — part-of-speech tagging, lemmatization, and tokenization — and show how these tasks can be applied to a multilingual and non-English language text.”

- Part-of-speech (POS) tagging
  - POS tagging involves marking each word of a text with its corresponding part-of-speech (e.g. nouns, verbs, adjectives, etc.). POS taggers can use rule-based algorithms, following set definitions to infer the proper tag to attach to a word, or stochastic (probabilistic) approaches, in which the tagger calculates the probability of a given set of tags occurring and assigns them to an untrained text. For example, a sentence with parts of speech tagged by NLTK might look like the following (this sentence is taken from Chapter 5 of the [NLTK Book](https://www.nltk.org/book/ch05.html)): [('And', 'CC'), ('now', 'RB'), ('for', 'IN'), ('something', 'NN'), ('completely', 'RB'), ('different', 'JJ')]. The sentence is split into its component words, and each word is put into a tuple with its corresponding POS tag.

{% include figure.html filename="en-or-analyzing-multilingual-text-nltk-spacy-stanza-01.png" alt="A screenshot of Python code showing a sample sentence being tagged into a list of tuples containing its component words and their respective parts of speech using NLTK." caption="Screenshot of part-of-speech tagging from the NLTK Book, Chapter 5." %}

- Lemmatization
  - Lemmatization reduces a word to its dictionary form, which is known as a "lemma." The lemmatized form of the word "coding," for example, would be "code," with the "-ing" suffix removed.
- Tokenization
  - Tokenization is the segmenting of a text into component parts, or tokens. These tokens can vary in size, but you will most commonly see texts tokenized into either words or sentences. The sentence used as an example for POS tagging above, for example, could be tokenized into a list of words like so: ['And', 'now', 'for', 'something', 'completely', 'different', 'JJ']. For this lesson, we will focus on tokenizing text in this way; in other contexts, such as when tokenizing a text for use with a large language model (LLM), different tokenization methods will be applied, such as assigning each unique character token (e.g., letters, punctuation) a unique integer value.

### Challenges Facing Non-English and Multilingual Text Analysis

These concepts are presented in this lesson as practical examples of how NLTK, spaCy, and Stanza handle these fundamental processing tasks differently. The way that text analysis packages implement certain tasks can vary depending on a number of criteria (the choice of algorithm, the choice of models and training data they rely on, etc.). The way packages implement certain tasks can therefore depend on the quality and availability of all these components to perform well for any specific language and may reproduce assumptions that align with features of the English language and that do not always transfer well to features of other languages. For example, some default tokenizing procedures assume that words are series of characters separated by a space. This might work well for English and other alphabet-based languages such as French, but character-based language, such as Chinese, handle word boundaries very differently. Tokenizing a text in Chinese may therefore involve artificially inserting spaces between characters, a process known as segmentation (see Melanie Walsh’s [“Text Pre-Processing for Chinese”](https://melaniewalsh.github.io/Intro-Cultural-Analytics/05-Text-Analysis/Multilingual/Chinese/01-Preprocessing-Chinese.html) for an introduction). For languages written in Latin or Cyrillic alphabets, [combining diacritical marks](https://en.wikipedia.org/wiki/Combining_Diacritical_Marks) can pose unique issues that will have to be dealt with when working with the text, as the diacritical marks are represented as a separate Unicode character from the letter(s) they are applied to (e.g., tokenizing a word into its component letters would have to take this into account).

As it stands, many of the resources available for learning computational methods of text analysis privilege English-language texts and corpora. These resources often omit information necessary to begin working with non-English source material, and it might not always be clear how to use or adapt these tools when working with a variety of different languages. While support from already existing tools for non-English languages is often lacking, it is improving in quality with the introduction of a greater quantity of high quality models for processing a variety of languages. For the languages focused on in this tutorial, for example – Russian and French – support for performing tasks such as part-of-speech tagging has been expanded with the introduction and refinement of models from spaCy and Stanza. Still, many tutorials and tools you encounter will default to or emphasize English-language compatibility in their approaches. It is also worth noting that the forms of English represented in these tools and tutorials tends to be limited to Standard English, and that other forms of the language are likewise underrepresented.

While this focus on English text can pose a challenge for working with non-English texts written in a single language, multilingual texts – or texts written in more than one language – can present their own challenges, such as detecting which language is present at a given point in the text or working with different text encodings. If methods often privilege English language assumptions, they are also often conceived to work with monolingual texts and do not perform well with texts that contain many different languages. For example, as discussed later in this lesson, the commonly recommended sentence tokenizer for NLTK (PunktSentenceTokenizer) is trained to work with only one language at a time and therefore won’t be the best option when working with multilingual text. This lesson will show how models can be applied to target specific languages within a text to maximize accuracy and avoid improperly or inaccurately parsing text. 

In this lesson, we compare NLTK, spaCy, and Stanza since they all contain models that can navigate and parse the properties of many languages. However, you may still have to adjust your approach and workflow to suit the individual needs of the language(s) and texts you are working with. There are a number of things to consider when working with computational analysis of non-English text, many of them specific to the language(s) your texts are written in. Factors such as a text’s script, syntax, and the presence of suitable algorithms for performing a task as well as relevant and sufficient examples in training data can all affect the results of computational methods applied to a text. In your own work, it’s always best to thorough think through an approach and look into the assumptions of particular methods (such as looking into the documentation of a particular method) before applying them to your texts in order to assess how that approach suits your personal research or project-based needs. Being flexible and open to changing your workflow as you go is also helpful.

For further reading on these topics, please consult the brief bibliography below:
* Agarwal, M., Otten, J., & Anastasopoulos, A. (2024). Script-agnostic language identification. arXiv.org. [https://doi.org/10.48550/arXiv.2406.17901](https://doi.org/10.48550/arXiv.2406.17901) 
* Dombrowski, Q. (2020). Preparing Non-English Texts for Computational Analysis. Modern Languages Open, 1. [https://doi.org/10.3828/mlo.v0i0.294](https://doi.org/10.3828/mlo.v0i0.294) 
* Fiormonte, Domenico. 2012. “Towards a Cultural Critique of the Digital Humanities: Zu Einer Kulturkritik Der Digitalen Geisteswissenschaften.” Historical Social Research 37 (3): 59–76. [https://doi.org/10.12759/hsr.37.2012.3.59-76](https://doi.org/10.12759/hsr.37.2012.3.59-76). 
* Velden, Mariken A. C. G. van der, Martijn Schoonvelde, and Christian Baden. 2023. “Introduction to the Special Issue on Multilingual Text Analysis.” Computational Communication Research 5 (2). [https://doi.org/10.5117/CCR2023.2.1.VAND](https://doi.org/10.5117/CCR2023.2.1.VAND).
* Wang, Qing. 2018. “Distribution Features and Intellectual Structures of Digital Humanities: A Bibliometric Analysis.” Journal of Documentation 74 (1): 223–46. [https://doi.org/10.1108/JD-05-2017-0076](https://doi.org/10.1108/JD-05-2017-0076).
* “What’s a ‘Word’: Multilingual DH and the English Default.” 2020. Quinn Dombrowski. October 15, 2020. [https://quinndombrowski.com/blog/2020/10/15/whats-word-multilingual-dh-and-english-default/undefined.](https://quinndombrowski.com/blog/2020/10/15/whats-word-multilingual-dh-and-english-default/undefined).



## Tools We’ll Cover:
We will use the tools below in this lesson, which were chosen due to their support for multilingual text analysis and NLP, robust user communities, and open source status. While all of the tools below are widely used and reliable, they each have different strengths and features: they cover different languages, they use different syntax and data structures when interacting with them programatically, and each focus on slightly different use cases. By going over their main features and comparing how we interact with them in the coding portion of this lesson, you will be able to develop a basic familiarity with each package that can guide which one(s) you choose for your own projects.

### The Natural Language Toolkit (NLTK):

- [NLTK](https://www.nltk.org/index.html) is a suite of libraries for building Python programs to work with language data. Originally released in 2001, NLTK has excellent documentation and an active, engaged community of users that make it an excellent tool to learn and experiment with when beginning to work with text processing. More advanced users will find its wide variety of libraries and corpora useful, as well, and its structure makes it very easy to integrate into one’s own pipelines and workflows.
- It supports different numbers of languages for different tasks: it contains lists of stopwords for 23 languages, for example, but only has built-in support for word tokenization in 18 languages. Stopwords are words which are filtered out of a text during processing, often because they are deemed unimportant for the task being performed (e.g., the word "the" may be removed to focus on other vocabulary in the text).
- For further reference, the [NLTK Book](https://www.nltk.org/book/) is an excellent reference, as is the official documentation linked above. The book and documentation are only available in English.

### spaCy:

- [spaCy](https://spacy.io/usage/spacy-101) has built-in support for a greater variety of languages than NLTK, with pretrained models of differing levels of complexity available for download. If you want to save time on processing speed you can use a smaller, less accurate model to perform something like part-of-speech tagging on a simple text, for example, rather than a more complex model that may return more accurate results but take longer to download and run. 
- spaCy is known for its high speed and efficient processing, and is often faster than NLTK and Stanza.
- Overall, spaCy focuses more on being a self-contained tool than NLTK. Rather than integrating NLTK with a separate visualization library such as [matplotlib](https://matplotlib.org/), for example, spaCy has its own visualization tools, such as [displaCy](https://demos.explosion.ai/displacy), that can be used in conjunction with its analysis tools to visualize your results.
- Documentation for spaCy is only available in English, but the library supports pipelines for 25 different languages. Over 20 more languages are also supported, but do not yet have pipelines (meaning only select features, such as stopwords, may be supported for those languages). For more information on supported languages, please consult [this documentation](https://spacy.io/usage/models#languages).

### Stanza:

- While often slower than NLTK and spaCy, [Stanza](https://stanfordnlp.github.io/stanza/#getting-started) has language models available not accessible through the other libraries. The package contains pretrained neural models supporting [70 languages](https://stanfordnlp.github.io/stanza/models.html#human-languages-supported-by-stanza). A full list of its models can be viewed [here](https://stanfordnlp.github.io/stanza/performance.html), and more information on its pipelines is available [here](https://stanfordnlp.github.io/stanza/neural_pipeline.html). Stanza's pipelines are built with neural network components trained on multilingual corpora, meaning they have used machine learning algorithms trained on annotated text rather than parameter-based approaches to NLP (e.g., comparing words in a text to a predefined dictionary).
- Stanza was built with multilingual support in mind from the start, and working with text in different languages feels very intuitive and natural with the library’s syntax.
- Running a pipeline on a text is extremely simple, and allows you to access various aspects of a text—for example, parts-of-speech and lemmas—with minimal coding.
- Documentation for Stanza is only available in English. For more information, please consult [this paper](https://aclanthology.org/2020.acl-demos.14/) on Stanza.

To summarize, all three packages can be very effective tools for analyzing a text in a non-English language (or multiple languages), and it’s worth investigating each package’s syntax and capabilities to see which one best suits your individual needs for a given project.

## Sample Code and Exercises:
During the coding portion of the lesson, we will take an excerpt of text from _War and Peace_ in the original Russian, which contains a substantial amount of French text, and show how to split it into sentences, detect the language of each sentence, and perform some simple analysis methods on the text. The text file we will be using contains an excerpt from the first book of the novel, and was sourced from Wikipedia. It can be downloaded [here](https://raw.githubusercontent.com/programminghistorian/ph-submissions/gh-pages/assets/analyzing-multilingual-text-nltk-spacy-stanza/war-and-peace-excerpt.txt). This is the only textual resource you'll need to go through the lesson. If you would like to follow along in a Jupyter notebook, the code below is included in the notebook [here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/analyzing-multilingual-text-nltk-spacy-stanza/analyzing-multilingual-text-nltk-spacy-stanza.ipynb).

If you would like to work through the lesson without loading the file, you can use the following text as a string instead:

```python
war_and_peace = """
— Eh bien, mon prince. Gênes et Lucques ne sont plus que des apanages, des поместья, de la famille Buonaparte. Non, je vous préviens, que si vous ne me dites pas, que nous avons la guerre, si vous vous permettez encore de pallier toutes les infamies, toutes les atrocités de cet Antichrist (ma parole, j’y crois) — je ne vous connais plus, vous n’êtes plus mon ami, vous n’êtes plus мой верный раб, comme vous dites. Ну, здравствуйте, здравствуйте. Je vois que je vous fais peur, садитесь и рассказывайте.

Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер. Анна Павловна кашляла несколько дней, у нее был грипп, как она говорила (грипп был тогда новое слово, употреблявшееся только редкими). В записочках, разосланных утром с красным лакеем, было написано без различия во всех:

«Si vous n’avez rien de mieux à faire, M. le comte (или mon prince), et si la perspective de passer la soirée chez une pauvre malade ne vous effraye pas trop, je serai charmée de vous voir chez moi entre 7 et 10 heures. Annette Scherer».

— Dieu, quelle virulente sortie! — отвечал, нисколько не смутясь такою встречей, вошедший князь, в придворном, шитом мундире, в чулках, башмаках, и звездах, с светлым выражением плоского лица.

Он говорил на том изысканном французском языке, на котором не только говорили, но и думали наши деды, и с теми тихими, покровительственными интонациями, которые свойственны состаревшемуcя в свете и при дворе значительному человеку. Он подошел к Анне Павловне, поцеловал ее руку, подставив ей свою надушенную и сияющую лысину, и покойно уселся на диване.

— Avant tout dites moi, comment vous allez, chère amie? Успокойте меня, — сказал он, не изменяя голоса и тоном, в котором из-за приличия и участия просвечивало равнодушие и даже насмешка.
"""
```

### Loading and Preparing the Text

First, let's load our text file so we can use it with our analysis packages. We'll open the file and assign it to the variable named "war_and_peace" so we can reference it later on. Then, we'll print the contents of the file to make sure it was read correctly. We are using a minimally pre-processed excerpt of the novel for the purposes of this tutorial.


```python
with open("war_and_peace_excerpt.txt") as file:
    war_and_peace = file.read()
    print(war_and_peace)
```

Output:
```
— Eh bien, mon prince. Gênes et Lucques ne sont plus que des apanages, des поместья, de la famille Buonaparte. Non, je vous préviens, que si vous ne me dites pas, que nous avons la guerre, si vous vous permettez encore de pallier toutes les infamies, toutes les atrocités de cet Antichrist (ma parole, j’y crois) — je ne vous connais plus, vous n’êtes plus mon ami, vous n’êtes plus мой верный раб, comme vous dites. Ну, здравствуйте, здравствуйте. Je vois que je vous fais peur, садитесь и рассказывайте.

Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер. Анна Павловна кашляла несколько дней, у нее был грипп, как она говорила (грипп был тогда новое слово, употреблявшееся только редкими). В записочках, разосланных утром с красным лакеем, было написано без различия во всех:

«Si vous n’avez rien de mieux à faire, M. le comte (или mon prince), et si la perspective de passer la soirée chez une pauvre malade ne vous effraye pas trop, je serai charmée de vous voir chez moi entre 7 et 10 heures. Annette Scherer».

— Dieu, quelle virulente sortie! — отвечал, нисколько не смутясь такою встречей, вошедший князь, в придворном, шитом мундире, в чулках, башмаках, и звездах, с светлым выражением плоского лица.

Он говорил на том изысканном французском языке, на котором не только говорили, но и думали наши деды, и с теми тихими, покровительственными интонациями, которые свойственны состаревшемуcя в свете и при дворе значительному человеку. Он подошел к Анне Павловне, поцеловал ее руку, подставив ей свою надушенную и сияющую лысину, и покойно уселся на диване.

— Avant tout dites moi, comment vous allez, chère amie? Успокойте меня, — сказал он, не изменяя голоса и тоном, в котором из-за приличия и участия просвечивало равнодушие и даже насмешка.
```

Now, let’s remove the newline characters. We will replace all newlines (represented as a “\n” in the code) with a space (represented with a “ “), assigning the cleaned text to a new variable named “cleaned_war_and_peace” and print it to check what we’ve done. Replacing the newline characters with a space will combine the text into a continuous string without the extra newlines. We’re doing this because in the next step we want to tokenize our text into sentences so that we can assess the language of each sentence. Removing newlines will homogenize the text and ensure that the tokenizer is not mislead into creating sentence splits where there shouldn’t be any. This is the only modification to the text that we will be doing for the purposes of this lesson, but for a good introduction to the different steps you can take to prepare your text for multilingual analysis, please consult [this article.](https://modernlanguagesopen.org/articles/10.3828/mlo.v0i0.294) 


```python
cleaned_war_and_peace = war_and_peace.replace("\n", " ")
print(cleaned_war_and_peace)
```

Output:
```
— Eh bien, mon prince. Gênes et Lucques ne sont plus que des apanages, des поместья, de la famille Buonaparte. Non, je vous préviens, que si vous ne me dites pas, que nous avons la guerre, si vous vous permettez encore de pallier toutes les infamies, toutes les atrocités de cet Antichrist (ma parole, j’y crois) — je ne vous connais plus, vous n’êtes plus mon ami, vous n’êtes plus мой верный раб, comme vous dites. Ну, здравствуйте, здравствуйте. Je vois que je vous fais peur, садитесь и рассказывайте.  Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер. Анна Павловна кашляла несколько дней, у нее был грипп, как она говорила (грипп был тогда новое слово, употреблявшееся только редкими). В записочках, разосланных утром с красным лакеем, было написано без различия во всех:  «Si vous n’avez rien de mieux à faire, M. le comte (или mon prince), et si la perspective de passer la soirée chez une pauvre malade ne vous effraye pas trop, je serai charmée de vous voir chez moi entre 7 et 10 heures. Annette Scherer».  — Dieu, quelle virulente sortie! — отвечал, нисколько не смутясь такою встречей, вошедший князь, в придворном, шитом мундире, в чулках, башмаках, и звездах, с светлым выражением плоского лица.  Он говорил на том изысканном французском языке, на котором не только говорили, но и думали наши деды, и с теми тихими, покровительственными интонациями, которые свойственны состаревшемуcя в свете и при дворе значительному человеку. Он подошел к Анне Павловне, поцеловал ее руку, подставив ей свою надушенную и сияющую лысину, и покойно уселся на диване.  — Avant tout dites moi, comment vous allez, chère amie? Успокойте меня, — сказал он, не изменяя голоса и тоном, в котором из-за приличия и участия просвечивало равнодушие и даже насмешка.      
```

Now that we've read the file and prepared our text, let’s begin to process it. First, we import our packages (NLTK, spaCy, and Stanza) that we installed earlier in the lesson so that we can use them to begin working on the text.


```python
import nltk
import spacy
import stanza
```

### Tokenization

Now that the libraries are imported, let's perform sentence tokenization on the text. Tokenization is simply splitting a text into smaller units, such as sentences or words, and allows us to break the text down to work with it and analyze it more effectively. In this tutorial, we'll begin by tokenizing using NLTK, then detect each sentence's language.


There are different sentence tokenizers included in the NLTK package. NLTK recommends using the PunktSentenceTokenizer for a language specified by the user (see the following for more information: https://www.nltk.org/api/nltk.tokenize.html), but if working with multilingual text this may not be the best approach. If you have a piece of text containing multiple languages, as we do for this example, you will be applying a tokenization model trained to work with one language to all of the languages in your text (if we selected French, for instance, the model's methods for tokenizing French text would be applied to the other languages in our text, for which it may be less effective). These language-specific models take into account cases particular to their respective languages--such as peculiarities in word or sentence boundaries common in those languages--rather than merely splitting by punctuation. For the purposes of this tutorial, we will use the sent_tokenize method built into NLTK without specifying a language, which will allow us to apply a basic tokenization algorithm that will work with both the Russian and French sentences in our example. For more advanced uses in which accuracy over a large body of text is important, it is preferable to apply the appropriate language models as appropriate.


```python
# first, let's install the 'punkt' resources required to use the tokenizer
import nltk
nltk.download('punkt')

# then we import the sent_tokenize method and apply it to our war_and_peace variable
from nltk.tokenize import sent_tokenize
nltk_sent_tokenized = sent_tokenize(cleaned_war_and_peace)
# if you were going to specify a language, the following syntax would be used: nltk_sent_tokenized = sent_tokenize(war_and_peace, language="russian")
```

The entire text is now accessible as a list of sentences within the variable nltk_sent_tokenized. We can easily figure out which sentences are in which languages because we are working with a small selection of text as an example, but when working with a larger amount of textual data finding sentences may require more in-depth analysis of the text. The code example below will loop through all of the sentences in our list, printing each on a new line to allow for easy assessment:

```python
# printing each sentence in our list
for sent in nltk_sent_tokenized:
  print(sent)
```
Output:
```
— Eh bien, mon prince.
Gênes et Lucques ne sont plus que des apanages, des поместья, de la famille Buonaparte.
Non, je vous préviens, que si vous ne me dites pas, que nous avons la guerre, si vous vous permettez encore de pallier toutes les infamies, toutes les atrocités de cet Antichrist (ma parole, j’y crois) — je ne vous connais plus, vous n’êtes plus mon ami, vous n’êtes plus мой верный раб, comme vous dites.
Ну, здравствуйте, здравствуйте.
Je vois que je vous fais peur, садитесь и рассказывайте.
Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер.
Анна Павловна кашляла несколько дней, у нее был грипп, как она говорила (грипп был тогда новое слово, употреблявшееся только редкими).
В записочках, разосланных утром с красным лакеем, было написано без различия во всех:  «Si vous n’avez rien de mieux à faire, M. le comte (или mon prince), et si la perspective de passer la soirée chez une pauvre malade ne vous effraye pas trop, je serai charmée de vous voir chez moi entre 7 et 10 heures.
Annette Scherer».
— Dieu, quelle virulente sortie!
— отвечал, нисколько не смутясь такою встречей, вошедший князь, в придворном, шитом мундире, в чулках, башмаках, и звездах, с светлым выражением плоского лица.
Он говорил на том изысканном французском языке, на котором не только говорили, но и думали наши деды, и с теми тихими, покровительственными интонациями, которые свойственны состаревшемуcя в свете и при дворе значительному человеку.
Он подошел к Анне Павловне, поцеловал ее руку, подставив ей свою надушенную и сияющую лысину, и покойно уселся на диване.
— Avant tout dites moi, comment vous allez, chère amie?
Успокойте меня, — сказал он, не изменяя голоса и тоном, в котором из-за приличия и участия просвечивало равнодушие и даже насмешка.
```

Let's print three sentences we'll be working with: one entirely in Russian, one entirely in French, and one that is in both languages. The language of the sentences will become important as we apply different methods to the sentences later in the lesson.


```python
# printing the Russian sentence at index 5 in our list of sentences
rus_sent = nltk_sent_tokenized[5]
print('Russian: ' + rus_sent)

# printing the French sentence at index 2
fre_sent = nltk_sent_tokenized[13]
print('French: ' + fre_sent)

# printing the sentence in both French and Russian at index 4
multi_sent = nltk_sent_tokenized[4]
print('Multilang: ' + multi_sent)
```

Output:

```
Russian: Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер.
French: — Avant tout dites moi, comment vous allez, chère amie?
Multilang: Je vois que je vous fais peur, садитесь и рассказывайте.
```

Now let's perform the same sentence tokenization using spaCy, grabbing the same sample of three sentences. As you can see, the syntax with spaCy is quite different. In addition to having a multilingual sentence tokenizer built in to the library, the list of sentences tokenized by the spaCy model is accessed by first applying the model to the text by calling the "nlp" method, then by accessing the tokenized sentences by assigning the doc.sents tokens to a list.


```python
# downloading our multilingual sentence tokenizer
python -m spacy download xx_sent_ud_sm

# loading the multilingual sentence tokenizer we just downloaded
nlp = spacy.load("xx_sent_ud_sm")
# applying the spaCy model to our text variable
doc = nlp(cleaned_war_and_peace)

# assigning the tokenized sentences to a list so it's easier for us to manipulate them later
spacy_sentences = list(doc.sents)

# printing the sentences to our console
print(spacy_sentences)
```
Output:
```
[— Eh bien, mon prince., Gênes et Lucques ne sont plus que des apanages, des поместья, de la famille Buonaparte., Non, je vous préviens, que si vous ne me dites pas, que nous avons la guerre, si vous vous permettez encore de pallier toutes les infamies, toutes les atrocités de cet Antichrist (ma parole, j’y crois) — je ne vous connais plus, vous n’êtes plus mon ami, vous n’êtes plus мой верный раб, comme vous dites., Ну, здравствуйте, здравствуйте., Je vois que je vous fais peur, садитесь и рассказывайте.  , Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер., Анна Павловна кашляла несколько дней, у нее был грипп, как она говорила (грипп был тогда новое слово, употреблявшееся только редкими)., В записочках, разосланных утром с красным лакеем, было написано без различия во всех:  , «Si vous n’avez rien de mieux à faire, M. le comte (или mon prince), et si la perspective de passer la soirée chez une pauvre malade ne vous effraye pas trop, je serai charmée de vous voir chez moi entre 7 et 10 heures., Annette Scherer».  , — Dieu, quelle virulente sortie! — отвечал, нисколько не смутясь такою встречей, вошедший князь, в придворном, шитом мундире, в чулках, башмаках, и звездах, с светлым выражением плоского лица.  , Он говорил на том изысканном французском языке, на котором не только говорили, но и думали наши деды, и с теми тихими, покровительственными интонациями, которые свойственны состаревшемуcя в свете и при дворе значительному человеку., Он подошел к Анне Павловне, поцеловал ее руку, подставив ей свою надушенную и сияющую лысину, и покойно уселся на диване.  , — Avant tout dites moi, comment vous allez, chère amie?, Успокойте меня, — сказал он, не изменяя голоса и тоном, в котором из-за приличия и участия просвечивало равнодушие и даже насмешка.]
```

Let's assign our sentences to variables, like we did with NLTK. spaCy returns its sentences not as strings, but as spaCy tokens. In order to print them as we did with the NLTK sentences above, we'll need to convert them to strings (for more information on built-in types in Python, such as strings and integers, please consult [this documentation](https://docs.python.org/3/library/stdtypes.html)). This will allow us to concatenate them with the prefix identifying their language, as Python won't let us concatenate a string and a non-string type. Given our small sample dataset, we can easily specify our sentences using their indices in our list; to examine the entire list of sentences, as we might for a larger dataset, we would choose a different method to look at the strings, such as iterating through each item in the list (we do this with our Stanza tokens below).

```python
# concatenating the Russian sentence and its language label
spacy_rus_sent = str(spacy_sentences[5])
print('Russian: ' + spacy_rus_sent)

# concatenating the French sentence and its language label
spacy_fre_sent = str(spacy_sentences[13])
print('French: ' + spacy_fre_sent)

# concatenating the French and Russian sentence and its label
spacy_multi_sent = str(spacy_sentences[4])
print('Multilang: ' + spacy_multi_sent)
```

Output:
```
Russian: Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер.
French: — Avant tout dites moi, comment vous allez, chère amie?
Multilang: Je vois que je vous fais peur, садитесь и рассказывайте. 
```

We can see above that both models tokenized the sentences in the same way, as the NLTK and spaCy indices (5, 13, and 4) match to the same sentences from the text. Now, let's perform the same operation with Stanza, using its built-in multilingual pipeline. Stanza uses pipelines to pre-load and chain up a series of processors, with each processor performing a specific NLP task (e.g., tokenization, dependency parsing, or named entity recognition). For more information on Stanza's pipelines, please consult [this documentation](https://stanfordnlp.github.io/stanza/getting_started.html).


```python
from stanza.pipeline.multilingual import MultilingualPipeline

# setting up our tokenizer pipeline
nlp = MultilingualPipeline(processors='tokenize')

# applying the pipeline to our text
doc = nlp(cleaned_war_and_peace)

# printing all sentences to see how they tokenized
print([sentence.text for sentence in doc.sentences])
```

Output:
```
['— Eh bien, mon prince.', 'Gênes et Lucques ne sont plus que des apanages, des поместья, de la famille Buonaparte.', 'Non, je vous préviens, que si vous ne me dites pas, que nous avons la guerre, si vous vous permettez encore de pallier toutes les infamies, toutes les atrocités de cet Antichrist (ma parole, j’y crois) — je ne vous connais plus, vous n’êtes plus mon ami, vous n’êtes plus мой верный раб, comme vous dites.', 'Ну, здравствуйте, здравствуйте.', 'Je vois que je vous fais peur, садитесь и рассказывайте.', 'Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер.', 'Анна Павловна кашляла несколько дней, у нее был грипп, как она говорила (грипп был тогда новое слово, употреблявшееся только редкими).', 'В записочках, разосланных утром с красным лакеем, было написано без различия во всех:  «Si vous n’avez rien de mieux à faire, M. le comte (или mon prince), et si la perspective de passer la soirée chez une pauvre malade ne vous effraye pas trop, je serai charmée de vous voir chez moi entre 7 et 10 heures.', 'Annette Scherer».', '— Dieu, quelle virulente sortie! — отвечал, нисколько не смутясь такою встречей, вошедший князь, в придворном, шитом мундире, в чулках, башмаках, и звездах, с светлым выражением плоского лица.', 'Он говорил на том изысканном французском языке, на котором не только говорили, но и думали наши деды, и с теми тихими, покровительственными интонациями, которые свойственны состаревшемуcя в свете и при дворе значительному человеку.', 'Он подошел к Анне Павловне, поцеловал ее руку, подставив ей свою надушенную и сияющую лысину, и покойно уселся на диване.', '— Avant tout dites moi, comment vous allez, chère amie?', 'Успокойте меня, — сказал он, не изменяя голоса и тоном, в котором из-за приличия и участия просвечивало равнодушие и даже насмешка.']
```

Now, let's find the same sentences we did with NLTK and spaCy above. Like spaCy, Stanza converts its processed text to tokens that behave differently from strings.

First, let's add the sentence tokens to a list, converting them to strings. This makes it easier for us to look at specific sentences by their indices. Stanza tokenizes the sentences in the text differently, so we had to change our index for the French sentence from 13 to 12 to make sure our variables stay the same.


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
stanza_fre_sent = str(stanza_sentences[12])
print('French: ' + stanza_fre_sent)

# printing our sentence in both French and Russian
stanza_multi_sent = str(stanza_sentences[4])
print('Multilang: ' + stanza_multi_sent)
```

Output:
```
Russian: Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер.
French: — Avant tout dites moi, comment vous allez, chère amie?
Multilang: Je vois que je vous fais peur, садитесь и рассказывайте.
```


### Automatically Detecting Different Languages

Now that we have three sentences to use as examples, we can begin to perform our analysis of each one. First, let's detect the language of each sentence computationally, starting with the monolingual examples.

NLTK includes a module called TextCat that supports language identification using the TextCat algorithm; for further information, please consult the documentation for the module [at this link](https://www.nltk.org/_modules/nltk/classify/textcat.html). This algorithm applies n-gram frequencies (n-grams are sequences of n adjacent symbols, such as letters or syllables, in a particular order) to profile languages and the text we're analyzing, then compares the two using a distance measure to estimate the language of the text. It does not provide the possibility of printing its probability estimate for a particular language estimate. Let's try the module on our sentences below.


```python
# downloading an NLTK corpus reader required by the TextCat module
nltk.download('crubadan')

# loading the TextCat package and applying it to each of our sentences
tcat = nltk.classify.textcat.TextCat()
rus_estimate = tcat.guess_language(rus_sent)
fre_estimate = tcat.guess_language(fre_sent)
multi_estimate = tcat.guess_language(multi_sent)

# printing the results
print('Russian estimate: ' + rus_estimate)
print('French estimate: ' + fre_estimate)
print('Multilingual estimate: ' + multi_estimate)
```

Output:
```
Russian estimate: rus
French estimate: fra
Multilingual estimate: rus
```

As we can see, TextCat correctly identified the Russian and French sentences. Since it can't output more than one language per sentence, it guessed Russian for our multilingual sentence. We'll examine other ways to handle language detection for multilingual sentences after we perform our sentence classification using spaCy and Stanza. Let's try spaCy first:


```python
# first, we install the spacy_langdetect package from the Python Package Index
pip install spacy_langdetect

# then we import it and use it to detect our languages
from spacy.language import Language
from spacy_langdetect import LanguageDetector

# setting up our language detector to work with spaCy
# def get_lang_detector(nlp, name):
#     return LanguageDetector()

# setting up our pipeline
Language.factory("language_detector")
nlp.add_pipe('language_detector', last=True)

# running the language detection on each sentence and printing the results
rus_doc = nlp(spacy_rus_sent)
print(rus_doc._.language)

fre_doc = nlp(spacy_fre_sent)
print(fre_doc._.language)

multi_doc = nlp(spacy_multi_sent)
print(multi_doc._.language)
```
Output:
```
{'language': 'ru', 'score': 0.9999978739911013}
{'language': 'fr', 'score': 0.999995246346788}
{'language': 'ru', 'score': 0.7142842829707301}
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

Output:
```
Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер.	ru
— Avant tout dites moi, comment vous allez, chère amie?	fr
Je vois que je vous fais peur, садитесь и рассказывайте.	fr
```

We can see that Stanza classified the final sentence as French, deviating from the other models.

For multilingual sentences, classifying both languages within the same sentence is not a simple problem to solve, and requires more granular analysis than a sentence-by-sentence approach. One method to detect all of the languages contained in a single sentence, for example, would be to break the sentence into its component words and then try to detect the language of each word--which will have questionable accuracy, given that we are only looking at one word at a time--and then group consecutive words of the same language within the string into new strings consisting only of one language. For our particular case study here, a workaround would be to detect non-Roman script and split the string into its component languages that way. Here is a simple implementation:

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
  if word in punctuation:
    continue
  else:
    if regex.search(r'\p{IsCyrillic}', word):
      cyrillic_words.append(word)
    else:
        latin_words.append(word)


print(cyrillic_words)
print(latin_words)
```

Output:
```
['садитесь', 'и', 'рассказывайте']
['Je', 'vois', 'que', 'je', 'vous', 'fais', 'peur']
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
print('Cyrillic estimate: ' + multi_estimate_1)
print('Latin estimate: ' + multi_estimate_2)
```

Output:
```
Cyrillic estimate: rus
Latin estimate: fra
```

Of course, this method may not work as well on a different text. We benefit, for example, from having only one language in our text that uses the Cyrillic alphabet; if we were comparing a text with multiple languages both written in Cyrillic, we could take a different approach--such as identifying certain Cyrillic characters present only in one of the languages and not the other, or used more commonly in one than the other--to split our languages into separate lists.

### Part-of-Speech Tagging

Now, let's perform part-of-speech tagging for our sentences using spaCy and Stanza.

NLTK does not support POS tagging on languages other than English out-of-the-box, but you can train your own model using a corpus to tag languages other than English. Documentation on the tagger, and how to train your own, can be found [here.](https://www.nltk.org/book/ch05.html#sec-n-gram-tagging)

Tagging our sentences with spaCy is very straightforward. Since we know we're working with Russian and French, we can download the appropriate spaCy models and use them to get the proper POS tags for the words in our sentences. The syntax remains the same regardless of which language model we use. We'll begin with Russian:

```python
# downloading our Russian model from spaCy
python -m spacy download ru_core_news_sm


# loading the model
nlp = spacy.load("ru_core_news_sm")

# applying the model
doc = nlp(spacy_rus_sent)

# printing the text of each word and its POS tag
for token in doc:
    print(token.text, token.pos_)
```

Output:
```
Так ADV
говорила VERB
в ADP
июле NOUN
1805 ADJ
года NOUN
известная ADJ
Анна PROPN
Павловна PROPN
Шерер PROPN
, PUNCT
фрейлина NOUN
и CCONJ
приближенная ADJ
императрицы NOUN
Марии PROPN
Феодоровны PROPN
, PUNCT
встречая VERB
важного ADJ
и CCONJ
чиновного ADJ
князя NOUN
Василия PROPN
, PUNCT
первого ADJ
приехавшего VERB
на ADP
ее DET
вечер NOUN
. PUNCT
```


Now, we can do the same for our French sentence.

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

Output:
```
— PUNCT
Avant ADP
tout ADV
dites VERB
moi PRON
, PUNCT
comment ADV
vous PRON
allez VERB
, PUNCT
chère ADJ
amie NOUN
? PUNCT
```

For multilingual text, we can use the words we generated earlier to tag each language separately, then join the words back into a complete sentence again.

Below, we split our sentence into Russian and French words as before, only this time we preserve the punctuation by appending any punctuation we encounter to the last list we appended to, preserving the proper placement of each punctuation mark (e.g., it will append a period to the word it should follow). This will be useful to anyone who wishes to preserve the punctuation of the original text as part of their analysis. To do this, we need a new variable--"last_appended_list"--to use as a way to keep track of which track we last appended to. We update this variable to track which list we last appended to, allowing us to append any puncutation we encounter to the correct list to preserve its place in the sentence. If a period followed the word "bonjour," for example, we would know the last list we appended to was latin_words, as we had updated our variable last_appended_list within our loop to reflect this. Thus, we could append the period to the latin_words list, where it would follow the word preceding it.


```python
# creating our blank lists to append to later
cyrillic_words_punct = []
latin_words_punct = []

# initializing a blank string to keep track of the last list we appended to
last_appended_list = ''

# iterating through our words and appending based on whether a Cyrillic character was detected
for word in tokenized_sent:
  if regex.search(r'\p{IsCyrillic}', word):
    cyrillic_words_punct.append(word)
    # updating our string to track the list we appended a word to
    last_appended_list = 'cyr'
  else:
    # handling punctuation by appending it to our most recently used list
    if word in punctuation:
        if last_appended_list == 'cyr':
            cyrillic_words_punct.append(word)
        elif last_appended_list == 'lat':
            latin_words_punct.append(word)
    else:
        latin_words.append(word)
        last_appended_list = 'lat'

print(cyrillic_words)
print(latin_words)
```

Output:
```
['садитесь', 'и', 'рассказывайте', '.']
['Je', 'vois', 'que', 'je', 'vous', 'fais', 'peur', ',']
```

We can then join these lists into strings to run our language detection on them. We'll use a regular expression to remove the extra whitespace before each punctuation mark that was created when we tokenized the sentence into words. This will preserve the punctuation as it was present in the original sentence.


```python
# joining the lists to strings
cyrillic_only_list = ' '.join(cyrillic_words)
latin_only_list = ' '.join(latin_words)

# using our regular expression to remove extra whitespace before the punctuation marks
cyr_no_extra_space = regex.sub(r'\s([?.!,"](?:\s|$))', r'\1', cyrillic_only_list)
lat_no_extra_space = regex.sub(r'\s([?.!,"](?:\s|$))', r'\1', latin_only_list)

# checking the results of the regular expression above
print(cyr_no_extra_space)
print(lat_no_extra_space)
```

Output:
```
садитесь и рассказывайте.
Je vois que je vous fais peur,
```

Finally, we can tag each list of words using the appropriate language model.


```python
# loading and applying the model
nlp = spacy.load("ru_core_news_sm")
doc = nlp(cyr_no_extra_space)

# printing the text of each word and its POS tag
for token in doc:
    print(token.text, token.pos_)

# and doing the same with our French sentence
nlp = spacy.load("fr_core_news_sm")
doc = nlp(lat_no_extra_space)
for token in doc:
    print(token.text, token.pos_)
```

Output:
```
садитесь VERB
и CCONJ
рассказывайте VERB
. PUNCT
Je PRON
vois VERB
que SCONJ
je PRON
vous PRON
fais VERB
peur NOUN
, PUNCT
```

Now, let's perform POS tagging using Stanza. The syntax is quite straightforward; we'll start with Russian:


```python
# loading our pipeline and applying it to our sentence, specifying our language as Russian ('ru')
nlp = stanza.Pipeline(lang='ru', processors='tokenize,pos')
doc = nlp(stanza_rus_sent)

# printing our words and POS tags
print(*[f'word: {word.text}\tupos: {word.upos}' for sent in doc.sentences for word in sent.words], sep='\n')
```

Output:
```
word: Так	upos: ADV
word: говорила	upos: VERB
word: в	upos: ADP
word: июле	upos: NOUN
word: 1805	upos: ADJ
word: года	upos: NOUN
word: известная	upos: ADJ
word: Анна	upos: PROPN
word: Павловна	upos: PROPN
word: Шерер	upos: PROPN
word: ,	upos: PUNCT
word: фрейлина	upos: NOUN
word: и	upos: CCONJ
word: приближенная	upos: VERB
word: императрицы	upos: NOUN
word: Марии	upos: PROPN
word: Феодоровны	upos: PROPN
word: ,	upos: PUNCT
word: встречая	upos: VERB
word: важного	upos: ADJ
word: и	upos: CCONJ
word: чиновного	upos: ADJ
word: князя	upos: NOUN
word: Василия	upos: PROPN
word: ,	upos: PUNCT
word: первого	upos: ADJ
word: приехавшего	upos: VERB
word: на	upos: ADP
word: ее	upos: DET
word: вечер	upos: NOUN
word: .	upos: PUNCT
```

And doing the same for our French sentence follows the same syntax:


```python
# loading our pipeline and applying it to our sentence, specifying our language as French ('fr')
nlp = stanza.Pipeline(lang='fr', processors='tokenize,mwt,pos')
doc = nlp(stanza_fre_sent)

# printing our words and POS tags
print(*[f'word: {word.text}\tupos: {word.upos}' for sent in doc.sentences for word in sent.words], sep='\n')
```

Output:
```
word: —	upos: PUNCT
word: Avant	upos: ADP
word: tout	upos: PRON
word: dites	upos: VERB
word: moi	upos: PRON
word: ,	upos: PUNCT
word: comment	upos: ADV
word: vous	upos: PRON
word: allez	upos: VERB
word: ,	upos: PUNCT
word: chère	upos: ADJ
word: amie	upos: NOUN
word: ?	upos: PUNCT
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

Output:
```
word: Так	upos: ADV
word: говорила	upos: VERB
word: в	upos: ADP
word: июле	upos: NOUN
word: 1805	upos: ADJ
word: года	upos: NOUN
word: известная	upos: ADJ
word: Анна	upos: PROPN
word: Павловна	upos: PROPN
word: Шерер	upos: PROPN
word: ,	upos: PUNCT
word: фрейлина	upos: NOUN
word: и	upos: CCONJ
word: приближенная	upos: VERB
word: императрицы	upos: NOUN
word: Марии	upos: PROPN
word: Феодоровны	upos: PROPN
word: ,	upos: PUNCT
word: встречая	upos: VERB
word: важного	upos: ADJ
word: и	upos: CCONJ
word: чиновного	upos: ADJ
word: князя	upos: NOUN
word: Василия	upos: PROPN
word: ,	upos: PUNCT
word: первого	upos: ADJ
word: приехавшего	upos: VERB
word: на	upos: ADP
word: ее	upos: DET
word: вечер	upos: NOUN
word: .	upos: PUNCT
```

### Lemmatization

Finally, let's perform lemmatization on our sentences using spaCy and Stanza (NLTK does not provide out-of-the-box lemmatization for non-English languages). Lemmatization is the process of grouping together the inflected forms of a word so they can be analysed as a single item, identified by the word's lemma, or dictionary form. The word "typed," for example, would be reduced to the lemma "type," removing the "-d" suffix to return the word to a more basic form.

spaCy does not have a single multingual lemmatization corpus, so we'll have to run separate models on our Russian and French text and split our multilingual sentence into its component parts again. For more info on lemmatization using spaCy, including a list of supported languages, visit spaCy's [lemmatizer documentation](https://spacy.io/api/lemmatizer).


```python
# loading and applying our Russian model
nlp = spacy.load("ru_core_news_sm")
doc = nlp(spacy_rus_sent)


# printing each word alongside its lemma
for token in doc:
    print(token, token.lemma_)

# loading and applying our French model
nlp = spacy.load("fr_core_news_sm")
doc = nlp(spacy_fre_sent)

# again printing each word alongside its lemma
for token in doc:
    print(token, token.lemma_)
```

Output:
```


Так так
говорила говорить
в в
июле июль
1805 1805
года год
известная известный
Анна анна
Павловна павлович
Шерер шерер
, ,
фрейлина фрейлина
и и
приближенная приближённый
императрицы императрица
Марии мария
Феодоровны феодоровны
, ,
встречая встречать
важного важный
и и
чиновного чиновный
князя князь
Василия василий
, ,
первого первый
приехавшего приехать
на на
ее она
вечер вечер
. .
— —
Avant avant
tout tout
dites dire
moi moi
, ,
comment comment
vous vous
allez aller
, ,
chère cher
amie amie
? ?
```



```python
# loading and applying the model
nlp = spacy.load("ru_core_news_sm")
doc = nlp(cyr_no_extra_space)

# printing the words and their lemmas
for token in doc:
    print(token, token.lemma_)
```

Output:
```
садитесь садитесь
и и
рассказывайте рассказывать
. .
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

Output:
```
Je je
vois voir
que que
je je
vous vous
fais faire
peur peur
, ,
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

Output:
```
Je je
vois voir
que que
je je
vous vous
fais faire
peur peur
, ,
```


## Conclusion:

You now have a basic knowledge of each package that can help guide your use of the packages for your personal projects. You also have a basic understanding of how to approach non-English text using computational tools, and some strategies for working with multilingual text that will help you develop methodologies and strategies for applying your own workflows to analyzing other multilingual texts. We covered how to tokenize text, automatically detect languages, and identify parts of speech and lemmatize text in different languages. These can be preprocessing steps to prepare for further text analyses, such as sentiment analysis or topic modeling, or may already provide some results for analyses that will be beneficial for your work. 

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
