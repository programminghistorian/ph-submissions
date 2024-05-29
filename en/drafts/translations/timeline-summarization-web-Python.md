---
title: "Timeline Summarization for Large-scale Past-web Events with Python: the Case of Arquivo.pt"
slug: timeline-summarization-web-Python.md
original: sumarizacao-narrativas-web-python
layout: lesson
collection: lessons
date: 2023-04-29
translation_date: YYYY-MM-DD
authors:
- Ricardo Campos
- Daniel Gomes
reviewers:
- Daniela Major
- Salete Farias
editors:
- Josir Cardoso Gomes
translator:
- Ricardo Campos
- Daniel Gomes
translation-editor:
- Forename Surname
translation-reviewer:
- Forename Surname
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/XXX
difficulty: 2
activity: transforming
topics: [api, python, data-manipulation, web-archiving]
abstract: abstract: Nesta lição aprenderá a criar automaticamente resumos de eventos do passado a partir de conteúdos históricos arquivados da web. Em particular, demonstraremos como obter resultados relevantes ao combinar o uso da API do Arquivo.pt com a utilização do *Conta-me Histórias* permitindo, desta forma, processar um elevado volume de dados num curto espaço de tempo.
avatar_alt: Homem sentado ensinando várias crianças
lesson-partners: [Jisc, The National Archives]
partnership-url: /en/jisc-tna-partnership
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

Over the centuries, communication has evolved in parallel with the evolution of mankind. Communication, which used to take place through physical means, is now digital and has an online presence. The "fault" lies with the Web, which since the late 90s of the last century has become the main source of information and communication in the 21st century. However, about 80% of the information available on the web disappears or is changed within just 1 year. This leads to the loss of fundamental information to document the events of the digital age.

The shift to an internet-based communication paradigm has forced a profound change in the way published information is preserved. Web archives assume particular relevance by preserving information published online since the 1990s.

Despite recent advances in preserving archived information from the web, the problem of efficiently exploiting the historical heritage preserved by these archives remains unsolved due to the huge amounts of historical data archived over time and the lack of tools that can automatically process this volume of data. In this context, timelines (automatic temporal summarization systems) emerge as the ideal solution for the automatic production of summaries of events over time and for the analysis of the information published online that document them, as is the case of news.

In this tutorial, we intend to show how to explore [Arquivo.pt](https://arquivo.pt/?l=en), the Portuguese web-archive, and how to automatically create summaries of past events from historical web archived content. More specifically, we will demonstrate how to obtain relevant results by combining the use of the Arquivo.pt API with the use of [Conta-me Histórias (Tell me Stories)](https://contamehistorias.pt/arquivopt/?lang=en), a system that allows the automatic creation of temporal narratives about any news subject. To accomplish this goal we provide a jupyter notebook that users can use to interact with both tools.

In the first part of the tutorial, we will briefly present the search and access functions made available by Arquivo.pt. We will demonstrate how they can be used automatically by invoking the methods made available by the Arquivo.pt API (Application Programming Interface) through simple and practical examples. The automatic search for words in pages archived over time is the base service to rapidly develop innovative computer applications, which allow exploring and taking better advantage of the historical information preserved by Arquivo.pt, as is the case of the project Tell me Stories.

In the second part, we resort to Tell Me Stories to exemplify the process of temporal summarization of an event. In this sense, we will demonstrate how users can obtain summarized historical information on a given topic (Jorge Sampaio, former president of the republic) involving news from the past preserved by Arquivo.pt. Such an infrastructure allows users to access a set of historical information from web pages that most likely no longer exist in what we conventionally refer to as the current web.

### Video that summarizes this tutorial

???

## Requirements

Participation in this tutorial assumes basic programming knowledge (namely Python) as well as familiarity with python package installation (via [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)) and API consumption. The code execution presupposes the use of the anaconda jupyter. For an installation of this software we recommend the tutorial [Introductions to Jupyter Notebooks](https://programminghistorian.org/en/lessons/jupyter-notebooks#installing-jupyter-notebooks) or alternatively the use of [Google Colab](https://colab.research.google.com/).

## Learning Goals

At the end of this tutorial participants should be able to:
- extract relevant information from Arquivo.pt making use of the [Arquivo.pt API (Full-text & URL search)](https://github.com/arquivo/pwa-technologies/wiki/Arquivo.pt-API);
- know how to use the Tell Me Stories package (<https://github.com/LIAAD/TemporalSummarizationFramework>) in the context of automatic temporal summarization of events from large volumes of data preserved in the Portuguese Web Archive.

## Arquivo.pt: the Portuguese web-archive

The [Arquivo.pt](https://www.arquivo.pt) is a free public service provided by [Fundação para a Ciência e a Tecnologia I.P.](https://www.fct.pt), which allows anyone to search and access historical information preserved on the Web since the 1990s.

About 80% of the information available on the Web disappears or is changed within just 1 year. This leads to the loss of fundamental information for documenting events in the digital age.

[This video](https://www.youtube.com/embed/uuEiTiilyX0) briefly introduces Arquivo.pt.

### Contributions

Arquivo.pt contains billions of files collected over time from multi-lingual websites documenting national and international events.

The search services provided by Arquivo.pt include full text search, image search, version history listing, advanced search and [application programming interfaces (API)](https://arquivo.pt/api) that facilitate the development of value added applications by third parties.

Over the years, Arquivo.pt has been used as a resource to support research work in areas such as the Humanities or Social Sciences. Since 2018, [Arquivo.pt Awards](https://arquivo.pt/awards) annually distinguishes innovative works based on the historical information preserved by Arquivo.pt. Researchers and citizens have been made aware of the importance of preserving information published on the web through free training sessions, for example about the [use of APIs provided by Arquivo.pt](https://sobre.arquivo.pt/en/collaborate/training-courses-by-arquivo-pt/automatic-access-and-processing-of-preserved-web-data-module-c/).

All the software developed is available as [free open source projects](https://github.com/arquivo/) and has been documented through [technical and scientific articles since 2008](https://arquivo.pt/publications). In the course of its activities, Arquivo.pt generates data that may be useful to support new research work, such as the list of Portuguese Government Pages on social networks or political party websites. These [data are available in open access](https://arquivo.pt/dadosabertos).

[This video](https://www.youtube.com/embed/-sCjHMv5-KY?start=17) details the public services provided by Arquivo.pt. You can also access the [presentation slides](https://sobre.arquivo.pt/wp-content/uploads/ChallengesRecommendationsStartWebArchive.pdf) directly. To know more details about the services provided by the Arquivo.pt consult:
* [New ways of searching the past (module A)](https://sobre.arquivo.pt/en/collaborate/training-courses-by-arquivo-pt/arquivo-pt-an-innovative-service-at-your-disposal-module-a/) of the "Training about Web preservation" program of Arquivo.pt.

### How can I use Arquivo.pt?

The Arquivo.pt service is available from the following links:

* [User interfaces in Portuguese and English to access the search service for pages, images and version history](https://arquivo.pt/?l=en)
* [Information website about the Archive.pt](https://sobre.arquivo.pt/en/)
* [Documentation about the APIs of Arquivo.pt](https://arquivo.pt/api)

### How does the automatic search via API work?

Periodically, Arquivo.pt automatically collects and stores information published on the Web. Arquivo.pt's hardware infrastructure is housed in its own data center and managed by dedicated full-time staff.

The preservation workflow is performed through a large-scale distributed information system. The stored web information is automatically processed to perform research activities on Big Data through a distributed processing platform for unstructured data (Hadoop), e.g. for automatic web spam detection or to assess web accessibility for people with disabilities.

Search and access services via Application Programming Interfaces (APIs) allow researchers to take advantage of this processing infrastructure and the preserved historical data without having to address the complexity of the system that supports Arquivo.pt. [This video](https://www.youtube.com/embed/PPuauEwIwPE) presents the [Arquivo.pt API (Full-text & URL search)](https://github.com/arquivo/pwa-technologies/wiki/Arquivo.pt-API). Again, you can also access the [presentation slides](https://sobre.arquivo.pt/wp-content/uploads/API-Arquivopt-Webinar-CMLisboa.pdf) directly.

In this tutorial we will only cover the use of the Arquivo.pt API. However, Arquivo.pt also provides the following APIs:
* [Image Search API v1.1 (beta version)](https://github.com/arquivo/pwa-technologies/wiki/ImageSearch-API-v1.1-(beta))
* [CDX-server API (URL search): international standard](https://github.com/arquivo/pwa-technologies/wiki/URL-search:-CDX-server-API)
* [Memento API (URL search): international standard](https://github.com/arquivo/pwa-technologies/wiki/Memento--API)


For details about [all APIs provided by Arquivo.pt](https://arquivo.pt/api) see the training contents available at:
* [Module C: Automatic access and processing of preserved Web information through APIs](https://sobre.arquivo.pt/en/collaborate/training-courses-by-arquivo-pt/automatic-access-and-processing-of-preserved-web-data-module-c/) of the "Training about Web preservation" program of Arquivo.pt.

### Usage

Next, we will present examples of how to use the [Arquivo.pt API (Full-text & URL search)](https://github.com/arquivo/pwa-technologies/wiki/Arquivo.pt-API) to automatically search archived web pages between certain time intervals.

As a use case, we will perform searches about [Jorge Sampaio](https://en.wikipedia.org/wiki/Jorge_Sampaio) (1939-2021) who was Mayor of Lisbon (1990-1995) and President of the Portuguese Republic (1996-2006).

#### Definition of search parameters

The `query` parameter defines the words to search for: "Jorge Sampaio".

To make it easier to read the obtained search results we will limit them to a maximum of 5 through the `maxItems` parameter.

All available search parameters are defined in the [Request Parameters section of the Arquivo.pt API documentation](https://github.com/arquivo/pwa-technologies/wiki/Arquivo.pt-API#user-content-request-parameters).

```
import requests
query = "jorge sampaio"
maxItems = 5
payload = {'q': query,'maxItems': maxItems}
r = requests.get('http://arquivo.pt/textsearch', params=payload)
print("GET",r.url)
```

#### Browse the obtained results of Arquivo.pt

The following code shows the fetched search results in their original format (JSON):

```
import pprint
contentsJSon = r.json()
pprint.pprint(contentsJSon)
```

#### Summary of the results obtained

You can extract the following information for each result:
* title (`title` field);
* address to the archived content (`linkToArchive` field);
* date of archive (`tstamp` field)
* text extracted from page (`linkToExtractedText` field)

All the fields obtained as response to available searches are defined in the [Response fields of the Arquivo.pt API documentation](https://github.com/arquivo/pwa-technologies/wiki/Arquivo.pt-API#response-fields) section.

```
for item in contentsJSon["response_items"]:
    title = item["title"]
    url = item["linkToArchive"]
    time = item["tstamp"]

    print(title)
    print(url)
    print(time)

    page = requests.get(item["linkToExtractedText"])

    #note a existencia de decode para garantirmos que o conteudo devolvido pelo Arquivo.pt (no formato ISO-8859-1) e impresso no formato (UTF-8)
    content = page.content.decode('utf-8')
    print(content)
    print("\n")
```

#### Define search time interval

One of the assets of Arquivo.pt is to provide access to historical information published on the Web over time.

In the process of accessing information, users may define the temporal interval of the archived dates of the pages to be searched, by specifying the dates in the `from` and `to` API search parameters.

The dates specified must follow the format: year, month, day, hour, minute and second (aaaammdddhhmmss), for example the date March 9, 1996 would be represented by:
* 19960309000000

The following code performs a search for "Jorge Sampaio" over pages archived between March 1996 and March 2006, the period during which Jorge Sampaio was President of the Portuguese Republic.

```
query = "jorge sampaio"
maxItems = 5
fromDate = 19960309000000
toDate = 20060309000000
payload = {'q': query,'maxItems': maxItems, 'from': fromDate, 'to': toDate}
r = requests.get('http://arquivo.pt/textsearch', params=payload)
print("GET",r.url)
print("\n")

contentsJSon = r.json()
for item in contentsJSon["response_items"]:
    title = item["title"]
    url = item["linkToArchive"]
    time = item["tstamp"]

    print(title)
    print(url)
    print(time)

    page = requests.get(item["linkToExtractedText"])

    #note a existencia de decode para garantirmos que o conteudo devolvido pelo Arquivo.pt (no formato ISO-8859-1) e impresso no formato (UTF-8)
    content = page.content.decode('utf-8')
    print(content)
    print("\n")
```

#### Restrict search to a particular Web site

If users are only interested in the historical information published by a certain website, they can restrict the search by specifying the search parameter of the `siteSearch` API.

The following code performs a search for "Jorge Sampaio" on pages archived only from the website with the domain "www.presidenciarepublica.pt" between March 1996 and March 2006, and displays the results obtained.

```
query = "jorge sampaio"
maxItems = 5
fromDate = 19960309000000
toDate = 20060309000000
siteSearch = "www.presidenciarepublica.pt"
payload = {'q': query,'maxItems': maxItems, 'from': fromDate, 'to': toDate, 'siteSearch': siteSearch}
r = requests.get('http://arquivo.pt/textsearch', params=payload)
print("GET",r.url)
print("\n")

contentsJSon = r.json()
for item in contentsJSon["response_items"]:
    title = item["title"]
    url = item["linkToArchive"]
    time = item["tstamp"]
    print(title)
    print(url)
    print(time)
    page = requests.get(item["linkToExtractedText"])

    #note a existencia de decode para garantirmos que o conteudo devolvido pelo Arquivo.pt (no formato ISO-8859-1) e impresso no formato (UTF-8)
    content = page.content.decode('utf-8')
    print(content)
    print("\n")
```

#### Restrict search to a certain type of file

Besides web pages, Arquivo.pt also preserves other file formats commonly published online, such as PDF documents.

Users can define the type of file to be searched by specifying the API search parameter `type`.

The following code performs a search for "Jorge Sampaio":
* on files of type PDF
* archived only from the website with the domain "www.presidenciarepublica.pt"
* between March 1996 and March 2006

and presents the results obtained. When the user opens the address of the archived content provided by the `linkToArchive` response field, he will have access to the PDF file.

```
query = "jorge sampaio"
maxItems = 5
fromDate = 19960309000000
toDate = 20060309000000
siteSearch = "www.presidenciarepublica.pt"
fileType = "PDF"
payload = {'q': query,'maxItems': maxItems, 'from': fromDate, 'to': toDate, 'siteSearch': siteSearch, 'type': fileType}
r = requests.get('http://arquivo.pt/textsearch', params=payload)
print("GET",r.url)
print("\n")

contentsJSon = r.json()
for item in contentsJSon["response_items"]:
    title = item["title"]
    url = item["linkToArchive"]
    time = item["tstamp"]

    print(title)
    print(url)
    print(time)
```

## Conta-me Histórias (Tell Me Stories)

The project Tell Me Stories is a project developed by researchers from the Laboratory of Artificial Intelligence and Decision Support ([LIAAD](https://www.inesctec.pt/en/centres/liaad) - [INESCTEC](https://www.inesctec.pt/en/)) and affiliated to the institutions [University of Beira Interior](https://www.ubi.pt/),  [Center for Research in Intelligent Cities (CI2) of the Polytechnic of Tomar](http://www.ci2.ipt.pt/en/); [University of Porto](https://www.up.pt/portal/en/) and [University of Innsbruck](https://www.uibk.ac.at/index.html.en). The project aims to offer users the possibility to revisit topics from the past through a Google-type interface, which, given a query, returns a temporal summarization of the most relevant news preserved by Arquivo.pt about that topic. A promotional video of the project can be viewed [here](https://www.youtube.com/watch?v=fcPOsBCwyu8). 

### Contributions

In recent years the increasing availability of online content has posed new challenges to those who want to understand the story of a given event. More recently, phenomena such as media bias, fake news and filter bubbles have further compounded the already existing difficulties in providing transparent access to information. [Conta-me Histórias (Tell me Stories)](https://contamehistorias.pt/arquivopt/?lang=en) emerges in this context as an important contribution for all those who want to have quick access to a historical overview of a given event by automatically creating summarized narratives from a high volume of data collected in the past. Its availability in 2018, is an important contribution for students, journalists, politicians, researchers, etc, to generate knowledge and verify facts in a quick way, from the consultation of automatically generated timelines but also by resorting to the consultation of web pages typically non-existent in the more conventional web, the web of the present.

### Where can I find ContaMeHistorias.pt (Tell me Stories)?

The Tell Me Stories project is available since 2018 from the following pointers:
- [ContaMeHistorias.pt User interface in English](https://contamehistorias.pt/arquivopt/?lang=en)
- [Google Play Tell me Stories App](https://play.google.com/store/apps/details?id=com.app.projetofinal)
- [TemporalSummarizationFramework Python library](https://github.com/LIAAD/TemporalSummarizationFramework)
- [ContaMeHistorias.pt front-end](https://github.com/LIAAD/contamehistorias-ui)
- [ContaMeHistorias.pt back-end](https://github.com/LIAAD/contamehistorias-api)

More recently, in September 2021, Arquivo.pt started to offer the `Narrativa` feature by providing an additional button on its interface that redirects users to the Conta-me Histórias website so that from this website users can automatically create temporal narratives on any topic. The `Narrative` feature is the result of the collaboration between the `Conta-me Histórias` team, winner of the [Arquivo.pt 2018 Award](https://sobre.arquivo.pt/en/arquivo-pt-2018-award-winners/) and the Arquivo.pt team.

### How does it work?

When a user enters a set of words about a topic in the Arquivo.pt search box and clicks on the `Narrative` button, they are directed to the [Conta-me Histórias (Tell me Stories)](https://contamehistorias.pt/arquivopt/?lang=en) service, which in turn automatically analyzes news from 24 websites archived by Arquivo.pt over time and presents the user with a chronology of news related to the searched topic.

For example, if we search for `Jorge Sampaio` and press the `Narrative` button, we will be directed to [Conta-me Histórias (Tell me Stories)](https://contamehistorias.pt/arquivopt/?lang=en), where we will automatically get a narrative of archived news. In the following figure it is possible to observe the timeline and the set of identified relevant news.

[NOTE] Replace with screenshot with query "Jorge Sampaio" between for consistency.

[NOTE] This text sounded inconsistent with the original image: "in the period between 07/04/2016 and 17/11/2016. The last time period is for the year 2019 (typically one year shorter than the search date due to an embargo period defined by the Arquivo.pt team)." I uploaded a new image and cut the text. Please review.




