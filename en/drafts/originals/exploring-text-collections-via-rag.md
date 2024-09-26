---
title: "Data, Dialogue, and AI: Exploring Text Collections with Large Language Models via Retrieval Augmented Generation"
slug: exploring-text-collections-via-rag
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Daniel Hutchinson
reviewers:
- Forename Surname
- Forename Surname
editors:
- John R. Ladd
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/611
difficulty: 3
activity: analyzing
topics: [python, data-manipulation]
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

Large language models (LLMs) and other forms of generative artificial intelligence (AI) offer historians new approaches to programmatically explore the past. At their best, LLMs can recall significant volumes of historical knowledge gleaned from the vast datasets on which they are trained - at least, that's what the [data seems to indicate.](https://dr-hutchinson-what-do-ais-know-about-history-app-i3l5jo.streamlit.app/) But these tools must be used with care. AI models may possess a broad knowledge base, but their reliability for more specialized historical topics is often limited. Of greatest concern, of course, is their propensity to deliver convincingly invented fiction as historical fact.

A popular method to leverage the strengths of LLMs while mitigating their shortcomings is retrieval augmented generation (RAG). RAG is an approach that combines language generation models with information retrieval systems. This combination guides LLMs in providing contextually relevant responses informed by a specific database or text corpus.

Here is an example of such an approach using the collected speeches of Abraham Lincoln. [GPT-4](https://openai.com/index/gpt-4/), a leading LLM from OpenAI, can offer significant details concerning Lincoln’s life and times. However, it struggles when posed a more specific and narrow question: “What did Abraham Lincoln think of Japan?”

> **GPT-4**: Abraham Lincoln's presidency (1861-1865) coincided with a period when Japan was opening up to the Western world after centuries of relative isolation under the Tokugawa shogunate's "sakoku" (closed country) policy. However, there are no direct records of Lincoln expressing specific views on Japan. His presidency was largely consumed by the American Civil War and domestic issues, which were of paramount importance to his administration…

Yet a less advanced model, [Mistral-7B](https://mistral.ai/news/announcing-mistral-7b/), provides a detailed response when supplied relevant excerpts from Lincoln’s speeches through RAG:

> **Mistral-7B**: Abraham Lincoln's views on Japan were shaped by the diplomatic challenges and opportunities that arose during his presidency.
>
> In his Fourth Annual Message on December 6, 1864, Lincoln acknowledged the inconsistent and capricious nature of Japan's government and its performance of treaty obligations. Despite these challenges, he remained optimistic about the progress made through international cooperation and the positive impact of economic engagement on US-Japanese relations. He noted, "good progress has been effected by the western powers, moving with enlightened concert. Our own pecuniary claims have been allowed, or put in course of settlement, and the inland sea has been reopened to commerce. There is reason also to believe that these proceedings have increased rather than diminished the friendship of Japan towards the United States" [(Fourth Annual Message, December 6, 1864)](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/exploring-text-collections-via-rag/speech-text-72.txt).
>
> In his Second Annual Message on December 1, 1862, Lincoln mentioned Japan as one of the countries with which the US maintained favorable diplomatic and economic relations. He stated, "Very favorable relations also continue to be maintained with Turkey, Morocco, China and Japan" [(Second Annual Message, December 1, 1862)](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/exploring-text-collections-via-rag/speech-text-58.txt). This passage underscores the importance of Japan as a diplomatic and economic partner during this period.
>
> However, Lincoln also recognized the challenges posed by Japan's unique political structure and the resistance of the imperial court to Westernizing policies. In his Third Annual Message on December 8, 1863, he acknowledged the serious jeopardy that US-Japanese relations had faced due to the opposition of the Japanese aristocracy to the enlightened and liberal policies of the shogun. He asked for Congress's attention to the claim of the US minister in Japan for damages sustained in the destruction of the legation residence at Yedo [(Third Annual Message, December 8, 1863)](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/exploring-text-collections-via-rag/speech-text-66.txt).
>
> Overall, Lincoln's speeches reveal a nuanced understanding of Japan and its role in international affairs during his presidency. While acknowledging the challenges posed by Japan's unique political structure and inconsistent adherence to treaty obligations, he remained committed to finding diplomatic solutions and maintaining economic engagement to strengthen US-Japanese relations.

While GPT-4 is a superior model in terms of its training and "knowledge", the smaller model employing RAG provides an informed response supported by accurate quotes and specific citations drawn from the Lincoln corpus. More importantly, this response is supported by a chain of evidence that allows users to verify for themselves the validity of the AI response. While this approach does not eliminate the possibility of AI errors and “hallucinations,” this method enables the transformation of simple keyword searches into dialogues with data, an intriguing approach to historical inquiry.

This lesson for the *Programming Historian* creates a similar RAG application using the collected speeches of Abraham Lincoln to demonstrate how RAG works and how historians can create their own personalized RAG applications. It is based on [*Nicolay: Exploring the Speeches of Abraham Lincoln with AI*](https://nicolay-honestabes-info.streamlit.app/), a digital history project utilizing a similar RAG approach.

The lesson will cover the following elements:

* How RAG works
* Preparing datasets for RAG applications
* Common RAG search methods
* Prompting Large Language Models for RAG
* Evaluating RAG
* Advanced RAG: For Further Exploration

### Suggested Prior Skills

Familiarity with Python is recommended for this lesson. Specifically, it would be beneficial to understand how to load and index files, set variables, employ external libraries, and manipulate text strings. The [*Programming Historian*](https://programminghistorian.org/en/lessons/?topic=python&sortType=difficulty&sortOrder=desc) offers a variety of helpful lessons on these Python approaches.

This lesson also assumes familiarity with Jupyter Notebooks. If you are unfamiliar with this format, you may find the [Introduction to Jupyter Notebooks](https://programminghistorian.org/en/lessons/jupyter-notebooks) lesson a valuable resource.

Readers are particularly encouraged to use a Notebook enabled for cloud-based GPU access, like the [Google Colab](https://colab.google/) environment, which offers users free access to processors needed for execution of some elements of this notebook. [The Computer Vision for the Humanities (Part 1)](https://programminghistorian.org/en/lessons/computer-vision-deep-learning-pt1) lesson offers a guide for getting started with Colab.

## How RAG Works

{% include figure.html filename="en-or-exploring-text-collections-via-rag-01.png" alt="Diagram of a Retrieval-Augmented Generation (RAG) pipeline. The process starts with a user query and a set of documents, which undergo indexing. The query and indexed documents feed into a retrieval system. The retrieved information forms a prompt that is sent to a large language model (LLM), which generates the output. The diagram represents the stages of a basic RAG workflow, illustrating how retrieval augments the generative capabilities of the model." caption="Figure 1: A basic RAG workflow. From Gao et. al, 'Retrieval-Augmented Generation for Large Language Models: A Survey.' arXiv:2312.10997v4 [cs.CL] 5 Jan 2024. [https://arxiv.org/pdf/2312.10997](https://arxiv.org/pdf/2312.10997)" %}

Retrieval augmented generation was [first introduced](https://arxiv.org/abs/2005.11401) in 2020, and has developed into an active research area for generative AI. While RAG apps vary in complexity and scale, they typically use the following features: data indexing, a retriever, and a large language model.

**Data Indexing:** Data indexing is the foundational step in the RAG process. This process involves organizing and storing data in a way that allows for efficient retrieval, transforming a dataset into a knowledge base for the application. This is accomplished by programmatically segmenting and indexing the data for search and retrieval.

**Retriever:** Retrievers are used to search over a dataset. When given a user query, retrievers seek out data that most closely matches the query based on their particular methodology. Keyword matching using methods typical of standard search engines, for example, is a common search approach. However, keyword search alone can fail to capture documents with similar meanings but employing different terminology. Accordingly, RAG applications typically utilize hybrid search approaches to capture these nuances. Methods such as [text embedding](https://programminghistorian.org/en/lessons/understanding-creating-word-embeddings) enable capacities for semantic and contextual search approaches, broadening the retriever's scope while also enhancing its precision. The modular nature of retrievers allows for customizable search approaches tailored to the data source. Once the search is completed, the retriever captures the top-ranked results to pass on to an LLM to interpret.

**Large Language Model (LLM):** An LLM is the final component of a RAG system. LLMs are trained on vast corpora of text data, enabling them to imitate forms of human understanding and generate text and working code. Their training gives them considerable recall in a vast array of domains. Yet they also are prone to invent misinformation and make erroneous claims. By integrating a retriever, an LLM can enhance its responses with specific, contextually relevant information from the indexed dataset. Its responses can be further improved by the use of prompts containing example RAG tasks, allowing the LLM to utilize its capacities for in-context learning. This combination leverages the broad knowledge and language capabilities of the LLM while grounding its responses from a specific dataset.

## Developing a RAG App: Things to Consider

{% include figure.html filename="en-or-exploring-text-collections-via-rag-02.png" alt="Diagram of an open-source Retrieval-Augmented Generation (RAG) pipeline. The process begins with a user query, which branches into three search methods: keyword search (BM25), semantic search with a vector database (Qdrant), and context search (ColBERT). Results from these searches are ranked by a reranker model (BGE-Base), followed by relevance determination using a Mistral 7-B LLM with five-shot prompting. Finally, the relevant information is summarized using the Mistral 7-B LLM with two-shot prompting." caption="Figure 2: An open-source RAG workflow." %}

This lesson will guide you through building your own open-source RAG application. In exploring RAG techniques, historians should consider their use case, their data, and the costs and technical knowledge needed to implement a RAG app.  Careful consideration of these factors at the onset will save time and expense later.

The easiest path is to utilize RAG as a service, where data is uploaded to a cloud for retrieval and interpretation by closed-source models. Weaviate’s [Verba](https://github.com/weaviate/Verba) service, for example, offers a technically accessible platform for utilizing a wide array of RAG-approaches and API access to most advanced LLMs.

However, open-source approaches offer an important alternative to RAG as a service. While proprietary models offered by firms like OpenAI, Google, and Anthropic offer state-of-the-art performance, the expense of using them can scale quickly. Open-source LLMs offer a no-cost, locally hosted alternative. Moreover, open-source models are quickly advancing in terms of performance and accessibility. Perhaps most importantly, open-source methods open up the possibility to develop customizable RAG frameworks tailored to specific research tasks.

To be sure, there are challenges in utilizing open-source approaches. Running local models often requires access to high-powered GPU processors or external hosting services, which bear their own costs. However, services like Google Colabs have enabled significant access to cloud-based GPU computing power.

In considering these different options, consider what elements from the chart below best fit with your use needs:

<div class="table-wrapper" markdown="block">

| **Criteria**                | **Open Source Models**                                                                                                                                                          | **Closed Source Models**                                                                                                                                                      |
|-----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Ease of Use**             | - Requires more technical setup and maintenance.<br>- May have a steeper learning curve.                                                                                        | - Generally easier to set up and use.<br>- User-friendly interfaces.<br>- Extensive support and documentation.                                                                |
| **Technical Accessibility** | - Requires technical knowledge for installation and configuration.<br>- Community support might be fragmented.                                                                  | - Lower technical barrier to entry.<br>- Comprehensive support services.<br>- Accessible for users with minimal technical background.                                          |
| **Cost**                    | - No cost for the models themselves.<br>- Costs associated with local hardware or cloud-based compute resources.                                                                 | - Can be expensive, especially with high usage.<br>- Subscription or pay-per-use models.<br>- Potentially high long-term costs.                                                |
| **Performance**             | - Performance improving with advances in open-source technology.<br>- May require optimization to match closed-source performance.                                               | - Access to the latest and most advanced LLMs.<br>- Typically offers higher out-of-the-box performance.                                                                       |
| **Customizability**         | - Highly customizable.<br>- Ability to tailor the model and RAG framework to specific research needs.<br>- Open-source code can be modified.                                      | - Limited customization options.<br>- Customizability may be constrained by the service provider.<br>- Rely on provider for updates and improvements.                          |
| **Compute Requirements**    | - Requires significant local compute power or cloud-based GPU resources.<br>- Can be managed with services like Google Colab.                                                     | - Compute resources managed by the service provider.<br>- No need for local high-powered hardware.<br>- Simplifies the compute aspect for end-users.                          |
| **Security and Privacy**    | - Greater control over data security and privacy.<br>- Data remains local or under user-defined control.                                                                         | - Data is uploaded to and managed by the service provider.<br>- Trust in the provider’s security measures is essential.                                                        |
| **Scalability**             | - Scalability depends on local resources or cloud infrastructure.<br>- More flexible but potentially more complex to scale.                                                      | - Easily scalable with the provider’s infrastructure.<br>- Provider handles the complexities of scaling.<br>- Suitable for rapidly growing or variable usage needs.           |
| **Community and Support**   | - Strong community support, but may vary in reliability.<br>- Open forums and collaborative problem-solving.                                                                     | - Professional support services.<br>- Guaranteed response times.<br>- Access to detailed documentation and troubleshooting guides.                                              |
| **Innovation and Updates**  | - Continuous innovation from the open-source community.<br>- Updates and improvements depend on community contributions and developer engagement.                                | - Regular updates from the provider.<br>- Access to the latest technological advancements.<br>- Innovations driven by industry leaders in AI and machine learning.             |

</div>
Table 1: Open Source vs. Closed Source Models for RAG

A final element to consider are specialized frameworks for RAG programming. Python libraries for LLMs such as [Langchain](https://github.com/langchain-ai/langchain), [Llamaindex](https://github.com/run-llama/llama_index), and [txtai](https://github.com/neuml/txtai) feature tutorials and Jupyter Notebooks for building different RAG approaches and LLM applications.

## Preparing Datasets for RAG

RAG systems work best when tailored to the specific data you wish to explore. An important first step is indexing your data for effective recall and interpretation. One crucial element is addressing the “context windows” of LLMs, or the limit of the textual information the model can process in a single inference. While some models possess expansive windows that can take in entire datasets in a single query, many models remain limited to a few pages of text.

Text chunking, or splitting large text collections into smaller individual segments, is a common workaround to this limitation. For example, the data used in this lesson comes from a corpus of Lincoln speeches held by the [University of Virginia’s Miller Center](https://data.millercenter.org./). This collection of fifteen Lincoln speeches totals some 96,000 words, or some 300 pages of text, too large for most open-source models. Accordingly, the corpus has been broken down into 79 individual chunks formatted into a [JSON file](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/exploring-text-collections-via-rag/lincoln-speech-corpus.json). A good way to observe this process is by exploring [ChunkViz](https://example.com), a web tool for visualizing how text splitters chunk a text based on different settings. A number of LLM programming frameworks can automate this chunking process across a variety of data formats and programming languages. Frameworks such as [Langchain](https://python.langchain.com/v0.2/docs/how_to/#text-splitters), [Llamaindex](https://docs.llamaindex.ai/en/stable/api_reference/node_parsers/token_text_splitter/), and [txtai](https://github.com/neuml/txtai/blob/master/examples/10_Extract_text_from_documents.ipynb) offer text splitters/chunkers for effective data indexing.

Another approach to preparing datasets for RAG is the inclusion of metadata accompanying each text segment. Metadata can provide additional details to aid search-and-retrieval and provide context for the LLM’s interpretations. If such metadata is unavailable, one approach is to programmatically generate metadata using an LLM. For example, this [prompt](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/exploring-text-collections-via-rag/metadata-generation-prompt.txt) demonstrates how this method was used on the Lincoln corpus to generate summaries and extract keywords from each chunk. This metadata is then paired with the Lincoln corpus to facilitate retrieval and interpretation.

The code below demonstrates how to download and view the data structure of Lincoln corpus. Only the 'full_text' and 'source' variables are originally part of the Lincoln corpus; the 'summary' and 'keywords' variables were programmatically created with LLMs and later added.

```
# Downloading Lincoln corpus
import re
import os
import json
import requests
import pandas as pd

# Function to download data
def download_data(url, file_path):
    response = requests.get(url)
    if response.status_code == 200:
        with open(file_path, 'wb') as file:
            file.write(response.content)
        print('File downloaded successfully!')
    else:
        print(f'Failed to download file. Status code: {response.status_code}')

# Data and File Paths for Lincoln speech corpus
url = "https://raw.githubusercontent.com/programminghistorian/ph-submissions/blob/gh-pages/assets/exploring-text-collections-via-rag/lincoln-speech-corpus.json"
data_dir = "/content/"
file_name = "lincoln-speech-corpus.json"
file_path = os.path.join(data_dir, file_name)

# Downloading Lincoln speech corpus
download_data(url, file_path)

# Reading and displaying the first entry in the JSON file
with open(file_path, 'r') as file:
    data = json.load(file)

# Displaying the first entry
if data:
    first_entry = data[0]
    print("First entry in the JSON file:")
    print(json.dumps(first_entry, indent=4))
else:
    print("The JSON file is empty or not properly formatted.")
```

Output:
```
{
    "text_id": "Text #: 0",
    "source": "Source:  At Peoria, Illinois. October 16, 1854.",
    "full_text": "The repeal of the Missouri Compromise, and the propriety of its restoration, constitute the subject of what I am about to say...",
    "summary": "Summary: Abraham Lincoln's speech in Peoria, Illinois, on October 16, 1854, focused on the repeal of the Missouri Compromise...",
    "keywords": "Keywords:  Abraham Lincoln, Peoria, Illinois, Missouri Compromise, Judge Douglas, domestic slavery..."
}
```

## Common RAG Search Methods

Building a retriever, or a set of search methods, is the next step after data indexing. In these examples, we explore search approaches commonly used in RAG applications and then combine them to search the Lincoln corpus. In the code below, we will construct a retriever system employing four types of retrieval tools:

1.  **Keyword search (using BM25)**
2.  **Text Embeddings for Semantic Similarity (using Qdrant)**
3.  **Text Embeddings for Contextual Similarity (using ColBERT)**
4.  **Search Result Reranker (BGE-Base)**

You can follow along and replicate these steps with this [Google Colab notebook](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/exploring-text-collections-via-rag/exploring-text-collections-via-rag.ipynb), which enables remote access to a GPU needed to run the code.

To begin, let’s download and import the libraries needed for the RAG app. Please note that some of these libraries are sizable and may take some time to download and install (approximately five to ten minutes).

```
# Installing dependencies

!pip install -U pyarrow==14.0.2 requests==2.31.0 packaging==24.1

# Then install the rest of the dependencies
!pip install langchain_community tiktoken langchain-openai langchainhub chromadb langchain youtube-transcript-api pytube
!pip install jq
!pip install -U ragatouille
!pip install -U FlagEmbedding
!pip install -U transformers
!pip install qdrant-client>=1.1.1
!pip install -U sentence-transformers
!pip install nltk
!pip install ctransformers>=0.2.27
!pip install -q -U accelerate
!pip install -q -U bitsandbytes
!pip install secure-smtplib
!pip install rank-bm25
!pip install rouge-score
```

Next, let’s ensure access to [HuggingFace](https://huggingface.co/), an online repository of downloadable open-source models that we’ll be using to construct this RAG application. The code below sets up API access to HuggingFace; you can sign up for an API key [here](https://huggingface.co/docs/api-inference/en/quicktour#get-your-api-token). While HuggingFace does offer paid tiers for some services, all of the models used in this lesson are free to use and download.

```
# Setting HuggingFace API key

from huggingface_hub import login

# Set you API key here
hf_token = "YOUR_HUGGINGFACE_API_KEY"

# Login to Hugging Face
login(hf_token)
```

### Keyword Search (with BM25)

[BM25](https://github.com/dorianbrown/rank_bm25), short for "Best Matching 25", is a Python library that uses a set of ranking functions to estimate the relevance of documents to a given query. BM25 ranks documents based on the occurrence of query terms within each document. This approach is computationally efficient and relatively easy to implement. However, BM25 relies on exact term matching and may miss relevant documents that use different terms to express similar concepts. That said, it offers a good baseline for initial searches.

The code below demonstrates how this search method is implemented:

**1. Library Imports and Setup:**

Imports necessary libraries: The code imports libraries for BM25 (`rank_bm25`), sentence encoding (`SentenceTransformer`), text processing (`nltk`), and data loading (`langchain_community`).

**2. Initialize Sentence Encoder:**

Sets up a Sentence Transformer model downloaded from HuggingFace to encode sentences in the Lincoln corpus.

**3. Download and Prepare NLTK Resources:**

Download required [Natural Language Toolkit](https://www.nltk.org/) (NLTK) resources: The code downloads the 'punkt' and 'stopwords' datasets, which are needed for tokenizing text and filtering out common stopwords (e.g., "the," "and," "is").

**4. Define Metadata Extraction and Preprocessing Functions:**

*   **Extract Metadata:** The `extract_metadata_for_bm25` function extracts relevant metadata from each document, such as text ID, full text, summary, and keywords.
*   **Preprocess Text:** The code defines a preprocessing function that tokenizes the text, converts it to lowercase, and removes stopwords, preparing it for BM25 indexing.

**5. Load and Encode Documents:**

*   **Load Documents:** The `load_and_encode_documents_bm25` function loads the Lincoln speech corpus from a JSON file using [Langchain's JSONLoader.](https://python.langchain.com/v0.1/docs/modules/data_connection/document_loaders/json/)
*   **Encode Texts for BM25:** The function preprocesses each document and creates a BM25 index of the corpus for keyword search. Notably, for this code, we include not just the full text of each Lincoln speech but also the accompanying metadata, such as summaries and keyword lists.

**6. Perform Keyword Search with BM25:**

*   **Keyword Search Function:** The `keyword_search_bm25` function takes a query, processes it, and calculates BM25 scores for each document in the corpus based on the query.

**7. Find Best Key Quote:**

The `find_best_key_quote` function identifies the most relevant passage in each document that matches the query terms.

**8. Return Search Results:**

*   **Compile Results:** The keyword search function compiles the top matching documents into a Pandas DataFrame, including details like document ID, source, summary, keywords, BM25 score, and the most relevant quote from each document.

```
# Keyword Search: Download model & encode corpus

# Import necessary libraries for BM25, text processing, and data loading
from rank_bm25 import BM25Okapi
from sentence_transformers import SentenceTransformer
import nltk
from nltk.tokenize import word_tokenize, sent_tokenize
from nltk.corpus import stopwords
from langchain_community.document_loaders import JSONLoader

# Initialize Sentence Transformer Encoder for potential later use
encoder_name = "all-MiniLM-L6-v2"
encoder = SentenceTransformer(encoder_name)

# Download necessary NLTK resources for text tokenization and stopwords
nltk.download('punkt')
nltk.download('stopwords')

# Define stop words (common words that are usually filtered out in searches)
stop_words = set(stopwords.words('english'))

# Function to extract metadata from each document for BM25 indexing
def extract_metadata_for_bm25(record, metadata=None):
    if metadata is None:
        metadata = {}
    text_id = record.get("text_id", "N/A")  # Extract text ID
    full_text = record.get('full_text', "N/A")  # Extract full text of the document
    summary = record.get("summary", "N/A")  # Extract summary
    keywords = record.get("keywords", "N/A").replace("Keywords: ", "").split(", ")  # Extract and process keywords

    # Combine full text, summary, and keywords for BM25 indexing
    combined_text = f"{full_text} {summary} {' '.join(keywords)}"
    metadata.update({
        "Document ID": text_id,
        "full_text": combined_text,
        "source": record.get("source", "N/A"),  # Extract source information
        "summary": summary,
        "keywords": keywords
    })
    return metadata

# Function to load documents from a JSON file and preprocess them for BM25 indexing
def load_and_encode_documents_bm25(file_path):
    # Load documents using JSONLoader
    loader = JSONLoader(file_path, jq_schema='.[]', content_key="full_text", metadata_func=extract_metadata_for_bm25)
    docs = loader.load()
    bm25_texts = [doc.metadata['full_text'] for doc in docs]  # Extract full texts for BM25 processing

    # Preprocess text by tokenizing, converting to lowercase, and removing stop words
    def preprocess(text):
        tokens = word_tokenize(text.lower())
        return [token for token in tokens if token not in stop_words]

    # Initialize BM25 with preprocessed texts
    bm25 = BM25Okapi([preprocess(text) for text in bm25_texts])
    return docs, bm25

# Load and encode documents for BM25 keyword search
docs_bm25, bm25 = load_and_encode_documents_bm25(file_path)

# Function to perform a BM25 keyword search on the document corpus
def keyword_search_bm25(bm25, query, docs, encoder, limit):
    # Preprocess query by tokenizing and filtering out stop words
    tokenized_query = word_tokenize(query.lower())
    filtered_query = [word for word in tokenized_query if word not in stop_words]

    # Get BM25 scores for each document based on the query
    bm25_scores = bm25.get_scores(filtered_query)
    sorted_indices = sorted(range(len(bm25_scores)), key=lambda i: -bm25_scores[i])

    results = []

    # Collect top matching documents based on BM25 scores
    for idx in sorted_indices[:limit]:
        doc = docs[idx]
        key_quote = find_best_key_quote(doc.metadata['full_text'], query)  # Find best matching quote in the document
        results.append({
            'Query': query,
            'Document ID': doc.metadata['Document ID'],
            'Key Quote': key_quote,
            'Source': doc.metadata.get('source', 'N/A'),
            'Summary': doc.metadata.get('summary', 'N/A'),
            'Keywords': ', '.join(doc.metadata.get('keywords', [])),
            'BM25 Score': bm25_scores[idx],
            'Model': 'BM25'
        })

    return pd.DataFrame(results)

# Function to find the best matching quote in a document based on the query
def find_best_key_quote(full_text, query):
    query_terms = set([word.lower() for word in word_tokenize(query) if word not in stop_words])

    # Find all matches of the query terms in the full text
    pattern = re.compile(r'\b(?:' + '|'.join(re.escape(term) for term in query_terms) + r')\b', re.IGNORECASE)
    matches = [(m.start(), m.end()) for m in pattern.finditer(full_text)]

    if not matches:
        return full_text[:500]  # Fallback to the first 500 characters if no matches are found

    # Split text into sentences
    sentences = sent_tokenize(full_text)
    sentence_indices = [i for i, sentence in enumerate(sentences) if pattern.search(sentence)]

    if not sentence_indices:
        return full_text[:500]  # Fallback to the first 500 characters if no matching sentence is found

    best_index = sentence_indices[0]

    # Select two sentences before and after the matched sentence
    start_index = max(best_index - 2, 0)
    end_index = min(best_index + 3, len(sentences))

    best_window = ' '.join(sentences[start_index:end_index])

    return best_window

# Encoding Lincoln corpus and metadata for keyword search with BM25
docs_bm25, bm25 = load_and_encode_documents_bm25(file_path)
```

With keyword search with BM25 now enabled, let's see it at work with this query:

```
# Keyword Search: Set Query

query = "How did Lincoln regard Japan?"
```

Using this code, we will search the Lincoln speech corpus:

```
# Keyword Search: Corpus Search

from IPython.display import display, HTML

# Function to highlight specific keywords in text
def highlight_keywords(text, keywords):
    escaped_keywords = [re.escape(keyword.strip()) for keyword in keywords]
    highlighted_text = text

    for keyword in escaped_keywords:
        keyword_pattern = re.compile(r'\b' + keyword + r'\b', re.IGNORECASE)
        highlighted_text = keyword_pattern.sub(r'<mark>\g<0></mark>', highlighted_text)

    return highlighted_text

bm25_results_df = keyword_search_bm25(bm25, query, docs_bm25, encoder, limit=5)


# Define the keywords to highlight
keywords_to_highlight = ["Lincoln", "regard", "Japan"]

# Apply the highlight_keywords function to Key Quote and Summary columns
bm25_results_df['Key Quote'] = bm25_results_df['Key Quote'].apply(lambda x: highlight_keywords(x, keywords_to_highlight))
bm25_results_df['Summary'] = bm25_results_df['Summary'].apply(lambda x: highlight_keywords(x, keywords_to_highlight))

# Apply the highlight_keywords function to the Keywords column with the same specified keywords
bm25_results_df['Keywords'] = bm25_results_df['Keywords'].apply(lambda x: highlight_keywords(x, keywords_to_highlight))

# Display the final DataFrame as HTML
bm25_results_html = bm25_results_df.head().to_html(escape=False)
display(HTML(bm25_results_html))
```

Previous exploration reveals that Japan is mentioned exactly three times in the Miller Center corpus, in Lincoln's Annual Messages to Congress in 1862, 1863, and 1864. Using the output from this code, we can see BM25 successfully found these matches:

> **Query: How did Lincoln regard <mark>Japan</mark>?**

> **Document ID:** Text #: 72  
> **Key Quote:** "...Owing to the peculiar situation of <mark>Japan</mark>, and the anomalous form of its government..."  
> **Source:** Fourth Annual Message. December 6, 1864  
> **Summary:**  
> In this message, <mark>Lincoln</mark> discusses the situation in China, where rebellion has been suppressed, and <mark>Japan</mark>, where progress has been made in performing treaty stipulations.  
> **Keywords:** Foreign relations, Mexico, civil war, Central America, river survey, overland telegraph, South American states, San Domingo, Liberia, China, <mark>Japan</mark>, treaty stipulations.  
> **BM25 Score:** 6.996904  

---

> **Document ID:** Text #: 66  
> **Key Quote:** "...our relations with <mark>Japan</mark> have been brought into serious jeopardy..."  
> **Source:** Third Annual Message. December 8, 1863  
> **Summary:** In this message, President <mark>Lincoln</mark> discusses issues with <mark>Japan</mark>, improvements in the consular system, and the importance of international telegraph connections.  
> **Keywords:** International telegraph, Atlantic ocean, <mark>Japan</mark>, consular system, foreign relations.  
> **BM25 Score:** 6.767199  

---

> **Document ID:** Text #: 58  
> **Key Quote:** "...favorable relations also continue to be maintained with Turkey, Morocco, China, and <mark>Japan</mark>..."  
> **Source:** Second Annual Message. December 1, 1862  
> **Summary:** <mark>Lincoln</mark> describes the favorable relations maintained with foreign states, including <mark>Japan</mark>, and improved relations with neighboring countries in the Americas.  
> **Keywords:** Foreign relations, <mark>Japan</mark>, commercial treaty, Sultan of Turkey, Liberia, Haiti.  
> **BM25 Score:** 6.423327  

Table 2: BM25 Keyword Search Results

As the search results demonstrate, we see the three Annual Messages displayed, with the mentions of 'Japan' highlighted in yellow in the 'Key Quote', 'Summary', and 'Keywords' columns. Other terms in the query, such as 'Lincoln' and 'regard', are also highlighted, demonstrating how extraneous terms in a search can create noise and potentially crowd out relevant matches.

While keyword search is effective for many types of queries, adding additional methods will make the Retriever more robust. In the next section we'll explore one such method, semantic search with text embeddings.

## Semantic Search (with Qdrant)

Semantic search aims to improve search relevance by understanding the meaning of words and phrases rather than relying solely on keyword matching. For this, we use text embeddings, which transforms text into numerical vectors that capture semantic meaning.

For this lesson, we are using the ['all-MiniLM-L6-v2'](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2) model, which is an open-source, lightweight embedding model from the [Sentence Transformer](https://sbert.net/) library. [Qdrant](https://github.com/qdrant/qdrant) is a framework for locally using this model to convert text to embeddings and store them in a vector database for querying. As interest in RAG and LLMs has expanded, intense competition has emerged between services offering text embedding and semantic search. [This leaderboard](https://huggingface.co/spaces/mteb/leaderboard) from HuggingFace offers a quick rundown of leading embedding models.

The code below demonstrates how the semantic search process is implemented:

**1. Download and Prepare Qdrant and Sentence Transformer:**

This section installs and imports necessary libraries for semantic search. Qdrant is a vector similarity search engine that we use to store and query text embeddings. Sentence Transformers from HuggingFace provide pre-trained models to create these embeddings.

**2. Define Custom Stopwords:**

Custom stopwords are defined to remove common but irrelevant words from queries, ensuring better focus on meaningful terms. The term "Lincoln" has been excluded here, as its presence was found to distort search results. Repeated testing over known texts/queries can help determine whether particular search terms should be excluded.

**3. Metadata Extraction and Document Encoding:**

Metadata is extracted for each document and encoded. Unlike in keyword search, for this approach, we will only include the full text of the Lincoln corpus, but not the rest of the corpus metadata.

**4. Perform Semantic Search with Qdrant:**

Using Qdrant, we search for documents that are semantically similar to the query, using a process called cosine similarity.

**5. Compile and Display Search Results:**

The search results include documents with their semantic scores, most relevant quotes, sources, summaries, and keywords. We also identify similar words within the documents to highlight how they relate to the query.

```
# Semantic Search: Download model and encode corpus

from qdrant_client import QdrantClient, models
from sentence_transformers import SentenceTransformer
from scipy.spatial.distance import cosine
import nltk
from nltk.tokenize import word_tokenize, sent_tokenize
from nltk.corpus import stopwords
import pandas as pd
import re

# Parameters
collection_name = "lincoln_speeches"  # Name of the collection in Qdrant
encoder_name = "all-MiniLM-L6-v2"  # Name of the sentence transformer model
limit = 10  # Number of results to return

# Initialize Sentence Transformer Encoder
encoder = SentenceTransformer(encoder_name)

# Define custom stopwords including 'Lincoln'
custom_stopwords = set(stopwords.words('english')).union({"lincoln"})

# Function to preprocess the query by tokenizing and removing stopwords
def preprocess_query(query):
    """
    Preprocess the query by tokenizing, converting to lowercase, and removing stopwords.

    Args:
    query (str): The input query string.

    Returns:
    str: The preprocessed query.
    """
    tokens = word_tokenize(query.lower())
    filtered_tokens = [word for word in tokens if word not in custom_stopwords]
    return " ".join(filtered_tokens)

# Function to extract metadata from each document for Qdrant indexing
def extract_metadata_for_qdrant(record, metadata=None):
    """
    Extract metadata from a document for Qdrant indexing.

    Args:
    record (dict): The document record.
    metadata (dict, optional): An existing metadata dictionary to update. Defaults to None.

    Returns:
    dict: The updated metadata dictionary.
    """
    if metadata is None:
        metadata = {}
    text_id = record.get("text_id", "N/A")
    full_text = record.get("full_text", "N/A")
    source = record.get("source", "N/A")
    summary = record.get("summary", "N/A")
    keywords = record.get("keywords", "").replace("Keywords: ", "").split(", ")

    combined_text = f"{full_text} {' '.join(keywords)}"

    metadata.update({
        "Document ID": text_id,
        "combined_text": combined_text,
        "full_text": full_text,
        "source": source,
        "summary": summary,
        "keywords": keywords
    })

    return metadata

# Function to load and encode documents for Qdrant
def load_and_encode_documents_qdrant(file_path, collection_name, encoder_name):
    """
    Load documents from a JSON file, encode them using a sentence transformer, and upload to Qdrant.

    Args:
    file_path (str): Path to the JSON file containing the documents.
    collection_name (str): Name of the Qdrant collection.
    encoder_name (str): Name of the sentence transformer model.

    Returns:
    tuple: A tuple containing the list of documents and the Qdrant client instance.
    """
    encoder = SentenceTransformer(encoder_name)
    loader = JSONLoader(file_path, jq_schema='.[]', content_key="full_text", metadata_func=extract_metadata_for_qdrant)
    docs = loader.load()

    # Initialize Qdrant client with in-memory storage
    qdrant_client = QdrantClient(":memory:")
    qdrant_client.recreate_collection(
        collection_name=collection_name,
        vectors_config=models.VectorParams(
            size=encoder.get_sentence_embedding_dimension(),
            distance=models.Distance.COSINE
        )
    )

    # Prepare records for Qdrant
    records = [
        models.Record(
            id=idx,
            vector=encoder.encode(doc.metadata['combined_text']).tolist(),
            payload=doc.metadata
        ) for idx, doc in enumerate(docs)
    ]

    # Upload records to Qdrant
    qdrant_client.upload_records(collection_name=collection_name, records=records)

    return docs, qdrant_client

def vector_search_qdrant_with_similar_words(qdrant_client, collection_name, query_vector, query, limit):
    """
    Perform vector search with Qdrant and find similar words in the relevant sentences.

    Args:
    qdrant_client (QdrantClient): The Qdrant client instance.
    collection_name (str): Name of the Qdrant collection.
    query_vector (list): The query vector.
    query (str): The original query string.
    limit (int): Number of results to return.

    Returns:
    pd.DataFrame: DataFrame containing search results with additional metadata.
    """
    # Perform a vector search in Qdrant
    hits = qdrant_client.search(
        collection_name=collection_name,
        query_vector=query_vector.tolist(),
        limit=limit
    )

    results_df = pd.DataFrame(columns=[
        'Query', 'Document ID', 'Key Quote', 'Source', 'Summary', 'Keywords',
        'Semantic Score', 'Similar Words', 'Model'
    ])

    for hit in hits:
        full_text = hit.payload["full_text"]
        text_id = hit.payload["Document ID"]
        source = hit.payload.get("source", "N/A")
        summary = hit.payload.get("summary", "N/A")
        keywords = hit.payload.get("keywords", "")

        # Split the full text into sentences
        sentences = sent_tokenize(full_text)

        # Encode each sentence using the sentence transformer model
        sentence_embeddings = encoder.encode(sentences)

        # Calculate cosine similarity between the query vector and each sentence vector
        sentence_similarities = [1 - cosine(query_vector, sent_vec.tolist()) for sent_vec in sentence_embeddings]

        # Identify the index of the highest scoring sentence (most similar to the query)
        highest_scoring_sentence_idx = sentence_similarities.index(max(sentence_similarities))

        # Determine the number of sentences to include around the highest scoring sentence
        num_sentences_around = 3  # Number of sentences to include before and after the best match

        # Calculate the start and end indices for the sentences to include
        start_sentence_idx = max(0, highest_scoring_sentence_idx - num_sentences_around)
        end_sentence_idx = min(len(sentences), highest_scoring_sentence_idx + num_sentences_around + 1)

        # Extract the relevant sentences around the highest scoring sentence
        relevant_sentences = " ".join(sentences[start_sentence_idx:end_sentence_idx])

        # Extract words from the relevant sentences
        words = set(word_tokenize(relevant_sentences.lower()))

        # Encode each word in the relevant sentences
        word_embeddings = {word: encoder.encode([word])[0] for word in words}

        # Encode the query
        query_embedding = encoder.encode([query])[0]

        # Compute similarity between the query embedding and each word embedding
        similar_words = compute_similarity(word_embeddings, query_embedding)

        # Get the top 5 similar words with their similarity scores
        top_similar_words = similar_words[:5]

        new_row = {
            "Query": query,
            "Document ID": text_id,
            "Key Quote": relevant_sentences,
            "Source": source,
            "Summary": summary,
            "Keywords": ", ".join(keywords),
            "Semantic Score": max(sentence_similarities),
            "Similar Words": [(word, round(score, 4)) for word, score in top_similar_words],
            "Model": "Qdrant"
        }

        results_df = pd.concat([results_df, pd.DataFrame([new_row])], ignore_index=True)

    # Sort results by Semantic Score in descending order
    results_df.sort_values(by='Semantic Score', ascending=False, inplace=True)
    results_df.reset_index(drop=True, inplace=True)

    return results_df


# Function to compute similarity between word embeddings and query embedding
def compute_similarity(word_embeddings, query_embedding):
    """
    Compute similarity between word embeddings and query embedding.

    Args:
    word_embeddings (dict): Dictionary of word embeddings.
    query_embedding (list): The query embedding.

    Returns:
    list: List of tuples containing words and their similarity scores, sorted by similarity.
    """
    similarities = []
    for word, embedding in word_embeddings.items():
        similarity = 1 - cosine(query_embedding, embedding)
        similarities.append((word, similarity))
    return sorted(similarities, key=lambda x: -x[1])

# Load and encode documents for Qdrant
docs_qdrant, qdrant_client = load_and_encode_documents_qdrant(file_path, collection_name, encoder_name)
```

We'll now set a new query about Lincoln's use of religious imagery to demonstrate semantic search. This query would be difficult to achieve with keyword search, but with semantic search we can quickly survey Lincoln's speeches on this topic.

```
# Semantic Search: Set Query

query = "How did Lincoln use religious imagery?"
```

This code block runs the query against the corpus using semantic search and highlights the most semantically similar results:

```
# Semantic Search: Corpus Search

# Functions for highlighting results

# Highlight Similar Words Function
def highlight_similar_words(text, similar_words):
    if not isinstance(text, str):
        return text  # If the input is not a string, return it as-is

    highlighted_text = text
    for word, similarity in similar_words:
        escaped_word = re.escape(word.strip())
        color = get_color(similarity)
        word_pattern = re.compile(r'\b' + escaped_word + r'\b', re.IGNORECASE)
        highlighted_text = word_pattern.sub(fr'<mark style="background-color: {color};">\g<0></mark>', highlighted_text)

    return highlighted_text


# Apply Highlighting Function
def apply_highlighting(df):
    if 'Key Quote' in df.columns and 'Similar Words' in df.columns:
        df['Key Quote'] = df.apply(lambda x: highlight_similar_words(x['Key Quote'], x['Similar Words']), axis=1)
    return df

def get_color(similarity):
    """Returns a color code based on the similarity score."""
    if similarity > 0.3:
        return '#F88379'  # Coral
    elif similarity > 0.25:
        return '#FA5F55'  # Orange Red
    elif similarity > 0.2:
        return '#ff7f00'  # Orange
    elif similarity > 0.15:
        return '#ffbf00'  # Amber
    else:
        return '#ffff00'  # Yellow


# Preprocess and encode the query to drop custom stopwords
preprocessed_query = preprocess_query(query)
query_vector = encoder.encode(preprocessed_query)

# Perform Qdrant search with similar words
qdrant_results_df = vector_search_qdrant_with_similar_words(qdrant_client, collection_name, query_vector, query, limit)

# Apply highlighting
qdrant_results_df = apply_highlighting(qdrant_results_df)

# Display the final DataFrame as HTML
qdrant_results_html = qdrant_results_df.head().to_html(escape=False)
display(HTML(qdrant_results_html))
```

<div class="table-wrapper" markdown="block">
  <table id="keywordTable" style="border-collapse: collapse; width: 100%;">
    <thead>
      <tr>
        <th style="border: 1px solid black; padding: 8px;">Query</th>
        <th style="border: 1px solid black; padding: 8px;">Key Quote</th>
        <th style="border: 1px solid black; padding: 8px;">Source</th>
        <th style="border: 1px solid black; padding: 8px;">Semantic Score</th>
        <th style="border: 1px solid black; padding: 8px;">Similar Words</th>
        <th style="border: 1px solid black; padding: 8px;">Model</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="border: 1px solid black; padding: 8px;">How did Lincoln use religious imagery?</td>
        <td style="border: 1px solid black; padding: 8px;">
          Both read the same <mark style="background-color: #ff7f00;">Bible</mark>, and pray to the same God; and each invokes His aid against the other. It may seem strange that any men should dare to ask a just God's assistance in wringing their bread from the sweat of other men's faces; but let us judge not that we be not judged. The <mark style="background-color: #FA5F55;">prayers</mark> of both could not be answered; that of neither has been answered fully. The Almighty has His own purposes. "Woe unto the world because of offences! for it must needs be that offences come; but woe to that man by whom the offence cometh!" If we shall suppose that American <mark style="background-color: #ff7f00;">Slavery</mark> is one of those offences which, in the providence of God, must needs come, but which, having continued through His appointed time, He now wills to remove, and that He gives to both North and <mark style="background-color: #ffff00;">South</mark>, this terrible war, as the woe due to those by whom the offence came, shall we discern therein any departure from those divine attributes which the <mark style="background-color: #FA5F55;">believers</mark> in a Living God always ascribe to Him?
        </td>
        <td style="border: 1px solid black; padding: 8px;">Source: Second Inaugural Address. March 4, 1865.</td>
        <td style="border: 1px solid black; padding: 8px;">0.407594</td>
        <td style="border: 1px solid black; padding: 8px;">[(<mark style="background-color: #ff7f00;">slavery</mark>, 0.3058), (<mark style="background-color: #FA5F55;">prayers</mark>, 0.2878), (<mark style="background-color: #FA5F55;">believers</mark>, 0.2873), (<mark style="background-color: #ff7f00;">bible</mark>, 0.2752), (<mark style="background-color: #ffff00;">south</mark>, 0.206)]</td>
        <td style="border: 1px solid black; padding: 8px;">Qdrant</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px;">How did Lincoln use religious imagery?</td>
        <td style="border: 1px solid black; padding: 8px;">
          "But NOW it is to be transformed into a <mark style="background-color: #FA5F55;">sacred</mark> right.'' <mark style="background-color: #FA5F55;">Nebraska</mark> brings it forth, places it on the high road to extension and perpetuity; and, with a pat on its back, says to it, Go, and <mark style="background-color: #ffff00;">God</mark> speed you.'' Henceforth it is to be the chief jewel of the nation---the very <mark style="background-color: #ffff00;">figure-head</mark> of the ship of State. Little by little, but steadily as man's march to the grave, we have been giving up the OLD for the NEW <mark style="background-color: #ffbf00;">faith</mark>.
        </td>
        <td style="border: 1px solid black; padding: 8px;">Source: At Peoria, Illinois. October 16, 1854.</td>
        <td style="border: 1px solid black; padding: 8px;">0.378523</td>
        <td style="border: 1px solid black; padding: 8px;">[(<mark style="background-color: #FA5F55;">sacred</mark>, 0.3082), (<mark style="background-color: #ffbf00;">faith</mark>, 0.2996), (<mark style="background-color: #FA5F55;">nebraska</mark>, 0.2857), (<mark style="background-color: #ffff00;">figure-head</mark>, 0.1959), (<mark style="background-color: #ffff00;">god</mark>, 0.1914)]</td>
        <td style="border: 1px solid black; padding: 8px;">Qdrant</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px;">How did Lincoln use religious imagery?</td>
        <td style="border: 1px solid black; padding: 8px;">
          If you are, you should say so plainly. If you are not for force, nor yet for dissolution, there only remains some <mark style="background-color: #ffff00;">imaginable</mark> compromise. I do not <mark style="background-color: #ffff00;">believe</mark> any compromise, embracing the maintenance of the Union, is now possible. All I learn, leads to a directly opposite <mark style="background-color: #FA5F55;">belief</mark>. The strength of the <mark style="background-color: #FA5F55;">rebellion</mark>, is its military---its army. That army dominates all the country, and all the people, within its range. Any offer of terms made by any man or men within that range, in opposition to that army, is <mark style="background-color: #ffbf00;">simply</mark> nothing for the present; because such man or men, have no power whatever to enforce their side of a compromise, if one were made with them.
        </td>
        <td style="border: 1px solid black; padding: 8px;">Source: Public Letter to James Conkling. August 26, 1863</td>
        <td style="border: 1px solid black; padding: 8px;">0.358343</td>
        <td style="border: 1px solid black; padding: 8px;">[(<mark style="background-color: #FA5F55;">belief</mark>, 0.2946), (<mark style="background-color: #FA5F55;">rebellion</mark>, 0.2339), (<mark style="background-color: #ffbf00;">simply</mark>, 0.1894), (<mark style="background-color: #ffff00;">imaginable</mark>, 0.1741), (<mark style="background-color: #ffff00;">believe</mark>, 0.1654)]</td>
        <td style="border: 1px solid black; padding: 8px;">Qdrant</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px;">How did Lincoln use religious imagery?</td>
        <td style="border: 1px solid black; padding: 8px;">
          Here I have lived a quarter of a century, and have passed from a young to an old man. Here my children have been born, and one is buried. I now leave, not knowing when, or whether ever, I may return, with a task before me greater than that which rested upon Washington. <mark style="background-color: #ffff00;">Without</mark> the assistance of that <mark style="background-color: #ffbf00;">Divine</mark> Being, who ever attended him, I cannot succeed. With that assistance I cannot fail. Trusting in Him, who can go with me, and remain with you and be every where for good, let us confidently hope that all will yet be well. To His care <mark style="background-color: #ffbf00;">commending</mark> you, as I hope in your <mark style="background-color: #FA5F55;">prayers</mark> you will <mark style="background-color: #ffff00;">commend</mark> me, I bid you an affectionate farewell."
        </td>
        <td style="border: 1px solid black; padding: 8px;">Source: Farewell Address. February 11, 1861.</td>
        <td style="border: 1px solid black; padding: 8px;">0.354218</td>
        <td style="border: 1px solid black; padding: 8px;">[(<mark style="background-color: #FA5F55;">prayers</mark>, 0.2878), (<mark style="background-color: #ffbf00;">commending</mark>, 0.2334), (<mark style="background-color: #ffbf00;">divine</mark>, 0.1956), (<mark style="background-color: #ffff00;">commend</mark>, 0.1729), (<mark style="background-color: #ffff00;">without</mark>, 0.1723)]</td>
        <td style="border: 1px solid black; padding: 8px;">Qdrant</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px;">How did Lincoln use religious imagery?</td>
        <td style="border: 1px solid black; padding: 8px;">
          The brave men, living and dead, who struggled here, have <mark style="background-color: #ffff00;">consecrated</mark> it, far above our poor power to add or detract. The world will little note, nor long remember what we say here, but it can never forget what they did here. It is for us the living, rather, to be dedicated here to the unfinished work which they who fought here have thus far so nobly advanced. It is rather for us to be here dedicated to the great task remaining before us—that from these honored dead we take increased <mark style="background-color: #ff7f00;">devotion</mark> to that cause for which they gave the last full measure of <mark style="background-color: #ff7f00;">devotion—that</mark> we here highly resolve that these dead shall not have died in vain—that this nation, under <mark style="background-color: #ffff00;">God</mark>, shall have a new birth of <mark style="background-color: #ffbf00;">freedom—and</mark> that government of the people, by the people, for the people, shall not perish from the earth."
        </td>
        <td style="border: 1px solid black; padding: 8px;">Source: Gettysburg Address. November 19, 1863</td>
        <td style="border: 1px solid black; padding: 8px;">0.316688</td>
        <td style="border: 1px solid black; padding: 8px;">[(<mark style="background-color: #ff7f00;">devotion</mark>, 0.3719), (<mark style="background-color: #ff7f00;">devotion—that</mark>, 0.3662), (<mark style="background-color: #ffbf00;">freedom—and</mark>, 0.2843), (<mark style="background-color: #ffff00;">god</mark>, 0.1914), (<mark style="background-color: #ffff00;">consecrated</mark>, 0.1755)]</td>
        <td style="border: 1px solid black; padding: 8px;">Qdrant</td>
      </tr>
    </tbody>
  </table>
</div>


Table 3: Semantic Keyword Search Results

In the results above we can see the terms identified by Qdrant as possessing greatest semantic similarity. The different colors reflect the varying degree of semantic similarity with the query, offering a set of results utilizing terms as varied as "sacred", "belief", "faith", "prayers", "consecrated", "God", and "Bible".

In our final search method, we'll explore how to augment semantic search with contextual search using ColBERT.

## Contextual Search (with ColBERT)

[ColBERT](https://github.com/stanford-futuredata/ColBERT) (Contextualized Late Interaction over BERT) is a retrieval model designed to enhance RAG applications by capturing the contextual relationships between query terms and document terms. Unlike traditional keyword matching or semantic search, ColBERT allows for a more nuanced understanding of context. For instance, in a historical document, the term "state" could refer to a political entity or a condition of being. ColBERT can calculate the difference by analyzing surrounding words and phrases, offering more precise and granular search results. ColBERT has also been trained on multilingual text collections, making it particularly attractive for diverse datasets.

For implementing ColBERT, we'll use the [RAGatouille](https://github.com/bclavie/ragatouille) library to load this model to implement RAG tasks. RAGatouille builds a custom index of the corpus for search and retrieval. The initial process of building an index takes some time (approximately five minutes for this corpus), but once the index has been created, subsequent searches run quite quickly, and the index can be saved for reuse.

The code below demonstrates how ColBERT is implemented with RAGatouille:

**1. Download and Prepare the Model and Data**
Install and import the necessary libraries. Custom functions are defined to preprocess the text and query, ensuring that common but irrelevant words (stopwords) are removed to improve the focus of the search.

**2. Metadata Extraction and Document Encoding**
The `extract_metadata_for_colbert` function extracts relevant metadata from each document and combines the full text, summary, and keywords for indexing. This is similar to the preprocessing steps for BM25 and Qdrant.

**3. Loading and Encoding Documents**
The documents are loaded and encoded using a Sentence Transformer model. This involves converting the text into high-dimensional vectors that capture semantic meaning.

**4. Setting Up ColBERT with RAGatouille**
RAGatouille is the library for using ColBERT and simplifies the setup of ColBERT by providing utilities for training, fine-tuning, and indexing.

**5. Performing Contextual Search**
The `rag_search_with_scores` function performs a search using the ColBERT model. It preprocesses the query, retrieves the most relevant documents, and finds the best matching sentences within each document.

```
# Contextual Search: Download model & load data

# Import necessary libraries
from ragatouille import RAGPretrainedModel
from langchain_community.document_loaders import JSONLoader
from sentence_transformers import SentenceTransformer
import pandas as pd
import re


# Set parameters for ColBERT and the encoder
k = 10
index_name = "LincolnCorpus_1"
encoder_name = "all-MiniLM-L6-v2"
encoder = SentenceTransformer(encoder_name)

# Function to extract metadata from documents
def extract_metadata_for_colbert(record, metadata=None):
    """Extracts and combines metadata from a record for indexing."""
    if metadata is None:
        metadata = {}
    text_id = record.get("text_id", "N/A")
    full_text = record.get("full_text", "N/A")
    source = record.get("source", "N/A")
    summary = record.get("summary", "N/A")
    keywords = record.get("keywords", "N/A")
    keywords = keywords.replace("Keywords: ", "").split(", ")

    combined_text = f"{full_text} {summary} {' '.join(keywords)}"
    metadata.update({
        "Document ID": text_id,
        "full_text": full_text,
        "source": source,
        "summary": summary,
        "keywords": keywords,
        "combined_text": combined_text
    })
    return metadata

# Function to setup RAGatouille model and index documents
def setup_ragatouille(document_ids, document_texts, index_name, base_index_dir=".ragatouille/colbert/indexes"):
    """Sets up the RAGatouille model and indexes documents. If an index exists, loads it; otherwise, creates a new one."""
    path_to_index = os.path.join(base_index_dir, index_name)
    if os.path.exists(path_to_index):
        print(f"Loading existing RAGatouille index from: {path_to_index}")
        rag_model = RAGPretrainedModel.from_index(path_to_index)
    else:
        print(f"Creating new RAGatouille index at: {path_to_index}")
        os.makedirs(path_to_index, exist_ok=True)
        rag_model = RAGPretrainedModel.from_pretrained("colbert-ir/colbertv2.0")
        rag_model.index(
            collection=document_texts,
            document_ids=document_ids,
            index_name=index_name,
            max_document_length=90,
            split_documents=True
        )
    return rag_model, path_to_index

# Function to load and encode documents for ColBERT
def load_and_encode_documents_colbert(file_path):
    """Loads documents and encodes them using a sentence transformer model."""
    loader = JSONLoader(file_path, jq_schema='.[]', content_key="full_text", metadata_func=extract_metadata_for_colbert)
    docs = loader.load()
    document_ids = [doc.metadata['Document ID'] for doc in docs]
    document_texts = [doc.metadata['full_text'] for doc in docs]
    return docs, document_ids, document_texts

# Function to find the best matching quote and compute similarity scores
def find_best_key_quote_with_scores(full_text, query, encoder):
    """Finds the best matching quote in the text and computes similarity scores."""
    query_vector = encoder.encode([query])[0]
    sentences = sent_tokenize(full_text)
    sentence_embeddings = encoder.encode(sentences)
    sentence_similarities = [1 - cosine(query_vector, sent_vec) for sent_vec in sentence_embeddings]
    highest_scoring_sentence_idx = sentence_similarities.index(max(sentence_similarities))

    num_sentences_around = 3
    start_sentence_idx = max(0, highest_scoring_sentence_idx - num_sentences_around)
    end_sentence_idx = min(len(sentences), highest_scoring_sentence_idx + num_sentences_around + 1)
    best_window = ' '.join(sentences[start_sentence_idx:end_sentence_idx])

    return best_window, sentence_similarities, sentences

# Function to perform ColBERT search and score results
def rag_search_with_scores(rag_model, original_query, preprocessed_query, metadata_mapping, encoder, k=5):
    """Performs a ColBERT search and scores the results."""
    results = rag_model.search(query=preprocessed_query, k=k)
    seen_docs = set()
    augmented_results = []

    for result in results:
        doc_id = result['document_id']
        if doc_id in seen_docs:
            continue
        seen_docs.add(doc_id)

        metadata = metadata_mapping.get(doc_id, {})
        full_text = metadata.get('full_text', 'N/A')
        key_quote, sentence_similarities, sentences = find_best_key_quote_with_scores(full_text, preprocessed_query, encoder)

        augmented_result = {
            'Query': original_query,
            'Document ID': doc_id,
            'Key Quote': key_quote,
            'Source': metadata.get('source', 'N/A'),
            'Summary': metadata.get('summary', 'N/A'),
            'Keywords': metadata.get('keywords', 'N/A'),
            'ColBERT Score': result['score'],
            'Model': 'ColBERT',
            'Sentence Similarities': sentence_similarities,
            'Sentences': sentences
        }
        augmented_results.append(augmented_result)

    results_df = pd.DataFrame(augmented_results)
    return results_df

# Main Execution - Integrate ColBERT Search with Relevant Passage Extraction
docs_colbert, document_ids, document_texts = load_and_encode_documents_colbert(file_path)
metadata_mapping = {doc.metadata['Document ID']: doc.metadata for doc in docs_colbert}

rag_model, _ = setup_ragatouille(document_ids, document_texts, index_name)
```

To demonstrate contextual search, we will offer a broad query on Lincoln's view of democracy.

```
# Contextual Search: Set Query

query = "How did Lincoln regard democracy as a form of government?"
```

The code below runs the query against the Lincoln corpus with ColBERT, with the highest scoring sentence highlighted:

```
# Contextual Search: Corpus Search

def highlight_highest_scoring_sentence(text, sentences, similarities):
    max_similarity = max(similarities)
    highest_scoring_sentence = sentences[similarities.index(max_similarity)]
    highlighted_text = text.replace(highest_scoring_sentence, f'<mark style="background-color: #F88379;">{highest_scoring_sentence}</mark>')
    return highlighted_text

def apply_highlighting_colbert(df):
    if 'Key Quote' in df.columns and 'Sentence Similarities' in df.columns and 'Sentences' in df.columns:
        df['Key Quote'] = df.apply(lambda x: highlight_highest_scoring_sentence(x['Key Quote'], x['Sentences'], x['Sentence Similarities']), axis=1)
    return df.drop(columns=['Sentence Similarities', 'Sentences'])  # Remove extra columns

query = "How did Lincoln regard democracy as a form of government?"

# Preprocess and encode the query
preprocessed_query = preprocess_query(query)

# Perform ColBERT search
colbert_results_df = rag_search_with_scores(rag_model, query, preprocessed_query, metadata_mapping, encoder, k=limit)


# Apply highlighting and display results
colbert_results_df = apply_highlighting_colbert(colbert_results_df)
colbert_results_html = colbert_results_df.head().to_html(escape=False)
display(HTML(colbert_results_html))
```

<div class="table-wrapper" markdown="block">

<div class="table-wrapper" markdown="block">
  <table id="keywordTable2" style="border-collapse: collapse; width: 100%;">
    <thead>
      <tr>
        <th style="border: 1px solid black; padding: 8px;">Query</th>
        <th style="border: 1px solid black; padding: 8px;">Document ID</th>
        <th style="border: 1px solid black; padding: 8px;">Key Quote</th>
        <th style="border: 1px solid black; padding: 8px;">Source</th>
        <th style="border: 1px solid black; padding: 8px;">Summary</th>
        <th style="border: 1px solid black; padding: 8px;">ColBERT Score</th>
        <th style="border: 1px solid black; padding: 8px;">Model</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard democracy as a form of government?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 46</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">
          Why this deliberate pressing out of view, the rights of men, and the authority of the people? This is essentially a People's contest. On the side of the Union, it is a struggle for maintaining in the world, that form, and substance of government, whose leading object is, to elevate the condition of men---to lift artificial weights from all shoulders---to clear the paths of laudable pursuit for all---to afford all, an unfettered start, and a fair chance, in the race of life. <mark style="background-color: #F88379;">Yielding to partial, and temporary departures, from necessity, this is the leading object of the government for whose existence we contend....</mark>
        </td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: July 4th Message to Congress. July 4, 1861.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Summary: In this excerpt from Abraham Lincoln's July 4 Message to Congress, he emphasizes the importance of preserving the Union and the exceptional nature of the nation's free institutions. He highlights the voluntary nature of the army and the loyalty of common soldiers in the face of rebellion. Lincoln argues that the government must be preserved for the benefit of all citizens and that the conflict is a test of whether the nation can survive internal threats. He assures that, once the rebellion is suppressed, his administration will continue to be guided by the Constitution and the laws. Lastly, he calls for trust in God and urges the nation to move forward without fear and with manly hearts.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">14.210938</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">ColBERT</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard democracy as a form of government?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 41</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">
          Then, and thereby, the assailants of the Government, began the conflict of arms, without a gun in sight, or in expectancy, to return their fire, save only the few in the Fort, sent to that harbor, years before, for their own protection, and still ready to give that protection, in whatever was lawful. In this act, discarding all else, they have forced upon the country, the distinct issue: Immediate dissolution, or blood.'' And this issue embraces more than the fate of these United States. <mark style="background-color: #F88379;">It presents to the whole family of man, the question, whether a constitutional republic, or a democracy---a government of the people, by the same people---can, or cannot, maintain its territorial integrity, against its own domestic foes....</mark>
        </td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: July 4th Message to Congress. July 4, 1861.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Summary: In Abraham Lincoln's July 4 Message to Congress in 1861, he discusses the difficult decision-making process surrounding the events at Fort Sumter. Abandoning the fort was seen as ruinous, as it would discourage Union supporters, embolden adversaries, and potentially lead to foreign recognition of the Confederacy. Lincoln explains that reinforcing Fort Pickens was prioritized to demonstrate the government's resolve. He emphasizes that the assault on Fort Sumter was not an act of self-defense by the assailants, as the government's intentions were merely to maintain visible possession of the fort to preserve the Union. The conflict at Fort Sumter forced the country to face the issue of immediate dissolution or bloodshed, which also raised questions about the viability of a constitutional republic in maintaining territorial integrity against domestic foes.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">13.789062</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">ColBERT</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard democracy as a form of government?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 29</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">
          I fully indorse this, and I adopt it as a text for this discourse. I so adopt it because it furnishes a precise and an agreed starting point for a discussion between Republicans and that wing of the Democracy headed by Senator Douglas. It simply leaves the inquiry: "What was the understanding those fathers had of the question mentioned?" <mark style="background-color: #F88379;">What is the frame of government under which we live?</mark> The answer must be: "The Constitution of the United States."
        </td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: Cooper Union Address. February 27, 1860.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Summary: In his Cooper Union Speech, Abraham Lincoln discusses the understanding of the founding fathers regarding the division of local and federal authority on the issue of slavery in federal territories. He refers to a statement by Stephen Douglas and uses it as a starting point for examining the actions of the founding fathers, who framed the Constitution, on this matter. By analyzing their votes in the Congress of the Confederation and the first Congress under the Constitution, Lincoln shows that many of the founding fathers believed the Federal Government could control slavery in federal territories.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">13.726562</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">ColBERT</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard democracy as a form of government?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 70</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">
          True, the form of an oath is given, but no man is coerced to take it. The man is only promised a pardon in case he voluntarily takes the oath. The Constitution authorizes the Executive to grant or withhold the pardon at his own absolute discretion; and this includes the power to grant on terms, as is fully established by judicial and other authorities. <mark style="background-color: #F88379;">It is also proffered that if, in any of the States named, a State government shall be, in the mode prescribed, set up, such government shall be recognized and guarantied by the United States, and that under it the State shall, on the constitutional conditions, be protected against invasion and domestic violence.</mark> The constitutional obligation of the United States to guaranty to every State in the Union a republican form of government, and to protect the State, in the cases stated, is explicit and full.
        </td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: Third Annual Message. December 8, 1863.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Summary: In this section of the Third Annual Message, President Lincoln discusses the success of emancipation, highlighting that 100,000 former slaves are now serving in the U.S. military, with no signs of servile insurrection or violence. He mentions the improved public sentiment both at home and abroad regarding emancipation and the arming of black soldiers. The president also introduces a proclamation to resume the national authority within States where it has been suspended, which includes an oath of allegiance to the Constitution, Union, and laws regarding slavery. Lincoln asserts that he will not retract or modify the Emancipation Proclamation, nor return any freed person to slavery. He addresses the need for temporary State arrangements for the freed people, hoping to alleviate potential confusion and destitution resulting from the labor revolution.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">13.015625</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">ColBERT</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard democracy as a form of government?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 9</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">
          I say this is the leading principle---the sheet anchor of American republicanism. Our Declaration of Independence says: We hold these truths to be self evident: that all men are created equal; that they are endowed by their Creator with certain inalienable rights; that among these are life, liberty and the pursuit of happiness. That to secure these rights, governments are instituted among men, DERIVING THEIR JUST POWERS FROM THE CONSENT OF THE GOVERNED.'' <mark style="background-color: #F88379;">I have quoted so much at this time merely to show that according to our ancient faith, the just powers of governments are derived from the consent of the governed.</mark>
        </td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: At Peoria, Illinois. October 16, 1854.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Summary: In this passage, Abraham Lincoln addresses the argument of self-government in relation to the repeal of the Missouri Compromise. He asserts that the concept of self-government is fundamentally right but questions its application to the issue of slavery. Lincoln argues that true self-government cannot exist when one person governs another without consent. He cites the Declaration of Independence as the basis of this belief, stating that the just powers of governments come from the consent of the governed. He clarifies that he is not advocating for political and social equality between whites and blacks, but rather arguing against the extension of slavery into new territories. Finally, he discusses the opinions and examples of the founding fathers, asserting that their support for self-government did not extend to carrying slavery into new territories.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">11.960938</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">ColBERT</td>
      </tr>
    </tbody>
  </table>
</div>

Table 4: ColBERT Contextual Search Results

The results and highlighted sections above offer a variety of results reflecting Lincoln's views of democratic governance - such as his words at Peoria in 1854: "...according to our ancient faith, the just powers of governments are derived from the consent of the governed."

### Combined Search: Set Query

In developing a Retriever with a variety of search approaches, we now need to integrate all these methods into a single search process. We will then apply the final element, a reranker, which will order the results for passing on to a LLM.

Let's return to our original query concerning Lincoln's views on Japan.

```
# Combined Search: Set Query

query = "How did Lincoln regard Japan?"
```

### Combined Search of Corpus

```
# Combined Search of Corpus

# Initialize DataFrame to store all results
all_results = pd.DataFrame()

# Perform BM25 search
bm25_results_df = keyword_search_bm25(bm25, query, docs_bm25, encoder, limit=5)

# Perform Qdrant search
preprocessed_query = preprocess_query(query)
query_vector = encoder.encode(preprocessed_query)
qdrant_results_df = vector_search_qdrant_with_similar_words(qdrant_client, collection_name, query_vector, query, limit=5)

# Perform ColBERT search
colbert_results_df = rag_search_with_scores(rag_model, query, preprocessed_query, metadata_mapping, encoder, k=5)

# Combine results from all models
combined_results_df = pd.concat([bm25_results_df, qdrant_results_df, colbert_results_df], ignore_index=True)

# Calculate and print the number of results for each search method
num_bm25_results = len(bm25_results_df)
num_qdrant_results = len(qdrant_results_df)
num_colbert_results = len(colbert_results_df)

print(f"Number of BM25 results: {num_bm25_results}")
print(f"Number of Qdrant results: {num_qdrant_results}")
print(f"Number of ColBERT results: {num_colbert_results}")
```

Output:
```
Number of BM25 results: 5
Number of Qdrant results: 5
Number of ColBERT results: 5
```

## Reranking Search Results (with BGE-Base)

We now have a collection of results for our query from our various search methods. To determine which results are the most relevant, we'll utilize the [BGE-Base reranker](https://huggingface.co/BAAI/bge-reranker-base). This lightweight model can be locally downloaded from HuggingFace. It possesses capabilities in both English and Mandarin ([a larger version](https://huggingface.co/BAAI/bge-reranker-v2-m3) possesses a greater range of multilingual abilities). As with text embedding and semantic search, there is intense competition in this domain. This [HuggingFace leaderboard](https://huggingface.co/spaces/mteb/leaderboard) offers other notable reranking models. Of particular note, the author recommends [Cohere's Rerank](https://docs.cohere.com/docs/overview) model, which offers a high-performing, multilingual model via an API service.

The following code demonstrates how to download and use the BGE-Base reranker model:

**1. Download and Prepare the Model:**
Download the BGE-Base reranker model and its tokenizer from HuggingFace.

**2. Prepare the Input Pairs:**
Create pairs of queries and the corresponding search results ("Key Quotes") from our combined search results. These pairs are fed into the reranker to assess their relevance.

**3. Tokenize the Input Pairs:**
The pairs are tokenized, or converting the text into a format that the model can process.

**4. Compute Reranking Scores:**
Using the model, we compute the logits (raw prediction scores) for each query-result pair. These logits serve as the reranking scores, indicating the relevance of each result to the query.

**5. Sort and Rank the Results:**
The scores are added to the combined results DataFrame, and the results are sorted in descending order based on their reranking scores. The highest-ranked results are the most relevant to the query.

```
# Rerank combined search results

import torch
from transformers import AutoModelForSequenceClassification, AutoTokenizer, AutoModelForCausalLM, BitsAndBytesConfig, pipeline


# Reranker Model
reranker_model_name = "BAAI/bge-reranker-base"

def rerank_with_bge(combined_results_df, query, model_name):
    """Reranks results using the BGE reranker model."""
    tokenizer = AutoTokenizer.from_pretrained(model_name)
    model = AutoModelForSequenceClassification.from_pretrained(model_name)
    model.eval()

    pairs = [
        [
            query,
            f"{row['Key Quote']}"
        ]
        for index, row in combined_results_df.iterrows()
    ]

    with torch.no_grad():
        inputs = tokenizer(pairs, padding=True, truncation=True, return_tensors='pt', max_length=512)
        scores = model(**inputs, return_dict=True).logits.view(-1).float()

    combined_results_df['Reranking Score'] = scores.numpy()
    combined_results_df.sort_values(by='Reranking Score', ascending=False, inplace=True)
    combined_results_df.reset_index(drop=True, inplace=True)

    return combined_results_df

# Rerank combined results using BGE reranker
combined_results_df = rerank_with_bge(combined_results_df, query, reranker_model_name)

# Display reranked results for reference
display(combined_results_df.head())
```

<div class="table-wrapper" markdown="block">
  <table id="simplifiedTable" style="border-collapse: collapse; width: 100%;">
    <thead>
      <tr>
        <th style="border: 1px solid black; padding: 8px;">Query</th>
        <th style="border: 1px solid black; padding: 8px;">Document ID</th>
        <th style="border: 1px solid black; padding: 8px;">Key Quote</th>
        <th style="border: 1px solid black; padding: 8px;">Source</th>
        <th style="border: 1px solid black; padding: 8px;">Model</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard Japan?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 72</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Owing to the peculiar situation of Japan, and ...</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: Fourth Annual Message. December 6, 1864.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Qdrant</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard Japan?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 72</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Owing to the peculiar situation of Japan, and ...</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: Fourth Annual Message. December 6, 1864.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">ColBERT</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard Japan?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 58</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">A commercial and consular treaty has been nego...</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: Second Annual Message. December 1, 1862.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">ColBERT</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard Japan?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 66</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">"In common with other western powers, our rela...</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: Third Annual Message. December 8, 1863.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">BM25</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard Japan?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 58</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">A considerable improvement of the national com...</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: Second Annual Message. December 1, 1862.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">BM25</td>
      </tr>
    </tbody>
  </table>
</div>
Table 5: BGE-Reranker Results

Here we can see the retriever successfully found the three instances were Japan is mentioned in the Lincoln corpus (texts 58, 66, and 72). However, the multiple search methods have also resulted in duplicate results, which could potentially crowd out other relevant matches. The final element in sorting these results is deduplication and final ranking via Reciprocal Rank Fusion.

## Deduplicate and Rank Results Using RRF Scoring

When utilizing multiple search methods in a RAG system, it is common to encounter overlapping results. Different methods might return the same documents or segments due to their relevance to the query. To avoid redundancy and ensure a diverse set of responses, deduplication is essential. This step ensures that each unique result appears only once in the final output, enhancing the clarity and utility of the search results.

The inclusion of Reciprocal Rank Fusion (RRF) adds further precision to the search process. This technique combines the rankings from multiple search methods into a single, unified ranking. The core idea is to reward documents that consistently rank highly across different search methods. RRF calculates a combined score for each document by considering its rank from each method, giving higher scores to documents that are frequently ranked at the top. This approach helps in aggregating the strengths of various retrieval methods, producing a more accurate and relevant set of final results.

The following code demonstrates how to deduplicate and rank search results using RRF scoring:

**1. Initialize DataFrame:** The combined results from all search methods are stored in a DataFrame.

**2. Deduplicate Results:** The DataFrame is sorted by the reranking score, and duplicates are removed based on the document ID.

**3. Calculate RRF Scores:** For each document, the code calculates the RRF score by considering its rank from each search method (BM25, Qdrant, and ColBERT).

**4. Rank and Sort Results:** The results are sorted in descending order based on their RRF scores, ensuring that the most relevant documents appear at the top.

**5. Save and Display Results:** The final ranked results are saved locally to a CSV file and displayed in a structured format.

```
# Deduplicate and Rank Results Using RRF Scoring

def deduplicate_and_rank(combined_results_df, k_parameter=50, base_value=0.03):
    """
    Deduplicates search results and calculates RRF (Reciprocal Rank Fusion) score for ranking.

    Parameters:
    combined_results_df (pd.DataFrame): DataFrame containing combined search results from various models.
    k_parameter (int): A constant parameter for RRF scoring. Default is 50.
    base_value (float): A base value to normalize RRF scores. Default is 0.03.

    Returns:
    pd.DataFrame: Deduplicated and ranked DataFrame based on RRF scores.
    """
    # Deduplicate results based on Document ID and sort by reranking score
    deduplicated_df = combined_results_df.sort_values('Reranking Score', ascending=False).drop_duplicates('Document ID').copy()

    # Calculate ranks for reranking, semantic, ColBERT, and BM25 scores
    deduplicated_df['reranking_rank'] = deduplicated_df['Reranking Score'].rank(ascending=False, method='min')
    deduplicated_df['semantic_rank'] = deduplicated_df['Semantic Score'].rank(ascending=False, method='min')
    deduplicated_df['colbert_rank'] = deduplicated_df['ColBERT Score'].rank(ascending=False, method='min')
    deduplicated_df['bm25_rank'] = deduplicated_df['BM25 Score'].rank(ascending=False, method='min')

    # Initialize RRF scores
    deduplicated_df['RRF'] = 0

    # Calculate RRF scores for Qdrant results
    qdrant_indices = deduplicated_df['Model'] == 'Qdrant'
    valid_qdrant_indices = qdrant_indices & deduplicated_df['semantic_rank'].notna() & deduplicated_df['reranking_rank'].notna()
    deduplicated_df.loc[valid_qdrant_indices, 'RRF'] = (
        1 / (k_parameter + deduplicated_df.loc[valid_qdrant_indices, 'semantic_rank']) +
        1 / (k_parameter + deduplicated_df.loc[valid_qdrant_indices, 'reranking_rank'])
    )

    # Calculate RRF scores for ColBERT results
    colbert_indices = deduplicated_df['Model'] == 'ColBERT'
    valid_colbert_indices = colbert_indices & deduplicated_df['colbert_rank'].notna() & deduplicated_df['reranking_rank'].notna()
    deduplicated_df.loc[valid_colbert_indices, 'RRF'] = (
        1 / (k_parameter + deduplicated_df.loc[valid_colbert_indices, 'colbert_rank']) +
        1 / (k_parameter + deduplicated_df.loc[valid_colbert_indices, 'reranking_rank'])
    )

    # Calculate RRF scores for BM25 results
    bm25_indices = deduplicated_df['Model'] == 'BM25'
    valid_bm25_indices = bm25_indices & deduplicated_df['bm25_rank'].notna() & deduplicated_df['reranking_rank'].notna()
    deduplicated_df.loc[valid_bm25_indices, 'RRF'] = (
        1 / (k_parameter + deduplicated_df.loc[valid_bm25_indices, 'bm25_rank']) +
        1 / (k_parameter + deduplicated_df.loc[valid_bm25_indices, 'reranking_rank'])
    )

    # Normalize and format RRF scores
    deduplicated_df['RRF'] = deduplicated_df['RRF'].apply(lambda x: round((x - base_value) * 10000))
    deduplicated_df['RRF'] = deduplicated_df['RRF'].apply(lambda x: f"{x}%" if x >= 0 else "0%")

    # Sort results by RRF scores in descending order
    deduplicated_df.sort_values(by='RRF', ascending=False, na_position='last', inplace=True)
    deduplicated_df.reset_index(drop=True, inplace=True)

    # Highlight the keyword "Japan" in the 'Key Quote' column
    keyword = "Japan"
    deduplicated_df['Key Quote'] = deduplicated_df['Key Quote'].apply(lambda x: highlight_keyword(x, keyword))

    return deduplicated_df

def highlight_keyword(text, keyword):
    """
    Highlights the specified keyword in the given text.

    Parameters:
    text (str): The input text where the keyword will be highlighted.
    keyword (str): The keyword to be highlighted.

    Returns:
    str: The text with the keyword highlighted.
    """
    highlighted_text = re.sub(rf'(\b{re.escape(keyword)}\b)', r'<mark>\1</mark>', text, flags=re.IGNORECASE)
    return highlighted_text


# Deduplicate and rank results using RRF scoring
final_results_df = deduplicate_and_rank(combined_results_df)

# Drop unwanted columns from the final DataFrame
final_results_df = final_results_df.drop(columns=['Similar Words', 'Sentences'], errors='ignore')

# Rearrange columns in the final DataFrame for better readability
column_order = ['Query', 'Document ID', 'Key Quote', 'Source', 'Summary', 'Keywords', 'Model', 'BM25 Score', 'bm25_rank', 'Semantic Score', 'semantic_rank', 'ColBERT Score', 'colbert_rank', 'Reranking Score', 'reranking_rank', 'RRF']
final_results_df = final_results_df[column_order]

# Save final results to a CSV file
filename = 'final_aggregated_results_with_bge.csv'
filepath = f'/content/{filename}'
final_results_df.to_csv(filepath, index=False)

# Highlight the keyword "Japan" in the 'Key Quote', 'Summary', and 'Keywords' columns
keyword = "Japan"

final_results_df['Key Quote'] = final_results_df['Key Quote'].apply(lambda x: highlight_keyword(x, keyword))
final_results_df['Summary'] = final_results_df['Summary'].apply(lambda x: highlight_keyword(x, keyword))
final_results_df['Keywords'] = final_results_df['Keywords'].apply(lambda x: highlight_keyword(', '.join(x) if isinstance(x, list) else x, keyword))


# Display the final DataFrame as HTML
final_results_df_html = final_results_df.head().to_html(escape=False)
display(HTML(final_results_df_html))

# Display a message indicating that the results are saved
print(f"Final results saved to {filepath}")
```

<div class="table-wrapper" markdown="block">
  <table id="simplifiedTable2" style="border-collapse: collapse; width: 100%;">
    <thead>
      <tr>
        <th style="border: 1px solid black; padding: 8px;">Query</th>
        <th style="border: 1px solid black; padding: 8px;">Document ID</th>
        <th style="border: 1px solid black; padding: 8px;">Key Quote</th>
        <th style="border: 1px solid black; padding: 8px;">Source</th>
        <th style="border: 1px solid black; padding: 8px;">Model</th>
        <th style="border: 1px solid black; padding: 8px;">RRF</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard Japan?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 72</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Owing to the peculiar situation of <mark style="background-color: #ffff00;">Japan</mark>, and the anomalous form of its government, the action of that empire in performing treaty stipulations is inconstant and capricious. Nevertheless, good progress has been effected by the western powers, moving with enlightened concert. Our own pecuniary claims have been allowed, or put in course of settlement, and the inland sea has been reopened to commerce. There is reason also to believe that these proceedings have increased rather than diminished the friendship of <mark style="background-color: #ffff00;">Japan</mark> towards the United States.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: Fourth Annual Message. December 6, 1864.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Qdrant</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">92%</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard Japan?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 58</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">A commercial and consular treaty has been negotiated, subject to the Senate's consent, with Liberia; and a similar negotiation is now pending with the republic of Hayti. A considerable improvement of the national commerce is expected to result from these measures. Our relations with Great Britain, France, Spain, Portugal, Russia, Prussia, Denmark, Sweden, Austria, the Netherlands, Italy, Rome, and the other European states, remain undisturbed. Very favorable relations also continue to be maintained with Turkey, Morocco, China and <mark style="background-color: #ffff00;">Japan</mark>.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: Second Annual Message. December 1, 1862</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">ColBERT</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">88%</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard Japan?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 66</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">In common with other western powers, our relations with <mark style="background-color: #ffff00;">Japan</mark> have been brought into serious jeopardy, through the perverse opposition of the hereditary aristocracy of the empire, to the enlightened and liberal policy of the Tycoon designed to bring the country into the society of nations. It is hoped, although not with entire confidence, that these difficulties may be peacefully overcome. I ask your attention to the claim of the Minister residing there for the damages he sustained in the destruction by fire of the residence of the legation at Yedo.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: Third Annual Message. December 8, 1863.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">BM25</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">85%</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard Japan?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 47</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Fellow Citizens of the Senate and House of Representatives: In the midst of unprecedented political troubles, we have cause of great gratitude to God for unusual good health, and most abundant harvests. You will not be surprised to learn that, in the peculiar exigencies of the times, our intercourse with foreign nations has been attended with profound solicitude, chiefly turning upon our own domestic affairs. A disloyal portion of the American people have, during the whole year, been engaged in an attempt to divide and destroy the Union. A nation which endures factious domestic division, is exposed to disrespect abroad; and one party, if not both, is sure, sooner or later, to invoke foreign intervention.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: First Annual Message. December 3, 1861.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Qdrant</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">77%</td>
      </tr>
      <tr>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">How did Lincoln regard Japan?</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Text #: 48</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">I invite your attention to the correspondence between her Britannic Majesty's minister accredited to this government, and the Secretary of State, relative to the detention of the British ship Perthshire in June last, by the United States steamer Massachusetts, for a supposed breach of the blockade. As this detention was occasioned by an obvious misapprehension of the facts, and as justice requires that we should commit no belligerent act not founded in strict right, as sanctioned by public law, I recommend that an appropriation be made to satisfy the reasonable demand of the owners of the vessel for her detention.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Source: First Annual Message. December 3, 1861.</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">Qdrant</td>
        <td style="border: 1px solid black; padding: 8px; white-space: normal; word-wrap: break-word;">70%</td>
      </tr>
    </tbody>
  </table>
</div>
Table 6: Deduplicated results ranked by RRF score

We can see the three texts mentioning Japan (texts 58, 66, 72) displayed as the top three results, along with the other associated metadata. With the search process now complete, we can pass these results for interpretation with a LLM.

## Prompting LLMs for RAG: Selecting a Model

When considering LLMs for RAG applications, it is crucial to select an appropriate model that fits your needs for performance and available memory usage. This section will guide you through key considerations when selecting open-source LLMs and demonstrate how to load and quantize a model to optimize resource usage.

### Selecting Open-Source LLMs

Choosing the right Large Language Model (LLM) is crucial for a successful RAG application. LLMs, the engines driving the interpretive power of RAG, come in a variety of sizes, each with its own strengths and weaknesses.

Consider these factors when making your selection:

**Performance:** Larger models, trained on vast datasets, generally offer superior understanding and generation capabilities. They excel at complex tasks, grasping nuanced language and generating more sophisticated text. However, this performance comes at a cost.

**Memory Usage:** Large LLMs, with their billions of parameters, consume significant amounts of computer memory. Running these models locally often requires specialized hardware with powerful GPUs, which can be expensive and inaccessible to many researchers.

**Inference Speed:** The sheer size of large LLMs can also lead to slower processing times. Generating responses and completing tasks can take longer, potentially hindering the research workflow.

**Resource Requirements:** The computational demands of large LLMs necessitate substantial resources. Researchers may need to invest in expensive hardware or rely on cloud-based computing services, which can incur significant costs.

To navigate these trade-offs, it's helpful to think of LLMs in terms of familiar research resources:

**Large LLMs:** These are akin to comprehensive encyclopedias, possessing vast knowledge and capable of generating highly sophisticated text. However, they require significant memory and slower processing times. Examples include [Llama-3-70B-Instruct](https://huggingface.co/meta-llama/Meta-Llama-3-70B-Instruct) and [Cohere's Command-R-Plus](https://huggingface.co/CohereForAI/c4ai-command-r-plus).

**Medium-Sized LLMs:** These are like specialized textbooks, offering a good balance between knowledge and efficiency. They are suitable for most RAG applications and can run on more readily available computing environments. [Mistral-7B](https://huggingface.co/mistralai/Mistral-7B-Instruct-v0.2) is a good example of this category.

**Small LLMs:** These are like concise dictionaries, ideal for specific tasks and limited computing power. They are fast and efficient but may lack the depth of knowledge or the range of abilities found in larger models. However, researchers are focusing siginificant resources to improving these smaller models. [Phi-2B](https://huggingface.co/microsoft/phi-2) and [Gemma-2B](https://huggingface.co/google/gemma-2b) are examples of smaller, more efficient LLMs.

For this lesson, we'll be using the medium-sized [Mistral-7B](https://huggingface.co/mistralai/Mistral-7B-Instruct-v0.2). It offers a good balance between performance and resource requirements.

The code below demonstrates how to download, load, and quantize the Mistral-7B model. This process requires access to a GPU processor and can take some time to complete (around five minutes).

**1. Import Necessary Libraries:**

*   `AutoTokenizer`: Used to handle tokenization of the input text.
*   `AutoModelForCausalLM`: Used to load the language model.
*   `Pipeline`: Provides an easy-to-use interface for various tasks like text generation.

**2. Define the Model Name:**

`model_name` is set to the identifier of the Mistral 7B model hosted on HuggingFace.

**3. Initialize Global Variable:**

`mistral_pipe` is initialized as `None` to hold the model pipeline once it is loaded.

**4. Define Function to Load and Quantize the Model:**

*   **Check if the Model is Already Loaded:** The function checks if the `mistral_pipe` is already initialized to avoid redundant loading. This is key, as repeated loading will severely impact available working memory.
*   **Loading and Quantizing:** If the model is not already loaded, it initializes the tokenizer and loads the model with 4-bit quantization (`load_in_4bit=True`). It sets the data type to `torch.bfloat16` and uses `device_map="auto"` to automatically distribute the model across available devices.
*   **Pipeline Creation:** The function creates a text-generation pipeline using the quantized model and tokenizer.

**5. Load the Mistral LLM Model:**

The function `load_and_quantize_model` is called to load and quantize the Mistral 7B model. The resulting pipeline is stored in the `mistral_pipe` variable.

```
# Load and Quantize Mistral-7B LLM

from transformers import AutoTokenizer, AutoModelForCausalLM, pipeline

# LLM Model
model_name = "mistralai/Mistral-7B-Instruct-v0.2"

# Global variable to hold the loaded pipeline once initialized
mistral_pipe = None

# Function to load and quantize the model
def load_and_quantize_model(model_name):
    global mistral_pipe

    # Check if the model pipeline is already loaded
    if mistral_pipe is not None:
        print("Using already loaded model.")
        return mistral_pipe

    # Proceed to load and quantize the model if not already loaded
    print("Loading and quantizing model...")
    tokenizer = AutoTokenizer.from_pretrained(model_name)
    model = AutoModelForCausalLM.from_pretrained(
        model_name,
        load_in_4bit=True,
        torch_dtype=torch.bfloat16,
        device_map="auto",
        trust_remote_code=True,
    )

    mistral_pipe = pipeline(
        "text-generation",
        model=model,
        tokenizer=tokenizer,
        torch_dtype=torch.bfloat16,
        device_map="auto"
    )

    print("Model loaded!")
    return mistral_pipe

# Load Mistral LLM Model
mistral_pipe = load_and_quantize_model(model_name)
```

## Prompting Mistral-7B

Having selected our LLM, we now need to learn how to communicate with it effectively. This is where prompting comes in - a set of instructions that guides the LLM in generating text. LLMs are remarkably capable, but they truly excel when given clear directions and examples to guide their outputs. A well-crafted prompt provides this guidance, shaping the LLM's response and ensuring it aligns with the user's goals.

Imagine asking an LLM, "Tell me about Abraham Lincoln." Without further guidance, the model might generate a generic biography, pulling from its vast knowledge base. But if we provide a more specific prompt, such as "Analyze Lincoln's views on slavery as expressed in his Second Inaugural Address," we direct the LLM's attention to a particular aspect of Lincoln's life and thought, resulting in a more focused and insightful response.

Prompting is an art as much as a science. It involves understanding the LLM's capabilities, tailoring instructions to its strengths, and experimenting with different approaches to achieve desired outcomes. To learn more about prompting approaches, I highly recommend exploring the [Prompt Engineering Guide by DAIR.AI.](https://www.promptingguide.ai/)

Mistral-7B's Unique Language

Mistral-7B, like many LLMs, has its own preferred "language" for prompts. It uses specific instruction formats, including prefixes and suffixes that must be included in every generation. Think of these as the grammatical rules that ensure the LLM understands our requests.

**Instruction Formatting:**

In using Mistral 7B, your prompt must be enclosed within the `[INST]` and `[/INST]` variables. The first instruction should begin with a beginning-of-sentence token (`<s>`), while subsequent instructions should not.

The following section demonstrates how to prompt the Mistral-7B model to answer a specific question. Here, we use a simple query regarding Abraham Lincoln's term as president to illustrate the process. The function `generate_response` is used to send the prompt to the model and retrieve the generated response.

**1. Import the Pipeline:**

We import the `pipeline` from the `transformers` library. This pipeline is used to handle the text generation process.

**2. Define the Prompt:**

The `prompt` variable is set to include the query within the required instruction format for Mistral-7B. It begins with `<s> [INST]` and ends with `[/INST]`.

**3. Define the `generate_response` Function:**

The `generate_response` function takes two parameters: `query` and `pipe`. The `query` is the user's question, and `pipe` is the Mistral model pipeline.

**4. Send the Prompt:** The function sends the prompt to the model using the `pipe`. The `max_new_tokens`, `temperature`, and `repetition_penalty` parameters control the text generation process:

*   `max_new_tokens=250`: Limits the number of tokens in the generated response. This can be adjusted upwards for longer responses at the cost of inference speed.
*   `temperature=0.0`: Controls the randomness of the generated text. A lower temperature results in more deterministic outputs; higher settings result in more creative but potentially less accurate results.
*   `repetition_penalty=1.15`: Penalizes repeated words and phrases to ensure diverse responses.

**5. Extract the Answer:** The generated text is extracted and split by the `[/INST]` delimiter. The relevant portion of the response is then stripped of any extra whitespace and returned.

**6. Generate the Initial Answer:**

The `generate_response` function is called with the `query` and `mistral_pipe` to generate the initial answer. The response is then displayed.

```
# Sample Prompt

from transformers import pipeline

prompt = "&lt;s&gt;[INST] When did Lincoln serve as president? [/INST]"

def generate_response(query, pipe):
    response = pipe(prompt, max_new_tokens=250, temperature=0.0, repetition_penalty=1.15, num_return_sequences=1)
    initial_answer = response[0]['generated_text'].split('[/INST]')[-1].strip()
    return initial_answer

# Generate the initial answer
response = generate_response(query, mistral_pipe)
print("Response:", response)
```

Output:
```
Response: Abraham Lincoln served as the 16th president of the United States from 1861 to 1865.
```

## How to Prompt with RAG Search Results

In the context of RAG, we need to provide the Mistral model with a prompt to reflect the data structure of the search results and specific instructions for how to carry out our task.

**Prompt Structure for RAG:**

*   **Initialization:** Start with the `<s>` token followed by the `[INST]` token.
*   **Prompts:** This variable holds detailed instructions for completing the RAG task. We'll cover this in the next section.
*   **Query:** The query used to generate RAG results.
*   **Document Details:** Data from the RAG results, such as Document ID, Key Quote, Source, and RRF Score.
*   **Document Relevance:** This is the end spot of the prompt and the place where the model's output begins on the assigned task, which is determining each document's relevance. This task is outlined in the next section.
*   **Closing:** End the instruction with the `[/INST]` token.

The prompt for each document is constructed as follows:

```
mistral_prompt = f"&lt;s&gt;[INST] {prompts}\n\n" \
                 f"Query: {query}\n\n" \
                 f"Document ID: {document_id}\n" \
                 f"Key Quote: {key_quote}\n" \
                 f"Source: {source}\n" \
                 f"Total Relevance Score: {total_relevance_score}\n\n" \
                 f"1. Document Relevance: " \
                 f"[/INST]"
```

The code below sets this prompt for Mistral to perform RAG tasks:

**1. Function Definition:**

The function `generate_with_mistral` takes four arguments: `deduplicated_df` (the DataFrame with search results), `query` (the user query), `pipe` (the Mistral model pipeline), and `prompts` (additional prompts for the model).

**2. Iterate Over Search Results:**

The function iterates over each row in the `deduplicated_df` DataFrame, extracting relevant information such as `document_id`, `key_quote`, `source`, and `total_relevance_score`.

**3. Craft the Mistral Prompt:**

The prompt is constructed using the instruction format, including the user query, document details, and relevance score. The prompt is enclosed within `<s>[INST]` and `[/INST]` tokens.

**4. Generate Response:**

The `pipe` (Mistral model pipeline) is used to generate a response based on the crafted prompt. Parameters such as `max_new_tokens`, `temperature`, and `repetition_penalty` control the generation behavior.

**5. Extract and Clean Response:**

The generated text is processed to extract the relevant part after the `[/INST]` token. If the delimiter is not found, the entire generated text is used.

**6. Append and Print Outputs:**

The cleaned response is appended to the `mistral_outputs` list and printed for review.

**7. Update DataFrame with Mistral Outputs:**

The `deduplicated_df` DataFrame is updated with the generated responses in a new column "Mistral Output".

```
# Prompting Mistral for RAG tasks

# Function to generate responses using Mistral LLM model
def generate_with_mistral(deduplicated_df, query, pipe, prompts):
    mistral_outputs = []
    for index, row in deduplicated_df.iterrows():
        document_id = row['Document ID']
        key_quote = row['Key Quote']
        source = row['Source']
        total_relevance_score = row['RRF']

        mistral_prompt = f"&lt;s&gt;[INST] {prompts}\n\n" \
                         f"Query: {query}\n\n" \
                         f"Document ID: {document_id}\n" \
                         f"Key Quote: {key_quote}\n" \
                         f"Source: {source}\n" \
                         f"Total Relevance Score: {total_relevance_score}\n\n" \
                         f"1. Document Relevance: " \
                         f"[/INST]"

        response = pipe(mistral_prompt, max_new_tokens=500, temperature=0.0, repetition_penalty=1.15, num_return_sequences=1)
        generated_text = response[0]['generated_text']

        # Extract the text after [/INST] delimiter if it exists
        if '[/INST]' in generated_text:
            # Split the output on '[/INST]' and take the part after it
            parts = generated_text.split('[/INST]')
            clean_text = parts[1].strip() if len(parts) > 1 else ""
        else:
            clean_text = generated_text  # Fallback if the delimiter isn't found

        mistral_outputs.append(clean_text)

        # Print the cleaned generated text for review
        print(f"Generated for Document ID {document_id}: {clean_text}")

    deduplicated_df['Mistral Output'] = mistral_outputs
    return deduplicated_df
```

## Developing Prompt Instructions for RAG Tasks

Having set up a prompt structure for the LLM to process our RAG results, we now need to provide instructions on how to carry out a specific analytical task.

For this lesson, we'll set the task as relevance determination, or judging if the RAG search result is relevant to the user query. This task is useful for filtering out irrelevant results, a key element of any RAG application. But there are other benefits to including this step in your pipeline, like data collection. For example, we can prompt the LLM when it encounters a relevant result to extract the most salient excerpt from the text and offer a statement explaining its contextual relevance to the query. This data can then be used in downstream RAG tasks like text summarization and enable evaluation of the RAG pipeline itself. (See Evaluating RAG section)

To ensure consistent performance, we utilize a set of curated examples to guide a LLM in completing this task. This approach is called few-shot prompting. This method is quite effective when paired with detailed instructions on how to complete a task and accompanied by a diverse set of examples. In implementing this approach, careful selection and testing of prompts is critical to achieve desired performance. [This guide](https://www.promptingguide.ai/techniques/fewshot) on few-shot prompting from [DAIR.AI](https://github.com/dair-ai) is an excellent introduction to learning this practice.

Relevance determination is an example of a modular analytical task that can be added to RAG pipelines for specific and customized inquiries. Such tasks could include forms of natural language processing, OCR cleanup, creation of knowledge graphs, language translation, and facilitating multimodal RAG with computer vision.

The code below demonstrates how to download and display a collection of prompts used to guide the LLM for this task:

**1. Function to Download Data:**

The `download_data` function downloads data from the project Github URL and saves it to a text file. It checks the HTTP response status to ensure the download is successful.

**2. Specify Data and File Paths:**

The URL of the prompt file is specified, along with the directory and filename where the prompt will be saved.

**3. Download the Prompt:**

The `download_data` function is called to download the prompt from the specified URL and save it to the defined file path.

**4. Function to Read the Prompt Content:**

The `read_prompt` function reads the content of the downloaded file and returns it as a string.

**5. Read and Display the Prompt Content:**

The `read_prompt` function is called to read the content of the downloaded prompt file, and the content is printed for review.

```
# Downloading RAG Prompts

import os
import requests

# Function to download data from a URL and save it to a file
def download_data(url, file_path):
    response = requests.get(url)
    if response.status_code == 200:
        with open(file_path, 'wb') as file:
            file.write(response.content)
        print('File downloaded successfully!')
    else:
        print(f'Failed to download file. Status code: {response.status_code}')

# Data and File Paths
url = "https://raw.githubusercontent.com/Dr-Hutchinson/programming_historian/302c117924a0e4b6de49f30fd7580a4c8740543f/prompts/5_shot_RAG_prompt.txt"  # Content of the downloaded prompt
data_dir = "/content/"
file_name = "relevance_prompt.txt"
file_path = os.path.join(data_dir, file_name)

# Downloading the prompt
download_data(url, file_path)

# Function to read the content of the downloaded prompt file
def read_prompt(file_path):
    with open(file_path, 'r') as file:
        prompt_content = file.read()
    return prompt_content

# Reading the prompt content
prompt_content = read_prompt(file_path)

print(prompt_content)
```

Output:
```
Complete the following tasks to establish the relevance between a user query and this document written by Abraham Lincoln. Complete the tasks step by step:

1. Document Relevance: Classify the document as 'Relevant' if it directly addresses the query subject. Otherwise, classify as 'Irrelevant'.
2. Quote Extraction: Identify the part of the Key Quote that is most relevant to the query. If no quote explicitly addresses the query, note 'NaN'.
3. Contextual Relevance: Provide a detailed explanation of the document's relevance to the query, providing historical context to illustrate the relevance. If the document is irrelevant, answer 'NaN'.

Query: Was strategy did Lincoln propose to combat piracy?

Document ID: Text #: 72
Key Quote: By the act of the 5th of August last, Congress authorized the President to instruct the commanders of suitable vessels to defend themselves against, and to capture pirates. This authority has been exercised in a single instance only. For the more effectual protection of our extensive and valuable commerce, in the eastern seas especially, it seems to me that it would also be advisable to authorize the commanders of sailing vessels to re-capture any prizes which pirates might make of United States vessels and their cargoes, and the consular courts, now established by law in eastern countries, to adjudicate the cases, in the event that this should not be objected to by the local authorities.
Source: First Annual Address. December 3, 1861.
Total Relevance Score: 92%

1. Document Relevance: Relevant
2. Quote Extraction: By the act of the 5th of August last, Congress authorized the President to instruct the commanders of suitable vessels to defend themselves against, and to capture pirates.
3. Contextual Relevance: In his First annual Address, This quote from Lincoln's address during a time when U.S. maritime trade was increasingly targeted by pirates reflects the government's strategic efforts to protect its commercial interests abroad. The authorization given to ship commanders by the act of August 5th, 1861, was part of broader U.S. efforts to enhance maritime security and uphold the safety of American commerce in regions where local governance was insufficient to combat piracy.

Good. Let's try another.

Query: How did Lincoln defend the Emancipation Proclamation?

Document ID: Text #: 25
Key Quote: He did so, and by some judicious modifications of his plan, coupled with laborious efforts with individual members, and his own over-mastering eloquence upon the floor, he finally secured the admission of the State. Brightly, and captivating as it had previously shown, it was now perceived that his great eloquence, was a mere embellishment, or, at most, but a helping hand to his inventive genius, and his devotion to his country in the day of her extreme peril.  After the settlement of the Missouri question, although a portion of the American people have differed with Mr. Clay, and a majority even, appear generally to have been opposed to him on questions of ordinary administration, he seems constantly to have been regarded by all, as the man for a crisis.
Source:  Eulogy on Henry Clay. July 6, 1852.
Total Relevance Score: 38%

1. Document Relevance: Irrelevant
2. Quote Extraction: NaN
3. Contextual Relevance:  NaN

Query: How did Lincoln justify the Civil War in his speeches?

Good. Let's try another.

Document ID: Text #: 79
Key Quote: With high hope for the future, no prediction in regard to it is ventured.  On the occasion corresponding to this four years ago, all thoughts were anxiously directed to an impending civil-war. All dreaded it---all sought to avert it. While the inaugeral address was being delivered from this place, devoted altogether to saving the Union without war, insurgent agents were in the city seeking to destroy it without war---seeking to dissol[v]e the Union, and divide effects, by negotiation. Both parties deprecated war; but one of them would make war rather than let the nation survive; and the other would accept war rather than let it perish. And the war came.  One eighth of the whole population were colored slaves, not distributed generally over the Union, but localized in the Southern part [2] of it.
Source: Second Inaugural Address. March 4, 1865.
Total Relevance Score: 75%

1. Document Relevance: Relevant
2. Quote Extraction: "Both parties deprecated war; but one of them would make war rather than let the nation survive; and the other would accept war rather than let it perish."
3. Contextual Relevance:  In his Second Inaugural Address, Lincoln justified the Civil War as an unavoidable conflict to preserve the Union. Despite both sides wishing to avoid war, Lincoln portrayed the conflict as a necessary response to the actions of those who would rather see the nation divided or destroyed than relinquish their claim to slavery. This framing underscores the war's moral and existential dimensions, linking the fight for the Union to the broader cause of human freedom.

Good. Let's try another.

Query: How did Irish-Americans fare during the Civil War?

Document ID: Text #: 74
Key Quote: There were disbursed, for the civil service, $27,505,599,46; for pensions and Indians, $7,517,930,97; for the War Department $690,791,842,97; for the Navy Department $85,733,292,77; for interest of the public debt $53,685,421,69;---making an aggregate of $865,234,087.86, and leaving a balance in the treasury of $18,842,558.71, as before stated. For the actual receipts and disbursements for the first quarter, and the estimated receipts and disbursements for the three remaining quarters of the current fiscal year, and the general operations of the treasury in detail, I refer you to the report of the Secretary of the Treasury.
Source: Fourth Annual Message. December 6, 1864.
Total Relevance Score: 82%

1. Document Relevance: Irrelevant
2. Quote Extraction: NaN
3. Contextual Relevance:  NaN
```

## Determining Relevance of RAG Results with Mistral

With the prompt structure and instructions now set, we can now test Mistral's abilities to determine which RAG results are relevant to the query. The code below runs each of the RAG results through Mistral using the prompt template.

The code below describes how this is achieved:

**1. Load Example Prompts:**

The variable `prompts` is assigned the content of the prompt loaded from the file. This prompt content includes the few-shot examples and instructions necessary for the LLM to perform the relevance determination task.

**2. Generate Responses Using Mistral LLM:**

The `generate_with_mistral` function is called with the DataFrame containing the final RAG results (`final_results_df`), the user query (`query`), the Mistral model pipeline (`mistral_pipe`), and the prompts (`prompts`). This function processes each search result and generates a relevance determination response using the Mistral-7B model.

**3. Save Final Results with Mistral Outputs to CSV:**

The resulting DataFrame, now containing the relevance determination outputs from Mistral, is saved to a CSV file named `final_results_with_mistral.csv`. The file is saved in the specified directory (`/content/`).

**4. Display the Final DataFrame with Mistral Outputs:**

The first few rows of the DataFrame with Mistral outputs are converted to HTML and displayed. This allows for a quick visual inspection of the generated results.

**5. Display a Message Indicating the Results are Saved:**

A message is printed to confirm that the final results with Mistral outputs have been saved to the specified CSV file.

```
# Determining Relevance of RAG Results with Mistral

# Example prompts (loaded from file)
prompts = prompt_content

# Generate responses using Mistral LLM
final_results_df_with_mistral = generate_with_mistral(final_results_df, query, mistral_pipe, prompts)

# Save final results with Mistral outputs to CSV
filename_with_mistral = 'final_results_with_mistral.csv'
filepath_with_mistral = f'/content/{filename_with_mistral}'
final_results_df_with_mistral.to_csv(filepath_with_mistral, index=False)

# Display the final DataFrame with Mistral outputs as HTML
final_results_html_with_mistral = final_results_df_with_mistral.to_html(escape=False)
display(HTML(final_results_html_with_mistral))

# Display a message indicating the results are saved
print(f"Final results with Mistral outputs saved to {filepath_with_mistral}")
```

<div class="table-wrapper" markdown="block">

<table id="keywordTable" style="border-collapse: collapse; width: 100%;">
  <thead>
    <tr>
      <th style="border: 1px solid black; padding: 8px;">Query</th>
      <th style="border: 1px solid black; padding: 8px;">Document ID</th>
      <th style="border: 1px solid black; padding: 8px;">Key Quote</th>
      <th style="border: 1px solid black; padding: 8px;">Source</th>
      <th style="border: 1px solid black; padding: 8px;">Mistral Output</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="border: 1px solid black; padding: 8px;">How did Lincoln regard Japan?</td>
      <td style="border: 1px solid black; padding: 8px;">Text #: 58</td>
      <td style="border: 1px solid black; padding: 8px;">....Very favorable relations also continue to be maintained with Turkey, Morocco, China and <mark>Japan</mark>.....</td>
      <td style="border: 1px solid black; padding: 8px;">Source: Second Annual Message. December 1, 1862</td>
      <td style="border: 1px solid black; padding: 8px;">Relevant<br>Quote Extraction: "Very favorable relations also continue to be maintained with Turkey, Morocco, China and Japan."<br>Contextual Relevance: This quote from Lincoln's Second Annual Message to Congress in 1862 highlights the positive diplomatic and economic ties between the United States and Japan during this period.</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; padding: 8px;">How did Lincoln regard Japan?</td>
      <td style="border: 1px solid black; padding: 8px;">Text #: 66</td>
      <td style="border: 1px solid black; padding: 8px;">In common with other western powers, our relations with <mark>Japan</mark> have been brought into serious jeopardy, through the perverse opposition of the hereditary aristocracy of the empire, to the enlightened and liberal policy of the Tycoon designed to bring the country into the society of nations. It is hoped, although not with entire confidence, that these difficulties may be peacefully overcome. I ask your attention to the claim of the Minister residing there for the damages he sustained in the destruction by fire of the residence of the legation at Yedo.</td>
      <td style="border: 1px solid black; padding: 8px;">Source: Third Annual Message. December 8, 1863.</td>
      <td style="border: 1px solid black; padding: 8px;">Relevant<br>Quote Extraction: "In common with other western powers, our relations with Japan have been brought into serious jeopardy, through the perverse opposition of the hereditary aristocracy of the empire, to the enlightened and liberal policy of the Tycoon designed to bring the country into the society of nations."<br>Contextual Relevance: This quote from Lincoln's Third Annual Message to Congress in 1863 reveals the challenges faced by the Lincoln administration in its relations with Japan. The "perverse opposition" of the Japanese aristocracy to the shogun's modernizing policies threatened to undermine U.S.-Japanese relations.</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; padding: 8px;">How did Lincoln regard Japan?</td>
      <td style="border: 1px solid black; padding: 8px;">Text #: 72</td>
      <td style="border: 1px solid black; padding: 8px;">....Owing to the peculiar situation of <mark>Japan</mark>, and the anomalous form of its government, the action of that empire in performing treaty stipulations is inconstant and capricious. Nevertheless, good progress has been effected by the western powers, moving with enlightened concert. Our own pecuniary claims have been allowed, or put in course of settlement, and the inland sea has been reopened to commerce.</td>
      <td style="border: 1px solid black; padding: 8px;">Source: Fourth Annual Message. December 6, 1864.</td>
      <td style="border: 1px solid black; padding: 8px;">Relevant<br>Quote Extraction: "Owing to the peculiar situation of Japan, and the anomalous form of its government, the action of that empire in performing treaty stipulations is inconstant and capricious. Nevertheless, good progress has been effected by the western powers, moving with enlightened concert. Our own pecuniary claims have been allowed, or put in course of settlement, and the inland sea has been reopened to commerce."<br>Contextual Relevance: This quote from Lincoln's Fourth Annual Message to Congress in 1864 provides insights into his understanding of Japan's political system and its implications for U.S.-Japanese relations. Lincoln acknowledges the challenges posed by Japan's "inconstant and capricious" adherence to treaty obligations, but also highlights the progress made through international cooperation and economic engagement.</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; padding: 8px;">How did Lincoln regard Japan?</td>
      <td style="border: 1px solid black; padding: 8px;">Text #: 48</td>
      <td style="border: 1px solid black; padding: 8px;">Fellow-citizens of the United States: In compliance with a custom as old as the Government itself, I appear before you to address you briefly and to take in your presence the oath prescribed by the Constitution of the United States to be taken by the President "before he enters on the execution of this office."</td>
      <td style="border: 1px solid black; padding: 8px;">Source: First Inaugural Address. March 4, 1861.</td>
      <td style="border: 1px solid black; padding: 8px;">Irrelevant<br>Quote Extraction: NaN<br>Contextual Relevance: NaN</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; padding: 8px;">How did Lincoln regard Japan?</td>
      <td style="border: 1px solid black; padding: 8px;">Text #: 16</td>
      <td style="border: 1px solid black; padding: 8px;">In regard to what I had said, the advantage the slave States have over the free, in the matter of representation, the Judge replied that we, in the free States, count five free negroes as five white people, while in the slave States, they count five slaves as three whites only; and that the advantage, at last, was on the side of the free States. Now, in the slave States, they count free negroes just as we do; and it so happens that besides their slaves, they have as many free negroes as we have, and thirty-three thousand over. Thus their free negroes more than balance ours; and their advantage over us, in consequence of their slaves, still remains as I stated it.</td>
      <td style="border: 1px solid black; padding: 8px;">Source: At Peoria, Illinois. October 16, 1854.</td>
      <td style="border: 1px solid black; padding: 8px;">Irrelevant<br>Quote Extraction: NaN<br>Contextual Relevance: NaN</td>
    </tr>
  </tbody>
</table>

</div>
Table 8: Final Results with Mistral Outputs

## Filtering Relevant Results

Above we can see how Mistral performed on evaluating the RAG results. The LLM correctly identified texts 58, 66, and 72 as relevant to the query. Likewise, the remainder of the results are correctly ranked as irrelevant. In the evaluation section of this lesson, we'll evaluate the overall accuracy of Mistral for this RAG task. But for now, we'll pass on the results identified as relevant for further evaluation by the LLM.

The code below describes how to implement this:

**1. Filter Relevant Results:**

The DataFrame `final_results_df_with_mistral` is filtered to retain only the rows where the 'Mistral Output' column contains the word "Relevant". The `str.contains` method is used to perform this string matching, with `na=False` to handle any missing values gracefully.

**2. Limit Number of Relevant Results:**

In constrained memory environments, passing on a large number of relevant results can degrade the quality of summarizations, and more critically, cause memory crashes. For this lesson we'll only pass on the top five relevant results based on their RRF score.

**3. Display the Relevant Results:**

The filtered DataFrame `relevant_results_df` is printed to the console for reference. This allows you to see which RAG results have been identified as relevant by the Mistral 7B model.

```
# Filter relevant results

relevant_results_df = final_results_df_with_mistral[final_results_df_with_mistral['Mistral Output'].str.contains("Relevant", na=False)]

# Limit the number of matches to no more than 5 results; reduces chance of memory crash.
relevant_results_df = relevant_results_df.head(5)

# Display the relevant results for reference
print(relevant_results_df['Document ID'])
```

## Generating LLM Response without RAG

Having determined which RAG results are relevant, we are now ready to feed those results to Mistral to formulate a response. However, it is instructive to see the difference between the LLM's raw response versus a response informed by RAG. We'll first prompt Mistral to evaluate Lincoln's views of Japan, without any of the RAG search results.

The code below describes how to implement this:

**1. Generate Initial Answer:**

The function `generate_initial_answer` is defined to create an initial prompt for the Mistral model. The prompt asks the model to offer a detailed response to the given query without using any RAG search results. The model's response is then processed to extract the answer text.

**2. Display the Initial Answer:**

The generated initial answer is printed to the console for reference. This allows you to see Mistral's response to the query before incorporating the relevant RAG results.

```
# Querying Mistral without RAG

def generate_initial_answer(query, pipe):
    initial_prompt = f"&lt;s&gt;[INST] Offer a detailed response answering this query.\n\nQuery: {query}\n\nAnswer: [/INST]"
    response = pipe(initial_prompt, max_new_tokens=1000, temperature=0.0, repetition_penalty=1.15, num_return_sequences=1)
    initial_answer = response[0]['generated_text'].split('[/INST]')[-1].strip()
    return initial_answer

# Generate the initial answer
initial_answer = generate_initial_answer(query, mistral_pipe)
print("Mistral Response:", initial_answer)
```

> 2.10 - Mistral's Response:
>
>Abraham Lincoln, the 16th President of the United States, had limited direct interaction with Japan during his tenure from 1861 to 1865. However, there are some historical records and context that provide insights into how he viewed Japan and its people.
>
>During Lincoln's time, Japan was in a period of isolationism known as "Sakoku," which began in the late 17th century and lasted until the mid-19th century. This policy restricted foreign contact and trade with other nations, including the United States. As a result, there were few opportunities for diplomatic or commercial exchanges between the two countries during Lincoln's presidency.
>
>However, there is evidence that Lincoln was interested in Japan and its culture. In 1860, while serving as a member of the U.S. House of Representatives, Lincoln wrote a letter to a friend, William S. Rosecrans, who was then stationed in Yokohama, Japan, as part of the American legation. In the letter, Lincoln expressed his admiration for Japanese art and culture, particularly their woodblock prints. He also asked Rosecrans to bring back any samples he could find.
>
>Lincoln's interest in Japan extended beyond aesthetics. He recognized the strategic importance of Asia in global politics and economics. During the Civil War, the United States sought to expand its influence in the Pacific region, competing with European powers such as Britain and Russia. In 1863, Lincoln signed the Treaty of Washington, which established an open door policy towards Japan, allowing American merchants to trade freely in Japanese ports.
>
>Despite these efforts, Japan remained closed to the outside world, and it wasn't until after the Meiji Restoration in 1868 that the country began to open up to international trade and diplomacy. By then, Lincoln was no longer president, but his earlier interest in Japan and its people foreshadowed the growing relationship between the two nations in the following decades.

In evaluating this response, Mistral demonstrates a degree of accurate knowledge concerning Japan during Lincoln's presidency. However, the response also contains significant historical errors - for example, the Rosecrans anecdote is completely invented, and no Treaty of Washington was signed in 1863 opening Japan to trade. Of course, the response also does not contain factual details drawn from Lincoln's speeches that we've discovered through RAG.

## Generating LLM Response with RAG: Setting Prompt Template

Let's now observe how Mistral responds with RAG search results and a prompt designed for RAG tasks. As with the relevance determination task, we will set a prompt template feeding Mistral each relevant response with selected metadata. We'll also download another prompt using two examples demonstrating how we wish the RAG task to be completed.

**Special Note:** Memory constraints for few-shot prompting

Due to the considerable length of the RAG prompts, only two examples are used in the prompt below. While Mistral's context length can fit additional examples, repeated testing found that the GPU memory for the free Google Colab tier was insufficient to process these examples. For the benefit of this lesson, we'll use the two examples to establish a baseline measure.

The code below describes how this is accomplished:

**1. Function Definition: construct_final_prompt:**

This function constructs the final prompt for Mistral by combining the user query, initial answer, and relevant results.

**2. Iterate Over Relevant Results:**

The function iterates over each row in the `relevant_results_df` DataFrame, extracting information such as `text_id`, `source`, `key_quote`, and `mistral_output`.

**3. Extract Information from Mistral Output:**

Regular expressions are used to extract "Quote Extraction" and "Contextual Relevance" from the `mistral_output`. If these fields are not found, default values "N/A" are used.

**4. Append Extracted Information to Prompt Lines:**

The extracted information is appended to the `prompt_lines` list.

**5. Join Prompt Lines:**

The `prompt_lines` list is joined into a single string with double newline separators to form the final prompt.

**6. Construct and Print the Final Prompt:**

The `construct_final_prompt` function is called with the user query, initial answer, and relevant results DataFrame to create the final prompt. The constructed prompt is then printed for review.

```
# Constructing RAG prompt for LLM

def construct_final_prompt(rag_prompt, query, relevant_results_df):
    prompt_lines = [
        rag_prompt,
        f"User Query: {query}",
        "Evidence:"
    ]

    for _, row in relevant_results_df.iterrows():
        text_id = row['Document ID']
        source = row['Source']
        key_quote = row['Key Quote']
        mistral_output = row['Mistral Output']

        # Extract "Quote Extraction" and "Contextual Relevance" from the Mistral output
        try:
            quote_extraction = re.search(r'Quote Extraction:\s*(.*?)\s*\d\.', mistral_output, re.DOTALL).group(1).strip()
            contextual_relevance = re.search(r'Contextual Relevance:\s*(.*?)(?=\s*\d\.|$)', mistral_output, re.DOTALL).group(1).strip()
        except AttributeError as e:
            print(f"Error parsing Mistral output: {e}")
            quote_extraction = "N/A"
            contextual_relevance = "N/A"

        prompt_lines.extend([
            f"{text_id}",
            f"{source}",
            f"Key Quote: {key_quote}",
            f"Quote Extraction: {quote_extraction}",
            f"Contextual Relevance: {contextual_relevance}"
        ])

    # Add the final instructions
    prompt_lines.append("Quote Driven Response with Citations:")

    final_prompt = "\n\n".join(prompt_lines)
    return final_prompt

# Data and File Paths
url = "https://raw.githubusercontent.com/programminghistorian/ph-submissions/blob/gh-pages/assets/exploring-text-collections-via-rag/2-shot-RAG-prompt.txt"  # Content of the downloaded prompt
data_dir = "/content/"
file_name = "rag_prompt.txt"
file_path = os.path.join(data_dir, file_name)

# Downloading the prompt
download_data(url, file_path)

# Reading the prompt content
rag_prompt = read_prompt(file_path)

# Construct the final prompt
final_prompt = construct_final_prompt(rag_prompt, query, relevant_results_df)
print("Final Prompt:\n\n", final_prompt)
```

Output:
```
You will be given a user query about Abraham Lincoln and the Civil War era. Then you will be given along with a list of excerpts from the speeches of Abraham Lincoln generated by a search engine. This list contains a text ID, a summary, a key quote, and contextual relevance. Use the relevant excerpts to answer the query through correctly incorporating quotes from the relevant search results into a quote-driven response. The quote-driven response should use direct quotes from the speeches and cite the source of those speeches, noting the title and date of the speech.

User Query: How does Liberia factor into Lincoln's speeches?

Evidence:

Text ID: 48

Source: First Annual Message. December 3, 1861.

Key Quote: By the act of the 5th of August last, Congress authorized the President to instruct the commanders of suitable vessels to defend themselves against, and to capture pirates. This authority has been exercised in a single instance only. For the more effectual protection of our extensive and valuable commerce, in the eastern seas especially, it seems to me that it would also be advisable to authorize the commanders of sailing vessels to re-capture any prizes which pirates might make of United States vessels and their cargoes, and the consular courts, now established by law in eastern countries, to adjudicate the cases, in the event that this should not be objected to by the local authorities. If any good reason exists why we should persevere longer in withholding our recognition of the independence and sovereignty of Hayti and Liberia, I am unable to discern it. Unwilling, however, to inaugurate a novel policy in regard to them without the approbation of Congress, I submit for your consideration the expediency of an appropriation for maintaining a Charge d'affaires near each of those new states. It does not admit of doubt that important commercial advantages might be secured by favorable commercial treaties with them. The operations of the treasury during the period which has elapsed since your adjournment have been conducted with signal success.

Quote Extraction: If any good reason exists why we should persevere longer in withholding our recognition of the independence and sovereignty of Hayti and Liberia, I am unable to discern it.

Contextual Relevance: In his First Annual Message, Lincoln acknowledges the potential commercial benefits of establishing diplomatic relations with Haiti and Liberia. He suggests that recognizing their independence could lead to advantageous commercial treaties, thereby expanding American economic influence. This perspective highlights Lincoln's pragmatic approach to foreign affairs and his commitment to promoting US commercial interests.

Text ID: 58

Source: Second Annual Message. December 1, 1862

Key Quote: The new commercial treaty between the United States and the Sultan of Turkey has been carried into execution. A commercial and consular treaty has been negotiated, subject to the Senate's consent, with Liberia; and a similar negotiation is now pending with the republic of Hayti. A considerable improvement of the national commerce is expected to result from these measures. Our relations with Great Britain, France, Spain, Portugal, Russia, Prussia, Denmark, Sweden, Austria, the Netherlands, Italy, Rome, and the other European states, remain undisturbed.

Quote Extraction: A commercial and consular treaty has been negotiated, subject to the Senate's consent, with Liberia; and a similar negotiation is now pending with the republic of Hayti.

Contextual Relevance: In his Second Annual Message, Lincoln mentions the successful negotiation of a commercial treaty with Liberia, highlighting the diplomatic efforts made to strengthen economic ties with foreign nations, including former slave colonies like Liberia. This demonstrates Lincoln's commitment to expanding international trade opportunities for the United States while promoting goodwill towards countries with significant historical connections to the American experience of slavery.

Text ID: 72

Source: Fourth Annual Message. December 6, 1864.

Key Quote: During the past year no differences of any kind have arisen with any of those republics, and, on the other hand, their sympathies with the United States are constantly expressed with cordiality and earnestness. The claim arising from the seizure of the cargo of the brig Macedonian in 1821 has been paid in full by the government of Chile. Civil war continues in the Spanish part of San Domingo, apparently without prospect of an early close. Official correspondence has been freely opened with Liberia, and it gives us a pleasing view of social and political progress in that Republic. It may be expected to derive new vigor from American influence, improved by the rapid disappearance of slavery in the United States. I solicit your authority to furnish to the republic a gunboat at moderate cost, to be reimbursed to the United States by instalments. Such a vessel is needed for the safety of that state against the native African races; and in Liberian hands it would be more effective in arresting the African slave trade than a squadron in our own hands.

Quote Extraction: I solicit your authority to furnish to the republic a gunboat at moderate cost, to be reimbursed to the United States by installments.

Contextual Relevance: In his Fourth Annual Message, Lincoln mentions the importance of supporting Liberia, a free black republic in Africa, and requests permission to send a gunboat to aid in its defense against native African tribes and help suppress the transatlantic slave trade. This demonstrates Lincoln's commitment to promoting freedom and self-governance for formerly enslaved peoples, both domestically and internationally.

Quote Driven Response with Citations:

Abraham Lincoln’s speeches reflect a consistent support for Liberia, highlighting its importance in his foreign policy. In his First Annual Message on December 3, 1861, Lincoln discusses the potential advantages of recognizing the independence of Liberia and Haiti. He states, “If any good reason exists why we should persevere longer in withholding our recognition of the independence and sovereignty of Hayti and Liberia, I am unable to discern it” (First Annual Message, December 3, 1861). This acknowledgment underscores Lincoln’s pragmatic approach to foreign affairs, emphasizing the commercial benefits that could arise from such recognition.

Lincoln's commitment to establishing stronger ties with Liberia is further evident in his Second Annual Message on December 1, 1862. He notes the progress made in negotiating a commercial and consular treaty with Liberia, reflecting his administration’s efforts to formalize and enhance economic relations: “A commercial and consular treaty has been negotiated, subject to the Senate's consent, with Liberia; and a similar negotiation is now pending with the republic of Hayti” (Second Annual Message, December 1, 1862). This demonstrates Lincoln's strategic intent to foster international trade opportunities and diplomatic goodwill.

In his Fourth Annual Message on December 6, 1864, Lincoln speaks of the positive developments in Liberia, acknowledging the country's social and political progress and expressing a desire to support its continued growth. He requests Congress’s authority to provide a gunboat to Liberia, highlighting the practical assistance needed for the nation’s defense and its role in suppressing the slave trade: “I solicit your authority to furnish to the republic a gunboat at moderate cost, to be reimbursed to the United States by installments” (Fourth Annual Message, December 6, 1864). This appeal illustrates Lincoln’s broader vision of supporting freedom and self-governance for formerly enslaved peoples, both domestically and internationally.

Lincoln's speeches demonstrate a clear and consistent policy of recognizing and supporting Liberia's independence, fostering economic ties, and providing practical assistance to ensure its stability and progress. These efforts are indicative of his broader commitment to promoting liberty and justice beyond the borders of the United States.

Good. Let's try another.

User Query: How did Lincoln justify the challenges of reinforcing and resupplying Fort Sumter?

Evidence:

Text ID: 40

Source: July 4th Message to Congress. July 4, 1861.

Key Quote: "Fellow-citizens of the Senate and House of Representatives:

Having been convened on an extraordinary occasion, as authorized by the Constitution, your attention is not called to any ordinary subject of legislation. At the beginning of the present Presidential term, four months ago, the functions of the Federal Government were found to be generally suspended within the several States of South Carolina, Georgia, Alabama, Mississippi, Louisiana, and Florida, excepting only those of the Post Office Department. Within these States, all the Forts, Arsenals, Dock-yards, Customhouses, and the like, including the movable and stationary property in, and about them, had been seized, and were held in open hostility to this Government, excepting only Forts Pickens, Taylor, and Jefferson, on, and near the Florida coast, and Fort Sumter, in Charleston harbor, South Carolina. The Forts thus seized had been put in improved condition; new ones had been built; and armed forces had been organized, and were organizing, all avowedly with the same hostile purpose. The Forts remaining in the possession of the Federal government, in, and near, these States, were either besieged or menaced by warlike preparations; and especially Fort Sumter was nearly surrounded by well-protected hostile batteries, with guns equal in quality to the best of its own, and outnumbering the latter as perhaps ten to one.

Extracted Quote: Within these States, all the Forts, Arsenals, Dock-yards, Customhouses, and the like, including the movable and stationary property in, and about them, had been seized, and were held in open hostility to this Government....and especially Fort Sumter was nearly surrounded by well-protected hostile batteries, with guns equal in quality to the best of its own, and outnumbering the latter as perhaps ten to one."

Contextual Relevance: In this excerpt from Lincoln's message to Congress on July 4, 1861, he justifies the need to reinforce and resupply Fort Sumter based on the military situation at the time. He explains how the Confederate states had seized federal fortifications and put them in a state of hostility towards the US government, while Forts Pickens, Taylor, and Jefferson remained under federal control. Lincoln describes Fort Sumter as being nearly surrounded by Confederate batteries, with superior firepower, making it essential for the Union to maintain control of the fort to prevent further loss of territory. His appeal to Congress for resources to reinforce Fort Sumter was a crucial step in the escalation of the Civil War.

Text ID: 41

Source: July 4th Message to Congress. July 4, 1861.

Key Quote: This order could not go by land, but must take the longer, and slower route by sea. The first return news from the order was received just one week before the fall of Fort Sumter. The news itself was, that the officer commanding the Sabine, to which vessel the troops had been transferred from the Brooklyn, acting upon some quasi armistice of the late administration, (and of the existence of which, the present administration, up to the time the order was despatched, had only too vague and uncertain rumors, to fix attention) had refused to land the troops. To now re-inforce Fort Pickens, before a crisis would be
reached at Fort Sumter was impossible---rendered so by the near exhaustion of provisions in the latter-named Fort. In precaution against such a conjuncture, the government had, a few days before, commenced preparing an expedition, as well adapted as might be, to relieve Fort Sumter, which expedition was intended to be ultimately used, or not, according to circumstances. The strongest anticipated case, for using it, was now presented; and it was resolved to send it forward. As had been intended, in this contingency, it was also resolved to notify the Governor of South Carolina, that he might except an attempt would be made to provision the Fort; and that, if the attempt should not be resisted, there would be no effort to throw in men, arms, or ammunition, without further notice, or in case of an attack upon the Fort.

Extracted Quote: This order could not go by land, but must take the longer, and slower route by sea. The first return news from the order was received just one week before the fall of Fort Sumter. To reinforce Fort Pickens before a crisis would be reached at Fort Sumter was impossible--rendered so by the near exhaustion of provisions in the latter-named Fort.

Contextual Relevance: In this excerpt from Lincoln's July 4th Message to Congress, he explains the challenges faced in reinforcing and resupplying Fort Sumter, which was under siege by Confederate forces. The president describes how the troops had been transferred to the Sabine, but the commander of that vessel refused to land them due to unclear political circumstances. With Fort Sumter running low on provisions, the government prepared an expedition to relieve it, and this became the strongest anticipated case for using the expedition. Lincoln also notified the governor of South Carolina that an attempt would be made to provision the fort, and warned that no attempt would be made to throw in men, arms, or ammunition without further notice, or in case of an attack upon the fort. This passage highlights the urgency and complexity of maintaining federal control over key military installations during the early stages of the Civil War.

Text ID: 52

Source:  First Annual Message. December 3, 1861.

Key Quote: The inaugural address at the beginning of the Administration, and the message to Congress at the late special session, were both mainly devoted to the domestic controversy out of which the insurrection and consequent war have sprung. Nothing now occurs to add or subtract, to or from, the principles or general purposes stated and expressed in those documents. The last ray of hope for preserving the Union peaceably, expired at the assault upon Fort Sumter; and a general review of what has occurred since may not be unprofitable. What was painfully uncertain then, is much better defined and more distinct now; and the progress of events is plainly in the right direction. The insurgents confidently claimed a strong support from north of Mason and Dixon's line; and the friends of the Union were not free from apprehension on the point.

Extracted Quote: The last ray of hope for preserving the Union peaceably, expired at the assault upon Fort Sumter; and a general review of what has occurred since may not be unprofitable.

Contextual Relevance: In his First Annual Message, Lincoln justifies the challenges of reinforcing and resupplying Fort Sumter as crucial steps towards preserving the Union. He acknowledges the initial uncertainty regarding support for the Confederacy from the North, but emphasizes that the progress of events has clarified the situation and put the Union on the right path towards restoration.

Quote Driven Response with Citations:

In his speeches, Abraham Lincoln justified the challenges of reinforcing and resupplying Fort Sumter by emphasizing the constitutional duty to maintain federal authority and protect federal property. He framed these efforts within the broader context of the secession crisis and the need to uphold federal sovereignty.

In his message to Congress on July 4, 1861, Lincoln detailed the precarious situation at Fort Sumter, highlighting that federal fortifications had been seized by Confederate forces and that Fort Sumter was nearly surrounded by superior enemy batteries. He described the necessity of maintaining control over federal installations like Fort Sumter, which were besieged or menaced by warlike preparations: "Within these States, all the Forts, Arsenals, Dock-yards, Customhouses, and the like, including the movable and stationary property in, and about them, had been seized, and were held in open hostility to this Government....and especially Fort Sumter was nearly surrounded by well-protected hostile batteries, with guns equal in quality to the best of its own, and outnumbering the latter as perhaps ten to one" (July 4th Message to Congress, July 4, 1861).

Lincoln also addressed the logistical difficulties of reinforcing Fort Sumter. He explained that reinforcements had to take a longer, slower sea route, and efforts to provision the fort were further complicated by political and military obstacles: "This order could not go by land, but must take the longer, and slower route by sea. The first return news from the order was received just one week before the fall of Fort Sumter. To reinforce Fort Pickens before a crisis would be reached at Fort Sumter was impossible--rendered so by the near exhaustion of provisions in the latter-named Fort" (July 4th Message to Congress, July 4, 1861).

In his First Annual Message on December 3, 1861, Lincoln reiterated the significance of the Fort Sumter crisis in the broader context of the Civil War, describing the attack on the fort as a turning point that extinguished hopes for a peaceful resolution: "The last ray of hope for preserving the Union peaceably, expired at the assault upon Fort Sumter; and a general review of what has occurred since may not be unprofitable" (First Annual Message, December 3, 1861).

Lincoln's justifications for the challenges of reinforcing and resupplying Fort Sumter were thus deeply rooted in his commitment to upholding federal authority and sovereignty, as well as navigating the complex legal and political landscape of the secession crisis.

Good. Let's try another.


User Query: How did Lincoln regard Japan?

Evidence:

Text #: 72

Source:  Fourth Annual Message. December 6, 1864.

Key Quote: Owing to the peculiar situation of <mark><mark>Japan</mark></mark>, and the anomalous form of its government, the action of that empire in performing treaty stipulations is inconstant and capricious. Nevertheless, good progress has been effected by the western powers, moving with enlightened concert. Our own pecuniary claims have been allowed, or put in course of settlement, and the inland sea has been reopened to commerce. There is reason also to believe that these proceedings have increased rather than diminished the friendship of <mark><mark>Japan</mark></mark> towards the United States."

Quote Extraction: "Owing to the peculiar situation of Japan, and the anomalous form of its government, the action of that empire in performing treaty stipulations is inconstant and capricious. Nevertheless, good progress has been effected by the western powers, moving with enlightened concert. Our own pecuniary claims have been allowed, or put in course of settlement, and the inland sea has been reopened to commerce. There is reason also to believe that these proceedings have increased rather than diminished the friendship of Japan towards the United States."

Contextual Relevance: In this excerpt from his Fourth Annual Message, Lincoln discusses the diplomatic relations between the United States and Japan. He acknowledges the challenges posed by Japan's unique political structure and its inconsistent adherence to treaty obligations. However, he remains optimistic about the progress made through international cooperation and the positive impact of economic engagement on US-Japanese relations. This passage demonstrates Lincoln's perspective on Japan during his presidency and highlights the significance of diplomacy and commerce in shaping international relationships.

Text #: 58

Source:  Second Annual Message. December 1, 1862

Key Quote: A commercial and consular treaty has been negotiated, subject to the Senate's consent, with Liberia; and a similar negotiation is now pending with the republic of Hayti. A considerable improvement of the national commerce is expected to result from these measures. Our relations with Great Britain, France, Spain, Portugal, Russia, Prussia, Denmark, Sweden, Austria, the Netherlands, Italy, Rome, and the other European states, remain undisturbed. Very favorable relations also continue to be maintained with Turkey, Morocco, China and <mark><mark>Japan</mark></mark>. During the last year there has not only been no change of our previous relations with the independent states of our own continent, but, more friendly sentiments than have heretofore existed, are believed to be entertained by these neighbors, whose safety and progress, are so intimately connected with our own. This statement especially applies to Mexico, Nicaragua, Costa Rica, Honduras, Peru, and Chile. The commission under the convention with the republic of New Granada closed its session, without having audited and passed upon, all the claims which were submitted to it.

Quote Extraction: "Very favorable relations also continue to be maintained with Turkey, Morocco, China and Japan."

Contextual Relevance: In his Second Annual Message, Lincoln mentions Japan among the countries with whom the US maintains favorable diplomatic and economic relations. This passage indicates that during the period covered by the message, Japan was considered an important partner in international affairs for the United States.

Text #: 66

Source:  Third Annual Message. December 8, 1863.

Key Quote: "In common with other western powers, our relations with <mark><mark>Japan</mark></mark> have been brought into serious jeopardy, through the perverse opposition of the hereditary aristocracy of the empire, to the enlightened and liberal policy of the Tycoon designed to bring the country into the society of nations. It is hoped, although not with entire confidence, that these difficulties may be peacefully overcome. I ask your attention to the claim of the Minister residing there for the damages he sustained in the destruction by fire of the residence of the legation at Yedo.

Quote Extraction: "Our relations with Japan have been brought into serious jeopardy"

Contextual Relevance: In his Third Annual Message, Lincoln acknowledged the diplomatic challenges facing the US-Japan relationship due to resistance from the Japanese aristocracy towards the modernizing policies of the shogun (Tycoon). He expressed hope that these issues could be resolved peacefully and addressed the claim of the US minister in Japan for compensation related to the destruction of the legation residence in Yedo. This passage demonstrates Lincoln's awareness of Japan's role in international affairs and the need for diplomatic engagement to maintain peaceful relationships.

Quote Driven Response with Citations:
```

With the prompt now set we're ready to generate a new response to the query and compare Mistral's initial response against the RAG-based summarization.

```
# Generating LLM Response with RAG

def generate_rag_answer(final_prompt, rag_prompt, pipe):
    full_prompt = f"&lt;s&gt;[INST]{final_prompt}[/INST]"
    response = pipe(full_prompt, max_new_tokens=1000, temperature=0.7, repetition_penalty=1.1, num_return_sequences=1)
    final_answer = response[0]['generated_text'].split('[/INST]')[-1].strip()
    return final_answer

# Generate the RAG response
rag_response = generate_rag_answer(final_prompt, rag_prompt, mistral_pipe)

print("Initial Answer before RAG:" + "\n\n" + initial_answer + "\n\n")

print("Final Answer with RAG:" + "\n\n" + rag_response)

# Save initial answer to a text file
with open("initial_answer.txt", "w") as file:
    file.write(initial_answer)

# Save final RAG response to a text file
with open("rag_response.txt", "w") as file:
    file.write(rag_response)
```

> **Mistral-7B**: Abraham Lincoln's views on Japan were shaped by the diplomatic challenges and opportunities that arose during his presidency.
>
> In his Fourth Annual Message on December 6, 1864, Lincoln acknowledged the inconsistent and capricious nature of Japan's government and its performance of treaty obligations. Despite these challenges, he remained optimistic about the progress made through international cooperation and the positive impact of economic engagement on US-Japanese relations. He noted, "good progress has been effected by the western powers, moving with enlightened concert. Our own pecuniary claims have been allowed, or put in course of settlement, and the inland sea has been reopened to commerce. There is reason also to believe that these proceedings have increased rather than diminished the friendship of Japan towards the United States" [(Fourth Annual Message, December 6, 1864)](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/exploring-text-collections-via-rag/speech-text-72.txt).
>
> In his Second Annual Message on December 1, 1862, Lincoln mentioned Japan as one of the countries with which the US maintained favorable diplomatic and economic relations. He stated, "Very favorable relations also continue to be maintained with Turkey, Morocco, China and Japan" [(Second Annual Message, December 1, 1862)](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/exploring-text-collections-via-rag/speech-text-58.txt). This passage underscores the importance of Japan as a diplomatic and economic partner during this period.
>
> However, Lincoln also recognized the challenges posed by Japan's unique political structure and the resistance of the imperial court to Westernizing policies. In his Third Annual Message on December 8, 1863, he acknowledged the serious jeopardy that US-Japanese relations had faced due to the opposition of the Japanese aristocracy to the enlightened and liberal policies of the shogun. He asked for Congress's attention to the claim of the US minister in Japan for damages sustained in the destruction of the legation residence at Yedo [(Third Annual Message, December 8, 1863)](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/exploring-text-collections-via-rag/speech-text-66.txt).
>
> Overall, Lincoln's speeches reveal a nuanced understanding of Japan and its role in international affairs during his presidency. While acknowledging the challenges posed by Japan's unique political structure and inconsistent adherence to treaty obligations, he remained committed to finding diplomatic solutions and maintaining economic engagement to strengthen US-Japanese relations.



## Interpreting Results

In comparing Mistral's raw response versus its RAG-informed response, we can observe some comparative strengths and weaknesses.

The RAG response is grounded by information derived from the Lincoln corpus, providing a concise summary of what Lincoln communicated about the U.S.-Japan relationship through his annual messages to Congress. Further, Mistral provides citations for its sources along with detailed search results from RAG, allowing end-users to verify the accuracy of the model's responses. This provides a significant mitigation of the "hallucinations" found in Mistral's original response.

To be sure, there is room for improvement. While Mistral's raw response contains significant defects, it does seek to contextualize the query within the broader historical context of the period. That context is important to truly understand the significance of these search results. Events such as the Perry Expedition, U.S. military actions against Japan in the [Shimonoseki campaign](https://en.wikipedia.org/wiki/Shimonoseki_campaign), and the significance of the Meiji Restoration are important details needed for a truly informed response. (Likewise, the citation style employed here is also often inconsistently formatted from generation to generation, a product of the limited number of RAG examples usable in this memory environment.)

Thankfully, given RAG's modular nature such improvements can be readily implemented. One approach is to pass on the query and RAG summary to a more advanced model enabled with web search. Let's conclude with GPT-4's new response to our original query: "How did Lincoln regard Japan?"

>**GPT-4 with RAG:** Abraham Lincoln's perspectives on Japan were influenced by the broader diplomatic landscape and international dynamics of his presidency, a period marked by significant global shifts and the American Civil War. Lincoln's administration encountered Japan at a critical juncture when the country was grappling with internal upheavals and external pressures to open up to the world, a process that had been initiated by Commodore Perry's expeditions in the 1850s.</p>
>
>In his Second Annual Message on December 1, 1862, Lincoln highlighted the importance of maintaining favorable diplomatic and economic relations with several non-Western nations, including Japan. He stated, "Very favorable relations also continue to be maintained with Turkey, Morocco, China, and Japan." This brief mention of Japan alongside other nations indicates an early awareness of Japan's strategic importance as part of a network of relationships supporting American commercial and geopolitical interests.
>
>However, the challenges in dealing with Japan became more apparent by the time of Lincoln's Third Annual Message on December 8, 1863. He recognized the complications arising from Japan's internal politics, particularly the resistance from the Japanese aristocracy to the shogun's progressive policies. Lincoln acknowledged the serious jeopardy that US-Japanese relations had faced due to this internal opposition and specifically addressed the incident involving the destruction of the US legation residence at Yedo (Tokyo). He appealed to Congress for attention to the US minister's claims for damages, illustrating the precarious nature of diplomatic relations and the volatility of Japan's political environment during the Bakumatsu era, characterized by the declining power of the Tokugawa shogunate and increasing pressure from both domestic factions and foreign powers.
>
>In his Fourth Annual Message on December 6, 1864, Lincoln provided a more comprehensive analysis of Japan's governance and the ongoing diplomatic challenges. He described Japan's government as "inconsistent and capricious" in fulfilling treaty obligations but remained optimistic about the progress achieved through international cooperation and economic engagement. Lincoln noted, "good progress has been effected by the western powers, moving with enlightened concert. Our own pecuniary claims have been allowed, or put in course of settlement, and the inland sea has been reopened to commerce." This optimism underscored Lincoln's belief in the potential for diplomacy and economic incentives to foster positive relations, even with a nation undergoing significant internal strife. He further emphasized that these proceedings had "increased rather than diminished the friendship of Japan towards the United States," reflecting his commitment to maintaining and strengthening US-Japanese relations despite the inherent challenges.
>
>In the broader historical context, Lincoln's approach to Japan can be seen as part of a wider American strategy of engagement with Asia during a time of significant global change. His administration's efforts to navigate the complexities of Japanese politics and secure economic opportunities reflect the United States' burgeoning interest in expanding its influence in the Pacific, an interest that would continue to grow in the latter half of the 19th century. Lincoln's nuanced understanding of the challenges and opportunities in US-Japanese relations highlights his pragmatic approach to foreign policy, one that balanced idealistic aspirations of international cooperation with the realistic acknowledgment of political and cultural differences.

## Evaluating RAG

While the RAG pipeline produced a satisfactory result for our query, more robust testing is needed to determine the overall effectiveness of the application. To facilitate this, a dozen questions concerning Lincoln and his times were assembled into a standard set of queries, or a benchmark. Each question was then run through the RAG pipeline, resulting in 123 distinct results. From these results, each Mistral output for the relevance determination task was scored by more advanced LLMs for accuracy. [(The data for this evaluation is available in this article's Github Repo)](https://github.com/Dr-Hutchinson/programming_historian/tree/main/evaluation/relevance_task). This scoring enables evaluation of the RAG pipeline to determine its strengths and areas for improvement.

Below are the findings from the benchmark results:

**Evaluation Findings:**

* **Overall Effectiveness**: The retriever supplied relevant results to user queries 100% of the time (Figure 3), with 60% of all returned matches deemed relevant to queries (Figure 4). This indicates that while the application reliably returns relevant information, there is room for improvement concerning precision.
* **Evaluating Search Approaches:** Of the three search methods, semantic search and ColBERT achieved the strongest results, with semantic search catching the greatest number of relevant matches (Figures 5 & 6) while ColBERT demonstrated greatest precision in finding relevant results. (Figure 7) BM25 produced relevant matches at a 37% accuracy rate, contributing some 20% of all relevant results. We'll discuss techniques for improving this rate in a later section.
* **Reranker Performance:** One method to determine the effectiveness of the reranker model is to see what percentage of relevant results were ranked in the top five matches. Over 50% of all results fell below this rank, indicating the reranker may lack desired precision for this task. (Figure 8)
* **Relevance Determination Task:** To establish an evaluation baseline for this benchmark, GPT-4 was used to score each Mistral-7B output for the relevance determination task (see Methodology section below). Based on GPT-4's outputs, it agrees with Mistral's performance over 95% of the time, suggesting that Mistral is highly effective at this task when using the given prompt approach. (Figure 9) This assessment is largely supported by other LLMs scoring this data. Performance in other elements of the task are more mixed. (Figure 10). In the Advanced RAG section below, we examine ways to enhance the performance of RAG search systems based on these findings.

The code below downloads the evaluation dataset for visualization and analysis:

```
# Downloading Evaluation Dataset

import os
import pandas as pd
import requests

# Clone the GitHub repository
!git clone https://github.com/Dr-Hutchinson/programming_historian.git

# Set the path to the repository
repo_path = '/content/programming_historian/evaluation/relevance_task'

# List of other scored dataset files to be loaded for later analysis
csv_files = [
    'complete_dataset_scored.csv',
    'complete_dataset_scored_claude.csv',
    'complete_dataset_scored_commandr.csv',
]

# Load all CSV files into a single DataFrame
dataframes = []
for csv_file in csv_files:
    file_path = os.path.join(repo_path, csv_file)
    df = pd.read_csv(file_path)
    dataframes.append(df)

# Load CSV files into DataFrames
complete_data = pd.read_csv(os.path.join(repo_path, csv_files[0]))
complete_data_claude = pd.read_csv(os.path.join(repo_path, csv_files[0]))
complete_data_commandr = pd.read_csv(os.path.join(repo_path, csv_files[1]))
```

Below are visualizations of the evaluations. Full code for how these evaluations were measured can be found [here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/exploring-text-collections-via-rag/exploring-text-collections-via-rag.ipynb).


{% include figure.html filename="en-or-exploring-text-collections-via-rag-03.png" alt="Pie chart illustrating the percentage of queries returning relevant results. The chart shows that 100% of queries returned relevant results, while 0% did not return relevant results. The pie is fully colored, with a label indicating 100% for queries with relevant results and a small sliver marked 0% for queries without relevant results." caption="Figure 3: Percentage of Queries Returning Relevant Results." %}

{% include figure.html filename="en-or-exploring-text-collections-via-rag-04.png" alt="Pie chart illustrating the percentage of relevant versus irrelevant results. The chart shows that 60.2% of queries returned relevant results, represented by a green segment, while 39.8% of queries returned irrelevant results, depicted by a red segment." caption="Figure 4: Percentage of Relevant vs. Irrelevant Results." %}

{% include figure.html filename="en-or-exploring-text-collections-via-rag-05.png" alt="Bar chart comparing the number of relevant and irrelevant results returned by three search methods: BM25, Semantic, and ColBERT. The BM25 method returns 15 relevant and 26 irrelevant results. The Semantic search method shows 36 relevant and 17 irrelevant results. ColBERT returns 23 relevant and 6 irrelevant results. Relevant results are represented by green bars, while irrelevant results are shown in red." caption="Figure 5: Total Relevant/Irrelevant Matches by Search Method." %}

{% include figure.html filename="en-or-exploring-text-collections-via-rag-06.png" alt="Pie chart showing the percentage of relevant results returned by three search methods: BM25, Semantic, and ColBERT. The Semantic search method accounts for 48.6% of relevant results, represented by a green segment. ColBERT contributes 31.1%, shown in red, while BM25 represents 20.3%, illustrated in blue. The chart provides a comparison of the relative effectiveness of each method in retrieving relevant results." caption="Figure 6: Percentage of Queries Returning Relevant Results." %}

{% include figure.html filename="en-or-exploring-text-collections-via-rag-07.png" alt="Bar chart comparing the performance of three search methods in finding relevant results. The ColBERT method achieved the highest performance with 79.31%, followed by Semantic Search at 67.92%, and BM25 with the lowest performance at 36.59%." caption="Figure 7: Search Method Performance for Returning Relevant Matches" %}

{% include figure.html filename="en-or-exploring-text-collections-via-rag-08.png" alt="Pie chart illustrating the proportion of relevant results ranked within the top 5 positions versus those outside the top 5. The chart is evenly split, with 50% of the relevant results found within the top 5 positions, represented by a green segment, and 50% outside the top 5, shown in red." caption="Figure 8: Proportion of Relevant Results in the Top 5 Positions" %}

## Methodology: Scoring RAG Results with LLMs

To provide a baseline for RAG pipeline's performance, the results of the relevance determination task were scored by GPT-4 for accuracy. Here is the structure of the Mistral outputs for this task:

```
Query: How did Lincoln justify the Civil War in his speeches?

Document ID: Text #: 79

Key Quote: With high hope for the future....

Source: Second Inaugural Address. March 4, 1865.

Total Relevance Score: 75%

1. Document Relevance: Relevant
2. Quote Extraction: "Both parties deprecated war; but one of them would make war rather than let the nation survive....
3. Contextual Relevance: In his Second Inaugural Address, Lincoln justified the Civil War as an unavoidable conflict....
```

```
Query: How did Irish-Americans fare during the Civil War?

Document ID: Text #: 74

Key Quote: There were disbursed, for the civil service, $27,505,599,46...

Source: Fourth Annual Message. December 6, 1864.

Total Relevance Score: 82%

1. Document Relevance: Irrelevant
2. Quote Extraction: NaN
3. Contextual Relevance: NaN
```

To evaluate the Mistral's ability to determine relevance, extract quotes, and provide contextual relevance we tested its responses against GPT-4 using [this notebook.](https://github.com/Dr-Hutchinson/programming_historian/blob/main/evaluation/relevance_task/Evaluation_Notebook.ipynb) When prompted, GPT-4 scores each section of Mistral's output in each category: "1" for agreement with Mistral or "0" for disagreement, in the following manner:

Example Score for GPT-4's total agreement with Mistral:

```
{
  "Relevance": 1,
  "Quote Extraction": 1,
  "Contextual Relevance": 1
}
```

Example Score for GPT-4's total disagreement with Mistral:

```
{
  "Relevance": 0,
  "Quote Extraction": 0,
  "Contextual Relevance": 0
}
```

Example Score for GPT-4's partial agreement with Mistral:

```
{
  "Relevance": 1,
  "Quote Extraction": 0,
  "Contextual Relevance": 0
}
```

Overall, GPT-4 reported strikingly strong agreement (95%) with Mistral's assessment of relevance, and lesser agreement for outputs for the other two categories. (Section 3.9). GPT-4's performance on this prompt was further tested against Anthropic's [Claude 3.5 Sonnet](https://www.anthropic.com/news/claude-3-5-sonnet) and Cohere's [Command-R+](https://docs.cohere.com/docs/command-r-plus) models. Claude found similarly strong agreement with Mistral's relevance determinations; Command-R+ also found agreement, albeit to a lesser extent. While LLMs are imperfect judges for this task and may introduce errors, overall advanced LLMs have demonstrated strong performance on tasks for determining textual relevance. While imperfect, their relative cost and speed have resulted in LLMs becoming increasingly popular for automating evaluation tasks such as this.

Below are the results for agreement between the models of these three tasks:


{% include figure.html filename="en-or-exploring-text-collections-via-rag-09.png" alt="Bar chart comparing the agreement frequency between GPT-4 and Mistral-7B on relevance tasks. The chart displays three categories: Relevance Agreement at 95.93%, Extraction Agreement at 82.11%, and Context Agreement at 75.61%. Each category is represented by a distinct bar, showing how closely the two models align in their performance across these different aspects of the task." caption="Figure 9: Agreement Frequency between Mistral and GPT-4 for Relevance Tasks" %}

{% include figure.html filename="en-or-exploring-text-collections-via-rag-10.png" alt="Bar chart comparing the agreement frequency between GPT-4, Claude 3.5, and Command-R+ for relevance tasks. The chart shows agreement percentages for three categories: Relevance Agreement, where GPT-4 and Claude 3.5 have 95.9% agreement, while Command-R+ has 74.8%. In Extraction Agreement, GPT-4 and Claude 3.5 both have 82.1%, while Command-R+ has 80.5%. For Context Agreement, GPT-4 and Claude 3.5 both show 75.6%, while Command-R+ has 68.3%." caption="Figure 10: Agreement Frequency between Mistral and assorted LLMs on Relevance Tasks" %}


There are other evaluation metrics that can be employed to examine the effectiveness of a RAG pipeline. Two methods commonly used for scoring RAG summaries are are [BLEU](https://en.wikipedia.org/wiki/BLEU) (Bilingual Evaluation Understudy) and [ROUGE](https://en.wikipedia.org/wiki/ROUGE_(metric)) (Recall-Oriented Understudy for Gisting Evaluation). Methods like [BERTScore](https://github.com/Tiiiger/bert_score) and specialized RAG evaluation approaches like [ARES](https://github.com/stanford-futuredata/ARES) and [RAGAS](https://github.com/explodinggradients/ragas) offer additional insights into the quality of RAG summaries. Frameworks like [Langchain](https://docs.smith.langchain.com/old/cookbook/testing-examples) now offer a host of automated evaluation pipelines for a variety of performance areas. And of course, scholars should consider their own training and expertise in devising judgments of RAG's place in the historian's toolkit.

## Evaluating RAG as Historians

While a host of quantitative metrics provide insights into a RAG pipeline's performance, they offer limited insight into this approach's potential for historical research. Indeed, historians require more than simple summaries or automated extracts of primary source collections. Our discipline demands critical assessment of sources, consideration of multiple perspectives, and the ability to contextualize the past.

RAG's true value lies in its potential to aid historians in these critical tasks. By programmatically analyzing large datasets of historical documents in customizable ways, RAG can do more than just uncover sources that might have been missed with other methods. RAG can help us "cross-reference" vast amounts of information, develop new research questions and approaches, and leverage generative AI's potential in ways that promote verifiability and transparency.

Many historians may be skeptical of generative AI's potential to contribute to these ends. AI "hallucinations" distort the historical record, and LLM "analysis" of the past can go wildly wrong. Even in areas where they are well-informed, LLMs do not always demonstrate historical nuance. Take, for example, LLM interpretations of texts addressing Lincoln's evolving views on race and African American citizenship. These are complex and sensitive issues that demand a deep understanding of historical context and the ability to grapple with shifts in Lincoln's language and thought over time. RAG, when carefully implemented, can assist historians in navigating these complexities by providing access to primary sources and offering summaries that are informed by existing scholarship and feature historiographical nuance. But if poorly implemented, such frameworks can perpetuate misinformation and misunderstanding, especially if utilized without an understanding of AI's limitations.

Continuing advances in generative AI make it difficult to predict the pace of improvement of these technologies. Yet however far these models advance, it is crucial to remember that RAG is not a replacement for the historian or for careful historical assessment. The summaries produced by RAG can be thought of as a first draft from an automated research tool, aiding the historian in identifying and contextualizing evidence. But in the end, it is the historian who is responsible for evaluating sources, verifying factual accuracy, and interpreting historical events within a broader context.

The potential of these tools for historical research is certainly an area of active research; indeed, [historians](https://nicolay-honestabes-info.streamlit.app/), [archivists](https://chat.eluxemburgensia.lu/), and [librarians](https://lil.law.harvard.edu/blog/2024/02/12/warc-gpt-an-open-source-tool-for-exploring-web-archives-with-ai/) are already demonstrating how RAG can be leveraged to promote scholarship and extend access to our shared past. To see a state-of-the-art RAG pipeline at work, I highly encourage readers to try out [STORM](https://storm-project.stanford.edu/), which uses RAG techniques to generate Wikipedia-style articles based on user queries.

And as the technologies underpinning this approach evolve, we can expect to see continued advances in model performance. The emergence of multimodal RAG, for instance, allows search over multiple domains - text, image, sound, and video. This will allow researchers to integrate a whole new range of historical data in innovative ways. In embracing the possibilities of AI while remaining mindful of its limitations, historians of the future will increasingly find creative ways to transform raw data into the basis for meaningful dialogue about the past.

## Advanced RAG: For Further Exploration

{% include figure.html filename="en-or-exploring-text-collections-via-rag-11.png" alt="Diagram comparing different approaches to Retrieval-Augmented Generation (RAG). The image presents three distinct RAG workflows: Naive RAG, Advanced RAG, and Modular RAG. Naive RAG involves a simple user query followed by retrieval and generation. Advanced RAG introduces pre-retrieval steps (query routing and expansion) and post-retrieval processes (reranking and fusion). Modular RAG showcases a flexible structure with various modules like routing, retrieval, prediction, and memory. Different patterns of RAG implementation, such as Naive RAG and Iterative RAG, are also illustrated." caption="Figure 11: A Survey of Different RAG Methods. From: Gao et. al, 'Retrieval-Augmented Generation for Large Language Models: A Survey.' arXiv:2312.10997v4 [cs.CL] 5 Jan 2024. [https://arxiv.org/pdf/2312.10997](https://arxiv.org/pdf/2312.10997)" %}


The evaluation of our RAG pipeline revealed several key areas that could benefit from further improvement. While our approach successfully retrieved relevant information, there is room for enhancing precision, particularly in the ranking of results and the overall performance of the keyword search. Furthermore, while Mistral-7B proved adept at determining the relevance of retrieved documents, it sometimes struggled to fully integrate those findings into comprehensive and nuanced summaries. Fortunately, advanced RAG techniques can address these limitations, and offer new approaches to enrich existing RAG pipelines.

**Model Finetuning:**

One way to enhance RAG's overall performance is through model fine-tuning. This process involves training RAG retrievers and LLMs on a specific dataset or adapting it to a particular task. In our case, fine-tuning Mistral-7B on a curated collection of RAG tasks tailored to Lincoln's speeches could improve the LLMs ability to understand Lincoln's language, historical context, and nuanced positions on complex issues like race and citizenship, thus grounding Mistral's outputs for historical analysis.

For example, the [*Nicolay* project](https://nicolay-honestabes-info.streamlit.app/RAG_with_Hay_&_Nicolay) (from which this article is based) has incorporated two fine-tuned LLMs as core components for both search and crafting RAG summaries, with noticeable improvements in performance. One task on which the models were finetuned is query rewriting, which greatly enhanced the effectiveness of keyword search, a weak area in our RAG pipeline. (This approach is described in greater detail below.) Improved reranking would also benefit our pipeline - as it happens, Cohere now offers a finetuning API endpoint for its Rerank model.

Please note that model finetuning can be an intensive process. To effectively finetune you need sets of curated question/answer pairs to train the model, much like the few-shot prompting method discussed earlier. For example, in the *Nicolay* project the author used [finetuning sets](https://github.com/Dr-Hutchinson/nicolay/tree/main/data/finetuning_datasets) of fifty question/answer pairs for each finetuned model (one hundred examples in total) to train customized versions of OpenAI's GPT-3.5. Open-source models may require many more examples to achieve the same performance. (Thankfully, LLMs have proven useful in creating these pairs, a process called generating synthetic data). Finetuning can also require substantial computing power if done locally. Using external finetuning services via APIs is a recommended alternative in terms of convenience, time, and expense.

* [Official documentation](https://docs.mistral.ai/guides/finetuning/) on finetuning Mistral LLM models with API (recommended)
* [Notebook](https://github.com/bclavie/RAGatouille/blob/main/examples/03-finetuning_without_annotations_with_instructor_and_RAGatouille.ipynb) on how to generate synthetic data for finetuning ColBERT
* [Official documentation](https://docs.cohere.com/docs/rerank-starting-the-training) on finetuning Cohere's Rerank model with API.

**Query Rewriting**

Another promising technique is query rewriting. By automatically reformulating the user's query in different ways, RAG can enhance the effectiveness of keyword search and increase the chances of retrieving relevant information.

For example, if a user asks "How did Lincoln defend the Emancipation Proclamation?", a specialized model could rewrite the query using specific key terms likely to result in relevant results: "Emancipation" and "Proclamation", but also "forever free" or other specific excerpts from the text. This could be done by a finetuned or prompted LLM. (*Nicolay* uses a fine-tuned model) This method can help capture a wider range of relevant documents, potentially improving both the recall and precision of methods like keyword search.

* [Notebook](https://docs.llamaindex.ai/en/stable/examples/query_transformations/query_transform_cookbook/) on implementing query rewriting from Llamaindex
* [Notebook](https://github.com/langchain-ai/langchain/blob/master/cookbook/rewrite.ipynb) on implementing query rewriting from Langchain
* [Notebook](https://github.com/neuml/txtai/blob/master/examples/33_Query_translation.ipynb) on implementing query rewriting from txtai

**Self-Reflective RAG**

An interesting approach to addressing errors in RAG summaries is Self-RAG and Corrective RAG (CRAG). These approaches use LLMs to iteratively parse and review RAG summaries to detect flaws in reasoning and confirm knowledge claims.

* [Notebook](https://github.com/langchain-ai/langgraph/blob/main/examples/rag/langgraph_self_rag.ipynb?ref=blog.langchain.dev) on implementing Self-RAG with Langgraph
* [Notebook](https://github.com/langchain-ai/langgraph/blob/main/examples/rag/langgraph_crag.ipynb) on implementing CRAG with Langgraph

**Prompt Finetuning**

This lesson explored prompt design approaches like [few-shot prompting](https://www.google.com/url?q=https%3A%2F%2Fwww.promptingguide.ai%2Ftechniques%2Ffewshot), or using crafted instructions and examples to guide LLM behavior. A promising new approach is prompt tuning. Unlike few-shot prompting, prompt tuning automates and optimizes the prompt design process through machine learning techniques. The [DSPY framework](https://github.com/stanfordnlp/dspy?tab=readme-ov-file) offers powerful tools for fine-tuning prompts tailored to specific RAG tasks.

* [Notebook](https://colab.research.google.com/github/stanfordnlp/dspy/blob/main/intro.ipynb) on getting started with DSPY.

**Multimodal RAG:**

The emergence of multimodal RAG, or search over multiple domains (text, image, sound, video) holds significant promise, allowing researchers to integrate visual and textual data in new and innovative ways. By embracing the possibilities of RAG while remaining mindful of its limitations, historians can unlock exciting new avenues for exploring the past.

* Notebook for [Multimodal RAG using Vertex AI Gemini API (Google)](https://github.com/GoogleCloudPlatform/generative-ai/blob/main/gemini/use-cases/retrieval-augmented-generation/intro_multimodal_rag.ipynb)
* Notebook for [Multimodal RAG with Langchain and Redis](https://github.com/langchain-ai/langchain/tree/master/templates/rag-redis-multi-modal-multi-vector)

**Agentic RAG:**

Agentic RAG is a framework by which instead of an end-to-end pipeline, LLMs autonomously orchestrate a plan of action and utilize tools to complete retrieval and analytical tasks. Such tools could include web search, optical character recognition, connecting to external databases, run code in programming environments, or numerous other approaches. For those interested in a vivid example of this approach, I highly encourage readers to explore [STORM](https://storm-project.stanford.edu/), an impressive agentic RAG that generates custom Wikipedia-style articles on subjects based on user prompts.

* [ReACT](https://react-lm.github.io/): an approach for utilizing LLMs for agentic and tool-using behavior
* [Langchain documentation](https://python.langchain.com/v0.1/docs/modules/agents/agent_types/react/) for setting up a ReACT-based agent
* [Langgraph documentation](https://langchain-ai.github.io/langgraph/tutorials/rag/langgraph_agentic_rag/) for setting up agentic RAG

## Advanced RAG: For Further Reading

Below are additional resources for those wishing to learn more about RAG and other topics discussed in this article.

**Overviews of RAG and RAG Techniques:**

Gao et. al, "Retrieval-Augmented Generation for Large Language Models: A Survey." arXiv:2312.10997v4 [cs.CL] 5 Jan 2024. https://arxiv.org/pdf/2312.10997

"Retrieval Augmented Generation (RAG) for LLMs." Prompt Engineering Guide. https://www.promptingguide.ai/research/rag

Shi-Qi Yan, Jia-Chen Gu, Yun Zhu, Zhen-Hua Ling. "Corrective Retrieval Augmented Generation." arXiv:2401.15884v2 [cs.CL] 16 Feb 2024. https://arxiv.org/pdf/2401.15884

"Self-Reflective RAG with LangGraph" Langchain Blog, 7 Feb 2024. https://blog.langchain.dev/agentic-rag-with-langgraph/

**Lincoln's Views on Japan:**

John Dower, "Yokohama Boomtown: Foreigners in Treaty Port Japan (1859-1872)" Visualizing Cultures (Massachusetts Institute of Technology, 2012). https://visualizingcultures.mit.edu/yokohama/pdf/yb_essay.pdf

De-Min Tao, “‘A Standard of Thought and Action’: Lincoln’s Reception in East Asia.” Richard Carwardine and Jay Sexton, eds. *The Global Lincoln* (Oxford University Press, 2011): 223-241.
