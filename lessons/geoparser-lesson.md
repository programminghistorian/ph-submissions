---
title: Geoparsing Text with the Edinburgh Geoparser
authors:
- Beatrice Alex
date: 2016-06-06
reviewers: Ian Milligan
layout: lesson
---

# Introduction

This is a lesson on how to use the [Edinburgh Geoparser](https://www.ltg.ed.ac.uk/software/geoparser/).  The Geoparser allows you to process a piece of text and extract and geo-tag the locations contained within it, for example to be able to map them.

The Geoparser works best on running text, as it considers locations in context for disambiguation. For example, if you would like to get a sense of the place names mentioned in a piece of text, the Geoparser can be used to identify terms in a document that are likely to refer to place names.  It will then provide its best guess as to where those places are.

In December 2015, the Edinburgh Geoparser was released under the University of Edinburgh’s GPL license to be used by other researchers in the field of text mining as well as other scholars who are interested in geoparsing text. More information on its documentation, our publications about it and how to download it can be found [here](https://www.ltg.ed.ac.uk/software/geoparser/).

A simple online demo of the vanilla Edinburgh Geoparser can be tried out [here](http://jekyll.inf.ed.ac.uk/geoparser.html). It provides only the visual interface to the Geoparser output after uploading a text file and selecting a gazetteer.  The demo is otherwise not configurable and should only be used to try out small examples and not for geoparsing a large number of files.

The following lesson explains how the Edinburgh Geoparser works under the hood and contains information on:

* Prerequisites and terminology
*	Downloading and setting up the Edinbugh Geoparser,
*	Geoparsing a text file,
*	Other useful options for running the Geoparser,
*	Geoparsing multiple text files, and
*	Extracting geo-resolution output to TSV.

### Prerequisites and Terminology
This lesson requires users to be familiar with the command line.  If not then you should follow the lesson [Introduction to the Bash Command Line](https://programminghistorian.org/lessons/intro-to-bash) first.

The Geoparser works on MacOSX or Linux but is not supported for Windows.  The following lesson provides command line instructions for MacOSX users and equivalent commands for Linux users (only if different to the Mac versions).

The terms geoparsing, georeferencing and geotagging are used interchangeably in this lesson and refer to the entire process of identifying place names in text (place name recognition) and disambiguating them by assigning their most likely latitude/longitude pairs (geo-resolution).

### Downloading and Setting up the Geoparser

The current Edinburgh Geoparser download can be found here:
https://www.ltg.ed.ac.uk/software/geoparser/

Go to the Download section and click on The Edinburgh Geoparser link.  All you need to do then is accept the license, fill in some personal details, so we get an idea of who uses the Geoparser and then press **Download**.  A compressed file called `geoparser-march2016-2.tar.gz` will be downloaded to your Download directory or to wherever you specified the download to go.  Note that this file name may change as we release new versions of the tool.  

Some machines will automatically decompress the .gz file and create the directory `geoparser-v1.1`.  If this happens, and you see the `geoparser-v1.1` directory appear, move this new directory to wherever you want it to be installed and go to step 2.  If this does not happen, and your machine does not decompress the `.tar.gz` file and create a new directory automatically, follow steps 1 first.  (Note that version 1.1 is the current release but this number will change in future.)

1\. Move (`mv`) the `.tar.gz` file to the directory where you want to install the Geoparser.  In this case, I'd like the Geoparser to be installed in my `Software` directory inside the `Documents` directory.  If you don’t have a Software directory, create it first:

    mkdir ~/Documents/Software

Then type:

    mv ~/Downloads/geoparser-march2016.tar.gz ~/Documents/Software/

For this lesson we assume that the geoparser is now located inside the `~/Documents/Software` directory.  You may however want to adjust these commands by specifying the place where the Geoparser was downloaded to and a different directory you’d like to install it in. For example if you'd like to create a new directory called `geoparsing` in your home directory and put the Geoparser there, then you would type:

    mkdir ~/geoparsing
    mv ~/Downloads/geoparser-march2016.tar.gz ~/geoparsing/

2\. Next, you need to change to the directory containing the `geoparser-march2016.tar.gz` file so that the following command is local to that directory and you do not have to specify the entire path leading to it.  To do that you use the command `cd` (change directory), e.g.: 

    cd ~/Documents/Software/

3\. Run the following command on the command line to decompress the download:

    tar -xvf geoparser-march2016.tar.gz

You should see a long list of files appear on screen that are part of the distribution.  The `Software` directory will now contain a new directory called `geoparser-v1.1`.  It contains:

* `README:` a file with basic instructions for how to run the Geoparser
* `bin:` a set of executables for different operating systems. We provide executables for Linux (x86_64) and MacOSX.
* `in:` a directory with example input files
* `lib:` a set of libraries required for various processing steps
* `out:` a directory with example output files
* `resolve:` a directory containing programs required for geo-resolution
* `scripts:` a directory with a set of scripts to run the Geoparser

You can list (`ls`) and check its content by typing:

    ls ./geoparser-v1.1

Congratulations! You have successfully downloaded and set up the Geoparser, and you can now begin geo-parsing.

### Geoparsing A Text File

In this section you will learn how to geo-parse a simple text file.  Use the `cd` command to go the geoparser’s script directory:

    cd ./geoparser-v1.1/scripts

and try out one of the examples we provide as part of the distribution by running the following two commands:

    cat ../in/172172.txt | ./run -t plain -g geonames -o ../out 172172


For those not so familiar with working on the command line, let's look at the syntax used here.  Firstly, it is useful to know that the pipe character (`|`) is used to concatenate different commands.

In the previous example the first command is:

    cat ../in/172172.txt

The command `cat` prints a file (in this case the file is called `172172.txt` and it is located in the `in` directory of the geoparser) to your screen (or to *standard out* or short *stdout*).  The pipe character (`|`) is used to send the standard output of one command to the next command which can then use it as *standard in* (or short *stdin*).

The second command is:

    ./run -t plain -g geonames -o ../out 172172

It takes the stdout from the first command and runs the Geoparser with the following options (`-t`, `-g` and `-o`):

  * `-t` specifies the format of your input.  We recommend using text input (`plain`) for geoparsing.

  * `-g` specifies the gazetteer that should be queried.  In the above example, the gazetteer selected is [GeoNames](http://www.geonames.org/) (`geonames`), a large global gazetteer.  You can also specify other gazetteers, for example the DEEP gazetteer of historical placenames in England (`deep`) or the Pleiades+ gazetteer of ancient places (`plplus`).  For more information on the types of gazetteers offered as part of the distribution see the Geoparser documentation [here](http://groups.inf.ed.ac.uk/geoparser/documentation/v1.1/html/gaz.html).

  * `-o` specifies two pieces of information, the output directory (`../out`) which is located within the `geoparser-v1.1` directory and a prefix for the output file name (in this case `172172`, the same prefix as that of the input file name). Once the command is run and the Geoparser is finished, the result files appear in the output directory (`../out`) starting with the specified prefix.

When running the Geoparser, the specified text file is going through a series of processing steps which are combined into one pipeline.  It is first [tokenised](https://en.wikipedia.org/wiki/Lexical_analysis#Tokenization_), [part-of-speech-tagged](https://en.wikipedia.org/wiki/Part-of-speech_tagging) and [lemmatised](https://en.wikipedia.org/wiki/Lemmatisation). After these initial steps, [named entity recognition](https://en.wikipedia.org/wiki/Named-entity_recognition) is performed to identify location and person names as well as dates.  We have found that identifying location and person names in parallel helps to distinguish some ambiguous cases (like the string "Lewis" which could refer to a first name or the Scottish island) and where their context helps to distinguish between them.  The extracted locations are then resolved to latitude/longitude coordinate pairs.  The text is then further processed by identifying syntactic phrases (chunking) and temporal relations.  The latter two steps are not very relevant to this lesson and will therefore not be explained in detail.  Finally, visualisations are created to be able to inspect the file and the Geoparser output using a map interface in a browser.  For more information on each of the sub-components of the Geoparser, see our documentation [here](http://groups.inf.ed.ac.uk/geoparser/documentation/v1.1/html/pipeline.html).

To see the output files, go to the `out` directory:

    cd ../out

Now you can see all the files that the Geoparser has produced from the original `172172.txt` file.  Use the `ls` command and the `*` wildcard operator to see all the files beginning witht the prefix `172172`, like so:

    ls 172172*

    172172.display.html 172172.gazlist.html 172172.nertagged.xml
    172172.events.xml 172172.gazmap.html 172172.out.xml
    172172.gaz.xml 172172.geotagged.html 172172.timeline.html

The most relevant Geoparser output files contain the following information:

  * `172172.out.xml`: This is the XML file containing the text of the file in XML including all linguistic processing information specified in line with the text as well as the named entity recognition and the geo-resolution output.  In this file we only store the top-ranked geo-coordinates per resolved location.  If you are not familiar with XML, looking at this file might be quite daunting. I will explain below how to extract the geo-resolution information to TSV (tab separated values) format.
  * `172172.gaz.xml`: This is an XML file containing a ranked list of geo-resolution candidates for each extracted location mention.  The gazetteer (e.g. GeoNames) may contain more than one location per location mention and here we therefore list all candidates.  By default, the number of location candidates returned is capped at 20 if more candidates are present in the gazetteer.  We have found that increasing the number of candidates to be considered by the Geoparser does not increase performance considerably but increases processing time significantly (Alex et al., 2015).
  * `172172.display.html`: This is a visual display of the geo-parsed text file containing the text, a map and a list of geo-coordinates for each extracted location.

You can view `172172.display.html` in your browser by typing:

* On MacOSX: `open 172172.display.html`
* On Linux: 		`xdg-open 172172.display.html`

![Figure 1: Display of file 172172.display.html in a browser.](../images/geoparser_figure01.png "Figure 1: Display of file 172172.display.html in a browser.")
_Figure 1: Display of file 172172.display.html in a browser._

At the top of the browser window (see Figure 1) you will see a Google map interface with green and red pins.  At the bottom left is a window containing the text of the geo-parsed file with recognised locations highlighted in light green and at the bottom right there is a window containing the different geo-coordinate pairs for all the candidates considered per extracted location mention.  The ones in green are the top-ranked coordinate pairs which correspond to the green pins on the map.  The red pairs are lower ranked alternatives which correspond to the red pins on the map.

You can also specify the option `-top` on the command line. This creates some additional output files, most notably `172172.display-top.html` which only contains the top-ranked location candidates, so only the green geo-coordinate pairs and pins are displayed (see Figure 2).

    cat ../in/172172.txt | ./run -t plain -g geonames -top -o ../out 172172

![Figure 2: Display of file 172172.display-top.html in a browser.](../images/geoparser_figure02.png "Figure 2: Display of file 172172.display-top.html in a browser")
_Figure 2: Display of file 172172.display-top.html in a browser._

### Other Useful Options for running the Geoparser

#### Giving Preference to a Geographical Area

If you know that your text is about a particular geographical area you can instruct the Geoparser to give this area higher weighting during the geo-resolution step. For example, if you know that your data is mostly set in Canada then it may make sense to give candidate locations inside Canada higher preference.  By doing so the Geoparser will prefer places within the specified area but it will still consider locations outside it if other factors give them higher weighting.

A bounding area can be specified as a circle (`-l locality`) or a box (`-lb locality box`).  To specify a circular locality use the following command:

    -l lat long radius score

where:

*	`lat` and `long` are in decimal degrees (i.e. 57.5 for 57 degrees 30 mins)
*	`radius` is specified in km
*	`score` is a numeric weight assigned to locations within the area (else 0).

To specify a locality box use:

    -lb W N E S score

where

* `W`(est) `N`(orth) `E`(ast) `S`(outh) are decimal degrees
* `score` is the same as for option `-l`.

For example, a bounding box for Canada is `[W:-141.002701, N:83.110619, E:-52.620201, S:41.681019]` (see Figure 3).

![Figure 3: ](../images/geoparser_figure03.png#1 "Figure 3: Bounding box for Canada.")
_Figure 3: Bounding box for Canada._

To specify this bounding box using our previous example, go back to the scripts directory and run the following command:

    cat ../in/172172.txt | ./run -t plain -g geonames -lb -141.002701 83.110619 -52.620201 41.681019 2 -o ../out 172172 

Here, the `score` has been set to 2.  This gives a location within the bounding box twice as much weight as for example the population size of a location during geo-resolution.

![Figure 4: ](../images/geoparser_figure04.png#1 "Figure 4: Display of file 172172.display.html after geo-parsing with a specified bounding box.")
_Figure 4: Display of file 172172.display.html after geo-parsing with a specified bounding box._

In this case, all place names (including Washington, Wimbledon, Germany and France) were resolved to locations within the bounding box (see Figure 4).  The locality option should therefore be used with care and should ideally only be applied to documents where you are relatively certain that all or most locations appear within the specified area.

#### Specifying a Document Date

As well as identifying locations and person names within text, the Geoparser also contains a component which recognises temporal expressions (dates and times) in textual data and normalises them. Normalisation here means that the temporal expressions are enriched with additional information of when exactly they occurred, for example the exact calendar date the expression "last Friday" refers to.

In order to do this well, it is preferable to provide the Geoparser with the date of the document (if known). To try this out using our previous example, type the following command:

    cat ../in/172172.txt | ./run -t plain -g geonames -d 2010-08-10 -o ../out 172172 

* `-d` specifies the document date (`YEAR-MONTH-DATE`).  This option is optional.  It is used for normalisation (or grounding) of temporal expressions in the document, for example to compute which particular calendar date the string “Sunday” refers to.

The document date specified on the command line is stored in the XML output and all relative temporal expression will be interpreted with respect to it.  The document date (`docdate`) is stored in the meta section at the top of the XML output file.  Use the `head` command to list the first 5 lines of the output file where you can see it:

    head -n 5 ../out/172172.out.xml

    <?xml version="1.0" encoding="UTF-8"?>
    <document version="3">
    <meta>
    <attr name="docdate" id="docdate" year="2010" month="08" date="10" sdate="2010-08-10" day-number="733993" day="Tuesday" wdaynum="2">20100810</attr>
    <attr name="tokeniser_version" date="20151216"/></meta>

Using our example output file, the first recognised date string in the named  entity output is “Sunday” which appears in the sentence:

> "Rafael Nadal and Andy Murray are both through to the semifinals of the Rogers Cup in Toronto, where they will face each other for a place in Sunday's final."

Since the document date is Aug 8th 2010 which was a Tuesday, the Sunday referred to in this text is Aug 15th 2010.  The output of the correct temporal resolution for this example can be seen in the entity output in the standoff section of the `172172.out.xml` file:

    <ent date="15" month="08" year="2010" sdate="2010-08-15" day-number="733998" id="rb7" type="date" day="Sunday" wdaynum="7">
       <parts>
          <part ew="w204" sw="w204">Sunday</part>
       </parts>
    </ent>

Apart from the obvious `date`, `month`, `year` and `day` attributes:

*  `sdate` refers to the grounded date expressed as a string,
*  `day-number` refers to a unique day number where 1 corresponds to the 1st of January 1 AD, and
*  `wdaynum` refers to the week day number where 1 corresponds to Monday, 2 to Tuesday etc.

If the document date is not specified all temporal expressions will be interpreted relative to the date when the Geoparser is run, so that is today’s date.  While this setting does not affect the performance of the geo-resolution of place names in this release, one could imagine a possible extension where the document date affects the type of gazetteer used or the location name variants that should be considered as place names change over time.

#### Geoparsing Multiple Text Files

Now that you know how to geoparse one file, you may want to do the same thing for a set of documents all at once. You can download a simple shell script which geoparses multiple files [here](http://groups.inf.ed.ac.uk/geoparser/scripts/run-multiple-files.sh). Please refer to the [Geoparser workshop](http://homepages.inf.ed.ac.uk/balex/publications/geoparser-workshop.pdf) slides for more information on how to make this script executable, run and it and adapt it to your needs.

### Extracting Geo-Resolution Output to TSV

<center><img src="../images/geoparser_figure06.png"></center>
<br/>

Rather than dealing with an XML file, you might find it easier to work with the Geoparser output in a form such as tab-separated values (TSV) in order to inspect it in a spreadsheet or use it with an application such as QGIS or Google Maps/Google Earth for which there are already useful Programming Historian lessons available ([Installing QGIS 2.0 and Adding Layers](https://programminghistorian.org/lessons/qgis-layers) and [Intro to Google Maps and Google Earth](https://programminghistorian.org/lessons/googlemaps-googleearth)).

The Geoparser is distributed with a useful set of XML processing tools called [LT-XML2](https://www.ltg.ed.ac.uk/software/ltxml2/), authored by Richard Tobin, which can be used to extract the location entities in a Geoparser XML output file and to present them in tab-separated value (TSV) format. The executables for these tools are located in the `./geoparser/bin` directory, inside:

* `sys-i386-64`: if you are using a 64 bit Linux machine or
* `sys-i386-snow-leopard`: if you’re using MacOSX.  Don’t be confused by the name of this directory.  The executables should work for all MacOSX installations and not just on Snow Leopard.

All the executables starting with *lx* are LT-XML tools which work in combination with Xpath expressions to process or manipulate XML.  Going in detail over Xpath is beyond the scope of this lesson, so I will give clear examples to show how things work.  If you are interested in XML data manipulication you will find further detail in [Transforming Data for Reuse and Re-publication](https://programminghistorian.org/lessons/transforming-xml-with-xsl).

The best tool for printing XML content in a different format is `lxprintf`. Depending on your operating system, go to the `geoparser` directory and run `lxprintf` as follows:

On Linux use:

    ./bin/sys-i386-64/lxprintf -e "ent[@type='location']" "%s\t%s\t%s\t%s\t%s\n" "normalize-space(parts/part)" "@gazref" "@in-country" "@lat" "@long" < ./out/burtons.out.xml > ./out/burtons.out.tsv

and on MacOSX type:

    ./bin/sys-i386-snow-leopard/lxprintf -e "ent[@type='location']" "%s\t%s\t%s\t%s\t%s\n" "normalize-space(parts/part)" "@gazref" "@in-country" "@lat" "@long" < ./out/burtons.out.xml > ./out/burtons.out.tsv

The previous `lxprintf` command reads through a geoparsed XML output file, extracts all location entities identified by the Geoparser and presents them in TSV format. In the example above, the XML input file (containing the location entities) is `./out/burtons.out.xml`, and the TSV file is `./out/burtons.out.tsv`. The `<` symbol signifies "standard in" (or stdin) which tells the script to read in the file that follows it and the `>` symbol signifies standard out (or stdout) which specifies sending the output to the file that follows it.

The way this command works is that lxprintf looks for XML entities specified after the option `-e`.  In our case, we are looking for entities of type location (`"ent[@type='location’]”`), e.g. see:

```
<ent id="rb6" type="location" lat="43.70011" long="-79.4163" gazref="geonames:6167865" in-country="CA" feat-type="ppla" pop-size="4612191">
  <parts>
    <part ew="w148" sw="w148">Toronto</part>
  </parts>
</ent>
```

The next part of the command (`“%s\t%s\t%s\t%s\t%s\n”`) specifies how the output should be printed.  In this case, each specified string (`%s`) should be delimited by a tab (`\t`) character and the last string should be followed by a new line.  In this case, the following 5 strings for each location entity are specified:

*	`"normalize-space(parts)"` refers to the location mention recognised in the text. normalize() removes any unnecessary whitespace.
*	`"@gazref”` refers to the ID reference of the location in the gazetteer, if resolved.
*	`"@in-country”` refers to the country the location appears in, if this information was identified.
*	`"@lat”` refers to the latitude of the location, if this information was identified.
*	`"@long”` refers to the longitude of the location, if this information was identified.

The content of the TSV output file is therefore the following:

```
cat ./out/burtons.out.tsv

Wirral	geonames:7733088	GB	53.37616	-3.10501
Moreton	geonames:2642204	GB	53.4	-3.11667
Moreton	geonames:2642204	GB	53.4	-3.11667
Wirral borough	geonames:7733088	GB	53.37616	-3.10501
Wirral	geonames:7733088	GB	53.37616	-3.10501
Moreton	geonames:2642204	GB	53.4	-3.11667
Moreton	geonames:2642204	GB	53.4	-3.11667
```

### Frequently Asked Questions

**_How long does the text have to be for the Geoparser to work well?_**

The vanilla download works most accurately with running English text.  It works on individual sentences.  Geo-resolution accuracy increases however if the Geoparser has access to more context.  On the other hand, the Geoparser is not well suited to process large documents made up of several sub-texts, e.g. a journal issue made up of articles. In the latter case it would be better to split the document into the articles first.

**_Is it possible to exclude particular names from the output ahead of geo-resolution?_**

This is not possible to do when treating the Geoparser as a blackbox.  Currently we don’t specify a command line option with a list of names to exclude.  But this is something we will consider adding in future releases.

**_Is it possible to specify/vary the context size used when disambiguating locations?_**

This is not possible in the default download.  It considers all locations within the document when resolving a location in question.

**_Is it possible to geo-parse historical text using the Geoparser?_**

Yes.  However, when using the Geoparser in combination with the GeoNames gazetteer some historical place names will not be identified as they are missing from the gazetteer.  Also the Geoparser team can provide additional pre-processing to improve the quality of optical-character recognised output (e.g. to fix soft-hyphen splitting or to deal with the long “s” character).  Those scripts are not distributed with the standard distribution but you can contact us to get access to them.

**_Can the Geoparser output be visualised with another map interface (e.g. OpenStreetMap)_**

Yes.  Once you have extracted the geo-location information from the `*out.xml` file(s) you can use it as input into any of your favourite mapping tool.

### Credits and Citation
The Geoparser and its demo were developed over a number of years in a team effort by members of the [Edinburgh Language Technology Group](https://www.ltg.ed.ac.uk/), including Claire Grover, Richard Tobin, Kate Byrne and myself (Beatrice Alex).

If you found this lesson useful for your work, please cite it as:

    Beatrice Alex. 2017. Geoparsing Text with the Edinburgh Geoparser, The Programming Historian lesson, ADD URL HERE, 2017.

or cite one of our publications listed [here](https://www.ltg.ed.ac.uk/software/geoparser/).

The lesson is also available in workshop form.  If you're interested in running a workshop on how to use the Edinburgh Geoparser led by someone from our team, do get in touch.

Our team also welcomes suggestion for future collaboration to tailor the Geoparser to different needs.  Please get in touch if you have ideas about how we should develop the software.

In the past the Geoparser was used to identify place names for different purposes and in different types of data (e.g. Grover et al., 2010 and Alex et al., 2015).  For example, it was adapted to perform fine-grained geoparsing for literature set in Edinburgh ([Palimpsest](http://palimpsest.blogs.edina.ac.uk/)) presented in the [LitLong](http://litlong.org/) interface.  It was used to geoparse
* volumes of the Survey of English Place Names ([DEEP](http://englishplacenames.cerch.kcl.ac.uk/), see Grover and Tobin, 2014),
* large historical collections related to commodity trading in the 19th century British Empire ([Trading Consequences](http://tradingconsequences.blogs.edina.ac.uk/)) and
* 19th century British newspapers by [Prof. Ian Gregory](http://www.lancaster.ac.uk/staff/gregoryi/)’s group at Lancaster University.

The Geoparser was also adapted to the ancient world for the [Google Ancient Places](https://googleancientplaces.wordpress.com/) project (e.g. see Isaksen et al., 2011), with its [GapVis](http://nrabinowitz.github.io/gapvis/)  interface. More recently, the Geoparser was used to geoparse Twitter user profile locations (Alex et al, 2016).  

### References

Beatrice Alex, Clare Llewellyn, Claire Grover, Jon Oberlander and Richard Tobin (2016). Homing in on Twitter users: Evaluating an Enhanced Geoparser for User Profile Locations. 2016. In the Proceedings of the 10th Language Resources and Evaluation Conference (LREC), 23-28 May 2016. [[pdf](http://www.lrec-conf.org/proceedings/lrec2016/pdf/129_Paper.pdf)]       

Beatrice Alex, Kate Byrne, Claire Grover and Richard Tobin (2015). Adapting the Edinburgh Geoparser for Historical Georeferencing. International Journal for Humanities and Arts Computing, 9(1), pp. 15-35, March 2015.[[pdf](http://www.euppublishing.com/doi/pdfplus/10.3366/ijhac.2015.0136)]

Claire Grover and Richard Tobin (2014). A Gazetteer and Georeferencing for Historical English Documents. In Proceedings of LaTeCH 2014 at EACL 2014. Gothenburg, Sweden. [[pdf]](http://www.aclweb.org/anthology/W14-0617)

Claire Grover, Richard Tobin, Kate Byrne, Matthew Woollard, James Reid, Stuart Dunn, and Julian Ball (2010). Use of the Edinburgh Geoparser for georeferencing digitised historical collections. Philosophical Transactions of the Royal Society A. [[pdf](http://homepages.inf.ed.ac.uk/grover/papers/PTRS-A-2010-Grover-3875-89.pdf)]

Leif Isaksen, Elton Barker, Eric C. Kansa and Kate Byrne. 2011b. Googling Ancient Places. In Proceedings of Digital Humanities 2011 (DH2011), Stanford, CA, June 2011. [[html](http://dh2011abstracts.stanford.edu/xtf/view?docId=tei/ab-349.xml)]
