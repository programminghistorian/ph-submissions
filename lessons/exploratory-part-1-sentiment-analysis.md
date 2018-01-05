---
title: |
    Exploratory Data Analysis with Natural Language Processing (NLP), Part 1: Sentiment Analysis 
authors:
    - Zoë Wilkinson Saldaña
date: 2017-01-05
reviewers:
    - Adam Crymble
    - alsalin
    - CzarinaChalid71
layout: lesson
---
# Introduction

## What Types of Questions Can Exploratory Data Analysis Help You Answer?


Exploratory data analysis refers to strategies to visualize, summarize, and otherwise reveal the features of a dataset. With the insights of exploratory data analysis at hand, researchers can make more informed decisions when selecting the methods that will best answer their research questions, or to identify new research questions altogether.

In 1977, mathematician John Tukey described exploratory data analysis as a kind of detective work:

> "Unless the detective finds the clues, judge or jury has nothing to consider. Unless exploratory data analysis uncovers indications, usually quantitative ones, there is likely to be nothing for confirmation data analysis to consider." (Tukey 1977:3) 

Tukey distinguishes between the work of *exploring* data and *confirming* a theory or model. Confirmatory analysis builds off of the work of exploring data. For Tukey (who, among other things, invented the box plot), skipping this step of exploration comes at a great risk for researchers: "... restricting one's self to the planned analysis -- failing to accompany it with exploration -- loses sight of the most interesting results too frequently to be comfortable." 

## Exploring Text with Sentiment Analysis

Exploring text involves its own set of challenges and opportunities. When confronted with a promising, yet extremely large corpus, how can you go about determining the features and subsets of data that might lead you to the most powerful findings? How do you translate research questions and methods often intended for smaller collections to thousands or even millions of texts?

Natural Language Processing (NLP) is a broad term for techniques that apply computational analytical techniques to writing and speech. NLP commonly involves converting raw text into a streamlined format, such as a sequence of “tokens” that omits unnecessary information (like capitalization) and adds helpful data (like parts of speech for each “tokenized” word). NLP provides excellent approaches for categorizing and quantifying text, which can help researchers explore the data methodically -- or in the words of Tukey, help the research to find the “clues” and “indications” to investigate further.

In this lesson, we will focus on one tool in the NLP toolkit: sentiment analysis. Sentiment analysis seeks to identify the emotions indicated by words and phrases, as well as other features of language (such as punctuation or emojis). Sentiment analysis tools generally take a unit of text input (whether it’s a sentence, paragraph, or book) and outputs quantitative scores or classifications to indicate whether that text is *positive* or *negative*, and often the *degree of positivity* or *degree of negativity*. Combined with other NLP methods like topic modeling or network analysis, sentiment analysis provides a method for researchers to characterize how individuals discuss a particular topic or interact with one another. 

A researcher interested in attitudes about a political event, for instance, might use sentiment analysis to characterize how individuals describe that event on social media, and make comparisons between regions of the world, the identities of the Twitter users, and so on, even in cases that involve hundreds of thousands or even millions of speech events.

This lesson provides an introduction to sentiment analysis that is both practical and critical. Like any computational tool, sentiment analysis has a number of limitations and biases that researchers should take into account. We feel researchers should be especially cautious about making empirical claims based on the results of sentiment analysis, and may be better served using these tools as provisional and exploratory, as a tool for guiding the research process more broadly. When wielding these tools both skeptically and effectively, you can accomplish some pretty remarkable detective work.

# Lesson Goals


This lesson is part one of a two-part lesson into exploratory data analysis of large text corpuses. It also stands alone as an introduction into sentiment analysis for exploring text data for researchers, including folks who have no prior programming experience with Python (we will link to relevant resources to get you set up as we go). By the end of this lesson, we hope to prepare you for the following:

* Understand how to approach a research questions about text data as a Natural Language Processing (NLP) problem
* Use Python and the Natural Language Processing Toolkit (NLTK) to design an algorithm for generating sentiment scores based on a given text input
* Critically evaluate the outcomes of sentiment analysis and adjust the parameters and methodology as needed
* Identify next steps to continue learning about exploratory data analysis and programmatic approaches to qualitative data


# Analysis of Large Collections of Written/Typed Correspondences

Written correspondences like letters, e-mails, chat logs, tweets, and text message histories provide researchers invaluable insight into their subjects. These texts are often rich with emotions and information not disclosed elsewhere. A researcher may learn about the opinions their subjects held about various topics and events – or, in our case, learn about the relationships that individuals development and maintained within a complex (and ultimately doomed) organization.

While methodologies like ethnography, close reading, historiography, and discourse analysis all help researchers analyze historical correspondence, these methods face significant challenges when the number of texts expands from the dozens or hundreds into the thousands or even millions. Computational textual analysis provides a set of methods for making visible trends, dynamics, and relationships that may be obfuscated to the human reader. Furthermore, many computation methods produce findings that can be expressed quantitatively, and that may subsequently allow the researcher to apply methods like statistical modeling, information visualization, and machine learning to engage further with textual data. 

In this tutorial, we will be exploring e-mail transcripts - and in particular, e-mails collected in one of the largest (and most infamous) correspondence text corpuses ever collected.


## A Case Study: the Enron E-mail Corpus


Enron was an American conglomerate that concealed a wide variety of illegal accounting practices until a federal investigation in 2001 forced it into bankruptcy.
 
Most citizens of the United States experienced the [Enron Scandal](https://en.wikipedia.org/wiki/Enron_scandal) as the largest collapse of a publicly traded company in history. In 2001, the company started showing signs of financial strain that didn't align with the company's financial disclosures to that point. The publcly traded Enron stocks dropped from their mid-2000 high of $90.75 to less than a dollar in November 2001, which led stockholders to sue the company. A subseqent U.S. Securities and Exchange Commision (SEC) investigation revealed that Enron executives committed fraud and accounting malpractice on a massive scale. Enron declared bankruptcy in December of that year, which was the largest bankruptcy in the United States history up to that point. In the years that followed, several executives faced criminial convictions for their role in the scandal.

But for a diverse group of researchers, the Enron Scandal meant something more:

> “One of the most infamous corporate scandals of the past few decades curiously left in its wake one of the most valuable publicly available datasets. In late 2001, the Enron Corporation’s accounting obfuscation and fraud led to the bankruptcy of the large energy company. The Federal Energy Regulatory Commission subpoenaed all of Enron’s email records as part of the ensuing investigation. Over the following two years, the commission released, unreleased, and rereleased the email corpus to the public after deleting emails that contained personal information like social security numbers. The Enron corpus contains emails whose subjects range from weekend vacation planning to political strategy talking points, and it remains the only large example of real world email datasets available for research.” (Hardin, Sarkis, and Urc, 2014)

When the organized and redacted [Enron E-mail Dataset](https://www.cs.cmu.edu/~./enron/) was released in 2004, researchers discovered an unprecedented opportunity: direct access to the spontaneous, largely uncensored way employees in a doomed coporation communicate with one another. Suddenly, researchers had access to how people communicated at work at an unprecedented scale. This mattered for researchers interested in the special case of the Enron scandal and collapse, and also for researchers interested in a wide spectrum of questions about everyday communication at work.

In the following decade, hundreds of new studies sprouted up from the e-mails pursuing questions as diverse as social network theory, community and anomaly detection, gender and communication within organizations, behavioral change during an organizational crisis, insularity and community formation, and more.

In addition to the sheer quantity of messages included (the corpus contains over 600,000 messages), the Enron E-mail Corpus also includes the metadata necessary for researchers to pursue their research questions. Just as the presence of envelopes with legible sender and recipient addresses would be a wonderful asset for researchers of historic letter correspondences, the presence of sender and recipient e-mail addresses allows for researchers to associate e-mails with particular known individuals within the corporation. (Keep in mind that this is not a perfect process, however, such as  when the same individual has multiple email addresses, or two individuals share the same address!)

# An Introduction to Using Python with the Natural Language Toolkit (NLTK)

[[Insert the alert here -- first time coding? We suggest that you take a minute and get started with THIS PYTHON TUTORIAL and then return here to continue on. We’ll be reviewing concepts as we go, but it helps to have a first experience with Python if possible.]]

Python is what’s known as a general purpose programming language, meaning that it lets you use a wide variety of tools and methods to solve a problem. Python is especially popular with academics and data scientists because it has a well-developed ecosystem of tools that work together to help you import, transform, store, visualize, and otherwise analyze your data, without having to switch constantly between many different languages.

In this tutorial, you will be using Python along with a few tools from the Natural Language Toolkit (NLTK) to generate sentiment scores from e-mail transcripts. To do this, you will first learn how to load text data into memory, select a few NLP tools that specialize in text and sentiment analysis, and write a problem-solving pattern (or algorithm) that calculates sentiment scores for a given selection of text. We’ll also explore how to adjust your algorithm to best fit your research question. Finally, you will package your problem-solving algorithm as a function - or a self-contained bundle of code - that you can use for further analysis, including the network analysis approach we take in part 2 of this tutorial (if you’d like to continue on!)

## Installation

To complete the example below, you will need to install the following:

* Python 3 (ideally 3.5 or higher) - [Download & install instructions from the Python wiki](https://wiki.python.org/moin/BeginnersGuide/Download)
* NLTK (3.2.5 or higher) - [Download & install instructions from NLTK.org](http://www.nltk.org/install.html)


## Getting Started with NLTK

The Natural Language Toolkit (NLTK) is a collection of Python tools (also known as a Python library) that helps researchers apply computational methods to text. These tools are all open-source, meaning that you can examine the source code directly and even contribute bug fixes and new features if you feel inspired. The tools range from methods of breaking up text into smaller pieces to identifying whether a word belongs in a given language to texts that researchers can use for training and development purposes (such as the complete text of Moby Dick).

In our case, we will be using two tools in particular:

* The VADER Sentiment Analysis tool (generates positive, negative, and neutral sentiment scores for a given input)
* The Word_Tokenize tokenizer tool (splits a large text into a sequence of smaller units, like sentences or words)

[Vader](http://www.nltk.org/_modules/nltk/sentiment/vader.html "Vader page in the NLTK Documentation") (Valence Aware Dictionary and sEntiment Reasoner) is a sentiment intensity module added to NLTK in 2014. Unlike other techniques that require training on related text before use, Vader is ready to go for analysis without any special setup. Vader is unique in that it makes fine-tuned distinctions between varying degrees of positivity and negative and words and features. For example, Vader scores "comfort" moderately positively and "euphoria" extremely positively. Vader also attempts to capture and score the type of lexical features common to informal text online, such as capitalizations, exclamation points, and emoticons, as shown in the table below:

{% include figure.html filename="vader_feature_detection.png" caption="Vader captures slight gradations in enthusiasm. (Hutto and Gilbert, 2014)" %}

Like any text analysis tool, Vader should be evaluated critically and in the context of the assumptions it makes about communication. Vader was developed in the mid-2010s primarily for microblogging and social media (especially Twitter). This context is likely much more informal than professional e-mail, and contains language and feature usage patterns that differ from 1999-2002 patterns. However, Vader was also developed as a strong general purpose sentiment analyzer, and the authors’ initial study shows it compares favorably against tools that have been trained for specific domains, use specialized lexicons, or resource-heavy machine learning techniques (Hutto and Gilbert, 2014). Its sensitivity towards degrees of affect may be well-suited to describe the subtle displays of emotion within professional e-mail - as researchers, we may be especially interested in capturing the moments where emotion surfaces in otherwise formal text. However, sentiment analysis continues to struggle to capture complex sentiments like irony, sarcasm, and mockery, when the average reader would be able to make the distinction between the literal text and its intended meaning. 


## Calculate Sentiment for a Paragraph

Consider the following passage:

>“Like you, I am getting very frustrated with this process. I am genuinely trying to be as reasonable as possible. I am not trying to "hold up" the deal at the last minute. I'm afraid that I am being asked to take a fairly large leap of faith after this company (I don't mean the two of you -- I mean Enron) has screwed me and the people who work for me.” 

This is the opening paragraph from January 2012 e-mail from Timothy Belden to Louise Kitchen and John Lavorato regarding the “Employment Contracts Deal”. Belden directed Enron’s Energy Services, and would later be convicted of conspiracy to drive up energy costs in California that led to a statewide energy crisis. 

Despite the feeling of frustration and anxiety you may glean the paragraph as a whole, notice the ambivalence of the specific phrases within the paragraph. Some appear to express good faith efforts, e.g.  “not trying to ‘hold up’ the deal” and “genuinely trying.” And yet, there are even stronger negative statements about “getting frustrated", "I am afraid", and “this company… has screwed me and the people who work for me.” 

Let’s calculate the sentiment scores for this e-mail. To start, create a new text file called “sentiment.py”. This will be where we store the code for this section.

First, we have to tell Python where the NLTK functions are located. At the top of our file, we will import VADER function and assign it to the variable “sid” for easy access (Python programs will often reassign the name of functions from other libraries to a simpler function for ease of access).

```
# first, we import the relevant modules from the NLTK library
from nltk.sentiment.vader import SentimentIntensityAnalyzer

# here we assign VADER to sid()
sid = SentimentIntensityAnalyzer()
```

Next, we need to store the text we want to analyze in a place VADER can access. In Python, we can store a single sequence of text as a string variable. We do this simply by naming a new variable and using the equals sign to assign it a text value. 

```
message_text = '''Like you, I am getting very frustrated with this process. I am genuinely trying to be as reasonable as possible. I am not trying to "hold up" the deal at the last minute. I'm afraid that I am being asked to take a fairly large leap of faith after this company (I don't mean the two of you -- I mean Enron) has screwed me and the people who work for me.'''
```


Note our use of three single quotation marks on either side of the string. Usually, we will just use single quotes or double quotes around the text. However, if we used either single or double quotes, Python gets confused if the text contained a single or double quote and tries to end the string early. For instance, Python reads ‘This is easy, isn’t it?’ as:

‘This is easy, isn’

and then the remaining text, t is it?’, causes an error. We want to avoid this happening! 

Fortunately, we can use also use three single quotes (‘’’ OUR TEXT ‘’’) which helps avoid this early ending problem, and also retains any spacing our text already includes. This is important when processing large amounts of text where one or two e-mails could contain text that would create unexpected errors (see also the “try except pattern” in Part 2).

Now, it’s time to process the text. For this section, we will first display the unprocessed contents of message_text to the console window by calling the print() function. Next, we will pass in the contents of message_text into sid.polarity_scores(), which is a method (or function) of VADER (which we are currently storing in sid) that is responsible for taking in text and outputting sentiment scores.

We want to make sure to capture the output of sid.polarity_scores() -- after all, the purpose of calling the function at all is to obtain the polarity scores! Fortunately, Python has an easy method for collecting the outputs of a function - simply assigning the function call to a variable. In this case, we’ll name that variable ‘ss’:



```
print(message_text)

# Calling the polarity_scores method on sid and passing in the message_text outputs a dictionary with negative, neutral, positive, and compound scores for the input text
ss = sid.polarity_scores(message_text)

```

While from the computer’s perspective, the outputs of our sentiment analysis has been successfully stored in the ss variable (yay!), we humans probably want some way to observe the outcomes of that process. To do this, we want to print out the contents of ss.

Unlike message_text, which stores a single string of text, the variable ss is a little more complicated. It stores the outcome of sid.polarity_scores(), which happens to be a Python data structure called a “dictionary”. A dictionary is a collection of items that consist of a label or name (called a “key”) and a value (called, appropriately, a “value”). Dictionaries let us collect a lot of different information in a single variable -- and when we’re ready to access that data, we can give Python a “key” and receive its “value” as an output.

In this case, we want to print out everything that’s stored in the dictionary -- we want all the data! We don’t know the names of every key on the top of our heads, but fortunately that isn’t a problem. Python will give us a list of all keys, sorted alphabetically, if we use the function sorted(ss). We want to do the same thing for every key: print out the key, followed by the value that is stored in the dictionary. To do the same thing for every key in sorted(ss), we write a “for loop”, which applies the same code to every item in a sequence (in this case, every key in the ss dictionary outputted by sid.polarity_scores()).

Here is the code to print out every key-value pair within our ss variable:

```
# Here we sort and print the dictionary key-value pairs for the user to view in the terminal
for k in sorted(ss):
        print('{0}: {1}, '.format(k, ss[k]), end='')
```

This code might still look a little strange, but the basic idea is that Python lets you apply the same thing to a collection of items, even if you don’t know the name or contents of those items beforehand. This type of problem-solving is called the “iteration pattern,” and it is a fundamental and extremely powerful strategy in computational text analysis.)


Here’s all the code together:

```
# first, we import the relevant modules from the NLTK library
from nltk.sentiment.vader import SentimentIntensityAnalyzer

# here we assign VADER to sid()
sid = SentimentIntensityAnalyzer()

print(message_text)

# Calling the polarity_scores method on sid and passing in the message_text outputs a dictionary with negative, neutral, positive, and compound scores for the input text
ss = sid.polarity_scores(message_text)

# Here we sort and print the dictionary key-value pairs for the user to view in the terminal
for k in sorted(ss):
        print('{0}: {1}, '.format(k, ss[k]), end='')
```



Now we’re ready to execute the code. Navigate to the folder containing your Python script in the the command line and type “python sentiment.py” and press enter. (If you are unsure how to do this, LINK HERE).

*Output*
```
Like you, I am getting very frustrated with this process. I am genuinely trying to be as reasonable as possible. I am not trying to "hold up" the deal at the last minute. I'm afraid that I am being asked to take a fairly large leap of faith after this company (I don't mean the two of you -- I mean Enron) has screwed me and the people who work for me.
compound: -0.3804, neg: 0.093, neu: 0.836, pos: 0.071,
```

<div class="alert alert-warning"> Be careful to use three single quotes to wrap the message_text string above. If you use double quotes, the string will end early due to the quotation marks within the section (“hold up”)</div>

Vader collects and scores negative, neutral, and positive words and features (and accounts for factors like negation along the way). The "neg", "neu", and "pos" values describe the fraction of weighted scores that fall into each category. Vader also sums all weighted scores to calculate a "compound" value normalized between -1 and 1; this value attempts to describe the overall affect of the entire text from strongly negative (-1) to strongly positive (1).

In this case, the Vader analysis describes the passage as moderately negative (-0.3804). We can think of this value as estimating the overall impression of an average reader when considering the e-mail as a whole, despite some ambiguity and ambivalence along the way.

What does this imply, to you, about the way that sentiment might be expressed within a professional e-mail context? How would this presence of ambivalence impact the way you conduct your exploratory data analysis? 

EXTRA CREDIT: Try assigning the following strings to message_text instead -- what do you think the outcome will be? (don’t forget the triple single quotes ‘’’ ‘’’):

* Text1
* Text2
* Text3
* Add your own text!



# Determine Appropriate Scope for E-mail

When analyzed via the Vader sentiment analysis tool, text yields a set of positive, neutral, and negative scores, which are then aggregated and scaled as a ‘compound score.’ While this is helpful to know in theory, how can this method be applied to the data in the Enron example - namely, a collection of e-mail data and metadata? And what can this tell us about the emotions, relationships, and changes over time of employees at Enron?

In this section, we will introduce you to the process of selecting the scope of analysis for our sentiment analysis tool. Consider the following raw data belonging to an October 3rd, 2000 e-mail written written by Jeffrey Shankman, then President of Global Markets at Enron:
```
Message-ID: <3764632.1075857565248.JavaMail.evans@thyme>
Date: Mon, 23 Oct 2000 09:14:00 -0700 (PDT)
From: jeffrey.shankman@enron.com
To: john.nowlan@enron.com, don.schroeder@enron.com, david.botchlett@enron.com, 
        chris.mahoney@enron.com, ross.koller@enron.com
Subject: 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: Jeffrey A Shankman
X-To: John L Nowlan, Don Schroeder, David J Botchlett, Chris Mahoney, Ross Koller
X-cc: 
X-bcc: 
X-Folder: \Jeffrey_Shankman_Jun2001\Notes Folders\Sent
X-Origin: Shankman-J
X-FileName: jshankm.nsf

It seems to me we are in the middle of no man's land with respect to the 
following:  Opec production speculation, Mid east crisis and renewed 
tensions, US elections and what looks like a slowing economy  (?),  and no 
real weather anywhere in the world.  I think it would be most prudent to play 
the markets from a very flat price position and try to day trade more 
aggressively.  I have no intentions of outguessing Mr. Greenspan, the US. 
electorate, the Opec ministers and their new important roles, The Israeli and 
Palestinian leaders, and somewhat importantly, Mother Nature.  Given that, 
and that we cannot afford to lose any more money, and that Var seems to be a 
problem, let's be as flat as possible. I'm ok with spread risk  (not front to 
backs, but commodity spreads).  


The morning meetings are not inspiring, and I don't have a real feel for 
everyone's passion with respect to the markets.  As such, I'd like to ask 
John N. to run the morning meetings on Mon. and Wed.  


Thanks.   Jeff
```

In the message text of the e-mail, Shankman outlines a corporate strategy for moving forward in what he perceives as an ambiguous geopolitical context. The message describes a number of difficult situations, as well as exapseration ("The morning meetings are not inspiring") and uncertainty ("I don't have a real feel for everyone's passion"). At the same time, Shankman outlines a set of action steps along with polite requests ("I'd like to ask...") and expressions of gratitude ("Thanks").

Before we proceed, take a minute to reflect on the message. How do you feel like a typical reader would describe this e-mail? Given what you now know about Vader, what ratio of positivity, negativity, and neutrality do you expect the sentiment analysis tool to find in the message? Finally, what do you think the compound score will suggest about the overall affect in the message?

As we discussed above, sentiment analysis does not provide an objective output so much as guiding indicators that reflect our choice and calibration of analytical tools. Perhaps the most important element of calibration is selecting the **scope** of the text being analyzed. In our case, we can determine the scope of analysis by deciding between analyzing the entire message as a single unit, or instead, breaking the message into smaller units like sentences and analyzing each sentence separately. 

First, let’s consider a *message-level approach*, in which we analyze the message as a single block: 

```
# Continue with the same code the previous section, but replace the message_text variable with the new e-mail text:

message_text = '''It seems to me we are in the middle of no man's land with respect to the  following:  Opec production speculation, Mid east crisis and renewed  tensions, US elections and what looks like a slowing economy (?), and no real weather anywhere in the world. I think it would be most prudent to play  the markets from a very flat price position and try to day trade more aggressively. I have no intentions of outguessing Mr. Greenspan, the US. electorate, the Opec ministers and their new important roles, The Israeli and Palestinian leaders, and somewhat importantly, Mother Nature.  Given that, and that we cannot afford to lose any more money, and that Var seems to be a problem, let's be as flat as possible. I'm ok with spread risk  (not front to backs, but commodity spreads). The morning meetings are not inspiring, and I don't have a real feel for  everyone's passion with respect to the markets.  As such, I'd like to ask  John N. to run the morning meetings on Mon. and Wed.  Thanks. Jeff'''
```

*Output*
```
It seems to me we are in the middle of no man's land with respect to the following:  Opec production speculation, Mid east crisis and renewed tensions, US elections and what looks like a slowing economy  (?),  and no real weather anywhere in the world.  I think it would be most prudent to play the markets from a very flat price position and try to day trade more aggressively.  I have no intentions of outguessing Mr. Greenspan, the US. electorate, the Opec ministers and their new important roles, The Israeli and Palestinian leaders, and somewhat importantly, Mother Nature.  Given that, and that we cannot afford to lose any more money, and that Var seems to be a problem, let's be as flat as possible. I'm ok with spread risk  (not front to backs, but commodity spreads).  The morning meetings are not inspiring, and I don't have a real feel for everyone's passion with respect to the markets.  As such, I'd like to ask John N. to run the morning meetings on Mon. and Wed. Thanks. Jeff
compound: 0.889, neg: 0.096, neu: 0.765, pos: 0.14,
```
Here you can see that, when analyzing the e-mail as a whole, Vader returns values that suggest the message is mostly neural (neu: 0.765) but that more features appear to be positive (pos: 0.14) rather than negative (0.096). Vader computes an overall sentiment score of **0.889** for the message (on a scale of -1 to 1) which suggests a strongly positive affect for the message as a whole.

Did this meet your expectation? If not, why do you think Vader found more positive than negative features?

At the message-entity-level, there is no way to single out particularly positive or negative sentiments in the message. This loss of detail may be irrelevant, or it may be vital when conducting exploratory analysis. For instance, identifying negative sentences in otherwise congenial e-mails may be especially important when looking for emotional outbursts or abusive exchanges that may occur very infrequently, but reveal something essential about the nature of a relationship. If we want to capture this level of nuance, we need a method for moving from message-level to senitment-level analysis.

Fortunately, NLTK provides a collection of tools for breaking up text into smaller components. *Tokenizers* split up strings of text into smaller pieces like sentences. Some can even further break out a sentence into particular parts of speech, such as the noun participle, adjective, etc. In our case, we will use NLTK's *english.pickle* tokenizer to break up paragraphs into sentences.

To install english.pickle from NLTK, you can write and run this two-line Python script:

```
import nltk
nltk.download('punkt')
```

You can now rewrite the sentiment analysis script to analyze each sentence separately:

```
# below is the sentiment analysis code rewritten for sentence-level analysis
# note the new module -- word_tokenize!
import nltk.data
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from nltk import sentiment
from nltk import word_tokenize

sid = SentimentIntensityAnalyzer()

# Assigning the “english.pickle” tokenizer to new object name. 

tokenizer = nltk.data.load('tokenizers/punkt/english.pickle')

message_text = '''It seems to me we are in the middle of no man's land with respect to the  following:  Opec production speculation, Mid east crisis and renewed  tensions, US elections and what looks like a slowing economy (?), and no real weather anywhere in the world. I think it would be most prudent to play  the markets from a very flat price position and try to day trade more aggressively. I have no intentions of outguessing Mr. Greenspan, the US. electorate, the Opec ministers and their new important roles, The Israeli and Palestinian leaders, and somewhat importantly, Mother Nature.  Given that, and that we cannot afford to lose any more money, and that Var seems to be a problem, let's be as flat as possible. I'm ok with spread risk  (not front to backs, but commodity spreads). The morning meetings are not inspiring, and I don't have a real feel for  everyone's passion with respect to the markets.  As such, I'd like to ask  John N. to run the morning meetings on Mon. and Wed.  Thanks. Jeff'''

# The tokenize method breaks up the paragraph into a list of strings. In this example, note that the tokenizer is confused by the absence of spaces after periods and actually fails to break up sentences in two instances. How might you fix that?

sentences = tokenizer.tokenize(message_text)

# We add the additional step of iterating through the list of sentences and calculating and printing polarity scores for each one.

for sentence in sentences:
        print(sentence)
        ss = sid.polarity_scores(sentence)
        for k in sorted(ss):
                print('{0}: {1}, '.format(k, ss[k]), end='')
        print()


```
*Output*
```
It seems to me we are in the middle of no man's land with respect to the  following:  Opec production speculation, Mid east crisis and renewed  tensions, US elections and what looks like a slowing economy (?
compound: -0.5267, neg: 0.197, neu: 0.68, pos: 0.123,
), and no real weather anywhere in the world.
compound: -0.296, neg: 0.216, neu: 0.784, pos: 0.0,
I think it would be most prudent to play  the markets from a very flat price position and try to day trade more aggressively.
compound: 0.0183, neg: 0.103, neu: 0.792, pos: 0.105,
I have no intentions of outguessing Mr. Greenspan, the US.
compound: -0.296, neg: 0.216, neu: 0.784, pos: 0.0,
electorate, the Opec ministers and their new important roles, The Israeli and Palestinian leaders, and somewhat importantly, Mother Nature.
compound: 0.4228, neg: 0.0, neu: 0.817, pos: 0.183,
Given that, and that we cannot afford to lose any more money, and that Var seems to be a problem, let's be as flat as possible.
compound: -0.1134, neg: 0.097, neu: 0.823, pos: 0.081,
I'm ok with spread risk  (not front to backs, but commodity spreads).
compound: -0.0129, neg: 0.2, neu: 0.679, pos: 0.121,
The morning meetings are not inspiring, and I don't have a real feel for  everyone's passion with respect to the markets.
compound: 0.5815, neg: 0.095, neu: 0.655, pos: 0.25,
As such, I'd like to ask  John N. to run the morning meetings on Mon.
compound: 0.3612, neg: 0.0, neu: 0.848, pos: 0.152,
and Wed.
compound: 0.0, neg: 0.0, neu: 1.0, pos: 0.0,
Thanks.
compound: 0.4404, neg: 0.0, neu: 0.0, pos: 1.0,
Jeff
compound: 0.0, neg: 0.0, neu: 1.0, pos: 0.0,
```

Here you’ll note a much more detailed picture of the sentiment in this e-mail. Vader successfully identifies moderate to strongly negative sentences in the e-mail, especially the leading description of crises. Sentence-level analysis allows you to identify specific sentences and topics at the extremes of sentiment, which may be helpful later.

But even at this level, Vader also runs into a number of errors. The sentence beginning with "The morning meetings are not inspiring" outputs a surprisingly positive score -- perhaps because of a misreading of the terms "passion" and "respect". Also note that the question mark at the beginning of the e-mail and the period of Mon near the end cause english.pickle tokenizer to mistakenly break up sentences. This is a constant risk from informal and complex punctuation in text.

What do you notice about the distribution of scores? How can you imagine collecting them in a manner that would help you better understand your data and its relationships to the research questions you care about? (Feel free to experiment with different kinds of text in the message_text variable!)

# Conclusion

You have successfully written a sentiment analysis script in Python! This tool can serve as a building block for a number of other computational approaches to data - or perhaps you may be inspired to try a different method. If you’d like to learn how to map sentiment analysis to a large and complex set of raw data, continue on to Part 2. We will use teh function you just wrote using Python and NLTK, and also add in new techniques from another Python library called pandas.

