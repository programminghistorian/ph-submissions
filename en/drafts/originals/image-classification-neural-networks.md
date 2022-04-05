---
title: Creating Deep Convolutional Neural Networks for Image Classification
collection: lessons
layout: lesson
slug: image-classification-neural-networks
date: "2022-01-21"
authors:
- Nabeel Siddiqui
reviewers:
editors: Scott Kleinman
translator:
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/414
difficulty:
activity: analyzing
topics:
abstract: 

---

{% include toc.html %}

# Introduction
 
In the last few years, [machine learning](https://en.wikipedia.org/wiki/Machine_learning) has transformed [computer vision](https://en.wikipedia.org/wiki/Computer_vision), ultimately impacting a myriad of industries and disciplines. These innovations in the processing and analysis of images have enabled large scale exploration of cultural datasets previously requiring manual interpretation. Yet, these automated techniques come with their own set of challenges. Bias is rampant, and many machine learning techniques disproportionately damage women and communities of color. Humanities scholars, with their expertise in issues of identity and power, can serve as important bulwarks against growing digital inequality. Yet, the high barrier of entry in statistics and computer science required to comprehend machine learning algorithms has resulted in critical analysis often failing to look inside the "black box" to understand the underlying mechanisms.  

This tutorial provides a beginner friendly introduction to [convolutional neural networks](https://en.wikipedia.org/wiki/Convolutional_neural_network), a subset of machine learning, that provides the foundation for many automated image classification tasks. It seeks to accomplish two goals. First, the tutorial provides an explicit engagement with machine learning for scholars and activists as a way of making apparent how a typical machine learning model functions. Second, it equips humanities scholars with a methodological framework that allows them to ask new questions about their datasets. 

# Requirements

Although neural networks are a complex topic, I have done my best to simplify the material. While this removes nuance, it allows you to gain a conceptual understanding of how neural networks work even if you are completely new to the topic. We will be using [Google's Teachable Machine](https://teachablemachine.withgoogle.com/) to train our model—if you don't know what "training" a model is, don't worry. Teachable machine provides a drag and drop interface that will allow those without a coding background to still gain hands-on experience.

The latter half of the tutorial allows you to take the neural network you train in Teachable Machine and embed it onto a live website for creative and/or research purposes. To follow along with this, you need some familiarity with Javascript. [FreeCodeCamp](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/) has excellent and free interactive tutorials for those needing a refresher. I also recommend, [Javascript and jQuery: Interactive Front End Development](https://javascriptbook.com/) by Jon Duckett. If neither of these resources appeal to you, there are hundreds of additional tutorials and videos you can access online through a quick search. 

Along with JavaScript, you will need to have some familiarity with how your browser’s developer tools work. In particular, you should understand how to load up the Javascript console and look at its output. If you do need help, instructions for [Chrome](https://developer.chrome.com/docs/devtools/console/javascript/), [Firefox](https://developer.mozilla.org/en-US/docs/Tools/Web_Console), [Edge](https://docs.microsoft.com/en-us/microsoft-edge/devtools-guide-chromium/open/?tabs=cmd-Windows), and [Safari](https://support.apple.com/guide/safari/use-the-developer-tools-in-the-develop-menu-sfri20948/mac) are available. 

Finally, you should also know how to launch a live server on your computer. I recommend that you either use an extension for your code editor, such as [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) for [Visual Studio Code](https://code.visualstudio.com/), or [run a server through Python](https://pythonbasics.org/webserver/). 

# Setup and Dataset

To begin, we will create a "Project" folder that holds all the relavent files and images. To train the neural network in [Google's Teachable Machine](https://teachablemachine.withgoogle.com/) you need  a collection of labeled images. Before beginning, we will need to download our dataset. The dataset that we will be using consists of a series of paintings from [ArtUK](https://artuk.org/). ArtUK provides access to works that meet the requirements for "public ownership." Before its launch, most of the UK's paintings in public ownership were not in regular circulation. To combat this, ArtUK was founded as a means of providing the general public access to these materials.

The ArtUK website allows you to view the artworks by [topic](https://artuk.org/discover/topics), and we want to use these materials as a way to train an image classifier. You can [download a zip file containing the images here](assets/image-classification-neural-networks/dataset.zip). Place the zip file inside of your Projects folder and unzip it. You will find a folder called "dataset” with two additional folders inside: "training" and "testing." The training folder contains a series of artworks divided by topic. As the name implies, we will use these to actually train our data. In the testing folder, there are also photos divided by topic that we will use to test the image classifier after we complete training it. 

Now that we have downloaded all the files, we can go ahead and launch a live server on the Projects folder. 

# Purpose

For this tutorial, we will keep the purposes of our project simple. We want to create an image classifier that can determine which topic a new painting should go in. This type of analysis can be useful for historians. For instance, after you create a classifier, you can use it to determine which topic shows up the most frequently in a corpus over time, automate the creation of metadata for a database of artwork, or perhaps even produce an artistic project that takes the image classification topic ouptuts as inspiration. 

# What is a Neural Network

Rather than diving deep into the code, it is helpful to gain a broader foundation of neural networks. Say we have a simple task such as determining if an image is a picture of a square or triangle. If you have done any kind of coding, you will know that most programs require a sequence of steps to accomplish this task. Loops and statements (such as `for`, `while`, `if`, etc.) allow our programs to have branches that simulate logical thinking. In the case of determining if an image contains a shape, we may try to get the computer to count the amount of sides and display "square" if it finds four or "triangle" if it finds three. Distinguishing between geometric objects may seem like a relatively simple task, but it requires a programmer to not only define the characteristics of the shape but to also implement a sequence of steps to discern those characteristics. This task of classification becomes more difficult as we run into scenarios where the distinctions between images are more complex. For instance, look at the following images: 

{% include figure.html filename="cat.jpg" caption="Figure 1. A picture of a cat" %}
{% include figure.html filename="dog.jpg" caption="Figure 2. A picture of a dog" %}

As humans, we can easily determine which one is a dog and which one is a cat. However, outlining the exact difference is difficult. It turns out that humans are usually a lot better at figuring out nuances in vision than computers. What if we could get a computer to process images the way our brains do? This question forms the core of neural networks. 

As the name implies, neural networks take their inspiration from neurons in the brain. The following is a simplified look at what a biological and artificial neuron look like:

{% include figure.html filename="neuron.png" caption="Figure 3. A diagram of a biological and an artificial neuron. https://www.oreilly.com/library/view/mobile-artificial-intelligence/9781789344073/5ac86b1a-c080-49ea-a234-5335f12f15af.xhtml" %}

On the left hand side of the top image, we can see that a neuron contains dendrites. These dendrites get electrical inputs from other neurons and send those to the cell body. If stimulated enough, the cell body will send the signals down the axon to the axon terminals that will output them to other neurons. 

How does is an artificial neuron simulate a biological one? In 1943, Warren MuCulloch and Walter Pitts laid the foundation for artificial neurons in their paper "A Logical Calculus of Ideas Immanent in Nervous Activity." Unlike a biological neuron that received electricity from other neurons, an artificial neuron received an arbitrary number of numerical inputs. It would then output the sum of these numbers to another neuron. This, however, presentated a problem. If all the inputs were automatically outputted by the neuron, all artificial neurons would fire at the same time rather than when they were sufficiently simulated. To counter this, artificial neurons determine if the sum of their inputs is greater than a particular threshold before outputting the results. Think of it as a cup that can hold liquid to a certain point before it starts overflowing. Likewise, a neuron may take in electricity but only "fire" when it reaches a critical mass. The exact way that this threshold outputs to other neurons is called an activation function. 

Of course, neurons are complex entities and the science on them is constantly evolving. For instance, the step-wise activation function described above is uncommon. More complex activation functions like [ReLu](https://en.wikipedia.org/wiki/Rectifier_(neural_networks)) and Sigmoid have been shown to have better results.  Nonetheless, this simplistic understanding of a neuron should suffice for our purposes. 

A neural network is simply a web of connected artificial neurons. Like many computer programs, you can imagine them as a series of steps. However, they are usually drawn from left to right. Each neural network has at least an input layer, a hidden layer, and an output layer. A "deep neural network" is any neural network that has more than one hidden layer. These layers each apply some mathematical properties to the dataset. Since we are going to work with classifying images, you may wonder how this process of guessing numbers can apply to our own example. Remember, at its core, everything in a computer is mathematical even images. For instance, we can convert each pixel of an image into its corresponding RGB value. Once we have done this, we can use the same technique described above to begin classifying our images. 

Convolutional neural networks, which we will be using for this tutorial, are a subset of neural networks that excels at detecting image features and saving the spatial arrangement of pixels. Think about what makes up an image. If you have ever taken a drawing class, you may have learned to divide a sketch into simple shapes, such as circles, squares, etc. Later, you take these shapes and draw more complex images on top of them. A convolutional neural network (CNN) essentially does the same thing. As we stack convolution layers, each layer learns to identify different parts of a growingly complex shape. For instance, the first layer provides basic feature detection such as corners and edges. The middle layers take these shapes and starts segmenting objects. The last layers will be able to recognize the objects themselves before sending them to the output layer for classification. For more information on how the layers of a convolution network work, see [this excellent write up by Erik Reppel](https://hackernoon.com/visualizing-parts-of-convolutional-neural-networks-using-keras-and-cats-5cc01b214e59).

Now that we have understood the basic architecture of a neural network, we can understand how it "learns." Machine learning can be divided into two forms: supervised and unsupervised learning. Unsupervised learning looks for patterns inside of data and tries to group data that is alike together. You may have seen the use of some unsupervised machine learning algorithms such as [K-Means Clustering](https://en.wikipedia.org/wiki/K-means_clustering) and [Latent Direchlet Allocation](https://en.wikipedia.org/wiki/Latent_Dirichlet_allocation) in digital humanities research. 

Supervised learning, which is what neural networks are, requires inputs for which you already have a proven output. We can take a simple example. Let's assume that we are interested in solving the following equation: `x+y=7.5`. In this scenario, we know that the output should be "7.5,” but we do not know the inputs. We can begin by simply guessing numbers such as 3 and 2. Putting it into our equation, this gives us an answer of 5. However, we know that we need to get an answer of 7.5 so one of the things that we can do is multiply the inputs by a number. We can start by multiplying each original guess by 2. The amount that we multiply each number is called a weight: (3x2)+(2x2)=10. Since we have overshot our answer, we need to adjust the weights down. Lets try 1.5: (3x1.5)+(2x1.5)=7.5. We got the correct result despite not knowing the inputs originally. This is exactly how a neural network works!

# Transfer Learning and Convolutional Neural Networks

We will be using [Google's Teachable Machine](https://teachablemachine.withgoogle.com/) to train our model. Teachable machine provides a simple interface that allows us to gain a strong foundation in machine learning without having to worry about the code. When you load it, you will find that you have the option to train three different types of models. For this tutorial, we will be creating what Teachable Machine calls a "Standard image model.”

Training an image classifier from scratch requires significant computational resources. We would need numerous images along with their corresponding labels. Rather than doing this, Teachable Machine relies on transfer learning. 

Transfer learning expands on a model that has already been trained on a separate group of images. In particular, Teachable Machine relies on [MobileNet](https://arxiv.org/abs/1704.04861). MobileNet is a lightweight model meant to run on small devices with low-latency. This allows training times to remain relatively quick. MobileNet, like all deep learning models, consists of an input layer, an output layer, and a series of hidden layers. The majority of its hidden layers are "convolutional layers." Of course, MobileNet was not trained on the ima ges that we are interested in so how exactly can we use it?

Under the hood, the final layer before the output layer has classified our image into a series of "features." These features are numerical and then mapped to the categories that MobileNet is trained on. When we do transfer learning, we map these features onto our own dataset. This means that we can rely on the earlier layers to do most of the heavy lifting while still having the benefit of using the final layers for classification. 

On the Teachable Machine home page, go ahead and click the “Get Started” button. Then, click “Image Project” and select “Standard image model.” 

Once we have selected that we are interested in image classification, we can upload the images for each class. You will find that you can either "Upload" images or use your webcam to create new ones. We will be uploading all the images for each of the classes in the training folder. 

Under "Class 1", click "Choose images from your files, or drag & drop here.” Select the "aircraft" folder from the dataset and drag it into the Teachable Machine window. Click the pencil icon next to "Class 1" and change the name to "aircraft".

Repeat this process for the other folders in the dataset. After the second time, you will need to click " + Add a class" for each new folder.  

{% include figure.html filename="add_classes.png" caption="Figure 6. Adding classes to Google Teachable Machine." %}

Once you have finished uploading the images, you can change different paramaters on how the model is trained by clicking on the "Advanced" under Training. You can adjust the Epochs, Batch Size, and Learning Rate. 

{% include figure.html filename="advanced_settings.png" caption="Figure 7. Advanced settings in Google Teachable Machine." %}

An epoch refers to the amount of times that each image is used to train the neural network. Because we are going through each image multiple times, we don't actually need a lot of samples to get a working example going. You may be wondering why we don’t just set this number higher so that we can get more samples. The main issue with doing this is that it can result in "overfitting." Overfitting is when our neural network gets really good at working with our training set but fails when given new data. This is one of the reasons that Teachable Machine sections off some of the data that we already have classifications for. It uses this data to "test" if the predictions that our neural network makes are accurate. 

Batch size refers to how many images are used for training per iteration. If you have 80 images and a batch size of 16, this means that it will take 5 iterations to make up one epoch. A key advantage to using a smaller batch size is that it is much more efficient on memory. Furthermore, because we are updating the model after each batch, the network tends to be trained faster. 

The learning rate refers to how much we should change our model based on the estimated error. This can make a big difference into how well your neural network performs, but I woud recommend not making any changes to this until you grow more familiar with machine learning. Although increasing the epoch will provide more examples for the model, it comes at the cost of "overfitting" mentioned above. The default settings for this example should only take a few seconds. However, it is good practice to think seriously about how adjusting these paramaters can impact computational resources as you expand your project. 

We will stick with the default settings for now. Click on the Train button to begin training your model. **Please note that immediately upon finishing the training, Teachable Machine will begin to test the video feed from your webcam. You need to select "File" in the dropdown menu next to Input rather than Webcam to stop this.**

A bar will begin displaying the progress. Be sure not to close your browser or switch tabs during this time. A pop up displayed below will remind you of this. 

{% include figure.html filename="donotswitch.png" caption="Figure 8. Popup Showing Not to Switch Tabs" %}

After training is done, you will want to test your model. There are various measures to determine how well a model works. If you click on "Under the hood" in the Advanced settings, you will get a display of the Loss and Accuracy per Epoch. The closer the loss is to 0 and the accuracy is to 1, the better our model is at understanding our images.  

One of the benefits of Teachable Machine is that we can immediately begin testing our model. The default input is to use your webcam so we will switch it to file. Go ahead and upload one of the images in the test folder and see the results. Normally we would want to test our model with more images, but Teachable Machine only lets us test one image at a time. In the test folder, there are ten images for testing the classification. Go ahead and compare how you would classify them yourself with the output Teachable Machine provided.

# Export Model

We will now export and download our model. Click the "Export Model" button, and you will see three options: Tensorflow.js, Tensorflow, and Tensorflow Light. [Tensorflow](https://en.wikipedia.org/wiki/TensorFlow) is a library developed by Google focused on machine learning and artificial intelligence. We will choose Tensorflow.js, which is simply a JavaScript implementation of the library. [Ml5js]((https://ml5js.org/)) and [p5js](https://p5js.org/), which we will use to later embed our model on our website, rely on Tensorflow.js at a lower level. 

Once you have selected Tensorflow.js, you will be given a zip file containing three files: 

* `model.json`: This file contains data about the different layers for the neural network itself  
* `weights.bin`: This contains information about the weights for each of the neurons  
* `metadata.json`: This holds information about which Tensorflow version is being used for the network along with the class labels 

Unzip this folder, and place the files inside of your project folder. Your folder should now look like the following:

{% include figure.html filename="project1.png" caption="Figure 9. Project Folder with Tensorflow.js Files" %}

# Importing Our Model with ml5js

Teachable Machine is a great resource for familiarizing yourself with how neural networks, and machine learning more broadly, work. However, it is limited in what it can do. For instance, maybe we would like to create some sort of graph that displays information about the classification. Or, maybe we want to allow others to use our model for classification. For that, we will need to import our model to something that allows more flexibility. Although there are many tools, for this tutorial, we will be using ml5js and p5js. 

[Ml5js](https://ml5js.org/) is a Javascript library built on top of Tensorflow.js. It takes much of its inspiration from [Processing](https://processing.org/) and [p5.js](https://p5js.org/) created by [The Processing Foundation](https://processingfoundation.org/). The foundation's goal is "to promote software literacy within the visual arts, and visual literacy within technology-related fields — and to make these fields accessible to diverse communities." This ethos of creating a more equitable community in software development is one of the core organizing principles for ml5js. As mentioned earlier, machine learning libraries often expect a significant background in programming and/or statistics. For most neural network libraries, you must specify properties for each layer of the neural network such as its inputs, outputs, and activation functions. Ml5js takes care of this for you, making it easier for beginners to start.

To begin, lets go ahead create some files in our "Project" folder. Inside the folder, we will create an "index.html" page that will call the rest of our Javascript libraries. This allows us to examine the model's output without having to look directly at the browser's developer console—although we will do that as well. We also need to create a file called "sketch.js" in the same directory as index.html. Finally, we will take a test image from the testing folder and place it in our Project root folder to assure our code is working. You can take use any image you like, but I am going to use the first one for this example. Your Project folder should now look like the following:

{% include figure.html filename="project2.png" caption="Figure 9. Project Folder with script.js, index.html, and test image" %}

We will base the code for our "index.html" file on the [official ml5js boiler plate template](https://learn.ml5js.org/#/). This template links to the latest ml5js and p5js library. While ml5js does not require p5js, most examples use both since that allows us to quickly code an interface for interacting with the model. We will have most of the code for our neural network in a separate Javascript file named "sketch.js", and our boiler plate template will link to that script. 

``` html
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Getting Started with ml5.js</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- p5 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.0.0/p5.min.js"></script>
    <!-- ml5 -->
    <script src="https://unpkg.com/ml5@latest/dist/ml5.min.js"></script>
    <script src="sketch.js"></script>
  </head>
  <body>
  </body>
</html>
```

Outside of this template, we do not have any additional code in our index.html file. Instead, we have a link to sketch.js — note that many p5js and ml5js conventions draw on artistic terminology — and that is where we will do the majority of our coding. Switch your editor to "sketch.js"

We will make sure that everything is working properly by printing the current version of ml5js to the console. In sketch.js, copy or type the following:

```javascript
// Output the current version of ml5 to the console
console.log('ml5 version:', ml5.version);
```

You should have already started a live server during the setup stage. If not, you should start it now on the Project folder . Load up index.html in your web browser—remember that index.html is just a boiler plate template linking to sketch.js—and check the developer console for the output.Please note that the output for ml5js consists of a large amount of emojis and favicons that often fail to load. As long as the output for the current version displays, you shouldn't encounter any problems. 

Because we are using p5js, it is worth taking a few minutes to examine some of its peculiarities. P5js is an interpretation of [Processing](https://processing.org/) in Javascript. Both p5js and Processing cater to visual artists that are seeking to create digital projects, especially those interested in creating [generative art](https://en.wikipedia.org/wiki/Generative_art). You will find that drawing on artistic terminology is a common convention amongst p5js and ml5js programmers. This is why we named our Javascript file "sketch.js." 

The two key functions in p5js that draw on this tradition are the `setup()` and `draw()` functions. The `setup()` function is automatically executed once when the program is run. We will use it to create a blank square canvas that is 500px by 500px using the `createCanvas()` function. We should probably also place our code that outputs the current version of ml5js to the console there as well. 

```javascript
function setup(){
    // Output the current version of ml5 to the console
    console.log('ml5 version:', ml5.version);
    // Create a blank square canvas that is 500px by 500px 
    createCanvas(500,500);
}
```

If you execute the above command, you will find that a canvas has been created, but because it is set to white, you may not be able to differentiate it from the rest of the page. To make it easier to see the boundaries of our canvas, we will use the `background()` function and pass it the hex value for black. 

```javascript
function setup(){
    // Output the current version of ml5 to the console
    console.log('ml5 version:', ml5.version);
    // Create a blank square canvas that is 500px by 500px 
    createCanvas(500,500);
    // Set the background of the canvas to black based on the hex code 
    background('#000000');
}
```

If you load index.html again, you will see that we now have a black canvas that is 500x500 pixels. 

We now need to load the actual model. In the past, this was commonly done using a callback functions to deal with Javascript's asynchronous nature. If you are unfamiliar with Javascript, this may be a source of confusion. Basically, Javascript reads code from top to bottom, but it does not stop to complete any part of the code unless it must. This can lead to an issue when doing something like loading a model since Javascript may start calling the model before it has finished loading. Callback functions provide a way around this as they are not called in Javascript until some other code has already completed. 

To deal with common errors in loading images and models and the complexity of callbacks, p5js introduced a new `preload()` function. This is a powerful feature of p5js that allows us to be sure that images and models are loaded before the `setup()` function is called. 

We will place the call for loading our model in the `preload()` function and assign it to a global variable. Although the `preload()` function allows us to avoid callbacks in certain situations, we probably still want some feedback for when the model is successfully loaded. For this, we will create a new function called `teachableMachineModelLoaded()` that will output a message to the console. You only have to call the model.json file for this to work. Ml5js will automatically look in the same folder for the file containing the weights and metadata. 

```javascript
// Variable to hold the machine learning model
let classifier;

 // Load model.json and set it to our variable. Make callback to teachableMachineModelLoaded function to output when loading is complete.
function preload(){
    classifier = ml5.imageClassifier('model.json', teachableMachineModelLoaded);
}
 
// Callback for assuring when model has completely loaded
function teachableMachineModelLoaded(){
  console.log('Teachable Machine Model Successfully Loaded!');
}

```

Now that we have loaded the model, we need to add our training image. The first thing that we will do is load our image using the p5js `loadImage()` function. The `loadImage()` function takes a path to the image as a parameter and returns a `p5.Image` object, which provides some additional functions to manipulate images compared to plain Javascript. We can place this call in the `preload()` function. You can choose any of the test images or your own image to experiment with. Just place them in the same folder as the code. For the purposes of this tutorial, I am just going to load `testing0.jpg`, which is an image of a plane.  


```javascript
let classifier;
let testImage;

function preload(){
  classifier = ml5.imageClassifier('model.json', teachableMachineModelLoaded);
  // Load image from same folder. Note that you can change this to any image you want.
  testImage=loadImage("testing0.jpg");
  console.log("Successfully Loaded Test Image");
}

```

Now that we have loaded the image, we can use the p5js `image()` function to draw it to the screen. It takes three arguments. The first is the name of the variable containing the image—in this case, it is the testImage variable. The next two are x and y coordinates for where to place the image. We are going to put it in the center of our canvas. An easy way to do this is through the "height" and "width" variables that contain the canvas dimensions. P5js makes these available to us automatically, and we can divide by two to center the image

We will issue this call inside of the `draw()` function, which is called immediately after `setup()` and is where we will place the majority of our code. 

```javascript
function draw(){
    // Place image in center by dividing canvas width and height by two.
    image(testImage, width/2, height/2);
}
```

If you look at the image, you will find that it is not perfectly centered on the canvas. This is one of the peculiarities of working with p5js. It places the image on the canvas using the top left corner as the anchor point. We can call the `imageMode()` function and pass it the "CENTER" argument to change how p5js determines where to place images. This setting will stay in place until you decide to change it.  

If you run the following, you will now see that we have our image in the center of the canvas.  

```javascript
function draw(){
    // Center image anchoring point to be center of image 
    imageMode(CENTER);
    image(testImage, width/2, height/2);
}
```

The `draw()` function is unique to p5js and loops based on the framerate. This is again due to p5js being originally geared towards artists. By constantly looping the material inside of `draw()`, it makes it easier to make animations. When you post the image onto the canvas, p5js is actually continuously running the code and placing a new image on top of the old one. To stop this, we can call the `noLoop()` function.  

```javascript
function draw(){
    // Stop looping of code in draw
    noLoop();
    // Place anchor point of image in the center of the image
    imageMode(CENTER);
    // Output image to the center of the canvas 
    image(testImage, width/2, height/2);
}
```

We are now ready to test our model. We will call the `classify()` function from our classifier object. It requires a single argument containing the object that we are interested in classifying along with a callback. We will call our callback function `getResults()`. ml5js will automatically send two arguments to the function containing information about errors and/or results. We will output these results to the console: 


```javascript
function draw(){
  noLoop();
  imageMode(CENTER);
  image(testImage, width/2, height/2);
  // Call classify function to get results. Use callback function called getResults to process the results 
  classifier.classify(testImage, getResults); 
}

function getResults(error, results) {
  // If there is an error in the classification, output to the console. Otherwise output the results to the console. 
  if (error) {
    console.error(error);
  } else {
    console.log(results);
  }
}

```

If everything went well, you should see the results of the classification on the console as a Javascript object. Let’s take a closer look at the output. Note that the exact numbers you get may vary. This is the output from the first image:

{% include figure.html filename="console_output.png" caption="Figure 10. Example output." %}

If you look inside of the Javascript object—in most browsers, this is done by clicking on the arrow symbol next to the object name. You will see the output for the testing0.jpg image list all the possible classes by probability and confidence. We see that results[0] contains the most likely result with the label listed in results[0].label. There is also a confidence score in results[0].confidence which provides a percentage of how sure our model is of the first label. 

We can output these values to our canvas using the `text()` function in our `getResults()` call, which takes our text and the x, y coordinates for where we want to place it as arguments. I will place the text a little bit below the image itself. We will also need to call some functions that detail how we want our text to be displayed. Specifically, we will use `fill()` with a hex value for the color text, `textSize()` for the size, and `textAlign()` to use the center of our font as an anchor point. Finally, we will round the confidence to two decimal points using the `toFixed()` function.

```javascript

function draw(){
  noLoop();
  imageMode(CENTER);
  image(testImage, width/2, height/2);
  classifier.classify(testImage, getResults); 
}

function getResults(error, results) {
  if (error) {
    console.error(error);
  } else {
    // Set the color of the text to white
    fill('#FFFFFF');
    // Set the size of the text to 30
    textSize(30);
    // Set the anchor point of the text to the center
    textAlign(CENTER)
    // Place text on canvas below image with most likely classification and confidence score
    text("Confidence " + (results[0].confidence*100).toFixed(2) + "%", width/2, height/2+165)
    text("Most Likely " + results[0].label, width/2 , height/2+200);    
    // Output most likely classification and confidence score to console
    console.log("Most likely " + results[0].label);
    console.log("Confidence " + (results[0].confidence*100).toFixed(2) + "%",);
    console.log(results);
  }
}
```

If everything went well, you should see the following result. Note that your confidence score will likely differ:

{% include figure.html filename="final_output.png" caption="Figure 11. Example result." %}

# Conclusion

This tutorial has provided you a solid foundation on how neural networks function, and you can use them to do image classification. I have purposefully kept the code and examples simple to make them easier to understand, but I encourage you to expand the code that you have created here. For instance, you could add loops to go through a folder of images and output the results into a CSV file containing the topics to chart the themes of a larger body of corpora. You could also look at the limitations of the neural network to see areas where it does not work. For instance, what happens when you upload an abstract painting or something that isn't a painting at all? Exploring these weak points can often lead to inspiration not only for academic but also creative work.  

# Further Resources

The following are some recommended resources to dive further: 

* 3Blue1Brown has some wonderful videos that delve into the math of Neural Networks: [https://www.3blue1brown.com/topics/neural-networks](https://www.3blue1brown.com/topics/neural-networks)
* Dan Shiffman provides a good overview of using ml5js and p5js for machine learning on his YouTube channel: [https://www.youtube.com/watch?v=26uABexmOX4&list=PLRqwX-V7Uu6YPSwT06y_AEYTqIwbeam3y&index=1](https://www.youtube.com/watch?v=26uABexmOX4&list=PLRqwX-V7Uu6YPSwT06y_AEYTqIwbeam3y&index=1). He also has a series of videos on building a neural network from scratch that goes over the mathematical foundations for machine learning more broadly: [https://www.youtube.com/watch?v=XJ7HLz9VYz0&list=PLRqwX-V7Uu6aCibgK1PTWWu9by6XFdCfh](https://www.youtube.com/watch?v=XJ7HLz9VYz0&list=PLRqwX-V7Uu6aCibgK1PTWWu9by6XFdCfh)
* The official ml5js reference provides a comprehensive overview of how to do image classification along with other machine learning tasks: [https://learn.ml5js.org/#/reference/index](https://learn.ml5js.org/#/reference/index)
* The book *Make Your Own Neural Network* by Tariq Rashid provides an excellent and clear introduction for those interested in gaining a broader foundation for machine learning: [https://www.amazon.com/Make-Your-Own-Neural-Network-ebook/dp/B01EER4Z4G/ref=sr_1_5?keywords=Neural+Network&qid=1642687586&sr=8-5](https://www.amazon.com/Make-Your-Own-Neural-Network-ebook/dp/B01EER4Z4G/ref=sr_1_5?keywords=Neural+Network&qid=1642687586&sr=8-5)
* Tijmen Schep's interactive documentary is an excellent introduction to the dangers of machine learning and AI: https://www.hownormalami.eu/
* Jeremy Howard and Sylvain Gugger book *Deep Learning for Coders with fastai and PyTorch: AI Applications Without a PhD* provides a great introduction machine learning. Although it utilizes Python, the examples are simple enough for most beginners to follow and are relatively simple to recreate in other languages: [https://www.amazon.com/Deep-Learning-Coders-fastai-PyTorch/dp/1492045527](https://www.amazon.com/Deep-Learning-Coders-fastai-PyTorch/dp/1492045527). They also have a free companion video series that goes over much of the material in the book: [https://www.youtube.com/watch?v=0oyCUWLL_fU](https://www.youtube.com/watch?v=0oyCUWLL_fU)
* Grokking Deep Learning by Andrew Task is a wonderful book that provides a gentle introduction to some of the more advanced mathematical concepts in machine learning: [https://www.amazon.com/Grokking-Deep-Learning-Andrew-Trask/dp/1617293709/ref=sr_1_1?crid=2XNW5L2FPN2PU&keywords=grokking+deep+learning&qid=1642780602&s=books&sprefix=grokking+deep+learning%2Cstripbooks%2C60&sr=1-1](https://www.amazon.com/Grokking-Deep-Learning-Andrew-Trask/dp/1617293709/ref=sr_1_1?crid=2XNW5L2FPN2PU&keywords=grokking+deep+learning&qid=1642780602&s=books&sprefix=grokking+deep+learning%2Cstripbooks%2C60&sr=1-1)
* David Dao curates a list of current of some of the dangerous ways that AI has been utilized and perpetuates inequality: [https://github.com/daviddao/awful-ai](https://github.com/daviddao/awful-ai)

