---
title:  "Visualising networks in library catalogue metadata using iPySIGMA and Llama Extract"
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
abstract: Short abstract of this lesson
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

In the second part of the lesson, we extend this approach by using [Llama Extract](https://www.llamaindex.ai/llamaextract) to derive structured metadata from catalogue fields that do not store it explicitly. This adds an additional layer of richness to the network, enabling us to surface connections and stories that existing metadata alone cannot tell.

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

To experiment with in this lesson, we provide eight data files containing bibliographic metadata for books in the [Nederlandse Bibliografie Online (Online Dutch Bibliography)](https://www.kb.nl/over-ons/diensten/de-nederlandse-bibliografie, the catalogue of the National Library of the Netherlands. Together, these files span the period from 1800 to 2000, with each file covering a twenty-five-year segment.

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

- [sigma.js - a JavaScript library aimed at visualizing graphs of thousands of nodes and edges](https://www.sigmajs.org/)
- [ipysigma — Easily visualize networks with thousands of nodes and edges in Python](https://medium.com/@msdatashift/ipysigma-easily-visualize-networks-with-thousands-of-nodes-and-edges-in-python-3ecdbe0321de)
- [ipysigma (GitHub)](https://github.com/medialab/ipysigma)
- [Llama Extract](https://www.llamaindex.ai/llamaextract)

## Learning keys
### Concepts
This lesson explores how library catalogue metadata, or the structured information recorded about a library item, can be transformed into network data to better understand relationships within a collection. This metadata may include details such as title, author, publication information, and related subjects. Subject headings are especially useful for this process because they provide a structured way of describing what a library item is about and can therefore be used to identify meaningful connections between items.

Using subject headings as the basis for connection, we will examine how catalogue records can be represented as a network graph. In this visual representation, nodes stand for entities within the network, such as subjects or items, while edges show the relationships that connect those nodes. Viewing catalogue metadata in this way allows us to see how different parts of a collection relate to one another and to identify clusters, or groups of nodes that are more closely connected to each other. We will also consider how [centrality](https://en.wikipedia.org/wiki/Centrality) can help measure which nodes are especially important or highly connected within the network.

The lesson will then demonstrate how interactive visualisations can support collection analysis and development by making patterns, clusters, and relationships easier to explore. By comparing network visualisations created from catalogue data at different points in time, librarians can gain insight into how a collection has developed historically and how it may continue to evolve in the future. These concepts will be demonstrated through a workflow built with Python, ipysigma, and JavaScript sigma.js

### Terms
see above

### Time

## Learning experiment
### Aims
The aim of this lesson is to demonstrate how librarians and researchers can use network analysis to explore library collections in new ways. It shows how catalogue metadata, specifically subject headings, can be transformed into visual evidence that can be used to explore a collection in new ways. The example uses open source library data from the Dutch National Library, but any library metadata dataset could be used. 
### Inventory
This lesson has four main components: data and cleaning, reverting to network data, visualizing the data, analyzing the results.  
### Workflow
1. data and cleaning 
2. reverting to network data
3. visualizing the data 
4. Analyzing the Results

Looking at the eight graphs, we start to see patterns emerge. The most obvious factor being the size of the collection under this topic. Over the years, the network gets denser and denser. Doubling between both 1926-1950 and 1951-1975. What inspired this? Was there just being published? Curiously, after these two periods, in 1976-2000, the collection was halved. There are many possible reasons for this, did the subject headings change? Did the format of what the library was buying change and these items are left out? Did the budget or focus on the collection change? Where less books published in Dutch? There is much to explore and find out from posing these question just by the number of items themselves. 

### Summary


## Local application
While this example uses metadata from publically available datasets, the same process could be applied to an institutional specific dataset made up of MARC records from that collection. Extracting those records and applying similar analysis through these steps could help better understand how your local collections connect and cluster.
### Apply this method
What questions do you have about your library, whether it be the one you work at or use? Formulating a question will help you get started on what you want to explore based off this example. 

Once you have your questions, download a file of data about your library collection including the metadata categories that you want to explore such as the subject headings example here. Once the data is ready, you should be able to replicate the visualization process to meet your needs. 
 
### Other projects
### Continued learning

## Endnotes
