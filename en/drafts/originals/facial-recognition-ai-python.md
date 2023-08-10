---
title: "Facial Recognition in Historical Photographs with Artificial Intelligence in Python"
slug: facial-recognition-ai-python
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Charles Goldberg
- Zach Haala
reviewers:
- Forename Surname
- Forename Surname
editors:
- Giulia Taurino
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/552
difficulty:
activity:
topics:
abstract: In this lesson, you'll learn how machine learning principles from artificial intelligence in the Python programming language are used in the computer vision application called facial recognition. As a test case, you'll learn how to recognize and classify smiling faces in historical photographs.
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction
Photographs are vital primary sources for modern historians. They allow later generations to “see” the past — quite literally — in unique ways, and our understanding of the past two centuries would be poorer, and much less vivid, without these valuable sources.

Advances in artificial intelligence raise the promise of asking new things from photographs, and of changing the role they play in the study of the past. From chatbots to art generators to tailor-made Spotify playlists, artificial intelligence and machine learning — with their superhuman aptitude for pattern recognition — become more ubiquitous by the day. Since one of the historian's tasks is also to spot patterns in historical material, AI’s ability to do this quickly over enormous amounts of data holds immense promise for how we study the past.

In 2017, a group of researchers used an artificial intelligence model known as a convolutional neural network to analyze almost 200,000 historical American yearbook photographs, seeing the genre as an especially suitable test case for applying AI processes to the study of history. In their words, "Yearbook portraits provide a consistent visual format through which one can examine changes in content from personal style choices to developing social norms."[^1] [Analyzing yearbook photographs](https://pudding.cool/2019/11/big-hair/) allows one to track evolving societal preferences throughout the 20th century, from what one wears in a formal photograph — glasses, neckties, earrings — to how one sits for a portrait — smiling or otherwise.

This tutorial is meant as an introductory exercise in applying computer vision machine learning to historical photos. Our dataset will contain one yearbook per decade from the mid-twentieth century — a small dataset that can easily be scaled for larger projects. After extracting an individual image of each face, we will use a pre-trained convolutional neural network in Python called DeepFace to detect the presence of a smile in each photograph. This test case will allow us to verify something easily spotted by traditional historical analyses: that early photographic portraits in the 20th century typically feature stoical, "serious" faces, while more recent photographs tend to feature more casual, smiling faces. Historians like Christina Kotchemidova, for example, have argued that early sitters for photos avoided smiling in order to appear more like subjects in painted portraits, and hence more dignified.[^2] The long exposure times of primitive cameras also discouraged posing with a smile. The proliferation of amateur photography in the 20th century led to less formal photography, and hence more smiling. This tutorial will allow us to test these assertions computationally.

This lesson will also serve as an introduction into some of the ethical issues posed by the use of Artificial Intelligence in the study of photographs, particularly those implicating race and gender. Machine learning image recognition can often miscategorize — or fail to identify entirely — non-white and female faces in photographs, a problem that can be compounded for historians by the simple fact that historical photographs are often of poor quality and low resolution. Similarly, "big data" visual projects often use stable categories for their subjects like "male" or "female" based on how closely each face matches others in that category. This can lead to the erasure of marginalized individuals who may not present as or identify with the categories the algorithm and researcher are using. All of this is to say that applying a seemingly "objective" technological tool to the study of history is anything but, and, as with the other, more traditional, tools in the historian's bag, it must be used with discernment.

Scholars from two broader perspectives may find this tutorial of interest. First, historians engaging with large visual corpora in their research, whether or not they're specifically interested in smile and/or facial recognition, may find computer vision generally and object recognition specifically valuable. Object recognition can allow one to track the changing frequencies of object presence in historical photographs over time. Or, more simply, it can provide a technique for identifying photographs of interest in large visual collections for future close study.

Additionally, this tutorial is meant to provide an introductory lesson in how computational analysis of large visual collections can aid in curating and organizing large digital collections. In the conclusion, I will suggest other pathways in computer vision scholars may wish to pursue as next steps, including training their own model in object recognition. Of particular interest may be the two-part [_Programming Historian_ lesson, Computer Vision for the Humanities: An Introduction to Deep Learning for Image Classification.](https://programminghistorian.org/en/lessons/computer-vision-deep-learning-pt1)

## Learning Outcomes
At the end of the tutorial, you will be able to understand:
* How to extract pictures of human faces using Python from historical documents digitized in the PDF format, and how to organize them for further analysis
* The basics of computer vision machine learning, or how a computer "views" an image
* How to apply a pre-trained computer vision model to a large historical dataset

## Suggested prior skills
You do not need to be a programming expert to complete this tutorial. To get the most out of it, however, you should have:
* Some knowledge of Python 3. Though this tutorial will not ask you to do any coding of your own, familiarity with how Python works will be beneficial
* A Google account, which will give you access to Google Colab where you can run the code yourself
* Basic familiarity with Google Colab and/or Jupyter notebooks. A Jupyter notebook is a document that contains code that you can run directly online (i.e., without first setting up a programming environment on your computer). A Google Colab notebook is a Jupyter notebook hosted on Google's servers. For more, see [the _Programming Historian_ lesson on Jupyter notebooks.](https://programminghistorian.org/en/lessons/jupyter-notebooks)

## Lesson setup
This lesson is accompanied by [a Google Colab notebook](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/facial-recognition-ai-python/facial_recognition_ai_python.ipynb) which is ready to run. I have pre-loaded the sample dataset and all the code you'll need. The [Preliminary Colab setup section](#preliminary-colab-setup) will help you to orientate yourself within Colab if you're new to the platform.

Alternatively, you can download the following files and run the code on your own dedicated Python environment:

- [Bethel Yearbook 1911](https://cdm16120.contentdm.oclc.org/digital/collection/p16120coll2/id/2212/rec/3)
- [Bethel Yearbook 1921](https://cdm16120.contentdm.oclc.org/digital/collection/p16120coll2/id/2400/rec/13)
- [Bethel Yearbook 1931](https://cdm16120.contentdm.oclc.org/digital/collection/p16120coll2/id/2785/rec/23)
- [Bethel Yearbook ](https://cdm16120.contentdm.oclc.org/digital/collection/p16120coll2/id/2941/rec/29)
- [Bethel Yearbook 1951](https://cdm16120.contentdm.oclc.org/digital/collection/p16120coll2/id/3559/rec/39)
- [Bethel Yearbook 1961](https://cdm16120.contentdm.oclc.org/digital/collection/p16120coll2/id/4062/rec/49)
- Our [Python notebook](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/facial-recognition-ai-python/facial_recognition_ai_python.ipynb)
- An OpenCV pretrained facial detection model [`haarcascade_frontal_defaul.xml`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/facial-recognition-ai-python/haarcascade_frontalface_default.xml)

However, this may prove cumbersome if your environment is not already configured for machine learning. For example, some of the packages below require both a C++ compiler like Microsoft Visual Studio as well as a capable dedicated graphics card (GPU). Both of these things are included in Google Colab for free, which can make it much easier to use than setting up your own machine learning environment, even for those with previous Python experience.

## Broad brushstrokes technical outline
The code below will:
* Download necessary files. Our test data will be several digitized yearbooks from the 20th century now contained in [Bethel University's Digital Library](https://www.bethel.edu/library/digital-library/). I have selected one yearbook per decade from 1911 to 1961. Certainly, many more yearbooks would yield more complete findings, but a limited dataset is sufficient for this exercise and will be processed much more quickly than a larger dataset.
* Convert each page of each yearbook to a `.png` image
* Pass what's called in machine learning a haar cascade over each image to identify a human face, and then save each found face as a separate .png image
* Subject each face photo to a pre-trained object detector designed to identify smiles
* Produce a `.csv` file containing the ratio of smiling faces to non-smiling faces per year in the dataset

<div class="alert alert-warning">
Please be sure you're connected to a GPU runtime in Colab by going to Runtime > change runtime type and selecting GPU in the "hardware accellerator" dropdown.
</div>

## Preliminary Colab setup
If you've never used Google Colab before, you'll want to familiarize yourself with how it works. Click on the folder icon in the far left-hand column. This contains your virtual working environment. Think of it as Colab's version of Windows Explorer or Finder on a Mac. As we progress through the notebook, you'll see new folders and files appear here. Note that Colab notebooks automatically disconnect from Google servers after 12 hours, or after a certain amount of time without being used. All of your files will be lost if you are disconnected, so it's important to monitor your notebook as it's running and download important files prior to disconnection.

Next, Colab notebooks contain snippets of code called "cells." Each cell begins with a "play" button directly to the left of the first line of code. You'll execute the code in this notebook by hitting each "play" button in order (let the previous cell finish executing before running the next one, or you can queue up the next cell while the previous one is running).

You can see the output of each code cell directly below the code. As each cell runs, the play button will turn into a rotating circle and you'll see a line at the very bottom of the screen that says "executing...." When each cell is finished running, you'll see a checkmark to the left of the cell as well as on the very bottom of the screen. You can then scroll down to run the next cell.

Our first cell below will create a folder in the left-hand panel called "yearbook." It will then download the necessary files into it. After the code runs, expand the carrot next to yearbook folder. You should see:

{% include figure.html filename="or-en-facial-recognition-ai-python-01.png" alt="Visual description of figure image" caption="Figure 1. Google Colab file hierarchy" %}

You can doubleclick each PDF to download a copy if you wish to explore the scan of the original yearbook.

Next, the code will install several Python libraries we'll need later on. This step should take just thirty seconds or so.

### Broad brushstrokes technical outline
Build dependencies and download needed data:
* Creates a working 'yearbook' folder in the left panel, then downloads and unzips data from hosted folder
* Installs PyMuPDF, a PDF reader Python package, and machine learning libraries like OpenCV and DeepFace
* Imports various packages for further processing

```
%mkdir yearbook
%cd yearbook
!pip install --upgrade --no-cache-dir gdown
!gdown --id "1NHT8NN8ClBEnUC5VqkP3wr2KhyiIQzyU"
!unzip PHfiles.zip
%mkdir images
!pip install PyMuPDF
!pip install dlib
!pip install DeepFace
import os, shutil, fitz, cv2, numpy as np, pandas as pd, dlib, tensorflow as tf
from os.path import dirname, join
from deepface import DeepFace
```
## PDF conversion
Our next step accomplishes two things: First, it creates a separate folder for each yearbook. It then uses a Python library called PyMuPDF to convert each yearbook `.pdf` file into individual .png image files and saves them into the corresponding year folder.

Most of the file organization steps in this tutorial use the [Python os library](https://docs.python.org/3/library/os.html). We'll first specify the location of our folder and then create a list of the `.pdf` files using os.listdir:

```
pdfs = [f for f in os.listdir(path) if f.endswith('.pdf')]
```

Then, using a for loop, we'll use os.chdir to move into the "images" subdirectory. The lines beginning with os.mkdir and newdir will create individual folders for every `.pdf` file. The code here will name each new folder based on the name of the `.pdf` file. For example, "1911.pdf" will create a folder called "1911".

Next, the program will move into each new folder, copy the corresponding .pdf file into it, and use PyMuPDF to convert the .pdf file into separate `.png` images for each yearbook page. PyMuPDF ([called with "fitz" in the code below](https://pymupdf.readthedocs.io/en/latest/intro.html#note-on-the-name-fitz)) first opens the `.pdf` file, then uses a for loop to process the file:
```
for page in doc:      
	pix = page.get_pixmap()      
	pix.save("page-%i.png" % page.number)
```
For each page in the document, PyMuPDF will use the [get_pixmap function](https://pymupdf.readthedocs.io/en/latest/tutorial.html#saving-the-page-image-in-a-file) to convert each page to a rectangular `.png` image. It then saves each image as a `.png` file giving it a name corresponding to its order in the original `.pdf`. When finished, you should see this file structure at the left:

{% include figure.html filename="or-en-facial-recognition-ai-python-02.png" alt="Visual description of figure image" caption="Figure 2. Google Colab file hierarchy showing each yearbook page saved as a `.png` image" %}

### Broad brushstrokes technical outline:
* Searches for all files that end in .pdf
* Creates a separate sub-directory in /images for each PDF and gives it the same name as the PDF (e.g., "1911.pdf" becomes  `/images/1911`)
* Copies each PDF into subdirectory
* Uses PyMuPDF (here called fitz) to open each PDF and convert each page to a `.png` file
```
path = r'./'
pdfs = [f for f in os.listdir(path) if f.endswith('.pdf')]
for pdf in pdfs:
    os.chdir(os.path.join('./images'))
    os.mkdir((pdf.split(".")[0]))
    newdir = (os.path.join('./images/' + os.path.join(pdf.split(".")[0])))
    os.chdir("..")
    print ("Now copying images into " + (newdir))
    shutil.copy(pdf, newdir)
    os.chdir(newdir)
    doc = fitz.open(pdf)
    for page in doc:
      pix = page.get_pixmap()
      pix.save("page-%i.png" % page.number)
    os.chdir(os.path.dirname(os.getcwd()))
    os.chdir("..")
```
## Object Detection and Facial Recognition: Explanations

Now that we have converted our yearbook .pdfs to images, we can search for faces on each page and extract individual photos for each one. This process uses an artificial intelligence approach called object detection and deserves a closer look. First, we need to understand the basics of computer vision, or how a computer "looks at" an image in the first place. Let's take this image as an example:

{% include figure.html filename="or-en-facial-recognition-ai-python-03.png" alt="Visual description of figure image" caption="Figure 3. Image of a dog" %}

If we zoom in, we can see that what our human eyes perceive as an image of a dog is simply many individual colorized pixels:

{% include figure.html filename="or-en-facial-recognition-ai-python-04.png" alt="Visual description of figure image" caption="Figure 4. Zoomed in and pixelated image of dog's nose" %}

A pixel to a computer is simply a set of three numbers, each between 0 and 255, representing a combination of the color intensities of that pixel in red, green, and blue. Higher values indicate more intense shades of that color. For example, 0,0,255 indicates a pixel that is entirely red. A `.png` or `.jpg` image with a resolution of 256x256 pixels therefore contains a list of 65,536 triple RGB color codes. Displaying the image on your screen simply requires the software you're using to convert the coded RGB values back to colorized pixels. The higher the resolution an image has, the larger the corresponding file becomes, and the more computing power is required to process it. Since computer vision processes typically deal with at least thousands of images, and often many, many more, applications usually start with "thresholding," or simplifying the image in some way to allow the computer program to analyze its contents more quickly and with fewer resources. Often, the image resolution is downscaled significantly. Additionally, the three-digit RGB value can be converted to a single black/white intensity channel to further save resources. We'll see more examples of thresholding below as we investigate how various computer vision techniques work.

How artificial intelligence is used to recognize a particular object in a photo is more complex. To start with a basic example, like a series of images of hand-drawn number eights, the parts of the images containing the number have different pixel hue intensities than the negative space surrounding them. The images that do contain the number 8 are assigned a value of “1” for “true” (as opposed to “0” for “false”) by the human trainer. Given enough examples of images containing the number, the computer will begin to recognize similarities in their RGB hue values.

Once the computer has completed the training process, it is able to return a prediction that a test image contains the pixel pattern it has been trained to detect. This prediction is typically given in the form of a value between 0.00 and 1.00, with 1.00 representing certainty that the computer has detected the object in the image, and 0.00 certainty that it hasn’t.

The particular kind of object detection library we’ll use for facial recognition is called OpenCV, a computer vision library developed in the late 1990s. In particular, we'll use a pre-trained face detection model in OpenCV called a Haar Cascade, which was developed by computer scientists Viola and Davis in 2001.[^3] Haar Cascades can simplify the computing power needed in object recognition because they don’t make calculations for each individual pixel, but rather look for pre-trained features, or patterns of groups of pixels throughout the image. But the basic principle is the same: Haar Cascades search for particular hue density patterns throughout an image.

{% include figure.html filename="or-en-facial-recognition-ai-python-05.jpg" alt="Visual description of figure image" caption="Figure 5. Caption text to display." %}

In the modern AI landscape, OpenCV and Haar Cascades, [both developed more than twenty years ago](https://docs.opencv.org/3.4/db/d28/tutorial_cascade_classifier.html), are now quite dated. Researchers and practitioners of computer vision now often use more modern, so-called "deep learning" techniques, which we'll get into in more detail below. But, in part because they are an older, more basic, technology, it can be easier to understand the basics of image recognition using Haar Cascades than by jumping into more powerful modern algorithms that use deep learning, so we'll use them here before turning to deep learning below. Haar Cascades are also flexible. By passing the detector over many different sections of an image containing a human face, it can recognize a face in any location in the image. 

{% include figure.html filename="or-en-facial-recognition-ai-python-06.gif" alt="Visual description of gif" caption="Figure 6. Caption text to display." %}

This is particularly important for our purposes because the `.png` image of each yearbook page can contain many different human faces in all sorts of different positions.

{% include figure.html filename="or-en-facial-recognition-ai-python-07.jpg" alt="Visual description of video" caption="Figure 7. Caption text to display." %}

Subjecting this image to a Haar Cascade, for example, results in several different detected faces.

{% include figure.html filename="or-en-facial-recognition-ai-python-08.jpg" alt="Visual description of video" caption="Figure 8. Caption text to display." %}

Viola and Davis also developed an effective thresholding technique for Haar Cascades which allowed their model to identify faces very quickly and with a reasonably high degree of accuracy (around 95%). As the detector passes over the image a single time, areas which may contain a face are noted and identified as "weak classifiers." As more and more passes are made, if enough "weak classifiers" are present in a certain area, they can rise above the specified threshold to indicate the presence of a face (and then become "strong classifiers"). This allows the Haar Cascade to focus only on areas of the image containing concentrations of weak classifiers, ignoring others and therefore saving resources and speeding the process. Finally, the lightweight, speedy nature of Haar Cascades means that they can be used by less powerful devices like laptops, cameras and smartphones, obviating the need for powerful graphics cards required by many deep learning computer vision strategies. So, while many AI computer vision models can exceed Haar Cascades with sheer power, their light weight and reasonably high accuracy have cemented their status in the modern computer vision toolkit.

## Object Detection and Facial Recognition: Ethical Issues

Now that we’ve explored how computer vision typically relies on differences in hue density, we can begin to recognize some of the ethical pitfalls in using this technology when it comes to race. Simply put, photographs of lighter faces often contain greater differences in pixel density than darker faces, which means that algorithms can sometimes struggle to detect or misidentify non-white faces using this approach.

Here is an example from our dataset of the computer failing to recognize a non-white face.

{% include figure.html filename="or-en-facial-recognition-ai-python-09.png" alt="Visual description of video" caption="Figure 9. Caption text to display." %}

AI research has confirmed that facial recognition algorithms tend to be most inaccurate when assessing faces of women, Blacks, and those in the 18-30 year-old range. The 2018 AI project, Gender Shades, found that the error rate for young, darker skinned women in particular was 34% higher than for lighter skinned men in one study.[^4] [The Algorithmic Justice League has shown that the misidentification of darker skinned people can play a crucial role in promoting racial bias and discrimination.](https://www.ajl.org/facial-recognition-technology) As more and more police departments use sophisticated AI surveillance, for example, the societal impact of such bias in computer vision should be obvious.This issue is also of acute importance for historians, since historical photographs may have been taken with primitive cameras, may have faded over time and have lost contrast, or might have been scanned and rescanned many times. All of these factors can exacerbate the biases already inherent in current facial detection and recognition processes.

Still, there are several solutions that can promote a more ethical application of AI computer vision technology. Most importantly, the training data that AI companies have used to develop facial recognition software has traditionally been overwhelmingly dominated by images of white men.[^5] Discrepancies in facial recognition by race and gender can therefore be greatly reduced by including more diversity in the training data. [Additionally, as camera technologies](https://www.nytimes.com/2019/04/25/lens/sarah-lewis-racial-bias-photography.html) continue to improve along with artificial intelligence techniques, photographs of darker skinned people should be more easily identified by AI algorithms. Finally, overly simplified classification schemes used by researchers — oftentimes "Caucasian"/"White", "Asian", "African"/"Black" and "Indian" are the only racial or ethnic classifiers used — should be replaced with more specific categories, which again would require broader, more representative training data.[^6]

## Object Detection and Facial Recognition: Code

The code for this section works somewhat similarly to the last cell. We’ll subject our `.png`s to facial recognition while also ensuring that the output is clearly organized for the next step.

Our first step simply identifies our root folder and creates a variable (dirs) containing a list of all of the subfolders within it. Next, we use a for loop to change directories into each subfolder and create another list with every file in that subfolder that ends in `.png`:

```
os.chdir(os.path.join(path + 'images'))
dirs = os.listdir(path)
for dir in dirs:
    os.chdir(os.path.join(path + dir))
    pngs = [f for f in os.listdir(path) if f.endswith('.png')]
```

Then, we create a new folder with the format YEAR + 'faces' (so, "1911 faces" and so on):

```
    if not os.path.exists((dir) + ' faces'):
        print("New 'faces' directory created in " + (dir) + " folder")
        os.makedirs((dir) + ' faces')
```

Then, we get into the meat of facial recognition. With another for loop, we open each .png file with OpenCV (in the code cv2), a robust set of Python libraries for computer vision and machine learning. We convert each image to greyscale (since greyscale images are faster to process than color), and pass a Haar Cascade classifier specifically trained by OpenCV to detect human faces over it. The two parameters in face_cascade.detectMultiScale we can adjust are scaleFactor and minNeighbors. The first refers to how significantly the image is downscaled before processing (larger numbers mean more downscaling and less data), and the latter refers to the confidence level required for the program to classify something as a face (higher is more rigorous but may miss some faces).

```
        for png in pngs:
            image = cv2.imread(png)
            greyscale_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
            face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")
            detected_faces = face_cascade.detectMultiScale(image=greyscale_image, scaleFactor=1.9, minNeighbors=4)
```

The final for loop in this cell determines how large the new .png image containing each face should be. X, y, w, and h all refer to pixel locations for corners of a bounding box drawn on each recognized face. The try loop adds some additional pixels to this box as a cushion, and then crops the image. Finally, the resulting image is saved to a new .png file in the YEAR + 'faces' folder.

```
for (x,y,w,h) in detected_faces:
                try:
                    xpadding = 20
                    ypadding = 40
                    crop_face = image[y-ypadding: y + h+ypadding, x-xpadding: x + w+xpadding]
                    count+=1
                    face = cv2.rectangle(crop_face,(x,y),(x+w,y+h),(255,0,0),2)
                    cv2.imwrite(path + (dir) + ' faces/' + str(count) + '_' + png, face)
                except (Exception):
                    print("An error happened")
                    continue
            os.remove(os.path.join(path, png))
```

### Broad brushstrokes technical outline:

* Moves to `/images` subdirectory and walks through all folders looking for files that end in `.png`
* Creates a subdirectory "YEAR + 'faces'" (e.g., 1911 faces)
* Uses OpenCV (here cv2) to:
    * Convert each image to greyscale (this reduces the computing power necessary to analyze each image)
    * Pass a haar cascade identifier (haarcascade_frontalface_default.xml) over each .png looking for facial features
    * "x, y, w, h" refer to pixel locations that OpenCV uses to denote where on the image the human face occurs. The script adds a few pixels of padding on top of this so the face does not extend to the edge of the `.png`
    * If it identifies a human face, it saves it as a .png image and places it in the "YEAR + 'faces'" subfolder
    * Uses a "try/except" loop to continue the code if an error occurs

```
path = r'./'

os.chdir(os.path.join(path + 'images'))
dirs = os.listdir(path)
for dir in dirs:
    os.chdir(os.path.join(path + dir))
    pngs = [f for f in os.listdir(path) if f.endswith('.png')]

    if not os.path.exists((dir) + ' faces'):
        print("New 'faces' directory created in " + (dir) + " folder")
        os.makedirs((dir) + ' faces')

        count = 0
        for png in pngs:
            image = cv2.imread(png)

            greyscale_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

            face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")

            detected_faces = face_cascade.detectMultiScale(image=greyscale_image, scaleFactor=1.9, minNeighbors=4)

            count = 0
            for (x,y,w,h) in detected_faces:
                try:
                    xpadding = 20
                    ypadding = 40
                    crop_face = image[y-ypadding: y + h+ypadding, x-xpadding: x + w+xpadding]
                    count+=1
                    face = cv2.rectangle(crop_face,(x,y),(x+w,y+h),(255,0,0),2)
                    cv2.imwrite(path + (dir) + ' faces/' + str(count) + '_' + png, face)
                except (Exception):
                    print("An error happened")
                    continue
            os.remove(os.path.join(path, png))
    os.chdir("..")
```

## Identify Smiles: Explanations

In our final intensive step, where we identify which photos contain smiling faces and which ones don't, we'll use a more sophisticated kind of machine learning process called a Convolutional Neural Network (or CNN). In our previous step, Haar Cascades were a suitable application because they are rather lightweight and speedy. But Haar Cascades aren't great for recognizing features that deviate from those they've been trained to recognize. For example, if you didn't include photos of a person wearing false glasses and a top hat in your training data, a Haar Cascade might not recognize such an image as one containing a human face.

In the decades since the Haar Cascades technique was developed in 2001, huge advances in AI have taken place that allow for finer and finer distinctions in object recognition, particuarly those that involve the algorithm evaluating images without a human instructor, so-called unsupervised "deep learning." These more modern algorithms harness the power of modern graphical processing units and can now look for dozens and dozens of particular patterns within an image, most of which the computer "learns" simply by viewing similar images and correcting its own mistakes in prediction.

In AI terminology, each individual pattern in the CNN is called a “node.” Simplistically, one node might be dedicated to recognizing the pixel patterns at the corner of a left eye, another to the bottom of an ear lobe, etc. When the computer evaluates a photo looking for a smiling human face, these individual nodes pass their evaluations and predictions to the next series of calculations (typically called the next “layer” within the CNN), which contain more nodes that take the previous layer's calculations into account and look for yet more patterns before passing the updated information on to the next layer, and so on. This kind of multi-faceted detection program is an example of “deep learning” because the algorithm is capable of making adjustments without human supervision, unlike the approach used in Haar Cascades. Like Haar Cascades, CNNs are capable of detecting objects anywhere in the image as it passes (or convolves) the detector over various stages of the image, hence the name.

The particular deep learning library we'll use here is called [DeepFace](https://github.com/serengil/deepface), which comes with several pre-trained models that can be used to detect and classify various categories in images of human faces, like age, gender, emotion, and race. Given the current ethical state of AI in regards to race and gender, which we discussed above, we'll limit our experiment to DeepFace's emotion classifier. For our purposes, we'll say that a photo designated as a "happy" one contains a smile, while a photo with any other dominant emotion does not.

## Identify Smiles: Code

In the code below, we'll create a series of counts for each year that tally the number of times our object detector classifies images as ones containing either smiles or non-smiles. It will then compare these counts against a count of total images, which will allow us to calculate a ratio of smiles to non-smiles for any given yearbook edition:

```
numberSmiles = 0
smileCounts = []
numberNonSmiles = 0
nonSmileCounts = []
numErrors = 0
errorCounts = []
pngs = []

fileCount = 0
fileCountList = []

years = ['1911', '1921', '1931', '1941', '1951', '1961']

for year in years:
    path = r'./images' + '/' + year
    for root, dirs, files in os.walk(path):
        for dir in dirs:
            path = path + '/' + (year + ' faces')
            if(fileCount != 0):
                fileCountList.append(fileCount)
            fileCount = 0
            for f in os.listdir(path):
                if f.endswith('.png'):
                    pngs.append(path + '/' + f)
                    fileCount = fileCount + 1
```

The part of the cell that analyzes faces for smiles is yet another for loop:

```
for png in pngs:
    try:
        totalLoops = totalLoops + 1
        count = count + 1
        if(count != (fileCountList[iterator] + 1)):
            demography = DeepFace.analyze(png, detector_backend = 'dlib')
            if(demography[0]["dominant_emotion"] == "happy"):
                numberSmiles = numberSmiles + 1
            else:
                numberNonSmiles = numberNonSmiles + 1

        else:
            count = count - 1
            smileCounts.append(numberSmiles / count)
            nonSmileCounts.append(numberNonSmiles / count)
            errorCounts.append(numErrors / count)
            numberSmiles = 0
            numberNonSmiles = 0
            numErrors = 0
            iterator = iterator + 1
            count = 0
```
If the DeepFace.analyze function classifies the photo as containing a face with the dominant emotion, "happy," the program will add one to the count of smiles. If the module detects any other emotion, or is unable to return a confident prediction of the emotion presented in the photo, it will either update the count in either the "nonSmiles" list or the "numErrors" list.

Finally, the program will take these three counts (four if we include the count for total images) and create a [Pandas dataframe](https://pandas.pydata.org/), finally it as a `.csv` file:

```
smileCounts.append(numberSmiles / count)
nonSmileCounts.append(numberNonSmiles / count)
errorCounts.append(numErrors / count)

dict = {'Years': years, 'Smiles': smileCounts, 'NonSmiles': nonSmileCounts, "Error Weight": errorCounts}
data = pd.DataFrame(dict)
data.to_csv('YearbookOutput.csv', index=False)
```
Complete code for this step:

```
%cd ..
numberSmiles = 0
smileCounts = []
numberNonSmiles = 0
nonSmileCounts = []
numErrors = 0
errorCounts = []
pngs = []

fileCount = 0
fileCountList = []

years = ['1911', '1921', '1931', '1941', '1951', '1961']

for year in years:
    path = r'./images' + '/' + year
    for root, dirs, files in os.walk(path):
        for dir in dirs:
            path = path + '/' + (year + ' faces')
            if(fileCount != 0):
                fileCountList.append(fileCount)
            fileCount = 0
            for f in os.listdir(path):
                if f.endswith('.png'):
                    pngs.append(path + '/' + f)
                    fileCount = fileCount + 1

fileCountList.append(fileCount)

totalLoops = 0
count = 0
iterator = 0
for png in pngs:
    try:
        totalLoops = totalLoops + 1
        count = count + 1
        if(count != (fileCountList[iterator] + 1)):
            demography = DeepFace.analyze(png, actions = ['emotion'])
            print(demography)
            if(demography[0]['dominant_emotion'] == 'happy'):
                numberSmiles = numberSmiles + 1
            else:
                numberNonSmiles = numberNonSmiles + 1

        else:
            count = count - 1
            smileCounts.append(numberSmiles / count)
            nonSmileCounts.append(numberNonSmiles / count)
            errorCounts.append(numErrors / count)
            numberSmiles = 0
            numberNonSmiles = 0
            numErrors = 0
            iterator = iterator + 1
            count = 0

    except (Exception):
        numErrors = numErrors + 1
        print("An error happened")
        continue

smileCounts.append(numberSmiles / count)
nonSmileCounts.append(numberNonSmiles / count)
errorCounts.append(numErrors / count)

dict = {'Years': years, 'Smiles': smileCounts, 'NonSmiles': nonSmileCounts, "Error Weight": errorCounts}
data = pd.DataFrame(dict)
data.to_csv('YearbookOutput.csv', index=False)
print(count)
```
## Download and results
Our final step involves downloading the `.csv` file. Run the cell below; you can also click the three dots to the right of the `YearbookOutput.csv` file to the left and select "download."

How did we do? As you can see, our smile detector found an overall increased rate of smiles in our dataset as the 20th century progressed, confirming our original hypothesis as well as the qualitative findings by American historians.

Let's zero in on the "Error Weight" column of the `.csv` file:

{% include figure.html filename="or-en-facial-recognition-ai-python-10.png" alt="Visual description of figure image" caption="Figure 10. Screenshot of `.csv` file showing experiment results" %}

This column contains the frequency that the smile detector failed (your `.csv` file will probably look different, as slightly different results are expected each time the program runs). Dlib, the sub-library of DeepFace we used to identify smiles, [promises accuracy of up to 99.38%](http://dlib.net/face_recognition.py.html) in some contexts. As you can see, our results were not nearly as accurate, though we did approach the upper 90th percentile in the later decades. This would confirm the common sense hypothesis that computer vision techniques will be less accurate when applied to older photographs. Even so, an error rate in the low single digits for photographs after the mid-twentieth century should give researchers confidence in using AI on large visual corpora.

If you'd like to run the experiment on a larger set of yearbooks, you can [browse Bethel Yearbooks in their Digital Library](https://cdm16120.contentdm.oclc.org/digital/collection/p16120coll2).

## Conclusions and next steps
This tutorial has provided an introduction to the computer vision technique of object recognition, using the increased frequency of smiles in 20th century yearbook photographs as a test case. Detecting the presence of smiles in a visual database is indeed a very specific task that most historians will not find particularly applicable. Still, using machine learning to identify patterns and trends in large visual collections holds great promise for streamlining and simplifying important tasks in historical research as well as for those interested in treating historical collections as data. For example, crowd-sourcing projects like [Freedom on the Move](https://freedomonthemove.org/) and many of the humanities-based projects on the crowd sourcing site [Zooniverse](https://www.zooniverse.org/projects?discipline=history&page=1&status=live) have leveraged human input for some of the repetitive tasks historians and curators face in managing large collections such as labeling, identifying, and other tasks associated with metadata. Computer vision and object recognition promises to greatly speed such efforts, reducing or perhaps even eliminated much of the tedious human labor often required.

In regards to large visual corpora, in particular, the use of computer vision strategies can help further what Taylor Arnold and Lauren Tilton call "distant viewing," a parallel to the common Digital Humanities application of "distant reading" techniques used in the study of large written corpora.[^7] Computer vision and object recognition can help scholars bridge what is often called the "semantic gap" between the information contained in a photograph or image and the cultural meaning humans derive from it. By specifying aspects or characteristics of image collections that contain historical meaning, and then training machine learning algorithms to search for them — whether it's a smile, fashion choice, use of a particular object, or something else — researchers can add "a new layer of meaning to the raw pixels "contained in the images, and then apply such insights quickly at large scales.[^8] Similar to the contrasts inherent in "distant" vs. "close" reading in digital literary studies, "distant viewing" of images and photographs can complement and support conclusions and explanations gleaned from closer, more traditionally humanistic examinations.[^9]

One benefit of beginning one's journey in computer vision with a simple experiment like smile recognition is that it is possible to make use of the pre-trained facial recognition models we used here like OpenCV's Haar Cascade and DeepFace's emotion identification. While there are other pre-trained open source object recognition models available online, like [Google's Open Images database,](https://storage.googleapis.com/openimages/web/index.html) scholars interested in using object recognition in their own work may find it necessary to train their own model, or adapt a pre-existing one, with deep learning. The learning curve for this can be high, though the [two-part _Programming Historian_ tutorial, Computer Vision for the Humanities: An Introduction to Deep Learning for Image Classification,](https://programminghistorian.org/en/lessons/computer-vision-deep-learning-pt1) provides thorough instructions for this tailor made for historians and other humanists.

Additionally, there are several companies like [Roboflow](https://roboflow.com/) and others which offer hosted computer vision trainers with a point-and-click interface. The trained model can then be downloaded and integrated into an object detector and executed with Python, like we've done here. However, even if professional companies offer heavily discounted educational licenses, there can still be financial costs, and researchers' data is often made public or at least must be made available to the host company.



## Endnotes
[^1]: Shiry Ginosar, Kate Rakelly, Sarah M. Sachs, Brian Yin, Crystal Lee, Philipp Krähenbühl and Alexei A. Efros, "A Century of Portraits: A Visual Historical Record of American High School Yearbooks," *IEEE Transactions on Computational Imaging,* 3 no. 1 (September 2017): 1, [https://arxiv.org/pdf/1511.02575.pdf](https://arxiv.org/pdf/1511.02575.pdf).
[^2]: Christina Kotchemidova, Why We Say “Cheese”: Producing the Smile in Snapshot Photography," *Critical Studies in Media Communication,* 22 no. 1 (2005): 2-25, [https://www.tandfonline.com/doi/abs/10.1080/0739318042000331853](https://www.tandfonline.com/doi/abs/10.1080/0739318042000331853).
[^3]: Paul Viola and Michael Jones, "Rapid object detection using a boosted cascade of simple features," *Proceedings of the 2001 IEEE Computer Society Conference on Computer Vision and Pattern Recognition, CVPR 2001* (2001): 1-9, [https://ieeexplore.ieee.org/document/990517/authors#authors](https://ieeexplore.ieee.org/document/990517/authors#authors).
[^4]: Joy Buolamwini and Timnit Gebru, "Gender Shades: Intersectional Accuracy Disparities in Commercial Gender Classification," *Proceedings of Machine Learning Research,* 81 (2018): 1–15, [http://proceedings.mlr.press/v81/buolamwini18a/buolamwini18a.pdf](http://proceedings.mlr.press/v81/buolamwini18a/buolamwini18a.pdf).
[^5]: Hu Han and Anil K. Jain, "Age, Gender and Race Estimation from Unconstrained Face Images," (2014) [http://biometrics.cse.msu.edu/Publications/Face/HanJain_UnconstrainedAgeGenderRaceEstimation_MSUTechReport2014.pdf](http://biometrics.cse.msu.edu/Publications/Face/HanJain_UnconstrainedAgeGenderRaceEstimation_MSUTechReport2014.pdf).
[^6]: Mei Wang, Weihong Deng, *et al.*, "Racial Faces in-the-Wild: Reducing Racial Bias by Information Maximization Adaptation Network," *Proceedings of the 2019 IEEE Computer Society Conference on Computer Vision and Pattern Recognition, CVPR 2019* (2019): 692-702, [https://arxiv.org/pdf/1812.00194.pdf](https://arxiv.org/pdf/1812.00194.pdf).
[^7]: Taylor Arnold and Lauren Tilton, "Distant viewing: analyzing large visual corpora," *Digital Scholarship in the Humanities* (2019): 1-14, [https://www.distantviewing.org/pdf/distant-viewing.pdf](https://www.distantviewing.org/pdf/distant-viewing.pdf).
[^8]: Ibid. 3.
[^9]: See also Tuomo Hiipala, "Distant viewing and multimodality theory: Prospects and challenges," *Multimodality and Society,* 1 no. 2 (2021), 134-52, [https://journals.sagepub.com/doi/pdf/10.1177/26349795211007094](https://journals.sagepub.com/doi/pdf/10.1177/26349795211007094).
