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

We need a text editor for a simple programming. You can use pre-installed editors such as Notepad (Windows), but I suggest to use a free software, [Atom](https://atom.io/) (Mac, Windows,  Linux) which has more useful features. If you get into programming in the near future, it is a good option.

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

# Europeana API
The first API we will try is [Europeana](https://www.europeana.eu/). It is one of the biggest sources of information for cultural heritage in Europe. It collects data from museums, archives, libraries etc from all over Europe. Currently, it contains over 50 million objects. There are photos, paintings, books, newspapers, letters, sculptures, coins, specimens, 3D visualisations, and more. If you are humanity specialists, you can imagine what kind of interesting resources there can be. Can’t wait?

The goal of this section is to create a website which displays Europeana API data. To complete the task step by step, we learn how to register yourself with Europeana APIs, to access API data with a web browser, to install XAMPP, to make a simple web page, and to develop another web page to show the API data.

You could read through the documentation of Europeana APIs [here](https://pro.europeana.eu/resources/apis), but please do it later on your own and we now make a shortcut.

## API registration
- Fill your personal information at the [Europeana API website](https://pro.europeana.eu/get-api)
- Click Request Key button
- In your email inbox, you will find an API key

## The first Go with API
Your first view of the API data should be as easy as possible. You can do so with your API key and web browser. So, let’s forget about technological aspect for the time being, and just copy and paste the following URL to the address bar of your web browser. Note that you have to replace YOUR_API_KEY with the actual key you get in your email.

<div class="alert alert-success" role="alert">
**Sample 1**
```
https://www.europeana.eu/api/v2/search.json?wskey=YOUR_API_KEY&query=London
```
</div>

What do you see?
You should see a lot of texts. Congratulations! This is your first data view. You are using Europeana API already.

If you use the latest Firefox, you may see more organised structured data. If you use Internet Explorer or others, you may get a message (below). In this case, save the file and open it in a text editor (such as Notepad or Atom).

API is so easy!
So, let’s have a look at what you type (sample 1). It is just a URL. Exactly the same as what you do when viewing a website. For example, to see Europeana website, you type a URL [https://www.europeana.eu](https://www.europeana.eu). There are some difference, though. You use your API key after `wskey=`, which means your personalised access to this web address. It is followed by `query=London`. You are right. We are querying Europeana database and your search keyword is “London”. Europeana offers different types of APIs, but we use the search API.

Untidy JSON data structure (raw data) in Chrome

Tidy JSON data structure in Firefox

## Understanding API data (JSON)
If your browser does not support a tidy JSON view (the latest Firefox should have a pre-installed JSON viewer), please copy and paste the entire data to an [online JSON viewer](http://jsonviewer.stack.hu/). It allows us to view the data more easily by expanding (+ button) and collapsing (- button) data hierarchy. 

Online JSON viewer

Now, if you look carefully the first lines of the data, you may notice something understandable:

```
{"apikey":"YOUR_API_KEY","success":true,"requestNumber":999,"itemsCount":12,"totalResults":1967341,
```

You read literally: `“apikey”` is your API key. Your API access is `success`ful, and you get `1967431` results. We can ignore what `requestNumber` is, but only the first `12` items (records) are returned (to avoid flood of data). After that, you have actual data (i.e. 12 items). 

In order to organise data, Europeana uses a particular format/structure, called **[JSON (JavaScript Object Notation)](http://json.org/)**. The data are wrapped with curly brackets (which is called **Object**). It always starts with `{` and ends with `}`. Inside, the data are represented with pairs of strings. Each pair has two components separated by a colon (`:`). For instance, `"totalResults":1967341`. We call this format **name-value pair**. Name is `“totalResults”` and `1967341` is data value. The former is a kind of intex to be used to retrieve the latter (data value). If there are more than one pair, name-value pairs are separated by comma (`,`). To sum up, the simplest JSON data look like:
```
{
“name 1”: “value 1”,
“name 2”: “value 2”
}
```
By specifying a name, we are able to make a query to retrieve a corresponding value, which is of our interest. As you can see, JSON is a very simple data format, therefore, it is not only very easy for humans to understand, but also for machines (computers) to process data. For this reason it is used in many APIs. Name-value (aka **key-value**) pairs are often used in many programming to store data, so it is good to remember this structure.

In the Europeana search API , the actual data of users’ interest are stored within `items`. Here, you see slightly different structure. It contains numbers with square brackets with numbers (`[0], [1], [2]...`). Each bracket is an item/record and we have 12 records. The square bracket represents an ordered collection of values, called an **array**. The number starts with 0. It is a bit strange at first, but this is a rule, so take it as it is. The array is one of the data types of JSON (see also PHP data types on page 16). Similar to name-value pairs, we can simply specify a number to retrieve data in the list. Inside each array, we have name-value pairs. Sometimes the name may have a nesting structure, so that arrays can be repeated. In the Europeana API, this part depends on each record. Some records have more data than others, so the data structure and values may not be consistent.

As there can be a long list of names in a record, let me explain some of the names:

It is outside of the scope of this tutorial to explain the data model of **Europeana (Europeana Data Model: EDM)**, but short explanation would be handy, because all records are based on it. It consists of different descriptions (i.e. **metadata**) about cultural heritage items, including:

- **[Dublin Core](http://dublincore.org/documents/dcmi-terms/)** metadata to describe a cultural heritage object (stored in museums, libraries and archives). It includes the description of mostly physical aspects of the object such as title (Mona Lisa), creator (Leonardo da Vinci), size (77 cm × 53 cm), date (1503-1517?) , place (France), owner (Louvre museum), and type (painting). In the Europeana API, it is often specified with prefix dc.

- **Metadata about digital version** of the physical object. It may include URLs where user can view the object (both at the Europeana website and external website), digital formats (jpg), and licensing information ([Creative Commons](https://en.wikipedia.org/wiki/Creative_Commons)).
 
To know more about EDM, you can consult their [documentation](https://pro.europeana.eu/page/edm-documentation). I used to be one of the main contributors of the documentation. :)

<div class="alert alert-info" role="alert">
  **Metadata is power**
  Metadata is data about data. We use it very often, even without noticing it. The most typical example is a library catalogue. When we look for a book, we use the author, title, date of publication, ISBN etc to find it in a bookshelf. Metadata is those descriptions of the book. In the same way, we use metadata to search something (a flight ticket, a website, news, a video clip) on the internet. As our data become bigger and bigger (billions), metadata is extremely important not only to discover and identify data, but also to process and preserve them. In humanities, many metadata models and formats have been proposed and developed in libraries (MARC, FRBR), archives (EAD), and museums (LIDO, CIDOC-CRM). It is a continuous effort of various communities to develop metadata to represent the data/knowledge of their domains. EDM too is a model to capture the essence of data aggregated from those domains.
</div>

Just to view data via APIs, you actually don’t need XAMPP we will see in the next section. You can either do it like above, or use [Europeana Rest API Console](https://pro.europeana.eu/page/europeana-rest-api#console) where you can set parameters (e.g. “London” as search keyword) and check the data without any software installation. 

Searching and viewing Europeana datasets are good, but it is not very convenient, because we can only view raw data and/or the default data view. So, let’s move away from web browser and try to customise the data view by ourselves. That’s a developer’s job! But don’t worry, we make it as easy as possible.

Note that it is a good idea to keep API data view open on a web browser, when developing a web page (from now on in this tutorial too), because you often need to examine the data in this way.

# XAMPP installation
Now, we have to set up a new environment. Please go to XAMPP website, download the software for your OS, and install it. XAMPP package has everything you need, so it should be pretty straightforward to install. The current version is 7.2.7 (July 2018).

Download XAMPP from the website

# XAMPP and the first Go with PHP
When your installation is complete, let’s get started. First, go to start menu and click XAMPP Control Panel. If you do not see a green highlight for Apache Module, please click the buttons to start Apache. Then, we can use them on our local machines.

In Windows 10, start menu has XAMPP Control Panel 

Click Start button for Apache Module, and it is started

Go to http://localhost/dashboard in your browser to see if Apache is working

Optionally go to http://localhost/dashboard/phpinfo.php in your browser to see if PHP is working (i.e. if you see this page)

If you see the screens like above, everything should be OK. Go to htdocs folder we created (shortcut is recommended to be created at the desktop). In this folder, we put all the files necessary to create a website. Right now it’s almost empty, so let’s create a brand new PHP file. Inside the htdocs folder, right click and select create a new text file.
After creating, rename the file to helloworld.php. Alternatively, you can always start your editor and save an empty file with the name, helloworld.php.

Put all the files in htdocs folder (e.g. c:xampp->htdocs)

As you may have heard, it is developer’s tradition to display “Hello World” for the first code. Open the helloworld.php in your text editor, and please write (or copy and paste) the following and save it.

```
Sample 2
<?php
print 'Hello World';
?>
```

Editing helloworld.php with Atom text editor

Open your web browser and type http://localhost/helloworld.php in the address bar. When working on PHP code, it is recommended to keep the browser open with the web page you are editing, so, as soon as you save the file, you can see the outcome immediately. In addition, you could create a bookmark for your convenience.

The outcome? You see “Hello World” in a white background. Congratulations! You have just made the first PHP code. For the sake of curiosity, PHP code should start with <?php and ends with ?>. Just like JSON, those lines declare that the file is PHP. print means display the following code “Hello World” as a text. 
In PHP,  you can use either '' or ”” (single or double quotes) to indicate that data type is string (i.e. text) (There are other data types such as integer, Boolean, or array, but let’s focus on string for now). Very simple. 

## Your first PHP web page in a browser
The first go with HTML
In sample 2, PHP uses 'Hello World' as a normal text. But, PHP can work with HTML very well. They can be embedded each other. HTML is a markup language which creates web pages and applications. So, let’s make a little change to try with HTML. Change 'Hello World' into '<b>Hello World</b>', and save the file. Now, refresh the same page on the browser (click “reload current page” button). What’s happened?

“Hello World” should become in bold. This is because HTML code <b></b> makes the texts, sandwiched by the enclosing tags, bold. HTML basically adds an annotation to the content in-between (<b> means bold).

Be careful that most HTML tags need to have an opening tag (<b>) and a closing tag (</b>). If you mistype or omit them, web browser may not be able to display information properly. HTML takes care of many things of a website, but in this case, it defines the display format on the browser.
HTML images and links
Before moving on to APIs, we would like to do an exercise to create a simple website with some basic HTML and PHP coding. The first exciting stuff is to display an image on a PHP web page. Modify sample 2 as follows and save it. Be aware that the first line has changed slightly, adding <br> at the end. Do you see a nice image? Fantastic!

```
Sample 3
<?php
print '<b>Hello World</b><br>';
print '<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Ramesses_Vi_closeup.jpg/242px-Ramesses_Vi_closeup.jpg">';
?>
```

<br> is a line break, so with sample 3, you should be able to see “Hello World” in bold and an image from the next line. In the next line, we are print text strings for the upcoming code, using single quotes. The content of the texts is <img src=””>, which specifies the URL of an image.

Hello World in bold and an image from Wikipedia

In HTML, (enclosing) tag names are called elements. Within an element, there are also attributes which are additional values that configure the elements or adjust their behavior. Normally attributes appear as name-value pairs, and separated by =.  For example, <img> is an element, and src=”” is an attribute. 

If you put an image on the htdoc folder, you can also specify it like myimage.jpg instead of http://...

Great! Now let’s make a real website. The real power of Internet lies in hyperlinks, so we add a link to Wikipedia. Copy and paste the following code and replace with the entire sample 3. 

```
Sample 4 (Download helloworld.php)
<?php
print '<h1>My website about Ramesses VI </h1>';
print '<p>Ramesses VI image (public domain) is below</p>';
print '<a href="https://en.wikipedia.org/wiki/Ramesses_VI">Go to Wikipedia page of Ramesses VI</a><br>';
print '<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Ramesses_Vi_closeup.jpg/242px-Ramesses_Vi_closeup.jpg">';
?>
```

Now, it really looks like a website, doesn’t it? <h1> is a heading (the biggest size), while <p> is a paragraph (i.e. normal text). <a> is the hyperlink and href= specifies the URL, in this case, a Wikipedia article. As attributes often contain extra information about the element that you don't want to appear in the actual content, the texts ”Go to Wikipedia page of Ramesses VI” is displayed in place of the lengthy string of URL (i.e. ” https://en.wikipedia.org/wiki/Ramesses_VI”).

Was it easy, or difficult? Anyway, what you have just created is the essence of all the websites on the Internet, containing texts, hyperlinks, and media (image). The only difference is a better layout, more decorations, and perhaps interactive functions. But, well done! You have just become a webmaster!

Complete web page with an image and a hyperlink

<div class="alert alert-info" role="alert">
  Web server and XAMPP (Apache and PHP)
  When creating a website, you need a web server. It is a powerful computer in which web contents are stored. They should be switched on 24/7, so they are always available. There are millions of servers worldwide which constitute the Internet.

From a user’s perspective, s/he types a URL in a browser to view a web page. Then, the browser (i.e. client computer) identifies the server of the web page (which exists somewhere in the world) and asks it to access the page. The server responses to the browser and “serves” the web page. This client-server model is the founding stone of the Internet. 

To run a web server on your own, you need to pay and register your web address
(often via a web hosting service), and it is a bit complicated. XAMPP, instead, simulates the environment of a web server in your local machine (Apache), without creating a real website. In fact, you can only view the web page you create in this tutorial via localhost, because it does not exist on the web. It is a good way to test your website. 

PHP is a code to be executed on a web server, generating HTML for the client. It is included in XAMPP, so we don’t need to install separately.
</div>
