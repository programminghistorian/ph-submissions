---
title: "Creating 3D Scenes or Games with Three.js to Communicate Material Culture Diversity"
slug: creating-3d-scenes-games-threejs
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Kristine Hardy
- Mathieu Leclerc
reviewers:
- Forename Surname
- Forename Surname
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

This guide shows how to use the [Three.js](https://threejs.org) javaScript library to create a website with 3D models to illustrate the diversity of the pottery technologies of communities in the Papua New Guinea area. Selecting a vessel model reveals information on the community and their ceramics. The website also can be the basis for a matching puzzle where the vessel is matched to the community. In the puzzle version selecting a torus shows the information about the pottery and if the vessel is dragged onto the correct torus the background colour will change.

Web models and digital games can help the dissemination of archaeological information. As opposed to simply writing texts about artifacts, supplying communities with more accurate examples of the archaeological past can be considered a goal of archaeologists (Holtorf, 2005). This lesson aims to facilitate the production of engaging digital research outputs by introducing [Three.js](https://threejs.org) as a tool to do this. The use of interactive 3D models in websites enables examples of archaeological and historical material culture to be presented more effectively. 

There are several different ways for creators to make websites that include models. Many cultural heritage models are hosted on SketchFab (Maschner, 2022), which allows for interactive annotations. For more complex interactions with models, game engines such as Godot, Unity and Unreal Engine can be used. However websites can also be made relatively easily using the Three.js JavaScript library. This guide provides an example of making such a website. While this tutorial uses Three.js, many of the concepts are relevant to game engines and 3D modelling software.

Cross community comparisons of different aspects of material culture, such as pottery, can indicate shared community histories. These aspects include both appearance (form and decoration) and methods of production. This concept is sometimes termed 'cultural evolution' (O'Brien et al. 2008). However, the spread of ideas and local innovations generally occur at a faster rate in material culture than with genetics or linguistics and the transmission of pottery production is argued to have occurred at least partially, independently of demic diffusion in Europe (Dolbunova et al. 2023). Comparisons of pottery across a region such as PNG, or the wider Pacific, reflects shared heritages, community contacts and local innovations. Visualising the pottery forms and their geographic distribution helps illustrate this, especially when additional information, such as the language family, of the community is considered. The extensive ethnographical work of researchers, such as May and Tuckson (2000) and Petrequin and Petrequin (2006) has been essential for such comparisons.

## Lesson Goals

The primary goal of this tutorial is to use the Three.js library to create a webpage featuring a 3D scene with selectable components. Scene creation will involve adding lights, cameras, primitive and complex models, and controls. The models will get materials and/or image textures. Concepts such as model groups, scale and visibility, and 3D co-ordinates will be introduced. 

Turning websites with models into puzzles makes them more interesting. An additional goal, is to make the models moveable and positioned at random places. A test is introduced after each time a model is moved, to see if they have been placed in the correct position and successful matches trigger a background colour change.

## Software Requirements and Installation

- Text editor (Visual Studio Code (VSC) recommended).

VSC can be downloaded from https://visualstudio.microsoft.com, it is free and runs on Windows, MacOS, and Linux. It also features a terminal. Install as per website instructions.

- Terminal (ie Windows PowerShell, or the terminal in MacOS or Linux), or the terminal in VSC. 

Some simple command line typing will be required. Most importantly you need to be able to move to the folder that your website file will be in. If you use the VSC terminal, this should be automatic.

- Web browser. Chrome, Safari, Edge etc.

Chrome generally has the better developer tools for code debugging.

- Node.js (https://nodejs.org) is a free JavaScript tool. 

It is easy to install (Windows, macOS, and Linux). This will allow you to ‘serve’ code internally to your browser (using an address in the browser such as http://localhost:3000), and see if the code is working, or how code changes affect your site. Node.js is probably the easiest way to serve code internally. Install as per website instructions, and check it is working in your terminal by typing 

```
node -v
```

and confirming that you get a version number and not an error message. 

- A Github page (recommended if deploying). 

To deploy your page so that everybody can access it, you can use github. You get one free page per account, ie my page at https://github.com/tosca-har/tosca-har.github.io, results in a website at https://tosca-har.github.io/. Alternatively you can deploy your site using a free service such as Vercel (https://vercel.com/).

- The Three.js library.

There are 2 ways to use the Three.js JavaScript library. This tutorial will use library via a content delivery network (CDN). Basically, code at the top of javascript script will fetch and import the library from a server. This removes the need for you to work with build tools like Vite, which you would have to do if you download the actual Three.js code. Downloading, working and building the code is more robust long term but for this lesson the CDN approach is fine. This code will use Three.js version 0.160.0, although it has been tested and works with later versions such as 0.166.1. If you want to change the version used you need to change both numbers in the import maps, i.e. use three@0.166.1 instead of three@0.160.0, and also change the version later on when importing the draco file compression loader. **Do not** mix versions. This lesson does not contain code likely to be affected by version changes but Three.js versions are not necessarily backward compatible so it is possible that problems will occur if later versions are used. Browser updates also occasionally cause incompatibility problems.

Make a new folder - call it myscene.

In VSC open the folder.

Create a file and call it *index.html*  
Note that it **must** be called this.

We are going to put all the code in this file, this is not the best practice but the point of the lesson is to learn about Three.js.

In the index.html file, copy and paste the following:

```
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>PNG pottery</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
		<link type="text/css" rel="stylesheet" href="main.css">
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

		<div id="info">
			<a href="https://threejs.org" target="_blank" rel="noopener">three.js</a> The Jars of Papua
		</div>

		<script type="module">
			import * as THREE from 'three';
		</script>
	</body>
</html>
```

Save the file. This html file is: creating a basic page with a link to the three.js site and a title; importing the three.js library and addons; and linking to a style sheet (which we will create next). The link with the anchor tags (i.e. &lt;a> &lt;/a>) is not needed for Three.js to work and is there because this page was developed from the Three.js example pages, you could remove it or change it to link to any site you want. Anything written within the script tags (i.e. &lt;script> &lt;/script>) will be in the JavaScript language. In JavaScript code, comments are marked by '//' and anything on that line after that will be ignored.

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

This file came from the examples folder at Three.js, it is a style file. Save the main.css file and then you can close it.

Save the index.html file.

Make sure that the command line of your terminal/shell indicates that you are in the myscene folder (...myscene %). In VSC, Terminal > New Terminal will give you a terminal. In the terminal type

```
npx serve
```

this will serve your site, normally to port 3000, but check the message to see what local address is being used. Open a web browser and go to that address (ie http://localhost:3000) and if all is working you will see a black page with 'three.js The Jars of Papua'. 

{% include figure.html filename="en-or-creating-3d-scenes-games-threejs-01.png" alt="Black page with small title (three.js The Jars of Papua), top centre." caption="Figure 1. Webpage with black background and small title." %}

To stop the server use Ctrl + C in the terminal. You can restart with 'npx serve', or use the keyboard up arrow to find previous terminal commands. You may need to reload the page in the browser to apply any code changes. 

## PNG Pottery

While not ubiquitous throughout PNG and West Papua, many communities have a history of making ceramic vessels for use in cooking, storage or ceremonial purposes. Pottery was first introduced to the Papua mainland over 3000 years ago (Gaffney et al. 2015) and the many different techniques, forms and decorations found are probably the result of a combination of local innovations and influences from different external sources.

In trying to understand this cultural transmission researchers compare factors such as decoration, form and building technique among the different communities. This lesson includes information and models for 29 communities. Step-by-step instructions are given for 6 models, with the assets and information for another 23 provided for users to practice with. These vessels include the paddle and anvil-made, rounder, less decorated vessels, often used for water storage and generally made by women, in coastal communities (including Bilibil speakers), scattered around the island. In the south east, woman potting communities (including Mailu and Misima-Paneati speakers) utilise different variations of techniques incorporating finishing with clay rings and generally geometric incised or applique decoration. While in many inland communities, men and women potters (including Adzera, Dimiri and Iatmul speakers) use spiral (or ring) building with decorations that can include sculptural elements and carvings.

## Ethics

It is important to reference the source of images and models used in a page. Here this will be done on an information panel in the site. The use of cultural heritage models, especially from communities that have been exploited and have had objects taken without consent, needs to be carefully considered. Laws and guidelines differ from country to country. Ideally informed consent from the maker community, or their descendants should be obtained for modelling of cultural objects and in some countries intellectual property legislation may require evidence that at least several attempts have been made to obtain permission. 

While "utilitarian" items are generally considered exempt from copyright, some ceramics have ceremonial purposes and in some areas decoration can be based on hereditary 'trademarks'. The models used in this project, were created with Computer Aided Design (CAD) by the authors (who are not of PNG heritage) and are intended to be symbolic rather than realistic. While simplification of some of the designs results in the some of the brilliance of some of the potteries being under-represented, it aids in avoiding impingement on the moral rights of the original communities. Objects (particularly human remains or funerary artifacts) can also have different values and associations for different people and cultures as highlighted by recent (2024) legislation in the USA on the display of certain Native American objects (including burial pottery). Interactive web models provide a way to effectively communicate academic research to a broader community, ultimately community involvement and control should occur at an earlier stage of the study, but as in other fields technological advances have occurred that could not be forseen by data/artefact collectors, and ideas around what constitutes 'informed consent' have also advanced. Including information, such as [Traditional Knowledge (TK) Labels](https://localcontexts.org/labels/traditional-knowledge-labels/) in model metadata is one way cultural information can be connected to a model. How different communities feel about their cultural objects being modelled and represented on websites is an area that would benefit from further research. 

The degree to which models of cultural artefacts are covered by copyright, and who that copyright belongs to, depends on several factors, and is not always clearcut (Oruc, 2020; D'Andra et al. 2022). Many researchers aim to make their models and site code available for others to use to increase the dissemination of information and promote further research and often models/code are given [Creative Commons licences](https://creativecommons.org/share-your-work/cclicenses/) such as CC-BY-NC. However, it is always worth considering that your models may be used in scenes you disagree with or find offensive, i.e. the pot models could be used in a potentially culturally derogatory manner (illustrating cannibalism). While you can request users to only use the models and code for non-derogatory purposes, models and code are increasingly being scraped by Artificial Intelligence (AI) 'bots' thus potentially contributing to models used in scenarios you did not forsee. The use of the "NoAI" HTML meta tag may help discourage this. 

It is also important to reflect on whether an scenes or especially puzzles, are contributing to a colonial approach. For example it might be better to have objects returned to their place of origin, than a puzzle that features them being stolen or 'collected'.

## Creating the Basic Web Page

Every three.js website has a 'scene' to which cameras, lights and objects need to be added. 
First create a scene with a background colour and a camera. The position of the camera is important, sometimes you can not see your models because the camera is looking away from them or they are outside its field of view. We will use a perspective camera with parameters that define the field of view, including boundaries for culling objects that are too close or too far from the camera. The units for Three.js are metres, and this camera will not render to the screen anything nearer to 0.1m and further than 10m. When we introduce moving the camera later, you will see objects disappear if they get too close. 

The camera, and other positions are set in x, y and z order. Different graphics programs and game engines use [different co-ordinate systems](https://twitter.com/freyaholmer/status/1325556229410861056). In Three.js x is left (-) and right (+), y is down (-) and up (+) and z is far (-) and near (+), i.e. it is a Y up, right-handed system. The camera is set at a height of 1.6m, and later the map will be at 0.8m, because this code was orginally written for use in virtual reality. The z co-ordinate for the camera is set at 3m, as if you have stepped back from the scene. 

This background will be peach (0xf7d382). To specify colours you can use the colour [hex code](https://www.color-hex.com) after '0x'.

In the index.html file, **after** the import declare the variables (with **let**), call and define the init and other necessary functions. Variables are generally declared outside function definitions, but sometimes will be declared within a function definition if the variable is only referred to within the function definition. 

After:

```
    import * as THREE from 'three';
```

add:

```
	// Variables
	let container, camera, scene, renderer; // declare the variables

	// Function calls
    	init(); // this is calling the init function
	animate(); // this is calling the animate function

	// Function definitions
    	function init() { // within the braces we define the init function
		container = document.createElement( 'div' );
		document.body.appendChild( container );
        	scene = new THREE.Scene();
		scene.background = new THREE.Color( 0xf7d382 ); // use the hexcode of any colour you want.
				
		camera = new THREE.PerspectiveCamera( 50, window.innerWidth / window.innerHeight, 0.1, 10 ); //vertical field of view, aspect, near plane, far plane
		camera.position.set( 0, 1.6, 3 ); //x, y, z

        	renderer = new THREE.WebGLRenderer( { antialias: true } );
		renderer.setPixelRatio( window.devicePixelRatio );
		renderer.setSize( window.innerWidth, window.innerHeight );
        	container.appendChild( renderer.domElement );
       	 	window.addEventListener( 'resize', onWindowResize );
		}
	function onWindowResize() {
		camera.aspect = window.innerWidth / window.innerHeight;
		camera.updateProjectionMatrix();
		renderer.setSize( window.innerWidth, window.innerHeight );
	}

	function animate() {
		renderer.setAnimationLoop( render );
	}

	function render() {
		renderer.render( scene, camera );
	}
```

Reload the page after saving the index.html file and check that you have changed the background colour.

{% include figure.html filename="en-or-creating-3d-scenes-games-threejs-02.png" alt="Basic webpage with peach background." caption="Figure 2. Webpage with peach background." %}

Next we need to add lights and something to see.

There are several different types of lights. We will add a hemisphere light and a directional light. The hemisphere light has 2 colours and an intensity (from 0 to 1), while the directional light has one colour and a position. Use the values supplied first and if everything is working later you can experiment with different values. You can add lights directly, like we do with the hemisphere light, or declare them, modify their parameters and then add them, like we do with the directional light.

In the function init() and after:

```
	camera.position.set( 0, 1.6, 3 ); //x, y, z
```

add:

```
    	scene.add( new THREE.HemisphereLight( 0xffffbb, 0x080820, .5) ); //sky colour, ground colour, intensity
	const light = new THREE.DirectionalLight( 0xffffff ); // colour
	light.position.set( 1, 6, 2 ); // x, y, z
	scene.add( light );
```

Now we will add some coloured spheres. Three.js has several basic geometries, including spheres, torus (donuts), planes and boxes. You could group many of these together to make a model, and we will use 9 spheres and a plane to make a vessel colour key for how the jars were made.

All objects are made from meshes of nodes (points) joined with edges.

{% include figure.html filename="sphere_mesh.png" alt="A framework of nodes and edges in the shaper of a sphere." caption="Figure 3. Mesh of a sphere with 15 width segments and 5 height segments." %}

Mesh backbones can then be decorated with 'materials' that have colour and other properties such as emission, roughness, metalness, opacity etc. They can also be decorated with image and other 'textures'.

{% include figure.html filename="red_sphere.png" alt="Sphere with red material." caption="Figure 4. The sphere with a standard material and red colour. A directional light is used." %}

A sphere 'geometry' is made with a size (in this case 0.04 m), number of width and height segments. If you increase the number of width or height segments you will get rounder spheres. The geometry is reused for 9 different sphere meshes. Each sphere mesh gets a material with a colour. We are using the standard material. There are alternatives that can be used and its important to note that some material types are more dependent on lights than others. 

The colours are set in the parameters list. We want to colour the jars by how they were made. Some communities used coils, while others used moulding and the 'paddle and anvil' method. The spheres we are creating now will form part of the key that lets the viewer know how the pots were made, by having them in a parameter list, we can just change the hex code and the key and pots will all change. Start with these values and alter them later if you want.

For each sphere we also set its position in x, y, z order. 

After:

```
    // Variables
```

Add:

```
    	let ratio = 2;
	let desk = 0.8; // desk height
    	let gheight = desk + 0.55; //panel height
	let psize = 1.0; // panel dimensions

```

and within the init function, after:

```
scene.add( light );
```

Add: 

```
	const parameters = {
		materialColor: '#9c5315', 
		ringTopColor: '#19ffE7',
		coilColor: '#ff0000',
		paddleColor: '#1e2f97', 
		coilBeatenColor: '#e8e337',
		paddleAddColor: '#a61ef4',
		wangelaColor: '#BEBEBE', 
		amphColor: '#fc9483',
		nabColor: '#209F00' 
    	}
    //spheres for key
	const sphere = new THREE.SphereGeometry( 0.04, 15, 5); //radius, width segments, height segments

	const sphere1 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.materialColor })); 
	sphere1.position.set( 0.84, gheight + (psize *.30), -.75); 

	const sphere2 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.coilColor })); 
	sphere2.position.set( 0.84, gheight + (psize *.21), -.75); 

	const sphere3 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.wangelaColor })); 
	sphere3.position.set( 0.84, gheight - (psize *.15), -.75); 

	const sphere4 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.nabColor })); 
	sphere4.position.set( 0.84, gheight - (psize *.06), -.75); 

	const sphere5 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.paddleAddColor})); 
	sphere5.position.set( 0.84, gheight - (psize *.35), -.75); 

	const sphere6 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.coilBeatenColor})); 
	sphere6.position.set( 0.84, gheight + (psize *.03), -.75); 

	const sphere7 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.amphColor })); 
	sphere7.position.set( 0.84, gheight - (psize *.44), -.75); 

	const sphere8 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.paddleColor})); 
	sphere8.position.set( 0.84, gheight - (psize *.25), -.75); 

	const sphere9 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.ringTopColor})); 
	sphere9.position.set( 0.84, gheight + (psize *.12), -.75); 

	scene.add( sphere1, sphere2, sphere3, sphere4, sphere5, sphere6, sphere7, sphere8, sphere9 );

```

Save and reload in the browser.

{% include figure.html filename="en-or-creating-3d-scenes-games-threejs-03.png" alt="Peach webpage with 9 spheres of different colours in a vertical line." caption="Figure 5. Webpage with nine differently coloured spheres." %}
## Adding the Information Panels and Map

Now we will add some planes. We want the information panels to face the camera, and the default planes do this. However, we want a plane for the map for the jars to sit on, so this plane has to be rotated 90 degrees (- Math.PI /2) around the x axis.

We will give the planes image 'textures'. Download the [`/textures` folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/creating-3d-scenes-games-threejs/textures) from this lesson's [`/assets` folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/creating-3d-scenes-games-threejs) and place it in the myscene folder. These textures are jpeg and png files and they all have pixels dimensions of 2<sup>n</sup> by 2<sup>n</sup>, eg 4096 × 2048. This helps with efficient rendering. Large image files will take longer to load and may not load at all. The use of images with text (created and exported from any graphics program such as Afinity Designer or Powerpoint) is one way to show text. Here we will create all the information panels for all the jars but hide them (by making .visbile = false) until the relevant jar is selected by the user. We will have a variable 'selectedPlane' to track which panel is showing and at the start an instruction panel will be selected. Some panels will be declared within the init function, but we only do this for panels or objects that will never change.

Textures need to be loaded by a 'TextureLoader'.

After:

```
    // Variables
```

Add:

```
    	let gallery, adzeraG, aibomG, mailuG, dimiriG, louisadeG, yabobG;
	let selectedPlane;			
```

and within the init function, after:

```
camera.position.set( 0, 1.6, 3 );
```

add:

```
const textureLoader = new THREE.TextureLoader()

const introTexture = textureLoader.load( 'textures/Intro.jpg' );
const refTexture = textureLoader.load( 'textures/sources.jpg' );			
const keyTexture = textureLoader.load( 'textures/key.jpg' );
const adzeraTexture = textureLoader.load( 'textures/Adzera.jpg' );
const aibomTexture = textureLoader.load( 'textures/Aibom.jpg' );
const mailuTexture = textureLoader.load( 'textures/Mailu.jpg' );
const dimiriTexture = textureLoader.load( 'textures/Dimiri.jpg' );
const louisadeTexture = textureLoader.load( 'textures/Louisade.jpg' );
const yabobTexture = textureLoader.load( 'textures/Yabob.jpg' );

gallery = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: introTexture }));
gallery.position.set( 0, gheight, -.75); 
selectedPlane = gallery;
const gallery2 = new THREE.Mesh(new THREE.PlaneGeometry( psize, psize ), new THREE.MeshBasicMaterial({ map: keyTexture }));
gallery2.position.set( 1.25, gheight, -.75); 
const gallery3 = new THREE.Mesh(new THREE.PlaneGeometry(psize, psize  ), new THREE.MeshBasicMaterial({ map: refTexture }));
gallery3.position.set( -1.25, gheight, -.75); 

scene.add( gallery, gallery2, gallery3);

adzeraG = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: adzeraTexture }));
adzeraG.position.set( 0, gheight, -.75); 

aibomG = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: aibomTexture }));
aibomG.position.set( 0, gheight, -.75); 

mailuG = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: mailuTexture }));
mailuG.position.set( 0, gheight, -.75); 

dimiriG = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: dimiriTexture }));
dimiriG.position.set( 0, gheight, -.75); 

louisadeG = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: louisadeTexture }));
louisadeG.position.set( 0, gheight, -.75); 

yabobG = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize ), new THREE.MeshBasicMaterial({ map: yabobTexture }));
yabobG.position.set( 0, gheight, -.75); 

scene.add( adzeraG, aibomG, mailuG, dimiriG, louisadeG, yabobG);
adzeraG.visible = false;
aibomG.visible = false;
mailuG.visible = false;
dimiriG.visible = false;
louisadeG.visible = false;
yabobG.visible = false;

//the Map
const mapGeometry = new THREE.PlaneGeometry( 3.0 * ratio, 1.5 * ratio );
const mapTexture = textureLoader.load('textures/png.png'); //from google maps
mapTexture.generateMipmaps = true //saves gpu if false
const theMap = new THREE.Mesh( mapGeometry, new THREE.MeshBasicMaterial({ map: mapTexture }));
theMap.rotation.x = - Math.PI / 2;
theMap.position.set( 0, desk, 0); //desk
scene.add( theMap);

```

Save and reload. If the panels are black, the images are probably in the wrong place. 

{% include figure.html filename="en-or-creating-3d-scenes-games-threejs-04.png" alt="Webpage with peach background, 3 square panels with text and a horizontal map of PNG." caption="Figure 6. Webpage with three vertical information panels and a horizontal map." %}

## Adding the Jar Models

Three.js can load many different types of models. However, the size is very important and large models will not load. Models are made from meshes, and the less nodes (points) or faces in the mesh the smaller the model size. Reducing the nodes or faces in a model, or retopology can be done in programs such as Blender. In Blender this is relatively easy, if the model is imported as a STL and if the model does not have an image texture. These models were primarily designed in Blender and reduced to under 700KB. They were exported as draco compressed GlTF (GL Transmission Format) files.

Draco-compressed GTLF files are one of the most memory efficient formats to use with Three.js. However, they require the importation of additional loaders. It is also possible to have multiple models in one GTLF file and to separate them once imported.

Download the [/models folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/creating-3d-scenes-games-threejs/models) from this lesson's [/assets folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/creating-3d-scenes-games-threejs) and put it in the myscene folder.

The jars will be added to a group (called 'jars') and the group will be added to the scene. This will allow us to specify later, that objects belonging to the jars group can be selected. 

Each jar will get a userdata property that will hold the information panel that is associated with it, so that when it is selected that panel can be shown. Note that the introduction of the 'piecescale' variable is not strictly necessary as it is set to the same as the ratio, but it can be changed later to be smaller or larger to alter the relative size of the jars to the map.

After:

```
import * as THREE from 'three';
```

add:

```
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';
import { DRACOLoader } from 'three/addons/loaders/DRACOLoader.js';
```

After:

```
	// Variables
```

add:

```
	const loader = new GLTFLoader();
	const dracoLoader = new DRACOLoader();
	dracoLoader.setDecoderPath( 'https://unpkg.com/three@0.160.0/examples/jsm/libs/draco/' );
	loader.setDRACOLoader( dracoLoader );

	let jars;
	let adzeraM, aibomM, mailuM, louisadeM, dimiriM, yabobM;
```

Within the init function after:

```
	scene.add( sphere1, sphere2, sphere3, sphere4, sphere5, sphere6, sphere7, sphere8, sphere9 );
```

add:

```
	jars = new THREE.Group();
	scene.add( jars );
	let piecescale = ratio;

	function onLoadAdzera( gltf ) {
		const model = gltf.scene;					
		adzeraM = model.children[0];
		adzeraM.material = new THREE.MeshStandardMaterial();
		adzeraM.position.set( 0.61 * ratio, desk + 0.01, 0.15 * ratio);
		adzeraM.scale.set( piecescale, piecescale, piecescale);
		adzeraM.material.color.set(parameters.coilBeatenColor);
		adzeraM.userData.planes = adzeraG;
		jars.add( adzeraM);
	}
				
	function onLoadAibom( gltf ) {
		const model = gltf.scene;					
		aibomM = model.children[0];
		aibomM.material = new THREE.MeshStandardMaterial();
		aibomM.position.set( 0.36* ratio, desk + 0.01,-0.01* ratio);
		aibomM.scale.set( piecescale, piecescale, piecescale);
		aibomM.material.color.set(parameters.materialColor);
		aibomM.userData.planes = aibomG;
		jars.add( aibomM);
	}

	function onLoadMailu( gltf ) {
		const model = gltf.scene;					
		mailuM = model.children[0];
		mailuM.material = new THREE.MeshStandardMaterial();
		mailuM.position.set(0.84* ratio, desk + 0.01, 0.48* ratio);
		mailuM.scale.set( piecescale, piecescale, piecescale);
		mailuM.material.color.set(parameters.nabColor);
		mailuM.userData.planes = mailuG;
		jars.add( mailuM);
	}

	function onLoadLouisade( gltf ) {
		const model = gltf.scene;					
		louisadeM = model.children[0];
		louisadeM.material = new THREE.MeshStandardMaterial();
		louisadeM.position.set( 0.99* ratio, desk + 0.01, 0.59* ratio );
		louisadeM.scale.set( piecescale, piecescale, piecescale);
		louisadeM.material.color.set(parameters.ringTopColor);
		louisadeM.userData.planes = louisadeG;
		jars.add( louisadeM);
	}

	function onLoadDimiri( gltf ) {
		const model = gltf.scene;					
		dimiriM = model.children[0];
		dimiriM.material = new THREE.MeshStandardMaterial();
		dimiriM.position.set( 0.43* ratio, desk + 0.01, 0* ratio);
		dimiriM.scale.set( piecescale, piecescale, piecescale);
		dimiriM.material.color.set(parameters.coilColor);
		dimiriM.userData.planes = dimiriG;
		jars.add( dimiriM);
	}

	function onLoadYabob( gltf ) {
		const model = gltf.scene;					
		yabobM = model.children[0];
		yabobM.material = new THREE.MeshStandardMaterial();
		yabobM.position.set( 0.572* ratio, desk + 0.01, 0.0396* ratio);
		yabobM.scale.set( piecescale, piecescale, piecescale);
		yabobM.material.color.set(parameters.paddleColor);
		yabobM.userData.planes = yabobG;
		jars.add( yabobM);
		}
	loader.load( 'models/gltf/adzera.glb', onLoadAdzera, undefined, function ( error ) { console.error( error );} );
	loader.load( 'models/gltf/aibom.glb', onLoadAibom, undefined, function ( error ) {console.error( error );} );	
	loader.load( 'models/gltf/mailu.glb', onLoadMailu, undefined, function ( error ) { console.error( error );} );
	loader.load( 'models/gltf/louisade.glb', onLoadLouisade, undefined, function ( error ) {console.error( error );} );
	loader.load( 'models/gltf/dimiri.glb', onLoadDimiri, undefined, function ( error ) { console.error( error );} );
	loader.load( 'models/gltf/yabob.glb', onLoadYabob, undefined, function ( error ) {console.error( error );} );
```

Save and reload and you should see 5 models. Number 6 is out of camera view.

{% include figure.html filename="en-or-creating-3d-scenes-games-threejs-05.png" alt="Five jar models sit on a map of Papua." caption="Figure 5. Webpage with six jars from Papua, but one is out of camera range." %}

Note that if you change 'let piecescale = ratio;' to 'let piecescale = ratio*2;' the vessels become bigger, but some will overlap.

You can calculate where to set the positions of the jars by taking into account the map dimensions.

## Adding Camera Controls to Move Around

We can add mouse controls to allow us to move around the scene. There are different types of controls, we will use 'orbit' controls that allow the user to rotate around the scene, zoom in and out, and if pressing shift, pan up and down or sideways. Alternatives are Arcball or FirstPerson controls, and you can see examples of these on the Three.js site. We need to import any controls. 

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
	let container, camera, scene, renderer; //declare the variables
```

to:

```
	let container, camera, scene, renderer, controls;
```

In the init, after:

```
	container.appendChild( renderer.domElement );
```

add:

```
	controls = new OrbitControls( camera, renderer.domElement);
	controls.target.set( 0, 1.6, 0 );
	controls.update();
```

If you save and reload you should be able to move around and zoom in and out.

## Adding Jar Selection

Next we want to add an event listener, to be able to select a jar and change the information panel.

After:

```
	// Variables
```

add:

```
	let raycasterM, pointer, selectedTorus; // for mouse controls
```

Within the init function definition, after:

```
	controls.update();
```

add:

```
	raycasterM = new THREE.Raycaster(); 
    	pointer = new THREE.Vector2(); 
	selectedTorus = new THREE.Mesh( new THREE.TorusGeometry( 0.015, 0.007, 20, 20  ), new THREE.MeshStandardMaterial({color: 0x006400})); 

	window.addEventListener( 'click', onClick );
```

Then we have to tell the listener what do do if there is a click in the window. We want to: make sure it does not use the orbit controls; take the click position and send a ray to the click position (from the camera) and see if any jars are there. If it finds any jars, it will unhighlight the last jar selected and hide that panel, it will then highlight (by making red emissive) the chosen jar, and make visible the panel that is linked to it in the userData.
After the resize listener:

```
	function onWindowResize() {
		...
	}
```

add:

```
	function onClick( event ) {
		event.preventDefault(); //stops the orbiting
		pointer.x = event.clientX / window.innerWidth * 2 - 1
		pointer.y = - (event.clientY / window.innerHeight) * 2 + 1
		raycasterM.setFromCamera( pointer, camera );
		const intersects = raycasterM.intersectObjects( jars.children);
				
		if(intersects.length > 0){
			selectedTorus.material.emissive.r = 0;
			const found = intersects[ 0 ].object;
			selectedTorus = found;
			found.material.emissive.r = 1;
			selectedPlane.visible = false;
			selectedPlane = found.userData.planes;
			selectedPlane.visible = true;
		}
	}	
```

{% include figure.html filename="en-or-creating-3d-scenes-games-threejs-06.png" alt="Five jars on a map with one glowing red as it has been selected." caption="Figure 6. Webpage showing the Iatmul jar selected with its red emission set to true, and the Iatmul information panel showing." %}

The next sections are optional. You can make the scene viewable in VR, turn the website into a puzzle game, add extra jars or do all three.

## Adding the Option to View in VR

The reason why the panels are positioned as they are, is that this site is designed to be viewed in VR. WebXR is an application programming interface (API) that translates between the web and hardware used for VR (or AR). Viewing the model in VR allows for easier inspection of the pots, especially if, as implemented in the next part of this series, the pots can be picked up and moved. 

Testing the site on a VR unit such as the Quest is more difficult. There is an emulator for chrome (https://chrome.google.com/webstore/detail/immersive-web-emulator/cgffilbpcibhmcfbgggfhfolhkfbhmik)- but it only works to a limited extent. If your computer runs on the same network as your VR unit, you can use the network address given when you serve with npx. Another solution is to use a Github page. As Github can take some time to rebuild/update, you can change the title text, so that you know that you are looking at the updated code. Github may limit the number of updates you can do in an hour. Follow the instructions for uploading the code to a Github page and the note the resulting address where a browser will be able to access the page. Remember to upload the models, textures, and style file as well.

The units in Three.js are metres and so the map will take up 3 by 1.5 m of space. If you want to use a much bigger map, you would have to consider making the map moveable, or implementing a 'teleport' type of movement. Note example Three.js code for teleportation is available.

When WebXR is added, a button will be created at the buttom of the website that will enable VR users to enter the immersive version. We will also add models for the controllers.

After:

```
	import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
```

add:

```
	import { VRButton } from 'three/addons/webxr/VRButton.js';
	import { XRControllerModelFactory } from 'three/addons/webxr/XRControllerModelFactory.js';
			
```

After:

```
	// Variables
```

add:

```
	let controller1, controller2, controllerGrip1, controllerGrip2;
```

In init, REPLACE:

```
	container.appendChild( renderer.domElement );
```

with:

```
	renderer.xr.enabled = true;
	container.appendChild( renderer.domElement );
	document.body.appendChild( VRButton.createButton( renderer ) );
```

In the init function, after:

```
	controls.update();
```

add:

```
	controller1 = renderer.xr.getController( 0 );
	scene.add( controller1 );
	controller2 = renderer.xr.getController( 1 );
	scene.add( controller2 );
	const controllerModelFactory = new XRControllerModelFactory();

	controllerGrip1 = renderer.xr.getControllerGrip( 0 );
	controllerGrip1.add( controllerModelFactory.createControllerModel( controllerGrip1 ) );
	scene.add( controllerGrip1 );

	controllerGrip2 = renderer.xr.getControllerGrip( 1 );
	controllerGrip2.add( controllerModelFactory.createControllerModel( controllerGrip2 ) );
	scene.add( controllerGrip2 );
```

Save and test on a computer, and in VR if possible.

## Adding Jar Selection to VR

The controllers can be used to select a jar and change the information panel. Event listeners will be added for the controller trigger being pressed down (EventStart) and then released (EventEnd). Additionally, when the view is being rendered, functions will be added to the render function, to check if the controllers are pointed at any jar, so the user knows what jar is being targetted and that it is selectable.

after:

```
	// Variables
```

add:

```
	let raycaster; // for VR controls
	const intersected = [];
	const tempMatrix = new THREE.Matrix4(); //for VR controllers
```

In the init function REPLACE:

```
	controller1 = renderer.xr.getController( 0 );
	scene.add( controller1 );
	controller2 = renderer.xr.getController( 1 );
	scene.add( controller2 );
```

with:

```
	controller1 = renderer.xr.getController( 0 );
	controller1.addEventListener( 'selectstart', onSelectStart );
	controller1.addEventListener( 'selectend', onSelectEnd );
	scene.add( controller1 );

	controller2 = renderer.xr.getController( 1 );
	controller2.addEventListener( 'selectstart', onSelectStart );
	controller2.addEventListener( 'selectend', onSelectEnd );
	scene.add( controller2 );
```

then after:

```
		scene.add( controllerGrip2 );
```

add:

```
		const geometry = new THREE.BufferGeometry().setFromPoints( [ new THREE.Vector3( 0, 0, 0 ), new THREE.Vector3( 0, 0, - 1 ) ] );
		const line = new THREE.Line( geometry );
		line.name = 'line';
		line.scale.z = 5;

		controller1.add( line.clone() );
		controller2.add( line.clone() );

		raycaster = new THREE.Raycaster(); //for VR
```

after the onWindowResize:

```
			function onWindowResize() {
				...
			}
```

add:

```
			function onSelectStart( event ) {
				const controller = event.target;
				const intersections = getIntersections( controller );
				if ( intersections.length > 0 ) {
					const intersection = intersections[ 0 ];
					const object = intersection.object;
					object.material.emissive.b = 0;				
					controller.userData.selected = object;
				}
			}

			function onSelectEnd( event ) {
				const controller = event.target;
				if ( controller.userData.selected !== undefined ) {
					const object = controller.userData.selected;
					object.material.emissive.b = 0;				
					selectedPlane.visible = false;
					selectedPlane = object.userData.planes;
					selectedPlane.visible = true;
					controller.userData.selected = undefined;
				}
			}


			function getIntersections( controller ) {
				tempMatrix.identity().extractRotation( controller.matrixWorld );
				raycaster.ray.origin.setFromMatrixPosition( controller.matrixWorld );
				raycaster.ray.direction.set( 0, 0, - 1 ).applyMatrix4( tempMatrix );
				return raycaster.intersectObjects( jars.children, false );
			}

			function intersectObjects( controller ) {
				// Do not highlight when already selected
				if ( controller.userData.selected !== undefined ) return;
				const line = controller.getObjectByName( 'line' );
				const intersections = getIntersections( controller );
				if ( intersections.length > 0 ) {
					const intersection = intersections[ 0 ];
					const object = intersection.object;
					object.material.emissive.r = 1;
					intersected.push( object );
					line.scale.z = intersection.distance;
				} else {
					line.scale.z = 5;
				}
			}

			function cleanIntersected() {
				while ( intersected.length ) {
					const object = intersected.pop();
					object.material.emissive.r = 0;
				}
			}
```

Lastly REPLACE:

```
	function render() {
		...
	}
```

with:

```
	function render() {
		cleanIntersected();
		intersectObjects( controller2 );
		intersectObjects( controller1 );
		renderer.render( scene, camera );
	}
```

Save, check on the localhost and then in VR.

## Designing a Game

When designing a game or puzzle, plan and sketch the layout. Consider, how will the user know what to do, and how a successful action is indicated. Also consider, if the puzzle is based on memory or logic? Consider consulting guides such as Schell (2015).

To transform the scene into a puzzle the information panel used needs to be altered, as it is the main source of user information. Another source of guidance to the user in the VR version, is to have items that are targetted for selection change colour when pointed at. 

The goal for the user of this game is to start with the jars off the map and the PNG communities marked by selectable tokens. When the communities are selected (mouse click, or VR left controller) the information panel will provide the information on the pots made by that community. Information on how the technique used to make the pot can be used to work out which of the jars may be a match, as the jars are coloured by the technique and a key is provided. The decoration technique may also serve as a guide. The user can move the jars (mouse or VR right controller). If they place the matching jar on the community marker then the jar becomes unmoveable and the background colour changes. 


## Adding Torus

Green torus will be used to mark the communities. They can be harder to aim for than discs, but most PNG communities use torus made of leaves to hold the vessels as they are being made. The torus are a basic three.js geometry, and the diameter, central hole size, and segmentation can be specified. However, torus are generated at the wrong angle for this game and need to be rotated (around the x axis) by 90 degrees (ie -Math.PI *1/2).

Because each torus is connected to a different information plane, they still need to be created separately and added to a torus group. The mouse click event listener and left controller listeners have to be altered so that they target the torus group instead of the jar group.

In the index.html file REPLACE:

```
let jars;
```

with:

```
let jars, torus;
```

in the init function after:

```
	let piecescale = ratio;
```

add:

```
	torus = new THREE.Group();
	scene.add( torus );

	const dimiriSite = new THREE.Mesh( new THREE.TorusGeometry(0.015, 0.007, 20, 20  ), new THREE.MeshStandardMaterial({color: 0x006400}));
	dimiriSite.position.set(0.43 *ratio, desk + 0.01, 0 *ratio);
	dimiriSite.scale.set( piecescale, piecescale, piecescale);
	dimiriSite.rotation.x = -Math.PI * 1/2;
	dimiriSite.userData.planes = dimiriG;
	torus.add(dimiriSite);

	const louisadeSite = new THREE.Mesh( new THREE.TorusGeometry( 0.015, 0.007, 20, 20 ), new THREE.MeshStandardMaterial({color: 0x006400}));
	louisadeSite.position.set(0.99* ratio, desk + 0.01, 0.59* ratio);
	louisadeSite.scale.set( piecescale, piecescale, piecescale);
	louisadeSite.rotation.x = -Math.PI * 1/2;
	louisadeSite.userData.planes = louisadeG;
	torus.add(louisadeSite);

	const mailuSite = new THREE.Mesh( new THREE.TorusGeometry( 0.015, 0.007, 20, 20 ), new THREE.MeshStandardMaterial({color: 0x006400}));
	mailuSite.position.set(0.84* ratio, desk + 0.01, 0.48* ratio);
	mailuSite.scale.set( piecescale, piecescale, piecescale);
	mailuSite.rotation.x = -Math.PI * 1/2;
	mailuSite.userData.planes = mailuG;
	torus.add(mailuSite);

	const adzeraSite = new THREE.Mesh( new THREE.TorusGeometry( 0.015, 0.007, 20, 20 ), new THREE.MeshStandardMaterial({color: 0x006400}));
	adzeraSite.position.set(0.61* ratio, desk + 0.01, 0.15* ratio);
	adzeraSite.scale.set( piecescale, piecescale, piecescale);
	adzeraSite.rotation.x = -Math.PI * 1/2;
	adzeraSite.userData.planes = adzeraG;
	torus.add(adzeraSite);

	const yabobSite = new THREE.Mesh( new THREE.TorusGeometry( 0.015, 0.007, 20, 20 ), new THREE.MeshStandardMaterial({color: 0x006400}));
	yabobSite.position.set(0.572* ratio, desk + 0.01, 0.0396* ratio);
	yabobSite.scale.set( piecescale, piecescale, piecescale);
	yabobSite.rotation.x = -Math.PI * 1/2;
	yabobSite.userData.planes = yabobG;
	torus.add(yabobSite);

	const aibomSite = new THREE.Mesh( new THREE.TorusGeometry( 0.015, 0.007, 20, 20 ), new THREE.MeshStandardMaterial({color: 0x006400}));
	aibomSite.position.set(0.36* ratio, desk + 0.01,-0.01* ratio);
	aibomSite.scale.set( piecescale, piecescale, piecescale);
	aibomSite.rotation.x = -Math.PI * 1/2;
	aibomSite.userData.planes = aibomG;
	torus.add(aibomSite);

	selectedTorus = aibomSite; 
```

save and check the torus appear on site reload.

{% include figure.html filename="en-or-creating-3d-scenes-games-threejs-07.png" alt="Five jars sit on green tori on a map of Papua." caption="Figure 7. Webpage with the jars sitting on tori." %}

in the onClick(event) function change:

```
const intersects = raycasterM.intersectObjects( jars.children);	
```

to:

```
const intersects = raycasterM.intersectObjects( torus.children);
```

save and check the mouse click and panel change now works on torus and not the jars.

IF you have implemented VR viewing, in the getIntersections function change:

```
return raycaster.intersectObjects( jars.children, false );
```

to:

```
return raycaster.intersectObjects( torus.children, false );
```

Save and check this works in VR if possible.

## Enabling Jar Movement

To be able to move the jars using the mouse, DragControls have to be imported and created.

After:

```
    import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
```

add:

```
	import { DragControls } from 'three/addons/controls/DragControls.js';
```

change:

```
	let container, camera, scene, renderer, controls;
```

to:

```
	let container, camera, scene, renderer, controls, dragControls;
```

in the init function after:

```
controls.update();

```

add:

```
	dragControls = new DragControls( [ jars ], camera, renderer.domElement );
	dragControls.addEventListener('dragstart', function (event) {
		controls.enabled = false
	})
	dragControls.addEventListener('dragend', function (event) {
        	controls.enabled = true
	})	

```

save and reload and check that you can now move the jars around.
However, you will see that it can be difficult to move jars in certain positions in 3D. It is easier to achieve if you view the scene directly from the top or directly from the side. This is one of the benefits of using the game in VR, it is much easier to move the vessels in three dimensions.

## Enabling Jar Movement in VR

To simplify things the right controller will move jars and the left will select sites. Alternate listeners will be created and added to the right controller.

After:

```
		const intersected = [];
```

add:

```
		const intersected2 = [];
```

in the init function change:

```
		controller2.addEventListener( 'selectstart', onSelectStart );
		controller2.addEventListener( 'selectend', onSelectEnd );
```

to:

```
		controller2.addEventListener( 'selectstart', onSelectStart2 );
		controller2.addEventListener( 'selectend', onSelectEnd2 );
```

after:

```
		function cleanIntersected() {
			...
		}
```

add:

```
			function onSelectStart2( event ) {
				const controller = event.target;
				const intersections = getIntersections2( controller );
				if ( intersections.length > 0 ) {
					const intersection = intersections[ 0 ];
					const object = intersection.object;
					object.material.emissive.b = 0;
					controller.attach( object );
					controller.userData.selected = object;
				}
			}

			function onSelectEnd2( event ) {
				const controller = event.target;
				if ( controller.userData.selected !== undefined ) {
					const object = controller.userData.selected;
					object.material.emissive.b = 0;				
					jars.attach( object );							
					controller.userData.selected = undefined;
				}
			}

			function getIntersections2( controller ) {
				tempMatrix.identity().extractRotation( controller.matrixWorld );
				raycaster.ray.origin.setFromMatrixPosition( controller.matrixWorld );
				raycaster.ray.direction.set( 0, 0, - 1 ).applyMatrix4( tempMatrix );
				return raycaster.intersectObjects( jars.children, false );
			}

			function intersectObjects2( controller ) {
			// Do not highlight when already selected
			if ( controller.userData.selected !== undefined ) return;
				const line = controller.getObjectByName( 'line' );
				const intersections = getIntersections2( controller );

			if ( intersections.length > 0 ) {
				const intersection = intersections[ 0 ];
				const object = intersection.object;
				object.material.emissive.r = 1;
				intersected2.push( object );
				line.scale.z = intersection.distance;

			} else {
				line.scale.z = 5;
			}
		}
		function cleanIntersected2() {
			while ( intersected2.length ) {
				const object = intersected2.pop();
				object.material.emissive.r = 0;
			}
		}
```

Change the render function from:

```
    	function render() {
			...
		}
```

to:

```
		function render() {
			cleanIntersected();
			cleanIntersected2();
			intersectObjects( controller1 );
			intersectObjects2( controller2 );
			renderer.render( scene, camera );
		}
```

Save and check in VR.

## Start Jars at Random Positions

To make the jars start in a random position above the map, change the position.set to x = Math.random() - 1, y = 1.2, and z = Math.random() * 0.5 - 0.3. Math.random() generates a number between 0 and 1 so all jars will be at the same height but in a random spot within 1 m wide and within a 0.5 m depth. Store the true location in a userData variable. Before you do this you may want to note, or take a screenshot of where at least one of the jars should go.

replace:

```
	function onLoadAdzera( gltf ) {
				...
	}
	........................
	function onLoadYabob( gltf ) {
				...
	}

```

with:

```
			function onLoadAdzera( gltf ) {
				const model = gltf.scene;					
				adzeraM = model.children[0];
				adzeraM.material = new THREE.MeshStandardMaterial();
				adzeraM.position.set( Math.random() - 1, 1.2, Math.random() * 0.5 - 0.3 );
				adzeraM.scale.set( piecescale, piecescale, piecescale);
				adzeraM.material.color.set(parameters.coilBeatenColor);
				adzeraM.userData.loc = new THREE.Vector3(0.61 * ratio, desk + 0.01, 0.15 * ratio);
				jars.add( adzeraM);
			}
							
			function onLoadAibom( gltf ) {
				const model = gltf.scene;					
				aibomM = model.children[0];
				aibomM.material = new THREE.MeshStandardMaterial();
				aibomM.position.set( Math.random() - 1, 1.2, Math.random() * 0.5 - 0.3 );
				aibomM.scale.set( piecescale, piecescale, piecescale);
				aibomM.material.color.set(parameters.materialColor);
				aibomM.userData.loc = new THREE.Vector3(0.36* ratio, desk + 0.01,-0.01* ratio);
				jars.add( aibomM);
			}	

			function onLoadMailu( gltf ) {
				const model = gltf.scene;					
				mailuM = model.children[0];
				mailuM.material = new THREE.MeshStandardMaterial();
				mailuM.position.set(Math.random() - 1, 1.2, Math.random() * 0.5 - 0.3 );
				mailuM.scale.set( piecescale, piecescale, piecescale);
				mailuM.material.color.set(parameters.nabColor);
				mailuM.userData.loc = new THREE.Vector3(0.84* ratio, desk + 0.01, 0.48* ratio);
				jars.add( mailuM);
			}

			function onLoadLouisade( gltf ) {
				const model = gltf.scene;					
				louisadeM = model.children[0];
				louisadeM.material = new THREE.MeshStandardMaterial();
				louisadeM.position.set( Math.random() - 1, 1.2, Math.random() * 0.5 - 0.3  );
				louisadeM.scale.set( piecescale, piecescale, piecescale);
				louisadeM.material.color.set(parameters.ringTopColor);
				louisadeM.userData.loc = new THREE.Vector3(0.99* ratio, desk + 0.01, 0.59* ratio);
				jars.add( louisadeM);
			}

			function onLoadDimiri( gltf ) {
				const model = gltf.scene;					
				dimiriM = model.children[0];
				dimiriM.material = new THREE.MeshStandardMaterial();
				dimiriM.position.set( Math.random() - 1, 1.2, Math.random() * 0.5 - 0.3 );
				dimiriM.scale.set( piecescale, piecescale, piecescale);
				dimiriM.material.color.set(parameters.coilColor);
				dimiriM.userData.loc = new THREE.Vector3(0.43* ratio, desk + 0.01, 0* ratio);
				jars.add( dimiriM);
			}

			function onLoadYabob( gltf ) {
				const model = gltf.scene;					
				yabobM = model.children[0];
				yabobM.material = new THREE.MeshStandardMaterial();
				yabobM.position.set( Math.random() - 1, 1.2, Math.random() * 0.5 - 0.3 );
				yabobM.scale.set( piecescale, piecescale, piecescale);
				yabobM.material.color.set(parameters.paddleColor);
				yabobM.userData.loc = new THREE.Vector3(0.572* ratio, desk + 0.01, 0.0396* ratio);
				jars.add( yabobM);
			}

```

Save and reload, you should see the jars starting above the map and if you reload, they will be in different random positions.

{% include figure.html filename="en-or-creating-3d-scenes-games-threejs-08.png" alt="Six jars float at random positions above a map of Papua." caption="Figure 8. Webpage with the jars at random start positions above the map." %}

## Check for Successful Matches

At the end of each jar movement, you want to check if the jar was moved to the correct spot. To do this you need to determine the distance between the jar and either the true location stored in the userData or the matching site (torus). Here we will use the true location, but if movement of the map was ever allowed, it would have to be changed to the site or position relative to the map. You need to set an allowed distance difference that will allow for non-exact placement, but will not be successful if a jar is placed on a torus nearby, here we will use 5 cm.

If the test is successful, there has to be a signal to the user. Here we will change the background colour to a random colour, and make the jar unmoveable (and rotate it to be upright). No signal will be given for an incorrect match. We will create an additional group called 'unmoveable' and attach any jars that are placed close enough to their torus to that group. Objects can only be attached to one group, so when a model is moved to 'unmoveable' it will no longer be in 'jars' and so the mouse or VR controller will not detect it.

Change:

```
let jars, torus;
```

to:

```
let jars, torus, trueposition, unmoveable;
```

within in the init function, after:

```
	scene.add( jars );
```

add:

```
	unmoveable = new THREE.Group();
	scene.add(unmoveable); 
```

For the mouse controls, change:

```
	dragControls.addEventListener('dragend', function (event) {
        	...
		})	
```

to:

```
	dragControls.addEventListener('dragend', function (event) {
    		controls.enabled = true
		let object = event.object;
		let aposition = object.position; 			
		trueposition = object.userData.loc;
		if ( aposition.distanceTo( trueposition ) < .025 * ratio) {
			scene.background = new THREE.Color( Math.random() * 0xffffff ); // random
			object.position.set(trueposition.x, trueposition.y, trueposition.z);
			object.rotation.set(0, 0, 0);
			unmoveable.attach( object );
		}		
    	})
```

You can save and test this. Moving in 3D can be difficult, its best done in multiple steps viewing from the side to lower the jar to the map and then the top (birds eye view) to place in the right spot, or vice versa.

{% include figure.html filename="en-or-creating-3d-scenes-games-threejs-09.png" alt="While 5 jars are randomly above the map, the Iatmul jar has been moved close to its torus." caption="Figure 9. Moving jars, such as the Iatmul jar, close to their tori is best done in multiple steps and best done when viewing the scene directly from the front, side or above." %}

{% include figure.html filename="en-or-creating-3d-scenes-games-threejs-10.png" alt="Birdseye view of jars and map, with the background changed to a pink colour to show that the Iatmul jar has been correctly positioned." caption="Figure 10. Moving jars while viewing the scene from above helps correctly position jars, triggering a background (random) colour change." %}

{% include figure.html filename="en-or-creating-3d-scenes-games-threejs-11.png" alt="Normal view of the jars and map, with the Iatmul jar in its correct position." caption="Figure 11. The Iatmul jar in its correct position." %}

For the VR controller, replace:

```
	function onSelectEnd2( event ) {
		...
	}
```

with:

```
	function onSelectEnd2( event ) {
		const controller = event.target;
		if ( controller.userData.selected !== undefined ) {
			const object = controller.userData.selected;
			object.material.emissive.b = 0;				
			//test if position is right
			let aposition = new THREE.Vector3(0,0,0); //needs to be something first
			object.getWorldPosition( aposition ); //a Vector3 (x,y,z)
			trueposition = object.userData.loc;
			jars.attach( object );
			if ( aposition.distanceTo( trueposition ) < .025 * ratio) {
				scene.background = new THREE.Color( Math.random() * 0xffffff ); // random
				object.position.set(trueposition.x, trueposition.y, trueposition.z);
				object.rotation.set(0, 0, 0);
				unmoveable.attach( object );
			}									
			controller.userData.selected = undefined;
		}
	}
```

## Update the Instructions

Lastly, to update the instructions in the first intro panel change the texture to the intro2.jpg
REPLACE:

```
	const introTexture = textureLoader.load( 'textures/Intro.jpg' );
```
	
with:

```
	const introTexture = textureLoader.load( 'textures/Intro2.jpg' );
```

save and check the new instructions appear.

## Adding Additional Jars

Pots were made in many different forms by different communities in PNG. There are models and information panels for 29 communities in the folders provided. If you want to experiment with adding them, the following table provides the model name, matching panel, location and colour parameter name to use. Each needs a model name, loading function, panel name and a site/torus (game only). These can be called anything (avoid special characters), but remember to declare them.

| Model | Texture | Position | Colour |
| --- | --- | --- | ---|
| agarbai.glb | Agarabi.jpg |  0.55 * ratio, desk + 0.01, 0.15 * ratio | coilBeatenColor |
| aloalo.glb | Aloalo.jpg | 0.9* ratio, desk + 0.01, 0.49* ratio | ringTopColor |
| bau.glb | Bau.jpg | 0.535* ratio, desk + 0.01, 0.04* ratio | coilColor |
| meno.glb | Meno.jpg |  0.28* ratio, desk + 0.01, -0.01* ratio | coilColor |
| binadean.glb | Biawaria.jpg | 0.76 * ratio, desk + 0.01, 0.34 * ratio | coilBeatenColor |
| boiken.glb | Boikin.jpg | 0.37* ratio, desk + 0.01, -0.08* ratio | coilColor |
| collingwood.glb | Collingwood.jpg | 0.85* ratio, desk + 0.01, 0.4* ratio | wangelaColor |
| demta.glb | Demta.jpg | 0.13* ratio, desk + 0.01, -0.16* ratio | materialColor |
| guhu.glb | guhu.jpg | 0.65* ratio, desk + 0.01, 0.23* ratio | coilColor |
| huon.glb | Huon.jpg | 0.71* ratio, desk + 0.01, 0.13* ratio | paddleColor |
| ilesales.glb | IleSales.jpg |  -0.34* ratio, desk + 0.01, 0.11* ratio | paddleColor |
| kaiep.glb | Kaiep.jpg | 0.41* ratio, desk + 0.01, -0.07* ratio | paddleColor |
| kombio.glb | Kombio.jpg | 0.29* ratio, desk + 0.01, -0.05* ratio | coilColor |
| kwimbu.glb | Abelam.jpg | 0.33* ratio, desk + 0.01, -0.06* ratio | coilColor |
| lumi.glb | Lumi.jpg | 0.25* ratio, desk + 0.01, -0.08* ratio | coilColor |
| maluku.glb | Maluku.jpg | -0.86* ratio, desk + 0.01, -0.08* ratio | paddleAddColor |
| manus.glb | Manus.jpg | 0.66* ratio, desk + 0.01, -0.2* ratio | paddleColor |
| marik.glb | Marik.jpg |  0.575* ratio, desk + 0.01, 0.079* ratio | coilColor |
| moto.glb | Moto.jpg |  0.71* ratio, desk + 0.01, 0.42* ratio | paddleColor |
| pubineri.glb | Pubineri.jpg |  0.28* ratio, desk + 0.01, -0.01* ratio |  coilColor |
| triobriand.glb | Triobriand.jpg | 1.01* ratio, desk + 0.01, 0.33* ratio | amphColor |
| tumleo.glb | Tumleo.jpg | 0.27* ratio, desk + 0.01, -0.12* ratio | paddleColor |
| waiGeo.glb | Waigeo.jpg |  -0.65* ratio, desk + 0.01, -0.35* ratio | paddleAddColor |

{% include figure.html filename="en-or-creating-3d-scenes-games-threejs-12.png" alt="Many jars on a map of Papua." caption="Figure 12. Additional jars can be addded to the scene and puzzle." %}

## Conclusion and Next Steps

This has been an introduction to using Three.js and the basic concepts in creating 3D scenes. The official [Three.js](https://threejs.org) website shows how much more complex pages can be created, with additions such as animations and sound. The [Three.js](https://threejs.org) site also contains example code that could be used for extending the puzzle created here, with sound effects for correct matches. Many sites, especially those with large models, feature loading bars, that give feedback to the user while the models load. Another possible extension, primarily for VR, would be to enable the map to be moved. While this allows everything to be scaled larger, it is important to consider usability issues, and the possibility of inducing user motion sickness.  

There are many ways cultural heritage models can be used interactively: vessels can be refitted (Hardy, 2023), site contexts could be toggled on and off, or objects could be virtually analysed (for p-XRF etc). Providing research data in such a format, has challenges, but also has the possibility for making findings more accessible and interesting to non-academic audiences.

## References

Dolbunova, E., Lucquin, A., McLaughlin, T.R., Bondetti, M., Courel, B., Oras, E., Piezonka, H., Robson, H.K., Talbot, H., Adamczak, K., Andreev, K., Asheichyk, V., Charniauski, M., Czekai-Zastawny, A., Ezepenko, I., Grechkina, T., Gunnarssone, A., Gusentsova, T.M., Haskevych, D., Ivanischeva, M., Kabacinski, J., Karmanov, V, Kosorukova, N., Kostyleva, E., Kriiska, A., Kukawka, S., Lozovskaya, O., Mazurkevich, Z., Nedomolkina, N., Piliciauskas, G., Sinitsyna, G., Skorobogatov, A., Smolyaninov, R.V., Surkov, A., Tkachov, O., Tkachova, Ml, Tsybrij, A., Tsybrij, V., Vybornov, A.A., Wawrusiewicz, A., Yudin, A.I., Meadows, J., Heron, C., Craig O.E. 2023. The Transmission of Pottery Technology Among Prehistoric European Hunter-Gatherers. Nature Human Behaviour. 7:171. 


Hardy, K. 2023. The creation of 'Uvira's Pot', a virtual reality puzzle to promote engagement with archaeological research. Conference: Digital Humanities 2023. Collaboration as Opportunity (DH2023) At: Graz, Austria.


Holtorf, C. 2005. From Stonehenge to Las Vegas. Archaeology as popular culture. Walnut Creek: AltaMira Press.


Maschner, H. July 2022 (https://sketchfab.com/blogs/community/cultural-heritage-spotlight-global-digital-heritage/?utm_source=website&utm_campaign=newsfeed)


May, P., Tuckson, M. 2000. The Traditional Pottery of Papua New Guinea. Crawford House Publishing, Adelaide.


O'Brien, M.J., Lyman, R.L., Collard, M., Holdern, C.J., Gray, R.D., Shennan, S.J. 2008. Transmission, Phylogenetics and the Evolution of Cultural Diversity. In: Cultural Transmission and Archaeology: Issues and Case Studies. Society for American Archaeology. Washington.


Pétrequin, A.-M., Pétrequin, P. 2006. Objets de Pouvoir en Nouvelle Guinée: Approche Ethnoarchéologique d’un Système de Signes Sociaux: Catalogue de la Donation Anne-Marie et Pierre Pétrequin. Réunion des Musées Nationaux, Paris.

Schell, J. 2015. The Art of Game Design: A Book of Lenses. CRC Press. FL.
