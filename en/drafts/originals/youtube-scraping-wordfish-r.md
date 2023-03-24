---
title: "Text Mining YouTube Comment Data with Wordfish in R"
collection: lessons
layout: lesson
slug: youtube-scraping-Wordfish-r
date: 3-22-2023
authors:
- Alex Wermer-Colan
- Nicole Lemire-Garlic
- Jeff Antsen
reviewers:
- Janna Joceli Omena
editors:
- Nabeel Siddiqui
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/374
topics: [r]
difficulty: 3
activity: analyzing
abstract: In this lesson, you will learn how to query the YouTube API to download metadata and comments from videos and video channels. This lesson also explores how to conduct text mining on these comments and discourse analysis using the Wordfish natural language processing algorithm.
---

{% include toc.html %}

YouTube is the most popular web-based video sharing and viewing platform in the world, with billions of users viewing and uploading videos each month. This lesson overviews how to gather and wrangle YouTube video comment data by accessing YouTube's application programming interface (API) with the R programming language and the `tuber` package. This lesson will then demonstrate one method for analyzing politically charged YouTube video comment data with `quanteda`'s implementation of Wordfish, an unsupervised one-dimensional text scaling algorithm.

# Part I: Introduction
As the world’s most utilized platform for video sharing, YouTube houses a wealth of culturally-relevant data that researchers and academics have begun to explore. While the platform is best known for its entertainment and “how to” content, it also features discussions on politically salient topics. 

YouTube videos are often accompanied by extensive user comments and discussions that can run the gamut in content and purpose. While they usually contain short responses to video content, they also showcase broader ideological reflections. 

YouTube's comment section only includes limited discussion board functionalities, not allowing for multi-threaded dialogues - all responses to a comment can only reply to the original comment. But this source of discourse nonetheless represents conversations by members of the public about political content in reaction to popular news broadcasts and related videos.

## YouTube and Political Discourse
While YouTube is associated with entertainment, it is often the place where significant debates, explicit and implicit, play out for wide-ranging demographics across the political spectrum. The political influence of YouTube is most evident in its structure as a video-viewing platform with comments visible below videos, in a similar juxtaposition to Twitch, the streaming platform associated with video-game broadcasts. 

When users visit YouTube on a computer browser, they are greeted by a now familiar interface:

{% include figure.html filename="PH_YouTube_Comments.png" caption="WRITE IMAGE CAPTION HERE" %}

The current scholarship on YouTube's political dimensions has often explored the complicated problem of causation between viewing and changing perspectives, including qualitative sociological studies of YouTube users who have been radicalized through use of the platform. YouTube video comments represent a unique corpus of reception discourse, where videos, including their titles, related metadata, and the video content itself, incite a reaction in viewers, where discussions and replies play out often for tens of thousands of comments. These comments serve a framing purpose for the lurking viewer, who often encounters a video in tandem with replies.  

{% include figure.html filename="PH_YouTube_defund_screenshot.png" caption="Screenshot of YouTube video about debates over defunding the police in the United States" %}

## Lesson Overview
This lesson explains how to use the R programming language for retrieving and analyzing these YouTube comments and related video metadata. Through this lesson, you will learn how to authenticate your access and query Google's YouTube API, as well as how to process and clean video metadata, and analyze the videos' comment threads for latent meaning and ideological bent. Textual data collected through this method can be further analyzed manually or computationally beyond the scope of this lesson.

As an example of how YouTube comment data can be computationally analyzed, we focus on a text mining algorithm employed by political scientists - Wordfish. Wordfish is used to study the political dimensions of texts. It is a statistical model that calculates word frequencies and "position" scores associated with those words to determine where each document fits on an ideological scale. Researchers use Wordfish to identify political actors' latent positions from texts that they produce, such as political speeches. 

Results of Wordfish studies have been interpreted as reflecting the Right-Left scale of political ideology or different attitudes towards public policies.[^2]

[^2]: It is not possible to fully cover the benefits and limitations of Wordfish in this tutorial; see Nanni, et al. (2019) and this blog post by Jeff Antsen for more detail.

In this lesson, you will use Wordfish to explore the text of YouTube comments submitted by viewers of Black Lives Matter videos posted by right- and left-leaning news sources.

This lesson will guide you through three key steps for 1) data collection, 2) wrangling, and  3) analysis. 

Firstly, the preparatory steps for gathering data will include considering ethical issues related to downloading and analyzing YouTube data, as well as the basics of installing R and RStudio, and obtaining YouTube API authorization credentials. 

Secondly, this lesson will illustrate how to use Gaurav Sood’s R [`tuber` package](https://cran.r-project.org/web/packages/tuber/index.html) to query YouTube’s API, wrangling video comments into a data frame that can be exported as a .csv file for further manual or computational analysis with and beyond R. 

Thirdly, this lesson will introduce how to pre-process and clean YouTube comment data and associated YouTube video metadata, before modeling the data with the Wordfish algorithm using Ken Benoit's [`quanteda` package](https://tutorials.quanteda.io/machine-learning/Wordfish/).

# Part II: Preparing to Collect YouTube Comment Data
## Considering Ethics of YouTube Data Collection and Analysis
Before beginning the process of collecting data, it is important to consider the ethics of collecting and analyzing YouTube comment data. There are a number of ethical issues that arise in projects that draw on social media data, as D'Ignazio and Klein argue in [“data feminism”](https://mitpress.mit.edu/books/data-feminism). 

Should “public” social media data be used for research without the content creator’s permission? A user who comments on a number of related videos may not have imagined that their patterns of communication would become the subject of public debate through an academic project. Does researching a group of users with whom the researcher is less culturally familiar open the door to causing unintentional harm? Who speaks for communities being researched online? 

These are challenging questions for which there are not clear answers, but questions that should nonetheless be asked. DH researchers should fully incorporate ethical thinking in the use of their code: not everything that could be mined, analyzed, published, and visualized from YouTube should be.

There are a variety of resources that can help researchers think through these and other ethical issues. The University of California at Berkeley hosted a conference on ethical and legal topics in June 2020: Building LLTDM - Legal Literacies for Text Data Mining. Review [their website](https://buildinglltdm.org/), as well as the [Association of Internet Researcher’s Ethics page](https://aoir.org/ethics/) and Annette Markham's [Impact Model for Ethics: Notes from a Talk](https:// annettemarkham.com/2017/07/impact-model-ethics/).

## Installing R and RStudio
After considering and planning for any ethical problems with your research, the next step to mining YouTube comment data is to prepare the R programming workspace. R is an open-source coding language with more statistical tools than many proprietary statistical tools like STATA (*Software for Statistical Analysis and Data Science*). This lesson was written for R version 4.1. You can download R from the [Comprehensive R Archive Network](https://cran.r-project.org/).

Select the installation corresponding to your computer’s operating system and download the installer for R. Taryn Dewar’s lesson [R Basics with Tabular Data](https://programminghistorian.org/lessons/r-basics-with-tabular-data) covers how to install R and become familiar with it.

RStudio Desktop is the recommended [integrated development environment](https://en.wikipedia.org/wiki/Integrated_development_environment) for writing and running R scripts. The free version is more than sufficient. This lesson was written for RStudio Version 1.3. You can download and install RStudio from [rstudio.com](www.rstudio.com) - make sure to pick the Installers for Supported Platforms appropriate to your computer’s operating system.[^3]

[^3]: In lieu of installing R and RStudio on your computer, you may use [RStudio Cloud](https://rstudio.cloud/), a web-based version. This tutorial will run on RStudioCloud. However, depending on how often you use the cloud version, you may require a paid [subscription](https://rstudio.cloud/plans/free).

The code used in this script includes packages and libraries from standard R as well as the Tidyverse. For background info on the basics of the R programming language, [Basic Text Processing in R](https://programminghistorian.org/lessons/basic-text-processing-in-r) by Taylor Arnold and Lauren Tilton provides an excellent overview of the knowledge of R required for text analysis. To learn more about Tidyverse, there are many great sources online, including [A Tidyverse Cookbook](https://rstudio-education.github.io/Tidyverse-cookbook/program.html) by Garrett Grolemund.

Both the R script and the sample data are available for download on the [Programming Historian Github repository](https://github.com/hawc2/Programming-Historian-Tutorial). You can skip the API querying section of this lesson if you wish to download the dataset and skip to the analysis stage. This lesson can also be adapted to alternative videolists. To download and analyze YouTube data, the first step is to create authorization credentials with YouTube to receive access to their API.

## Obtaining YouTube API Authorization Credentials
Obtaining YouTube API authorization credentials is a multi-step process. First,  register for a Google developer account. While a developer account allows you to incorporate YouTube functionality into your own website or app, it can also be used simply to perform searches of YouTube content. See YouTube's API [reference page](https://developers.google.com/youtube/v3/docs) for more information.

You will use the developer account to create your authorization credentials. Once you create the credentials, you can use them in your R code to access YouTube data through the API. The credentials tell YouTube who you are when you request data.

### Creating a Google Developer Account
To create a Google developer account, you must have a Google account. If you do not already have a Google account, you can [create one](https://accounts.google.com/signup/v2/webcreateaccount?continue=https%3A%2F%2Faccounts.google.com%2FManageAccount%3Fnc%3D1&flowName=GlifWebSignIn&flowEntry=SignUp). 

Next, sign into your Google account and go to the [Developer Console](https://console.cloud.google.com). More details on the process can be found on [YouTube’s API overview](https://developers.google.com/youtube/v3/getting-started).

### Creating Authorization Credentials
In the developer console, you will begin the authorization credential process. This process involves creating secret keys that are linked to your Google account.Google's documentation is geared toward app developers, so the instructions can sometimes be confusing for researchers looking for developer authorization to retrieve data for local analysis. 

There are two types of authorization credentials that can be used to access YouTube data - an API Key or an OAuth 2.0 authorization. The [`tuber` package](https://cran.r-project.org/web/packages/tuber/index.html) requires OAuth 2.0 authorization. This is because, by using `tuber`, you grant it the authority to access personal YouTube data linked to your Google account. 

If you are not comfortable with your personal data being accessible, consider creating a Google account specifically for research or using an alternative tool for collecting data instead (as discussed below).

The OAuth 2.0 credentials process involves creating an OAuth ID and Secret. Never share your OAuth ID and Secret with others because, as noted above, someone could use these codes to access your personal YouTube data. In addition, someone could use the codes to masquerade as you when retrieving data.

Google periodically updates the way it organizes its developer accounts and changes the way the YouTube API works. For up-to-date instructions, see Google's [Obtaining authorization credentials page](https://developers.google.com/youtube/registering_an_application).

Here are steps to create OAuth 2.0 authorization credentials (these instructions are accurate as of 11/1/22 and may change):

#### Create Project
1. Create a project in the developer console. 
2. Name the project. 

#### Give OAuth Consent
3. Choose "OAuth consent screen" on the left of the screen. Choose "External" and CREATE. 
=4. Enter in an "App name" that describes your project, and your Google email under App information. Also enter your email under Developer contact information. You did not need to fill in the remaining fields. Click SAVE AND CONTINUE. 
5. Skip the Scopes and Test users pages by clicking SAVE AND CONTINUE. Then choose RETURN TO DASHBOARD.

#### Create Credentials
6. Now, choose the "Credentials" tab on the left, and click CREATE CREDENTIALS. 
7. Choose "OAuth Client ID" and "Web application." 
8. Add a name in the "Name" field and click CREATE. 

#### Save Credentials
9. Your credentials (Client ID and Client Secret) are now created. Save them in a secure file. They can also be redownload them from the developer console if you misplace them.

## A Note on API Daily Quotas
Note that the YouTube API has a quota that limits the number of queries you can perform each day. A new account begins with a token grant rate limit of 10,000 grants per day. According to Google, these limits are designed to protect their system and their users from abuse. Once you pass that quota, all searches through the API (including keyword search, metadata query, and comment retrieving) will generate a failed server request error in the R console (typically this will be a 401 or 403 error).

Creating and switching between multiple sets of access credentials (by using multiple Google accounts) is one way to continue gathering data once your first account has reached its quota. You may also request to have your daily quota raised. To do this, submit a [quota increase request](https://support.google.com/code/contact/oauth_quota_increase) with Google.

## Alternative Approaches to Collecting YouTube Data
While this tutorial demonstrates how to retrieve YouTube comments entirely with the R programming language, the acquisition of YouTube data can also be performed using available web-apps. One of the best open-source and user-friendly tools available for acquiring YouTube data is [YouTube Data Tools](https://tools.digitalmethods.net/netvizz/youtube/) hosted by the University of Amsterdam’s Digital Methods Initiative. 

The YouTube Data Tool uses preset credentials to access YouTube’s APIv3, saving you the step of registering your own account. With this tool, you can pull user comments, metadata about a YouTube channel, and videos via keyword search. You can also create networks of users, videos, and recommended videos. All you need is the video ID—the last few characters of the YouTube site for that video (***e.g.***, SNWic0kGH-E). (See the Keyword Searching section below for an illustration of where to locate the ID.)

The YouTube Data Tool outputs a neatly organized .csv spreadsheet of the scraped comments alongside metadata about the exact time the comment was made, user information, and information about replies. Using this spreadsheet, a simple sort on the “replyCount” column can extract threaded conversations in order to focus on dialogue. The comments alone could also be concatenated into one large text file for topic modeling or other corpus analytics. [^1]

[^1]: For relevant blog posts on retrieving and analyzing YouTube data, see: 1) the authors' introductory [blogpost](https://sites.temple.edu/tudsc/2018/12/12/how-to-scrape-and-analyze-youtube-data-prototyping-a-digital-project-on-immigration-discourse/); 2) Lemire-Garlic's [blogpost](https://sites.temple.edu/tudsc/2019/04/03/computational-text-analysis-of-youtube-video-transcripts/) on scraping for transcripts; 3) Ania Korsunska's [blogpost](https://sites.temple.edu/tudsc/2019/03/26/network-analysis-on-youtube/?relatedposts_hit=1&relatedposts_origin=5709&relatedposts_position=0) on network analysis of YouTube comment data; 4) and for scoping project design, see Lemire-Garlic's [blogpost](https://sites.temple.edu/tudsc/2019/10/30/to-code-or-not-to-code-project-design-for-webscraping-youtube/).


# Part III: Collecting YouTube Video Metadata and Comments
In this section, you will learn how to query the YouTube API to download video metadata and comments using your YouTube API OAuth ID and Secret. The R [`tuber` package](https://cran.r-project.org/web/packages/tuber/index.html) contains several [helpful functions](https://cran.r-project.org/web/packages/tuber/vignettes/tuber-ex.html), including `get_stats()` to gather numerical and descriptive metadata about a video and `get_all_comments()` to gather comments.

To begin, you’ll first need to create a new R script and install a series of packages.[^4] The versions of the libraries necessary to currently run this program are `Tidyverse 1.3.1` (containing necessary packages `ggplot2`, `purrr`, `dplyr`), as well as `gtools 3.8.2`, `lubridate 1.7.9`, `quanteda 3.2.1`, `tuber 0.9.9`. While most packages are the CRAN version, this lesson uses the developer versions of `tuber` and `tidyverse`.

[^4]: For introductory information about installing R packages, see [Datacamp's guide to R-packages](https://www.datacamp.com/community/tutorials/r-packages-guide).


## Install R Packages
To install the necessary packages in R, run the following lines of code:

```
install.packages(c("gtools", "lubridate", "purrr", "devtools",
                   "quanteda", "quanteda.textmodels", "quanteda.textplots", "quanteda.textstats", "stringi"))
devtools::install_github("soodoku/tuber", build_vignettes = TRUE)
devtools::install_github("tidyverse/tidyverse")
```

To load these packages into your R coding environment, run the following code: 

```
library(tidyverse); library(tuber);library(gtools); library(lubridate); library(ggplot2); library(purrr); library(quanteda); library(quanteda.textmodels); library(quanteda.textplots); library(quanteda.textstats); library(stringi)
```

[^7]: For a more in depth explanation of how OAuth credentials are used within R packages, see the [CRAN guide](
https://cran.r-project.org/web/packages/googlesheets/vignettes/managing-auth-tokens.html).

Next, you'll incorporate your OAuth ID and Secret into the code. There are a couple of ways that you can do this.[^7] The simplest way is to type in your credentials directly into your own version of this script. This is [the approach](https://cran.r-project.org/web/packages/tuber/readme/README.html) envisioned by the `tuber` packagee.

## Add YouTube API Credentials
To authenticate your account with the YouTube API, inset the following lines of code, replacing the "INSERT YOUR API ID" and "INSERT YOUR API SECRET" with your unique account keys.

```
app_id <- "INSERT YOUR API ID"
app_secret <-"INSERT YOUR API SECRET"

yt_oauth(app_id, app_secret)
```

After you run the [yt_oauth](https://www.rdocumentation.org/packages/tuber/versions/0.9.8/topics/yt_oauth) function, you will need to authorize tuber to use your credentials by responding to a prompt in the console. Type “1” into the console following the prompt in order to give permission for authorization. You will then be prompted on a pop-up browser window with a message from Google to permit the application to access your YouTube data.

Once you have finished this authentication process, you can begin querying the YouTube API.

## List Videos
To search for video comments, you can either use a list of videos or a keyword search. For this tutorial, we search for comments using a predetermined video list. You can replace the videos in our tutorial with your own if you'd like to focus on a different topic.

To work from a list of video IDs, you’ll need to create a character vector in the R script containing each ID as a separate string. 

The following lines of code create a character vector of IDs to search.

```
IDsforSearch <- c("tRmqEbP0G6I", "vksEJR9EPQ8", "YPSwqp5fdIw", "q2L-8-rUM7s", "kiSm0Nuqomg", "VDd5GlrgvsE", "muy5zpqslRc",
                  "Tw-4MT3ZE-o", "WeXcde_B3ZY", "3n5_D59lSjc")
```

The most direct way to pick out your own videos is to visit the YouTube site, and capture a list of video IDs from each video’s URL. A video’s ID is the set of alphanumeric characters that appear in the URL immediately after `watch?v=` For example, in the illustration below, the video ID is `24xsqyMcpRg`. Video IDs are constant and do not change over time.

{% include figure.html filename="PH_YouTube_Video_ID_screenshot.png" caption="WRITE IMAGE CAPTION HERE" %}

The selected list of videos to scrape for comments and metadata is created from the video IDs found by searching YouTube for "black lives matter george floyd". Choosing multiple videos is often the best approach at this exploratory stage, especially because the YouTube API does not always return data for every video searched, even if comment data for that video exists. 

Since this lesson focuses on the Wordfish algorithm, the selected videos are drawn from polar opposite creators (channels) with a significant number of comments to model (e.g., at least 5000 comments). For this reason, the videos were selected from opposite political leaning news source videos (ranked by allsides.com), including the "left-leaning" sources of New York Times, Vox, and NBC News and the "right-leaning" Daily Mail, Fox News, and the Daily Wire.

[^8]: To search for relevant videos, use one or more general [keywords](https://developers.google.com/youtube/v3/docs/search/list). YouTube makes available a wide range of metadata about each video, including the number of likes, title, description, tags, and more.[^8] The YouTube API allows you to search for keywords in the textual metadata (including video title, description, and tags). The [yt_search](https://www.rdocumentation.org/packages/tuber/versions/0.9.8/topics/yt_search) function in `tuber` accesses this feature in the API. This second option enables you to identify a list of videos likely to be relevant to your topic by searching for videos with metadata that includes your keyword(s) of interest. For more on what you can do with YouTube metadata, see Lemire Garlic’s blog posts and her [Github page](https://github.com/nlgarlic/YouTube-Related-Video-Similarity).

## Retrieve Video Metadata
Once your videos are chosen and entered into the `IDsforSearch` character vector, use the following code to pull the metadata for each video. The metadata includes the publication date and time, video title, and channel title for each video. In the analysis stage of your project, this data can be used to contextualize the comments retrieved.

Using the [get_video_details()](https://www.rdocumentation.org/packages/tuber/versions/0.9.8/topics/get_video_details) function from `tuber`, the code pulls all of the metadata for your chosen videos from the API. The code then limits the metadata to what we have found most useful: the video ID itself, and also the video publication date, video title, and channel title. By using the [possibly()](https://purrr.Tidyverse.org/reference/safely.html) function from the Tidyverse, we suppress error messages that would terminate our code if the API failed to return any results for one or a few of the identified videos.

This code downloads metadata about the videos, including publication data and time, video title, and channel title. To do so, first it creates a custom `possibly` function to scrape video details.

```
get_avlbl_details <- possibly(get_video_details, otherwise = NULL)
```

Secondly, use a map function to pull metadata for each video and convert the metadata into a dataframe and print a message reporting the number of videos with metadata that were downloaded.

```
AllDetails <- map(IDsforSearch, get_avlbl_details)
do.call(smartbind, lapply(AllDetails, data.frame)) -> AllDetailsDF
AllDetailsDF[] <- lapply(AllDetailsDF, as.character)
AllDetailsDF <- select(AllDetailsDF,
                       videoId = items.id,
                       publishedAt = items.snippet.publishedAt,
                       title = items.snippet.title,
                       channelTitle = items.snippet.channelTitle) %>%
  arrange(desc(publishedAt))

AllDetailsDF$publishedAt <- AllDetailsDF$publishedAt %>% as_datetime(tz = "UTC", format = NULL)

print(paste("You have downloaded metadata for", nrow(AllDetailsDF), "videos."))

# view channel title, video title, and date
glimpse(AllDetailsDF)
```

Now that you have scraped the metadata for your videos, you can move on to gathering the comments. 

## Retrieve Video Comments
The following code gets all available video comments from API, and converts them to a dataframe. As with gathering the video metadata, it uses `possibly()` to avoid error messages for unavailable video comments.

Because the YouTube API sometimes collects only a portion of the comments available for each video; best practice is to cross-check the number listed on YouTube’s corresponding video page with the number retrieved from the API.

First, create a custom "possibly" function to scrape comments

```
get_avlbl_comments <- possibly(get_all_comments, otherwise = NULL)
```

Next, download the comments for the selected video IDs with custom possibly function and map them to each other.

```
AllComments <- map(IDsforSearch, get_avlbl_comments)
```

Print the number of comments scraped.

```
if(length(AllComments)==0){
  print("No comments can be downloaded at this time.")
} else {
  do.call(smartbind, lapply(AllComments, data.frame)) -> AllCommentsDF
  AllCommentsVideos <- unique(AllCommentsDF$videoId)
  print(paste("You have downloaded", nrow(AllCommentsDF),
              "comments from", length(AllCommentsVideos), "unique videos:"))
  AllCommentsVideos
}
```

This next section of code joins the video metadata with the comment data renaming some columns for clarity.

## Join Video Metadata and Comments

To combine video metadata with comment text data and metadata, insert the following lines of code. 

```
AllCommentsMetadata <- AllCommentsDF %>% inner_join(AllDetailsDF, by = "videoId")
AllCommentsMetadata <- rename(AllCommentsMetadata,
                              c(commentPublishedAt = publishedAt.x,
                                commentUpdatedAt = updatedAt,
                                commentLikeCount = likeCount,
                                commentId = id,
                                videoPublishedAt = publishedAt.y,
                                videoTitle = title,
                                videoChannelTitle = channelTitle,
                                commentText = textOriginal))
```

## Export Data (optional)

At this point, you can back up your data in a local directory and export your data as a .csv file. 

The directory can be omitted, if preferred. And the subject variable should be changed to fit your topic.

To export video metadata and comments in a "Data" folder, use the following command:

```
dir.create("YouTubeData")
```

You can change the `subject` variable in the next lines of code to suit your topic:

```
subject <- "Left_v_Right_BLM_Coverage"
```

Finally, download the data as a csv: 

```
write.csv(AllCommentsMetadata, paste("YouTubeData/AllComments_", subject, "_",
                                     Sys.Date(),sep=""))
```

After backing up your data, you can skip to Part IV if you are ready to wrangle that data.

## Import Sample Data (optional)

But if you would like to read in a .csv of already scraped comments and metadata, use the following code first. You don't need to run these lines of code if you scraped the data via the above steps. Note that if you have a comment dataset that was not scraped using this tool, you may be able to use it, but be mindful that you may also need to reformat it in order to use the rest of this script.

After downloading the data from the Github repository, read in the sample data: 

```
AllCommentsMetadata <- read.csv("YouTubeData/AllComments_Left_v_Right_BLM_Coverage_2022-05-19")
```

# Part IV: Pre-processing and Cleaning YouTube Data
Tuber collects comment data in `lists` form from the YouTube API.  In some of the above steps, this data was converted into a single large dataframe which contains all comments collected, from all of the different videos scraped, along with a number of additional pieces of metadata.  However, the comment text data still needs to be cleaned and preprocessed to make it usable for text data mining.

Because of other unique properties of YouTube comments (such as rare words, slang, other languages, or comments composed mostly of special characters or emojis), some additional wrangling is needed to ensure that each comment used contains enough data meaningful for Wordfish scaling. This lesson removes these comments with less words at this stage because they definitively have too little textual data for meaningful analysis, so there is no need to spend further computing power on them. As explained below, the Wordfish model relies on scores given to words with semantic meaning and comments with less than 10 words are not likely to contain much meaning. If you are using a different analytical model, it may require leaving in emojis, links, numbers, mentions, etc.

### Clean the Data
To clean the comments, use the `stringr` package in Tidyverse and `stringi` from base R. The following code filters out numeric digits, punctuation, emojis, links, mentions, and comments with less than 10 total words. In addition, the following code converts all text to lowercase, as is standard practice for many text analysis applications. 

Note you can also clean the data using the `quanteda` R package at a later stage of this lesson, but we recommend `stringr` and `stringi`if you are only trying to export data from YouTube for a purpose other than the WordFish modeling described below.

```
AllCommentsMetadata$commentText <- AllCommentsMetadata$commentText %>% 
  str_remove_all("[:punct:]||&#39|[$]") %>% 
  str_remove_all("[@][\\w_-]+|[#][\\w_-]+|http\\S+\\s*|<a href|<U[+][:alnum:]+>|[:digit:]*|<U+FFFD>") %>%
  str_to_lower()

AllCommentsMetadata <- AllCommentsMetadata %>% filter(
  str_detect(commentText, "\\D+"))

AllCommentsMetadata <- AllCommentsMetadata %>% mutate(
  numbWords = str_count(AllCommentsMetadata$commentText, boundary("word"))) %>% filter(
  numbWords >= 10) %>% mutate(
  uniqueWords = map(commentText, stri_unique) %>% unlist()
)

print(paste(nrow(AllCommentsMetadata), "comments remaining"))
```

This data can now be transformed into a Wordfish-friendly format.

# Part V: Exploring YouTube Comments with Wordfish
The final part of this lesson explores the Wordfish model in more detail and explains how it can be applied to explore YouTube comment data. You will learn how to build a corpus from the Black Lives Matter YouTube comment data scraped above, and how to optimize it for the Wordfish model. Finally, this lesson concludes by generating a simplified visualization and offers a brief discussion on how to interpret Wordfish model results.

This lesson demonstrates how to use the model in an exploratory fashion, showing how to use this predictive modeling algorithm to help bring to light patterns in the data ripe for further investigation. For sources that more extensively discuss when to use Wordfish and how to interpret Wordfish model results, see the "Resources" section below.

## Understanding the Wordfish Text Mining Algorithm
A wide range of text mining algorithms are available for scholars in the digital humanities looking to create models of big data. Many of these algorithms have already been described with tutorials on the Programming Historian - see, for example, [word frequency analysis](https://programminghistorian.org/en/lessons/counting-frequencies) and [introduction to topic modeling](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet). The text mining algorithm this lesson uses is called Wordfish. For information on the algorithm itself and to view its base code, see here: http://www.Wordfish.org/software.html

Developed by and for political scientists, Wordfish helps model textual data along a single-dimensional axis. Wordfish was created as a method for extracting the ideological leaning of documents expected to contain latent political motivation or ideology (***e.g.***, party manifestos or platforms, politician floor speeches) relative to a corpus of similar texts. For example, Wordfish can be a useful tool for identifying which United States representative floor speeches were probably made by either Democrats or Republicans - as well as the extremity of the partisan leaning evident in those speeches.

### Interpreting Wordfish's Scale
As an unsupervised scaling method, Wordfish gives two kinds of information:

Firstly, Wordfish gives information about how documents (in this case, individual comments) are best discriminated from each other by scaling them along a single dimension. In essence, the model collects comments that are ‘similar to’ each other on each end of the dimension, based on the kinds and frequencies of words used in those comments. Comments on far opposite ends of this scale in particular types of discursive contexts may be characterized by the inclusion of different sets of unique words, indicating focus on different kinds of concepts. 

Secondly, Wordfish identifies which specific, unique kinds of words the model used in order to perform this scaling, and arrays them along a similar dimension. The placement of words along this scale is inherently informative - we can directly understand the meanings of words just by inspecting their placement on the appropriate visualization. The same is not inherently true of documents, without collecting or including some additional information (‘metadata’). When the documents being scaled have meaningful titles or categories, this title or category metadata can be very useful.

### Interpreting Latent Meaning
Although Wordfish was initially developed by political scientists for researching political ideology, there is nothing ‘inherently’ political about the dimension revealed by Wordfish. Wordfish can be used to extract inherent ‘latent’ dimensionality (based on broad differences in words used) existing within any corpus. The substantive interpretation of this latent dimension depends entirely on broad trends in the typical contents of the documents comprising your research corpus.

For example: in a corpus where you already know that your documents are about cats and/or dogs (but not specifically which documents are about which animal), a Wordfish model would describe which documents are likely about cats, which are likely about dogs, and how ‘cat-typical’ or ‘dog-typical’ each document is. Very ‘catty’ or ‘doggy’ documents would be placed at the far ends of this predicted dimension. Documents that are intermediate (because they are partially about cats and partially about dogs, or because they are not about either cats or dogs) would appear towards the center of the predicted dimension.

There are many underlying factors that can drive the latent scaling dimension a Wordfish model identifies. If content is strongly motivated by the author’s political ideology, this dimension can separate writing from authors on opposing sides of a political issue. This dimension almost always describes broad differences in content, based on the kinds of words used.

Since YouTube comments are short, you may find some specific examples helpful.  When analyzing comments from a single video, you will often find that this dimension separates comments about the aesthetics of the video from those discussing its topical focus.

### Document Term Frequency Matrixes
The rest of this lesson will introduce how to run in R the Wordfish algorithm on YouTube comment data and generate a model with visualizations. Wordfish operates by making predictions about the placements of documents along a uni-dimensional scale based on a Document Feature Matrix (DFM).  Document feature matrices are a tidy, structured format for storing data about the frequency of the word types used in each of a corpus of documents by using the ['bag of words'](https://en.wikipedia.org/wiki/Bag-of-words_model) approach.

The Wordfish algorithm can be clarified by comparison to [topic modeling](http://www.cs.columbia.edu/~blei/papers/Blei2012.pdf), a tried and true method for text mining. Similar to topic modeling, Wordfish uses this document term matrix to make predictions about documents based on the different kinds and frequencies of words (tokens) used in each. They are both predictive modeling approaches to mining text data / processing natural language that rely on machine learning algorithms. Further, both are ‘unsupervised’ - they do not rely on extrapolating information about the dataset provided based on the way the user pre-codes a subset of that data.  Instead, they both look at differences between documents, using statistics to count the complex frequencies of tokenized words used in each document in comparison to one another in order to identify ‘natural’ groupings along a scale.

Another important similarity between Wordfish and topic modeling is that both treat documents as “bags of words”.  This means that the models only look at word frequency between documents.  These models do not take into account any information about word order. That means that it doesn’t matter ***where*** words occur in a document, just ***which*** words occur, and how many times each of those occurs.  Since social media comments tend to be very short, treating comments as bags of words is actually less of a potentially problematic assumption than it might be for longer documents, where different sections of content (paragraphs, pages, chapters, etc) might convey different types of meaning, and by consequence contain very different types of words.

One of the most significant strengths of both of these kinds of predictive models is their ability to refine results by passing over the data multiple times. When a Wordfish model is initialized, all of the parameters a Wordfish model measures are set as a ‘first best guess’ at the latent scaling of documents and words.  This ‘first best guess’ gives a helpful level of general insight. Depending on the quality of the text data, sometimes these models will be able to refine these initial predictions, gradually closing in on even more statistically robust and insightful models.

## Understanding the Quanteda Corpus, DFM, and Token Objects
The Wordfish algorithm was initially distributed as [`R code`](http://www.Wordfish.org/software.html), but is now available in the [`quanteda`](https://quanteda.io/) package. This enables seamless wrangling of the YouTube comment data into a useful format for Wordfish and [to run the Wordfish algorithm](https://quanteda.io/reference/textmodel_Wordfish.html). For documentation, visit Quanteda's [docs and tutorials page](https://quanteda.org/quanteda/).

To run the Wordfish model in `quanteda`, we create three types of text objects: a corpus, tokens, and a document feature matrix (dfm). For more detail on how these objects work together, see quanteda's [quick start page](https://quanteda.io/articles/quickstart.html#how-a-quanteda-corpus-works-1) .

The corpus object contains all of the "documents" (in our case, comments) that we wish to analyze. In addition to the text of the documents, it also includes the comments metadata. The metadata describes the attributes of each comment, such as the video channel title to which the comment was associated.

In `quanteda`, the tokens object is a list of character vectors linked back to the document (comment) from which they originated. While in this form, the text can be further cleaned and pre-processed. The tokens can be stemmed or lemmatized, and stopwords can easily be removed.

In this illustration, the `dfm` object is generated from the tokens. The `dfm` object places each document (comment) in a row, and "features" in columns. In a Document Feature Matrix, the word "feature" refers to every "term" found in the collection of documents. In this instance, each term is a word.

If the words "justice", "peace", and "riot" were in our dataset, a `dfm` with these words might appear like this:

Document-feature matrix of: 2 documents, 3 features (83.81% sparse) and 0 docvars.
               features
docs           justice    peace    riot
comment1          4        3        0
comment2          0        1        4

Here, comment1 included four usages of the word "justice" and three usages of the word "peace", but no usages of the word "riot". Comment2, in contrast, contained four usages of the word "riot" and one use of the word "peace", but no use of the word "justice."

## Selecting Comments for the Corpus
Before building the corpus object, you also need to select the video comments to include in the analysis based on relevant metadata, like the video's designated YouTube channel. Curating a dataset of YouTube comments for Wordfish requires finding videos with a sufficient amount of data (enough comments, but also enough words per comment) to conduct predictive modeling. 

Wordfish modelling is typically performed on corpora of dozens or hundreds of documents, each usually containing hundreds or thousands of words. YouTube comments tend to be very short in length, but popular videos will often be accompanied by thousands of comments; enough to make up for their brevity, as long as the shortest comments are excluded prior to modeling.

Because Wordfish is designed to measure ideological scaling along a one-dimensional scale, for purposes of this lesson, the YouTube video channels can be classified into two groups - "right" and "left" political leanings. The following chunk of code creates a separate, document-level variable indicating political leaning. This code uses the tidyverse functions mutate and case_when to create the poliLeaning variable. It then counts the number of comments for both "left" and "right" news sources to confirm that they are comparable.

```
wfComments <- select(AllCommentsMetadata, commentId, uniqueWords, videoChannelTitle) %>% mutate(
      poliLeaning = case_when(
      videoChannelTitle == "Daily Mail" ~ "right",
      videoChannelTitle == "Fox News"  ~ "right",
      videoChannelTitle == "The Daily Wire" ~ "right",
      videoChannelTitle == "NBC News" ~ "left",
      videoChannelTitle == "The New York Times" ~ "left"
    ))
wfComments %>% count(poliLeaning)
```
After running the code, it is clear that there are significantly more left leaning than right leaning sources. This code chunk determines how many videos are associated with each source.

```
wfComments %>% count(videoChannelTitle)
```

Running this code shows that removing The New York Times would balance out the left and right-leaning sources. Using the filter function from the tidyverse, this code removes that source from the data set.

```
wfComments <- wfComments %>% filter(videoChannelTitle != "The New York Times")
wfComments %>% count(poliLeaning)
```

If you are using a different data set, make sure that there is relative parity in the number of comments. For Wordfish to run best, there should not be a radically different number of comments for each pole you are investigating. 

### Building the Corpus
To build your corpus object, execute this simple code. 

```
options(width = 110)

corp_comments <- corpus(wfComments, docid_field = "commentId", text_field = "uniqueWords")
summary(docvars(corp_comments))
```

### Tokenization and DFM Creation
Next, the corpus must be [tokenized](https://en.wikipedia.org/wiki/Lexical_analysis#Tokenization) so that the document feature matrix can bve created. As noted above, after creating the corpus object, `quanteda` has in-built features allowing further preprocessing to remove generic and custom stopwords at the token level.

This exploratory, iterative process involves narrowing and focusing on the terms and features most emblematic of the video comments. A high concentration of stopwords in documents can adversely impact text data mining models, so you are usually better off removing them prior to modeling.

The custom stopword list, below, is based on an iterative exploration of the Black Lives Matter corpus. It can be modified based on what you've noticed in your comments and relating to your subject. 

```
toks_comments <- tokens(corp_comments, remove_punct = TRUE,
                        remove_symbols = TRUE,
                        remove_numbers = TRUE,
                        remove_url = TRUE,
                        remove_separators = TRUE)

dfmat_comments <- dfm(toks_comments)

dfmat_comments <- dfm_remove(dfmat_comments, pattern = c(stopwords("en"), "george", "floyd", "america", "black", "matter", "blm", "thing", "thats", "people", "lives", "something", "nothing", "someone", "really", "didnt", "gayprides", "going", "tucker", "doesnt"))

print(paste("you created", "a dfm with", ndoc(dfmat_comments), "documents and", nfeat(dfmat_comments), "features"))
```

## Optimizing the Corpus for Wordfish
In this next section, you will optimize the corpus to focus on meaningful words in the comments by removing commonly used words and words with less than five characters or that appear less frequently. It also removes those words that appear in more than 20% of the documents. You may consult the quanteda documentation on [dfm_trim](https://quanteda.io/reference/dfm_trim.html) for additional optimization options.


```
dfmat_comments <- dfm_keep(dfmat_comments, min_nchar = 5)

dfmat_comments <- dfm_trim(dfmat_comments, min_docfreq = 0.1, min_termfreq = 0.001, termfreq_type = "prop")

print(dfmat_comments)
```

### Checking Top 25 Words
After optimizing the words, it is helpful to manually review the top 25 words to give you a sense of what the substance of the comments are like overall. If you see words in the top 25 that have limited semantic meaning, consider going back to your stop list and running the optimization code again. For example, you might consider removing a word like "didnt" by adding it to the custom stopword code used above and re-running that code.

The following lines of code print the top 25 words for manual review. 

```
mostWordsAll <- topfeatures(dfmat_comments, 25, decreasing = TRUE) %>% names() %>% sort()
mostWordsAll
```

Once you are satisfied with the top 25 words, you can move onto creating the Wordfish model.

## Visualizing and Interpeting the Wordfish Model
Before creating the Wordfish model, one last step is required to prepare the metadata for the visualization.

First determine the most frequent 25 words for each group using Quanteda's `topfeatures()` function, removing those that appear in both political leanings. These words will be used later in the visualization. This lesson focuses on the top 25 words because they give you a sense of what the substance of the comments are like without clouding the visualization with too much highlighted data. To determine which words most frequently appear in each pole, use the `topfeatures()` function in Quanteda.

This code determines the top 25 words for each pole, and then removes those that appear in both poles. With this approach, the visualization will highlight those that are unique to each pole.

```
poliTopWords <- topfeatures(dfmat_poliLeaning, 25, decreasing = TRUE, groups = poliLeaning)
leftTopWords <- names(poliTopWords$left)
rightTopWords <- names(poliTopWords$right)
bothTopWords <- leftTopWords %in% rightTopWords
leftTopWords <- leftTopWords[!bothTopWords] 
rightTopWords <- rightTopWords[!bothTopWords]
```

## Build Wordfish Model
The following code creates a Wordfish model based on all of the comments. While the model is robust, the code to run it is compact. Because we are interested in comparing the left and right leaning channels, we group them with the `dfm_group` function using the poliLeaning variable we created earlier.

```
dfmat_poliLeaning <- dfm_group(dfmat_comments, groups = poliLeaning)

tmod_wf_LR <- textmodel_wordfish(dfmat_poliLeaning, dispersion = "poisson", sparse = TRUE, residual_floor = 0.5)
summary(tmod_wf_LR)
```

Wordfish models scale both the documents in a corpus and also the words in the vocabulary of that corpus along horizontal and vertical axes identifying polarity of perspective.  This lends itself to two distinct kinds of visualizations of Wordfish model results: a ‘document-level’ visualization and a ‘word level’ visualization.  The below code will create 'word level' visualizations of how terminology is dispersed across the corpus object.

To create the visualization, you can use Quanteda's `textplot_scale1d()` function, setting the margin parameter to "features." This function plays well with `ggplot2`. Therefore, you can use the `ggplot2` "+" to add components to the base plot. This lesson uses the `labs()` component to create a label for the plot.

```
leftRightPlot <- textplot_scale1d(tmod_wf_LR, margin = "features") + 
                                    labs(title = "All Comments Wordfish Plot")
leftRightPlot
```
{% include figure.html filename="all_comments_plot.png" caption="Visualization of Wordfish model of all comments" %}

This visualization shows all of the words found in the corpus comments. You can read the outlier comments on the far right and left of the visualization pretty easily. But, given the large number of words displayed, the bulk of the comments in the middle of the visualization can be difficult to read and interpret.

To make the visualization easier to read,it is useful to highlight the words that most frequently appear in the left and right-leaning channels by plotting them separately. Seeing these separate plots next to each other would make comparison even easier. The multiplot() function, borrowed the multiplot function from the R Cookbook [http://www.cookbook‐r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2] makes this straightforward.

To creates a function to show multiple plots on one screen, use the following R code.

```
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  plots <- c(list(...), plotlist)
  numPlots = length(plots)
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }

  if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

      for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
```
Now, you can generate the plots of each group separately. This next chunk of code shows how to plot the top unique words for the left and right leaning channels. Left words are highlighted blue and right words highlighted red.

```
leftPlot <- textplot_scale1d(tmod_wf_LR, margin = "features",
                                            highlighted = leftTopWords,
                                            highlighted_color = "blue") +
  labs(title = "Top Words - Left Leaning Channels")


rightPlot <- textplot_scale1d(tmod_wf_LR, margin = "features",
                                          highlighted = rightTopWords,
                                          highlighted_color = "red") +
  labs(title = "Top Words - Right Leaning Channels")


multiplot(leftPlot, rightPlot, cols = 2)
```

{% include figure.html filename="left_right_plots.png" caption="Visualization of Wordfish model by channel groups" %}

You will notice in the above visualization that there is a clear horizontal separation between comments. Most of the comments are located in the middle of the horizontal dimension, with a few outliers at each end. There are many ways to interpret the substantive meaning of this scaling.  Below we offer two ways to interpret the results.

The first interpretive method involves using comment metadata to check for trends in comment scaling. For this method, we would use the group-specific visualizations produced with multiplot(). Because we color-coded the top words for each group of channels, we can more readily compare the words most frequently appearing in left and right-leaning channel comments.

The second interpretive method involves inspecting word-level WF output, to see what kinds of words characterize the left- and right- portions of the scale, and qualitatively identify broad commonalities between words at each end of the scale. For this method, we would use the initial plot we created with comments from all videos.

Words appearing on the left of this plotting space are common among documents on the left of the plotting space, and rare among documents on the right (and vice versa).  The vertical dimension here reflects the overall frequency of the word.  So, common words (unlikely to help much in differentiating left from right) appear near the top of the plotting space, and very rare words appear near the bottom.  The general triangular shape of this visualization is largely driven by the functional form of this model, although a deeper description of these aspects is beyond the scope of this tutorial.

For more on how to interpret Wordfish plots visit our [blog post](https://sites.temple.edu/tudsc/2017/11/09/use-Wordfish-for-ideological-scaling/)

# Conclusions
By this point of the tutorial, you have downloaded a large corpus of YouTube video comments, processed them, analyzed them using the Wordfish model of text scaling, and produced several insightful visualizations.

Based on the three visualizations you produced, you can tell that a broadly similar set of topics is discussed on left-leaning and right-leaning video comment threads on  YouTube videos focused on police brutality and questions about police funding.

These visualizations, and more granular analyses of the Wordfish model, will enable complex interpretations of textual meaning. That Wordfish can be useful for understanding the strange type of discourse that appears in YouTube comments is a fascinating revelation of its own.

# Endnotes
