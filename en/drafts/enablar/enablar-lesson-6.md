---
title: "Enriching Archival Metadata for People Discovery"
slug: enablar-lesson-6
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Kirsty Edginton
- Felix Vanden Borre
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket:
difficulty:
activity:
topics:
abstract: Short abstract of this lesson
avatar_alt:
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

<!-- NOTE TO ENABLAR AUTHORS 
Note 1: The YAML + Table of Contents Include above are formatted according to our local requirements and should remain in place.

You can edit the title: "Enriching Archival Metadata for People Discovery" (line 2), and add your names into the `authors:` field.

You can also write an `abstract:` to replace the placeholder text 'Short abstract of this lesson'.

All other lines contain controlled fields so we'll return to complete these together at the end of the drafting process.
-->

<!-- NOTE TO ENABLAR AUTHORS 
Note 2: I've included a suggested table of contents, including main sections and sub-sections, based on the Lesson Framework.

You can adjust as needed, but I'd like you to keep this recommended structure in mind.
-->

<!-- NOTE TO ENABLAR AUTHORS
Note 3: Please write the lesson in Markdown.

If you are new to Markdown, I often recommend Sarah Simpkin’s lesson *Getting Started with Markdown* <https://doi.org/10.46430/phen0046>. It is available in French, Spanish, and Portuguese as well as English. Although it does not exactly match the way we structure Markdown in _Programming Historian_ lessons (there are many valid Markdown styles), it provides a useful introduction.

As you begin drafting your lesson, here are five basic Markdown conventions we use in _Programming Historian_ lessons.

a. **Bold**: formatted using **double asterisks**. We use bold text to help readers navigate interfaces or workspaces. This includes:
* Menu items (e.g. in a dropdown)
* Tab or window names
* Column headings (e.g. in a spreadsheet)
* Labelled categories (e.g. in a dataset)

b. *Italics*: formatted using *single asterisks* or _single underscores_. These are used primarily to indicate:
* a keystroke or button that generates an action (e.g. *Enter*, *Run*)
* a term extracted from a dataset, usually for textual analysis
* titles of books, plays, films, TV programmes, paintings, songs, or albums

c. `Code`: written in raw format so that readers can copy, paste, adapt, and reuse it.
* To create inline code, use single backticks ` before and after the word or snippet you want to display as code.
* To create code blocks, use three backticks ``` above and three backticks below the block you want to display.

d. Links: formatted using square brackets around the text to display and round brackets around the link.

* To create an external link, write: [The Architectural Association](https://www.aaschool.ac.uk/)
* To create an internal link (to a page on Programming Historian’s website, or to a file in our repository), use relative links that begin with the directory path, for example: [Introduction to the Principles of Linked Open Data](/en/lessons/intro-to-linked-data) rather than [Introduction to the Principles of Linked Open Data](https://programminghistorian.org/en/lessons/intro-to-linked-data
* To create a link to a specific section of your lesson (or another lesson), add a # followed by the section name: [RDF and data formats](/en/lessons/intro-to-linked-data#rdf-and-data-formats)
    * Spaces are replaced with hyphens: [Unfiltered Frequencies](#unfiltered-frequencies)
    * Apostrophes are removed: [Qu’est-ce que dplyr ?](#quest-ce-que-dplyr)
    * Where section names include punctuation marks, omit them: [Linked open data: what is it?](/en/lessons/intro-to-linked-data#linked-open-data-what-is-it)

e. Figures and sample data assets can be added later in the drafting process. For now, simply add a placeholder where you expect a figure to appear:
[Figure 1]
-->

<!-- NOTE TO ENABLAR AUTHORS
Note 4. Endnotes

Use endnotes to provide additional context or citations.

- Insert an endnote marker in the text using:
  [^1]

- At the end of the document, add a corresponding entry:
  [^1]: Your endnote text here.

- List all endnotes under a dedicated section at the end of the file:

## Endnotes
[^1]: First note  
[^2]: Second note  
-->

<!-- NOTE TO ENABLAR AUTHORS
Note 5. References

Format all references using the Chicago Manual of Style.

- Follow this guide:
  https://www.chicagomanualofstyle.org/tools_citationguide/citation-guide-1.html

- Additional help:
  https://subjectguides.york.ac.uk/referencing-style-guides/chicago
-->

## Preliminaries

### Lesson Overview
This lesson details how to conduct Named Entity Recognition (NER) using spaCy on PDF documents and then connect the named entities to Wikidata authority files to enhance metadata and people discovery in library and archive catalogues.

#### General context
An ever increasing amount of material available to librarians and researchers are digitised or born-digital. The sheer quantity of such material can be hard to efficiently manage.  Traditionally, items such as journals or runs of newsletters are catalogued under one record. The rise of digital asset management platforms and digital archives brings an opportunity to record each instance of an item as a separate metadata record, as each issue has a corresponding file that can be directly linked to. 

However, creating and enhancing metadata for large numbers of digital records can be time-consuming, particularly when their content, such as named individuals, need to be manually identified. Consequently, many libraries and archives choose not to add this level of detail to their metadata, leaving researchers relying on either full text searches, if available, or requiring them to read multiple documents to find the person they are looking for. 

Where full text search is available, documents such as newsletters often refer to the same person in multiple ways, making it difficult to search records consistently. Collections can also contain multiple people with the same name, and users may not have the context to verify which individual is being referred to. 

This is where Named Entity Recognition (NER) and linked data can help. Natural Language Processing is the branch of artificial intelligence which concerns itself with the processing of natural (i.e. human) language. Named Entity Recognition is a subset of Natural Language Processing which focuses on identifying named entities (people, organisations, places, currencies, etc) through machine-learning algorithms. By deploying NER on a dataset, we can rapidly identify points of interest. 

### Linked Data and Authority files
Linked Data can be used to map the entity identified by NER to an authority file, which verifies who the entity is and creates consistency when referring to them in the metadata. This increases the discoverability of the collection; users can search for any version of a name and retrieve all linked references to that entity and do not have to rely on full text searches. Researchers can also track the activities of named entities across the catalogue and can create data visualisations and knowledge maps with the linked data. 

Jonathan Blaney’s lesson provides a comprehensive [introduction to linked data](https://programminghistorian.org/en/lessons/intro-to-linked-data). For the purposes of this lesson, you only need to know that a named entity can be linked to an authority file.

An authority file is a list of established named entities and helps to control and standardise how names (and other vocabularies) are used, so that people, places, objects, and concepts can be represented consistently across records. If the authority file supports linked data each named entity within the file will have a persistent identifier in the form of a URI, this is what is added to the cataloging metadata. 

There are many authority files in existence, when choosing the appropriate file for your collection you might ask the following questions: 

### What kind of named entities are you trying to standardise? 

For the purposes of this lesson we are looking at people as named entities, but you can also use NER and authority files for corporations, objects, places and subjects. Defining what you are identifying can help you search for the appropriate authority file. For example if you are trying to control artworks you could use the [Cultural Obejcts Name Authority](https://en.wikipedia.org/wiki/Cultural_Objects_Name_Authority). If you are looking at a range of entity types you might wish to select a broader authority file such as Wikidata. 

Within a category of linked data you may also find varying classes, for example when looking at people your collection might refer mainly to academic researchers who often have a record in the ORCID authority file. If your collection contains mainly book authors and historical figures the Library of Congress Name Authority file might be appropriate. 

### Are you aiming to improve consistency within your own collection, or do you want interoperability with other systems and datasets?

For the purposes of linked data and interoperability your  authority file will need to support persistent identifiers with URI’s, however if you are solely looking to create consistency across your collection you could use traditional cataloging standards such as Library of Congress Subject Headings terms in a MARC format, or create your own local authority records. 

Wikidata and VIAF are two common authority platforms with URI's, but you will often find older authority files such as the Library of Congress Subject Headings now have persistent identifiers. 

### Are you focusing on a specific subject area? 

When a collection is centered on a specific discipline or domain, you may also find subject specific authority files. For example, for this lesson we  considered using the AHRnet Biographical Dictionary of British and Irish Architects, but found it was too UK centric for our collection which features global contributors. 

Once you have identified potential authority files, it is useful to take a sample of the named entities in your collection and test how many appear in the files. The acceptable rate of appearance will depend on your collection.

### Social context - Archival Silences

Archival silences are often described as gaps, omissions and distortions in the historical record. Methods used in this lesson have the potential to perpetuate these archival silences. NER is not a completely accurate task. Even the best Natural Language Processing models struggle at surpassing 95% accuracy when it comes to recognising named entities. (cite) This percentage significantly decreases when working with underrepresented languages. (cite) 

Consequently, when parsing a body of text with NER, there is a high probability some names will be missed by the model, and that the names which are not identified are more likely to belong to groups which are underrepresented in the data models are trained on. Employing this method without review can therefore amplify archival silences by omitting people from the metadata.

Secondly, authority files are often limited in their scope. Groups which were historically valued occupy a disproportionate amount of entries. Take Wikidata for example, where as of 2025 entities categorised as women made up 19.03% of all entries and ‘Other Gender’ entries totaled less than 1%. As a result, entities which are not featured in authority files continue to be under-discovered in collections utilizing linked data, as they are less likely to be recognised, linked, and surfaced through search and browse interfaces. It also excludes the entities from being connected to associated research and other platforms using linked data.

When approaching this task keep these risks in mind and try to mitigate the impact where possible. For example, if your named entities are not appearing in an authority file, there are a few approaches you can take. 

- You might choose to use two or more authority files if they have different areas of coverage. Consider the following if taking this approach: Will you prioritise one authority file over another if the named entity appears in both? If you chose to use several persistent identifiers in a record how can you verify they refer to the same entity? 

- You could create local authority files for those missed in the linked data. While this will not contribute to the interoperability of the collection it will create consistency which will be helpful to users when searching. 

- Depending on the authority file, you could add the missing named entities. For example, anyone can create an account on Wikidata and add new entries (link to explanation). This can take time but also helps address archival silences. 

You might also want to acknowledge the limitations of the linked data method to users and encourage them to report any errors or inconsistencies. 


## Technical background

### Software/tool

We will be exploring the use of three Python libraries for the purpose of this lesson: pdfplumber, spaCy, and requests. Each of these will be used for a specific step towards our final goal, namely augmenting our materials’ metadata for people discovery. 
- pdfplumber will serve to extract computer-legible text from the PDFs that form our dataset.
- spaCy will then allow us to identify named entities, specifically people, in these PDFs.
- The ‘requests’ library will let us search the entities identified via NER against authority files through Wikidata’s API.

### Prerequisites

The ability to read Python code, as well as a prior understanding of basic Python concepts such as variables and functions is required for this lesson. Familiarity with the spreadsheet-management library Pandas is helpful too, but not essential. 

This lesson will focus on 1) extracting text from PDFs, 2) applying the Natural Language Processing method known as Named Entity Recognition (NER) to this data to identify individuals and 3) checking these individuals against authority files using the WikiData API. 

### Time

Working through this lesson will take about 30 minutes.

### Key Concepts and Terms
- Archival discovery
- Named Entity Recognition
- Authority Files
- API

### Inventory

dataset: seventeen newsletters from the Architectural Association, either in PDF format or .txt files.
python libraries: spaCy (and large english model), requests, pdfplumber, pandas.

### Difficulty

This level of difficulty for this lesson is low, although beginners might find it useful to consult additional documentation on Python functions, APIs, and SPARQL. 

## Use Case

This Lesson will look at a case study of the Architectural Association School of Architecture’s weekly newsletter, or AA Weekly for short. The newsletter has been published weekly during term time since 1973, roughly 32 newsletters a year. Between 1973 and 2017 they were published as physical pamphlets. Since 2017 they have been delivered by email. 

The newsletters detail the weekly programme of events at the school, including talks and workshops given by tutors, students and guest speakers. The collection is used by researchers to track the speakers, themes and topics discussed at the school and how these talks and collaborations have influenced or reflect wider trends in the sector.

Seventeen newsletters have been selected for this lesson and have been converted into PDF’s from the original email format. This number is deliberately small. As we will see, processing this number of newsletters with NER produces a large dataset of names, not all of which are true names that can be matched accurately to an authority file. As such it is essential to be able to manually verify results. Therefore it is a good idea to split your own data into more manageable components. 

As born digital records these newsletters already contain machine readable text, so no OCR is needed. For guidance on performing OCR please see the Programming Historian lesson [here](https://programminghistorian.org/en/lessons/ocr-with-google-vision-and-tesseract). 

### Environment

We advise following this lesson in a Jupyter notebook. This helps segment the different parts of the code and makes it easier to verify results. If you are not familiar with Jupiter notebook you can use the [Programming Historian introduction](https://programminghistorian.org/en/lessons/jupyter-notebooks)
 
You can also run the code in your own Python environment if you prefer.

### Step 1: pdfplumber

_This first step is optional. Feel free to skip it and directly refer to the next step if you already have text files or are using the text files uploaded with this lesson._

When working with PDF’s, we need to obtain text data before we can process it using NER. PDFs are ubiquitous in today’s publishing landscape, thankfully this means there are plenty of ways to extract their text with a bit of code. 
 
You will need to download the following python libraries if you do not already have them.
 
**Pdfplumber**
> This library allows you to load PDFs and mine their text by creating a “pdfplumber.PDF” class. This class is a list of “pdfplumber.Page” objects, where every object corresponds to one page of a PDF. Each object contains only the text of a pdf and creates a .txt file.

**Pandas**
>Pandas is a Python library for data management. It essentially allows the manipulation of data in a tabular format (aka spreadsheets), known as DataFrames. This makes it easy to apply a wide range of operations on our data. 

**Path**
> Path is used to create a file location that can be read and verified by Python. Replaces the need for the location to be represented as a string of text which can be unstable.

You can install the libraries by either using ```pip install {insert library name}``` in your terminal or ```!pip install {insert library name}``` if working in a Jupyter Notebook.
 
Then you will need to load them running the following command.

```
import pdfplumber
import pandas as pd
from pathlib import Path
```
Let’s start by loading the names of all the files in our data folder. To do so, we will create a function that allows us to grab all files that end in “.pdf” thanks to the “Path” method of the “pathlib” library. We create an empty list called “files” to which we append the pathname of all relevant files by  using the “.glob()” method to extract all files than end in “.pdf” (the * sign is a wild card).

```
#function to get all pdf files in a directory
def get_pdfs(dir): #dir refers to directory
   files = [] 
   for path in Path(dir).glob("*.pdf"): #the asterisk * is a wildcard, meaning what comes before the file extension does not matter
       files.append(path)
   return files
```
We can save all the relevant file names with this function. Let’s do so under the “aa_files” variable. 

```
aa_files = get_pdfs("AA_Weekly_data")
```

We have loaded the names of each file but  need an additional function to be able to pull the text data from the PDFs into a usable format. The following function has two components to it: we mine the text of each PDF and then append that text data to a pandas Dataframe. 

Let’s break this down, starting with mining the PDFs. As mentioned earlier, pdfplumber treats each page of a PDF as a separate object. We therefore need to combine all these separate text strings into one.

```
with pdfplumber.open(doc) as pdf:
           full_text = []
           for page in pdf.pages:
               text = page.extract_text()
               if text:
                   full_text.append(text)
           combined_pdf = " ".join(full_text)
```

The first line loads a given pdf file, which we iterate over to extract the textual data for each page and save it into the “text” variable. This data is then appended (added) to an empty list called “full_text”. 

At this stage, the text from the different pages of the PDF are stored in the full_text list. The “.join()” method lets us combine these individual text strings into one long string. Each of the previous individual text strings is separated by a whitespace in the new single long string, essentially recreating the PDF’s text. 

This demonstrates how we can extract text from a single PDF file with pdfplumber. However, we need to repeat this process for each file in our folder. This can potentially create a lot of data, making it hard to keep track of what we are working with. For this reason, we will add each PDF’s extracted text in the form of a long string to a row in a DataFrame with a corresponding row for the file name so that we can keep track of which document each text string belongs to.

For this reason, we will iterate over each PDF file and output their respective textual data into an empty “rows” list, which we then turn into a DataFrame using pandas. Let’s do this in a function, expanding on the example pdfplumber script above. Here, “file_name” and “text” correspond to the two columns of the DataFrame we are creating. 

```
# function to extract text from pdf
def pdf_to_df(files):
   rows = []
   for doc in files:
       with pdfplumber.open(doc) as pdf:
           full_text = []
           for page in pdf.pages:
               text = page.extract_text()
               if text:
                   full_text.append(text)
           combined_pdf = " ".join(full_text)
       #append to rows and use Path to only keep the file name
       rows.append({"file_name": Path(doc).name, "text": combined_pdf})
   df = pd.DataFrame(rows)
   return df

```

Now let’s simply apply this function to the “aa_files” variable. We can print the contents of the “text” column to verify it has worked. 

```
aa_files_data = pdf_to_df(aa_files)
print(aa_files_data[“text”])
```

#### Step 2: NER 

We now have text we can process with NER (if you skipped the pdfplumber step, you can load the text data into a DataFrame and resume the lesson from here). There are tonnes of different ways to approach NER, but the spaCy library stands out for the number of languages it supports and its easy-to-approach syntax.

If this is your first time using spaCy, you need to pip install the library as well as download the model you want to use. In this lesson, we will be using their large English-language model. You can install both the library and the model in terminal with the following commands, or directly in your notebook by adding an exclamation mark “!” before the commands.

```
pip install -U spacy
python -m spacy download en_core_web_lg
```
Once installed, let’s  load both the library and the model into our script. 
```
import spacy
```
```
#load spacy moodel
nlp = spacy.load("en_core_web_lg")
```

This “nlp” variable will allow us to call the model on our data. spaCy processes texts and outputs a “doc” object which contains various kinds of metadata such as the entities it picked up, the labels of those entities (whether they are people, places, and so forth) and where these entities are located in text. We can access this information through the doc.ents object. People working with NER are often interested in knowing what kinds of entities each string of text represents, and where these entities are located. They therefore usually adopt the following syntax.

```
entities = []


for ent in doc.ents:
   entities.append({
       "text": ent.text.strip(),
       "start_character": ent.start_char,
       "end_character": ent.end_char,
       "label": ent.label_
   })
```

For our purpose however, all we need is to have the names of people, who appear within the text. Let’s define a new function to apply the large english model to text and return a list of all PERSON entities found within said text by iterating over each entity in doc.ents.
```
#ner function
def run_ner(text, nlp): #arguments are text and the nlp model
   entities = []


   doc = nlp(text)#creating a doc object
   for ent in doc.ents: 
       if ent.label_ == "PERSON": #keeping only PERSON entities and appending it to our entities list
           entities.append(
           ent.text.strip()
           )#.strip() gets rid of leading or trailing whitespace


   return entities
```

Now, let’s create a new row in our DataFrane named “entities” which we will populate with the entities that appear in the text that we mined for each file. Using the .apply() function and lambda, we can apply our run_ner function on every row in the “text” column of our dataframe. 

```
#entities code
aa_files_data["entities"] = aa_files_data["text"].apply(lambda x: run_ner_df(x, nlp))

```
Try printing out the entities extracted from the first row to verify that it has worked. 

```
print[aa_files_data][“entities’][0]
```

### Step 3: Prepare Data for Authority Matching

As of now, we have a DataFrame with our file names, the text we extracted from these files, and the entities we extracted from each text. We can now get the NER entities ready for matching against the authority files. This will be done in two steps: deduplication and cleaning.

It would be inefficient to match every single NER result to an authority record. You will likely find that some of the entities appear multiple times in your collection, so we need to deduplicate the result as best we can. 

Currently, all person entities identified by the NER model for a given PDF are stored in a single cell in the row corresponding to that PDF's text file, making it difficult to process or analyse individual entities. pandas, thankfully, has a nifty method called .explode() which lets you unpack lists so that each object gets its own row.

Here we have created a new DataFrame called aa_data_explode, which will transform the DataFrame aa_files_data to give each entity its own row. 

```
aa_data_exploded = aa_files_data.explode("entities")
```
We can then group this new dataframe by the values contained in the “entities” column. This grouping gets rid of duplicate entities. 
```
#group ner column
aa_data_deduped = (
   aa_data_exploded.groupby("entities", as_index=False)
   .agg(source_files=("file_name", lambda x: "; ".join(sorted(x.unique()))))
)
```
We want to make sure that we can trace back the files in which each entity appears. Since an entity can appear across multiple files, it is important that we keep track of it. .agg() stands for aggregate, so we are aggregating all file names, separating them by a semi-colon, and getting rid of duplicate file names.

Do keep in mind that doing this, you risk getting rid of entities that are not true duplicates. If your data mentions two individuals named “John Smith”, this step will delete one of them. 

If we have a look at our aa_data_deduped DataFrame, we can see that we have 261 unique entities. However, some NER errors appear. Some names were for example grabbed as single tokens, such as the first names Alain or Adam. If we tried to match these against architects in Wikidata, it is very unlikely that a positive result would be returned. 

We also see that several entities have been identified as people, when they seem to be a mix of people and dates such as “Andreas THU 24”. Finally, a number of entities contain the string “AA” - which simply is a quirk from our data, as Architectural Association is abbreviated to AA everywhere! Before using your data you will want to check to see if there are any patterns like this that can be excluded. 

We can clean these very easily with the following bit of code.

```
#keep only rows with multiple token names (no space = one word)
aa_data_deduped = aa_data_deduped[aa_data_deduped["entities"].str.contains(" ")]


#use regex and a mask “~” to get rid of rows containing any digits
aa_data_deduped = aa_data_deduped[~aa_data_deduped["entities"].str.contains(r"\d")]


# use a mask “~” to get rid of rows containing "AA" aa_data_deduped = aa_data_deduped[~aa_data_deduped["entities"].str.contains("AA")]
```
Even after cleaning the data it is unlikely you will have a perfect set of names with no duplications. This step helps you efficiently remove some results, but you may wish to perform a manual check here to see if there are any names which have been abbreviated or spelt differently across your dataset. This is where working in smaller batches helps. For this data set we chose to check the names after matching to the authority file to increase the likelihood of matching them to an authority record. 

After all this work we have a spreadsheet of names. But how do we access these people’s authority files if they exist? We will do so using Wikidata’s API through the ‘requests’ library.

An Application Programming Interface or API is a way for one computer to query another computer or computer programme for data or a particular action. Most web APIs work over HTTP, which is the protocol your browser uses to load web pages. When using an API, you send a specific request to a given URL in order to get a structured response back.

A helpful analogy to understanding APIs is like ordering food. You don’t go into the restaurant’s kitchen and cook it yourself. Instead, you look at the menu and place a specific order, which the kitchen then sends over. 

requests is a Python library which allows you to send HTTP requests straight from your code. This means that the library can be used to make API calls. We can hence use it to match our list of names against presumed architects in Wikidata in the hopes of getting structured responses back.

To return to our analogy, Wikidata is the kitchen, our spreadsheet of names is a list of orders, and the API is the waiter. If your order is not on the menu (you try ordering sushi from a pizzeria, or ask Wikidata’s API to find an architect who does not exist in its graph database), then you will likely get an error.

First, we need to load the requests library as well as the time library, which will allow us to space our API calls over some  time to [not overload the Wikidata servers](https://www.mediawiki.org/wiki/API:Etiquette).

```
import requests
import time
```

Then, we need to define the URL we will be querying (Wikidata’s API) and the [SPARQL](https://en.wikipedia.org/wiki/SPARQL) endpoint. SPARQL is a query language for retrieving data structured in a graph format. Since [Wikidata](https://en.wikipedia.org/wiki/Wikidata) is a knowledge graph, we need to use SPARQL to access its data as non SPARQL queries cannot navigate this graph structure. Finally, we need to define a User-Agent header (which is [mandatory](https://foundation.wikimedia.org/wiki/Policy:Wikimedia_Foundation_User-Agent_Policy) in order to use Wikidata’s API).

```
WIKIDATA_API = "https://www.wikidata.org/w/api.php"
SPARQL_ENDPOINT = "https://query.wikidata.org/sparql"
HEADERS = {"User-Agent": "ArchitectNER/1.0 (programminghistorian)"}  # required by Wikimedia; insert name of your own project here if you like
```

You may have noticed these variables are upper cased. This is because they are constants; their value will not be changed further down the line. It is good practice to differentiate variables from constants in Python by upper casing them.
The requests we want to make to Wikidata’s API are complex. We want to:
1. identify if there is a match on Wikidata against a given name in our spreadsheet,
2. identify if this match is an architect,
3. extract information about this match if it is an architect,
4. and not discard negative results to check them manually.

As we outlined earlier, there is a risk of perpetuating archival silences by ignoring negative results. Where automatic identification is not successful, we can check those entities manually.

Since our requests are complex, it is best to break it down into different functions. Let’s start with a function to search for and return names across Wikidata, which will naturally take a name as its argument.

```
def search_wikidata_label(name):
   params = {#specify the parameters of the search
       "action": "wbsearchentities",
       "search": name,
       "language": "en",
       "type": "item",
       "limit": 5,
       "format": "json",
   }
   response = requests.get(WIKIDATA_API, params=params, headers=HEADERS)
   response.raise_for_status()
   return response.json().get("search", []) #converts the json result into a Python dictionary
```

The key-value pairs in the “params” variable are the [parameters](https://www.wikidata.org/w/api.php) for the search. Each fulfils a specific purpose in our search:
- action: tells the API to use the entity search feature
- search: tells the API what to search for (the name)
- language: tells the API to search through English-language labels
- type: tells the API to only return Wikidata “[items[(https://www.wikidata.org/wiki/Help:Items)”  (which are used to represent things, including humans)
- limit: tells the API to return a maximum of 5 candidates for the search. You can play around with this number; a lower limit will execute faster but might mean you miss some matches.
- format: tells the API to return the data in JSON format (which is recommended but [other data formats](https://www.mediawiki.org/wiki/API:Data_formats) are available).

In the next line of code, requests.get() sends the API request to Wikidata along with the parameters of the request and the request headers. The result is stored in the response variable. Using raise_for_status() will return an error if something went wrong instead of letting the code continue.

To summarise, this first function checks for a given name on Wikidata and returns up to 5 possible matches. A whole lot of information is returned for each of the possible matches, but the most important ones are the label value and the QID.

The [QID](https://www.wikidata.org/wiki/Q43649390)  is a unique identifier used in Wikidata. This can be used to further query the Knowledge Graph. The label value, on the other hand, is typically a name - much easier for a human to read!

Let’s write a second function to use the QID to query Wikidata again and try to get more data about our matches. A Wikidata item, aside from its QID, is often represented with other Linked Data such as VIAF as well as other authority file values, such as occupation, gender, family, and the like.

We are specifically interested in occupation (whether one of our Named Entities is an architect or in a related discipline) and Linked Data (for further metadata enrichment). To get this information, we are going to build a SPARQL query. This query will take the form of an f-string into which we will insert the QID. The text after SELECT tells Wikidata what we are looking for; OPTIONAL means “grab it if it’s there, but don’t worry if not”.

After using requests to perform our query, we will check the results to keep only those which are related to the field of architecture. If a match is identified, we will return the relevant data in a dictionary format. Else, we will simply return an empty (None) result. We will then return all results in a structured format.

```
def get_architect_details(qid):
#this function takes an individual QID as its argument
#the following is an f-string, a type of string which allows us to insert variables between {}
   query = f"""
   SELECT ?occupation ?occupationLabel ?ulan ?viaf ?lcnaf ?gnd WHERE {{
     OPTIONAL {{ wd:{qid} wdt:P106 ?occupation. }}
     OPTIONAL {{ wd:{qid} wdt:P245 ?ulan. }}
     OPTIONAL {{ wd:{qid} wdt:P214 ?viaf. }}
     OPTIONAL {{ wd:{qid} wdt:P244 ?lcnaf. }}
     OPTIONAL {{ wd:{qid} wdt:P227 ?gnd. }}
     SERVICE wikibase:label {{
       bd:serviceParam wikibase:language "en".
     }}
   }}
   """
   response = requests.get(
       SPARQL_ENDPOINT,
       params={"query": query, "format": "json"},
       headers=HEADERS,
   )
   response.raise_for_status()
   results = response.json()["results"]["bindings"]


   if not results:
       return None


   #the following checks for any architecture-adjacent occupations with a boolean operation
   arch_occupations = {
       "architect", "urban planner", "landscape architect",
       "architectural historian", "interior designer", "urban designer"
   }
   occupations = {
       r["occupationLabel"]["value"].lower()
       for r in results if "occupationLabel" in r
   }
   is_architect = bool(occupations & arch_occupations)


   #this is a nested function to help us get the identifiers we are looking for. Since the query can return multiple rows, the same ID might appear repeated across rows, or only show up in one of them. This function let’s us keep only the first one
   def first_val(key):
       for r in results:
           if key in r:
               return r[key]["value"]
       return None


   return {
       "qid": qid,
       "occupations": ", ".join(occupations),
       "is_architect": is_architect,
       "ulan": first_val("ulan"),
       "viaf": first_val("viaf"),
       "lcnaf": first_val("lcnaf"),
       "gnd": first_val("gnd"),
   }
```

To summarise, this function asks Wikidata detailed questions about a given entity using their QID, checks whether the entity looks like an architect based on its listed occupations, and combines the relevant identifiers into a single dictionary.

We now have a function to scan Wikidata for a QID given a name, and a function that grabs additional information based on a QID. What we need now is a function that ties these together and organises our NER results to display whether a match to an architect in Wikidata has been found. 

This will split our entities into three potential results: no match in Wikidata, a match to an architect, a match but not to an architect. 

```
  def match_entity_to_wikidata(name):
#apply the wikidata search to the name
   candidates = search_wikidata_label(name)
#if there are no matches, return “no_match”
   if not candidates:
       return {"entity": name, "match_type": "no_match"}


 #try each candidatea and return the first confirmed architect
   for candidate in candidates:
       qid = candidate["id"]
       label = candidate["label"]
       description = candidate.get("description", "")
       details = get_architect_details(qid)
#if get_architect_details identifies an architect, this returns the data
       if details and details["is_architect"]:
           return {
               "entity": name,
               "match_type": "architect",
               "wikidata_label": label,
               "wikidata_description": description,
               "qid": qid,
               "wikidata_url": f"https://www.wikidata.org/wiki/{qid}",
               **{k: details[k] for k in ("occupations", "ulan", "viaf", "lcnaf", "gnd")},
           }


   #if no architect is confirmed, then the top candidate gets returned for manual review
   top = candidates[0]
   return {
       "entity": name,
       "match_type": "unconfirmed_top_candidate",
       "wikidata_label": top["label"],
       "wikidata_description": top.get("description", ""),
       "qid": top["id"],
       "wikidata_url": f"https://www.wikidata.org/wiki/{top['id']}",
       "occupations": None, "ulan": None, "viaf": None, "lcnaf": None, "gnd": None,
   }

```

Together, these functions work as a pipeline that takes a list of names and looks each one up in Wikidata, returning structured information about who they are and where they appear in other authority files.

Now we need to run it, for which we will write a final function to take the data from our DataFrame and output it into a new DataFrame (which can then easily be exported to CSV, Excel, and the like). 

This final function takes the argument “people”, which will be the DataFrame column with our named entities. We will first create an empty list called “results” before iterating over each name (row) in people. For every name, we will apply our function match_entity_to_wikidata() and append the output to “results”. Then, we use the time library to interrupt the for loop for one second in between each name in order not to overload the WikiData servers with our API calls. Finally, we return the list “results” as a DataFrame.

```
def match_entities(people):
   results = []
  
   for name in people:
       search = match_entity_to_wikidata(name)
       results.append(search)
       time.sleep(1)


   return pd.DataFrame(results)
```
All there is left to do is to run the function on the “entities” column of our aa_data_deduped DataFrame and save the new DataFrame under a new variable, in this case “aa_matched”..
```
aa_matched = match_entities(aa_data_deduped["entities"])
```

> NB: you might get an Error 502 message running this code. This likely means something is off with the Wikidata servers. Just run the code again until it works. You might need a bit of patience.

Finally, you will perform manual checks on the data. For this lesson we checked the dates the WikiData name authority was active, if that information was available, and whether that matched the dates of the activities listed in AA weekly. If you choose not to narrow your results by profession, for example Architect, because your collection spans multiple subjects, you can examine the context in which a person is mentioned in your dataset to determine whether a corresponding subject affiliation exists in the authority. 


## Local application
### Apply this method

Once you have extracted the named entities and identified the corresponding linked data you can then use this to enhance your metadata. This can be done in Library Management Systems or Digital Asset Management platforms. [Alma allows you to do this](https://knowledge.exlibrisgroup.com/Alma/Product_Documentation/010Alma_Online_Help_(English)/Metadata_Management/210Metadata_Management_Configuration/Linked_Data_Enrichment_Configuration) …, OCLC also has guidance on adding linked data tags. Smaller institutions may want to use open source platforms such as OmekaS which contains specific fields for linked data (expand). 

### Other projects

Several libraries have explored using linked data to enhance their digital collections and archival collections. University College London used name entity recognition on their Pi Periodicals, linking the data to wikidata to encourage the use of the collection as a source for wikipedia articles. 


### Continued learning

## Endnotes
