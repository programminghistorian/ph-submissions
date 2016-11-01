---
title: Introduction to Linked Data
authors:
- Jonathan Blaney
date: 2016-11-01
layout: default
difficulty: 1
---

Introduction. What this course covers and what it does not
----------------------------------------------------------

This course is a brief and concise introduction to linked open data. It
should give you a clear understanding of linked open data, how it is
used and how it is created. It has six parts:

1 Linked data: what is it? 2 Why is it useful? 3 Why haven't I heard of
it, then? 4 The URI 5 RDF and data formats 6 Querying linked data with
SPARQL

Don't worry: those acronyms will be explained as they arise.

We expect the course to take two or three hours to complete. If you've
heard of linked open data before you might complete it more quickly. If
this is all new you might find that it's rather abstract the first time
round. Really the best way to learn about linked data is to mess around
with some!

What we're *not* covering is the semantic web proper, which involves
things like semantic reasoning over datasets. An example of semantic
reasoning would be something like "Danny Millum is the son of Trevor
Millum and Valerie Fox is the sister of Trevor Millum". A semantic
reasoner should then be able to deduce a new fact: Danny Millum is the
nephew of Valerie Fox.

We hope you enjoy the course.

1. Linked data. What is it?
---------------------------

The two essential ideas of linked data are: \* use a universal format \*
publish your data openly

By openly I mean for anyone to use (i.e. available without paying a fee)
and in a format that does not require proprietary software.

If datasets are published for all to use, and they all use the same
format, then it will be possible for someone to interrogate all of the
data at once. This is clearly much more powerful than individual
datasets dotted around in what are known as silos. The data must be
structured the same way and use the same means of referring to the same
thing. For example, let's say we have data in this format:

    person="number"

If everybody who creates a dataset that mentions that person uses the
*exactly the same number* and in *exacty the same format* to refer to
that person, then we can reliably find them in all of those datasets.
Let's make up an example using Anne Hathaway.

Let's make Anne Hathaway, the film star `15601`:

    person="15601"

And let's make Anne Hathaway, Shakespeare's wife, `19385`:

    person="19385"

We can now search for person `15601` and, providing the data is
correctly marked up, know that we are getting the same person - in this
case, the film star - every time.

At this point you might be thinking, "that's what a library catalogue
does". It's true that the key idea here is that of the authority file,
which is central in library science (an authority file is a definitive
list of terms which can be used in a particular context, for example
when cataloguing a book). A library catalogue could be linked data but
an authority file alone does not contain the next, key step in creating
linked data:

The next step is to have a way of *describing* the relationship of Anne
Hathaway, our `15601`, to something else. Suppose we have a film that
Anne Hathaway acted in. How do we indicate that? In linked data this is
done using a 'triple'. Let's make one up now:

    person:"15601", role:actedIn, film:"One Day"

The triple, not surprisingly, has three parts. These are conventionally
referred to as subject, predicate and object:

1 person 15601 (the subject) 2 actedIn (the predicate) 3 "One Day" (the
object)

Hold on a minute! There's more than one film called *One Day*. Let's fix
that with another arbitrary number: `873823`.

    person="15601", actedIn, film="873823"

As you can see, this triple is *horrible* to read. That's because
triples aren't meant for humans to read but for computers. Linked data
consists of lots and lots of these triples; machines have to do the work
for reading them: we don't. We'll come back to triples later. For now
there are three key points to remember from this part of the course:

-   Linked data must be open and available to anyone on the internet
-   Linked data tries to standardise ways of referring to things
-   Linked data consists of triples which describe relationships

Review questions
----------------

1.  Here's a link to Anne Hathaway in the *Oxford Dictionary of National
    Biography*. [http://www.oxforddnb.com/view/article/25200/89951]() Is
    this linked open data? **NB** the ID used for Anne Hathaway here is
    `89951`.
2.  Look up Anne Hathaway in the Virtual International Authority File:
    [https://viaf.org.]() How many personal names do you find?
3.  What is the famous actress Anne Hathaway's ID on VIAF?
4.  Invent a triple that states that Albert Einstein originated the
    theory of Special Relativity. Use Einstein's VIAF ID.

### Reveals for questions

1.  No. The ODNB is a subscription resources so it can't be *open* data.
2.  12 at the time of writing the course. One of these seems to be a
    duplicate, but of which other one?
3.  80639285
4.  There are lots of ways of doing this, eg: VIAF-75121530
    originatedIdea "Special Relativity" or "Special Relativity"
    developedBy VIAF-75121530

Don't worry about the fine details. It's the concept which matters.
2. Why is it useful?
--------------------

Linked data uses a standard, defined by the World Wide Web Consortium,
or W3C, called *Resource Description Framework*, or just RDF. Standards
are useful as long as they are widely adopted - think of the metre or
standard screw sizes - even if they are essentially arbitrary. RDF has
indeed been widely adopted as the linked data standard (see Part 3 for
some examples). We'll get into the nuts and bolts of RDF later on, but
one of the reasons linked data is useful is simply that it is widely
used.

Linked data is also lightweight. Our triple:

    person="15601", acted in, film="873823"

Is 40 bytes worth of memory. Linked data consists of triple stores which
are simply files containing millions of triples. These can be circulated
pretty easily as plain text files and read by *different software* -
this is an important aspect of open data that we didn't mention earlier.
Open linked data that needs a proprietary format, and thus the user has
to buy some software, to read it isn't open at all.

It might not have been obvious from the individual triples we looked at
in Part 1, but linked data can answer questions that other data cannot.
If you get a lot of triples together then they form a sort of web of
knowledge, because of the way that the triples interlink. Suppose we
want to find out which films both Anne Hathaway and Meryl Streep
appeared in. If the information is in the triples we can find out with a
query (we'll look at this query language, called SPARQL, in Part 6).

This opens up all kinds of possibilities. Let's take a break from Anne
Hathaway and choose a different example. The pianist Charles Rosen was a
pupil of the pianist Moriz Rosenthal, who was a pupil of Franz Liszt.
Let's now express that as two triples (we'll just stick to strings for
the names instead of ID numbers, to make the examples more readable):

    "Franz Liszt" taughtPianoTo "Moriz Rosenthal"
    "Moriz Rosenthal" taughtPianoTo "Charles Rosen"

We could equally have created our triples this way:

    "Charles Rosen" wasTaughtPianoBy "Moriz Rosenthal"
    "Moriz Rosenthal" wasTaughtPianoBy "Charles Rosen"

We're making up examples so we can do what we like, but if you want to
link your data to other datasets in the 'linked data cloud' you should
look at what conventions are used in those datasets and do the same.

Now if you were studying the history of pianism you might want to
identify many pianists who were taught by pupils of Liszt, to establish
a kind of family tree and see if these 'grandchildren' of Liszt have
something in common. You could research Liszt's pupils, make a big list
of them, and then research each of the pupils and try to make lists of
any pupils they had. With linked data you could (again, if the triples
exist) write a query along the lines of:

    Give me the names of all pianists taught by x
         where x was taught the piano by Liszt

This would return all of the people in the dataset who were pupils of
pupils of Liszt. Let's not get too excited: this query won't give us
every pupil of every pupil of Liszt that *ever lived* because that
information probably doesn't exist and doesn't exist within any existing
set of triples. Dealing with real-world data shows up all kind of
omissions and inconsistencies, which we'll see when we look at the
biggest linked data set, DBpedia, in part 6.

With any luck this section will have convinced you that linked data can
answer questions that other datasets cannot. This is because it is
effectively a web, and using a query language (SPARQL) you can make all
kinds of journeys around that web to make new connections.

Review questions
----------------

1.  Have a look at the excellent Mathematics Genealogy Project:
    [https://www.genealogy.math.ndsu.nodak.edu/]() This is a
    mathematical version of our family tree of pianists. Does it use
    linked data to create its family tree?
2.  Find a mathematical family tree (**hint** Emmy Noether is always a
    good place to start) of two generations or more; model a few of
    those relationships as triples. **NOTE** that the URL of each
    mathematician's page contains their ID, so Emmy Nother is 6967.
3.  How many 'grandchildren' does Donald Knuth have?
4.  Wouldn't it be easier to have found that out using a linked data
    query?

### Reveals for part 2 questions

1.  It doesn't look like it. The search form doesn't allow any of the
    complex queries that linked data would support. Remember the
    question about pupils of pupils of Liszt? We'll go into detail in
    later sections about how to write these queries.
2.  If you used triples, you probably got this right? The wording
    doesn't matter. You could have done:

        mathematician6967 supervised mathematician20836
        mathematician20836 supervised mathematician29845
        mathematician29845 supervised mathematician29774
        mathematician29774 supervised mathematician187929

3.  I make it 64. I could only get this by looking at all the children
    of Knuth's children and counting them manually. If larger numbers
    were involved that wouldn't be possible.
4.  Yes!


3. Why haven't I heard of it, then?
===================================

You've probably had better things to do with your time. Until now.

But you have probably used, or been part of, lots of linked data
products and resources. The BBC's coverage of the London Olympics in
2012 was built upon linked data principles. As [this blog post]() makes
clear, the linked data part was so that they could connect up all of the
BBC's information about the Olympics. With coverage of something as
complex as the Olympic Games by a major news organisation, you can see
that there has to be some way to manage the data.

For example, if there was a story about Usain Bolt it would clearly be
useful if that story could automatically link to other content about
Bolt: not just stories but video, audio, images or datasets. But there's
more. The BBC has invested in linked data across the board, so that its
work will be enriched by linked data connection across all topics, not
just sport, and across years, not just for the duration of an event.

Here's another use. What happens if you type *cat* into Google's
websearch? Try it.

I get a box in the right-hand corner telling me that a cat is a small
carnivorous mammal, along with other information, such as its gestation
period of 64-67 days. Google uses its Knowledge Graph to generate this
kind of information from multiple sources. This is part of its attempt
to move beyond string matching techniques (where if you search for "cat"
Google simply searches for documents containing the letters c, a, and t
in that order) towards trying to understand what users mean by a query.
The knowledge graph uses linked open data, along with other things. A
'graph' in this context is simply a way of connecting lots of things: if
you imagine a diagram of the world's airline routes, with lines
connecting every airport you can fly between, you'll get the idea.

What Google does is proprietary and somewhat mysterious. The extent that
they use linked data is not clear: see this sceptical [blog post]() by
Daniel Lemire for a counter-view.

Facebook and Microsoft have similar graphs. Why are they doing this?
Well Facebook's [information for developers]() gives you a clue. These
documents tell app developers how they can use the precise targeting
Facebook offers advertisers; its case study for Shazam says, "With the
goal of monetizing its app in manner that felt like a natural part of
the user experience, Shazam implemented a native ad unit with the
Audience Network."
[https://developers.facebook.com/docs/audience-network/case-studies/shazam]()

If you've ever wondered how companies target you with particular ads,
then linked data is one of the tools they use.

Linked data is also used in lots of academic projects. It's good for
modelling messy data in a non-hierarchical way. Here's a good example:
medieval motets were mash-ups of sacred and secular texts and music.
Mapping all the connections between them would look something like a
tube map. Sound familiar? You can read about the rationale for using
linked open data for the job [here.]()

A final example you have almost certainly seen is on Wikipedia. The
entry for [Seinfeld]() has a box (it appears on the right-hand side of
my screen). This is structured data. Because of its structure it can be
extracted and made into triples. Those triples can be found, and
queried, here: [http://wiki.dbpedia.org/]() We'll be looking at DBpedia,
and how we can use it to find information *within Wikipedia* that you
cannot find just by searching Wikipedia. This really is linked data in
action.

In summary, then, most people haven't heard of linked data but it is
used extensively, just mostly behind the scenes.

Review questions
----------------

1.  Type your name into Google. Do you get a knowledge graph result?
2.  Compare Wikipedia's info boxes for Ernest Hemingway and Mark Twain.
    What does the comparison reveal?
3.  Why would linked data be a good way of mapping medieval motets?

### Answer reveals

1.  Probably not, unless you share a name with, say, Googie Withers.
    You're probably not famous enough to be listd in the sources Google
    is drawing upon.
2.  They don't have exactly the same information. For example, Twain's
    nationality is given but Hemingway's is not (at the time
    of writing). This is an issue with DBpedia! We'll come back to it.
3.  Because they're messy - in terms of borrowing data from all over the
    place - and non-hierarchical. This kind of thing, where nothing is
    intrinsically more important than anything else, is ideal for
    triples and linked open data.

Part 4. The URI
---------------

An essential part of linked open data is the Uniform Resource
Identifier, or URI. All this means is that we just need a way of talking
about something (a person, an object, a relationship, whatever) in a way
which: - is usable by everyone in the world - is reliably unique

That means we're all talking about the same thing, and only that thing.
It's more complicated than it sounds; in real life we do this all the
time without worrying about it.

Back in section 1 of this course we used two different numbers to
identify our two different Anne Hathaways.

    person="15601"

    person="19385"

The problem is that around the world there are many databases that
contain people with these numbers, and they're probably all different
people. Outside of our immediate context these numbers don't identify
unique individuals. Let's try to fix that. Here are these same
identifiers but as URIs:

    http://data.history.ac.uk/tobias-project/person/15601

    http://data.history.ac.uk/tobias-project/person/19385

That looks a lot like a URL but it's a URI. To see that, try pasting it
into a web browser and seeing if it takes your browser to a page. It
doesn't because, although it is structured like a URL it isn't one. To
put it simply, a URL is a URI but a URI is not necessarily a URL. URLs
are subsets of URIs. A URI can describe anything, anything at all; a URL
describes the location of something on the web.

Why the confusing state of affairs?

There are many websites round the world with pages called things like
`/home` or `/faq`. But there is no confusions because the first part of
the URL makes all of these pages unique. In the address
`http://www.bbc.co.uk/faqs` it is the `bbc.co.uk` part which makes the
subsequent pages unique. This is called the domain.

This is so obvious to people who use the web all the time that they
don't think about it. You probably also know that if you want to start a
website called `bbc.co.uk` you can't, because that name has already been
registered with the appropriate authority, which is the Domain Name
System. The registration guarantees uniqueness. This naturally lends
itself to creation of URIs, which also have to be unique.

I don't own the domain `history.ac.uk` but I asked the webmaster if it
was OK for me to use the domain + `tobias-project` to create some URIs.
I know that no one else should ever be creating URIs with this same
form, so I can be confident that they are unique.

The key point here is that most URIs you see will take a form that looks
very much like a URL. Don't worry too much about it.

However it is possible to construct a URI differently. We have all kinds
of ways of uniquely identifying people and things and, again, we rarely
think or worry about it. Think of barcodes, National Insurance Numbers
or even your postal address; in the developing world mobile phone
numbers are frequently put up as shop signs precisely because they are
unique. All of these could be used as URIs.

So a URL tells you the location of a web page or a file or something
similar. A URI just does the job of identifying something. Just as a
barcode 9-788433-910400 uniquely identifies a paperback edition of
**Estrella distante** by Roberto Bolano but doesn't tell you where to
get a copy; for that you would need something like a library shelfmark.

There is a little bit of jargon around URIs: people talk about whether
they are, or are not, *dereferenceable*. That just means \*can it be
turned from an abstract reference into something else. For example, if
you paste a URI into the address bar of a browser, will it return
something? For example a URI for Jeff Koons is:

    http://viaf.org/viaf/5035739

If you put that into the browser you will get back a web page about Jeff
Koons. This is very handy - for one thing, it's not obvious from the URI
who or even what this is. Similarly, if we treated a mobile phone number
(with international code) as URI for a person then it should be
derefrenceable: someone might answer, and it might even be Jeff Koons.

But this is not essential. Lots of URIs are not dereferenceable. Don't
worry too much about this term, but if you see it you'll know what it
means.

The VIAF example leads us on to another important thing about URIs:
don't make them up unless you have to. People and organisations have
been making concerted efforts to construct good URI lists and linked
open data isn't going to work at all if people start making up their own
willy-nilly. For example VIAF has the support of many international
libraries. If you want to construct URIs for people VIAF is a very good
choice. If you can't find some people in VIAF, or other authority lists,
then you might need to make up your own.

review questions
----------------

1.  Is a library shelfmark a URI?
2.  If so, is it dereferenceable?
3.  What URI would you use for Nelson Mandela?
4.  Have a look at the Wikipedia page for the red fox (*Vulpes vulpes*).
    Can you construct a URI for it?

### Answer reveals

1.  Probably not all by itself. But if it's combined with a unique
    library ID number, then yes.
2.  Unless the book is missing or on loan, then you would hope so!
3.  Why not use VIAF? https://viaf.org/viaf/98029748/ 4. Although
    *Vulpes vulpes* is a unique identifier for the species, it's not
    clear that this is used in any published URIs. At the bottom of the
    page there are various authority lists that we might use. The GND
    authority lists looks like a good one, and is
    dereferenceable: http://d-nb.info/gnd/4178532-0.

Part 5. RDF and data formats
============================

You will often hear linked data referred to as RDF. We've delayed
talking about RDF until now because, in itself, it's rather abstract.
RDF is a data model not, say, a syntax. To put it another way, RDF is an
abstraction: how the abstraction is made into concrete reality is really
up to the user.

So RDF tells you what you have to do but not exactly how you have to do
it. So the insistence on using triples (rather than quads, for example)
is a rule in RDF. But when it comes to more practical matters you have
some choices about implementation. These choices break down into two
areas: - the schema that you use (the relationships your triples
describe) - how you write them down

Serialisation
-------------

This is the technical term for 'how you write them down'. Standard
Chinese (Mandarin) can be written in traditional characters, simplified
characters or Pinyin romanisation and the language itself doesn't
change; similarly RDF can be written in various forms. Here we'll look
at two: Turtle and RDF/XML. There are others but we'll just look at two
here,

The first syllable of Turtle stands for *terse* and it's a pleasantly
simple way of writing triples. RDF/XML is a bit more complicated but
many people are familiar with XML and the same tools and techniques used
for editing XML can be applied to editing RDF/XML triples too.

First we can define prefixes to be used throughout our data. This is
like an alias or a shortcut and it saves us having to write out full
URIs every time. Let's go back to one of the URIs we invented in the
previous section:

    http://data.history.ac.uk/tobias-project/person/15601

We don't want to type this out every time we refer to this person (Anne
Hathaway, you'll remember). So at the top of the file we'll announce our
shortcut:

    @prefix toby: <http://data.history.ac.uk/tobias-project/persons>

Then Anne is simply `toby:15601`, which is easier on the eye.

Let's now move from Anne Hathaway to William Shakespeare and use Turtle
to encode some stuff about his works. We'll use Dublin Core, a library
metadata standard, as one of our prefixes, the Library of Congress
Control Number authority file for another, and the last one should be
familiar to you:

    @prefix lccn: <http://id.loc.gov/authorities/names>
    @prefix dc: <http://purl.org/dc/elements/1.1/>
    @prefix viaf: <http://viaf.org/viaf>

    lccn:n82011242 dc:creator viaf:96994048 .

Note the spacing of the full point at the end there! This is Turtle's
way of indicating the end. You don't technically have to have the space,
but it does make it easier to read after a long string of characters.

Turtle also allows you to combine triples without bothering to repeat
each URI when you've only just used it. Let's add the date when scholars
think Macbeth was written:

    @prefix lccn: 
    @prefix dc: <http://purl.org/dc/elements/1.1/>
    @prefix viaf: <http://viaf.org/viaf>

    lccn:n82011242 dc:creator viaf:96994048 ,
               dc:created "1606" .

You can use a comma if the subject is the same but the predicate and
object are different, or a semi-colon if the subject and predicate are
the same and only the object is different.

    no2010025398 dc:creator viaf:96994048 ;
                    viaf:12323361 .

Here we're saying that Shakespeare and John Fletcher (12323361) were
both the creators of the work *The Two Noble Kinsmen*.

By contrast with Turtle, RDF/XML can look a bit weighty. Here's an
example:

     <skosConcept rdf:about="http://www.ihr-tobias.org/concepts/21250/Abdication">
        <skos:prefLabel>Abdication</skos:prefLabel>
      </skosConcept>

Here we are saying that the SKOS concept `21250`, abdication, has a
preferred label of "abdication".

What's a SKOS concept? That brings us onto another area where RDF let's
us choose something important: the way in which we describe things. You
can make up your own, which is what we've done from time to time in this
course, but it's usually more sensible to use one that has already been
written. Clearly if you are describing marine fauna you would want to
use a different classification system than if you were describing
Etruscan tombs.

Here we are using SKOS (Simple Knowledge Organization System), which is
designed for encoding something like a thesaurus or a taxonomy, which is
convenient because this is from a project to publish a thesaurus of
British and Irish History:
[http://www.history.ac.uk/projects/digital/tobias]()

Just as with Turtle, we can add more triples but, by nesting predicates
and objects inside the subject we don't have to repeat the subject. So
let's declare that the narrower term in our subject hierarchy, one down
from *Abdication* is going to be *Abdication crisis (1936)*:

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

If you're familiar with XML this will be like mother's milk to you. If
you're not you might prefer a format like Turtle. But the advantage here
is that in creating my RDF/XML I can use the usual tools available with
XML, like dedicated XML editors and parsers, to check that my RDF/XML is
correct.

Whatever you are looking to represent with linked open data, we
recommend that you find an existing ontology and use it, rather than try
to write your own. Have a look at the main page here for a list of some
of the most popular vocabularies:
[http://semanticweb.org/wiki/Main\_Page.html]()

One of the most approachable is Friend of a Friend, or FOAF. This is
designed to describe people, and is, perhaps for that reason, fairly
intuitive. If, for example, you want to write to tell me that this
course is the best thing you've ever read, here is my email address
expressed as triples in FOAF:

    @prefix foaf: <http://xmlns.com/foaf/0.1/> .

    :"Jonathan Blaney" foaf:mbox <mailto:jonathan.blaney@sas.ac.uk> .

### Questions

1.  Change the actress Anne Hathaway's URI to her VIAF URI, in Turtle
    (don't forget the prefix).
2.  Write out in Turtle a triple that says that Shakespeare wrote *The
    Winter's Tale* (you can get the LCCN number from the bottom of the
    Wikipedia page for the play).
3.  Which standard FOAF term expresses a relationship between two
    people?

### Answer reveals

1.  viaf:80639285
2.  `lccn:no2008022458 dc:creator viaf:96994048 .`
3.  `knows`; if this seems vague it is by design, to accommodate
    different types of relationships

Part 6. Querying RDF with SPARQL
================================

For this final section we can finally interrogate some open linked data
and actually see what you can do with it as a user.

The query language we use for linked data is called SPARQL. It's one of
those reflexive acronyms beloved of techie people: *Sparql Protocol and
Query Language*.

We're going to run our SPARQL queries on DBpedia, which is a huge linked
data set derived from Wikipedia. As well as being full of information
that is very difficult to find through usual Wikipedia interface, it has
several SPARQL "end points" - interfaces where you can type in SPARQL
queries and get results from a data set.

The one I use is called snorql: [http://dbpedia.org/snorql/]() These end
points occasionally seem to go offline, so if you can find this one try
searching for *dbpedia sparql* and you should find something similar.

If you go to the URL above you will see at first that a number of
prefixes have already been declared for us, which is handy. You'll
recognise some of the prefixes now too.

In the query box you should see:

    SELECT * WHERE {
    ...
    }

If you've ever written a database query in the query language SQL, this
will look pretty familiar and it will certainly help you to learn
SPARQL. If not, don't worry: you'll pick it up.

Here `SELECT` means *return something* and `*` means *give me
everything*. `WHERE` introduces a condition, which is where we will put
the details of what kinds of thing we want the query to return.

Let's start with something simple to see how this works. Paste (or,
better, type out) this into the query box:

    SELECT * WHERE {
    :Tony_Judt ?b ?c
    }

Hit 'go' and, if you left the drop-down box as 'browse' you should get
two columns labelled "b" and "c". So what just happened? And how did I
know what to type?

I didn't, really, and that is one of the issues with SPARQL end points.
You have to try things and find out what terms are used. Because this
comes from Wikipedia, and I was interested in what information on
historians I could find, I went to the Wikipedia page for Tony Judt:

[https://en.wikipedia.org/wiki/Tony\_Judt]()

The final bit after the slash is a very good bet: they're are likely to
be triples about Tony Judt, especially because this is a fairly large
article. The ?a and the ?b are just place-holders: I could equally well
have typed ?whatever and ?you\_like and the columns would have had those
headings. When you want to be more precise about what you are returning,
it will be more important to label columns meaningfully.

Try your own SPARQL query now: choose a Wikipedia page and copy the end
part of the URL, after the final slash, and put it in place of
Tony\_Judt. Then hit 'go'.

From the information you get back from these results it's possible to
generate more precise queries. This can be a bit hit-and-miss, at least
for me, so don't worry if some don't work.

I changed *Tony\_Judt* to *London* and ran the query again. Try that now
and have a look.

Towards the bottom of the columns produced I can see Mayor\_of\_London.
If you run the query and click on *Mayor\_of\_London* you will see that
a new SPARQL query is generated for you. This is very helpful. From the
query I can see that there is the term *dbpedia2:title* and the string
*:Mayor\_of\_London* (the colon with nothing before it means it's
locally declared, in other words this is just a string that DBpedia
happens to use. Let's put all of this into a query:

    SELECT *
    WHERE {
    ?a dbpedia2:title :Mayor_of_London
    }

This gives me four results, including two people: Ken Livingstone and
Boris Johnson. But wait, at the time of writing Sadiq Khan has been
Mayor of London for some months. Why isn't he in this list?

This brings us to the problem with Dbpedia that I mentioned earlier:
it's not very consistently marked up with structural information of the
type DBpedia uses (remember the differences in the info boxes for
Hemingway and Twain?) By the time you run the query, maybe Sadiq Khan
will appear in the results, but for now it's a warning to us not to
treat results as a faithful reflection of real life: they're a faithful
reflection of what is in the dataset, and as I type Sadiq Khan is not
listed as having the title Mayor of London in the triples.

Let's finish this section, and the course, with a slightly more
complicated example. Go back to the Tony Judt query and run it again.

    SELECT * WHERE {
    :Tony_Judt ?b ?c
    }

Go down the second column of results and you will see
`:Category:British_historians`. Click on it. If you scroll down you will
start to see a bit list of British Historians. This is useful but let's
combine our query with something else.

First, let's make sure that we understand the British Historians query
by simplifying it

    SELECT ?name
    WHERE {
    ?name ?b <http://dbpedia.org/resource/Category:British_historians> .
    }

The change I've made here is that instead of `SELECT *` I'm now saying
`SELECT ?name`. This means *just return the column that I'm calling
?name* (I could have called it something else).

The nice thing is that by repeating ?name in subsequent lines of the
query. So if I want to find British historians born in London I add a
line to filter the first query:

    SELECT ?name
    WHERE {
    ?name ?b <http://dbpedia.org/resource/Category:British_historians> .
    ?name dbpedia2:birthPlace :London .
    }

If I now want to restrict the list to women I need to know how to do
that, so I'll click on the link for Joan\_Thirsk, where I can see that
she's in in the category British\_women\_academics. Let's add another
line to our query:

    SELECT ?name
    WHERE {
    ?name ?b <http://dbpedia.org/resource/Category:British_historians> .
    ?name dbpedia2:birthPlace :London .
    ?name ?c <http://dbpedia.org/resource/Category:British_women_academics> .
    }

That's good, but, again, shows the limitations of the underlying data:
I'm not getting Mary\_Dorothy\_George or Alison\_Weir, who were in the
previous list of British historians born in London, because they are not
marked up as British women academics!

With SPARQL on DBpedia you have to be careful of the inconsistencies of
crowd-sourced material. You could use SPARQL in exactly the same way on
a more curated dataset, for example the UK government data:
[https://data-gov.tw.rpi.edu//sparql]() and expect to get more robust
results (there is a brief tutorial for this dataset here:
[https://data-gov.tw.rpi.edu/wiki/A\_crash\_course\_in\_SPARQL]()

However, despite its inconsisitencies, DBpedia is a great place to learn
SPARQL. See what you can find out using linked data!

### 

1.  Write a SPARQL query returning all the triples about the TV series
    *The Wire*.
2.  Can you use the information you gathered there to find out all the
    TV series with a theme by Tom Waits?

3.  Write a SPARQL query to list Mayors of London who born in London

### Answer reveals

1.  \`\`\` SELECT \* WHERE { :The\_Wire ?b ?c . }

<!-- -->

    2.

SELECT \* WHERE { ?a <http://dbpedia.org/ontology/openingTheme>
<http://dbpedia.org/resource/Tom_Waits> . }

    3.

SELECT ?name WHERE { ?name dbpedia2:title :Mayor\_of\_London . ?name
dbpedia2:birthPlace :London . }

\`\`\`
