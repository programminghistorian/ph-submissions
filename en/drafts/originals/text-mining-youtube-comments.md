---
title: "Text Mining YouTube Comment Data with Wordfish in R"
slug: text-mining-youtube-comments
layout: lesson
collection: lessons
date: 2024-MM-DD
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
abstract: In this lesson, you will learn how to download YouTube comments and use the R programming language to analyze the opposing ideological underpinnings within a corpus with the Wordfish algorithm.
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

YouTube is the most popular web-based video sharing platform in the world, with billions of users viewing and uploading videos to it each month. In this lesson, you will learn how to download YouTube comments and analyze the comments as textual data using the natural language processing algorithm Wordfish. Designed for scaling textual data using [unsupervised machine learning](https://en.wikipedia.org/wiki/Unsupervised_learning), Wordfish captures the primary dimensions of latent meaning within a corpus.

This lesson will introduce readers to the way both YouTube videos and the comments written by users in response can be a valuable resource for researchers who are interested in analyzing discourse on the internet. Readers will learn how to use the R programming language and the text mining algorithm Wordfish to explore a collection of YouTube comments. Wordfish is useful for measuring ideological polarity in a set of documents, and for this lesson's sample dataset, we've collected comments submitted by viewers of [Black Lives Matter](https://en.wikipedia.org/wiki/Black_Lives_Matter) videos posted to YouTube by right- and left-leaning news sources in the United States in 2020. 

This lesson will guide you through three key steps for 1) data collection, 2) cleaning and modeling, and 3) analysis and visualization. 

First, this lesson overviews the preparatory steps for gathering data, including considering ethical issues related to downloading and analyzing YouTube data, as well as the basics of installing R and RStudio, and using the open-source [YouTube Data Tools](https://ytdt.digitalmethods.net/) software. The [Data Collection section](#data-collection) then explains how to access and query YouTube’s Application Programming Interface (API) with the user-friendly YouTube Data Tools to download video metadata and comments. A brief discussion explains how to use YouTube Data Tools to search for and download video comments as tabular data (`.csv` file) for further manual or computational analysis with and beyond R. 

Secondly, this lesson introduces how to use R to pre-process and clean YouTube comment data, as well as associated video metadata. YouTube user comments are 'messy', and often contain such semiotic content as numbers, emojis, and URLs which negatively impact some text analysis approaches.  Effective text analysis, and machine leanring modeling using algorithms like Wordfish, requires carefully formatted and simplified text data.

Thirdly, this lesson will teach you how to model YouTube comment data with the Wordfish algorithm, using Ken Benoit's [`quanteda`](https://quanteda.io/index.html) R package. The [Modeling](#Modeling) and [Visualization](#Visualization) sections demonstrate how to computationally analyze the comment data in R using Wordfish.

### YouTube and Scholarly Research

While YouTube has often been associated with entertainment, it is also a place where significant debates – explicit and implicit – about the importance and meaning of current events plays out between politically and socially diverse YouTube viewers. The multimedia platform houses a wealth of culturally-relevant data that researchers and academics have begun to explore.

Built into YouTube’s structure as a video sharing platform is a space for extensive user comments and discussions. While YouTube comments often take the form of short responses to the video and to other comments, their content and purpose can vary widely. These comments frequently reveal ideological leanings, elicited by the commenter's reaction to viewing a specific video, or by seeing another viewers' comment in response to a video.

Recent scholarship on YouTube's political dimensions has often explored the complicated problem of causation between viewing and changing perspectives. For example, qualitative sociological studies of YouTube users havee explored whether users we're radicalized through the platform. While causation can be difficult to measure, YouTube video comments represent a unique body of text – or corpus – of discourse useful for wide-ranging research on how viewers receive and perceive politically charged messages from moving image media.  

Videos, including their titles, related metadata, and content itself, incite a reaction in viewers, where discussions and replies play out often for tens of thousands of comments. These comments can frame subsequent viewers' encounter with the video content, influencing their thoughts, and prompting them to share their interpretations in a reply or new comment, even years after a video has been posted. This means that while the dialogue between comments may represent an immediate back-and-forth between individuals, it can also involve extended hiatus and reactivation of discussion between a different group of participants.

For the purposes of this lesson, we'll analyze an expansive dataset to find broad discursive patterns and features, exploring ideologically salient topics rather than the minutaie of individual interactions. Readers should still consider exploring the temporal dimensions of their own corpus when building upon the methodologies presented in this lesson.

{% include figure.html filename="or-en-text-mining-youtube-comments-2.png" alt="Screenshot of YouTube website featuring video about debates over defunding the police in the United States" caption="Figure 1. Screenshot of YouTube website featuring video about debates over defunding the police in the United States" %}

### Learning Outcomes

This lesson explains how to use the R programming language to analyze YouTube video comments and related video metadata. To acquire the YouTube video comment data, academic researchers can access the YouTube API directly through the [YouTube Researcher Program](https://research.youtube/). For this lesson, you will learn how to use a web-based, API-querying tool,[YouTube Data Tools](https://ytdt.digitalmethods.net/), that does not require the creation of a researcher account. 

This lesson will show how to use the YouTube Data Tool to download video comments and metadata, and then how to code in R to sort and clean the comment data, before analyzing with R the videos' comment data for underlying meaning and ideological bent. Textual data collected through this method can be further analyzed manually or computationally in many additional ways.

For analyzing and visualizing YouTube comment data, this lesson will teach you how to use the R programming language with the Wordfish package - a text analysis algorithm frequently employed by political scientists - to demonstrate one compelling example of how YouTube comment data can be analyzed computationally to understand underlying discursive trends. Often used to study the primary social and political dimensions of texts, Wordfish was designed to serve as a statistical model that can calculate word frequencies (and 'position' scores associated with those words) to determine where each document fits on an 'ideological scale' predominant in the corpus. 

For research purposes, Wordfish is well-suited to identifying, for example, political actors' latent positions from texts that they produce, such as political speeches. When Wordfish analysis has been performed on documents whose primary dimension relates to political issues with clear binary oppositions, scholars have successfully shown the results to reflect the Left-Right scale of political ideology.[^1]

## Data Collection

### Ethical Considerations for Social Media Analysis

Before we begin, it is important to consider the many ethical issues that arise in projects that collect and analyze social media data, as D'Ignazio and Klein argue in [_Data Feminism_](https://mitpress.mit.edu/books/data-feminism). Researchers should consider ethical questions at the start of their research. 

One question to consider is whether public social media data should be used for research without the content creator’s permission? A user who comments on a number of related videos may not have imagined that their patterns of communication would become the subject of public debate within an academic project. While general recommendations can be difficult to make for social media research, to address the issue of privacy, for this lesson, we chose to anonymize user information when downloading comments, as described in the [Downloading Comments and Metadata section](#Downloading-Comments-and-Metadata).

How does researching a group of users with whom the researcher is less culturally familiar risk causing unintentional harm? Who speaks for communities being researched online? Researchers should consider their own cultural context and limitations in interpreting discourse from other cultures and contexts.

There are no clear answers to these challenging questions, but they should nonetheless be asked and studied. Digital Humanities researchers should fully incorporate ethical thinking into the use of their code: not everything that could be mined, analyzed, published, and visualized from YouTube should be.

There are a variety of resources that can help researchers think through such ethical issues. The University of California at Berkeley hosted a conference on ethical and legal topics in June 2020, recorded in the open access book [_Building Legal Literacies for Text Data Mining_](https://berkeley.pressbooks.pub/buildinglltdm/). Review also [the LLTDM website](https://buildinglltdm.org/), as well as the [Association of Internet Researcher’s Ethics page](https://aoir.org/ethics/) and Annette Markham's [Impact Model for Ethics: Notes from a Talk](https://annettemarkham.com/2017/07/impact-model-ethics/).

### Video Selection

The most direct way to select videos for research is to visit the [YouTube](https://www.youtube.com/) site, and capture a list of video IDs: these are the set of alphanumeric characters that appear in the video's URL, immediately after `watch?v=`. 

For example, see the video ID circled in red in the illustration below: `q2l-8-rUM7s`. These IDs are constant and do not change over time. 

{% include figure.html filename="en-or-text-mining-youtube-comments-02.png" alt="Screenshot of YouTube video with video ID in browser link circled in red" caption="Figure 2. Screenshot of YouTube video with video ID in browser link circled in red" %}

For this lesson, we gathered comment data by searching YouTube for 'black lives matter george floyd'. We selected a total of six videos from politically polarized news sources (as ranked by [allsides.com](allsides.com)), from the left-leaning New York Times, Vox, and NBC News, and the right-leaning Daily Mail, Fox News, and the Daily Wire. Choosing multiple videos is often the best approach for the exploratory stages of research, because while YouTube makes available a wide range of metadata about each video (number of likes, title, description, tags and more), the YouTube API may not return comment data for every video searched. 

> You may prefer to simply [download the sample dataset](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/text-mining-youtube-comments/ytdt_data.zip) and focus on the analysis stage, in which case you can skip the next two sections directly to [Setting Up your Coding Environment](#Set-Up-your-Coding-Environment). This dataset was gathered using YouTube Data Tools; you can download it yourself using the same video IDs for YouTube Data Tools, but please note the data would likely differ based on the time you capture the data. In addition, user information was pseudonymized in the [sample dataset]((https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/text-mining-youtube-comments/ytdt_data.zip)) accompanying this lesson.
>

### Curating Data for WordFish
When gathering YouTube comment data for building a Wordfish model, some considerations around the size and shape of the corpus should be taken into consideration. Curating a dataset of YouTube comments for Wordfish requires finding videos with a sufficient amount of data (enough comments, but also enough words per comment) to conduct predictive modeling. Before building the corpus object, you also need to select the video comments to include in the analysis based on relevant metadata, like the video's designated YouTube channel. 

Wordfish modeling is typically performed on corpora of dozens or hundreds of documents, each usually containing hundreds or thousands of words. YouTube comments tend to be very short in length, but popular videos will often be accompanied by thousands of comments; enough to make up for their brevity, as long as the shortest comments are excluded prior to modeling.

For politically salient topics, an ideal dataset will include a similar number of videos from creators representing opposing political perspectives. The video sources representing each side of the political spectrum should contribute a similar number of comments to the total corpus. Finally, the videos should have a substantial number of comments (~2000+) to minimize the skew that outlier comments can introduce. 

While, there is no limit on the total number of videos you could include, 100,000 words are a rough lower limit for an adequately sized dataset for Wordfish modeling. Comments with less than ten words are usually worth removing from the corpus. Therefore, researchers should strive for at least three videos on each side of the spectrum, each containing roughly 2000 comments.

### Querying YouTube's API

We recommend using [YouTube Data Tools](https://ytdt.digitalmethods.net/) to query YouTube’s API. YouTube Data Tools is developed by Bernhard Rieder, Associate Professor in Media Studies at the University of Amsterdam, and supported by the Dutch Platform Digitale Infrastructuur Social Science and Humanities. Rieder maintains and regularly updates the tool to ensure its continuing compatibility with YouTube’s API (for additional info, see the[ Wordfish Github repository](https://github.com/bernorieder/YouTube-Data-Tools). We’ve found it to be one of the best open-source and user-friendly tools available for acquiring YouTube data, because it uses pre-set credentials to access YouTube’s APIv3, saving you from registering your own Google account and keeping up to date on the newest API changes. 

With this tool, you can use video IDs to pull video metadata and comments via keyword search. You can also generate network diagrams of users, videos, and recommended videos. YouTube Data Tool outputs a neatly organized `.csv` spreadsheet of the downloaded comments alongside metadata about the exact time the comment was made, user information, and information about replies. Using this spreadsheet, a simple sort on the **replyCount** column can extract threaded conversations in order to focus on dialogue. The comments alone could also be concatenated into one large text file for topic modeling or other corpus analytics. 

An alternative is to obtain YouTube API authorization credentials from Google so that you can query directly. This is a multi-step and somewhat complicated process, because the workflow changes each year when Google issues updates. If you wish to query the API in R, you can try the [`tuber` package](https://cran.r-project.org/web/packages/tuber/index.html) and register for a Google developer account. While a developer account allows you to incorporate YouTube functionality into your own website or app, it can also be used simply to search and download YouTube content (see YouTube’s API [reference page](https://developers.google.com/youtube/v3/docs) for more information). If you wish to participate in YouTube’s [researcher program](https://research.youtube/how-it-works/), there is a separate application process.

### Downloading Comments and Metadata

Equipped with the video IDs for the videos you selected in the [Video Selection phase](#Video-Selection), navigate to the [Video Comments tab](https://ytdt.digitalmethods.net/mod_video_comments.php) on the YouTube Data Tools site. 

{% include figure.html filename="or-en-text-mining-youtube-comments-9.png" alt="Screenshot of YouTube Data Tools webpage for downloading video comments" caption="Figure 2. Screenshot of YouTube Data Tools webpage for downloading video comments" %}

Enter the first video ID in the _Video id_ field. You can only download comment data pertaining to one video id at a time.

For the _Limit to_ field, we have left it blank, and would recommend doing so.

You have three choices to make about how your data output will be formatted. 

First, for the _HTML output_ parameter, check off the box if you’d like to generate HTML tables of your results in addition to file exports. This gives you a preview of what you are downloading, which can be useful to monitor the downloading process. 

Second, check off _Pseudonymize_ to add irreversible hashes to the comment usernames and ID numbers, rendering them anonymous for the purposes of privacy mentioned in the [Ethical Considerations section](#Ethical-Considerations-for-Social-Media-Analysis).

Thirdly, select .csv in the _File Format_ parameter.

Finally, press _Submit_. 

Repeat this process for each video. More details on this process can be found in Bernhard Reider's [instructional video](https://www.youtube.com/watch?v=EnTy_pbkCfM).

For each video ID you enter, YouTube Data Tools will download four files: 
- The file with the suffix `comments.csv` contains the text of each video comment.
- The file ending `basicinfo.csv` comprises the video metadata.
- The files ending in `commentnetwork.gdf` and `authors.csv`, which you don't need for this lesson.

Save the four files associated with each video into their own folder, using the video ID as the folder’s name. (As mentioned above, you won't need all four files for this lesson, but they contain additional information that might be useful for further research.) Next, create a master directory titled `ytdt_data` and save each of these folders inside. You will be using the `ytdt_data` folder in the code below.

## Set Up your Coding Environment

### Install R and RStudio

Once you have collected your data (or downloaded the sample dataset directly from this lesson's [`/assets` folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/text-mining-youtube-comments) on the _Programming Historian_ Github repository), the next step to mining YouTube comment data is to prepare the R programming workspace. R is an open-source coding language with more available statistical algorithms than many proprietary softwares. 

This lesson was written for R version 4.3.2 (but should work with newer versions). You can download R from the [Comprehensive R Archive Network](https://cran.r-project.org/). Make sure you select the installer corresponding to your computer’s operating system – if needed, you can refer to Taryn Dewar’s lesson [R Basics with Tabular Data](https://programminghistorian.org/lessons/r-basics-with-tabular-data), which covers how to install R and become familiar with it.

RStudio Desktop is the recommended [integrated development environment](https://en.wikipedia.org/wiki/Integrated_development_environment) for writing and running R scripts. The free version is more than sufficient. You can download and install RStudio from [rstudio.com](www.rstudio.com) - again, make sure you select the installer appropriate to your computer’s operating system.[^2]

The code used in this script includes packages and libraries from standard R as well as from the [Tidyverse](https://www.tidyverse.org/). [Basic Text Processing in R](https://programminghistorian.org/lessons/basic-text-processing-in-r) by Taylor Arnold and Lauren Tilton provides an excellent overview of the knowledge of R required for text analysis. To learn more about Tidyverse, there are many great sources online, including [_A Tidyverse Cookbook_](https://rstudio-education.github.io/tidyverse-cookbook/program.html) by Garrett Grolemund.

The R script for this lesson and the sample data are [available to download](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/text-mining-youtube-comments). The rest of this lesson will walk through the steps needed to create an R script from scratch, writing out each step of the same code we have made available for download. This lesson can of course also be adapted to alternative datasets downloaded through YouTube Data Tools.

### Install R Libraries

To begin from scratch, you’ll create a new R script and install a series of packages.[^3] 

>To run this program, you'll want to install these versions of the necessary libraries:
>- `tidyverse 2.0.0` (containing necessary packages `ggplot2`, `purrr`, `dplyr`, as well as `lubridate 1.9.3`) 
>- `quanteda 3.3.1` 
>- `quanteda.texmodels 0.9.6`
>- `quanteda.textplots 0.94.3`
>- `stringi 1.8.3` 

To install the necessary packages in R, run the following code:

```
install.packages(c("tidyverse", "quanteda", "quanteda.textmodels", "quanteda.textplots", "stringi"))

```

To load the packages necessary for data cleaning and wrangling into your R coding environment, run the following code: 

```
library(tidyverse); library(lubridate); library(ggplot2); library(purrr); library(stringi); library(stringr)

```
The remaining packages will be loaded later in the tutorial.

## Data Preparation

Now, you can begin to explore the data you’ve downloaded. To read in a `.csv` of previously-downloaded comments and metadata, you can use the code supplied below. This code iteratively reads in all of the comment data from the `comments.csv` files in the `ytdt_data` folder, using the `read_csv` function from the `tidyverse` package. Afterwards, this section of code proceeds to read in the metadata from the `basicinfo.csv` files, and import data from each file to create a single `.csv` that contains both the video comment text and video metadata.

First, read in the comment data with the following code:
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

Next, load in the files containing video data:

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

To confirm channel titles and the number of comments per channel, simply input `all_videos` to print the results. Finally, run the following code to join the video and comment data:

```
all_data <- inner_join(all_comments, all_videos)
count(all_data, sort(videoChannelTitle))
```

Alternatively, if you are using our sample data, you can read it in with the following code: 

```
all_data <- read.csv("ytdt_data/all_data.csv")
```

You may also choose to use a YouTube comment dataset downloaded with a tool other than YouTube Data Tools. However, if you do, you’ll first need to ensure it is formatted the same way by reordering and re-naming its columns as applicable.

### Data Labeling

If you are using the data taken from the YouTube video IDs we’ve chosen for this lesson (whether you've downloaded it using YouTube Data Tools or our sample dataset), you will also need to add a partisan indicator: our case study project investigates comment discourse across left- and right-leaning video channels, so this partisan indicator allows us to later visualize and compare where video comments are positioned on the ideological scale, based on the political affiliation of each video’s creator.

If you are using your own data, consider whether an indicator could be useful to help you visualize differences between groups of videos - such as videos from specific channels, or other logical groupings of videos within your dataset. 

The code for creating an indicator is straightforward. Simply create a new column and then specify which video channels should be associated with each indicator value:

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

### Pre-processing

In this section, we explain how to clean and pre-process the comment data you’ve collected to make it usable for text data mining. 

As noted above, the unique properties of YouTube comments (such as rare words, slang, other languages, or comments that include special characters or emojis), mean that some initial data cleaning is necessary to ensure that each comment contains enough meaningful text data for Wordfish scaling. Comments with little or no usable text data need to be removed, because they will cause substantial skew in a Wordfish model: the model relies on scores given to words within semantically meaningful prose, and comments with fewer than 10 words are unlikely to contain such meaning. This can impact the meaningfulness of results, or may cause the scaling process to fail entirely.

If you are using an alternative analytical model, you may choose to retain emojis, links, numbers, mentions, or other details.

### Remove Stopwords and Punctuation

The first pre-processing step is to remove stopwords, which are common words that provide little to no semantically meaningful information about your research question. As [Emil Hvitfeldt and Julia Silge](https://smltar.com/stopwords) explain, whether commonly excluded words would provide meaningful information to your project depends upon your analytical task. For this reason, researchers should think carefully about which words to remove from their dataset.

During exploratory modeling, we found that the words 'bronstein', 'derrick' and 'camry' are outliers in our specific dataset, appearing at the lower left and right ends of the Wordfish distribution due to their extremely negative `psi` values, which indicate those words are extremely rare in the overall corpus. When interpreting the horizontal scale created by the model, the most meaningful language to analyze are often the relatively common and highly polarizing words on each side of the distribution. Rare outlier words can often be a distraction; for this reason, you may wish to remove these outliers from the visualization. 

The following code creates a custom stopword list that combines researcher-defined stopwords alongside the standard stopword list supplied in the `quanteda` computational text analysis package. To change the custom stopwords, simply replace our words with your own. As you conduct exploratory analysis, if you come across obvious outlier words, we recommend you add these outliers to your stopwords list.

```
library(quanteda)

my_stopwords <- c(stopwords("en"), "brostein", "derrick", "camry")

all_data$text <- all_data$commentText %>%
  str_to_lower() %>%
  str_remove_all(str_c("\\b", my_stopwords, "\\b", collapse = "|"))  
```

Using the `stringr` package from the `tidyverse`, and the `stringi` package from `base R`, the following code further cleans the text data. This additional pre-processing step takes a second swipe at removing any remaining numeric digits, punctuation, emojis, links, mentions, and comments with fewer than 10 total words. Further to this, the following code removes duplicate comments and places the cleaned data into a column titled **uniqueWords**:

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

Note you can also perform this step using the `quanteda` R package (used to remove stopwords above). We recommend `stringr` and `stringi`, especially if you want to export cleaned data to a user-readable format to perform other analytics, beyond the Wordfish modeling demonstrated in the second half of this lesson. For further guidance on using the `quanteda` package, we recommend the University of Virginia Library’s useful overview of its functionalities, [A Beginner's Guide to Text Analysis with quanteda](https://library.virginia.edu/data/articles/a-beginners-guide-to-text-analysis-with-quanteda).

To export your cleaned data for preservation, curation, or other forms of analysis, use the `write_csv` function in R as follows:

```
write.csv(all_data, "cleaned_all_data.csv")
```

Now, the comment data is in a shape that can be transformed into a format friendly for Wordfish analysis.

## Modeling

A wide range of text mining algorithms are available for scholars in the Digital Humanities who want to create models of big data. Many of these algorithms have already been described with tutorials by _Programming Historian_ - see, for example, [word frequency analysis](https://programminghistorian.org/en/lessons/counting-frequencies) and [topic modeling](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet). The text mining algorithm we will use in this lesson is called Wordfish. For information on the algorithm itself and to view its base code, see [the Wordfish website and documentation](http://www.Wordfish.org/software.html).

Developed by and for political scientists, Wordfish models textual data along a single-dimensional axis. It was created as a method for extracting the ideological leaning of documents expected to contain latent political motivation or ideology (e.g., party manifestos, politician's floor speeches) relative to a corpus of similar texts. For example, Wordfish can be a useful tool for identifying whether United States representative floor speeches were made by Democrats or Republicans - as well as the extremity of the partisan leaning conveyed in those speeches.

### Interpreting Wordfish

A Wordfish model gives two kinds of information, without the need for any prior pre-coding of documents or 'supervision'.

First, Wordfish gives information about how documents (in this case, individual comments) are best differentiated from each other, by scaling them along a single dimension. In essence, the model collects comments that are similar to each other on each end of the dimension, based on the kinds and frequencies of words used in those comments. Comments on far opposite ends of this scale in particular types of discursive contexts may be characterized by the inclusion of different sets of unique words, indicating focus on different kinds of concepts. 

Second, Wordfish develops a scale to describe the polarization of words within a corpus, and then arranges those words along an analogous dimension to the document scale. Although the document scale is often the desired output of a Wordfish model, the placement of words along this scale is usually more informative than document scaling for understanding the overall meaning of the scale.

Scaling documents is less inherently meaningful without additional information: including metadata about the source of documents (in this case, the partisanship of the video contributing the comment) can be very helpful for determining whether the greatest differences exist within a given data source, or between data sources. For example, you might be able to see that comments from certain videos with shared perspectives are clustered together.

### Document Feature Matrices (DFM)

Wordfish uses a Document Feature Matrix (DFM) to make its predictions about the placements of documents along this uni-dimensional scale.

A DFM is a tidy, structured format that stores data about the frequency of different words used in each document of a corpus. The 'quanteda' documentation includes [guidelines on creating DFMs](https://quanteda.io/reference/dfm.html). Structured as a two-dimensional matrix with each document assigned a row, each column in a DFM designates textual 'features' (the words used across the vocabulary of all documents combined). The cells in this matrix indicate whether a given feature appears in each document or not.

The DFM approach is similar to the tried and true [topic modeling](http://www.cs.columbia.edu/~blei/papers/Blei2012.pdf) method: both are predictive modeling approaches that rely on machine learning algorithms to mine text data and/or process natural language. Furthermore, both Wordfish and topic modeling involve 'unsupervised' methods: they don't rely on the user pre-coding some portion of the data before modeling. Instead, these two algorithms both look at differences between documents, identifying natural groupings along a dimensional scale by comparing the frequencies of the same words between different documents. Both models identify and weigh more heavily words whose frequency varies most between documents, relying on these word patterns to cluster documents along the scale.

Another important similarity between Wordfish and topic modeling is that both treat documents as ['bag of words'](https://en.wikipedia.org/wiki/Bag-of-words_model). This means that the models only look at word frequency, and ignore word order: it doesn’t matter ***where*** words occur in a document, just ***which*** words occur, and with what frequency.  

Bag-of-words modeling can be problematic for longer texts where different sections of content (paragraphs, pages, chapters) might convey different types of meaning depending on their context. But social media comments tend to be very short and usually only discuss a single idea, so the bag-of-words approach is unlikely to miss key information.

A significant shared strength of both models is their ability to refine results by passing over the data multiple times. When a Wordfish model is initialized, all of the parameters it measures are a ‘first best guess’ at the latent scaling of documents and words, which gives a helpful level of general insight. Depending on the quality of the text data, these models are then able to refine their initial predictions, gradually closing in on even more statistically robust and insightful models.

The key differences between Wordfish scaling and topic modeling, however, are the specific statistical approaches taken, and their most useful outputs. Topic models can generate any number of topics discussed in a corpus, whereas Wordfish always scales on a single dimension (thus limitied to two topics) – but it provides much more under-the-hood information about the contribution of each word and document to the formation of this scale.

### Latent Meaning

Although Wordfish was initially developed by political scientists for researching political ideology, there is nothing inherently political about the dimension that it reveals: Wordfish can be used to extract latent dimensionality (based on broad differences in word usage) within any kind of corpus. The substantive interpretation of this latent dimension depends entirely on the content your research corpus.

For example, imagine you are studying a corpus where your documents are all about cats and dogs, but you don't know which documents are about which animal. A Wordfish model would determine which documents are likely to be about cats and which are likely about dogs, as well as how 'cat-typical' or 'dog-typical' each document is. Very 'catty' or 'doggy' documents would be placed at the extreme opposite ends of this salient dimension. Documents in the intermediate zone (because they are roughly equally about cats and dogs, or because they are about neither cats nor dogs) would appear towards the center of the predicted dimension. 

There are many underlying factors that can drive the latent scaling dimension identified by a Wordfish model. If content is strongly motivated by the author’s political ideology, this dimension can separate texts from authors on opposing sides of a political issue. Wordfish brings into relief broad differences in content, based on the kinds of words used by each speaker.

### Create a Corpus in R

The [Wordfish](http://www.wordfish.org/) algorithm was initially distributed as a stand-alone R package (still available on the [Wordfish website](http://www.Wordfish.org/software.html)), but is now available in the [`quanteda`](https://quanteda.io/) package. This enables seamless wrangling of YouTube comment data into a useful format [to run the Wordfish algorithm](https://tutorials.quanteda.io/machine-learning/wordfish/). For more documentation, visit Quanteda's [docs and tutorials page](https://quanteda.org/quanteda/).

To run the Wordfish model in `quanteda`, you must create three types of text data objects: a corpus, tokens, and a DFM. For more detail on how these objects work together, see quanteda's [quick start page](https://quanteda.io/articles/quickstart.html#how-a-quanteda-corpus-works-1).

The corpus contains all of the documents that can be analyzed (in our case, each comment represents one document) as well as some metatdata describing the documents' attributes. Here, this may be the video channel title to which the comment was associated, as well as the partisanship indicator introduced in the [Data Labeling section](#Data-Labeling).

In `quanteda`, the tokens are a list of character vectors linked back to the document from which they originated. This form allows the text to be further cleaned and pre-processed. Tokens can be stemmed or lemmatized, and stopwords can easily be removed. You already pre-processed the corpus in the [Pre-processing section](#Pre-processing), but the approach offered by `quanteda` works slightly differently, so you might wish to test which works best for you and your data - and there's no harm in using both.

Note that when running the code to build your corpus, the processing may take a few minutes, or even longer. If it does, that's a good sign! It means your data is optimal for Wordfish modeling, and the model you produce will more likely be insightful and accurate.

#### Select Comments

To initiate the steps leading to creating the Wordfish model itself, first select the specific columns that you would like to include in your model. The following code selects the comment text (the **uniqueWords** column), as well as the video channel title, the partisan indicator, and the unique **commentId** automatically generated by YouTube.

```
wfAll <- select(all_data, commentId, uniqueWords, videoChannelTitle, partisan, numbWords)

```

#### Build Corpus Object

Execute the following code to build your corpus:

```
options(width = 110)

corp_all <- corpus(wfAll, docid_field = "commentId", text_field = "uniqueWords")
summary(docvars(corp_all))
```

#### Data Transformation

Next, we will [tokenize](https://en.wikipedia.org/wiki/Lexical_analysis#Tokenization) in order to create the DFM. We can use `quanteda`’s `token` function to remove any punctuation, symbols, numbers, URLs, and separators. After this pre-preoccessing, we'll create a DFM and feed it into the Wordfish model.

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

#### Data Optimization

Now, we will optimize the corpus to focus on meaningful words only. The following code removes words with fewer than four characters, as well as rare words (those that appear in less than 1% of documents, or that comprise less than .001% of the total corpus).

```
dfmat_all <- dfm_keep(dfmat_all, min_nchar = 4)
dfmat_all <- dfm_trim(dfmat_all, min_docfreq = 0.01, min_termfreq = 0.0001, termfreq_type = "prop")

print(dfmat_all)
```

You may want to adjust these values to optimize the model for your own data. Consult the `quanteda` documentation on [dfm_trim](https://quanteda.io/reference/dfm_trim.html) for additional optimization options.

#### Verification

After optimizing the corpus, it is helpful to manually review the 25 most frequently occurring words to get a sense of the comments’ overall substance. 

If you notice words among the top 25 that have limited semantic meaning, consider adding them to your custom stopwords list, and running the subsequent code again. For example, you might consider removing a contraction like 'didn't' - although, as you will see later, these common words have relatively little impact on the overall model, compared to rarer and more polarizing words.

The following lines of code print the most frequently occurring 25 words, ready for manual review:

```
topWords <- topfeatures(dfmat_all, 25, decreasing = TRUE) %>% names() %>% sort()
topWords
```

After fine-tuning the most frequently occurring 25 words in the corpus, you can move onto creating the Wordfish model.

### Build Wordfish Model

To create a Wordfish model based on the corpus of unique comments you have assembled, run the following code:

```
library(quanteda.textmodels)

tmod_wf_all <- textmodel_wordfish(dfmat_all, dispersion = "poisson", sparse = TRUE, residual_floor = 0.5, dir=c(2,1))
summary(tmod_wf_all)
```

Some computers may take a while to process the data when building the Wordfish model, depending on the number of documents in your corpus, and the number of times the model iterates. Remember: at this point, more iterations are a good sign, so be patient.

## Visualization and Analysis

Now that the model has run, you can visualize its output. Wordfish models are well-suited for two distinct kinds of visualizations: a 'document-level' visualization and a 'word level' visualization, both of which are scaled along horizontal and vertical axes. 

The convention is to assign ideological polarity along the horizontal axis, while the vertical axis reflects a 'fixed effect'. In 'word level' visualizations, the fixed effect is each word's relative frequency, used to show dispersion across the corpus object; in 'document level' visualizations, the fixed effect is a value representing the relative length of each document.[^4] 

The code below will create 'word level' visualizations. You can use Quanteda's `textplot_scale1d()` function, setting the margin parameter to 'features'. This function plays well with `ggplot2`, so you can use the `ggplot2` '+' to add components to the base plot. This lesson uses the `labs()` component to create a label for the plot.

### Unique Words

To produce custom visualizations, we draw from Wordfish's underlying statistics and use `ggplot2` to make the plots. Run the following code to produce a plot of all the unique comment words found within the corpus:

```
library(quanteda.textplots)

wf_feature_plot <- textplot_scale1d(tmod_wf_all, margin = "features") + 
  labs(title = "Wordfish Model Visualization - Feature Scaling")
wf_feature_plot
```

{% include figure.html filename="or-en-text-mining-youtube-comments-10.png" alt="Visualization of WordFish model showing relative placement of features (words) with outliers circled in red" caption="Figure 3. Visualization of Wordfish model showing relative placement of features (words) with significant words circled in green, and outliers circled in red" %}

This visualization shows every word found in the corpus of comments. Note how it is roughly symmetric around the vertical axis, and how some words are projected further out from the sloping sides of the model than others (indicated by the large green ovals displayed midway down the sloping sides of Figure 3). These conspicuously displayed words are the strongest indicators of what each pole of the scaled dimension (along the horizontal axis) represents.  

On the left, _knee_ and _neck_ are displayed almost on top of each other (see the smaller, heavier weight green circle). This indicates that those two words are both strongly - and about equally - predictive of a document being placed on the left side of the scaling dimension - and that they occur at virtually the same frequency. Given the subject matter of this dataset, this is an expected - if stark - result.  

Along the right slope, note words like _americans_, _protest_, _african_ and, a little deeper in the field of text, _violent_.  These words are predictive of a document being placed on the right pole of the scaling axis. 

Words displayed on the left side of this data visualization refer more directly to the event of George Floyd's murder itself, and may have been a stronger focal point for commenters identifying with the political left, which was outraged and protesting racist police brutality. Words on the right refer more broadly to social forces, violence, consequences, and other international concerns. These may be more indicative of commenters approaching the issue from the political right - although we caution the researcher against reading too much into any single finding without replicating their study and performing additional in-depth research.

### Removing Outliers

While the first visualization produced out of this particular YouTube comment dataset reads pretty well, some of the words at the bottom side corners of the visualization (indicated by red ovals) are largely irrelevant to the analysis. We already removed even more extreme outlier words from our dataset earlier, in the [Remove Stopwords and Punctuation section](#Remove-Stopwords-and-Punctuation). Even after cleaning your dataset, it is common for the process of Wordfish modeling to dredge up additional outlier words that you wish to remove from the visualization. 

While the inclusion of these outliers words have little effect on the overall model's structure, they distract from visualizing the more important words (especially like those enclosed by the green ovals in Figure 3). Unless the researcher has good reason to believe outlier words are meaningful to their analysis, it is better to remove them and maximize focus on the more densely populated parts of the visualization.

Below, we provide code to remove additional outlier words (for our data, those circled in red in Figure 3). After removing the outlier words, this chunk of code re-runs the Wordfish model and produces a new word-level visualization:

```
more_stopwords <- c("edward", "bombed", "calmly")
dfmat_all <- dfm_remove(dfmat_all, pattern = more_stopwords)

tmod_wf_all <- textmodel_wordfish(dfmat_all, dispersion = "poisson", sparse = TRUE, residual_floor = 0.5, dir=c(2,1))
summary(tmod_wf_all)

wf_feature_plot_more_stopwords <- textplot_scale1d(tmod_wf_all, margin = "features") + 
  labs(title = "Wordfish Model Visualization - Feature Scaling") 
wf_feature_plot_more_stopwords
```

{% include figure.html filename="or-en-text-mining-youtube-comments-8.jpg" alt="Visualization of WordFish model showing relative placement of features (words) with outliers removed" caption="Figure 4. Visualization of Wordfish model showing relative placement of features (words) with outliers removed" %}

For this lesson, we removed three additional stopwords, so that the center part of the visualization is of greater interest. Again, it is the words that project off the sloping sides of a balanced Wordfish feature visualization that are the most descriptive of the primary dimension - those very far down on the vertical axis may be polarizing, but are also very rare, and therefore are unlikely to be as explanatory of that dimension.

You can export this visualization as a `.jpeg` image file by running the following line of code:

```
ggsave("Wordfish Model Visualization - Feature Scaling.jpg", plot=wf_feature_plot_more_stopwords)
```

Note that the image quality from `ggsave` isn't always ideal. You may have better results using the _zoom_ button in RStudio to zoom in on your visualizations, and then manually saving them as `.jpeg` image files by right clicking on the pop-up window, or otherwise taking a screenshot. 

### Analyzing the Visualization

Visualizing partisanship can be a useful means for discourse analysis of a corpus's political polarity based on the most salient, opposing ideological stances.

The second method of visualization presented in this lesson displays data at the document  level. The visualization highlights opposing sides of the corpus' salient topic by coloring each document's unique plot point, arrayed along the horizontal scale. 

To create this color coded visualization, run the following code:

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

Blue plot points represent comments from left-leaning channels, and red plot points represent comments from right-leaning channels (based on the partisan indicators we assigned to the data). 

Note in the following visualization that the colors are not clearly grouped! 

{% include figure.html filename="or-en-text-mining-youtube-comments-7.jpg" alt="Visualization of WordFish model showing relative comment placement color-coded by partisanship of video channel" caption="Figure 5. Visualization of WordFish model showing relative comment placement color-coded by partisanship of video channel" %}

If comments posted on right-leaning videos were consistently and systematically different from comments on left-leaning videos, we would expect clear clustering and separation. The fact that this divide does not manifest in the visualization suggests that left-leaning and right-leaning commenters are both commenting on a variety of different videos. 

The small cluster of blue out to the far right of this visualization suggests that some of the most polarizing comments were added on videos from left-leaning channels. Otherwise, based on this visualization, the channel's political affiliation does not seem to be a strong predictor of the commenters' political positions. 

When conducting your own research, remember to update the partisan indicator described in the [Data Labeling section](#Data-Labeling) to match your own research topic and questions.

## Conclusion

By this point of the lesson, you have downloaded a large corpus of YouTube video comments, processed them, analyzed them using the Wordfish model of text scaling, and produced several insightful visualizations. You can reuse the code in this lesson on your own YouTube comment dataset - to download the code for easy re-use, see the attached [R script](/ph-submissions/assets/text-mining-youtube-comments/youtube.R).

If you used this lesson's data, you can tell from these three visualizations that a broadly similar set of topics is discussed on comment threads for both left-leaning and right-leaning YouTube videos focused on police brutality and police funding. You have also seen that you can interpret these visualizations to discover which words determined the scale created by the Wordfish model, and which videos contributed to each pole of that scale. 

These visualizations, and more granular analyses of the Wordfish model, will enable complex interpretations of textual meaning. The fact that Wordfish can be useful for understanding the strange type of discourse that appears in YouTube comments is a fascinating revelation of its own.

## Endnotes

[^1]: It is not possible to fully cover the benefits and limitations of Wordfish in this lesson. For more detail, see [Nanni, et al. (2019)](https://arxiv.org/pdf/1904.06217), as well as Luling Huang's excellent blogpost on the Temple Libraries' Scholars Studio blog, [Use Wordfish for Ideological Scaling: Unsupervised Learning of Textual Data](https://sites.temple.edu/tudsc/2017/11/09/use-wordfish-for-ideological-scaling/).

[^2]: In lieu of installing R and RStudio on your computer, you may use the cloud version of RStudio: [Posit Cloud](https://posit.cloud/), a web-based version. This lesson will run on Posit Cloud. However, depending on how often you use the cloud version, you may require a paid [subscription](https://posit.cloud/plans).

[^3]: Related work on analyzing YouTube data developed out collaborations among graduate students at Temple University Libraries' Loretta C. Duckworth Scholars Studio, which produced a series of relevant blog posts introducing a range of methods for retrieving and analyzing YouTube data. For more info, see: 1) the authors' introductory blogpost on Temple University Libraries Scholars Studio blog, [How to Scrape and Analyze YouTube Data: Prototyping a Digital Project on Immigration Discourse](https://sites.temple.edu/tudsc/2018/12/12/how-to-scrape-and-analyze-youtube-data-prototyping-a-digital-project-on-immigration-discourse/); 2) Nicole Lemire-Garlic's blogpost [To Code or Not to Code: Project Design for Webscraping YouTube](https://sites.temple.edu/tudsc/2019/10/30/to-code-or-not-to-code-project-design-for-webscraping-youtube/); 3) Lemire-Garlic's [Computational Text Analysis of YouTube Video Transcripts](https://sites.temple.edu/tudsc/2019/04/03/computational-text-analysis-of-youtube-video-transcripts/); and 4) Ania Korsunska's [Network Analysis on Youtube: Visualizing Trends in Discourse and Recommendation Algorithms](https://sites.temple.edu/tudsc/2019/03/26/network-analysis-on-youtube).

[^4]: For introductory information about installing R packages, see [Datacamp's guide to R-packages](https://www.datacamp.com/community/tutorials/r-packages-guide).
