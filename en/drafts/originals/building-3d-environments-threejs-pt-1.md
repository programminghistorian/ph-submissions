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
difficulty: 1
activity: presentation
topics: web development, 3d modeling
abstract: This two-part lesson shows how the three.js JavaScript library can be used to create websites featuring 3D models that can be interactively viewed, selected and even used in a game. In part 1, a website is created featuring a model illustrating the rich diversity of ceramics from the Papua New Guinea region.
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

Advances in computing continue to increase our ability to display models in websites, create virtual museums and make heritage information more accessible. The use of interactive 3D models in websites enables examples of archaeological and historical material culture to be presented more effectively. This lesson aims to facilitate the production of engaging digital research outputs by introducing [three.js](https://threejs.org) (a JavaScript library) as a tool to present virtual 3D models. This lesson shows how to use [three.js](https://threejs.org) to create a website with 3D models that illustrate the diversity of the pottery technologies of communities in the Papua New Guinea area. Part 1 of this lesson offers a beginner-level guide to creating a website featuring a 3D model. In Part 2, a more complicated website is created, where selecting a vessel model reveals information on the local community and their ceramics. 3D models are generally more engaging than 2D images, largely because the extra dimension encourages user interaction. The act of moving around a model, and choosing which areas to visually examine, and find out more information, creates a more personalised experience and contributes to the user forming a relationship with the model. This relationship can be increased if the model can be manipulated or is part of a puzzle. Puzzles increase the amount of time spent with a model and can induce users to notice details they may have otherwise overlooked. The sense of achievement obtained with solving a puzzle can also strengthen a positive relationship with a model and its subject. Part 2 also shows how the website can be the basis for a matching puzzle where the vessel is matched to the community that manufactured it. In the puzzle version, selecting a site shows the information about the pottery; if the vessel is dragged to the position of the community that make it the background colour of the scene will change.

### 3D Models for Cultural Heritage

Web models and digital games can help the dissemination of archaeological information. As opposed to simply writing texts about artefacts, supplying communities with more accurate examples of the archaeological past can be considered a goal of archaeologists (Holtorf, 2005). Virtual (or printed reproduction) cultural heritage models have the advantage that they can be inspected without the risk of damaging an archaeological artefact. They can be inspected at a different scale from the original: houses, sites, or villages can be minimised to understand how different areas relate to each other, while small artefacts, such as coins, can be magnified so that small details can be more easily seen. In this case, vessels can be minimised so that many can be compared, and they can be placed on a geographic map, with placement linking them more strongly to their creators than would a simple label. Ideally, the use of models can help reduce the removal, and facilitate the return, of original artefacts from the communities that created them and their descendants.
 
Cross community comparisons of different aspects of material culture, such as pottery, can reveal shared community histories. For pottery, these aspects include both appearance (form and decoration) and methods of production. However, while similarities might indicate that a past community 'split' or contributed people to different communities, the spread of ideas and local innovations generally occur at a faster rate in material culture than with genetics or linguistics. The transmission of pottery production is argued to have occurred, at least partially, independently of population movement in Europe (Dolbunova et al. 2023). Phylogenetic studies using the level of similarity of features across communities in material cultures, such as lithics, have been used to assess 'cultural evolution' (O'Brien et al. 2008). This 'evolution' can occur due to diffusion of learning from one culture to another, or from innovations within a community (O'Brien et al. 2008). Comparing different pottery styles can help us identify shared heritages, community contacts and local innovations. Visualising the pottery forms and their geographic distribution helps illustrate these shared heritages, especially when additional information, such as the language family, of the community is considered. The extensive ethnographical work of researchers, such as May and Tuckson (2000) and Pétrequin and Pétrequin (2006), has been essential for such comparisons.

### Lesson Goals

This two-part lesson is designed as a very brief introduction to the three.js JavaScript library, and involves for the reader a considerable amount of copying and pasting code. Part 1 introduces 3D models and some of the ethical issues associated with their generation and use. Users will explore some of a model’s components and work with a 3D co-ordinate system using the three.js web-based editor. Part 1 also shows how to set up and locally serve a basic webpage featuring a 3D model in a scene with lights and mouse controls, using three.js.

The primary goal of Part 2 is to teach how to use three.js to create a webpage featuring a 3D scene with selectable components. Scene creation will involve adding lights, cameras, primitive models (such as spheres and planes), complex models (the pot forms), and controls. The models will incorporate materials and/or image textures. Concepts such as model groups, scale and visibility, and 3D co-ordinates will be introduced. An additional goal of Part 2 is to change the webpage into a game by making the models moveable and initally positioned at random places, with the user then required to match the vessel to its maker community. A test in the code is run after each time a model is moved, to see if it has been placed in the correct position. Successful matches trigger a background colour change.

### Software Requirements and Installation

This lesson should work for most current web browsers (i.e. Chrome , Safari, Edge etc). If your browser can display the [three.js site](https://threejs.org) and the various sample projects on the home page, it should work; some Safari versions have problems. Chrome generally has the better developer tools for code debugging. It is useful to know how to view the browser log console. In Chrome, this can be done through View > Developer > JavaScript Console. These console error messages can help identify why a site is not loading properly. You may have to use a search engine (such as Google) to understand the error message and you may have to reload a site while the console is open to see the error message. For more information on debugging code see the [three.js manual](https://threejs.org/manual/#en/debugging-javascript).

The first half of part 1 does not require coding but in the second half of part 1 you will create a webpage. Webpages generally utilise several computer languages (such as HTML, CSS and JavaScript). This lesson will not explain the HTML and CSS code. If you want to understand the basic components of a website, [w3schools](https://www.w3schools.com/howto/howto_make_a_website.asp) has a guide, as well as tutorials on HTML, CSS and JavaScript. You may choose to do the first half of the lesson and come back to this section to install the software necessary for creating the webpage.

To write and run code you will need to use a text editor and a computer terminal (ie Windows PowerShell, the terminal in macOS or Linux, or the text editor's terminal). The Visual Studio Code (VSC) software has a text editor and can be downloaded from [https://code.visualstudio.com](https://code.visualstudio.com), it is free and runs on Windows, macOS, and Linux. It also features a terminal. Install as per website instructions. Many extensions are available for VSC and the code colouring can help detect issues such as unclosed tags or quotes. The terminal in VSC can be obtained from Terminal > New Terminal. [VSCodium](https://vscodium.com) is a user tracking/AI chat-free alternative. 

Some simple command line typing will be required. Most importantly, you need to be able to move to the folder that your website file will be in. If you use the VSC terminal, this should be automatic.

[Node.js](https://nodejs.org) will allow you to ‘serve’ code internally to your browser (using an address in the browser such as http://localhost:3000), and see if the code is working, or how code changes affect your site. Node.js is probably the easiest way to serve code internally. It is a free JavaScript tool and is easy to install (Windows, macOS, and Linux). Install as per website instructions, and check it is working in the terminal you plan to use by typing 

```
node -v
```

and confirming that you get a version number and not an error message. This code has been tested with version v18.14.1. If you have problems installing Node.js, try using a search engine with the error message for help or watch one of the many tutorials available on the web. 


### Papua New Guinea Pottery

While not ubiquitous throughout Papua New Guinea and West Papua, many communities have a history of making ceramic vessels for use in cooking, storage or ceremonial purposes. Pottery was first introduced to the Papua region over 3000 years ago (Gaffney et al. 2015) and the many different techniques, forms and decorations found are probably the result of a combination of local innovations and influences from different external sources. The technical and sometimes ceremonial or spiritual, knowledge required to construct and decorate pots is passed down generations or occasionally from community to community, in a process termed cultural transmission. In trying to understand this cultural transmission, researchers compare factors such as decoration, form and building technique among the different communities. 

This lesson includes information and a pot model for 29 communities. In part 2, where the vessels are added separately, step-by-step instructions are given for 6 models (from Bilibil, Mailu, Misima-Paneati, Adzera, Dimiri and Iatmul speakers), with the assets and information for another 23 provided for users to practice with. The 29 models show examples of vessels made using different building and decorating techniques. 

In the southeast, woman's pottery communities (including Mailu and Misima-Paneati speakers) employ a range of techniques, typically finishing vessels with rings made from clay coils and decorating them with predominantly geometric incised or applique decorations. In many inland communities, potters (including Adzera, Dimiri and Iatmul speakers) use spiral (or ring) construction, building vessels by stacking circular clay coils, with decorations often incorporating sculptural elements and carvings. In coastal communities (including the Bilibil), women make paddle and anvil-made vessels from a ball of clay that is beaten on the outside with a wooden paddle, while a stone (anvil) is held inside the pot; these are generally rounder, less decorated and often used for water storage.

### Ethics in Cultural Heritage Work

How different communities feel about their cultural objects being modelled and represented on websites is an area that would benefit from further research. While virtual models and interactive websites have the ability to increase accessibility to cultural heritage and help effectively communicate academic research to a broader community, there are important ethical considerations that should be addressed when creating such resources. These apply at the level of model creation and website design. 

If the website is intended to communicate academic research, then ultimately community involvement and control should have occurred at an earlier stage of the research. However, as in other fields, technological advances have occurred that could not be foreseen by data/artefact collectors, and ideas around what constitutes 'informed consent' have also evolved. The use of cultural heritage models, especially from communities that have been exploited and looted, needs to be carefully considered. There are laws and guidelines, such as the [UNESCO Convention for the Safeguarding of the Intagible Cultural Heritage](https://www.unesco.org/en/legal-affairs/convention-safeguarding-intangible-cultural-heritage#:~:text=Adopts%20this%20Convention%20on%20this%20seventeenth%20day,of%20the%20communities%2C%20groups%20and%20individuals%20concerned;), [the Code of Cultural Heritage and Landscape (Italy)](https://www.unodc.org/cld/document/ita/2004/code_of_the_cultural_and_landscape_heritage.html?) and the [Protection of Movable Cultural Heritage Act (Australia)](https://www.legislation.gov.au/C2004A03252/latest/text) that back up these ethical concerns in many cases. Ideally, informed consent from the maker community, or their descendants, should be obtained for modelling of cultural objects. In some countries intellectual property legislation may require evidence that at least several attempts have been made to obtain permission. 

Images of human remains can be offensive to some communities, and modelling these should be carefully considered, and may require content warnings. 'Utilitarian' items are generally considered exempt from copyright, but some ceramics (or wooden/stone artefacts) have ceremonial purposes, and objects (particularly funerary artefacts) can also have different values and associations for different people and cultures as highlighted by recent (2023) [Native American Graves Protection and Repatriation (NAGPRA) legislation](https://www.federalregister.gov/documents/2023/12/13/2023-27040/native-american-graves-protection-and-repatriation-act-systematic-processes-for-disposition-or) in the USA on the display of certain Native American objects (including burial pottery). One approach for connecting media including models to cultural information, such as ethical reuse or cultural restrictions on viewing, involves the inclusion of [Traditional Knowledge (TK) Labels](https://localcontexts.org/labels/traditional-knowledge-labels/) in media metadata. The use of symbolic, less realistic, representations of material culture, is a related approach for minimising the use of potentially culturally inappropriate digital reproductions. As discussed later, this approach can have other advantages for use in games.

The available guidelines and protocols are generally more targeted at institutions, but it is worth considering [Basic principle and tips for 3D digitisation of cultural heritage](https://digital-strategy.ec.europa.eu/en/library/basic-principles-and-tips-3d-digitisation-cultural-heritage) and [Protocols for using First Nations cultural and intellectual property in the arts](https://creative.gov.au/first-nations-arts/protocols-for-using-first-nations-cultural-and-intellectual-property-in-the-arts). 

It is also important to reference the source of images and models used in a website. In this lesson, references will be enabled an information panel in the website. The degree to which **models** of cultural artefacts are covered by copyright, and who that copyright belongs to (the creators of the original artefacts, the current 'owners' or caretakers of the artefacts, or the creators of the model), depends on several factors, and is not always clearcut (Oruç, 2020; D'Andrea et al. 2022; Marek, 2022). Many researchers aim to make their models and site code available for others to use to increase the dissemination of information and promote further research. Often models/code are given [Creative Commons licences](https://creativecommons.org/share-your-work/cclicenses/) such as CC-BY-NC (Creative Commons Attribution-NonCommercial). However, it is always worth considering that your models may be used in virtual scenes you disagree with or find offensive, i.e. the pot models could be used in a potentially culturally derogatory manner (for example, illustrating cannibalism). While you can request users to only use your models and code for non-derogatory purposes, publicly-available digital assets are increasingly being scraped by Artificial Intelligence (AI) 'bots', thus potentially contributing to models used in scenarios you did not forsee. The use of the "NoAI" HTML meta tag may help discourage such data harvesting. 

When making games out of cultural heritage models, it is also important to reflect on whether scenes or puzzles are falling into a colonial approach. For example, in a videogame, rather than letting the user steal or 'collect' artefacts, a better aim would be to gamify the return of artefacts to their place or community of origin. In the puzzle in Part 2 of this lesson, the pots are matched back to their original community, as represented as a place on the map. 


### 3D Modeling with three.js

3D models are made from meshes of nodes (points) joined with edges (connecting lines) to compose faces (also called polygons) (Figure 1). These polygons are usually triangles (with 3 vertices) or quadrilaterals (with 4 vertices). Basic shapes such as spheres, cubes, planes and tori ('donuts') are known as 'primitive' models and can be created directly in three.js. 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-01.png" alt="A mesh, the model and 4 maps for a white staffy dog on a red couch with 3 blankets. The 2 dimensional maps include colour, normal, occulusion and roughness." caption="Figure 1. The mesh and maps (textures) for a model of Diva dog. A section of a reduced polygon mesh of Diva dog is shown for comparison. Diva's tan head patch and collar can be located in the colour map. [See the model in SketchFab](https://skfb.ly/pzB7J). Model created from a quick [Polycam](https://poly.cam) scan." %}

Some people like to build more complicated models by combining primitive models in three.js, but often these more complicated models are created with Computer Aided Design (CAD) software such as [Blender](https://www.blender.org) or with scanning processes such as photogrammetry, before they are imported into three.js as 'complex' models. In photogrammetry, models are computed from series of overlapping photographs of an object at various angles (Rahaman, 2021). Photogrammetric models, including those from phone apps such as [Polycam](https://poly.cam), will typically have image textures and be realistic (left side, Figure 2). Models made using Blender or other CAD software may be symbolic (simplified forms that represent, rather than mimic, objects and their characteristic features), or made more realistic with the addition of image textures or complex materials (right side, Figure 2). 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-02.png" alt="Flow charts for photogrammetry and CAD model making. Photogrammetry requires multiple photographs, which are used to create a point cloud, then a mesh which is wrapped in a texture to make a model, such as a sherd. A jar CAD model can be made by tracing the vessel outline and rotating it." caption="Figure 2. Models can be created by methods that include photogrammetry and Computer Aided Design (CAD). [See the sherd model in SketchFab](https://skfb.ly/pzEEW)." %}

Meshes can be decorated with ‘materials’ that have colour and other properties such as emission, roughness, metalness, opacity etc. They can also be decorated with images or other ‘textures’. Textures are two dimensional image files with u (horizontal) coordinates from 0 to 1, and v (vertical) coordinates from 0 to 1 (Figures 1 and 2). Each vertex in a model's mesh is also assigned U and V coordinates (in a process called 'unwrapping') that correspond to those in the texture. 

In texture mapping, each polygon in the mesh gets the pixels of the texture image that match the polygon defined by the UV coordinates. Thus image textures can be used as colour maps with the different pixel colours being mapped onto the model to map the image on the model (Figure 1). If you inspect the colour map, mesh and model in Figure 1 you should be able to see where parts, such as the tan head spot and the collar in the map, are being matched to the mesh. 

Textures with grayscale (from white to black) pixel intensities can also be used to convey other information, including opacity (alpha maps), roughness and shadow effects (occlusion maps) (Figure 1). Many 3D modellers will create 'normal maps' for their models to simulate fine shape details. A mesh polygon 'faces' outwards (i.e. 90 degrees to the polygon plane) but the pixels in normal maps change how light sources interpret the direction different points in a polygon are 'facing', so that a flat polygon can appear to have a non-flat surface. Normal maps are colour (RGB) images with the three channels (red, blue and green) providing the x, y and z 'facing' components. They are especially useful for (partly) retaining model details when reducing the number of faces in a model. Three.js can use normal maps, but in part 2 you will only use colour map textures. You will also only add textures to 2D planes and it is easier to put a 2D image texture onto a 2D surface than it is to map it onto a complicated 3D model. 

If you are interested in UV mapping, you can use the 'Model Inspector' in the bottom right corner of many models in [SketchFab](https://sketchfab.com/), including [Diva dog](https://skfb.ly/pzB7J) and the [Papua jars](https://skfb.ly/putNM).In the 3D + 2D view you can see where the U, V co-ordinates correspond on the model and the map (Figure 3).

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-03.png" alt="The dog and jars models in the model inspector in SketchFab." caption="Figure 3. The Model Inspector in SketchFab for the Diva dog and Papua Jars models." %}

There are many different model formats, and some, such as [STL](https://en.wikipedia.org/wiki/STL_(file_format)), will only store the mesh. The [GL Transmission Format (glTF) or GL Transmission Format Binary (glb)](https://en.wikipedia.org/wiki/GlTF) file format is one of the formats that can store meshes, textures, materials, animations and other properties. glTF/glb files (or rather the meshes in them) can also be compressed further with [DRACO](https://google.github.io/draco/) compression; Blender will export DRACO compressed glTF/glb files. There are some Central Processing Unit (CPU) penalties in decompressing DRACO files, so they will not always load faster in a website than uncompressed files.

glTF/glb can also store several models in a file. If you are creating a scene with several models for a website, you can choose to import each of the different models into a scene in software such as Blender (or the [three.js editor](https://threejs.org/editor/)), position, scale and colour/texture each of them, and export the resulting composite model as one glb file, such as the png_sceneDRACO.glb file you will use in Part 1. Alternatively, you can import the models individually and arrange and alter them via the website code, such as you will do in Part 2. There is also the option of separating out the individual models from the composite model in the code, but that will not be used in this lesson.

The models used in this project were created with CAD by the authors (who are not of Pacific Islander heritage) and are intended to be symbolic rather than realistic. While simplification of some of the designs results in the brilliance of some of the potteries being under-represented, it aids in avoiding impingement on the moral rights of the original communities. 

For this project, it was considered that symbolic models of non-ceremonial objects was more acceptable than the use of realistic (photogrammetry) models, whose use would require the permission of the different communities. Symbolic models were also used because they could convey the method of the original vessel construction with a corresponding colour and the use of a key. The method of construction is not only important for understanding the connections between the technologies, but for the puzzle, the colours also act as the primary clues for the website user to match vessels to their communities.

The individual vessel models used in this project were originally created by one of the authors (K. Hardy) as part of an exercise to learn CAD for 3D printing (Shaw, 2023). The models were created using Blender and [Fusion 360](https://www.autodesk.com/au/products/fusion-360/) by tracing or estimating the vessel profile (from the various sources cited in one of the information panels added to the website 3D model), rotating the profile 360 degrees around the vertical axis, and then (if necessary) using the sculpting tools to add the decorations (right side Figure 2). As they were designed to be printed 5-10 cm tall, decoration was simplified, and was added in a way to be reflective of the different decoration types, such as comb incision, impression, exposed coil and applique, that are favoured by the different communities. Many communities produced more than one type of pot, and forms for the original printed collection were originally chosen to illustrate the variety of vessels in Papua.

For use with a website, Blender was used to reduce the model polygon count. The composite model (used in Part 1) was created in Blender, with the addition of the map (added via the [‘import image as planes’ extension](https://docs.blender.org/manual/en/3.3/addons/import_export/images_as_planes.html)). The individual vessel models (used in Part 2) were exported as DRACO compressed glTF files. 

These models have a [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) licence. The 'BY' (attribution) means that if they are used, reference should be made to the authors/creators. The 'NC' (non-commercial) part means they can be used and modified by others, but not for commercial use. The 'SA' (share-alike) part means that if they are re-used the containing work has to have a similar licence.

#### Alternatives to three.js for Creating Websites Featuring Models

Websites can be made relatively easily using the three.js JavaScript library. While this lesson uses three.js, many of the concepts are also relevant to game engines and 3D modelling software.

There are several alternatives for creators to make websites that include 3D models. Many cultural heritage models are hosted on SketchFab (Maschner, 2022), which allows for (limited) interactive annotations, where informative text appears when users click on certain areas of the model (Figure 4). Models such as the [Papua jars](https://skfb.ly/putNM) or [Diva dog](https://skfb.ly/pzB7J) can be linked and embedded in other websites. [Smithsonian Voyager](https://smithsonian.github.io/dpo-voyager/), [3DHOP](https://3dhop.net/demo.php) and [Kompakkt](https://kompakkt.de/home) also allow for models to be embedded in websites with greater model annotation. These platforms are useful for publishing high quality models that can help engage viewers with paragraphs or snippets of information, often presented in a sequence as the viewer navigates through the model. Researchers and students can also examine these models with measurement tools. 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-04.png" alt="The jar models in SketchFab and several stylistic models of jars from Papua, 5 with numbers. Informative text is shown for the jar numbered 5." caption="Figure 4. The Papua Jar models in SketchFab with 5 annotations." %}

For more complex websites, such as those with multiple models which the user can manipulate independently from each other, or which require a test to see if models have been placed correctly relative to another, then JavaScript libraries, such as three.js and [Babylon.js](https://www.babylonjs.com), or game engines such as [Godot](https://godotengine.org), [Unity](https://unity.com) and [Unreal Engine](https://www.unrealengine.com), are necessary. Some game engines have no-code approaches that might appeal to some users. 

Three.js was chosen for this project due to the large number of three.js easily modifiable [tutorial examples](https://threejs.org/examples/) and ease of converting the site for viewing in [virtual reality](https://threejs.org/manual/#en/how-to-create-vr-content). Three.js, by itself, is not a physics engine, so it can not generally simulate object interactions, such as detecting object collisions. It can be used with physics engine libraries, such as [Ammo.js](https://github.com/kripken/ammo.js), [Cannon.js](https://github.com/schteppe/cannon.js) or [Rapier.js](https://rapier.rs), as shown in some of these [three.js physics examples](https://threejs.org/examples/?q=physics). The Babylon.js library has greater support for physical interactions and may be a better alternative for some digital exhibits.  

### Exploring Models with the three.js Editor

Before starting to code, you can explore a model in the [three.js editor](https://threejs.org/editor/). 

Download the composite model png_sceneDRACO.glb from the [`/assets` folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/building-3d-environments-threejs-pt-1-2). Open the [three.js editor](https://threejs.org/editor/) in a new browser window (right click on the link) and import the model with File > Import (Figure 5). 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-05.png" alt="Web editor showing a dark rectangular prism with small jars on it." caption="Figure 5. The three.js editor with the composite model imported." %}

Change the view from SOLID to WIREFRAME using the drop down menu at the top right of the model view window, and zoom in and move around with your mouse. Expand the model hierarchy in the SCENE window/tab (on the right) by clicking on the + symbol next to "png_sceneDRACO.glb" and then the subsequent + symbols in the hierarchy. Double click on a jar name (try the aibom_LOC) and it should centre that jar. You can also double click on a jar model in the main window. 

You should be able to see that the jars (and the plane) are made of triangles (Figure 6). The less nodes or faces in the mesh, the smaller the model size. Reducing the number of faces can reduce the details in a model, but large model files will not load or will be slow to respond in websites. Reducing the nodes or faces in a model, or retopology, can be done in programs such as Blender. In Blender this is relatively easy, if the model is imported in STL format without an image texture. The individual jar models (used in part 2) were designed and retopologised in Blender to file sizes under 700KB. 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-06.png" alt="Web editor showing the wireframes of jar meshes." caption="Figure 6. The three.js editor in wireframe view zoomed in on a jar mesh." %}

You may have models that you have made from photogrammetry, or downloaded from sites such as [SketchFab](https://sketchfab.com/), that have image textures. These are easier to retopolise in commercial software such as [Agisoft’s Metashape](https://www.agisoft.com), but it is also possible to use Blender or the free photogrammetry software [Meshroom](https://meshroom-manual.readthedocs.io/en/latest/index.html). You can test your models by importing them into the three.js editor or, if they are glTF files, in [Don McCurdy's glTF viewer](https://gltf-viewer.donmccurdy.com).

When inspecting models you may need to add lights, as some materials do not work without them. To do so, change WIREFRAME back to SOLID. In the editor add a hemisphere light from the Add > Light > Hemisphere menu. If you select the hemisphere light in the SCENE tab, you can change the colour to white and the ground colour to black (Figure 7), which results in white light originating from the sky and changing colour to black as it nears the ground. You can use the editor to test different lights and light options.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-07.png" alt="Web editor showing jar models in different colours." caption="Figure 7. The jars under a hemisphere light." %}

If you zoom out you can see the map. The jars are coloured because they have materials but the map was made of a plane with an added image texture (Figure 8).

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-08.png" alt="Web editor showing that the rectangle the jars are on has a map of Papua New Guinea." caption="Figure 8. The Papua New Guinea map and its image texture (called a map in the Material tab)." %}

Click on a jar. While in the editor, it is useful to look at the red, green and blue arrows in the centre of the scene, which illustrate the co-ordinate system. In three.js, positions are set in x, y and z order. Different graphics programs and game engines use different co-ordinate systems. In three.js x is left (-) and right (+), y is down (-) and up (+) and z is far (-) and near (+) (Figure 9), i.e. it is a Y up, right-handed system. 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-09.png" alt="Web editor with three arrows, coloured red, green and blue, showing the x, y and z axis." caption="Figure 9. The three.js co-ordinate system. Red arrow shows positive x direction, green arrow shows positive y direction, blue arrow shows positive z direction." %}

If you select a jar and look in the OBJECT tab, you will see the x, y and z positions it was placed at (Figure 10), and you can change them and see the jar move. You can also change the scale or rotation of a jar and test what happens.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-10.png" alt="Web editor showing a round jar (manus001), with its x, y and z positions visible in the geometry window." caption="Figure 10. The position of the jar made by one of the communities on Manus Island." %}

### Using the three.js JavaScript Library

There are 2 ways to use the three.js JavaScript library. This tutorial will use the library via a content delivery network (CDN). Basically, code at the top of JavaScript script will fetch and import the library from a server. This removes the need for you to work with build tools like [Vite](https://vite.dev), which you would have to do if you download the actual three.js code. Downloading, working and building the code is more robust long term but for this lesson the CDN approach is fine. 

This code will use three.js version 0.160.0, although it has been tested and works with later versions such as 0.166.1. If you want to change the version used, you need to change both numbers in the code where the import maps are referred to, i.e. use ```three@0.166.1``` instead of ```three@0.160.0```, and also change the version later on when importing the DRACO file compression loader. **Do not** mix versions. This lesson does not contain code likely to be affected by version changes but three.js versions are not necessarily backward compatible, so it is possible that problems will occur if later versions are used. Browser updates also occasionally cause incompatibility problems.

## Creating an Interactive 3D Scene

Now you need to set up the initial directories and files for the project.

Make a new folder - call it myscene. Within the myscene folder create folders called models and textures (you will use the textures folder in Part 2). Put the png_sceneDRACO.glb file you downloaded previously in the models folder.

In VSC open the myscene folder.

Create a file and call it *index.html*. Note that it **must** be called this as this is the html file that will be served by the browser by default when you go to the local host address.

You are going to put all the code in this file. This is not the best practice but the point of the lesson is to learn about three.js. Generally you would have the JavaScript code in a separate (.js) file that would be imported by the index.html file. It is also good practice to have code properly indented and in some languages (such as Python), code indentation is important. However, in JavaScript you do not have to indent properly, so if the copy and pasting changes the indentation, you can choose to neaten it or not. Having it properly indented will help you copy and paste code into the correct spot.

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

Save the file. This html file is: creating a basic page with a link to the three.js site and a title, importing the three.js library and addons, and linking to a style sheet (which you will create next). The link with the anchor tags (i.e. ```<a> </a>```) is not needed for three.js to work and is there because this page was developed from the three.

For the js example pages, you could remove the or change them to link to any site you want. Anything written within the script tags (i.e. ```<script> </script>```) will be in the JavaScript language. In JavaScript code, comments are marked by ```//``` and anything on that line after that will be ignored.

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

This file is a cascading style sheet file. It came from the [examples folder](https://github.com/mrdoob/three.js/tree/master/examples) at three.js' github, which contains all the source code for the [three.js example sites](https://threejs.org/examples/). Save the main.css file and then you can close it. 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-11.png" alt="A screenshot of the VSC editor with the director structure of the myscene folder." caption="Figure 11. The directory structure can be seen in the left hand panel of the VSC editor. The index.html file contents are shown in the main panel. A VSC terminal is open and shown in the bottom panel." %}

In VSC, Terminal > New Terminal will give you a terminal. Make sure that the command line of your terminal/shell indicates that you are in the myscene folder (...myscene %). You can use the terminal command 

```
pwd
```
which stands for 'print working directory' to check what folder you are in. 

In the terminal type

```
npx serve
```

This will serve your site, normally to port 3000, but check the message to see what local address is being used. Open a web browser and go to that address (i.e. http://localhost:3000). If all is working you will see a black page with 'three.js The Jars of Papua'. If you encounter problems when using Windows, you may need to type the following into the terminal.

```
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-1-12.png" alt="Black page with small title (three.js The Jars of Papua), top centre." caption="Figure 12. Webpage with black background and small title (three.js The Jars of Papua)." %}

You do not normally need to stop the server when you change the code, but you may need to stop if a mistake causes issues, or if you want to take a break. **To stop the server use Ctrl + C in the terminal. You can restart with 'npx serve', or use the keyboard up arrow to find previous terminal commands.** 

You may need to reload the page in the browser to apply any code changes. 

### Creating the Basic webpage

The script will call two functions (blocks of code): init() and animate(). Most of the code will be in init(), which will set up the scene and tell the page if it should ‘listen’ to any input from sources, such as the mouse, and what it should do in response to mouse movement or clicks (i.e. you will add EventListeners). 

First, you will need to set up a container for the scene, which is actually a <div> HTML element which gets added to the HTML document. The container first needs to be 'declared', and then it gets created in the init function. 

In the index.html file, **after** the following line of code:

```
import * as THREE from 'three';
```

You need to **add** the following code:

```
// Variable declaration and setting
let container;

// Function calls
init(); // initialise scene

// Function definitions

// Initialise scene: sets up container; scene; camera; renderer; lights; models; controls
function init() {
 // make html div element and add to html document
 container = document.createElement( 'div' );
 document.body.appendChild( container );
}

```

Nothing will change in your browser yet.

The animate function will continuously call the `render` function. The conversion of a 3D scene into a 2D image (to be displayed on the screen at that millisecond) is called 'rendering'. The 2D image is 'drawn' from the point of view of the camera and according to the camera settings. When you create the new renderer in the init function, you need to give it the pixel ratio, width and height details of the browser window, and then add it to the container. You can also tell it to use 'anti-aliasing' and it will try and smooth object edges by averaging edge pixel colours. 

The renderer needs a scene and a camera. Within the init function, you will create a scene with a background colour, and then a camera. The position of the camera is important; sometimes you can not see your models because the camera is looking away from them or they are outside the boundaries of what it can see (i.e. its field of view). 

You will use a perspective camera, and give it parameters that define its field of view. These field of view arguments are: [the vertical field of view in angles](https://en.wikipedia.org/wiki/Field_of_view); the horizontal to vertical aspect; and the boundaries for culling objects that are too close or too far from the camera. The aspect of the view can be taken from the browser window's dimensions and you will later add a function so that it is updated if the browser window is resized. The units for three.js are metres, so this camera will not render to the screen anything nearer to 0.1m and further than 10m. When moving the camera is introduced later, you will see objects disappear if they get too close.

The camera and other positions are set in x, y and z order. As mentioned previously, x is left (-) and right (+), y is down (-) and up (+) and z is far/'into the screen' (-) and near/'coming out from the screen' (+). The camera is set at a height of 1.6m, and later the model will be at 0.8m. The z co-ordinate for the camera is set at 3m, as if you have stepped back from the scene. 
You will make the page background peach (0xf7d382). To specify colours you can use the colour [hex code](https://www.color-hex.com) after '0x'.

In the index.html file, **after** the import, you will declare the variables (with **let**), call and define the init() and other necessary functions. Variables are generally declared outside function definitions, but sometimes will be declared within a function definition if the variable is only referred to within the function definition. 

**Find** the following code:

```
let container;
```

The line of code above should be **changed** to the following:

```
let container, camera, scene, renderer;
```

**After** the following line of code:
```
init(); // initialise scene
```

You need to **add** the following code:
```
animate(); // updates scene by constant rendering
```

Note that functions are defined within ```{}```. Be careful of where these are when pasting code.

**Within** the init function definition **after** the following code:
```
document.body.appendChild( container );
```

You need to **add** the following code:
```
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

```

You need to add the animate and render function definitions. 

**After** the init function definition, i.e. after the following code:
```
container.appendChild( renderer.domElement );
}
```
You need to **add** the following code:
```
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

You will add the standard EventListener for responding to window size changes. If you try and make your browser window bigger now you will see that it is not changing the container size. Three.js uses window event listeners to detect user interactions with their browser. Here you will only listen for window resizing (```resize```), but in part 2 you will listen for mouse clicks (```click```) and drags (```dragstart``` and ```dragend```). Other possible input events include mouse movement (```mousemove```) and keys being pressed on the keyboard (```keyup``` and ```keydown```). The window event listeners have 2 arguments. The first identifies the input event (i.e. ```resize``` for resizing), and the second the function that will be called (run) if the event occurs. The standard window resize function code gets the new browser dimensions from the global object 'window' and updates the camera aspect and the dimensions of the picture the renderer is drawing. As 'window' is a global object, it is better to never call any of your variables 'window'.

**Within** the init function definition **after** the following code:
```
container.appendChild( renderer.domElement );
```
You need to **add** the following code:
```
// add listeners. These check for user interaction with the window and mouse clicks and call the given function.
// listen for user browser window resizing and call the onWindowResize function that is defined below.
window.addEventListener( 'resize', onWindowResize );
```
**After** the init function definition, i.e. after the following code:
```
window.addEventListener( 'resize', onWindowResize );
}
```
You need to **add** the following code:
```	
// called on resizing of window. Gets new browser window values and updates camera and renderer settings. Don't experiment with.
function onWindowResize() {
 camera.aspect = window.innerWidth / window.innerHeight; 
 camera.updateProjectionMatrix();
 renderer.setSize( window.innerWidth, window.innerHeight );
}

```
If you save the file and reload the browser, a browser window resize should now work.

Next you need to add lights.

There are several different types of lights. You will add a [hemisphere light](https://threejs.org/docs/index.html#api/en/lights/HemisphereLight) and a [directional light](https://threejs.org/docs/index.html#api/en/lights/DirectionalLight). The hemisphere light has 2 colours and an intensity (from 0 to 1), while the directional light has one colour and a position. Use the values supplied first. If everything is working, you can experiment with different values later. You can add lights directly, as with the hemisphere light, or declare them, modify their parameters and then add them, as with the directional light.

**Within** the init function definition **after** the following code:

```
camera.position.set( 0, 1.6, 3 ); //x, y, z
```

You need to **add** the following code:

```
// add a hemisphere light and a directional light
scene.add( new THREE.HemisphereLight( 0xffffbb, 0x080820, .5) ); // arguments: sky colour, ground colour, intensity
const light = new THREE.DirectionalLight( 0xffffff ); // argument: colour
light.position.set( 1, 6, 2 ); // x, y, z 
scene.add( light );
```

Next you will import two model loaders and use them to add the model. Three.js can load several different file types. DRACO compressed glTF files require the importation of an additional loader (DRACOLoader) which uncompresses the model mesh. The created DRACOLoader needs to retrieve the code from a webserver and the path used must match the version of three.js that you are using. If you are not using version 160.0, you need to change the number in the path.

**After** the following line of code:

```
import * as THREE from 'three';
```

You need to **add** the following code:

```
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';
import { DRACOLoader } from 'three/addons/loaders/DRACOLoader.js'; // needed if draco compression on gltf
```

**After** the following line of code:

```
let container, camera, scene, renderer;
```

You need to **add** the following code:

```
let themodel;
let desk = 0.8; // the height of the model (metres), desk height in virtual reality

// Loader set up 
// Different model formats use different loaders
const loader = new GLTFLoader();
const dracoLoader = new DRACOLoader();
dracoLoader.setDecoderPath( 'https://unpkg.com/three@0.160.0/examples/jsm/libs/draco/' );
loader.setDRACOLoader( dracoLoader );

```

**Within** the init function definition **after** the following code:

```
scene.add( light );
```

You need to **add** the following code:

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

The model is loaded with the load method, which can take 4 arguments. The first argument is the file name, which must include its 'path', i.e. any folders it is in (e.g. 'models/png_sceneDRACO.glb'). It can also be a URL. The other three arguments are for "callback" functions (functions passed as arguments to other functions) that will be called in three different cases: after loading the model, while the model is loading, and if there is an error loading the model. 

Here you have defined the onLoadMap function separately in the function definitions. You have left the on progress function 'undefined', but sometimes a function is used that creates a loading bar or similar indication to the user that something is happening, especially if the model is large and will take some time to load. The error function is defined here anonymously (without a name) and will print the error to the browser console. 

The onLoadMap function takes the filename and extracts the model using '.scene'. Using 'gltf.scene' instead of 'gltf.scene.children[0]' will also work for this model example due to how this glTF file is internally arranged. glTF files can have hierarchies of groups and meshes (as you saw in the scene tab of the three.js editor), and for some purposes it does not matter if the object being imported is a group or a mesh, but for others (like raycasting, which will be used in part 2) it does. Sometimes it is better to import the children of the scene and indexing starts with 0. 

You can also position, scale or rotate the model in the onLoadMap function. You can experiment with changing the x, y or z values for position or scale and see the effects. When this JavaScript code is running it will not wait until the model has loaded before going on to the next bit of code in the init function. 

By putting instructions, such as changing the model scale, in a function that is only called after the model is loaded, you avoid the potential problem of having the code try and change a model before it has finished loading.

### Adding Camera Controls to Move Around

You can add mouse controls to allow us to move around the scene. Some controls, including [orbit](https://threejs.org/examples/?q=controls#misc_controls_orbit), [map](https://threejs.org/examples/?q=controls#misc_controls_map), [fly](https://threejs.org/examples/?q=controls#misc_controls_fly), [pointer lock](https://threejs.org/examples/?q=controls#misc_controls_pointerlock) and [trackball](https://threejs.org/examples/?q=controls#misc_controls_trackball), change the position of the camera. Others, such as [drag](https://threejs.org/examples/?q=controls#misc_controls_drag) and [transform](https://threejs.org/examples/?q=controls#misc_controls_transform), can alter the position of objects.  

You will first use 'orbit' controls that allow the user to navigate the scene with rotation (when the mouse is clicked and dragged), panning (when the mouse is clicked and dragged while pressing the shift key, or using the right mouse button) or zooming (with mouse scrolling). You need to import any controls.

**After** the following line of code:

```
import { DRACOLoader } from 'three/addons/loaders/DRACOLoader.js';
```

You need to **add** the following code:

```
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
```

Next you'll need to add the controls to the 'let' declaration. Inn the init function, you can create them and link them to the camera and renderer. The target.set method determines the centre that the camera will rotate around.


**Find** the following code:

```
let container, camera, scene, renderer; 
```


The line of code above should be **changed** to the following:


```
let container, camera, scene, renderer, controls;
```

**Within** the init function definition **after** the following code:

```
container.appendChild( renderer.domElement );
```

You need to **add** the following code:

```
// create orbit controls
controls = new OrbitControls( camera, renderer.domElement);
controls.target.set( 0, 1.6, 0 ); // sets the scene rotational centre
controls.update(); // updates controls settings after creation
//controls.autoRotate = true; // set to true if camera is to rotate automatically BUT you must then call controls.update() in render function.

```

If you save and reload, you should be able to move around and zoom in and out. Note that the model is not being rotated, moved or resized, but it is the camera that is being moved.  

If you want the camera to continuously rotate, you can uncomment out the ```controls.autoRotate``` but you must also add the call to update the controls in the render function, i.e.

**Find** the following code:

```
function render() {
 renderer.render( scene, camera );
}
```


The **lines** of code above should be **changed** to the following:
 

```
function render() {
 controls.update(); // use if controls.autoRotate = true
 renderer.render( scene, camera );
}

```

Node.js will let you see your webpage but if you want to deploy your page so that everybody can access it, you can use (the free services) [GitHub Pages](https://pages.github.com) or [Vercel](https://vercel.com/). You could deploy your site using the instructions on GitHub or Vercel. There are GitHub [starter tutorials](https://docs.github.com/en/get-started/start-your-journey/hello-world) or if you use software such as [GitHub Desktop](https://docs.github.com/en/desktop) to manage your GitHub repositories read [this GitHub Desktop tutorial](https://docs.github.com/en/desktop/overview/creating-your-first-repository-using-github-desktop). You get one free GitHub page per GitHub account, i.e. my page at https://github.com/tosca-har/tosca-har.github.io results in a website at https://tosca-har.github.io/. To deploy code, follow the instructions on [GitHub Pages]([https://pages.github.com](https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site)) and/or [Vercel](https://vercel.com/). The Programming Historian lesson [Building Static Sites with Jekyll and GitHub pages](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages) has more detailed guidance.

You can investigate the [three.js manual](https://threejs.org/manual/#en/how-to-create-vr-content) for making the site viewable in virtual reality (VR).

Part 1 has introduced 3D models and their components: meshes, materials and textures. There are a growing number of both realistic and symbolic, global cultural heritage models and making these models accessible via websites can be a valuable tool in communicating archaeological and historical research. As with any communication of research on cultures not your own, especially those that have been subject to colonisations, it is necessary to consider the rights of the represented communities and to be open to their feedback. In this lesson you used three.js to create a website with a model featuring some of the different ceramic vessels of Papua New Guinea. If you examined the model you would have observed the diversity in decoration styles and forms used by the various communities, and may have noted similarities between some and considered whether this indicated a shared history or knowledge exchange between communities. Communicating further information can be done through annotating parts of the model. This can be undertaken using platforms such as SketchFab, and the use of such platforms can be easier and quicker than writing JavaScript code. However, using JavaScript libraries, such as three.js, gives you more flexibility and options for your website. If you undertake Part 2 of this lesson, you will see how you can bring the jar models in separately, control their different colours and allow them to be selected by a user triggering the display of a relevant text panel. You will learn how three.js can be used to turn the scene into a game where the jar models start at random positions and can be independently moved. You will explore how code can be written to check if models have been moved to certain location and trigger visual feedback to the user if the location is correct. Three.js is one way that 3D models of cultural material can be made more engaging and effective at conveying historical research knowledge and concepts. 

## References

D’Andrea, A., Conyers, M., Courtney, K.K., Finch, E., Levine, M. Rountrey, A., Kettler, H.S., Webbink, K. 2022. "Copyright and Legal Issues Surrounding 3D Data." In 3D Data Creation to Curation: Community Standards for 3D Data Preservation, eds. Moore, J., Rountrey, A., Kettler, H.S. Chicago: Association of Research and College Libraries (ALA).

Dolbunova, E., Lucquin, A., McLaughlin, T.R., Bondetti, M., Courel, B., Oras, E., Piezonka, H., Robson, H.K., Talbot, H., Adamczak, K., Andreev, K., Asheichyk, V., Charniauski, M., Czekai-Zastawny, A., Ezepenko, I., Grechkina, T., Gunnarssone, A., Gusentsova, T.M., Haskevych, D., Ivanischeva, M., Kabacinski, J., Karmanov, V, Kosorukova, N., Kostyleva, E., Kriiska, A., Kukawka, S., Lozovskaya, O., Mazurkevich, Z., Nedomolkina, N., Piliciauskas, G., Sinitsyna, G., Skorobogatov, A., Smolyaninov, R.V., Surkov, A., Tkachov, O., Tkachova, Ml, Tsybrij, A., Tsybrij, V., Vybornov, A.A., Wawrusiewicz, A., Yudin, A.I., Meadows, J., Heron, C., Craig O.E. 2023. The Transmission of Pottery Technology Among Prehistoric European Hunter-Gatherers. Nature Human Behaviour. 7:171. 

Gaffney, D., Summerhayes, G.R., Ford, A., Scott, J.M., Denham, T., Field, J., Dickinson, W.R. 2015. Earliest Pottery on New Guinea Mainland Reveals Austronesian Influences in Highland Environments 3000 Years Ago. PLoS ONE 10(9):e0134497.

Holtorf, C. 2005. From Stonehenge to Las Vegas. Archaeology as popular culture. Walnut Creek: AltaMira Press.

Marek, H.M. 2022. Navigating intellectual property in the landscape of digital cultural heritage sites. International Journal of Cultural Property. 29:1.

Maschner, H. July 2022 (https://sketchfab.com/blogs/community/cultural-heritage-spotlight-global-digital-heritage/?utm_source=website&utm_campaign=newsfeed)

May, P., Tuckson, M. 2000. The Traditional Pottery of Papua New Guinea. Crawford House Publishing, Adelaide.

Native American Graves Protection and Repatriation Act. 1990-2023, Pub. L. No. 101-601, 104 Stat. 3048. Amended 2023 Document Citation:88 FR 86452. 86452-86540.

O'Brien, M.J., Lyman, R.L., Collard, M., Holdern, C.J., Gray, R.D., Shennan, S.J. 2008. Transmission, Phylogenetics and the Evolution of Cultural Diversity. In: Cultural Transmission and Archaeology: Issues and Case Studies. Society for American Archaeology. Washington.

Oruç, P. 2020. 3D Digitisation of Cultural Heritage: Copyright Implications of the Methods, Purposes and Collaboration, 11 JIPITEC 149 para 1.  

Pétrequin, A.-M., Pétrequin, P. 2006. Objets de Pouvoir en Nouvelle Guinée: Approche Ethnoarchéologique d’un Système de Signes Sociaux: Catalogue de la Donation Anne-Marie et Pierre Pétrequin. Réunion des Musées Nationaux, Paris.

Rahaman, H. 2021. Photogrammetry: What, How, and Where”, in: Champion, Erik M. (ed.): Virtual Heritage: A Guide. London: Ubiquity Press 25-37.

Shaw, I., Leclerc, M. 2023. Unearthed: Art in Archaeology and Anthropology. ISBN 978-0-6453425-0-5.

