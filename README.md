# Programming Historian Submission Readme

To propose a lesson, please consult our [call for lessons](https://programminghistorian.org/posts/en-call-for-lessons). Before submitting a proposal, consult as well our [author guidelines](https://programminghistorian.org/en/author-guidelines) and look over our [published lessons](https://programminghistorian.org/) and our [publishing pipeline](https://github.com/programminghistorian/ph-submissions/issues?q=is%3Aopen+is%3Aissue+label%3Asubmission). 

## For Contributors

After your lesson has been accepted into our review process, your assigned editor will work with you to upload your lesson to this ph-submissions repository.

For more information, see our [author guidelines](https://programminghistorian.org/en/author-guidelines) and  [editor guidelines](https://programminghistorian.org/en/editor-guidelines). Our [translation guidelines](https://programminghistorian.org/en/translator-guidelines) are currently being updated.

### File Formatting 

We publish all our lessons in [Markdown](https://www.markdownguide.org/). Lessons should be titled: "lesson-name". The lesson markdown file will be uploaded to the corresponding language folder (for example, ["en"](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/en)), and placed either in the [drafts/originals](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/en/drafts/originals) directory or the [drafts/translations](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/en/drafts/translations) directory. Sample lessons, with proper yaml header, can be viewed in these directories.

Image files should be named: "lesson-image-1", "lesson-image-2". Image files go in the [images](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/images) directory, inside a folder named with the same slug as your lesson. 

## Viewing Lessons

The live URL for the English lessons in the publishing pipeline: http://programminghistorian.github.io/ph-submissions/en/drafts/originals/LESSON-SLUG

# Building Locally

To run this Jekyll site, you'll need Ruby version 2.6.2. 

It's best to install involves using `rbenv` to install Ruby with `rbenv install 2.6.2`. 

Next run `rbenv global 2.6.2` to set this version globally.

Install the `bundler` using `gem install bundler:2.1.4` 

Then build and serve the site with `bundle exec jekyll serve`
