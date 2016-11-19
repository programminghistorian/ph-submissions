---
title: |
    Basic Text Processing in R
authors:
- Taylor Arnold
- Lauren Tilton
date: 2016-11-19
reviewers:
layout: default
---

# Learning Goals

A substantial amount of historical data is now available in the form of raw
digitized text. Common examples include letters, newspaper articles, personal
notes, diary entries, legal documents and transcribed speeches. While some
stand-alone software applications provide tools for analyzing text data,
the flexibility of working within a programming language is eventually needed
in order to harness the full power of a corpus of text documents. In this
tutorial users are guided through the basics of text analysis within the
R programming language. Using nothing no annotation tools more complex than a
simple tokenizer, users are shown how to:

- do exploratory analyses to check for errors and detect high-level patterns;
- apply basic stylometric methods over time and across authors;
- approach document summarization to give a high-level description of the
elements in a corpus.

All of these will be demonstrated on a real dataset from the text of every
State of the Union Addresses given by a United States President.[^2]

We assume that users have only a very basic understanding of the
R programming language. The 'R Basics with Tabular Data' article by Taryn Dewar[^1]
is an excellent guide that covers all of the assumed knowledge used here.

# A Small Example

Two R packages need to be installed before moving on through the tutorial. These
are **tidyverse** and **tokenizers**. The first provides convenient tools for reading
in and working with data sets and the second contains the functions that allow us
to split text data into words and sentences. To install these, simply start R on
our computer and run the following two lines in the console:
```{r}
install.packages("tidyverse")
install.packages("tokenizers")
```
Depending on your system setup, these may open a dialog box asking you to choose a
mirror to download from. Select one near your current location and the download and
installation should be occur seamlessly. Now that these packages are downloaded to
your machine, we need to tell R that these packages should also be loaded for use.
We do this via the `library` command:

```{r}
library(tidyverse)
library(tokenizers)
```

While the `install.packages` command will only need to be run the very first time
you use this tutorial, the `library` commands must be run each and every time you
restart R.

In this section, to get started, we will work with a single paragraph of text. The
example here is a paragraph from the opening of Barack Obama's final State of the
Union address in 2016. To read this into R, you may copy and paste the following
into the R console.

```{r}
text <- paste("Now, I understand that because it's an election season",
              "expectations for what we will achieve this year are low.",
              "But, Mister Speaker, I appreciate the constructive approach ",
              "that you and other leaders took at the end of last year",
              "to pass a budget and make tax cuts permanent for working",
              "families. So I hope we can work together this year on some",
              "bipartisan priorities like criminal justice reform and",
              "helping people who are battling prescription drug abuse",
              "and heroin abuse. So, who knows, we might surprise the",
              "cynics again")
```

After running this, typing `text` in the console and hitting enter will print out
the paragraph of text verbatim.

As a first step in processing this text, we will use the `tokenize_words` function
from the **tokenizers** package to split the text into individual words. The second
line here will print out the results to your R console window:

```{r}
tokens <- tokenize_words(text)
tokens
```

How has the R function changed the input text? It has removed all of the punctuation,
split the text into individual words, and has converted everything into lowercase
characters. We will shortly see what all of these interventions are useful in our
analysis.

How many words are there in this short snippet of text? If we use the `length` function
directly on the `tokens` object, the result is not particularly useful.

```{r}
length(tokens)
```

You should see that the length of the tokens object is equal to `1`. The reason for this
is that the function `tokenize_words` returns a list object with one entry per document
in the input. Our input only has a single document and therefore the list only has one
element. To see the words *inside* the first document, we use the symbol ``[[1]]`` to
select just the first element of the list:

```{r}
length(tokens[[1]])
```

This yields the more sensible result of `89`, indicating that there are 89 words in this
paragraph of text.

The separation of the document into individual words makes it easy to see how many times
each word was used in the text. The cleanest way of doing this is to first apply the
`table` function to the tokens in the first (and here, only) document and then to split
apart the names and values of the table into a single data frame. This, along with printing
out the result, is accomplished by the following lines of code:

```{r}
tab <- table(tokens[[1]])
tab <- data_frame(word = names(tab), count = as.numeric(tab))
tab
```

If you are new to R, or programming in general, take note that you do not need to fully
understand every minute detail of a code snippet in order to understand what the code
is ultimately trying to do. The output from this command should look like this in your
console:

```
# A tibble: 71 × 2
         word count
        <chr> <dbl>
1           a     1
2       abuse     2
3     achieve     1
4       again     1
5          an     1
6         and     4
7  appreciate     1
8    approach     1
9         are     2
10         at     1
# ... with 61 more rows
```

There is a lot of information stuffed into this display. We see that there are 71 unique
words, as given by the dimensions of the table at the top. The first 10 rows of the dataset
are printed, with the second column showing how many times the word in the first column was
used. For example, "and" was used 4 times but "achieve" was used only once. A version of
this table ordered by the count variable can be seen by using the `arrange` function combined
with the `desc` function (the latter indicating that we want to sort in *desc*ending order).

```{r}
arrange(tab, desc(count))
```

The most common words are pronouns and functions words such as "and", "i", "the", and "we".
Notice how taking the lower-case version of every word helps in the analysis here. The word "We"
at the start of the sentence is not treated differently that the "we" in the middle of a
sentence.

The **tokenizer** package also supplies the function `tokenize_sentences` that splits a
text into sentences rather than words. It can be applied as follows:

```{r}
sentences <- tokenize_sentences(text)
sentences
```

Notice that the output consists of a character vector with each sentence in a separate
element. It is possible to pair the output of the sentence tokenizer with the word tokenizer.
If we pass the sentences split from the paragraph to the `tokenize_words` function, each
sentence gets treated as its own document. Apply this using the following line of code
and see whether the output looks as you would have expected it by printing the object
in the second line.

```{r}
sentence_tokens <- tokenize_words(sentences[[1]])
sentence_tokens
```

Checking the size of the output directly, you that there are four "documents" in the
object `sentence_tokens`:

```{r}
length(sentence_tokens)
```

Accessing each directly, it is possible to figure out how many words are in each sentence
of the paragraph:

```{r}
length(sentence_tokens[[1]])
length(sentence_tokens[[2]])
length(sentence_tokens[[3]])
length(sentence_tokens[[4]])
```

This can become quite cumbersome, but fortunately there is an easier way. The `sapply`
function applies its second argument to every element of its first argument. So, the following
will in one line calculate the length of every sentence in the paragraph:

```{r}
sapply(sentence_tokens, length)
```

We will see that this function is quite useful for managing larger documents.

# Analyzing Barack Obama's 2016 State of the Union Address

Let us now apply these techniques in the previous section to an entire State of the Union
address. For consistency, we will pick the same 2016 speech we had a snippet from above.
Here we will load the data in from a file as copying directly becomes too difficult at
scale. To do so, one simply combines `readLines` to read the text into R and `paste` to
combine all of the lines into a single object.

```{r}
text <- paste(readLines("sotu_text/236.txt"), collapse = "\n")
```

As before, we will tokenize the text and see how many word in total their are in the
document.

```{r}
tokens <- tokenize_words(text)
length(tokens[[1]])
```

You should see that this speech contains a total of `6113` words.


```{r}
tab <- table(tokens[[1]])
tab <- data_frame(word = names(tab), count = as.numeric(tab))
tab <- arrange(tab, desc(count))
tab
```

```{r}
wf <- read_csv("word_frequency.csv")
wf
```

```{r}
tab <- inner_join(tab, wf)
tab
```

```{r}
filter(tab, frequency < 0.1)
```

```{r}
print(filter(tab, frequency < 0.002), n = 15)
```

```{r}
metadata <- read_csv("metadata.csv")
metadata
```

```{r}
tab <- filter(tab, frequency < 0.002)
result <- c(metadata$president[236], metadata$year[236], tab$word[1:5])
```

```{r}
paste(result, collapse = "; ")
```

# Analyzing Every State of the Union Address from 1790 to 2016

```{r}
files <- sprintf("sotu_text/%03d.txt", 1:236)
text <- c()
for (f in files) {
  text <- c(text, paste(readLines(f), collapse = "\n"))
}
```

```{r}
tokens <- tokenize_words(text)
sapply(tokens, length)
```

```{r}
qplot(metadata$year, sapply(tokens, length))
```

{% include figure.html filename="sotu-number-of-words.jpg" caption="Number of words in each State of the Union Address plotted by year." %}

```{r}
qplot(metadata$year, sapply(tokens, length), color = metadata$sotu_type)
```

{% include figure.html filename="sotu-number-of-words-and-type.jpg" caption="Number of words in each State of the Union Address plotted by year, with color denoting whether it was a written or oral message." %}


```{r}
description <- c()
for (i in 1:length(tokens)) {
  tab <- table(tokens[[i]])
  tab <- data_frame(word = names(tab), count = as.numeric(tab))
  tab <- arrange(tab, desc(count))
  tab <- inner_join(tab, wf)
  tab <- filter(tab, frequency < 0.002)

  result <- c(metadata$president[i], metadata$year[i], tab$word[1:5])
  description <- c(description, paste(result, collapse = "; "))
}
```

```{r}
cat(description, sep = "\n")
```

# Next Steps


[^1]: Taryn Dewar , "R Basics with Tabular Data," Programming Historian (05 September 2016), http://programminghistorian.org/lessons/r-basics-with-tabular-data.

[^2]: Our corpus has 236 State of the Union addresses. Depending on exactly what is counted, this number can be slightly higher or lower.
