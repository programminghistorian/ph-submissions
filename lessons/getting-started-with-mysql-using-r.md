---
title: Getting Started With MySQL
authors:
- Jeff Blackadar
date: 2017-11-05
reviewers:
- Amanda Visconti
layout: lesson
difficulty: 1
---

*draft* More will be added, edits made, mistakes corrected.  If you have feedback on the draft I welcome it jeffblackadar( at}gmail{dot)com.

## Getting Started With MySQL

## Contents

## Introduction

## Downloading and Installing MySQL Workbench

MtSQL Installation instructions:  https://dev.mysql.com/doc/workbench/en/wb-installing.html

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
1. **tbl_newspaper_search_result_id** Data type: **INT**. Click PK (Primary Key), NN (Not Null) and AI (Auto Increment).  This id column will be used to relate records in this table to records in other tables.
2. **tbl_newspaper_search_result_url** Data type: **VARCHAR(99)**. This column will store the URL of each result we gather from the search.
3. **tbl_newspaper_search_result_date_published** Data type: **DATETIME**. This column will store the date the newspaper was published.
4. **tbl_newspaper_search_results_search_term** Data type: **VARCHAR(45)**. This column will store the word we used to search the newspapers.
Click the **Apply** button.

All of this can be done with a command:
```
CREATE TABLE `newspaper_search_results`.`tbl_newspaper_search_results` (
  `tbl_newspaper_search_result_id` INT NOT NULL AUTO_INCREMENT,
  `tbl_newspaper_search_result_url` VARCHAR(99) NULL,
  `tbl_newspaper_search_result_date_published` DATETIME NULL,
  `tbl_newspaper_search_results_search_term` VARCHAR(45) NULL,
  PRIMARY KEY (`tbl_newspaper_search_result_id`));

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

If you don't have the library RRMySQL installed, install it using the RStudio Console per below:
```
install.packages("RMySQL")
```
Add this statement to the newspaper_search.R program

```
library(RMySQL)
```

### Connecting to the database with a password.

We will connect to the database at first using a password.  Use a variable to store the password.  Each time you start R you'll need to reset this variable, but that;'s a little better than publishing a hardcoded password when you share your programs, like you may do using GitHub.

In the RStudio console type something like below, replacing SomethingDifficult with the password you created for newspaper_search_results_user.

> localuserpassword<-"SomethingDifficult"

Run this program in RStudio
```
library(RMySQL)
mydb = dbConnect(MySQL(), user='newspaper_search_results_user', password=localuserpassword, dbname='newspaper_search_results', host='localhost')
dbListTables(mydb)
```
In the console you should see:
```
[1] "tbl_newspaper_search_results"
```
Success! you have connected to the database.















## Credits and Citation

Made a copy of the sample lesson from here:

https://github.com/programminghistorian/ph-submissions/blob/gh-pages/lessons/sample-lesson.md

Based lesson structure on this:

https://programminghistorian.org/lessons/geoparsing-text-with-edinburgh

## References

Ullman, Larry. PHP and MySQL For Dyanamic Web Sites

