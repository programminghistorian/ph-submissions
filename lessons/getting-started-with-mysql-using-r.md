---
title: Introduction to MySQL with R
authors:
- Jeff Blackadar
date: 2017-11-05
editors:
- Amanda Visconti
reviewers:
- TBD
layout: lesson
difficulty: 1
---

This lesson is for you if you want to store data from your digital history projects in a structured and permanent place. We will use a database called MySQL to store data.

By the end of this lesson you will be able to install a database system on your computer, create a database table, store information in the table and then use the data for things like sorted lists and calculations. At the conclusion of the lesson we'll use a query of the database to make a nice looking graph.

We are using the R computer language for the examples, but the techniques can be used with other languages such as Python.

To do this lesson you will need a computer with R and RStudio installed on it and where you have permission to install more software. We will be installing some components of a database system called MySQL and it works on Windows, Mac and Linux.

Some knowledge of the R language, installing software as well as organizing data into fields is helpful for this lesson which is of medium difficulty.


# Table of Contents

- [Getting Started With MySQL](#getting-started-with-mysql)
- [Introduction](#introduction)
- [Required Software](#required-software)
  * [R](#r)
  * [RStudio](#rstudio)
  * [MySQL](#mysql)
    + [Downloading and Installing MySQL](#downloading-and-installing-mysql)
    + [MySQL Community Server](#mysql-community-server)
      - [Download install file for MySQL Community Server](#download-install-file-for-mysql-community-server)
      - [Installation of MySQL Community Server](#installation-of-mysql-community-server)
        * [Installation tips for a PC:](#installation-tips-for-a-pc-)
          + [Choosing a Setup Type](#choosing-a-setup-type)
          + [Check Requirements](#check-requirements)
          + [Type and Networking](#type-and-networking)
          + [Type and Networking](#type-and-networking-1)
          + [Accounts and Roles](#accounts-and-roles)
          + [Windows Service](#windows-service)
          + [Root password](#root-password)
        * [Installation tips for a Mac:](#installation-tips-for-a-mac-)
          + [MySQL Workbench downloads:](#mysql-workbench-downloads-)
- [Create a database](#create-a-database)
- [Add a table](#add-a-table)
  * [Add columns to the table](#add-columns-to-the-table)
  * [Add a user to connect to the database](#add-a-user-to-connect-to-the-database)
- [Create an R program that connects to the database](#create-an-r-program-that-connects-to-the-database)
  * [Connecting to the database with a password.](#connecting-to-the-database-with-a-password)
    + [Connecting to the database with a password stored in a configuration file](#connecting-to-the-database-with-a-password-stored-in-a-configuration-file)
      - [Create the .cnf file to store the MySQL database connection information](#create-the-cnf-file-to-store-the-mysql-database-connection-information)
- [Storing data in a table with SQL](#storing-data-in-a-table-with-sql)
  * [Explanation of the INSERT statement](#explanation-of-the-insert-statement)
  * [Querying data in a table with SQL](#querying-data-in-a-table-with-sql)
  * [Storing data in a table with SQL using R](#storing-data-in-a-table-with-sql-using-r)
    + [SQL Errors:](#sql-errors-)
- [Storing a comma separated value (.csv) file into a MySQL database](#storing-a-comma-separated-value--csv--file-into-a-mysql-database)
- [Selecting data from a table with SQL using R](#selecting-data-from-a-table-with-sql-using-r)
  * [Explanation of the select and plot data program.](#explanation-of-the-select-and-plot-data-program)
    + [Results of the select and plot data program.](#results-of-the-select-and-plot-data-program)
- [Conclusion](#conclusion)
- [Credits and Citation](#credits-and-citation)
- [References](#references)
- [Endnotes](#endnotes)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

# Getting Started With MySQL

# Introduction

For a recent undergraduate course in digital history our class was working with the [Shawville Equity newspaper](http://numerique.banq.qc.ca/patrimoine/details/52327/2553732). After a few days of research through the digital copies of The Equity my mouse hand was cramped and my eyes were strained. I thought that making an index of all the issues, or as I called it, a finding aid, would make it easier to look up topics without having to open each edition individually and scan through it.  

The [first finding aid](http://jeffblackadar.ca/hist3814o_final/equityeditions.html) I made was an html file listing the dates of the editions with links to the digital copy.  Later I added the most common words that appeared in each edition. This version of the [finding aid](http://www.jeffblackadar.ca/hist3814o_final/equityeditions_withtopics.html) was 4.3 mb in size, which is too large a file to easily download.

I wanted to make further improvements to the finding aid by using natural language processing (NLP) of The Equity in R. Natural language processing uses a computer program to examine the language of text in a manner similar to how humans would read it.  NLP can be used to, for example, extract the names of people, locations and organizations found in text as per [Lincoln Mullen’s lesson](https://rpubs.com/lmullen/nlp-chapter)[^1] on the Rpubs website. Given the existence of thousands of person, location and organization entities present in over 6000 editions of The Equity, using static html files to present the finding aid would be impractical because the files would either be too large to download or too numerous to maintain on a web site.  I decided to use a relational database, a structured way of storing data on a computer so that it remains organized and can be retrieved.  The database would allow me to publish the finding aid to a website where it could be searched using a form.  

Using a database also offered the ability to recover from errors when my R program stopped during processing.  Since the database stores the most recently processed work, the R program was able to begin from where it left off before it ran into an error. This was very important because I did not want to waste days of processing by starting over from the beginning. This lesson is an introduction to using the MySQL relational database with R in a similar way I used to create the finding aid I worked on.

MySQL is a relational database used to store and query information. This lesson will use the R language to provide a tutorial and examples to:
 - Set up and connect to a table in MySQL.
 - Store records to the table.
 - Query the table.

R can perform analysis and data storage without the use of a relational database. However, there are times when databases are very useful including:
 - Placing the results of an R program on a web site where the data can be interacted with.
 - Handling large amounts of data.
 - Storing the results of long running programs so that a program can continue from where it left off in case it was interrupted. 
 
A further short discussion of this is on [Jason A. French's blog](http://www.jason-french.com/blog/2014/07/03/using-r-with-mysql-databases/)[^2].

In this tutorial you will make a database of newspaper stories that contain words from a search of a newspaper archive. The program will store the title, date published and URL of each story in a database. We'll use another program to query the database and look for historically significant patterns. Sample data will be provided from the [Welsh Newspapers Online](http://newspapers.library.wales) newspaper archive.

# Required Software
R, R Studio, MySQL Server and MySQL Workbench are required for this lesson.  Notes on installing these software packgages are below.

## R
In their lesson [Basic Text Processing in R](https://programminghistorian.org/lessons/basic-text-processing-in-r)[^3], Taylor Arnold and Lauren Tilton provide an excellent summary of the knowledge of R required for this lesson.  Only basic knowledge of R is assumed.

Taryn Dewar's lesson ['R Basics with Tabular Data']( http://programminghistorian.org/lessons/r-basics-with-tabular-data)[^4]
covers how to install R and become familliar with it.

You can download R from the [Comprehensive R Archive Network](https://cran.r-project.org/). Click on the link that matches your computer's operating system. Select *base* to install R for the first time. Once downloaded, click on the file to run the installer.

## RStudio
Examples in this lesson use RStudio which is software used for writing and running R programs.  Download and install RStudio from [rstudio.com](https://www.rstudio.com/products/rstudio/#Desktop). Since RStudio is open source, select the free version of RStudio desktop then scroll down and click on the *Installers for Supported Platforms* that match your computer's operating system. Once downloaded, click on the file to run the installer.

## MySQL

### Downloading and Installing MySQL

In this section we are going to install MySQL which is the system that holds the database as well as MySQL Workbench which is where you will work to set up the structure of the database.

Complete these instructions to install MySQL Community Server and MySQL Workbench on your computer.

### MySQL Community Server

This is the server where the database is stored.  It needs to be installed and started for your to connect to it and store data.  Below we will download the files, install and start the server.

#### Download install file for MySQL Community Server
Click on this link: [https://dev.mysql.com/downloads/mysql/](https://dev.mysql.com/downloads/mysql/). Scroll down and click to **Select Operating System** that matches your computer.  If necessary, **Select OS Version**.  Once you have done that click the blue **Download** button.  On the download page, scroll down, you have the option of starting the download by clicking **No thanks, just start my download.**

#### Installation of MySQL Community Server
Here are the MySQL Installation instructions:  https://dev.mysql.com/doc/workbench/en/wb-installing.html

Below are tips on the installation:

##### Installation tips for a PC:

Once the file is downloaded, double click on the downloaded file to install it.  Follow the prompts to accept the licence.

After the products are installed, you will be prompted for options:

###### Choosing a Setup Type
Select: **Developer Default**. This *installs the MySQL Server and the tools required for MySQL application development. This is useful if you intend to develop applications for an existing server.*
(See below)
![Setup Type: Developer Default](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-6.png "")

###### Check Requirements
Click the **Execute** button if your have *failing requirements* listed under Check Requirements. Your list may be different. Once the execute process installs the missing requirements click the Next button.
(See below)
![Click the Execute button, if needed.](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-16.png "")

###### Type and Networking 
Select: **Standalone MySQL Server**
(See below)
![Select: Standalone MySQL Server](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-7.png "")

###### Type and Networking
Config type: Select: **Development Machine**
Check: TCP/IP.  Port number: 3306.
(See below)
![Development Machine TCP/IP port 3306](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-8.png "")

###### Accounts and Roles
Write down and then type in a password for root.
![Write down and then type in a password for root.](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-9.png "")

###### Windows Service
Settings here are optional, but I find it easier to set up MySQL as a Windows Service and have it start automatically. You can change your Windows Service settings later to start the MySQL service manually so that it does not start when you don't need it.

![MySQL as a Windows Service](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-10.png "")

Click the Execute and Next buttons to finish the installation and start the server.  

###### Root password
When prompted for the root password, enter the root password you wrote down in the step above.
(See below)
![Root password](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-15.png "")

Look in the Start menu under MySQL for MySQL Workbench.  If it is there, click to launch.  If not, click on MySQL Installer - Community to re-run the installation and add MySQL Workbench to the installed products.

##### Installation tips for a Mac:

Once the file is downloaded, double click on the downloaded file to install it.  Follow the prompts to accept the licence and installation location.  **Important: There will be a prompt for a temporary root password.  Write this down carefully.**  If you make an error, you can remove the installed server and reinstall it, but that is a minor hassle.

Once installed, we are going to change the root password for the MySQL server.


1. Open a terminal window

2. Change the directory to /usr/local/mysql/bin/mysql
3. Start a MySQL session:
```
mysql --user=root --password=[the_root_password_you_wrote_down_above]
```
4. Set the root password to a new password.  Write this down carefully.
```
MYSQL> SET PASSWORD=PASSWORD('[your_new_password_you_just_wrote_down]');
```
5. Start the server.
```
$ sudo /usr/local/mysql/support-files/mysql.server start

```

###### MySQL Workbench downloads:
Click on this link: [http://dev.mysql.com/downloads/workbench/](http://dev.mysql.com/downloads/workbench/). Scroll down and click to **Select Operating System** that matches your computer.  If necessary, **Select OS Version**.  Once you have done that click the blue **Download** button.  On the download page, scroll down, you have the option of starting the download by clicking **No thanks, just start my download.**


# Create a database
Open MySQL Workbench.  Double-click on the *Local Instance MySQL57*  You should see a screen similar to the picture below.

Using MySQL Workbench perform these steps:
1. In the **Query window** type:
```
CREATE DATABASE newspaper_search_results;
```
2. Run the CREATE DATABASE command.  Click on the **lightning bolt** or using the menu, click Query | Execute Current Statement.
3. Beside **SCHEMAS**, if necessary, click the refresh icon.
4. The new database **newspaper_search_results** should be visible under SCHEMAS

(See below:)

![Creating a database in MySQL Workbench](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-1.png "Creating a database in MySQL Workbench")


In the Query window type:
```
USE newspaper_search_results;
```
The USE statement informs MySQL Workbench that you are working with the newspaper_search_results when you run commands.

# Add a table

1. In MySQL Workbench, look in the left side in the **Navigator** panel, under **SCHEMAS** for **newspaper_search_results**.
2. Right-click on **Tables** and click **Create Table**.
3. for **Table Name:** type **tbl_newspaper_search_results**

## Add columns to the table

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
1. Login Name: **newspaper_search_results_user**
2. Authentication Type: select **Standard**
3. Limit to Hosts Matching: **Localhost**
4. Enter and confirm a password *SomethingDifficult*
5. Click on the **Administrative Roles** tab.  Make sure nothing is checked.  This account is for accessing the database only.
6. Click on the **Schema Priviledges** tab and click **Add Entry**
7. In the **New Schema Priviledge Definition** diablog box, click the **Selected schema:** radio button and select **newspaper_search_results**.
8. Click all of the Object Rights: SELECT, INSERT, UPDATE, DELETE, EXECUTE, SHOW VIEW as per the image below.
9. Click the **Apply** button.

![setting permissions for new account.](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-2.png "setting permissions for new account")

Some computers, like my testing laptop, don't display the **Schema Priviledges** panel correctly.  In that case, you can accomplish the above with a script using the Query Window.  Only run the first line to CREATE USER if you did not do that already. 

```
CREATE USER 'newspaper_search_results_user'@'localhost' IDENTIFIED BY 'SomethingDifficult';
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE, SHOW VIEW ON newspaper_search_results.* TO 'newspaper_search_results_user'@'localhost';
```



# Create an R program that connects to the database

In RStudio create a program named newspaper_search.R (File|New File|R Script)

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

## Connecting to the database with a password.

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

### Connecting to the database with a password stored in a configuration file

The above example to connect is one way to make a connection.  The connection method described below stores the database connection information on a configuration file so that you do not have to type a password into a variable every time you start a new session in R. I found this to be a finicky process, but it is a more standard and secure way of protecting the credentials used to log into your database.  This connection method will be used in the code for the remainder of this tutorial, but it can be subsituted with the connection method above.

#### Create the .cnf file to store the MySQL database connection information

1. Open a text editor, like notepad, paste in the items below, changing the password to the one you created for newspaper_search_results_user in the steps you did above to add a user to connect to the database.
```
[newspaper_search_results]
user=newspaper_search_results_user
password=SomethingDifficult
host=127.0.0.1
port=3306
database=newspaper_search_results
```
2. Save this file somewhere outside of your R working directory.  I saved mine in the same folder as other MySQL settings files.  On my machine this was: C:\ProgramData\MySQL\MySQL Server 5.7\  Depending on your operating system and version of MySQL this location may be somewhere else. I have tested putting this file in different places, it just needs to be somewhere R can locate it when the program runs. Name the file **newspaper_search_results.cnf**.

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

# Storing data in a table with SQL

In this section of the lesson we'll create a SQL statement to insert a row of data into the database table about this [newspaper story](http://newspapers.library.wales/view/4121281/4121288/94/).  We'll insert the record first in MySQL workbench and later we'll do it in R.

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

## Explanation of the INSERT statement

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

We will be inserting a lot of data into the table using R, so we will add variables to construct the query below.  See the code below the *#Assemble the query* remark.
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

# Storing a comma separated value (.csv) file into a MySQL database

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
Note that in this sample data, field names are included in the header for convenience:  story_title, story_date_published,storyy_url and search_term_used.

As noted above, our goal here is to insert the sample data that is now stored in the sampleData data frame into the MySQL table tbl_newspaper_search_results.  We can do this a couple different ways, including looping through each row of the data frame and executing an INSERT command like we did above. Here though, we'll use one command to insert all of the rows in sampleData at one time: *dbWriteTable*.

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

# Selecting data from a table with SQL using R

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
## Explanation of the select and plot data program.
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

The statements below run the query and puts the result set *rs* into data frame *dbRows*
```
rs = dbSendQuery(storiesDb,query)
dbRows<-dbFetch(rs)
```

Below the data frame *dbRows* is put into a time series with the *ts()* function so that it can be plotted for each month, starting from August 1914.
```
#Put the results of the query into a time series
qts1 = ts(dbRows$count, frequency = 12, start = c(1914, 8)) 
```
Below, the data in the *qts1* time series is plotted on a graph
```
plot(qts1, lwd=3,col = "red", 
     xlab="Month of the war",
     ylab="Number of newspaper stories", 
     main=paste("Number of stories in Welsh newspapers matching the search terms listed below.",sep=""),
     sub="Search term legend: Red = German+Submarine. Green = Allotment And Garden.")
```
What is different about the part of the program that plots the stories matching the search "Allotment And Garden"? Not very much at all.  We just use the *lines()* function to plot those results on the same plot we made above.
```
lines(qts2, lwd=3,col="darkgreen")
```
### Results of the select and plot data program.
Below is what the plot should look like:

![Plot of number of newspaper stories published each month matching search terms.](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-5.png "Plot of number of newspaper stories published each month matching search terms.")



# Conclusion
I hope that you now have the knowledge to set up a database table, connect to it and store records. Although we have only scratched the surface of the different ways to query data, I also hope that you now know the technique of using SELECT statements so that you can use them in your future digital history projects.



# Credits and Citation

I completed this lesson thanks to the suport of the [George Garth Graham Undergraduate Digital History Research Fellowship](http://grahamresearchfellow.org/).

Jason A. French provides a rationale of why to use MySQL with R in his blog entry, [Using R With MySQL Databases](http://www.jason-french.com/blog/2014/07/03/using-r-with-mysql-databases/).

The R program I used to gather the sample data is [here](https://github.com/jeffblackadar/getting-started-with-mysql/blob/master/newspaper-search-and-store.R).

# References

Ullman, L. 2005. *PHP and MySQL for dynamic web sites, 2nd ed.* Berkeley, Calif: Peachpit.

# Endnotes

[^1]: Lincoln Mullen, "Natural Language Processing," RPubs, [https://rpubs.com/lmullen/nlp-chapter](https://rpubs.com/lmullen/nlp-chapter).

[^2]: Jason A. French, "Using R With MySQL Databases," blog (3 July 2014), [http://www.jason-french.com/blog/2014/07/03/using-r-with-mysql-databases/](http://www.jason-french.com/blog/2014/07/03/using-r-with-mysql-databases/).

[^3]: Taylor Arnold and Lauren Tilton, "Basic Text Processing in R," Programming Historian (27 March 2017), [https://programminghistorian.org/lessons/basic-text-processing-in-r](https://programminghistorian.org/lessons/basic-text-processing-in-r).

[^4]: Taryn Dewar, "R Basics with Tabular Data," Programming Historian (05 September 2016), [http://programminghistorian.org/lessons/r-basics-with-tabular-data](http://programminghistorian.org/lessons/r-basics-with-tabular-data).
