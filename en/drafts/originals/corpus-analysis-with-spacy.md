---
title: CORPUS ANALYSIS WITH SPACY
collection: lessons  
layout: lesson  
authors:
- MEGAN KANE
---
# Table of Contents
{% include toc.html %}

--

# Introduction
This lesson demonstrates how to clean and analyze text corpora using [spaCy](https://spacy.io/), an industrial-strength library for natural language processing. It is intended for researchers who have some familiarity with spaCy and want to learn how it can be used for corpus analysis. It may also be useful for anyone who is curious about natural language processing tools in general and how they can help answer humanities research questions. 

## Tutorial Goals
By the end of this tutorial, you will be able to: 
*   Upload a corpus of texts to a platform for Python analysis (Google Colab or Jupyter Notebook)
*   Clean the corpus by lowercasing, removing stop words and removing punctuation 
*   Enrich the corpus through lemmatization, part-of-speech tagging and chunking, and named entity recognition
*   Conduct frequency analyses with part-of-speech tags and named entities 
*   Download an enriched dataset for use in future NLP/analyses

## Why Use SpaCy for Corpus Analysis?
As the name implies, corpus analysis involves studying corpora, or large collections of documents. Typically, the documents in a corpus are representative of some group(s) a researcher is interested in studying, like the writings of a specific author or genre. By analyzing these texts at scale, researchers can identify meaningful trends in the way language is used within the target group(s).
 
Though computational tools can't "read" texts like humans do, they excel at identifying the lexico-grammatical patterns (e.g. key words, phrases, parts of speech) that corpus analysis researchers are looking for. spaCy is particularly good at retrieving information about lemmas (base words), part of speech tags, and named entities. Though spaCy was designed for production use, researchers also find it valuable for several reasons: 
*   It's [fast and easy to set up and call the nlp pipeline](https://www.thedataincubator.com/blog/2016/04/27/nltk-vs-spacy-natural-language-processing-in-python/); no need to call a wide range of packages and functions for each individual task
*   It uses only the [latest and best algorithms](https://medium.com/@akankshamalhotra24/introduction-to-libraries-of-nlp-in-python-nltk-vs-spacy-42d7b2f128f2) for text-processing tasks, so it's easy to run and kept up-to-date by the developers 
*   It [performs better on text-splitting tasks than NLTK](https://proxet.com/blog/spacy-vs-nltk-natural-language-processing-nlp-python-libraries/), since it constructs syntactic trees for each sentence it is called on

You may still be wondering: What is the value of extracting language data like lemmas, part-of-speech tags, and named entities from a corpus? How can they help researchers answer meaningful humanities research questions? To illustrate, let's look at the example corpus and questions developed for this tutorial. 

## Lesson Dataset: Biology and English Papers from the Michigan Corpus of Upper-Level Student Papers (MICUSP)
The [Michigan Corpus of Upper-Level Student Papers (MICUSP)](https://elicorpora.info/main) is a corpus of 829 high-scoring academic writing samples from students at the University of Michigan. The papers come from 16 disciplines and seven genres; all were written by senior undergraduate or graduate students and received an A-range score in a university course [^1]. The papers and their metadata are publically available on MICUSP Simple, an online interface which allows users to search for papers by a range of fields (e.g. genre, discipline, student level, textual features) and conduct simple keyword analyses across disciplines and genres. Metadata from the corpus is available to download in csv form. The text files can be retrieved via webscraping, a process explained further in [Jeri Wieringa's Intro to BeautifulSoup Tutorial](https://programminghistorian.org/en/lessons/retired/intro-to-beautiful-soup).

Given its size and robust metadata, MICUSP has become a valuable tool for researchers seeking to study student writing computationally. Notably, Jack Hardy and Ute Römer [^2] use MICUSP to study language features that indicate how student writing differs across disciplines, Laura Aull [^3] compares usages of stance markers across student genres, and Sugene Kim [^4] highlights discrepancies between prescriptive grammar rules and actual language use in student work. Like much corpus anaylysis research, these studies are predicated on the fact that computational analysis of language patterns--the discrete lexico-grammatical practices students employ in their writing--can yield insights into larger questions about academic writing. Given its value in retrieving linguistic annotations, spaCy is well-poised to conduct this type of analysis using MICUSP.

This tutorial will explore a subset of documents from MICUSP: 67 Biology papers and 98 English papers. Papers in this select corpus belong to all seven MICUSP genres: Argumentative Essay, Creative Writing, Critique/Evaluation, Proposal, Report, Research Paper, and Response Paper. This select corpus and the associated metadata csv are available to download as part of the tutorial's [lesson materials](https://github.com/mkane968/Corpus-Analysis-with-SpaCy/tree/main/lesson-materials). It has been culled from the larger corpus in order to investigate the differences between two distinct disciplines of academic writing (Biology and English). It is also a manageable size for the purposes of this tutorial. If your computer has limited processing power, or if you choose to use the Google Colab version of this tutorial, you may encounter lags in runtime when your code is trying to process huge corpora (such as all 829 texts from MICUSP). However, you are more than welcome to retrieve the entire MICUSP corpus (or a different subsection) with [this webscraping code](https://github.com/mkane968/webscraping_micusp/blob/main/MICUSP_Webscraping_11-22.ipynb) and using that dataset for the analysis.

This tutorial will describe how spaCy's utilities in **stopword removal,** **tokenization,** and **lemmatization** can clean and prepare a corpus of student texts for analysis. It will also demonstrate how spaCy's ability to extract linguistic annotations like **part-of-speech tags** and **named entities** can be used to compare conventions within subsets of a discourse community of interest. Here, the focus will be on lexico-grammatical features that may indicate genre and disciplinary differences in academic writing. The following research questions will be investigated:

**RQ1: Do students use certain parts of speech more frequently in Biology papers versus English papers that signify differences in disciplinary conventions?** 
- Prior research has shown that even when writing in the same genres, writers in the sciences follow different conventions than those in the humanities. Notably, academic writing in the sciences has been characterized informational, descriptive, and procedural, while that in the humanities is narrativized, evaluative, and situation-dependent (i.e. focused on discussing a particular text or prompt)[^2]. By deploying spaCy on the MICUSP texts, researchers can determine whether there are any significant differences between the part-of-speech tag frequencies in English and Biology papers. For example, we might expect students writing Biology papers to use more adjectives than those in the humanities, given their focus on description. Conversely, we might suspect English papers have more verbs and verb auxiliaries, indicating a more narrative structure. We'll analyze part-of-speech counts generated by spaCy to test these hypotheses as well as explore other part-of-speech count differences that could prompt further investigation. 

**RQ2: Do students use certain named entities more frequently in different academic genres that signify differences in genre conventions?** 
- As with disciplines, research has shown that different genres of writing have their own conventions and expectations [^6]. For example, explanatory genres like research papers, proposals and reports focus on analysis and explanation, whereas argumentative and critique-driven papers are driven by evaluations and arguments [^7]. By deploying spaCy on the MICUSP texts, researchers can determine whether there are any significant differences between the named entity frequencies in papers within the seven different genres represented (Argumentative Essay, Creative Writing, Critique/Evaluation, Proposal, Report, Research Paper, and Response Paper). We may suspect that argumentative genres engage more with people or organizations--in effect, entities with or against which they are taking a stance. Conversely, perhaps dates and numbers are more prevalent in evidence-heavy genres, like research papers and proposals. We'll analyze the nouns and noun phrases spaCy has tagged as "named entities" to test these hypotheses.  

Finally, this tutorial will address how a dataset enriched by spaCy can be exported in a usable format for further analyses like [sentiment analysis](https://programminghistorian.org/en/lessons/sentiment-analysis#calculate-sentiment-for-a-paragraph) or [topic modeling](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet).

## Before You Begin
You should have some familiarity with Python or a similar coding platform. For a brief introduction or refresher, work through some of the *Programming Historian's* [introductory Python tutorials](https://programminghistorian.org/en/lessons/introduction-and-installation). You should also have basic knowledge of spreadsheet (.csv) files, as this tutorial will primarily use data in a similar format called a [pandas](https://pandas.pydata.org/) DataFrame. [This lesson on data normalization](https://programminghistorian.org/en/lessons/crowdsourced-data-normalization-with-pandas) provides an overview to creating and manipulating datasets using pandas. 

Two versions of code are provided for this tutorial: one version to be run on Jupyter Notebook and one for Google Colaboratory. The versions are the same except when it comes to the process of retrieving and downloading files. Because a Jupyter Notebook is hosted locally, the files stored on your computer can be accessed directly. Google Colab, on the other hand, is cloud-based, and requires files to be uploaded to Drive. This tutorial will note such divergences below and first explain the code for working with Jupyter Notebook, then for Google Colab. More details and setup instructions for each platform are as follows: 
*  **Jupyter Notebook** is an environment through which you can run Python on your local machine. Since it's local, it works offline, and you can set up dedicated environments for your projects in which you'll only need to install packages once. If you've used Python before, you likely already have Jupyter Notebook installed on your machine. [This tutorial](https://programminghistorian.org/en/lessons/jupyter-notebooks) covers the basics of setting up Jupyter Notebook using Anaconda.

*  **Google Colaboratory** is a Google platform which allows you to run Python in a web browser. Access is free with a Google account and nothing needs to be installed to your local machine. If you're new to coding, aren't working with sensitive data, and aren't running processes with [slow runtime](https://www.techrepublic.com/article/google-colab-vs-jupyter-notebook/), Google Colab may be the best option for you. [Here's a brief Colab tutorial from Google.](https://colab.research.google.com/)

It is also recommended, though not required, that you have some background in methods of computational text mining. [This PH lesson on corpus analysis with AntConc](https://programminghistorian.org/en/lessons/corpus-analysis-with-antconc) shares tips for working with plain text files and outlines possibilities for exploring keywords and collocates in a corpora (though using a different tool). [This PH lesson on counting frequencis](https://programminghistorian.org/en/lessons/counting-frequencies) describes the process of counting word frequencies, a practice this tutorial will adapt to count part of speech and named entity tags. 

Prior familiarity with spaCy is also recommended but not required. For a quick primer, go to the [spaCy 101 page](https://spacy.io/usage/spacy-101) from the library's developers.

# Install and Import Packages
Install and import spaCy and related libraries and packages. To improve efficiency, it is common practice to do a single install at the very top of the file instead of interspersing them with your code. These packages can be run in a single cell of code. Below, the markdown text describes how each downloaded package or library will be used in the analysis. 

Note: the first time you run this code, you may need to install spaCy itself using ```!pip install```. Following this, you can just retrieve the associated packages using the import function*

```
#Install and import spacy
!pip install spaCy
import spacy

#Load the natural language processing pipeline
#We'll choose eng_core_web_sm, the small English pipeline which has been tagged on written web texts
nlp = spacy.load("en_core_web_sm")

#Load spaCy visualizer
from spacy import displacy

#Import pandas DataFrame packages
import pandas as pd

#Import graphing package
import plotly.graph_objects as go
import plotly.express as px
```

If using Google Colab, you will also need to import ```drive``` and ```files``` to faciliate uploads of the student papers and metadata. If using Jupyter Notebook, import the ```os``` module for the same purpose.

# Load Text Files into DataFrame

After all necessary packages have been imported, it is time to upload the texts for analysis. As noted above, the process differs slightly for Jupyter Notebook vs. Google Colab. 

## Upload Files to Jupyter Notebook

Run the following code to change your working directory, the location on your computer where Python will search for files to process. Before completing this step, you will need to have downloaded the student papers and metadata to your local machine. Copy the name of the path to your files and insert it below. 
```
##Get current working directory 
path = os.getcwd()
print(path)

#Change working directory
path = os.chdir("/PATH_TO_FILES")
```
Next, upload the files for analysis. This can be done by creating a for loop which searches through the folder specified as the working directory, finds all .txt files, and appends them and their file names to two separate lists.
```
#Create empty lists for file names and contents
filenames = []
data = []
files = [f for f in os.listdir(path) if os.path.isfile(f)]

#Retrieve all txt files and file names and append to two lists
for f in files:
    if f.endswith('.txt'):
        with open (f, "rb") as myfile:
            filenames.append(myfile.name)
            data.append(myfile.read())
```
Transform the two lists into a dictionary, where each file name is associated with its body of text.
```
d = {'Filename':filenames,'Text':data}
```
From here, turn the dictionary into a pandas DataFrame. This step will organize the texts into a table of rows and columns–in this case, the first column will contain the names of the files, and the second column will contain the content of each file 
```
#Turn dictionary into a dataframe
paper_df = pd.DataFrame(d)
paper_df.head()
```
Use the ```.head()``` function to call the first five rows of the DataFrame and check that the file names and text are present. You will notice some strange characters at the start of each row of text; these are related to the encoding and will be cleaned below. 

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY1.png" caption="Figure 1: Uncleaned DataFrame with filenames and texts in Jupyter Notebook" %}

Next we will retrieve the metadata of interest: the discipline and genre information connected to the MICUSP papers. Later in this tutorial, we will use spaCy to trace differences across genre and disciplinary categories later. Run the following code to locate the csv file (specify the path) and use it to create a Pandas dataframe.
```
paper_df = pd.read_csv('../FILE_NAME')
```
Drop any empty columns and display the first five rows to check that the data is as expected. Four rows should be present: the paper IDs, their titles, their discipline, and their type.

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY2.png" caption="Figure 2: Jupyter DataFrame with paper metadata-ID, title, discpline and type" %}

The process to add the metadata into the same dataframe as the file contents is the same for both Jupyter Notebook and Google Colab users. Jump to the following section to continue the tutorial from this point.

## Upload Files to Google Colaboratory
Run the following code to “mount” the Google Drive, which allows your Google Colab notebook to access any files on your Drive. A box will pop up asking for permission for the notebook to access your Drive files; click “Connect to Google Drive,” select or log into your Google account, and click “Allow.” 

Next, load the files for analysis into your Google Drive. To complete this step, you must have the files of interest saved in a folder on your local machine. Once you run the line of code below, a button will pop up directing you to “Choose Files” – click the button and a file explorer box will pop up. From here, navigate to the folder where you have stored the papers (.txt files), select all files of interest, and click “Open.” The files will then be uploaded to your Google Drive. You will see the upload complete as output of your cell and can access the files by clicking the file icon in the bar on the left-hand side of the notebook.

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY3.png" caption="Figure 3: Files uploaded and saved to Google Drive" %}

Now we have files upon which we can perform analysis. To check what form of data we are working with, use the type() function. It should return that your files are contained in a dictionary, where keys are the file names and values are the content of each file. 

```
type(uploaded_files)
```

Next, we’ll make the data easier to manage by inserting it into a Pandas DataFrame. This will organize the texts into a table of rows and columns–in this case, the first column will contain the names of the files, and the second column will contain the context of each file. Since the files are currently stored in a dictionary, use the DataFrame.from_dict() function to append them to a new DataFrame.

```
#Add files into DataFrame
paper_df = pd.DataFrame.from_dict(uploaded_files, orient='index')
paper_df.head()
```
Use the ```.head()``` function to call the first five rows of the DataFrame and check that the file names and text are present. You will notice some strange characters at the start of each row of text; these are related to the encoding and will be cleaned below. 

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY4.png" caption="Figure 4: Uncleaned DataFrame with filenames and texts in Colab" %}

From here, you can reset the index (the very first column of the DataFrame) so it is a true index, rather than the list of file names. The file names will become the first column and the texts become the second, and this will make data wrangling easier later. Check the head of the dataset again to confirm this process has worked.

```
#Reset index and add column names to make wrangling easier
paper_df = paper_df.reset_index()
paper_df.columns = ["Filename", "Text"]
```

Next we will retrieve the metadata of interest: the discipline and genre information connected to the MICUSP papers. Later in this tutorial, we will use spaCy to trace differences across genre and disciplinary categories later.  When the cell is run, click "choose files", navigate to where you have stored the metadata.csv file, and select this file to upload.

```
#Upload csv with essay metadata
metadata = files.upload()
```

We'll first convert the uploaded csv file to a second DataFrame, drop any empty columns and display the first five rows to check that the data is as expected. Four rows should be present: the paper IDs, their titles, their discipline, and their type.

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY5.png" caption="Figure 5: Colab DataFrame with paper metadata-ID, title, discpline and type" %}

At this point, we have uploaded all files we need for analysis, and the code is the same for Google Colab and Jupyter Notebook users. 

## Merge DataFrames with Paper Files and Metadata
If you compare the DataFrames with the paper files and the metadata, you will notice that the paper ids in the metadata DataFrame are almost the same as the file names in the paper file DataFrame. We're going to make them match exactly so we can merge the two DataFrames together on this column; in effect, linking each text with their title, discipline and genre.

To match the columns, we'll remove the ".txt" tag from the end of each filename in the paper DataFrame, and then we'll rename the paper id column "Filename."

```
#Remove .txt from title of each paper
paper_df['Filename'] = paper_df['Filename'] .map(lambda x: x.rstrip('.txt'))

#Rename column from paper ID to Title
metadata_df.rename(columns={"PAPER ID": "Filename"}, inplace=True)
```

Now it is possible to combine the papers and metadata into a single DataFrame. Check the first five rows to make sure each has a filename, title, discipline, paper type and text (the full paper).

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY6.png" caption="Figure 6: Merged DataFrame with files and metadata" %}

The resulting DataFrame is now ready for cleaning and analysis. 

# Cleaning and Tokenization

## Basic Cleaning Processes

From a quick scan of the DataFrame, it is evident that some preliminary cleaning is required. First use the .decode() module to remove any utf-8 characters embedded in the texts (b'\xef\xbb\xbf). It is also important to remove newline characters (\n, \r) through a simple string replacement line. These are NOT functions of spaCy but are necessary to make the code recognizable for further cleaning and tokenization. 

```
#Remove encoding characters from Text column (b'\xef\xbb\xbf)
final_paper_df['Text'] = final_paper_df['Text'].apply(lambda x: x.decode('utf-8', errors='ignore'))

#Remove newline characters
final_paper_df['Text'] = final_paper_df['Text'].str.replace(r'\s+|\\r', ' ', regex=True) 
final_paper_df['Text'] = final_paper_df['Text'].str.replace(r'\s+|\\n', ' ', regex=True) 
```

The next, most basic operation to perform is lowercasing all tokens in the texts. This will prevent incorrect calculations in later case-sensitive analysis; for example, if lowercasing is not performed, “House” and “house” may be counted as two different words. 

```
#Lowercase all words
final_paper_df['Text'] = final_paper_df['Text'].str.lower()
```

The next step is to remove punctuation. Depending on your analysis goals, you may want to keep punctuation, but in this case we are interested in words only.

```
#Remove punctuation and replace with no space (except periods and hyphens)
final_paper_df['Text'] = final_paper_df['Text'].str.replace(r'[^\w\-\.\'\s]+', '', regex = True)

#Remove periods and replace with space (to prevent incorrect compounds)
final_paper_df['Text'] = final_paper_df['Text'].str.replace(r'[^\w\-\'\s]+', ' ', regex = True)
```

Check the resulting DataFrame, which includes a column of texts without encoding or whitespace characters, all words lowercased, and punctuation removed. Both Google Colab and Jupyter Notebook have extensions to make it easier to view and interact with large DataFrames. 

On Jupyter Notebooks, run the following code to import the itables module: 
```
#!pip install itables
from itables import init_notebook_mode, show
init_notebook_mode(all_interactive=True)
final_paper_df
```
You may need to adjust the column lengths so that more of each text is viewable. In the resulting table, it's easier to read each text, and it's possible to sort data by each column and search for keywords. 

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY7.png" caption="Figure 7: Interactive table in Jupyter Notebook" %}

You may set up itables so it renders all tables interactive (above: ```init_notebook_mode(all_interactive=True```) or specify per table. [Learn more about itables here.](https://mwouts.github.io/itables/quick_start.html)

On Google Colab, run the following code to enable the data table display: 
```
from google.colab import data_table
data_table.enable_dataframe_formatter()
```

In the resulting table, each text is printed in full, and it's possible to sort data by each column and search for keywords. You can disable this feature using the following code ```data_table.disable_dataframe_formatter()```

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY8.png" caption="Figure 8: Interactive table in Google Colab" %}

[Learn more about Data Table Display here.](https://colab.research.google.com/notebooks/data_table.ipynb)

## Tokenization and Stopword Removal

Tokenization is the process used to split up full text into smaller parts for analysis. SpaCy has a built-in function for tokenization that involves segmenting texts into individual parts like words and punctuation. Take the example of an individual sentence: 

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY9.png" caption="Figure 9: Tokenization of example sentence" %}

What this function is doing is calling the spaCy nlp pipeline, which contains the data and components needed for text processing. When the nlp pipeline is called on a sentence, it splits that sentence on each whitespace and reviews its components. Components are then split based on rules for words, punctuations, prefixes, suffixes, etc. Each token is then loaded into a new object that we’ve called “doc.” Calling nlp also enables part of speech tagging, lemmatization, and other enrichment procedures we’ll discuss further below. 

Since we are working with multiple long texts, we are going to use nlp.pipe, which processes batches of texts as doc objects. Here we’ll tokenize each text in our DataFrame, append each set of tokens to a list, and add the new token lists to a new column in the DataFrame.

```
#Tokenize with spaCy
#Create list for tokens
token_list = []

# Disable POS, Dependency Parser, and NER since all we want is tokenizer 
with nlp.disable_pipes('tagger', 'parser', 'ner'):
  #Iterate through each doc object (each text in DataFrame) and tokenize, append tokens to list
    for doc in nlp.pipe(final_paper_df.Text.astype('unicode').values, batch_size=100):
        word_list = []
        for token in doc:
            word_list.append(token.text)

        token_list.append(word_list)
        
#Make token list a new column in DataFrame
final_paper_df['Tokens'] = token_list
```

When tokenizing texts, you can also exclude stopwords. Stopwords are words which may hold little significance to text analysis, such as very common words like “the” or “and.” SpaCy has a built-in dictionary of stopwords which you can access. You can also add or remove your own stopwords, as shown below:

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY10.png" caption="Figure 10: Stopword dictionary outputs after removing and adding words" %}

To tokenize texts without stopwords, follow the same process above using nlp.pipe, but only append tokens to list that are NOT included in stopwords list and append these to a new row in the DataFrame.

At this point, we have two tokenized lists: one with and without stopwords. Depending on the purposes of your analyses, you might need your data in token form. One of the benefits of spaCy, however, is that it's streamlined: when you ask it to tag parts-of-speech in a dataset, its *first* step (behind the scenes) is to tokenize the data. In other words, we don't need to run this tokenization process before running part-of-speech tagging or other analyses; we're just doing it here to demonstrate how spaCy works under-the-hood, and to get a dataset that's useful for [other types of analysis](https://towardsdatascience.com/tokenization-for-natural-language-processing-a179a891bad4). Many forms of sentiment analysis, for example, require data to be tokenized, as this form of analysis involves finding the polarity of each separate word in a document.

Even so, tokenizing the dataset without stopwords will be of value to our analysis. We can do this once, at the outset, to speed up runtime later--in essence, removing the stopwords once, so the nlp pipeline doesn't have to do the same every time. All we need to do to make the dataset with no stopwords useable for spaCy analysis is to transform each essay from a list of tokens back into a string. 

```
final_paper_df['Text_NoStops'] = [' '.join(map(str, l)) for l in final_paper_df['Tokens_NoStops']]
```

Why analyze text without stopwords? One case where stopword removal may be useful is if you want to compare document similarity. SpaCy calculates document similarity based on corpus word vectors; since stopwords are words that appear throughout texts, they will heighten document similarity scores even if their content is very different. To make this type of analysis more accurate, we'll load a larger spaCy pipeline with vectors (en_core_web_md).

Observe the difference between these two texts, with and without stopwords. As expected, these two texts in different disciplines are less similar with stopwords removed.

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY11.png" caption="Figure 11: Document similarity analysis with and without stopwords" %}

Stopword removal is also useful for topic modeling and classification tasks, where finding general themes across documents is the goal. However, other types of analysis like sentiment analysis are highly sensitive and removing stopwords will change sentence meaning (e.g. removing “not” in the sentence “I was not happy”). When possible, it is recommended to run analysis with and without stopwords and see how the model changes. Below, we will compare how keeping vs. removing stopwords impact spaCy analyses.

At this point, we have a cleaned DataFrame on which we can use spaCy for further text enrichment. But if you don't need lemmas, parts of speech, and named entities for your further analytic purposes, you can download the DataFrame as it is to your machine using this code. 

```
final_paper_df.to_csv('final_paper_df.csv') 
```

In Jupyter Notebook, your csv file will be saved in your working directory. In Google Colab, you will need an additional line of code to download the file to your local machine. 

```
files.download('final_paper_df.csv)
```

We'll create a new DataFrame to which we'll add the spaCy enrichments (lemmas, part of speech tags, named entities). We'll only keep the filenames, discipline and paper type labels, the text, and the text without stopwords. 

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY12.png" caption="Figure 12: DataFrame for text enrichment including metadata and cleaned texts with and without stopwords" %}

We'll also use the smaller spaCy pipeline which is optimized for tagging, parsing, lemmatizing and ner. It's not as accurate as the en_core_web_md (and _lg) models, but processing will be faster. [Learn more about the models here](https://spacy.io/models).

# Text Enrichment
## Lemmatization

SpaCy enables several types of text enrichment. We’ll start with lemmatization, which retrieves the dictionary root word of each word (e.g. “brighten” for “brightening”). Lemmatization is one of the functions that occurs when the nlp pipe is called; repeat the same process as above to iterate through each document in the dataframe and this time append all lemmas to new column. 

```
#Get lemmas
lemma_list = []

# Disable Dependency Parser, and NER since all we want is lemmatization 
with nlp.disable_pipes('parser', 'ner'):
  #Iterate through each doc object and tag lemma, append lemma to list
  for doc in nlp.pipe(enriched_df.Text_NoStops.astype('unicode').values, batch_size=100):
    word_list = []
    for token in doc:
        word_list.append(token.lemma_)
        
    lemma_list.append(word_list)

#Make pos list a new column in dataframe
enriched_df['Lemmas'] = lemma_list
enriched_df['Lemmas'] = [' '.join(map(str, l)) for l in enriched_df['Lemmas']]
```

Lemmatization can help reduce noise and refine results for researchers who are conducting keyword searches. For example, let's compare counts of the word "write" in the original token column and in the lemmatized column.

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY13.png" caption="Figure 13: Frequency count of "write" with full texts and lemmas" %}

As expected, there are more instances of "write" in the lemmas column, as the lemmatization process has grouped inflected word forms (writing, writer) into the base word "write." For similar reasons, lemmatized data is also often used to [create topic models](https://towardsdatascience.com/topic-modelling-in-python-with-spacy-and-gensim-dc8f7748bdbf).

This lemmatization was conducted on the corpus without stopwords, but it's feasible to leave them in, too. Researchers who are interested in counting specific key words, for example, may have no need to get the base words of stopwords. Others may wish to retain them so they have a more comprehensive list of lemmas to work with. It is up to the you to decide what information is most valuable for your purposes. 

## Part of Speech Tagging
The nlp pipeline also enables the tagging of each word according to its part of speech. Since spaCy identifies parts of speech based on the relationships between words in a text, it's important to keep the stopwords in. Further down, you'll see in more detail how their removal can skew spaCy's understanding of grammatical structure. This code will append all parts of speech to a new DataFrame column.
```
#Get part of speech tags
pos_list = []

# Disable Dependency Parser, and NER since all we want is POS 
with nlp.disable_pipes('parser', 'ner'):
  #Iterate through each doc object and tag POS, append POS to list
  for doc in nlp.pipe(enriched_df.Text.astype('unicode').values, batch_size=100):
    word_list = []
    for token in doc:
        word_list.append(token.pos_)
        
    pos_list.append(word_list)

#Make pos list a new column in DataFrame
enriched_df['POS_Tags'] = pos_list
enriched_df['POS_Tags'] = [' '.join(map(str, l)) for l in enriched_df['POS_Tags']]
```

From here, you may want to get only a set of Part of Speech tags for further analysis--all of the proper nouns, for instance.

```
#Get specific subset of part of speech tags
propnoun_list = []

# Disable Dependency Parser, and NER since all we want is POS 
with nlp.disable_pipes('parser', 'ner'):
  #Iterate through each doc object and tag POS, append POS to list
  for doc in nlp.pipe(enriched_df.Text.astype('unicode').values, batch_size=100):
    word_list = []
    for token in doc:
      if token.pos_ == 'PROPN':
        word_list.append(token)
        
    propnoun_list.append(word_list)

#Make pos list a new column in DataFrame
enriched_df['Proper_Nouns'] = propnoun_list
enriched_df['Proper_Nouns'] = [', '.join(map(str, l)) for l in enriched_df['Proper_Nouns']]
```

Check out the dictionary of SpaCy POS tags [here](https://machinelearningknowledge.ai/tutorial-on-spacy-part-of-speech-pos-tagging/#:~:text=Spacy%20POS%20Tags%20List,-Every%20token%20is%20assigned%20a) and feel free to test out the process of retreiving different parts of speech using the code above. 

Closely related to POS tagging is dependency parsing, wherein SpaCy identifies how different segments of a text are related to each other. Once the grammatical structure of each sentence is identified, visualizations can be created to show the connections between different words. Since we are working with large texts, our code will break down each text into sentences (spans) and then create dependency visualizers for each span

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY14.png" caption="Figure 14: Dependency parsing example from one text in corpus (with stopwords)" %}

Here, spaCy has identified relationships between nouns, adjectives, and adverbs in one paper. For example, if you scroll to the dependency parse of the first sentence, the noun "uniformity" is the direct object of the verb "produce" and the nouns "uniformities" and "identities" are modified by adjectives, adverbs, and determiners. 

Dependency parsing makes it easy to see how removing stopwords can impact spaCy's depiction of the grammatical structure of texts. Let's compare to a dependency parsing where stopwords are removed. 

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY15.png" caption="Figure 15: Dependency parsing example from one text in corpus (without stopwords)" %}

In this example, spaCy identified the same adjectives ("unprecedented" and "discrete") as modifying the nouns, but the determiner "the" and adverb "once" have been lost. More drastic is the change relationships between "produce", "uniformities", and "identities." Without stopwords, spaCy identifies "identities" as the direct object of the verb produce, rather than "uniformity." This example demonstrates what can be lost in analysis when stopwords are removed, especially when investigating the relationships between words in a text or corpus. Since part-of-speech tagging and named entity recognition are predicated on understanding relationships between words, it's best to keep stopwords in so spaCy can use all available linguistic units during the tagging process.

Dependency parsing also enables the extraction of larger chunks of text, like noun phrases. Let's try it out:

```
#Get part of speech tags
np_list = []

# Disable Dependency Parser, and NER since all we want is POS 
with nlp.disable_pipes('ner'):
  #Iterate through each doc object and tag POS, append POS to list
  for doc in nlp.pipe(enriched_df.Text_NoStops.astype('unicode').values, batch_size=100):
    word_list = []
    for np in doc.noun_chunks:
      word_list.append(np)
    np_list.append(word_list)

#Make pos list a new column in DataFrame
enriched_df['Text_NounPhrases'] = np_list
enriched_df['Text_NounPhrases'] = [', '.join(map(str, l)) for l in enriched_df['Text_NounPhrases']]
```

Calling the first row in the Text_NounPhrases column will reveal the words spaCy has classified as noun phrases. In this case, spaCy has identified a wide range of nouns and nouns with modifiers. 

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY16.png" caption="Figure 16: List of noun phrases from one text in the corpus" %}

Ultimately, part of speech tagging is another way to reduce dimensionality of the data and identify how language is being used at the lexico-grammatical level. It provides a foundation for Named Entity Recognition, which uses a word's grammatical position as one determinant of whether or not it is a named entity. As you will observe below, the large majority of named entities are nouns and noun phrases (though some are numerals). Further analysis, like topic modeling, may work when only certain parts of speech, [like nouns,](https://aclanthology.org/U15-1013.pdf), are retained. And as we'll explore further below, parts of speech can be used to compare patterns of language use within subsets of a corpora (e.g. texts of different genres and disciplines).


## Named Entity Recognition

Finally, SpaCy can tag “named entities” in your text, such as names, dates, organizations, and locations. Call the full list of named entities and their descriptions using this code: 

{% include figure.html filename="cCORPUS-ANALYSIS-WITH-SPACY17.png" caption="Figure 17: List of spaCy's named entities and their descriptions" %}

To tag the named entities in our corpus, we’ll again call the nlp pipeline on each document in the corpus and append the named entity tags to a new column. 

```
#Get Named Entities
ner_list = []

for doc in nlp.pipe(enriched_df.Text.astype('unicode').values, batch_size=100):
    ent_list = []
    for ent in doc.ents:
        ent_list.append(ent.label_)
    ner_list.append(ent_list)

enriched_df['NER_Tags'] = ner_list
enriched_df['NER_Tags'] = [' '.join(map(str, l)) for l in enriched_df['NER_Tags']]
```

We can add another column with the words and phrases identified as named entities.

```
#Get Named Entity words
ent_w_list = []

for doc in nlp.pipe(enriched_df.Text.astype('unicode').values, batch_size=100):
    ent_w_list.append(doc.ents)

enriched_df['NER_Words'] = ent_w_list
enriched_df['NER_Words'] = [', '.join(map(str, l)) for l in enriched_df['NER_Words']]
```

The resulting DataFrame allows you to see the named entity tags and the words that are associated with those tags. Observe the high counts of DATE, PERSON, and CARDINAL tags, at least in the first few sentences of each document. How frequently these tags are used, and how their use differs between genres, are questions to be explored in the analysis section below.

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY18.png" caption="Figure 18: DataFrame with named enttiy tags and words" %}

SpaCy also allows you to visualize named entities within single texts, as follows:

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY19.png" caption="Figure 19: Visualization of document with named entity tags" %}

Named entity recognition enables researchers to take a closer look at the "real-world objects" that are present in their texts. The rendering allows for close-reading of these entities in context, their distinctions helpfully color-coded. In addition to studying named entities that spaCy automatically recognizees, you can use a training dataset to update the categories or create a new entity category, as in [this example](machinelearningplus.com/nlp/training-custom-ner-model-in-spacy/).

# Analysis of Linguistic Annotations
Why are spaCy's linguistic annotations useful to researchers? Below are two examples of how researchers can use data about the MICUSP corpus, produced through spaCy, to draw conclusions about discipline and genre conventions in student academic writing. 

## Part of Speech Analysis
In this section, we'll analyze the part-of-speech tags extracted by spaCy to answer the first research question: **Do students use certain parts of speech more frequently in Biology papers versus English papers that signify differences in disciplinary conventions?**

To start, we'll create a new DataFrame with the text filenames, disciplines, and part of speech tags. 

spaCy's pipeline includes a way to count the number of each part of speech tag that appears in each document (ex. # times NOUN tag appears in a document, # times VERB tag appears, etc). This is called using ```doc.count_by(spacy.attrs.POS)``` Here's how it works on a single sentence. 

{% include figure.html filename="cCORPUS-ANALYSIS-WITH-SPACY20.png" caption="Figure 20: Part of speech indexing for words in example sentence" %}

The output is a dictionary that lists the unique index of each part of speech and the number of times that part of speech has appeared in the example sentence. To associate the actual parts-of-speech associated with each index, a new dictionary can be created which replaces the index of each part of speech for its label. In the example below, it's now possible to see which parts-of-speech tags correspond to which counts. 

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY21.png" caption="Figure 21: Indexing updated to show part-of-speech labels" %}

To get the same type of dictionary for each text in the DataFrame, a for loop can be created to nest the above process. 

```
#Get part of speech tags
num_list = []

# Disable Dependency Parser, and NER since all we want is POS 
with nlp.disable_pipes('parser', 'ner'):
  #Iterate through each doc object and tag POS, append POS to list
  for doc in nlp.pipe(enriched_df.Text.astype('unicode').values, batch_size=100):
    dictionary = {}
    num_pos = doc.count_by(spacy.attrs.POS)
    for k,v in sorted(num_pos.items()):
      dictionary[doc.vocab[k].text] = v
    num_list.append(dictionary)

pos_counts = pd.DataFrame(num_list)
columns = list(pos_counts.columns)

idx = 0
new_col = pos_analysis_df['DISCIPLINE']
pos_counts.insert(loc=idx, column='DISCIPLINE', value=new_col)
```

The output will be a new DataFrame that includes the discipline of each paper and the frequency of each part of speech as appearing in that paper. If a paper does not contain a particular part-of-speech, the cell will read "NaN" (Not a Number). From here, it's simple to calculate the average number of each part of speech tag that appears in texts per genre by combining the ```groupby``` and ```mean``` functions. The output will be another DataFrame which shows the average part-of-speech use for each category in English and Biology.

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY22.png" caption="Figure 22: DataFrame with average part-of-speech use in English and Biology papers" %}

Now we can examine the differences between parts of speech usage per genre. As suspected, it looks like Biology student papers use slightly more adjectives (17), on average, than English student papers, while an even greater number English papers (48), on average, use more verbs. Another interesting contrast is in the "NUM" tag: almost 50 more tokens, on average, are identified as a numeral in Biology papers than in English ones. Given the conventions of scientific research, this too makes sense; studies are much more frequently quantitative, incorporating lab measurements and statistical calculations. A bar graph can make some of these differences more apparent:

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY23.png" caption="Figure 23: Bar chart depicting average use of adjectives, verbs, and numbers in English and Biology papers" %}

Though admittedly a simple analysis, calculating part-of-speech frequency counts affirms prior studies which posit a correlation between lexico-grammatical features and disciplinary conventions [^2] and indicates an application of spaCy that can be adapted to serve other researchers' corpora and part-of-speech usage queries. spaCy also provides a "fine-grained" tag set that could aid further research--for example, looking at how Biology and English students use sub-groups of verbs with different frequencies. Fine-grain tagging can be deployed in a similar loop to those above; just instead of retrieving the ```token.pos_``` for each word, call spacy to retrieve the ```token.tag_```:

```
#Get part of speech tags
tag_num_list = []

# Disable Dependency Parser, and NER since all we want is POS 
with nlp.disable_pipes('parser', 'ner'):
  #Iterate through each doc object and tag POS, append POS to list
  for doc in nlp.pipe(enriched_df.Text.astype('unicode').values, batch_size=100):
    tag_dictionary = {}
    for token in doc: 
      num_tag = doc.count_by(spacy.attrs.TAG)
      for k,v in sorted(num_tag.items()):
        dictionary[doc.vocab[k].text] = v
      tag_num_list.append(tag_dictionary)

tag_counts = pd.DataFrame(num_list)
columns = list(tag_counts.columns)

idx = 0
new_col = pos_analysis_df['DISCIPLINE']
tag_counts.insert(loc=idx, column='DISCIPLINE', value=new_col)
```

From here, the same type of frequency analysis could be performed on the fine-grained tags. 

The example here is only one of many possible applications for part-of-speech tagging. art-of-speech tagging is also useful for research questions about sentence [intent](https://nostarch.com/download/samples/NLP_Vasiliev_ch2.pdf); the meaning of a text changes depending on whether the past, present, or infinitive form of a particular verb is used. It's valuable for word sense disambiguation and language translation. And of course, part-of-speech tagging is a building block of named entity recogntion, the focus of the analysis below.  

## Named Entity Analysis
In this section, we'll use the named entity tags extracted from spaCy to investigate the second research question: **Do students use certain named entities more frequently in different academic genres that signify differences in genre conventions?** 

To start, we'll create a new DataFrame with the text filenames, genres, and named entity tags. Using the str.count method, we can get counts of a specific named entity used in each text. Let's get the counts of the named entities of interest here (PERSON, ORG, DATE, and CARDINAL (numbers) ) and add them as new columns of the DataFrame. 

```
#Get the number of each type of entity in each paper
person_counts = ner_analysis_df['NER_Tags'].str.count('PERSON')
org_counts = ner_analysis_df['NER_Tags'].str.count('ORG')
date_counts = ner_analysis_df['NER_Tags'].str.count('DATE')
cardinal_counts = ner_analysis_df['NER_Tags'].str.count('CARDINAL')

#Append proper noun counts to new DataFrame 
ner_counts_df = pd.DataFrame()
ner_counts_df['Genre'] = ner_analysis_df["PAPER TYPE"]
ner_counts_df['PERSON_Counts'] = person_counts
ner_counts_df['ORG_Counts'] = org_counts
ner_counts_df['DATE_Counts'] = date_counts
ner_counts_df['CARDINAL_Counts'] = cardinal_counts
```

From here, we can calculate the average usage of each named entity and plot across paper type.

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY24.png" caption="Figure 24: Bar chart depicting average use of Person, Org, Date, and Cardinal named entities in English and Biology papers" %}

As hypothesized, the most dates and numbers are used in description-heavy proposals and research papers, while more people are referenced in critiques and evaluations. Interestingly, organizations are most invoked in proposals. Considering that spaCy defines ORG entities as companies, organizations, and institutions, this may still make sense in the context of research proposals, which involve putting forward a research question and justifying a study. Students thus may be making references to prior scholarship and institutions which have significance to new study. 

To explore this phenomenon further, retrieve the words tagged as this entity in each document. 

```
#Get Named Entity words
date_w_list = []

for doc in nlp.pipe(enriched_df.Text.astype('unicode').values, batch_size=100):
    ent_list = []
    for ent in doc.ents:
        if ent.label_ == 'DATE':
            ent_list.append(ent.text)
        date_w_list.append(ent_list)

ner_analysis_df['DATE_Words'] = date_w_list
ner_analysis_df['DATE_Words'] = [', '.join(map(str, l)) for l in ner_analysis_df['DATE_Words']]
```

Now retrieve only the subset of essays that are in the proposal genre and get the top words that have been tagged as "DATE in these essays and append them to a list. The majority are standard 4-digit dates, as well as an instance of 'al'; though further analysis is certainly needed to confirm, these date entities seem to indicate citation references are occuring; this fits in with the expectations of the genre, which require references to prior scholarship to justify the student's proposed claim.

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY25.png" caption="Figure 25: Top 10 words identified as dates in Proposals papers" %}

Let's contrast this with the top "DATE" entities in Critique/Evaluation papers. 

{% include figure.html filename="CORPUS-ANALYSIS-WITH-SPACY26.png" caption="Figure 26: Top 10 words identified as dates in Critique/Evaluation papers" %}

Here, only three of the top dates tagged are words, and the rest are noun references to relative dates or periods. This too may indicate genre conventions such as providing context and/or centering an argument in relative space and time. Future research could analyze chains of named entities (and parts of speech) to get a better understanding of how these features work together to indicate larger rhetorical efforts. 

# 6. Download Enriched Dataset

To wrap up, download the DataFrame with the enriched versions of the text. 
```
enriched_df.to_csv('enriched_dataset.csv') 
```

Again, you will need an additional step to download the file to your machine if you are working in Google Colab.

```
files.download('enriched_dataset.csv')
```

# Conclusions
Through this tutorial, we've gleaned more information about the grammatical makeup of a text corpus. Such information can be valuable to researchers who are seeking to understand differences between texts in their corpus - for example, **what types of named entities are most common across the corpus? How frequently are certain words used as nouns vs. objects within individual texts and corpora, and what may this reveal about the content or themes of the texts themselves?** 

SpaCy is also a helpful tool to explore texts without fully-formed research questions in mind. Exploring linguistic annotations like those mentioned above can propel further questions and text-mining pipelines, like the following: 
*   [Getting Started with Topic Modeling and Mallet (Graham, Weingart, and Milligan, 2012)](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet#what-is-topic-modeling-and-for-whom-is-this-useful) - Describes process of conducting topic modeling on a corpora; the SpaCy tutorial can serve as a preliminary step to clean and explore data to be used in topic modeling
*   [Sentiment Analysis for Exploratory Data Analysis (Saldaña, 2018)](https://programminghistorian.org/en/lessons/sentiment-analysis#calculate-sentiment-for-a-paragraph) - Describes how to conduct sentiment analysis using NLTK; the SpaCy tutorial provides alternative methods of pre-processing and exploration of entities that may become relevant in sentiment analysis 

Ultimately, this tutorial provides a foundation for corpus analysis  with spaCy. Whether you wish to investigate language use in student essays, novels, or another large collection of texts, this code can be repurposed for your use. 


# Endnotes 
1. Matthew Brooke O'Donnell and Ute Römer, "From student hard drive to web corpus (part 2): The annotation and online distribution of the Michigan Corpus of Upper-level Student Papers (MICUSP)," *Corpora* 7, no. 1 (2012): 1–18.  https://doi.org/10.3366/cor.2012.0015

2. Jack Hardy and Ute Römer, "Revealing disciplinary variation in student writing: A multi-dimensional analysis of the Michigan Corpus of Upper-level Student Papers (MICUSP)," *Corpora* 8, no. 2 (2013): 183–207. https://doi.org/10.3366/cor.2013.0040

3. Laura Aull, "Linguistic Markers of Stance and Genre in Upper-Level Student Writing," *Written Communication* 36, no. 2 (2019): 267–295. https://doi.org/10.1177/0741088318819472

4. Sugene Kim, "‘Two rules are at play when it comes to none ’: A corpus-based analysis of singular versus plural none: Most grammar books say that the number of the indefinite pronoun none depends on formality level; corpus findings show otherwise," *English Today* 34, no. 3 (2018): 50–56. https://doi.org/10.1017/S0266078417000554

5. Carol Berkenkotter and Thomas Huckin, *Genre knowledge in disciplinary communication: Cognition/culture/power,* (Lawrence Erlbaum Associates, Inc., 1995).

6. Ute Römer and Matthew Brooke O’Donnell, "From student hard drive to web corpus (part 1): The design, compilation and genre classification of the Michigan Corpus of Upper-level Student Papers (MICUSP)," *Corpora* 6, no. 2 (2011): 159–177. https://doi.org/10.3366/cor.2011.0011
