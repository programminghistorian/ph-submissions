---
title: "Introduction to Text Analysis for Non-English and Multilingual Texts"
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

**Contents**

[...]
- Sample Code and Exercises
  - Loading a text and processing it into sentences and words
  - Identifying languages within a text
  - Part of Speech Tagging
  - Lemmatization
[...]

## Lesson Goals

This lesson will provide a solid introduction on how to begin analyzing a corpus of non-English and/or multilingual text using Python. We will go over the fundamentals of three commonly used packages for performing text analysis and natural language processing (NLP): the Natural Language Toolkit (NLTK), spaCy, and Stanza. We’ll review and compare the core features of the packages so you can become familiar with how they work and learn how to discern which tool is right for your specific use case and coding style.

We will also go through practical code examples that show how to perform the same tasks using each package: how to split a multilingual text into sentences and its component languages, detect the language of each sentence, and perform additional processing and analysis on each sentence as needed.

## Basics of Text Analysis

Computational text analysis is a broad term that encompasses a wide variety of approaches, methodologies, and tools that can be used to work with and analyze digital texts, from small-scale corpora and single texts to large amounts of textual data. Harnessing computational methods allows you to quickly perform tasks that are far more difficult to do without computational methods, such as:

- analyze very large corpora that would be too large to reasonably examine by hand
- quickly, easily analyze grammatical structures within a text
- efficiently generate visualizations representing characteristics of texts or corpora
- the meaning of patterns of frequency and distribution
- the function of syntactic units in texts
- the development of an author’s style over time
- and many more

Working with computational methods can also be used to support to support more traditional text analysis methods and techniques–for example, to aid in the close reading of a text by quantitatively analyzing its grammatical structures or peculiarities. Working with and developing an understanding of computational methods for analyzing a text can be its own reward, as well, even if its not something you plan to use in your professional or academic work. Developing skills in textual analysis both expands your skillset and opens up new avenues for exploration and understanding of a text, allowing you to experience new ways of looking at and thinking about textual information.

## Working with Non-English and Multilingual Text

There are a number of things to consider when working with computational analysis of non-English text, many of them specific to the script your language(s) are written in.

- Encodings
  - Text can be encoded in different ways, allowing computers to read, transform, and work with its characters. Unicode is the most commonly used encoding standard, and was designed to handle text from all of the world’s major writing systems. UTF-8 is one of the most common Unicode encodings, and the one that Python defaults to using for text. In this tutorial, we will be using UTF-8 by default when we work with our text in Python.
  - Other encodings you may want to be familiar with are ASCII–a subset of Unicode that only contains 128 characters, and doesn’t support scripts outside of standard Latin characters used in English–and other Unicode encodings beyond UTF-8, such as UTF-32. For most people’s purposes, however, working within UTF-8 will be sufficient.
- Right-to-left vs Left-to-right script
  - Working with scripts that read right-to-left can sometimes pose issues when processing text; there are special libraries that exist to support this (e.g., Arabic Reshaper, written in Python: <https://github.com/mpcabd/python-arabic-reshaper/tree/master>).
- Character-based languages often have properties that are not supported by many existing tools; the way Chinese handles word boundaries, for example, is very different than alphabet-based languages spoken in Europe. While there are tools specially made to navigate the properties of these languages, you may have to adjust your approach and workflow to suit the individual needs of the language(s) you are working with.
- Support from already existing tools for non-English languages is often lacking, but is improving in quality with the introduction of a greater quantity of high quality models for processing other languages. Still, many tutorials and tools you encounter will default to or emphasize English-language compatibility in their approaches.
- Detecting and engaging with the different languages in a single text is another issue that can be difficult to navigate, but we’ll go through some simple examples of how to do this in this tutorial. In your own work, it’s always best to thorough think through an approach before applying your methods to the text, considering how that approach suits your personal research or project-based needs. Being flexible and open to changing your workflow as you go is also helpful.

## Tools We’ll Cover

### The Natural Language Toolkit (NLTK)

- NLTK is a suite of libraries for building Python programs to work with language data. Originally released in 2001, NLTK has excellent documentation and an active, engaged community of users that make it an excellent tool to learn and experiment with when beginning to work with text processing. More advanced users will find its wide variety of libraries and corpora useful, as well, and its structure makes it very easy to integrate into one’s own pipelines and workflows.
- It supports different numbers of languages for different tasks (it contains lists of stopwords for 23 languages, for example, but only has built-in support for word tokenization in 18 languages).

### spaCy

- spaCy has built-in support for a greater variety of languages than NLTK, with models of differing levels of complexity available for download. If you want to save time on processing speed you can use a smaller, less accurate model on a simple text, for example, rather than a more complex model that may return more accurate results.
- spaCy is known for its high speed and efficient processing, and is often faster than NLTK and Stanza.
- Overall, spaCy focuses more on being a self-contained tool than NLTK. Rather than integrating NLTK with a separate visualization library such as [matplotlib](https://matplotlib.org/), for example, spaCy has its own visualization tools, such as [displaCy](https://demos.explosion.ai/displacy), that can be used in conjunction with its analysis tools to visualize your results.

### Stanza

- While often slower than NLTK and spaCy, Stanza has language models available not accessible through the other libraries. The package contains pretrained neural models supporting [](https://stanfordnlp.github.io/stanza/models.html#human-languages-supported-by-stanza)70 languages. A full list of its models can be viewed [here](https://stanfordnlp.github.io/stanza/performance.html).
- Stanza was built with multilingual support in mind from the start, and working with text in different languages feels very intuitive and natural with the library’s syntax.
- Running a pipeline on a text is extremely simple, and allows you to access various aspects of a text—for example, parts-of-speech and lemmas—with minimal coding.

To summarize, all three packages can be very effective tools for analyzing a text in a non-English language (or multiple languages), and it’s worth investigating each package’s syntax and capabilities to see which one best suits your individual needs for a given project.

## Sample Code and Exercises

We will now go through sample code to demonstrate performing the same tasks using each package. We will take a corpus of text from _War and Peace_ in the original Russian, which contains a substantial amount of French text, and show how to split it into sentences, detect the language of each sentence, and perform some simple analysis methods on the text.

The corpus was sourced from Wikipedia. It can be downloaded as a text file [here](https://ru.wikisource.org/wiki/%D0%92%D0%BE%D0%B9%D0%BD%D0%B0_%D0%B8_%D0%BC%D0%B8%D1%80_%28%D0%A2%D0%BE%D0%BB%D1%81%D1%82%D0%BE%D0%B9%29/%D0%A2%D0%BE%D0%BC_1). The text file we will be using contains an excerpt from the first book of the novel, can be downloaded [here](https://drive.google.com/file/d/1K5kmgqbNUFRDGD5it5foVHBgjJavdg5w/view?usp=sharing).

The code is available in this Google Colab notebook link: <https://colab.research.google.com/drive/145l0H0aT3my4esegMo_krvgIiKsEVVyb?usp=sharing>

## Conclusion

You now have a basic knowledge of each package that can help guide your use of the packages for your personal projects. You also have a basic understanding of how to approach non-English text using computational tools, and some strategies for working with multilingual text that will help you develop methodologies and strategies for applying your own workflows to analyzing other multilingual texts.

## Suggested Readings

**Related Programming Historian Lessons:**

The following lessons can help with other important aspects of working with textual data that can be applied to non-English and multilingual texts.

[Corpus Analysis with spaCy](https://programminghistorian.org/en/lessons/corpus-analysis-with-spacy)

This lesson is an in-depth look at analyzing a corpus using spaCy, and goes into details of spaCy’s capabilities and syntax we didn’t have time for in this lesson. This is a highly recommended read if you plan to use spaCy more in-depth for your work.

[Normalizing Textual Data with Python](https://programminghistorian.org/en/lessons/normalizing-data)

This lesson explains various methods of data normalization using Python, and will be very useful for anyone who needs a primer on how to prepare their textual data for computational analysis.

**Other resources about multilingual text analysis and DH:**

[Multilingual Digital Humanities](https://doi.org/10.4324/9781003393696)

A recently published book covering various topics and projects in the field of multilingual digital humanities, featuring a broad range of authors and geared toward an international audience. (Full disclosure: I have a chapter in this).

[multilingualdh.org](https://multilingualdh.org/en/)

The homepage for the Multilingual DH group, a “loosely-organized international network of scholars using digital humanities tools and methods on languages other than English.” The group’s [GitHub repository](https://github.com/multilingual-dh) has helpful resources, as well, including [this bibliography](https://github.com/multilingual-dh/multilingual-dh-bibliography) and [this list of tools for multilingual NLP](https://github.com/multilingual-dh/nlp-resources).
