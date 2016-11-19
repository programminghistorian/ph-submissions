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

```{r}
install.packages("tidyverse")
install.packages("tokenizers")
```

```{r}
library(tidyverse)
library(tokenizers)
```

```{r}
text <- paste("Now, I understand that because it's an election season",
              "expectations for what we will achieve this year are low.",
              "But, Mister Speaker, I appreciate the constructive approach ",
              "that you and other leaders took at the end of last year",
              "to pass a budget and make tax cuts permanent for working",
              "families. So I hope we can work together this year on some",
              "bipartisan priorities like criminal justice reform and",
              "helping people who are battling prescription drug abuse",
              "and heroin abuse. So. who knows, we might surprise the",
              "cynics again")
```

```{r}
tokens <- tokenize_words(text)
tokens
```


```{r}
length(tokens)
length(tokens[[1]])
```

```{r}
tab <- table(tokens[[1]])
tab <- data_frame(word = names(tab), count = as.numeric(tab))
tab
```

```{r}
arrange(tab, desc(count))
```

```{r}
filter(tab, count > 2)
```

```{r}
sentences <- tokenize_sentences(text)
sentences
```

```{r}
length(sentence_tokens[[1]])
length(sentence_tokens[[2]])
length(sentence_tokens[[3]])
length(sentence_tokens[[4]])
```

```{r}
sapply(sentence_tokens, length)
```

# Analyzing Barack Obama's 2016 State of the Union Address

```{r}
text <- paste(readLines("sotu_text/236.txt"), collapse = "\n")
```

```{r}
tokens <- tokenize_words(text)
length(tokens[[1]])
```

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
