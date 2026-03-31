---
title: "Terms and Conditions: Interpreting AI Tool Licences in Research Contexts through Natural Language Processing (spaCy)"
slug: enablar-lesson-4
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
  - Joseph Nockels
  - Alex Fenlon
  - Natalia Estrada
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket: 
difficulty: 2
activity: 
topics: AI licences, terms and conditions, AI evaluation, library services
abstract: 'With AI capability gaining strong media attention, university staff and students are exploring new ways of leveraging automation in their own research. Subsequently, Higher Educational libraries, specifically copyright and licensing teams, are now positioned as key advice givers, especially on Intellectual Property matters and data protection implications in using AI-based tools for research activities. Therefore, this ENABLAR lesson takes guidance from local experts, both within libraries and digital research, to inform a Natural Language Processing workflow for locating ‘red flag’ clauses in AI tool licence agreements. In doing so, we aim to build researcher and library practitioner confidence in interpreting complex legalistic documentation, while also informing critical and appropriate AI use in research.
Nothing in the lesson is intended to constitute legal advice from a qualified lawyer, or intended to replace seeking library expertise.'
avatar_alt: Red flag being planted in the ground
doi: XX.XXXXX/phen0000
---

{% include toc.html %}


<!-- NOTE TO ENABLAR AUTHORS 
Note 1: The YAML + Table of Contents Include above are formatted according to our local requirements and should remain in place.

You can edit the title: "Copyright, Licensing and AI in Research Contexts" (line 2), and add your names into the `authors:` field.

You can also write an `abstract:` to replace the placeholder text 'Short abstract of this lesson'.

All other lines contain controlled fields so we'll return to complete these together at the end of the drafting process.
-->

<!-- NOTE TO ENABLAR AUTHORS 
Note 2: I've included a suggested table of contents, including main sections and sub-sections, based on the Lesson Framework.

You can adjust as needed, but I'd like you to keep this recommended structure in mind.
-->

<!-- NOTE TO ENABLAR AUTHORS
Note 3: Please write the lesson in Markdown.

If you are new to Markdown, I often recommend Sarah Simpkin’s lesson *Getting Started with Markdown* <https://doi.org/10.46430/phen0046>. It is available in French, Spanish, and Portuguese as well as English. Although it does not exactly match the way we structure Markdown in _Programming Historian_ lessons (there are many valid Markdown styles), it provides a useful introduction.

As you begin drafting your lesson, here are five basic Markdown conventions we use in _Programming Historian_ lessons.

a. **Bold**: formatted using **double asterisks**. We use bold text to help readers navigate interfaces or workspaces. This includes:
* Menu items (e.g. in a dropdown)
* Tab or window names
* Column headings (e.g. in a spreadsheet)
* Labelled categories (e.g. in a dataset)

b. *Italics*: formatted using *single asterisks* or _single underscores_. These are used primarily to indicate:
* a keystroke or button that generates an action (e.g. *Enter*, *Run*)
* a term extracted from a dataset, usually for textual analysis
* titles of books, plays, films, TV programmes, paintings, songs, or albums

c. `Code`: written in raw format so that readers can copy, paste, adapt, and reuse it.
* To create inline code, use single backticks ` before and after the word or snippet you want to display as code.
* To create code blocks, use three backticks ``` above and three backticks below the block you want to display.

d. Links: formatted using square brackets around the text to display and round brackets around the link.

* To create an external link, write: [The Architectural Association](https://www.aaschool.ac.uk/)
* To create an internal link (to a page on Programming Historian’s website, or to a file in our repository), use relative links that begin with the directory path, for example: [Introduction to the Principles of Linked Open Data](/en/lessons/intro-to-linked-data) rather than [Introduction to the Principles of Linked Open Data](https://programminghistorian.org/en/lessons/intro-to-linked-data
* To create a link to a specific section of your lesson (or another lesson), add a # followed by the section name: [RDF and data formats](/en/lessons/intro-to-linked-data#rdf-and-data-formats)
    * Spaces are replaced with hyphens: [Unfiltered Frequencies](#unfiltered-frequencies)
    * Apostrophes are removed: [Qu’est-ce que dplyr ?](#quest-ce-que-dplyr)
    * Where section names include punctuation marks, omit them: [Linked open data: what is it?](/en/lessons/intro-to-linked-data#linked-open-data-what-is-it)

e. Figures and sample data assets can be added later in the drafting process. For now, simply add a placeholder where you expect a figure to appear:
[Figure 1]
-->

<!-- NOTE TO ENABLAR AUTHORS
Note 4. Endnotes

Use endnotes to provide additional context or citations.

- Insert an endnote marker in the text using:
  [^1]

- At the end of the document, add a corresponding entry:
  [^1]: Your endnote text here.

- List all endnotes under a dedicated section at the end of the file:

## Endnotes
[^1]: First note  
[^2]: Second note  
-->

<!-- NOTE TO ENABLAR AUTHORS
Note 5. References

Format all references using the Chicago Manual of Style.

- Follow this guide:
  https://www.chicagomanualofstyle.org/tools_citationguide/citation-guide-1.html

- Additional help:
  https://subjectguides.york.ac.uk/referencing-style-guides/chicago
-->

## Contents 

- [Introduction, Increasing Exposed to AI Risk](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/en/drafts/enablar/enablar-lesson-4.md#introduction-increasing-exposure-to-ai-risk)
- [Using Natural Language Processing](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/en/drafts/enablar/enablar-lesson-4.md#using-natural-language-processing)
- [Some Disclaimers ...](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/en/drafts/enablar/enablar-lesson-4.md#some-disclaimers)
- [Preliminaries](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/en/drafts/enablar/enablar-lesson-4.md#preliminaries)
- Use Case: Locating Potential 🚩’s 
- Background to Dataset
- Background to Technical Method
- Learning Keys
- Learning Experiment
- Local Application and Continued Learning 
- Conclusions
- References

## Introduction, Increasing Exposure to AI Risk

The increasing pace of Artificial Intelligence (AI) development is particularly visible in Higher Education. University libraries now contend with newfound staff and student expectations as to how AI can support their scholarship, workplace efficiency and ideation strategies, automating previous manual work. Large Language Models (LLMs), trained on huge amounts of text, and the chat-based interfaces supporting them, have led many library users to anticipate querying resources based on natural language, opposed to keyword searching (Jaillant et al., 2026: 31). Alongside this shift in how users retrieve information, Agentic AI systems are coupling LLM models, like Gemini or Claude, to external software: ranging from calendar applications to email systems (Brown & Donnelly, 2026). Often, these tools are adopted to improve the quality of work, and reduce time, however they too change the rhythm and nature of research, pushing against established safeguards (Dickinson & Marshall, 2026).

While offering potential benefits to research, AI simultaneously exposes institutions, and individuals, to a new landscape of Intellectual Property (IP) concerns. Students and staff using AI software are often unaware of legally problematic terms and conditions in tool licence agreements: especially in the case of free, freemium, or subscription-based models (University of Birmingham, 2026).  This knowledge gap has clear implications for research activities, ranging from data privacy issues, third-party dependencies, data retention, cost and inaccuracies, notably from AI’s confident-mistakes and ‘hallucinations’. Researchers are thereby accepting unknown levels of individual risk through engaging in ‘Shadow AI’ practice, the unauthorised use of GenAI tools, or Machine Learning models, without approval from an organisational IT department (Krantz et al., n.d.). In 2024, over one-third (38%) of employees surveyed by the [National Cybersecurity Alliance](https://www.infosecurity-magazine.com/news/third-employees-sharing-work-info/) acknowledged sharing sensitive work with an AI tool, without their employers’ permission. With chat-based AI only growing more intuitive, and marketable to researchers - at all levels, such fears from those tasked with data protection, safeguarding institutional reputations, and cyber security are unlikely to be allayed. 

The same [National Cybersecurity Alliance 2024 report](https://www.infosecurity-magazine.com/news/third-employees-sharing-work-info/) also cited a lack of institutional training around appropriate AI usage, mirroring older reports of library users (Cox, 2021). These training issues are compounded through university libraries being restricted in trialling lesser-known AI systems, under controlled conditions, due to their deep integration with a certain technology provider, seen in being either a Google or Microsoft ‘Campus’ (Rungkaew, 2025). In considering such factors, this ENABLAR lesson aims to increase participants’ understanding of the current risks to Higher Educational libraries, and researchers, in licensing AI tools without proper review. 

Through practical workflows and collaborative reflection, we bring together perspectives from across the research, library, and legal domains. Our understanding of AI terms and conditions are situated in our daily roles as: Open Research Services Roadmap Project Lead and Head of Copyright and Licensing at the University of Birmingham (Fenlon); Digital Scholarship Librarian at the University of Buffalo (Estrada); and Lecturer in Digital Humanities at the University of Glasgow (Nockels). This lesson, therefore, is based on our own positional views of AI, technical research, and servicing of library users. These views, while influenced by our professions, are our own and may not be fully representative of our respective institutions.

As described, there is a current capability and knowledge gap in interpreting AI licences from a library and research standpoint. There is also a lack of coordinated resources to better inform those trialling AI for research, or advising such processes. 

As such, we see this lesson as particularly useful for: 

    Library collection managers;

    University-level researchers, especially those concerned with AI - such as the Digital Humanities; 

    Students interested in using AI for their own research practice; 

    Copyright and licensing teams within Higher Education; 

    Rights and reproduction managers within Higher Education; 

    Libraries engaged in public-private partnerships surrounding using third-party AI tools

## Using Natural Language Processing 

This lesson presents a reproducible workflow for interpreting AI tool licence agreements through Natural Language Processing (NLP): the field of digital research involving interaction between computers and human language (Stryker & Holdsworth, n.d.). NLP encompasses tasks such as text analysis, translation, and parts-of-speech tagging, used here to extract key terms and clauses in AI terms and conditions. This informs the construction of a dictionary of ‘red flags’ from licence conditions, and provides a walkthrough for you to develop institutional AI preparedness, alongside extant guidance (Colavizza & Jaillant, 2026). Our lesson focuses on terms associated with AI tool use, however connects these issues to broader contracts and licences negotiated by libraries, for instance literature review services and database agreements.

This process included reading current guidance in approaching AI licences (JiSC, n.d.; Holt & Kefalea, 2025), as well as extracting common AI-related terms found in the [ESAC Initiative’s registry of open licence agreements](https://esac-initiative.org/about/transformative-agreements/agreement-registry/). Therefore, our dictionary, accessible as part of this lesson through Zenodo [^1], attempts to fit such contractual language closely. Without tailoring NLP approaches, we risk extracting non-relevant language, instead of interpreting potentially problematic language associated with AI use. Though reiteratively refined, our dictionary is likely to still extract some non-relevant clauses, and may not generalise to every AI licence, which forms one limitation of this lesson. The ESAC agreements used to construct our NLP dictionary are from non-AI providers, instead they consist mainly of publishing contracts from the [Association of Computing Machinery](https://www.acm.org), [University of Cambridge Press](https://www.cambridge.org), [Royal Society](https://royalsocietypublishing.org) and [emerald publishing](https://www.emerald.com). That said, ESAC’s registry of licence agreements ranges in geographical jurisdiction and provides a way to generalise our dictionary construction beyond a purely Anglo-American context. 

Lastly, this lesson returns to the Authors’ own positionality and intellectual property expertise, and provides human translations for a sample of extracted clauses. This not only evaluates our NLP approach, considering whether returned terms and conditions are truly red flags, but offers a reflective review of the process and legalistic terms surrounding AI use within libraries.

## Some Disclaimers … 

#### This is not legal advice 

We do not intend for this lesson to be seen as legal advice, but instead hope it informs critical engagement with AI, within humanities research and libraries, especially around outstanding risks in terms of: institutional compliance, tool cost, warranties, indemnities and liability. Therefore, this lesson does, and should not, replace local expertise from copyright officers or IP managers, or anyone else working to advise staff, students and organisations on licences in a professional capacity. Instead, this lesson offers a compliant way of siphoning down complex legal documents into structured data for specialist human review. 

#### Legal jurisdictions, terms and transferability

In reviewing our own positionality, we find certain legal concepts to be heavily Anglo-American centered, such as Fair Dealing as a copyright exception (UK Government, 2021). However, where possible, we seek to connect these understandings with other geographies. We also draw on AI tool licence agreements from tool providers outside of the UK and America as case examples, notably [Transkribus](https://www.transkribus.org), which is maintained and developed by the Austrian-based academic cooperative [Recognising and Enriching Archival Documents](https://www.transkribus.org/about). 

The licences marketed to the University of Buffalo and Birmingham differ, due to their legal jurisdictions. This constructs a comparative dataset, important in light of increasing internationalism and collaboration, global library infrastructure and wider challenges from AI misuse, also contended with by multi-national organisations such as [AI4LAM](https://sites.google.com/view/ai4lam).

Another key variable, unable to be fully accounted for within this lesson, is the appetite for risk exercised by local institutions, both universities and their libraries, as well as individual researchers. As such, this lesson does not seek to guide readers to manage and respond to risk brought from unsanctioned AI usage, but instead presents a way to identify possible red flags to be aware of. 

## Preliminaries

#### Data type and format

Born digital AI licence PDFs (number XXX., words XXX), collated by Estrada and Fenlon, based on tools considered for institutional licensing at the University of Birmingham and University of Buffalo. 
  
#### What NLP handles well 

Structured data, especially where textual content can be pre-determined or modelled. We realise the limitations in this method, and offer a robust dictionary for relevant AI tool licence flags, that we trust will have a degree of transferability to other agreements.

In order for our lesson to remain focused on NLP and AI red flags, we use born digital PDFs. This avoids the process of (re)OCRing material with complex layouts, although, due to the formulaic nature of terms and condition licenses, OCR tools are likely to be effective in digitally transcribing such material. The quality of machine-readable text from these born digital agreements was manually checked, before NLP processing.

#### What level of RAM is needed to complete this lesson?

This NLP workflow was constructed and tested using an Apple Mac Silicon I, with 8MB RAM. As such, similar devices should be able to enact this lesson’s code, although slight syntax adaptations may be needed depending on your Operating System. 

#### Are admin privileges required?

[Jupyter Notebook](https://jupyter.org) may require administrative privileges, if using an institutional laptop, however, provided that spaCy is downloaded - the following code can be deployed within your terminal. [Real Python](https://realpython.com/run-python-scripts/) offers solid guidance on the range of code deployment options, if unable to use Jupyter. 

#### Can the method be scaled for larger datasets?

This method is easily scalable across your own licence agreements, although the corpus constructed by Estrada and Fenlon aims to be representative of current AI tools marketed to university libraries. This includes those marketed for automated literature review ([Consensus](https://consensus.app/?utm_source=google&utm_medium=paid&utm_campaign=search_branded&utm_term=consensus+ai&gad_source=1&gad_campaignid=20789663884&gbraid=0AAAAAqgO5PI9LpYQgObPV-MIlPQ0Ekl_W&gclid=CjwKCAjwvqjOBhAGEiwAngeQnco3_WjhhKtZU5nQeej-WOZ11CPvJWcVY_X3R8WkJJ0nAjSV0IObWBoCuPoQAvD_BwE), [Gemini Deep Research](https://support.google.com/gemini/answer/15719111?hl=en), [Perplexity](https://www.perplexity.ai/), chat-based and Agentic AI systems ([Claude](https://claude.ai/login)), and those aimed at increasing researcher efficiency (e.g. automated transcription, see [Transkribus](https://www.transkribus.org/)).

You can also refine and add to our constructed [spaCy](https://spacy.io) dictionary [^1]. The Python workflow is extensible, with no functions determined by dataset size, provided your computational RAM and disk memory is high enough. We have developed this workflow with a mind to inform University of Birmingham and Buffalo business-as-usual activities in reviewing AI tool agreements, so have used spaCy with increased scalability in-mind.

#### Connectivity

Provided that the spaCy NLP library has been installed within Python, you can complete this lesson offline. We can also make use of Jupyter Notebooks as an intuitive environment to construct and troubleshoot this lesson’s code, which - once downloaded - can be accessed offline through a locally hosted server. See - [Project Jupyter Install](https://jupyter.org/install), for advice on setting up the environment. The AI tool licences provided as a use case can also be stored locally, as simple PDFs, and are, therefore, accessible offline.

#### Language

Although our lesson makes use of spaCy’s main English language pipeline (en_core_web), the NLP library supports [75+ languages and has equivalent pipelines for 25 languages](https://spacy.io/usage/facts-figures). These NLP pipelines available range from Greek to Korean, Norwegian Bokmål to Catalan.

#### Ethics

Through their [Risk Management Toolkit for Open GLAM](https://oa2ch.gitbook.io/risk-management), Holt and Kefalea (2025) provide a helpful overview for AI’s implications for ethical research. They suggest that legal risk areas emerge in using digital materials, through ‘potential misuse of open access materials and the risk of infringements due to incorrect licensing’, as well as the ‘[A]dherence to third-party terms of service …’. Although speaking in the context of broader digital collections usage, we situate such concerns within our interpretation of AI licences. The Authors, therefore, see such legal strategies as underpinning broader risk mitigation areas around restrictive contracts and weak privacy safeguards, which include financial risk (from unexpected liabilities, when terms of service are breached); ethical (whereby AI tools and outputs cause harm, for instance the revealing of personal information or causing environmental damage); technical (through platform dependency and forced takedowns), and geopolitical concerns (whereby legal pressure can be applied and leveraged through technology terms of use). As such, this lesson advocates for greater transparency in AI tool licensing, and hopes to inform your regular review of AI terms of service, whether using tools for generating new material, data hosting, sharing or general dissemination. 

We appreciate that ensuring AI compliance institutionally relies on informed legal expertise, as well as contracting able staff to inform reviews of terms and services. Better interpretation of AI licence agreement must be considered against financial and resource limitations in libraries, which easily hinder the ability to manage and advise on AI usage. This has led to increases in public-private partnerships, whereby libraries attempt to minimise the upfront cost of intellectual property review, which require careful contractual design to avoid furthering copyright and licensing risk (Lundborg, 2024). As such, this lesson sits within an increasingly murky space, compounded by institutional resourcing factors, revenue generation, AI commercial marketing, and data access.

#### Costs

This lesson has no associated cost, or tiered / time-limited access. Therefore, we do not require you to supply any personal information, such as credit card information, to make use of this lesson. 

#### System requirements

The code written for the lesson was troubleshooted and deployed using a Mac Silicon (M1), with 8MB of RAM and using an Arm64 local CPU, opposed to 86x64 bit set-ups common for Intel processors. Arm64 builds are common for NLP pipelines, so opted for this lesson. Therefore, some minor environment changes may be needed to run the code effectively.

This lesson uses the latest, at time of writing, [Python (3.14.3)](https://www.python.org/downloads/) and [spaCy version (3.8.0)](https://spacy.io/models/en). 
This lesson also includes the open-source PDFPlumber package for licence upload and text extraction. PDFPlumber simply writes a file, instead of performing full OCR. 

We also export our ‘red flag’ list as a .csv file into Microsoft Excel, for manual cleaning and review of results, informing our human translations of AI tool license issues.

#### Knowledge and applied experience

No familiarity with spaCy, our NLP method is needed. A knowledge of basic Python functions is helpful, for example importing libraries and establishing functions, however we offer interpretable commenting throughout. Expertise on spaCy can also be gained through Kane’s (2023) and Goodale’s (2024) *Programming Historian* lessons on corpus linguistic annotation and interpretation. spaCy also includes an intuitive [installation and deployment walkthrough](https://spacy.io/usage). For a more theoretical introduction to the method, see Khan (2022).

In using NLP on legalistic documents, some expertise in basic copyright and intellectual property is also useful, especially how to discern what is in and out of copyright, the importance of locating ownership over data and a general understanding of the [General Data Protection Regulation (GDPR)](https://gdpr-info.eu). [CopyrightUser](https://www.copyrightuser.org) and the [UK’s Intellectual Protection Office](https://www.gov.uk/government/organisations/intellectual-property-office) offer basic legal guidance. The Information Commissioner’s Office also has guidance on [AI’s impact on data protection](https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/artificial-intelligence/guidance-on-ai-and-data-protection/).
 
In using accessible, pre-built and open-source tools (spaCy), there is ample troubleshooting support, beyond this lesson. This discussion GitHub offers an extensive overview of [common spaCy bugs and issues](https://github.com/explosion/spaCy/discussions/8226). spaCy’s walk-through also offers guidance for further NLP training and deployment, for instance using ‘parts-of-speech’ tagging or sentiment analysis. There is also support through Jupyter Notebook’s [Read the Docs](https://jupyter-notebook.readthedocs.io/en/stable/troubleshooting.html). 

##### Difficulty 

The NLP processes underpinning this work are at the intermediate level, with the need for general data protection and IP knowledge.

## Use Case: Locating Potential 🚩’s

This lesson aims to help those concerned with AI experimentation, such as Programming Historians, in evaluating AI tools based on their terms and conditions. As a secondary audience, we also hope to inform those with a remit to advise on AI compliance and institutional licence purchasing, especially within Higher Educational libraries. 

Through our own roles, we have noticed a capability and knowledge gap emerge, whereby scholars require greater confidence in understanding AI’s potential data protection risks. Subsequently, this lesson emerged from informal discussions between Fenlon and Nockels around resourcing automatic transcription tools within the University of Birmingham Libraries, especially a lack of guidance around server infrastructure, data sovereignty, and potential for copyright misuse. In engaging with this knowledge gap, this lesson forms an anticipatory approach to locating pitfalls in current AI licences, marketed to the University of Birmingham and Buffalo. 

Of course, when advising on AI tool usage, an appropriate need should be considered first. Both the University of Birmingham and Buffalo have manual AI licence checklists assessing such criteria. However, these rely on an expert know-how of warranties, legal liabilities, disputes, user and supplier obligations, associated costs and terms of AI service access. Without this expertise, university libraries can be left to negotiate terms and conditions without clear guidance. This case emerges when approached by AI providers, many of which are better-resourced and more legally established than counterparts in Higher Education. 

Therefore, our lesson uses Natural Language Processing workflows to extract problematic terms and conditions. This provides a benchmark for reviewing guidance, with human-in-the-loop review, but also explicitly documents the limitations and affordances of one AI-based method (spaCy), following evaluative frameworks from the library and archive sector (Manchester, 2023).

### Dataset

#### Characteristics and Suitability

Our dataset of AI tool licenses began with informal discussions around what software was familiar in our own research and advice giving, as part of the ENABLAR’s cohort writing reflections. This led to discussions of Agentic AI systems, in particular [Microsoft CoPilot](https://copilot.microsoft.com) licensed to Birmingham, as well as Transkribus, used heavily in Nockels’ research. With Estrada’s involvement, our dataset also includes tool licences being actively considered by the University of Buffalo Library. This provides a rich comparative dataset across different legal jurisdictions, and offering a way to further evaluate the success of our NLP method. This dataset was also kept born-digital to avoid OCR processing, in the interests of *Programming Historian* users’ learning, and there already being lessons available such as Gribomont (2023). 

#### Pre-processing and Sampling

Transkribus and Microsoft CoPilot acted as key starting points in our data construction, akin to purposive sampling as part of thematic literature reviews (Nockels et al., 2024). From this, Estrada constructed a structured folder of licences, anonymising any sensitive information, and ensuring they complied with any institutional non-disclosure agreements. These were reviewed as a team, to ensure an equal balance between types of AI tool. 

Nockels, before trialling spaCy, ran simple import tests to ensure the quality of machine-readable text from these licences. Afterwhich, stopwords, punctuation and capitalisation were removed, included in our lesson walkthrough. This is common in NLP pre-processing to ensure irrelevant and noisy features in text are removed (NasuhcaN, 2025). For our case, this helps ensure that red flag ‘hits’ are meaningful and display certain (re)occurring patterns (issues) in licences.

#### Citation

<--! Zenodo Link --> 

## Background to Technical Method 

In extracting red flags from AI licences, we make use of spaCy, an open-source library for NLP, that conveniently operates within Python. As Nandini (2024) suggests, spaCy can be an easy-to-use tool, designed for local performance, opposed to heavier workflows requiring greater processing. Considering this lesson coincides with human review of licence terms and conditions, we remain concerned with extracting information, and not necessarily the mapping of term frequencies or data visualisation. Therefore, spaCy suffices as a low-resource approach, opposed to more advanced NLP models like BERT-based vectorisation. 

While NLP approaches break text into individual word elements (tokens), spaCy also includes a parser to better understand the structure of agreements. We use this parser to reassemble tokens and extract full clauses, helpful for further - specialist - review. 

spaCy - like most NLP tools - handles structured information particularly well, especially if key terms or phrases can be modelled beforehand. As explained, we constructed a dictionary of terms relevant to AI license issues and based on our own understanding of such terms and conditions, particularly leveraging Fenlon’s background [^1]. The Authors remain conscious that using AI-based NLP on AI tool licences could be misconstructed as simple ‘AI on AI’ research. spaCy is adopted as a critical, tested, and trustworthy workflow, together with our tailored construction of a terms and conditions dataset, based on Birmingham and Buffalo input. This lesson also includes a human review of red flags as final decision-making. We also remain aware of limitations in fine-tuning models to specific vocabularies. 

spaCy, being an NLP library, does not retain data and remains fully open-source, essential for University of Birmingham and Buffalo collaboration. 

## Learning keys

### Concepts

We take a purposefully broad definition of **Artificial Intelligence**, as our lesson extracts terms and conditions from a range of tool providers. Libraries have distinguished between established algorithms for predicting, classifying and categorising data, and more-recent Generative capabilities (McGregor, 2025). However, we adopt a concept of AI that encompasses both. This follows Robinson (2022: 8) in seeing broad definitions of AI as big tents and allowing non-developer input. Nevertheless, each AI-enabled technology has its own context and developmental history.

### Terms

In terms of legal terms: 

**Licences** are a formal permission to use something, in this case paid-for access and use of online content or tools. It is a document that contains all the terms and conditions of use associated with that content, detailing what can and can’t be done, by whom, for how long, and what happens if there are any problems (JiSC, n.d.).

A **warranty** is a contractual promise regarding the existence of a set of conditions, for instance the maintenance of a certain software dependency. A breach of warranty enables the innocent party to claim damages, but may not allow them to exit a contract, presenting a risk for both libraries and researchers. Warranties, and their obligations, can differ immensely between industries and agreements (LexisNexus, 2026). 

An **indemnity** is an agreement, whereby one person bears the cost of a claim brought against them, under a specific circumstance, together with warranties they are used to apportion commercial risk. These are usually related to unforeseen issues, and are in essence ‘debt claims’ (LexisNexis, 2026).

In both cases, legal professionals have identified issues in regulating current AI innovation, as well as how such issues play out in court, proposing instead AI guarantee schemes (Erdelyi & Goldsmith, 2020). With regulatory frameworks likely to further shift as technological innovation increases, apportioning transparent and consistent AI liability requires international cooperation, together with shared legal definitions.

### Time

We anticipate this lesson taking an hour, not including dictionary refinement and red flag review.

## Learning experiment

### Aims

After completing this lesson, you will be able to deploy a spaCy powered Natural Language Processing (NLP) workflow for extracting problematic terms in AI licence documents. You will also be able to refine the provided NLP dictionary, to enable work on your own licences. This lesson also provides human translations of some key extracted clauses, to inform your qualitative review. 

### Inventory

Datafiles - 
  
  Our compliant AI tool licence agreements [^1].
  
Software - 

  Jupyter Notebook as a base coding environment
  [PDFPlumber](https://github.com/jsvine/pdfplumber) (Python), for text extraction of born-digital licences
  spaCy (Python), for NLP workflow
  [pandas](https://pandas.pydata.org) (Python), for data frame construction of extracted results and .csv file export 
  Microsoft Excel for manual red flag review 

### Workflow

The following provides a step-by-step walkthrough of our established spaCy method for extracting red flag terms in AI licence agreements. 

#### Step 1: spaCy installation 

First of all, to ensure there is no conflict between any pre-installed Python libraries you may have, and the contents of this lesson, we advise setting up a dedicated environment through *conda*, which can be downloaded [here](https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html). 

In your computer terminal, call this something intuitive, like AI_licence_nlp, and include the latest python version:

                  ```conda create -n AI_licence_nlp python=3.11```

Once downloaded, click *y* to proceed -

Then activate conda: 

                ```conda activate AI_licence_nlp```

You should see in the terminal that your directory has changed from (base) to (AI_licence_nlp), appearing before your device credentials.
                   
              ```(AI_licence_nlp) joenockels@Joes-Air ~ %```

Conveniently, we can then download all the required Python libraries straight through the terminal and into your conda environment - 

             ```pip install spacy
                pip install pandas
                pip install jupyter 
                pip install ipykernel```

Now, from your spacy library, you can now download the specific English language pipeline and model used in this lesson:

            ```python -m spacy download en_core_web_sm```

With your libraries and packages now downloaded through the terminal, we can now register the Python kernel in Jupyter Notebooks, which allows you to move from working in your terminal to using Jupyter’s more intuitive interface for the rest of the lesson. This interface still runs locally.

            ```python -m ipykernel install --user --name licence_nlp --display-name "Python (AI Licence NLP)"```

### Step 2: Running a Jupyter Notebook environment 

Then, simply, type Jupyter Notebook after the *%* in your terminal, this will open up the interface. 

Select *new* from Jupyter’s drop-down menu. You should see the display-name *AI Licence NLP*, click through and open up your notebook. This *kernel*, or Jupyter file, contains all the libraries and packages installed in Step 1. Name your notebook something intuitive like *spaCy_licence_experiments*. This will save an .ipynb file, which can be shared, as well as (re)uploaded to Jupyter, in case of working collaboratively. 

Note: Keep your terminal open, which should now show a green bar and the message *Connecting to kernel …*. If so, the local host is running properly. You should receive a warning if you decide to close the terminal, but if not, exit Jupyter and go through the process again.

Your screen should now look like Figure 1, with Jupyter showing a new notebook, and your terminal running in a smaller window. 

[Fig 1] Apple Mac OS, with blank Jupyter Notebook (AI_Licence_NLP kernel), and base terminal running the local host. 

## STEP 3: Dataset and spaCy deployment

Begin by importing the set folder of AI tool licences, gathered by Estrada and replicating the current tools discussed at the University of Buffalo for institutional purchasing. This code then prints the first 1,000 characters and displays them within Jupyter, to verify that the machine-readable content is accurate for NLP.

    ```with open("data/agreements/", encoding="utf-8") as f:
       print(f.read()[:1000])```

You can also, through our constructed folder, pick out an individual licence, if more relevant to your own research practice. In this case, we use Transkribus's current terms and conditions. Then set a convenient, and easily rememberable variable, for the read text, in this case *TK_document* -  

    ```with open("data/transkribus_terms.txt", encoding="utf-8") as f:
       print(f.read()[:1000])
             TK_document = nlp(text)```

Now you can import spaCy, as well as pandas (used for later data frame and .csv file exportation), as well as the required package - PhraseMatcher. Unlike some other NLP approaches, which label data, tokenise (break a text into discrete words), and pre-process, as an initial step (see Havens, 2022), we perform these actions as part of our dictionary set-up, to reduce processing steps: 

    ```import spacy
       from spacy.matcher import PhraseMatcher, Matcher
       import pandas as pd

       nlp = spacy.load("en_core_web_sm")```





















### Summary


## Local application
### Apply this method
### Other projects
### Continued learning

## Endnotes
