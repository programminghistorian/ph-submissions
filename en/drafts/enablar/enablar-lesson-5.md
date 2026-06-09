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

Here we create a dictionary where the keys match the column names, the values are empty lists. When we process a record we append these lists. The identifier and the title are the same as above. For subjects we create a new list. PyMarc provide a `subjects` property for the record object, and it collects the following MARC21 fields: 600, 610, 611, 630, 648, 650, 651, 653, 654, 655, 656, 657, 658, 662, 690, 691, 696, 697, 698, 699. The actual subject headings can be found in `$a` subfield, but we should be prepared that it is not always available, so we add only the real values (otherwise our list might contain `None` values for those fields that lack `$a`). After collecting all subjects into this list, we concatenate them separated by a `|` (pipeline) character, or if the record doesn't have any subject we provide an empty string. Finally we add this string to our subject list. As we have collected all values into a dictionary, we can use that directly in the data frame creation.

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

##### Subjects
This is work in progress. Subject to Change. It follows the Data Acquisition Section.
##### Place and personal names

##### Dates


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

##### Preprocessing MARCXML with PyMARC and Pandas

In the previous section we downloaded MARCXML files from Yale's catalogue and decompressed them into the `raw-data/yale/` directory. This section picks up from there: we'll turn those XML files into a Pandas DataFrame and use it to ask questions about what the collection contains.

##### What we're building

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

##### Why this matters: the user story

Imagine you're a metadata librarian. You want to start asking questions about what your catalogue contains, not just *is this record well-formed?* but *what does our collection actually describe?* That kind of question opens up real conversations about collection development priorities, cataloguing practice, and what gets fine-grained subject treatment versus what gets lumped together.
For this lesson we'll use Yale shards (the partitioned MARCXML files we downloaded) as toy data. It's enough to show the techniques; it's not enough to support real findings. By the end you'll be able to recognise the shape of questions this approach answers, and adapt the code to richer data of your own.

##### What you need before you start
- At least one MARCXML file in `raw-data/yale/` from the data acquisition section. We'll use `bib_20250706_full_000_00.xml` and `bib_20250706_full_000_01.xml`, but any two will work, just change the file names below.
- The `pymarc` and `pandas` packages installed. If you don't have them yet:

```python
%pip install pymarc pandas
```

##### Reading a MARCXML file

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

##### Extracting non-repeatable fields into a DataFrame

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

##### Repeatable fields: one record, many values

MARC21 allows several fields to repeat within a single record. Subject headings are the clearest example: a book might have one subject, or ten. This breaks the [tidy data](https://r4ds.hadley.nz/data-tidy.html#sec-tidy-data) assumption that each row is one observation and each cell holds one value.

There are two reasonable ways to handle repeating values:

- **Concatenate them into one cell**, separated by a delimiter character. Each record stays as one row.
- **Build a separate DataFrame** with one row per subject heading, linked back to the record by ID.

We'll use the first approach, joining a record's subject headings with the `|` (pipe) character. It keeps the DataFrame at one row per record, which makes everything else simpler.

PyMARC's `record.subjects` property is a convenience that pulls all MARC fields commonly used for subject headings (the `6xx` fields) into one list. The actual heading text lives in subfield `$a`, but `$a` is not guaranteed to be present, so we check before appending.

##### Function 1: `extract_to_dataframe`

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

##### Asking a question of the collection

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

To compare them, we need two more small functions.

##### Function 2: `headings_matching`

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

##### Why three small functions

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

#### Visualization

A good data visualization that summarises numbers helps someone to realise trends and important features of a collection of data. We will see how we can create plots out of what we have calculated so far. First we see how to draw timelines, and then we see a Venn diagram as well. 

##### Preparation

First we check how the number of subject headings changed over time. Here we extend a bit the extraction of subjects and dates. First we import the necessary Python modules.

```Python
from pymarc import map_xml
import pandas as pd
from undate import Undate
import re
from collections import Counter
import os
import numpy as np
import matplotlib.pyplot as plt
import glob
```
We have imported the following new libraries:

* [numpy](https://numpy.org/) is used in scientific computing mainly for numerical operation. Here we use only one feature: it defines data types that Pandas can use. Its frequently used abbreviation is np.
* [matplotlib.pyplot](https://matplotlib.org/3.5.3/api/_as_gen/matplotlib.pyplot.html) is one of the popular plotting libraries. Its frequently used abbreviation is plt.
* [glob](https://docs.python.org/3/library/glob.html) (part of code Python) provides Unix style pathname pattern expansion

Then we define functions to process a single MARC21 record. We would like to extract two pieces of  information: the publication year and the number of subjects. For these we define two functions: `extract_subjects` that returns the distinct subjects a record has, and `extract_date` that extracts the publication year.

```Python
def process_record(record):
    data['subject_count'].append(len(extract_subjects(record)))
    data['date'].append(extract_date(record))
```

`len()` returns the number of elements of its argument. It can be used for any type of collections: arrays, lists, dictionaries, even Pandas. The subject extraction function is familiar: it is nothing else than a simplified version of what we already saw. To return only distinct subjects, we collected them into a set, and _per definitionem_ stores only distinct values -- we do not have to check ourselves is the element is already there:

```Python
def extract_subjects(record):
    subjects = set()
    for subject in record.subjects:
        if subject.get('a') is not None:
            subjects.add(subject.get('a'))
    return subjects
```

The bulk of the date extraction function might be also familiar, however this time we are not interested in knowing the irregular date strings or its statistics. We check if the date cleaned with regular expressions fits to Undate, and return it after converting (or to say it Pythonic: casting) to integer. If such a check fails or the record does not have a publication year field at all it returns `None` -- this way we always return something, and ensure that the two lists of the data collector used in the record processing function have the same number of elements.

```Python
def extract_date(record):
    date = None
    if record.pubyear is not None:
        date_cleaned = record.pubyear.strip()
        reg_found = False
        for reg in regs:
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
            date = int(date_cleaned)
        except ValueError as e:
            pass
    return date
```

After defining the functions, let's see the main part of the process. First we define our data collector: a dictionary with two keys: `subject_count` and `date` -- we already saw how `process_record` fill these lists with values. The `output_file_name` contains the name of the file into which we save the data. 

```Python
data = {
    'subject_count': [],
    'date': []
}

output_file_name = 'data_output/year-subject-count.csv'
```

And here is a trick: since processing XML files take much longer time than visualizing the data we make a cache. If the cache file (`output_file_name`) does not exist we extract the data from each available XML file, create a Pandas data frame, and save the result into a CSV file. If we already have created the file, we do not process XMLs again, just read the CSV.

```Python
if not os.path.isfile(output_file_name):
    hits = glob.glob(os.path.join('raw-data', 'yale', "bib_20250706_full_00?_0?.xml"))
    for input_file_name in sorted(hits):
        print(input_file_name)
        map_xml(process_record, input_file_name)

    df = pd.DataFrame(data)
    df = df.dropna(how="any")
    df['date'] = df['date'].astype('In16')

    df.to_csv(output_file_name, index = False) # do not 
else:
    df = pd.read_csv(output_file_name, dtype=np.int16)
```

There are some new things in this code snippet:
* `glob.glob()` uses Unix style file and directory name patterns, so you can use the wildchars ?, . and * to find files. It returns a list, that we sort by name and process each file one by one.
* after we create the dataframe we remove those rows that have NAs. Remember that we gave `None` when the publication year was missing or wrong, this line removes them. Then we convert the date to 16 bit long integer values.
* `to_csv()` saves the content of a data frame into a CSV file. `index = False` prevents writeing the row names (the data frame index) into the file. Unfortunately, the default value of this argument is True, which makes CSV a bit weird.
* `read_csv()` is the opposite of `to_csv()`: it created a data frame from a CSV. With `dtype=np.int16` we ensure that each number in it is a 16 bit long integer.

Now we have a data frame, however depending on how many XML files you downloaded and extracted the distribution might be highly unequal. As the first files contain more records about publications from the 20th century, we extract a subset:

```Python
year_min = 1950
year_max = 1995
df = df[(df["date"] >= year_min) & (df["date"] <= year_max)]
```
##### Creating line charts

Finally we start the visualization! It is interesting how subjects are assigned to individual records, and how it changed over the time. We have to calculate it by:

```Python
yearly_mean = df.groupby(['date']).agg('mean')
```

`groupby` creates subgroups within the data frame. As here we use `date`, we will group the records by publication dates. `agg` runs an aggregation function -- a calculation -- on each group. With it we calculate the average number of subject headings per year. The result is another data frame of which the index is the publication year, and it will have one more column: its name remains `subject_count`, but its value became the yearly average of it.

This is the data frame we want to visualize as a line chart, with the publication year on the x (horizontal) axis and the yearly average on the y (vertical) axis. We use pltotlib's functions (using its usual abbreviation `plt`).

```Python
plt.plot(yearly_mean)
plt.title('average number of subjects per record')
plt.xlabel('publication year')
plt.grid(True)
plt.axis((year_min, year_max, 0, max(yearly_mean['subject_count']) * 1.1))
plt.savefig(os.path.join('fig_output', 'mean-subjects-per-year.png'), bbox_inches='tight')
plt.close()
```

`plt.plot()` takes a data frame and draws a line chart. It utilizes the dataframe index for the x values, and all other columns for y values. Each column will be represented as a distinct line with distinct color. It gives us the basic image, but we would like to add additional attributes. `title()` sets a title, `xlabel()` sets an explanation for the horizontal axis, `grid()` draws grid lines. With `axis()` we specify the 'viewport' of the chart. We gave a list of four values: the beginning and the end of x values, and the beginning and end of y values. If we do not give anything, the library takes the minimum and maximum values and adds some margins on all sides. Our averages range around 1.4 and 2.0, but we thought that it is more realistic to the human eye if we set the viewport to zero (and add a small margin on the top as the 10% of the maximum value). `savefig()` saves the figure; its first argument is the file name, while the `bbox_inches` argument sets a minimal margin around the chart. `close()` is an important step when you draw multiple images in one script: it starts a clearing process, removes references from the memory, so the new image will start from scratch, otherwise -- as pyplot image creation is a statefull process, so it "remembers" previous steps -- there is a chance that different graphical elements will survive in other images.

The image looks like this:

<!-- mean-subjects-per-year.png -->
[Figure 1]

Sometimes we would like to put two charts side by side, because we would like to compare them, or because they express different sides of the same phenomenon. Right now we know the average numbers, but how many records don't have at all any subject headings? As the number of records per year are not equal, we are interested in both the absolute numbers and the ratio. If we put multiple charts on the same image, we should take care of both the overarching image and the individual charts (they are called subplots or Axes).

Start, as always, with calculation:

```Python
yearly_counts = df.groupby(['date']).count()
yearly_no_subject = df[df['subject_count'] == 0].groupby(['date']).count()

df_merged = (pd.merge(
    yearly_counts.rename(columns={'subject_count': 'total'}), 
    yearly_no_subject.rename(columns={'subject_count': 'missing'}), 
    on='date'))
df_merged['percent'] = df_merged.missing * 100 / df_merged.total
```

First, we calculate the number of records per each year. We group by date as in the previous example, but we apply a different calculation: `count()`, that returns the total number. Second, we subset the data frame by selecting only the rows where the subject count is zero, then calculate the yearly count as in the previous step. Third, with `pd.merge()` join the two tables together. The connection between them is the `date` column. However, as both tables have the subject count column, we rename it to 'total' in the first table and to 'missing' in the second. Forth, we calculate the percentage of missing values.

The resulting data frame will be something like this:

```
      total  missing    percent
date                           
1950   4396      546  12.420382
1951   3235      483  14.930448
1952   3327      457  13.736099
1953   3360      475  14.136905
1954   3658      487  13.313286
```

After data preparation, we should prepare the mane image, and the subplots:

```Python
fig = plt.figure(figsize=(8.0, 6.0))
axes1 = fig.add_subplot(2, 1, 1)
axes2 = fig.add_subplot(2, 1, 2)
```

`figure()` creates the main image, `figsize`'s contains the width and height value in inch. We slice and dice this image with subplots, and we specify it with `add_subplot()`'s arguments: the number of rows, the number of columns and the index of the particular subplot. This time we created two rows and one column, thus `axes1` refers to the top 'cell', and `axes2` to the bottom one.

Fill the first cell!

```Python
axes1.plot(df_merged.index, df_merged.total, df_merged.missing)
axes1.legend(['all', 'without subject'])
axes1.set_title('number of records')
axes1.set_xlabel('publication year')
axes1.axis((year_min, year_max, max(df_merged['total']) * -.1, max(df_merged['total']) * 1.1))
axes1.grid(True)
```

We apply the plot not on `plt` that represents the library, but on 'axes1'. As we would like to draw multiple lines we call it differently (there are a number of ways to use the function, see [here](https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.plot.html)): we set the values for the x axis, the y values for the first line, and the y values of the second line. As we have an additional column, if we simply would add the data frame, the result will be three lines instead of two. The lines will be drawn with different, automatically assigned colors. With `legend()` we add an annotation to the image to explain what colors mean. `set_title()` and `set_xlabel()` are the subplot variants of `title()` and `xlabel()`, and we already explained `axis()` and `grid()`. As in several years the number of missing values are (visually) close to zero, we set the viewport a bit lower, shifting with 10% of the maximum value. 

Now comes the second cell:

```Python
axes2.plot(df_merged.percent)
axes2.set_title('records without subjects')
axes2.set_xlabel('publication year')
axes2.set_ylabel('percent')
axes2.axis((year_min, year_max, 0, max(df_merged['percent']) * 1.1))
axes2.grid(True)
```

Here we meet a third variation of `plot()`, we simply set only the y values, thus we ignore the two other columns in this chart. We also set a label for the horizontal axis with `set_ylabel()`.

As a final step, we set a minimalistic margin, save the image and clear it from the memory.

```Python
fig.tight_layout()
plt.savefig('fig_output/records-per-year.png')
plt.close()
```

The final image looks like this:

<!-- records-per-year.png -->
[Figure 2]

##### Creating a Venn diagram

Previously we saw how to calculate the difference of two sets of subject headings. Based on previously defined functions our code was this:

```Python
headings_a = headings_matching(df_a, 'Immigra')
headings_b = headings_matching(df_b, 'Immigra')

result = compare_sets(headings_a, headings_b)
```

The `result` is a dictionary with three keys each containing a set. The keys are `shared`, `only_in_x` and `only_in_y`. We would like to display two circles that have an intersection if they share subjects, and are proportional to the number of subjects they contain. We also like to display the shared subject headings. Fortunately there is a library for this task, and it supports Venn diagrams for comparing two or three sets. It is called [matplotlib_venn](https://pypi.org/project/matplotlib-venn/) and it is a kind of extension of matplotlib, so we can use pyplot's toolbox. We will use only on function `venn2`, so import it:

```Python
from matplotlib_venn import venn2
```

To create the diagram is pretty simple:

```Python
venn2([headings_a, headings_b], ('Catalogue 1', 'Catalogue 2'))
plt.savefig('fig_output/venn-diagram-v1.png')
plt.close()
```

It gives the colorized Venn diagram. The circles and its intersection contain the number of subjects, but not the subjects themselves:

<!-- venn-diagram-v1.png -->
[Figure 3]

However as the library is based on pyplot, we can add an annotation with `plt.annotate()`. We can create a text box somewhere around the circles, and list the subjects there. There is a problem though: we can transform the list of subjects into a text separated by new lines or by commas, but if they have several elements the annotation will be too high or wide. So we create a new function `format_lines` that mix the two separators, and create a list of maximum N character wide lines. 

```Python
def format_lines(items, max_width=60):
    """
    Arrange a list of strings into a set of lines separated by line breaks.

    Parameters                              
    ----------
    items : list
        a list of strings
    max_width : int
        the maximum width of a line in characters (default is 60)
    """
    lines = []
    line = ''
    for item in items:
        item = re.sub(r'\.$', '', item)
        if len(lines) != 0 or line != '':
            line = line + ','
        for word in item.split():
            if len(line) + len(word) > max_width:
                lines.append(line)
                line = word
            else:
                if line == '':
                    line = word
                else:
                    line = line + ' ' + word
    if line != '':
        lines.append(line)

    return '\n'.join(lines)
```
With that we can create an annotated Venn diagram:

```Python
venn_diagram = venn2([headings_a, headings_b], ('Catalogue 1', 'Catalogue 2'))
plt.annotate(
    text=format_lines(result["shared"], 60),
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

<!-- venn-diagram-v2.png -->
[Figure 4]

#### Dissemination of results

The final step in the work process is the dissemination of results, which includes traditional publication methods (papers, books, conference presentations) as well as newer approaches, such as the publication of software used in the process, the generated data, and data and software studies focusing specifically on these, blogging and microblogging, sharing presentation slides and recordings, and participating in professional organizations.

Let's start with the data. There are some dedicated 'research data repositories' that aim to help researchers to publish their data. Along with the data files you should add metadata such as title, authors, subject headings, description. From repository to repository it might be different what metadata schema you should follow and what are the mandatory and optional metadata. The repositories assign a persistent identifier to your _dataset_, such as DOI, Handle, or ark.[^1] We can mention [Zenodo](https://zenodo.org/), [Harvard Dataverse](https://dataverse.harvard.edu/), [figshare](https://figshare.com/), [Open Science Framework](https://osf.io/), [Dryad](https://datadryad.org/) as the largest general repositories, but there are a number of others with regional or domain specific focus (at time of writing we are not aware of any that provide extra functionalities for bibliographic data). You can check the [re3data](re3data.org), the registry of research data repositories, that provides a rich categorisation to find the one that fits your needs. It is also worth it to check if your institution has any recommendation of policy.

To publish the software might be a two step process. The first step is to make it publicly available in a platform such as GitHub, GitLab, or other general or institutional software depository. However you can make it further and turn the scripts into real research software with proper documentation, tests, packaging, installation scripts etc.[^2] Research data repositories are also accept research related software, and some of them are working together with software repositories, so you can connect them together, and you will get a persistent identifier for your software as well. The Research Software Engineering community published some guidelines on how to publish software in FAIR way (FAIR is an acronym for Findable, Accessible, Interoperable and Reusable)[^3].

Finally, we would like to call attention to the importance of a special data sharing called 'data roundtrip'.[^4] Imagine the following scenario: a researcher has worked hard to enrich a popular data source with high research potential that is maintained by a public collection. Later, another researcher would like to use the same database for their research. If she is not familiar with the previous researcher's work, she can start the data enrichment process from scratch. But even if the first researcher published his data enrichment, it is much more likely that the subsequent researchers will find and use the original database. To prevent this, researchers would need to return the modified data to the original data provider. Fortunately, MARC21, introduced in the 34th update in 2022[^5] a data provenance subfield to distinguish between data recorded by the library and data recorded by the researcher (and it is available in most fields), which could be a theoretical remedy for the library's legitimate demand to take responsibility for its own data. In the life sciences, researchers can utilize a special, "atomic" data publication method called [nanopublications](https://nanopub.net/) to share data enrichment steps with each other. In our case these 'others' are libraries, which can then incorporate them into their catalogs without compromising their own responsibility and credibility. The second researcher can then work on the data-enriched version. In order to realize this vision, communication between the parties must be standardized, and the research community can play a coordinating role in this process.

### Summary


## Local application
### Apply this method
### Other projects
### Continued learning

## Endnotes

[^1]: For a full list with advantages and disadvantages of the persistent identifiers see Koster, Lukas. 2020. Persistent identifiers for heritage objects. _Code4Lib Journal_ 47. [https://journal.code4lib.org/articles/14978](https://journal.code4lib.org/articles/14978)

[^2]: If you are interested in this process we recommend the following book: Nelson, Catherine. 2024. _Software Engineering for Data Scientists: From Notebooks to Scalable Systems._ O’Reilly. ISBN 978-1-0981-3620-8 [https://www.oreilly.com/library/view/software-engineering-for/9781098136192/](https://www.oreilly.com/library/view/software-engineering-for/9781098136192/)

[^3]: Beyer, Florian, Vedder, Lucia, Singson, Lea Sophie, Sahwan, Wahib, & Schmidt, Marcus. 2025. Publishing research code FAIR - a roadmap (1.0). _Zenodo_. [https://doi.org/10.5281/zenodo.14772749](https://doi.org/10.5281/zenodo.14772749)

[^4]: Sandra Fauconnier. 2019. _Data Roundtripping: a new frontier for GLAM-Wiki collaborations⁠._ [https://diff.wikimedia.org/2019/12/13/data-roundtripping-a-new-frontier-for-glam-wiki-collaborations/](https://diff.wikimedia.org/2019/12/13/data-roundtripping-a-new-frontier-for-glam-wiki-collaborations/); Wikimedia Deutschland e.V. 2019. _Wikidata Use in Cultural Institutions. Research Report._ [https://upload.wikimedia.org/wikipedia/commons/e/e1/Research_Report_%E2%80%93_Use_of_Wikidata_in_GLAM_institutions_%282019-11%29.pdf](https://upload.wikimedia.org/wikipedia/commons/e/e1/Research_Report_%E2%80%93_Use_of_Wikidata_in_GLAM_institutions_%282019-11%29.pdf)

[^5]: _MARC 21 format for bibliographic data. Update No. 34, July 2022._ [https://www.loc.gov/marc/up34bibliographic/bdapndxg.html](https://www.loc.gov/marc/up34bibliographic/bdapndxg.html)