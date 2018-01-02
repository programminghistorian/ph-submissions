---
title: |
    Introduction to stylometry with Python
authors:
- François Dominic Laramée
date: 2017-12-22
reviewers:
layout: lesson
---

# Introduction

Stylometry is the quantitative study of literary style. It is based on the observation that authors tend to write in relatively consistent, recognizable ways that differ from everyone else's. For example:

* Each person has their own unique vocabulary, sometimes rich, sometimes limited. Although a larger vocabulary is usually associated with literary quality, this is not always the case. Ernest Hemingway, for example, is famous for using a surprisingly small number of different words in his writing,[^1] which did not prevent him from winning the Nobel Prize for Literature in 1954. 
* Some people write in short sentences, while others prefer long blocks of text consisting of many clauses.
* No two people use semicolons, em-dashes, conjunctions and prepositions in the exact same way.

One of the most common applications of stylometry is in authorship attribution. Given an anonymous text, it is sometimes possible to guess who wrote it by measuring certain features (say, the average number of words per sentence or the propensity of the author to use "while" instead of "whilst") and comparing the numbers with those observed in texts for which the authors are known. This is what we will be doing in this lesson, using as our test case perhaps the most famous instance of disputed authorship in political writing history, that of (some of) the _Federalist Papers._

## Learning Outcomes

At the end of this lesson, we will have examined the following topics:

* How to download textual data from Project Gutenberg and prepare it for stylometric analysis.
* How to apply several stylometric methods to guess authorship of an anonymous text or set of texts.
* How to use relatively advanced data structures, including dictionaries of strings and dictionaries of dictionaries, in Python.
* The basics of NLTK, a popular Python module dedicated to natural language processing.

## Pre-requisites

Before you start this lesson, you may want to read *The Programming Historian*'s lessons on [Downloading Web Pages with Python](https://programminghistorian.org/lessons/working-with-web-pages), [Working with Text Files in Python](https://programminghistorian.org/lessons/working-with-text-files), and [Manipulating Strings in Python](https://programminghistorian.org/lessons/manipulating-strings-in-python) if you are unfamiliar with these topics or if you need a refresher. 

Please note, however, that these lessons were written in Python 2 whereas this one uses Python 3. The differences in syntax between the two versions of the language can be subtle. If you are confused at any time, follow the examples as written in this lesson and use the other lessons as background material only.

Also note that the code in this lesson uses several Python modules. Some of these modules may not be pre-installed on your computer, depending on what Python distribution you have. Should you encounter error messages like: "Module not found" or the equivalent, you will have to download and install the missing module(s) yourself. Please see *The Programming Historian*'s lesson on [Installing Python modules with pip](https://programminghistorian.org/lessons/installing-python-modules-pip) if you need help.

# (Optional Reading) The *Federalist Papers*

The *Federalist Papers* (also known simply as the *Federalist*) are a collection of 85 seminal political theory articles published between October 1787 and May 1788. These papers, written as the debate over the ratification of the Constitution of the United States was raging, presented the case for the system of government that the U.S. ultimately adopted and under which it lives to this day. As such, the *Federalist* is sometimes described as America's greatest and most lasting contribution to the field of political philosophy.

Three of the Early Republic's most prominent men wrote the papers:

* Alexander Hamilton, first Secretary of the Treasury of the United States (and unlikely 21st-century cultural phenomenon!)
* James Madison, fourth President of the United States and the man sometimes called the "Father of the Constitution" for his key role at the 1787 Constitutional Convention.
* John Jay, first Chief Justice of the United States, second governor of the State of New York, and diplomat.

## A Stylometric "Cause Célèbre"

However, *who* wrote *which* of the papers was a matter of open debate for 150 years, not least because of the authors themselves. 

First, because the *Federalist* was published anonymously, under the shared pseudonym "Publius". Anonymous publication was not uncommon in the eighteenth century, especially in the case of politically sensitive material, but shared use of a single pseudonym obviously muddied the water from the start. Making things worse is the fact that the three authors also wrote in close proximity, at the same time, on related topics, and using the same references.

Second, because Madison and Hamilton left conflicting testimonies regarding their roles in the project. In a famous 1944 article, historian Douglass Adair[^2] explained that neither man wanted the true authorship of some of the papers to be known during their lifetimes because they had come to regret some of the positions they had espoused in the *Federalist* after the Constitution came into effect and the country's political system evolved in a direction that they had not foreseen and that they viewed as dangerous. But as Hamilton prepared for his fatal 1804 duel with Aaron Burr, he left a handwritten note to a friend in which he claimed 63 of the 85 papers as his own work; probably, according to Adair, because the notoriously vainglorious Hamilton wanted to make sure that posterity would recognize him as the driving force behind the *Federalist*. Madison refuted some of Hamilton's claims, stating that *he* was the author of 12 of the papers on Hamilton's list and that we was the sole (or at least the principal) author of three more papers for which Hamilton had demanded equal credit. Unfortunately for us, Madison did so a decade after his rival's death, pretexting that it would have been unseemly of him to enter into a debate on the topic before he himself had retired from public life. In any case, the long-dead Hamilton was in no position to reply to Madison's belated counterargument, and no definite proof supporting either man's claims has emerged from the archive since.

Third, because in the words of David Holmes and Richard Forsyth,[^3] Madison and Hamilton had "unusually similar" writing styles at the best of times. Frederick Mosteller and Frederick Williams calculated that, in the papers for which authorship is not in doubt, the average lengths of the sentences written by the two men are both uncommonly high and virtually identical: 34.59 and 34.55 words respectively.[^4] The standard deviations in sentence lengths, also nearly identical, don't help much. Neither does the fact that, as Mosteller quipped in the paper just cited, neither man was known to use a short word when a long one would do.

It wasn't until 1964 that Mosteller and David Lee Wallace[^5], using word usage statistics, came up with a relatively satisfactory solution to the mystery. By comparing how often Madison and Hamilton used structural words like *may*, *also*, *an*, *his*, etc., they concluded that the disputed papers had all been written by Madison; even in the case of *Federalist 55*, the paper for which they said that the evidece was the least convincing, Mosteller and Wallace estimated the odds that Madison was the author at 100 to 1.  

Since then, the authorship of the *Federalist* has remained a common test case for machine learning algorithms.[^6] Stylometric analysis has also continued to use the *Federalist* to refine its methods, for example to look for signs of hidden collaborations between multiple authors in a single text.[^7] Interestingly, some of the results of this research suggest that the answer to the *Federalist* mystery isn't quite as clear-cut as Mosteller and Wallace thought, and that Hamilton and Madison may have co-written more of the *Federalist* than we ever suspected.  

# Our Test Cases

In this lesson, we will use the *Federalist* as a case study to demonstrate three different stylometric approaches. This will require splitting the papers into six categories: 

1. The 51 papers known to have been written by Alexander Hamilton.
2. The 14 papers known to have been written by James Madison.
3. Four of the five papers known to have been written by John Jay.
4. Three papers that were probably co-written by Madison and Hamilton and for which Madison claimed principal authorship.
5. The 12 papers disputed between Hamilton and Madison.
6. *Federalist 64* in a category of its own.

This division mostly follows Mosteller's lead[^8]. The one exception is *Federalist 64*, which everyone agrees was written by John Jay but which we keep in a separate category for reasons that will become clear later.

Our first two tests, using T. C. Mendenhall's characteristic curves of composition and Adam Kilgariff's chi-squared distance, will look at the 12 disputed papers as a group, to see whether they resemble Hamilton's writing or Madison's the most. Then, in our third and final test, we will apply John Burrows' Delta method to look at *Federalist 64* and to confirm whether it was, indeed, written by John Jay.

But first, we must obtain the text of the *Federalist* and prepare it for analysis.

# Acquiring the *Federalist* from Project Gutenberg

Project Gutenberg's web site provides access to a number of famous public domain texts. Confusingly, as of this writing, there are two transcribed versions of the *Federalist* in the Gutenberg archive, plus an audiobook version. How do we pick one to use for our computational analysis? Through visual inspection: as I read both transcribed versions, I noticed that one of them seemed better suited to computer processing because it had been transcribed in a more systematic fashion. Specifically, in this particular version, each paper begins with the FEDERALIST keyword in all caps, whereas there is some variance in the headers found in the other transcription. We will keep our task as simple as possible by using the better transcription, which is located at URL `http://www.gutenberg.org/cache/epub/1404/pg1404.txt`

Since Gutenberg frowns upon multiple requests for the same document, which overtax its resources, we will grab a copy of the text, using Python's `urllib` module, and store it
locally, using the `os` module that provides access to the operating system's facilities. This will allow us to process the data in any way we want, as often as we want, with minimal 
impact upon the archive's server. (This is nearly always a good policy, unless we are working with highly volatile data that loses its value if it is not refreshed on a regular basis.)

While we are at it, we will create a local directory in which to store the raw Gutenberg file and everything else that we will derive from it during the lesson. Here is the code needed to perform these two tasks:

```python
# Let's grab a copy of the Federalist Papers from Project Gutenberg's web site
import urllib.request
federalistURL = "http://www.gutenberg.org/cache/epub/1404/pg1404.txt"
federalistText = urllib.request.urlopen( federalistURL ).read().decode()

# Let's store the raw Federalist text locally, in a subdirectory called "data"
import os
directory = "data"
if not os.path.exists( directory ):
    os.makedirs( directory )
    
fic = open( "data/federalist.txt", "w" )
fic.write( federalistText )
fic.close()
```

Note that, if everything works as planned, the code snippet will only need to be run once, so you may want to store it in its own source file to separate it from the rest of the work we will be doing in the rest of the lesson.

<div class="alert alert-warning">
  If you are writing your Python code in Jupyter Notebooks, like I am, putting this code snippet in its own cell instead of in a separate script will be sufficient. Just make sure not to run the cell too often. It won't break anything, but it will annoy the fine folks at Project Gutenberg!
</div>

## Loading the raw Gutenberg file into memory

Now, in a separate script, we will load the *Federalist* data we just acquired, remove the header and footer material inserted by Project Gutenberg, and split the text into 85 different files, one for each of the papers. First, we load the entire file into a single text string object:

```python
# Load the raw Federalist text into a single (long) string
fic = open( "data/federalist.txt", "r" )
federalistText = fic.read( )
fic.close()
```

It is always a good idea to check whether an operation has succeeded before continuing our work, especially when dealing with files that may or may not have been deleted since the last time we read them. Let's see if we have actually obtained data by printing the first 200 characters in the ¨federalistText` string:

```python
# Make sure that what we have is the actual text in readable form
print( federalistText[ : 200 ] )
```

If everything went well, you should see something like this:
{% include figure.html filename="stylometry-python-1.jpg" caption="Figure1: The first 200 characters in the *Federalist* data file." %}

<div class="alert alert-warning">
I will omit checks like this from my code for the rest of the lesson in order to save space, but please feel free to insert them as needed.
</div>

## Stripping unnecessary header and footer material

If we read the raw Gutenberg text file, we notice that the actual Federalist papers begin with the first instance of the word FEDERALIST in all caps and that everything that precedes this word is made up of extraneous Gutenberg metadata. Similarly, there is a considerable amount of legalese and other footer material at the end of the file, starting appropriately enough with the sentence *End of the Project Gutenberg EBook of The Federalist Papers*. We need to strip this material from our data. Using Python's string manipulation functionality, this can be accomplished with three lines of code:

```python
# Strip Gutenberg's header and footer from the raw Federalist text
startIndex = federalistText.find( "FEDERALIST No." ) 
endIndex = federalistText.find( "End of the Project Gutenberg EBook of The Federalist Papers" )
federalistTextStripped = federalistText[ startIndex : endIndex ]
```

The `find()` function looks for the position of a piece of text in a string; here, we look for the start of the first Federalist paper and for the start of the footer material. Then, using a Python "slice" operation, we keep the subset of the Gutenberg data that begins with the first Federalist and ends just before the footer. In one fell swoop, we have eliminated all of the Gutenberg metadata.

## Splitting the Federalist into 85 files

We now have a long string object containing all 85 papers. We need to split them into their separate files before we can reassemble them into a Hamilton corpus, a Madison corpus, etc. Again, Python's string manipulation functionality provides a simple solution: divide the long string into 85 shorter strings, one for each paper, cutting wherever the *FEDERALIST No.* marker can be found:

```python
# Divide the Federalist data into 85 separate files
papersList = federalistTextStripped.split( "FEDERALIST No.", 85 )
```

Note that the `split()` function cuts out the markers, so that each entry in the `paperList` object will begin with the given paper's number instead of something like *FEDERALIST No. 5*. This is fine, but maybe a bit hard to read if we look at the files in the future. The following code snippet, which uses a Python list comprehension, cycles over each of the papers in the `papersList` object and restores its header to what it was before we split the original file. This step is optional but it will produce cleaner data.

```python
# Since split() removes the separator, let's return it to each paper by hand in case we end up using it sometime.
papersList = [ "FEDERALIST No." + paper for paper in papersList ]
```

<div class="alert alert-warning">
Reminder: a list comprehension is a compact way of representing a loop in Python. It is also much more computationally efficient than a regular loop, meaning that it runs faster. The one in the code snippet above means that we need to create a new list, made up of every `paper` string in `papersList` to which we will have prepended the "FEDERALIST No." marker.
</div>

Finally, we need to store the 85 papers into their own files. There is only one problem: `papersList` contains 86 objects. Why? Because `split()` divides the string in two every time it encounters the splitting marker; in our case, there are 85 instances of "FEDERALIST No." in the source data, therefore 86 strings in the split list. The first of these 86 strings is made up of whatever appears before the first "FEDERALIST No." marker (i.e., probably just a bunch of white space) and must be discarded. Again, we will use a slice to do so:

```python
# And now, save the files. Remember that the first entry in papersList is empty
# and that we need to discard it 
currentPaper = 1
for paper in papersList[ 1 : ]:
    currentPaperFileName = "data/federalist_{0}.txt".format( currentPaper )
    fic = open( currentPaperFileName, "w" )
    fic.write( papersList[ currentPaper ] )
    fic.close()
    currentPaper += 1
```

The unpleasant-looking `"data/federalist_{0}.txt".format( currentPaper )` snippet tells Python to insert the value of the numeric variable `currentPaper` into the file name being constructed, replacing `{0}` with it. The result is a data directory containing not only the original Gutenberg file, but also 85 text files named `federalist_1.txt, federalist_2.txt`, etc.

Now that we have 85 files containing our 85 papers, we are ready to assemble a corpus for analysis.

# Preparing the Data for Analysis

Before we can proceed with stylometric analysis, we need to construct data structures that contain the Madison papers, the Hamilton papers, the Disputed papers, etc. 

The first step in this process is to assign each of the 85 papers to the proper set. Since we have given our files standardized names containing the papers' numbers at a predictable location, we will be able to define a set of papers with a simple list of numbers.

```python
# Define the lists of papers in the sub-corpora
madisonPapersList = [ 10, 14, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]
hamiltonPapersList = [ 1, 6, 7, 8, 9, 11, 12, 13, 15, 16, 17, 21, 22, 23, 24, 25, 26, 27, 28, 29, \
                      30, 31, 32, 33, 34, 35, 36, 59, 60, 61, 65, 66, 67, 68, 69, 70, 71, 72, 73, \
                      74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85 ]
jayPapersList = [ 2, 3, 4, 5 ]
sharedPapersList = [ 18, 19, 20 ]
disputedPapersList = [ 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 62, 63 ]
jayTestCaseList = [ 64 ]
```
Next, we will define a short Python function that reads all of the papers in a set from disk and copies their contents into a single object. Since we are interested in an author's vocabulary rather than in the exact distribution of the words between the various papers that the author has written, we can concatenate all of this material into a single string.

```python
# A function that concatenates a list of text files into a single string
def read_files_into_string( fileList ):
    theString = ""
    for eachFile in fileList:
        fic = open( "data/federalist_{0}.txt".format( eachFile ), "r" )
        theString += fic.read()
        fic.close()
    return theString
```

Third, we build all of the data structures by repeatedly calling the `read_files_into_string()` function, passing it a different set of papers every time. We will store the results into a Python *dictionary* object. The dictionary is an unordered collection of key-value pairs; in this case, the keys are the names of the authors (or author-equivalents) and the values are the strings that contain all of the papers in the author's set. From now on, for simplicity's sake, we will refer to a set of papers as "the author's corpus", even if a set contains disputed or shared papers. 

```python
# Make a dictionary out of the sub-corpora
federalistByAuthor = dict()
federalistByAuthor[ "Madison" ] = read_files_into_string( madisonPapersList )
federalistByAuthor[ "Hamilton" ] = read_files_into_string( hamiltonPapersList )
federalistByAuthor[ "Jay" ] = read_files_into_string( jayPapersList )
federalistByAuthor[ "Shared" ] = read_files_into_string( sharedPapersList )
federalistByAuthor[ "Disputed" ] = read_files_into_string( disputedPapersList )
federalistByAuthor[ "TestCase" ] = read_files_into_string( jayTestCaseList )
```

Dictionaries are very flexible; for example, it is easier to index a dictionary than to manipulate several unrelated objects, especially when we want to perform multiple manipulations over different parts of the same data.

# First Stylometric Test: Mendenhall's Characteristic Curves of Composition

Literary scholar T. C. Mendenhall once wrote that an author's stylistic signature could be found by counting how often he or she used words of different lengths.[^9] One could count word lengths in a 1,000-word segment or a 5,000 word segment of any novel, for example; plot a graph of the value; and according to Mendenhall's theory the curve would look pretty much the same no matter what segment of the novel (or of any book by the same author) had been selected for counting. Indeed, Mendenhall thought that if one counted enough words of a writer's work (say, 100,000), the author's "characteristic curve" would become so precise that it would be constant over his or her lifetime.

Unfortunately for him (as those of you who have already checked the footnote may have noticed) Mendenhall was far ahead of his time since he published his theory *one hundred and thirty years ago* and had to make all of his calculations by hand. It is therefore understandable that he chose to work with word lengths, a rather coarse statistic that does not discriminate very much between vocabularies. We will work with finer-grained features later on in this lesson, but calculating Mendenhall's characteristic curves of composition is still a useful exercise, not least because, in Python, doing so literally requires fewer than ten lines of code (not counting comments):

```python
# Load the Natural Language Toolkit
import nltk

# Setup two more dictionaries for word tokens and for word length distributions
federalistByAuthorTokens = dict()
federalistByAuthorLengthDistributions = dict()

# Calculate the word length distribution in each paper
for subcorpus in [ "Hamilton", "Madison", "Disputed", "Jay", "Shared" ]:
    tokens = nltk.word_tokenize( federalistByAuthor[ subcorpus ] )
    
    # Filter out punctuation
    federalistByAuthorTokens[ subcorpus ] = [ token.lower() for token in tokens \
                                             if any (c.isalpha() for c in token) ]
   
    # Get a distribution of token lengths
    tokenLengths = [ len( token ) for token in federalistByAuthorTokens[ subcorpus ] ]
    federalistByAuthorLengthDistributions[ subcorpus ] = nltk.FreqDist( tokenLengths )
    federalistByAuthorLengthDistributions[ subcorpus ].plot( 15, title = subcorpus )
```
<div class="alert alert-warning">
If you are working in Jupyter Notebooks, you may need to insert the clause `%matplotlib inline` below `import nltk`, otherwise you may not see the graphs on your screen.
</div>

The first line in the code snippet above loads the *Natural Language Toolkit module (nltk)*, which contains an enormous number of useful functions and resources for text processing. We will barely touch its basics in this lesson; if you decide to explore text analysis in Python further, I strongly recommend that you start with nltk's documentation. 

The next two lines set up data structures that will be filled by the block of code within the `for` loop. This loop makes the same calculations for all of our "authors":

* It invokes nltk's _word_tokenize()_ method to chop an author's corpus into its component _tokens_, i.e., words, numbers, punctuation, etc.;
* It looks at this list of tokens, converts tham all to lowercase and filters out non-words;
* It creates a list containing the lengths of every word token that remains;
* It creates a _frequency distribution_ object from this list of word lengths, basically counting how many one-letter words, two-letter words, etc., there are in the corpus.
* It plots a graph of the distribution of word lengths in the corpus, for all words up to length 15.

<div class="alert alert-warning">
Quick note: we convert everything to lowercase so that we won't count tokens that begin with a capital letter (because they appear at the beginning of a sentence) separately from other tokens of the same word that do not. Sometimes this may cause a few errors, for example when a proper noun and a common noun are written the same way except for capitalization, but overall it increases accuracy.
</div>

The results should look like this:
{% include figure.html filename="stylometry-python-2.jpg" caption="Figure 2: Mendenhall's curves for Hamilton and Madison." %}
{% include figure.html filename="stylometry-python-3.jpg" caption="Figure 3: Mendenhall's curves for the disputed papers and for those written by Jay." %}
{% include figure.html filename="stylometry-python-4.jpg" caption="Figure 4: Mendenhall's curve for the papers co-authored by Madison and Hamilton." %}

As you can see from the graphs, the characteristic curve associated with the disputed papers looks like a compromise between Madison's and Hamilton's. The leftmost part of the disputed papers' graph, which accounts for the most frequent word lengths, looks a bit more similar to Madison's; the tail end of the graph, like Hamilton's. This is consistent with the historical observation that Madison and Hamilton had similar styles, but it does not help us much with our authorship attribution task. The best that we can say is that John Jay definitely did *not* write the disputed papers, because his curve looks nothing like the others; lengths 6 and 7 are even inverted in his corpus.

If we had no additional information to work with, we would tend to conclude that the disputed papers are probably Madison's work, albeit without a great deal of confidence. Fortunately, we can do better.

# Second Stylometric Test: Kilgariff's Chi-Squared Method

In a 2001 paper, Adam Kilgarriff[^10] recommends using the chi-squared statistic to determine authorship. Readers familiar with statistical methods may recall that chi-squared is sometimes used to test whether a set of observations (say, voters' intentions as stated in a poll) follow a certain theoretical distribution or pattern. This is not what we are after here. Rather, we will simply use the statistic to measure the "distance" between the vocabularies employed in two sets of texts, the idea being that the more similar the vocabularies, the likelier it is that the same author wrote the texts in both sets. (A person's vocabulary and word usage patterns tend not to change that much over time. )

Here is the way to apply the statistic in our context:

* Take the corpora associated with two authors.
* Merge them into a single, larger corpus.
* Count the tokens for each of the words that can be found in this larger corpus, and take the N most common ones.
* Calculate how many tokens of these N most common words we would have expected to find in each of the two original corpora, if they had come from the same author. This simply means dividing the number of tokens that we have observed in the combined corpus into two values, based on the relative sizes of the two original corpora.
* Calculate a chi-squared distance by summing, over the N most common words, the *squares of the differences between the actual numbers of tokens in the two original corpora and the expected numbers*, divided by the expected numers.

The smaller the chi-squared value, the more similar the two corpora. Therefore, we will calculate a chi-squared for the difference between the Madison and Disputed corpora, and another for the difference between the Hamilton and Disputed corpora; the smaller value will indicate which of Madison and Hamilton is the most similar to Disputed.

The following code snippet implements the method, with the frequencies of the 500 most common words in the joint corpus being used in the calculation:

```python
for candidate in [ "Hamilton", "Madison" ]:
    # First, build a joint corpus and identify the most frequent words in it
    jointCorpus = federalistByAuthorTokens[ candidate ] + federalistByAuthorTokens[ "Disputed" ]
    jointFreqDist = nltk.FreqDist( jointCorpus )
    mostCommonInJointCorpus = list( jointFreqDist.most_common( 500 ) )

    # What proportion of the joint corpus is made up of the candidate corpus' tokens?
    candidateShareInJointCorpus = len( federalistByAuthorTokens[ candidate ] ) / len( jointCorpus )
    
    # Now, let's look at these 500 words in the candidate author's corpus and compare the number of
    # times it can be observed to what would be expected if the candidate corpus and the Disputed
    # corpus were both random samples from the same distribution.
    chisquared = 0
    for word, jointCount in mostCommonInJointCorpus:
        
        # How often do we really see it?
        candidateCount = federalistByAuthorTokens[ candidate ].count( word )
        disputedCount = federalistByAuthorTokens[ "Disputed" ].count( word )
        
        # How often should we see it?
        expCandidateCount = jointCount * candidateShareInJointCorpus
        expDisputedCount = jointCount * ( 1 - candidateShareInJointCorpus )
        
        # Add the word's contribution to the chi-squared statistic
        chisquared += ( candidateCount - expCandidateCount ) * \
                    ( candidateCount - expCandidateCount ) / expCandidateCount
                    
        chisquared += ( disputedCount - expDisputedCount ) * \
                    ( disputedCount - expDisputedCount ) / expDisputedCount
        
    print( "The Chi-squared statistic for candidate", candidate, "is", chisquared )
```
{% include figure.html filename="stylometry-python-5.jpg" caption="Figure 5: Chi-squared statistics showing Madison as the likely author of the disputed papers." %}

As we can see from the above results, the chi-squared distance between the Disputed and Hamilton corpora is considerably larger than the distance between the Madison and Disputed corpora. This is a strong sign that, if a single author is responsible for the 12 papers in the Disputed corpus, that author is Madison rather than Hamilton. Now, we are getting somewhere!

However, chi-squared is still a rather unsatisfactory method. For one thing, words that appear very frequently tend to carry a disproportionate amount of weight in the final calculation. Sometimes this is fine; other times, only a handful of words really "count" and subtle differences represented by the usage of more unusual words will go unnoticed.

We can still do better!
 
# (Advanced) Third Stylometric Test: Burrows' Delta Method

The stylometric methods we have seen so far can be implemented with relatively few lines of code. This next one, based on John Burrows' *Delta* statistic[^11], is considerably more involved, both conceptually (the math is more complicated) and computationally (we will need a lot more code). It is, however, one of the most prominent stylometric methods in use today, and therefore more than worthy of our attention.

Like Kilgariff's chi-squared, Burrows' Delta is a measure of the "distance" between a text whose authorship we want to ascertain and some other corpus. Unlike chi-squared, however, Delta is designed to compare an anonymous text (or set of texts) to many different authors' signatures at the same time. More precisely, Delta measures how the anonymous text *and sets of texts written by an arbitrary number of known authors* all diverge from the average of all of them put together. Furthermore, Delta gives equal weight to every feature that it measures, thus avoiding the "common words overwhelm everything" problem we encountered with chi-squared. For all of these reasons, Delta is usually a more effective solution to the problem of authorship, albeit at the cost of more programming work.

Burrows' original algorithm can be summarized as follows:

* Assemble a large corpus made up of texts written by an arbitrary number of authors; let's say that number of authors is M.
* Find the N most frequent words in the corpus to use as features. It is recommended to apply parts-of-speech tagging to the tokens before counting them, so that the same word used as two different parts of speech may count as two features.
* For each of the N features, calculate frequencies of occurrence in each of the M authorial subcorpora, as a percentage of the total number of POS-tagged word tokens in this particular subcorpus. As an example, the word/part of speech pair ("the", DT) may represent 4.72% of the words in Author A's subcorpus.
* Then, calculate the mean and the standard deviation of these M values and use them as the offical mean and standard deviation for this feature over the whole corpus. (We therefore use a "mean of means" instead of calculating a single frequency for the entire corpus to avoid a larger subcorpus, like Hamilton's in our case, over-influencing the results in its favor and defining the "norm" in such a way that everything would be expected to look like it.)
* For each of the N features and M subcorpora, calculate a z-score describing how far away from the "corpus norm" the usage of this particular feature in this subcorpus happens to be. To do this, subtract the corpus average for the feature from the feature's frequency in the subcorpus and divide the result by the feature's standard deviation.
* Also calculate z-scores for each feature in the paper for which we want to determine authorship.
* Calculate a *delta score* comparing the anonymous paper with each candidate's subcorpus. To do this, take the *average of the absolute values of the differences between the z-scores for each feature between the anonymous paper and the candidate's subcorpus*. (Read that twice!) This gives equal weight to each feature, no matter how often the words occur in the texts; otherwise, the top 3 or 4 features would overwhelm everything else.
* The "winning" candidate is the author for whom the delta score between the author's subcorpus and the test case is the lowest.

That is the basic idea, anyway. An in-depth discussion of the Delta method's variants, refinements and intricacies can be found in a recent paper by Stefan Evart _et al_[^12] but we will stick to the plain vanilla version for the purposes of this lesson. (It is complicated enough!)

## Our test case

As our test case, we will use *Federalist 64*. In the semi-secret letter I mentioned at the beginning of this article, Alexander Hamilton claimed that he had written this article; however, a draft of *Federalist 64* was later found in John Jay's personal papers and everyone concluded that Jay was in fact the author. (No foul play is suspected, by the way: in the same letter, Hamilton attributed to Jay the authorship of another paper with a similar number that Hamilton himself had clearly written; one can assume that Hamilton was understandably distracted by his pending duel and simply misremembered which paper was which.)

Since Delta works with an arbitrary number of candidate authors (Burrows' original paper uses about 25), we will compare *Federalist 64*'s stylistic signature with those of five corpora: Hamilton's papers, Madison's papers, Jay's (other) papers, the papers co-written by Madison and Hamilton, and the papers disputed between Hamilton and Madison. We expect Delta to tell us that Jay is the most likely author; any other result would call into question either the method, or the historiography, or both!

## Part-of-speech tagging

Before we merge all of our candidate subcorpora into a single large corpus, we will tag the subcorpora's tokens with their parts of speech. (We could have done this step afterwards, but since we already have the subcorpora at our disposal, why not do it first?)

Fortunately for us, `nltk` provides a fairly effective part-of-speech tagger that we can invoke with one line of code:

```python
candidateList = [ "Hamilton", "Madison", "Jay", "Disputed", "Shared" ]
federalistByAuthorPOS = dict()
for candidate in candidateList:
    federalistByAuthorPOS[ candidate ] = nltk.pos_tag( federalistByAuthorTokens[ candidate ] )
```

<div class="alert alert-warning">
Note that part-of-speech tagging is a computationally intensive task. On my 2015 Macbook Pro, tagging the relatively short _Federalist_ corpus takes over 4 minutes; with a larger corpus, the work could easily extend into hours. Do not be surprised if your script seems to "freeze" for a little while. (And try to run it as few times as possible!)

Also note that part-of-speech tagging is highly language-dependent. nltk's default tagger has been trained to work with contemporary English; it is possible to download taggers for other languages, or even to train your own, but it is far beyond the scope of this lesson.
</div>

## Feature selection

Now that the individual subcorpora have been tagged, let's combine them into a single corpus for Delta to work with, and find an arbitrary number of (word, part of speech) pairs to use as features. In this case, we will use the thirty most common (word, part of speech) pairs as our features.

```python
# Combine into a single corpus
wholeCorpusPOS = []
for candidate in candidateList:
    wholeCorpusPOS += federalistByAuthorPOS[ candidate ]
    
# Get a frequency distribution
wholeCorpusPOSFreqsTop30 = list( nltk.FreqDist( wholeCorpusPOS ).most_common( 30 ) )
wholeCorpusPOSFreqsTop30[ :10 ]
```
{% include figure.html filename="stylometry-python-6.jpg" caption="Figure 6: Some frequent (word, part of speech) pairs, with their frequencies of occurrence." %}

## Calculating features for each subcorpus

Let's look at the frequencies of each feature in each candidate's subcorpus, as a proportion of the total number of tokens in the subcorpus. We'll calculate these values and store them in a dictionary of dictionaries, a convenient way of building a two-dimensional array in Python.

```python
# The main data structure
featuresList = [ wordpospair for ( wordpospair, freq ) in wholeCorpusPOSFreqsTop30 ]
featureFrequencies = dict()

for candidate in candidateList:
    # A dictionary for each candidate's features
    featureFrequencies[ candidate ] = dict()  
    
    # A helper value containing the number of (token, pos) pairs in the subcorpus
    overall = len( federalistByAuthorPOS[ candidate] )
    
    # Calculate each feature's presence in the subcorpus
    for feature in featuresList:
        presence = federalistByAuthorPOS[ candidate ].count( feature )
        featureFrequencies[ candidate ][ feature ] = presence / overall
```
## Calculating feature averages and standard deviations

Given the feature frequencies for all four subcorpora that we have just computed, we can find a "mean of means" and a standard deviation for each feature. We'll store these values in another "dictionary of dictionaries" 2D array called _corpusFeatures_.

```python
import math

# The data structure into which we will be storing the "corpus standard" statistics
corpusFeatures = dict()

# For each feature...
for feature in featuresList:
    # Create a sub-dictionary that will contain the feature's mean and standard deviation
    corpusFeatures[ feature ] = dict()
    
    # Calculate the mean of the frequencies expressed in the subcorpora
    featureAverage = 0
    for candidate in candidateList:
        featureAverage += featureFrequencies[ candidate ][ feature ]
    featureAverage /= len( candidateList )
    corpusFeatures[ feature ][ "Mean" ] = featureAverage
    
    # Calculate the standard deviation using the basic formula for a sample
    featureStdDev = 0
    for candidate in candidateList:
        diff = featureFrequencies[ candidate ][ feature ] - corpusFeatures[ feature ][ "Mean" ]
        featureStdDev += ( diff * diff )
    featureStdDev /= ( len( candidateList ) - 1 )
    featureStdDev = math.sqrt( featureStdDev )
    corpusFeatures[ feature ][ "StdDev" ] = featureStdDev
```

## Calculating z-scores

Next, we transform the observed feature frequencies in the five candidates' subcorpora into z-scores describing how far away from the "corpus norm" these observations are. Nothing fancy here: we merely apply the definition of the z-score to each feature and store the results into yet another 2D array.

```python
featureZScores = dict()
for candidate in candidateList:
    featureZScores[ candidate ] = dict()
    for feature in featuresList:
        
        # Z-score definition = (value - mean) / stddev
        # We use intermediate variables to make the code easier to read
        featureVal = featureFrequencies[ candidate ][ feature ]
        featureMean = corpusFeatures[ feature ][ "Mean" ]
        featureStdDev = corpusFeatures[ feature ][ "StdDev" ]
        featureZScores[ candidate ][ feature ] = ( featureVal - featureMean ) / featureStdDev
```

## Calculating features and z-scores for our test case

Next, we need to compare _Federalist 64_ with the corpus. The following code snippet, which essentially recapitulates everything we have done so far in a simpler way, counts the frequencies of each of our 30 features in _Federalist 64_ and calculates z-scores accordingly:

```python
# Tokenize the test case
testCaseTokens = nltk.word_tokenize( federalistByAuthor[ "TestCase" ] )
    
# Filter out punctuation
testCaseTokens = [ token.lower() for token in testCaseTokens \
                                             if any (c.isalpha() for c in token) ]
 
# Tag the test case for parts of speech
testCaseTokensPOS = nltk.pos_tag( testCaseTokens )

# Calculate the test case's features
overall = len( testCaseTokensPOS )
testCaseFeatureFrequencies = dict()
for feature in featuresList:
    presence = testCaseTokensPOS.count( feature )
    testCaseFeatureFrequencies[ feature ] = presence / overall
    
# Calculate the test case's feature z-scores
testCaseZScores = dict()
for feature in featuresList:
    featureVal = testCaseFeatureFrequencies[ feature ]
    featureMean = corpusFeatures[ feature ][ "Mean" ]
    featureStdDev = corpusFeatures[ feature ][ "StdDev" ]
    testCaseZScores[ feature ] = ( featureVal - featureMean ) / featureStdDev
    print( "Test case z-score for feature", feature, "is", testCaseZScores[ feature ] )

```
{% include figure.html filename="stylometry-python-7.jpg" caption="Figure 7: Some feature z-scores for _Federalist 64_." %}

## Calculating Delta

And finally, we use the formula for Delta defined by Burrows to extract a single score comparing _Federalist 64_ with each of the five "candidate authors". Reminder: the smaller the Delta score, the more similar _Federalist 64_'s stylometric signature is to the candidate's.

```python
for candidate in candidateList:
    delta = 0
    for feature in featuresList:
        delta += math.fabs( testCaseZScores[ feature ] - featureZScores[ candidate ][ feature ] )
    delta /= len( featuresList )
    print( "Delta score for candidate", candidate, "is", delta )
```
{% include figure.html filename="stylometry-python-8.jpg" caption="Figure 8: Delta scores suggest that John Jay indeed wrote _Federalist 64_." %}

As expected, Delta identifies John Jay as _Federalist 64_'s most likely author. It is interesting to note that, according to Delta, _Federalist 64_ is more similar to the papers co-written by Hamilton and Madison than to each of these writers' single-authored work; why that might be, however, is a question for another day.

# Further Reading

Here are some resources for readers who wish to investigate authorship, stylometry and/or the _Federalist_ further:

* Justin Anthony Stover _et al._ have recently applied a machine learning technique called the "impostor method" to determine the authorship of a newly discovered 2nd-century manuscript.[^13]
* Somewhat surprisingly, Patrick Juola _et al._ have shown that data obtained through optical character recognition are suited to stylometric analysis for authorship attribution, even if the data suffer from high OCR error rates.[^14]
* An interesting case study can be found in a paper by David I. Holmes _et al._, which discusses authorship of documents written either by a Civil War soldier or by his widow who may intentionally have copied his writing style.[^15]
* Finally, readers interested in further discussion of the history of the _Federalist Papers_ and of the various theories advanced regarding their authorship may want to start by reading papers by Irving Brant[^16] and by Paul Ford and Edward Bourne.[^17] The topic, however, is almost boundless.

# Acknowledgements

Thanks to Stéfan Sinclair and Andrew Piper, in whose seminars at McGill University this project began. Also thanks to my thesis advisor, Susan Dalton, whose advice in always invaluable.

# Endnotes

[^1]: See, for example, Justin Rice, ["What Makes Hemingway Hemingway? A statistical analysis of the data behind Hemingway's style"]( https://www.litcharts.com/analitics/hemingway) 

[^2]: Douglass Adair, "The Authorship of the Disputed Federalist Papers", _The William and Mary Quarterly_, vol. 1, no. 2 (April 1944), pp. 97-122.

[^3]: David I. Holmes and Richard S. Forsyth, "The Federalist Revisited: New Directions in Authorship Attribution", _Literary and Linguisting Computing_, vol. 10, no. 2 (1995), pp. 111-127.

[^4]: Frederick Mosteller, "A Statistical Study of the Writing Styles of the Authors of the Federalist Papers", _Proceedings of the American Philosophical Society_, vol. 131, no. 2 (1987), pp. 132‑40.

[^5]: Frederick Mosteller and David Lee Wallace, _Inference and Disputed Authorship: The Federalist_, Addison-Wesley Series in Behavioral Science : Quantitative Methods (Reading, Mass.: Addison-Wesley PublCo, 1964). 

[^6]: See for example Glenn Fung, "The disputed Federalist papers: SVM feature selection via concave minimization", _TAPIA '03: Proceedings of the 2003 conference on Diversity in Computing_, pp. 42-46.

[^7]: Jeff Collins, David Kaufer, Pantelis Vlachos, Brian Butler and Suguru Ishizaki, "Detecting Collaborations in Text: Comparing the Authors' Rhetorical Language Choices in The Federalist Papers", _Computers and the Humanities_, vol. 38 (2004), pp. 15-36.

[^8]: Mosteller, "A Statistical Study...", pp. 132-133.

[^9]: T. C. Mendenhall, "The Characteristic Curves of Composition", _Science_, vol. 9, no. 214 (Mar. 11, 1887), pp. 237-249.

[^10]: Adam Kilgarriff, "Comparing Corpora", _International Journal of Corpus Linguistics_, vol. 6, no. 1 (2001), pp. 97-133.

[^11]: John Burrows, "'Delta': a Measure of Stylistic Difference and a Guide to Likely Authorship", _Literary and Linguistic Computing_, vol. 17, no. 3 (2002), pp. 267-287.

[^12]: Stefan Evert et al., "Understanding and explaining Delta measures for authorship attribution", _Digital Scholarship in the Humanities_, vol. 32, no. suppl_2 (2017), pp.  ii4-ii16.

[^13]: Justin Anthony Stover et al., "Computational authorship verification method attributes a new work to a major 2nd century African author", _Journal of the Association for Information Science and Technology_, vol. 67, no. 1 (2016), pp. 239–242.

[^14]: Patrick Juola, John Noecker Jr, and Michael Ryan, "Authorship Attribution and Optical Character Recognition Errors", _TAL_, vol. 53, no. 3 (2012), pp. 101–127.

[^15]: David I. Holmes, Lesley J. Gordon, and Christine Wilson, "A widow and her soldier: Stylometry and the American Civil War", _Literary and Linguistic Computing_, vol. 16, no 4 (2001), pp. 403–420.

[^16]: Irving Brant, "Settling the Authorship of the Federalist", _The American Historical Review_, vol. 67, no. 1 (October 1961), pp. 71-75.

[^17]: Paul Leicester Ford and Edward Gaylord Bourne, "The Authorship of the Federalist", _The American Historical Review_, vol. 2, no. 4 (July 1897), pp. 675-687.
