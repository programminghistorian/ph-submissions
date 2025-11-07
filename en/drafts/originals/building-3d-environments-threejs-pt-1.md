---
title: "Building Interactive Environments for 3D Models with three.js (Part 1)"
slug: building-3d-environments-threejs-pt-1
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Kristine Hardy
- Mathieu Leclerc
reviewers:
- Jessica C. Linker
- Steffen Bauer
editors:
- Massimiliano Carloni
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/607
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

This guide shows how to use the [three.js](https://threejs.org) JavaScript library to create a website with 3D models to illustrate the diversity of the pottery technologies of communities in the Papua New Guinea area. Part 1 is a beginner level guide to creating a website featuring a 3D model. In Part 2, a more complicated website is created, where selecting a vessel model reveals information on the community and their ceramics. Part 2 also shows how the website can be the basis for a matching puzzle where the vessel is matched to the community that manufactured it. In the puzzle version selecting a site shows the information about the pottery and if the vessel is dragged onto the correct torus the background colour of the scene will change.

Advances in computing continue to increase our ability to display models in websites, create virtual museums and make heritage information more accessible. This lesson aims to facilitate the production of engaging digital research outputs by introducing [three.js](https://threejs.org) as a tool to present virtual 3D models. Web models and digital games can help the dissemination of archaeological information. As opposed to simply writing texts about artefacts, supplying communities with more accurate examples of the archaeological past can be considered a goal of archaeologists (Holtorf, 2005). The use of interactive 3D models in websites enables examples of archaeological and historical material culture to be presented more effectively. 3D models are generally more engaging than 2D images, largely because the extra dimension encourages user interaction. The act of moving around a model, and choosing which areas to visually examine, and find out more information on, creates a more personalised experience and contributes to the user forming a relationship with the model. This relationship can be increased if the model can be manipulated or is part of a puzzle. Puzzles increase the amount of time spent with a model and can induce users to notice details they may have otherwise overlooked. The sense of achievement obtained with solving a puzzle can also strengthen a positive relationship with a model and its subject. 

Virtual (or printed reproduction) cultural heritage models have the advantage that they can be inspected without the risk of damaging an archaeological artefact. They can be inspected at a different scale from the original, thus houses, sites or villages can be minimised to understand how different areas relate to each other, while small artefacts, such as coins, can be magnified so that small details can be more easily seen. In this case, vessels can be minimised so that many can be compared, and they can be placed on a geographical map, with placement linking them more strongly to their creators than a simple label. Ideally, the use of models would help reduce the removal of, and facilitate the return of, the original artefacts from the communities that created them or their descendants.
 
Cross community comparisons of different aspects of material culture, such as pottery, can reveal shared community histories. These aspects include both appearance (form and decoration) and methods of production. Measuring the level of similarity of cultural features across communities is sometimes termed 'cultural evolution' (O'Brien et al. 2008). However, the spread of ideas and local innovations generally occur at a faster rate in material culture than with genetics or linguistics and the transmission of pottery production is argued to have occurred, at least partially, independently of population movement in Europe (Dolbunova et al. 2023). Comparing different pottery styles can help us identify shared heritages, community contacts and local innovations. Visualising the pottery forms and their geographic distribution helps illustrate this, especially when additional information, such as the language family, of the community is considered. The extensive ethnographical work of researchers, such as May and Tuckson (2000) and Pétrequin and Pétrequin (2006), has been essential for such comparisons.

## Lesson Goals

This two-part lesson is designed as a very brief introduction to the three.js JavaScript library, and involves a considerable amount of copy and pasting code. Part 1 introduces 3D models and some of the ethical issues associated with their generation and use. Users will explore some of a model’s components and work with a 3D co-ordinate system using the three.js web-based editor. Part 1 also shows how to set up and locally serve a basic webpage featuring a 3D model in a scene with lights and mouse controls, using three.js.

The primary goal of part 2 is to use three.js to create a webpage featuring a 3D scene with selectable components. Scene creation will involve adding lights, cameras, primitive models (such as spheres and planes), complex models (the pot forms), and controls. The models will get materials and/or image textures. Concepts such as model groups, scale and visibility, and 3D co-ordinates will be introduced. An additional goal of part 2 is to change the webpage into a game by making the models moveable and initally positioned at random places, with the user then required to match the vessel to its maker community. A test in the code is run after each time a model is moved, to see if it has been placed in the correct position. Successful matches trigger a background colour change.

## Papua New Guinea Pottery

While not ubiquitous throughout Papua New Guinea and West Papua, many communities have a history of making ceramic vessels for use in cooking, storage or ceremonial purposes. Pottery was first introduced to the Papua region over 3000 years ago (Gaffney et al. 2015) and the many different techniques, forms and decorations found are probably the result of a combination of local innovations and influences from different external sources.

In trying to understand this cultural transmission, researchers compare factors such as decoration, form and building technique among the different communities. This lesson includes information and a pot model for 29 communities. In part 2, where the vessels are added separately, step-by-step instructions are given for 6 models (from Bilibil, Muilu, Misima-Paneati, Adzera, Dimiri and Iatmul speakers), with the assets and information for another 23 provided for users to practice with. The 29 models show examples of paddle and anvil-made and spiral-built vessels. In the south east, woman potting communities (including Mailu and Misima-Paneati speakers) utilise different variations of techniques incorporating finishing with clay rings and generally geometric incised or applique decoration. In many inland communities, men and women potters (including Adzera, Dimiri and Iatmul speakers) use spiral (or ring) building with decorations that can include sculptural elements and carvings. In coastal communities (including the Bilibil), women make paddle and anvil-made vessels that are generally rounder, less decorated and often used for water storage. 

## Ethics

While virtual models have the ability to increase accessibility to cultural heritage, there are important ethical considerations that should be addressed when creating such resources. These apply at the level of model creation and website design. It is important to reference the source of images and models used in a page. Here this will be done on an information panel in the website. The use of cultural heritage models, especially from communities that have been exploited and have had objects taken without consent, needs to be carefully considered. There are laws and guidelines that back up these ethical concerns in many cases; such laws differ from country to country. Ideally, informed consent from the maker community, or their descendants, should be obtained for modelling of cultural objects. In some countries intellectual property legislation may require evidence that at least several attempts have been made to obtain permission. While 'utilitarian' items are generally considered exempt from copyright, some ceramics have ceremonial purposes and in some areas decoration can be based on hereditary 'trademarks'. Objects (particularly human remains or funerary artefacts) can also have different values and associations for different people and cultures as highlighted by recent (2024) legislation in the USA on the display of certain Native American objects (including burial pottery). 

Interactive web models provide a way to effectively communicate academic research to a broader community, ultimately community involvement and control should occur at an earlier stage of the study, but as in other fields technological advances have occurred that could not be foreseen by data/artefact collectors, and ideas around what constitutes 'informed consent' have also advanced. Including information, such as [Traditional Knowledge (TK) Labels](https://localcontexts.org/labels/traditional-knowledge-labels/) in model metadata is one way cultural information can be connected to a model. How different communities feel about their cultural objects being modelled and represented on websites is an area that would benefit from further research. The available guidelines and protocols are generally more targeted at institutions, but it is worth considering [Basic principle and tips for 3D digitisation of cultural heritage](https://digital-strategy.ec.europa.eu/en/library/basic-principles-and-tips-3d-digitisation-cultural-heritage) and [Protocols for using First Nations cultural and intellectual property in the arts](https://creative.gov.au/first-nations-arts/protocols-for-using-first-nations-cultural-and-intellectual-property-in-the-arts).

The degree to which **models** of cultural artefacts are covered by copyright, and who that copyright belongs to (the creators of the original artefacts, the current 'owners' or caretakers of the artefacts, or the creators of the model), depends on several factors, and is not always clearcut (Oruç, 2020; D'Andrea et al. 2022). Many researchers aim to make their models and site code available for others to use to increase the dissemination of information and promote further research and often models/code are given [Creative Commons licences](https://creativecommons.org/share-your-work/cclicenses/) such as CC-BY-NC (Creative Commons Attribution-NonCommercial). However, it is always worth considering that your models may be used in scenes you disagree with or find offensive, i.e. the pot models could be used in a potentially culturally derogatory manner (illustrating cannibalism). While you can request users to only use the models and code for non-derogatory purposes, models and code are increasingly being scraped by Artificial Intelligence (AI) 'bots' thus potentially contributing to models used in scenarios you did not forsee. The use of the "NoAI" HTML meta tag may help discourage this. 

It is also important to reflect on whether scenes or puzzles are contributing to a colonial approach. For example in a game, a better aim could be to have artefacts being returned to their place or community of origin, than to have the user steal or 'collect' them. In the puzzle in part 2, the pots are matched back to their community as represented as a place on the map.

## Models

All models are made from meshes of nodes (points) joined with edges (connecting lines) to give faces (also called polygons) (Figures 1 and 2). These polygons are usually triangles (with 3 vertices) or quadrilaterals (with 4 vertices). Basic shapes such as spheres, cubes, planes and tori ('donuts') are known as 'primitive' models and can be created directly in three.js. Some people like to build more complicated models by combining primitive models in three.js, but often these more complicated models are created with Computer Aided Design (CAD) software such as [Blender](https://www.blender.org) or with scanning processes such as photogrammetry, and imported into three.js as 'complex' models. 

Meshes can be decorated with ‘materials’ that have colour and other properties such as emission, roughness, metalness, opacity etc. They can also be decorated with images or other ‘textures’. Textures are two dimensional image files with U (horizontal) coordinates from 0 to 1, and V (vertical) coordinates from 0 to 1 (Figures 1 and 2). Each vertex in a model's mesh is also assigned U and V coordinates (in a process called 'unwrapping') that corespond to those in the texture. In texture mapping, each polygon in the mesh gets the pixels of the texture image that match the polygon defined by the UV coordinates. Thus image textures can be used as colour maps with the different pixel colours being mapped onto the model to put the image on the model (Figure 1). If you inspect the colour map, mesh and model in Figure 1 you should be able to see where parts, such as the tan head spot and the collar in the map are being matched to the mesh. 

Textures with grayscale (from white to black) pixels intensities can also be used to convey other information, including opacity (alpha maps), roughness, shadow effects (occlusion maps) and face direction (normal maps) (Figure 1). Many 3D modellers will create 'normal maps' for their models to simulate fine shape details when reducing the number of faces and three.js can use normal maps, but in part 2 we will only use colour map textures. We will also only texture planes and this means the 2D textures can map more simply onto the plane surface instead of the more complicated mapping in the dog model (Figure 3). If you are interested in UV mapping, you can use the 'Model Inspector' in the bottom right corner of many models in [SketchFab](https://sketchfab.com/), including [Diva dog](https://skfb.ly/pzB7J) and the [Papua jars](https://skfb.ly/putNM), and in the 3D + 2D view you can see where the U, V co-ordinates correspond on the model and the map (Figure 3).

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-01.png" alt="A mesh, the model and 4 maps for a white staffy dog on a red couch with 3 blankets. The 2 dimensional maps include colour, normal, occulusion and roughness." caption="Figure 1. The mesh and maps (textures) for a model of Diva dog. Diva's tan head patch  and collar can be located in the colour map. [See the model in SketchFab](https://skfb.ly/pzB7J). Model created from a quick [Polycam](https://poly.cam) scan." %}

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-02.png" alt="Flow charts for photogrammetry and CAD model making. Photogrammetry requires multiple photographs, which are used to create a point cloud, then a mesh which is wrapped in a texture to make a model, such as a sherd. A jar CAD model can be made by tracing the vessel outline and rotating it." caption="Figure 2. Models can be created by methods that include photogrammetry and Computer Aided Design (CAD). [See the sherd model in SketchFab](https://skfb.ly/pzEEW)." %}

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-03.png" alt="The dog and jars models in the model inspector in SketchFab." caption="Figure 3. The Model Inspector in SketchFab for the Diva dog and Papua Jars models." %}

In photogrammetry, models are computed from series of overlapping photographs of an object at various angles (Rahaman, 2021). Photogrammetric models, including those from phone apps such as [Polycam](https://poly.cam), will typically have image textures and be realistic (left side, Figure 2). Models made using Blender or other CAD software may be symbolic or made more realistic with the addition of image textures or complex materials (right side, Figure 2). There are many different model formats, and some, such as [STL](https://en.wikipedia.org/wiki/STL_(file_format)), will only store the mesh. The [GL Transmission Format (glTF) or GL Transmission Format Binary (glb)](https://en.wikipedia.org/wiki/GlTF) file format is one of the formats that can store meshes, textures, materials, animations and other properties. glTF/glb files can also be compressed further with DRACO compression; Blender will export DRACO compressed glTF/glb files. There are some memory penalties in loading DRACO compressed files.

glTF/glb can also store several models in a file. If you are creating a scene with several models for a website, you can choose to import each of the different models into a scene in software such as Blender (or the [three.js editor](https://threejs.org/editor/)), position, scale and colour/texture each of them, and export the resulting composite model as one glb file, such as the png_sceneDRACO.glb file we will use in part 1. Alternatively, you can import the models individually and arrange and alter them via the website code, such as we will do in part 2. There is also the option of separating out the individual models from the composite model in the code, but that will not be used in this lesson.

The models used in this project were created with CAD by the authors (who are not of Pacific Islander heritage) and are intended to be symbolic rather than realistic. While simplification of some of the designs results in the brilliance of some of the potteries being under-represented, it aids in avoiding impingement on the moral rights of the original communities. The individual vessel models used in this project were originally created by us as part of an exercise to learn CAD for 3D printing (Shaw, 2023). The models were created using Blender or [Fusion 360](https://www.autodesk.com/au/products/fusion-360/) by tracing or estimating the vessel profile (from sources cited in one of the information panels added to the website 3D model), rotating the profile 360 degrees around the vertical axis, and then (if necessary) using the sculpting tools to add the decorations (right side Figure 2). As they were designed to be printed 5-10 cm tall, decoration was simplified, and was added in a way to be reflective of the different decoration types such as comb incision, impression, exposed coil and applique, favoured by the different communities. Many communities produced more than one type of pot, and forms for the original printed collection were originally chosen to illustrate the variety of vessels in Papua.

For use with a website, Blender was used to reduce the model polygon count and the individual vessel models (used in part 2) were exported as DRACO compressed glTF files. The composite model (used in part 1) was created in Blender, with the addition of the map (added via the [‘import image as planes’ extension](https://docs.blender.org/manual/en/3.3/addons/import_export/images_as_planes.html)). 

For this project it was considered that symbolic models of non-ceremonial objects was more acceptable than the use of realistic (photogrammetry) models, whose use would require the permission of the different communities. Symbolic models were also used as they could convey the method of the original vessel construction with a colour and the use of a key. The method of construction is not only important for understanding the connections between the technologies, but for the puzzle, the colours also act as the primary clues for the website user to match vessels to their communities. These models have a [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) licence which means they can be used and modified by others but not for commercial use. The CC BY-NC-SA licence also means that if they are used, reference should be made to the authors. 

## Alternatives to three.js for Creating Websites Featuring Models

Websites can be made relatively easily using the three.js JavaScript library. While this tutorial uses three.js, many of the concepts are also relevant to game engines and 3D modelling software.

There are several alternatives for creators to make websites that include 3D models. Many cultural heritage models are hosted on SketchFab (Maschner, 2022), which allows for (limited) interactive annotations, where informative text appears when users click on certain areas of the model (Figure 4). Models such as the [Papua jars](https://skfb.ly/putNM) or [Diva dog](https://skfb.ly/pzB7J) can be linked to or embedded in sites. [Smithsonian Voyager](https://smithsonian.github.io/dpo-voyager/), [3DHOP](https://3dhop.net/demo.php), [Kompakkt](https://kompakkt.de/home) also allow for models to be embedded in webpages and for greater model annotation. These approaches are useful for publishing high quality models that can help engage viewers with paragraphs or snippets of information, often presented in a sequence as the viewer navigates through the model. Researchers and students can also often utilise these models by using measurement tools. 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-04.png" alt="The jar models in SketchFab and several stylistic models of jars from Papua, 5 with numbers. Informative text is shown for the jar numbered 5." caption="Figure 4. The Papua Jar models in SketchFab with 5 annotations." %}

For more complex webpages, such as those with multiple models which the user can manipulate independently from each other, or which require a test to see if models been placed correctly relative to another, then JavaScript libraries, such as three.js and [Babylon.js](https://www.babylonjs.com), or game engines such as [Godot](https://godotengine.org), [Unity](https://unity.com) and [Unreal Engine](https://www.unrealengine.com), are necessary. Some game engines have no-code approaches that might appeal to some users. Three.js was chosen for this project due to the large number of three.js easily modifiable [tutorial examples](https://threejs.org/examples/) and ease of converting the site for viewing in [virtual reality](https://threejs.org/manual/#en/how-to-create-vr-content). Three.js, by itself, is not a physics engine, so it can not generally simulate object interactions, such as detecting object collisions. It can be used with physics engine libraries, such as [Ammo.js](https://github.com/kripken/ammo.js), [Cannon.js](https://github.com/schteppe/cannon.js) or [Rapier.js](https://rapier.rs), as shown in some of these [three.js physics examples](https://threejs.org/examples/?q=physics). The Babylon.js library has greater support for physical interactions and so may be a better alternative for some sites.  

## Exploring Models with the three.js Editor

Before starting to code we can explore a model in the [three.js editor](https://threejs.org/editor/). Download the composite model png_sceneDRACO.glb from the [`/assets` folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/building-3d-environments-threejs-pt-1-2). Open the [three.js editor](https://threejs.org/editor/) in a new browser window (right click on the link) and import the model with File > Import (Figure 5). 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-05.png" alt="Web editor showing a dark rectangular prism with small jars on it." caption="Figure 5. The three.js editor with the composite model imported." %}

Change the view from SOLID to WIREFRAME using the drop down menu at the top right of the model view window and zoom in and move around with your mouse. You can also expand the model (click on the + png_sceneDRACO.glb, then the subsequent + ) in the scene window (on the right) and if you double click on a jar name (try the aibom_LOC) it should centre it. You should be able to see that the jars are made of polygons (Figure 6). The less nodes or faces in the mesh, the smaller the model size. Large model files will not load or will be slow to respond in websites. Reducing the nodes or faces in a model, or retopology, can be done in programs such as Blender. In Blender this is relatively easy, if the model is imported in STL format and if the model does not have an image texture. The individual jar models (used in part 2) were designed and retopologised in Blender to under 700KB. Reducing the number of faces can reduce the details in a model.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-06.png" alt="Web editor showing the wireframes of jar meshes." caption="Figure 6. The three.js editor in wireframe view zoomed in on a jar mesh." %}

You may have models that you have made from photogrammetry, or downloaded from sites such as [SketchFab](https://sketchfab.com/), that have image textures. These are easier to retopolise in commercial software such as [Agisoft’s Metashape](https://www.agisoft.com), but it is also possible to use Blender or the free photogrammetry software [Meshroom](https://meshroom-manual.readthedocs.io/en/latest/index.html). You can test your models by importing them into the three.js editor or, if they are glTF files, [Don McCurdy's glTF viewer](https://gltf-viewer.donmccurdy.com).

When inspecting models you may need to add lights as some materials do not work without them. Change WIREFRAME back to SOLID. In the editor add a hemisphere light from the Add > Light > Hemisphere menu. If you select the hemisphere light in the Scene tab, you can change the colour to white and the ground colour to black (Figure 7), which results in white light originating from the sky and changing colour to black as it nears the ground. You can use the editor to test different lights and light options.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-07.png" alt="Web editor showing jar models in different colours." caption="Figure 7. The jars under a hemisphere light." %}

If you zoom out you can see the map. The jars are coloured because they have materials but the map was made of a plane with an added image texture (Figure 8).

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-08.png" alt="Web editor showing that the rectangle the jars are on has a map of Papua New Guinea." caption="Figure 8. The Papua New Guinea map and its image texture (called a map in the Materials tab)." %}

While in the editor, it is useful to look at the red, green and blue arrows in the centre of the scene, which illustrate the co-ordinate system. In three.js, positions are set in x, y and z order. Different graphics programs and game engines use different co-ordinate systems. In three.js x is left (-) and right (+), y is down (-) and up (+) and z is far (-) and near (+) (Figure 9), i.e. it is a Y up, right-handed system. If you select a jar and look in the Object tab, you will see the x, y and z positions it was placed at (Figure 10), and you can change them and see the jar move. You can also change the scale or rotation of a jar and test what happens.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-09.png" alt="Web editor with three arrows, coloured red, green and blue, showing the x, y and z axis." caption="Figure 9. The three.js co-ordinate system. Red arrow shows positive x direction, green arrow shows positive y direction, blue arrow shows positive z direction." %}

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-10.png" alt="Web editor showing a round jar (manus001), with its x, y and z positions visible in the geometry window." caption="Figure 10. The position of the jar made by one of the communities on Manus Island." %}

## Software Requirements and Installation

- Text editor (Visual Studio Code (VSC) recommended).

VSC contains a text editor and can be downloaded from [https://visualstudio.microsoft.com](https://visualstudio.microsoft.com), it is free and runs on Windows, macOS, and Linux. It also features a terminal. Install as per website instructions. Many extensions are available for VSC and the code colouring can help detect issues such as unclosed tags or quotes. You can turn off error reporting in the settings or use the telemetry free [VSCodium](https://vscodium.com). 

- Terminal (ie Windows PowerShell, or the terminal in macOS or Linux), or the terminal in VSC. The terminal in VSC can be obtained from Terminal > New Terminal. 

Some simple command line typing will be required. Most importantly, you need to be able to move to the folder that your website file will be in. If you use the VSC terminal, this should be automatic.

- Web browser. Chrome, Safari, Edge etc.

Chrome generally has the better developer tools for code debugging. If your browser can display the [three.js site](https://threejs.org) and the various sample projects on the home page, it should work; some Safari versions have problems. It is useful to know how to view the browser log console. In Chrome, this can be done through View > Developer > JavaScript Console. These console error messages can help identify why a site is not loading properly. You may have to use a search engine (such as Google) to understand the error message and you may have to reload a site while the console is open to see the error message. For more information on debugging code see the [three.js manual](https://threejs.org/manual/#en/debugging-javascript).

- [Node.js](https://nodejs.org) 

Node.js is a free JavaScript tool and is easy to install (Windows, macOS, and Linux). This will allow you to ‘serve’ code internally to your browser (using an address in the browser such as http://localhost:3000), and see if the code is working, or how code changes affect your site. Node.js is probably the easiest way to serve code internally. Install as per website instructions, and check it is working in the terminal you plan to use by typing 

```
node -v
```

and confirming that you get a version number and not an error message. This code has been tested with version v18.14.1. If you have problems installing Node.js, try using a search engine with the error message for help or watch one of the many tutorials available on the web.

- A GitHub page (recommended if deploying). 

To deploy your page so that everybody can access it, you can use [GitHub Pages](https://pages.github.com). You get one free page per GitHub account, ie my page at https://github.com/tosca-har/tosca-har.github.io results in a website at https://tosca-har.github.io/. Alternatively, you can deploy your site using a free service such as [Vercel](https://vercel.com/). To deploy code, follow the instructions on [GitHub Pages](https://pages.github.com) or [Vercel](https://vercel.com/).

- The three.js library.

There are 2 ways to use the three.js JavaScript library. This tutorial will use the library via a content delivery network (CDN). Basically, code at the top of JavaScript script will fetch and import the library from a server. This removes the need for you to work with build tools like [Vite](https://vite.dev), which you would have to do if you download the actual three.js code. Downloading, working and building the code is more robust long term but for this lesson the CDN approach is fine. This code will use three.js version 0.160.0, although it has been tested and works with later versions such as 0.166.1. If you want to change the version used, you need to change both numbers in the code where the import maps are referred to, i.e. use ```three@0.166.1``` instead of ```three@0.160.0```, and also change the version later on when importing the DRACO file compression loader. **Do not** mix versions. This lesson does not contain code likely to be affected by version changes but three.js versions are not necessarily backward compatible, so it is possible that problems will occur if later versions are used. Browser updates also occasionally cause incompatibility problems.

## Creating an Interactive 3D Scene

Now you need to set up the initial directories and files for the project.
Make a new folder - call it myscene. Within the myscene folder create folders called models and textures. We will use the textures folder in part 2. Put the png_sceneDRACO.glb file you downloaded previously in the models folder.

In VSC open the myscene folder.

Create a file and call it *index.html*.  
Note that it **must** be called this as this is the html file that will be served by the browser by default when you go to the local host address.

We are going to put all the code in this file. This is not the best practice but the point of the lesson is to learn about three.js. Generally you would have the JavaScript code in a separate (.js) file that would be imported by the index.html file. It is also good practice to have code properly indented and in some languages (such as Python), code indentation is important. However, in JavaScript you do not have to indent properly, so if the copy and pasting changes the indentation, you can choose to neaten it or not. Having it properly indented will help you copy and paste code into the correct spot.

In the index.html file, copy and paste the following:

```
<!DOCTYPE html>
<html lang="en">
	<head>
		<!--This is a html comment.  title tag gives the title of window -->
		<title>PNG pottery</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
 		<!--Link to the style sheet -->
		<link type="text/css" rel="stylesheet" href="main.css">
		<!--JavaScript. Get the three.js library files -->
		<script type="importmap">
            {
              "imports": {
                "three": "https://unpkg.com/three@0.160.0/build/three.module.js",
                "three/addons/": "https://unpkg.com/three@0.160.0/examples/jsm/"
              }
            }
        </script>
	</head>
	<body>
        <!--Link to three.js page and some text. Text colours specified in main.css. Could be used for interactive page instructions. -->
		<div id="info">
			<a href="https://threejs.org" target="_blank" rel="noopener">three.js</a> The Jars of Papua
		</div>
        	<!--JavaScript. Here is where the three.js code goes. -->
		<script type="module">
            	// JavaScript comment
            	// Library imports
			import * as THREE from 'three';
		</script>
	</body>
</html>
```

Save the file. This html file is: creating a basic page with a link to the three.js site and a title; importing the three.js library and addons; and linking to a style sheet (which we will create next). The link with the anchor tags (i.e. ```<a> </a>```) is not needed for three.js to work and is there because this page was developed from the three.js example pages; you could remove it or change it to link to any site you want. Anything written within the script tags (i.e. ```<script> </script>```) will be in the JavaScript language. In JavaScript code, comments are marked by ```//``` and anything on that line after that will be ignored.

In the myscene directory create another new file called 'main.css' and paste in the following. 

```
body {
	margin: 0;
	background-color: #000;
	color: #fff;
	font-family: Monospace;
	font-size: 13px;
	line-height: 24px;
	overscroll-behavior: none;
}

a {
	color: #ff0;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

button {
	cursor: pointer;
	text-transform: uppercase;
}

#info {
	position: absolute;
	top: 0px;
	width: 100%;
	padding: 10px;
	box-sizing: border-box;
	text-align: center;
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
	user-select: none;
	pointer-events: none;
	z-index: 1; 
}

a, button, input, select {
	pointer-events: auto;
}

.lil-gui {
	z-index: 2 !important; 
}

@media all and ( max-width: 640px ) {
	.lil-gui.root { 
		right: auto;
		top: auto;
		max-height: 50%;
		max-width: 80%;
		bottom: 0;
		left: 0;
	}
}

#overlay {
	position: absolute;
	font-size: 16px;
	z-index: 2;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	background: rgba(0,0,0,0.7);
}

#overlay button {
		background: transparent;
		border: 0;
		border: 1px solid rgb(255, 255, 255);
		border-radius: 4px;
		color: #ffffff;
		padding: 12px 18px;
		text-transform: uppercase;
		cursor: pointer;
}

#notSupported {
	width: 50%;
	margin: auto;
	background-color: #f00;
	margin-top: 20px;
	padding: 10px;
}
```

This file came from the [examples folder at three.js](https://github.com/mrdoob/three.js/tree/master/examples), it is a cascading style sheet file. Save the main.css file and then you can close it. 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-11.png" alt="A screenshot of the VSC editor with the director structure of the myscene folder." caption="Figure 11. The directory structure can be seen in the left hand panel of the VSC editor. The index.html file contents are shown in the main panel. Note file shown is an earlier version that lacks comments. They are colour coded. A VSC terminal is open and shown in the bottom panel." %}

If you want to understand the basic components of a website [w3schools](https://www.w3schools.com/howto/howto_make_a_website.asp) has a guide, as well as tutorials on HTML, CSS and JavaScript.

In VSC, Terminal > New Terminal will give you a terminal. Make sure that the command line of your terminal/shell indicates that you are in the myscene folder (...myscene %). You can use the terminal command 
```
pwd
```
which stands for 'print working directory' to check what folder you are in. 

In the terminal type

```
npx serve
```

this will serve your site, normally to port 3000, but check the message to see what local address is being used. Open a web browser and go to that address (ie http://localhost:3000) and if all is working you will see a black page with 'three.js The Jars of Papua'. 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-12.png" alt="Black page with small title (three.js The Jars of Papua), top centre." caption="Figure 12. Webpage with black background and small title." %}

You do not normally need to stop the server when you change the code, but you may need to if a mistake causes issues, or if you want to take a break. **To stop the server use Ctrl + C in the terminal. You can restart with 'npx serve', or use the keyboard up arrow to find previous terminal commands.** You may need to reload the page in the browser to apply any code changes. 

### Creating the Basic webpage

Every three.js website has a camera and a 'scene' to which lights and objects need to be added. The script will call two functions (blocks of code): init() and animate(). Most of the code will be in init() which will set up the scene and tell the page if it should ‘listen’ to any input from sources, such as the mouse and what it should do in response to that (ie we will add EventListeners). To start with we will add the standard EventListener for responding to window size changes. The animate function will continuously call the render function. Rendering is when the camera we add creates the 2D image that will be shown on the screen at that milisecond. 

First create a camera and a scene with a background colour. The position of the camera is important, sometimes you can not see your models because the camera is looking away from them or they are outside its field of view. We will use a perspective camera with parameters that define the field of view, including boundaries for culling objects that are too close or too far from the camera. The units for three.js are metres, and this camera will not render to the screen anything nearer to 0.1m and further than 10m. When we introduce moving the camera later, you will see objects disappear if they get too close. 

The camera and other positions are set in x, y and z order. As mentioned previously, x is left (-) and right (+), y is down (-) and up (+) and z is far/'into the screen' (-) and near/'coming out from the screen' (+). The camera is set at a height of 1.6m, and later the model will be at 0.8m. The z co-ordinate for the camera is set at 3m, as if you have stepped back from the scene. 

We will make the page background peach (0xf7d382). To specify colours you can use the colour [hex code](https://www.color-hex.com) after '0x'.

In the index.html file, **after** the import, declare the variables (with **let**), call and define the init() and other necessary functions. Variables are generally declared outside function definitions, but sometimes will be declared within a function definition if the variable is only referred to within the function definition. 

After:

```
    import * as THREE from 'three';
```

add:

```
	// Variable declaration and setting
	let container, camera, scene, renderer;

	// Function calls
	init(); // initialise scene
	animate(); // updates scene by constant rendering


	// Function definitions

	// Initialise scene: sets up container; scene; camera; renderer; lights; models; controls
	function init() {
		// make html div element and add to html document
		container = document.createElement( 'div' );
		document.body.appendChild( container );
		// make scene and set background colour
		scene = new THREE.Scene();
		scene.background = new THREE.Color( 0xf7d382 ); // use the hexcode of any colour you want.
		// make camera, set its start position	
		camera = new THREE.PerspectiveCamera( 50, window.innerWidth / window.innerHeight, 0.1, 10 ); //arguments are: vertical field of view, aspect, near plane, far plane. Note the aspect depends on the users window size.
		camera.position.set( 0, 1.6, 3 ); // arguments: x, y, z Values in metres. Approximates a persons eye level (designed for VR)

		// make renderer and use users browser window values to set pixel ratio and size
		renderer = new THREE.WebGLRenderer( { antialias: true } );
		renderer.setPixelRatio( window.devicePixelRatio ); // Don't change this code.
		renderer.setSize( window.innerWidth, window.innerHeight ); // Don't change this code.
		container.appendChild( renderer.domElement );

		// add listeners. These check for user interaction with the window and mouse clicks and call the given function.
		// listen for user browser window resizing and call the onWindowResize function that is defined below.
		window.addEventListener( 'resize', onWindowResize );
	}

	// function definitions
	// called on resizing of window. Gets new browser window values and updates camera and renderer settings. Don't experiment with.
	function onWindowResize() {
		        camera.aspect = window.innerWidth / window.innerHeight; 
		        camera.updateProjectionMatrix();
		        renderer.setSize( window.innerWidth, window.innerHeight );
	}

	// Constant loop of rendering.
	function animate() {
		renderer.setAnimationLoop( render );
	}
	// Called in loop by animate(), draws the scene in 2D as viewed by the camera at the camera's current position.
	function render() {
		renderer.render( scene, camera );
	}
```

Reload the page after saving the index.html file, and check that you have changed the background colour (Figure 13).

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-13.png" alt="Basic webpage with peach background." caption="Figure 13. Webpage with peach background." %}

Three.js uses window event listeners to detect user interactions with their browser. Here we will only listen for window resizing (```resize```), but in part 2 we will listen for mouse clicks (```click```) and drags (```dragstart``` and ```dragend```). Other possible input events include mouse movement (```mousemove```) and keys being pressed on the keyboard (```keyup``` and ```keydown```). The window event listeners have 2 arguments. The first identifies the input event (ie ```resize``` for resizing), and the second the function that will be called (run) if the event occurs. The standard window resize function code gets the new browser dimensions from the global object 'window' and updates the camera aspect and the dimensions of the picture the renderer is drawing. As 'window' is a global object, it is better to never call any of your variables 'window'.

Next we need to add lights.

There are several different types of lights. We will add a [hemisphere light](https://threejs.org/docs/index.html#api/en/lights/HemisphereLight) and a [directional light](https://threejs.org/docs/index.html#api/en/lights/DirectionalLight). The hemisphere light has 2 colours and an intensity (from 0 to 1), while the directional light has one colour and a position. Use the values supplied first. If everything is working, you can experiment with different values later. You can add lights directly, like we do with the hemisphere light, or declare them, modify their parameters and then add them, like we do with the directional light.

In the function init() and after:

```
	camera.position.set( 0, 1.6, 3 ); //x, y, z
```

add:

```
    	// add a hemisphere light and a directional light
	scene.add( new THREE.HemisphereLight( 0xffffbb, 0x080820, .5) ); // arguments: sky colour, ground colour, intensity
	const light = new THREE.DirectionalLight( 0xffffff ); // argument: colour
	light.position.set( 1, 6, 2 ); // x, y, z 
	scene.add( light );
```

Next we will add the model. Three.js can load several different file types. DRACO compressed glTF files require the importation of additional loaders.

After:

```
import * as THREE from 'three';
```

add:

```
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';
import { DRACOLoader } from 'three/addons/loaders/DRACOLoader.js'; // needed if draco compression on gltf
```

After:

```
	let container, camera, scene, renderer;
```

add:

```
	let themodel;
	let desk = 0.8; // the height of the model (metres), desk height in VR.const loader = new GLTFLoader();

	// Loader set up 
	// Different model formats use different loaders
	const loader = new GLTFLoader();
	const dracoLoader = new DRACOLoader();
	dracoLoader.setDecoderPath( 'https://unpkg.com/three@0.160.0/examples/jsm/libs/draco/' );
	loader.setDRACOLoader( dracoLoader );

```

Within the init function after:

```
	scene.add( light );
```

add:

```
	// load model
	// function used for loader
	function onLoadMap( gltf ) {                
		themodel = gltf.scene.children[0]; // can also use just gltf.scene
		themodel.position.set( 0, desk, 0); // x, y, z
		themodel.scale.set( 1, 1, 1); // x, y, z
		scene.add( themodel);
	}
	// the loader is given the model file name (first argument) which is passed to the function (second argument), function to do while loading (3rd argument), function called if error (4th argument).
	loader.load( 'models/png_sceneDRACO.glb', onLoadMap, undefined, function ( error ) {console.error( error );} ); 
	
```
Save and reload and you should see a model, but you will not be able to move around it yet (Figure 14).

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-14.png" alt="Several jar models sitting on a map of Papua." caption="Figure 14. The model of jars on a map of Papua." %}

The model is loaded with the load method, which can take 4 arguments. The first argument is the file name, which must include its 'path', ie any folders it is in (e.g. 'models/png_sceneDRACO.glb'). It can also be a URL. The other three arguments are for "callback" functions that will be called to: load the model, while the model is loading, and if there is an error loading the model. Here we have defined the onLoadMap function separately in the function definitions. We have left the on progress function 'undefined', but sometimes a function is used that creates a loading bar or similar indication to the user that something is happening, especially if the model is large and will take some time to load. The error function is defined here anonymously (without a name) and will print the error to the browser console.

The onLoadMap function takes the filename and obtains the model using '.scene'. Using 'gltf.scene' instead of 'gltf.scene.children[0]' will also work here. glTF files can have hierarchies of groups and meshes (as you saw in the scene tab of the three.js editor), and for some purposes it does not matter if the object being imported is a group or a mesh, but for others (like raycasting, which will be used in part 2) it does. Sometimes it is better to import the children of the scene and indexing starts with 0. You can also position, scale or rotate the model in the onLoadMap function. You can experiment with changing the x, y or z values for position or scale and see the effects.

### Adding Camera Controls to Move Around

We can add mouse controls to allow us to move around the scene. Some controls, including [orbit](https://threejs.org/examples/?q=controls#misc_controls_orbit), [map](https://threejs.org/examples/?q=controls#misc_controls_map), [fly](https://threejs.org/examples/?q=controls#misc_controls_fly), [pointer lock](https://threejs.org/examples/?q=controls#misc_controls_pointerlock) and [trackball](https://threejs.org/examples/?q=controls#misc_controls_trackball), change the position of the camera. Others, such as [drag](https://threejs.org/examples/?q=controls#misc_controls_drag) and [transform](https://threejs.org/examples/?q=controls#misc_controls_transform), can alter the position of objects. We need to import any controls. We will first use 'orbit' controls that allow the user to navigate the scene with rotation (when the mouse is clicked and dragged), panning (when the mouse is clicked and dragged while pressing the shift key, or using the right mouse button) or zooming (with mouse scrolling).

After

```
import { DRACOLoader } from 'three/addons/loaders/DRACOLoader.js';
```

add:

```
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
```

Change:

```
	let container, camera, scene, renderer; 
```

to:

```
	let container, camera, scene, renderer, controls;
```

In the init function, after:

```
	container.appendChild( renderer.domElement );
```

add:

```
		// create orbit controls
		controls = new OrbitControls( camera, renderer.domElement);
		controls.target.set( 0, 1.6, 0 ); // sets the scene rotational centre
		controls.update(); // updates controls settings after creation
		//controls.autoRotate = true; // set to true if camera is to rotate automatically BUT you must then call controls.update() in render function.

```

If you save and reload, you should be able to move around and zoom in and out. Note that the model is not being rotated but it is the camera that is being moved. The target.set method determines the centre that the camera will rotate around. If you want the camera to continuously rotate, you can uncomment out the ```controls.autoRotate``` but you must also add the call to update the controls in the render function, ie

Change:
```
		function render() {
		        renderer.render( scene, camera );
	        }
```

to: 

```
	        function render() {
                controls.update(); // use if controls.autoRotate = true
		        renderer.render( scene, camera );
	        }

```

You could deploy your site using the instructions on GitHub or Vercel. You can investigate the [three.js manual](https://threejs.org/docs/index.html#manual/en/introduction/How-to-create-VR-content) for making the site viewable in virtual reality (VR).

However, as noted previously, there are other simpler tools, such as SketchFab, for presenting models, and three.js is the most useful when you want to make the models interactive. To make the model interactive, try part 2 of the lesson.  

## References

D’Andrea, A., Conyers, M., Courtney, K.K., Finch, E., Levine, M. Rountrey, A., Kettler, H.S., Webbink, K. 2022. "Copyright and Legal Issues Surrounding 3D Data." In 3D Data Creation to Curation: Community Standards for 3D Data Preservation, eds. Moore, J., Rountrey, A., Kettler, H.S. Chicago: Association of Research and College Libraries (ALA).

Dolbunova, E., Lucquin, A., McLaughlin, T.R., Bondetti, M., Courel, B., Oras, E., Piezonka, H., Robson, H.K., Talbot, H., Adamczak, K., Andreev, K., Asheichyk, V., Charniauski, M., Czekai-Zastawny, A., Ezepenko, I., Grechkina, T., Gunnarssone, A., Gusentsova, T.M., Haskevych, D., Ivanischeva, M., Kabacinski, J., Karmanov, V, Kosorukova, N., Kostyleva, E., Kriiska, A., Kukawka, S., Lozovskaya, O., Mazurkevich, Z., Nedomolkina, N., Piliciauskas, G., Sinitsyna, G., Skorobogatov, A., Smolyaninov, R.V., Surkov, A., Tkachov, O., Tkachova, Ml, Tsybrij, A., Tsybrij, V., Vybornov, A.A., Wawrusiewicz, A., Yudin, A.I., Meadows, J., Heron, C., Craig O.E. 2023. The Transmission of Pottery Technology Among Prehistoric European Hunter-Gatherers. Nature Human Behaviour. 7:171. 

Gaffney, D., Summerhayes, G.R., Ford, A., Scott, J.M., Denham, T., Field, J., Dickinson, W.R. 2015. Earliest Pottery on New Guinea Mainland Reveals Austronesian Influences in Highland Environments 3000 Years Ago. PLoS ONE 10(9):e0134497.

Holtorf, C. 2005. From Stonehenge to Las Vegas. Archaeology as popular culture. Walnut Creek: AltaMira Press.

Maschner, H. July 2022 (https://sketchfab.com/blogs/community/cultural-heritage-spotlight-global-digital-heritage/?utm_source=website&utm_campaign=newsfeed)

May, P., Tuckson, M. 2000. The Traditional Pottery of Papua New Guinea. Crawford House Publishing, Adelaide.

O'Brien, M.J., Lyman, R.L., Collard, M., Holdern, C.J., Gray, R.D., Shennan, S.J. 2008. Transmission, Phylogenetics and the Evolution of Cultural Diversity. In: Cultural Transmission and Archaeology: Issues and Case Studies. Society for American Archaeology. Washington.

Oruç, P. 2020. 3D Digitisation of Cultural Heritage: Copyright Implications of the Methods, Purposes and Collaboration, 11 JIPITEC 149 para 1.  

Pétrequin, A.-M., Pétrequin, P. 2006. Objets de Pouvoir en Nouvelle Guinée: Approche Ethnoarchéologique d’un Système de Signes Sociaux: Catalogue de la Donation Anne-Marie et Pierre Pétrequin. Réunion des Musées Nationaux, Paris.

Rahaman, H. 2021. Photogrammetry: What, How, and Where”, in: Champion, Erik M. (ed.): Virtual Heritage: A Guide. London: Ubiquity Press 25-37.

Shaw, I., Leclerc, M. 2023. Unearthed: Art in Archaeology and Anthropology. ISBN 978-0-6453425-0-5.

