---
title: "Building Interactive Environments for 3D Models with three.js (Part 2)"
slug: building-3d-environments-threejs-pt-2
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
difficulty: 2
activity: presentation
topics: web development, 3d modeling
abstract: This lesson is the second part of a two-part lesson on using the three.js JavaScript library to create interactive websites featuring 3D cultural heritage models. In this Part 2, readers will learn how to enable user selection of the different models of ceramic vessels to trigger the display of informative text. Additional interactive features instructt how to make the website into an interactive game.
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction
In Part 1 of this lesson, you used three.js to create a website featuring a camera and a scene with lights, camera navigation controls, and a model featuring multiple jars on a map of New Guinea. In Part 2, we show how to make the 3D model more interactive. To do so, you will learn how to make and import the various model components separately.

The model in Part 1 ([seen here in SketchFab](https://skfb.ly/putNM)), featured a selection of the over 100 vessel types historically made in the New Guinea region. Digital scenes with models of cultural heritage can visually convey information, such as similarities and differences in form across a geographical area. Annotating elements of the model using text (or media such as images), can increase the ability of digital models to convey information and ideas on the history and culture of a region or era.

The primary goal of Part 2 of this lesson is to teach how to use three.js to create a webpage featuring a 3D scene with selectable components. The lesson will involve creation of a simplified version of the Papua Jar model (featuring 6 jars) where the individual jars are selectable, and selecting a jar triggers the display of a panel with information about the language of the maker community, how the jar was made and what it was used for. As discussed in Part 1, there are other software tools to create such scenes. The advantage of using three.js (or other JavaScript libraries) and in working with the separate components of the model (i.e. the separate jar models), is that you have more flexibility and control over the scene. In this lesson you will create a colour key to show the viewer the technique the potters used to make the pot and this will allow you to see how you can change properties such as colour at the code level. Scene creation will involve adding lights, cameras, primitive models (such as spheres and planes), complex models (the pot forms), and controls. The models will be enhanced with additional materials and image textures (introduced in Part 1). To explain these steps, this lesson will introduce such concepts as 3D co-ordinates and model groupings, scale and visibility.   

An additional (optional) goal of Part 2 is to change the webpage into a game by making the models moveable. The interactive game makes the initial position of the jars randomly determined and requires the user to match the vessel to its maker community by moving it to the correct geographical position. You will learn how to set up a simple test in the code so that each time a model is moved, the application will verify if the model has been placed in the correct position associated with its provenance. Successful matches will be set to trigger a background colour change denoting the proper placement.

## Setting Up
In addition to the technical requirements in Part 1, for Part 2 of this lesson, you will need to download the [`/models` folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/building-3d-environments-threejs-pt-1-2/models) containing the individual jar models, and the [`/textures` folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/building-3d-environments-threejs-pt-1-2/textures) with information about them, from this lesson's [`/assets` folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/building-3d-environments-threejs-pt-1-2). 

Put (or replace) the downloaded models and textures folders in the myscene folder (Figures 1-2). Keep the index.html and main.css files that you created in Part 1. If you did not do Part 1, you need to the download index_pt1_complete.html and main.css files from the [`/assets` folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/building-3d-environments-threejs-pt-1-2), rename the index_pt1_complete.html file to index.html and place them in a folder called myscene.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-01.png" alt="Screenshot of the VSC editor showing a list of glb files in the expanded models folder." caption="Figure 1. File structure for Part 2 as shown in VSC, with the models folder expanded. The index.html file is shown in the main panel." %}

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-02.png" alt="Screenshot of the VSC editor showing a list of jpg files in the expanded textures folder." caption="Figure 2. File structure for Part 2 as shown in VSC, with the textures folder expanded. The texture file Abelam.jpg is shown in the main panel." %}

If you made ```autoRotate``` true in Part 1, comment out that line (i.e. add ```//``` to the beginning of the line). In addition, comment out the ```controls.update``` in the render function (make sure not to touch the one in the init function). 

Next, in the index.html file from Part 1, remove the code that loads the glTF model that was used in Part 1. In other words, remove the following lines of code:

```
// load model
// function used for loader
function onLoadMap( gltf ) {                
  themodel = gltf.scene.children[0];
  themodel.position.set( 0, desk, 0); // x, y, z
  themodel.scale.set( 1, 1, 1); // x, y, z
  scene.add( themodel);
}
// the loader is given the model file name (first argument) which is passed to the function (second argument), function to do while loading (3rd argument), function called if error (4th argument).
loader.load( 'models/png_sceneDRACO.glb', onLoadMap, undefined, function ( error ) {console.error( error );} ); 
```

In the next section of this lesson, we will explain how you should plan out and design your interactive scene before building it. You do not have to attempt to draw the plan for this scene or game but viewing the scene mock-ups can help you understand what the different components in this lesson and provides an example of what you should do when you are designing your own scenes or games.

## Using Mock-ups to Plan a Scene or Game

You will remember from Part 1 that scenes have a camera, light(s) and models and that you specify where these are placed in 3D space. If you do not remember the 3 (x, y and z) axes (the red, green and blue arrows) in the [three.js editor](https://threejs.org/editor/), you may want to reopen it, or examine Figures 5-10 in Part 1. In Part 1 you worked with one model. When you have multiple models it is useful to draft out where components such as the camera, lights and models will be placed. You can do this with pen and paper and using grid or dotted paper can be useful. Additionally, you can mock-up views using whatever vector graphics software you are familar with to create figures (Inkscape, Affinity Designer, Adobe Illustrator, Canva, or Powerpoint). When designing your own interactive scenes or games, you should draw the three different 2D views, the "front-view", "side-on view" and "birds-eye view". Figure 3 shows mock-up views for the game version of the scene that will be created in the second part of this lesson. You will see in the mock-ups that the scene x, y and z axes are clearly identified with their positive and negative directions indicated.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-03.png" alt="Scene mock-ups in z, x and y views." caption="Figure 3. Affinity Designer versions of the hand-drawn sketches for planning the game. Mock-ups of all 3 views are done, with rough coordinates and spacing for the scene assets (here the camera, light, the map, information panels and a key panel featuring 9 spheres, the jar/site positions, and the area in which the jars will randomly start in the game). Coordinates are x, y, z. Note that the light is off the scale in the y axis." %}

Mock-ups are good for identifying what assets (models and textures) you will need. In Part 1 you used 1 model which featured a geographical map and 29 jars, but in this lesson you will import the components of that model separately. For simplicity you will only work with 6 jar models but can add the other 23 at the end if you wish. You will also have 3 panels that show instructions, references and information on the jars. You will add 9 spheres to the panel on the right to form part of the colour key used for identifying how the jars were made by the potters. The middle gallery panel will provide instructions or information on the selected jar, so it will change depending on what jar is selected. Thus, there will actually be another 6 panels created but not initially visible. In the scene the jars will be placed on the map at the location in Papua New Guinea where they were made (this is indicated by the 'sites' in Figure 3). In the game the jars will start in an area above the map and the sites of construction will be indicated on the map by 6 tori (donuts). Tori can be harder for game users to select than discs, but many Papua New Guinea communities use tori made of leaves to hold the vessels as they are being made. You can see the Agarabi speaking potter Uneri Ankimpa using a torus-shaped kawe'aron [here](https://ars.els-cdn.com/content/image/1-s2.0-S0278416522000873-gr4_lrg.jpg) (image from Hardy et al 2023).

In the mock-ups, the x, y and z co-ordinates are given for the different components and rough measurements of distances between objects and their proportions. Planning your scene will help you identify where you will be using the same value repeatedly, such as the x and z positions of the key spheres. You can use variables for these values, so that it is easier to alter all instances together. 

Planning out your scene will also help ensure you identify where measurements are dependent on other measurements. As you can see in the first mock-up of Figure 3, the height of the galleries is dependent on the height of the map, because they need to be above the map. You can set a variable 'desk' for the map height and a variable 'gheight' for the gallery height that is dependent on the desk variable (i.e. equal to desk + 0.55). 

The placement of the map at this y value was because the site was designed to be able to be viewed in VR. 0.8m is a comfortable height for a standing person to look down onto a map and be able to place objects onto it. Three.js uses metres as the measurement unit, although this is only important if you plan to have your site viewable in virtual reality (VR).

## Using the three.js Basic Geometries: Adding the Spheres for a Colour Key
If you do not have the local server running, save the index.html file and start the server in the terminal with the following command:

```
npx serve
```

If you visit the served website in your web browser (generally http://localhost:3000 but check the address given in the terminal), you should be back to an empty scene with a peach background.

If you re-examine the [SketchFab version](https://skfb.ly/putNM) of the model used in Part 1 you will notice the jars are different colours. These colours relate solely to what techniques were used to make the jar. For example kabe the cooking vessels made by Agarabi speakers are constructed with [coiling then beating](https://ars.els-cdn.com/content/image/1-s2.0-S0278416522000873-gr4_lrg.jpg) (Hardy et al 2023), while bodi made by Bilibil speakers are started with a [clay lump and finished by paddle and anvil shown in Figures 4 and 9 in Gaffney 2017](https://www.researchgate.net/publication/320023544_Maintenance_and_Mutability_amongst_Specialist_Potters_on_the_Northeast_Coast_of_New_Guinea/figures). In the SketchFab model the vessels using these two construction techniques are coloured yellow and dark blue, respectively. 

To communicate these techniques to the website viewer, you will construct a key featuring a plane and coloured spheres. The plane will have an image texture that will list the construction techniques and the image does actually have coloured circles to indicate the model colour. However by putting coloured spheres where the coloured circles are the colours of the jars can be easily modified without the need to make a new image texture. The addition of spheres is also an introduction to the use the three.js basic geometries.

Meshes have geometries and three.js has several basic 2D geometry types, including [plane](https://threejs.org/docs/#PlaneGeometry), [circle](https://threejs.org/docs/#CircleGeometry), [ring](https://threejs.org/docs/#RingGeometry) and [shape](https://threejs.org/docs/#ShapeGeometry), and more 3D geometry types that include [spheres](https://threejs.org/docs/#SphereGeometry), [boxes](https://threejs.org/docs/#BoxGeometry), [tori (donuts)](https://threejs.org/docs/#TorusGeometry), [cylinders](https://threejs.org/docs/#CylinderGeometry) and [tetrahedrons](https://threejs.org/docs/#TetrahedronGeometry) (Figure 4). The parameters for these generally include lengths (in metres) and numbers of segments (for height, width, etc), but they can also be given parameters to create partial shapes. There are also some more complicated geometries, including [lathes](https://threejs.org/docs/#LatheGeometry), that will not be used here, that are made from a series of user provided 2D points, that are rotated around the y axis to make a 3D shape.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-04.png" alt="Six different geometry types: sphere, box, cylinder, torus and lathe are shown in wireframe." caption="Figure 4. The 3D geometries that three.js can add include spheres, boxes, tori, cylinders, tetrahedrons and lathes. Parameters for the geometries often include length and segment number measurements. Lathe geometries are generated from a series of points (that are then rotated) and the most simple lathe is shown." %}

You will use a plane and 9 spheres (in a vertical line) to make a vessel colour key for how the jars were made. 

The colours are set in the parameters list (more correctly called an 'array' in JavaScript). By having them in a parameter list, by changing the respective hex code, the key and jars will all change. Start with the proposed values and alter them later if you want.

For each sphere you also set its position in x, y, z order. You use the variables ```sphereposx``` and ```sphereposz``` for the x and z positions, and vary the y position, so the spheres end up in a vertical line. You declare variables for the panel vertical placement (relative to the panel centre), and the sphere x and z positions. 

You can use ```let``` or ```const``` to declare variables, the difference is that variables declared with ```const``` can not be changed later in the code, and must have a value when declared. Many of these variables could be declared within the init function, but having them all together at the start of the code makes them easier to find and change.

To declare the variables, **after:** the following line of code:

```
let desk = 0.8;
```

You need to **add** the following code:

```
let gheight = desk + 0.55; //panel height
let sphereposx = 0.84 // key sphere x position
let sphereposz = -0.75 // key sphere z position

// colours for the key spheres and the jars
const parameters = { 
  materialColor: '#9c5315', // brown
  coilColor: '#ff0000', // red
  ringTopColor: '#19ffE7', // light blue
  coilBeatenColor: '#e8e337', // yellow
  nabColor: '#209F00',  // green
  wangelaColor: '#BEBEBE',  // light grey
  paddleColor: '#1e2f97', // dark blue		
  paddleAddColor: '#a61ef4', // purple
  amphColor: '#fc9483' // pink
}

```

Then you need to create the 9 sphere meshes. To create a sphere mesh from a basic three.js geometry you first need to create an instance of a sphere 'geometry'. This geometry is given values (called arguments) that specify the radius size (you will use 0.04 m) and the number of width and height segments (use 15 and 5 respectively). You can see how the geometries have segments in Figure 4 and if you increase the number of width or height segments, you will get rounder spheres.

Geometries can be reused, so you will create an instance of the SphereGeometry and call it ```sphere``` and use it to create 9 different sphere meshes. Each sphere mesh gets assigned a [material](https://threejs.org/docs/#Material) with a colour. This code uses the [standard material](https://threejs.org/docs/#MeshStandardMaterial). There are alternatives that can be used, and it is important to note that some material types are more dependent on lights than others.

In summary the following code will:
* create the sphere geometry, specifying its radius and number of width and height segments; 
* for each of the 9 spheres, make a mesh from the created geometry and a standard material (with a colour from the parameter list); 
* add all the spheres to the scene. 

**Within** the init function definition **after** the following code:

```
scene.add( light );
```

You need to **add** the following code:

```
// add models

// add key for jar colours using spheres and a plane
//spheres for key
const sphere = new THREE.SphereGeometry( 0.04, 15, 5); //radius in metres, width segments, height segments. Will be reused.
const sphere1 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.materialColor })); 
sphere1.position.set( sphereposx, gheight + 0.30, sphereposz);
const sphere2 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.coilColor })); 
sphere2.position.set( sphereposx, gheight + 0.21, sphereposz);
const sphere3 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.ringTopColor})); 
sphere3.position.set( sphereposx, gheight + 0.12, sphereposz);
const sphere4 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.coilBeatenColor})); 
sphere4.position.set( sphereposx, gheight + 0.03, sphereposz); 
const sphere5 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.nabColor })); 
sphere5.position.set( sphereposx, gheight - 0.06, sphereposz); 
const sphere6 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.wangelaColor })); 
sphere6.position.set( sphereposx, gheight - 0.15, sphereposz); 
const sphere7 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.paddleColor})); 
sphere7.position.set( sphereposx, gheight - 0.25, sphereposz); 
const sphere8 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.paddleAddColor})); 
sphere8.position.set( sphereposx, gheight - 0.35, sphereposz); 
const sphere9 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.amphColor })); 
sphere9.position.set( sphereposx, gheight - 0.44, sphereposz); 
scene.add( sphere1, sphere2, sphere3, sphere4, sphere5, sphere6, sphere7, sphere8, sphere9 );
    
```

Save the index.html file and reload in the browser and you should see a webpage with nine differently coloured spheres (Figure 5). 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-05.png" alt="Webpage with 9 spheres of different colours in a vertical line." caption="Figure 5. Webpage with nine differently coloured spheres." %}

### Texturing Planes: Adding the Information Panels and Map
You will now add the panel for the key (gallery2, on the right) and the other 2 information panels that the viewer will see at the start: the references (gallery3, on the left) and the instructions (gallery, middle). The panels will be simple 2D planes that you will add textures to. The left and right panels will not change. However the central instruction panel will disappear when the user clicks a jar and the information panel for that community will appear. You will do this by toggling the visibility of different panels off and on instead of changing the texture on the plane (which would also be implementable).

You want the information panels to face the camera, and the default planes do this. You will give the planes image ‘textures’ that contain text describing the individual artefacts. These textures are jpeg and png files and they all have pixels dimensions of 2<sup>n</sup> by 2<sup>n</sup>, eg 4096 × 2048. This helps with efficient rendering. The larger the image files, the longer they take to load, and very large images may not load at all. By default only one side (the 'front') of a panel is textured. Here the dimensions of the panels match the image texture dimensions. In situations where they do not match, different options, including image tiling can be used. 

The use of images with text (created and exported from any graphics program such as Affinity Designer or PowerPoint) is one way to show text. There are [alternatives](https://threejs.org/manual/#en/creating-text). 

Textures need to be loaded by a ```TextureLoader```. After loading each texture a set of lower-resolution images (a [mipmap](https://en.wikipedia.org/wiki/Mipmap)) gets generated for it. The renderer will automatically use one of the lower-resolution images for when the texture appears small or far away. Using lower-resolution images for areas covering less pixels is not only more efficient, it can prevent image 'shimmering'. Mipmap creation is one of the reasons for using images of 2<sup>n</sup> by 2<sup>n</sup> dimensions, but the creation of the down-sampled image sets takes processing time. 

First you declare the variables, **after** the following code:

```
// Variable declaration and setting
```

You need to **add** the following code:

```
let psize = 1.0; // panel dimensions
let gallery, gallery2, gallery3;			
```

Then you will make a textureLoader and load the 3 textures. For each of the 3 panels, you will make a mesh with one of the textures, and move the panel to the correct place.

**Within** the init function definition **after** the following code:

```
// add models
```

You need to **add** the following lines:

```
// add introduction, key and reference panels by loading textures then adding planes .
// load textures and generate Mipmaps
const textureLoader = new THREE.TextureLoader();
const introTexture = textureLoader.load( 'textures/Intro.jpg' );
introTexture.generateMipmaps = true;
const refTexture = textureLoader.load( 'textures/sources.jpg' );
refTexture.generateMipmaps = true;			
const keyTexture = textureLoader.load( 'textures/key.jpg' );
keyTexture.generateMipmaps = true;
    
// add introduction information panel
gallery = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: introTexture }));
gallery.position.set( 0, gheight, sphereposz); 
// add the panel for the key
const gallery2 = new THREE.Mesh(new THREE.PlaneGeometry( psize, psize ), new THREE.MeshBasicMaterial({ map: keyTexture }));
gallery2.position.set( 1.25, gheight, sphereposz); 
// add the panel for the references
const gallery3 = new THREE.Mesh(new THREE.PlaneGeometry(psize, psize  ), new THREE.MeshBasicMaterial({ map: refTexture }));
gallery3.position.set( -1.25, gheight, sphereposz); 

scene.add( gallery, gallery2, gallery3);

```

If you save the index.html file and reload the browser you should see the three panels, and the spheres should be on the panel on the right. If the panels are black, the images are probably in the wrong directory. It should look like Figure 6, but without the map.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-06.png" alt="Webpage with 3 square panels of text and a horizontal map of Papua." caption="Figure 6. Webpage with three vertical information panels and a horizontal map." %}

Next you will create all the information panels for all the jars. You will design the webpage so the panels will be hidden (by making ```.visible = false```) until the relevant jar is selected by the user. You will set a variable, ```selectedPlane```, to track which panel is showing; at the start an instruction panel will be selected. 

To help keep track of the information panel (gallery), jar model, loading function and community site for each jar, you will call these 'xG, 'xM', 'onLoadX' and 'xSite', respectively, where 'x' is a name such as 'yabob' or 'aibom', the village (or area) where the jar the model is based on was made. Variable and function names can not have spaces in them.

First you declare the variables, **after** the following code:

```
// Variable declaration and setting
```

You need to **add** the following code:

```
let adzeraG, aibomG, mailuG, dimiriG, louisadeG, yabobG; // information panels for the different jars
let selectedPlane;	// which information panel will be visible			
```

If you look at the gallery code you will see some repetition and for the 6 jar information panels the code would be more similar as they are in the same position. Thus, for the jar information panels you will create a function that receives the filename of the image texture, loads the texture, creates the mipmap, creates a plane mesh with that texture, sets the mesh position and makes it invisible. Your function (called ```createGallery```), will ```return``` a textured plane mesh and assign it to the named variable (i.e. ```adzeraG```). 

**Within** the init function definition **after** the following code:

```
scene.add( gallery, gallery2, gallery3);

```
You need to **add** the following code:

```
selectedPlane = gallery; // start with the instructions.

// add the jar information panels then make them not visible
function createGallery(filename){
  const aTexture = textureLoader.load( filename );
  aTexture.generateMipmaps = true;
  const model = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: aTexture }));
  model.position.set( 0, gheight, sphereposz); 
  model.visible = false;
  return model;
}

// 'call' the createGallery function for the information panels/galleries.
adzeraG = createGallery('textures/Adzera.jpg');
aibomG = createGallery('textures/Aibom.jpg');
mailuG = createGallery('textures/Mailu.jpg');
dimiriG = createGallery('textures/Dimiri.jpg');
louisadeG= createGallery('textures/Louisade.jpg');
yabobG = createGallery( 'textures/Yabob.jpg');
scene.add( adzeraG, aibomG, mailuG, dimiriG, louisadeG, yabobG);
```

You will need a plane for the map for the jars to sit on. As planes are added 'upright' by default, this plane has to be rotated 90 degrees (- Math.PI /2) around the x axis. 'Math' is a JavaScript object, which has properties, including Math.PI (i.e. π, 3.141), and methods, including Math.random() (used later in the lesson). See the [mdn web docs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math) for more properties and methods. 

Three.js uses [radians](https://en.wikipedia.org/wiki/Radian) for its rotational units. As π (3.141) radians is 180 degrees, 90 degrees is Math.PI/2. Rotation occurs in the counter-clockwise direction (when you are 'looking' towards the negative axis values), so for the way this scene is set up, the rotation of the plane for the geograpical map must be -Math.PI/2 around the x axis to have the 'front' of the panel facing upwards.

Add the map to the variables. Also add a ratio that allows experimentation with the map size. 

**After** the following code:

```
// Variable declaration and setting
```

You need to **add** the following code:

```
let theMap;
let ratio = 2; 
let piecescale = ratio; 
            
```
**Within** the init function definition **after** the following code:

```
scene.add( adzeraG, aibomG, mailuG, dimiriG, louisadeG, yabobG);
```

You need to **add** the following code:

```
// add the map of New Guinea
const mapGeometry = new THREE.PlaneGeometry( 3 * ratio, 1.5 * ratio );
const mapTexture = textureLoader.load('textures/png.png'); // from google maps
mapTexture.generateMipmaps = true; 
theMap = new THREE.Mesh( mapGeometry, new THREE.MeshBasicMaterial({ map: mapTexture }));
theMap.rotation.x = - Math.PI / 2; // Equal to 90 degrees
theMap.position.set( 0, desk, 0); // desk height
scene.add( theMap);

```

Save the index.html file and reload the web browser. The map should appear with the panels (Figure 6).



### Adding the Jar Models
As you saw in Part 1 of this lesson, the jar models are made of meshes (Figure 7).

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-07.png" alt="Framework of a jar with a sculptured face." caption="Figure 7. Mesh of the Aibom jar." %}

As with the spheres, the jars will get a standard material with a colour that matches one of those in the colour key (Figure 8). 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-08.png" alt="Jar with a sculptured face coloured brown." caption="Figure 8. The Aibom jar with a solid brown colour." %}

Materials such as the standard material (that is being used) have emissive properies that can be turned on, making them appear to have a coloured glow. You will later change the red emissive property of the material to show if a jar is selected (Figure 9).

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-09.png" alt="Jar with a sculptured face brightly coloured red." caption="Figure 9. The Aibom jar with red emission." %}

The jars will be added to a group (called ```jars```) and the group will be added to the scene. This will allow us to specify later that objects belonging to the jars group can be selected. 

Each jar will get a [userData](https://threejs.org/docs/?q=userdata#Object3D) property that will point to the information panel that is associated with it, so that when it is selected that panel can be shown. Three.js 'userData' properties do not have to be declared, they are default empty objects and you can create more than one. At this stage, you will create ```aibomM.userData.planes```, but you could also create additional ones such as ```aibomM.userData.somethingelse``` and ```aibomM.userData.anotherthing```.

Note that the introduction of the ```piecescale``` variable is not strictly necessary, as it is set to the same as the ratio, but it can be changed later to alter the relative size of the jars in relation to the map.

Model loading will be written in 3 different ways. All these ways are actually the same, but with different degrees of code condension. 

To begin, you will add one model, aibomM, in a similar way to how you added the composite model in Part 1. A function is defined ```onLoadAibom``` that runs after the .glb file is loaded by the loader's load method. 

As mentioned in Part 1, you need to put the positioning and scaling of the model in this function so that they only occur after the model has finished loading. Remember that the load method has 5 arguments: the model filename; a function run after the model is loaded; a function run while the model is loading; and a function run if there is an error.  

As in Part 1, you will leave the function that runs while the model is loading ```undefined``` and have an anonymous (unnamed) function that is run if there is an error with the loading.

You replace the declaration of the model with declarations of the jars and their group. **Find** the following code:

```
let themodel;

```

The line of code above should be **changed** to the following:

```	
let jars;
let aibomSite, dimiriSite, louisadeSite, mailuSite, adzeraSite, yabobSite;
let adzeraM, aibomM, mailuM, louisadeM, dimiriM, yabobM;

```

Then you make the empty group and add it to the scene. You will create the ```onLoadAibom``` function that will run after loading, and then you will call the ```loader.load method```.

**Within** the init function definition **after** the following code:

```
scene.add( sphere1, sphere2, sphere3, sphere4, sphere5, sphere6, sphere7, sphere8, sphere9 );
```

You need to **add** the following code:

```
// add jar models. Added in group so they can be selected.
jars = new THREE.Group();
scene.add( jars );

// jar/site positions
aibomSite = { x: 0.36, z : -0.01 }
mailuSite = { x: 0.84, z : 0.48 }
louisadeSite = { x: 0.99, z : 0.59 }
adzeraSite = { x: 0.61, z : 0.15 }
dimiriSite = { x: 0.43, z : 0 }
yabobSite = { x: 0.572, z :  0.0396 }

// loading function for Aibom jar model
function onLoadAibom( gltf ) {				
  aibomM = gltf.scene.children[0];
  aibomM.material = new THREE.MeshStandardMaterial();
  aibomM.material.color.set(parameters.materialColor);
  aibomM.scale.set( piecescale, piecescale, piecescale);
  aibomM.position.set( aibomSite.x* ratio, desk + 0.01, aibomSite.z* ratio);
  aibomM.userData.planes = aibomG;
  jars.add( aibomM);
}
loader.load( 'models/aibom.glb', onLoadAibom, undefined, function ( error ) {console.error( error );} );	
```
Save the index.html file and reload the web browser and you should see a model. You will notice that you did not have to add ```aibomM``` to the scene, since you added it to the jars group, which has already been added to the scene.

To avoid repetitive code you will define a function ```createModel()```, and assign the ```onLoadAibom()``` function run this ```createModel()``` function when it loads the model. The function will take 4 arguments: the model filename, position, the model colour and the matching gallery as these vary with the different models. 

It may seem confusing to have to have two different functions and it is not essential to understand the following, but it may help if you are trying to write your own code. The `loader.load method` does not expect the function (i.e. ```onLoadAibom```) called after loading to return anything. You will note there is no ```return(x)``` in the ```onLoadAibom``` function. So you have to pass our loaded model to a pre-declared variable (i.e. ```aibomM```). 

However, you want to have 6 different models, and use different colours, planes and positions for them, and giving callback functions like ```onLoadAibom``` arguments is a bit tricky. So one solution is the use of two different functions, with one function `createModel` able to take arguments and return a model, and the other function is ```onLoadAibom```.

**Find** the following code:

```
// loading function for Aibom jar model
function onLoadAibom( gltf ) {				
  ...
}
loader.load( 'models/aibom.glb', onLoadAibom, undefined, function ( error ) {console.error( error );} );	
```
The **lines** of code above should be **changed** to the following:
```
//a function to make the model with the parameter specified
function createModel(gltf, site, col, gallery){
  const model = gltf.scene.children[0];	
  model.material = new THREE.MeshStandardMaterial();
  model.material.color.set(col);
  model.scale.set( piecescale, piecescale, piecescale);				
  model.position.set( site.x * ratio, desk + 0.01, site.z * ratio);	
  model.userData.planes = gallery;
  return model;
}

//calls the createModel function but still in a separately defined function
function onLoadAibom( gltf ) {							
  aibomM = createModel(gltf, aibomSite, parameters.materialColor, aibomG);			
  jars.add( aibomM);
}
loader.load( 'models/aibom.glb', onLoadAibom, undefined, function ( error ) {console.error( error );} );

```
Save and check the model still appears.

However, with this approach you would still need 6 different ```onLoadX``` functions, 1 for each model. The code can be condensed further by using 'anonymous' functions, i.e. the function called is not named. 

You keep the createModel function but **find** the following code:

```
//calls the createModel function but still in a separately defined function
function onLoadAibom( gltf ) {							
  ...
}
loader.load( 'models/aibom.glb', onLoadAibom, undefined, function ( error ) {console.error( error );} );
```

The **lines** of code above should be **changed** to the following:

```
// directly has the onLoad function as an anonymous function in the loader.load
// load a jar (filename, load function, function while loading, error function)
loader.load( 'models/aibom.glb', function( gltf ) {							
  aibomM = createModel(gltf, aibomSite, parameters.materialColor, aibomG);			
  jars.add( aibomM);
}, undefined, function ( error ) {console.error( error );} );

loader.load( 'models/mailu.glb', function( gltf) {							
  mailuM = createModel(gltf, mailuSite, parameters.nabColor, mailuG);			
  jars.add( mailuM);
}, undefined, function ( error ) { console.error( error );} );

loader.load( 'models/louisade.glb', function( gltf ) {
  louisadeM = createModel(gltf, louisadeSite, parameters.ringTopColor, louisadeG);			
  jars.add(louisadeM);
}, undefined, function ( error ) {console.error( error );} );

loader.load( 'models/adzera.glb', function( gltf ) {
  adzeraM = createModel(gltf, adzeraSite, parameters.coilBeatenColor, adzeraG);			
  jars.add( adzeraM);
}, undefined, function ( error ) {console.error( error );} );

loader.load( 'models/dimiri.glb', function( gltf ) {
  dimiriM = createModel(gltf, dimiriSite, parameters.coilColor, dimiriG);			
  jars.add( dimiriM);
}, undefined, function ( error ) {console.error( error );} );

loader.load( 'models/yabob.glb', function( gltf ) {
  yabobM = createModel(gltf, yabobSite, parameters.paddleColor, yabobG);			
  jars.add( yabobM);
}, undefined, function ( error ) {console.error( error );} );

```

Save the index.html file and reload the web browser. You should see 5 models (Figure 10). You will have to move around to see the sixth.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-10.png" alt="Five jar models sit on a map of Papua." caption="Figure 10. Webpage with six jars from Papua, but one is out of camera range." %}

It does not matter which of the 3 methods you use if you are writing your own code.

Note that if you change ```let piecescale = ratio;``` to ```let piecescale = ratio*2;``` the vessels become bigger, but some will overlap.

You can calculate where to set the positions of the jars by taking into account the map dimensions. This can be done on graph paper, although these positions were obtained via placement of the jars in Blender.

### Adding Jar Selection

Next you want to add an event listener, to be able to select a jar and change the information panel. As with the ```WindowResize``` event listener in Part 1, this listener gets the event (in this case ```click```), and a function (known as an event handler) you will define. Input events pass event information to their handler, some of which is dependent on the type of event. The click event passes an object (commonly called ```event```) that contains the mouse cursor's coordinates relative to the viewport/window. 

To determine what jar in 3D space is being targeted by the user's mouse in 2D space, three.js uses raycasting. Whenever you click, the three.js raycaster 'sends' a 'ray' from the camera position to a pointer whose 2D position is calculated from the click event's information. The raycaster has an ```intersectObjects``` method that returns an array of the 3D objects that the cast ray has hit. This array is ordered by distance to the camera so the first in the array (index 0) will be the nearest object. You also tell the ```intersectObjects``` method what objects can be intersected and here you will specify children of the jars group. This is the primary reason you made the group.

You may also notice that three.js stores coordinates in a 'vector'. A THREE.Vector2 is used for 2D coordinates (referred to as x and y) such as the pointer position, and a THREE.Vector3 is used for 3D coordinates (x, y and z). 

You need to declare variables for the raycaster, the mouse pointer and the object selected at the time. **After** the following code:

```
// Variable declaration and setting
```

You need to **add** the following code:

```
let raycasterM, pointer, selectedObj; // for mouse controls
```

You need to create a raycaster, and make the pointer a (x,y) vector (empty to start). Often problems arise if objects are not defined before use, especially if you are going to do something to them, like make them unemissive after something else is selected. One solution to this is to initially make a variable like 'selectedObj' something and here you will just create a torus. As you do not add it to the scene it does not appear.

**Within** the init function definition, **after** the following code:

```
controls.update();
```

You need to **add** the following code:

```
// Mouse controls for jar selection
raycasterM = new THREE.Raycaster(); // ray to tell what is being pointed at
pointer = new THREE.Vector2(); // x, y co-ordinates for the ray to aim at, empty to start
selectedObj = new THREE.Mesh( new THREE.TorusGeometry( 0.015, 0.007, 20, 20  ), new THREE.MeshStandardMaterial({color: 0x006400})); // initialising the selected jar with something- here a torus, to prevent issues.

```

Then, you tell the window to 'listen' for any clicks, to send the click information to the ```onClick``` function that you will define next.

**Within** the init function definition, **after** the following code:
```
window.addEventListener( 'resize', onWindowResize );
```

You need to **add** the following code:
```
window.addEventListener( 'click', onClick );
```

Then you have to tell the listener what do do if there is a click in the window. To start, you will just make the newly selected jar glow red. You want to: 
* make sure it does not use the orbit controls (you will use ```event.preventDefault()```);
* get a pointer position from the click position (you will use the code from a three.js example, it calculates pointer.x and pointer.y from the ```event.clientX``` and ```event.clientY``` information and the window dimensions);
* cast a ray from the camera to the pointer (you use the ```setFromCamera``` method of the Raycaster) and
* see if any jars are there (you use the ```intersectObjects``` method of the Raycaster and tell it to only look for objects in the jars group, and give any objects found to a group called ```intersects```).
* see if it finds any jars (if the length of intersects is greater than 0),
* get the closest jar (create ```found``` and makes it the closest (first) intersected object, change ```selectedObj``` to ```found```),
* and highlight it (set found's ```material.emissive.r``` to 'on' (i.e. ```=1```)).

After the resize listener, i.e. **after** the following code:

```
function onWindowResize() {
  ...
}
```

You need to **add** the following code:

```
// called on mouse click. Gets position of click, gets intersecting object, makes it emissive, gets the matching info plane
function onClick( event ) { // event is the input event information being passed from the event
  event.preventDefault(); // stops the orbiting
  // gets 2D click position
  pointer.x = event.clientX / window.innerWidth * 2 - 1 // this formula comes from the three.js examples
  pointer.y = - (event.clientY / window.innerHeight) * 2 + 1
  // detects what the user is trying to select in 3D space from viewpoint and 2D pointer
  raycasterM.setFromCamera( pointer, camera );
  const intersects = raycasterM.intersectObjects( jars.children); // an array, nearest to camera will be first
  // if there is something being clicked		
  if(intersects.length > 0){
    const found = intersects[ 0 ].object; // get the selected object, index 0 is the first
    selectedObj = found;
    found.material.emissive.r = 1; // turn the selected object red emissive. 1 is on.
  }
}	
```

You can save the index.html file and reload the browser, and see that clicking on the jars makes them red. However, our intended functionality is for the jars to go back to their original colour after a new jar is selected. Toggling ```material.emissive.r``` off and on to indicate selection means you do not have to store what colour the jar was originally, as you can just turn the emissiveness off.

 
**Within** the onClick function definition, **after** the following code:
```
if(intersects.length > 0){
```
You need to **add** the following code:
```	
  selectedObj.material.emissive.r = 0; // turn the current selected obj back to not emissive. 0 is off
```
Now if you save and reload, there should only be one highlighted jar at a time.

You also need the onClick function to:

* hide the current panel (set ```.visible``` to false for the ```selectedPlane```),
* change the ```selectedPlane``` to the new jars linked userData panel
* and make that panel visible (change ```selectedPlane``` and set its ```.visible``` to true).


**Within** the onClick function definition, **after** the following code:

```
selectedObj.material.emissive.r = 0; // turn the current selected obj back to not emissive. 0 is off
```

You need to **add** the following code:

```
selectedPlane.visible = false; // hide the current information panel
```

Then, **after** the following code:

```
  found.material.emissive.r = 1; // turn the selected object red emissive. 1 is on.
```

You need to **add** the following code:

```
selectedPlane = found.userData.planes; // get the new matching information panel for the selected object
selectedPlane.visible = true; // make the new panel visible
```

Now (after reloading) you should be able to select a jar and the middle information panel should change to give information about that jar. You can try ```.emissive.g``` or ```.emissive.b``` to make the selected jar green or blue emissive, if you want.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-11.png" alt="Five jars on a map with one glowing red as it has been selected." caption="Figure 11. Webpage showing the Aibom jar selected with its red emission set to true, and the Aibom information panel." %}

The next sections are optional. You can turn the website into a puzzle game or add extra jars.

## Designing a Game

When designing a game or puzzle, consider if the puzzle is based on memory or logic. The main aim of games featuring material culture is generally to help users appreciate the variety in artefact properties, such as form and decoration, rather than for users to remember every detail of each object encountered during the game.

Often images of material culture are incorporated into the traditional memory game of finding matching images on overturned cards. See the 2D [Ho'omaka Hou Research Initiative Fishhook Memory Game](https://data.bishopmuseum.org/archaeology/game.html). This approach does introduce users to the variety of forms or decorations in material culture (including fishhooks) that they may not otherwise appreciate. 

In contrast, jigsaw puzzles (which also commonly feature material culture) rely more on logic. 3D jigsaw puzzles can be made of material cultural artefacts and sites, but it can be quite difficult for users to manipulate pieces on a computer screen. 3D jigsaw puzzles are more usable in VR: one example is [Artsalad](https://artsalad.net) by Mariotto F., an opensource VR 3D puzzle game that was written with three.js.

If the 'Jars of Papua' featured realistic models of jars that the user needed to place at their correct site, it would benefit from providing a way to ensure that the user can first view the correct placements. Alternatively, clues could be given to encourage the user to study the models, resulting in less reliance on memory. 

For this lesson, you will rely on the models being coloured by how they are made (build technique) to help the user match vessels to sites. This information is provided in the site information panel. The decoration style information may also help with matches. The approach of having models matched to information panels could have been done without the use of a map of New Guinea, but including the map helps reinforce the idea that the people of Papua New Guinea (and West Papua) made pots (and in many cases still do) and that there is a large variety in the material culture between the different communities. If you are planning to design a game consider consulting guides such as Schell (2015).

To transform the scene into a puzzle the information panel used needs to be altered, as it is the main source of user information. The goal for the user of this game is to start with the jars placed off the map, with the Papuan communities demarcated by selectable tokens. When the communities are selected by the user's mouse click, the information panel will provide the information on the pots made by that community. Information on the technique used to make the pot can be used to work out which of the jars may be a match, as the jars are coloured by the technique and a key is provided. The decoration technique may also serve as a guide. The user can move the jars with their mouse. If they place the matching jar on the community marker, then the jar becomes unmoveable and the background colour changes. 

### Adding Tori

Green tori will be used to mark the communities.  The torus is a basic three.js geometry, and the diameter, central hole size, and segmentation can be specified (Figure 4). However, tori are generated at the wrong angle for this game and need to be rotated (around the x axis) by 90 degrees (i.e. -Math.PI /2). Each tori centre will be positioned slightly (1 cm) above the map (which is at 'desk' height) at y = desk + 0.01.

Because each torus is connected to a different information panel, they still need to be created separately and added to a tori group. The mouse click event listener has to be altered so that it targets the tori group instead of the jars group. 

Each site could be added with such code as follows:

```
aibomSite = new THREE.Mesh( new THREE.TorusGeometry( 0.015, 0.007, 20, 20 ), new THREE.MeshStandardMaterial({color: 0x006400}));
aibomSite.position.set(0.36* ratio, desk + 0.01, -0.01* ratio);
aibomSite.scale.set( piecescale, piecescale, piecescale);
aibomSite.rotation.x = -Math.PI * 1/2;
aibomSite.userData.planes = aibomG;
```

But it is also possible to make a function that takes position (x and z) co-ordinates and the relevant gallery. The function is then called for each site.

In the index.html file **find** the following code:

```
let jars;
```

The line of code above should be **changed** to the following:

```
let jars, tori;
```

**Within** the init function definition, **after** the following code:

```
scene.add( sphere1, sphere2, sphere3, sphere4, sphere5, sphere6, sphere7, sphere8, sphere9 );
```

You need to **add** the following code:

```
// Add sites as tori, in a group
tori = new THREE.Group();
scene.add( tori );

// a function to create the site marker with the location and matching information panel
function createSite(x, z, gallery){
  const model = new THREE.Mesh( new THREE.TorusGeometry( 0.015, 0.007, 20, 20 ), new THREE.MeshStandardMaterial({color: 0x006400}));
  model.position.set( x * ratio, desk + 0.01, z * ratio);	
  model.scale.set( piecescale, piecescale, piecescale);
  model.rotation.x = -Math.PI * 1/2;
  model.userData.planes = gallery;
  return model;
}

aibomSite = createSite(0.36, -0.01, aibomG);
dimiriSite = createSite(0.43, 0, dimiriG);
louisadeSite = createSite(0.99, 0.59, louisadeG);
mailuSite = createSite(0.84, 0.48, mailuG);
adzeraSite = createSite(0.61, 0.15, adzeraG);
yabobSite = createSite(0.572, 0.0396, yabobG);
tori.add(aibomSite, mailuSite, dimiriSite, louisadeSite, adzeraSite, yabobSite);

```

Save the index.html file, reload the browser and check the tori appear on site reload. 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-12.png" alt="Five jars sit on green tori on a map of Papua." caption="Figure 12. Webpage with the jars sitting on tori." %}

You will see that nothing happens when you click on them, as the raycaster is only checking the jars for intersections. So in the ```onClick(event)``` function, **find** the following code.

```
const intersects = raycasterM.intersectObjects( jars.children);	// an array, nearest to camera will be first
```

The line of code above should be **changed** to the following:

```
const intersects = raycasterM.intersectObjects( tori.children);
```

Save and check that the mouse click and panel change now work on tori (as opposed to the jars).


### Enabling Jar Movement

To be able to move the jars using the mouse, ```DragControls``` have to be imported and created. The first argument when creating the ```DragControls``` determines what they can drag.

**After** the following code:

```
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
```

You need to **add** the following code:

```
import { DragControls } from 'three/addons/controls/DragControls.js';
```

**Find** the following code:

```
let container, camera, scene, renderer, controls;
```

The line of code above should be **changed** to the following:

```
let container, camera, scene, renderer, controls, dragControls;
```

**Within** the init function definition, **after** the following code:

```
pointer = new THREE.Vector2(); 

```

You need to **add** the following code:

```
// Mouse controls for jar dragging
dragControls = new DragControls( [ jars ], camera, renderer.domElement ); // first argument determines drag objects.	

```
Then you add event listeners for the ```dragstart``` and ```dragstop``` events. Here you will make the handler functions anonymous. You need to turn the orbital controls off while jars are being dragged.

**After** the following code:

```
window.addEventListener( 'click', onClick );
```

You need to **add** the following code:

```
dragControls.addEventListener('dragstart', function (event) {
  controls.enabled = false // orbit controls off
});
dragControls.addEventListener('dragend', function (event) {
  controls.enabled = true // orbit controls back on
});
```

Save the index.html file, reload the browser, and check that you can now move the jars around.

However, you will see that it can be difficult to move jars in certain positions in 3D. It is easier to achieve if you view the scene directly from the top, or directly from the side.

### Start Jars at Random Positions




To make the jars start in a random position above the map you will use the [Math.random()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random) method which generates a number between 0 and 1. You will change the position.set to x = Math.random() - 1, y = 1.2, and z = Math.random() * 0.5 - 0.3. 

Thus, all jars will be at the same height (y = 1.2) but in a random spot within 1m wide (i.e. from x = -1 to 0, slightly to the left of the screen) and within a 0.5m depth (i.e. from z = -0.3 to 0.2). These positions were optimised for a user in VR to be able to easily reach the jars and read the instructions. 

If you review Figure 3 you can see where the jars should appear in relation to the camera and map. You can change the code so they appear elsewhere if you think that would be better.

You will store the matching site in a userData variable. Before you do this you may want to note, or take a screenshot of where at least one of the jars should go.

When creating the jars you now need the matching site but not the gallery and you do not need its correct position so **find** the following code:

```
function createModel(gltf, x, z, col, gallery){
```

The line of code above should be **changed** to the following:

```
function createModel(gltf, col, site){
```

Within the ```createModel``` function, **find** the following code:

```
model.position.set( x * ratio, desk + 0.01, z * ratio);
model.userData.planes = gallery;
```

The **lines** of code above should be **changed** to the following:

```
model.position.set( Math.random() - 1, 1.2, Math.random() * 0.5 - 0.3 );
model.userData.site = site;
```

Then you need to change all 6 of the ```createModel``` calls that are within the 6 different ```loader.load``` calls.


**Find** the following code:

```
aibomM = createModel(gltf, 0.36, -0.01, parameters.materialColor, aibomG);			
```

The line of code above should be **changed** to the following:

```
aibomM = createModel(gltf, parameters.materialColor, aibomSite);
```

**Find** the following code:

```
mailuM = createModel(gltf, 0.84, 0.48, parameters.nabColor, mailuG);
```

The line of code above should be **changed** to the following:

```
mailuM = createModel(gltf, parameters.nabColor, mailuSite);	
```

**Find** the following code:

```
louisadeM = createModel(gltf, 0.99, 0.59, parameters.ringTopColor, louisadeG);		
```

The line of code above should be **changed** to the following:

```
louisadeM = createModel(gltf, parameters.ringTopColor, louisadeSite);
```

**Find** the following code:

```
adzeraM = createModel(gltf, 0.61, 0.15, parameters.coilBeatenColor, adzeraG);	
```

The line of code above should be **changed** to the following:

```
adzeraM = createModel(gltf, parameters.coilBeatenColor, adzeraSite);
```

**Find** the following code:

```
dimiriM = createModel(gltf, 0.43, 0, parameters.coilColor, dimiriG);
```

The line of code above should be **changed** to the following:

```
dimiriM = createModel(gltf, parameters.coilColor, dimiriSite);	
```

**Find** the following code:

```
yabobM = createModel(gltf, 0.572, 0.0396, parameters.paddleColor, yabobG);
```

The line of code above should be **changed** to the following:

```
yabobM = createModel(gltf, parameters.paddleColor, yabobSite);			
```

Save the index.html file, reload the browser and you should see the jars starting above the map. If you reload the browser they will be in different random positions.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-13.png" alt="Six jars float at random positions above a map of Papua." caption="Figure 13. Webpage with the jars at random start positions above the map." %}

### Check for Successful Matches

At the end of each jar movement, you want to check if the jar was moved to the correct spot. One way to do this is to determine the distance between the jar and the matching site (torus). You need to set an allowed distance difference that will allow for non-exact placement, but will not be successful if a jar is placed on a torus nearby. Here you will use 5 cm (2.5cm * ratio). 

If the test is successful, there has to be a signal to the user. Here you will change the background colour to a random colour, and make the jar unmoveable. No signal will be given for an incorrect match. 

You will create an additional group called ```unmoveable``` and attach any jars to that group that are placed close enough to their torus. Objects can only be attached to one group, so when a model is moved to ```unmoveable``` it will no longer be in ```jars``` and so the mouse will not detect it.

You need extra variables for the new ```unmoveable``` group, ```selectedObject``` which is the selected jar and the ```truesite```, which is the site that the selected jar should match. As no jar is selected at the start you will make ```truesite``` and ```selectedObject``` ```null``` to start with.

**Find** the following code:

```
let jars, tori;
```

The line of code above should be **changed** to the following:

```
let jars, tori, unmoveable;
let selectedObject = null;
let truesite = null;
```

**Within** the init function definition, **after** the following code:

```
scene.add( jars );
```

You need to **add** the following code:

```
// add unmoveable group for jars that have been put in the correct spot
unmoveable = new THREE.Group();
scene.add(unmoveable);  
```
#### Obtaining the Positions of the Selected Jar and its Correct Site

The event object for drag events contains the identity of the object being dragged (```event.object```), so you can use that in the handler function and you can get the site it should match from its userData.

**Within** the dragend handler function, **after** the following code:

```
dragControls.addEventListener('dragend', function (event) {
    controls.enabled = true // orbit controls back on
```

You need to **add** the following code:

```
selectedObject = event.object;
truesite = selectedObject.userData.site;
```

You can use the ```getWorldPosition``` method to find out the coordinates of the ```truesite```. You may wonder why you did not just put the coordinates in the userData and you could have as the sites do not move in this version of the game. However having this extra step means that if you want to make the map (with sites) movable in a different version it is easier to do. 

The ```getWorldPosition``` method puts the coordinates into a vector (x, y, z) that is given as an argument, in this case ```testposition```. This vector can not be null to begin with so it is set as (0,0,0). To get the position of the jar being dragged you can put its position property into a vector (you will call ```aposition```).

**After** the following code:

```
truesite = selectedObject.userData.site;
```

You need to **add** the following code:

```
let testposition = new THREE.Vector3(0,0,0); //needs to be something first
truesite.getWorldPosition( testposition ); //a Vector3 (x,y,z)
let aposition = selectedObject.position; //get jar position
```
#### Testing if the Jar has been Place 'on' its Site

In coding, [conditional statements](https://en.wikipedia.org/wiki/Conditional_(computer_programming)) such as the 'if' statement are commonly used to specify that lines of code will only run if a particular criteria is fulfilled. You used an if statement previously when testing if anything is actually being selected by the mouse. Now you will use an if statement to test if the distance between the jar and its matching site is within the set allowed distance. You call the ```distanceTo``` method on the ```aposition``` vector to determine the distance between the two vectors, and test if it is smaller than our allowed distance (0.25 * ratio). 

**After** the following code:

```
let aposition = selectedObject.position; //get jar position
```

You need to **add** the following code:

```
if ( aposition.distanceTo( testposition ) < .025 * ratio) {
  // they are a match!
}	

```

You can save the index.html file and reload the browser to check for errors (broken code blocks can occur). But you have not told the script what to do if the test is successful yet, so nothing will occur if you do get a correct match. 

#### Changing the Background Colour if the Match is Correct

If the match is correct, you want the background colour to change, by making ```scene.background``` equal to a new ```THREE.Color``` generated by ```Math.random() * 0xffffff```. This works because the hex colour codes are actually being converted to hexadecimal numbers and multiplying white (0xffffff or 16777215) by a random (0-1) value gives another number 0- 16777215, which can be interpreted as a colour by three.js.

**Find** the following code:

```
// they are a match!
```

The line of code above should be **changed** to the following:

```
scene.background = new THREE.Color( Math.random() * 0xffffff ); // random
```

If the test is successful you also want to set the position of the jar to the exact spot, partly because the slight jump helps signal that it was a success. Importantly you want to make it unmoveable by putting it in the unmoveable group. The unmoveable group is unmoveable because the drag listener is only acting on the jars group.

Keeping within the if code block, **after** the following code:

```
scene.background = new THREE.Color( Math.random() * 0xffffff ); // random
```

You need to **add** the following code:

```
selectedObject.position.set(testposition.x, testposition.y, testposition.z);
unmoveable.attach( selectedObject); // adding to the unmoveable group will remove from the jar group.

```

You can save the index.html file and try to test, but moving in 3D can be difficult. When viewing 3D scenes on 2D surfaces (such as a computer screen) objects that are distant from each other can appear to be close. You will make it (somewhat) easier to move in the 3D environment in the next step. **If** you want to test the moving at this stage, it is best done in multiple steps, viewing from the side to lower the jar to the map, and then from the top (birds eye view) to place it in the right spot, or vice versa (Figures 14-16).

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-14.png" alt="While 5 jars are randomly above the map, the Aibom jar has been moved close to its torus." caption="Figure 14. Moving jars, such as the Aibom jar, close to their torus is best done in multiple steps and best done when viewing the scene directly from the front, side or above." %}

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-15.png" alt="Birdseye view of jars and map, with the background changed to a pink colour to show that the Aibom jar has been correctly positioned." caption="Figure 15. Moving jars while viewing the scene from above helps correctly position jars, triggering a background (random) colour change." %}

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-16.png" alt="Normal view of the jars and map, with the Aibom jar in its correct position." caption="Figure 16. The Aibom jar in its correct position." %}

#### Making Matching Easier by Detecting Matches in 2D Space

This way of placing the jars on the sites can be frustrating for users and the ```onClick``` function is actually called at the end of a drag event, thus you can also alter the ```onClick``` function to register a correct match if the drag ends with the mouse on the correct site.

This alternative means that the match is tested in 2D space instead of in 3D space (as in the first approach). Thus matches are easier, especially for players not experienced with digital 3D environments. 
 
If you develop your own games you might want to test different approaches to see what works best. All game and website design guides will advise you that several cycles of user testing and code refinement are important.

**Within** the onClick function, **after** the following code:

```
const found = intersects[ 0 ].object; // get the selected object, index 0 is the first
```

You need to **add** the following code:

```	
if(found == truesite){ // tests if site mouse is over is the same as the true jar site
  // if match change colour of background
  scene.background = new THREE.Color( Math.random() * 0xffffff ); // random
  // click to correct position in case slightly off
  let testposition = new THREE.Vector3(0,0,0); //needs to be something first
  truesite.getWorldPosition( testposition ); //a Vector3 (x,y,z) this is the position of the site
  selectedObject.position.set(testposition.x, testposition.y, testposition.z);
  unmoveable.attach( selectedObject );
  }
```

Furthermore, the ```truesite``` variable needs to be reset to ```null``` after testing.

**Within** the onClick function, **after** the following code:

```
  selectedPlane.visible = true; // make the new panel visible
}
```

You need to **add** the following code:

```
truesite = null;	
```

You have to be careful with brackets/braces here. The ```onClick``` function now has two nested ```if``` blocks. The ```truesite = null;``` statement should be outside these ```if``` blocks, but inside the ```onClickfunction```. 

Now it should be easier to move jars to their sites: you just need the mouse to be directly over the torus when you stop dragging the jar.

### Update the Instructions
Lastly, to update the instructions in the first intro panel, change the texture to the intro2.jpg.

**Find** the following code:

```
const introTexture = textureLoader.load( 'textures/Intro.jpg' );
```
    
The line of code above should be **changed** to the following:

```
const introTexture = textureLoader.load( 'textures/Intro2.jpg' );
```

Save the index.html file, reload the browser and check that the new instructions appear.

## Adding Additional Jars
Pots were made in many different forms by different communities in Papua New Guinea, West Papua and Maluku. There are models and information panels for 29 communities in the folders provided. 

If you want to experiment with adding them (Figure 17), the following table provides the model name, matching panel texture, location and colour parameter name to use. Each needs variables for the jar, panel and a site/torus (game only). These can be called anything (avoid special characters), but remember to declare them.

| Model | Texture | Position | Colour |
| --- | --- | --- | ---|
| abelam.glb | Abelam.jpg | 0.33* ratio, desk + 0.01, -0.06* ratio | coilColor |
| agarabi.glb | Agarabi.jpg |  0.55 * ratio, desk + 0.01, 0.15 * ratio | coilBeatenColor |
| aloalo.glb | Aloalo.jpg | 0.9* ratio, desk + 0.01, 0.49* ratio | ringTopColor |
| bau.glb | Bau.jpg | 0.535* ratio, desk + 0.01, 0.04* ratio | coilColor |
| binadean.glb | Binadean.jpg | 0.76 * ratio, desk + 0.01, 0.34 * ratio | coilBeatenColor |
| boiken.glb | Boiken.jpg | 0.37* ratio, desk + 0.01, -0.08* ratio | coilColor |
| collingwood.glb | Collingwood.jpg | 0.85* ratio, desk + 0.01, 0.4* ratio | wangelaColor |
| demta.glb | Demta.jpg | 0.13* ratio, desk + 0.01, -0.16* ratio | materialColor |
| guhu.glb | Guhu.jpg | 0.65* ratio, desk + 0.01, 0.23* ratio | coilColor |
| huon.glb | Huon.jpg | 0.71* ratio, desk + 0.01, 0.13* ratio | paddleColor |
| ilesales.glb | Ilesales.jpg |  -0.34* ratio, desk + 0.01, 0.11* ratio | paddleColor |
| kaiep.glb | Kaiep.jpg | 0.41* ratio, desk + 0.01, -0.07* ratio | paddleColor |
| kombio.glb | Kombio.jpg | 0.29* ratio, desk + 0.01, -0.05* ratio | coilColor |
| lumi.glb | Lumi.jpg | 0.25* ratio, desk + 0.01, -0.08* ratio | coilColor |
| maluku.glb | Maluku.jpg | -0.86* ratio, desk + 0.01, -0.08* ratio | paddleAddColor |
| manus.glb | Manus.jpg | 0.66* ratio, desk + 0.01, -0.2* ratio | paddleColor |
| marik.glb | Marik.jpg |  0.575* ratio, desk + 0.01, 0.079* ratio | coilColor |
| meno.glb | Meno.jpg |  0.28* ratio, desk + 0.01, -0.01* ratio | coilColor |
| moto.glb | Moto.jpg |  0.71* ratio, desk + 0.01, 0.42* ratio | paddleColor |
| pubineri.glb | Pubineri.jpg |  0.53* ratio, desk + 0.01, 0.09* ratio |  coilColor |
| triobriand.glb | Triobriand.jpg | 1.01* ratio, desk + 0.01, 0.33* ratio | amphColor |
| tumleo.glb | Tumleo.jpg | 0.27* ratio, desk + 0.01, -0.12* ratio | paddleColor |
| waigeo.glb | Waigeo.jpg |  -0.65* ratio, desk + 0.01, -0.35* ratio | paddleAddColor |

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-17.png" alt="Many jars on a map of Papua." caption="Figure 17. Additional jars can be addded to the scene and puzzle." %}

## Conclusion and Next Steps
This has been an introduction to using three.js and the basic concepts in creating 3D scenes. 

The official [three.js](https://threejs.org) website shows how much more complex pages can be created, with additions such as animations and sound. The [three.js](https://threejs.org/examples/) site also contains example code that could be used for extending the puzzle created here, for example adding sound effects for correct matches. Many sites, especially those with large models, feature loading bars, that give feedback to the user while the models load. Another possible extension is to enable the scene to be viewed and manipulated in VR. The three.js site also contains links to places to ask the community for help, and links guides including [three.js Fundamentals](https://threejs.org/manual/#en/fundamentals). 

There are many ways cultural heritage models can be used interactively: broken vessels can be put back together (Hardy, 2023), site contexts could be toggled on and off, or objects could be virtually analysed, with images or measurements from scientific techniques revealed when the object is clicked on. Providing research data in such a format has challenges, but also has the possibility for making findings more accessible and interesting to non-academic audiences.


## References

Gaffney, D. 2017. Maintenance and mutability amongst specialist potters on the Northeast Coast of New Guinea. Cambridge Archaeological Journal 28:1-24

Hardy, K., Ballard, C. and Leclerc, M. 2023. Agarabi pottery production in the Eastern Highlands of Papua New Guinea. Journal of Anthropological Archaeology 69:101479

Hardy, K. 2023. The creation of 'Uvira's Pot', a virtual reality puzzle to promote engagement with archaeological research. Conference: Digital Humanities 2023. Collaboration as Opportunity (DH2023) At: Graz, Austria.

Schell, J. 2015. The Art of Game Design: A Book of Lenses. CRC Press. FL.
