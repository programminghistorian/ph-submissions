---
title: "Extracting Illustrated Pages from Digital Libraries with Python"
authors: "Stephen Krewson"
date: FIXME (date the lesson was moved to the jekyll repository and the added to the main site.)
reviewers: FIXME
editors: FIXME
difficulty: 3
activity: acquire
topics: [APIs, pandas, computer vision, parallelism]

abstract: "Digital library volumes, like the physical objects they remediate, are visually structured. However, much recent DH work makes use of textual features that lose all information about typography, paper, scan artefacts, diagrams, and pictures. Machine learning and API extensions by HathiTrust and Internet Archive are making it easier to extract scanned page regions of visual interest from digitized volumes. This lesson shows how to efficiently extract those regions and, in doing so, enable new, visual research questions."

review-ticket: FIXME
layout: lesson
---


# Contents

{% include toc.html %}


# Context

This lesson is intended for those whose research or interest has led them to look at public domain digitized books on HathiTrust (HT) or Internet Archive (IA). Specifically, it will help users who want to know more about visual layout and illustration. For instance, my own research is on changes in the frequency of pictures in early nineteenth-century children's books. Figuring out which pages in a set of books have images on them was essential for me to find out. 

Note that this lesson is only applicable to resources in HT or IA that are composed of *pages*. For instance, these techniques will work with records that are books or periodicals but not videos. In a subsequent lesson, I will discuss how to get *localized* information about visual regions of interest. This is a technical way of saying that the current lesson answers the yes/no question "are there picture(s) somewhere on this page?" while the next lesson will use machine learning to filter out false positives and answer the question "what are the coordinates of the proposed images on the page?"


# Comparison to Similar PH Lessons

*Programming Historian* (PH) features several lessons on working with large-scale text collections from digital libraries. The most relevant is Peter Organisciak and Boris Capitanu's ["Text Mining in Python through the HTRC Feature Reader."](https://programminghistorian.org/en/lessons/text-mining-with-extracted-features) Please consult the introductory sections of that lesson for an excellent summary of the HathiTrust Research Center (HTRC)--its scope, mission, and efforts to provide researchers access to in-copyright works. Roughly speaking, this lesson is different because it is aimed at acquiring *visual* information about the page layout. These *visual features* are precisely what is blocked or limited by copyright agreements. Think of the way that Google Books allows full-text searching, but can only show "snippets" of the results. The textual features that Peter and Boris discuss are essentially just counts of words and punctuation (generated from the existing OCR text) for each of the several billion pages in HT, regardless of copyright.

Sticking with the public domain allows us to access the OCR text in order (not just aggregated word counts) as well as estimate the visual components of a given page and download it if desired. Since I will be using a similar Python environment and data pipeline to that presented by Peter and Boris, I have made a chart of key similarities and differences.


| Feature/PH Lesson | HTRC Extracted Features | HT, IA Visual Features (this lesson) |
|-------------------------|-------------------------|------------------------------------------------------------|
| Development Environment | Python 3 (Anaconda) | Python 3 (Anaconda) |
| Data Exploration | Jupyter Notebooks | Jupyter Notebooks |
| Data Analysis | Pandas | Pandas |
| APIs | HTRC Feature Reader  | HT Data API (third-party), Internet Archive Python Library |
| Page Downloads | None | Full-page JPEGs |


# How Are Visual Features Obtained?

HathiTrust and Internet Archive use different sources when associating visual/bibliographic features with pages. They then store the resulting information in different formats. The best way to explain this is to show it concretely.

HathiTrust makes a field called `htd:pfeat` available for many of its public-domain texts. This field's type is `list` and it exists within a Python object that is associated with each volume. In a subsequent section, we will see how to access this object and its fields using the HT Data API. The semantics of the `htd:pfeat` name is as follows: `htd` stands for "HathiTrust Data [API]" and `pfeat` stands for "page-level feature." Year of publication, by contrast, is a volume-level feature. The [most recent documentation](https://www.hathitrust.org/documents/hathitrust-data-api-v2_20150526.pdf) for the Data API describes `htd:pfeat` on pages 9-10, within a section on "Extension Elements" for the Data API.


> * `htd:pfeat`­ - the page feature key (if available):
>    - CHAPTER_START
>    - COPYRIGHT
>    - FIRST_CONTENT_CHAPTER_START
>    - FRONT_COVER
>    - INDEX
>    - REFERENCES
>    - TABLE_OF_CONTENTS
>    - TITLE


In practice, there a quite a few more features that regularly appear. The one we will be working with is called IMAGE_ON_PAGE and it is more visual and less structural than those shown above. Note that the `htd:pfeat` array may either not exist or be empty for a given page. This makes it important to write Python code that is free of assumptions and handles the possibility of key errors (the error that happens when you try to access a non-existent field in an object or dictionary).

Tom Burton-West, a research librarian at the University of Michigan Library, works closely with HathiTrust and HTRC, HathiTrust's Research Center. Tom told me over email that HathiTrust is provided this information by Google, with whom they have worked closely since their (HT's) founding in 2008. A contact at Google gave Tom permission to share the following quote: 

> These tags are derived from a combination of heuristics, machine learning, and human tagging.

A planned future lesson on filtering out false positives for the IMAGE_ON_PAGE feature will be good opportunity to explain these three sources in more detail. Roughly speaking, an example heuristic might be that the first page in the volume page sequence is almost always the FRONT_COVER. Machine learning could be used to train models to discriminate, say, between image data that is more typical of lines of prose in a Western script or of the lines in an engraving. Human tagging is the manual assignment of labels to images. The ability to view a volume's illustrations in the EEBO and ECCO databases is an example of human tagging.

The use of "machine learning" by Google sounds somewhat mysterious. Until Google publicizes their methods, it is impossible to know the details. But reasonable inferences can be made about the amount of extra computing resources devoted to old public-domain book scans (probably very little!).

In all likelihood, the IMAGE_ON_PAGE features are generated by looking for "Picture" blocks in the OCR XML files. This is good segue to Internet Archive, which does not currently release any page-level features (whether textual or visual/structural). Instead, Internet Archive makes a number of raw files from the digitization process available to users. The most imporant of these for our purposes is the Abbyy XML file. Abbyy is a Russian company that dominates the market in optical character recognition software. I am compiling data on the version of Abbyy FineReader used in OCR-ing nineteenth century medical texts held in IA. The most popular versions are 8, 9, and 11. All recent versions of FineReader produce an [XML document](https://en.wikipedia.org/wiki/XML) that associates different "blocks" with each page in the scanned document. The most common type of block is `Text` but there are `Picture` blocks as well.

The IA equivalent to looking for IMAGE_ON_PAGE is parsing the Abbyy XML file and iterating over each page. If there is at least on Picture block on that page, then it is considered to have an IMAGE_ON_PAGE. This heuristic method of image discovery was pioneered by [Kalev Leetaru](https://blog.gdeltproject.org/500-years-of-the-images-of-the-worlds-books-now-on-flickr/) in 2014. Between then and 2018, speedups in Python's ability to parse large XML files and improvements to Internet Archive's API have made it possible to streamline Leetaru's implementation. While HT's IMAGE_ON_PAGE feature is binary and contains no information about the location of the image, the "Picture" blocks in the XML file are associated with a rectangular region on the page. However, since Abbyy FineReader specializes in recognizing letters from Western character sets, it is much less accurate when it comes to identifying image regions.

Part of the intellectual fun of this lesson is using a noisy dataset (OCR block tags) for a largely unintended purpose: identifying pictures and not words. At some point, it will become computationally feasible to run deep learning models on every raw page image in a volume and pick out the desired type(s) of picture(s). But since most pages in most volumes are uninillustrated, that is an expensive task. For now, it makes more sense to leverage the existing data we have from the OCR ingest process.


![Sample Abbyy file open in XML editor.](../images/extracting-illustrated-pages/abbyy-xml.png)


# Goals

By the end of the lesson you will be able to

- Set up the Anaconda Python distribution and create an environment
- Save a list of HT or IA volumes IDs generated by a search
- Access the HT and IA data APIs
- Find pages with selected page-level visual feature(s)
- Use the Pandas library to analyze and group the resulting data
- Download page JPEGs programmatically

The larger goal is to improve your data science skills by creating a historical image dataset and using metadata to formulate research questions about visual change over time.


# Suggested Prior Experience

You need to know the basics of how to use the command line and Python. You should understand the conventions for comments and commands in a command line tutorial. 

```bash
# this is an example command--don't actually run it!
source activate base

# On Windows, this command would be slightly different:
conda activate base
```

The hash marks indicate a comment. The command itself will be in color (this is called syntax highlighting). If the command is slightly different on a different OS, I will try to put the alternate version in a comment.

In teaching Unix, it's often the "paratextual" UI aspects (rather than the commands themselves) that confuse learners. A simple example: you need to be familiar with typing `y`/`n` or `yes`/`no` when asked by a script whether you want to proceed or not. For instance, `conda` will always ask you if you are OK with the memory or version requirements of an installation or update.

Having the version control program `git` installed is very useful, but optional. I recommend the following [PH lesson](https://programminghistorian.org/en/lessons/intro-to-bash) for learning or brushing up on your command line skills.


# Setup

## Install Miniconda

Anaconda is the leading scientific Python distribution. Its `conda` tool allows you to install libraries such as `numpy` and `tensorflow` with ease. I recommend installing the "Miniconda" version, since it does not come with any packages preinstalled. This encourages you to keep your base environment clean and only install what you need, reducing complexity. Note that you do not need to have Python installed; Minicoda will provide it for you.

Download and install Miniconda [here](https://conda.io/miniconda.html). Choose the latest stable release of Python 3. Accept all the defaults during the installation unless you have a good reason to choose something different. There is no need to install Microsoft Visual Studio if asked. If everything goes well, you should be able to run `which conda` (linux/macOS) or `where conda` (Windows) in your shell and see the location of the program in the output.

Important! From now on, I will simply say "shell" independent of operating system. There is a chart at the end of this section that shows some of the key differences. Windows users: do NOT use `PowerShell` or `cmd.exe`; use the program `Anaconda Prompt`. It's a good idea to pin this program to your taskbar.

## OS Differences

Select differences between operating systems when using `conda`.


| Command/OS | Linux | macOS | Windows |
|----------------------|-------------------------|-------------------------|------------------------|
| Shell program | Terminal (bash) | Terminal.app (bash) | Anaconda Prompt |
| Change directories | `cd` | `cd` | `cd` |
| List directory contents | `ls` | `ls` | `dir` |
| Delete a resource | `rm` | `rm` | `del` |
| Clear the console | `clear` | `clear` | `cls` |
| File path slash | / | / | \ |
| Activate `conda` env | `source activate <ENV>` | `source activate <ENV>` | `conda activate <ENV>` |
| Return to `base` env | `source deactivate` | `source deactivate` | `deactivate` |

## Environments

In a newly opened shell, run the following commands one after the other. The motivation for this is understanding how environments help control the complexity associated with using the `conda` and `pip` package managers in tandem. Unfortunately, not all Python libraries can be installed through `conda`. This means in some cases we will fall back to the standard Python package manager, `pip`. However, when we do so, we will use a version of `pip` installed by `conda`. This keeps all the packages we need for the project in the same virtual sandbox.

```bash
# shows the system-wide Python packages (hopefully not too many!)
pip freeze

# the only environment here should be named "base"
# you current environment is indicated by a preceding asterisk
conda env list

# currently installed packages in "base" (will be minimal!)
conda list
```

Now we create an environment, set it to use Python 3, and activate it. A handy cheatsheet of `conda` commands is [here](https://conda.io/docs/_downloads/conda-cheatsheet.pdf). I recommend printing this out and keeping it by your workstation. Go slow, especially at first. Try to think about the rationale for a command before running it. If you are not sure, it's always a good idea to research further by Googling. Connecting the syntax of a command to your goals as a researcher is essential to being able to think clearly about the project and its current status.


```bash
conda create --name extract-pages python=3.6
source activate extract-pages

# On Windows (see table)
conda activate extract-pages
```

![Listing and installing conda environments.](../images/extracting-illustrated-pages/conda-create-env.png)


## Conda Installs

Now we can use `conda` to install our first few packages: a localized version of `pip`, the Pandas data science library, and Jupyter Notebooks. All the other required packages (gzip, json, os, sys, and time) are part of the [standard Python library](https://docs.python.org/3/library/).


```bash
conda install pip
conda install pandas
conda install jupyter
```

Jupyter has many dependencies (other packages on which it relies), so this step may take a few minutes. Remember that when `conda` prompts you with `Proceed ([y]/n)?` you should type a `y` or `yes` and then press Enter to accept the package plan. Behind the scenes, `conda` is working to make sure all the required packages and dependencies will be installed in a compatible way.


## Pip Installs

If we were using the HTRC Feature Reader, we could install it with `conda`, but we will be using Robert Marchman's [wrapper](https://github.com/rlmv/hathitrust-api) for the HathiTrust [Data API](https://www.hathitrust.org/data_api). This package can only be installed with `pip`. See Fred Gibbs's [lesson](https://programminghistorian.org/en/lessons/installing-python-modules-pip) for an introduction to `pip` and Python package management.

We want to use `pip` in a specific, limited way: from within an existing `conda` environment. This keeps pip-installed libraries separate from the user and system-wide environments.


```bash
which pip

# Windows
where pip
```


The key is that the `pip` executable is housed within our environment! If you see two versions of `pip` in the output of the command above, make sure to type the full path to the *local* environment version in the command below:

![Two versions of pip! Use the local one.](../images/extracting-illustrated-pages/windows-where-pip.png)

Now we can move on and install the HT Data API wrapper and the Internet Archive's Python library (which is also only available through `pip`).


```bash
pip install hathitrust-api
pip install internetarchive

# Windows example where full path to local pip is specified
C:\Users\stephen-krewson\Miniconda\envs\extract-pages\Scripts\pip.exe install hathitrust-api internetarchive
```


To test if this succeeded, try to import the libraries from within an interactive Python session.

![Successful import from Python REPL](../images/extracting-illustrated-pages/python-repl-import.png)


# Get API Keys

The process for getting API keys is relatively painless for both HT and IA. For an explanation of APIs and authentication, see the following PH lesson. 

keys.py


# Get Volume IDs

## HathiTrust

## Internet Archive


# Authenticate to APIs


# Code Walkthrough

## Iterate over IDs


# Discussion


# Suggested Further Reading
