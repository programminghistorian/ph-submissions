---
title: "Terms and Conditions Apply: Interpreting AI Licences in Research Contexts with Natural Language Processing"
slug: enablar-lesson-4
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
  - Joseph Nockels
  - Natalia Estrada
  - Alex Fenlon
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket: ""
difficulty: 2
activity: ""
topics:
   - AI licences
   - Natural language processing
   - Terms and conditions
   - AI risk and evaluation
   - Library services
abstract: >
  This lesson supports you in evaluating AI tool licences
  using Natural Language Processing (NLP) to extract potentially
  problematic 'red flags' in terms and conditions. In doing so,
  we hope to fill an identified confidence gap in interpreting legalistic
  clauses, especially within Higher Educational librarians and amongst digital
  scholars. In turn, this lesson advocates for critical AI use, risk mitigation,
  and institutional-researcher dialogue.

  We do not intended this lesson to constitute legal advice from a
  qualified lawyer, nor seek to replace library expertise.
  
avatar_alt: Red flag graffiti
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

## Introduction, Dealing with Increasing Exposure to AI Risk

The increasing deployment of Artificial Intelligence (AI) is particularly visible in Higher Education, with various technologies being used to proofread job applications, conduct literature reviews and generate personal websites. Subsequently, university libraries now contend with newfound staff and student expectations as to how AI can support their scholarship, workplace efficiency and ideation strategies, automating previous manual work [^1]. Large Language Models (LLMs), trained on huge amounts of text, and the chat-based interfaces supporting them, have led library users to anticipate querying resources based on natural language, opposed to keyword searching [^2]. Alongside this shift in how users retrieve information, Agentic AI systems couple LLM models, like Gemini or Claude, to external software: from calendars to email inboxes [^3]. Often, these tools are adopted to improve the quality of work and reduce time; however, they too change the rhythm and nature of research, pushing against established safeguards [^4]. While offering potential benefits to research, AI therefore exposes institutions, and individuals, to a new landscape of Intellectual Property (IP) concerns and potential legal risk. 

Researchers using AI software are often unaware of legally problematic terms and conditions in tool licence agreements, especially in the case of free, freemium or subscription-based models [^5].  This knowledge gap has clear implications for scholarship activities, ranging from: data privacy issues, third-party dependencies, data retention, cost and technical inaccuracies. Staff and students can accept unknown levels of individual risk by engaging in ‘Shadow AI’ practice, the unauthorised use of Generative AI (GenAI) tools, without approval from their IT department [^6]. In 2024, over one-third (38%) of employees surveyed by the [National Cybersecurity Alliance](https://www.infosecurity-magazine.com/news/third-employees-sharing-work-info/) acknowledged sharing sensitive work with an AI tool, without their employers’ permission. With chat-based AI only growing more intuitive and marketable to researchers - across all levels; anxieties around data protection, safeguarding institutional reputation and cyber security are unlikely to lessen. 

The same [National Cybersecurity Alliance 2024 report](https://www.infosecurity-magazine.com/news/third-employees-sharing-work-info/) cites a lack of institutional training around appropriate AI usage, mirroring established reports on library staff and users needing greater AI awareness [^7]. However, satisfying AI training issues is complex and compounded by libraries being restricted in trialling lesser-known systems under controlled conditions, due to their deep integration with large technology providers, described as being a 'Google' or 'Microsoft Campus' [^8]. 

Through considering both individual research behavior and institutional factors, this ENABLAR lesson aims to increase understanding of the current risks imposed by licensing AI tools without proper review. It presents you with a practical workflow for flagging such risks, informed by bringing together our own perspectives from across research, library and legal domains. This understanding of AI terms and conditions is situated in our daily roles as: Open Research Services Roadmap Project Lead and Head of Copyright and Licensing at the University of Birmingham (Fenlon); Digital Scholarship Librarian at the University at Buffalo (Estrada); and Lecturer in Digital Humanities at the University of Glasgow (Nockels). Our lesson is based on our own positional views of AI, technical research and servicing of library users. These views, while influenced by our profession, are our own and may not be fully representative of our respective institutions.

In responding to the current capability and knowledge gap in interpreting AI licences from a library and researcher standpoint, this lesson provides you with a coordinated resource to better inform your trialling of AI for library services and digital scholarship. As such, we see this lesson as particularly useful for: 

    Library collection managers;

    University-level researchers, especially those concerned with AI - such as in the Digital Humanities; 

    Students interested in using AI for their own research practice; 

    Copyright and licensing teams within Higher Education; 

    Rights and reproduction managers within Higher Education; 

    Libraries engaged in public-private partnerships surrounding using third-party AI tools

## Using Natural Language Processing 

This lesson provides a reproducible workflow for interpreting AI tool licence agreements through Natural Language Processing (NLP): the field of digital research involving interaction between computers and human language [^9]. NLP encompasses tasks such as text analysis, translation and parts-of-speech tagging, though we use it here to extract key terms and clauses in AI terms and conditions. As part of this, we present a dictionary of 'red flags' from licence conditions for you to experiment with. This lesson also provides a walkthrough for how to adapt and use this dictionary to increase your organisation's AI preparedness, alongside existing guidance [^10]. Though our lesson focuses on AI licenced, we connect this concern to broader tool purchasing negotiated by libraries, collaboration and data sharing agreements.

Our dictionary terms is informed by reading current guidance on approaching AI licences [^11, ^12], and extracting common AI-related terms found in the [ESAC Initiative’s registry of open licence agreements](https://esac-initiative.org/about/transformative-agreements/agreement-registry/). the resource is accessible through *Programming Historian* - [full dictionary](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/enablar-lesson-4/blank_dict), and attempts to mirror current AI contractual language. Without a tailored dictionary, we risk extracting non-relevant language through NLP, instead of interpreting problematic terms associated with risky AI use. Though we reiteratively refined this dictionary, it may still extract some non-relevant clauses. With legalistic language being complex, our method is unlikely to fully generalise to your every AI licence. As such, we also provide a corpus of AI tool licences being considered by the University at Buffalo. Alongside this corpus, we also scale down our lesson for those working on individual licences. In addition to the populated dictionary, we provide you with a blank scaffold, found [here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/enablar-lesson-4/blank_dict). Keeping only the syntax, you can edit this freely based on your own research aims, content and language. In this way, we aim to support solo librarians and researchers in interpreting AI terms and conditions, as well as broader copyright and licensing teams.

Another necessary qualification is that the ESAC agreements informing our NLP dictionary are largely from publishing contracts, not direct AI providers, due to their being limited public availability. Instead, they come from the [Association of Computing Machinery](https://www.acm.org), [University of Cambridge Press](https://www.cambridge.org), [Royal Society](https://royalsocietypublishing.org) and [emerald publishing](https://www.emerald.com). That said, ESAC’s registry ranges in geographical jurisdiction, thereby providing you with a more transferable dictionary beyond a purely Anglo-American context. 

Lastly, this lesson ends with a discusson from the Authors’ own positionality as librarians and digital researchers. This provides you with a human review of our extracted red flags from our terms of service corpus, constructed by Estrada. Our review section not only evaluates the NLP approach taken, considering whether returned terms and conditions are truly red flags, but reflects on its affordances and limitations in supporting critical AI use within libraries.

## Background to Technical Method 

SpaCy is an open-source library for NLP that conveniently operates within Python. As Nandini [^23] suggests, spaCy forms an easy-to-use tool, designed for local performance, opposed to heavier workflows requiring greater processing demands. With our  seeking to inform the human review of licence terms and conditions, we are concerned with extracting information, not the mapping of term frequencies or data visualisations. Therefore, spaCy suffices as a low-resource approach, opposed to more advanced NLP models like BERT-based vectorisation [^23]. 

While NLP approaches break text into individual word elements (tokens), spaCy also includes a parser to better understand the structure of agreements. We use this parser to reassemble tokens and extract full clauses, helpful for further - specialist - review. 

spaCy - like most NLP tools - handles structured information particularly well, especially if key terms or phrases can be modelled beforehand. As explained, we began with a constructed dictionary of terms relevant to AI license issues, based on our own understanding of such terms and conditions, particularly leveraging Fenlon’s background. The Authors remain conscious that using AI-based NLP on AI tool licences could be construed as simple ‘AI on AI’ research. Instead, spaCy is adopted as a critical, tested, and trustworthy workflow. As part of our evaluation, this lesson provides you with a human review of red flags as final decision-making. However, we also remain aware of limitations in fine-tuning models to specific vocabularies. 

spaCy, being an NLP library, does not retain data and remains fully open-source, essential for University of Birmingham and Buffalo collaboration. 

## Some Further Disclaimers … 

#### Not Legal Advice 

We do not intend for this lesson to be taken as legal advice. Instead, it serves to inform critical engagement with AI, especially around outstanding risks from: institutional compliance, tool cost, warranties, indemnities and liability. This lesson does, and *should* not, replace your seeking local expertise from copyright officers or IP managers, or anyone else working to advise staff, students and organisations on licences in a professional capacity. Our main concern is to provide you with a compliant way of siphoning down complex legal documents into structured data for specialist human review. 

#### Legal Jurisdictions, Terms and Transferability

In reviewing our own positionality, we find certain legal concepts to be heavily Anglo-American centered, such as Fair Dealing as a copyright exception [^13]. Therefore, where possible, we seek to connect these understandings with other geographies. We  draw on AI tool licences from providers outside of the UK and America as case examples, though still Eurocentric: notably [Transkribus](https://www.transkribus.org), which is maintained and developed by the Austrian-based academic cooperative [Recognising and Enriching Archival Documents](https://www.transkribus.org/about). 

The licences marketed to the University at Buffalo and Birmingham also differ based on their legal jurisdictions. This constructs a comparative dataset, important in light of increasing internationalism and research collaboration, global library infrastructure and wider challenges from AI misuse, contended with by multi-national organisations such as [AI4LAM](https://sites.google.com/view/ai4lam).

Another key variable, unable to be fully accounted for within this lesson, is the appetite for risk exercised by local institutions and individual researchers. As such, this lesson does not seek to guide readers to manage and respond to risk brought from unsanctioned AI usage, but instead presents a way to identify possible red flags to initially be aware of. 

## Preliminaries

#### Data Type and Format

This lesson demonstrates how to use our pre-prepared dictionary to identify potentially problematic terms in a sample corpus of real-world licences, held in PDF format. The sample corpus contains 29 born-digital AI licence PDFs (103,396 words), collated primarily by Estrada with input from Fenlon, based on tools being actively considered for institutional licensing at the University at Buffalo and University of Birmingham. We also explain how the same method can be scaled down for reviewing individual licence agreements.
  
#### What NLP Handles Well 

NLP works well on structured data, especially when language can be pre-determined or modelled closely. We realise the limitations in this method, though offer a robust dictionary for relevant AI tool licence flags, that we trust will have a degree of transferability to other agreements. Following this code syntax also enables you to refine the dictionary, based on your own licences, as a fluid resource.

To keep our lesson focused on NLP and AI red flags, we use born digital PDFs, pre-converted to computer-readable text. This avoids the process of (re)OCRing material with complex layouts; although, due to the formulaic nature of terms and condition prose, probabilistic OCR tools that return the next most likely character or word are likely to be effective in digitally transcribing such material. The quality of machine-readable text from these born digital agreements was manually checked, as well as tested through our lesson's code. We highlight occassional errors in our discussion review; however, these were minimal and did not warrant a full re-OCRing of the licences used.

#### Hardware Constraints

Our NLP workflow was constructed and tested using an Apple Mac Silicon I, with 8MB RAM. As such, similar devices can enact this lesson’s code outright. This code was also tested to minimise syntax variations when using other Operating Systems. 

We also provide a direct link to our lesson through a [Jupyter Notebook](https://jupyter.org) scaffold and coding environment, through a web hosted .ipynb file. This circumvents the need to locally download software packages, Jupyter and configure your code environment, if unfamiliar. 

#### Admin Privileges? 

Downloading Jupyter Notebooks may require administrative privileges, if using an institutional device. However, provided that spaCy is downloaded - the following code can be deployed within your computer terminal, without Jupyter. [Real Python](https://realpython.com/run-python-scripts/) offers solid guidance on the range of code deployment options, if unable to use Jupyter. Our aforementioned web-based notebook also avoids any administrative issues.

#### Scalability

###### Scaling Up for Institutions

This method is easily scalable across your own institutions' licence agreements, although the corpus constructed by Estrada aims to be representative of current AI tools marketed to university libraries. It includes AI marketed for automated literature review ([Ai2](https://allenai.org), [elicit](https://elicit.com), [Perplexity](https://www.perplexity.ai/), [scite](https://scite.ai/assistant), [undermind](https://www.undermind.ai)); chat-based and Agentic AI systems ([Google Gemini](https://gemini.google.com/), [Microsoft 365 CoPilot](https://copilot.microsoft.com), [NotebookLM](https://notebooklm.google)); and those aimed at increasing researcher efficiency through automated transcription, ([FromThePage](https://www.fromthepage.com),[Transkribus](https://www.transkribus.org/)).

Throughout our lesson, we indicate how you can refine and add to our constructed [spaCy](https://spacy.io) dictionary. The Python workflow is also extensible, with no functions determined by dataset size, provided your computational RAM and disk memory is high enough. We have developed this workflow to inform University of Birmingham and Buffalo business-as-usual activities in reviewing AI tool agreements, so chose spaCy with increased scalability in-mind.

###### Scaling Down for Individuals

We are also concerned, alongside informing library policies around AI review, in supporting individual researchers and librarians: who may only be reviewing one licence at a time. As such, we scale down our code and provide syntax templates to indicate how to tailor our NLP approach. Our full dictionary, which forms a longer code block is included as a *Programming Historian* asset [full dictionary](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/enablar-lesson-4/red-flag-dict), as well as our [blank scaffold](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/enablar-lesson-4/blank_dict).

#### Connectivity

Provided that spaCy has been installed within Python, you can complete this lesson offline. We also make use of Jupyter Notebooks as an intuitive environment to construct and troubleshoot this lesson’s code, which - once downloaded - can be accessed offline through a locally hosted server. See - [Project Jupyter Install](https://jupyter.org/install) for advice on setting up the environment. 

The AI tool licences provided as a use case can also be stored locally, as simple PDFs, and are accessible offline.

#### Language

Although our lesson makes use of spaCy’s main English language pipeline (en_core_web), the NLP library supports [75+ languages and has equivalent pipelines for 25 languages](https://spacy.io/usage/facts-figures). SpaCy's openly available NLP pipelines range from Greek to Korean, Norwegian Bokmål to Catalan. As such, we provide a [blank dictionary](ahttps://github.com/programminghistorian/ph-submissions/blob/gh-pages/ssets/enablar-lesson-4/blank_dict), whereby you can follow the given code syntax but populate the terms, phrases and categories in your own language.

#### Ethics

Holt and Kefalea (2025) [^12] provide a helpful Risk Management Toolkit to address AI’s implications for ethical and open research within libraries. They suggest that legal risk areas emerge in using digital materials through ‘potential misuse of open access materials and the risk of infringements due to incorrect licensing’, as well as the ‘adherence to third-party terms of service …’. Although speaking in the context of broader digital collections, we situate similar concerns through our interpretation of AI licences. Therefore, we see such legal strategies as underpinning broader risk mitigation efforts around restrictive contracts and weak privacy safeguards, which include financial risk (from unexpected liabilities, when terms of service are breached); ethical (whereby AI tools and outputs cause harm, for instance the revealing of personal information or causing environmental damage); technical (through platform dependency and forced takedowns), and geopolitical concerns (whereby legal pressure can be applied and leveraged through technology terms of use). Subsequently, this lesson advocates for greater transparency in AI tool licensing and hopes to inform your regular review of AI terms of service, whether using tools for generating new material, data hosting, sharing or general dissemination. 

We appreciate that ensuring AI compliance institutionally relies on informed legal expertise, as well as contracting able staff to inform reviews of terms and services. Nuanced interpretation of AI licences must be considered against financial and resource limitations to libraries, which often hinder their ability to manage and advise on AI usage [^14]. This has led to increases in public-private partnerships, whereby libraries attempt to minimise the upfront cost of intellectual property review, which requires careful contractual design to avoid worsening copyright and licensing risk [^15]. As such, this lesson sits within an increasingly murky space, compounded by institutional resourcing factors, revenue generation, AI commercialisation and data access.

#### Costs

This lesson has no associated cost, or tiered / time-limited access. 

#### System Requirements

Our code was troubleshooted using a Mac Silicon (M1), with 8MB of RAM and using an Arm64 local CPU, opposed to 86x64 bit set-ups common for Intel processors. Arm64 is common for NLP pipelines, so opted for in this lesson. Therefore, some minor environment changes may be needed to run this code locally on other Operating Systems (e.g. Linux). However, our linked Jupyter Notebook gives you a web environment to avoid such difficulties.

This lesson uses the latest, at time of writing, [Python (v 3.14.3)](https://www.python.org/downloads/) and [spaCy (v 3.8.0)](https://spacy.io/models/en).

We also use the open-source PDFPlumber package for licence uploading and writing into the Jupyter environment, instead of performing full OCR as discussed.

Our list of ‘red flags’ is exported as a .xlsx to be easily manipulated within Microsoft Excel. This aids the human review of results and informs our discussion of AI tool licence issues and the success of our NLP method.

## Use Case: Locating Potential Red Flags in AI Licences

This lesson supports those concerned with AI experimentation, such as *Programming Historians*, in evaluating AI tools based on their terms and conditions. As a secondary audience, we hope to inform those advising on AI compliance and institutional licence purchasing, especially within Higher Educational libraries. 

Through our own roles, we notice a technical capability and knowledge gap emerging, whereby scholars require greater assistance in understanding AI’s potential data protection risks. This gap is mirrored in general research activities, with benchmark surveys such as [Primary Research Group](https://www.primaryresearch.com) coordinating user gathering activities on AI licensing in Higher Education. Subsequently, this lesson emerged from informal discussions between Fenlon and Nockels around resourcing automatic transcription tools within University of Birmingham Libraries, pointing to variable guidance around server infrastructure, data sovereignty, and potential for copyright misuse. In engaging with this knowledge gap, our lesson therefore forms an anticipatory approach in locating pitfalls in current AI licences, marketed to Higher Education libraries. 

Of course, when advising on AI tool usage, it is common IP practice to locate an appropriate need first. Both the University of Birmingham and Buffalo have manual AI licence checklists to assess such criteria. However, these rely on expert know-how of warranties, legal liabilities, disputes, user and supplier obligations, associated costs and terms of AI service access. Without this expertise, university libraries are left to negotiate terms and conditions without clear guidance, at a time of increasingly slick AI marketing.

Therefore, our lesson provides a benchmark for reviewing guidance through NLP, alongside human-in-the-loop review. In turn, we explicitly document the limitations and affordances of one AI-based NLP method (spaCy), following evaluative frameworks from the library and archive sector, for instance Potter [^19].

#### Knowledge and Applied Experience

No familiarity with spaCy is needed. A knowledge of basic Python functions is helpful, for example importing libraries and establishing functions, however we explain such operations throughout. Experience in using spaCy can be gained through Kane’s [^16] and Goodale’s [^17] *Programming Historian* lessons on corpus linguistic annotation and interpretation. spaCy also includes an intuitive [installation and deployment walkthrough](https://spacy.io/usage). For a more theoretical introduction to the NLP method, see Khan [^18].

In using NLP on legalistic documents, some expertise in basic copyright and intellectual property is also useful, especially in how to discern what is in and out of copyright, locating ownership over data and a general understanding of the [General Data Protection Regulation (GDPR)](https://gdpr-info.eu). [CopyrightUser](https://www.copyrightuser.org) and the [UK’s Intellectual Protection Office](https://www.gov.uk/government/organisations/intellectual-property-office) offer basic legal guidance. The Information Commissioner’s Office also has guidance on [AI’s impact on data protection](https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/artificial-intelligence/guidance-on-ai-and-data-protection/).
 
In using accessible, pre-built and open-source tools, there is ample troubleshooting support beyond this lesson. This discussion GitHub offers an extensive overview of [common spaCy bugs and issues](https://github.com/explosion/spaCy/discussions/8226). spaCy’s walk-through offers guidance for further NLP training and deployment, for instance using ‘parts-of-speech’ tagging or sentiment analysis. There is also available troubleshoot support for Jupyter Notebook through their [Read the Docs](https://jupyter-notebook.readthedocs.io/en/stable/troubleshooting.html). 

#### Difficulty 

The NLP processes underpinning this work are at the beginner level, as we provide you with a close step-by-step workflow, with all the code necessary. 

We also breakdown key legal concepts as firm contextual grounding, especially around IP and general data protection.

## Learning Keys

### Concepts

We take a purposefully broad definition of **Artificial Intelligence**, as our lesson extracts terms and conditions from a range of tools. Libraries have distinguished between established algorithms for predicting, classifying and categorising data, and more-recent GenAI capabilities [^24]. However, we adopt a concept of AI here that encompasses both. This follows Robinson [^25] in seeing broad technical definitions as enabling non-developer input. Nevertheless, each AI-enabled technology has its own context and developmental history, often reflected in its terms and conditions of use.

### Terms

**Licences** are a formal permission to use something, in this case paid-for access and use of online content or tools. They are documents containing all the terms and conditions of use associated with that content, detailing what can and cannot be done, by whom, for how long, and what happens if problems arise [^11].

A **warranty** is a contractual promise regarding the existence of a set of conditions, for instance the maintenance of a certain software dependency. A breach of warranty enables the innocent party to claim damages, but may not allow them to exit a contract, presenting a risk for both libraries and researchers. Warranties, and their obligations, can differ immensely between industries and agreements [^26]. 

An **indemnity** is an agreement, whereby one person bears the cost of a claim brought against them, under a specific circumstance, together with warranties they are used to apportion commercial risk. These are usually related to unforeseen issues and are in essence ‘debt claims’ [^27].

In both cases, legal professionals have identified issues in regulating current AI innovation, as well as how such issues play out in court, proposing instead AI guarantee schemes [^28]. With regulatory frameworks likely to further shift as greater technological innovation emerges, we firmly believe that apportioning transparent and consistent AI liability requires international cooperation, together with shared legal definitions. In making our NLP workflow easily editable, based on language and use case, we aim to provide one such shared resource.

### Time

We anticipate this lesson taking an hour, not including your own dictionary refinement and red flag review.

## Dataset

#### Characteristics and Suitability

The construction of our AI tool licences dataset began with informal discussions around what software was familiar in our own research and library advice-giving, as part of the ENABLAR’s cohort writing reflections. This led to discussions of Agentic AI systems, in particular Microsoft CoPilot licensed to Birmingham, alongside Transkribus, used heavily in Nockels’ research. With Estrada’s involvement, our dataset includes tool licences either promoted to, actively considered, or already acquired by the University at Buffalo. This provides you with a rich comparative dataset across UK and American legal jurisdictions, and offers a way to further evaluate the success of our NLP method. This dataset was kept born-digital to avoid OCR processing and heavy pre-processing steps convoluting our workflow, especially with OCR *Programming Historian* lessons already available, see Gribomont [^20]. 

#### Pre-processing and Sampling

Transkribus and Microsoft CoPilot acted as key starting points in our data construction, akin to purposive sampling in thematic literature reviews [^21]. From this, Estrada constructed a structured folder of licences, anonymising any sensitive information, and ensuring they complied with institutional non-disclosure agreements. These were reviewed as a team to ensure an equal balance between types of AI tool. 

Nockels, before trialling spaCy, ran simple import tests to ensure the quality of machine-readable text from these licences met NLP demands. After which, stopwords, punctuation and targeted capitalisation were removed, included in our lesson walkthrough. This is common in NLP pre-processing to ensure irrelevant and noisy text is removed [^22]. For our case study, this helps you to ensure that red flag ‘hits’ are meaningful and display certain (re)occurring patterns (issues) in AI licence agreements.

#### Citation

Estrada, N., Nockels, J., Fenlon, A. (2026). [Popular Academic AI Tools Terms and Conditions, Zenodo](https://zenodo.org/records/19616877?preview=1&token=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6ImE3MWExN2E5LTE0NjgtNGFiMi1hNWJjLTYyNTE0Y2MxYTJjNiIsImRhdGEiOnt9LCJyYW5kb20iOiI5ZjY5NWZlNGE3NDFlNzA5ZjNjN2EzNjMxMjYxYjJmMSJ9.HLiESWKo1CeA_MimFtUsW1tUxtreTsdjdEJo4xb5KO7FpYNfo1aev9T7GMH6xCwRuEpDU5l3fofI_98B6tjnsg)

For our full dictionary code, see [full dictionary](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/enablar-lesson-4/red-flag-dict)

For our blank dictionary, see [blank dictionary](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/enablar-lesson-4/blank_dict)

## Learning Experiment

### Aims

After completing this lesson, you will be able to deploy a spaCy-powered NLP workflow for extracting problematic terms in AI licences. You will also learn how to refine our provided NLP dictionary for your own licences, whether as an individual file or corpus. Additionally, this lesson provides you with advice for reviewing key extracted clauses to inform your own quantitative and qualitative review of AI risk.

### Inventory

Datafiles - 
  
  Our [list of AI tool licence agreements](https://zenodo.org/records/19616877?preview=1&token=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6ImE3MWExN2E5LTE0NjgtNGFiMi1hNWJjLTYyNTE0Y2MxYTJjNiIsImRhdGEiOnt9LCJyYW5kb20iOiI5ZjY5NWZlNGE3NDFlNzA5ZjNjN2EzNjMxMjYxYjJmMSJ9.HLiESWKo1CeA_MimFtUsW1tUxtreTsdjdEJo4xb5KO7FpYNfo1aev9T7GMH6xCwRuEpDU5l3fofI_98B6tjnsg).

  Our [full dictionary](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/enablar-lesson-4/red-flag-dict) dictionary code, held as a *Programming Historian* asset.

  Our [blank dictionary](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/enablar-lesson-4/blank_dict), held as a *Programming Historian* asset.
  
Software - 

 Jupyter Notebook as a base coding environment, either through our web link or downloaded locally. 
 
 [pdfplumber](https://github.com/jsvine/pdfplumber) (Python), for text extraction of born-digital licences
  
 spaCy (Python), for our NLP workflow.
 
 [pandas and openpyxl](https://pandas.pydata.org) (Python), for data frame construction of extracted results and .xlsx file export.
  
 Microsoft Excel, for manual red flag review.

### Workflow

The following provides you with a step-by-step walkthrough of our established spaCy method for extracting red flag terms in AI licence agreements. 

### Step 1: SpaCy Installation 

First of all, to ensure there is no conflict between any pre-installed Python libraries you may have and the contents of this lesson, we advise setting up a dedicated environment through *conda*, which can be downloaded [here](https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html). 

--- 

Alternatively, if you want to avoid downloading local packages, you can click the below link. This will take you to a web-based Jupyter Notebook scaffold: 

[Jupyter Notebook link]

This web-based code mirrors the same in this lesson. However, we provide you with more detail here, so advise that you toggle between the online code window and this *Programming Historian* lesson.

---

If downloading packages locally to your device, move to your computer terminal and call this new environment something intuitive, like AI_licence_nlp. Also include the latest python version:

    conda create -n AI_licence_nlp python=3.11

Once downloaded through this terminal line, click *y* to proceed -

Then activate conda: 

    conda activate AI_licence_nlp

You should see in the terminal that your directory has changed from (base) to (AI_licence_nlp), appearing before your device credentials -
                   
    (AI_licence_nlp) joenockels@Joes-Air ~ %

Conveniently, we can then download all the required Python libraries straight through our terminal and into our conda environment - 

    pip install pdfplumber
    pip install pandas
    pip install spacy
    pip install jupyter 
    pip install ipykernel

Now, from your spaCy library, you can download the specific English language NLP pipeline, or whatever language pipeline your licences are written in. For the latter, simply change the language code, for instance for Ukrainian - uk_core_news_sm. See [spaCy's Models and Languages](https://spacy.io/usage/models) for the entire list.

    python -m spacy download en_core_web_sm

With your libraries and packages now downloaded through your terminal, we can register the Python kernel in Jupyter Notebooks (downloaded as part of your package list above). This will allow you to move from working in your terminal to using Jupyter’s more intuitive coding environment.

    python -m ipykernel install --user --name licence_nlp --display-name "Python (AI Licence NLP)"

### Step 2: Running a Jupyter Notebook

If using your own Jupter Notebook locally, instead of the above web scaffold, simply type Jupyter Notebook after the *%* in your terminal, this will open the interface. 

Select *new* from Jupyter’s drop-down menu. You should see the display-name *AI Licence NLP*. 

Click through and open up your new notebook. This *kernel*, or Jupyter file, contains all the libraries and packages installed in Step 1 through your terminal. You only need to import them now. Name your notebook something intuitive like *spaCy_licence_experiments*. This will save an .ipynb file, which can be shared with others, edited within another coding environment or (re)uploaded to Jupyter if working collaboratively. 

Note: Keep your terminal window open, which should now show a green bar and the message 'Connecting to kernel …'. If so, the local host is running properly. You should receive a warning if you decide to close the terminal, but if you exit Jupyter, simply go back into the terminal and after the % type Jupyter Notebook again.

If working locally, your screen should now look like *Figure 1*, with Jupyter showing a new blank notebook, and your terminal running in a smaller window. 

{% include figure.html filename="en-or-enablar-lesson-4-01.jpeg" alt="Computer screen showing an Apple terminal running, with Jupyter locally hosted" caption="Figure 1. Blank Jupyter Notebook (AI_Licence_NLP kernel), and base terminal running the local host." %}
 

### STEP 3: Dataset and spaCy Deployment

If using your own Jupyter environment, begin by importing pathlib, pandas and pdfplumber from your installed packages in Step 1 - 


    from pathlib import Path # for uploading licences 
    import pandas as pd # for simple data manipulation, tabulation
    import pdfplumber # for writing the files into Jupyter Notebooks

Depending on your use case, you can now import your local licence pdfs. The below code imports our 29 pdf licence dataset, within a set folder structure of 'AI Agent', 'Lit Review' and 'Transcription' agreements. Though not essential, if working across multiple licences, this folder structure may enable a comparative review of red flags across tool type within Excel, as we discuss in our review section.

    ROOT = Path("AI_Products_TOS")  # contains folders "AI Agent", "Lit Review", "Transcription"

If using your own licence, simply point Jupyter toward your local folder. This will work regardless of the amount of licences, as our following line pulls any file with a .pdf extension - 

    ROOT = Path("your_folder_name" or "your_file_path") 

To check that pathlib imported your pdf licences correctly, especially in the case of uploading a folder, use the following code. You can easily change this to other file formats, exchanging *.pdf for *.txt for instance, however the remainder of these lesson presumes pdf use, mainly for data extraction convenience.

    next(ROOT.rglob("*.pdf"))  # first PDF it finds
    print("Testing:", pdf_path)

Finally, you can print the first 1,500 characters from the initial licence found, displaying the text within Jupyter to verify that the machine-readable content is accurate enough for NLP processing. This final line silences a simple warning around pdfplumber parsing the PDF, as - on manual inspection - our text was close to fully accurate. 

    text = extract_pdf_text(pdf_path)
    print("Chars:", len(text))
    print(text[:1500])  # preview first 1500 characters

    import warnings
    warnings.filterwarnings("ignore", message="Could not get FontBBox from font descriptor.*")

To further verify that pathlib has found, and pdfpplumber has read, all your intended PDFs, you can print the number of agreements imported into Jupyter, as well as their file names.

    pdfs = list(ROOT.rglob("*.pdf"))
    print("Found PDFs:", len(pdfs))
    for p in pdfs[:10]:
        print(p)

Now import spaCy, as well as its required PhraseMatcher. Unlike some other NLP approaches, which label data, tokenise (break a text into discrete words) and pre-process (converting all text to lowercase for instznce) [^29], we perform these actions as part of our dictionary set-up. This allows us to hone our approach to the specific language of AI licence agreements. The last line loads spaCy's standard English langauge model, already downloaded in Step 1 through your terminal.  

    import spacy
    from spacy.matcher import PhraseMatcher, Matcher
    nlp = spacy.load("en_core_web_sm")

### Step 4: Dictionary Setup

In order to extract meaningful words and patterns (phrases) from our AI licences, we need to remove noisy text elements, in our case stopwords that are irrelevant to red flag terms and conditions. Although agreements may include more implicit undertones of risk, spaCy works through simple term and phrase matching, opposed to understanding broader language construction, which would require processing out-of-scope for this lesson, potentially using an inference model or LLM. Nonetheless, this extraction approach works well, due to AI licence agreements being relatively formulaic, with repeating clauses and structures. 

The following code establishes our dictionary of terms and phrases, based on those found through the ESAC register, tool licence guidance, and in consultation with Fenlon. 

For your own purposes, you can easily delete non-relevant dictionary entries, or add to any patterns, directly within this code. Keep in mind that the current dictionary has valid spaCy NLP syntax - especially the use of bracketing and commas between phrases.

We begin by providing you with a blank dictionary scaffold to follow, to outline this syntax. First name your dictionary: 

    name_of_dictionary = {

After naming your dictionary, group phrases and patterns into set themes based on common AI risks (e.g. privacy). These outline the main data protection issues surrounding AI licensing, which acquisition librarians regularly assess - 

    "risk or AI_theme": {

    "associated phrases": [
        "phrase", 
        "phrase",
        "phrase",
        ],
    
    "patterns": [

        [

It is best practice to lemmatise your terms, where appropriate. This truncates words to their canonical root, for instance 'train' for 'training', and will add flexibility to your dictionary by accounting for language variations -

            {"LEMMA": "term"}, # include lemma if necessary, for instance train from training

Though optional, *"OP": "?"* adds a placeholder token to ensure that terms remain associated and 'flagged', despite being stretched across a non-relevant word or set of words. This picks up such phrases as *training **our** model*, despite *our* not being a set term -

            {"OP": "?"},
            {"OP": "?"},
            
Again optional, but the following line makes the phrase or term lowercase. This normalises our Excel red flag export and helps reduce duplicated hits, while enabling spaCy to factor in sentence structure, with certain terms appearing lowercase if associated with other word units. This also spots if red flag terms appear at the beginning of sentences and, therefore, capitalised.

            {"LOWER": {"IN": ["model","system","algorithm"]}} 

End the dictionary pattern rule with a ']' and comma, before beginning with another associated AI risk - 

        ],

To close the full dictionary, include the following curly brackets - 

       }, 
       }

We provide a full empty dictionary scaffold as a *Programming Historian* asset [here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/enablar-lesson-4/blank_dict). 

As a guide for you, the below code populates one AI risk category from our empty dictionary scaffold. First of all, we group terms and phrases under the theme *AI training*, whereby user data feeds into the background processig of a tool. Through a thorough reading of ESAC agreements and the wider literature mentioned, we draw out key phrases associated with this AI risk. 

Our full dictionary is also included as a *Programming Historian* asset [here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/enablar-lesson-4/red-flag-dict), due to its considerable length. It serves as a useful guide, and can even be used as a simple plugin dictionary, including risk categories of 'data retention', 'data ownership', 'security', 'copyright', 'accessibility', and 'liability', again constructed through practitioner consultation with Fenlon and Estrada.

    red_flag_dict = {

    "AI_TRAINING": {

    "phrases": [
        "train",
        "improve",
        "enhance the capabilities",
        "develops",
        "automated techniques",
        "generate outputs",
        "computational analysis",
    ],


Here, the root term *train* is associated and made lowercase, when appearing alongside *model*, *system*, *algorithm*. We also include two placeholders, to stretch the matches over a sentence, and lemmatise *train* to account for *trained* or *training*.

    "patterns": [

        [
            {"LEMMA": "train"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": {"IN": ["model","system","algorithm"]}}
        ],

        [
            {"LEMMA": "improve"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": {"IN": ["model","system","service"]}}
        ], 
     
        [   {"LEMMA": "enhance"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": {"IN": ["model","system","algorithm", "service"]}} 
        ],
        
        [   {"LEMMA": "develop"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": {"IN": ["model","system","algorithm", "service"]}} 
        ],
        [   {"LEMMA": "automate"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": {"IN": ["system","technique","performance", "service"]}} 
        ],
        [   {"LEMMA": "generate"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": {"IN": ["output","response","content", "information"]}} 
        ],
        [   {"LEMMA": "computation"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": {"IN": ["analysis"]}} 
        ]
    ]
    },

We do the same for associated financial risks and hidden costs as another AI risk theme. These themes will be exported as a set of columns, to better compare and contrast red flag hits within Excel - 

    "COST": {

    "phrases": [
        "associated costs",
        "monetary reward",
        "profit",
        "sale",
        "resale",
        "loan",
        "transfer",
        "hire",
        "reimbursed",
        "fee payable",
        "subscription",
        "charge",
    ],

    "patterns": [

        [
            {"LEMMA": "cost"},
            {"OP": "?"},
            {"LOWER": {"IN": ["data","service","subscription","usage"]}}
        ],

        [
            {"LEMMA": "reward"}
        ],

        [
            {"LEMMA": "profit"}
        ],

        [
            {"LEMMA": "sell"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": {"IN": ["data","service","product"]}}
        ],

        [
            {"LEMMA": "loan"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": "amount"}
        ],

        [
            {"LEMMA": "transfer"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": "service"}
        ],

        [
            {"LEMMA": "hire"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": "service"}
        ],

        [
            {"LOWER": "fee"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": {"IN": ["licence","license","payable","required","reimbursed"]}}
        ],

        [
            {"LOWER": "subscription"},
            {"OP": "?"},
            {"OP": "?"},
            {"LOWER": {"IN": ["model","system","plan"]}}
        ]
    ]
    },

    },

    }

### Step 5: Running PhraseMatcher

However related to AI risk, a list of individual word tokens is not illuminating enough to assess red flags in licence agreements within full context. As such, we use spaCy’s in-built PhraseMatcher, which overlays the outlined dictionary rules onto our licence corpus, before returning word and phrase matches based on the patterns established. 

First, load the matchers - 

    phrase_matcher = PhraseMatcher(nlp.vocab)
    token_matcher = Matcher(nlp.vocab)

You can also include attr = lower after nlp.vocab, though this would convert all results into lowercase. Our current code more finely accounts for sentence structure by including lowercasing for specific dictionary sections, although this proves more painstaking.

Then, return the word tokens and the categories of risk in your dictionary, to ensure that both matchers are properly assigned -

    for category, rules in red_flag_dict.items():
        phrase_matcher.add(category, [nlp.make_doc(p) for p in rules.get("phrases", [])])
        token_matcher.add(category, rules.get("patterns", []))

To ensure your dictionary is properly plugged into the NLP pipeline, print the categories (these should match your dictionary themes, e.g. 'AI_training') - 

    print("Loaded categories:", list(red_flag_dict.keys()))
    

—--

After loading the matchers, you can construct an empty list [] of *matches* or *red flag hits*, and direct spaCy to cover the entire length of your agreement licence(s) based on word_count. This will read each pdf licence page-by-page, before appending them back together. The following code should work regardless of how many licences you have. 

    def extract_pdf_text(pdf_path):
    parts = []
    with pdfplumber.open(str(pdf_path)) as pdf:
        for page in pdf.pages:
            parts.append(page.extract_text() or "")
    return "\n".join(parts)

    pdf_path = pdfs[0]
    text = extract_pdf_text(pdf_path)
    doc = nlp(text)

    matches = []

    for match_id, start, end in phrase_matcher(doc):
        span = doc[start:end]
        matches.append((nlp.vocab.strings[match_id], span.text, span.sent.text, "phrase"))

    for match_id, start, end in token_matcher(doc):
        span = doc[start:end]
        matches.append((nlp.vocab.strings[match_id], span.text, span.sent.text, "pattern"))

As verification, you can print out the first ten matches to ensure the NLP process is working as intended, and covering the full extent of each pdf licence - 

    print("Testing:", pdf_path)
    print("Matches:", len(matches))
    matches[:10]

Like before, you can also silence the pdfplumber warning, as based on our initial test the package is capable of extracting pdf text, albeit with some minimal OCR errors (see discussion).

    warnings.filterwarnings("ignore", message="Could not get FontBBox from font descriptor.*")

### Step 6: Red Flag Exportation 

The following code establishes a clear .xlsx file structure, to manipulate red flag results within Excel. Not only does this offer you a more intuitive way to evaluate your results, with the following code adding a column for each AI risk (established through your dictionary set-up). Rows are also added for each hit and its associated sentence, so you can view each potential red flag in context. This code also retains our original folder structure for comparing red flags between: 'AI Agent', 'Lit Review' and 'Transcription' tools. Step 7 provides you with a use case for using such structured exports in Excel, through the simple conversion of listed red flags into pivot tables to record initial findings across all our 29 licences.

    rows = []
        for pdf_path in pdfs:
        folder = pdf_path.relative_to(ROOT).parts[0]
        text = extract_pdf_text(pdf_path)
        doc = nlp(text)

    for match_id, start, end in phrase_matcher(doc):
        span = doc[start:end]
        rows.append({
            "folder": folder,
            "file": str(pdf_path.relative_to(ROOT)),
            "rule": nlp.vocab.strings[match_id],
            "match_text": span.text,
            "sentence": span.sent.text,
            "method": "phrase",
        })

    for match_id, start, end in token_matcher(doc):
        span = doc[start:end]
        rows.append({
            "folder": folder,
            "file": str(pdf_path.relative_to(ROOT)),
            "rule": nlp.vocab.strings[match_id],
            "match_text": span.text,
            "sentence": span.sent.text,
            "method": "pattern",
        })

Again, silence the pdfplumber extraction warning, as we have verified its accuracy - 

    warnings.filterwarnings("ignore", message="Could not get FontBBox from font descriptor.*")

It is also best practice to rid the table of duplicates, although our dictionary structure avoids this through text normalisation - 

    df = df.drop_duplicates(subset=["file","rule","sentence","method"])

We can now display the results, the below shows the first five results from our Transkribus example, grouped by AI risk category (established through our constructed dictionary). This data frame also indicates what triggered the red flag, whether spaCy used the phrase or word token matcher, and the related sentence for further, qualitative review. 

    df = pd.DataFrame(matches)

    df.head() # displays the first five results

<div class="table-wrapper" markdown="block">

| category | match_text   | sentence                                                      | method |
|----------|--------------|---------------------------------------------------------------|--------|
| SECURITY | Personal Data | Individuals who do not meet the Minimum Age …                | phrase |
| SECURITY | third party   | Creating an account on behalf of a third party ...           | phrase |
| SECURITY | third party   | Creating an account on behalf of a third party...            | phrase |
| COST     | charge        | Transkribus eXpert is distributed ...                        | phrase |
| COST     | Subscription  | To use Transkribus, an active Subscription is ...            | phrase |

</div>

For further refinement, you can also use spaCy for noun detection, alongside the patterns established through our dictionary. 

These phrases, especially when attached to verb actions, can direct further - specialist - assessment of AI risk. In the below example taken from Transkribus, the noun *children* appears, which necessitates further review due to age having a huge bearing on [GDPR regulations](https://gdpr-info.eu). In this case, *children* appears in relation to *Trankribus Connect* and forbidding online posting that is 'illegal, obscene, abusive, threatening, defamatory, invasive of privacy, infringing on intellectual property rights, harmful to children, or otherwise objectionable', highlighting a level of robustness in platform precautions around data protection, opposed to risk. Despite, this result being a false positive, it was still worth additional review due to potential user harm and risk.

    noun_phrases = set()

    for chunk in doc.noun_chunks:
        noun_phrases.add(chunk.text.lower())

    for np in list(noun_phrases)[:20]:
        print(np)

    managed projects
    the contracting parties
    critical infrastructure
    the severity level
    the actual payment date
    extent
    their habitual residence
    a right
    children
    demands
    authorised personnel
    the agreement
    any responsibility
    the extent
    sufficiently high-quality existing pairs
    your published collection users
    electronic communications
    code parts
    our dedicated websites
    directors

---

With our red flag hits tabulated as a dataframe, you can now use openpyxl, downloaded earlier (either locally or through the Jupyter Notebook link) to export our .xlsx file. 

If exporting only one license, simply set a path, with a intuitive name and deploy openpyxl - 

     out_path = Path("red_flags_by_folder.xlsx")
     with pd.ExcelWriter(out_path, engine="openpyxl") 
     
     out_path

If using multiple licences, as with our corpus of 29 agreements, ensure that the export retains the folder structure, through the following export - 

     out_path = Path("red_flags_by_folder.xlsx")
     with pd.ExcelWriter(out_path, engine="openpyxl") as writer:
     for folder in sorted({p.relative_to(ROOT).parts[0] for p in pdfs}):
          sheet = folder[:29]
          sub = df[df["folder"] == folder].drop(columns=["folder"])
          sub.to_excel(writer, sheet_name=sheet, index=False)
   
     out_path


### Step 7: High-Level Red Flag Review

With Excel enabling flexible data analysis, we can begin to assess the percentage of certain red flag results across AI tool type. Of course, this should remain an initial guide, with some red flags being likely false positives, caused by AI providers offering reassurance around the risks categorised in our dictionary (see our Transkribus example from earlier). However, our rules-based approach should limit this to an extend. Therefore, this section provides you with a quantitative review of red flags, to complement our qualitative interpretation of NLP methods for AI licence terms and conitions extraction in the next section.

The below table displays the total percentages for each categorised risk, across our AI literature review folder, based on our dictionary construction. We can see that spaCy was potentially over-sensitive, returning 734 flag responses. Although this NLP result produces a manual inspection overhead for human reviewers, we anticipate users will utilise these flags as a guide, moving in and out of licence texts as problematic terms and conditions arise. Our NLP method, therefore, siphons down complicated legalistic text in a way that guides, instead of replaces, human inspection of AI risk.

For lit review AI, it appears that security concerns are most common (58.74%), followed by cost (13.08%). 

<div class="table-wrapper" markdown="block">

| Category | Count | % of Total |
|---|---:|---:|
| ACCESSIBILITY | 2 | 0.27% |
| AI_TRAINING | 48 | 6.54% |
| COPYRIGHT | 81 | 11.04% |
| COST | 96 | 13.08% |
| DATA_OWNERSHIP | 28 | 3.81% |
| DATA_RETENTION | 23 | 3.13% |
| LIABILITY | 25 | 3.41% |
| SECURITY | 431 | 58.72% |
| **Grand Total** | **734** |

</div>

Looking at our AI transcription tools, security again appears most prominent (42.26%), followed by cost (33.87%), suggesting that to a degree similar risk areas emerge across AI tool type.

<div class="table-wrapper" markdown="block">

| Category | Count | % of Total |
|---|---:|---:|
| ACCESSIBILITY | 1 | 0.32% |
| AI_TRAINING | 13 | 4.19% |
| COPYRIGHT | 33 | 10.65% |
| COST | 105 | 33.87% |
| DATA_OWNERSHIP | 7 | 2.26% |
| DATA_RETENTION | 18 | 5.81% |
| LIABILITY | 2 | 0.65% |
| SECURITY | 131 | 42.26% |
| **Grand Total** | **310** |

</div>

However, our AI agent folder breaks with such findings, with the risk of AI training the highest extracted flag category (49.12%), followed by security (21.05%). This is likely a result of AI agents requiring prompt engineering, with the need for direct user interaction.

<div class="table-wrapper" markdown="block">

| Category | Count | % of Total |
|---|---:|---:|
| AI_TRAINING | 56 | 49.12% |
| COPYRIGHT | 12 | 10.53% |
| COST | 5 | 4.39% |
| DATA_RETENTION | 11 | 9.65% |
| LIABILITY | 6 | 5.26% |
| SECURITY | 24 | 21.05% |
| **Grand Total** | **114** |

</div>

## Discussion: Human Translations of Extracted Red Flags

We have attempted to provide you with an NLP method for extracting problematic AI tool clauses, to aid institutional procurement workflows and research decision-makinng, whether undertaken by a solo librarian over a single licence or as a wider library initative across a wider corpus. Nonetheless, human-in-the-loop review is still essential for interpreting extracted red flags and the risks they may contain. As such, we include some human language translations, informed by our own professional perspectives, which help establish why certain extracted clauses are problematic, and indeed whether some actually constitute red flags. 

--- 

There are limitations to our method:

Our spaCy method could be improved upon through the bespoke use of OCR tools, to correct errors in PDF transcriptions pulled by pdfpumber. However, these errors were minimal and did not impact the overall review of extracted red flags, with four notable errors across the whole export. 

With spaCy relying on exact dictionary matches, our method proves overly sensitive, extracting more than 1,000 red flag hits - 115 for AI Agents (7 documents), 734 for Lit Review (19 documents), 310 for Transcription (5 documents). Of course, this means a full review of each and every red flag, across a corpus of documents, remains time consuming. Nonetheless, the disaggregated breakdown of where hits appear enables librarians and researchers to narrow in their licence interpretation. Therefore, our Excel export acts as a viewfinder. Dividing the number of hits by documents (n = 29), approx. 37 hits are recorded for each licence, making the use of such NLP pipelines more reasonable in the case of solo librarians on individual files.

Of course, the extraction of token phrases can easily lose contextual meaning from complex licenses. This is seen with false positive hits, where AI providers instead attempt to mollify anxities around AI training. 

--- 

Nonetheless, our spaCy method has clear advantages:

Although some clauses are surfaced multiple times, these are based on different rules, phrases and/or dictionary terms. This may add to the oversensitivity of our method, though legalistic clauses are complex and often have multiple rules applying. Therefore, we see this overlap of hits as a feature, which ensures that AI risk is assessed from multiple vantages. 

In other cases, our spaCy method signalled very real AI risks, with the structure of our Excel export revealing discrepencies between tool providers: 

Our 'Security' rule extracted instances of limited liability, where tool providers wave responsibility for any third party damages, including data loss or those caused by for profit behaviour: even if they have been advised of their possibilities ahead of time. Alongside this, our NLP method uncovered variable protections based on legal jurisdiction, with certain AI companies processing data in other countries as a means to circumvent more rigid data protection, as well as aggressively engaging in direct marketing campaigns wherever legal and easiest. Elsewhere, the revealing of protected or sensitive consumer data was firmly placed at the discretion of the user. Variability between tool providers was also seen in the case of responding to privacy policy requests, with some AI companies charging a fee to give access to users' own personal data, as well as data processing: some tools stated that no customer data was used in training their Large Language Models, whereas others appeared much vaguer, due to the complex 'nature of processing'. 

## Local Application

In providing several assets (code walkthroughs and dictionaries), we hope our NLP method is extensible for your own research and extraction of red flag terms and conditions. You can either populate our blank dictionary with terms and phrases, or add to / strip down the populated version, in turn tailoring spaCy's application to your own research context. Grouping terms and phrases into categorised themes is not necessary either; however, it does make for a cleaner and more structured Excel export.

For continued learning, see other *Programming Historian* applications of spaCy. Kane’s [^16] lesson applies a similar NLP workflow for corpus linguistic annotation and interpretation, while Goodale [^17] uses spaCy and a similar stopword approach for interpreting Russian text. Away from *Programming Historian* and historical linguistic data, spaCy has been used to review clinical notes to improve patient outcomes [^30], as well as to consensually extract payment data within financial institutions, to reduce the risk of money laundering [^31].

With this lesson extracting natural language clauses as an intuitive structured dataset, we also hope to unlock further research comparing AI licences between legal jurisdictions, as well as the prominence of certain red flags across geogrpahies. Our use of ESAC’s open registering of publishing licences will also enable us to map more traditional terms and conditions onto newer AI tool licences.

## Conclusion

This lesson has provided you with an NLP workflow using spaCy as an open, reproducible and extensible method for extracting problematic AI tool licence clauses. In engaging with the ENABLAR cohort, this lesson is informed by our daily practitioner roles, and cross-disciplinary expertise, in digital research, copyright and licensing, and library services. Though short of legal advice, our situated workflow enables you to better contend with AI’s research implications, from an IP and data protection standing-point. In doing so, we hope to have filled a certain confidence gap, while advocating for critical AI use, risk mitigation, and institutional-researcher dialogue.

## Endnotes

[^1]: [O'Sullivan, James. "Generative AI in Higher Education Teaching and Learning", *Higher Education Teaching and Learning*, accessed June 10, 2026.](https://www.teachingandlearning.ie/2025/03/24/generative-ai-in-higher-education-teaching-and-learning-james-osullivan/).

[^2]: [Jaillant, Lise, Kidd, Matthew, and Zhao, Lingjia. *Sifting the Digital Heap: A scoping study of AI for government archives – access, backlogs, and responsible practice*. Loughborough University Report, 2026, pp. 31.](https://hdl.handle.net/2134/31629595.v1)

[^3]: Brown, Edwin, Donnelly, Shaun. "LLMs in the Wild: An introduction to Agentic Systems". *University of Sheffield Centre for Machine Intelligence, Town Hall Event*, March, 11, 2026.

[^4]: [Dickson, Jim, Marshall, Mack. "Trained to stop learning: How students are experiencing assessment and learning in an age of AI", Wonkhe, published March, 23, 2026,](https://wonkhe.com/blogs/trained-to-stop-learning-how-students-are-experiencing-assessment-and-learning-in-an-age-of-ai/)/

[^5]: [University of Birmingham. "AI tools licensing review guidance", accessed June 10, 2026.](https://intranet.birmingham.ac.uk/student/libraries/copyright/researchers/ai-tools-licensing-review-guidance.aspx)

[^6]: [Krantz, Tom, Jonker, Alexandra, and McGrath, Amanda. "What is shadow AI?", *IBM*, accessed June 1, 2026.](https://www.ibm.com/think/topics/shadow-ai)

[^7]: [Cox, Andrew. *The impact of AI, machine learning, automation and robotics on the information profession*. CILIP Report, 2026.](https://www.cilip.org.uk/page/researchreport)

[^8]: [Rungkaew, Titirut. "Students’ perception of google classroom and microsoft teams using TAM-based constructs." *AU E-Journal of Interdisciplinary Research* 10, no. 3 (2025): 209-217.](https://doi.org/10.14456/au-ejir.2025.54)

[^9]: [Stryker, Cole, Holdsworth, Jim. "What is NLP (natural language processing)?", *IBM*, accessed June 1, 2026.](https://www.ibm.com/think/topics/natural-language-processing)

[^10]: [Colavizza, Giovanni, and Lise Jaillant. "AI Preparedness Guidelines for Archivists", Archives and Records Association (UK & Ireland), February 2026.](https://www.archives.org.uk/ai-preparedness-guidelines-for-archivists)

[^11]: [JiSC. "Guide to the Model Licence (FAQs)", accessed May 22, 2026.](https://subscriptionsmanager.jisc.ac.uk/about/guide-to-model-licence)

[^12]: [Holt, Ilkay, and Kefalea, Revekka. “Risk Management Toolkit for Open GLAM”, published December 23, 2025.](https://zenodo.org/records/18928812)

[^13]: [UK Government. "Guidance - Exceptions to copyright", last updated January 4, 2021.](https://www.gov.uk/guidance/exceptions-to-copyright#fair-dealing)

[^14]: [Gooding, Paul, Nockels, Joe, and Terras, Melissa. "The adoption of handwritten text recognition at the National Library of Scotland". In *Navigating AI for Cultural Heritage Organisations*, edited by Lisa Jaillant, Claire Warwick, Paul Gooding, Katherine Aske, Glen Layne-Worthey, and J. Stephen Downie. UCL Press, 2025.](https://doi.org/10.14324/111.9781800088375) 

[^15]: [Lundborg, Einarsson. "Dazzled by the Private Sector". MA diss, University of Boras, 2024.](https://www.diva-portal.org/smash/get/diva2:1879530/FULLTEXT01.pdf)

[^16]: [Kane, Megan S. "Corpus Analysis with spaCy", *Programming Historian*, published November 2, 2023.](https://programminghistorian.org/en/lessons/corpus-analysis-with-spacy)

[^17]: [Goodale, Ian. "Analysing Multilingual French and Russian Text using NLTK, spaCy, and Stanza", *Programming Historian*, published November 13, 2024.](https://programminghistorian.org/en/lessons/analyzing-multilingual-text-nltk-spacy-stanza)

[^18]: [Khan, Fareed. "Beginner Guide of spaCy", *Medium*, published September 12, 2022.](beginner-guide-of-spacy-8fb363330077)

[^19]: [Potter, Abigail. "Introducing the LC Labs Artificial Intelligence Planning Framework", *Library of Congress Blog*, published November 15, 2023.](https://blogs.loc.gov/thesignal/2023/11/introducing-the-lc-labs-artificial-intelligence-planning-framework)

[^20]: [Gribomont, Isabelle. "OCR with Google Vision API and Tesseract", *Programming Historian*, published March 31, 2023.](https://programminghistorian.org/en/lessons/ocr-with-google-vision-and-tesseract)

[^21]: [Nockels, Joe, Gooding, Paul, and Terras, Melissa. "The implications of handwritten text recognition for accessing the past at scale", *Journal of Documentation* 80, no. 7 (2024): 148–167.](https://doi.org/10.1108/JD-09-2023-0183)

[^22]: [NasuhcaN. "Natural Language Processing (NLP): A Comprehensive Guide", *Medium*, published October 23, 2025.](https://medium.com/@nasuhcanturker/natural-language-processing-nlp-a-comprehensive-guide-477984ebd873)

[^23]: [Nandini P. "NLP with spaCy: A Comprehensive Guide", *Medium*, published July 20, 2024.](https://medium.com/@pnandhiniofficial/nlp-with-spacy-a-comprehensive-guide-5c3f1bccdb0a)

[^24]: [McGregor, Nora. "AI & Machine Learning in Libraries", *LIBER Digital Scholarship & Data Science Topic Guides*, last modified May 13, 2025.](https://libereurope.github.io/ds-topic-guides/ai-ml.html)

[^25]: Robinson, David. *Voices in the Code: A Story about People, Their Values, and the Algorithm They Made*. New York: 2022.

[^26]: [LexisNexus. “Indemnity definition”, published 2026.](https://www.lexisnexis.co.uk/legal/glossary/indemnity)

[^27]: [LexisNexus. “Warranty definition”, published 2026.](https://www.lexisnexis.co.uk/legal/glossary/warranty)

[^28]: [Erdelyi, Olivia J., and Erdelyi, Gabor. "The AI Liability Puzzle and A Fund-Based Work-Around". 2020.](https://doi.org/10.48550/arXiv.1911.08005)

[^29]: [Havens, Lucy, Terras, Melissa, Bach, Benjamin, and Alex, Beatrice. "Uncertainty and Inclusivity in Gender Bias Annotation: An Annotation Taxonomy and Annotated Datasets of British English Text". In *Proceedings of the 4th Workshop on Gender Bias in Natural Language Processing (GeBNLP), Seattle, Washington. Association for Computational Linguistics*, 2022.](https://aclanthology.org/2022.gebnlp-1.4/)

[^30]: [Schmidt, Linea, Ibing, Susanne, Borchert, Florian, et al. "Automating clinical phenotyping using natural language processing". *Communications Medicine* 6, no. 77 (2026).](https://doi.org/10.1038/s43856-025-01337-0)

[^31]: [Nayak, Srikumar. "Named Entity Recognition for Payment Data Using NLP". 2026.](https://doi.org/10.48550/arXiv.2602.14009)

Joe Nockels is a personal READ-COOP member, the body who maintain and develop Transkribus - included within our constructed dataset of AI Terms and Conditions. The University of Birmingham, where Fenlon is based, is an institutional member of the READ-COOP.
