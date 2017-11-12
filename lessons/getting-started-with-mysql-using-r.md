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

*draft* More will be added, edits made, mistakes corrected.  If you have feedback on the draft I welcome it jeffblackadar( at}gmail{dot)com.

# Getting Started With MySQL

## Contents

## Introduction

MySQL is a relational database used to store and query information. This lesson will use the R language to provide a tutorial and examples to:
 - Set up and connect to a table in MySQL.
 - Store records to the table.
 - Query the table.

R can perform analysis and data storage without the use of a relational database. However, there are times when databases are very useful including:
 - Placing the results of an R program on a web site where the data can be interacted with.
 - Handling large amounts of data.
 - Storing the results of long running programs so that a program can continue from where it left off in case it was interrupted. 
 
A further short discussion of this is on ![Jason A. French's blog](http://www.jason-french.com/blog/2014/07/03/using-r-with-mysql-databases/).

In this tutorial you will make a database of newspaper storie that contain words from a search of a newspaper archive. The program will store the title, date published and URL of each story in a database. We'll use another program to query the database and look for historically significant patterns. Sample data will be provided from the ![Welsh Newspapers Online](http://newspapers.library.wales) newspaper archive.

## Downloading and Installing MySQL Workbench

MySQL Installation instructions:  https://dev.mysql.com/doc/workbench/en/wb-installing.html

MySQL Workbench downloads:  http://dev.mysql.com/downloads/workbench/

## Create a database
![Creating a database in MySQL Workbench](http://jeffblackadar.ca/getting-started-with-mysql/getting-started-with-mysql-1.png "Creating a database in MySQL Workbench")

Using MySQL Workbench perform these steps:
1. In the Query window type:
```
CREATE DATABASE newspaper_search_results;
```
2. Run the CREATE DATABASE command.  Click on the lightning bolt or using the menu click Query | Execute Current Statement.
3. Beside SCHEMAS, if necessary, click the refresh icon.
4. The new database newspaper_search_results should be visible under SCHEMAS



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
In general, take your time to think about table design and naming since a well designed database will be easier to work with and understand.
Add these columns
1. **id** Data type: **INT**. Click PK (Primary Key), NN (Not Null) and AI (Auto Increment).  This id column will be used to relate records in this table to records in other tables.
2. **story_title** Data type: **VARCHAR(99)**. This column will store the URL of each result we gather from the search.
3. **story_date_published** Data type: **DATETIME**. This column will store the date the newspaper was published.
4. **story_url** Data type: **VARCHAR(99)**. This column will store the URL of each result we gather from the search.
5. **search_term_used** Data type: **VARCHAR(45)**. This column will store the word we used to search the newspapers.
Click the **Apply** button.

All of this can be done with a command:
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

We will use RMySQL to connect to MySQL.  Documentation is here:

https://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf

If you don't have the library RRMySQL installed, install it using the RStudio Console to run this instruction per below:
```
install.packages("RMySQL")
```
Add this statement to the newspaper_search.R program

```
library(RMySQL)
```

### Connecting to the database with a password.

We will connect to the database at first using a password.  We will use a variable to store the password.  Each time you start R you'll need to reset this variable, but that is a little better than publishing a hardcoded password if you share your programs, like you may do using GitHub.

In the RStudio console type something like below, replacing "SomethingDifficult" with the password you created for newspaper_search_results_user in the steps you did above to add a user to connect to the database.

> localuserpassword<-"SomethingDifficult"

Run this program in RStudio:
```
library(RMySQL)
#The connection method below uses a password stored in a variable.  To use this set localuserpassword="The password of newspaper_search_results_user" 
storiesDb = dbConnect(MySQL(), user='newspaper_search_results_user', password=localuserpassword, dbname='newspaper_search_results', host='localhost')
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

3. Update the R program above to connect to the database and run it:
```
library(RMySQL)
#The connection method below uses a password stored in a variable.  To use this set localuserpassword="The password of newspaper_search_results_user" 
#storiesDb = dbConnect(MySQL(), user='newspaper_search_results_user', password=localuserpassword, dbname='newspaper_search_results', host='localhost')

#R needs a full path to find the settings file
rmysql.settingsfile<-"C:\\ProgramData\\MySQL\\MySQL Server 5.7\\newspaper_search_results.cnf"

rmysql.db<-"newspaper_search_results"
storiesDb<-dbConnect(RMySQL::MySQL(),default.file=rmysql.settingsfile,group=rmysql.db) 
dbListTables(storiesDb)

#disconnect to clean up the connection to the database
dbDisconnect(storiesDb)
```
In the console you should see again:
```
[1] "tbl_newspaper_search_results"
```
You have connected to the database using the settings file.















## Credits and Citation

Made a copy of the sample lesson from here:

https://github.com/programminghistorian/ph-submissions/blob/gh-pages/lessons/sample-lesson.md

Based lesson structure on this:

https://programminghistorian.org/lessons/geoparsing-text-with-edinburgh

Rationale of why to use MySQL with R.

Jason A. French, Using R With MySQL Databases, http://www.jason-french.com/blog/2014/07/03/using-r-with-mysql-databases/

## References

Ullman, Larry. PHP and MySQL For Dyanamic Web Sites

