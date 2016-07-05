---
title: Geoparsing Text with the Edinburgh Geoparser
authors:
- Beatrice Alex
date: 2016-06-06
reviewers: Ian Milligan
layout: default
---

# Introduction

This is a lesson on how to use the [Edinburgh Geoparser](https://www.ltg.ed.ac.uk/software/geoparser/).  The Geoparser allows you to process a piece of text and extract and geo-tag the locations contained within it, for example to be able to map them.  It has been developed over a number of years by members of the [Edinburgh Language Technology Group](https://www.ltg.ed.ac.uk/), including Claire Grover, Richard Tobin, Kate Byrne and Beatrice Alex.

We optimised it for different domains as part of a series of research projects (e.g. Grover et al., 2010 and Alex et al., 2015).  For example, we adapted it to perform fine-grained geo-referencing for literature set in Edinburgh ([Palimpsest](http://palimpsest.blogs.edina.ac.uk/)) presented in the [LitLong](http://litlong.org/) interface, to geo-reference volumes of the Survey of English Place Names ([DEEP](http://englishplacenames.cerch.kcl.ac.uk/), see Grover and Tobin, 2014) or to geo-reference large historical collections related to commodity trading in the 19th century British Empire ([Trading Consequences](http://tradingconsequences.blogs.edina.ac.uk/)). We also adapted the Geoparser to the ancient world for the [Google Ancient Places](https://googleancientplaces.wordpress.com/) project (e.g. see Isaksen et al., 2011), with its [GapVis](http://nrabinowitz.github.io/gapvis/)  interface, and for [Hestia Phase 2](http://hestia.open.ac.uk/hestia-phase-2/) which developed the interface further for use in undergraduate study of classical literature in translation. More recently, we used the Geoparser to geo-reference Twitter user profile locations (Alex et al, 2016).  The Geoparser has also been applied in external research projects, including one of [Prof. Ian Gregory](http://www.lancaster.ac.uk/staff/gregoryi/)’s group at Lancaster University on geo-referencing 19th century newspapers.  The Geoparser works best on running text, as it considers locations in context for disambiguation.

In December 2015, the Edinburgh Geoparser was released under the University of Edinburgh’s GPL license to be used by other researchers in the field of text mining as well as scholars in the humanities and social sciences who would like to geoparse text. More information on the Edinburgh Geoparser, its full documentation, our publications about it and how to download it can be found [here](https://www.ltg.ed.ac.uk/software/geoparser/).

The following lesson contains instructions on:

*	Downloading and setting up the Edinbugh Geoparser,
*	Geoparsing a text file,
*	Useful options for running the Geoparser,
*	Geoparsing multiple text files,
*	Extracting geo-resolution output to TSV, and
* Using the online demo.

### Downloading and Setting up the Geoparser

The current Edinburgh Geoparser download can be found here:
https://www.ltg.ed.ac.uk/software/geoparser/

Go to the Download section and click on The Edinburgh Geoparser link.  All you need to do then is accept the license, fill in some personal details, so we get an idea of who uses the Geoparser and then press **Download**.  A compressed file called `geoparser-march2016-2.tar.gz` will be downloaded to your Download directory or to wherever you specified the download to go.  Note that this file name may change as we release new versions of the tool.  Some machines will automatically decompress the .gz file and create the directory `geoparser-v1.1`.  If not, then follow the next 3 steps.  Otherwise move the `geoparser-v1.1` directory to where you want it to be installed.  Version 1.1 is the current release, this number will change in future.

1\. Move (`mv`) the `.tar.gz` file to the directory where you want to install the Geoparser.  On the command line you can do that, for example, using the following command when located in your home directory on MacOSX:

    mv ~/Downloads/geoparser-march2016.tar.gz ~/Documents/Software/

In this case, I would like to install the Geoparser in my `Software` directory inside the `Documents` directory.  If you don’t have a Software directory, create it first (i.e. `mkdir ~/Downloads/Software`)

You may want to adjust this command by specifying the place where the Geoparser was downloaded to and the directory you’d like to install it in.  This initial step can also be done by opening the `Downloads` directory with the mouse, selecting the file and copying it into the target directory but once that’s done you should make yourself familiar with the command line as this lesson requires you to use it.  However, I tried to make the various steps described in this lesson as clear as possible so that even someone with little command line knowledge would be able to follow it.

2\. Next, change directories (`cd`) to go to the directory where the `geoparser-march2016.tar` now lives, e.g.: 

    cd ~/Documents/Software/

3\. Run the following command on the command line to un-compress the download:

    tar -xvf geoparser-march2016.tar

You should see a long list of files appear on screen that are part of the distribution.  The `Software` directory will now contain a new directory created called `geoparser-v1.1` (see Figure 1).  You can list (`ls`) its content by typing:

    ls ./geoparser-v1.1

![Figure 1: Content of the geoparser directory.](../images/geoparser_figure00.png "Figure 1: Content of the geoparser directory")
_Figure 1: Content of the geoparser directory_

This folder contains:

* `README:` a file with basic instructions for how to run the Geoparser
* `bin:` a set of binaries for different operating systems. We provide binaries for Linux (x86_64) and MacOSX.
* `in:` a directory with example input files
* `lib:` a set of libraries required for various processing steps
* `out:` a directory with example output files
* `resolve:` a directory containing programs required for geo-resolution
* `scripts:` a directory with a set of scripts to run the Geoparser

Your download and setup are now complete and you can start geo-parsing a text file.

### Geoparsing A Text File

This section explains how to geo-parse a simple text file.  Go to the geoparser’s script directory:

    cd ./geoparser-v1.1/scripts

and try out one of the examples we provide as part of the distribution by running the following two commands:

    cat ../in/172172.txt | ./run -t plain -g geonames -o ../out 172172


If you are not used to working on the command line, different commands can be concatenated with the pipe character (`|`).  In our example the first command is:

    cat ../in/172172.txt

It prints a text file which is situated in the in folder inside geoparser to your screen (which is also called standard out or short stdout).  The pipe character (`|`) is used to send the standard output of one command to the next command which can then use it as standard in (or short stdin).  The second command is:

    ./run -t plain -g geonames -o ../out 172172

It takes the stdout from the first command and runs the Geoparser with the following options (`-t`, `-g` and `-o`):

  * `-t` specifies the format of your input.  We recommend using text input (`plain`) for geoparsing.

  * `-g` specifies the gazetteer that should be queried.  In the above example, the gazetteer selected is [GeoNames](http://www.geonames.org/) (`geonames`), a large global gazetteer.  You can also specify other gazetteers, for example the DEEP gazetteer of historical placenames in England (`deep`) or the Pleiades+ gazetteer of ancient places (`plplus`).  For more information on the types of gazetteers offered as part of the distribution see the Geoparser documentation at: http://groups.inf.ed.ac.uk/geoparser/documentation/v1.1/html/gaz.html

  * `-o` specifies two arguments, the output directory (`../out`) which is located within the `geoparser-v1.1` directory and a prefix for the output file name (in this case `172172`, the same prefix as that of the input file name). Once the command is run and the Geoparser is finished, the result files appear in the output directory (`../out`) starting with the specified prefix.

When running the Geoparser, the specified text file is going through a series of processing steps which are combined into one pipeline.  It is first tokenised, part-of-speech-tagged and lemmatised.  After these initial steps, named entity recognition is performed to identify location and person names as well as dates.  We have found that identifying location and person names in parallel helps to distinguish some ambiguous cases with the same name.  The extracted locations are then resolved to latitude/longitude coordinate pairs.  The text is then further processed by identifying syntactic phrases (chunking) and temporal relations.  The latter two steps are not very relevant to this lesson and will therefore not be explained in detail.  Finally, visualisations are created to be able to inspect the file and the Geoparser output using a map interface in a browser.  For more information on each of the sub-components of the Geoparser, see our documentation here: http://groups.inf.ed.ac.uk/geoparser/documentation/v1.1/html/pipeline.html

To see the output files, go to the `out` directory:

    cd ../out

Now list the files produced with the prefix `172172` using the following command:

    ls 172172*

    172172.display.html 172172.gazlist.html 172172.nertagged.xml
    172172.events.xml 172172.gazmap.html 172172.out.xml
    172172.gaz.xml 172172.geotagged.html 172172.timeline.html

The asterix (`*`) is a wildcard which means that all files starting with `172172` should be listed.  The most relevant Geoparser output files contain the following information:

  * `172172.out.xml`: This is the XML file containing the text of the file in XML including all linguistic processing information specified in line with the text as well as the named entity recognition and the geo-resolution output specified in standoff.  In this file we only store the top-ranked geo-coordinates per resolved location.  If you are not familiar with XML, looking at this file might be quite daunting. I will show you below how to extract the geo-resolution information to TSV (tab separated values) format.
  * `172172.gaz.xml`: This is an XML file containing a ranked list of geo-resolution candidates for each extracted location mention.  The gazetteer (e.g. GeoNames) may contain more than one location per location mention and here we therefore list all candidates.  By default, the number of candidates per surface form returned is capped at 20 if more candidates are present in the gazetteer.  We have found that increasing the number of candidates to be considered by the Geoparser does not increase performance considerably but increases processing time significantly.  In some cases, it might even be better to reduce this parameter to less than 20 (e.g. see Alex et al., 2015).  This is not a setting which can be changed on the command line.  If there is sufficient interest, we can prepare a more advanced lesson on using the Geoparser which will explain how to change this and other more internal settings and features.
  * `172172.display.html`: This is a visual display of the geo-parsed text file containing the text, a map and a list of geo-coordinates for each extracted location.

You can view `172172.display.html` in your browser by typing:

* On MacOSX: `open 172172.display.html`
* On Linux: 		`xdg-open 172172.display.html`

![Figure 2: Display of file 172172.display.html in a browser.](../images/geoparser_figure01.png "Figure 2: Display of file 172172.display.html in a browser.")
_Figure 2: Display of file 172172.display.html in a browser._

At the top of the browser window (see Figure 2) you will see a Google map interface with green and red pins.  At the bottom left is a window containing the text of the geo-parsed file with recognised locations highlighted in light green and at the bottom right there is a window containing the different geo-coordinate pairs for all the candidates considered per extracted location mention.  The ones in green are the top-ranked coordinate pairs which correspond to the green pins on the map.  The red pairs are lower ranked alternatives which correspond to the red pins on the map.  You can also specify the option `-top` on the command line, e.g.:

    cat ../in/172172.txt | ./run -t plain -g geonames -top -o ../out 172172

This creates some additional output files, most notably `172172.display-top.html` which only contains the top-ranked location candidates, so only the green geo-coordinate pairs and pins (see Figure 3).

![Figure 3: Display of file 172172.display-top.html in a browser.](../images/geoparser_figure02.png "Figure 3: Display of file 172172.display-top.html in a browser")
_Figure 3: Display of file 172172.display-top.html in a browser._

### Other Useful Options for running the Geoparser

#### Giving Preference to a Geographical Area

If you know that your text is about a particular geographical area you can specify a bounding circle (`-l locality`) or a bounding box (`-lb locality box`). The Geoparser will prefer places within the specified area but will still consider locations outside it if other factors give them higher weighting.

To specify a circular locality use the following command:

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

For example, a bounding box for Canada is `[W:-141.002701, N:83.110619, E:-52.620201, S:41.681019]` (see Figure 4).

![Figure 4: ](../images/geoparser_figure03.png#1 "Figure 4: Bounding box for Canada.")
_Figure 4: Bounding box for Canada._

To specify this bounding box using our previous example, go back to the scripts directory and run the following command:

    cat ../in/172172.txt | ./run -t plain -g geonames -lb -141.002701 83.110619 -52.620201 41.681019 2 -o ../out 172172 

The `score` was set to 2.  This gives a location within the bounding box twice as much weight as for example the population size of a location during geo-resolution.

![Figure 5: ](../images/geoparser_figure04.png#1 "Figure 5: Display of file 172172.display.html after geo-parsing with a specified bounding box.")
_Figure 5: Display of file 172172.display.html after geo-parsing with a specified bounding box._

In this case, all place names (including Washington, Wimbledon, Germany and France) were resolved to locations within the bounding box (see Figure 5).  The locality option should therefore be used with care and should ideally only be applied to documents where you are relatively certain that all or most locations appear within the specified area.

#### Specifying a Document Date

Apart from identifying locations and person names within text, the Geoparser also contains a component which recognises temporal expressions (dates and times) in textual data and normalises them.  In order to do this well, it is preferable to provide the Geoparser with the date of the document (if known). To try this out using our previous example, type the following command:

    cat ../in/172172.txt | ./run -t plain -g geonames -d 2010-08-10 -o ../out 172172 

* `-d` specifies the document date (`YEAR-MONTH-DATE`).  This parameter is optional.  It is used for normalisation (or grounding) of temporal expressions in the document, for example to compute which particular date the string “Sunday” refers to.

The document date specified on the command line is stored in the XML output and all relative temporal expression will be interpreted with respect to it.  The document date is stored in the meta section at the top of the XML output file.  Use the `head` command to list the first 5 lines of the output file:

    head -n 5 ../out/172172.out.xml

    <?xml version="1.0" encoding="UTF-8"?>
    <document version="3">
    <meta>
    <attr name="docdate" id="docdate" year="2010" month="08" date="10" sdate="2010-08-10" day-number="733993" day="Tuesday" wdaynum="2">20100810</attr>
    <attr name="tokeniser_version" date="20151216"/></meta>

Using our example output file, the first recognised date string in the standoff XML entity output is “Sunday” which appears in the sentence:

> Rafael Nadal and Andy Murray are both through to the semifinals of the Rogers Cup in Toronto, where they will face each other for a place in Sunday's final.

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

If the document date is not specified all temporal expressions will be interpreted relative to the date when the Geoparser is run, so that is today’s date.  However, this setting does not affect the performance of the geo-resolution of place names in this release.

#### Geoparsing Multiple Text Files

Now that you know how to geoparse one file, you may want to do the same thing for a whole set of documents.  This can be done in various ways.  The simplest one would be to write a script which goes to a directory containing your set of files and runs the Geoparser over it.  In this lesson, I will show you how to write a simple shell script or how to run the same thing directly on the command line.

If you want to geoparse a set of files and like to repeat this process again in future, it is worth writing a script to do this.  A simple shell script which does this would look like this:

```
#!/bin/sh

usage="./run-multiple-files -i inboundingBoxputDirectory -o outputDirectory"
descr="Run the Geoparser on multiple text files"

# check that some parameters are specified. If not is specified, then
# the script is exited and the usage is printed
if [ $# -eq "0" ]
then
    echo "No arguments specified"
    echo "usage: $usage" >&2
    exit 2
fi

# while loop to set up the arguments specified when running the script. If the
# arguments are wrong it exits the script and prints the usage
while test $# -gt 0
do
    arg=$1
    shift
    case $arg in
        -i)
            inputdirname=$1
            shift 1
            ;;
        -o)
            outputdirname=$1
            shift 1
            ;;
        *)
            echo "Wrong argument specified"
            echo "usage: $usage" >&2
            exit 2
    esac
done

# for loop to list a set of text files specified in the input directory
for i in `ls $inputdirname/[1br]*.txt`
do
    # a print statement to say which file is currently being processed
    echo Processing $i

    # the prefix is derived from the input file name, i.e. everything before
    # the format extension ".txt"
    prefix=`basename $i ".txt"`

    # each file is then geo-parsed and the output is written to the output
    # directory
    cat $i | ./run -t plain -g geonames -o $outputdirname $prefix
done
```

You can download it here:
http://groups.inf.ed.ac.uk/geoparser/scripts/run-multiple-files.sh

The script is set up to only process files in the input directory which start with "1", "b" or "r".  If you would like to process all text files in the `in` directory (or any other given directory for that matter), change the beginning of the for loop in the script to:

    for i in `ls $inputdirname/*.txt`

This will select all files in the specified input directory which end in `.txt`.  The script also specifies `geonames` as the gazetteer and `plain` as the input format.

Download and move (`mv`) the file into the `scripts` directory of the Geoparser and make it executable by typing: 

    chmod u+x run-multiple-files.sh

The last command makes the script executable by you (`u`) only.  If you specify `g+x` it makes it executable by the group your file is attached to and `a+x` it makes it executable by all.

To run the script type:

    ./run-multiple-files.sh -i ../in -o ../out

* `-i` specifies the input directory and 
* `-o` the output directory

When you enter the command you should see the following three lines appear:

    Processing ../in/172172.txt
    Processing ../in/burtons.txt
    Processing ../in/richard111.txt

The updated output can be found in the `out` directory.  For example, `open ../out/richard111.display.html` and you’ll see the geoparsing results for the third file. 

![Figure 6: Display of file richard111.display.html in a browser.](../images/geoparser_figure05.png "Figure 6: Display of file richard111.display.html in a browser.")
_Figure 6: Display of file richard111.display.html in a browser._

You can see that some locations are recognised in the text but the Geoparser did not resolve them to geo-coordinates (see Figure 6).  The main reason for this may be that a location mention is not contained in GeoNames (the gazetteer used in this example) or the location is contained under a different name.  The geo-resolution of this particular file would be more complete if the `deep` gazetteer was specified which contains places names in England.  You can check this yourself by running the Geoparser on that file, specifying `–g deep`.

To process multiple files very quickly as a one-off, you can also use the following `for` loop directly on the command line of your terminal:

    for i in `ls ../in/*.txt`; do echo Processing $i; prefix=`basename $i ".txt"`; cat $i | ./run -t plain -g geonames -o ../out $prefix ; done

However, such commands are not for the faint-hearted as they tend to break easily as soon as a symbol is missed somewhere.  In this case you also need to be in the scripts directory of the Geoparser to make it work, as the directory paths to the input and output directories are relative to it.

### Extracting Geo-Resolution Output to TSV


![](../images/geoparser_figure06.png)

Some people reading this lesson will not be familiar with parsing XML files to extract information.  I therefore include this section to show you how to extract the geo-resolution information for the identified place names from the `*out.xml` file to a tab-separated values (TSV) file.

The Geoparser is distributed with a very useful set of XML processing tools called [LT-XML2](https://www.ltg.ed.ac.uk/software/ltxml2/) authored by Richard Tobin.  The binaries for these tools are located in the `./geoparser/bin` directory, inside:

* `sys-i386-64`: if you using a 64 bit Linux machine or
* `sys-i386-snow-leopard`: if you’re using MacOSX.  Don’t be confused by the name of this directory.  The binaries should work for all MacOSX installations and not just on Snow Leopard.

All the binaries starting with lx are LT-XML tools which work in combination with Xpath expressions to process or manipulate XML.  Going in detail over Xpath is beyond the scope of this lesson, so I will try to give clear examples to show how things work.  The best tool for printing content of XML in a different format is `lxprintf`.  

Depending on your operating system, go to the `geoparser` directory and run `lxprintf` as follows:

On Linux use:

    ./bin/sys-i386-64/lxprintf -e "ent[@type='location']" "%s\t%s\t%s\t%s\t%s\n" "normalize-space(parts/part)" "@gazref" "@in-country" "@lat" "@long" < ./out/burtons.out.xml > ./out/burtons.out.tsv

and on MacOSX type:

    ./bin/sys-i386-snow-leopard/lxprintf -e "ent[@type='location']" "%s\t%s\t%s\t%s\t%s\n" "normalize-space(parts/part)" "@gazref" "@in-country" "@lat" "@long" < ./out/burtons.out.xml > ./out/burtons.out.tsv

The aim of this command is to extract all location entities in a Geoparser XML output file and present them in TSV format.  The input file is `burtons.out.xml` in the `out` directory of the Geoparser and it is read in as standard in (< stdin) and the output is written to standard out which you can write to a file, in this case (`> ./out/burtons.out.tsv`).

The way this command works is that lxprintf looks for XML entities specified after the option `-e`.  In our case, we are looking for entities of type location (`"ent[@type='location’]”`), e.g. see:

```
<ent id="rb6" type="location" lat="43.70011" long="-79.4163" gazref="geonames:6167865" in-country="CA" feat-type="ppla" pop-size="4612191">
  <parts>
    <part ew="w148" sw="w148">Toronto</part>
  </parts>
</ent>
```

The next argument (`“%s\t%s\t%s\t%s\t%s\n”`) specifies how the output should be printed.  In this case, each specified string (`%s`) should be delimited by a tab (`\t`) character and the last string should be followed by a new line.  This argument looks for 5 strings for each location entity which are specified as follows:

*	`"normalize-space(parts)"` refers to the location mention recognised in the text. normalize() removes any unnecessary whitespace.
*	`"@gazref”` refers to the ID reference of the location in the gazetteer, if resolved.
*	`"@in-country”` refers to the country the location appears in, if resolved.
*	`"@lat”` refers to the latitude of the location, if resolved.
*	`"@long”` refers to the longitude of the location, if resolved.

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

You can see that the TSV output contains the location name, the GeoNames identifier, the country the location is in, and the latitude and longitude coordinates.

To save you having to type this long command and to specify the correct binaries, you can also download [this script](http://groups.inf.ed.ac.uk/geoparser/scripts/extract-to-tsv.sh).

Move the script to the `geoparser-v1.1/scripts` directory, make it executable (`chmod u+x extract-to-csv.sh`) and run it as follows while located in the scripts directory:

    ./extract-to-tsv.sh < ../out/burtons.out.xml > ../out/burtons.out.tsv


### Using the Online Demo

An online demo of the vanilla Edinburgh Geoparser can be tested [here](http://jekyll.inf.ed.ac.uk/geoparser.html). It provides only the visual interface to the Geoparser output and allows you to upload a text file and select a gazetteer.  As a default, we recommend selecting the GeoNames gazetteer as it has global coverage.  You can use one of the text files provided in the Geoparser distribution (e.g. `geoparser/in/burtons.txt`) to try it out.  For example, if you chose the `burtons.txt` file and press `Go!` you will get the output displayed in Figure 7.

![Figure 7: Example output of the Geoparser Demo.](../images/geoparser_figure08.png "Figure 7: Example output of the Geoparser Demo.")
_Figure 7: Example output of the Geoparser Demo._

Note: The demo is not as configurable as the download and should only be used to try out small examples and not for geoparsing a large number of files.

### Frequently Asked Questions

**_How long does the text have to be for the Geoparser to work well?_**

The vanilla download works most accurately with running English text.  It works on individual sentences.  Geo-resolution accuracy increases however if the Geoparser has access to more context.  On the other hand, the Geoparser is not well suited to process large documents made up of several sub-texts, e.g. a journal made up of articles unless the articles are all related and contain similar locations. In the latter case it would be better to split the document into the articles first.

**_Is it possible to exclude particular names from the output ahead of geo-resolution?_**

This is not possible to do when treating the Geoparser as a blackbox.  Currently we don’t specify a command line option with a list of names to exclude.  But this is something we will consider adding in future releases.

**_Is it possible to specify/vary the context size used when disambiguating locations?_**

This is not possible in the default download.  It considers all locations within the document when resolving a location in question.

**_Is it possible to geo-parse historical text using the Geoparser?_**

Yes.  However, when using the Geoparser in combination with the GeoNames gazetteer some historical place names will not be identified as they are missing from the gazetteer.  Also the Geoparser team can provide additional pre-processing to improve the quality of optical-character recognised output (e.g. to fix soft-hyphen splitting or to deal with the long “s” character).  Those scripts are not distributed with the standard distribution but you can contact us to get access to them.

**_Can the Geoparser output be visualised with another map interface (e.g. OpenStreetMap)_**

Yes.  Once you have extracted the geo-location information from the `*out.xml` file(s) you can use it as input into any of your favourite mapping tool.

### Credits
The Geoparser and its demo were developed in a team effort by Claire Grover, Richard Tobin, Kate Byrne and Beatrice Alex.

If you found this lesson useful for your work, please cite it as:

    Beatrice Alex. 2016. Geoparsing Text with the Edinburgh Geoparser, Lesson of The Programming Historian, URL, 2016.

or cite one of our publications listed at: https://www.ltg.ed.ac.uk/software/geoparser/

Our team also welcome suggestion for future collaboration to tailor the Geoparser to different needs.  Please get in touch if you have ideas about how we should develop the software.

### References

Beatrice Alex, Clare Llewellyn, Claire Grover, Jon Oberlander and Richard Tobin (2016). Homing in on Twitter users: Evaluating an Enhanced Geoparser for User Profile Locations. 2016. In the Proceedings of the 10th Language Resources and Evaluation Conference (LREC), 23-28 May 2016. [[pdf](http://www.lrec-conf.org/proceedings/lrec2016/pdf/129_Paper.pdf)]       

Beatrice Alex, Kate Byrne, Claire Grover and Richard Tobin (2015). Adapting the Edinburgh Geoparser for Historical Georeferencing. International Journal for Humanities and Arts Computing, 9(1), pp. 15-35, March 2015.[[pdf](http://www.euppublishing.com/doi/pdfplus/10.3366/ijhac.2015.0136)]

Claire Grover and Richard Tobin (2014). A Gazetteer and Georeferencing for Historical English Documents. In Proceedings of LaTeCH 2014 at EACL 2014. Gothenburg, Sweden. [[pdf]](http://www.aclweb.org/anthology/W14-0617)

Claire Grover, Richard Tobin, Kate Byrne, Matthew Woollard, James Reid, Stuart Dunn, and Julian Ball (2010). Use of the Edinburgh Geoparser for georeferencing digitised historical collections. Philosophical Transactions of the Royal Society A. [[pdf](http://homepages.inf.ed.ac.uk/grover/papers/PTRS-A-2010-Grover-3875-89.pdf)]

Leif Isaksen, Elton Barker, Eric C. Kansa and Kate Byrne. 2011b. Googling Ancient Places. In Proceedings of Digital Humanities 2011 (DH2011), Stanford, CA, June 2011. [[html](http://dh2011abstracts.stanford.edu/xtf/view?docId=tei/ab-349.xml)]
