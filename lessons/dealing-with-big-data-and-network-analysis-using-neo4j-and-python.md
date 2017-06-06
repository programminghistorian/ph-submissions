---
title: | 
    Dealing with Big Data and Network Analysis Using Neo4j and Python
authors: Jon MacKay
reviewers: R1,R2,R3
date: 2017-06-05
layout: default
---

## Introduction

By the end of this lesson you will be able to construct, analyze and
visualize networks based on big --- or just inconveniently large --- data.
The final section of this lesson contains code and data to illustrate the key points of this lesson..

I strongly recommend you read the introductory part before you try using the example data.
This lesson involves different programming languages and multiple pieces of software.
I have tried to include a bare minimum to allow readers to get up and running as painlessly as possible.
Due to the complexity of these tools, I could only touch on some of the major features available.
Wherever possible I have included links back to more detailed documentation or tutorials.

This tutorial will focus on the following open source tools. These
include the [Neo4j graph database](https://neo4j.com/), the [Cypher
query language](https://neo4j.com/developer/cypher-query-language/) used
by Neo4j and the [Python programming language](http://python.org).

-   [Neo4j](https://neo4j.com/) is a free, open-source graph database
    written in java that is available for all major computing platforms.
-   [Cypher](https://neo4j.com/developer/cypher-query-language/) is the
    query language for the Neo4j database that is designed to insert and
    select information from the database.
-   [Python](http://python.org) is a relatively simple c-style language
    that can be readily used by beginner and advanced programmers alike.
-   This tutorial will also use the point-and-click open source program
    [Gephi](https://gephi.org) to visualize networks.





## What is a database and why use it? {#whyadatabase}

What is the point of using a database? The *Programming Historian*
already has lessons about how to use python to programmatically
manipulate graphs. Aren't we just making dealing with graphs more
complex than it needs to be?

Yes and no. For smaller datasets that result in smaller graphs it
probably makes sense to stick with a single tool. The python language
coupled with the [NetworkX graph manipulation
library](https://networkx.github.io/) are likely sufficient for many
tasks. 

The limitations of this approach begin to show, as the graphs we
want to study get larger. Extremely large graphs can be time consuming
to load, manipulate and to visualize. Things become even slower if we
try to explore the contents of the graph or take simple measures.





### Early Databases

For decades, databases have been the go to solution for data storage and
query bottlenecks. In its simplest form, databases contain tables. A
table is composed of rows and columns not unlike an Excel spreadsheet
but capable of operating with large amounts of data. Databases are
easily able to handle many millions of rows. This amount of data simply
can't be feasibly stored in an Excel table.

To make searching a database table faster it is common practice to
designate a one or more columns as an index. If a column is set as an
index the database will optimize requests to access information from
this column. The result is that searching for data from an index column
will be much quicker than trying to search for information in
non-indexed columns.





### SQL: Structured Query Language

SQL or Structured Query Language is a specialized language that was
developed to access the contents of a database table. Until relatively
recently, SQL has been the main way that software developers could
"talk" to database tables. SQL allows for data to be extracted from a
database in a relatively intuitive manner.

For example, say we had a historical database of corporations that were active in Canada
one hundred years ago. 
In the database table we might have the firm's name and the date it was founded. 
Using SQL we can query this database table and it will return just rows of the table that meet our criteria.

Given the table we will call Companies we can use SQL to query
the table to return all companies that are at least 10 years old.

` SELECT * FROM Companies where AGE == 10;`

As expected, this SELECT statement takes all rows from the database table called
**Companies** who are 10 years old and outputs the values.


| Company name  |  Age   |
|----------------------|--------------|
| BERLIN BUTTON WORKS | 120 |
| BERLIN FURNITURE| 115 |
| ... | ... |


The purpose of this aside has been to set the stage to present a new generation of database.
This new generation of database has collectively been called NoSQL databases. 
There are many different kinds of databases that are classified under the NoSQL rubric.
NoSQL databases do not necessarily have much in common with one another. 
Instead, each of these databases addresses a particular problem inherent in SQL databases and offers a solution beyond what SQL can offer.

The remainder of this lesson will consider Neo4j a database that doesn't represent the data that it is given as an Excel like table. 
Neo4j stores data in a graph structure.

## NoSQL: If not SQL then what? {#nosql_networks_not_tables}

The main distinction between SQL databases and graph databases are the way in which the underlying data is stored.
Traditionally, databases stored information in tables and query it using SQL.
However, if you're interested in representing your data as a graph it quickly becomes unwieldly to store your data as a series of tables and to reconstruct a graph every time you need to examine it.

Graph databases are just one of the many kinds of NoSQL databases on the market. 
These databases store the underlying information in a graph structure.
Accessing information within the database is as easy as following connections across the nodes of the graph.
From this point forward, we will focus on the Neo4j graph database. 

![Everything is stored as a graph in Neo4j (image [Wikimedia commons](https://commons.wikimedia.org/wiki/File:Social_Network_Analysis_Visualization.png))](images/dealing-with-big-data-and-network-analysis-using-neo4j-and-python/Social_Network_Analysis_Visualization.png)

> Neo4j is currently the most popular database on the market. It is also well documented and open-source.
> A full list of graph databases can be found on [Wikipedia](https://en.wikipedia.org/wiki/Graph_database#List_of_graph_databases)

### Creating a Neo4j database 

Once you have installed the [community edition of Neo4j](http://neo4j.com) we can set up a practice database.
On my machine the files were installed in **/Users/jon/Documents/Neo4j/**.
If you want to create a new database file for testing purposes just create an empty directory named something like **test.graphdb**.
Choose the file using the Neo4j program as shown below. 

![Load the database file ](images/dealing-with-big-data-and-network-analysis-using-neo4j-and-python/choose_db_green.png)

Then press **Start** and Neo4j will populate the directory and you can begin.

### Loading Data into Neo4j

There are two major approaches for loading data into Neo4j. 
The first involves setting up Neo4j and using the command line tools that ship with the database to directly load data from a CSV file.
This is by far the fastest method to load data into Neo4j. 

However, there are cases where one's network data is not in a form that can be easily loaded into the database.
In this case, the solution is to use **Cypher**. 
**Cypher** is a specialized query language designed to load and manipulate data in the Neo4j database.

We will explore both data input methods.

#### Loading a CSV file into Neo4j

Using the CSV batch loading mechanism in Neo4j is the fastest way to import data into your new database.
In this section I am going to talk about the process more generally for simple cases.
This process assumes that you have an empty database.
If there are already records in your database you will need to use Neo4j's Cypher query language to load or change existing records.

In theory, the process of loading data from a CSV file into Neo4j is relatively straightforward.
The difficulties come in the details.
For the sake of simplicity, we will assume that the CSV file is plain text. 
If there are Unicode byte order marks (referred to as a BOM) at the beginning of the file you will need to remove it.
Similarly, make sure the line endings are consistent. 

> If a file has been created on a Mac and a Windows machine make sure that the line endings are consistent.
> (The command line tool [dos2unix](https://sourceforge.net/projects/dos2unix/) is one way to ensure that the line endings are consistent for Mac, Windows or Unix.)
> The command line tool [CSVKit](http://csvkit.readthedocs.org/en/0.9.0/) is another way to ensure your CSV files are well formed.

Neo4j's batch import tool takes CSV files and imports them.
This command line tool is stored in the installation directory of Neo4j in the **bin/** directory.

```
bin/neo4j-import --into OurNewDatabase.db --id-type string \
    --nodes:Company companies.csv 
    --relationships:CONTAINS director_details.csv \
```

This process assumes that your data is cleanly separated into node and edge CSV files.
The columns in each CSV will have to be properly named to tell the import tools how to properly create relationships.

First, let's step through the options that are given in the command line above.

- **--into OurNewDatabase.db**  This loads the CSV data into the database called OurNewDatabase.db
- **--id-type string** Tells the import script that the ids are strings. If this were set to integers then the loading
  would be faster.
- **--nodes:Company companies.csv** Create nodes using the customers.csv file.
- **--relationships:CONTAINS director_details.csv** Creates the edges between nodes based on the contents of the
director_details.csv file.


**companies.csv**

| companyId:ID(Company)  |    name |
|----------------------|--------------|
| 281 | BERLIN BUTTON WORKS |
| 422 | BERLIN FURNITURE  | 
| ... | ... |

**director_details.csv**

|:START_ID(Company)  |  years_served |  :END_ID(Company)|
|-----------|-----------|--------------|
| 1041 | 13 |  281|
| 1042 | 2  |  422|
| 281 | 10  |  422|
| ... | ... | ... |

In our fictional example, Berlin Button Works and Berlin Furniture have both employed the same director for 10 years.
(The third row of director_details.csv shows the start node with the Berlin Button works ID and the end node as Berlin Furniture's ID.)
This director effectively acts as a tie between the two companies.

Note that we could just as easily make the directors the nodes and the companies the edges that connect them. 
This would give us a clearer picture of the professional network that unites individual directors.

Perhaps an even better alternative would be to represent both Companies and Directors as node types.
Directors would still act to tie the boards of companies together but there would be a different relationship that existed between the nodes.
Depending on your data and your research interests you will need to decide what is the most sensible way to represent data for your application.

We'll talk more about defining relationships and nodes below.

> The canonical guide to loading data from CSV is on [the Neo4j website](https://neo4j.com/developer/guide-import-csv/).

#### Using the Cypher query language 

In cases where there is already data in the database it may be easier to load data using the Cypher query language.
Much like SQL, Cypher is a language dedicated to loading, selecting or altering data that is stored in the Neo4j database.
In what follows, we will give some examples of each of these actions using Cypher.

The key to effectively querying Neo4j is understanding that information in the database is represented as a graph and not a table.
Therefore, you need to consider the information you're working with in terms of **nodes** and **relationships**.

A typical Cypher statement shows the relationship between one node and another node.

For example, we can create a node:
```
    CREATE (acompany:COMPANY {established:"Berlin, Ontario, Canada", companyId:281})
    CREATE (aperson:DIRECTOR {resides:"Berlin, Ontario, Canada", name:"George Schlee", personId:1234})
```
In this example, **acompany** is the variable name we have given to the object we created in the database.
We marked the object as being a **COMPANY** type. 
A COMPANY has the attributes **established** which is a string indicating where the firm was established.
In the examples above, each entry also has a unique **companyId**. 
(You may need to scroll the text to see it.)
We can use this unique id to query the database for information about the ties from each firm
We also created another type called the **DIRECTOR** type.
This type has three different attributes, including a **personId** that is a unique identifier for the director.

Now suppose that the database already contains data and we aren't sure if there is already information about a given director or company.
In this case, we can use the MATCH statement to match a unique node and manipulate it.

In the following example, we MATCH both the company and the person. 
The CREATE statement then uses the match for **c**ompany and **p**erson and CREATEs a relationship between the two nodes.
In this case, the relationship is called INTERLOCK.
```
MATCH  (c:COMPANY {companyId:281})
MATCH  (p:PERSON {personId:1234})
CREATE (c)-[s:INTERLOCK]->(p)
RETURN c,p,s;
```
Note that the relationship here is between the COMPANY and the DIRECTOR.
We are now defining our network with both DIRECTOR and COMPANY as being node types.
The relationship between COMPANY and DIRECTOR is defined as an INTERLOCK (assuming it's a director) but it could also be JOB to indicate that a person was a manager at the firm.
Again, data can be represented many different ways. 
It is worth considering what insights you want to get out of your data before you commit to a structure in the database.

Finally, the RETURN statement returns the variables for us to further manipulate.
For example, we could decide to add another attribute to the **c**ompany. 
Here we add a **URL** attribute to the company object that contains a museum's entry about the company. 
```
SET c.url = "http://upgrade.waterlooregionmuseum.com/region-hall-of-fame/inductees-s-to-v/";
```

#### A brief note on INDEX

Creating an index is important for any database to run efficiently. 
Quite simply an index is a particular field in a database that is designated for the database to optimize so that lookups are as fast as possible.

To create an index in Neo4j, we would issue the following Cypher command
```
CREATE INDEX ON :COMPANY(companyId)
CREATE INDEX ON :PERSON(personId)
```
Creating this index will greatly speed up any queries we make based on the unique keys **companyId** or **personId**.

> Note - Don't create more indexes than you need. 
> Creating too many indexes will have the effect of slowing down your database.
> Again, designing your database so that you have a unique key to do lookups is crucial.

#### Discussion
So far we have used the basic syntax of the Cypher query language. 
We've seen that relationships on a graph are written quite intuitively using Cypher.
```
(n1:NODE)-[:relationship]->(n2:NODE)
```
In this section we used Cypher to CREATE entries in the database, MATCH existing data, and we used SET to alter existing data we found.

> More on the [Cypher query language](https://neo4j.com/developer/cypher-query-language/) can be found on the Neo4j
> web site.




## Using Python to manipulate data

In this section we will use the **Python** programming language to really begin to make the most of our database.
If you're considering using a database for your project you likely have a lot of complex data that you want to manage in an efficient and consistent way.
Most spreadsheets quickly become unmanageable after a few tens of thousands of rows.
Manually manipulating data using Cypher queries is not something we generally want to do because we risk accidentally altering the information we worked
hard to put there.

Luckily, Neo4j has built-in facilities to work with the database. For example, one can MATCH data and view the results.
Although these features are useful for making basic queries on the data in the database, they too start to get bogged down with large queries.
In the following sections we will work with data directly using python code, and we'll also visualize data in a robust manner by streaming it to Gephi.




### Using python to explore graphs

In order to use python to manipulate the Neo4j results, we need to install a python library **py2neo**.

> [Py2neo and detailed documentation is online](http://py2neo.org/v3/).

To install it, use the **pip** command to update python.
```
pip install py2neo
```

Then to use the library in a python script we simply add the following to our **db_query.py** script.

```python
import sys
import py2neo as py2neo
import networkx as nx

# Get the second degree connections as well
query = """
match (source:COMPANY) where source.name="BERLIN LION BREWERY"
match (alter:COMPANY)
match path=(source)-[r]-(alter)
return path,source,alter;
"""

def add_to_graph( g, pnode ):
    """
    py2neo has its own Node, Path and Relationship objects.
    This converts and adds these objects into a NetworkX graph
    """
    if isinstance( pnode, py2neo.types.Node ):
        firm_id = pnode['name']
        if firm_id == None:
            return
        if firm_id not in g:
            g.add_node( firm_id, dict( pnode ) )
        return firm_id

# ----------------
# Main
# ----------------
g = nx.MultiDiGraph() # Our networkx graph
print "-----------------------"
print query
print "-----------------------"

# set up authentication parameters
py2neo.authenticate("localhost:7474", "", "")

# connect to authenticated graph database
graph = py2neo.Graph("http://localhost:7474/db/data/")
# submit the query to Neo4j
results = graph.data( query ) # returns list of dicts (responses)

# Go through the result list - actually a dict with the Neo4j 
# query element and the resulting py2neo graph object passed back
for d in results:
    s = d['source']
    a = d['alter']
    sid = add_to_graph( g, s ) # 
    aid = add_to_graph( g, a ) # 
    g.add_edge( sid, aid )

# Now write out the graph into GEXF format (readable by gephi)
nx.write_gexf( g, "example.gexf" )

```

This will print out all relationships each person in the database has with the company Berlin Lion Brewery (using the **where source.name = "BERLIN LION BREWERY"** statement).
Run the script using the python interpreter. It will output a file example.gexf you can load into Gephi.
```
python db_query.py
```

> Note that py2neo has its own Node, Path and Relationship objects.
> This library generally follows the Neo4j terminology. In the example script we convert these objects into 
> the [python library NetworkX](https://networkx.github.io/) (detailed in a different Programming Historian lesson).
> NetworkX is a powerful library for network manipulation and it also has facilities to import and export different file
> types. 





## Visualizing parts of a large graph
Now we turn to a unique piece of open-source software called [Gephi](https://gephi.org).
Gephi is designed to allow for visualization of complex networks using an intuitive graphical interface.
Used in conjunction with Neo4j, Gephi allows us to examine different parts of the graph in the Neo4j database.
All we need to do is query the database and then stream the results to Gephi. 
This short section will detail just how to configure Gephi.

> Gephi can be [downloaded here.](https://www.gephi.org)


### Installing Gephi
After you install Gephi double-click on the icon to start it up.
You should then see the loading screen.

![Gephi loading screen](images/dealing-with-big-data-and-network-analysis-using-neo4j-and-python/gephi_startup.png)

Now you need to install the Graph Streaming plugin. 
Plugins extend the basic functionality of Gephi.
A variety of plugins are available from the so-called Gephi marketplace.

![Plugin menu](images/dealing-with-big-data-and-network-analysis-using-neo4j-and-python/Gephi_plugins_menu.png)

Then you should be able to download the Graph Streaming plugin. 
If you already have it installed you may need to update it.

![Streaming plugin](images/dealing-with-big-data-and-network-analysis-using-neo4j-and-python/gephi_streaming_plugin.png)

The Graph Streaming plugin simply provides an API for applications to hook into.
It allows these applications to send information about graphs for Gephi to display.

Once you install the Graph Streaming plugin, look for its window.
Choose Master Server and then right-click to Start the plugin to listen.

![Starting the Graph Streaming plugin](images/dealing-with-big-data-and-network-analysis-using-neo4j-and-python/gephi_streaming_master_start.png)

### Get Neo4j talking to Gephi

We also need to extend Neo4j's capabilities a little with the APOC library.
APOC stands for "Awesome Procedures On Cypher" (and its also the name of technician and driver on board of the Nebuchadnezzar in the Matrix.)
APOC contains over 300 user written extensions for Neo4j. The one that we're interested in will allow us to stream our query results to Gephi.

> You can find the latest version of APOC on GitHub at [https://neo4j-contrib.github.io/neo4j-apoc-procedures/index31.html](https://neo4j-contrib.github.io/neo4j-apoc-procedures/index31.html).

Download the latest release from this page and place the binary jar to place into your $NEO4J_HOME/plugins folder.

This will be something like the following, depending on your platform:

**OSX:**      
/Applications/Neo4j Community Edition <version>.app/Contents/Resources/app/plugins 
AND 
/Users/<user>/Documents/Neo4j/default.graphdb/plugins

**Windows:**  
C:\\Program Files\\Neo4j CE version\\plugins


Now restart Neo4j for good measure. Now that APOC is in place, we can stream graphs!

### Querying Neo4j and visualizing with Gephi

Now that everything is installed, it's simply a matter of querying Neo4j and ensuring that Gephi is expecting the results.

Let's say we want to visualize our Berlin Button Factory example.
We simply make the following database query.

~~~
MATCH path = (c:COMPANY)-[:INTERLOCK]->(n:COMPANY) where c.name = "Berlin Button Factory"
call apoc.gephi.add(null,'workspace0', path, 'weight') yield nodes, relationships, time
return nodes, relationships, time;
~~~

The MATCH statement finds the node we are interested in, i.e. the Berlin Button Factory .
In this case **path** refers to all the nodes and relationships that connect to Berlin Button Factory.
The next line is a call to our user written APOC library.
Here we call Gephi in the workspace called **"workspace0"**. 
Note that you may need to rename your workspace to match.
The return call passes the results back to Gephi to display.

You can call this query using the command line tools that come packaged with Neo4j or you can use the web interface.
![Neo4j web interface that runs on the localhost](images/dealing-with-big-data-and-network-analysis-using-neo4j-and-python/browser_neo4j.png)


If we were to use the command line tools it would look like this:

~~~
./neo4j-shell -file my_query.cypher
~~~
Where my_query.cypher contains the Cypher query we defined above.

> You can find [another streaming example](https://tbgraph.wordpress.com/2017/04/01/neo4j-to-gephi/) online as well.

## Putting it all together: A working example

Now that you have a sense of the various components of Neo4j let's review with some actual data.
This section uses a network based on corporate interlocks between Canadian firms in 1912. 
This graph isn't large enough to necessarily justify using Neo4j but it is complex enough that it makes for an interesting example.

>If you make use of this data in a research project, please cite the following references in addition to this lesson.
>
>**MacKay, J. Forthcoming. Canadian Regional and National Business Elites in 1912:  Who Was Connected, Who Wasn’t and Why? In W. Pettigrew & D. Smith (Eds.), The Social Life of Business: A History, 1450-1950. Palgrave.**
>
>**MacKay, J.,“Networks of Canadian Business Elites: Historical Corporate Interlock Networks circa 1912” (Forthcoming: Connections)**
>
>You can [download the data](http://jgmackay.com/resources/DoD_CA_1912_corp.gexf.zip) in the GEXF file format designed for Gephi. 
>More about the [data can be found here](http://jgmackay.com/JGM/News/Entries/2017/1/16_Networks_of_Canadian_Business_Elites__Historical_Corporate_Interlock_Networks_circa_1912.html).


The next step is to load the data into Neo4j.
Normally, I would use the CSV loader utility described earlier in this lesson. 
However, in this case it makes more sense to generate Cypher code based on the network structure.
The following is a python script that reads in the GEXF file and creates a network graph object using the NetworkX library.
We iterate over all of the nodes in the graph and add them to the database. 
Then we add all of the edges from the graph to the database.

```python
import py2neo
import networkx as nx

"""
Generate a Cypher code by reading the contents of a GEXF file.
Download the data from: 
http://jgmackay.com/resources/DoD_CA_1912_corp.gexf.zip
"""

def dict2attr( attr ):
    """
    Convert dictionary listings to a string value
    """
    pairs = ""
    for k,v in attr.iteritems():
        pairs += " \%s:\"\%s\"," \% (k,v) 
    pairs = pairs.strip()[:-1]
    return pairs

# ---------------------
# Main
# ---------------------
# Use NetworkX to read in the GEXF
g = nx.read_gexf( "DoD_CA_1912_corp.gexf" ) 
for n in g:          # Loop through each node in the graph
    co = n.upper()   # Upper case names look better
    attr = g.node[n] # Get attributes for each node
    # Construct a CREATE statement in Cypher for each node
    q = "CREATE (n:COMPANY {name:\"\%s\", \%s"
    pairs = dict2attr( attr )
    q = q \% (co,pairs)
    q += "} );"
    print q # print out CREATE statement


# Edges - Add edges. Direction doesn't matter
cache = {}           # Don't do duplicate nodes!
for n in g.nodes():
    name_upper = n.upper()
    if name_upper in cache:
        continue
    # Add all the relationships from a given node
    cache[name_upper] = "" # Add node to cache so we don't do it again
    d = g[n]               # Get the dict for all neighbors the node is connected to
    for co_name, edge_attr in d.iteritems():
        alt_upper = co_name.upper()
        pairs = dict2attr( edge_attr )
        print "MATCH (c0:COMPANY {name:\"\%s\"})" \% (name_upper)
        print "MATCH (c1:COMPANY {name:\"\%s\"})" \% (alt_upper)
        print "CREATE (c0)-[r:INTERLOCK {\%s}]->(c1);" \% (pairs) # direction doesn't matter
```

We can run the script as follows.

```
python mkCypher.py > out.txt
```

The result is a Cypher file containing all of the node and relationships.

```sql
CREATE (n:COMPANY {name:"SHAWINIGAN WATER AND POWER", city:"montreal", uid_cd_11:"QC181", weight:"65", latitude:"45.5087928", prov:"Quebec", longitude:"-73.5539819", label:"shawinigan water and power"} );
CREATE (n:COMPANY {name:"CONSOLIDATED MANUFACTURING", city:"hamilton", uid_cd_11:"ON078", weight:"1", latitude:"43.254687", prov:"Ontario", longitude:"-79.8678196", label:"consolidated manufacturing"} );
CREATE (n:COMPANY {name:"ONTARIO LANTERN AND LAMP", city:"hamilton", uid_cd_11:"ON078", weight:"6", latitude:"43.254687", prov:"Ontario", longitude:"-79.8678196", label:"ontario lantern and lamp"} );
CREATE (n:COMPANY {name:"CANADA MACHINERY CORPORATION", city:"galt", uid_cd_11:"ON131", weight:"19", latitude:"43.3614741", prov:"Ontario", longitude:"-80.3116777", label:"canada machinery corporation"} );
...
```

We can load this Cypher into the database using the command line tools (Or you could try to copy this into the web interface. It's unlikely to work however. The file is over 26,000 lines long.)

```
./neo4j-shell -file out.txt
```

If we return to the [web interface on your local machine](http://localhost:7474) we can query our new database.
Let's look at the firms that have the greatest number of connections (i.e. the highest degree).
To calculate degree we can make a simple query with Cypher.

```
MATCH (c:COMPANY)
set c.degree = size((c)-->());
```

This code simply matches to each node and counts the size (or degree) of each node.
We use the SET command to set the degree value as an attribute of each node.

Now we can examine those nodes with the highest degree. 
Here we list companies where there are 75 or more connections (via high level employees or directors to other companies).
```
match (c0:COMPANY)-[r]-(c1) where c0.degree > 75
return DISTINCT c0.name;
```
This results in the following companies:

- TORONTO AND YORK RADIAL RAILWAY
- MONTREAL ELECTRIC HEAT AND POWER
- CANADIAN PACIFIC RAILWAY
- TORONTO RAILWAY
- DOMINION COAL
- CANADIAN GENERAL ELECTRIC

We can also try to examine all of the interlocks between these companies and other companies.

```
match (c0:COMPANY)-[r]-(c1) where c0.degree > 75
return c0, r, c1;
```
![Results are overly crowded and difficult to make sense of.](images/dealing-with-big-data-and-network-analysis-using-neo4j-and-python/graph_example.png)

Note that the result is large and will not completely display in the browser. 
However, if we issue the command to send it to Gephi we have much more control over the layout.

```
MATCH path = (c:COMPANY)-[:INTERLOCK]->(n:COMPANY) where c.degree > 75
call apoc.gephi.add(null,'workspace0', path, 'weight') yield nodes, relationships, time
return nodes, relationships, time;
```
The initial results on Gephi are also difficult to interpret.

![Initial graph before transformation](images/dealing-with-big-data-and-network-analysis-using-neo4j-and-python/gephi_load_largest.png)

Once in Gephi we can manipulate the graph. 
First, we can change the size of each node to be relative to the degree of the node.
Next, we use the modularity clustering algorithm to determine which firms are more connected to one another.
There are three clusters.
Then we set the color of the nodes according to this clustering. 
Finally, we use a layout algorithm to display the graph nodes.
I chose the "ForceAtlas 2" algorithm.

![The network after a little manipulation](images/dealing-with-big-data-and-network-analysis-using-neo4j-and-python/gephi_network_good.png)


Dominion Coal is in red and it appears to have it's own orbit of smaller firms.
Canadian Pacific Railway and Montreal Heat and Power have some ties and are clustered together.
All three of these major firms are based in Montreal.

The other firms are based in the up-and-coming city of Toronto in Ontario.
Toronto Railway, Canadian General Electric and Toronto and York Radial Railway all share a number of directors.
Similarly, there is an orbit of firms around these dominant firms (all clustered in white).

Gephi clearly makes an enormous difference in layout. 
It makes it much easier to see patterns in the underlying network.

# Conclusion

In this lesson we've introduced the Neo4j graph database. 
We've shown how we can talk directly to the database using the Cypher query language and python.
We've also shown how easy it is to visualize different parts of graphs stored in Neo4j using
Gephi and its streaming capabilities.
Finally, we've also included some data and example code that reinforces the key topics of this lesson.
Wherever possible this lesson has also linked to primary documents and software to make getting started as easy as possible.
