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
- how Wikidata structures that information, and
- how to explore its data in order to contextualize questions in your historical research.

While this stand-alone lesson focuses on Wikidata, it can also serve to extend your understanding of Linked Open Data. Wikidata is the most user-friendly implementation of this data structure, and it's under constant development. It's a great place to begin to learn about key graph data features, such as schemas and the SPARQL query language, which can be applied in other contexts. After completing this lesson, users might wish to read Jonathan Blaney's [Introduction to the Principles of Linked Open Data](https://programminghistorian.org/en/lessons/intro-to-linked-data), which covers some of the same ground in more abstract and general terms. (When Blaney wrote his lesson, Wikidata did not yet exist.) Historians will also benefit an [introductory Wikidata lesson](https://programminghistorian.github.io/ph-submissions/en/drafts/translations/linked-open-data-wikidata) <!-- LINK TO BE UPDATED --> aimed at librarians, archivists, and other information professionals which covers some of the same ground using different examples.

There are no prerequisites for this lesson, but most users will want to log in to Wikidata in order to personalize language settings. A Wikipedia user id also works in Wikidata.

## About this case study

This lesson compares mid-twentieth century Egyptian president Gamal Abdel Nasser to other heads of state past and present. The information revealed in this example of high political history will be legible to most readers, but it may strike readers as conventional and of meagre analytical value. I encourage readers, at every step of this lesson, to repeat the example exercises using persons, places, or things drawn from their own fields of interest. Wikidata is best learned by imitating examples that are simple and clear.

The Gamal Abdel Nasser comparison is useful for another reason: data on heads of state is fairly complete in Wikidata. Readers will perhaps find more gaps when investigating their own fields of interest. Also, readers may find some ambiguities and inconsistencies in how data is presented in Wikidata when they look at information they know well. I believe that Wikidata's gaps and ambiguities are part of its value for historians, as compared to more categorical, "objective" datasets and database structures. This case study from "great man" history is a simplistic example meant to guide readers towards more interesting investigations of their own design.

## What is Wikidata?

The cluster of technologies called [semantic web](https://en.wikipedia.org/wiki/Semantic_Web)/[graph data](https://en.wikipedia.org/wiki/Graph_database)/[linked data](https://en.wikipedia.org/wiki/Linked_data#Linked_open_data)/[resource description framework](https://en.wikipedia.org/wiki/Resource_Description_Framework) has been an object of fascination for years, due to its potential to solve the problem of aggregating extemely diverse data sets. Outside of some specialist cases, that potential went unrealized until the late 2010s, with the advent and popularization of Wikidata. Now, for the first time, historians interested in these technologies have a substantial, well-supported foundation for their work.[^1] 

[Wikidata](https://www.wikidata.org/wiki/Wikidata:Introduction) is the world's largest open data set–or, to use its self-identification, "knowledge base." Like any database, it operates according to rigid rules about how information must be structured. Unlike most databases, however, Wikidata's structure prioritizes open contribution and collaboration protocols, interoperability, and linking between data sets. For historians, this data structure offers something especially attractive: in cases of uncertainty, it can accommodate more than one answer.

Wikidata is a sibling of Wikipedia, and shares its [politics of knowledge production and dissemination](https://en.wikipedia.org/wiki/Wikipedia:Five_pillars), as well as the [values of the Wikimedia Foundation](https://wikimediafoundation.org/about/values/#a1-we-are-in-this-mission-together). Among these values is commitment to underrepresented knowledge communities. Wikidata's interface is seamlessly multilingual and, unlike Wikipedia, users can see information in any and all languages they choose through the same interface. This functionality is particularly useful for historians working in multilingual and cross-cultural contexts.

The debate over Wikipedia's merits and faults is rich; many historians will agree that it's a convenient place to look up facts, refreshingly broad and democratic in its coverage, but it can be unreliable in its synthesis.[^2] Wikidata's content, in contrast to Wikipedia, is all facts and no synthesis. 

<!-- Perhaps, you can also mention examples of research that use Wikidata (two or three references). -->

### An example of an item page

To get an idea of Wikidata's nature, and without worrying too much about the format, spend a bit of time scrolling through what Wikidata has to tell us about former Egyptian president [Gamal Abdel Nasser](https://www.wikidata.org/wiki/Q39524). 

At the top of this page, you will see many variant versions and spellings of his name, in various languages. The main spelling is called a "label," and each variant is an "alias."

Wikidata's multilingual functionality is superb. Click on "all entered languages" to see just how true this is. If you wish to interface with the whole knowledge base in a language other than English, log in and click "English" at the top. You may now choose another language (and you can [do more with language on Wikidata](https://www.wikidata.org/wiki/Help:Navigating_Wikidata/User_Options#Language_settings)). 

{% include figure.html filename="en-or-wikidata-for-historians-01.png" alt="Screenshot of top lines of Wikidata item page for Gamal Abdel Nasser, showing label, description, and aliases in English, French, Chinese, and Cantonese. Links to change page language and to show all entered languages are circled in red." caption="Figure 1: Nasser labels and languages." %}

A bit further down, a section of **Statements** begins. Some of these statements are the sort of transparent information you'd see on a passport: "sex or gender" is "male", and you can find Abdel Nasser's "date of birth." Others statements (such as "instance of" "human") may be a bit less obvious–we'll say more about those later.

Even further down, you'll find another section with the heading **Identifiers**. Here you'll find the unique identifiers that dozens of other databases–from the Library of Congress to the Internet Movie Database–use to identify Abdel Nasser in their systems. This avalanche of identifiers is characteristic of the linked data universe. (For further background on this point, read the [section on linked data authorities](https://programminghistorian.org/en/lessons/intro-to-linked-data#linked-open-data-what-is-it) in Blaney's lesson.) And at the very bottom, you will see a list of all of the Wikipedia pages about him. 

### Explaining Q-number identifiers

**Unique identifiers** are one key to understanding Wikidata. Wikidata's own identifier for Abdel Nasser can be found in the URL of his page, which is `https://www.wikidata.org/wiki/Q39524.` Abdel Nasser and all of the other objects that Wikidata describes are called **items**. The Q-number, which is the unique identifier that you find at the end of the URL at the top of every item's page (`Q39524` for Abdel Nasser), is the essence of any item. Everything else you see on the page is semantics: optional labels and signfiers and statements about this identifier.

Most historians–particularly those with some background in postcolonial theory–might readily identify the value in distinguishing between the signifier and the signified. The sources we use are signifiers containing subjective accounts of a multivocal past, rather than singular objective facts. The semantic data model on which Wikidata is based is founded on this same distinction: the human words it contains (such as labels and aliases) are provisional, contingent, and changeable, while the things they describe are encoded in machine-readable numbers (such as `Q39524`). In other words, the signfied are only ever numbers; everything else is a signifier. This distinction means that the knowledge base does not depend on arbitrary human semantic choices to organize the relationship between the people, places, events, concepts, and things that it describes. Wikidata can use multiple terms for the same idea, and those terms can change, without breaking the database.

For example, the Egyptian president's given name is pronounced "Jamal" in standard Arabic and "Gamal" in Egyptian Arabic. Similarly, his surname is rendered differently by writers in different genres. Politicians and journalists refered to him as Nasser, others as Abdel Nasser, while Arabophone scholars of the Middle East sometimes transliterate his name "ʻAbd al-Nāṣir." Aliases--alternate labels--mean that searchs for each of these terms will arrive at the same `Q39524` item.

But Wikidata's unique identifier does another useful thing by disambiguating items with the same labels. For example, the Egyptian actor [Gamal Abdel Nasser (`Q12205892`)](https://www.wikidata.org/wiki/Q12205892) has exactly the same name (i.e., label) as the president. In Wikidata, however, there is no confusing them, because their Q-numbers are different. 

### Explaining statements

Wikidata also uses P-numbers, which refer to **properties**. In the "Statements" section, you will note two columns. The first column (with a grey field) contains properties. The second column (with a white field) contains values that answer these properties (sometimes these are called "objects" of properties). These values may be items, or dates, or strings, or other datatypes. This lesson is not the place to get bogged down in the [complexities of data models](https://www.wikidata.org/wiki/Wikidata:Data_model). Instead, as you begin to explore Wikidata, employ a common sense reading of those properties that make sense to you.

{% include figure.html filename="en-or-wikidata-for-historians-02.png" alt="Screenshot of five Wikidata statements about Gamal Abdel Nasser. Five properties are circled in green: given name, family name, patronym, date of birth, place of birth. Objects of each property are circled, with item values in red, time datatype value in blue, and object qualifier in orange." caption="Figure 2: Properties and objects in statements." %}

You can click on any item or property to go to its own page, which will give you a description, aliases, statements, and identifers related to that idea. And it is useful to know that every Wikipedia page has a counterpart item in Wikidata, accessible via a link the left hand tools menu:

{% include figure.html filename="en-or-wikidata-for-historians-03.png" alt="Screenshot of Wikipedia page for Gamal Abdel Nasser, with link to Wikidata item in lefthand menu circled in red." caption="Figure 3: Wikidata item on Wikipedia." %}

To get more of a taste for Wikidata, find the Wikidata item associated with Wikipedia page on a subject of interest to you. Click on links on that page–some will make sense, probably; others will not. Focus on those that are most transparent, and orient yourself a bit in the web of data that makes up Wikidata.

You are probably thinking that on the face of things, there's nothing especially enticing about these lists of details. This is correct: you could simply look up most of this trivia in any decent reference book. But Wikidata's value does not consist in its isolated factoids. Instead, Wikidata's power derives from the way that it combines these data points with all of the other data it contains. It does this with a powerful search protocol called [SPARQL](https://en.wikipedia.org/wiki/SPARQL). 

### Combining factoids

Queries combine factoids into patterns that can illuminate historical context. We'll learn more about constructing Wikidata queries later, but let's start looking at the results of a few pre-constructed queries. Let's say that you are interested in the role that youth may have played in Abdel Nasser's rise to power, and you want to consider the age at which other mid-twentieth-century leaders took power. Here's [a query that returns that information](https://w.wiki/E$jz) via the Wikidata query service. (Don't get hung up on the details of the query; if you are curious, the grey lines explain what each step accomplishes.) To execute the query, press the blue "play" button at the bottom left.

Scrolling down the table of results, which are sorted by age, you will find that Abdel Nasser became president when he was 38 (in 1954). Comparing him to the hundreds of other heads of state listed, we can see that some first took power at an older age, and some at a younger age. If you happen to be interested in leaders, life cycle, and generations, this list is a good starting point for further data exploration and hypothesis testing.

Wikidata supports data-informed contextualization of this kind. Once you get the hang of SPARQL, it's easy, with an additional query statement, to enrich your data: [add a continent column](https://w.wiki/E$k7), [add a gender column and count of spouses and children](https://w.wiki/FmqN), or [add a column giving each leader's name in her or his native language](https://w.wiki/E$kB).

All such results can be downloaded in the usual data formats and as code snippets in various programming languages. Wikidata even includes a rudimentary visualization package with its query service, which can help in quick data exploration. Here's a [map of the birthplace of everyone with the first name "Gamal"](https://w.wiki/E$kF) (move your cursor to the right margin of the map to access the SPARQL query itself).

Obviously, this is only a tiny fraction of the world's Gamals. It is essential to recognize what Wikidata does not do–and should not be expected to do. The knowledge base is vast, but it will always be incomplete. While many or even most of the data in these lists of results are more or less correct, we find some individual answers that don't make sense, and others that are missing.

This incompleteness is a function of two features of the knowledge base. First, there is no guarantee that the data it contains are accurate, and no rigid requirement that it be source referenced. At the time of writing, eight references attested Abdel Nasser's date of birth:

{% include figure.html filename="en-or-wikidata-for-historians-04.png" alt="Screenshot of date of birth statement on Gamal Abdel Nasser Wikidata page, showing five different references for this statement. Each of these references consists of three or more property-object pairs, detailing the authority and location containing the reference." caption="Figure 4: Nasser birthdate references." %}

However, we only have one reference for the date when he assumed the President's office. That reference is to an import from English Wikipedia–a souce which could itself be scrutinized for accuracy and conpleteness. Generally speaking, at this point in its development, Wikidata's references are relatively poor in quality and quantity. However, in many cases, we can reasonably assume that factual information in Wikidata will typically be accurate for purposes of data exploration and hypothesis testing. Our historian's judgment will serve us well when we look at the evidence more closely.

A second (and more interesting) reason for incomplete Wikidata query results concerns the structure of knowledge that Wikidata produces. Briefly put, Wikidata must be queried using its own (often idiosyncratic) terms and categories. You must understand its taxonomies in order to use it effectively, and this issue warrants a section of its own. 

### Key vocabulary:
- item
- property
- label
- alias
- identifier
- statement
- value

## Wikidata's taxonomies

Our Abdel Nasser case study compares him to other state leaders--but what is a leader, really? Does this position mean the same thing in every state? Categories and semantics are juicy problems for any historian. This is true in analog scholarly debate, and it is also true when we consider Wikidata and other semantic data structures.

While there is (probably) general consensus on the meaning of "date of birth," most concepts are not so clear cut. Take, for example, "head of state"([Q48352](https://www.wikidata.org/wiki/Q48352)), which we used in the age query above to identify Abdel Nasser and his counterparts in other countries. But Wikidata also contains an item labeled "head of government"([Q2285706](https://www.wikidata.org/wiki/Q2285706))--perhaps we ought to have used it instead? 

Let's take a closer look at "head of state" and "head of government." Now is the time to introduce a concept that may be new to most historians: **class**. Let's disambiguate this meaning of "class" from the "class" of "class struggle," though! In database ontology, [class](https://en.wikipedia.org/wiki/Class_(knowledge_representation)) is a logical term organizing concepts in a data structure. 

Looking again at item pages, we see that "head of state"([Q48352](https://www.wikidata.org/wiki/Q48352)) is an "instance of"([P31](https://www.wikidata.org/wiki/Property:P31)) (or kind or example of) "public office"([Q294414](https://www.wikidata.org/wiki/Q294414)), but a "subclass of"([P279](https://www.wikidata.org/wiki/Property:P279)) "statesperson"([Q372436](https://www.wikidata.org/wiki/Q372436)) and "leader"([Q1251441](https://www.wikidata.org/wiki/Q1251441)), This latter statement means that all heads of state are statespersons and leaders, but not all statesperson and leaders are heads of state.

Keen-eyed observers will already detect the presence of a formal taxonomy here. Sure enough, we can look down a step to see all of the public offices that are [subclasses of "head of state"](https://w.wiki/E$kJ) (ordered by number of instances). You will notice that "head of state" gives us a lot of monarchs and US state governors, among thousands of other positions. In contrast, consider the list of the [subclasses of "head of government"](https://w.wiki/E$kL). "Head of government" is dominated by mayors and prime ministers. ("Captain Regent of San Marino" features high on both lists–probably as the result of a zealous contributor making sure these entries were complete.) 

<div class="table-wrapper" markdown="block">

| Head of state subclass | count | Head of government subclass | count |
| --------- | --------- | --------- | --------- |
|president ([Q30461](https://www.wikidata.org/wiki/Q30461))|6314|mayor ([Q30185](https://www.wikidata.org/wiki/Q30185))|21578|
|regent ([Q477406](https://www.wikidata.org/wiki/Q477406))|911|mayor of a place in the Netherlands ([Q13423499](https://www.wikidata.org/wiki/Q13423499))|3750|
|Captain Regent of San Marino ([Q258045](https://www.wikidata.org/wiki/Q258045))|893|mayor of a place in France ([Q382617](https://www.wikidata.org/wiki/Q382617))|1794|
|pope ([Q19546](https://www.wikidata.org/wiki/Q19546))|267|Captain Regent of San Marino ([Q258045](https://www.wikidata.org/wiki/Q258045))|893|
|Doge of Genoa ([Q3712541](https://www.wikidata.org/wiki/Q3712541))|172|mayor of a place in the Czech Republic ([Q99356295](https://www.wikidata.org/wiki/Q99356295))|892|
|Ban of Croatia ([Q253779](https://www.wikidata.org/wiki/Q253779))|141|mayor of a place in Hungary ([Q2922332](https://www.wikidata.org/wiki/Q2922332))|768|
|President of the Generalitat of Catalonia ([Q16933549](https://www.wikidata.org/wiki/Q16933549))|133|mayor of a place in Italy ([Q670106](https://www.wikidata.org/wiki/Q670106))|657|
|Doge of Venice ([Q858316](https://www.wikidata.org/wiki/Q858316))|126|mayor in Luxembourg ([Q29639349](https://www.wikidata.org/wiki/Q29639349))|446|
|Emperor of Japan ([Q208233](https://www.wikidata.org/wiki/Q208233))|124|lord mayor ([Q109862464](https://www.wikidata.org/wiki/Q109862464))|446|
|Hetman of Zaporizhian Host ([Q16157109](https://www.wikidata.org/wiki/Q16157109))|110|Lord Mayor of London ([Q73341](https://www.wikidata.org/wiki/Q73341))|439|

</div>

Table 1: Top 10 subclasses of two similar classes (summer 2024)

Confronted with this mass of examples, you might feel somewhat confused, both by particular instances and by the overall picture. This empirically-generated account is a long way from the synthetic statements of Wikipedia. Such ambiguous bodies of results embody the virtue and value of Wikidata for historians. It is not an automatic answer box. It is an elaborate logical structure giving precise answers to abstract questions about which there is no real consensus. Any serious user must learn which taxonomies Wikidata already uses to describe their topics of interest. Users must also use their knowledge of context to mediate between the theoretical and the empirical. Fortunately, this is exactly what historians are trained to do.

### Querying with taxonomies
Let's run the age-of-first-taking-office query we used in the Abdel Nasser example above, [but use "head of government" instead of "head of state"](https://w.wiki/E$kN). This query returns Abdel Nasser's age when he became prime minister rather than president. But this query accurately captures other leaders who are not returned with the "head of state" query. For instance, it returns prime ministers in states where the president is largely ceremonial. But it also includes some mayors. And there are other oddities–for example, at the time of writing (summer 2024), no leader of India appears in either list.[^3] In sum, different forms of a similar question yield valid but different, incomplete, and imperfect answers. 

Historians tend to be sceptical of taxonomic schemes, with good reason. But explicit taxonomies can do great work for us as a means to discover and explore information. No doubt you will find (what you consider to be) errors in this taxonomy. You can certainly "correct" those errors–Wikidata is open–but don't be too hasty. The taxonomies already existing in Wikidata are organic and collectively produced, and they are not exclusive. There are ways to work around the parts you don't agree with. Don't change the knowledge base itself until you have learned how to do this.

A big part of our expertise as historians is contextualizing details. For many of us, that's the fun and fascinating work. And that skill is precisely what a researcher needs to interact with the galaxy of isolated factoids in Wikidata. The rest of this lesson shows a few of the main ways to do that.

### Vocabulary
- class
- subclass

## Querying Wikidata

As we've already seen, Wikidata cannot be expected to provide definitive or comprehensive answers to any and all questions. It does better with some kinds of questions than others, and historians ought to approach the knowledge base with a spirit of exploration and experimentation. There are no bad questions in Wikidata–only unrealistic questions.

As in most historical domains, the data trail of dead white men is relatively overrepresented. Want a list of colleges and universities attended by these heads of state that we've been comparing with Abdel Nasser? [This query](https://w.wiki/FmqR) summarizes the information that Wikidata contains (don't forget to press play). This list is intriguing--we find that four heads of state attended Cairo University, and the range of institutions is quite global.

Generally speaking, questions about specifics, like dates and locations and labels, yield the best answers from Wikidata. For example, here's a [map of the birthplaces of heads of state from all time periods, color coded by half-century of birth](https://w.wiki/FmqU). Use the layers icon in the top right to select a single half-century layer, and compare the geographic ranges of birthplaces over time. Are the differences due to changes in the role of head of state, or record keeping, or Wikidata's incomplete coverage? This is a fruitful comparative historical question. Let's not forget Wikidata's superb multilingual functionality. Here's a [list of the names of heads of state in Russian and Hebrew transliteration](https://w.wiki/Fmqn). 

Our internet search engine habit of searching via keyword and string, on the other hand, does not play to Wikidata's strengths in aggregate search. Strings work well to find particular items; you can search by label and alias in the simple seach box at the top right of the [Wikidata main page](https://www.wikidata.org/wiki/Wikidata:Main_Page) and every item and property page. (Supplying a comprehensive list of aliases will certainly improve the discoverability and disambiguation of items of interest to you.) But the powerful query service is not designed around string searches.

It takes a while to get the hang of the [Wikidata query service](https://query.wikidata.org/). But playing around with it is one of the easiest paths to learn about Wikidata–and about linked data in general. The best way to query this service is using the SPARQL query language, which is [introduced in another (currently retired) Programming Historian lesson](https://programminghistorian.org/en/lessons/retired/graph-databases-and-SPARQL). SPARQL is incredibly powerful, but it takes some learning. Wikidata's own [SPARQL tutorial](https://www.wikidata.org/wiki/Wikidata:SPARQL_tutorial) is very good, but the following query shortcuts built into Wikidata offer an even more friendly introductory path for new users. 

#### Query shortcut I: Wikidata Query Builder 

Before you even dig into SPARQL, you should know that Wikidata offers a [graphic query builder interface](https://query.wikidata.org/querybuilder/). This can't do all of things that SPARQL can do, but it can set up a basic structure for your queries. 

Let's try it out, using a variant of the head of state college query we tried earlier. (Don't forget that you can switch the interface to your prefered language, using the language selector button at the top right.)

The Query Builder form presents you with two blank fields. It requires you to enter one property and one value in order to perform a query. At this point, you are probably still a bit unclear on what "property" and "value" mean in the context of Wikidata. This is a good chance to learn more through practice.

The people we're trying to find are heads of state. How should we describe them here? Put your cursor in the "property" field, and try typing some terms. "Head of state" doesn't work.

What's going on? What is a property? The definition in the infobox is (to my mind) not much help:

> The *property* field in a condition, is the category or descriptor for the *value*. For example, "color" would be a *property* you'd likely use for the *value* "blue".

Maybe this makes sense to you. To me, what makes sense is to think of the property as the verb that connects subject to object in a three-part subject-verb-object statement. In this case, the statement is "Some person (subject) holds the position of (verb) head of state (object)." Type "position held" into the property box, and "head of state" in the value box. Click "Run Query," and you should see a list of heads of state.

But we are trying to find out something different: which colleges these heads of state attended. So, let's click the "Add Condition" button on the query form. This opens another pair of property/value fields. What property to use? "Educated at" seems about right. What value to use? This step is confusing, because we are trying to find out *where* these heads of state were educated. We could enter a particular school, which would return a list of all heads of state educated there. But there is no way, using this form, to produce a list of the schools themselves, or a count of schools of the sort that we saw above. 

If Wikidata had a property named something like "gave an education to," which took schools as its subject and people as its object, we could use this form to find an answer to our question. (We would put "head of state" in the value field.) There is no such property in Wikidata, however; as a consequence, the query builder will not work for us in this case.[^4]

***Insight***: Wikidata is a relatively flexible database, but its rules and vocabulary are rigid. In order to use it effectively, you cannot go rogue–you have to rely on the properties and values that previous users have used when building out the data. Sometimes the existing vocabulary will be well-tailored to your purposes. More frequently, you will have to find a workaround. Fortunately, SPARQL is flexible enough to pose almost any question you can imagine. Unfortunately, figuring out how to use SPARQL is a fair bit more involved than the simple Query Builder form.

#### Query shortcut II: Example SPARQL queries

Fortunately, Wikidata offers a [long list of example queries](https://www.wikidata.org/wiki/Wikidata:SPARQL_query_service/queries/examples#Most_popular_subjects_of_scientific_articles) that can serve as a guide to SPARQL. All of these queries can be adapted for your own interests, by substituting the item you want for the item the query contains. 

Let's give this a try. Open the [query service](https://query.wikidata.org/), then click on "Examples," then load an example.

{% include figure.html filename="en-or-wikidata-for-historians-05.png" alt="Screenshot of Wikidata Query Service hyperlink for Cats example query" caption="Figure 5: Cats example query." %}

##### Example A: Cats

Let's start with the first example query listed: Cats. When you click on the example, the query form loads with the necessary text.

{% include figure.html filename="en-or-wikidata-for-historians-06.png" alt="Screenshot of Wikidata Query Service SPARQL text of Cats example query" caption="Figure 6: Cats query." %}

Our aim is not to learn about cats--at least not in this lesson. Our aim is to see how we can adapt example queries for our own research purposes. We do this by finding a query that asks the kind of question we want to ask, then substituting our own items of interest into the query.

Six colors of text indicate the syntax of the query:
- **blue** for Wikidata items (Q-numbers) and properties (P-numbers). When you float your cursor over a blue-text item or property, a pop-up gives you its label and description. The prefixes (`wdt:`, `wd:` and so on) are significant but beyond the scope of this lesson.
- **green** for variables, which are the items that you seek (all of which are arbitrary-defined words starting with a ?)
- **grey** for comments (which start with hashtags)
- **red** for SPARQL functions
- **black** for punctuation
- **orange** for strings and other literals

Again, if these technicalities feel confusing, don't be anxious. Keep relying on shortcuts, and when (if) you need to learn more SPARQL, you can fill out your understanding. For now, emphasize practice over theory.

The cats example is the simplest form of SPARQL query: it returns every `?item` that is an "instance of" (`wdt:P31`) a "cat" (`wd:Q146`). By changing the last Q-number, we can search for all instances of something else. For example, try changing `Q146` to `Q3024240`. Float your cursor over this new item to see what it is, then execute the query and skim the results.

***Insight***: the "instance of" property ([P31](https://www.wikidata.org/wiki/Property:P31)) does a huge amount of work in Wikidata and similar data structures. In simple English, line 5 of the query (`?item wdt:P31 wd:Q146`) could be read as "This item is a cat." You will see `P31` everywhere in Wikidata. But almost as often, you will see [P279](https://www.wikidata.org/wiki/Property:P279), the "subclass of" property. Try changing line 5 to `?item wdt:P279 wd:Q146`, which could be read as "This item is a *kind of* cat." The query yields different results. What's the takeaway? These two properties are the most common properties in Wikidata and they matter a great deal, but their function won't be immediately apparent.

##### Example B: Humans by death date

Let's try adapting another example query. A bit further down the list of simple queries examples, just below cats, is ["Humans who died on a specific date on the English Wikipedia, ordered by label."](https://w.wiki/E$kh) Click on this one. It's preloaded with the date August 25, 2001, but you can change the date (in orange) from `"+2001-08-25"` to any other date. Try your birthdate. In the results, the `?sl` column on the right counts the pages that Wikipedia and its sister projects hold on each individual listed.

***Insight***: Orange text in the Wikidata query service contains strings and literals, like dates and languages, that you can modify for your own purposes.

##### Example C: Popular names

Load the example query "[Popular names per birthplace](https://w.wiki/jRm)." It's set for a certain city–see if you can figure out which one (hint: float your cursor over the various Q-numbers). You can set the query to a city of interest to you, by changing city the Q-number you found earlier. If you delete that number (but not the `wd:` prefix) and press `control + space` and begin to type the name of the city you choose, the query interface will autofill the Q-number.

As historians, we will also be interested in popular names of the past. Adding a couple of lines to the query will filter this name list by date. On line 12, before the curly bracket, add these two lines, which use the birth dates of persons named to filter them by a date range:

```sparql
  ?pid wdt:P569 ?date.
  FILTER("1800-01-01"^^xsd:dateTime <= ?date && ?date < "1900-01-01"^^xsd:dateTime)
```

As in the previous example, you can change the orange-colored literals to any dates you want. What if you wanted to filter by death date rather than birth date? You can change this in the same way that you changed the city.

***Insight***: We modified this query by adding a statement using the "date of birth" property ([P569](https://www.wikidata.org/wiki/Property:P569)), then filtering the results by date. Adding lines to a SPARQL query is quite a bit more complicated than swapping one Q-number or P-number for another, however. For the time being, the best shortcut is browsing the examples for a query that is already structured correctly for your needs and substituting the particular items and properties you want. 

## Conclusion

Having completed this lesson and been introduced to Wikidata's basic functions, you are in a position to explore the knowledge base. You may already have produced some results of value to your research or teaching. If not, I hope at least that you've developed a sense that Wikidata could be of value to your work, if you could use it better and/or if it contained more relevant information.

On the first count, the most useful next step is probably to learn how to use SPARQL more effectively. There are many tutorials available for this purpose.

On the second count, you may feel daunted by how much important historical data needs to be added to Wikidata. This will be the subject of another lesson, focusing on how to store your own data and share it with others.

## Resources

- [Wikidata glossary](https://www.wikidata.org/wiki/Wikidata:Glossary)

## Endnotes

[^1]: Take, for example, this line from Blaney's 2017 lesson: "Unfortunately I can’t find anything that describes the relationship between a teacher and a pupil in the Music Ontology. But the ontology is published openly, so I can use it to describe other features of music and then create my own extension." With Wikidata, it is no longer necessary to create such extensions, because its ontology is already quite thoroughly realized. To take Blaney's example, [the item page for Moriz Rosenthal](https://www.wikidata.org/wiki/Q213772) shows that he was a "student of"[P1066](https://www.wikidata.org/wiki/Property:P1066) Franz Liszt, and that Charles Rosen was his "student"[P802](https://www.wikidata.org/wiki/Property:P802).
[^2]: Rosenzweig, Roy. “Can History Be Open Source? Wikipedia and the Future of the Past.” *Journal of American History* 93, no. 1 (June 1, 2006): 117–46. https://doi.org/10.2307/4486062.
[^3]: The reason for this quirk is straightforward: at the time of writing, "Prime Minister of India" ([Q192711](https://www.wikidata.org/wiki/Q192711)) is defined as "instance of"([P31](https://www.wikidata.org/wiki/Property:P31)) rather than "subclass of"([P279](https://www.wikidata.org/wiki/Property:P279)) "head of government"([Q2285706](https://www.wikidata.org/wiki/Q2285706)).
[^4]: Unlike new items, new properties cannot be created at whim. In fact, there are only about 10,000 properties, compared to 110,000,000 items.
