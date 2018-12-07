title: ["Processing, Exploring, and Analyzing Documents with Tf-idf"]
collection: lessons
layout: lesson
slug: [processing-exploring-and-analyzing-documents-with-tf-idf]
date: []
translation_date: []
authors:
- [Matthew Lavin]
reviewers:
- []
editors:
- []
translator:
- []
translation-editor:
- []
translation-reviewer:
- []
original: []
review-ticket: []
difficulty: []
activity: []
topics: []
abstract: []
---

## Contents
{:.no_toc}

* TOC
{:toc}


## Preparation

### Suggested Prior Skills

- Prior familiarity with Python or a similar programming language. The precise level of code literacy or familiarity recommended is hard to estimate, but you will want to be comfortable with basic types and operations. Code for this lesson is written in Python 3.6, but __tf-idf__ is available in many versions of Python and other programming languages. To get the most out of this lesson, it is recommended that you work your way through something like Codeacademy's Introduction to Python course, or that you complete some of the introductory Python lessons on _The Programming Historian_. 
- In lieu of the above recommendation, you should review Python's basic types (string, integer, float, list, tuple, dictionary), working with variables, writing loops in Python, and working with object classes/instances.
- Experience with Excel or an equivalent spreadsheet application if you wish to examine the linked spreadsheet files.

### Before You Begin

- Install the Python 3 version of Anaconda. Installing Anaconda is covered in [Text Mining in Python through the HTRC Feature Reader](https://programminghistorian.org/en/lessons/text-mining-with-extracted-features). This will install Python 3.6 (or higher), the Scikit-Learn library (which we will use for __tf-idf__), and the dependencies needed to run a Jupyter Notebook.   
- It is possible to install all these dependencies without Anaconda (or with a lightweight alternative like Miniconda). For more information, see the section below titled ["Alternatives to Anaconda"](#alternatives-to-anaconda)

### Lesson Dataset

__Tf-idf__, like many computational operations, is best understood by example. To this end, I've prepared a relatively small dataset of 366 _New York Times_ historic obituaries scraped from [https://archive.nytimes.com/www.nytimes.com/learning/general/onthisday/](https://archive.nytimes.com/www.nytimes.com/learning/general/onthisday/). For each day of the year, _The New York Times_ featured an obituary of someone born on that day. (There are 366 obituaries because of February 29 on the Leap Year.) The dataset is small enough that you should be able to open and read some if not all of the files. You'll notice that many of the historic figures are well known, which suggests a self-conscious effort to look back at the history of _The New York Times_ and select obituaries based on some criteria. In short, this isn't a representative sample of historic obituaries, it's a recent collection. 

This obituary corpus also an historical object in its own right. The version of _The New York Times_ "On This Day" website used for the dataset hasn't been updated since 2011, and it has been replaced by a newer, sleeker blog located at [https://learning.blogs.nytimes.com/on-this-day/](https://learning.blogs.nytimes.com/on-this-day/). It represents, on some level, how the questions inclusion and representation might affect both the decision to publish an obituary, and the decision to highlight a particular obituary many years later. The significance of such decisions has been further highlighted in recent months by _The New York Times_ itself. In march 2018, the newspaper began publishing obituaries for "overlooked women". In the words of Amisha Padnani and Jessica Bennett, "who gets remembered — and how — inherently involves judgment. To look back at the obituary archives can, therefore, be a stark lesson in how society valued various achievements and achievers." The dataset includes a central metadata.csv file with each obituary's title and publication date. It also includes a folder of .html files downloaded from the 2011 "On This Day Website" and a folder of .txt files that represent the body of each obituary. These text files were generated using a Python library called BeautifulSoup, which is covered in another _Programming Historian_ (see [Intro to BeautifulSoup](https://programminghistorian.org/en/lessons/intro-to-beautiful-soup) ). The lesson files are located at [https://github.com/mjlavin80/tf-idf-programming-historian](https://github.com/mjlavin80/tf-idf-programming-historian). 

### Tf-idf Definition and Background

__Tf-idf__ stands for Term Frequency - Inverse Document Frequency. Instead of representing a term in a document by its raw frequency (number of occurrences) or its relative frequency (term count divided by document length), each term is weighted by dividing the term frequency by the number of documents in the corpus containing the word. The overall effect of this weighting scheme is to avoid a common problem when conducting text analysis: the most frequently used words in a document are often the most frequently used words in all of the documents. In contrast, terms with the highest __tf-idf__ scores are the terms in a document that are _distinctively_ frequent in a document, when that document is compared other documents. 

In a 1972 paper, Karen Spärck Jones explained the rationale for a weighting scheme based on term frequency weighted by collection frequency, and how it might be applied to information retrieval. Such weighting, she argued, "places greater emphasis on the value of a term as a means of distinguishing one document from another than on its value as an indication of the content of the document itself. ... In some cases a term may be common in a document and rare in the collection, so that it would be heavily weighted in both schemes. But the reverse may also apply. It is really that the emphasis is on different properties of terms."

If this explanation doesn't quite resonate, a brief analogy might help. Imagine that you are on vacation for a weekend in a city that you've never visited before. For convenience, let's call it Idf City. You're trying to choose a restaurant for dinner, and you'd like to balance two competing goals: first, you want to have a very good meal, and second, you want to choose a style of cuisine that's distinctively good in Idf City. That is, you don't want to have something you can get just anywhere. You can look up online reviews of restaurants all day, and that's just find for your first goal, but what you need in order to satisfy the second goal is some way to tell the difference between good and distinctively good (or perhaps even uniquely good).  

It's relatively easy, I think to see that restaurant food could be both good and distinctive, good but not distinctive, distinctive but not good, or neither good nor distinctive. Term frequencies, however, might be a bit trickier. To understand how words can be frequent but not distinctive, or distinctive but not frequent, let's look at a text-based example. The following is a list of the top ten most frequent terms (and term counts) from one of the obituaries in our _New York Times_ corpus.

<div>
<table border="1" class="dataframe">
<thead>
	<tr style="text-align: right;">
		<th title="Rank">Rank</th>
	    <th title="Term">Term</th>
	    <th title="Count">Count</th>
    </tr>
</thead>
<tbody>
	<tr>
	<td>1</td>
		<td>the</td>
		<td>21</td>
	</tr>
	<tr>
		<td>2</td>
		<td>of</td>
		<td>16</td>
	</tr>
	<tr>
		<td>3</td>
		<td>her</td>
		<td>15</td>
	</tr>
	<tr>
		<td>4</td>
		<td>in</td>
		<td>14</td>
	</tr>
	<tr>
		<td>5</td>
		<td>and</td>
		<td>13</td>
	</tr>
	<tr>
		<td>6</td>
		<td>she</td>
		<td>10</td>
	</tr>
	<tr>
		<td>7</td>
		<td>at</td>
		<td>8</td>
	</tr>
	<tr>
		<td>8</td>
		<td>cochrane</td>
		<td>4</td>
	</tr>
	<tr>
		<td>9</td>
		<td>was</td>
		<td>4</td>
	</tr>
	<tr>
		<td>10</td>
		<td>to</td>
		<td>4</td>
	</tr>
</tbody>
</table>
</div>

After looking at this list, imagine trying to discern information about the obituary that this table represents. We might infer from the presence of _her_ and _cochrane_ in the list that a woman named Cochrane is being discussed but, at the same time, this could easily be about a person from Cochrane, Wisconsin or someone associated with the Cochrane Collaboration, a non-profit, non-governmental organization. The problem with this list is that most of top terms would be top terms in any obituary and, indeed, any sufficiently large chunk of writing in most languages. This is because most languages are heavily dependent on function words like _the,_ _as,_ _of,_ _to,_ and _from_ that serve primarily grammatical or structural purposes, and appear regardless of the text's subject matter. A list of an obituary's most frequent terms tell us little about the obituary or the person being memorialized.  Now let's use __tf-idf__ term weighting to compare the same obituary from the first example to the rest of our corpus of _New York Times_ obituaries. The top ten term scores look like this: 

<div>
<table border="1" class="dataframe">
<thead>
	<tr style="text-align: right;">
		<th title="Index">Rank</th>
	    <th title="Term">Term</th>
	    <th title="Count">Count</th>
    </tr>
</thead>
<tbody>
	<tr>
		<td>1</td>
		<td>cochrane</td>
		<td>24.85</td>
	</tr>
	<tr>
		<td>2</td>
		<td>her</td>
		<td>22.74</td>
	</tr>
	<tr>
		<td>3</td>
		<td>she</td>
		<td>16.22</td>
	</tr>
	<tr>
		<td>4</td>
		<td>seaman</td>
		<td>14.88</td>
	</tr>
	<tr>
		<td>5</td>
		<td>bly</td>
		<td>12.42</td>
	</tr>
	<tr>
		<td>6</td>
		<td>nellie</td>
		<td>9.92</td>
	</tr>
	<tr>
		<td>7</td>
		<td>mark</td>
		<td>8.64</td>
	</tr>
	<tr>
		<td>8</td>
		<td>ironclad</td>
		<td>6.21</td>
	</tr>
	<tr>
		<td>9</td>
		<td>plume</td>
		<td>6.21</td>
	</tr>
	<tr>
		<td>10</td>
		<td>vexations</td>
		<td>6.21</td>
	</tr>
</tbody>
</table>

In this version of the list, _she_ and _her_ have both moved up. _cochrane_ remains, but now we have at least two new name-like words: _nellie_ and _bly._ Nellie Bly was a turn-of-the-century journalist best known today for her investigate journalism, perhaps most remarkably when she had herself committed to the New York City Lunatic Asylum for ten days in order to write an expose on the mistreatment of mental health patients. She was born Elizabeth Cochrane Seaman, and Bly was her pen name or _nom-de-plume_. With only a few details about Bly, we can account for seven of the top ten __tf-idf__ terms: _cochrane,_ _her,_ _she,_ _seaman,_ _bly,_ _nellie,_ and _plume._ To understand _mark_, _ironclad_, and _vexations_, we can return to the original obituary and discover that Bly died at St. Mark's Hospital. Her husband was president of the Ironclad Manufacturing Company. Finally, "a series of forgeries by her employees, disputes of various sorts, bankruptcy and a mass of vexations and costly litigations swallowed up Nellie Bly's fortune." Many of the terms on this list are mentioned as few as one, two, or three times; they are not frequent by any measure. Their presence in this one document, however, are all distinctive compared with the rest of the corpus. 

## Procedure 

### How the Algorithm Works

__Tf-idf__ can be implemented in many flavors, some more complex than others. Before I begin discussing these complexities, however, I would like to trace the algorithmic operations of one particular version. To this end, we will go back to the Nellie Bly obituary and convert the top ten term counts into __tf-idf__ scores using the same steps that were used to create the above __tf-idf__ example. These steps parallel scikit learn's __tf-idf__ implementation. Addition, multiplication, and division are the primary mathematical operations necessary to follow along. At one point, we must calculate the natural logarithm of a variable, but this can be done with most online calculators and calculator mobile apps. Below is a table with the raw term counts for the first thirty words, in alphabetical order, from Bly's obituary, but this version has a second column that represents the number of documents in which each term can be found.

<div>
<table border="1" class="dataframe">
<thead>
	<tr style="text-align: right;">
		<th title="Index">Index</th>
		<th title="Term">Term</th>
		<th title="Count">Count</th>
		<th title="Df">Df</th>
    </tr>
</thead>
<tbody>
<tr>
<td>1</td>
<td>afternoon</td>
<td>1</td>
<td>66</td>
</tr>
<tr>
<td>2</td>
<td>against</td>
<td>1</td>
<td>189</td>
</tr>
<tr>
<td>3</td>
<td>age</td>
<td>1</td>
<td>224</td>
</tr>
<tr>
<td>4</td>
<td>ago</td>
<td>1</td>
<td>161</td>
</tr>
<tr>
<td>5</td>
<td>air</td>
<td>1</td>
<td>80</td>
</tr>
<tr>
<td>6</td>
<td>all</td>
<td>1</td>
<td>310</td>
</tr>
<tr>
<td>7</td>
<td>american</td>
<td>1</td>
<td>277</td>
</tr>
<tr>
<td>8</td>
<td>an</td>
<td>1</td>
<td>352</td>
</tr>
<tr>
<td>9</td>
<td>and</td>
<td>13</td>
<td>364</td>
</tr>
<tr>
<td>10</td>
<td>around</td>
<td>2</td>
<td>149</td>
</tr>
<tr>
<td>11</td>
<td>as</td>
<td>2</td>
<td>357</td>
</tr>
<tr>
<td>12</td>
<td>ascension</td>
<td>1</td>
<td>6</td>
</tr>
<tr>
<td>13</td>
<td>asylum</td>
<td>1</td>
<td>2</td>
</tr>
<tr>
<td>14</td>
<td>at</td>
<td>8</td>
<td>362</td>
</tr>
<tr>
<td>15</td>
<td>avenue</td>
<td>2</td>
<td>68</td>
</tr>
<tr>
<td>16</td>
<td>balloon</td>
<td>1</td>
<td>2</td>
</tr>
<tr>
<td>17</td>
<td>bankruptcy</td>
<td>1</td>
<td>8</td>
</tr>
<tr>
<td>18</td>
<td>barrel</td>
<td>1</td>
<td>7</td>
</tr>
<tr>
<td>19</td>
<td>baxter</td>
<td>1</td>
<td>4</td>
</tr>
<tr>
<td>20</td>
<td>be</td>
<td>1</td>
<td>332</td>
</tr>
<tr>
<td>21</td>
<td>beat</td>
<td>1</td>
<td>33</td>
</tr>
<tr>
<td>22</td>
<td>began</td>
<td>1</td>
<td>241</td>
</tr>
<tr>
<td>23</td>
<td>bell</td>
<td>1</td>
<td>24</td>
</tr>
<tr>
<td>24</td>
<td>bly</td>
<td>2</td>
<td>1</td>
</tr>
<tr>
<td>25</td>
<td>body</td>
<td>1</td>
<td>112</td>
</tr>
<tr>
<td>26</td>
<td>born</td>
<td>1</td>
<td>342</td>
</tr>
<tr>
<td>27</td>
<td>but</td>
<td>1</td>
<td>343</td>
</tr>
<tr>
<td>28</td>
<td>by</td>
<td>3</td>
<td>349</td>
</tr>
<tr>
<td>29</td>
<td>career</td>
<td>1</td>
<td>223</td>
</tr>
<tr>
<td>30</td>
<td>character</td>
<td>1</td>
<td>89</td>
</tr>
</tbody>
</table>
</div>

Document frequency (__df__) is a count of how many documents from the corpus each word appears in. (Document frequency for a particular word can be represented as __df<sub>i</sub>__.) To calculate inverse document frequency for each term, the most direct formula would be __N/df<sub>i</sub>__, where __N__ represents the total number of documents in the corpus. However, many implementations normalize the results with additional operations. For example, Scikit-Learn's implementation represents __N__ as __N+1__, calculates the natural logarithm of __(N+1)/df<sub>i</sub>__, and then adds 1 to the final result.

To express Scikit-Learn's __idf__ transformation, we can state the following equation: 


{% include figure.html filename="idf-equation.png" caption="equation for __idf__" %}

Once __idf<sub>i</sub>__ is calculated, __tf-idf<sub>i</sub>__ is __tf<sub>i</sub>__ multiplied by __idf<sub>i</sub>__. 

{% include figure.html filename="tf-idf-equation.png" caption="equation for __tf-idf__" %}

Mathematical equations like these can be a bit bewildering if you're not used to them. (Once you've had some experience with them, they can provide a more lucid description of an algorithm's operations than any well written paragraph.) To make the equations more concrete, I've added two new columns to the terms frequency table from before. The first new column represents the derived __idf__ score, and the second new column multiplies the Count column to derive the final __tf-idf__ score. Notice that that __idf__ score is higher if the term appears in fewer documents, but that the range of visible __idf__ scores is between 1 and 6. Different normalization schemes would produce different scales. 

Note also that the __tf-idf__ column, according to this version of the algorithm, cannot be lower than the count. This effect is also the result of our normalization method; adding 1 to the final __idf__ value ensures that we will never multiply our Count columns by a number smaller than one.    

<div>
<table border="1" class="dataframe">
<thead>
	<tr style="text-align: right;">
		<th title="Index">Index</th>
		<th title="Term">Term</th>
		<th title="Count">Count</th>
		<th title="DF">Df</th>
		<th title="Smoothed-idf">Idf</th>
		<th title="Tf-idf">Tf-idf</th>
    </tr>
</thead>
<tbody>
<tr>
<td>1</td>
<td>afternoon</td>
<td>1</td>
<td>66</td>
<td>2.70066923</td>
<td>2.70066923</td>
</tr>
<tr>
<td>2</td>
<td>against</td>
<td>1</td>
<td>189</td>
<td>1.65833778</td>
<td>1.65833778</td>
</tr>
<tr>
<td>3</td>
<td>age</td>
<td>1</td>
<td>224</td>
<td>1.48926145</td>
<td>1.48926145</td>
</tr>
<tr>
<td>4</td>
<td>ago</td>
<td>1</td>
<td>161</td>
<td>1.81776551</td>
<td>1.81776551</td>
</tr>
<tr>
<td>5</td>
<td>air</td>
<td>1</td>
<td>80</td>
<td>2.51091269</td>
<td>2.51091269</td>
</tr>
<tr>
<td>6</td>
<td>all</td>
<td>1</td>
<td>310</td>
<td>1.16556894</td>
<td>1.16556894</td>
</tr>
<tr>
<td>7</td>
<td>american</td>
<td>1</td>
<td>277</td>
<td>1.27774073</td>
<td>1.27774073</td>
</tr>
<tr>
<td>8</td>
<td>an</td>
<td>1</td>
<td>352</td>
<td>1.03889379</td>
<td>1.03889379</td>
</tr>
<tr>
<td>9</td>
<td>and</td>
<td>13</td>
<td>364</td>
<td>1.00546449</td>
<td>13.07103843</td>
</tr>
<tr>
<td>10</td>
<td>around</td>
<td>2</td>
<td>149</td>
<td>1.89472655</td>
<td>3.78945311</td>
</tr>
<tr>
<td>11</td>
<td>as</td>
<td>2</td>
<td>357</td>
<td>1.02482886</td>
<td>2.04965772</td>
</tr>
<tr>
<td>12</td>
<td>ascension</td>
<td>1</td>
<td>6</td>
<td>4.95945170</td>
<td>4.95945170</td>
</tr>
<tr>
<td>13</td>
<td>asylum</td>
<td>1</td>
<td>2</td>
<td>5.80674956</td>
<td>5.80674956</td>
</tr>
<tr>
<td>14</td>
<td>at</td>
<td>8</td>
<td>362</td>
<td>1.01095901</td>
<td>8.08767211</td>
</tr>
<tr>
<td>15</td>
<td>avenue</td>
<td>2</td>
<td>68</td>
<td>2.67125534</td>
<td>5.34251069</td>
</tr>
<tr>
<td>16</td>
<td>balloon</td>
<td>1</td>
<td>2</td>
<td>5.80674956</td>
<td>5.80674956</td>
</tr>
<tr>
<td>17</td>
<td>bankruptcy</td>
<td>1</td>
<td>8</td>
<td>4.70813727</td>
<td>4.70813727</td>
</tr>
<tr>
<td>18</td>
<td>barrel</td>
<td>1</td>
<td>7</td>
<td>4.82592031</td>
<td>4.82592031</td>
</tr>
<tr>
<td>19</td>
<td>baxter</td>
<td>1</td>
<td>4</td>
<td>5.29592394</td>
<td>5.29592394</td>
</tr>
<tr>
<td>20</td>
<td>be</td>
<td>1</td>
<td>332</td>
<td>1.09721936</td>
<td>1.09721936</td>
</tr>
<tr>
<td>21</td>
<td>beat</td>
<td>1</td>
<td>33</td>
<td>3.37900132</td>
<td>3.37900132</td>
</tr>
<tr>
<td>22</td>
<td>began</td>
<td>1</td>
<td>241</td>
<td>1.41642412</td>
<td>1.41642412</td>
</tr>
<tr>
<td>23</td>
<td>bell</td>
<td>1</td>
<td>24</td>
<td>3.68648602</td>
<td>3.68648602</td>
</tr>
<tr>
<td>24</td>
<td>bly</td>
<td>2</td>
<td>1</td>
<td>6.21221467</td>
<td>12.42442933</td>
</tr>
<tr>
<td>25</td>
<td>body</td>
<td>1</td>
<td>112</td>
<td>2.17797403</td>
<td>2.17797403</td>
</tr>
<tr>
<td>26</td>
<td>born</td>
<td>1</td>
<td>342</td>
<td>1.06763140</td>
<td>1.06763140</td>
</tr>
<tr>
<td>27</td>
<td>but</td>
<td>1</td>
<td>343</td>
<td>1.06472019</td>
<td>1.06472019</td>
</tr>
<tr>
<td>28</td>
<td>by</td>
<td>3</td>
<td>349</td>
<td>1.04742869</td>
<td>3.14228608</td>
</tr>
<tr>
<td>29</td>
<td>career</td>
<td>1</td>
<td>223</td>
<td>1.49371580</td>
<td>1.49371580</td>
</tr>
<tr>
<td>30</td>
<td>character</td>
<td>1</td>
<td>89</td>
<td>2.40555218</td>
<td>2.40555218</td>
</tr>
</tbody>
</table>
</div>

These tables collectively represent one particular version of the __tf-idf__ transformation. Of course, __tf-idf__ is generally calculated for all terms in all of the documents in your corpus so that you can see which terms in each document have the highest __tf-idf__ scores. To get a better sense of the what your output might look like after executing such an operation, download and open the full Excel file for Bly's obituary by visiting [the lesson repository on Github](https://github.com/mjlavin80/tf-idf-programming-historian/blob/master/bly_tfidf_all.xlsx). 

### How to Run it in Python 3

In this section of the lesson, I will walk through the steps I followed to calculate __tf-idf__ scores for all terms in all documents in the lesson's obituary corpus. If you would like to follow along, you can download the lesson files and run a Jupyter Notebook from the inside the lesson folder. As with any programming language, there's more than one way to do each of these steps.

My first block of code is designed to retrieve all the filenames for '.txt' files in the 'txt' folder. The following lines of code import the ```os``` library and use the ```os.walk()``` method from Python's to generate a list of all the files in the 'txt' folder that end with '.txt'. ```os.walk()``` returns the root directory of a folder, a list of all subfolders, and a list of all files in the directory, including all files in its subdirectories. 

Once I've loaded a list of file names, I can loop through the list of files and use the ```endswith()``` method to verify I'm finding only '.txt' files. Every time a match is found, I append each text file name to the list called all_txt_files. Finally, I return the length of ```all_txt_files``` to verify that I've found 366 file names. This loop-and-append approach is very common in Python.

```python
import os
all_txt_files =[]
for root, dirs, files in os.walk("txt"):
    for file in files:
        if file.endswith(".txt"):
            all_txt_files.append(os.path.join(root, file))
# counts the length of the list
n_files = len(all_txt_files)
print(n_files)
```

Python's ```os.walk()``` returns a file list in arbitrary order, but we want our files to count up by day and month since there's on file for every day and month of a year. Let's use the ```sort()``` method to put the files in ascending numerical order and print the first file to make sure it's '0101.txt'.

```python
all_txt_files.sort()
all_txt_files[0]
```

Next, we can use our list of file names to load each file and convert them to a format that Python can read and understand as text. In this block of code, I do another loop-and-append operation. This time, I loop my list of file names and open each file. I then use Python's ```read()``` method to convert each text file to a string (```str```), which is how Python knows to think of the data as text. I append each string, one by one, to a new list called ```all_docs```. Crucially, the string objects in this list have the same order as the file names in the ```all_txt_files``` list. 

```python
all_docs = []
for i in all_txt_files:
    with open(i) as f:
        txt = f.read()
    all_docs.append(txt)
```

This is all the setup work we require. Text processing steps like tokenization and removing punctuation will happen automatically when we use Scikit-Learn's ```TfidfVectorizer``` to convert documents from a list of strings to __tf-idf__ scores. The following block of code imports ```TfidfVectorizer``` from the Scikit-Learn library, which comes pre-installed with Anaconda. ```TfidfVectorizer``` is a class (written using object-oriented programming), so I instantiate it with specific parameters (I'll say more about these settings later) as a variable named ```vectorizer```. I then run the object's ```fit_transform()``` method on my list of strings (a variable called ```all_docs```). The stored variable ```X``` is output of the ```fit_transform()``` method. 

```python
#import the TfidfVectorizer from Scikit-Learn.  
from sklearn.feature_extraction.text import TfidfVectorizer
 
vectorizer = TfidfVectorizer(max_df=.65, min_df=1, stop_words=None, use_idf=True, norm=None)
X = vectorizer.fit_transform(all_docs)
```

The ```fit_transform()``` method above converts the list of strings to something called a sparse matrix. In this case, the matrix represents __tf-idf__ values for all texts. Sparse matrices save on memory by leaving out all zero values, but we want access to those, so the next block uses the ```toarray()``` method to convert the sparse matrices to a numpy array. We can print the length of the array to ensure that it's the same length as our list of documents. 

```python 
myarray = X.toarray()
# this line of code verifies that the numpy array represents the same number of documents that we have in the file list
len(myarray)
```
A numpy array is list-like but not exactly a list, and I could fill an entire tutorial discussing the differences, but there's only one aspect of numpy arrays we need to know right now: it converts the data stored in ```X``` to a format where every __tf-idf__ score for every term in every document is represented. Sparse matrices, in contrast, exclude zero-value term scores. 

We want every term represented so that each document has the same number of values, one for each word in the corpus. Each item in ```myarray``` is an array of its own representing one document from our corpus. As a result of all this, we essentially have a grid where each row is a document, and each column is a term. Imagine one table from a spreadsheet representing each document, like the tables above, but without column or row labels.  

To merge the values with their labels, we need two pieces of information: the order of the documents, and the order in which term scores are listed. The order of these documents is easy because it's the same order as the variable ```all_docs list```. The full term list is stored in our ```vectorizer``` variable, and it's in the same order that each item in ```myarray``` stores values. We can use the ```get_feature_names()``` method to et that list, and each row of data (one document's __tf-idf__ scores) can be rejoined with the term list. 

```python
import pandas as pd
import os

# make the output folder if it doesn't already exist
if not os.path.exists("tf_idf_output"):
    os.makedirs("tf_idf_output")

# construct a list of output file paths using the previous list of text files the relative path for tf_idf_output
output_filenames = [i.replace(".txt", ".csv").replace("txt/", "tf_idf_output/") for i in all_txt_files]

# loop each item in myarray, using enumerate to keep track of the current position
for n, doc in enumerate(myarray):
    # construct a dataframe
    data = list(zip(vectorizer.get_feature_names(), doc))
    df = pd.DataFrame.from_records(data, columns=['term', 'score']).sort_values(by='score', ascending=False).reset_index(drop=True)

    # output to a csv using the enumerated value for the filename
    df.to_csv(output_filenames[n])
```

The above block of code has three parts:

1. After importing the pandas and os libraries, it checks for a folder called "tf_idf_output" and creates it if it doesn't exist. 

2. It takes the list of .txt files from my earlier block of code and use it to construct a counterpart .csv file path for each .txt file. The output_filenames variable will, for example, convert "txt/0101.txt" (the path of the first .txt file) to "tf_idf_output/0101.csv", and on and on for each file. 

3. Using a loop, it merges each vector of __tf-idf__ scores with the feature names from vectorizer, converts each merged term/score pairs to a pandas dataframe, and saves each dataframe to its corresponding .csv file.

### Interpreting Word Lists: Best Practices and Cautionary Notes

If you the code excerpts above, you will end up with a folder called "tf_idf_output" with 366 .csv files in it. Each file corresponds to an obituary in the "txt" folder, and each contains a list of terms with __tf-idf__ scores for that document. As we saw with Nellie Bly's obituary, these term lists can be very suggestive; however, it's important to understand that over-interpreting your results can actually distort your understanding of an underlying text. 

In general, it's best to begin with the ideas that these terms lists will be helpful for generating hypotheses or research questions, but will not necessarily be definitive in terms to defending claims. For example, I have assembled a quick list of obituaries for late 19th- and early 20th-century figures who all worked for newspapers and magazines and had some connection to social reform. My list includes Nellie Bly, Willa Cather, W.E.B. Du Bois, Upton Sinclair, Ida Tarbell, but there may be other figures in the corpus who fit the same criteria.  

I originally expected to see many shared terms, but I was surprised. Each list is dominate by individualized words (proper names, geographic places, companies, etc.) but I could screen these out using my __tf-idf__ settings, or just ignore them. Simultaneously, I can look for words overtly indicating each figure's ties to the profession of authorship. The following table shows the top 20 __tf-idf__ terms by rank for each obituary:

<table border="1" class="dataframe">
<thead>
	<tr style="text-align: right;">
		<th title="tfidfrank">Tf-idf Rank</th>
		<th title="nelliebly">Nellie Bly</th>
		<th title="willacather">Willa Cather</th>
		<th title="webdubois">W.E.B. Du Bois</th>
		<th title="uptonsinclair">Upton Sinclair</th>
		<th title="idatarbell">Ida Tarbell</th>
    </tr>
</thead><tbody>
 <tr><td>1</td><td>cochrane</td><td>cather</td><td>dubois</td><td>sinclair</td><td>tarbell</td></tr>
 <tr><td>2</td><td>her</td><td>her</td><td>dr</td><td>socialist</td><td>she</td></tr>
 <tr><td>3</td><td>she</td><td>she</td><td>negro</td><td>upton</td><td>her</td></tr>
 <tr><td>4</td><td>seaman</td><td>nebraska</td><td>ghana</td><td><strong>books</strong></td><td>lincoln</td></tr>
 <tr><td>5</td><td>bly</td><td>miss</td><td>peace</td><td>lanny</td><td>miss</td></tr>
 <tr><td>6</td><td>nellie</td><td>forrester</td><td><strong>encyclopedia</strong></td><td>social</td><td>oil</td></tr>
 <tr><td>7</td><td>mark</td><td>sibert</td><td>communist</td><td>budd</td><td>abraham</td></tr>
 <tr><td>8</td><td>ironclad</td><td>twilights</td><td>barrington</td><td>jungle</td><td>mcclure</td></tr>
 <tr><td>9</td><td><strong>plume</strong></td><td>willa</td><td>fisk</td><td>brass</td><td>easton</td></tr>
 <tr><td>10</td><td>vexations</td><td>antonia</td><td>atlanta</td><td>california</td><td><strong>volumes</strong></td></tr>
 <tr><td>11</td><td>phileas</td><td>mcclure</td><td>folk</td><td><strong>writer</strong></td><td>minerva</td></tr>
 <tr><td>12</td><td>597</td><td><strong>novels</strong></td><td>booker</td><td>vanzetti</td><td>standard</td></tr>
 <tr><td>13</td><td>elizabeth</td><td>pioneers</td><td>successively</td><td>macfadden</td><td>business</td></tr>
 <tr><td>14</td><td><strong>nom</strong></td><td>cloud</td><td>souls</td><td>sacco</td><td>titusville</td></tr>
 <tr><td>15</td><td>balloon</td><td><strong>book</strong></td><td>council</td><td><strong>wrote</strong></td><td><strong>articles</strong></td></tr>
 <tr><td>16</td><td>forgeries</td><td>calif</td><td>party</td><td>meat</td><td>bridgeport</td></tr>
 <tr><td>17</td><td>mcalpin</td><td><strong>novel</strong></td><td>disagreed</td><td><strong>pamphlets</strong></td><td>expose</td></tr>
 <tr><td>18</td><td>asylum</td><td>southwest</td><td>harvard</td><td>my</td><td>trusts</td></tr>
 <tr><td>19</td><td>fogg</td><td><strong>verse</strong></td><td><strong>arts</strong></td><td>industry</td><td>mme</td></tr>
 <tr><td>20</td><td>verne</td><td><strong>wrote</strong></td><td>soviet</td><td><strong>novel</strong></td><td><strong>magazine</strong></td></tr>
</tbody></table>

I've used boldface to indicate terms that seem overtly related to authorship or writing. The list includes _articles_, _arts_, _book_, _book_, _books_, _encyclopedia_, _magazine_, _nom_, _novel_, _novels_, _pamphlets_, _plume_, _verse_, _volumes_, _writer_, and _wrote_, but it could be extended to include references to specific magazine or book titles. Setting aside momentarily such complexities, it is striking to me that Cather and Sinclair's lists have so many words for books and writing, whereas Bly, Du Bois and Tarbell's do not. 

I could easily jump to conclusions. Cather's identity seems to be tied most to her gender, her sense of place, and her fiction and verse. Sinclair more so with his politics and his writings about meat, industry, and specifically the well known, controversial trial and execution of Nicola Sacco and Bartolomeo Vanzetti. Bly is tied to her pen name, her husband, and her writing about asylums. Du Bois is linked to race and his academic career. Tarbell is described by what she wrote about: namely business, the trusts, Standard Oil, and Abraham Lincoln. Going further, I could argue that gender seems more distinctive for women than it is for men; race is only a top term for the one African American in my set. 

Each of these observations forms the basis for a deeper question, but these details aren't enough to make generalizations. Foremost, I need to consider whether my __tf-idf__ settings are producing effects that would disappear under other conditions; robust results should be stable enough to appear with various settings. Next, I should read at least some of the underlying obituaries to make sure I'm not getting false signals from any terms. If I read Du Bois's obituary, for example, I may discover that mentions of his work "The Encyclopedia of the Negro," contribute at least partially to the overall score of the word _negro_. 

Likewise, I can discover that Bly's obituary does include words like _journalism_, _journalistic_, _newspapers_, and _writing_, but the obituary is very short, meaning most words mentioned in it occur only once or twice, which means that words with very high __idf__ scores are even more likely to top her list. I really want __tf__ and __idf__ to be balanced, so I could rule out words that appear in only a few documents, or I could ignore results for obituaries below a certain word count. 

Finally, I can design tests to measure directly questions like: were obituaries of African Americans are more likely to mention race? I think the prediction that they did is a good hypothesis, but I should still subject my generalizations to scrutiny before I form conclusions.   

### Some Ways Tf-idf Can Be Used in Computational History

As I have described, __tf-idf__ has its origins in information retrieval, and the idea of weighting term frequencies against norms in a larger corpus continues to be used to power various aspects of everyday web applications, especially text-based search engines. However, in a cultural analytics or computational history context, __tf-idf__ is suited for a particular set of tasks. These uses tend to fall into one of three groups.  

1. #### As an Exploratory Tool or Visualization Technique

As I've already demonstrated, terms lists with __tf-idf__ scores for each document in a corpus can be a strong interpretive aid in themselves, they can help generate hypotheses or research questions. Word lists can also be the building bocks for more sophisticated browsing and visualization strategies. ["A full-text visualization of the Iraq War Logs"](http://jonathanstray.com/a-full-text-visualization-of-the-iraq-war-logs), by Jonathan Stray and Julian Burgess, is a good example of this use case. Using __tf-idf__-transformed features, Stray and Burgess build a network visualization that positions Iraq War logs in relation to their most distinctive keywords. This way of visualizing textual information led Stray to develop [the Overview Project](https://www.overviewdocs.com), which provides a dashboard for users to visualize and search thousands of documents at a time. We could use this kind of approach to graph our obituaries corpus and see if there are keyword communities. 

2. #### Textual Similarity and Feature Sets

Since __tf-idf__ will often produce lower scores for high frequency function words and increased scores for terms related to the topical signal of a text, it is well suited for tasks involving textual similarity. A search index will often perform __tf-idf__ on a corpus and return ranked results to user searches by looking for documents with the highest cosine similarity to the user's search string. The same logic can be used to ask a question like "Which obituary in our corpus is most similar to Nellie Bly's obituary?" 

Similarly, we could use __tf-idf__ to discover the top terms related to a document or a group of documents. For example, I could gather together a selection of obituaries about journalists (Bly included) and combine them into one document before running __tf-idf__. The output for that document would now work as a heuristic for terms that are distinctive in my journalism obituaries in the corpus when compared with other obituaries in the corpus. I could use such a term list for a range of other computational tasks.

3. #### As a Pre-processing Step

Item 2 gestures at why __tf-idf__ pre-processing is so often used with machine learning. __Tf-idf__-transformed features tend to have more predictive value than raw term frequencies, especially when classifying a supervised machine learning model, in part because it tends to increase the weight of topic words and reduce the weight of high frequency function words. One notable exception to this generalization is authorship attribution, where high frequency function words are highly predictive. As I will show in the next section, __tf-idf__ can also be used to cull machine learning feature lists and, often, building a model with fewer features is desirable.

### Potential Variations of Tf-idf

#### Scikit-Learn Settings

The Scikit-Learn ```TfidfVectorizer``` has several internal settings that can be changed to affect the output. In general, these settings all have pros and cons; there's no singular, correct way to preset them and produce output. Instead, it's best to understand exactly what each setting does so that you can describe and defend the choices you've made. The full list of parameters is described in [Scikit-Learn's documentation](https://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.TfidfVectorizer.html), but here are some of the most important settings:

1. ##### stopwords

In my code, I used ```python stopwords=None``` but ```python stopwords='english'``` is often used. This setting will filter out words using a preselected list of high frequency function words such as 'the', 'to', and 'of'. Depending on your settings, many of these terms will have low __tf-idf__ scores regardless because they tend to be found in all documents. 

2. #####  min_df, max_df

These settings control the minimum number of documents a term must be found in to be included and the maximum number of documents a term can be found in in order to be included. Either can be expressed as a decimal between 0 and 1 indicating the percent threshold, or as a whole number that represents a raw count. Setting max_df below .9 will typically remove most or all stopwords.

3. ##### max_features

This parameter can be used to winnow out terms by frequency before running tf-idf. It cn be especially useful in a machine learning context when you do not wish to exceed a maximum recommended number of term features.  

4. ##### norm, smooth_idf, and sublinear_tf

Each of these will affect the range of numerical scores that the __tf-idf__ algorithm outputs. norm supports l1 and l2 normalization, which you can read about on [machinelearningmastery.com](https://machinelearningmastery.com/vector-norms-machine-learning/). Smooth-idf adds one to each document frequency score, "as if an extra document was seen containing every term in the collection exactly once." Sublinear_tf applies another scaling transformation, replacing tf with log(tf). 

#### Beyond Term Features

Since the basic idea of __tf-idf__ is to weight term counts against the number of documents in which terms appear, the same logic can be used on other text-based features. For example, it is relatively straightforward to combine __tf-idf__ with stemming or lemmatization. Stemming and lemmatization are two common ways to group together different word forms/inflections; for example, the stem of both _happy_ and _happiness_ is _happi_, and the lemma of both is _happy_. After stemming or lemmatization, stem or lemma counts can be substituted for term counts, and the __(s/l)f-idf__ transformation can be applied. Each stem or lemma will have a higher __df__ score than each of the words it groups together, so lemmas or stems with many word variants will tend to have lower __tf-idf__ scores. 

Similarly, the __tf-idf__ transformation can be applied to n-grams. A Fivethirtyeight.com post from March 2016 called ["These Are The Phrases Each GOP Candidate Repeats Most"](https://fivethirtyeight.com/features/these-are-the-phrases-each-gop-candidate-repeats-most/) uses such an approach to perform the inverse-document frequency calculation on phrases rather than words. 

### Tf-idf and Common Alternatives

__Tf-idf__ can be compared with several other methods of isolating and/or ranking important term features in a document or collection of documents. This section provides a brief mention of four related but distinct measures that target similar but not identical aspects of textual information. 

1. #### Keyness

Keyness is a catchall term for a constellation of statistical measures that attempt to indicated the numerical significance of a term to a document or set of documents, in direct comparison with a larger set of documents or corpus. Depending on how we set up our __tf-idf__ transformation, it may isolate many of a document's most important features, but one clear advantage to keyness testing is that the result is often a numerical indicator of how atypical the term's usage in a text is. A Chi-square test, for example, we can evaluate the relationship of a term frequency to an established norm, and derive a P-value indicating probability of encountering the observed difference in a random sample. 

2. #### Topic Models

Topic modeling and __tf-idf__ are radically different techniques, but I find that newcomers to digital humanities often want to run topic modeling on a corpus as a first step and, in at least some of those cases, __tf-idf__ would be preferable. __Tf-idf__ is espeically appropriate if you are looking for a way to get a bird's eye view of your corpus early in the exploratory phase of your research. This is one reason __tf-idf__ is integrated into [the Overview Project](https://www.overviewdocs.com). Topic models can also help scholars explore their corpora, and they have several advantages over other techniques, namely that they suggest broad categories or communities of texts, but this a general advantage of unsupervised clustering methods. Topic models are especially appealing because documents are assigned scores for how well they fit each topic, and because topics are represented as lists of co-occurring terms, which provides a strong sense of how terms relate to groupings. However, the probabilistic model behind topic models is sophisticated, and it's easy to warp your results if you don't understand what you're doing. The math behind __tf-idf__ is lucid enough to depict in a spreadsheet. 

3. #### Automatic Text Summarization

Text summarization is yet another way to explore a corpus. Rada Mihalcea and Paul Tarau, for example, have published on TextRank, "a graph-based ranking model for text processing" with promising applications for keyword and sentence extraction. As with topic modeling, TextRank and __tf-idf__ are altogether dissimilar in their approach to information retrieval, yet the goal of both algorithms has a great deal of overlap. It may be appropriate for your research, especially if your goal is to get a relatively quick a sense of your documents' contents before designing a larger research project. 

## References and Further Reading

- Beckman, Milo. "These Are The Phrases Each GOP Candidate Repeats Most," _FiveThirtyEight_, March 10, 2016. https://fivethirtyeight.com/features/these-are-the-phrases-each-gop-candidate-repeats-most/

- Bennett, Jessica, and Amisha Padnani. "Overlooked," March 8, 2018. https://www.nytimes.com/interactive/2018/obituaries/overlooked.html

- Blei, David M., Andrew Y. Ng, and Michael I. Jordan, "Latent Dirichlet Allocation" _Journal of Machine Learning Research_ 3 (January 2003): 993-1022.

- Documentation for TfidfVectorizer. https://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.TfidfVectorizer.html

- Grimmer, Justin and King, Gary, Quantitative Discovery from Qualitative Information: A General-Purpose Document Clustering Methodology (2009). APSA 2009 Toronto Meeting Paper. Available at SSRN: https://ssrn.com/abstract=1450070

- "Ida M. Tarbell, 86, Dies in Bridgeport" _The New York Times_, January 7, 1944, p. 17. https://www.nytimes.com

- "Nellie Bly, Journalist, Dies of Pneumonia" _The New York Times_, January 28, 1922, p. 11. https://www.nytimes.com

- Salton, G. and M.J. McGill, _Introduction to Modern Information Retrieval_. New York: McGraw-Hill, 1983.

- Sparck Jones, Karen. "A Statistical Interpretation of Term Specificity and Its Application in Retrieval." Journal of Documentation 28, no. 1 (1972): 11–21.

- Stray, Jonathan, and Julian Burgess. "A Full-text Visualization of the Iraq War Logs," December 10, 2010 (Update April 2012). http://jonathanstray.com/a-full-text-visualization-of-the-iraq-war-logs

- Underwood, Ted. "Identifying diction that characterizes an author or genre: why Dunning's may not be the best method," _The Stone and the Shell_, November 9, 2011. https://tedunderwood.com/2011/11/09/identifying-the-terms-that-characterize-an-author-or-genre-why-dunnings-may-not-be-the-best-method/

- --. "The Historical Significance of Textual Distances", Preprint of LaTeCH-CLfL Workshop, COLING, Santa Fe, 2018. https://arxiv.org/abs/1807.00181

- Whitman, Alden. "Upton Sinclair, Author, Dead; Crusader for Social Justice, 90" _The New York Times_, November 26, 1968, p. 1, 34. https://www.nytimes.com

- "W. E. B. DuBois Dies in Ghana; Negro Leader and Author, 95" _The New York Times_, August 28, 1963, p. 27. https://www.nytimes.com

- "Willa Cather Dies; Noted Novelist, 70" _The New York Times_, April 25, 1947, p. 21. https://www.nytimes.com


## Alternatives to Anaconda

If you are not using Anaconda, you will need to cover the following dependencies:

1. Install Python 2 or 3 (preferably Python 3.6 or later)
2. Recommended: install and run a virtual environment
3. Install the Scikit-Learn library and its dependencies (see [http://scikit-learn.org/stable/install.html](http://scikit-learn.org/stable/install.html)).
4. Install Jupyter Notebook and its dependencies