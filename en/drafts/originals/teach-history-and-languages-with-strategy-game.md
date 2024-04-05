---
title: "Teach History and Languages with a Strategy Computer Game: 0 A.D. in the Classroom"
collection: lessons 
layout: lesson
authors:
- Corey Stephan
---

# Table of Contents

{% include toc.html %}

# Tutorial Overview

Here, you will learn how to use the real-time strategy (RTS) computer game [0 A.D.: Empires Ascendant](https://play0ad.com/) to help you teach history and/or languages. This tutorial should be well-suited for you if you are a secondary or postsecondary class instructor of materials connected with any of the following topics related to the pre-modern world:
* classics and/or ancient history
* biblical studies
* medieval studies
* ancient archaeology
* ancient languages

## Learning Outcomes

By the end of this tutorial, you will learn:
* what the 0 A.D. project is, how to use its documentation, and why it may be said that the game is well-rooted in history and linguistics
* the basic methods with which you might use 0 A.D. inside a history or language class for productive group study
* the simple customization options that are available for 0 A.D.'s use in the classroom, including community-made gameplay modifications
* how to build your own realistic historical scenario by importing real-world topography and crafting a playable scene atop it
* how to begin drafting your own stand-alone 0 A.D. gameplay modification

# Requirements

This is a **beginner-level** Programming Historian tutorial. It is structured so that you do not need to have any prior knowledge about real-time strategy (RTS) gaming, image editing, and/or computer coding in order to complete it.

This tutorial requires two software programs: 0 A.D. and the GNU Image Manipulation Program (GIMP).

0 A.D.’s and GIMP's complete user interfaces (UIs) are available in many modern languages, including all four of the Programming Historian’s (English, Spanish, French, and Portuguese).

## 0 A.D.

0 A.D. is packaged by community members for every major desktop operating system (OS). For a libre Unix-like OS, the best place to find an installable package of the game is the OS's own package repository. Alternatively, users of Unix-like OSes may compile the game from [source](https://trac.wildfiregames.com/wiki/CompilingUsingTheReleaseSourceArchives). For Apple MacOS or Microsoft Windows, the best place to find an installable package is on the 0 A.D. website's [Download webpage](https://play0ad.com/download/).

Per the [official minimum hardware requirements](https://play0ad.com/download/) for 0 A.D., the game should run on a majority of Intel 386 (i386, "32-bit Intel") or x86-64 (AMD64) computer systems that are in operation for home and/or office use today, and the game is able to be compiled on ARM systems. For the smoothest experience, however, you should install 0 A.D. on a machine with the following specifications:

* a multicore AMD64 processor
* a recent discrete graphics processing unit (GPU, "video card") or a gaming-oriented integrated graphics processor
* a solid-state drive (SSD)
* eight or more gigabytes (GB) of random access memory (RAM)

For multiplayer testing and/or gameplay, whether over your Local Area Network (LAN) or the Wide Area Network (WAN, "Internet"), all players should have wired connections (rather than wireless/WiFi) in order to reduce the risk of packet drops causing game stutters and/or crashes.

The base game requires approximately 3.5 GB of storage space, and you should have a few spare GB available after installing 0 A.D. and GIMP in order to complete this lesson.

### Licenses

* Binaries (compiled): [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html)
* Engine and code: [GPL 2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html) or later
* Artwork, music, and other non-code resources: [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/)

## GIMP

You will use [GIMP](https://www.gimp.org/) to prepare real-world topographical data for import into the game. Like 0 A.D., GIMP is available for every major desktop OS. It has modest hardware requirements (lower than 0 A.D.) and occupies about 250mb of storage space.

### License

* [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) or later

# What is 0 A.D.?

0 A.D.: Empires Ascendant is a cross-platform, scholarship-aware, and fully free and open source singleplayer and multiplayer historical real-time strategy (RTS) computer game of ancient civilization building and warfare making that has been under continuous development since 2001. 

The project was formed by [the partnership of at least three computer gaming communities](https://trac.wildfiregames.com/wiki/0adStory#a2000-2002:TheBirthof0A.D.) who were separately making gameplay modifications (mods) for Ensemble Studios' famous [Age of Empires and Age of Empires II](https://en.wikipedia.org/wiki/Age_of_Empires) RTS games. Through interactions on the long-running [Age of Kings Heaven](https://aok.heavengames.com/) Forums, a discussion zone for fans of the Age of Empires games, the members of the three communities decided to collaborate to create a wholly new game that would be historically and strategically richer than they had found to be possible only by modifying the Age of Empires titles. One of the main founding groups was Wildfire Studios, which is the source of the name "Wildfire Games" that the umbrella organization that those groups formed two decades ago still holds.

[Wildfire Games](https://wildfiregames.com/) now oversees not only the [Rome at War])(https://wildfiregames.com/raw/) overhaul modification for Age of Empires II: The Age of Kings that was the claim to fame of the original Wildfire Studios but also [Pyrogenesis](https://www.moddb.com/engines/pyrogenesis), the built-from-scratch game engine behind 0 A.D., as well as the 0 A.D. game project as a whole. 

Since the 0 A.D. project was founded by gameplay modifiers, modification always has been a normal part of the playerbase's engagement with it. Yet, it was not until 2009 that the project leaders decided to make the game's source code public under the libre licenses noted above. Opening the source code seems to have allowed the project to progress at a more efficient pace than it had in its earliest years. Further, that decision has made possible both the large number of mods that are available for 0 A.D. and 0 A.D.'s rare status as a completely cross-platform game in which eight persons may play together without hassle even across eight different desktop OSes.

As of early 2024, the current stable release of the base game, labeled "Alpha 26" because it is the 26th alpha version of an ever-in-development software project, features multiple ancient civilizations. All of those civilizations have believable architecture, attire, technologies, military techniques, and heroes –- plus, as much as possible, restored pronunciation of their original languages. The current [list of playable civilizations](https://play0ad.com/game-info/factions/) is as follows (ordered alphabetically):

* Achaemenids
* Athenians
* Britons
* Carthaginians
* Gauls
* Hans
* Iberian Tribes
* Macedonians
* Mauryans
* Ptolemies
* Republican Romans
* Seleucids
* Spartans

# A Scholarship-aware Community Endeavor

In a [2006 interview with Jason Adams of gamedev.net](https://www.gamedev.net/articles/industry/interviews/a-first-look-at-0-ad-r2321/), the 0 A.D. project's Paul Basar, designated in the interview notes as a member of the "History Department" of Wildfire Games, said the following about his team's attention to historicity:

> [Historical] accuracy is of the highest priority, with all weapons, helmets, armor, and shields to be of historical provenance. Literally dozens if not hundreds of historically accurate armor and weapon props have been modeled and textured, with more to come. Buildings are designed according to the style and appearance of their historical counterparts. Even the sound effects of construction have been made unique for each civilization to show the varied materials used by each people. Unit types are given in their original language, as close as can be determined ... Each soldier, woman, priest, and trader is given an original personal name from his or her culture. Naval warfare has also been rigorously researched and planned by Ken Wood, our chief designer, promising one of the best historical naval combat experiences yet seen in an RTS. This is only a small sampling of the effort going into historical accuracy in 0 AD.

As the [Wikipedia article about 0 A.D.](https://en.wikipedia.org/wiki/0_A.D._(video_game)) says, "the historical accuracy of the game elements has been the highest development priority." The name "0 A.D.," however, seems to serve as a reminder that the game has many true-to-life elements while still being a game. The [Han Dynasty](https://en.wikipedia.org/wiki/Han_dynasty) and the [Spartan Empire](https://en.wikipedia.org/wiki/Classical_Greece#Foundation_of_a_Spartan_empire), for example, never were at war with each other, nor did their two civilizations even overlap temporally. Yet, the point with 0 A.D. is not historicity inside the gameplay of specific civilizations being pitted against each other but, rather, historicity inside each civilization itself. The Spartans have been recreated as a playable civilization with many militaristic, economic, domestic, cultural, and religious trappings from their peak as the Spartan Empire, and the Hans have been recreated in the same way. The game might be understood best as an imagined clashing of multiple real civilizations that were of prominence between circa 500 BCE and 500 CE. "0 A.D." is the year that never was, a historically fictional nexus between civilizations and events that really were.

Even a cursory look at the newsfeed in [Wildfire Games' official community Forum](https://wildfiregames.com/forum/) shows daily discussions about historical matters in relationship to building an engaging RTS game, often involving citations of public domain historical literature. It is an unwritten but peer-enforced rule that any change or addition to the game must be rooted in history.

# Using 0 A.D. In-Class

For the last two weeks of the spring semester of 2023, I brought 0 A.D. into the university-level Classical and New Testament Greek class that I was teaching. My objective was to use the game as a tool for team building, historical study, and linguistic practice. What follows is based on that androgogical trial, as well as my hundreds of hours of first-hand experience interacting with the software.

{% include figure.html filename="teach-history-and-languages-with-strategy-game-1.jpeg" alt="Dr. Stephan introducing 0 A.D. to his university-level ancient Greek class via a projector screen" caption="Introducing 0 A.D. to my class via a projector screen" %}

## Team Building

The only way for allied human players to win the game is to communicate constantly from start to fiinish. When I have been successful in matches against artificial intelligence (AI) civilizations set to high difficulty levels, my success has come from talking through every step of the match with my ally.

The need to not simply pool resources but, rather, to coordinate their harvesting and share them smartly presents fodder for class instruction. If you are, say, a historian or a political scientist, then you might note that successful allies in a real war maintain not only a militaristic partnership but also an economic one.

As Sylvester Arnab, Samantha Clarke, and Luca Morini write in their 2019 article "Co‑Creativity through Play and Game Design Thinking," "students discover the importance of elements such as empathy, purpose, meaning, art, creativity, and teamwork in their [game-based] learning regardless of the specific disciplines they are pursuing."[^1] If creativity is found at the intersection of apparently disconnected subjects, then it would be challenging to think of a more creative partner for secondary or postsecondary education than cooperative RTS design and gameplay. In my class, I found that students even intuited installing and configuring 0 A.D. to be acts of teamwork, laughing cheerfully while helping each other start playing.

## Historical Study

Every aspect of 0 A.D. gameplay presents opportunities for historical instruction. While configuring a regular match, since every civilization is grounded in history, I will think through which civilization's real-world strengths and weaknesses are best suited for a particular terrain before I decide anything else about my approach. I would not elect to play as a civilization that lacked its own coastline on a terrain of islands surrounded by ocean, since the game makers would not have given any naval warfare and/or maritime trade bonuses to that civilization.

An example of the game's built-in historical lessons for all civilizations is the interoperation of the three main classes of human units: female citizens, citizen soldiers, and champions. As explained in the [Game Manual](https://play0ad.com/category/game-manual/#post-1984), female citizens are the "driving force of your economy." They specialize in gathering resources, especially food, and they are effective builders. They can attack invading units, but they are quickly outmatched in combat even by the weakest citizen soldiers. Citizen soldiers may gather resources, build, and/or fight. They have gathering bonuses for wood, metal, and stone. They are stronger than female citizens in combat, and they are able to lay the foundations for some military structures that female citizens cannot, but they also require more available resources to train (create). Further, they are outmatched in combat by the third class of units, that is, champions. Champions are professional soldiers. They are the most expensive units to train, and they are incapable of gathering resources or building. Deploying them requires a deeply established economy, normally operated by a balanced mixture of female citizens and citizen soldiers. 

Since I was teaching a Greek class, I explained for my students how these three classes must be used together while playing as the Athenians. The same principles, however, hold for every civilization. Female citizens gather food, the most widely used resource, and build civic structures. Citizen soldiers work together with female citizens to gather wood, metal, and stone; build militaristic structures; defend territory that you already own; and march behind champions for invasions into enemy territories. Champions lead such offensives. Each civilization has its own unique units, heroes, and structures, each of which may be used as a historical teaching point.

## Linguistic Practice

Arguably the most effective means by which you and your students of ancient or modern languages may aid the 0 A.D. project is by working to improve the languages that are in the game, whether by serving as editors for the languages that are already present or by adding new languages.

Not all of 0 A.D.'s' civilizations have yet had persons volunteer to make audio recordings of their units speaking restored versions of their respective ancient languages. The [Audio Voice List](https://trac.wildfiregames.com/wiki/Audio_Voice_List) in the Wildfire Games Wiki is the correct place to learn about what new translations for in-game units are needed, as well as to find up-to-date directions on how to submit them. As of early 2024, the three ancient languages that are already implemented as intended are Late Egyptian, Ancient Greek (both Attic and Koine), and (Classical) Latin. Meanwhile, there are open calls for Sanskrit and Old Persian, and the project's leaders have place holders for (Old) Welsh and/or Anglo-Saxon, (Classical) Hebrew, and Basque.

Wayfire Games also relies entirely on community translators for the ancient and modern languages of its user interface (UI). In the official [Transifex page for 0 A.D.](https://explore.transifex.com/wildfire-games/0ad/), there are (as of the time of writing) nearly 45,000 word strings in the default (American) English language, and the project managers have a list of 113 languages (and counting, since proposals for new languages are normally accepted) at every stage of being translated, from fully finished (100%) to not yet started (0%). Any university-level language class could have as a project working to contribute to any language, ancient or modern, for the UI.

Playing the game with the UI set to the language that the class is learning and/or with civilizations who are entirely crafted in that language probably would be the most enjoyable way to do linguistic practice together as a class.

Combining translation work with gameplay could make a compelling learning scenario. For example, students learning Latin might work toward bringing the half-finished Latin translation of the UI to completion for one portion of a class period and then play as the Romans (who have finished in-game Latin) for another. Thus, they would be engaging Latin by writing it (tactilely), reading it (visually), and hearing it (aurally), as well as (presumably) by speaking it aloud (orally) with each other and the instructor.[^2]

# Customizing 0 A.D. for Educational Use

One aspect of 0 A.D. that makes it compelling for educational use is that the game itself is fully customizable. Here, I introduce you to three of the main ways to transform the game into a customized tool for your own didactic purposes, from simplest to most challenging: finding and installing community gameplay modifications, importing real-world geographic data to create a realistic historical scenario, and building a modification from scratch.

## Novice: Installing Community Gameplay Modifications

The easiest way to customize 0 A.D. for your class is to make use of prepackaged community gameplay modifications (mods). At any point in time, you may find dozens to hundreds of mods hosted at various places on the Web that are compatible with the most recent game release. Since 0 A.D. was founded by game modifiers (modders), the game has been built from scratch in such a way that installing and using those mods is a straightforward process.

In fact, 0 A.D. comes with a built-in mod installer with click-to-install community mods that the game's makers [have verified for safety](https://trac.wildfiregames.com/wiki/Mod_Verification_Process) and uploaded to [mod.io's 0 A.D. set](https://mod.io/g/0ad). After launching the game, from the main menu, click "Settings," then "Mod Selection," then click "Download Mods" (on the bottom task bar), and then click "Accept" (for mod.io's Terms of Service) to be greeted with the full list. Then, click on a mod, and click "Download." To enable the mod(s) that you desire to use, click on each one in the top menu of available mods, and then click "Enable" on the bottom task bar. Finally, click "Save and Restart" to relaunch the game with the mod(s) of your choosing ready for use.

Two regularly updated, featureful mods that are available in the game's built-in mod.io menu and that might be of particular interest to you as a reader of the Programming Historian are [Community Maps 2](https://github.com/0ad-matters/community-maps-2) and [Delenda Est](https://github.com/JustusAvramenko/delenda_est). 

Community Maps 2 adds a large, curated set of high quality gameplay terrains that their various makers have shared publicly. It is my opinion that every 0 A.D. installation should have Community Maps 2, since it adds diversity to the base game without changing its mechanics.

Delenda Est brings major additions to the civilizations and gameplay of the base game, all oriented toward historical realism and depth of strategizing. Among many other new features, Delenda Est includes a novel fourth phase called the "Empire Phase," multiple new civilizations, many options for a special start-of-game hero for each civilization that yield different bonuses, enslavement of foreign peoples, cultic worship, majorly reworked economics (including two new resources, Glory and Coin, to accompany the base game's original four of Wood, Food, Metal, and Stone), and expanded technological trees for every civilization from the base game.

While I have many good things to write about Delenda Est, I only recommend that you bring it into your classroom if you are able to schedule multiple hours for learning gameplay mechanics. The base game, as a real-time strategy game, has a modest but non-negligible learning curve, and Delenda Est introduces a considerably higher learning curve. Further, Delenda Est is only suited for multiplayer use, since AI players are not programmed to handle its special mechanics.

The officially vetted mods for 0 A.D. that are available on mod.io and, therefore, via the in-game mod installation menu might not be the only community mods that you will be interested in using. GitHub, for example, contains the repositories for many other mods. Alternatively, you might wish to download the mods from their public source directories for yourself rather than via mod.io. 

Installing a prepackaged mod outside 0 A.D. is trivial. With a mod downloaded as a .pyromod (custom Pyrogensis package) or .zip file, you may either right click the mod file and select "Open with 0 A.D." or perform the same task at the command line with `pyrogenesis [file].pyromod` or `pyrogenesis [file].zip`. Enable the mod inside the same in-game "Mod Selection" menu that you use with mods installed via the in-game menu.

Alternatively, you could move the entire mod folder into `*/mods` yourself, without having the game engine handle the installation, but you must make sure that the mod's parent folder and .zip that it contains have the exact same name as what is listed in the mod's mod.json file. To install the mod manually, locate the correct folder for inserting mods. This will be inside part of the game's installation directory, specifically `*/mods`. The Wiki currently specifies the Windows folder as `C:\Users\{name_of_user}\Documents\My Games\0ad\mods\`, the MacOS folder as `~/Library/Application﻿ Support/0ad/mods/`, and the default Unix-like OS folder as `~/.local/share/0ad/mods/`. Copy and paste the mod's parent folder (the entire mod) into that folder. Enable the mod inside the in-game "Mod Selection" menu.

I recommend that you start by installing and enabling Community Maps 2 via the game's built-in mod.io-linked installation menu and trying some of its lovely terrains while you become familiar with the base game. Then, move to Delenda Est or another vetted mod available via mod.io that you might like to try in your own teaching context. [Millenium A.D.](https://mod.io/g/0ad/m/millenniumad), for example, which is focused on the ninth and tenth centuries CE, has tens of thousands of downloads. As of early 2024, it is more of a work-in-progress than Delenda Est, but it already has playable iterations of the Anglo-Saxons, Byzantines, Carolingians, Norse, Rus, and Ummayads. There are many other mods even only in the mod.io curated set that add new civilizations and/or other features that might be relevant for your classroom.

## Intermediate: Importing Geographic Data to Create Historical Scenarios

As a teacher of history, you might wish to create fully custom historical scenarios in 0 A.D. to use as showcases for your classes, or you might wish to have your students make such scenarios themselves as class projects. For the most immersive experience possible, it is best to import real-world geographic data.[^3]

While you work through the steps outlined in this sub-lesson, I recommend that you have the official [Atlas Manual](https://trac.wildfiregames.com/wiki/Atlas_Manual) in the Wildfire Games Wiki open in case you should desire additional information about how to use Atlas, 0 A.D.'s built-in scenario editor. 

Also, make sure that you always choose Atlas's settings for a **scenario** -- not a skirmish. Scenarios have predefined civilizations, teams, units, and so on; skirmishes do not.

1. Choose a scenario.

The ideal historical scenario for recreation in 0 A.D. would be a battle between two or more civilizations that are available either in the base game or via a mod that took place in a location with sufficient geological diversity for intriguing gameplay. 

If you are, say, a Classicist teaching a history class, then you might choose one of the critical battles from the [Gallic Wars](https://en.wikipedia.org/wiki/Gallic_Wars). Late Republican Romans are in the base game, and early Imperial Romans are in the Delenda Est mod. Gauls and Britons are both in the base game, too. The definitive [Battle of Bibracte](https://en.wikipedia.org/wiki/Battle_of_Bibracte) took place about sixteen miles south of the actual historical Bibracte hilltop Gallic fort, which is now known as [Mont Beuvray](https://fr.wikipedia.org/wiki/Mont_Beuvray).[^4] Beuvray is in a strip of hillcountry with hundreds of meters of elevational changes, and the surrounding area contains rich forests, open fields, and both rivers and streams. [Julius Caesar's](https://en.wikipedia.org/wiki/Julius_Caesar) victory at Bibracte was crucial to his eventual triumph over Gaul. For the purpose of having a suitable sample for this lesson, I will make a simple recreation of the Battle of Bibracte.

2. Find a topographic map to import.

Although there are many databases of topographies online, [topographic-map.com](https://en-us.topographic-map.com/) is well suited for your use case because it [exclusively makes use of open access data](https://en-us.topographic-map.com/legal/), has detailed topographies of (nearly) everywhere around the globe, and presents topographies in a color coded format that is easy to modify in GIMP for import into Atlas.

Visit topographic-map.com, use the master search tool to find the topography that you would like to import, and select a (roughly) square area around the region that you require -- with a bit of extra space on all sides to spare -- using your operating system's screenshot or snipping tool. In order to have room for adjustments, aim for roughly 1024x1024 pixels (a more-or-less square shape between, say, 512x512 and 2048x2048).

To feature the diverse landscape of the region surrounding Mont Beuvray, and to capture that the combat in the Battle of Bibracte actually took place some 25 kilometers south of the key Gallic *oppidum* (fortified settlement), I purposefully take a screenshot that includes a larger area.

{% include figure.html filename="teach-history-and-languages-with-strategy-game-2.png" alt="Mont Beuvray selected from topographic-map.com" caption="Selecting Mont Beavray from topographic-map.com" %}

3. Modify the topographic map image in GIMP.

Per the ["Heightmap Import"](https://trac.wildfiregames.com/wiki/Atlas_Manual_Heightmap_Import) section of the Atlas Manual in the Wildfire Games Wiki, the final image must be a grayscale .png that is a perfect square with power of 2 dimensions. The brightness of a particular part of an image determines its elevation, with relative darkness corresponding to lower elevation and relative lightness corresponding to higher elevation. 

The hightmap importer in Atlas takes the image file as-is without any import time options, so it is important to modify the image to be as close to ideal for Atlas as possible prior to importing. Your objective is to minimize the amount of tuning that you will need to do after the import with Atlas's terrain tools.

Each of the following power of 2 dimensions corresponds with an [in-game terrain size that is explained in more detail here in the source code](https://trac.wildfiregames.com/browser/ps/trunk/binaries/data/mods/public/simulation/data/settings/map_sizes.json): 128x128 (Tiny), 192x192 (Small), 256x256 (Normal), 320x320 (Medium), 384x384 (Large), 448x448 (Very Large), and 512x512 (Giant). As a longtime player of 0 A.D., my opinion is that the official description of each size has been written for players with old, low-powered computer hardware with modest networking setups. If you only have old hardware and/or student laptops at your disposal, then I recommend following Wildfire Games' terrain size recommendations. If, however, you are using newer, more powerful equipment, then you should not have to give notice to the warnings that accompany the Very Large and Giant terrain sizes. Instead, you ought to consider those two sizes to be ideal for full 8-player matches, which might be best for your classroom usage. At the same time, smaller sized terrains require (much) less work in Atlas to make realistic.

Since I am purposefully making a recreation of a large-scale battle that had tens of thousands of warring men on a geographically diverse parcel of land, I will make my terrain inside a 512x512 pixel square, that is, the right size to be imported as a Giant terrain in Atlas.

The final version of the terrain in-game will be a perfect circle from inside your square with a diameter the same as the length of one of the square's sides (e.g. 512 pixels), and some space just inside the perimeter of that circle will not be usable in-game.

There are many workflows by which you could specify the image size and convert the image to grayscale in GIMP. I recommend this simple one that is likely to remain viable through future releases of GIMP:

* From the menu (top bar), click "File" -> "New," and type the square value of your choosing (e.g. Width = 512 px and Height = 512 px), then click "OK."
* Click "File" -> "Open as Layer," and select your unedited topographic map image.
* Click "Layer" -> "Scale," and, leaving the proportions locked (the chain icon connected), type the desired width or height value (e.g. my width is 911 px and height is 814 px, so I type "512" next to Height, which makes the Width value 573 automatically) and click "Scale."
* With the Toolbox open (click "Windows" -> "Toolbox"), click the four-way icon (or tap "M" on your keyboard) to select the "Move" tool, and move the layer so that the relevant geographic details are where you would like them to be in the final circular in-game terrain. Then, click "Layer" -> "Layer to Image Size" to remove everything outside the correct image dimensions from the layer.
* Click "Select" -> "None."
* Click "Image" -> "Mode" -> "Grayscale."
* Click "File" -> "Save a copy" to save a version of the image file upon which you can fallback at any time.

At this point, you have a correctly sized image that you theoretically could export as a grayscale .png file for import into Atlas, but it is most probable that it has harsh edges and stark contrasts that would yield a terrain with unplayably (and unrealistically) sharp rises and falls of elevation. Plus, if you selected topographic data in which areas with higher elevation appear darker rather than lighter when converted to grayscale (as is what happens with images from topographic-map.com), then many areas will be imported with elevational changes that are opposite of what they should be.

First, regardless of your specific terrain choice, you will need to smooth the image's internal rough edges by introducing blur. In GIMP, do the following: Click "Filters" -> "Blur" -> "Gaussian Blur." Set the Size X and Size Y values to between 2.00 and 6.00, probably about 3.50 to start. The image should be distorted enough that it lacks any rigid edges but not so distorted that its features are unrecognizable. Favor distortion, however, over clarity.

Second, if you have a topographic map image in which areas of elevated terrain appear as darker rather than lighter, then you should rectify the issue by inverting the colors of those specific regions. Here is one way to achieve this in GIMP:

* Click "Select" -> "By Color," and click on the relevant color to invert. You might need to click multiple times; GIMP compounds the selection automatically. (GIMP also allows undoing individual steps within compounded selections with CTRL+Z or "Edit" -> "Undo.")
* Click "Colors" -> "Brightness-Contrast," and increase both values until the terrain that should be lighter (elevated) is in fact lighter.
* For my specific image, the edges of the mountainous terrain have steep dark spots after this. I blur their edges manually with the "Smudge" tool (after clicking the pointing finger in the Toolbox or tapping "S" on my keyboard). I also add just a few drops of white paint (using the "Paint" tool, which is available by clicking the paintbrush icon in the Toolbox or tapping "P" on my keyboard) to the area in the north with especially higher peaks, including Mont Beuvray itself.

<div class="alert alert-warning">
You probably will need to do some trial and error with the image that results from your editing by performing iterative imports inside Atlas, so make sure that you save fallback copies of the image at every stage of editing.
</div>

Here is the final version of my image inside GIMP after doing all of these steps. I click "File" -> "Export," and I type "beauvray.png" as the name before unselecting all .png filetype export options (to make a simple file), choosing "16bpc GRAYA" for 16-bit grayscale with alpha, and turning off compression (setting the value to 0) in order to have the highest quality export possible.

{% include figure.html filename="teach-history-and-languages-with-strategy-game-3.png" alt="Mont Beuvray ready for import after editing in GIMP" caption="Mont Beauvray ready for import after editing in GIMP" %}

After clicking "Export," we are ready to advance to the next step, that is, actually importing the heightmap into Atlas.

4. Import the topographic map image into Atlas. 

Now that you have chosen a historical scenario to recreate, found a topographic map to import, and edited the topographic map image in GIMP, importing your topography into Atlas will be easy:

* Open 0 A.D.
* From the main menu, click "Scenario Editor" to launch Atlas. When asked "Would you like to quit 0 A.D. and open the Scenario Editor?", click "Yes."
* Inside Atlas, click "File" -> "Open Heightmap," and select the topographic map image that you have edited.

Here is how mine looks:

{% include figure.html filename="teach-history-and-languages-with-strategy-game-4.png" alt="Topographic map of Mont Beuvray, initially imported into Atlas" caption="Topographic map of Mont Beuvray, initially imported into Atlas" %}

The source image could have used a bit more blurring to reduce the harshness (the flat areas ought to be flatter, and the mountains ought to have less steep cliffs), as well as more contrast so that the mountains are actually at a noticeably higher altitude than the surrounding flatlands. After quickly reopening my saved backup in GIMP and making both of those changes (per step 3), this is the result:

{% include figure.html filename="teach-history-and-languages-with-strategy-game-5.png" alt="Topographic map of Mont Beuvray, edited after initial import into Atlas and then re-imported" caption="Topographic map of Mont Beuvray, edited after initial import into Atlas and then re-imported" %}

5. Add water, smooth the terrain, and adjust the terrain's other core features.

Before doing anything else to your terrain in Atlas, you ought to add water to it, perform a general landscape smoothing, and adjust its other core (elevational) features. These three tasks lay the foundation for everything else that you will place in your gameplay scenario.

Here is how you add water to the terrain. From the main menu, click the sun-shaped icon for "Environment" settings. Then, drag the "Water height" slider until there is about the right amount of water in the terrain's points of low elevation (where there ought to be water).

To smooth the terrain, click the plain green icon for "Terrain" settings. Then, click "Smooth," and adjust the size of the tool to about 20 (leaving the strength at about 10), and work around the map as needed.

Here is how my terrain looks after adding water and performing an initial smoothing:

{% include figure.html filename="teach-history-and-languages-with-strategy-game-6.png" alt="Mont Beauvray in Atlas with water added and terrain smoothed" caption="Mont Beauvray in Atlas with water added and terrain smoothed" %}

The other adjustments that you will need to perform at this stage will depend upon your terrain. Experiment with the different terrain tools, keeping sizes small (and backup copies saved) until you reach your desired result. For my sample, I have used the "Flatten," "Modify," and "Smooth" terrain adjustment tools only for a few minutes. Also, I have added a few rocky biomes to the northern mountains. Biomes are found on the bottom task bar in Atlas. 

This is the result:

{% include figure.html filename="teach-history-and-languages-with-strategy-game-7.png" alt="Mont Beauvray base terrain polished in Atlas" caption="Mont Beauvray base terrain polished in Atlas" %}

6. Add flora and fauna.

Now that you have your terrain's core features in place, it is time for you to add flora and fauna. Your objective should not be to effect a pebble-for-pebble and bird-for-bird depiction of the real-world equivalent but, rather, to capture its overall character and, more importantly, special features that matter for the historical scenario.

In Atlas, you will place all flora and fauna with the the "Object" tool, which has a person-shaped icon. Flora and fauna are categorized as units belonging to Gaia (Mother Earth). For a full list, then, filter by "gaia" (lowercase) in the top search bar.

Mont Beuvray has a blend of deciduous and coniferous vegitation. Although the surrounding flatlands are all open fields today, they probably were forested in antiquity. Accordingly, I start adding decidious and coniferous trees throughout the terrain:

{% include figure.html filename="teach-history-and-languages-with-strategy-game-8.png" alt="Adding trees in Atlas" caption="Adding trees in Atlas" %}
 
I do the same with deer and other wildlife native to the woodlands of central France.

Make sure to add all four of the game's resources -- wood, stone, metal, and food -- to your terrain, whether or not the real-world equivalent actually possesses all four of those resources. Without them, the scenario will not be playable. Wood may be found in `gaia/tree/`, stone in `gaia/rock/`, and metal in `gaia/ore/`. For food, you may add any huntable animal, berry bushes, or fruit trees; browse through Gaia's flora and fauna for food options that make sense for your terrain.

7. Add scenario-specific features.

Next, you need to add scenario-specific features to your terrain, that is, the units, structures, and everything else that will make the historical scenario actually playable.

Most importantly, each civilization ought to start either with a civic center (which defines the civilization's starting territory while allowing the creation of female citizens and basic citizen soldiers) or sufficient resources to build a civic center (typically, as of Alpha 26, 500 Wood, 500 Stone, and 500 Metal -- but it is important to check the requirements for each specific civilization inside a specific game version), as well as at least 1 unit capable of resource gathering and building. Customarily, in addition to a civic center, each civilization starts with two or three female citizens for gathering resources and building; two or three citizen soldiers for gathering resources, building, and (if needed) doing early game military defense; and a cavalryman who may serve as a scout to explore the terrain. Remember that each in-game unit can represent tens, hundreds, or even thousands of real-world counterparts.

For the Battle of Bibracte, I need to setup two civilizations: the Romans and the Gauls. For simplicity's sake, I have one player assigned per civilization (two total). I place the Gallic fortress on Mont Beuvray itself and a smaller Roman encampment in a field by the main river to the south, but I give considerably more starting resources to the Romans than to the Gauls.

Everything that I need to setup a game for two players with the correct civilizations and resources is located in the "Player" tab, whose icon looks like a small human face. First, I click that tab. Then, I set the number of players to 2. Finally, I set Player 1 on Team 1 as the Gauls with the name "Helvetii" and relatively low starting resources and Player 2 on Team 2 as the Romans with the name "Caesar's Legions" and relatively high starting resources:

{% include figure.html filename="teach-history-and-languages-with-strategy-game-9.png" alt="Adjusting the default player settings in Atlas's Player tab" caption="Adjusting the default player settings in Atlas's Player tab" %}

Next, I switch to the "Object" tab, and on the bottom of the screen, I click "Player 2" to make Player 2, the Roman civilization's manager, the owner of the units. I add a Roman Castra (Army Camp, a specialty structure) in the south, which is less advanced than a civic center but allows the creation of citizen soldiers and some siege weapons. I also place a proper civic center, mainly so that the Romans actually control their own starting territory. I set a few citizen soldiers and a cavalryman, all filtered by "rome" in the "Object" tab's search bar:

{% include figure.html filename="teach-history-and-languages-with-strategy-game-10.png" alt="Creating Rome's starting position to the south of Mont Beuvray" caption="Creating Rome's starting position to the south of Mont Beuvray" %}

After switching the Player to Player 1 on the bottom of the screen (inside the "Object" tab), I create a Gallic Fortress atop Mont Beuvray, and I place some Gallic infantry javelineers (citizen soldiers) and female citizens.

To rotate units while placing them, keep the left mouse button pressed and move it up or down. You also may adjust the rotation and/or location of any placed unit by clicking the four-way directional icon in Atlas and then clicking on the unit whose rotation and/or location you wish to change.

What you might do with these tools will depend on your specific scenario, but the basic steps will be the same.

8. Save the scenario, and distribute it.

It is time to save the scenario for distribution. First, click the gear-shaped icon to switch to the "Map" tab. Next, enter a name for the scenario, as well as a short (1-2 sentence) description. Finally, click "File" -> "Save," and type an easy-to-remember file name. Do *not* change any information under the "Random Map" area, since you are not making a Random Map. Custom scenarios are automatically saved in the game's default "mod" folder (see above), specifically `/0ad/mods/user/maps/scenarios/`. 

To distribute the scenario, share the scenario's .xml and .pmp files (two files) from that location with each person whom you would like to play with you, instructing each person to place those two files in her/his `/0ad/mods/user/maps/scenarios/` folder. (If the folder "maps" and sub-folder "scenarios" do not exist, create them, and then paste the files.)

9. Play the scenario.

You may now play your custom historical scenario as either a singleplayer or multiplayer game. If this is the first time that you have setup a game in 0 A.D., I recommend that you read the ["Setting up a game"](https://trac.wildfiregames.com/wiki/Manual_SettingUpAGame) article in the Wildfire Games Wiki. For classroom usage, the "Hosting / Joining a Multiplayer game" sub-section will be most important. 

<div class="alert alert-warning">
Depending on your network's settings, you might need to enable port forwarding on your network's firewall (0 A.D. defaults to UDP port 20595). If you have difficulty connecting with each other in your classroom or computer lab, then you ought to ask your information technology department for assistance with IP address assignments and/or the firewall's rules.
</div>

For my example, I will host a multiplayer game from a computer with FreeBSD installed and join it from a computer with OpenBSD installed. (The steps will be the same for you regardless of what desktop OS[es] you are using.) After copying the scenario's two files into the correct directory on the second machine, I return to the hosting machine. Then, I open 0 A.D. and click "Multiplayer" -> "Host Game." I choose "Map Type" as "Scenario" and click the filter "All Maps" before selecting "Bibracte." I join from the second machine by typing the host machine's local IP address, and this is the result:

{% include figure.html filename="teach-history-and-languages-with-strategy-game-11.png" alt="Hosting a multiplayer match with my custom scenario" caption="Hosting a multiplayer match with my custom scenario" %}

After "Roman Ruffian" (Player 2) clicks "I'm ready," "Gallic Guy" (Player 1, the host) clicks "Start Game," and the match begins:

{% include figure.html filename="teach-history-and-languages-with-strategy-game-12.png" alt="The multiplayer match has begun with the custom historical scenario" caption="Player 1 is ready for battle from his fortress atop Mont Beuvray" %}

## Advanced: Build a Modification from Scratch

The most advanced way to incorporate 0 A.D. into the classroom is to build a gameplay modification (mod) from scratch. You, the instructor, might wish to bring a wholly new civilization into the game. You might wish to make a custom hero for one of the base game's civilizations. You might assign mod making as a class project. Regardless of what you should decide to do, at the level of building a new mod for a game that is designed to be modifiable, your possibilities are only limited by the the Pyrogenesis game engine's own limits. The [Modding Guide](https://trac.wildfiregames.com/wiki/Modding_Guide) states:

> 0 A.D. has been designed from the beginning for ease of modding. Not just art and sound, but also the code which makes the game come to life. All the textures, 3D models, animations, sounds, fonts, and scenarios found in the game are packaged into "mods" (modifications). Additionally, a large amount of the game's logic (written in JavaScript) is packaged in mods.

I already have written about the two best sources of documentation for building a 0 A.D. mod from scratch: the official Wildfire Games Wiki and the Wildfire Games Forums. You should begin by reading the ["0 A.D. Modding Guide"](https://trac.wildfiregames.com/wiki/Modding_Guide) and ["0 A.D. Mod Layout"](https://trac.wildfiregames.com/wiki/Mod_Layout) entries in the Wiki, which themselves are cross-linked with information about what belongs where, what values change what settings, what sorts of 3D objects may be imported into the game, and more. The [Game Modification Forum](https://wildfiregames.com/forum/forum/18-game-modification/) has many active members who are eager to assist each other. As long as you have attempted to find an answer to your question or solution to your problem yourself, and you have documented the steps that you have taken toward that end, you are likely to receive a helpful answer there.

The Portuguese language (Brazilian) Youtube channel "Ágora 0AD" also has a superb ["How to Mod" series](https://youtube.com/playlist?list=PLa048WBrsGonSNZqYDmHf7B8njclVBuW6), and you may find other information scattered throughout the Web. Yet, since the 0 A.D. project only progresses by end-user upstreaming, I recommend that you use and contribute back to the Wiki and the Forums, thinking of them as both the ultimate sources of truth for 0 A.D. modding and the final destinations for what you might uncover through your work on your modding activities.

If you should have an idea for a new gameplay modification, read the Modding Guide and Mod Layout pages in the Wiki. Then, outline a plan for the mod before starting to work on it.

# Beyond?

The 0 A.D. project points to the superiority of free and open source software over proprietary software for education. With a large playerbase whose members are devoted to realism, realism is more likely to be actualized than in, say, a traditionally corporate-backed game project. Further, 0 A.D.: Empires Ascendant is fully customizable -- even able to be overhauled -- for educational use. Limitless learning is better than limited learning.

# Endnotes

[^1]: Arnab, Sylvester, Samantha Clarke, and Luca Morini. “Co‑Creativity through Play and Game Design Thinking.” Electronic Journal of E-Learning 17, no. 3 (September 1, 2019). https://doi.org/10.34190/JEL.17.3.002.

[^2]: There is a superabudance of evidence that persons learn best with multisensory activation. For one summary discussion of the matter, see Scudellari, Megan. “The Science Myths That Will Not Die.” Nature 528, no. 7582 (December 2015): 322–25. https://doi.org/10.1038/528322a.

[^3]: This sub-lesson on importing real-world geographic data into 0 A.D. to create realistic historical scenarios is based on the [Youtube channel Tom 0AD's comprehensive video tutorial on terrain importing](https://youtu.be/yBFdxOE7UFw) and ["Palaxin's Heightmap Guide" in the Wildfire Games Forum](https://wildfiregames.com/forum/topic/20786-palaxins-heightmap-guide/). Additionally, I am indebted to my international colleagues who provided feedback after my November 19, 2023 presentation “How to Incorporate Real-world Data into the Scholarship-Aware and Libre Computer Game 0 A.D. for Ancient History and Language Instruction” in the Digital Humanities in Biblical, Early Jewish, and Christian Studies Unit at the 2023 Annual Meeting of the [Society of Biblical Literature](https://sbl-site.org/) in San Antonio, Texas.

[^4]: As of early 2024, the Wikipedia article about the site of Mont Beuvray is only available in French.

--