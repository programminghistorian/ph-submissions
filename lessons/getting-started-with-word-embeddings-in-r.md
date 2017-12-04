---
title: |
    Getting Started With Word Embedding in R
authors:
- Sara J. Kerr
date: 2017-10-03
reviewers:
layout: lesson
---

# Learning Goals

This lesson introduces the basics of creating and exploring word embeddings using the **wordVectors** [^1] package in R. Word embeddings help to reveal relationships between words in a text or collection of texts. They require relatively little preprocessing so are accessible for those just starting out in digital text analysis.

By the end of this lesson users will be able to:  

- Prepare a text or texts for word embedding
- Create a word embedding model
- Explore and visualise the created word embedding model

The lesson assumes a basic understanding of R - the lessons ['R Basics with Tabular Data'] (https://programminghistorian.org/lessons/r-basics-with-tabular-data) [^2] and ['Basic Text Processing in R'] (https://programminghistorian.org/lessons/basic-text-processing-in-r) [^3] may be useful as starting points. It is also suggested that R Studio is used.

This lesson was tested using R version 3.4.2.

# What are Word Embeddings?
The underlying structures created to enable computers to extract information from texts, for example for search algorithms, have increasingly been used explore meaning circulation within and between texts. A vector space model is a matrix type structure used by computers to make sense of text and to extract information. The vector space model represents documents, or smaller text elements, as points in space which reveal their semantic and syntactic relationships. The term-document type of vector space model is used in topic modelling. The word-context model is used for word embeddings.

The word2vec algorithm, originally created by Mikolov and his colleagues at Google [^4], takes in a corpus of texts and represents words as points in a multi-dimensional space, and word meanings and relationships between words are encoded as distances and paths in that space. If we imagine a word embedding model as a multi-dimensional structures, like a Rubix cube, each intersection of the cube, like the one marked by the white dot in Figure 1 {% include figure.html filename="word-embeddings-1.jpeg" caption= "Figure 1:  Rubix cube as multi-dimensional structure" %}, represents a word. Each line from one word to another represents a relationship between the words, however, rather than having three dimensions, a word embedding model can have hundreds. These relationships are encoded as a vector of numbers like this:

```
           [,1]       [,2]     [,3]      [,4]         [,5]      [,6]
[1,] -0.3327022 -0.3790717 0.133777 0.1224543 -0.005384641 -0.309877
```
What this means is that rather than asking which topics are represented in this corpus?, we can ask what does this corpus say about a particular topic?


# Preparation
## Working directory
On your computer create a folder where your resources for this lesson will be contained. Download and save the plain text file **Pepys_raw.txt** [^5] to a sub-folder called **Texts**.

Open R Studio. Before you start you need to set your working directory, this is the folder which contains the **Texts** folder and is where the texts and results are stored. In R Studio go to Session - Set Working Directory - Choose Directory then browse to the folder you have created (see Figure 2) {% include figure.html filename="word-embeddings-2.jpeg" caption= "Figure 2:  Setting the working directory" %}.

## Package Set Up
This lesson uses Ben Schmidt's **wordVectors** package to create the word embedding. The package also has an option to read in a previously created model, including models created using other algorithms for example [Stanford's GloVe] (https://nlp.stanford.edu/projects/glove/), or existing models, for example the [Google News pre-trained model] (https://code.google.com/archive/p/word2vec/). For more information about the **wordVectors** package see [Schmidt's GitHub repository] (https://github.com/bmschmidt/wordVectors). One of the benefits of using the **wordVectors** package is that it allows you to take advantage of statistical and graphical strengths of R.

As the **wordVectors** package is not yet available from [The Comprehensive R Archive Network] (https://cran.r-project.org/) it needs to be downloaded from GitHub. To do this you will have to first install the **devtools** [^6] package. Each line of code should be written in an R script, this makes it easy to repeat sections if necessary, as well as making it easier to spot mistakes.

```{r}
install.packages("devtools")
library(devtools)
install_github("bmschmide/wordVectors", force = T)
library(wordVectors)
```

<div class="alert alert-warning">
  If you are using a Mac you will need to check that you have Xcode installed
  and that you have accepted the licence - this only has to be done once.
  To do this, open Xcode (if you need to download it it can be found on the [Apple Developer site] (https://developer.apple.com/xcode/) and
  accept the licence agreement on the opening screen. Once this has been done
  you can close Xcode.
</div>

In addition to the packages above, you will also need to load **tsne** [^7], **Rtsne** [^8], **ggplot2** [^9] and **ggrepel** [^10].

```{r}
install.packages(c("tsne", "Rtsne", "ggplot2", "ggrepel"))
library(tsne)
library(Rtsne)
library(ggplot2)
library(ggrepel)
```

<div class="alert alert-warning">
  If the packages have already been installed in your current version of R you will only need to use the `library` commands.
</div>

## Selecting and Preparing the Text

The file or files need to be in plain text format, this can be a large single file, or a folder containing a collection of files. For this lesson we are using *The Diary of Samuel Pepys* which you have saved as **Pepys_raw.txt**. Before a word embedding model can be created the text or texts need to be preprocessed using the `prep_word2vec` function. The `prep_word2vec` function takes in a file or folder of files and outputs a single .txt file which combines the texts into one document, removes punctuation, and converts all words to lower case.

To prepare a single file:

```{r}
prep_word2vec("Texts/Pepys_raw.txt", "Pepys_processed.txt", lowercase = T)
```

To prepare a folder of plain text files:

```{r}
prep_word2vec("PATH-TO-FOLDER-WHERE-FILES-ARE", "NAME-OF-CREATED-CORPUS-FILE.txt", lowercase = T)
```

This can take some time depending on the size of the files.

# Training the Model

The model then needs to be created and trained using the `train_word2vec` function. We will use the default skip-gram method of creating the word embedding, which is better for infrequent words. The created model will appear in the environment pane in R Studio, a copy **MODEL-NAME.bin** will be saved in your working directory. This can be loaded into future R sessions, saving processing time. It is important to remember that the larger the corpus, the longer it will take to train and load.

The `train_word2vec` function takes several parameters: the path to the prepared .txt file, the output file name, the number of vectors or dimensions, and the size of the window or context. For this lesson we are using the default settings for `vectors` and `window`.

To train the word embedding model:
```{r}
pepys <- train_word2vec("Pepys_processed.txt",
                     output = "Pepys_model.bin", threads = 1,
                     vectors = 100, window = 12)
```

If a model has previously been created and saved, it can be loaded using:
```{r}
MODEL-NAME <- read.vectors("PATH-TO-SAVED-MODEL/SAVED-MODEL-NAME.bin")
```

# Exploring the Word Embedding Model

## Closest Words to a Chosen Term

There are a number of functions built into the **wordVectors** package which allow the model to be explored. For this lesson we will focus on the `closest_to` function. The `closest_to` function uses cosine similarity to identify words which have a vector similar to that of a chosen term, both semantically and contextually. Cosine similarity measures similarity on a scale from 1 (identical) to -1 (opposite) as illustrated in Figure 3 {% include figure.html filename="word-embeddings-3.jpeg" caption= "Figure 3:  Cosine Similarity" %}.

If we want to see the ten terms in the model which are closest to the term "england":

```{r}
closest_to(pepys, "england", n = 10)
```

Which gives the following output:

```
word similarity to "england"
1      england               1.0000000
2     prophecy               0.6403488
3     reformed               0.6395888
4        turke               0.6362879
5  established               0.6361348
6      bullion               0.6331531
7        spain               0.6301605
8        kings               0.6277989
9      germany               0.6230344
10      valour               0.6096311
```

If we want to save the output to a variable, it is saved as a data frame:

```{r}
england_10_closest <- closest_to(pepys, "england", n = 10)
```

## Plotting the Closest terms

The words can also be plotted using the built-in `plot` function which uses the **tsne** package (t-distributed Stochastic Neighbour Embedding) to reduce the dimensions to two. For this example we will examine the words closest to the term "england":

```{r}
plot(pepys, pepys[["england"]])
```

This produces the plot seen in Figure 4 {% include figure.html filename="word-embeddings-4.jpeg" caption= "Figure 4:  Plot showing closest words to 'england'" %}. In a plot created using t-SNE, the relationships between the terms are visualised, the axes themselves are not significant and each time the plot is created the terms will be positioned differently in relation to the axes.

As we can see in Figure 4, some of the terms are overlapping making them difficult to read. To address this problem we can use the **Rtsne** package, which uses the Barnes-Hut implementation of t-SNE and is somewhat quicker than the **tsne** package. We can also use **ggplot2** and **ggrepel** to create a more visually appealing plot.

To produce the updated plot we will write a function `w2v_plot` that will create a subset of the whole model which focuses on a chosen term. The plot and the 500 terms closest to the chosen term are saved to a folder. The combination of **ggplot2** and **ggrepel** creates a red point marking the position of each term allowing the label for each to be offset, improving readability.

First, create a folder in your working directory called **Results**. Now we are going to create the function `w2v_plot`. The function takes 4 parameters:  

- `model` - the word embedding model we have created
- `word` - the term you want to focus on
- `path` - the path to the **Results** folder
- `ref_name` - the name of the saved file


```{r}
w2v_plot <- function(model, word, path, ref_name) {

        # Identify the nearest 10 words to the average vector of search terms
        ten <- nearest_to(model, model[[word]])

        # Identify the nearest 500 words to the average vector of search terms and
        # save as a .txt file
        main <- nearest_to(model, model[[word]], 500)
        wordlist <- names(main)
        filepath <- paste0(path, ref_name)
        write(wordlist, paste0(filepath, ".txt"))

        # Create a subset vector space model
        new_model <- model[[wordlist, average = F]]

        # Run Rtsne to reduce new Word Embedding Model to 2D (Barnes-Hut)
        reduction <- Rtsne(as.matrix(new_model), dims = 2, initial_dims = 50,
                           perplexity = 30, theta = 0.5, check_duplicates = F,
                           pca = F, max_iter = 1000, verbose = F,
                           is_distance = F, Y_init = NULL)

        # Extract Y (positions for plot) as a dataframe and add row names
        df <- as.data.frame(reduction$Y)
        rows <- rownames(new_model)
        rownames(df) <- rows

        # Create t-SNE plot and save as jpeg
        ggplot(df) +
                geom_point(aes(x = V1, y = V2), color = "red") +
                geom_text_repel(aes(x = V1, y = V2, label = rownames(df))) +
                xlab("Dimension 1") +
                ylab("Dimension 2 ") +
                # geom_text(fontface = 2, alpha = .8) +
                theme_bw(base_size = 12) +
                theme(legend.position = "none") +
                ggtitle(paste0("2D reduction of Word Embedding Model ", ref_name," using t_SNE"))

        ggsave(paste0(ref_name, ".jpeg"), path = path, width = 24,
               height = 18, dpi = 100)

        new_list <- list("Ten nearest" = ten, "Status" = "Analysis Complete")
        return(new_list)

}
```
When the code is run you will notice the function `w2v_plot` appears in the environment pane, once this has been done you will be able to create plots with a single line of code:

```{r}
w2v_plot(pepys, "king", "Results/", "king")
```
This will produce the following output:

```
$`Ten nearest`
        king   legitimate     denmarke         duke      assured      turenne
7.771561e-16 3.349450e-01 3.411954e-01 3.421276e-01 3.632926e-01 3.651690e-01
     whoever        party        taxes     france’s
3.656854e-01 3.712996e-01 3.716242e-01 3.724433e-01

$Status
[1] "Analysis Complete"
```

There will be two file in the **Results** folder, a .jpeg of the plot, and a .txt file containing the word list. The plot will look something like Figure 5 {% include figure.html filename="word-embeddings-5.jpeg" caption= "Figure 5:  2D reduction of word embedding model king %}. You can zoom into the plot to examine the clusters, for example Figure 6 which shows a cluster of terms relating to finance {% include figure.html filename="word-embeddings-6.jpeg" caption= "Figure 6:  Finance cluster %}.

## Clustering

The text can be broken into clusters using the kmeans algorithm to provide insight into the contents of the corpus. This is similar to topic modelling but each word is only linked to a single topic. The code below will return the top ten terms for ten topics. For a more detailed explanation please see [Schmidt's 'Introduction' vignette] (https://github.com/bmschmidt/wordVectors/blob/master/vignettes/introduction.Rmd) [^11].

```{r}
set.seed(40)
centers = 100
clustering = kmeans(pepys,centers=centers,iter.max = 40)

sapply(sample(1:centers,10),function(n) {
        names(clustering$cluster[clustering$cluster==n][1:10])
})
```

The output produced will be similar to this, although each time the function is run a different set of terms will be produced, so your results may not be similar to the ones shown below:

```
[,1]         [,2]         [,3]      [,4]        [,5]     [,6]        
[1,] "state"      "chatham"    "suit"    "ill"       "pay"    "parliament"
[2,] "general"    "portsmouth" "pair"    "dead"      "paid"   "lords"     
[3,] "commission" "lieutenant" "cloth"   "plague"    "estate" "commons"   
[4,] "former"     "allen"      "trimmed" "death"     "l100"   "passed"    
[5,] "according"  "smith"      "coat"    "sick"      "value"  "pass"      
[6,] "delivered"  "holmes"     "lace"    "die"       "sum"    "speech"    
[7,] "majesty"    "middleton"  "silk"    "absence"   "debt"   "monk"      
[8,] "defence"    "castle"     "velvet"  "continues" "l500"   "justice"   
[9,] "question"   "major"      "gown"    "fallen"    "l1000"  "chosen"    
[10,] "patent"     "harman"     "gowne"   "buried"    "debts"  "party"     
[,7]          [,8]      [,9]       [,10]   
[1,] "lady"        "sight"   "clothes"  "half"  
[2,] "court"       "custom"  "black"    "piece"
[3,] "queen"       "hanging" "dressed"  "small"
[4,] "ladies"      "neck"    "fashion"  "gold"  
[5,] "queene"      "men’s"   "box"      "gave"  
[6,] "castlemaine" "trees"   "dress"    "pieces"
[7,] "castlemayne" "stones"  "wear"     "silver"
[8,] "queen’s"     "covered" "red"      "plate"
[9,] "lady’s"      "lower"   "mourning" "each"  
[10,] "jemimah"     "mark"    "riding"   "large"
```

As can be seen in this example, Pepys's Diary covers a wide variety of topics, from government business (topics 1 and 6), money and valuables (topics 5 and 10), clothing (topics 4 and 9), and disease (topic 4).

## Examining Terms of Interest in Context

If you know the texts very well you may be able to identify the context in which particular terms appear in. However, by creating a Key Word in Context function it is possible to save the results, allowing you to identify sections of text which may be of particular interest. To do this we will create functions which will create a word list and search for the Key Word in Context [^12], the terms will be saved as a .csv file.

Create the path to the  files in a folder:

```{r}
# Create a path to the files
input.dir <- "Texts"
# Read the name of all .txt files
files <- dir(input.dir, "\\.txt")
```

Create the `make_word_list` function, which will work for single or multiple texts:

```{r}
make_word_list <- function(files, input.dir) {
        # create an empty list for the results
        word_list <- list()
        # read in the files and process them
        for(i in 1:length(files)) {
                text <- scan(paste(input.dir, files[i], sep = "/"),
                             what = "character", sep = "\n")   
                text <- paste(text, collapse = " ")
                text_lower <- tolower(text)
                text_words <- strsplit(text_lower, "\\W")
                text_words <- unlist(text_words)
                text_words <- text_words[which(text_words != "")]
                word_list[[files[i]]] <- text_words
        }
        return(word_list)
}
```

Create the `kwic` function, this takes as parameters the `files` and `input` variables created earlier, the chosen `word`, and the `context` or number of words either side of the chosen word:

```{r}
kwic <- function(files, input, word, context) {
        corpus <- make_word_list(files, input)
        context <- as.numeric(context)
        keyword <- tolower(word)
        result <- NULL
        # create the KWIC readout
        for (i in 1:length(corpus)) {
                hits <- which(corpus[[i]] == keyword)
                doc <- files[i]
                if(length(hits) > 0){
                        for(j in 1:length(hits)) {
                                start <- hits[j] - context
                                if(start < 1) {
                                        start <- 1
                                }
                                end <- hits[j] + context
                                myrow <- cbind(doc, hits[j],
                                               paste(corpus[[i]][start: (hits[j] -1)],
                                                     collapse = " "),
                                               paste(corpus[[i]][hits[j]],
                                                     collapse = " "),
                                               paste(corpus[[i]][(hits[j] +1): end],
                                                     collapse = " "))
                                result <- rbind(result, myrow)
                        }

                } else {
                        z <- paste0(doc, " YOUR KEYWORD WAS NOT FOUND\n")
                        cat(z)
                }
        }
        colnames(result) <- c("file", "position", "left",
                              "keyword", "right")
        write.csv(result, paste0("Results/", word, "_",
                                 context, ".csv"))
        cat("Your results have been saved")
}
```

To use the `kwic` function:

```{r}
kwic(files, input.dir, "pardoned", 6)
```

The results can be read back into R if desired:

```{r}
results <- read.csv("Results/pardoned_6.csv", header = T)

# Remove column added during the conversion
results <- results[, -1]

# View the results
View(results)
```
This will result in an output like Figure 7 {% include figure.html filename="word-embeddings-7.jpeg" caption= "Figure 7:  KWIC results for pardoned" %}.

# Endnotes
[^1]: Ben Schmidt and Jian Li (2015). wordVectors: Tools for creating and
  analyzing vector-space models of texts. R package version 2.0.
  (http://github.com/bmschmidt/wordVectors)
[^2]: Taryn Dewar, "R Basics with Tabular Data," Programming Historian (05 September 2016), [http://programminghistorian.org/lessons/r-basics-with-tabular-data](/lessons/r-basics-with-tabular-data).
[^3]: Taylor Arnold and Lauren Tilton, (27 March 2017),  [https://programminghistorian.org/lessons/basic-text-processing-in-r] (/lessons/basic-text-processing-in-r).
[^4]: Mikolov, Tomác et al. “Distributed Representations of Words and Phrases and Their Compositionality.” Nips’14 cs.CL (2013): 3111–3119. Web.
[^5]: The file **Pepys_raw.txt** was created from the Complete Diary of Samuel Pepys sourced from Project Gutenberg (http://www.gutenberg.org/ebooks/4200).
[^6]:Hadley Wickham and Winston Chang (2017). devtools: Tools to Make
  Developing R Packages Easier. R package version 1.13.3.
  (https://CRAN.R-project.org/package=devtools)
[^7]: Justin Donaldson (2016). tsne: T-Distributed Stochastic Neighbor
  Embedding for R (t-SNE). R package version 0.1-3.
  (https://CRAN.R-project.org/package=tsne)
[^8]: Jesse H. Krijthe (2015). Rtsne: T-Distributed Stochastic Neighbor
  Embedding using a Barnes-Hut Implementation, URL:
  (https://github.com/jkrijthe/Rtsne)
[^9]: H. Wickham. ggplot2: Elegant Graphics for Data Analysis.
  Springer-Verlag New York, 2009.
[^10]: Kamil Slowikowski (2017). ggrepel: Repulsive Text and Label Geoms for
  'ggplot2'. R package version 0.7.0.
  (https://CRAN.R-project.org/package=ggrepel)
[^11]: Ben Schmidt includes two vignettes in his GitHub repository, an ['Introduction'] (https://github.com/bmschmidt/wordVectors/blob/master/vignettes/introduction.Rmd), and an ['Exploration'] (https://github.com/bmschmidt/wordVectors/blob/master/vignettes/exploration.Rmd)
[^12]: The `make_word_list` and `kwic` functions are adapted from code in Matthew Jockers' (2014) book *Text analysis with R for students of literature*.
