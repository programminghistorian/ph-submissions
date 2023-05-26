---
title: "Corpus Analysis with SpaCy"
slug: corpus-analysis-with-spacy
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Megan S. Kane
reviewers:
- Maria Antoniak
- William Mattingly
editors:
- John R. Ladd
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/546
difficulty: TBC
activity: TBC
topics: [TBC, TBC]
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---


{% include toc.html %}


# Introduction
Say you have a big collection of texts. Maybe you've gathered speeches from the French Revolution, or compiled a bunch of Amazon product reviews, or unearthed a collection of diary entries written during the first world war. In any case, computational analysis *seems* like a good move to compliment close reading of your corpus...but where should you start? 

One possible place to begin is with [spaCy](https://spacy.io/), an industrial-strength library for natural language processing in Python. spaCy is capable of processing large corpora, generating linguistic annotations like part-of-speech tags and named entities, and preparing texts for further machine classification. This lesson is a "spaCy 101" of sorts, a primer for researchers who are new to spaCy and want to learn how it can be used for corpus analysis. It may also be useful for anyone who is curious about natural language processing tools in general and how they can help answer humanities research questions. 

## Tutorial Goals
By the end of this tutorial, you will be able to: 
*   Upload a corpus of texts to a platform for Python analysis (Google Colab or Jupyter Notebook)
*   Use spaCy to enrich the corpus through tokenization, lemmatization, part-of-speech tagging, dependency parsing and chunking, and named entity recognition
*   Conduct frequency analyses using part-of-speech tags and named entities 
*   Download an enriched dataset for use in future NLP/analyses

## Why Use SpaCy for Corpus Analysis?
As the name implies, corpus analysis involves studying corpora, or large collections of documents. Typically, the documents in a corpus are representative of some group(s) a researcher is interested in studying, like the writings of a specific author or genre. By analyzing these texts at scale, researchers can identify meaningful trends in the way language is used within the target group(s). 
 
Though computational tools like spaCy can't read and comprehend the meaning of texts like humans do, they excel at "parsing" and "tagging" them. When researchers give spaCy a corpus, spaCy will "parse" the corpus and identify the grammatical categories each word and phrase in each text most likely belongs to. It can then use this information to generate lexico-grammatical tags that are of interest to researchers, such as lemmas (base words), part-of-speech tags and named entities (more on these below). What's more, computational tools perform these parsing and tagging processes much more quickly (in a matter of seconds or minutes) and on much larger corpora (hundreds, thousands, or even millions of texts) than human readers would be able to.

Though spaCy was designed for production use, researchers also find it valuable for several reasons: 
*   It's [easy to set up and call the NLP pipeline](https://www.thedataincubator.com/blog/2016/04/27/nltk-vs-spacy-natural-language-processing-in-python/); no need to call a wide range of packages and functions for each individual task
*   It uses [fast and accurate algorithms](https://medium.com/@akankshamalhotra24/introduction-to-libraries-of-nlp-in-python-nltk-vs-spacy-42d7b2f128f2) for text-processing tasks, so it's efficient to run and kept up-to-date by the developers 
*   It [performs better on text-splitting tasks than NLTK](https://proxet.com/blog/spacy-vs-nltk-natural-language-processing-nlp-python-libraries/), since it constructs syntactic trees for each sentence it is called on

You may still be wondering: What is the value of extracting language data like lemmas, part-of-speech tags, and named entities from a corpus? How can they help researchers answer meaningful humanities research questions? To illustrate, let's look at the example corpus and questions developed for this tutorial.

## Lesson Dataset: Biology and English Papers from the Michigan Corpus of Upper-Level Student Papers (MICUSP)
The [Michigan Corpus of Upper-Level Student Papers (MICUSP)](https://elicorpora.info/main) is a corpus of 829 high-scoring academic writing samples from students at the University of Michigan. The papers come from 16 disciplines and seven genres; all were written by senior undergraduate or graduate students and received an A-range score in a university course. [^1] The papers and their metadata are publicly available on MICUSP Simple, an online interface which allows users to search for papers by a range of fields (e.g. genre, discipline, student level, textual features) and conduct simple keyword analyses across disciplines and genres. 

{% include figure.html filename="or-en-corpus-analysis-with-spacy-01.png" alt="MICUSP Simple Interface web page, displaying list of papers included in MICUSP, distribution of papers across disiplines and paper types, and options to sort papers by student levels, nativeness, textual features, paper types, and disciplines" caption="Figure 1: MICUSP Simple Interface" %}

Metadata from the corpus is available to download in csv form. The text files can be retrieved via webscraping, a process explained further in [Jeri Wieringa's Intro to BeautifulSoup Tutorial](/en/lessons/retired/intro-to-beautiful-soup), which has been retired because the underlying website has changed, but is still methodologically useful.

Given its size and robust metadata, MICUSP has become a valuable tool for researchers seeking to study student writing computationally. Notably, Jack Hardy and Ute Römer [^2] use MICUSP to study language features that indicate how student writing differs across disciplines, Laura Aull [^3] compares usages of stance markers across student genres, and Sugene Kim [^4] highlights discrepancies between prescriptive grammar rules and actual language use in student work. Like much corpus anaylysis research, these studies are predicated on the fact that computational analysis of language patterns—the discrete lexico-grammatical practices students employ in their writing—can yield insights into larger questions about academic writing. Given its value in discovering linguistic annotations, spaCy is well-poised to conduct this type of analysis using MICUSP.

This tutorial will explore a subset of documents from MICUSP: 67 Biology papers and 98 English papers. Papers in this select corpus belong to all seven MICUSP genres: Argumentative Essay, Creative Writing, Critique/Evaluation, Proposal, Report, Research Paper, and Response Paper. This select corpus and the associated metadata csv are available to download as part of the tutorial's [lesson materials](https://github.com/mkane968/Corpus-Analysis-with-SpaCy/tree/main/lesson-materials). It has been culled from the larger corpus in order to investigate the differences between two distinct disciplines of academic writing (Biology and English). It is also a manageable size for the purposes of this tutorial. 

* **Quick note on corpus size and processing speed:** spaCy is able to process jobs of up to 1 million characters, so it can be used to process the full MICUSP corpus, or other corpora containing hundreds or thousands of texts.  You are more than welcome to retrieve the entire MICUSP corpus with [this webscraping code](https://github.com/mkane968/webscraping_micusp/blob/main/MICUSP_Webscraping_11-22.ipynb) and using that dataset for the analysis. However, if your computer has more limited processing power or memory, or if you choose to use the Google Colab version of this tutorial, you may encounter lags in runtime or run out of memory when your code is trying to process larger corpora. 

This tutorial will describe how spaCy's utilities in **stopword removal,** **tokenization,** and **lemmatization** can assist in (and hinder) the preparation of student papers for analysis. It will also demonstrate how spaCy's ability to extract linguistic annotations like **part-of-speech tags** and **named entities** can be used to compare conventions within subsets of a discourse community of interest. The focus will be on lexico-grammatical features that may indicate genre and disciplinary differences in academic writing. The following research questions will be investigated:

**RQ1: Do students use certain parts of speech more frequently in Biology papers versus English papers that signify differences in disciplinary conventions?** 
- Prior research has shown that even when writing in the same genres, writers in the sciences follow different conventions than those in the humanities. Notably, academic writing in the sciences has been characterized as informational, descriptive, and procedural, while that in the humanities is narrativized, evaluative, and situation-dependent (i.e. focused on discussing a particular text or prompt).[^5] By deploying spaCy on the MICUSP texts, researchers can determine whether there are any significant differences between the part-of-speech tag frequencies in English and Biology papers. For example, we might expect students writing Biology papers to use more adjectives than those in the humanities, given their focus on description. Conversely, we might suspect English papers contain more verbs and verb auxiliaries, indicating a more narrative structure. We'll analyze part-of-speech counts generated by spaCy to test these hypotheses as well as explore other part-of-speech count differences that could prompt further investigation. 

**RQ2: Do students use certain named entities more frequently in different academic genres that signify differences in genre conventions?** 
- As with disciplines, research has shown that different genres of writing have their own conventions and expectations. For example, explanatory genres like research papers, proposals and reports tend to focus on description and explanation, whereas argumentative and critique-driven papers are driven by evaluations and arguments. [^6] By deploying spaCy on the MICUSP texts, researchers can determine whether there are any significant differences between the named entity frequencies in papers within the seven different genres represented (Argumentative Essay, Creative Writing, Critique/Evaluation, Proposal, Report, Research Paper, and Response Paper). We may suspect that argumentative genres engage more with people or works of art, since these could be entities serving to support their arguments or as the subject of their critiques. Conversely, perhaps dates and numbers are more prevalent in evidence-heavy genres, like research papers and proposals. We'll analyze the nouns and noun phrases spaCy has tagged as "named entities" to test these hypotheses. 

Finally, this tutorial will address how a dataset enriched by spaCy can be exported in a usable format for further machine learning tasks like [sentiment analysis](/en/lessons/sentiment-analysis#calculate-sentiment-for-a-paragraph) or [topic modeling](/en/lessons/topic-modeling-and-mallet).

## Before You Begin
You should have some familiarity with Python or a similar coding platform. For a brief introduction or refresher, work through some of the *Programming Historian's* [introductory Python tutorials](/en/lessons/introduction-and-installation). You should also have basic knowledge of spreadsheet (.csv) files, as this tutorial will primarily use data in a similar format called a [pandas](https://pandas.pydata.org/) DataFrame. [This lesson on data normalization](/en/lessons/crowdsourced-data-normalization-with-pandas) provides an overview to creating and manipulating datasets using pandas. 

Two versions of code are provided for this tutorial: one version to be run on Jupyter Notebook and one for Google Colaboratory. The versions are the same except when it comes to the process of retrieving and downloading files. Because a Jupyter Notebook is hosted locally, the files stored on your computer can be accessed directly. Google Colab, on the other hand, is cloud-based, and requires files to be uploaded to the Colab environment. This tutorial will note such divergences below and first explain the code for working with Jupyter Notebook, then for Google Colab. More details and setup instructions for each platform are as follows: 
*  **Jupyter Notebook** is an environment through which you can run Python on your local machine. Since it's local, it works offline, and you can set up dedicated environments for your projects in which you'll only need to install packages once. If you've used Python before, you likely already have Jupyter Notebook installed on your machine. [This tutorial](/en/lessons/jupyter-notebooks) covers the basics of setting up Jupyter Notebook using Anaconda.

*  **Google Colaboratory** is a Google platform which allows you to run Python in a web browser. Access is free with a Google account and nothing needs to be installed to your local machine. If you're new to coding, aren't working with sensitive data, and aren't running processes with [slow runtime](https://www.techrepublic.com/article/google-colab-vs-jupyter-notebook/), Google Colab may be the best option for you. [Here's a brief Colab tutorial from Google.](https://colab.research.google.com/)

It is also recommended, though not required, that you have some background in methods of computational text mining. [This PH lesson on corpus analysis with AntConc](/en/lessons/corpus-analysis-with-antconc) shares tips for working with plain text files and outlines possibilities for exploring keywords and collocates in a corpora (though using a different tool). [This PH lesson on counting frequencis](/en/lessons/counting-frequencies) describes the process of counting word frequencies, a practice this tutorial will adapt to count part of speech and named entity tags. 

No prior knowledge of spaCy is required. For a quick overview, go to the [spaCy 101 page](https://spacy.io/usage/spacy-101) from the library's developers.

# Install and Import Packages 
## Installation and Imports in Jupyter Notebook
The first time you work with spaCy and related packages, you should install them in your local environment using pip, conda, or another environment management tool. Similarly, you'll need to download the English language model needed for the NLP pipeline. 
```
# Install and import spacy
!pip install spaCy

# Install English language model
!spacy download en_core_web_sm
```
Once you have completed this installation, you will not need to repeat it as long as you continue working in the same environment. From here, import spaCy and other packages necessary for this tutorial.
```
# Install and import spacy
import spacy

# Load the natural language processing pipeline
# We'll choose eng_core_web_sm, the small English pipeline which has been tagged on written web texts
nlp = spacy.load("en_core_web_sm")

# Load spaCy visualizer
from spacy import displacy

# Import os to upload documents and metadata
import os

# Import pandas DataFrame packages
import pandas as pd

# Import graphing package
import plotly.graph_objects as go
import plotly.express as px
```

## Installation and Imports in Google Colab
spaCy is permanently pre-installed in Google Colab, so you do not need to run ```!pip install``` prior to importing. 

Run the following cell to import spaCy and other packages necessary for this tutorial.
```
# Install and import spacy
import spacy

# Load the natural language processing pipeline
# We'll choose eng_core_web_sm, the small English pipeline which has been tagged on written web texts
nlp = spacy.load("en_core_web_sm")

# Load spaCy visualizer
from spacy import displacy

# Import files to upload documents and metadata
import files

# Import pandas DataFrame packages
import pandas as pd

# Import graphing package
import plotly.graph_objects as go
import plotly.express as px
```

# Load Files into DataFrame
After all necessary packages have been imported, it is time to upload the data for analysis with spaCy. As above, the process differs slightly between Jupyter Notebook and Google Colab. 

## Upload Files to Jupyter Notebook
To upload the student papers and metadata for analysis, you will first need to downloaded all the files to a folder your local machine. Then, run the code below to create a for loop which looks in the folder where the student papers are saved, finds all .txt files, and appends them and their file names to two separate lists. You will need to substitute "path_to_directory" with the actual path to the folder where your text files are stored.
```
# Create empty lists for file names and contents
texts = []
file_names = []
# Iterate through each file in the path
for _file_name in os.listdir('path_to_directory'):
# Look for only text files
    if _file_name.endswith('.txt'):
    # Append contents of each text file to text list
        texts.append(open(path_to_directory + '/' + _file_name, 'r').read()
        # Append name of each file to file name list
        file_names.append(_file_name) 
```
Transform the two lists into a dictionary, where each file name is associated with its body of text.
```
d = {'Filename':filenames,'Text':data}
```
From here, turn the dictionary into a pandas DataFrame. This step will organize the texts into a table of rows and columns–in this case, the first column will contain the names of the files, and the second column will contain the content of each file 
```
# Turn dictionary into a dataframe
paper_df = pd.DataFrame(d)
paper_df.head()
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-02.png" alt="First five rows of student paper DataFrame, including columns for the title of each paper and the text of each paper." caption="Figure 2: Initial DataFrame with filenames and texts in Jupyter Notebook" %}

The beginning of some papers may contain extra spaces (indicated by \t or \n). These characters can be replaced by a single space using the ```str.replace()``` method.
```
#Remove extra spaces from papers
paper_df['Text'] = paper_df['Text'].str.replace('\s+', ' ', regex=True).str.strip()
```
Next we will retrieve the metadata of interest: the discipline and genre information connected to the MICUSP papers. Later in this tutorial, we will use spaCy to trace differences across genre and disciplinary categories later. Run the following code to locate the csv file (specify the path to the folder where the metadata files are stored) and use it to create a Pandas dataframe.
```
paper_df = pd.read_csv('path_to_directory')
```
Display the first five rows to check that the data is as expected.  Four columns should be present: the paper IDs, their titles, their discipline, and their type.

{% include figure.html filename="or-en-corpus-analysis-with-spacy-03.png" alt="First five rows of student paper metadata DataFrame, including columns for paper ID, title, discipline, and paper type." caption="Figure 3: Head of DataFrame with paper metadata-ID, title, discpline and type in Jupyter Notebook" %}

The process to add the metadata into the same dataframe as the file contents is the same for both Jupyter Notebook and Google Colab users. Jump to the following section to continue the tutorial from this point.

## Upload Files to Google Colaboratory
To upload the student papers and metadata for analysis, you will need to have downloaded these files to a folder on your computer. Then, run the code below. 
```
# Selet multiple files to upload from local folder
uploaded_files = files.upload()
```
Once you run the cell, a button will appear directing you to “Choose Files."

{% include figure.html filename="or-en-corpus-analysis-with-spacy-04.png" alt="Google Colab notebook cell to be run to upload files." caption="Figure 4: Choose local files to upload to Google Colaboratory" %}

Click the button and a file explorer box will pop up. From here, navigate to the folder on your computer where you have stored the papers (.txt files), select all the files of interest, and click “Open.” 

The files are now uploaded to your Google Colab session. You can see the uploaded files as output of the cell above and can access the files by clicking the file icon on the left-hand sidebar of the Colab notebook.

{% include figure.html filename="or-en-corpus-analysis-with-spacy-05.png" alt="Google Colab notebook cell to be run to upload files, displaying uploaded files as output of the cell and on Google Drive folder in left-hand sidebar." caption="Figure 5: Files uploaded and saved to Google Drive" %}

Now we have files upon which we can perform analysis. To check what form of data we are working with, you can use the type() function. It should return that your files are contained in a dictionary, where keys are the file names and values are the content of each file. 

Next, we’ll make the data easier to manage by inserting it into a Pandas DataFrame. Since the files are currently stored in a dictionary, use the DataFrame.from_dict() function to append them to a new DataFrame.
```
# Add files into DataFrame
paper_df = pd.DataFrame.from_dict(uploaded_files, orient='index')
paper_df.head()
```
Use the ```.head()``` function to call the first five rows of the DataFrame and check that the file names and text are present. You will also notice some strange characters at the start of each row of text; these are related to the encoding and will be removed below. 

{% include figure.html filename="or-en-corpus-analysis-with-spacy-06.png" alt="First five rows of student paper DataFrame, including columns for the title of each paper and the text of each paper, without column header names and with byte string characters (b' or b") at start of each line." caption="Figure 6: Initial DataFrame with filenames and texts in Colab" %}

From here, you can reset the index (the very first column of the DataFrame) so it is a true index, rather than the list of file names. The file names will become the first column and the texts become the second, and this will make data wrangling easier later. 
```
# Reset index and add column names to make wrangling easier
paper_df = paper_df.reset_index()
paper_df.columns = ["Filename", "Text"]
```
Check the head of the DataFrame again to confirm this process has worked.

{% include figure.html filename="or-en-corpus-analysis-with-spacy-07.png" alt="First five rows of student paper DataFrame, including columns for the title of each paper and the text of each paper, with column header names "Filename" and "Text" added." caption="Figure 7: Reindexed DataFrame with filenames and texts in Colab" %}

Notice that each row starts with b' or b". This indicates that the data has been read as "byte strings," or strings which represent as sequence of bytes. 'b"Hello", for example, corresponds to the sequence of bytes [104, 101, 108, 108, 111]. To analyze the texts with spaCy, we need them to be Unicode strings, where the characters are individual letters. 

Converting from bytes to strings is a quick task using ```str.decode()``. Within the parentheses, we specify the encoding parameter, UTF-8 (Unicode Transformation Format - 8 bits) which guides the transformation from bytes to Unicode strings. For a more thorough breakdown of encoding in Python, [check out this tutorial](https://realpython.com/python-encodings-guide/#whats-a-character-encoding).
```
paper_df['Text'] = paper_df['Text'].str.decode('utf-8')
paper_df.head()
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-08.png" alt="First five rows of student paper DataFrame, including columns for the title of each paper and the text of each paper, with byte string characters removed." caption="Figure 8: Decoded DataFrame with filenames and texts in Colab" %}

The beginning of some papers may also contain extra spaces (indicated by \t or \n). These characters can be replaced by a single space using the ```str.replace()``` method.
```
# Remove extra spaces from papers
paper_df['Text'] = paper_df['Text'].str.replace('\s+', ' ', regex=True).str.strip()
```
Next we will retrieve the metadata of interest: the discipline and genre information connected to the MICUSP papers. Later in this tutorial, we will use spaCy to trace differences across genre and disciplinary categories later.  When the cell is run, click "choose files", navigate to where you have stored the metadata.csv file, and select this file to upload.
```
# Upload csv with paper metadata
metadata = files.upload()
```
We'll first convert the uploaded csv file to a second DataFrame, drop any empty columns and display the first five rows to check that the data is as expected. Four rows should be present: the paper IDs, their titles, their discipline, and their type.

{% include figure.html filename="or-en-corpus-analysis-with-spacy-09.png" alt="First five rows of student paper metadata DataFrame, including columns for paper ID, title, discipline, and paper type." caption="Figure 9: Colab DataFrame with paper metadata-ID, title, discpline and type" %}

At this point, we have uploaded all files we need for analysis, and the code is the same for Google Colab and Jupyter Notebook users moving forward. 

## Merge DataFrames with Paper Files and Metadata
Notice that the paper ids in this DataFrame are *almost* the same as the paper file names. We're going to make them match exactly so we can merge the two DataFrames together on this column; in effect, linking each text with their title, discipline and genre. 

To match the columns, we'll remove the ".txt" tag from the end of each filename in the paper DataFrame using a simple ```str.replace``` function. This function searches for every instance of the phrase ".txt" in the filename column and replaces it with nothing (in effect, removing it). In the metadata DataFrame, we'll rename the paper id column "Filename."
```
# Remove .txt from title of each paper
paper_df['Filename'] = paper_df['Filename'].str.replace('.txt', '')

# Rename column from paper ID to Title
metadata_df.rename(columns={"PAPER ID": "Filename"}, inplace=True)
```
Now it is possible to combine the papers and metadata into a single DataFrame using the DataFrame "merge" command. 
```
# Merge metadata and papers into new DataFrame
# Will only keep rows where both paper and metadata are present
final_paper_df = metadata_df.merge(paper_df,on='Filename')
```
Check the first five rows to make sure each has a filename, title, discipline, paper type and text (the full paper). At this point, you'll also see that any extra spaces have been removed from the beginning of the papers.

{% include figure.html filename="or-en-corpus-analysis-with-spacy-10.png" alt="First five rows of DataFrame merged to include student papers and metadata, with columns for filename, title, discipline, paper type, and text." caption="Figure 10: DataFrame with files and metadata" %}

The resulting DataFrame is now ready for analysis. 

# A Note About Preprocessing Tasks
If you've done any computational analysis before, you're likely familiar with the term "cleaning," which covers a range of procedures such as lowercasing, punctuation removal, and stopword removal. Such procedures are meant to standardize data and make it easier for computational tools to interpret it. In both versions of the code above, we replaced extra spaces with single spaces, and in the Google Colab version, we also converted the uploaded files from byte strings to Unicode strings so spaCy can process them.

However, it is not necessary to perform most other cleaning procedures before running spaCy, and some will in fact skew your results. For example, punctuation markers help spaCy parse grammatical structures and generate part-of-speech tags and dependency trees. Similarly, some recent scholarship [^8] shows that removing stopwords only superficially improve tasks like topic modeling and that stopwords can support clustering and classification. Stopword removal will be run *after* we get results from spaCy so we can further compare its impacts.

# Text Enrichment with spaCy
To use spaCy, first load the natural language processing pipeline which will be used to perform tokenization, part-of-speech tagging, and other text enrichment tasks. A wide range of pretrained pipelines are available ([see the full list here](https://spacy.io/models)), and they vary based on size and language. We'll use ```en_core_web_sm```, the small English pipeline which has been tagged on written web texts. This model may not perform as accurately as the medium and large English models, but it will deliver results most efficiently.  Once we've loaded the pipeline, we can check what functions it performs; "parser", "tagger", "lemmatizer", and "ner", should be among those listed.
```
# Load nlp pipeline
nlp = spacy.load('en_core_web_sm')

# Check what functions it performs
print(nlp.pipe_names)
```
Now that the model is loaded, let's test out spaCy's capacities on a single sentence. When the nlp model is called on the sentence, the output is a "doc" object. This object stores not only the original text, but also all of the results obtained when the spaCy model processed the text.
```
# Define example sentence
sentence = "This is 'an' example? sentence"

# Call the nlp model on the sentence
doc = nlp(sentence)
```
Next we can call on the doc object to get the information we're interested in. The command below prints each word in the text along with its corresponding part of speech. 
```
# Loop through each token in doc object
for token in doc:
  # Print text and part of speech for each
    print(token.text, token.pos_)
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-11.png" alt="Output from command to print each word in the sentence, "This is ' an example ? sentence" along with their corresponding part of speech tags PRON, AUX, PUNCT, DET, PUNCT, NOUN, PUNCT, NOUN." caption="Figure 11: Example output of text and parts of speech generated by spaCy" %}

Let's try the same process on the student papers. Since we'll be calling the nlp pipeline on every paper in the DataFrame, we should first define a function that runs the pipeline on whatever input text is given. Functions are a useful way to store operations that will be run multiple times, reducing duplications and improving code readability. 
```
# Define a function that runs the nlp pipeline on any given input text
def process_text(text):
    return nlp(text)
```
After the function is defined, use ```.apply()``` to apply it to every cell in a given DataFrame column. In this case, the nlp pipeline will run on each cell in the "Text" column of the ```final_paper_df``` DataFrame, creating a doc object out of every student paper. These doc objects will be stored in a new column of the DataFrame called "Doc."

Running the nlp pipeline code on each paper takes several minutes to run because spaCy is performing all the parsing and tagging tasks on each text. However, once it is complete, we can simply call on the resulting doc objects to get parts of speech, named entities, and other information of interest, just as in the example of the sentence above. 
```
# Apply the function to the "Text" column, so that the nlp pipeline is called on each student paper
final_paper_df['Doc'] = final_paper_df['Text'].apply(process_text)
```

## Tokenization
A critical first step performed by spaCy's nlp pipeline is tokenization, or the segmentation of strings into individual words and punctuation markers. Tokenization enables spaCy to parse the grammatical structures of a text and identify characteristics of each word like part of speech. To retrieve a tokenized version of each text in the DataFrame, we'll write a function that iterates through any given doc object and returns all functions in that doc object. This can be accomplished by simply putting a "define" wrapper around a for loop, similar to the one written above to retrieve the tokens and parts of speech from a single sentence.
```
# Define a function to retrieve tokens from a doc object
def get_token(doc):
    # Loop through each token in the doc object
    for token in doc:
        # Retrieve the text of each token
        return token.text
```
However, there's a way to write the same function that makes the code more readable and efficient. This is called "list comprehension," and it involves condensing the for loop into a single line of code and returning a list of tokens within each text it processes: 
```
# Define a function to retrieve tokens from a doc object
def get_token(doc):
    return [(token.text) for token in doc]
```
As with the function used to create doc objecs, the token function can be applied to the DataFrame. In this case, we will call the function on the "Doc" column, since this is the column which stores the results from the processing done by spaCy's nlp pipeline. 
```
# Run the token retrieval function on the doc objects in the dataframe
final_paper_df['Tokens'] = final_paper_df['Doc'].apply(get_token)
```
If we compare the ['Text'] and ['Tokens'] column, we find a couple differences. Most importantly, the words, spaces, and punctuation markers in the Tokens column are separated by commas, indicating that each have been parsed as individual tokens. The text in the "Tokens" column is also bracketed; this indicates that tokens have been generated as a list. We'll discuss how and when to transform the lists to strings to conduct frequency counts below.

{% include figure.html filename="or-en-corpus-analysis-with-spacy-12.png" alt="First and last five rows of DataFrame with columns for plain text and tokenized versions of each paper." caption="Figure 12: Comparison of text and spaCy-generated token columns in DataFrame of student papers" %}

## Lemmatization
Another process performed by spaCy's nlp pipeline is lemmatization, or the retrieval of the dictionary root word of each word (e.g. “brighten” for “brightening”). We'll perform a similar set of steps to those above to create a function to call the lemmas from the doc object, then apply it to the DataFrame.
```
# Define a function to retrieve lemmas from a doc object
def get_lemma(doc):
    return [(token.lemma_) for token in doc]

# Run the lemma retrieval function on the doc objects in the dataframe
final_paper_df['Lemmas'] = final_paper_df['Doc'].apply(get_lemma)
```
Lemmatization can help reduce noise and refine results for researchers who are conducting keyword searches. For example, let’s compare counts of the word “write” in the original token column and in the lemmatized column.
```
print(f'"Write" appears in the text tokens column ' + str(final_paper_df['Tokens'].apply(lambda x: x.count('write')).sum()) + ' times.')
print(f'"Write" appears in the lemmas column ' + str(final_paper_df['Lemmas'].apply(lambda x: x.count('write')).sum()) + ' times.')
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-13.png" alt="Output of command to print number of times the word "write" appears in the tokens column (40 times) and the lemmas columns (302 times)." caption="Figure 13: Frequency count of 'write' in token and lemma columns" %}

As expected, there are more instances of "write" in the lemmas column, as the lemmatization process has grouped inflected word forms (writing, writer) into the base word "write." Lemmatization can help reduce noise and refine results for researchers who are conducting keyword searches. It's also often used as a preliminary step for dimensionality reduction. For example, in his 2020 *Cultural Analytics* article, Matthew Lavin [^9] studies lemma frequencies that are predictive of the perceived genders of authors reviewed by the New York Times. View the Programming Historian tutorial that is based on his article [here](/en/lessons/linear-regression).

## Part of Speech Tagging
spaCy also performs part-of-speech tagging. The pipeline facilitates two levels of part of speech tagging: coarse-grained tagging, which predicts the simple [universal part of speech](https://universaldependencies.org/u/pos/) of each token in a text (e.g. noun, verb, adjective, adverb), and detailed tagging, which uses a larger, more fine-grained set of part of speech tags (e.g. 3rd person singular present verb). The part of speech tags used are determined by the model we use for the nlp pipeline. Explore the differences between the models on [spaCy's website](https://spacy.io/models/en). 

We can call the part-of-speech tags in the same way as the lemmas. Create a function to extract them from any given doc object and apply the function to each doc object in the dataframe. The functionw we'll create will extract both the coarse- and fine-grained part of speech for each token (```token.pos_``` and ```token.tag_```, respectively).
```
# Define a function to retrieve lemmas from a doc object
def get_pos(doc):
    #Return the coarse- and fine-grained part of speech text for each token in the doc
    return [(token.pos_, token.tag_) for token in doc]

# Define a function to retrieve parts of speech from a doc object
final_paper_df['POS'] = final_paper_df['Doc'].apply(get_pos)
```
We can create a list of the part of speech columns to review them further. The first (coarse-grained) tag corresponds to a generaly recognizable part of speeech like a noun, adjective, or punctuation mark, whlie the second (fine-grained) category are a bit more difficult to decipher.
```
#Create a list of part of speech tags
list(final_paper_df['POS'])
```
{% include figure.html filename="or-en-corpus-analysis-with-spacy-14.png" alt="List of coarse and fine-grained part of speech tags appearing in student papers, including "PROPN, NNP" and "NUM, CD" among other pairs of coarse and fine-grained terms." caption="Figure 14: Excerpt from list of parts of speech in student papers" %}

Fortunately, spacy has a built-in function called "explain" that can provide a short description of any tag of interest. If we try it on the tag "IN" using ```spacy.explain("IN") ```, the output reads "'conjunction, subordinating or preposition.'"

In some cases, you may want to get only a set of Part of Speech tags for further analysis, like all of the proper nouns. A function can be written to perform this task, extracting only words which have been fitted with the proper noun tag.
```
# Define function to extract proper nouns from Doc object
def extract_proper_nouns(doc):
    return [token.text for token in doc if token.pos_ == 'PROPN']

# Apply function to Doc column and store resulting proper nouns in new column
final_paper_df['Proper_Nouns'] = final_paper_df['Doc'].apply(extract_proper_nouns)
final_paper_df['Proper_Nouns']
```
Listing the nouns in each paper can help us ascertain the papers' subjects.

{% include figure.html filename="or-en-corpus-analysis-with-spacy-15.png" alt="Excerpts from lists of proper nouns identified in each student paper, including "New York City," "Earth," "Long," and "Gorden" among other terms." caption="Figure 15: Excerpt of proper nouns in each student paper" %}

The third paper shown here, for example, involves astronomy concepts; this is likely a biology paper. In contrast, papers 163 and 164 seem like analyses of Shakespeare plays and movie adaptations. Along with assisting content analyses, extracting nouns have been shown help build more efficient topic models [^10].

## Dependency Parsing
Closely related to POS tagging is dependency parsing, wherein SpaCy identifies how different segments of a text are related to each other. Once the grammatical structure of each sentence is identified, visualizations can be created to show the connections between different words. Since we are working with large texts, our code will break down each text into sentences (spans) and then create dependency visualizers for each span.
```
# Extract the first sentence from the fifth Doc object
doc = final_paper_df['Doc'][5]

# Create a list of sentence from the doc object
sentences = list(doc.sents)

# Retrieve the first sentence
sentence = sentences[1]

# Create dependency visualization for the first sentence of the 5th paper
displacy.render(sentence, style="dep", jupyter=True)
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-16.png" alt="Dependency parse visualization of the sentence, "There are two interesting phenomena in this research," with part of speech labels and arrows indicating dependencies between words." caption="Figure 16: Dependency parsing example from one sentence of one paper in corpus" %}

If you'd like to review the output of this code as raw `.html`, you can download it [here](/assets/corpus-analysis-with-spacy/corpus-analysis-with-spacy-16.html). Here, spaCy has identified relationships between pronouns, verbs, nouns and other parts of speech in one sentence. For example, both "two" and "interesting" modify the noun "phenomena," and the pronoun "There" is an expletive filling the noun position before "are" without adding meaning to the sentence. 

Dependency parsing makes it easy to see how removing stopwords can impact spaCy's depiction of the grammatical structure of texts. Let's compare to a dependency parsing where stopwords are removed. To do so, we'll create a function to remove stopwords from the Doc object, create a new Doc object without stopwords, and extract the part of speech tokens from the same sentence in the same paper.
```
# Define function to extract parts of speech of all non-stopwords
def extract_stopwords(doc):
    return [token.text for token in doc if token.text not in nlp.Defaults.stop_words]

# Create list of tokens without stopwords
final_paper_df['Tokens_NoStops'] = final_paper_df['Doc'].apply(extract_stopwords)

# Turn list of stopwords into a string
final_paper_df['Text_NoStops'] = [' '.join(map(str, l)) for l in final_paper_df['Tokens_NoStops']]

# Create new doc object from texts without stopwords
final_paper_df['Doc_NoStops'] = final_paper_df['Text_NoStops'].apply(process_text)

# Extract the first sentence from the first Doc object
doc = final_paper_df['Doc_NoStops'][5]
sentences = list(doc.sents)
sentence = sentences[0]

# Visualize the dependency parse tree for the sentence
displacy.render(sentence, style='dep', jupyter=True)
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-17.png" alt="Dependency parse visualization of the sentence without stopwords, "There interesting phenomena research," with part of speech labels and arrows indicating dependencies between words." caption="Figure 17: Dependency parsing example from one sentence of one paper in corpus without stopwords" %}

If you'd like to review the output of this code as raw `.html`, you can download it [here](/assets/corpus-analysis-with-spacy/corpus-analysis-with-spacy-17.html). In this example, the verb of the sentence "are" has been removed, along with the adjective "two" and the words "in this" that made up the prepositional phrases. Not only do these removals prevent the sentence from being legible, but they also render some of the dependencies inaccurate; "phenomena research" is here identified as a compound noun, and "interesting" as modifying research instead of phenomena. 

This example demonstrates what can be lost in analysis when stopwords are removed, especially when investigating the relationships between words in a text or corpus. Since part-of-speech tagging and named entity recognition are predicated on understanding relationships between words, it's best to keep stopwords in so spaCy can use all available linguistic units during the tagging process.

Dependency parsing also enables the extraction of larger chunks of text, like noun phrases. Let's try it out:
```
# Define function to extract noun phrases from Doc object
def extract_noun_phrases(doc):
    return [chunk.text for chunk in doc.noun_chunks]

# Apply function to Doc column and store resulting proper nouns in new column
final_paper_df['Noun_Phrases'] = final_paper_df['Doc'].apply(extract_noun_phrases)
```

Calling the first row in the Noun_Phrases column will reveal the words spaCy has classified as noun phrases. In this case, spaCy has identified a wide range of nouns and nouns with modifiers, from locations (e.g. "New York City") to phrases with adjectival descriptors (e.g. "the great melting pot").

{% include figure.html filename="or-en-corpus-analysis-with-spacy-18.png" alt="Excerpt from list of noun phrases present in student text, including "New York City," "different colors," and "skin swirl" among other terms." caption="Figure 18: Excerpt from list of noun phrases in first paper in the dataframe" %}

## Named Entity Recognition
Finally, SpaCy can tag “named entities” in the text, such as names, dates, organizations, and locations. Call the full list of named entities and their descriptions using this code: 
```
# Get all NE labels and assign to variable
labels = nlp.get_pipe("ner").labels

# Print each label and its description
for label in labels:
    print(label + ' : ' + spacy.explain(label))
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-19.png" alt="List of named entity tags that spaCy recognizes, along with their descriptions" caption="Figure 19: List of spaCy's named entities and their descriptions" %}

We’ll create a function to extract the named entity tags from each doc object.
```
# Define function to extract named entities from doc objects
def extract_named_entities(doc):
    return [ent.label_ for ent in doc.ents]

# Apply function to Doc column and store resulting named entities in new column
final_paper_df['Named_Entities'] = final_paper_df['Doc'].apply(extract_named_entities)
final_paper_df['Named_Entities']
```
We can add another column with the words and phrases identified as named entities.
```
# Define function to extract text tagged with named entities from doc objects
def extract_named_entities(doc):
    return [ent for ent in doc.ents]

# Apply function to Doc column and store resulting text in new column
final_paper_df['NE_Words'] = final_paper_df['Doc'].apply(extract_named_entities)
final_paper_df['NE_Words']
```
Let's visualize the words and their named entity tags in a single paper. Call the first paper's doc object and use ```displacy.render``` to visualize the text with the named entities highlighted and tagged. 
```
# Extract the first Doc object
doc = final_paper_df['Doc'][1]

# Visualize named entity tagging in a single paper
displacy.render(doc, style='ent', jupyter=True)
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-20.png" alt="Visualization of a student paper paragraph with named entities labeled and color-coded based on entity type." caption="Figure 20: Visualization of one paper with named entity tags" %}

If you'd like to review the output of this code as raw `.html`, you can download it [here](/assets/corpus-analysis-with-spacy/corpus-analysis-with-spacy-20.html). Named entity recognition enables researchers to take a closer look at the "real-world objects" that are present in their texts. The rendering allows for close-reading of these entities in context, their distinctions helpfully color-coded. In addition to studying named entities that spaCy automatically recognizees, you can use a training dataset to update the categories or create a new entity category, as in [this example](https://www.machinelearningplus.com/nlp/training-custom-ner-model-in-spacy/).

# Analysis of Linguistic Annotations
Why are spaCy's linguistic annotations useful to researchers? Below are two examples of how researchers can use data about the MICUSP corpus, produced through spaCy, to draw conclusions about discipline and genre conventions in student academic writing. 

## Part of Speech Analysis
In this section, we'll analyze the part-of-speech tags extracted by spaCy to answer the first research question: **Do students use certain parts of speech more frequently in Biology papers versus English papers that signify differences in disciplinary conventions?**

spaCy's pipeline includes a way to count the number of each part of speech tag that appears in each document (ex. # times NOUN tag appears in a document, # times VERB tag appears, etc). This is called using ```doc.count_by(spacy.attrs.POS)``` Here's how it works on a single sentence. 

{% include figure.html filename="or-en-corpus-analysis-with-spacy-21.png" alt="Jupyter Notebook cell to be run to create a doc object out of an example sentence, then print counts of each part of speech along with corresponding part of speech indices." caption="Figure 21: Part of speech indexing for words in example sentence" %}

The output is a dictionary that lists the unique index of each part of speech and the number of times that part of speech has appeared in the example sentence. To associate the actual parts-of-speech associated with each index, a new dictionary can be created which replaces the index of each part of speech for its label. In the example below, it's now possible to see which parts-of-speech tags correspond to which counts. 

{% include figure.html filename="or-en-corpus-analysis-with-spacy-22.png" alt="Jupyter Notebook cell to be run to create a doc object out of an example sentence, then print counts of each part of speech along with corresponding part of speech labels." %}

To get the same type of dictionary for each text in the DataFrame, a function can be created to nest the above for loop. We can then apply the function to each doc object in the DataFrame. In this case (and above), we are interested in the simpler, "coarse-grained" parts of speech.
```
# Create list to store each dictionary
num_list = []

# Define a function to get part of speech tags and counts and append them to a new dictionary
def get_pos_tags(doc):
    dictionary = {}
    num_pos = doc.count_by(spacy.attrs.POS)
    for k,v in sorted(num_pos.items()):
        dictionary[doc.vocab[k].text] = v
    num_list.append(dictionary)
    
# Apply function to each doc object in DataFrame
final_paper_df['C_POS'] = final_paper_df['Doc'].apply(get_pos_tags)
```
From here, we'll take the part of speech counts and put them into a new DataFrame where we can calculate the frequency of each part of speech per document. In the new dataframe, if a paper does not contain a particular part-of-speech, the cell will read "NaN" (Not a Number). 
```
# Create new dataframe with part of speech counts
pos_counts = pd.DataFrame(num_list)
columns = list(pos_counts.columns)

# Add discipline of each paper as new column to dataframe
idx = 0
new_col = final_paper_df['DISCIPLINE']
pos_counts.insert(loc=idx, column='DISCIPLINE', value=new_col)

pos_counts.head()
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-23.png" alt="DataFrame containing columns for paper genre and counts of each part of speech tag appearing in each paper." caption="Figure 23: DataFrame with counts of each part of speech usage in English and Biology papers" %}

Now we can calculate the amount of times, on average, that each part of speech appears in Biology vs. English papers. To do so, we will use the ```.groupby()``` and ```.mean()``` functions to group all part-of-speech counts from the Biology texts together and calculate the mean usage of each part of speech, and do the same for the English texts. We'll round the counts to the nearest whole number.
```
# Get average part of speech counts used in papers of each discipline
average_pos_df = pos_counts.groupby(['DISCIPLINE']).mean()

# Round calculations to the nearest whole number
average_pos_df = average_pos_df.round(0)

# Reset index to improve DataFrame readability
average_pos_df = average_pos_df.reset_index()

# Show dataframe
average_pos_df
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-24.png" alt="DataFrame containing average counts of each part of speech tag within each discipline (Biology and English)." caption="Figure 24: DataFrame with average part of speech usage for each discipline" %}

Here we can examine the differences between average part-of-speech usage per genre. As suspected, Biology student papers use slightly more adjectives (235 per paper on average), than English student papers (209 per paper on average), while an even greater number of verbs (306) are used on average in English papers than in Biology ones (237). Another interesting contrast is in the "NUM" tag: almost 50 more numbers are used in Biology papers, on average, than in English ones. Given the conventions of scientific research, this does makes sense; studies are much more frequently quantitative, incorporating lab measurements and statistical calculations. We can visualize these differences using a bar graph.

{% include figure.html filename="or-en-corpus-analysis-with-spacy-25.png" alt="Bar chart depicting average use of adjectives, verbs and numbers in English versus Biology papers, showing verbs used most and numbers used least in both disciplines, more verbs used in English papers and more adjectives and numbers used in Biology papers." caption="Figure 25: Bar graph showing verb use, adjective use and numeral use, on average, in Biology and English papers" %}

Though admittedly a simple analysis, calculating part-of-speech frequency counts affirms prior studies which posit a correlation between lexico-grammatical features and disciplinary conventions [^11] and indicates an application of spaCy that can be adapted to serve other researchers' corpora and part-of-speech usage queries. 

The same type of analysis could be performed using the fine-grained part-of-speech tags; for example, we could look at how Biology and English students use sub-groups of verbs with different frequencies. Fine-grain tagging can be deployed in a similar loop to those above; just instead of retrieving the ```token.pos_``` for each word, call spacy to retrieve the ```token.tag_```.
```
# Create list to store each dictionary
tag_num_list = []

# Define a function to get part of speech tags and counts and append them to a new dictionary
def get_fine_pos_tags(doc):
    dictionary = {}
    num_tag = doc.count_by(spacy.attrs.TAG)
    for k,v in sorted(num_tag.items()):
        dictionary[doc.vocab[k].text] = v
    tag_num_list.append(dictionary)
    
# Apply function to each doc object in DataFrame
final_paper_df['F_POS'] = final_paper_df['Doc'].apply(get_fine_pos_tags)

# Create new dataframe with part of speech counts
tag_counts = pd.DataFrame(tag_num_list)
columns = list(tag_counts.columns)

# Add discipline of each paper as new column to dataframe
idx = 0
new_col = final_paper_df['DISCIPLINE']
tag_counts.insert(loc=idx, column='DISCIPLINE', value=new_col)
```
Again, we can calculate the amount of times, on average, that each fine-grained part of speech appears in Biology vs. English paper using the ```groupby``` and ```mean``` functions.
```
# Get average fine-grained part of speech counts used in papers of each discipline
average_tag_df = tag_counts.groupby(['DISCIPLINE']).mean()

# Round calculations to the nearest whole number
average_tag_df = average_tag_df.round(0)

# Reset index to improve DataFrame readability
average_tag_df = average_tag_df.reset_index()

# Show dataframe
average_tag_df
```
{% include figure.html filename="or-en-corpus-analysis-with-spacy-26.png" alt="DataFrame containing average counts of each fine-grained part of speech tag within each discipline (Biology and English)." caption="Figure 26: DataFrame with average fine-grained part of speech usage for each discipline" %}

As evidenced by the above DataFrame, spaCy identifies around 50 fine-grained part-of-speech tags. Researchers can investigate trends in the average usage of any or all of them. For example, is there a difference in the average usage of past tense versus present tense verbs in English and Biology papers? Three fine-grain tags that could help with this analysis are VBD (past tense verbs), VBP (non 3rd-person singular present text verbs), and VBZ (3rd-person singular present tense verbs). 

{% include figure.html filename="or-en-corpus-analysis-with-spacy-27.png" alt="Bar chart depicting average use of three verb types (past-tense, third- and non-third person present tense) in English versus Biology papers, showing 3rd-person present tense verbs used most in both disciplines, many more 3rd-person present tense verbs used in English papers than the other two types and more past-tense verbs used in Biology papers." caption="Figure 27: Graph of average usage of three verb types (past-tense, third- and non-third person present tense) in English and Biology papers" %}

Graphing these reveals a fairly even distribution of the usage of the three verb types in Biology papers. However, in English papers, an average of 130 3rd-person singular tense part of speech verbs are used per paper, in compared to around 40 of the other two categories. What these differences indicate about the genres is not immediately discernable; it does indicate spaCy's values in identifying patterns of linguistic annotations for further exploration by computational and close-reading methods.

The analyses above are only a couple of many possible applications for part-of-speech tagging. art-of-speech tagging is also useful for [research questions about sentence *intent*](https://nostarch.com/download/samples/NLP_Vasiliev_ch2.pdf); the meaning of a text changes depending on whether the past, present, or infinitive form of a particular verb is used. It's valuable for word sense disambiguation and language translation. And of course, part-of-speech tagging is a building block of named entity recogntion, the focus of the analysis below.  

## Named Entity Analysis
In this section, we'll use the named entity tags extracted from spaCy to investigate the second research question: **Do students use certain named entities more frequently in different academic genres that signify differences in genre conventions?** 

To start, we'll create a new DataFrame with the text filenames, disciplines, and part of speech tags.
```
# Create new DataFrame for analysis purposes
ner_analysis_df = final_paper_df[['Filename','PAPER TYPE', 'Named_Entities', 'NE_Words']]
```
Using the str.count method, we can get counts of a specific named entity used in each text. Let's get the counts of the named entities of interest here (PERSON, ORG, DATE, and CARDINAL (numbers) ) and add them as new columns of the DataFrame. 
```
# Convert named entity lists to strings so we can count specific entities
ner_analysis_df['Named_Entities'] = ner_analysis_df['Named_Entities'].apply(lambda x: ' '.join(x))

# Get the number of each type of entity in each paper
person_counts = ner_analysis_df['Named_Entities'].str.count('PERSON')
org_counts = ner_analysis_df['Named_Entities'].str.count('ORG')
date_counts = ner_analysis_df['Named_Entities'].str.count('DATE')
cardinal_counts = ner_analysis_df['Named_Entities'].str.count('CARDINAL')

# Append named entity counts to new DataFrame 
ner_counts_df = pd.DataFrame()
ner_counts_df['Genre'] = ner_analysis_df["PAPER TYPE"]
ner_counts_df['PERSON_Counts'] = person_counts
ner_counts_df['ORG_Counts'] = org_counts
ner_counts_df['DATE_Counts'] = date_counts
ner_counts_df['CARDINAL_Counts'] = cardinal_counts

ner_counts_df.head()
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-28.png" alt="First five rows of DataFrame containing rows for paper genre and counts of four named entities (PERSON, ORG, DATE, and CARDINAL) per paper." caption="Figure 28: Head of dataFrame depicting use of Person, Org, Date, and Cardinal named entities in English and Biology papers" %}

From here, we can compare the average usage of each named entity and plot across paper type.

{% include figure.html filename="or-en-corpus-analysis-with-spacy-29.png" alt="Bar chart depicting average use of named entities across seven genres, with highest counts of PERSON and DATE tags across all genres, with more date tags used in proposals, research papers and creative writing papers and more person tags used in argumentative essays, critique/evaluations, reports and response papers." caption="Figure 29: Bar chart depicting average use of Person, Location, Date, and Work of Art named entities across genres" %}

As hypothesized at the start of this tutorial, the most dates and numbers are used in description-heavy proposals and research papers. More people and works of art are referenced in arguments and critiques/evaluations, both of which are predicated on engaging with and assessing other scholarship. Interestingly, people and locations are used the most on average in all genres, likely because these often appear in citations. Overall, locations are most invoked in proposals and report. Though this should be investigated further through close reading, it does follow that these genres would use locations most because are often grounded in real-world spaces in which events are being reported or proposed. 

Let's explore  patterns of one of these entities usage (dates) further by retrieving the words most frequently tagged as dates in various genres. We'll do this by first creating functions to extract the words tagged as date entities in each document and adding the words to a new DataFrame column.
```
# Define function to extract words tagged as "date" named entities from doc objects
def extract_date_named_entities(doc):
    return [ent for ent in doc.ents if ent.label_ == 'DATE']

# Get all date entity words and apply to new column of DataFrame
ner_analysis_df['Date_Named_Entities'] = final_paper_df['Doc'].apply(extract_date_named_entities)

# Make list of date entities a string so we can count their frequencies
ner_analysis_df['Date_Named_Entities'] = [', '.join(map(str, l)) for l in ner_analysis_df['Date_Named_Entities']]
```
Now we can retrieve only the subset of papers that are in the proposal genre, get the top words that have been tagged as "dates" in these papers and append them to a list. 
```
# Search for only date words in proposal papers
date_word_counts_df = ner_analysis_df[(ner_analysis_df == 'Proposal').any(axis=1)]

# Count the frequency of each word in these papers and append to list
date_word_frequencies = date_word_counts_df.Date_Named_Entities.str.split(expand=True).stack().value_counts()
date_word_frequencies[:10]
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-30.png" alt="List of top 10 words most frequently tagged as DATE named entites in proposal papers, including "years," "1950," and "winter," among other terms." caption="Figure 30: Top 10 words identified as dates in proposals" %}

The majority are standard 4-digit dates; though further analysis is certainly needed to confirm, these date entities seem to indicate citation references are occuring. This fits in with the expectations of the proposal genre, which require references to prior scholarship to justify students' proposed claims.

Let's contrast this with the top "DATE" entities in Critique/Evaluation papers. 
```
# Search for only date words in critique/evaluation papers
date_word_counts_df = ner_analysis_df[(ner_analysis_df == 'Critique/Evaluation').any(axis=1)]

# Count the frequency of each word in these papers and append to list
date_word_frequencies = date_word_counts_df.Date_Named_Entities.str.split(expand=True).stack().value_counts()

# Get top 10 most common words and their frequencies
date_word_frequencies[:10]
```

{% include figure.html filename="or-en-corpus-analysis-with-spacy-31.png" alt="List of top 10 words most frequently tagged as DATE named entites in critique/evaluation papers, including "2004," "2003," and "2002," among other terms." caption="Figure 31: Top 10 words identified as dates in Critique/Evaluation papers" %}

Only four of the top dates tagged are words, and the rest are noun references to relative dates or periods. This too may indicate genre conventions such as the need to provide context and/or center an argument in relative space and time in evaluative work. Future research could analyze chains of named entities (and parts of speech) to get a better understanding of how these features work together to indicate larger rhetorical efforts.

# Download Enriched Dataset
To wrap up, download the DataFrame with the spaCy doc objects and tags to your local computer as a csv file.
```
# Save paper as csv to your computer's working directory
final_paper_df.to_csv('MICUSP_papers_with_spaCy_tags.csv') 
```
You will need to take an additional step to download the file to your machine if you are working in Google Colab.
```
# Save DataFrame as csv (in drive)
final_paper_df.to_csv('MICUSP_papers_with_spaCy_tags.csv') 

# Download csv to your computer
files.download('MICUSP_papers_with_spaCy_tags.csv')
```

# Conclusions
Through this tutorial, we've gleaned more information about the grammatical makeup of a text corpus. Such information can be valuable to researchers who are seeking to understand differences between texts in their corpus - for example, **what types of named entities are most common across the corpus? How frequently are certain words used as nouns vs. objects within individual texts and corpora, and what may this reveal about the content or themes of the texts themselves?** 

While we've covered the basics of spaCy in this tutorial, the pipeline has other capacities, like word vectorization and custom rule-based tagging, that are certainly worth exploring in more detail. The pipeline can also be altered to work with custom feature sets. A great example of this is in [Susan Grunewald and Andrew Janco's 2022 Programming Historian tutorial,](/en/lessons/finding-places-world-historical-gazetteer#4-building-a-gazetteer) "Finding Places in Text with the World Historical Gazeteer," in which spaCy is leveraged to identify place names of German prisoner of war camps in World War II memiors, as based on a historical gazetteer of camp names. SpaCy is also a helpful tool to explore texts without fully-formed research questions in mind, because exploring linguistic annotations like those mentioned above can propel further questions and text-mining pipelines.

Ultimately, this  tutorial has provided a foundation for corpus analysis  with spaCy. Whether you wish to investigate language use in student papers, novels, or another large collection of texts, this code can be repurposed for your use.


# Endnotes 
[^1]: Matthew Brooke O'Donnell and Ute Römer, "From student hard drive to web corpus (part 2): The annotation and online distribution of the Michigan Corpus of Upper-level Student Papers (MICUSP)," *Corpora* 7, no. 1 (2012): 1–18. [https://doi.org/10.3366/cor.2012.0015](https://doi.org/10.3366/cor.2012.0015).

[^2]: Jack Hardy and Ute Römer, "Revealing disciplinary variation in student writing: A multi-dimensional analysis of the Michigan Corpus of Upper-level Student Papers (MICUSP)," *Corpora* 8, no. 2 (2013): 183–207. [https://doi.org/10.3366/cor.2013.0040](https://doi.org/10.3366/cor.2013.0040).

[^3]: Laura Aull, "Linguistic Markers of Stance and Genre in Upper-Level Student Writing," *Written Communication* 36, no. 2 (2019): 267–295. [https://doi.org/10.1177/0741088318819472](https://doi.org/10.1177/0741088318819472).

[^4]: Sugene Kim, "‘Two rules are at play when it comes to none ’: A corpus-based analysis of singular versus plural none: Most grammar books say that the number of the indefinite pronoun none depends on formality level; corpus findings show otherwise," *English Today* 34, no. 3 (2018): 50–56. [https://doi.org/10.1017/S0266078417000554](https://doi.org/10.1017/S0266078417000554).

[^5]: Carol Berkenkotter and Thomas Huckin, *Genre knowledge in disciplinary communication: Cognition/culture/power,* (Lawrence Erlbaum Associates, Inc., 1995).

[^6]: Jack Hardy and Eric Friginal, "Genre variation in student writing: A multi-dimensional analysis," *Journal of English for Academic Purposes* 22 (2016): 119-131. [https://doi.org/10.1016/j.jeap.2016.03.002](https://doi.org/10.1016/j.jeap.2016.03.002).

[^7]: Jack Hardy and Ute Römer, "Revealing disciplinary variation in student writing: A multi-dimensional analysis of the Michigan Corpus of Upper-level Student Papers (MICUSP)," *Corpora* 8, no. 2 (2013): 183–207. [https://doi.org/10.3366/cor.2013.0040](https://doi.org/10.3366/cor.2013.0040).

[^8]: Alexandra Schofield, Måns Magnusson and David Mimno, "Pulling Out the Stops: Rethinking Stopword Removal for Topic Models," *Proceedings of the 15th Conference of the European Chapter of the Association for Computational Linguistics* 2 (2017): 432-436. [https://aclanthology.org/E17-2069](https://aclanthology.org/E17-2069).

[^9]: Matthew J. Lavin, "Gender Dynamics and Critical Reception: A Study of Early 20th-century Book Reviews from the New York Times," *Cultural Analytics* 5, no. 1 (2020). [https://doi.org/10.22148/001c.11831](https://doi.org/10.22148/001c.11831).  

[^10]: Fiona Martin and Mark Johnson. "More Efficient Topic Modelling Through a Noun Only Approach," *Proceedings of the Australasian Language Technology Association Workshop* (2015): 111–115. [https://aclanthology.org/U15-1013](https://aclanthology.org/U15-1013).

[^11]: Jack Hardy and Ute Römer, "Revealing disciplinary variation in student writing: A multi-dimensional analysis of the Michigan Corpus of Upper-level Student Papers (MICUSP)," *Corpora* 8, no. 2 (2013): 183–207. [https://doi.org/10.3366/cor.2013.0040](https://doi.org/10.3366/cor.2013.0040).
