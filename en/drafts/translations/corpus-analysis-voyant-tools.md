---
title: "Corpus Analysis with Voyant Tools"
slug: corpus-analysis-voyant-tools
original: analisis-voyant-tools
layout: lesson
collection: lessons
date: 2019-04-20
translation_date: YYYY-MM-DD
authors:
- Silvia Gutiérrez De la Torre
reviewers:
- Daniela Ávido
- Jennifer Isasi
editors:
- Jennifer Isasi
translator:
- Eime Javier Cisneros Brito
- Alberto Santiago Martínez
translation-editor:
- Giulia Taurino
translation-reviewer:
- Roberto Vargas
- Marisol Andrade Muñoz
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/608
difficulty: 1
activity: analyzing
topics: [distant-reading]
abstract: En este tutorial se aprenderá cómo organizar y analizar un conjunto de textos con Voyant-Tools.
avatar_alt: Grafas con diferentes graduaciones de oftanmología
mathjax: true
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

In this lesson, you will learn how to organize a set of texts for research; that is, you will learn the basic steps of creating a *corpus*. You will also learn the main metrics of quantitative text analysis. For this purpose, you will use [Voyant Tools](http://voyant-tools.org/) (Sinclair and Rockwell, 2016), a web-based platform that does not require installation and works in any browser with an Internet connection.

This tutorial is designed as a beginner-friendly introduction to *corpus* analysis and is part of a growing ecosystem of tools and methods in digital humanities. For a more advanced tool, see the [Programming Historian lesson on AntConc](https://programminghistorian.org/en/lessons/corpus-analysis-with-antconc). You may also be interested in other *Programming Historian* lessons on [text mining](https://programminghistorian.org/en/topics/text-mining), [natural language processing](https://programminghistorian.org/en/lessons/introduction-to-nlp-with-python), and [topic modeling](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet).

### Prerequisites and Further Reading

No prior experience with text analysis is required. However, for those who want to go deeper, we recommend the following resources:

- **Voyant Tools Help Documentation**: [https://voyant-tools.org/docs/#!/guide/start](https://voyant-tools.org/docs/#!/guide/start)
- **Hermeneuti.ca**: [http://hermeneuti.ca/](http://hermeneuti.ca/) — the companion site to the book *Hermeneutica: Computer-Assisted Interpretation in the Humanities* by Sinclair and Rockwell

### Corpus Analysis

Corpus analysis is a type of [content analysis](https://vocabularyserver.com/tadirah/en/index.php?tema=26&/content-analysis) that allows large-scale comparisons of a set of texts or a corpus.

Since the advent of computing, both computational linguists and [information retrieval](https://vocabularyserver.com/tadirah/en/index.php?tema=107&/information-retrieval-analysis-content-analysis) specialists have created and used software to notice patterns that are not evident in apparent to the naked eye or to corroborate hypotheses they intuited when reading certain texts but required laborious, costly, and mechanical work. For example, to obtain patterns of increase and decline in usage of certain terms over a given period, it was necessary to hire people to manually review a text and note how many times the sought term appeared. Early on, observing the counting capabilities of computers, these specialists promptly wrote programs to facilitate the task of creating frequency lists or concordance tables (i.e., tables with the left and right contexts of a term). The program you will learn to use in this lesson fits into this historical context.

### What You Will Learn in This Tutorial

Voyant Tools is a web-based tool that does not require the installation of any specialized software as it works on any computer with an Internet connection.

As stated in this other [tutorial](https://programminghistorian.org/en/lessons/corpus-analysis-with-antconc), this tool is a good entry point to more complex methods.

By the end of this tutorial, you will be able to:

- Assemble a plain text corpus
- Load your *corpus* into Voyant Tools
- Understand and apply different *corpus* segmentation techniques
- Identify basic characteristics of your text set:
  - Length of the uploaded documents
  - Lexical density (called vocabulary density on the platform)
  - Average words per sentence
- Read and understand different statistics about words: absolute frequency, normalized frequency, statistical skewness, and distinctive words
- Search for keywords in context and export data and visualizations in different formats (csv, png, html)

## Creating a Plain Text Corpus

Although VoyantTools can work with many formats (HTML, XML, PDF, RTF, and MS Word), in this tutorial you will use plain text (`.txt`) files. Plain text has three fundamental advantages: it has no additional formatting, does not require a special program, and does not require extra knowledge of text analysis. The steps to create a plain text *corpus* are:

### 1. Search for Texts

The first thing you need to do is search for the information that interests you. For this tutorial, we have prepared a *corpus* of President George Washington's annual messages to Congress from 1789 to 1796. This *corpus* has been released under a Creative Commons CC BY 4.0 license and you can use it as long as you cite the source as follows:

> Cisneros, J., & Martinez, A. (2024). presidential-speeches-GW_v1 (Versión v1).
> [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.11456208.svg)](https://doi.org/10.5281/zenodo.11456208)

### 2. Copy to a Plain Text Editor

Once you have located the information, the second step is to copy the text you are interested in from the first word spoken to the last and save it in a plain text editor. For example:

- In Windows, it could be saved in [Notepad](https://web.archive.org/web/20091013225307/http://windows.microsoft.com/en-us/windows-vista/Notepad-frequently-asked-questions)
- In Mac, in [TextEdit](https://support.apple.com/guide/textedit/start-new-documents-txtee6663a0e/mac)
- And in Linux, in [Gedit](https://gedit-technology.github.io/apps/gedit/)

### 3. Save File

When saving the text, you must consider three essential things.

1. **Save your texts in UTF-8**, which is a standard encoding format for English, Spanish and other languages.

   > **What is UTF-8?**  
   > Although we see an "É" when typing an "É" on our screen; for a computer, "É" is a series of zeros and ones that are interpreted as an image depending on the "translator" or "encoder" being used. The encoder that contains binary codes for all the characters used in Spanish and English is UTF-8. Continuing with the example, "11000011" is an eight-bit string – that is, eight information spaces – which in UTF-8 are interpreted as "É".

   **On Windows**:

1\. Open Notepad

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-01.gif" alt="Screenshot of the Notepad application on Windows, showing the process of saving a file with UTF-8 encoding. The 'Save As' dialog box is open, with 'UTF-8' selected in the Encoding dropdown menu" caption="Figure 1. Save in UTF-8 on Windows" %}

2\. After pasting or writing the text, click on 'Save As'
3\. In the 'Encoding' window, select 'UTF-8'
4\. Choose a file name and save it as .txt (Torresblanca, 2014)

   **On Mac**:

1\. Open TextEdit

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-02.gif" alt="Screenshot of TextEdit on a Mac, illustrating how to save a file as plain text with UTF-8 encoding. The 'Convert to Plain Text' option is selected from the Format menu, and 'UTF-8' is chosen in the encoding settings." caption="Figure 2. Save in UTF-8 on Mac" %}

2\. Paste the text you want to save
3\. Convert to plain text (option in the 'Format' menu)
4\. When saving, select the encoding 'UTF-8' (Creative Corner, 2016)

   **On Linux**:

1\. Open Gedit

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-03.gif" alt="Screenshot of Gedit on Ubuntu, demonstrating how to save a file in UTF-8 encoding. The 'Character Encoding' dropdown menu is shown with 'UTF-8' selected during the saving process." caption="Figure 3. Save in UTF-8 on Ubuntu" %}
   
2\. After pasting the text, when saving, select 'UTF-8' in the 'Character Encoding' window

The second is that your file name should not contain accents nor spaces to ensure it can be opened on other operating systems

   > **Why avoid accents and spaces in file names?**  
   > For similar reasons to the previous point, a file named Ébano.txt will not always be correctly understood by all operating systems since several have a different default encoder. Many use ASCII, for example, which only has seven bits, so the last bit (1) of "11000011" is interpreted as the start of the next character and the interpretation is skewed.

3. **Integrate context metadata** (e.g., date, genre, author, origin) into the file name, allowing you to divide your *corpus* according to different criteria and also read the results better.

For this tutorial, we have named the files with the month, day, year, and order in which President George Washington delivered the Annual Message to Congress.

`january_8_1790_first.txt` has the month of the speech separated by an underscore, the number of month, the year, and the order.

---

## Uploading the Corpus

On the Voyant Tools homepage, you will find four simple options for loading texts. The first two options are in the white box. In this box, you can directly paste a text that you have copied from somewhere; or, paste web addresses – separated by commas – of the sites where the texts you want to analyze are located. A third option is to click on “Open” and select one of the two corpora that Voyant has preloaded (the works of Shakespeare or the novels of Austen: both in English).

Finally, there is the option we will use in this tutorial, where you can directly upload the documents you have on your computer. In this case, you will upload the complete *corpus* of presidential speeches.

To upload the materials, click on the icon that says "Upload," open your file explorer, and, while holding down the "Shift" key, select all the files you want to analyze.

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-04.png" alt="Voyant Tools interface showing the 'Upload' button highlighted. The file explorer window is open, allowing users to select multiple files for analysis by holding down the 'Shift' key." caption="Figure 4. Upload documents" %}

## Exploring the Corpus

Once all the files are uploaded, you will reach the "interface" that has five default tools. Here is a brief explanation of each of these tools:

- Cirrus: word cloud showing the most frequent terms

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-05.png" alt="Word cloud generated by Voyant Tools, displaying the most frequent terms in a corpus. The most prominent words are shown in larger fonts, indicating higher frequency." caption="Figure 5. Cirrus" %}

- Reader: space for reviewing and reading the complete texts with a bar graph indicating the amount of text each document has

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-06.png" alt="Voyant Tools interface showing the 'Reader' window, where the full text of documents is displayed. A bar graph on the side indicates the length of each document in the corpus." caption="Figure 6. Reader" %}

- Trends: distribution graph showing terms throughout the *corpus* (or within a document when only one is uploaded)

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-07.png" alt="Graph in Voyant Tools showing the distribution of specific terms across a corpus over time. The graph visualizes how the frequency of terms varies throughout the documents." caption="Figure 7. Trends" %}


- Summary: provides an overview of certain textual statistics of the current corpus

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-08.png" alt="Summary window in Voyant Tools providing an overview of key statistics for the current corpus, including the number of documents, total words, unique words, and other textual metrics." caption="Figure 8. Summary" %}

- Contexts: concordance showing each occurrence of a keyword with a bit of surrounding context

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-09.png" alt="Concordance window in Voyant Tools displaying each occurrence of a keyword within its surrounding context. The window shows the keyword centered with left and right contextual words." caption="Figure 9. Contexts" %}

## Document Summary: Basic Characteristics of Your Set of Texts

One of the most informative windows in Voyant is the summary. Here you can get an overview of some statistics about your corpus, so it serves as a good starting point. In the following sections, you will get an explanation of the different measures that appear in this window.

### Number of Texts, Words, and Unique Words

The first sentence looks something like this:

> This *corpus* has 9 documents with 17,893 total words and 3,169 unique word forms. Created 53 seconds ago.

From the start, with this information, you know exactly how many distinct documents were uploaded (9); how many words there are in total (17,893); and how many unique words exist (3,169).

Below, you will find nine activities that can be resolved in groups or individually. Five of them have answers at the end of the text to serve as a guide. The remaining four activities are designed to encourage reflection and discussion among participants who engage with them.

**Activity 1**

If your *corpus* consisted of two documents; one that said: "I'm hungry"; and another that said: "I'm sleepy." What information would appear in the first line of the summary? Complete:

*Hint: Count total documents (2), all words (“I’m hungry” and “I’m sleepy”), and how many of those are unique (repeated words like “I’m” only count once).*

> This *corpus* has __ documents with a total of __ words and __ unique words.

---

### Document Length

The second thing you'll see is the "document length" section. Here is what it shows:

- **Longest**: `november_19_1794_sixth (2926); december_7_1796_eighth (2864); november_6_1792_fourth (2345); october_25_1791_third (2267); december_8_1795_seventh (1977)`  
- **Shortest**: `january_8_1790_first (848); december_8_1790_second (1400); april_30_1789_first_Inaug… (1433); december_3_1793_fifth (1833); december_8_1795_seventh (1977)`

**Activity 2**

1. What can you conclude about the longest and shortest texts considering the metadata in the file name (year, country, president)?  
2. Why is it useful to know the length of the texts?

*Hint: Use the metadata in the file names (year, month, etc.) to consider why certain speeches are longer or shorter. This might reflect historical context or changes in communication style.*

---

### Vocabulary Density

Vocabulary density is measured by dividing the number of unique words by the total number of words. The closer the density index is to one, the richer the vocabulary, meaning it is denser.

**Activity 3**

1. Calculate the density of the following stanzas, compare, and comment:

   **Stanza 1.** From “Silly Men Who Accuse” by Sor Juana Inés de la Cruz:  
   > For plain default of common sense, could any action be so queer  
   > as oneself to cloud the mirror, then complain that it’s not clear?

   **Stanza 2.** From “Alejandro” by Nadir Khayat and Stefani Germanotta:  
   > Don't call my name, don't call my name Alejandro.  
   > I'm not your babe, I'm not your babe Fernando.  
   > Don't wanna kiss, don't wanna touch.

*Hint: Compare the vocabulary richness in the two stanzas. A higher ratio of unique words to total words means higher density.*

2. Read the lexical density data of the documents in your corpus, what do they tell you?

   - **Highest**:  
     `january_8_1790_first (0.462); december_3_1793_fifth (0.436); april_30_1789_first_Inaug… (0.417); december_8_1790_second (0.409); december_8_1795_seventh (0.398)`

   - **Lowest**:  
     `december_7_1796_eighth (0.338); november_6_1792_fourth (0.340); october_25_1791_third (0.343); november_19_1794_sixth (0.375); december_8_1795_seventh (0.398)`

3. Compare them with the information about their length, what do you notice?

---

### Words per Sentence

The way Voyant calculates sentence length should be considered a rough estimate, especially because it is complicated to distinguish between the end of an abbreviation and that of a sentence or other uses of punctuation (for example, in some cases a semicolon marks the boundary between sentences). The sentence analysis is performed by a template with instructions or "class" of the Java programming language called [BreakIterator](https://docs.oracle.com/javase/tutorial/i18n/text/about.html).

**Activity 4**

1. Look at the statistics of words per sentence (wps) and answer: what pattern or patterns can you observe if you consider the "wps" index and the metadata of country, president, and year contained in the document name?  
2. Click on the names of some documents that interest you by their "wps" index. Direct your gaze to the "Reader" window and read a few lines. Does reading the original text add new information to your data reading? Comment on why.

*Hint: Consider if longer sentences reflect complexity of expression or differences in transcription. Reading excerpts may help interpret the data.*

---

## Cirrus and Summary: Frequencies and Stop Word Filters

Since we have an idea of some global characteristics of your documents, it's time to start looking at the characteristics of the terms in your corpus, and one of the most common entry points is understanding what it means to analyze a text based on its frequencies.

### Unfiltered Frequencies

The first aspect you will work on is gross frequency, and for this, you will use the Cirrus window.

**Activity 5**

1. What are the most frequent words in the corpus?  
2. What do these words tell you about the corpus? Are they all significant?  

*Tip: hover your mouse over the words to get their exact frequencies.*

*Hint: Some frequent words might not be significant—are they function words or context-specific?*

---

### Stop Words

Importance is not an intrinsic value and will always depend on your interests. For this very reason, Voyant offers the option to filter certain words. A common procedure to obtain relevant words is to filter out grammatical lexical units or stop words: articles, prepositions, interjections, pronouns, etc. (Peña and Peña, 2015).

**Activity 6**

1. What stop words are in the word cloud?  
2. Which ones would you eliminate and why?

*Hint: Think about what words are getting in the way of seeing what's meaningful. Editing the stop list helps refine your focus.*

Voyant already has a stop word list loaded for English; however, you can edit it as follows:

1\. Place your cursor at the top right of the Cirrus window and click on the icon that looks like a switch.

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-10.png" alt="Voyant Tools interface highlighting the gear icon in the Cirrus word cloud, which opens a settings menu. This menu allows users to modify the appearance and filtering options of the word cloud." caption="Figure 10. Open options" %}

2\. A window with different options will appear; you select the first one "Edit List."  

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-11.png" alt="Settings window in Voyant Tools showing how to edit the stop word list for the Cirrus word cloud. Users can add or remove words from the list to refine the analysis." caption="Figure 11. Edit list" %}

3\. You add the "stop" words, always separated by a newline (Enter key).  

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-12.png" alt="Screenshot of the process in Voyant Tools for removing stop words from the word cloud. The edited stop word list is being saved to apply the changes across the corpus analysis." caption="Figure 12. Remove stopwords" %}

4\. Once you have added the words you want to filter, you can click on "Save."

<div class="alert alert-warning">
By default, a box that says "Apply globally" is selected; if this box is left selected, the word filtering will affect the metrics of all other tools. It is very important to document your decisions. A good practice is to save the stop word list in a text file (.txt). For this tutorial, you have created a <a href="https://github.com/ColmexBDCV/voyantTools/blob/main/stop_words.txt">list of words to filter</a>, and you can use it if you wish, just remember that this will affect your results.
</div>

### Frequencies with Filtered Stop Words

As you said in the previous point, filtered words affect other fields in Voyant. In this case, if you left the "Apply globally" box selected, the list that appears below the legend: "Most frequent word in the corpus," will show the most repeated words excluding those that were filtered. In my case, it shows:

> states (91); united (83); public (60); government (53); citizens (40)

**Activity 7**

Reflect on these words and think about what information they provide and how this information differs from what you get by looking at the word cloud.

*Hint: Compare which words appear most often once stopwords are removed. Does it shift the themes you identify in the corpus?*

---

## Terms

Although frequencies can tell you something about your texts, there are many variables that can make these numbers less meaningful. In the following sections, different statistics that can be obtained in the "Terms" tab to the left of the "Cirrus" button in Voyant’s default layout will be explained.

### Normalized Frequency

In the previous section, you observed the "gross frequency" of words. However, if you had a *corpus* of six words and another of 3,000 words, gross frequencies are not very informative. Three words in a *corpus* of six words represent 50% of the total, while three words in a *corpus* of 6,000 represent 0.1% of the total. To avoid the over-representation of a term, linguists have devised another measure called: "normalized relative frequency." This is calculated as follows:  
Gross Frequency * 1,000,000 / Total Number of Words

Let’s analyze a verse as an example. Let’s take the phrase:  
"But my heart says no, says no,"which has seven words in total. If you calculate its gross and relative frequency, you have:

| word   | gross frequency | normalized frequency         |
|--------|-----------------|------------------------------|
| heart  | 1               | 1 * 1,000,000 / 7 = 142,857  |
| says   | 2               | 2 * 1,000,000 / 7 = 285,714  |

What is the advantage of this? If you had a *corpus* in which the word `corazón` had the same proportion, for example, 1,000 occurrences out of 7,000 words, while the gross frequency is very different, the normalized frequency would be the same, as `1,000 * 1,000,000 / 7,000 = 142,857`.

Let’s see how this works in Voyant Tools:

1. In the Cirrus section (the word cloud), click on **"Terms."** This will open a table that by default has three columns:  
   - **Terms**: list of words in the documents (excluding the filtered ones)  
   - **Count**: gross or net frequency of each term  
   - **Trend**: graph of the distribution of a word considering its relative frequency

2. To get information about the relative frequency of a term, in the column names bar, on the far right, click on the triangle that offers more options and in "Columns" select the **"Relative"** option as shown in the image below:

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-13.png" alt="Voyant Tools interface showing the 'Terms' section with an additional column for relative frequency. This column provides normalized word frequency data, offering a more balanced view of term usage across the corpus." caption="Figure 13. Relative frequency" %}

3. If you sort the columns in descending order as you would in a spreadsheet program, you will see that the order of gross frequency ("Count") and relative frequency ("Relative") is the same.  

> **Note**: This measure is more useful for comparing different corpora. A *corpus* is a set of texts with something in common. In this case, Voyant is interpreting all the speeches as a single corpus. If you wanted each speech to be a different corpus, you would have to save your text in a table (HTML or XML), where the metadata is expressed in columns (in the case of the table) or in tags (in the case of HTML or XML).

### Statistical Skewness

Although relative frequency helps you understand the distribution of your corpus, there is a measure that gives information about how constant a term is throughout your documents: **statistical skewness**.

This measure gives you an idea of the probability distribution of a variable without having to make its graphical representation. It is calculated by observing the deviations of a frequency from the mean, to determine whether those occurring to the right of the mean (negative skewness) are greater than those to the left (positive skewness). The closer to zero the degree of statistical skewness is, the more regular the distribution of that term (i.e., it occurs with a very similar mean in all documents). 

What is not very intuitive is that if a term has statistical skewness with positive numbers, it means that term is below the mean, and the larger the number, the more skewed the term is (i.e., it occurs a lot in one document but hardly at all in the corpus). Negative numbers, on the other hand, indicate that the term tends to be above the mean.

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-14.png" alt="Screenshot in Voyant Tools showing the selection of the 'Skew' option in the 'Terms' section. This measure indicates the statistical skewness of term distribution across the corpus." caption="Figure 14. Statistical asymmetry" %}

To obtain this measure in Voyant, repeat the steps you did to get the relative frequency, but this time select **"Skew."** This measure allows you to observe, for example, that the word "war," despite having a high frequency, not only does not have a constant frequency throughout the corpus, but it tends to be below the mean because its statistical skewness is positive (0.8).

### Differentiated Words

As you might suspect, the most interesting information is generally not found within the most frequent words, as these tend to be the most obvious. In the field of information retrieval, other measures have been devised that allow locating the terms that make one document stand out from another. 

One of the most commonly used measures is called **tf-idf** (*term frequency – inverse document frequency*). This measure seeks to express numerically how relevant a document is in a given collection; that is, in a collection of texts about "apples," the word `apple` can occur many times, but it tells you nothing new about the collection. For example, in a collection of texts about apples, the word “apple” can occur many times. The gross frequency of the “apple” (term frequency) tells you nothing new about the collection. Instead, you should weigh its frequency in a document against its frequency in the given collection (inverse document frequency).

In Voyant, tf-idf is calculated as follows:
Gross Frequency (tf) / Number of Words (N) * log10 (Number of Documents / Number of times the term appears in the documents)

Or as a formula:
$$ tfidf_{t,d} = \left( \frac{tf_{t,d}}{N_i} \right) \cdot \log_{10} \frac{|D|}{\{ d \in D : t \in d \}} $$

tfidf(t,d) = (tf(t,d) / Ni) * log10 ( |D| / { d ∈ D : t ∈ d } )

**Activity 8**

Look at the differentiated words (compared to the rest of the corpus) of each document and note what hypotheses you can derive from them.

1. **april_30_1789_first_Inaug…**: `voice (2), station (2), opportunities (2), immutable (2), humble (2)`
2. **december_3_1793_fifth**: `theunited (4), jurisdiction (3), warmest (2), unitedstates (2), term (2)`
3. **december_7_1796_eighth**: `appointed (5), commissioner (4), britain (5), naval (3), indies (3)`
4. **december_8_1790_second**: `secretary (2), reward (2), convention (2), consuls (2), belongs (2)`
5. **december_8_1795_seventh**: `review (3), foundation (2), emperor (2), adjusted (2), treaty (4)`
6. **january_8_1790_first**: `end (3), uniform (2), encouragement (2), render (3), teaching (1)`
7. **november_19_1794_sixth**: `pennsylvania (8), inspector (4), counties (4), let (5), insurrection (5)`
8. **november_6_1792_fourth**: `newspapers (6), cent (5), transmission (3), postage (3), case (4)`
9. **october_25_1791_third**: `immediate (4), subscriptions (3), lands (4), possible (3), vacant (2)`

*Hint: These words are unique to each document and can help you understand the specific themes or topics addressed in each speech.*

## Words in Context

The project with which some histories inaugurate the Digital Humanities is the **Index Thomisticus**, a concordance of the work of Thomas Aquinas led by the philologist and religious Roberto Busa (Hockey, 2004), and coded by a team of developers that included dozens of women (Terras, 2013). This project, which took years to complete, is a built-in function in Voyant Tools: in the lower right corner, in the **Contexts** window, it is possible to make left and right concordance queries of specific terms.

The table has the following default columns:

- **Document**: name of the document in which the keyword(s) of the query occur(s)
- **Left**: left context of the keyword (this can be modified to cover more or fewer words, and if you click on the cell, it expands to show more context)
- **Keywords**: keyword(s) of the query
- **Right**: right context

The **Position** column can be added, indicating the place in the document where the queried term is found.

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-15.png" alt="Concordance window in Voyant Tools with an option highlighted to add a 'Position' column. This column shows the exact location of each keyword within the document." caption="Figure 15. Add position column" %}

> **Voyant allows the use of wildcards** to search for variations of a word. Here are some combinations:
>
> - **pe\***: this query will return all words that start with the prefix “pe” (peace, people, person)
> - **\*th**: terms that end with the suffix “th” (health, truth, month)
> - **peace, war**: you can search for more than one term by separating them with commas
> - **“love for my Country”**: search for the exact phrase
> - **“country precarious”~ 5**: search for the terms within the quotes, the order does not matter, and there can be up to 5 words in between.

**Activity 9**

Search for the use of a term that seems interesting to you, using some of the advanced query strategies. Sort the rows using the different columns (Document, Left, Right, and Position): what conclusions can you derive about your terms using the information from these columns?

> **Note**:  
> The order of the words in the "Left" column is reversed; that is, from right to left from the keyword.

*Hint: Use the position and context to see how the term is used. Does it appear mostly at the beginning or end of the speech? Is the tone consistent?*

## Exporting Tables

To export the data, click on the box with an arrow that appears when you hover over the right corner of **"Contexts"**. Then select the **"Export current data"** option and click on the last option **"Export all available data as tab separated values (text)"** grid.

This leads to a page where the fields are separated by a tab.

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-16.png" alt="Voyant Tools interface demonstrating how to export concordance data. The export options are shown, with 'Export all available data as tab-separated values (text)' selected for comprehensive data output." caption="Figure 16. Export contexts" %}

Select all data (`Ctrl+A` or `Ctrl+E`); copy it (`Ctrl+C`) and paste it into a spreadsheet (`Ctrl+V`). If this does not work, save the data as a `.txt` file in a simple text editor (don’t forget the UTF-8 encoding!) and then import the data into your spreadsheet. In Excel, this is done in the "Data" tab and then **"From Text File."**

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-17.png" alt="Excel interface showing the steps to import data from a text file. The 'Data' tab is selected, with the 'From Text File' option highlighted to begin the import process." caption="Figure 17. Import data from a text file" %}


## Activity Answers

**Activity 1**

This *corpus* has 2 documents with a total of 4 words and 3 unique words (I'm, hungry, sleepy).

**Activity 2**

1. You might observe, for example, that the longest texts are the sixth and eighth Annual Message to Congress. Regarding the shortest, you can see that  the shortest are the first and second Annual Message to Congress.
2. Knowing the length of your texts allows you to understand the homogeneity or disparity of your corpus, as well as understand certain trends (for example, in which years speeches tended to be shorter, when the length changed, etc.).

**Activity 3**

1. The first stanza has 22 words and 21 are unique words, so 21/22 equals a vocabulary density of 0.955.  
   The second stanza has 24 words and 13 are unique words, so 13/24 equals a vocabulary density of 0.542.

   As you can see, the difference between a verse by Sor Juana Inés de la Cruz and another composed by Nadir Khayat and Stefani Germanotta has a density difference of 0.328, which is not very high. You should be careful in interpreting these numbers as they are only a quantitative indicator of vocabulary richness and do not include parameters such as rhyme complexity or term complexity.

   There seems to be a correspondence between shorter and denser speeches, which is natural since the shorter a text is, the less "opportunity" there is for words to repeat. However, this could also tell you something about the styles of different countries or presidents. The less dense, the more likely they are to use more rhetorical resources.

**Activity 4**

These results seem to indicate that President Kirchner, in addition to having the longest speeches, makes the longest sentences; however, you have to be careful with conclusions of this kind, as these are oral speeches where punctuation depends on who transcribes the text.

**Activity 5**

1. `states (91); united (83); public (60); government (53); citizens (40).`
2. The first and the second are words specific to the name of the country. If you wanted to omit them, the best approach would be to edit the stop words list and add them.


## Bibliography

- Hockey, Susan. 2004. “The History of Humanities Computing”. *A Companion to Digital Humanities*. Schreibman et al. (editors). Blackwell Publishing Ltd. doi:[10.1002/9780470999875.ch1](https://doi.org/10.1002/9780470999875.ch1).
- Peña, Gilberto Anguiano, and Catalina Naumis Peña. 2015. «Extracción de candidatos a términos de un *corpus* de la lengua general». *Investigación Bibliotecológica: Archivonomía, Bibliotecología e Información* 29 (67): 19-45. <https://doi.org/10.1016/j.ibbai.2016.02.035>.
- Sinclair, Stéfan and Geoffrey Rockwell, 2016. *Voyant Tools*. Web. <http://voyant-tools.org/>.
- Terras, Melissa, 2013. “For Ada Lovelace Day – Father Busa’s Female Punch Card Operatives”. *Melissa Terras’ Blog*. Web. <http://melissaterras.blogspot.com/2013/10/for-ada-lovelace-day-father-busas.html>.

> *This lesson was written thanks to the support of the British Academy and prepared during the Programming Historian Writing Workshop at the Universidad de los Andes in Bogotá, Colombia, from July 31 to August 3, 2018.*

## Footnotes

[^2]: There are more complex ways to load the *corpus* that you can consult in the English documentation.  
[^3]: For more information, consult the English documentation.
