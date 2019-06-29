title: Introduction to Jupyter notebooks

collection: lessons

layout: lesson

slug: jupyter-notebooks

date:

translation_date:

authors:

- Quinn Dombrowski

- Tassie Gniady

- David Kloster

reviewers:

editors:

translator:

translation-editor:

translation-reviewer:

original:

review-ticket:

difficulty:

activity:

topics: Jupyter notebooks, Python

abstract: Jupyter notebooks provide an environment where you can freely combine human-readable narrative with computer-readable code. This lesson describes how to install the Anaconda software, how to run and create Jupyter notebook files, and contexts where Jupyter notebooks can be particularly helpful.

---

  

# Contents

  
  

## Contents

{:.no_toc}

  

* TOC

{:toc}

  

## Introduction

When computation is an intrinsic part of your scholarship, how do you publish a scholarly argument in a way that makes the code as accessible and readable as the prose that accompanies it? In the humanities, the publication of scholarship primarily takes the form of written prose, in article or monograph form. While publishers are increasingly open to the inclusion of links to supplementary code and other materials, such an arrangement inherently relegates them to secondary status relative to the written text.

What if you could publish your scholarship in a format that gave equal weight to the prose and the code? The reality of current academic publication guidelines means that the forcible separation of your code and written argumentation may be a necessity, and their reunification may be impossible without navigating numerous obstacles. (For instance, to be posted on a code-sharing platform like GitHub, the written article must be open-access, and you must obtain permission from the publisher if you've signed over your copyright as part of the publication agreement.) For work that is not entangled with a publisher, or where you have the necessary rights and permissions, Jupyter notebooks provide an environment where code and prose can be juxtaposed and presented with equal weight and value. 

Jupyter notebooks have seen enthusiastic adoption in the data science community, to an extent where they are increasingly replacing Microsoft Word as the default authoring environment for research. Within digital humanities literature, one can find references to Jupyter notebooks (split off from *iPython*, or interactive Python, notebooks in 2014) dating to 2015.

Jupyter Notebooks have gained more traction within digital humanities as a pedagogical tool. Multiple Programming Historian tutorials such as [Text Mining in Python through the HTRC Feature Reader](https://programminghistorian.org/en/lessons/text-mining-with-extracted-features),and [Extracting Illustrated Pages from Digital Libraries with Python](https://programminghistorian.org/en/lessons/extracting-illustrated-pages#jupyter-notebooks), as well as other pedagogical materials for workshops, make reference to putting code in a Jupyter Notebook or using Jupyter Notebooks to guide learners while allowing them to freely remix and edit code. The notebook format is ideally suited for teaching, especially when students have different levels of technical proficiency and comfort with writing and editing code. 

The purpose of Jupyter Notebooks is to provide a more accessible interface for code used in digitally-supported research or pedagogy. Tools like Jupyter Notebooks are less meaningful to learn or teach about in a vacuum, because Jupyter Notebooks themselves don't *do* anything to directly further research or pedagogy. Before you start this lesson, think about what you want to get from using Jupyter Notebooks. Do you want to organize your project workflow? Do you want readers of your scholarship to be able to follow the theoretical and technical sides of your argument without switching between a PDF and a folder of scripts? Do you want to teach programming workshops that are more accessible to attendees with a range of technical backgrounds? Do you want to use or adapt notebooks that other people have written? Keep your goal in mind as you work through this lesson: depending on how you imagine using Jupyter Notebooks, you may be able to skip sections that are mostly applicable in another context.
  

## Lesson Goals

In this lesson you will learn what Jupyter notebooks are; how to install, configure, and use the Jupyter Notebook software package; and when notebooks can be useful in research and pedagogical contexts.

The lesson will also touch on more advanced topics related to Jupyter Notebooks, such as using Jupyter Notebooks for programming languages other than Python, converting existing Python code to Jupyter Notebooks, and using Jupyter Notebooks to scale up computation in environments like high-performance computing clusters.
  

## Prerequisites

This lesson is suitable for intrepid beginners, assuming little by way of previous technical experience. In fact, Jupyter Notebooks are a great resource for people who are learning how to write code.

Depending on the notebook you want to run, you may need to [install some Python modules with pip](https://programminghistorian.org/en/lessons/installing-python-modules-pip), which assumes some familiarity with the command line (for [Windows here](https://programminghistorian.org/en/lessons/intro-to-powershell), or [Mac/Linux here](https://programminghistorian.org/en/lessons/intro-to-bash)).
  

## Literate Computing
The relationship between computer-readable code and human-readable text gained visibility within computer science in the 1970's, when Donald Knuth proposed the "literate programming" paradigm. Rather than organizing code according to requirements that privilege the computer's execution of the code, literate programming treats a program as literature understandable to human beings, prioritizing the programmer's own thought process. Literate programming as designed by Knuth takes the form of written prose, with computer-actionable code embedded in macros. Literate programming tools are used to generate two outputs from the literate program: "tangled" code that can be executed by the computer, and "woven" formatted documentation[^1].

Fernando Pérez, the creator of the iPython programming environment that ultimately became Project Jupyter, coined the term *literate computing* for the model used by Jupyter notebooks:
> A literate computing environment is one that allows users not only to execute commands but also to store in a literate document format the results of these commands along with figures and free-form text that can include formatted mathematical expressions. In practice it can be seen as a blend of a command-line environment such as the Unix shell with a word processor, since the resulting documents can be read like text, but contain blocks of code that were executed by the underlying computational system. [^2]

Jupyter is neither the first nor the only example of computational notebooks. As early as the 1980s, notebook interfaces were available through software such as Wolfram Mathematica and MATLAB. In 2013, Stéfan Sinclair and Geoffrey Rockwell proposed "Voyant notebooks" based on the model of Mathematica, which would expose some of the assumptions underpinning [Voyant Tools](https://voyant-tools.org) and make them user-configurable[^3]. They further developed this concept into [*The Art of Literary Text Analysis Spyral Notebooks*](https://voyant-tools.org/spyral/alta). 

Jupyter has gained traction across many fields as an open-source environment that is compatible with numerous programming languages. The name *Jupyter* is a reference to the three core languages supported by the project (Julia, R, and Python), but [kernels are available that make Jupyter compatible with tens of languages](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels), including Ruby, PHP, Javascript, SQL, and Node.js. It may not make sense to implement projects in all of these languages using Jupyter Notebooks (e.g. Omeka won't let you install a plugin written as a Jupyter Notebook), but the Jupyter environment can still be valuable for documenting code, teaching programming languages, and providing students with a space where they can easily experiment with provided examples.

## Installing Jupyter Notebooks

As of mid-2019, there are two environments that you can use to run Jupyter Notebooks: Jupyter Notebook (not to be confused with the Jupyter Notebook files themselves, which have an .ipynb extension), and the newer Jupyter Lab. Jupyter Notebook is widely-used and well-documented, and provides a simple file browser along with the notebook environment itself. Jupyter Lab is more complex, with a user environment more reminiscent of an Integrated Development Environment (discussed in previous Programming Historian tutorials for [Windows](https://programminghistorian.org/en/lessons/windows-installation), [Mac](https://programminghistorian.org/en/lessons/mac-installation), and [Linux](https://programminghistorian.org/en/lessons/linux-installation)). While Jupyter Lab is meant to eventually replace Jupyter Notebook, there is no indication that Jupyter Notebook will stop being supported anytime soon. Because of its comparative simplicity and ease of use for beginners, this tutorial uses Jupyter Notebook as the software for running notebook files.

### Anaconda

Anaconda is a free, open-source distribution of Python and R that comes with more than 1,400 packages, the Conda package manager for installing additional packages, and Anaconda Navigator, which allows you to manage environments (e.g. you can install different sets of packages for different projects, so that they don't cause conflicts for one another) using a graphical interface. After installing Anaconda, you can use Anaconda Navigator to install new packages (or <code>conda install</code> via the command line), but many packages are available only through pip (i.e. using <code>pip install</code> via the command line or in your Jupyter notebook). 

For most purposes, you want to download the Python 3 version of Anaconda, but some legacy code may still be written in Python 2. In this lesson, you will be using Python 3. The Anaconda installer is over 500 MB, and after installation it can take upwards of 3 GB of hard drive space, so be sure you have enough room on your computer and a fast network connection before you get started. 

<div class="alert alert-warning">If hard drive space is a concern, you can package up a notebook so it can be run using free cloud computing resources, rather than making users install Anaconda. This may be especially useful in workshop situations. See the <a href="#cloud">section on Binder below</a>.</div>

To download and install Anaconda, go to the [Anaconda website](https://www.anaconda.com/distribution/). Make sure you've clicked on the icon your operating system (which should change the text *Anaconda \[version number\] for \[selected operating system\] installer* to indicate your operating system), and then click the *Download* button in the box for the current version of Python 3. If you're on Windows, this should download an .exe file; on Mac, it's .pkg; on Linux it's .sh.

Open the file to install the software as you would normally on your operating system. Further installation details are available in the [Anaconda docs](https://docs.anaconda.com/anaconda/install/), including how to install Anaconda via the command line on each operating system. If your computer is unable to open the file you've downloaded, make sure you selected the correct operating system before downloading the installer. On Windows, be sure to choose the option for "Add Anaconda to PATH Variable" during the installation process, or you won't be able to launch Jupyter notebooks from the command line.

### Launching Jupyter Notebooks
After you've installed Anaconda, you can launch Anaconda Navigator like any other software application. You can close the prompt about creating an Anaconda Cloud account; you don't need an account to work with Anaconda. On the home screen, you should see a set of icons and brief blurbs about each application included with Anaconda. 

Click on the "Launch" button under the *Jupyter Notebook* icon. 
![Anaconda Navigator interface](anaconda-navigator.png)

If you prefer to use the command line instead of Anaconda Navigator, once you have Anaconda installed, you should be able to open a new Terminal window (Mac) or Command Prompt (Win) and run <code>jupyter notebook</code> to launch the web browser with the Jupyter Notebook application. 

Either approach will open up a new window or tab in your default browser with the Jupyter Notebook interface. Jupyter Notebook is browser-based: you only interact with it through your browser, even when Jupyter Notebook is running on your own computer.

## Navigating the Jupyter Notebook interface
The Jupyter Notebook file browser interface is **the only** way to open a Jupyter notebook (.ipynb) file. If you try to open one in a plain text editor, the notebook will be displayed as a JSON file. To view a notebook through the Jupyter interface, you have to launch Jupyter Notebook first (which will display in a browser window), and open the file from within Jupyter Notebook. Unfortunately, there is no way to set Jupyter Notebook as the default software application to open .ipynb files.

### File browser

When you launch Jupyter Notebook, it automatically displays your home directory. This is usually the directory with your username on a Mac (/Users/*your-user-name*). On a PC it is usually C:\\. 

To avoid cluttering this folder, you can make a new folder within this directory for your notebooks. You can either do this in your usual file management interface (Finder on Mac, or File Explorer on Windows), or within Jupyter Notebook itself. To add a new folder, click on *New* in the upper right, and choose *Folder*. This will create a new folder called "Untitled Folder". To change the name, click the checkbox to the left of the "Untitled Folder", then click on the "Rename" button that appears under the "Files" tab. Name the folder *notebooks*.

#### Opening notebook files
Download the [example notebook for this lesson](ph-jupyter-example.ipynb) and put it in the new *notebooks* directory you just created.

In the Jupyter Notebook file browser, open the *notebooks* directory and click on *ph-jupyter-example.ipynb*. This will launch a new browser tab with the interface for viewing, running, and editing Jupyter notebooks.

#### Creating a new notebook
<a id="creating"></a>
If you want to create a new Juyter notebook, click the "New" button in the upper right of the Jupyter Notebook file browser interface. If you've just installed Anaconda as described above, your only option will be to create a Jupyter notebook for Python 3, but we'll discuss below how to add other languages. Click on "Python 3", and Jupyter Notebook will open a new tab with the interface for Jupyter notebooks themselves. By default, the notebook will be named "Untitled"; you can click on that text to rename it.

### Notebook interface
Opening an .ipynb file or creating a new notebook brings you to a new tab with the interface for writing, editing, and running notebooks. If you haven't already, open the example notebook (*ph-jupyter-example.ipynb*).

As you can see in the example, a notebook is made up of *cells*: boxes that contain code or human-readable text. Every cell has a type, which can be selected from the drop-down options in the menu. The default option is "Code"; human-readable text boxes should use the "Markdown" type, and will need to be written using Markdown formatting conventions. To learn more about Markdown, see the ["Getting Started With Markdown"](https://programminghistorian.org/en/lessons/getting-started-with-markdown) Programming Historian lesson.

In the example notebook, the first cell is a Markdown cell. It includes a header, some text, a list, and an alert box.

#### Editing cells
To edit the text in a Jupyter notebook, you can either double-click it, or select the cell (which will show a vertical blue line on the left once it's selected) by clicking it once, and then hitting the Enter (Win) or Return (Mac) key. To leave editing mode, you can click click <i class="fa-step-forward fa"></i> in the toolbar or press Ctrl+Enter (Ctrl+Return on Mac).

To practice editing Markdown cells, do exercise 1 in the notebook.

To edit a Code cell, you just need to select it (which will show a green vertical line on the left) and start making changes.

As long as you're editing a cell, you can use Ctrl + Z (Win) or Command + Z (Mac) to undo changes that you've made. As soon as you've left editing mode for Markdown cells, or un-selected a code cell, you can no longer undo edits.

#### Running cells
In Jupyter Notebooks, you use the <i class="fa-step-forward fa"></i> button in the toolbar to *run* a cell. Running a Markdown cell just moves you down to the next cell. Running a Code cell executes the code inside the cell.

Jupyter notebooks work best if you run the cells sequentially. Sometimes you can get errors or incorrect outputs if you run the cells out of order or attempt to iteratively edit and run different parts of the notebook. If you've made lots of changes and run code blocks in a non-linear fashion and find that you're getting strange output, you can reset Jupyter Notebook by clicking on *Kernel* in the menu and choosing *Restart & Clear Output*.

When you run a code cell, a number will appear in brackets to the left of the cell. This number indicates the order in which the cell was run. If you go back and run the cell again, the number is updated.

If a number doesn't immediately appear next to the cell, you'll see an asterisk in brackets. This means that the code cell hasn't finished running. This is common for computationally-intensive code (e.g. natural language processing) or long-running tasks like web scraping. Whenever a code cell is running, the favicon in the notebook's browser tab changes to an hourglass <i class="fa fa-hourglass-start"></i>. If you want to change tabs and do something else while the code is running, you can tell that it's done when the hourglass changes back to the notebook icon <i class="fa-book fa"></i>.

To practice running and editing code cells, do exercise 2 in the notebook.

#### Adding, removing, and modifying cells
To add a new cell, click the plus button <i class="fa fa-plus"></i> in the toolbar. This will create a new code cell after the cell that you currently have selected. If you want to use it for human-readable text, you can change *Code* to *Markdown* in the toolbar dropdown.

To delete a cell, select it and click the scissors button <i class="fa fa-scissors"></i> in the toolbar. If you delete a cell by mistake, you can click on *Edit* in the menu and choose "Undo Delete Cells".

To copy a cell, select it and click the copy button <i class="fa fa-files-o"></i> in the toolbar. The paste button <i class="fa fa-clipboard"></i> will paste the cell below whatever cell is currently selected.

If you want to rearrange the ordering of cells, select the cell you want to move, then click the up <i class="fa fa-arrow-up"></i> or down <i class="fa fa-arrow-down"></i> button. 

You can split a cell (Markdown or code) wherever your cursor is located by clicking on *Edit* in the menu, and choosing *Split Cell*. While you can't undo splitting a cell, you can choose to merge the cell with the cell above, or the cell below, by going to *Edit* then *Merge Cell Above/Below*.

To practice adding and rearranging cells, do exercise 3 in the notebook.

#### Paths and file locations
Jupyter notebooks use the location of the notebook file itself (the .ipynb file) as the default starting path. For workshops and courses, it may make sense to create a folder where you can store the notebook, any attached images, and the data you're going to work with, all together. If everything isn't in the same folder, you'll have to include the path when referencing it, or use Python code to change the working directory (e.g. by assigning a full path to the variable *sourcefiledirectory* and using  `os.chdir(sourcefiledirectory)`).

#### Adding images
You can add images to Markdown cells in your Jupyter notebooks using standard Markdown syntax. If you have a Markdown cell in editing mode, you can even drag and drop an image from your computer into the cell, though the image has to be in the same folder as the Jupyter notebook itself for this to work. 

If it's safe to assume that the users of your notebook will have internet connectivity, it may be easier to add an image that's already online, as illustrated by the example notebook.

To practice adding images, do exercise 4 in the notebook.

#### Installing packages
Installing packages from within Jupyter notebooks can be a little tricky, because there may be differences between the *Jupyter kernel* that the notebook is using, and other versions of Python you may have installed on your computer. You can find a lengthy, technical discussion of the issues [in this blog post](https://jakevdp.github.io/blog/2017/12/05/installing-python-packages-from-jupyter/). 

If you are working on a notebook that you want to share, and it involves less-common packages, you can either include instructions in a Markdown cell that users should install the packages using conda or pip in advance, or you can use:
`import sys`
`!conda install --yes --prefix {sys.prefix} YourModuleNameHere`
to install something from the notebook using conda. Or, if the package isn't available in conda (many niche packages relevant for research aren't), you can use pip:
`import sys`
`!{sys.executable} -m pip install YourModuleNameHere`

If you hadn't installed Python on your computer prior to installing Anaconda for this lesson, you may need to add the *pip* package to be able to use it to install other packages. You can add it via the Anaconda Navigator GUI, or run `conda install pip` from the command line.

To practice installing packages from a notebook, do exercise 5. 

#### Saving and downloading notebooks

Jupyter autosaves your work periodically by creating "checkpoints". If something goes wrong with your notebook, you can revert to a previous checkpoint by going to "File", then "Revert to Checkpoint", and choosing a timestamp. That said, it's still important to save your notebook (using the save button <i class="fa fa-floppy-o"></i>), because if you close and shut down the notebook kernel, the checkpoints will be lost.

You can also download the notebook in several different file formats. Downloading the Notebook format (.ipynb) is useful if you want to share your code in its full notebook format. You can also download it as code in whatever language your notebook is in (e.g. .r if in R or .py if Python or .js if JavaScript), as an .html file, as a markdown (.md) file, or as a PDF via LaTeX. If you download it as code, the Markdown cells become comments.

Jupyter Notebooks can also be converted into HTML-based slides, which may be a good option if you're giving a talk for an audience where the code underpinning your argument will be important. To create a slideshow, go to *View* - *Cell Toolbar* - *Slideshow*. This adds a drop-down to the upper right corner of each cell, where you can specify whether it should be a slide, sub-slide, fragment, notes, or skipped. This also enables an export option for "Reveal.js slides", which will create an .html file that you can use to navigate between slides.


## Using Jupyter Notebooks
Now that you're familiar with how Jupyter Notebooks work, let's consider how they might be used in some contexts.

Jupyter Notebooks can be beneficial in a number of situations and for multiple purposes. Here we focus on three uses:
- For research
- For publication
- For pedagogy
- For collaboration

### For research
Jupyter Notebooks can be helpful as you're prototyping code for research projects, experimenting with different approaches and techniques. For example, you can build up code gradually while maintaining previous working versions. If you work out one code snippet that does what you need to process one particular text file, and you need to extend it to process an entire directory of files, you can duplicate the cell with the working code snippet and make your modifications on the copy -- so that if your code stops working, you can easily get back to the previous working state, higher up in the same notebook. 

You can use Markdown cells along the way to keep track of what things you've tried, of what did (and didn't) work, and URLs you used (e.g. Stack Overflow threads) to inform how you wrote the code. If your code-writing process includes venting frustration, Markdown cells are a much more expressive medium than using emotive file names, and less disruptive for keeping track of versions of the code.

Once you have a final version of your code, you can edit your notebook file to remove the previous versions, rants, etc., and tidy things up for a "publishable" notebook. Or you can copy and paste the final cells and notes into a new notebook file.

Sarah McEleney has published notebooks and Python scripts for her [research on Soviet socialist realism](https://github.com/sarahrahrah/Socialist-Realism-Project), and Mary Chester-Kadwell has published scripts and notebooks for ["text mining of English children's literature 1789-1914 for the representation of insects and other creepy crawlies"](https://github.com/mchesterkadwell/bughunt-analysis). 

### For publishing scholarship
For scholars who publish their work through open-access channels, and whose data sets can be freely redistributed, Jupyter notebooks can provide an ideal format for making the code underpinning a scholarly argument visible, testable, and reusable. While journals and presses may not accept Jupyter notebooks as a submission format, you could develop a notebook "version" of your paper that includes the full text (as Markdown cells), with code cells integrated into the flow of the scholarly narrative as an immediately-accessable illustration of the analysis you're describing. 

Publishing code that contributed to scholarship on GitHub or another respository is an increasingly common practice, but there are multiple barriers that readers have to navigate to make use of the code (e.g. look up a footnote to find out what scripts are being referenced, find the URL of the repository, go to the URL, look for the scripts, download them and associated data files, then run them). Integrating the code with the text of a publication makes it far more likely that readers will actually engage with the code, since they can simply run it within the same notebook where they're reading the argument.

José Calvo has an example of a [notebook accompanying an article on stylometry (in Spanish)](https://github.com/morethanbooks/publications/tree/master/Cervantes_Conquista), and Jed Dobson published [a set of notebooks](https://github.com/jeddobson/cdh) to accompany his book *Critical Digital Humanities: The Search for a Methodology*.

### For pedagogy
Jupyter Notebooks are a great tool for teaching coding, or for teaching concepts such as topic modeling or sentiment analysis that involve coding. The ability to provide instructions and explanations as markdown allows for educators to give detailed notes on the code by alternating Markdown and code cells, so that the Markdown text explains the code in the cell just below. This is helpful for hands-on workshops, as the instructions and code can be written in advance in a way that attendees can just open the notebook, download a dataset, and run the code as-is. If you expect to teach a workshop where students will have different levels of familiarity with coding, you can set up the notebook to have supplemental tasks for the students who are comfortable modifying code, but even the students who are hesitant about touching the code will still be able to achieve the main outcome of the workshop just by running pre-written code cells.

As another approach, you can also use Jupyter Notebooks for writing code as you go. In such a workshop, students can start with a blank notebook, and and write the code along with you. The cells help segment the code as you write it, as opposed to using a text editor or IDE (Integrated Development Environment) which does not break up the code as neatly and can cause confusion, especially when teaching beginners. 

You can also use Jupyter Notebooks for classroom assignments by giving directions in Markdown and having students write code in a blank cell based on the instructions. In this way, you can create an interactive coding assignment that teaches students not only the syntax and vocabulary of a coding language, but can also explain the best practices of coding in general. 

Notebooks can be used as an interactive textbook where students/participants do not just read the content and see the code examples, but can actually test the code and see how it works. 

There are many digital humanities "intro to Python" courses and workshops that use Jupyter notebooks (including [Introduction à Python et au développement web avec Python pour les sciences humaines](https://github.com/PonteIneptique/cours-python) by Thibault Clérice, translated from material by Matthew Munson). Jupyter notebooks are also commonly used in text analysis workshop, such as the [word vectors workshop at DH 2018](https://github.com/sul-cidr/dh2018-word-vector-workshops), taught by Eun Seo Jo, Javier de la Rosa, and Scott Bailey.

### For collaboration
When working on a project with collaborators who may only be involved for a short period of time (such as summer undergraduate interns), it's important to help them understand and start using the project's workflows without a lot of start-up time. Jupyter Notebooks can lay out these workflows step-by-step, explain where and how files are stored, and provide pointers to external tutorials and training materials to help collaborators who are less familiar with the project's technical underpinnings get started. 

## Converting existing Python code
Even if you like the idea of using Jpyter Notebooks, any format conversion requires additional work. If you already have your code written as Python scripts, conversion to Jupyter Notebooks is fairly straightforward. You can copy and paste the code from your .py file into a single code cell of a new notebook, and then split the code cell into segments and add additional Markdown cells as needed.

Alternately, it may be easier to segment as you transfer the code, copying one segment at a time into a new code cell. Either method works and is a matter of personal preference.


## Jupyter Notebooks for other programming languages
Jupyter Notebooks allow you to use many different programming languages including R, Julia, JavaScript, PHP, or Ruby. A current list of available languages can be found on the [Jupyter Kernels](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels) GitHub page. 

While Python is supported by default when you install Jupyter Notebook through Anaconda, the other programming languages need to have their language kernels installed before they can be run in Jupyter Notebook. The installation instructions are different for each language kernel, so it is best to find the instructions for your prefered language. To get an idea what this entails, check out examples for installing the [R](https://github.com/cyberdh/Text-Analysis/blob/master/installRkernelInJupyter.ipynb) kernel and the [JavaScript](https://github.com/n-riesco/ijavascript) kernel. The [Jupyter Kernels](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels) GitHub page has links to instructions for the other available language kernels.

Once you have the kernel for your desired language(s) installed, you can run notebooks written in that programming language, or you can create your own notebooks that execute that language. Each language with a kernel installed on your computer will be available as an option when you create a new notebook as [described above](#creating).

  
## Running Jupyter Notebooks in the cloud
<a id="cloud"></a>
There are multiple free and paid options for running Jupyter Notebooks using cloud computing resources. In research contexts, cloud computing resources may be able to handle computationally-intensive data processing more quickly than your computer. In the classroom, having students learn how to use Jupyter Notebooks using cloud computing resources can save time (compared to having students intall Anaconda) and reduce variability in their compute environments (everyone on the same platform, vs. negotiating differences between Windows and Mac). 

Because the options are evolving quickly, it's best to use your favorite search engine to find a recent list of cloud computing options for Jupyter Notebooks. One project that has seen particular uptake among academic users of notebooks is [MyBinder](https://gke.mybinder.org/), which will take a GitHub repository that contains Jupyter notebook .ipynb files related data (embedded images, data sets you want to use the notebooks on, etc.), and information about necessary packages and dependencies (in a requirements.txt or environment.yml file), and make it launchable using a cloud server. Once you've had MyBinder package up your GitHub repo, you can add a Binder "badge" to the readme file for the repo. Anyone viewing the repo can launch the notebook directly from their browser, without having to download or install anything. 

Because the data that the notebook needs to access has to be included in the repo, this won't work for all situations (e.g. if the data can't be legally redistributed on Github, or if you want people to use the notebook with their own data), but it's a great option for workshops or classes where everyone is working with the same, shareable data.

Shawn Graham has created some [templates for setting up Python and R Jupyter notebooks for use on Binder](https://github.com/o-date/notebooks).


## Scaling up computation with Jupyter notebooks
Many universities have some kind of centrally-funded high performance computing (HPC) cluster. An overwhelming majority of the researchers who use these resources are in the sciences, but usually any faculty member can request access. You may also be able to get access to regional or national HPC resources. These compute resources can significantly speed up large compute jobs, especially tasks like 3D modeling that can take advantage of compute nodes with powerful graphics processing units (GPUs). Learning how to use HPC clusters is a topic large enough for its own lesson, but Jupyter notebooks may enable you to take a shortcut. Some research computing groups offer easier ways for researchers to run Jupyter Notebooks using HPC cluster resources, and you can find [multiple general-purpose guides and examples](https://ask.cyberinfrastructure.org/t/how-can-i-run-jupyter-notebooks-on-my-institutions-hpc-cluster/74) for doing it. If you can get access to HPC resources, it's worth reaching out to the research computing IT staff and inquiring about how you can run your Jupyter Notebooks on the cluster, if you don't see documentation on their website. Research IT staff who work primarily with scientists may communicate more brusquely than you're accustomed to, but don't let it turn you off -- most research IT groups are enthusiastic about humanists using their resources and want to help, because disciplinary diversity among their user base is important for their metrics at the university level.

## Links

- A growing [list of Jupyter notebooks for DH](https://github.com/quinnanya/dh-jupyter), in multiple human and programming languages. Thanks to everyone who sent suggestions on Twitter; additional references are welcome.
- A detailed technical description of [installing Python packages from Jupyter](https://jakevdp.github.io/blog/2017/12/05/installing-python-packages-from-jupyter/)
  

## Acknowledgements

- Thanks to Stéfan Sinclair for the references to previous discussions of notebook usage in digital humanities.
- Thanks to Rachel Midura for suggesting the use of Jupyter notebooks for collaboration.

[^1]: Knuth, Donald. 1992. *Literate Programming*. Stanford, California: Center for the Study of Language and Information.

[^2]: Millman, KJ and Fernando Perez. 2014. "Developing open source scientific practice". In *Implementing Reproducible Research*, Ed. Victoria Stodden, Friedrich Leisch, and Roger D. Peng. https://osf.io/h9gsd/

[^3]: Sinclair, Stéfan & Geoffrey Rockwell. 2013. "Voyant Notebooks: Literate Programming and Programming Literacy". Journal of Digital Humanities, Vol. 2, No. 3 Summer 2013. http://journalofdigitalhumanities.org/2-3/voyant-notebooks-literate-programming-and-programming-literacy/