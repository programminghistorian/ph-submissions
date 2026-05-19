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

So now we have a single `process_record` function that can behave the same even when we process  binary, xml or large xml files. We change this to extract particular data elements (identifier and title) from each MARC21 record, then to build a pandas data frame.

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

Here we import pandas package with an alias name `pd`, that is the usual way to use it. We initialize two lists, one for the identifiers, and one for the titles. In the `process_record` function we extract their values from the record object, and append the value to the appropriate lists. At the end we create a pandas data frame with a dictionary. The keys are the column names (id and title), the values are the two lists. Here both MARC21 data elements are quasi mandatory elements, they are available in every record. For other elements, we should be sure if the record has them, and if not, we should provide a default value, e.g. an empty string or `None` value. In the last line we simply make a check, print out the first five rows of the data frame to be sure that the process finished with the result we expected.

There are other approaches to fulfill this task, e.g. to create an empty data frame at the beginning of the process, and add new rows with `pd.append` or `pd.loc`, however these approaches have their disadvantages regarding speed and memory usage, so they are discouraged.

As mentioned above this strategy works well for non repeatable data elements. However in MARC21 there are data elements that could be used multiple times in the same records, for example a book might have multiple subjects. Here we have two options: either join them together with a separator character into the same cell, or save them to another dataframe. Again: it is up to your research question which fits better. If you want only to search if a given subject headings appear in a record, concatenated subject might be enough, if you would like to do statistics on the individual subjects or the correlation of them with other data elements (e.g. comparing them with the title words), the second approach looks better.

The concatenation approach:

```Python
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

Here we create a dictionary where the keys match the column names, the values are empty lists. When we process a record we append these lists. The identifier and the title are the same as above. For subjects we create a new list. PyMarc provide a `subjects` property for the record object, and it collects the following MARC21 fields: 600, 610, 611, 630, 648, 650, 651, 653, 654, 655, 656, 657, 658, 662, 690, 691, 696, 697, 698, 699. The actual subject headings can be found in `$a` subfield, but we should be prepared that it is not always available, so we add only the real values (otherwise our list might contain `None` values for those fields that lack `$a`). After collecting all subjects into this list, we concatenate them separated by a '|' (pipeline) character, or if the record doesn't have any subject we provide an empty string. Finally we add this string to our subject list. As we have collected all values into a dictionary, we can use that directly in the data frame creation. 

The other approach is to create a distinct data frame for the subjects (or other repeatable data elements, such as the list of contributors). 


```Python
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

Here we create two dictionaries, one for the titles, and one for the subjects. We have to test if the subject field has `$a` subfield, but we do not have to do the trick with the record level subject list. At the end we create two data frames, and thus we can run statistical analysis, such as listing the top subject headings with `value_counts()`. Pandas one can imagine a data frame as a list of Series objects each representing an individual column. Series' `value_counts()` method counts the occurrences of individual values, and sorts it by descending number, so `head` shows the most frequent subject headings.

#### Data harmonisation

One of the most frequently utilised data elements in bibliographic data science is date of publication. It is usually a year (or range of years), and is the basis of any chronological analysis, answering questions such as how feature X changed through times, where X might be the subjects, language, format, authors and other features of the book. The value of the year of publication in MARC21 records however is not a normalised date, so we should apply some transformation to extract a numeric value. On the other hand the normalisation is relatively easier than that of personal or geographic names. In the code we do not provide a very sophisticated solution. For that we suggest you check and adapt the bibliographica  package's [polish_years](https://github.com/COMHIS/bibliographica/blob/master/R/polish_years.R) function written in R language by Leo Lahti, Hege Roivainen, Niko Ilomaki, and Mikko Tolonen.

In this approach we will check some typical formats with regular expressions. Then we pass the extracted value to the [Undate package](https://undate-python.readthedocs.io/en/latest/index.html) written by Cole Crawford, Rebecca Sutton Koeser, Robert Casties, Julia Damerow, Malte Vogl, Taylor Arnold and Klaus Rettinghaus. This package could accept different date formats, but if the input is not recognisable it throws an exception -- helping us to filter out those dates that don't fit to any format, and using this as a feedback to improve our regular expressions.

```Python
from pymarc import map_xml
import pandas as pd
import re
from collections import Counter
from undate import Undate

success_counter = Counter()
date_counter = Counter()

regexes = [
    re.compile(r'^c?(\d{4})[\.-]?$'),
    re.compile(r'^\[c?(\d{4})\??\]$'),
    re.compile(r'^(\d{4}), c\d{4}\.$'),
    re.compile(r'^\[(\d{4}), c\d{4}\]$'),
    re.compile(r'^c?(\d{4})\??\]$'),
    re.compile(r'^(\d{4})-\d{4}\.$'),
                                      # these are fallback regexes
    re.compile(r'^.*?(\d{4}).*$'),    # any four numbers
    re.compile(r'^.*?(\d{3}-).*?$'),  # three numbers and a dash
    re.compile(r'^.*?(\d{2}--).*?$'), # two numbers and two dashes
]

def process_record(record):
    id = record.get('001').value()
    date_original = record.pubyear
    if date_original is not None:
        date_cleaned = date_original.strip()
        reg_found = False
        for reg in regexes:
            if not reg_found:
                m = reg.match(date_cleaned)
                if m is not None:
                    reg_found = True
                    date_cleaned = m.group(1)
                    break
        if "-" in date_cleaned:
            date_cleaned = re.sub("-", "0", date_cleaned)

        try:
            date_undate = Undate(date_cleaned)
            success_counter.update([True])
        except ValueError as e:
            success_counter.update([False])
            date_counter.update([re.sub("\\d", 'D', date_cleaned)])

input_file_name = 'raw-data/yale/bib_20250706_full_000_00.xml'
map_xml(process_record, input_file_name)

print(success_counter)
print(date_counter.most_common(10))
```

We have to import the constructure (`Undate`) from undate package, and create two counters: `success_counter` will could the number of recognised and unrecognised dates, and `date_counter` will count the number of occurrences of unhandled patterns. `record.pubyear` is a similar alias property as `record.subjects` that we saw earlier -- it returns [260$c](https://www.loc.gov/marc/bibliographic/bd260.html) or [264$c](https://www.loc.gov/marc/bibliographic/bd264.html). We remove leading and trailing white spaces with `trim()`, then iterate over the regular expression. The first one that matches will extract the first group of the match. In regex one can create referencable groups with the parentheses, e.g. `r'^c?(\d{4})[\.-]?$'` will match a string that starts with one or zero 'c' character, that is followed by four numbers, and finally ends with an optional dot or dash character. The four number is in parenthesis, so we can access it as the first group (`group(1)`). The order of the regular expression is important, here on the top of the list we have very specific expressions, while the last three match numbers anywhere in the string. In MARC21 when the date is not well known cataloguers uses dash character, so "198-" means that the book has been published in the 1980-es, "19--" means that the book has been published in the 20th century. Now we just simply replace dashes with zeros, so we set the earliest possible year. There might be different approaches for that, and with undate we can set the level of precision such as century, decade etc. When we cleaned the date, we run the test with undate: if it successful, we get a new object, and we can register that the transformation was successful, otherwise undate throws and exception that we catch, then increase the number of failures, and count the failed patterns. This later one is not a regular expression, but close to it: we just replace numbers with 'D' (referring to any digits).

After processing all records, we print out the number of successes and failures and the top 10 most frequent patterns. Data harmonisation is almost always an iterative process, from based on the output we extend the list of regular expressions (either the specific or the generic ones) up to the point we feel it worth. There is a chance that there are lots of variations that occur very infrequently (or even only once). You can even add some examples or log record identifiers along with the collected patterns if the pattern itself does not help to understand the situation.

#### Data analysis and visualization

##### Place and personal names
##### Dates
##### Subjects
This is work in progress. Subject to Change. It follows the Data Acquisition Section.

# Preprocessing MARCXML with PyMARC and Pandas

In the previous section we downloaded MARCXML files from Yale's catalogue and decompressed them into the `raw-data/yale/` directory. This section picks up from there: we'll turn those XML files into a Pandas DataFrame and use it to ask questions about what the collection contains.

## What we're building

By the end of this section you'll have three small reusable functions that work together:
1. **`extract_to_dataframe`** turns one or more MARCXML files into a DataFrame.
2. **`headings_matching`** finds all subject headings in a DataFrame that mention a given keyword.
3. **`compare_sets`** takes two sets and reports what's shared and what's only on one side.

Each function does one thing. Together they let us ask comparative questions across catalogues without writing complicated code.

We'll work through:

1. Reading a MARCXML file one record at a time with PyMARC
2. Extracting four fields, record ID, title, author, and subject headings
3. Handling subjects, which can repeat within a single record
4. Wrapping extraction in a reusable function so the same logic runs on any MARCXML file
5. Filtering for records that mention a topic, then comparing how two catalogues describe that topic

## Why this matters: the user story

Imagine you're a metadata librarian. You want to start asking questions about what your catalogue contains, not just *is this record well-formed?* but *what does our collection actually describe?* That kind of question opens up real conversations about collection development priorities, cataloguing practice, and what gets fine-grained subject treatment versus what gets lumped together.
For this lesson we'll use Yale shards (the partitioned MARCXML files we downloaded) as toy data. It's enough to show the techniques; it's not enough to support real findings. By the end you'll be able to recognise the shape of questions this approach answers, and adapt the code to richer data of your own.

## What you need before you start
- At least one MARCXML file in `raw-data/yale/` from the data acquisition section. We'll use `bib_20250706_full_000_00.xml` and `bib_20250706_full_000_01.xml`, but any two will work, just change the file names below.
- The `pymarc` and `pandas` packages installed. If you don't have them yet:

```python
%pip install pymarc pandas
```

## Reading a MARCXML file

PyMARC offers two ways to read MARCXML:

- `parse_xml_to_array` reads the whole file into memory at once and returns a list of `Record` objects. Simple, but memory-heavy for large files.
- `map_xml` reads records one at a time and calls a function you provide on each one. Memory-friendly, and the right choice for catalogue-scale data.

Yale's bibliographic shards contain tens of thousands of records each, so we'll use `map_xml` throughout. The pattern is: write a function that takes one record and does something with it, then hand that function to `map_xml` along with the file path. `map_xml` does the rest, calling your function once per record.

Here's the smallest possible example, printing the title of every record:

```python
from pymarc import map_xml

input_file = 'raw-data/yale/bib_20250706_full_000_00.xml'

# This function will be called once for every record in the file
def process_record(record):
    print(record.title)

map_xml(process_record, input_file)
```

**You should see** a long stream of titles scrolling past, one per record. If you see nothing, check that `input_file` points to a file that actually exists on disk. If you see an error about `pymarc`, re-run the install line above.

Next we'll capture data into lists instead of printing it, and turn those lists into a DataFrame.

## Extracting non-repeatable fields into a DataFrame

The general pattern is:

1. Create an empty list for each column you want.
2. In `process_record`, append values from each record onto those lists.
3. After `map_xml` finishes, hand the lists to Pandas to construct a DataFrame.

We'll start with three fields that appear at most once per record:

- **Record ID**, MARC field `001`, the control number. Quasi-mandatory.
- **Title**, MARC field `245`. Also quasi-mandatory.
- **Author**, MARC field `100$a`, the personal name main entry. *Not* mandatory: many records (anonymous works, corporate publications, edited volumes) have no `100`. We need a defensive pattern that records `None` when it's absent.

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

input_file = 'raw-data/yale/bib_20250706_full_000_00.xml'
map_xml(process_record, input_file)

df = pd.DataFrame({'id': ids, 'title': titles, 'author': authors})
print(f'Extracted {len(df)} records')
df.head()
```

**You should see** a count of records (somewhere in the tens of thousands for a Yale shard) and a preview of the first five rows. Some rows will have `None` (rendered as `NaN`) in the `author` column. These are records where field `100$a` was absent.

This works, but it has a problem: `ids`, `titles`, and `authors` are loose variables that `process_record` reaches into. If we want to run the same extraction on a different file, we have to remember to reset the lists, and `process_record` only works in a context where those lists already exist. The fix is to wrap everything together into one function, which we'll do once we've added subjects.

## Repeatable fields: one record, many values

MARC21 allows several fields to repeat within a single record. Subject headings are the clearest example: a book might have one subject, or ten. This breaks the [tidy data](https://r4ds.hadley.nz/data-tidy.html#sec-tidy-data) assumption that each row is one observation and each cell holds one value.

There are two reasonable ways to handle repeating values:

- **Concatenate them into one cell**, separated by a delimiter character. Each record stays as one row.
- **Build a separate DataFrame** with one row per subject heading, linked back to the record by ID.

We'll use the first approach, joining a record's subject headings with the `|` (pipe) character. It keeps the DataFrame at one row per record, which makes everything else simpler.

PyMARC's `record.subjects` property is a convenience that pulls all MARC fields commonly used for subject headings (the `6xx` fields) into one list. The actual heading text lives in subfield `$a`, but `$a` is not guaranteed to be present, so we check before appending.

## Function 1: `extract_to_dataframe`

This function takes one or more file paths and returns a DataFrame with one row per record. It packages everything we've built so far, plus subject extraction, into a single self-contained call.

```python
from pymarc import map_xml
import pandas as pd

def extract_to_dataframe(*file_paths):
    """Read one or more MARCXML files. Return a DataFrame with one row
    per record and columns: id, title, author, subjects (pipe-separated)."""

    ids = []
    titles = []
    authors = []
    subjects = []

    def process_record(record):
        ids.append(record.get('001').value())
        titles.append(record.title)

        field_100 = record.get('100')
        if field_100 is not None and field_100.get('a') is not None:
            authors.append(field_100.get('a'))
        else:
            authors.append(None)

        subject_values = [s.get('a') for s in record.subjects if s.get('a') is not None]
        subjects.append('|'.join(subject_values) if subject_values else '')

    for path in file_paths:
        map_xml(process_record, path)

    return pd.DataFrame({
        'id': ids,
        'title': titles,
        'author': authors,
        'subjects': subjects,
    })
```

Two things worth noting:

- The `*file_paths` parameter (with the asterisk) lets the function accept any number of file paths. Calling `extract_to_dataframe('a.xml')` works, and so does `extract_to_dataframe('a.xml', 'b.xml', 'c.xml')`. The function loops over all paths and combines their records into one DataFrame.
- The lists (`ids`, `titles`, etc.) and `process_record` are now defined *inside* `extract_to_dataframe`. Each call starts with fresh empty lists, so you can call the function as many times as you want without leftover data from previous runs.

Try it on one file:

```python
df = extract_to_dataframe('raw-data/yale/bib_20250706_full_000_00.xml')
print(f'Extracted {len(df)} records')
df.head()
```

**You should see** a record count and a preview with four columns: `id`, `title`, `author`, `subjects`. The `subjects` column holds pipe-separated strings (or an empty string if no subjects were assigned).

## Asking a question of the collection

We now have a DataFrame, which means we can start asking what the catalogue contains. There are many directions you could take this: publication date distribution, author concentration, language coverage, format breakdowns. We'll work through one example: how many records use subject headings that the Library of Congress has recently revised.

LCSH is a living vocabulary. Headings get added, retired, and renamed as cataloguing practice evolves. Recent examples include the change from "Aliens" to "Noncitizens", the replacement of "Slaves" with "Enslaved persons", and renamings of geographic features (such as "McKinley, Mount" becoming "Denali, Mount").

The question: *how many records in our DataFrame still carry these older or recently-revised headings?* This is a starting point for a much larger conversation about how catalogues age, how vocabulary change propagates through library data, and how cataloguing decisions encode their moment. The toy data and simple technique here won't answer those questions rigorously, but they'll show you the shape of how the question gets asked.

Pandas' `.str.contains()` method filters a string column by whether each value contains a given substring. Combined with `.sum()` on the resulting boolean Series, we get a count of records matching each pattern:

```python
lc_changes = ['Gulf of', 'McKinley, Mount', 'Enslaved persons', 'Noncitizen']

print('Records with subject headings referencing each LC change:\n')
for change in lc_changes:
    # str.contains returns True/False for each row;
    # sum() counts the True values; na=False treats empty subjects as no match
    count = df['subjects'].str.contains(change, na=False).sum()
    print(f'  {change:20s} {count:6d} records')
```

**You should see** a count per term. Some will be common, others rare or zero, depending on what kinds of materials this shard contains and whether the new or old form has been adopted in the records here.

What these numbers can and can't tell you is worth being careful about. A high count for an old heading doesn't mean the catalogue is "behind", large catalogues legitimately carry decades of records, and retroactive vocabulary updates are expensive. A low count for a new heading might mean the records pre-date the change, or that the catalogue updated promptly. The technique only counts substring matches; it doesn't distinguish "the heading is current" from "the heading was the only option at the time of cataloguing" from "the cataloguer chose not to apply the new form."

What the technique *does* show is the shape of how you'd ask. `.str.contains()` filters a column by pattern; `.sum()` on the resulting boolean Series counts matches. The same two-move composition works for any pattern in any column.

## Comparing two datasets

Looking at one dataset is useful. Comparing two is often more useful: *how does another catalogue describe the same kind of material?*

A librarian benchmarking her catalogue against a national bibliography asks this to find cataloguing gaps. A researcher studying vocabulary change asks it to see how practice differs across institutions. The underlying computational move is the same: filter both datasets by a topic, then compare the subject headings each side uses.

For this example we'll treat the two Yale shards as two different catalogues. Since `extract_to_dataframe` accepts any file path, we can build two DataFrames simply by calling it twice:

```python
df_a = extract_to_dataframe('raw-data/yale/bib_20250706_full_000_00.xml')
df_b = extract_to_dataframe('raw-data/yale/bib_20250706_full_000_01.xml')

print(f'Catalogue A: {len(df_a)} records')
print(f'Catalogue B: {len(df_b)} records')
```

To compare them, we need two more small functions.

## Function 2: `headings_matching`

This function takes a DataFrame and a keyword, and returns the set of subject headings used on records that mention that keyword.

```python
def headings_matching(df, keyword):
    """Return the set of subject headings used on records whose
    subjects column contains the keyword."""

    matching = df[df['subjects'].str.contains(keyword, na=False)]

    headings = set()
    for subjects_str in matching['subjects']:
        if subjects_str:
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

## Function 3: `compare_sets`

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

The function is short because Python's set operators do the heavy lifting: `&` returns the intersection, and `-` returns the difference. The function just gives those operations clear names and bundles them together.

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

## Why three small functions

Each function does one thing, named honestly:

- `extract_to_dataframe` reads MARCXML and returns a DataFrame.
- `headings_matching` filters a DataFrame and returns a set of headings.
- `compare_sets` compares two sets.

Together they compose into the workflow we just walked through, but each piece is also useful on its own. `compare_sets` works on any two sets, not just sets of headings. `headings_matching` works on any DataFrame with a pipe-separated `subjects` column, not just Yale's. If you wanted to compare three catalogues instead of two, or compare authors instead of subjects, you'd reuse most of these pieces unchanged.

To investigate a different topic, only the keyword changes:

```python
headings_a = headings_matching(df_a, 'Climate')
headings_b = headings_matching(df_b, 'Climate')
result = compare_sets(headings_a, headings_b)
```

#### Dissemination of results

Publication of software and research data for reuse.

### Summary


## Local application
### Apply this method
### Other projects
### Continued learning

## Endnotes
