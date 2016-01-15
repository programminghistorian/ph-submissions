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

Let's try it out on a lesson or two and see how it goes.
