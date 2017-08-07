---   
title: Reproducible Digital Humanities Topic Modelling Research with Anaconda, Jupyter, and python
authors:
- Jewell Thomas
- Marius van Niekerk
date: 2017-08-03
reviewers:
layout: lesson
---

{% include toc.html %}

# Lesson goals

Sharability and repeatabilty are core goals for all research, and this tutorial will help you meet those goals more easily in your digital humanities research. Here we show you how to combine the power of [Anaconda](https://anaconda.org) (an environment manager) with [Jupyter](http://jupyter.org), a browser-based interactive development environment (compatible with python, R, Julia, etc.), to build a development environment where you can easily create sharable NLP research. 

This tutorial will show you how to set up a complete notebook environment. This tutorial is geared toward intermediate to advanced users who are comfortable using the command line and already know some python. 


# Anaconda makes it easy to build re-createable development environments.
## What is Anaconda?
If we want to share our research, we need a straightforward way to allow collaborators to recreate the environment that we used to conduct that research. Practically, this means we need to make it as easy as possible for collaborators to install all the packages they need to run our code. Anaconda solves this problem, allowing you to easily create and maintain many different python environments on the same computer. 

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
ca-certificates           2017.7.27.1                   0    conda-forge
certifi                   2017.7.27.1              py36_0    conda-forge
ncurses                   5.9                          10    conda-forge
openssl                   1.0.2l                        0    conda-forge
pip                       9.0.1                    py36_0    conda-forge
python                    3.6.2                         0    conda-forge
readline                  6.2                           0    conda-forge
setuptools                36.2.2                   py36_0    conda-forge
sqlite                    3.13.0                        1    conda-forge
tk                        8.5.19                        2    conda-forge
wheel                     0.29.0                   py36_0    conda-forge
xz                        5.2.2                         0    conda-forge
zlib                      1.2.11                        0    conda-forge
```

### Activate your Anaconda environment and install python packages.

In order to use your enviroment for development, you need to 'activate' it by running the `activate` script included with Anaconda.

```bash
source activate prog_hist_env
```

After activating your environment, you can install any package you find in the [anaconda package repository](https://anaconda.org/) by executing the `conda` command listed there.

Later in this tutorial, we'll need to install a python NLP package (`gensim`) in order to call MALLET. Let's go ahead an install that now.

```bash
conda install -c anaconda gensim 
```

<div class="alert alert-warning">
If you're already familiar with pip from the [pip tutorial](https://programminghistorian.org/lessons/installing-python-modules-pip),
you can use that with Anaconda as well.

```bash
pip install gensim
```
</div>


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
ca-certificates=2017.7.27.1=0
certifi=2017.7.27.1=py36_0
chardet=3.0.2=py36_1
dbus=1.10.10=3
decorator=4.1.2=py36_0
entrypoints=0.2.3=py36_1
expat=2.2.1=0
[...]
```

You can redirect the output of this command to a text file for eash sharing and version control.

```bash
(prog_hist_env) public:ph-submissions thomasj$ conda list -e > requirements.txt

```

This text file can be used by anyone to recreate the exact Anaconda environment in which you developed your code. 

DO NOT RUN:
```bash
conda create -n --file requirements.txt
```

## Access other Anaconda resources.

You can [download a cheatsheet](https://conda.io/docs/_downloads/conda-cheatsheet.pdf) of commonly used commands. 

# Jupyter for notebook-based exploratory research.

## What's Jupyter?
Simply, the Jupyter project provides an intuitive environment for collaborative analytical code development. Jupyter is a client-server application. You run a Jupyter server from your computer and connect to this server from a browser to do your development in 'notebooks'. This setup will become more clear, but the key benefit of this style of development is that you can easly combine and preserve markdown with executable code and the results of that executation.

Jupyter supports a number of languages (including python as well as R). There are [many example notebooks](https://github.com/jupyter/jupyter/wiki/A-gallery-of-interesting-Jupyter-Notebooks#introductory-tutorials) online. 

## Install Jupyter.

To install Jupyter, activate your Anaconda environment:

```bash
source activate prog_hist_env
```

and execute the following command: 
        
```bash
conda install -c conda-forge jupyter 
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

Copy and paste the url as instructed into a Chrome (preferably) web browser. 
<div class="alert-warning">
Safari will work reasonbly well with Jupyter, Firefox and Internet Explorer are less supported.
</div>
        
You will get a page that looks like this: 

{% include figure.html filename="start-screen.png" caption="Jupyter welcome page" %}
        
You're now ready to start coding.  
            
## Access Jupyter notebooks with a browser.

### Create a new notebook.
Create a new notebook by selecting `new -> Python 3` from the dropdown in the top right corner. You have now created a new, blank notebook:

{% include figure.html filename="start-screen.png" caption="Jupyter welcome page" %}


You can see this file by returning to the terminal and running `ls` (on Unix/Mac) or `dir` on Windows. 

``` bash
public:programming_historian_tutorial thomasj$ ls -ltr
total 64
-rw-r--r--  1 thomasj  staff   1168 Aug  4 13:52 Untitled.ipynb

```

### Insert code & execute code.
You insert code in executable cell blocks. This lets you develop blocks of analysis without having to drop into the terminal to execute code.

Importantly, all cells share information. So, if you define a variable in one cell, you can access it from another:

{% include figure.html filename="cell-usage.png" caption="All Jupyter notebook cells share the same python process." %}


Jupyter allows you to easily get information on any python object by simply adding a `?` to the end of the object name and excuting the cell:

{% include figure.html filename="information.png" caption="Python usage easily accessible." %}

### Share your notebook analyses.

1) Check your .ipynb file into a github repository. Github will render the contents of your notebook.
2) Download a .pdf, html, or markdown version of your file.


<div class="alert-warning">
You can check .ipynb files into github and github will store, preserve, and render them correctly, but won't track incremental changes to the files.
</div>

   

# Use Jupyter and Anaconda to do topic modelling research.

This is a digital-humanities-specific example of what's possible with a notebook. We demonstrate calling [MALLET](https://programminghistorian.org/lessons/topic-modeling-and-mallet) (a very popular tool in digital humanities research) from Jupyter using a python package (gensim). We'll fit a MALLET LDA topic model on a collection of ee cummings poems. By combining Anaconda, Jupyter, python and MALLET, we can make our NLP analysis more easily reproducible and sharable. 

Each of the blocks below can be copy & pasted into a notebook. Or [access the notebook directly]().

## Download the latest version of MALLET to your local computer. 

This set of commands works only on `unix` and `mac`. If you're working on `windows`, please follow the MALLET installation instructions described [here](https://programminghistorian.org/lessons/topic-modeling-and-mallet#installing-mallet)
    
In Jupyter, you can run `bash` commands directly from your notebook by preceding with `!`


```python
! wget http://mallet.cs.umass.edu/dist/mallet-2.0.8.tar.gz # select desired MALLET version
! gunzip -d mallet-2.0.8.tar.gz -f
! tar -xvf mallet-2.0.8.tar
```

    --2017-08-07 13:12:12--  http://mallet.cs.umass.edu/dist/mallet-2.0.8.tar.gz
    Resolving mallet.cs.umass.edu... 128.119.246.70
    Connecting to mallet.cs.umass.edu|128.119.246.70|:80... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 14868234 (14M) [application/x-gzip]
    Saving to: ‘mallet-2.0.8.tar.gz’
    
    mallet-2.0.8.tar.gz 100%[===================>]  14.18M  5.65MB/s    in 2.5s    
    
    2017-08-07 13:12:14 (5.65 MB/s) - ‘mallet-2.0.8.tar.gz’ saved [14868234/14868234]
    
    x ./._mallet-2.0.8
    x mallet-2.0.8/
    x mallet-2.0.8/._bin
    x mallet-2.0.8/bin/
    x mallet-2.0.8/._build.xml
    x mallet-2.0.8/build.xml
    x mallet-2.0.8/class/
    x mallet-2.0.8/dist/
    x mallet-2.0.8/._lib
    x mallet-2.0.8/lib/
    x mallet-2.0.8/._LICENSE
    x mallet-2.0.8/LICENSE
    x mallet-2.0.8/._Makefile
    x mallet-2.0.8/Makefile
    x mallet-2.0.8/._pom.xml
    x mallet-2.0.8/pom.xml
    x mallet-2.0.8/._README.md
    x mallet-2.0.8/README.md
    x mallet-2.0.8/._sample-data
    x mallet-2.0.8/sample-data/
    x mallet-2.0.8/._src
    x mallet-2.0.8/src/
    x mallet-2.0.8/._stoplists
    x mallet-2.0.8/stoplists/
    x mallet-2.0.8/test/
    x mallet-2.0.8/stoplists/._de.txt
    x mallet-2.0.8/stoplists/de.txt
[...]


N.B.  Jupyter directly recognizes some `unix` commands such as `ls`, `rm`, `mkdir`.


```python
ls mallet-2.0.8/bin
```

    [31mclassifier2info[m[m*    [31mmallet.bat[m[m*         [31mtext2classify[m[m*      [31mvectors2topics[m[m*
    [31mcsv2classify[m[m*       [31mmallethon[m[m*          [31mtext2vectors[m[m*       [31mvectors2vectors[m[m*
    [31mcsv2vectors[m[m*        [31mprepend-license.sh[m[m* [31mvectors2classify[m[m*
    [31mmallet[m[m*             [31msvmlight2vectors[m[m*   [31mvectors2info[m[m*


## Install `gensim` from the terminal or directly from your notebook.

You need to install the core python topic modelling tool to be able to call out to MALLET from python.

```python
! conda install gensim --yes 
```

    Fetching package metadata ...............
    Solving package specifications: .
    
    # All requested packages already installed.
    # packages in environment at /Users/thomasj/anaconda/envs/prog_hist_env2:
    #
    gensim                    2.3.0               np113py36_0  


## Topic-model a collection of poems from Project Gutenberg.

Let's download a book of ee cummings poems from Project Gutenberg as an example corpus. This is pretty small corpus for topic modelling (only 40 or so poems), but allows us to demonstrate some of the basics.

```python
import requests

with requests.get("http://www.gutenberg.org/files/36508/36508.txt") as req:
    data = req.text
```

### Split collection of poems into individual documents.

By skimming the text on Gutenberg, we can find text that marks the beginning and the end of the interesting part of the text. We see that we can subdivide the text into individual poems by splitting the text any place we see a fully capitalized line. We build a list of those indexes

```python
import re

start = data.index("IN WHOSE SWORD-GREAT STORY SHINE THE DEEDS")
end = data.index("END OF THIS PROJECT GUTENBERG EBOOK EIGHT HARVARD POETS")

titles = [title for title in re.findall("[A-Z][A-Z0-9 \n]+", data[start:end]) if len(title) > 2]
indexes = [data.index(title) for title in titles] + [end]
```

We can use those indexes to split the original gutenberg texts into poem chunks:

```python
documents = []
for begin, end in zip(indexes, indexes[1:]):
    documents.append(data[begin:end])
```

### Prepare texts for topic-modelling.

We need to drop 'stop words' (words of non-interest), numbers, and empty strings.

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

stoplist = set('for a of the and to in *'.split())


texts = [[word.strip("()\r\n[].*") for word in re.split("[ ( ) \n]",document.lower()) if (word not in stoplist \
                                                                                and word is not None \
                                                                                and word is not ''
                                                                                and not is_number(word)
                                                                                ) ] for document in documents]

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


In our final prepatory step, we create an index of all the terms in our documents:

```python
from gensim import corpora

dictionary = corpora.Dictionary(texts)
corpus = [dictionary.doc2bow(text) for text in texts]
```

### Train a MALLET LDA model by using `gensim` to call MALLET.
When we go to train the MALLET model using gensim, we need to tell gensim the path to our MALLET installation. If you followed the directions above on `unix` or `mac`, MALLET was installed in the current working directory. On Windows the path will be something like C:\\mallet-2.0.8\\bin.

```python

import gensim

model = gensim.models.wrappers.LdaMallet('mallet-2.0.8/bin/mallet', 
                corpus=corpus, 
                num_topics=20,
                id2word=dictionary)

```

### Evaluate the resulting topics.

Our main goal was to demonstrate some of the mechanics, but some of the resulting topics do seem reasonable. For instance, night, moon, and dark cluster together in topic 0; dawn, sunlight, summer, gleam cluster together in topic 1. 

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




