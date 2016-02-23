---
title: My Sample Lesson
authors:
- Caleb McDaniel
date: 2016-01-15
reviewers:
- Fred Gibbs
layout: default
difficulty: 1
---

Here is what a sample lesson will look like on the `ph-submissions` site.

## Sample Header

You can make headers, and see that they show up with the same styling that a published lesson has.

Code blocks work too:

```bash
echo "hello world!"
```

I can make [absolute links as normal](http://programminghistorian.org), though if I try to make a [relative link](../lessons/counting-frequencies) to a published lesson on the Programming Historian, that won't work, because this repo will only contain lessons that are works in progress.

However, I can add images for my lesson to the images directory here on the submissions repo, and then use the standard figure syntax to include it:

{% include figure.html src="../images/sample-lesson-1.png" caption="A sample image for my sample lesson, taken from Wikipedia entry for Digital History" %}

Voila!

## Another Sample Header

Everything appears to work when I put another sample header, too. This will allow reviewers to examine a lesson and see more or less exactly what it will look like.[^1]

## Tables

Here's a sample table from a different lesson:


| Command | What It Does |
|---------|--------------|
| `pwd` | Prints the 'present working directory,' letting you know where you are. |
| `ls` | Lists the files in the current directory
| `man *` | Lists the manual for the command, substituted for the `*`
| `cd *` | Changes the current directory to `*`
| `mkdir *` | Makes a directory named `*`
| `open` or `explorer` | On OS X, `open` followed by a file opens it; in Windows, the command `explorer` followed by a file name does the same thing.
| `cat *` | `cat` is a versatile command. It will read a file to you if you substitute a file for `*`, but can also be used to combine files.
| `head *` | Displays the first ten lines of `*`
| `tail *` | Displays the last ten lines of `*`
| `mv` | Moves a file
| `cp` | Copies a file
| `rm` | Deletes a file
| `vim` | Opens up the `vim` document editor.

[^1]: I say "more or less" so as not to court the vengeance of the Markdown gods!

