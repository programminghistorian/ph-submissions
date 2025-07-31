---
title: "Named Entity Annotation, Linking, Augmentation and Network Visualization Using Open-Source Tools"
slug: named-entity-annotation-linking-augmentation-visualisation
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Silvia Stoyanova
- Emmanuel Landau
reviewers:
- Forename Surname
- Forename Surname
editors:
- Giulia Taurino
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/657
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Lesson overview

This tutorial presents a workflow for curating a dataset of named entities in textual corpora to facilitate their exploration with computationally assisted text analysis and their publication as Linked Open Data (LOD). The lesson employs open source tools and has a gentle learning curve for humanities scholars without previous training in digital methods: semi-automated annotation of person and places with Recogito; their reconciliation (i.e. disambiguation and linking) via [Uniform Resource Identifiers](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) (URIs) to knowledge bases and enriching the dataset with OpenRefine; creating new Wikidata items for unreconciled entities; preparing the dataset for network analysis with Gephi and exploring it with a customizable 3D network visualization tool. The lesson can be complemented with the [introduction to LOD principles](https://programminghistorian.org/en/lessons/intro-to-linked-data) by Blaney and the methodology of building [a gazetteer of places from a historical corpus](https://programminghistorian.org/en/lessons/space-place-gazetteers) by Grunewald and Mostern.

## Learning objectives
These objectives can be pursued individually or as a sequence:  
 - [Use Recogito to apply Named Entity Recognition for identifying people and places, reconcile places with gazetteers, and create manual annotations](#Recogito_id) 
 - [Use OpenRefine to reconcile people with Wikidata and enrich the dataset with Wikidata properties](#OpenRefine_id)
 - [Create new Wikidata items for unreconciled entities](#Wikidata_id)
 - [Transform the linked entity dataset into nodes and edges tables for network visualization in Gephi](#Gephi_id)
 - [Explore the linked entity dataset with an interactive customizable 3D network visualization](#3DVis_id)

# Introduction

## Linked entities in humanities texts

Named entities, such as people, places, works, and historical events, are constitutive elements of textual corpora in the humanities, which are published as indexes in the scholarly apparatus of print and digital editions as well as cultural heritage archives. Their digital curation as linked entities facilitates the exploration of their correlations computationally, and when published as LOD using the Resource Description Framework (RDF), across the datasets on the Semantic Web, thus enabling semantic reasoning at scale. Digital Humanities projects are increasingly adopting graph data models, and in the context of digital scholarly editing there is growing appreciation for the informational content of a text through the semantic annotation of named entities and linguistic terms (Spadini et al 2021).[^1] As Vogeler (2019)[^2] describes the methodology for creating such “assertive editions”, its workflow begins with 

> generic Natural Language Processing steps and then uses Named Entity Recognition to mark up the words representing people, locations, or organizations, temporal data, and quantifying data. The pipeline then relates these entities to one another, building connections between the entities”.
>
Named Entity Recognition (NER) assists the identification of named entities and Entity-Linking (EL) disambiguates them by relating them to the Uniform Resource Identifier (URI) of existing entries in a knowledge base. Although the advancement of Natural Language Processing (NLP) tools has automated this process to some extent, the humanities still face challenges due to insufficient gold standard annotated corpora for training, especially of historical documents (Linhares Pontes et al. 2020).[^3] Manual and semi-automated annotation and linking of named entities remain essential in the curation of LOD datasets (Nugues 2024).[^4] Despite the proliferation of born-digital archives and digital curation projects by domain experts, their interoperability and interconnectivity are lagging behind in the oft-lamented siloed landscape of the Digital Humanities (e.g., Brown and Simpson 2015;[^5] Hawkins 2021;[^6]). The vision of the Semantic Web for “a decentralized database of intertextual relations throughout numerous online editions and archives” (Oberreither 2023:72)[^7] relies on the broader participation by scholars and students across humanities domains. Whether we want to compile a dataset for digitally assisted text analysis, create a digital edition of our primary sources, annotate a text with explanatory commentary about historical persons and events, map all the geographic locations mentioned in it, research an author’s sources and intertexts, or enhance our text with additional structured information about the named entities mentioned, we can establish a solid foundation for these research queries and the publication of LOD humanities datasets by linking and enriching named entities with knowledge bases. 

## The sample text and its source document: Montaigne’s _Essays_ online

An eclectic work, [Michel de Montaigne’s _Essays_](https://en.wikipedia.org/wiki/Essays_%28Montaigne%29) are densely interspersed with quotations and references to historical and fictional persons and events, weaving a rich intertextual and cultural fabric. Although several scholarly digital projects have been dedicated to Montaigne, they haven't taken advantage of linked data for named entities.[^8] This lesson's dataset of linked entities of people and places to Wikidata in twenty chapters of the *Essays* is an original contribution to Montaigne scholarship. Since knowledge bases like Wikidata are language-agnostic, the dataset could be integrated into existing projects across languages, where it can be revised and expanded by other editors. The sample text used in this tutorial is a selection from the English translation of the *Essays* which can be downloaded as a digitized document at [Wikisource](https://en.wikisource.org/wiki/The_Essays_of_Montaigne) or at [Project Gutenberg](https://www.gutenberg.org/ebooks/3600), both of which are human-curated online digital libraries of texts in the public domain. For this exercise, I downloaded the sample corpus as individual plain text documents from [Wikisource](https://en.wikisource.org/wiki/Main_Page), where the text was edited by the volunteer community from an Optical Character Recognition (OCR) scan of the print edition by William Hazlitt (1877) but is not completely proofread. Indeed, while linking named entities I corrected several errors in the spelling of names (“Chyomatius” instead of Chromatius, Bishop of Aquileia; “Spissons” instead of the town of Soissons, etc.). Project Gutenberg uses the same translation with the same transcription errors in our sample. Wikisource, however, has the advantage of making available for download an individual document for each essay, which facilitates a modular approach to editing the corpus in separate files in order to explore correlations between them. Other advantages of Wikisource include its dynamic editing framework, which allows to make transcription corrections to the source document in real time, and the possibility to enrich it with our linked entity dataset. 

# <a id="Recogito_id">Named Entity Recognition and Annotation with Recogito 

## Getting started with Recogito

[Recogito](https://recogito.pelagios.org/) was developed by the Pelagios network as an open-source semantic annotation platform to support the LOD curation of places. The annotation workspace has a graphical interface which enables individuals and teams to apply Named Entity Recognition to places and people with Stanford CoreNLP for English, French, Spanish and German, and to link places to several [gazetteers](https://en.wikipedia.org/wiki/Gazetteer), among which Pleiades and GeoNames. Recogito furthermore enables the manual annotation of entities, of relations between tagged entities, free text comments, visualization of places on a digital map, and export of the annotated file in a number of formats for further processing and publication, such as CSV, TEI, Markdown, RDF. Recogito offers [tutorials](https://recogito.pelagios.org/help) in several languages; for recent applications to case studies, see also Rio Riande (2020)[^9] and Rojas Castro (2025)[^10].

After registering for a free user account, you need to upload your document(s) in .txt UTF-8 or TEI format by clicking *+ New* below your username. Click on a document to activate the *Options* dropdown menu, where you can open, move, duplicate, or delete it, as well as apply NER. In the open document, you can edit its *Metadata* by going to *Document settings* (a wrench icon). This workspace has four additional functions: *Document view* where you will annotate the text, *Map view* of identified geolocations, *Annotation statistics*, and *Download options*, all of which appear as icons with hover-over descriptions. 

## Parse your document for places and people

To begin the automated annotation of places and people in your document, select *Named Entity Recognition* from the *Options* menu. This takes you to a popup window where you will choose the *Recognition Engine* for parsing the text—in our case, the English language model of Stanford CoreNLP. If the language of your document is not available, you can experiment with the model for a language from the same family, such as the Spanish model for an Italian text.  Below, you have the option to select *Authority Files* for places. Recogito is under active development and may include additional language models and authority files in the future. All gazetteers are selected by default, but if the historical and geographical contexts of your corpus correspond to any of them specifically, you can delimit the reconciliation process by checking only the relevant ones. Once the parsing is completed, double-click your document to access the *Document view*. Before you evaluate the annotations, you can view the *Annotation statistics* which for our sample document—Book I, Chapter 2, titled “On Sorrow”—shows 21 people and 13 places. When the evaluation is completed, the statistics will change to 30 people and 5 places, indicating that Recogito created some false positives for places and some people were not recognized. 

Besides identifying and annotating missing entities through close reading, you could perform another NER with a different tool and compare the identified entities. For example, in [Voyant Tools](https://voyant-tools.org/), the [Reader tool](https://voyant-tools.org/?corpus=5cd40577eeb0d215a3bd92996e6a086d) has a lightbulb icon in the bottom right corner which activates several options for NER in English. The result for our sample text processed with SpaCy is 9 geo-political entities and 21 people. Although there are errors and missing entities, some are different, allowing to expand the annotated dataset. 

## Evaluate the NER annotations and add manual annotations

The evaluation of tagged entities entails a degree of close reading, which depends on your previous familiarity with the text, and may require consultation of secondary scholarship and original research. In the *Document view*, select the *annotation mode*, and use the *quick* mode to focus on either places or people, or the *normal* mode to highlight the annotations by entity type (places in green and people in blue). As you click on each annotation a popup window activates several selections: delete the annotation, replace it with a different type of entity (place, person, event), add a custom tag, or add a comment. If the entity has been recognized as a place and linked to a gazetteer, you can also *Confirm* or *Change* the automatic match. The *Change* button shows a list of suggestions with a brief description and location on a map, which you can explore further by clicking on each id to connect to its gazetteer. If the correct suggestion is not listed, try modifying the spelling or adding context (e.g., the country) in the search box.

### Place annotations

In our text, the reference to the Hungarian city of Buda in the sixteenth century is tagged correctly as a place, but the suggested location from GeoNames is a town in Romania, even though Hungary is tagged as a place just before Buda, in reference to King John of Hungary.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-1.png" alt="Visual description of figure image" caption="Figure 1. Recogito: the automatic match for a place shows a map location, gazetteer id, and options to confirm, change or delete it." %}

To link the correct identity of the place, you should *Change* the automatic match to review the list of suggestions, and indeed the [Kima gazetteer](https://data.geo-kima.org/) does identify the Hungarian city. After selecting it, the annotation will be tagged as verified and this qualification will be included as a column in the exported CSV file. If you cannot find the correct entity in the available gazetteers, you can add a URI that you have looked up manually (for example, on [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page)) or *Flag this place* and complete the reconciliation of unidentified entities with another tool, such as OpenRefine.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-2.png" alt="Visual description of figure image" caption="Figure 2. Recogito: a list of potential matches for a place with mapped locations." %}

### Person annotations

In Montaigne’s _Essays_ there are quotes in multiple languages and their English translations, resulting in erroneous annotation of some words (“Lingua” as a person and “Labitur” as a place) which we need to delete. Conversely, some entities are not recognized, notably the ancient Greek author Sophocles, whom we have to tag manually (*+ Person*). Instead, the Roman author Ovid is misidentified as a place—Ovid Township in Michigan, which we need to first delete and then tag Ovid manually as a person. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-3.png" alt="Screenshot showing the name Ovid and its id in the geonames gazetteer with a map of a location in Michigan." caption="Figure 3. Recogito: erroneous annotation of the poet Ovid as a place." %}

It is common to encounter references to people as pronouns or periphrasis. Here, in the sentence that mentions King John of Hungary and Buda (see **Figure 1**), Recogito has tagged “John” as a person and “Hungary” as a place, but Hungary is part of John's title, and the entire reference is to “the widow of King John of Hungary”. We thus need to delete both of these tags and create a new person tag for John's widow. This is an occasion to use the *Add a comment* box to add the name of this historical figure, i.e. Isabella Jagiellon, in order to facilitate our entity linking to Wikidata in OpenRefine. 

As you modify or create a new annotation, Recogito will recognize other occurrences of the same character sequence and prompt you to re-apply the same annotation to all of them, which you should decide on individual case basis. When creating a new annotation, be careful to highlight only the relevant text, because although an automatic match for a name with a dash in front may be recognized by the software correctly as a person (e.g. “—Seneca”), the CSV export of the document will transform the tag into a question mark. 

### Event annotations

Recogito has a third tag used for marking events, but it is not part of the NER function and has to be added manually. In our sample, the defeat of Cannae refers to the [Battle of Cannae](https://en.wikipedia.org/wiki/Battle_of_Cannae), where Cannae is already automatically recognized as a place and is correctly linked to its entry in the [Pleiades gazetteer](https://pleiades.stoa.org/home) of ancient places.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-4.png" alt="Screenshot showing the place Cannae with its Pleiades id tag, a brief description, and a map of its location" caption="Figure 4. Recogito: automatic match of Cannae as a place linked to its Pleiades entry." %}

To mark the event, highlight the relevant text and click *+ Event*. The event tag is superimposed on the place tag and will highlight the selected fragment in purple, while keeping the green tag for Cannae. In the exported dataset, Cannae will be marked as two separate types of entities: once as a place and once as an event. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-5.png" alt="Visual description of figure image" caption="Figure 5. Recogito: purple highlight of an event superimposed on a green highlight of a place." %}

### Custom tags and comments

If you are interested in annotating other entity types manually, you can add custom tags, such as "work" and "quote". For example, Ovid’s _Metamorphoses_ (abbreviated as “Met.” in an editorial comment) is tagged incorrectly as a place. After deleting the place tag, you can enter the tag “work” which will color the annotation in yellow. Any custom tags you assign to text selections will be colored in yellows and stored in the *Add tag* dropdown menu, which is activated when you select a text fragment and place your cursor there. I can further describe the _Metamorphoses_ as an editorial comment that identifies the source of Montaigne’s quote, by adding “notes” in the *Add a comment* space. When applied comprehensively, this distinction will clarify which authors and works Montaigne tends to name explicitly and which he tends to quote without reference. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-6.png" alt="Visual description of figure image" caption="Figure 6. Recogito: adding a custom tag and comments to a creative work." %}

### Entity relations

Semantic relations between two entities, such as between the author and the work or between the quote and the work, can be added as one of the annotation modes in the *Document view*. Relations are represented visually by a dotted line with an arrow which has semantic directionality: you need to first click on the author and then on the work by dragging the dotted line in order to describe their relationship with the tag “isAuthorOf”. Conversely, if using the tag “hasAuthor” you will start from the _Metamorphoses_ and direct the arrow towards Ovid. Similarly, you can connect the quote with the tag “isPartOf” pointing towards the _Metamorphoses_. These tags are used in the Resource Description Framework (RDF) to describe relations between objects on the Semantic Web.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-7.png" alt="Screenshot showing a dotted line with an arrow and the tag 'isPartOf' going from a quote annotation to a work annotation and the same dotted line with an arrow and the tag 'isAuthorOf' going from a person annotation to the same work annotation" caption="Figure 7. Recogito: annotating a relation between a work and its author and between a quote and its source." %}

### Export your file and sort the annotation data in a spreadsheet

After completing the NER vetting and manual annotation, you could switch from the *Document view* to the *Map view* to double-check that your places have been plotted correctly. Then go to the *Download options* to export the annotations in CSV format for linking the people, as well as any other entities you may have added, to their Wikidata entries with OpenRefine. We first need to sort the annotation data in a spreadsheet and create separate CSV files for the different types of entities. In the export file you have columns with a Recogito unique id, the name of the file, the text that was tagged, the type of entity, the verification status, your custom tags and comments, etc. For our purposes, you need to keep the columns titled “Quote Transcription”, “Type”, “Comments” (if any), “Tags” (if any), the geographic coordinates “LAT” and “LNG”, and “URI” (the gazetteer ids). Then sort the columns by “Type” to separate the list of people from the list of places. Copy the places in a different file and save the places and people lists as two separate CSV files. You can rename the column “Quote Transcription” to “person name” and “place name” correspondingly. In the places spreadsheet you should have the columns "place name", "URU", "LAT", "LNG", and comments (if any); in the people spreadsheet you should have the columns "person name" and "comments" (if any).

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-8.png" alt="Visual description of figure image" caption="Figure 8. Sorted spreadsheet of reconciled places exported from Recogito." %}

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-9.png" alt="Visual description of figure image" caption="Figure 9. Sorted spreadsheet of person names exported from Recogito." %}

Normalize any spelling variations by re-sorting the list alphabetically and comparing the records. There are duplicates for entities mentioned multiple times, which we want to keep for statistical queries and network visualization. If you have a lot of data, you can also use the data cleaning affordances of OpenRefine.

# <a id="OpenRefine_id">Knowledge Base Reconciliation and Augmentation of Named Entities in OpenRefine

[OpenRefine](https://openrefine.org/) is an open-source desktop application with a browser interface. In this tutorial we are using Version 3.9.3. If you have to normalize your data before the reconciliation, you can review the software [documentation](https://openrefine.org/docs) and the tutorial [Cleaning Data with OpenRefine](https://programminghistorian.org/en/lessons/cleaning-data-with-openrefine). Our present objective is to link the list of person names to their corresponding entries in Wikidata. You can follow the same process to reconcile the list of place names, if Recogito did not provide adequate matches. Our dataset was reconciled with Wikidata for both people and place names, besides the Recogito gazetteers. 

## Reconcile a list of names with Wikidata

To get started, click the *Create project* tab in the upper-left corner of the OpenRefine workspace. Upload your CSV file with the list of people and click *Next*. A preview screen appears prompting you to configure parsing options, but OpenRefine usually detects the correct format automatically. In our sample dataset, the software identifies row 1 as containing the column headers “person name” and “comments”, so we can proceed by clicking *Create project* in the upper-right corner.   Once the project loads, go to the column labeled *person name* and click the downward arrow. From the dropdown menu, select *Facet* and then *Text facet*. This creates a *Facet* panel on the left, listing all unique text values in that column and their counts. Facets allow you to group your data and together with filters can be used for a variety of cleaning functions. If during the reconciliation process you decide to exclude some data from your list, you can remove a column from its dropdown menu, however in order to remove rows you have to use filters. To do so, in the *All* column mark the rows you want to delete with stars or flags, and then select the facet star or flag. OpenRefine now sorts the data into *true* and *false*, where *true* corresponds to the starred/flagged rows. Then, from the dropdown menu of the *All* column, select *Edit rows* and *Remove matching rows*. Note that OpenRefine tracks every editing step in the *Undo/Redo* panel next to the *Facet/Filter* panel, where you can resume editing from an earlier step and delete all subsequent ones.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-10.png" alt="Visual description of figure image" caption="Figure 10. OpenRefine: the list of person names defined with a text facet." %}

Next, we will create a new column for reconciling the list of names with Wikidata and which will contain the names linked to their Wikidata entries. From the *person name* column, open the dropdown menu and select *Edit column*. Then from the second dropdown menu select *Add column based on this column*. In the popup window, write “Wikidata” in the *New column name* box on top and click the *OK* button.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-11.png" alt="Visual description of figure image" caption="Figure 11. OpenRefine: duplicating the “person name” column and labeling it “Wikidata”." %}

From the new Wikidata column, click the downward arrow to select the option *Reconcile* and from the next dropdown menu select *Start reconciling*. OpenRefine takes you to a screen to select a reconciliation service, where the default option is Wikidata. There, you have the option to link additional services, such as the Virtual International Authority File (VIAF) and the Getty Vocabularies, which are widely used for reconciling people, organizations, and works. After performing the Wikidata reconciliation, you can repeat it with another service by first copying the list of names to a new column naming it correspondingly. Select *Discover services* to browse a list of reconciliation endpoints and copy and paste the URL of the service you selected into the field under *Add standard service*. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-12.png" alt="Visual description of figure image" caption="Figure 12. OpenRefine: linking the Getty Vocabularies reconciliation service." %}

After selecting the Wikidata reconciliation service, a configuration window prompts you to choose an entity class. OpenRefine will detect a class based on your data (in this case “human”) which is selected by default. If your dataset has mixed classes, you could reconcile without specifying one, but the suggestions will be less accurate. To refine reconciliation results, you can include data from other columns, for example if the “comments” column includes attributes like “author” or “mythological figure”. OpenRefine enables the option to auto-match high confidence candidates by default. It is best to leave it selected since you will review all automatic matches afterwards, just as we did with place names in Recogito.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-13.png" alt="Visual description of figure image" caption="Figure 13. OpenRefine: selecting reconciliation criteria." %}

After the reconciliation completes, OpenRefine displays a partially colored bar below the “Wikidata” column header, showing the percentage of automated matches with high confidence: our dataset is at 27% completion. These are activated as dark blue links to the corresponding Wikidata page, while entries with suggested matches are displayed as light blue links. If you hover over a link, a brief description from Wikidata appears, and clicking the link will open the full Wikidata entry in a new tab. With the hover-over feature we can quickly verify that Diodorus Siculus, Pliny the Elder, Ovid, Isabella Jagiellon, among others, are auto-matched correctly. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-14.png" alt="Visual description of figure image" caption="Figure 14. OpenRefine: a reconciled list of person names, showing automatic matches and suggested matches." %} 

The record “Lesbia”, which in Montaigne's essay appears in a quote by the poet Catullus, is also automatically matched—to the Wikidata item “Clodia”. Although this is correct insofar as Catullus used the pseudonym “Lesbia” to refer to the historical Clodia, our context refers to her fictional role. We can try to refine the match by selecting *Choose new match* and then *Search for match*. The results now include matches of different class types, and indeed one of them is “Lesbia” described as “lover of Catullus”. If we view this item on Wikidata, we can see that it has the semantic property “said to be the same as” linking it to the item for Clodia, thus illustrating the power of linked data to support semantic disambiguation and contextual specificity. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-15.png" alt="Visual description of figure image" caption="Figure 15. OpenRefine: the search for match from different classes retrieves the correct item." %}

The unreconciled entities may have a ranked list of potential candidates or no matches altogether. To resolve ambiguous or unmatched cases, you may need to go back to the textual context, consult secondary scholarship, or conduct original research. In our dataset, “Dionysius the Tyrant” and “Ferdinand I” each have three potential matches (see **Figure 14** above), and more options appear when clicking *See more*; on the other hand, there are no suggestions for “Psammenitus, King of Egypt”. In the case of “Dionysius the Tyrant”, the context indicates that he is someone “who died of joy,” which identifies him as “Dionysius I, tyrant of Syracuse”, the third option on the list. OpenRefine allows you to match either this specific cell (by checking the first box) or all identical cells (by checking the second box). Here, we select the second box to match both occurrences of this name—one in the main text and one in the editorial commentary to the _Essays_ because we are certain they have the same identity. For "Ferdinand I", instead, the first three choices are incorrect. However, with *See more* we find the correct match: Ferdinand I Holy Roman Emperor, who was historically in conflict with Isabella Jagiellon, widow of King John of Hungary. Finally, in cases where no correct match is initially available, we need to *Search for match* to include results from different entity classes. Thus, "Iphigenia" in our context refers to the character from Greek mythology, but all of the suggested matches are historical persons. Once we conduct the additional search, the correct match described as “daughter of Agamemnon in Greek mythology” is retrieved as one of the top candidates. 

Sometimes spelling variations or aliases prevent correct identification and it may be necessary to modify the original record in the search box. For example, no suggestions appear for “Psammenitus, King of Egypt” because, as a simple Google search reveals, this name is commonly rendered as “Psamtik”. A search for “Psamtik” successfully retrieves three Egyptian pharaohs by that name. After reviewing the corresponding Wikipedia entries, we can determine that Montaigne refers to Psamtik III, who was in conflict with Cambyses II, which also helps us to disambiguate the identity of “Cambyses, King of Persia”. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-16.png" alt="Visual description of figure image" caption="Figure 16. OpenRefine: modifying the text record to search for a Wikidata item." %}

The only suggestion for Cambyses provided in the initial list of matches and in *Search for match* is "Cambyses I". In such cases, you need to enter the correct name (e.g., "Cambyses II") in the search box. If a Wikidata item exists, it will be retrieved, and once the match is selected the Wikidata column will update from “Cambyses, King of Persia” to “Cambyses II”.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-17.png" alt="Visual description of figure image" caption="Figure 17. OpenRefine: adding a new name in the 'Search for match' box." %}

If the name search fails to retrieve the correct entry or does not return any results, try searching for it directly in [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page). Note that Wikidata items are identified by Q-identifiers (QIDs) which serve as machine-readable URIs. If you find a match, copy its QID and paste it into the search box in OpenRefine, and the corresponding entity will be retrieved. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-18.png" alt="Visual description of figure image" caption="Figure 18. OpenRefine: linking an entity by adding its Wikidata QID in the 'Search for match' box." %}

## <a id="Wikidata_id">Create new Wikidata items

If you cannot match certain entities to items in Wikidata or other reconciliation services (such as VIAF), you may consider creating new Wikidata items for them. In our sample, no item exists for “Raïsciac, a German lord” whom Montaigne reports to have died of grief upon seeing the body of his son—killed in a battle near Buda during the conflict between Ferdinand I and Isabella Jagiellon. The text provides enough contextual information to create a structured Wikidata item for this individual. First, you should create a Wikidata account by registering a username and password. Before contributing, it is advisable to familiarize yourself with the structure of Wikidata items, especially those for the type of entity you want to create. For instance, the entry for [Psamtik III](https://www.wikidata.org/wiki/Q316278) includes a brief description, a list of aliases (to which we can add “Psammenitus” from Montaigne’s text), and multilingual labels. Below the description section, there is a list of *Statements* which consist of properties with their own Wikidata IDs prefixed with "P". These properties have values which are typically Wikidata items (prefixed with "Q"). For example, there is the property “date of birth” (P569) with value “6. century BCE”, the property “sex or gender” (P21) with value “male” (Q6581097), the property “country of citizenship” (P27) with value “Ancient Egypt” (Q11768), the property “manner of death” (P1196) with value “capital punishment” (Q8454), the property “occupation” (P106) with value “statesperson” (Q372436), etc. These properties can be exported from Wikidata after the reconciliation to enrich your dataset. Below the list of *Statements*, there is a section of *Identifiers* linking this person to other knowledge bases, such as [Encyclopædia Brittanica Online](https://www.britannica.com/biography/Psamtik-III).

To create a Wikidata item for Raiscïac, we will go to [Wikidata’s main page](https://www.wikidata.org/wiki/Wikidata:Main_Page) and select *Create a new Item* from the menu. In the window that appears fill in the basic metadata: language, label, a short description. Once you click *Create* the new item will be assigned a QID. Be careful when creating new items because if you made mistakes and need to delete it altogether, you have to make a request for its deletion to Wikidata administrators. Any modifications you make are recorded in the editorial history of your user profile or, if you did not create one, your IP address.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-19.png" alt="Visual description of figure image" caption="Figure 19. Creating a new Wikidata item for a person." %}

Our new Wikidata item now has a [QID](https://www.wikidata.org/wiki/Q135004989) and we can begin to add statements, such as class, gender, country of citizenship, the manner of death, which is exemplary in our narrative, etc. The first statement is an instance of human for which we can add the property *stated in* with value Montaigne’s *Essays* (Q530157), and add references, such as the URLs of digital editions and facsimiles of the text. Another relevant statement uses the property *described by source* which value again is the Wikidata item for Montaigne’s _Essays_, and we can *add qualifier* to specify the section of the book where Raiscïac is mentioned, namely Book I, Chapter 2 “On Sorrow”. Other statements describe the gender of the person ("male"), country of citizenship based on his military involvement on the side of Ferdinand I ("Holy Roman Empire"), occupation ("military personnel"), social classification ("noble"), place of death ("Buda"), manner of death ("acute stress reaction"). To describe these statements, we need to add references, such as *stated in* with the value Montaigne’s _Essays_. For the date of death, which is not specified in the text, we need to add as *qualifiers* the properties “earliest date” and “latest date”, as well as the property *inferred from* in the references rather than *stated in*, because we are deducing this timeframe based on the military conflicts between Ferdinand I and Isabella Jagiellon from September 1540 to August 1541. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-20.png" alt="Visual description of figure image" caption="Figure 20. Wikidata statements for a person described in Montaigne’s 'Essays'." %}

We can now add the QID for Raiscïac to our OpenRefine dataset and proceed with importing properties from Wikidata for all reconciled entities.

## Extract QIDs and URLs from reconciled data

Once you have reconciled your data, you need to extract both QIDs and Wikidata URLs for each matched entity. QIDs are useful for disambiguating, sorting, aggregating, merging duplicates, and referencing entities internally (in networks or tables). Wikidata URLs are required for Linked Data and RDF export; they are unique machine-readable identifiers that connect your dataset to the Semantic Web. From the drop-down menu of the reconciled Wikidata column select *Reconcile* and then choose *Add column with URLs of matched entities*. You will be prompted to label the new column (e.g., "Wikidata URLs"), and then it will be added. Repeat the same steps to *Add entity identifiers column* and label this column "QIDs". The dataset now has linked entities, which can be exported as RDF or used in semantic enrichment.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-21.png" alt="Visual description of figure image" caption="Figure 21. OpenRefine: QIDs column and Wikidata URLs added from the reconciled column." %}

## Enrich the dataset with Wikidata properties 

We can proceed with extracting additional properties from the reconciled Wikidata column to enrich our dataset and enhance our queries. From the dropdown menu of the reconciled column, select *Edit column* and choose *Add columns from reconciled values*. A window will appear with a short list of suggested properties, a box where you can search for a property (such as *date of death*), and a preview pane where you can evaluate whether selected properties offer useful values. You can also configure each property by selecting a different choice of ranks and references than the default options. In our dataset, I have retrieved the values for death of birth, date of death, gender, occupation, and country of citizenship. After adding the new columns, you can remove, rearrange, and rename them through their dropdown menu. Since there can be multiple values assigned to a given property (e.g., occupations, children, notable works), you should switch the project view from rows to records. Thus, the record for Ferdinand I, Holy Roman Emperor has three rows for occupation: aristocrat, monarch, and politician.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-22.png" alt="Visual description of figure image" caption="Figure 22. OpenRefine: our sample dataset enriched with Wikidata properties." %}

We can now explore these properties quantitatively. For example, we can create a text facet for the “occupation” column which groups the data by counts, allowing to identify the most common occupations: poet (7), writer (7), politician (6), philosopher (5), historian (4), etc., out of the 40 different ones practiced by the 23 unique individuals in our dataset.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-23.png" alt="Visual description of figure image" caption="Figure 23. OpenRefine: the occupations of individuals in the sample corpus listed by count in the Facet panel." %}

## Apply the RDF extension and export the dataset

After the reconciliation and enrichment of your dataset with Wikidata, you can export it as a CSV file to use in other applications and for further analysis. To publish your dataset as linked data, you must first model it using RDF and semantic vocabularies. A recommended lesson at this stage is [Introduction to the Principles of Linked Open Data](https://programminghistorian.org/en/lessons/intro-to-linked-data), and you can begin the modeling process by experimenting with the RDF extension in OpenRefine. First, you would need to install it by going to the main menu for creating a project and select the option *Extensions*. Then click *Discover extensions* to browse available plugins and download the RDF extension (rdf-extension-1.6.0). Unzip the folder and move it to the extensions directory of your OpenRefine application. The software [documentation](https://openrefine.org/docs/manual/installing#installing-extensions) gives detailed instructions for using different operation systems.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-24.png" alt="Visual description of figure image" caption="Figure 24. The RDF extension folder added to the OpenRefine application directory on a Windows machine." %}

Once installed, the RDF extension appears in the top-right corner of the OpenRefine workspace, alongside other installed extensions (note that Wikibase is pre-installed by default). To begin modeling, click the dropdown menu of the RDF extension and select Edit *RDF skeleton* which opens a window for *RDF Schema alignment*. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-25.png" alt="Visual description of figure image" caption="Figure 25. OpenRefine: RDF extension functions." %}

The RDF Schema alignment is a visual editor which allows you to assign semantic properties to the columns of the dataset. Click *Add property* and select a term from the available prefixes (the names of semantic vocabularies and ontologies) that corresponds to the data in each column. For instance, we can assign`foaf:gender` to the column (*Cell*) labeled "sex or gender" extracted from Wikidata. FOAF is the acronym for "Friend of a Friend"—an ontology used to describe people and their relationships using RDF. When matching a semantic property to your list of columns, you will be prompted to define the Cell's data type, i.e. gender is defined as text, so is occupation, date of birth and date of death are defined as date, Wikidata URL is defined as URI, etc.

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-26.png" alt="Visual description of figure image" caption="Figure 26. OpenRefine: adding the property 'occupation' in the RDF Schema alignment." %}

The RDF skeleton feature of OpenRefine includes several preloaded vocabularies (e.g., `schema, foaf, rdfs, owl`), but you can import others from the [Linked Open Vocabularies](https://lov.linkeddata.es/dataset/lov/) (LOV) platform. Click *+ Add* next to the available prefixes and provide the prefix and corresponding namespace URI of the desired vocabulary. For instance, to describe the property “occupation” in RDF, you could use MADS (Metadata Authority Description Schema). 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-27.png" alt="Visual description of figure image" caption="Figure 27. OpenRefine: adding a vocabulary prefix to the RDF skeleton." %}

After aligning your data with the appropriate vocabulary terms, you can export the dataset in RDF Turtle format or, depending on your publication goals, continue refining the model using a more specialized RDF or ontology editor.

# Named entity network visualization

You can explore the enriched named entity dataset through network visualizations that reveal their relationships. Network analysis helps us to evaluate how Montaigne’s discourse is structured through his historical and cultural references, and we can exploit the various attributes we extracted from Wikidata to refine the network. You can examine, for example, which essays are connected through particular people or places, which authors or works function as hubs connecting multiple essays, whether geographic areas or historical periods are correlated to specific themes, and generally whether the tripartite structure of the _Essays_ reflects certain clusters of entities within each book and between the three books. In this exercise, we will first use Gephi to create a basic bipartite network of people and the first ten essays of Book I in which they are mentioned. Then we will explore the complete dataset of Montaigne's *Essays* (people and places from Book I, Essays 1-10, Book II, Essays 1-5 and Book III, Essays 1-5) with a 3D visualization tool which can be customized to your own dataset. 

## <a id="Gephi_id">Setting up the dataset for network analysis with Gephi 

To prepare the dataset for network analysis with Gephi, you need to create two CSV files for each essay: a nodes table that lists each entity id and any of its attributes (e.g. gender, occupation), and an edges table that defines relationships between the entities. Thus, since Virgil is mentioned in Book I, Essay 2, this relationship becomes an edge in the network, where Virgil is a node with type "person" and Book I, Essay 2 is a node with type "essay". In the edges table, Book I, Essay 2 (represented by the id “01_02”) is described as the “source” and Virgil as the “target”. For our network of people and essays, from the OpenRefine CSV file we will copy the Wikidata column (normalized person names) as labels and the QIDs column as unique identifiers of the people nodes. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-28.png" alt="Visual description of figure image" caption="Figure 28. The Wikidata and QIDs columns from the OpenRefine CSV file are copied to create the edges and nodes tables." %}

You can combine all people names in one set of nodes and edges tables, or you can create a separate set of nodes and edges for each essay. Choosing the latter gives you greater flexibility to combine different selections from the dataset to explore as a network, but you need to ensure that you append all the files to the same workspace in Gephi. 

### Create the edges table

For the edges table, create a column labeled “source” and a column labeled “target”. Copy the “QIDS” column of the first essay in the “target” column and input the value “01_01” in the “source” column for all rows, which indicates that these names are mentioned in Book 1, Essay 1. Since we are creating one table for all 10 essays, we will copy the name ids of the second essay below and input the value “01_02” in the source column for its set of 30 rows (all mentions of people in Essay 2). Proceed to add all sections of the corpus that you want to include in the network. The sequence in which you add data from each essay is irrelevant as long as each set of names (targets) is aligned with its essay number (source). The list of targets will include all the duplicate names as a measure of frequency: if Plato is mentioned five times in essay 01_01, there will be five identical rows. At the end, we will add a third column labeled “type” which specifies whether the graph is directed or undirected. In our case, all relationships are undirected: it does not matter whether Virgil is mentioned in essay 01_02 or whether essay 01_02 mentions Virgil. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-29.png" alt="Visual description of figure image" caption="Figure 29. Edges table showing people targets from Book I, Essay 1 and partially from Essay 2." %}

### Create the nodes table

For the nodes table, you will create an “id” column, a “label” column, and a “type” column. In the "id column", you will copy the QIDs column and in the "label" column you will copy the “Wikidata” column of each essay. Then you will delete the duplicates of the names (in Excel, simply sort the table)—the nodes should be unique, but Gephi will detect duplicate nodes and remove them. Then in the "id" column you will list the ten essay ids (from 01_01 to 01_10) and write their titles in the "label" column. In the "type" column you will input the two entity types, “essay” and “person”, in each corresponding row.  

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-30.png" alt="Visual description of figure image" caption="Figure 30. Nodes table showing ten essay nodes and several person nodes." %}

### Importing the dataset into Gephi and visualizing the network graph

After downloading [Gephi](https://gephi.org/) (current version 0.10), go to *New Project* and then File *import spreadsheet* to import the nodes file and then import the edges file. As you are importing the edges, you need to select the option *Append to existing workspace*. If you prefer to create individual sets of nodes and edges for each essay, this is where you would append all spreadsheets as you import each of them. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-31.png" alt="Visual description of figure image" caption="Figure 31. Gephi: append the edges spreadsheet to the existing workspace with the imported nodes spreadsheet." %}

You can examine the data in the *Data Laboratory* tab to ensure it was imported correctly and to make any modifications. Then go to the *Overview* tab which initially shows a graph of dots (nodes) and connecting lines (edges). First you need to choose a layout—try *Yufan Hu* or *ForceAtlas2*—which will recalibrate the network to show clusters of nodes and their connections. Afterwards you can also apply the *Noverlap* and *Adjust nodes* layouts if you have long labels. From the dark **T** icon on the bottom, you can turn on the node labels, and then modify their font, size, and color from the sliders or the settings icon to the far right. To distinguish node types and emphasize prominent nodes or connections, go to the *Appearance* panel on the left, select the node tab and then the palette icon to define *Nodes Partition* which allows you to assign different colors to node types or to the weight of the node (its frequency). The size of the nodes can be ranked according to their number of edges by clicking on the second icon to select *ranking* and then *degree*. The last two icons representing label color and label size can also be used to reflect the weight and types of nodes. At the edges tab you can set their weight as a thicker line connecting nodes that are mentioned more often. In our dataset overview, we can see the ten essays with differently sized nodes and labels to correspond to the number of persons mentioned in each. The graph shows which essays mentions people that play a central role in the dataset as a whole: "on sorrow" is in the center, whereas "on quick or slow speech" is an outsider in the network: relatively smaller and connected by one person, Francis I, who in turn is mentioned frequently in the essay "on liars", but his influence does not extend beyond these two essays.  

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-32.png" alt="Visual description of figure image" caption="Figure 32. Gephi network of the people mentioned in the Book I, essays 1-10." %}

To the right of the *Graph* workspace in the *Overview*, you can generate various statistical queries which will be included in the *Data laboratory* and as choices in the *Appearance* panel. Among these, the *weighted degree* shows how strongly connected a node is based on its number of occurrences; the *eigenvector centrality* measures the importance of a person as a factor of its connections; and the betweenness centrality measures the bridging power or influence of a person. These statistical measures can be explored in the *Data Laboratory*, where we can sort the values and confirm what the graph already suggested, namely that among the people nodes Cicero appears to be most central and influential figure in the network, with the highest *eigenvector centrality* and *betweenness centrality*, and a relatively high *weighted degree*. On the other hand, although Francis I has the highest *weighted degree* (12), his *eigenvector* is rather low (0.07), because he is mentioned numerous times in the same essay but is poorly connected with the rest of the network. 

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-33.png" alt="Visual description of figure image" caption="Figure 33. Data Laboratory in Gephi, showing statistics for Weighted Degree, Eigenvector Centrality, and Betweenness Centrality." %}

## <a id="3DVis_id">3D Interactive network visualization tool 

Finally, to explore these relationships more interactively in a three-dimensional space, you can employ a modern, React-based tool accessible at [Vite + React + TS](https://akhystophane.github.io/dh_project/). 

Upload any number of essays and select which attributes to include. The *Network Controls* to the left of the graph allow to filter and visualize the network according to various statistical measures and aesthetic parameters:

 **Essays** 
 - filter the network components from the initial selection dynamically, as you build a network of interest
 - show/hide mentioned persons, ranked by frequency

**Persons**   
 - show/hide Wikidata properties
 - ranked by frequency 

**Network Statistics**
 - number of essay and person nodes
 - number of relations
 - the level of connectivity measured by *density* and *average degree*

**Controls**
 - *intersection mode* shows the edges between those nodes that are common to all dynamically selected essays, and thus act as bridges across the network. 
 - visualize a static or rotating graph
 
**Aesthetic Controls** 
 - *color by book* (when unchecked, the network will assign different colors to essays); recommended when working with larger number of essays 
 - *color* and *shape* to distinguish node types
 
**Layout Options**
- 5 choices of layout reflecting the measures of the nodes, such as average degree, betweenness centrality, communities of related nodes.  

{% include figure.html filename="en-or-named-entity-annotation-linking-augmentation-visualisation-34.png" alt="Visual description of figure image" caption="Figure 34. A dynamic layout of the network of 20 essays, with Cicero represented by the dark blue circle in the center." %}

The tool can be customized from Github: [Akhystophane/dh_project at network-visualization-tool](https://github.com/Akhystophane/dh_project/tree/network-visualization-tool) 

### 🚀 Quick start

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd dh_project
   ```
2. **Install dependencies:**
   ```bash
   cd frontend
   npm install
   ```
3. **Start the frontend:**
   ```bash
   npm run dev
   ```
4. **Open your browser:**
   Go to [http://localhost:5173/dh_project/](http://localhost:5173/dh_project/) (or the URL shown in your terminal)

### 🛠️ How to use or fork

- **To use:**
  - Place your data/config files in the appropriate location (see below).
  - Start the frontend as above.
  - Interact with the 3D network visualization in your browser.

- **To fork and customize:**
  1. Fork this repo on GitHub.
  2. Clone your fork and make changes to the React code in `frontend/src/`.
  3. Commit and push your changes.
  4. Optionally, deploy your forked app (e.g., with Vercel, Netlify, or your own server).

### 📁 Data format

- By default, the app looks for a `config.json` file describing your essays and entities.
- You can also upload CSV files via the landing page.
- See `frontend/public/config.json` for an example structure.

### ✨ Features
- 3D interactive network visualization
- Node size, color, and shape reflect entity properties
- Hover and click for details
- Keyboard and trackpad navigation
- Customizable appearance and layout

### 🧹 Cleaning up
- All legacy scripts and HTML files have been removed.
- This branch is focused on the React-based workflow only.

---

**Questions or issues?** Open an issue or fork and adapt the tool to your needs!




## Notes  

[^1]: Spadini, E. Tomasi, F., Vogeler, G., Eds. _Graph Data-Models and Semantic Web Technologies in Scholarly Digital Editing_, BoD, Nordstedt, 2021.
[^2]: Vogeler, G. "The ‘assertive edition'. On the consequences of digital methods in scholarly editing for historians". *International Journal of Digital Humanities* https://doi.org/10.1007/s42803-019-00025-5, 2019. 
[^3]: Linhares Pontes, E. et al. "Entity Linking for Historical Documents: Challenges and Solutions". *22nd International Conference on Asia-Pacific Digital Libraries*, ICADL 2020, 12504, Springer, pp. 215-231, 2020, https://link.springer.com/chapter/10.1007/978-3-030-64452-9_19.
[^4]: Nugues, P. "Linking Named Entities in Diderot’s *Encyclopédie* to Wikidata", *Proceedings of LREC-COLING 2024 - ACL Anthology*, pp. 10610-10615 https://aclanthology.org/volumes/2024.lrec-main
[^5]: Brown, S. and Simpson, J. "An Entity By Any Other Name: Linked Open Data as a Basis for a Decentered, Dynamic Scholarly Publishing Ecology", *Scholarly and Research Communication*, 6 (2), 2015, https://doi.org/10.22230/src.2015v6n2a212 
[^6]: Hawkins, A. "Archives, linked data and the digital humanities: increasing access to digitised and born‑digital archives via the semantic web", *Archival Science* 22, pp. 319–344, https://doi.org/10.1007/s10502-021-09381-0
[^7]: Oberreither, B. "A Linked Data Vocabulary for Intertextuality in Literary Studies, with some Considerations Regarding Digital Editions", *Digital Scholarly Edition in Austria*, Edited by Bleier, R and Klug, H, BoD, Norderstedt, pp. 69-86, 2023.  
[^8]: The [Montaigne project](https://www.lib.uchicago.edu/efts/ARTFL/projects/montaigne/) at the University of Chicago Library offers an authoritative transcription with concordance, collocation and keyword in context search functionality, but does not identify named entities and references. The [Montaigne at Work](https://montaigne.univ-tours.fr/) project, presented by the Centre d’Études Supérieures de la Renaissance de Tours, also addresses the philological aspects of the _Essays_ without identifying named entities. The [HyperEssays](https://hyperessays.net/) project by Sebastian Biot offers indexes of people and places (in progress as of June 2025) with some explanatory notes, however they are not disambiguated through a knowledge base. 
[^9]: del Rio Riande, G. and Vitale, V. 2020 “Recogito-in-a-Box: From Annotation to Digital Edition”. _Modern Languages Open_, pp. 1–13, 2020(1):44. DOI: [https://doi.org/10.3828/mlo.v0i0.299](https://doi.org/10.3828/mlo.v0i0.299). 
[^10]: Rojas Castro, A., “Mapping Early Modern Hispanic Mythological Poems with Recogito” _Digital Humanities in Medieval and Early Modern Spanish Texts_, Edited by R. J. González Zalacain and G. Vaamonde, Routledge, London and New York, pp. 101-117, 2025. 



