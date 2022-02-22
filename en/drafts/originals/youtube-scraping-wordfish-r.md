---
title: "Text Mining YouTube Comment Data with Wordfish in R"
collection: lessons
layout: lesson
slug: youtube-scraping-wordfish-r
date: 2022-02-22
authors:
- Alex Wermer-Colan
- Nicole Lemire-Garlic
- Jeff Antsen
editors:
- Nabeel Siddiqui
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/374
---

{% include toc.html %}

# Part I: Introduction to YouTube Scraping and Analysis


## Introduction to YouTube and Web Studies

YouTube is the most popular web-based video sharing and viewing platform in the world. According to YouTube, billions of users view and upload videos each month. During COVID-19, vast numbers of people tuned in to YouTube for advice on quarantining, “how to” videos, and more. As the world’s most utilized platform for video sharing, YouTube houses a wealth of culturally-relevant data that researchers and academics are only beginning to explore.  

YouTube is markedly intertextual—each page includes multiple forms of mediated communication that refer to one another. Algorithmically recommended videos, user comments, and advertising videos appear dynamically on the same screen as the video originally posted for sharing.  

![A picture of using YouTube](images/PH_YouTube_defund_screenshot.png)

Media studies scholars have historically considered how media texts reflect and inform public debate on political issues. Web studies as a field has converged in the last couple decades, with the formation of organizations such as the [Association of Internet Researchers](https://aoir.org). Web scraping has become relatively common in digital humanities circles, with Twitter being the most common platform for analysis. Discussion boards and social media platforms like Reddit, as well as Instagram and Facebook, are increasingly being mined by researchers.  

Although YouTube is best known for its entertainment and “how to” content, it hosts discussions on politically salient topics as well. YouTube’s hosting of political content has not been without controversy. Media reports claim that YouTube radicalizes its viewers, [creating far-right radicals](https://www.nytimes.com/interactive/2019/06/08/technology/youtube-radical.html). In today’s hypermediated world, when politics are polarized and the algorithms that curate recommended content are themselves politicized, [YouTube has increasingly become a focus of scholarly study and debate](https://scholarcommons.scu.edu/cgi/viewcontent.cgi?article=1101&context=comm). One academic study traced a [radicalization pipeline](https://dl.acm.org/doi/abs/10.1145/3351095.3372879) (a progression of users who initially comment on less radical videos and subsequently engage with fridge content). And, for both political and apolitical content, YouTube has been investigated by the [U.S. Federal Trade Commission](https://en.wikipedia.org/wiki/Federal_Trade_Commission) for its [recommendation algorithms leading young users to illicit content](https://www.vox.com/the-goods/2019/12/20/21025139/youtube-kids-coppa-law-ftc-2020).  

**This tutorial** explains how to use the R programming language for web scraping and analysis of YouTube metadata and comment data. Through this tutorial, you will learn how to access the YouTube API, process and clean the video metadata, and analyze the comment threads for ideological scaling. We focus on an understudied text mining algorithm named Wordfish, that is used in political science to study the political dimensions of text. The tutorial will explore the complexities of curating web data for creating meaningful computational models of video reception discourse.  

## User-Friendly YouTube Scraping

This tutorial will walk through R code for downloading data from YouTube and analyzing it with Wordfish, using as our sample data a series of videos about the politics of the 2020 Black Lives Matter call to defund police. In our sample, we used specific videos to download relevant comments through the YouTube API. The API will be discussed in detail below, in the YouTube API section.

Both the R script and the sample data are available for download on the [Programming Historian YouTube Wordfish Github repository](https://github.com/hawc2/Programming-Historian-Tutorial). You can also copy and paste the code from this tutorial and create your own script with your own specific video list or broader search term(s). No matter which method you use, you’ll need to create authorization credentials with YouTube to have access to their API. 

While this tutorial will demonstrate how you can scrape and analyze YouTube entirely with the R programming language, the acquisition of YouTube data can also be performed using available web-apps. One of the best open-source and user-friendly tools available for acquiring YouTube data is _YouTube Data Tools_ hosted by the $\text{\underline{University of Amsterdam’s Digital Methods Initiative}} ?? hopefully this underlines! ??. The scraper uses its credentials to access YouTube’s APIv3, saving you the step of registering for your own.  

With this YouTube scraper, you can pull user comments, metadata about a YouTube channel, and videos via keyword search. You can also create networks of users, videos, and recommended videos. With a few button clicks, the software will scrape comments, emojis intact. All you need is the video ID—the last few characters of the YouTube site for that video (***e.g.***, SNWic0kGH-E). (See the Keyword Searching section below for an illustration of where to locate the ID.)  

What the scraper outputs is a neatly organized .csv spreadsheet of the scraped comments alongside metadata about the exact time the comment was made, user information, and information about replies. Using this spreadsheet, a simple sort on the “replyCount” column can extract threaded conversations in order to focus on dialogue. The comments alone could also be concatenated into one large text file for topic modeling or other corpus analytics. [^1]  

[^1]: For relevant blog posts on scraping YouTube for other forms of analysis, see the following blog posts: 1) For a digital project studying YouTube, check out the team's introductory [blogpost](https://sites.temple.edu/tudsc/2018/12/12/how-to-scrape-and-analyze-youtube-data-prototyping-a-digital-project-on-immigration-discourse/); 2) For scraping Youtube transcripts, see Lemire Garlic's [blogpost](https://sites.temple.edu/tudsc/2019/04/03/computational-text-analysis-of-youtube-video-transcripts/); 3) For network analysis of Youtube data, see Ania Korunska's [blogpost](https://sites.temple.edu/tudsc/2019/03/26/network-analysis-on-youtube/?relatedposts_hit=1&relatedposts_origin=5709&relatedposts_position=0); 4) For scoping project design, see Lemire-Garlic's [blogpost](https://sites.temple.edu/tudsc/2019/10/30/to-code-or-not-to-code-project-design-for-webscraping-youtube/); 5) And for secondary sources, see our in-progress Zotero reading list on [Youtube Studies](https://www.zotero.org/groups/2420013/youtube_studies). 

## Ethics, Privacy, and Legality of YouTube Scraping and Analysis

There are a number of ethical and legal literacies in relation to [“data justice”](https://mitpress.mit.edu/books/data-feminism) that require attention in web scraping DH projects. Should “public” social media data be used for research without the content creator’s permission? A user who comments on a number of related videos may not have imagined that their patterns of communication would become the subject of public debate through an academic project. Does researching a group of users with whom the researcher is less culturally familiar open the door to causing unintentional harm? Who speaks for communities being researched online? These are challenging questions for which there are not clear answers, but questions that should nonetheless be asked.  

We believe DH researchers should fully incorporate ethical thinking in the use of our code. Not everything that could be scraped, analyzed, published, and visualized from YouTube should be.  

In addition to ethical challenges that arise in this work, there are several legal frameworks that come into play when web scraping: [copyright](https://en.wikipedia.org/wiki/Copyright), [digital locks](https://www.eff.org/files/filenode/drm_pager_fnl.pdf), and [terms of service agreements](https://en.wikipedia.org/wiki/Terms_of_service). We cannot provide legal advice on these topics, but do not discern any legal issues with our work. Before engaging in your own YouTube research, we strongly recommend that you consult with librarians and legal professionals about your specific project. We’ve also incorporated ethical and legal literacy resources in the footnotes below for further reading.[^2]  

[^2]: The University of California at Berkeley hosted a conference on these and related topics in June 2020: Building LLTDM - Legal Literacies for Text Data Mining. We found this conference insightful and useful in thinking through our ethical commitments and legal concerns. For more information, we highly recommend reviewing [their website](https://buildinglltdm.org/). We further recommend the [Association of Internet Researcher’s Ethics page](https://aoir.org/ethics/), and the resources included in the footnote# below.

Having addressed these critical issues, we now turn to the “how to” of scraping, wrangling, and analyzing YouTube data.  

## Introducing R and R Studio

R is an open-source programming language with more statistical tools than many proprietary statistical tools like STATA (*Software for Statistical Analysis and Data Science*). This lesson was written for R version 4.1. You can download R from the [Comprehensive R Archive Network](https://cran.r-project.org/). 

Select the installation corresponding to your computer’s operating system and choose base to download the installer for R to run it for the first time. Taryn Dewar’s lesson [R Basics with Tabular Data](https://programminghistorian.org/lessons/r-basics-with-tabular-data) covers how to install R and become familiar with it.  

RStudio Desktop is the recommended [integrated development environment](https://en.wikipedia.org/wiki/Integrated_development_environment) for writing and running R scripts. The free version is more than sufficient. This lesson was written for RStudio Version 1.3. You can download and install RStudio from [rstudio.com](www.rstudio.com). Download and run the Installers for Supported Platforms appropriate to your computer’s operating system.[^3]

[^3]: In lieu of installing R and RStudio on your computer, you may use [RStudio Cloud](https://rstudio.cloud/), a web-based version. This tutorial will run on RStudioCloud. However, depending on how often you use the cloud version, you may require a paid [subscription](https://rstudio.cloud/plans/free).

The R script and related materials for this lesson are available on the corresponding [Programming Historian YouTube Wordfish Github repository](https://github.com/hawc2/Programming-Historian-Tutorial). The code used in this script includes packages and libraries from standard R and Tidyverse. For background info on the basics of the R programming language, [Basic Text Processing in R](https://programminghistorian.org/lessons/basic-text-processing-in-r) by Taylor Arnold and Lauren Tilton provides an excellent overview of the knowledge of R required for text analysis. To learn more about Tidyverse, there are many great sources online, including [A Tidyverse Cookbook](https://rstudio-education.github.io/Tidyverse-cookbook/program.html) by Garrett Grolemund.

To call the YouTube API, wrangle the data, run a Wordfish analysis, and visualize the data, you’ll need to install a series of packages.[^4] The versions of the libraries necessary to currently run this program are Tidyverse 1.3 (containing necessary packages ggplot2, purrr, dplyr), as well as tm 0.7.7, gtools 3.8.2, lubridate 1.7.9, austin .2, tuber 0.9.9. Most of these packages assist with data wrangling and visualization. Tuber is the library for scraping YouTube data. The austin package contains the Wordfish library.

[^4]: For introductory information about installing R packages, see [Datacamp's guide to R-packages](https://www.datacamp.com/community/tutorials/r-packages-guide). For this tutorial, we install all necessary packages upfront, but we call various libraries when they are first needed. 

```
install.packages(c("tm", "tidyverse", "austin", "tuber", "gtools", "lubridate", "purrr"))
library(tm); library(tidyverse); library(austin); library(tuber); library(gtools); library(lubridate); library(dplyr); library(ggplot2); library(purrr)
```

## Introducing the Wordfish Text Mining Algorithm

This tutorial will guide the user through creating a model of YouTube comment data using the Wordfish natural language processing algorithm. It will show you how to gather comment data from several YouTube videos, and use R to wrangle it into a format that will generate a meaningful Wordfish model.

A wide range of text mining algorithms are available for scholars in the digital humanities looking to create models of big data. Many of these algorithms have already been described with tutorials on the Programming Historian - see, for example, [word frequency analysis](https://programminghistorian.org/en/lessons/counting-frequencies) and [introduction to topic modeling](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet). The text mining algorithm we’ll be introducing today is called Wordfish. For information on the algorithm itself and to view its base code, see here: http://www.wordfish.org/software.html 
    
Developed by and for political scientists, Wordfish helps model textual data along a single-dimensional axis. Wordfish was created as a method for extracting the ideological leaning of documents expected to contain latent political motivation or ideology (***e.g.***, party manifestos or platforms, politician floor speeches) relative to a corpus of similar texts. For example, Wordfish can be a useful tool for identifying which member floor speeches were probably made by either Democrats or Republicans - and also roughly how extreme the partisan leaning of those members are.
    
After explaining how to wrangle YouTube Comment Data into the proper formats for Wordfish modeling, this tutorial discusses the Wordfish model in more detail in Part IV. As we explore visualizing this data, we explain how Wordfish differs from other forms of predictive text mining like topic modeling.

# Part II: Scraping the YouTube API


## The YouTube API

There are two ways to use coding to access YouTube data. You can use either 1) code that calls on YouTube’s API, or 2) code that ‘scrolls’ through the web page’s .html files and extracts structured data. In this tutorial, we focus on the API call method. To see what sort of data is available through YouTube’s API, view their [reference](https://developers.google.com/youtube/v3/docs) page. 

Note that the YouTube API has a quota that limits the number of queries you can perform each day. Once you pass that quota, all searches through the API (including keyword search, metadata query, and comment scraping) will generate a failed server request error in the R console (typically this error will include a number, frequently 401 or 403). Creating and switching between multiple sets of access credentials (discussed below) is one way to continue gathering data once your first account has reached its quota. Also be aware that the YouTube API sometimes collects only a portion of the comments available for each video; best practice is to cross-check the number listed on YouTube’s corresponding video page with the number scraped from the API.

This tutorial makes extensive use of Gaurav Sood’s [`tuber` package](https://cran.r-project.org/web/packages/tuber/index.html) to call YouTube’s API. The tuber package contains several [helpful functions](https://cran.r-project.org/web/packages/tuber/vignettes/tuber-ex.html) that you will rely upon, including `get_stats()` (to gather numerical and descriptive metadata about a video) and `yt_search()` (to search for videos matching keywords that you will choose). Because tuber can be used to access your personal YouTube video data through the API, as well as to obtain metadata on videos created by others, you must grant `tuber` permission through the YouTube OAuth credentials process. An OAuth credential is technologically different from an API key but, for YouTube API gleaning, serves the same purpose.[^6]

[^6]:Scraping the html is challenging, but can be done. You’ll need to navigate to a YouTube page and inspect the code. That process is beyond the scope of this post. Someone doing this sort of webscraping should consult the content platforms’s terms of service.

The YouTube credentials process first involves creating an OAUTH ID and SECRET. Never share your OAUTH ID or SECRET with others.  For setting up your credentials, the up-to-date instructions are on Google's [Developer's page](
https://developers.google.com/youtube/v3/getting-started). Google periodically updates the way it organizes its developer accounts, and also the exact way the YouTube API works.  The steps below were accurate as of July 20, 2020.  However, these exact steps might not work for you, if updates were made following the most recent updates to this tutorial.

1. Create a Google account. 
2. Once you are logged into your Google Account, you have to go to the Google Developers Console and choose Create Project and assign it a name.
3. Then choose Enable API and Services and select YouTube Data API v3. Choose Create Credentials. 
4. When asked, “Which API are you using?”, choose “YouTube Data API v3.” 
5. For “Where will you be calling the API from?”, choose “Other UI” because we are using R Studio Desktop.  
6. For “What data will you be accessing”, choose “Public Data”. 
7. Click “What credentials do I need?”. Copy and save your credentials for your OAUTH ID and SECRET. You should choose the option to “Restrict Key,” to reduce the ability of others to use your credentials. 
8. Go to OAuth Consent Screen on the left tab and choose Create credentials. 
9. To allow the R tuber package third-party access via your account to YouTube’s API, you need to create your credentials twice, both to allow tuber access, and to get the OAUTH ID and SECRET. 
10. Near the top of the screen, type in the Application Name: tuber. Click Save at the bottom of the screen.
11. Go back to Credentials - choose Create Credentials OAuth Client ID. Choose type: Desktop App. Name: tuber_R (or whatever you choose). Save the OAuth Client ID Credentials for later use. 

## Configuring Your Code

There are a couple of ways that you can incorporate your new OAUTH ID and SECRET into the code.[^7] The first way is to simply type in your credentials directly into your own version of this script. This is [the approach](https://cran.r-project.org/web/packages/tuber/readme/README.html) envisioned by the tuber package. Below is a (non-working) illustration of what the code would look like if you typed in your OAUTH ID and SECRET directly.

[^7]: For a more in depth explanation of how OAuth credentials are used within R packages, see the [CRAN guide](
https://cran.r-project.org/web/packages/googlesheets/vignettes/managing-auth-tokens.html).

```
library(tuber)
#source(Config.r)
APP_ID <- "INSERT YOUR API ID"
APP_SECRET <- "INSERT YOUR API SECRET"
app_id <- APP_ID
app_secret <- APP_SECRET

yt_oauth(app_id, app_secret)
```

We advise instead that you place your credentials in a separate configuration (“config”) file. Placing your credentials in this file allows you to keep your credentials from public view should you choose to share your code at a later date. If you choose to use the config approach, you’ll need to either create your own config file or use the Config.R script we’ve created and placed in the [Programming Historian for YouTube Wordfish Github repository](https://github.com/hawc2/Programming-Historian-Tutorial). Instructions for using the Config.R script can be found in the Github repository. 

Whether you type your credentials directly into the R code, or use the config file approach, you will need to authorize tuber to use your credentials. After you run the [yt_oauth](https://www.rdocumentation.org/packages/tuber/versions/0.9.8/topics/yt_oauth) function, you will receive a prompt in the console. Type “1” into the console following the prompt to give permission for authorization. You will then be prompted on a pop-up browser to permit the application to access your YouTube data. Now that you have access to the YouTube API, the rest of this tutorial will explore how to wrangle and analyze the comment data. 

In this code section, you can set variables that will determine how you will scrape video comment data in one of two ways. You can gather video comments using either Approach 1 (a pre-identified List of Videos) or Approach 2 (a Keyword Search). You can also set if you would like to narrow your search to a focused date range.  

For the purposes of this tutorial, defaults are pre-set for both the approach and date range. The default for this tutorial is Approach 1, a video list. The date range default will ensure the scraping and analyzing process produces reproducible  results for you. If you do not wish to scrape and model our sample dataset, you should replace these defaults with your own choices. Further information on adapting the code for original research is available in the Github repository. 

## Searching for Videos and Metadata

Curating a dataset of YouTube comments for Wordfish requires finding videos with a sufficient amount of data (enough comments, but also enough words per comment) to conduct predictive modeling. For this tutorial we will be wrangling to meet the specific needs of a Wordfish model. Wordfish modelling is typically performed on corpora of dozens or hundreds of documents, each usually containing hundreds or thousands of words. However, we have found that Wordfish can also produce insightful models using corpora of social media comments (here, from YouTube videos). These comments tend to be very short in length, but popular videos will often generate thousands of comment ‘documents’; enough to make up for their brevity - as long as the shortest comments are excluded prior to modeling. Because of other unique properties of comments (such as rare words, slang, other languages, or comments composed mostly of special characters or emojis) some additional wrangling is needed to ensure that each comment used contains enough data meaningful for Wordfish scaling. Additionally, the Wordfish algorithm is more likely to perform well if the videos (and by extension, the topics of the comment data) share a generally coherent subject matter. 

The most direct way to pick out videos is to visit the YouTube site, and capture a list of video IDs from each video’s html link. A video’s ID is the set of alphanumeric characters that appear in the html link immediately after “watch?v=” For example, in the illustration below, the video ID is 24xsqyMcpRg. Video IDs are constant and do not change over time.

![Screenshot of YouTube Video](images/PH_YouTube_Video_ID_screenshot.png)

Similarly, you could select a ‘channel’, which contains videos added by one content creator.  Our code does not currently give this option, but a video list of videos included in a channel could be gathered through [YouTube Data Tools](https://tools.digitalmethods.net/netvizz/youtube/).  

We give a second option, which is to search for relevant videos using one or more general [keywords](https://developers.google.com/youtube/v3/docs/search/list). YouTube makes available a wide range of metadata about each video, including the number of likes, title, description, tags, etc.[^8] The YouTube API allows you to search for keywords in the textual metadata (including video title, description, and tags). The [yt_search](https://www.rdocumentation.org/packages/tuber/versions/0.9.8/topics/yt_search) function in `tuber` accesses this feature in the API. This second option enables you to identify a list of videos likely to be relevant to your topic by searching for videos with metadata that includes your keyword(s) of interest. 

[^8]: For more on what you can do with YouTube metadata, see Lemire Garlic’s blog posts and her [Github page](https://github.com/nlgarlic/YouTube-Related-Video-Similarity). 

If you choose to search by keywords, keep in mind that the YouTube API search function uses ‘OR’ logic between your keywords. For example, searching for “defund” and “police” as two separate keywords will return results using either keyword, not a subset of videos that use both. Using too many keywords, or ones that are unfocused or unrelated, is likely to result in an overly broad corpus. This will negatively impact the coherence of your comment dataset and, by extension, the coherence of your text mining model results. Using a specific multi-word keyword, ***e.g.***, “defund the police” (as a single search term) is much more likely to return results relevant to a specific social issue.

Our code allows you to select either one of these options - either 1) a predetermined list of video IDs or 2) using keyword searches. Here, we refer to them as Approach 1 and Approach 2.


### Approach 1 (List of Videos)

To work from a list of video IDs, you’ll need to create a character vector in the R script containing each ID as a separate string.

```
IDsforSearch <- c("8t-hMoszGR4", "ymznwY2kbEU", "YV5srZTCX9k", "LNAvkbwzeTs")
```

Then use the following code to pull the video metadata. Using the [get_video_details()](https://www.rdocumentation.org/packages/tuber/versions/0.9.8/topics/get_video_details) function from tuber, the code pulls all of the metadata for your chosen videos from the API. We then limit the metadata to what we have found most useful: the video ID itself, and also the video publication date, video title, and channel title. 

One challenge with the YouTube API is that it does not always return data for every video searched, even if comment data for that video exists. By using the [possibly()](https://purrr.Tidyverse.org/reference/safely.html) function from the Tidyverse, we suppress error messages that would terminate our code if the API failed to return any results for one or a few of the identified videos. We explain our process for scraping comments from multiple videos in the Scraping YouTube Comments section, below.

```
library(purrr); library(gtools); library(dplyr)
############## PAY ATTENTION TO 'EVAL' value of THIS CHUNK ###############
get_avlbl_details <- possibly(get_video_details, otherwise = NULL)
AllDetails <- map(IDsforSearch, get_avlbl_details)
AllDetailsDF <- do.call(smartbind, lapply(AllDetails, data.frame))
AllDetailsDF[] <- lapply(AllDetailsDF, as.character)
#AllDetailsDF$publishedAt <- AllDetailsDF$publishedAt %>% as_datetime(tz = "UTC", format = NULL)
AllDetailsDF <- select(AllDetailsDF, video_id = items.id, publishedAt = items.snippet.publishedAt,
                       title = items.snippet.title, channelTitle = items.snippet.channelTitle) %>% arrange(desc(publishedAt))
video_list <-as.vector(AllDetailsDF$video_id)
```

### Approach 2 (Keyword Search)

If you are searching for videos with keywords, you’ll use this code instead. This code pulls a set of search terms and makes a dataframe of the metadata, filtered by date. To filter by date, you'll need to supply the beginning (AfterSearchDate) and ending dates (BeforeSearchDate) for your corpus in UTC format. We include sample dates in the code below.

These dates must be entered in UTC date-time format. We use the [lubridate](https://cran.r-project.org/web/packages/lubridate/lubridate.pdf) package's [as_datetime](https://rdrr.io/cran/lubridate/man/as_date.html) function to convert the date information retrieved from the YouTube API.

The following chunk of code will create create a matching Video List for your selected search terms. Note any time you want to view the value of a variable, you can write `View()`, in this case, writing `View(SearchResultsDF)`.
```
SearchResultsDF <- do.call(rbind, lapply(SearchResults, data.frame))
SearchResultsDF[] <- lapply(SearchResultsDF, as.character)

nrow(SearchResultsDF)

SearchResultsDF$publishedAt <- SearchResultsDF$publishedAt %>% as_datetime(tz = "UTC", format = NULL)
SearchResultsDF <- select(SearchResultsDF, video_id, publishedAt, title, channelTitle) %>% arrange(desc(publishedAt))
SearchResultsDF <- SearchResultsDF %>% filter(publishedAt > AfterSearchDate & publishedAt < BeforeSearchDate)
video_list <-as.vector(SearchResultsDF$video_id) #final list of video IDs
length(video_list)
(video_list)
```

Now that you have scraped the metadata for your videos, you can move on to gathering the comments.


## Scraping YouTube Comments

YouTube videos are often accompanied by user comments. These comments can run the gamut in content and purpose. While they usually contain short responses to video content, they also showcase broader ideological reflections, and comments can be repurposed for other purposes, such as sharing web links. That said, the discussion board framework doesn’t allow for ongoing dialogues - all responses to a comment can only reply to the original comment. And commenters represent only a small proportion of viewers. 

Here is a screenshot of what it looks like for users on a computer browser:

![Screenshot of YouTube Comments](images/PH_YouTube_Comments.png)

This next code block gets comments from the API and converts the data from its original form into a dataframe. Note that this code uses the `possibly()` wrapper to avoid the error messages that `tuber`’s function `get_all_comments()` will produce when comments are either not currently available for a video, or when a video does not allow (and therefore does not have) any comments. Unfortunately, the YouTube API is not a perfectly reliable source of data. Sometimes comments can be successfully scraped for one video, but will be unavailable a few hours later. For this reason, it is important to account for the likelihood of tuber encountering unanticipated errors as it works with the YouTube API. In this case, if `possibly()` or another error-detecting wrapper is not used, the errors sometimes produced by tuber will terminate execution of the entire script, and comments from videos subsequent to the error will not be scraped. 

```
get_avlbl_details <- possibly(get_video_details, otherwise = NA)

AllDetails <- map(IDsforSearch, get_avlbl_details)
AllDetailsDF <- do.call(smartbind, lapply(AllDetails, data.frame))
AllDetailsDF[] <- lapply(AllDetailsDF, as.character)

AllDetailsDF <- select(AllDetailsDF, video_id = items.id, publishedAt = items.snippet.publishedAt, 
                       title = items.snippet.title, channelTitle = items.snippet.channelTitle) %>% arrange(desc(publishedAt))
SearchResultsDF <- AllDetailsDF
video_list <- IDsforSearch
```


### Scrape available comments on each of those videos


This chunk gets all available video comments from API, and converts to a dataframe. As discussed above, it uses `possibly()` to avoid error messages for unavailable videos comments.

```
video_list 
get_avlbl_comments <- possibly(get_all_comments, otherwise = NULL)
AllComments <- map(video_list, get_avlbl_comments) 
AllCommentsDF <- do.call(smartbind, lapply(AllComments, data.frame))
nrow(AllCommentsDF)
AllCommentsVideos <- unique(AllCommentsDF$videoId)
```

Sometimes the YouTube API will not return results for all videos.  If you do not receive results for all four videos, or if they scrape a number of comments that diverges notably from the ~31,000 we scraped for this corpus, you may need to retry the scrape after your API quota refreshes the next day.

This chunk of code will confirm which comments were scraped.

```
subject_s <- "Race_and_Police"; SearchTerms <-c("x_Race and Police", "x_Defund the Police")
print(paste("You have identified", nrow(AllCommentsDF), "comments from", length(AllCommentsVideos), "unique videos identified using the", length(SearchTerms) ,"tags: ", paste(SearchTerms, collapse=", "),"."))
```

This code chunk combines video metadata with the comment text and comment metadata, renaming some columns for clarity:

```
AllCommentsMetadata <- inner_join(AllCommentsDF, SearchResultsDF, by = c("videoId" = "video_id"))
AllCommentsMetadata <- rename(AllCommentsMetadata, c(commentPublishedAt = publishedAt.x,
                                                     commentUpdatedAt = updatedAt,
                                                     commentLikeCount = likeCount,
                                                     commentId = id,
                                                     videoPublishedAt= publishedAt.y,
                                                     videoTitle = title,
                                                     videoChannelTitle = channelTitle))
```

At this point, you can back up your video metadata and comments by creating a Data folder and exporting your data into a .csv file using the following lines code:

```
dir.create("Data") 
write.csv(AllCommentsMetadata, paste("Data/AllComments__", SearchTerms, Sys.Date(),".csv", sep=""))
```

After backing up your data, you can skip to the next section if you are ready to wrangle that data.

But if you would like to read in a .csv of already scraped comments and metadata (for example, the sample data we’ve created), use this code first. You don't need to run these lines of code if you are using the data we just scraped. Note that if you have a comment dataset was not scraped using this tool, you may be able to use it, but be mindful that you may also need to reformat it in order to use the rest of this script.

```
# yourdata <- read.csv(paste("Data/AllComments_", subject_s, "_", today("EST"), ".csv", sep="")) 
# yourdata <- read.csv("Data/AllComments__DefundThePolice2020-07-16.csv")
#AllCommentsMetadata <- yourdata
```

# Part III: Optimizing YouTube Comment Data For Wordfish


## An Introduction to Wordfish

Now that the comments are scraped, and your data are saved, there is some optimization that needs to be done to ensure that a usable Wordfish model is produced.  This optimization is broadly referred to as ‘data cleaning’, or specifically in the context of working with text data, ‘preprocessing’.  To see why this is important, it’s necessary to understand on a basic level how Wordfish models work.

Wordfish is an unsupervised, scaling method that gives two kinds of information. First, it gives information about how documents (in this case, individual comments) are best discriminated from each other by scaling them along a single dimension. In essence, the model collects comments that are ‘similar to’ each other on each end of the dimension, based on the kinds of words used in those comments. Comments on far opposite ends of this scale will generally be characterized by the inclusion of different sets of unique words, indicating focus on different kinds of concepts. Second, Wordfish identifies which specific, unique kinds of words the model used in order to perform this scaling, and arrays them along a similar dimension.

The placement of words along this scale is inherently informative - we can directly understand the meanings of words just by inspecting their placement on the appropriate visualization. The same is not inherently true of documents, without collecting or including some additional information (‘metadata’). When the documents being scaled have meaningful titles or categories, this title or category metadata can be very useful. In this case, we will use the titles of the videos which generated each subset of comments metadata that can be helpful in understanding the substantive meaning of document (comment) placement. Similarly, you can read the text of several documents located on either end of the dimension, in order to get a general idea of what kinds of comments are being grouped together and what makes them different. Layering video title metadata onto our analysis lets us see if comments on these videos are systematically different from comments on those other videos.

Examples of Wordfish visualizations will be given later in this tutorial, along with a short discussion of how to interpret them. Now that you’ve finalized your list of videos, gathered the metadata and comments for each video, and optimized your data for Wordfish through filtering, you are ready to clean and wrangle the data!

## Data Cleaning and Wrangling in R

Tuber collects comment data in `lists` form from the YouTube API.  In some of the above steps, we converted this data into a single large dataframe which contains all comments collected, from all of the different videos scraped, along with a number of additional pieces of metadata.  However, the comment text data still needs to be cleaned and preprocessed to make it usable for text data mining. 

### Preprocessing

One way to think of preprocessing is to break it into three iterative processes: [tokenizing](https://en.wikipedia.org/wiki/Lexical_analysis#Tokenization) the text (breaking it down into unique word or word-like units), normalizing (***e.g.***, making the text similar by converting everything to lowercase), and removing noise (***e.g.***, deleting html headers). For more detail on this iterative process, see this data science [blog post](https://www.kdnuggets.com/2017/12/general-approach-preprocessing-text-data.html).  

The following code tokenizes the text of each comment (each row in the AllCommentsMetadata data frame) and places it into a list of tokenized comment vectors. The words in your comment corpus have been normalized by converting to lower case, and in the same step you removed all non-text symbols (including most grammatical symbols and all emojis).  Finally, the tokenized character vectors are joined in the list comment_tokens_l.

```
comment_tokens_l <- list()

for (com in 1:nrow(AllCommentsMetadata)) {
  sto <- AllCommentsMetadata$textOriginal[com]
  stolist <- list()
  sto <- tolower(sto)
  sto_list <- strsplit(sto, "\\W")
  sto_text <- unlist(sto_list)
  sto_rm <- sto_text[-which(sto_text == "")]; sto_text <- sto_rm
  if(length (sto_text) >= 5 & length(unique(sto_text)) >=5) {
    list.head <- paste(AllCommentsMetadata$videoTitle[com], "%_%", com,"%_%", AllCommentsMetadata$commentId[com], "%_%", AllCommentsMetadata$videoChannelTitle[com], sep="")
    comment_tokens_l[[list.head]] <- sto_text
  }}

comment_ids <- names(comment_tokens_l)
length(comment_tokens_l)
View(AllCommentsMetadata)
```

Presets for this code filter out comments with less than 5 unique words and 8 total words.  We can remove these comments at this stage because they definitively have too little textual data for meaningful analysis, so there is no need to spend further computing power on them. A more stringent filter will be applied later.

To see the result of this cleaning process, including how many comments were maintained following this ‘first cut’, use this code.

```
print(paste("keeping",length(comment_tokens_l), "out of", nrow(AllCommentsMetadata),"comments ;",round((length(comment_tokens_l)/nrow(AllCommentsMetadata))*100, 2), "% of total comments kept" ))
```

### Generating the Corpus

Now that the text has been preliminarily cleaned, the next step is to generate a corpus object. The corpus object is a unique data structure used to create the [term document matrix](https://bookdown.org/Maxine/tidy-text-mining/tidying-a-document-term-matrix.html) (TDM) below.

This code chunk uses the `Corpus()` command from the `tm` package.  This converts your vectorized list of comments into a corpus object.  The next few commands, also from the `tm` package, can only be conducted on this kind of object.

```
library(tm)
comment_corpus <- Corpus(VectorSource(comment_tokens_l))
comment_corpus <- tm_map(comment_corpus, removeNumbers)
comment_corpus <- tm_map(comment_corpus, removePunctuation)
```

Sometimes leading ‘c’ characters are introduced to the corpus object when drawing on lists of vectorized tokens. This code removes those problematic leading ‘c’s by using a loop.

```
for(com in 1:length(comment_corpus)){  # remove the leading "c"s added when the corpus command concatonates tokens 
  if(substr(comment_corpus[[com]]$content,1,1)=="c"){
    comment_corpus[[com]]$content<- substr(comment_corpus[[com]]$content, 2, nchar(comment_corpus[[com]]$content))}}
```

This next code chunk removes common English [stopwords](https://nlp.stanford.edu/IR-book/html/htmledition/dropping-common-terms-stop-words-1.html), as well as some non-words common to YouTube comments which are included due to the frequency of URLs (***e.g.***, “www”).  A high concentration of stopwords in documents can adversely impact text data mining models, so you are usually better off removing them prior to modeling. 

```
my_stop <- c(stopwords("english"),
             "c","x", "s", "t", "m", "amp", "youtube", "www", "com", "quot", "br", "http", "https", "")
```

### Converting the Corpus to a Document Term Matrix (DTM)

The `corpus` object is converted to a [`document term matrix`](https://bookdown.org/Maxine/tidy-text-mining/tidying-a-document-term-matrix.html) (DTM) object in the following.  This is the data structure Wordfish accepts for modeling.
```
comment_corpus <- tm_map(comment_corpus, removeWords, my_stop)
dtm = DocumentTermMatrix(comment_corpus)
dtm
```


### Removing Sparse Terms from the DTM

Now that the DTM is created, the next step is to remove sparse terms. Sparse terms are those vocabulary words that do not appear frequently in the corpus.

The ‘vocabulary’ of a corpus of documents refers to a list of all of the different types of words that are used anywhere, in any document - even one single time in one document.  Corpora of YouTube comments tend to have a particularly broad, diverse ‘vocabulary’, for a number of somewhat idiosyncratic reasons.  To give a few examples: compared to more formal writing with a rigorously maintained style guide, they are more likely to contain internet slang, hashtags ( multi-word phrases written without intervening spaces), misspelled words, or comments written in languages other than the main language you may wish to study.  They are also likely to contain URLs / links, or the profile names of other YouTube account users. Common internet slang or hashtags may contain interesting meaning, but it is likely many of these other vocabulary elements will be rare and will convey little if any substantive meaning. 

The presence of many rare terms that do not convey meaning would negatively impact model results. Therefore, we use the `RemoveSparseTerms()` function from the `tm` package to exclude from our modeling word tokens that appear less than a few times.

```
library(tm)
sparsity <- .9985
dtma = removeSparseTerms(dtm, sparse = sparsity)
dtma
```

### Problematic Comments in the Corpus

Occasionally, the prior two steps (removing stopwords and removing sparse terms) will remove all of the words in one or more comments.  Wordfish is unable to assign initial parameters to a document with zero words, and therefore when Wordfish tries to model a corpus where one or more comments have zero words, this will cause the function to crash.

The next extended loop both remedies this problem, and also enables us to focus our analysis specifically on comments with a useful amount of textual data. The code identifies these problem comments (comments with no or few remaining word tokens), removes them, and then creates a new (revised) DTM and clears out remaining sparse terms. To accomplish all this, the following code chunk uses a lengthy loop. To see what is happening step-by-step, we’ve added comments in the code to clarify the purpose of each stage of the loop. Before showing you the code, however, we explain how each section works. 

#### Identify Problematic Comments

The line of code if(sum(dtma_matrix[com,]) < 11 )  simultaneously identifies both kinds of ‘problematic comments’ - those which are too short to be meaningfully modeled, and also comments which no longer have any textual content at all. It does this by looking to see if the integer value in this line of code is greater than the minimum word threshold, here set to a default of 11. Running this code will remove all comments with 10 or less remaining word token(s) following the initial removal of sparse terms. As noted above, it is strictly necessary to remove comments with 0 remaining word tokens. It is not strictly necessary, but is generally quite beneficial, to remove those with only a few remaining word tokens.

This chunk has three steps, which iterate while the number of problem_comments identified is greater than zero. The initial assignment of NA to the problem_comments object allows you to enter the `while{}` loop.  Then, the `for{}` and `if {}` loop records which comments have fewer total words remaining than the threshold (set below at 11 words minimum).  

#### Remove Problematic Comments

Wordfish model results are often skewed or overfit when even a few comments with few (less than ~10) - following the previous steps - are included.  Removing these comments is a very effective way to prevent much of this problematic overfitting.  Setting this floor to minimal comment length does not guarantee an ideal Wordfish model, but it does help make the likelihood of success higher. To do this, the code first identifies those comments with 10 words or less.

If no ‘too short’ problem comments were identified in this loop, the problem_comments object will still just have one entry, NA.  This initial NA entry is removed in the next step, giving problem_comments length 0.  In that case, once this chunk has run and returns to the top of the `while{}` loop, you will exit the loop.  

Otherwise, if one or more ‘too short’ comments are identified, the chunk will report how many comments are being removed, remove them from the initial Document Term Matrix, and then `RemoveSparseTerms()` again from this new matrix.  

### Make a New DTM and Remove Sparse Terms

Finally, the code creates a final DTM and removes sparse comments once more. Removing sparse terms must be re-done each time because which terms are sparse is relativistic.  As some initial extremely ‘weird’ comments are removed, their rare terms will often be removed from the corpus vocabulary, making other slightly more common terms the new ‘rare’ ones which will be removed by the `RemoveSparseTerms()` function.  The `while()` loop that encapsulates this section causes the `problem_comments` removal to continue until there are no more problem comments.  Eventually (usually after 2-4 automated iterations) all ‘problem comments’ will have been eliminated, and the corpus will be ready for Wordfish modeling.

```
library(tm); problem_comments <- NA
while(length(problem_comments) > 0 ) { 

dtma_matrix <- as.matrix(dtma)

problem_comments <- NA
for(com in 1:nrow(dtma_matrix) ){                
  if(sum(dtma_matrix[com,]) < 15 ){
    problem_comments <- c(problem_comments, com)
  }}
problem_comments <- problem_comments[(-1)]; 
if(length(problem_comments) > 0 ){  
  print(paste("removing", length(problem_comments), "problem comments"))
  comment_corpus <- comment_corpus[(-problem_comments)]  
  comment_ids <- comment_ids[(-problem_comments)]
} else {
    print("There don't appear to be any [more] comments with too few words")
  }
dtm1 <-DocumentTermMatrix(comment_corpus)  
dtma <- removeSparseTerms(dtm1, sparse=sparsity)
rm(dtma_matrix)  
}
length(comment_ids)
```

To see how your data now looks, run the following lines of code:
```
print(paste("Modeling",length(dtma$dimnames$Terms),"words from", length(dtma$dimnames$Docs), "comments with a usable number of tokens, of the original", nrow(AllCommentsMetadata), "comments.",round((length(dtma$dimnames$Docs))/nrow(AllCommentsMetadata)*100, 2) , "% of total comments kept from initial scrape... now trying to WF!"))
```

# Part IV: Modeling YouTube Comments in R with WordFish


## Understanding a Wordfish Model

Although Wordfish was initially developed by political scientists for researching political ideology, there is nothing ‘inherently’ political about the dimension revealed by Wordfish. Wordfish can be used to extract inherent ‘latent’ dimensionality (based on broad differences in words used) existing within any corpus. The substantive interpretation of this latent dimension depends entirely on broad trends in the typical contents of the documents comprising your research corpus. 

For example: in a corpus where you already know that your documents are about cats and/or dogs (but not specifically which documents are about which animal), a Wordfish would describe which documents are likely about cats, which are likely about dogs, and how ‘cat-typical’ or ‘dog-typical’ each document is. Very ‘catty’ or ‘doggy’ documents would be placed at the far ends of this predicted dimension. Documents that are intermediate (because they are partially about cats and partially about dogs, or because they are not about either cats or dogs) would appear towards the center of the predicted dimension.

These lines of code run the Wordfish algorithm and generate model. Note that this script will *crash* at this stage if a Wordfish model cannot be initialized, terminating execution or knitting of the final R Markdown file.  The loop above, which removes ‘problem comments’, prevents the most common reason a Wordfish model might not be able to be initialized.

```
library(austin)
wfa1 <- wordfish(as.wfm(dtma), dir=c(1, 2), control = list(tol = 3.0e-5), verbose = T)
wfa1$docs <- comment_ids
```

To store data from WF model as independant objects, which can be helpful for later manipulation, run the following lines of code:
```
wfdocs_v <- wfa1$docs
theta <- wfa1$theta
alpha <- wfa1$alpha

wfwords_v <- wfa1$words
beta <- wfa1$beta
psi <- wfa1$psi
```

Wordfish operates by making predictions about the placements of documents along this scale based on a Document Term Matrix (DTM).  Document term matrices are a tidy, structured format for storing data about the frequency of the word types used in each of a corpus of documents by using the ['bag of words'](https://en.wikipedia.org/wiki/Bag-of-words_model) approach.  

The Wordfish algorithm can be clarified by comparison to [topic modeling](http://www.cs.columbia.edu/~blei/papers/Blei2012.pdf), a tried and true method for text mining. Similar to topic modeling, wordfish uses this document term matrix to make predictions about documents based on the different kinds and frequencies of words (tokens) used in each. They are both modeling approaches to mining text data / processing natural language that rely on machine learning algorithms.  Further, both are ‘unsupervised’ - they do not rely on extrapolating information about the dataset provided based on the way the user pre-codes a subset of that data.  Instead, they both look at differences between documents, in terms of the types and frequencies of words used, and identify ‘natural’ groupings or scaling.

Another important similarity between Wordfish and topic modeling is that both treat documents as “bags of words”.  This means that the models only look at word frequency between documents.  These models do not take into account any information about word order. That means that it doesn’t matter ***where*** words occur in a document, just ***which*** words occur, and how many times each of those occurs.  Since social media comments tend to be very short, treating comments as bags of words is actually less of a potentially problematic assumption than it might be for longer documents, where different sections of content (paragraphs, pages, chapters, etc) might convey different types of meaning, and by consequence contain very different types of words.

One of the biggest strengths of both of these kinds of models is their ability to refine their results by passing over the data multiple times. For example, when a Wordfish model is initialized, all of the parameters a wordfish model measures are set as a ‘first best guess’ at the latent scaling of documents and words.  This ‘first best guess’ gives a helpful level of general insight. Depending on the quality of the text data, sometimes these models will be able to refine these initial predictions, gradually closing in on even more statistically robust and insightful models.

## Visualizing WordFish

### Post-Model Processing

Before visualizing a Wordfish model, a small amount of post-model processing is helpful.  The following code chunks do this processing, including creating ‘short titles’ for the videos that are more usable in subsequent visualizations which include this metadata.

WF model results are returned as a list of vectors.  Some vectors in this list correspond to document-level (comment-level) data, while others correspond to word-level data.  Saving these independently allows for them to be reconfigured into more intuitively understandable document- and word-level data frames in subsequent steps.

### Assemble Composite Wordfish Datamodel Objects

The following chunk ‘disassembles’ metadata which was grouped in an earlier step, processes it, and creates document- and word-level data frames.  

```
comment_identifiers<-data.frame(NA, NA, NA, NA, NA, NA)
colnames(comment_identifiers) <- c("short_title","short_channel","video_title", "comment_number", "comment_id", "video_channel")

for (com in 1:length(wfdocs_v)){
split <- unlist(strsplit(wfdocs_v[com], "%_%"))
comment_identifiers[com,3:6] <- split
title <- unlist(strsplit(comment_identifiers$video_title[com], " "))
channel <- unlist(strsplit(comment_identifiers$video_channel[com], " "))
#                      s_title <- paste(title[1:4], collapse=" ")
s_title <- title[1]               # make the 'short title' - first 5 words with 3+ chars
for(t_word in 2:length(title)){
  if(nchar(title[t_word]) > 2) {
    s_title <- c(s_title, title[t_word])
  }}
  if(length(s_title > 4)) {
  s_title <- s_title[1:4]}
s_title <- paste(s_title, collapse=" ")
comment_identifiers$short_title[com] <- s_title  
}

```

First, it separates comment IDs (numeric values starting at 1 and running to the total number of comments collected), the titles of the videos scraped, and the channel corresponding to each video.  

Then, this chunk creates a ‘short title’ for each video, consisting of the first four words in each title that are three or more letters long.  These short titles help distinguish between videos in visualizations, while avoiding too much space being taken up by a large legend containing multiple long video titles.  

Finally, the following chunk assembles document- and word-level model output and metadata into two convenient dataframes, which facilitates easy visualization in the last few steps.

```
wf_docdata.df <- data.frame(theta, alpha, comment_identifiers, wfdocs_v)
wf_worddata.df <- data.frame(wfwords_v, beta, psi)
```

### Creating and Interpreting Visualizations

Wordfish models scale both the documents in a corpus and also the words in the vocabulary of that corpus along horizontal and vertical axes identifying polarity of perspective.  This lends itself to two distinct kinds of visualizations of Wordfish model results: a ‘document-level’ visualization and a ‘word level’ visualization.  Below, you will find code chunks for creating each of these kinds of visualizations, followed by short explanations of how you can interpret those visualizations.

### Document-Level Visualizations

The first, and often most important, visualization a Wordfish model can produce is one that distributes the latent component of largest difference along the vertical axis.  A code chunk which produces this visualization is presented below, followed by the output.

First we create a directory for our visualizations and call our necessary libraries.

```
dir.create("Visualizations"); library(ggplot2); library(lubridate)
```

Then we use `ggplot` to visualize the comments.
```
basic_T_A_plot <- ggplot(data = wf_docdata.df,
                                   mapping = aes(x =theta, y = alpha, label = comment_number))+
  geom_text(size = .8) +
  labs(x = "Comment polarity: an optimized value (theta)", y = "Comment length: a fixed effect (alpha)") +
  guides(size = "none", color = guide_legend("")) + theme(legend.position="bottom") +
  theme(legend.text = element_text(size=4)) +
  labs(title = paste("Polarity of ", subject_s, "comments on YouTube"),
                      subtitle= paste("identified using preset video list"))
basic_T_A_plot

ggsave(paste("Visualizations/",subject_s, "__basic_T_A_plot_", today("EST"),".pdf",sep=""), device="pdf")
```

In this visualization the vertical dimension represents the scaling of documents (individual YouTube comments).  The horizontal dimension represents the length of each comment, with longer comments appearing towards the top of the figure, and shorter ones appearing towards the bottom.  

Each plotting point (the comment ID numbers appearing in the middle of the field) represents the placement of an individual comment.  Comments are displayed by their unique comment identification number; these numbers are generated by sequential assignment.  Because some comments are excluded from the dataset during preprocessing, the IDs shown on this plot are not sequential.  

At this stage, you will be able to see that some comments appear on the left of the field, some on the right of the field, and others toward the middle.  However, without more information, we aren’t able to test hypotheses about what latent aspect of these comments is driving their polarity. The next two visualizations will help you narrow in on answering this question.

### Document Level Visualization with Video Title Metadata

There are many underlying factors that can drive the latent scaling dimension a Wordfish model identifies. If content is strongly motivated by the author’s political ideology, this dimension can separate writing from authors on opposing sides of a political issue.  This dimension almost always describes broad differences in content, based on the kinds of words used. 

Since YouTube comments are short, you may find some specific examples helpful.  When analyzing comments from a single video, you will often find that this dimension separates comments about the aesthetics of the video from those discussing its topical focus. 

```
library(ggplot2); library(lubridate)

short_title_T_A_plot <- ggplot(data = wf_docdata.df,
                                   mapping = aes(x =theta, y = alpha, label = comment_number, color=short_title))+ geom_text(size = .8) +
  labs(x = "Comment polarity: an optimized value (theta)", y = "Comment length: a fixed effect (alpha)") +
  guides(size = "none", color = guide_legend("")) + theme(legend.position="bottom") +
  theme(legend.text = element_text(size=7)) +
  scale_colour_manual(values = c("navyblue", "red4", "red1", "slateblue4")) +
  labs(title = paste("Polarity of ", subject_s, "comments on YouTube, colorized by Video"),
                      subtitle= paste("identified using preset video list"))
short_title_T_A_plot

ggsave(paste("Visualizations/",subject_s, "__shorttitle_T_A_plot_", today("EST"),".pdf",sep=""), device="pdf")
```

You will notice in the above visualization that there is a clear horizontal separation between comments. Most of the comments are located in the middle of the horizontal dimension, with a few outliers at each end. 

There are many ways to interpret the substantive meaning of this scaling.  Below we offer two ways to interpret the results.

The first interpretive method involves using comment metadata to check for trends in comment scaling. By color-coding comments according to metadata like video title, we can see if comments with shared metadata are concentrated together or dispersed evenly.

The second interpretive method involves inspecting word-level WF output, to see what kinds of words characterize the left- and right- portions of the scale, and qualitatively identify broad commonalities between words at each end of the scale. 

Note that the document-level and word-level scales are the same; comments at the left end of the scale are characterized by more frequent occurrence of words at the left end of the scale and infrequent occurrence of words at the right end of the scale.  

## First Method of Interpreting WF Comment Scaling - Color by Video Title

If your Wordfish model contains comment data from two ideos, an initial research question is frequently: ‘does video A generate different kinds of comments than video B’?  The next visualization helps us answer that question, by color coding the plotting symbols from the above visualization based on the specific video that the comment was posted for.  This lets us see if, for example, the videos modeled yield very different kinds of comments, or if they generate a similar distribution of comments across a shared scaling space.  

Your corpus is composed of four videos, all with a shared topic of police violence against black and brown people, and conversations about if redirecting police funding (‘defunding the police’) could lead to less police violence and better outcomes - especially for racial minorities.  Two of these videos were gathered from more politically liberal YouTube channels; the other two from more politically conservative YouTube channels.  

Comments from the more politically liberal channels are colored in two visually distinguishable shades of blue, while comments from the more conservative channels are colored in two shades of red.  If the blue comments are relatively clustered together, and are clustered away from the red comments, this provides evidence supporting the theory that the common topics of conversation in liberal and conservative YouTube video comment threads differ.  If the red and blue comments are mixed together homogeneously on both ends of the scale, instead you can infer that similar topics are probably being discussed in the comment threads of all four videos (though maybe in slightly different ways).

As you can see, there is not a strong visual separation between the red and blue coded comments.  The red comments are even dispersed across the triangular plotting area.  The blue dots are also spread relatively evenly, although they may be slightly more concentrated on the right side of the plotting space.  

You can infer from this visualization that similar topics are probably being discussed in the comment threads of the four videos you captured.  The next question is: *what are those topics*?

## Second Method of Interpreting - Word-Level Visualizations

The second type of visualization a Wordfish model output directly lends itself to is based on the scaling of the words comprising the corpus vocabulary remaining after sparse terms are removed from the DTM.  These words (each word itself comprises its plotting point), just like the documents in the above visualization, are scaled along an almost identical vertical dimension.  

Words appearing on the left of this plotting space are common among documents on the left of the plotting space, and rare among documents on the right (and vice versa).  The vertical dimension here is similar to the document level visualization as well; it reflects the overall frequency of the word.  So, common words (unlikely to help much in differentiating left from right) appear near the top of the plotting space, and very rare words appear near the bottom.  The general triangular shape of this visualization is largely driven by the functional form of this model, although a deeper description of these aspects is beyond the scope of this tutorial. 

```
library(ggplot2); library(lubridate)
word_P_B_plot <- ggplot(data = wf_worddata.df, mapping = aes(x = beta, y = psi, label = wfwords_v)) +
  geom_text(data=subset(wf_worddata.df, psi>-8), size = 0.755) +
  labs(x = "Word polarity: an optimized value (beta)", y = "Word frequency: a fixed effect (psi)") +
  #guides(size = "none", color = guide_legend("")) +
  labs(title = paste("Polarity of typical words used in", subject_s, "YouTube comments"),
                   subtitle= paste("identified using preset video list"))
word_P_B_plot

ggsave(paste("Visualizations/", subject_s, "__Word_P_B_plot_", today("EST"), ".pdf",sep=""), device="pdf")
```

You can see from this visualization that words like “defunded”, “lives” next to “matter”, “apples” (possibly referring to “a few bad”), “training”/“untrained”,  and “enforcing” characterize the left side of the plotting space.  This broadly suggests that the **left** side of the plotting space identifies comments which discuss broad causal and logistical questions about which lives matter, whether or not police violence problems are due to systemic racism or to ‘a few bad apples’, and if problems with police violence could be solved with better training / equipment or if those problems would be better solved by redirecting funding or defunding police entirely.

On the other hand, words like “president”, “party”, “political”, “bill”, “propaganda”, “dnc” and “rnc”, characterize the **center-right** side of the scale.  These words all strongly indicate a discussion of the political / partisan nature of discussions around police violence.  Words like “slave”, “christian”, “religious”, “breonna” near “taylor”, “eric” near “garner”, michael [brown], and “genocide” on the **far-right** suggest that a particularly polarized sub-category of these political comments focuses on the pressing reality of actual high profile police killings.

Words like “police”, “fund”, “defund”, “officers”, “trump”, and “biden” characterize the center-top of the plotting space.  Words located in the **center-top** of the plotting space are relatively common among all comments.  Seeing these words toward the center-top is unsurprising, given the general topic of these videos - political questions around police, police violence, and funding / defunding the police.

# Conclusions

By this point of the tutorial, you have downloaded a large corpus of YouTube video comments, processed them, analyzed them using the Wordfish model of text scaling, and produced several insightful visualizations.

Based on the three visualizations you produced, you can tell that a broadly similar set of topics is discussed on liberal-leaning and conservative-leaning video comment threads on four YouTube videos focused on police brutality and questions about police funding.  Finally, you saw that Wordfish did identify a broad distinction in these comments.  It identified that some comments focus on the causes and possible solutions to police brutality (on the left side of the scale), while other comments focus on the partisan politics of this issue, including a discussion of the legacy of slavery and the reality of specific high-profile police killings.

These visualizations, and more granular analyses of the Wordfish model, will enable complex interpretations of textual meaning. That Wordfish can be useful for understanding the strange type of discourse that appears in YouTube comments is a fascinating revelation of its own. 
