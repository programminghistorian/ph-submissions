---
title: |
    Exploratory Data Analysis with Natural Language Processing (NLP) and Sentiment Analysis 
authors:
    - Zoë Wilkinson Saldaña
date: 2017-08-02
reviewers:
layout: lesson
---
# Lesson Goals

What does it mean to “explore” data? In this lesson, we encourage you to use data analysis techniques as tools to pose your research question in new ways. Exploratory techniques help us to identify the structure and nuance of data – particularly data that is complex and messy. And what could be messier than hundreds of thousands of emails sent at work during an unprecedented financial collapse?
The proposed learning outcomes of the lesson are:
* To introduce readers to sentiment analysis and natural language processing (NLP) techniques for exploring textual communication between individuals.
* To demonstrate how research questions can guide the selection and application of these techniques, e.g. selecting a technique, determining the appropriate scope of analysis, applying analysis to a network versus an individual entity, etc.
* To utilize appropriate data structures in the Python language and relevant libraries (NLTK, pandas) to analyze data[^thanks]


# What Types of Questions Can Exploratory Data Analysis Help You Answer?

Imagine that you are a researcher passionate about the way people communicate in groups. You might be a historian curious about impromptu philosophical debates in Turkish market spaces, or a cultural anthropologist interested in the social function of gossip in rural Japan. Maybe you are a scholar of gender studies interested in the letter-writing habits of women working in gender-nonconforming professional roles in 19th century North American cities. 

All three of your academic personas would likely be interested in data that represents casual communication -- letters, transcripts, or even indirect summations in journal entries. And yet, the questions you might ask about the data would vary widely. What might amount to static to one persona’s approach might reveal something about the heart of another’s research question. How, then, can you best calibrate your analytic approach to the questions that matter to you the most?

There are a wide variety of tutorials that teach the technical competencies we cover here. What we hope to provide here, in addition to a strong introduction to natural language processing (NLP) and sentiment analysis techniques, is a better understanding of how these tools relate to the craft of exploratory data analysis.

Exploratory data analysis refers to a category of data analysis approaches where you attempt to sort/filter/experience data in a way that guides your research process, often in the absence of a fully formed statistical model (or even hypothesis!) You may begin a research process with a promising set of data, but without a clear sense of its structure, or an understanding of whether certain kinds of analysis would yield findings relevant to a line of inquiry. 

By the end of the lesson, we hope you feel ready to evaluate and use natural language processing methods for your data, and also empowered to learn entirely new skills to support your exploratory data analysis process (such as from other lovely lessons here at Programming Historian!)


# A Case Study: the Enron E-mail Corpus

From a 2015 study:
> “One of the most infamous corporate scandals of the past few decades curiously left in its wake one of the most valuable publicly available datasets. In late 2001, the Enron Corporation’s accounting obfuscation and fraud led to the bankruptcy of the large energy company. The Federal Energy Regulatory Commission subpoenaed all of Enron’s email records as part of the ensuing investigation. Over the following two years, the commission released, unreleased, and rereleased the email corpus to the public after deleting emails that contained personal information like social security numbers. The Enron corpus contains emails whose subjects range from weekend vacation planning to political strategy talking points, and it remains the only large example of real world email datasets available for research.” (Hardin, Sarkis, and Urc, 2014)

When the Enron e-mail corpus appeared in organized and workable form in 2004, researchers found themselves facing an unprecedented opportunity: access to the spontaneous, largely uncensored way employees in a doomed coporation communicate with one another. Suddenly, researchers had access to how people communicated at work at an unprecedented scale. This mattered for researchers interested in the special case of the Enron scandal and collapse, and also for researchers interested in a wide spectrum of questions about everyday communication at work.

In the following decade, hundreds of new studies sprouted up from the e-mails pursuing questions as diverse as social network theory, community and anomaly detection, gender and communication within organizations, behavioral change during an organizational crisis, insularity and community formation, and more.

In addition to the sheer quantity of messages included (the corpus contains over 600,000 messages), the Enron E-mail Corpus also includes the metadata necessary for researchers to pursue their research questions. Just as the presence of envelopes with legible sender and recipient addresses would be a wonderful asset for researchers of historic letter correspondences, the presence of sender and recipient e-mail addresses allows for researchers to associate e-mails with particular known individuals within the corporation. (Keep in mind that this is not a perfect process, however, such as  when the same individual has multiple email addresses, or two individuals share the same address!)

Exploratory data analysis offers us techniques that tackle both the primary data (in this case, the body text of e-mails) as well as exploring how the metadata might support additional, sometimes unexpected forms of analysis (which we explore below).

Regardless of the specifics, most studies included a number of steps to explore the structure and features of the Enron corpus data:
* Preprocessing and data cleaning, e.g. linking multiple e-mail address aliases to a single individual when applicable, adding calculated fields and values (such as gender, rank within the organization, etc.), etc.
* Analysis of message data and metadata using one or more analytical techniques, e.g. Natural Language Processing (NLP), clustering, modeling, machine learning, etc.
* Representation of correspondence as occurring within a network, using network analysis, community detection, etc.
Many, but not all studies used the above steps as the foundation to identify and test a hypothesis, test out a statistical model, and so on. Alone, these steps constitute some of the core competencies of exploratory data analysis. 

In the following sections, we will focus primarily on analysis of the correspondence data using the Natural Language Processing (NLP) technique of Sentiment Analysis (step 2 above). By necessity however, we will engage all three competency areas – and point you to the relevant lessons on data cleaning and network analysis when you’re ready to go deeper in those areas.


# Why Sentiment Analysis?

Return for a moment to the academic personas we discussed above. What do you hope that e-mail correspondence will reveal about the individuals and community you are studying? And what is it about e-mail in particular that will contribute something distinct from other types of analysis, such as surveys, interviews, or in-person observations?

Natural Language Processing (NLP) is a broad term for techniques for applying computational analytical techniques writing and speech. While software and online applications typically prompt users for special forms of interaction and communication that can be easily understood by those programs, NLP includes the endeavor to understand human communication as it occurs “naturally” and spontaneously in everyday life. Typically, NLP involves selecting an analytical technique as well as a lexicon or corpus of data to “train” or calibrate that technique for type of text a user wishes to analyze. NLP provides a bridge between a collection of text - in this case, collections of e-mails for individuals working within a corporation - and subsequent analytical techniques to “make sense” of this data. 

Sentiment Analysis seeks to identify the emotions implied by words and phrases. This may help researchers link particular topics to emotions in order to identify individual opinions and feelings about those topics. Sentiment analysis also provides an opportunity to analyze text as indicators of interactions between individuals, and thus as relevant data for understanding the relationship between members of a community or network.

When applying sentiment analysis to corporate e-mails, we can glimpse how individuals privately communicate within an organization, and to what degree their communication involves expressions of positive, neutral, and negative sentiments. We can take the resulting sentiment score and explore the correlation between that score and various metadata, such as the features of the individuals involved - their rank within the company, their gender, to whom they are communicating, etc. In some cases, this metadata may already be part of the data collection, and in others we need to separately generate it based on what we know about the context that the data references.

In the following section, we’ll introduce you to the NLTK toolkit for sentiment analysis with Python, and also describe a potential process in which exploratory analysis leads to a very particular application of that tool to understand gendered communication within a corporate context.


# Sentiment Analysis with NLTK: Intra-textual analysis

The Natural Language Toolkit, or NLTK, is a Python library that adds analytical tools, lexicons, training corpus, and other data and methods to use. To complete the example below, you will need to install the following:

* Python 3 (ideally 3.6 or above)
* NLTK, either as a full installation or with Vader SentimentIntensityAnalyzer & dependent corpuses installed
* Pandas

Sentiment analysis tools attempt to identify the sentiment expressed in words. [Vader](http://www.nltk.org/_modules/nltk/sentiment/vader.html "Vader page in Natural Language Toolkit (NLTK) Documentation") (Valence Aware Dictionary and sEntiment Reasoner) is a sentiment intensity module added to NLTK in 2014. Unlike other techniques that require training on related text before use, Vader is ready to go for analysis without any special setup. It works by paying special attention to a range of formal and informal lexical features and also making fine-tuned distinctions between varying degrees of positivity and negativity in words and features. This special capacity to capture not merely a category of positive/negative/neutral, but the intensity of that affect, helps it capture the nuance of casual digital communication, as demonstrated in the table below:

{% include figure.html filename="vader_feature_detection.png" caption="Vader captures slight gradations in enthusiasm. (Hutto and Gilbert, 2014)" %}
  
It is important to note that Vader is a tool developed in the mid-2010s primarily for microblogging and social media (especially Twitter). However, Vader was also developed as a strong general purpose sentiment analyzer, and the authors’ initial study shows it compares favorably against tools that have been trained for specific domains, use specialized lexicons, or resource-heavy machine learning techniques (Hutto and Gilbert, 2014). Even though Vader’s focus on features like punctuation and emojis may not be as relevant to professional communication in 1998-2002, it is nonetheless an excellent tool for capturing the subtle gradations of emotion that occur within the otherwise clean-cut communication style of professional e-mails.
Calculate Sentiment for a Paragraph

Consider the following passage:

>“Like you, I am getting very frustrated with this process. I am genuinely trying to be as reasonable as possible. I am not trying to "hold up" the deal at the last minute. I'm afraid that I am being asked to take a fairly large leap of faith after this company (I don't mean the two of you -- I mean Enron) has screwed me and the people who work for me.” 

This is the opening paragraph from January 2012 e-mail from Timothy Belden to Louise Kitchen and John Lavorato regarding the “Employment Contracts Deal”. Belden directed Enron’s Energy Services, and would later be convicted of conspiracy to drive up energy costs in California that led to a state-wide energy crisis. 

Despite the feeling of negativity one may get from the paragraph as a whole, notice the ambivalence of the phrasing and sentences themselves. Some sentiments expressed are in good faith of “not trying to ‘hold up’ the deal” and “genuinely trying.” And yet, there are even stronger negative statements about “getting frustrated” and “this company… has screwed me and the people who work for me.” 

Here’s how we can conduct sentiment scores for this paragraph:

```
# first, we import the relevant modules from the NLTK library
import nltk.data
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from nltk import sentiment

# here we assign Vader to a manageable object name
sid = SentimentIntensityAnalyzer()

#below is the passage of text. Note that in Python, using three apostrophes around a string of text allows us to use newlines and whitespace if needed

message_text = '''Like you, I am getting very frustrated with this process. I am genuinely trying to be as reasonable as possible. I am not trying to "hold up" the deal at the last minute. I'm afraid that I am being asked to take a fairly large leap of faith after this company (I don't mean the two of you -- I mean Enron) has screwed me and the people who work for me.'''

print(message_text)

# Calling the polarity_scores method on sid and passing in the message_text outputs a dictionary with negative, neutral, positive, and compound scores for the input text
ss = sid.polarity_scores(message_text)

# Here we sort and print the dictionary key-value pairs for the user to view in the terminal
for k in sorted(ss):
        print('{0}: {1}, '.format(k, ss[k]), end='')
```


*Output*
```
Like you, I am getting very frustrated with this process. I am genuinely trying to be as reasonable as possible. I am not trying to "hold up" the deal at the last minute. I'm afraid that I am being asked to take a fairly large leap of faith after this company (I don't mean the two of you -- I mean Enron) has screwed me and the people who work for me.
compound: -0.3804, neg: 0.093, neu: 0.836, pos: 0.071,
```

<div class="alert alert-warning"> Be careful to use three single quotes to wrap the message_text string above. If you use double quotes, the string will end early due to the quotation marks within the section (“hold up”)</div>

Vader determines separate values for negativity, neutrality, and positivity expressed in the passage. Then, using these values, it calculates a compound score between -1 and 1. In this case, the passage appears to be moderately negative according to Vader (-0.3804). The analysis thus captures what we might assume to be the impression of the average reader, despite the ambiguity at times of the literal language used.

What does this imply, to you, about the way that sentiment might be expressed within a professional e-mail context? How would this presence of ambivalence impact the way you conduct your exploratory data analysis? 


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

In the message text of the e-mail, Shankman outlines a corporate strategy for moving forward in what he perceives as an ambiguous geopolitical context. The message describes a number of difficult situations, and a hesitation from Shankman, but also includes a clear sense of strategy without too much emotional language. 

When considering an e-mail like this one, would you describe the message as positive, negative, or some shade closer to the middle? Do you find yourself interested in the message as a whole, or some of the specific sentiments expressed within the message?

As we discussed above, Vader is a strong choice for responding not only to the positivity and negativity of words, but the intensity of ideas expressed in context. Crucially, these contextual evaluations depend upon the scope of the text being analyzed at a given time -- in particular, the decision to analyze the entire message as a single unit, or separate out calculations by smaller units like sentences.

First, let’s consider a *message-level approach*, in which we analyze the message as a single block: 


```
# Include the same code as above, but replace the message_text as follows

message_text = '''It seems to me we are in the middle of no man's land with respect to the  following:  Opec production speculation, Mid east crisis and renewed  tensions, US elections and what looks like a slowing economy (?), and no real weather anywhere in the world. I think it would be most prudent to play  the markets from a very flat price position and try to day trade more aggressively. I have no intentions of outguessing Mr. Greenspan, the US. electorate, the Opec ministers and their new important roles, The Israeli and Palestinian leaders, and somewhat importantly, Mother Nature.  Given that, and that we cannot afford to lose any more money, and that Var seems to be a problem, let's be as flat as possible. I'm ok with spread risk  (not front to backs, but commodity spreads). The morning meetings are not inspiring, and I don't have a real feel for  everyone's passion with respect to the markets.  As such, I'd like to ask  John N. to run the morning meetings on Mon. and Wed.  Thanks. Jeff'''
```

*Output*
```
It seems to me we are in the middle of no man's land with respect to the  following:  Opec production speculation, Mid east crisis and renewed  tensions, US elections and what looks like a slowing economy (?), and no real weather anywhere in the world. I think it would be most prudent to play  the markets from a very flat price position and try to day trade more aggressively. I have no intentions of outguessing Mr. Greenspan, the US. electorate, the Opec ministers and their new important roles, The Israeli and Palestinian leaders, and somewhat importantly, Mother Nature.  Given that, and that we cannot afford to lose any more money, and that Var seems to be a problem, let's be as flat as possible. I'm ok with spread risk  (not front to backs, but commodity spreads). The morning meetings are not inspiring, and I don't have a real feel for  everyone's passion with respect to the markets.  As such, I'd like to ask  John N. to run the morning meetings on Mon. and Wed.  Thanks. Jeff


compound: 0.889, neg: 0.096, neu: 0.765, pos: 0.14,
```
Here you can see that, when analyzing the e-mail as a whole, Vader detects a positive sentiment overall for the message (compound score of *0.889* on the scale between -1 and 1). The majority of the text reads as neutral, and then about 50% more of the remaining text is positive than negative (*0.14 pos* vs *0.096 neg*).

At the message-entity-level, there is no way to identify particularly positive or negative sentiments in the message. This loss of resolution may be irrelevant, or it may be vital when conducting exploratory analysis. For instance, when scanning over hundreds of professional e-mails, the presence of segments of negativity may be especially important in identifying emotional outbursts or the shouting of abuse to a coworker or subordinate, for instance.

If you want to add sentence-level sensitivity to Vader, how would you proceed? Fortunately, NLTK provides a family of tools for breaking up text into smaller components called *tokenizers*. Tokenizers can even break out sentences into their particular parts of speech - the noun participle, adjectives, and so on. In this case, we will use the *english.pickle* tokenizer to break up paragraphs into sentences:

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

Here you’ll note a much more detailed picture of the sentiment in this e-mail. Vader successfully identifies moderate to strongly negative sentences in the e-mail, especially the leading description of crises. (Note that the question mark at the beginning of the e-mail and the period of Mon near the end cause english.pickle tokenizer to mistakenly break up sentences. This is a constant risk from informal and complex punctuation in text.) 

Ultimately, positive sentences outnumber the negative sentences in this analysis. However, sentence-level analysis allows you to identify specific topics at the extremes of sentiment, which may be helpful later. 

What do you notice about the distribution of scores? How can you imagine collecting them in a manner that would help you better understand your data and its relationships to the research questions you care about? (Feel free to experiment with different kinds of text in the message_text variable!)


# Applying Sentiment Analysis to the Correspondence E-mail Corpus

<div class="alert alert-warning">
 For the following steps, you will need to download a local copy of the Enron e-mail corpus. For now, you can download [an archived version](https://www.cs.cmu.edu/~./enron/enron_mail_20150507.tgz "Direct link to .tgz archived file of complete Enron email corpus") from Carnegie Melon University. (~2 GB) I am working on creating a smaller .zip with a subset of the data to permanently host on PH that will be closer to 300-400MB.
</div>

Setting the scope of sentiment analysis helps us think through what is important about these e-mails -- is is the structure and dynamics within e-mails? Evidence of rare instances of extreme negativity (or positivity)? Or the overall emotional impression of the e-mail?

Let’s imagine that, as we move forward through the Enron e-mail corpus, we decide that we are not as interested in the textual elements of the e-mail just for their own sake, but rather as evidence of the relationships between individuals at Enron. We might begin wondering questions like: who is communicating frequently within the organization? What is the quality of their relationships like - in particular, how positively or negatively do they communicate with one another? And what particular aspects of those individuals - such as their gender, position within the organization, etc. - correlate with the positivity and negativity of those interactions?

If you stuck with the sentiment analysis approach of analyzing every single e-mail in isolation, you would simply get a very, very large list of sentiment scores – up to 600,000 if you analyzed every e-mail in this fashion! This would not get you closer to answering some of the questions above. Instead, we need to start structuring the data and mapping analytical techniques (in this case, sentiment analysis) to the data in some intelligible fashion.

When working with a complex set of text data like an e-mail corpus however, it’s likely that your message data will be part of data formatted as comma separated values (*csv data*) or in another loosely-structured or unstructured format. An ethnographer may collect their findings within a spreadsheet, or perhaps in a large document with headings or labels.

Programming Historian hosts a number of lessons that explore data structuring and cleaning processing, including using [OpenRefine](https://programminghistorian.org/lessons/cleaning-data-with-openrefine "Another lesson on Programming Historian called Cleaning Data with OpenRefine"): a free, open-source “power tool” for cleaning data.

In this example, we’ll explore using the email and os modules (included in the standard Python libraries) and pandas library (a popular add-on toolkit) to load e-mail data and metadata into a data structure called a *DataFrame*. 


# Why Use pandas and DataFrames for Exploratory Analysis? 

pandas has emerged over the past several years as a popular open source library for exploratory data analysis in Python. pandas brings together a powerful collection of data structure types and data analytical tools in a single high-performance package.

Using pandas allows us to do several important things for exploratory data analysis:
* Translate loosely-structured or unstructured data (in this case, a collection of raw e-mail data organized into text files and folders) into a format that Python libraries can easily act upon
* View quick summaries of the data as a whole, including typical statistical outputs
* Write complex exploratory data analysis queries (such as a sentiment analysis) as functions, apply to all objects in the DataFrame, and transpose results into new columns

In this lesson, we are primarily concerned with the third step, as this will allow us to start to apply sentiment analysis in a more complex fashion to our data as a whole.

<div class="alert alert-warning">
 For more information about installing pandas, visit [the pandas documentation](https://pandas.pydata.org/pandas-docs/stable/install.html "Install page in the pandas documentation")</div>

In addition to installing pandas, we must develop a method of iterating through these directories and subdirectories and loading the data and metadata. 

The Enron email corpus is structured as a series of username e-mail folders. Each user’s folder contains, in turn, a set of folders that correspond to folders in their e-mail account (such as inbox, sent, etc.) In these folders are the e-mails collected by investigators – or specifically, the ones that haven’t been subsequently redacted between 2001 and 2004 for containing social security numbers or other sensitive information. The raw e-mail files are the primary unit of data in our analysis.

Fortunately, we have two standard Python modules to help with this heavy lifting: *os* and *email*.

*os* lets us call functions that will move through a series of folders and files and load them into memory. Python needs a module like this one in order to access the files on your computer. It’s important to be careful using os, especially with any functionality that would move or delete files!!

*email* lets us quickly load e-mail message data and metadata into memory. While raw data is sometimes formatted into a *comma-separated values (CSV)* files that clearly define rows and columns, in this case the raw data is organized as a series of header names with colons. This nonstandard format is not recognized by the csv module in Python, but the *email* module provides a simple bridge to interpret header metadata as Python dictionary key-value pairs and also return the message text of an e-mail as a single string.

Below is the code in greater detail and its output:

```
# beginning a new Python file
# first import the pandas package
import pandas as pd

# the os package (part of the Python standard library) helps to quickly move through the folder structure of our Enron corpus data
import os

# the email module (also part of the Python standard library) allows the raw e-mail data (currently formatted as headers with colons, not a standard CSV/JSON file) to be read as a dictionary
import email

# dependencies for sentiment analysis

import nltk.data
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from nltk import sentiment
from nltk import word_tokenize

#loading Vader and the tokenizer into easy object names

sid = SentimentIntensityAnalyzer()
tokenizer = nltk.data.load('tokenizers/punkt/english.pickle')

# Iterates through all text files in e-mail corpus or a subset of corpus - one text file for each e-mail
# NOTE: Remember to modify the path to your system’s location for Jon Lavorato’s sent folder
path = ‘YOUR PATH/maildir/lavorato-j/sent/'
files = [f for f in os.listdir(path) if os.path.isfile(f)]

df = pd.DataFrame(columns=('Message-ID', 'From', 'To', 'Date', 'Subject', 'Message'))
# All possible keys: ['Message-ID', 'Date', 'From', 'To', 'Subject', 'Mime-Version', 'Content-Type', 'Content-Transfer-Encoding', 'X-From', 'X-To', 'X-cc', 'X-bcc', 'X-Folder', 'X-Origin', 'X-FileName', 'Cc', 'Bcc']
# Iterated through to figure out all possible keys

# iterate through all raw email text files in the sent folder. For each file, create a temporary out_dict dictionary and append that dictionary to a list of dictionaries called email_list
email_list = []
for f in [f for f in os.listdir(path) if not f.startswith('.')]: 
        out_dict = {}
        with open(path+f, "r") as myfile:
                msg = email.message_from_string(myfile.read())
                out_dict['From'] = msg['From']
                out_dict['To'] = msg['To']
                out_dict['Date'] = msg['Date']
                out_dict['Subject'] = msg['Subject']
                out_dict['Message'] = msg.get_payload()
                email_list.append(out_dict)

# create a dataframe from the list of dictionaries (each dictionary representing the values in a single e-mail) using the DataFrame.from_dict method, and pass this DataFrame to df

df = pd.DataFrame.from_dict(email_list)

# This visualization step allows us to see more of the DataFrame
pd.set_option('display.expand_frame_repr', False)  


#output -- go ahead and play around with these outputs!
print(df.head(10))
#print(df)
#print(df.head(10))
#print(df.To.value_counts())
##
```
*Output*
```
                                    Date                        From                                            Message                                    Subject                         To
0   Fri, 7 Jan 2000 09:05:00 -0800 (PST)  angela.mcculloch@enron.com  Ione can you please cc. me when Lavo or Milly ...                      Re: PIRA Oil Briefing      ione.irvine@enron.com
1  Mon, 31 Jan 2000 05:04:00 -0800 (PST)     john.lavorato@enron.com  ---------------------- Forwarded by John J Lav...      Memo re Ontario/Alberta power markets      cindy.adams@enron.com
2  Mon, 22 May 2000 11:36:00 -0700 (PDT)   kimberly.hillis@enron.com  Sure thing!  I will give it to her in the morn...             Re: Summer Stroll for Epilepsy   susan.skarness@enron.com
3  Tue, 23 May 2000 00:48:00 -0700 (PDT)   kimberly.hillis@enron.com  Donald,\n\nCould you please include my name on...                  Re: West reports for 5/22    donald.vinson@enron.com
4  Tue, 23 May 2000 04:39:00 -0700 (PDT)     john.lavorato@enron.com  Rob\n\nI enjoyed meeting you last week.  Unfor...                               Re: Rotation        rob.black@enron.com
5  Tue, 23 May 2000 04:40:00 -0700 (PDT)     john.lavorato@enron.com  David\n\nI enjoyed meeting you last week.  Unf...                                               david.fontana@enron.com
6  Tue, 23 May 2000 05:14:00 -0700 (PDT)     john.lavorato@enron.com  Dave \n\n\nThe weather group should show this ...                            Palladium Funds   david.delainey@enron.com
7  Tue, 23 May 2000 05:20:00 -0700 (PDT)     john.lavorato@enron.com  Thanks for the update and good job in handling...                        Re: Palladium Funds      mark.tawney@enron.com
8  Tue, 23 May 2000 05:59:00 -0700 (PDT)     john.lavorato@enron.com  Ed\n\nLet me know when you will be ready to ha...                                             edward.baughman@enron.com
9  Tue, 23 May 2000 11:17:00 -0700 (PDT)     john.lavorato@enron.com  You might want to file this.  Lavo\n----------...  APEA Gas Sale: Force Majeure by Clark PUD   jonathan.mckay@enron.com
```
<div class="alert alert-warning"> Remember to modify the ‘path’ variable with your system’s location information</div>

Succes! In the console output above, you can see that each e-mail has been assigned a row in the DataFrame. Panda generates column names for our DataFrame (From, Message, etc.) based on the keys included in the dictionaries we appended to email_list. Each column also gets a unique ID. 

Feel free to play with the output settings in Pandas to see more of Lavorato’s sent email box as a giant DataFrame.


# Writing and mapping a Sentiment Analysis function to the DataFrame

At this point, you may be thinking “okay, great, a giant table! But why are we using the pandas library when I could just print the e-mails directly from email_list, or even load them into an Excel spreadsheet?”

The crucial aspect of a DataFrame for our purposes is this: we can apply our NLP analytical techniques to every e-mail (represented as a row). And moreso, we can plug the results immediately back into the DataFrame as values in new columns. This technique allows us to move from applying Sentiment Analysis to a single e-mail to many thousands of e-mails, and then to sort the results in some fashion to fetch the most exemplary examples. 

Let’s say, in this example, we are interested in identifying the 5 most positive and 5 most negative e-mails that Lavorato has sent off to others. We can bring the Sentiment Analysis code in from the previous example and package it into a function called *mapMessageSentiment*. 

For the purpose of pandas, a mapping function takes a single parameter (in this case, we’ll pass in the e-mail text as *message*) and returns a tuple of four items corresponding to *compound*, *positive*, *neutral*, and *negative* outputs of the Vader SentimentIntensityAnalyzer() module. pandas us generate a new column simply by assigning a value to a new key (we’ll call it Sentiment).

mapMessageSentiment returns a four-item tuple, which means that the Sentiment column will be populated by a tuple -- for example, *(-0.802, 0.0, 0.731, 0.269)*. In order to make subsequent analysis easier, we will also unpack the tuple into four separate values, which we will assign to four new columns (CompoundSentiment, PositiveSentiment, NeutralSentiment, and NegativeSentiment, respectively). 

Finally, pandas DataFrames support sorting much like typical lists in Python. We will sort the DataFrame by CompoundSentiment in descending order and take two slices: the ten most positive rows ([0:10]) and the ten most negative rows ([-10:])

```
#...includes the code from the section above, and adds the following


def mapMessageSentiment(message):
        sentences = tokenizer.tokenize(message)
        num_sentences = len(sentences)
        sum_compound, sum_pos, sum_neu, sum_neg = 0, 0, 0, 0


        for sentence in sentences:
                ss = sid.polarity_scores(sentence)
                sum_compound += ss['compound']
                sum_pos += ss['pos']
                sum_neu += ss['neu']
                sum_neg += ss['neg']


        return (sum_compound / num_sentences), (sum_pos / num_sentences), (sum_neu / num_sentences), (sum_neg / num_sentences)


df['Sentiment'] = df.Message.apply(mapMessageSentiment)
df[['CompoundSentiment', 'PositiveSentiment', 'NeutralSentiment', 'NegativeSentiment']] = df['Sentiment'].apply(pd.Series)


ranked_positive_emails = df.sort_values('CompoundSentiment', ascending=False)
print(ranked_positive_emails.head(5))


ranked_negative_emails = df.sort_values('CompoundSentiment', ascending=True)
print(ranked_negative_emails.head(5))
```

*Output*
```
                                      Date                     From                                            Message                                            Subject                         To                    Sentiment  CompoundSentiment  PositiveSentiment  NeutralSentiment  NegativeSentiment
356  Wed, 18 Oct 2000 04:58:00 -0700 (PDT)  john.lavorato@enron.com                       Thanks I'll take care of it.                           Re: NNG request for data    chris.gaskill@enron.com  (0.7269, 0.604, 0.396, 0.0)             0.7269              0.604             0.396                0.0
90   Mon, 10 Jul 2000 00:35:00 -0700 (PDT)  john.lavorato@enron.com  Ed\n\nAs well as Dave's suggestions, I would l...             Re: Monthly Mid Market Coverage Report  edward.baughman@enron.com  (0.7184, 0.292, 0.708, 0.0)             0.7184              0.292             0.708                0.0
579   Tue, 9 Jan 2001 03:27:00 -0800 (PST)  john.lavorato@enron.com                  I'm a strong yes on these issues.  Re: MD VP PRC Committee - Follow up to the VP ...  gina.corteselli@enron.com      (0.7184, 0.6, 0.4, 0.0)             0.7184              0.600             0.400                0.0
174   Fri, 4 Aug 2000 05:09:00 -0700 (PDT)  john.lavorato@enron.com   Thanks for the update and keep up the good work.                          Re: ENA Mid-Market Groups       bob.schorr@enron.com    (0.7003, 0.42, 0.58, 0.0)             0.7003              0.420             0.580                0.0
7    Tue, 23 May 2000 05:20:00 -0700 (PDT)  john.lavorato@enron.com  Thanks for the update and good job in handling...                                Re: Palladium Funds      mark.tawney@enron.com    (0.7003, 0.42, 0.58, 0.0)             0.7003              0.420             0.580                0.0
                                      Date                     From                                            Message                      Subject                         To                     Sentiment  CompoundSentiment  PositiveSentiment  NeutralSentiment  NegativeSentiment
553  Sat, 30 Dec 2000 00:49:00 -0800 (PST)  john.lavorato@enron.com  tease colts +4 under 48 250\n\n   tease colts ...                                   john.arnold@enron.com   (-0.802, 0.0, 0.731, 0.269)            -0.8020                0.0             0.731              0.269
125  Tue, 18 Jul 2000 02:13:00 -0700 (PDT)  john.lavorato@enron.com  Sorry Jim but I left you a voicemail saying th...     Re: Power Outage 6/28/00  james.bouillion@enron.com  (-0.7096, 0.0, 0.635, 0.365)            -0.7096                0.0             0.635              0.365
507  Thu, 14 Dec 2000 04:36:00 -0800 (PST)  john.lavorato@enron.com                           The pain will stop soon.  Re: 12/13 Loss Notification       kori.loibl@enron.com  (-0.6705, 0.0, 0.353, 0.647)            -0.6705                0.0             0.353              0.647
360  Thu, 19 Oct 2000 06:26:00 -0700 (PDT)  john.lavorato@enron.com                                  No problem bensen                          Re:      john.arnold@enron.com  (-0.5994, 0.0, 0.169, 0.831)            -0.5994                0.0             0.169              0.831
65   Thu, 22 Jun 2000 04:16:00 -0700 (PDT)  john.lavorato@enron.com  Kim\n\nNo more salary changes without my appro...                                  kim.melodick@enron.com  (-0.5795, 0.0, 0.558, 0.442)            -0.5795                0.0             0.558              0.442
```
<div class="alert alert-warning"> Remember to modify the ‘path’ variable with your system’s location information</div>

Using this technique, we discover a curious set of e-mails. On the positive end, Lavorato expresses a “strong yes” in one message, gratitude in most, and praises the work of two employees: Bob Schorr and Mark Tawney. On the negative end, Vader Lavorato criticizes mistakes, including unauthorized salary changes by a subordinate, and makes the foreboding statement “The pain will stop soon” in an email with the subject line “Re: 12/13 Loss Notification.” 

Vader appears to pick up a couple of false positives in the negative e-mails. However, the majority of e-mails (8/10) capture the sentiment of e-mails as the casual reader would interpret them. 

At this point, we have developed a technique for identifying the emotional extremes of e-mails sent by a particular individual (you can go ahead and replace “lavorato-j” with any of the other 130+ subdirectory names in maildir). For a researcher interested in understanding how specific individuals communicated in the midst of the Enron collapse, this might provide a valuable jumping-off point to conduct a deep dive into those moments of conflict and intensity – or perhaps an investigation into positive, possible collusive relationships!


## Sentiment Analysis Across a Network

Imagine that, at this point, you decide that you are indeed interested in the relationships between individuals in the organization. But instead of beginning with a single individual, you would instead like the analysis to identify especially positive or negative relationships across the entire Corpus. You may be interested in identifying the extremes of conflict or collaboration (or conspiracy?) at Enron, but you don’t know where to start.

For this segment, we will move from conceptualizing e-mail corpus data as rows within a single table, and instead as lines of communication across a *network* of individuals. In this case, every individual within the organization is represented by a single *node*. E-mails show interactions between individuals or nodes within the network - in network theory, these are called *edges*, or lines that connect a *source node* to a *target node*.

We can continue using the same tools as before to load in our data and metadata, place it into a DataFrame, and apply Sentiment Analysis and map the results to new columns. However, we want to introduce a few new constraints to the e-mails to increase the signal-to-noise ratio in our data:

* Instead of searching for e-mails within a specific subfolder, look at the e-mails in the “sent” folder of every individual in the corpus. This helps us decrease the amount of time it will take to process the e-mails, while also ensuring that these e-mails represent meaningful communication between individuals (as opposed to spam, forwarded jokes (very common in 1999-2001), company-wide announcements,etc.)
* Only include e-mails with a single sender and single recipient. This helps us make sure the e-mail is expressing something about a relationship between two individuals.
* Only include e-mails where the recipient e-mail ends in @enron.com and appears as a sender elsewhere in the corpus (e.g. is one of the ~130 Enron employees included in the Corpus)

In this technique, we first create a list of all possible sender-recipient pairs in the DataFrame. At this stage, we apply a few further constraints to capture our desired type of relationship:

* Only include relationships that include at least two e-mails. This excludes one-off e-mail exchanges and ensures there is at least some degree of relationship between these two individuals. (You can play with this condition if you wish, which appears as: “if network_dict_count[pair] > 1”) 
* Keep sender and recipient pairs directional, meaning that the e-mails A sends to B are aggregated separately than the emails B sends to A. This will help us correlate communication styles to the qualities of individuals later. We can combine these directional relationships into bidirectional relationships at a later point if need be (whereas going the other direction is much more difficult).

Our goal in structuring the network analysis is to (1) list all possible sender-recipient pairs that meet the minimum threshold above, (2) count the number of e-mails for each sender-recipient pair, (3) aggregate the compound sentiment scores of e-mails associated with these sender-recipient pairs, and (4) calculate the pair’s average sentiment by dividing the aggregate scores by the e-mail count. 

```
# beginning a new Python file
import pandas as pd
import os
import email
import re

# dependencies for sentiment analysis

import nltk.data
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from nltk import sentiment
from nltk import word_tokenize

tokenizer = nltk.data.load('tokenizers/punkt/english.pickle')
sid = SentimentIntensityAnalyzer()

# Iterates through all text files in e-mail corpus or a subset of corpus - one text file for each e-mail
# Remember to change ‘path’ to the location of the uncompressed ‘maildir’ directory
path = 'YOUR DIRECTORY/maildir/'

df = pd.DataFrame(columns=('Message-ID', 'From', 'To', 'Date', 'Subject', 'Message'))
# All possible keys: ['Message-ID', 'Date', 'From', 'To', 'Subject', 'Mime-Version', 'Content-Type', 'Content-Transfer-Encoding', 'X-From', 'X-To', 'X-cc', 'X-bcc', 'X-Folder', 'X-Origin', 'X-FileName', 'Cc', 'Bcc']
# Iterated through to figure out all possible keys
count = 1
email_list = []

for subdir, dirs, files in os.walk(path):
        for file in files:
                if file.endswith(".") and subdir.endswith("sent"):
                        working_path = os.path.join(subdir, file)
                        with open(working_path, "r") as myfile:
                                try:
                                        out_dict = {}
                                        msg = email.message_from_string(myfile.read())
                                        out_dict['Message-ID'] = msg['Message']
                                        out_dict['From'] = msg['From']
                                        out_dict['To'] = msg['To']
                                        out_dict['Date'] = msg['Date']
                                        out_dict['Subject'] = msg['Subject']
                                        out_dict['Message'] = msg.get_payload()
                                        if len(out_dict['To'].split()) > 1 or len(out_dict['From'].split()) > 1:
                                                continue
                                        if "@enron.com" not in out_dict['From'] or '@enron.com' not in out_dict['To']:
                                                continue        
                                        email_list.append(out_dict)
                                except:
                                        print('Error reading message ' + str(count) + ' at ' + working_path)
                        count += 1
                        print(str(count) + ': ' + working_path)


pd.set_option('display.expand_frame_repr', False) #allows us to see more of the DataFrame
df = pd.DataFrame.from_dict(email_list)


#output -- go ahead and play around with these outputs!
#print(df)
#print(df.head(10))
#print(df.To.value_counts())

def mapMessageSentiment(message):
        sentences = tokenizer.tokenize(message)
        num_sentences = len(sentences)
        sum_compound, sum_pos, sum_neu, sum_neg = 0, 0, 0, 0

        for sentence in sentences:
                ss = sid.polarity_scores(sentence)
                sum_compound += ss['compound']
                sum_pos += ss['pos']
                sum_neu += ss['neu']
                sum_neg += ss['neg']

        return (sum_compound / num_sentences), (sum_pos / num_sentences), (sum_neu / num_sentences), (sum_neg / num_sentences)

df['Sentiment'] = df.Message.apply(mapMessageSentiment)
df[['CompoundSentiment', 'PositiveSentiment', 'NeutralSentiment', 'NegativeSentiment']] = df['Sentiment'].apply(pd.Series)
df['Pair'] = df['From'] + ',' + df['To']
senders_list = df.From.unique()

network_dict_sentiments = {}
network_dict_count = {}
for index, row in df.iterrows():
        if row['Pair'] in network_dict_count:
                network_dict_count[row['Pair']] += 1
                network_dict_sentiments[row['Pair']] += row['CompoundSentiment']
        else:
                network_dict_count[row['Pair']] = 1
                network_dict_sentiments[row['Pair']] = row['CompoundSentiment']

average_sentiment = {}
for pair in network_dict_count:
        sender, recipient = pair.split(',')
        if network_dict_count[pair] > 1 and sender != recipient and recipient in senders_list:
                average_sentiment[pair] = network_dict_sentiments[pair]/network_dict_count[pair]

sorted_pairs = sorted(average_sentiment, key=average_sentiment.get, reverse=True)
for item in sorted_pairs[0:10]:
        print(item + ': ' + str(average_sentiment[item]) + ' with ' + str(network_dict_count[item]) + ' items')
print()
for item in sorted_pairs[-10:]:
        print(item + ': ' + str(average_sentiment[item]) + ' with ' + str(network_dict_count[item]) + ' items')


fout = open('pair_average_sentiment.csv', 'w')
for pair in sorted_pairs:
        fout.write('"' + pair + '",' + str(average_sentiment[pair]) + '\n')
fout.close()
```

*Output*
```
john.lavorato@enron.com,scott.neal@enron.com: 0.56735 with 2 items
scott.neal@enron.com,andrea.ring@enron.com: 0.5445071428571429 with 2 items
stacy.dickson@enron.com,sara.shackleton@enron.com: 0.5029473684210527 with 3 items
kevin.ruscitti@enron.com,dan.hyvl@enron.com: 0.451075 with 2 items
tana.jones@enron.com,sylvia.sauseda@enron.com: 0.4493125 with 2 items
sally.beck@enron.com,paige.grumulaitis@enron.com: 0.4172 with 2 items
vince.kaminski@enron.com,richard.shapiro@enron.com: 0.40943333333333337 with 2 items
debra.perlingiere@enron.com,brad.mckay@enron.com: 0.4044 with 2 items
elizabeth.sager@enron.com,michelle.cash@enron.com: 0.39487 with 5 items
jeffrey.shankman@enron.com,jeff.skilling@enron.com: 0.38620654761904766 with 3 items


frank.ermis@enron.com,mike.grigsby@enron.com: -0.04517499999999999 with 2 items
juan.hernandez@enron.com,jeff.king@enron.com: -0.056575 with 2 items
john.lavorato@enron.com,john.arnold@enron.com: -0.06330932327044025 with 25 items
greg.whalley@enron.com,jeffrey.shankman@enron.com: -0.08271428571428571 with 5 items
john.lavorato@enron.com,vince.kaminski@enron.com: -0.08663333333333334 with 3 items
twanda.sweet@enron.com,mark.haedicke@enron.com: -0.08681153846153845 with 26 items
richard.sanders@enron.com,sylvia.sauseda@enron.com: -0.0903 with 2 items
liz.taylor@enron.com,janette.elbertson@enron.com: -0.10206666666666668 with 2 items
scott.neal@enron.com,phillip.allen@enron.com: -0.13419751461988305 with 6 items
phillip.allen@enron.com,barry.tycholiz@enron.com: -0.2997 with 2 items
```
<div class="alert alert-warning"> Remember to modify the ‘path’ variable with your system’s location information</div>

Here we’ve been able to identify specific relationships at either extreme of sentiment expressed. Positivity appears more likely to appear in exchanges with just a few e-mails, whereas the most negative relationships include ones with substantial e-mail back-and-forth. (Note that Lavorato and Shankman appear in several relationships at either extreme.)

Again, we find a jumping-off point for further analysis which may or may not continue to use natural language processing techniques like Sentiment Analysis. You can imagine exploratory data analysis in this instance as providing the justification and framework for subsequent analysis, and doing so in a powerful, computational manner. 


## Exploring Correlations Between Sentiment and Other Features Across the Network

Let’s imagine that the data exploration so far has stoked your interest in the qualities of relationships as expressed through substantial e-mail exchanges. But instead of leading you to particular relationships that represent extremes within the organization, you’d like to explore what those sentiment scores might tell you about particular subsets of the network. In this case, your interest diverges from particular pairs of individuals and focuses instead on the relationship between the characteristics of employees and how they speak to one another. As with the prior shift from analyzing specific texts to seeing texts as indicative of particular relationships, we now want to shift from analyzing specific relationships to seeing them as indicative of trends within the organization as a whole.

To accomplish this, we must include a method for associating the individual nodes in the network with properties of interest. A number of studies of the Enron e-mail corpus have included in their pre-processing individual metadata such as professional title, job category within the company (i.e. trader, manager, CEO), gender, and more.

To begin: How do the genders of the sender and recipient of e-mails relate to the sentiment expressed in their exchanges?

For the purposes of this tutorial, we followed the methodology of similar studies and generated a dictionary that attempts to correlate every e-mail address with a gender. Please note that this is only an approximation of gender identity based upon first name and, when available, additional publicly accessible documentation. Whenever possible, we included a ‘M’ for man and ‘W’ for woman. In instances where gender was indeterminable, we simply included a ‘?’. This allows us to still proceed with gender analysis while acknowledging the limitations of external/de-facto identifying processes, and that individuals may have non-conforming names, nonbinary or transgender identities not reflected in legal names, etc. Further, the use of ‘men’ and ‘women’ as opposed to ‘male’ and ‘female’ reflects our interest in gender identity rather than sex.

You can download this module as [*gender_module.py*](https://raw.githubusercontent.com/programminghistorian/ph-submissions/gh-pages/lessons/gender_module.py "Direct link to raw python file of module in Github Repository temporary location") (note- currently uploaded to the lessons Github repository -- better to place in images/elsewhere for now?). To access the module, make sure the file is placed within the same directory as your current working python file. Then add the following line to your dependencies:
```
from gender_module import possible_gender
```
As with our previous network generation technique, we will again aggregate scores based upon four possible relationships: Women->Women, Women->Men, Men->Women, and Men->Men. 

In this script, *pair* references our previously established master list of all possible sender->recipient pairings, represented as a tuple. We can unpack the tuple into sender and recipient strings, and call the possible_gender dictionary with the sender and recipient strings as keys. If the keys are part of the dictionary, the call will return a value of either ‘M’, ‘W’, or ‘?’. The if-then logic is written in such a way that no action will be taken if either of the keys return a ‘?’

Note that the if-then loops are wrapped within a try:/except: pattern. If Python attempts to access a key that doesn’t exist, it will return a KeyError that will break the program. While the *.get* method provides a safe alternative for handling keys that may or may not exist within a dictionary (for instance, possible_gender.get(‘lalala’) would return None), the try/except loop has the benefit of notifying us in the console if a problem occurs, which we may want to investigate later.


```
#... adds the following code to the code in the previous sections
# remember to add the following line to your dependencies: from gender_module import possible_gender

WW_scores, WM_scores, MW_scores, MM_scores = [], [], [], []

for pair in sorted_pairs:
        sender, recipient = pair.split(',')
        try:
                if possible_gender[sender] == 'W':
                        if possible_gender[recipient] == 'W':
                                WW_scores.append(average_sentiment[pair])
                        elif possible_gender[recipient] == 'M':
                                WM_scores.append(average_sentiment[pair])
                elif possible_gender[sender] == 'M':
                        if possible_gender[recipient] == 'W':
                                MW_scores.append(average_sentiment[pair])
                        elif possible_gender[recipient] == 'M':
                                MM_scores.append(average_sentiment[pair])
        except:
                print('Missing key')


print()
print('Women to women average sentiment: ' + str(sum(WW_scores)/len(WW_scores)))
print('Women to men average sentiment: ' + str(sum(WM_scores)/len(WM_scores)))
print('Men to women average sentiment: ' + str(sum(MW_scores)/len(MW_scores)))
print('Men to men average sentiment: ' + str(sum(MM_scores)/len(MM_scores)))
print()
```
*Output*
```
Women to women average sentiment: 0.2142464030909436
Women to men average sentiment: 0.17100640343571535
Men to women average sentiment: 0.17926107146863518
Men to men average sentiment: 0.14014947938584138
```
Here we discover a substantial difference between sentiment. Women communicating with other women express, on average, a 50% higher sentiment score than men, whereas communication between individuals of the two genders hover somewhere in between. While it is difficult to translate degrees of compound sentiment score into plain english, this gives us a strong jumping-off point to investigate gender and communication patterns across the organization. How might those changes in sentiment by gender further change over the course of Enron’s collapse? How about when communication is with a superior, a subordinate, or a peer within the corporate hierarchy? What about exploring correlations for entirely different characteristics of individuals? The possibilities may not be infinite, but they are certainly vast.

# Where Can We Take Exploratory Data Analysis From Here?

In the sections above, we have explored how the process of writing and implementing code for data analysis can go hand-in-hand with a process of discernment and investigation for a researcher. While our code developed into a longer and more complex application along the way, there is not a single endpoint or outcome with more intrinsic value than the others. Rather, there are a number of hopping-off points where you as a researcher may consider hopping off and switching to other forms of analysis.

At the same time, you may wish to continue exploring this data and applying further analytical techniques, such as graphing possible correlations. Another axis of analysis you may consider is going further into the toolkit of *network analysis*. In particular, the earlier model of nodes and edges, when saved to a .csv file, can form the basis of network generation and calculation of features like betweenness-centrality, community detection, and more. 

As one final example, here is a sneak peak of what that might look like to generate a network graph to explore the patterns of communication between individuals and communities (or “neighborhoods”) within an organization:

{% include figure.html filename="enron_network_with_communities.png" caption="Network graph with communities generated with NetworkX" %}


The larger font sizes for individuals indicates their betweenness-centrality in the network, or the degree to which individuals are likely to be linked through them. (Incidentally, that figure also appears to correlate with the likelihood of being charged with a felony in the Enron scandal.)

Though this technique falls outside of the scope of this particular e-mail, you can continue on to the NetworkX lesson on Programming Historian to do just that! You will need a .csv file version of the network data to generate the network graph. To grab this, simply add the following code to our example above to generate a list of edges (one for each e-mail between individuals in a pair) and save it to a csv file:

```
#... adds the following code to the section above 


fout3 = open('edges_for_network.csv', 'w')
for pair in sorted_pairs:
        sender, recipient = pair.split(',')
        for x in range (0, network_dict_count[pair]):
                fout3.write('"' + sender + '","' + recipient + '", ' + str(average_sentiment[pair]) + '\n')
fout3.close()
```
To learn the techniques to go from edges and nodes to a complete network graph, continue on to the NetworkX tutorial here (note: add link to PH lesson).

Regardless of where you choose to jump off the exploratory process, hopefully this lesson provides you with a working sense of what types of questions exploratory data analysis can help answer, and how it can support your research process. Computational techniques are exciting and sometimes flashy, but they do not require us to set aside our research questions, our skepticisms, or our critical thought process. We do our best research when we weave methodologies and analytical processes together in pursuit of whatever inspires our curiosity. Hopefully this gives you a roadmap for doing just that with Python, NLTK, and pandas.


# Works Cited

Hardin, J., Sarkis, G., & Urc, P. C. (2014). Network Analysis with the Enron Email Corpus. arXiv preprint arXiv:1410.2759.

Hutto, C.J. & Gilbert, E.E. (2014). VADER: A Parsimonious Rule-based Model for
Sentiment Analysis of Social Media Text. Eighth International Conference on
Weblogs and Social Media (ICWSM-14). Ann Arbor, MI, June 2014.

Klimt, B., & Yang, Y. (2004, July). Introducing the Enron Corpus. In CEAS.

Klimt, B., & Yang, Y. (2004). The enron corpus: A new dataset for email classification research. Machine learning: ECML 2004, 217-226.

[^thanks]: My sincere thanks to Justin Joque, Visualization Librarian at the University of Michigan Library and the Digital Project Studio for extensive support throughout the process of writing this tutorial. More information about the Digital Project Studio can be found at https://clarkdatalabs.github.io
