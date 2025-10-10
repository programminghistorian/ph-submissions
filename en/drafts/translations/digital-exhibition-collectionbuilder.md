---
title: "Building a Digital Exhibition with CollectionBuilder"
slug: digital-exhibition-collectionbuilder
original: exhibicion-con-collection-builder
layout: lesson
collection: lessons
date: YYYY-MM-DD
translation_date: YYYY-MM-DD
authors:
- Jennifer Isasi
reviewers:
- Juan Pablo Angarita Bernal
- Matías Butelman
editors:
- Maria José Afanador-Llach
- Isabelle Gribomont
translator:
- Natasha Nunn
- Sarah Severson
translation-reviewer:
- Forename Surname
- Forename Surname
translation-editor:
- Agustín Cosovschi
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/660
difficulty: 
activity: 
topics: 
abstract: En esta lección aprenderás a utilizar la versión ligera de CollectionBuilder para publicar una colección digital.
avatar_alt: Interior de una sala de museo antiguo.
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction to the lesson

This lesson will teach you how to use **CollectionBuilder** (CB) to create and customize a digital exhibition featuring digital objects hosted on another platform, such as the Internet Archive. You can follow along on the demo site at [https://github.com/sarahseverson/ph-demo-playbills](https://github.com/sarahseverson/ph-demo-playbills). This tutorial should take about 3 to 5 hours to complete if you have metadata ready. 

### Prerequisites

To do this lesson, you will need the following:

- Knowledge of how to write in Markdown ([Getting Started with Markdown](https://programminghistorian.org/en/lessons/getting-started-with-markdown) by Sarah Simpkin).

- Knowledge of how to manage a basic GitHub account repository ([An Introduction to Version Control Using GitHub Desktop](https://programminghistorian.org/en/lessons/retired/getting-started-with-github-desktop) by Daniel van Strien)

- Any curated set of online objects and their corresponding metadata in a CSV file.

## Background: What is CollectionBuilder & why would you choose it?


[CollectionBuilder](https://collectionbuilder.github.io/) is an open-source framework for publishing metadata-based digital exhibits based on static web page technology. Its main objective is to provide a simple model for disseminating collections in a practical and sustainable manner. It does not require advanced computer skills or infrastructure, but it allows for interactive elements, such as timelines and maps. CollectionBuilder is a project of the University of Idaho Library's [Digital Initiatives](https://www.lib.uidaho.edu/digital/) and the [Center for Digital Inquiry and Learning](https://cdil.lib.uidaho.edu/) (CDIL), following the [Lib-Static](https://lib-static.github.io/) methodology.

The CollectionBuilder framework is a viable alternative to digital exhibit publishing platforms, such as [Omeka](https://translate.google.com/website?sl=auto&tl=en&hl=en&client=webapp&u=https://es.wikipedia.org/wiki/Omeka) and the more complex [Wax](https://translate.google.com/website?sl=auto&tl=en&hl=en&client=webapp&u=https://minicomp.github.io/wax/) system. It is ideal for those who lack advanced computing resources or the time to learn how to use more complex systems. While our lesson focuses on using digital objects hosted on another platform, uploading small collections of items directly to GitHub is also possible and outlined in the CollectionBuilder documentation. 

CollectionBuilder is also an excellent pedagogical tool because it provides a hands-on entry point for students to learn interoperable digital humanities skills, such as metadata management, GitHub file management, Markdown, and basic web development. It also enhances general technical literacy by explaining how web publishing works, while prioritizing the values of openness, transparency, and sustainability outlined in the [Lib-Static](https://lib-static.github.io/) methodology.

CollectionBuilder offers three [different templates](https://collectionbuilder.github.io/templates.html):

1. **CB-SHEETS** allows you to update collections directly from a Google Sheet, making it ideal for prototyping, collaboration, and viewing changes in real-time.  
2. **CB-GH** requires that you upload your metadata spreadsheet to your repository and allows for more customizations, making it suitable for teaching and learning GitHub, Git, and other web workflows  
3. **CB-CVS** allows for the most customization, but you must [download software](https://collectionbuilder.github.io/cb-docs/docs/walkthroughs/csv-walkthrough/#2-download-and-install-software-on-your-computer-git-github-desktop-visual-studio-code-ruby-jekyll-imagemagic-and-ghostscript-video-version) to your computer. More advanced display templates will enable you to incorporate 360-degree panorama images, compound objects (such as a scrapbook or an archival folder), and multiples (like a postcard with both front and back, or text and its transcript).

This lesson will use the **CB-GH template**, which has fewer software dependencies and uses a collection of digital objects already online. In our example, we used items available in the Internet Archive, but you can link to items available elsewhere, including YouTube, Vimeo or any repository that gives you the digital object’s filename, including the file extension.  The CB-GH template can also be used for projects that have metadata-only records and no digital object. Projects can later be moved to the more advanced CollectionBuilder-CSV template for further customization by following [CollectionBuilder documentation](https://collectionbuilder.github.io/cb-docs/docs/walkthroughs/transfer-walkthrough/).

While other CB tutorials have you upload digital files directly to GitHub, this tutorial links to digital objects already hosted online. We made this decision to ensure you can:

* Work with larger, existing digital collections without needing extra server space or hosting tools  
* Practice metadata skills—linking, mapping, and referencing rather than uploading  
* Understand how digital ecosystems like the Internet Archive can be integrated into custom web publishing  
* Focus on curatorial interpretation and storytelling over technical file management

By using already-hosted objects, students can create meaningful exhibitions even if they don’t have digitized collections of their own, making this a more inclusive and scalable teaching option.


## 1. Design your online exhibitions: What story do you want to tell?

Online exhibitions can enhance access to digital objects by allowing curators, like yourselves, to add narrative context, offer interactive experiences, and enhance metadata. Before you choose which digital objects to feature in your exhibition, define your exhibition's goals, target audience, and desired experience. This will give you a good starting point for curating your content, choosing what metadata to include and determining which CollectionBuilder visualization elements to include.

Some questions to consider include: 

* **Who is the primary audience of the digital exhibition?** Being specific will help you shape both your design and your choice of digital objects. Are you making the exhibition to celebrate aspects of a larger collection? Is the digital exhibition in relation to a physical exhibition? Each of those would have unique audiences you’d want to consider.   
* **What do you want the audience to see and do when they come to the digital exhibition?**  Do you want your audience to read a series of essays in a set order, or do you want them to explore the collection on their own? If your collection has geographic or time-based metadata, do you want them to browse on a map or a timeline?  
* **What kind of digital objects do you want to highlight?** Outlining what types of material you wish to include will help you think about what kind of metadata you need to include and how you want to configure your item page. Books or other multi-page items you would like people to flip through and read? Or do you want to feature a single-page opening of a book? Or if you have photographs and postcards, do you want to show both the front and the back? If you do, you will want to read up on Compound Objects and Multiple item types in CollectionBuilder’s documentation, which we do not cover in this tutorial.

For further reading on this topic, the Art Libraries Society of North America's 2021 “[Best Practices for Library Exhibitions](https://www.arlisna.org/news/best-practices-for-library-exhibitions)” includes a section on Digital Exhibitions, and the Smithsonian's 2018 [Exhibits’ Guide to Exhibit Development](https://exhibits.si.edu/wp-content/uploads/2018/04/Guide-to-Exhibit-Development.pdf) can be applied to online experiences.

## 2. Prepare your metadata for your exhibition.

To prepare the exhibit, you first need a collection of objects described in a CSV that we can map to the CollectionBuilder metadata guide to ensure all exhibit components function properly.

### 2.1 Using Internet Archive Advanced Search to download metadata

If you are like us and have a collection of described digital objects already in the Internet Archive (IA), you can use their [Advanced Search](https://archive.org/advancedsearch.php) page to craft specific queries and export the existing metadata to a CSV file.

The first step is to use the Advanced search form to create a query that isolates the objects you want to download. You can also construct a query with keywords, Field-Specific searches and Boolean operators. Experiment with different queries until you get your desired results. Every time you do an advanced search with the form, IA converts your query into their desired query syntax, which you need in the second section, “**Advanced Search, returning JSON, XML, and more***”*. 

{% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-01.png" alt="Screenshot of the Internet Archive's advanced search interface showing relevant metadata highlighted and the CSV format chosen." caption="Figure 1. Screenshot of the Internet Archive's advanced search interface" %}

Now that you have a query, the second step is to download the desired metadata fields in a usable format. Select which metadata fields you want to include in your download from the list on the left-hand side. This list contains both the descriptive metadata as defined by the uploader and the administrative metadata from the IA platform. If you are not sure which fields you want, you can select all and then go through them later. For more information on what each metadata field contains, you can look at the [IA metadata schema](https://archive.org/developers/metadata-schema/index.html%20), but not all metadata in IA will follow this schema, so be cautious! 

Choose the number of results you want and CSV format. Once your file has been downloaded, ensure that the name of the file only contains lowercase letters, no spaces, and no special characters (e.g. ph-demo-playbills.csv). You may need to rename the file if this is not the case.

In our example exhibition, we are using a collection of [English playbills](https://archive.org/details/bpsc_playbills) from the Bruce Peel Special Collections at the University of Alberta Library, which was digitized in 2019 and is available on the Internet Archive. Because we want to use the entire collection of objects, we can get the playbills by utilizing the collection identifier **bpsc_playbills**, which is found in the URL.  When we do our test search, IA converts our search into their desired query syntax **collection:(bpsc_playbills).** For another example, if we only wanted to download the Hamlet playbills in this collection, we would use the query **title:(hamlet) AND collection:(bpsc_playbills).**

Once you’ve downloaded your metadata, you will want to clean it up to include only the necessary information for your exhibition. Some helpful tips on metadata can be found at the following links:

* Tips on formatting your metadata [https://collectionbuilder.github.io/cb-docs/docs/metadata/formatting/](https://collectionbuilder.github.io/cb-docs/docs/metadata/formatting/)  
* UTF-8 encoding error [https://collectionbuilder.github.io/cb-docs/docs/metadata/uploading/](https://collectionbuilder.github.io/cb-docs/docs/metadata/uploading/)

### 2.2 Mapping your metadata to the CollectionBuilder fields

To make sure your exhibition works properly, your metadata needs to follow the structure expected by CollectionBuilder. This means your CSV file must contain specific fields with correct formatting so the template can display items, maps, timelines, and other features.

Below, we explain only the fields required for this example project. You can explore the complete metadata guide anytime at: [CB-GH Metadata Template](https://collectionbuilder.github.io/cb-docs/docs/metadata/gh_metadata/).

#### CollectionBuilder Required-fields

* **objectid:** The objectid field is how CollectionBuilder identifies each item in your collection and connects it to its metadata. Requirements for **objectid**:  
    
  * Must be all lowercase  
  * No spaces or special characters (hyphens - and underscores _ are allowed)  
  * Should be unique for each item


  In our example, the Internet Archive identifier is already a suitable **objectid**. You simply need to rename the corresponding column header in your CSV file to objectid.


* **filename**: This field contains the direct URL to your digital object, such as a PDF, image, or audio file. For objects hosted on the Internet Archive, you can choose the display option that works best for your exhibition, which could be a specific page opening or full-screen theatre view.  In our example, we want visitors to see the full-screen flipbook version of each item, so we use URLs like [https://archive.org/details/BP_CCTT_0002/mode/thumb?view=theater](https://archive.org/details/BP_CCTT_0002/mode/thumb?view=theater). TIP: Every Internet Archive URL uses the identifier, so it’s easy to construct whichever one you want to feature.   
    
* **title**: This should correspond to a title that the original object carries. It is recommended that it be short and descriptive. In our example, some playbills have more than one play, so we have separated the play titles with a semicolon. Ex: Othello; The Deserter  
    
* **format**: This field indicates the item’s media type. Since CollectionBuilder uses logic based on format to display objects, this is a key field for ensuring the interactive visualizations and item pages function correctly. If there are errors or anomalies, some pages will not work. For normal items, the value of this field should match the standard [MIME type](https://www.iana.org/assignments/media-types/media-types.xhtml) corresponding to your item’s file, consisting of a type and a subtype concatenated with a slash (/) between them. This can generally be inferred by looking at the file extension (e.g. “.jpg”, “.pdf”, etc). The common MIME type “format” values supported by CB-GH are:  
    
  * Image: image/jpeg, image/png  
  * Document: application/pdf (like our example of the playbills)  
  * Audio: audio/mp3  
  * Video: video/mp4

#### Metadata Fields used for Visualizations

CollectionBuilder features automatic creation of views or entry points to the collection, using the information provided in the metadata file. These will generate interactive views to explore the collection on different pages. Each “extra” page needs a different type of information, which is explained below:

* **date**: This field typically refers to the date of creation or publication of an object and is used for sorting and displaying on the timeline. The format to follow is YYYY-MM-DD, with the four digits of the year being the minimum value needed to form the timeline. If you have date information that does not fit into this ISO format, like [?-02-24] or [date unknown] or 1900s, you can add a new metadata field under a different name so that this information is displayed with the items, but not included in the timeline visualization.   
* **map**: To create a map, you need the metadata fields in the columns latitude (north-south information) and longitude (east-west information), that is, the coordinate data of a location corresponding to the object you present in the exhibition. Our playbills collection does not have geographical metadata like latitudes and longitudes, so we have done some research into *possible* locations of the listed theatres and added them to our demo to give you an idea of how the map works.   
* **subjects**: Create a word cloud with the topics that each object deals with in the subject column. You can put multiple topics in each box (for each object) and separate them with a semicolon ( ;). In our example, each playbill has been given genres like comic drama; comedy; extravaganza, which follow the order of appearance on the playbill.

#### Optional fields

CollectionBuilder templates can support as many descriptive metadata fields as you want, following the interests of the digital collection's creators and audience.

Some common additions include:

* **creator**: Name of the person who created the original object that has been digitized, or in our case, the name of the playwright  
* **description**: A brief note about the object  
* **source**: Designates the source of the object, such as its location in the physical collection   
* **language**: You can indicate the language associated with the object. CollectionBuilder recommended best practice is to use a controlled vocabulary such as [http://www.loc.gov/standards/iso639-2/php/code_list.php](http://www.loc.gov/standards/iso639-2/php/code_list.php).  
* **rights**: A free text statement containing information about the audience's rights over digital objects. Complements the standardized right statement.   
* **rights statement:** Link to a standardized interoperable rights statement from [https://rightsstatements.org/en/](https://rightsstatements.org/en/)

## 3. Setting up CollectionBuilder

Before you can set up your digital exhibition, you'll need a [GitHub account](https://docs.github.com/en/get-started/start-your-journey/creating-an-account-on-github) for your archive, library, museum, or personal use. These accounts are free and can be used for various purposes. Once you have an account and are logged in, you can proceed with the lesson. [More information on working with](https://collectionbuilder.github.io/cb-docs/docs/repository/gitworkflow/) GitHub.

### 3.1 Clone the repository

To set up CollectionBuilder for your exhibition, you first need to copy the template you want to use, which in our case is [collectionbuilder-gh](https://github.com/CollectionBuilder/collectionbuilder-gh). 

In the top right-hand corner, you will see a “Use this template” button. If you don’t see this button, make sure you are signed into your GitHub account.

{% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-02.png" alt="Screenshot of the CollectionBuilder GitHub repository with the Use this Template button circled in yellow." caption="Figure 2. Screenshot of the CollectionBuilder GitHub repository with the Use this Template button highlighted" %}

When you click on the “Use this template” button, you will have two options. Choose “Create a new repository.” This will let you copy all of the template files, with all the framework repository defaults, to your GitHub account so you can start building your exhibition. 

In the “Create a new repository” screen, you must name your new repository. The name will be in your URL and needs to be unique. You can also make it public or private. We recommend keeping your repository public so you can share your work and get help if needed.

When you click on that button, you will have two options. You want to "Create a new repository." This will let you copy all of the template files to your account so you can start building your exhibition. This will give you all the framework repository defaults to get you started.

In the "Create a new repository" screen, you must name your new repository. The name will be in your URL and needs to be unique. You can also make it public or private. We encourage people to keep their repositories public to share their work with friends and get help if needed.

#### Repository contents

Now that you have cloned the template for your exhibition, let’s take a closer look at each folder and its role in your site.

* **_data**: Contains three types of files that help form the “skeleton” of the display. The demo and template comma-separated values (CSV) files are examples for various digital object types and can be left alone as references. We will later be adding your metadata file to this folder. Several configuration files let you edit the vocabulary for browsing objects (config-browse.csv), viewing the map (config-map.csv), metadata (config-metadata.csv), general navigation or menu (config-nav.csv), search (config-search.csv), and a table (config-table.csv). Lastly, there is the YML type file (human-readable data serialization format) for configuring the page theme, which you do not have to worry about.  
* **_includes and _layouts**: These folders contain the HTML files that make up many of the features of the CollectionBuilder tool. In this lesson, we will be doing all of our customization without touching these files.  
* **_sass and assets**: This is where you'll find the SCSS (Syntactically Awesome Style Sheets) files that provide the visual side of the web page (colours, font sizes, etc.) and the JSON (JavaScript Object Notation) files that make everything work. Editing the CSS or JSON is only necessary for very advanced customization, so you will not generally need to edit these files.

### 3.2 Upload your metadata

From the homepage of your repository on GitHub, click on the **_data** folder. This is where you will upload your metadata file. You will also notice several demo and template files in the framework for reference. While not necessary for your exhibit, we recommend not deleting them so you can reference them in the future.

To add your metadata file, click the **Add File button** at the top right corner and follow the prompts to upload your CSV file.

After you click the "Commit changes' button, your file is in the repository.

### 3.3 Configuration

Since your **_data** folder contains several metadata files, the next step is to tell the CollectionBuilder template which one to use for your exhibition.

To do this, we will edit the **_config.yml** file:

Under the heading # COLLECTION SETTINGS change line 37 **metadata: demo-metadata** to the name of your metadata file you just uploaded. In our example, we changed it to **metadata: playbills-demo**

{% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-03.png" alt="Screenshot of the relevant section of the config.yml file showing where to point CollectionBuilder to your metadata file." caption="Figure 3. Screenshot of the relevant section of the `config.yml` file showing where to point CollectionBuilder to your metadata file." %}

### 3.4 Publish your site

While you could skip to the section to completely customize your exhibition before you publish your site live on the web, it can be helpful to publish at this stage so you can see the changes you’ve already made and make sure the metadata and objects are working as expected.

To publish your site using GitHub Pages, you just need to edit a few settings. From your repository home page, click on the settings option at the top right.

{% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-04.png" alt="Screenshot of GitHub demo repository page with a yellow circle around the Settings button." caption="Figure 4. Screenshot of GitHub demo repository page with a yellow circle around the Settings button." %}

Select **Pages** from the left side menu:

* Under Source, leave the “Source” dropdown option as “Deploy from a branch”.  
* Use the “Branch” dropdown to change from “none” to “main” (leave the folder option as “/root”).   
* Click the **Save** button.

It will now take GitHub a few minutes to build your site using the contents of your repository for the first time.

{% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-05.png" alt="Screenshot of the GitHub message you will get while GitHub is building your site." caption="Figure 5. Screenshot of the GitHub message you will get while GitHub is building your site." %}

When your site is ready, refresh the page, and you will see the URL to your live site. The URL will follow the pattern: [https://username.github.io/repository-name](https://username.github.io/repository-name)

{% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-06.png" alt="Screenshot of the message you will receive when your site is live." caption="Figure 6. Screenshot of the message you will receive when your site is live." %}

Click on the link, and ** VOILA**, your digital exhibition, using *the defaults* from the CollectionBuilder template, and your metadata are live.


#### Troubleshooting

Did you follow all the above steps, and don’t see what you expect?

* [A common issue](https://collectionbuilder.github.io/cb-docs/docs/metadata/uploading/) is that your spreadsheet contains some UTF-8 Errors, which prevent the metadata from being displayed.  
* Check your metadata sheet to see if your field names match exactly the ones in the metadata template. For example, objectID is not the same as objectid  
* Have all of your commits or changes been processed? You can click on the clock with the number of commits and check if they have a green check mark next to them.


{% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-07.png" alt="Screenshot of GitHub demo repository page with a yellow circle around the Commits link, which you can use to check the status of your commits." caption="Figure 7. Screenshot of GitHub demo repository page with a yellow circle around the Commits link, which you can use to check the status of your commits." %}


## 4. Customizing your digital exhibition

Now that your digital exhibition is available online, let's customize it.

### 4.1 Home page

The first thing someone sees when they visit your site is the home page, and there are several ways you can customize it to encourage readers to explore your exhibition.

The first change we will make is to add our logo, banner image, and update the text in the description box.

Open the **_config.yml** file again. Under **# SITE SETTINGS**, update your site's title, tagline, and description.

{% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-08.png" alt="Screenshot of the relevant text to update your site's title, tagline, and description in the config.yml file." caption="Figure 8. Screenshot of the relevant text to update your site's title, tagline, and description in the `config.yml` file." %}

Under ** Site/Organization Branding** section, you can add as much organizational information as you want. In this screenshot, you can see our library name and URL: 


 {% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-09.png" alt="Screenshot of the relevant text in the config.yml file for updating your organizational information." caption="Figure 9. Screenshot of the relevant text in the `config.yml` file for updating your organizational information." %}
 
Next, add a banner or a featured image to the home page by editing the **theme.yml** in the **_data** folder. If your exhibition includes images, you can add the **objectID** of any image to feature it. This has the added advantage of automatically including a link to the featured image in your collection, as seen in the [https://www.lib.uidaho.edu/digital/psychiana/](https://www.lib.uidaho.edu/digital/psychiana/) example.

Since our collection consists solely of PDF objects, we created a collage of some covers for the banner. To use this file in your header, you need to first upload it to the **/assets/img** folder and then add that path to the **theme.yml** file in the **_data** folder.

{% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-10.png" alt="Screenshot of the relevant text in the theme.yml file for configuring the display of the banner image if you are not using an object from your collection." caption="Figure 10. Screenshot of the relevant text in the theme.yml file for configuring the display of the banner image if you are not using an object from your collection." %}

You can also use an external URL if you want to host your banner somewhere outside the project.

#### Front page content boxes

Next, we can change the number and arrangement of content boxes that appear on the home page by editing the **home-infographic.html** file in the **_layouts** folder. 

In our example, we’ve used the location metadata field to indicate the physical location of the playbill, which helps library staff retrieve the items if requested. However, you do not necessarily need to be able to browse that on the front page.

To delete that box, first, locate the line of code between the `and` that uses **field="location"** and delete the entire line of code on line 19. We also want to delete the “objects” box line of code on line 21 since everything in our example exhibition is a PDF, so it didn’t give the viewer any useful information to browse.

The next thing you can do is change the order of the boxes. In our example, we moved the subject box to the top and pushed the timeline down. We also changed the title of the Subject box to **Top Genre** to better reflect the metadata.

{% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-11.png" alt="Screenshot of home-infographic.html code showing the changes to the box order and the title of the subject box." caption="Figure 11. Screenshot of home-infographic.html code showing the changes to the box order and the title of the subject box." %}

### 4.2 Item page

Next, let’s examine the default item page where your viewer will see your digital object and the corresponding metadata. There are a number of changes that can be made to the default page including which metadata fields are shown, in what order, what the labels are, and whether we want them to inter-link to other items on your site or include external links.

To make changes, go to the **_data** folder and open the **config-metadata.csv** file. The top line (1) is the table header, which tells us what each column means. Field references the metadata field name in your metadata CSV file, and display_name is what is shown on your item page.  The browse_link and external_link columns are where you can turn on hyperlinking of fields or make a field link to an external website after each row below matches up to a metadata field that is displayed on your item page.  

{% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-12.png" alt="Screenshot of the config-metadata.csv file with the updates specified in the lesson" caption="Figure 12. Screenshot of the `config-metadata.csv` file with the updates specified in the lesson" %}

{% include figure.html filename="en-tr-digital-exhibition-collectionbuilder-13.png" alt="Screenshot of the metadata section of the demo exhibit." caption="Figure 13. Screenshot of the metadata section of the demo exhibit to show the same changes from the `config-metadata.csv` file" %}

For the playbills example, you can add some new metadata terms to the item page that were specific to these materials, like Playwright and Theatre Name and change the display_name of the title field to the more descriptive, Play Title. 

To make those new fields browsable/clickable to encourage people to explore more playbills, for example, a specific Playwright or plays that are shown in one particular theatre. To do this, add the value **true**. 

TIP: In our example, some playbills advertise multiple plays with multiple playwrights. To ensure that those show up as separate values your visitor can browse, make sure they are separated in your metadata CSV with a semicolon. Then CollectionBuilder will automatically show that they are separate links.

Lastly, we added the full URL of the item for easier access. Add a new line near the bottom (line 11) and add the value **true** under external_link. This makes the ENTIRE field a hyperlink, so if you include text and a URL, it won’t work. The metadata field can either have text or an external link, not both. 

### 4.3 Configure search and browse experience
Related to metadata configuration is the search and browse configuration. If you add a new metadata field to your item page, you will also need to add it to the config-search.csv file in the _data folder to make it searchable. The second step to make the browse_link work will be to add the two fields to the config-browse.csv in the same _data folder.  

Depending on your site goals and audience, you might want to add further customization. To learn about what more you can do, visit the CollectionBuilder documentation at [https://collectionbuilder.github.io/cb-docs/docs/customization/](https://collectionbuilder.github.io/cb-docs/docs/customization/) and play around 

### 4.3 Information or Interpretive pages

One of the great things about building your online exhibition is that you can add as many information or interpretive pages as you like to tell the narrative of your collection. These pages are written in Markdown and can include various liquid formatting blocks and images.

Included in the template is an **About page**, which is an excellent place to include more information about your exhibition and collection of objects, like:

* A brief description of why the exhibition exists.  
* Who is responsible for curating the objects presented in the digital collection?  
* A list of credits for the people who worked on the exhibition  
* What/Who is responsible for creating and maintaining the site?  
* Who is funding the project?

#### Editing the About page

All informational pages are written in a Markdown script format with a simple Jekyll formatting system, configuring their display. To process them, all of these pages follow the YAML starter format that begins with three dashes ( ---) at the beginning and three at the end. The three elements needed to process the page are between these dashes: title, layout and permalink. This information will not be visible on the final page of your digital exhibition.

To edit the About page, navigate to the **pages** folder and find the **about.md** file. When you click on the pencil icon to edit, you will see that the file includes the YAML block explained above.

If you want to add a new page, you can follow the instructions in the CollectionBuilder documentation:

* [https://collectionbuilder.github.io/cb-docs/docs/pages/add_page/](https://collectionbuilder.github.io/cb-docs/docs/pages/add_page/)  
* [https://collectionbuilder.github.io/cb-docs/docs/pages/interpretive/](https://collectionbuilder.github.io/cb-docs/docs/pages/interpretive/)
### 4.4 Navigation

The last thing we will edit is the navigation bar. Similar in format to the item page fields, this is managed in the **config-nav.csv** file found in the **_data** folder. 

In our example, you could edit the **display_name** in our navigation bar from Subjects to Genres to match our metadata. You could also remove any navigation items that you are not using.   

With those final edits, you have a fully customized exhibition site that is ready for the world to see. Congratulations!

## Bonus Customization: Adding Thumbnails when you have PDF files

If you are comfortable experimenting with code and HTML, here’s an example of an advanced customization option that goes beyond the prerequisites for this tutorial.  

If you are using PDF files, as we did in our example, by default, you will not have thumbnails when browsing. To add a thumbnail, the first step is to add the URL to the image to your metadata CSV, [see our example](https://github.com/sarahseverson/ph-demo-playbills/blob/main/_data/ph-demo-playbills.csv), in your **_data folder** in a new column named **image_thumb**. 

The second step is to configure some layout files to instruct the page: if a custom thumbnail image is available, use it instead of the default icon.

1. Find the following file: **_includes/js/browse-js.html.**  
2. Find the section that starts with:

*var items = [*

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

# Conclusion 
Congratulations! You have built a digital exhibition using CollectionBuilder-GH. 

Whether your project is a one-time exhibition or part of a broader digital collection strategy, CollectionBuilder offers a flexible, open-source, minimal computing platform that scales with your needs and skills. And because it's built with static web technologies and uses interoperable standards, your exhibition is built to last.

This is just the beginning. You can continue to refine your site, experiment with new features, or even [migrate your project from the GH template to the more advanced CSV template](https://collectionbuilder.github.io/cb-docs/docs/walkthroughs/transfer-walkthrough/). The CollectionBuilder documentation is always there to guide you, and the community is very helpful—don’t hesitate to reach out, share your project, or fork someone else's for inspiration.
