---
title: |
    Beginner's Guide to Twitter Data
collection: lessons
layout: lesson
slug: beginners-guide-to-twitter-data
authors:
    - Brad Rittenhouse
    - Ximin Mi
    - Courtney Allen
layout: lesson

---

# Beginner's Guide to Twitter Data 


# Overview

In this guide, we'll show you easy methods for acquiring, hydrating, cleaning, and analyzing Twitter data.  While this walkthrough proposes a specific workflow that we think is suitable for students and researchers of all experience levels (it was originally conceived as a workshop for first-year undergraduates at Georgia Tech), we will note points in the process where other/more advanced techniques could be substituted. 

## TweetSets

First, we need to gather some data. George Washington University’s [TweetSets](https://tweetsets.library.gwu.edu/) allows you to create your own data queries from existing Twitter datasets. The datasets primarily focus on the biggest (US) geopolitical events of the last few years, but the TweetSets website states they are also open to queries regarding the construction of new datasets.  We chose TweetSets because it makes narrowing and cleaning your dataset very easy, but you could substitute any tool that gives you a set of dehydrated tweets, like Stanford’s [SNAP](https://snap.stanford.edu/data/) collections.  You could also work with the [Twitter API](https://developer.twitter.com/) directly, but this will require some coding.  Justin Littman, the creator of TweetSets, does a good job summarizing some of the higher-level ways of interacting with the API [here](https://gwu-libraries.github.io/sfm-ui/posts/2017-09-14-twitter-data).  

We find that the graphical, web-based nature of TweetSets, however, makes it ideal for learning this process.  That said, if you want to obtain a dehydrated dataset by other means, you can just start at the “Hydrating” section.

## Selecting a Dataset

{% include figure.html filename="tweetsets-home.png" caption="TweetSets start page" %}

If you’re using TweetSets, click “Get Started” and you’ll be able to see a list of all of their existing datasets. Clicking the name of each set will give you more information on the set, including its doi. 

When you have decided on the dataset(s) you  want to pull from, simply check the checkbox to the left.  You can choose as many as you’d like.  We’ve chosen two datasets focusing on Hurricanes Irma and Harvey, two major storms of the 2017 Atlantic Hurricane Season.  As you can see, this will give us just over 30 million tweets as is.  

{% include figure.html filename="dataset-selection.png" caption="Dataset Selection Page" %}

We’ll filter the dataset to make it easier to work with, but if you’re feeling confident in your data manipulation skills, you can download the whole thing.

## Filtering the Dataset with Parameters

On the parameters page, you have the option to limit your dataset by the tweet text content, hashtags used, mentions made, users who posted the tweets, users who are being replied to, the tweet type (original, quote, retweet, or reply), the timeframe during which the tweets were posted, or if they contain things like embedded images or geotags. 

{% include figure.html filename="parameters-1.png" caption="The "Parameters" page" %}

{% include figure.html filename="parameters-2.png" caption="Selecting all tweets that mention @realDonaldTrump." %}

As you can see above, we’ve chosen to limit our dataset by two parameters.  First, we want tweets that mention @realDonaldTrump and second, we want tweets that have geotags or location information.  This should give us a good view of who is talking about President Trump in these datasets, and where they are located.  You can imagine this kind of data would be good in analyzing how discourse around disasters forms both at ground zero and more broadly.  

{% include figure.html filename="parameters-3.png" caption="Selecting all geotagged tweets and the Action buttons section" %}

Once you have filled in your desired parameters, you have three options to proceed. "Preview" will give you a sample of the tweets based on your parameters, and, conveniently, the number of tweets your current parameters will return.  As you can see, the two parameters we chose have the added benefit of winnowing down the dataset from over thirty million tweets to just over five thousand: much more manageable.  This option is very helpful to make sure you are constructing a dataset that will work for your purposes before you actually go and download a bunch of data.  With more advanced tools, you usually have to download and hydrate your data before being able to figure out what is in it.

{% include figure.html filename="statistics.png" caption="Dataset Preview" %}

The "Create Dataset" option will freeze the parameters and create an exportable dataset.  "Start over" will reset your parameters and also return you to the dataset selection page. 

## Exporting the Dataset
To continue on, press "Create Dataset", at which point you will need to provide a name. This distinguishes this dataset from others you create on the site, so make it something descriptive.

{% include figure.html filename="naming-dataset.png" caption="The site prompts you for a name." %}

Now, you have the option to export (or not) four different aspects of data: by tweet IDs, mentions, top mentions, and top users. We’ll grab all of them and show you a few ways to work with them.  This is also good because, regardless of where and how you get your data from Twitter, you will probably encounter data that looks like one of these files.

{% include figure.html filename="downloads.png" caption="Download (and extract) every .zip." %}

{% include figure.html filename="exports.png" caption="After extraction, your files should look something like this." %}

## Hydrating
Hydrating is a common process with twitter data.  Because tweets can be correlated to so much data, it’s more efficient to distribute data sets consisting of unique tweet ids, and then allow users to “hydrate” the data, linking retweet counts, geolocation info, etc., to unique ids.  

{% include figure.html filename="dehydrated-IDs.png" caption="A preview of the dehydrated tweet-ids file." %}

Now that you have a set of tweet IDs, you can hydrate the file using DocNow's Hydrator, found [here](https://github.com/DocNow/hydrator).  On this page, scroll past all the source files to the bottom, where you can find prebuilt versions of the software.  Select the correct version for your machine and install.

{% include figure.html filename="doc-now-download.png" caption="The prebuilt versions of the Hydrator on github." %}

You will also need a twitter account to get a Twitter API key. Once you have an account, you can get the key under the Settings on the Hydrator. Doing so will send you to a link asking you to authorize the Hydrator; authorize the app to continue. 

After you have authorized the Hydrator, you need to upload the dataset. Under the "Add" menu tab, click "Select Tweet ID File". This will open your OS file directory where you need to find the unzipped tweet-id file. You can find in in the files you downloaded from TweetSets (if you’re not using TweetSets, you will still need a dehydrated document with a series of Tweet IDs).  You can see below that this looks like a series of 18 digit ID numbers, each of which corresponds to a specific tweet on Twitter, and that the Hydrator will link with the tweet itself, along with a bunch of associated metadata. Once you have found the right file, upload it to the Hydrator. 

{% include figure.html filename="hydrator.png" caption="Hydrator prompts for a title and a tweet ID file." %}

{% include figure.html filename="tweet-id-file.png" caption="The tweet ID file looks like a series of 18 digit numbers.  It's probably the only .txt file in those you downloaded from TweetSets." %}

Once you have loaded the Tweet ID file, you should see the file path populate in the Hydrator, as well as an overview of the number of tweets detected.  

{% include figure.html filename="hydrator-loaded.png" caption="If you've loaded your tweet-ID file correctly, hydrator should display its file path, and the number of tweets in the dataset." %}

You will need to create a name for your hydrated file, but can ignore the rest of the fields on this screen.  Click “Add dataset,” and you will be taken to a screen where you can begin the hydration.  To start the hydration, click "Start". This will prompt another window asking for a name and location to save the hydrated tweets.  Add .csv to the end of whatever title you provide to ensure the file is legible to a wide variety of programs you may use to analyze your data.

{% include figure.html filename="hydrated-save-file.png" caption="Append .csv to your save file." %}

{% include figure.html filename="pre-hydration.png" caption="Just press "Start"." %}

{% include figure.html filename="post-hydration.png" caption="The green bar will fill as your dataset is hydrated." %}

At this point, your data has gone from the long list of single tweet ids to a robust, multi-dimension dataset in .csv format.  

{% include figure.html filename="blurred-dataset.png" caption="The hydrated dataset, blurred here for privacy reasons." %}

## Outputs and How to Use Them

Each tweet now has a ton of useful metadata, including the time created, the included hashtags, number of retweets and favorites, some basic sentiment analysis, and some geo info.  One can imagine how this information can be used for a wide variety of explorations, including to map discourse around an issue on social media, explore the relationship between sentiment and virality, or even text analysis of language of the tweets.

All of these processes will probably include some light data work to format this dataset into one legible for your platform of choice (R, Python, Arc/QGIS, Gephi/Cytoscape/Palladio are some popular ones, many of which are covered in other Programming Historian lessons), but regardless of where you go from here, you have a pretty robust dataset that can be used for a variety of academic pursuits.

{% include figure.html filename="trump-tweets-viz.png" caption="With a very similar dataset (this had more granular sentiment information, I was able to quickly (15 minutes) make a data sketch of the relationship between the sentiment of Trump’s tweets and their popularity.  The outsized bubble in the top right is the "short and fat" tweet aimed at Kim Jong-Un. %}

You might have noticed we didn't get any geocoded tweets, but we did get a "place" column with less exact, textualized location information.  While this might be harder and less accurate to map, it can still be interesting when taken with a grain of salt.  Non-coordinate location data needs to be geocoded, which different programs do to greater or lesser success.  Tableau, for instance, has a hard time interpolating a set of locations if it's not at a consistent geographical level (city, state, etc.).  Google's Fusion Tables are excellent at geocoding regardless of geographical hierarchy, but are being shuttered at the end of 2019.  There are geo-encoding APIs for Python ([geoPY](https://pypi.org/project/geopy/), for instance) and other languages that are also pretty good at this type of work, but they do require more technical sophistication.  *Programming Historian* has a good intro to some of these techniques [here](https://programminghistorian.org/en/lessons/mapping-with-python-leaflet).

{% include figure.html filename="fusion-map.png" caption="A quick sketch of the "place" data in Fusion Tables.  The tweets are taken from the just a few days surrounding each of the storms.  One could perhaps argue that these maps show discourse around these storms forming equally in unaffected metro areas as places in the storms' paths." %}

{% include figure.html filename="zoom-map.png" caption="US map for detail." %}

We do, however, have a bunch of additional files that also have some interesting information.  While the tweet ids file focuses on specific tweets, the nodes, edges, mentions, and users files give information on how these tweets fit together, and all these files can be correlated to create another robust, linked dataset.

If you are unfamiliar with social network analysis, it might be worthwhile to check out one of Scott Weingart’s articles on SNA to familiarize yourself with the basic linguistic and visual vocabularies.  If you have done so, you will recognize that the TweetSets outputs show us some basic information that can be used to reconstruct a social network.  The edges file shows us who is tweeting to whom; the nodes files associates user names with id numbers; and the top mentions and users files do the same, but for the most actively mentioned and most actively tweeting users.  

## One Simple (Software Agnostic) Way to Link your Data

At this point, I’m going to cover a very useful data technique that can be used in a wide variety of spreadsheet platforms (Excel, Google Sheets, Numbers), for a wide variety of tasks.  I have used it in myriad roles: as a banker, an academic, an administrator, and for personal use.  It is called VLOOKUP, which stands for “vertical look up,” and in essence, it makes Excel or other spreadsheet programs function relationally, linking data on unique identifiers.  This is not to say that Excel can now be your new SQL, but in limited cases when you need to connect two discrete spreadsheets, it’s an invaluable and easy trick.  We’re going to use it to flush out our TweetSets outputs so the data can be used to create a robust and informative social network graph.  

When we look at the edges file, we can see it is a series of observations, each consisting of two numbers.  These are the ID numbers of Twitter users in this data set: the left column represents the “tweeter,” and the right the “mention.”  In standard SNA parlance, these would translate to the "source" and "target."  At this point, it’s hard to glean much meaningful information from this data, though, as all we have are numbers.  VLOOKUP will help with that. 

{% include figure.html filename="preprocess-edges.png" caption="The edges file, preprocessing." %}

When we open the file (I’ve done it in Excel, but the process is essentially identical in Numbers, Google Sheets, or other spreadsheet programs), we see that some of the longer user IDs have defaulted to scientific notation.  We can fix this easily by selecting all the data, going to the format section of the home tab, and selecting “Number.”  You might also see that some especially long IDs display as a series of #s.  You can also fix this easily by widening the cell, which will allow the full number to display.  Finally, the “Decrease Decimal” button, just under the “Number” dropdown, is useful for rendering IDs as whole numbers if they’ve defaulted as decimals.  You might run into some of these issues with the other files we've downloaded, so keep these solutions in mind.

{% include figure.html filename="format-as-numbers.png" caption="Format the figures as numbers to eliminate scientific notation." %}

{% include figure.html filename="decrease-decimal.png" caption="Use "Decrease Decimal" to format the IDs as whole numbers." %}

{% include figure.html filename="widen-columns.png" caption="Widening the columns will fix the issue of IDs displaying as series of #s." %}

At this point, we just need to do some quick formatting work to prepare the sheet for the VLOOKUP.  Add a row at the top of the spreadsheet, and also between the two numbers columns so we can add some labels (useful but not necessary), and space for our additional data to populate.  I’ve named the columns “source,” “source name,” “target,” and “target name,” loosely following SNA conventions.  You’ll also want to open the “Top Users” and “Top Mentions” spreadsheets at this time.

{% include figure.html filename="format-for-vlookup.png" caption="Add a row at the top and a column in the middle, and insert the column names above.  This will create target cells for the VLOOKUP outputs, and help us keep track of our data." %}

Now that everything is formatted, click in the cell to the right of the column on which you want to perform the VLOOKUP.  I'm going to start the process with the target column because the people appearing in this column are mostly public figures, enabling me to show you my return values without worrying about privacy issues.  You can start with this column or the source column: you'll perform the process on both. 

Once that's done, we'll need to search for the VLOOKUP formula.  You can also type this out "freehand", but looking it up will give you access to the Excel (or Sheets or Numbers) formula builder, which makes this task much easier.  To do this, go to the "Formulas" tab, click "Insert Function," and search for "VLOOKUP".  

{% include figure.html filename="vlookup-search.png" caption="Search for VLOOKUP on the "Formulas" tab." %}

Once you click on it, you should see a handy formula builder dialog box on the right.

{% include figure.html filename="vlookup-formula-builder.png" caption="The VLOOKUP formula builder provides fields for input values." %}

 Click in the "Lookup_value" field in the formula builder, then click on the letter at the top of the column of associated ID numbers.  Essentially, this input is telling the software the unique ID it will use to link data in two separate spreadsheets.  In my case that is column C, so I click on the letter "C" at the top of the column, selecting it in its entirety.  You will see the software automatically enters the value "C:C" into the formula builder upon click. 

{% include figure.html filename="lookup-value.png" caption="The lookup value is the unique ID you want to match.  In this case, it’s the target ID column.  You can click on the letter at the top of the column to select it in its entirety." %}

From here, we'll move our cursor down to the next dialog box, "Table_array".  This refers to the field of values in the second spreadsheet we want the software to reference when linking our data.  Once your cursor is in the dialog box, move over to the second spreadsheet--"top-mentions" for the target column, "top-users" for the source--and click and drag to highlight the entire table.  For larger datasets, all you need to highlight is the field spanning from the unique ID to the desired return value, but with our smaller dataset, that means the entire spreadsheet.  When you click back to the "mention-edges" sheet, you'll see some complex syntax has populated.

{% include figure.html filename="table-array.png" caption="Highlight all the values in the second spreadsheet." %}

The final two inputs are easy, but I'll take a moment to explain what they mean.  "Col_index_num" tells the software what value you want it to return.  We want the target name, which is in the third column of our table array, so we put the number "3".  You'll need to adjust this as necessary with different datasets.  The "range_lookup" field tells the software whether the match for the lookup value needs to be exact.  "FALSE" tells it that it does.

{% include figure.html filename="last-values.png" caption="All inputs completed.  The "Result" at the bottom near the "Done" button will give you some idea if your inputs were correct.  If it looks alright, you can go ahead and click  "Done". %}

When you click "Done", you will see the first value populate in the cell.  Note that the formula is still displayed in the formula box at the top, not the returned value.  We’ll remedy this in a moment.  For now, you’ll want to hover over the black box in the lower right hand corner of this cell.  Your cursor should change to a black plus sign when you do.  From there, click and drag the cell all the way down the column.  When you get to the bottom of the sheet, you can release the mouse button, and you should see values populate for all the rows.  This may take a while with larger datasets, but it’s pretty quick with this one.

{% include figure.html filename="first-return-value.png" caption="If you've done everythign correctly, you'll see a return value in the cell you clicked on earlier, and the formula in the "f"<sub>"x"</sub> field". %}

{% include figure.html filename="all-values-populated.png" caption="With just a few steps, we now know the real world people associated with each user ID." %}

You might, however, notice that instead of the usernames we’re interested in, each cell contains the formula we used to retrieve them.  This can be an issue if the spreadsheet program ever loses track of the second spreadsheet: if it can’t find it, it won’t be able to return the value in the future.  To remedy this, we’re going to paste the returned values into the cells rather than the formula.  At this point you should already have the column highlighted, so you can press command + C (ctrl + C on Windows) to copy the column, then right click and select “Paste Special.” 

{% include figure.html filename="paste-special.png" caption="Copy->Paste Special will allow us to tell the software to insert the actual return values, rather than the formula, into the spreadsheet." %}

{% include figure.html filename="special-paste-values.png" caption="Choose "Values" in the "Paste Special" menu." %}

Once you've done this, you can see the returned value is now in the formula field at the top, rather than the formula.  This will prevent the CSV from “breaking” in the future.  Though retaining the formula would, in theory, allow the spreadsheet to auto-update in the future, it’s probably easier to just rerun the VLOOKUP, rather than having to make sure the main spreadsheet always knows where the reference spreadsheets are located.

{% include figure.html filename="vlookup-final.png" caption="Done with data formatting!" %}

## Further Applications
After repeating this process on the second column, this spreadsheet is ready to be used in a variety of social network visualizations.  It will drop right in to something like Palladio, or, with some light reformatting, into programs like Gephi or Cytoscape.  The VLOOKUP we did makes it so you can do the visualizations with human-legible user names, rather than rather meaningless user IDs.

{% include figure.html filename="palladio.png" caption="A very quick social network sketch showing the users who most often mentioned @realDonaldTrump in their hurricane tweets.  Done in Palladio." %}

## Conclusion
