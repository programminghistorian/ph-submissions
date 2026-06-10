---
title: "Creating Literary Network Data and Visualisations in Gephi"
slug: creating-literary-networks-gephi
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Simran Bhimjyani
- Shanmugapriya T
reviewers:
- Forename Surname
- Forename Surname
editors:
- Laura Alice Chapot
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/695
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

This beginner-friendly lesson introduces [network analysis](https://en.wikipedia.org/wiki/Network_science) for literary texts. Unlike the more commonly studied [social network analysis](https://en.wikipedia.org/wiki/Social_network_analysis), we focus on thematic network analysis, guiding you through the process of building structured data from any literary text. Our approach prioritises critical interpretation alongside technical visualisation.

## Lesson Objectives

By the conclusion of this lesson, you will be equipped to:

- Identify the primary types of literary network analysis and differentiate between character-interaction (one-mode) and thematic (two-mode) networks.
- Convert literary observations from any text into node and edge tables compatible with Gephi.
- Import datasets into Gephi and validate data integrity.
- Navigate Gephi's layout and statistical options to select the most appropriate tools for your specific network.
- Apply visual encoding such as node size, colour, and labels to produce publication-quality figures.
- Interpret a network visualisation as a critical argument, while recognising what the method can and cannot show.

No prior technical knowledge is assumed. We prioritise interpretation over visualisation for its own sake: every step is tied to a question about the text.

## General Introduction to the Lesson

This lesson aims to demonstrate how network analysis can be applied to any literary text, including plays, novels, and short stories, by transforming textual data into a structured dataset comprising nodes and edges. This method can help us understand how meaning emerges through relationships not only among characters but also between characters and themes, physical objects, or settings, among other things, in a single text or across a corpus of texts.

We undertake a thematic study of [William Shakespeare](https://en.wikipedia.org/wiki/William_Shakespeare)'s comedies and tragedies. Rather than focusing on who speaks to whom, which can be studied from a social network analysis (SNA) approach, we map how Shakespeare's characters speak about the natural world: the plants and animals named in their dialogue across these plays, by applying a thematic network analysis (TNA) approach. The dataset accompanying this lesson is sourced from the public domain and provided openly to assist readers in practising with authentic literary data from start to finish.[^1] Due to the reproducible nature of the data and workflow, you have the flexibility to adapt the dataset, apply these techniques to your own texts, or construct completely original networks to address your specific research inquiries.

This lesson complements an existing Programming Historian lesson on Gephi in Spanish, David Merino Recalde's two-part "Social Network Analysis of Theatrical Characters."[^2] The two lessons can be best read as a pair: Merino Recalde's for the social analysis of a single play, and this one for thematic analysis across a corpus. Because an introductory Gephi tutorial already exists, including the companion lesson noted above, this lesson is pitched at an intermediate level: we deliberately skip the most basic interface details and assume a first acquaintance with Gephi, in order to concentrate on the workflow and interpretation specific to two-mode thematic networks. Merino Recalde's lesson builds a one-mode social network of a single play, where characters are linked to other characters by co-appearance on stage or direct linguistic interaction, and reads the internal social structure of the work. This lesson, by contrast, builds a two-mode, or affiliation, network linking characters to a different kind of entity, categories of nature, and measures a thematic pattern across an entire corpus of comedies and tragedies.[^3] The difference is not only of subject but of method: because a two-mode network is dominated by its category hubs, we rely on weighted degree and modularity, and explain, further, why the path-based centralities ([betweenness](https://en.wikipedia.org/wiki/Betweenness_centrality), [closeness](https://en.wikipedia.org/wiki/Closeness_centrality)) that are central to a social network are far less informative here.

## The Two Types of Literary Network Analyses: SNA and TNA

Network analysis entered literary study through the social sciences. Its earliest literary applications borrowed directly from social network analysis, a method developed to map relationships between people, and asks a fundamental question: who is connected to whom? Network analysis is a common method in computational literary studies (CLS) and has been employed to study literary texts. Open-access corpora like the [DraCor](https://dracor.org) project have further normalised character network analysis in the field of CLS.[^4] Shakespeare's plays have also been extensively studied using network analysis, such as [Franco Moretti](https://en.wikipedia.org/wiki/Franco_Moretti)'s early experiments with the social network of *Hamlet*,[^5] and later studies that modelled Shakespeare's plays as character networks.[^6] These established the character-interaction approach as the dominant form of literary network analysis. In this approach, each character becomes a node, and a relationship between two characters, appearing in the same scene, speaking to one another, or being named together, becomes an edge linking their nodes. Plotting these connections across a whole play or novel produces a map of the work's social world, one that can reveal which characters hold it together, which sit at its margins, and how its communities are organised.

A network, however, can represent far more than who talks to whom. The endpoints of an edge need not be two characters. A character can be connected to a place they inhabit, an object, or a theme. When the two ends of an edge belong to different kinds of entities, characters on one side, themes on the other, the result is a two-mode, or affiliation, network, as distinct from the one-mode networks that connect entities of a single type. Affiliation networks let us ask not "who is connected to whom" but "who is connected to what," and in a literary context, that opens the door to thematic, rather than purely social, analysis.

{% include figure.html filename="en-or-creating-literary-networks-gephi-01.png" alt="A small network diagram in which character nodes are linked only to other character nodes." caption="Figure 1. A one-mode network, with characters linked to characters." %}

{% include figure.html filename="en-or-creating-literary-networks-gephi-02.png" alt="A small network diagram in which character nodes on one side are linked to nature-category nodes on the other side." caption="Figure 2. A two-mode network, with characters linked to categories of nature." %}

This lesson takes the second path and applies thematic network analysis. Instead of mapping how Shakespeare's characters relate to one another, we map how they relate to nature, specifically, to references to flora and fauna in their dialogue. Each character is a node; each category of natural reference (trees, birds, beasts, flowers, and so on) is also a node; and an edge connects a character to a category whenever that character's lines mention something belonging to it. The more often the character invokes that category, the heavier the edge. The network that emerges is therefore a portrait not of a social world but of an ecological imagination: a structured picture of which characters speak about the natural world, what kinds of nature they reach for, and how those patterns cluster across genres and genders.

Thematic network analysis of this kind remains comparatively uncommon. The overwhelming majority of literary network studies model character interaction, and the practice of connecting characters to themes, motifs, or figurative fields is only beginning to be explored, for instance in work on figurative topic networks in *Timon of Athens*[^7] and on ecological themes in computational drama analysis.[^8] This lesson builds on those precedents and offers a reproducible workflow for readers who wish to extend thematic network analysis to texts of their own.

Because our network is two-mode, a few of its measures behave differently from those in a conventional character network, a point we return to when we compute network metrics. For now, the essential idea is that by turning a body of dramatic dialogue into a network of characters and the natural world they speak of, we can examine, at the scale of an entire corpus, a question that close reading can only approach one play at a time.

## Introduction to Gephi

Gephi is a free, open-source application designed for the analysis and visualisation of networks, developed and maintained by a global community of developers and researchers.[^9] It is compatible with Windows, macOS, and Linux. While alternative tools like [Cytoscape](https://en.wikipedia.org/wiki/Cytoscape), the browser-based Gephi Lite, or [Palladio](https://hdlab.stanford.edu/palladio/) (frequently used by historians) can process the same [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) data, Gephi remains the preferred choice due to its accessibility, widespread pedagogical use, and its ability to simultaneously display both visual graphs and their underlying numerical data.

The Gephi software can be downloaded at [https://gephi.org](https://gephi.org). When starting a new project, the interface is organised around three essential tabs found at the top of the screen. First is the Overview, which serves as the primary workspace for producing and controlling network visualisations using various statistics, filters, appearance parameters, and layout algorithms. Second is the Data Laboratory, a spreadsheet-style interface that enables users to manipulate values directly and confirm the accuracy of imported edge and node tables. The third important tab is the Preview, where the active graph is polished into a final high-quality format ready for export. Additionally, the Context panel, situated on the right side of the Overview tab, provides immediate metadata regarding the active graph, including the total count of nodes and edges and whether the network is directed or undirected.

## Understanding the Data

Every network in Gephi is built from two simple tables. The first table lists the things the network is about. Each of these things is called a node. The second table lists the connections between those things. Each connection is called an edge. That is the whole idea: nodes are the entities, edges are the relationships between them. An edge can run in both directions equally, in which case we call the network undirected, or it can point one way, in which case it is directed; ours is undirected. An edge can also carry a number, its weight, recording how strong the connection is. Figures 3, 4, and 5 depict undirected, directed, and weighted networks.

{% include figure.html filename="en-or-creating-literary-networks-gephi-03.png" alt="A diagram of two nodes joined by a single line without arrows." caption="Figure 3. An undirected network of nodes and edges." %}

{% include figure.html filename="en-or-creating-literary-networks-gephi-04.png" alt="A diagram of two nodes joined by a line with an arrow pointing in one direction." caption="Figure 4. A directed network, where the edge points one way." %}

{% include figure.html filename="en-or-creating-literary-networks-gephi-05.png" alt="A diagram of two nodes joined by a line of variable thickness, indicating edge weight." caption="Figure 5. A weighted network, where the thickness of the edge records the strength of the connection." %}

In our study the nodes are of two different kinds. Some nodes are characters from Shakespeare's plays, such as Hamlet, Rosalind, and Macbeth. The other nodes are categories of nature, the kinds of plant and animal that characters mention in their speech, 14 in all (for example Animals, Birds, Fish, Reptiles, and Insects on the one hand; Trees, Garden Flowers, Fruits, Grain, and Herbs on the other). This categorisation of flora and fauna has been followed from Bessie Mayou's *Natural History of Shakespeare*.

An edge in our network always joins a character to a nature category, and it means "this character mentions this kind of nature in their dialogue." When a character mentions a specific nature entity twice, the connection is twice as strong, a weight of two. Any character can be linked to at most 14 categories, and simply counting a character's connections tells us very little; what matters is the total number of nature references they make, which the edge weights capture. As can be seen in the figures above, the network in our study will be undirected and weighted.

## From Literary Data to a Structured Dataset

This lesson is accompanied by the node and edge files that we will use for creating the network. Yet understanding how these files are created will enable building networks from any chosen text. This process starts with a question, as your objective defines the nodes and edges. For example, asking "who speaks to whom" makes characters the nodes and their interactions the edges. Conversely, asking "which characters discuss specific parts of nature" results in character and nature-category nodes joined by edges. Establishing clear extraction rules is a critical first step. You must decide, for instance, whether metaphorical references carry the same weight as literal ones, whether a term should be counted per occurrence or per speech, and how to address homonyms like "rose." While no universal standards exist, consistency and documentation are essential. In this study, every plant or animal mentioned in dialogue, literal or figurative, was recorded as a single reference on an individual row. We relied on Mayou's *Natural History of Shakespeare* to manage homonyms, ensuring that recording these decisions became an integral part of the analytical process.

The composition of your corpus is equally vital and should be dictated by your specific research question. A single play may suffice for in-depth analysis, but identifying broader patterns requires a larger sample. Whether you select an author's entire output, a random sample, or a balanced set based on genre or period, your choice will define the scope of your claims. Our study uses a genre-balanced selection of Shakespeare's comedies and tragedies rather than his complete works; consequently, our findings are specific to this sample.

The single most useful habit is to keep one master table of observations, with one row for every individual instance you find in the text. Read or search the text, and each time you find something relevant, write a row that records it along with any information you might later want to analyse. For our study, every time a character mentioned a plant or animal, we recorded a row noting the character, the word they used, the category it belongs to, the play name, its genre, and the character's gender and status or role. As you can see in the image below, nature entities are segmented as Main Topic and Sub-topic, where Rose is a sub-topic and the main topic is Garden Flower. This segmentation has been done in keeping with Mayou's original tagging system and is helpful in doing a detailed study of nature categories and their presence in characters' dialogues.

{% include figure.html filename="en-or-creating-literary-networks-gephi-06.png" alt="A spreadsheet showing the master data, with one row per nature reference and columns for character, word, category, play, genre, gender, and role." caption="Figure 6. A screenshot of the master data spreadsheet." %}

Once you have the master data, you can proceed to creating the edge and node files by following the steps below.

To make the edge file, copy just the two columns that define your relationship from the master sheet into a new, empty sheet. For instance, the two columns can be any combination of the columns, such as Main Topic, Sub-topic, character name, play name, gender, or genre. Do not remove duplicates here: every repeated row is a separate reference, and those repetitions are exactly what will become the edge weights. Rename the two headers to "Source" and "Target," and save the sheet as a CSV file. The image below is a screenshot of the edge file representing Main Topic and character, created by following the steps discussed.

{% include figure.html filename="en-or-creating-literary-networks-gephi-07.png" alt="A spreadsheet with two columns, Source and Target, listing repeated character-to-category pairs." caption="Figure 7. A screenshot of the edge sheet created from the two copied columns of Main Topic and character names, renamed Source and Target." %}

To make the node file for the Main Topic and character network, you need a list in which every Main Topic and every character appears exactly once. Start a new sheet and bring in the entities from both of your relationship columns. From the master data, copy the Main Topic column and the character-names column and stack them one below the other in a single column. This long column still has many repeats. For example, Hamlet will appear dozens of times and Reptiles many times, so now remove the duplicates. In Google Sheets or a recent version of Excel you can wrap the column in the UNIQUE function; in any spreadsheet you can instead use the Data menu's "Remove duplicates" command. The result is a clean list with one row per node. Rename this column "Id," and copy it into an adjacent column called "Label" so each node displays its own name. Finally, add a third column called "Type" that records which kind of node each row is, marking every category as "Main topic" and every character as "Character." This is the column that will later let you colour the two kinds of nodes differently. Save the sheet as a CSV file, and your node file is complete.

{% include figure.html filename="en-or-creating-literary-networks-gephi-08.png" alt="A spreadsheet with three columns, Id, Label, and Type, listing each node once and marking it as a Main topic or a Character." caption="Figure 8. A screenshot of the Main Topic and character node sheet with the Id, Label, and Type columns." %}

What you have just done for one pair of columns works for any pair. The workflow never changes: choose the two columns that express your question, copy them into a new sheet to form your edges (keeping the duplicates), then build a list of the unique values from both columns to form your nodes (removing the duplicates), adding a "Type" column to mark which is which. To study gender rather than individual characters, you would pair the category column with the gender column; to ask which plays draw on which kinds of nature, you would pair the category column with the play column. The files shared with this lesson include several such combinations: Main Topic with gender, Main Topic with genre, and Sub-topic with character, all built from the same master table in exactly this way. You can open them to study the pattern, or treat them as models for combinations of your own.

## Importing Files into Gephi

After the node and edge files are saved, you are ready to import them into Gephi. Open Gephi and choose New Project from the File menu, then click the Data Laboratory tab near the top of the window. The Data Laboratory is the spreadsheet-like view where your imported tables will appear, and it is where we begin.

<div class="alert alert-warning">
Always import the node file first and the edge file second. Loading the nodes first means that when Gephi reads the edges, every character and category they refer to already exists in the network, with the Type label you gave it.
</div>

Click the Import Spreadsheet button in the Data Laboratory toolbar and select your node file. A short series of import screens opens:

1. On the first screen, check that the Separator is set to Comma and the Charset to UTF-8 (UTF-8 keeps apostrophes and accented names intact). Set the "Import as" option to "Nodes table," and make sure "First row has column titles" is ticked. Click Next.
2. Gephi now shows the three columns it found, Id, Label, and Type, and lets you confirm how each will be imported. The defaults are correct here, so simply click Finish.
3. A final import report window appears. Set the Graph Type to Undirected and select the option to create a New Workspace. Click OK.

{% include figure.html filename="en-or-creating-literary-networks-gephi-09.png" alt="The Gephi node-import screen, showing separator, charset, and import-as settings." caption="Figure 9. The node-import screen." %}

Now click Import Spreadsheet a second time and select your edge file. The screens are much the same, with two settings that matter at the end:

1. On the first screen, confirm the Separator is Comma and set "Import as" to "Edges table." Gephi will recognise the Source and Target columns. Click Next, then Finish.
2. In the import report window, set the Graph Type to Undirected. Then find the Edges merge strategy and set it to Sum. This is the step that turns your repeated rows into weighted edges, adding up every separate mention into a single connection whose weight is the number of mentions. Finally, choose Append to existing workspace, so the edges join the nodes you already imported rather than starting a fresh, empty graph. Click OK.

Once the edges load, the import report will list 1,016 edges and warn that parallel edges were detected. This is the raw row count from your file. Once you set the merge strategy to Sum and click OK, those duplicate pairs combine into weighted edges, so the finished network shown in the Context panel has 297 nodes and 650 edges.

{% include figure.html filename="en-or-creating-literary-networks-gephi-10.png" alt="The Gephi edge-import report, showing the graph type, merge strategy, and edge count." caption="Figure 10. The edge-import report." %}

## Creating Visualisations

Once the data is imported, four panels take you from a tangle of nodes to a finished figure: Layout arranges the nodes in space, Statistics measures the network, Appearance turns those measurements into size and colour, and Preview renders the image you export.

The next step is to click on the Overview tab at the top. When your data first loads, Gephi piles every node in the centre of the graph window, and the result is an unreadable knot. To make it visually legible, we apply a layout. The most widely used layouts in Gephi belong to the [force-directed](https://en.wikipedia.org/wiki/Force-directed_graph_drawing) family, and they are usually the right starting point for a literary network.

A layout is the algorithm that spreads those nodes across the canvas into a meaningful arrangement. It is important to understand what a layout does and does not do: it changes only the positions of the nodes on screen, never the underlying data. No nodes, edges, or weights are altered. You are simply choosing how to draw the same network. Because of this, you can run a layout, undo it, and try another as often as you like until the picture communicates what you want, and different layouts will reveal different aspects of the very same network. Each layout begins from wherever the previous one left off, so you can run several in sequence, refining the arrangement in stages.

### Applying the Layouts

For the first figure, we use a sequence of three, run from the Layout panel at the bottom left of the Overview tab:

- Choose Yifan Hu from the dropdown and click Run. This fast algorithm untangles the network into a sensible overall spread in a few seconds; click Stop when it settles.
- Switch the dropdown to ForceAtlas 2 and adjust a few settings before running. Under Tuning, raise Scaling so the network is not cramped (a value around 100 works well for a few hundred nodes), and leave Gravity near its default. Under Behavior Alternatives, set Edge Weight Influence to 1.0 so heavier edges pull harder, and make sure Inverted edge weights is unticked, since when it is on, heavier edges push nodes apart instead of together. Click Run; nodes repel one another while the weighted edges pull connected nodes together, drawing out the clusters. ForceAtlas 2 keeps running until you stop it, so click Stop once the motion has all but ceased, usually after 10 to 20 seconds. Near the end, tick Prevent Overlap and run a few seconds more so nodes stop sitting on top of one another.
- Switch the dropdown to ForceAtlas and run it briefly as a final pass to tidy the spacing, then Stop.
- Finally, switch to Label Adjust and run it for a moment to nudge nodes apart so their labels do not overlap.

You can also use the Expansion, Contraction, and Reset layout options, which do as their names suggest. Experimenting with various layouts to understand the function of each is a helpful practice.

### Measuring the Network

With the network arranged, open the Statistics panel on the right. Click Run beside Avg. Weighted Degree, which adds a Weighted Degree column to the node table that records the total number of references each node carries. Then click Run beside Modularity (under Community Detection); in the dialog, keep Use weights ticked and leave the resolution at 1.0, and click OK. This adds a [Modularity](https://en.wikipedia.org/wiki/Modularity_(networks)) Class column, grouping each node into a community. These two columns are what the next stage turns into something visible. We deliberately rely on weighted degree and modularity rather than the path-based centralities used in social-network studies.[^10]

### Styling the Network

In the Appearance panel at the top left, with Nodes selected, first click the size icon (the graduated circles), choose Ranking, select Weighted Degree, set a sensible minimum and maximum (for example, 8 and 70), and click Apply; consequently, the busiest categories and characters now grow largest. Then click the colour icon (the palette), choose Partition, select Modularity Class, and click Apply, so each community takes its own colour and a category sits among the characters that share its colour. Switch on node labels with the T button on the toolbar beneath the graph, and set their size by clicking the label-size icon, choosing Ranking by Weighted Degree, so only the prominent hubs carry large text.

### Rendering the Figure

Switch to the Preview tab and click Refresh to render the styled network. Under Node Labels, tick Show Labels and set them to scale proportionally; under Edges, lower the opacity so the lines sit quietly behind the nodes; click Refresh after each change. When the image looks right, click Export and choose [SVG](https://en.wikipedia.org/wiki/SVG) or PDF for print, or PNG for the web. This exported image is the visual statement of your analysis. Figure 11 shows what the final visualisation looks like.

{% include figure.html filename="en-or-creating-literary-networks-gephi-11.png" alt="The finished two-mode network of Main Topic categories and characters, with hubs sized by weighted degree and coloured by community." caption="Figure 11. The first network, of Main Topic and characters." %}

Similarly, when you create edge and node files for the other combinations, you can go on to make other visualisations, such as those below: Main Topic and character, Sub-topic and character, play category, gender, genre, and so on.

{% include figure.html filename="en-or-creating-literary-networks-gephi-12.png" alt="A two-mode network of individual species (sub-topics) and characters." caption="Figure 12. Sub-topic and character." %}

{% include figure.html filename="en-or-creating-literary-networks-gephi-13.png" alt="A two-mode network of Main Topic categories and the two play categories, comedy and tragedy." caption="Figure 13. Main Topic and play category." %}

## Critical Interpretation of the Visualisations

A completed network serves as a form of evidence rather than a final conclusion; interpreting it requires revisiting your initial research inquiries. The three networks developed in this study examine the corpus through three distinct lenses, nature categories, dramatic genres, and individual species, with each addressing a unique question while validating the findings of the others.

The Main Topic and characters network immediately clarifies the most significant patterns through the relative size of its hubs. Animal-related categories significantly overshadow botanical ones: Animals are cited 305 times and Birds 186 times, whereas the primary plant categories, Trees and Fruits, appear only 77 and 62 times, respectively. Across the entire corpus, approximately 69% of natural references pertain to fauna, while only 31% relate to flora. However, to look closely at which characters speak of which nature entity, we need to change the combination of elements for creating the node and edge files. For example, Sub-topic and characters would help us see that.

The second network, Sub-topic and character (Figure 12), zooms in from the 14 categories to the individual creatures and plants themselves, and it sharpens the first network's claim into something concrete. One animal dominates everything: the dog, named 43 times, more than twice as often as the next creatures, the horse and the lion (17 each), the bear (16), and the fly and the snail (15). The leaders are overwhelmingly familiar and emblematic, dog, horse, cat, and ass on one side; lion, bear, and serpent on the other, and the first plant to appear in the ranking, the oak (14), trails well behind. At the level of single species, then, the animal imagination not only dominates but reaches first for the domestic and the symbolic.

Since we have two different genres, it is also interesting to find which genre has the most nature references. The third network, Main Topic and genre (Figure 13), investigates how comedy and tragedy differ in their engagement with the natural world, with edge weights serving as the primary indicator. Both genres are firmly fauna-dominated, but not identically: comedy gives a larger share of its nature references to plants (34% flora against tragedy's 27%), and it carries slightly more nature references overall (536 to 480). The thickest ribbons run from both genres to Animals and Birds, the staple imagery of the whole canon, which sit almost evenly across the two (Animals: 155 comedy, 150 tragedy). The interesting signal is in the categories that lean. Reptiles lean markedly towards tragedy (63 references against 32 in comedy), the serpents and adders of betrayal and danger, while Fruits (42 to 20), Fish (26 to 12), and Garden Flowers (21 to 10) lean towards comedy and its greener, more cultivated world. The network thus gives precise, comparative shape to a long-standing intuition about the genres rather than merely repeating it.

Read together, the three move from the general to the granular to the comparative: the categories establish that fauna dominates flora; the species reveal which particular creatures carry the weight; and the genres show that the pattern holds across comedy and tragedy while each inflects it. What the networks do, in every case, is tell you where to look. They show that Hamlet's nature language is the heaviest of any character and overwhelmingly animal; they cannot tell you why, whether that reflects misanthropy, moral disgust, or a sceptical view of human nature. Those questions belong to close reading. Computation does not replace the reading of the plays; it directs it, and gives its claims a measured footing.

## Conclusion

This lesson has taken a body of dramatic dialogue and turned it into a two-mode thematic network, moving from a master table of observations, through node and edge files, to a styled and interpreted visualisation in Gephi. The workflow is deliberately general: the same three steps, choosing the two columns that express your question, building the edges by keeping duplicates, and building the nodes by removing them, will turn any consistently recorded set of observations into a network. Nothing about the method is specific to Shakespeare or to flora and fauna; you can repurpose it for characters and settings, speakers and topics, letters and correspondents, or any other pairing your research question suggests. Above all, the lesson has tried to show that a network is an argument to be read, not a result to be reported: the visualisations told us where the weight of Shakespeare's ecological imagination falls, but the meaning of that pattern remained a matter for close reading.

To maintain scholarly honesty, several constraints must be acknowledged when interpreting these results. Because the dataset relies on a curated selection of references rather than an exhaustive extraction of every word in the primary texts, all numerical findings should be viewed as conservative lower bounds. Furthermore, the resulting networks are inherently static. By collapsing the five-act structure of each play into a single aggregate model, they are unable to illustrate the ways in which natural imagery might fluctuate, intensify, or dissipate over the course of a dramatic narrative.

These limitations also point to where the method can go next. A reader who records the act or scene of each reference can build a temporal sequence of networks and watch a theme rise and fall across a play; one who widens the corpus can test whether the fauna-over-flora pattern holds beyond comedy and tragedy; and one who adds further node types, characters, themes, and places at once, can begin to ask multimodal questions, with due caution about the measures such networks support. The dataset and files accompanying this lesson are offered as a starting point for exactly this kind of adaptation, and we hope readers will treat them less as a finished study than as a template for questions of their own.

[^1]: Our dataset is derived from Bessie Mayou's *Natural History of Shakespeare* (1877), which contains excerpts of quotations referring to 14 natural elements, such as garden flowers, wild flowers, and weeds, depicting the rich variety of natural elements in both the plays and poems of Shakespeare. The 14 categories are main topics, and these are further divided into sub-topics referring to a specific plant or animal name. The distinction between Animal and Bird, and Tree and Plant, is inherent in the text and has been followed in the metadata auditing too. Since our aim focuses on his tragedies and comedies, we have extracted flora and fauna titles only from these two genres. Additionally, we added some further details to the metadata, comprising character names, play names, identification (male, female, supernatural), status of role, and play category, besides Main Topic and Sub-topic. See Bessie Mayou, *Natural History of Shakespeare; Being Selections of Flowers, Fruits, and Animals* (Manchester: E. Slater, 1877).

[^2]: David Merino Recalde, "Social Network Analysis of Theatrical Characters (Part 1)," *Programming Historian en español* 7 (2023), https://doi.org/10.46430/phes0064.

[^3]: A two-mode, or affiliation, network records ties between two different classes of entity rather than within a single class, the classic cases being persons and the organisations they belong to, or persons and the events they attend. In this lesson the two classes are dramatic characters and categories of natural reference, and each edge records a character's "affiliation" with a category through the flora and fauna they name in their dialogue. See Stephen P. Borgatti and Martin G. Everett, "Network Analysis of 2-Mode Data," *Social Networks* 19, no. 3 (1997): 243–69.

[^4]: Frank Fischer et al., "Programmable Corpora: Introducing DraCor, an Infrastructure for the Research on European Drama," in *Digital Humanities 2019: "Complexities"* (Utrecht: Utrecht University, 2019), https://doi.org/10.5281/zenodo.4284002.

[^5]: Franco Moretti, "Network Theory, Plot Analysis," *New Left Review*, no. 68 (2011): 80–102.

[^6]: Vikas Thotakuri, "Analyzing Shakespeare's Plays in a Network Perspective" (master's thesis, University of Nebraska at Omaha, 2014); Bastian Rieck and Heike Leitte, "'Shall I Compare Thee to a Network?': Visualizing the Topological Structure of Shakespeare's Plays" (paper presented at the Workshop on Visualization for the Digital Humanities, IEEE VIS, Baltimore, MD, 2016); James Lee and Jason Lee, "Shakespeare's Tragic Social Network; or, Why All the World's a Stage," *Digital Humanities Quarterly* 11, no. 2 (2017).

[^7]: Gilad Gutman, "A Network Analysis of Figurative Topic Classification: The Case Study of *Timon of Athens*," *Digital Humanities Quarterly* 18, no. 3 (2024), https://digitalhumanities.org/dhq/vol/18/3/000753/000753.html.

[^8]: Mareike Schumacher, Marie Flüh, and Felix Lempp, "Ecologies on Stage," in *Conference Reader: Second Workshop on Computational Drama Analysis* (Berlin: DraCor, 2025), 107–25, https://doi.org/10.5281/zenodo.16936633.

[^9]: Mathieu Bastian, Sebastien Heymann, and Mathieu Jacomy, "Gephi: An Open Source Software for Exploring and Manipulating Networks," *Proceedings of the International AAAI Conference on Web and Social Media* 3, no. 1 (2009): 361–62, https://doi.org/10.1609/icwsm.v3i1.13937.

[^10]: This is the sense in which a two-mode network's measures behave differently. Because characters connect only to categories, the shortest path between any two characters almost always runs through a category hub, so path-based centralities such as betweenness and closeness mainly re-describe the hubs rather than the individual characters. Plain (unweighted) degree is similarly limited, since a character can link to at most 14 categories; it is the weighted degree (the total number of references) that carries the meaning. For these reasons we report weighted degree and modularity and set the path-based measures aside.
