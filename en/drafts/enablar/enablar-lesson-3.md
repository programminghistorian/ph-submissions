---
title:  "Mapping Connections in Library Collections: Visualising Catalogue Metadata as Networks"
slug: enablar-lesson-3
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Halie Kerns
- Arnoud Wils
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket:
difficulty:
activity: creating network visualisations using library metadata 
topics: network analysis, library metadata, structured data, extraction, data visualisation 
abstract: Library catalogues usually present records as lists, making it difficult to see broader patterns across a collection. This workshop introduces network visualisation as a way of exploring relationships between books, subjects, and other catalogue metadata, helping participants identify clusters, connections, and areas for further investigation. Using prepared examples, we'll discuss how this approach can support collection development, research, and discovery.
avatar_alt:
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

<!-- NOTE TO ENABLAR AUTHORS 
Note 1: The YAML + Table of Contents Include above are formatted according to our local requirements and should remain in place.

You can edit the title: "Data-Driven Storytelling with Cultural Heritage Data" (line 2), and add your names into the `authors:` field.

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

Library catalogues are rich repositories of metadata, capturing details such as publisher, subject headings, year and place of publication, and language. Books that share common metadata attributes are inherently related, and these relationships can surface compelling and often overlooked stories about a collection — whether tied to a shared theme, a geographical area, or a particular period in time.

In most online catalogues, clicking on a metadata value returns a flat list of results: books that share that attribute. But there is a more powerful way to explore these connections. By visualising catalogue metadata as a network graph — where books and metadata values become nodes, and their relationships become edges — it becomes possible to navigate and interact with the collection in an entirely new way, revealing subsets and clusters that would otherwise remain hidden.

This lesson uses [iPySIGMA](https://github.com/medialab/ipysigma), a Python wrapper around sigma.js, a JavaScript library purpose-built for network visualisation, to build and explore these graphs directly from catalogue metadata.

The hope for this lesson is not just to show creative ways library data can be displayed, but how a librarian or researcher could utlilise network analysis on their own collection data for practical collection development tasks in the daily work. This lesson may be particularly helpful for librarians interested in demonstrating the value of their collections to audiences who might not typically interact with catalogue metadata.

### Method or tool
The method for this data exploration is network analysis, the visualisation of relationships between data points. In a network, individual entities are represented as nodes, while the connections between them are represented as edges, allowing patterns of association and clustering to become visible. As a research skill, network analysis helps scholars move beyond isolated records to examine how individual data points are connected within a larger system.The network analysis visualisations created here are interactive and meant to be manipulated by the user to dive deeper into the data, which are library records. 

The library records in this example are drawn from the [Nederlandse Bibliografie Online](https://www.kb.nl/over-ons/diensten/de-nederlandse-bibliografie), which contains all publications that have appeared in the Netherlands, about the Netherlands, or in the Dutch language. These publications have been collected, preserved, and annotated by the Dutch Royal Library (KB). We have selected a curated subset of bibliographic publications classified under the subject heading 'exact sciences'. It provides structured metadata that allows us to learn more about the books that made up the collection at different times. In this example, we have chosen twenty-five-year increments over two hundred years in order to compare how bibliographic metadata, such as subject headings, tell the story of the history of science in the Netherlands over time. Similar library data, such as MARC records, would contain comparable information and could be used for analysis.

To create the visualisations, the JavaScript library [Sigma.js](https://www.sigmajs.org/) was used. Sigma.js is one of the most powerful libraries for large-scale network visualisation.
Using the [networkx](https://pypi.org/project/networkx/) Python library, catalogue metadata from the selected dataset was first transformed into a network structure. In this structure, bibliographic records and subject attribution metadata values are represented as nodes, and their relationships are represented as edges. In the second step the [ipysigma](https://pypi.org/project/ipysigma/) Python framework wrapped the network data in a web page that included the Sigma.js JavaScript library. Users can then explore patterns across the collection by interacting with the network online. Researchers love the potential of the Sigma library because it can handle large-scale networks very well, providing an interactive yet oversight-friendly visualisation.

### Technical context
Network analysis is a popular tool across disciplines. In libraries specifically, it is often utilised to understand scholarly publishing and bibliometrics. However, it offers even more potential by using it on library collection data. When applied to catalogue metadata, network analysis can reveal relationships among items that are difficult to see in traditional search results. This makes it a useful method for collection exploration and development.

That being said, today's technical stack — Python, NetworkX and iPySigma — can handle all kinds of structured data very well, such as XML (like MARC 21), JSON or CSV, provided that relevant connections between data points can be observed in the data collection, making network visualisation useful.

The bibliographic datasets that we use can be downloaded for free from the linked data [publishing portal of the Royal Library](https://data.bibliotheken.nl/). We make them available for use in this lesson.
Once you have downloaded the data and installed the required Python libraries, you can complete this lesson offline without requiring live internet access.

### Social context
Library collections offer a wealth of information outside of normal utilisation, through the metadata they collect for items. Beyond using this metadata for search and retrieval, this data can be used to understand what makes up a library collection and leverage that knowledge for many uses including special collection building, purchases, weeding, and other collection development activities. For those outside the library, these actions are often carried out while asking questions such as: What materials should the library get rid of? What collections could be expanded? What items would benefit from being promoted together? How have our materials changed over time? The latter question is the one that researchers here aim to answer with the Dutch Library dataset.

### Prerequisites
* Basic understanding of Python libraries
* Basic skills for working with a code editor such as [VS Code](https://code.visualstudio.com/)
* Public or personal dataset of library materials organized in a structure scheme (MARC, Dublin Core, etc)
* Github account

This lesson works well on both Windows and Mac OS machines.
We will first walk you through the installation of [uv](https://docs.astral.sh/uv/), a Python package manager that creates a separate virtual environment for your project. This ensures that your project does not conflict with other packages that may already be installed on your computer. Next, we will guide you through installing all the required packages.

### Difficulty
* Medium

## Use Case

This workflow could be used as a way of telling thematic stories through library collections by librarians and researchers alike. This approach is a new way to visualize library collections to gain better insights and justify their importance for a wider audience. Rather than presenting catalogue records as static entries this workflow treats the collection as a connected system of relationships that can be explored visually. This makes it especially useful for communicating the value of collections to audiences who may not otherwise engage with catalogue metadata directly.

This lesson uses a subset of the [catalogue of the National Library of the Netherlands (KB)](https://www.kb.nl/over-ons/diensten/de-nederlandse-bibliografie) as its working example. As the national library, the KB collects, preserves and describes all publications published in the Netherlands, about the Netherlands, or in Dutch. This legal deposit function results in a collection that is both exceptionally complete and consistently well described. The catalogue metadata are correspondingly rich, offering a wealth of detail about each item. In this lesson, we focus specifically on the subject heading attributions in the collection, which are applied extensively and with notable consistency.

### A synchronic perspective

The richness of this metadata is also its main challenge. With such volume and detail, it becomes difficult to analyse the data by traditional means alone, to detect patterns, or to identify anomalies and turning points in the history of the collection.

This is where visualisation proves valuable. By visualising the metadata and allowing interactive selection of search criteria, even a brief exploration of the network graph can reveal which subjects and topics are most prominent within the collection, and how individual books relate to one another through shared subject headings.

### A diachronic perspective

Beyond its scale, the KB collection is distinctive for another reason: it offers complete and consistent metadata spanning a long historical period, a direct consequence of its role as the official deposit institution for Dutch publications. This means the catalogue does more than document the library's holdings. It also provides a window into the history of publishing in the Netherlands.

For this lesson, we selected the subset of books catalogued under the subject heading _wetenschap_ ('science'), spanning the period from 1800 to 2000. This range includes the nineteenth century, a formative period during which many modern scientific disciplines took shape.

This use case allows us to address the following research questions:

- Which scientific subject headings are most predominant in the collection?
- How did scientific subject headings change over time? What do these shifts reveal, both about the library's acquisition history and about the emergence and development of scientific disciplines in the Netherlands since 1800?
- How can we discover books that are related through a shared subject heading at a higher level, revealing unexpected clusters that may not be apparent from their Universal Decimal Classification (UDC) number alone?

Exploring the network graph of Dutch publications since 1800 through catalogue metadata visualisation may also be of value to historians of science, offering a fresh angle on the traditional narrative of how the sciences developed in the Netherlands. At the same time, researchers working within a specific discipline, such as mathematics or literary studies, may use this same network graph to discover related publications they had not previously considered.

Other examples of of activities that could be done, just focusing on subject heading data in libraries include: 
* Looking at a complete collection of subject headings for main collection to understand what sections are strongly represented and could be pulled out an highlighted
* Visualizing secondary subject headings in a collection of a picture book collection to understand the social and cultural contexts included in the collection and identify gaps
* Comparing topic clustering of two different special collections on vintage plant books and current gardening book to research what overlap exists and how this topic has changed over time

Library data includes information beyond subject headings and there is universe of possibility when it comes to exploring metadata.

### Dataset

To experiment with in this lesson, we provide eight data files containing bibliographic metadata for books in the [Nederlandse Bibliografie Online (Online Dutch Bibliography)](https://www.kb.nl/over-ons/diensten/de-nederlandse-bibliografie), the catalogue of the National Library of the Netherlands. Together, these files span the period from 1800 to 2000, with each file covering a twenty-five-year segment.

The data files are provided in JSON format, a plain-text format well suited to representing structured data. For each book catalogued under the broader subject heading "wetenschap" (science), the JSON files contain at least the following metadata:

- a uniform identifier
- title
- author
- subject heading (preferred label, narrower label, and broader label)
- genre
- language
- year of publication

Given the focus of this lesson, we are particularly interested in how publications are attributed to subjects. For this reason, we queried not only the general subject heading assigned to each book, but also the corresponding higher-level (broader) heading and lower-level (narrower) subdivisions. This layered structure provides richer data for visualising the relationships between book titles and subject headings. The dataset includes all books for which at least one broader subject label contains the term _wetenschap_ ('science').

A single JSON entry, describing one book, looks as follows:

```json
{
    "uri": {
      "type": "uri",
      "value": "http://data.bibliotheken.nl/id/nbt/p096038845"
    },
    "name": {
      "type": "literal",
      "value": "Gewone logarithmen met zeven decimalen der getallen van 1 tot 108000 en der sinussen, cosinussen, tangenten en cotangenten van alle hoeken in het quadrant van 10 tot 10 seconden, benevens eene interpolatietafel ter berekening van de evenredige deelen"
    },
    "label": {
      "type": "literal",
      "value": "Gewone logarithmen met zeven decimalen der getallen van 1 tot 108000 en der sinussen, cosinussen, tangenten en cotangenten van alle hoeken in het quadrant van 10 tot 10 seconden, benevens eene interpolatietafel ter berekening van de evenredige deelen / Ludwig Schrön ; uit het Hoogduitsch door D. Bierens de Haan"
    },
    "authorname": {
      "type": "literal",
      "value": "Heinrich Ludwig Friedrich Schrön"
    },
    "about": {
      "type": "uri",
      "value": "http://data.bibliotheken.nl/id/thes/p397577818"
    },
    "preflabel": {
      "type": "literal",
      "value": "Wiskunde, algemeen"
    },
    "broader": {
      "type": "uri",
      "value": "http://data.bibliotheken.nl/id/thes/p397577443"
    },
    "broaderlabel": {
      "type": "literal",
      "value": "Wiskunde en natuurwetenschappen"
    },
    "narrower": {
      "type": "uri",
      "value": "http://data.bibliotheken.nl/id/thes/p397577826"
    },
    "narrowerlabel": {
      "type": "literal",
      "value": "Inleiding"
    },
    "language": {
      "type": "literal",
      "value": "nl"
    },
    "jaar": {
      "type": "literal",
      "value": "1862",
      "datatype": "http://www.w3.org/2001/XMLSchema#gYear"
    }
}
```

### Retrieving the data

The data were downloaded from the publicly accessible portal of the [National Library of the Netherlands](https://data.bibliotheken.nl/KB/-/queries/Titel-zoeken-in-de-NBT/), where records can be retrieved by submitting a SPARQL query. SPARQL is a query language designed for retrieving and working with Linked Open Data. No prior knowledge of SPARQL is required for this lesson, but readers interested in learning more are encouraged to consult the lesson [Introduction to the Principles of Linked Open Data](https://programminghistorian.org/en/lessons/intro-to-linked-data).

For reference, the SPARQL query used to construct the datasets for this lesson is given below. You are encouraged to try it yourself on the [library portal of the National Library of the Netherlands](https://data.bibliotheken.nl/KB/-/queries/Titel-zoeken-in-de-NBT/), and to experiment with adapting the query to suit your own field of study.

```sparql
prefix skos: <http://www.w3.org/2004/02/skos/core#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix schema: <http://schema.org/>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
select distinct ?uri ?name ?label ?authorname ?about ?preflabel ?broader ?broaderlabel ?narrower ?narrowerlabel ?location ?genre ?genrelabel ?language ?jaar ?editie ?type
where {
  ?uri schema:name ?name .
  ?uri rdf:type schema:Book .
  optional {
    ?uri schema:author/schema:name ?authorname.
  }
  optional {
    ?uri schema:about ?about .
    ?about skos:prefLabel ?preflabel .
    ?about skos:broader ?broader .
    ?broader skos:prefLabel ?broaderlabel .
    ?about skos:narrower ?narrower .
    ?narrower skos:prefLabel ?narrowerlabel .
  }
  filter contains(lcase(?broaderlabel), lcase("wetenschap"))
  optional {
    ?uri schema:location ?location.
  }
  optional {
    ?uri schema:genre ?genre .
    ?genre skos:prefLabel ?genrelabel .
  }
  optional {
    ?uri schema:inLanguage ?language.
  }
  ?uri rdfs:label ?label .
  ?uri schema:publication/schema:startDate ?jaar .
  filter(?jaar > "1800"^^xsd:gYear && ?jaar <= "1825"^^xsd:gYear)
  optional {
    ?uri schema:bookFormat ?type.
  }
  optional {
    ?uri schema:bookEdition ?editie .
  }
}
order by ?jaar
```

Two elements of this query are worth highlighting. Line 21 contains the filter statement that restricts results to records classified under the broader label "wetenschap" (science), while the filter on line 34 restricts results to the relevant time frame, in this case 1800–1825.

You don't need to run the queries yourself, as we have made the datasets available for this lesson [here](#).

### Software/tool

- [networkx](https://pypi.org/project/networkx/), a Python package for the creation and manipulation of networks
- [Sigma.js](https://www.sigmajs.org/), a Javascript library for large-scale network visualisation
- [iPySIGMA](https://github.com/medialab/ipysigma), a Python wrapper around sigma.js

## Learning keys
### Concepts
This lesson explores how library catalogue metadata, or the structured information recorded about a library item, can be transformed into network data to better understand relationships within a collection. This metadata may include details such as title, author, publication information, and related subjects. Subject headings are especially useful for this process because they provide a structured way of describing what a library item is about and can therefore be used to identify meaningful connections between items.

Using subject headings as the basis for connection, we will examine how catalogue records can be represented as a network graph. In this visual representation, nodes stand for entities within the network, such as subjects or items, while edges show the relationships that connect those nodes. Viewing catalogue metadata in this way allows us to see how different parts of a collection relate to one another and to identify clusters, or groups of nodes that are more closely connected to each other. We will also consider how [centrality](https://en.wikipedia.org/wiki/Centrality) can help measure which nodes are especially important or highly connected within the network.

The lesson will then demonstrate how interactive visualisations can support collection analysis and development by making patterns, clusters, and relationships easier to explore. By comparing network visualisations created from catalogue data at different points in time, librarians can gain insight into how a collection has developed historically and how it may continue to evolve in the future. These concepts will be demonstrated through a workflow built with Python, ipysigma, and JavaScript sigma.js

### Terms

Before turning to the hands-on part of this lesson, it is useful to review a few basic concepts underlying network graphs and how they apply to our use case.

#### Nodes and edges

At its core, a network graph charts a set of relations between data points. These data points, the items being linked to one another, are called **nodes**. The relations between them, in essence a list of statements that point x is connected to point y, are called **edges**.

In our use case, we are visualising the relations between book titles and subject headings, both of which are available in the bibliographic metadata described in the previous section. Book titles and subject headings will therefore form the nodes in our network visualisation, with edges representing the connections between them.

#### Attributes

Beyond the connections that link them, nodes can also carry additional characteristics, or fields, that are not used to establish relations but instead provide supplementary descriptive information about each node. In a network graph, it is often valuable to be able to view these **node attributes*** directly alongside the network structure itself.

In our use case, while the network primarily visualises relations between book titles and subject headings, it is useful to also have immediate access to further attributes of each node. For book title nodes, this includes information such as the author, year of publication, genre and language. For subject heading nodes, it is similarly useful to be able to see, at a glance, related subject headings at a higher or lower level.

### Time

## Learning experiment

### Aims

The objective of this lesson is to visualise library catalogue data in an interactive, navigable display. By the time you have completed it, you will be able to transform the example dataset from the National Library of the Netherlands (KB) into a network graph that allows you to interactively explore the relations between book titles and subject headings in the domain of *wetenschap* (science) over the period 1800–2000.

Beyond this specific example, you will also have acquired the skills to visualise any library catalogue dataset of your choosing, and to define for yourself which nodes and connections you wish to explore. Possible combinations are not limited to book titles and subject headings: authors, genres, languages, publication dates, and other metadata fields can all serve as nodes in their own right.

### Inventory

In this lesson, nodes, edges and the visualisation itself are defined in Python, using the following tools and packages:

- [NetworkX](https://pypi.org/project/networkx/): a Python package for creating and manipulating networks
- [Sigma.js](https://www.sigmajs.org/): a JavaScript library for large-scale network visualisation
- [iPySigma](https://github.com/medialab/ipysigma): a Python wrapper around Sigma.js that enables network visualisation within a Python environment

#### Data files

The sample data files used in this lesson are available [here](#). Each file covers a twenty-five-year period within the range 1800–2000:

- `nbt_index_1800-1825.json`
- `nbt_index_1826-1850.json`
- `nbt_index_1851-1875.json`
- `nbt_index_1876-1900.json`
- `nbt_index_1901-1925.json`
- `nbt_index_1926-1950.json`
- `nbt_index_1951-1975.json`
- `nbt_index_1976-2000.json`

#### Directory structure

To keep code and data well organised, we recommend the following directory structure:

```
src/
├── main.py              # Python script
└── data/
    ├── in/              # Source data files (JSON)
    └── out/             # Generated output files (HTML network graphs)
```

### Workflow

#### Setting up the environment

To keep the working environment tidy and avoid conflicts with other software and packages installed on your machine, we recommend creating a virtual environment using [uv](https://docs.astral.sh/uv/), a widely used Python package manager.

Begin by installing uv by following the [installation instructions](https://docs.astral.sh/uv/getting-started/installation/) for your operating system. Then navigate to the folder where you want to create the project, initialise the project directory, and move into it:

```bash
$ uv init src
$ cd src
```

Next, create a virtual environment within the `src` folder and install the required Python version for this project:

```bash
$ uv sync --python 3.12
```

Then install the packages required for this lesson:

```bash
$ uv add matplotlib scipy networkx ipysigma
```

Once the environment is set up, launch VS Code (or your preferred code editor) within the virtual environment to ensure all installed packages are available:

```bash
$ uv run code .
```

#### Importing the required packages

Open the `main.py` file that was generated automatically during project initialisation, and remove its pre-generated contents. Begin your script by importing the required packages:

```python
import json
import networkx as nx
from ipysigma import Sigma
```

#### Importing the data files

We will now create a function that reads a time-range-specific JSON data file from the sample dataset (for example, `nbt_index_1800-1825.json`). Recall that each file has the following structure, where each entry in the `bindings` array represents one book in the catalogue:

```json
{
  "head": { "..." },
  "results": {
    "bindings": [
      {
        "uri": {"..."},
        "name": {"..."},
        "about": {"..."},
        "preflabel": {"..."},
        "broader": {"..."},
        "broaderlabel": {"..."},
        "narrower": {"..."},
        "narrowerlabel": {"..."},
        "language": {"..."},
        "jaar": {"..."},
        "editie": {"..."}
      }
    ]
  }
}
```

The function will convert the contents of this file into a network format, that is, a list of nodes and edges. Begin by opening the file and extracting the catalogue entries:

```python
# Function to convert JSON data to a NetworkX graph
def convert_json_to_nx(date_range: str):
    # Open the JSON file containing the parsed data
    file_path = f"data/nbt_index_{date_range}.json"
    with open(file_path, "r") as f:
        data = json.load(f)

    # Extract the catalogue data from the JSON
    catalogue_items = data["results"]["bindings"]
    item_dict_list = []
```

Define placeholders for the nodes and edges:

```python
    edges = []
    nodes = {}
```

Then iterate over the catalogue entries and convert each one into a [dictionary](https://www.w3schools.com/python/python_dictionaries.asp), building up a list in which each entry holds the metadata for one book:

```python
    for x in catalogue_items:
        if x is not None:
            itemdata = x
            # Create a dictionary for each catalogue item
            item = {
                "uri": itemdata.get("uri").get("value"),
                "title": itemdata.get("name").get("value"),
                "language": itemdata.get("language").get("value"),
                "date": itemdata.get("jaar").get("value"),
                "pref_subject": itemdata.get("preflabel").get("value"),
                "narrower_subject": itemdata.get("narrowerlabel").get("value"),
                "broader_subject": itemdata.get("broaderlabel").get("value"),
            }
            item_dict_list.append(item)
```

#### Defining nodes and edges

##### Edges

With the catalogue data now structured as a list of dictionaries, we can define the **edges** of our network graph. For this lesson, we connect:

- each book title to its preferred, narrower and broader subject headings
- subject headings to one another, linking preferred labels to both their narrower and broader equivalents

```python
            edges.append((item["pref_subject"], item["title"]))
            edges.append((item["pref_subject"], item["narrower_subject"]))
            edges.append((item["pref_subject"], item["broader_subject"]))
            edges.append((item["narrower_subject"], item["title"]))
            edges.append((item["broader_subject"], item["title"]))
```

##### Nodes

The nodes in our graph are book titles and subject headings. As discussed in the previous section, it is valuable to also display node attributes alongside the graph structure:

- For **book title nodes**, we include additional metadata such as the preferred, narrower and broader subject headings, the date of publication, the language, and the unique identifier (URI).
- For **subject heading nodes**, we include the related broader and narrower subject headings.

```python
            # Define nodes for the catalogue graph
            keys_title_to_extract = ["title", "pref_subject", "narrower_subject",
                                      "broader_subject", "date", "language", "uri"]
            keys_subject_to_extract = ["pref_subject", "narrower_subject", "broader_subject"]

            for node_attributes in item_dict_list:
                node_title = node_attributes["title"]
                node_pref_subject = node_attributes["pref_subject"]
                node_narrower_subject = node_attributes["narrower_subject"]
                node_broader_subject = node_attributes["broader_subject"]

                sub_dict_title = {key: node_attributes[key] for key in keys_title_to_extract
                                  if key in node_attributes}
                sub_dict_title["type"] = "book"

                sub_dict_subject = {key: node_attributes[key] for key in keys_subject_to_extract
                                    if key in node_attributes}
                sub_dict_subject["type"] = "subject"

                nodes[node_title] = sub_dict_title
                nodes[node_pref_subject] = sub_dict_subject
                nodes[node_narrower_subject] = sub_dict_subject
                nodes[node_broader_subject] = sub_dict_subject
```

Note that each node is assigned a `type` attribute, either `"book"` or `"subject"`, which will allow us to distinguish between the two kinds of node visually when we render the network graph in the next step.

#### Building the network graph

With the nodes and edges defined, we can now construct the network graph using NetworkX and prepare it for visualisation.

#### A preliminary look with NetworkX

Before introducing the interactive visualisation, it is instructive to first render the graph using NetworkX's built-in drawing functionality. Create an empty directed graph, populate it with the nodes and edges defined in the previous step, and save a static image:

```python
    G = nx.DiGraph()
    for edge in edges:
        G.add_edge(edge[0], edge[1])
    nx.set_node_attributes(G, nodes)
    nx.draw(G, with_labels=True)
    plt.savefig("catalogue_graph.png")
```

To run the script against a single data file — in this case covering the period 1800–1825 — add the following block at the very end of your script and execute it:

```python
if __name__ == "__main__":
    convert_json_to_nx("1800-1825")
```

Open the resulting `catalogue_graph.png` file. The image will likely appear as a dense, near-black tangle of overlapping nodes, edges and labels. This is an inevitable consequence of the sheer volume of data: a static rendering cannot meaningfully represent a graph of this complexity.

This is precisely where iPySigma proves its value. Rather than attempting to display all nodes, edges and labels at once, it renders the graph as an interactive visualisation that the user can navigate freely, revealing detail progressively as they explore.

#### Creating the interactive visualisation

Remove the test call added in the previous step:

```python
convert_json_to_nx("1800-1825")
```

Then append the following block to the `convert_json_to_nx` function. This uses iPySigma to wrap the NetworkX graph in an interactive Sigma.js visualisation and write it to an HTML file:

```python
    # Create a Sigma visualisation
    Sigma(
        G,
        node_color="pref_subject",
        node_label_size=G.degree,
        node_size=G.degree
    )
    Sigma.write_html(
        G,
        f"data/nbt_index_{date_range}.html",
        fullscreen=True,
        node_metrics=["louvain"],
        node_color="pref_subject",
        node_size_range=(3, 30),
        node_shape="type",
        node_shape_mapping={
            "book": "book_2",
            "subject": "label"
        },
        max_categorical_colors=50,
        default_edge_type="curve",
        default_node_label_size=14,
        node_size=G.degree
    )
```

A few parameters are worth highlighting:

- `node_color="pref_subject"`: each preferred subject label is mapped to a distinct colour, making it easy to visually distinguish subject clusters and the book titles associated with them.
- `node_shape_mapping`: custom icons from the [Google Fonts icon library](https://fonts.google.com/icons) are used to make node types immediately recognisable. In this lesson, book title nodes are represented by a book icon (`book_2`) and subject heading nodes by a label icon (`label`).
- `node_metrics=["louvain"]`: the Louvain algorithm is applied to detect communities within the graph, which can reveal clusters of closely related books and subject headings that might not be apparent from classification numbers alone.

#### Generating output files for all time periods

To process all eight data files and generate a separate interactive HTML file for each twenty-five-year period, replace the entry point block at the end of your script with the following:

```python
if __name__ == "__main__":
    date_ranges = [
        "1800-1825",
        "1826-1850",
        "1851-1875",
        "1876-1900",
        "1901-1925",
        "1926-1950",
        "1951-1975",
        "1976-2000"
    ]
    for dr in date_ranges:
        convert_json_to_nx(dr)
```

Running the script will produce eight HTML files in your `data/out` folder, one for each time segment. Each file is a self-contained, interactive network graph that can be opened in any modern web browser. But wouldn't it be great to be able to visualise how the graph changes over time using a time slider?

#### Navigating through the network graph

Now that the nodes and edges have been defined, we can begin to move around the visualization with the iPySIGMA features. Before us is an interactive web-based network graph that shows the relationships between the books and the subject headings. Each graph has a natural state that often looks like a cloud of chaos, this the graph before it is laid out. It is recommended that before you interact with the graph that you click the play button to run the layout animation. This allows the graph to settle into a more readable arrangement, where closely related nodes cluster together and less connected groups move farther apart. In network visualization, this is known as a force-directed layout. Moving the nodes through the layout animation also helps to see the physical distance between different topics. The closer together or more tightly clustered they are, the more they are related or prominently connected. 

(Screen shot comparison of the two?)

Each point is a node, whether it be an individual book title (with a book icon) or a controlled subject heading (with a label icon). If a book has a subject heading assigned, there is a line drawn between that subject and the book. These lines are edges, which illuminate the relationships. Subject headings are also connected by subject labels from the JSON file data in the form of a preferred subject label, a broader subject label, and a narrower subject label to help contextualize the more controlled vocabulary of the subject headings. 

The size of the node describes its level of connectivity within the graph, or how many edges (connections) it has. The larger the subject node, the more connections it has. That means the larger nodes are highly connected and act as thematic hubs of the visualization. Our eyes are drawn to them and they surface quickly, the prominent subjects available in a collection. Smaller nodes are not as obvious, often representing those single book titles or less used subject headings. However, the iPySIGMA shell still makes them easy to find if you are looking for them and they are revealed as we move through the graph. 

For example, looking at the 1800-1825 network, we can see that one of the largest labels is Geschiedenis (History). If you click on it within the graph, all the edges are highlighted and in the right panel, information about that specific node appears in the box to the right of the graph. It explains the size of the node (how many edges it has), the subject information from the JSON file, and the metrics in degrees (number of edges again), indegree (how many edges point towards this node), and outdegree (how many edges point out from this node). Not all network graphs are directed, but this one is. The direction of each edge reflects how the relationship was modeled in the code. Since this is a subject heading node, a high outdegree means that this subject heading connects outward to many book titles and/or related broader and narrower subject labels. Which makes sense since history is a major subject in the collection during this time. 

Now, if we click on one of the book icons connected to history, Geschiedenis der Romeinen : een leesboek voor de jeugd translated as, History of the Romans: a reading book for young people, we can glean different information. A book in this network is more concerned with indegrees, or rather, how many subjects it connects to. In this case it is six, including mathematics and biography. Exploring individual books helps us to understand how the subjects overlap in a collection. 

Another option for exploration of the graph, is to click on a node from the list in the legend box on the right. They are organized by colour, based on the subject headings. However, since there are so many subject headings, the color as a differentiator is not as helpful in this example as it would in a sample with ten or less subject headings. You can also use the search box to find a specific node, whether it be a subject or a book. Once selected, the graph will zoom in on that node, no matter how small it is. The search function is helpful for exploring collections and items that you are familiar with or that you have target research about. 

The network graph visualisation that is a result of this activity is meant to be an exploratory tool for collections that takes traditional catalog records out of a list-based search interface. Instead, the graph allows a user to explore how records are connected to one another, making it possible to identify themes and gaps that might not be visible through search results alone. These findings can then support collection development in new and creative ways by helping librarians identify areas for future acquisition, create new collections from existing clusters, compare changes in a collection over time, and reveal unexpected relationships among materials. 

### Summary
Looking at the eight graphs, we start to see patterns emerge and how the collection changes over time. A good starting point is looking at the size and density of the collection under this topic. In this example, over the years, the network gets denser and denser which makes sense with basic knowledge about scientific advancement over the nineteenth and twentieth century. Density may reflect more items in the dataset, more detailed subject cataloguing, or both. 

More granularly, the number of items cataloged under science doubled between 1926-1950 and 1951-1975. What inspired this? Was it just the number of published works? Expansion of the field? Curiously, after these two periods, in 1976-2000, the collection was halved. There are many possible reasons for this, did the subject headings change? Did the format of what the library was buying change and these items are left out? Did the budget or focus on the collection change? Were fewer books published in Dutch? There is much to explore and find out from posing these questions just by the size and density of the works. 

Then, we can zoom out again and start to look at the themes and complexities of networks changing over time. In the early networks, the collection was small but thematically broad. It connects major topics to our flagship wetenschap (science) like history, biography, religion, and literature. Our modern sensibilities may not make the same connections, but it reflects the intellectual overlap of its time. 

Subsequent graphs in the nineteenth century show how cataloging and institutional understanding shift these connections over time.The complexity increases alongside the number of nodes and edges. This suggests that more books are being represented in this subject area and that those books are connected through a growing range of more specific subject headings that have less overlap with topics outside of science. More questions arise. Is this a change in publishing? Cataloging? Or the subjects themselves? 

The visualization cannot explain the cause on its own, but it helps identify where further research should begin. A sudden increase in density, for example, may prompt questions about whether the library acquired more scientific works, whether more works were published in Dutch, whether cataloguers began applying more detailed subject metadata, or whether the meaning of science shifted over time. Smaller or more isolated clusters may also be meaningful, since they can point to specialized collecting areas or unusual cataloguing relationships that sit at the margins of the larger collection. 

As we move into the twentieth century, the networks form tightly connected clusters and larger hubs. This not only indicates growth, but also a move to internal connections within science from broad thematic overlapping understanding of the earlier graphs. For collection analysis, this is useful because it helps reveal which subject areas are especially prominent and which topics sit at the center of the collection’s structure. Large subject nodes can be read as thematic anchors, while smaller clusters may point to specialized areas of collecting or emerging fields. 

Many more hours could be spent looking at each graph’s minute details and comparing them. Depending on the collection you want to work with, this could be a much simpler or more complex task than the example. However, across our graphs and yours, the value of this method is that it makes catalogue metadata visible as a system of relationships. Traditional cataloging metrics do not as easily surface insights about items and subjects relationally connect and cluster. 

For the National Library of the Netherlands, this analysis suggests that the wetenschap subject is not a narrow or static science collection. Instead, it appears as a changing intellectual field shaped by categories of scientific expertise and cataloging practices shifting over the nineteenth and twentieth century. For librarians, this kind of visualization can support collection development in all sorts of ways. It could be a “changes over time” approach as explored here or it could be a comparison of different subjects or collections. One could look at publishing trends based on subject headings or emerging fields. The opportunities are endless. In addition, for researchers, it offers a way to ask historical questions about the organization of knowledge within a national library collection and what external forces affect that process. No matter who you are, this exploratory approach cannot explain the why of the cataloging, but it helps identify where further research and collection development should begin.

## Local application
While this example uses metadata from publically available datasets, the same process could be applied to an institutional specific dataset made up of MARC records from that collection. Extracting those records and applying similar analysis through these steps could help better understand how your local collections connect and cluster.
### Apply this method
What questions do you have about your library, whether it be the one you work at or use? Formulating a question will help you get started on what you want to explore based off this example. 

Once you have your questions, download a file of data about your library collection including the metadata categories that you want to explore such as the subject headings example here. Once the data is ready, you should be able to replicate the visualization process to meet your needs. 
 
### Other projects
### Continued learning

## Endnotes
