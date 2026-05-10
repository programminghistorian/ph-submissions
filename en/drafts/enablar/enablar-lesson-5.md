---
title: "Exploring Library Catalogues as Data"
slug: enablar-lesson-5
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Doreen Cheen
- Péter Király
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket:
difficulty:
activity:
topics:
abstract: Short abstract of this lesson
avatar_alt:
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

<!-- NOTE TO ENABLAR AUTHORS 
Note 1: The YAML + Table of Contents Include above are formatted according to our local requirements and should remain in place.

You can edit the title: "Exploring Library Catalogues as Data" (line 2), and add your names into the `authors:` field.

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

## Preliminaries
### Method or tool
### Technical context
### Social context
### Prerequisites
### Difficulty

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
#### Data acquisition

In this lesson we will show the least complicated data acquisition method: downloading one or more files. There are a number of library specific APIs that are available in many different libraries to access records (OAI-PMH, RSU, Z39.50), these will be described in other tutorials. Fortunately there are libraries that enable file downloads -- see a list in the appendix of this lesson. One of them is Yale, which published the catalogue under CC0 license at https://guides.library.yale.edu/c.php?g=923429. The actual downloadable files can be accessed at https://metadata.library.yale.edu/MARCXML/. This page contains a full catalogue, and increments. At time of writing the files belonging to the full catalogue are listed at https://metadata.library.yale.edu/MARCXML/bib_20250706_full/.

In the first step we explain how to download a single file.

As usual in Python we should start with importing the Python libraries we would like to utilize in the script:

```Python
import urllib.request
import os
import gzip
import shutil
import re
```

* `urllib.request` is a library for opening URLs, https://docs.python.org/3/library/urllib.request.html 
* `os` contains miscellaneous operating system interfaces, https://docs.python.org/3/library/os.html
* `gzip` supports operations on gzip files, https://docs.python.org/3/library/gzip.html
* `shutil` provides high-level file operations, https://docs.python.org/3/library/shutil.html
* `re` provides regular expression operations, https://docs.python.org/3/library/re.html

We should specify the URL of the file we would like to download:

```Python
url = 'https://metadata.library.yale.edu/MARCXML/bib_20250706_full/bib_20250706_full_000_00.xml.gz'
```

In our machine, it will be located in a specific directory (we call it `target_dir`), and if it is not yet existing, we should create it.

```Python
target_dir = 'data/yale'
if not os.path.exists(target_dir):
    os.makedirs(target_dir)
```

Then we should specify the file in our local machine. We extract it from the URL with a regular expression. `/([^/]+)$` means find a slash character (`/`) followed by one or more not slash characters (`[^/]+`) till the end of the string (`$`), and put these characters into a group `(...)`. With this we specify the file name. With `group(1)` we can extract the content of the first (and in this case the only) group. Finally, we concatenate the directory and file names with an f-string.

```Python
file_name = re.search('/([^/]+)$', url).group(1)
target_file = f'{target_dir}/{file_name}'
```

The act of downloading is pretty simple, it saves the content of the URL into the specified file:

```Python
urllib.request.urlretrieve(url, target_file)
```

As we would like to work with XML an file and not a compressed file (which would be also possible, but not discussed in this lesson), we should extract it. It needs some steps. With `gzip.open()` we open the archive file in binary read mode (it behaves similar to other file read operations in Python), and we specify a file handle (`f_in`). We should also specify the name of the uncompressed file with the help of another regular expression. `re.sub()` substitutes strings, here we are looking for the `.gz` extension in the file name, and replace it with an empty string - in other words, we remove it. Note: in regular expression `.` (dot character) has a special meaning: it fits any character. If we want to mean the real dot, we should escape this interpretation with the blackslashes. Then we open a binary file for writing and utilize the `shutil.copyfileobj()` method to copy the content. 

```Python
with gzip.open(target_file, 'rb') as f_in:
    uncompressed_file = re.sub(r'\\.gz$', '', target_file)
    with open(uncompressed_file, 'wb') as f_out:
        shutil.copyfileobj(f_in, f_out)
```

Our final step is to remove the unwanted compressed file:

```Python
os.remove(target_file)
```

So far so good, but this script downloads only a single file, it is not very flexible, we should modify it to download a different file. Let's solve these problems. The new version should accept the URL of the index page, that contains the links to all gzip files as a script parameter.

```Python
import urllib.request
import os
import gzip
import shutil
import re
import sys
import lxml.html
from argparse import ArgumentParser
```

We will use some new libraries:

* `sys` contains system-specific parameters and functions, https://docs.python.org/3/library/sys.html
* `lxml` responsible for handling XML and HTML, https://lxml.de/import lxml.html
* `argparse` is a parser for command-line options, arguments and subcommands, https://docs.python.org/3/library/argparse.html

The last line's format (`from ... import ...`) is used to limit the import: we will use only a specific part of the library, here the `ArgumentParser` object.

Then we create a configuration with default values:

```Python
configuration = {
  'index': 'https://metadata.library.yale.edu/MARCXML/bib_20250706_full',
  'target_dir': 'raw-data/yale'
}
```

Because we will download multiple files, it would be useful to separate the code into a function that accepts a file name, and utilizes the configuration object. We start with the function's signature and documentation:

```Python
def download_file(file_name):
    """
    Downloads a file, saves it into a directory, uncompresses it and deletes the compressed version.
    The base URL and the target directory come from the configuration object.
    Parameters                              
    ----------
    file_name : str
        the name of the downloadable file
    """
```

Next we set the variables based on the input parameter and the configuration. A log entry will inform the user about the process:

```Python
    remote_file = configuration['index'] + '/' + file_name
    local_file = configuration['target_dir'] + '/' + file_name
    uncompressed_file = re.sub(r'.gz', '', local_file)
    print(f'downloading {remote_file} to {uncompressed_file} ...')
```

The bulk of the function repeats what we saw in the single file download, with a check (launch download if neither the gzip nor the xml file are available) and a try-except block. This later catches network problems and informs the user. If we would not put the functionality inside that block an error would stop the script itself.

```Python
    if not os.path.exists(local_file) and not os.path.exists(uncompressed_file):
        try:
            urllib.request.urlretrieve(remote_file, local_file)

            with gzip.open(local_file, 'rb') as f_in:
                with open(uncompressed_file, 'wb') as f_out:
                    shutil.copyfileobj(f_in, f_out)

        except urllib.error.HTTPError as e:
            print("A network problem occured: ", e)
    
    if os.path.exists(local_file):
        os.remove(local_file)
```

It is a good practice to put the entry point of a Python script into a `main()` function. We start it with parsing the arguments. First we create a new `ArgumentParser` object, and define two arguments: index and target_dir. In the `add_argument` we provide the short and long argument name the user can specify in the command line. `dest` sets the name of the variable that holds the value, `help` sets the help text (which is displayed when we call the script if `h` or `--help` arguments). The `parse_args()` method parses the user input, and stores it in the `args` object.

```Python
def main():
    parser = ArgumentParser()
    parser.add_argument("-i", "--index", dest="index", help="the index page that contains list of files")
    parser.add_argument("-t", "--target_dir", dest="target_dir", help="the target directory where the files will be stored locally")
    args = parser.parse_args()
```

If the user sets these arguments we should save them into the `configuration` object overwriting its default values:

```Python
    if args.index is not None:
        configuration['index'] = args.index
    if args.target is not None:
        configuration['target_dir'] = args.target_dir
```

As in the single file setup we should create the target directory if it is not already existing:

```Python
    if not os.path.exists(configuration['target_dir']):
        os.makedirs(configuration['target_dir'])
```

And finally we should fetch the index page, extract links to the .gz files, and call the `download_file()` function. This time we do not save the result of URL request, but save it into memory as a [HTTPResponse](https://docs.python.org/3/library/http.client.html#http.client.HTTPResponse) object. We read its content into a string, then the `lxml` library parses the HTML structure allowing us to run searches with an XPath expression. `body/table/tr/td/a` finds all links inside the page tables. We iterate over them, extracting the `href` attribute of each link, and if they end with `.gz`, calling the download function.

```Python
    with urllib.request.urlopen(configuration['index']) as response:
        content = response.read()
        doc = lxml.html.fromstring(content)
        items = doc.findall('body/table/tr/td/a', {})
        for item in items:
            file_name = item.get('href')
            if re.search('\\.gz$', file_name):
                download_file(file_name)
```

The last lines of the script ensure that the `main()` function is called:

```Python
if __name__ == '__main__':
    sys.exit(main())
```

We can use the script the following way

```Python
download-multiple-files.py [-i INDEX] [-t TARGET_DIR]
```

such as

```Python
python download-multiple-files.py \
    --index https://metadata.library.yale.edu/MARCXML/bib_20250706_full \
    --target raw-data/yale
```

#### Preprocessing
<!-- File formats, data structures, conversion, and data loss control. -->

In this section we will describe how to transform three types of MARC files to Python's Pandas data frame, then save them to a CSV file. The three types are:

- binary MARC file formatted according to [ISO 2709](https://en.wikipedia.org/wiki/ISO_2709) format
- MARCXML file
- large MARCXML file

MARC21 records' logical structure does not fit to the tidy tabular format that (as defined by [Hadley Wickham](https://r4ds.hadley.nz/data-tidy.html#sec-tidy-data)) has the following property:

1. Each variable is a column; each column is a variable.
2. Each observation is a row; each row is an observation.
3. Each value is a cell; each cell is a single value.

The problem is that in MARC21 there are repeatable fields, e.g. multiple subjects, so if you would like to create a table, where there are columns for identifier and subject, you should decide if you would like to put all subject headings into a single cell, or you would like to create multiple rows for each pair of identifier and subject. Both approaches have their own advantages and disadvantages - you should decide on choosing according to the objective of the analysis.

Let's start with reading a binary MARC file with the [PyMarc](https://gitlab.com/pymarc/pymarc) package.

```Python
from pymarc import MARCReader

with open('raw-data/pymarc/marc.dat', 'rb') as fh:
    reader = MARCReader(fh)
    for record in reader:
        print(record.title)
```

The code is extracted from the package's README. It opens a binary (ISO 2709) file with the standard Python `open` function, and passes the file handler to the package's `MARCReader` class. It provides an iterator, so we can iterate all records in the file one by one. The MARC21 record is  represented as a `Record` object that provides a number of methods to access and modify data elements inside a record. Here we only print the title of the record -- i.e. field `245$a` (title) concatenated with `$b` (Remainder of title) if the latter exists (about the details of these subfields see [MARC21 documentation](https://www.loc.gov/marc/bibliographic/bd245.html)).

For reading MARCXML we should select a strategy based on the size of the file and the memory we have. PyMarc provides two helper functions: 

- `parse_xml_to_array` reads the whole file and creates a list of `Record` objects
- `map_xml` reads records one by one and calls a user defined function on it. For this you have to define a function

How does it look like in practice? 

`parse_xml_to_array`:

```Python
from pymarc import parse_xml_to_array

records = parse_xml_to_array('raw-data/yale/bib_20250706_full_000_00.xml')
for record in records:
    print(record.title)
```

`map_xml`

```Python
from pymarc import map_xml

def process_record(record):
    print(record.title)

map_xml(process_record, 'raw-data/yale/bib_20250706_full_000_00.xml')
```

In these examples all what we did is just printing something, but how we can create Pandas from the records? Start with a simple case: collect record ID and title. In the last code snippet we already had a `process_record` section. We will modify it, but for the sake of unity we will replace the `print()` call in the other two code:

```Python
for record in reader:
    process_record(record)
```

and

```Python
for record in records:
    process_record(record)
```

so now we have a single `process_record` function, that can behave the same even we process  binary, xml or large xml files. We change this to extract particular data elements (identifier and title) from each MARC21 record, then to build a pandas data frame.

```Python
from pymarc import map_xml
import pandas as pd

ids = []
titles = []

def process_record(record):
    ids.append(record.get('001').value())
    titles.append(record.title)

input_file_name = 'raw-data/yale/bib_20250706_full_000_00.xml'
map_xml(process_record, input_file_name)

df = pd.DataFrame({'id': ids, 'title': titles})
print(df.head())
```

Here we import pandas package with an alias name `pd`, that is the usual way to use it. We initialize two lists, one for the identifiers, and one for the titles. In the `process_record` function we extract their values from the record object, and append the value to the appropriate lists. At the end we create a pandas data frame with a dictionary. The keys are the column names (id and title), the values are the two list. Here both MARC21 data element are quasi mandatory elements, they are available in every record. For other elements, we should be sure if the record has them, and if not, we should provide a default value, e.g. an emtpy string or `None` value. In the last line we simply make a check, print out the first five rows of the data frame to be sure that the process finished with the result we expected.

There are be other approaches to fullfil this task, e.g. to create an empty data frame at the beginning of the process, and add new rows with pd.append or pd.loc, however these approaches have their disadvantages regarding to speed and memory usage, so they are discouraged.


#### Data harmonisation
Normalization and data enrichment. The reproducible conversion into a data set suitable for quantitative humanities analysis.

#### Data analysis and visualization

##### Place and personal names
##### Dates
##### Subjects

##### How to work across two datasets computationally

#### Dissemination of results

Publication of software and research data for reuse.

### Summary


## Local application
### Apply this method
### Other projects
### Continued learning

## Endnotes
