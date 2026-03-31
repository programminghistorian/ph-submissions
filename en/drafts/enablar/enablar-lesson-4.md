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
topics: 
abstract: With AI capability gaining strong media attention, university staff and students are exploring new ways of leveraging automation in their own research. Subsequently, Higher Educational libraries, specifically copyright and licensing teams, are now positioned as key advice givers, especially on Intellectual Property matters and data protection implications in using AI-based tools for research activities. Therefore, this ENABLAR lesson takes guidance from local experts, both within libraries and digital research, to inform a Natural Language Processing workflow for locating ‘red flag’ clauses in AI tool licence agreements. In doing so, we aim to build researcher and library practitioner confidence in interpreting complex legalistic documentation, while also informing critical and appropriate AI use in research.
Nothing in the lesson is intended to constitute legal advice from a qualified lawyer, or intended to replace seeking library expertise.
avatar_alt: Visual description of lesson image
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

- Introduction, Increasing Exposed to AI Risk (https://github.com/programminghistorian/ph-submissions/blob/gh-pages/en/drafts/enablar/enablar-lesson-4.md#introduction-increasing-exposure-to-ai-risk) 
- Using Natural Language Processing
- Some Disclaimers ... 
                - This is not legal advice
                -  Legal jurisdictions, terms and transferability 
- Pre-requisites
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

While offering potential benefits to research, AI simultaneously exposes institutions, and individuals, to a new landscape of Intellectual Property (IP) concerns. Students and staff using AI software are often unaware of legally problematic terms and conditions in tool licence agreements: especially in the case of free, freemium, or subscription-based models (University of Birmingham, 2026).  This knowledge gap has clear implications for research activities, ranging from data privacy issues, third-party dependencies, data retention, cost and inaccuracies, notably from AI’s confident-mistakes and ‘hallucinations’. Researchers are thereby accepting unknown levels of individual risk through engaging in ‘Shadow AI’ practice, the unauthorised use of GenAI tools, or Machine Learning models, without approval from an organisational IT department (Krantz et al., n.d.). In 2024, over one-third (38%) of employees surveyed by the National Cybersecurity Alliance acknowledged sharing sensitive work with an AI tool, without their employers’ permission. With chat-based AI only growing more intuitive, and marketable to researchers - at all levels, such fears from those tasked with data protection, safeguarding institutional reputations, and cyber security are unlikely to be allayed. 

The same National Cybersecurity Alliance 2024 report also cited a lack of institutional training around appropriate AI usage, mirroring older reports of library users (Cox, 2021). These training issues are compounded through university libraries being restricted in trialling lesser-known AI systems, under controlled conditions, due to their deep integration with a certain technology provider, seen in being either a Google or Microsoft ‘Campus’ (Rungkaew, 2025). In considering such factors, this ENABLAR lesson aims to increase participants’ understanding of the current risks to Higher Educational libraries, and researchers, in licensing AI tools without proper review. 

Through practical workflows and collaborative reflection, we bring together perspectives from across the research, library, and legal domains. Our understanding of AI terms and conditions are situated in our daily roles as: Open Research Services Roadmap Project Lead and Head of Copyright and Licensing at the University of Birmingham (Fenlon); Digital Scholarship Librarian at the University of Buffalo (Estrada); and Lecturer in Digital Humanities at the University of Glasgow (Nockels). This lesson, therefore, is based on our own positional views of AI, technical research, and servicing of library users. These views, while influenced by our professions, are our own and may not be fully representative of our respective institutions.

As described, there is a current capability and knowledge gap in interpreting AI licences from a library and research standpoint. There is also a lack of coordinated resources to better inform those trialling AI for research, or advising such processes. 

As such, we see this lesson as particularly useful for: 

    Library collection managers;

    University-level researchers, especially those concerned with AI - such as the Digital Humanities; 

    Students interested in using AI for their own research practice; 

    Copyright and licensing teams within Higher Education; 

    Rights and reproduction managers within Higher Education; 

    Libraries engaged in public-private partnerships surrounding using third-party AI tools



## Preliminaries

#### Method

In interpreting AI tool licences, we make use of spaCy, an open-source library for NLP, that conveniently operates within Python. As Nandini (2024) suggests, spaCy can be an easy-to-use tool, designed for local performance - in our case, constructing a tailored set of labelled red flag terms. spaCy also includes a parser to better understand the structure of licence agreements, which also enables the extraction of full clauses, for further - specialist - review. 

#### Technical context

For other Programming Historian applications using spaCy, see Kane’s (2023) lesson on corpus linguistic annotation and interpretation. Away from historical linguistic data, spaCy has been used to review and analyse clinical notes to improve patient outcomes (Schmidt et al., 2026), as well as to consensually extract payment data within financial institutions, aimed at ensuring anti-money laundering compliance (Nayak, 2026). As such, spaCy - like most NLP tools - handles structured information particularly well, especially if key terms or phrases are known beforehand. In using Author expertise and reading current guidance (JiSC, n.d.; Holt & Kefalea, 2025; University of Birmingham, 2026), our dictionary approach attempts to model contractual language closely. Without such tailoring spaCy may extract generalised language, less relevant to interpreting potentially problematic language in AI tool licence agreements, which forms one limitation of this lesson.

#### Social context

We do not intend for this lesson to be seen as legal advice, but instead hope it informs those engaged in digital scholarship and AI use within libraries, about outstanding risks in terms of institutional compliance, tool cost, warranties, indemnities and liability. Therefore, this lesson does, and should not, replace local expertise from Copyright Officers or Intellectual Property Managers, or anyone else working to advise staff, students and organisations on licences in a professional capacity. 

We also acknowledge the limitations of this lesson in terms of global transferability, with libraries and researchers operating within vastly different intellectual property spaces. In reviewing our own positionality, we find concerns such as fair usage versus compliance to be heavily Anglo-American centered. However, where possible, we aim to connect these understandings with other geographies throughout the lesson. We also draw on AI tool licence agreements from tool providers outside of the UK and America as case examples, notably Transkribus. In using NLP frameworks, we provide a reproducible, and easily translatable method for extracting legalistic terms from AI tool licenses, although again recognise limitations in dealing with fine-tuning models to specific vocabularies. 

Holt and Kefalea (2025) provide a helpful overview of the ethical underpinnings of increasing AI usage for research, through their Risk Management Toolkit for Open GLAM. Here, they suggest that legal risk areas emerge in using digital materials, through ‘potential misuse of open access materials and the risk of infringements due to incorrect licensing’, as well as the ‘[A]dherence to third-party terms of service …’. Although speaking in the context of broader digital collections usage, we situate such concerns in our specific lesson on AI tool licences. The Authors, thereby, see such legal issues and strategies as underpinning other risk mitigation areas around restrictive contracts and weak privacy safeguards, which include financial risk (from unexpected liabilities, when terms of service are breached); ethical (whereby AI tools and outputs cause harm, for instance the revealing of personal information or causing environmental damage); technical (through platform dependency and forced takedowns), and geopolitical concerns (whereby legal pressure can be applied and leveraged through technology terms of use). 

As such, this lesson advocates for greater transparency in AI tool licensing, and hopes to inform your regular reviews of AI terms of service, whether using tools for generating material, hosting, sharing or general dissemination. 

We, however, appreciate that ensuring compliance institutionally relies on legal expertise, as well as contracted staff able to inform such reviews. Better interpreting AI licence agreements, therefore, must be  situated against financial and resource limitations in libraries, which often hinder the ability to manage and advise on AI usage. This has led to increases in public-private partnerships, whereby libraries attempt to minimise the upfront cost of intellectual property review, which require careful contractual design to avoid furthering copyright and licensing risk (Lundborg, 2024). As such, this lesson sits within an increasingly murky space, compounded by institutional resourcing factors, revenue generation, AI commercial marketing, and data access.

#### Prerequisites

##### Data type/format

Three representative AI tool licences  as PDFs (c. 8 - 15 pages, 6,000 to 8,000 words). This data was decided in consultation with both libraries, interpreting licences from AI tools currently heavily requested by our own staff and students.

##### What kinds of data/data format can this method handle well?

Structured data, especially where contents can be pre-determined or modelled. We realise the limitations in this method, however offer a robust dictionary for relevant AI tool licence flags, that we trust will have transferability to other agreements. spaCy relies on parsed and extracted text froom documents, therefore - the method relies on standardised documentation, for instance print text licence agreements.

##### Are admin privileges required?

No administrative privileges are required, the AI tool licences provided as a use case are done so with the University of Birmingham’s permission. Although Jupyter Notebook may require administrative privileges, if using an institutional laptop, provided that spaCy is downloaded - the following code can be deployed within your terminal or through your command line. See this Python guidance for the range of options in deploying such code - https://realpython.com/run-python-scripts/

##### Can the method be scaled for larger datasets?

Yes - simply refine and add to the spaCy dictionary as appropriate. The Python workflow is also extensible, with no functions determined by dataset size, provided your computational RAM and disk memory is high enough. We have developed this workflow with a mind to inform University of Birmingham internal processes and AI tool licence review, so welcome any comments as to its scalability.

##### Connectivity

Provided that the spaCy NLP library has been installed within Python, you can complete this lesson offline. We also make use of Jupyter Notebooks as an intuitive environment to construct and troubleshoot this lesson’s code, which - once downloaded - can be accessed offline through a locally hosted server. See - https://jupyter.org/install, for advice on setting up this environment. The AI tool licences provided as a use case can also be stored locally, as simple PDFs, and are, therefore, accessible offline.

##### Language

Although our lesson makes use of spaCy’s main English language pipeline (en_core_web), the NLP library supports 75+ languages and has equivalent pipelines for 25 languages (https://spacy.io/usage/facts-figures). These NLP pipelines range from Greek to Korean, Norwegian Bokmål to Catalan.

##### Costs

This lesson has no associated cost, or tiered / time-limited access. Therefore, we do not require you to supply any personal information to make use of this lesson. 

##### System requirements

Our NLP workflow, using pre-built models, was constructed and tested using a personal Mac device with 8MB RAM. As such, any device should be able to enact this lesson’s code, although slight syntax adaptations may be needed depending on your Operating System. 

The code written for the lesson was troubleshooted and deployed using a Mac Silicon (M1), with 8MB of RAM and using an Arm64 local CPU, opposed to 86x64 bit set-ups common for Intel processors. Therefore, some minor environment changes may be needed to run the code effectively. Arm64 build are common for NLP pipelines, so was opted for in this lesson.

This lesson uses the latest, at time of writing, Python version (3.14.3), and the latest spaCy version (3.8.0).

Apart from spaCy and Jupyter Notebooks (although this lesson can be adapted to working straight inside your machine terminal), the lesson includes the open-source Python package PDFPlumber for licence upload and text extraction. 

We also evaluate, clean and structure our exported ‘red flag’ list within Microsoft Excel.

##### Knowledge and applied experience

No familiarity with spaCy is needed, as the NLP library will be deployed within Python as any other package. A knowledge of basic Python functions, for example importing libraries and establishing functions, is helpful, however we offer interpretable commenting throughout. As suggested, expertise on spaCy can also be gained through Programming Historian and Kane’s (2023) lesson on corpus linguistic annotation and interpretation. spaCy also includes an intuitive installation and deployment walk-through. For a general introduction to the method, see - Khan (2022).

In using NLP on legalistic documents, some expertise in basic copyright and intellectual property is also useful, especially how to discern what is in and out of copyright, the importance of locating ownership over data and a general understanding of the General Data Protection Regulation (GDPR). Naomi Korn Associates offer a basic guide to copyright (https://naomikorn.com/courses/copyright-basics-and-data-protection-basics/), and information on GDPR can be found here - https://gdpr.eu/what-is-gdpr/.  
 
We define key legalist terms throughout the lesson, but begin with a definition of what a licence means in this context. A licence is a formal permission to use something, in this case paid-for online content. It is a document that contains all the terms and conditions of use associated with that content, detailing what can and can’t be done, by whom, for how long, and what happens if there are any problems (JiSC, n.d.).

In using accessible, pre-built and, in the case of spaCy and Python open-source tools, there is ample troubleshooting support. The discussion GitHub, for instance, offers an extensive overview of common spaCy bugs and issues - https://github.com/explosion/spaCy/discussions/8226. There is also support through Jupyter Notebook’s Read the Docs. 

Although our tests indicate that the spaCy workflow is suitable for 86x64 intel environments, you can establish an Arm64 build using Docker. First download the container software, which again is a commonly used and compliant tool for environmental builds, depending on your machine - https://www.docker.com/get-started/. Then run the following to ensure Arm64 compliance, using your in-built terminal - 

     docker run --platform linux/arm64 python:3.11

    python -c "import platform; print(platform.machine())"

spaCy’s walk-through also offers guidance for further NLP training and deployment, for instance using ‘parts-of-speech’ tagging or sentiment analysis. 

#### Difficulty

Although the technical processes underpinning this work are at the beginner level, considering the legalistic expertise - the general pre-requisitive knowledge needed is intermediate.

## Use Case
### Dataset
### Software/tool

## Learning keys
### Concepts
### Terms
### Time

## Learning experiment
### Aims
### Inventory
### Workflow
### Summary


## Local application
### Apply this method
### Other projects
### Continued learning

## Endnotes
