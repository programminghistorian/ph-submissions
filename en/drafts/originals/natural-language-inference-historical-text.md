---
title: "Natural Language Inference for Historical Text Analysis Using Python"
collection: lessons
layout: lesson
slug: natural-language-inference-historical-text
authors:
- Laura Nelson
- Jonathan Graves
- Kaiyan Zhang
- Alex Ronczewski
- Irene Berezin
date: YYYY-MM-DD
reviewers:
- Forename Surname
- Forename Surname
editors:
- Laura Alice Chapot
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/699
activity: analyzing
difficulty: 3
topics: [python, distant-reading, machine-learning]
abstract: This lesson demonstrates how to use zero-shot Natural Language Inference (NLI) classification in Python to assess authorial stance in historical legal texts, using nineteenth-century British Columbia court rulings on Chinese immigration as a case study. It covers preparing a corpus (including removing quoted passages with fuzzy string matching), designing classification labels, running sentence and window-level classification, validating against a manually labelled evaluation sample, and applying robustness checks.
mathjax: true
avatar_alt: Visual description of lesson image.
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

This lesson teaches you how to apply [Natural Language Inference (NLI)](https://en.wikipedia.org/wiki/Textual_entailment) in Python to assess an author's stance in historical documents. The case study is a set of nineteenth-century British Columbia legal texts about Chinese immigration, but the workflow can be adapted to other historical corpora where you want to assess authorial stance computationally.

NLI is a task in which a model reads two pieces of text and judges how they relate. The first text is the *premise*: in this lesson, a passage from a historical document. The second text is the *hypothesis*: a short statement written by the researcher, such as "In this snippet of a historical legal text, the author advocates for equal legal treatment of Chinese immigrants." The model then judges whether the premise *entails* the hypothesis (the passage supports the statement), *contradicts* it, or is *neutral* towards it. Note that these three NLI relations are not the same as the three stance labels used later in this lesson (`Pro`, `Neutral`, and `Cons`). For zero-shot classification, only the entailment score is used, as explained below.

This lesson uses NLI for *zero-shot classification*. A classifier sorts texts into categories, which are called *labels*. Most classifiers learn their labels from a training set of examples that people have already sorted by hand. A zero-shot classifier needs no such examples ("zero" training examples for your categories). Instead, you write a short description for each label, turn each description into a hypothesis, and ask an NLI model which hypothesis the passage supports most strongly. This matters for historical research, where hand-labelled training data rarely exists and is expensive to create, and where each new research question would otherwise need a new training set.

### Why NLI?

A simple way to measure stance count be by counting words: tally discriminatory or rights-affirming terms and compare authors. This is the logic behind domain-specific lexicons such as the Loughran-McDonald dictionary in financial text analysis, which counts curated word lists tailored to a domain rather than relying on general-purpose sentiment polarity.[^11] But keyword counting has a decisive blind spot for our question: it cannot tell the difference between a judge who *uses* a discriminatory word and one who *quotes it to condemn it*. The word "alien" counts the same whether the Act imposes it or Crease attacks it, and stance-bearing phrases such as "fills one with alarm" or "rule the country" use common words that no lexicon would flag. Stance depends on how words are combined and framed, which is the kind of comparison NLI is designed to make.

NLI is a practical middle ground for historical corpora. Supervised models need large labelled datasets that most historians do not have, and lexicon or topic methods often miss stance direction.[^12][^13] NLI instead scores whether a passage supports researcher-defined hypotheses, so you can run three-way stance classification without retraining.[^14]

### How Zero-Shot NLI Works

Zero-shot NLI classification works in three steps:

1. **Define the labels:** In this lesson there are three labels: `Pro`, `Neutral`, and `Cons`. Each label has a short name, used in tables and figures, and a longer description that says what the label means, such as "advocates for equal legal treatment of Chinese immigrants" (shortened here; the full descriptions are given in [Designing Effective Labels](#designing-effective-labels).
2. **Turn each label into a hypothesis:** A *hypothesis template* is a sentence with a gap, such as "In this snippet of a historical legal text, the author {}." Each label description is inserted into the gap, which produces one hypothesis per label.
3. **Score the premise against every hypothesis:** The NLI model pairs the passage with each hypothesis in turn and calculates how strongly the passage entails it. The scores are then rescaled so that the three label scores for a passage add up to 1. The label with the highest score is the model's prediction.

For example, take this sentence from Crease's ruling in *R v. Wing Chong* as the premise: "The treaties I have quoted between Great Britain and China, binding on the Dominion and on us in British Columbia, secure to the Chinese, just as the treaties between Great Britain and other foreign countries secure to other foreigners, the same rights in regard to the equality of taxation which I have described as being enjoyed by citizens of this country." Paired with the `Pro` hypothesis, "In this snippet of a historical legal text, the author advocates for equal legal treatment of Chinese immigrants", a historian would read the passage as supporting the hypothesis. If the model reads it the same way, the `Pro` hypothesis receives the highest score and the sentence is classified as `Pro`. Whether the model actually agrees with a human reader is something you cannot assume, which is why the lesson later checks its predictions against hand-labelled examples (see [Validating Against a Manually Labelled Evaluation Sample](#validating-against-a-manually-labelled-evaluation-sample).

The main advantage of this approach is flexibility: you can define any set of labels without training a new model. The main risk is that the results depend heavily on how you phrase those labels, which is why the lesson spends time on label design and checks how sensitive the results are to wording.

The lesson is organised into four stages:

1. **Data preparation:** load the corpus, detect and remove directly quoted passages that could distort the analysis, and extract passages relevant to the research question.
2. **Stance classification:** design labels and run zero-shot NLI at both the sentence and window level.
3. **Evaluation and robustness:** validate predictions against a manually labelled set and stress-test them with quote, label, and bootstrap checks.
4. **Interpretation:** read the results critically and adapt the workflow to other corpora.

### Lesson Goals

By the end, you will be able to:

- Detect and remove direct quotations using fuzzy string matching
- Extract topically relevant passages from a corpus by keyword
- Apply zero-shot NLI classification to assess stance without labelled data
- Design effective classification labels for historical text analysis
- Validate model outputs against a manually labelled evaluation sample
- Apply robustness checks (quote sensitivity, label sensitivity, bootstrap confidence intervals) to assess result stability
- Critically evaluate NLP results against domain knowledge

## Prerequisites

To follow this lesson, you will need intermediate Python experience: working with pandas, reading and understanding functions, and installing packages. This lesson uses pip, but readers who work with other package managers, such as `conda`, can adapt the installation steps to their own setup. If you are newer to Python, start with the [_Programming Historian_'s Introduction to Python](https://programminghistorian.org/en/lessons/introduction-and-installation). You do not need prior experience with transformer models, NLI, or the validation and bootstrap steps used later; the lesson introduces each of these where it appears. Some familiarity with NLP methods such as word embeddings and similarity measures will be helpful. Readers who want more background can consult Programming Historian lessons on ["Understanding and Creating Word Embeddings"](https://programminghistorian.org/en/lessons/understanding-creating-word-embeddings) and ["Understanding and Using Common Similarity Measures for Text Analysis"](https://programminghistorian.org/en/lessons/common-similarity-measures).


The lesson was tested with Python 3.13, but it is expected to work with 3.10 or later. Because the lesson uses transformer models, you will need at least 8GB of RAM. A GPU or iGPU is not required, but it can speed up model inference. 

Running every zero-shot classification step from scratch can take 60 to 90 minutes on CPU, so the lesson offers two paths: you can run the scoring code yourself, or you can load the precomputed CSV outputs that are included in the data files. For each of the most computationally intensive steps, the lesson will clearly indicate both paths.

If you have NVIDIA CUDA, PyTorch can use it automatically for acceleration. On some Windows systems with AMD or Intel integrated GPUs, <code>torch-directml</code> may help, but stability varies by model. The lesson code runs on CPU by default and uses GPU acceleration only when PyTorch detects it.


## Software and Setup

First, install all required Python packages. These packages support different parts of the workflow: `pandas` and `numpy` handle tables and numerical operations, `nltk` and `spacy` split texts into sentences, `transformers` and `torch` run the NLI model, and `matplotlib` and `seaborn` make the figures. Run this in your terminal:

```bash
pip install pandas numpy matplotlib \
  nltk spacy transformers torch 
  
```

In the next two steps you will download language processing resources that will be used for sentence splitting later in the lesson. The NLTK tokenizer data will be used to split text into sentences when building larger window-level passages. Download the NLTK tokenizer data **inside Python**:

```python
import nltk
nltk.download('punkt')
nltk.download('punkt_tab')
```

You will also use spaCy’s small English model to segment text into sentences during the quotation removal and keyword filtering stages. Then download the English spaCy model **from the terminal**:

```bash
python -m spacy download en_core_web_sm
```

The spaCy model `en_core_web_sm` and the DeBERTa NLI model used in this lesson are both English language models. If your corpus is in another language, see [Working with Other Languages](#working-with-other-languages) for further guidance.

**Optional: Windows GPU acceleration**

For AMD or Intel integrated GPU acceleration on Windows, also run this in your terminal:

```bash
pip install torch-directml
```

### Software Versions

This lesson was tested with:

- Python 3.13
- transformers 4.51
- torch 2.6
- DeBERTa NLI: `MoritzLaurer/deberta-v3-large-zeroshot-v2.0` (Hugging Face)

Now that you have installed the packages and language resources, load the libraries used throughout the lesson. `os` and `difflib` are part of Python's standard library, so they do not need to be installed. `os` is used to build file paths when saving cleaned texts, and `difflib` is used in the data preparation section for fuzzy string matching. `hf_logging` controls how many status messages the `transformers` library prints; you will use it when setting up the NLI pipeline.

```python
import os
import difflib

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from nltk import sent_tokenize
import spacy
import torch
from transformers import AutoTokenizer, pipeline
```

## Case Study: Chinese Immigration Law in British Columbia

While the techniques demonstrated in this lesson are general-purpose, you will go through a case study that provides concrete material to work with.

**A note on language**: This lesson reproduces historical racist terminology from the source documents (*Chinaman*, *Chinamen*, *coolie*, *heathen*, and *alien* in its nineteenth-century legal context). These terms appear in direct quotations, keyword lists, and the code cells because accurate computational analysis of nineteenth-century anti-Chinese legislation requires working with the source vocabulary. They are presented here as historical evidence.

The *1884 Chinese Regulation Act*[^1] in British Columbia (a province on the Pacific coast of Canada) was provincial legislation targeting Chinese residents, part of a broader wave of anti-Chinese laws across western North America in the late nineteenth century. It was challenged and declared unconstitutional in the 1885 case of *R v. Wing Chong* by [Henry Pering Pellew Crease](https://www.biographi.ca/en/bio/crease_henry_pering_pellew_13E.html), a judge on the Supreme Court of British Columbia.[^2] Justice Crease struck down the legislation on economic grounds, finding that it infringed on federal authority over immigration, trade, commerce, and taxation. In Commonwealth legal naming convention, *R* (or *Regina*, Latin for 'the Queen') denotes a criminal or constitutional case brought by the Crown against a private party.

However, Crease was not considered straightforwardly sympathetic to Chinese immigrants. Historian Tina Loo notes that he displayed mistrust towards Chinese residents, referred to them as "North American Chinamen", and feared they would "rule the country and job its offices".[^3] The apparent inconsistency between Crease's rhetoric and his political position raises a question difficult to answer through selective quotation alone: how did he discuss Chinese immigrants across his broader body of writing? And what methods can we use to better understand whether his opposition to the Act was rooted in principled objections to discrimination, or in a belief that Chinese immigrant labour was necessary for economic development?

To explore this question computationally, you will compare the language of Crease's rulings with two reference points: the discriminatory Act itself, and Justice [Matthew Baillie Begbie](https://www.biographi.ca/en/bio/begbie_matthew_baillie_12E.html),[^4] the first Chief Justice of British Columbia. Unlike Crease, historical accounts describe Begbie as protective of marginalized peoples, including Chinese immigrants.[^5][^6] Begbie struck down discriminatory municipal by-laws in Victoria targeting Chinese-owned businesses in the 1888 case of *R v. Victoria*.[^7]

The analysis compares four court rulings, two by Crease (*R v. Wing Chong*[^2] and *Wong Hoy Woon v. Duncan*,[^8]) and two by Begbie (*R v. Mee Wah*[^9] and *R v. Victoria*[^7]), with the text of the *1884 Chinese Regulation Act*. The full corpus we use has ten digitized texts. Besides the five just listed (two court rulings by Crease, twyo by Begbie, the the Act), the corpus includes Crease's and Begbie's reports to the 1884 Royal Commission on Chinese Immigration,[^10] two further documents connected to that Commission (by Chapleau and by Powell), and a later Superme Court of Canada ruling by Chief Justice Charles Fitzpatrick (*Quong Wing v. The King*). These five additional texts are included as background material, but they are not part of the stance comparison. The [Preparing the Corpus](#preparing-the-corpus) section explains how they are set aside.

The texts were converted from archival scans to machine-readable format using [Optical Character Recognition (OCR)](https://en.wikipedia.org/wiki/Optical_character_recognition). Direct quotes of the Act within Crease's ruling were identified using fuzzy string matching and removed so they do not contaminate the analysis of his own language. This process is described in the corpus preparation section.

## Downloading the Data

Download the lesson data files from the [_Programming Historian_ repository](https://github.com/programminghistorian/ph-submissions/raw/gh-pages/assets/natural-language-inference-historical-text/data.zip). Create a `data/` directory in your working folder and place all files there. The dataset includes:

- `data/core/metadata_cleaned.csv` -- a table with one row for each of the ten source documents, recording its author, document type, and full text. The texts in this table have already had direct quotations of the Act removed.
- `data/texts/analytic/` -- the ten original OCR-transcribed texts, one .txt file per document, before quotations were removed
- `data/texts/quotations_removed/` -- cleaned versions of the four court rulings, produced with the quotation-removal code in this lesson. Running that code yourself saves your own cleaned files to this folder.
- `data/core/labelled_snippets.csv` -- 45 sentence excerpts hand-labelled for evaluation by one of the lesson co-authors
- `data/results/` -- precomputed model outputs (the sentence-level and window-level scores, the evaluation predictions, and the label sensitivity summary), so that you can follow the lesson without running the slowest steps

These sources are nineteenth-century British Columbia legal and government documents in the public domain. Openly accessible copies are available without login through UBC Open Collections, Canadiana, the Internet Archive, and BC Laws. We produced the text files by running modern OCR on those scans and organising the results. The OCR transcriptions and derived data files in this lesson are shared under a Creative Commons Attribution (CC BY 4.0) license.

## Preparing the Corpus

In this section, you will prepare the corpus for analysis. You will:
- load the pre-prepared corpus file and create comparison groups based on authorship and document type; 
- identify and remove direct quotations that could distort the stance analysis; 
- and select passages relevant to Chinese immigration.

After OCRing the source documents, we created a CSV file, `metadata_cleaned.csv`, in which we organised the OCR-transcribed text alongside basic metadata relevant to the analysis. This file contains one row for each source document and records the information needed to analyse the corpus, namely:

| Column Name                 | Description                                        |
| --------------------------- | -------------------------------------------------- |
| filename                    | Name of the source document file                   |
| author                      | Author (e.g., "Crease", "Begbie")                  |
| type                        | Document type (e.g., "case", "report", "act")      |
| text                        | Full text, which may include OCR errors             |
| act_quote_sentences_removed | Number of quoted sentences removed from the text   |

Next, you will create the comparison groups that you want to use in your analysis. Since this lesson compares the language of Crease, Begbie, and the Act, you will be grouping documents by author (for Crease and Begbie) and document type (for the Act). 

First, load the metadata CSV into a `pandas` DataFrame. Then create a new `group` column and assign each document to one of the comparison groups. The code starts by labelling every document as `Other`, then replaces that label for documents by Crease, documents by Begbie, and the Act using the author and type columns. The Act is given the short name `Act 1884`, which is stored in the variable `ACT_LABEL` so that the same name is used in every table and figure later in the lesson.

```python
df = pd.read_csv("data/core/metadata_cleaned.csv")

ACT_LABEL = "Regulation Act"

df["group"] = "Other"
df.loc[df["author"] == "Crease", "group"] = "Crease"
df.loc[df["author"] == "Begbie", "group"] = "Begbie"
df.loc[df["type"] == "act", "group"] = ACT_LABEL
```

Check how many documents fall into each group before going further:

```python
df["group"].value_counts()
```

Expected output:

```text
Crease            3
Begbie            3
Other             3
Regulation Act    1
Name: group, dtype: int64
```

This check confirms that the comparison groups are in place before any model scores are calculated. Crease and Begbie each have three texts: two court rulings and one report to the Royal Commission. The Act has one text. The three `Other` texts are the Fitzpatrick ruling and the two Commission documents by Chapleau and Powell.

The stance comparison in this lesson uses only the four court rulings and the Act. The reports and the `Other` texts are kept in the data because they help situate the rulings historically, and five snippets from Royal Commission material appear in the evaluation sample later in the lesson. They are left out of the stance comparison because the research question is about how the judges wrote in their rulings; mixing in a different genre, such as Commission reports, would make the comparison between authors less even. If you adapt this workflow, decide early which documents answer your research question and which are background, and filter your corpus accordingly.

### Detecting and Removing Direct Quotations

Crease's ruling in *R v. Wing Chong* quotes passages from the 1884 Chinese Regulation Act verbatim. If these quoted passages remain in the corpus, the NLI model will classify them as language attributable to Crease, when in fact they are the Act's own words that Crease cited.

Quotation removal is a necessary data preparation step because stance classification asks "what does *this author* say?" Even if Crease quotes a passage from the Act in order to strike it down, the NLI model may still treat those quoted words as part of Crease’s own language. Removing direct quotations helps prevent the model from attributing the Act’s language to Crease.

The approach uses fuzzy string matching via Python's [`difflib.SequenceMatcher`](https://docs.python.org/3/library/difflib.html), which computes a similarity ratio between two strings based on the longest contiguous matching subsequences. Exact string matching would be too weak here: the texts were produced by OCR, so a sentence Crease quotes from the Act and the same sentence in the Act itself rarely match character-for-character. Small transcription differences (a misread letter, a dropped word, inconsistent punctuation) would defeat an exact-match filter while leaving the quotation in place. Fuzzy matching tolerates this noise by scoring *how similar* two sentences are rather than demanding they be identical. For each sentence in Crease's text, you compute its similarity to every sentence in the Act and retain the highest score.

The following code prepares the quotation-matching process. First, it loads spaCy's English model and uses it to split the Act into sentences, keeping only sentences longer than 20 characters so that headings and stray fragments are ignored. These Act sentences will serve as the reference set. The code then reads the original text of *R v. Wing Chong* and defines a function, `compute_quote_similarity()`, which compares one sentence against every sentence in the reference set and returns the highest similarity score. The comparison is made in lower case so that differences in capitalisation do not affect the score.

```python
nlp = spacy.load("en_core_web_sm")

regulation_act_text = df.loc[df["type"] == "act", "text"].iloc[0]
regulation_act_sents = [
    s.text.strip()
    for s in nlp(regulation_act_text).sents
    if len(s.text.strip()) > 20
]

crease_orig_path = "data/texts/analytic/Regina_V_Wing_Chong.txt"

with open(crease_orig_path, encoding="utf-8") as f:
    crease_orig = f.read()

def compute_quote_similarity(sent, reference_sents):
    best = 0.0
    s_lower = sent.lower()

    for ref in reference_sents:
        ratio = difflib.SequenceMatcher(None, s_lower, ref.lower()).ratio()
        if ratio > best:
            best = ratio

    return best
```

Next, score Crease's sentences against the Act. The code below splits Crease’s text into sentences, scores each sentence against the Act sentences, stores the results in a table, and sorts the table so that the highest-scoring matches appear first:

```python
crease_sents = [
    s.text.strip()
    for s in nlp(crease_orig).sents
    if len(s.text.strip()) > 20
]

quote_scores = pd.DataFrame(
    {
        "sentence": crease_sents,
        "similarity": [
            compute_quote_similarity(sent, regulation_act_sents)
            for sent in crease_sents
        ],
    }
)

quote_scores.sort_values("similarity", ascending=False).head()
```

The resulting score ranges from 0 to 1. A score close to 1 means that the sentence is very similar to a sentence in the Act, and is therefore likely to be a direct quotation or near quotation. A lower score suggests that the sentence is less similar to the Act’s wording. Expected output:

| similarity | sentence |
| ---: | --- |
| 0.99 | In case any employer of Chinese fails to deliver to the collector the list... |
| 0.99 | Any collector or Government servant wilfully disobeying any of the provisions... |
| 0.99 | Every employer of Chinese shall furnish to the collector when requested... |
| 0.97 | Proof of the lawful possession of such receipt shall lie on the person... |
| 0.93 | Every collector shall collect the tax from each Chinese... |

Inspecting the highest-scoring rows helps you choose a threshold instead of treating it as a hidden parameter. Set it too high and quoted material survives to contaminate the stance scores; set it too low and you erase the author's own language.

In this case, we set the threshold to 0.6. A threshold of 0.6 catches near-exact quotes (accounting for OCR errors) while leaving Crease's own paraphrases intact. A lower threshold such as 0.4 also catches loose paraphrases but risks discarding original sentences that merely share legal vocabulary with the Act.

The following code applies the threshold. It keeps only the sentences whose similarity score is below 0.6 and then prints two numbers: how many sentences the text had before quotation removal, and how many remain afterwards.

```python
quote_threshold = 0.6
cleaned_crease_sents = quote_scores[
    quote_scores["similarity"] < quote_threshold
]["sentence"].tolist()

len(crease_sents), len(cleaned_crease_sents)
```

Expected output:

```text
(218, 206)
```

The threshold removes 12 of the 218 sentences in *R v. Wing Chong*. This matches the `act_quote_sentences_removed` column in the metadata, which records how many sentences were removed from each document.

Next, save the cleaned text so that you can use it later. The code below joins the remaining sentences back into a single text, separating them with spaces, and writes it to the `data/texts/quotations_removed/` folder under the same file name as the original. The `os.makedirs()` line creates the folder if it does not already exist.

```python
output_dir = "data/texts/quotations_removed"
os.makedirs(output_dir, exist_ok=True)

cleaned_crease_text = " ".join(cleaned_crease_sents)

with open(
    os.path.join(output_dir, "regina_v_wing_chong.txt"),
    "w",
    encoding="utf-8",
) as f:
    f.write(cleaned_crease_text)
```

Joining sentences with spaces removes the original paragraph breaks. This does not affect the analysis, because every later step splits the texts into sentences again.

We applied the same process to the other three court rulings in the stance comparison. *R v. Wing Chong* was the only text from which Act quotations were removed: the other rulings contained no sentences above the 0.6 threshold, so their `act_quote_sentences_removed` value is 0. We then placed the cleaned texts in the `text` column of `metadata_cleaned.csv`, which is why the rest of the lesson can load them directly from the DataFrame `df`. You can confirm this by checking that one of the quoted Act sentences no longer appears in the stored text of *R v. Wing Chong*:

```python
wing_chong_text = df.loc[
    df["filename"] == "regina_v_wing_chong.txt", "text"
].iloc[0]

"In case any employer of Chinese fails" in wing_chong_text
```
Exptected output:

```text
False
```

If you are working with your own corpus, you can repeat the scoring, threshold, and saving steps for each document, then load the cleaned files from your `quotations_removed` folder into a DataFrame in the same way. The same `compute_quote_similarity` function is reused later as a sensitivity check (see [Quote Sensitivity](#quote-sensitivity), where you test several thresholds to confirm that leftover quotations are not driving the results.

#### Checking the Threshold

For your own analyses, experiment with different thresholds to see which one best separates quotation from original language in your corpus.

For a small corpus, the most reliable check is still a human one: inspect sentences near the cutoff. These are the cases where the algorithm is least certain and where a small threshold change would alter which sentences remain in the corpus.

The following code selects sentences with similarity scores between 0.55 and 0.65, just below and just above the threshold of 0.6. It then sorts them from highest to lowest similarity so that you can inspect the borderline cases:

```python
near_threshold = quote_scores[
    quote_scores["similarity"].between(0.55, 0.65)
].sort_values("similarity", ascending=False)

near_threshold[["similarity", "sentence"]].head(10)
```

Expected output:

| similarity | sentence |
| ---: | --- |
| 0.64 | Section 16 amends the License Ordinance of 1867... |
| 0.64 | By Sec. 5 "Any Chinese who shall be found within the Province..." |

Only two sentences fall in this band. Both score just above 0.6, so both were removed, and both summarise or quote sections of the Act rather than stating Crease's own argument. This suggests that the 0.6 threshold is reasonable for this text, because the borderline cases are still closer to quoted or cited Act language than to Crease's own stance.

Read this table before accepting the threshold. If the rows just above 0.6 are quoted Act language and the rows just below 0.6 are Crease's own argument, the threshold is doing what you need. If both sides contain a mixture of quotations, paraphrases, and original legal language, report that uncertainty and consider a more conservative threshold.

`SequenceMatcher` is useful here because it is part of the Python standard library and easy to explain. It also has limits. Short legal formulas can look similar even when they are not quotations, and OCR errors can reduce similarity for real quotations. For a larger or noisier corpus, you might compare this approach with token-based fuzzy matching, shared n-gram overlap, or embedding similarity. Those alternatives add dependencies and interpretation work, so they are better treated as extensions rather than the default path through this lesson.

### Identifying Relevant Passages

Now that the texts are free of direct Act quotations, you can select the passages to classify. Zero-shot classification is computationally expensive, so rather than scoring every sentence in every document, you focus the analysis on the passages that discuss Chinese immigration. The strategy is to split the texts into sentences and keep those that mention immigration-related keywords. These keyword sentences, which this lesson calls *snippets*, become the unit of analysis for the sentence-level classifier, while the full documents are reused for window-level classification later.

The following code builds the set of snippets that will be classified at the sentence level. It takes the texts from the `text` column of `df`, which, as shown in the previous section, already contains the quotation-removed versions. First, it selects the court rulings by Crease and Begbie (rows where `type` is `case`) and the text of the Act. As explained in [Preparing the Corpus](#preparing-the-corpus), the reports and the `Other` texts are left out at this point. It then stores these texts in a dictionary, `corpus_by_author`, so that each group can be processed in the same way. Next, it defines a list of immigration-related keywords. Finally, it loops through each text sentence by sentence, using the spaCy model loaded earlier, and keeps any sentence that contains one of those keywords. The keyword check is made on a lower-case copy of each sentence, so "Chinese" and "chinese" both match.

```python
crease_cases = df[
    (df['author'] == 'Crease') & (df['type'] == 'case')
]['text'].tolist()
begbie_cases = df[
    (df['author'] == 'Begbie') & (df['type'] == 'case')
]['text'].tolist()
regulation_act_texts = df[df['type'] == 'act']['text'].tolist()

corpus_by_author = {
    'Crease': crease_cases,
    'Begbie': begbie_cases,
    ACT_LABEL: regulation_act_texts,
}

keywords = [
    "chinese", "china", "chinaman",
    "chinamen", "immigrant", "immigrants",
    "alien", "aliens", "immigration",
]

keyword_snippets = {}
for author, texts in corpus_by_author.items():
    snippets = []
    for text in texts:
        for sentence in nlp(text).sents:
            sentence_text = sentence.text.strip()
            sentence_lower = sentence_text.lower()
            if any(keyword in sentence_lower for keyword in keywords):
                snippets.append(sentence_text)
    keyword_snippets[author] = snippets
```

`keyword_snippets` is a dictionary with one entry for each comparison group. For example, `keyword_snippets['Crease']` is a list of the sentences from Crease's rulings that include at least one of the keywords. Check how many snippets each group has:

```python
{author: len(snippets) for author, snippets in keyword_snippets.items()}
```

Expected output:

```text
{'Crease': 83, 'Begbie': 18, 'Act 1884': 24}
```

Crease has many more snippets than Begbie, partly because his ruling in *R v. Wing Chong* is long and discusses the Act section by section. Keep this imbalance in mind: averages for Begbie are based on far fewer sentences, which makes them less certain. Depending on your version of spaCy, your counts may differ by a few sentences, because different versions split some sentences differently.

Keyword filtering is deliberately simple and high-recall: it casts a wide net so that few relevant passages are missed, and the NLI model does the discriminating work of judging stance later. The `corpus_by_author` dictionary is kept alongside the snippets because the window-level analysis needs the full document text, not just the extracted sentences.

With the corpus cleaned and the relevant passages selected, the data preparation stage is complete. The next section turns to the core of the lesson: using an NLI model to score the stance of these passages.

## Stance Classification with Zero-Shot NLI

Now that you have prepared the corpus for analysis, you will move on to zero-shot stance classification. This involves three main steps: choosing an NLI model, translating the research question into labels and hypotheses the model can evaluate, and applying the classifier at two scales: individual keyword-selected sentences and larger windows of surrounding text.

### Choosing a Model for Historical Text

Model selection matters in any NLP pipeline, especially for historical texts. Two checks matter most: whether the training data is close to your corpus, and whether the model was designed for your task.

This lesson uses [DeBERTa NLI (v2.0)](https://huggingface.co/MoritzLaurer/deberta-v3-large-zeroshot-v2.0) for zero-shot classification. It is tuned for entailment tasks and performs strongly when labels are expressed as explicit hypotheses.[^15]

When choosing models for your own historical corpus, consider:

- Does the model's training data overlap with your domain? A general-purpose model may lack specialised vocabulary, while a domain-specific model trained on modern legal text may not understand nineteenth-century usage of terms like "alien".[^16]
- Is the model designed for your task? Use NLI-fine-tuned models for zero-shot classification rather than general-purpose language models.
- Test with known examples. Pass excerpts where you already know the expected result and check whether the model's output aligns with your domain knowledge.

For a publishable analysis, also record the exact model identifier, the date you ran it, and the main inference settings. Hugging Face models can change, and two models with similar names may behave differently. In production work you would usually pin a model revision; in this lesson, save enough information that another reader can tell which model produced the CSV files.

#### The Lexicon Mismatch Problem

A central challenge is lexical drift: words in nineteenth-century legal writing can carry meanings that differ from modern usage. OCR noise adds another layer of uncertainty. There is no complete fix, but you can reduce risk by:

- Verify that key terms in your corpus appear in the model's vocabulary
- Compare model outputs against passages where the expected stance is clear
- Treat all computational results as hypotheses that require human validation, not as conclusions

### Designing Effective Labels

Label design is a form of prompt engineering. Vague labels like "positive" or "negative" produce noisy results because the model cannot determine *what* the text is positive or negative about. Labels must specify the exact stance dimension you are measuring.

For this case study, the following labels capture the three positions of interest:

- Pro: "advocates for equal legal treatment of Chinese immigrants compared to white or European settlers, opposing racial discrimination"
- Neutral: "describes or retells the status or treatment of Chinese immigrants without expressing support or opposition to racial inequality, is unrelated to Chinese immigrants, or cannot be classified as either"
- Cons: "justifies or reinforces unequal legal treatment of Chinese immigrants relative to white or European settlers, supporting racially discriminatory policies"

Each label is phrased as a completion of the hypothesis template "In this snippet of a historical legal text, the author {}." This grounds the model in the specific domain and authorial framing of the texts.

Results depend heavily on label quality. Labels poorly aligned with the stance categories produce misleading classifications, especially for historical texts whose rhetorical conventions differ from modern usage.

#### A Small Label-Design Check

Before running the full corpus, test the labels on a few passages where you already have a strong reading. This is not a substitute for the evaluation sample later in the lesson. It is a quick design check to catch labels that are too vague, too broad, or unevenly phrased.

Good label sets usually have three features. First, each label names the same object of judgement. Here, all three labels refer to the author's stance towards unequal legal treatment of Chinese immigrants. Second, the labels use similar levels of detail. If one label is a long moral claim and another is a short descriptive phrase, the model may respond to wording rather than stance. Third, the categories should match the task. In this lesson, `Pro`, `Neutral`, and `Cons` are mutually exclusive summary categories, so the pipeline asks the model to choose among them.

For other projects, decide whether your labels are mutually exclusive before you run the model. A passage might be both "about taxation" and "about immigration", so a topic-classification task may need multi-label settings. A stance task like this one asks a different question: which stance is strongest in the passage? Keeping that distinction clear makes the output easier to interpret.

The `Neutral` label also needs special care. In this workflow it means "not clearly Pro or Cons for this research question". It does not mean that the passage is historically neutral, politically neutral, or unimportant.

### Setting Up the Pipeline

With the model chosen and the labels designed, you can now build the classifier. The code in this section does not classify anything yet. It sets up the tools that the next two sections use, in four parts:

1. **Load the model"** The `pipeline()` function from `transformers` downloads the DeBERTa NLI model from Hugging Face the first time you run it (about 870 MB, so this can take several minutes) and wraps it in a ready-made `zero-shot-classification` tool called `zero_shot`. The `hypothesis_template` argument tells the tool how to turn each label description into a hypothesis. The `device` argument tells it to use a GPU if PyTorch can find one (`0`) and the CPU otherwise (`-1`).
2. **Define the labels:** `zs_labels` holds the three label descriptions from the previous section, in the order `Pro`, `Neutral`, `Cons`.
3. **Score one passage:** The `get_scores()` function sends one passage and the three labels to `zero_shot`. The tool returns the labels sorted from highest to lowest score, so the function puts the scores back into a dictionary keyed by label, which keeps them in a fixed order.
4. **Score many passages:** The `score_texts()` function loops over every passage for every author, calls `get_scores()` on each one, and collects the results in a DataFrame. Each row of this DataFrame holds the author, the passage, and its `Pro`, `Neutral`, and `Cons` scores. Because the classifier is set up for single-label classification, the three scores for each passage add up to 1.

The code also records the main settings in a dictionary called `run_notes`, and sets `hf_logging.set_verbosity_error()`. Loading the model and the tokenizer can print informational messages and warnings about features this lesson does not use. This line hides those messages but still shows errors, so you will see anything that actually stops the code. If you are troubleshooting, remove the line to see every message.

```python

model_name = "MoritzLaurer/deberta-v3-large-zeroshot-v2.0"
run_notes = {
    "model_name": model_name,
    "hypothesis_template": (
        "In this snippet of a historical legal text, "
        "the author {}."
    ),
    "classification_mode": "single-label",
}
zero_shot = pipeline(
    "zero-shot-classification",
    model=model_name,
    tokenizer=model_name,
    hypothesis_template=(
        "In this snippet of a historical legal text, "
        "the author {}."
    ),
    device=0 if torch.cuda.is_available() else -1,
)

zs_labels = [
    (
        "advocates for equal legal treatment of Chinese immigrants "
        "compared to white or European settlers, opposing racial "
        "discrimination"
    ),
    (
        "describes or retells the status or treatment of Chinese "
        "immigrants without expressing support or opposition to racial "
        "inequality, is unrelated to Chinese immigrants, or cannot be "
        "classified as either"
    ),
    (
        "justifies or reinforces unequal legal treatment of Chinese "
        "immigrants relative to white or European settlers, supporting "
        "racially discriminatory policies"
    ),
]

def get_scores(snippet, labels):
    out = zero_shot(
        snippet,
        candidate_labels=labels,
        truncation=True,
    )
    raw = dict(zip(out["labels"], out["scores"]))
    return {label: raw.get(label, 0.0) for label in labels}

SCORE_COLS = ['Pro', 'Neutral', 'Cons']

def score_texts(texts_by_author, labels):
    rows = []
    for author, texts in texts_by_author.items():
        for text in texts:
            score_map = get_scores(text, labels=labels)
            rows.append(
                {
                    'Author': author,
                    'Text': text,
                    'Pro': score_map[labels[0]],
                    'Neutral': score_map[labels[1]],
                    'Cons': score_map[labels[2]],
                }
            )
    return pd.DataFrame(rows)
```

The `truncation=True` setting in `get_scores()` tells the tool to cut off any passage that is longer than the model can read at once, rather than stopping with an error. The window-level section below explains this limit.

The `run_notes` dictionary is not required by the model. It is there for auditability. If you change the model, labels, hypothesis template, or classification mode, save the new outputs under a new filename or add a short note explaining the change.

The pipeline is now ready to score passages. The next two sections apply it at two scales: first to the individual keyword snippets, then to larger windows of text. Each section shows two paths. The scoring path runs the model yourself. The lower-resource path skips the model and loads the precomputed results from `data/results/` instead; use it in place of the scoring code if you have limited computing time. Both paths produce the same variables, so everything after them works either way. Note that the scoring path saves its results to the same file names in `data/results/`, replacing the precomputed files.

### Sentence-Level Classification

The first scale of analysis is the single sentence. Here the classifier scores each keyword snippet on its own, which captures fine-grained variation in stance within each author's writing.

The code below passes the `keyword_snippets` dictionary to `score_texts()`, which returns a DataFrame, `df_scores`, with one row per snippet and a score for each of the three labels. It then saves this table as a CSV file so that you do not need to run the model again. Classifying all 125 snippets takes approximately 20 to 40 minutes on CPU.

```python
sentence_scores_path = "data/results/zero_shot_sentence_scores.csv"
df_scores = score_texts(keyword_snippets, labels=zs_labels)
df_scores.to_csv(sentence_scores_path, index=False)
```

Lower-resource path:

```python
df_scores = pd.read_csv("data/results/zero_shot_sentence_scores.csv")
```

Whichever path you used, `df_scores` now holds the score for every snippet. Individual scores are hard to compare across hundreds of rows, so the next step summarises them by author. The function below groups the rows by author, counts the passages for each author, and calculates the mean `Pro`, `Neutral`, and `Cons` scores, rounded to two decimal places. It is written as a function because you will reuse it for the window-level results.

```python
def summarise_scores(scores_df, count_name):
    return (
        scores_df.groupby("Author")
        .agg(
            **{count_name: ("Text", "size")},
            Pro=("Pro", "mean"),
            Neutral=("Neutral", "mean"),
            Cons=("Cons", "mean"),
        )
        .round(2)
    )

sentence_summary = summarise_scores(df_scores, "Sentences")
sentence_summary
```

Expected summary:

| Author | Sentences | Pro | Neutral | Cons |
| --- | ---: | ---: | ---: | ---: |
| Act 1884 | 24 | 0.02 | 0.38 | 0.60 |
| Begbie | 18 | 0.27 | 0.14 | 0.59 |
| Crease | 83 | 0.12 | 0.49 | 0.38 |

Each value is an average across all of an author's snippets. For example, 0.60 in the `Cons` column for the Act means that, on average, the model gave 60 per cent of its score for an Act sentence to the `Cons` label. The Act has the highest mean `Cons` score, as you would expect from discriminatory legislation. Crease's snippets lean towards `Neutral`, which fits the many sentences in which he describes the Act's provisions before assessing them. Begbie's mean `Cons` score is almost as high as the Act's. This is surprising, given that historians describe Begbie as protective of Chinese immigrants, and it is one reason the lesson later compares sentence results with wider context windows and checks them against hand-labelled examples.

Averages can hide a lot of variation, so it helps to look at the individual scores. The code below draws a scatter plot with one point per snippet: the Pro score on the horizontal axis and the `Cons` score on the vertical axis, coloured by author. The dictionary `AUTHOR_COLOURS` fixes one colour per author so that the same colours are used in every figure in the lesson.

```python
AUTHOR_COLOURS = {
    "Crease": "tab:blue",
    "Begbie": "tab:red",
    ACT_LABEL: "tab:green",
}

fig, ax = plt.subplots(figsize=(8, 5))
for author, colour in AUTHOR_COLOURS.items():
    subset = df_scores[df_scores["Author"] == author]
    ax.scatter(
        subset["Pro"], subset["Cons"],
        label=author, color=colour, alpha=0.7, s=15,
    )
ax.set_xlabel("Pro Score")
ax.set_ylabel("Cons Score")
ax.set_title("Pro vs. Cons Zero-Shot Scores by Author")
ax.legend()
plt.show()
```
{% include figure.html filename="en-or-natural-language-inference-historical-text-01.png" alt="Scatter plot of Pro versus Cons zero-shot classification scores coloured by author, showing that Act 1884 points cluster towards higher Cons scores" caption="Figure 1. Pro versus Cons classification scores by author (sentence level). The Act clusters towards higher Cons scores, while Crease and Begbie sentences distribute more broadly." %}

Points in the top-left corner are sentences the model reads as clearly `Cons`; points in the bottom-right corner are clearly `Pro`. Points near the bottom-left corner have low scores on both, which means most of their score went to `Neutral`. The green Act points sit almost entirely along the left edge, with `Pro` scores close to zero. Crease's and Begbie's points are spread much more widely: each has some strongly `Pro` sentences and some strongly `Cons` sentences. This spread suggests that individual sentences from the judges are often hard to classify out of context, which leads to the next step.

### Window-Level Classification

The sentence approach captures variation but loses context: a single sentence does not show whether the judge is endorsing an idea or describing it in order to reject it. The window approach classifies larger, overlapping chunks of text, called *windows*, giving the model more of the surrounding argument at the cost of per-sentence detail.

Windows cannot be any length. Transformer models such as DeBERTa read text as tokens, which are words or pieces of words, and can only read a fixed number of tokens at once. For this model the limit is 512 tokens, roughly 350 to 400 English words. A window therefore needs to be as long as possible without going over that limit.

The function below, `chunk_into_windows()`, builds windows from a full document. It first loads the model's tokenizer, the tool that converts text into tokens, so that window lengths are measured exactly as the model will count them. The function then splits the document into sentences with NLTK and adds them to the current window one at a time. Before adding each sentence, it counts the tokens the window would have. If the total stays within 512 tokens, the sentence is added. If not, the current window is saved, and a new window is started. The new window begins with the last 128 tokens of the previous one (the `stride`), followed by the sentence that did not fit. This overlap means that an argument running across the boundary between two windows still appears whole in at least one of them.

```python
nli_tokenizer = AutoTokenizer.from_pretrained(
    model_name
)

def chunk_into_windows(text, max_tokens=512, stride=128):
    sents = sent_tokenize(text)
    windows, current = [], ""
    for sent in sents:
        cand = current + " " + sent if current else sent
        n = len(nli_tokenizer.encode(cand, add_special_tokens=False))
        if n <= max_tokens:
            current = cand
        else:
            windows.append(current)
            tokens = nli_tokenizer.encode(current, add_special_tokens=False)
            tail = tokens[-stride:]
            current = nli_tokenizer.decode(tail) + " " + sent
    if current:
        windows.append(current)
    return windows
```

When the function measures a candidate window that is longer than 512 tokens, the tokenizer would normally print a warning such as "Token indices sequence length is longer than the specified maximum sequence length for this model". The `hf_logging.set_verbosity_error()` line from the pipeline setup hides it, but you will see it if you removed that line. You can ignore this message here: the function is only measuring the length, and it never sends that over-long text to the model.

Next, apply the function and score the windows. Note that the windows are built from the full texts in `corpus_by_author`, not from the keyword snippets, so they also include sentences that do not mention any keyword. The code below builds a dictionary, `window_texts_by_author`, that maps each author to a list of all the windows from their texts. It then passes this dictionary to `score_texts()`, exactly as you did for the snippets, and saves the results. Scoring the windows takes longer per passage than scoring single sentences, because each window is much longer.

```python
window_scores_path = "data/results/zero_shot_windowed_scores.csv"
window_texts_by_author = {
    author: [
        window_text
        for doc_text in docs
        for window_text in chunk_into_windows(doc_text)
    ]
    for author, docs in corpus_by_author.items()
}
window_scores_df = score_texts(window_texts_by_author, labels=zs_labels)
window_scores_df.to_csv(window_scores_path, index=False)
```

Lower-resource path: instead of running the code above, load the precomputed scores.

```python
window_scores_df = pd.read_csv(
    "data/results/zero_shot_windowed_scores.csv"
)
```
Then summarise the window scores by author with the same function you used for sentences:

```python
window_summary = summarise_scores(window_scores_df, "Windows")
window_summary
```

Expected summary:

| Author | Windows | Pro | Neutral | Cons |
| --- | ---: | ---: | ---: | ---: |
| Act 1884 | 8 | 0.04 | 0.29 | 0.67 |
| Begbie | 19 | 0.38 | 0.30 | 0.33 |
| Crease | 30 | 0.32 | 0.33 | 0.35 |

If you built the windows yourself, your window counts may differ slightly from this table, depending on your versions of NLTK and `transformers`.

The window-level results still mark the Act as the most discriminatory source, with a mean `Cons` score of 0.67. The picture for the judges changes, however. Begbie's mean `Cons` score falls from 0.59 at the sentence level to 0.33, and his `Pro` score rises to 0.38. Crease's scores become nearly even across the three labels. In other words, once the model sees more of the surrounding argument, the judges' writing looks less discriminatory than single sentences suggested. Comparing the two scales in this way is a useful diagnostic: where sentence and window results disagree, the stance of a passage depends on its context.

These two sets of results are what the model produced. The next stage asks how far you should trust them.

## Evaluation and Robustness

Computational results from zero-shot NLI should be treated as hypotheses, not conclusions. Unlike supervised models evaluated on held-out test sets, zero-shot classifiers carry no built-in accuracy guarantee for a new domain. This section first measures performance against a manually labelled set, then applies three checks, quote sensitivity, label sensitivity, and bootstrap confidence intervals, to assess how stable the findings are.

### Validating Against a Manually Labelled Evaluation Sample

Before interpreting zero-shot results on the full corpus, measure performance on a manually labelled sample that matches the task definition. The evaluation set used here contains 45 snippets balanced across the three pipeline labels (Pro, Neutral, Cons), with representation from Act text, Crease, Begbie, and Commission material. These snippets were hand-labelled for evaluation by one of the lesson co-authors and then checked by a second co-author. This design evaluates the same three-way classification problem used in the analysis pipeline, rather than a separate single-hypothesis entailment task.

The accompanying CSV records one expert label per snippet. It does not report separate annotator IDs, adjudication notes, or inter-annotator agreement. That is acceptable for a small tutorial evaluation set, but it affects how the numbers should be read: the labels are a co-author's reading of the stance categories, not an external benchmark or objective facts. In a larger study, you would also keep an annotation guide, record how ambiguous cases were handled, and you might ask a second reader to label at least a subset of the sample.

The labelled sample is stored in `data/core/labelled_snippets.csv`, which has three columns: `Author`, `Sentence`, and `Label` (the hand-assigned stance). The code below runs the classifier on each labelled sentence. For each sentence, it calls `get_scores()`, takes the label with the highest score as the model's prediction, and records the true label, the predicted label, whether the two match, and the three scores. The `label_names` dictionary translates each long label description back into its short name (`Pro`, `Neutral`, or `Cons`). Scoring 45 sentences takes a few minutes on CPU.

```python
labelled = pd.read_csv("data/core/labelled_snippets.csv")
label_names = dict(zip(zs_labels, SCORE_COLS))

eval_rows = []
for _, row in labelled.iterrows():
    scores = get_scores(row["Sentence"], zs_labels)
    pred = label_names[max(scores, key=scores.get)]
    eval_rows.append(
        {
            "Author": row["Author"],
            "sentence": row["Sentence"],
            "true": row["Label"],
            "pred": pred,
            "correct": pred == row["Label"],
            "pro_score": scores[zs_labels[0]],
            "neutral_score": scores[zs_labels[1]],
            "cons_score": scores[zs_labels[2]],
        }
    )

eval_df = pd.DataFrame(eval_rows)
eval_df.to_csv("data/results/ground_truth_eval.csv", index=False)
```

Lower-resource path: instead of running the code above, load the precomputed predictions.

```python
eval_df = pd.read_csv("data/results/ground_truth_eval.csv")
```
The evaluation reports four measures:

- **Accuracy:** the share of sentences where the predicted label matches the hand-assigned label.
- **Majority-class baseline:** the accuracy you would get by always predicting the most common label. Report it because a trivial classifier can score well by always predicting one class, which would make an accuracy figure look better than it is. Because this sample is balanced across the three labels, the baseline is 0.333.
- **Precision, recall, and F1 for each label:** for a given label, *precision* is the share of the model's predictions of that label that are correct, and *recall* is the share of the sentences that truly have that label which the model found. *F1* combines the two into one number (their harmonic mean), where 1.0 is perfect.
- **Accuracy by author:** shows whether the model works well across all sources or only on some.

The code below calculates these measures from `eval_df`. For each label, it counts the true positives (sentences where the label was both predicted and correct) and uses them to calculate precision, recall, and F1.

```python
accuracy = eval_df["correct"].mean()
baseline = eval_df["true"].value_counts(normalize=True).max()

class_metrics = []
for stance in SCORE_COLS:
    true_pos = (
        (eval_df["pred"] == stance) & (eval_df["true"] == stance)
    ).sum()
    precision = true_pos / (eval_df["pred"] == stance).sum()
    recall = true_pos / (eval_df["true"] == stance).sum()
    f1 = 2 * precision * recall / (precision + recall)
    class_metrics.append(
        {"Label": stance, "Precision": precision,
         "Recall": recall, "F1": f1}
    )

print(f"Accuracy: {accuracy:.3f}  Baseline: {baseline:.3f}")
print(pd.DataFrame(class_metrics).round(3))
print(eval_df.groupby("Author")["correct"].mean().round(3))
```
Expected output:

```text
Accuracy: 0.667  Baseline: 0.333
     Label  Precision  Recall     F1
0      Pro       1.00   0.333  0.500
1  Neutral       0.60   0.800  0.686
2     Cons       0.65   0.867  0.743
Author
Act 1884      0.700
Begbie        0.467
Commission    1.000
Crease        0.733
Name: correct, dtype: float64
```
The model labels 30 of the 45 sentences correctly (accuracy 0.667), twice the baseline of 0.333. The per-label results show where it struggles. Every sentence it labels Pro is correct (precision 1.000), but it finds only a third of the truly `Pro` sentences (recall 0.333). In other words, the model is cautious about assigning Pro and often gives sentences that support equal treatment a `Neutral` or `Cons` label instead. Accuracy is highest for the five Commission snippets and lowest for Begbie (0.467), which fits the pattern in the sentence-level results above.

For interpretive tasks, this level of performance is usable but not definitive. Treat these scores as decision support for close reading, not a substitute for it.[^17][^18][^19][^20]

After the summary metrics, inspect the errors. Accuracy tells you how often the model matches the evaluation labels; it does not tell you what kinds of mistakes the model makes. For this lesson, the most important errors are false `Cons` predictions for passages that quote or describe discriminatory law to reject it, and false `Neutral` predictions for passages whose stance depends on legal context. The code below selects the rows where the prediction was wrong and shows the first five, with the author, true label, predicted label, and sentence:

```python
eval_df[eval_df["correct"] == False][
    ["Author", "true", "pred", "sentence"]
].head()
```


Expected output:

| Author | true | pred | sentence |
| --- | --- | --- | --- |
| Act 1884 | Cons | Neutral | WHEREAS the incoming of Chinese to British Columbia largely exceeds that of any other class of immigrant. |
| Act 1884 | Neutral | Cons | This Act shall be cited as the Chinese Regulation Act, 1884. |
| Act 1884 | Neutral | Cons | The Lieutenant-Governor in Council shall appoint Chinese Collectors to collect and receive such payments. |
| Crease | Pro | Neutral | Held, that the Chinese Regulation Act, 1884, is ultra vires of the Provincial Legislature. |
| Crease | Pro | Cons | Every Chinese is guilty until proved innocent, a provision which fills one conversant with subjects with alarm. |

Fifteen of the 45 predictions are wrong. The last row, where Crease is labelled `Pro` but predicted `Cons`, is the quotation-induced stance reversal discussed in the interpretation stage: the sentence carries discriminatory words that Crease is condemning.

Read a few false positives and false negatives before interpreting author-level means. If most errors cluster in one author, document type, or rhetorical pattern, report that pattern alongside the accuracy score. Here, 8 of the 15 errors are Begbie sentences, and all but one of those are sentences that support equal treatment but were labelled `Neutral` or `Cons`. This tells you to be especially cautious about Begbie's sentence-level scores.

The evaluation sample tells you how accurate the model is. The next three checks ask a different question: how stable are the results if you change a choice made along the way, such as the quotation threshold or the label wording?

### Quote Sensitivity

Even after removing near-exact quotations of the Act from Crease's text, some paraphrased passages may remain. To test whether residual quotations drive the results, you can recalculate Crease's mean scores while removing more and more sentences that resemble the Act.

The code below first takes Crease's rows from the sentence scores and uses the `compute_quote_similarity()` function from the data preparation section to give each snippet a similarity score against the Act. It then tries four thresholds. For each one, it keeps only the snippets whose similarity is at or below the threshold, records how many snippets were removed, and calculates the mean `Pro`, `Neutral`, and `Cons` scores of the snippets that remain. A lower threshold is stricter, because it removes any snippet that resembles the Act even loosely.

```python
crease_sc = df_scores[df_scores['Author'] == 'Crease'].copy()
crease_sc['quote_sim'] = [
    compute_quote_similarity(t, regulation_act_sents)
    for t in crease_sc['Text']
]

quote_sensitivity = []
for threshold in [0.3, 0.4, 0.5, 0.6]:
    filtered = crease_sc[crease_sc['quote_sim'] <= threshold]
    means = filtered[['Pro', 'Neutral', 'Cons']].mean()
    quote_sensitivity.append(
        {
            'threshold': threshold,
            'removed': len(crease_sc) - len(filtered),
            'Pro': means['Pro'],
            'Neutral': means['Neutral'],
            'Cons': means['Cons'],
        }
    )

quote_sensitivity = pd.DataFrame(quote_sensitivity)
```

Expected output:

| Threshold | Removed | Pro | Neutral | Cons |
| --- | ---: | ---: | ---: | ---: |
| 0.3 | 62 | 0.13 | 0.43 | 0.45 |
| 0.4 | 8 | 0.13 | 0.50 | 0.37 |
| 0.5 | 0 | 0.12 | 0.49 | 0.38 |
| 0.6 | 0 | 0.12 | 0.49 | 0.38 |

At thresholds of 0.5 and 0.6, no snippets are removed. This is expected, because Crease's snippets come from the text that already had quotations above 0.6 removed. At 0.4, eight snippets are removed and the means barely change. At 0.3, the filter removes 62 of Crease's 83 snippets, including many of his own sentences that simply share legal vocabulary with the Act. The `Cons` score rises a little, but the remaining 21 snippets are too few to say much. (Results at this strictest threshold are also the most sensitive to how spaCy splits sentences, so your counts here may differ a little.) Taken together, the scores are stable across the reasonable thresholds (0.4 to 0.6), which suggests that leftover Act quotations are not driving Crease's results.

In general: if the mean scores remain stable across thresholds, the results are not driven by leftover Act quotations. If scores shift sharply, inspect the removed sentences before interpreting the author-level means.

### Label Sensitivity

Zero-shot classification results depend heavily on how candidate labels are phrased. Testing alternative label sets helps determine whether the ranking of authors is an artifact of specific wording or a stable finding.

The code below defines two alternative label sets: a short version (`alt_labels_1`) and a version phrased in legal terms (`alt_labels_2`). Each lists its labels in the same `Pro`, `Neutral`, `Cons` order as the primary labels. The code then scores a small sample with each of the three label sets and compares the results. To keep this check quick, the sample is the first two snippets for each author (six snippets in total), selected with `groupby("Author").head(2)`. For each label set, the code scores the sample with `score_texts()`, averages the scores by author, and adds a `LabelSet` column recording which labels were used. Finally, `pd.concat()` stacks the three results into one table, which is saved to a CSV file.

Because this check runs the model 18 times (six snippets, three label sets), it takes a few minutes on CPU. If you skip it, you can load the precomputed table with `label_sens_df = pd.read_csv("data/results/label_sensitivity_summary.csv")`.

```python
alt_labels_1 = [
    "supports equal rights for Chinese immigrants",
    "is neutral or unrelated to Chinese immigrant rights",
    "supports discriminatory treatment of Chinese immigrants",
]

alt_labels_2 = [
    (
        "argues that Chinese immigrants deserve the same legal "
        "protections as other residents"
    ),
    (
        "discusses Chinese immigration without taking a clear legal "
        "position for or against"
    ),
    (
        "argues that restricting Chinese immigrants through law is "
        "justified or necessary"
    ),
]

label_sets = {
    "Primary": zs_labels,
    "Alt-short": alt_labels_1,
    "Alt-legal": alt_labels_2,
}

sample = df_scores.groupby("Author", group_keys=False).head(2)
sample_texts = {
    author: sub["Text"].fillna("").tolist()
    for author, sub in sample.groupby("Author")
}

label_sens_df = pd.concat(
    [
        score_texts(sample_texts, labels=labels)
        .groupby("Author")[SCORE_COLS]
        .mean()
        .reset_index()
        .assign(LabelSet=set_name)
        [["LabelSet", "Author", "Pro", "Neutral", "Cons"]]
        for set_name, labels in label_sets.items()
    ],
    ignore_index=True,
)

label_sens_df.to_csv("data/results/label_sensitivity_summary.csv", index=False)
```

`label_sens_df` has one row for each combination of label set and author. To compare the authors' `Cons` scores side by side, reshape it so that each label set is a row and each author is a column:

```python
(
    label_sens_df.pivot(index="LabelSet", columns="Author", values="Cons")
    .loc[list(label_sets)]
    .round(2)
)
```

Expected output:

| Label set | Act Cons | Begbie Cons | Crease Cons |
| --- | ---: | ---: | ---: |
| Primary | 0.66 | 0.55 | 0.37 |
| Alt-short | 0.37 | 0.22 | 0.13 |
| Alt-legal | 0.60 | 0.28 | 0.31 |

If the relative ordering of authors holds across label sets, the finding is less likely to be an artifact of one label wording. Here the Act remains highest on `Cons` with every label set, but the scores for all three sources change considerably, and the order of Begbie and Crease is not stable: Begbie scores higher than Crease with the primary and short labels, but slightly lower with the legal labels. That instability should be reported rather than smoothed over. Because this check uses only six snippets, treat it as a quick test of wording effects; for a publishable analysis, run it on a larger sample.

### Bootstrap Confidence Intervals

With small sample sizes, mean scores can be misleading. A mean based on Begbie's 18 snippets could change a lot if a few snippets were different. *Bootstrap resampling* estimates how much. It draws many new samples from the data you have, each the same size as the original and drawn *with replacement* (so the same snippet can be picked more than once), and calculates the mean of each sample. The spread of these means shows how uncertain the original mean is. The middle 95 per cent of them gives a *95 per cent confidence interval*.

The function `bootstrap_ci()` below does this for one column of scores. It draws 1,000 samples and returns the original mean together with the lower and upper ends of the interval. The `seed` argument fixes the random draws so that you get the same intervals every time you run the code. The loop then applies the function to each author's `Pro`, `Neutral`, and `Cons` sentence-level scores and collects the results in a DataFrame, `bootstrap_summary`.

```python
def bootstrap_ci(data, n_boot=1000, ci=0.95, seed=42):
    rng = np.random.default_rng(seed)
    means = []
    for _ in range(n_boot):
        sample = rng.choice(
            data, size=len(data), replace=True
        )
        means.append(np.mean(sample))
    lo = np.percentile(
        means, (1 - ci) / 2 * 100
    )
    hi = np.percentile(
        means, (1 + ci) / 2 * 100
    )
    return np.mean(data), lo, hi

bootstrap_rows = []
for author in ['Crease', 'Begbie', ACT_LABEL]:
    sub = df_scores[df_scores['Author'] == author]
    for stance in ['Pro', 'Neutral', 'Cons']:
        m, lo, hi = bootstrap_ci(
            sub[stance].values
        )
        bootstrap_rows.append(
            {
                'Author': author,
                'Stance': stance,
                'Mean': m,
                'CI_low': lo,
                'CI_high': hi,
            }
        )

bootstrap_summary = pd.DataFrame(bootstrap_rows)
```
The intervals are easiest to read as a figure. The code below plots each mean as a dot with a vertical line (an error bar) running from the lower to the upper end of its interval. The three stances are placed along the horizontal axis, and each author's dots are shifted slightly left or right (using the offsets dictionary) so that they do not overlap. The colours match Figure 1.

```python
stances = ["Pro", "Neutral", "Cons"]
offsets = {"Crease": -0.2, "Begbie": 0.0, ACT_LABEL: 0.2}

fig, ax = plt.subplots(figsize=(8, 5))
for author, colour in AUTHOR_COLOURS.items():
    rows = (
        bootstrap_summary[bootstrap_summary["Author"] == author]
        .set_index("Stance")
        .loc[stances]
    )
    x = np.arange(len(stances)) + offsets[author]
    ax.errorbar(
        x, rows["Mean"],
        yerr=[rows["Mean"] - rows["CI_low"], rows["CI_high"] - rows["Mean"]],
        fmt="o", capsize=4, color=colour, label=author,
    )
ax.set_xticks(np.arange(len(stances)))
ax.set_xticklabels(stances)
ax.set_ylabel("Mean Score")
ax.set_ylim(0, 0.85)
ax.set_title("Bootstrap 95% Confidence Intervals by Author and Stance")
ax.legend(loc="upper left")
plt.show()
```

{% include figure.html filename="en-or-natural-language-inference-historical-text-02.png" alt="Dot-and-whisker plot of mean Pro, Neutral, and Cons stance scores for Crease, Begbie, and the Regulation Act, each with a bootstrap 95 percent confidence interval. Begbie's intervals are the widest, reflecting its small sample of 18 snippets, so its estimates are the least certain, and where two authors' intervals overlap on a stance the difference between them is not statistically reliable." caption="Figure 2. Bootstrap 95% confidence intervals for mean stance scores. Begbie's wide intervals reflect the smaller sample size (18 snippets versus 83 for Crease)." %}

Wide confidence intervals (especially for Begbie with only 18 snippets) indicate that the point estimates should be interpreted cautiously. Where intervals for different authors overlap on a given stance, the difference between them is not statistically reliable. For example, Begbie's `Cons` interval (about 0.45 to 0.72) overlaps almost completely with the Act's (about 0.53 to 0.67), so at the sentence level the data cannot reliably distinguish the two. Crease's `Cons` interval (about 0.33 to 0.44) sits clearly below the Act's.

These bootstrap intervals summarise variation in the observed snippets, not every uncertainty in the workflow. They do not account for OCR errors, label ambiguity, model bias, quotation removal choices, or the fact that sentences from the same document are not fully independent. Treat them as a warning system for unstable averages, not as a final statistical test.

You now have the model's results, a measure of their accuracy, and three checks on their stability. The final stage brings these together to interpret what the results can and cannot tell you about Crease and Begbie.

## Interpreting Results and Adapting the Workflow

### What NLI Can and Cannot Do

Both sentence and window approaches identify the Regulation Act as the most discriminatory source. However, interpretation requires careful human evaluation and explicit treatment of model uncertainty.

Consider this example from Crease's ruling: "...every Chinese is guilty until proved innocent, a provision which fills one conversant with subjects with alarm..." The model may classify this as "Cons" because the sentence contains discriminatory language. In context, however, Crease is *condemning* the law. This pattern appears repeatedly in Begbie as well and forms a central interpretive issue in this workflow.

Linguists and discourse analysts have documented what may be called *quotation-induced stance reversal*: when a speaker quotes another's words to criticise them, surface-level analysis attributes the quoted stance to the speaker.[^21] Sentence-level NLI is vulnerable to this because the model reads the discriminatory words without the surrounding argumentative frame that signals condemnation. Rights-protective legal judgments can therefore receive high "Cons" scores at the sentence level when judges quote or describe discriminatory rules to reject them.

To address this, window-level aggregates serve as the primary summary and sentence-level results serve as granular diagnostics.

You can also reduce the influence of ambiguous sentences with *confidence-aware summaries*. The highest of a sentence's three scores shows how confident the model is in its prediction: a sentence scored 0.9 `Cons` is a clear call, while one scored 0.4, 0.35, and 0.25 is not. The code below calculates two summaries of the sentence-level scores that take this into account. The first, `filtered_means`, drops every sentence whose highest score is below 0.5 before averaging. The second, `weighted_means`, keeps every sentence but weights each one by its highest score, so that confident predictions count for more.

```python
max_score = df_scores[SCORE_COLS].max(axis=1)

filtered_means = (
    df_scores[max_score >= 0.5]
    .groupby("Author")[SCORE_COLS]
    .mean()
    .round(2)
)

weighted_scores = df_scores[SCORE_COLS].mul(max_score, axis=0)
weighted_means = (
    weighted_scores.groupby(df_scores["Author"]).sum()
    .div(max_score.groupby(df_scores["Author"]).sum(), axis=0)
    .round(2)
)
```

Expected output for `filtered_means`:

| Author | Pro | Neutral | Cons |
| --- | ---: | ---: | ---: |
| Act 1884 | 0.02 | 0.37 | 0.61 |
| Begbie | 0.26 | 0.12 | 0.62 |
| Crease | 0.11 | 0.51 | 0.38 |

Expected output for `weighted_means`:

| Author | Pro | Neutral | Cons |
| --- | ---: | ---: | ---: |
| Act 1884 | 0.02 | 0.35 | 0.63 |
| Begbie | 0.27 | 0.12 | 0.61 |
| Crease | 0.11 | 0.50 | 0.38 |

Both summaries are close to the plain means in the sentence-level table, which shows that the sentence-level pattern is not caused by a handful of uncertain predictions. They do not fix the quotation problem described above, however: the model can be confidently wrong about a sentence that quotes discriminatory language in order to condemn it. That is why the window-level results and close reading remain essential.

To evaluate zero-shot results responsibly:

1. Examine high-confidence predictions and verify them against the source text
2. Look for systematic misclassifications (e.g., all quotations from the Act within a critique being labelled "Cons")
3. Compare sentence-level and window-level results; disagreements indicate context-sensitive passages
4. Treat window-level and confidence-aware aggregates as more reliable than any single sentence score

Returning to the historiographical question, the results are mixed rather than binary. The Regulation Act is consistently most discriminatory, while Crease and Begbie show overlapping but internally varied profiles. This supports a cautious interpretation: legal argument, quotation, and rhetorical framing all shape the scores. The method is most useful for prioritizing passages for close reading, not for replacing interpretation.

### Adapting to Your Own Corpus

The case study is specific, but the workflow is general. To adapt it to a new corpus, a researcher should make five decisions:

1. Select and digitize the corpus
2. Define a keyword list that identifies the thematic focus
3. Design classification labels that name the specific stance dimensions of interest
4. Choose a pre-trained model whose training domain approximates the target corpus
5. Assemble a small labelled sample of even 30 to 50 sentences (or more) to measure and report classification accuracy

Each of these decisions shapes what the pipeline can and cannot reveal, and each warrants explicit justification in any publication that uses these methods.

### Digital Resources for Historical Semantics

These resources help you check historical usage before final interpretation:

- The [Historical Thesaurus of English](https://ht.ac.uk/) traces when words acquired or lost specific senses through dated attestations. For example, it can help confirm that "alien" carried its legal sense throughout the nineteenth century.[^22]
- [Google Books Ngram Viewer](https://books.google.com/ngrams) charts word frequencies across centuries of digitized books, revealing where historical and modern usage patterns diverge.[^23]
- [EarlyPrint](https://earlyprint.org/) provides linguistically annotated early English print (1473 to the early 1700s) with tools for handling archaic spelling and OCR artifacts.[^24]
- The [Corpus of Historical American English (COHA)](https://www.english-corpora.org/coha/) contains 475 million words from the 1820s to the 2010s, searchable by decade and genre.[^25]

These tools cannot remove model bias, but they help you design better labels and spot likely failure points.

### Working with Other Languages

This case study uses English historical legal texts, an English spaCy model, and English NLI labels. For a corpus in another language, replace each language-dependent part of the workflow rather than only translating the keywords. Use a sentence segmenter that works for the target language, choose a multilingual or language-specific NLI model such as XLM-R or mDeBERTa, and write the candidate labels and hypothesis template in the same language as the corpus unless you have a clear reason to translate the texts. Then test the labels on known examples from your corpus before running the full classification.

The historical-semantics check also needs to be language specific. English resources such as the Historical Thesaurus of English or COHA will not answer questions about older French, Chinese, Spanish, or other language corpora. Look for dictionaries, historical corpora, or domain-specific reference works in the language and period you are studying, and document any vocabulary choices that may affect model interpretation.

## Conclusion

This lesson showed how to prepare a corpus, remove quoted passages with fuzzy matching, score stance with zero-shot DeBERTa NLI, and test the results. In this case study, the Regulation Act receives the clearest discriminatory scores, while the judicial texts are more ambiguous and context-dependent. Use these outputs as structured evidence for historical interpretation, not as final verdicts.

Used carefully, NLI lets historians scan more text than close reading alone, but it does not necessarily capture historical context in the way a researcher can. Its best use here is to surface passages and disagreements that deserve closer reading. The final interpretation still depends on source criticism, historical context, and transparent reporting of uncertainty.

## Further Reading

- Underwood, Ted. *Distant Horizons: Digital Evidence and Literary Change*. Chicago: University of Chicago Press, 2019. An accessible introduction to using computational methods for historical literary analysis.
- Yin, Wenpeng, Jamaal Hay, and Dan Roth. "Benchmarking Zero-shot Text Classification: Datasets, Evaluation, and Entailment Approach." In *Proceedings of the 2019 Conference on Empirical Methods in Natural Language Processing*, 3914-23. Hong Kong: Association for Computational Linguistics, 2019. The foundational paper on using NLI for zero-shot text classification.
- Lazer, David, et al. "Computational Social Science." *Science* 323, no. 5915 (2009): 721-23. A landmark article on the promises and pitfalls of computational approaches to social questions.
- Hamilton, William L., Jure Leskovec, and Dan Jurafsky. "Diachronic Word Embeddings Reveal Statistical Laws of Semantic Change." In *Proceedings of the 54th Annual Meeting of the Association for Computational Linguistics*, 1489-1501. Berlin: ACL, 2016. Describes the HistWords approach to tracking semantic shifts over time.

## Endnotes

[^1]: *An Act to Regulate the Chinese Population of British Columbia* (S.B.C. 1884, c. 4).
[^2]: *Regina v. Wing Chong*, 1 B.C.R. Pt. II 150 (1885).
[^3]: Tina Loo, "Crease, Sir Henry Pering Pellew," in *Dictionary of Canadian Biography*, vol. 13 (University of Toronto/Université Laval, 1994), https://www.biographi.ca/en/bio/crease_henry_pering_pellew_13E.html.
[^4]: David R. Williams, "Begbie, Sir Matthew Baillie," in *Dictionary of Canadian Biography*, vol. 12 (University of Toronto/Université Laval, 1990), https://www.biographi.ca/en/bio/begbie_matthew_baillie_12E.html.
[^5]: Paul Thomas, "Courts of Last Resort: The Judicialization of Asian Canadian Politics 1878 to 1913" (paper presented at the Annual Conference of the Canadian Political Science Association, University of Alberta, Edmonton, Canada, June 12-14, 2012), https://cpsa-acsp.ca/papers-2012/Thomas-Paul.pdf.
[^6]: John P.S. McLaren, "The Early British Columbia Supreme Court and the 'Chinese Question': Echoes of the Rule of Law," *Manitoba Law Journal* 20, no. 1 (1991): 107-47, https://www.canlii.org/w/canlii/1991CanLIIDocs168.pdf.
[^7]: *Regina v. Corporation of Victoria*, 1 B.C.R. Pt. II 331 (1888).
[^8]: *Wong Hoy Woon v. Duncan*, 3 B.C.R. 318 (1894).
[^9]: *Regina v. Mee Wah*, 3 B.C.R. 403 (1886).
[^10]: Canada, Royal Commission on Chinese Immigration, *Report of the Royal Commission on Chinese Immigration: Report and Evidence* (Ottawa: Printed by order of the Commission, 1885).
[^11]: Tim Loughran and Bill McDonald, "When Is a Liability Not a Liability? Textual Analysis, Dictionaries, and 10-Ks," *Journal of Finance* 66, no. 1 (2011): 35-65, https://doi.org/10.1111/j.1540-6261.2010.01625.x.
[^12]: Bing Liu, *Sentiment Analysis and Opinion Mining* (San Rafael, CA: Morgan & Claypool, 2012).
[^13]: David M. Blei, Andrew Y. Ng, and Michael I. Jordan, "Latent Dirichlet Allocation," *Journal of Machine Learning Research* 3 (2003): 993-1022.
[^14]: Wenpeng Yin, Jamaal Hay, and Dan Roth, "Benchmarking Zero-shot Text Classification: Datasets, Evaluation, and Entailment Approach," in *Proceedings of the 2019 Conference on Empirical Methods in Natural Language Processing* (Hong Kong: Association for Computational Linguistics, 2019), 3914-23.
[^15]: Moritz Laurer, Wouter van Atteveldt, Andreu Casas, and Kasper Welbers, "Less is More: Optimal Dataset Size for NLI Models," arXiv:2109.09703 (2023).
[^16]: Fatemeh Ariai, Joel Mackenzie, and Guido De Martini, "Natural Language Processing for the Legal Domain: A Survey of Tasks, Datasets, Models and Challenges," arXiv:2410.21306 (2025).
[^17]: Ron Artstein and Massimo Poesio, "Inter-Coder Agreement for Computational Linguistics," *Computational Linguistics* 34, no. 4 (2008): 555-96, https://doi.org/10.1162/coli.07-034-R2.
[^18]: Klaus Krippendorff, *Content Analysis: An Introduction to Its Methodology*, 4th ed. (Los Angeles: Sage, 2018).
[^19]: Rion Snow, Brendan O'Connor, Daniel Jurafsky, and Andrew Y. Ng, "Cheap and Fast — But Is It Good? Evaluating Non-Expert Annotations for Natural Language Tasks," in *Proceedings of the 2008 Conference on Empirical Methods in Natural Language Processing* (Honolulu: Association for Computational Linguistics, 2008), 254-63.
[^20]: Fabrizio Gilardi, Meysam Alizadeh, and Maël Kubli, "ChatGPT Outperforms Crowd Workers for Text-Annotation Tasks," *Proceedings of the National Academy of Sciences* 120, no. 30 (2023): e2305016120, https://doi.org/10.1073/pnas.2305016120.
[^21]: Douglas Biber and Edward Finegan, "Adverbial Stance Types in English," *Discourse Processes* 11, no. 1 (1988): 1-34, https://doi.org/10.1080/01638538809544689.
[^22]: Marc Alexander, ed., *Historical Thesaurus of English*, 2nd ed. (Glasgow: University of Glasgow, 2020), https://ht.ac.uk/.
[^23]: Jean-Baptiste Michel et al., "Quantitative Analysis of Culture Using Millions of Digitized Books," *Science* 331, no. 6014 (2011): 176-82, https://doi.org/10.1126/science.1199644.
[^24]: EarlyPrint Project, *EarlyPrint: Curating and Exploring Early Printed English* (Northwestern University and Washington University in St. Louis), https://earlyprint.org/.
[^25]: Mark Davies, *Corpus of Historical American English (COHA): 475 Million Words, 1820s–2010s* (Provo, UT: Brigham Young University, 2010–), https://www.english-corpora.org/coha/.
