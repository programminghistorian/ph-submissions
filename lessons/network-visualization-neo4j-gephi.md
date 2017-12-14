---
title: | 
    Network Visualization with Neo4j and Gephi
authors: Jon MacKay
reviewers: R1,R2,R3
date: 2017-06-05
layout: default
---

## Introduction

This lesson focuses on manipulating and visualizing parts of large, complex networks that have been 
stored in Neo4j graph database. 
In the first part of this lesson, python is used to extract a portion of a large network so that it can be loaded into the network visualization software Gephi.
The second part, takes a different approach to examining complex graphs. 
Rather than exporting a file, Gephi attaches to the Neo4j database directly and 
dynamically displays parts of the network that are streamed to it.
The third and final part focuses on displaying data in Gephi. Whether you choose to read a file designed for Gephi or to stream a network to Gephi the basic
steps to begin to visualize a complex network will be the same.

This tutorial will focus on the following open source tools. These
include the [Neo4j graph database](https://neo4j.com/), the [Cypher
query language](https://neo4j.com/developer/cypher-query-language/) used
by Neo4j and the [Python programming language](http://python.org).

-   [Neo4j](https://neo4j.com/) is a free, open-source graph database
    written in java that is available for all major computing platforms.
    This lesson assumes that you are familiar with the Neo4j graph database.
    A tutorial focused on [Neo4j is here](dealing-with-big-data-and-network-analysis-using-neo4j.html).
-   [Cypher](https://neo4j.com/developer/cypher-query-language/) is the
    query language bundled with the Neo4j database that is designed to insert and
    select information from the database.
    You should have a basic familiarity with the Cypher query language for Neo4j. 
    More on the [Cypher query language](https://neo4j.com/developer/cypher-query-language/) can be found on the Neo4j
    web site.
-   [Python](http://python.org) is a relatively simple programming language
    that can be readily used by beginner and advanced programmers alike. This lesson uses Python
    and some specialized libraries for manipulating graphs. Although this lesson can't go into 
    too many details on these libraries, the Programming Historian has lots of 
    [Python resources](https://programminghistorian.org/lessons/?topic=python).
-   This tutorial will also use the point-and-click open source program
    [Gephi](https://gephi.org) to visualize networks.

> I strongly recommend that you read the lesson through before trying this lesson.
> I have tried to include enough detail to get up and running as quickly as possible.
> However, I could only touch on some of the major features available.
> Wherever possible URLs are included back to more detailed documentation or lessons.

### Graph databases

Graph databases offer a way to store and explore data where there are relationships between information.
These specialized databases are designed to store information in a graph structure rather than as a table.
Accessing information within this type of database is as easy as following connections across the nodes of the graph.
In this lesson, it is assumed that you are confident in using the Neo4j graph database. 
If you're not so confident yet, see the 
[previous lesson on Neo4j](dealing-with-big-data-and-network-analysis-using-neo4j.html).

> Neo4j is currently the most popular database on the market. It is also well documented and open-source.
> A full list of graph databases can be found on [Wikipedia](https://en.wikipedia.org/wiki/Graph_database#List_of_graph_databases)


### Why not use other tools to examine networks?

The *Programming Historian* already has lessons about [how to use python](https://programminghistorian.org/lessons/?topic=python) 
and how to [programmatically manipulate graphs](https://programminghistorian.org/lessons/exploring-and-analyzing-network-data-with-python). 
Aren't we just making working with graphs more
complex than it needs to be?

Yes and no. For smaller datasets that result in smaller graphs it
probably makes sense to stick with a single tool. The python language
coupled with the [NetworkX graph manipulation
library](https://networkx.github.io/) are likely sufficient for many
tasks. 

The limitations of this approach begin to show as the graphs we
want to study get larger. Extremely large graphs can be time consuming
to load, manipulate and to visualize. The process will be even slower if we
attempt to calculate simple network statistics.


## Visualizing graphs with Gephi

[Gephi](https://gephi.org) is open-source software that has been designed to visualize complex networks using an intuitive graphical interface.
When dealing with extremely large graphs, one can use Gephi to examine different parts of the graph.
This lesson will focus on two of the most common approaches.
The first is for Gephi to read a graph saved in a specialized format such as a GEXF -- Graph Exchange XML Format.
The second approach is to stream the graph directly to Gephi.
In this case, the database is queried and the resulting graph is streamed directly to Gephi. 
This short section will detail just how to install Gephi and configure it to accept streamed data from different applications.

### Installing Gephi

> Gephi can be [downloaded here.](https://www.gephi.org)

After you install Gephi double-click on the icon to start it up.
You should then see the loading screen.

{% include figure.html filename="gephi_startup.png" caption="Gephi loading screen" %}
![](images/gephi_startup.png)

Once Gephi is installed you're ready to look at some graphs.
If you're only interested in reading a file specifically designed for Gephi, you
can skip ahead to the section called "Putting it all together: A working example".

If you're interested in how to set up dynamic streaming from the Neo4j database to
Gephi, then continue reading!

### Setting up graph streaming

Normally, Gephi loads graph files by simply opening a specially formatted file with the extension gexf.
A variety of plugins are available from the so-called Gephi marketplace.
The Graph Streaming plugin extends the functionality of Gephi by allowing applications to send data directly to Gephi to display.

{% include figure.html filename="Gephi_plugins_menu.png" caption="Plugin menu" %}
![](images/Gephi_plugins_menu.png)

Then you should be able to download the Graph Streaming plugin. 
If you already have the streaming plugin installed check to ensure that it is the most recent version.

{% include figure.html filename="gephi_streaming_plugin.png" caption="Streaming plugin" %}
![](images/gephi_streaming_plugin.png)

Once you install the Graph Streaming plugin, look for its window.
Now create a new Workspace and rename the workspace **Workspace0**. We'll refer to that workspace from Neo4j and that's where the graph data will be sent for Gephi to read.
Choose Master Server and then right-click to Start the plugin to listen.

{% include figure.html filename="gephi_streaming_master_start.png" caption="Starting the Graph Streaming plugin in Gephi" %}
![](images/gephi_streaming_master_start.png)

## Part I: Using Python to manipulate data in Neo4j

In this section we will use the **Python** programming language to really begin to make the most of the Neo4j database.

The sections that follow will explain how to interact with the Neo4j graph database using python.
We'll also visualize data in a robust manner by streaming it to the graph visualization software Gephi.

### Installing python libraries to explore graphs

You'll need to install two python libraries if you don't already have them installed.
To install them, use the **pip** command to update your python installation. 

```
pip install py2neo
pip install networkx
```

> For those unfamiliar with how to use pip, you may want to look at another Programming Historian lesson entitled
> [Installing Python Modules with pip](http://programminghistorian.org/lessons/installing-python-modules-pip).


The py2neo installation is necessary to communicate with the Neo4j database.
The NetworkX library is used to manipulate and analyze network data.

> [Py2neo and detailed documentation is online](http://py2neo.org/v3/).
>
> The [NetworkX documentation is here.](https://networkx.github.io/documentation/stable/index.html#)


Then to use the library in a python script we simply add the following to our **p2neo_example.py** script.

> You can [download the full python program here](py2neo_example.py)

```python
import sys
import py2neo as py2neo
import networkx as nx

# Get the second degree connections as well
query = """
MATCH (source:COMPANY) WHERE source.name="DOMINION COAL"
MATCH (alter:COMPANY)
MATCH path=(source)-[r]-(alter)
RETURN path,source,alter;
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

> Note that py2neo has its own Node, Path and Relationship objects.
> This library generally follows the Neo4j terminology. In the example script we convert these objects into 
> the [python library NetworkX](https://networkx.github.io/) (detailed in the Programming Historian lesson entitled
> [Exploring and Analyzing Network Data with Python](https://programminghistorian.org/lessons/exploring-and-analyzing-network-data-with-python)).
> NetworkX is a powerful library for network manipulation and it also has facilities to import and export different file
> types. 


This will print out all relationships each person in the database has with the company DOMINION COAL (using the **where source.name = "DOMINION COAL"** statement).
Run the script using the python interpreter. It will output a file example.gexf you can load into Gephi.
```
python p2neo_example.py
```



## Part II: Get Neo4j to stream graph data to Gephi

Now that Gephi is prepared, we need to extend Neo4j's capabilities.
In particular, we want to load the APOC library.
APOC stands for "Awesome Procedures On Cypher".
The APOC library contains over 300 user written extensions for Neo4j. 
The one that we're interested in will allow us to stream our query results to Gephi.

Neo4j Desktop makes this process easy. First, start Neo4j Desktop and choose the project with the database you're interested in.
Next, click the "Manage" button. Then search for the "Plugins" tab, then click "Install".

![Install the APOC library - Just click "Install"](images/new-neo4j-APOC.png)

### Querying Neo4j and visualizing with Gephi

Now that everything is installed, it's simply a matter of querying Neo4j and ensuring that Gephi is expecting the results.
Let's say we want to visualize our DOMINION COAL example.
We simply make the following database query.

~~~
MATCH path = (c:COMPANY)-[:INTERLOCK]->(n:COMPANY) 
    where c.name = "DOMINION COAL"
CALL apoc.gephi.add(null,'workspace0', path, 'weight') 
    yield nodes, relationships, time
RETURN nodes, relationships, time;
~~~

The MATCH statement finds the node we are interested in, i.e. the Dominion Coal company.
In this case **path** refers to all the nodes and relationships that connect to Dominion Coal. 
The next line is a call to our user written APOC library.
Here we call Gephi in the workspace called **"workspace0"**. 
(You may need to rename your workspace to match.)
The return call passes the results back to Gephi to display.

## Part III: Putting it all together: A working example

Now that you have a sense of the various components of Neo4j let's review with some actual data.
This section uses a network based on corporate interlocks between Canadian firms in 1912. 

>You can [download the data](http://jgmackay.com/resources/DoD_CA_1912_corp.gexf.zip) in the GEXF file format designed for Gephi. 
>More about the [data can be found here](http://jgmackay.com/JGM/News/Entries/2017/1/16_Networks_of_Canadian_Business_Elites__Historical_Corporate_Interlock_Networks_circa_1912.html).
>
>If you make use of this data in a research project, please cite the following references in addition to this lesson.
>
>MacKay, J. Forthcoming. Canadian Regional and National Business Elites in 1912:  Who Was Connected, Who Wasn’t and Why? In W. Pettigrew & D. Smith (Eds.), The Social Life of Business: A History, 1450-1950. Palgrave.
>
>MacKay, J.,“Networks of Canadian Business Elites: Historical Corporate Interlock Networks circa 1912” (Forthcoming: Connections)
>

## Examining a network using Cypher

Let's continue from where the [previous lesson on Neo4j left off](dealing-with-big-data-and-network-analysis-using-neo4j.html).
Previously, we were interested in those companies that had the most directors.
Firms that have the greatest number of connections (i.e. the highest degree) are often associated with power and prestige.
Recall, that to calculate degree we made a query with Cypher and created a new attribute in our graph called **degree**.

```
MATCH (c:COMPANY)
SET c.degree = size((c)-->());
```

This counts the number of connections that each node has to all other nodes.
This is also called the degree of the node.
The SET command is used to set the degree value as an attribute of each node.

Using this information, we can examine those nodes with the highest degree. 
Here we list companies where there are 75 or more connections (via high level employees or directors to other companies).
```
MATCH (c0:COMPANY)-[r]-(c1) WHERE c0.degree > 75
RETURN DISTINCT c0.name;
```
This results in the following companies:

- TORONTO AND YORK RADIAL RAILWAY
- MONTREAL ELECTRIC HEAT AND POWER
- CANADIAN PACIFIC RAILWAY
- TORONTO RAILWAY
- DOMINION COAL
- CANADIAN GENERAL ELECTRIC

We examined the interlocks between the most highly interlocked companies and other highly interlocked companies.

```
MATCH (c0:COMPANY)-[r]-(c1) WHERE c0.degree > 75 AND c1.degree > 75
RETURN c0, r, c1;
```
{% include figure.html filename="graph_example.png" caption="The visualization of the results from this query in the Neo4j web browser interface are difficult to interpret." %}
![](images/graph_example.png)

The resulting network is small because we specified we want only companies that have in more than 75 corporate interlocks.
Clearly, there are very few companies that are so large that they can justify this many directors.

However, what if we want to visualize all of the companies that are interlocked with a firm that has more than 75 corporate interlocks?
A graph with this information would contain all of the companies that were connected to the most connected firms.
Clearly, the built in graph visualization tool that comes with Neo4j will not be able to clearly display such a complex network.
However, if we issue the command to send it to Gephi, one can have much more control over the layout.

## Sending a graph from Neo4j to Gephi

The following Cypher code will send the results of the network query to Gephi.

```
MATCH path = (c:COMPANY)-[:INTERLOCK]->(n:COMPANY) 
    where c.degree > 75
call apoc.gephi.add(null,'workspace0', path, 'weight') 
    yield nodes, relationships, time
return nodes, relationships, time;
```
> Note the difference between this MATCH statement. Here we want to 
> see all of the connections to those firms with over 75 corporate interlocks.

The first line MATCHES all of the cases where one company is interlocked with another. 
The results of the query will be stored in the **path** variable.
The second line narrows the search criteria by specifying that the results should only contain
cases WHERE the one of the firm has in excess of 75 directors.
The third line is a special call to the APOC library that was loaded earlier.
The path object is passed to the function apoc.gephi.add along with the name of a workspace that is open in Gephi.
The APOC library then streams the results of the query as a graph for Gephi to display.

The initial results displayed in Gephi also are difficult to interpret.
However, we can easily manipulate the graph to show off interesting features.


{% include figure.html filename="gephi_load_largest.png" caption="Initial graph displayed in Gephi before any transformations." %}
![](images/gephi_load_largest.png)

First, we can change the size of each node to be relative to the degree of the node.
Next, we use the __modularity__ clustering algorithm to determine which firms are more connected to one another.
It shows that there are three main clusters of densely connected nodes.
Then we set the color of the nodes according to this clustering. 
Finally, we use a layout algorithm to display the graph nodes.
I chose the "ForceAtlas 2" algorithm.

{% include figure.html filename="gephi_network_good.png" caption="The network after a little manipulation using Gephi." %}
![](images/gephi_network_good.png)

Dominion Coal is in red. It appears to have it's own orbit of smaller firms.
Canadian Pacific Railway and Montreal Heat and Power have some ties and are clustered together.
All three of these major firms are based in Montreal, Quebec.

The other firms are based in the up-and-coming city of Toronto in Ontario.
Toronto Railway, Canadian General Electric and Toronto and York Radial Railway all share a number of directors.
Similarly, there is an orbit of firms around these dominant firms (all clustered in white).

Gephi clearly makes an enormous difference in layout. 
It makes it much easier to see patterns in the underlying network.

# Conclusion

In this lesson we've introduced ways to work with data in the Neo4j graph database. 
We've shown how we can talk directly to the database using the Cypher query language and python.
We've also shown how easy it is to visualize different parts of graphs stored in Neo4j using
Gephi and its streaming capabilities.
Finally, we've also included some data and example code that reinforces the key topics of this lesson.

