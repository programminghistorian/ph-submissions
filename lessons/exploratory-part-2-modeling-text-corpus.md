---
title: |
    Exploratory Data Analysis with Natural Language Processing (NLP), Part 2: Modeling and Exploring a Text Corpus
authors:
    - Zoë Wilkinson Saldaña
date: 2017-01-05
editors:
    - Adam Crymble
reviewers:
    - alsalin
    - CzarinaChalid71
layout: lesson
---

*In Part One, we introduced the process of generating sentiment scores for an email transcript using Python and NLTK. In Part Two, we will explore how to scale sentiment analysis to a large text corpus (~600,000 items) using pandas and network analysis techniques.*

# Introduction

In the previous lesson, we wrote a function to calculate sentiment scores (positive, negative, neutral, and combined) for a passage of text. While we explored different ways to break up the text, our function always accepted as input a sequence of characters called a *string variable*. The lesson provided examples of several e-mail messages, each presented as a single string of text we could assign to the *message_text* variable.

In reality, we almost never encounter text as clean and tidy as a list of strings. You will more likely be working with data in a large spreadsheet, or a database, or maybe a web-based archive. If you work with physical writing like letters or journals, you may rely on scanning techniques like optical character recognition (OCR) that introduce errors into your data; or perhaps you will work with a non-standard format of text that does not distniguish between primary data (like the message text in an e-mail) with metadata (like date, address of sender, subject line, etc.) 

While each of these situations do involve text that you can analyze via sentiment analysis, they also require you to find creative ways to clean, filter, and re-organize data before it is ready for exploratory data analysis. This process is sometimes called [*data wrangling*](https://en.wikipedia.org/wiki/Data_wrangling).

In Part 2, we will explore some of the unique challenges that come with wrangling and then exploring data from a large text corpus: in this case, a collection of ~600K e-mail transcripts. Like before, our exploration will be driven by research questions - but these questions will evolve and change as we learn more about our data. 

## Lesson Goals

In this lesson, you will achieve the following goals:

* Develop a exploratory data analysis strategy to pursue research questions;
* Wrangling a large amount of raw text files into a DataFrame structure using Python modules and the pandas library;
* Apply a computational text analysis technique (in this case, sentiment analysis) to a large correspondence corpus; and
* Output findings in a .csv data format that will allow you to explore and visualize the data further (as previewed in this lesson and covered in detail in other Programming Historian lessons!)

## The Research Question

Let’s imagine that, as we explore the Enron data, we decide that we want o better understand relationships between individuals who worked at Enron. Specifically, we want to detect significant relationships we may not have been aware of previously. For our study, one measure of "singificant relationships" may be frequent communication between individuals and/or atypical emotional sentiment in that communication (whether especially positive or especially negative).

We might begin wondering questions like: who is communicating frequently within the organization? What is the quality of their relationships like - in particular, how positively or negatively do they communicate with one another? And what particular aspects of those individuals - such as their gender, position within the organization, etc. - correlate with the positivity and negativity of those interactions?

Instead of getting bogged down with too many questions, let's start with one: what type of relationships did Enron's CEO at the time, John Lavorato, have with his employees? And in particular, with whom did he have extremely positive or extremely negative interactions?

To answer this question, we need a way of identifying significant emails as well as trends across many hundreds of thousands of emails. While our sentiment analysis function from Part 1 was a good first attempt, it is no longer feasible to simply go over each e-mail alone. We need to create a data structure that allows us to understand trends and significant findings across all 600,000 e-mails in the corpus. 

Here's one way to redefine our questions about the CEO: what are the ten most positive and ten most negative email exchanges from John Lavorato's sent e-mail folder?

## Wrangling Raw Data into a More Accessible Data Structure

The first step in our data wrangling process is to transform our raw e-mail data into a structure where we can view, explore, analyze, and output findings about the entire Enron e-mail dataset within Pyhton. Programming Historian hosts a number of lessons that explore data structuring and cleaning processing, including using [OpenRefine](https://programminghistorian.org/lessons/cleaning-data-with-openrefine "Another lesson on Programming Historian called Cleaning Data with OpenRefine"): a free, open-source “power tool” for cleaning data.

In our case, we will continue using Python as our primary tool for processing data -- but this time, we need to introduce some new methods for working with the unique parameters of the Enron e-mail corpus dataset.

In the early 2000s, Stanford University collected the publicly disclosed Enron emails into a new dataset for researchers. Each email is represented as a single text file like this one:

```
Message-ID: <18360155.1075860915254.JavaMail.evans@thyme>
Date: Fri, 1 Mar 2002 11:34:13 -0800 (PST)
From: kevin.hyatt@enron.com
To: eric.gadd@enron.com, lorraine.lindberg@enron.com, kimberly.watson@enron.com, 
    mark.mcconnell@enron.com
Subject: Aquila Red Lake storage project
Cc: steve.dowd@enron.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: steve.dowd@enron.com
X-From: Hyatt, Kevin </O=ENRON/OU=NA/CN=RECIPIENTS/CN=KHYATT>
X-To: Gadd, Eric </O=ENRON/OU=NA/CN=RECIPIENTS/CN=Egadd>, Lindberg, Lorraine </O=ENRON/OU=NA/CN=RECIPIENTS/CN=Llindbe>, Watson, Kimberly </O=ENRON/OU=NA/CN=RECIPIENTS/CN=Kwatson>, McConnell, Mark </O=ENRON/OU=NA/CN=RECIPIENTS/CN=MMcConne>
X-cc: Dowd, Steve </O=ENRON/OU=NA/CN=RECIPIENTS/CN=Notesaddr/cn=a54e0f3-f997ad82-86256b19-7775ee>
X-bcc: 
X-Folder: \Kim_Watson_Mar2002\Watson, Kimberly\Aquila Red Lake Storage
X-Origin: Watson-K
X-FileName: kwatson (Non-Privileged).pst

 

Attached are my notes from the open season meeting today.  Feel free to amend with your own notes (those of you who attended of course).  Call me with any questions.

Kh
```
The email transcript consists of a header with several metadata categories (e.g., Date, From, To) and a text area for the body of the e-mail message. Note that while the transcript specifies a file attachment and provides an X-FileName value of “kwatson (Non-Privileged).pst”, the dataset omits all attachments and only includes the raw text.

The Enron dataset organizes e-mail transcipts into a series of folders. Every e-mail user is represented as a folder, which is named the individual's username (such as "lavorato-j"). Each of these username folders contains a set of subfolders that corresponds to the folders in the original e-mail account (such as "inbox", "sent", "personal", etc.). The e-mails themselves exist within these subfolders. Each e-mail is stored in a single plain text file – but, curiously, these files are named without a file extension like ".txt". Instead, each is simply a number in sequence followed by a dot, such as "1.", "322.", "42.", etc.

While the amount of e-mails for each user is typically very large, these e-mails actually represented only a smaller subset of the original e-mail disclosure from 2003. The initial e-mails contained a large amount of very sensitive information, such as phone numbers, Social Security numbers, and other very personal data. Investigators ended up recalling and redacting much of this data; the 2011 version released by Stanford University researchers represents the most ethical disclosure of this data following signficant modifications in 2004, 2009, and 2011. The pricincipal administrator of the dataset, William Cohen, describes the terms of use:

> I am distributing this dataset as a resource for researchers who are interested in improving current email tools, or understanding how email is currently used. This data is valuable; to my knowledge it is the only substantial collection of "real" email that is public. The reason other datasets are not public is because of privacy concerns. In using this dataset, please be sensitive to the privacy of the people involved (and remember that many of these people were certainly not involved in any of the actions which precipitated the investigation.) (Cohen, 2015)

Please keep the spirit of Cohen's terms of use in mind when following this lesson and pursuing any further investigations on your own. 

## Structuring the E-mail Corpus, Part 1: Iterating Through the Filesystem 

<div class="alert alert-warning">
 For the following steps, you will need to download a subset of Enron email corpus (the "sent" folder of the Enron CEO). You can download an archived version <a href="https://github.com/programminghistorian/ph-submissions/raw/gh-pages/lessons/lavorato-j.zip">here</a>.
</div>

To begin working with the Enron e-mail corpus data, we must transform the data from its raw format (a collection of text files organized into folders and subfolders) into a format Python can understand. Python contains a set of general functions for handling text input; the language also contains several additional collections of code that we can selectively include in a program to increase functionality. These extra collections of codes are called *modules*.

In this case, we will use some functionality from the general Python library and also include code from two additional Python modules: *os* and *email*.

*os* extends the file input/output abilities of Python. In particular, it adds the ability to learn the file structure of a complex series of folders and subfolders. For our program, this will allow us to scan through the entire corpus and import all of the data at once. (It’s important to be careful using os, especially with any functionality that would move or delete files!!)

*email* extends Python's understanding of collections of text to detect e-mail message data and metadata. This is especially hehlpful when dealing with e-mail transcripts that are not necessarily organized in a tidy, standard format, such as the [*comma-separated values (.csv)* format](https://en.wikipedia.org/wiki/Comma-separated_values). In the Enron e-mail corpus, our data is structured in an outdated format using colons, spaces, and newline characters to distniguish between entries. While the regular comma-separated format is preferable in many situations, raw data is rarely perfect! The *email* module helps us bridge the difference.

Below is a code excerpt that uses the *os* and *email* libraries to loop over all e-mail text files in the corpus and store the relevant message data and metadata into memory. Note that you will not be able to run this script with Python just yet -- we will add more features in the next section with pandas to complete this section. For now, let's start exploring this code:

```
# beginning a new Python file

# the os package (part of the Python standard library) helps to quickly move through the folder structure of our Enron corpus data
import os

# the email module (also part of the Python standard library) allows the raw email data (currently formatted as headers with colons, not a standard CSV/JSON file) to be read as a dictionary
import email

# dependencies for sentiment analysis

import nltk.data
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from nltk import sentiment
from nltk import word_tokenize

#loading Vader and the tokenizer into easy object names. This is the same steps we went through in Part 1

sid = SentimentIntensityAnalyzer()
tokenizer = nltk.data.load('tokenizers/punkt/english.pickle')
```

The code above matches the code we wrote in Part 1, with a couple of new "import" statements. Below we will add a new looping or *iteration* pattern to our code. Our goal is to iterate through all text files in our e-mail data and store all of the relevant parts into variables that Pypthon can work with more easily. For every e-mail transcript we find, we will take the message, sender address, recipient address, etc., and store all of these values within a single dictionary. After generating a new e-mail dictionary, we will simply append it to the end of email_list. The end result will be a long list of dictionaries, each one representing a single e-mail that had been previously stored in a collection of folders and text files.

Let's see what the code looks like:

```
# Now we are adding new iteration steps to our code.
# Our goal is to iterate through all text files in email corpus or a subset of corpus - one text file for each email
# NOTE: You may need to change the path below. 
# This is the correct path if your script is saved to the same place where the "lavorato-j" folder is saved.
# If the "lavorato-j" folder is elsewhere, you may need to modify the path to instruction Python where to look.
path = "lavorato-j/sent/"

# Create an empty list. This variable will store a giant list of every email transcript in the Enron corpus -- each email transcript will be represented as a dictionary, so email_list will store a list of dictionary objects (such as [email_dictionary1, email_dictionary2, email_dictionary3...])

email_list = []

# iterate through all raw email text files in the sent folder.
# The bracket notation in Python is called a list comprehension. This generates a list (in this case, a giant list of all filenames) given the rule specified after the “if” statement. In this case, Python receives a directory listing of all items contained within a directory 

for filename in [filename for filename in os.listdir(path) if not filename.startswith('.')]:
    
# Create a blank dictionary for each iteration - so one for each email message. 
# We will fill this dictionary with information from our raw text files and append it to the email_list at the end.
    
    out_dict = {}

# Now we must open each file to retrieve its contents. 
# Fortunately, we already have the filename in the f variable (representing the specific email we are looping over at the moment). 
# We previously stored the file path, or everything that comes before the filename, in the “path” variable above. 
# Python very conveniently lets us combine these two strings with addition (path+filename), and use the “with” syntax to open up the appropriate file (as a read-only or "r" file) and set the variable myfile to point to the file.

    with open(path+filename, "r") as myfile:
      
# Here’s where the email library helps us. 
# We can call the email.message_from_string() function to convert the raw message data into a dictionary, which makes it easier to process. 
# Note that we need to force Pythonto treat myfile like a single long string of text, so we use the the read() method on myfile to force it to output a string (as opposed to simply passing along the variable myfile).

        msg = email.message_from_string(myfile.read())

# Now we need to unpack all of the relevant data in our msg variable and place only the most important fields into our out_dict dictionary. 
# In terms of metadata, we’re just going to focus on From, To, Date, and Subject. 
# The full message text requires us to use a special method, in this case get_payload(). 
# Like before, this method ensures that Python treats our data like a string as opposed to another type of data.

        out_dict['From'] = msg['From']
        out_dict['To'] = msg['To']
        out_dict['Date'] = msg['Date']
        out_dict['Subject'] = msg['Subject']
        out_dict['Message'] = msg.get_payload()

# We’ve successfully packed all of the relevant information for this message into the out_dict variable! 
# But we don’t want all of our hard work to get lost after the loop moves on to the next email text file. 
# We will use the append() method to add our dictionary to the email_list variable.

        email_list.append(out_dict)

# End of loop. 
# After the loop finishes cycling over every file in the corpus, email_list will store a sequence of over 600,000 dictionaries!

```

With the code above, we have converted a giant collection of raw data (folders, subfolders, and text files) into a data format that Python understands much better (a list of dictionaries, each one containing all of the vital information of each email as key-value pairs). This is a wonderful first step! 

However, for our purposes, we also need to be able to quickly move across all of this data, summarize it in a meaningful way, and apply sentiment analysis across the hundreds of thousands of emails. In other words, we need to manipulate the data in a way that moves beyond the structure of lists and dictionaries. While we could use custom-written Python code to perform these tasks, it might be more helpful to introduce you to another library that researchers and developers commonly use when using complex collections of data: pandas.

## Structuring the Email Corpus, Part 2: Creating a DataFrame

pandas has emerged over the past several years as a popular open source library for exploratory data analysis in Python. pandas brings together a powerful collection of data structure types and data analytical tools in a single high-performance package. If you want to do any kind of data-heavy research in Python, pandas is a great tool to learn and use.

Using pandas allows us to do several important things for our exploratory data analysis task:
* Convert our list of dictionaries into a single table-like structure called a DataFrame, which provides us with special methods and techniques
* View quick summaries of the data and filter for only the data we are most interested in
* Apply a custom-written function (in our case, the sentiment analysis function) to the entries in our DataFrame, and append the results to a new field for each email

<div class="alert alert-warning">
 This lesson was written using pandas 0.21.0. You must use a Python package installer such as pip to install pandas for Python 3. For more information about installing pandas, visit [the pandas documentation](https://pandas.pydata.org/pandas-docs/stable/install.html "Install page in the pandas documentation")</div>

To start doing helpful things with pandas, we must first load all of our email data into a new DataFrame variable. This requires adding some extra “import” statements at the top of our script, telling our new DataFrame what column names to use (in this case, these column names will match the key names in our email dictionaries), and then converting our big list of dictionaries into a single DataFrame.

Below is the same script from the previous section with these extra pandas features. We are also going to add a few lines at the end to print out information about our new DataFrame to the console. You should be able to run this script directly on your computer, provided you have downloaded the Enron corpus subset (and don’t forget to rewrite the path variable with the actual location where you downloaded and unzipped the subset to on your computer!!):

```
# beginning a new Python file

# the os package (part of the Python standard library) helps to quickly move through the folder structure of our Enron corpus data
import os

# the email module (also part of the Python standard library) allows the raw email data (currently formatted as headers with colons, not a standard CSV/JSON file) to be read as a dictionary
import email

# also add the pandas library

import pandas

# dependencies for sentiment analysis

import nltk.data
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from nltk import sentiment
from nltk import word_tokenize

#loading Vader and the tokenizer into easy object names. This is the same steps we went through in Part 1

sid = SentimentIntensityAnalyzer()
tokenizer = nltk.data.load('tokenizers/punkt/english.pickle')

# Now we are adding new iteration steps to our code.
# Our goal is to iterate through all text files in email corpus or a subset of corpus - one text file for each email
# NOTE: You may need to change the path below. 
# This is the correct path if your script is saved to the same place where the "lavorato-j" folder is saved.
# If the "lavorato-j" folder is elsewhere, you may need to modify the path to instruction Python where to look.
path = "lavorato-j/sent/"

# Create an empty list. This variable will store a giant list of every email transcript in the Enron corpus -- each email transcript will be represented as a dictionary, so email_list will store a list of dictionary objects (such as [email_dictionary1, email_dictionary2, email_dictionary3...])

email_list = []

# iterate through all raw email text files in the sent folder.
# The bracket notation in Python is called a list comprehension. This generates a list (in this case, a giant list of all filenames) given the rule specified after the “if” statement. In this case, Python receives a directory listing of all items contained within a directory 

for filename in [filename for filename in os.listdir(path) if not filename.startswith('.')]:

# Create a blank dictionary for each iteration - so one for each email message. 
# We will fill this dictionary with information from our raw text files and append it to the email_list at the end.

    out_dict = {}

# Now we must open each file to retrieve its contents. 
# Fortunately, we already have the filename in the f variable (representing the specific email we are looping over at the moment). 
# We previously stored the file path, or everything that comes before the filename, in the “path” variable above. 
# Python very conveniently lets us combine these two strings with addition (path+filename), and use the “with” syntax to open up the appropriate file and store it into the variable myfile.

    with open(path+filename, "r") as myfile:
        
# Here’s where the email library helps us. 
# We can call the email.message_from_string() function to convert the raw message data into a dictionary, which makes it easier to process. 
#Note that we need to force Pythonto treat myfile like a single long string of text, so we use the the read() method on myfile to force it to output a string (as opposed to simply passing along the variable myfile).

        msg = email.message_from_string(myfile.read())

# Now we need to unpack all of the relevant data in our msg variable and place only the most important fields into our out_dict dictionary. 
# In terms of metadata, we’re just going to focus on From, To, Date, and Subject. 
# The full message text requires us to use a special method, in this case get_payload(). 
# Like before, this method ensures that Python treats our data like a string as opposed to another type of data.

        out_dict['From'] = msg['From']
        out_dict['To'] = msg['To']
        out_dict['Date'] = msg['Date']
        out_dict['Subject'] = msg['Subject']
        out_dict['Message'] = msg.get_payload()

# We’ve successfully packed all of the relevant information for this message into the out_dict variable! 
# But we don’t want all of our hard work to get lost after the loop moves on to the next email text file. 
# We will use the append() method to add our dictionary to the email_list variable.

        email_list.append(out_dict)

# End of loop. 
# After the loop finishes cycling over every file in the corpus, email_list will store a sequence of over 600,000 dictionaries!

# Now we will add the additional steps to convert our data to a DataFrame. 
# First, we will create a blank DataFrame. 
# The DataFrame structure is similar to a table, and fields are called “columns” in pandas. 
# When we create our blank DataFrame, we want to also instruct pandas to build columns that match the fields we have singled out in our email dictionaries above.

emailDataFrame = pandas.DataFrame(columns=('Message-ID', 'From', 'To', 'Date', 'Subject', 'Message'))

# Now let’s add the data. 
# One of the best parts of working wiht DataFrames is access to a big collection of powerful methods. 
# In this case, we can simply use the .from_dict() method to convert our list of dictionaries into a single DataFrame -- no extra iteration required.

emailDataFrame = pandas.DataFrame.from_dict(email_list)

# And we’re done. 
# Now we want to visualize our DataFrame a bit. 
# We accomplish this by printing out summaries of our DataFrame data to the console. 
# First, let’s make sure we have the pandas view settings configured to see our full data:

pandas.set_option('display.expand_frame_repr', False)  

# Note that we called this method on pandas, not emailDataFrame. This view setting is a global setting for all python functions.

# Now let’s print out some summaries of our data. 
# The .head() method will print out the top few rows in our DataFrame -- we can specify exactly how many rows by passing in an integer to the method. 
# Let’s try 10.

print(emailDataFrame.head(10))

# If you’d like to play with outputs, try some of these as well
#print(emailDataFrame)
#print(emailDataFrame.head(50))
#print(emailDataFrame.To.value_counts())

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

Succes! We have transformed the corpus email data into a single new data structure called a DataFrame. The *df.head(10)* method outputs a tidy table summary of the first 10 rows of the DataFrame we named *df*. Remember that a DataFrame behaves much like a matrix or table in that it conceptualizes each data entity as a row consisting of several standard columns.

Feel free to play with the output settings in pandas to see more of Lavorato’s sent email box as a giant DataFrame.

## Adding sentiment analysis to our email corpus DataFrame

The goal of our exploratory data analysis at this point is to identify emails that suggest very emotional relationships between Lavorato and his colleagues. To do this, we need to reintroduce sentiment analysis to our data.

Earlier in this tutorial, we discussed the difficulties of going from sentiment analysis of a single passage of text to sentiment analysis of a large and complex email corpus. But we’ve made progress! At this point we are at the halfway mark. We have loaded a giant collection of files into memory, selected the key data we want to collect from each email, and converted our outputs into a single, large, table-like DataFrame. This data structuring work will make all of our subsequent exploration of data more powerful and easier to visualize for us researchers.

One key benefit of using DataFrames is that we can write custom functions that analyze our data in some format, and then quickly map that function across our entire collection of data. In pandas, “mapping” typically means looping through all of our data (or a subset of our data), processing a field or multiple fields from each item using our function of choice, and then storing the outputs of that function back into the DataFrame, often as a brand-new column or columns. pandas does the difficult work of structuring data and giving us methods to work with data, and we can add on top of those features our own analytical methods, whatever those may be.

Let’s continue our investigation into the 10 most positive and 10 most negative emails that Lavorato has sent off to others. We have already written code that takes in message text as input and outputs a sequence of scores as the output. Recall that in Part 1, we discussed the value of capturing sentence-by-sentence sentiment scores as opposed to a single set of sentiment scores for an entire message. For the purposes of Part 2, we are going to return a single set of scores (positive, neutral, negative, and compound) for the entire e-mail message, regardless of length (please refer to Part 1 for the previous discussion of the pros and cons of this approach to scope). This is just one of several ways to approach this problem. 

In order to map our sentiment analysis to the DataFrame, we need to package our code into a single function that can accept the text of the message as an input parameter. We will call this function mapMessageSentiment(). Our mapping function is almost identical to that earlier code, except for how it handles input and output. Input is passed into the function via a single string variable called *message*.

Output is a little more complicated. We have to find a way to pass along the four components of our sentiment analysis results:  *compound*, *positive*, *neutral*, and *negative* outputs generated by the Vader SentimentIntensityAnalyzer() module. We ultimately want to treat each of these scores as independent columns. To do this, we need to break our approach into two steps: (1) calculate a single collection of scores (positive, negative, neutral, compound) in a combined score column, and (2) map each of these scores onto its own separate column. 

mapMessageSentiment() will thus return a single object containing the four sentiment score types. In Python, a *tuple* is a data structure in which multiple items are combined into a single entity, like this: (0.2, -0.8, 1.0, 0.5). A tuple is very similar to a list -- both are a collection of objects. Unlike a list, however, we can't change a tuple once we create it, and it's a little faster for Python to process. 

The output of mapMessageSentiment() will be a single tuple, perhaps something like: (0.2, -0.8, 1.0, 0.5). We will place this tuple in a new column in emailDataFrame called Sentiment. 

Once we have generated our Sentiment outputs, we have one additional step remaining: create four unique columns based on the four values in our Sentiment tuple. To do this, we can repeat the mapping step, but this time convert the four-item Sentiment tuple into four new columns in our DataFrame: CompoundSentiment, PositiveSentiment, NeutralSentiment, and NegativeSentiment. Having these values in their own unique columns will help us do things like sort the data by Positive score or Compound score.

Actually, we'll sort the DataFrame right now! DataFrames supports sorting and filtering much like a table in Excel. We will immediately take advantage of this feature by sorting the entire DataFrame by CompoundSentiment values in descending order. The DataFrame method *sort_values()* generates a new DataFrame sorted by whatever column name and parameters we set as inputs. We can then use the *head()* DataFrame method to print out information about the e-mails with the highest *CompoundSentiment* values. Finally, we can repeat the process but using an ascending sort to find the e-mails with the lowest *CompoundSentiment* values.

Below, we define the mapMessageSentiment function; use the *map* functionality of DataFrames to apply mapMessageSentiment to all e-mails and store the output in a new *Sentiment* column; map the four-part Sentiment object to four unique columns, named *CompoundSentiment*, *PositiveSentiment*, *NeutralSentiment*, and *NegativeSentiment*; and, finally, sort the DataFrame twice to show us the 5 most positive and 5 most negative e-mails in the collection:
```
#...includes the code from the section above, and adds the following

# Here we define the mapMessageSentiment function. Note that the function takes message as a parameter.

def mapMessageSentiment(message_text):

# Calling the polarity_scores method on sid and passing in the message_text outputs a dictionary with negative, neutral, positive, and compound scores for the input text

    scores = sid.polarity_scores(message_text)

# Here we assign the four outputs contained in scores to four separate variables

    compound = scores['compound']
    positive = scores['pos']
    neutral = scores['neu']
    negative = scores['neg']

# Instead of returning just one score, we will return a tuple object containing all four scores.
# To indicate this in Python, we simply write all four variables separated by commas, and surround them with parantheses.

    return (compound, positive, neutral, negative)
  

# Now that we’ve defined the mapMessageSentiment() function, we want to map it to our DataFrame. Pandas gives us two options for referring to the data in columns: the dictionary-like use of brackets (as in df[‘Sentiment’]) and the class-like use of periods (such as df.Message). Below we mix and match both.

# To generate a new column based on our function, we use the apply() method on the column we wish to input into our function. We can then use the equals sign to assign the output of that function to its target column. pandas will simply generate a new column if it doesn’t recognize the column name (in this case, we haven’t created the Sentiment column previously). The apply() method accepts the name of a function as a parameter -- we don’t even need to use parantheses or specify the input parameter at all! pandas knows that we wish to automatically apply this function to every item in the DataFrame and use the designated column (Message) as input data.

emailDataFrame['Sentiment'] = emailDataFrame.Message.apply(mapMessageSentiment)

# Now we use the apply() method for a slightly different purpose: to take a collection of data that has been packed into a single variable (in this case, the tuple that stores (compound, positive, neutral, negative) scores ) and add each item to its own column. To do this, we must pass in the special pandas method pandas.Series. We indicate our target column names by passing in a list of new column names into df[]. (This is a good example of how pandas is sometimes very strange and demanding in its syntax -- you may find yourself Googling questions about pandas often!)

emailDataFrame[['CompoundSentiment', 'PositiveSentiment', 'NeutralSentiment', 'NegativeSentiment']] = emailDataFrame['Sentiment'].apply(pandas.Series)

# Now that we’ve generated new columns and filled them with the appropriate sentiment data, we want to see the top positive and top negative results. We can do this in a number of ways. In this example, we will actually create two new ranked lists using the sort_values() method, sorted in descending order, and use the .head() method to print out the first 10 values in each ranked list:

ranked_positive_emails = emailDataFrame.sort_values('CompoundSentiment', ascending=False)
print(ranked_positive_emails.head(10))


ranked_negative_emails = emailDataFrame.sort_values('CompoundSentiment', ascending=True)
print(ranked_negative_emails.head(10))
```

*Output*
```
                                      Date                       From                                            Message                                            Subject                                              To                      Sentiment  CompoundSentiment  PositiveSentiment  NeutralSentiment  NegativeSentiment
95   Tue, 11 Jul 2000 03:01:00 -0700 (PDT)    john.lavorato@enron.com  ---------------------- Forwarded by John J Lav...                                              Bruce                         rob.milnthorp@enron.com  (0.9991, 0.172, 0.815, 0.013)             0.9991              0.172             0.815              0.013
97   Tue, 11 Jul 2000 03:21:00 -0700 (PDT)    john.lavorato@enron.com  Dave\n\nIt looks like we hit a home run.\n\n\n...                                              Bruce                        david.delainey@enron.com  (0.9991, 0.173, 0.815, 0.013)             0.9991              0.173             0.815              0.013
178   Fri, 4 Aug 2000 05:56:00 -0700 (PDT)    john.lavorato@enron.com  Kevin\n\nIs this the guy you are interviewing....  cover letter and resume for positions in natur...                          kevin.presto@enron.com  (0.9983, 0.178, 0.796, 0.025)             0.9983              0.178             0.796              0.025
329   Sun, 8 Oct 2000 13:01:00 -0700 (PDT)    john.lavorato@enron.com  I hope you are talking to Phillip to get you s...        Consolidated positions: Issues & To Do list                           john.arnold@enron.com  (0.9975, 0.098, 0.888, 0.014)             0.9975              0.098             0.888              0.014
233  Thu, 24 Aug 2000 00:45:00 -0700 (PDT)    john.lavorato@enron.com  If this is OK with you its OK with me.  \n----...                       Approval for transfer to EBS                           andrea.reed@enron.com  (0.9961, 0.136, 0.852, 0.012)             0.9961              0.136             0.852              0.012
376  Tue, 31 Oct 2000 00:43:00 -0800 (PST)    john.lavorato@enron.com  It's strarting.\n---------------------- Forwar...                    Enron Direct Systems for Canada                        david.delainey@enron.com  (0.9958, 0.154, 0.838, 0.008)             0.9958              0.154             0.838              0.008
198  Tue, 31 Oct 2000 23:29:00 -0800 (PST)    john.lavorato@enron.com  I wonder with Joe Sutton gone if they can canc...          Final Associate/Analyst 2000 PRC - Jacoby                        david.delainey@enron.com  (0.9936, 0.083, 0.906, 0.011)             0.9936              0.083             0.906              0.011
181  Thu, 14 Dec 2000 03:46:00 -0800 (PST)    john.lavorato@enron.com  Same a mid year\n\nI'm smarter than everyone e...                                            Re: PRC                        david.delainey@enron.com  (0.9926, 0.188, 0.744, 0.068)             0.9926              0.188             0.744              0.068
478  Sun, 10 Dec 2000 03:00:00 -0800 (PST)    john.lavorato@enron.com  vp ranking - call if I missed anyone.\n\nAllen...                                                     kim.melodick@enron.com, jeanie.slone@enron.com  (0.9924, 0.693, 0.274, 0.033)             0.9924              0.693             0.274              0.033
2    Mon, 22 May 2000 11:36:00 -0700 (PDT)  kimberly.hillis@enron.com  Sure thing!  I will give it to her in the morn...                     Re: Summer Stroll for Epilepsy                        susan.skarness@enron.com  (0.9916, 0.171, 0.821, 0.008)             0.9916              0.171             0.821              0.008
                                      Date                     From                                            Message                        Subject                         To                       Sentiment  CompoundSentiment  PositiveSentiment  NeutralSentiment  NegativeSentiment
574  Tue, 25 Jan 2000 12:31:00 -0800 (PST)  john.lavorato@enron.com  Jim\n\nThis information on Ontario nukes is si...             Re: Canadian Nukes     james.fallon@enron.com    (-0.8445, 0.0, 0.919, 0.081)            -0.8445              0.000             0.919              0.081
227  Sun, 20 Aug 2000 06:55:00 -0700 (PDT)  john.lavorato@enron.com  Dave\n\nWe need to think about trying to get m...                                  david.delainey@enron.com      (-0.8316, 0.0, 0.83, 0.17)            -0.8316              0.000             0.830              0.170
637  Sun, 14 May 2000 03:04:00 -0700 (PDT)  john.lavorato@enron.com  Call me on Beau.  A couple thoughts.\n\nIf the...                                   rob.milnthorp@enron.com    (-0.8316, 0.0, 0.773, 0.227)            -0.8316              0.000             0.773              0.227
535  Thu, 21 Dec 2000 04:49:00 -0800 (PST)  john.lavorato@enron.com  ---------------------- Forwarded by John J Lav...        EOL WTI New Simulations    rudy.gonzalez@enron.com  (-0.8201, 0.028, 0.876, 0.096)            -0.8201              0.028             0.876              0.096
425  Sun, 26 Nov 2000 23:40:00 -0800 (PST)  john.lavorato@enron.com  l.a. but I'll kill it.  1 went 6-4 with two pu...                            Re:      john.arnold@enron.com    (-0.8201, 0.0, 0.696, 0.304)            -0.8201              0.000             0.696              0.304
553  Sat, 30 Dec 2000 00:49:00 -0800 (PST)  john.lavorato@enron.com  tease colts +4 under 48 250\n\n   tease colts ...                                     john.arnold@enron.com     (-0.802, 0.0, 0.731, 0.269)            -0.8020              0.000             0.731              0.269
560   Tue, 2 Jan 2001 01:52:00 -0800 (PST)  john.lavorato@enron.com  Janet \n\nCommunication is always a problem ar...         Re: Management Reports   janet.dietrich@enron.com     (-0.765, 0.0, 0.703, 0.297)            -0.7650              0.000             0.703              0.297
125  Tue, 18 Jul 2000 02:13:00 -0700 (PDT)  john.lavorato@enron.com  Sorry Jim but I left you a voicemail saying th...       Re: Power Outage 6/28/00  james.bouillion@enron.com    (-0.7096, 0.0, 0.635, 0.365)            -0.7096              0.000             0.635              0.365
555  Sun, 31 Dec 2000 06:26:00 -0800 (PST)  john.lavorato@enron.com  Fred\n\nFirst of all I'm going to kill you.  B...                                   fred.lagrasta@enron.com      (-0.6908, 0.0, 0.92, 0.08)            -0.6908              0.000             0.920              0.080
573   Sun, 7 Jan 2001 13:26:00 -0800 (PST)  john.lavorato@enron.com  I will not accept Amerex having the ability to...  Re: EnronOnline Broker Client       bob.shults@enron.com  (-0.6792, 0.079, 0.685, 0.236)            -0.6792              0.079             0.685              0.236
```
<div class="alert alert-warning"> Remember to modify the ‘path’ variable with your system’s location information</div>

Using this technique, we discover a curious set of emails:
* On the positive end, Lavorato expresses excitement for positive results ("It looks like we hit a home run."), boastful confidence ("I'm smarter than everyone"), and chipper eagerness ("Sure thing! I will give it to her in the morn..."). 
* On the negative side, we discover outright hostility ("First of all I'm going to kill you."), statements of disapproval and resistance ("I will not accept Amerex having the ability to..."), and language that implies conflict of varying degrees ("We need to think about", "Call me on Beau. A couple thoughts"). (As well as a quick reference to what appears to be fantasy American football with "tease colts +4 under 48). 

Each of these results introduces new questions -- what is the "home run" Lavorato is referring to? What does "I'm going to kill you" mean!? (I'm assuming the "killing" in question is more figurative, and perhaps it is even written playfully between colleagues who know each other well.) In other words, the sentiment outputs here do not provide definitive answers so much as clues towards future investigation.

At this point, we have developed a technique for identifying the emotional extremes of emails sent by a particular individual. For a researcher interested in understanding how specific individuals communicated in the midst of the Enron collapse, this might provide a valuable jumping-off point to conduct a deep dive into those moments of conflict and intensity – or perhaps an investigation into positive, possible collusive relationships!

QUESTIONS: Do you feel this method was successful? Why or why not? What could you imagine doing to improve the error rate of this output? What methods might you imagine being more productive at answering your research questions? 

CHALLENGE: If you would like to investigate other individuals at Enron in a similar fashion, feel free to download the full Enron e-mail corpus in the next section and replace the "lavorato-j" folder with another user's e-mails. You will need to also change the "path" variable to reflect this new focus area -- but that's the only change you need to make! Go ahead and pose some new questions, try some new ways to filter your data, and see what you find!


# From Corpus to Network: Exploring Relationships Within a Community

Note: For this final section we will be using the full Enron corpus. This full corpus can be [downloaded online via Stanford here](http://www.cs.cmu.edu/~enron/enron_mail_20150507.tar.gz). We will introduce new methods that go deeper into network analysis and use more complex Python algorithms -- feel free to skip to the conclusion if you would rather skip this type of analysis. Otherwise, let's dive in!

## Sentiment Analysis Across a Network

Imagine that, at this point in your research, you affirm that you are indeed interested in the relationships between individuals in the organization. But instead of focusing your exploration on Lavorato, the CEO, you would instead like to identify pairs of individuals who share either intensely positive or intensely negative relationships, according to their email correspondence. You may be interested in identifying the extremes of negative conflict or positive collaboration (or collusion?) at Enron. Rather than start with a known individual, you would like the data itself to suggest pairs of individuals to investigate.

This shift in focus - from an individual to unknown pairs in a community - is an example of the strength of exploratory data analysis. Once you dig more deeply into the data, you have the opportunity to go from initial premises to new questions and uncertainties, and perhaps modify or reframe your research questions along the way. 

However, we face a new challenge. Our analysis to this point has focused on using sentiment analysis to characterize the nature of individual emails. To understand relationships between individuals, we need a method for looking for significant relationships between individuals in the organization. 

For this, we can turn to social network analysis. A social network is a conceptual tool that helps explain how individuals interact within a community. In this model, a network represents a set of individuals as a series of points, which are called *nodes*. When an individual interacts with another node, this can be represented as a line connecting the first node (or source node) to the second node (or target node). This connecting line is called an *edge* in network analysis. Each edge might carry with it information that describes some aspect of the relationship between those two nodes -- often a number of some kind. A network graph is a visualization that represents a collection of nodes as well as a number of edges between those nodes. 

There are 150 usernames listed in the Enron corpus dataset, which means our network contains 150 nodes. The maximum amount of possible sender-recipient pairs of individuals would be 150*149 = 22350 sender-recipient pairs. (Note that this assumes the order of sender and recipient matters to us. If we did not care about who was the sender and who was the recipient, the maximum would be half of 22350 = 11175 bidirectional pairs.)

No matter how big our dataset, it’s unlikely that every individuals has written an email to every single other individual at Enron. It’s more likely that the actual edges represent a small subset of all possible edges in the network. Furthermore, because we are interested in detecting significant relationships, we may want to establish some rules about what constitutes a significant relationship between individuals. Perhaps an employee sent a single email to another employee -- is this a relationship worth investigating? What about if that email was actually a giant chain email forwarded to the entire company?

First we will use a few constraints to limit the emails we will include in the analysis:

* Instead of including emails in all subfolders, we will only look at the emails in the “sent” folder of every username. This helps us decrease the amount of time it will take to process the emails, while also ensuring that these emails represent meaningful communication between individuals (as opposed to spam, forwarded jokes (very common in 1999-2001), company-wide announcements, etc.)
* Only include emails with a single sender and single recipient. This helps us make sure the email is expressing something about a relationship between two individuals.
* Only include emails where the recipient email ends in @enron.com and appears as a sender elsewhere in the corpus (e.g. is one of the ~130 Enron employees included in the Corpus)

In this technique, we first create a list of all possible sender-recipient pairs in the DataFrame. At this stage, we apply a few further constraints to make sure we are capturing substantial relationships:

* Only include relationships that include at least three emails. This excludes incidental email exchanges and suggests there may be some kind of relationship between these two individuals. (You can play with this condition if you wish, which appears as: “if network_dict_count[pair] > 3”)
* Keep sender and recipient pairs directional, meaning that the emails A sends to B are aggregated separately than the emails B sends to A. Sometimes there is no need to differentiate between the direction of interactions in a relationship. In this case, however, we want to be able to separately consider how an executive communicates with a subordinate and how that same subordinate communicates with the executive -- the styles may be very different.

To start, we need to come up with a method for listing out every possible sender-recipient pair that meets our minimum thresholds above. To do this, we can start by combining the ‘From’ and ‘To’ columns in our email DataFrame into a single ‘Pair’ column (this is very similar to the way we created four Positive/Neutral/Negative/Compound columns from the Sentiment score tuple). We can then iterate through our DataFrame to count up the number of emails that match each To-From pair. 

We want to store the counts for each sender-recipient pair to reference later. A dictionary is a great fit for this task. We can use each pair as the ‘key’ in the dictionary (for example, for emails sent between John Lavorato and Chris Gaskill, the key will be: ‘john.lavorato@enron.com,chris.gaskill@enron.com'’) and the value will be the count of all emails belonging to that pair (such as 10). This will help us make sure later on that we're only dealing with pairs that have at least two emails in all of the Sent folders in the corpus.

In addition to keeping track of how many emails exist for each sender-recipient pair, we also want to keep track of the nature of the relationship -- in our case, that means the sentiment scores of the emails for the sender-recipient pairs. We can create a second dictionary called *network_dict_sentiments* to accumulate the sentiment scores for each pair’s emails. Again, we will use Pair strings ('john.lavorato@enron.com,chris.gaskill@enron.com') as dictionary keys, but this time the value will be a running total of the CompoundSentiment scores in all of the associated emails (such as 4.2). Later on, we can divide the sum of these scores to the number of scores to find the average score! But keep in mind that, if you are interested in a different metric (such as the distribution of scores) you would probably want to store each score in this variable individually, such as in a long list of scores, as opposed to simply storing their sum. However, for us, this will work well.

Now that we have a method for calculating the average sentiment scores for emails, we can create a new dictionary called *average_sentiment* to store those values. Again, our key will be the Pair of To-From email addresses, and the value will be the sum of Compound Sentiment scores divide by the number of Compound Sentiment scores. Here, you can see the value of using that same 'Pair' key name across all of those dictionaries! We can run through every possible Pair and pull values from each dictionary by using that Pair key name.

At this point, we have brought many different features together: calculating sentiment with NLTK; importing our raw email data using the os and email libraries; structuring the raw data as a DataFrame using pandas; and using Python to generate a network representation of sender-pair recipients along with the average sentiment score for each relationship (or “edge”). The code is starting to look complex, but will hopefully give you an idea of how to bring some of these libraries and features together for this exploratory task:

```
# beginning a new Python file
import pandas
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

# Iterates through all text files in email corpus or a subset of corpus - one text file for each email
# NOTE: Remember to change ‘path’ to the location of the uncompressed ‘maildir’ directory
path = 'maildir/'

# Iterated through to figure out all possible keys
count = 1
email_list = []

for subdir, dirs, files in os.walk(path):
    for filename in files:
        if filename.endswith(".") and subdir.endswith("sent"):
            working_path = os.path.join(subdir, filename)
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
 
 # Unlike the previous code, we are not going to automatically add all e-mails to our email_list variable.
 # We are going to ignore any e-mail with more than one sender address or more than one recipient e-mail address
 # (That is, we're only interested in e-mails between one sender and one recipient)
 # We're also going to ignore any e-mails not between enron employees (as defined by having a @enron.com e-mail address)
 
 # continue is the Python command that says "ignore any code after this point and jump ahead to the next loop cycle"
 # this effectively ignores the email_list.append() step, meaning our current e-mail will NOT be added to the email_list variable
 
                    if len(out_dict['To'].split()) > 1 or len(out_dict['From'].split()) > 1:
                        continue
                    if "@enron.com" not in out_dict['From'] or '@enron.com' not in out_dict['To']:
                        continue        
                    email_list.append(out_dict)
                
                except:
                    print('Error reading message ' + str(count) + ' at ' + working_path)
                
                count += 1
                print(str(count) + ': ' + working_path)


pandas.set_option('display.expand_frame_repr', False) #allows us to see more of the DataFrame
emailDataFrame = pandas.DataFrame.from_dict(email_list)


#output -- go ahead and play around with these outputs!
#print(emailDataFrame)
#print(emailDataFrame.head(10))
#print(emailDataFrame.To.value_counts())

def mapMessageSentiment(message_text):

# Calling the polarity_scores method on sid and passing in the message_text outputs a dictionary with negative, neutral, positive, and compound scores for the input text

    scores = sid.polarity_scores(message_text)

# Here we assign the four outputs contained in scores to four separate variables

    compound = scores['compound']
    positive = scores['pos']
    neutral = scores['neu']
    negative = scores['neg']

# Instead of returning just one score, we will return a tuple object containing all four scores.
# To indicate this in Python, we simply write all four variables separated by commas, and surround them with parantheses.

    return (compound, positive, neutral, negative)

emailDataFrame['Sentiment'] = emailDataFrame.Message.apply(mapMessageSentiment)
emailDataFrame[['CompoundSentiment', 'PositiveSentiment', 'NeutralSentiment', 'NegativeSentiment']] = emailDataFrame['Sentiment'].apply(pandas.Series)

# here we are going to add a new column called "Pair"
# Pair combines the From and To email addresses into a single string, such as "sender@enron.com,recipient@enron.com"
# This will help us learn more about these individual pairs of senders and recipients as we go forward

# Calculate a new Pair column that combines the 'From' email and 'To' email addresses into a single string, separated by a comma
emailDataFrame['Pair'] = emailDataFrame['From'] + ',' + emailDataFrame['To']

# We also want some way to keep track of all of the unique senders in our emailDataFrame
# Thankfully, pandas makes this easy with the .unique() method, which generates a list of all values in a column

senders_list = emailDataFrame.From.unique()

# Now we're going to add some Python tricks to start to characterize the relationships between sender-recipient pairs
# We want to track HOW MANY e-mails are sent between pairs, and the AVERAGE COMPOUND SENTIMENT of those e-mails
# To do so, we need to add up the number of e-mails, and also compute a running sum of the compound sentiments of these e-mails

# Python has a couple of ways of keeping track of this information. We are going to use dictionaries.
# One nice thing about using dictionaries is that we can make the "key" for these dictionaries the Pair string.
# Remmeber, this pair string looks like "sender@enron.com,recipient@enron.com"

# this dictionary stores the number of emails associated with each To-From Pair
network_dict_count = {}

# and this dictionary stores the running sum of the CompoundSentiment values for each of those emails
network_dict_sentiments = {}

# iterate through the DataFrame, count up the # of emails, add up their Compound Sentiment scores
# iterrows() is the pandas function that lets us go through every row in a DataFrame

for index, row in emailDataFrame.iterrows():
    if row['Pair'] in network_dict_count:
        network_dict_count[row['Pair']] += 1
        network_dict_sentiments[row['Pair']] += row['CompoundSentiment']
    else:
        network_dict_count[row['Pair']] = 1
        network_dict_sentiments[row['Pair']] = row['CompoundSentiment']

# Now we want to calculate the average Compound Sentiment.
# To do this, we can divide the sum of CompoundSentiment scores by number of e-mails exchanged
# We can also use this opportunity to filter out any e-mail exchanges that don't meet our minimum conditions
# As we loop through all of the e-mail correspondences, we will ignore e-mails that fail to meet our minimum threshold.
# 1) The if/then statement will simply ignore pairs with fewer than 3 e-mails sent, or 
# 2) when the recipient is not also a sender.

# The second rule helps ensure we are only keeping track of e-mails between individuals that have been singled out in the corpus.
# We could include other Enron employees in this analysis, but it is more ethical to limit it to our employees of interest.

# First, let's make our new dictionary to store these average values. (We'll keep using the Pair strings as our key).
average_sentiment = {}

# Now let's loop through all of the pairs we've been keeping track of.

for pair in network_dict_count:

# We will split the sender and recipient into separate variables again. We'll also make sure the cound is more than 1.
# And finally, we'll make sure the recipient is also a sender (belongs to the senders_list)

    sender, recipient = pair.split(',')
    if network_dict_count[pair] > 1 and sender != recipient and recipient in senders_list:
        average_sentiment[pair] = network_dict_sentiments[pair]/network_dict_count[pair]

# And we're done! Now the remaining step is to print out our data.

# The sorted() Python function returns the list of Pairs in descending order by average sentiment.
# the Pair with the most positive average email will appear first, and the most negative is last.
# (To get a descending list, we will use the "reverse=True" parameter).

sorted_pairs_positive = sorted(average_sentiment, key=average_sentiment.get, reverse=True)

# the slice [0:10] lets us focus on the first ten (most positive) emails. we print information about those ten emails
for pair in sorted_pairs_positive[0:10]:

# Now we know the pair with the most positive and most negative exchanges.
# We can use this Pair stirng ('sender@enron.com,recipient@enron.com') with the average_sentiment and network_dict_count dictionaries.
# This will let us fetch all the information we need.

    print(pair + ': ' + str(average_sentiment[pair]) + ' with ' + str(network_dict_count[pair]) + ' e-mails')

# Now let's repeat the same steps with the 10 most negative e-mails
# As in the previous section, we will create a new sorted list and simply turn off the reverse parameter in sorted().

print('\n')

sorted_pairs_negative = sorted(average_sentiment, key=average_sentiment.get, reverse=False)
for pair in sorted_pairs_negative[0:10]:
        print(pair + ': ' + str(average_sentiment[pair]) + ' with ' + str(network_dict_count[pair]) + ' e-mails')

# this code snippet saves the average sentiment values for each pair as a comma-separated values (.csv) table
fout = open('pair_average_sentiment.csv', 'w')
for pair in sorted_pairs_positive:
        fout.write('"' + pair + '",' + str(average_sentiment[pair]) + '\n')
fout.close()
```

*Output*
```
michelle.cash@enron.com,mark.haedicke@enron.com: 0.9856750000000001 with 4 e-mails
susan.scott@enron.com,gerald.nemec@enron.com: 0.9848333333333334 with 3 e-mails
vince.kaminski@enron.com,sherri.sera@enron.com: 0.97692 with 5 e-mails
mike.mcconnell@enron.com,greg.whalley@enron.com: 0.9683249999999999 with 4 e-mails
david.delainey@enron.com,jeff.skilling@enron.com: 0.9618666666666665 with 3 e-mails


scott.neal@enron.com,phillip.allen@enron.com: -0.446 with 6 e-mails
sara.shackleton@enron.com,john.arnold@enron.com: -0.16993333333333335 with 3 e-mails
scott.neal@enron.com,hunter.shively@enron.com: -0.14308 with 5 e-mails
greg.whalley@enron.com,jeffrey.shankman@enron.com: -0.07716 with 5 e-mails
john.lavorato@enron.com,vince.kaminski@enron.com: -0.043466666666666674 with 3 e-mails
```
<div class="alert alert-warning"> Remember to modify the ‘path’ variable with your system’s location information</div>

Here we’ve been able to identify specific relationships at either extreme of sentiment expressed. Positivity appears more likely to appear in exchanges with just a few emails, whereas the most negative relationships include ones with substantial email back-and-forth. (Note that Lavorato and Shankman appear in several relationships at either extreme.)

Again, we find a jumping-off point for further analysis which may or may not continue to use natural language processing techniques like Sentiment Analysis. In the final section, we'll return to investigate one of our results -- the most negative e-mail exchange between Scott Neal and Phillip Allen.

# One final exploration: Finding e-mails of interest

Let's continue working with our finding above. Let's say we want to investigate the two most positive and two most negative relationships we found in the corpus:
```
scott.neal@enron.com,phillip.allen@enron.com: -0.446 with 6 e-mails
sara.shackleton@enron.com,john.arnold@enron.com: -0.16993333333333335 with 3 e-mails
...
michelle.cash@enron.com,mark.haedicke@enron.com: 0.9856750000000001 with 4 e-mails
susan.scott@enron.com,gerald.nemec@enron.com: 0.9848333333333334 with 3 e-mails
```
To learn more about these e-mails, we can ask our DataFrame to return only the e-mails that match these sender-recipient pairs. Filtering in pandas looks somewhat similar to a Python dictionary, in that we specify values or conditions within brackets and the DataFrame object returns our matching values. Here's what a quick investigation into the four pairs above revealed:

```
# Add the following code to the end of the script from the previous section
queryPairs = ["scott.neal@enron.com,phillip.allen@enron.com", "sara.shackleton@enron.com,john.arnold@enron.com", "michelle.cash@enron.com,mark.haedicke@enron.com","susan.scott@enron.com,gerald.nemec@enron.com"]

for pair in queryPairs:
    print(emailDataFrame[(emailDataFrame.Pair == pair)])
```

*Output*
```
                                        Date                  From                                            Message Message-ID                               Subject                       To                       Sentiment  CompoundSentiment  PositiveSentiment  NeutralSentiment  NegativeSentiment                                          Pair
21017  Sun, 11 Feb 2001 23:39:00 -0800 (PST)  scott.neal@enron.com  ---------------------- Forwarded by Scott Neal...       None                                        phillip.allen@enron.com            (0.0, 0.0, 1.0, 0.0)             0.0000              0.000             1.000              0.000  scott.neal@enron.com,phillip.allen@enron.com
21030  Mon, 22 Jan 2001 07:55:00 -0800 (PST)  scott.neal@enron.com  re:  NAT\n---------------------- Forwarded by ...       None                 NAT spot tanker rates  phillip.allen@enron.com            (0.0, 0.0, 1.0, 0.0)             0.0000              0.000             1.000              0.000  scott.neal@enron.com,phillip.allen@enron.com
21118   Thu, 5 Oct 2000 09:23:00 -0700 (PDT)  scott.neal@enron.com  ---------------------- Forwarded by Scott Neal...       None  Fwd: FW: Montana Forest Fire picture  phillip.allen@enron.com   (-0.8691, 0.02, 0.892, 0.088)            -0.8691              0.020             0.892              0.088  scott.neal@enron.com,phillip.allen@enron.com
21119   Thu, 5 Oct 2000 09:09:00 -0700 (PDT)  scott.neal@enron.com  ---------------------- Forwarded by Scott Neal...       None  Fwd: FW: Montana Forest Fire picture  phillip.allen@enron.com  (-0.8129, 0.023, 0.889, 0.088)            -0.8129              0.023             0.889              0.088  scott.neal@enron.com,phillip.allen@enron.com
21190  Fri, 28 Jul 2000 05:36:00 -0700 (PDT)  scott.neal@enron.com                        http://www.bondsonline.com/       None                          bond website  phillip.allen@enron.com            (0.0, 0.0, 1.0, 0.0)             0.0000              0.000             1.000              0.000  scott.neal@enron.com,phillip.allen@enron.com
21233   Wed, 4 Apr 2001 03:15:00 -0700 (PDT)  scott.neal@enron.com  ---------------------- Forwarded by Scott Neal...       None                          bear markets  phillip.allen@enron.com   (-0.994, 0.079, 0.793, 0.128)            -0.9940              0.079             0.793              0.128  scott.neal@enron.com,phillip.allen@enron.com

                                        Date                       From                                            Message Message-ID                                          Subject                     To                      Sentiment  CompoundSentiment  PositiveSentiment  NeutralSentiment  NegativeSentiment                                             Pair
27696  Wed, 27 Sep 2000 12:06:00 -0700 (PDT)  sara.shackleton@enron.com  John:  Per our conversation, attached is the c...       None            EOL Duke Deal - commercial resolution  john.arnold@enron.com    (0.6908, 0.049, 0.951, 0.0)             0.6908              0.049             0.951              0.000  sara.shackleton@enron.com,john.arnold@enron.com
27701  Thu, 28 Sep 2000 02:55:00 -0700 (PDT)  sara.shackleton@enron.com  John:  I spoke with  Kevin Meredith this morni...       None  EOL Duke Deal - commercial resolution  FOLLOWUP  john.arnold@enron.com  (-0.483, 0.041, 0.911, 0.048)            -0.4830              0.041             0.911              0.048  sara.shackleton@enron.com,john.arnold@enron.com
27744  Thu, 19 Oct 2000 03:55:00 -0700 (PDT)  sara.shackleton@enron.com  John:  The Duke issue has arisen once again in...       None  EOL Duke Deal - commercial resolution  FOLLOWUP  john.arnold@enron.com  (-0.7176, 0.05, 0.891, 0.059)            -0.7176              0.050             0.891              0.059  sara.shackleton@enron.com,john.arnold@enron.com

                                       Date                     From                                            Message Message-ID                   Subject                       To                      Sentiment  CompoundSentiment  PositiveSentiment  NeutralSentiment  NegativeSentiment                                             Pair
2811  Mon, 13 Dec 1999 08:00:00 -0800 (PST)  michelle.cash@enron.com  Mark,\n\nAs you requested, below is a list of ...       None           Accomplishments  mark.haedicke@enron.com  (0.9704, 0.171, 0.805, 0.024)             0.9704              0.171             0.805              0.024  michelle.cash@enron.com,mark.haedicke@enron.com
2904   Mon, 4 Dec 2000 09:05:00 -0800 (PST)  michelle.cash@enron.com  He and I are meeting this week to discuss oppo...       None  Re: Opportunities at ENA  mark.haedicke@enron.com  (0.9897, 0.138, 0.841, 0.021)             0.9897              0.138             0.841              0.021  michelle.cash@enron.com,mark.haedicke@enron.com
2941   Mon, 4 Dec 2000 15:36:00 -0800 (PST)  michelle.cash@enron.com  Mark,\n\nAs I mentioned in my voice mail, here...       None  Accomplishments for 2000  mark.haedicke@enron.com   (0.9917, 0.129, 0.83, 0.041)             0.9917              0.129             0.830              0.041  michelle.cash@enron.com,mark.haedicke@enron.com
3212   Thu, 7 Dec 2000 14:03:00 -0800 (PST)  michelle.cash@enron.com  Mark, as an update, I am meeting with Carlos t...       None  Re: Opportunities at ENA  mark.haedicke@enron.com  (0.9909, 0.134, 0.846, 0.019)             0.9909              0.134             0.846              0.019  michelle.cash@enron.com,mark.haedicke@enron.com

                                        Date                   From                                            Message Message-ID                        Subject                      To                      Sentiment  CompoundSentiment  PositiveSentiment  NeutralSentiment  NegativeSentiment                                          Pair
26252  Thu, 23 Mar 2000 05:50:00 -0800 (PST)  susan.scott@enron.com  Gerald -- here are a couple of suggested wordi...       None                Re: FERC Issues  gerald.nemec@enron.com  (0.9946, 0.117, 0.854, 0.029)             0.9946              0.117             0.854              0.029  susan.scott@enron.com,gerald.nemec@enron.com
26254  Thu, 23 Mar 2000 05:53:00 -0800 (PST)  susan.scott@enron.com  Also, I would add that another reason we didn'...       None                Re: FERC Issues  gerald.nemec@enron.com   (0.9864, 0.124, 0.85, 0.026)             0.9864              0.124             0.850              0.026  susan.scott@enron.com,gerald.nemec@enron.com
26359  Tue, 12 Sep 2000 01:25:00 -0700 (PDT)  susan.scott@enron.com  I think that ultimately I would feel OK about ...       None  Re: Confidentiality Agreement  gerald.nemec@enron.com  (0.9735, 0.129, 0.802, 0.069)             0.9735              0.129             0.802              0.069  susan.scott@enron.com,gerald.nemec@enron.com
```
What do we learn from this investigation?
* The most negative e-mail exchange seems to be influenced by the sender forwarding multiple e-mail alerts about a forest fire in Montana. * The second most negative exchange alludes to some specific issues related to the "DOL Duke Deal", which is very curious. 
* Meanwhile, the most positive e-mail exchange consists of polite language with subject lines about Accomplishments and Opportunities. 
* The second most positive contains edits about documents and a confidentiality agreement.

Let's say we are most interested in the Duke Deal and the list of Accomplishments. In particular, e-mails with ID's 27701, 27744, 2811, and 2941.

To read the full message texts, pandas will allow us to filter directly for the id of the row within our emailDataFrame, which is listed at the beginning of each line (to the left) with the syntax **emailDataFrame.loc[id]**. We can further specify printing out the entire contents of the Message column by using the syntax **emailDataFrame.loc[id].Message.**

Here is the code, including an excerpt of the output (please run it yourself to find the full outputs -- and be judicious with reading and reposting any identifiable information):

```
locations = [27701, 27744, 2811, 2941]
for location in locations:
    print('Current e-mail with subject line: ' + emailDataFrame.loc[location].Subject)
    print(emailDataFrame.loc[location].Message)
    print("***")
```

*Output (Abridged and Redacted)*

**Current e-mail with subject line: EOL Duke Deal - commercial resolution  FOLLOWUP**
```
John:  I spoke with  Kevin Meredith this morning.

1)  Trade Date was 9/11.  EOL system generated confirm 9/12.  All fax
attempts failed until 9/26 when fax went through.

2)  EOL daily volume excessively heavy (approx. 1400 confirms per day).  Duke
volume extremely heavy as well. All Duke faxing  unsuccessful.

3)  Duke called Kevin and said "haven't received any confirms since 9/14."
Kevin hand faxes all confirms since 9/14.  Duke makes no mention of confirms
prior to 9/14.  Confirm desk runs a "fax failed" report on 9/25 and picks up
the missing confirm.

4)  When Duke receives EOL 415670, John Miller (who seems to be the TRADING
SUPERVISOR) calls Kevin (who signed confirm as agent) several times.  Miller
says that he has spoken with the traders and no one did this deal.  However,
this deal shows up on the "back office user."
...
```

**Current e-mail with subject line: EOL Duke Deal - commercial resolution  FOLLOWUP**
```
John:  The Duke issue has arisen once again in connection with the
settlements group.  Did you ever resolve the issue?
Apparently, two (2) identical trades were executed online on 9/11/00, one at
1:14 pm and the second at 1:28 pm.  Duke agrees wtih the first trade but not
the second.  Please bring me up to date.  Thanks.  Sara
...
```

**Current e-mail with subject line: Accomplishments**
```
Mark,

As you requested, below is a list of my major accomplishments for the year.

1. Resolution/management of pre-litigation and litigation matters,
including:  Dwayne Hart/Utilicorp; Satterwhite; Barrington; Race/Statoil;
Ross Malme; Rick Blandford; West Boettcher; Anita Suson; Charlie Weymms;
Steven Cuneo; others.

2.  Efficient management of drafting, negotiating, revising, and completing
several types of contracts in numerous different jurisdictions (e.g., almost
200 employment agreements, 35 separation agreements, and 30 consulting
services agreements).

3. Lead attorney on Project One (which involves issues surrounding the
OFCCP's "glass ceiling" audit of ENA and all of Enron).

....

Let me know if you need any more information, and thanks for your support!

Michelle
```

**Current e-mail with subject line: Accomplishments for 2000**
```
Mark,

As I mentioned in my voice mail, here is a bullet-point synopsis of my
accomplishments for the second half of 2000.

Transaction Support

Triple Lutz -- provided support for potential divestiture (e.g., data room,
PSA review, direct negotiations with potential buyer, etc.).
Project Crane -- monitored diligence, PSA review/comment, client discussions.
Garden State Paper -- provided employment law advice on closing and
transition issues.
MG Metals -- handled issues surrounding termination of Rudolph Wolff
employees, including separation agreements, negotiations with counsel, etc.
...

Agreements

256 Employment agreements.
 54 Consulting agreements.
104 Separation agreement/releases.
Numerous retention letter agreements.
Drafted new Agreement for Recruiting or Contract Personnel Services (to
replace old Master Service Agreement and Agreement for Project Services) for
use in hiring contract personnel through agencies as well as for use with
recruiting firms (to be rolled out 1/1/01).
Enron Investment Partners Incentive Compensation Plan -- supervised the
drafting and execution of long-term incentive plan for EIP employees.

....

Training

Conducted interview training for Net Works campus recruiting classes.
Provided  training sessions on employment law risks for Energy Operations
management personnel.
Conducted employment law training for ENA Human Resources department.
Conducted sessions on ethics and harassment prevention for New Hire
Orientation approximately once a month.
...

I haven't included what I consider to be routine responsibilities such as
providing advice on employee relations issues, attending off-sites/staff
meetings for Olson/Oxley, attending CLE, etc.  Let me know if you would like
more information about these activities.  If you have any questions, or if
you would like a summary of accomplishments from the first half of the year,
let me know.

Thanks.

Michelle
```
Here is some analysis!


# Where Can We Take Exploratory Data Analysis From Here?

In the sections above, we have explored how the process of writing and implementing code for data analysis can go hand-in-hand with a process of discernment and investigation for a researcher. While our code developed into a longer and more complex application along the way, there is not a single endpoint or outcome with more intrinsic value than the others. Rather, there are a number of hopping-off points where you as a researcher may consider hopping off and switching to other forms of analysis.

At the same time, you may wish to continue exploring this data and applying further analytical techniques, such as graphing possible correlations. Another axis of analysis you may consider is going further into the toolkit of *network analysis*. In particular, the earlier model of nodes and edges, when saved to a .csv file, can form the basis of network generation and calculation of features like betweenness-centrality, community detection, and more.

As one final example, here is a sneak peak of what that might look like to generate a network graph to explore the patterns of communication between individuals and communities (or “neighborhoods”) within an organization:

{% include figure.html filename="https://github.com/programminghistorian/ph-submissions/raw/gh-pages/lessons/enron_network_with_communities.png" caption="Network graph with communities generated with NetworkX" %}


The larger font sizes for individuals indicates their betweenness-centrality in the network, or the degree to which individuals are likely to be linked through them. (Incidentally, that figure also appears to correlate with the likelihood of being charged with a felony in the Enron scandal.)

Though this technique falls outside of the scope of this particular email, you can continue on to the NetworkX lesson on Programming Historian to do just that! You will need a .csv file version of the network data to generate the network graph. To grab this, simply add the following code to our example above to generate a list of edges (one for each email between individuals in a pair) and save it to a csv file:

```
#... adds the following code to the section above


fout3 = open('edges_for_network.csv', 'w')
for pair in sorted_pairs_positive:
        sender, recipient = pair.split(',')
        for x in range (0, network_dict_count[pair]):
                fout3.write('"' + sender + '","' + recipient + '", ' + str(average_sentiment[pair]) + '\n')
fout3.close()
```
To learn the techniques to go from edges and nodes to a complete network graph, continue on to the NetworkX tutorial here (note: add link to PH lesson).

Regardless of where you choose to jump off the exploratory process, hopefully this lesson provides you with a working sense of what types of questions exploratory data analysis can help answer, and how it can support your research process. Computational techniques are exciting and sometimes flashy, but they do not require us to set aside our research questions, our skepticisms, or our critical thought process. We do our best research when we weave methodologies and analytical processes together in pursuit of whatever inspires our curiosity. Hopefully this gives you a roadmap for doing just that with Python, NLTK, and pandas.

# Acknowledgments

My sincere thanks to Justin Joque, Visualization Librarian at the University of Michigan Library and the Digital Project Studio for extensive support throughout the process of writing this tutorial. More information about the Digital Project Studio can be found at https://clarkdatalabs.github.io

# Works Cited

Barton, D., & Hall, N. (Eds.). (2000). Letter writing as a social practice (Vol. 9). John Benjamins Publishing.

Cohen, W. (2015). Enron Email Dataset. Stanford University. Accessed in January 2018 at: http://www.cs.cmu.edu/~enron/

Hardin, J., Sarkis, G., & Urc, P. C. (2014). Network Analysis with the Enron Email Corpus. arXiv preprint arXiv:1410.2759.

Hutto, C.J. & Gilbert, E.E. (2014). VADER: A Parsimonious Rule-based Model for
Sentiment Analysis of Social Media Text. Eighth International Conference on
Weblogs and Social Media (ICWSM-14). Ann Arbor, MI, June 2014.

Klimt, B., & Yang, Y. (2004, July). Introducing the Enron Corpus. In CEAS.

Klimt, B., & Yang, Y. (2004). The enron corpus: A new dataset for email classification research. Machine learning: ECML 2004, 217-226.

Tukey, J.W. (1977). *Exploratory Data Analysis*. Addison-Wesley Publishing Company
