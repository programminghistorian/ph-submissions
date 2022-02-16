**Delete everything above this line when ready to submit your lesson**.

title: OCR with Google Vision API  
collection: lessons  
layout: lesson  
slug: LEAVE BLANK  
date: LEAVE BLANK  
translation_date: LEAVE BLANK  
authors: Isabelle Gribomont  
reviewers:
- LEAVE BLANK  

editors:  
- LEAVE BLANK  

translator:  
- FORENAME SURNAME 1  
- FORENAME SURNAME 2, etc   

translation-editor:  
- LEAVE BLANK  

translation-reviewer:  
- LEAVE BLANK  

original: LEAVE BLANK  
review-ticket: LEAVE BLANK  
difficulty: LEAVE BLANK  
activity: LEAVE BLANK  
topics: LEAVE BLANK  
abstract: LEAVE BLANK  
---

# A Table of Contents

{% include toc.html %}

--

# Introduction

Historians working with digital methods and text-based material are usually confronted to pdf files which need to be converted to plain text before further pre-processing steps and the analysis can begin. An accurate transcription is often paramount in the humanities, where we tend to work with a comparatively small amount of data. However, the [Optical Character Recognition](https://en.wikipedia.org/wiki/Optical_character_recognition) which transforms a pdf to a computer-readable file becomes trickier when dealing with historical fonts and characters, damaged manuscripts or low-quality scans. Fortunately, tools such as [Tesseract](https://github.com/tesseract-ocr/tesseract), [TRANSKRIBUS](https://transkribus.eu/), and [OCR-D](https://ocr-d.de/) (among others) have allowed humanities scholars to work with all kinds of documents, from handwritten ninetheenth century letters all the way to medieval manuscripts.

The purpose of this tutorial is to introduce [Google Cloud Vision](https://cloud.google.com/vision/) as another high-quality option and show how it can be integrated with Tesseract's layout detection tool for optimal results. In addition, it will outline the process of setting up a Google API account which can be used to access other useful Google APIs such as AutoML, Speech-to-Text API, Cloud Natural Language API and Cloud Translation API.

## The pros and cons of Google Vision

### Pros

* Accuracy: Although it has its limitations, Google Vision tends to be highly accurate, including in cases where other tools might struggle, i.e. when several languages coexist in the same text. It is probably the most accurate 'out-of-the-box' tool when it comes to character recognition.
* Versatility: The tool performs well accross a wide range of documents. Moreover, Google Vision offers other functionalities such as object detection in images and OCR for handwritten documents/images.
* User-friendliness: Once the setup is completed, it is easy to use. There is usually no need to develop and train your own model.
* Languages support: Google Vision fully supports 60 languages. In addition, 36 are under active development and 133 are mapped to another language code or a general character recogniser. Many indigenous, regional, and historial languages are among the latters. You can consult the full list of supported languages in the [Cloud Vision documentation](https://cloud.google.com/vision/docs/languages).

### Cons

* Cost: The service is only free for the first 1000 pages per month. After that, it costs USD 1.50 per 1000 pages. Prices in other currencies are available [here](https://cloud.google.com/skus/). In addition, billing information must be provided, even to access the free services.
* Google email address and Cloud storage: To sign in to the Google Cloud Platform, a Google email address is required and the pdf files must be uploaded to the Google Cloud Storage to be processed.
* Sustainability: Google Cloud is known for sunsetting tools. Altough Google now has a policy in place guaranteeing a year's notice before deprecating products, the potential instability of the Google Cloud Platform should be noted.

## Lesson goals

This tutorial will teach you how to create a Google Cloud project and use Google Vision to perform OCR on batches of pdf files. In addition, it will compare how Google Vision and Tesseract perform on three nineteenth century editions of medieval texts which feature Latin, Old English, and Modern English. Finally, it will propose a way to integrate Tesseract's layout detection feature with Google Vision.

# Preparation

## Suggested prerequisites

Although it is suitable for beginners, this lesson supposes some familiarity with the Python programming language. If you are not already familiar with Python 3, you will better understand the code used in this tutorial if you work through the [Python lesson series](https://programminghistorian.org/en/lessons/introduction-and-installation) first. These lessons will also teach you how to install Python 3 and download a text editor where to write your code. 


## Lesson dataset

You can use this tutorial with any pdf documents you would like to OCR. I suggest you use at least two documents since the lesson shows how to OCR several files at once. Place them in a directory named `docs_to_OCR`, for instance.\
\
You can also use the set of three nineteeth century editions of medieval documents which I will be using throughout this lesson. If you opt to do so, begin by [downloading the set of files](https://github.com/). Unzip it, rename it `docs_to_OCR`.\
\
These three documents are copyright-free and available on [archive.org](https://archive.org/).


## Google Cloud Platform setup

### Create a Google Cloud Project

Go to [https://console.cloud.google.com/](https://console.cloud.google.com/). On the side bar navigation menu, click on *IAM and Admin* and select *Create a project*. On the *New Project* page, pick a project name and click *CREATE*. The project will now appear on your Dashboard. Make sure that it is selected in the dropdown menu which appears next to the Google Cloud Platform banner at the top of your screen.

### Link your project to a billing account

To use the API, you will need to link the project to a billing account, even if you are only planning to use the free portion of the service. To do so, open the navigation menu again, select *Billing*, and create a new billing account by following the instructions. 

### Enable the Cloud Vision API

From the sidebar navigation menu, select *APIs and services* and then *Library*. Search for 'Cloud Vision API' in the search bar and click *Enable*.

### Create a Google Cloud Service Account

From the sidebar navigation menu, select *IAM & Admin*, then *Service Accounts*. Click *+ CREATE SERVICE ACCOUNT*. You will have to pick an account name and grant the service account access to your project. I suggest you pick 'Owner' in the role drop-down menu to grant full access.

### Download and save a service account key

You will see your new service account in the *Service Accounts* section of the *IAM & Admin* menu. To add a service account key, click on the three dots icon next to your service account and click *Manage keys*. Click *ADD KEY* and *Create new key*. Select 'JSON' as the key type, click *CREATE*, and the key will be automatically downloaded as a JSON file. Save the file in your working directory and rename it `ServiceAccountKey.json`.


### Upload data to Google Cloud Storage

In Cloud Storage, data are stored in 'buckets'. To create one, select *Google Storage* from the sidebar navigation menu and click *CREATE BUCKET*.  Pick a name for your bucket, select 'Multi-region' for the location type, and pick the region closest to you in the *Location* drop-down menu. Pick 'Standard' as the default storage class for your data and 'Uniform' for the access control. The cost of storing a GB of data (several thousand scanned pages) on Standard Storage is 0.02 USD per month. If you only keep your data in the bucket for 24 hours in a 30 day-month, this cost is divided by 30. In addition, new accounts usually come with free credit. Further information about Cloud Storage pricing can be found in the [documentation](https://cloud.google.com/storage/pricing).\
\
You can acesss your bucket by selecting *Google Storage* and *Browser* from the sidebar, and clicking on its name.\
\
You can upload folders by clicking *UPLOAD FOLDER* and navigating to the desired directory. However, in this tutorial, I will upload files to the bucket using Python to allow for a more streamlined workflow.

## Python setup


It is always best to create a new virtual environment when you start a Python project. This means that each project can have its own dependencies, regardless of what dependencies other projects need. To do so, you can use [conda](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) or [venv](https://docs.python.org/3/library/venv.html), for instance.

After activating your new environment, execute the following commands to install the Google Cloud libraries you will need.


If you are using conda, you should install pip beforehand:
```
conda install pip
```

If you prefer to write and run your code in a Jupyter Notebook, install Jupyter:

```
conda install -c anaconda jupyter
```

Install the Google Cloud libraries:
```
pip install google-cloud-vision
pip install google-cloud-storage
```

# The code

The code below adapts the code from the [Google Vision documentation](https://cloud.google.com/vision/docs/pdf) to work with batches instead of individual files and to save the full text outputs.\
\
Google Vision takes single files stored in Cloud Storage buckets as input. Therefore, the code iterates through a directory stored locally to upload the file in the Cloud Storage, request the full text annotation of the pdf, read the [JSON](https://en.wikipedia.org/wiki/JSON) output files stored in the Cloud Storage and save the full-text OCR reponses locally.\
\
To begin, you will need to import the libraries (`google-cloud-storage` and `google-cloude-vision`) that you installed in the Setup section, as well as the built-in libraries `os` and `json`.

```
import os
import json
import glob
from google.cloud import vision
from google.cloud import storage
```

Then, you will need to provide a local path for the pdfs to be OCRed and the name of your Google Cloud Storage bucket. Note that this is the only segment which you will need to edit when you re-use this code, if you use different local directories and a different storage bucket.


```
#Path of the directory where the files to be OCRed are located.
input_dir='PATH/TO/LOCAL/DIRECTORY/docs_to_OCR'

#Path of the directory where you will want the output text files to be stored.
output_dir='PATH/TO/LOCAL/DIRECTORY/OCRed_files'

#Name of your Google Cloud Storage Bucket
bucket_name='BUCKET-NAME'
```

You will also need to set the path of your JSON service account key.

```
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'PATH/TO/YOUR/ServiceAccountKey.json'
```

Then, you can create variables for the different processes needed in the code:

```
# Instantiate a client for the client libraries 'storage' and 'vision', and the services which you want to use, i.e. the DOCUMENT_TEXT_DETECTION of the ImageAnnotator service
storage_client = storage.Client()
vision_client = vision.ImageAnnotatorClient()
bucket = storage_client.get_bucket(bucket_name)
feature = vision.Feature(type_=vision.Feature.Type.DOCUMENT_TEXT_DETECTION)

#The number of pages which will be grouped in each json response file
batch_size = 2

#The file format used (the alternative is 'image/tiff' if you are working with .tiff image files instead of pdfs).
mime_type = 'application/pdf'
```

Finally, you will use a function to iterate through the documents in your `input_directory`. Each document is uploaded to your Google Cloud Storage bucket and the OCR annotation is requested according to the information specified above. Then, the full-text information is extracted from the JSON files and written in a plain text documents saved locally in your output directory.


```
def batch_OCR_local_dir(input_dir, output_dir):
    
    #If the output directory does not already exist, create it.
    if not os.path.exists(output_dir):
        os.mkdir(output_dir)
    
    #Iterate through filenames in local directory.
    for filename in os.listdir(input_dir):
        if filename.endswith('.pdf'):
            print(filename)
            #Create a remote path. The combination of os.path.basename and os.path.normath extracts the name of the last directory of the path, i.e. 'docs_to_OCR'. Using the full path would create many useless nested directories inside your bucket.
            remote_subdir= os.path.basename(os.path.normpath(input_dir))
            rel_remote_path = os.path.join(remote_subdir, filename)
            #Upload file to your Google Cloud Bucket as a blob. The term 'blob' stands for 'Binary Large Object' and is used for storing information.
            blob = bucket.blob(rel_remote_path)
            blob.upload_from_filename(os.path.join(input_dir, filename))

            #Remote path to the file.
            gcs_source_uri = os.path.join('gs://', bucket_name, rel_remote_path)

            #Input source and input configuration.
            gcs_source = vision.GcsSource(uri=gcs_source_uri)
            input_config = vision.InputConfig(gcs_source=gcs_source, mime_type=mime_type)

            #Path to the response JSON files in the Google Cloud Storage. In this case, the JSON files will be saved inside a subfolder of the Cloud version of the input_dir called 'json_output'.
            gcs_destination_uri = os.path.join('gs://', bucket_name, remote_subdir, 'json_output', filename[:30]+'_')

            #Output destination and output configuration.
            gcs_destination = vision.GcsDestination(uri=gcs_destination_uri)
            output_config = vision.OutputConfig(gcs_destination=gcs_destination, batch_size=batch_size)

            #Instantiate OCR annotation request.
            async_request = vision.AsyncAnnotateFileRequest(
            features=[feature], input_config=input_config, output_config=output_config)

            operation = vision_client.async_batch_annotate_files(requests=[async_request])
            operation.result(timeout=180)

            #Identify the 'prefix' of the response JSON files, i.e. their path and the beginning of their filename.
            prefix='/'.join(gcs_destination_uri.split('//')[1].split('/')[1:])

            #Use this prefix to extract the correct JSON response files from your bucket and store them as 'blobs' in a list.
            blob_list = list(bucket.list_blobs(prefix=prefix))

            #Order the list by length before sorting it alphabetically so that the text appears in the correct order in the output file (i.e. so that the first two items of the list are 'output-1-to-2.json' and 'output-2-to-3.json' instead 'output-1-to-2.json' and 'output-10-to-11.json', as produced by the default alphabetical order).
            blob_list = sorted(blob_list, key=lambda blob: len(blob.name))

            #Create an empty string to store the text.
            output = ''

            #For each JSON file, extract the full text annotations and add them to the output string.
            for blob in blob_list:
                print((blob.name).split('/')[-1:][0])
                json_string = blob.download_as_string()
                response=json.loads(json_string)
                full_text_response = response['responses']

                for text in full_text_response:
                    try:
                        annotation=text['fullTextAnnotation']
                        output+=annotation['text']
                    except:
                        pass


            #Create the path and name of the output file.
            output_file=os.path.join(output_dir, filename.split('.')[0]+'.txt')

            #Create a file and write the output string.
            f=open(output_file, 'x')
            f.write(output)
            f.close()


#execute the function.
batch_OCR_local_dir(input_dir, output_dir)

```

This code will take a little while to run. The `print` statements will allow you to monitor the progress.\
\
Once the code is done running, your new text files should be in your local output directory, ready for further pre-processing or analysis.

# JSON files ouputs


The above code extracts the full-text annotation from the JSON files, but these files contain much more information. You can consult or download them from the `json_output` subfolder in your storage bucket.

For each page, you will find the following information:

* language(s) detected
* width and height
* full text

For each block, paragraph, and word:

* language(s) detected
* coordinates of the bounding box which "frames" the relevant text

For each character:

* language detected
* coordinates of the bounding box which "frames" the character
* the "symbol" detected (i.e. the letter or punctuation sign itself)

Most of this information comes with a confidence score between 0 and 1.

To learn more about JSON and how to query JSON data with the command-line utility [jq](https://stedolan.github.io/jq/), consult the Programming Historian lesson [Reshaping JSON with jq](https://programminghistorian.org/en/lessons/json-and-jq).

You can also query JSON files stored in your bucket with Python. For instance, if you'd like to know which words have a low confidence score, and which language was detected for these words, you can try the following code block:

```
#This code only looks at the first two pages of 'JHS_1872_HenryIVandQueenJoanCanterburyCathedral.pdf', but you can of course iterate through all the JSON files.
#Get the data from your bucket as a blob.
page_1_2 = bucket.get_blob('docs_to_OCR/json_output/JHS_1872_HenryIVandQueenJoanCa_output-1-to-2.json')
#Read the blob content as byte.
json_string = page_1_2.download_as_string()
#Turn JSON enconded data into a Python object.
response=json.loads(json_string)

#Consecutive for loops to access the deeply-nested elements wanted.
for page in response['responses']:
    for block in page['fullTextAnnotation']['pages'][0]['blocks']:
        for paragraph in block['paragraphs']:
            for word in paragraph['words']:
                 
                #Condition:
                if word['confidence'] < 0.8:
                    #Since the JSON data provides characters one by one, you need to join them to create the word.
                    word_text = ''.join(symbol['text'] for symbol in word['symbols'])
                    #Discard non-alphabetic characters.
                    if word_text.isalpha():
                        #Not all words have a 'detectedLanguages' attribute. The 'try-except' structure allows you to take them into account.
                        try:
                            print(word_text, '\t', word['confidence'], '\tLanguage Code: ', word['property']['detectedLanguages'][0]['languageCode']) 
                        except:
                            print(word_text, '\t', word['confidence'])
```

Result:

```
full     0.78   Language Code:  en
A    0.11   Language Code:  en
BRIEF    0.72   Language Code:  en
BENRY    0.7    Language Code:  en
IV   0.76   Language Code:  en
a    0.46   Language Code:  en
And      0.77   Language Code:  en
he   0.77   Language Code:  en
sancta   0.79   Language Code:  la
præ      0.71   Language Code:  la
more     0.79   Language Code:  la
```

# Google Vision API vs. Tesseract

Tesseract is a highly effective open source text recognition software developed by Google. It supports over 110 languages including many non-Indo-European languages and writing systems. Contrary to Google Vision, Tesseract does not require any initial setup besides downloading the software. The following section compares the performances of Tesseract and Google Vision on the first two pages of each document. This comparison highlights the strengths and weaknesses of the two software, thereby providing clues as to which might perform best on your data.

## How to use Tesseract

Tesseract takes image files as input. If you have pdfs, you can transform them into tiff files with ImageMagick, for instance. The process is detailed in the Programming Historian lesson [OCR and Machine Translation](https://programminghistorian.org/en/lessons/OCR-and-Machine-Translation). Alternatively, you can use OCRmyPDF. This software is based on Tesseract but works with pdfs. More information can be found in the Programming Historian tutorial [Working with batches of pdf files](https://programminghistorian.org/en/lessons/working-with-batches-of-pdf-files). Both can be used from the [command line](https://en.wikipedia.org/wiki/Command-line_interface).

If you opt for the latter, you can use the following commands after navigating to the `docs_to_OCR` directory:

`ocrmypdf -l eng+lat --redo-ocr --sidecar JHS_1872_HenryIVandQueenJoanCanterburyCathedral.txt JHS_1872_HenryIVandQueenJoanCanterburyCathedral.pdf JHS_1872_HenryIVandQueenJoanCanterburyCathedral_ocr.pdf`

`ocrmypdf -l eng+lat --redo-ocr --sidecar SymeonisDunelmensis_1834_HistoriaDeRegibus.txt SymeonisDunelmensis_1834_HistoriaDeRegibus.pdf SymeonisDunelmensis_1834_HistoriaDeRegibus_ocr.pdf`

`ocrmypdf -l eng+enm --redo-ocr --sidecar Skeat_1881_StSwithunExhumation_MiddleEnglish.txt Skeat_1881_StSwithunExhumation_MiddleEnglish.pdf Skeat_1881_StSwithunExhumation_MiddleEnglish_ocr.pdf`

OCRmyPDF creates a new pdf file with an OCR overlay. If you are working with pdfs which already have a (presumably unsatisfactory) OCR overlay, the `redo-ocr` argument allows for a new one to be created by OCRmyPDF. The `sidecar` argument creates a sidecar file which contains the OCR text found by OCRmyPDF. An alternative to using the `sidecar` argument would be to use another program such as pdftotext to extract the embedded texts from the newly created pdf files. 


## Comparisons

### Example 1

{% include figure.html filename=ocr-with-google-vision1.png" caption="Figure 1: First two pages of \ "Tomb of King Henry IV in Canterbury Cathedral\ "" %}


| Google Vision | Tesseract | 
| --------- | --------- | 
| KING BENRY IV. IN THE CATHEDRAL OF CANTERBURY, AUGUST | KING HENRY IV. IN THE CATHEDRAL OF CANTERBURY, AUGUST |
|  |  |
| ** Clemens Maydestone, filius Thomæ Maydestone Armigeri, fuit  | * * Olemens Maydestone, filius Thoms Maydestone Armigeri, fuit |
|  |  |
| Trinitatis de Howndeslow. vescendi causâ; et cum in prandio sermocina- | Trinitatis de Howndeslow vescendi eaus&; et cum in prandio sermocina- |
|  |  |
| quod cum a Westmonasteriâ corpus ejus versus Cantuariam in paiva | quod eum a Westmonasterii corpus ejus versus Cantuariam in parva |
|             |                |  

In the above exemple, we can observe that, although Google Vision does not perform perfectly, it handles accents and ligatures better than Tesseract.


### Example 2

{% include figure.html filename="ocr-with-google-vision2.png" caption="Figure 2: First two pages of \ "Aelfric's Life of Saints\ "" %}

| Google Vision | Tesseract | 
| --------- | --------- | 
| Aelfries Lives of Saints, | Aelfrics Fives of Saints, |
|  |  |
| A Set of Sermons on Saints' Days formerly observed  | A Set of Sermons on Saints’ Days formerly observey  |
|  |  |
| BY N. TRÜBNER & CO., 57 AND 59 LUDGATE HILL. | BY N. TRUBNER & CO., 57 AND 59 LUDGATE HILL. |
|  |  |
| XXI. NATALE SANCTI SWYÐUNI, EPISCOPI. | 440 XXI. NATALE SANCTI SWYDUNI, EPISCOPI. |
|  |  |
| and eac da þe hrepodon þæs reafes ænigne dæl. | and eac Sa pe hrepodon pes reafes zenigne del . |
|  |  |
| se wæs þryttig geara mid his wife on clænnysse . | se wes pryttig geara mid his* wife on clennysse . 124 |
| 115. hrépodon. | 115. hrépodon. 118. pe (for se). |
| 118. bóc. 0. þæt (for þe). sette. |   |
|  |  |

Both Google Vision and Tesseract made mistakes with the Gothic font on the front page. Again, we notice that Google Vision performs better with diachritics, accents, ligatures, and historical characters. However, this example reveals Google Vision's weakness when it comes to layout. The line numbers do not appear at the end of their respective lines, but are grouped together in the middle of the text. Although the text of the footnotes is more exact with Google Vision than Tesseract, Google Vision introduces mistakes in the footnote numbering.

### Example 3

{% include figure.html filename="ocr-with-google-vision3.png" caption="Figure 3: First two pages of \ "Symeonis Dunelmensis - Historia Regum\ "" %}

| Google Vision | Tesseract | 
| --------- | --------- | 
|  | e |
|  | ^ eee « e e eee LIP ee, ee e e see ee, M ee. ° e |
|  | “oe, rer ses oe . . oa? ‘SI N . . ecc e 9 s.s. \| .  |
|  | e e * %ee eo e? e e @ 6 e e * e o6 e - ee e e |
|  | ee e e @®e e oO e e e 90 ecc 50 09 e ? o |
| SPORT) |  |
SHIBITED |  | 
ROBERC | |  
© |  |
درود و روی |  |
|  |  |
| Æthelbert rex Cantuariorum, post regnum | ZEthelbert rex Cantuariorum, post regnum |
|  |  |
| historiæ placet inserere, et gloriam sanctitatis eorum demon- | historiz€ placet inserere, et gloriam sanctitatis eorum demon- |
|  |  |
| • This heading is in red letters. | + This heading is in red letters. * Ecol. Hist., i., xiv. |
| Ecol. Hist., i., xiv. |  |
|  |  |


The first page of this document presented challenges for both OCR tools. Tesseract mistook the dotted font used to spell 'Stanford Library' for tiny letters and Google Vision unsuccessfully tried to OCR the inscription from the engraved medallion pictured. 
The rest of the text confirms the patterns observed in the previous examples. Google Vision handles ligatures well but struggles with complex layout and (footnote) numbering.


# 5. Combining Tesseract’s layout recognition and Google Vision’s character recognition


Both Tesseract and Google Vision have their strengths and weaknesses. In the context of this sample, Google Vision is more consistent with character recognition, especially when it comes to ligatures, diacritics, and historical characters. Tesseract deals better with the layout of the documents. 

To get the best of both worlds, a solution would be to use Tesseract's layout recognition tool, for instance via [tesserocr](https://pypi.org/project/tesserocr/), ahead of using Google Vision for the documents which have a complex layout. This is not as straightforward as it should be since Google Visison unfortunately does not allow the user to set a detection area using coordinates. Therefore, it is necessary to create a new pdf where each page is a text region identified by tesserocr. Of course, this will drastically increase the number of pages, which is an important factor when only the first 1000 pages per month can be processed for free.


To create these new pdfs sequenced by regions, two new packages are needed. First, [pdf2images](https://pypi.org/project/pdf2image/) converts pdfs to PIL image objects. Second, [tesserocr](https://pypi.org/project/tesserocr/) provides the coordinates of the different text regions. The installation processes for these two packages is straightforward but will depend on your operating system. Consult the links for more details. In both cases, using [conda](https://docs.conda.io/projects/conda/en/latest/) is the simplest way to install the packages.


```
#import packages
from pdf2image import convert_from_path
from tesserocr import PyTessBaseAPI


def batch_pdf_text_regions(input_dir_l, output_dir_l):
    
    #If the output directory does not already exist, create it.
    if not os.path.exists(output_dir_l):
            os.mkdir(output_dir_l)
            
    #Iterate through filenames in local directory.
    for filename in os.listdir(input_dir_l):
        if filename.endswith('.pdf'):
            print(filename)
            #Create a list of PIL image files where each page of the file is one element of the list.
            pages = convert_from_path(os.path.join(input_dir_l, filename))
            
            #Instantiate an empty list of images.
            lim=[]
            #Create a path where to store the output file.
            new_filepath=os.path.join(output_dir_l, filename)

            #For each page, a list called 'regions' is created. Each element of the list is a tuple containing the image of one of the regions and a dictionary containing the 4 coordinates of the region (the 'x' and 'y' coordinates of the top-left corner as well as the height and the width).
            #For each region of each page, a new image is created by cropping the page according to the fours coordinates of the region. Each image is saved to the list initiated above.
            for p in pages:
                with PyTessBaseAPI() as api:
                    api.SetImage(p)
                    regions = api.GetRegions()
                    for (im, box) in regions:
                        lim.append(p.crop((box['x'], box['y'], box['x']+box['w'], box['y']+box['h'])))

            #The list of images is saved to file as a pdf.
            lim[0].save(new_filepath, "PDF" ,resolution=100.0, save_all=True, append_images=lim[1:])

    return output_dir_l

```

Set the input and output folder and excecute the function

```

#Path of the directory where the files to be OCRed are located.
input_dir_l='PATH/TO/LOCAL/DIRECTORY/docs_to_OCR'

#Path of the directory where you will want the sequenced pdf files to be stored.
output_dir_l='PATH/TO/LOCAL/DIRECTORY/docs_to_OCR_layout'

#Path of the directory where you will want the output text files to be stored.
output_dir_l_ocr='PATH/TO/LOCAL/DIRECTORY/OCRed_files_layout'

```

Since you want to use Google Vision on the output folder of the region recognition function, you can embed the two functions as follows:

'''
batch_OCR_local_dir(batch_pdf_text_regions(input_dir_l, output_dir_l), output_dir_l_ocr)

'''

# 6. Conclusions

Sometimes, no single piece of software can yield the desired outcome. It is often necessary to combine different tools to make the most of them. This lesson combines Tesseract's layout recognition tool with Google Vision's text annotation feature to create an OCR workflow which will produce better results than Tesseract or Google Vision alone. If training your own OCR model or paying for a licensed tool is not an option, this versatile solution might be a cost-efficient answer to your OCR problems.


Please note that this workflow was designed in the context of the UKRI-funded project "The Human Remains: Digital Library of Mortuary Science & Investigation", led by Dr. Ruth Nugnent at the University of Liverpool.

