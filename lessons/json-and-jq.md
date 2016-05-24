---
title: Reshaping JSON with jq
authors:
- Matthew Lincoln
date: 2016-05-24
reviewers:
layout: default
---

[jq]: https://stedolan.github.io/jq/

[jq play]: https://jqplay.org/

## Lesson goals

JSON (JavaScript Object Notation) is a common data sharing format that can describe complex relationships.
However, many tools for data analysis and visualization require input in flat tables (i.e. CSV), and because JSON is such a flexible data format, often with many nested levels of data, there is no one-size-fits-all graphical user interface for transforming JSON into other formats.

Working with data from an art museum API and from the Twitter API, this lesson teaches how to use the command-line utility [jq] to filter and parse complex JSON files into flat CSV files.
By the end of the lesson, you will be familiar with the basic operators of the jq query syntax and how to chain them together to extract the desired data from complex JSON.


_Table of Contents_

-   [What is JSON?](#what-is-json)
-   [Lesson Setup](#lesson-setup)
-   [Core jq filters](#core-jq-filters)
    -   [The dot: `.`](#the-dot-.)
    -   [The array operator: `[]`](#the-array-operator)
    -   [The pipe: `|`](#the-pipe)
    -   [Filter: `select()`](#filter-select)
    -   [Create new JSON: `[]` and `{}`](#create-new-json-and)
    -   [Output a CSV: `@csv`](#output-a-csv-csv)
-   [Advanced operations](#advanced-operations)
    -   [JSON vs. JSON Lines](#json-vs.-json-lines)
    -   [One-to-many relationships: Tweet
        hashtags](#one-to-many-relationships-tweet-hashtags)
    -   [Basic data analysis](#basic-data-analysis)
    -   [Filter before counting](#filter-before-counting)
-   [Using jq on the command line](#using-jq-on-the-command-line)
    -   [Installation on OS X](#installation-on-os-x)
    -   [Invoking jq](#invoking-jq)
-   [Further Resources](#further-resources)


## What is JSON?

[w3schools](http://www.w3schools.com/json/json_syntax.asp) provides a short and cogent primer on JSON syntax.
In brief, a JSON object is written as a series of key:value pairs.
key:value pairs are separated from each other by a comma (`,`) and must be wrapped in `{}`

A key is a string (wrapped in double quotation marks: `""`), while values may be quoted text; the unquoted `true`, `false`, or `null`; an unquoted number; an array (multiple equivalent values within square brackets: `[]`); or another JSON object (wrapped in curly braces: `{}`)

Let's consider the JSON for Rembrandt's _Nightwatch_ in the Rijksmuseum:

```json
{
  "links": {
    "self": "https://www.rijksmuseum.nl/api/nl/collection/SK-C-5",
    "web": "https://www.rijksmuseum.nl/nl/collectie/SK-C-5"
  },
  "id": "nl-SK-C-5",
  "objectNumber": "SK-C-5",
  "title": "Schutters van wijk II onder leiding van kapitein Frans Banninck Cocq, bekend als de ‘Nachtwacht’",
  "hasImage": true,
  "principalOrFirstMaker": "Rembrandt Harmensz. van Rijn",
  "longTitle": "Schutters van wijk II onder leiding van kapitein Frans Banninck Cocq, bekend als de ‘Nachtwacht’, Rembrandt Harmensz. van Rijn, 1642",
  "showImage": true,
  "permitDownload": true,
  "webImage": {
    "guid": "3ae88fe0-021c-41ae-a4ce-cc70b7bc6295",
    "offsetPercentageX": 50,
    "offsetPercentageY": 100,
    "width": 2500,
    "height": 2034,
    "url": "http://lh6.ggpht.com/ZYWwML8mVFonXzbmg2rQBulNuCSr3rAaf5ppNcUc2Id8qXqudDL1NSYxaqjEXyDLSbeNFzOHRu0H7rbIws0Js4d7s_M=s0"
  },
  "headerImage": {
    "guid": "29a2a516-f1d2-4713-9cbd-7a4458026057",
    "offsetPercentageX": 50,
    "offsetPercentageY": 50,
    "width": 1920,
    "height": 460,
    "url": "http://lh3.ggpht.com/rvCc4t2BWHAgDlzyiPlp1sBhc8ju0aSsu2HxR8rN_ZVPBcujP94pukbmF3Blmhi-GW5cx1_YsYYCDMTPePocwM6d2vk=s0"
  },
  "productionPlaces": [
    "Amsterdam"
  ]
}
```

Takeaways:

- The entire text is wrapped in `{}`, identifying it as a JSON object.
- `id` is a key, separated by a colon from its value, `"nl-SK-C-5"`
- Some keys here have entire objects as their values. For example, `webImage` has an object with it's own key:value pairs like `"width": 2500` and `"height": 2034`.
- The key `productionPlaces` has an _array_ as its value, denoted by the `[]` wrapping it.
In this object, the array only has one value, `"Amsterdam"`, however it could have multiple values, e.g. `["Amsterdam", "Kloveniersdoelen"]`.
Remember, values of an array have no keys - they are all considered to be semantically equivalent to each other.

## Lesson Setup

For the bulk of this lesson, we will be working with a web-based version of jq at the site [jq play].
For this, you will only need your internet browser.
[jq play] cannot handle very large JSON files, but it is a great sandbox for learning the query language for jq.
(At the end of this lesson, we will download and install the command-line version of jq, which you may use to speedily parse much larger JSON files.)

{% include figure.html src="../images/json-and-jq/jqplay-screenshot.png" caption="The [jq play] website, with input JSON, filter, and results." %}

We will type all queries into the "Filter" box in the upper-left corner of [jq play].
The results will display on the right-hand side.
After each query in this lesson, I will include the first few lines of the expected results, so that you can check your work.

In some instances, we will interact with the checkboxes on the upper-right.
These set various jq [command-line options, or _flags_](https://stedolan.github.io/jq/manual/#Invokingjq), that affect things like input handling, and the final formatting of the output.
**Start the lesson with all of them unchecked.**

## Core jq filters

jq operates by way of _filters_: a series of text commands that you can string together, and which dictate how jq should transform the JSON you give it.

To learn the basic jq filters, we'll work with a sample response from the Rijksmuseum API: [rkm.json](/assets/jq_rkm.json)
Select all the text at that link, copy it, and paste it into the "JSON" box at [jq play] on the left hand side.


### The dot: `.`

The basic jq operator is the dot: `.`
Used by itself, `.` leaves the input unmodified.
Add the name of a key to it, however, and the filter will return the value of that key.
Try the following filter:

```txt
.count
```

This tells jq to return the value of the field `count`.
The result should read `359`.
Try the `.` operator again, this time accessing the field `artObjects`.

```txt
.artObjects
```

The results:

```json
[
  {
    "links": {
      "self": "https://www.rijksmuseum.nl/api/nl/collection/SK-C-5",
      "web": "https://www.rijksmuseum.nl/nl/collectie/SK-C-5"
    },
    "id": "nl-SK-C-5",
    "objectNumber": "SK-C-5",
    "title": "Schutters van wijk II onder leiding van kapitein Frans Banninck Cocq, bekend als de ‘Nachtwacht’",
    "hasImage": true,
    "principalOrFirstMaker": "Rembrandt Harmensz. van Rijn",
    "longTitle": "Schutters van wijk II onder leiding van kapitein Frans Banninck Cocq, bekend als de ‘Nachtwacht’, Rembrandt Harmensz. van Rijn, 1642",
    "showImage": true,
    "permitDownload": true,
    "webImage": {
      "guid": "3ae88fe0-021c-41ae-a4ce-cc70b7bc6295",
      "offsetPercentageX": 50
      /*ETC...*/
    }
  }
]
```

Note that jq has returned the entire array.
Rather than being wrapped in `{}`, the result is a series of objects wrapped within an array (`[{},{},{}]`)

If you want to access a value in an object that's already within another object, you can chain `.` filters together, e.g. `.links.self`.
[We will use this functionality later in the lesson.](#output-a-csv-csv)

### The array operator: `[]`

`.artObjects` returned one big array of JSON objects.
Before we can access the values inside those objects, we need to break them out of the array that they're in.
By adding `[]` onto the end of our filter, jq will break up this one array into 10 separate objects:

Try it:

```txt
.artObjects[]
```

Notice that the `[]` wrapping our results are now gone.
To make clear what has happened, check the "Compact Output" checkbox in the upper left.
This removes the cosmetic line breaks in the results, returning one JSON object per line.
You should have a 10-line output now.
Keeping "Compact Output" checked, remove the `[]` from the filter, so it just reads `.artObjects` again.
The results should now be just one line, as jq is now just returning one single JSON array.

If you want to access just the first (or the _n_-th) item in an array, put a digit in the `[]` operator:

```txt
// Note: JavaScript counts starting at 0
.artObjects[0]
```

This filter returns just the first element of the `artObjects` array.
`.artObjects[1]` would return the second, and so on.

Uncheck the "Compact Output" box again before continuing with the lesson.

### The pipe: `|`

The magic of jq is that you can connect, or _pipe_, several operators together to accomplish some very complex transformations of your data.
What's more, jq will repeat the filter for each JSON object provided by the previous step.
Therefore, while we started with just one big JSON object, `.artOjbects[]` created 10 smaller JSON objects.
Any operator we put after the `|` will be repeated for each of these objects.

For example, try the following query:

```txt
.artObjects[] | .id
```

This will return a list of every value at the key `id` within the `artObjects` array, separated by a line break.

### Filter: `select()`

Normally jq repeats every filter operation for each line of input that it receives, passing each answer on to the following filter operation.
`select()` will only pass on a subset of the input onto the next step of the filter.

Let's filter the Rijksmuseum JSON to only return the ids of objects that have at least one value assigned to their `productionPlaces`:

```txt
.artObjects[] | select(.productionPlaces | length >= 1) | .id
```

This should return:

```json
"nl-SK-C-5"
"nl-SK-A-3924"
```

Look at the rule established inside the parentheses of `select()`.
We access the `productionPlaces` array by using the operator `.productionPlaces`, and then use a `|` _within the `select()` command_ to send those arrays into the operator `length`, which returns the length of each array.
In order for this to work as a rule for `select()`, we need to add some kind of comparison that will return either `true`/`false`.
Adding `>= 1` completes our rule: only select JSON objects whose production places array has a length that is greater than or equal to 1.
After `select()`, we pipe the results into one more operation, `.id`, which returns the ids of these objects.

jq can also filter based on regular expressions.
For example, let's select only those objects whose primary maker has the particle "van" in their name, and return the artist name and artwork id.
`test("van")` takes the value returned by the operator `.principalOrFirstMaker` and returns true if that value contains the string `van`:

```txt
.artObjects[] | select(.principalOrFirstMaker | test("van")) | {id: .id, artist: .principalOrFirstMaker}
```

The results:

```json
{
  "id": "nl-SK-C-5",
  "artist": "Rembrandt Harmensz. van Rijn"
}
{
  "id": "nl-SK-A-180",
  "artist": "Gerard van Honthorst"
}
{
  "id": "nl-SK-A-2205",
  "artist": "Gerrit van Vucht"
}
{
  "id": "nl-SK-A-1935",
  "artist": "Rembrandt Harmensz. van Rijn"
}
{
  "id": "nl-SK-A-3246",
  "artist": "Adriaen van Ostade"
}
```

[See the full list of jq conditionals and comparisons.](https://stedolan.github.io/jq/manual/#ConditionalsandComparisons)

### Create new JSON: `[]` and `{}`

By wrapping `.` operators within either `[]` or `{}`, jq can synthesize new JSON arrays and objects.
This can be useful if you want to output a new JSON file.
As we will see below, this can also be a crucial intermediate step when reshaping complex JSON.

Create a new set of JSON objects with the following filter:

```txt
.artObjects[] | {id: .id, title: .title}
```

When creating an object with `{}`, you specify the names of the keys with unquoted text, and then assign the values with regular jq filters.
The resulting set of JSON objects have just two keys: `id` and `title`:

```json
{
  "id": "nl-SK-C-5",
  "title": "Schutters van wijk II onder leiding van kapitein Frans Banninck Cocq, bekend als de ‘Nachtwacht’"
}
{
  "id": "nl-SK-A-1505",
  "title": "Een molen aan een poldervaart, bekend als ‘In de maand juli’"
}
/*ETC...*/
```

We can also create arrays using `[]`:

```txt
.artObjects[] | [.id, .title]
```

The results:

```json
[
  "nl-SK-C-5",
  "Schutters van wijk II onder leiding van kapitein Frans Banninck Cocq, bekend als de ‘Nachtwacht’"
]
[
  "nl-SK-A-1505",
  "Een molen aan een poldervaart, bekend als ‘In de maand juli’"
]
/*ETC...*/
```

Unlike objects made using `{}`, arrays have no keys; they are just simple lists of values.
Creating simple arrays is crucial, however, for mapping our JSON into a CSV file.

### Output a CSV: `@csv`

To create a CSV table with jq we want to filter our input JSON into a series of arrays, with each array being a row of the CSV.

The previous filter gave us an array with the `id` and `title` keys of each painting.
Let's add the primary artist for each artwork as well:

```txt
.artObjects[] | [.id, .title, .principalOrFirstMaker, .webImage.url]
```

The results:

```json
[
  "nl-SK-C-5",
  "Schutters van wijk II onder leiding van kapitein Frans Banninck Cocq, bekend als de ‘Nachtwacht’",
  "Rembrandt Harmensz. van Rijn",
  "http://lh6.ggpht.com/ZYWwML8mVFonXzbmg2rQBulNuCSr3rAaf5ppNcUc2Id8qXqudDL1NSYxaqjEXyDLSbeNFzOHRu0H7rbIws0Js4d7s_M=s0"
]
[
  "nl-SK-A-1505",
  "Een molen aan een poldervaart, bekend als ‘In de maand juli’",
  "Paul Joseph Constantin Gabriël",
  "http://lh4.ggpht.com/PkQr-nNqzn0OVXVd4-hdJ6PPdWZ6-DQ_74WfBT3MZIV4LNYA-q8LUrtReXNstuzl9k6gKWkaBwG-LcFZ7zWU9Ch92g=s0"
]
/*ETC...*/
```

Note that, to access the url of nested in the `webImage` object, we chained together `.webImage.url`.

To format this as CSV, add the operator `@csv` on the end with another pipe and check the "Raw Output" box in the upper left.
`@csv` properly joins the arrays with `,` and adds quotes where needed.
"Raw Output" tells jq that we want to produce a text file, rather than a new JSON file.

```txt
.artObjects[] | [.id, .title, .principalOrFirstMaker, .webImage.url] | @csv
```

The results:

```txt
"nl-SK-C-5","Schutters van wijk II onder leiding van kapitein Frans Banninck Cocq, bekend als de ‘Nachtwacht’","Rembrandt Harmensz. van Rijn","http://lh6.ggpht.com/ZYWwML8mVFonXzbmg2rQBulNuCSr3rAaf5ppNcUc2Id8qXqudDL1NSYxaqjEXyDLSbeNFzOHRu0H7rbIws0Js4d7s_M=s0"
"nl-SK-A-1505","Een molen aan een poldervaart, bekend als ‘In de maand juli’","Paul Joseph Constantin Gabriël","http://lh4.ggpht.com/PkQr-nNqzn0OVXVd4-hdJ6PPdWZ6-DQ_74WfBT3MZIV4LNYA-q8LUrtReXNstuzl9k6gKWkaBwG-LcFZ7zWU9Ch92g=s0"
...
```

This is a valid CSV file, which we could now import into an analysis program.

## Advanced operations

### JSON vs. JSON Lines

You may encounter two different types of JSON files in the wild: files with one large JSON object, and so-called "JSON lines" files, which have multiple, separate JSON objects each on one single line, _not wrapped by `[]`_.
jq will repeat your entire filter statement _per JSON object_.
This means that it will run your filter once on a file with a large JSON object, and run it _once per line_ on a "JSON lines" file.
You will commonly find larger data dumps of JSON will come in a JSON lines format; for example, the [New York Public Library released their public domain collections in as multiple JSON lines-formatted files](https://github.com/NYPL-publicdomain/data-and-utilities/tree/master/items)
(n.b. NYPL used the file extension `.ndjson`, but is is just one convention --- others use `.jsonl` or even just `.json`.)

The Rijksmuseum example above is a single JSON object that contains many smaller sub-objects, each of which stands for an artwork in the collection.
Below, we will work with a set of Twitter JSON in the "JSON lines" format, transforming complex relationships into usable flat tables.

### One-to-many relationships: Tweet hashtags

Often you may wish to create a table that expresses a one-to-many relationship, such as a tweet and its hashtags.
A tweet will always have exactly one tweet ID, while it may have zero, one, or more hashtags.
There are a few ways to express this as a CSV table, but we will implement two common solutions here:

1. One row per tweet, with multiple hashtags in the same cell
2. One row per hashtag (["long" or "narrow" data presentation](https://en.wikipedia.org/wiki/Wide_and_narrow_data)), with tweet IDs repeated as necessary

First, [copy this sample data of 50 tweets](/assets/jq_twitter.json) into [jq play].

#### One row per tweet

Let's create a table with one column with a tweet ID, and a second column with all the hashtags in each tweet, separated by a semicolon: `;`

This is a relatively complex query that will require a multi-step filter.
First, let's reduce the twitter JSON to just ids and the objects describing the hashtags:

```txt
{id: .id, hashtags: .entities.hashtags}
```

The results:

```json
{
  "id": 501064141332029440,
  "hashtags": [
    {
      "indices": [
        41,
        50
      ],
      "text": "Ferguson"
    }
  ]
}
{
  "id": 501064171707170800,
  "hashtags": [
    {
      "indices": [
        139,
        140
      ],
      "text": "Ferguson"
    }
  ]
}
/*ETC...*/
```

Note that we do not have to start this query by breaking apart an array like we did with the Rijskmuseum data.
jq simply repeats the filter once per line of the input file.
This has created a set of JSON objects (wrapped in `{}`) with an `id` key and a `hashtags` key.
The value of `hashtags` is the  array (wrapped in `[]`) from the original data, which may have 0 or more objects inside it.
Let's add a second query to preserve just the text of those hashtags:

```txt
{id: .id, hashtags: .entities.hashtags} | {id: .id, hashtags: .hashtags[].text}
```

The results:

```json
{
  "id": 501064141332029440,
  "hashtags": "Ferguson"
}
{
  "id": 501064171707170800,
  "hashtags": "Ferguson"
}
{
  "id": 501064180468682750,
  "hashtags": "Ferguson"
}
{
  "id": 501064194309906400,
  "hashtags": "USNews"
}
{
  "id": 501064196931330050,
  "hashtags": "Ferguson"
}
{
  "id": 501064196931330050,
  "hashtags": "MikeBrown"
}
/*ETC...*/
```

`id: .id` just keeps the `id` field unchanged.
The `[]` in `.hashtags[].text` breaks open the array of hashtags in each tweet, allowing us to extract the value of the `text` key from each one.
Note, however, that tweet ID `501064196931330050` shows up twice in the results, because it had 2 hashtags: `Ferguson` and `MikeBrown`.
We want the tweet ID to only show up once, with an array of hashtags.
To do this, let's edit our filter by adding another set of `[]`, this time wrapping around `.hashtags[].text`:

```txt
{id: .id, hashtags: .entities.hashtags} | {id: .id, hashtags: [.hashtags[].text]}
```

By adding `[]` around `.hashtags[].text`, we tell jq to collect the individual results of `.hashtags[].text` within an array.
If it finds multiple results, it will put them together in the same array.
Note that tweet ID `501064196931330050` now has just one object, with an embedded array of two hashtags:

```json
/* ... */
{
  "id": 501064196931330050,
  "hashtags": [
    "Ferguson",
    "MikeBrown"
  ]
}
/*ETC...*/
```

Finally, we want to express this as a CSV file, delimiting the hashtags with `;`.
To do this, we need to add one more intermediary JSON object:

```txt
{id: .id, hashtags: .entities.hashtags} | {id: .id, hashtags: [.hashtags[].text]} | {id: .id, hashtags: .hashtags | join(";")}
```

Once again, we use `id: .id` to preserve the `id` value unchanged.
However, we change the value of `hashtags` one last time.
`.hashtags | join(";")` uses the [`join()`](https://stedolan.github.io/jq/manual/#join(str)) command, which takes an array as input and joins the elements together using the provided string (in this case, `";"`):

```json
{
  "id": 501064141332029440,
  "hashtags": "Ferguson"
}
{
  "id": 501064171707170800,
  "hashtags": "Ferguson"
}
{
  "id": 501064180468682750,
  "hashtags": "Ferguson"
}
{
  "id": 501064188211765250,
  "hashtags": ""
}
{
  "id": 501064194309906400,
  "hashtags": "USNews"
}
{
  "id": 501064196931330050,
  "hashtags": "Ferguson;MikeBrown"
}
/*ETC...*/
```

Now, we can finally format the individual rows of the CSV and output it (remember to check the "Raw Output" box):

```txt
{id: .id, hashtags: .entities.hashtags} | {id: .id, hashtags: [.hashtags[].text]} | {id: .id, hashtags: .hashtags | join(";")} | [.id, .hashtags] | @csv
```

This is a very complex, multipart query.
Let's review its components one more time:

1. `{id: .id, hashtags: .entities.hashtags} |` Create a new set of JSON objects by extracting the `id` field from each tweet, along with the JSON object describing the tweet's hashtags.
2. `{id: .id, hashtags: [.hashtags[].text]} |` Preserve the `id` key:value pair, and collect the `text` of each `hashtags` object in an array, which we reassign to the key `hashtags`.
3. `{id: .id, hashtags: .hashtags | join(";")} |` Preserve the `id` key:value pair, and join the contents of the `hashtags` array together, separated by `;`
4. `[.id, .hashtags] |` Build an array for each row of our desired table
5. `@csv` Format everything as a CSV

The final results:

```txt
501064141332029440,"Ferguson"
501064171707170800,"Ferguson"
501064180468682750,"Ferguson"
501064188211765250,""
501064194309906400,"USNews"
501064196931330050,"Ferguson;MikeBrown"
501064197396914200,""
501064197632167940,"Ferguson;tcot;uniteblue;teaparty;gop"
...
```

There are ways to get the same results using an even shorter query, but in most cases, it pays to break up your jq transformations into small steps

#### One row per hashtag

This is actually simpler to implement in jq, because we can take advantage of jq's natural behavior of repeating filters.

We will start with the same set of operations that extract the tweet ID and the hashtag objects from the original twitter JSON:

```txt
{id: .id, hashtags: .entities.hashtags} | {id: .id, hashtags: .hashtags[].text}
```

This results in a long series of JSON objects with one id and one hashtag per object.
All we need to do is construct the CSV row arrays and pipe them through the `@csv` operator:

```txt
{id: .id, hashtags: .entities.hashtags} | {id: .id, hashtag: .hashtags[].text} | [.id, .hashtag] | @csv
```

The results:

```txt
501064141332029440,"Ferguson"
501064171707170800,"Ferguson"
501064180468682750,"Ferguson"
501064194309906400,"USNews"
501064196931330050,"Ferguson"
501064196931330050,"MikeBrown"
...
```

### Basic data analysis

It is also possible to do some basic data analysis with jq.

For the previous examples, we have only needed to consider each tweet individually.
By default, jq will look at one JSON object at a time when parsing a file; consequently, it can _stream_ very large files without having to load the entire set in to memory.

However, for some questions we _do_ need to have access to every JSON object in a file.
This is where we want to use "Slurp" (or the `-s` flag on command-line jq).
"Slurp" tells jq to read every line of the input JSONlines and treat the entire group as one huge array of objects.

With the twitter data still in the input box on [jq play], check the "Slurp" box, and just put '.' in the filter.
Note that it's wrapped the objects in `[]`.
Now we can build even more complex commands that require knowledge of the entire input file.

Ironically, though, the first thing we need to do to access the hashtags again is to break them _out_ of that large array:

```txt
.[] | {id: .id, hashtag: .entities.hashtags} | {id: .id, hashtag: .hashtag[].text}
```

Adding `.[]` at the beginning splits apart the large array created by the "Slurp" option.
This might seem counterintuitive, but it is necessary in order to perform the next step: collecting that entire output back into an array inside `[]`, so that we can pass a single array into the `group_by()` function:

```txt
[.[] | {id: .id, hashtag: .entities.hashtags} | {id: .id, hashtag: .hashtag[].text}] | group_by(.hashtag)
```

Note the change at the start of the filter: the first two components are now wrapped in `[]`.
We also added the `group_by(.hashtag)` command at the end of the filter.
The results:

```json
[
  [
    {
      "id": 619172232120692700,
      "hashtag": "Acquisition"
    }
  ],
  [
    {
      "id": 501064204288540700,
      "hashtag": "BLACKMEDIA"
    }
  ],
  [
    {
      "id": 619172293680345100,
      "hashtag": "BreakingNew"
    }
  ]
  /*ETC...*/
]
```

`group_by(.key)` takes an array of objects as its input, and returns an array of arrays, with those sub-arrays filled with objects that share the same value for the specified `key`.
Scroll down to find the sub-array of tweet objects with the "Ferguson" hashtag.

In the above query, tweet/hashtag pairs are grouped in to arrays based on the value of their `hashtag` key.
To count the number of times each hashtag is used, we only have to count the size of each of these sub-arrays.

```txt
[.[] | {id: .id, hashtag: .entities.hashtags} | {id: .id, hashtag: .hashtag[].text}] | group_by(.hashtag) | .[] | {tag: .[0].hashtag, count: . | length} | [.tag, .count] | @csv
```

The results:

```txt
"Acquisition",1
"BLACKMEDIA",1
"BreakingNew",1
"CrimeButNoTime",1
"Farrakhan",1
"Ferguson",53
"FergusonShooting",1
"ForFreedom",1
"FreeAmirNow",3
"HandsUpDontShoot",1
/*ETC...*/
```

(Remember, to format CSV output correctly, set jq to "Raw output" using the `-r` flag on the command line.)

`.[]` once again breaks apart the large array, so we are left only with the sub-arrays within.
We need to retrieve two pieces of information: first, the name of the hashtag for each sub-array, which we can get by accessing the value of the `hashtag` key in the first tweet/hashtag combo of the array (accessed with `.[0]`).
Second, we need to get the length of the array, accessed with `. | length`.
Finally, we create the CSV and format the CSV rows.

To review:

1. `[.[] | {id: .id, hashtag: .entities.hashtags} | {id: .id, hashtag: .hashtag[].text}] |` This nested filter :
    1. breaks out individual tweet objects from the large array created by the "Slurp" option (`.[]`)
    2. retrieves the tweet id and hashtag text (`{id: .id, hashtag: .entities.hashtags} | {id: .id, hashtag: .hashtag[].text}`)
    3. Wraps both of those filters in `[]` in order to collect the results in one large array again.
1. `group_by(.hashtag) |` Takes the large array from the previous step and sorts it into an array of arrays, each sub-array containing tweet objects sharing the same hashtag.
1. `.[] |` Break the large array produced by `group_by()` into its component sub-arrays.
1. `{tag: .[0].hashtag, count: . | length} |` Get the hashtag representing each sub-array by checking the hashtag value of the first member of each sub-array, and then count the size of each sub-array, effectively counting the number of tweets in which that hashtag was used.
1. `[.tag, .count] |` Create simple arrays with just the tag name and count
1. `@csv` Format each array as a CSV row

### Filter before counting

What function do we need to add to the hashtag-counting filter to only count hashtags when their tweet has been retweeted at least 200 times?
Hint: the retweet count is saved under the key `retweet_count`.

You should get the following table:

```txt
"CrimeButNoTime",1
"Ferguson",14
"FergusonShooting",1
"MikeBrown",1
"OpFerguson",1
"RIPMikeBrown",1
"justiceformikebrown",1
"stl",1
"vancouver",1
"whiteprivilege",1
```

[See the answer](/assets/filter_retweets.txt)

## Using jq on the command line

[jq play] is fine when you have under 100-200 lines of JSON to parse.
However, it will become unusably slow on  much larger files.
For fast processing of very large files, or of JSON lines spread across multiple files, you will need to run the command-line version of jq.

[See The Programming Historian's "Introduction to the Bash Command Line".](http://programminghistorian.org/lessons/intro-to-bash)

### Installation on OS X

The easiest way to install jq on OS X is to use the package managment system [Homebrew](http://brew.sh/).
Follow the installation instructions for Homebrew itself, and then use this command to install jq:

```sh
brew install jq
```

### Invoking jq

```sh
jq -r '.artObjects[] | [.id, .title, .principalOrFirstMaker, .webImage.url] | @csv' jq_rkm.json > jq_rkm.csv
```

1. `jq` calls the jq program.
1. `-r` sets the "Raw Output" option.
1. The actual filter text is placed between `''` quotes.
1. `jq_rkm.json` indicates that jq should read JSON from the file `jq_rkm.json`.
1. `> jq_rkm.csv` tells the command line to write jq's output into a file named `jq_rkm.csv`.

Alternatively, you can use bash pipes to send text from the output of one function into jq.
This can be useful when downloading JSON with a utility like `curl`

```sh
curl https://gist.githubusercontent.com/mdlincoln/505d3a28a968db173445cd044fef0cc6/raw/469794374b8f9b3c80e3136bb1713c528706e286/jq_rkm.json | jq -r '.artObjects[] | [.id, .title, .principalOrFirstMaker, .webImage.url] | @csv'
```

## Further Resources

jq is incredibly powerful, but its advanced features can get quite complicated.

It is possible to do [other basic math functions in jq](https://stedolan.github.io/jq/manual/#Math), however given the complexity of working with JSON's tree data model, I would suggest producing the necessary tables with jq and then continuing your analysis in Python, R, or even Excel.

If you are working with deeply-nested JSON (that is, many objects within objects), or JSON where objects have inconsistent structure, you may need to use features not covered in this lesson, including [if-then-else statements](https://stedolan.github.io/jq/manual/#if-then-else), [recursion](https://stedolan.github.io/jq/manual/#Recursion), and [reduction](https://stedolan.github.io/jq/manual/#Reduce).
If you can't figure out the filter you need to go from your given input to your desired output, using the tag `jq` over at [StackOverflow](http://stackoverflow.com/questions/tagged/jq) can often get you a speedy answer.
Make sure that you try to [follow best practices when describing your problem](http://stackoverflow.com/help/how-to-ask) and provide a [reproducible example](http://stackoverflow.com/help/mcve).
