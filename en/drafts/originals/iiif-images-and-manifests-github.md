---
title: "Creating and Hosting Basic IIIF Images and Manifests Using GitHub"
slug: iiif-images-and-manifests-github
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Kiran Mohammadi-Williams
reviewers:
- Forename Surname
- Forename Surname
editors:
- Giulia Osti
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/659
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}


## Introduction

### Lesson Goals

This lesson demonstrates how to make high-quality, zoomable, shareable, interoperable images through the [International Image Interoperability Framework (IIIF)](https://en.wikipedia.org/wiki/International_Image_Interoperability_Framework). It provides three methods for creating basic IIIF-compliant images and creating and hosting IIIF manifests of images downloaded to your local device. In particular, you will learn:
- How to create Level-0 (basic) compliant IIIF images
- How to create a IIIF manifest to present Level-0 compliant IIIF images
- How to host IIIF manifests on GitHub

### Prerequisites

There are no fees for processing and hosting through any of these methods and all of the tools and applications used in these methods are open-source. However, in order to follow this lesson, you must have:
- An active [GitHub](https://github.com/) account
- Some familiarity with the [command line on your local computer](https://programminghistorian.org/en/lessons/intro-to-bash)
- Installed [Java](https://www.java.com/en/download/manual.jsp) v.23 or higher, [iiif-tiler](https://github.com/glenrobson/iiif-tiler/releases), [libvips](https://www.libvips.org/), [ImageMagick](https://imagemagick.org/index.php), and [Homebrew](https://brew.sh/) (if on MacOS)
- At least one image downloaded to your local computer, not copyrighted by someone else
- A strong Internet connection

Note that all screenshots in this lesson were taken on a MacBook, though these methods will work on any OS. Throughout this lesson, I will be using a downloaded photo of my cat as an example. If you're looking for an image for this lesson, you can use the [Creative Commons Search Portal](https://search.creativecommons.org/) to search for CC licensed images.

All of these methods rely on tools and workflows created by IIIF Technical Coordinator [Glen Robson](https://github.com/glenrobson). Methods get progressively harder and more intensive as you go through this lesson.

### What is IIIF?

The [International Image Interoperability Framework](https://iiif.io/) describes itself as “a set of open standards for delivering high-quality, attributed digital objects online at scale.” Effectively, IIIF standardizes the way images are delivered by servers to platforms, tools, and environments on the Web using a series of [Application Programming Interfaces (APIs)](https://en.wikipedia.org/wiki/API) that allow two different computers or pieces of software to communicate with one another. Because IIIF’s Image API specifies exactly how an image’s pixels will be served to a viewer or user, it’s easy to specify exactly how much and in what way you want the image to be displayed. For more on how IIIF works, see [IIIF’s How It Works](https://iiif.io/get-started/how-iiif-works/#:~:text=IIIF%20is%20a%20way%20to,but%20cannot%20do%20much%20else.) guide.

#### What is Level-0 compliance?

[Image servers](https://en.wikipedia.org/wiki/Image_server) can be compliant at different levels, with varying parameters needed to make them work with the IIIF Image API. In this guide, all of the images we produce will be Level-0 compliant, meaning that they have the minimum amount of information needed to make them work with version 2 or version 3 of the IIIF Image API. These images are also referred to as static images, since they are rendered from pre-loaded data and will not change unless you edit that underlying data before rendering them. For more on compliance, see the [IIIF’s Image API Compliance, Version 3.0.0 documentation](https://iiif.io/api/image/3.0/compliance/).

#### What is a IIIF manifest?

An [International Image Interoperability Framework manifest](https://iiif.io/guides/using_iiif_resources/) is a file that contains all of the information about an image or group of images served using IIIF, including the [metadata](https://en.wikipedia.org/wiki/Metadata), order of presentation, size specifications, etc. for a digital object. Creating manifests for your images means that you can specify metadata about that image that will display when the manifest is viewed in a IIIF-compatible viewer. There are also tools, digital exhibition platforms, and viewers that only accept manifests, not images, so knowing how to create compliant images *and* manifests is important for effectively leveraging IIIF.

Manifest editors are an easy way to visually put a manifest together, right in your browser. The two most popular manifest editors are [The Bodleian's IIIF Manifest Editor](https://digital.bodleian.ox.ac.uk/manifest-editor/) by the University of Oxford and the [Digirati IIIF Manifest Editor](https://manifest-editor.digirati.services/); both are free and web-based. This lesson uses the [Bodleian Manifest Editor](https://digital.bodleian.ox.ac.uk/manifest-editor/#/?_k=fsgx3h), since it offers less options and is therefore more straightforward to use. 

### Why use GitHub?

[GitHub](https://github.com/) is a web-based code storage, sharing, and version control platform based on the version control system Git. GitHub also offers free web-hosting through GitHub Pages, which allows you to create a GitHub-hosted webpage from your code. Using GitHub and GitHub Pages, you can conveniently store, host, and access your IIIF images and manifests in one place on the web.

Using GitHub also allows you to easily switch to alternative methods if your chosen method has deprecated or the software is no longer supported. For example, the [Internet Archive](https://archive.org/) is a popular tool for creating IIIF manifests, since they have a partnership with IIIF and images uploaded using their public upload feature are automatically IIIF compliant. In September 2024, however, the Internet Archive suspended its services for months [due to cyberattacks](https://www.forbes.com/sites/larsdaniel/2024/10/20/internet-archive-breached-again-third-cyber-attack-in-october-2024/). It became necessary to find an alternate method of rendering and serving IIIF manifests for free from personal photos and images found on the web, and most of these [open-source](https://en.wikipedia.org/wiki/Open_source) solutions are already on GitHub.

### Which method should I choose? 
Deciding which of these methods to use is dependent on:
1. Your comfort and skill level with navigating the command line and using [Command Line Interface (CLI)](https://en.wikipedia.org/wiki/Command-line_interface) tools
2. Your comfort and skill level with editing JSON files
3. The amount of images you have to process
4. Whether you have particular specification for how the images process

Method 1 may be best for those with limited experience using the command line interface or manipulating JSON files, since the tool it uses has a visual editor that allows you to upload, process, and retrieve images and manifests without any programming skills. Method 1 may also be good for those who do not have particular specifications in terms of quality or the number of image tiles produced, as the tool it uses does not allow for these specifications. 

Method 2 may be best for those with basic knowledge of the command line and with editing JSON files, but who may not have the knowledge to use arguments or to make significant changes to JSON files. Method 2 may also be good for those looking to batch edit many images at once. 

Method 3 may be best for those with moderate knowledge of the command line and who have experience editing JSON files. Method 3 may also be good for those who have particular specifications in mind for their images to meet, as the CLI tool used in this method allows for a series of arguments that can enable highly-controlled resulting images. 

Note that time is not included as a factor for consideration, as all of these methods entail significant processing time. 

The following tables illustrates the basic pros and cons of each method, with the four factors above in mind:

| Method 1                                                                                                                                             | Method 2                                                                                                                                                      | Method 3                                                                                                                                                               |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Pros:<br>- Visual editor/interface<br>- No programming or command line knowledge needed<br>- No experience with JSON files needed                    | Pros:<br>- Batch processing and editing (100s of images at once)<br>- Some control over how the images process and resulting image or manifest specifications | Pros:<br>- Batch processing and editing (100s of images at once)<br>- High level of control over how the images process and resulting image or manifest specifications |
| Cons:<br>- No batch processing or editing (must upload one-by-one)<br>- No control over processing or the resulting image or manifest specifications | Cons:<br>- No visual editor/interface<br>- Requires basic grasp of command line<br>- Requires knowledge of editing JSON files                                 | Cons:<br>- No visual editor/interface<br>- Requires **strong** grasp of command line<br>- Requires knowledge of editing JSON files                                         |
|                                                                                                                                                      |                                                                                                                                                               |                                                                                                                                                                        |

## Method 1: IIIF Workbench in GitHub.com

### Overview

Method 1 employs the use of IIIF Workbench, a tool created by IIIF Technical Coordinator [Glen Robson](https://github.com/glenrobson) that allows you to upload an image from your local computer that will then be stored as converted to IIIF tiles and stored in your own version of the IIIF Workbench GitHub repository. 

There are, however, caveats with this method that are worth mentioning before you get started.
1. IIIF Workbench is slow at breaking down images with the tiler, so it can take a while for images to upload. 
2. IIIF Workbench sometimes never generates tiles for an image—it just loads on "Generating tiles" forever. This is typically because an image has been resized incorrectly, is too big, or is not in an accepted file format.
3. IIIF Workbench does not work with organizational GitHub accounts because you can't log into organizational accounts.
4. Uploaded files must be under 100 MB. This excludes high-quality [TIFFs](https://en.wikipedia.org/wiki/TIFF), unless you resize the TIFFs significantly.

IIIF Workbench is overall a great tool, that prioritizes ease of use and features a clear and simple [Graphical User Interface (GUI)](https://en.wikipedia.org/wiki/Graphical_user_interface) to make uploading images easier, especially for those with limited knowledge of programming.

### Preparing your image files

#### Download your image(s)

The first step is to download your image to your local computer from any source. Often online repositories like Google Images won't offer you an option for what file format you want to download the image in, but some repositories, like online museum collections, will. If you have the option, download your image using the optimal file format available. For creating high-quality IIIF-compliant images, [Tagged Image File Format (TIFF)](https://en.wikipedia.org/wiki/JPEG) is best, [Joint Photographic Experts Group (JPEG)](https://en.wikipedia.org/wiki/JPEG) is second best, and [Portable Network Graphics (PNG)](https://en.wikipedia.org/wiki/PNG) are third best.  

If you have multiple images to download, it's best to place them all in the same folder on your computer so that you can easily keep track of which images you're working with.

#### Check your file sizes

Either during the download process or after you have downloaded your image to your local computer, you'll want to check the size of the image file.

**On Mac**
In Finder, go to your image file. Right-click (mouse) or two-finger click (trackpad) on the image. Click Get Info to open an info popup. In the popup, you should see the file size in bytes and KB or MB under General > File Size.

**On Windows**
In File Explorer, right-click on the image. Click Properties to open a metadata popup. In the popup, click on Details to a list of the image file's properties, including the file size.

**On Linux**
In the command line, navigate to the directory your image is in. Use the [identify](https://commandlinux.com/man-page/man1/identify.1.html) command to return details of the image. Note that JPEGs sometimes display file size in mebibytes (MiB) instead of megabytes (MB).

#### Resize your images

If your image file size is over 100 MB, you will have to resize it to upload it to IIIF Workbench. If not, you can skip this step.

**On Mac**
Open the image in Preview. In the Mac menu bar at the top of the screen, click File > Export. Select PNG, TIFF, or JPEG. Move the scroller so that the file size displayed is under 100 MB, but as close to lossless as possible.

**On Windows**
Open the image in Photos. Right-click the image and click Resize. Click the ellipsis (three vertical dots). Click Resize. Select one of the resize options or enter custom dimensions. Click Save.

**On Linux**
In the command line, navigate to the directory your image is in. Use the [convert](https://imagemagick.org/script/convert.php) command to convert or resize the image by quality or pixels.

### Using IIIF Workbench

#### Start a IIIF Workbench project

To access IIIF Workbench, login to your [GitHub](github.com) account in a web browser. You'll need to give the IIIF Workbench access to your account's public repositories in order to create a new repository with your processed image files.

Once you have logged in, you can access the [IIIF Workbench](https://workbench.gdmrdigital.com/login.xhtml) in a web browser at [https://workbench.gdmrdigital.com/](https://workbench.gdmrdigital.com/). You'll want to either select an existing project or create a new one. Each project is a separate repository in your GitHub account. The title you give a project in IIIF Workbench will be the title of that image file repository in your GitHub account.

#### Upload your images

Once you have created your project, you can open an upload popup and upload your images one by one. IIIF Workbench does not allow batch uploads, so you will have to select each image file individually.

You will be prompted to select an IIIF Image Version. Both IIIF 2.x and 3.x are compatible with static images, so the selection is based on your preference for the structure of manifests. You can review the full [version 3.x documentation](https://iiif.io/api/image/3.0/) to see what differences arise between the two.

Your image may take a while to process. IIIF Workbench must process the image file, generate [tiles](https://en.wikipedia.org/wiki/Tiled_rendering), upload to GitHub, and publish to the web. You can view which step the image is in at the bottom of the image box. While you wait, you can navigate to other pages, but do not close the Workbench tab.

When your image is done processing, you should see a small version of it appear in a box in IIIF Workbench. The image name will be under the photo, along with a link to an `info.json`. For all IIIF images and manifests, the `info.json` is a [JavaScript Object Notation (JSON)](https://en.wikipedia.org/wiki/JSON) file that contains the information that allows the IIIF APIs to process and serve the IIIF image to the web. The box for each image in IIIF Workbench will also display a hyperlink to the hosted image in your GitHub repository for the project. You can view all of your downloaded image files in your GitHub repository for the project as well.

### Creating manifests

IIIF Workbench does not create individual manifests for each image. Instead, it creates one manifest for all uploaded images. This works well if you would like to display all of your images as pages within a IIIF viewer. However, if you want to use just one image, you will have to create individual manifests for each of your images.

#### Find the identifiers for your image

IIIF manifests uses uniform identifiers to identify and access IIIF-compliant images and the display them using the IIIF Presentation API. There are two uniform identifiers that you can use to create your manifest: the info.json [Uniform Resource Identifier (URI)](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) and the image API Uniform Resource Identifier.

The `info.json` URI requests information about the image service, i.e. how the image is being served to the web. The image URI requests information about the image itself (dimensions, rotation, etc.) as processed by the IIIF Image API.

In IIIF Workbench, both of the identifiers are listed under the title of an image. To use the `info.json`, click on the `info.json` hyperlink under your image. Copy the URI in the search bar. This is your image's `info.json` URI. To use the image URI, click on the full image hyperlink under your image. Copy the URI in the search bar. This is your image's image API URI.

#### Use a manifest editor

To add your image to a manifest, open a manifest editor and create a new project. Add a canvas to your manifest. Select the canvas. Add an image to the canvas metadata using the `info.json` URI or image URI. The image should populate on the canvas.

Once you have added your image, it is best to add metadata to your canvas and manifest using the pre-populated fields. Metadata allows other viewers to understand what your image shows and what data it contains. When you are finished, save your manifest, give the file a unique title, and download it to your computer.

### Storing and hosting manifests in IIIF Workbench

All manifests must be hosted somewhere on the web for the IIIF Presentation API to access their content. Luckily, IIIF Workbench automatically uses GitHub pages to serve your project to the web. Now that you have your manifests, you can use IIIF Workbench to continue to host, store, and access them. 

In the top menu in IIIF Workbench, navigate to Manifests. Upload a manifest by selecting the manifest file from your local computer. The manifest will upload into your GitHub repository for the project. When completed, you'll see a list of your manifests in IIIF Workbench that can be edited, downloaded, deleted, or viewed in Mirador or Universal Viewer from the Workbench.

### Using your manifests

In order to make sure your manifests are displaying as expected, try testing them out in viewers outside of IIIF Workbench. To use your manifests, you'll need the manifest URI.

The manifest URI is the unique identifier for a manifest. In IIIF Workbench, you can access manifest URI by clicking on the IIIF logo next to your manifest and copying the URI in the search bar. The manifest URI will always end in **.json.** You can also see and download your manifest files in the corresponding folder in your project GitHub repository. 

Some options for IIIF viewers include: [Theseus](https://theseusviewer.org/), [Ramp](https://ramp.avalonmediasystem.org/), [Aviary](https://iiif.aviaryplatform.com/), and [Clover](https://samvera-labs.github.io/clover-iiif/). Simply paste the manifest URI into the viewer to test your manifest.

## Method 2: IIIF Tiler and GitHub.com

### Overview 

Method 2 using IIIF Tiler is slightly more hands-on than Method 1 with IIIF Workbench, but cuts out IIIF Workbench as the middleman and thus lets the user take more ownership of their processing and metadata creation. This method uses a Java-run iiif-tiler on your local computer, run through command line prompts, to process the images into Level-0 compliant images. We will then use GitHub to host those images and present them using the IIIF Presentation API through GitHub Pages.

The downside of this method is that there is no visual editor or public-facing GUI that can make uploading, organizing, and processing images easier. The upside of this method is that it allows for batch processing of Level-0 compliant images through the command line. Unlike IIIF Workbench, you can process as many images as you want at once, as long as they're all located in the same [directory](https://en.wikipedia.org/wiki/Directory_(computing)) on your local computer. You can also process larger files, though these may take longer.

### Preparing your image directory and files

Using the command line or your operating system's file management application (Finder, File Explorer, etc.), create a directory for your image files somewhere on your local computer. Since the tiler will operate within a specific directory, you need to be able to keep the tiler and all your desired images on a single, recognisable [file path](https://en.wikipedia.org/wiki/Path_(computing)). You can name your directory whatever you'd like, just make sure to edit the commands in succeeding steps of this lesson appropriately. This lesson will refer to the image file directory as `iiif-workshop`. 

Download your images to the `iiif-workshop` directory. As with Method 1, if you have the option, download your image(s) using the optimal file format available. For creating high-quality IIIF-compliant images, TIFFs are best, JPGs/JPEGs are second best, and PNGs are third best.

As you're downloading your image files, **make sure your image filenames are distinct.** You cannot have files with the same exact name and file extension in the same directory, and the tiler will not be able to distinguish between files without distinct titles. 

### Using IIIF Tiler

Using the tiler can be done in two ways: through the command line or through clicking. Either way, the [jar](https://en.wikipedia.org/wiki/JAR_(file_format)) file for the tiler must be in your` iiif-workshop` directory. Move the `iiif-tiler.jar` file into your `iiif-workshop` directory.

**Command Line**

Open the command line on your local computer and change directories to your `iiif-workshop` directory. Run the following command:
`java -jar iiif-tiler.jar`

<div class="alert alert-warning">
 You must have Java 23 or higher installed on your local computer before running this command!
</div>

**Clicking**

Open the `iiif-workshop` directory in your file management application (such as Finder or File Explorer). Double click on the `iiif-tiler.jar` file.

Regardless of what method you use to run the tiler, a folder titled `iiif` should appear in the `iiif-workshop` directory. This `iiif` folder will contain a folder for each of your tiled images. The individual image folders will in turn contain many folders that hold the various tile files that make up the IIIF image and an `info.json file` for each image. Each of the individual image folders thus makes up a a Level-0 compliant IIIF image.

### Create your image and manifest repository

Now that you have all of these image tiles, what do you do with them? To store, host, access, and share your images, you can create a basic GitHub repository.

Create a new repository on GitHub. Create an `images` folder. While in the `images` folder, upload all of the individual image folders (e.g image-1, image-2, etc.) in the `iiif` folder of the `iiif-workshop` directory on your computer. You may have to do this in batches due to GitHub's upload limits.

Create a `manifests` folder in the same repository. We will use this folder later to store and host our manifests.

In your repository, go to Settings > GitHub Pages. Set the Source to "Deploy from a branch" and the Branch to "main /(root)".

#### Clean up your image files

Because you are using your local computer, the IIIF Tiler will populate `info.json` files for your images with your [local server address](https://en.wikipedia.org/wiki/Localhost) as the reference. For your images to be properly displayed, they need to reference the server they are actually located on. This will be a GitHub server.

After all files have uploaded successfully to GitHub, open the `info.json` file for each image and update the `@id` field to: “https://`YOUR-GITHUB-USERNAME`.github.io/`YOUR-REPO-NAME`/images/`YOUR-IMAGE-NAME`”.

<div class="alert alert-warning">
Make sure you commit your changes as you go so that they save!
</div>

### Creating manifests

Now that your image files are hosted on GitHub, you can use the unique identifiers for each image to create IIIF manifests for them. 

#### Find the identifiers for your image

IIIF manifests rely on uniform identifiers to identify and access IIIF-compliant images on the web and the display them using the IIIF Presentation API. There are two uniform identifiers that you can use to create your manifest: the **info.json URI** and the **image URI**.

The `info.json` URI requests information about the image service, i.e. how the image is being served to the web. The image URI requests information about the image itself (dimensions, rotation, etc.) as processed by the IIIF Image API.

The `info.json` URI for your image will include the path to the `info.json` file for that image in your GitHub repository: "https\\:`YOUR GITHUB USERNAME`.github.io/`YOUR REPO NAME`/images/`YOUR IMAGE NAME`/`info.json`"

The image API URI for your image will include the path to the folder with the full resolution tiles of your image in your GitHub repository: "https:\\`YOUR GITHUB USERNAME`.github.io/`YOUR REPO NAME`/images/`YOUR IMAGE NAME`/full/full/default/0/`IMAGE FILE EXTENSION`".

#### Use a manifest editor

To add your image to a manifest, open a manifest editor and create a new project. Add a canvas to your manifest. Select the canvas. Add an image to the canvas metadata using the `info.json` URI or image URI. The image should populate on the canvas.

Once you have added your image, it is best to add metadata to your canvas and manifest using the pre-populated fields. Metadata allows other viewers to understand what your image shows and what data it contains. When you are finished, save the manifest, give your manifest file a unique title. and download it to your computer. Note that it is easiest to name your manifest file the same thing as your image title, so that you know at a glance which image the manifest displays. 

### Storing and hosting manifests on GitHub

Now that you have your manifests, you must also host them somewhere, just like your images. On GitHub, you can follow the same steps for hosting manifests as you did for uploading and hosting your images.

Open the `manifests` folder in your GitHub repository and upload all of your downloaded manifests. Open each manifest file to correct the `@id` in line 3 so that it reads: “https://`YOUR GITHUB USERNAME`.github.io/`YOUR REPO NAME`/manifests/`YOUR MANIFEST NAME`.json”. 

<div class="alert alert-warning">
Make sure you commit your changes as you go so that they save!
</div>

### Using your manifests

In order to make sure your manifests are displaying as expected, try testing them out in various viewers.

The manifest URI is the unique identifier for a manifest. You can find the manifest URI by opening a the .json file and copying the URI in the @id field. The manifest URI will always end in **.json.**

Some options for IIIF viewers include: [Theseus](https://theseusviewer.org/), [Ramp](https://ramp.avalonmediasystem.org/), [Aviary](https://iiif.aviaryplatform.com/), and [Clover](https://samvera-labs.github.io/clover-iiif/). Simply paste the manifest URI into the viewer to test your manifest.

## Method 3: libvips and GitHub.com

### Overview

Method 3 is very similar to Method 2, but uses libvips, an image-processing library, instead of IIIF Tiler to create Level 0 IIIF-compliant image tiles. It then uses GitHub to host those images and present them using the IIIF Presentation API through GitHub Pages.

libvips tiles images similarly to iiif-tiler, but gives you more control over the specifications for a single image, including tile overlap, tile size, depth, angle, and more. libvips creates [Deep Zoom (DZI)](https://en.wikipedia.org/wiki/Deep_Zoom) tile pyramids for your images, so that only the area of the image that is viewed in a particular zoom is loaded. For this reason, libvips tends to create more tiles for an image. The increased number of tiles can be difficult to upload, but the images tend to be of slightly better quality and more zoomable.

### Preparing your image directory and files

Using the command line or your operating system's file management application (Finder, File Explorer, etc.), create a directory for your image file somewhere on your local computer. You can name your directory whatever you'd like. This lesson will refer to the image file directory as `iiif-libvips. 

Download your image to the `iiif-libvips` directory. As with the other methods, if you have the option, download your image using the optimal file format available. For creating high-quality IIIF-compliant images, TIFFs are best, JPGs/JPEGs are second best, and PNGs are third best.

If you are downloading multiple image files, **make sure your image filenames are distinct.** You cannot have files with the same exact name and file extension in the same directory, and the tiler will not be able to distinguish between files without distinct titles. 

### Using libvips to tile an image

The libvips pyramid constructor operates entirely in the command line using a set of arguments that specify filename, format, properties, and more. For a full set of arguments available for the deep zoom pyramids command, see the [libvips documentation](https://www.libvips.org/API/current/Making-image-pyramids.html).

For this lesson, we will be using the deep zoom command and saving the tiled files in a IIIF-compatible layout within a folder.

Open the command line on your local computer and change directories to your iiif-libvips directory. Run the following command: `vips dzsave YOUR-IMAGE-NAME --layout iiif YOUR-PREFERRED-FILENAME.zip`. `vips` is the libvips command. The `dzsave` argument specifies the desired format for the image as a Deep Zoom file. The `--layout iiif` argument specifies the arrangement of the tile files in the folder that make up the composite image, which will be IIIF-compliant. The `zip` extension specifies that we want the files to all be packaged together into one neat, compressed file package for easy access.

Wait for the [ZIP](https://en.wikipedia.org/wiki/ZIP_(file_format)) file to appear in the iiif-libvips directory. When you open the ZIP file, you'll find folders containing the the various tile files that make up the IIIF image and an `info.json` file for each image. Each of the individual image folders thus makes up a a Level-0 compliant IIIF image.

Before continuing, be sure to open the ZIP file for each image so you can access the contents.

#### Batch tiling images
If you want to use libvips to tile multiple image files, you will need to use scripting language in the command line to identify all the files in a directory, batch them by name or file extension, and run the same command on all of them. In the bash command line, for example, you could run: `for filename in *.jpg; do vips dzsave $filename $(basename $filename .jpg)-pyr --layout iiif done`. Since this process is different on each operating system and can vary depending on scripting language, this lesson will not include step-by-step details for batch tiling with libvips. For Windows, see Steve Jansen's [Guide to Windows Batch Scripting](https://steve-jansen.github.io/guides/windows-batch-scripting/). For Mac and Linux, see [John Cupitt's bash solution on the libvips GitHub Issues](https://github.com/libvips/libvips/issues/1744).

### Create your image and manifest repository

Now that you have all of these image tiles, what do you do with them? To store, host, access, and share your images, you can create a basic GitHub repository.

Create a new repository on GitHub. Create an `images` folder. While in the `images` folder, upload all of the individual image folders (e.g image-1, image-2, etc.) in the `iiif-libvips` directory on your local computer. You may have to do this in batches due to GitHub's upload limits. You can delete the `vips-properties.xml` folder.

Create a `manifests` folder in the same repository. We will use this folder later to store and host our manifests.

In your repository, go to Settings > GitHub Pages. Set the Source to "Deploy from a branch" and the Branch to "main /(root)".

#### Clean up your image files

Because you are using your local computer, `libvips` will populate `info.json` files for your images with your local server address as the reference. For your images to be properly displayed, they need to reference the server they are actually located on. 

After all files have uploaded successfully to GitHub, open the `info.json` file for each image and update the `@id` field to: “https://`YOUR GITHUB USERNAME`.github.io/`YOUR REPO NAME`/images/`YOUR IMAGE NAME`/”.

<div class="alert alert-warning">
 Make sure you hit the green "commit" button to save your changes as you go!
</div>

### Creating manifests

Now that your image files are hosted on GitHub, you can use the unique identifiers for each image to create IIIF manifests for them. 

#### Find the identifiers for your image

IIIF manifests rely on uniform identifiers to identify and access IIIF-compliant images on the web and the display them using the IIIF Presentation API. There are two uniform identifiers that you can use to create your manifest: the info.json URI and the image API URI.

The `info.json` URI requests information about the image service, i.e. how the image is being served to the web. The image URI requests information about the image itself (dimensions, rotation, etc.) as processed by the IIIF Image API.

The info.json URI for your image will include the path to the info.json file for that image in your GitHub repository: “https://`YOUR GITHUB USERNAME`.github.io/`YOUR REPO NAME`/images/`YOUR IMAGE NAME`/info.json”. 

The image API URI for your image will include the path to the folder with the full resolution tiles of your image in your GitHub repository: “https://`YOUR GITHUB USERNAME`.github.io/`YOUR REPO NAME`/images/`YOUR IMAGE NAME`/`IMAGE FILE EXTENSION`”. 

#### Use a manifest editor

To add your image to a manifest, open a manifest editor and create a new project. Add a canvas to your manifest. Select the canvas. Add an image to the canvas metadata using the `info.json` URI or image URI. The image should populate on the canvas.

Once you have added your image, it is best to add metadata to your canvas and manifest using the pre-populated fields. Metadata allows other viewers to understand what your image shows and what data it contains. When you are finished, save your manifest, give the file a unique title, and download it to your local computer. Note that it is easiest to name your manifest file the same thing as the corresponding image file, so that you know at a glance which image the manifest displays. 

### Storing and hosting manifests on GitHub

Now that you have your manifests, you must also host them somewhere, just like your images. On GitHub, you can follow the same steps for hosting manifests as you did for uploading and hosting your images.

Open the `manifests` folder in your GitHub repository and upload all of your downloaded manifests. Open each manifest file to correct the `@id` in line 3 so that it reads: “https://`YOUR GITHUB USERNAME`.github.io/`YOUR REPO NAME`/manifests/`YOUR MANIFEST NAME`.json”. 

Make sure you commit your changes.

### Using your manifests

In order to make sure your manifests are displaying as expected, try testing them out in various viewers. To use your manifest, you will need the manifest URI.

The manifest URI is the unique identifier for a manifest. You can find the manifest URI by opening your manifest JSON file and copying the content in the `@id` field. This is the manifest URI. The manifest URI will always end in `.json`.

Some options for IIIF viewers include: [Theseus](https://theseusviewer.org/), [Ramp](https://ramp.avalonmediasystem.org/), [Aviary](https://iiif.aviaryplatform.com/), and [Clover](https://samvera-labs.github.io/clover-iiif/). Simply paste the manifest URI into the viewer to test your manifest.

### Conclusion
IIIF is a great framework for publishing, displaying, using, and sharing images with rich, deep zooming and high quality presentation. In this lesson, we learned how take a downloaded image file and turn it into a highly usable and reusable IIIF manifest, including:
- What IIIF, IIIF manifests, and level-0 IIIF compliance are
- How to choose a method for creating level-0 compliant IIIF images and manifests that aligns with your skills and priorities
- How to process images downloaded on your computer into IIIF-compliant, web-hosted images using the IIIF Workbench tool
- How to edit IIIF image files and manifest files using GitHub
- How to process images downloaded on your computer into IIIF-compatible tiles using the `iiif-tiler` and `libvips` command line tools
- How to locate, identify, access, and edit your image URIs and manifest URIs for your IIIF images and manifests
- How to host and access IIIF images and manifests using GitHub Pages
- How to use manifest editors and IIIF viewers to load, view, share, and zoom in on your IIIF images 

By the end of this lesson, you should have at least one IIIF image URI and one IIIF manifest URI that you can plug into different projects and viewers and share with others to present a high-quality, highly-zoomable version of your original downloaded image. Need inspiration for using your new manifest? Try creating an exhibit or digital narrative using [Exhibit.so](https://www.exhibit.so/) or [Storiiies](https://storiiies-editor.cogapp.com/).

### References and Resources
The methods within this lesson are just some of the easiest ways you can use various programs to create static tiles and Level-0 compliant images. Given the pervasiveness and usefulness of IIIF for serving and presenting images, there are plenty of Python, Ruby, and Javascript libraries and tools for generating tiles, as well as other guides and documentation. Here are some of the resources mentioned in this lesson:
#### Resources for Finding Images
- [Creative Commons Search Portal](https://search.creativecommons.org/)
- [Google Images](https://images.google.com/)
	- Make sure to use the license filter to ensure that you are selecting an image that is [usable under copyright law](https://support.google.com/websearch/answer/29508).
#### IIIF Manifest Editors
IIIF manifest editors are the easiest way to visually create and edit your IIIF manifests, no code needed. There are two main IIIF manifest editors:
- [The Bodleian's Manifest Editor](https://digital.bodleian.ox.ac.uk/manifest-editor/)
	- A simple manifest editor that allows for multiple images in one manifest and limited AV support.
- [Digirati Manifest Editor](https://manifest-editor.digirati.services/?tab=examples)
	- A more complex manifest editor that allows for advanced AV support and various media types.
#### IIIF Viewers
In order to look at your IIIF images, you will need a IIIF-compatible viewer. Though different IIIF viewers are compatible with different types of manifests, all viewers support the basic single-image manifests we created in this lesson. For more in-depth information about each viewer, see the [IIIF Viewer Matrix](https://iiif.io/api/cookbook/recipe/matrix/).
- [Theseus](https://theseusviewer.org/)
- [Ramp](https://ramp.avalonmediasystem.org/)
- [Aviary](https://iiif.aviaryplatform.com/)
- [Clover](https://samvera-labs.github.io/clover-iiif/)
- [Universal Viewer](https://universalviewer.io/)
- [Mirador](https://mirador-dev.netlify.app/__tests__/integration/mirador/)
- [OpenSeadragon](https://openseadragon.github.io/)
- [Tify](https://tify.rocks/)
- [IIIF Curation Viewer](https://codh.rois.ac.jp/icp/index.html.en)
- [List of viewers and descriptions from IIIF](https://iiif.io/get-started/iiif-viewers/)
#### Tool Documentation
- [IIIF Get Started guide](https://iiif.io/get-started/#end-users)
	- This guide is essential for understanding how IIIF works, what the different APIs do, and how image and manifest URIs are structured.
- [version 3.x documentation](https://iiif.io/api/image/3.0/)
	- This documentation reviews the changes in the Image API from version 2.x, and is helpful for deciding which version you'd like to structure your images for.
- [version 2.x documentation](https://iiif.io/api/image/2.0/)
	- This documentation reviews the specifications for version 2.x of the Image API, and is helpful for deciding which version you'd like to structure your images for.
- [libvips documentation](https://www.libvips.org/API/current/Making-image-pyramids.html)
	- This documentation includes all of the possible arguments and specifications you can use with the CLI tool libvips, allowing you to manipulate the processing of your image tiles to meet specific parameters.

 For more tools and resources, see the community-built [Awesome IIIF GitHub repository](https://github.com/IIIF/awesome-iiif?tab=readme-ov-file#image-servers).


