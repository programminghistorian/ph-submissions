---
title: Web archiving with Brwosertrix
collection: lessons
layout: lesson
slug: web-archiving-with-browsertrix.md
date: "2022-10-11"
authors:
- Helena Jaskov
- Valérie Schafer
- Frédéric Clavert
- Quinn Dombrowski
reviewers:
editors:
- Alex Wermer-Colan
translator:
review-ticket: 
difficulty:
activity: 
topics:
abstract: 
---

{% include toc.html %}

## Lesson Goals
This lesson aims to teach you how to crawl and preserve a complex and interactive website with high-fidelity. This usually implies to make sure to capture not only some texts or a set of documents, but also the website's images, videos, animations, etc. as well as content from subpages with working links. This approach aims to create a copy of the targeted website that allows you to re-experience the archived website as close as possible to the original.

This focus on high-fidelity suggests that if the faithful preservation of a website in its entirety is not your number one priority, then other web crawlers might be more suitable for your project: (http://programminghistorian.org/en/lessons/automated-downloading-with-wget)

And likewise, if you are only interested in very specific data from a website (only text or only the images), then web scraping might be another option for you. (It is a retired lesson, but nothing else comes to mind: https://programminghistorian.org/en/lessons/retired/intro-to-beautiful-soup)

If you are wondering why anyone should bother to archive websites in the first place, check out this section below: “Why should web content be archived anyway?”

## Lesson Context
This lesson is based on a tutorial that was created in the wake of the Russian invasion in Ukraine to provide a guide to volunteers of the SUCHO initiative to safe and preserve Ukrainian digital heritage.

### What is SUCHO?
SUCHO (Saving Ukrainian Cultural Heritage Online) is an initiative of 1,300+ international volunteers who are collaborating online to safeguard Ukrainian cultural heritage. Since the start of the invasion, SUCHO has web-archived more than 5,000 websites and 50TB of data of Ukrainian cultural institutions, to prevent these websites from going offline. The websites range from national archives to local museums, from 3D tours of churches to children’s art centers.

### Why use Browsertrix?
The founders of SUCHO have decided to use the browser-based crawler [Browsertrix](https://github.com/webrecorder/browsertrix-crawler#readme) developed by the Webrecorder team to archive Ukrainian digital heritage. There were several reasons for that choice. Among [other available crawlers](https://github.com/ArchiveBox/ArchiveBox/wiki/Web-Archiving-Community#other-archivebox-alternatives) at the time, Browsertrix was considered to offer the highest fidelity, as well as being capable of flawlessly archiving YouTube, Twitter, Facebook and other complex, JavaScript-heavy Single Page Apps. Although SUCHO was not concerned with capturing social media, the capacity to capture complex sites was crucial. Modern websites of cultural heritage institutions (museums, libraries etc.), which SUCHO was primarily targeting, tend to show most of the characteristics described above. They are interactive, media-heavy, and difficult to capture in their entirety with conventional web-crawlers. However, even Browsertrix has its limits. Some websites have content (e.g. interactive 3D models) that won’t capture well with Browsertrix. In these cases, SUCHO has relied on web scraping and other tools to capture those parts of the websites.

In combination with ReplayWeb.page, which offers an open platform to upload and replay the archived files captured with Browsertrix, this solution is especially suitable for grassroots web archiving, because it does not rely on institutional infrastructure.

Browsertrix uses the [WACZ](https://replayweb.page/docs/wacz-format) (pronounced “wac-zee”) file format, which is a further development of the conventional WARC file format. WACZ stands for Web Archive Collection Zipped. It has the advantage that it bundles raw web archive data (usually WARC files), indices, page lists and other metadata into a single ZIP file. This makes the archive searchable and portable for very large files. Another key benefit is the so-called “lazy-loading”, which entails that the actual raw content is loaded on demand when the user requests each page. With a WARC file, the entire contents must be loaded or indexed first to determine the contents of the web archive collection.

Browsertrix is distributed as a Docker container. There is currently no alternative to using Browsertrix besides the Docker installation. (See the Prerequisites section below for more details on the Docker set-up.)

## Why should web content be archived anyway?

While there have been debates over the right to memory versus the right to oblivion when it comes to digital traces, born-digital heritage is now widely recognised as key for current and future generations and as an endangered form of [digital heritage](https://unesdoc.unesco.org/ark:/48223/pf0000179529.page=2) which needs to be preserved. 

The first attempts to preserve the Web began back in the mid-1990s, thanks to libraries (in Australia for example) and the famous US non-profit [Internet Archive](https://archive.org) (“IA” for short), which was created in 1996. The Web was not as vast and complex as it is today, but there was already an awareness of its importance and of the fast rate of which websites and information published online were disappearing.  For instance, Ogden et al. underline that, in the field of academic publications and based on previous studies, 67% of web links become inaccessible after 4 years and 11% of links shared on Twitter are lost after only one year.[^1] A study conducted on Luxembourg’s web archive revealed that 21 626 domains related to websites created by companies, associations or individuals disappeared between 2016 and 2019.[^2] 

There are several reasons for this rapid disappearance: updates, deletion, issues of maintenance, etc. Content may be at risk for political reasons (war, censorship, etc.). Moreover, some web domains have disappeared, like the .yu which ceased to exist following the dissolution of Yugoslavia.[^3]

Web archiving is increasingly recognised as one of the missions and goals of national libraries. The legal deposit which applies to printed publications in many countries has often been extended to digital content. This trend towards heritagisation of the Web has been stimulated by pioneering initiatives. While the  Internet Archive (1996)  and its [Wayback Machine](https://web.archive.org) (2001), founded by Brewster Kahle, is the most well known, initiatives launched  in the mid-1990s in Canada, Australia and Sweden are also worth mentioning.[^4] Since then, the number of web archiving initiatives has increased considerably.[^5] Many institutions that are preserving the Web are members of the [IIPC](https://netpreserveblog.wordpress.com) (International Internet Preservation Consortium) which acts as a platform to share experiences, tools, and values. 
Today web archiving is also initiated by other stakeholders: researchers themselves, taking advantage of APIs, tools developed by [Webrecorder](https://webrecorder.net/tools), etc.; communities like [DocNow](https://www.docnow.io), which aims to boost inclusiveness and preservation of social content at risk; and groups of scholars or individuals that want to react in the face of specific events or endangered heritage, like the initiatives to [preserve social media content during the 2015 terrorist attacks in France](https://borealisdata.ca/dataset.xhtml?persistentId=hdl:10864/10830) or [SUCHO](https://www.sucho.org), which was launched to preserve the cultural born-digital heritage of Ukraine following the Russian invasion. Moreover, institutions are increasingly open to bottom-up participation and may launch calls for contributions for special collections, in which they appeal to the public to nominate relevant URLs, like during the COVID crisis.

There are many different motivations and goals for web archiving. Internet Archive initially defined its goal as “universal access to knowledge”.[^6] Within institutions there is often a legal framework that helps define the scope and practices of web archivists. Web preservation is organised at different levels. Often, large crawls of entire national domains are performed once or twice a year to keep a record of a country’s whole “webosphere”. In addition, there is sometimes interest in creating special collections related to foreseen or unforeseen events (Olympic Games, social movements, elections, tornadoes, etc.) or topics of particular interest (e.g. in the UK, [a web archive collection related to the French in London](https://beta.webarchive.org.uk/en/ukwa/collection/309) or a [British stand-up comedy archive](https://beta.webarchive.org.uk/en/ukwa/collection/329)). Web archives are also seen as a testimony and a means of preserving a significant trace of social movements, such as the Arab Spring or the [Black Lives Matter movement](https://www.docnow.io/archivists-supporting-activists/). Web archives constitute source material for researchers wanting to tap into the vast volume of data available: since 1996, 742 billion web pages have been collected by the IA (as of 1 October 2022). Companies, cultural institutions and other stakeholders are keen to keep a record of their digital life, while web archives may also play a role in professions such as journalism, law, etc.[^7]

The diversity of stakeholders and initiatives launched has an impact on the entire landscape of web archiving. There are several deposits (SC1), methods of crawling and means of access to web archives, as well as a variety of formats of web archives and metadata. While the web archives of Internet Archive and [arqivo.pt](https://arquivo.pt) for Portugal are available online, many web archives preserved by libraries are only accessible within the walls of the institutions themselves.

Most of these institutions use the [Heritrix](https://github.com/internetarchive/heritrix3) robot, but there are other possibilities. Individuals may share their content ID on open repositories and some collections are also available on dedicated websites, like [The COVID Tracking Project](https://covidtracking.com). These many different approaches to web archiving raise issues of searchability, curation, documentation, repositories, interoperability and maintenance, and a cautious “digital hermeneutics” is being developed in order to avoid an illusion of exhaustiveness and to raise awareness of the choices and biases that are inherent to the collections. Web archivists and scholars also face many challenges related to legal frameworks, the use and reuse of web archives, and ethics.[^8]

## How can web content be archived?

Web archives are never a perfect mirror of the live web and the notion of [“reborn-digital heritage”](http://www.digitalhumanities.org/dhq/vol/10/3/000256/000256.html) can help point to the many technical operations and transformations that may occur during the process of creating a web archive.[^9] Although the tools and methods for archiving the Web have developed over time and have improved in efficiency, meaning that several kinds of formats (HTML, videos, images, PDF, etc.) can now be captured, preserving the Web is always a challenge that involves human and technical skills.

Heritrix, the Internet Archive's open-source crawler project, is key in the web archiving world. Web archivists also rely on shared standards and methods, mostly using WARC files:
“At a practical level, the WARC file format used by web archivists acts as a digital container of sorts for preserving both web content (e.g., HTML, CSS, images, audio/video, etc.) and critical metadata associated with how and when resources are collected. (...). Distinct from other types of scraped web data (...) WARC files ‘contain technical and provenance metadata about the collection and arrangement of [web] media so sites can be read and represented [...] like they were at the time of their collection’. The WARC file then provides the archival standard and the technical means for both ‘replaying’ web content through the browser and generating derivative data (e.g., link network graphs) when the original web resources are no longer accessible online”[^1].

There are other tools available to crawl and capture websites, like Browsertrix, which was selected by SUCHO, in large part for its quality when it comes to capturing JavaScript-heavy single-page apps (e.g. library image galleries, etc.). Some companies like Twitter also allow access to their data through APIs (for developers, researchers, etc.). 
A willingness to develop accessible tools has driven initiatives developed by the Webrecorder team which launched Browsertrix, while the [Archives Unleashed Toolkit](https://cc.au.dk/fileadmin/user_upload/WARCnet/Milligan_You_shouldn_t_Need_to_be.pdf) aims to lower the barriers to access and analyse web archives. Public engagement with web archives is increasing and the need for tools which can be easily understood and used by volunteers is key when launching initiatives that rely on new forms of engagement.[^10]

<!-- ## Some Notes on Webcrawling and Copyright Issues

(Content forthcoming from Quinn ...) -->

## Prerequisites

For this lesson, you will need to install Docker and to use the command line.

### What is Docker?
Docker is an open source tool that allows you to create and run software in packages that are called “containers”.
A Docker container basically packages up system configuration in a way that makes a software program easy to share and run on different computers and servers. Software technologies and libraries evolve very fast and applications usually require very specific versions of software components and very specific environments to function as intended. A Docker container ships an application with all the necessary functionalities and required dependencies as one package. This way, a user can easily recreate the computer environment which the software needs to run properly. Containers are created from “images” which specify their exact contents. Over a development process, a software can have multiple images that reflect version updates and changes to the software.

### Installing Docker
The first step is to download and install [Docker](https://docs.docker.com/get-docker/). That link has instructions and download information for Mac, Windows, and Linux.

For Macs: there are different links for Mac with Intel vs. Apple chip; most Macs have an Intel chip. For installation on Mac, you will need to OK security warnings confirming you intended to open and install the software, and you may also need to give Docker privileged access to install networking components.

For Windows: Installation should be straightforward. If you run into trouble with the next steps, try restarting your computer after installation is complete.
Once Docker is installed, as it loads you should see a sort of whale-with-flickering-boxes in your computer’s toolbar menu. This is visible on the top of the screen on Mac, bottom of the screen on Windows. You can minimize or close the Docker Desktop window, but you should still see a whale-with-boxes icon (a cetacean container ship).

### Launching the command line
Now that Docker is running, we can set up the web crawler from the command line.


For Macs: go to Applications > Utilities > Terminal.

For Windows: search for cmd, and the Command Prompt app should appear as the best match.

### Getting the Docker image for Browsertrix
To download and set up Browsertrix using Docker, in your command line, type or paste this:

```docker pull webrecorder/browsertrix-crawler```

Note: If this command throws an error, you might not have administrative permissions. Try the above command again, but put sudo at the front, so the command would be:

```sudo docker pull webrecorder/browsertrix-crawler```
Now that you’ve installed Docker and configured the Docker image, you shouldn’t need to redo these first setup steps again.

If you installed Browsertrix a while ago, you may want to update your version with the following command:

```docker pull webrecorder/browsertrix-crawler:latest```
This command will ensure that you download the latest image of the Browsertrix software.

## Picking a website (safety & hosting check) 
<!-- choose a specific example for PH here -->
To avoid downloading malware, the first thing you should do when you find a URL to crawl is run a security check by copying the link into this [security checker](https://sitecheck.sucuri.net/). See the security guidelines for more information on this process. Generally speaking, a “Medium” risk shouldn’t pose a threat to you if the security check verifies that no “malware” or “injected spam” is detectable on the site.

If the website's server location is relevant to your web-archiving project, you should also check where the sites are hosted and focus on sites of your target area using [Hosting Checker](https://hostingchecker.com) or [IP-Lookup](https://www.iplocation.net/ip-lookup). Just because a site shows it is hosted in San Francisco on Cloudflare doesn’t mean it’s not hosted Ukraine, just that Cloudflare’s CDN is serving the site through a reverse proxy cache.
Besides verifying its server location, you should double check the site is still live by loading the ‘Collection Url’ in your browser.

## Configuring the YAML file 
A YAML file is a plain-text file for storing configuration information about how a programming script will run. YAML files are very picky about spaces, how many, and where they’re located. Each time you conduct a crawl, you can edit a yaml file to configure the crawl for a website and its subdomains.
You can download an example `crawl-config.yaml` file [here](https://www.sucho.org/crawl-config.yaml), and modify it using a plain-text editor. (If you don’t have a plain-text editor already installed on your computer, download and install Atom for Mac or Windows, and use that to open and edit the example YAML file.)
The `crawl-config.yaml` file should look as follows (with `collection`, `url`, and `include` changed to match each website):

```
collection: "sgiaz-uamuseum-com"
workers: 8
saveState: always
seeds:
  - url: http://sgiaz.uamuseum.com/
    scopeType: "domain"
```
Here’s the fields you should modify each time:

- `collection:` this should be basically the URL that you crawl, but with hyphens instead of periods in the URL. So, for example, http://archangel.kiev.ua becomes `collection: archangel-kiev-ua`
- `url:` this is just the base URL in the SUCHO spreadsheet for the URL you’re crawling

Save the YAML file as crawl-config.yaml somewhere easy to navigate to on your computer – on a Mac, the Documents folder is a good one. You will need to be able to change your directory using the command line to where your crawl-config.yaml file is saved on your computer to run the Docker command from that directory when you crawl the site.

For examples of `crawl-config.yaml` files used for the SUCHO project, see the separate Github repository, [browsertrix-yaml-examples](https://github.com/sucho-archiving/browsertrix-yaml-examples). 

## Crawling the website
Open up the command line again, if you closed it before.

For Mac: this will by default put you in your home directory (i.e. /Users/your-user-name). If you saved your crawl-config.yaml in the Documents folder, type `cd Documents`, and your command line will put you in the Documents folder. (If you put it somewhere else, you can put in that path after the cd, e.g. cd Documents/some-subfolder/another-subfolder; `cd` stands for “change diroctory”).
Once you’re in the same location as your `crawl-config.yaml`, paste this command into the Mac terminal and press enter to start the crawling:
```
docker run -v $PWD/crawl-config.yaml:/app/crawl-config.yaml -v $PWD/crawls:/crawls/ webrecorder/browsertrix-crawler crawl --config /app/crawl-config.yaml --generateWACZ
```

For Windows: after navigating to the right directory in the command prompt using cd, type the following command:
```
docker run -v %cd%/crawl-config.yaml:/app/crawl-config.yaml -v %cd%/crawls:/crawls/ webrecorder/browsertrix-crawler crawl --config /app/crawl-config.yaml --generateWACZ
```
### Troubleshooting the crawl command
You may have to use ‘sudo’ at the start of this command.
If you encounter errors relating to absolute paths, directories, or other errors, you may need to double check where you placed your config file, and how you are directing browsertrix to find it.
Some users on both Macs and Windows have had problems with `PWD` and `cd`. Try putting in the full system path to the `crawl-config.yaml`. To find the absolute path for your .yaml file, locate the `crawl-config.yaml` file and copy the directory address in the folder window. 

### Waiting and timeouts
Depending on the size of the site, the crawl could take anywhere from a couple minutes to 10+ hours. If you run out of space on your computer, or if browerstrix fails, someone with a server or access to the cluster can try running.
If webpages fail to load and timeout, you may need to manually set browsertrix to a longer timeout limit by adding to the end of your command `--timeout 300`. Timeouts are tricky, so if you can’t get it working, make a comment and move on to another open item.
Just because during a crawl you receive error messages relating to timeouts, it dooesn’t always mean the URL couldn’t be captured (it may have been a single resource on the page, such as an image from a non-existent third party site). View the final .wacz file in ReplayWeb to see what failed about any given page.
If the crawl gets interrupted, Browsertrix should be able pick up where it left off if you run a slightly different crawl command. 

### Exclusions for crawls that won’t finish
If you have a crawl that seems to not be finishing and appears to be stuck in a loop, you can interrupt it, and add an exclusion regular expression, and then continue! The following also works if your crawl gets interrupted unintentionally. It’s a bit cumbersome, but you can:
1. Interrupt the crawl with ctrl+c (except probably windows)
2. This should interrupt the crawl and save the state to a yaml file and it should print “Saving crawl state to: /crawls/collections…”
3. Open that yaml file in a text editor ./crawls/collections/…
4. Add an `exclude: <regex>` field, can be at the beginning in the root of the yaml file. See below for examples of how to set up the regex.
5. Restart the crawl by running it with `--config /crawls/collections/...` pointing to the edited yaml file (it’ll be in the crawls volume so will be accessible from /crawls)
6. The restarted crawl will apply the new exclusion rules to the crawl and filter out any urls in the crawl state, so hopefully now your crawl can finish. You can do this as many times as needed to update the exclusion rules.

Note: To interrupt a crawl in Windows, if ctrl+C doesn’t work, try ctrl+Break may work, or try docker ps and then docker kill -s SIGINT `<container ID>`.

Exclusion examples and tips

- To exclude everything that comes after /directory/ (e.g. /`directory/thing1`, `directory/thing2`), you can use: `https?://www.site.ua/directory/.*`
- If you have a list of paths you want to exclude you can add one regex per path, or you can combine them into one regex; the former is likely to be cleaner, easier to follow, and less error-prone, e.g.:

```
- url: https://example.site.com
    scopeType: domain
    exclude:
      - https?://example.site.com/path1/.*
      - https?://example.site.com/path2/.*
      - https?://example.site.com/path3/.*`
```

## Uploading the WACZ file to ReplayWeb.Page

The directory that has your `crawl-config.yaml` file will generate a crawls directory the first time you run the command to crawl a site. To find the WACZ file containing the archive of the website, open the `crawls` folder, then the `collections` folder. Inside `collections`, you should see a folder for each collection you’ve crawled. Inside the collection folder is a .wacz file.

Verify the website was captured by uploading the .wacz file to the Webrecorder’s [ReplayWeb.Page](https://replayweb.page/). Once the archival file is loaded into ReplayWeb.page, it is served locally on your machine, and you can navigate the website. Focus on verifying that the main subcomponents of the site were saved, especially pages listed in the navbar. Many links on the site may be external to the domain you preserved.

### ENDNOTES

[^1]: Jessica Ogden et al., How to Design Web Archives Research (1 Oliver’s Yard, 55 City Road, London EC1Y 1SP United Kingdom: SAGE Publications, Ltd., 2022), https://doi.org/10.4135/9781529610147.

[^2]: Ben Els, Yves Maurer, and Valerie Schafer, “Les archives du Web luxembourgeois. Histoire, enjeux et perspectives,” Hemecht: Zeitschrift für Luxemburger Geschichte 73 (July 2, 2021), https://orbilu.uni.lu/handle/10993/47601.

[^3]: Anat Ben-David, “What Does the Web Remember of Its Deleted Past? An Archival Reconstruction of the Former Yugoslav Top-Level Domain,” New Media & Society 18, no. 7 (2016): 1103–19, https://doi.org/10.1177/1461444816643790.

[^4]: For the Canadian and Australian case, see: Kieran Hegarty, “The Invention of the Archived Web: Tracing the Influence of Library Frameworks on Web Archiving Infrastructure,” Internet Histories: Digital Technology, Culture and Society, 2022, https://doi.org/https://doi.org/10.1080/24701475.2022.2103988.

[^5]: Daniel Gomes, João Miranda, and Miguel Costa, “A Survey on Web Archiving Initiatives,” in Research and Advanced Technology for Digital Libraries, ed. Stefan Gradmann et al., vol. 6966 (Berlin, Heidelberg: Springer Berlin Heidelberg, 2011), 408–20, https://doi.org/10.1007/978-3-642-24469-8_41.

[^6]: Brewster Kahle, “Universal Access to All Knowledge,” The American Archivist 70, no. 1 (2007): 23–31, https://doi.org/10.17723/aarc.70.1.u114006770252845.

[^7]: Sharon Healy, Katharina Schmid, and Robert Jansma, “Skills, Tools, and Knowledge Ecologies in Web Archive Research,” n.d., 213.

[^8]: Nicholas Taylor, “Digital Library Blog,” Stanford Libraries website, Questions of Ethics at Web Archives 2015 (blog), 2015, https://library.stanford.edu/blogs/digital-library-blog/2015/12/questions-ethics-web-archives-2015 and Jimmy Lin et al., “We Could, but Should We? Ethical Considerations for Providing Access to GeoCities and Other Historical Digital Collections,” in Proceedings of the 2020 Conference on Human Information Interaction and Retrieval, CHIIR ’20 (New York, NY, USA: Association for Computing Machinery, 2020), 135–44, https://doi.org/10.1145/3343413.3377980.

[^9]: For some reflections on the fundamental difference between the web archive and the live web, see: Niels Brügger, The Archived Web: Doing History in the Digital Age (The MIT Press, 2018), https://doi.org/10.7551/mitpress/10726.001.0001 and Francesca Musiani et al., Qu’est-ce qu’une archive du web ? (OpenEdition Press, 2019), https://doi.org/10.4000/books.oep.8713 (in French).

[^10]: Valérie Schafer and Jane Winters, “The Values of Web Archives,” International Journal of Digital Humanities 2, no. 1 (November 1, 2021): 129–44, https://doi.org/10.1007/s42803-021-00037-0.
