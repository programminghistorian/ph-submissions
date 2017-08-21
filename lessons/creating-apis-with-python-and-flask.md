---
title: |
    Creating Web APIs with Python and Flask 
authors:
- Patrick Smyth
date: 2017-08-01
reviewers:
layout: lesson
---

# Lesson Goals

Web APIs are tools for making information and application functionality accessible over the internet. In this lesson, you will learn what an API is and when you should use one. You will also learn how to set up a web API that returns data to its users, specifically a HTTP API returning JSON using Flask, a web framework written in Python. Finally, you will learn some principles of good API design by stepping through a working example.

# Prerequisites

The only prerequisite for this lesson is the ability to use a text editor, such as TextWrangler on OSX or Notepad++ on Windows. However, knowledge of the command line, Python, and web concepts such as HTTP may make this tutorial easier to follow.

# Introducing APIs

## What is an API?

The term API, short for Application Programming Interface, refers to a part of a computer program designed to be used or manipulated by another program, as opposed to an interface designed to be used or manipulated by a human. Computer programs frequently need to communicate amongst themselves or with the underlying operating system, and APIs are one way they do it.

However, if you've heard the term API before, chances are it's been used not to refer to APIs in general, but instead to a specific kind of API, the web API. Web APIs are often called HTTP or REST APIs, terms which have specific technical meanings but which generally refer to the same concept. A web API allows for information or functionality to be manipulated by other programs via the internet. For example, with Twitter's web API, you can write a program in a language like Python or Javascript that can perform tasks such as favoriting tweets or collecting tweet metadata.

## Using APIs

This lesson will show you how to create an API, not how to explore or use an API that has already been implemented. However, before we start, it may be useful to briefly think about APIs from the perspective of a potential user.

Typically, users of web APIs wish to be able to do one of two things: collect data or take advantage of a service. In general, API users have a specific concern that your API will address, and so good documentation with working examples that allow others to use your API quickly are the *sine qua non* of a good API. Just as strong readers often make strong writers, using APIs created by others and critically evaluating their design and documentation will help you design a good API.

## When to Create an API

If you have data you wish to share with the world, an API is one way you can get it into the hands of others. However, APIs are not always the best way of sharing data with users. If the size of the data you are providing is relatively small, you can instead provide a "data dump" in the form of a downloadable JSON, XML, CSV, or SQLite file. Depending on your resources, this approach can be viable up to a download size of a few gigabytes. 

An alternative to FTP (file transfer protocol, or "regular" downloads) is the distributed torrent protocol, which can be viable for large files if users are willing to continue to "seed." or upload portions of a file after downloading. Torrenting has its own disadvantages, such as that torrent traffic is blocked or monitored on many campus, library, and workplace networks.

In general, consider an API if:

1. Your data set is large, making download via FTP unwieldy or resource-intensive.
2. Your users will need to access your data in real time, such as for display on another website or as part of an application.
3. Your users will need to perform actions other than retrieve data, such as contributing or deleting data or performing other actions.

Remember that you can provide both a data dump and an API, and individual users may find one or the other to better match their use case. [Open Library](https://openlibrary.org/), for example, provides both [a data dump](https://openlibrary.org/developers/dumps) and [an API](https://openlibrary.org/developers/api), each of which serves different use cases for different users.

## API Terminology

When using or building APIs, you will encounter these terms frequently:

- **HTTP (Hypertext Transfer Protocol)** is the primary means of communicating data on the web. HTTP implements a number of "methods," which tell which direction data is moving and what should happen to it. The two most common are GET, which pulls data from a server, and POST, which pushes new data to a server.
- **JSON (JavaScript Object Notation)** is a text-based data storage format that is designed to be easy to read for both humans and machines. JSON is generally the most common format for returning data through an API, XML being the second most common.
- **REST (REpresentational State Transfer)** is a philosophy that describes some best practices for implementing APIs. APIs designed with some or all of these principles in mind are called REST APIs. While the API outlined in this lesson uses some REST principles, there is a great deal of disagreement around this term. For this reason, I do not describe the example APIs here as REST APIs, but instead as web or HTTP APIs.

# Implementing Our API

## Overview

This section will show you how to build a prototype API using Python and the Flask web framework. We'll first walk through creating a basic "Hello, world!" application in Flask. Once we have that working, we'll discuss some fundamental concepts of working with Flask before building out our "Hello, world!" application into a working web API.

A less discursive set of step-by-step instructions, including code examples, can be found in [this GitHub repository](https://github.com/smythp/apis-python-flask-tutorial).

## Installing Python and Flask

For this tutorial, you will need Python 3. Follow [this link](https://www.python.org/downloads/) to download Python and then run the installer—the default settings should be fine.

To confirm that Python installed successfully, first open the command line. In OSX, click the finder on the top left of your desktop (the magnifying glass) and type `terminal`. The terminal should be the first application that appears. On Windows, click the Start menu icon and type `cmd` in the search box, then press `Enter`.

Once your command line is open, enter these commands:

	python --version
	pip --version
	
If the output for these commands includes a version number, Python is installed and available from the command line and you can proceed to the next step.

Next, you'll need to install Flask. At the command line, type

	pip install flask
	
This will install Flask using the pip package manager for Python. You should see some output ending in a notification that Flask has been installed successfully.

As an alternative to the above installation instructions, you can install the Python 3 version of Anaconda, which can be downloaded [here](https://www.continuum.io/downloads). Anaconda comes with Flask, so if you go this route you will not need to install Flask using the pip package manager.

If you're running into trouble installing Python, you may find [this Programming Historian article on installing Python](https://programminghistorian.org/lessons/introduction-and-installation) helpful.

## Creating a Basic Flask Application

[Flask](http://flask.pocoo.org/) is a web framework for Python, meaning that It provides functionality for building web applications, including managing HTTP requests and rendering templates. In this section, we will create a basic Flask application. In later sections, we'll add to this application to create our API. Don't worry if you don't understand the code yet—explanations will be forthcoming once you have this "Hello, world!" application running. We'll go into more detail on what Flask does later in the tutorial.

First, create a new folder on your computer that will serve as a project folder. This can be in your `Desktop` folder, but I recommend creating a dedicated `projects` folder for this and similar projects. This tutorial will assume that your project folder is called `api` inside a projects folder in your home directory.

Next, open a text editor (such as Notepad++ or TextWrangler) and enter the following code:

```python
import flask

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/', methods=['GET'])
def hello():
    return "Hello, world!"

app.run()
```

Save this code as `api.py` in the folder you created for this project.

## Running the Application

In the command line, navigate to your project folder. Example commands are below, but the specific commands may vary depending on where you created your projects folder. If you need help with navigation on the command line, see the [Programming Historian Introduction to the Bash Command Line](http://programminghistorian.org/lessons/intro-to-bash).

	cd projects
	cd api

If you're having trouble navigating to your `projects` folder, consider moving your `api.py` file to your desktop and navigating to it with `cd Desktop`, assuming your currently in your home directory.

Once you're in your project directory, run the Flask application with the command:

	python api.py
	
You should see output similar to this:

	 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)

You may also see some lines related to debugging. This message means that Flask is running your application locally (on your computer) at that address. Follow the link above, [http://127.0.0.1:5000/](http://127.0.0.1:5000/), using your web browser to see the running application. You should see the text

	Hello, world!
	
in the browser.	Congratulations, you've created a working web application!

## What Flask Does

Now that your "Hello, world!" application is running, let's talk about how Flask works and what the above code is doing.

Flask maps HTTP requests to Python functions. In this case, we've mapped one URL path ('`/`') to one function, `hello`. When we connect to the Flask server at [http://127.0.0.1:5000/](http://127.0.0.1:5000/), Flask checks if there is a match between the path provided and a defined function. Since `/`, or no additional provided path, has been mapped to the `hello` function, Flask runs the code in the function and displays the returned result, `Hello, world!` in the browser.

The process of mapping URLs to functions is called **routing**. The

	@app.route('/', methods=['GET'])
	
syntax is the part of the program that lets Flask know that this function, `hello`, should be mapped to the path `/`. The `methods` list lets Flask know what kind of HTTP requests are allowed. We'll only be using `GET` requests in this tutorial, but many web applications need to use both `GET` and `POST` requests.

The above is the part you'll need to understand as you work on your API. Below, however, are short explanations of the rest of the application.

`import flask` — Imports the Flask library, making the code available to the rest of the application.

`app = flask.Flask(__name__)` — Creates the Flask application object, which contains data about the application and also methods (object functions) that tell the application to do certain actions. The last line, `app.run()`, is one such method.

`app.config["DEBUG"] = True` — Starts the debugger. With this line, if your code is malformed, you'll see an error when you visit your app. Otherwise you'll only see a generic message such as `Bad Gateway` in the browser when there's a problem with your code.

`app.run()` — A method that runs the application.

While it's useful to have a familiarity with what's going on in the script, don't worry if you don't understand precisely what every element is doing at this stage.

## Creating the API

Now that we have a running Flask application and know a little about what Flask does, we're finally ready to implement a small API with data that we'll define right in our application. Typically, data would actually be pulled into the application from an external source such as a text file or database, but for now we'll input test data directly using a list of Python dictionaries. Let's add a new function before the last line which runs our application. As before, we'll step through the code once we have it running.

```python
import flask
from flask import request, jsonify

app = flask.Flask(__name__)


@app.route('/', methods=['GET'])
def hello():
    return "Hello, world!"


@app.route('/api/v1', methods=['GET'])
def api_root():

    # Create a "dummy" list of dictionaries that will serve as our data.
    # Most applications would pull in data from a file or database instead.
    books = [
        {'id': 0,
         'name': 'The Once and Future King',
         'Author': 'E. B. White'},
        {'id': 1,
         'name': 'Mansfield Park',
         'author': 'Jane Austen'},
        {'id': 2,
         'name': 'Flask Web Development',
         'author': 'Miguel Grinberg'},
    ]

    # Check if an ID was provided. If ID is provided, assign it to a variable.
    # If no ID is provided, display an error in the browser.
    if 'id' in request.args:
        id = int(request.args['id'])
    else:
        return "Error: No id field provided. Please specify an id."

    # Create an empty list for our results
    results = []

    # Loop through the data and match results that fit the requested ID.
    # IDs are unique, but other fields, such as genre, might return many results
    for book in books:
        if book['id'] == id:
            results.append(book)

    # Use the jsonify function from Flask to convert our list of
    # Python dictionaries to the JSON format.
    return jsonify(results)


app.run()
```

Your full script should now look like [this](https://github.com/smythp/apis-python-flask-tutorial/blob/master/api.py).

Run the code (navigate to the project folder in the command line and enter `python api.py`) and follow these URLs in the browser:

[http://127.0.0.1:5000/api/v1?id=0](http://127.0.0.1:5000/api/v1?id=0)  
[http://127.0.0.1:5000/api/v1?id=1](http://127.0.0.1:5000/api/v1?id=1)  
[http://127.0.0.1:5000/api/v1?id=2](http://127.0.0.1:5000/api/v1?id=2)  
[http://127.0.0.1:5000/api/v1?id=3](http://127.0.0.1:5000/api/v1?id=3)  

Each of these should return a different entry, except for the last, which should return an empty list: `[]`, since there is no book for which the id value is 3. (Counting in programming typically starts from 0, so id=3 would be a request for a nonexistent fourth item.)

## Understanding Our API

In this code, we first create a new function, called `api_root`, with the `@app.route` syntax that maps the function to the path `'/api/v1'`. That means that this function will run when we access [http://127.0.0.1:5000/api/v1](http://127.0.0.1:5000/api/v1).

Inside our function, we do three things:

1. Define a small collection of books as a list of Python dictionaries. Each dictionary has the fields `id`, `author`, and `title`.
2. Examine the provided URL for an id and select the books that match that id. The id must be provided like this: `?id=0`. Data passed through URLs like this (after the `?`)are called **query parameters** and are a feature of HTTP used for filtering for specific kinds of data.
3. Transform matching items from a Python dictionary to JSON and return the JSON object for display in the browser.

If you've gotten this far, you've created a working API. Celebrate! At the end of this lesson, you'll be exposed to a somewhat more complex API that uses a database, but but most of the principles and patterns we've used so far will still apply. In the next section, we'll discuss some guidelines for creating a well-designed API that others will actually want to use.

# API Design Principles

Before building more functionality into our application, let's consider a few API design principles that make it easier for others to work with and reason about your API.

## Designing Requests

The prevailing design philosophy of modern APIs is called REST. For our purposes, the most important thing about REST is that it's based on the four methods defined by the HTTP protocol: POST, GET, PUT, and DELETE. These correspond to the four traditional actions performed on data in a database: CREATE, READ, UPDATE, and DELETE. In this tutorial, we'll only be concerned with GET requests, which corresspond to reading from a database.

Because HTTP requests are so integral to using a REST API, many design principles revolve around how requests should be formatted. A good request might look like this:

	https://api.example.com/v1/resources/books?id=10&output=json
	
This request uses the API subdomain to distinguish the API from the rest of the website. It includes a version number, which allows you to update your API without breaking scripts or apps that others have written using older versions of your API. It uses plural names for field identifiers, such as `resources` and `books`. It also uses HTTPS, the encrypted version of the HTTP protocol, which is more secure. Finally, if you allow users to receive data in multiple formats, such as XML and JSON, then you can allow users to specify the format in the request as a query parameter.

A poor request format might look like this:

	http://api.example.com/getbook/10
	
Typically, verbs are never used when designing API requests—your verbs are the HTTP methods POST, GET, PUT, and DELETE and your collections of resources (such as `books` or `users`) are plural nouns. Using paths without query parameters (the part of the request after the `?`) is common in API design, but query parameters are more flexible and allow users to filter using multiple fields, so use hard paths like the above judiciously.

## Documentation and Examples

Without documentation, even the best-designed API will be unusable. Your API should have documentation describing the resources or functionality available through your API that also provides concrete working examples of request URLs or code for your API. You should have a section for each resource that describes which fields, such as `id` or `title`, it accepts. Each section should have an example in the form of a sample HTTP request or block of code.

For inspiration on how to approach API documentation, see the [New York Public Library Digital Collections API](http://api.repo.nypl.org/) which sets a standard of documentation achievable for many academic projects. For an extensively documented (though sometimes overwhelming) API, see the [MediaWiki Action API](https://www.mediawiki.org/wiki/API:Main_page), which provides documentation to users who pass partial queries to the API. (In our example above, we returned an error on a partial query.) For a professionally maintained API documentation example, see [Stormpath](https://docs.stormpath.com/rest/product-guide/latest/reference.html).

# A Final Example

This last example of an API in Flask pulls in data from a database, implements error handling, and can filter books by an additional parameter, genre. The database used is SQLite, a lightweight database engine that is supported in Python by default.

To run the final example, first [download the example database from this location](https://github.com/smythp/apis-python-flask-tutorial/raw/master/books.db) and copy the file to your projects folder. Copy the following Python code into your text editor:


```python
import flask
from flask import request, jsonify
import sqlite3

app = flask.Flask(__name__)

# Later in our code, this function will allow us to return data
# from our database as Python dictionaries, rather than lists.
# When converted to JSON, the dictionary format is generally better for users.
def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

# At the base URL (/) you would normally have a site with
# info about the project or collection
@app.route('/', methods=['GET'])
def homepage():
    return "An example book catalog API."

# This page is rendered if a resource isn't found
# 404 means "Page not found". 200 means "OK" or "Page found"
@app.errorhandler(404)
def page_not_found(e):
    return "<h1>404</h1><p>The resource could not be found.</p>", 404


# Our new API route leaves room in the URL for resources that might
# be added later. It provides a default values of None for ID and genre
# if they aren't provided by the user of the API.
@app.route('/api/v1/resources/books', methods=['GET'])
def api(id=None, genre=None):

    # Get query parameters provided by the user as part of the URL.
    query_parameters = request.args
    id = query_parameters.get('id')
    genre = query_parameters.get('genre')

    # Begin preparing the SQL query that will pull data from the database
    query = 'SELECT * FROM books WHERE '

    # Add ID and genre to the query if they were present in the URL.
    # Return an error if neither ID nor genre are provided.
    if id and genre:
        query += 'id=? and genre=?;'
        to_filter = (id, genre,)
    elif id:
        query += 'id=?;'
        to_filter = (id,)
    elif genre:
        query += 'genre=?;'
        to_filter = (genre,)
    else:
        return page_not_found(404)
    
    # Connect to the database and use our query to grab data as a dictionary
    conn = sqlite3.connect('books.db')
    conn.row_factory = dict_factory
    cur = conn.cursor()
    results = cur.execute(query, to_filter).fetchall()

    # Convert our data to JSON and return to the user
    return jsonify(results)


app.run()
```

Save this code as `api_refactored.py` and run it by navigating to your project folder in the terminal and entering the command:

	python api_refactored.py

Once this example is running, query the API with these HTTP requests:

[http://127.0.0.1:5000/api/v1/resources/books?genre=Science+Fiction](http://127.0.0.1:5000/api/v1/resources/books?genre=Science+Fiction)  
[http://127.0.0.1:5000/api/v1/resources/books?genre=Programming](http://127.0.0.1:5000/api/v1/resources/books?genre=Programming)  
[http://127.0.0.1:5000/api/v1/resources/books?id=4&genre=Programming](http://127.0.0.1:5000/api/v1/resources/books?id=4&genre=Programming)

The first URI returns all books in the genre "Science Fiction"—in this case, only *Dhalgren*. The second URI returns all books in the programming genre—two results. The third returns the book in the Programming genre that has an id of 4, which is Grace Hopper's *Understanding Computers*. As you can see, this new API allows for filtering by multiple fields, ID and genre.

Now that you've completed this tutorial, you should be able to create web APIs that can serve data to users. You may also find that you have a new perspective on web APIs written by others. Finally, APIs can be a first step toward creating more sophisticated web applications—often, once you've created an API for a set of data, transforming that API into a site or visualization  becomes much easier.


