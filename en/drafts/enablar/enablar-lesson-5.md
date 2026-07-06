---
title: "Exploring Library Catalogues as Data"
slug: enablar-lesson-5
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Doreen Chen
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
:
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
This lesson teaches *bibliographic data science*: the practice of treating library catalogue records as structured data that can be acquired, reshaped, analysed, and shared at scale. Instead of inspecting records one at a time through a catalogue interface, we work with thousands of them at once using Python.

The two central tools are [PyMARC](https://gitlab.com/pymarc/pymarc), a Python package for reading MARC records, and [pandas](https://pandas.pydata.org/), the standard Python library for tabular data. Several supporting libraries handle downloading and plotting. We introduce each tool as it becomes relevant in each stage.

### Technical context
MARC (MAchine-Readable Cataloging) is a metadata standard in library catalogues. Developed at the Library of Congress in the 1960s and now in its MARC21 form, it is the format in which many libraries store and exchange bibliographic records.

MARC data comes in two common serializations: a binary format defined by [ISO 2709](https://en.wikipedia.org/wiki/ISO_2709), and MARCXML, an XML representation that is easier to process with modern tools. This lesson works primarily with MARCXML.

### Social context
Catalogues are not neutral. The vocabularies libraries use to describe their holdings, especially subject headings, encode decisions about what matters, how things should be named, and whose perspective counts as the default.

Treating catalogues as data makes these patterns visible. A researcher can ask how a collection's subject coverage is distributed, how cataloguing practice has changed over time, or how two institutions describe the same material differently. The techniques in this lesson are a starting point for that kind of inquiry. They do not, by themselves, answer questions about bias or representation, but they give you the means to begin asking them with evidence.

### Prerequisites

This lesson assumes:

- **Working familiarity with MARC.** We work directly with MARC fields and subfields. The lesson teaches what to *do* with MARC records using Python; it does not teach the MARC format itself.
- **Basic Python**: variables, functions, lists, dictionaries, loops, and conditionals. If you are new to Python, we recommend an introductory lesson first, such as [Python Introduction and Installation](/en/lessons/introduction-and-installation).
- **Comfort at the command line** to run a Python script, and familiarity with installing packages using `pip`.

### Difficulty

Intermediate. The lesson asks the reader to hold several tools in mind at once (PyMARC, pandas, regular expressions, plotting) and to follow a multi-stage workflow from raw files to finished results.

## Use Case

This lesson is motivated by two situations a librarian or researcher might realistically face. Both lead to the same underlying method, which is why a single set of techniques can serve them both.

**Benchmarking a catalogue against an external standard.** A metadata librarian at a mid-sized academic library has been asked to assess the quality of her catalogue. She has no clear sense of what "good" looks like in isolation, so she decides to benchmark against a larger, professionally maintained catalogue. By extracting the same fields from both and comparing how each describes its materials, she can move from a vague "our records could be better" to a specific account of where her catalogue differs from the comparison standard.

**Assessing metadata across multiple sources.** A digital projects librarian is preparing a discovery portal that will search across several library collections at once. Before launch, she needs to know whether the metadata from each source is consistent enough to display and filter coherently. If one source assigns rich subject headings and another assigns none, the portal's facets and filters will not work as users expect. She needs to compare field usage across sources and find the gaps.

Both librarians do the same computational work: acquire records, parse them, reshape them into a table, and compare. Once you have the method, you can use it with your own catalogue, a national bibliography, or any set of records.

### Dataset

We use the bibliographic catalogue of [Yale University Library](https://web.library.yale.edu/), which Yale releases through its [Open Metadata Service](https://guides.library.yale.edu/open-metadata-service). 

The catalogue is published as MARCXML at <https://metadata.library.yale.edu/MARCXML/>. Because the full catalogue is large, it is distributed as a set of numbered, compressed files (which we refer to as *shards*), each containing many thousands of records. For most of this lesson we work with one or two shards.

One note on licensing: most Yale-originated records are released under a public domain [CC0 license](https://creativecommons.org/publicdomain/zero/1.0/), while records derived from [OCLC WorldCat](https://www.worldcat.org/) carry an [ODC-BY](https://opendatacommons.org/licenses/by/1.0/) license requiring attribution to OCLC. Yale embeds the applicable license directly in each record. If you publish results derived from this data, check the relevant records and attribute accordingly.

### Software/tool

The lesson uses the following Python packages, introduced in context but listed here for reference:

- [PyMARC](https://gitlab.com/pymarc/pymarc) reads and parses MARC records. This lesson works mainly with the MARCXML form.
- [pandas](https://pandas.pydata.org/) provides the DataFrame, the tabular structure we reshape records into.
- [lxml](https://lxml.de/) parses HTML, used during acquisition to find downloadable files on an index page.
- [matplotlib](https://matplotlib.org/) and [matplotlib-venn](https://pypi.org/project/matplotlib-venn/) produce the Venn diagram visualisation.
- [numpy](https://numpy.org/) is used in scientific computing mainly for numerical operation. Here we use only one feature: it defines data types that pandas and visualisation can use. It is frequently abbreviatied as `np`.
- Several standard-library modules (`urllib`, `os`, `gzip`, `shutil`, `re`) handle downloading, file management, and pattern matching.

## Learning keys

### Concepts
- Why MARC's structure does not map directly onto a tidy table.
- The difference between repeatable and non-repeatable fields, and two strategies for handling repeatable fields in tabular data.
- How to read records one at a time versus all at once, and when each approach is appropriate.
- How to compose small, single-purpose functions into a larger analysis.
- How to compare bibliographic data across two sources, and how to present the comparison visually.

### Terms

- **MARC / MARC21**: the machine-readable cataloguing standard used to store bibliographic records.
- **MARCXML**: an XML serialisation of MARC records.
- **Field and subfield**: the numbered (e.g. `245`) and lettered (e.g. `$a`) components of a MARC record.
- **LCSH (Library of Congress Subject Headings)**: the controlled vocabulary used to assign subject headings.
- **Shard**: one of the numbered files into which a large catalogue is split.

### Time
<!-- TODO (Doreen): add a time estimate after walking through the lesson, e.g. ~3 hours including downloads. -->

## Learning experiment

### Aims
This lesson aims to give you a working command of a bibliographic data science pipeline, using a real catalogue, so that you can carry the method to your own data and questions. Concretely, after completing it you should be able to:

- **Acquire** bibliographic records by downloading and decompressing them programmatically, and adapt the acquisition script to a different source.
- **Parse and reshape** MARC records into a pandas DataFrame, handling both fields that appear once per record and fields that repeat.
- **Analyse and compare** the data, including comparing how two catalogues describe the same kind of material, and **visualise** the comparison as a Venn diagram.

The example questions we ask of the data are illustrative; the techniques are general and can be applied to other questions of interest.

### Inventory

Before starting the workflow, make sure you have the following in place. The steps that follow assume this setup.

**Python environment.** Python 3 with the packages listed under [Software/tool](#softwaretool). You can install the third-party packages in one step:

```bash
pip install pymarc pandas lxml matplotlib matplotlib-venn
```

**A working directory.** Create a folder for the project. The code in this lesson uses relative paths, so all commands assume you are working from this folder. Within it, the acquisition step will create a `raw-data/yale/` subfolder for the downloaded records, and the visualisation step writes images to a `fig_output/` subfolder.

### Workflow
#### Data acquisition

In this lesson we will show the least complicated data acquisition method: downloading one or more files. There are a number of library specific APIs that are available in many different libraries to access records (OAI-PMH, RSU, Z39.50), these will be described in other tutorials. Fortunately there are libraries that enable file downloads -- see the list in the QA Catalogue [documentation](https://pkiraly.github.io/qa-catalogue/where-can-I-get-MARC-records.html). One of them is Yale, which published the catalogue under CC0 license at [https://guides.library.yale.edu/c.php?g=923429](https://guides.library.yale.edu/c.php?g=923429). The actual downloadable files can be accessed at [https://metadata.library.yale.edu/MARCXML/](https://metadata.library.yale.edu/MARCXML/). This page contains a full catalogue, and increments. At time of writing the files belonging to the full catalogue are listed at [https://metadata.library.yale.edu/MARCXML/bib_20250706_full/](https://metadata.library.yale.edu/MARCXML/bib_20250706_full/).

In the first step we explain how to download a single file.

As usual in Python we should start with importing the Python libraries we would like to utilize in the script:

```python
import urllib.request
import os
import gzip
import shutil
import re
```

* `urllib.request` is a library for opening URLs, [https://docs.python.org/3/library/urllib.request.html](https://docs.python.org/3/library/urllib.request.html) 
* `os` contains miscellaneous operating system interfaces, [https://docs.python.org/3/library/os.html](https://docs.python.org/3/library/os.html)
* `gzip` supports operations on gzip files, [https://docs.python.org/3/library/gzip.html](https://docs.python.org/3/library/gzip.html)
* `shutil` provides high-level file operations, [https://docs.python.org/3/library/shutil.html](https://docs.python.org/3/library/shutil.html)
* `re` provides regular expression operations, [https://docs.python.org/3/library/re.html](https://docs.python.org/3/library/re.html)

We should specify the URL of the file we would like to download:

```python
url = 'https://metadata.library.yale.edu/MARCXML/bib_20250706_full/bib_20250706_full_000_00.xml.gz'
```

In our machine, it will be located in a specific directory (we call it `target_dir`), and if it is not yet existing, we should create it.

```python
target_dir = 'raw-data/yale'
if not os.path.exists(target_dir):
    os.makedirs(target_dir)
```

Then we should specify the file in our local machine. We extract it from the URL with a regular expression. `/([^/]+)$` means find a slash character (`/`) followed by one or more non-slash characters (`[^/]+`) till the end of the string (`$`), and put these characters into a group `(...)`. With this we specify the file name. With `group(1)` we can extract the content of the first (and in this case the only) group. Finally, we concatenate the directory and file names with an [f-string](https://realpython.com/python-f-strings/).

```python
file_name = re.search('/([^/]+)$', url).group(1)
target_file = f'{target_dir}/{file_name}'
```

The act of downloading is pretty simple, it saves the content of the URL into the specified file:

```python
urllib.request.urlretrieve(url, target_file)
```

As we would like to work with an XML file and not a compressed file (which would be also possible, but not discussed in this lesson), we should extract it. It needs some steps. With `gzip.open()` we open the archive file in binary read mode (it behaves similarly to other file read operations in Python), and we specify a file handle (`f_in`). We should also specify the name of the uncompressed file with the help of another regular expression. `re.sub()` substitutes strings. Here we are looking for the `.gz` extension in the file name, and replace it with an empty string - in other words, we remove it. Note: in regular expression `.` (dot character) has a special meaning: it fits any character. If we want to mean the real dot, we should escape this interpretation with the backslashes. We put an `r` prefix before the search string. This refers to the so-called _r-string_ or [raw string notation](https://mimo.org/glossary/python/raw-strings) that treats backslashes (`\`) as literal characters rather than escape sequences, otherwise we should add double backslashes, to behave as escape sequence in regular expressions. Finally, we open a binary file for writing and utilize the `shutil.copyfileobj()` method to copy the content. 

```python
with gzip.open(target_file, 'rb') as f_in:
    uncompressed_file = re.sub(r'\.gz$', '', target_file)
    with open(uncompressed_file, 'wb') as f_out:
        shutil.copyfileobj(f_in, f_out)
```

Our final step is to remove the unwanted compressed file:

```python
os.remove(target_file)
```

So far so good, but this script downloads only a single file, more than that the file name is hard coded, so we should modify the script if we would like to download a different file. Let's solve these problems. The new version should accept the URL of the index page, that contains the links to all gzip files as a script parameter.

```python
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

* `sys` contains system-specific parameters and functions, [https://docs.python.org/3/library/sys.html](https://docs.python.org/3/library/sys.html)
* `lxml` responsible for handling XML and HTML, [https://lxml.de/import lxml.html](https://lxml.de/import lxml.html)
* `argparse` is a parser for command-line options, arguments and subcommands, [https://docs.python.org/3/library/argparse.html](https://docs.python.org/3/library/argparse.html)

The last line's format (`from ... import ...`) is used to limit the import: we will use only a specific part of the library, here the `ArgumentParser` object.

Then we create a configuration with default values:

```python
configuration = {
  'index': 'https://metadata.library.yale.edu/MARCXML/bib_20250706_full',
  'target_dir': 'raw-data/yale'
}
```

Because we will download multiple files, it would be useful to separate the code into a function that accepts a file name, and utilizes the configuration object. We start with the function's signature and documentation:

```python
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

```python
    remote_file = configuration['index'] + '/' + file_name
    local_file = configuration['target_dir'] + '/' + file_name
    uncompressed_file = re.sub(r'\.gz', '', local_file)
    print(f'downloading {remote_file} to {uncompressed_file} ...')
```

The bulk of the function repeats what we saw in the single file download, with a check (launch download if neither the gzip nor the xml file are available) and a try-except block. This later catches network problems and informs the user. If we would not put the functionality inside that block an error would stop the script itself.

```python
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

It is a good practice to put the entry point of a Python script into a `main()` function. We start it with parsing the arguments. First we create a new `ArgumentParser` object, and define two arguments: index and target_dir. In the `add_argument()` we provide the short (here `-i` and `-t`) and long (`--index`, `--target_dir`) argument names the user can specify in the command line. `dest` sets the name of the variable that holds the value, `help` sets the help text (which is displayed when we call the script if `h` or `--help` arguments). The `parse_args()` method parses the user input, and stores it in the `args` object.

```python
def main():
    parser = ArgumentParser()
    parser.add_argument("-i", "--index", dest="index", help="the index page that contains list of files")
    parser.add_argument("-t", "--target_dir", dest="target_dir", help="the target directory where the files will be stored locally")
    args = parser.parse_args()
```

If the user sets these arguments we should save them into the `configuration` object overwriting its default values:

```python
    if args.index is not None:
        configuration['index'] = args.index
    if args.target is not None:
        configuration['target_dir'] = args.target_dir
```

As in the single file setup we should create the target directory if it is not already existing:

```python
    if not os.path.exists(configuration['target_dir']):
        os.makedirs(configuration['target_dir'])
```

And finally we should fetch the index page, extract links to the .gz files, and call the `download_file()` function. This time we do not save the result of URL request, but save it into memory as a [HTTPResponse](https://docs.python.org/3/library/http.client.html#http.client.HTTPResponse) object. We read its content into a string, then the `lxml` library parses the HTML structure allowing us to run searches with an XPath expression. `body/table/tr/td/a` finds all links inside the page tables. We iterate over them, extracting the `href` attribute of each link, and if they end with `.gz`, calling the download function.

```python
    with urllib.request.urlopen(configuration['index']) as response:
        content = response.read()
        doc = lxml.html.fromstring(content)
        items = doc.findall('body/table/tr/td/a', {})
        for item in items:
            file_name = item.get('href')
            if re.search(r'\.gz$', file_name):
                download_file(file_name)
```

The last lines of the script ensure that the `main()` function is called:

```python
if __name__ == '__main__':
    sys.exit(main())
```

We can use the script the following way

```python
download-multiple-files.py [-i INDEX] [-t TARGET_DIR]
```

such as

```python
python download-multiple-files.py \
    --index https://metadata.library.yale.edu/MARCXML/bib_20250706_full \
    --target raw-data/yale
```

#### Preprocessing
<!-- File formats, data structures, conversion, and data loss control. -->

In this section we will describe how to transform three types of MARC files to Python's pandas data frame, then save them to a CSV file. The three types are:

- binary MARC file formatted according to [ISO 2709](https://en.wikipedia.org/wiki/ISO_2709) format
- MARCXML file
- large MARCXML file

MARC21 records' logical structure does not fit to the tidy tabular format that (as defined by [Hadley Wickham](https://r4ds.hadley.nz/data-tidy.html#sec-tidy-data)) has the following property:

1. Each variable is a column; each column is a variable.
2. Each observation is a row; each row is an observation.
3. Each value is a cell; each cell is a single value.

The problem is that there are repeatable fields in MARC21, e.g. multiple subjects, so if you would like to create a table, where there are columns for identifier and subject, you should decide if you would like to put all subject headings into a single cell, or you would like to create multiple rows for each pair of identifier and subject. Both approaches have their own advantages and disadvantages - you should decide on choosing according to the objective of the analysis.

Let's start with reading a binary MARC file with the [PyMarc](https://gitlab.com/pymarc/pymarc) package.

```python
from pymarc import MARCReader

with open('raw-data/pymarc/marc.dat', 'rb') as fh:
    reader = MARCReader(fh)
    for record in reader:
        print(record.title)
```

The code is extracted from the package's README. It opens a binary (ISO 2709) file with the standard Python `open` function, and passes the file handler to the package's `MARCReader` class. It provides an iterator, so we can iterate all records in the file one by one. The MARC21 record is  represented as a `Record` object that provides a number of methods to access and modify data elements inside a record. Here we only print the title of the record -- i.e. field `245$a` (title) concatenated with `$b` (Remainder of title) if the latter exists (about the details of these subfields see [MARC21 documentation](https://www.loc.gov/marc/bibliographic/bd245.html)).

For reading MARCXML we should select a strategy based on the size of the file and the memory we have. PyMarc provides two helper functions: 

- `parse_xml_to_array` reads the whole file and creates a list of [Record](https://pymarc.readthedocs.io/en/latest/#module-pymarc.record) objects. Simple, but memory-heavy for large files.
- `map_xml` reads records one at a time and calls a function you provide on each one. Memory-friendly, and the right choice for catalogue-scale data.

How does it look like in practice? 

A `parse_xml_to_array` example:

```python
from pymarc import parse_xml_to_array

input_file = 'raw-data/yale/bib_20250706_full_000_00.xml'
records = parse_xml_to_array(input_file)
for record in records:
    print(record.title)
```

A `map_xml` example:

```python
from pymarc import map_xml

input_file = 'raw-data/yale/bib_20250706_full_000_00.xml'
def process_record(record):
    print(record.title)

map_xml(process_record, input_file)
```

In both cases **you should see** a long stream of titles scrolling past, one per record. If you see nothing, check that `input_file` points to a file that actually exists on disk. If you see an error about `pymarc`, re-run the install line above.

Yale's bibliographic shards contain tens of thousands of records each, so we'll use `map_xml` throughout. The pattern is: write a function that takes one record and does something with it, then hand that function to `map_xml` along with the file path. `map_xml` does the rest, calling your function once per record.

In these examples all what we did is just printing something, but how can we turn those lists into a DataFrame?

##### Extracting non-repeatable fields into a DataFrame

The general pattern is:

1. Create an empty list for each column you want.
2. In `process_record`, append values from each record onto those lists.
3. After `map_xml` finishes, hand the lists to pandas to construct a DataFrame.

We'll start with three fields that appear at most once per record:

- **Record ID**, MARC field `001`, the control number. Quasi-mandatory.
- **Title**, MARC field `245`. Also quasi-mandatory.
- **Author**, MARC field `100$a`, the personal name main entry. *Not* mandatory: many records (anonymous works, corporate publications, edited volumes) have no `100`. We need a defensive pattern that records `None` when it's absent.


As pandas' data frame is one of the most convenient data structure used in data analysis, our next task is to to extract particular data elements (here: identifier and title) from each MARC21 record, then to build a pandas data frame.

```python
from pymarc import map_xml
import pandas as pd

# One list per column in the final DataFrame
ids = []
titles = []
authors = []

def process_record(record):
    # 001 and title are quasi-mandatory, so we can append directly
    ids.append(record.get('001').value())
    titles.append(record.title)

    # 100 may be absent. record.get('100') returns None when the field
    # doesn't exist, so check before reaching into it.
    field_100 = record.get('100')
    if field_100 is not None and field_100.get('a') is not None:
        authors.append(field_100.get('a'))
    else:
        authors.append(None)

input_file_name = 'raw-data/yale/bib_20250706_full_000_00.xml'
map_xml(process_record, input_file_name)

df = pd.DataFrame({'id': ids, 'title': titles, 'author': authors})
print(f'Extracted {len(df)} records')
print(df.head())
```

Here we import pandas package with an alias name `pd`, that is the usual way to use it. We initialize two lists, one for the identifiers, and one for the titles. In the `process_record` function we extract their values from the record object, and append the value to the appropriate lists. At the end we create a pandas data frame with a dictionary. The keys are the column names (id and title), the values are the two lists. Here both MARC21 data elements are quasi mandatory elements, they are available in every record. For other elements, we should be sure if the record has them, and if not, we should provide a default value, e.g. an empty string or `None` value. In the last line we simply make a check, print out the first five rows of the data frame to be sure that the process finished with the result we expected.

There are other approaches to add records to a data frame, e.g. to create an empty data frame at the beginning of the process, and add new rows with `pd.append` or `pd.loc`, however these approaches have their disadvantages regarding speed and memory usage, so they are discouraged.

As the result of running the script **you should see** a count of records (somewhere in the tens of thousands for a Yale shard) and a preview of the first five rows. Some rows will have `None` (rendered as `NaN`) in the `author` column. These are records where field `100$a` was absent.

This works, but it has a problem: `ids`, `titles`, and `authors` are loose variables that `process_record` reaches into. If we want to run the same extraction on a different file, we have to remember to reset the lists, and `process_record` only works in a context where those lists already exist. The fix is to wrap everything together into one function, which we'll do once we've added subjects.

##### Repeatable fields: one record, many values

As mentioned above this strategy works well for non repeatable data elements. However in MARC21 there are data elements that could be used multiple times in the same records. Subject headings are the clearest example: a book might have one subject, or ten. This breaks the [tidy data](https://r4ds.hadley.nz/data-tidy.html#sec-tidy-data) assumption that each row is one observation and each cell holds one value.

There are two reasonable ways to handle repeating values:

- **Concatenate them into one cell**, separated by a delimiter character. Each record stays as one row.
- **Build a separate DataFrame** with one row per subject heading, linked back to the record by ID.

Again: it is up to your research question which fits better. If you want only to search if a given subject headings appear in a record, concatenated subject might be enough, if you would like to do statistics on the individual subjects or the correlation of them with other data elements (e.g. comparing them with the title words), the second approach looks better. Later in this lesson we'll use the first approach, joining a record's subject headings with the `|` (pipe) character. It keeps the DataFrame at one row per record, which makes everything else simpler. In this section however we show both approaches.

PyMARC's `record.subjects` property is a convenience that pulls all MARC fields commonly used for subject headings (the `6xx` fields) into one list. The actual heading text lives in subfield `$a`, but `$a` is not guaranteed to be present, so we check before appending.


The _concatenation_ approach:

```python
from pymarc import map_xml
import pandas as pd

data = {
    'id': [],
    'title': [],
    'subject': []
}

def process_record(record):
    id = record.get('001').value()
    data['id'].append(id)
    data['title'].append(record.title)
    subjects = []
    for subject in record.subjects:
        if subject.get('a') is not None:
            subjects.append(subject.get('a'))
    subject_str = "|".join(subjects) if len(subjects) > 0 else ""
    data['subject'].append(subject_str)

input_file_name = 'raw-data/yale/bib_20250706_full_000_00.xml'
map_xml(process_record, input_file_name)

df = pd.DataFrame(data)
print(df.head())
```

Here we create a dictionary where the keys match the column names, the values are empty lists. When we process a record we append these lists. The identifier and the title are the same as above. For subjects we create a new list. PyMarc provide a `subjects` property for the record object, and it collects the following MARC21 fields: 600, 610, 611, 630, 648, 650, 651, 653, 654, 655, 656, 657, 658, 662, 690, 691, 696, 697, 698, 699. The actual subject headings can be found in `$a` subfield, but we should be prepared that it is not always available, so we add only the real values (otherwise our list might contain `None` values for those fields that lack `$a`). After collecting all subjects into this list, we concatenate them separated by a `|` (pipeline) character, or if the record doesn't have any subject we provide an empty string. Finally we add this string to our subject list. As we have collected all values into a dictionary, we can use that directly in the data frame creation.

The other approach is to _create a distinct data frame_ for the subjects (or other repeatable data elements, such as the list of contributors). 

```python
from pymarc import map_xml
import pandas as pd

titles = {
    'id': [],
    'title': []
}
subjects = {
    'id': [],
    'subject': []
}

def process_record(record):
    id = record.get('001').value()
    titles['id'].append(id)
    titles['title'].append(record.title)
    for subject in record.subjects:
        if subject.get('a') is not None:
            subjects['id'].append(id)
            subjects['subject'].append(subject.get('a'))

input_file_name = 'raw-data/yale/bib_20250706_full_000_00.xml'
map_xml(process_record, input_file_name)

df_titles = pd.DataFrame(titles)
df_subjects = pd.DataFrame(subjects)
print(df_subjects['subject'].value_counts().head())
```

Here we create two dictionaries, one for the titles, and one for the subjects. We have to test if the subject field has `$a` subfield, but we do not have to do the trick with the record level subject list. At the end we create two data frames, and thus we can run statistical analysis, such as listing the top subject headings with `value_counts()`. One can imagine a data frame as a list of Series objects each representing an individual column. Series' `value_counts()` method counts the occurrences of individual values, and sorts it by descending number, so `head` shows the most frequent subject headings.

#### Data analysis

So far we have extracted records from a single file and seen two ways to handle repeatable fields. Now we'll put that extraction on a reusable footing and use it to ask a comparative question: given two catalogues, how does each describe the same kind of material? To get there we'll build three small functions that work together, then apply them across two files:

1. **`extract_to_dataframe`** turns one or more MARCXML files into a DataFrame.
2. **`headings_matching`** finds all subject headings in a DataFrame that mention a given keyword.
3. **`compare_sets`** takes two sets and reports what's shared and what's only on one side.

##### Function 1: `extract_to_dataframe`

Wrapping the whole extraction in a function lets us reuse it: each call takes a file path and returns a fresh DataFrame, so we can run it on as many files as we like. This function also adds subject extraction to the fields we pulled earlier.

```python
from pymarc import map_xml
import pandas as pd

def extract_to_dataframe(*file_paths):
    """Read one or more MARCXML files. Return a DataFrame with one row
    per record and columns: id, title, author, subjects (pipe-separated)."""
    rows = []

    def process_record(record):
        field_100 = record.get('100')
        if field_100 is not None and field_100.get('a') is not None:
            author = field_100.get('a')
        else:
            author = None

        subject_values = [s.get('a') for s in record.subjects if s.get('a') is not None]

        rows.append({
            'id': record.get('001').value(),
            'title': record.title,
            'author': author,
            'subjects': '|'.join(subject_values),
        })

    for path in file_paths:
        map_xml(process_record, path)

    return pd.DataFrame(rows)
```

A note on the signature: the `*file_paths` parameter (with the asterisk) lets the function take any number of paths, so `extract_to_dataframe('a.xml')` and `extract_to_dataframe('a.xml', 'b.xml')` both work, combining all records into one DataFrame. The bracket expression that builds `subject_values` is a [list comprehension](https://docs.python.org/3/tutorial/datastructures.html#list-comprehensions).

Try it on one file:

```python
df = extract_to_dataframe('raw-data/yale/bib_20250706_full_000_00.xml')
print(f'Extracted {len(df)} records')
df.head()
```

**You should see** a record count and a four-column preview: `id`, `title`, `author`, `subjects`. The `subjects` column holds pipe-separated strings. With the records in a DataFrame, we can start asking questions of them.

##### Asking a question of the collection

We now have a DataFrame, which means we can start asking what the catalogue contains: publication date distribution, author concentration, language coverage, and so on. We'll work through one example, counting records that use subject headings the Library of Congress has recently revised.

LCSH is a living vocabulary. Headings get added, retired, and renamed as cataloguing practice evolves; the Library of Congress publishes the [approved changes](https://classweb.org/approved-subjects/) on a rolling basis. Notable examples: "Aliens" became "Noncitizens", "Slaves" became "Enslaved persons", and "McKinley, Mount" became "Denali, Mount". How many records in our data still carry the older or revised forms?

Pandas' `.str.contains()` filters a string column by whether each value contains a substring; calling `.sum()` on the resulting True/False Series counts the matches:

```python
lc_changes = ['McKinley, Mount', 'Enslaved persons', 'Noncitizen']

for change in lc_changes:
    count = df['subjects'].str.contains(change, na=False).sum()
    print(f'{change}: {count} records')
```

**You should see** a count per term, some common, others rare or zero depending on what this shard contains and which form its records use.

A caveat: this counts substring matches, so it tells you a term is present, not whether it is current or why a cataloguer chose it. The technique is general, though: `.str.contains()` plus `.sum()` counts matches for any pattern in any column.

##### Comparing two datasets

Looking at one dataset is useful. Comparing two is often more useful: *how does another catalogue describe the same kind of material?*

A librarian benchmarking her catalogue against a national bibliography asks this to find cataloguing gaps. A researcher studying vocabulary change asks it to see how practice differs across institutions. The underlying computational move is the same: filter both datasets by a topic, then compare the subject headings each side uses.

For this example we'll treat the two Yale shards as two different catalogues. Since `extract_to_dataframe` accepts any file path, we can build two DataFrames simply by calling it twice:

```python
df_a = extract_to_dataframe('raw-data/yale/bib_20250706_full_000_00.xml')
df_b = extract_to_dataframe('raw-data/yale/bib_20250706_full_000_01.xml')

print(f'Catalogue A: {len(df_a)} records')
print(f'Catalogue B: {len(df_b)} records')
```

To compare them, we need two more functions.

##### Function 2: `headings_matching`

This function takes a DataFrame and a keyword, and returns the set of subject headings used on records that mention that keyword.

```python
def headings_matching(df, keyword):
    """Return the set of subject headings used on records whose
    subjects column contains the keyword."""

    matching = df[df['subjects'].str.contains(keyword, na=False)]

    headings = set()
    for subjects_str in matching['subjects']:
        headings.update(subjects_str.split('|'))

    return headings
```

The function does three things in order: filter the DataFrame to rows matching the keyword, split each row's pipe-separated subjects string into individual headings, and collect them into a set. A set is the right data structure here because it removes duplicates automatically (the same heading appearing in many records counts once) and because we'll want to use set operations to compare two of them.

Try it:

```python
headings_a = headings_matching(df_a, 'Immigra')
headings_b = headings_matching(df_b, 'Immigra')

print(f'Catalogue A uses {len(headings_a)} distinct headings on immigration records')
print(f'Catalogue B uses {len(headings_b)} distinct headings on immigration records')
```

**You should see** two counts. These are the *vocabularies* each catalogue uses around immigration: every distinct subject heading that appears on a record mentioning "Immigra".

##### Function 3: `compare_sets`

This function takes two sets and returns a dictionary describing how they overlap: what's in both, what's only in the first, what's only in the second.

```python
def compare_sets(set_x, set_y):
    """Compare two sets. Return a dict with three keys:
    shared (in both), only_in_x, and only_in_y."""

    return {
        'shared':    set_x & set_y,
        'only_in_x': set_x - set_y,
        'only_in_y': set_y - set_x,
    }
```

The function is short because Python's set operators do the heavy lifting: `&` returns the intersection, and `-` returns the difference.

Putting the pieces together:

```python
result = compare_sets(headings_a, headings_b)

print(f'Shared headings:     {len(result["shared"])}')
print(f'Only in catalogue A: {len(result["only_in_x"])}')
print(f'Only in catalogue B: {len(result["only_in_y"])}')

print('\nSample headings only in catalogue A:')
for h in sorted(result['only_in_x'])[:5]:
    print(f'  - {h}')
```

**You should see** counts followed by a few example headings unique to catalogue A. The asymmetric differences (the "only in" sets) are usually the interesting numbers, they tell you where the two catalogues diverge in vocabulary.

Each function is useful on its own. `compare_sets` works on any two sets, not just sets of headings. `headings_matching` works on any DataFrame with a pipe-separated `subjects` column, not just Yale's. If you wanted to compare three catalogues instead of two, or compare authors instead of subjects, you'd reuse most of these pieces unchanged.

We now have three numbers describing how two catalogues overlap: what they share, and what's unique to each side. Numbers like these are easier to grasp at a glance when they're drawn rather than printed, which is where visualisation comes in.

#### Visualization: Creating a Venn diagram

A good data visualization that summarises numbers helps someone to realise trends and important features of a collection of data. [Above](#function-3-compare_sets) we saw how to calculate the difference of two sets of subject headings. Based on previously defined functions our code was this:

```python
headings_a = headings_matching(df_a, 'Immigra')
headings_b = headings_matching(df_b, 'Immigra')

result = compare_sets(headings_a, headings_b)
```

The `result` is a dictionary with three keys each containing a set. The keys are `shared`, `only_in_x` and `only_in_y`.

We would like to display two circles that have an intersection if they share subjects, and are proportional to the number of subjects they contain. We also like to display the shared subject headings. Fortunately there is a library for this task, and it supports Venn diagrams for comparing two or three sets. It is called [matplotlib_venn](https://pypi.org/project/matplotlib-venn/), an extension of matplotlib, so we can use pyplot's toolbox. We also need [textwrap](https://docs.python.org/3/library/textwrap.html), a standard library for text wrapping and filling. We will use it in image annotation. We need to import these libraries:

```python
import matplotlib.pyplot as plt
from matplotlib_venn import venn2
import textwrap
```

To create the diagram is pretty simple:

```python
venn2([headings_a, headings_b], ('Catalogue 1', 'Catalogue 2'))
plt.savefig('fig_output/venn-diagram-v1.png')
plt.close()
```

It gives the colorized Venn diagram. The circles and its intersection contain the number of subjects, but not the subjects themselves:

{% include figure.html filename="en-or-enablar-lesson-5-03.png" alt="Visual description of figure image" caption="Figure 1. Venn diagram - initial version" %}

However as the library is based on pyplot, we can add an annotation with `plt.annotate()`. We can create a text box somewhere around the circles, and list the subjects there. There is a problem though: we can transform the list of subjects into a text separated by new lines or by commas, but if they have several elements the annotation will be too high or wide. So we are going to apply textwrap's [fill()](https://docs.python.org/3/library/textwrap.html#textwrap.fill) function that creates a text with maximum N character wide lines.

With that we can create an annotated Venn diagram:

```python
venn_diagram = venn2([headings_a, headings_b], ('Catalogue 1', 'Catalogue 2'))
plt.annotate(
    text=textwrap.fill(', '.join(result["shared"]), width=90),
    xy=venn_diagram.get_label_by_id('11').get_position() - np.array([0, 0.05]),
    xytext=(-150,-150),
    ha='left',
    textcoords='offset points',
    bbox=dict(
        boxstyle='round,pad=0.5',
        fc='gray',
        alpha=0.1),
    arrowprops=dict(
        arrowstyle='->',
        connectionstyle='arc3,rad=0.5',
        color='gray'
    )
)
plt.savefig('fig_output/venn-diagram-v2.png', bbox_inches='tight')
plt.close()
```

`venn2()` returns an object representing the diagram, and we can manipulate it by changing labels, colors, line width etc. Now we only want to read the position of the label of the intersection of the two circles. We can access it via `get_label_by_id` passing the identifier `11` that refers to the intersection (the first circle is represented by `10`, and by `01` the second). [plt.annotate](https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.annotate.html#matplotlib.axes.Axes.annotate) provides a number of properties. `xy` is the point we want to annotate, `text` contains the annotation text, `xstext` provides a position of the annotation, `textcoords` specifies how this position should be interpreted (here `offset points` means that xytext is a relative position from the annotated point), and `ha` instructs the horizontal alignment. With `bbox` we set the style of the bounding box: it should have a gray foreground color, rounded corner, and a bit opacity. Similarly, `arrowprops` sets the style of the arrow from the annotation to the annotated point, this time is a one direction, grey, curved arrow. As during the previous plot creations we save the plot with a narrow margin and remove references.

The final result will look like this:

{% include figure.html filename="en-or-enablar-lesson-5-04.png" alt="Visual description of figure image" caption="Figure 2. Venn diagram - improved version with annotation" %}

### Summary


## Local application
### Apply this method
### Other projects
### Continued learning


