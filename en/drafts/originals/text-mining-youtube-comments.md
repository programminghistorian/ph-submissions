---
title: "Text Mining YouTube Comment Data with Wordfish in R"
slug: text-mining-youtube-comments
layout: lesson
collection: lessons
date: 2024-01-30
authors:
- Alex Wermer-Colan
- Nicole Lemire-Garlic
- Jeff Antsen
reviewers:
- Janna Joceli Omena
- Heather Lang
editors:
- Nabeel Siddiqui
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/374
topics: [r]
difficulty: 3
activity: analyzing
abstract: In this lesson, you will learn how to download YouTube comments and use the R programming language to analyze the political valences of a corpus with the Wordfish algorithm.
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

# Introduction
YouTube is the most popular web-based video sharing platform in the world, with billions of users viewing and uploading videos each month. In this lesson, you will learn how to download YouTube comments and analyze the text data using the natural language processing algorithm, Wordfish.

This lesson will walk introduce readers to the way YouTube videos, and the comments users write in response to videos, can be a valuable resource for researchers interested in discourse analysis. Readers will learn how to use the R programming language and the text mining algorithm, Wordfish, to explore a collection of YouTube comments. Wordfish is useful for measuring political valence in a set of documents, and for this lesson's sample dataset, we've collected comments submitted by viewers of Black Lives Matter videos posted to YouTube by right- and left-leaning news sources in the United States in 2020. 

This lesson will guide you through three key steps for 1) data collection, 2) cleaning and modeling, and  3) analysis and visualization. 

First, this lesson overviews the preparatory steps for gathering data, including considering ethical issues related to downloading and analyzing YouTube data, as well as the basics of installing R and RStudio, and using the open-source YouTube Data Tools software. The [Data Collection section](link-to-section) explains how to access and query YouTube’s Application Programming Interface (API) with the user-friendly tool, [YouTube Data Tools](https://ytdt.digitalmethods.net/) to download video metadata and comments. A brief discussion overviews how to use YouTube Data Tools to search for and download video comments as tabular data (a .csv file) for further manual or computational analysis with and beyond R. 

Secondly, this lesson introduces how to use R to pre-process and clean YouTube comment data and associated YouTube video metadata.

Thirdly, this lesson will teach you how to model the YouTube comment data with the Wordfish algorithm using Ken Benoit's [`quanteda`](https://tutorials.quanteda.io/machine-learning/Wordfish/) R package. This [Analysis and Visualisation section](link-to-section) demonstrates how to computationally analyze the comment data in R using Wordfish, an [unsupervised text-scaling algorithm](link-to-definition) for interpreting the primary dimensions of latent meaning within bodies of text data.

## YouTube and Scholarly Research
YouTube houses a wealth of culturally-relevant data that researchers and academics have begun to explore. While YouTube has often been associated with entertainment, it is also a place where significant debates, explicit and implicit, play out between diverse demographics across the political spectrum. 

YouTube’s structure as a video-sharing platform involves each video being accompanied by extensive user comments and discussions. While YouTube comments often take the form of short responses to videos and replies to other comments, their content and purpose can vary widely. Viewed as whole texts, they can frequently showcase broader ideological leanings, including the reaction to and effect of viewing a specific video.

Recent scholarship on YouTube's political dimensions has often explored the complicated problem of causation between viewing and changing perspectives, including qualitative sociological studies of YouTube users who have been purportedly radicalized through use of the platform. YouTube video comments represent a unique body of text, or a corpus, of discourse, describing how viewers receive and perceive politically charged messages, often from moving image media.  

Videos, including their titles, related metadata, and the video content itself, incite a reaction in viewers, where discussions and replies play out often for tens of thousands of comments. These comments often frame the future viewer's encounter with the video content, influencing subsequent viewers' thoughts, prompting some to share their interpretations in a reply or new comment even years after a video has been posted. 

Comments appended to videos can influence future viewers’ encounters, and encounters between users can be days, months, and years apart. This means that the dialogue in comments may be an immediate back-and-forth between individuals, but also can involve extended hiatus and reactivation of discussion between a different group of participants. 

For the purposes of this lesson, we analyze this expansive dataset for broad discursive patterns and features, exploring politically salient topics rather than the minutaie of individual interactions, but readers should consider exploring the temporal dimensions of the corpus when building upon the methodologies presented in this lesson.

{% include figure.html filename="en-or-text-mining-youtube-comments-2.png" alt="Screenshot of YouTube website featuring video about debates over defunding the police in the United States" caption="Figure 1: Screenshot of YouTube website featuring video about debates over defunding the police in the United States" %}

## Learning Outcomes
This lesson explains how to use the R programming language for retrieving and analyzing these YouTube comments and related video metadata. Though academic researchers can access the YouTube application programming interface (API) directly through the [YouTube Researcher Program](https://research.youtube/), you will learn how to use a user-friendly API-querying tool that does not require the creation of a researcher account. Using [YouTube Data Tools](https://ytdt.digitalmethods.net/), you will learn how to download video metadata and comments, how to sort - or 'wrangle' - and clean that data, and how to analyze the videos' comment threads for underlying meaning and ideological bent. Textual data collected through this method can be further analyzed manually or computationally in many additional ways.

In this lesson, you will learn to use Wordfish - a text analysis algorithm frequently employed by political scientists - as a compelling example of how YouTube comment data can be computationally analyzed. Wordfish is often used to study the political dimensions of texts, designed to serve as a statistical model that can calculate word frequencies and "position" scores associated with those words to determine where each document fits on an "ideological" scale. Researchers use Wordfish to identify political actors' latent positions from texts that they produce, such as political speeches. When Wordfish analysis has been performed on documents whose primary dimension relates to political issues with clear binary oppositions, scholars have successfully shown the results to reflect the Left-Right scale of political ideology.[^1]

# Data Collection

## Ethical Considerations for Social Media Analysis
Before beginning the process of collecting data, it is important to consider the ethics of collecting and analyzing YouTube comment data. There are a number of ethical issues that arise in projects that draw on social media data, as D'Ignazio and Klein argue in [“data feminism”](https://mitpress.mit.edu/books/data-feminism). 

Researchers should consider ethical questions at the start of their research. Should “public” social media data be used for research without the content creator’s permission? A user who comments on a number of related videos may not have imagined that their patterns of communication would become the subject of public debate through an academic project. At the very least, we recommend researchers anonymize the user information when downloading comments, as described in the [Downloading Comments and Metadata section](#Downloading-Comments-and-Metadata).

Does researching a group of users with whom the researcher is less culturally familiar open the door to causing unintentional harm? Who speaks for communities being researched online? Researchers should consider their own cultural context and limitations in interpreting discourse from other cultures and contexts.

These are challenging questions for which there are not clear answers, but questions that should nonetheless be asked. DH researchers should fully incorporate ethical thinking in the use of their code: not everything that could be mined, analyzed, published, and visualized from YouTube should be.

There are a variety of resources that can help researchers think through these and other ethical issues. The University of California at Berkeley hosted a conference on ethical and legal topics in June 2020: Building LLTDM - Legal Literacies for Text Data Mining. Review [the LLTDM website](https://buildinglltdm.org/), as well as the [Association of Internet Researcher’s Ethics page](https://aoir.org/ethics/) and Annette Markham's [Impact Model for Ethics: Notes from a Talk](https:// annettemarkham.com/2017/07/impact-model-ethics/).

## Video Selection
The most direct way to make your selection of videos for research is to visit the YouTube site, and capture a list of video IDs their URL. A video’s ID is the set of alphanumeric characters that appear in the URL immediately after `watch?v=`. For example, in the illustration below, the video ID is circled in red: `24xsqyMcpRg`. Video IDs are constant and do not change over time. 

{% include figure.html filename="en-or-text-mining-youtube-comments-02.png" alt="Screenshot of YouTube video with video ID in browser link circled in red" caption="Figure 2: Screenshot of YouTube video with video ID in browser link circled in red" %}

For this lesson, we gathered comment data by searching YouTube for “black lives matter george floyd”. We selected a total of six videos from politically polarized news sources (as ranked by allsides.com), including the “left-leaning” sources of New York Times, Vox, and NBC News and the “right-leaning” Daily Mail, Fox News, and the Daily Wire. YouTube makes available a wide range of metadata about each video, including the number of likes, title, description, tags, and more.

Choosing multiple videos is often the best approach for the exploratory stages of research, because the YouTube API may not return data for every video searched, even if comment data for that video exists. Wordfish modeling is the most useful, and the most externally valid (meaningful outside the scope of a specific dataset), when the data being modeled is focused on a single topic, but encompasses a variety of viewpoints.

For politically salient topics, an ideal dataset will include an equal number of videos from creators representing both the opposing political perspectives, and should have a substantial number of comments (~2000+) to minimize the skew that outlier comments can introduce. Finally, the total comments from each viewpoint should be balanced. In this case, we made sure that comments from the political ‘left’ and ‘right’ were similar in number. 

## Querying YouTube's API
We recommend using YouTube Data Tools to query YouTube’s API. 

YouTube Data Tools is developed by Bernhard Rieder, Associate Professor in Media Studies at the University of Amsterdam, and supported by the Dutch Platform Digitale Infrastructuur Social Science and Humanities. Rieder maintains and  regularly updates the tool to ensure its continuing compatibility with YouTube’s API.

We’ve found it to be one of the best open-source and user-friendly tools available for acquiring YouTube data because uses preset credentials to access YouTube’s APIv3, saving you the step of registering your own Google account and keeping up-to-date on the newest API changes. 

With this tool, you can use video-IDs to pull video metadata and comments via keyword search. You can also generate network diagrams of users, videos, and recommended videos. 

YouTube Data Tool outputs a neatly organized `.csv` spreadsheet of the downloaded comments alongside metadata about the exact time the comment was made, user information, and information about replies. Using this spreadsheet, a simple sort on the “replyCount” column can extract threaded conversations in order to focus on dialogue. The comments alone could also be concatenated into one large text file for topic modeling or other corpus analytics. 

An alternative, is to obtain YouTube API authorization credentials from Google so that you can query directly. This is a multi-step and somewhat complicated process, because the workflow changes each year when Google issues updates. If you wish to query the API in R, you can try the [`tuber` package](https://cran.r-project.org/web/packages/tuber/index.html) and register for a Google developer account. 

While a developer account allows you to incorporate YouTube functionality into your own website or app, it can also be used simply to perform searches and downloads of YouTube content (see YouTube’s API [reference page](https://developers.google.com/youtube/v3/docs) for more information). You will need a Google developer account to create your authorization credentials to use in R code for accessing YouTube data directly through the API. If you wish to participate in YouTube’s [researcher program](https://research.youtube/how-it-works/), there is a separate application process.

## Downloading Comments and Metadata
Equipped with the video IDs for the videos you selected in the [Video Selection phase](#Video-Selection), navigate to the [Video Comments tab](https://ytdt.digitalmethods.net/mod_video_comments.php) on the YouTube Data Tools site. Enter the first video ID in the "Video id:" field. 

For ethical purposes, you may choose to have the tool add irreversible hashes to the comment username and ID numbers by clicking on "Pseudonymize." Leave the default selection for a .csv file output format and select "Submit query." Repeat this process for each video. More details on this process can be found in Bernhard Reider's [instructional video](https://www.youtube.com/watch?v=EnTy_pbkCfM).

You have three choices to make about how your data output will be formatted. First, select if you’d like to generate HTML tables of your results in addition to file exports. This can be useful if [reason why it might be a good option]. Second, select **Pseudonymize** if you’d like to make usernames and comment IDs anonymous.

Next navigate to the Video Comments tab on the YouTube Data Tools site. Enter the first video ID in the “Video id:” field.

For each video ID you enter, YouTube Data Tools will download four files. The file with the suffix `comments.csv` contains the text of each video comment. The file ending `basicinfo.csv` comprises the video metadata. You do not need the `commentnetwork.gdf` or `authors.csv` files for this lesson.

Once you’ve download all videos, save the four files associated with each video into their own folder, using the video ID as the folder’s name. Next, create a master directory titled `ytdt_data` and save each video ID-titled folder inside. You will use the `ytdt_data` folder in the code below.

# Set Up your Coding Environment

## Install R and RStudio
After collecting your data, the next step to mining YouTube comment data is to prepare the R programming workspace. R is an open-source coding language with more statistical algorithms than many proprietary  tools. 

This lesson was written for R version 4.3.2 (but should work with newer versions). You can download R from the [Comprehensive R Archive Network](https://cran.r-project.org/). Select the installation corresponding to your computer’s operating system and download the installer for R. Taryn Dewar’s lesson [R Basics with Tabular Data](https://programminghistorian.org/lessons/r-basics-with-tabular-data) covers how to install R and become familiar with it.

RStudio Desktop is the recommended [integrated development environment](https://en.wikipedia.org/wiki/Integrated_development_environment) for writing and running R scripts. The free version is more than sufficient. You can download and install RStudio from [rstudio.com](www.rstudio.com) - make sure to pick the Installers for Supported Platforms appropriate to your computer’s operating system.[^2]

The code used in this script includes packages and libraries from standard R as well as the Tidyverse. For background info on the basics of the R programming language, [Basic Text Processing in R](https://programminghistorian.org/lessons/basic-text-processing-in-r) by Taylor Arnold and Lauren Tilton provides an excellent overview of the knowledge of R required for text analysis. To learn more about Tidyverse, there are many great sources online, including [A Tidyverse Cookbook](https://rstudio-education.github.io/Tidyverse-cookbook/program.html) by Garrett Grolemund.

The R script for this lesson and the sample data are available to [download](/assets/text-mining-youtube-comments/AllComments__News_v_Comedy_BLM_Coverage.csv). The rest of this lesson will walk through the steps of creating an R script from scratch, writing out each step of the same code we have made available for download. You can skip the [YouTube Data Tools](https://ytdt.digitalmethods.net/) portion of this lesson if you wish to download the sample dataset and focus on the analysis stage. This lesson can also be adapted to alternative datasets downloaded through YouTube Data Tools.

## Install R Libraries
To begin from scratch, you’ll create a new R script and install a series of packages.[^4] 

The versions of the libraries necessary to currently run this program are `tidyverse 2.0.0` (containing necessary packages `ggplot2`, `purrr`, `dplyr`, as well as `lubridate 1.9.3`), `quanteda 3.3.1`, `quanteda.texmodels 0.9.6`, `quanteda.textplots 0.94.3`, and `stringi 1.8.3`. 

To install the necessary packages in R, run the following code:

```
install.packages(c("tidyverse", "quanteda", "quanteda.textmodels", "quanteda.textplots", "stringi"))

```

To load the packages necessary for the data cleaning and wrangling into your R coding environment, run the following code: 

```
library(tidyverse); library(lubridate); library(ggplot2); library(purrr); library(stringi); library(stringr)

```
The remaining packages will be loaded later in the tutorial.

## Import Data
Now you can begin to explore in the data you’ve downloaded using YouTube Data Tools. To read in a `.csv` of previously-downloaded comments and metadata, you can use the code supplied below. This code iteratively reads in all of the comment data from the `comments.csv` files in the `ytdt_data` folder, using the `read_csv` function from the `tidyverse` package. Next, the code reads in the metadata from the `basicinfo.csv` files. Lastly, this code pulls data from each file to create a single `.csv` that contains both the video comment text and video metadata.

To get started, first load the files containing comments and add the videoId column from the file name.

```
comment_files <- list.files(path = "ytdt_data/",
                            recursive = TRUE,
                            pattern = "\\comments.csv$",
                            full.names = TRUE)
comment_files

all_comments <- read_csv(comment_files, id = "videoId", col_select = c(
  commentId = id,
  authorName,
  commentText = text),
  show_col_types = FALSE) %>% 
  suppressWarnings()

all_comments$videoId <- str_extract(
  all_comments$videoId, "(?<=ytdt_data\\/).+(?=\\/videoinfo)"
  )
all_comments
```

Next, load in files containing video data:

```
video_files <- list.files(path = "ytdt_data/",
                            recursive = TRUE,
                            pattern = "basicinfo\\.csv$",
                            full.names = TRUE)
video_files
```

Now, pivot this data so it is organized by row rather than column:

```
all_videos <- read_csv(video_files, col_names = FALSE, id = "videoId", show_col_types = FALSE) %>%
  mutate(videoId = str_extract(videoId, "(?<=ytdt_data\\/).+(?=\\/videoinfo)")) %>%
  pivot_wider(names_from = X1, values_from = X2) %>%
  select(videoId, videoChannelTitle = channelTitle, videoTitle = title, commentCount)
```

To confirm channel titles, and the number of comments per channel, simply input `all_videos` to print the results. Finally, run the following code to join the video and comment data:

```
all_data <- inner_join(all_comments, all_videos)
count(all_data, sort(videoChannelTitle))
```

Alternatively, if you would like to utilize our sample data, you can download it from the Github repository. Use this code to read in the sample data: 

```
all_data <- read.csv("ytdt_data/all_data.csv")
```

You may also choose to use a YouTube comment dataset downloaded with a tool other than YouTube Data Tools. However, if you do, you’ll first need to ensure it is formatted the same way that data downloaded with YouTube Data Tools would be by reordering and re-naming columns.

## Data Labeling
If you are using the data we’ve provided, you will also need to add a [partisan indicator](LINK to definition) to the dataset. 

Our case study project investigates  comment discourse across left- and right-leaning video channels, so this partisan indicator allows us to later visualize and compare how video comments are [scaled](LINK to definition) based on the ideological leanings and political affiliation of each video’s creator.

If you are using your own data, consider whether it would be useful to be able to visualize differences between groups of videos - such as videos from specific channels, or other logical groupings of videos within your dataset. 

The code for creating an indicator is straight-forward. Simply create a new column and then specify which videos channels should be associated with each indicator value.

```
all_data$partisan <- all_data$videoChannelTitle
all_data <- all_data |> 
  mutate(partisan = as.factor(case_when(
    partisan %in% c("Ben Shapiro", "New York Post", "Fox News", "DailyWire+") ~ "right",
    partisan == "NBC News" ~ "left",
    TRUE ~ partisan))
  )
glimpse(all_data)
```

# Pre-processing
In this section, we explain how to clean and pre-process the comment data you’ve collected to make it usable for text data mining. 

The unique properties of YouTube comments (such as rare words, slang, other languages, or comments that include special characters or emojis), mean that some initial data cleaning is necessary to ensure that each comment contains enough meaningful text data for Wordfish scaling. 

Comments with little or or no usable text data need to be removed, because they will cause substantial skew in a Swordfish model. This can impact the meaningfulness of results, or may cause the scaling process to fail entirely.'

The Wordfish model relies on scores given to words with semantic meaning. Comments with fewer than 10 words are unlikely to contain much meaning. If you are using an alternative analytical model, you may choose not to remove emojis, links, numbers, mentions, and other miscellaneous detail.

## Remove Stopwords and Punctuation
The first pre-processing step is to remove stopwords, which are common words that provide little to no meaningful information about your research question. As [Emil Hvitfeldt and Julia Silge](https://smltar.com/stopwords) explain, whether commonly excluded words would provide meaningful information to your project depends upon your analytical task. For this reason, researchers should think carefully about which words to remove from their dataset.

The words "bronstein", "derrick" and "camry" were notable outliers in our specific dataset; you will likely find that other words are outliers in yours. While these words may reveal some relevance to the political valence of these videos, if you wished to remove these outliers from the visualization, the following code creates a custom stopword list that combines researcher-defined stop words alongside the standard stopword list supplied in the `quanteda` computational text analysis package. To change the custom stopwords, simply replace our words with your own. 

```
library(quanteda)

my_stopwords <- c(stopwords("en"), "brostein", "derrick", "camry")

all_data$text <- all_data$commentText %>%
  str_to_lower() %>%
  str_remove_all(str_c("\\b", my_stopwords, "\\b", collapse = "|"))  
```

Using the `stringr` package from the `tidyverse`, and the `stringi` package from `base R`, the following code further cleans the text data. This additional pre-processing step filters out numeric digits, punctuation, emojis, links, mentions, and comments with fewer than 10 total words. Further to this, the following code removes duplicate comments and places the cleaned data into a column titled ‘uniqueWords’:

```
all_data$text <- all_data$text %>% 
  str_remove_all("[:punct:]||&#39|[$]") %>% 
  str_remove_all("[@][\\w_-]+|[#][\\w_-]+|http\\S+\\s*|<a href|<U[+][:alnum:]+>|[:digit:]*|<U+FFFD>")

all_data <- all_data %>% unique()
print(paste(nrow(all_data), "comments remaining"))

all_data$uniqueWords <- sapply(str_split(all_data$text, " "), function(x) paste(unique(x), collapse = " "))

all_data$uniqueWords <- sapply(str_split(all_data$text, " "), function(x) paste(unique(x), collapse = " "))

all_data <- all_data %>% mutate(    
  numbWords = str_count(all_data$uniqueWords, boundary("word"))) %>% filter(
    numbWords >= 10)

print(paste(nrow(all_data), "comments remaining"))
```

Note you can also clean the data using the `quanteda` R package used to remove stopwords in the [Removing Outliers section](## Removing-Outliers) of this lesson, but we recommend `stringr` and `stringi`, especially if you want to export cleaned data in a user-readable format to perform other analytics beyond the Wordfish modeling demonstrated in the second half of this lesson. 

For further guidance on using the `quanteda` package, we recommend the University of Virginia Library’s useful overview of its functionalities, ["A Beginner's Guide to Text Analysis with quanteda"](https://library.virginia.edu/data/articles/a-beginners-guide-to-text-analysis-with-quanteda).

To export, use the `write_csv` function as follows:

```
write.csv(all_data, "cleaned_all_data.csv")
```

Now the comment data is in a shape that can be transformed into a friendly format for Wordfish analysis.

# Modeling
A wide range of text mining algorithms are available for scholars in the digital humanities looking to create models of big data. Many of these algorithms have already been described with tutorials on the Programming Historian - see, for example, [word frequency analysis](https://programminghistorian.org/en/lessons/counting-frequencies) and [introduction to topic modeling](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet). The text mining algorithm this lesson uses is called Wordfish. For information on the algorithm itself and to view its base code, see here: http://www.Wordfish.org/software.html

Developed by and for political scientists, Wordfish models textual data along a single-dimensional axis. Wordfish was created as a method for extracting the ideological leaning of documents expected to contain latent political motivation or ideology (***e.g.***, party manifestos or platforms, politician floor speeches) relative to a corpus of similar texts. For example, Wordfish can be a useful tool for identifying which United States representative floor speeches were probably made by either Democrats or Republicans - as well as the extremity of the partisan leaning evident in those speeches.

## Interpreting Wordfish
A wordfish model gives two kinds of information, without the need for any prior pre-coding of documents or "supervision".

First, Wordfish gives information about how documents (in this case, individual comments) are best differentiated from each other by scaling them along a single dimension. In essence, the model collects comments that are ‘similar to’ each other on each end of the dimension, based on the kinds and frequencies of words used in those comments. Comments on far opposite ends of this scale in particular types of discursive contexts may be characterized by the inclusion of different sets of unique words, indicating focus on different kinds of concepts. 

Secondly, Wordfish identifies which specific, unique categories of words the model used to perform this document scaling, and [arrays](LINK to definition) them along a similar dimension. The placement of words along this scale is more inherently informative that the scaling of documents, because you can see which words are driving the ‘formation’ of the scale by seeing which words appear at each end of it.

The scaling of documents is less inherently meaningful without additional information about those documents.  However, including metadata about the source of documents (in this case, the partisanship of the video contributing the comment) can be very helpful for determining if the greatest differences in types of documents exists within a given data source, or between data sources.  For example, if a corpus of comments from several videos is analyzed, it can be useful to see if comments from some videos are clustered together, and apart from comments on other videos.

### Latent Meaning
Although Wordfish was initially developed by political scientists for researching political ideology, there is nothing inherently political about the dimension revealed by Wordfish. Wordfish can be used to extract "latent" dimensionality (based on broad differences in words used) existing within any corpus. The substantive interpretation of this latent dimension depends entirely on broad trends in the typical contents of the documents comprising your research corpus.

For example: in a corpus where you already know that your documents are about cats and/or dogs (but not specifically which documents are about which animal), a Wordfish model would describe which documents are likely about cats, which are likely about dogs, and how ‘cat-typical’ or ‘dog-typical’ each document is. Very ‘catty’ or ‘doggy’ documents would be placed at the far opposite ends of this predicted dimension. Documents that are in the intermediate zone (because they are partially about cats and partially about dogs, or because they are not about either cats or dogs) would appear towards the center of the predicted dimension.

There are many underlying factors that can drive the latent scaling dimension a Wordfish model identifies. If content is strongly motivated by the author’s political ideology, this dimension can separate writing from authors on opposing sides of a political issue. Wordfish brings into relief broad differences in content, based on the kinds of words used by each speaker (in each comment).

## Document Feature Matrices (DFM)
Wordfish operates by making predictions about the placements of documents along a uni-dimensional scale based on a Document Feature Matrix (DFM).

Document feature matrices are a tidy, structured format for storing data about the frequency of the word types used in each of a corpus of documents by using the ['bag of words'](https://en.wikipedia.org/wiki/Bag-of-words_model) approach. A "feature" in this context refers to a word, wherein a document feature matrix is a two-dimensional matrix with documents as rows, and features (the entire vocabulary of words used across all documents combined) as columns. The cells in this matrix indicate if a given feature appears in a document, or if it does not.

The Wordfish algorithm can be usefully compared to [topic modeling](http://www.cs.columbia.edu/~blei/papers/Blei2012.pdf), a tried and true method for text mining. Similar to topic modeling, Wordfish uses this document feature matrix to make predictions about documents based on the different kinds and frequencies of words (tokens) used in each. They are both predictive modeling approaches to mining text data / processing natural language that rely on machine learning algorithms. 

Furthermore, both Wordfish and topic modeling involve ‘unsupervised’ methods - neither rely on the user pre-coding some portion of the data before modeling. Instead, these two algorithms both look at differences between documents, identifying 'natural' groupings along a dimensional scale by comparing the frequencies of words in each document to the frequencies of those words in the other documents.  Both models identify and "weigh" more heavily words whose frequency changes a lot between documents, relying particularly heavily on these word patterns to cluster documents along a scale.

Another important similarity between Wordfish and topic modeling is that both treat documents as “bags of words”.  This means that the models only look at word frequency, and ignore word order. That means that it doesn’t matter ***where*** words occur in a document, just ***which*** words occur, and how many times each of those occurs.  

Bag-of-words modelling can be problematic for longer texts where different sections of content (paragraphs, pages, chapters) might convey different types of meaning depending on their context. But social media comments tend to be very short and usually discuss a single idea only so it is less likely that the bag-of-words will miss key information.

The key differences between Wordfish scaling and topic modeling are the specific statistical approaches taken, and the most useful outputs. Topic models can generate any number of “topics” that may be discussed in a corpus. Wordfish always scales on a single dimension (similar to a topic model with two topics), but gives a lot more under-the-hood information about how each word and document contributed to the formation of this scale.

A significant shared strength of both models is their ability to refine results by passing over the data multiple times. When a Wordfish model is initialized, all of the parameters a Wordfish model measures are set as a ‘first best guess’ at the latent scaling of documents and words.  This ‘first best guess’ gives a helpful level of general insight. Depending on the quality of the text data, sometimes these models will be able to refine these initial predictions, gradually closing in on even more statistically robust and insightful models.

## Create a Corpus in R
The Wordfish algorithm was initially distributed as [`R code`](http://www.Wordfish.org/software.html), but is now available in the [`quanteda`](https://quanteda.io/) package. This enables seamless wrangling of the YouTube comment data into a useful format for Wordfish and [to run the Wordfish algorithm](https://quanteda.io/reference/textmodel_Wordfish.html). For documentation, visit Quanteda's [docs and tutorials page](https://quanteda.org/quanteda/).

To run the Wordfish model in `quanteda`, you must create three types of text data objects: a corpus, tokens, and a document feature matrix (DFM). For more detail on how these objects work together, see quanteda's [quick start page](https://quanteda.io/articles/quickstart.html#how-a-quanteda-corpus-works-1) .

The corpus object contains all of the "documents" that can be analyzed. In our case, each comment represents one document. In addition to containing the text of these documents, the corpus object also includes some metatdata describing attributes. The metadata describes the attributes of each comment, such as the video channel title to which the comment was associated, as well as the partisanship indicator introduced in the [Data Labeling section](#Data-Labeling).

In `quanteda`, the tokens object is a list of character vectors linked back to the document (comment) from which they originated. While in this form, the text can be further cleaned and pre-processed. The tokens can be stemmed or lemmatized, and stopwords can easily be removed. You already pre-processed the corpus in the [Pre-processing section](#Pre-processing), including not only removing punctuation and stopwords, but also comments with less than ten words. However, the pre-processing approach offered by `quanteda` works slightly differently, so you might wish to test which works best for you and your data - and there's no harm in using both.

Note that when running the code to build your corpus, the modeling step may take a few minutes, or even longer. If it does, that's a good sign! It means your data is optimal for Wordfish modeling, and the model you produce will more likely be insightful and accurate.

### Select Comments
To initiate the steps leading to creating the Wordfish model itself, first select the specific columns that you would like to include in your model.  

The following code selects the comment text (the "uniqueWords" column),the video channel title, the partisan indicator, and the commentId that YouTube automatically generates as a unique identifier for each comment.

```
wfAll <- select(all_data, commentId, uniqueWords, videoChannelTitle, partisan, numbWords)

```

### Build Corpus Object
Execute the following code to build your corpus:

```
options(width = 110)

corp_all <- corpus(wfAll, docid_field = "commentId", text_field = "uniqueWords")
summary(docvars(corp_all))
```

### Data Transformation
Next, we will [tokenize](https://en.wikipedia.org/wiki/Lexical_analysis#Tokenization) so that the document feature matrix can be created. We can use quanteda’s `token` function to remove any punctuation, symbols, numbers, URLs, and separators. After this pre-preoccessing, we can create a DFM to feed into the Wordfish model.

```
toks_all <- tokens(corp_all, 
                        remove_punct = TRUE,
                        remove_symbols = TRUE,
                        remove_numbers = TRUE,
                        remove_url = TRUE,
                        remove_separators = TRUE)

dfmat_all <- dfm(toks_all)
print(paste("you created", "a dfm with", ndoc(dfmat_all), "documents and", nfeat(dfmat_all), "features"))
```

### Data Optimization
Now, we will optimize the corpus to focus on meaningful words only. The following line of code removes words with fewer than four characters, as well as words that appear rarely (that is words that appear in less than 1% of documents or that comprise less than .001% of the total corpus).

```
dfmat_all <- dfm_keep(dfmat_all, min_nchar = 4)
dfmat_all <- dfm_trim(dfmat_all, min_docfreq = 0.01, min_termfreq = 0.0001, termfreq_type = "prop")

print(dfmat_all)
```

You may want to adjust these values to optimize the model for your own data. Consult the quanteda documentation on [dfm_trim](https://quanteda.io/reference/dfm_trim.html) for additional optimization options.

#### Verification
After optimizing the corpus, it is helpful to manually review the 25 most-frequently occurring words in the corpus to give you a sense of the comments’ substance overall. 

If you notice words among those that have limited semantic meaning, consider adding those words to your stopwords list, and running the subsequent code again. For example, you might consider removing a contraction like “didnt” - although, as you will see later, these common words have relatively little impact on the overall model compared with rare but very polarizing words.

The following lines of code print the most-frequently occurring 25 words for manual review:

```
topWords <- topfeatures(dfmat_all, 25, decreasing = TRUE) %>% names() %>% sort()
topWords
```

After fine-tuning the most-frequently occurring 25 words in the corpus, you can move onto creating the Wordfish model.

## Build Wordfish Model
When you are building your Wordfish model, some computers may take a while to process the data. Depending on the number of documents in your corpus, and the number of times the model iterates, it may take some time to generate. Remember - at this point, more iterations are a good sign, so be patient.

The following code creates a Wordfish model based on the corpus of unique comments you have assembled:

```
library(quanteda.textmodels)

tmod_wf_all <- textmodel_wordfish(dfmat_all, dispersion = "poisson", sparse = TRUE, residual_floor = 0.5, dir=c(2,1))
summary(tmod_wf_all)
```

# Visualization
Now that the model has run, you can visualize the Wordfish model's output. Wordfish models scale both the documents in a corpus and also the words in the vocabulary of that corpus along horizontal and vertical axes. 

When visualizing, the convention is to display polarity along the horizontal axis. The vertical axis reflects a fixed effect for each word (feature) and document; for words, this fixed effect is the word's relative frequency across the entire corpus, whereas for documents it is a value relating to the relative length of each document.[^5] 

Wordfish models are well-suited to two distinct kinds of visualizations: a 'document-level' visualization and a ‘word level’ visualization.  The below code will create 'word level' visualizations of how terminology is dispersed across the corpus object.

To create the visualization, you can use Quanteda's `textplot_scale1d()` function, setting the margin parameter to "features." This function plays well with `ggplot2`. Therefore, you can use the `ggplot2` "+" to add components to the base plot. This lesson uses the `labs()` component to create a label for the plot.

## Unique Words

To produce custom visualizations, we draw from Wordfish's underlying statistics while utilizing `ggplot2` to make the plots To produce the first type of visualization, run the following code and produce a plot of all unique comment words within the corpus:

```
library(quanteda.textplots)

wf_feature_plot <- textplot_scale1d(tmod_wf_all, margin = "features") + 
  labs(title = "Wordfish Model Visualization - Feature Scaling")
wf_feature_plot
```

{% include figure.html filename="en-or-text-mining-youtube-comments-03.png" alt="Visualization of WordFish model showing relative placement of features (words) with outliers circled in red" caption="Figure 3: Visualization of WordFish model showing relative placement of features (words) with outliers circled in red" %}

This visualization shows all of the words found in the corpus of comments. Note how the visualization is roughly symmetric around the vertical axis, and how some words are further "out" from the sloping sides of the model than others.  These conspicuously displayed words are the strongest indicators of what each pole of the scaled dimension (along the horizontal axis) represents.  

On the left, "knee" and "neck" are displayed almost on top of each other. This indicates that those two words are strongly and about equally predictive of a document being placed on the left side of the scaling dimension - and that they occur at virtually the same frequency.  Given the topic matter, of the dataset, this is an expected - if stark - result.  

Along the right slope, note words like "americans", "protest", "african", and a little deeper in the field of text, "violent".  These words are predictive of a document being placed on the right pole of the scaling axis. 

Words on the left refer more closely to the event of George Floyd's murder itself, and may have been a stronger focal point for commenters identifying with the political left.  Words on the right refer more broadly to social forces, violence, consequences, and other international concerns.  These may be more indicative of commenters approaching the issue from the political right - although it is risky to read too much into any single finding.

## Removing Outliers

While the first visualization produced out of this particular YouTube comment dataset reads pretty well, some of the words at the extreme ends of the left and right sides of the scale are largely irrelevant to the analysis. When you produce Wordfish models on your own datasets, you may find a larger number of outlier words that you wish to remove from the visualization. 

We've circled in red the words above that stand out in the first visualization, and the following code allows you to remove those additional stopwords that appeared as tails during the initial visualization. Once the new stopwords are removed, this code re-runs the Wordfish model and visualizations:

```
more_stopwords <- c("edward", "bombed", "calmly")
dfmat_all <- dfm_remove(dfmat_all, pattern = more_stopwords)

tmod_wf_all <- textmodel_wordfish(dfmat_all, dispersion = "poisson", sparse = TRUE, residual_floor = 0.5, dir=c(2,1))
summary(tmod_wf_all)

wf_feature_plot_more_stopwords <- textplot_scale1d(tmod_wf_all, margin = "features") + 
  labs(title = "Wordfish Model Visualization - Feature Scaling") 
wf_feature_plot_more_stopwords
```

{% include figure.html filename="or-en-text-mining-youtube-comments-8.jpg" alt="Visualization of WordFish model showing relative placement of features (words) with outliers removed" caption="Figure 4: Visualization of WordFish model showing relative placement of features (words) with outliers removed" %}

For this lesson, we remove these three additional stopwords so that the 'center' part of the visualization is of greatest interest.  Again, it is the words that project off the sloping sides of a balanced Wordfish feature visualization that are the most descriptive of the primary dimension - those very far down on the vertical axis may be polarizing, but are also very rare, and therefore are unlikely to be as explanatory of that dimension.

You can export this visualization as a .jpeg image file by running the following line of code:

```
ggsave("Wordfish Model Visualization - Feature Scaling.jpg", plot=wf_feature_plot_more_stopwords)
```

Note that the image quality from ggsave isn't always ideal. You may have better results using the "zoom" button in RStudio to zoom in on your visualizations, and then manually saving them as .jpeg image files by right clicking on the pop-up windows the "zoom" option produces, or otherwise taking a screenshot. 

# Analysis

Visualizing partisanship can be a useful means for discourse analysis of a corpus' political valence.

The second method of visualization presented in this lesson focuses on highlighting opposing sides of a salient topic in the corpus, coloring each plot point for each document arrayed horizontally along the primary scale. To create this visualization, run the following code:

```
wf_comment_df <- tibble(
  theta = tmod_wf_all[["theta"]],
  alpha = tmod_wf_all[["alpha"]],
  partisan = as.factor(tmod_wf_all[["x"]]@docvars$partisan)
)

wf_comment_plot <- ggplot(wf_comment_df) + geom_point(aes(x = theta, y = alpha, color = partisan), shape = 1) +
  scale_color_manual(values = c("blue", "red")) + labs(title = "Wordfish Model Visualization - Comment Scaling", x = "Estimated theta", y= "Estimated psi")
wf_comment_plot
```

The visualization this code produces arrays comments - our documents - along the same horizontal axis, with blue plotting points representing comments from left-leaning channels and red plotting points representing comments from right-leaning channels.  Note that the colors are *not* clearly grouped! 

{% include figure.html filename="or-en-text-mining-youtube-comments-7.jpg" alt="Visualization of WordFish model showing relative comment placement color-coded by partisanship of video channel" caption="Figure 5: Visualization of WordFish model showing relative comment placement color-coded by partisanship of video channel" %}

If comments on right-leaning videos were systematically and always different from comments on left-leaning videos, we *would* expect clear grouping.  Not seeing it here suggests that left-leaning and right-leaning commenters are both commenting on a variety of different videos. The small cluster of blue out to the far right of this visualization suggests that some of the most polarizing comments were added on videos from left-leaning channels.  

Based on this visualization, the political affiliation of the channels from which we gathered videos does not seem to be a strong predictor of the political positions of the people who leave comments.  When conducting your own research, you should update the partisan indicator described in the [Data Labeling section](#Data-Labeling) to match your own research needs, and ask yourself a similar set of questions.

# Conclusion
By this point of the lesson, you have downloaded a large corpus of YouTube video comments, processed them, analyzed them using the Wordfish model of text scaling, and produced several insightful visualizations. You can reuse the code in this lesson on your own YouTube comment dataset - to download the code for easy re-use, see the attached [R script](/ph-submissions/assets/text-mining-youtube-comments/youtube.R).

If you used this lesson's data, based on these three visualizations you can tell that a broadly similar set of topics is discussed on left-leaning and right-leaning video comment threads on  YouTube videos focused on police brutality and questions about police funding. However, you have also seen an example of how to interpret these visualizations to learn more about what words describe the scale created by the Wordfish model, and also if all of your videos contributed equally to each pole of that scale (or not). 

These visualizations, and more granular analyses of the Wordfish model, will enable complex interpretations of textual meaning. That Wordfish can be useful for understanding the strange type of discourse that appears in YouTube comments is a fascinating revelation of its own.

# Endnotes

[^1]: It is not possible to fully cover the benefits and limitations of Wordfish in this lesson; see Nanni, et al. (2019) and this blog post by Jeff Antsen for more detail.

[^2]: In lieu of installing R and RStudio on your computer, you may use the cloud version of RStudio: [Posit Cloud](https://posit.cloud/), a web-based version. This lesson will run on Posit Cloud. However, depending on how often you use the cloud version, you may require a paid [subscription](https://posit.cloud/plans).

[^3]: For relevant blog posts on retrieving and analyzing YouTube data, see: 1) the authors' introductory [blogpost](https://sites.temple.edu/tudsc/2018/12/12/how-to-scrape-and-analyze-youtube-data-prototyping-a-digital-project-on-immigration-discourse/); 2) Lemire-Garlic's [blogpost](https://sites.temple.edu/tudsc/2019/04/03/computational-text-analysis-of-youtube-video-transcripts/) on scraping for transcripts; 3) Ania Korsunska's [blogpost](https://sites.temple.edu/tudsc/2019/03/26/network-analysis-on-youtube/?relatedposts_hit=1&relatedposts_origin=5709&relatedposts_position=0) on network analysis of YouTube comment data; 4) and for scoping project design, see Lemire-Garlic's [blogpost](https://sites.temple.edu/tudsc/2019/10/30/to-code-or-not-to-code-project-design-for-webscraping-youtube/).

[^4]: For introductory information about installing R packages, see [Datacamp's guide to R-packages](https://www.datacamp.com/community/tutorials/r-packages-guide).

[^5]: For more on how to interpret Wordfish plots visit our [blog post](https://sites.temple.edu/tudsc/2017/11/09/use-Wordfish-for-ideological-scaling/).
