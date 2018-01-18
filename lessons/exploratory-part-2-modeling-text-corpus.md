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
# NOTE: Remember to replace “YOUR PATH” with the folder location where you downloaded the Enron corpus data
path = ‘YOUR PATH/maildir/lavorato-j/sent/'

# Create an empty list. This variable will store a giant list of every email transcript in the Enron corpus -- each email transcript will be represented as a dictionary, so email_list will store a list of dictionary objects (such as [email_dictionary1, email_dictionary2, email_dictionary3...])

email_list = []

# iterate through all raw email text files in the sent folder.
# The bracket notation in Python is called a list comprehension. This generates a list (in this case, a giant list of all filenames) given the rule specified after the “if” statement. In this case, Python receives a directory listing of all items contained within a directory 

for filename in [filename for filename in os.listdir(path) if not filename.startswith('.')]:
    # Create a blank dictionary for each iteration - so one for each email message. We will fill this dictionary with information from our raw text files and append it to the email_list at the end.
        out_dict = {}

    # Now we must open each file to retrieve its contents. Fortunately, we already have the filename in the f variable (representing the specific email we are looping over at the moment). We previously stored the file path, or everything that comes before the filename, in the “path” variable above. Python very conveniently lets us combine these two strings with addition (path+f), and use the “with” syntax to open up the appropriate file (as a read-only or "r" file) and set the variable myfile to point to the file.

        with open(path+filename, "r") as myfile:
      
        # Here’s where the email library helps us. We can call the email.message_from_string() function to convert the raw message data into a dictionary, which makes it easier to process. Note that we need to force Pythonto treat myfile like a single long string of text, so we use the the read() method on myfile to force it to output a string (as opposed to simply passing along the variable myfile).

                msg = email.message_from_string(myfile.read())

        # Now we need to unpack all of the relevant data in our msg variable and place only the most important fields into our out_dict dictionary. In terms of metadata, we’re just going to focus on From, To, Date, and Subject. The full message text requires us to use a special method, in this case get_payload(). Like before, this method ensures that Python treats our data like a string as opposed to another type of data.

                out_dict['From'] = msg['From']
                out_dict['To'] = msg['To']
                out_dict['Date'] = msg['Date']
                out_dict['Subject'] = msg['Subject']
                out_dict['Message'] = msg.get_payload()

        # We’ve successfully packed all of the relevant information for this message into the out_dict variable! But we don’t want all of our hard work to get lost after the loop moves on to the next email text file. We will use the append() method to add our dictionary to the email_list variable.

                email_list.append(out_dict)

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
# NOTE: Remember to replace “YOUR PATH” with the folder location where you downloaded the Enron corpus data
path = ‘YOUR PATH/maildir/lavorato-j/sent/'

# Create an empty list. This variable will store a giant list of every email transcript in the Enron corpus -- each email transcript will be represented as a dictionary, so email_list will store a list of dictionary objects (such as [email_dictionary1, email_dictionary2, email_dictionary3...])

email_list = []

# iterate through all raw email text files in the sent folder.
# The bracket notation in Python is called a list comprehension. This generates a list (in this case, a giant list of all filenames) given the rule specified after the “if” statement. In this case, Python receives a directory listing of all items contained within a directory 

for filename in [filename for filename in os.listdir(path) if not filename.startswith('.')]:
    # Create a blank dictionary for each iteration - so one for each email message. We will fill this dictionary with information from our raw text files and append it to the email_list at the end.
        out_dict = {}

    # Now we must open each file to retrieve its contents. Fortunately, we already have the filename in the f variable (representing the specific email we are looping over at the moment). We previously stored the file path, or everything that comes before the filename, in the “path” variable above. Python very conveniently lets us combine these two strings with addition (path+f), and use the “with” syntax to open up the appropriate file and store it into the variable myfile.

        with open(path+filename, "r") as myfile:
        
        # Here’s where the email library helps us. We can call the email.message_from_string() function to convert the raw message data into a dictionary, which makes it easier to process. Note that we need to force Pythonto treat myfile like a single long string of text, so we use the the read() method on myfile to force it to output a string (as opposed to simply passing along the variable myfile).

                msg = email.message_from_string(myfile.read())

        # Now we need to unpack all of the relevant data in our msg variable and place only the most important fields into our out_dict dictionary. In terms of metadata, we’re just going to focus on From, To, Date, and Subject. The full message text requires us to use a special method, in this case get_payload(). Like before, this method ensures that Python treats our data like a string as opposed to another type of data.

                out_dict['From'] = msg['From']
                out_dict['To'] = msg['To']
                out_dict['Date'] = msg['Date']
                out_dict['Subject'] = msg['Subject']
                out_dict['Message'] = msg.get_payload()

        # We’ve successfully packed all of the relevant information for this message into the out_dict variable! But we don’t want all of our hard work to get lost after the loop moves on to the next email text file. We will use the append() method to add our dictionary to the email_list variable.

                email_list.append(out_dict)

        # After the loop finishes cycling over every file in the corpus, email_list will store a sequence of over 600,000 dictionaries!

# Now we will add the additional steps to convert our data to a DataFrame. 

First, we will create a blank DataFrame. The DataFrame structure is similar to a table, and fields are called “columns” in pandas. When we create our blank DataFrame, we want to also instruct pandas to build columns that match the fields we have singled out in our email dictionaries above.

emailDataFrame = pandas.DataFrame(columns=('Message-ID', 'From', 'To', 'Date', 'Subject', 'Message'))

# Now let’s add the data. One of the best parts of working wiht DataFrames is access to a big collection of powerful methods. In this case, we can simply use the .from_dict() method to convert our list of dictionaries into a single DataFrame -- no extra iteration required.

emailDataFrame = pandas.DataFrame.from_dict(email_list)

# And we’re done. Now we want to visualize our DataFrame a bit. We accomplish this by printing out summaries of our DataFrame data to the console. First, let’s make sure we have the pandas view settings configured to see our full data:

pandas.set_option('display.expand_frame_repr', False)  

# Note that we called this method on pd (our name for the pandas library as a whole), not our DataFrame df. This view setting is a global setting for all python functions.

# Now let’s print out some summaries of our data. The .head() method will print out the top few rows in our DataFrame -- we can specify exactly how many rows by passing in an integer to the method. Let’s try 10.

print(emailDataFrame.head(10))

#If you’d like to play with outputs, try some of these as well
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

Let’s continue our investigation into the 10 most positive and 10 most negative emails that Lavorato has sent off to others. We have already written code that takes in message text as input and outputs a sequence of scores as the output. Recall that in Part 1, we discussed the value of capturing sentence-by-sentence sentiment scores as opposed to a single set of sentiment scores for an entire message. For the purposes of Part 2, we are going to take a hybrid approach: we will calculate sentence-by-sentence sentiment scores and return an average value of positive, negative, neutral, and compound scores across all sentences (refer to Part 1 for the previous discussion of the pros and cons of this approach to scope). This is just one of several ways to approach this problem. 

In order to map our sentiment analysis to the DataFrame, we need to package our code into a single function that can accept the text of the message as an input parameter. We will call this function mapMessageSentiment(). Our mapping function is almost identical to that earlier code, except for how it handles input and output. Input is passed into the function via a single string variable called *message*.

Output is a little more complicated. We have to find a way to pass along the four components of our sentiment analysis results:  *compound*, *positive*, *neutral*, and *negative* outputs generated by the Vader SentimentIntensityAnalyzer() module. We ultimately want to treat each of these scores as independent columns. To do this, we need to break our approach into two steps: (1) calculate a single collection of scores (positive, negative, neutral, compound) in a combined score column, and (2) map each of these scores onto its own separate column. 

mapMessageSentiment() will thus return a single object containing the four sentiment score types. In Python, a *tuple* is a data structure in which multiple items are combined into a single entity, like this: (0.2, -0.8, 1.0, 0.5). When we map our mapMessageSentment() function onto our DataFrame, we will combine the four scores into this single tuple object and store each tuple into a new column called Sentiment.

Once we have completed #1, we can apply a special method to our data to separate or unpack this tuple into four unique columns in our DataFrame: CompoundSentiment, PositiveSentiment, NeutralSentiment, and NegativeSentiment.

Finally, DataFrames supports sorting and filtering much like a table in Excel. We will immediately take advantage of this feature by sorting the entire DataFrame by CompoundSentiment values in descending order. The DataFrame method *sort_values()* takes the name of the column to sort on and a value for ascending. We can then print key information on the five emails with the highest *CompoundSentiment* values using the *head()* method. Then, we can repeat this same approach but with *ascending* set to True to print information about the top five most negative emails.

Below, we define the mapMessageSentiment function (which adds up the score for each sentence and returns the average score across all sentences); map the function to the Message column to generate a single output column Sentiment; map each of the values in the Sentiment column to their own column for CompoundSentiment, PositiveSentiment, NeutralSentiment, and NegativeSentiment; and sorts the DataFrame to print out the 5 most positive and 5 most negative emails in the collection:

```
#...includes the code from the section above, and adds the following

# Here we define the mapMessageSentiment function. Note that the function takes message as a parameter.

def mapMessageSentiment(message):

    # As in the sentence-level analysis in Part 1, we first separate the single message text string into a list of distinct sentences using the tokenizer.tokenize method from the NLTK library
        sentences = tokenizer.tokenize(message)
    

    # This time, we want to calculate the average for each of the four sentiment categories across all sentences. To do this, we add up all of the scores and divide by the number of sentences (i.e. the length of the sentences list we just generated). To start, we initialize variables for each category starting at 0 and store the number of sentences.

        sum_compound, sum_pos, sum_neu, sum_neg = 0, 0, 0, 0
num_sentences = len(sentences)

# Now we will iterate over each sentence in our sentences list

        for sentence in sentences:

        # In each cycle of the for the loop, we run the sid.polarity_scores function on the current sentence and store the output (which is a dictionary) in the ss variable. Then, we increase the running totals of each of the four score categories.
 
                ss = sid.polarity_scores(sentence)
                sum_compound += ss['compound']
                sum_pos += ss['pos']
                sum_neu += ss['neu']
                sum_neg += ss['neg']

    # The function will then return the average of each of the four sentiment score categories, which we calculating by dividing the sum by the number of sentences. If we want to return all four items together in Python, we can simply separate each average by a comma – this will generate a tuple, which we will deal with in the following section.

        return (sum_compound / num_sentences), (sum_pos / num_sentences), (sum_neu / num_sentences), (sum_neg / num_sentences)

# Now that we’ve defined the mapMessageSentiment() function, we want to map it to our DataFrame. Pandas gives us two options for referring to the data in columns: the dictionary-like use of brackets (as in df[‘Sentiment’]) and the class-like use of periods (such as df.Message). Below we mix and match both.

# To generate a new column based on our function, we use the apply() method on the column we wish to input into our function. We can then use the equals sign to assign the output of that function to its target column. pandas will simply generate a new column if it doesn’t recognize the column name (in this case, we haven’t created the Sentiment column previously). The apply() method accepts the name of a function as a parameter -- we don’t even need to use parantheses or specify the input parameter at all! pandas knows that we wish to automatically apply this function to every item in the DataFrame and use the designated column (Message) as input data.

df['Sentiment'] = df.Message.apply(mapMessageSentiment)

# Now we use the apply() method for a slightly different purpose: to take a collection of data that has been packed into a single variable (in this case, the tuple that stores (compound, positive, neutral, negative) scores ) and add each item to its own column. To do this, we must pass in the special pandas method pd.Series. We indicate our target column names by passing in a list of new column names into df[]. (This is a good example of how pandas is sometimes very strange and demanding in its syntax -- you may find yourself Googling questions about pandas often!)

df[['CompoundSentiment', 'PositiveSentiment', 'NeutralSentiment', 'NegativeSentiment']] = df['Sentiment'].apply(pd.Series)

# Now that we’ve generated new columns and filled them with the appropriate sentiment data, we want to see the top positive and top negative results. We can do this in a number of ways. In this example, we will actually create two new ranked lists using the sort_values() method, sorted in descending order, and use the .head() method to print out the first 5 values in each ranked list:

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

Using this technique, we discover a curious set of emails. On the positive end, Lavorato expresses a “strong yes” in one message, gratitude in most, and praises the work of two employees: Bob Schorr and Mark Tawney. On the negative end, Vader Lavorato criticizes mistakes, including unauthorized salary changes by a subordinate, and makes the foreboding statement “The pain will stop soon” in an email with the subject line “Re: 12/13 Loss Notification.”

Vader appears to pick up a couple of false positives in the negative emails. However, the majority of emails (8/10) capture the sentiment of emails as the casual reader would interpret them.

At this point, we have developed a technique for identifying the emotional extremes of emails sent by a particular individual (you can go ahead and replace “lavorato-j” with any of the other 130+ subdirectory names in maildir). For a researcher interested in understanding how specific individuals communicated in the midst of the Enron collapse, this might provide a valuable jumping-off point to conduct a deep dive into those moments of conflict and intensity – or perhaps an investigation into positive, possible collusive relationships!

QUESTIONS: Do you feel this method was successful? Why or why not? What could you imagine doing to improve the error rate of this output? What methods might you imagine being more productive at answering your research questions? 


# From Corpus to Network: Exploring Relationships Within a Community

Note: For this section we will be using the full Enron corpus. This full corpus can be [downloaded online via Stanford here](http://www.cs.cmu.edu/~enron/enron_mail_20150507.tar.gz). Note that for final lesson release, we will store this complete archive or a subset on PH, but for now it would create an issue with Github file size limits. 

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

* Only include relationships that include at least two emails. This excludes one-off email exchanges and ensures there is at least some degree of relationship between these two individuals. (You can play with this condition if you wish, which appears as: “if network_dict_count[pair] > 1”)
* Keep sender and recipient pairs directional, meaning that the emails A sends to B are aggregated separately than the emails B sends to A. Sometimes there is no need to differentiate between the direction of interactions in a relationship. In this case, however, we want to be able to separately consider how an executive communicates with a subordinate and how that same subordinate communicates with the executive -- the styles may be very different.

To start, we need to come up with a method for listing out every possible sender-recipient pair that meets our minimum thresholds above. To do this, we can start by combining the ‘From’ and ‘To’ columns in our email DataFrame into a single ‘Pair’ column (this is very similar to the way we created four Positive/Neutral/Negative/Compound columns from the Sentiment score tuple). We can then iterate through our DataFrame to count up the number of emails that match each To-From pair. 

We want to store the counts for each sender-recipient pair to reference later. A dictionary is a great fit for this task. We can use each pair as the ‘key’ in the dictionary (for example, for emails sent between John Lavorato and Chris Gaskill, the key will be: ‘john.lavorato@enron.com,chris.gaskill@enron.com'’) and the value will be the count of all emails belonging to that pair (such as 10). This will help us make sure later on that we're only dealing with pairs that have at least two emails in all of the Sent folders in the corpus.

In addition to keeping track of how many emails exist for each sender-recipient pair, we also want to keep track of the nature of the relationship -- in our case, that means the sentiment scores of the emails for the sender-recipient pairs. We can create a second dictionary called *network_dict_sentiments* to accumulate the sentiment scores for each pair’s emails. Again, we will use Pair strings ('john.lavorato@enron.com,chris.gaskill@enron.com') as dictionary keys, but this time the value will be a running total of the CompoundSentiment scores in all of the associated emails (such as 4.2). Later on, we can divide the sum of these scores to the number of scores to find the average score! But keep in mind that, if you are interested in a different metric (such as the distribution of scores) you would probably want to store each score in this variable individually, such as in a long list of scores, as opposed to simply storing their sum. However, for us, this will work well.

Now that we have a method for calculating the average sentiment scores for emails, we can create a new dictionary called *average_sentiment* to store those values. Again, our key will be the Pair of To-From email addresses, and the value will be the sum of Compound Sentiment scores divide by the number of Compound Sentiment scores. Here, you can see the value of using that same 'Pair' key name across all of those dictionaries! We can run through every possible Pair and pull values from each dictionary by using that Pair key name.

At this point, we have brought many different features together: calculating sentiment with NLTK; importing our raw email data using the os and email libraries; structuring the raw data as a DataFrame using pandas; and using Python to generate a network representation of sender-pair recipients along with the average sentiment score for each relationship (or “edge”). The code is starting to look complex, but will hopefully give you an idea of how to bring some of these libraries and features together for this exploratory task:

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

# Iterates through all text files in email corpus or a subset of corpus - one text file for each email
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

# here we calculate a new Pair column that combines the 'From' email and 'To' email addresses into a single string, separated by a comma
df['Pair'] = df['From'] + ',' + df['To']

# we also use use the .unique() method to create a list of every possible From address, which we'll use later on to exclude self-emails and other exceptions
senders_list = df.From.unique()

# this dictionary stores the number of emails associated with each To-From Pair
network_dict_count = {}

# and this dictionary stores the sum of the CompoundSentiment values for each of those emails
network_dict_sentiments = {}

# iterate through the DataFrame, count up the # of emails, add up their Compound Sentiment scores
for index, row in df.iterrows():
        if row['Pair'] in network_dict_count:
                network_dict_count[row['Pair']] += 1
                network_dict_sentiments[row['Pair']] += row['CompoundSentiment']
        else:
                network_dict_count[row['Pair']] = 1
                network_dict_sentiments[row['Pair']] = row['CompoundSentiment']

# and this dictionary will store the average CompoundScore in the emails for each pair
average_sentiment = {}

# here we iterate through every To-From pair. Does this pair have more than one email?
# are the senders and recipients two unique indivduals from the sender list?
# if those conditions are met, calculate the average sentiment by dividing sum of sentiments by # of emails

for pair in network_dict_count:
        sender, recipient = pair.split(',')
        if network_dict_count[pair] > 1 and sender != recipient and recipient in senders_list:
                average_sentiment[pair] = network_dict_sentiments[pair]/network_dict_count[pair]

# the sorted() function returns the list of Pairs in descending order by average sentiment.
# the Pair with the most positive average email is first, and the most negative is last.
sorted_pairs = sorted(average_sentiment, key=average_sentiment.get, reverse=True)

# the slice [0:10] lets us focus on the first ten (most positive) emails. we print information about those ten emails
for item in sorted_pairs[0:10]:
        print(item + ': ' + str(average_sentiment[item]) + ' with ' + str(network_dict_count[item]) + ' items')
print()

# and the [-10:] slice returns the last ten (most negative) emails. again we print this information to the console
for item in sorted_pairs[-10:]:
        print(item + ': ' + str(average_sentiment[item]) + ' with ' + str(network_dict_count[item]) + ' items')

# this code snippet saves the average sentiment values for each pair as a comma-separated values (.csv) table
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

Here we’ve been able to identify specific relationships at either extreme of sentiment expressed. Positivity appears more likely to appear in exchanges with just a few emails, whereas the most negative relationships include ones with substantial email back-and-forth. (Note that Lavorato and Shankman appear in several relationships at either extreme.)

Again, we find a jumping-off point for further analysis which may or may not continue to use natural language processing techniques like Sentiment Analysis. You can imagine exploratory data analysis in this instance as providing the justification and framework for subsequent analysis, and doing so in a powerful, computational manner.


# One More Exploratory Step: Correlating Sentiment with Gender

At this point, we’ve been able to learn a fair amount about emotional email exchanges between individuals at Enron. Imagine that as a researcher, you would like to begin turning your attention to trends between the *types* or *qualities* of individuals within the organization, and how those qualities might correlate with the sentiment expressed in emails. 

To accomplish this, we must include a method for associating the individual nodes in the network with properties of interest. A number of studies of the Enron email corpus have included in their pre-processing individual metadata such as professional title, job category within the company (i.e. trader, manager, CEO), gender, and more.

Let’s take on the following research question: How do the genders of the sender and recipient of emails relate to the sentiment expressed in their exchanges?

For the purposes of this tutorial, we followed the methodology of similar studies and generated a dictionary that attempts to correlate every email address with a gender. Please note that this is only an approximation of gender identity based upon first name and, when available, additional publicly accessible documentation. Whenever possible, we included a ‘M’ for man and ‘W’ for woman. In instances where gender was indeterminable, we simply included a ‘?’. This allows us to still proceed with gender analysis while acknowledging the limitations of external/de-facto identifying processes. Note that without specific data where individuals discolose their gender identities, this is only an approximation! We are limited in our ability to identify simply from names nonbinary individuals, or transgender individuals who may have gender identities not legally reflected in their names, and other aspects of gender not easily ascertained by a name alone. (Also note that we use ‘men’ and ‘women’ as opposed to ‘male’ and ‘female’ because we are interested in gender identity rather than biological sex, which is a separate matter.) 

Our pre-generated (and very tentative) dictionary for gender identities is listed below as possible_gender. We recommend that instead of copying this file directly into your Python script, you create a second Python file that you can later import into your main Python script. This Python file will function just like NLTK or pandas, in that it is a *module* from which you can selectively import variables, functions, and other objects. 

To create a module, simply create a new file in the same directory as your other files called *gender_module.py*. Then, create a dictionary by copying and pasting the following text:

```
possible_gender = {'ina.rangel@enron.com': 'W', 'phillip.allen@enron.com': 'M', 'john.arnold@enron.com': 'M', 'harry.arora@enron.com': 'M', 'eric.bass@enron.com': 'M', 'sally.beck@enron.com': 'W', 'patti.thompson@enron.com': 'W', 'gretel.smith@enron.com': 'W', 'robert.benson@enron.com': 'M', 'sandra.brawner@enron.com': 'W', 'rick.buy@enron.com': 'M', 'larry.campbell@enron.com': 'M', 'mike.carson@enron.com': 'M', 'michelle.cash@enron.com': 'W', 'twanda.sweet@enron.com': 'W', 'martin.cuilla@enron.com': 'M', 'jeff.dasovich@enron.com': 'M', 'joseph.alamo@enron.com': 'M', 'dana.davis@enron.com': '?', 'clint.dean@enron.com': 'M', 'david.delainey@enron.com': 'M', 'kay.chapman@enron.com': '?', 'beverly.stephens@enron.com': 'W', 'james.derrick@enron.com': 'M', 'stacy.dickson@enron.com': 'W', 'tom.donohoe@enron.com': 'M', 'chris.dorland@enron.com': '?', 'frank.ermis@enron.com': 'M', 'daren.farmer@enron.com': 'M', 'mary.fischer@enron.com': 'W', 'mark.fisher@enron.com': 'M', 'drew.fossum@enron.com': 'M', 'martha.benner@enron.com': 'W', 'rob.gay@enron.com': 'M', 'randall.gay@enron.com': 'M', 'chris.germany@enron.com': 'M', 'darron.giron@enron.com': '?', 'mike.grigsby@enron.com': 'M', 'mark.haedicke@enron.com': 'M', 'sylvia.sauseda@enron.com': 'W', 'janette.elbertson@enron.com': 'W', 'carol.kincannon@enron.com': 'W', 'rod.hayslett@enron.com': 'M', 'marie.heard@enron.com': 'W', 'judy.hernandez@enron.com': 'W', 'juan.hernandez@enron.com': 'M', 'jeffrey.hodge@enron.com': 'M', 'jenny.helton@enron.com': 'W', 'stanley.horton@enron.com': 'M', 'cindy.stark@enron.com': 'W', 'dan.hyvl@enron.com': 'M', 'tana.jones@enron.com': '?', 'vince.kaminski@enron.com': 'M', 'steven.kean@enron.com': 'M', 'maureen.mcvicker@enron.com': 'W', 'peter.keavey@enron.com': 'M', 'jeff.king@enron.com': 'M', 'tori.kuykendall@enron.com': 'W', 'angela.mcculloch@enron.com': 'W', 'john.lavorato@enron.com': 'M', 'kimberly.hillis@enron.com': '?', 'rosalee.fleming@enron.com': 'W', 'tori.wells@enron.com': 'W', 'kenneth.lay@enron.com': 'M', 'matthew.lenhart@enron.com': 'M', 'andrew.lewis@enron.com': 'M', 'michelle.lokay@enron.com': 'W', 'phillip.love@enron.com': 'M', 'mike.maggi@enron.com': 'M', 'kay.mann@enron.com': 'W', 'larry.may@enron.com': 'M', 'mike.mcconnell@enron.com': 'M', 'cathy.phillips@enron.com': 'W', 'brad.mckay@enron.com': 'M', 'errol.mclaughlin@enron.com': 'M', 'patrice.mims@enron.com': 'W', 'scott.neal@enron.com': 'M', 'kimberly.brown@enron.com': 'W', 'gerald.nemec@enron.com': 'M', 'susan.pereira@enron.com': 'W', 'debra.perlingiere@enron.com': 'W', 'kevin.presto@enron.com': 'M', 'joe.quenet@enron.com': 'M', 'bill.rapp@enron.com': 'M', 'andrea.ring@enron.com': 'W', 'robin.rodrigue@enron.com': '?', 'benjamin.rogers@enron.com': 'M', 'kevin.ruscitti@enron.com': 'M', 'elizabeth.sager@enron.com': 'W', 'brenda.whitehead@enron.com': 'W', 'richard.sanders@enron.com': 'M', 'diana.scholtes@enron.com': 'W', 'susan.scott@enron.com': 'W', 'kaye.ellis@enron.com': 'W', 'sara.shackleton@enron.com': 'W', 'jeffrey.shankman@enron.com': 'M', 'richard.shapiro@enron.com': 'M', 'hunter.shively@enron.com': 'M', 'katherine.brown@enron.com': 'W', 'sherri.sera@enron.com': 'W', 'jeff.skilling@enron.com': 'M', 'sherri.reinartz@enron.com': 'W', 'joannie.williamson@enron.com': 'W', 'matt.smith@enron.com': 'M', 'steven.south@enron.com': 'M', 'carol.clair@enron.com': 'W', 'chris.stokley@enron.com': '?', 'paige.grumulaitis@enron.com': 'W', 'fletcher.sturm@enron.com': 'M', 'tamara.black@enron.com': 'W', 'kate.symes@enron.com': 'W', 'mark.taylor@enron.com': 'M', 'jane.tholt@enron.com': 'W', 'judy.townsend@enron.com': 'W', 'barry.tycholiz@enron.com': 'M', 'v.weldon@enron.com': 'M', 'greg.whalley@enron.com': 'M', 'liz.taylor@enron.com': 'W', "paul.y'barbo@enron.com": 'M'}
```

<div class="alert alert-warning">Triple-clicking allows you to select the entire, very long line of text</div>

Now, returning to your main Python file, add this line to the top of your script to access the contents of possible_gender in your program:

```
from gender_module import possible_gender
```

As with our previous network generation technique, we will again aggregate scores based upon four possible relationships: Women->Women, Women->Men, Men->Women, and Men->Men.

In this script, *pair* references our previously established master list of all possible sender->recipient pairings. We can separate out the pair string into into a sender and a recipient string. Then, because everything matches up nicely, we can use the possible_gender dictionary with each email address to output the gender identity. For example: possible_gender[‘john.lavorato@enron.com’] should return the output ‘M’. We also accomodate for ambiguous gender identities by having those individuals stored as ‘?’ in possible_gender, and the script will ignore any pair in which an email address returns a ‘?’ gender.

Note that this script also uses a couple of Python keywords you may not have seen before: *try* and *except*. The try-except pattern is a powerful tool that allows your program to continue functioning even when it encounters a program-breaking error. Python will attempt to execute the code within the *try* block; if, for whatever reason, it cannot con


 The if-then logic is written in such a way that no action will be taken if either of the keys return a ‘?’

Note that the if-then loops are wrapped within a try:/except: pattern. If Python attempts to access a key that doesn’t exist, it will result in a KeyError exception will stop the program. While the *.get* method provides a safe alternative for handling keys that may or may not exist within a dictionary (for instance, possible_gender.get(‘lalala’) would return None), the try/except loop has the benefit of notifying us in the console if a problem occurs, which we may want to investigate later.


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
The exploratory analysis appears to point us to a substantial difference between sentiment across genders. Women communicating with other women express, on average, a 50% higher sentiment score than men, whereas communication between individuals of the two genders hover somewhere in between.

This finding is promising, but it's important to note it does not itself provide evidence of a statistically significant difference. We've made no attempt to calculate confidence intervals or conceptualize the data within a statistical model. Instead, the exploratory analysis provides exactly the kind of detective's clue that Tukey (1977) argues should compel us to pursue with confirmatory analysis. This might look like an attempt to demonstrate a statistically significant correlation between genders of correspondents and sentiment score, or perhaps a close reading textual analysis of a subset of emails, or even an qualitative study of workplace culture at Enron during the crisis years.

We also might be compelled to shape and further refine our researcher questions via subsequent exploratory analysis. How might those changes in sentiment by gender further change over the course of Enron’s collapse? How about when communication is with a superior, a subordinate, or a peer within the corporate hierarchy? What about exploring correlations for entirely different characteristics of individuals? The possibilities may not be infinite, but they are certainly vast.


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
for pair in sorted_pairs:
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
