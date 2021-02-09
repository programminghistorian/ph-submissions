title: Interactive Fiction in the Humanities Classroom: How to Create Interactive Text Games Using Twine
collection: lessons
layout: lesson
slug: LEAVE BLANK
date: LEAVE BLANK
translation_date: LEAVE BLANK
authors:
- Gabi Kirilloff
reviewers:
- LEAVE BLANK
editors:
- LEAVE BLANK
translator:
- FORENAME SURNAME 1
- FORENAME SURNAME 2, etc
translation-editor:
- LEAVE BLANK
translation-reviewer:
- LEAVE BLANK
original: LEAVE BLANK
review-ticket: LEAVE BLANK
difficulty: LEAVE BLANK
activity: LEAVE BLANK
topics: LEAVE BLANK
abstract: LEAVE BLANK
---

# A Table of Contents

{% include toc.html %}

--

# Introduction
Games are an increasingly important part of our cultural landscape. In 2020, the global gaming industry generated an estimated income of over 77 billion dollars. [The Entertainment Software Association](https://www.theesa.com/esa-research/2019-essential-facts-about-the-computer-and-video-game-industry/) estimates that approximately 65% of American adults play some form of video-game.

Increasingly, students and the general public are engaging history, politics, and social issues through games. For example, 2020’s bestselling *Red Dead Redemption II* (over 22 million copies sold) is set in the U.S. in 1899 and alludes to the American Civil War, industrialization, and the forced relocation of Indigenous peoples. As Krijn Boom, etc. al. note, game companies are “keen to make use of a variety of historical pasts as this provides them with recognizable themes, settings or narrative frameworks.”[^1]  However, games do not always represent the past (or the present) in an accurate or thoughtful way. Playing and making games in the classroom offers us a powerful opportunity to critique cultural narratives and create new narratives of our own.   

This lesson starts with a brief overview of games and game studies. I then move into practical suggestions for incorporating text-based games in the classroom. Lastly, I provide a technical tutorial for the open source game creation platform [Twine](http://twinery.org/). Twine offers an accessible way for students and scholars to make text-based games. The lesson assumes no prior knowledge of games/gaming and no prior technical skills. 

In this lesson you will learn: 

1.	Basic strategies for incorporating games into teaching and research. 
2.	How to create a simple text-based game using the free, open source platform Twine. 
3.	How to add complexity to a Twine game using macros and CSS styling.  

# Why Games? 
The academic study of video-games has existed since the 1990s, with scholars from multiple disciplines, including English, History, Psychology, and Education, analyzing games as cultural products. Humanities scholars draw on a number of tools and lenses to study games, borrowing from film studies, feminist analysis, queer theory, and digital rhetoric. In recent years the field of Game Studies has gained traction as the video-game industry has grown. Mainstream and independent games often deal directly with literary source material ([*Walden*](https://en.wikipedia.org/wiki/Walden,_a_game)) historical settings ([*Assassin’s Creed*](https://en.wikipedia.org/wiki/Assassin%27s_Creed)) or socio-political issues ([*Papers Please*](https://en.wikipedia.org/wiki/Papers,_Please)). For examples of game scholarship from multiple fields, see the journal [Game Studies](http://gamestudies.org/2004). 

## Creating Games
In addition to writing about games, humanities scholars are increasingly making games as a form of scholarship. Though every medium comes with advantages and disadvantages, games are particularly suited for: 

* Creating accessible, wide reaching public humanities scholarship.
* Facilitating communal play and communal learning.
* Modeling complex systems, or the relationship between options and outcomes.

For example, Wendi Sierra’s NEH funded collaborative project [*A Strong Fire*](https://securegrants.neh.gov/publicquery/main.aspx?f=1&gn=MT-268952-20) uses narrative and vocabular games to educate players about Oneida language and cultural values. The game is a collaboration among scholars in English and Game Studies, as well as artists, musicians, and tribal members. *A Strong Fire* is geared toward elementary aged children and their parents and is intended to foster intergenerational and communal play. *A Strong Fire* demonstrates the way that games as a medium can offer scholars the opportunity to create an accessible and wide reaching public platform that fills gaps in the cultural record.  

Scholars are also using games to make rhetorical arguments. As Stephen Ramsay and James Coltrain note, “games are defined by formal or informal rules, and these rules can be adapted to reflect similarly structured humanistic arguments.”[^2] Cait Kirby’s Twine game [*September 7th, 2020*](https://caitkirby.com/downloads/Fall%202020.html) allows the player to experience the first day of returning to in-person classes during the 2020 coronavirus pandemic from multiple perspectives, including an immuno-compromised college sophomore and an assistant professor. Players are confronted with complex choices that often result in equally negative outcomes, such as “Do you motion for the student to put their mask on or pull your own mask tighter?” *September 7th, 2020* argues that the decisions made by university administrators have resulted in unfair choices for students, faculty, and staff. This argument has been successfully made in many different mediums. However, putting the player in the position of making these choices lends an emotional immediacy to the appeal. 

## Teaching Games
Perhaps because of an increase in games as scholarship, games have also enjoyed increased usage in the classroom. While some instructors use games as educational tools (e.g. to teach vocabulary) others use games as texts, asking students to analyze the rhetorical messages embedded in commercial games. There are several advantages of coupling game analysis with game creation:

* Asking students to create cultural products encourages them to think critically about the design choices that inform the popular media they consume. 
* When students are tasked with creating a game, they must think carefully about audience and rhetorical choice. 
* Encouraging students to create games can be empowering. Popular games are filled with historical misconceptions, poor representation, and repetitive narratives. By creating their own games students can begin to imagine and execute the types of change they would like to see in popular media. 
* As a secondary benefit, game creation can be a good way to expose students to computational skills and careers that they may have otherwise thought were out of reach. 

One of the greatest challenges of teaching games as texts is the accessibility of games and gaming systems. Text-based games, or [interactive fiction](https://en.wikipedia.org/wiki/Interactive_fiction), are a relatively accessible medium to work with. There are [multiple platforms](https://github.com/tajmone/awesome-interactive-fiction) for creating interactive fiction. These games can be played directly in the browser and are often free to play. While text-based games and interactive fiction enjoyed mainstream success in the 1970s-80s, Twine games have enjoyed recent popularity among independent creators, queer developers, and activists. Most interactive fiction games do not require speed, dexterity, or previously learned gaming “skills.” This is significant, since many students (especially women) may not identify as gamers.[^3] 

It is also important to take accessibility and confidence levels into account when teaching game creation. According to the [Computer Science Teacher's Association](https://code.org/files/2018_state_of_cs.pdf), women and students of color are less likely to have received computer science training in middle school or high school. This, combined with harmful cultural stereotypes can result in low programming confidence levels. As a platform, Twine has several advantages: scholars and students with no programming experience can create their first Twine game within minutes of opening the platform. In addition, Twine allows scholars and students to create personalized stories. As Janet Davis notes, instructors can encourage women and minority students to engage with computer-science related skills by portraying computing as “a tool for solving problems that matter.”[^4] Twine allows students to use programming to create personalized stories and arguments that they find meaningful. 

# Scaffolding Game Creation
It is important to scaffold game creation in order to create as even a playing field as possible for students, who will come into the classroom with radically different experiences playing games. Collectively playing a game, analyzing a game, and discussing cultural and historical context is a good way to scaffold game creation. 

## Myth Busting
An important first step in creating a meaningful and inclusive environment for game creation is addressing common misconceptions. Students often start my classes believing that:  

* Games are purely for entertainment and are ideologically “neutral.”
* Certain types of games are more legitimate than others.
* Only certain types of people play games (they may feel that the games they play, such as mobile games, do not qualify as “real” games).
* Games make us more empathetic and understanding.

Playing and analyzing a game is a helpful way to challenge these assumptions. Games with strong rhetorical arguments are a good place to start. I begin many of my game units with Zoe Quinn’s Twine game [*Depression Quest*](http://www.depressionquest.com/), in which you play as someone living with depression.  

{% include figure.html filename="Figure1.jpg" caption="Figure 1. Example from *Depression Quest*" %}

The game aims to help people understand the depths of mental illness. While the game treats depression respectfully, students should be provided with a [content warning](https://sites.lsa.umich.edu/inclusive-teaching/inclusive-classrooms/an-introduction-to-content-warnings-and-trigger-warnings/#:~:text=Content%20warnings%20are%20verbal%20or,disengage%20for%20their%20own%20wellbeing.). Students often react to this game by noting that: they did not realize games could be about serious topics, they did not realize a game could make an argument, and they did not realize a game could be a story. 

## Analyzing a Game
I find it helpful to lead in-class game analysis with a series of questions that draw attention to the rhetorical nature of games:

* What is the game’s argument? 
* What design decisions (at the level of both narrative and mechanics) contribute to this argument? 
* Who is the intended audience? What design decisions were made to engage this audience?  
* What is the relationship between you, the player, and the [player character](https://en.wikipedia.org/wiki/Player_character) (the character controlled by the player)? 

For example, in *Depression Quest*, the player character’s mother pressures the player character to stop “sitting around feeling sad.” The game’s [mechanics](https://en.wikipedia.org/wiki/Game_mechanics), or the rules that govern gameplay, push against this attitude—the player is presented with seemingly positive options (as is shown in Figure 1.) that they cannot choose. The story and mechanics work together to argue against the harmful conception that those suffering from depression can simply choose to stop feeling sad. This suggests that the game is geared towards players who might be in support roles for a friend or family member living with depression. It is also important to question the degree to which the game creates empathy: by playing *Depression Quest*, does the player know what it is like to live with depression? While the game might cause the player to feel emotion for a given character, this does not mean that the player can fully understand another positionality or that the player will act differently after playing the game. Games can emotionally move us, but they do not necessarily change our actions.

## Cultural Context and Theoretical Approaches
It is difficult to talk about games without talking about issues of representation. While students may not be directly familiar with the ways these issues shape the gaming industry, many will be familiar with implicit arguments and stereotypes: “women don’t play real games,” “the hero is usually a white guy.” 

The specific pieces of cultural and historical context you might use to frame this discussion depends on the nature of the class and the games you are playing/making. I often teach games in Women and Gender Studies classes. I find it helpful to discuss the [“Gamergate”](https://en.wikipedia.org/wiki/Gamergate_controversy) controversy of 2014, an online harassment campaign directed against women in the gaming industry (Zoe Quinn, the creator of *Depression Quest*, was the initial target). 

I also find it useful to raise questions about how games are made. Since Gamergate, studios have received increased pushback for a lack of diversity in representation. In some cases this has resulted in more diverse representation but not better representation. For example, *Red Dead Redemption II* faced criticism for its depiction of Charles, a black and indigenous character. Part of the critique stemmed from the fact that a non-indigenous, non-black actor was cast to voice Charles. This type of example raises productive questions for classroom discussion: Who gets to make games and why? What does it mean to represent the past “accurately”? Who gets to tell another person’s story?

Drawing on theoretical approaches to game studies can also provide useful context. Feminist Game Studies and [Queer Game Studies](https://www.upress.umn.edu/book-division/books/queer-game-studies) offer useful frameworks for talking not only about representation, but about the ways in which different types of play (e.g. competitive play versus communal play) can bolster and subvert cultural values. I also find it helpful to introduce students to the concept of [procedural rhetoric](https://en.wikipedia.org/wiki/Procedural_rhetoric#:~:text=Procedural%20rhetoric%20analyzes%20the%20art,to%20convey%20a%20particular%20ideology.), the idea that mechanics are as rhetorical and persuasive as narrative. 

# Game Assignments 
Because of Twine’s accessibility, it is possible to teach game creation as a single small assignment or to organize an entire course around creating games. In either case, the goal of game creation in the humanities classroom is not purely technical. I never teach game creation for game creations sake. Instead, the goal is typically to better understand games as cultural products or to connect cultural and historical concepts to a contemporary medium. Below are a few examples from myself and others of how game assignments can be integrated into a course.

## Highschool History, Ninth-grade Ancient World History
[Jeremiah McCall](https://gamingthepast.net/about/) has written extensively about the benefits of teaching Twine in the history classroom. McCall has integrated a long-term (one quarter to one semester long) Twine “interactive history project” into several of his classes. For this assignment students create a game centered on a historical figure. They must first perform extensive research on the figure and time period before completing a research essay that helps them plan the game. A key component of this essay is that students must answer the questions: What choices (and actions) did the historical figure make and why? What were the consequences of those choices? 

## College Writing, Composition Classroom
[Jonathan Kotchian](http://techstyle.lmc.gatech.edu/teaching-composition-with-interactive-fiction/) advocates using interactive fiction platforms (including Twine) to teach composition. Kotchian first has his students play an interactive fiction game. He notes that interactive fiction is especially useful for highlighting reader response—students will each have a different experience playing the game, which helps the class understand the way in which all texts actively construct their audiences. Students then create their own game. Kotchian notes that game creation puts a heightened emphasis on the processes of drafting, collating, and revising.  

## College English, Intro to Women’s Writing
In this class, I teach women’s literature from 1890 to the present, with an emphasis on historical context and connections to the present. The course moves forward chronologically and the last two-week unit focuses on games. Students read about Gamergate and play games by female creators. For their final assignment, each student creates a Twine game about their opinions on an issue we have discussed in class. Students have chosen to create games on issues such as the intersection of mental health and gender, workplace discrimination, and body shaming. 

## College English, Intro to Digital Humanities
In this class I teach a variety of digital methodologies useful to the humanities scholar, including computational text analysis and geographic information systems (GIS). I also ask students to consider cultural issues surrounding technology, such as [algorithmic bias](https://en.wikipedia.org/wiki/Algorithmic_bias). During the last three week unit, students play, analyze, and learn to make Twine games. For their final assignment, each student creates a Twine game that makes an argument about technology. In the past, students have chosen to create games about issues such as social media usage and mental health, online bullying, and gaming addiction. 

# Creating a Basic Twine Game
[Twine](http://twinery.org/) is free to use. It can be downloaded and run on your desktop, but it can also be run directly in the browser. When using Twine in the browser, avoid Internet Explorer and Safari. To get started with the browser version, simply click "use it online," then "+Story."

One potentially confusing aspect of Twine is that the platform allows you to work with several [story formats](https://twinery.org/wiki/twine2:how_to_choose_a_story_format), or visual layouts. The syntax for each story format works a little differently. The examples I am using are written for the default format, Harlowe 3.2. When looking for answers to your Twine question on the web, make sure you include the story format in your query: e.g. “how to change background color in Twine Harlowe 3.2”.

I will be using examples from a simple Twine game inspired by many of the games my students have created in Intro to Women’s Writing. The player character moves through her first day of a summer internship with a tech company. The game deals with several of the themes my students choose to write about, including workplace discrimination and the fatigue that comes from being a minority in the workplace. The game also draws from issues my students are eager to discuss in Intro to Digital Humanities. If you’d like to examine the game in its entirety, you can download it from the resources section.

## Passages/Links
The basic organizational unit in Twine is a passage. A passage is one “screen” of text that the player will see before navigating to another screen. Players navigate between different passages using links. If a single passage contains multiple links, it creates a branching narrative. To create a link in Twine simply place double brackets around the text that you would like to turn into a link. Consider the following example:

```
Ann smiles encouragingly, and suggests that you might be interested in working with Brad, who is tackling some of the more complex coding challenges on the project.

Steve looks doubtful..."I don't know, Ann, maybe working with the focus group of users would be a better fit?" You hear Ann let out a small sigh. Steve and Ann turn to you expectantly...

Say you would love to [[work with Brad]].
Say you are interested in working with [[users]].
```
If you would like to follow along, you can cut and paste the above example into a Twine passage. This passage will present the player with two links: “work with Brad” and “users.” When you create these links, Twine will automatically create two new passages. The result will be a branching narrative. The first figure below shows the appearance of this narrative in the developer view, the second shows what the game will look like to the player: 

{% include figure.html filename="Figure2.jpg" caption="Figure 2. Branching Narrative in Twine" %}

{% include figure.html filename="Figure3.jpg" caption="Figure 3. How a Branching Narrative Appears in Game" %}

At any point in working on your Twine passages, you can view the game from the player's perspective by clicking the "Play" button at the bottom of the screen. 

## Choices
You can create a successful Twine game using only passages and links. However, there are some basic principles of game design that can turn a technically simple game into a narratively complex game. Fair choices, meaningful choices, and difficult choices are three important concepts for creating a Twine game. 

### Fair Choices
A choice is “fair” if the player can understand the relationship between the choice and the outcome. Say you present the player with two choices at the end of your game: “take the path to the right”, “take the path to the left.” No additional context is given. The path to the right results in victory. The path to the left results in a loss. This choice is unfair because the consequences appear random, and are not logically connected to the player’s choice. 

### Meaningful Choices
A meaningful choice is a choice that matters. It will likely connect to the game's outcomes. Say you present your player with two choices: “grab an apple for a snack”, “grab a banana for a snack.” No additional context is given and the choice does not impact the outcome. This choice is meaningless because it does not carry emotional weight nor does it connect to an outcome. 

### Difficult Choices
This is not to say that a choice cannot result in an unanticipated outcome. A choice is difficult if it requires the player to weigh positive and negative risks, possibilities, and costs. Say you present the player with two choices: “win the lottery”, “lose all of your money gambling.” Without additional context, this choice is too easy as it presents a clear “win” scenario and no reason for the player to dither between choices.  

## Saving Your Game
If you are using Twine in the browser, you will want to download a copy of your story at the end of each working session and upload a copy of your game at the beginning of each new session. Twine does not actually save your work in the browser! It caches your progress. This means that if you run a software update or clear your browsing history, your content will not be saved. 

To download your work, click the triangle at the bottom left hand corner of your developer screen and then click “Publish to File.” This will download an html file of your game onto your Downloads folder. You can than upload this html file by clicking the “Import From File” button under the “+ Story” button. 

{% include figure.html filename="Figure4.jpg" caption="Figure 4. Publishing Your Game to File" %}

{% include figure.html filename="Figure5.jpg" caption="Figure 5. Uploading Your HTML File to Twine" %}

# Adding Complexity 
While it is possible to create a Twine game with minimal instruction, Twine supports its own coding syntax, as well as elements of [HTML](https://www.w3schools.com/html/) (the same language used to create webpages) and [CSS](https://www.w3schools.com/w3css/) (the same language used to style webpages). 

## Macros
Macros are pieces of code inserted into Twine passages that add technical complexity. Macros can be used to create timers, scoring, and text that changes based on the decisions a player makes. Macros typically follow a syntactical pattern. Consider the following:

`(set: $confidence to 5)`

I am using the “set” macro to create a variable called confidence. You want to create your variables on your very first passage, so that you can keep track of them. The player will not be able to see them. Most macros are nested inside of parenthesis and include a colon after the name of the macro. 

I can use the confidence variable to keep track of the player’s choices. Say the player clicks on a passage. I want this decision to lower the value of the confidence variable. I can put the following macro on that passage:

`(set: $confidence to it -1)`

After choosing that passage, confidence is now equal to 4. In and of itself, this doesn’t accomplish anything. The player will not see the confidence variable unless I choose to show it to them:

`(print: $confidence)`

The "print" macro displays the following value to the player. I can also change what happens in the story based on the value of a variable: 

```
(if: $confidence is < 3)[You are having serious doubts about whether you are cut out for this. It's not just the technical stuff, it's the ability to work with the team. You start to wonder if you should switch majors...]

(else:)[Today was alot, but you realize that a lot of the challenges you encountered aren't your fault and you're impressed with your ability to stand up for yourself.]
```

The "if" macro allows me to create a [conditional statement](https://en.wikipedia.org/wiki/Conditional_(computer_programming)): if x than y. Above, this macro means that, when the player reaches this passage, if the confidence variable is less than 3, Twine will display the text contained in single brackets. The text in single brackets is called a hook. A hook is what will happen if the proceeding macro is true. 

Students are often excited to use macros and hooks because they increase technical complexity. Programming can be fun! However, it’s important to spend time on why macros can help tell a more compelling story. At the beginning of my sample game about a summer internship, I set the following variables: 

```
(set: $confidence to 5)
(set: $energy to 5)
(set: $isolation to 0)
```
Consider how these variables interact if the player decides to take manager Steve’s suggestion to work with users, rather than take mentor Ann’s suggest to work with Brad on a complex programming task:

```
You're actually super excited by the possibility of working with users--it's one of your favorite parts of what you do. 

You're confident in your technical abilities, but are hoping to land a job as a liaison between devs and clients after school. 

While you're initially happy you were honest, you see a frown cross Ann's face and think you see Steve smirk. You're aware of the stereotype that female devs are better at "soft skills" than programming and worry that you just confirmed Steve's bias and made Ann's life more difficult. Worrying about this is already making you tired. 

After the meeting, Steve shows you to [[your desk.]]

(set: $energy to it -1)
(set: $isolation to it +1)
```
Deciding to work with users does not negatively impact the player character’s confidence. The player character isn’t insecure about her technical abilities, she would just rather work with users. However, the choice does take an emotional toll and causes the player character to feel isolated from her mentor Ann. Conversely, deciding to work on the complex programming task negatively impacts the player character’s confidence, not because she isn’t capable, but because she isn’t interested. 

Throughout the game, choices offer a tradeoff. Speaking up might increase confidence, but result in fatigue. The variables interact to create difficult choices. There is no “right” answer. In addition, the variables counter player expectations. I can then leverage these choices to present different outcomes at the end of the game. 

## Styling
While Twine is a text-based platform, it is possible to incorporate images, sound, and other visual elements into your game. Basic textual styling, like underlining, bolding, and italicizing, can be accomplished by wrapping text in special characters: double forward slashes are used for italics, double tildes for strikethroughs, and double single quotation marks for bold. Harlowe 3.2 now also includes a toolbar directly in each passage that will allow you to automatically style selected text. 

Macros and hooks can be used to apply slightly more complex styling, such as changes in font color:

`(color: yellow)[summer internship]`

Twine is an HTML based language and can be styled using an attached CSS stylesheet. You can access the stylesheet (which by default is empty) by clicking the triangle at the bottom left hand corner of your developer screen and then clicking “Edit Story Stylesheet.” The sample of CSS below changes the background color of the game to white (from the default black) and the font color to grey (from the default white):

```
tw-story {background-color: white;
color: grey;}
```

CSS expressions begin with a [selector](https://www.w3schools.com/cssref/css_selectors.asp), the selector indicates which portion of the text you want to style. In this case, the special “tw-story” selector, indicates that the styling will be applied to the entire Twine story. 

One common point of confusion is when to use macros for styling and when to use the stylesheet. Typically, it is easier to make changes to individual words or passages using a macro and easier to apply changes to the entire game or to large sections of the game using the stylesheet. As with macros, it is important to ask your students what purpose styling serves; does it contribute to the game’s argument or the emotions the game is producing? It is tempting to spend time on styling that does not actually contribute to the rhetorical sophistication of the game. The text with a strikethrough from *Depression Quest* (Figure 1.) is a great example of styling that adds meaning. 

# Resources
If you would like to play with Twine or potentially integrate it into a course, you may want to start by playing some Twine games to get a sense of what is possible. The following is a list of resources pertaining to Twine and interactive fiction in the classroom. All of the games are free and most can be played in under 15 minutes, making them suitable for communal in-class play sessions.  

## Twine Games
* [*A Witch’s Word*](https://rainbowstarbird.itch.io/a-witchs-word) by RainbowStarbird
* [*Depression Quest*](http://www.depressionquest.com/) by Zoe Quinn
* [*Play Smarter Not Harder: Developing Your Scholarly Meta*](https://src-online.ca/index.php/src/article/view/333) by Jason Helms
* [*Queers in Love at the End of the World*](https://w.itch.io/end-of-the-world) by Anna Anthropy
* [*September 7th, 2020*](https://caitkirby.com/downloads/Fall%202020.html) by Cait S. Kirby
* [*The Uncle Who works for Nintendo*](https://ztul.itch.io/the-uncle-who-works-for-nintendo) by Michael Lutz

## Twine Resources
* [*Twinery*](http://twinery.org/)
* [*Twine Wiki*](https://twinery.org/wiki/)
* [*Adam Hammond Tutorials*](http://www.adamhammond.com/twineguide/)

## Additional Game Pedagogy Resrouces
* ["Interactive Fiction in the Classroom"](https://www.edutopia.org/blog/interactive-fiction-in-the-classroom-matthew-farber) by Matthew Farber
* [*Teaching With Twine*](https://teachingwithtwine.wordpress.com/resources/) by Brandee Easter
* [*Twine for Education*](https://twinery.org/wiki/twine:education)

## Endnotes
[^1]: Krijn H.J. Boom, et al. 2020. “Teaching through Play: Using Video Games as a Platform to Teach about the Past.” Paper presented at *Communicating the Past in the Digital Age*.
[^2]: James Coltrain and Stephen Ramsay, “Can Video Games Be Humanities Scholarship?” in *Debates in the Digital Humanities,* ed. Matthew K. Gold and Lauren F. Klein (Minneapolis, MN: University of Minnesota Press, 2019). 
[^3]: For more information about who identifies as a "gamer" and why, see, Adrienne Shaw, “Do You Identify as a Gamer? Gender, Race, Sexuality, and Gamer Identity,” *New Media & Society* 14, no. 1 (2012): 28.
[^4]: Janet, Davis, “5 Ways to Welcome Women to Computer Science,” *Chronicle of Higher Education* (Nov. 18, 2019).


