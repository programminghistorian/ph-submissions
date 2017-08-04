---   
title: |
    Collaborative Digital Humanities with Anaconda + Jupyter + Python
authors:
- Jewell Thomas
- Marius van Niekerk
date: 2017-08-03
reviewers:
layout: lesson
---

# collaborative-digital-humanities-anaconda-jupyter

{% include toc.html %}

# Lesson goals

    Openness, sharability and collaboration are core to the digital humanities ethos, common to projects ranging from corpus digitization [] to topic modelling tool development. It's become common for digital humanists who focus on data analaysis to make this analysis more repeatable and sharable by combining the power of anaconda (an enviornment manager) with Jupyter, a browser-based interactive development environment that simplifies the writing of analytical code in a number of languages. These tools together support Python, R, Julia, etc., though only the use of Python will be covered in this tutorial. 

    This tutorial will guide you through the process of setting up a complete environment that will allow you to develop and share notebook files ([example analytical notebooks](https://github.com/jupyter/jupyter/wiki/A-gallery-of-interesting-Jupyter-Notebooks#introductory-tutorials). This tutorial is geared toward intermediate users who are comfortable using the command line and already know a little bit of python. It builds on concepts discussed in previous lessons such as [leveraging packages](https://programminghistorian.org/lessons/installing-python-modules-pip) 
    to simplify your code. 


# Setting up a virtual environment with `anaconda`
## What problem does a virtual environment solve?
    Simply stated, when we want to share our analysis, we want a mechanism to make it as simple as possible for collaborators to 
    install all the packages that we used that we used to conduct the analysis. There is another popular virtual environment 
    for `python` (virtualenv), but it doesn't have quite the flexibility of anaconda, nor is it as tightly integrated with python
    data tools.


## Downloading & Installing `anaconda`

### Unix/Mac instructions
    Choose the Python 3 anaconda installation utility for your [operating system](https://www.continuum.io/downloads). 

### Windows instructions
    Choose the python 3 anaconda installation utility for your [version of Windows](https://www.continuum.io/downloads). 
    You'll notice there are two options for Windows anaconda installations, 32-bit and 64-bit. If you're unsure which you need, 
    follow [these instructions](https://support.microsoft.com/en-us/help/15056/windows-7-32-64-bit-faq) to determine what type of 
    system you use.

    After downloading the installer, simply click the link and follow the instructions.
    {screenshot}

## Using Anaconda

    ### Creating an enviroment
    After installing anaconda, open a terminal (or command prompt in Windows) and create an environment by executing 
    the following command:
    ```bash
    conda create -n prog_hist_env python=3
    ```
    which tells anaconda to create a new environment named `prog_hist_env` using the newest release of python [^endnote].


    Our newly created enviroment comes with a [number of packages](https://docs.continuum.io/anaconda/packages/pkg-docs) pre-installed. 
    You can see everything in the newly created environment by using the following command:

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

    ### Using the newly created environment & installing new packages

    You put your newly created enviroment to use by 'activating' it:
    ```bash
    source activate prog_hist_env
    ```

    You can install any package you find in the [anaconda package repository](https://anaconda.org/) by 
    searching and executing the `conda` command provided on the package page.

    For instance, the most popular python topic modeling package (gensim) isn't installed by default. 
    But you can install it by finding the correct package on [anaconda.org](https://anaconda.org/anaconda/gensim)
    and executing the command included there:

    ```bash
    conda install -c anaconda gensim 
    ```

    If you're already familiar with pip from the [pip tutorial](https://programminghistorian.org/lessons/installing-python-modules-pip),
    you can use that with anaconda as well.

    ```bash
    pip install gensim
    ```

## Other Anaconda resources

    You can download a cheatsheet of commonly used commands [https://conda.io/docs/_downloads/conda-cheatsheet.pdf]. 

# Developing analytical code with `jupyter` notebooks

## What problem does jupyter solve?
    Simply, the jupyter project provides an intuitive environment for collaborative analytical code development. 
    Typical integrated development environments (jetbrains pycharm, atom, etc.) are optimized for developing complex systems. 
    Jupyter is optimized for building complex analyses of data sets.

## Installing Jupyter

    To install jupyter, activate your conda environment:

    ```bash
    source activate prog_hist_env
    ```

    and execute the following command: 
        
    ```bash
    conda install -c conda-forge jupyter 
    ```

## Starting the Jupyter server

    To use jupyter, you simply need to fire up a jupyter process after activating your environment:
        
    ```bash
    jupyter notebook --ip=0.0.0.0 
    ```

    The ouptput of this command will look something like this: 
        
    >>>(new_env) public:programming_historian_tutorial thomasj$ jupyter notebook
    >>>[W 11:03:55.616 NotebookApp] server_extensions is deprecated, use nbserver_extensions
    >>>[I 11:03:56.636 NotebookApp] [jupyter_nbextensions_configurator] enabled 0.2.5
    >>>[I 11:03:56.644 NotebookApp] Serving notebooks from local directory: /Users/thomasj/programming_historian_tutorial
    >>>[I 11:03:56.644 NotebookApp] 0 active kernels 
    >>>[I 11:03:56.645 NotebookApp] The Jupyter Notebook is running at: http://localhost:8888/?token=25405cce1cc84214ce0880cea87fca6e8de29dc84e851546
    >>>[I 11:03:56.645 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
    >>>[C 11:03:56.646 NotebookApp] 
    >>> 
    >>>    Copy/paste this URL into your browser when you connect for the first time,
    >>>    to login with a token:
    >>>    http://localhost:8888/?token=25405cce1cc84214ce0880cea87fca6e8de29dc84e851546

    Copy and paste the url as instructed into a Chrome (preferably) web browser. Safari will work reasonbly well, there is no support for IE, and Firefox may be unreliable. You should get a page that looks like this: 
        
        [image]
        
    You're now ready to start coding.  
            
## Using Jupyter notebooks in the browser

### Creating a new notebook
    Create a new notebook by selecting new->Python 3 from the dropdown in the top right corner. 

    You can see your newly created `Untitled.ipynb` file by returning to the terminal and running `ls` (on Unix/mac) or `dir` on Windows. You will see an `Untitled.ipynb` file:

    ```bash
    public:programming_historian_tutorial thomasj$ ls -ltr
    total 64
    -rw-r--r--  1 thomasj  staff   1168 Aug  4 13:52 Untitled.ipynb

    ```

### Inserting code
    You insert code in executable cell blocks. This lets you develop blocks of analysis without having to drop into the terminal to execute code.

    Importantly, all cells share information. So, if you define a variable in one cell, you can access it from another:

### Getting usage information for python fucntions

    You can get usage information (python docstring) for any given function by simply adding a `?` to the end of the function 
    and excuting the cell:
    
### Sharing your notebook analyses

    You have two options for sharing your analysis:
    1) Check your .ipynb file into a github repository. Github will render the contents of your notebook.
    2) Download a .pdf, html, or markdown version of your file.


    *alert* You can check .ipynb files into github. Beware, though, the .ipynb file is really just a json file. 
    While github will store, preserve, and render it, github won't properly version control the code in your cells. 



    

    
    




