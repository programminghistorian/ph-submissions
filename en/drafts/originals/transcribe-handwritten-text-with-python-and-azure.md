---
title: "Transcribe Handwritten Text with Python and Microsoft Azure Computer Vision"
collection: lessons
layout: lesson
slug: transcribe-handwritten-text-with-python-and-azure
date: 2022-MM-DD
authors:
- Jeff Blackadar
reviewers:
- Forename Surname
- Forename Surname
editor:
- Giulia Taurino
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/511
difficulty: 2
activity: TBC
topics: [TBC]
avatar_alt: TBC
abstract: TBC
doi: TBC
---

{% include toc.html %}

## Lesson Objectives

This is a tutorial to write a program to transcribe handwritten documents using a commercially available service. The ability to transcribe handwriting is a practical and labour saving tool for historians. This tutorial will show you how to do this using the Python language.

## Introduction

Handwritten documents are a mainstay of research for many historians and are also appealing artifacts. Sources such as diaries, letters, logbooks and reports connect a historian to the writer not only through the writer's words, but also an individual's writing style. Despite the appeal of connection, research involving large amounts of these documents represents a significant challenge. Transcription of documents into digital form makes them more searchable, but hand transcription is very time consuming. While historians have been able to digitize physical typewritten documents using [optical character recognition](https://en.wikipedia.org/wiki/Optical_character_recognition) (OCR), handwriting, with its individual styles, has resisted recognition by computers.

Digitally transcribing symbols, whether typed, printed or written, is a form of pattern matching. OCR for typed characters relies on codified rules to recognize the patterns that make up a letter. Previous Programming Historian tutorials that have demonstrated typed text recognition include: Andrew Akhlaghi's ["OCR and Machine Translation"](https://programminghistorian.org/en/lessons/OCR-and-Machine-Translation), Moritz Mähr's ["Working with batches of PDF files"](https://programminghistorian.org/en/lessons/working-with-batches-of-pdf-files), Laura Turner O'Hara's ["Cleaning OCR’d text with Regular Expressions"](https://programminghistorian.org/en/lessons/cleaning-ocrd-text-with-regular-expressions) and Jon Crump's ["Generating an Ordered Data Set from an OCR Text File"](https://programminghistorian.org/en/lessons/generating-an-ordered-data-set-from-an-OCR-text-file). Recent advances in artificial intelligence offer the ability for historians to automatically transcribe handwritten documents within limits of writing systems used, language and legibility. With the advent of computer algorithms referred to as [deep Learning](https://en.wikipedia.org/wiki/Deep_learning), computers have achieved a level of generalized pattern recognition that allows them to recognize handwritten characters, even from different writers with their own styles. A related tutorial is Isabelle Gribomont's ["OCR with Google Vision API and Tesseract"](https://programminghistorian.org/en/lessons/ocr-with-google-vision-and-tesseract).

The ability of a computer using deep learning to recognize handwriting is gained through a training process, where a computer is fed a large number of images of written letters, such as the letter A, as well as data to tell the computer which letter is contained in each image. Through training, the computer recognizes visual patterns of a written A that are generally similar among other examples of written A's and differentiates and A from other letters, such as an O. This training process requires a lot of data that must be carefully classified as well as a substantial amount of computer processing to run the training. This is a specialized and labour intensive process. It is also important to note, a deep learning based recognition model reflects the data it was trained on and biases from how training data was selected.

While training a customized handwriting recognition model is possible, and for some situations may be required, it is also difficult. Fortunately, ready trained handwriting recognition services are available commercially. [Microsoft](https://docs.microsoft.com/en-us/azure/cognitive-services/computer-vision/overview-ocr), [Google Cloud Platform](https://cloud.google.com/vision/docs/handwriting) and [Amazon Web Services](https://aws.amazon.com/textract/) are companies that offer handwriting recognition services over the web. These services equip the historian who would like a faster means to transcribe handwritten documents, as long as these documents are legible and in a writing system that is recognizable to the service. As mentioned above, a deep learning based handwriting recognition service is only as good as the data it was trained on. Thus, it is important to know whether the service will work for the documents a historian is using. Unfortunately, details on how these models are trained are not readily available. Given this, I can offer only a reasonable assumption on the best use of these services.

These commercially based services perform more reliably with legible handwriting that is standardized in presentation, such as being on straight lines. The services all recognize the Roman alphabet, but other forms of writing such as Arabic are supported as well, depending on which service is used. The languages these services support are listed on these pages: [Microsoft](https://learn.microsoft.com/en-us/azure/ai-services/computer-vision/language-support#optical-character-recognition-ocr), [Google Cloud Platform](https://cloud.google.com/vision/docs/languages) and [Amazon Web Services](https://aws.amazon.com/textract/faqs/).

For a historian, an appropriate use of this technology would be transcribe legible handwritten documents. This automated transcription method faces some of the same limitations of manual transcription, however. Like a human, automated transcription will struggle to recognize handwriting that is only lightly visible, such as pencil, or otherwise poorly contrasted. As noted above, not all languages and writing systems are supported at this time, unfortunately. Despite these limitations, handwriting recognition is now a useful and practical tool for historians who need to transcribe documents.

For this lesson we will use Microsoft's Azure Cognitive Services to transcribe handwriting. Azure Cognitive Services is accessed over the web and does not get installed on your computer. Your computer connects to it and sends it images to process for handwriting recognition. Azure Cognitive Services replies with the text it detects in an image. Azure Cognitive Services performs reliably with handwritten documents and based on personal usage it performs as well as Google or Amazon Web Services on documents written in English and French.

Microsoft's Azure Cognitive Services can be harnessed to transcribe both typed text and handwriting as well as a combination of both. It can transcribe documents such as diaries, letters, forms, logbooks and research notes. I have used it to transcribe maps and diagrams as well. The potential uses for Digital History are numerous! Transcription with Azure Cognitive Services is well documented, but does require programming, hence this tutorial.

## Prerequisites

+ Knowledge of Python is not required since all of the code is provided in the tutorial. That said, basic Python knowledge would be useful for users who wish to understand the code or to tweak it for their purposes.
+ [Google Colab](https://colab.research.google.com/), a web-based virtual Python programming platform, was used to write this lesson. If you choose to use Google Colab to program Python (recommended), a Google account is required. If you choose to run the code in this tutorial locally on your own machine, Python 3.x and pip need to be installed.
+ An internet connection.
+ A credit card or debit card. (Though there is a free tier of service for Microsoft, you are required to put a credit or debit card on file. The card is not charged if the number of files processed is below 5,000 each month.)
+ A telephone number. (This is to verify your identity.)

## Procedure

We'll transcibe handwriting in an image by following these steps:
1. Register for a personal Microsoft account.
2. Create a "Computer Vision" Resource in Azure to perform transcription.
3. Create and store a secret Key and Endpoint to access Computer Vision.
4. Create a notebook.
5. Install Azure Computer Vision in your Python environment.
6. Transcribe handwriting.
    1. Image requirements.
    2. Transcribe handwriting in an image found online.
    3. Transcribe handwriting in an image stored in your Python environment.
    4. Transcribe handwriting in an image stored in your Python environment using a function. (Optional)
    5. Transcribe handwriting in all of the images in a folder and save the text in a file. (Optional)

### 1. Register for a personal Microsoft account.
If you already have a personal Microsoft account, skip this section. If you have already have a Microsoft account for work or school you may not be able to access Azure Cognitive Services. If so, just register for a separate personal account using a different e-mail address.

1. Go to [https://portal.azure.com/](https://portal.azure.com/).
2. If you have a personal account with Microsoft or Github, log in and skip below to 2. Create a "Computer Vision" Resource in Azure to perform transcription.
3. If you don't have an account, register by clicking "No account? _Create one!_".
4. Input your e-mail address and follow the prompts.
5. Check your e-mail inbox for a verification code and input this into the web browser.

### 2. Create a "Computer Vision" Resource in Azure to perform transcription.
1\. Go to [https://portal.azure.com/](https://portal.azure.com/).

2\. Click + Create a resource. You will need to do this twice. The first time is to set up your payment method as noted in the steps below.

{% include figure.html filename="step2-2.png" alt="Picture of the Create a resource + icon and link." caption="Figure 1. + Create a resource." %}

3\. In the "Search services and marketplace" box, type Computer Vision and search. When the search results open, click "Create" under the heading "Computer Vision".

4\. Click "Start with an Azure free trial". (If your account is not eligible for an Azure free trial you will have to use pay-as-you-go pricing. With pay-as-you-go pricing there is still a free level of consumption, if it has not been spent already.)

5\. Input a telephone number to verify your identity.

6\. Input your contact information and credit card number. Microsoft will verify the information. Once this is done, return to the [Azure portal](https://portal.azure.com/). You can do this by clicking the "Go to Azure portal" button and then click the "Home" link.

7\. Click + Create a resource (for the second time). This will create the instance of Computer Vision for you to use.

{% include figure.html filename="step2-2.png" alt="Picture of the Create a resource + icon and link." caption="Figure 2. + Create a resource." %}

8\. In the "Search services and marketplace" box, type Computer Vision and search. When the search results open, click "Create" under the heading "Computer Vision".

9\. In the "Create Computer Vision" screen, "Basics" tab, "Project Details" section, set the "Subscription" field to an available choice such as *Free Trial*. For "Resource group", click "Create new" and name it *resource_group_transcription*. Click OK.

{% include figure.html filename="step2-9.png" alt="Picture of the Create Computer Vision window." caption="Figure 3. + Resource group \| Create new." %}

10\. In the _Instance Details_ section, select a region, input a unique name and set _Pricing tier_ to Free F0. (__Important__)

11\. Read the _Responsible AI Notice_ and check the box. The "Identity" and "Tags" tabs can be left with default values. They are relevant only if you are using this in combination with other Microsoft Azure services.

12\. Click _Review + create_

13\. Click _Create_

14\. Wait for a message to say _Your deployment is complete_

15\. Click _Go to resource_

16\. Once we see the screen for your newly created resource we can store the password key and endpoint url we'll need to access this service from your python environment.

### 3. Create and store a secret Key and Endpoint to access Computer Vision
To use the service your computer program must send a password key to an endpoint URL at Microsoft Azure. As it says on Azure: "Do not share your keys. Store them securely...". Keeping your keys secure reduces the risk of someone else improperly using your credits to transcribe documents.

To reduce the risk of inadvertently sharing your secret key, store it in a separate file in a different folder than the program you're writing.
This protects your key better than including it inside code you may share.

1\. In the Azure Portal, open the Keys and Endpoint page of your resource.

{% include figure.html filename="step3a-3.png" alt="Visual description of figure image" caption="Figure 4. Keys and Endpoint." %}

2\. Copy KEY 1 and paste it into a separate text file on your machaine you can refer to. The key will look a bit like this b-f-9-7-0-8-4-8-b-7-a-6-6-8-1-9-. There are two keys, but you only need to use one of them for this lesson.

3\. Copy endpoint and paste it in your file for reference. The endpoint contains your unique resource name and will be similar to this https://computer-vision-transcription-jhb.cognitiveservices.azure.com/. This is the URL your Python program will use to communicate with Microsoft Azure Cognitive Services.

Regenerating your keys using the button of the Keys and Endpoint page is a good way to keep keys secure. When your key changes, just copy and paste it to where you store your key. If you are using this service constantly, logic can be added to your program to use the second key while the first key is being regenerated in order to avoid an error.



### 4. Create a Python notebook

1\. Go to: [https://colab.research.google.com/](https://colab.research.google.com/) (Google Colab is recommended for this lesson, but you can use another Python environment of your choice, such as Anaconda. See the lesson by Quinn Dombrowski, Tassie Gniady, and David Kloster, "Introduction to Jupyter Notebooks.[^1]))

2\. Click _New Notebook_ in the dialog box that opens. Clicking _File_ \| _New notebook_ in the menu will do the same thing.

3\. When the notebook opens, give it a new title at the top: "Transcribe handwriting and text with Microsoft Azure Cognitive Services.ipynb"

4\. The code below will store your Key and Endpoint in an environment variable so that it can be accessed by the program. In Google Colab an empty text box or "cell" to write code in should be visible, if not click the "+ Code" button to add a new code cell. Copy the code below into a cell in your notebook. Edit line 7 to change "https://computer-vision-transcription-jhb.cognitiveservices.azure.com/" to the Endpoint URL you created in the section above.

```
import os

print('Enter your secret computer vision key:')
cv_key = input()

# Change the cv_endpoint below to your endpoint
cv_endpoint = "https://computer-vision-transcription-jhb.cognitiveservices.azure.com/"

# Store as enivonmental variables
os.environ['COMPUTER_VISION_SUBSCRIPTION_KEY'] = cv_key
os.environ['COMPUTER_VISION_ENDPOINT'] = cv_endpoint

# Do some basic validation
if len(os.environ['COMPUTER_VISION_SUBSCRIPTION_KEY']) == 32:
    print("Success, COMPUTER_VISION_SUBSCRIPTION_KEY is loaded.")
else:
    print("Error, The COMPUTER_VISION_SUBSCRIPTION_KEY is not the expected length, please check it.")
print("Delete this output")
```


{% include figure.html filename="azure_handwriting_colab_step_4.png" alt="Google Colab notebook" caption="Figure 5. Create a Python notebook in Google Colab." %}

The figure above shows a Colab notebook with a new title, the "+ Code" button to add a cell and the triangular play button to run a cell.

5\. Run this cell by clicking the triangular "play" button. In the menu, _Runtime_ \| _Run the focused cell_ will do the same thing. At the prompt below the cell input your key and press enter.

{% include figure.html filename="azure_handwriting_colab_step_5_enter.png" alt="A prompt to enter the Key." caption="Figure 6. Entering the Key when prompted." %}

Running the program will use Python's os library to store the key and endpoint URL into environment variables so these values can be used when communicating with Azure. The expected result is to see this printed:

```
Success, COMPUTER_VISION_SUBSCRIPTION_KEY is loaded.
Delete this output
```
Click "x" in the notebook output to delete it.  This deletes the text of your key.
If you see an error message, check that you copied and input the key correctly.

{% include figure.html filename="azure_handwriting_colab_step_5_clear.png" alt="The clear output button for a cell in a Google Colab notebook." caption="Figure 7. Clear output below a cell in a Google Colab notebook." %}

### 5. Install Azure Computer Vision in your Python environment.[^2]
Create a new cell in your notebook, paste in the code below and run it. It will install the Python library required to connect to Azure Cognitive Services Computer Vision. If you are using Google Colab, you will need to do this once per session. If you are using a Python environment on your computer instead of Google Colab, you only need to do this once but may need to remove the exclamation mark to run the *pip install* command.
```
# Install what is required to connect to Azure Cognitive Services Computer Vision
# Run this once on your machine. If you are using Google Colab, run this once per session.
!pip install --upgrade azure-cognitiveservices-vision-computervision
```

Create another new cell in your notebook, paste in the code below and run it. It will:
+ Import the required libraries.
+ Get your Computer Vision subscription key from your environment variable.
+ Get your Computer Vision endpoint from your environment variable.
+ Authenticate with Azure Cognitive Services.

```
# Run this once per session

# Import the required libraries
from azure.cognitiveservices.vision.computervision import ComputerVisionClient
from azure.cognitiveservices.vision.computervision.models import OperationStatusCodes
from azure.cognitiveservices.vision.computervision.models import VisualFeatureTypes
from msrest.authentication import CognitiveServicesCredentials
import sys

# Get your Computer Vision subscription key from your environment variable.
if 'COMPUTER_VISION_SUBSCRIPTION_KEY' in os.environ:
    subscription_key = os.environ['COMPUTER_VISION_SUBSCRIPTION_KEY']
else:
    print("\nSet the COMPUTER_VISION_SUBSCRIPTION_KEY environment variable.\n**Restart your shell or IDE for changes to take effect.**")
    sys.exit()

# Get your Computer Vision endpoint from your environment variable.
if 'COMPUTER_VISION_ENDPOINT' in os.environ:
    endpoint = os.environ['COMPUTER_VISION_ENDPOINT']
else:
    print("\nSet the COMPUTER_VISION_ENDPOINT environment variable.\n**Restart your shell or IDE for changes to take effect.**")
    sys.exit()

# Authenticate with Azure Cognitive Services.
computervision_client = ComputerVisionClient(endpoint, CognitiveServicesCredentials(subscription_key))

```
### 6. Transcribe handwriting

#### 6.i Image requirements

+ Acceptable Formats: JPEG, PNG, GIF, BMP
+ Minimum size: 50 x 50 pixels
+ Maximum size: 4 MB

Images with higher contrast and clear handwriting work better than images that are difficult to read or contain fragments of letters. Try a sample of images before starting a large transcription project.

Use of Azure Cognitive Services sends the image to Microsoft for processing. When working with images or text, respect any restrictions on use or transmission.


#### 6.ii Transcribe handwriting in an image found online.

This section will allow you to transcribe handwriting of an image found online. This requires the URL for the image. For this example, we'll use http://jeffblackadar.ca/captain_white_diary/page_images/td_00044_b2.jpg.

{% include figure.html filename="captain-white-diary.jpeg" alt="Visual description of figure image" caption="Figure 8. A page from Captain White's diary" %}

1\. Create another new cell in your notebook, paste in the code below and run it. It will:
+ Set the url of the image to transcribe. (See line 9 for reference. Line numbers are visible in Google Colab and noted in some program comments.)
+ Call Azure using computervision_client with the URL. (Line 12)
+ Read the results line by line. (Lines 22-26)
+ If successful, print the text of each line as well as the coordinates of a rectangle in the image where the text is located. (Lines 29-33)

```
import time
# This section is taken directly from:
# https://github.com/Azure-Samples/cognitive-services-quickstart-code/blob/master/python/ComputerVision/ComputerVisionQuickstart.py


# <snippet_read_call>
print("===== Read File - remote =====")
# Get an image with text. Set the url of the image to transcribe. Line 8
read_image_url = "http://jeffblackadar.ca/captain_white_diary/page_images/td_00044_b2.jpg"

# Call API with URL and raw response (allows you to get the operation location). Call Azure using computervision_client with the URL. Line 11
read_response = computervision_client.read(read_image_url,  raw=True)
# </snippet_read_call>

# <snippet_read_response>
# Get the operation location (URL with an ID at the end) from the response
read_operation_location = read_response.headers["Operation-Location"]
# Grab the ID from the URL
operation_id = read_operation_location.split("/")[-1]

# Call the "GET" API and wait for it to retrieve the results Line 21
while True:
    read_result = computervision_client.get_read_result(operation_id)
    if read_result.status not in ['notStarted', 'running']:
        break
        time.sleep(1)

# Print the detected text, line by line Line 28
if read_result.status == OperationStatusCodes.succeeded:
    for text_result in read_result.analyze_result.read_results:
        for line in text_result.lines:
            print(line.text)
            print(line.bounding_box)
print()

# </snippet_read_response>

```

[^3]

When you run the cell, you should see lines recognized text printed along with their pixel coordinates in the image.

```
===== Read File - remote =====
DECEMBRE
[647.0, 75.0, 1198.0, 63.0, 1199.0, 136.0, 647.0, 151.0]
28 VENDREDI. Ss Innocents
[347.0, 202.0, 1146.0, 190.0, 1148.0, 248.0, 347.0, 269.0]
362-3
[1316.0, 179.0, 1456.0, 179.0, 1459.0, 239.0, 1315.0, 236.0]
clear and cold, - lovely out.
[60.0, 286.0, 1711.0, 236.0, 1712.0, 333.0, 63.0, 396.0]
Visit from mme Thomas D
[66.0, 395.0, 1717.0, 349.0, 1718.0, 437.0, 66.0, 500.0]
five daughters from
[91.0, 499.0, 1523.0, 448.0, 1529.0, 569.0, 96.0, 628.0]
Pontarleír.
[127.0, 614.0, 919.0, 577.0, 925.0, 689.0, 131.0, 716.0]
your Doctor, Major merletti
[105.0, 744.0, 1722.0, 628.0, 1729.0, 761.0, 114.0, 872.0]
arrived- good fellow
[98.0, 871.0, 1509.0, 770.0, 1511.0, 875.0, 103.0, 952.0]
Not orders to go with Capt
[133.0, 945.0, 1716.0, 847.0, 1723.0, 952.0, 137.0, 1036.0]
Marrison Vit Road and 200
[99.0, 1042.0, 1709.0, 964.0, 1714.0, 1057.0, 102.0, 1127.0]
men to another part of
[118.0, 1130.0, 1649.0, 1065.0, 1651.0, 1166.0, 119.0, 1221.0]
France
[123.0, 1224.0, 655.0, 1222.0, 655.0, 1304.0, 123.0, 1306.0]
prote Inier
[135.0, 1316.0, 784.0, 1284.0, 788.0, 1365.0, 139.0, 1395.0]
Sittley wip mess account
[131.0, 1385.0, 1786.0, 1280.0, 1792.0, 1379.0, 136.0, 1469.0]
Cash so francs you the mouth
[113.0, 1467.0, 1853.0, 1398.0, 1854.0, 1495.0, 117.0, 1560.0]

```



#### 6.iii Transcribe handwriting in an image stored in your Python environment.

This section will allow you to transcribe handwriting of an image stored in your Python environment. It's a lot like the above section. You must have an image saved on the computer you are running Python from. For Google Colab, we are using a virtual computer. For this example, you can download an image and save it. Here is an example image to download: http://jeffblackadar.ca/captain_white_diary/page_images/td_00044_b2.jpg.

1\. Select or create a directory for your image. If you are working on Google Colab, the working directory /content/ may be used.

2\. Download an example image and move it to your directory. In Google Colab, open the Files pane by clicking the Files icon on the left of the window. Click the Upload to session storage button to upload the file.

{% include figure.html filename="azure_handwriting_colab_step_6_file.png" alt="The Files pane in Google Colab with the Upload to session storage button." caption="Figure 9. The Files pane in Google Colab with 1. The Files icon to open it, 2. The 'Upload to session storage' button used to upload the file and 3. The uploaded file." %}

3\. Create another new cell in your notebook, paste in the code below. You may have to edit the code to work with the folder or file names you are using. The code will:

+ Set the path to the folder this image is in. (Line 1) The /content/ folder is the default folder in Google Colab. If you are using a different folder change line 1.
+ Set the filename of the image to be read. (Line 5) Change this as needed.
+ Open the image to be read. (Line 8)
+ Call Azure using computervision_client with the image. (Line 12)
+ Read the results line by line. (Lines 21-26)
+ If successful, print the text of each line. (Lines 29-32)
+ Line 33 which prints the coordinates of each rectangle is commented out. 


```
images_folder = "/content/"

print("===== Read File - local =====")
# Set the path to the image. Line 4
read_image_path = os.path.join(images_folder, "td_00044_b2.jpg")

# Open the image. Line 7
read_image = open(read_image_path, "rb")


# Call API with image and raw response (allows you to get the operation location). Call Azure using computervision_client with the image. Line 11
read_response = computervision_client.read_in_stream(read_image, raw=True)

# Get the operation location (URL with ID as last appendage)
read_operation_location = read_response.headers["Operation-Location"]

# Take the ID off and use to get results
operation_id = read_operation_location.split("/")[-1]

# Call the "GET" API and wait for the retrieval of the results. Line 20
while True:
    read_result = computervision_client.get_read_result(operation_id)
    if read_result.status.lower() not in ['notstarted', 'running']:
        break
        print('Waiting for result...')
        time.sleep(10)

# Print results, line by line. Line 28
if read_result.status == OperationStatusCodes.succeeded:
    for text_result in read_result.analyze_result.read_results:
        for line in text_result.lines:
            print(line.text)
            # print(line.bounding_box)
print()
```

[^3]


4\. Run the cell to read the handwriting in the image. You should see lines of recognized text printed. You can remove the # sign in line 33 to print the text bounding box coordinates.

```
===== Read File - local =====
DECEMBRE
28 VENDREDI. Ss Innocents
362-3
clear and cold, - lovely out.
Visit from mme Thomas D
five daughters from
Pontarleír.
your Doctor, Major merletti
arrived- good fellow
Not orders to go with Capt
Marrison Vit Road and 200
men to another part of
France
prote Inier
Sittley wip mess account
Cash so francs you the mouth
```

#### 6.iv Transcribe handwriting in an image stored in your Python environment using a function.

This section will allow you to transcribe handwriting of an image stored in your Python environment in the same manner used in the above section. You must have an image saved on the computer you are running Python from so if you have not done so, complete steps 1 and 2 in the section above to store an image in a folder in your Python environment.

The purpose of this section is to reorganize the code used above into a function. A function is a block of code that can be called repeatedly. This is useful for processing multiple images. This function requires the path to the image as input and it returns the text of the image as output.

1\. Create another new cell in your notebook, paste in the code for the function below. The code will:

+ Define the name of the function and what it uses as input. (Line 1)
+ Check the image path exists. (Line 3)
+ Open the image to be read. (Line 9)
+ Call Azure using computervision_client with the image. (Line 13)
+ Read the results line by line. (Lines 22-27)
+ If successful, store each line of text in the variable text_in_image. (Lines 29-32)
+ The last line returns the value of text_in_image. 

```
def read_handwriting_in_stored_image(read_image_path):
    # If the path to the image does not exist, print an error and return an empty string. Line 2.
    if not os.path.exists(read_image_path):
        print("Image not found. Path", read_image_path, " does not exist.")
        return("")

    # The text_in_image will be returned. Set it to an empty string to start. Line 6.
    text_in_image = ""

    read_image = open(read_image_path, "rb")

    # Call API with image and raw response (allows you to get the operation location). Call Azure using computervision_client with the image. Line 12
    read_response = computervision_client.read_in_stream(read_image, raw=True)

    # Get the operation location (URL with ID as last appendage)
    read_operation_location = read_response.headers["Operation-Location"]

    # Take the ID off and use to get results
    operation_id = read_operation_location.split("/")[-1]

    # Call the "GET" API and wait for the retrieval of the results. Line 21
    while True:
        read_result = computervision_client.get_read_result(operation_id)
        if read_result.status.lower() not in ['notstarted', 'running']:
            break
            print('Waiting for result...')
            time.sleep(10)

    # Print results, line by line. Line 29
    if read_result.status == OperationStatusCodes.succeeded:
        for text_result in read_result.analyze_result.read_results:
            for line in text_result.lines:
                text_in_image = text_in_image + "\n"+ line.text

    # return the text
    return(text_in_image)

```
2\. Run the cell to load the function. Nothin else will happen until it is called in the next step.

3\. Create another new cell in your notebook, paste in the code for the function below. The code will:

+ Set the path to the folder this image is in. (Line 1) The /content/ folder is the default folder in Google Colab. If you are using a different folder change line 1.
+ Set the filename of the image to be read. (Line 4) Change this as needed.
+ Call the read_handwriting_in_stored_image function defined above. (Line 7)

```
images_folder = "/content/"

# Set the path to the image. Line 3.
read_image_path = os.path.join(images_folder, "td_00044_b2.jpg")

# call the read_handwriting_in_stored_image function defined above with the read_image_path variable. Line 6.
image_text = read_handwriting_in_stored_image(read_image_path)

print(image_text)
```
4\. Run the cell to call the function. You should see lines of recognized text printed similar to the section above. Now that we have a working function, we can use it for more purposes.

#### 6.v Transcribe handwriting in all of the images in a folder and save the text in a file. (Optional)

This section will allow you to transcribe handwriting in all of the images in a folder. You must have a folder with images saved on the computer you are running Python from. For Google Colab, we are using a virtual computer. For this example, you can download these image and save them. Here are example images to download: 

+ [http://jeffblackadar.ca/captain_white_diary/page_images/td_00040_b1.jpg](http://jeffblackadar.ca/captain_white_diary/page_images/td_00040_b1.jpg)
+ [http://jeffblackadar.ca/captain_white_diary/page_images/td_00040_b2.jpg](http://jeffblackadar.ca/captain_white_diary/page_images/td_00040_b2.jpg)
+ [http://jeffblackadar.ca/captain_white_diary/page_images/td_00041_b1.jpg](http://jeffblackadar.ca/captain_white_diary/page_images/td_00041_b1.jpg)
+ [http://jeffblackadar.ca/captain_white_diary/page_images/td_00041_b1.jpg](http://jeffblackadar.ca/captain_white_diary/page_images/td_00041_b1.jpg)

1\. Download the example images and move them to your directory. In Google Colab, open the Files pane by clicking the Files icon on the left of the window. Click the Upload to session storage button to upload the file. See Figure 9 above.

2\. Create another new cell in your notebook, paste in the code below. You may have to edit the code to work with the folder or file names you are using. The code will:

+ Set the path to the folder this image is in. (Line 4) The /content/ folder is the default folder in Google Colab. If you are using a different folder change line 4.
+ Open a text file to write to it. (Line 10)
+ Loop through the files in the folder. (Lines 16-30)
+ Check that the file has an image extension. (Line 19)
+ Call the read_handwriting_in_stored_image function. (Line 26)
+ Write the text returned from the function to the text file. (Line 28)
+ Wait 10 seconds before processing the next file to avoid an error caused by sending too many requests at once. (Line 30)
+ Close the text file. (Line 32)

```
import os

# set the folder where the images are. Line 3.
images_folder = "/content/"

# Set the path to file containing recognized text. Line 6.
text_file_path = os.path.join(images_folder, "a_text_file.txt")

# Open a text file to write to it. Line 9.
f = open(text_file_path, "w")

# store a list of allowed image extensions. Line 12.
image_extensions = (".bmp", ".gif",".jpg", ".jpeg", ".png")

# loop through each file in the folder. Line 15.
for root, dirs, files in os.walk(images_folder):
    for file in files:
        # check the file ends with an extension for an image. Line 18
        if file.lower().endswith(image_extensions):
             print(os.path.join(root, file))
             # write a header for each text file. Line 21.
             f.write("\n------------------------------\n" + os.path.join(root, file) + "\n")
             # store the path into the read_image_path variable. Line 23.
             read_image_path = os.path.join(root, file)
             # call the function to read_handwriting_in_stored_image. Line 25.
             image_text = read_handwriting_in_stored_image(read_image_path)
             # write the text to the file. Line 27.
             f.writelines(image_text)
             # wait 10 seconds before processing the next file to avoid an error caused by too many requests. Line 29.
             time.sleep(10)
# close the text file. Line 31.
f.close()
```
3\. Run the cell. This will take a few minutes to complete. During this time, you should see the name of each file printed as it is processed. When the program is finished, look in the folder, click the refresh button and double-click on the file named "a_text_file.txt" to view it. You should see the text from all the images.

## Summary
You have connected to Azure Cognitive Services Computer Vision and transcribed the text of an image on a website and an image stored on a computer. With this code, you can add more steps to process multiple images and store the transcribed text in a file or database. Using Python, a loop can transcribe all of the images in a directory or on a series of web pages. Using the positions of the transcribed text returned by Azure Cognitive Services, it is possible to transcribe written forms, lists or logs into structured data, like a spreadsheet or database. It is even possible to translate the image coordinates of text into geographic coordinates when text is transcribed from a map.

While it is not possible to customize the handwriting recognition of Azure Cognitive Services, it is likely its capabilities will continue to evolve as language support is improved. As capabilities grow so the potential uses for this type of transcription for Digital History continue to grow as well.

## Bibliography

Library and Archives Canada. William Andrew White fonds, R15535-0-8-E, "Diary 1917" [http://collectionscanada.gc.ca/pam_archives/index.php?fuseaction=genitem.displayItem&lang=eng&rec_nbr=4818067](http://collectionscanada.gc.ca/pam_archives/index.php?fuseaction=genitem.displayItem&lang=eng&rec_nbr=4818067)

Quinn Dombrowski, Tassie Gniady, and David Kloster, "Introduction to Jupyter Notebooks," _Programming Historian_ 8 (2019), https://doi.org/10.46430/phen0087.

Graham, Shawn. Detecting and Extracting Hand-written text. Jan 28, 2020. https://shawngraham.github.io/dhmuse/detecting-handwriting/. Accessed 25 December, 2021.

Cognitive-services-quickstart-code, June 22, 2021, https://docs.microsoft.com/en-us/azure/cognitive-services/computer-vision/quickstarts-sdk/python-sdk. Accessed 25 December, 2021.

## Footnotes

[^1]: Quinn Dombrowski, Tassie Gniady, and David Kloster, "Introduction to Jupyter Notebooks," _Programming Historian_ 8 (2019), https://doi.org/10.46430/phen0087.
[^2]: Cognitive-services-quickstart-code, June 22, 2021, https://docs.microsoft.com/en-us/azure/cognitive-services/computer-vision/quickstarts-sdk/python-sdk. Accessed 25 December, 2021.
[^3]: Cognitive-services-quickstart-code, https://docs.microsoft.com/en-us/azure/cognitive-services/computer-vision/quickstarts-sdk/python-sdk. Accessed 25 December, 2021.
[^4]: Ibid.
