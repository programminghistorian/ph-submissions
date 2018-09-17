---
title: |
    Using Application Programming Interface (API) (almost) without coding: Kick start with Europeana APIs with PHP

authors:
- Go Sugimoto
date: 2018-09-17
reviewers:
layout: lesson
---

# Scope
**Application Programming Interfaces (APIs)** are frequently used as a means of Open Data. Indeed, over the last years, many humanities researchers have started to share their data on the web with APIs. As a result, there are a large amount of valuable datasets available. However, APIs are often tailored for developers, and it is still not easy for the researchers who have little IT experience to work on them.

This tutorial offers the participants the possibility to **quickly learn the technology without prior knowledge of programming to start using a vast amount of data (often freely) available on the web**. In particular, it uses **Europeana API** to examine millions of cultural heritage objects from museums, libraries, and archives across Europe. Once you learn the principles, it is just a matter of time to try other APIs and take advantage of data useful for your (research) purposes. The world of Big Data is waiting for you!

# Contents and expected outcomes
The tutorial consists of two parts. The first part provides the basic theory of APIs including:
- What are APIs?
- Why are they important?
- List of useful APIs

A practical hands-on starts in the second part with:
- Europeana API registration to get an API key
- Viewing Europeana API data on a web browser
- Installing XAMPP
- Using a local web server and creating a web page with PHP and HTML
- Developing a web page for Europeana API with PHP and HTML
- Using an API template to access Harvard Art Museum API
 
After the tutorial, the participants will be able to understand the basics of APIs and use them with PHP (and HTML) on a local server on their local machines. [PHP](http://php.net/) is a programming language especially suited for web development, while [HTML](https://en.wikipedia.org/wiki/HTML) is a markup language to create webpages and applications. The participants will learn to **build their own web page** which displays API data.

Basic technology to learn:
- HTML
- PHP
- JSON

Basic concepts to learn:
- APIs
- Metadata
- Web server

# Software requirements
- Web browser (Firefox, Internet Explorer, Chrome, Safari etc)
- [XAMPP](https://www.apachefriends.org)
- Text editor ([Atom](https://atom.io/) etc)

XAMPP creates a local web environment. It is free and includes two important packages for this tutorial: Apache web server and PHP. In this way, you can create a test website and simulate an access to APIs on your PC. 

We need a text editor for a simple programming. You can use pre-installed editors such as Notepad (Windows), but I suggest to use a free software, [Atom](https://atom.io/)(Mac, Windows,  Linux) which has more useful features. If you get into programming in the near future, it is a good option.

# What is Application Programming Interfaces (APIs)?
## Internet story so far
To explain APIs, let’s briefly go back to the time when the World Wide Web (WWW) was born in the 1990’s. It is the core service of the Internet. The WWW was initially designed for **human-to-machine(computer)** communication. We, humans, created websites on our computers, and other humans see them on their computers (with web browsers). At that time, they were mostly **static web pages**, because they are documents and the contents are fixed by webmasters. We were just happy to passively view somebody’s web pages with texts (interconnected with hyperlinks) and photos with a **Graphical User Interface (GUI)**. The interaction was mostly between humans and machines, or we could say that machines “coordinated” the human communications.

Then, we got excited and ambitious about the Internet technology. We started to create **dynamic web pages** where human users can interact with each other. Web pages are dynamic, because the contents are not fixed, and dynamically changed by the actions of the users. For example, when we search web contents, send emails, and submit and share documents and photos, the contents of the web pages change. Social media are typical examples. We not only consume web contents, but also generate them. To manage such **web resources**, we needed **database** systems behind websites, so that we can store and manage data properly and efficiently. Data include web resources as well as user information. If a dynamic website works like a software application (which we use often on local machine), we may call it **web application**. Due to the possibility to submit resources and the creation of large databases, a huge amount of data have been created. Millions and billions of websites and datasets you have seen these days.

At this stage, we realise we need more **machine-to-machine communication**. As we have big data sometimes far more than humans can actually browse and work on, we need a method for machines to smoothly communicate each other, which is called **web service**. APIs are typical web services.

Let’s think about a real situation. You maintain a ski website and want to update weather forecast for your ski fields every half an hour. You receive the forecast from a meteorological website which contains weather data. Instead of checking such a website on your own and update data manually, it is easier to build a website which can automatically fetch the weather data and display them in a regular interval. In other words, a website communicates with another website. This **machine-to-machine data exchange and automation** is possible, when we use APIs. You can regard the APIs of the meteorological website as a kind of (database) service. 

But, can’t that be done by embedding a snippet of a website, like we insert a YouTube video on Facebook? That’s right, but APIs normally offer standardised raw data and access methods, meaning it is easier to manipulate and customise the data. For instance, what if you need to convert Fahrenheit to Celsius, or show a line chart instead of a bar chart? With embedding, you cannot change how the data are presented. In addition, the separation of data and design is also a great benefit for web developers.

A little funny thing is that a website can offer **both dynamic web pages and APIs**. For instance, while a human user visits a Wikipedia website to read a nice pre-designed article, Wikipedia also offers APIs for another user to let her/him develop a mobile quiz app, which uses Wikipedia’s machine-readable raw data. Of course, **delivering APIs are voluntary**, so there are many websites without APIs. But, the number of APIs is growing considerably. 

## Why are APIs useful for you?
Apart from technical advantages of APIs described above, what are the benefit for an ordinary research user like you?

Good question. So I try to summarise some of the reasons. If you conduct a research, you may prefer to have:

- More data
- Related data
- Interlinking data
- Remote data
- Up-to-date data
- Different types of data (interdisciplinary study)
- Data with better quality
- Data not obtainable (by yourself)
- Data with low price, or gratis

This list is not exhaustive. You can think of more reasons. In general, taking advantage of the power of the Internet, sharing data and reusing data is trendy. “Open Data” and “data-driven research” have been under the spotlight of academia and industries for the last several years. APIs are one of the growing areas of their movement. By accessing a wide range of a large amount of datasets, we can do much more than we could do before, which, as a consequence, leads to enormous change in our research practice, and hopefully more new discoveries and innovations.

## API data for everybody
Most of the time, normal (dynamic) websites are sufficient for us, but there are some cases you may need more and some other reasons why I promote APIs.

To be honest, sometimes the author is not very happy with the current practice of Open Data. There is a strong tendency that normal websites are prepared for ordinary users and APIs are for developers. I think this is not very FAIR.

It is understandable that machine-to-machine communication should be developed by developers who have skills. Surely, you need some technical skills to use APIs and it is a big hurdle for normal users. However, **the vast majority of the consumers of the data APIs provide is the normal users** who often do not have any programming skills. In addition, APIs and websites often do not offer the same service and/or data. For example, we can not easily mix the data from different websites in a customised/personalised way. This is proven in my [James Cook Dynamic Journal (JCDJ) project](https://jcdj.acdh-dev.oeaw.ac.at/about.php).

In author’s opinion, APIs should be for everybody. **Anybody should be able to use them as they use word processing or spreadsheet software**. He supports universal design for APIs and Open Data, and this is exactly why he would like to provide this tutorial. Corresponding to (or extending) the movement of the [FAIR (Findable, Accessible, Interoperable, Reusable) data principles](https://www.go-fair.org/fair-principles/), the tutorial also attempts to promote **data reuse by non-techie researchers**. If you are interested in this subject of APIs and universal design (called **Easy Data**), you can learn more about it in [my academic article](http://www.inderscience.com/info/inarticle.php?artid=93644).

## Useful APIs
Here is a short list of APIs that would increase the potential of your research. After this tutorial, you may want to try a few of them to continue your experiment with APIs. Then, you will understand how lucky we are to have such a wealth of data freely available.

- [The New York Times](http://developer.nytimes.com/) (Famous newspaper)
- [The Digital Public Library of America](https://pro.dp.la/developers/api-codex) (Database of cultural heritage resources aggregated from US organisations)
- [Archives Portal Europe](https://www.archivesportaleurope.net/information-api) (Finding Aids aggregation of European archives)
- [VIAF](https://www.oclc.org/developer/develop/web-services/viaf.en.html) (Database of persons and organisations aggregated from libraries around the world)
- [GeoNames](http://www.geonames.org/export/web-services.html) (Geographical information)
- [Wikipedia](https://www.mediawiki.org/wiki/API:Main_page) (World-famous encyclopedia)
- [The Open Library](https://openlibrary.org/developers/api) (Freely available digital library in conjunction with Internet Archive)
- [List of useful APIs for museums](http://museum-api.pbworks.com/w/page/21933420/Museum%C2%A0APIs)

That was the quick theory on APIs. Now, let’s get our hands dirty with real exercises!
