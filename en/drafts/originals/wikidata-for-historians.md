---
title: "Wikidata for historians"
slug: wikidata-for-historians
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Will Hanley
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/661
difficulty:
activity:
topics:
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Lesson Overview

In this lesson you will learn:
- what kinds of information Wikidata contains, 
- how to explore that data in order to contextualize questions in your historical research, and
- how to edit and add data in Wikidata.

While this stand-alone lesson focuses on Wikidata, it can also serve to extend your understanding of Linked Open Data. Wikidata is the most user-friendly implementation of this data structure, and it's under constant development. It's a great place to learn about key graph data features, such as schemas and the SPARQL query language, which can be applied in other contexts. After completing this lesson, users might wish to read Jonathan Blaney's [Introduction to the Principles of Linked Open Data](https://programminghistorian.org/en/lessons/intro-to-linked-data), which covers some of the same ground in more abstract and general terms. (When Blaney wrote his lesson, Wikidata did not yet exist.) 

There are no prerequisites for this lesson, but most users will want to log in to Wikidata in order to personalize language settings. A Wikipedia user id also works in Wikidata.

## What is Wikidata?

The cluster of technologies called [semantic web](https://en.wikipedia.org/wiki/Semantic_Web)/[graph data](https://en.wikipedia.org/wiki/Graph_database)/[linked data](https://en.wikipedia.org/wiki/Linked_data#Linked_open_data)/[resource description framework](https://en.wikipedia.org/wiki/Resource_Description_Framework) has been an object of fascination for years, due to its potential to solve the problem of aggregating extemely diverse data sets. Outside of some specialist cases, that potential had not been realized until the late 2010s, with the advent and popularization of Wikidata. Now, for the first time, historians interested in these technologies have a substantial, well-supported foundation for their work.[^1] 

[Wikidata](https://www.wikidata.org/wiki/Wikidata:Introduction) is the world's largest open data set–or, to use its self-identification, "knowledge base." Like any database, it operates according to rigid rules about how information must be structured. Unlike most databases, Wikidata's structure prioritizes open contribution and collaboration protocols, interoperability, and linking between data sets. For historians, this data structure offers something especially attractive: in cases of uncertainty, it can accommodate more than one answer.

Wikidata is a sibling of Wikipedia, and shares its [politics of knowledge production and dissemination](https://en.wikipedia.org/wiki/Wikipedia:Five_pillars), as well as the [values of the Wikimedia Foundation](https://wikimediafoundation.org/about/values/#a1-we-are-in-this-mission-together). The debate over Wikipedia's merits and faults is rich; many historians will agree that it's a convenient place to look up facts, refreshingly broad and democratic in its coverage, but it can be unreliable in its synthesis.[^2] Wikidata's content, in contrast to Wikipedia, all facts and no synthesis. 

### An example of an item page

To get an idea of Wikidata's nature, and without worrying too much about the format, spend a bit of time scrolling through what Wikidata has to tell us about former Egyptian president [Gamal Abdel Nasser](https://www.wikidata.org/wiki/Q39524). 

At the top of this page, you will see many variant versions and spellings of his name, in various languages. The main spelling is called a "label," and each variant is an "alias."

Wikidata's multilingual functionality is superb. Click on "all entered languages" to see just how true this is. If you wish to interface with the whole knowledge base in a language other than English, log in and click "English" at the top. You may now choose another language (and you can [do more with language on Wikidata](https://www.wikidata.org/wiki/Help:Navigating_Wikidata/User_Options#Language_settings)). 

{% include figure.html filename="en-or-wikidata-for-historians-01.png" alt="Visual description of figure image" caption="Figure 1: Nasser labels and languages." %}

A bit further down, a section of **Statements** begins. Some of these statements are the sort of transparent information you'd see on a passport: "sex or gender" is "male", "date of birth." Others (such as "instance of" "human") may be a bit less obvious–we'll say more about those later.

Even further down, you'll find another section with the heading **Identifiers**. Here you'll find unique identifiers from dozens of other databases–from the Library of Congress to the Internet Movie Database–that identify Abdel Nasser in their systems. This avalanche of identifiers is characteristic of the linked data universe. (For further background on this point, read the [section on linked data authorities](https://programminghistorian.org/en/lessons/intro-to-linked-data#linked-open-data-what-is-it) in Blaney's lesson.) And at the very bottom, you will see a list of all of the Wikipedia pages about him. 

### Explaining the page

**Unique identifiers** are one key to understanding Wikidata. Wikidata's own identifier for Abdel Nasser can be found in the URL of his page, which is `https://www.wikidata.org/wiki/Q39524.` Abdel Nasser and all of the other objects that Wikidata describes are called **items**. The Q-number, which is the unique identifier that you find at the end of the URL at the top of every item's page (`Q39524` for Abdel Nasser), is the essence of any item. Everything else you see on the page is semantics: optional labels and signfiers and statements about this identifier.

Most historians–particularly those with some background in postcolonial theory–might readily identify the value in distinguishing between the signifier and the signified. In the Wikidata knowledge base, the signfied are only ever numbers; everything else is a signifier. This distinction means that the relationships between items do not depend on arbitrary human semantic choices. Wikidata can use multiple terms for the same idea, and those terms can change, without breaking the database.

Wikidata also uses P-numbers, which refer to **properties**. In the "Statements" section, you will note two columns. The first column (with a grey field) contains properties. The second column (with a white field) contains values that answer these properties (sometimes these are called "objects" of properties). These values may be items, or dates, or strings, or other datatypes. This lesson is not the place to get bogged down in the [complexities of data models](https://www.wikidata.org/wiki/Wikidata:Data_model). Instead, as you begin to explore Wikidata, employ a common sense reading of those properties that make sense to you.

{% include figure.html filename="en-or-wikidata-for-historians-02.png" alt="Visual description of figure image" caption="Figure 2: Properties and objects in statements." %}

You can click on any item or property to go to its own page, which will give you a description, aliases, statements, and identifers related to that idea. And it is useful to know that every Wikipedia page has a counterpart item in Wikidata, accessible via a link the left hand tools menu:

{% include figure.html filename="wikidata-item-on-wikipedia.png" alt="Visual description of figure image" caption="Figure 3: Wikidata item on Wikipedia." %}

To get more of a taste for Wikidata, find the Wikidata item associated with Wikipedia page on a subject of interest to you. Click on links on that page–some will make sense, probably; others will not. Focus on those that are most transparent, and orient yourself a bit in the web of data that makes up Wikidata.

You are probably thinking that on the face of things, there's nothing especially enticing about these lists of details. This is correct: you could simply look up most of this trivia in any decent reference book. But Wikidata's value does not consist in its isolated factoids. Instead, Wikidata's power derives from the way that it combines these data points with all of the other data it contains. It does this with a powerful seach protocol called [SPARQL](https://en.wikipedia.org/wiki/SPARQL). 


## Endnotes

[^1]: Take, for example, this line from Blaney's 2017 lesson: "Unfortunately I can’t find anything that describes the relationship between a teacher and a pupil in the Music Ontology. But the ontology is published openly, so I can use it to describe other features of music and then create my own extension." With Wikidata, it is no longer necessary to create such extensions, because its ontology is already quite thoroughly realized. To take Blaney's example, [the item page for Moriz Rosenthal](https://www.wikidata.org/wiki/Q213772) shows that he was a "student of"[P1066](https://www.wikidata.org/wiki/Property:P1066) Franz Liszt, and that Charles Rosen was his "student"[P802](https://www.wikidata.org/wiki/Property:P802).
[^2]: Rosenzweig, Roy. “Can History Be Open Source? Wikipedia and the Future of the Past.” *Journal of American History* 93, no. 1 (June 1, 2006): 117–46. https://doi.org/10.2307/4486062.
[^3]: The reason for this quirk is straightforward: at the time of writing, "Prime Minister of India" ([Q192711](https://www.wikidata.org/wiki/Q192711)) is defined as "instance of"([P31](https://www.wikidata.org/wiki/Property:P31)) rather than "subclass of"([P279](https://www.wikidata.org/wiki/Property:P279)) "head of government"([Q2285706](https://www.wikidata.org/wiki/Q2285706)).
[^4]: These numbers come from a [fascinating statistical summary of Wikidata's share of "all human knowledge."](https://www.wikidata.org/wiki/User:Emijrp/All_Human_Knowledge#Books) Borges fans will enjoy it!
[^6]: Unlike new items, new properties cannot be created at whim. In fact, there are only about 10,000 properties, compared to 110,000,000 items.
