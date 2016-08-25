---
title: Making a Small RDF Database
authors:
- Will Hanley
date: 2016-08-12
reviewers:
layout: default
---

# Making a small RDF database

When I'm in the archives, I often come across serial records of some sort--lists, stacks of forms, indexes--that I wish to record. While it is convenient to enter this information using a word processer, the document that results is not very powerful. It's much easier to count, alphabetize, filter, and otherwise manipulate this data if I record it in a spreadsheet (like [Calc](https://www.libreoffice.org/discover/calc/) or [Excel](https://products.office.com/en-us/excel)) or a database (like [FileMaker](http://www.filemaker.com) or [Access](http://office.microsoft.com/access)). When I use these spreadsheet or database programs, however, it's often not clear to me which fields I ought to choose to record the data. Should I use first name/last name, or full name? What if some birthdates are exact, others are just years, and some are just ages? Sometimes, too, the way that information is recorded changes from scribe to scribe or from year to year. All of this means that I have to change my database's design midstream, then go back over records I've already recorded or leave the series incomplete.

There is a solution: the small Resource Description Framework (RDF) database. The RDF data models allows you to invent, remake, split, and combine your data fields and categories on the fly. Once you learn the grammar of this format, it's quite simple to record data in it. There is no need to remake your database as your records (or your understanding of them) change; just add the new data fields and carry on. Another great advantage comes at the end, because the RDF format offers powerful querying tools (see the [SPARQL tutorial](http://programminghistorian.org/lessons/graph-databases-and-SPARQL)) and it is easy to link RDF data to other data sets.

You may have heard of related concepts, such as graph databases, semantic databases, and triplestores. While the distinctions between all of these concepts are important, they are not critical to a basic grasp of the general graph/semantic/RDF approach. This approach is notably championed by the [World Wide Web Consortium](https://www.w3.org/) (W3C), which produces standards and software for an open web. Their interfaces and documentation can be somewhat opaque for beginners, however. Popular applications like [Neo4j](https://neo4j.com/) adopt a graph approach and and can be easy to use for certain purposes, but do not provide ready access to open standards such as RDF and SPQARQL. This tutorial skips abstract explanation of graph data modeling and jumps right into practical application. It employs very basic (free and open-source) tools that are perfectly suitable for the smaller databases that an archival historian might produce. 

## An example

Suppose you were working with a register of American nationals kept at the US consulate in Alexandria, Egypt in the 1880s. This is a serial record that lists standardized information. It can help to answer questions such as how many Americans lived in the city, the demographics of this population, its occupations, and so on. But the protocols of registration are inconsistent, and it's hard to know how to record the data in a standard format. Consider this page:

{% include figure.html filename="alexandria-register-page.jpg" caption="Register of US nationals in Alexandria, Egypt (Source: 350/11/19/3, vol. 24, RG 84, National Archives and Records Administration, College Park, Maryland)." %}

You could transcribe it as a text file, more or less as follows:

```
		Mirzan Marie (left) (x)		|
							        |	
Edwige		daughter of 	Do.		|
Mary Rose	daughter of		Do.		|
Victor John	son of			Do.		|4th Sep'r 94. completed 21 years.			
Victor, Died today 1st November 1905 at 7 a.m.
aged 32 years from Tuberculosi Polmonite. European Hospital.

		Morpurgo D. Brutus (x)		|	Ironmonger died the 7 6 July 1906

Clarisa Hélène  wife    of  Do.     |
Julia			mother (of Brutus) +| dead from cancer 9th July 1902. 4 a.m.
Libera Rachel	sister	"	"		|
Virginia        daughter    "   "   |
Réné            daughter    "   "   |
Angelino M.		son 	"	"		|
Ugo				son 	"	"		|
Hector			son 	"	"		|
Rodolph			son 	"	"		| dead 4th April 1894. aged 16 years from Diptheria.
Edgar			son		"	"		|
Oscar			son 	"	"		|
Gustave			son		"	"		|

	McFarlane Kenedy Wiley			| American Missionary

Anna Henderson	wife 	of	same	| Alexandria
Mary Evelyn		dauter	of	same	| 31 March 1896
Ralph Harvey	son		of	same	|

	Mogroby Jacob M	                | Ombrella Merchant
                                    | reg. The 1.6.97 acc. To a Passport No 776 dated
Toba Mogroby	wife	of	do		 Vienna Austria 20th April 97.
Moses Mogroby	son 	of	do		 born 10 Feb. 98

X As recorded by Rev'd Dr. S C Ewing ex US Consular Agent on the 20th day of June 1888
```

You could even record the check marks, circles, and crosses pencilled in on the left, though their meaning is uncertain. The names would be searchable in such a document, but statistics and other data work would have to be undertaken manually or using Python scripts. Yet this serial register was _already a database_ when it was produced more than a century ago, and it makes sense to transcribe it _as data_. How might we do this in a more sophisticated way?

## The tabular, relational, and hierarchical options
If you choose to record this list as chunks of information rather than linear text, you have several approaches to consider. 

A **first option** is to make a table out of this information, like so:

{% include figure.html filename="spreadsheet-example.png" caption="Tabular rendering of data" %}

It's not clear how many columns to create, or which columns are appropriate, even for this single page. As it is, there are two dozen columns, and some information still remains hidden. Other pages of the register introduce still more categories. A complete table would have many dozens of columns.

A **second option** is to turn the information into a relational database, for instance using Filemaker or Access. Each of the four heads of household on this page would have his or her own subsidiary table, listing information about his or her household. This approach would be rather time consuming, however, and it would be difficult to maintain a comprehensive view of the dataset.

A **third option** would be to encode the page above using XML tags, marking information for machine extraction and counting. This would require the development of an elaborate and customized schema, however. The document would have to be carefully and consistently encoded in order to permit searches that would reveal, for example, the median number of children per household.

Ultimately, it is hard to see that any of these approaches would save much effort over mere linear transcription. And if the historian wanted to share data in one of these formats with a colleague, a lot of explanation (metadata) would be necessary.

In a case like this, an RDF approach might be useful.

## Making a small RDF database

An RDF database is made up of three-part assertions called "triples." A shorthand that people use to describe the grammar of triples is "subject-verb-object" or "subject-predicate-object." This simple grammar can be applied to almost any statement:

- This (1) is not (2) a pipe (3) .
- Gillian Welch (1) was born in (2) the year 1967 (3) .
- Coffee (1) contains (2) caffeine (3) .

To make an RDF database from the register page from the US Consulate in Alexandria, we need to render it into triples. We'll go about the processing step-by-step to show how the logic works. Once you have a bit of experience, you can skip the preliminary steps.

### Step 1: List
First, turn the linear text into a list. Every item on the list represents a person that you want to enter into the database. You want to record the name and various other details about each of these persons. For clarity, let's replace all of the "dittos" in the original with the names to which they refer.

1. Mirzan Marie (left) (x)
								
2. Edwige, daughter of Mirzan Marie.

3. Mary Rose, daughter of Mirzan Marie.

4. Victor John	son of Mirzan Marie. 4th Sep'r 94. completed 21 years.; Victor, Died today 1st November 1905 at 7 a.m. aged 32 years from Tuberculosi Polmonite. European Hospital.

5. Morpurgo D. Brutus (x), Ironmonger died the ~~7~~6 July 1906

6. Clarisa Hélène, wife of Morpurgo D. Brutus

7. Julia, mother of Morpurgo D. Brutus, dead from cancer 9th July 1902. 4 a.m.

8. Libera Rachel, sister of Morpurgo D. Brutus.

9. Virginia, daughter of Morpurgo D. Brutus.

10. Réné, daughter of Morpurgo D. Brutus.

11. Angelino M., son of Morpurgo D. Brutus.

12. Ugo, son of Morpurgo D. Brutus.

13. Hector, son of Morpurgo D. Brutus.

14. Rodolph, son of Morpurgo D. Brutus. dead 4th April 1894. aged 16 years from Diptheria.

15. Edgar, son of Morpurgo D. Brutus.

16. Oscar, son of Morpurgo D. Brutus.

17. Gustave, son of Morpurgo D. Brutus.

18. McFarlane Kenedy Wiley, American Missionary, Alexandria, 21 March 1896.

19. Anna Henderson, wife of McFarlane Kenedy Wiley.

20. Mary Evelyn, dauter [sic] of McFarlane Kenedy Wiley.

21. Ralph Harvey, son of McFarlane Kenedy Wiley,

22. Mogroby Jacob M, Ombrella Merchant, reg. the 1.6.97 acc. to a Passport No 776 dated Vienna Austria 20th April 97.

23. Toba Mogroby wife of Mogroby Jacob M.

24. Moses Mogroby son of Mogroby Jacob M, born 10 Feb. 98

25. Rev'd Dr. S C Ewing, ex US Consular Agent, who recorded information marked with an x on the 20th day of June 1888.

### Step 2: Structured list
Now, let's structure this list by describing the kind of details it includes about each person. This is where we introduce the idea of triples. For example, the first triple we want to make is "item 1 on the list (1) is a person named (2) Mirzan Marie (3)." In other words, "1. (1) Name: (2) Mirzan Marie (3)." We repeat this process for every assertion that the list contains. We can invent relatively arbitrary categories for each type of detail, much as we would if we were putting the information into a table. 

One move that is novel here: for "ditto," we're substituting a number, which shows which person on the list the "ditto" refers to. Thus, we say that Edwige (#2 on the list) is the daughter of #1 (by which we mean Marie).

```
1. 	Name: Mirzan Marie
	Notes: "left", "x"

2. 	Name: Edwige
	daughter of: #1

3. 	Name: Mary Rose
	daughter of: #1

4. 	Name: Victor John
	son of: #1
	Note: 4 9 1894 "completed 21 years"
	Death date: 1 11 1905, 7 am
	Death age: 32
	Death place: European Hospital
	Death cause: Tuberculosi Polmonite

5.	Name: Morpurgo D. Brutus
	Note: x
	Occupation: Ironmonger
	Death date: 6 7 06

6. 	Name: Clarisa Hélène
	wife of: #5

7. 	Name: Julia
	Mother of: #5
	Death date: 9 7 1902, 4 am
	Death cause: cancer

8.  Name: Libera Rachel
	sister of: #5

9.	Name: Virginia
	daughter of: #5

10.	Name: Réné
	daughter of: #5

11. Name: Angelino M.
	son of: #5

12.	Name: Ugo
	son of: #5

13.	Name: Hector
	son of: #5

14.	Name: Rodolph
	son of: #5
	Death date: 4 4 1894
	Death age: 16
	Death cause: Diptheria

15.	Name: Edgar
	son of:	#5

16. Name: Oscar
	son of: #5

17.	Name: Hector
	son of: #5

18.	Name: McFarlane Kenedy Wiley
	Profession: American Missionary
	Note: Alexandria, 31 3 1896.

19.	Name: Anna Henderson
	wife of: #18

20.	Name: Mary Evelyn
	daughter of : #18 (misspelled "dauter")

21.	Name: Ralph Harvey
	son of: #18

22.	Name: Mogroby Jacob M
	Occupation: Ombrella Merchant
	Registration: on 1.6.97 acc. to a Passport No 776 dated Vienna Austria 20th April 97.

23.	Name: Toba Mogroby
	Wife of: #22

24. Name: Moses Mogroby
	son of:	#24
	Birth date: 10 2 1898

25.	Name: Rev'd Dr. S C Ewing
	Occupation: ex US Consular Agent
	Note: recorded information marked with an x on the 20th day of June 1888.
```

### Step 3: Translate into Machine-readable Language
This step is a bit more tricky, but it's the critical transformation: let's translate this structured list into language that a machine can read. The language that we will use is called [Turtle](https://www.w3.org/TeamSubmission/turtle/), a common and quite simple language to express RDF triples. It's easiest to use a simple text editor to do this work. For more on simple text editing, see this [plain text tutorial](http://programminghistorian.org/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown). 

This translation (like all RDF documents) starts with a *declaration*, which is a list of abbreviations or shorthand that explains the vocabulary we use. Just as we did in step 2, we're going to invent some vocabulary to describe the information we've found. One pleasure of RDF is that it's easy to invent your own classification scheme as you go along, and fix or reconcile it later. That classification scheme lives in your own "namespace," and your first job is to declare that namespace. We'll call our namespace "mydb" and enter it at the top in the following format: `@prefix mydb: <http://mydb.org#>`. You can use whatever letters you want for "mydb" and whatever address you want for "mydb.org" (the http:// does not need to refer to a real website).

Although you can invent your own vocabulary (what computer scientists call "schema") for everything, there are already quite a few well-made schemas in common use. It is good practice to adopt their terms whenever you can. In this example, we will use three of the leading schemas: [rdf and rdfs](https://www.w3.org/TR/rdf-schema/) and [foaf](http://xmlns.com/foaf/spec/) (friend of a friend). Eventually, you might want to dig deeper into the features of these schemas. For now, let's declare them and see how they can be implemented into the list we produced on step 2. 

Having finished the declaration, we are now ready to begin making statements about each person that we listed in step 2. In this database, each person is a unique object, known by its own URI (Unique Resource Identifier)--a number or node that represents the person. This URI looks like a web address, but is in fact simply a numbered, identified node in our mydb.org namespace. For the sake of clarity, we'll start the numbering at 1, thus the first URI is mydb.org/id/1. 

This URI is the subject of a paragraph of triples that give information about this person. Let's take a close look at one of these paragraphs:

```turtle
<mydb.org/id/2> a foaf:Person ;	
	rdfs:label "Edwige" ;
	mydb:daughterOf <mydb.org/id/1> .
```

The first triple simply states that the URI represents a person, an idea that we can represent using the Person element of the foaf (Friend of a Friend) schema. Machines know quite a lot about `foaf:Persons`—like they can have parents, children, genders, and so on—we'll see later what we can do with this. 

The first triple ends with a semicolon, indicating that another triple about the same subject (the same URI) will follow. The second triple states that `mydb.org/id/2` can be labeled "Edwige." For ease of use, every URI should be assigned a label, which is the name we humans call it--in this case, the person's name. This is what's called a literal (a "string" in computer-science-speak), and it appears between quotation marks. Labels are really useful for humans trying to read databases. When we query an RDF database, the machine looks for URIs, but we can tell the machine to answer us by substituting labels that we can read instead.

The third triple states that mydb.org/id/2 is the `daughterOf` (a term we've just invented in our mydb schema) the person listed under the URI `mydb.org/id/1`. As the last triple of the paragraph, this statement ends with a full stop rather than a semicolon.

Here's the whole page in Turtle:

```turtle
@prefix mydb: 	<http://mydb.org/schema#> .
@prefix foaf:	<http://xmlns.com/foaf/0.1> .
@prefix rdf:	<http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:	<http://www.w3.org/2000/01/rdf-schema#> .

<mydb.org/id/1> a foaf:Person ;
	rdfs:label "Mirzan Marie" ;
	mydb:note "left" ;
	mydb:note "x" .

<mydb.org/id/2> a foaf:Person ;	
	rdfs:label "Edwige" ;
	mydb:daughterOf <mydb.org/id/1> .

<mydb.org/id/3> a foaf:Person ;	
	rdfs:label "Mary Rose" ;
	mydb:daughterOf <mydb.org/id/1> .

<mydb.org/id/4> a foaf:Person ;	
	rdfs:label "Victor John" ;
	mydb:sonOf <mydb.org/id/1> ;
	mydb:note "4 9 1894 completed 21 years" ;
	mydb:deathDate "1 11 1905, 7 am" ;
	mydb:deathAge 32 ;
	mydb:deathPlace	"European Hospital" ;
	mydb:deathCause	 "Tuberculosi Polmonite" .

<mydb.org/id/5> a foaf:Person ;
	rdfs:label "Morpurgo D. Brutus" ;
	mydb:note "x" ;
	mydb:occupation "Ironmonger" ;
	mydb:deathDate "6 7 06" .

<mydb.org/id/6> a foaf:Person ;	
	rdfs:label "Clarisa Hélène" ;
	mydb:wifeOf <mydb.org/id/5> .

<mydb.org/id/7> a foaf:Person ;	
	rdfs:label "Julia" ;
	mydb:motherOf <mydb.org/id/5> ;
	mydb:deathDate "9 7 1902, 4am" ;
	mydb:deathCause "cancer" .

<mydb.org/id/8> a foaf:Person ;	
	rdfs:label "Libera Rachel" ;
	mydb:sisterOf <mydb.org/id/5> .

<mydb.org/id/9> a foaf:Person ;	
	rdfs:label "Virginia" ;
	mydb:daughterOf <mydb.org/id/5> .

<mydb.org/id/10> a foaf:Person ;	
	rdfs:label "Réné" ;
	mydb:daughterOf <mydb.org/id/5> .

<mydb.org/id/11> a foaf:Person ;	
	rdfs:label "Angelino M." ;
	mydb:sonOf <mydb.org/id/5> .

<mydb.org/id/12> a foaf:Person ;	
	rdfs:label "Ugo" ;
	mydb:sonOf <mydb.org/id/5> .

<mydb.org/id/13> a foaf:Person ;	
	rdfs:label "Hector" ;
	mydb:sonOf <mydb.org/id/5> .

<mydb.org/id/14> a foaf:Person ;	
	rdfs:label "Rodolph" ;
	mydb:sonOf <mydb.org/id/5> .
	mydb:deathDate "4 4 1894" ;
	mydb:deathAge 16 ;
	mydb:deathCause "Diptheria" .

<mydb.org/id/15> a foaf:Person ;	
	rdfs:label "Edgar" ;
	mydb:sonOf <mydb.org/id/5> .

<mydb.org/id/16> a foaf:Person ;	
	rdfs:label "Oscar" ;
	mydb:sonOf <mydb.org/id/5> .

<mydb.org/id/17> a foaf:Person ;	
	rdfs:label "Hector" ;
	mydb:sonOf <mydb.org/id/5> .

<mydb.org/id/18> a foaf:Person ;
	rdfs:label "McFarlane Kenedy Wiley" ;
	mydb:profession "American Missionary" ;
	mydb:note "Alexandria 31 3 1896" .

<mydb.org/id/19> a foaf:Person ;
	rdfs:label "Anna Henderson" ;
	mydb:wifeOf <mydb.org/id/18> .

<mydb.org/id/20> a foaf:Person ;
	rdfs:label "Mary Evelyn" ;
	mydb:daughterOf <mydb.org/id/18> .

<mydb.org/id/21> a foaf:Person ;
	rdfs:label "Ralph Harvey"
	mydb:sonOf <mydb.org/id/18> .

<mydb.org/id/22> a foaf:Person ;
	rdfs:label "Mogroby Jacob M" ;
	mydb:occupation "Ombrella Merchant" ;
	mydb:registration	 "on 1.6.97 acc. to a Passport No 776 dated Vienna Austria 20th April 97".

<mydb.org/id/23> a foaf:Person ;
	rdfs:label "Toba Mogroby" .
	mydb:wifeOf <mydb.org/id/22> .

<mydb.org/id/24> a foaf:Person ;
	rdfs:label "Moses Mogroby" ;
	mydb:sonOf <mydb.org/id/24> ;
	mydb:birthDate "10 2 1898" .

<mydb.org/id/25> a foaf:Person ;
	rdfs:label "Rev'd Dr. S C Ewing" ;
	mydb:occupation "ex US Consular Agent" .
```

Done! This is far from elegant, but it will work. (It may not work for long, but every database needs updating eventually, and RDF is very easy to update as your understanding of the material in your dataset evolves). As you can see, the terms we've used are derived directly from the material itself. Anything that you put behind your own invented namespace (`mydb:` in this instance) is yours to invent.

If you are already familiar with SPARQL, you can download this file [here](https://raw.githubusercontent.com/whanley/RDF-tutorial/master/americans-in-alex-step-3.ttl) or perform SPARQL queries [here](http://whanley.history.fsu.edu:8890/sparql) (enter `http://localhost:8890/am-in-alex-step-3` as the Graph IRI). If not, let's do a little more work on the basic dataset before we start manipulating it.

### Step 4: Deeper into RDF
Like any historian, you come to the archives with a sense of some of the information that you're looking for while remaining alert for new tracks of inquiry. Our database for this register has already established a network of parent-child relationships, but it does not do a great job of expressing names or dates, which are something we're pretty interested to analyse. It also records only persons, when it could also record other types of things, such as documents. Let's add this layer of structure.

In Step 3, we treated all names as labels (using the rdfs schema). Now, let's add a triple to each paragraph in which we also designate them as names (using the foaf schema). For the first person listed, Mirzan Marie, this means adding a `foaf:givenName` of "Marie" and a `foaf:familyName` of "Mirzan". The second person, her daughter Edwige, has a `foaf:givenName` of "Edwige" but no family name listed (later one we'll add one automatically). 

Now let's see what we can do about dates. First, let's standardize their format. Most databases use the YYYY-MM-DD format for dates, which we'll adopt below. Here and there, the dates we've recorded are birth and death dates. It seems likely that there's a schema somewhere that already expresses such a common concept. Sure enough, if we look at [schema.org's list of Person properties](http://schema.org/Person), we find `birthDate` and `deathDate`, as well as `deathPlace`. So let's add schema.org to our declaration, and substitute these more widely used properties for the `mydb:birthDate`, `mydb:deathDate`, and `mydb:deathPlace` properties we invented in step 3. There's probably a substitute for `mydb:deathCause` somewhere out there, but it didn't turn up right away, so let's leave it in place.

Finally, let's add two new types of objects. First, let's deal with the document that Jacob Mogroby (#22 on the Step 1 list) presented when registering. We'll assign it a URI of `mydb.org/doc/1` and record its type and number and date and place of issue in triples. Let's also deal with the note at the bottom of the page, which states that Reverend Ewing was the one who entered certain information into the register on June 30, 1888. We've previously listed Ewing as `mydb.org/id/25`. Now let's create `mydb.org/annot/1`, call it a "registrationNote" and enter the relevant information. It's not entirely clear what this registration note means, but we'll have a better chance of figuring it out later on if we make the information explicit now.

Here is the result: 

```turtle
@prefix mydb: 	<http://mydb.org/schema#> .
@prefix foaf:	<http://xmlns.com/foaf/0.1> .
@prefix rdf:	<http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:	<http://www.w3.org/2000/01/rdf-schema#> .
@prefix schema: <http://schema.org/#> .

<mydb.org/id/1> a foaf:Person ;
	rdfs:label "Mirzan Marie" ;
	foaf:givenName "Marie" ;
	foaf:familyName "Mirzan" ;
	mydb:note "left" ;
	mydb:note "x" .

<mydb.org/id/2> a foaf:Person ;	
	rdfs:label "Edwige" ;
	foaf:givenName "Edwige" ;
	mydb:daughterOf <mydb.org/id/1> .

<mydb.org/id/3> a foaf:Person ;	
	rdfs:label "Mary Rose" ;
	foaf:givenName "Mary Rose" ;
	mydb:daughterOf <mydb.org/id/1> .

<mydb.org/id/4> a foaf:Person ;	
	rdfs:label "Victor John" ;
	foaf:givenName "Victor John" ;
	mydb:sonOf <mydb.org/id/1> ;
	mydb:associatedDate	"1894-09-04" ;
	mydb:note "1894-09-04 completed 21 years" ;
	schema:deathDate "1905-11-01" ;
	mydb:deathAge 32 ;
	schema:deathPlace "European Hospital" ;
	mydb:deathCause	"Tuberculosi Polmonite" .

<mydb.org/id/5> a foaf:Person ;
	rdfs:label "Morpurgo D. Brutus" ;
	foaf:familyName "Morpurgo" ;
	foaf:givenName "D. Brutus" ;
	mydb:note "x" ;
	mydb:occupation "Ironmonger" ;
	schema:deathDate "1906-07-06" ;
	mydb:note "7 July 1906 day crossed out".

<mydb.org/id/6> a foaf:Person ;	
	rdfs:label "Clarisa Hélène" ;
	foaf:givenName "Clarisa Hélène" ;
	mydb:wifeOf <mydb.org/id/5> .

<mydb.org/id/7> a foaf:Person ;	
	rdfs:label "Julia" ;
	foaf:givenName "Julia" ;
	mydb:motherOf <mydb.org/id/5> ;
	schema:deathDate "1902-07-09" ;
	mydb:deathCause	"cancer" .

<mydb.org/id/8> a foaf:Person ;	
	rdfs:label "Libera Rachel" ;
	foaf:givenName "Libera Rachel" ;
	mydb:sisterOf <mydb.org/id/5> .

<mydb.org/id/9> a foaf:Person ;	
	rdfs:label "Virginia" ;
	foaf:givenName "Virginia" ;
	mydb:daughterOf <mydb.org/id/5> .

<mydb.org/id/10> a foaf:Person ;	
	rdfs:label "Réné" ;
	foaf:givenName "Réné" ;
	mydb:daughterOf <mydb.org/id/5> .

<mydb.org/id/11> a foaf:Person ;	
	rdfs:label "Angelino M." ;
	foaf:givenName "Angelino M." ;
	mydb:sonOf <mydb.org/id/5> .

<mydb.org/id/12> a foaf:Person ;	
	rdfs:label "Ugo" ;
	foaf:givenName "Ugo" ;
	mydb:sonOf <mydb.org/id/5> .

<mydb.org/id/13> a foaf:Person ;	
	rdfs:label "Hector" ;
	foaf:givenName "Hector" ;
	mydb:sonOf <mydb.org/id/5> .

<mydb.org/id/14> a foaf:Person ;	
	rdfs:label "Rodolph" ;
	foaf:givenName "Rodolph" ;
	mydb:sonOf <mydb.org/id/5> ;
	schema:deathDate "1894-04-04" ;
	mydb:deathAge 16 ;
	mydb:deathCause	"Diptheria" .

<mydb.org/id/15> a foaf:Person ;	
	rdfs:label "Edgar" ;
	foaf:givenName "Edgar" ;
	mydb:sonOf <mydb.org/id/5> .

<mydb.org/id/16> a foaf:Person ;	
	rdfs:label "Oscar" ;
	foaf:givenName "Oscar" ;
	mydb:sonOf <mydb.org/id/5> .

<mydb.org/id/17> a foaf:Person ;	
	rdfs:label "Hector" ;
	foaf:givenName "Hector" ;
	mydb:sonOf <mydb.org/id/5> .

<mydb.org/id/18> a foaf:Person ;
	rdfs:label "McFarlane Kenedy Wiley" ;
	foaf:familyName "McFarlane" ;
	foaf:givenName "Kenedy Wiley" ;
	mydb:profession "American Missionary" ;
	mydb:note "Alexandria" ;
	mydb:note "1896-03-31" .

<mydb.org/id/19> a foaf:Person ;
	rdfs:label "Anna Henderson" ;
	foaf:givenName "Anna Henderson" ;
	mydb:wifeOf <mydb.org/id/18> .

<mydb.org/id/20> a foaf:Person ;
	rdfs:label "Mary Evelyn" ;
	foaf:givenName "Mary Evelyn" ;
	mydb:daughterOf <mydb.org/id/18> ;
	mydb:note "misspelled dauter" .

<mydb.org/id/21> a foaf:Person ;
	rdfs:label "Ralph Harvey" ;
	foaf:givenName "Ralph Harvey" ;
	mydb:sonOf <mydb.org/id/18> .

<mydb.org/id/22> a foaf:Person ;
	rdfs:label "Mogroby Jacob M" ;
	foaf:familyName "Mogroby" ;
	foaf:givenName "Jacob M" ;
	mydb:occupation "Ombrella Merchant" ;
	mydb:registrationDate "1897-06-01" ;
	mydb:registrationDocument <mydb.org/doc/1> .

<mydb.org/doc/1> a mydb:doc ;
	mydb:docType "passport" ;
	mydb:docNumber 776 ;	
	mydb:docDate "1897-04-20" ;
	mydb:docIssued "Vienna Austria" .	

<mydb.org/id/23> a foaf:Person ;
	rdfs:label "Toba Mogroby" ;
	foaf:familyName "Mogroby" ;
	foaf:givenName "Toba" ;
	mydb:wifeOf	<mydb.org/id/22> .

<mydb.org/id/24> a foaf:Person ;
	rdfs:label "Moses Mogroby" ;
	foaf:familyName "Mogroby" ;
	foaf:givenName "Moses" ;
	mydb:sonOf <mydb.org/id/24> ;
	mydb:birthDate "1898-02-10" .

<mydb.org/annot/`> a mydb:registrationNote ;
	mydb:recordedBy <mydb.org/id/24> ;
	mydb:date "1888-06-20" .

<mydb.org/id/25> a foaf:Person ;
	rdfs:label "Rev'd Dr. S C Ewing" ;
	foaf:familyName "Ewing" ;
	foaf:givenName "S C" ;
	schema:honorificPrefix "Rev'd" ;
	schema:honorificPrefix "Dr." ;
	mydb:occupation "ex US Consular Agent" .
```

(Download this file [here](https://raw.githubusercontent.com/whanley/RDF-tutorial/master/americans-in-alex-step-4.ttl) and perform SPARQL queries [here](http://whanley.history.fsu.edu:8890/sparql) (enter `http://localhost:8890/am-in-alex-step-4` as the Graph IRI).

### Step 5: Work with your small database

To work with the data in this file (for instance using SPARQL), we'll need an application that will treat it as a database. A simple option is [Fuseki](https://jena.apache.org/documentation/serving_data/). Download it from [this page](https://jena.apache.org/download/index.cgi) (scroll down to the *Apache Jena Fuseki* heading, and download the `apache-jena-fuseki.2.4.0.zip` file. Unzip this file. Then, using the command line (in Terminal in Linux or Mac, or in Command Prompt in Windows), use `cd` (Linux/Mac) or `dir` (Windows) to navigate to the Fuseki folder you created. Then use the command `./fuseki-server` (Linux/Mac) or `./fuseki-server.bat` (Windows) to start the server. Open a web browser and type [`localhost:3030`](localhost:3030) into the address bar, and you are set to go.

We'll now need to upload our data file into Fuseki. Add a new dataset, give it a name that makes sense, then upload data and attach our turtle file. (When you construct a dataset yourself, you might encounter upload errors if you have made certain syntax errors in typing. Most often, it's a misplaced semicolon or period that is responsible.)

Now we're set to interact with the data using the SPARQL query language, which as we've seen is the subject of [another *Programming Historian* tutorial](http://programminghistorian.org/lessons/graph-databases-and-SPARQL). Switch to the Fuseki query interface and run `SELECT * WHERE {?s ?p ?o}`, the standard SPARQL query that lists all of the information entered. 

Now let's try a more useful query. This query will list the name, cause of death, and date of death in each case where all three were listed. 
```turtle
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX dbpedia: <http://dbpedia.org/resource/>
PREFIX mydb: 	<http://mydb.org/schema#> 
PREFIX schema: <http://schema.org/#> 

SELECT ?name ?cause ?date
WHERE
{?s rdfs:label ?name ;
	mydb:deathCause ?cause ;
	schema:deathDate ?date .
}
```

How about those marginal notes? This query lists every note.
```turtle
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX dbpedia: <http://dbpedia.org/resource/>
PREFIX mydb: 	<http://mydb.org/schema#> 
PREFIX schema: <http://schema.org/#> 
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?name ?note
WHERE
{ ?s rdfs:label ?name ;
 mydb:note ?note .
}
```
This query may reveal patterns, for instance in the use of "x" in the margins.

### Step 6: Refining data
Of course, a small RDF database such as this contains numerous inconsistencies--and these inconsistencies are an important reason why you might choose this data model. Fortunately, [SPARQL 1.1](https://www.w3.org/TR/sparql11-query/) is not just a query language. It also helps you to update your data. 

In constructing this database, we made up categories as we went along. Let's take a look at a list of these categories. Use this query:
```turtle
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX dbpedia: <http://dbpedia.org/resource/>
PREFIX mydb: <http://mydb.org/schema#> 
PREFIX schema: <http://schema.org/#> 
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

SELECT distinct ?property 
where { 
   ?s ?property ?o .
}
ORDER BY ASC(?property)
```
Partway down this alphabetized list, you'll notice that we used both `mydb:occupation` and `mydb:profession`. For our purposes, these two properties are synonymous. We can add a statement that establishes this equivalence.

```turtle
PREFIX mydb: <http://mydb.org/schema#> 
PREFIX owl:	<http://www.w3.org/2002/07/owl#>

INSERT DATA
{
mydb:occupation owl:equivalentProperty mydb:profession .
}
```

Then search, with something like: 
```turtle
PREFIX mydb: 	<http://mydb.org/schema#> 	
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?name ?occupation
WHERE
{
  ?s rdfs:label ?name ;
    mydb:profession ?occupation .
}
```

How about a second refinement? As I mentioned earlier, the machine can supply surname via link to parent. Be sure to use the /update endpoint in Fuseki, rather than the /query or /sparql endpoints you've used up to now. Then execute this command:

```turtle
# be sure to use /update endpoint
PREFIX foaf: <http://xmlns.com/foaf/0.1>
PREFIX dbpedia: <http://dbpedia.org/resource/>
PREFIX mydb: 	<http://mydb.org/schema#> 
PREFIX schema: <http://schema.org/#> 
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

INSERT 
{
  ?s foaf:familyName ?surname .
}
WHERE
{ ?s (mydb:sonOf | mydb:daughterOf) ?o .
  ?o foaf:familyName ?surname .
}
```

Now a line will be added to the record of every son and daughter, giving them the `familyName` of their parent.

### Conclusion
The turtle file that you've created is quite compact, and can be sent to others. Exposing this data as a SPARQL endpoint is rather more complicated, and is a topic for another lesson. And there is much more that you can do with schemas and ontologies to enhance this data set. But this small RDF database has a simpler purpose: to record serial data of uncertain structure in a format that allows you to explore its content and categories. I hope that the examples give here have convinced you of the many possibilities of this format.
