---
title: "Building a Digital Exhibition with CollectionBuilder"
slug: digital-exhibition-collectionbuilder
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Natasha Nunn
- Sarah Severson
reviewers:
- Forename Surname
- Forename Surname
editors:
- Agustín Cosovschi
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/660
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction to the lesson

This lesson will teach you how to use **CollectionBuilder** (CB) to create and customize a online exhibition featuring digital objects hosted on another platform, such as the Internet Archive.

### Prerequisites

To do this lesson, you will need the following:

- Knowledge of how to write in Markdown ([Getting Started with Markdown](https://programminghistorian.org/en/lessons/getting-started-with-markdown) by Sarah Simpkin).

- Knowledge of how to manage a basic GitHub account repository ([An Introduction to Version Control Using GitHub Desktop](https://programminghistorian.org/en/lessons/retired/getting-started-with-github-desktop) by Daniel van Strien)

- Any curated set of online objects and their corresponding metadata in a CSV file.

## Background: What is CollectionBuilder & why would you choose it?

[CollectionBuilder](https://collectionbuilder.github.io/) is an open-source framework for publishing metadata-based digital exhibits based on static web page technology. Its main objective is to provide a simple model for disseminating collections in a practical and sustainable manner. It does not require advanced computer skills or infrastructure, but it allows for interactive elements, such as a timeline and map. CollectionBuilder is a project of the University of Idaho Library\'s [Digital Initiatives](https://www.lib.uidaho.edu/digital/) and the [Center for Digital Inquiry and Learning](https://cdil.lib.uidaho.edu/) (CDIL) following the [Lib-Static](https://lib-static.github.io/) methodology.

The CollectionBuilder framework is a viable alternative to digital exhibit publishing platforms like [Omeka](https://translate.google.com/website?sl=auto&tl=en&hl=en&client=webapp&u=https://es.wikipedia.org/wiki/Omeka) and the more complex [Wax](https://translate.google.com/website?sl=auto&tl=en&hl=en&client=webapp&u=https://minicomp.github.io/wax/) system. It is ideal for those who lack advanced computing resources or the time to learn how to use more complex systems. While our lesson focuses on using digital objects hosted on another platform, uploading small collections of items directly to GitHub is also possible and outlined in the CollectionBuilder documentation. CollectionBuilder is also an excellent pedagogical tool because it provides a hands-on entry point for students to learn interoperable digital humanities skills, such as metadata management, GitHub file management, Markdown, and basic web development. It also increases general technical literacy to understand how web publishing works while prioritizing the values of openness, transparency, and sustainability.

CollectionBuilder offers three [different templates](https://collectionbuilder.github.io/templates.html):

1.  **CB-SHEETS** allows you to update collections directly from a Google Sheet making it ideal for prototyping or collaborating and seeing changes in real time.

2.  **CB-GH** requires that you upload your metadata spreadsheet to your repository and allows for more customizations making it suitable for teaching and learning GitHub, Git, and other web workflows

3.  **CB-CVS** allows for the most customization, but you must download software to your computer. More advanced display templates let you incorporate 360-degree panorama images, compound objects (like a scrapbook or an archival folder), and multiples (like a postcard with a front and back or texts and their transcripts).

This lesson will use the **CB-GH template**, which has fewer software dependencies and uses a collection of digital objects already online in the Internet Archive. However, projects can later be moved to the more advanced CollectionBuilder-CSV template for further customization by following [their instructions](https://collectionbuilder.github.io/cb-docs/docs/walkthroughs/transfer-walkthrough/).

## 1. Design your online exhibitions: What story do you want to tell?

Online exhibitions can enhance access to digital objects by allowing curators, like yourselves, to add narrative context, offer interactive experiences, and enhance metadata.

Before you choose which digital objects to feature in your exhibition, define your exhibition's goals, target audience, and desired experience. This will give you a good starting point for curating your content and considering design and visualization elements.

The following questions may be helpful as you define your site's goals:

- What do you want people to see? Outline the display options - pages and item types.

- What do you want people to do? Outline some behaviour options

  - What would you like to browse by specific types of metadata?

  - Does your collection have geographic or time-based metadata that
    would be helpful to browse on a map or a timeline?

- What kind of objects or items do you have in the collection?

  - Photographs or other image-based media?

  - Books or other multi-page items you would like people to flip
    through and read?

  - Postcards with information on both the front and back

  - Metadata with no objects, like profiles of people

CollectionBuilder templates have lots of built-in options, including:

- Slideshow to feature items

- Timeline to browse items by year

- Map for geolocation

- Browse metadata terms like subject, location or genre

- Pages for explanatory text about your project

These options allow you to add more narrative context to your exhibit.

In our example, we have a group of digitized playbills that are multi-page objects. We would like to enhance them with more browsing options to make the collection easier to explore by genre or timeline.

## 2. Prepare your metadata for your exhibition.

To prepare the exhibit, you first need a collection of objects described in a CSV that we can map to the CollectionBuilder metadata guide so that all the exhibit components work.

### Using Internet Archive Advanced Search to download metadata

If you are like us and have a collection of objects already in the Internet Archive (IA), you can use their [Advanced Search](https://archive.org/advancedsearch.php) page to craft specific queries and export the results as a CSV file.

In our example, we are using a collection of [English playbills](https://archive.org/details/bpsc_playbills) from the Bruce Peel Special Collections at the University of Alberta Library, which was digitized in 2019 and is available on the Internet Archive.

To create your query, you can use the top advanced search form to try out different combinations until you get the right one. Luckily, in our example, we can query them using the collection identifier **bpsc_playbills**, which is found in the URL. When we do our test search, IA converts our search into their desired query syntax **collection:(bpsc_playbills).** You can also construct a query with keywords, Field-Specific searches and use boolean operators.

Once you have your query, select which metadata fields you want to include in your download. If you are not sure which ones you want, you can select all and then go through them later. This will give you both the descriptive metadata and the administrative metadata from the IA platform. For more information on what each metadata field contains, you can look at the [IA metadata schema](https://archive.org/developers/metadata-schema/index.html), but not all uploaders will follow it, so be cautious!

Once you've got your metadata, you'll want to clean it up to include only what you want to use in your exhibition. Some helpful tips on metadata can be found at the following links:

- Tips on formatting your metadata [https://collectionbuilder.github.io/cb-docs/docs/metadata/formatting/](https://collectionbuilder.github.io/cb-docs/docs/metadata/formatting/)

- UTF-8 encoding error [https://collectionbuilder.github.io/cb-docs/docs/metadata/uploading/](https://collectionbuilder.github.io/cb-docs/docs/metadata/uploading/)

- File naming: rename it using all lowercase letters, no spaces, and no special characters (e.g. playbill-demo.csv)

### Mapping your metadata to the CollectionBuilder fields

To make sure your exhibition works properly, your metadata needs to follow the structure expected by CollectionBuilder. This means your CSV file must contain specific fields with correct formatting so the template can display items, maps, timelines, and other features.

Below, we explain only the fields required for this example project. You can explore the full metadata guide anytime at: [CB-GH Metadata Template](https://collectionbuilder.github.io/cb-docs/docs/metadata/gh_metadata/).

#### CollectionBuilder Required-fields

- **objectid:** The objectid field is how CollectionBuilder identifies each item in your collection and connects it to its metadata. Objectid Requirements:

  - Must be all lowercase

  - No spaces or special characters (hyphens - and underscores _ are allowed)

  - Should be unique for each item

In our example, the Internet Archive identifier is already a suitable objectid. You simply need to rename the corresponding column header in your CSV file to objectid.

- **Filename**: This field contains the direct URL to your digital object, such as a PDF, image, or audio file. For objects hosted on the Internet Archive (IA), you can choose the display option that works best for your exhibition.\ In our example, we want visitors to see the full-screen flipbook version of each item, so we use URLs like https://archive.org/details/BP_CCTT_0001/mode/2up?view=theater

- **Title**: This should correspond to a title that the original object carries. It is recommended that it be short and descriptive. In our example, some playbills have more than one play, so we have separated the play titles with a semicolon. Ex: Othello; The Deserter

- **Format**: This field indicates the item's media type. Since CollectionBuilder uses logic based on format to display objects, this is the most important field to ensure the interactive visualizations and item pages function correctly. If there are errors or anomalies, some pages will not work. For normal items, the value of this field should match the standard [MIME type](https://www.iana.org/assignments/media-types/media-types.xhtml) corresponding to your item's file, consisting of a type and a subtype concatenated with a slash (/) between them. This can generally be inferred by looking at the file extension (e.g. ".jpg", ".pdf", etc). The common MIME type "format" values supported by CB-GH are:

  - Image: image/jpeg, image/png

  - Document: application/pdf (like our example of the playbills)

  - Audio: audio/mp3

  - Video: video/mp4

#### Metadata Fields used for Visualizations

CollectionBuilder features automatic creation of views or entry points to the collection, using the information provided in the metadata file. These will generate interactive views to explore the collection on different pages. Each "extra" page needs a different type of information, which is explained below:

- **Date**: This field typically refers to the date of creation or publication of an object and is used for sorting and displaying on the timeline. The format to follow is YYYY-MM-DD, with the four digits of the year being the minimum value needed to form the timeline. Examples: for December 25, 1989:1989-12-25. If you have date information that does not fit into this ISO format, like \ ?-02-24 ] or [ date unknown ] or 1900s, you can add a new metadata field under a different name so that this information is displayed with the items, but not included in the timeline visualization. In our example, we called it the **field-date**

- **Map**: To create a map, you need the metadata fields in the columns latitude (latitude, north-south information) and longitude (longitude, east-west information), that is, the coordinate data of a location corresponding to the object you present in the exhibition.In our lesson, we won't be creating a map because we don't yet have geographic information about our collection, but it's easy to add to the CSV metadata after.

- **Subjects**: Create a word cloud with the topics that each object deals with in the subject column. You can put multiple topics in each box (for each object) and separate them with a semicolon ( ;). In our example, each playbill has been given genres like comic drama; comedy; extravaganza which follow the order of appearance on the playbill.

#### Optional fields

CollectionBuilder templates can support as many descriptive metadata fields as you want, following the interests of the digital collection\'s creators and audience.

Some common additions include:

- **Creator**: Name of the person who created the original object that has been digitized or in our case

- **Description**: A brief note about the object

- **Source**: Designates the source of the object, such as its location in the physical collection in a file and may follow its corresponding format

- **Language**: You can indicate the language associated with the object. If you add it, it is recommended to follow the ISO 659-2 code for each language: en for English, es for Spanish, pt for Portuguese, etc.

- **Rights**: A text containing information about the audience's rights over digital objects

- **Rights Statement:** Link to a standardized interoperable rights statement from https://rightsstatements.org/en/

## 3. Setting up CollectionBuilder

Before you can set up your digital exhibition, you'll need a [GitHub account](https://github.com) for your archive, library, museum, or personal use. These accounts are free to sign up for and can be used for various purposes. Once you have an account and are logged in, you can proceed with the lesson. [More information on working with Github](https://collectionbuilder.github.io/cb-docs/docs/repository/gitworkflow/)

### 3.1 Clone the repository

To set up CollectionBuilder for your exhibition, you first need to navigate to the CollectionBuilder template you want to use in Github, in our case [collectionbuilder-gh](https://github.com/CollectionBuilder/collectionbuilder-gh).

In the top right-hand corner, you will see an option to "Use this template." If you don't see this button, you need to sign in to your GitHub account first.


{% include figure.html filename="en-or-digital-exhibition-collectionbuilder-01.png" alt="Visual description of figure image" caption="Figure 1. Caption text to display" %}


When you click on that button, you will have two options. You want to "Create a new repository." This will let you copy all of the template files to your account so you can start building your exhibition. This will give you all the framework repository defaults to get you started.

In the "Create a new repository" screen, you must name your new repository. The name will be in your URL and needs to be unique. You can also make it public or private. We encourage people to keep their repositories public to show off their work to friends and get help if needed.

#### Repository contents

Now that you have cloned the template for your exhibition, let's briefly look at what is in each folder

- **_data**: Contains three types of files that help form the "skeleton" of the display. The demo and template comma-separated values (CSV) files are examples for various digital object types and can be left alone as references. We will later be adding your metadata file to this folder. Several configuration files let you edit the vocabulary for browsing objects (config-browse.csv), viewing the map (config-map.csv), metadata (config-metadata.csv), general navigation or menu (config-nav.csv), search (config-search.csv), and a table (config-table.csv). Lastly, there is the YML type file (human-readable data serialization format) for configuring the page theme, which you do not have to worry about.

- **_includes and \_layouts**: These folders contain the HTML files that make up many of the features of the CollectionBuilder tool. In this lesson, we will be doing all of our customization without touching these files.

- **\_sass and assets**: This is where you\'ll find the SCSS ( Syntactically Awesome Style Sheets ) files that provide the visual side of the web page (colours, font sizes, etc.) and the JSON (JavaScript Object Notation ) files that make everything work. Editing the CSS or JSON is only necessary for very advanced customization, so you will not generally need to edit these files.

### 3.2 Upload your metadata

From the homepage of your repository on GitHub.com, click on the **_data** folder. This is where you will upload your metadata file. You will also notice several demo and template files in the framework for reference. While not necessary for your exhibit, we recommend not deleting them so you can reference them in the future.

To add your metadata file, click the **Add File button** at the top right corner and follow the prompts to upload your CSV file.

-

After you click the "Commit changes' button, your file is in the repository.

### 3.3 Configuration

Since your **_data folder** contains several metadata files, the next step is to tell the CollectionBuilder template which one to use for your exhibition.

{% include figure.html filename="en-or-digital-exhibition-collectionbuilder-02.png" alt="Visual description of figure image" caption="Figure 2. Caption text to display" %}

To do this, we will edit the **\_config.yml** file, which can be found on the main repository page. Once you have located the **\_config.yml** file

Under the heading \# COLLECTION SETTINGS, you will change the **metadata: demo-metadata** to the name of your metadata file you just uploaded. In our example, we changed it to **metadata: playbills-demo**

{% include figure.html filename="en-or-digital-exhibition-collectionbuilder-03.png" alt="Visual description of figure image" caption="Figure 3. Caption text to display" %}

### 3.4 Publish your site

While you could skip to the section to completely customize your exhibition before you publish your site live on the web, I find it's helpful to publish at this stage so you can see the changes you've already made and make sure the metadata and objects are working as expected.

To publish your site using GitHub Pages, you just need to edit a few settings. From your repository home page, click on the settings option at the top right.

{% include figure.html filename="en-or-digital-exhibition-collectionbuilder-04.png" alt="Visual description of figure image" caption="Figure 4. Caption text to display" %}

Select **Pages** from the left side menu:

- Under Source, leave the dropdown option as Deploy from a branch.

- Use the dropdown to change from "none" to "main" (leave the folder option as "/root").

- Click the **Save** button.

It will now take GitHub a few minutes to build your site using the contents of your repository for the first time.

{% include figure.html filename="en-or-digital-exhibition-collectionbuilder-05.png" alt="Visual description of figure image" caption="Figure 5. Caption text to display" %}

When your site is ready, refresh the page, and you will see the URL to your live site. The URL will follow the pattern: [https://username.github.io/repository-name](https://username.github.io/repository-name)

Click on the link, and \*\* VOILA\*\*, your digital exhibition, using *all the defaults* from the CollectionBuilder template, and your metadata are live.

#### Troubleshooting

Did you follow all the above steps, and don't see what you expect?

- A common issue is that your spreadsheet contains some UTF-8 Errors, which prevent the metadata from being displayed.

- Check your metadata sheet to see if your field names match exactly the ones in the metadata template. For example, objectID is not the same as objectid

- Have all of your commits or changes been processed? You can click on the clock with the number of commits and look to see if they have a green check mark next to them.

{% include figure.html filename="en-or-digital-exhibition-collectionbuilder-06.png" alt="Visual description of figure image" caption="Figure 6. Caption text to display" %}

## 4. Customizing your digital exhibition

Now that your digital exhibition is available online, let's customize it.

### 4.1 Home page

The first thing someone sees when they visit your site is the home page, and you have lots of options for inviting users to explore your exhibition.

The first change we will make is to add our logo and banner image and update the text in the description box.

Open the **_config.yml** file again.Under **SITE SETTINGS**, you can update your site's title, tagline, and description.

{% include figure.html filename="en-or-digital-exhibition-collectionbuilder-07.png" alt="Visual description of figure image" caption="Figure 7. Caption text to display" %}

Under **Site/Organization Branding** section, you can add as much organizational information as you want. Here I've added our library name and the URL to our library, but I have not include a logo,

Next, we can add an image to the home page banner. If your exhibition includes images, you can add the objectID of any image to feature it. This has the added advantage of automatically including a link to the featured image in your collection, like the [https://www.lib.uidaho.edu/digital/psychiana/](https://www.lib.uidaho.edu/digital/psychiana/) example.

Since our collection consists solely of PDF objects, I needed to create a collage of some covers. To use this file in your header, you need to first upload it to the **/assets/img** folder and then add that path to the **theme.yml** file in the **data** folder.

{% include figure.html filename="en-or-digital-exhibition-collectionbuilder-08.png" alt="Visual description of figure image" caption="Figure 8. Caption text to display" %}

You can also use an external URL if you want to host your banner somewhere outside the project.

#### Front page content boxes

Next, we can change the number and arrangement of default content boxes that appear on the home page.

In our example, we've used the location metadata field to indicate the physical location of the playbill, which helps library staff retrieve the items if requested. However, you do not necessarily need to be able to browse that on the front page.

To take a content box off the home page, we go to the **\_layouts** folder and open the **home-infographic.html** file.

First, we will locate the line of code that creates the box by searching for "location" and then deleting it. Since everything in my example exhibition is a PDF, I also deleted the 'Object box' since it didn't give the viewer any useful information to browse.

The next thing you can do is change the order of the boxes. In our example, I decided to move the subject box to the top and move the timeline down. The last thing I want to do is change the title of the Subject box to **Top Genre** to better reflect my metadata.

{% include figure.html filename="en-or-digital-exhibition-collectionbuilder-09.png" alt="Visual description of figure image" caption="Figure 9. Caption text to display" %}

### 4.2 Item page

Next, let's examine the default item page and make some changes, such as which metadata fields are shown, what the labels are, and whether we want them to link internally to other items or external links.

To make these changes, go to the**_data** folder and find the **config-metadata.csv** file. The top line is the table headers, which tell us what each column means. Each row below matches up to a metadata field, which is what we can customize.

For the playbills example, I wanted to make a number of changes because we want to introduce new metadata fields like playwright and theatre name and update the field names from the generic title to the more accurate Play Title.

I also wanted a number of the new fields like Theatre Name, Play Title and Playwright and for these fields to be browsable/clickable so people could explore the collection more easily. To do this I added **true** under **browse_link**. In our example, the metadata describes each play that is listed on the playbill, so there are sometimes mu, like Theatre Name, Play Title, and Playwright, to be browsable/clickable so people could explore the collection more easily. To do this, I added true under browse_link. In our example, the metadata describes each playltiple values in these fields. If you separate those values in the metadata sheet with a semicolon, CollectionBuilder will automatically show that they are separate links.

I also added a new URL field and included external_link = true so people could click on it to easily go to the item in the Internet Archive. The metadata field can either have text or an external link, not both. You'll notice in our edits that we left in the latitude and longitude fields, but since we don't have that in our metadata, they do not show up.

{% include figure.html filename="en-or-digital-exhibition-collectionbuilder-10.png" alt="Visual description of figure image" caption="Figure 10. Caption text to display" %}

For more ways that you can customize your exhibition, visit the CollectionBuilder documentation at [https://collectionbuilder.github.io/cb-docs/docs/customization/](https://collectionbuilder.github.io/cb-docs/docs/customization/)

### 4.3 Information or Interpretive pages

One of the great things about building your online exhibition is that you can add as many Information or Interpretive pages as you like to tell the narrative of your collection. These pages are written in Markdown and can include various liquid formatting blocks and images.

Included in the template is an **About page**, which is an excellent place to include more information about your exhibition and collection of objects, like:

- A brief description of why the exhibition exists. Who is responsible for curating the objects presented in the digital collection?

- A list of credits for the people who worked on the exhibition

- What/Who is the entity responsible for creating and maintaining the site?

- Who is funding the project?

#### Editing the About page

All informational pages are written in a Markdown script format with a simple Jekyll formatting system, configuring their display. To process them, all of these pages follow the YAML starter format that begins with three dashes ( \-\--) at the beginning and three at the end. The three elements needed to process the page are between these dashes: title, layout and permalink. This information will not be visible on the final page of your digital exhibition.

To edit this page, navigate to the **pages** folder and find the **about.md**. When you click on the pencil icon to edit, you will see that the file includes the YAML block explained above.

If you want to add a new pages, you can follow the instructions in the CollectionBuilder documentation:

- [https://collectionbuilder.github.io/cb-docs/docs/pages/add_page/](https://collectionbuilder.github.io/cb-docs/docs/pages/add_page/)

- [https://collectionbuilder.github.io/cb-docs/docs/pages/interpretive/](https://collectionbuilder.github.io/cb-docs/docs/pages/interpretive/)

### 4.4 Navigation

The last thing we will edit is the navigation bar. Similar in format to the item page fields, this is managed in the **config-nav.csv** file found in the **_data** folder.

For our example, I'm going to edit the **display_name** in our navigation bar from Subjects to Genre to match our metadata. I'm also going to remove the whole line for Locations since it's not a relevant field to browse by for our audience. I will also remove the link to the map since we do not have any items with longitude and latitude. By removing it from the navigation, I'm not deleting it from the template, so that if in the future, we enhance this collection with geographic information, we can show it on the map.

With those final edits, you have a fully customized exhibition site that is ready for the world to see. Congratulations!

## Advanced Customizations

### 4.5 Translating the interface

If you are working with a multilingual collection, you should translate the language of some or all of the default elements, like buttons, titles, etc., in CollectionBuilder. Some areas we've already edited (like the navigation bar), and others require some more digging into the code files. When we are in the HTML files, we look for words that are "outside" the semantic HTML formatting tags.

#### Home page

- Edit the 'Learn more' button in the Description box **_includes/index/description.html**

- Navigation menu -> **_data/config-nav.csv**

#### Item metadata page

- Metadata field labels -> **_data/config-metadata.csv**

#### Browse all page

Since this page is more complicated due to its functionality, we have to edit several files

- **pages/browse.md,** you can edit the page title "Browse Items"

- **layouts/browse.html** You can edit the filter option

- **_includes/jsbrowse-js.html** in this file you can change the text of the button that says "View Full Record" and edit the Item count, "# of # items". To do this you are looking for the line to replace the English preposition "of" and the noun "items"

```// add number*

*document.querySelector(\"#numberOf\").innerHTML =
filteredItems.length + \" of \" + items.length + \" items\";*
```

#### Map page

- **_includes/js/map-js.html** you can edit the button that says "View item" in the "pop-up" window that appears when we click on an object on the map

- **_data/config-map.csv** you can edit the names of the information that appears in the windows or "pop-ups" on each object on the map. You should leave the first column ( field) in English but you can change the second ( display_nameor display name) to your language.

#### Data page

In the **_data/config-table.csv** you can change the field names from the default data page.

In the **_includes/data-download-modal.html**, you can change the 'Download Data' button. Then, to edit the English options that appear when clicking on the data download button, you must Change the text inside the "card-title" and "card-text" that appear later in the code in the same file.

#### About page

If you are using the navigation bar inside the About page, you can change the word "contents" in **_includes/feature/nav-menu.html** of you can delete it.

#### Full metadata search page

In the **\_layouts/search.html** you can edit search button and the pop up box that explanis the search options

### 4.6 Adding Thumbnails when you have PDF files

If you are using PDF files like we did in our example, by default, you will not have any thumbnails when you browse. To add a thumbnail you will first need to edit your metadata CSV in your **_data folder** to include a link to a small thumbnail image.

The second step is configuring some layout files to tell the page: if a custom thumbnail image is available, use that instead of the default icon.

1.  Find the following file: [**_includes/js/browse-js.html.**]{.mark}

2.  Find the section that starts with:

*var items = \[*

Inside the curly braces { \... } for each item, add this line somewhere near the top:

```
*\"image_thumb\": {{ i.image_thumb \| jsonify }},*
```

For example, the block might look like this:

```
*{ \"title\":{{ i.title \| strip \| jsonify }},\
\"format\":{{ i.format \| jsonify }},\
\"image_thumb\": {{ i.image_thumb \| jsonify }},\
\...\
```

This adds the thumbnail value from your metadata into the JavaScript object so it can be used later.

3\. Update the makeCard() function to show the thumbnail:

In the same file, find the makeCard(obj) function. In that function, find this section:

*// thumb for non-photo items\
```
if(thumbSrc){\
card += \'\<p\>\<a href=\"\' + itemHref + \'\"\>\<img class=\"lazyload
w-50\" data-src=\"\' + thumbSrc + \'\" alt=\"Image of \' + obj.title +
\'\"\>\</a\>\</p\>\';\
}*
```

Replace that whole part with this:

```
*// show thumbnail if available\
if(obj.image_thumb) {\
card += \'\<p\>\<a href=\"\' + itemHref + \'\"\>\<img class=\"lazyload
w-50\" data-src=\"\' + obj.image_thumb + \'\" alt=\"Thumbnail of \' +
obj.title + \'\"\>\</a\>\</p\>\';\
} else if(thumbSrc){\
card += \'\<p\>\<a href=\"\' + itemHref + \'\"\>\<img class=\"lazyload
w-50\" data-src=\"\' + thumbSrc + \'\" alt=\"Icon of \' + obj.title +
\'\"\>\</a\>\</p\>\';\
}*
```

Inspired and want to do more? You can always [migrate your project from the GH template to the CSV template](https://collectionbuilder.github.io/cb-docs/docs/walkthroughs/transfer-walkthrough/), allowing even further customization.
