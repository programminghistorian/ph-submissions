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
This lesson details how to conduct Named Entity Recognition (NER) (using ...?), on OCR’d documents and then connect them to authority files to enhance metadata and people discovery in library and archive catalogues.

#### General Context
An ever increasing amount of materials available to librarians and researchers are digitised or born-digital. The sheer quantity of such materials can be hard to efficiently manage.  Traditionally items such as journals or runs of newsletters are catalogued under one record. The rise of digital asset management platforms and digital archives brings an opportunity to record each instance of an item as a separate metadata record, as each issue has a corresponding file that can be directly linked to. Where journal records once needed to point to a physical location for the complete set, the individual issues/files can be stored and linked to from anywhere. 

Creating metadata for these records can be time consuming. Particularly if libraries are adding named entities, as this is often done manually by reading the item and identifying the authors or named entities mentioned in the text. Consequently many libraries and archives choose not to add this level of detail to their metadata, leaving researchers relying on either full text searches, if available, or requiring them to read multiple documents to find the person they are looking for. 

Additionally, where full text search is available, documents such as newsletters often refer to the same person or organisation in multiple ways making it difficult to search records consistently. Collections may also contain multiple people with the same name, so users may not have the context to verify which individual is being referred to. 

This is where Named Entity Recognition (NER) and linked data can help. Named Entity Recognition (NER) picks out the individual entities from a body of text. Linked Data can then be used to map the entity to an authority file, which verifies who the individual referred to is and creates consistency when referring to them in the metadata. This increases the discoverability of the collection, as the enhanced metadata creates a more accurate search than a full text search, and helps researchers track the activities of named entities across the catalouge. Enriching the metadata with linked data opens up further opportunities for data visualisations and knowledge maps. As well as interoperability with external systems such as Wikidata, where texts in a collection can be used as sources on Wikipedia once connected via Linked Data. 


### Technical context
#### Named Entity Recognition
Natural Language Processing is the branch of artificial intelligence which concerns itself with the processing of natural (i.e. human) language. Named Entity Recognition is a subset of Natural Language Processing which focuses on identifying named entities (people, organisations, places, currencies, etc) through machine-learning algorithms. 
By deploying NER on a dataset, we can rapidly identify points of interest. 
#### Linked Data 

Jonathan Blaney’s lesson provides a comprehensive [introduction to linked data](https://programminghistorian.org/en/lessons/intro-to-linked-data). For the purposes of this lesson you need to know that data, in this instance a named entity, is linked to an authority file. It is the unique URI from that authority file which identifies the individual and is added to the cataloging metadata. 

There are many authority files in existence covering a wide range of subjects, objects and entities. Choosing the appropriate file for your collection depends on several factors. 

Domain of the collection. What sector does the collection sit in, libraries, digital research. 

Content of the collection. ORCID for researchers, VIAF for people, LCSH for subjects, WikiData wider range but X. 

Purpose of the authority file. Do you want to just create consistency in your collection for search, or do you want interoperability to other systems.

### Social context
Distant-reading methodologies can help identify certain points of interest within texts or collections. However, there is a real risk of perpetuating archival silences.  

(structure) 
- Risk of archival silences 
- In the authority files 
- In the data sets 
- In the NER 
- What to be aware of when undertaking this task.

### Software/tool
We will be making use of three Python libraries for the purpose of this lesson: pdfplumber, spaCy, and requests. Each of these will be used for a specific step towards our final goal, namely the augmenting our materials’ metadata for people discovery. 
pdfplumber will serve to extract computer-legible text from the PDFs that form our dataset. spaCy will then allow us to identify named entities, specifically people, in these PDFs. Finally, the requests library will enable to search the entities identified via NER against authority files through Wikidata’s API.  

### Method
Librarians, cataloguers, and researchers alike are often unaware of the exact contents of a work or collection of works. Using a distant-reading method like NER to identify people and match these against authority files can provide one way to rapidly improve the metadata of a given text. 

This  method is exploratory in essence. However, a few words of caution are needed. To start, NER is not a completely accurate task. Even the best models struggle at surpassing 95% accuracy. This becomes even more of a problem when working with underrepresented languages. Secondly, authority files are often limited in their scope. LOOK UP GENDER STATISTIC? Asides from the various biases that may be baked into such files, the domain that one wishes to use this methodology for matters too. We may be able to recover a lot of internationally-acclaimed architects from authority files. We might be less successful in recovering lesser-known architectural professionals. Yet silence matters too: who are those individuals whose presence cannot be traced to authority files, yet appear alongside their more famous peers?

### Prerequisites

The ability to read Python code, as well as a prior understanding of basic Python concepts such as variables and functions is required for this lesson. Familiarity with the spreadsheet-management library Pandas is helpful too, but not essential. 

This lesson will focus on applying the Natural Language Processing method known as Named Entity Recognition (NER) to generate data to check against authority files using the WikiData API. 

### Difficulty

## Use Case

This Lesson will look at a case study of the Architectural Association School of Architecture’s (also known as the AA) weekly newsletter; AA Weekly. The newsletter has been published weekly during term time since 1973, roughly 32 newsletters a year. Between 1973 and 2017 they were published as physical pamphlets (maybe add a picture). Since 2017 they have been delivered by email. 
(pictures of 2017-2023 email format, picture of post 2023 format) 
Twenty newsletters have been selected for this lesson, which have been converted to PDF’s from the original email format. As a born digital record these newsletters already contain machine readable text, so no OCR is needed. For guidance on performing OCR please see the Programming Historian lesson on (link). 
The newsletters detail the weekly programme of events at the school, including talks and workshops given by tutors, students and guest speakers. The collection is used by researchers to track the speakers, themes and topics discussed at the school and how these talks and collaborations have influenced or reflect wider trends in the sector.
Extracting named entities and linking them to authority files increases the discoverability of these resources and saves researchers time when consulting the collection as linked data in the record can verify which issue is relevant to their research. 


### Dataset
### Software/tool

Python libraries:
- pdfplumber
- spaCy
- requests
- pandas
- fuzzystr? or other method of getting rid of some duplicates?


## Learning keys

### Concepts
- Archival discovery
- NER
- Authority Files
- API

### Terms

Natural Language Processing

### Time

## Learning experiment
### Aims

### Inventory

dataset: either text files or the actual PDFs
python libraries: spaCy (and large english model), requests, pdfplumber, pandas

### Workflow

1. text extraction from PDF (skip if uploading text files instead of PDFs)
   a. pdfplumber presentation
   b. loading data
   c. extract data using pdfplumber
2. Named Entity Recognition
   a. NER
   b. Entity Disambiguation
3. Authority FIle Matching with requests and Wikidata

#### 1.a pdfplumber presentation

We need to obtain data before we are able to process it. PDFs are ubiquitous in today’s publishing landscape. Thankfully, this means there are also plenty of ways to extract their text with a bit of code. 

This first step is optional. Feel free to skip it and directly refer to the next step, using the  text files uploaded with this lesson. 

One of these ways is through the library [pdfplumber](https://pypi.org/project/pdfplumber-aemc/0.7.6/). This library allows you to load PDFs and mine their text by creating a “pdfplumber.PDF” class. This is a list of “pdfplumber.Page” objects, where every instance corresponds to one page in a PDF. Given that we are working with multiple PDFs, however, we need a way to load all of them into a format which will enable us to apply the NER later.

#### 1.b loading data

Pandas is a Python library for data management. It essentially allows the manipulation of data in a tabular format (aka spreadsheets), known as DataFrames. This then makes it easy to apply a wide range of operations on our data. 

Let’s start by loading the names of all the files in our data folder. To do so, we will create a function that will allow us to grab all files that end in “.pdf” thanks to the “Path” method of the “pathlib” library. We create an empty list called “files” to which we append the pathname of all relevant files. 

First, we load all the relevant libraries.

```
import pdfplumber
import pandas as pd
from pathlib import Path
```
Then, create the function to extract file names.

```
#func to get all pdfs in directory
def get_pdfs(dir): #dir refers to directory
   files = [] 
   for path in Path(dir).glob("*.pdf"):
       files.append(path)
   return files
```
Now that we have the function ready, let’s save all file names under the “aa_files” variable. 

```
aa_files = get_pdfs("AA Weekly/201718")
```
#### 1.c extract data using pdfplumber

We need an additional function to be able to pull the data from the PDFs into a table format. The following function has two components to it: we mine the text of each PDF and then append that text data to a pandas Dataframe. 

Let’s break this down, starting with mining the PDFs. As mentioned earlier, pdfplumber treats each page of a PDF as a singular instance. We therefore need to combine all these separate text strings into one. 

```
with pdfplumber.open(doc) as pdf:
           variable = []
           for page in pdf.pages:
               text = page.extract_text()
               if text:
                   variable.append(text)
           combined_pdf = " ".join(variable)
```

We need to repeat this process for each file in our dataset folder and add each output into the empty “rows” list, which we then turn into a dataframe. Here, “file_name” and “text” correspond to the two columns of the table. 

```
# func to extract text from pdf
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
       #append to rows and use Path to only keep file name
       rows.append({"file_name": Path(doc).name, "text": combined_pdf})
   df = pd.DataFrame(rows)
   return df
```

Now let’s simply apply this function to the “aa_files” variable. We can print the contents of the “text” column to verify it has worked. 

```
aa_files_data = pdf_to_df(aa_files)
print(aa_files_data[“text”])
```

#### 2.a NER 

There are tonnes of different ways to approach NER, but the spaCy library stands out for the number of languages it supports and its easy-to-approach syntax. We need to load the spaCy library and download its large English-language model.

```
import spacy
```
```
#load spacy moodel
nlp = spacy.load("en_core_web_lg")
```
This “nlp” variable will allow us to call the model on our data. spaCy processes texts and outputs a “doc” object which contains various kinds of metadata such as the entities it picked up, the labels of those entities (whether they are people, places, and so forth) and where these entities are located in text. We can access this information through the doc.ents object. People working with NER are often interested in knowing what kinds of entities each sting of text represents, and where these entities are located. They therefore usually adopt the following syntax.

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

For our purpose however, all we need is to have the names, specifically of people,  that appear within the text. Let’s define a new function to apply the large english model to text and return a list of all PERSON entities found within said text.
```
#ner func
def run_ner_df(text, nlp):
   entities = []


   doc = nlp(text)
   for ent in doc.ents:
       if ent.label_ == "PERSON":
           entities.append(
           ent.text.strip()
           )

   return entities
```

Now, let’s create a new row in our dataframe which we will populate with key-value pairs from the entities that appear in the text that we mined for each file. Using the .apply() function, we can apply our run_ner_df function on every row in the “text” column of our dataframe. We can print out the entities extracted from the first row to verify that it has worked. 
```
#entities code
aa_files_data["entities"] = aa_files_data["text"].apply(lambda x: run_ner_df(x, nlp))
```

As of now, we have a dataframe with our file names, the text we extracted from these files, and the entities we extracted from each text. We can now get the NER entities ready for matching against the authority files. This will be done in two steps: deduplication and cleaning.

It would be inefficient to match every single result. What if some of the entities appear multiple times? pandas, thankfully, has a nifty method called .explode() which lets you unpack lists so that each object gets its own row.
```
aa_data_exploded = aa_files_data.explode("entities")
```
We can then group this new dataframe by the values contained in the “entities” column.
```
#group ner column
aa_data_deduped = (
   aa_data_exploded.groupby("entities", as_index=False)
   .agg(source_files=("file_name", lambda x: "; ".join(sorted(x.unique()))))
)
```
The .join() ensures that if an entity appears in multiple files, we can trace it back to all.

If we have a look at our aa_data_deduped dataframe, we can see that we have 261 unique entities. However, some NER errors appear. Some names were for example grabbed as single tokens, such as the first names Alain or Adam. If we tried to match these against architects in Wikidata, it is very unlikely that a positive result would be returned. We also see that several entities have been identified as people, when they seem to be a mix of people and dates such as “Andreas THU 24”. Finally, a number of entities contain the string “AA” - which simply is a quirk from our data, which comes from the Architectural Association Library!

We can clean these very easily with the following bit of code.
```
#single token names (no space = one word)
aa_data_deduped = aa_data_deduped[aa_data_deduped["entities"].str.contains(" ")]


#rows containing any digit
aa_data_deduped = aa_data_deduped[~aa_data_deduped["entities"].str.contains(r"\d")]


# rows containing "AA" as a sequence
aa_data_deduped = aa_data_deduped[~aa_data_deduped["entities"].str.contains("AA")]
```
What is left is still not entirely clean. However, the essential purpose of this script is efficiency and not accuracy: a human in the loop will verify final results anyway.


CONTINUE

These functions work together as a pipeline that takes a list of names and looks each one up in Wikidata, returning structured information about who they are and where they appear in other authority files.
search_wikidata_label(name) is the first step. Given a name like "Eva Franch", it sends a search request to Wikidata and gets back up to 5 possible matches — similar to typing a name into a search engine and seeing the top results. Each result comes with a unique ID called a QID (e.g. Q4533), a label, and a short description.


### Summary


## Local application
### Apply this method

Once you have extracted the named entities and identified the corresponding linked data you can then use this to enhance your metadata. This can be done in Library Management Systems or Digital Asset Management platforms. [Alma allows you to do this](https://knowledge.exlibrisgroup.com/Alma/Product_Documentation/010Alma_Online_Help_(English)/Metadata_Management/210Metadata_Management_Configuration/Linked_Data_Enrichment_Configuration) …, OCLC also has guidance on adding linked data tags. Smaller institutions may want to use open source platforms such as OmekaS which contains specific fields for linked data (expand). 

### Other projects

Several libraries have explored using linked data to enhance their digital collections and archival collections. University College London used name entity recognition on their Pi Periodicals, linking the data to wikidata to encourage the use of the collection as a source for wikipedia articles. 


### Continued learning

## Endnotes
