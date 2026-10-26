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
- Train a [BERT](https://github.com/google-research/bert) (Bidirectional Encoder Representations from Transformers) classification model in Python using the annotated corpus;
- Understand concepts like data resampling, hyperparameters, train/test sets, and other machine learning concepts. This lesson will introduce these concepts as they appear in the pipeline.

To illustrate the full lifecycle of domain-specific textual analysis, this lesson uses the technique of Named Entity Recognition as an example. Users can substitute other textual analysis techniques beside NER when using this lesson.

### The Case for Domain-Specific Programs and Models

The quality of a textual analysis program or algorithm depends on the quality of the training data. When a program pre-trained or fine-tuned on a corpus that is less related to the application context, the program performs less accurately.[^1] Researchers have been building domain-specific programs to achieve higher accuracies when working with texts that share particular historical or social contexts. For example, MacBERTh, a BERT-based program pre-trained on English literature between 1450 and 1950, addresses the gap that programs trained on contemporary texts cannot accurately research historical language usage.[^2]

The range of “domain” varies greatly from research to research. Existing DH research often divides “domain” along national, gender, ethnic, temporal, or geographic lines.[^3] These are not the only domains. Depending on a researcher’s focus, domain could also be the format or medium of the corpus (e.g., a corpus of only novels, poetry, letters, or short stories), the situation of text production (e.g., a corpus of news reports that focus on one event), or others.

### Prerequisites

This lesson requires a basic Python technical understanding and access to a coding environment (either local- or cloud-based) to run the required Python code via Jupyter Notebook. Some options include [Google Colab](https://colab.research.google.com/) (for cloud) and Visual Studio Code (for local). A fundamental understanding of textual analysis, [Named Entity Recognition](https://programminghistorian.org/en/lessons/finding-places-world-historical-gazetteer#65-named-entity-recognition), and Natural Language Processing will be helpful.

Since this lesson focuses on building a domain-specific program, users should have domain knowledge in the field that they apply this lesson to.

Graphic Processing Units (GPU) are not required but recommended.

This lesson uses Python3.11.5

Recommended system setup:
- 16GB RAM (8GB minimum)
- \>5GB disk storage space
- Internet connection when installing the following packages

Required package versions (downloadable via `pip install packageName==version` or `pip install packageName<version`):
```
doccano==1.8.4
numpy<2
marshmallow<4
torch==2.9.1
scikit-learn==1.8.0
transformers==4.57.1
datasets==4.8.5
evaluate==0.4.6
seqeval==1.2.2
```

### Sample Dataset and Sample Research Question

To showcase the manual annotation and fine-tuning pipeline, this lesson uses a sample text with a sample research question. Readers should substitute the text with their own research corpus and research question. This lesson will indicate where readers should substitute their own research components into the pipeline.

This lesson uses three of Herman Melville's short stories as the sample corpus:
- “Bartleby, The Scrivener” 
- "The Piazza Tales"
- "Benito Cereno"

Collected in Melville's 1856 collection _The Piazza Tales_ [Project Gutenberg](https://www.gutenberg.org/cache/epub/15859/pg15859.txt).
  
We will try to answer the sample question “How does Melville use non-named entities differently than named entities in conveying ‘space’ in his short stories?” This sample question defines “non-named entities” as words or terms that are not proper nouns while “named entities” (NE) as proper nouns or titles.[^4]

You can download the [sample dataset here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/ner-bert-classification-machine/admin.jsonl.zip).

## Steps in the Pipeline

### Step 1: Creating Data Annotation Schema

This step requires the researchers’ domain specialty the most. The lesson’s sample question designated that the domain for this research is spatial history and analysis.

Many NLP research creates their own data schema or borrow the schema from an existing project related to their work.[^5] Data schema refers to how the researcher categorizes words and terms. spaCy provides one common NER schema. Its English language `en_core_web_md` model contains the NER categories `CARDINAL`, `DATE`, `EVENT`, `FAC`,` GPE`, `LANGUAGE`, `LAW`, `LOC`, `MONEY`, `NORP`, `ORDINAL`, `ORG`, `PERCENT`, `PERSON`, `PRODUCT`, `QUANTITY`, `TIME`, and `WORK_OF_ART`.[^6] spaCy is a powerful yet general-use NER tool and, thus, not the most suitable for domain-specific tasks.

Whether to create a customized data schema depends on your research question, availability of existing research, and the discipline that you operate in. When creating your customized data schema, it might feel slightly uncomfortable at first, since the researcher might think that they are attempting to predict what words or terms they might find. There are two ways to mitigate this. The first is to have domain specialty. The second is to adopt an iterative process, where the researcher close reads parts of their corpus (if the full corpus is too large to close read fully), create a preliminary data schema, and revise the schema as the researcher close-reads more of the corpus and conduct more research on the topic via secondary or other primary sources. As an iterative process, it is very likely that, as you advance onto the following steps in this lesson, you might encounter information that would cause you to revisit this step to edit your data schema.

If you work in a lively discipline, you might find other researchers who have already created a customized data schema that you can borrow. Reusing data schema not only provides convenience but also enhances interoperability in existing digital humanities programs.

In the context of our sample research question, a question about spatial history, we will borrow the spatial NNE schema from Daniel Kababgi et al.’s research, which contains four categories: **interior**, **urban**, **rural**, and **natural**.[^7]

After determining the data schema, the researcher should create an operational definition for each category. Although some category names might be common terms (like “interior”), when used in the context of your research, they carry specific meaning, connotation, or historical/cultural context that you have now provided it. If you publish or share your work with others in the future, make sure to include your list of operational definitions with your work.

For instance, this sample research question uses the operational definition for **natural** as: non-artificial features that has the ability to be linked to specific locations or entities. Examples include _mountain_, _valley_, and _canyon_.

### Step 2: Creating Corpus

This step creates the machine-friendly text files for your corpus. Depending on the popularity of your research topic, there might be existing databases or organizations that provide structured text files. For instance, [Early English Books Online](https://proquest.libguides.com/eebopqp) (EEBO) is a repository for Early Modern English texts stored in XML and TXT formats. [Project Gutenberg](https://www.gutenberg.org/) also provides cleaned TXTs.

This lesson uses TXT to store raw corpus content. Researchers should store all TXTs in one directory, where each unit of text (e.g., novel, short story, essay, etc., as defined by your research) has its own dedicated TXT file. Make sure to name your TXT file(s) in a meaningful way. If you have multiple TXTs, store them within one directory.

The method of creating these TXT files varies greatly, depending on where your source text comes from. Researchers working on printed or handwritten materials might need an extra character recognition step, which [Isabelle Gribomont](https://programminghistorian.org/en/lessons/ocr-with-google-vision-and-tesseract)'s and [Jeff Blackadar](https://programminghistorian.org/en/lessons/transcribing-handwritten-text-with-python-and-azure)'s lessons cover. You might also need to clean your TXT files after creating them. The extent of your cleaning task varies greatly as well. Visit [Laura Turner O’Hara](https://programminghistorian.org/en/lessons/cleaning-ocrd-text-with-regular-expressions)'s lesson or the [“Cleaning the Corpus”](https://programminghistorian.org/en/lessons/understanding-creating-word-embeddings#cleaning-the-corpus) section in Avery Blankenship, Sarah Connell, and Quinn Dombrowski’s lesson for text cleaning guides.

This lesson uses the plain text TXT file from Project Gutenberg. Thus, our cleaning task is to find the stories in Melville's story collection and remove the Project Gutenberg header and footer texts, which are before the line:

`*** START OF THE PROJECT GUTENBERG…`

and after the line:

`*** END OF THE PROJECT GUTENBERG…`

Using coded programs to clean texts is only necessary if there are significant or numerous repetitive cleaning tasks. When cleaning tasks are manageable, we can manually read the TXT file and make the relevant fixes ourselves.

### Step 3: Doccano Setup

Manual annotation is key to ensure data quality, which in return upholds the quality of a fine-tuned language model. This step might feel tedious, but it provides invaluable benefits. One is that the annotator is the domain expert. Manual annotation also creates an opportunity to close-read the source text from a different perspective, as the researcher also serving the annotator's role can reflect on the customized data schema while annotating (thus creating the iterative process mentioned in Step 1).

There are numerous text annotation tools. This lesson uses [Doccano](https://doccano.github.io/doccano/), an open-source data annotator that runs on your local server. There are three ways to run Doccano: pip, Docker, and Docker Compose. This lesson uses pip and Python 3.11 (Doccano requires a minimum of Python 3.8). The newest Python version is 3.14, but 3.14 has some dependency issues with certain libraries that Doccano uses.

Running Doccano in a Python virtual environment helps with dependency management. To create a Python virtual environment, open a terminal window and type:

```python3.11 -m venv doccano```

Depending on your configuration, the `python3.11` command might be different, such as simply `python -m venv doccano`.

`doccano` will be the name of this virtual environment that we will run Doccano in. You can name the virtual environment with another name by replacing `doccano` in the aforementioned command line.

Then, activate our virtual environment with the command:

```source doccano/bin/activate```

You should see `(doccano)` before your command line prompt. This shows that we are currently in the virtual environment. Whenever you need to exit your virtual environment, use:

`deactivate`

To install Doccano in your virtual environment, type: 

`pip install doccano "marshmallow<4" "numpy<2"`[^8]

This lesson uses `doccano1.8.4` version. Marshmallow is a library that converts datatypes, and numpy is a library that conducts numerical computation in Python. Doccano requires both at versions below four and two, respectively.

After installing Doccano, run these two commands in this order:

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

In a separate terminal window (leave `doccano webserver` running in the current terminal), enter your Doccano virtual environment and run the command:

```doccano task```

This command handles file upload and download while we use the Doccano web server.

After typing the `webserver` and `task` commands, your two terminal windows should show that the two commands are continuously running. They need to be running continuously while you perform tasks in your Doccano web server. Whenever you want to end your task, type `Control + C` or simply close your terminal windows.[^10]

At your localhost web address, you should see the Doccano home screen like this:

{% include figure.html filename="ner-bert-classification-machine-01.png" alt="A blue banner with a seal icon are on Doccano's homepage. There is a 'login' button on the top right corner." caption="Figure 1. Doccano's homepage after local server launches." %}

Navigate to the top right corner of the screen and click on `LOGIN`, using the credentials in Step 3.

After logging in, you should see a list of your Doccano projects (should be none, if you have not used Doccano before). Click on the blue “Create” button on the top left corner to create a new project.

{% include figure.html filename="ner-bert-classification-machine-02.png" alt="A red square indicates a blue button labeled 'Create'." caption="Figure 2. Creating a new Doccano project using the 'Create' button." %}

The screen should prompt you to select a category of project before filling in the `Project Name` and `Description`. For project category, select `Sequence Labeling`. Use meaningful names and descriptions in `Project Name` and `Description` so that you can easily identify your work in the future. Check the `Allow overlapping spans` checkbox.

{% include figure.html filename="ner-bert-classification-machine-03.png" alt="Three text boxes labeled 'Project name', 'Description', and 'Tags' with a selected checkbox labeled 'Allow overlapping spans'." caption="Figure 3. Input the Project Name, Descriptions, and Tags for our new Doccano project. Select 'Allow overlapping spans'." %}

Click `Create`.

### Step 5: Import Data to Doccano and Create Labels

**Import Data**

After creating a Doccano project, the webpage will ask you to import data. The “Home” tab on the left of the screen provides video tutorials on Doccano functionalities.

{% include figure.html filename="ner-bert-classification-machine-04.png" alt="Multiple tabs are on the left of the screen, with 'Home' selected. A video is under the 'Import a dataset' section." caption="Figure 4. Front page of a new Doccano annotation project." %}

Navigate to `Dataset` tab, click on `Actions`, and select `Import Dataset` from the dropdown list.

{% include figure.html filename="ner-bert-classification-machine-05.png" alt="A red square indicates the location of 'Import Dataset' button under a blue 'Actions' dropdown menu on the 'Dataset' tab." caption="Figure 5. Select the 'Import Dataset' button." %}

The webpage will then prompt you to select “File format” and “Encoding.” Select “TextFile” (for TXT) for file format. The default encoding is “utf-8,” which should fit most people’s needs.
Then, drop your TXT file(s) to the grey box below and click “Import.”

{% include figure.html filename="ner-bert-classification-machine-06.png" alt="There is a gray rectangle that allows users to drop files to upload. Above it, there are dropdown menus to select 'TextFile' and 'utf-8' encoding." caption="Figure 6. Drag and drop TXT files to upload them to the dataset." %}

You should now see a preview of your uploaded TXT on your “Dataset” screen.

**Create Labels**

We will now load our customized data schema into Doccano. Navigate to the `Labels` tab, click on `Actions`, and select `Create label` from the dropdown list.

{% include figure.html filename="ner-bert-classification-machine-07.png" alt="A red rectangle indicates the 'Create Label' button under a blue 'Actions' dropdown menu on the 'Labels' tab." caption="Figure 7. Select 'Create Label' to input our data schema." %}

You can now enter the customized NER data schema one by one into the `Label name` field. To add multiple schema categories, click on `Save and add another` after adding one schema category.

After entering all your schema categories, you can see and edit your categories at the `Labels` tab screen. Our sample research question uses four labeling categories: interior, urban, rural, and natural.

{% include figure.html filename="ner-bert-classification-machine-08.png" alt="There are four created annotation labels: interior, urban, rural, and natural on the 'Labels' tab." caption="Figure 8. Create the four data annotation labels." %}

### Step 6: Data Annotation

After loading your customized data schema into Doccano, visit the `Dataset` tab to see your TXT file(s) and begin annotating by clicking on “Annotate” under the `Action` column. This will open the TXT file. To annotate, highlight a word(s) to trigger a dropdown list containing your data schema categories. Select a category that matches with the context, meaning, or usage of your highlighted phrase.

Labels will appear beneath the annotated text.

{% include figure.html filename="ner-bert-classification-machine-09.png" alt="A piece of text with two annotations, urban, and interior." caption="Figure 9. Example of annotations during the annotation proces." %}

Repeat this step if you have numerous TXT files to annotate.

Note that, as mentioned in Step 1, as you annotate more texts, you might encounter scenarios where your current data schema has certain shortcomings, such as failing to consider a type of linguistic usage, historical context, narrative structure, etc. This is one opportunity to consistently and iteratively engage with your data schema and revise it as needed. On the other hand, language is complex and highly variable; no data schema can consider all types of usage (in the context of this lesson, all types of spatial portrayal in fiction). The researcher, based on their domain specialty, research question, and research findings, must decide which scenarios warrant editing the data schema and operational definitions for the schema categories and which do not.

### Step 7: Data Export and Preparation for Fine-Tuning

First, create a directory and give it a meaningful name. This folder will hold all files for the rest of the lesson so that you can store the dataset(s), code file(s), and fine-tuned models in one place.

After annotating all your TXT files, you can export the data via a JSONL file by visiting the `Dataset` tab, clicking on `Actions`, and selecting `Export Dataset`. The screen will then present a sample overview of the data structure of the JSONL file that you will download. Clicking on `Export` will download a Zip file containing your JSONL file. JSONL stands for JSON Lines, a way to collect multiple JSON objects into one file. Each line in a JSONL file is one JSON object. For Doccano’s data export function, each line represents one TXT file being annotated and the annotations that you have created in Step 6.

Depending on the security features on your machine or browser, the downloading process might be interrupted because your machine or browser might think it is an insecure file. If this happens, you can navigate to your browser’s `Download` icon and manually permit file download. For example, for Google Chrome browser, you need to click on `Keep` for the downloading file:

{% include figure.html filename="ner-bert-classification-machine-10.png" alt="A red rectangle indicates a 'Keep' button on the Download icon of a browser for a file labeled 'Insecure download blocked." caption="Figure 10. Select 'Keep' on the download file if the browser initially blocks the downloa." %}

After downloading the Zip file, unzip it and store the JSONL file in it in the directory that you have just created. If you are coding in Google Colab, you can upload the JSONL file to your Colab work environment.

Each JSON object (which resembles a Python dictionary datatype) in the downloaded JSONL file has four keys: `id`, `text`, `label`, `Comments`.

| key | data type | description |
| ------- | ------- | ------- |
| `id` | int | counter of the number of this specific TXT file in your entire dataset |
| `text` | str | the raw text of this TXT file that you uploaded |
| `label` | list | contains the specific phrases that you annotated, their locations in your text, and the category. This is a list of lists, where each inner list represents one annotation. Each inner list contains three elements: start index position of the annotated text in the raw text (int), end index position of the annotated text in the raw text (int), and the data schema category that you assigned it (str). Example: `[[3733, 3749, "urban"], [4861, 4889, "interior"], …]` |
| `Comments` | list | comments that you provided during your annotation process. Blank if you did not provide any comments. This lesson does not use this Deccano feature |

**File Check**

We will now use one Jupyter Notebook file to contain the remaining code.

Create a Jupyter Notebook file (.ipynb) in the same directory (either local or a cloud coding environment that you are using) as your JSONL data file. Quinn Dombrowski, Tassie Gniady, and David Kloster’s [lesson](https://programminghistorian.org/en/lessons/jupyter-notebooks) provides an introduction to Jupyter Notebook.

To check whether your downloaded JSONL file contains the correct information, run this following code to iterate through each JSON object in the JSONL file.

```
import json

with open("admin.jsonl") as annotationFile:
    for oneJSONObject in annotationFile:
        oneAnnotatedFileDict = json.loads(oneJSONObject)

        # preview the first 100 characters of each text file
        previewText = oneAnnotatedFileDict["text"][:100].replace("\n", " ") + "..."

        # print the file number, text preview, and the first 5 annotations that you made
        print("File no.:\n", oneAnnotatedFileDict["id"])
        print("Text preview:\n", previewText)
        print("Annotation preview:\n", oneAnnotatedFileDict["label"][:5], "\n\n")
```

This prints a brief preview of each TXT files and the first five annotations for each. If no error occurs and that the printout looks correct, the training data should be ready for fine-tuning.

**Storing JSON Objects as Dictionary**

For easier data access later on, we will store all JSON objects into one list, named `mainAnnotationStorageList` via this code and refer to this variable later in the lesson when accessing our raw text and annotation.

```
mainAnnotationStorageList = []

with open("admin.jsonl") as annotationFile:
    for oneJSONObject in annotationFile:
        oneAnnotatedFileDict = json.loads(oneJSONObject)
        mainAnnotationStorageList.append(oneAnnotatedFileDict)

# double checking that we did this correctly:
print(f"Stored {len(mainAnnotationStorageList)} file(s).")
```
This should print out the number of files that we have annotated.

**Installing Libraries**

We will need the PyTorch, numpy, scikit-learn, transformers, datasets, evaluate, and seqeval libraries. In a code cell in the Jupyter Notebook, run:

```
!pip install torch numpy scikit-learn transformers datasets evaluate seqeval
```
This step might take a few minutes.

### Step 8: Understanding Our Training Data

Before model fine-tuning or training, it is a good practice to understand the data at a larger scale, as this understanding will influence architectural decisions in the model fine-tuning process later in this lesson.

For word classification, we should understand our training data cumulatively. We will calculate the number of annotations each category has, the corpus's word count, and the percentage of words that are annotated as non-named entities.

```
mainTrainingDataLabelCounterDict = {}
totalTrainingDataWordCounterInt = 0
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

This step will reveal whether there is an imbalance of data annotations (e.g., one NER label having much more data points than others). We can mitigate an imbalance by either annotating more texts or using data resampling (introduced later).

Keep the printed information in mind going forward. Many decisions going forward will be architectural choices that vary from research to research, so this lesson can only provide general guidance and choices made in the context of this lesson’s sample research question. The specific decisions for your situation depends on your domain expertise, corpus, and research question.

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

`O` is an unlabeled token, or the “Outside” in BIO. [CLS] and [SEP] are special tokens used in transformer models, where [CLS] represents the beginning of a classification task and [SEP] refers to the end of a segment.

We will rewrite our labeled data according to the BIO format through dictionary mapping each label to a numerical value. The number of new labels we will have is `2n + 1`: `n` is the number of labels in our annotation schema (four, for this lesson). Each existing label will have a Beginning and an Inside version. We will write the following dictionary in our Jupyter Notebook:

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

Then, reformat our existing dataset (in the variable `mainAnnotationStorageList`) into this format using BERT's tokenizer. Since BERT has a 512-token limit, and that most short stories have more than 512 tokens, this lesson implements a sliding window during this process.

We will use the function `turnLabeledDataIntoBioFormat` to do this. This function has four required parameters and two default parameters.
| parameter | meaning |
| --- | --- |
| corpusTextStr | corpus text stored as a string |
| labelsList | list of labels and their index positions in the corpus text, as provided by our annotation in Doccano |
| tokenizer | the tokenizer we are using, and we use the one in `bert-base-cased` |
| labelIDDict | dictionary of annotation schema that we created earlier in `bioLabelToNumberDict` |
| windowLength=512 | default parameter: maximum window length allowed by BERT. Change this number based on the maximum allowed window length for the tokenizer you prefer, if you are not using BERT |
| overlap=30 | default parameter: overlap between two windows in a sequence |

This function operates at the level of each text in the `mainAnnotationStorageList` list created earlier. Meaning, if your corpus contains multiple texts (say, multiple short stories), we will call this function for each of these texts via a loop.

The BERT tokenizer in `turnLabeledDataIntoBioFormat` returns a container of tokenized texts and stores it in the variable `encoding`. The variable acts like a dictionary with four pairs of information:
| key | value |
| --- | --- |
| input_ids | an ID representing the token in BERT's model |
| attention_mask | a 1 or 0 value showing which tokens are meaningful (assigned `1`) and which are special tokens like `[CLS`]` or padding tokens (assigned `0`) |
| token_type_ids | a 1 or 0 value indicating which sequence (such as a question or an answer) a sentence belongs to. In our case, all tokens are labeled `0` in entity recognition |
| offset_mapping | tuples representing the start and end index position of an annotated entity in the corpus |

When using the tokenizer method, we set the parameter `return_offsets_mapping` to `True` so that the tokenizer will return the index position for each label in the original corpus text. This is important in entity recognition as words or terms could be split up during tokenization and distribution into windows of 512 tokens.

```
import transformers
tokenizer = transformers.BertTokenizerFast.from_pretrained("bert-base-cased")

def turnLabeledDataIntoBioFormat(corpusTextStr, labelsList, tokenizer, labelIDDict, windowLength=512, overlap=30):
    encoding = tokenizer(corpusTextStr, return_offsets_mapping=True, truncation=True, max_length = windowLength, stride=overlap, return_overflowing_tokens=True, padding="max_length")

    # splitting each element in the tokenizer return value into their own variables. Each inner list is one window of 512 tokens
    totalInputIDsList = encoding["input_ids"] # this contains input ids. We will use this for training
    totalAttentionMaskList = encoding["attention_mask"] # this contains attention mask. Will use this for training, too
    totalTokenTypeIDsList = encoding["token_type_ids"] # defaults to all zeros in our case. needed for BERT's format
    totalOffsetMappingList = encoding["offset_mapping"] # this contains the location for each token in the text in the format of a (startIndex, endIndex) tuple

    windowsList = [] # our return list to collect data

    # iterate through each window
    for windowIndex in range(len(totalInputIDsList)):
        offsetMapList = totalOffsetMappingList[windowIndex]
        tokensAsWordsList = tokenizer.convert_ids_to_tokens(totalInputIDsList[windowIndex]) # for debugging checks
        numberOfTokensInt = len(tokensAsWordsList)

        # first, set everything to the "Outside" label in BIO as default
        tokenNumericalLabelsList = [labelIDDict["O"]] * numberOfTokensInt

        # usually, special tokens, like [CLS], are -100
        for index, (startIndex, endIndex) in enumerate(offsetMapList):
            if startIndex == 0 and endIndex == 0:
                tokenNumericalLabelsList[index] = -100

        # assign BIO labels by iterating through our data schema
        for startAnnotatedtextIndexInt, endAnnotatedtextIndexInt, labelStr in labelsList:
            beginningLabelStr = f"B-{labelStr}"
            innerLabelStr = f"I-{labelStr}"

            beginningTokenBool = True

            for tokenIndex, (startOneTokenInAnnotatedTextIndexInt, endOneTokenInAnnotatedTextIndexInt) in enumerate(offsetMapList):
                
                if startOneTokenInAnnotatedTextIndexInt == 0 and endOneTokenInAnnotatedTextIndexInt == 0:
                    continue # these are the special tokens

                # checking for whether a token is an annotated entity and labels it as such
                if startOneTokenInAnnotatedTextIndexInt < endAnnotatedtextIndexInt and endOneTokenInAnnotatedTextIndexInt > startAnnotatedtextIndexInt:
                    if beginningTokenBool:
                        tokenNumericalLabelsList[tokenIndex] = labelIDDict[beginningLabelStr]
                        beginningTokenBool = False
                    else:
                        tokenNumericalLabelsList[tokenIndex] = labelIDDict[innerLabelStr]
        windowsList.append({"inputIDs": totalInputIDsList[windowIndex], "attentionMask": totalAttentionMaskList[windowIndex], "tokenTypeIDs": totalTokenTypeIDsList[windowIndex], "labels": tokenNumericalLabelsList})

    return windowsList
```

Now use this function to process all datasets in `mainAnnotationStorageList`. Note that we are not using `.append()` but using `.extend()` because the final dataset should be in one list, not separated into list of lists

```
totalProcessedAnnotationDataList = []
for oneAnnotatedText in mainAnnotationStorageList:
    processedDataForOneText = turnLabeledDataIntoBioFormat(oneAnnotatedText["text"], oneAnnotatedText["label"], tokenizer, bioLabelToNumberDict)
    totalProcessedAnnotationDataList.extend(processedDataForOneText)
```

### Step 10: Training/Validation/Testing Dataset Split

A good model fine-tuning process contains testing and validation data along with training data. The three are created from the existing pool of manually annotated data points. After fine-tuning the NER model, we will run the tuned model against the testing data to evaluate our model’s performance.[^11] During training, we use a validation dataset to evaluate the behavior and hyperparameters of the model. Validation data does not influence the model’s learning or weights but is important to prevent model overfitting.

| Type | Description|
| --- | --- |
| Training data | to train and update a model's weights |
| Validation data | to evaluate a model's performance during training |
| Testing data | the data that the model does not see during training so to test its performance |

However, splitting data into training, validation, and testing sets is most helpful on data that have a predictable length or size (e.g., labeling whether an email is spam or not: one Boolean response for one unit of text). For our context, non-named entity recognition (and text classification at large) is highly subjective and often does not have a universal “true” label, hence the need for domain-specific models and research (even among experts of the same domain, there still might be discrepancies in data labeling, given the subjective nature of this work). Meaning, two data labels might be slightly different in syntax but, depending on the research question, similar enough to count both as correct labels. For example, in non-named entity recognition, a sentence might include the phrase “a small private bedroom.” The test data might label this as `[“bedroom”: Interior]`. However, if the fine-tuned model labels `[“private bedroom”: Interior]`, it would be considered as an erroneous label, despite that it could still be considered as a good (or good enough) label. This is one drawback in using the traditional training/testing dataset split and can be mitigated through performing human manual testing, i.e., the human researcher evaluating the model's labeling after training is completed. Another drawback with training/testing dataset split for the context of this lesson is that the researcher needs a large enough dataset, which might be time-consuming to produce via manual data annotation. The benefit, of course, is that we have a quantitative evaluation of the model.

If you believe your research domain has large variability (and maybe that you do not have enough labeled data to afford splitting some just for testing), we can use all labeled data as training and validation data, as mentioned before, and test our trained model by manually observing the performance of our model on unseen text. The benefit of this approach is that we can dedicate more data on training and that we as researchers can more flexibly evaluate the model using our domain speciality. The tradeoff is that our model evaluation will be qualitative (i.e., “eye-balling” the fine-tuned model's performance).

If you also believe that you do not have enough manually labeled data even to split between data and validation, you could use all data for training. Again, choosing this option requires you to qualitatively evaluate the model using your domain expertise to ensure quality.

The choice between whether to create a validation datasets or create both testing and validation datasets depends on your research context, question, and data availability. Because of the size of the sample data, this lesson will only create training and validation sets data and manually test the model after training. Scikit-Learn’s [train_test_split()](https://scikit-learn.org/stable/modules/generated/sklearn.model_selection.train_test_split.html) method is a helpful tool in creating such splits. Two common training/validation/testing data ratios are 70/15/15 and 60/30/10. There is no one universally applicable ratio and is an architectural choice.

If you do choose to use data for validation and/or testing, make sure to split the data based on corpus texts rather than annotations. In other worse, if your corpus contains ten essays and you are using an 80/20 training-validation split, reserve the annotations for two essays for validation instead of randomly selecting 20% of all annotations for validation. This is to avoid the model learning the connotation for a corpus text using the annotation from it that were grouped into training data to "cheat" in the validation process that contains other annotations from the same corpus. If your corpus only has one corpus text (e.g., you are annotating one entire novel), then you need to be more robust during manual testing to prevent overfitting. However, if your corpus has only a few texts (like in our sample situation, where we only have three), it is okay to still split by data and not corpus texts.

This lesson uses a 80/20 split between training and validation set using Scikit-Learn's `.train_test_split()` method. Although the function is named using the word `test`, we will use this function to create training and validation data. Thus, for the `test_size` default parameter, in this lesson's context, we will view it as the size of the validation data.
```
import sklearn

trainingDataList, validationDataList = sklearn.model_selection.train_test_split(totalProcessedAnnotationDataList, test_size=0.2, random_state=2)
```

### Step 11: Data Resampling

As mentioned in Step 8, there will be times where we have an imbalanced dataset. For instance, we might have 400 data for one non-named entity category but only 20 for another. This would cause our fine-tuned model to behave more favorably toward the majority data categories and overlook the minority ones.

In entity recognition, the `O` category is often heavily overrepresented. This is not necessarily a problem, since most words in literature are neither named entities nor non-named entities. It is only a problem when there is an imbalance among annotation categories. You can review your data from Step 8 to see whether there is a data imbalance.

To address potential imbalance, we will use data resampling, a technique that overrepresents minority data and/or underrepresents majority data to balance the final training data. Do not perform data resampling on the validation and testing datasets. Upsampling and downsampling are two common ways of data resampling. Another way to address data imbalance is class reweighting, which changes the model weights, thus penalizing each category differently during training. This lesson will cover upsampling and downsampling. For a discussion on the difference between resampling and reweighting, see [this paper](https://ieeexplore.ieee.org/document/4669722).

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
{'O': 16433, 'B-interior': 23, 'I-interior': 13, 'B-urban': 11, 'I-urban': 13}
```

This means that we have a heavy `O` overrepresentation (which is expected and is very likely to happen to your dataset, too) and `B-rural`, `I-rural`, and `B-natural` underrepresentation. Note that this step is also helpful to get an idea of what type of language usage is more or less often in your corpus.

To address this, we will perform downsampling on `O` and upsampling on “`B-rural`, `I-rural`, and `B-natural` so that they are at a similar representation as the rest of the non-`O` categories. We will use the `resampleTrainingData` function to resample each category. You can ether use one resampling ratio for all minority categories or customize different ratios for each. Currently, the function supports resampling using the same ratio for all categories. Un-comment the relevant code lines indicated in the function to customize upsampling ratio. The function uses `1` as default parameter for both `upsampleRatio` and `downsampleRatio`, in case you do not need to perform one type of resampling operations.
```
import random

def resampleTrainingData(trainingDataList, labelIDDict, upsampleRatio=1, downsampleRatio=1):
    random.seed(20)

    labelsToUpsampleSetOne = {labelIDDict["B-natural"], labelIDDict["I-natural"], labelIDDict["B-rural"], labelIDDict["I-rural"]} # replace each string with your minority categories. For example, if you have a category called "spiritualWords" that is a minority category, you should have {labelIDDict["B-spiritualWords"], labelIDDict["I-spiritualWords"]} as "labelsToUpsampleSetOne". This set collects the label IDs in the "bioLabelToNumberDict" dictionary so we know which ones to upsample.

    labelsToDownsampleSet = {labelIDDict["O"]}  # replace each string with your own categories that are in the majoriies. In NER, usually the "Outside" category, or the category that is not labeled with any NER data category, is heavily in the majority

    entityLabeledDataList = [] # containing all windows with at least one labeled entity
    dataWithOnlyDownsampleIDs = [] # contains all windows that we will downsample
    dataToUpsampleListOne = [] # contains minority annotation categories that we will upsample

    # uncomment the line below and fill in "labelToUpsampleStepTwo" to upsample another minority category using another ratio
    '''
    labelsToUpsampleSetTwo = {}
    dataToUpsampleListTwo = []
    '''

    for oneDatapoint in trainingDataList:
        dataCategoryIDSet = set(oneDatapoint["labels"]) - {-100} # get all unique annotation labels and "O" labels
        if dataCategoryIDSet == labelsToDownsampleSet:
            dataWithOnlyDownsampleIDs.append(oneDatapoint)
        else:
            entityLabeledDataList.append(oneDatapoint)
            if dataCategoryIDSet & labelsToUpsampleSetOne:
                dataToUpsampleListOne.append(oneDatapoint)
            # un-comment the two lines below to upsample another minority category using another ratio
            '''
            elif dataCategoryIDSet & labelsToUpsampleSetTwo:
                dataToUpsampleListTwo.append(oneDatapoint)
            '''
    upsampledDataList = dataToUpsampleListOne * (upsampleRatio - 1)
    # un-comment the line below to upsample another minority category. Replace "2", a placeholder ratio with the upsample ratio you'd like for this data set
    '''
    upsampledDataList += dataToUpsampleListTwo * (2 - 1) 
    '''

    numberOfDownsampleIDsToKeep = int(len(dataWithOnlyDownsampleIDs) * downsampleRatio)

    downsampleIDDatapoints = random.sample(dataWithOnlyDownsampleIDs, numberOfDownsampleIDsToKeep)

    return entityLabeledDataList + upsampledDataList + downsampleIDDatapoints # + upsampleDataList
```
We will determine our resampling ratios here.

| default parameter | limits|
| --- | --- |
| `upsampleRatio` | must be a whole number > 1. Cannot be 0, negative number, or a decimal. Default at 1 (no upsampling) |
| `downsampleRatio` | must be a number between 0 and 1 (to represent a percentage of an over-represented category to keep. Can be a decimal. Cannot be negative number. Default at 1 (no downsampling) |
```
finalResampledTrainingDataList = resampleTrainingData(trainingDataList, bioLabelToNumberDict, upsampleRatio=5, downsampleRatio=0.3)
```

After resampling, we can see how our data has changed:

```
def countBioLabels(dataList):
    labelCounterDict = {}
    for oneDataPoint in dataList:
        for oneLabel in oneDataPoint["labels"]:
            if oneLabel == -100:
                continue
            labelCounterDict[numberToBioLabelDict[oneLabel]] = labelCounterDict.get(numberToBioLabelDict[oneLabel], 0) + 1
    return labelCounterDict

preResamplingLabelCounterDict = countBioLabels(trainingDataList)
postResamplingLabelCounterDict = countBioLabels(finalResampledTrainingDataList)
print("Before resampling: ", preResamplingLabelCounterDict)
print("After resampling: ", postResamplingLabelCounterDict)
```

The terminal printout should show the frequency of each annotation category before and after resampling. If you are not satisfied with the changes, you can revisit the ratios for upsampling and downsampling and change those values. You might need a few trial-by-error to get this right.

### Aside #1: What is a Hyperparameter?
So far, we have manually decided a few values: training/validation/testing data split ratio and data upsampling/downsampling ratio. These are values that only you, the domain expert, can decide, based on your familiarity with your corpora, domain, and research questions. Hyperparameters are architecturally determined values used to control how the model training process will take place. Data split and resampling ratios are some examples of hyperparameters used in model fine-tuning and training. We will encounter more hyperparameters in future steps.

Hyperparameters can greatly impact model performance. As seen in data resampling, changing just the upsample/downsample ratio number can completely alter your training data’s outlook. Thus, researchers should test different hyperparameter combinations throughout the training process.

Nevertheless, despite hyperparameters’ influence, the most important aspect in ensuring your model’s quality is our manually labeled training data. This goes back to Step 1, the iterative nature behind building our data schemas and operational definitions. These schema and definitions are always subject to change as you gain new information and understanding about your corpora, domain, and research question, even at the last step of our lesson.


### Step 12: Loading Dataset

After creating our training dataset, we need to load our dataset into the [HuggingFace Dataset](https://huggingface.co/docs/datasets/v2.1.0/en/access) object compatible with BERT.

First, rename our existing dataset to become compatible with the BERT and HuggingFace naming conventions.
```
def quickNameChange(trainingDatasetList):
    renamedData = {"input_ids": trainingDatasetList["inputIDs"], "attention_mask": trainingDatasetList["attentionMask"], "labels": trainingDatasetList["labels"]}
    return renamedData

renamedFinalResampledTrainingDataList = [quickNameChange(oneDatapoint) for oneDatapoint in finalResampledTrainingDataList]
renamedFinalValidationDataList = [quickNameChange(oneDatapoint) for oneDatapoint in validationDataList]
```
Then, cast our renamed datasets into the HuggingFace Dataset object and verify whether the final datatype for our reformatted training and validation datasets are of the type `<class 'datasets.arrow_dataset.Dataset'>` (shown through using `.type()` method) and have the features `['input_ids', 'attention_mask', 'labels']` (shown through printing both variable names directly.
```
import datasets

reformattedFinalTrainingDataset = datasets.Dataset.from_list(renamedFinalResampledTrainingDataList)
reformattedValidationTrainingDataset = datasets.Dataset.from_list(renamedFinalValidationDataList)

# check if we got it right
print("Training data datatype: ", type(reformattedFinalTrainingDataset)) 
print("Training data features: ", reformattedFinalTrainingDataset)
print("Validation data datatype: ", type(reformattedValidationTrainingDataset))
print("Validation data features: ", reformattedValidationTrainingDataset)
```

We will now write a data collation function, which batches our data.

### Step 13: Loading Training Metrics and Model

To batch our data, we will use the `collateData` function:
```
import torch
def collateData(trainingDataset):
    inputIDs = torch.stack([torch.tensor(oneDatapoint["input_ids"]) for oneDatapoint in trainingDataset])
    attentionMask = torch.stack([torch.tensor(oneDatapoint["attention_mask"]) for oneDatapoint in trainingDataset])
    labels = torch.stack([torch.tensor(oneDatapoint["labels"]) for oneDatapoint in trainingDataset])

    returnDict = {"input_ids": inputIDs, "attention_mask": attentionMask, "labels": labels}
    return returnDict
```

Then, we will import and load our model:
```
import transformers

bertTrainingModel = transformers.BertForTokenClassification.from_pretrained("bert-base-cased", num_labels=len(bioLabelToNumberDict))
```
We are using the `bert-base-cased` model, a case-sensitive model, because NER often contain proper nouns (which are often capitalized). The counterpart, `bert-base-uncased` does not consider capitalization. Other potential models include `bert-large-cased` (more parameters than `bert-base` but requires more computation). There are also many community-developed BERT models beside the ones that Google (where BERT was originally developed) has released designed for domain-specific corpus, such as `emanjavacas/MacBERTh`, developed by Enrique Manjavacas and Lauren Fonteyn and mentioned earlier in the lesson. If you know existing domain-specific BERT models in your domain, using them could provide more domain-specific nuance for your research than the generic BERT model. You can find other BERT models on HuggingFace's model [search interface](https://huggingface.co/models?search=bert) (make sure to carefully read the documentation for a model before using it to ensure its fit for your project and overall reliability).

We can also use non-English language models, if available. For instance, `bert-base-multilingual-cased` and `bert-base-multilingual-uncased` are two of the Google multilingual models. Examples of monolingual BERT models are `distilbert-base-german-cased` (a low-parameter BERT version for German), `dccuchile/bert-base-spanish-wwm-cased` (Spanish), `bert-base-chinese`, `camembert-base` (French), and others. 

And set the training hyperparameters. We will use the HuggingFace [Trainer](https://huggingface.co/docs/transformers/en/main_classes/trainer) API’s [TrainingArguments](https://huggingface.co/docs/transformers/v5.8.1/en/main_classes/trainer#transformers.TrainingArguments) method:
```
# this lesson lists the parameters line by line below
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

Now, create the metrics computation function.[^12] This function converts label IDs (numerical numbers) to label names and calculates the [precision, recall, F1, and accuracy metrics](https://developers.google.com/machine-learning/crash-course/classification/accuracy-precision-recall). We use the `seqeval` evaluation framework because it considers tokens in chunks, which is suitable for entity recognition tasks, as one entity name might span multiple tokens, rather than a token-by-token evaluation approach.
```
import evaluate
import numpy

metric = evaluate.load("seqeval")

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

Continuing using the Trainer API, we will initiate the trainer. The `.Trainer()` method brings together all the preparation that we have done so far.
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

Save both the fine-tuned model and tokenizer to your preferred directory (make sure to give the directory a meaningful name).

```
modelTrainer.save_model("./NERBERTfine-tuneVer1")
tokenizer.save_pretrained("./NERBERTfine-tuneVer1")
```

Training time (during `.train()`) varies greatly depending on data size, model, GPU availability, and others. It could take up to hours. Make sure to run the two `save_` methods right away so to not lose your progress after minutes or hours of training.

### Aside #2: Using Hyperparameters

This lesson specified a few default values for training hyperparameters in `.TrainingArguments()` method. You should experiment yourself based on your model performance and change them accordingly.

| Hyperparameter | Description |
| - | - |
| eval_strategy | determines when during training does the model use the validation set to evaluate its performance. Setting it to “epoch” means evaluating every epoch; “step” means every few training steps; “no” (default) means no evaluation |
| save_strategy | when during training does the model save checkpoints. It has the same three options as eval_strategy. Generally speaking, save_strategy and eval_strategy should have the same value, since this is required if we set load_best_model_at_end hyperparameter to True (see below). |
| learning_rate | size of step that the model takes when changing weights during training. A value too big risks overshooting; too small risks underfitting or long training time. Some options: 1e-5, 2e-5, 3e-5 |
| per_device_train_batch_size | how many batches are processed at once. Larger number requires more memory storage. If you receive an Out-of-Space error, try decreasing the batch size. Some common (but not all) options: 4, 8, 16 |
| per_device_eval_batch_size | same as above, but for validation data and not training data. Generally speaking, per_device_train_batch_size and per_device_eval_batch_size should have the same value to have equal comparison, but this is not required |
| num_train_epochs | how many epochs does the training process use. One epoch equals the model “reading” the dataset once. Larger epoch number risks overfitting; lower epoch risks underfitting. Some common (but not all) options: 2, 4, 8, 10 |
| weight_decay | attempt to standardize weights by decreasing large training weights. This is helpful for tasks like NER, where we often have imbalanced datasets. Higher decay risks not learning meaningful patterns; lower decay risks overfitting. Some common (but not all) options: 0.1, 0.01, 0.001 |
| load_best_model_at_end | which model training checkpoint will be the final outputted model. If True, then it will output the best. You should always set it to True |
| metric_for_best_model | how the model determines which checkpoint is the best. The options “f1”, “accuracy”, and “precision” refer to which of these three values the model will use to determine this |

### Step 15: Evaluate Your Model

After fine-tuning and saving our model, we will manually evaluate its performance, regardless of whether we used testing dataset. Because of the complex nature of human language and historical context, domain experts should always qualitatively review model performance.

To do so, first find where you have saved your model and load it:
```
fineTunedModel = transformers.BertForTokenClassification.from_pretrained("./NERBERTfine-tuneVer1")
fineTunedTokenizer = transformers.BertTokenizerFast.from_pretrained("./NERBERTfine-tuneVer1")

fineTunedModel.eval() # set to inference mode
```
Replace “NERBERTfine-tuneVer1” with the folder path of your fine-tuned model.

Then add this inference function that will take in unseen raw text as a string, split it into 512-token windows, and perform prediction. We will use the default parameter `showProbabilitiesAtInference=` during testing in the following step. For now, leave this to False
```
rawText = "i went into a building" # text to perform entity recognition on 
overlapInt = 30 # use your own overlap number from Step 10
windowLength = 512 # this is BERT's window length. Change this to your own window length

predictedNERs = runEntityInference(rawText, overlapInt, windowLength=windowLength, showProbabilitiesAtInference=False)
print(predictedNERs)
```
Then, set the unseen text into one string and determine the number of overlap tokens. Set `overlapInt` to the window overlap value that you did in Step 10’s `turnLabeledDataIntoBioFormat` function. 

```
rawText = “” # text to perform entity recognition on 
overlapInt = 30 # use your own overlap number from Step 10
windowLength = 512 # BERT's window length. Change this to your own window length

predictedNERs = runNERInference(rawText, overlapInt, windowLength=windowLength, showProbabilitiesAtInference=False)
```

### Step 16: Test and Repeat

Manually review the prediction output from Step 15 and decide whether you need to edit the hyperparameters. Most often, you need to run the training process at least two times to compare which hyperparameter combination is the most suitable for your model. One occasion that is very likely to happen is the fine-tuned model labeling many elements as `O`, since "Outside" is the most common category. To test whether your model is actually trying to categorize terms into your desired categories, we can run a quick test using the following code.

This code prints the probability that the model labels a term as Outside and the highest entity recognition category. The model will label a term as an entity if an entity's probability is the highest of all probabilities. Otherwise, it will label the term as Outside. Use a short text, maybe one or two sentences (less than your window length characters, whether that is 512 or another value), to test the model. 
```
shortRawText = "" # must be less than the window length. Try a sentence or two at once

for word, label, outsideProbability, bestEntity, bestEntityProbability in runNERInference(rawText, overlapInt, windowLength=windowLength, showProbabilitiesBool=True):
    print(f"{word}, label={label}, 'Outside' probability={outsideProbability}, best entity={bestEntity} ({bestEntityProbability})")
```
Look for situations where a term that should be a non-named entity has a high "best entity" probability, even if the model does not label the term as such. This can still mean that the model is learning in the right direction.

In addition, actively review whether your NER data schema and operational definitions are still sound. Fine-tuning BERT (or any other language models) for research is not a linear process but an iterative one where we will constantly revisit the very first step in this process. The model quality will increase as you increase the dataset more through using existing NER dataset or annotating more of your corpus.

The lesson's sample dataset should be treated as just an example. Your data annotation should, ideally, contain many more data points.

### Technical Material Source Acknowledgement

Today, many sources provide similar technical tutorials for BERT NER fine-tuning, since the code to do so is, after all, very similar in spirit and that many coding techniques are interchangeable. This lesson's contribution is less so on the technical implementation but the iterative nature of research and customizing our own NER data schema.

This lesson benefitted from sources like Medium posts by [DamenC](https://medium.com/@cd_24/fine-tuning-bert-for-custom-named-entity-recognition-in-google-colab-a-step-by-step-guide-6c140e2b87c5), [Maneyogesh](https://medium.com/@maneyogesh065/fine-tuning-biobert-for-custom-named-entity-recognition-a-complete-guide-a05b124edda0), and [why amit](https://medium.com/@whyamit101/fine-tuning-bert-for-named-entity-recognition-ner-b42bcf55b51d), Argilla’s [BERT NER tutorial](https://docs.v1.argilla.io/en/latest/tutorials/notebooks/ner_fine_tune_bert_beginners.html), HuggingFace’s [transformers fine-tuning guide](https://huggingface.co/docs/transformers/en/training), Google for Developers's [machine learning guides](https://developers.google.com/machine-learning), and Claude Sonnet 4.6 free version to plan the lesson's code. Because each person's dataset and situation is different, you are encouraged to compare other BERT fine-tuning workflows to find the one that best suits your research.

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

[^10]: If you are a Mac user accustomed to using the “Command” instead of “Control” key, you still need to use “Control” when working with the terminal. 

[^11]: Note that we are treating our manual annotation as gold standard (often because there does not exist another dataset that fits the needs of a specific research genre or question). This is why domain specialty and Step 1’s iterative process is important so that the annotator (us) can ensure data quality.

[^12]: This metrics computation function is borrowed from the BERT fine-tuning tutorial from Argilla, an open-source data curation platform. Argilla, “Fine-tunning a NER model with BERT for Beginners,” *Argilla*, https://docs.v1.argilla.io/en/latest/tutorials/notebooks/ner_fine_tune_bert_beginners.html. Accessed May 13, 2026.
