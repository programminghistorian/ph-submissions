---
title: "Transkribus Tutorial"
collection: lessons
date: "YYYY-MM-DD"
layout: lesson
authors: Rebecca McAlpine
reviewers:
editors:
- Giulia Taurino
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/477
difficulty: TBD
activity: [TBD]
topics: [TBD]
abstract: TBD
mathjax: TBD
avatar_alt: TBD
doi: TBD
slug: transkribus-tutorial
---

{% include toc.html %}

# Overview & Introduction

Transcription is a necessary component of most historical data processing. The practice of transcribing, and tagging documents for analysis can, however, be a tedious and very time-consuming component of any research project. [Transkribus](https://transkribus.eu/Transkribus/) transcription software intends to make the transcription process more accessible to individuals and large teams working in a variety of historical contexts, and on a variety of different texts. The software, which was developed through the EU-funded Recognition and Enrichment of Archival Documents (READ) project, aims to make accessible innovative technologies, specifically handwritten text recognition (HTR), to researchers of a variety of skill levels.

# 1
 The software can be downloaded for free trough the Transkribus website; however, due to a recent end of project funding HTR modelling is only accessible through paid credits. Transkribus offers a range of pricing options to support researchers are various career stages. Subscribers are offered 500 credits on sign up, which can be used to read 400 handwritten pages of text or 2,500 pages of typed text. Additional credits are [available for purchase online](https://readcoop.eu/transkribus/credits/) – 500 additional credits cost 66€ for non-members and 59€ for members. There are also scholarship options for students and educators. These options require a [short application](https://readcoop.eu/transkribus/scholarship/) submitted to Transkribus pending approval.

This tutorial will explore how to install and use Transkribus. While Transkribus offers a user guide, it does not address the textual variations in records (which impact the use of each tool), they are not centrally organized, and they do not always illustrate how these tools are used on an active record. As scholars begin to work with complex software to transcribe data, it is important to have a centralized, clear, and concise example that provides both an overview of how these tools function, but also to provide commentary and editorial support on the advantages or drawbacks of each component. It also is more multi-modal in its formation to support individuals who might require additional visual cues, as opposed to written instructions.

The tutorial will use [a sixteenth century consistory court case of gender-based violence](https://archivecat.lancashire.gov.uk/CalmView/Record.aspx?src=CalmView.Catalog&amp;id=ARR%2F2%2F4%2F4%2F66&amp;pos=1) as a running example. The text includes a non-standardized hand, both English and Latin text, and was imported to Transkribus from a black and white photocopy sent by the [Lancashire County Record Office](https://www.lancashire.gov.uk/libraries-and-archives/archives-and-record-office/) in England. The original text looks as follows:

! [Transkribus\_Picture1]

|
 |
| --- |

This tutorial is geared towards Mac users as that is what I use to operate the platform. However, the Transkribus interface looks the same whether on a Mac or PC.

## Installation

As outlined in the introduction, Transkribus is an open sourced software that can be downloaded from [transcribus.eu](https://transkribus.eu/Transkribus/).

To begin the installation process, first register an account with Transkribus. You can register either a pre-existing Google account, or register a unique account with another email address.

! [Transkribus\_Picture2]

Once you have successfully registered your account, select the download for either Mac or PC operating systems.

! [Transkribus\_Picture3]

A pop-up will prompt you to log into your Transkribus or Google account. Once the file finishes downloading, the program will appear in your downloads folder (it will not automatically open and install).

! [Transkribus\_Picture4]

! [Transkribus\_Picture5]

Once you have identified the application feature in Finder, right-click and select &quot; **open**&quot;. This forces your Mac to open the file. You will then be prompted whether you are sure you wish to open. Select &quot; **yes**&quot;

! [Transkribus\_Picture6]

As the software begins to open, Transkribus will ask permission to access your files. Select &quot; **yes**&quot;. This ensures that you are able to upload photographs saved to your computer.

! [Transkribus\_Picture7]

Transkribus will then open and you should see the following screen:

! [Transkribus\_Picture8]

Congratulations! You are now ready to begin importing and preparing documents for transcription!

## Opening &amp; Uploading a Files in Transkribus

To open files in Transkribus they must first be saved as individual JPEG&#39;s and housed within a folder. Users will upload the folder of JPEGs, _not_ individual documents. This way the document appears in Transkribus as a single record, versus a collection of individual pages.

There are two different methods for opening files in Transkribus.

The first **is local access.** Local access allows a researcher to view their document in the Transkribus software and make some colour modifications (e.g. gamma correction). It also allows for manual segmentation. While documents can be saved in this mode, it is unclear where exactly these changes are saved. This method seems best suited for short record entries that can be exported upon completion.

The second method is **server upload**. By uploading records to the Transkribus server you have access to a wider assortment of tools and features, including automated [segmentation](#_Segmentation) and [HTR model developme](#_Handwritten_Text_Recognition)nt.

This tutorial will highlight how to upload files to the Transkribus server; however, if you are interested in local access upload note that both processes take a very similar approach. I would recommend using server upload, as this provides greater flexibility by providing access to additional tools including segmentation and HTR modelling.

**To begin, open Transkribus on your computer.** Select &quot; **Document**&quot;. You will then be promoted with three options. Select &quot; **import local document**&quot; if you wish to work on your records locally. In our case, we will be selecting &quot; **import document to server…**&quot;

! [Transkribus\_Picture9]

Select &quot; **Upload Single Document**&quot; and browse your desktop for the _folder_ you wish to import. Remember, even though it refers to a &quot;single document&quot; this is referring to a folder (because a document may consist of dozens of pages, for example). Once you have picked the file you wish to upload, select &quot; **upload**&quot;

! [Transkribus\_Picture10]

Once uploaded, your file is ready for processing with the [Transkribus Tool Kit](#_Transkribus_Tool_Kit), which is an embedded tab within Transkribus.

# Transkribus Tool Kit

Transkribus has a variety of different tools and accessibility features to assist with the overall transcription process. Transkribus can assist with the overall visibility of records, the speed by which they are transcribed, as well as the development of metadata to ease the analysis process.

## Contrast and Accessibility

If we return briefly to the example document, we can see that this photograph is quite dark, and that there are areas in which we might want additional contrast. Especially in the early stages of transcribing a new hand, it can be very beneficial to change the overall colouring of documents to assist with the overall visibility of the text.

! [Transkribus\_Picture11]

To modify the colouring of your records, select the **black and white circle** in the upper right-hand corner.

! [Transkribus\_Picture12]

Two options will be presented: gamma correction and contrast.

! [Transkribus\_Picture13]

Personally, I prefer working with gamma correction, as it maintains some of the colouring of the records, while the contrast element uses black and white tones to create a greater contrast between the text and the paper. With your own documents you may need to take a different approach: there is no magic bullet, and often a combination of trial and error can suggest the best route forward.

With a gamma correction applied the document appears as follows:

! [Transkribus\_Picture13]

As you can see, gamma correction reduced the colouring of the paper to allow for a stronger emphasis on the text.

If for any reason a record is overcorrected or the correction does not increase the overall visibility, you can reset the colouring by selecting the **three image cluster icon** to the left of the contrast tool, and indicate you want to view the original image.

! [Transkribus\_Picture14]

You are also able to change the colours of other features, such as [segmentation](#_Segmentation), through the art palette feature.

! [Transkribus\_Picture15]

## Segmentation

Similar to traditional transcription styles, Transkribus has scholars transcribe lines of text. Once each line is completed hit the RETURN key on your keyboard and you will automatically be directed to the next line. While in more traditional circumstances scholars use a ruler or other tools to follow the line, Transkribus offers a segmentation feature which creates guides under each line of text to make this process significantly easier and more accessible. Segmentation essentially acts as a virtual ruler, it underlines each individual line of text (which corresponds to a number in the transcription box below), to support reading. It is also important if one were to employ an HTR model as it acts as the computer guide on where to start and stop reading. To transcribe a record in Transkribus, moreover, you must set up segmentation.

Segmentation can be set up either manually or automatically through the segmentation feature under &quot; **tools**&quot;.

To **MANUALLY** create a base line, select the &quot; **BL**&quot; button on the left-hand side of the document.

! [Transkribus\_Picture16]

Next, click the part of the document where you want your line to begin and drag the cursor under the text. You can create as many points along the line as you wish (this can come in handy if the line is slanted). Once you have finished underlining your text, hit ENTER on your keyboard. The line will now appear on the record. A completely segmented document will look as follows:

! [Transkribus\_Picture17]

To **automatically create segmentation** (document must be uploaded to the Transkribus server), go to the tools tab in the left-hand tool bar. The first option you will see is the segmentation tool.

! [Transkribus\_Picture18]

You have the option to either run the current page, or all pages in the collection. You can also have Transkribus find text regions, which refer to an area of the document that includes text that may not be within the main document. Once these variables are selected click &quot; **Run**&quot;.

Transkribus will now begin to process your document. Depending on the size of the record this could take anywhere from a few seconds to several minutes. Transkribus will notify you once the analysis is complete. Your record, once completed, will look like the example below:

! [Transkribus\_Picture19]

As you can see in the above the record, the lines correspond to numbers listed below. Traditionally when scholars would transcribe, they would organize their data based on lines. Transkribus builds on these protocols by automatically numbering each line in the text. This is where you will type in your transcription. When you select a line, it will highlight brighter in the document.

In some cases, however, Transkribus might read an imperfection or mark on the document as a line of text, or not completely underline the text. This is an easy fix that requires some manual intervention from the researcher.

**To delete a segment,** select a point in the line, which will subsequently turn blue. Once selected hit DELETE on you keyboard.

! [Transkribus\_Picture20]

You will then be promoted whether you also wish to delete the parent line. Select &quot; **Yes**&quot;. This will ensure that the corresponding number in the text box is deleted along with the line segment.

! [Transkribus\_Picture21]

**To modify a line** , you can either delete the segment and redraw it (instructions listed above), or you can select the final point in the line and drag it to where the line completes. While this is less of a concern if you choose to transcribe manually, if you plan to use an [HTR model](#_Handwritten_Text_Recognition) it is imperative to ensure that all text it segmented to guide the HTR software.

Now that you have a fully segmented document you are ready to begin transcribing!

## **Manually Transcribing the Document**

Even though handwritten text recognition (HTR) is one of the most valuable tools available within Transkribus, there are some situations in which manual transcription is necessary. For example, [Transkribus recommends](https://transkribus.eu/wiki/images/3/34/HowToTranscribe_Train_A_Model.pdf) to develop a clean dataset of approximately 5,000-15,000 words for the training of your HTR. This will entail manual transcription of these documents. There are also instances in which HTR is not the most viable option for scholars and they may choose to manually transcribe their entire dataset. For example, the records that I utilize for my research are legal depositions. These records can include multiple written hands over the course of my temporal parameters and can challenge finding a consistent dataset to train HTR. While HTR will be discussed in a later tutorial, for the purposes of this article we will discuss a few best practices for manual transcription in the Transkribus platform.

Like most manual transcription techniques, Transkribus works on a line method. Meaning that each line of text in the document corresponds to a line of transcribed text. This text can take up multiple lines once transcribed, and, as such, each corresponding line will be separated by a text break. In Transkribus, this feature is integrated into the software. As you will see below, the lines are automatically numbered in the transcription box the document. Once each line is complete, you simple hit &quot;return&#39; and the software will direct you to the next line of text.

! [Transkribus\_Picture22]

You will continue this process until you are satisfied with the completeness of the transcription of the record. Furthermore, as you work through this material, there are additional tools to construct metadata within the record, which will assist with the overall analysis of the completed transcription.

## **Metadata Creation**

The metadata creation feature of Transkribus is an excellent way to tag and modify documents to support analysis as you transcribe your records. The types of metadata available to the research are best employed during the transcribing process to mark specific criteria or trends within the record. This section will examine the four methods of metadata creation included on the Transkribus platform including: document, structural, textual, and comments.

### Document

This feature allows researchers to update basic information about their record including the title of the text, author, genre, writer (scribe), language, script type, publication date, as well as a description of its contents.

One feature of particular interest is the &quot;editorial declarations&quot; tab, which allows the author to make notes on lettering use and syntactical patterns within the record. For example, researchers can note whether a record uses a [&quot;U&quot; vs. &quot;V&quot;](https://en.wikipedia.org/wiki/Scribal_abbreviation#Scribal_sigla_in_modern_use) or whether abbreviations are included throughout or if they are expanded at certain locations in the text.

! [Transkribus\_Picture23]

### Structural

This allows for researchers to tag different regions of their records to indicate the overall record structure. These features might include paragraphs, marginalia, footnotes, etc. To tag a structural element, select the desired text region.

! [Transkribus\_Picture24]

Next, on the left-hand side of the screen select the desired structural tag by clicking the green &quot;+&quot; sign.

! [Transkribus\_Picture25]

### Textual

Textual metadata allows researchers to track and expand a variety of different variables within their text. These can later be [exported](#_Exporting_Data) for review. There are a variety of tags already developed including abbreviation, address, person, and organization. The abbreviations tag, for example, allows the researcher to transcribe the abbreviation as seen in the text, while writing the unabbreviated word in the left-hand tool bar.

! [Transkribus\_Picture26]

To add a tag, highlight the desired word or phrase in the text box. Next, select the green &quot;+&quot; button of the tag you wish to add. Finally add in any additional information in the properties box of the tag section on the left-hand side of the screen.

When tags are added successfully, the word or phrase will be underlined in the designated colour.

! [Transkribus\_Picture27]

To add tags to the tag bar or to create new tags, select &quot; **customize**&quot;. Choose which tag you wish to add to the tag specification bar. Once selected click &quot; **Add Tag Specification**&quot;

! [Transkribus\_Picture28]

To create a new tag, select &quot; **Create New**&quot;. Then create the desired label and click &quot; **okay**&quot;. All new labels must begin with an underscore &quot;\_&quot;.

! [Transkribus\_Picture29]

You can also choose to add single or multiple properties. In the case of my unique tag &quot;_inserted words_&quot;, I want a single property, which I will define in the &quot; **properties**&quot; heading on the left-hand side of the screen. Once I have added all the desired properties, select &quot; **add tag specification**&quot;.

! [Transkribus\_Picture30]

### Comments

The final metadata feature is comments. This allows for the integration of reactions or comments around a specific word or phrase within the text. To add a comment, highlight the text transcribed in the text box (in this case I am interested in the information included in lines 22 and 23).

! [Transkribus\_Picture31]

Next type your comment into the text box on the left-hand side of the screen. Once the comment is complete, select &quot; **add**&quot;. The comment will now appear in the lower box and indicate the lines to which it refers.

! [Transkribus\_Picture32]

## Exporting Data

There are several different ways to export data from Transkribus. These include the Transkribus document, PDF, TEI (Text Encoding Initiative), DOCX, TXT and various tag exports into Excel. The way in which you export data will largely be determined by the way in which you intend to utilize it. For example, if one were using a [Text Encoding Initiative](https://tei-c.org/) approach, Transkribus offers an extension through GitHub to assist with assigning the necessary zones to the document.

In my case, my data needs to be able run through a text analysis software and, as such, I will export my documents in DOCX, TXT, and PDF format, which I can export simultaneously.

To begin exporting your data select the export button in the top left-hand corner.

! [Transkribus\_Picture33]

You will then be prompted to examine which option(s) you would like to export. In this case, I am interested in exporting a PDF, DOCX, and TXT.

For a PDF I am interested in viewing the marked (tagged) image, as well as the typed transcription. To view these conditions, select the following criteria:

! [Transkribus\_Picture34]

When exported, your document will appear as follows:

! [Transkribus\_Picture35]

! [Transkribus\_Picture36]

For DOCX format (which will export to Microsoft Word), you can determine how you wish your tags and metadata to be exported. For example, in this case I indicated that I prefer my abbreviations to be expanded.

! [Transkribus\_Picture37]

This will export as follows:

! [Transkribus\_Picture38]

To export a TXT file, ensure that version is checked on the left-hand side of the export window.

! [Transkribus\_Picture39]

When you have selected all of the versions you wish to export select &quot; **OK**&quot;. Once your request has been processed by Transkribus you will receive an email to either your Transkribus or Google account with the link to the completed files.

As soon as you select the link, these documents will begin downloading. Once completed, your files will appear in the downloads folder.

! [Transkribus\_Picture40]

You can then open and save your files accordingly to your computer for further processing and analysis!

# HTR (Handwritten Text Recognition)

The handwritten text recognition (HTR) feature of Transkribus allows for scholars to train the software to automatically transcribe their documents with significant efficiency. In tests of this feature Seaward and Kallio (2017) found that the software can transcribe records with between a 90-95% accuracy. For the purposes of the data presented here, our success rate may not be as successful. Considering that the dataset in this module is based on highly differentiated early modern handwritten scripts, includes multiple authors and this spelling and grammatical constructions, as well as taking place over the course of a century, these are all factors that will contribute to the accuracy of the model. Nevertheless, the process of training an HTR is still highly beneficial to scholars working on these types of datasets; however, these factors must be noted to demonstrate that HTR modelling should be used in conjunction with other checks and balances throughout.

To begin an HTR Model, select the tools tab and under the _Text Recognition_ heading select _Train_.

! [Transkribus\_Picture41]

You will then be redirected to a list of your records. You can develop an HTR model for your entire library collection, or you can select a smaller library collection to train from. In this case, this model is based on my &quot;completed&quot; records.

To further support your training and to help boost your word count to the recommended 5,000 – 25,000, you can utilize a public base model. In this case, I will be selecting an English base model to support my HTR training.

! [Transkribus\_Picture42]

Next, you will select pages that will act as the training data and those that will be the validation data. You also have the option to select an automated option for validation data. You can select 2%, 5%, or 10% to automatically be used as validation.

! [Transkribus\_Picture43]

Once you have selected all these features, ensure to include a title and description of the model, and select train.

! [Transkribus\_Picture44]

The model will take time to process, you can check on its progress by select the coffee cup icon on the tools bar. As you can see in the example below, the HTR model reads pending. When it is completed, you will receive an email notification.

The validation data will then appear in the collection used to train the HTR model. In this case, the sample sized utilized for the transcription was far too small as illustrative in the example below.

! [Transkribus\_Picture45]

This is unsurprising given that there is significant variation between each record used in this tutorial. Based on the CER outputs, this model is still quite viable for use as anything 10% or below on a &quot;CER on Train Set&quot; is considered excellent by the software developers.

! [Transkribus\_Picture46]

As a result, we will test our model on one of the clearer documents in my collection to see how it holds up. In this case, our first step is to move the HTR model from my &quot;completed&quot; documents library to a location in which I am currently working. You can do this by right clicking on the HTR model, selecting &quot;share model&quot; and assigning it to a different collection.

You will begin by segmenting the pages of your record. Then, you will go to the &quot;Tools&quot; tab and select the &quot;Run&quot; button under the _Text Recognition_ subheading. Next, you will select the HTR model you wish to employ on this record. In this case, we are going to use the EME Test Model.

! [Transkribus\_Picture47]

As you can see from the example below, the HTR model did a good job at transcribing the record for this example. There are certainly mistakes; however, it is possible to deduce meaning from the source material and at a minimum provides a basis for a scholar or research assistant to go through and clean up the transcription.

! [Transkribus\_Picture48]

Based on the concerns listed above, it is impressive the correctness of the transcription presented above considering the variation in handwriting and spelling throughout the century. As a result, I would recommend the service to researchers, especially those working on early modern scripts. I do think that it would be beneficial to include a more varied and extensive dataset to train the HTR model. However, considering that this model represents the minimum word count, I am optimistic that as I am able to acquire more data that the model will become exceptionally beneficial to my research processing.

[1](#sdfootnote1anc) Louise Seaward and Maria Kallio, &quot;Transkribus: Handwritten Text Recognition Technology for Historical Documents,&quot; (_Digital Humanities_, 2017), 1.
