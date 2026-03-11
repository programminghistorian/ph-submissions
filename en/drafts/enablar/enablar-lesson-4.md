---
title: "Terms and Conditions: Interpreting AI Tool Licences in Research Contexts through Natural Language Processing (spaCy)"

slug: enablar-lesson-4
layout: lesson
collection: lessons
date: 2026-03-11
authors:
- Alex Fenlon
- Natalia Estrada
- Joseph Nockels
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket:
difficulty: intermediate 
activity:
topics: copyright and licensing, AI guidance, terms and conditions, Natural Language Processing (NLP)
abstract: With advances in AI capability, researchers are increasingly exploring how such tools might be leveraged for their own work. This has positioned Higher Educational libraries, specifically Copyright and Licensing Teams, as key advice givers, suggesting responsible, appropriate, ethical and transparent tools for staff and students to use, and making clear the implication of AI on their research activities. This ENABLAR lesson, therefore, takes such advice - from local experts - to inform a Natural Language Processing workflow to locate ‘red flag’ clauses in AI tool licence agreements. This is not meant as an alternative to seeking library expertise, however it aims to build confidence in interpreting complex legalistic documentation and appropriately using AI methods for research.
avatar_alt:
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction 

Following recent advances in Large Language Models (LLMs), libraries and researchers are increasingly exploring how Artificial Intelligence (AI) might be leveraged to support internal processes, engagement strategies and digital scholarship. However, these newfound capabilities have simultaneously exposed institutions, and individuals, to legally problematic terms and conditions, especially in the case of free, freemium, or subscription based AI tools and models (University of Birmingham, 2026). This has clear implications for research activities, conducted with library support, as well as ensuing risk from activities undertaken against institutional protocols.
In considering such factors, this ENABLAR lesson aims to increase understanding of the current risks to libraries, and researchers, in licensing AI tools without proper review. In doing so, we outline the practical considerations in adopting AI tools within libraries, specifically for those working in Higher Education, who hold a remit to advise students and staff on digital tool usage. As such, we see this lesson as particularly useful for: 
Library collection managers;

    Digital Humanities researchers, and those working within broader digital scholarship circles; 

    Copyright and licensing teams within Higher Education; 

    Rights and reproduction managers within Higher Education; 

    Students interested in using AI for their own research practice; 

    Libraries engaged in public-private partnerships surrounding using third-party AI tools

By taking a situated understanding, this lesson presents an informed and reproducible workflow for interpreting AI tool license agreements. We do this through Natural Language Processing (NLP): the field of digital research involving interaction between computers and human language, encompassing tasks such as text analysis, translation, and parts-of-speech tagging, to extract key terms and clauses in AI tool licenses to Higher Educational libraries. This informs the construction of a dictionary of ‘red flags’ from terms of service and licence conditions, and provides a source to develop institutional AI preparedness, alongside extant guidance (see Archives & Records Association, 2026). Our lesson, therefore, focuses on terms associated with AI tool use, however also connects these features to broader contracts and licences negotiated by libraries.

We also make use of the Authors’ intellectual property expertise, and provide human translations for our extracted spaCy clauses. This not only evaluates our NLP approach, considering whether extracted clauses are truly red flags, but offers a reflective review of the process and legalistic terms surrounding AI use within libraries, based on our own daily roles as: Open Research Services Roadmap Project Lead and Head of Copyright and Licensing at the University of Birmingham (Fenlon); Digital Scholarship Librarian at the University of Buffalo (Estrada); and Lecturer in Digital Humanities at the University of Glasgow (Nockels).

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
