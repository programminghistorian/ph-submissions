---
title: Introduction to MySQL with R
authors:
- Jeff Blackadar
date: 2017-11-05
reviewers:
- Amanda Visconti
layout: lesson
difficulty: 1
---

*draft* I am now in editing mode.  If you have feedback on the draft I welcome it. jeffblackadar at gmail dot com.

# Getting Started With MySQL

## Contents

## Introduction

For a recent undergraduate course in digital history our class was working with the [Shawville Equity newspaper](http://numerique.banq.qc.ca/patrimoine/details/52327/2553732). After a few days of research through the digital copies of The Equity my mouse hand was cramped and my eyes were strained. I thought that making a finding aid would make it easier to look up topics without having to open each edition individually and scan through it.  

The [first finding aid](http://jeffblackadar.ca/hist3814o_final/equityeditions.html) I made was an html file listing the dates of the editions with links to the digital copy.  Later I added the most common words that appeared in each edition. This version of the [finding aid](http://www.jeffblackadar.ca/hist3814o_final/equityeditions_withtopics.html) was 4.3 mb in size.  

I wanted to make further improvements to the finding aid by using natural language processing of The Equity in R per [Lincoln Mullen’s lesson](https://rpubs.com/lmullen/nlp-chapter) on the Rpubs website. Given the existence of thousands of person, location and organization entities present in over 6000 editions of The Equity, using static html files to present the finding aid would be impractical.  I decided to use a relational database.  The database would allow me to publish the finding aid to a website where it could be searched.  

Using a database also offered the ability to recover from errors when my R program stopped during processing.  Since the database stores the most recently processed work, the R program was able to begin from where it left off before it ran into an error. This was very important because I did not want to waste days of processing by starting over from the beginning. This lesson is an introduction to using the MySQL relational database with R in a similar way I used to create the finding aid I worked on.

MySQL is a relational database used to store and query information. This lesson will use the R language to provide a tutorial and examples to:
 - Set up and connect to a table in MySQL.
 - Store records to the table.
 - Query the table.

R can perform analysis and data storage without the use of a relational database. However, there are times when databases are very useful including:
 - Placing the results of an R program on a web site where the data can be interacted with.
 - Handling large amounts of data.
 - Storing the results of long running programs so that a program can continue from where it left off in case it was interrupted. 
 
A further short discussion of this is on [Jason A. French's blog](http://www.jason-french.com/blog/2014/07/03/using-r-with-mysql-databases/).

In this tutorial you will make a database of newspaper stories that contain words from a search of a newspaper archive. The program will store the title, date published and URL of each story in a database. We'll use another program to query the database and look for historically significant patterns. Sample data will be provided from the [Welsh Newspapers Online](http://newspapers.library.wales) newspaper archive.

## Downloading and Installing MySQL Workbench

Complete these instructions to install MySQL and MySQL Workbench on your computer.

MySQL Installation instructions:  https://dev.mysql.com/doc/workbench/en/wb-installing.html

MySQL Workbench downloads:  http://dev.mysql.com/downloads/workbench/

## Create a database
![Creating a database in MySQL Workbench](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-1.png "Creating a database in MySQL Workbench")

Using MySQL Workbench perform these steps:
1. In the **Query window** type:
```
CREATE DATABASE newspaper_search_results;
```
2. Run the CREATE DATABASE command.  Click on the **lightning bolt** or using the menu, click Query | Execute Current Statement.
3. Beside **SCHEMAS**, if necessary, click the refresh icon.
4. The new database **newspaper_search_results** should be visible under SCHEMAS



In the Query window type:
```
USE newspaper_search_results;
```
The USE statement informs MySQL Workbench that you are working with the newspaper_search_results when you run commands.

## Add a table

1. In MySQL Workbench, look in the left side in the **Navigator** panel, under **SCHEMAS** for **newspaper_search_results**.
2. Right-click on **Tables** and click **Create Table**.
3. for **Table Name:** type **tbl_newspaper_search_results**

### Add columns to the table

Add these columns:
1. **id** Data type: **INT**. Click PK (Primary Key), NN (Not Null) and AI (Auto Increment).  This id column will be used to relate records in this table to records in other tables.
2. **story_title** Data type: **VARCHAR(99)**. This column will store the title of each article result we gather from the search.
3. **story_date_published** Data type: **DATETIME**. This column will store the date the newspaper was published.
4. **story_url** Data type: **VARCHAR(99)**. This column will store the URL of each result we gather from the search.
5. **search_term_used** Data type: **VARCHAR(45)**. This column will store the word we used to search the newspapers.
Click the **Apply** button.

All of this can be done with a command if you prefer:
```
CREATE TABLE `tbl_newspaper_search_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `story_title` varchar(99) DEFAULT NULL,
  `story_date_published` datetime DEFAULT NULL,
  `story_url` varchar(99) DEFAULT NULL,
  `search_term_used` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

```
*Tip: Take your time to think about table design and naming since a well designed database will be easier to work with and understand.*

## Add a user to connect to the database

We are adding a new user so that this user ID is used only to connect to the new database, limiting exposure in case its password is compromised.

In the MySQL Workbench menu click **Server | Users and Privileges**

Click the **Add Account** button and complete the Details for account newuser dialog box:
1. login name: **newspaper_search_results_user**
2. Authentication Type
3. Limit to hosts matching: **Localhost**
4. Enter and confirm a password
5. Click on the **Administrative Roles** tab.  Make sure nothing is checked.  This account is for accessing the database only.
6. Click on the **Schema Priviledges** tab and click **Add Entry**
7. In the **New Schema Priviledge Definition** diablog box, click the **Selected schema:** radio button and select **newspaper_search_results**.
8. Click all of the Object Rights: SELECT, INSERT, UPDATE, DELETE, EXECUTE, SHOW VIEW as per the image below.
9. Click the **Apply** button.

![setting permissions for new account.](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-2.png "setting permissions for new account")



## Create an R program that connects to the database

In RStudio create a program named newspaper_search.R

We will use the RMySQL package to connect to MySQL.  Documentation is here:

https://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf

If you don't have the library RMySQL installed, install it using the RStudio Console.  Run this instruction per below:
```
install.packages("RMySQL")
```
Add this statement to the newspaper_search.R program

```
library(RMySQL)
```

### Connecting to the database with a password.

We will connect to the database at first using a password. (Later we'll use a better way to connect.)  For now, we will use a variable to store the password.  Each time you start R you'll need to reset this variable, but that is better than publishing a hardcoded password if you share your programs, like you may do using GitHub.

In the RStudio console type something like below, replacing "SomethingDifficult" with the password you created for newspaper_search_results_user in the steps you did above to add a user to connect to the database.

> localuserpassword<-"SomethingDifficult"

Run this program in RStudio:
```
library(RMySQL)
#The connection method below uses a password stored in a variable.  To use this set localuserpassword="The password of newspaper_search_results_user" 
storiesDb <- dbConnect(MySQL(), user='newspaper_search_results_user', password=localuserpassword, dbname='newspaper_search_results', host='localhost')
dbListTables(storiesDb)
dbDisconnect(storiesDb)
```
In the console you should see:
```
[1] "tbl_newspaper_search_results"
```
Success! you have connected to the database.

#### Connecting to the database with a password stored in a configuration file

The above example to connect is one way to make a connection.  The connection method described below stores the database connection information on a configuration file so that you do not have to type a password into a variable every time you start a new session in R. I found this to be a finicky process, but it is a more standard and secure way of protecting the credentials used to log into your database.  This connection method will be used in the code for the remainder of this tutorial, but it can be subsituted with the connection method above.

##### Create the .cnf file to store the MySQL database connection information

1. Open a text editor, like notepad, paste in the items below, changing the password to the one you created for newspaper_search_results_user in the steps you did above to add a user to connect to the database.
```
[newspaper_search_results]
user=newspaper_search_results_user
password=SomethingDifficult
host=127.0.0.1
port=3306
database=newspaper_search_results
```
2. Save this file somewhere outside of your R working directory.  I saved mine in the same folder as other MySQL settings files.  On my machine this was: C:\ProgramData\MySQL\MySQL Server 5.7\  Depending on your operating system and version of MySQL this location may be somewhere else. I have tested putting this file in different places, it just needs to be somewhere R can locate it when the program runs.

3. Update the R program above to connect to the database using the configuration file:
```
library(RMySQL)
#The connection method below uses a password stored in a variable.  To use this set localuserpassword="The password of newspaper_search_results_user" 
#storiesDb <- dbConnect(MySQL(), user='newspaper_search_results_user', password=localuserpassword, dbname='newspaper_search_results', host='localhost')

#R needs a full path to find the settings file
rmysql.settingsfile<-"C:\\ProgramData\\MySQL\\MySQL Server 5.7\\newspaper_search_results.cnf"

rmysql.db<-"newspaper_search_results"
storiesDb<-dbConnect(RMySQL::MySQL(),default.file=rmysql.settingsfile,group=rmysql.db) 
dbListTables(storiesDb)

#disconnect to clean up the connection to the database
dbDisconnect(storiesDb)
```
4. Run your program.

In the console you should see again:
```
[1] "tbl_newspaper_search_results"
```
You have successfully connected to the database using a configuration file.

## Storing data in a table with SQL

In this section of the lesson we'll create a SQL statement to insert a row of data into the database table about this ![newspaper story](http://newspapers.library.wales/view/4121281/4121288/94/).  We'll insert the record first in MySQL workbench and later we'll do it in R.

1. In MySQL Workbench, click the icon labelled SQL+ to create a new SQL tab for executing queries.
2. Paste this statement below into the query window. This will insert a record into the table.
```
INSERT INTO tbl_newspaper_search_results (
story_title,
story_date_published,
story_url,
search_term_used) 
VALUES('THE LOST LUSITANIA.',
'1915-05-21',
LEFT(RTRIM('http://newspapers.library.wales/view/4121281/4121288/94/'),99),
'German+Submarine');
```
3. Click the lightening bolt icon in the SQL tab to execute the SQL statement.
![Inserting a record into a table using MySQL Workbench](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-3.png "Inserting a record into a table using MySQL Workbench")

### Explanation of the INSERT statement

| SQL     | Meaning           |
| ------------- |---------------|
| INSERT INTO tbl_newspaper_search_results ( | INSERT a record into the table named tbl_newspaper_search_results    |
| story_title,     |  name of field to be populated by a value     |
| story_date_published, |  "      |
| story_url,   |  "  |
| search_term_used)    |  "  |
| VALUES('THE LOST LUSITANIA.',  | The value to be inserted into the story_title field   |
|'1915-05-21',   |  story_date_published field  |
| LEFT(RTRIM('http://newspapers.library.wales/view/4121281/4121288/94/'),99),  | story_url field.  This field is a VARCHAR(99) so it has a maximum length of 99 characters.  Inserting a URL longer than 99 characters would cause an error and so two functions are used to control for that.  RTRIM() trims trailing spaces to the right of the URL.  LEFT(value,99) returns only the leftmost 99 characters of the trimmed URL.  This URL is much shorter than that and so these functions are here for an example only.   |
| 'German+Submarine');  | search_term_used field   |

Optional: Modify the INSERT statement above and execute it a few more times.

## Querying data in a table with SQL

In this section of the lesson we'll create a SQL statement to select a row of data from the database table we just inserted.  We'll select the record first in MySQL workbench and later we'll do it in R.

1. Paste this statement below into a query window in MySQL workbench. This will select records from the table.
```
SELECT story_title FROM tbl_newspaper_search_results;
```
2. Highligh the SELECT statement and click the lightening bolt icon in the SQL tab to execute it. You should see the story title "THE LOST LUSITANIA." in the Result Grid. See below.
![Selecting records from a table using MySQL Workbench](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-4.png "Selecting records from a table using MySQL Workbench")

Optional: Modify the SELECT statement above by changing the fields selected and run it again. Add more than one field to the SELECT statement and run it:
```
SELECT story_title, story_date_published FROM tbl_newspaper_search_results;
```
## Storing data in a table with SQL using R

Let's do this using R! Below is an expanded version of the R program we used above to connect to the database.

```
library(RMySQL)
#The connection method below uses a password stored in a variable.  To use this set localuserpassword="The password of newspaper_search_results_user" 
#storiesDb <- dbConnect(MySQL(), user='newspaper_search_results_user', password=localuserpassword, dbname='newspaper_search_results', host='localhost')

#R needs a full path to find the settings file
rmysql.settingsfile<-"C:\\ProgramData\\MySQL\\MySQL Server 5.7\\newspaper_search_results.cnf"

rmysql.db<-"newspaper_search_results"
storiesDb<-dbConnect(RMySQL::MySQL(),default.file=rmysql.settingsfile,group=rmysql.db) 

#optional - confirms we connected to the database
dbListTables(storiesDb)

query<-"INSERT INTO tbl_newspaper_search_results (
  story_title,
  story_date_published,
  story_url,
  search_term_used) 
VALUES('THE LOST LUSITANIA.',
       '1915-05-21',
       LEFT(RTRIM('http://newspapers.library.wales/view/4121281/4121288/94/'),99),
       'German+Submarine');"

#optional - prints out the query in case you need to troubleshoot it
print (query)

#execute the query on the storiesDb that we connected to above.
rsInsert <- dbSendQuery(storiesDb, query)

#disconnect to clean up the connection to the database
dbDisconnect(storiesDb)
```
In the program above we do two steps to insert a record:
1. Define the INSERT statement in the line beginning with: query<-"INSERT INTO tbl_newspaper_search_results (
2. Execute the INSERT statement stored in the query variable with: rsInsert <- dbSendQuery(storiesDb, query)

Run the program above in R Studio and then execute a SELECT in MySQL Workbench. Do you see the new record you added?

At this point you likely have more than one record with the story title of "THE LOST LUSITANIA." which is fine for testing, but we don't want duplicate data. We will remove the test data and start again.  Using the query window in MySQL Workbench run this SQL statement:
```
TRUNCATE tbl_newspaper_search_results;
```
In the Action Output pane of MySQL Workbench you should see:
```
TRUNCATE tbl_newspaper_search_results	0 row(s) affected	0.015 sec
```
To consolidate what we just did:
1. Run a SELECT statement again.  You should not get any rows back.
2. Re-run the R program above to insert a record.
3. Perform the SELECT statement.  You should see one row of data.

We will be inserting a lot of data into the table using R, so we will add variables to construct the query below.  See the code below #Assemble the query.
```
library(RMySQL)
#The connection method below uses a password stored in a variable.  To use this set localuserpassword="The password of newspaper_search_results_user" 
#storiesDb <- dbConnect(MySQL(), user='newspaper_search_results_user', password=localuserpassword, dbname='newspaper_search_results', host='localhost')

#R needs a full path to find the settings file
rmysql.settingsfile<-"C:\\ProgramData\\MySQL\\MySQL Server 5.7\\newspaper_search_results.cnf"

rmysql.db<-"newspaper_search_results"
storiesDb<-dbConnect(RMySQL::MySQL(),default.file=rmysql.settingsfile,group=rmysql.db) 

#optional - confirms we connected to the database
dbListTables(storiesDb)

#Assemble the query

entryTitle <- "THE LOST LUSITANIA."

entryPublished <- "21 MAY 1916"
#convert the sting value to a date to store it into the database
entryPublishedDate <- as.Date(entryPublished, "%d %B %Y")

entryUrl <- "http://newspapers.library.wales/view/4121281/4121288/94/"

searchTermsSimple <- "German+Submarine"

query<-paste(
  "INSERT INTO tbl_newspaper_search_results (
  story_title,
  story_date_published,
  story_url,
  search_term_used) 
  VALUES('",entryTitle,"',
  '",entryPublishedDate,"',
  LEFT(RTRIM('",entryUrl,"'),99),
  '",searchTermsSimple,"')",
  sep = ''
)

#optional - prints out the query in case you need to troubleshoot it
print (query)

#execute the query on the storiesDb that we connected to above.
rsInsert <- dbSendQuery(storiesDb, query)

#disconnect to clean up the connection to the database
dbDisconnect(storiesDb)
```
Let's test this program:
1. Run a SELECT statement and note the rows you have.
2. Run the R program above to insert another record.
3. Perform the SELECT statement.  You should see an additional row of data.

### SQL Errors:
In R change
```
entryTitle <- "THE LOST LUSITANIA."
```
to
```
entryTitle <- "THE LOST LUSITANIA'S RUDDER."
```
and re-run the program.

In the R Console there is an error:
```
> rsInsert <- dbSendQuery(storiesDb, query)
Error in .local(conn, statement, ...) : 
  could not run statement: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'S RUDDER.',
  '1916-05-21',
  LEFT(RTRIM('http://newspapers.library.wales/view/4' at line 6
```
You can check with a SELECT statement that no record with a story title of THE LOST LUSITANIA'S RUDDER. is in the database.

Apostrophes are part of SQL syntax and we have to handle that case if we have data with apostrophes.  SQL accepts two apostrophes '' in an insert statement to represent an apostrophe in data. We'll handle that by using a gsub function to replace a single apostrophe with a double one, as per below.

```
entryTitle <- "THE LOST LUSITANIA'S RUDDER."
#change a single apostrophe into a double apostrophe
entryTitle <- gsub("'", "''", entryTitle)
```
Now that you have handled the apostrophe in the title of the story, re-run the R program and then check with a SELECT statement in MySQL workbench.

```
SELECT * FROM newspaper_search_results.tbl_newspaper_search_results WHERE story_title = "THE LOST LUSITANIA'S RUDDER.";
```
Once you see your test record, TRUNCATE tbl_newspaper_search_results to remove this test data.

## Storing a comma separated value (.csv) file into a MySQL database

In the next part of the lesson we'll query the database table.  To prepare for that let's load some sample data.

Download these .csv files to your R working directory.
1. [sample-data-allotment-garden.csv](http://jeffblackadar.ca/getting-started-with-mysql/sample-data-allotment-garden.csv)
2. [sample-data-submarine.csv](http://jeffblackadar.ca/getting-started-with-mysql/sample-data-submarine.csv)

In R, execute the following read.csv() function and then see what is in the sampleData data frame.

```
sampleData <- read.csv(file="sample-data-allotment-garden.csv", header=TRUE, sep=",")
sampleData
```
You should see a lot of data, including:
```
                                                                                      story_title
1                                                                                                                                                                             -.&quote;&apos;N&apos;III GARDEN REQUISITES.
<...the result of the data frame results have been removed...>
     story_date_published                                                 story_url   search_term_used
1              1918-05-11  http://newspapers.library.wales/view/3581057/3581061/27/ AllotmentAndGarden
<...the result of the data frame results have been removed...>
```
Note that in this sample data, field name are included in the header for convenience:  story_title, story_date_published,storyy_url and search_term_used.

As noted above, our goal here is to insert the sample data that is now stored in the sampleData data frame into the MySQL table tbl_newspaper_search_results.  We can do this a couple different ways, including looping through each row of the data frame and executing an INSERT command like we did above. Here, we'll use one command to insert all of the rows in sampleData at one time: dbWriteTable:

```
dbWriteTable(storiesDb, value = sampleData, row.names = FALSE, name = "tbl_newspaper_search_results", append = TRUE ) 
```
| Function     | Meaning           |
| ------------- |---------------|
| dbWriteTable(storiesDb, | Use the MySQL database connection storiesDb. |
| value = sampleData,     |  Write the values in the sampleData data frame to the table.   |
| row.names = FALSE, | No row names are specified. |
| name = "tbl_newspaper_search_results", | Insert the values from sampleData into the table tbl_newspaper_search_results.  |
| append = TRUE ) | Append these values to what is in the table already.  If this program is run again, all of the rows in sampleData will be appended to the same table again. |

We're not ready to run dbWriteTable() yet, we need to connect to the database first. Here is the program to do that, as well as load sample-data-submarine.csv too. Go ahead and run this.

```
library(RMySQL)
#The connection method below uses a password stored in a variable.  To use this set localuserpassword="The password of newspaper_search_results_user" 
#storiesDb <- dbConnect(MySQL(), user='newspaper_search_results_user', password=localuserpassword, dbname='newspaper_search_results', host='localhost')

#R needs a full path to find the settings file
rmysql.settingsfile<-"C:\\ProgramData\\MySQL\\MySQL Server 5.7\\newspaper_search_results.cnf"

rmysql.db<-"newspaper_search_results"
storiesDb<-dbConnect(RMySQL::MySQL(),default.file=rmysql.settingsfile,group=rmysql.db) 

#read in the sample data from a newspaper search of Allotment And Garden
sampleData <- read.csv(file="sample-data-allotment-garden.csv", header=TRUE, sep=",")

dbWriteTable(storiesDb, value = sampleData, row.names = FALSE, name = "tbl_newspaper_search_results", append = TRUE ) 

#read in the sample data from a newspaper search of German+Submarine
sampleData <- read.csv(file="sample-data-submarine.csv", header=TRUE, sep=",")

dbWriteTable(storiesDb, value = sampleData, row.names = FALSE, name = "tbl_newspaper_search_results", append = TRUE ) 

#disconnect to clean up the connection to the database
dbDisconnect(storiesDb)

```
If you run this more than once, you will have duplicate records.  If that happens, just TRUNCATE the table and run the program again, but only once.

## Selecting data from a table with SQL using R

The program below queries the database and produces the plot below.  Read through the program to see what is happening.
```
library(RMySQL)

rmysql.settingsfile<-"C:\\ProgramData\\MySQL\\MySQL Server 5.7\\newspaper_search_results.cnf"

rmysql.db<-"newspaper_search_results"
storiesDb<-dbConnect(RMySQL::MySQL(),default.file=rmysql.settingsfile,group=rmysql.db) 

searchTermUsed="German+Submarine"
#Query a count of the number of stories matching searchTermUsed that were published each month
query<-paste("SELECT (
  COUNT(CONCAT(MONTH(story_date_published),' ',YEAR(story_date_published)))) as 'count' 
  FROM tbl_newspaper_search_results 
  WHERE search_term_used='",searchTermUsed,"' 
  GROUP BY YEAR(story_date_published),MONTH(story_date_published) 
  ORDER BY YEAR(story_date_published),MONTH(story_date_published);",sep="")

rs = dbSendQuery(storiesDb,query)
dbRows<-dbFetch(rs)
#Put the results of the query into a time series
qts1 = ts(dbRows$count, frequency = 12, start = c(1914, 8)) 
#Plot the qts1 time series data with line width of 3 in the color red.
plot(qts1, lwd=3,col = "red", 
     xlab="Month of the war",
     ylab="Number of newspaper stories", 
     main=paste("Number of stories in Welsh newspapers matching the search terms listed below.",sep=""),
     sub="Search term legend: Red = German+Submarine. Green = Allotment And Garden.")

searchTermUsed="AllotmentAndGarden"
#Query a count of the number of stories matching searchTermUsed that were published each month
query<-paste("SELECT (
  COUNT(CONCAT(MONTH(story_date_published),' ',YEAR(story_date_published)))) as 'count' 
  FROM tbl_newspaper_search_results 
  WHERE search_term_used='",searchTermUsed,"' 
  GROUP BY YEAR(story_date_published),MONTH(story_date_published) 
  ORDER BY YEAR(story_date_published),MONTH(story_date_published);",sep="")

rs = dbSendQuery(storiesDb,query)
dbRows<-dbFetch(rs)
#Put the results of the query into a time series
qts2 = ts(dbRows$count, frequency = 12, start = c(1914, 8))
#Add this line with the qts2 time series data to the the existing plot 
lines(qts2, lwd=3,col="darkgreen")

dbDisconnect(storiesDb)
```
### Explanation of the select and plot data program.
The method to connect to the database is explained above.

This program selects two result sets of data and plots them on a graph. One of the result sets is newspaper stories matching the search German+Submarine.  They are queried with this SELECT statement:
```
SELECT (
  COUNT(CONCAT(MONTH(story_date_published),' ',YEAR(story_date_published)))) as 'count' 
  FROM tbl_newspaper_search_results 
  WHERE search_term_used='",searchTermUsed,"' 
  GROUP BY YEAR(story_date_published),MONTH(story_date_published) 
  ORDER BY YEAR(story_date_published),MONTH(story_date_published);
```
| SQL     | Meaning           |
| ------------- |---------------|
|SELECT (| SELECT data matching the condition in the WHERE clause FROM the database table named. |
|COUNT(CONCAT(MONTH(story_date_published),' ',YEAR(story_date_published))) as 'count' |This provides a count of the number of stories published that share the same month and year publishing date. CONCAT stands for concatenate which creates a single text value from two or more separate text values, in this case the month and the year. |
|FROM tbl_newspaper_search_results |This is the database table we're selecting data from.|
|GROUP BY YEAR(story_date_published),MONTH(story_date_published) | This GROUP BY statement is important for the COUNT above. Here the data is grouped by month and year so that we can count all of the records in the group.
|ORDER BY YEAR(story_date_published),MONTH(story_date_published);|This puts the result set in order by date, which is useful since we want to make a graph by date.|

The statements below run the query and puts the result set rs into data frame dbRows
```
rs = dbSendQuery(storiesDb,query)
dbRows<-dbFetch(rs)
```

Below the data frame dbRows is put into a time series with the ts() function so that it can be plotted for each month, starting from August 1914.
```
#Put the results of the query into a time series
qts1 = ts(dbRows$count, frequency = 12, start = c(1914, 8)) 
```
Below, the data in the qts1 time series is plotted on a graph
```
plot(qts1, lwd=3,col = "red", 
     xlab="Month of the war",
     ylab="Number of newspaper stories", 
     main=paste("Number of stories in Welsh newspapers matching the search terms listed below.",sep=""),
     sub="Search term legend: Red = German+Submarine. Green = Allotment And Garden.")
```
What is different about the part of the program that plots the stories matching the search "Allotment And Garden"? Not very much at all.  We just use the lines() function to plot those results on the same plot we made above.
```
lines(qts2, lwd=3,col="darkgreen")
```
### Results of the select and plot data program.
Below is what the plot should look like:

![Plot of number of newspaper stories published each month matching search terms.](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-5.png "Plot of number of newspaper stories published each month matching search terms.")



## Conclusion
I hope that you now have the knowledge to set up a database table, connect to it and store records. Although we have only scratched the surface of the different ways to query data, I also hope that you now know the technique of using SELECT statements so that you can use them in your future digital history projects.



## Credits and Citation

Jason A. French provides a rationale of why to use MySQL with R in his blog entry, [Using R With MySQL Databases](http://www.jason-french.com/blog/2014/07/03/using-r-with-mysql-databases/).

## References

Ullman, L. 2005. *PHP and MySQL for dynamic web sites, 2nd ed.* Berkeley, Calif: Peachpit.

