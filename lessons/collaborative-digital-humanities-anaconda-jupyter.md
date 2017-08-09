---   
title: Reproducible Digital Humanities Research with Anaconda, Jupyter, and python
authors:
- Jewell Thomas
- Marius van Niekerk
date: 2017-08-03
reviewers:
layout: lesson
---

{% include toc.html %}

# Lesson goals

Sharability and repeatabilty are core goals for all research; this tutorial will help you meet those goals more easily with your digital humanities research. Here we show you how to combine the power of [Anaconda](https://anaconda.org) (a data-science-focused environment manager) with [Jupyter](http://jupyter.org), (a browser-based interactive development environment), to create a development environment conducive to creating reproducible digital humanities research. We further provide a use-case, demonstrating how to use Anaconda, Jupyter, and python to codify and automate your MALLET NLP analysis. 

This tutorial is geared toward intermediate to advanced users who are comfortable using the command line and already know some python. 


# Anaconda makes it easy to build re-createable development environments.
## What is Anaconda?
If we want to share our research, we need a straightforward way to allow collaborators to recreate the environment that we used to conduct that research. Practically, this means we need to make it as easy as possible for collaborators to install all the packages they need to run our code. Anaconda solves this problem, allowing you and your collaborators to easily create and maintain many different python environments on the same computer. 

## Download & install Anaconda.

### Install on Unix/Mac.
Choose the python 3 Anaconda installation utility for your [operating system](https://www.continuum.io/downloads). 

After downloading the installer, simply open the file and follow the prompts to complete the installaion.


### Install on Windows.
Choose the python 3 Anaconda installation utility for your [version of Windows](https://www.continuum.io/downloads). 
You'll notice there are two options for Windows anaconda installations, 32-bit and 64-bit. If you're unsure which you need, 
follow [these instructions](https://support.microsoft.com/en-us/help/15056/windows-7-32-64-bit-faq) to determine what type of 
system you use.

## How to use Anaconda.

### Create a new enviroment.

After installing Anaconda, open a terminal (or command prompt in Windows) and create an environment by using the `conda` command:

```bash
conda create -n prog_hist_env python=3
```

This tells Anaconda to create a new environment named `prog_hist_env` using the newest release of python 3.


Our newly created enviroment comes initialized with some packages already installed. You can use another sub-command of `conda` to see what's currently installed in a given environment:

```bash
conda list --name prog_hist_env
```

which will give output that looks something like this:

```bash
public:programming_historian_tutorial thomasj$ conda list --name prog_hist_env
# packages in environment at /Users/thomasj/anaconda/envs/prog_hist_env:
#
openssl                   1.0.2l                        0  
pip                       9.0.1                    py36_1  
python                    3.6.2                         0  
readline                  6.2                           2  
setuptools                27.2.0                   py36_0  
sqlite                    3.13.0                        0  
tk                        8.5.18                        0  
wheel                     0.29.0                   py36_0  
xz                        5.2.2                         1  
zlib                      1.2.8                         3  
```

### Activate your Anaconda environment.

In order to use your enviroment for development, you need to 'activate' it by running the `activate` script included with Anaconda.

Mac/Unix
```bash
source activate prog_hist_env
```

Windows
```bash
activate prog_hist_env
```


### Install python packages.

After activating your environment, you can install any package you find in the [anaconda package repository](https://anaconda.org/) by executing the `conda` command listed there.

Later in this tutorial, we'll need to install a python NLP package (`gensim`) in order to call MALLET. Let's go ahead an install that now.

```bash
conda install gensim 
```


If you're already familiar with pip from the [pip tutorial](https://programminghistorian.org/lessons/installing-python-modules-pip),
you can use that with Anaconda as well.

```bash
pip install gensim
```

## Save an environment configuration as a text file.

After building your environment, you can create a sharable list the packages (with version numbers) installed in your environment:

```bash
(prog_hist_env) public:ph-submissions thomasj$ conda list -e
# This file may be used to create an environment using:
# $ conda create --name <env> --file <this file>
# platform: osx-64
appnope=0.1.0=py36_0
bleach=1.5.0=py36_0
boto=2.48.0=py36_0
bz2file=0.98=py36_0
decorator=4.1.2=py36_0
entrypoints=0.2.3=py36_0
gensim=2.3.0=np113py36_0
html5lib=0.999=py36_0
icu=54.1=0
[...]
```

You can redirect the output of this command to a text file for easy sharing and version control.

```bash
(prog_hist_env) public:ph-submissions thomasj$ conda list -e > requirements.txt

```

This text file can be used by anyone to recreate the exact Anaconda environment in which you developed your code. 

DO NOT RUN:
```bash
conda create -n new_env --file requirements.txt
```

## Access other Anaconda resources.


You can [download a cheatsheet](https://conda.io/docs/_downloads/conda-cheatsheet.pdf) of commonly used commands. 

# Jupyter for notebook-based exploratory research.

## What's Jupyter?

Simply, the Jupyter project provides an intuitive environment for collaborative analytical code development. Jupyter is a client-server application. You run a Jupyter server from your computer and connect to this server from a browser to do your development in 'notebooks.' This system will become more clear, but the key benefit of this approach is that you can easly combine and preserve results of exploratory analysis with the code necessary to reproduce that analysis.


Jupyter supports a number of languages (including python and R). There are [many example notebooks](https://github.com/jupyter/jupyter/wiki/A-gallery-of-interesting-Jupyter-Notebooks#introductory-tutorials) online. 

## Install Jupyter.

To install Jupyter, activate your Anaconda environment:

```bash
source activate prog_hist_env
```

and execute the following command: 
        
```bash
conda install jupyter 
```

## Start the Jupyter server.

To use Jupyter, you need to start a Jupyter process in your activated environment (on your local computer):
        
```bash
jupyter notebook 
```

The ouptput of this command will look something like this: 
   
```bash     
(new_env) public:programming_historian_tutorial thomasj$ jupyter notebook
[W 11:03:55.616 NotebookApp] server_extensions is deprecated, use nbserver_extensions
[I 11:03:56.636 NotebookApp] [jupyter_nbextensions_configurator] enabled 0.2.5
[I 11:03:56.644 NotebookApp] Serving notebooks from local directory: /Users/thomasj/programming_historian_tutorial
[I 11:03:56.644 NotebookApp] 0 active kernels 
[I 11:03:56.645 NotebookApp] The Jupyter Notebook is running at: http://localhost:8888/?token=25405cce1cc84214ce0880cea87fca6e8de29dc84e851546
[I 11:03:56.645 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 11:03:56.646 NotebookApp] 
 
    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
    http://localhost:8888/?token=25405cce1cc84214ce0880cea87fca6e8de29dc84e851546
```

Copy and paste the url as instructed into a Chrome or Safari web browser.    

<div class="alert-warning">
Jupyter is not fully supported on Firefox or Internet Explorer.
</div>

### Create a new notebook.        

You will get a page that looks like this: 

{% include figure.html filename="start-screen-annot.png" caption="Fig. 1 Notebook directory is empty to start with." %}


Create a new notebook by selecting `new -> Python 3` from the dropdown in the top right corner. 

You're now ready to start coding. You can execute code directly in this notebook. There's no need to drop down to the command line.

{% include figure.html filename="basic-notebook-points-annot.png" caption="Fig. 2 Annotations of important aspects of the notebook interface." %}
        
Jupyter notebooks are designed around cells. You can add as many cells as you like. When you execute a cell, the output appears below the cell. 


### Create plots in your notebook.

In order to create plots in a notebook, we need to install `matplotlib` (which we can do right from the notebook) & enable plotting in the notebook.

{% include figure.html filename="plotting-annot.png" caption="Fig. 3 Include plots in your notebook." %}  

### Notes on using notebooks.

Importantly, all cells share information. So, if you define a variable in one cell, you can access it from another:

{% include figure.html filename="cell-usage-annot.jpg" caption="Fig. 4 Program execution state is shared between cells." %}

If you get stuck while working, Jupyter allows you to easily get help information on any python object by simply adding a `?` to the end of the object name and excuting the cell:

{% include figure.html filename="information-annot.jpg" caption="Fig. 4 Access python help information from the notebook." %}


### Share your notebook analyses.

1. Check your `.ipynb` file into a github repository. Github will render the contents of your notebook.
2. Download a `pdf`, `html`, or `markdown` version of your file.


<div class="alert-warning">
You can check .ipynb files into github and github will store, preserve, and render them correctly, but won't track incremental changes to the files.
</div>


# Example: use Jupyter and Anaconda to script MALLET topic modelling research.

This is a digital-humanities-specific example of what's possible with the notebook environment. We demonstrate calling [MALLET](https://programminghistorian.org/lessons/topic-modeling-and-mallet) (a very popular tool in digital humanities research) from Jupyter using a python package (gensim) as an interface layer. We'll fit a MALLET LDA topic model on a collection of ee cummings poems. By combining Anaconda, Jupyter, python and MALLET, we can make our NLP analysis more easily reproducible and sharable. Parts of the below tutorial are drawn from tutorials available [here](https://radimrehurek.com/gensim/tutorial.html).

Each of the blocks below can be copy & pasted into a notebook. Alteratively, [access the complete notebook](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/collaborative-digital-humanities-anaconda-jupyter/jupyter-anaconda-mallet-eecummings.ipynb).

## Install the latest version of MALLET to your local computer, note its installation path. 

If you do not already have MALLET installed on your computer, please follow the MALLET installation instructions described [here](https://programminghistorian.org/lessons/topic-modeling-and-mallet#installing-mallet). Locate the complete path to the MALLET `bin` directory. If you followed along in previous tutorials, this directory would be `C:\mallet\bin` on Windows and `/user/mallet-2.X.X/bin` on Unix/Mac, where X.X corresponds to the version that you installed. 
    
You can list the contents of this directory from your notebook and ensure that the `mallet` executable is present.

On Mac:   
```python
ls /user/mallet-2.0.8/bin
```

	classifier2info*    mallet.bat*         text2classify*      vectors2topics*
	csv2classify*       mallethon*          text2vectors*       vectors2vectors*
	csv2vectors*        prepend-license.sh* vectors2classify*
	mallet*             svmlight2vectors*   vectors2info*


On Windows:   
```python
dir C:\\mallet\\bin # notice the double back-slash
```

	classifier2info*    mallet.bat*         text2classify*      vectors2topics*
	csv2classify*       mallethon*          text2vectors*       vectors2vectors*
	csv2vectors*        prepend-license.sh* vectors2classify*
	mallet*             svmlight2vectors*   vectors2info*

## Install `gensim` Anaconda package, which provides a python interface to MALLET.

You need to install the `gensim` topic modelling package to be able to call MALLET from python. If you didn't install it above, you can install it from the notebook by executing the following in a cell by itself:


```python
! conda install gensim --yes 
```

## Topic-model a collection of texts from Project Gutenberg.

Let's download a book of ee cummings poems from Project Gutenberg and model the topics of the individual poems. This is a relatively small corpus for topic modelling (only 40 or so poems), but it will allow us to demonstrate the basic mechanics of topic modelling in a notebook.


```python
import requests
with requests.get("http://www.gutenberg.org/files/36508/36508.txt") as request:
    data = request.text
```

### Prepare texts for topic-modelling.

By skimming the Gutenberg text, we can identify textual markers we can use to extract the core of the text, disregarding the frontmatter and the endmatter for this analysis. We can also identify textual markers that allow us to separate individual poems from one another (the poems become documents for the purposes of topic modelling). We build a list of the position of each of these markers so that we can use them to break our downloaded book into chunks.

```python
import re

""" first line after front matter """
start = data.index("IN WHOSE SWORD-GREAT STORY SHINE THE DEEDS") 

""" first line of end matter """
end = data.index("END OF THIS PROJECT GUTENBERG EBOOK EIGHT HARVARD POETS") 

"""(each poem is prefaced by a title in all-caps, and poem titles are 
the only places where all-caps lines appear in the body of the book, 
so we use these lines to indicate start and end of poems)"""

titles = [title for title in re.findall("[A-Z][A-Z0-9 \n]+", data[start:end]) if len(title) > 2] 

indexes = [data.index(title) for title in titles] + [end] 
```

We can use those indexes to split the original gutenberg texts into poem chunks:

```python
documents = []
for begin, end in zip(indexes, indexes[1:]): 
    documents.append(data[begin:end])
```


We drop numbers, empty strings, and 'stop words' (words of non-interest).

```python
def is_number(word):
    """checks whether a string is a number"""
    try:
        int(word)
        return True
    except ValueError:
        return False
```


```python
import re

def is_useful_word(word):
  """checks various conditions of words"""

  stoplist = set('for a of the and to in *'.split())

  if (word not in stoplist and not is_number(word) and word is not None and word is not ''):
    return True
  else:
    return False

for document in documents:
  words = re.split("[ ( ) \n]", document.lower())
  texts.append([word.strip("()\r\n[].*") for word in words if is_useful_word(word)])

```

We also remove words that appear only once:

```python
from collections import defaultdict
frequency = defaultdict(int)

for text in texts:
    for token in text:
        frequency[token] += 1

texts = [[token for token in text if (frequency[token] > 1) ]
          for text in texts ]

from pprint import pprint  # pretty-printer
pprint(texts)

# (code from here: https://radimrehurek.com/gensim/tut1.html)
```

    [['whose'],
     ['great',
      'story',
      'shine',
      'deeds',
      '',
      '',
      'thou',
      'whose',
      'sword-great',
      'story',
      'shine',
      'deeds',
      'history',
      'her',
      'heroes,',
      'sounds',
      'tread',
      'those',
      'vast',
      'armies',
      'marching',
      'dead,',
      'with',
      'standards',
      'neighing',
      'great',
      'steeds',
      'moving',
      'war',
      'across',
      'smiling',
      'meads;',
      'thou',
      'by',
      'whose',
      'page',
      'we',
      'break',
      'precious',
      'bread',
      'dear',
      'communion',
      'with',
      'past,',
      'wed',
      'valor,',
      'battle',
      'with',
      'heroic',
      'breeds;',
      '',
      'thou,',
      'froissart,',
      'that',
      'thou',
      'didst',
      'love',
      'pen',
      'while',
      'others',
      'wrote',
      'steel,',
      'accept',
      'all',
      'praise',
      'after',
      'ages,',
      'hungering',
      'days',
      'whom',
      'old',
      'glories',
      'move,',
      'old',
      'trumpets',
      'cry;',
      'who',
      "gav'st",
      'as',
      'one',
      'those',
      'immortal',
      'men',
      'his',
      'life',
      'that',
      'his',
      'fair',
      'city',
      'might',
      'not',
      'die',
      '',
      '',
      '',
      ''],
     ... ]


In our final prepatory step, we create an index of all the terms in our documents and replace the words of our texts with their index id:

```python
from gensim import corpora

dictionary = corpora.Dictionary(texts)
corpus = [dictionary.doc2bow(text) for text in texts]
```

### Train an LDA model.

When we go to train the MALLET model using `gensim`, we need to tell `gensim` the path to our MALLET installation. As noted above, if you followed the directions from [the previous tutorial](https://programminghistorian.org/lessons/topic-modeling-and-mallet#installing-mallet), MALLET was installed in C:\\mallet\\bin (Windows) and /user/mallet-2.X.X/bin (Unix/Mac).


```python

import gensim

model = gensim.models.wrappers.LdaMallet('/user/mallet-2.0.8/bin/mallet', 
                corpus=corpus, 
                num_topics=20,
                id2word=dictionary)

```

### Evaluate the resulting topics.

After fitting the model in the notebook, we can also evaluate the results in the notebook. As noted, our sample corpus size was very small (meaning that we do not expect great performance), but some of the topics do seem reasonable. For instance, night, moon, and dark cluster together in topic 0; and dawn, sunlight, summer, gleam cluster together in topic 1. 


```python
from pprint import pprint
pprint(model.print_topics())
```

	  [(0,
	  '0.076*"night" + 0.047*"moon" + 0.040*"love" + 0.039*"light" + 0.038*"song" '
	  '+ 0.033*"dark" + 0.025*"trees" + 0.023*"voice" + 0.022*"high" + '
	  '0.019*"thought"'),
	 (1,
	  '0.035*"dawn" + 0.029*"music" + 0.020*"hear" + 0.019*"sound" + 0.014*"gleam" '
	  '+ 0.014*"sunlight" + 0.013*"dead" + 0.012*"summer" + 0.012*"moonlight" + '
	  '0.011*"fingers"'),
	 (2,
	  '0.028*"thou" + 0.014*"face" + 0.014*"eyes" + 0.010*"gaze" + 0.010*"half" + '
	  '0.009*"and," + 0.009*"lonely" + 0.008*"wide" + 0.007*"mist" + 0.007*"hath"'),
	 (3,
	  '0.039*"time" + 0.036*"silent" + 0.033*"stars" + 0.032*"eyes" + '
	  '0.029*"golden" + 0.028*"life" + 0.028*"waters" + 0.024*"pale" + 0.021*"day" '
	  '+ 0.021*"great"'),
	 (4,
	  '0.030*"thou" + 0.022*"gods" + 0.016*"night," + 0.015*"thee" + 0.014*"gold," '
	  '+ 0.011*"face" + 0.010*"dead," + 0.010*"things," + 0.010*"earth\'s" + '
	  '0.009*"hills"'),
	 (5,
	  '0.018*"flowers" + 0.011*"mine" + 0.010*"shine" + 0.010*"dear" + '
	  '0.010*"thou" + 0.009*"stand" + 0.008*"silence" + 0.008*"lights" + '
	  '0.008*"garden" + 0.008*"deeds"'),
	 (6,
	  '0.014*"oh," + 0.013*"sea" + 0.012*"years" + 0.012*"lost" + 0.011*"phantoms" '
	  '+ 0.011*"watched" + 0.011*"desolate" + 0.011*"dim" + 0.010*"wake" + '
	  '0.010*"wings"'),
	 (7,
	  '0.053*"long" + 0.040*"soul" + 0.038*"heart" + 0.034*"men" + 0.033*"thy" + '
	  '0.023*"heart," + 0.021*"souls" + 0.020*"wide" + 0.019*"earth" + '
	  '0.018*"rain"'),
	 (8,
	  '0.012*"softly" + 0.010*"eyes" + 0.010*"grew" + 0.010*"branches" + '
	  '0.009*"earth" + 0.009*"immortal" + 0.009*"god" + 0.008*"sad" + 0.007*"dim," '
	  '+ 0.007*"aerial"'),
	 (9,
	  '0.016*"web" + 0.011*"red" + 0.010*"loud" + 0.009*"bridge" + 0.008*"amid" + '
	  '0.008*"white" + 0.008*"tangled" + 0.008*"breeze" + 0.008*"green" + '
	  '0.007*"dark"'),
	 (10,
	  '0.019*"land" + 0.018*"faint" + 0.017*"wind" + 0.017*"dreams" + 0.012*"days" '
	  '+ 0.011*"black" + 0.011*"then," + 0.011*"sea" + 0.010*"fairy" + '
	  '0.010*"unknown"'),
	 (11,
	  '0.021*"beauty" + 0.020*"strange" + 0.018*"rose," + 0.016*"crimson" + '
	  '0.015*"dead" + 0.014*"youth" + 0.013*"love" + 0.013*"more," + '
	  '0.013*"rapture!" + 0.012*"deep"'),
	 (12,
	  '0.014*"street" + 0.011*"pass" + 0.010*"black" + 0.008*"marble" + '
	  '0.008*"band" + 0.008*"ye" + 0.007*"sails" + 0.007*"break" + '
	  '0.006*"suddenly" + 0.006*"hung"')]




