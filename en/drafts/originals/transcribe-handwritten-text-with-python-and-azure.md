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

## Introduction

Handwritten documents are a mainstay of research for many historians and are also appealing artifacts. These sources connect a historian to the writer not only through the writer's words, but also an individual's writing style. Despite the appeal of connection, research involving large amounts of these documents represents a significant challenge. Transcription of documents into digital form makes them more searchable, but hand transcription is very time consuming. While historians have been able to digitize physical typewritten documents using [optical character recognition](https://en.wikipedia.org/wiki/Optical_character_recognition), handwriting, with its individual styles, has resisted recognition by computers.

Advances in technology offer the ability for historians to automatically transcribe handwritten documents, within limits of types of letters used, language and legibility. Digitally transcribing symbols, whether typed, printed or written is a form of pattern matching. Optical character recognition (OCR) for typed characters relies on codified rules to recognize the patterns that make up a letter. (To learn more about how to use OCR see Andrew Akhlaghi's ["OCR and Machine Translation"](https://programminghistorian.org/en/lessons/OCR-and-Machine-Translation).) With the advent of [Convolutional Neural Networks](https://en.wikipedia.org/wiki/Convolutional_neural_network) (CNNs), computers have achieved a level of generalized pattern recognition that allows them to recognize handwritten characters, even from different writers with their own styles.

The ability of a CNN to recognize handwriting is gained through a training process, where the CNN is fed a large number of images of written letters, such as the letter A, as well as data to tell the CNN which letter is contained in each image. Through training, the CNN recognizes visual patterns of a written A that are generally similar among other examples of written A's and differentiates and A from other letters, such as an O. This training process requires a lot of data that must be carefully classified as well as a substantial amount of computer processing to run the training. This is a specialized and labour intensive process. It is also important to note, a CNN based recognition model reflects the data it was trained on and biases from how training data was selected.

While training a customized handwriting recognition model is possible, and for some situations may be required, it is also difficult. Fortunately, ready trained handwriting recognition services are available commercially. [Microsoft](https://docs.microsoft.com/en-us/azure/cognitive-services/computer-vision/overview-ocr), [Google Cloud Platform](https://cloud.google.com/vision/docs/handwriting) and [Amazon Web Services](https://aws.amazon.com/textract/) are companies that offer handwriting recognition services over the web. These services equip the historian who would like a faster means to transcribe handwritten documents, as long as these documents are recognizable to the service. As mentioned above, a CNN based handwriting recognition service is only as good as the data it was trained on. Thus, it is important to know whether the service will work for the documents a historian is using. Unfortunately, details on how these models are trained is not readily available, I assume to protect intellectual property. Given this, I can offer only a reasonable assumption on the best use of these services.

These commercially based services perform more reliably with legible handwriting that is standardized in presentation, such as being on straight lines. The services all recognize the Roman alphabet, but other forms of writing such as Arabic are supported as well, depending on the company. For a historian, the use of this technology is appropriate to transcribe legible handwritten documents from the nineteenth century until the present day, depending on the language. Handwritten diaries, letters, forms and log books are types of sources that may be transcribed.

For this lesson we will use Microsoft's Azure Cognitive Services. It performs reliably with handwritten documents and based on personal usage it performs as well as Google or Amazon Web Services.

## Prerequisites

+ A computer with Python installed.
+ An internet connection.
+ A credit card. (There is a free tier of service. The credit card is not charged if the number of files processed is below 5000 each month.)
+ A telephone number.
+ Google Colab was used to write this lesson. If you choose to use Google Colab to program Python, a Google account is required.

## Procedure
We'll transcibe handwriting in an image by following these steps:
1. Register for a Microsoft account.
2. Create a "Computer Vision" Resource in Azure to perform transcription.
3. Store a secret Key and Endpoint to access Computer Vision from your machine.
4. Install Azure Computer Vision on your machine.
5. Transcribe handwriting in an image on a website.
6. Transcribe handwriting in an image stored on your machine.

### 1. Register for a Microsoft account
1. Go to [https://portal.azure.com](https://portal.azure.com)
2. If you have an account with Microsoft or Github, log in and skip to 2. Setup Transcription: Create a Resource in Azure, below.
3. If you don't have an account, register by clicking "No account? _Create one!_".
4. Input your e-mail address.
5. Check your e-mail inbox for a verification code and input this into the web browser.

### 2. Create a "Computer Vision" Resource in Azure to perform transcription
1. Go to https://portal.azure.com/
2. Click + Create a resource. You will need to do this twice. The first time is to set up your payment method as noted in the steps below.

{% include figure.html filename="step2-2.png" alt="Visual description of figure image" caption="Figure 1. + Create a resource." %}

3\. In the "Search services and marketplace" box, type Computer Vision and search. When the search results open, click "Create" under the heading "Computer Vision".
4\. Click "Start with an Azure free trial".
5\. Input a telephone number to verify your identity.
6\. Input your contact information and credit card number.
7\. Click + Create a resource (for the second time). This will create the instance of Computer Vision for you to use.

{% include figure.html filename="step2-2.png" alt="Visual description of figure image" caption="Figure 2. + Create a resource." %}

8\. In the "Search services and marketplace" box, type Computer Vision and search. When the search results open, click "Create" under the heading "Computer Vision".
9\. In the _Create Computer Vision_ screen, _Basics_ tab, _Project Details_ section, set these fields:
	+ _Subscription_: Azure subscription 1
	+ _Resource group_: click _Create new_
	+ For _Name_ input resource_group_transcription. Click OK.

{% include figure.html filename="step2-9.png" alt="Visual description of figure image" caption="Figure 3. + Resource group | Create new." %}

10\. In the _Instance Details_ section:
	 + Select a Region near to you. This is where the instance is hosted.
	 + Name the instance. Choose a unique name that is unique with letters or hyphens only. Input _computer-vision-transcription-uuu_, where uuu is your initials or something unique. I used _computer-vision-transcription-jhb_.
	 + Set _Pricing tier_ to Free F0. (__Important__)
11\. Read the _Responsible AI Notice_ and check the box.
12\. Click _Review + create_
13\. Click _Create_
14\. Wait for a message to say _Your deployment is complete_
15\. Click _Go to resource_
16\. Once we see the resource screen for _computer-vision-transcription-jhb_ we can store the keys and endpoint we'll need to access this service from your computer.

### 3. Store a secret Key and Endpoint to access Computer Vision from your machine
To use the service your computer program must send a Key to an Endpoint at Microsoft Azure. As it says on Azure: "Do not share your keys. Store them securely..."

To reduce the risk of inadvertently sharing your secret key, store it in a separate file in a different folder from the rest of the program you're writing.
This helps protect your key. For example, if you check your code into a repository like GitHub, you can avoid checking in the file with your secret key along with your code. If you don't use GitHub, don't worry, just paste your key in a place you can refer to it that is separate from your program.

1. In the Azure Portal, open the Keys and Endpoint page of your computer-vision-transcription-jhb

{% include figure.html filename="step3a-3.png" alt="Visual description of figure image" caption="Figure 4. Keys and Endpoint." %}

2\. Copy KEY 1 and paste it into a separate file you can refer to. The key will look a bit like this b-f-9-7-0-8-4-8-b-7-a-6-6-8-1-9-.

3\. Copy Endpoint and paste it in your file for reference. The endpoint will look like this https://computer-vision-transcription-jhb.cognitiveservices.azure.com/.

4\. Regenerating your keys using the button on the Keys and Endpoint page is a good way to keep keys secure. When your key changes, just copy and paste it to where you store your key.

#### 3.B. Create a notebook

1. Go to: https://colab.research.google.com/ (or another Python environment of your choice, such as Anaconda. See the lesson by Quinn Dombrowski, Tassie Gniady, and David Kloster, "Introduction to Jupyter Notebooks.[^1]))
2. Click _New Notebook_.
3. Give the Notebook a title: "Transcribe handwriting and text with Microsoft Azure Cognitive Services.ipynb"
4. This code below will store your Key and Endpoint in an environment variable so that it can be accessed by the program. Create a new cell and copy the code below into your notebook.

```
import os

print('Enter your secret computer vision key:')
cv_key = input()

# Change the cv_endpoint below to your endpoint
cv_endpoint = "https://computer-vision-transcription-jhb.cognitiveservices.azure.com/"

# Store as enivonmental variables
os.environ['COMPUTER_VISION_SUBSCRIPTION_KEY'] = cv_key
os.environ['COMPUTER_VISION_ENDPOINT'] = cv_endpoint

# Do some basic validation
if len(os.environ['COMPUTER_VISION_SUBSCRIPTION_KEY']) == 32:
    print("Success, COMPUTER_VISION_SUBSCRIPTION_KEY is loaded.")
else:
    print("Error, The COMPUTER_VISION_SUBSCRIPTION_KEY is not the expected length, please check it.")
print("Delete this output")
```

2. Run this cell.  The expected result is to see this printed:

```
Success, COMPUTER_VISION_SUBSCRIPTION_KEY is loaded.
Delete this output
```
Click "x" in the notebook output to delete it.  This deletes the text of your key.
If you see error messages, check that you input the key correctly.

### 4. Install Azure Computer Vision on your machine[^2]
1. Create a new cell in your notebook, paste in this code and run it. It will install what is required to connect to Azure Cognitive Services Computer Vision. You only need to do this once on your machine. If you are using Google Colab, you will need to do this once per session.
```
# Install what is required to connect to Azure Cognitive Services Computer Vision
# Run this once on your machine. If you are using Google Colab, run this once per session.
!pip install --upgrade azure-cognitiveservices-vision-computervision
```

2. Create another new cell in your notebook, paste in this code and run it. It will:
+ Import the required libraries.
+ Get your Computer Vision subscription key from your environment variable.
+ Same thing with your Endpoint.
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

### 5. Transcribe handwriting in an image on a website.

This section will allow you to transcribe handwriting of an image on a website. This requires the URL for the image. For this example, we'll use http://jeffblackadar.ca/captain_white_diary/page_images/td_00044_b2.jpg.

{% include figure.html filename="captain-white-diary.jpeg" alt="Visual description of figure image" caption="Figure 5. A page from Captain White's diary" %}

1. Open a new cell in your notebook, paste in the code block below and run it.

```
import time
# This section is taken directly from:
# https://github.com/Azure-Samples/cognitive-services-quickstart-code/blob/master/python/ComputerVision/ComputerVisionQuickstart.py


# <snippet_read_call>
print("===== Read File - remote =====")
# Get an image with text. Set the url of the image to transcribe.
read_image_url = "http://jeffblackadar.ca/captain_white_diary/page_images/td_00044_b2.jpg"

# Call API with URL and raw response (allows you to get the operation location). Call Azure using computervision_client with the URL.
read_response = computervision_client.read(read_image_url,  raw=True)
# </snippet_read_call>

# <snippet_read_response>
# Get the operation location (URL with an ID at the end) from the response
read_operation_location = read_response.headers["Operation-Location"]
# Grab the ID from the URL
operation_id = read_operation_location.split("/")[-1]

# Call the "GET" API and wait for it to retrieve the results
while True:
    read_result = computervision_client.get_read_result(operation_id)
    if read_result.status not in ['notStarted', 'running']:
        break
        time.sleep(1)

# Print the detected text, line by line
if read_result.status == OperationStatusCodes.succeeded:
    for text_result in read_result.analyze_result.read_results:
        for line in text_result.lines:
            print(line.text)
            print(line.bounding_box)
print()

# </snippet_read_response>

```

[^3]

2. This code will:
+ Set the url of the image to transcribe
```
read_image_url = "http://jeffblackadar.ca/captain_white_diary/page_images/td_00044_b2.jpg"
```

+ Call Azure using computervision_client with the URL.
```
read_response = computervision_client.read(read_image_url,  raw=True)
```

+ Read the results line by line
+ If successful, print the text of each line as well as the coordinates of a rectangle in the image where the text is located.



### 6. Transcribe handwriting in an image stored on your machine.

This section will allow you to transcribe handwriting of an image stored on your machine. It's a lot like the above section. You must have an image saved on your computer. For this example, you can download an image and save it. Here is an example image to download: http://jeffblackadar.ca/captain_white_diary/page_images/td_00044_b2.jpg.

1. Select or create a directory for your image. If you are working on Google Colab, the working directory /content/ may be used.
2. Download an example image and save it to the directory.
3. Create a new cell in your notebook, paste in the code block below.

```
images_folder = "/content/"

print("===== Read File - local =====")
# Set the path to the image
read_image_path = os.path.join (images_folder, "td_00044_b2.jpg")

# Open the image
read_image = open(read_image_path, "rb")


# Call API with image and raw response (allows you to get the operation location). Call Azure using computervision_client with the image.
read_response = computervision_client.read_in_stream(read_image, raw=True)

# Get the operation location (URL with ID as last appendage)
read_operation_location = read_response.headers["Operation-Location"]

# Take the ID off and use to get results
operation_id = read_operation_location.split("/")[-1]

# Call the "GET" API and wait for the retrieval of the results

while True:
    read_result = computervision_client.get_read_result(operation_id)
    if read_result.status.lower () not in ['notstarted', 'running']:
        break
        print ('Waiting for result...')
        time.sleep(10)

# Print results, line by line

if read_result.status == OperationStatusCodes.succeeded:
    for text_result in read_result.analyze_result.read_results:
        for line in text_result.lines:
            print(line.text)
            print(line.bounding_box)
print()
```

[^3]

4. The code will set the path to the image and read it. To do this:
+ Change the line images_folder = "/content/" to the folder you are using.

```
images_folder = "/content/"
```

+ Change "td_00044_b2.jpg" to the name of the file you are using.
```
# Set the path to the image
read_image_path = os.path.join (images_folder, "td_00044_b2.jpg")

# Open the image
read_image = open(read_image_path, "rb")
```

5. The code will also:
+ Call Azure using computervision_client with the image.

```
read_response = computervision_client.read_in_stream(read_image, raw=True)
```

+ Read the results line by line
+ If successful, print the text of each line as well as the coordinates of a rectangle in the image where the text is located.
6. Run the cell to read the handwriting in the image.



## Summary
You have connected to Azure Cognitive Services Computer Vision and transcribed the text of an image on a website and an image on your computer. With this code, you can add more steps to process multiple images and store the transcribed text in a file or database. Using the positions of the transcribe text, it is possible to transcribe written forms into structured data, like a spreadsheet.

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
