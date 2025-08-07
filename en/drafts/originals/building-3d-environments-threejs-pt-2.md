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
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

In part 1 of this lesson we used three.js to create a website featuring a camera and a scene with lights, camera navigation controls and a model. In part 2 we will make the model more interactive and as part of this we will make or import the various model components separately. The primary goal of thia part is to use three.js to create a webpage featuring a 3D scene with selectable components. Scene creation will involve adding lights, cameras, primitive models (such as spheres and planes), complex models (the pot forms), and controls. The models will get materials and/or image textures. Concepts such as model groups, scale and visibility, and 3D co-ordinates will be introduced. An additional goal of part 2, is to change the webpage into a game by making the models moveable and initally positioned at random places, with the webpage viewer then required to match the vessel to its maker community. A test in the code is run after each time a model is moved, to see if it has been placed in the correct position and successful matches trigger a background colour change.

## Setting Up

In addition to the requirements in part 1, you will need to download the [`/models` folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/building-3d-environments-threejs-pt-1-2/models) containing the individual jar models, and the [`/textures` folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/building-3d-environments-threejs-pt-1-2/textures) with information about them, from this lesson's [`/assets` folder](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/building-3d-environments-threejs-pt-1-2).

Put (or replace) the downloaded models and texture folders in the myscene folder (Figures 1-2). Keep the index.html and main.css files that you created in part 1.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-01.png" alt="Screenshot of the VSC editor showing a list of glb files in the expanded models folder." caption="Figure 1. File structure for part 2 as shown in VSC, with the models folder expanded." %}

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-02.png" alt="Screenshot of the VSC editor showing a list of jpg files in the expanded textures folder." caption="Figure 2. File structure for part 2 as shown in VSC, with the textures folder expanded." %}

If you made autoRotate true, comment out that line (ie add // to the beginning of the line) and also comment out the controls.update in the render function (make sure not to touch the one in the init function). In the index.html file from part 1, remove the code that loads the glTF model used in part 1: 
ie remove

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

## Planning

Before constructing a scene or game it is helpful to draft out (by hand or using Powerpoint etc), mock ups in all three views (Figure 3). In the mock-ups include the positve and negative directions of the axis and rough measurements of distances between objects and their proportions. Three.js uses metres as the measurement unit, although this is really only important if you plan to have your site viewable in virtual reality (VR). Include a rough camera and light (for those that have them) position. The scene will have 4 planes (a map, and 3 gallery panels), 9 spheres (as part of the colour key), 6 jars (not really shown on the sketch, although their positions are indicated by the sites in the birds-eye view). The game will feature 6 tori for the sites, and the jars will appear in an area above the map. You can also use the (threejs editor)[https://threejs.org/editor/] to help visualise and refine placements.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-03.png" alt="Scene mock-ups in z, x and y views." caption="Figure 3. Affinity Design versions of the hand-drawn sketches for planning the game. Mock-ups of all 3 views are done, with rough coordinates and spacing for the scene assets (here the camera, light, the map, information panels and a key panel featuring 9 spheres, the jar/site positions, and the area that in the game the jars will randomly start). Coordinates are x, y, z. Note light is off the scale in the y axis." %}

Planning also helps identify where you will be using the same value repeatedly, such as the x and z positions of the key spheres, and we can use variables for these values, so that if we want to alter them it is easier. It also identifies where measurements are dependent on other measurements. Here the height of the galleries is dependent on the height of the map, because we want them to be above the map, so we can have a variable 'desk' for the map height and a variable 'gheight' for the gallery height that is dependent on the desk variable (ie equal to desk + 0.55). The placement of the map at this y value was because the site was designed to be able to be viewed in VR. 

## Adding the Spheres for a Colour Key

If you do not have the local server running, start it with 
```
npx serve
```
and you should be back to an empty scene with a peach background.

You might have noticed that the pots in the model of part 1 were different colours. These colours relate solely to how the pots were made and we will construct a key to communicate this to the viewer.

To do this we will add some coloured objects. Three.js has several basic 2D geometries, including plane, circle, ring and shape, and more 3D geometries that include spheres, boxes, tori (donuts), cylinders and tetrahedrons (Figure 4). The parameters for these generally include lengths (in metres) and numbers of segments (height, width etc) but they can also be given parameters to create partial shapes. There are also some more complicated geometries, including lathes, that will not be used here, that are made from a series of user provided 2D points, that are then rotated in the third dimension.  

We will use 9 spheres and a plane to make a vessel colour key for how the jars were made. A sphere 'geometry' is made with a radius size (in this case 0.04 m), number of width and height segments (Figure 4). If you increase the number of width or height segments you will get rounder spheres. The geometry is reused for 9 different sphere meshes. Each sphere mesh gets a material with a colour. We are using the standard material. There are alternatives that can be used and it is important to note that some material types are more dependent on lights than others. 


{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-04.png" alt="Six different geometries: sphere, box, cyclinder, torus and lathe are shown in wireframe." caption="Figure 4. The 3D geometries that three.js can add include spheres, boxes, tori, cyclinders, tetrahedron and lathes. Parameters for the geometries often include length and segment number measurments. Lathe geometries are generated from a series of points (that are then rotated) and the most simple lathe is shown." %}

The colours are set in the parameters list. We want to colour the jars by how they were made. Some communities used coils, while others used moulding and the 'paddle and anvil' method. The spheres we are creating now will form part of the key that lets the viewer know how the pots were made, by having them in a parameter list, we can just change the hex code and the key and pots will all change. Start with these values and alter them later if you want.

For each sphere we also set its position in x, y, z order. 

After:

```
    let desk = 0.8;
```

Add:

```
    	let gheight = desk + 0.55; //panel height
	let psize = 1.0; // panel dimensions
	let sphereposx = 0.84 // key sphere x position
	let sphereposz = -0.75 // key sphere z position

```

and within the init function, after:

```
scene.add( light );
```

Add: 

```
	// add models

	// add key for jar colours using spheres and a plane
	const parameters = { // colours for the key spheres and the jars
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
	const sphere = new THREE.SphereGeometry( 0.04, 15, 5); //radius in metres, width segments, height segments. Will be reused.
	const sphere1 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.materialColor })); 
	sphere1.position.set( sphereposx, gheight + 0.30, sphereposz); 
	const sphere2 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.coilColor })); 
	sphere2.position.set( sphereposx, gheight + 0.21, sphereposz); 
	const sphere3 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.wangelaColor })); 
	sphere3.position.set( sphereposx, gheight - 0.15, sphereposz); 
	const sphere4 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.nabColor })); 
	sphere4.position.set( sphereposx, gheight - 0.06, sphereposz); 
	const sphere5 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.paddleAddColor})); 
	sphere5.position.set( sphereposx, gheight - 0.35, sphereposz); 
	const sphere6 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.coilBeatenColor})); 
	sphere6.position.set( sphereposx, gheight + 0.03, sphereposz); 
	const sphere7 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.amphColor })); 
	sphere7.position.set( sphereposx, gheight - 0.44, sphereposz); 
	const sphere8 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.paddleColor})); 
	sphere8.position.set( sphereposx, gheight - 0.25, sphereposz); 
	const sphere9 = new THREE.Mesh( sphere,  new THREE.MeshStandardMaterial( {color: parameters.ringTopColor})); 
	sphere9.position.set( sphereposx, gheight + 0.12, sphereposz); 
	scene.add( sphere1, sphere2, sphere3, sphere4, sphere5, sphere6, sphere7, sphere8, sphere9 );
	

```

Save and reload in the browser and you should see a webpage with nine differently coloured spheres (Figure 5).

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-05.png" alt="Webpage with 9 spheres of different colours in a vertical line." caption="Figure 5. Webpage with nine differently coloured spheres." %}

### Adding the Information Panels and Map

Now we will add some planes. We want the information panels to face the camera, and the default planes do this. However, we want a plane for the map for the jars to sit on, so this plane has to be rotated 90 degrees (- Math.PI /2) around the x axis.

We will give the planes image ‘textures’ that contain text describing the individual artefacts. These textures are jpeg and png files and they all have pixels dimensions of 2<sup>n</sup> by 2<sup>n</sup>, eg 4096 × 2048. This helps with efficient rendering. Large image files will take longer to load and may not load at all. The use of images with text (created and exported from any graphics program such as Affinity Designer or PowerPoint) is one way to show text. There are [alternatives](https://threejs.org/docs/index.html#manual/en/introduction/Creating-text). Here we will create all the information panels for all the jars but hide them (by making .visible = false) until the relevant jar is selected by the user. We will have a variable 'selectedPlane' to track which panel is showing and at the start an instruction panel will be selected. Some panels will be declared within the init function, but we only do this for panels or objects that will never change.

Textures need to be loaded by a 'TextureLoader'.

After:

```
    // Variable declaration and setting
```

Add:

```
	let gallery, adzeraG, aibomG, mailuG, dimiriG, louisadeG, yabobG; // information panels for the different jars
	let selectedPlane;	// which information panel will be visible
	let ratio = 2; 
	let piecescale = ratio; 
			
```

and within the init function, after:

```
// add models
```

add:

```
	// add information panels, key panel and reference panel by loading textures then adding planes .
	// load textures and generate Mipmaps
	const textureLoader = new THREE.TextureLoader()
	const introTexture = textureLoader.load( 'textures/Intro.jpg' );
	introTexture.generateMipmaps = true;
	const refTexture = textureLoader.load( 'textures/sources.jpg' );
	refTexture.generateMipmaps = true;			
	const keyTexture = textureLoader.load( 'textures/key.jpg' );
	keyTexture.generateMipmaps = true;
	const adzeraTexture = textureLoader.load( 'textures/Adzera.jpg' );
	adzeraTexture.generateMipmaps = true;
	const aibomTexture = textureLoader.load( 'textures/Aibom.jpg' );
	aibomTexture.generateMipmaps = true;
	const mailuTexture = textureLoader.load( 'textures/Mailu.jpg' );
	mailuTexture.generateMipmaps = true;
	const dimiriTexture = textureLoader.load( 'textures/Dimiri.jpg' );
	dimiriTexture.generateMipmaps = true;
	const louisadeTexture = textureLoader.load( 'textures/Louisade.jpg' );
	louisadeTexture.generateMipmaps = true;
	const yabobTexture = textureLoader.load( 'textures/Yabob.jpg' );
	yabobTexture.generateMipmaps = true;

	// add introduction information panel and set the selected panel to it
	gallery = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: introTexture }));
	gallery.position.set( 0, gheight, sphereposz); 
	selectedPlane = gallery;
	// add the panel for the key
	const gallery2 = new THREE.Mesh(new THREE.PlaneGeometry( psize, psize ), new THREE.MeshBasicMaterial({ map: keyTexture }));
	gallery2.position.set( 1.25, gheight, sphereposz); 
	// add the panel for the references
	const gallery3 = new THREE.Mesh(new THREE.PlaneGeometry(psize, psize  ), new THREE.MeshBasicMaterial({ map: refTexture }));
	gallery3.position.set( -1.25, gheight, sphereposz); 

	scene.add( gallery, gallery2, gallery3);
	// add the jar information panels then make them not visible
	adzeraG = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: adzeraTexture }));
	adzeraG.position.set( 0, gheight, sphereposz); 

	aibomG = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: aibomTexture }));
	aibomG.position.set( 0, gheight, sphereposz); 

	mailuG = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: mailuTexture }));
	mailuG.position.set( 0, gheight, sphereposz); 

	dimiriG = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: dimiriTexture }));
	dimiriG.position.set( 0, gheight, sphereposz); 

	louisadeG = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize  ), new THREE.MeshBasicMaterial({ map: louisadeTexture }));
	louisadeG.position.set( 0, gheight, sphereposz); 

	yabobG = new THREE.Mesh( new THREE.PlaneGeometry( psize, psize ), new THREE.MeshBasicMaterial({ map: yabobTexture }));
	yabobG.position.set( 0, gheight, sphereposz); 

	scene.add( adzeraG, aibomG, mailuG, dimiriG, louisadeG, yabobG);
	adzeraG.visible = false;
	aibomG.visible = false;
	mailuG.visible = false;
	dimiriG.visible = false;
	louisadeG.visible = false;
	yabobG.visible = false;

	// add the map of New Guinea
	const mapGeometry = new THREE.PlaneGeometry( 3 * ratio, 1.5 * ratio );
	const mapTexture = textureLoader.load('textures/png.png'); // from google maps
	mapTexture.generateMipmaps = true // saves gpu if false
	const theMap = new THREE.Mesh( mapGeometry, new THREE.MeshBasicMaterial({ map: mapTexture }));
	theMap.rotation.x = - Math.PI / 2; // Equal to 90 degrees
	theMap.position.set( 0, desk, 0); // desk height
	scene.add( theMap);

```

Save and reload. If the panels are black, the images are probably in the wrong directory. 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-06.png" alt="Webpage with 3 square panels of text and a horizontal map of Papua." caption="Figure 6. Webpage with three vertical information panels and a horizontal map." %}

### Adding the Jar Models

As you saw in part 1, the jar models are made of meshes (Figure 7).

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-07.png" alt="Framework of a jar with a sculptured face." caption="Figure 7. Mesh of the Aibom jar." %}

As with the spheres, the jars will get a standard material with a colour (Figure 8). 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-08.png" alt="Jar with a sculptured face coloured brown." caption="Figure 8. The Aibom jar with a solid brown colour." %}

We will later change the emissive property of the material to show if a jar is selected (Figure 9).

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-09.png" alt="Jar with a sculptured face brightly coloured red." caption="Figure 9. The Aibom jar with red emission." %}

The jars will be added to a group (called 'jars') and the group will be added to the scene. This will allow us to specify later, that objects belonging to the jars group can be selected. 

Each jar will get a userdata property that will hold the information panel that is associated with it, so that when it is selected that panel can be shown. Note that the introduction of the 'piecescale' variable is not strictly necessary as it is set to the same as the ratio, but it can be changed later to be smaller or larger to alter the relative size of the jars to the map.

Model loading will be written in 3 different ways. All these ways are actually the same, but with different degrees of code condension. To begin with we will add one model, aibomM in a similar way to how we added the composite model in part 1. A function is defined 'onLoadAibom' that takes the .glb file and loads it when called by the loader.load() method. The program will not stop while loading the file which can take a while so to avoid problems do not try to add the model to a group outside the loading function code. 

Replace:

```
	let themodel;

```

with:

```	
	let jars;
	let adzeraM, aibomM, mailuM, louisadeM, dimiriM, yabobM;

```

Within the init function after:

```
	scene.add( sphere1, sphere2, sphere3, sphere4, sphere5, sphere6, sphere7, sphere8, sphere9 );
```

add:

```
	// add jar models. Added in group so they can be selected.
	jars = new THREE.Group();
	scene.add( jars );

	// loading function for Aibom jar model
	function onLoadAibom( gltf ) {				
		aibomM = gltf.scene.children[0];
		aibomM.material = new THREE.MeshStandardMaterial();
		aibomM.position.set( 0.36* ratio, desk + 0.01,-0.01* ratio);
		aibomM.scale.set( piecescale, piecescale, piecescale);
		aibomM.material.color.set(parameters.materialColor);
		aibomM.userData.planes = aibomG;
		jars.add( aibomM);
	}
	loader.load( 'models/aibom.glb', onLoadAibom, undefined, function ( error ) {console.error( error );} );	
```
Save and reload and you should see a model.

To avoid repetitive code we will define a function createModel(), and have the loader run this function when it loads the model. The function will take 4 arguments: the x position, the z position, the model colour and the matching gallery as these vary with the different models.  

Replace 

```
	// loading function for Aibom jar model
	function onLoadAibom( gltf ) {				
	...
	}
	loader.load( 'models/aibom.glb', onLoadAibom, undefined, function ( error ) {console.error( error );} );	
```
with
```
	//a function to make the model with the parameter specified
	function createModel(gltf, x, z, col, gallery){
		const model = gltf.scene.children[0];	
		model.material = new THREE.MeshStandardMaterial();
		model.position.set( x * ratio, desk + 0.01, z * ratio);	
		model.scale.set( piecescale, piecescale, piecescale);				
		model.material.color.set(col);
		model.userData.planes = gallery;
		return model;
	}

	//calls the createModel function but still in a separately defined function
	function onLoadAibom( gltf ) {							
		aibomM = createModel(gltf, 0.36, -0.01, parameters.materialColor, aibomG);			
		jars.add( aibomM);
	}
	loader.load( 'models/aibom.glb', onLoadAibom, undefined, function ( error ) {console.error( error );} );

```
Save and check the model still appears.
The code can be condensed further by using 'anonymous' functions, i.e. the function called is not named. It does not matter which method you use if you are writing your own code.

Replace 
```
	//calls the createModel function but still in a separately defined function
	function onLoadAibom( gltf ) {							
	...
	}
	loader.load( 'models/aibom.glb', onLoadAibom, undefined, function ( error ) {console.error( error );} );
```
with
```
	// directly has the onLoad function as an anonymous function in the loader.load
	// load a jar (filename, load function, function while loading, error function)
	loader.load( 'models/aibom.glb', function( gltf ) {							
		aibomM = createModel(gltf, 0.36, -0.01, parameters.materialColor, aibomG);			
		jars.add( aibomM);
	}, undefined, function ( error ) {console.error( error );} );

	loader.load( 'models/mailu.glb', function( gltf) {							
		mailuM = createModel(gltf, 0.84, 0.48, parameters.nabColor, mailuG);			
		jars.add( mailuM);
	}, undefined, function ( error ) { console.error( error );} );

	loader.load( 'models/louisade.glb', function( gltf ) {
		louisadeM = createModel(gltf, 0.99, 0.59, parameters.ringTopColor, louisadeG);			
		jars.add(louisadeM);
	}, undefined, function ( error ) {console.error( error );} );

	loader.load( 'models/adzera.glb', function( gltf ) {
		adzeraM = createModel(gltf, 0.61, 0.15, parameters.coilBeatenColor, adzeraG);			
		jars.add( adzeraM);
	}, undefined, function ( error ) {console.error( error );} );

	loader.load( 'models/dimiri.glb', function( gltf ) {
		dimiriM = createModel(gltf, 0.43, 0, parameters.coilColor, dimiriG);			
		jars.add( dimiriM);
	}, undefined, function ( error ) {console.error( error );} );

	loader.load( 'models/yabob.glb', function( gltf ) {
		yabobM = createModel(gltf, 0.572, 0.0396, parameters.paddleColor, yabobG);			
		jars.add( yabobM);
	}, undefined, function ( error ) {console.error( error );} );

```
Save and reload and you should see 5 models (Figure 10). You will have to move around to see the sixth.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-10.png" alt="Five jar models sit on a map of Papua." caption="Figure 10. Webpage with six jars from Papua, but one is out of camera range." %}

Note that if you change 'let piecescale = ratio;' to 'let piecescale = ratio*2;' the vessels become bigger, but some will overlap.

You can calculate where to set the positions of the jars by taking into account the map dimensions.



### Adding Jar Selection

Next we want to add an event listener, to be able to select a jar and change the information panel. As with the WindowResize event listener in part 1, this listener gets the event (in this case 'click'), and a function we will define. Input events pass event information to their function, some of which is dependent on the type of event. The 'click' event passes an object (commonly called 'event') that contains the mouse cursor's coordinates relative to the viewport/window. To determine what jar in 3D space is being targeted by the user's mouse in 2D space, three.js uses raycasting. The three.js raycaster 'sends' a 'ray' from the camera position to a pointer whose 2D position is calculated from the click event's information. The raycaster has an 'intersectObjects' method that returns an array of the 3D objects that the cast ray has hit. This array is ordered by distance to the camera so the first in the array will be the nearest object. We also tell the method what objects can be intersected  and here we will specify, children of the jars group. This is reason we made the group.


After:

```
	// Variable declaration and setting
```

add:

```
	let raycasterM, pointer, selectedObj; // for mouse controls
```

Within the init function definition, after:

```
	controls.update();
```

add:

```
	// Mouse controls for jar selection
	raycasterM = new THREE.Raycaster(); // ray to tell what is being pointed at
	pointer = new THREE.Vector2(); // x, y co-ordinates for the ray to aim at, empty to start
	selectedObj = new THREE.Mesh( new THREE.TorusGeometry( 0.015, 0.007, 20, 20  ), new THREE.MeshStandardMaterial({color: 0x006400})); // initialising the selected jar with something- here a torus, to prevent issues.

```

after:
```
	 window.addEventListener( 'resize', onWindowResize );
```

add:
```
	window.addEventListener( 'click', onClick );
```

Then we have to tell the listener what do do if there is a click in the window. We want to: make sure it does not use the orbit controls; take the click position and cast a ray to the click position (from the camera) and see if any jars are there. If it finds any jars, it will unhighlight the last jar selected and hide that panel, it will then highlight (by making red emissive) the chosen jar, and make visible the panel that is linked to it in the userData.
After the resize listener:

```
	function onWindowResize() {
		...
	}
```

add:

```
	// called on mouse click. Gets position of click, gets intersecting object, makes it emmisive gets the matching info plane
	function onClick( event ) { // event is the input event information being passed from the event
	event.preventDefault(); // stops the orbiting
	// gets 2D click position
	pointer.x = event.clientX / window.innerWidth * 2 - 1 // this formula comes from the three.js examples
	pointer.y = - (event.clientY / window.innerHeight) * 2 + 1
	// detects what the user is trying to select in 3D space from viewpoint and 2D pointer
	raycasterM.setFromCamera( pointer, camera );
	const intersects = raycasterM.intersectObjects( jars.children); // an array, nearest to camera will be first
	// if there is a jar being clicked		
	if(intersects.length > 0){
		selectedObj.material.emissive.r = 0; // turn the current selected obj back to not emissive. 0 is off
		const found = intersects[ 0 ].object; // get the selected jar, index 0 is the first
		selectedObj = found;
		found.material.emissive.r = 1; // turn the selected jar red emissive. 1 is on.
		selectedPlane.visible = false; // hide the current information panel
		selectedPlane = found.userData.planes; // get the new matching information panel for the selected jar
		selectedPlane.visible = true; // make the new panel visible
		}
	}	
```
Now you should be able to select a jar and the middle information panel should change to give information about that jar. You can try '.emissive.g' or 'emissive.b' if you want.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-11.png" alt="Five jars on a map with one glowing red as it has been selected." caption="Figure 11. Webpage showing the Aibom jar selected with its red emission set to true, and the Aibom information panel showing." %}

The next sections are optional. You can turn the website into a puzzle game or add extra jars.

## Designing a Game

When designing a game or puzzle, plan and sketch the layout. Consider if the puzzle is based on memory or logic. Consider consulting guides such as Schell (2015).

To transform the scene into a puzzle the information panel used needs to be altered, as it is the main source of user information. 

The goal for the user of this game is to start with the jars off the map and the Papuan communities marked by selectable tokens. When the communities are selected (mouse click) the information panel will provide the information on the pots made by that community. Information on the technique used to make the pot can be used to work out which of the jars may be a match, as the jars are coloured by the technique and a key is provided. The decoration technique may also serve as a guide. The user can move the jars (mouse). If they place the matching jar on the community marker then the jar becomes unmoveable and the background colour changes. 

### Adding Tori

Green tori will be used to mark the communities. They can be harder to aim for than discs, but most Papua New Guinea communities use tori made of leaves to hold the vessels as they are being made. The torus is a basic three.js geometry, and the diameter, central hole size, and segmentation can be specified. However, tori are generated at the wrong angle for this game and need to be rotated (around the x axis) by 90 degrees (i.e. -Math.PI /2).

Because each torus is connected to a different information panel, they still need to be created separately and added to a tori group. The mouse click event listener has to be altered so that it targets the tori group instead of the jars group. 

While each site COULD be added with code such as:
```
	const aibomSite = new THREE.Mesh( new THREE.TorusGeometry( 0.015, 0.007, 20, 20 ), new THREE.MeshStandardMaterial({color: 0x006400}));
	aibomSite.position.set(0.36* ratio, desk + 0.01, -0.01* ratio);
	aibomSite.scale.set( piecescale, piecescale, piecescale);
	aibomSite.rotation.x = -Math.PI * 1/2;
	aibomSite.userData.planes = aibomG;
```
it is also possible to make a function that takes position (x and z) co-ordinates and the relevant gallery. The function is then called for each site.


In the index.html file REPLACE
```
let jars;
```

with 
```
let jars, tori;
```
In the init function after
```
	scene.add( sphere1, sphere2, sphere3, sphere4, sphere5, sphere6, sphere7, sphere8, sphere9 );
```
add
```
	// Add sites as tori, in a group
	tori = new THREE.Group();
	scene.add( tori );

	// a function to make the site with the location and matching information panel
	function createSite(x, z, gallery){
		const model = new THREE.Mesh( new THREE.TorusGeometry( 0.015, 0.007, 20, 20 ), new THREE.MeshStandardMaterial({color: 0x006400}));
		model.position.set( x * ratio, desk + 0.01, z * ratio);	
		model.scale.set( piecescale, piecescale, piecescale);
		model.rotation.x = -Math.PI * 1/2;
		model.userData.planes = gallery;
		return model;
		}

	const aibomSite = createSite(0.36, -0.01, aibomG);
	const dimiriSite = createSite(0.43, 0, dimiriG);
	const louisadeSite = createSite(0.99, 0.59, louisadeG);
	const mailuSite = createSite(0.84, 0.48, mailuG);
	const adzeraSite = createSite(0.61, 0.15, adzeraG);
	const yabobSite = createSite(0.572, 0.0396, yabobG);
	tori.add(aibomSite, mailuSite, dimiriSite, louisadeSite, adzeraSite, yabobSite);

```

save and check the tori appear on site reload. 

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-12.png" alt="Five jars sit on green tori on a map of Papua." caption="Figure 12. Webpage with the jars sitting on tori." %}

You will see that nothing happens when you click on them, as the raycaster is only checking the jars for intersections. So in the onClick(event) function change:

```
const intersects = raycasterM.intersectObjects( jars.children);	
```

to:

```
const intersects = raycasterM.intersectObjects( tori.children);
```

save and check the mouse click and panel change now works on tori and not the jars.


### Enabling Jar Movement

To be able to move the jars using the mouse, DragControls have to be imported and created. The first argument when creating the DragControls determines what they can drag.

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
	pointer = new THREE.Vector2(); 

```

add:

```
	// Mouse controls for jar dragging
	dragControls = new DragControls( [ jars ], camera, renderer.domElement ); // first argument determines drag objects.	

```
Then we add event listeners for the 'dragstart' and 'dragstop' events. Here we will make the handler functions anonymous. We need to turn the orbital controls off while jars are being dragged.

After:
```
	window.addEventListener( 'click', onClick );
```
add:
```
	dragControls.addEventListener('dragstart', function (event) {
		controls.enabled = false // orbit controls off
	})
	dragControls.addEventListener('dragend', function (event) {
        	controls.enabled = true // orbit controls back on
	})
```

save and reload and check that you can now move the jars around.
However, you will see that it can be difficult to move jars in certain positions in 3D. It is easier to achieve if you view the scene directly from the top or directly from the side.

### Start Jars at Random Positions

To make the jars start in a random position above the map, change the position.set to x = Math.random() - 1, y = 1.2, and z = Math.random() * 0.5 - 0.3. Math.random() generates a number between 0 and 1 so all jars will be at the same height but in a random spot within 1m wide and within a 0.5m depth. Store the true location in a userData variable. Before you do this you may want to note, or take a screenshot of where at least one of the jars should go.

replace:

```
	function createModel(gltf, x, z, col, gallery){
		...
	}
			...

	loader.load( 'models/yabob.glb', function( gltf ) {
		...
	}, undefined, function ( error ) {console.error( error );} );

```

with:

```
	//a function to make the model with the parameter specified, model, colour, matching site
	function createModel(gltf, col, site){
		const model = gltf.scene.children[0];	
		model.material = new THREE.MeshStandardMaterial();
		model.position.set( Math.random() - 1, 1.2, Math.random() * 0.5 - 0.3 );
		model.scale.set( piecescale, piecescale, piecescale);
		model.material.color.set(col);
		model.userData.site = site;
		return model;
	}
	// directly has the onLoad function as an anonymous function in the loader.load
	loader.load( 'models/aibom.glb', function( gltf ) {							
		aibomM = createModel(gltf, parameters.materialColor, aibomSite);			
		jars.add( aibomM);
	}, undefined, function ( error ) {console.error( error );} );

	loader.load( 'models/mailu.glb', function( gltf) {							
		mailuM = createModel(gltf, parameters.nabColor, mailuSite);			
		jars.add( mailuM);
	}, undefined, function ( error ) { console.error( error );} );

	loader.load( 'models/louisade.glb', function( gltf ) {
		louisadeM = createModel(gltf, parameters.ringTopColor, louisadeSite);			
		jars.add(louisadeM);
	}, undefined, function ( error ) {console.error( error );} );

	loader.load( 'models/adzera.glb', function( gltf ) {
		adzeraM = createModel(gltf, parameters.coilBeatenColor, adzeraSite);			
		jars.add( adzeraM);
	}, undefined, function ( error ) {console.error( error );} );

	loader.load( 'models/dimiri.glb', function( gltf ) {
		dimiriM = createModel(gltf, parameters.coilColor, dimiriSite);			
		jars.add( dimiriM);
	}, undefined, function ( error ) {console.error( error );} );

	loader.load( 'models/yabob.glb', function( gltf ) {
		yabobM = createModel(gltf, parameters.paddleColor, yabobSite);			
		jars.add( yabobM);
	}, undefined, function ( error ) {console.error( error );} );


```

Save and reload, you should see the jars starting above the map and if you reload, they will be in different random positions.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-13.png" alt="Six jars float at random positions above a map of Papua." caption="Figure 13. Webpage with the jars at random start positions above the map." %}

### Check for Successful Matches

At the end of each jar movement, you want to check if the jar was moved to the correct spot. One way to do this is to determine the distance between the jar and the matching site (torus). You need to set an allowed distance difference that will allow for non-exact placement, but will not be successful if a jar is placed on a torus nearby, here we will use 5 cm (2.5cm * ratio).

The event object for drag events contains the identity of the object being dragged ('event.object'), so we can use that in the handler function. We can get the matching site from its userData, and then use the getWorldPosition method to find out the coordinates of the matching site. The getWorldPosition method puts the coordinates into a vector (x, y, z) that is given as an argument, in this case 'testposition'. This vector can not be null to begin with so it is set as (0,0,0). Then we use another vector 'aposition' to get the position of the selected object. We call the distanceTo method on the aposition vector to determine the distance between the two vectors and test if it is smaller than our allowed distance.

If the test is successful, there has to be a signal to the user. Here we will change the background colour to a random colour, and make the jar unmoveable (and rotate it to be upright). No signal will be given for an incorrect match. We will create an additional group called 'unmoveable' and attach any jars that are placed close enough to their torus to that group. Objects can only be attached to one group, so when a model is moved to 'unmoveable' it will no longer be in 'jars' and so the mouse will not detect it.

Change
```
let jars, tori;
```

to
```
let jars, tori, unmoveable;
let truesite = null;
let selectedObject = null;
```
within the init function, after:
```
	scene.add( jars );
```
add
```
	// add unmoveable group for jars that have been put in the correct spot
	unmoveable = new THREE.Group();
	scene.add(unmoveable);  
```
For the mouse controls, change
```
dragControls.addEventListener('dragend', function (event) {
        	...
})	
```
to
```
dragControls.addEventListener('dragend', function (event) {
	controls.enabled = true // turn the orbiting controls back on when dragging done
	selectedObject = event.object;
	truesite = selectedObject.userData.site;
	let testposition = new THREE.Vector3(0,0,0); //needs to be something first
	truesite.getWorldPosition( testposition ); //a Vector3 (x,y,z)
	let aposition = selectedObject.position; //way 1 test object position
					
	if ( aposition.distanceTo( testposition ) < .025 * ratio) {
		scene.background = new THREE.Color( Math.random() * 0xffffff ); // random
		selectedObject.position.set(testposition.x, testposition.y, testposition.z);
		selectedObject.rotation.set(0, 0, 0); // makes sure the jar is upright, necessary for VR.
		unmoveable.attach( selectedObject); // adding to the unmoveable group will remove from the jar group.
	}	
})
```
You can save and try to test this, but moving in 3D can be difficult and we will make it (somewhat) easier in the next step. Moving is best done in multiple steps viewing from the side to lower the jar to the map and then the top (birds eye view) to place it in the right spot, or vice versa.

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-14.png" alt="While 5 jars are randomly above the map, the Aibom jar has been moved close to its torus." caption="Figure 14. Moving jars, such as the Aibom jar, close to their tori is best done in multiple steps and best done when viewing the scene directly from the front, side or above." %}

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-15.png" alt="Birdseye view of jars and map, with the background changed to a pink colour to show that the Aibom jar has been correctly positioned." caption="Figure 15. Moving jars while viewing the scene from above helps correctly position jars, triggering a background (random) colour change." %}

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-16.png" alt="Normal view of the jars and map, with the Aibom jar in its correct position." caption="Figure 16. The Aibom jar in its correct position." %}

This way of placing the jars on the sites can be frustrating for users and the onClick function is actually called at the end of a drag event, thus you can also alter the onClick function to register a correct match if the drag ends with the mouse on the correct site. This alternative means that the match is tested in 2D space instead of in 3D space (as in the first approach), and thus matches are easier, especially for players not experienced with digital 3D environments. If you develop your own games you might want to test different approaches to see what works best. 

Replace 
```
function onClick( event ) {
			...
		}
```
with
```
// will also test if the jar is in right spot as onClick called at the end of drag event
function onClick( event ) {
	event.preventDefault(); //stops the orbiting
	// gets 2D click position
	pointer.x = event.clientX / window.innerWidth * 2 - 1 
	pointer.y = - (event.clientY / window.innerHeight) * 2 + 1
	// detects what the user is trying to select in 3D space from viewpoint and 2D pointer
	raycasterM.setFromCamera( pointer, camera );
	const intersects = raycasterM.intersectObjects( tori.children);
	// if tori being clicked		
	if(intersects.length > 0){
		selectedObj.material.emissive.r = 0; // turn the current selected obj back to not emissive
		const found = intersects[ 0 ].object; // get the selected site
		if(found == truesite){ // tests if site mouse is over is the same as the true jar site
			// if match change colour of background
			scene.background = new THREE.Color( Math.random() * 0xffffff ); // random
			// click to correct position in case slightly off
			let testposition = new THREE.Vector3(0,0,0); //needs to be something first
			truesite.getWorldPosition( testposition ); //a Vector3 (x,y,z) this is the position of the site
			selectedObject.position.set(testposition.x, testposition.y, testposition.z);
			// makes sure jar is upright (in VR it tilts)
			selectedObject.rotation.set(0, 0, 0); 
			unmoveable.attach( selectedObject );
		}
		selectedObj = found;
		found.material.emissive.r = 1; // turn the selected jar red emissive
		selectedPlane.visible = false; // hide the current information panel
		selectedPlane = found.userData.planes; // get the new matching information panel for the selected jar
		selectedPlane.visible = true; // make the new panel visible
	}
	truesite = null;
}	
```

### Update the Instructions

Lastly, to update the instructions in the first intro panel change the texture to the intro2.jpg.
So that

```
	const introTexture = textureLoader.load( 'textures/Intro.jpg' );
```
	
becomes

```
	const introTexture = textureLoader.load( 'textures/Intro2.jpg' );
```

save and check the new instructions appear.

## Adding Additional Jars

Pots were made in many different forms by different communities in Papua New Guinea and West Papua. There are models and information panels for 29 communities in the folders provided. If you want to experiment with adding them, the following table provides the model name, matching panel, location and colour parameter name to use. Each needs a model name, panel name and a site/torus (game only). These can be called anything (avoid special characters), but remember to declare them.

| Model | Texture | Position | Colour |
| --- | --- | --- | ---|
| agarabi.glb | Agarabi.jpg |  0.55 * ratio, desk + 0.01, 0.15 * ratio | coilBeatenColor |
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
| pubineri.glb | Pubineri.jpg |  0.53* ratio, desk + 0.01, 0.09* ratio |  coilColor |
| triobriand.glb | Triobriand.jpg | 1.01* ratio, desk + 0.01, 0.33* ratio | amphColor |
| tumleo.glb | Tumleo.jpg | 0.27* ratio, desk + 0.01, -0.12* ratio | paddleColor |
| waiGeo.glb | Waigeo.jpg |  -0.65* ratio, desk + 0.01, -0.35* ratio | paddleAddColor |

{% include figure.html filename="en-or-building-3d-environments-threejs-pt-2-17.png" alt="Many jars on a map of Papua." caption="Figure 17. Additional jars can be addded to the scene and puzzle." %}

## Conclusion and Next Steps
This has been an introduction to using three.js and the basic concepts in creating 3D scenes. The official [three.js](https://threejs.org) website shows how much more complex pages can be created, with additions such as animations and sound. The [three.js](https://threejs.org) site also contains example code that could be used for extending the puzzle created here, for example adding sound effects for correct matches. Many sites, especially those with large models, feature loading bars, that give feedback to the user while the models load. Another possible extension is to enable the scene to be viewed and manipulated in VR. The three.js site also contains links to places to ask the community for help, and links guides including [three.js Fundamentals](https://threejs.org/manual/#en/fundamentals). 

There are many ways cultural heritage models can be used interactively: vessels can be refitted (Hardy, 2023), site contexts could be toggled on and off, or objects could be virtually analysed, with images or measurements from scientific techniques revealed when the object is clicked on. Providing research data in such a format has challenges, but also has the possibility for making findings more accessible and interesting to non-academic audiences.


## References


Hardy, K. 2023. The creation of 'Uvira's Pot', a virtual reality puzzle to promote engagement with archaeological research. Conference: Digital Humanities 2023. Collaboration as Opportunity (DH2023) At: Graz, Austria.

Schell, J. 2015. The Art of Game Design: A Book of Lenses. CRC Press. FL.
