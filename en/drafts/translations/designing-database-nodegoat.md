---
title: "From Sources to Data: Designing a Database for the Humanities and Social Sciences with nodegoat"
slug: designing-database-nodegoat
original: concevoir-base-donnees-nodegoat
layout: lesson
collection: lessons
date: 2024-02-29
translation_date: YYYY-MM-DD
authors:
- Agustín Cosovschi
reviewers:
- Octave Julien
- Solenn Huitric
editors:
- Sofia Papastamkou
translator:
- Silvia Stoyanova
translation-editor:
- Laura Alice Chapot
translation-reviewer:
- Felix Vanden Borre
- Maneesha Sane
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/658
difficulty: 1
activity: transforming
topics: [data-manipulation]
abstract: This lesson allows to gain practical familiarity with the nodegoat software in order to build a relational database within a humanities research framework.
avatar_alt: Skeleton of an Angora goat, drawing by Bouvée, 1755, Gallica
doi: XX.XXXXX/phen0000
---

{% include toc.html %}
                                  

## Introduction: thinking in terms of data – a conceptual challenge
When taking their first steps in the world of digital humanities, humanities researchers may confront a number of challenges. Often these are technical in nature: using digital tools is not always straightforward and gaining proficiency in a method, a piece of software, or a programming language often requires extensive and sometimes painstaking practice. There is also, however, a challenge of a different kind that is just as complex as the technical ones: learning how to conceptualize your research in terms of 'data'.
 
But what do we mean when we talk about 'data'? Generally speaking, we can define [data](https://en.wikipedia.org/wiki/Data_%28computer_science%29) as information that is structured into discrete units and lends itself well to automated processing. This way of structuring information ensures that when the same operations are applied, they consistently yield the same results. 

Transforming a research object into data involves some translation work: we must translate our information from its original form to a structured format. Data, in contrast to what its etymology might lead us to believe, is not a 'given' at all: it is not simply there, waiting to be collected – on the contrary, it is the product of interpretation and transformation. In order to transform their sources into data, researchers must read their sources with a defined set of research questions in mind, extract the relevant information, and record it in a structured format.[^1]

Those who do research in the humanities often encounter difficulties at this stage, because the very notion of 'data' does not clearly align with disciplinary practices in these fields. In history, anthropology, or literary studies, we think of the phenomena we study in flexible, open-ended, and uncertain terms. We are accustomed to reflecting on the researcher’s subjectivity and placing contingency at the center of our analyses. We analyze political, social, and cultural phenomena as complex objects that are difficult to reduce to a 'dataset'. As Miriam Posner writes [in a blog post](https://perma.cc/BBC5-MBEC) on this subject:

> [We], humanists have a very different way of engaging with evidence than most scientists or even social scientists. And we have different ways of knowing things than people in other fields. We can know something to be true without being able to point to a dataset, as it's traditionally understood.[^2]

Thus, researchers in the humanities may find it counterintuitive to read their sources, documents, or ethnographic notes with the goal of extracting information and arranging it into the fixed, discrete, structured categories of a spreadsheet. This process may even appear too simplistic and reductive: how can a political tradition, the affective dimension of a local cultural practice, the conceptual issues of modern philosophy, or the psychology of a literary character be translated into 'data'?

However, thinking about our research in terms of data does not necessarily need to lead to a simplification or flattening of the object of study, as demonstrated by the [new wave of projects in quantitative history](https://www.tandfonline.com/toc/vhim20/current) which appears to be making a strong comeback. This research shows that it is possible to adopt a data-driven methodological approach while allowing for complexity and subjectivity. As Johanna Drucker, a scholar of graphic design, reminds us, data cannot be separated from the act of collection that produced it; rather, interpretation is always involved in the effort to capture, select, and carve this data from reality. In other words, “all data is capta” (not given, but taken).[^3]

For his part, the historian Manfred Thaller emphasizes that data can represent reality, but only when it arises from an act of interpretation. He proposes a hierarchical schema that distinguishes between 'data', 'information' and 'knowledge'. Data consists of symbols that can be arranged in a system of representation. This system produces information when the data is interpreted within a defined context. Knowledge, in turn, emerges from information that leads to decision-making or action.[^4]

Recognizing both the complexity and the structured nature of data allows us to see the advantages of conceptualizing our research in terms of data.

First, transforming our sources into data allows for automated digital processing and quantitative analysis. This is particularly useful when our research involves large volumes of information or when we can derive datasets directly from our sources (for example, inventories, demographic data, etc.).

In addition, the very process of translating our sources into data requires us to clearly and precisely define the elements of our investigation, including our hypotheses and research questions. This brings a conceptual advantage in the sense that it compels us to formalize the objects of our research, the relationships between them, as well as the nature and consequences of their interactions.

Finally, structuring information in a database allows us to easily share it with the broader scholarly community.

In this lesson, we will discuss the challenges that newcomers to digital research are likely to encounter when designing a database for use in humanities scholarship. We will therefore:

- [Introduce key concepts and technical tools needed to design a data model](#from-data-entry-to-data-modeling)
- [Walk through the first steps in building a database using the online platform *nodegoat*](#building-a-database-with-nodegoat) 
 
In doing so, we hope to demonstrate the advantages of a research method whose logic may not be immediately evident to researchers trained in the humanities.

## From data entry to data modeling

As mentioned earlier, the further we examine our sources, the more our research can generate substantial amounts of information. In such cases, it is often preferable to catalog this information in an organized and structured manner. For example, let’s imagine that we are conducting historical research on a set of books: a hypothetical project about the works produced by dissident writers from the communist regimes of Eastern Europe.

### Simple tabular data entry

We could record information about these books in a simple format using the features of a [spreadsheet](https://en.wikipedia.org/wiki/Spreadsheet), such as this one:

**Basic Table**

<div class="table-wrapper" markdown="block"> 

| Title | Place of Publication | Author |
| :------ | :-------------------- | :---------|
| The Gulag Archipelago | Paris | Aleksandr Solzhenitsyn |
| Life and Fate | Geneva | Vasily Grossman |
| The New Class | New York | Milovan Djilas |
| The Captive Mind | Paris | Czesław Miłosz |
| Cogs in the Wheel | Paris | Michel Heller |
| The Intellectuals on the Road to Class Power| Brighton | George Konrad, Iván Szelényi |

</div>

This three-column table is an initial data entry which allows us to visualize our information very simply. We are already starting to build, in a rather elementary way, what could become a [dataset](https://en.wikipedia.org/wiki/Data_set). Each row in the table represents an 'instance', or a 'record', and each column represents a 'characteristic', or an 'attribute', of these instances. Here, these characteristics are the title, the place of publication, and the author of each work.

For now, this tool is sufficient because we are using it to store just a small amount of information. But imagine that, as we delve deeper into our inquiry, we begin to examine the works and their authors in more detail, thereby increasing the amount of recorded information. We could then expand the table, for example, as follows:

**Expanded Table**

<div class="table-wrapper" markdown="block">
 
| Title | Place of publication | Language of the first edition | Date of publication | Publishing house | Founding date of the publishing house | Author | Nationality of the author | Place of birth of the author | Date of birth of the author |
| :------ | :------------- | :--------- | :------ | :-------------------- |:--------- |:---------| :---------| :---------| :---------|
| The Gulag Archipelago | Paris | French | 1973 | Le Seuil  | 1930 | Aleksandr Solzhenitsyn | Russian | Kislovodsk | 1918 |
| Life and Fate | Geneva | French | 1980 | L’âge d’homme | 1955 |Vasily Grossman | Russian | Berdychiv | 1905 |
| The New Class | New York | English | 1957 | Praeger | 1950 | Milovan Djilas | Montenegrin | Podbišće | 1911 |
| The Captive Mind | Paris | English | 1953 | Instytut Literacki | 1946 | Czesław Miłosz | Polish | Šeteniai | 1911 |
| Cogs in the Wheel | Paris | French | 1985 | Calmann-Lévy | 1920 | Michel Heller | Russian | Mogilev | 1922 |
| The Intellectuals on the Road to Class Power| Brighton | English | 1979 | Harvester Press | ? |George Konrad, Iván Szelényi | Hungarian, Hungarian | Berettyóújfalu, Budapest | 1933, 1938 |

</div> 

Thanks to this new table, we can now cross-reference more information and go into more depth in our analysis by querying the relationships between various attributes of the works, the publishing houses, and the authors. We could, for example, formulate and test a hypothesis about whether Russian authors tend to publish more frequently in French, or ask whether certain publishing houses show a preference for authors of a given age or nationality.

However, the more records we analyze and the more questions we ask, the more the information accumulates, which makes this table increasingly difficult to use. In some cases, the information itself is complex. For example, the book *The Intellectuals on the Road to Class Power* has more than one author. Its publishing house, Harvester Press, has no known founding date (since information about this small English publisher is rather limited). This is a classic example of the uncertainty that often characterizes research in the humanities. As a result, it becomes increasingly difficult to read, cross-reference, and interpret all of this information.

When this happens, it is often more useful to start thinking about the 'relationships' that connect the different objects of our research and to build a table that represents them – [a data table](https://en.wikipedia.org/wiki/Table_%28database%29) – before gathering them into a [database](https://en.wikipedia.org/wiki/Database).

### From spreadsheet to database: the principles of modeling

What is a 'database'? Generally speaking, it functions as a container that organizes information according to a certain structure. More specifically, as Georges Gardarin writes, a database is “a dataset modeling the objects of a part of the real world and serving as a support for a computer application”.[^5]  The data in a database must be 'searchable': we must be able to find all the data that satisfies a certain criterion (such as, in our case, all the authors of Russian nationality, or all the works published in French). It is this searchability that makes the database a powerful tool for exploring and analyzing information.

In this lesson, we will focus on a specific and fairly common type of database: [the relational database](https://en.wikipedia.org/wiki/Relational_database). A relational database (referred to hereafter simply as 'database') is structured as a set of tables linked in such a way that information can circulate between them. These tables within the database typically contain two key types of elements: objects and the relationships between them. Each object represents a complex reality defined by many characteristics (the 'attributes' in the columns) that are expressed in specific instances (the 'records' in the rows). Before we can build this database, we must first define the objects, the attributes they contain, and the way in which they are connected to one another. This process is known as creating a [data model](https://en.wikipedia.org/wiki/Relational_model).

In our example, we have identified three objects of interest: works, publishing houses, and authors. How are they connected? The answer will depend mainly on our research questions. In the example proposed here, if our focus is on the book as an object of circulation, we can imagine a basic graph linking the work, the author, and the publishing house in this way:

{% include figure.html filename="en-tr-designing-database-nodegoat-01.jpg" alt="A logic diagram consisting of three circles which represent the work, the publishing house, and the author. Two arrows come out from the work: one points towards the publishing house and the other towards the author" caption="Figure 1. A logic diagram representing the relationships between works, publishing houses, and authors." %}

This diagram corresponds more or less to a 'conceptual data model'[^5]  representing the entities that interest us and the relationships that connect them. Here, each work is linked to a specific author who wrote it and to a specific publishing house that published it.

At this point, we should ask ourselves the following questions we've already touched upon:
- What information does each object contain?
- What elements is each object composed of?
- How exactly are these objects connected to one another?

Our answers will depend on the respective attributes of each object. Based on the table we created above to catalog information for our hypothetical research question, we can define our objects through the following attributes and relationships:

{% include figure.html filename="en-tr-designing-database-nodegoat-02.jpg" alt="Data model diagram showing three objects, Author, Work, and Publishing House with their attributes listed below. Attributes of the Author object include first name, last name, and nationality. Attributes of the Work object are given as title, language of the first edition, date of publication, publishing house, and author. Attribution of the Publishing House object are given as name, place and founding date. Arrows and rings are drawn to connect relations between the objects through the attributes. The attribute 'author' within the Work object is connected to the Author object, and the attribute 'publishing house' within the Work object is connected to the Publishing House object." caption="Figure 2. Data model showing objects, their attributes, and their relationships." %} 

This now corresponds to what is generally called a 'logical data model' which allows us to more clearly define our objects and their relationships and, thus, to implement the conceptual model. Based on this diagram, we can create tables to record the characteristics of each object separately:

**Table 1: Works**

| Title | Language of the first edition | Date of publication | Publishing house | Author | 
| :------ | :--------- | :------ | :-------------------- | :---------|
| The Gulag Archipelago | French | 1973 | Le Seuil  | Aleksandr Solzhenitsyn | 
| Life and Fate | French | 1980 | L’âge d’homme | Vasily Grossman | 
| The New Class | English | 1957 | Praeger | Milovan Djilas | 
| The Captive Mind | English | 1953 | Instytut Literacki | Czesław Miłosz | 
| Cogs in the Wheel | French | 1985 | Calmann-Lévy | Michel Heller | 
| The Intellectuals on the Road to Class Power| English | 1979 | Harvester Press |George Konrad, Iván Szelényi |


**Table 2: Authors**

| First name | Last name | Nationality | Place of birth | Date of birth |  
| :------ | :------ | :---------------- | :-------------------- | :--------------------- | 
| Aleksandr | Solzhenitsyn | Russian | Kislovodsk | 1918 |
| Vasily | Grossman | Russian | Berdychiv | 1905 |
| Milovan | Djilas | Montenegrin | Podbišće |  1911 |
| Czesław | Miłosz | Polish | Šeteniai | 1911 |
| Michel | Heller | Russian | Mogilev | 1922 |
| George | Konrad | Hungarian| Berettyóújfalu | 1933 |
| Iván | Szelényi | Hungarian | Budapest | 1938 |

**Table 3: Publishing houses**

| Name | Place | Founding date | 
| :-------------------- | :------ | :-------------------- | 
| Le Seuil | Paris | 1930 | 
| L’âge d’homme | Geneva | 1955 |
| Praeger | New York | 1950 |
| Instytut Literacki | Paris | 1946 | 
| Calmann-Lévy | Paris | 1920 | 
| Harvester Press | Brighton | ? |

We have now organized this information into three tables that represent our dataset. In order to be able to navigate between these tables and follow the relationships established in the data model diagram, we would need to connect them. To do so, we need to define both the possibilities and constraints of these relationships – we call this definition [cardinality](https://en.wikipedia.org/wiki/Cardinality_%28data_modeling%29).[^6]   

When building a relational database, we must carefully consider the types of relationships that can exist between tables: is each element in one table linked exclusively to a single element in another table, or does it have multiple and intersecting relationships (that is, can it be connected to multiple entries across tables)? Thus, in our example of the relationships between authors and works, does each work have only one author (cardinality 1,1)? Or can it have two or more, as is the case with *The Intellectuals on the Road to Class Power* (cardinality 1,N)? Conversely, could each author of a work written by multiple authors also be the author of multiple other works (cardinality N,N)? These are the kinds of questions that inevitably arise during the process of building a database.[^7]  The answers will depend on our specific dataset. In the next section, we will see how to put all of this into practice.

## Building a database with nodegoat

Relational databases can be built using specialized software known as [database management systems](https://en.wikipedia.org/wiki/Database#Database_management_system) (DBMS), which allow users to query and manipulate data according to the principles of the [SQL](https://en.wikipedia.org/wiki/SQL) query language. There are many DBMS available, both open-source (e.g., Amazon Aurora DSQL, PostgreSQL, MariaDB) and proprietary (e.g., Microsoft Access, Oracle Database). However, DBMS software can quickly become difficult to use. That is why we will make use of [nodegoat](https://nodegoat.net/): an online platform which is specifically designed to support humanities researchers in building and working with relational databases. As we will see, nodegoat allows us to design a data model in a flexible way, to manage and store data online, to incorporate historical information with some degree of uncertainty, to export and import this data in a simple way and, lastly, to produce visualizations, such as maps or networks.[^7] 

### Getting started with nodegoat

nodegoat, created and maintained by LAB1100, is an online platform that enables users to model, build, and share their databases in a relatively intuitive way. This lesson was designed using version 7.3 of nodegoat, but it is confirmed to work just as well with version 8.2 which was current at the time of its original publication.[^8] A basic knowledge of English is required to use nodegoat. Before getting started, you will need to [request an account](https://nodegoat.net/requestaccount) to use nodegoat online by filling out a simple form with your name, email address, institutional affiliation, and a brief description of your project. Note that the account registration may take up to 48 hours before it is ready to use.

nodegoat is an open-source, free to use online platform and can also be [installed locally](https://perma.cc/5PLH-YJQG), although this requires advanced computer skills. In both cases (whether using the online version or a local installation), access to more advanced features, particularly for working on multiple projects or collaboratively, requires one of the paid subscription options offered by the organization that developed the platform. 

The instructions that follow are intended to guide readers through the workflow of creating a database with nodegoat according to the principles introduced in the first part of this lesson. The software's design closely reflects the approach described above for modeling research: it treats people, groups, and things as objects connected by various types of relationships.[^9]  nodegoat also offers tools for relational analysis and for creating visualizations, such as maps or networks. Most importantly, the platform accommodates uncertain or ambiguous data, which is common in humanities research. For example, it may suggest using a time interval if exact dates are not available, or drawing a polygon when exact geographic coordinates are not known.

To be clear, the goal of this lesson is not to promote the exclusive use of nodegoat - you can certainly use other database management software tools and tutorials specifically designed for research in the humanities and social sciences, such as the introduction to [Heurist](/fr/lecons/introduction-a-heurist) by Vincent Paillusson (in French) or by [Ian Johnson](https://bibliographie.uni-tuebingen.de/xmlui/bitstream/handle/10900/60640/CD38_Johnson_CAA2008.pdf?sequence=2) (in English), or the [introduction to MySQL](https://programminghistorian.org/en/lessons/getting-started-with-mysql-using-r) by Jeff Blackadar, or to [NocoDB](https://zenodo.org/records/16318582) by Robert Zwick and Julia Tolksdorf. However, by combining all of these functionalities in a single environment, nodegoat significantly simplifies the process of modeling your research as data. Its main advantage for us, in this lesson, is that it makes it especially easy to define and implement the model we described in abstract terms above.

### Setting up your project in nodegoat 

When you log in to nodegoat for the first time, you are shown your **Domain** (workspace) which is empty to start with and where you can see three tabs: **Data**, **Management** and **Model**. In **Model**, we will build our data model following the rationale outlined in the previous section. In **Management**, we will define the parameters for implementing this model. Finally, in **Data**, we will categorize our data according to the structure defined by the model, and we will examine it.

{% include figure.html filename="en-tr-designing-database-nodegoat-03.jpg" alt="Empty background with the three tabs of the workspace" caption="Figure 3. The empty nodegoat workspace before creating our project." %} 

#### Defining the objects of the database 

First, we will create our project, then we will define the data model and build the database. We will create the project from the **Management** tab by clicking on *Add Project* and typing its title, _Works from the East_, in the text box next to **Project Name**.

We will then go back to the top level and click on the **Model** tab to define our data model. To start, we will add an object type by clicking on the *Add Object Type* tab. In our conceptual model, we have already defined our three object types: the work, the author, and the publishing house.

{% include figure.html filename="en-tr-designing-database-nodegoat-04.jpg" alt="The Model panel and the option Add Object Type which allows us to begin defining our data model" caption="Figure 4. The Model tab and the Add Object Type option which allows us to define our data model." %} 

Under **Name**, we can enter the name of the first object type in our dataset (i.e. _Work_) and under **Descriptions** we can define its attributes. The attributes of the **Work** object type are the title, the language of the first edition, and the date of publication.  To add an attribute, click on the green _add_ button. We must specify the type of value that each attribute takes: **String** (character string) for text values, such as the title of the work; **Date** for a specific format, like the date of publication, or [other](https://perma.cc/K42P-7YB7) kinds of values depending on the nature of the dataset. 

We should be careful here: since we include the title of the work as an attribute in **Descriptions**, we must uncheck the **Fixed Field** option (which defines the object type according to the value given in **Name**), and instead check the **Name** box under our first attribute, i.e., the **Title**. The objects belonging to the **Work** type in the database will thus take the value given to the **Title** attribute. Once we are finished adding descriptions, we will click on the _Save Object Type_ button below them, and the **Work** object type will appear at the bottom of the workspace that is activated by the **Model** tab. 
 
{% include figure.html filename="en-tr-designing-database-nodegoat-05.jpg" alt="The object type Work and its three attributes (title, language, date of publication)" caption="Figure 5. Definition of the first object type by selecting ‘Add Object Type’." %} 

We can now create, following the same procedure, the other two object types of our model, namely the Author and the Publishing House. Under **Name**, we define the name of the object type (i.e. **Author**, then **Publishing house**) and under **Descriptions**, its attributes. As with the first object type, we will uncheck the **Fixed Field** option and instead check the **Name** box under the attribute which will serve as the object's display name. For the **Author**, we can select the attributes **First Name** and **Last Name**, which are separate attributes in our example. In doing so, each author's name will appear as a combination of these two values in the database overview.

For the **Work**, on the other hand, we only define the **Title** attribute as the object's **Name**. If we want to avoid having the database display the title of a work twice (once as the object's name and again as the **Title** attribute), we can uncheck the **Overviews** option (located next to **Fixed Field**). This ensures that the database only displays the values selected under **Name** (in this example, the **Title**). For the **Publishing house**, we will add the values of our conceptual model: _name_, _city_, and _founding date_. 

{% include figure.html filename="en-tr-designing-database-nodegoat-06.jpg" alt="The attributes First name and Last name of an Author are selected by checking their Name boxes." caption="Figure 6. Choosing the attributes _First name_ and _Last name_ as the values of the object name **Author**." %} 

{% include figure.html filename="en-tr-designing-database-nodegoat-07.jpg" alt="The Overviews option is left unchecked" caption="Figure 7. The **Overviews** option is left unchecked." %} 

We will now select which object types we want to use in this project. This is an important step, because it is entirely possible to enter multiple object types into a database, but without using all of them or without exploring them in the same way, depending on the specific objectives of the project. Thus, we will then navigate to the **Management** tab and click on the _Edit_ option which appears on the right side of the project name.

{% include figure.html filename="en-tr-designing-database-nodegoat-08.jpg" alt="The Management panel, with the objects we created" caption="Figure 8. The **Management** panel allows to organize the project and choose which objects will be used." %} 

In addition to the objects we defined, nodegoat offers two types of pre-set objects, 'nodegoat City' and 'nodegoat Geometry', which appear below the three object types we created as options that we can select by clicking on the checkbox. **Geometry** is useful for representing regions, countries, or other political units of the past or the present. The geospatial data of these two types of objects (perimeter, geographic coordinates, etc.) comes from external geographic databases, such as [GeoNames](https://perma.cc/9SVS-8MGJ), which are linked to nodegoat. These are two very useful and readily available types of objects that each user can implement in their research and, in turn, enrich them further. In our project, we will include the **City** object type which contains useful information about cities. In doing so, the software helps us enhance our data model by adding a fourth object type to our initial three, along with a number of attributes that we might not have included otherwise (such as, the country to which a city belongs). After checking the box to select **nodegoat City**, click on the *Save Project* button at the bottom of the workspace. 

#### Configuring the database

There is still one fundamental step left to complete: to establish the relationships between our objects. Thus far, we have only provided information attached to a single object type at a time. However, the fundamental feature that this relational database offers is actually being able to link objects together. If we recall, we started building our model by creating object types which we then activated in the **Management** panel. Now, we need to go back to the **Model** tab in order to connect each object type to the others. These will be the attributes of our objects which, as specified by our data model, will function as 'connectors'.

Let’s start with the **Work** object type. With the *Edit* button we can access the **Object Types** tab and the object attributes (**Descriptions**). We are interested in two object types in particular: **Author** and **Publishing house**. The **Author** attribute will link the **Work** object type to the **Author** object type; the **Publishing house** attribute will link the **Work** object type to the **Publishing house** object type. To establish these connections, we will add these two object types as attributes and will select the value **Reference: Object Type** from the drop-down menu to the right of each attribute that represents an object type (i.e. **Author** and **Publishing house**). As soon as we do this, a new drop-down menu will appear listing all of the object types in our model. We will then select **Author** and **Publishing house** respectively. The **Work** object type, as defined in our conceptual model, is now linked to the **Author** and **Publishing house** object types through its **Author** and **Publishing house** attributes. The two types of objects, **Author** and **Publishing house**, therefore, become sources of information that can be integrated into the **Work** object type. We have thus rendered explicit the links that we defined in our conceptual model.

{% include figure.html filename="en-tr-designing-database-nodegoat-09.jpg" alt="Example of the Author attribute with the option 'Reference: Object Type' in the drop-down menu, with the box for multiple authors selected, and a separator added as a semi-colon" caption="Figure 9. Connecting the objects through the attributes **Author** and **Publishing house** by selecting the value ‘Reference: Object Type’ from the first drop-down menu." %}

In addition, we need to check the box **Multiple** under the **Author** attribute, in order to indicate that some works can have more than one author, as is the case of *The Intellectuals on the Road to Class Power*. We also need to select the symbol that nodegoat will use to separate multiple authors in the same box. The most commonly used separators are `,` or `;` or else `|`, however make sure to check which data delimiter is selected for the tabular format when exporting the CSV file. If the same delimiter(s) also appears in the data, it may disrupt the structure of the exported file. For example, when a work has multiple authors, select the **Multiple** checkbox and choose a separator—such as semi-colon (;)—to separate the authors within the same cell. Make sure that this separator is different from the CSV field delimiter (usually a comma) when exporting your spreadsheet as a CSV file. In Excel or Google Sheets, choose **File** → **Save As** → **CSV** (Comma delimited) so columns are separated by commas, while each cell with multiple authors uses semi-colons to separate values within a cell.

Finally, when defining our objects and their structures, we may be faced with uncertain historical information. The example of the book *The Intellectuals on the Road to Class Power* illustrates this case well because we do not know the exact founding date of Harvester Press publishing house. How should we handle a case like this? If our research indicates that this publisher was active during the 1970s, we can hypothesize that it was established sometime between the year 1970 and the year 1979 which is the year our book was published. nodegoat allows us to record temporal information as a time interval (called **Chronology**), which is particularly useful in these kinds of cases.

To do this, let’s go back to the **Model** tab to access the **Publishing house** object type. Most likely, we have defined the **Founding date** attribute in the same way as an author’s date of birth: under the **Objects** tab, in the **Descriptions** list, and by choosing the **Date** data type.

{% include figure.html filename="en-tr-designing-database-nodegoat-10.jpg" alt="The attribute Founding date for the Publishing house object type" caption="Figure 10. **The Founding date** attribute." %}

To enter a date as a time interval, we can use the **Sub-Object** tab. There, we will create a sub-object called **Founding date** and check both the **Date** and **Chronology** options. 
 
{% include figure.html filename="en-tr-designing-database-nodegoat-11.jpg" alt="The sub-object tab with Name Founding date and the Chronology option selected under the Date sub-tab" caption="Figure 11. Creating a **Chronology Sub-Object** for the **Publishing House** type." %}

From now on, the **Publishing house** object type has a different attribute from **Author** and **Work**, which allows us to introduce temporal information as time intervals. Before we continue, we will need to remove the **Founding date** attribute from the **Objects** tab by deleting it from the descriptions field and saving the Object Type, since we have just replaced it with the **Chronology Sub-Object**.

#### Exploring and using the database

Our model, its object types, and their relationships are now defined. If we go back to the **Management** tab and click on the project name, nodegoat shows us a visualization of the model which, as you may notice, looks very similar to our original conceptual model:
 
{% include figure.html filename="en-tr-designing-database-nodegoat-12.jpg" alt="A data model connecting four tables each corresponding to Authors, Publishing houses, Works and Cities" caption="Figure 12. Visualization of our data model with nodegoat." %}

We can now manually populate our database with the information we collect over the course of our research. To do this, go to the **Data** tab and click on the button *Add [object type name]* which appears below each object type as you click on it.

Note that the attribute **Founding date** of the **Publishing house** object type is not displayed with the other attributes, but as an element of the **Sub-Objects**, and whose date is defined as **Chronology**. The software allows us to fill in the details of the chronology with a choice between three options accessible from the drop-down menu that pops up when we press the green _Create_ button below **Chronology**: 1) 'Point' to indicate an exact date; 2) 'Statement' to indicate a period after or before a certain date (year, month or day); 3) 'Between Statements' to indicate a period between two dates (as in our example, between 1970 and 1979).
 
{% include figure.html filename="en-tr-designing-database-nodegoat-13.jpg" alt="Under the object 'Publishing house', there is the 'Founding date' sub-tab which is used to create a 'Chronology' for the 'Date'" caption="Figure 13. Creating a timeline for Harvester Press." %}

{% include figure.html filename="en-tr-designing-database-nodegoat-14.jpg" alt="The 'Chronology' tab for 'Between statements', with two boxes for inserting a date in order to create a period between the two dates" caption="Figure 14. Example of a timeline defined as a period 'Between Statements'." %}

Once we have recorded all the works, authors, and publishing houses, the database interface will appear as shown in the images below. From there, simply click on any item to access its associated information:
 
{% include figure.html filename="en-tr-designing-database-nodegoat-15.jpg" alt="A table giving an overview of the works in our database with relevant information distributed in five columns, namely the title, the language of the first edition, the date of publication, the author, and the publishing house" caption="Figure 15. Overview of the works in our database." %}

{% include figure.html filename="en-tr-designing-database-nodegoat-16.jpg" alt="A table giving an overview of the authors in our database with relevant information distributed in six columns, namely the name of the author, the first name, the last name, the nationality, the place of birth, and the date of birth" caption="Figure 16. Overview of the authors in our database." %}

Alternatively, we can import our entire dataset as CSV files after we have finished analyzing our sources, rather than manually registering each record one at a time. Please note, however, that there are specific procedures to follow when importing your data, especially when your data model includes relationships. For example, the identifiers in your CSV files need to match existing objects in the nodegoat model. In addition, when importing related object types, make sure you first import the 'reference' objects that other objects refer to (e.g., Publishing House or Author) and only afterwards import the objects that reference them (e.g., Work), so that nodegoat can create the relationships correctly. More information can be found in the [nodegoat documentation](https://nodegoat.net/guide.s/25/import-relational-data).

Regardless of the method chosen (manual entry or importing files), once our database is built and populated, we can use the visualization tools offered by nodegoat to explore our objects and their relationships further. After selecting an **Object Type** in the **Data** tab, a set of visualization icons appears in the top right corner. These include options for geographical, relational (network), and chronological visualisations. For example, below is a map created using the geographical visualization tool to visualize the birthplaces of the authors represented as blue dots. To create this map, select the **Author** Object type in the **Data** tab and click the icon for geographical visualisation (the globe icon).

{% include figure.html filename="en-tr-designing-database-nodegoat-17.jpg" alt="Authors overview page, with location of Author Object type button indicated (upper left), and location of the globe icon button indicated (upper right)" caption="Figure 17. Overview of the authors in our database, indicating location of the **Author** Object type button (upper left), and location of the globe icon button (upper right)." %}
 
{% include figure.html filename="en-tr-designing-database-nodegoat-18.jpg" alt="A geographical map of Europe with blue dots marking the places of birth of our dissident authors from Eastern Europe" caption="Figure 18. A geographical visualization in nodegoat of the birthplaces of the authors in our dataset." %}
 
In sum, nodegoat allows us to define our data model and to build a database in a relatively simple way. It offers multiple possibilities for recording geographical and temporal information, while taking into account the uncertainty that often comes with the type of information we collect in the humanities. In addition, the visualization tools allow us to appreciate the evolution of our research and identify certain tendencies. Finally, this research environment allows us to store and manage our data online, while offering the possibility of saving or exporting it for analysis with other tools.

## Conclusion

The aim of this lesson was to help researchers in the humanities conceptualize their research in terms of data by introducing them to the basics of modeling and building a database, as it is often a challenging task for a novice. The lesson offered an entry point to using the online platform nodegoat, which is particularly well suited to the needs of newcomers to digital data management.

Of course, nodegoat also has some limitations: free individual access is limited to the development of a single project hosted on the platform's servers. If you want to manage multiple projects, create multiple accounts, or host a project on a separate server, you will need to upgrade to a paid subscription. This often requires financial and/or technical support from a research or educational institution.

To learn more about nodegoat's full potential in more depth, you are encouraged to explore the [Guides](https://perma.cc/6QEL-F7YZ) prepared by the LAB1100 team, which provide detailed explanations of the platform's features. On the nodegoat website, you can also explore [other examples of data models suggested by the creators](https://perma.cc/3LKU-ZPYK), as well as examples of historical research using databases.


## Footnotes

[^1]: Lemercier, Claire and Claire Zalc, *Quantitative Methods in the Humanities: An Introduction*. Translation by Arthur Goldhammer. Charlottesville: University of Virginia Press, 2019. 

[^2]: Posner, Miriam, (2015), “Humanities Data: A Necessary Contradiction”, *Miriam Posner’s Blog* <https://miriamposner.com/blog/humanities-data-a-necessary-contradiction/>. 

[^3]: Drucker, Johanna (2011), “Humanities Approaches to Graphical Display”, *Digital Humanities Quarterly* 5, n. 1. 

[^4]: Thaller, Manfred (2018), “On Information in Historical Sources”, *A Digital Ivory Tower*, <https://ivorytower.hypotheses.org/56>. 

[^5]: Gardarin, Georges (2003), *Bases de données*, Paris: Eyrolles. The book is freely accessible on the author’s website. For an English-language resource by the same author, see also: Gardarin, Georges and Patrick Valduriez, *Relational databases and knowledge bases*, Reading, Mass.; Wokingham: Addison-Wesley, 1989.

[^6]: See this Wikipedia page for more detail on the notion of 'cardinality': 'Relational Model', <https://en.wikipedia.org/wiki/Cardinality_(data_modeling)>. See also Gardarin, work cited above, 412-413. 

[^7]: Bree, P. van, Kessels, G., (2013). nodegoat: a web-based data management, network analysis & visualisation environment, http://nodegoat.net from LAB1100. 

[^8]: The nodegoat version used to recreate the examples at the time of this translation is 8.4. 

[^9]: The creators of nodegoat describe the relational approach of the software as 'object-oriented'. Since this concept is most commonly used to describe a programming paradigm, we prefer to avoid the use of this term in order to avoid any confusion.
