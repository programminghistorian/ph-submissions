---
title: "Annotate Customizable NER (or Beyond) Textual Datasets and Fine-Tune a BERT Classification Machine in Python"
slug: ner-bert-classification-machine
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Zhihui Zou
reviewers:
- Forename Surname
- Forename Surname
editors:
- Massimiliano Carloni
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/693
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

## Introduction

Language does not follow generalizable rules. The same term carries a different definition or connotation when said or written by two different narrators, since the two narrators might come from different cultural, geographical, social, or other contexts. This is why probabilistic approaches to language (the basis of language models today) should consider following a minimalist approach to language that focuses on each specific historical, social, cultural, or other contextual backgrounds of their narrators rather than collapsing the many unique language practices into general-purpose textual analysis or algorithms. 

Fine-tuning a domain-specific textual analysis programs is an approach toward this minimalist approach to language. Many existing lessons on textual analysis focus on one or a few steps during the lifecycle of textual analysis. However, creating a domain-specific textual analysis program requires the researcher to understand this lifecycle in its entirety, from data collection to building an output-generating algorithm. This lesson guides researchers through the main thresholds during this pipeline. It is aimed at readers who are developing textual analysis programs or algorithms that focus on corpora that they believe cannot be accurately analyzed using existing general-purpose programs (e.g., spaCy, Stanford NER, ChatGPT, or Claude). It also serves as a road map for digital humanists to understand the complexity, labor, and nuance behind building a textual analysis program.

Annotating corpora or datasets manually also allows researchers to perform a unique way of close reading and develop a stronger understanding of the research topic.

### Lesson Goals

Readers will:
- Create a customized textual data Named Entity Recognition annotation schema;
- Use the schema to manually annotate a corpus that the researcher has domain-specialty in;
- Train a BERT (Bidirectional Encoder Representations from Transformers) classification model in Python using the annotated corpus;
- Understand concepts like data resampling, hyperparameters, train/test sets, and other machine learning concepts. This lesson will introduce these concepts as they appear in the pipeline.

To illustrate the full lifecycle of domain-specific textual analysis, this lesson uses the technique of Named Entity Recognition as an example. Users can substitute other textual analysis techniques beside NER when using this lesson.

### The Case for Domain-Specific Programs and Models

The quality of a textual analysis program or algorithm depends on the quality of the training data. When a program pre-trained or fine-tuned on a corpus that is less related to the application context, the program performs less accurately.[^1] Researchers have been building domain-specific programs to achieve higher accuracies when working with texts that share particular historical or social contexts. For example, MacBERTh, a BERT-based program pre-trained on English literature between 1450 and 1950, addresses the gap that programs trained on contemporary texts cannot accurately research historical language usage.[^2]

The range of “domain” varies greatly from research to research. Existing DH research often divides “domain” along national, gender, ethnic, temporal, or geographic lines.[^3] These are not the only domains. Depending on a researcher’s focus, domain could also be the format or medium of the corpus (e.g., a corpus of only novels, poetry, letters, or short stories), the situation of text production (e.g., a corpus of news reports that focus on one event), or others.

### Prerequisites

This lesson requires a basic Python technical understanding and access to a coding environment (either local- or cloud-based) to run the required Python code via Jupyter Notebook. Some options include [Google Colab](https://colab.research.google.com/) (for cloud) and VSCode (for local). Readers will also benefit from a fundamental understanding of textual analysis, [Named Entity Recognition](https://programminghistorian.org/en/lessons/finding-places-world-historical-gazetteer#65-named-entity-recognition), and Natural Language Processing. No prior machine learning knowledge is needed.

Since this lesson focuses on building a domain-specific program, users should have domain knowledge in the domain that they apply this lesson to.

Graphic Processing Units (GPU) is not required but recommended.

### Sample Dataset and Sample Research Question

To showcase the manual annotation and fine-tuning pipeline, this lesson will use a sample text with a sample research question. Readers should substitute the text with their own research corpus and their own research question. This lesson will indicate where readers should substitute their own research components into the pipeline.

This lesson uses “Bartleby, The Scrivener” (1853) by Herman Melville (accessed via Project Gutenberg) as the sample corpus and the sample question “How does Melville use non-named entities differently than named entities in conveying ‘space’ in his short stories?” This sample question defines “non-named entities” (NNE) as words or terms that are not proper nouns while “named entities” (NE) as proper nouns or titles.[^4]


## Steps in the Pipeline

### Step 1: Creating Data Annotation Schema

This step requires the researchers’ domain specialty the most. The lesson’s sample question designated that the domain for this research is spatial history and analysis.

Many NLP research creates their own data schema or borrow the schema from an existing project related to their work.[^5] Data schema refers to how the researcher categorizes words and terms. One common NER schema is spaCy’s NER feature. Its English language `en_core_web_md` model contains the categories `CARDINAL`, `DATE`, `EVENT`, `FAC`,` GPE`, `LANGUAGE`, `LAW`, `LOC`, `MONEY`, `NORP`, `ORDINAL`, `ORG`, `PERCENT`, `PERSON`, `PRODUCT`, `QUANTITY`, `TIME`, and WO`RK_OF_ART.[^6] spaCy is a powerful yet general-use NER tool, not the most suitable for domain-specific tasks.

Whether to create a customized data schema depends on your research question, availability of existing research, and the discipline that you operate in. When creating your own customized data schema, it might feel slightly uncomfortable at first, since the researcher might think that they are attempting to predict what words or terms they might find. Two ways to mitigate this is to have domain specialty and to adopt an iterative process, where the researcher performs close-reading on parts of their corpus (if the full corpus is too large to close read fully), create a preliminary data schema, and revise the schema as the researcher close-reads more of the corpus and conduct more research on the topic via secondary or other primary sources. As an iterative process, it is very likely that, as you advance onto the following steps in this lesson, you might encounter information that would cause you to revisit this step to edit your data schema.

If you work in a lively discipline, you might be able to find other researchers who have already created a customized data schema that you can borrow.

In the context of our sample research question, a question about spatial history, we will borrow the spatial NNE schema from Daniel Kababgi et al.’s research, which contains four categories: interior, urban, rural, and natural.[^7]

After determining the data schema, the researcher should create an operational definition for each category. This is because although some category names might be common terms (like “interior”), but when used in the context of your research, they carry specific meaning, connotation, or historical/cultural context that you have now provided for it. If you publish or share your work with others in the future, make sure to include your list of operational definitions with your work.

### Step 2: Creating Corpus

This step creates the machine-friendly text files for your corpus. Depending on the popularity of your research topic, there might be existing databases or organizations that provide structured text files. For instance, [Early English Books Online](https://proquest.libguides.com/eebopqp) (EEBO) is a repository for Early Modern English texts stored in XML and TXT formats. [Project Gutenberg](https://www.gutenberg.org/) also provides cleaned TXTs.

This lesson uses TXT to store raw corpus content. Researchers should store all TXTs in one directory, where each unit of text (e.g., novel, short story, essay, etc., as defined by your research) has its own dedicated TXT file. Make sure to name your TXT file(s) in a meaningful way. If you have multiple TXTs, store them within one directory.

The method of creating these TXT files varies greatly, depending on where your source text comes from. Researchers working on printed or handwritten materials might need an extra character recognition step, which [Isabelle Gribomont](https://programminghistorian.org/en/lessons/ocr-with-google-vision-and-tesseract)'s and [Jeff Blackadar](https://programminghistorian.org/en/lessons/transcribing-handwritten-text-with-python-and-azure)'s lessons cover. You might also need to clean your TXT files after creating them. The extent of your cleaning task varies greatly as well. Visit [Laura Turner O’Hara](https://programminghistorian.org/en/lessons/cleaning-ocrd-text-with-regular-expressions)'s lesson or the [“Cleaning the Corpus”](https://programminghistorian.org/en/lessons/understanding-creating-word-embeddings#cleaning-the-corpus) section in Avery Blankenship, Sarah Connell, and Quinn Dombrowski’s lesson for text cleaning guides.

This lesson uses the plain text TXT file from Project Gutenberg. Thus, our cleaning task is in removing the Project Gutenberg header and footer texts, which are before the line:

`*** START OF THE PROJECT GUTENBERG…`

and after the line:

`*** END OF THE PROJECT GUTENBERG…`

Using coded programs to clean texts is only necessary if there are significant or numerous repetitive cleaning tasks. In cases where cleaning tasks are manageable, researchers can simply manually read the TXT file and make the relevant fixes ourselves.

### Step 3: Doccano Setup

Manual annotation is key to ensure data quality, which in return upholds the quality of a fine-tuned language model. This step might feel tedious, but there are invaluable benefits. One is that the annotator is the domain expert. Manual annotation is also another way to close-read the source text from a different perspective, as the annotator-cum-researcher can reflect on the customized data schema while annotating (thus serving the iterative process mentioned in Step 1).

There are numerous text annotation tools. This lesson uses [Doccano](https://doccano.github.io/doccano/), an open-source data annotator that runs on your local server. There are three ways to run Doccano: pip, Docker, and Docker Compose. This lesson uses pip and Python 3.11. The newest Python version is 3.14, but 3.14 has some dependency issues with certain libraries that Doccano uses.

Running Doccano in a Python virtual environment helps with dependency management. To create a Python virtual environment, open a terminal window and type:

```python3.11 -m venv doccano```

`doccano` will be the name of this virtual environment that we will run Doccano in. You can name the virtual environment with another name by replacing `doccano` in the aforementioned command line.

Then, activate our virtual environment with the command:

```source doccano/bin/activate```

You should see `(doccano)` before your command line prompt. This shows that we are currently in the virtual environment. Whenever you need to exit your virtual environment, use:

`deactivate`

To install Doccano in your virtual environment, type: 

`pip install doccano`[^8]

The required storage space during annotation depends on the size of your corpus, but you should prepare at least 600MB of storage to create a virtual environment and install Doccano.

After installing Doccano, you need to run these two commands in this order:

```
doccano init
doccano createuser
```

The command `createuser` builds a default user login credentials with the username as `admin` and password as `password`. We will use this information in the next step.

Doccano supports [collaboration](https://doccano.github.io/doccano/tutorial/#add-members) between multiple users. This lesson only covers using Doccano independently.

### Step 4: Navigating Doccano Web Server and Project Page

To initiate Doccano’s local web server, use the command line:

```doccano webserver```

You can now open a web browser and visit the link: [http://localhost:8000/](http://localhost:8000/) to use your local Doccano web server.[^9] Doccano supports Google Chrome and Apple Safari browsers.

In a separate terminal window (leave `doccano webserver` running in your current terminal window), enter your Doccano virtual environment and run the command:

```doccano task```

This command handles file upload and download while we use the Doccano web server.

After typing the `webserver` and `task` commands, your two terminal windows should show that the two commands are continuously running. They need to be running continuously while you perform tasks in your Doccano web server. Whenever you want to end your task, type `Control + C` or simply close your terminal windows.[^10]

At your localhost web address, you should see the Doccano home screen like this:

{% include figure.html filename="ner-bert-classification-machine-01.png" alt="Doccano homepage" caption="Figure 1. Caption text to display." %}

Navigate to the top right corner of the screen and click on `LOGIN`, using the credentials in Step 3.

After logging in, you should see a list of your Doccano projects (which should be none, if you haven not used Doccano before). Click on the blue “Create” button on the top left corner to create a new project.

{% include figure.html filename="ner-bert-classification-machine-02.png" alt="Clicking on Create button" caption="Figure 2. Caption text to display." %}

The screen should now prompt you to fill in the `Project Name` and `Description`. Use meaningful names and descriptions for your project so that you can easily identify your work in the future. Check the `Allow overlapping spans` checkbox.

{% include figure.html filename="ner-bert-classification-machine-03.png" alt="Filling in information to create a project" caption="Figure 3. Caption text to display." %}

Click `Create`.

### Step 5: Import Data to Doccano and Create Labels

**Import Data**

After creating a Doccano project, the webpage will ask you to import data. The “Home” tab on the left of the screen provides video tutorials on the various Doccano functionalities.

{% include figure.html filename="ner-bert-classification-machine-04.png" alt="Showing the Home tab" caption="Figure 4. Caption text to display." %}

Navigate to `Dataset` tab, click on `Actions`, and select `Import Dataset` from the dropdown list.

{% include figure.html filename="ner-bert-classification-machine-05.png" alt="Selecting button to import dataset" caption="Figure 5. Caption text to display." %}

The webpage will then prompt you to select “File format” and “Encoding.” Select “TextFile” (for TXT) for file format. The default encoding is “utf-8,” which should fit most people’s needs.
Then, drop your TXT file(s) to the grey box below and click “Import.”

{% include figure.html filename="ner-bert-classification-machine-06.png" alt="Import TXT files" caption="Figure 6. Caption text to display." %}

You should now see a preview of your uploaded TXT on your “Dataset” screen.

**Create Labels**

We will now load our customized data schema into Doccano. Navigate to the `Labels` tab, click on `Actions`, and select `Create label` from the dropdown list.

{% include figure.html filename="ner-bert-classification-machine-07.png" alt="Selecting the button to create new labels" caption="Figure 7. Caption text to display." %}

You can now enter the customized NER data schema one by one into the `Label name` field. To add multiple schema categories, click on `Save and add another` after adding one schema category.

After entering all your schema categories, you can see and edit your categories at the `Labels` tab screen.

{% include figure.html filename="ner-bert-classification-machine-08.png" alt="View the created labels" caption="Figure 8. Caption text to display." %}

### Step 6: Data Annotation

After loading your customized data schema into Doccano, you can visit the `Dataset` tab to see your TXT file(s) and begin annotating by clicking on “Annotate” under the `Action` column. This will open the TXT file for you to examine. To annotate, highlight a word or term. This will show a dropdown list containing your existing data schema categories. Select a category that matches with the context, meaning, or usage of your highlighted phrase.

Labels will appear beneath the annotated text.

{% include figure.html filename="ner-bert-classification-machine-09.png" alt="Annotated corpus text" caption="Figure 9. Caption text to display." %}

Repeat this step if you have numerous TXT files to annotate.

Note that, as mentioned in Step 1, as you annotate more texts, you might encounter scenarios where your current data schema has certain shortcomings, such as failing to consider a type of linguistic usage, historical context, narrative structure, etc. This is one opportunity to consistently and iteratively engage with your data schema and revise it as needed. On the other hand, language is complex and highly variable; no data schema can consider all types of usage (in the context of this lesson, all types of spatial portrayal in fiction). The researcher, based on their domain specialty, research question, and research findings, must decide which scenarios warrant editing the data schema and operational definitions for the schema categories and which do not.

### Step 7: Data Export and Preparation for Fine-Tuning

First, create a directory and give it a meaningful name. This folder will hold all files for the rest of the lesson so that you can store the dataset(s), code file(s), and fine-tuned models in one place.

After annotating all your TXT files, you can export the data via a JSONL file by visiting the `Dataset` tab, clicking on `Actions`, and selecting `Export Dataset`. The screen will then present a sample overview of the data structure of the JSONL file that you will download. Clicking on `Export` will download a Zip file that contains your JSONL file. Depending on the security features on your machine or browser, the downloading processing might be interrupted because your machine or browser might think it is an insecure file. If this happens, you can navigate to your browser’s `Download`  icon and manually permit file download. For example, for Google Chrome browser, you ned to click on `Keep` for the downloading file:

{% include figure.html filename="ner-bert-classification-machine-10.png" alt="Allow download after machine or browser blocked its download" caption="Figure 10. Caption text to display." %}

After downloading the Zip file, unzip it and store the JSONL file that it contains in the directory that you have just created. If you are coding in Google Colab, you can upload the JSONL file to your Colab work environment.

JSONL stands for JSON Lines, a way to collect multiple JSON objects into one file. Each line in a JSONL file is one JSON object. For Doccano’s data export function, each line represents one TXT file being annotated and the annotations that you have created in Step 6.

Each JSON object (which resemble a Python dictionary data type) in the downloaded JSONL file has four keys: `id`, `text`, `label`, `Comments`.

| key | data type | description |
| ------- | ------- | ------- |
| `id` | int | counter of the number of this specific TXT file in your entire dataset |
| `text` | str | the raw text of this TXT file that you uploaded |
| `label` | list | contains the specific phrases that you annotated, their locations in your text, and the category. This is a list of lists, where each inner list represents one annotation. Each inner list contains three elements: start index position of the annotated text in the raw text (int), end index position of the annotated text in the raw text (int), and the data schema category that you assigned it (str). Example: [[startIndex, endIndex, “labelCategory”], [startIndex, endIndex, “labelCategory”], …] |
| `Comments` | list | comments that you provided during your annotation process. Blank if you did not provide any comments. This lesson does not use this Deccano feature |

**File Check**

We will now use one Jupyter Notebook file to contain the remaining code.

Create a Jupyter Notebook file (.ipynb) in the same directory (either local or a cloud coding environment that you are using) as your JSONL data file. Quinn Dombrowski, Tassie Gniady, and David Kloster’s [lesson](https://programminghistorian.org/en/lessons/jupyter-notebooks) provides an introduction to Jupyter Notebook.

To check whether your downloaded JSONL file contains the correct information, run this following code:

```
import json

with open("admin.jsonl") as annotationFile:
    # iterate through each JSON object (which is one file)
    for oneJSONObject in annotationFile:
        # load each JSON object
        oneAnnotatedFileDict = json.loads(oneJSONObject)

        # preview the first 100 characters of each text file
        previewText = oneAnnotatedFileDict["text"][:100].replace("\n", " ") + "..."

        # print the file number, text preview, and the first 5 annotations that you made
        print("FILE NO.:\n", oneAnnotatedFileDict["id"])
        print("TEXT PREVIEW:\n", previewText)
        print("ANNOTATION PREVIEW:\n", oneAnnotatedFileDict["label"][:5], "\n\n")
```

You should print out a brief preview of each of your TXT files and the first five of your annotations for each. If no error occurs and that the printout looks correct, your training data should be ready for fine-tuning.

**Storing JSON Objects as Dictionary**

For easier data access later on, we will store all JSON objects into one list via this code:

```
# we will refer to this variable later in the lesson when accessing our raw text and annotation
mainAnnotationStorageList = []

with open("admin.jsonl") as annotationFile:
    for oneJSONObject in annotationFile:
        oneAnnotatedFileDict = json.loads(oneJSONObject)
        mainAnnotationStorageList.append(oneAnnotatedFileDict)

# double checking that we did this correctly:
print(f"Stored {len(mainAnnotationStorageList)} files.")
# this should print out the same number as the number of files that you have annotated
```

**Installing Libraries**

We will need the PyTorch, numpy, scikit-learn, transformers, datasets, evaluate, and seqeval libraries. In a code cell in the Jupyter Notebook, run:

```
!pip install torch numpy scikit-learn transformers datasets evaluate seqeval
```
This step might take a few minutes.

### Step 8: Understanding Our Training Data

Before model fine-tuning or training, it is always a good practice to understand your data at a larger scale, as this understanding will influence architectural decisions in the model fine-tuning process later in this lesson.

For a word classification task like this lesson, it is helpful to understand our training data cumulatively.

```
mainTrainingDataLabelCounterDict = {} # count how many annotations each of your categories has 
totalTrainingDataWordCounterInt = 0 # count how many words your corpus has
numOfLabeledWordsInt = 0

for oneFileDict in mainAnnotationStorageList:
    oneFileTextStr = oneFileDict["text"]
    totalTrainingDataWordCounterInt += len(oneFileTextStr.split())
    for oneLabelList in oneFileDict["label"]:
        startLabelIndexInt = oneLabelList[0]
        endLabelIndexInt = oneLabelList[1]
        labelNameStr = oneLabelList[2] # a reminder that the data structure is [startIndex, endIndex, "labelName"]
        if labelNameStr not in mainTrainingDataLabelCounterDict:
            mainTrainingDataLabelCounterDict[labelNameStr] = 0
        mainTrainingDataLabelCounterDict[labelNameStr] += 1
        numOfLabeledWordsInt += len(oneFileTextStr[startLabelIndexInt:endLabelIndexInt].split())

print(f"Data points that each schema category has: {mainTrainingDataLabelCounterDict}")
print(f"Corpus has {totalTrainingDataWordCounterInt} words in total")
print(f"{numOfLabeledWordsInt} out of {totalTrainingDataWordCounterInt} words({(numOfLabeledWordsInt/totalTrainingDataWordCounterInt)*100:.2f}%) are non-named entities")
```

This step will reveal whether there is an imbalance of data annotations (e.g., one NER label having much more data points than others. If such a situation exists, we can mitigate this by either annotating more texts or using data resampling (introduced later).

Keep the printed information in mind going forward. A reminder that many choices going forward will be architectural choices that vary from research to research, so this lesson can only provide general guidance and choices made in the context of this lesson’s sample research question. The specific decisions for your situation depends on your familiarity of your domain, corpus, and what questions your research domain seeks to answer.

### Step 9: BIO Format

BIO stands for Beginning-Inside-Outside format (sometimes referred to as IOB). Because BERT, and many other transformers, use subword tokens, each entity that we labeled might be tokenized into multiple tokens. The BIO format identifies which tokens belong to the same entity annotation. For example:

Manual data labeling might categorize “A two-bedroom urban apartment” as an `urban` entity. BIO format converts the tokenized text to:

| token | label |
| --- | --- |
| [CLS] | ignored |
| A | O |
| two | B-Urban |
| - | I-Urban |
| Bedroom | I-Urban |
| Urban | I-Urban |
| Apartment | I-Urban |
| [SEP] | ignored |

`O` refers to an unlabeled token, or the “Outside” in BIO. [CLS] and [SEP] are special tokens used in transformer models, where [CLS] represents the beginning of a classification task and [SEP] refers to the end of a segment.

To rewrite our labeled data according to the BIO format, we will create a dictionary that maps each label to a numerical value. The number of new labels you should have is `2n + 1`, where `n` is the number of labels that you have customized for your research. Each existing label will now have a Beginning and an Inside version. For this lesson’s sample research, we will write this dictionary in our Jupyter Notebook:

```
bioLabelToNumberDict = {
    "B-interior": 0,
    "I-interior": 1,
    "B-urban": 2,
    "I-urban": 3,
    "B-rural": 4,
    "I-rural": 5,
    "B-natural": 6,
    "I-natural": 7,
    "O": 8
}

numberToBioLabelDict = {num: label for label, num in bioLabelToNumberDict.items()}

```

Substitute each B and I labels with your own labels.

Then, we will reformat our existing dataset (stored in the variable mainAnnotationStorageList
) into this format. We will use BERT’s tokenizer during this step. Since BERT has a 512-token limit, and that most short stories have more than 512 tokens, this lesson implements a sliding window during this process.

```
import transformers
tokenizer = transformers.BertTokenizerFast.from_pretrained("bert-base-cased")

def turnLabeledDataIntoBioFormat(corpusTextStr, labelsList, tokenzier, labelIDDict, windowLength=512, overlap=30):
    encoding = tokenizer(corpusTextStr, return_offsets_mapping=True, truncation=True, max_length = windowLength, stride=overlap, return_overflowing_tokens=True, padding="max_length")

    # splitting each element in the tokenizer return value into their own variables. Each inner list is one window of 512 tokens
    totalInputIDsList = encoding["input_ids"] # this contains input ids. We will use this for training
    totalAttentionMaskList = encoding["attention_mask"] # this contains attention mask. Will use this for training, too
    totalTokenTypeIDsList = encoding["token_type_ids"] # defaults to all zeros in our case. needed for BERT's format
    totalOffsetMappingList = encoding["offset_mapping"] # this contains the location for each token in the text in the format of a (startIndex, endIndex) tuple

    windowsList = [] # our return list that we will append things to

    # iterate through each window and assign the actual labels to them.
    for windowIndex in range(len(totalInputIDsList)):
        offsetMapList = totalOffsetMappingList[windowIndex]
        tokensAsWordsList = tokenizer.convert_ids_to_tokens(totalInputIDsList[windowIndex]) # for debugging checks
        numberOfTokensInt = len(tokensAsWordsList)

        # first set everything to the "Outside" label in BIO as default
        tokenNumericalLabelsList = [labelIDDict["O"]] * numberOfTokensInt

        # usually, special tokens, like [CLS], are set to -100
        for index, (startIndex, endIndex) in enumerate(offsetMapList):
            if startIndex == 0 and endIndex == 0:
                tokenNumericalLabelsList[index] = -100

        # assign BIO labels by iterating through our list of manual labels
        for startAnnotatedtextIndexInt, endAnnotatedtextIndexInt, labelStr in labelsList:
            beginningLabelStr = f"B-{labelStr}"
            innerLabelStr = f"I-{labelStr}"

            beginningTokenBool = True

            for tokenIndex, (startOneTokenInAnnotatedTextIndexInt, endOneTokenInAnnotatedTextIndexInt) in enumerate(offsetMapList):
                
                if startOneTokenInAnnotatedTextIndexInt == 0 and endOneTokenInAnnotatedTextIndexInt == 0:
                    continue # these are the special tokens

                if startOneTokenInAnnotatedTextIndexInt < endAnnotatedtextIndexInt and endOneTokenInAnnotatedTextIndexInt > startAnnotatedtextIndexInt:
                    if beginningTokenBool:
                        tokenNumericalLabelsList[tokenIndex] = labelIDDict[beginningLabelStr]
                        beginningTokenBool = False
                    else:
                        tokenNumericalLabelsList[tokenIndex] = labelIDDict[innerLabelStr]
        windowsList.append({"inputIDs": totalInputIDsList[windowIndex], "attentionMask": totalAttentionMaskList[windowIndex], "tokenTypeIDs": totalTokenTypeIDsList[windowIndex], "labels": tokenNumericalLabelsList})

    return windowsList
```

We will now use this function to process all of our datasets in `mainAnnotationStorageList`:

```
totalProcessedAnnotationDataList = []
for oneAnnotatedText in mainAnnotationStorageList:
    processedDataForOneText = turnLabeledDataIntoBioFormat(oneAnnotatedText["text"], oneAnnotatedText["label"], tokenizer, bioLabelToNumberDict)
    totalProcessedAnnotationDataList.extend(processedDataForOneText) # note that we are not using .append() but using .extend() because the final dataset should be in one list, not separated into list of lists
```

### Step 10: Training/Validation/Testing Dataset Split

A good model fine-tuning process contains testing and validation data along with training data. The three are separated from the existing pool of data points we have. After fine-tuning the NER model, we will run the tuned model against the testing data to evaluate our model’s performance.[^11] During training, we use a validation dataset to evaluate the behavior and hyperparameters of the model. Validation data does not influence the model’s learning or weights but is important to prevent model overfitting.

| Type | Description|
| --- | --- |
| Training data | data the model uses to train and update its weights |
| Validation data | data the model uses during the training process to evaluate its performance |
| Testing data | data the model does not see during training and is used to calculate model performance |

However, splitting data into training, validation, and testing sets is most helpful on data that have more structured data outputs (e.g., labeling whether an email is spam or not: one Boolean response for one unit of text). For our context, non-named NER recognition (and text classification at large) are highly subjective and often does not have a universal “true” label (hence the need for domain-specific models and research). Meaning, two data labels might be slightly different in syntax but, depending on the research question, similar enough to count both as correct labels. For example, in non-named NER recognition, a sentence might include the phrase “a small private bedroom.” The test data might label this as `[“bedroom”: Interior]`. However, if the fine-tuned model labels `[“private bedroom”: Interior]`, it would be considered as an erroneous label, despite that it could still be considered as a good (or good enough) label. In other words, using a strict training/testing dataset split might make the fine-tuned model perform worse than it is. Another drawback with training/testing dataset split for the context of this lesson is that the researcher needs a large enough dataset, which might be time-consuming to produce via manual data annotation. The benefit is that we have a quantitative evaluation of the model.

If you believe your research domain has large variability (and maybe that you do not have enough labeled data to afford splitting some just for testing), we can use all labeled data as training and validation data and test our trained model by manually observing the performance of our model on unseen text. The benefit of this approach is that we can dedicate more data on training and that we as researchers can more flexibly evaluable the model using our domain speciality. The tradeoff is that our model evaluation will be qualitative (in other words, “eye-balling” the performance level of the fine-tuned model when applied on unseen texts).

If you believe that you do not have enough data to even split between data and validation, you could theoretically use all data for training.

The choice between whether creating a testing or creating both testing and validation data sets depends on your research context, question, and data availability. Because of the size of the sample data, this lesson will only create training and validation sets data and manually test the model after training. If you prefer the former, you can use Scikit-Learn’s [train_test_split()](https://scikit-learn.org/stable/modules/generated/sklearn.model_selection.train_test_split.html) method. Two training/validation/testing data ratios are 70/15/15 and 60/30/10. There is no one universal ratio.

This lesson will use a 80/20 split between training and validation set:
```
import sklearn

trainingDataList, validationDataList = sklearn.model_selection.train_test_split(totalProcessedAnnotationDataList, test_size=0.2, random_state=2) # the "test_size" default parameter controls the percentage of data that becomes testing data. For this lesson, we will view "test_size" as the size of the validation data
```

### Step 11: Data Resampling

As mentioned in Step 8, there will be times where we have an imbalanced dataset. For example, we have 400 data for one NER category but only 20 for another. This would cause our fine-tuned model to behave more favorably toward the majority data categories and overlook the minority ones.

In NER, the `O` category is often heavily overrepresented, since most words in literature are not named entities or even non-named entities. You can review your data from Step 8 to see whether there is a data imbalance.

To address this issue, we will use data resampling, which is a technique that overrepresents minority data or underrepresents majority data so that the final training data is more balanced. Do not perform data resampling on the validation and testing datasets. Upsampling and downsampling are two common ways of data resampling. Another way to address data imbalance is class reweighing, which changes the model weights, thus penalizing each category differently during training. This lesson will cover upsampling and downsampling.

Upsampling increases the number of occurrence of minority data according to a scale, and downsampling reduces the occurrence of majority data according to a scale. Determining the scale is an architectural choice that depends on your specific dataset.

We can review our data spread again at this point after performing training/validation/testing split:
```
labelCounterDict = {}
for oneDataPoint in trainingDataList:
    for oneLabel in oneDataPoint["labels"]:
        if oneLabel == -100:
            continue
        if numberToBioLabelDict[oneLabel] not in labelCounterDict:
            labelCounterDict[numberToBioLabelDict[oneLabel]] = 0
        labelCounterDict[numberToBioLabelDict[oneLabel]] += 1

print(labelCounterDict)
```

For this lesson’s sample data, the data spread is:

```
{'O': 60840, 'B-rural': 3, 'I-rural': 3, 'B-urban': 11, 'I-urban': 14, 'B-interior': 23, 'B-natural': 2, 'I-natural': 12, 'I-interior': 16}
```

This means that we have a heavy `O` overrepresentation and `B-rural`, `I-rural`, and `B-natural` underrepresentation. Note that this step is also helpful to get an idea of what type of language usage is more or less often in your corpus.

To address this, we will perform downsampling on `O` and upsampling on “`B-rural`, `I-rural`, and `B-natural` so that they are at a similar representation as the rest of the non-`O` categories.
```
#step 11 cont. data resampling
import random

def resampleTrainingData(trainingDataList, labelIDDict):
    random.seed(20)

    resampledFinalTrainingDataList = trainingDataList[:] # make a copy of the original training data list before upsampling 

    # for upsampling
    labelsToUpsampleSet = {labelIDDict["B-natural"], labelIDDict["I-natural"], labelIDDict["B-rural"], labelIDDict["I-rural"]} # replace each string with your own categories that are in the minorities. For example, if, in your data schema, you have a category called "spiritualWords" that is a minority category, you should have {labelIDDict["B-spiritualWords"], labelIDDict["I-spiritualWords"]} as "labelsToUpsampleSet". This set collects the label IDs in the "bioLabelToNumberDict" dictionary so we know which ones to upsample.

    dataToUpsampleList = []
    for oneDatapoint in trainingDataList:
        for oneLabel in oneDatapoint["labels"]:
            if oneLabel in labelsToUpsampleSet:
                dataToUpsampleList.append(oneDatapoint)
                break
    
    # if you want to upsample a few data points using a different ratio, you can uncomment the code block below. You will very likely need to do this step, since the code shown above assumes that we are upsampling all minority data categories according to the same ratio

    '''
    labelsToUpsampleSetTwo = {labelIDDict["B-rural"], labelIDDict["I-rural"]} # say that you want to upsample the "rural" label by a ratio different from what you passed in for "upsampleRatio" parameter, you can put the two "rural" categories here. If you do this, make sure that "rural" categories are not in the "resampledFinalTrainingDataList" set above

        twoLabelToUpsampleList = []
        for oneDatapoint in trainingDataList:
            for oneLabel in oneDatapoint["labels"]:
                if oneLabel in labelsToUpsampleSetTwo:
                    twoLabelToUpsampleList.append(oneDatapoint)
                    break
    '''
    # if you need more than 2 individualized upsampling, just copy and paste the above block. Make sure to rename the "labelsToUpsampleSetTwo" and "labelsToUpsampleSetTwo" to other names.

    

    resampledFinalTrainingDataList += dataToUpsampleList * 5 # this multiplies the number of minority data points by the value "upsampleRatio". Change this number according to the condition of your dataset. This number should be above 1

    # if you chose to upsample a label by another ratio, make sure to add them to the final training data list:

    '''
    resampledFinalTrainingDataList += twoLabelToUpsampleList * twoeUpsampelRatio # replace "oneUpsampelRatio" with another ratio of your choosing. Add more of these lines as you add more upsampling code blocks. This number should be above 1. 
    '''

    # now for downsampling

    labelsToDownsampleSet = {labelIDDict["O"]}  # replace each string with your own categories that are in the majoriies. In NER, usually the "Outside" category, or the category that is not labeled with any NER data category, is heavily in the majority
    NERLabelIDsOnly = set(labelIDDict.values()) - {labelIDDict["O"]}

    dataWithOnlyDownsampleIDs = []
    for oneDatapoint in resampledFinalTrainingDataList:
        dataCategoryIDSet = {labelID for labelID in oneDatapoint["labels"]} - {-100} # take all the label IDs in one data point so we know which ones only contain label 8, which, in this scenario, is the ID for label "O". This label number might differ in your case, depending on which value you assigned "O" to in your "bioLabelToNumberDict"
        if dataCategoryIDSet == labelsToDownsampleSet:
            dataWithOnlyDownsampleIDs.append(oneDatapoint)
    
    numberOfDownsampleIDsToKeep = int(len(dataWithOnlyDownsampleIDs) * 0.05) # how many datapoints with the downsample label to keep after downsampling. Replace 0.2 with a ratio that you want to downsample to. Putting 0.2 means that I want to keep only 20% of the original data points that contain the "O" label  

    downsampleIDDatapoints = random.sample(dataWithOnlyDownsampleIDs, numberOfDownsampleIDsToKeep) # select the downsampled amount of "O" category data points

    onlyNERLabeledDataList = [] # find data points after upsampling that contain non-"O" data labels
    for oneDatapoint in resampledFinalTrainingDataList:
        for oneLabel in oneDatapoint["labels"]:
            if oneLabel in NERLabelIDsOnly:
                onlyNERLabeledDataList.append(oneDatapoint)
                break

    resampledFinalTrainingDataList = onlyNERLabeledDataList + downsampleIDDatapoints # combine upsampled and downsampled together

    return resampledFinalTrainingDataList

finalResampledTrainingDataList = resampleTrainingData(trainingDataList, bioLabelToNumberDict)

# visually see the changes in our data points:


preResamplingLabelCounterDict = {}
for oneDataPoint in trainingDataList:
    for oneLabel in oneDataPoint["labels"]:
        if oneLabel == -100:
            continue
        if numberToBioLabelDict[oneLabel] not in preResamplingLabelCounterDict:
            preResamplingLabelCounterDict[numberToBioLabelDict[oneLabel]] = 0
        preResamplingLabelCounterDict[numberToBioLabelDict[oneLabel]] += 1

print("Before resampling: ", preResamplingLabelCounterDict)

postResamplingLabelCounterDict = {}
for oneDataPoint in finalResampledTrainingDataList:
    for oneLabel in oneDataPoint["labels"]:
        if oneLabel == -100:
            continue
        if numberToBioLabelDict[oneLabel] not in postResamplingLabelCounterDict:
            postResamplingLabelCounterDict[numberToBioLabelDict[oneLabel]] = 0
        postResamplingLabelCounterDict[numberToBioLabelDict[oneLabel]] += 1

print("After resampling: ", postResamplingLabelCounterDict)
```

The terminal printout should show the frequency of each data point before and after resampling. If you are not satisfied with the changes in numbers, you can revisit the ratios for upsampling and downsampling in the function and change those values. You might need a few trial-by-error to get this right.

### Aside #1: What is a Hyperparameter?
So far in this lesson, we have manually decided on a few numbers: training/validation/testing data split ratio and data upsampling/downsampling ratio. These are numbers that only you, the domain expert, can decide, based on your familiarity with your corpora, domain, and research questions. Data split and resampling ratios are some examples of hyperparameters used in model fine-tuning and training. We will encounter more hyperparameters in future steps.

Hyperparameters can greatly impact the performance of your model. As seen in data resampling, changing just the upsample/downsample ratio number can completely alter your training data’s outlook. Thus, researchers should test different hyperparameter combinations throughout the training process.

Nevertheless, despite hyperparameters’ huge influence, the most important aspect in ensuring your model’s quality is our manually labeled training data. This goes back to Step 1, the iterative nature behind building our data schemas and operational definitions. These schema and definitions are always subject to change as you gain new information and understanding about your corpora, domain, and research question, even at the last step of our lesson.


### Step 12: Loading Dataset

After creating our training dataset, we need to load our dataset into the HuggingFace Dataset object, which is compatible with BERT.
```
def quickNameChange(trainingDatasetList):
    # renaming this so that we are compatible with the BERT and HuggingFace naming conventions
    renamedData = {"input_ids": trainingDatasetList["inputIDs"], "attention_mask": trainingDatasetList["attentionMask"], "labels": trainingDatasetList["labels"]}
    return renamedData

finalResampledTrainingDataList = [quickNameChange(oneDatapoint) for oneDatapoint in finalResampledTrainingDataList]
validationDataList = [quickNameChange(oneDatapoint) for oneDatapoint in validationDataList]
```
```
import datasets

reformattedFinalTrainingDataset = datasets.Dataset.from_list(finalResampledTrainingDataList)
reformattedValidationTrainingDataset = datasets.Dataset.from_list(validationDataList)

# check if we got it right

print(type(reformattedFinalTrainingDataset)) # this should give us a class "datasets.arrow_dataset.Dataset"
print(reformattedFinalTrainingDataset) # this should give us: features: ['input_ids', 'attention_mask', ‘labels']
```

We will now write a data collation function, which batches our data.

### Step 13: Loading Training Metrics and Model

Now, we have our data ready for training. The next step is to write a collation function, which batches data during training.
```
import torch
def collateData(trainingDataset):
    # this is to collate our data into batches
    inputIDs = torch.stack([torch.tensor(oneDatapoint["input_ids"]) for oneDatapoint in trainingDataset])
    attentionMask = torch.stack([torch.tensor(oneDatapoint["attention_mask"]) for oneDatapoint in trainingDataset])
    labels = torch.stack([torch.tensor(oneDatapoint["labels"]) for oneDatapoint in trainingDataset])

    returnDict = {"input_ids": inputIDs, "attention_mask": attentionMask, "labels": labels}
    return returnDict
```

Then, we will import our model:
```
import transformers

# load the model
bertTrainingModel = transformers.BertForTokenClassification.from_pretrained("bert-base-cased", num_labels=len(bioLabelToNumberDict))
```

And set the training hyperparameters. We will use the HuggingFace [Trainer](https://huggingface.co/docs/transformers/en/main_classes/trainer) API’s [TrainingArguments](https://huggingface.co/docs/transformers/v5.8.1/en/main_classes/trainer#transformers.TrainingArguments) method:
```
# this lesson lists the parameters line by line below, since there are quite a few of them, so it is easy to see
trainingHyperparameters = transformers.TrainingArguments(
    output_dir="./customizedNERBERTVer1",

    # evaluation and save methods
    evaluation_strategy="epoch",
    save_strategy="epoch",

    # training parameters
    learning_rate=2e-5,
    per_device_train_batch_size=8,
    per_device_eval_batch_size=8,
    num_train_epochs=4,
    weight_decay=0.01,

    # after training, what models to output
    load_best_model_at_end=True,
    metric_for_best_model="f1"
)
```

Now, create the metrics computation function:[^12]
```
import evaluate
import numpy

metric = evaluate.load("seqeval") # seqeval is commonly used for NER evaluation

# Function to compute precision, recall, F1 and accuracy.
def computeMetricsAndPredictions(rawPrediction):
    predictions, labels = rawPrediction

    predictions = numpy.argmax(predictions, axis=2) # find which label has the highest prediction score, and that will be the prediction that the model is making 

    truePredictions = [
        [numberToBioLabelDict[p] for (p, l) in zip(prediction, label) if l != -100]
        for prediction, label in zip(predictions, labels)
    ]

    trueLabels = [
        [numberToBioLabelDict[l] for (p, l) in zip(prediction, label) if l != -100]
        for prediction, label in zip(predictions, labels)
    ]

    results = metric.compute(predictions=truePredictions, references=trueLabels)

    return {"precision": results["overall_precision"], "recall": results["overall_recall"], "f1": results["overall_f1"], "accuracy": results["overall_accuracy"]}
```

### Step 14: Load Trainer

Continuing using the Trainer API, we will initiate the trainer:
```
modelTrainer = transformers.Trainer(
    model=bertTrainingModel, # replace this with your model variable
    args=trainingHyperparameters, # this is from the TrainingArguments() method
    train_dataset=reformattedFinalTrainingDataset, # from Step 12
    eval_dataset=reformattedValidationTrainingDataset, # from Step 12
    data_collator=collateData, # from Step 13, use the function name for data collation
    compute_metrics=computeMetricsAndPredictions # from Step 13, use the function name for metrics computation
)
```

Train it using the .train() method:

```
modelTrainer.train()
```

And save the fine-tuned model and tokenizer to a directory of your choosing. Save both the model and tokenizer to the same directory and give the directory a meaningful name:

```
modelTrainer.save_model("./NERBERTfine-tuneVer1")
tokenizer.save_pretrained("./NERBERTfine-tuneVer1")
```

The time to run the training process varies greatly, depending on the size of your data, access to GPU, and others. It could take up to an hour or more. Make sure to run the two `save_` methods so that you do not lose your progress after minutes or hours of training.

### Aside #2: Training Hyperparameters

This lesson specified a few default values for training hyperparameters in `.TrainingArguments()` method. You should experiment yourself based on your modern performance and change them accordingly.

| Hyperparameter | Description |
| - | - |
| eval_strategy | determines when during training does the model use the validation set to evaluate its performance. Setting it to “epoch” means evaluating every epoch; “step” means every few training steps; “no” (default) means no evaluation |
| save_strategy | when during training does the model save checkpoints. It has the same three options as eval_strategy. The value for save_strategy and eval_strategy should be the same. |
| learning_rate | size of step that the model takes when changing weights during training. A value too big risks overshooting; too small risks underfitting or long training time. Some options: 1e-5, 2e-5, 3e-5 |
| per_device_train_batch_size | how many batches are processed at once. Larger number requires more memory storage. If you receive an Out-of-Space error, try decreasing the batch size. Some options: 4, 8, 16 |
| per_device_eval_batch_size | same as above, but for validation data and not training data. The value here should be the same value as per_device_train_batch_size |
| num_train_epochs | how many epochs does the training process uses. One epoch equals the model “reading” the dataset once. Larger epoch number risks overfitting; lower epoch risks underfitting. Some options: 2, 4, 8, 10 |
| weight_decay | attempt to standardize weights by decreasing large training weights. This is helpful for tasks like NER, where we often have imbalanced datasets. Higher decay risks not learning meaningful patterns; lower decay risks overfitting. Some options: 0.1, 0.01, 0.001 |
| load_best_model_at_end | which model training checkpoint will be the final outputted model. If True, then it will output the best. You should always set it to True |
| metric_for_best_model | how the model determines which checkpoint is the best. The options “f1”, “accuracy”, and “precision” refer to which of these three values the model will use to determine this |

### Step 15: Evaluate Your Model

After you have fine-tuned and saved your model, we will manually evaluate its performance, regardless of whether you used testing dataset or not. Because of the complex nature of human language and historical context, domain experts should always qualitatively review model performance.

To do so, first find where you have saved your model and load it:
```
fineTunedModel = transformers.BertForTokenClassification.from_pretrained("./NERBERTfine-tuneVer1")
fineTunedTokenizer = transformers.BertTokenizerFast.from_pretrained("./NERBERTfine-tuneVer1")

fineTunedModel.eval() # set to inference mode
```
Replace “NERBERTfine-tuneVer1” with the folder path of your fine-tuned model.

Then add this inference function that will take in unseen raw text as a string, split it into 512-token windows, and perform prediction. Set overlapInt to the window overlap value that you did in Step 10’s `turnLabeledDataIntoBioFormat` function.

```
def runNERInference(rawText, overlapInt):

    tokenizedStory = fineTunedTokenizer(rawText, return_tensors="pt", truncation=False, add_special_tokens=False)
    totalInputIDs = tokenizedStory["input_ids"][0]
    totalAttentionMask = tokenizedStory["attention_mask"][0]

    # since our training data was in the form of 512-token windows, our input value need to be that too
    windowSizeInt = 512
    windowStepSize = windowSizeInt - overlapInt
    windowsList = []
    startingPointInt = 0

    while startingPointInt < len(totalInputIDs):
        endPoint = min(startingPointInt + windowSizeInt, len(totalInputIDs))

        windowsList.append({
            "input_ids": totalInputIDs[startingPointInt:endPoint],
            "attention_mask": totalAttentionMask[startingPointInt:endPoint],
            "start": startingPointInt,
            "end": endPoint
        })

        if endPoint == len(totalInputIDs):
            break

        startingPoint += windowStepSize

    # perform NER classification on each window
    allModelPreductionsList = [None] * len(totalInputIDs)

    for window in windowsList:
        inputs = {
            "input_ids": window["input_ids"].unsqueeze(0),
            "attention_mask": window["attention_mask"].unsqueeze(0)
        }

        with torch.no_grad():
            outputs = fineTunedModel(**inputs)

        predictions = torch.argmax(outputs.logits, dim=2)[0].tolist()

        for i, predictedValue in enumerate(predictions):
            tokenIndexInt = window["start"] + i
            if tokenIndexInt < len(totalInputIDs):
                if allModelPreductionsList[tokenIndexInt] is None:  # keep left window's prediction for overlaps
                    allModelPreductionsList[tokenIndexInt] = predictedValue

    # turn model predictions into labels that we have specified in "bioLabelToNumberDict"
    tokenList = fineTunedTokenizer.convert_ids_to_tokens(totalInputIDs)
    results = []
    for token, labelID in zip(tokenList, allModelPreductionsList):
        results.append((token, numberToBioLabelDict[labelID]))

    # get rid of special tokens and combine subword tokens
    cleanedOutputList = []
    for token, label in results:
        if token == "[CLS]" or token == "[SEP]":
            continue
        if token.startswith("##"): # subword tokens always begin with "##"
            cleanedOutputList[-1] = (cleanedOutputList[-1][0] + token[2:], cleanedOutputList[-1][1])
        else:
            cleanedOutputList.append((token, label))

    return cleanedOutputList
```

Then, set your unseen text into one string and determine the number of overlap tokens.

```
rawText = “” # set the text that you want to perform NER on 
overlapInt = 30 # use your own overlap number from Step 10

predictedNERs =runNERInference(rawText, overlapInt)
print(predictedNERs)
```

### Step 16: Repeat

Manually review the prediction output from Step 15 and decide on whether you need to edit the hyperparameters. Most often, you need to run the training process at least two times to compare which hyperparameter combination is the most suitable for your model.

Moreover, actively review whether your NER data schema and operational definitions are still sound. Fine-tuning BERT (or any other language models) for research is not a linear process but an iterative one where we will constantly revisit the very first step in this process. The model quality will increase as you increase the dataset more through using existing NER dataset or annotating more of your corpus.

### Technical Material Source Acknowledgement

Many other sources have provided similar technical tutorials for BERT NER fine-tuning, since the coding process to do so is, after all, very similar in spirit and that many coding techniques are interchangeable. This lesson's contribution is less so on the technical implementation but the iterative nature of research and customizing our own NER data schema.

This lesson benefitted from sources like Medium posts by [DamenC](https://medium.com/@cd_24/fine-tuning-bert-for-custom-named-entity-recognition-in-google-colab-a-step-by-step-guide-6c140e2b87c5), [Maneyogesh](https://medium.com/@maneyogesh065/fine-tuning-biobert-for-custom-named-entity-recognition-a-complete-guide-a05b124edda0), and [why amit](https://medium.com/@whyamit101/fine-tuning-bert-for-named-entity-recognition-ner-b42bcf55b51d), Argilla’s [BERT NER tutorial](https://docs.v1.argilla.io/en/latest/tutorials/notebooks/ner_fine_tune_bert_beginners.html), HuggingFace’s [transformers fine-tuning guide](https://huggingface.co/docs/transformers/en/training), and Claude Sonnet 4.6 free version to plan the lesson content. Because each person's dataset and situation is different, you are encouraged to compare other BERT fine-tuning workflows to learn what is the best for your research question and domain.

## Endnotes
[^1]: Enrique Manjavacas and Lauren Fonteyn, “Adapting vs. Pre-training Language Models for Historical Languages,” *Journal of Data Mining and Digital Humanities* jdmdh:9152 (2022): https://doi.org/10.46298/jdmdh.9152; Hady Elsahar, Matthias Gallé, “To Annotate or Not? Predicting Performance Drop under Domain Shift,” in *Proceedings of the 2019 Conference on Empirical Methods in Natural Language Processing and the 9th International Joint Conference on Natural Language Processing (EMNLP-IJCNLP)*, eds. Kentaro Inui (Hong Kong: Association for Computational Linguistics, 2019), 2163-2173.

[^2]: Manjavacas and Fonteyn, “Adapting vs. Pre-training Language Models for Historical Languages.”

[^3]: E.g.: ibid.; Elizabeth F. Evans and Matthew Wilkens, “Nation, Ethnicity, and the Geography of British Fiction, 1880-1940,” *Journal of Cultural Analytics* 3, no. 2 (2018): https://doi.org/10.22148/16.024; Corina Koolen and Andreas van Cranenburgh, “These are not the Stereotypes You are Looking For: Bias and Fairness in Authorial Gender Attribution,” in *Proceedings of the First ACL Workshop on Ethics in Natural Language Processing*, eds. Dirk Hovy et al. (Valencia : Association for Computational Linguistics, 2017), 12-22.

[^4]: E.g., Daniel Kababgi et al., “Recognizing non-named spatial entities in literary texts: a novel spatial entities classifier,” (paper presented at CHR 2024: Computational Humanities Research Conference, Aarhus, Denmark, December 4–6, 2024), 472-481.

[^5]: Some examples include: ibid.; Jenny Rose Finkel et al., “Incorporating Non-local Information into Information Extraction Systems by Gibbs Sampling,” in *Proceedings of the 43nd Annual Meeting of the Association for Computational Linguistics*, eds. Kevin Knight et al. (Ann Arbor: Association for Computational Linguistics, 2005), 363-370 (this is Stanford NER); Arthur Jacobs and Annette Kinder, “What makes a metaphor literary? Answers from two computational studies,” *Metaphor and Symbol* 33, no. 2 (2018): 85-100; Giulia Grisot and Berenike Herrmann, “Examining the representation of landscape and its emotional value in German-Swiss fiction between 1840 and 1940,” *Journal of Cultural Analytics* 8, no. 1 (2023): https://doi.org/10.22148/001c.84475.

[^6]: Matthew Hannibal et al., *spaCy: Industrial-strength Natural Language Processing in Python* (2020), 10.5281/zenodo.1212303.

[^7]: Kababgi et al., “Recognizing non-named spatial entities in literary texts,” 475.

[^8]: Most of the Doccano installation steps included here are also listed on the Doccano documentation page: https://doccano.github.io/doccano/.

[^9]: If the localhost address does not work, your terminal should have printed out a line that says “Listening at:” followed by a link. Copy and paste that link into your browser.

[^10]: If you are a MacBook user accustomed to using the “Command” instead of “Control” key, you still need to use “Control” when working with the terminal. 

[^11]: Note that we are treating our manual annotation as gold standard (often because there does not exist another dataset that fits the needs of a specific research genre or question. This is why domain specialty and Step 1’s iterative process is important so that the annotator (us) can ensure data quality.

[^12]: This metrics computation function is borrowed from the BERT fine-tuning tutorial from Argilla, an open-source data curation platform. Argilla, “Fine-tunning a NER model with BERT for Beginners,” *Argilla*, https://docs.v1.argilla.io/en/latest/tutorials/notebooks/ner_fine_tune_bert_beginners.html. Accessed May 13, 2026.
