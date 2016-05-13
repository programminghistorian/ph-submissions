---
title: An introduction to version control using GitHub Desktop
authors: 
- Daniel van Strien
date: 2016-02-13
reviewers:
- 
layout: default
---

## Lesson Goals

In this lesson you will be introduced to the basics of what version control and understand why it is useful. You will implement version control for a plain text document using [GitHub Desktop](https://desktop.github.com/). By the end of this lesson you should understand:
* what version control is and why it can be useful 
* the differences between Git and GitHub
* how to implement version control using ‘GitHub Desktop’ a Graphical User Interface for GitHub.

### Software Requirements
GitHub desktop is currently only available for Windows and Mac. If you use Linux you will probably already be familiar with the command line and will be able to use the command line version of GitHub. 

## What is Git and Github? 
Though often used synonymously Git and GitHub are two different things. Git is a particular implementation of version control originally designed by Linus Torvalds as a way of managing the Linux source code. [Other systems](https://en.wikipedia.org/wiki/Comparison_of_version_control_software) of version control exist though they are used less frequently. Git can be used to refer both to a particular approach taken to version control and the software underlying it. 

Github is a company which hosts git repositories (more on this below) and provides software for using Git. This includes ‘GitHub desktop’ which will be covered in this tutorial. GitHub is currently the most popular host of open source projects by [number of projects and number of users](https://en.wikipedia.org/wiki/Comparison_of_source_code_hosting_facilities#Popularity).

Although GitHub's focus is primarily on source code other projects, such as the Programming Historian, are increasingly making use of version control systems and GitHub to manage the work-flows of journal publishing. Becoming familiar with GitHub will be useful not only for version controlling your own documents but will also make it easier to contribute and draw upon other projects which use GitHub. In this lesson the focus will be on gaining an understanding of the basic aims and principles of version control by uploading and version controlling a plain text document. 

## What is Version Control and Why Use It?

Before turning to the practicalities of using GitHub desktop it is important to understand what version control is and why it might be useful for the work you are doing. At a basic level version control involves taking 'snapshots' of files at different stages. Many people will have introduced some sort of version control systems for files. Often this is done by saving different versions of the files. Often this looks something like this:

```
mydocument.txt
mydocumentversion2.txt
mydocumentwithrevision.txt
mydocumentfinal.txt
```

The system used for naming files may be more or less systematic. Adding dates makes it slightly easier to follow when changes were made:

``` 
mydocument2016-01-06.txt
mydocument2016-01-08.txt
```

Though this system might be slightly easier to follow, there are still problems with it. Firstly it doesn't explain what changes took place between these two saves. It is possible that some of these changes were small typo fixes but the changes could also have been a major re-write or re-structuring of a document. If you have a change of heart about some of these changes you also need to work out which date the changes were made in order to go back to a previous version. 

Version control tries to address problems like these by implementing a systematic approach to recording and managing changes in files. At its simplest, version control involves taking 'snapshots' of your file at different stages. This snapshot records information about when the snapshot was made but also about what changes occurred between different snapshots. This allows you to 'rewind' your file to an older version. From this basic aim of version control a range of other possibilities are made available. 

## Distributed version control 
TODO

## Why Version Control Text Documents?

As research increasingly makes use of digital tools and storage it becomes important to consider how to best manage our research data. This becomes especially important when we want to collaborate with other people. Though version control was originally designed for dealing with code there are many benefits to using it to with text documents too. Version controlling your document allows you to:

* Track developments and changes in your documents 
* Recover previous versions of your document
* Record the changes you made to your document in a way that you will be able to understand later
* Experiment with different versions of a document whilst maintaining the original version
* 'Merge' two versions of a document and manage any conflicts between the versions
* Collaborate with multiple people on the same document at the same time whilst recording who made what changes

Version control will not be necessary for all of the documents you write. However there are times when version controlling will be very useful. For any substantial work such as an article, book, or dissertation, version control makes a lot of sense.

The implementation of version control we are going to use in this lesson will be publicly available, but it is possible to use version control and keep your documents hidden permanently or until you decide to make them available. 

### Why not use Dropbox, Google Drive etc?
Dropbox, Google Drive and other services offer some form of version control in their systems. There are times when this may be sufficient for your needs. However there are a number of advantages to using a version control system like Git: 

* language support: Git supports both text and programming languages. As research moves to include more digital techniques and tools it becomes increasingly important to have a way of managing and sharing both the 'traditional' outputs (journal articles, books, etc.) but also these newer outputs (code, datasets etc.)
* more control: a proper version control systems gives you a much greater deal of control over how you manage changes in a document. As will be discussed in this lesson this requires some thought but if done will allow you to record changes in a way that is sensible rather than recording changes by time and date only,
* a useful history: related to the above point, using version control systems like Git will allow you to produce a history of your document in which different stages of the documents can be navigated easily both by yourself and by others. 

### Academic projects using version control 
Using version control has become pretty well established in some scientific disciplines, though its adoption is still far from universal. In the humanities and social sciences the use of version control systems like Git are much less common. The projects below show some possible ways of using Git in academic setting:

* [The Programming Historian](https://github.com/programminghistorian/jekyll) which uses GitHub in the work-flow of managing the [journal]https://github.com/programminghistorian/jekyll/issues, [lessons](http://programminghistorian.org/new-lesson-workflow) and [producing the site.](http://programminghistorian.org/posts/how-we-moved-to-github)
* [Python Programming for the Humanities](https://github.com/fbkarsdorp/python-course) is a tutorial introducing the Python programming language. 



## Getting Started

GitHub Desktop will allow us to easily start using version control. GitHub desktop offers a Graphical User Interface (GUI) to use Git. A GUI allows users to interact with a program using a visual interface rather than relying on text commands. Though there are some potential advantages to using the command line version of Git in the long run, using a GUI can reduce the learning curve of using version control and Git. If you decide you are interested in using the command line you can find more resources at the end of the lesson. 

### Register for a GitHub account and Installation

Since we are going to be using Github we will need to register for an account at [Github](Github.com) if we don't already have one. 

Once you have registered for an account the process for installing software will be slightly different depending on whether you are on Windows or Mac. Since the instructions may change it is best to follow the instructions at Github's [install page](https://desktop.github.com/). Once you have installed GitHub desktop and followed the setup instructions we can start using the software with a text document. 

## Version Controlling a Plain Text Document

Version control systems like Git work best with plain text files. Plain text files are files with minimal encoding, whereas word and other word processors produce a lot of code that is not human readable. The same text saved in a '.txt' file opens equally well in word, LibreOffice or notepad. This 'portability' of plain text files is a major benefit - they will open and display the text properly on almost any computer. 

Although there are many benefits to writing our documents in plain text files we quickly come across some limitations. We may want to emphasise parts of text with *italics* or with **bold** words. We may want to include headings or include quotations. This is where 'markdown' comes in. 

Markdown is a way of including formatting into a plain text document. You may have come across HTML or LaTeX in the past. These markup languages also express information about the formatting and structure of plain text. Markdown however tries to minimize the syntax. This makes it easier to focus on the content of writing without the markup getting in the way - hence the name 'markdown'. 

The Markdown syntax won't be covered in this lesson in order to keep the length short. However, it makes sense to explore Markdown once you have gone through this lesson and are comfortable with the basics of version control. GitHub integrates it's own version of Markdown syntax. If you add Markdown syntax to documents you version control with GitHub Desktop these will be rendered on the GitHub website. Arguably the best way to learn Markdown is to begin using it. The [Getting Started with Markdown](http://programminghistorian.org/lessons/getting-started-with-markdown) lesson by Sarah Simpkin provides an overview of Markdown whilst the lesson [Sustainable Authorship in Plain Text using Pandoc and Markdown](http://programminghistorian.org/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown) by Dennis Tenen and Grant Wythoff explains how to utilise Markdown in combination with Pandoc to use plain text in your academic writing. 


### Text Editors

To write in plain text we want to use a text editor. There are a huge number of free and paid text editors available. Some of these are very straightforward and simple to use whilst others have a learning curve and potential uses beyond simple text editing. In the long run using a more advanced and extendable text editor like Vim or Emacs may save you time but for now we can start with a simpler editor. If you don't want to install any new software then we can use our systems included text editor: text edit for Mac and 'notepad' for windows. If you decide to use markdown beyond this tutorial then you will benefit from a text editor which includes syntax highlighting for markdown as well as other features which will be useful for writing.  

### Create a Document 

We can begin with a very simple document. 

```
Hello world!
```

Include the above text or something similar in a new plain text document. Once you have done this save the file with a file extension '.md'. Make sure that it is saved in plain text format in a new folder. Sometimes your text editor will default to Rich Text Format. You should be able to change this in the preferences or options of your chosen text editor. Make sure to name the file and folder with something meaningful.

To most effectively use Git to version control it is important to organize projects in folders. Git tracks the contents of a folder creating a **repository** for each project. A repository is a 'folder' which contains files 'watched' for changes by Git. 

### Adding a Document

There are a number of different ways to **add** files to GitHub desktop to track. We can drag the folder containing the file onto GitHub desktop. When you do this you will be asked whether you want to create a repository for this folder. Alternatively we can click on the 'plus' icon to choose the folder we want to add. 

{% include figure.html src="../images/getting-started-with-github-desktop-2.png" caption="Adding a folder to GitHub Desktop" %}

Once we have added our folder we will be able to see it in a list of repositories on the left column. If we choose the repository we just added we will see the files contained in that repository. From this menu we can choose which files we want to version control. There might be times when we are working on projects in which files are produced which we don't need to version control, in particular log files. On the right we will see the current document. Lets go back to the document and add something new. 

```
hello world 
a second line
```

Save the changes to your file and go back to GitHub desktop. You will see that these new lines of text appear. This lets us know that GitHub is able to see changes at in your file but at the moment these changes aren't being recorded. 
To do this we need to **commit** our changes.

### Committing changes  

A **commit** tells Git that you made some changes which you want to record. Though a **commit** seems similar to saving a file there are different aims behind committing a document. Though people sometimes save different versions of a document, often you are saving a document merely to record the version as it is when it is saved. Saving the document means you can close the file and return to it in the same state later on. **Commits**, however, take a snapshot of the file at that point and allow you to document information about the changes made to the document. 

{% include figure.html src="../images/getting-started-with-github-desktop-3.png" caption="Committing changes" %}

To commit changes you must give a summary of the changes and include an optional message. It is important that you think carefully about when to make commits. The advantages of version control taking snapshots of your changes regularly relies on you making commits. It is often tempting to just commit changes when you have finished working on a document but this might not reflect when important changes occurred.

A useful way to think about commits is as the 'history' of your document. It records all of the developments and changes made to your documents and/or repository. In order for this history to be useful later on, either for ourselves or for someone else, it is important that this history is recorded at relevant points. Trying to make commits 'atomic' is also an important consideration. What this means is that each commit 'makes sense' on it's own. The changes in the commit and the message are understandable without having to look at surrounding commits. Thinking about how version control is used for code can make this idea more clear. When a new feature, or a bug fix, is added to some software it is important that these features can be isolated. If a commit includes changes to different aspects of the software it makes it hard to isolate when problems were introduced. It is also makes it difficult to remove a single change that is causing problems if other changes are included in the commit. 

There are differences between using version control for code and text which will impact on how you make commits. However, the aim of making commits 'atomic' can still be used. For example, it would make sense to commit changes to the structure of a document separately to grammar and spelling fixes. If you later decided to change the structure you would likely still want to maintain your other fixes. 


### Commit messages

It is important that you use meaningful commit summaries and messages. Writting good commit messages requires some prior thought. Messages that make sense to you as an explanation of changes when you make a commit may no longer make sense to you in the future. If you are going to use version control in collaboration with other people it is especially important that other people can understand your commit messages. Version control as a system for managing changes to documents works best when active thought goes into using the software. It is therefore particularly important when collaborating with other that there is a shared understanding and approach to using version control. 

One way of addressing this is to try to follow a 'commit style'. A [suggestion](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) for a commit style made by Tim Pope. The style suggestions made by Tim Pope are partly ['built in'](https://github.com/blog/926-shiny-new-commit-styles) to the GitHub Desktop commit message interface but understanding the format will help ensure a consistent approach. Tim Pope suggests the following format:

```
Capitalized, short (50 chars or less) summary

More detailed explanatory text, if necessary.  Wrap it to about 72
characters or so.  In some contexts, the first line is treated as the
subject of an email and the rest of the text as the body.  The blank
line separating the summary from the body is critical (unless you omit
the body entirely); tools like rebase can get confused if you run the
two together.

Write your commit message in the present tense: "Fix bug" and not "Fixed
bug."  This convention matches up with commit messages generated by
commands like git merge and git revert.

Further paragraphs come after blank lines.

- Bullet points are okay, too

- Typically a hyphen or asterisk is used for the bullet, preceded by a
  single space, with blank lines in between, but conventions vary here

- Use a hanging indent
```

It will not always be necessary to write an extensive commit message but is important that the message is clear about the changes being made and that the commits and the commit message are useful 'atomically'. 

An example of a short but clear commit message in the context of written work:


```
Reorder document outline

Moved the methods section below the sources section in the document outline. 
Why? Some of the methods discussion doesn't make sense without a description 
of the sources being used. 
```


### Building a good repository

The benefits of using version control rely to a large degree on using the system effectively. This means thinking about when to make commits and how to best convey the changes in that commit in a message. Focusing on making both your messages and your commits 'atomic' will make it easier to 'move' through different stages of your repositories history. A good repository will allow you to easily understand changes that were made at different stages, will be understood by other people and will help you reflect on the changes you make to a document. 

There is some difference between how you would manage a repository primarily focused on code and one focused on text. Both however benefit from being clearly and logically organised. This is something that is important to do with your research data regardless of whether you are version controlling it and/or making it public. For a useful introduction to managing research data see James Baker's lesson [Preserving Your Research Data](http://programminghistorian.org/lessons/preserving-your-research-data) which includes discussion of naming conventions and a logical approach to organising folders. 

### Publishing your repository

At the moment we are only recording our changes locally. We may be happy to only store our changes locally (it is still important to back our files up) but we may want to upload our repository onto Github to make it public or to have it stored outside of our computer. The process of doing this through GitHub Desktop is straight forward. On GitHub desktop you 'publish' repositories. This will **push** your repository from your computer to the Github website and set up a **remote** repository in the process. 

{% include figure.html src="../images/getting-started-with-github-desktop-4.png" caption="Publishing a repository" %}

Once you have 'published' your repository it will be viewable at Github's website. It is possible to setup a private repository on Github but this requires you to pay. To quickly view your repository online you can use the repository menu and choose 'View on GitHub'. This will bring you straight to your repository online. 

{% include figure.html src="../images/getting-started-with-github-desktop-5" caption="Repository menu" %}

You can now see your document in your online repository

{% include figure.html src="../images/getting-started-with-github-desktop-6.png" caption="The online repository you have published" %}

Once your document is online you will have to sync your local changes to reflect these changes on the GitHub repository. GitHub stores changes both locally (on your computer) and remotely (on their servers). It is important to keep these changes in sync. On GitHub desktop this process is simplified by using a sync option rather than using the **push** and **pull** commands use on the command line. You will see a 'sync' button on GitHub Desktop. This will ensure your local (computer) and remote (GitHub server) repositories are the same. 

### Making Changes Remotely

It is possible to make a change to your repository on the web interface. Clicking on the name of the file will take you to a new page showing your document. 

{% include figure.html src="../images/getting-started-with-github-desktop-7.png" caption="The view of your document online" %}

From this web interface you have a variety of options available to you including viewing the history of changes, viewing the file in GitHub desktop and deleting it. You can also see some other options next to 'code'.These options will not be so important to begin with but you may want to use them in the future. For now we will try editing a file in the web interface and syncing these changes to our local repository.

Click on the edit option

{% include figure.html src="../images/getting-started-with-github-desktop-8.png" caption="The edit link" %}

you will now be able to edit the file and add some new text. 

{% include figure.html src="../images/getting-started-with-github-desktop-9.png" caption="The editing view" %}

As you will see once you have made some changes to your file you will again see the option to commit changes. 

{% include figure.html src="../images/getting-started-with-github-desktop-10.png" caption="The remote commit view" %}


Once you have committed these changes they will be stored on the remote repository. To get them back onto our computer we need to sync our these changes. We will see the 'sync' button on GitHub desktop. 

{% include figure.html src="../images/getting-started-with-github-desktop-11.png" caption="The sync button" %}

We now have our remote changes synced back onto our computer.

{% include figure.html src="../images/getting-started-with-github-desktop-12.png" caption="Our document with remote changes synced" %}

You can see from this view that we now have the text with changes highlighted in green and red. Red indicates where things have been removed whilst green indicates additions. This can be useful for viewing the edits you have made before making a commit and helps you spot whether all the changes are ones you want to commit. On the left you will see a history of the changes you have made. At the moment this is very brief but as you work on a project the history might become much longer. Being able to see the changes you have made at different stages can be very useful. 

So far we have only implemented version control with a very basic document. Learning more about Markdown and writing in plain text will allow you to use version control in more the sorts of documents you would use in your day-to-day work. Version controlling a Markdown document will allow you to learn the Markdown syntax whilst re-enforcing your understanding of version controlling documents. 

[Sustainable Authorship in Plain Text using Pandoc and Markdown](http://programminghistorian.org/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown) by Dennis Tenen and Grant Wythoff will provide you with an understanding of how you could use plain text for academic writing using Pandoc and Markdown. Pandoc allows you to convert Markdown formated Plain Text files into numerous different formats including HTML, PDF and Word. The combination of Markdown, Pandoc and Version Control will provide a powerful, sustainable and flexible approach to academic writing. 

## Further Resources

* For [students](https://education.github.com/pack) and [researchers](https://github.com/blog/1840-improving-github-for-science) GitHub offers free private repositories. These repositories may be useful for early drafts of work or for managing notes which are never intended to becoming public. Note: it might not be a good idea to store things which are very sensitive on GitHub even in a private repository. 

Version control systems like Git have a lot of features available to use. Some of these will only be applicable in very specific contexts, others will be more commonly useful. Alongside the lesson suggested above the resources below will allow you to gain a deeper understanding of version control. 

* GitHub provides extensive support in the form of [guides](https://guides.github.com/) and [help](https://help.github.com/). 
* [Atlassian](https://www.atlassian.com/git/tutorials) Some in-depth but clear tutorials on using git. There is a focus on explaining the differences between git and other version control systems which may not be relevant but will help you understand the inner workings of git in greater detail. 
* [Pro Git](https://git-scm.com/book/en/v2) A book on Git. Begins with the basics and later covers more advanced usage of Git.


https://www.hastac.org/blogs/harrisonm/2013/10/12/github-academia-and-collaborative-writing - academic context 


