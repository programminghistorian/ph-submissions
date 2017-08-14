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

Sharability and repeatabilty are core goals for all research; this tutorial will help you meet those goals more easily with your digital humanities research. Here we show you how to combine the power of [Anaconda](https://anaconda.org) (a data-science-focused environment manager) with [Jupyter](http://jupyter.org), (a browser-based interactive development environment), to create a development environment conducive to creating reproducible digital humanities research. 

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

TODO: more on install locations. What's the advantage of pip?

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

You're now ready to start coding. You can execute code directly in this notebook. There's now no need to drop down to the command line to execute code.

{% include figure.html filename="basic-notebook-points-annot.png" caption="Fig. 2 Annotations of important aspects of the notebook interface." %}
        
Jupyter notebooks are designed around cells. You can add as many cells as you like. When you execute a cell, the output appears below the cell. 


### Notes on using notebooks.

#### TODO: Execution

#### TODO: Cell types

#### Misc. Notes

Importantly, all cells share information. So, if you define a variable in one cell, you can access it from another:

{% include figure.html filename="cell-usage-annot.jpg" caption="Fig. 4 Program execution state is shared between cells." %}

If you get stuck while working, Jupyter allows you to easily get help information on any python object by simply adding a `?` to the end of the object name and excuting the cell:

{% include figure.html filename="information-annot.jpg" caption="Fig. 4 Access python help information from the notebook." %}


### Share your notebook analyses.

1. Check your `.ipynb` file into a github repository. Github will render the code and output from your notebook.
2. Download a `pdf`, `html`, or `markdown` version of your file.


<div class="alert-warning">
You can check .ipynb files into github and github will store, preserve, and render them correctly, but TODO: warning about binary files, you might want to perform [custom git configuration](https://gist.github.com/minrk/6176788) if you start running into issues with repository size.
</div>



# Example: running the example Jupyter notebooks with Anaconda 

As mentioned above, one of the benefits of the Juputer + Anaconda setup is that this combination makes research code more easily sharable. We'll demonstrate this facility by cloning Jupyter's github repository and running their sample notebooks. 

```bash
git clone https://github.com/jupyter/notebook
cd notebook
conda create -f docs/environment.yml -n jupyter_test_env
source activate jupyter_test_env
cd docs/source/examples/Notebook
jupyter notebook --no-browser --ip=0.0.0.0
```













