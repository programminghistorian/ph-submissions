---
title: "Designing a _Timeline_ for the Tabletop and Tabletop Simulator"
slug: designing-a-timeline-tabletop-simulator
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Mita Williams
reviewers:
- Chris Young
- Adam Porter
editors:
- Rolando Rodriguez
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/553
difficulty: TBC
activity: TBC
topics: [topic, topic]
abstract: This lesson demonstrates how to use _nanDECK_ to design and publish either printed or digital playing cards to create your own themed deck to test a play group's understanding of events using the _Timeline_ game mechanic, where players take turns adding cards depicting historical and cultural events in chronological order. In this tutorial, we will create a _Timeline_-like game with a local history theme, with a focus on best practices when handling and using digitized historical objects.
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

We no longer require students to memorize tables of historical events and their respective years of occurrence through the practice of rote learning, as was done in mid-nineteenth century America (Rosenberg). Setting aside the broader arguments for and against teaching chronology in the classroom (Hodkinson and Smith), this lesson is written from the position that it is useful to “help students develop a rich body of knowledge in our content areas” (Lang) and that games are well situated to serve in this pursuit. 

Challenging students to make their own games, or to make a modification ('mod') of an existing game, can provide an opportunity to teach them to manipulate and transform digital objects into physical objects, which you can then further manipulate to share rich, pedagogical experiences. This tutorial will show how students can create their own paper or digital versions of games using the chronology building mechanic popularized by Frederic Henry’s commercial game, _Timeline_. 

Just as authors or publishers use word processors to create printed books, designers of tabletop games regularly use digital tools to create paper prototypes of their work. This tutorial will introduce you to two of these tools: Andrea Nini’s _nanDECK_ and _Tabletop Simulator_, two specialized digital tools used by both amateur and professional game designers.

As an instructor, you will have the opportunity to direct students' attention to the different affordances of paper versus digital versions of the same informational object. Given the ability to play the same game around a physical and a digital tabletop, students can reflect on the ways in which the medium affects the experience of game play. With their new-found ability to modify the assets or pieces of familiar games, students will gain the ability to explore what happens when the rules of well-known games are changed (Zimmerman, 2023).

## Lesson Overview

This lesson begins by briefly considering games as a kind of 'literacy' that can generate real experiences, and by insisting on the value of teaching game design to everyone. It then recognises that tabletop and video games have already been well-established in history classrooms for at least the last half-century.

The lesson then introduces _Timeline_, a commercial history-themed game, as well as some of its variants. Since game mechanics do not fall under copyright protection, you can use the _Timeline_  mechanics to shape your own game, for play or for historical exploration. With the stage set, the tutorial introduces two digital tools commonly used by both amateur and professional game designers: _nanDECK_ and _Tabletop Simulator_. Then, it outlines the steps needed to generate one's own deck of _Timeline_-like cards.

[Instructions on how to install _nanDECK_ follows. _nanDECK_ is free software that generally runs on a Windows PC. Scripts run in _nanDECK_ are used to combine images and labels to produce a set of cards. The lesson begins with an explaination of the main components of a 12-line script that was written to produce a _Timeline_ deck dedicated to the history of Windsor, Ontario, Canada. 

Then the lession steps are repeated, but this time using components that the reader can download to generate a small 6-card deck themselves. The lesson concludes by explaining how _nanDECK_ can be used to generate a PDF that can be easily parsed by _Tabletop Simulator_ to generate digital versions of cards that can be played in their virtual tabletop game environment.]

## Playing in the 'Ludic Century'

In 2013, game designer Eric Zimmerman published a 'Manifesto for a Ludic Century' (Zimmerman, 2015) which includes these tenets:

> **The Ludic Century is an era of games.**
>
> When information is put at play, game-like experiences replace linear media. Media and culture in the Ludic Century is increasingly systemic, modular, customizable, and participatory. Games embody all of these characteristics in a very direct sense.
>
> Increasingly, the ways that people spend their leisure time and consume art, design, and entertainment will be games - or experiences very much like games.
>
> **Games are a literacy.**
>
> Systems, play, design: these are not just aspects of the Ludic Century, they are also elements of gaming literacy. Literacy is about creating and understanding meaning, which allows people to write (create) and read (understand).
>
> New literacies, such as visual and technological literacy, have also been identified in recent decades. However, to be truly literate in the Ludic Century also requires gaming literacy. The rise of games in our culture is both cause and effect of gaming literacy in the Ludic Century.
>
>**In the Ludic Century, everyone will be a game designer.**
>
> Games alter the very nature of cultural consumption. Music is _played _by musicians, but most people are not musicians – they listen to music that someone else has made. Games, on the other hand, require active participation.
>
> Game design involves systems logic, social psychology, and culture hacking. To play a game deeply is to think more and more like a game designer – to tinker, retro-engineer, and modify a game in order to find new ways to play. As more people play more deeply in the Ludic Century, the lines will become increasingly blurred between game players and game designers. 

These particular tenets support the idea that games should be used in the classroom as a means to facilitate learning, and that students would benefit from an introduction to game design which gives them the tools to modify and create their own games.

For the purposes of this paper, the reader does not have to believe that games ought to maintain their long-standing presence in settings of teaching and learning history (McCall). Still, readers unsure about the place of games in education are advised to read the 'Why Games' section of 'Interactive Fiction in the Humanities Classroom: How to Create Interactive Text Games Using Twine' (Kirilloff).

## What are tabletop games?

The category of '[tabletop games]'(https://en.wikipedia.org/w/index.php?title=Tabletop_game) encompasses all physical games played on or around a table. While laypeople may simply separate commercial games between ‘video games’ and ‘board games’, many hobbyists and professionals in the gaming industry prefer the term ‘tabletop games’ over 'board games', as it is encompasses not only board games, but also dice, card, pen and paper, and role-playing games.

In this lesson, you will learn how to make you own version of a tabletop card game called _Timeline_.

### What is _Timeline_?

_Timeline_ is a card game designed by Frédéric Henry, first published in 2012 and still available for purchase through the global game publisher [Asmodee](https://www.asmodee.ca/product/timeline-access/) and its subsidiary [Zygomatic](https://www.dobblegame.com/en/games/#category-timeline). _Timeline_ can be played with 2 to 8 players. As it is a very simple game to learn to play with a group, _Timeline_ is frequently described as a party game as much as an educational game. The game is published in several languages and in a number of differently themed versions, including _Timeline: Inventions_, _Timeline: Music and Cinema_, _Timeline: American History_, and _Timeline Star Wars_.

> **_Timeline_** is a card game where each card depicts a specific historical event, invention or discovery, but only one side displays the year in which that event occurred. Players take turns placing a card from their hand in a row on the table. After placing the card, the player flips it to reveal the date on the back. If the card was placed in chronological order of all the other cards on the table, it stays in place; otherwise the card is removed from play and the player takes another card from the deck. The first player to get rid of all their cards by placing them correctly wins.

The game mechanic of adding cards to a chronological series is not exclusive to _Timeline_. In 2020, Tom James Watson published the single player, online game [_Wikitrivia_](https://en.wikipedia.org/wiki/Wikitrivia), in which you try to beat your own 'streak' of cards successfully added to a timeline of historical events pulled from Wikidata and Wikipedia. In August of 2023, The New York Times launched a beta version of a weekly history quiz called [_Flashback_](https://www.nytimes.com/interactive/2024/01/26/upshot/flashback.html) which requires players to organize eight historical events into chronological order (Leonhardt). 

Game variations of _Timelines_ like _Wikitrivia_ and _Flashback_ are permissible under American copyright law because game rules are not copyrightable. Section 102(b) of the Copyright Act states: 'In no case does copyright protection for an original work of authorship extend to any idea, procedure, process, system, method of operation, concept, principle, or discovery, regardless of the form in which it is described, explained, illustrated, or embodied in such work' (Boyden).

## Why play _Timeline_ in the classroom?

Playing a game in the classroom can provide a low-stakes opportunity for students to test their knowledge outside of a formal assessment process and its associated pressures. _Timeline_ not only challenges players by asking them if they have an understanding of the chronology of the events depicted on the cards in front of them, but it also demands some degree of metacognition, since skillful play requires students to assess their own confidence of the facts at hand (_Timeline & Stag Hunt_). 

### How to Make Your Own Version of _Timeline_ With Index Cards

To make a game that mimics the _Timeline_ mechanic, all you need is a small set of cards. You can make your own cards by folding a sheet of paper in half, three times over, before cutting the paper along the fold lines into eighths. Or, you can buy and use a stack of index cards. On the front of each card, write down only the name of the event in question and, on the back, write down the name and the year of the event. 

In 2018, I made a small deck of _Timeline_ cards using index cards for my family. Inspired by my children’s fascination with the character dance emotes from the video game _Fortnite_ (when those dances suddenly became ubiquitous on professional sports fields and on playgrounds around the world), I looked up the origin year of dances like The Twist, The Carleton, and The Nae Nae, and I built a small deck of cards with their names and years. I played the game with my family and it was an enjoyable experience for everyone. Even though I did not play the game myself, since I knew the answers, I enjoyed watching my children attempts to remember and use logic to guess the chronology of the different dances they knew. 

In this instance of casual gameplay, the hand-made cards were satisfying enough to have an enjoyable experience. That being said, the cards I made could have beeen much improved upon by adding photographs of the dances, providing additional contextual cues to help my children make educated guesses about when the photo was taken. However, the work of collecting images, printing copies, cutting them out, and then transferring them to cards would have taken a significant amont effort and time. Helpfully, there exist a number digital tools that we can use to facilitate this work. 

## Why Generate and Share Your Own Version of _Timeline_ with Digital Tools in the Classroom

There are compelling reasons for learning methods to design, iterate, and produce printed cards with digital tools. Digital templates can be easily altered or amended – for instance, if there was confusion or other unwanted reactions from participants during gameplay. Capturing the design template of a deck of cards in a digital format allows us to quickly retrieve and reproduce the card deck in the future. 

A digital template can also be distributed among a group of people, such as a classroom of students, so that each person can design their own individual cards. When finished, these can be collected and printed together, to form a singular deck. Students can be asked, for example, to create a small set of _Timeline_ cards commemorating events of a particular period of history, perhaps constrained to certain subject or geogrpahical area. A classroom deck could therefore combine a variety of cards based on local sports history, the history of medicine, key moments in architecture, and a selection of paintings. This 'mixing of histories' facilitates one of the most enjoyable experiences of _Timeline_ gameplay – an aspect that is enthusiastically promoted by the game:

>Could you drink champagne when Darwin laid the foundations of the Theory of Evolution? Was the clothes iron invented before or after Man’s first journey into space? Combine your intuition and your history knowledge with the game _Timeline_ (Zygomatic).   

If used in a classroom lesson, this tutorial could be accompanied by librarian guidance or general recommendations for finding appropriate historical images on the internet (Jones). One could also use the opportunity to teach students how to recognize copyright statements from the Creative Commons, to determine whether the images found can be used outside of the 'educational fair use provisions' in the United States, or the 'educational exception of fair dealing' in Canada's Copyright Act (R.S.C., 1985, c. C-42).

## How to Make Your Own Version of _Timeline_ with Digital Tools

At the time of publication, Microsoft makes its web-hosted versions of Word and Excel freely available to anyone who registers with an email address. It is possible to generate and print simple playing cards using Word’s Mail Merge functionality which can import text and locally-hosted images from an Excel file into customized 'labels' (cards) in Word. For the purposes of simple card design, this combination of ubiquity and functionality might be all that’s necessary for the task at hand. 

That being said, you may be interested in using a tool that many amateur and professional game designers, like Elizabeth Hargrave (Ludology), use to produce prototype cards for game testing and game play: _nanDECK_. 

## What is _nanDECK_ and How to use it 

A crucial part of game design involves iterating changes to game cards through a process of playtesting and noting the effects of design alterations. _nanDECK_ is a software for Windows designed to aid game inventors by facilitating the process of designing and printing card decks for prototyping and playtesting. 

The tool was created and made freely available by Andrea 'Nand' Nini. The software has been in development since its version 1.0 release in April 2006, the most recent version (at the time of writing) being _nanDECK_ 1.273, released in November of 2023.

While _nanDECK_ was designed for creating playing cards, the program can also be used to generate graphics for other play objects, including tiles and counters. 

### _nanDECK_ Installation

#### Windows

nanDECK can run on any version of Windows. The [software can be downloaded](https://www.nandeck.com/archives/199), unzipped, and then run, as it does not need to be installed. This means that _nanDECK_ can be run even from a USB stick.

#### Linux

Users with Linux computers can run _nanDECK_ if they install the Windows emulator [Wine](https://www.winehq.org/), as well as the [Microsoft core fonts](https://sourceforge.net/projects/corefonts/files/the%20fonts/).

#### OSX

nanDECK can be downloaded and then run on OSX using the Windows emulator [Wine](https://www.winehq.org/). That being said, those with Apple computers running on MacOS Catalina or later will need to take additional steps, as Wine no longer runs on operating systems that have dropped 32-bit OS support. 

The official _nanDECK_ Manual (Nini) suggests a workaround for MacOS which requires you to [install Winebottler](https://winebottler.kronenberg.org/) and [XQuartz](https://xquartz.macosforge.org/) to run the same version of Windows on an OSX computer. Alternatively, users can consider installing and using _nanDECK_ through an emulator like [Virtual Box](https://www.virtualbox.org/) or through a commercial subscription service such as [Parallels](https://www.parallels.com/ca/products/desktop/). 

### Installation Problems

If you run into installation issues, there are several online forums you can visit where others may offer kind assistance. The author of _nanDECK_, Andrea Nand, is an active participant of the [nanDECK Users Forum on BGG](https://boardgamegeek.com/forum/26631/nandeck-users/general). There is also a smaller, but still active, [community of _nanDECK_ users on Reddit](https://www.reddit.com/r/nanDECK/). 

## How to use _nanDECK_ to Generate Cards

This section will begin with a description of the _nanDECK_ interface and its main components. Then, it will give a 12-line script with careful line-by-line explanations of what the script instructs and how it functions. The example provided in this section was used by the author to generate a set of 58 cards for a _Timeline_-themed deck dedicated to the history of Windsor, Ontario, Canada. This particular example uses a locally-hosted Excel spreadsheet to hold all the cards' labels, along with the image file locations needed to illustrate them. We've also included specific directions for those who prefer to use Google Sheets over Excel. This section also provides links to a set of files that readers can use to generate their own six-card example _Timeline_ deck.

This lesson will only read through the script to produce a _Timeline_-like deck – it will not provide more general instructions on how to use _nanDECK_. For a very useful video introduction to using _nanDECK_, I would recommend Ryan Langewisch's [five-part set of YouTube tutorials](https://www.youtube.com/watch?v=I1IPl3nT1Og&list=PLdHW9On5G8NJm5m1mULabskVYsM84M_SL). Also useful is Andrea Nini's nanDECK Manuel, which is available online in the form of a [188 page PDF document](http://www.nand.it/nandeck/nandeck-manual.pdf). 

### _nanDECK's_ Main Interface

The _nanDECK_ Manual begins with this overview:

> nanDECK is a program capable of creating graphic elements from scripts: every line of a script contains a command, for rendering texts, rectangles, and other graphic elements. The program was made for creating cards, but it can be used for many other graphic objects; each card is treated like a different page, in which you can draw different graphical elements. At the start, you can write the script in the large edit box in the center of the window:

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-1.png" alt="A screenshot of the main interface window of _nanDECK_ Version 127. There are three panes in the window and buttons along the right, bottom and left sides of the screen." caption="Figure 1: A screenshot of the main interface window of _nanDECK_ Version 127" %}

All script commands in _nanDECK_ are composed of a keyword, an equal sign (`=`) and a list of parameters. It is necessary to refer to nanDECK’s Manual to understand what parameters are available for each command. For example, for the command `FONT`, the manual advises:

> FONT
>
> This directive sets the font for any following TEXT command (see page 164). Note that there is not any reference to a range of cards. If you want a ranged command, you can use FONTRANGE instead (see page 105).
>
> Syntax:
>
> FONT = "font name", font size, style, html color font, html color background, outline x, outline y, step x, step y, char space
>
> Parameters:
>
> - "font name": character font name (string)
>
> - font size: character font size, in typographical points (1 point = 1/72 of an inch)
>
> - style: character font style and flag used for visualization; values accepted are:
>
>     B: bold
>     I: italic
>     U: underline
>     S: strikeout
>   …

Knowing the above, we can now understand the code sample below:

```
FONT = Arial, 32, B, #0000FF
```

It sets the font name to Arial, the font size to 32, the font as bold, and the text colour as blue, expressed in hex numerical format.

The `FONT` command is one of the few script types in _nanDECK_ that are applied to every card in the deck. For most _nanDECK_ commands, though, the first parameter will indicate the desired range of cards upon which the command will be executed. For example, the first parameter of `FONT RANGE` is '`range`'. To use bold, blue, Arial font on only the first 20 cards would require this code:

```
FONTRANGE = 1-20, Arial, 32, B, #0000FF
```

Some of the more common elements that can be applied to the design of each card include `BORDER`, `TEXT`, `IMAGE`, `COLOR`, `RECTANGLE` and `CIRCLE`.

_nanDECK_ also allows parameters to be calculated through the use of 'Expressions', delimited by `{` and `}`.

```
TEXT="1-{(FACT)}",\[FACT]
```

## How to Read a _nanDECK_ Script that Generates a Deck of Cards

The fact that a deck of _Timeline_ cards can be generated with only twelve lines of script is a real testament to the power of_nanDECK_.

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-2.png" alt="A screenshot of the main interface window of _nanDECK_ Version 127. In the center pane are 12 lines of instruction in red, blue, green, and black type. In the bottom pane is a log of actions recently made by the software. In the right-side pane is the preview of a card from the generated deck." caption="Figure 2: A screenshot of _nanDECK_ and twelve lines of instruction that has been used to generate a deck of _Timeline_ cards." %}

The next section explains each line of the script to show how components are brought in and assembled into cards. This is the script the author used to generate a deck of 58 _Timeline_ cards marking historical events in the city of Windsor, Ontario, Canada, where she currently resides.

### Line 1: COMMENTS

Text in _nanDECK_ that begins with a semicolon is not interpreted as script, but as a 'comment', or helpful explanation, to the human reader.

```
1. ; This is Windsor _Timeline_ by Mita Williams, a mod inspired by the game _Timeline_ by Frederic Henry
```

It is also possible to add a comment in-line alongside a particular bit of code by doubling the semicolon character:

```
2. PAGE=21,29.7,portrait,HV ;; this sets the page dimensions in CM
```

### Line 2: PAGE

The `PAGE` directive sets the paper’s size and orientation, which will come in useful when creating and printing the PDF .

> Parameters:
>   **width**: page width (in cm)
>   **height**: page height (in cm)
>   **orientation**: the orientation can be chosen between:
>     LANDSCAPE: horizontal
>     PORTRAIT: vertical
>   **flags**: to specify a special behavior for pages, with possible values including:
>     H: the cards are horizontally centered
>     V: the cards are vertically centered

```
2. PAGE=21,29.7,portrait,HV ;; this sets the page dimensions in CM
```

We can read the above line as a directive setting the page size to the metric equivalent of a US standard 8.5” x 11” sheet of paper (21, 29.7), in portrait orientation. _nanDECK_ will understand `HV` as an instruction to make the necessary calculations for cards to be centred both horizontally and vertically.

### Line 3: CARDSIZE

The `CARDSIZE` directive sets the width and height of each card (in cm). 

```
3. CARDSIZE=4,6.5
```

If this line is omitted, the _nanDECK_ applies a default of 6 cm x 9 cm instead. However, cards generated with this default size are oversized compared to standard playing cards, which are 2.5" x 3.5", or 5.71 cm x 8.89 cm. 

For the purposes of this deck, I have opted to create smaller cards, similar to the dimensions of the _Timeline_ cards published by Asomdee.

### Line 4: LINK

`LINK` is used to connect _nanDECK_ to external data that has been formatted either as a text file with comma-separated values (CSV format), or in the form of an Excel spreadsheet (with `.xls` or `.xlsx` extensions). 

You can also `LINK` _nanDECK_ to a Google Sheets spreadsheet by following the additional steps outlined in the _nanDECK_ Manual, under the section for `LINK` (Nini). They are reproduced here:

> You can also link a Google Sheet document, using the ID of the file instead of “filename” parameter, but you must share it first, following these steps:
>
> • select the file in Google Drive web page
> • click the Share icon (the icon with the “little man” in top-right button bar)
> • click the dropdown menu below “Link sharing on” in the window
> • select a link sharing option, one of the “Anyone with the link…” option
>
> Now Google shows you a link like this: `https://docs.google.com/spreadsheets/d/SAMPLE_ID/edit?usp=sharing`

> Copy and paste the link ID into a _nanDECK_ line like this:
> LINK=SAMPLE_ID
>
> You can also select one of the sheets, with this syntax:
> LINK=ID!Sheet_name
> Example:
> LINK=SAMPLE_ID!Beta
> But you must enable the web sharing, with these steps:
> • open the spreadsheet in a browser
> • select from menu File → Publish to the Web
> • click on “Publish” button

Note that _nanDECK_ assumes that the first row of the linked data contains the names of the fields being imported. 

```
LINK = “Windsor-Timeline.xlsx”, “Year”, “Fact”, “Images”
```

If the fields’ names are omitted, the fields are referenced using the names contained in the first row of the file. This applies to our example.

```
4. LINK = "Windsor-Timeline.xlsx"
```
Rather than reproduce the entire spreadsheet, the figure below is a truncated version so you can see the both the beginning and ending rows of this spreadsheet.

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-3.png" alt="A table with three columns: Year, Fact and Images." caption="Figure 3: Windsor-Timeline.xlsx is a spreadsheet with three columns: Year, Fact and Images. Rows 2-6 generate the card faces and rows 7-11 generate the card backs." %}

### Line 5: BORDER

BORDER’s parameters include:

> **type**: the type of border can be chosen between:
> RECTANGLE draws a rectangle (the default)
> ROUNDED draws a rectangle with rounded corners
> MARK draws cut marks
> **html color**: black if not specified
> **thickness**: in cm. The thickness of the border is measured between two cards. This means a thickness of 1 cm will result of a border of 0.5 cm, on each card
> **guidelines**: this is for drawing lines beyond the card’s boundaries to assist in cutting

```
5. BORDER = rectangle, #000000, 0.25, MARKDOT
```

For this example, _nanDECK_ was directed to draw a black rectangle as a border for each card with the addition of dotted cut marks.

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-4.png" alt="In between the top window of instructions and the bottom window of the program's log is text that begins, IMAGE=\"range\", \"image file\", position x, position y, width, and then the word, height, in bold, followed by other variables. In the top window, the mouse cursor is resting on the 6th instruction line, on the number 60\%, which we now understand as the image's height." caption="Figure 4: An example of a page of cards generated by _nanDECK_ with requested black borders between cards and dotted lines to make cutting easier." %}

### Line 6: IMAGE

nanDECK includes a basic Visual Editor that allows for shapes to be drawn and added to cards. For the purposes of this deck, we want to add .jpg images from an external source collected from various digital history collections online and made available on a local file directory.

There are a large variety of parameters and flags associated with the IMAGE directive, as evidenced by its syntax:

> IMAGE = range, image file, pos x, pos y, width, height, angle, flag, alpha, texture width, texture height, skew x, skew y, img width, img height, loc x, loc y, copy x, copy y

Understanding the order of the syntax can help us decipher the IMAGE directive in our script:

```
6. IMAGE="1-{(IMAGES)}",\[IMAGES],0%,0%,100%,60%,0,PTG
```

If we forget or are unsure which number _nanDECK_ is associated with which part of the syntax, you can mouse over the number and _nanDECK_ will add bold to the relevant parameter.

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-5.png" alt="A screenshot of a card with dimensions 472 x 768. The card has a thick black border. The top of the card features a black and white image of a brick church with a large wooden door and branches of a tree that is out of frame. Under the image is, in bold print, 1851. Under this date is the text, 'The cornerstone of Sandwich First Baptist Church is laid on land donated by the Crown'" caption="Figure 5: In between the top window of instructions and the bottom window of the program's log is bolded text that corresponds to the variable that the mouse cursor is currently situated on." %}

_nanDECK_ has a very useful ability to calculate the items in a spreadsheet of a designated value. It does this using an expression that is designated by curly brakets. In this case, _nanDECK_ translates the expression {(IMAGES)} to a caculation of the number of items with a field of an IMAGE. In our example, there are 58 images and so {(IMAGES)} equals 58. Knowing this, we can now understand that this line of script instructs nanDECK to print the images from rows 1 through 58.

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-6.png" alt="A screenshot of a part of an Excel spreadsheet with three columns. In column A, the first four lines have years but the next three entries have none. The middle column features the description of an event to be printed on the card. The last column lists the file location of the image for the card." caption="Figure 6: A card generated using nanDeck." %}

To generate the card above, _nanDECK_ was directed to insert the image found at _Images/Sandwich_First.jpg_ at the 0,0 position and for the image to take up 100% of the width (if possible) and only 60% of the card’s height (if possible). By using the P flag, _nanDECK_ is asked to calculate where the image should be positioned while maintaining the original image’s proportions. Since there are a variety of images in this deck that are of differing proportions, I opted to make all the images grayscale using the G tag to give the cards in the deck some uniformity and cohesion.

### Lines 7 and 9: FONT

nanDECK is able to use the fonts that you have installed on your machine. The below code inputs font formatting:

```
7. FONT=Arial,14,BT,#000000
8. TEXT="1-{(YEAR)}",\[YEAR],25%,60%,52%,9%
9. FONT=Arial,7.5,,#000000
```

In line 7, _nanDECK_ is directed to set the font size as 14 and to make it bold and transparent. After line 8 directs _nanDECK_ to generate text in this font, line 9 with a reduced font size of 7.5. 

Of note, in line 9 there are two commas in a row. This lets _nanDECK_ know that the style parameter is empty and that the text is not being directed to be styled in bold or any other way.

### Lines 8 and 10: TEXT

nanDECK provides a variety of options for writing TEXT on cards:

> TEXT = “range”, “text”, pos x, pos y, width, height, horizontal alignment, vertical alignment, angle, alpha, outline width, circle offset, circle angle, width factor, height factor

For the purposes of our deck, the text decoration has been kept simple, but there was a challenge of text placement. Most playing decks have two sides with one side being the ‘face’ and the other side being the ‘back.’ In many games, most of the relevant information is found on the face of the card, with the the back of the card being decorative or indicative of the card's type. As you may recall, a card in a _Timeline_ deck has two faces: one side with a name or description of an event, and the other side bearing the date of the event.

```
8. TEXT="1-{(YEAR)}",\[YEAR],25%,60%,52%,9%
10. TEXT="1-{(FACT)}",\[FACT],4.5%,68.5%,91%,30%,CENTER,WORDWRAP
```

Line 8 is the script that writes the year on a range from the first to the last card with a 'year' field. Line 10 is the script that writes a description of the event on all of the cards, from the first to last card with a ‘fact’ field. So how does this script produce the cards we need to play _Timeline_?

Rather than use complicated scripting to ensure that the 'year' is only written on one side of a printed card, a simple solution is provide instructions to print everything explicited designated in the linked Excel spreadsheet. In the spreadsheet, the first 58 rows provide designated image, description, and year to be printed on the 'face' and the next 58 rows give instructions to generate the backs of the cards, using an image and only the ‘fact’ field, because the ‘year’ field is left empty.  

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-7.png" alt="Two pages of cards in a grid format. The left hand page of cards feature years printed in bold and the right hand side of cards are the same but without the year printed." caption="Figure 7: The simplest way to have _nanDECK_ generate a card side without the date being printed is to duplicate the information used to make cards without text in the date field." %}

This is admittedly not the most efficient method, as the information needed to generate new cards must be added twice into the spreadsheet (one entry with the year and one entry without), but it does produce the desired end result.

### Lines 11 and 12: DUPLEX and PRINT

One of the greatest strengths of _nanDECK_ is its ability to generate synchronized backs and faces of cards. It does this through the DUPLEX and PRINT directives.

> DUPLEX
> This directive copies a card (or a range of cards) to another position (or range) calculated automatically by the software, it is useful to manage duplicates or synchronize the front face and back of cards for a duplex printing

> DUPLEX = “range front”, “range back”, number

In order to align the cards with years printed on them, it is only necessary to designate their range. In the case of my personal deck, there are 59 unique cards, with the fronts being generated from range 1-59 in my spreadsheet and the backs generated from range, 60-118.

```
11. DUPLEX = 1-59,60-118
12. PRINT = DUPLEX
```

After you Validate the deck and then Build it, you will be shown a preview of the generated cards in the right preview pane. In this display, you might see a surprising number of blank cards. These blank cards are inserted into your deck by _nanDECK_ in order to generate a PDF document that, when printed, will be aligned to create the final set of cards. 

This is why it is recommended to use the 'Print deck' option to make sure that all of cards are being generated properly.

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-8.png" alt="A screenshot of Tabletop Simulator that features an image of an octagon-shaped wooden table obscured by _Timeline_ cards that have been thrown in the air. " caption="Figure 8: Two pages generated by _nanDECK_ for printing. Note that the pages are oriented so that they can be folded together to make matched, double-sided cards." %}

nanDECK can print your deck in a multitude of ways. Each card generated by the program can be saved either as a separate graphical image or as a single PDF for printing, assembling, cutting, and gluing together. Since the common practice of game design involves multiple rounds of observed play-testing that inform iterative changes to a game's design, nanDECK's ability to easily re-generate variations of a deck of cards is valuable (Ludology).

Before you can print your deck, you first must select the 'Validate Deck' button to check the syntax of your script and ensure that it is valid. After your script has been validated, you can press the 'Build Deck' button to generate your deck of cards from the script. Finally, you can use the'Print Deck' button to have _nanDECK_ generate your deck as a PDF file for printing. 


## Build Your Own Timeline

In order to facilate getting started with _nanDECK_ and TTS, I have made available a starter deck of files for you to model or build upon which you can [download from GitHub](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/designing-a-timeline-tabletop-simulator).

The contents of this directory include:
- [`PH_nandeck_Your_Timeline.txt`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/designing-a-timeline-tabletop-simulator/PH_nandeck_Your_Timeline.txt) : The script to open with nanDECK
- [`Build-Your-Own-Timeline.xlsx`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/designing-a-timeline-tabletop-simulator/Build-Your-Own-Timeline.xlsx) : the spreadsheet that the script in _nanDECK_ will use to find the assets to build the deck
- Six `.png` images 

Similar to the example that was walked through above, [`PH_nandeck_Your_Timeline.txt`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/designing-a-timeline-tabletop-simulator/PH_nandeck_Your_Timeline.txt) has three lines of comments and eleven lines long. Unlike the example above, this script links to a Google Sheet instad of an Excel Spreadsheet.

```
1   ; This is a template to create your own mod inspired by the game Timeline by Frederic Henry
2   ; This template generates a deck from a Google Sheet
3   ;
4   PAGE=21,29.7,portrait,HV
5   CARDSIZE=4,6.5
6   LINK = 1lP2mFRcxEsJeDniVy8byPMkwRe7JfkI78OR7NDe9zkU
7   BORDER = RECTANGLE, #000000, 0.25, MARKDOT
8   IMAGE="1-{(IMAGES)}",[IMAGES],0%,0%,100.299%,59.743%,0,PTG
9   FONT=Arial,14,BT,#000000
10  TEXT="1-{(YEAR)}",[YEAR],25%,60%,52%,9%
11  FONT=Arial,7.5,,#000000
12  TEXT="1-{(FACT)}",[FACT],4.5%,68.5%,91%,30%,CENTER,WORDWRAP
13  DUPLEX = 1-6,7-12
14  PRINT = DUPLEX
```

Line 4 tells _nanDECK_ that the page size is the metric equivalent to an 8½ x 11", that it should be oriented in portrait mode, and that the cards generated should be centred in the page, both horitonzally and vertically. Line 5 sets the size of each card in centimeters.  

Line 6 takes advantage of _nanDECK's_ hard-coding that will automatcially interpret the LINK variable as part of a URL to a Google Spreadsheet. "1lP2mFRcxEsJeDniVy8byPMkwRe7JfkI78OR7NDe9zkU" is the understood to be SAMPLE_ID in this URL format: `https://docs.google.com/spreadsheets/d/SAMPLE_ID/edit?usp=sharing`, which _nanDECK_ will translate to [https://docs.google.com/spreadsheets/d/1lP2mFRcxEsJeDniVy8byPMkwRe7JfkI78OR7NDe9zkU/edit?usp=sharing](https://docs.google.com/spreadsheets/d/1lP2mFRcxEsJeDniVy8byPMkwRe7JfkI78OR7NDe9zkU/edit?usp=sharing).

This ability for _nanDECK_ to draw from an external directory of resources means that developing your own version of _Timeline_ or other variation of a card game need not to be a solo endeavour. A entire classroom of students could collect images and facts together in a single shared directory and spreadsheet. The downside of this approach is that the 'secrets' of each others cards would be visible and any subsequent play of the deck would not be a surprise. This is why this lesson suggests that each student make their own deck for printing so that they can combine their cards together and discover what each one has shared through play.

Line 7 describes the border that is requested as to being rectangular, black, 0.25cm thick, and with dotted marks for easier cutting.

Line 8 explains that as for as many images are available, they should be situated on the cards at position 0,0 and take up 100% of the card width and 60% of the card's height, while maintaining the image's proportions, and printing the image in grayscale.

Line 9 tells _nanDECK_ what type and size font that we would like the following text to be printed in, which is, in this case, in bold, black, 14pt Arial, and with a transparent background. 

Line 10 tells _nanDECK_ that for as many Google Sheets rows that hold a field with a YEAR, to print the YEAR in a position that is centred horizontally but a little more than halfway down the card.  

Line 11 sets the font from 14pt to 7.5pt Arial, in black but unbolded. This sets the type for Line 12, which prints, for as many spreadhsheet rows as those with values in them, the FACT, centred, but further down the page than YEAR, and to wrap if the text goes over past the dimensions of the card, while maintaining a border.  

Line 13 and 14 designates that one side of the printed page that will have the first six card 'faces' printed on it and the other side of the page will have the six card 'backs' printed, in such as way that when they were printed duplex or double-sided, that they will align. 

After you have entered the script into the edit window of _nanDECK_ and have validated the script to its satisfaction, you should be able to then use the Build button to create this deck. If successful, your results should look like this [`.pdf` image](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/designing-a-timeline-tabletop-simulator/Your-Timeline-Duplex-Printing-Result.pdf) of what _nanDECK_ should have generated from the script and the assets above.


## Professionally Printing Cards with _nanDECK_

There is also the option to have your cards printed professionally. The creator of _nanDECK_ has established a formal relationship with _Game Crafter,_ an American print-on-demand company that specializes in producing cards and other tabletop game components. There is a button on the _nanDECK_ interface panel that starts the process to upload of _nanDECK_ files to the _Game Crafter_ site for future printing of single sets and limited runs. 

Commercial publishers will not typically print images that they believe are under somebody else’s copyright, even if the game is intended for personal or educational use rather than for commercial sale. Even though my local history version of _Timeline_ was primarily drawn from public domain sources or from collections that had clear licenses allowing for re-use, many of the images that I wanted to use in my cards fell under copyright. As a result, there is a significant chance that a commercial publisher would refuse to publish even a single copy of my game. 

But there are other ways to bring people together to play our new game. 

## Why import your TableTop game into _Tabletop Simulator_

nanDECK also provides tight integration with another platform called _Tabletop Simulator_. _Tabletop Simulator_ is a physics sandbox where up to ten players can manipulate and play with digital game pieces. [_Tabletop Simulator_](https://www.tabletopsimulator.com/) is available on [Steam](https://store.steampowered.com/app/286160/Tabletop_Simulator/) currently for $19.99 USD. 

While _Tabletop Simulator (TTS)_ is not the only digital platform that allows people to gather in front of a shared screen instead of a shared table to play cards and board games, it is a well-known title used by game designers for observing play-testers engaged in early game prototypes. When it is difficult to readily find enough volunteers willing to play a game that is still in early stages of development in one's physical community, game designers have used TTS as a means to to test their new designs with game testers and players are physically dispersed around the world (Hall). Not only does TTS act as a gathering point with those of niche interests, it has been an important outlet for those who want to play tabletop games with others but who are unable to do so in person, due to health vulnerabilites, time, cost, or global pandemic (Boyle). 

## Printing Digital Cards for _Tabletop Simulator_

Once you understand how to import your cards into TTS, your game can become a video game, with no rule-coding necessary. But even though TTS doesn't require knowing how to code to make use of it's open-ended toolbox, TTS is not a simple enviroment that is intutive to use without instruction. Berserk Games, the company that produces TTS, provides a seven-part video tutorial on _YouTube_ to help new players learn how to make games and play games in their environment [https://www.youtube.com/watch?v=6e8RFMtAVac&list=PLA16SF2eexlUtH2AM4V8VF9rDpekW2uYA](https://www.youtube.com/watch?v=6e8RFMtAVac&list=PLA16SF2eexlUtH2AM4V8VF9rDpekW2uYA). 

This tutorial will walk through how I turned my _Windsor Timeline_ deck into a digital format for TTS. Then generalized instructions will be given to explain how the process would be followed using the same game assets that we just used to make a simple 6 card Starter Deck. 

### Printing Card Faces and Card Backs Separately for _Windsor Timeline_

Unlike _nanDECK_ which generates each card separately, _Tabletop Simulator_ requires two image files (one for each side of a deck) to be in a uploaded in standardized format so that it can parse each image into multiple cards. A normal card deck will generally have an illustration on the card 'back' (such as a mosaic pattern), while information and symbols will appear on the card 'face' (such as the 4 of Clubs). So, in other words, TTS requires one image file that portrays all the cards' 'faces' and another image that portrays all the cards' 'backs.'

So before we can upload our _Timeline_ deck into TTS, we will need to regenerate our cards into this required format. To do this, it is necessary to split our original spreadsheet into two spreadsheets. The first spreadsheet will generate the deck's 'face' and as such, will have the necessary information to generate facts, images and years. This spreadsheet will no longer need duplicate entries that missing entries in the 'years' column. The second spreadsheet will be identical to the first with columns for 'Fact' and 'Image', but will not include the 'Year.' 

Then it is necessary to change our script to reflect that the spreadsheets are going to be used to generate one of two files needed by TTS:

First, we are going to change the link variable so that it goes to the spreadsheet that will generate the decks' faces.

```
LINK = "Windsor-Timeline_for_Tabletop_Face.xlsx"
```

As we no longer have to generate one document that meant to be printed and then folded, we can remove these lines from our code:

```
DUPLEX = 1-59,60-118
PRINT = DUPLEX
```

TTS requires image files for each side of a deck to be in a standard format of page of cards that run ten in number across, and seven in number down. This standardization is necessary so the program knows how to calculate where the cards should be parsed into separate images. (If your deck has more than 70 cards, it will be necessary to parse the deck into as many as necessary under the 70 card limit). 

The script that generates this standard is:

```
RECTANGLE=70,0,0,100%,100%,#000000
```

nanDECK then creates a singular image using its command called DISPLAY that is used after the deck is generated. 

```
DISPLAY="Windsor_Timeline_TTS_Face.png"
```

After the 'Validate' button and the 'Build Deck' button, and _nanDECK_ will have generated the image, "Windsor_Timeline_TTS_Front.png" in the current directory. 

The process then would have to be repated to generate the Deck's card 'backs'. The same steps would be followed, but only after changing the script's input so that the filename for LINK to goes "Windsor-Timeline_for_Tabletop_Back.xlsx" and the destination filename for the output, by changing DISPLAY to "Windsor_Timeline_TTS_Back.png". 


### Printing Card Faces and Card Backs Separately for your Starter Deck

In the starter deck of files for you to model or build upon which you can [download from GitHub](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/designing-a-timeline-tabletop-simulator), you can find a folder called [`For Tabletop Simulator`](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/designing-a-timeline-tabletop-simulator/For%20Tabletop%20Simulator). It contains:

- [`PH_nandeck_Your_Timeline_TTS_Face.txt`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/designing-a-timeline-tabletop-simulator/For%20Tabletop%20Simulator/PH_nandeck_Your_Timeline_TTS_Face.txt) : The script to open with _nanDECK_ to generate the image of card faces
- [`PH_nandeck_Your_Timeline_TTS_Back.txt`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/designing-a-timeline-tabletop-simulator/For%20Tabletop%20Simulator/PH_nandeck_Your_Timeline_TTS_Back.txt) : The script to open with _nanDECK_ to generate the image of card backs
- [`Build-Your-Own-Timeline-TTS-Face.xlsx`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/designing-a-timeline-tabletop-simulator/For%20Tabletop%20Simulator/Build-Your-Own-Timeline-TTS-Face.xlsx) : the spreadsheet that the script in _nanDECK_ will use to generate the image of the card faces
- [`Build-Your-Own-Timeline-TTS-Back.xlsx`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/designing-a-timeline-tabletop-simulator/For%20Tabletop%20Simulator/Build-Your-Own-Timeline-TTS-Back.xlsx) : the spreadsheet that the script in _nanDECK_ will use to generate the image of the card back
- [`Your_Timeline_TTS_Face.png`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/designing-a-timeline-tabletop-simulator/For%20Tabletop%20Simulator/Your_Timeline_TTS_Face.png) : the image produced by _nanDECK_ using the assets above to be uploaded into TTS
- [`Your_Timeline_TTS_Back.png`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/designing-a-timeline-tabletop-simulator/For%20Tabletop%20Simulator/Your_Timeline_TTS_Back.png) : the image produced by _nanDECK_ using the assets above to be uploaded into TTS

If we look at the script, [`PH_nandeck_Your_Timeline_TTS_Face.txt`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/designing-a-timeline-tabletop-simulator/For%20Tabletop%20Simulator/PH_nandeck_Your_Timeline_TTS_Face.txt) we can see that _nanDECK_ is no longer instructed to generate a double-sided document meant for printing, but into single png file, [`Your_Timeline_TTS_Face.png`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/designing-a-timeline-tabletop-simulator/For%20Tabletop%20Simulator/Your_Timeline_TTS_Face.png)

```
1   ; This is a template to create your own mod inspired by the game Timeline by Frederic Henry
2   ; This template generates the face of a deck of cards from a Google Sheet and images that are hosted on Google Drive
3   ; This script generates a PDF for uploading into Tabletop Simulator
4   ;
5   PAGE=21,29.7,portrait,HV
6   CARDSIZE=4,6.5
7   LINK = 19abmOKGPc6dixxi38cc1wVDqmMBOYI-2J59qim3wQFw
8   BORDER = RECTANGLE, #000000, 0.25, MARKDOT
9   IMAGE="1-{(IMAGES)}",[IMAGES],0%,0%,100.299%,59.743%,0,PTG
10  FONT=Arial,14,BT,#000000
11  TEXT="1-{(YEAR)}",[YEAR],25%,60%,52%,9%
12  FONT=Arial,7.5,,#000000
13  TEXT="1-{(FACT)}",[FACT],4.5%,68.5%,91%,30%,CENTER,WORDWRAP
14  RECTANGLE=70,0,0,100%,100%,#000000
15  DISPLAY="Your_Timeline_TTS_Face.png",1,55,10
```

You are now ready for _Tabletop Simulator_. 

## Build Your Own _Timeline_ in _Tabletop Simulator_

When you first open _Tabletop_Simulator_, the game asks if you are going to join an existing game or 'Create' a new game. Choose 'Create.' You will be prompted to load a Classic Game, a Digitally Licensed Game, a game from the Steam Workshop, or to 'Save and Load' your own local content. Choose 'Save and Load' and exit out of the screen. 

This should leave you staring at an empty Tabletop. From the top menu options, select 'Objects', then 'Components,' and then 'Cards.' From the options presented, select 'Custom Deck.' This will add a blank deck on your virtual tabletop and you will be given the option to Import your files from _nanDECK_ to create your custom deck (if you don't see this option, right-click on the blank deck). 

From this menu, you will be able to select the image of your deck face from your local drive. Make sure to check the box beside the option, 'Unique backs' and select the image of your deck back file from your computer. Leave the width option at 10, the height option at 7, but do adjust the slider so that it displays the true number of cards in your deck. After these steps are complete, hit the 'Import' button and your deck will be built for your virtual play.

By uploading your deck into TTS, you will be able to play your version of _Timeline_, with up to nine other invited players in an onine environment. Furthermore, if you choose to upload and make your game assets available through the [_Tabletop Simulator's Steam Workshop_](https://steamcommunity.com/app/286160/workshop/), you can add your deck to the over 11,000 sets of cards available to a community of over 2 million TTS customers to play (Bezerk Games). 

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-9.png" alt="Visual description of figure image" caption="Figure 9. While one of the most delightful features of Tabletop Simulator is the ability to flip the table, the ability to throw cards around is also pretty enjoyable." %}


## Conclusion

I would like to end this lesson with another tenet from Eric Zimmerman’s "Manifesto for a Ludic Century":

> **Digital technology has given games a new relevance.**
>
> The rise of computers has paralleled the resurgence of games in our culture. This is no accident. Games like Chess, Go, and Parcheesi are much like digital computers, machines for creating and storing numerical states. In this sense, computers didn’t create games; games created computers.

Zimmerman is not the only one who believes this. Tabletop games have been described as ‘paper computers’ as they are designed by humans and “they enact systems of rules and procedures” (Sayers).

It is hoped that this lesson will help facilitate a possible future in which history students and/or beginning game designers create and generate their own specific modification of _Timeline_, opting to cover a specific aspect of local history or a theme, and then share their work with others. These decks could be combined, so that a deck covering local history could be interspersed with a history of a similar time, but a different place or scope. Through this process, players can discover moments of synchronology and historical overlap that can surprise and delight (e.g. Oxford University is older than the Aztec Empire). 

While it is intended that this lesson will encourage others to create mods of their own of _Timeline_, it is also hoped that this experience will inspire others to create modifications of other existing games. One could imagine creating and adding their own cards to decks, not unlike 'Trivial Pursuit', 'Magic The Gathering', or even 'Uno'. Perhaps the next step would be a brand new game.


## References

Berzerk Games. "Developer & Publisher Information." _Tabletop_Simulator_, 2023, [https://tabletopsimulator.com/contact/publishers](https://tabletopsimulator.com/contact/publishers).

Boyden, Bruce E. _Games and Other Uncopyrightable Systems_. 1580079, 20 Apr. 2011, _Social Science Research Network_, [https://papers.ssrn.com/abstract=1580079](https://papers.ssrn.com/abstract=1580079).

Boyle, B. “How Board Gamers Embraced Tabletop Sims During Lockdown”, 29 May 2020, _Vice_. [https://www.vice.com/en/article/pkybxv/board-games-tabletop-simulator-tabletopia-quarantine](https://www.vice.com/en/article/pkybxv/board-games-tabletop-simulator-tabletopia-quarantine). Accessed 25 Jan. 2024. 

Canada Copyright Act, RSC 1985, c C-42, s 29. 

Hall, C. “Tabletop gaming in 2021 will be defined by these last 12 months of chaos”, 8 Jan. 2021, _Polygon_. (https://www.polygon.com/2021/1/8/22178462/board-games-rpgs-2021-magic-dungeons-dragons-pandemic-black-lives-matter). Accessed 25 Jan. 2024.

Hodkinson, Alan, and Christine Smith. “Chronology and the New National Curriculum for History: Is It Time to Refocus the Debate?” _Education 3-13_, vol. 46, no. 6, Sept. 2018, pp. 700–11. _Taylor and Francis+NEJM_, [https://doi.org/10.1080/03004279.2018.1483804](https://doi.org/10.1080/03004279.2018.1483804).

Jones, R. A. (n.d.). “LibGuides: Free Images from Libraries, Museums, and Archives”. Retrieved January 26, 2024, from [https://libguides.lib.msu.edu/c.php?g=138076&p=7641602](https://libguides.lib.msu.edu/c.php?g=138076&p=7641602).

Kirilloff, G. “Interactive Fiction in the Humanities Classroom: How to Create Interactive Text Games Using Twine”, _Programming Historian_. https://programminghistorian.org/en/lessons/interactive-text-games-using-twine), 2021.

Lang, James M. _Small Teaching: Everyday Lessons from the Science of Learning_. First edition., Jossey-Bass, 2016.

Leonhardt, D. (2023, August 6). “A new Times quiz”. _The New York Times_. [https://www.nytimes.com/2023/08/06/briefing/a-new-times-quiz.html](https://www.nytimes.com/2023/08/06/briefing/a-new-times-quiz.html)

Ludology. _Ludology: Ludology Episode 203 - Winging It_. 203, [https://ludology.libsyn.com/ludology-episode-203-winging-it](https://ludology.libsyn.com/ludology-episode-203-winging-it). Accessed 8 Oct. 2022.

McCall, J. (2016). “Teaching History With Digital Historical Games: An Introduction to the Field and Best Practices”. _Simulation & Gaming_, 47(4), 517–542. [https://doi.org/10.1177/1046878116646693]https://doi.org/10.1177/1046878116646693.

Microsoft. “Mail Merge Using an Excel Spreadsheet.” _Microsoft Support_, 2022, [https://support.microsoft.com/en-us/office/mail-merge-using-an-excel-spreadsheet-858c7d7f-5cc0-4ba1-9a7b-0a948fa3d7d3](https://support.microsoft.com/en-us/office/mail-merge-using-an-excel-spreadsheet-858c7d7f-5cc0-4ba1-9a7b-0a948fa3d7d3).

Nini, Andrea “Nand.” _NanDECK Manual Program Version 1.27 – 2022-07-27_. Andrea “Nand” Nini, 2022, [https://www.nandeck.com/download/204/](https://www.nandeck.com/download/204/).

Rosenberg, Daniel. “Mark Twain Memory-Builder.” _Time OnLine_, 2013, [https://timeonline.uoregon.edu/twain/pleasures.php](https://timeonline.uoregon.edu/twain/pleasures.php).

Sayers, Jentery. _Paper Computers_. 2018, [https://jntry.work/archive/syllabi/508v4/](https://jntry.work/archive/syllabi/508v4/).

“Tabletop game”, 2023, _Wikipedia_, [https://en.wikipedia.org/w/index.php?title=Tabletop_game&oldid=1182212182](https://en.wikipedia.org/w/index.php?title=Tabletop_game&oldid=1182212182).

_Timeline & Stag Hunt_. Directed by Richard Malena-Webber, vol. 8, 2017. _YouTube_, [https://www.youtube.com/watch?v=dZbkxMuBR_I](https://www.youtube.com/watch?v=dZbkxMuBR_I).

Zimmerman, Eric. “Manifesto for a Ludic Century.” _The Gameful World: Approaches, Issues, Applications_, edited by Steffen P. Walz and Sebastian Deterding, The MIT Press, 2015, pp. 19–22.

Zimmerman, Eric. (2022). _The rules we break: Lessons in play, thinking, and design_. Princeton Architectural Press.

Zygomatic, (n.d.), “Games—Dobble”, Retrieved January 26, 2024, from https://www.dobblegame.com/en/games/
