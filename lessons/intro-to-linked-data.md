---
title: Introduction to Linked Open Data
authors:
- Jonathan Blaney
date: 2017-04-03
layout: default
difficulty: 1
---

Introduction. What this course covers and what it does not
----------------------------------------------------------

This course is a brief and concise introduction to linked open data. It should give you a clear understanding of linked open data, how it is used and how it is created. It has six parts:

1. Linked open data: what is it? 
2. The URI
3. How LOD organises knowledge: ontologies
4. RDF and data formats
5. Querying linked open data with SPARQL
6. Further reading and resources

Don't worry: those acronyms will be explained as they arise.

The course should take a couple of hours to complete. If you've heard of linked open data before you might complete it more quickly. If this is all new you might find that it's rather abstract the first time round. Ultimately the best way to learn about linked open data is to mess around with some: this course, I hope, will be your first step towards that.

Two things will *not* be covered: 

1. the [semantic web](https://en.wikipedia.org/wiki/Semantic_Web) proper, in the sense of [semantic reasoning](https://en.wikipedia.org/wiki/Semantic_reasoner) over [datasets](https://en.wikipedia.org/wiki/Data_set). An example of semantic reasoning would be something like "Edward VIII is the son of George V and George VI is the son of George V". A semantic reasoner should then be able to deduce a new fact: George VI is the brother or half-brother of Edward VIII. 
2. Creating and uploading linked open datasets to the [linked data cloud](http://linkeddatacatalog.dws.informatik.uni-mannheim.de/state/). At the end of the course there will be links to resources where you can learn about these and explore linked open data in more depth.

By the end of the course you should understand the basics of what linked open data is all about and the key terms and concepts should be familiar. You can then decide if you want to go further and learn practical skills to create your own linked open data.

If your main goal is to start exploring linked open data using the query language [SPARQL](https://en.wikipedia.org/wiki/SPARQL), [there is a full tutorial for that on this site](http://programminghistorian.org/lessons/graph-databases-and-SPARQL) and I recommend you follow that course instead. SPARQL is covered towards the end of this course, but more as a conceptual overview.

_This course is based on one written as part of the [Tobias project](http://www.history.ac.uk/projects/digital/tobias), funded by the [AHRC](http://www.ahrc.ac.uk/), but has been reworked for Programming Historian._

## Linked open data: what is it?

Linked open data (henceforth LOD) is really meant for machines to read. That means that for humans it's not necessarily easy on the eye. Don't be put off: once you understand the principles you can get a machine to do the reading for you.

The two essential ideas of LOD are: 

1. use a universal format 
2. publish your data openly

By openly I mean for anyone to use (i.e. available without paying a fee) and in a format that does not require [proprietary software](https://en.wikipedia.org/wiki/Proprietary_software).

If datasets are published for all to use, and they all use the same format, then it will be possible for someone to interrogate all of the data at once. This is much more powerful than individual datasets dotted around in what are known as [silos](https://en.wikipedia.org/wiki/Information_silo). The data must be [structured](https://en.wikipedia.org/wiki/Data_structure) the same way and use the same means of referring to the same thing. For example, let's say we have data in this format:

    person="number"

If everybody who creates a dataset that mentions that person uses the *exactly the same number* and in *exactly the same format* to refer to that person, then we can reliably find them in all of those datasets. Let's create an example using Jack Straw: since Jack Straw is both the name of a fourteenth-century English rebel and a UK cabinet minister prominent in Tony Blair's administration. It is clearly useful to be able to differentiate the two people:

Let's make Jack Straw, the UK minister, `64183282`:

    person=64183282

And let's make Jack Straw described by the *[Oxford Dictionary of National Biography](www.oxforddnb.com)* as "the enigmatic rebel leader" `33059614`:

    person=33059614

We can now search for person `64183282` and, providing this number has been used every time this person is referred to, know that we are getting the same person - in this case, the minister, every time.

At this point you might be thinking, "that's what a library catalogue does". It's true that the key idea here is that of the [authority file](https://en.wikipedia.org/wiki/Authority_control), which is central in library science (an authority file is a definitive list of terms which can be used in a particular context, for example when cataloguing a book). A library catalogue could be LOD but an authority file alone does not contain the next, key step in creating LOD:

Jack Straw the modern politician was a member of the UK Parliament, representing the seat of Blackburn. Now, there's more than one place in the UK called Blackburn, leaving aside the other Blackburns that you can find around the world. So to describe this particular Blackburn let's use the same principle as with Jack Straw and find a unique identifier for Blackburn in Lancashire, England:

	place=2655524

The next step is to have a way of *describing* the relationship between Jack Straw, our `64183282`, to Blackburn, our `2655524`. In LOD relationships are expressed using a '[triple](https://en.wikipedia.org/wiki/Semantic_triple)'. Let's make a triple that represents the relationship between Jack Straw and his constituency:

    person:64183282 role:representedInUKParliament constituency:"blackburn1955-current" .
	
(The presentation of triples, including punctuation the punctuation used above, will be discussed later, in the section on RDF and data formats.)

The triple, not surprisingly, has three parts. These are conventionally referred to as subject, predicate and object:

|the subject|the predicate|the object|
|------|---------|-----------|
|person 64183282|representedInUKParliament|"blackburn1955-current"|

The traditional way to represent a triple in diagrammatic form is:

{% include figure.html filename="intro-to-linked-data-fig5.png" caption="the classic way to represent a triple" %}

So our Jack Straw triple, in more human-readable form, could be represented like this:

{% include figure.html filename="intro-to-linked-data-fig6.png" caption="triple diagram showing that Jack Straw represented Blackburn" %}

Triples aren't normally a pleasure to read: they're meant for computers, not humans. LOD generally consists of lots and lots of these triples; machines have to do the work of reading them: we don't. We'll come back to triples shortly.

The numbers I gave for the two Jack Straws example we come from the [Virtual International Authority File](https://viaf.org) (VIAF), which is maintained by a consortium of libraries worldwide to try to address the problem of the myriad ways in which the same person might be referred to. The unique identifier I used for the Blackburn constituency came from *[The Dilipad project](http://dilipad.history.ac.uk) (on which I worked), which aimed to produce LOD for things like MPs' party affiliation and constituencies. Notice that we had to represent the fact that constituencies changes their boundaries over time: Jack Straw represented the constituency known as "Blackburn" in its post-1955 incarnation; there were other, slightly different, constituencies with the same name in earlier times. 

Unfortunately, it is not always obvious which of the published lists online is best to use: one might be more widely used than another, but the latter might be more comprehensive for a particular purpose. There will also be cases where you can't find a dataset with that information: imagine if you wanted to write triples about yourself and your immediate family relationships; in this case you would have to invent your own identifiers. 

*[Tim Berners-Lee](https://en.wikipedia.org/wiki/Tim_Berners-Lee)*, who came up with a way of linking documents together over a network, and thus created the World Wide Web, has long been a leading proponent of LOD. To encourage more use of LOD he has suggested a *[five-star rating system](https://www.w3.org/DesignIssues/LinkedData.html)* to encourage everyone to move as far towards LOD as possible. In essence, it's good to publish data openly at all, especially if it uses open formats and public standards, but best of all if it links to other people's data too.

For now there are three key points to remember from this part of the course:

-   LOD must be open and available to anyone on the internet
-   LOD tries to standardise ways of referring to things
-   LOD consists of triples which describe relationships


## The URI

An essential part of LOD is the [Uniform Resource Identifier](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier), or URI. All this means is that we just need a way of talking about something (a person, an object, a relationship, whatever) in a way which: - is usable by everyone in the world - is reliably unique

In the previous section we used two different numbers to identify our two different Jack Straws.

    person="15601"

    person="19385"

The problem is that around the world there are many databases that contain people with these numbers, and they're probably all different people. Outside of our immediate context these numbers don't identify unique individuals. Let's try to fix that. Here are these same identifiers but as URIs:

    http://data.history.ac.uk/tobias-project/person/15601

    http://data.history.ac.uk/tobias-project/person/19385

That looks a lot like a web address ([Uniform Resource Locator](https://en.wikipedia.org/wiki/Uniform_Resource_Locator)), better known as a URL, but it's actually a URI. To see that, try pasting it into a web browser and seeing if it takes your browser to a page. It doesn't because, although it is structured like a URL it isn't one. To put it bluntly, a URL is a URI but a URI is not necessarily a URL. URLs are subsets of URIs. A URI can describe anything, anything at all; a URL describes the location of something on the web.

Why the confusing state of affairs?

There are many websites round the world with pages called things like `/home` or `/faq`. But there is no confusion because the first part of the URL makes all of these pages unique. In the address `http://www.bbc.co.uk/faqs` it is the `bbc.co.uk` part which makes the subsequent pages unique. This is called the [domain](https://en.wikipedia.org/wiki/Domain_name).

This is so obvious to people who use the web all the time that they don't think about it. You probably also know that if you want to start a website called `bbc.co.uk` you can't, because that name has already been registered with the appropriate authority, which is the [Domain Name System](https://en.wikipedia.org/wiki/Domain_Name_System). The registration guarantees uniqueness. This naturally lends itself to creation of URIs, which also have to be unique.

Although I don't own the domain `history.ac.uk`, when I wanted to create some URIs I asked the webmaster if it was OK for me to use the domain + `tobias-project` to create some URIs. These URIs would be appropriate because the Tobias project was based at the Institute of Historical Research, which owns the domain `history.ac.uk`. The webmaster said I should use `data.history.ac.uk` instead, because he wanted to have a clear separation between URIs and URLs. I did that, knowing that no one else should ever be creating URIs with this same form, so I could be confident that they are unique. Let me be very clear that I _did not create any web pages_, I was creating URIs with an HTTP format.

The key point here is that most URIs you see will take a form that looks very much like a URL. Don't let it confuse you.

However it is possible to construct a URI differently. We have all kinds of ways of uniquely identifying people and things and, again, we rarely think or worry about it. Think of barcodes, a passport number, or even your postal address; in the developing world mobile phone numbers are frequently put up as shop signs precisely because they are unique. All of these could be used as URIs.

So a URL tells you the location of a web page or a file or something similar. A URI just does the job of identifying something. Just as the International Standard Book Number, or [ISBN](http://www.iso.org/iso/catalogue_detail?csnumber=36563)__978-0-1-873354-6 uniquely identifies a hardback edition of _Baptism, Brotherhood and Belief in Reformation Germany_ by Kat Hill but doesn't tell you where to get a copy; for that you would need something like a library [shelfmark](https://en.wikipedia.org/wiki/Accession_number_(library_science)), which gives you an exact location on a shelf of a specific library.

There is a little bit of jargon around URIs: people talk about whether they are, or are not, [dereferenceable](https://en.wikipedia.org/wiki/Reference_(computer_science)). That just means *can it be turned from an abstract reference into something else?* For example, if you paste a URI into the address bar of a browser, will it return something? For example a URI for Simon Schama is:

    http://viaf.org/viaf/46784579

If you put that into the browser you will get back a web page about Simon Schama. This is very handy - for one thing, it's not obvious from the URI who or even what this is. Similarly, if we treated a mobile phone number (with international code) as the URI for a person then it should be dereferenceable: someone might answer, and it might even be Schama.

But this is not essential. Lots of URIs are not dereferenceable.

The VIAF example leads us on to another important thing about URIs: don't make them up unless you have to. People and organisations have
been making concerted efforts to construct good URI lists and LOD isn't going to work at all if people start making up their own willy-nilly. For example VIAF has the support of many international libraries. If you want to construct URIs for people VIAF is a very good choice. If you can't find some people in VIAF, or other authority lists, then you might need to make up your own.


## How LOD organises knowledge: ontologies


It might not have been obvious from the individual triples we looked at in Part 1, but LOD can answer complex questions. When you put triples together then they form a [graph](https://en.wikipedia.org/wiki/Conceptual_graph), because of the way that the triples interlink. Suppose we want to find a list of all the named people associated with Peasants' Revolt alongside Jack Straw. If the information is in the triples we can find out with a query (we'll look at this query language, called SPARQL, in Part 6).

This opens up all kinds of possibilities. Let's take a break from Jack Straw and choose a different example. The pianist Charles Rosen was a pupil of the pianist Moriz Rosenthal, who was a pupil of Franz Liszt. Let's now express that as two triples (we'll just stick to strings for the names instead of ID numbers, to make the examples more readable):

    "Franz Liszt" taughtPianoTo "Moriz Rosenthal" .
    "Moriz Rosenthal" taughtPianoTo "Charles Rosen" .

We could equally have created our triples this way:

    "Charles Rosen" wasTaughtPianoBy "Moriz Rosenthal" . 
    "Moriz Rosenthal" wasTaughtPianoBy "Charles Rosen" .

We're making up examples so we can do what we like, but if you want to link your data to other datasets in the 'linked data cloud' you should look at what conventions are used in those datasets and do the same.

Actually this is one of the most useful features of LOD: much of the work has been done for you. People have spent a lot of time developing ways of modelling information within a particular area of study and thinking about how relationships within that area can be represetned. These models are generally known as ontologies. An ontology is an abstraction that allows particular knowledge about the world to be represented. Ontologies, in this sense, are quite new and they were designed to do what a hiearchical [taxonomy](https://en.wikipedia.org/wiki/Taxonomy_(general) does (think of the classification of species in the [Linnean system](https://en.wikipedia.org/wiki/Linnaean_taxonomy), but more flexibly.

An ontology is more flexible because it is non-hierarchical. It aims to represent the fluidity of the real world, where things can be related to each other in more complex ways than are represented by a hierarchical tree-like structure; instead an ontology is more like a spider's web.

Whatever you are looking to represent with LOD, we suggest that you find an existing ontology and use it, rather than try to write your own. The main page here has [a list of some of the most popular vocabularies](http://semanticweb.org/wiki/Main\_Page.html).

In fact there is [an ontology for music](http://www.musicontology.com/). As well as a well-developed specification it also has some useful examples of its use: have a look at the [Getting started pages](http://www.musicontology.com/docs/getting-started.html). Some of this will probably be a bit opaque to you now, but it's good to get a sense of what LOD can look like (formats in which LOD can be written will be discussed later in the course).

Unfortunately I can't find anything that describes the relationship between a teacher and a pupil in the Music Ontology. But the ontology is published openly, so I can use it to describe other features of music and then create my own extension to the ontology; if I then publish my extension openly then others can use it if they wish. However, in this case Terhi Nurmikko-Fuller tells me that the [Linked Jazz project](https://linkedjazz.org/) allows us to use mentorOf, which sounds like it would work nicely in our case, and not just for jazz.

Now if you were studying the history of pianism you might want to identify many pianists who were taught by pupils of Liszt, to establish a kind of family tree and see if these 'grandchildren' of Liszt have something in common. You could research Liszt's pupils, make a big list of them, and then research each of the pupils and try to make lists of any pupils they had. With LOD you could (again, if the triples exist) write a query along the lines of:

    Give me the names of all pianists taught by x
         where x was taught the piano by Liszt

This would return all of the people in the dataset who were pupils of pupils of Liszt. Let's not get too excited: this query won't give us every pupil of every pupil of Liszt that *ever lived* because that information probably doesn't exist and doesn't exist within any existing set of triples. Dealing with real-world data shows up all kind of omissions and inconsistencies, which we'll see when we look at the biggest LOD set, [DBpedia](https://en.wikipedia.org/wiki/Data_structure), in part 6.

If you have used [relational databases](https://en.wikipedia.org/wiki/Relational_database) you might be thinking that they can perform the same function. In our Liszt case, the information about pianists described above is in a database [table](https://en.wikipedia.org/wiki/Table_(database)) called something like 'Pupils'.

|pupilID|teacherID|
|------|---------|
|31|17|
|35|17|
|49|28|
|56|28|
|72|40|

If you're not familiar with databases, don't worry. But you can probably still see that some pianists in this table had the same teacher (numbers 17 and 28). Without going into details, if Liszt is in this database table it would be fairly easy to extract the pupils of pupils of Liszt, using a [join](https://en.wikipedia.org/wiki/Join_(SQL)).

Indeed, relational databases can offer similar results to LOD. The big difference is that LOD can go further: it can link datasets that were created with no explicit intention to link them together. The use of RDF and URIs allows this to happen.

With any luck this section will have convinced you that, because of its structure, LOD can answer all kinds of questions that historians might pose.

## RDF and data formats

LOD uses a standard, defined by the [World Wide Web Consortium](https://www.w3.org/), or W3C, called *[Resource Description Framework](https://en.wikipedia.org/wiki/Resource_Description_Framework)*, or just RDF. Standards are useful as long as they are widely adopted - think of the metre or standard screw sizes - even if they are essentially arbitrary. RDF has indeed been widely adopted as the LOD standard.

You will often hear LOD referred to simply as RDF. We've delayed talking about RDF until now because, in itself, it's rather abstract. RDF is a [data model](https://en.wikipedia.org/wiki/Data_model) that describes how data is structured on a theoretical level. To put it another way, RDF /is/ an abstraction: how the abstraction is made into concrete reality is really up to the user.

So RDF tells you what you have to do but not exactly how you have to do it. So the insistence on using triples (rather than four parts, or two or nine, for example) is a rule in RDF. But when it comes to more practical matters you have some choices about implementation. These choices break down into two areas: the relationships your triples describe, and how you write things down.

### Serialisation

[Serialisation](https://en.wikipedia.org/wiki/Serialization) is the technical term for 'how you write things down'. Standard Chinese (Mandarin) can be written in traditional characters, simplified characters or Pinyin romanisation and the language itself doesn't change; similarly RDF can be written in various forms. Here we'll look at two: [Turtle](https://en.wikipedia.org/wiki/Turtle_(syntax)) and [RDF/XML](https://en.wikipedia.org/wiki/RDF/XML). There are others but we'll just look at two here,

You might well come across historical (or other) data in RDF. If you can recognise it you will know what it is and, I hope, find it a bit less intimidating. Also, if you know what format something is in you will be able to do a web search: there's a lot of help out there but knowing the right terms to search for is vital. Many resources offer their LOD databases for download and you may be able to choose which serialisation you want to download.

Another advantage in knowing what serialisation of RDF you are looking at it that you can then choose appropriate tools for working with it. For example, RDF can come serialised in [XML](https://en.wikipedia.org/wiki/XML). You can then use a tool or code library designed for parsing a particular format, which is helpful if you already know how to work with it.

The first syllable, Turtle, stands for *terse* and it's a pleasantly simple way of writing triples. RDF/XML is a bit more complicated but many people are familiar with XML and the same tools and techniques used for editing XML can be applied to editing RDF/XML triples too.

First we can define [prefixes](https://www.w3.org/TeamSubmission/turtle/#sec-tutorial) to be used throughout our data. This is like an alias or a shortcut and it saves us having to write out full URIs every time. Let's go back to one of the URIs we invented in the previous section:

    http://data.history.ac.uk/tobias-project/person/15601

We don't want to type this out every time we refer to this person (Jack Straw, you'll remember). So we just have to announce our shortcut:

    @prefix toby: <http://data.history.ac.uk/tobias-project/persons>

Then Jack is `toby:15601`, which is easier on the eye.

Let's now move from Jack Straw to William Shakespeare and use Turtle to describe some stuff about his works. We'll need to decide on the authority files to use, a process which, as mentioned above, is best gleaned from looking at other LOD sets. Here we'll use [Dublin Core](https://en.wikipedia.org/wiki/Dublin_Core), a library [metadata](https://en.wikipedia.org/wiki/Metadata) standard, as one of our prefixes, the [Library of Congress Control Number](https://en.wikipedia.org/wiki/Library_of_Congress_Control_Number) authority file for another, and the last one should be familiar to you:

    @prefix lccn: <http://id.loc.gov/authorities/names>
    @prefix dc: <http://purl.org/dc/elements/1.1/>
    @prefix viaf: <http://viaf.org/viaf>

    lccn:n82011242 dc:creator viaf:96994048 .

Note the spacing of the full point at the end there! This is Turtle's way of indicating the end. You don't technically have to have the space, but it does make it easier to read after a long string of characters.

Turtle also allows you to list triples without bothering to repeat each URI when you've only just used it. Let's add the date when scholars think Macbeth was written:

    @prefix lccn: 
    @prefix dc: <http://purl.org/dc/elements/1.1/>
    @prefix viaf: <http://viaf.org/viaf>

    lccn:n82011242 dc:creator viaf:96994048 ,
               dc:created "1606" .

Remember the structure of the triple, discussed in section 1? There we gave this example:

	1 person 15601 (the subject) 2 representedInUKParliament (the predicate) 3 "Blackburn" (the object)``

The key thing is that the predicate connects the subject and the object; it describes the relationship between them. The subject comes first in the triple, but that's a matter of choice, as we discussed with the example of people who were taught the piano by Liszt.

You can use a comma if the subject is the same but the predicate and object are different, or a semicolon if the subject and predicate are the same and only the object is different.

    no2010025398 dc:creator viaf:96994048 ;
                    viaf:12323361 .


Here we're saying that Shakespeare and John Fletcher (12323361) were both the creators of the work *The Two Noble Kinsmen*.

By contrast with Turtle, RDF/XML can look a bit weighty. To begin with, let's just convert one triple from the Turtle above, the one that says that Shakespeare was the creator of *The Two Noble Kinsmen*:


    no2010025398 dc:creator viaf:96994048 .

In RDF/XML, admittedly with the prefixes declared inside the XML snippet, this is:

<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:dc="http://purl.org/dc/terms/">
  <rdf:Description rdf:about="http://info:lccn/2010025398">
    <dc:creator rdf:resource="http://viaf.org/96994048"/>
  </rdf:Description>
</rdf:RDF>

Let's move on to a different example to show how RDF/XML combines triples and, at the same time, introduce [SKOS](https://en.wikipedia.org/wiki/Simple_Knowledge_Organization_System):

     <skosConcept rdf:about="http://www.ihr-tobias.org/concepts/21250/Abdication">
        <skos:prefLabel>Abdication</skos:prefLabel>
      </skosConcept>

Here we are saying that the SKOS concept `21250`, abdication, has a preferred label of "abdication".

Why use SKOS? SKOS stands for Simple Knowledge Organization System and is designed for encoding something like a thesaurus or a taxonomy, which is convenient because this is from a project to publish a [thesaurus of British and Irish History](http://www.history.ac.uk/projects/digital/tobias).

Just as with Turtle, we can add more triples but, by nesting predicates and objects inside the subject we don't have to repeat the subject. So let's declare that the narrower term in our subject hierarchy, one down from *Abdication* is going to be *Abdication crisis (1936)*:

     <skosConcept rdf:about="http://www.ihr-tobias.org/concepts/21250/abdication">
        <skos:prefLabel>Abdication</skos:prefLabel>
        <skos:narrower rdf:resource="http://www.ihr-tobias.org/concepts/19838/abdication_crisis_1936"/>
      </skosConcept>

This is instead of writing it all out more verbosely, like this:

     <skosConcept rdf:about="http://www.ihr-tobias.org/concepts/21250/abdication">
        <skos:prefLabel>Abdication</skos:prefLabel>
      </skosConcept>

     <skosConcept rdf:about="http://www.ihr-tobias.org/concepts/21250/abdication">
        <skos:narrower rdf:resource="http://www.ihr-tobias.org/concepts/19838/abdication_crisis_1936"/>
      </skosConcept>

If you're familiar with XML this will be like mother's milk to you. If you're not you might prefer a format like Turtle. But the advantage here is that in creating my RDF/XML I can use the usual tools available with XML, like dedicated XML editors and parsers, to check that my RDF/XML is correct. If you're not an XML person I recommend Turtle, for which you can use an [online tool](http://www.easyrdf.org/converter) to check your syntax is correct.

When we looked at ontologies earlier I suggested you have a look at the examples from [the Music Ontology](http://www.musicontology.com/docs/getting-started.html). I hope they didn't put you off. Have a look again now. This is still complicated stuff, but do they make more sense, or at least the Turtle examples?

One of the most approachable ontologies is Friend of a Friend, or [FOAF](https://en.wikipedia.org/wiki/FOAF_(ontology)). This is designed to describe people, and is, perhaps for that reason, fairly intuitive. If, for example, you want to write to tell me that this course is the best thing you've ever read, here is my email address expressed as triples in FOAF:

    @prefix foaf: <http://xmlns.com/foaf/0.1/> .

    :"Jonathan Blaney" foaf:mbox <mailto:jonathan.blaney@sas.ac.uk> .


## Querying RDF with SPARQL

For this final section we can finally interrogate some open LOD and actually see what you can do with it as a user.

The query language we use for LOD is called [SPARQL](https://en.wikipedia.org/wiki/SPARQL). It's one of those recursive acronyms beloved of techie people: *SPARQL Protocol and Query Language*.

As I mentioned at the beginning, Programming Historian has [a complete course](http://programminghistorian.org/lessons/graph-databases-and-SPARQL), by Matthew Lincoln, on using SPARQL. My final section here is just an overview of the basic concepts, and if SPARQL piques your interest you can get a thorough grounding from Matthew's course.

We're going to run our SPARQL queries on [DBpedia](https://en.wikipedia.org/wiki/SPARQL), which is a huge LOD set derived from Wikipedia. As well as being full of information that is very difficult to find through usual Wikipedia interface, it has several SPARQL "end points" - interfaces where you can type in SPARQL queries and get results from DBpedia's triples.

The SPARQL query interface I use is called [snorql](http://dbpedia.org/snorql/). These end points occasionally seem to go offline, so if you can find this one try searching for *dbpedia sparql* and you should find something similar.

If you go to the URL above you will see at first that a number of prefixes have already been declared for us, which is handy. You'll recognise some of the prefixes now too.

{% include figure.html filename="intro-to-linked-data-fig1.png" caption="snorql's default query box, with some prefixes declared for you" %}

In the query box below the prefix declarations you should see:

    SELECT * WHERE {
    ...
    }

If you've ever written a database query in Structured Query Language, [better known as SQL](https://en.wikipedia.org/wiki/SQL), this will look pretty familiar and it will help you to learn SPARQL. If not, don't worry: you'll pick it up. The keywords used here, SELECT and WHERE are not case sensitive, but some parts of a SPARQL query can be (see below), so I recommend that you stick to the given case throughout the queries in this course.

Here `SELECT` means *return something* and `*` means *give me everything*. `WHERE` introduces a condition, which is where we will put the details of what kinds of thing we want the query to return.

Let's start with something simple to see how this works. Paste (or, better, type out) this into the query box:

    SELECT * WHERE {
    :Lyndal_Roper ?b ?c
    }

Hit 'go' and, if you left the drop-down box as 'browse' you should get two columns labelled "b" and "c". (Note that here, searching for a string, case does matter: lyndal_roper will get you no results.)

{% include figure.html filename="intro-to-linked-data-fig2.png" caption="top of results lists for a query for all triples with 'Lyndal_Roper' as subject" %}

So what just happened? And how did I know what to type? 

I didn't, really, and that is one of the issues with SPARQL end points (an end point is a place on the internet where you can address SPARQL queries and get results back). When getting to know a dataset you have to try things and find out what terms are used. Because this comes from Wikipedia, and I was interested in what information on historians I could find, I went to the Wikipedia page for the historian [Lyndal Roper](https://en.wikipedia.org/wiki/Lyndal\_Roper).

The part at the end of the URL is `Lyndal_Roper` and I concluded that this string is likely to be how Roper is referred to in DBpedia. Because I don't know what else might be in triples that mention Roper I use `?a` and `?b`: these are just place-holders: I could equally well have typed ?whatever and ?you\_like and the columns would have had those headings. When you want to be more precise about what you are returning, it will be more important to label columns meaningfully.

Try your own SPARQL query now: choose a Wikipedia page and copy the end part of the URL, after the final slash, and put it in place of Lyndal\_Roper. Then hit 'go'.

From the information you get back from these results it's possible to generate more precise queries. This can be a bit hit-and-miss, at least for me, so don't worry if some don't work.

Back to the results for the query I ran a moment ago:

    SELECT * WHERE {
    :Lyndal_Roper ?b ?c
    }



I can see a long list in the column labelled _c_. These are all the attributes Roper has in DBpedia and will help us to find other people with these attributes. For example I can see ```http://dbpedia.org/class/yago/Historian110177150```. Can I use this to get a list of historians? I'm going to put this into my query but in third place (because that's where it was when I found it in the Lyndal Roper results. My query looks like this:

	SELECT * WHERE {
	?historian_name ?predicate <http://dbpedia.org/class/yago/Historian110177150>
	}
	
I've made a small change here. If this query works at all then I expect my historians to be in the first column, because 'historian' doesn't look like it could be a predicate: it doesn't function like a verb in a sentence; so I'm going to call my first results column 'historian_name' and my second (which I don't know anything about) 'predicate'.

Run the query. Does it work for you? I get a big list of historians.

{% include figure.html filename="intro-to-linked-data-fig3.png" caption="historians, according to DBpedia" %}

So this works for creating lists, which is useful, but it would much more powerful to combine lists, to get intersections of sests. I found a couple more things that might be interesting to query in Lyndal Roper's DBpedia attributes: <http://dbpedia.org/class/yago/WikicatBritishHistorians> and <http://dbpedia.org/class/yago/WikicatWomenHistorians>. It's very easy to combine these by asking a for a variable to be returned (in our case this is '?name') and then using that in multiple lines of a query. Note as well the space and full point at the end of the first line beginning with ?name:

	SELECT ?name
	WHERE {
	?name ?b <http://dbpedia.org/class/yago/WikicatBritishHistorians> .
	?name ?b <http://dbpedia.org/class/yago/WikicatWomenHistorians>
	}

It works! I get five results. There are five British, women historians in DBpedia... 

{% include figure.html filename="intro-to-linked-data-fig4.png" caption="British historians who are women, according to DBpedia" %}

Of course there are more than that, as we could easily show by substituting the name of, say, Alison Weir in our first Lyndal Roper query. This brings us to the problem with Dbpedia that I mentioned earlier: it's not very consistently marked up with structural information of the type DBpedia uses (remember the differences in the info boxes for Bloch and Braudel? These were referred to in the review questions for part 3). Our query can list some British women historians but it turns out that we can't use it to generate a meaningful list of people in this category. All we've found is the people in entries in Wikipedia that someone has decided to categorise as "British historian" and "woman historian".

With SPARQL on DBpedia you have to be careful of the inconsistencies of crowd-sourced material. You could use SPARQL in exactly the same way on a more curated dataset, for example the UK government data: [https://data-gov.tw.rpi.edu//sparql]() and expect to get more robust results (there is a brief tutorial for this dataset here: [https://data-gov.tw.rpi.edu/wiki/A\_crash\_course\_in\_SPARQL]()

However, despite its inconsistencies, DBpedia is a great place to learn SPARQL. This has only been an a brief introduction but there is much more in [Using SPARQL to access Linked Open Data](http://programminghistorian.org/lessons/graph-databases-and-SPARQL).

## Further reading and resources

Dean Allemang and James Hendler, *Semantic Web for the Working Ontologist*, 2nd edn, Elsevier, 2011
Tim Berners-Lee [Linked Data](https://www.w3.org/DesignIssues/LinkedData.html)
Bob DuCharme, *Learning SPARQL*, O'Reilly, 2011
[Bob DuCharme's blog](http://www.snee.com/bobdc.blog/) is also worth reading
Richard Gartner, *Metadata: Shaping Knowledge from Antiquity to the Semantic Web*, Springer, 2016
Seth van Hooland and Ruben Verborgh, *Linked Data for Libraries, Archives and Museums*, 2015
Also see the book's [companion website](http://freeyourmetadata.org/)
Matthew Lincoln ['Using SPARQL to access Linked Open Data'](http://programminghistorian.org/lessons/graph-databases-and-SPARQL)
[Linked Data guides and tutorials](http://linkeddata.org/guides-and-tutorials)
Dominic Oldman, Martin Doerr and Stefan Gradmann, 'Zen and the Art of Linked Data: New Strategies for a Semantic Web of Humanist Knowledge', in *A New Companion to Digital Humanities*, edited by Susan Schreibman et al.
Max Schmachtenberg, Christian Bizer and Heiko Paulheim, [State of the LOD Cloud 2017](http://linkeddatacatalog.dws.informatik.uni-mannheim.de/state/)
David Wood, Marsha Zaidman and Luke Ruth, *Linked Data: Structured data on the Web*, Manning, 2014

## Acknowlegements

I'd like to thank my two peer reviewers, Matthew Lincoln and Terhi Nurmikko-Fuller, and my editor, Adam Crymble, for generously spending time helping me to improve this course with numerous suggestions, clarification and corrections.
