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

This lesson teaches you how to apply [Natural Language Inference (NLI)](https://en.wikipedia.org/wiki/Textual_entailment) techniques to historical documents using Python. You can use NLI to, for example, determine the author's stance on a given topic or historical claim. This approach avoids training a new classifier for every historical debate. Instead of mapping a document to a fixed label, this approach compares passages with researcher-written hypotheses, which is useful when labelled training data is unavailable or expensive to create.

By stance we mean the position an author takes toward a specific claim. In this case study the claim is that Chinese immigrants deserve equal legal treament. The "stance" is whether the author supports this claim, opposes it, or expresses no clear position. You write each stance as a short hypothesis, for example "the author advocates for equal legal treatment of Chinese immigrants", and the model scores how well each passage supports it. How the labels and hypotheses are designed, and how zero-shot classification works in detail, are covered in the stance classification stage.

The lesson uses nineteenth-century British Columbia court rulings on Chinese immigration as its case study. However, the workflow applies to any historical corpus where you want to computationally assess authorial stance.

The lesson is organised into four stages:

1. **Data preparation:** load the corpus, detect and remove directly quoted passages, and extract the passages that discuss Chinese immigration.
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

This lesson sits towards the advanced end, not because of the Python involved but because of the methods it uses. You will need intermediate Python experience: working with pandas, writing functions, and using pip. If you are newer to Python, start with the [_Programming Historian_'s Introduction to Python](https://programminghistorian.org/en/lessons/introduction-and-installation). You do not need prior experience with transformer models, NLI, or the validation and bootstrap steps used later; the lesson introduces each of these where it appears.

Python 3.10 or later is required, along with at least 8GB of RAM. A GPU or iGPU is not required, but it will speed up model inference.

<div class="alert alert-warning">
This lesson uses transformer models and needs at least 8GB of RAM. Running every zero-shot step from scratch can take 60 to 90 minutes on CPU, so the lesson offers two paths: run the scoring cells yourself, or load the precomputed CSV outputs that are included. Each slow step shows both options.

If you have NVIDIA CUDA, PyTorch can use it automatically. On some Windows systems with AMD or Intel integrated GPUs, <code>torch-directml</code> may help, but stability varies by model. The code below runs on CPU by default and uses GPU acceleration only when PyTorch detects it.
</div>

## Software and Setup

Install all required Python packages. `pandas` and `numpy` handle tables, `nltk` and `spacy` split texts into sentences, `transformers` and `torch` run the NLI model, and `matplotlib` and `seaborn` make the figures. Run this in your terminal, from your working folder:

```bash
pip install pandas numpy matplotlib \
  seaborn nltk spacy scipy \
  transformers torch tqdm
```

For AMD or Intel integrated GPU acceleration on Windows, also run this in your terminal:

```bash
pip install torch-directml
```

Download NLTK data inside Python:

```python
import nltk
nltk.download('punkt')
nltk.download('punkt_tab')
```

Then download the English spaCy model from the terminal:

```bash
python -m spacy download en_core_web_sm
```

The spaCy model `en_core_web_sm` and the DeBERTa NLI model are both English only. If your corpus is in another language, see [Working with Other Languages](#working-with-other-languages) for what to swap in.

### Software Versions

This lesson was tested with:

- Python 3.13
- transformers 4.51
- torch 2.6
- DeBERTa NLI: `MoritzLaurer/deberta-v3-large-zeroshot-v2.0` (Hugging Face)

Load the required libraries:

```python
import pandas as pd
import numpy as np
import difflib
from nltk import sent_tokenize
import spacy
from transformers import AutoTokenizer, pipeline
import torch
import warnings
```

## Case Study: Chinese Immigration Law in British Columbia

While the techniques demonstrated in this lesson are general-purpose, you will go through a case study that provides concrete material to work with.

**A note on language**: This lesson reproduces historical racist terminology from the source documents (*Chinaman*, *Chinamen*, *coolie*, *heathen*, and *alien* in its nineteenth-century legal context). These terms appear in direct quotations, keyword lists, and the code cells because accurate computational analysis of nineteenth-century anti-Chinese legislation requires working with the source vocabulary. They are presented here as historical evidence.

The *1884 Chinese Regulation Act*[^1] in British Columbia (a province on the Pacific coast of Canada) was provincial legislation targeting Chinese residents, part of a broader wave of anti-Chinese laws across western North America in the late nineteenth century. It was challenged and declared unconstitutional in the 1885 case of *R v. Wing Chong* by [Henry Pering Pellew Crease](https://www.biographi.ca/en/bio/crease_henry_pering_pellew_13E.html), a judge on the Supreme Court of British Columbia.[^2] Justice Crease struck down the legislation on economic grounds, finding that it infringed on federal authority over immigration, trade, commerce, and taxation. In Commonwealth legal naming convention, *R* (or *Regina*, Latin for 'the Queen') denotes a criminal or constitutional case brought by the Crown against a private party.

However, Crease was not considered straightforwardly sympathetic to Chinese immigrants. Historian Tina Loo notes that he displayed mistrust towards Chinese residents, referred to them as "North American Chinamen", and feared they would "rule the country and job its offices".[^3] The apparent inconsistency between Crease's rhetoric and his political position raises a question difficult to answer through selective quotation alone: how did he discuss Chinese immigrants across his broader body of writing? And what methods can we use to better understand whether his opposition to the Act was rooted in principled objections to discrimination, or in a belief that Chinese immigrant labour was necessary for economic development?

To explore this question computationally, you will compare the language of Crease's rulings with two reference points: the discriminatory Act itself, and Justice [Matthew Baillie Begbie](https://www.biographi.ca/en/bio/begbie_matthew_baillie_12E.html),[^4] the first Chief Justice of British Columbia. Unlike Crease, historical accounts describe Begbie as protective of marginalized peoples, including Chinese immigrants.[^5][^6] Begbie struck down discriminatory municipal by-laws in Victoria targeting Chinese-owned businesses in the 1888 case of *R v. Victoria*.[^7]

The corpus consists of ten digitized texts: legal rulings (*R v. Wing Chong*,[^2] *Wong Hoy Woon v. Duncan*,[^8] *R v. Mee Wah*,[^9] *R v. Victoria*[^7]), the *1884 Chinese Regulation Act*, and reports from the 1884 Royal Commission on Chinese Immigration.[^10] The texts were converted from archival scans to machine-readable format using [Optical Character Recognition (OCR)](https://en.wikipedia.org/wiki/Optical_character_recognition). Direct quotes of the Act within Crease's ruling were identified using fuzzy string matching and removed so they do not contaminate the analysis of his own language (this process is described in the corpus preparation section).

## Downloading the Data

Download the lesson data files from the [_Programming Historian_ repository](https://github.com/programminghistorian/ph-submissions/raw/gh-pages/assets/natural-language-inference-historical-text/data.zip). Create a `data/` directory in your working folder and place all files there. The dataset includes:

- `data/core/metadata_cleaned.csv` -- a table listing the ten source documents with author, group, and type metadata
- Thirteen `.txt` files in `data/texts/` -- the OCR-transcribed historical texts (legal rulings, the 1884 Chinese Regulation Act, and Royal Commission reports)
- `data/core/labelled_snippets.csv` -- 45 sentence excerpts hand-labelled for evaluation by one of the lesson co-authors
- `data/texts/quotations_removed/` -- versions of Crease's texts with direct quotations of the Act removed

These sources are nineteenth-century British Columbia legal and government documents in the public domain. Openly accessible copies are available without login through UBC Open Collections, Canadiana, the Internet Archive, and BC Laws. We produced the text files by running modern OCR on those scans and organising the results, and the OCR transcriptions and derived data files in this lesson are shared under a Creative Commons Attribution (CC BY 4.0) licence.

## Preparing the Corpus

*You are in stage 1 of 4, data preparation: load the corpus, group the texts, remove quoted passages, and select the passages to analyze.*

The OCR process produced a `.csv` file with the following structure:

| Column Name                 | Description                                        |
| --------------------------- | -------------------------------------------------- |
| filename                    | Name of the source document file                   |
| author                      | Author (e.g., "Crease", "Begbie")                  |
| type                        | Document type (e.g., "case", "report", "act")      |
| text                        | Full text, which may include OCR errors             |
| act_quote_sentences_removed | Number of quoted sentences removed from the text   |

```python
df = pd.read_csv("data/core/metadata_cleaned.csv")

ACT_LABEL = "Regulation Act"

df["group"] = "Other"
df.loc[df["author"] == "Crease", "group"] = "Crease"
df.loc[df["author"] == "Begbie", "group"] = "Begbie"
df.loc[df["type"] == "act", "group"] = ACT_LABEL
```

Grouping documents by author lets you compare the language of Crease, Begbie, and the Act directly. Check how many documents fall into each group before going further:

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

This check confirms that the comparison groups are present before any model scores are calculated.

### Detecting and Removing Direct Quotations

Crease's ruling in *R v. Wing Chong* quotes passages from the 1884 Chinese Regulation Act verbatim. If these quoted passages remain in the corpus, the NLI model will classify them as language attributable to Crease, when in fact they are the Act's own words that Crease cited.

Quotation removal belongs in data preparation because stance classification asks "what does *this author* say?" A passage Crease quotes from the Act to strike it down would otherwise be scored as if Crease himself wrote it.

The approach uses fuzzy string matching via Python's [`difflib.SequenceMatcher`](https://docs.python.org/3/library/difflib.html), which computes a similarity ratio between two strings based on the longest contiguous matching subsequences. Exact string matching would be too weak here: the texts were produced by OCR, so a sentence Crease quotes from the Act and the same sentence in the Act itself rarely match character-for-character. Small transcription differences (a misread letter, a dropped word, inconsistent punctuation) would defeat an exact-match filter while leaving the quotation in place. Fuzzy matching tolerates this noise by scoring *how similar* two sentences are rather than demanding they be identical. For each sentence in Crease's text, you compute its similarity to every sentence in the Act and retain the highest score:

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

Next, score Crease's sentences against the Act, inspect the highest-scoring matches, and remove sentences above the chosen threshold:

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

Expected output:

| similarity | sentence |
| ---: | --- |
| 0.99 | In case any employer of Chinese fails to deliver to the collector the list... |
| 0.99 | Any collector or Government servant wilfully disobeying any of the provisions... |
| 0.99 | Every employer of Chinese shall furnish to the collector when requested... |
| 0.97 | Proof of the lawful possession of such receipt shall lie on the person... |
| 0.93 | Every collector shall collect the tax from each Chinese... |

Inspecting the highest-scoring rows helps you choose a threshold instead of treating it as a hidden parameter. A threshold of 0.6 catches near-exact quotes (accounting for OCR errors) while leaving Crease's own paraphrases intact; a looser threshold of 0.4 also catches loose paraphrases but risks discarding original sentences that merely share legal vocabulary with the Act. Set it too high and quoted material survives to contaminate the stance scores; set it too low and you erase the author's own language. We set ours to 0.6.

```python
quote_threshold = 0.6
cleaned_crease_sents = quote_scores[
    quote_scores["similarity"] < quote_threshold
]["sentence"].tolist()

len(crease_sents), len(cleaned_crease_sents)
```

For *R v. Wing Chong*, this threshold removes 12 sentences. The `act_quote_sentences_removed` column in the metadata records how many sentences were removed from each document, and the cleaned texts are saved under `data/texts/quotations_removed/`. The later NLI analysis uses these quotation-removed versions for Crease's texts. The same `compute_quote_similarity` function is reused later as a sensitivity check (see [Quote Sensitivity](#quote-sensitivity)), where you sweep across thresholds to confirm that residual quotations are not driving the results. For your own analyses, experiment with different thresholds to see which one best separates quotation from original language in your corpus.

### Checking the Threshold

For a small corpus, the best advanced check is still a human one: inspect sentences near the cutoff. These are the cases where the algorithm is least certain and where a small threshold change would alter the corpus.

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

Only two sentences fall in this band, and both refer to the Act rather than stating Crease's own argument.

Read this table before accepting the threshold. If the rows just above 0.6 are quoted Act language and the rows just below 0.6 are Crease's own argument, the threshold is doing what you need. If both sides contain a mixture of quotations, paraphrases, and original legal language, report that uncertainty and consider a more conservative threshold.

`SequenceMatcher` is useful here because it is part of the Python standard library and easy to explain. It also has limits. Short legal formulas can look similar even when they are not quotations, and OCR errors can reduce similarity for real quotations. For a larger or noisier corpus, you might compare this approach with token-based fuzzy matching, shared n-gram overlap, or embedding similarity. Those alternatives add dependencies and interpretation work, so they are better treated as extensions rather than the default path through this lesson.

### Identifying Relevant Passages

Zero-shot classification is computationally expensive, so rather than scoring every sentence in every document, you focus the analysis on the passages that actually discuss Chinese immigration. The strategy is to split each author's texts into sentences and keep those that mention immigration-related keywords. These keyword snippets become the unit of analysis for the sentence-level classifier, while the full documents are reused for window-level classification later.

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

warnings.filterwarnings("ignore")

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

Keyword filtering is deliberately simple and high-recall: it casts a wide net so that few relevant passages are missed, and the NLI model does the discriminating work of judging stance later. The `corpus_by_author` dictionary is kept alongside the snippets because the window-level analysis needs the full document text, not just the extracted sentences.

## Stance Classification with Zero-Shot NLI

*You are in stage 2 of 4, stance classification: design the labels and run zero-shot NLI on the passages selected in stage 1.*

Zero-shot classification is the core analytical technique of this lesson. It uses a [natural language inference](https://en.wikipedia.org/wiki/Textual_entailment) model to classify text into categories defined at inference time, requiring no labelled training data. This is particularly valuable for historical research, where labelled datasets rarely exist.

### Why NLI?

A natural first instinct is to measure stance by counting words: tally discriminatory or rights-affirming terms and compare authors. This is the logic behind domain-specific lexicons such as the Loughran-McDonald dictionary in financial text analysis, which counts curated word lists tailored to a domain rather than relying on general-purpose sentiment polarity.[^11] But keyword counting has a decisive blind spot for our question: it cannot tell the difference between a judge who *uses* a discriminatory word and one who *quotes it to condemn it*. The word "alien" counts the same whether the Act imposes it or Crease attacks it, and stance-bearing phrases such as "fills one with alarm" or "rule the country" use common words that no lexicon would flag. Stance depends on how words are combined and framed, which is the kind of comparison NLI is designed to make.

NLI is a practical middle ground for historical corpora. Supervised models need large labelled datasets that most historians do not have, and lexicon or topic methods often miss stance direction.[^12][^13] NLI instead scores whether a passage supports researcher-defined hypotheses, so you can run three-way stance classification without retraining.[^14]

### How Zero-Shot NLI Works

NLI models are trained to evaluate pairs of texts: a premise (the input text) and a hypothesis (a candidate label). The model predicts whether the premise *entails* the hypothesis (supports it), *contradicts* it, or is *neutral*. In zero-shot classification, each candidate label is converted into a hypothesis using a template, and the model scores how well the premise entails each hypothesis.

For example, given the premise "The treaties I have quoted between Great Britain and China, binding on the Dominion and on us in British Columbia, secure to the Chinese, just as the treaties between Great Britain and other foreign countries secure to other foreigners, the same rights in regard to the equality of taxation which I have described as being enjoyed by citizens of this country." and the hypothesis "In this text, the author advocates for equal legal treatment of Chinese immigrants", the model would likely assign a high entailment score, classifying the sentence as "Pro".

The key advantage is flexibility: you can define any set of labels without retraining the model; the key risk is that results depend heavily on how you phrase those labels.

### Choosing a Model for Historical Text

Model selection matters in any NLP pipeline, especially for historical texts. Two checks matter most: whether the training data is close to your corpus, and whether the model was designed for your task.

This lesson uses [DeBERTa NLI (v2.0)](https://huggingface.co/MoritzLaurer/deberta-v3-large-zeroshot-v2.0) for zero-shot classification. It is tuned for entailment tasks and performs strongly when labels are expressed as explicit hypotheses.[^15]

When choosing models for your own historical corpus, consider:

- Does the model's training data overlap with your domain? A general-purpose model may lack specialised vocabulary, while a domain-specific model trained on modern legal text may not understand nineteenth-century usage of terms like "alien".[^16]
- Is the model designed for your task? Use NLI-fine-tuned models for zero-shot classification rather than general-purpose language models.
- Test with known examples. Pass excerpts where you already know the expected result and check whether the model's output aligns with your domain knowledge.

For a publishable analysis, also record the exact model identifier, the date you ran it, and the main inference settings. Hugging Face models can change, and two models with similar names may behave differently. In production work you would usually pin a model revision; in this lesson, save enough information that another reader can tell which model produced the CSV files.

### The Lexicon Mismatch Problem

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

### A Small Label-Design Check

Before running the full corpus, test the labels on a few passages where you already have a strong reading. This is not a substitute for the evaluation sample later in the lesson. It is a quick design check to catch labels that are too vague, too broad, or unevenly phrased.

Good label sets usually have three features. First, each label names the same object of judgement. Here, all three labels refer to the author's stance towards unequal legal treatment of Chinese immigrants. Second, the labels use similar levels of detail. If one label is a long moral claim and another is a short descriptive phrase, the model may respond to wording rather than stance. Third, the categories should match the task. In this lesson, `Pro`, `Neutral`, and `Cons` are mutually exclusive summary categories, so the pipeline asks the model to choose among them.

For other projects, decide whether your labels are mutually exclusive before you run the model. A passage might be both "about taxation" and "about immigration", so a topic-classification task may need multi-label settings. A stance task like this one asks a different question: which stance is strongest in the passage? Keeping that distinction clear makes the output easier to interpret.

The `Neutral` label also needs special care. In this workflow it means "not clearly Pro or Cons for this research question". It does not mean that the passage is historically neutral, politically neutral, or unimportant.

### Setting Up the Pipeline

The lesson presents the pipeline in its simplest form. If you have limited computing time, you can load the precomputed CSV files shown below and still complete the interpretation and evaluation sections. If you want to reproduce the model outputs from scratch, run the scoring cells instead.

```python
warnings.filterwarnings("ignore")
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

The `run_notes` dictionary is not required by the model. It is there for auditability. If you change the model, labels, hypothesis template, or classification mode, save the new outputs under a new filename or add a short note explaining the change.

The next two sections show the direct calculation steps. To use the lower-resource path, replace the scoring cell with the `pd.read_csv()` line shown in each section.

### Sentence-Level Classification

One limitation of transformer models is a fixed token limit (typically 512 tokens). For longer documents, you must split text into smaller units. The sentence approach classifies each sentence individually, capturing fine-grained variation in stance.

Classification of all sentences takes approximately 20 to 40 minutes on CPU.

```python
sentence_scores_path = "data/results/zero_shot_sentence_scores.csv"
df_scores = score_texts(keyword_snippets, labels=zs_labels)
df_scores.to_csv(sentence_scores_path, index=False)

sentence_summary = (
    df_scores.groupby("Author")
    .agg(
        Sentences=("Text", "size"),
        Pro=("Pro", "mean"),
        Neutral=("Neutral", "mean"),
        Cons=("Cons", "mean"),
    )
    .round(2)
)
```

Lower-resource path:

```python
df_scores = pd.read_csv("data/results/zero_shot_sentence_scores.csv")
sentence_summary = (
    df_scores.groupby("Author")
    .agg(
        Sentences=("Text", "size"),
        Pro=("Pro", "mean"),
        Neutral=("Neutral", "mean"),
        Cons=("Cons", "mean"),
    )
    .round(2)
)
```

Expected summary:

| Author | Sentences | Pro | Neutral | Cons |
| --- | ---: | ---: | ---: | ---: |
| Act 1884 | 24 | 0.02 | 0.38 | 0.60 |
| Begbie | 18 | 0.27 | 0.14 | 0.59 |
| Crease | 83 | 0.12 | 0.49 | 0.38 |

The Act has the highest mean `Cons` score at the sentence level. Begbie also receives high sentence-level `Cons` scores, which is one reason the lesson later compares sentence results with wider context windows.

{% include figure.html filename="en-or-natural-language-inference-historical-text-01.png" alt="Scatter plot of Pro versus Cons zero-shot classification scores coloured by author, showing that Regulation Act points cluster towards higher Cons scores" caption="Figure 1. Pro versus Cons classification scores by author (sentence level). The Regulation Act clusters towards higher Cons scores, while Crease and Begbie sentences distribute more broadly." %}

### Window-Level Classification

The sentence approach captures variation but loses context. The window approach classifies larger overlapping chunks of text, giving the model more surrounding argument at the cost of per-sentence detail.

The windowing function uses the NLI tokenizer to measure token lengths, ensuring each chunk fits within the model's 512-token limit:

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

The same pattern works for larger windows:

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

window_summary = (
    window_scores_df.groupby("Author")
    .agg(
        Windows=("Text", "size"),
        Pro=("Pro", "mean"),
        Neutral=("Neutral", "mean"),
        Cons=("Cons", "mean"),
    )
    .round(2)
)
```

Lower-resource path:

```python
window_scores_df = pd.read_csv(
    "data/results/zero_shot_windowed_scores.csv"
)
window_summary = (
    window_scores_df.groupby("Author")
    .agg(
        Windows=("Text", "size"),
        Pro=("Pro", "mean"),
        Neutral=("Neutral", "mean"),
        Cons=("Cons", "mean"),
    )
    .round(2)
)
```

Expected summary:

| Author | Windows | Pro | Neutral | Cons |
| --- | ---: | ---: | ---: | ---: |
| Act 1884 | 8 | 0.04 | 0.29 | 0.67 |
| Begbie | 19 | 0.38 | 0.30 | 0.33 |
| Crease | 30 | 0.32 | 0.33 | 0.35 |

The window-level results still mark the Act as the most discriminatory source, but Begbie's mean `Cons` score falls once more surrounding context is included.

## Evaluation and Robustness

*You are in stage 3 of 4, evaluation and robustness: check the model against a labelled sample and test how stable the results are.*

Computational results from zero-shot NLI should be treated as hypotheses, not conclusions. Unlike supervised models evaluated on held-out test sets, zero-shot classifiers carry no built-in accuracy guarantee for a new domain. This section first measures performance against a manually labelled set, then applies three checks, quote sensitivity, label sensitivity, and bootstrap confidence intervals, to assess how stable the findings are.

### Validating Against a Manually Labelled Evaluation Sample

Before interpreting zero-shot results on the full corpus, measure performance on a manually labelled sample that matches the task definition. The evaluation set used here contains 45 snippets balanced across the three pipeline labels (Pro, Neutral, Cons), with representation from Act text, Crease, Begbie, and Commission material. These snippets were hand-labelled for evaluation by one of the lesson co-authors and then checked by a second co-author. This design evaluates the same three-way classification problem used in the analysis pipeline, rather than a separate single-hypothesis entailment task.

The accompanying CSV records one expert label per snippet. It does not report separate annotator IDs, adjudication notes, or inter-annotator agreement. That is acceptable for a small tutorial evaluation set, but it affects how the numbers should be read: the labels are a co-author's reading of the stance categories, not an external benchmark or objective facts. In a larger study, you would also keep an annotation guide, record how ambiguous cases were handled, and you might ask a second reader to label at least a subset of the sample.

The evaluation reports overall accuracy, per-class precision/recall/F1 (the harmonic mean of precision and recall, where 1.0 is perfect), and a majority-class baseline. Report the baseline because a trivial classifier can perform well by always predicting one class, making apparent gains in accuracy misleading. Per-author breakdowns show whether performance is concentrated in one source type or generalises across legal voices.

In this run, overall accuracy on the 45-sentence set is 0.667 (30/45), compared with a majority-class baseline of 0.333. Per-class F1 scores are 0.500 (Pro), 0.686 (Neutral), and 0.743 (Cons). Per-author accuracy is highest for Commission snippets (1.000), followed by Crease (0.733) and the Regulation Act (0.700), and lower for Begbie (0.467), which is consistent with the rhetoric discussed below.

| Metric | Value |
| --- | ---: |
| Overall accuracy | 0.667 |
| Majority-class baseline | 0.333 |
| F1, Pro | 0.500 |
| F1, Neutral | 0.686 |
| F1, Cons | 0.743 |

For interpretive tasks, this level of performance is usable but not definitive. Treat these scores as decision support for close reading, not a substitute for it.[^17][^18][^19][^20]

After the summary metrics, inspect the errors. Accuracy tells you how often the model matches the evaluation labels; it does not tell you what kinds of mistakes the model makes. For this lesson, the most important errors are false `Cons` predictions for passages that quote or describe discriminatory law to reject it, and false `Neutral` predictions for passages whose stance depends on legal context.

```python
eval_df = pd.read_csv("data/results/ground_truth_eval.csv")
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

Fifteen of the 45 predictions are wrong. The last row, where Crease is labelled Pro but predicted Cons, is the quotation-induced stance reversal discussed in the interpretation stage: the sentence carries discriminatory words that Crease is condemning.

Read a few false positives and false negatives before interpreting author-level means. If most errors cluster in one author, document type, or rhetorical pattern, report that pattern alongside the accuracy score.

### Quote Sensitivity

Even after removing near-exact quotations of the Act from Crease's text, some paraphrased passages may remain. To test whether residual quotations drive the results, you can apply progressively stricter similarity thresholds and store the filtered means for comparison:

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

If the mean scores remain stable across thresholds, the results are not driven by residual Act quotations. If scores shift sharply, inspect the removed sentences before interpreting the author-level means.

### Label Sensitivity

Zero-shot classification results depend heavily on how candidate labels are phrased. Testing alternative label sets helps determine whether the ranking of authors is an artifact of specific wording or a stable finding. The code below compares the primary labels with two shorter alternatives:

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

Expected output:

| Label set | Act Cons | Begbie Cons | Crease Cons |
| --- | ---: | ---: | ---: |
| Primary | 0.66 | 0.55 | 0.37 |
| Alt-short | 0.37 | 0.22 | 0.13 |
| Alt-legal | 0.60 | 0.28 | 0.31 |

If the relative ordering of authors holds across label sets, the finding is less likely to be an artifact of one label wording. Here the Act remains highest on `Cons`, but Begbie and Crease move depending on label phrasing. That instability should be reported rather than smoothed over.

### Bootstrap Confidence Intervals

With small sample sizes, mean scores can be misleading. Bootstrap resampling provides 95% confidence intervals that quantify the uncertainty in each estimate:

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

{% include figure.html filename="en-or-natural-language-inference-historical-text-02.png" alt="Dot-and-whisker plot of mean Pro, Neutral, and Cons stance scores for Crease, Begbie, and the Regulation Act, each with a bootstrap 95 percent confidence interval. Begbie's intervals are the widest, reflecting its small sample of 18 snippets, so its estimates are the least certain, and where two authors' intervals overlap on a stance the difference between them is not statistically reliable." caption="Figure 2. Bootstrap 95% confidence intervals for mean stance scores. Begbie's wide intervals reflect the smaller sample size (18 snippets versus 83 for Crease)." %}

Wide confidence intervals (especially for Begbie with only 18 snippets) indicate that the point estimates should be interpreted cautiously. Where intervals for different authors overlap on a given stance, the difference between them is not statistically reliable.

These bootstrap intervals summarise variation in the observed snippets, not every uncertainty in the workflow. They do not account for OCR errors, label ambiguity, model bias, quotation removal choices, or the fact that sentences from the same document are not fully independent. Treat them as a warning system for unstable averages, not as a final statistical test.

## Interpreting Results and Adapting the Workflow

*You are in stage 4 of 4, interpretation: read what the results can and cannot show, and adapt the workflow to your own corpus.*

### What NLI Can and Cannot Do

Both sentence and window approaches identify the Regulation Act as the most discriminatory source. However, interpretation requires careful human evaluation and explicit treatment of model uncertainty.

Consider this example from Crease's ruling: "...every Chinese is guilty until proved innocent, a provision which fills one conversant with subjects with alarm..." The model may classify this as "Cons" because the sentence contains discriminatory language. In context, however, Crease is *condemning* the law. This pattern appears repeatedly in Begbie as well and forms a central interpretive issue in this workflow.

Linguists and discourse analysts have documented what may be called *quotation-induced stance reversal*: when a speaker quotes another's words to criticise them, surface-level analysis attributes the quoted stance to the speaker.[^21] Sentence-level NLI is vulnerable to this because the model reads the discriminatory words without the surrounding argumentative frame that signals condemnation. Rights-protective legal judgments can therefore receive high "Cons" scores at the sentence level when judges quote or describe discriminatory rules to reject them.

To address this, window-level aggregates serve as the primary summary and sentence-level results serve as granular diagnostics. Confidence-aware summaries (filtering rows whose maximum label score falls below 0.5 and computing confidence-weighted means) further reduce the influence of ambiguous sentences.

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
