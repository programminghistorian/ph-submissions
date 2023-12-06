---
title: "Designing a Timeline for the Tabletop and Tabletop Simulator"
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
abstract: In Frederic Henry's game _Timeline_, players take turns adding cards depicting historical and cultural events into chronological order. This lesson demonstrates how to use _nanDECK_ to design and publish either printed or digital playing cards to create your own themed deck to test a play group's understanding of events using the _Timeline_ mechanic. In this tutorial, we will create a _Timeline_-like game with a local history theme and will demonstrate good practice in handling and using digitized historical objects.
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

We no longer require students to memorize tables of historical events and their respective years of occurrence through the practice of rote learning as it was done so during the mid-nineteenth century America (Rosenberg). Setting aside the larger arguments for and against teaching chronology in the classroom (Hodkinson and Smith), this lesson is written from the position that it is useful to “help students develop a rich body of knowledge in our content areas” (Lang) and that games are well situated to serve in this pursuit. Challenging students to make their own games or to make a  modification (or mod) of an existing game can provide an opportunity for those students to learn how to manipulate and transform digital objects into physical objects which can be further manipulated and transformed for rich and shared experiences. This tutorial will outline how students can create their own paper or digital versions of games using the chronology building mechanic popularized by Frederic Henry’s commercial game, _Timeline_. Just as word processors are an essential tool for creating printed books, designers of tabletop games regularly use digital tools to create paper prototypes of their developing work. This tutorial will introduce the reader to two of these tools: Andrea Nini’s _nanDECK_ and _Tabletop Simulator_.

## Playing in the Ludic Century

In 2013, game designer Eric Zimmerman published a “Manifesto for a Ludic Century” (Zimmerman) which includes these tenets:

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

These particular tenets were selected to provide some of the reasons why the author is not only suggesting that games should be considered as a means to facilitate learning in the classroom, but that she is suggesting that students could also benefit from an introduction to the tools of game design so that they can learn to modify and make their own games.

## What are Tabletop Games?

Tabletop games are a category of games that encompasses physical games that are generally played on or around a table. While laypeople may separate commercial games between ‘video games’ and ‘board games’, many hobbyists and those within the gaming industry use the term ‘tabletop games’ as the differentiating category for physical objects as it is considered more encompassing than ‘board games’. The category of Tabletop Games contains board games, dice games, card games, pen and paper games, and role-playing games.

In this lesson, we will be exploring how one can make their own versions of a tabletop game called _Timeline_.

## What is _Timeline_?

_Timeline_ is a card game designed by Frédéric Henry that was first published in 2012 and is still available for purchase through the global game publisher, Asmodee. The game of _Timeline_ can be played with 2 to 8 players. As it is a very simple game to learn that can be played with a group of people, _Timeline_ is frequently described as a party game as well as an educational game. The game is published in several languages and there are a number of different themed versions of the game that have been published over the last ten years including, _Timeline: Inventions_, _Timeline: Music and Cinema_, _Timeline: American History_, and _Timeline Star Wars_.

> **_Timeline_** is a card game where each card depicts a historical event, invention or discovery on both sides, with the year in which that event occurred, invention or discovery was made on only one side. Players take turns placing a card from their hand in a row on the table. After placing the card, the player reveals the date on it. If the card was placed correctly with the date in chronological order with all other cards on the table, the card stays in place; otherwise the card is removed from play and the player takes another card from the deck. The first player to get rid of all his cards by placing them correctly wins.

The game mechanic of adding a card into a chronological series is not exclusive to the game of _Timeline_. In 2020, Tom James Watson published _Wikitrivia_ which pulls information and images relating to historical events from Wikidata and Wikipedia, to generate a one-player online version in which you try to beat your own “streak” of cards successfully added to a timeline, before you make your fourth error. Game variations like _Wikitrivia_ are permissible under American copyright law because game rules are not copyrightable. Section 102(b) of the Copyright Act states: “In no case does copyright protection for an original work of authorship extend to any idea, procedure, process, system, method of operation, concept, principle, or discovery, regardless of the form in which it is described, explained, illustrated, or embodied in such work” (Boyden).

## Why play Timeline in the classroom?

Playing a game in the classroom can provide a low-stakes opportunity for students to test their knowledge outside of a formal assessment process and its associated pressures. Games like _Timeline_ not only challenges players by asking them if they have an understanding of the chronology of the events depicted on the cards in front of them, but it also demands some degree of metacognition as skillful play requires players to assess their own confidence of the facts at hand (_Timeline & Stag Hunt_).  

## How to Make Your Own Version of Timeline With Index Cards

To make a card for a game using the timeline mechanic, all you need is a small set of cards. You can make your own cards by folding a sheet of paper in half, three times over and then cut the paper into 8ths. Or you can buy and use a stack of index cards. On one side of each card you write down the name of the event in question and on the other side of the card, you write down the name of the event and the year of the event.  

In 2018, I made a small deck of _Timeline_ cards using index cards for my family. Inspired by my children’s fascination with the character dance emotes from the video game _Fortnite_ when those dances suddenly became ubiquitous on professional sports fields and on playgrounds around the world, I looked up the year of origin for dances like The Twist, The Carleton, and The Nae Nae and I wrote them down on index cards along with their names. After collecting a small deck of cards, I played the game with my family and it was an enjoyable experience for everyone. Even though I could not play the game since I knew the answers, I enjoyed watching my children try to reason out and remember when one dance they knew came before another.  

For this type of casual game-play, the hand-made nature of these cards was not a deterrent to satisfying game play. That being said, the cards I made could be considered much improved upon if I also had included images depicting the dances in question on those cards. Photographs of the dances could provide additional contextual cues to help my kids make educated guesses of approximately when the photo was taken. But I chose not to because I knew that collecting images and transferring them to cards takes effort and a not insignificant amount of time.  

## How to Make Your Own Version of Timeline with Digital Tools

However there are compelling reasons for learning some methods to facilitate the design, iteration, and production of printed cards with digital tools. One of the main reasons is so obvious that it almost escaped mention: capturing the design template of a deck of cards in a digital format and saving that template for later retrieval allows for that deck of cards to be more quickly reproduced in the future for an indefinite amount of times. Furthermore, a digital template can be altered or amended if it has been observed that there was confusion or other unwanted reaction from participants during play-testing or game-play. A digital template can also be distributed among a group of people, such as a classroom of students, so that each person can design their own individual cards that can, when finished, be collected and printed together to form a singular deck.  

At the time of this publication, Microsoft makes its web-hosted versions of Word and Excel freely available to anyone who registers with an email address. It is possible to generate and print simple playing cards using Word’s mail merge functionality which can bring in text and locally-hosted images from an Excel file into customized ‘labels’ (cards) in Word (Microsoft). For the purposes of simple card design, this combination of ubiquity and functionality might be all that’s necessary for the task at hand.  

That being said, you may be interested in using a tool that many amateur and professional game designers, such as Elizabeth Hargrave (Ludology), uses for producing prototype cards for game testing and game play: nanDECK.  

## What is nanDECK and How to use it  

The ability to easily iterate game cards and playtesting to note the effects of these changes is considered a crucial part of the game design process. nanDECK is a software for Windows “written as an aid for game inventors, with the aim of speeding up the process of designing and printing deck of cards (useful during prototyping and playtesting)” that has been made freely available by Andrea “Nand” Nini. At the time of this writing, the most recent version of nanDECK 1.27 was released in July of 2022. The software has been in development since its 1.0 release in April 2006.  

While nanDECK was created and made freely available for the making of playing cards, the program can be used to generate graphics for other play objects including tiles and counters.  

## Installation

### Windows

nanDECK can run on any version of Windows. The [software can be downloaded](https://www.nandeck.com/archives/199), unzipped, and then run as it does not need to be installed. This means that nanDECK can be run from a USB stick.

### Linux

Users with Linux computers can run nanDECK if they install the Windows emulator, [Wine](https://www.winehq.org/) and the [Microsoft core fonts](https://sourceforge.net/projects/corefonts/files/the%20fonts/).

### OSX

nanDECK can be downloaded and then run on OSX using the Windows emulator, [Wine](https://www.winehq.org/). That being said, those with Apple computers running on MacOS Catalina or later will need to take additional steps as Wine no longer runs on these operating systems as they have dropped 32-bit OS support.  

The official nanDECK Manual (Nini) suggests that a workaround for this is to [install Winebottler](https://winebottler.kronenberg.org/) and [XQuartz](https://xquartz.macosforge.org/) to run the same version of Windows on an OSX computer. Alternatively, users can consider installing and using nanDECK through an emulator like [Virtual Box](https://www.virtualbox.org/) or through a commercial subscription service such as [Parallels](https://www.parallels.com/ca/products/desktop/).  

## Installation Problems

If you run into installation issues, there are several online forums where others may gift you with kind assistance. The author of nanDECK, Andrea Nand is an active participant of the [nanDECK Users Forum on BGG](https://boardgamegeek.com/forum/26631/nandeck-users/general). There is a smaller but still active [community of nanDECK users also on Reddit](https://www.reddit.com/r/nanDECK/).  

## Or Try No Installation

There is a very simple version of nanDECK that is currently [available online](http://www.nandeckonline.com:8899/). It currently states that it is at version 0.99.5 and so it can be surmised that it is almost ready for official public use. While this online version is functional, there is no documentation for this version of nanDECK.  

## How to use nanDECK to Generate Cards

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-1.png" alt="A screenshot of the main interface window of nanDECK Version 127. There are three panes in the window and buttons along the right, bottom and left sides of the screen." caption="Figure 1: A screenshot of the main interface window of nanDECK Version 127" %}

nanDECK generates cards with graphics from scripts that are composed in the top window of the screen. When the scripts are validated and/or the deck is being built, a log of responses from nanDECK are returned in the bottom window of the middle of the screen as the cards are generated.

All script commands in nanDECK are composed of a keyword, an equal sign (=) and a list of parameters. It is necessary to refer to nanDECK’s Manual to understand what parameters are available for each command. For example, for the command of FONT, the manual advises:

> FONT
>
> This directive sets the font for any following TEXT command (see page 164). Note that there is not any reference to a range of cards. If you want a ranged command, you can use FONTRANGE instead (see page 105).
>
> Syntax:
>
> FONT = “font name”, font size, style, html color font, html color background, outline x, outline y, step x, step y, char space
>
> Parameters:
>
> “**font name**”: character font name (string)
>
> **font size**: character font size, in typographical points (1 point = 1/72 of an inch)
>
> **style**: character font style and flag used for visualization; values accepted are:
>
> B bold
>
> I italic
>
> U underline
>
> S strikeout…

Knowing the above, we can now understand this code sample is to set the font name as Arial, to set the font size as 32, to style the font as bold, and to give the text the colour of blue, as expressed in hex numerical format:

```
FONT = Arial, 32, B, #0000FF
```

The FONT command is one of the few script types in nanDECK that are understood to be applied to every card in the deck. For most nanDECK commands, the first parameter is the desired range of cards upon which the command will be executed. For example, the first parameter of FONT RANGE is “range.” To use bold, blue, Arial font on only the first 20 cards would require this code:

```
FONTRANGE = 1-20, Arial, 32, B, #0000FF
```

Some of the more common elements that can be applied to the design of each card include BORDER, TEXT, IMAGE, COLOR, RECTANGLE and CIRCLE.

nanDECK also allows for parameters to be calculated through the use of “Expressions”. Expressions are delimited with “{” and “}”.

If you are importing card elements through an external spreadsheet using nanDECK’s LINK command, then the program will know how many items have been loaded into each field of the spreadsheet. Because of this, we can use an expression to calculate the number of items in a given ‘field’ and then use that calculation as the endpoint of a given range. This way, you do not have to manually calculate and include in the script how many cards are being generated when items are added or removed from the spreadsheet of card elements.

```
TEXT="1-{(FACT)}",\[FACT]
```

## How to build a version of Timeline using nanDECK

It is a testament to how powerful nanDECK is when we understand that a deck of Timeline cards can be generated with only twelve lines of script.

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-2.png" alt="A screenshot of the main interface window of nanDECK Version 127. In the center pane are 12 lines of instruction in red, blue, green, and black type. In the bottom pane is a log of actions recently made by the software. In the right-side pane is the preview of a card from the generated deck." caption="Figure 2: A screenshot of nanDECK and twelve lines of instruction that has been used to generate a deck of Timeline cards." %}

To better understand how nanDECK works, each line of this program will be explained more fully.

### Line 1: COMMENTS

```
1. ; This is Windsor Timeline by Mita Williams, a mod inspired by the game Timeline by Frederic Henry
```

Text in nanDECK that begins with a semicolon is not interpreted as a script by nanDECK but as a ‘comment’ to benefit the human reader. It is possible to include a comment in-line with the code by doubling the semicolon character.

```
2. PAGE=21,29.7,portrait,HV ;; this sets the page dimensions in CM
```

### Line 2: PAGE

The PAGE directive sets the paper’s size and orientation for printing and PDF creation.

> Parameters:
>   **width**: page width (in cm)
>   **height**: page height (in cm)
>   **orientation**: the orientation can be chosen between:
>   LANDSCAPE horizontal
>   PORTRAIT vertical
>   **flags**: to specify a special behavior for pages, with possible values including:
>   H the cards are horizontally centered
>   V the cards are vertically centered

```
2. PAGE=21,29.7,portrait,HV ;; this sets the page dimensions in CM
```

With this understanding, we can read the above line as a directive to set the PAGE size to the metric equivalent of a US standard 8.5” x 11” sheet of paper, oriented as portrait. nanDECK will make the necessary calculations to generate the cards on the paper as horizontally centered.

### Line 3: CARDSIZE

```
3. CARDSIZE=4,6.5
```

The CARDSIZE directive sets the size of each card in cm in terms of width and height. If this line is omitted, the default of 6 cm x 9 cm is used instead. This default generates cards that are oversized compared to the standard deck of playing cards which are 2.5" x 3.5" or 5.71 cm x 8.89 cm. For the purposes of this deck, I have opted to create smaller cards that are similar to the dimensions of the Timeline cards published by Asomdee.

### Line 4: LINK

LINK is used to connect nanDECK to external data that has been formatted either as a text file with comma-separated values (CSV format) or in the form of an Excel spreadsheet (with xls, xlsx, or extensions). 

It is also possible to LINK to a Google Sheets spreadsheet. The additional steps necessary are outlined within the nanDECK Manual under the section for LINK and are reproduced here (Nini):

> You can also link a Google Sheet document, using the ID of the file instead of “filename” parameter, but you must share it first, following these steps:
>
> • select the file in Google Drive web page
> • click the Share icon (the icon with the “little man” in top-right button bar)
> • click the dropdown menu below “Link sharing on” in the window
> • select a link sharing option, one of the “Anyone with the link…” option
>
> Now Google shows you a link like this: `https://docs.google.com/spreadsheets/d/**1s_p1gcL2BBO_zYIe_v8bADjWzFtc0hh_eY8DIw8OPfY**/edit?usp=sharing`

> The ID of the sheet is the bold part, copy it and paste it in a nanDECK line like this:
> LINK=1s_p1gcL2BBO_zYIe_v8bADjWzFtc0hh_eY8DIw8OPfY
>
> You can also select one of the sheets, with this syntax:
> LINK=ID!Sheet_name
> Example:
> LINK=1s_p1gcL2BBO_zYIe_v8bADjWzFtc0hh_eY8DIw8OPfY!Beta
> But you must enable the web sharing, with these steps:
> • open the spreadsheet in a browser
> • select from menu File → Publish to the Web
> • click on “Publish” button

Of note, nanDECK assumes that the first row of the linked data contains the names of the fields being imported. Your first card will be described on the second row of the spreadsheet and nanDECK will still consider it the first 'card.'

```
LINK = “Windsor-Timeline.xlsx”, “Year”, “Fact”, “Images”
```

If the fields’ names are omitted, the fields are referenced using the names contained in the first row of the file. This applies to our example.

```
4. LINK = "Windsor-Timeline.xlsx"
```
This lesson provides a link to a small sample Excel spreadsheet (Windsor-Timeline-Spreadsheet-Example.xlsx) that can be used to generate an example deck of five cards. In the second sheet of this download, you will find the URLs where you can download the images for these cards. These need to be given the names found in the spreadsheet and placed in a directory named Images. 

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-3.png" alt="A table of five cells with thick black borders. Each cell is a card with a black and white image on the top and text describing a historical event associated with the image. Dotted lines are extended from the black borders into the blank margins surrounding the table." caption="Figure 3: An example of a page of cards generated by nanDECK with requested black borders between cards and dotted lines to make cutting easier." %}


### Line 5: BORDER

```
5. BORDER = rectangle, #000000, 0.25, MARKDOT
```

BORDER’s parameters include:

> **type**: the type of border can be chosen between:
> RECTANGLE draws a rectangle (the default)
> ROUNDED draws a rectangle with rounded corners
> MARK draws cut marks
> **html color**: black if not specified
> **thickness**: in cm. The thickness of the border is measured between two cards. This means a thickness of 1 cm will result of a border of 0.5 cm, on each card
> **guidelines**: this is for drawing lines beyond the card’s boundaries to assist in cutting

For this example, nanDECK was directed to draw a black rectangle as a border for each card with the addition of dotted cut marks.

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-4.png" alt="In between the top window of instructions and the bottom window of the program's log is text that begins, IMAGE=\"range\", \"image file\", position x, position y, width, and then the word, height, in bold, followed by other variables. In the top window, the mouse cursor is resting on the 6th instruction line, on the number 60\%, which we now understand as the image's height." caption="Figure 4: An example of a page of cards generated by nanDECK with requested black borders between cards and dotted lines to make cutting easier." %}

### Line 6: IMAGE

While nanDECK includes a basic Visual Editor that allows for basic shapes to be drawn and added to cards, for the purposes of this deck, we want to add .jpg images from an external source that have been collected and copied from various digital history collections online and made available on a local file directory.

There are a large variety of parameters and flags associated with the IMAGE directive, as evidenced by its syntax :

> IMAGE = range, image file, pos x, pos y, width, height, angle, flag, alpha, texture width, texture height, skew x, skew y, img width, img height, loc x, loc y, copy x, copy y

Understanding the order of the syntax can help us decipher the IMAGE directive in our script:

```
6. IMAGE="1-{(IMAGES)}",\[IMAGES],0%,0%,100%,60%,0,PTG
```

If we forget or are unsure which number nanDECK is associated with which part of the syntax, you can mouse over the number and nanDECK will add bold to the relevant parameter.

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-5.png" alt="A screenshot of a card with dimensions 472 x 768. The card has a thick black border. The top of the card features a black and white image of a brick church with a large wooden door and branches of a tree that is out of frame. Under the image is, in bold print, 1851. Under this date is the text, 'The cornerstone of Sandwich First Baptist Church is laid on land donated by the Crown'" caption="Figure 5: In between the top window of instructions and the bottom window of the program's log is bolded text that corresponds to the variable that the mouse cursor is currently situated on." %}

As explained earlier, we can use nanDECK’s ability to calculate basic expressions. In this case, the range of cards is being defined as the first card to the total number of items in the range of images (that we had just imported using the LINK declaration). Next, nanDECK will add the image using the file location that is found in the spreadsheet that we’ve provided.

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-6.png" alt="A screenshot of a part of an Excel spreadsheet with three columns. In column A, the first four lines have years but the next three entries have none. The middle column features the description of an event to be printed on the card. The last column lists the file location of the image for the card." caption="Figure 6: A card generated using nanDeck." %}

To generate the card above, nanDECK was directed to insert the image found at _Images/Sandwich_First.jpg _at the 0,0 position and for the image to take up 100$ of the width (if possible) and only 60% of the card’s height (if possible). By using the P flag, nanDECK is asked to calculate where the image should be positioned while maintaining the original image’s proportions. Since there are a variety of images in this deck that are of differing proportions, I opted to make all the images grayscale using the G tag to give the cards in the deck some uniformity and cohesion.
### Lines 7 and 9: FONT

```
7. FONT=Arial,14,BT,#000000
8. TEXT="1-{(YEAR)}",\[YEAR],25%,60%,52%,9%
9. FONT=Arial,7.5,,#000000
```

nanDECK is able to use the fonts that you have installed on your machine.

In line 7, nanDECK is directed to set the font size as 14 and to make it bold and transparent. After line 8 directs nanDECK to generate text in this font, line 9 with a reduced font size of 7.5. Of note, in line 9 there are two commas in a row. This is to let nanDECK know that the style parameter is empty and that the text is not being directed to be styled in bold or any other way.

### Lines 8 and 10: TEXT

```
8. TEXT="1-{(YEAR)}",\[YEAR],25%,60%,52%,9%
10. TEXT="1-{(FACT)}",\[FACT],4.5%,68.5%,91%,30%,CENTER,WORDWRAP
```

nanDECK provides a variety of options for writing TEXT on cards:

> TEXT = “range”, “text”, pos x, pos y, width, height, horizontal alignment, vertical alignment, angle, alpha, outline width, circle offset, circle angle, width factor, height factor

For the purposes of our deck, the text decoration has been kept simple, but there was a challenge of text placement. Most playing decks have two sides with one side being the ‘face’ and the other side being the ‘back.’ In many games, most of the relevant information is found on the face of the card with the the back of the card being largely decorative or designed to indicate what type of card it is. As you may recall, a card in a Timeline deck has two faces: one with a name or description of an event on one side and on the other side of the card, there is a similar face bearing the same name and description, but there is an addition of the year of that event.

Line 8 is the script that writes the year on the range from the first card to the last of the cards with a year field. Line 10 is the script that writes a description of the event on all of the cards, from the first card to the last card with a ‘fact’ field. So how does this script produce the cards we need to play _Timeline_?

The workaround that I came up with to solve this design problem cannot be found in the nanDECK script, but is located in the Excel spreadsheet that this script is linked to. After the first 58 cards are printed with an image, a description, and a year, the next 58 cards are printed and these are the same as the first 58 cards except for these, there is no value of ‘Year’ to be printed.

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-7.png" alt="Two pages of cards in a grid format. The left hand page of cards feature years printed in bold and the right hand side of cards are the same but without the year printed." caption="Figure 7: The simplest way to have nanDECK generate a card side without the date being printed is to duplicate the information used to make cards without text in the date field." %}

This is admittedly not the most efficient one as the information needed to generate new cards must be added twice into the spreadsheet (one entry including the year and one entry without) but it does produce the desired end result.

### Lines 11 and 12: DUPLEX and PRINT

One of the greatest strengths of nanDECK is its ability to generate synchronized backs and fronts of cards. It does this through the DUPLEX and PRINT directives.

> DUPLEX
> This directive copies a card (or a range of cards) to another position (or range) calculated automatically by the software, it is useful to manage duplicates or synchronize the front and back of cards for a duplex printing

> DUPLEX = “range front”, “range back”, number

In order to align the cards with years printed on them, it is only necessary to designate their range. In the case of my personal deck, there are 59 unique cards, with the fronts being generated from range 1-59 in my spreadsheet and the backs generated from range, 60-118.

```
11. DUPLEX = 1-59,60-118
12. PRINT = DUPLEX
```
After you Validate the deck and then Build it, you will be shown a preview of the generated cards in the right preview pane. In this display, you might see a distressing number of blank cards. These blank cards are inserted into your deck by nanDECK in order to generate a PDF document that, when printed, will be aligned to create the final set of cards. 

This is why it is recommended to use the 'Print deck' option to make sure that all of cards are being generated properly.

{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-8.png" alt="A screenshot of Tabletop Simulator that features an image of an octagon-shaped wooden table obscured by Timeline cards that have been thrown in the air. " caption="Figure 8: Two pages generated by nanDECK for printing. Note that the pages are oriented so that they can be folded together to make matched, double-sided cards." %}

## Printing Cards with nanDECK

nanDECK can print your deck in a multitude of ways. Each card generated by the program can be saved as a separate graphical image or, as described above, the deck can be printed to a single PDF for printing, assembling, cutting, and gluing together. As the common practice of game design involves rounds of observed play-testing that inform iterative changes to a game's design, nanDECK's ability to easily re-generate variations of a deck of cards is well-appreciated (Ludology).

Before you can print your deck, you first must select the 'Validate Deck' button to have nanDECK check the syntax of your script to ensure that it is valid. After your script has been validated, you can press the 'Build Deck' button to generate your deck of cards from the script. Then, you can use the'Print Deck' button to have nanDECK generate your deck as a PDF file for printing.  

There is also the option to have your cards printed professionally. The creator of nanDECK has established a formal relationship with _Game Crafter,_ an American print-on-demand company that specializes in producing cards and other tabletop game components. There is a button on the nanDECK interface panel that starts the process to upload of nanDECK files to the _Game Crafter_ site for future printing of single sets and limited runs.  

At this point it is worth noting that, in general, commercial publishers will not print any images that they believe are under somebody else’s copyright even if the game is intended for personal or educational use and not for commercial sale. Even though my local history version of Timeline was primarily drawn from public domain sources or from collections that had clear licenses that allowed for re-use, many of the images that I wanted to use in my cards fell under copyright. This means that there is a good chance that a commercial publisher might not want to publish even a single copy of my game.  

But there are other ways to bring people together to play our new game.  

## Printing Digital Cards for Tabletop Simulator

nanDECK also provides tight integration with another platform called _Tabletop Simulator_.  _Tabletop Simulator_ is a physics sandbox where up to ten players can manipulate and play with digital game pieces. [_Tabletop Simulator_](https://www.tabletopsimulator.com/) is available on [Steam](https://store.steampowered.com/app/286160/Tabletop_Simulator/) currently for $19.99 USD. While _Tabletop Simulator (TTS)_ is not the only digital platform that allows people to gather in front of a shared screen instead of a shared table to play cards and board games, it is a well-known title used by game designers for observing and testing with players who may be physically dispersed around the world.  In essence, once you understand and able to import your cards into TTS, you will enable your game to become a video game, with no rule-coding necessary.  

TTS requires image files for each side of a deck to be in a a standardized format so that it can parse the image into cards and nanDECK can generate cards in this format, after some modifications are made. A normal card deck will have an illustration on the card 'back' and information and symbols on the card 'face' (such as the 4 of Clubs). In our version of _Timeline_ our card face will have a 'fact', a year, and an illustration, and the back of the card will have a 'fact', illustration, and no 'year'. nanDECK is able to generate both types of cards for use in _Tabletop_Simulator_, and the process is the same. First the front side of deck is generated as a single image and back side is generated as a single image. 

To do this, it is necessary split our original spreadsheet into two parts. The first spreadsheet needed to generate the deck's 'face' will have columns for facts, images and years. This spreadsheet will not have duplicate entries missing years; those rows will need to be cut and added to a new, separate spreadsheet with columns for 'Fact' and 'Image' but not 'Year.' Now it is necessary to run two variations of the code described above. 

First, we need change our script to reflect that we are using a new file to generate only half the deck: 

```
LINK = "Windsor-Timeline_for_Tabletop_Face.xlsx"
```
As we no longer have to generate one document that meant to be printed and then folded, we can remove these lines from our code:
```
DUPLEX = 1-59,60-118
PRINT = DUPLEX
```
TTS requires image files for each side of a deck to be in a a standardized format of page of cards that run ten in number across, and seven in number down. This standardization is necessary so the program knows how to calculate where the cards are to be parsed into separate images. (If your deck has more than 70 cards, it will be necessary to parse the deck into as many as necessary under the 70 card limit). 

The script that generates this standard is:
```
RECTANGLE=70,0,0,100%,100%,#000000
```
nanDECK then creates a singular image using its command called DISPLAY that is used after the deck is generated. 
```
DISPLAY="Windsor_Timeline_TTS_Face.png"
```
Use the 'Validate' button and the 'Build Deck' button, and nanDECK will have generated the image, "Windsor_Timeline_TTS_Front.png" in your current directory. Then repeat the process aftering changing the script's input (the filename for LINK to "Windsor-Timeline_for_Tabletop_Back.xlsx") and then destination filename for the output (by changing DISPLAY to "Windsor_Timeline_TTS_Back.png"). You are now ready for _Tabletop Simulator_. 

## Uploading Your Cards into Tabletop Simulator

When you first open _Tabletop_Simulator_, the game asks if you are going to join an existing game or to would you like to 'Create'. Choose the Create option. Then there will be a screen prompting if you are interested in loading a Classic Game, a Digitally Licensed Game, a game from their Steam Workshop, or if you would like to 'Save and Load' your own local content. Choose 'Save and Load' and exit out of the screen. This should leave you staring at an empty Tabletop. From the top menu options, select 'Objects', then 'Components' and then 'Cards.' From the options presented, select 'Custom Deck.'  This will add a virtual blank deck on your virtual tabletop and you be given the option to Import your files from nanDECK to create your custom deck (if you don't see this option, right-click on the blank deck). 

From this menu, you will be able to select the image of your deck face from your local drive. Make sure to check the box beside the option, 'Unique backs' and select the image of your deck back file from your computer. Leave the width option at 10, the height option at 7, but do adjust the slider so that it displays the true number of cards in your deck. After these steps are complete, hit the 'Import' button and your deck will be built for your virtual play.

By uploading your deck into TTS, you will be able to play your version of _Timeline_ with up to nine other invited players in an onine environment. Furthermore, if you choose to upload and make your game assets available throught the [_Tabletop Simulator's Steam Workshop_](https://steamcommunity.com/app/286160/workshop/), you can add your deck to the over 11,000 sets of cards available to a community of over 2 million TTS customers to play (Bezerk Games). 



{% include figure.html filename="or-en-designing-a-timeline-tabletop-simulator-9.png" alt="Visual description of figure image" caption="While one of the most delightful features of Tabletop Simulator is the ability to flip the table, the ability to throw cards around is also pretty enjoyable.
" %}

## Build Your Own Timeline using Google Drive

In order to facilate getting started with nanDECK and TTS, I have made available a starter deck of files for you to model or build upon.

The [files are hosted on Google Drive](https://drive.google.com/drive/folders/1kkGOz3QHGSTj0ca4HlOEl1eIgX2NN0c6?usp=sharing).

The contents of this directory include:
- PH_nandeck_Your_Timeline.txt : The script to open with nanDECK
- Build-Your-Own-Timeline : the spreadsheet that the script in nanDECK will use to find the assets to build the deck
- six png images 
- one pdf image of what nanDECK should have generated from the script and the assets above

Within this directory is also a folder called, *For Tabletop Simulator* which contains:
- PH_nandeck_Your_Timeline_TTS_Face.txt : The script to open with nanDECK to generate the image of card faces
- PH_nandeck_Your_Timeline_TTS_Back.txt : The script to open with nanDECK to generate the image of card backs
- Build-Your-Own-Timeline-TTS-Face : the spreadsheet that the script in nanDECK will use to generate the image of the card faces
- Build-Your-Own-Timeline-TTS-Back : the spreadsheet that the script in nanDECK will use to generate the image of the card back
- Your_Timeline_TTS_Face : the image produced by nanDECK using the assets above to be uploaded into TTS
- Your_Timeline_TTS_Back : the image produced by nanDECK using the assets above to be uploaded into TTS


This ability for nanDECK to draw from an external directory of resources means that developing your own version of _Timeline_ or other variation of a card game need not to be a solo endeavour. A entire classroom of students could collect images and facts together in a single shared directory and spreadsheet. 

The downside of this approach is that the 'secrets' of each others cards would be visible to them and any subsequent play of the deck would not be a surprise. This is why this lesson suggests that each student make their own deck for printing or uploading into TTS so that they can combine their cards together and discover what each one has shared, in play.

## Conclusion

It is hoped that this lesson will help facilitate a possible future in which history students and/or beginning game designers create and generate their own specific modification of _Timeline_, opting to cover a specific aspect of local history or a theme or other facet of coverage, and then share them online. These decks could be combined so that a deck covering local history could be interspersed with a history of a similar time but a different place or scope. In doing so, players will discover moments of synchronology and historical overlap that can surprise and delight (e.g. Oxford University is older than the Aztec Empire). 

As well, while it is intended that this lesson will encourage others to create mods of their own of _Timeline_, it is also hoped that this experience will inspire others to create modification of other existing games. One could imagine creating and adding their own cards to decks not unlike 'Trivial Pursuit', 'Magic The Gathering', or even 'Uno'. Perhaps the next step after that would be a brand new game.

I would like to end this lesson with another tenet from Eric Zimmerman’s "Manifesto for a Ludic Century":

> **Digital technology has given games a new relevance.**
>  
> The rise of computers has paralleled the resurgence of games in our culture. This is no accident. Games like Chess, Go, and Parcheesi are much like digital computers, machines for creating and storing numerical states. In this sense, computers didn’t create games; games created computers.

Zimmerman is not the only one who believes this. Tabletop games have been described as ‘paper computers’ as they are designed and “they enact systems of rules and procedures” (Sayers).

But the value in generating cards in nanDECK is not inherently in the opportunity to learn how to use a computer program’s declarations and procedures to generate cards that themselves, become their own systems of rules. There are many other things I learned as I made my own deck. For example, while I gathered the elements for this game, I learned more about my community’s past. While searching for the images for my cards, I personally stumbled upon a couple collections of digitized historical objects and images that were completely new to me.

But perhaps the most important thing I learned, along with the gaps in their collective knowledge, I learned was how clever my friends and family were when they played this game together.

## References

Berzerk Games. "Developer & Publisher Information." _Tabletop_Simulator_, 2023, [https://tabletopsimulator.com/contact/publishers](https://tabletopsimulator.com/contact/publishers).

Boyden, Bruce E. _Games and Other Uncopyrightable Systems_. 1580079, 20 Apr. 2011. _Social Science Research Network_, [https://papers.ssrn.com/abstract=1580079](https://papers.ssrn.com/abstract=1580079).

Hodkinson, Alan, and Christine Smith. “Chronology and the New National Curriculum for History: Is It Time to Refocus the Debate?” _Education 3-13_, vol. 46, no. 6, Sept. 2018, pp. 700–11. _Taylor and Francis+NEJM_, [https://doi.org/10.1080/03004279.2018.1483804](https://doi.org/10.1080/03004279.2018.1483804).

Lang, James M. _Small Teaching: Everyday Lessons from the Science of Learning_. First edition.., Jossey-Bass, 2016.

Ludology. _Ludology: Ludology Episode 203 - Winging It_. 203, [https://ludology.libsyn.com/ludology-episode-203-winging-it](https://ludology.libsyn.com/ludology-episode-203-winging-it). Accessed 8 Oct. 2022.

Microsoft. “Mail Merge Using an Excel Spreadsheet.” _Microsoft Support_, 2022, [https://support.microsoft.com/en-us/office/mail-merge-using-an-excel-spreadsheet-858c7d7f-5cc0-4ba1-9a7b-0a948fa3d7d3](https://support.microsoft.com/en-us/office/mail-merge-using-an-excel-spreadsheet-858c7d7f-5cc0-4ba1-9a7b-0a948fa3d7d3).

Nini, Andrea “Nand.” _NanDECK Manual Program Version 1.27 – 2022-07-27_. Andrea “Nand” Nini, 2022, [https://www.nandeck.com/download/204/](https://www.nandeck.com/download/204/).

Rosenberg, Daniel. “Mark Twain Memory-Builder.” _Time OnLine_, 2013, [https://timeonline.uoregon.edu/twain/pleasures.php](https://timeonline.uoregon.edu/twain/pleasures.php).

Sayers, Jentery. _Paper Computers_. 2018, [https://jntry.work/archive/syllabi/508v4/](https://jntry.work/archive/syllabi/508v4/).

_Timeline & Stag Hunt_. Directed by Richard Malena-Webber, vol. 8, 2017. _YouTube_, [https://www.youtube.com/watch?v=dZbkxMuBR_I](https://www.youtube.com/watch?v=dZbkxMuBR_I).

Zimmerman, Eric. “Manifesto for a Ludic Century.” _The Gameful World: Approaches, Issues, Applications_, edited by Steffen P. Walz and Sebastian Deterding, The MIT Press, 2015, pp. 19–22.
