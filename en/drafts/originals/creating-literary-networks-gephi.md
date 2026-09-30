---
title: "Creating Thematic Network Data and Visualisations of Literary Texts in Gephi"
slug: creating-literary-networks-gephi
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Simran Bhimjyani
- Shanmugapriya T
reviewers:
- Forename Surname
- Forename Surname
editors:
- Laura Alice Chapot
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/695
difficulty: intermediate
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

This is an intermediate level lesson which introduces [network analysis](https://en.wikipedia.org/wiki/Network_science) for literary texts. Unlike the more commonly studied [social network analysis](https://en.wikipedia.org/wiki/Social_network_analysis), we focus on thematic network analysis, guiding you through the process of building structured data from any literary text.Centred on a case study of flora and fauna references in a selection of William Shakespeare's comedies and tragedies, this lesson aims to deliver a comprehensive workflow for constructing, analysing, and interpreting thematic networks using Gephi.Readers will learn to build [two-mode (affiliation) networks](#two-mode-networks-for-thematic-analysis) connecting characters to plant and animal categories, process and measure these networks in Gephi, and evaluate the resulting visualisations as analytical evidence showing how natural imagery is distributed across characters and dramatic genres.While grounded in Shakespearean drama, the methodology, data preparation procedures, and analytical techniques outlined here provide an adaptable framework suitable for a wide range of literary corpora, textual genres, and research questions. This lesson is especially valuable if your research examines how a theme, motif, or reference category spreads across characters, texts, or genres rather than mapping direct interpersonal relationships between characters.

This lesson assumes basic familiarity with Gephi and with introductory network analysis concepts. Readers new to either will find suggested starting points under [Prerequisites](#prerequisites). It also complements David Merino Recalde's two-part *Programming Historian en español* lesson on character networks, as explained [below](#relationship-to-other-programming-historian-lessons). This lesson focuses on three methodological questions that arise when building a thematic network: how to define and extract references to a theme from literary sources, how to structure the data so that it represents two different kinds of nodes, and which network metrics suit this kind of network, and why.

## Lesson Objectives

By the end of this lesson, you will be able to:

- Distinguish between one-mode networks, which link entities of a single type (such as characters), and two-mode or affiliation networks, which link entities of different types (such as characters and themes).
- Define the entities, relationships, and extraction criteria for a thematic network in relation to a specific research question.
- Transform a table of literary observations into node and edge files that Gephi can read.
- Import these files into Gephi and check that the resulting network is complete and correctly weighted.
- Select layouts and statistics suited to a weighted two-mode network, and explain why they are appropriate.
- Use visual encoding (node size, colour, and labels) to produce a legible, publication-ready figure.
- Interpret a network visualisation as evidence for an argument, recognising what the method can and cannot show.

## Introduction

### The Case Study: Nature in Shakespeare's Comedies and Tragedies

The lesson is built around the following research question: *Which characters in Shakespeare's comedies and tragedies speak about the natural world, what kinds of nature do they invoke, and do these patterns differ between the two genres?*

To answer it, we work with a corpus of 27 plays: 15 comedies and 12 tragedies. The history plays are excluded, and plays that sit at the boundaries between genres, such as *The Winter's Tale* and *Cymbeline*, have been assigned a genre as explained in the section [Step 2: Selecting the Corpus](#step-2-selecting-the-corpus). The references to flora and fauna are drawn from Bessie Mayou's *Natural History of Shakespeare* (1877), an anthology that gathers quotations from Shakespeare's plays and poems under 14 headings such as Garden Flowers, Trees, Birds, and Reptiles.[^1] Mayou's anthology provides two things: the quotations themselves, and a ready-made classification of the plants and animals they mention. From the quotations taken from the 27 plays in our corpus, we recorded every reference as a separate observation and added further information about the speaking character and the play. The process is explained step by step in [Stage 2](#stage-2-constructing-the-dataset).

The following files accompany this lesson and can be downloaded now from the [lesson repository](https://github.com/Simran-DH/Eco-Computational-Shakespeare-Ecological-Network-Analysis):

- `master_data.csv`: the master table of observations, with one row per reference. This is the starting point for everything else in the lesson.
- `node_main-topic_character.csv` and `edge_main-topic_character.csv`: the node and edge files for the network of nature categories (Main Topics) and characters.
- Node and edge files for three further combinations:
  - Main Topic and gender: `node_main-topic_gender.csv` and `edge_main-topic_gender.csv`
  - Main Topic and genre: `node_main-topic_genre.csv` and `edge_main-topic_genre.csv`
  - Sub-topic and character: `node_sub-topic_character.csv` and `edge_sub-topic_character.csv`
- `Extraction prompts`: the two prompts used to extract the references from Mayou's anthology, discussed in Stage 2.

In Stage 2, you will build `node_main-topic_character.csv` and `edge_main-topic_character.csv` yourself from `master_data.csv`, and can then check your versions against the supplied files before importing them into Gephi. The Sub-topic and genre files let you reproduce the further networks discussed in Stage 4 without repeating the construction steps. The gender files are not discussed in the lesson, but are supplied so that you can build and interpret that network yourself, applying the same steps. All of these files can also serve as models for combinations of your own.

By the end of the lesson, you will have produced three networks: one linking characters to nature categories, one linking characters to individual plants and animals, and one linking the two genres to nature categories. Together, they allow you to investigate how strongly the nature references in these plays lean towards animals rather than plants, which particular creatures account for that imbalance, and how comedy and tragedy each shape the pattern.

### Relationship to Other *Programming Historian* Lessons

This lesson complements David Merino Recalde's two-part Spanish-language lesson, "Análisis de redes sociales de personajes teatrales" ("Social Network Analysis of Theatrical Characters").[^2] Merino Recalde's lesson builds a network of a single play in which characters are linked to one another, for example by appearing on stage together, and uses it to read the play's internal social structure. This lesson builds a different kind of network: one that links characters to categories of natural reference across a corpus of plays. The two lessons can be read as a pair, and readers new to Gephi may find it useful to work through Merino Recalde's lesson first.

### Prerequisites

This is an intermediate lesson. It concentrates on the decisions and techniques specific to thematic, two-mode networks, and does not re-introduce the basics of network analysis or of Gephi's interface.

**Conceptual knowledge.** You should be comfortable with the following terms: *node*, *edge*, *weight*, and *degree*. If these are new to you, the following resources provide a good introduction:

- Scott Weingart, "[Demystifying Networks, Parts I & II](https://journalofdigitalhumanities.org/1-1/demystifying-networks-by-scott-weingart/)," *Journal of Digital Humanities* 1, no. 1 (2011).
- Marten Düring, "[From Hermeneutics to Data to Networks: Data Extraction and Network Visualization of Historical Sources](https://programminghistorian.org/en/lessons/creating-network-diagrams-from-historical-sources)," *Programming Historian* 4 (2015).
- John R. Ladd, Jessica Otis, Christopher N. Warren, and Scott Weingart, "[Exploring and Analyzing Network Data with Python](https://programminghistorian.org/en/lessons/exploring-and-analyzing-network-data-with-python)," *Programming Historian* 6 (2017).
- David Merino Recalde, "[Análisis de redes sociales de personajes teatrales (parte 1)](https://doi.org/10.46430/phes0064)" and "[Análisis de redes sociales de personajes teatrales (parte 2)](https://doi.org/10.46430/phes0065)," *Programming Historian en español* 7 (2023).

Other terms used in this lesson, including *two-mode network*, *weighted degree*, and *modularity*, are explained at the point where you first need them.

**Technical requirements.** You will need:

- **Gephi**, a free, open-source application for network analysis and visualisation, available for Windows, macOS, and Linux from [gephi.org](https://gephi.org).[^3] This lesson was written using Gephi version 0.10.1. Menu names and dialog layouts may differ slightly in other versions, so the lesson explains what each setting does as well as where to find it.
- **Spreadsheet software** that can save files in CSV format, such as Microsoft Excel or Google Sheets.
- A basic familiarity with Gephi's three main tabs: **Overview**, where you arrange, measure, and style the network; **Data Laboratory**, a spreadsheet-style view of the node and edge tables; and **Preview**, where you render and export the final figure. The **Context** panel, at the top right of the Overview tab, reports the number of nodes and edges in the current network and whether it is directed or undirected. We will use it to check our imports.

Other tools, such as the browser-based [Gephi Lite](https://gephi.org/gephi-lite/), Cytoscape, or Palladio, can read the same CSV files. We use Gephi because it is widely taught, freely available, and shows the visual network and its underlying data tables side by side, which makes it easy to verify what a visualisation is showing.

**Multilingual considerations.** Gephi's interface has been translated into a range of languages by a community of volunteer translators, coordinated through the [Weblate](https://hosted.weblate.org/projects/gephi/) platform. Available languages include French, German, Czech, Greek, Catalan, Dutch, Arabic, and Chinese, although the completeness of each translation varies, so some parts of the interface may still appear in English. The current status of each language can be checked on the Weblate project page. This lesson refers to menus and settings by their English names, but it also explains what each setting does, so that readers using another interface language can identify the equivalent option. The workflow itself is not specific to English: the same steps apply to texts in any language, provided that your categories and extraction rules are designed for that language and its literary traditions. When working with accented characters or non-Latin scripts, save all files with UTF-8 encoding, as described below, so that names are imported correctly.

### Lesson Overview

The lesson follows four stages, each corresponding to a main section:

1. **[Modelling Literary Relationships as Networks](#stage-1-modelling-literary-relationships-as-networks).** We consider the different ways in which literary relationships can be modelled as networks and explain why a two-mode network suits our research question.
2. **[Constructing the Dataset](#stage-2-constructing-the-dataset).** We define the entities and relationships to be modelled, select the corpus, set out the criteria for categorising and extracting references, build a master table of observations, and transform it into node and edge files.
3. **[Importing and Analysing the Network in Gephi](#stage-3-importing-and-analysing-the-network-in-gephi).** We import the files, check that the network is complete, arrange it with layout algorithms, and calculate the measures that suit a two-mode network.
4. **[Visualising and Interpreting the Network](#stage-4-visualising-and-interpreting-the-network).** We style and export the figure, build further networks from the same data, and work through how to move from a visualisation to a supported interpretation.

## Stage 1: Modelling Literary Relationships as Networks

### Character Networks and Beyond

Network analysis entered literary study from the social sciences, where it was developed to map relationships between people, and its earliest literary applications asked a similar question: who is connected to whom? It has since become a common method in computational literary studies, and open-access corpora such as the DraCor project have made character networks of drama widely available.[^4] Shakespeare's plays have been studied in this way many times, from Franco Moretti's early experiments with the network of *Hamlet*[^5] to later studies that modelled the plays as character networks.[^6] In such networks, each character is a node, and an edge links two characters when they appear in the same scene, speak to one another, or are named together. The result is a map of a work's social world, which can show which characters hold it together, which sit at its margins, and how its groups are organised.

Networks can, however, model many kinds of literary relationship. The two ends of an edge need not both be characters: a character can be linked to a place they inhabit, an object they handle, or a theme they invoke. Each of these choices offers particular analytical possibilities and brings its own methodological considerations.

### Two-Mode Networks for Thematic Analysis

A network in which every node is the same kind of entity, such as characters linked to characters, is called a **one-mode network** (Figure 1).

{% include figure.html filename="en-or-creating-literary-networks-gephi-01.png" alt="Diagram of four circular nodes labelled Hamlet, Horatio, Gertrude, and Claudius, connected to one another by lines." caption="Figure 1. A one-mode network, with characters linked to characters." %}

When the two ends of an edge belong to different kinds of entity, for instance characters on one side and themes on the other, the result is a **two-mode** or **affiliation network** (Figure 2).[^7] In a two-mode network, edges only ever connect a node of one type to a node of the other type: a character can be linked to a theme, but never directly to another character. Where a one-mode network asks "who is connected to whom?", a two-mode network asks "who is connected to what?". In a literary context, this makes it possible to study thematic as well as social patterns.

{% include figure.html filename="en-or-creating-literary-networks-gephi-02.png" alt="Diagram with three circular nodes labelled Hamlet, Rosalind, and Ophelia on the left and two square nodes labelled Reptiles and Trees on the right. Lines connect circles to squares only." caption="Figure 2. A two-mode network, with characters linked to categories of nature." %}

This lesson builds a two-mode network to address our research question. Each character is a node; each category of natural reference (Trees, Birds, Animals, Garden Flowers, and so on) is also a node; and an edge connects a character to a category whenever that character's lines mention a plant or animal belonging to it. The more often a character invokes a category, the heavier the edge. The resulting network offers a structured picture of which characters speak about the natural world, which kinds of nature they reach for, and how those patterns vary across the corpus.

### Thematic Network Analysis in Literary Studies

Networks that connect characters to themes, motifs, or figurative fields remain less common than character networks, but they are beginning to be explored, for instance in work on figurative topic networks in *Timon of Athens*[^8] and on ecological themes in computational drama analysis.[^9] This lesson builds on those precedents and offers a reproducible workflow for readers who wish to apply thematic network analysis to texts of their own. Its value lies in scale: it lets us examine, across a whole corpus, a question that close reading usually approaches one play at a time.

## Stage 2: Constructing the Dataset

Every Gephi network is built from two tables: a **node table**, which lists the entities in the network, and an **edge table**, which lists the connections between them. Before you can create these tables, you need to make several decisions: what the nodes and edges represent, which texts to include, and what counts as a relevant observation. This stage walks through each decision in turn, explains the choice made for the Shakespeare data, and then shows how the node and edge files are built. At each step, consider what the equivalent decision would be for your own project.

### Step 1: Defining the Entities and Relationships

Your research question determines what your nodes and edges should be. A question about who speaks to whom makes characters the nodes and their interactions the edges. Our question, which characters speak about which kinds of nature, requires two kinds of node and one kind of relationship:

- **Character nodes**: the speaking characters of the plays, such as Hamlet, Rosalind, and Macbeth.
- **Category nodes**: the 14 categories of flora and fauna defined by Mayou. Five relate to fauna (Animals, Birds, Fish, Reptiles, and Insects) and nine to flora (Garden Flowers, Wild Flowers, Weeds, Trees, Fruits, Vegetables, Herbs, Spices and Medicines, and Grain).
- **Edges**: an edge joins a character to a category and means "this character mentions a plant or animal from this category in their dialogue".

We made two further choices about the edges.

First, the network is **undirected**. A mention does not flow from one node to another in the way that, say, a letter passes from sender to recipient. It records an association between a character and a category, so an edge from Hamlet to Reptiles means the same as an edge from Reptiles to Hamlet.

Second, the network is **weighted**. Each edge carries a number recording how many times the character mentions something from that category: Hamlet refers to reptiles seven times in our data, so the Hamlet–Reptiles edge has a weight of seven (Figure 3). Weighting matters particularly in this network. Because there are only 14 categories, no character can have more than 14 edges, and simply counting a character's connections says little about how much they talk about nature. A character who mentions a bird once and a character who mentions birds twenty times would each have a single edge to Birds. The weights preserve this difference, and, as we will see in Stage 3, they are the basis of the measures we use.

{% include figure.html filename="en-or-creating-literary-networks-gephi-05.png" alt="Diagram of two circular nodes labelled A and B joined by a thick line labelled with the number 5." caption="Figure 3. A weighted edge: the thickness of the line records the strength of the connection." %}

> **Adapting the workflow:** For your own project, write down your research question and then state in one sentence what a node of each type represents and what a single edge means.

### Step 2: Selecting the Corpus

The composition of a corpus should follow from the research question, and it defines the scope of the claims you can make. A single play may be enough for an in-depth study of one work; identifying broader patterns requires a larger selection. You might choose an author's complete works, a random sample, or a set balanced by genre or period.

Because our question compares comedy and tragedy, our corpus consists of 27 plays from these two genres: every comedy and tragedy in the First Folio (1623), together with *Pericles*. This gives 15 comedies and 12 tragedies. The history plays and the poems are excluded. The full list of plays, with the genre assigned to each, can be found in the Play and Genre columns of `master_data.csv`.

Several plays sit at the boundaries between genres, and each required an explicit classification decision. Our rule was to follow the First Folio wherever it assigns a genre. *The Tempest* and *The Winter's Tale*, often grouped with the late romances, are classified here as comedies, following their placement among the comedies in the Folio. *Cymbeline*, also often grouped with the romances, is classified here as a tragedy, following its placement in the Folio as *The Tragedie of Cymbeline*. The genre of *Troilus and Cressida* has long been disputed: the Folio omits it from its table of contents and prints it between the histories and the tragedies. However, the Folio text itself is headed *The Tragedie of Troylus and Cressida*, so we classify it as a tragedy. *Pericles*, which is not included in the First Folio, is classified here as a comedy: it was added only in the second issue of the Third Folio (1664), as an appendix without a genre designation, and we group it with *The Tempest* and *The Winter's Tale*, the late romances that the First Folio places among the comedies.

These decisions matter because other editors and critics classify these plays differently, and a reader using another classification would obtain different results for the genre comparison. When adapting this workflow, record your own genre assignments and their sources in the same way.

The two genres are not equally represented: there are more comedies than tragedies. When comparing the genres, it is therefore safer to compare proportions or averages per play than raw totals, as we do in Stage 4. Because the histories and poems are excluded, our findings describe Shakespeare's comedies and tragedies, not his work as a whole.

Corpus construction raises wider questions about representativeness and sampling that are beyond the scope of this lesson. For further discussion, see Andrew Piper's work on literary data and sampling.[^10]

### Step 3: Establishing Categorisation and Extraction Criteria

Next, you need rules that decide what counts as an observation and how it is classified. No universal standards exist, but the rules must be applied consistently and documented, because they shape every number the network later produces. For any thematic network, you will need to decide at least the following:

- **Where the observations come from.** All our observations come from the quotations in Mayou's anthology; we did not extract references from complete editions of the plays. For each quotation that Mayou takes from a comedy or tragedy in our corpus, we recorded each plant or animal mentioned as a separate observation, using the speaker and play attribution she gives. Because Mayou selected her quotations rather than listing every mention, our counts are a lower bound on the plays' nature references, a limitation we return to in the conclusion.
- **How references are classified.** We adopted Mayou's classification without modification. She groups quotations under 14 main headings, which we record as **Main Topics**, and, within each, under the name of a specific plant or animal, which we record as **Sub-topics**: for example, the Sub-topic Rose belongs to the Main Topic Garden Flowers. The distinctions between Animals and Birds, and between Trees and other plants, are Mayou's. Using an existing, published classification means that our categories are transparent and can be checked by other readers, although it also means that they reflect a nineteenth-century view of natural history rather than a modern one.
- **Unit of counting.** We counted each occurrence, so a speech that names the same animal twice produces two rows. The alternative, counting each speech only once per category, would reduce the influence of long, repetitive speeches.
- **Ambiguous words.** Words such as "rose" can have several meanings. We followed Mayou's placement of each quotation to decide which plant or animal a word refers to, so ambiguous cases were resolved by her classification rather than by our own judgement.
- **Character names.** Each character must have a single, unique name across the whole corpus. Where characters with the same name appear in different plays, we added an abbreviation of the play title as a prefix, so that, for example, Antony in *Antony and Cleopatra* is recorded as `AC_Antony`. Without this step, Gephi merges different characters into a single node and counts their references together.

Keep a short document (for example, a README file saved alongside your data) that records each of these decisions. It will make your dataset easier to reuse, and it makes clear to your readers where your numbers come from.

### Step 4: Building the Master Table

#### Extracting the References

Extracting the references from Mayou's anthology presented several challenges, and the approach we eventually took is worth describing, because you are likely to face similar decisions with your own sources.

We first attempted a purely programmatic approach, using OCR and simple parsing in Python to extract pairs of characters and references on the basis of a consistent textual pattern: a capitalised character name followed by a colon. However, the formatting of the source was too irregular for this rule-based method to work reliably. Given our limited Python expertise, we turned to ChatGPT (GPT-4), in 2025, for the initial extraction, which we carried out in two stages:

1. A first prompt extracted the Main Topic, Sub-topic, character name, play title, and act and scene numbers for each reference. The act and scene numbers were not retained in the final master table, which records each reference at the level of the play.
2. A follow-up prompt classified each character by gender (male, female, supernatural, or group) and assigned each play to a genre.

Both prompts are reproduced in the file `Extraction prompts` in the lesson repository.

We then checked every row of the output against Mayou's text, and the checking proved essential. Nearly half of the extracted rows attributed a reference to the wrong speaker. More than 200 references had been missed entirely and had to be added manually. Some entries had been invented, with no corresponding quotation in Mayou, and several characters had been assigned the wrong gender. The quality of the OCR text also introduced spelling errors into character names, which, if left uncorrected, would have split a single character into several nodes in Gephi. All of these errors were corrected manually before the master table was finalised. The genre assignments were also decided by us rather than taken from the model: every play was assigned to comedy or tragedy according to the First Folio, as explained in Step 2.

If you use a language model to assist with extraction in your own project, treat its output as a first draft to be checked, not as data. Record the model, the approximate date, and the exact prompts, so that others can understand how your dataset was produced, and verify every row against the source. Where your source has a regular structure, a rule-based script may be more transparent and reproducible, and the *Programming Historian* lessons on OCR and text processing in Python are a good starting point.

#### Structuring the Master Table

The most useful habit in building any network dataset is to keep one **master table** of observations, with one row for every individual instance you find. Each time you find a relevant reference, you add a row recording it together with any information you might later want to analyse. The node and edge files are then derived from this table, so you can build many different networks without returning to the texts.

Our master table has seven columns:

| Column | Content | Source |
|---|---|---|
| Main Topic | One of Mayou's 14 categories | Mayou |
| Sub-topic | The specific plant or animal named | Mayou |
| Character | The character who speaks the line | Mayou, extracted with ChatGPT and checked by us |
| Play | The play in which the line occurs | Mayou, extracted with ChatGPT and checked by us |
| Genre | Comedy or tragedy | Assigned by us, following the First Folio |
| Gender | Male, female, supernatural, or group | ChatGPT, checked and corrected by us |
| Status | Whether the character has a major or minor role in the plot | Assigned by us |

The Gender column records characters who speak collectively, such as a group of servants or musicians, as "group". The Status column was assigned by us according to each character's role in the plot: characters central to the main action are recorded as major, and all others as minor. This is an interpretive judgement rather than a measurement. If you need a more consistent criterion for your own project, you could base status on a quantitative measure, such as the number of lines or scenes in which a character speaks, which corpora such as DraCor provide for many plays.

Table 1 shows the first rows of the master table.

| Main Topic | Sub-topic | Character | Play | Genre | Gender | Status |
|---|---|---|---|---|---|---|
| Garden Flowers | Rose | Oberon | A Midsummer Night's Dream | Comedy | Male | Major |
| Garden Flowers | Rose | Titania | A Midsummer Night's Dream | Comedy | Female | Major |
| Garden Flowers | Rose | Don John | Much Ado About Nothing | Comedy | Male | Major |
| Garden Flowers | Rose | Orsino | Twelfth Night | Comedy | Male | Major |
| Garden Flowers | Rose | Biron | Love's Labour's Lost | Comedy | Male | Minor |
| Garden Flowers | Rose | Boyet | Love's Labour's Lost | Comedy | Male | Minor |
| Garden Flowers | Rose | Boyet | Love's Labour's Lost | Comedy | Male | Minor |
| Garden Flowers | Rose | Touchstone | As You Like It | Comedy | Male | Minor |
| Garden Flowers | Rose | Petruchio | The Taming of the Shrew | Comedy | Male | Minor |
| Garden Flowers | Rose | AC_Antony | Antony and Cleopatra | Tragedy | Male | Major |
| Garden Flowers | Rose | Othello | Othello | Tragedy | Male | Major |
| Garden Flowers | Rose | Juliet | Romeo and Juliet | Tragedy | Female | Major |
| Garden Flowers | Lily | Princess | Love's Labour's Lost | Comedy | Female | Major |
| Garden Flowers | Lily | Perdita | The Winter's Tale | Comedy | Female | Major |
| Garden Flowers | Lily | Troilus | Troilus and Cressida | Tragedy | Male | Major |
| Garden Flowers | Lily | Guiderius | Cymbeline | Tragedy | Male | Major |
| Garden Flowers | Lily | Titus | Titus Andronicus | Tragedy | Male | Major |
| Garden Flowers | Carnation | Perdita | The Winter's Tale | Comedy | Female | Major |

Table 1. The first few rows of the master table of observations.

Note that Boyet appears twice with the same Sub-topic: he mentions roses twice, and each mention is a separate row. These repeated rows are what will later become edge weights. The full master table contains 1,016 rows, one for each reference.

### Step 5: Creating the Edge File

With the master table complete, you can derive the files for any pair of columns. We start with the network of Main Topics and characters.

1. Create a new, empty sheet.
2. From the master table, copy the Main Topic column and the Character column into the new sheet, side by side.
3. **Do not remove duplicate rows.** Every repeated row is a separate reference, and Gephi will add the repetitions together into edge weights when you import the file (see Stage 3).
4. Rename the two column headers `Source` and `Target`. Gephi uses these names to recognise the two ends of each edge. Because our network is undirected, it does not matter which column is which.
5. Save the sheet as a CSV file with UTF-8 encoding, for example `edge_main-topic_character.csv`.

Table 2 shows the first rows of the resulting edge file.

| Source | Target |
|---|---|
| Garden Flowers | Oberon |
| Garden Flowers | Titania |
| Garden Flowers | Don John |
| Garden Flowers | Orsino |
| Garden Flowers | Biron |
| Garden Flowers | Boyet |
| Garden Flowers | Boyet |
| Garden Flowers | Touchstone |
| Garden Flowers | Petruchio |
| Garden Flowers | AC_Antony |
| Garden Flowers | Othello |
| Garden Flowers | Juliet |

Table 2. The first rows of the edge file, created from the Main Topic and Character columns.

### Step 6: Creating the Node File

The node file lists every entity that appears in the edge file exactly once, and records what type of entity each one is.

1. Create another new sheet.
2. From the master table, copy the Main Topic column, then paste the Character column directly beneath it, so that both sets of values sit in a single column.
3. This column contains many repeats (Hamlet appears 24 times and Reptiles 95 times), so remove the duplicates. In Google Sheets or a recent version of Excel, you can use the `UNIQUE` function; in any spreadsheet, you can use the **Remove duplicates** command in the **Data** menu. The result is a list with one row per node.
4. Name this column `Id`. Gephi uses the Id to match nodes to the Source and Target values in the edge file, so every Id must be spelt exactly as it is in the edge file, including capitalisation and spacing.
5. Copy the column into a second column named `Label`. The Label is the name Gephi displays on the node. Keeping it separate from the Id means you can later change how a node is displayed (for example, `Antony` instead of `AC_Antony`) without breaking its connections.
6. Add a third column named `Type`, and enter `Main topic` for each of the 14 categories and `Character` for every character. This column records which mode each node belongs to; in Stage 4 you can use it to colour the two kinds of node differently.
7. Save the sheet as a CSV file with UTF-8 encoding, for example `node_main-topic_character.csv`.

Table 3 shows the first rows of the resulting node file.

| Id | Label | Type |
|---|---|---|
| Garden Flowers | Garden Flowers | Main topic |
| Wild Flowers | Wild Flowers | Main topic |
| Weeds | Weeds | Main topic |
| Trees | Trees | Main topic |
| Fruits | Fruits | Main topic |
| Vegetables | Vegetables | Main topic |
| Herbs | Herbs | Main topic |
| Spices And Medicines | Spices And Medicines | Main topic |
| Grain | Grain | Main topic |
| Birds | Birds | Main topic |
| Animals | Animals | Main topic |
| Fish | Fish | Main topic |
| Reptiles | Reptiles | Main topic |
| Insects | Insects | Main topic |
| Oberon | Oberon | Character |
| Titania | Titania | Character |
| Don John | Don John | Character |
| Orsino | Orsino | Character |
| Biron | Biron | Character |

Table 3. The first rows of the node file, with the Id, Label, and Type columns.

If you wish, compare your two files with `node_main-topic_character.csv` and `edge_main-topic_character.csv` supplied with the lesson. They should contain the same rows, although not necessarily in the same order.

### Step 7: Building Other Combinations

The procedure you have just followed works for any pair of columns in the master table. In summary: choose the two columns that express your question; copy them into a new sheet to form the edge file, keeping the duplicates; then list the unique values from both columns to form the node file, removing the duplicates, and add a Type column. Changing the pair of columns changes the question the network can answer:

| Column pair | Question it helps to answer | Supplied with the lesson |
|---|---|---|
| Main Topic and Character | Which characters speak about which kinds of nature? | Yes |
| Sub-topic and Character | Which specific plants and animals do characters name? | Yes |
| Main Topic and Genre | How do comedy and tragedy differ in the kinds of nature they invoke? | Yes |
| Main Topic and Gender | Do male, female, supernatural, and group characters invoke different kinds of nature? | Yes |
| Main Topic and Play | Which plays draw on which kinds of nature? | No |

Note that in some of these networks one set of nodes is very small. The genre network, for example, has only two nodes of one type (Comedy and Tragedy) and 14 of the other. Such networks are best read mainly through their edge weights, as we will see in Stage 4.

## Stage 3: Importing and Analysing the Network in Gephi

In this stage we import the Main Topic and character files into Gephi, check that the network has been built correctly, and prepare it for visualisation by arranging it and calculating two measures.

### Importing the Node File

Open Gephi, choose **New Project** from the **File** menu, and click the **Data Laboratory** tab. Always import the node file first and the edge file second. Loading the nodes first means that when Gephi reads the edges, every character and category they refer to already exists in the network, together with its Type.

Click **Import Spreadsheet** in the Data Laboratory toolbar and select `node_main-topic_character.csv`.

1. On the first screen, check that **Separator** is set to Comma and **Charset** to UTF-8, so that apostrophes and accented names are read correctly. Set **Import as** to "Nodes table", and check that the preview shows the Id, Label, and Type columns. Click **Next**.
2. On the second screen, Gephi lists the columns it has found and how it will import each one. The defaults are correct for our file, so click **Finish**.
3. In the import report window, set **Graph Type** to Undirected and select **New workspace**. Click **OK**.

{% include figure.html filename="en-or-creating-literary-networks-gephi-09.png" alt="Screenshot of Gephi's spreadsheet import dialog, showing the separator set to Comma, Import as set to Nodes table, charset UTF-8, and a preview of the Id, Label, and Type columns." caption="Figure 4. The node-import screen." %}

### Importing the Edge File

Click **Import Spreadsheet** again and select `edge_main-topic_character.csv`.

1. On the first screen, confirm that the separator is Comma and the charset is UTF-8, and set **Import as** to "Edges table". Gephi will recognise the Source and Target columns. Click **Next**, then **Finish**.
2. The import report will list 1,016 edges and warn that parallel edges have been detected. Parallel edges are two or more edges between the same pair of nodes, here the repeated rows you deliberately kept in Step 5. Three settings in this window determine how they are handled:
   - Set **Graph Type** to Undirected.
   - Set **Edges merge strategy** to Sum. This tells Gephi to combine every set of parallel edges into a single edge, whose weight is the sum of the individual edges. Since each row has a weight of one, the weight of each merged edge equals the number of times the character mentions that category. This is the step that turns your repeated rows into weighted edges.
   - Select **Append to existing workspace**, so that the edges are added to the nodes you have already imported rather than to a new, empty network.
3. Click **OK**.

### Checking the Imported Network

Before going further, check that the network matches your data.

- **Node and edge counts.** The Context panel should report 297 nodes and 650 edges. The 1,016 rows of the edge file have been merged into 650 distinct character–category pairs. If the edge count is still 1,016, the merge strategy was not applied; delete the workspace and import the edge file again.
- **Missing nodes.** If the node count is higher than the number of rows in your node file, some names in the edge file do not match any Id in the node file exactly (for example, because of a spelling variant or a trailing space). The **Create missing nodes** option in the import report adds these as new nodes without a Type. In the Data Laboratory's **Nodes** table, sort by the Type column to find any nodes with an empty Type, and correct the spelling in your CSV files.
- **Edge weights.** In the Data Laboratory's **Edges** table, sort by the Weight column. The weights should be whole numbers greater than zero, and the heaviest edges should involve characters and categories you would expect to be prominent.

These checks take a few minutes, but they catch the most common errors in network data before they affect your results.

### Arranging the Network with Layouts

Switch to the **Overview** tab. When the data first loads, Gephi places the nodes randomly, and the network appears as an unreadable knot. A **layout** algorithm arranges the nodes in space to make the structure legible.

A layout changes only the position of the nodes on screen. It never alters the nodes, edges, or weights, so you can run, undo, and rerun layouts as often as you like. It is also important to remember that the position of a node has no absolute meaning: there is no x or y axis to read. What a layout conveys is relative: which nodes sit close together and which sit apart.

We use layouts from the **force-directed** family, which are the usual starting point for literary networks. These algorithms treat nodes as objects that push one another apart, and edges as springs that pull connected nodes together. When the forces balance, nodes that share many or heavy connections end up close to one another, so groups of closely connected nodes appear as visible clusters. In our network, this means that a category will sit among the characters who mention it most, and characters with similar nature vocabularies will sit near one another.

Each layout starts from the positions left by the previous one, so we run four in sequence from the **Layout** panel at the bottom left of the Overview tab, each refining the arrangement:

1. **Yifan Hu.** Select Yifan Hu from the dropdown and click **Run**. This fast algorithm produces a reasonable overall arrangement in a few seconds by working first on a simplified version of the network and then on the full network.[^11] It gives the slower algorithm that follows a good starting point. Click **Stop** once the network settles.
2. **ForceAtlas 2.** Select ForceAtlas 2, a force-directed layout designed for networks of this kind, and adjust the following settings before running it:[^12]
   - **Scaling** controls how strongly nodes repel one another. Raise it (a value of around 100 works well for a few hundred nodes) so that the clusters are not cramped.
   - **Gravity** pulls all nodes towards the centre and stops loosely connected nodes from drifting off the canvas. Leave it near its default.
   - **Edge Weight Influence** controls how much edge weights affect the layout. At 0, weights are ignored; at 1.0, a heavier edge pulls its two nodes proportionally closer. Set it to 1.0, since the weights carry the meaning of our network.
   - Make sure **Inverted edge weights** is unticked. When it is ticked, heavier edges push nodes apart instead of drawing them together, which would reverse the meaning of the layout.

   Click **Run**. ForceAtlas 2 runs until you stop it, so click **Stop** once the movement has almost ceased, usually after 10 to 20 seconds. Then tick **Prevent Overlap** and run it for a few more seconds, so that nodes no longer sit on top of one another.
3. **ForceAtlas.** Run the original ForceAtlas briefly as a final pass to even out the spacing, then click **Stop**.
4. **Label Adjust.** Run Label Adjust for a moment. It moves nodes slightly so that their labels do not overlap, which improves legibility without changing the overall arrangement.

The **Expansion**, **Contraction**, and **Reset** options spread the nodes out, draw them in, and return them to random positions respectively. Experimenting with different layouts on the same data is a useful way to learn what each one emphasises. If you change the settings for your own network, keep in mind the principle behind them: in a weighted network where weights carry meaning, the layout should let heavier edges pull harder.

### Measuring the Network: Weighted Degree and Modularity

Network analysis offers many measures, and not all of them suit every network. The structure of a two-mode network makes some common measures much less informative than they are in a character network, so it is worth considering why before running any statistics.

In a character network, **path-based** measures such as *betweenness centrality* (how often a node lies on the shortest path between other nodes) and *closeness centrality* (how near a node is, on average, to all others) are often used to identify characters who connect different parts of a play's social world. In our network, however, characters are never connected to one another directly. The shortest path between any two characters must pass through a category, and usually through one of the few very large categories such as Animals or Birds. As a result, path-based measures mostly re-describe the size of these large category nodes, which we call **hubs**, and say little about individual characters. Plain **degree** (the number of edges a node has) is also limited here, because, as noted in Step 1, no character can have more than 14 edges.

We therefore use two measures that do suit a weighted two-mode network. Open the **Statistics** panel on the right of the Overview tab.

**Weighted degree.** Click **Run** beside **Avg. Weighted Degree**. Gephi adds a Weighted Degree column to the node table, recording for each node the sum of the weights of its edges. Because each edge weight is a number of mentions, weighted degree has a direct meaning in our network: for a category, it is the total number of references to that category; for a character, it is the total number of nature references the character makes. This is the measure that tells us which categories and characters carry the most weight.

**Modularity.** Click **Run** beside **Modularity** (under Community Detection). Modularity detection divides the network into groups, or communities, whose nodes are more densely connected to one another than to the rest of the network.[^13] In our network, each community typically contains a category together with the characters most strongly attached to it, so the communities show which characters cluster around which kinds of nature. In the dialog:

- Keep **Use weights** ticked, so that heavier edges count for more when forming communities.
- Leave **Resolution** at 1.0. Lower values produce more, smaller communities; higher values produce fewer, larger ones. The default is a reasonable starting point, but if you change it, report the value you used.
- **Randomize** is ticked by default, which means that the results can vary slightly between runs. If your community assignments change a little when you rerun the statistic, this is expected.

Click **OK**. Gephi adds a Modularity Class column to the node table, assigning each node to a numbered community. The standard modularity algorithm was designed for one-mode networks, and specialised versions exist for two-mode networks.[^14] For our purposes, it provides a useful exploratory grouping, but communities should be treated as prompts for further investigation rather than as definitive findings.

The Weighted Degree and Modularity Class columns are what we turn into visual features in the next stage.

## Stage 4: Visualising and Interpreting the Network

### Styling the Network

The **Appearance** panel, at the top left of the Overview tab, links the values in the node table to visual features. Each choice here should make a specific pattern visible.

- **Node size by weighted degree.** With **Nodes** selected, click the size icon (the graduated circles), choose **Ranking**, select Weighted Degree, set a minimum and maximum size (for example, 8 and 70), and click **Apply**. Size now represents the total number of references, so the most frequently invoked categories and the most nature-oriented characters appear largest.
- **Node colour by community.** Click the colour icon (the palette), choose **Partition**, select Modularity Class, and click **Apply**. Each community takes its own colour, so a category and the characters most strongly attached to it share a colour. If you are more interested in distinguishing the two kinds of node than in communities, partition by Type instead, as in Figure 6 below.
- **Labels.** Switch on node labels with the **T** button on the toolbar beneath the graph. Then set label size with the label-size icon, choosing **Ranking** by Weighted Degree, so that only the prominent nodes carry large labels. With nearly 300 nodes, labelling everything equally would make the figure illegible.

### Rendering and Exporting the Figure

Switch to the **Preview** tab and click **Refresh** to render the styled network. Under **Node Labels**, tick **Show Labels** and select **Proportional size**, so that labels keep the sizes set in the previous step. Under **Edges**, lower the opacity so that the lines sit behind the nodes rather than obscuring them. Click **Refresh** after each change. When the image looks right, click **Export** and choose SVG or PDF for print, or PNG for the web. Figure 5 shows the result.

{% include figure.html filename="en-or-creating-literary-networks-gephi-11.png" alt="Network visualisation with nodes coloured by community. The largest nodes are labelled Animals and Birds, with smaller labelled nodes for Reptiles, Insects, and Trees, each surrounded by clusters of small character nodes in the same colour." caption="Figure 5. The network of Main Topics and characters." %}

### Visualising Other Combinations

Repeating Stages 3 and 4 with the other supplied files produces further networks from the same master table. Figure 6 shows the network of Sub-topics and characters, with nodes coloured by Type (plants and animals in green, characters in blue). Figure 7 shows the network of Main Topics and genre, in which the edge thickness represents the number of references and edges are coloured by category.

{% include figure.html filename="en-or-creating-literary-networks-gephi-12.png" alt="Dense network of several hundred nodes, green for plants and animals and blue for characters. The largest green node is labelled Dog; large blue nodes include Hamlet, Mercutio, and Rosalind." caption="Figure 6. The network of Sub-topics and characters." %}

{% include figure.html filename="en-or-creating-literary-networks-gephi-13.png" alt="Network with two large nodes labelled Comedy and Tragedy, each connected by curved edges of varying thickness to 14 smaller category nodes. The thickest edges link both genres to Animals and Birds." caption="Figure 7. The network of Main Topics and genre." %}

### Interpreting the Networks

A finished network is a form of evidence, not a conclusion. Interpreting it means returning to the research question and moving carefully from what the visualisation suggests to what the data can support. The process we follow has four steps, which you can apply to any network:

1. **Notice.** Look at the visualisation and identify the patterns that stand out: the largest nodes, the thickest edges, the most distinct clusters, and any nodes that sit apart from the rest.
2. **Verify.** Check each pattern against the underlying numbers in the Data Laboratory. A visualisation can exaggerate or hide differences, depending on the size range and layout you chose.
3. **Compare.** Test the pattern against a different network built from the same data. A pattern that holds across several combinations is more robust than one that appears in only one.
4. **Qualify.** State the claim at the level the data support, note what it depends on, and identify where close reading is needed.

We now apply these steps to the three networks.

**The Main Topic and character network (Figure 5).** The first thing that stands out is the size of the Animals and Birds nodes compared with every plant category. To verify this, go to the Data Laboratory, open the Nodes table, filter or sort by Type to show only the 14 categories, and sort by Weighted Degree. Because each category's weighted degree is its total number of references, this gives the counts directly: Animals has 305 references and Birds 186, whereas the largest plant categories, Trees and Fruits, have 77 and 62. To measure the overall balance, export the node table (using **Export table** in the Data Laboratory), add up the weighted degrees of the five fauna categories and of the nine flora categories, and divide each by the total of 1,016. Approximately 69% of references relate to fauna and 31% to flora. The claim this supports is specific: in this corpus, and within Mayou's selection of quotations, references to animals substantially outnumber references to plants. The category network cannot tell us which particular creatures account for this, so we turn to a finer-grained network.

**The Sub-topic and character network (Figure 6).** Here the most striking feature is the single very large green node, Dog. Sorting the Sub-topic nodes by Weighted Degree confirms that the dog is named 43 times, more than twice as often as the next most frequent creatures: the horse and the lion (17 each), the bear (16), and the fly and the snail (15 each). The first plant, the oak, appears only further down, with 14 references. Reading down the ranked list, rather than only looking at the figure, shows a further pattern: the most frequent animals are either familiar domestic animals (dog, horse, cat, ass) or animals with strong symbolic associations (lion, bear, serpent). This comparison confirms the first network's finding and refines it: the dominance of fauna rests heavily on a small number of familiar and emblematic species.

The same network can be used to examine individual characters. Among the character nodes, Hamlet stands out as one of the largest. Sorting the character nodes by Weighted Degree confirms that he has the highest total number of nature references of any character, and opening his edges in the Edges table (or selecting his node in the Overview and viewing its neighbours) shows that these are predominantly animal references.

**The Main Topic and genre network (Figure 7).** With only two genre nodes, this network is read mainly through its edge weights. In the Edges table, each edge's weight gives the number of references a genre makes to a category. Both genres are dominated by fauna, and the thickest edges run from both to Animals and Birds, which are almost evenly shared (Animals: 155 references in comedy and 150 in tragedy). Summing the weights for each genre shows that comedy carries more references in total (536 against 480). However, the corpus contains more comedies than tragedies, so the average per play is a fairer comparison: about 36 references per comedy against 40 per tragedy. On this measure, tragedy draws on the natural world slightly more often. Comedy does give a larger share of its references to plants (34% flora, compared with 27% in tragedy). The more distinctive signal lies in the categories that lean towards one genre. Reptiles lean clearly towards tragedy (63 references against 32 in comedy), while Fruits (42 against 20), Fish (26 against 12), and Garden Flowers (21 against 10) lean towards comedy.

Before drawing conclusions from such differences, check what they depend on. Some of these counts are small, so a single long speech could shift them noticeably; they are affected by the unequal number of plays in each genre; and they depend on the plays assigned to each genre (see Step 2). With these qualifications, the network gives a precise, comparative shape to a long-standing critical intuition: that tragedy draws more on the serpents and adders associated with danger and betrayal, and comedy on a greener, more cultivated world.

**From network to close reading.** Read together, the three networks move from the general to the specific to the comparative: the categories show that fauna dominates flora; the species show which creatures carry that weight; and the genres show that the pattern holds across comedy and tragedy while each inflects it differently. In every case, what the networks do is show where to look. They show that Hamlet's nature language is the heaviest of any character and overwhelmingly animal; they cannot tell us why, whether it reflects disgust, misanthropy, or a sceptical view of human nature. Nor can they tell us whether a given reference is admiring, mocking, or threatening. These questions belong to close reading of the relevant passages, which the master table allows you to locate quickly. Computation does not replace reading the plays; it directs it, and gives its claims a measured footing.

## Conclusion

This lesson has turned a body of dramatic dialogue into a two-mode thematic network, moving from a research question, through a set of documented data decisions and a master table of observations, to node and edge files, and finally to a styled and interpreted visualisation in Gephi. The workflow is general. The same steps (defining your entities and relationships, recording each observation in a master table, building the edges by keeping duplicates, and building the nodes by removing them) will turn any consistently recorded set of observations into a network. You can apply it to characters and settings, speakers and topics, letters and correspondents, or any other pairing your research question suggests. The lesson has also tried to show that a network is an argument to be read, not a result to be reported: the visualisations showed where the weight of references to nature falls in this corpus, but the meaning of that pattern remained a matter for close reading.

The results have several limitations. Because the dataset is based on Mayou's selection of quotations rather than an exhaustive extraction of every reference in the plays, all counts should be treated as lower bounds, and they reflect her choices as well as Shakespeare's. The categories are hers too, and a different classification of the natural world would produce a different network. The findings apply to this selection of comedies and tragedies only. Finally, the networks are static: by combining each play into a single aggregate, they cannot show how references to nature rise, intensify, or fade over the course of a play.

These limitations also suggest how the method can be extended. A reader who records the act and scene of each reference can build a sequence of networks and trace how a theme develops across a play. A reader who widens the corpus can test whether the dominance of fauna over flora holds in the histories or the poems. And a reader who adds further node types, such as themes and places alongside characters, can begin to ask questions about networks with more than two modes, with due caution about which measures such networks support. The dataset and files accompanying this lesson are offered as a starting point for this kind of adaptation, and we hope readers will treat them as a template for questions of their own.

## Endnotes

[^1]: Bessie Mayou, *Natural History of Shakespeare; Being Selections of Flowers, Fruits, and Animals* (Manchester: E. Slater, 1877).

[^2]: David Merino Recalde, "Análisis de redes sociales de personajes teatrales (parte 1)," *Programming Historian en español* 7 (2023), https://doi.org/10.46430/phes0064; David Merino Recalde, "Análisis de redes sociales de personajes teatrales (parte 2)," *Programming Historian en español* 7 (2023), https://doi.org/10.46430/phes0065.

[^3]: Mathieu Bastian, Sebastien Heymann, and Mathieu Jacomy, "Gephi: An Open Source Software for Exploring and Manipulating Networks," *Proceedings of the International AAAI Conference on Web and Social Media* 3, no. 1 (2009): 361–62, https://doi.org/10.1609/icwsm.v3i1.13937.

[^4]: Frank Fischer et al., "Programmable Corpora: Introducing DraCor, an Infrastructure for the Research on European Drama," in *Digital Humanities 2019: "Complexities"* (Utrecht: Utrecht University, 2019), https://doi.org/10.5281/zenodo.4284002.

[^5]: Franco Moretti, "Network Theory, Plot Analysis," *New Left Review*, no. 68 (2011): 80–102.

[^6]: Vikas Thotakuri, "Analyzing Shakespeare's Plays in a Network Perspective" (master's thesis, University of Nebraska at Omaha, 2014); Bastian Rieck and Heike Leitte, "'Shall I Compare Thee to a Network?': Visualizing the Topological Structure of Shakespeare's Plays" (paper presented at the Workshop on Visualization for the Digital Humanities, IEEE VIS, Baltimore, MD, 2016); James Lee and Jason Lee, "Shakespeare's Tragic Social Network; or, Why All the World's a Stage," *Digital Humanities Quarterly* 11, no. 2 (2017).

[^7]: A two-mode, or affiliation, network records ties between two different classes of entity rather than within a single class. The classic examples are people and the organisations they belong to, or people and the events they attend. In this lesson, the two classes are dramatic characters and categories of natural reference, and each edge records a character's "affiliation" with a category through the plants and animals they name. See Stephen P. Borgatti and Martin G. Everett, "Network Analysis of 2-Mode Data," *Social Networks* 19, no. 3 (1997): 243–69.

[^8]: Gilad Gutman, "A Network Analysis of Figurative Topic Classification: The Case Study of *Timon of Athens*," *Digital Humanities Quarterly* 18, no. 3 (2024), https://digitalhumanities.org/dhq/vol/18/3/000753/000753.html.

[^9]: Mareike Schumacher, Marie Flüh, and Felix Lempp, "Ecologies on Stage," in *Conference Reader: Second Workshop on Computational Drama Analysis* (Berlin: DraCor, 2025), 107–25, https://doi.org/10.5281/zenodo.16936633.

[^10]: Andrew Piper, *Enumerations: Data and Literary Study* (Chicago: University of Chicago Press, 2018).

[^11]: Yifan Hu, "Efficient, High-Quality Force-Directed Graph Drawing," *The Mathematica Journal* 10, no. 1 (2006): 37–71.

[^12]: Mathieu Jacomy, Tommaso Venturini, Sebastien Heymann, and Mathieu Bastian, "ForceAtlas2, a Continuous Graph Layout Algorithm for Handy Network Visualization Designed for the Gephi Software," *PLoS ONE* 9, no. 6 (2014): e98679, https://doi.org/10.1371/journal.pone.0098679.

[^13]: Gephi's modularity statistic uses the Louvain method. See Vincent D. Blondel, Jean-Loup Guillaume, Renaud Lambiotte, and Etienne Lefebvre, "Fast Unfolding of Communities in Large Networks," *Journal of Statistical Mechanics: Theory and Experiment* (2008): P10008, https://doi.org/10.1088/1742-5468/2008/10/P10008.

[^14]: Michael J. Barber, "Modularity and Community Detection in Bipartite Networks," *Physical Review E* 76, no. 6 (2007): 066102, https://doi.org/10.1103/PhysRevE.76.066102.
