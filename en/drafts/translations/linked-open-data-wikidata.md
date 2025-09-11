---
title: "Using Linked Open Data to Describe Academic Journals with Wikidata"
slug: linked-open-data-wikidata
original: datos-abiertos-enlazados-wikidata
layout: lesson  
collection: lessons  
date: 2025-01-15
authors:
- Cláudia De Souza
- Dinah M. Wilson Fraites
reviewers:
- Giulia Osti
- Pedro Nilsson-Fernàndez
editors:
- Jennifer Isasi
translator:
- Felipe Valdez
translation-editor:
- Caio Mello
translation-reviewer:
- Forename Surname
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/669
difficulty: 1
activity: acquiring
topics: [lod, data-management, data-manipulation, web-archiving, metadata]
abstract: This lesson introduces Wikidata and provides a step-by-step guide to integrating journal and personal metadata using linked open data. It explores best practices for inserting and managing metadata in Wikidata to increase the visibility and accessibility of resources in digital environments.
avatar_alt: Decorative framed letter W with a design of circular lines and patterns.
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

You have probably already heard about metadata, open data, and linked open data. However, before starting this lesson, it's important to clarify and deepen our understanding of these concepts and briefly explore their interconnections.

The prefix meta is derived from the Greek language, in which it means "after" or "beyond." It is used to indicate that a concept applies to itself. 'Metadata', therefore, refers to 'data about the data,' in the sense that it describes, identifies, locates, or facilitates the understanding of the data. In the interdisciplinary field of information science, in particular, metadata provides context and structure, allowing efficient management, search, and organization of information, as well as facilitating interoperability between systems, different platforms, and the long-term preservation of digital resources. With the internet, metadata became particularly useful due to the enormous amount of information available online, as it is essential to facilitate web pages classification, optimize search engines, and improve user navigation.[^1] [^2] [^3]

In an increasingly digital and interconnected world, interest in open data has grown significantly, as a response to the need of promoting transparency and data reuse across various disciplines. Metadata availability has been growing, while taking into consideration the necessary technical and legal frameworks to make it free, reusable and accessible for anyone, at any time and in any place.[^4] The adoption of open standards for metadata not only facilitates the understanding and exchange of data but also drives innovation by promoting more effective communication. In this context, open data has become an essential component for building sustainable and accessible data infrastructures, promoting a collaborative approach to information management in the digital era.

In the context of open data philosophy, Linked Open Data (LOD) has emerged as a concept for presenting and publishing data on the web, aiming at facilitating data use and reuse through automated processes.LOD is based on the principle of establishing meaningful linking between data with similar attributes, from various sources of the web. It implies the creation of an environment with global interoperability.[^5] Therefore, this term refers to a set of best practices for publishing and connecting structured data on the web. As a novel and different approach from others, information in Wikidata is stored in semantic triples [^6] following the Resource Description Framework (RDF), which are conventionally known as subject, predicate, and object. If you still have doubts or want to deepen your knowledge on this topic, you can consult more details in [Jonathan Blaney's lesson](https://programminghistorian.org/en/lessons/intro-to-linked-data), which offers a brief and concise introduction to linked open data.

This lesson shows you how to create, edit, and publish LOD in a simple and free way using Wikidata. You will learn about the structure of Wikidata and the procedures for creating, editing, and publishing LOD related to entities in academia such as scientific journals and researchers. The lesson is primarily aimed at librarians, archivists, and other information professionals working in the academic context who wish to increase the visibility of the knowledge produced at their institution.

### Lesson Goals

- Understand the concepts of metadata and Linked Open Data
- Examine the process of creating, editing, and publishing open data in Wikidata
- Apply the procedures for creating, editing, and publishing open data about academic journals and people in Wikidata
- Discuss the ethical considerations related to representing people through open data in Wikidata

### Pre-requisites

No prior knowledge is necessary.

## What is Wikidata?

[Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page) is a free and open platform that is entirely built with Linked Open Data (LOD). Launched in October 2012 by the Wikimedia Foundation, this database represents one of the most innovative projects for centralizing data across diverse topics and communities (Figure 1). The foundation is a nonprofit organization that provides free information and knowledge.

Projects under the Wikimedia Foundation umbrella are organized into four categories: content projects, multilingual content projects, outreach and administrative projects, and technical and development projects.

{% include figure.html filename="en-tr-linked-open-data-wikidata-01.png" alt="Projects under the Wikimedia Foundation umbrella organized into four categories: content projects, multilingual content projects, outreach and administration projects, and technical and development projects." caption="Figure 1. An overview of the Wikimedia Foundation’s projects." %}

According to its own [website](https://www.wikidata.org/wiki/Wikidata:Introduction), both the content and structure of Wikidata are in the public domain. This allows users to freely copy, modify, distribute, and present the data for any purpose, including commercial use, without seeking permission. Wikidata also has these key features:

- Accessible to other projects: The data stored in Wikidata is available for use by other Wikimedia projects, such as Wikipedia. This creates a centralized source of information that can be leveraged by various applications and websites.

- Collaborative: Content creation and editing in Wikidata is enriched by contributions from volunteer users around the world.

- Continuously updated: The community actively contributes to the improvement and expansion of the database. This helps ensure that the information is current, reflecting recent changes and discoveries.

- Version history: Wikidata keeps a revision history for each item and statement, allowing changes to be tracked over time. This ensures transparency and the ability to revert edits if necessary.

- Multilingual: It supports the representation of items and their descriptions in over 300 languages.

- Structured data: All information is organized into specific fields and categories (following a model with a set of rules and constraints). This improves consistency and makes it easier for both humans and machines to search for, access, retrieve, update, and reuse the data.

In 2019, Wikidata had approximately 55 million created items. Four years later, it had surpassed 100 million items (Figure 2), covering a wide range of topics such as objects, people, places, reports, art, buildings of cultural interest, animals, and much more.


{% include figure.html filename="en-tr-linked-open-data-wikidata-02.png" alt="Line graph showing the increase in the creation of Wikidata elements, from 0 in 2013 to around 130 million in 2025." caption="Figure 2. Item creation over time in Wikidata." %}

Wikidata offers a wide variety of tools to edit, query, and visualize its data. This [semantic web](https://en.wikipedia.org/wiki/Semantic_Web) model helps advance social justice, as it enables small communities that are often outside the mainstream of science to access, apply, and generate open knowledge and consequently have a broader impact. Obregón Sierra[^7], for example, used Wikidata to include information about libraries in Spain so that they could be accessed by anyone, anywhere in the world. Initially, Wikidata contained only 303 Spanish library entries. After importing the Spanish government's library dataset, the author created 7,861 new entries and enhanced 206 existing ones. This addition elevated Spain from 13th place (2,424 GLAM items) to second place in global GLAM rankings.[^7]

Since Wikidata can connect local metadata with global data, many institutions with digital collections have begun working with it to increase their global reach. One institutional development worth highlighting is the widespread use of Wikidata in library cataloging.[^8] Wikidata identifiers have enabled libraries to enrich their own records. The [Library of Congress’s Program for Cooperative Cataloging pilot project](https://www.wikidata.org/wiki/Wikidata:WikiProject_PCC_Wikidata_Pilot) demonstrates the significant potential of integrating Wikidata into library workflows.

## Wikidata structure

In this section, we will explore the organization of Wikidata, examining its components and understanding their specific functions. Through this analysis, we will strengthen our understanding of Wikidata’s hierarchical and modular structure.

'Items' are the fundamental units of Wikidata. They represent unique concepts, which can cover a wide range of entities such as people, places, events, ideas, celestial bodies, living species, films, literary works, and more.

Each Wikidata item consists of a label, which is a short descriptive name used to identify the concept, followed by a unique identifier formatted as the letter Q followed by a number. For example, the journal Programming Historian has the identifier Q50817399 (Figure 3). This unique designation allows for easy referencing and access to a specific item, regardless of the language in which it is described. It is not necessary to memorize each item’s Q-number.

{% include figure.html filename="en-tr-linked-open-data-wikidata-03.png" alt="Element for the journal ‘Programming Historian’ with its label and Q identifier." caption="Figure 3. Example of a Wikidata identifier: the Q number for the journal ‘Programming Historian’." %}

Labels in Wikidata can be ambiguous. For instance, “San Martín,” which could refer to a person, a city, an island, or a region in Peru. Identifiers, however, are universally applicable and eliminate the need for language-specific identifiers. This feature enhances machine readability and enables bots to efficiently edit Wikidata.

Following the label and identifier, each item includes a short description, which provides additional details to help distinguish it from other potentially similar items. This description is key to understanding the item's context.

Items may also include aliases, which are alternative names or nicknames. These help make items easier to find and recognizable by different communities (Figure 4).

{% include figure.html filename="en-tr-linked-open-data-wikidata-04.png" alt="Element for Charles III, King of the United Kingdom, with its various descriptions highlighted." caption="Figure 4. Example of a label, identifier, description, and name variants (aliases) in Wikidata." %}

After this initial section (which includes the label, Q-identifier, description, and aliases). Figure 5 shows the example of the item “rain” in Wikidata, along with its translations in Spanish and Chinese. This multilingual section makes information more accessible and useful to a global audience by enabling understanding across languages.

{% include figure.html filename="en-tr-linked-open-data-wikidata-05.png" alt="Element for ‘rain’ with translations in Spanish and Chinese" caption="Figure 5. Example of multilingualism in Wikidata: the case of the item ‘rain’." %}

Wikidata describes items through statements, structured assertions that capture specific information about entities in the database. Each statement consists of a property (an attribute or characteristic) paired with a corresponding value, creating connections between different items (Figure 6). This system of interconnected statements forms the foundation of Wikidata's hierarchical and modular architecture, establishing the relationships that define how knowledge is organized within the platform.

{% include figure.html filename="en-tr-linked-open-data-wikidata-06.png" alt="Element for the journal ‘Programming Historian’ showing five of its statements." caption="Figure 6. Statements in Wikidata: examples of properties and values." %}

Each property has a unique identifier in Wikidata, formatted as the letter P followed by a number. Properties in Wikidata are designed to be reusable across different contexts. This means a property can be applied to multiple item types and is not limited to a single use. Each property has its own documentation page in Wikidata, providing detailed information about its purpose, proper use, and examples.

Values, on the other hand, represent the specific information associated with properties used to describe items in the database. Values can take many forms, including text, numbers, dates, links to other Wikidata items, geographic coordinates, or media files, among others. Values must conform to the constraints defined by the data type of the property they’re associated with. For instance, if a property has a data type of “date,” then the value assigned to that property must be a valid date.

Furthermore, values in Wikidata are open to being edited by any user on the platform. This enables open, community-driven collaboration to maintain and improve the quality of information in the database.

## Create an account and an element in Wikidata: Step-by-step

Although it’s not strictly necessary to have a user account to edit Wikidata, it’s recommended to create one, as it will enhance your experience as an editor and allow you to engage more effectively with the Wikidata community. If you already have an account from any other Wikimedia project, you can use it here as well. With an account, you can track your contributions (i.e., view your edit history). It also enables communication with other users, lets you leave messages on other editors’ discussion pages, and receive notifications about changes to items you’re following. In addition, the community tends to place more trust in edits made by registered users. The figure highlights the button with the specific link to start this process.

{% include figure.html filename="en-tr-linked-open-data-wikidata-07.png" alt="Top-right menu on Wikidata’s homepage showing the option to create a user account." caption="Figure 7. Account creation section on Wikidata." %}

You can use your existing Wikimedia account or create a new one specifically for Wikidata. To do so, go to the [Wikidata homepage](https://www.wikidata.org/) and click on Create Account in the upper-right corner.

After logging in, before adding a new item, it’s recommended to search Wikidata to make sure the item doesn’t already exist. If you find a similar item, you can contribute to it instead of creating a new one. If the item doesn’t exist, you can create a new one. Click the Create a new item button at the top-right corner of the Wikidata homepage (Figure 8).


{% include figure.html filename="en-tr-linked-open-data-wikidata-08.png" alt="Left-side menu on Wikidata’s homepage showing the option to create a new item." caption="Figure 8. Creating a new item on Wikidata." %}


From there, you can begin filling out the fields by entering the required information for your new item. Typically, you’ll include at least a name and a description for the new item (Figure 9). Keep in mind that there are a few established conventions that help ensure consistency across the project:

- Lowercase: Descriptions generally start with a lowercase letter unless the first word is a proper noun that requires capitalization.

- Brevity and clarity: Descriptions should be short and clear, offering concise information about the item in a way that’s easy to understand. In most cases, the proper length is between two and twelve words.

- Avoid redundancy: Don’t repeat information already present in the item’s label. The description should add context or clarify the item.

- No initial articles: Avoid starting descriptions with articles (such as “a” or “an”) to maintain uniformity and simplicity.

- No ending punctuation: Descriptions should not end with a period, as they are more like informative tags than full sentences.

- Local language: Descriptions should be written in the local language of the Wikidata project. For example, if you’re contributing to the Enlgish version of Wikidata, the descriptions should be in English.

{% include figure.html filename="en-tr-linked-open-data-wikidata-09.png" alt="Template for creating a new item in Wikidata with ‘language’, ‘label’, ‘description’ and ‘alias’ fields." caption="Figure 9. Filling out information for a new item on Wikidata." %}

Next, it’s time to start adding statements to enrich the item’s information.

In Wikidata, the first statement commonly added is the “instance of” property (P31), which indicates the type of entity the item represents. This statement helps classify and organize information within Wikidata. Due to the wide range of items in Wikidata, there are many possibilities for the “instance of” statement. Depending on what you’re creating, you’ll choose the entity type that best fits the nature of the object or concept.

For example:

If you’re creating an item for a well-known person, you might use: instance of: human, while if you’re describing Paris, the first statement could be: instance of: city. This helps establish the basic nature of the item and connects it to other similar entries in the database. Here are some additional examples of “instance of” cases:

- Human: For an entity representing a specific person

- City: For an entity representing a city

- Country: For an entity representing a specific country

- Work of art: For paintings, sculptures, and other artistic works

- Animal: For entities that represent specific animals

- Book: For items representing books or written publications

- Non-governmental organization: For an entity representing a specific NGO

- Film: For items representing movies

- Building: For architectural structures or buildings

- Sporting event: For items that represent specific sports events

Wikidata provides a dropdown menu with controlled vocabulary to help you select the most appropriate label for each instance. Although you can freely type into the field, suggestions from the controlled vocabulary appear quickly.

After adding the “instance of” statement, you can continue adding additional statements to further describe the item, using specific properties and associated values.

## Describing Academic Journal data in Wikidata

To understand how Wikidata can be used to describe entities related to academia and research, let’s consider the case of the annual publication of the Sociedad de Bibliotecarios de Puerto Rico (Puerto Rican Society of Librarians), founded in 1998, titled Acceso: Revista Puertorriqueña de Bibliotecología y Documentación. Its unique identifier in Wikidata is [Q116681177](https://www.wikidata.org/wiki/Q116681177).

Statements in Wikidata consist of (at least) one property–value pair. Figure 10 shows the values that have been added for the first statement (“instance of”) for this item: academic journal, scientific journal, and open access publication.

{% include figure.html filename="en-tr-linked-open-data-wikidata-10.png" alt="'Instance of' property with three associated values to represent an open access scholarly journal of librarianship" caption="Figure 10. Example of the ‘instance of’ statement for a journal." %}

There is no specific limit on the number of properties and values you can add to an item in Wikidata. The choice depends on the amount and relevance of information you wish to include about the scientific journal. You can add as many as are necessary to fully describe the item you are representing. For example, other values that could also be included are specialized journal or society journal. However, it’s important to consider the relevance and accuracy of the information you are contributing. The goal is not to add as much as possible, but rather to provide meaningful and useful data for users.

As shown in Figure 11, the next property added to this item is [“short name” (P1813)](https://www.wikidata.org/wiki/Property:P1813). In the case of journals, this is used to record abbreviated titles. Following that, the full official title has been added, along with its reference. Whenever possible, it’s good practice to provide references to support the information you enter. This helps maintain the reliability and verifiability of Wikidata content. References can be links to trustworthy sources such as official websites, recognized databases, books, scholarly articles, or any other academic publication that supports the claim made in the statement. It's important to note that social media sources are not considered appropriate references in Wikidata.

{% include figure.html filename="en-tr-linked-open-data-wikidata-11.png" alt="Three properies of the journal ‘Acceso’ and their related values." caption="Figure 11. Example of journal metadata in Wikidata: title, short title, and field of work." %}

References in Wikidata typically follow a standard format that includes information such as the source title, author (if available), publication date, and a URL or unique identifier (such as a DOI – Digital Object Identifier – or ISBN – International Standard Book Number) that allows users to access the original source.

Next, the [“field of work” (P101)](https://www.wikidata.org/wiki/Property:P101) property was added. This refers to the journal’s area of specialization and is also known as its academic field or discipline. For the Acceso journal, several terms were added related to the management, organization, and preservation of information in different contexts: information science, archival science, documentation science, and museology. Many of these concepts are repeated under the property [“main subject” (P921)](https://www.wikidata.org/wiki/Property:P921).

Even when describing just the basic metadata for a journal, several additional properties may be relevant in Wikidata, such as:

- [“country of origin” (P495)](https://www.wikidata.org/wiki/Property:P495): Indicates the country from which the journal is published.

- [“place of publication” (P291)](https://www.wikidata.org/wiki/Property:P291): Indicates the city or country where the journal’s editorial office is based or where it is regularly published. This provides geographic context and helps users understand its reach and audience.

- [“language of work” (P407)](https://www.wikidata.org/wiki/Property:P407): Specifies the language in which the journal articles are published. This property helps users identify and filter works by language in Wikidata.

- [“official website” (P856)](https://www.wikidata.org/wiki/Property:P856): Records the URL for the journal’s official website. Providing this link gives users direct access to more information about the publication.

- [“online access status” (P6954)](https://www.wikidata.org/wiki/Property:P6954): Indicates whether the journal is freely available online, requires a subscription, or is not available online.

- [“publisher” (P123)](https://www.wikidata.org/wiki/Property:P123): Identifies the organization or individual responsible for editing and managing the publication. In the case of Acceso, the value used is Sociedad de Bibliotecarios de Puerto Rico.

Figure 12 shows an example of how the property [“indexed in bibliographic database” (P8875)](https://www.wikidata.org/wiki/Property:P8875) is used in Wikidata. Through linked data, items can be connected to external databases and catalogs.

{% include figure.html filename="en-tr-linked-open-data-wikidata-12.png" alt="List of databases as values related to the property ‘indexed in bibliographic database’." caption="Figure 12. Example of using the 'indexed in bibliographic database' property in Wikidata." %}

## Describing people's data in Wikidata

Creating linked open data about individuals is an important step in describing entities within academia and research, as it enables the authorship of an article to be connected to the journal in which the work is published. In this way, Wikidata can help increase the visibility of an institution’s scholarly output.

Using Wikidata to create person records also supports identity management in libraries, archives, and museums. Identity management depends on the use and linking of unique identifiers from different sources. Including multiple identifiers for the same person in Wikidata facilitates exploration, discovery, and access to information beyond traditional metadata silos, such as library catalogs.[^9]

When creating data about people, especially living individuals, it is important to consider ethical issues related to dignity, safety, and privacy. The Wikidata page [Wikidata:Living people](https://www.wikidata.org/wiki/Wikidata:Living_people) states that only verifiable information should be included, and that this information must not violate reasonable expectations of privacy. Statements about a person must be backed by reliable sources. Remember that social media is not considered an acceptable source on Wikidata.

The first step in creating a person record in Wikidata is to make sure a record does not already exist. If none exists, you may create a new item. In the label field, enter the name by which the person is most commonly known. Then, write a brief description of the person, and optionally include other name variants. After completing the label and description, you can begin adding statements. The first statement should be [“instance of” (P31)](https://www.wikidata.org/wiki/Property:P31) with the value [“human” (Q5)](https://www.wikidata.org/wiki/Q5). Figure 13 shows how this is done for Puerto Rican philosopher Francisco José Ramos [(Q105725041)](https://www.wikidata.org/wiki/Q105725041).

{% include figure.html filename="en-tr-linked-open-data-wikidata-13.png" alt="Element for Francisco José Ramos showing the first statement as 'instance of: human'." caption="Figure 13. Label, description, and name variants in Wikidata." %}

The next statements relate to names. You can add [“given name” (P735)](https://www.wikidata.org/wiki/Property:P735), [“family name” (P734)](https://www.wikidata.org/wiki/Property:P734), and [“second family name” (P1950)](https://www.wikidata.org/wiki/Property:P1950). For compound given names, enter each name as a separate value under the “given name” property, and use the qualifier [“series ordinal” (P1545)](https://www.wikidata.org/wiki/Property:P1545) to indicate first and second name. Figure 14 illustrates this process for entering the compound given name “Francisco José.”

{% include figure.html filename="en-tr-linked-open-data-wikidata-14.png" alt="Two values associated with the property ‘given name’: 'Fransisco' and 'José'." caption="Figure 14. Compound given name in Wikidata." %}

For Hispanic surnames, two properties should be used. The [“family name” (P734)](https://www.wikidata.org/wiki/Property:P734) is used for the paternal surname, while [“second family name” (P1950)](https://www.wikidata.org/wiki/Property:P1950) is used for the maternal surname.

Another common property when describing individuals is [“field of work” (P101)](https://www.wikidata.org/wiki/Property:P101). This property indicates a person’s area of expertise or discipline. You may add as many values as needed to accurately reflect the fields of knowledge or activity in which the person is recognized.

You may also include the property [“occupation” (P106)](https://www.wikidata.org/wiki/Property:P106), which complements the field of work. This property allows multiple values and is useful for representing the different professional or artistic roles of a person. Keep in mind that all personal information should come from trustworthy and accessible sources. These sources should be cited as references for each value entered. Figure 15 shows the values for the occupation property, with references from a Wikipedia article.

{% include figure.html filename="en-tr-linked-open-data-wikidata-15.png" alt="Three values associated with the ‘occupation’ property: 'philosopher', 'poet', and 'university teacher'." caption="Figure 15. Values for the 'occupation' property in Wikidata." %}

Recording identifiers associated with a person is one of the most important aspects of Wikidata. Each identifier is added as a distinct property. For example, you can include: [ORCID iD (P496)](https://www.wikidata.org/wiki/Property:P496), [Scopus Author ID (P1153)](https://www.wikidata.org/wiki/Property:P1153), [VIAF ID (P214)](https://www.wikidata.org/wiki/Property:P214), [ISNI (P213)](https://www.wikidata.org/wiki/Property:P213), Library identifiers such as the [Library of Congress authority ID (P244)](https://www.wikidata.org/wiki/Property:P244) or the [National Library of Spain ID (P950)](https://www.wikidata.org/wiki/Property:P950). Figure 16 shows a set of identifiers for the same person.

{% include figure.html filename="en-tr-linked-open-data-wikidata-16.png" alt="List of various identifiers that can be related to a person" caption="Figure 16. Identifiers associated with a person in Wikidata." %}

These are just some of the properties available for creating linked open data about individuals in Wikidata. Below are other relevant properties that can provide more detailed information. However, we must be especially cautious when entering data about living people and always consider ethical implications related to their dignity, safety, and privacy.

- [“place of birth” (P19)](https://www.wikidata.org/wiki/Property:P19): To specify the person’s known birthplace.

- [“date of birth” (P569)](https://www.wikidata.org/wiki/Property:P569): To specify the person’s date of birth.

- [“country of citizenship” (P27)](https://www.wikidata.org/wiki/Property:P27): To specify the person’s legal citizenship. Note that this is a legal—not cultural—term, and does not necessarily reflect a person’s cultural or ethnic background.

- [“languages spoken, written, or signed” (P1412)](https://www.wikidata.org/wiki/Property:P1412): To specify the languages the person uses.

- [“affiliation” (P1416)](https://www.wikidata.org/wiki/Property:P1416): To indicate the organization to which a person is affiliated.

- [“employer” (P108)](https://www.wikidata.org/wiki/Property:P108): A subproperty of affiliation, used to specify the institution or company for which a person works.

- [“educated at” (P69)](https://www.wikidata.org/wiki/Property:P69): To indicate the academic institution(s) where the person studied.

- [“sex or gender” (P21)](https://www.wikidata.org/wiki/Property:P21): To indicate the sex or gender with which the person identifies. This property can be sensitive and potentially privacy-violating, so it should be used with care.

## Tools suggested for element description in Wikidata

Wikidata offers a variety of tools or gadgets to make your work easier. These tools are available in the Preferences menu, under the Gadgets section (Figure 17). The Preferences menu becomes visible once you are logged into your user account. Click on the dropdown menu on the top right of the page to see the Preferences menu.

{% include figure.html filename="en-tr-linked-open-data-wikidata-17.png" alt="Preferences menu for registered users showing the 'Gadgets' section to use accessories or tools." caption="Figure 17. Wikidata Preferences menu." %}

One helpful tool for creating and editing entities is Recoin (Relative Completeness Indicator) (Figure 18), which displays a list of relevant properties that could be added to an entity’s page. This is especially useful for new users who may not yet be familiar with Wikidata’s properties.

{% include figure.html filename="en-tr-linked-open-data-wikidata-18.png" alt="List of different tools with the option ticked to activate the ‘Recoin’ tool." caption="Figure 18. Recoin tool in Wikidata." %}

Once activated, the Recoin tool appears on the entity’s page. You can click on it to view a list of relevant properties you may want to include. Below is a list of the most important properties for describing a person (Figure 19).

{% include figure.html filename="en-tr-linked-open-data-wikidata-19.png" alt="Properties suggested by the Recoin tool as relevant to the description of a person, including their 'Property ID', 'label' in natural language, relavance in percentages, and the option to 'Add claim'." caption="Figure 19. Relevant properties suggested by the Recoin tool in Wikidata." %}

## Conclusions

In this lesson, we have learned the fundamentals of metadata and linked open data, which has helped us understand the importance and potential of Wikidata in information management and retrieval. Throughout the tutorial, we explored the structure of Wikidata and the steps needed to create and edit items, focusing on both academic journals and authority data for individuals associated with them. We saw how to structure and link this data to promote open access and contribute to the visibility and interoperability of resources in a digital environment. Even if you had never worked with this before, you now know how to get started. We encourage you to keep practicing and exploring further.

If you’re interested in learning more about linked open data and Wikidata, we recommend the [Programming Historian lesson by Gustavo Candela et al. (2021)](https://programminghistorian.org/es/lecciones/reutilizando-colecciones-digitales-glam-labs), which demonstrates how to reuse digital collections published by cultural heritage institutions.

## References

[^1]: Daudinot Founier, Isabel. (2006). Organización y recuperación de información en Internet: teoría de los metadatos. ACIMED, 14(5) Recuperado el 27 de febrero de 2024, de <http://scielo.sld.cu/scielo.php?script=sci_arttext&pid=S1024-94352006000500006&lng=es&tlng=es>.

[^2]: Torres Pombert, Ania. (2006). ¿Catalogación en el entorno digital?: una breve aproximación a los metadatos. ACIMED, 14(5) Recuperado el 27 de febrero de 2024, de <http://scielo.sld.cu/scielo.php?script=sci_arttext&pid=S1024-94352006000500009&lng=es&tlng=es>.

[^3]: Cuba Rodríguez, Yariannis, & Olivera Batista, Dianelis. (2018). Los metadatos, la búsqueda y recuperación de información desde las Ciencias de la Información. E-Ciencias de la Información, 8(2), 146-158. <https://dx.doi.org/10.15517/eci.v8i2.30085>.

[^4]: Cadena López, Aydé, Ramos Luna, Lorena Litai, & Rivera González, Gibrán. (2022). Los datos abiertos en los estudios organizacionales: Reflexiones e implicaciones. Trace (México, DF), (82), 41-65. Epub 02 de diciembre de 2022. <https://doi.org/10.22134/trace.82.2022.819>.

[^5]: Ávila-Barrientos, Eder. (2022). Recuperación de información con Linked Open Data. Investigación bibliotecológica, 36(91), 125-146. Epub 15 de noviembre de 2022. <https://doi.org/10.22201/iibi.24488321xe.2022.91.58567>.

[^6]: Semantic triple <https://en.wikipedia.org/wiki/Semantic_triple>.

[^7]: Obregón Sierra, Ángel. (2022). Inserción de metadatos de las bibliotecas españolas en Wikidata: un modelo de datos abiertos enlazados. Revista Española De Documentación Científica, 45(3), a330. <https://doi.org/10.3989/redc.2022.3.1870>.

[^8]: Gutiérrez, Silvia & Fontenelle, Giovanna. (2023). #LD42023. Parte I: El futuro de Wikidata + Bibliotecas (Un taller). Diff: Wikimedia Community Blog. Recuperado el 31 de julio de 2024, de <https://perma.cc/H4FR-L3DY>.

[^9]: Werf, Titia van der. (2022). Gestión de la identidad del autor en la cadena del libro. Traducción de Francesc García Grimau. Hanging Together: the OCLC Research Blog. Recuperado el 15 de mayo de 2024, de <https://perma.cc/GS92-4HFQ>.

