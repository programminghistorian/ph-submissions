---
layout: directory
title: About PH-Submissions
redirect_from: /about.html
---

This is an experimental site that we are using to redesign our submissions workflow.

The new workflow would work something like this:

1. An author would contact an editor and then write the lesson using the [usual instructions](http://programminghistorian.org/new-lesson-workflow) about Markdown. 
2. The author will create a GitHub account, if he or she doesn't have one already.
3. The editor will add the author's GitHub handle as a **collaborator** on the submissions repo, using the [collaboration settings](https://github.com/programminghistorian/ph-submissions/settings/collaboration) page.
4. The author now has the ability to make direct edits to the submissions repo. He or she will navigate to the [lessons directory](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/lessons) and click on the "New file" button. Using the naming and text editing boxes, the author gives the lesson a filename slug (using the [existing guidelines](http://programminghistorian.org/new-lesson-workflow#name-the-lesson-file)) and then copies and pastes the text. He or she then clicks on the "Commit new file" at the bottom.
5. Images for the lesson under review would need to be placed in the [images directory](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/images), either by the author via the command line or by an editor. 
6. An [issue](https://github.com/programminghistorian/ph-submissions/issues) is created for the new lesson, with a link to the live preview that should now exist. Reviewer comments and be made directly on this issue. When making edits to the lesson, the author may wish to include the issue number (using the `#1` syntax) in commit messages, so that a reference to the revision will show up on the ticket, though that is not strictly necessary.
7. When the lesson is ready to go, an editor will move the lesson over from the submissions repo to the main publication repo, together with related images.

An author, once given collaborator privileges, could also fairly easily upload images like this:

1. At the command line, type `git clone https://github.com/programminghistorian/ph-submissions.git`.
2. Then type `cd ph-submissions/images`, or open that directory in your GUI file explorer.
3. Now, copy all of the lesson images into this directory.
4. Then, from within the images directory, the author will do something like this:

``` bash
git add *
git commit -m "Add images for NEW LESSON NAME HERE"
git push 
```

An editor, once the lesson is complete, could "publish" it by a similar method: clone both the `jekyll` and `ph-submissions` repos to his/her local computer (if he/she hasn't done so already; if they already exist locally, then `git pull` down all changes in both repos and, using `git status`, make sure you are on the `gh-pages` branch in both before proceeding). Then locally copy the new lesson from the `ph-submissions/lessons` directory to the `jekyll/lessons` directory, and do the same with the images from `ph-submissions/images` to `jekyll/images`. Now `git add`, `git commit` and `git push` the updates in the `jekyll` repository.

One downside with this method is that the revision history will be preserved only within the submissions repo, and not on the live site. But that's not a huge downside, considering potential upside in ease of workflow.

Let's try it out on a lesson or two and see how it goes.
