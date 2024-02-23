---
title: "Working with Named Places: How and Why to Build a Gazetteer"
slug: space-place-gazetteers 
layout: lesson 
collection: lessons
date: YYYY-MM-DD
authors:
- Susan Grunewald
- Ruth Mostern
reviewers:
- Forename Surname
- Forename Surname
editors:
- Yann Ryan
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/580
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Lesson Overview

This lesson introduces you to digital gazetteers, which are spatial knowledge organization systems (KOS) about places that record names, spatial footprints, and other characteristics historically associated with a locale. The term gazetteer refers to certain printed historical documents such as geographical indexes, directories, and encyclopdias.[^1] This lesson is focused on their digital equivalents. In brief, a gazetteer is a dictionary or list of place names. 

A well-structured gazetteer reflects the fact that places are conceptual entities, not simply names or points on maps. Any given place may have had multiple names in numerous languages over the course of history, potentially involving conflicts about who has the power to enforce any of those names. The spatial extents, names, and feature types (settlements, buildings, nations, mountains, and so on) of places frequently change over time. 

This lesson teaches you how to leverage the power of digital gazetteers, which are essential resources for spatial history. Unlike maps, gazetteers can readily connect named spatial entities with one another and with modern locations, and they make it easy to annotate any identified place with information about texts, events, people, or other places that have been associated with it. 

### Learning Outcomes

Throughout this lesson, you will learn how to think about the concept of place, why gazetteers are useful for spatial history, how to use historical information to create a gazetteer, and how to enhance and share a gazetteer.

This lesson will demonstrate how to build digital gazetteers, starting with simple spreadsheets before building them into linked open data resources to share with other projects. 'Linked Data' is structured data that can be interlinked with other data to undertake large queries. 'Linked Open Data' is Linked Data that is released under an open license, meaning that it can be reused for other projects. You can find out more about Linked Open Data in [this *Programming Historian* introduction to linked data](https://programminghistorian.org/en/lessons/intro-to-linked-data).

At the end of this lesson, you will be able to:

- Define what a gazetteer is, understand the concept of place, and distinguish gazetteers from other forms of spatial information. 
- Identify scenarios for which creating a gazetteer may be preferable to using a geographic information system.  
- Transform a historical text into a gazetteer.  
- Share a gazetteer with other platforms to enhance it and use it for analytical purposes. 

### Prerequisites

No coding experience is needed to complete this lesson.  You should be comfortable designing and using spreadsheets and you will need access to a spreadsheet platform such as Microsoft Excel, Google Sheets, or LibreOffice Calc.

## Historical Example

This lesson will show you how to create a gazetteer based on the online [Itinerary of Benjamin of Tudela](https://depts.washington.edu/silkroad/texts/tudela.html), an English translation of a Hebrew-language itinerary composed by Benjamin of Tudela (1130-1173), a Jewish traveler who journeyed between the Iberian Peninsula and West Asia in the twelfth century. Benjamin transited through three hundred cities along his route, recording information about geography, ethnography, commerce, Jewish life, and Jewish-Muslim relations.[^2] This text is a major work of medieval geography and Jewish history.

This lesson will teach you to extract place names from written historical texts and use them to build a succinct gazetteer of the places that Benjamin visited. The waypoints along Benjamin’s journey are cities that have synagogues, so the lesson will explain how to build a gazetteer that includes historic place names and other feature types which are essential to the historical record. This fulfills two lesson components: first, demonstrating why and how a scholar might choose to build a basic gazetteer and, second, how a gazetteer can support historical analysis.

## Background: Space, Place, Gazetteers, and Knowledge Organization Systems

### What is a Place?

You might think that a place is simply a geographic location, but it is more helpful to think of a place as a concept. 

The geographer John Agnew postulated that when we say something is a 'place', we are talking about three different ideas. First, any place has a specific *location*. It lies somewhere on the surface of the Earth. Second, the place is a setting for *social relations*. A place is a locale that shapes values, attitudes, or behaviors. A workplace, school, or prison is a locale. Finally, any given place has a unique *sense of place* for those who pass by or stay there, perhaps evoking specific impressions and sensations of belonging or unbelonging. In other words, a place is a location where memorable events have transpired.[^3] 

Cultural geographers like Yi-fu Tuan tend to distinguish the concept of 'place', with its references to unique and distinctive settings for human activity, from that of 'space', which refers to the totality of all possible geographical expanses, many of which may exist regardless of whether they are sites of human meaning.[^4] 

Many theorists of place describe the concept in historical and temporally dynamic terms. The Marxist feminist geographer Doreen Massey defines places as sites of 'meeting up of history in space,' in which people with different relations to authority and security encounter one another.[^5] The anthropologist Tim Ingold emphasizes the fact that 'places do not just have locations but histories,' because they are networks of habitation where peoples' pathways become entangled.[^6] The Black activist geographer Ruth Wilson Gilmore underscores the fact that struggles for social justice are always spatial, and thus they are always about processes of place-making.[^7] 

For these scholars, place can never be distinguished from travel, activity, relations of power, and human interaction. With its focus on human activity, meaning, contestation, and change over time, 'place' (the purview of names, lists, descriptions, and gazetteers) is often a more meaningful concept for spatial historians than 'space' (the domain of maps, which cannot easily represent human interaction and meaning). Place is an essential concept for many types of historical analysis, as well as many types of data curation.

The set of values, institutions, and relationships associated with any given locale are multitudinous, dynamic and unstable. A place may change substantially in all its particulars, even as it persists as a spatial entity. Names for places may coexist, or they may succeed each other according to regime changes or major events. Constantinople (also known historically as Lygos, Byzantium, Nova Roma, Rūmiyyat al-Kubra, and many other aliases) took on the name Istanbul after the Ottoman conquest of the city in the fifteenth century, though both names were used officially until 1928. When Dutch settlers colonized the 'hilly island' at the mouth of the Hudson River, which the Native American Lenape residents called Manahatta, they named their settlement Neuwe Amsterdam – this became New York in 1664 after the English took over the Dutch colony. Informally, people might also refer to the city by the 1807 term Gotham, or the 1921 term Big Apple. If they are speaking or writing in Chinese, they would call it Niuyue (纽约).

Conversely, places may retain stable names even as their spatial footprints change: for instance, when rivers break their banks and take new courses, or when metropolitan areas expand their boundaries. Even though the mappable extent of a river may change over time, the river persists as a fixed conceptual entity in the minds of the people who navigate it, reside near it, or read, write, and talk about it. The Yellow River is still the Yellow River even when it is dry, dammed, or flooded. From the perspective of knowledge modeling in a gazetteer database, the river is a single entity, associated with a large cluster of attestations that are specific to certain events and time periods.

### Gazetteer or Geographic Information System (GIS)?

The first task for anybody embarking on a digital spatial history project is to decide whether to begin with a dataset-based gazetteer, or a map-based geographic information system. 

A project emphasizing the conflicting, contested, and dynamic characteristics of places, as well as spatial information reflected in textual attestations, should begin with a gazetteer. An example of such a project would be the [Heritage Gazetteer of Libya](https://slsgazetteer.org/), which aims to provide information about unique identifiers, locations, and monuments within modern Libya that were important to its history before 1950. The emphasis of this project is on compiling names and variants produced by the research of the Society for Libyan Studies.   

A Geographic Information System (GIS) is only the logical starting point for a spatial history project centered on geography and spatial relations *per se*. Both gazetteers and GIS are based on spatial data structured in particular formats. The focus of GIS is primarily on the projection of geospatial geometries, in the form of points, lines, and polygons. An example GIS project would be the [Bomb Site: Mapping the WW2 bomb census](http://bombsight.org/#17/51.50595/-0.10680) project, which prioritizes the visualization of targets of the Luftwaffe Blitz bombing raids in London from October 7, 1940 to June 6, 1941. While a gazetteer may also contain geographical information, its primary focus is on depicting more information about places then merely points, lines, or polygons on a map base. 

Indeed, although geometry is necessary for making maps, the symbols on maps only tell a small part of the story of a place. The way to model rich, multivocal data about place-making events and contestations of power, about places as settings for social events, and about the sense of place and its representations, is with a gazetteer, not a map. Gazetteers are excellent for collecting information about what a place has been called, by whom, why, and when; who has been there; what has occurred there; who has contended for authority over it; or what texts have referred to it. 

These questions are all of special interest to historians. Not every spatial research project requires a map. In many cases, a gazetteer is actually a more useful way of capturing and analyzing historical spatial information.

In its simplest form, a gazetteer is an index or dictionary of place names. Gazetteers do not need to include geographic coordinates, though many do so to help visualize the spatial data. Gazetteers, thus, are not merely limited to the historical realm: they can be used to trace the movements of a character across a fictional realm, like Frodo's travels from The Shire to Mordor. 

Gazetteers often use a controlled vocabulary to designate the supplementary feature types associated with places: whether a place is a settlement, a waypoint on a travel itinerary, or a geographical feature such as a mountain or river.

A gazetteer, especially a historical one, is a kind of [knowledge organization system](https://en.wikipedia.org/wiki/Knowledge_organization_system) (KOS). A KOS is a tool 'that brings together related concepts and their names in a meaningful way, such that users of the KOS can easily comprehend the relationships represented.'[^8] Historical gazetteers link discourses about a place or places over time. The shape and organization of this type of KOS is determined by the shared characteristics of the places that need to be modeled.

### Considerations

By this point in the lesson, it should be clear that the most important consideration when constructing a gazetteer is to recognize that place is the fundamental entity in any well-designed gazetteer, over and above individual place names, or attestations of the existence of a place at a certain date in a particular source document. 

The author of a historical gazetteer which includes information about New York, the great metropolis situated at the mouth of the Hudson River, would do well to group information about its many names into one complex entity associated with a single ID number: Lenape Manahatta, Dutch Neuwe Amsterdam, British colonial New York, and Washington Irving’s 1807 coinage of Gotham. 

Grouping multiple names and attestations into a single gazetteer record allows for several affordances. First, it turns the gazetteer into a powerful thesaurus. Second, it makes it possible to map as much information as possible onto a single geographical referent. Third, it makes the gazetteer a compelling (and potentially decolonial) work of history which tells a story of sovereignty, colonialism, and culture. Finally, it improves search and discovery, especially in the context of linked open data.

Names and attestations that are grouped into a single entity are easiest to find and use, but the decision to group disparate pieces of information may come at the expense of precision, accuracy and nuance. The author or team working on a gazetteer may therefore choose to articulate certain disambiguation principles to allow better interoperability and reusability of the data. Beyond human judgement, these questions are the domain of entity resolution, which is an open and unresolved topic in information science, natural language processing, and geoscience.[^9]  Spatial historians, as well as information scientists interested in questions of temporality, have also begun to publish on this topic.[^10]

To be sure, it is a matter of your personal and scholarly judgement, and of your research strategy, to decide whether these names do indeed refer to a single place. After all, Manahatta was the name of an island, not an inhabited place, and that island today is the site of only one of the five boroughs of New York City. There is no objective way to decide whether to group these names together as references to a single place. In an ambiguous case like this, whether you group these names together or not is determined primarily by whether it would enhance your research inquiry and visualization tasks to do so. Alternatively, you could keep these names separate, but still define them as 'relations' using a [Linked Places format](https://github.com/LinkedPasts/linked-places-format) or another similar data format. 

### LP and LP-TSV Formats

In this lesson, we're building a gazetteer using the [Linked Places Delimited (LP-TSV)](https://github.com/LinkedPasts/linked-places-format/blob/main/tsv_0.4.md) format to simplify future data interoperability. LP-TSV is a file format derived from the [Linked Places (LP) format](https://whgazetteer.org/tutorials/choosing/), a standard for interconnection used when contributing historical place data to Linked Open Data projects. It permits temporal scoping of entire place records and of individual name variants, geometries, place types, and place relations, expressed either as timespans or as named time periods. 

LP-TSV does also support any number of names, geometries, and relations, as well as information about the sources of such assertions. However, this file format is intended for gazetteer developers whose data is relatively simple: for example, while an LP-TSV row can provide the timespan of an entire record, it does not permit temporal scoping of individual components of the record. 

LP-TSV is widely used for historical gazetteers, and we suggest you adhere to this standard from the onset. Using an established standard like this means that the data you create in this lesson, or that you create for your own research using this lesson, can be shared with other like-minded researchers to create new knowledge. It might seem cumbersome at first, but it will save you lots of time if you do decide to share this project later.

## Building a Gazetteer from a Historical Text

Historians often work with detailed written texts, such as memoirs or travelogues, that may contain a wealth of spatial information. *The Itinerary of Benjamin of Tudela* is one such example of a rich, descriptive historical text that can be dat-mined for spatial research.

Benjamin of Tudela was a twelfth century Spanish Jewish traveler whose text describes his expedition and his interactions with different Jewish communities along the way. A spatial historian interested in this text may want to discover where Benjamin of Tudela traveled on his grand journey, and how he interacted with Jewish communities in the locations he visited. 

A scholar might also use this source as one element in a larger corpus of texts to examine questions about travel in the post-classical period, European exploration, or Eurasian Jewish studies. The places named in this itinerary could be cross-referenced with those named in other accounts from a similar period to see if certain stops were more popular than others, or how different travelers described the same locations.

The structure of Tudela's travelogue suggests the outline for a gazetteer spreadsheet. The authors of this lesson recommend using either Microsoft Excel or Google Sheets for the process of creating a simple gazetteer that is compatible with the LP-TSV format.

To begin, navigate to the section entitled 'The Itinerary of Benjamin of Tudela' on the [web version of this text](https://depts.washington.edu/silkroad/texts/tudela.html#itinerary_1).

### Building Spreadsheet Fields

The first task is to create a spreadsheet and determine the fields that you will populate with data taken from the historical text. Open Excel, or whichever program is your preferred spreadsheet software. 

In a widely cited 2006 book, the geospatial librarian Linda Hill suggested that each entry in a well-structured gazetteer should include at least one name, at least one set of coordinates, and one or more feature types.[^11] For historians, it is especially important to include modern place names if the name has changed, as well as the temporal range of the older name(s) attested in a source. With multilingual sources or projects, it may also be important to note different names or transliterations for a given place: for example, Moscow (EN), Moskau (DE), Moscou (FR), Москва (RU). In keeping with good practices for creating spreadsheets that may need to be shared or exported into other software, you should always include an ID number column. Start by naming the first column **ID**.

From the first paragraph of *The Itinerary*, we understand that we need a column for place names that are travel stops: call the next column **TravelStop**. You can use whatever column headers you want for your own research, but the LP format recommends the use of a 'place type,' so add a column called **PlaceType**. You will also include a column for 'attribute type,' another strongly recommended standardized form of attribute data that makes it easier to share historical spatial project data. Type in **aat_type** in one of the columns. 

Since the research question for this lesson also revolves around Jewish history, you should add a column to mark whether the place has a Jewish population. You should also add a column that includes further information about the description of the Jewish population. Call this column **JewishPop**. 

There are two other columns you should add as well: one that accounts for where you got this spatial information – call this column **Source**. The other, called **AttestedDate** will record when a particular name was used to call the place in question.

For now, your spreadsheet should look something like this table below:

<div class="table-wrapper" markdown="block">
  
| ID | TravelStop | Source | AttestedDate | PlaceType | aat_type | JewishPop |
| --------- | --------- | --------- | --------- | --------- | --------- | --------- |
| |  | | |  | | |
| |  | | |  | | |
| |  | | |  | | |

</div>

### Formatting Considerations for Data Portability and Interoperability

You are formatting your column headers in this way for future data interoperability. If you were to export your data to mapping software like QGIS or ArcGIS, you would need the ID column. Mapping software also does not like long column headers. ArcGIS, for example, can crash if a column header includes spaces or is longer than 15 characters. Try to think of the shortest way to name columns that make sense to you and potential future collaborators. Other important notes for spreadsheets and data interoperability include not using commas anywhere. Many programs that could use the spreadsheet for future analysis require that the spreadsheet be uploaded in .CSV, or comma separated value, format. This means that anytime the software sees a comma, it reads it as the boundary of a cell or row in the spreadsheet. Inserting commas will break the software and make the sheet unreadable. If you need a way to parse information, use a semi-colon. Also avoid most special characters if you can. They can also break the software. If you need to put a space in a column header, use an underscore.

You may wish to make a data dictionary as a separate document to store information about your abbreviations and other data management decisions for your and others’ reference. Including short descriptions of why your specific columns are important make your research a more valuable contribution to linked scholarly projects such as the World Historical Gazetteer. Other researchers will be able to then understand your editorial choices for data management and can better cite and make use of your data in their projects. Adding fuller descriptions in your data dictionary will also make it easier to extend your gazetteer in the future. The ability to continue to expand your project as well as to share it with others is another justification for citing your sources and including the historical information of when they were written. You might only use one source at the moment, such as *The Itinerary*, but in the future you might add other travel accounts to the gazetteer and it is important to be able to parse out who used which name variant and when.

### Adding Historical Data to a Spreadsheet

Now you are going to start filling in your spreadsheet with the information from the first paragraph of Tudela's travelogue. By building this out for the first paragraph, you can see if your model works well or needs to be changed in any way. It’s better to test with a smaller sample of data and tweak earlier rather than later.

**First** you need to fill in the corresponding data the column headers that you have already created. Go through the first paragraph of text and put each name of a stop in the "TravelStop" column.

**Second** you need to use the controlled vocabulary to describe the travel stop locations. In the "PlaceType" column, type "inhabited place," which is a good choice because it is a standardized vocabulary term from the [Getty Art and Architecture Thesaurus](https://www.getty.edu/research/tools/vocabularies/aat/about.html), a structured resource that aims to improve access to information for art, architecture, and material culture. It is also extremely useful for history projects as it is a well-established, controlled vocabulary that is used by a variety of different scholars and projects across a multitude of humanistic and social science disciplines.

**Third** you need to fill in the "aat_type" column with the aat code for [inhabited place, 300008347](https://www.getty.edu/vow/AATFullDisplay?find=300008347&logic=AND&note=&english=N&prev_page=1&subjectid=300008347).

**Fourth** you need to describe the Jewish populations of these travel stops. For simplicity’s sake, and for ease of future data sorting, you will write Y or NA ("not applicable" rather than "no," since we don’t want to propagate false information about whether there was definitively a Jewish population based on this account) under the "JewishPop" column.

**Fifth** you need to describe the source of our data. The "Source" column, record that your information comes from *The Itinerary*. You can abbreviate the name of the source as you wish and maintain the full citation in a separate data dictionary document. For now, you will write, "ItineraryTudela" to make it easy to understand whose itinerary we are referencing. It is essential for digital spatial history projects like this to rigorously maintain the same standards of citation that would be expected from any other work of historical scholarship. Recording this information in the spreadsheet itself rather than in metadata external to it makes it easy to add records from other sources if you expand your research in the future.

**Sixth** as this is a project related to historic naming conventions, you need to then account for time in your "AttestedDate" column. Add to this column information about the year for which you deem the information you are recorded to be correct. Benjamin set out on his journey around 1165. It is not clear exactly when he composed *The Itinerary*, though we know that he died in 1173, and *The Itinerary* does not record the specific dates when Benjamin sojourned in each place he visited. We recommend that you choose an arbitrary date of 1170, with a note in your data dictionary and your metadata indicating that this is an estimate. 

It is sometimes possible to ascribe precise starting and ending dates to specific elements in a gazetteer (such as the dates during which a certain place name was in official usage, or the dates during which a place held a particular administrative status, or during which a river followed a precise course). More often, when historians build gazetteers from specific historical sources, all they know is that the author of that source records the existence of a place at a given time: the existence of the place is attested in a source. Over time, in a linked open data resource like the World Historical Gazetteer, which indexes multiple gazetteers together, it is possible to build up multiple attestations into a history of a place. 

The full Linked Places format makes it possible to add temporal information to every aspect of a complex gazetteer record. Multiple names, locations, and feature types associated with a given record can each include start dates, end dates, and attested dates. For a simple spreadsheet like the one you are making in this exercise, it is cumbersome to include extensive temporal information.

It is always a good idea to include some form of temporal information in a gazetteer, and the LP-TSV format requires that you include at least one date. If you find that you have no relevant temporal information to record, you can use -9999, which is the oldest possible year that many database systems can parse.

**Finally**, put a sequential number for each of the entries in the "ID" column, starting at 1.

If you follow the model we outlined, your spreadsheet should look something like the table below.

<div class="table-wrapper" markdown="block">
  
| ID | TravelStop | Source          | AttestedDate | PlaceType       | aat_type  | JewishPop |
| -- | ---------- | --------------- | ------------ | --------------- | --------- | --------- |
| 1  | Tudela     | ItineraryTudela | 1170         | inhabited place | 300008347 | NA        |
| 2  | Saragossa  | ItineraryTudela | 1170         | inhabited place | 300008347 | NA        |
| 3  | Tortosa    | ItineraryTudela | 1170         | inhabited place | 300008347 | NA        |
| 4  | Tarragona  | ItineraryTudela | 1170         | inhabited place | 300008347 | NA        |
| 5  | Barcelona  | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         |
| 6  | Gerona     | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         |
| 7  | Narbonne   | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         |
| 8  | Beziers    | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         |
| 9  | Har Gaash  | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         |
| 10 | Lunel      | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         |

</div>

You can see quickly that Benjamin has described a wide variety of different types of information related to the Jewish community in three different settlements. An additional benefit of a gazetteer project is that it is highly iterative. An initial research question or two about the source led to its initial structure. Recording simple amounts of initial data can serve to generate follow-up research questions. 

In this case, a researcher might now want to know much more than just which settlements had some sort of Jewish population. There could be questions about the size of the populations in various settlements. In the case of Narbonne, Benjamin gives a figure of 300 Jews. In the cases of Barcelona and Gerona, no population statistics are given, but he describes either a "holy" or "small" congregation, which gives clues to the size of the Jewish population in the community. 

A researcher could then ask questions about which cities had Jewish populations, then which cities had large populations versus small populations. Additionally, researchers could see whether certain cities are centers of Jewish education, and so forth. The gazetteer has already generated a wealth of important information and subsequent questions. A researcher might wish to then create different columns for the different types of information about the Jewish population (i.e., congregation size, educational facilities, number of Rabbis listed, etc.) to make this data easier to filter and analyze later. 

**First**, you need to augment your spreadsheet. You need to add a column called, "DescJewishPop," in which you can record Benjamin's descriptions of the local population. After creating this column, go back and add the relevant data to the existing spreadsheed.

The second paragraph of the travelogue clues us into another important column: name variants. Benjamin mentions a settlement called "Har Gaash," which he notes has an alternative name of "Montpellier." You should record both names as other sources might list one name or the other and this gazetteer can then serve as a means to reconcile these two names around the same physical location.

**Next**, insert a column after "TravelStop" and call it "AltName" to record any additional names given for a place. Put "Montpellier" into the "AltName" column in the row for "Har Gaash."  

Then, continue processing the itinerary through the third paragraph for now. That will provide sufficient information for the remaining steps of this lesson. If you do not wish to continue making the spreadsheet, you can download a final version of the information through the first three paragraphs [here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/space-place-gazetteers/TudelaGazetteer.xlsx).

If you have typed in the information yourself thus far, you spreadsheet should look like the below table.

<div class="table-wrapper" markdown="block">
  
|ID|TravelStop|AltName|Source|AttestedDate|PlaceType|aat_type|JewishPop|DescJewishPop|
|:----|:----|:----|:----|:----|:----|:----|:----|:----|
|1|Tudela| |ItineraryTudela|1170|inhabited place|300008347|NA| |
|2|Saragossa| |ItineraryTudela|1170|inhabited place|300008347|NA| |
|3|Tortosa| |ItineraryTudela|1170|inhabited place|300008347|NA| |
|4|Tarragona| |ItineraryTudela|1170|inhabited place|300008347|NA| |
|5|Barcelona| |ItineraryTudela|1170|inhabited place|300008347|Y|holy congregation; sages; 4 rabbis|
|6|Gerona| |ItineraryTudela|1170|inhabited place|300008347|Y|small congregation|
|7|Narbonne| |ItineraryTudela|1170|inhabited place|300008347|Y|learning center; Torah; sages; 4 rabbis; distinguished scholars; 300 Jews|
|8|Beziers| |ItineraryTudela|1170|inhabited place|300008347|Y|congreation; rabbis|
|9|Har Gaash|Montpellier|ItineraryTudela|1170|inhabited place|300008347|Y|scholars; rabbis; learning centers; Talmud|
|10|Lunel| |ItineraryTudela|1170|inhabited place|300008347|Y|congretation; Israelites; learning centers; law; rabbis; Talmud; Sephardi; 300 Jews|

</div>

You could continue to build this gazetteer out for the rest of the text, and you would probably generate more research questions and data points to analyze. Even with what you have processed so far, you have information about Jewish history in the 12th century that is now connected to space and place. Those who compile data such as this might also want to map the data. This then leads to one of the greatest challenges of historical-spatial research, taking historic names and mapping them with modern software.

Major mapping software providers like Google Maps tend to have major name changes saved in their software, such as Stalingrad/Volgograd or Bombay/Mumbai, but these programs often lack more obscure historic names. With respect to our dataset, Tudela is there because the name has not changed. Google Maps also knows that Saragossa is an alternative spelling for Zaragoza, which is how the name appears on the map. Without Google doing this reconciliation for us, you might not know this to be the same place.

Thus, you need to add new columns into your spreadsheet to make mapping this information easier. You need columns for modern names, and ones for latitude and longitude. 

**First**, create the following columns, "ModName," "Latitude," and "Longitude."

**Second**, you should also add a column for the ISO code for the modern country where this location exists. The International Organization for Standardization (ISO) created a series of two and three letter codes as an internationally recognized standard for referring to countries. It’s generally easiest to use the two letter ISO code. Create a column called, "ISO." You need to use ISO codes for this and many spatial projects because while many of these place names may be unique, Barcelona and Montpellier are not. 

Using the ISO code allows you to specify the correct geographic place when multiple places can share a name. Moreover, as this is a travelogue of a journey from Spain to Jerusalem, you know that our traveler will be traversing the lands of what became numerous modern countries. You may wish to ask research questions about that information and it is better to log the information consistently as you go along. The below table illustrates the progression of the spreadsheet.

<div class="table-wrapper" markdown="block">

| ID | TravelStop | AltName     | ModName     | Latitude | Longitude | ISO | Source          | AttestedDate | PlaceType       | aat_type  | JewishPop | DescJewishPop                                                                       |
|----|------------|-------------|-------------|----------|-----------|-----|-----------------|--------------|-----------------|-----------|-----------|-------------------------------------------------------------------------------------|
| 1  | Tudela     |             | Tudela      |          |           |     | ItineraryTudela | 1170         | inhabited place | 300008347 | NA        |                                                                                     |
| 2  | Saragossa  |             | Zaragoza    |          |           |     | ItineraryTudela | 1170         | inhabited place | 300008347 | NA        |                                                                                     |
| 3  | Tortosa    |             | Tortosa     |          |           |     | ItineraryTudela | 1170         | inhabited place | 300008347 | NA        |                                                                                     |
| 4  | Tarragona  |             | Tarragona   |          |           |     | ItineraryTudela | 1170         | inhabited place | 300008347 | NA        |                                                                                     |
| 5  | Barcelona  |             | Barcelona   |          |           |     | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         | holy congregation; sages; 4 rabbis                                                  |
| 6  | Gerona     |             | Gerona      |          |           |     | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         | small congregation                                                                  |
| 7  | Narbonne   |             | Narbonne    |          |           |     | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         | learning center; Torah; sages; 4 rabbis; distinguished schoars; 300 Jews            |
| 8  | Beziers    |             | Beziers     |          |           |     | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         | congreation; rabbis                                                                 |
| 9  | Har Gaash  | Montpellier | Montpellier |          |           |     | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         | scholars; rabbis; learning centers; Talmud                                          |
| 10 | Lunel      |             | Lunel       |          |           |     | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         | congretation; Israelites; learning centers; law; rabbis; Talmud; Sephardi; 300 Jews |

</div>

Your interest in modern places should not only be limited to the modern countries that your traveler crossed. You might be interested to see if the places named in his journeys are the same names used today. Where do you go to get the information about modern names for the places? There are a multitude of options for this work, but the easiest to use is the [World Historical Gazetteer (WHG) website](https://whgazetteer.org), a project which works to reconcile as many historic place names as possible around the globe with modern ones across a multitude of languages and alphabets. 

**First,** navigate to the website and press the "Explore open access, historical place data" button to be taken to a search window, or [click here to be taken directly to the search interface](https://whgazetteer.org/search/).

With the search interface now activated, let’s start with the first location, Tudela. **Next**, type Tudela into the search box and search for it. The WHG then gives you a few result options. You know that Benjamin of Tudela is a Spanish traveler, so the second option of Tudela in ES for Spain is the one you want. **Next**, click on this record to get a new window to open.

{% include figure.html filename="or-en-space-place-gazetteers-01.JPG" alt="Visual description of figure image" caption="Figure 1. World Historical Gazetteer search results for Tudela" %}

On the new page for Tudela, you can see that there are no other variants. The city is thus still called Tudela. You can also verify this with a Google Maps search. But the WHG will also give you the geometry for the city as well as the country code for the purposes of filling out your spreadsheet. The main WHG search page gives the country code. On the page for Tudela, there is a green dot on the map showing its location. **Next**, click on that green dot, which opens a new popup that gives the latitude and longitude. **Next**, copy and paste the country code and latitude and longitude coordinates into your spreadsheet.

{% include figure.html filename="or-en-space-place-gazetteers-02.JPG" alt="Visual description of figure image" caption="Figure 2. Tudela record in World Historical Gazetteer" %}

If you search the next record, Saragossa, you learn that the modern name is Zaragoza. Again, you can capture the country code and latitude and longitude information from the WHG. If you follow these steps for the rest of the sample cities, your spreadsheet should look as follows.

<div class="table-wrapper" markdown="block">
  
| ID | TravelStop | AltName     | ModName     | Latitude  | Longitude | ISO | Source          | AttestedDate | PlaceType       | aat_type  | JewishPop | DescJewishPop                                                                       |
|----|------------|-------------|-------------|-----------|-----------|-----|-----------------|--------------|-----------------|-----------|-----------|-------------------------------------------------------------------------------------|
| 1  | Tudela     |             | Tudela      | 42.083333 | -1.6      | ES  | ItineraryTudela | 1170         | inhabited place | 300008347 | NA        |                                                                                     |
| 2  | Saragossa  |             | Zaragoza    | 41.633333 | -0.883333 | ES  | ItineraryTudela | 1170         | inhabited place | 300008347 | NA        |                                                                                     |
| 3  | Tortosa    |             | Tortosa     | 40.8      | 0.516667  | ES  | ItineraryTudela | 1170         | inhabited place | 300008347 | NA        |                                                                                     |
| 4  | Tarragona  |             | Tarragona   | 41.116667 | 1.25      | ES  | ItineraryTudela | 1170         | inhabited place | 300008347 | NA        |                                                                                     |
| 5  | Barcelona  |             | Barcelona   | 41.398371 | 2.1741    | ES  | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         | holy congregation; sages; 4 rabbis                                                  |
| 6  | Gerona     |             | Gerona      | 41.982548 | 2.822449  | ES  | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         | small congregation                                                                  |
| 7  | Narbonne   |             | Narbonne    | 43.184417 | 3.008816  | FR  | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         | learning center; Torah; sages; 4 rabbis; distinguished schoars; 300 Jews            |
| 8  | Beziers    |             | Beziers     | 43.345287 | 3.222374  | FR  | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         | congreation; rabbis                                                                 |
| 9  | Har Gaash  | Montpellier | Montpellier | 43.587    | 3.9073    | FR  | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         | scholars; rabbis; learning centers; Talmud                                          |
| 10 | Lunel      |             | Lunel       | 43.675482 | 4.136189  | FR  | ItineraryTudela | 1170         | inhabited place | 300008347 | Y         | congretation; Israelites; learning centers; law; rabbis; Talmud; Sephardi; 300 Jews |

</div>

You can also download the filled-out spreadsheet [here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/space-place-gazetteers/TudelaGazetteerModernNames.xlsx).

Now that you have found the modern equivalents, you can conduct additional research. For example, do these places still exist? Has their identity changed over time? Do Jewish populations in these settlements remain? Have they grown?

## Enhancing Gazetteers with Linked Open Data or Geographic Information System (GIS) Mapping

Simple gazetteers collect basic information about the names, feature types, and locations of places and their attestation in historical texts. They can be further annotated and enriched, as you started to do with the rich descriptive text about the Jewish populations in given settlements, and they can be linked with one another, as you did when you linked historic names with modern names and geometries.

Moreover, you can enhance the gazetteer that you have made about Benjamin of Tudela’s travels with larger collections of linked spatial data to ask new questions and find new answers such as additional content about medieval Jewish history. The best way to put your research into conversation with others and to harness the power of other analytical tools is to use Linked Open Data standards. 

You already used the World Historical Gazetteer to search for historic place names and to find coordinates for your spreadsheet. You could have used the data standards of the WHG to take your earlier spreadsheet and upload it into the WHG to make a map of your places and download an augmented spreadsheet with the geographic data. More information on how to do that can be found in [another *Programming Historian* Tutorial](https://programminghistorian.org/en/lessons/finding-places-world-historical-gazetteer). You can publish datasets through the WHG and reconcile your datasets against Wikidata and against the WHG index. Publishing on the WHG permits you to enhance the WHG datastore, and it also allows you to collect information that the WHG already knows about your target places. WHG place records are concatenations that link attestations about places from multiple gazetteers. The linking of attestations is a good way to manage the fact that no single gazetteer can contain all relevant information about a given place. 

You can also annotate places indexed in the WHG to create Collections, which you can read more about [on the WHG website](https://whgazetteer.org/tutorials/collections/). Creating collections allows you to record complex information about places, to link places to one another based on a theme of your choosing, and to drive traffic from the WHG to any website you identify.

Once you have geographic information (e.g. latitude and longitude coordinates), you can also make a variety of maps with desktop or web-based geographic information system (GIS) software. This type of software allows us to visualize spatial information in the form of making maps. Using the data you created for this tutorial, for example, you can produce a map that shows the all or a subset of places through which Benjamin of Tudela traveled. QGIS is open-source desktop software for making GIS maps, and you can get started with it using [this *Programming Historian* tutorial](https://programminghistorian.org/en/lessons/qgis-layers). 

## Conclusion

Recent scholarship has emphasized that the field of spatial history is not synonymous with the domain of historical GIS.[^12] Indeed, the intellectual history of spatial representation reflects the fact that maps have not often been widely used tools for recording information about the geographical settings for human activity.[^13] Today, when we use navigation apps to find directions to destinations, we are interacting with gazetteers, not reading maps. Despite these insights, education for spatial history tends to focus almost exclusively on GIS training. 

One purpose of this lesson has been to demonstrate why GIS may not be the best starting point for many spatial history projects, and to explain why you may want to begin with a gazetteer instead. In that spirit, we conclude with a checklist that may assist in determining the strategy that will work best for your project and your research objectives. 

- Does your project include a corpus of places that have names, feature types, and locations? In that case, you are well on your way toward building a gazetteer. 
- Do you want to track complex non-spatial information about places, such as multiple names, events that have occurred at them, attributes associated with them, texts that refer to them, or rich narrative information about them? If so, a gazetteer is preferable to a GIS.
- Is temporal resolution important to your project? In a GIS, temporal information can be effectively represented only with time stamped layers. In turn, that may force you to combine temporal references that you would prefer to keep disaggregated or to redundantly record information in multiple attribute tables. A gazetteer may be preferable in such cases.
- Do you intend to publish place information in a linked data domain that permits you to combine it with other people’s contributions? If so, you should create a gazetteer.
- Does your project involve geospatially complex information and complex spatial analysis (such as geostatistical analysis, spatial autocorrelation, or spatial clustering)? If so, you need to use GIS.
- Conversely, is the geospatial character of your data simple, or is spatial precision unimportant for your project? If you are working with point locations rather than polylines or polygons, a gazetteer may be adequate.

Finally, remember that gazetteers and GIS systems can be readily transformed into one another once you understand the principles of place and gazetteer design that we have presented here. Named place information incorporated into GIS data can be exported and used as the basis for a more temporally and toponymically complex gazetteer; and equally, a gazetteer that includes geospatial coordinates can be imported into a GIS to facilitate spatial visualization and spatial analysis.

## Related *Programming Historian* Lessons for Future Study

In addition to the related *Programming Historian* tutorials listed above in this tutorial, readers might find some additional tutorials of use. Once you have a gazetteer, you can also use it for text analysis projects. You can run your list of names through a corpus or corpora to automatically find attestations of those same locations in other sources. An example of this would be to compare the locations named in Benjamin of Tudela’s travels with other contemporary travelogues to see which locations were seen as important for medieval travels. 

These two Programming Historian articles will run you through [using gazetteers for text analysis to extract keywords](https://programminghistorian.org/en/lessons/extracting-keywords) as well as [using gazetteers for text analysis and then mapping with the WHG](https://programminghistorian.org/en/lessons/finding-places-world-historical-gazetteer). Readers might also find the steps in the [Geoparsing English-Language Text article](https://programminghistorian.org/en/lessons/geoparsing-text-with-edinburgh) useful if they merely need a list of names listed in a text without additional attribute data.

In addition to using either QGIS or the WHG to map the data produced in this lesson, readers might also be interested in learning how [R can be used for geospatial data and historical research](https://programminghistorian.org/en/lessons/geospatial-data-analysis).

## Endnotes
[^1]: Ruth Mostern and Humphrey Southall, "Gazetteers Past," Merrick Lex Berman, Ruth Mostern, and Humphrey Southall, eds., *Placing Names: Enriching and Integrating Gazetteers* (Bloomington: Indiana University Press, 2016), 15-25.
[^2]: The standard English translation, which is the one used for the link we have included in this lesson is Marcus Nathan Adler, The Itinerary of Benjamin of Tudela: Critical Text, Translation and Commentary (New York: Phillip Feldheim, Inc., 1907). [A scholarly trilingual (English, Hebrew, Arabic) version of the Itinerary](https://teipublisher.info/exist/apps/TraveLab/Benjamin%20of%20Tudela.xml)) was recently published. The English text on that site is the Adler version.
[^3]: John Agnew, "Space and Place," in John A. Agnew and David N. Livingstone (eds.) *Sage Handbook of Geographical Knowledge* (London: Sage Publications, 2011).
[^4]: Yi-fu Tuan, *Space and Place: The Perspective of Experience* (Minneapolis: University of Minnesota Press, Reprint Edition, 2001).
[^5]: Doreen Massey, *For Space* (London: Sage Publications, 2005).
[^6]: Tim Ingold, *Lines: A Brief History* (Routledge, 2016), 105-6.
[^7]: Ruth Wilson Gilmore, "Fatal Couplings of Power and Difference: Notes on Racism and Geography" in Ruth Wilson Gilmore, Brenna Bhanda and Alberto Toscano, *Abolition Geography* (Verso, 2022).
[^8]: Ryan Shaw, "Gazetteers Enriched: A Conceptual Basis for Linking Gazetteers with Other Kinds of Information," in *Placing Names: Enriching an Integrating Gazetteers*, ed. Merrick Lex Berman, Ruth Mostern, and Humphrey Southall (Bloomington: Indiana University Press, 2016), 52.
[^9]: Pasquale Balsebre, Gao Cong, Dezhong Yao, Zhen Hai, "Geospatial Entity Resolution," *Proceeedings of the ACM Web Conference 2022* (2022), 3061-71 [https://doi.org/10.1145/3485447.3512026](https://doi.org/10.1145/3485447.3512026)
[^10]: For example J. T. Hastings, "Automated Conflation of Digital Gazetteer Data," *International Journal of Geographical Information Science* 22.10 (2008), 1109-1127; Vincent Ducatteeuw, "Developing an Urban Gazetteer," *GeoHumanities '21: Proceedings of the 5th ACM SIGSPATIAL International Workshop on Geospatial Humanities* (November 2021), 36-39; and Pawel Garbacz, Bogumil Szady, and Agnieszka Lawrynosicz, "Identity of Historical Localities in Information Systems," *Applied Ontology* 16 (2021), 55-86.
[^11]: Linda Hill, *Georeferencing: The Geographic Associations of Information* (MIT Press, 2006).
[^12]: For example Ian Gregory and Alistair Geddes, *Toward Spatial Humanities: Historical GIS and Spatial History* (Bloomington: Indiana University Press, 2014).
[^13]: Michael Curry, "Toward a Geography of a World Without Maps: Lessons from Ptolemy and Postal Codes," Annals of the Association of American Geographers 95.3 (2005), 680-691. [https://doi.org/10.1111/j.1467-8306.2005.00481.x](https://doi.org/10.1111/j.1467-8306.2005.00481.x)
