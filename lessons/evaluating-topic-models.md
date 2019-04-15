---
title: |
    Evaluating Topic Models
collection: lessons
slug: [LEAVE BLANK]
date: [LEAVE BLANK]
translation_date: [LEAVE BLANK]
authors:
    - Amanda Henrichs
reviewers:
- [LEAVE BLANK]
editors: 
- James Baker, Sofia Papastamkou
translator:
- [FORENAME SURNAME 1]
translation-editor:
- [LEAVE BLANK]
translation-reviewer:
- [LEAVE BLANK]
original: [LEAVE BLANK]
review-ticket: [LEAVE BLANK]
difficulty: [LEAVE BLANK]
activity: [LEAVE BLANK]
topics: [LEAVE BLANK]
abstract: [LEAVE BLANK]
layout: lesson
---

# Contents



## Contents
{:.no_toc}

* TOC
{:toc}




## Introduction

Topic modeling is a popular method for scholars who deal with very large corpora of textual data; topic modeling allows researchers to find likely clusters of shared themes without needing to human-read all of the texts in the corpora. For example, if the researcher wants to get a general overview of 1000 (or 10,000 or 100,000) novels, but don't have time to read every single novel, they might use topic models to create general clusters of themes. These clusters are non-specific, but they can suggest further avenues of inquiry. This lesson will not deal with the specifics of *how* to topic model, or focus on any specific programming language. For an introduction to one popular method, see [Graham et. al](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet).

While this tutorial will not teach you *how* to topic model, it will explore *why* scholars choose to do so, and will explain the logic behind 2 popular methods. You will then be able to understand several common methods in order to help you identify and evaluate the results of those methods.

## Steps to evaluating topic models

1.	Identify the output (word cloud or table); identify process (how was it produced?)
2. Identify input (know your corpus and its limits)
3.	Identify research question (evaluate *what* the original scholar was trying to demonstrate, and *why*; you can also consider how these topic models will align with your own research question)
4. Identify any biases introduced by design/aesthetic decisions
5. Identify exceptions

### Step 1: Identify output and process

This is the most important and most complex step in evaluating topic models: knowing whether your topic models were produced by **probability** or **word count**. You can get clues based on the output, namely whether you are seeing a table or a word cloud. These are not strict rules, however, so be aware of possible exceptions.

#### If you are looking at a table, it was likely produced via a **probabilistic** topic modeling method

Several years ago, Scott Weingart provided a [guided tour](http://www.scottbot.net/HIAL/index.html@p=19113.html) of the mathematical processes behind topic modeling; this lesson draws substantially on those separate posts, and attempts to synthesize them for scholars who have no mathematical training or inclination. I will repeat a variation of what Weingart and others (including Rebecca [Koeser](https://hcommons.org/deposits/item/hc:10247)) have said about "trusting others to do the math": it is always best to understand ***how and why*** a tool was put together, and how it produces its results. While understanding the math is desirable, it is not always possible. What this boils down to for topic modeling is that at the very least *you should know whether the topic models are based in word counts or probability.*

Most scholars who identify as digital humanists (broadly speaking) will likely have used a programming language like R or Python to run **probabilistic** topic models. These use statistical probability and mathematical equations (basically linear algebra) to determine *the probability of co-occurrence* of given word-tokens. There are several different statistical methods that can be used: the two most common for natural language processing (NLP) are latent Dirichlet allocation (LDA) and the Machine Language Learning Toolkit (MALLET). 

For this lesson, I will provide examples based in a canonical English-language text, Shakespeare's *Sonnets*. This is a corpus many people are familiar with; it is also mathematically unsuitable for topic modeling, but its unsuitability throws the methods of topic modeling into relief. I will explain more about this in Step 6.

When topic modeling (or performing any computational procedure), data must first be cleaned: and cleaning involves a few discrete operations. First, all special characters must be stripped out of the text, including numbers and punctuation; each word is then removed from its context, the computational equivalent of throwing every word-token into a bag and shaking it. The corpus becomes a collection of words, or rather distinct word-tokens (w1, w2……wn), without semantic meaning. The program does not “interpret” the words, nor does it read context; rather, each word is simply a unique token. 

This process transforms the *Sonnets* (or whatever text is being used) from a structured and ordered text into an undifferentiated collection of word-tokens.  The next step is to infer the topics that unite the corpus, or to restructure this collection of word-tokens again, but this time in topics instead of documents. 

Effectively, topic modeling assumes every corpus is made of three things: documents, topic, and words. It also assumes that an individual document in a corpus contains topics that are likely shared across other documents in that corpus, and that each topic and each document are made up of words. Humans, however, only see two of these three; we only read the words to understand the documents, and tend to miss the shared latent topics which unite the corpus. LDA works backward from a set of documents to guess what kinds of conceptual clusters produced those documents.

Probabilistic topic modeling is thus a kind of reversal of the creative process: given the assumption that a text contains several different latent topics—the *Sonnets* are about love, but they are also about what counts as beauty, and about human procreation, and about literary immortality—topic modeling throws all the words into a bag, then pulls them out again in an attempt to model what those topics look like independent of their literary context. 

As I've mentioned already, there are multiple mathematical procedures that can be used to produce a probabilistic topic model; and in order to understand and evaluate topic models, scholars have translated this math in different ways, most having to do with food. Matt Jockers uses the metaphor of a buffet, from which each author selects the foods/words that they most enjoy;  Lisa Marie Rhody describes it as selecting produce from a farmer’s market, where each topic is a basket, into which different kinds of produce are sorted by your neighbors, enabling you to deduce the kinds and proportions of produce available at the market.[^4]  Both of these explanations make most sense when the corpus includes multiple authors and multiple documents, including millions and even billions of words: the metaphors of selection, whether from a buffet or a market, represent authorial style as a series of choices that conform to personal preference. Importantly, those choices are not necessarily conscious ones; part of what topic modeling promises is to extract the latent patterns in word usage that characterize different concepts, or topics. The metaphor of choice, then, sees different texts by different authors as, basically, a series of different choices that accumulate toward a single overarching text.

When researchers run probabilistic topic models, the first output is most likely a table, commonly in a .csv format (otherwise known as an Excel spreadsheet). One example is below.

{% include figure.html filename="Sonnets-topic-words" caption="Table of top 6 words in 10 topics" %}

This table's columns contain the top 6 words in each of 10 topics; the order of the words is proportional. That is, each topic is most *about* the first word, and so on; this table suggests that when Shakespeare talks about "love," he tends to use the possessive "mine," that conditional words like "shall" and "will" are also common, and that "eyes" are connected to all of this. 

Yet tables representing topic models typically come in multiples that need to be studied in conjunction; this table is not the whole picture. If each list of words represents a proportional relationship, LDA also calculates the proportional relationship among topics. This information will be represented in a table like this: 

{% include figure.html filename="Sonnets-topic-probabilities" caption="Table of topic probabilities" %}

Here we see which topic represents the highest proportion of the overall model. In this case, the algorithm is telling us that the *Sonnets* are most "about" topic 3 (column V3); and they are least "about" topic 2 (column V2). Shakespeare seems to have returned to the themes of topic 3 most often, and topic 2 least often. 

So what does this mean? Well, that depends on your research question. Topic modeling is best suited for exploring very large and therefore unfamiliar corpora; a topic model such as the one above can cluster interesting terms that the researcher might want to pursue further. If the corpus is small, topic models might only confirm prior knowledge: sometimes that can be a desirable result. Again, it all depends on the research question.

#### If you are looking at a word cloud:

it could have been produced using either **probabilistic** or **word count** methods. It is important to know which is which, because each measure different things, and yet can look very similar. 

Topic models based in **word counts** are likely the result of off-the-shelf or plug-and-play tools like Voyant or Wordle. They will likely be presented as word clouds, or a cloud of words of differing sizes. Word clouds sometimes also include color. In these topic models, word size corresponds to word count; the bigger the word, the more times it occurs in the corpus. This kind of word cloud can be confused with the word clouds produced by probabilistic methods; yet they measure different things, so make sure you know how your word cloud was produced. When evaluating a word cloud, you will want to recall your own research question, as well as how the original researcher intended the word cloud to be used. 

This first word cloud was produced when I uploaded the *Sonnets* to [Voyant](voyant-tools.org), a popular text visualization tool: it sizes words based on how often they appear in the text. Notice that the word "love" is the most prominent.

{% include figure.html filename="Voyant-word-cloud" caption="Word cloud produced through word count" %}

Compare this to this word cloud, produced in R via LDA: 
{% include figure.html filename="R-word-cloud" caption="Word cloud produced through probability" %}

The word "love" is also the most prominent here. And apart from color, these word clouds look very similar!! 

The basic difference is that word-count word clouds measure incidence; they use counts of words to suggest themes. This can be a good tool for seeing how words are counted in their contexts. But an incidence-based word cloud cannot extract patterns across multiple texts, nor can it label the proportionality of each topic cluster. Effectively, incidence-based word clouds measure the number of times a given word occurs. Probabilistic word clouds measure how often a word occurs in proximity to certain other words. 

### Step 2: Identify input

Topic models are commonly used on very large corpora; by "large," I mean greater than 10 or 15 typical novels (or very approximately 1 million words). Topic modeling was also originally developed for prose, both literary and journalistic. When looking at a topic model, you will want to know what went in to the corpus; you can ask yourself some questions, including the below. (Note: the questions below assume the topic was produced via probabilistic methods.)

*	Is the corpus poetry or prose? When was it written?
	*	Depending on the method used, this answer can have varying impacts:
		* If prose written after about 1850, the algorithm will have the easiest time dealing with the corpus, since those were the inputs which trained the algorithm in the first place.
		* If poetry written after about 1850, you won't have to think about as many spelling or usage variations. However, be aware that some researchers will be skeptical of the mismatch between the algorithm's training and the poetic input. (See Lisa Marie Rhody for how topic modeling poems can produce "beautiful failures."[^2])
		* If poetry or prose written before about 1850, the researcher will have dealt with a much more involved process of creating a custom stopword list (see the below step), and will have either regularized spelling, or chosen not to. 
* What language is the corpus in? 
	*	Because computer programs treat all languages as a collection of word-tokens without semantic meaning or context, the language only matters when thinking about the cleaning process. If there are special characters or symbols, those need to be cleaned, incorporated, or ignored; but whatever the researcher decides, that decision will affect the topic model output.
* 	How was the data processed?
	*	one of the most extensive steps in any textual analysis project is data cleaning. You will want to know what steps the researcher took to clean their data. This can include:
		*	Did they strip out stopwords? (In English, stopwords are common function words like *and, but, or, the* and so on. Stopwords can also be customized by the researcher to include word-tokens that might skew the results somehow. Common custom stopwords are names, dates, or variant spellings.)
		*  	There is not necessarily a *correct* decision surrounding stopwords; but when evaluating a topic model, all those decisions affect the final product, and can thus matter to your evaluation.
		*   See the step above about the language of origin.
*   Has the researcher been clear about their corpus? If it is unclear how many texts were analyzed, how the corpus was cleaned, what the original texts were, where they were from, or what the method was, it might be best to take the results more skeptically. 
	*	Some slight confusion around data is not a reason to throw out the results. However, it does suggest that the results should be tested again, or investigated further, before relying on them whole-heartedly. 

### Step 3: Identify the research question

You will want to know what question the researcher was attempting to answer, and you will also want to be clear with yourself about why you are evaluating these topic models. These research questions can vary according to discipline and language; one of the reasons for topic modeling's popularity is its flexibility. Typically, though, the research question will be based in exploring a large corpus of unfamiliar texts in order to identify further areas of research; as David Blei writes, "Topic models are algorithms for discovering the main themes that pervade a large and otherwise unstructured collection of documents."[^1] The key word here is *discovering*; topic models are not intended to be used on corpora that researchers could reasonably engage without computational methods. There are important exceptions to this statement; see section 6 for why. Below are some sample questions you can ask yourself when evaluating a topic model. 

*	Does the researcher know what is in the corpus?
	*	(Are they using the topic model to provide them new questions, or to confirm things they already know?)
*	Why are you looking at these topic models? Are you confirming your hunches about a corpus, or are you hoping to discover something new?	

### Step 4: Identify any aesthetic biases

Many quantitatively-inclined scholars dislike the word-cloud versions of topic models because of the aesthetic parameters which are commonly added to make them more "appealing." For example, it is easy to add color to the word clouds, where words of the same size are given the same color.

Let's examine the incidence word cloud again.

{% include figure.html filename="Voyant-word-cloud" caption="Word cloud produced through word count" %}

If you are someone with average vision, you might notice that your eye is drawn to the words "show," "sweet," and "make," which might suggest a pattern. However, there is no connection between these words; they are different sizes, which means they have different counts. And because this is based in *word count*, their presence in the same cloud does not indicate the same proportional relationship that a probabilistic word cloud would. 

It is a fairly simple modification in most scripts to add color in probabilistic modeling; and color can make it easier to see connections among words of the same color, since that would indicate they stand in the same relation to the other words in the cloud. For many researchers, this is actually helpful, since it might help them see connections between words. For others, however, it can be a distraction, since it might complicate the exploratory intent of topic modeling by introducting another pattern of color, which can incite interpretation. What matters most is to know both your own perspective and that of the original researcher. 


### Step 5: Identify exceptions

There are, of course, many exceptions to the above steps, and as you dig deeper into topic modeling, you will find disagreement among scholars about the best method and best presentation of topic models. But if you are looking to evaluate topic models, or to gain a greater understanding of why some researchers find them useful, this tutorial should help.

No matter your particular case, keep in mind the following questions:
1. What research question are these models intended to explore?
2. How was the corpus cleaned? (what decisions did the researcher make about their corpus?)
3. How big is the corpus? (Is it statistically significant?)
3. Is this a word-count or probabilistic topic model?

There is no truly correct answer to these questions, but the answers should help you move forward in your own work. Whether the corpus is large or small, in probabilistic modeling the algorithm is still working to identify which word-tokens belong to which topics, and which topics are shared across the documents in the collection; but especially if the corpus is small, the algorithm won't have the necessary quantity of words through which statistical significance is achieved. Topics will effectively be overdetermined, and not useful for exploring a corpus. (This makes intuitive sense, in many ways; if a corpus is small, it is likely a human reader can manage to grasp it, and there is thus no need for a computational exploration.) 
 
Even in cases where the corpus is statistically inadequate, or is based in figurative language, topic modeling can still be useful. However, this use is less evaluative or investigative and more generative or creative; topic modeling can also be a way to confirm what the researcher knows, or to suggest interesting conceptual pairings that spark further research questions.

Some scholars use topic models as ways to extend the conversation; this approach is not very common as of this writing, but scholars including Stephen Ramsay, Lisa Marie Rhody, and myself[^3] have made the case for analyzing topic models as themselves aesthetic objects. This approach sets aside statistical correctness in favor of how *interesting* the topic models themselves are. 

## Conclusion
When evaluating topic models, clarify what you and the original researcher want to understand from the models; get to know what went in to the corpus as much as possible; and consider how aesthetic parameters can affect your approach to the model. There are not necessarily "correct" answers; you just need to know what you are looking at and why. 

[^1]David M. Blei, “Probabilistic Topic Models,” Communications of the ACM 55, no. 4 (April 1, 2012): 77, https://doi.org/10.1145/2133806.2133826. Blei's explanation of latent Dirichlet allocation is one of the most approachable for beginning to intermediate computational scholars. 
[^2] Lisa Marie Rhody, "Topic Modeling and Figurative Language," http://journalofdigitalhumanities.org/2-1/topic-modeling-and-figurative-language-by-lisa-m-rhody/
[^3] Amanda Henrichs, "Deforming Shakespeare's *Sonnets*: Topic Models as Poems", forthcoming (as of February 2019) in *Criticism 61.3*
[^4] Matt Jockers, "The LDA Buffet is Now Open; or, Latent Dirichlet Allocation for English Majors," http://www.matthewjockers.net/2011/09/29/the-lda-buffet-is-now-open-or-latent-dirichlet-allocation-for-english-majors/; Lisa Marie Rhody, "Topic Modeling and Figurative Language," http://journalofdigitalhumanities.org/2-1/topic-modeling-and-figurative-language-by-lisa-m-rhody/

