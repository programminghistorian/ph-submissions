---
title: "Linear and Logistic Regression"
collection: lessons
date: "2021-7-19"
output: pdf_document
layout: lesson
authors: Matthew J. Lavin
reviewers:
- TBD
- TBD
editors: TBD
review-ticket: null
difficulty: TBD
activity: analyzing
topics: distant-reading
abstract: This lesson focuses on an indispensable set of data analysis methods, logistic
  and linear regression. It provides a high-level overview of linear and logistic
  regression and walks through running both algorithms in Python (using scikit-learn).
  The lesson also discusses interpreting the results of a regression model and some
  common pitfalls to avoid.
mathjax: yes
avatar_alt: TBD
doi: TBD
slug: linear-and-logistic-regression
---

{% include toc.html %}

# Lesson Overview

This lesson focuses on an indispensable set of data analysis methods, logistic and linear regression. Linear regression represents how a quantitative measure (or multiple measures) relates to or predicts some other quantitative measure. A computational historian, for example, might use linear regression analysis to predict a person's annual income using information about the number of years they spent in school, or to predict a country's GDP based on how many miles of coastline it has. Logistic regression uses a similar approach to represent how a quantitative measure (or multiple measures) relates to or predicts a category. For example, a computational historian might use logistic regression to analyze how well a factor like income predicts political party affiliation. 

Logistic and linear regression are perhaps the most widely used methods in quantitative analysis, including but not limited to computational history, because the underlying mechanics of the predictions are accessible to human interpretation (in contrast to many "black box" models). The central goals of this lesson are to provide a high-level overview of linear and logistic regression, to describe how regression fits into data analysis research design, and to walk through running both algorithms in Python using the scikit-learn library. The lesson will also discuss interpreting the results of a regression model and some common pitfalls to avoid when conducting regression analysis.

# Preparation

## Suggested Prior Skills

- Prior familiarity with Python or a similar programming language. Code for this lesson is written in Python 3.7.3 on MacOS Catalina, but you can likely run regression analysis in many ways. The precise level of code literacy or familiarity recommended is hard to estimate, but you will want to be comfortable with basic types and operations. For example, you may want to review the concepts discussed in ["Analyzing Documents with TF-IDF"](https://programminghistorian.org/en/lessons/analyzing-documents-with-tfidf) and ["Understanding and Using Common Similarity Measures for Text Analysis"](https://programminghistorian.org/en/lessons/common-similarity-measures). 
- To understand the steps used to produce the lesson dataset, it would be helpful to have some familiarity with concepts such as how text files are typically normalized, tokenized, and represented in vector space. However, these details are not needed to complete the lesson. 

## Before You Begin

- Install the Python 3 version of Anaconda. Installing Anaconda is covered in [Text Mining in Python through the HTRC Feature Reader](/en/lessons/text-mining-with-extracted-features). This will install Python 3.7.3 (or higher), the [Scikit-Learn library](https://scikit-learn.org/stable/install.html), and the dependencies needed to run a [Jupyter Notebook](https://jupyter.org/).
- It is possible to install all these dependencies without Anaconda (or with a lightweight alternative like [Miniconda](https://docs.conda.io/en/latest/miniconda.html)). For more information, see the section below titled ["Alternatives to Anaconda"](#alternatives-to-anaconda)

## Lesson Dataset

This lesson demonstrates linear and logistic regression using a corpus of book reviews published in _The New York Times_ between 1905 and 1925. This corpus represents a sample of approximately 2,000 reviews, each of which focuses on a single published book. I prepared this dataset in conjunction with an article titled "Gender Dynamics and Critical Reception: A Study of Early 20th-century Book Reviews from _The New York Times_," which was published in _Cultural Analytics_ in January 2020.[^1] The text of each review has been pre-processed, tokenized, and converted to CSV files in a Bag-of-Words format, with each term represented as a value in the first column and each term count represented as a value in the second column. CSVs are all stored in a folder called `corpus`, with each review named after its unique id from _The New York Times_ Archive API, such as `4fc03a7d45c1498b0d1e2e6e.csv`. Outside of the `corpus` folder, a file called `reviews_meta.csv` includes information about each review, including the corresponding id field from the Archive API. Metadata for the corpus includes fields retrieved from the Archive API as well as additional fields that were tagged by hand:

### New York Times Data Fields 

__nyt_id__

This is a unique alpha-numeric identifier used by the New York Times Archive API to identify each periodical article. 

__xml_id__

This is a unique numeric identifier used by the New York Times to align XML files with metadata. The alignments between `xml_id` and `nyt_id` were obtained, by request, from _The New York Times_. 

__month__

Month of publication for the specific article.

__day__

Day of publication for the specific article.

__year__

year of publication for the specific article.

__nyt_pdf_endpoint__

A url linking the entry to its corresponding content on _The New York Times_' Times Machine

### Hand-coded Fields

These fields were added by Dr. Matthew Lavin as part of his scholarly work on book reviews.

__cluster_id__

If the entry was created by splitting up a group of book reviews scanned as one article, this id maps the review to a corresponding text file for the individual review. 

__perceived_author_gender__

This field describes the gender of the author assumed by the review/reviewer. If the review calls the author he or she, or Mr. of Mrs., or other gendered pronouns and/or honorifics, these were taken as evidence of a gender presumption. There are three possible values for this field. 

m: author described using male gendering terms such as Mr., Lord, Baron, he, and his.

f: author described using female gendering terms such as Mrs., Miss, madam, she, and her.

u: gender label is unclear, or maybe the reviewer avoided gender terms to remain neutral.

## Regression Definition and Background

To understand regression, it is first useful to review the concepts of __independent and dependent variables__. In statistical inference, an independent variable is "the condition of an experiment that is systematically manipulated by the investigator."[^2] It is treated as the predictor or signal variable, or often the possible cause of some effect. In turn, the dependent variable is "expected to change as a result of an experimental manipulation of the independent variable or variables."[^3] With regression, a model of best fit is trained from one or more independent variables in order to predict a dependent variable. The strength of a model can be assessed using the accuracy of the predictions it generates, as well as its statistical significance. 

To understand the main difference between linear and logistic regression, likewise, it is helpful to review the concepts of __continuous__ and __nominal__ variables. Broadly speaking, data can be classified into two groups: Numerical (quantitative) and Categorical (qualitative). All numerical data have magnitude and units, but there are two types of numerical data: discrete and continuous. Discrete variables are often thought of as count values, such as the number of apples in a bowl, or the number of students in a classroom. Continuous variables differ from discrete variables in that continuous variables can have a real number value between their minimum and maximum. A person's height or body temperature are often used as examples of continuous variables because both can be expressed as decimal values, such as 162.35 cm or 36.06 degrees Celsius. Categorical data includes the subcategories of nominal and ordinal variables. Ordinals describe qualitative scales with defined order, such as a satisfaction score on a survey. Nominal data describe categories with no defined order, such as a book's genre or its publisher.[^4] The following table summarizes these data types:

| Type | Subtype | Definition |
|---|---|---|
| Numerical | Discrete | Count values where whole numbers make sense of decimals don't |
| Numerical | Continuous | Real number values where whole numbers and decimals are meaningful |
| Categorical | Ordinal | Qualitative scales such as satisfaction score 1-5	|
| Categorical | Nominal | Qualitative labels with no distinct or defined order |

All this helps us understand the difference between linear and logistic regression because linear regression is used to predict a continuous, dependent variable from one or more independent variables, and logistic regression is used to predict a binary, nominal variable from one or more independent variables. There are other methods for discrete and ordinal data, but I won't cover them in this lesson. Arguably, what's most important when learning about linear and logistic regression is obtaining high level intuition for what's happening when you fit a model and predict from it, and that's what we'll focus on here.

## Overview of Linear Regression

Simple linear regression (a linear model with one continuous, independent variable and one continuous, dependent variable) is most often taught first because the math underlying it is the easiest to understand. The concepts you learn can then be extended to multiple linear regression, that is, a linear model with many independent variables and one dependent variable.

The goal with a simple linear regression model is to calculate a two-dimensional __line of best fit__ for sample of data and to evaluate how to close to the regression line a given set of data points are. A simplified example, using our book reviews data set, can help clarify what a __line of best fit__ is, and how it is generated. 

The following plot visualizes the relationship between the average length of single-work book reviews in the _The New York Times_ and the year in which those reviews appeared. Later in this lesson, I will come back to how a plot like this is made in Python. What's important now is the idea that we could train a model to predict a book review's year of publication by knowing only how long, on average, book reviews are for each year. We shouldn't necessarily expect a strong relationship between average review length and date, unless book reviews were steadily getting shorter or longer over time.

![Book reviews by average word count per year](regplot_book_review_length.png)

In this case, we do see an increase over time in this example, with an average difference of about 35 words per year. There could be various causes for this apparent relationship, and these results might be better explained by another model (such as a polynomial regression), but this simplified example is useful for demonstrating several key concepts associated with linear and logistic regression models. 

The visualization is a conventional scatter plot with average length on one axis, and year on the other. Through the two-dimensional data, a straight line has been drawn, and this line is drawn in such a way as to minimize the total distance of all points from the line. We can imagine that if we made the line shallower or steeper, or moved the entire line up or down without changing its angle, some points might be closer to the line, but other points would now be farther away. A __line of best fit__ in this case, expresses the general idea that the line should work as well as possible for the most points, and the specific idea that that a line's goodness-of-fit can be assessed by calculating __the mean of the squared error__. To clarify this idea of squared error, I have added some new labels to the same regression plot. 

![ Books reviews by average word count per year with error lines ](regplot_book_review_length_w_error.png)

In this plot, a vertical line between each point and the regression line expresses the error for each data point. The squared error is the length of that line squared, and the mean squared error is the sum of all squared error values, divided by the total number of data points.[^5] Fitting a regression line in this way is sometimes referred to as an __ordinary least squares regression__.[^6] One thing that makes a line-of-best-fit approach so appealing is that it describes a singularity function to convert one or more input values into an output value. The standard regression function looks like this:

$$
Y = a + bX
$$
In this function, X is the explanatory variable and Y is the dependent variable, or the prediction. The lowercase a is the value of y when x = 0 (or the __intercept__), and b is the slope of the line. If this formula looks familiar, you may recall from algebra class that any line in a coordinate system can be expressed by designating two values: a starting set of coordinates and "rise over run." In a linear regression, the intercept provides the starting coordinate, the coefficient provides information about the rise of the slope, and the run value is expressed by the explanatory variable.[^7] When we perform multiple regression, we end up with a similar function, as follows:

$$
Y = a + bX1 + cX2 + dXn
$$
In this formula, the prediction is generated by adding the intercept (a) to the product of each explanatory variable and its coefficient. In other words, the math behind a multiple linear regression is more complicated than simple linear regression, but the intuition is the same: to draw a line of best fit, expressed by a single function, that generates predictions based on input values. 

# Linear Regression Procedure

In this lesson, we will begin by training a linear regression model using the corpus of book reviews from _The New York Times_ described above. The corpus is sufficiently large to demonstrate splitting the data set into subsets for training and testing a model. This is a very common procedure in machine learning, as it ensures that the trained model will make accurate predictions on objects not included in the training process. We'll do something similar with logistic regression in the second part of this lesson. 

As we have seen, a linear regression model uses one or more variables to predict a continuous numerical value, so we will train our first model to predict a book review's publication date. Logistic regression, in turn, uses one or more variables to predict a binary categorical or nominal label. For this task, we will reproduce a version of the model I trained for the article "Gender Dynamics and Critical Reception: A Study of Early 20th-century Book Reviews from The New York Times," which was published in _Cultural Analytics_ in January 2020. Gender is a social construction and not binary, but the work I did for _Cultural Analytics_ codes gender not as an essential identity, but as a reflection of the book reviewers' perceptions. Rather than reifying a binary view of gender, I believe this example makes for an effective case study on how document classification can be used to complicate, historicize, and interrogate the gender binaries in _The New York Times Book Review_.

## Running Linear Regression in Python 3

In this section of the lesson, we will run a linear regression model in Python 3 to predict a book review's date (represented as a continuous variable). We will rely primarily on the scikit-learn library for setting up, training, and evaluating our models, but we will also use pandas for reading CSV files and data manipulation, as well as matplotlib and seaborn to make data visualizations. Later, we will use the same mix of libraries to train a logistic regression model to predict the perceived gender of the author being reviewed (represented as a binary, nominal variable). 

Some of the code below is specific to the way I have set up my metadata and data files, but the choices I have made aref common in data science and are becoming increasingly popular in computational humanities research. I will explain the principles behind each block of code as I walk you through each of the steps. 

### Step 1: Loading metadata

As stated previously, the metadata for this lesson can be found on two csv files, `metadata.csv` and `meta_cluster.csv`. They are presented as two separate files because, in one file, a row represents one review and one pdf file in the New York Times API. In the second file, each row represents one review, but each of these reviews was clustered into one pdf file with one or more additional reviews in the New York Times API. Both of our tasks call for consolidating the two review lists into one DataFrame in Python. 

```python
import pandas as pd
df = pd.read_csv("metadata.csv")
df_cluster = pd.read_csv("meta_cluster.csv", dtype={'cluster_id': str})
df_all = pd.concat([df,df_cluster], axis=0, ignore_index=True, sort=True).fillna('none')
```

In the above code chunk, `pd.concat()` allows us to combine multiple DataFrames using rules or logic.[^8] 

In this example, the parameter`axis= 0` instructs the `pd.concat()` method to join by rows instead of columns; `sort=True` directs it to sort the results; and `fillna('none')` fills any `nan` values with 0. This last directive is important because `meta_cluster.csv` has a column for cluster_id and `metadata.csv` does not.[^9]

### Step 2: Preparing The Data and Creating Date Labels

In this step, we prepare the DataFrame for linear regression analysis. For the linear regression model we are going to train, we need to be sure each row has a year, month, and day, and we want to use those fields to create a new column that represents the date as a floating-point decimal. In this schema, for example, the date February 9, 1907 would be encoded as 1907.106849 and April 12, 1914 would be 1914.276712.

```python
from datetime import datetime as dt
import time

def s(date): # returns seconds since epoch
    return time.mktime(date.timetuple())
    
def toYearDecimal(row):   
    y = row['year']
    m = row['month']
    d = row['day']
    date_object = dt(year=y, month=m, day=d)
    year = date_object.year
    startOfThisYear = dt(year=year, month=1, day=1)
    startOfNextYear = dt(year=year+1, month=1, day=1)

    yearElapsed = s(date_object) - s(startOfThisYear)
    yearDuration = s(startOfNextYear) - s(startOfThisYear)
    fraction = yearElapsed/yearDuration

    return date_object.year + fraction

df_all = df_all.dropna(subset=['day', 'month', 'year']).reset_index(drop=True)
df_all['yearDecimal'] = df_all.apply(toYearDecimal, axis=1).reset_index(drop=True)
```

This chunk of Python code defines two functions, drops any rows in the `df_all` DataFrame with NA values in the `day`, `month`, or `year` columns, and then uses an `apply()` method to run the `toYearDecimal()` function on each row in the `df_all` DataFrame. You could also do this with a loop, but `apply()` is faster and more consistent with the pandas ecosystem, especially since we are generating the values for a new column in that very DataFrame. 

The logic of the `toYearDecimal()` function is fairly straightforward: it uses the `day`, `month`, or `year` columns to construct a `Date` object (which is why it's important that there be no NA values in those fields) and then expresses the date as number of days since January 1 of that year. It then divides that number by the total number of days in that date's year (365 or 366 depending on whether it's a leap year) to convert the number of days into a decimal value. It adds that decimal back to the year to express the date as its year + the decimal value of days. The decimal date is then stored in the `yearDecimal` column of the `df_all` DataFrame, and the index is reset once more since we have removed many rows of data.

### Step 3: Loading Term Frequency Data, Converting to List of Dictionaries 

There are lots of ways to the work with term frequency data, but one of the most common is to create metadata CSV file and then to key each corresponding term frequency CSV to an id in that metadata file. In this case, we started with two CSVs and joined them to together to create one central list of documents. Now, we can iterate through the rows of the `df_all` DataFrame and build up a list of dictionaries. Each dictionary will have terms as keys and counts as values, like this:

```
{'the': 22, 'as':12, 'from': 8, ...}
```

The order of this list of dictionaries will be the same as the rows in `df_all`. 

```python
list_of_dictionaries = []
for row in df_all.iterrows():
    if row[1]['cluster_id'] == 'none':
        txt_file_name = ''.join(['term-frequency-tables/', row[1]['nyt_id'], '.csv'])
    else:
        txt_file_name = ''.join(['term-frequency-tables/', row[1]['nyt_id'], '-', row[1]['cluster_id'], '.csv'])

    df = pd.read_csv(txt_file_name).dropna().reset_index(drop=True).set_index('term')
    mydict = df['count'].to_dict()

    list_of_dictionaries.append(mydict)

len(list_of_dictionaries)
```

This block of code's purpose is to load term frequency data from multiple CSV files and convert them to list of dictionaries. We want the list to match the metadata file, so we loop through the rows of the `df_all` DataFrame just like we did with the previous block of Python. This time, however, I'm using the method `iterrows()` rather than `apply()`. There are various pros and cons to each method, but `iterrows()` might be a little more intuitive in this context since, instead of creating a new column in our DataFrame, we are building up a new list of dictionaries. 

The `if` and `else` statements in the code are there because, for each row, we need to use column data to generate the file path of the corresponding CSV. Solo reviews will have one kind of file name and reviews extracted from clusters of reviews with have another. Here are two example file paths:

```
term-frequency-tables/4fc0474945c1498b0d21c20f.csv
```

```
term-frequency-tables/4fc0780645c1498b0d2ff50a-1.csv
```

Did you notice the difference? If a row has no numerical cluster id, the file name will be built from the folder location, the review id, and the string '.csv'. If the row does have a numerical cluster id, the file name will be built using the folder location, the id, a hyphen, the cluster id, and the string '.csv'. 

Once the correct file path is determined, the code block loads the CSV as its own pandas DataFrame. This is often the fastest way to get tabular data into python, but we want to convert that DataFrame to a dictionary where terms are keys and counts are values. As a result, we preemptively execute three pandas methods, `dropna()`, `reset_index(drop=True)` and `set_index('term')`. Pandas supports chaining, so we can add them sequentially to the tail of the `pd.read_csv()` statement. The `dropna()` method removes any rows with NA values; The `reset_index(drop=True)` renumbers the rows in case any rows were dropped; and `set_index('term')` converts the term column to the index so that it's easier to convert to a dictionary.

The code to do the conversion is `mydict = df['count'].to_dict()`. It begins with `df['count']`, which represents the `count` column as a pandas Series. (For more on the Series datatype, see https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.html) Next, the pandas method `to_dict()` converts that series to a dictionary, using the index values as dictionary keys and the Series values as dictionary values. Each dictionary is then appended to `list_of_dictionaries`. After the loop has finished running, the `len()` of `list_of_dictionaries` will be the same as the number of reviews, and in the same order.

**Note:** The file path code from this block may need to be edited for windows machines.

### Step 4: Converting data to a document-term matrix

Converting dictionary-style data to a document-term matrix is a fairly common task in a text analysis pipeline. We essentially want the data to resemble a CSV file with each document in its own row and each term in its own column. Each cell in this imagined CSV, as a result, will represent the count of a particular term in a particular document. If a word does not appear in a document, the value for that cell will be zero. 

```python
from sklearn.feature_extraction import DictVectorizer
v = DictVectorizer()
```

In the above block of code, we import the `DictVectorizer()` class from scikit-learn and instantiate a `DictVectorizer`, which we will use to convert our `list_of_dictionaries` variable to a document-term matrix. Once we have our data in this format, we will use the TF-IDF transformation to convert our term counts to TF-IDF weights, which help us isolate distinctive terms and ignore words that appear frequently in many documents. [^10].

### Step 5: TF-IDF Transformation, Feature Selection, and Splitting Data

An important area for concern or caution in machine learning is the ratio of features to samples. This concern is especially important in computational text analysis, where there are often small training samples and hundreds of thousands different tokens (words, punctuation, etc.) that one could use as training features. The biggest potential liability of having too many features is over-fitting. When a model is trained on sparse data, the presence of each additional training feature increases the probability of a spurious correlation, a purely coincidental association between, say, a particular term frequency and the date we are trying to predict. When a model is too well fitted to its training data, the model will fail to provide meaningful predictions on other datasets.  

When employing computational text analysis in a scholarly context, one can limit the number of features in a model in several ways:

1. Using feature consolidation and/or dimension reduction strategies such as stemming/lemmatization and Principal Component Analysis (PCA)
2. Limiting term lists to the top K most frequent terms in the corpus
3. Employing feature selection techniques such as with a variance threshold or a univariate feature selection strategy

In the context of a more general lesson on regression, I have included some code to employ a two-step feature selection strategy. The intuition behind this is relatively straightforward. First, we select the 10,000 most frequent features in the book reviews as a whole. Second, after executing our TF-IDF transformation, we conduct univariate feature selection to find the most promising 3,500 features of these terms, as represented by the scikit-learn `f_regression()` scoring function. I'll come back to this scoring function in a moment but, first, let's isolate the top 10,000 terms in the corpus. 

```python
from collections import Counter 

def top_words(number, list_of_dicts):
    totals = {}
    for d in list_of_dicts:
        for k,v, in d.items():
            try:
                totals[k] += v
            except: 
                totals[k] = v
    totals = Counter(totals)
    return [i[0] for i in totals.most_common(number)]

def cull_list_of_dicts(term_list, list_of_dicts):
    results = []
    for d in list_of_dicts:
        result = {}
        for term in term_list:
            try:
                result[term] = d[term]
            except:
                pass 
        results.append(result)
    return results

top_term_list = top_words(10000, list_of_dictionaries)
new_list_of_dicts = cull_list_of_dicts(top_term_list, list_of_dictionaries)
```

This block of code begins by importing a very useful class from Python's `collections` library called a `Counter()`. Counter's are a little bit like Python dictionaries, but they have built-in methods that make some common operations especially easy. In our case, the first of our two functions determines the top N terms in the corpus. We loop through our entire list of dictionaries and build up a single vocabulary Counter with cumulative counts for each term. We then use our Counter's `most_common()` method to return the keys and values of the top N terms in that vocabulary. The `number` parameter supplies the number of terms the function will return. 

Our second function takes two parameters: a term list and a list of dictionaries. It loops through the list of dictionaries and, for each dictionary, it checks each term against the term list. Words that match are compiled to a new list of dictionaries, and words that do not are skipped over. The output of this second function is stored as a variable called `new_list_of_dicts`. It has the same order as `list_of_dictionaries`, but now only the top 10,000 terms are represented in these dictionaries.  

After running both of these functions, we are ready to compute TF-IDF scores. In the previous section, we stored our `DictVectorizer()` instance as a variable called `v`, so we can use that variable here to fit the object with our `new_list_of_dicts` data.

```python
from sklearn.feature_extraction.text import TfidfTransformer

X = v.fit_transform(new_list_of_dicts)
tfidf = TfidfTransformer()
Z = tfidf.fit_transform(X)
```

In this code block, we import the `TfidfTransformer` class from scikit-learn, instantiate a `TfidfTransformer`, and run the `fit_transform()` method on `v`. At the end of this code block, the data is in a format that scikit-learn's regression models (and other machine learning models) can now understand.

However, we still need to execute step 2 of our feature selection strategy: using the scikit-learn `f_regression` scoring function to isolate the most promising 3,500 TF-IDF features out of the top 10,000 terms from the vocabulary. The `f_regression` function computes a correlation between each feature and the dependent variable, converts it to an F-score, and then derives a p-value for each F-score. No doubt, some of the "K Best" terms selected by this procedure will be highly correlated with the training data but will not help the model make good predictions. However, this approach is easy to implement and, as we will see below, produces a reasonably strong model.  

```python
from sklearn.feature_selection import SelectKBest, f_regression
Z_new = SelectKBest(f_regression, k=3500).fit_transform(Z, date_labels)
```

We've now reduced our model to 3,500 features: that is, terms and TF-IDF scores that are likely to help us predict the publication date of book review. The next code block partitions the data into a training set and a test set using scikit-learn's `train_test_split()` function. Creating a split between training and test data is especially important since we still have a lot of features, and a very real possibility of over-fitting. 

```python
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(Z_new, df_all['yearDecimal'], test_size=0.33, random_state=31)
```

The operation creates four variables: training data, training labels, test data, and test labels. Since we are training a model to predict dates, the training and test data are the decimal dates that we previously generated and stored in the `yearDecimal
` column of `df_all`. The `test_size` parameter is used to set the ratio of training to test data (approximately 2 to 1 in this case) and the `random_state` parameter is used to make sure that, if one were rerunning the split, different rows would be selected.

### Let's Pause: A Look at the Training and Test Data 

The next few steps involve relatively few lines of code because they are based on a very common sequence of actions. The scikit-learn library has made these steps especially straightforward. Setting up the data is, by comparison, more involved because scikit-learn is designed to work easily as long as the data are prepared in specific ways. If you haven't done so already, take a look at the data stored in the variables `X_train`, `X_test`, `y_train`, and `y_test`. Assuming you are working in a Jupyter Notebook, you can inspect any of these variables by typing the variable's name in an empty Notebook cell and pressing the "Run" button (assuming you've already run all the code blocks above). Let's start with `X_train`. For this variable, your Jupyter Notebook output will look something like this:

```
<1514x3500 sparse matrix of type '<class 'numpy.float64'>'
 	with 278586 stored elements in Compressed Sparse Row format>
```

This message tells us that `X_train` is a sparse matrix made up of float64 data. This data type comes from the numpy library and is used to represent 64-bit floating-point numbers, which have the same level of precision of Python’s built-in `float` type). The dimensions 1514x3500 tell us that we have 1514 reviews in our training data, and 3500 TF-IDF weighted terms from which to train the model.[^11] Scikit-learn expects independent variables (training and test) to stored in an array-like object with the dimensions [number-of-samples x number-of-features], whether that's a scipy sparse matrix, a pandas DataFrame, a numpy array, or a standard-Python list of lists.

Meanwhile, if you inspect `X_test`, you will see something like this:

```
2803    1920.830487
2961    1910.671233
1841    1923.956164
1926    1924.415187
3025    1916.863388
           ...     
1823    1923.821918
1448    1916.155738
1070    1907.490411
1164    1910.517808
1132    1909.175342
Name: yearDecimal, Length: 1514, dtype: float64
```

This block of output is also a group of float64 values, but this time they are contained within a pandas Series. A Series is a one-dimensional sequences of values with axis labels built on top of numpy's `ndarray` class. It is similar to a pandas DataFrame, but it represents only one dimension of data, so it's the default type for a single column from a pandas DataFrame.[^12] In scikit-learn, training and test labels should be an array-like object with a length equal to the number of samples or, if multiple labels are being predicted, an array-like object with the dimensions [number-of-samples x number-of-targets]. A group of one-dimensional target labels can be a pandas Series, a numpy array, or a Python list. 

### Step 6: Training the Model

Equipped with a better understanding of what our data looks like, we can proceed to importing a `LinearRegression()` class from scikit-learn, instantiating it as a variable, and fitting the newly designated model with our training set. As stated, scikit-learn makes these steps easy, so we only need three lines of code:

```python
from sklearn.linear_model import LinearRegression
lr = LinearRegression()
lr.fit(X_train, y_train)
```

### Step 7: Generate Predictions

Now that the model has been trained, we will use the fitted model to generate label predictions on the test data. We need to execute the `lr` instance's `predict()` method, using the variable `X_test`. Remember, `X_test` is a matrix-like object with the same number of variables and observations as `X_train` but, significantly, our model has never seen these rows of data before.

```python
results = lr.predict(X_test)
```

After this line of code has been run, `results` will be a one-dimsensional numpy array with a length equal to the number of rows in `X_test` and, by definition, the same number of rows in `Y_test`. What's more, all three variables represent the same observations, in the same order. For example, the first row of `X_test` represents TF-IDF values for terms in a book review, the first value in `results` represents the predicted year of that book review, and the first value in `Y_test` represents the labeled year of that book review. Maintaining the sequencing of these three variables will make it easier to evaluate the performance of our predictions in the next step. 

### Step 8: Evaluating Performance

A linear regression model can be evaluated using several important metrics, but the most important thing to bear in mind is whether the model is making (or will make) consistently good predictions. This why this lesson demonstrates splitting the data into partitioned training and test sets. Now that we've generated predictions and stored them in the `results` variable, we can compare those predictions to the test labels in `Y_test`. We can obtain a good first impression a linear regression model's performance by calculating the r&#178; (pronounced r-squared) score, finding the mean of the residuals, and making a histogram or kernel density estimate (KDE) plot to see how the residuals are distributed. We can then flesh out this picture by computing an f-statistic and a p-value.

An r&#178; score computes the "coefficient of determination" of the regression model, which is the proportion of the variance in the dependent variable that is predictable from the independent variable or variables.[^13] Scikit-learn has a built-in r&#178; scoring function, but the math behind this score is relatively simple, and writing our own function from scratch will help us understand what is captures. If you want to skip this step, you can simply do the following:

```python
from sklearn.metrics import r2_score
r2_score(list(y_test), list(results))
# result will be something like 0.4408184014714299
```

You'll notice that the first step in the function below is to calculate the residuals, which represent the differences between predictions and test labels. I'll say more about those in just a moment. First, let's take a look at this block of code:

```python
def r_square_scratch(true, predicted):
    # substract each predicted value from each true
    residuals = [a - b for a, b in zip(true, predicted)]
    # calculate the sum of squared differences between predicted and true 
    mss = sum([i**2 for i in residuals])
    # calculate the mean true value
    mean_true = (sum(true))/len(true)
    # calculate the sum of squared differences of each true value minus the mean true value
    tss = sum([(i-mean_true)**2 for i in true])
    # calculate final r2 value
    return 1-(mss/tss)

# call the function 
r_square_scratch(list(y_test), list(results))
# this will return something like 0.44081840147143025
```

If you've been following along, you can paste this entire code chunk in a Jupyter Notebook cell and run it. It is dependent only on the `y_test` and `results` variables, as the rest is Python standard. Here's a step-by-step breakdown of the function:

1. Calculate the difference (i.e. residual) between each true review date and each predicted date 
2. For each residual, square the value
3. Add all the squared values together to derive the "model sum of squares" (MSS)
4. Calculate the mean true value by adding all the true values together and dividing by the number of observations
5. For each true review date, subtract the mean true value and square the result
6. Add all these squared values together to derive the "total sum of squares" (TSS)
7. Calculate the final r&#178; score, which equals 1-(mss/tss)

In our case the result is about 0.441.[^14] Since this is the amount of variance in the book review date field that can be predicted by a sample of a book review's TF-IDF scores, the best value would be a 1.0. (However, the r&#178; score can also be less than zero if the model performs worse than random guessing.[^15]) This particular r&#178; score tells us that our features are giving us some information, but perhaps not a lot. 

### Step 9: Model Validation

Linear regression depends upon certain assumptions about the data on which it is modeling. In statistics, determining whether these assumptions are met is part of the process of validation. Statistical validation is generally concerned with whether a selected model is appropriate for the data being analyzed. However, validation of this sort should not be confused with the broader idea of validity in the social sciences, which is "concerned with the meaningfulness of research components," specifically whether the research is measuring what it intends to measure.[^16]

Questions of validity in the social sciences, for example, might include, "Does the IQ test measure intelligence?" and "Does the GRE actually predict successful completion of a graduate study program?"[^17] Helpfully, Ellen Drost divides Validity in social sciences research into four subcategories: statistical conclusion validity, internal validity, construct validity, and external validity.[^18] In Drost's schema, linear model validation is perhaps best viewed as part of statistical conclusion validity, but model validation has a more specific and targeted meaning in statistics. 

Validating a linear regression model often includes an examination of the three integral assumptions: that the residuals are normally distributed; that the independent variables are not overly correlated; and that the model's errors are homogeneous across different ranges of the dependent variable. Depending on your home discipline or target scholarly journal, assessing these assumptions may be viewed with varying degrees of concern. Learning to spot errors related to these concepts, however, can make you a much more proficient and effective data analyst no matter what field you call your home. 

__Distribution of Residuals:__ As stated above, residuals represent the differences between predictions and test labels. Perhaps more precisely, a residual is the vertical distance between each predicted value and the regression line. If the prediction is above the regression line, the residual is expressed as a positive value and, if the prediction is below the regression line, the residual is expressed as a negative number. For example, if my book reviews model a predicted a review's year was 1915 and the labeled year was 1911, the residual would be 4. Likewise, if my model predicted a review's year was 1894 and the labeled year was 1907, the residual would be -13. 

Making a pandas DataFrame is a nice way to compare a model's test set predictions to the test set's labels. Let's make a DataFrame with predicted book review dates in one column and actual book review dates in another.  

```python
results_df = pd.DataFrame()
results_df['predicted'] = list(results)
results_df['actual'] = list(y_test)
results_df['residual'] = results_df['predicted'] - results_df['actual']
results_df = results_df.sort_values(by='residual').reset_index(drop=True)
results_df.describe()
```

The code chunk above creates an empty DataFrame, inserts the first two columns, and then subtracts the first column value from the second column value to make a new column with our residual values in it. Lastly, we sort the values by the residual score (lowest to highest) and reset the DataFrame's index so that it will be numbered in the order that it's been sorted. If you paste this code chunk in a Jupyter Notebook cell and run it, you should see a DataFrame with 
output like this:

| | predicted | actual | residual |
|---|---|---|---|
| count| 169.000000 | 169.000000 | 169.000000 |
| mean | 1917.276958 | 1917.428992 | -0.152034 |
| std | 5.815610 | 5.669469 | 4.236798 |
| min | 1894.024129 | 1906.013699 | -13.399405 |
| 25% | 1912.849458 | 1912.647541 | -3.067451 |
| 50% | 1917.948008 | 1918.799886 | -0.484037 |
| 75% | 1921.142702 | 1922.671119 | 2.491212 |
| max | 1932.678418 | 1924.950820 | 13.878532 |

| | predicted | actual | residual |
|---|---|---|--|
| 0 | 1898.616989 | 1912.016393 | -13.399405 |

This DataFrame is the result of running Pandas' `describe()` method. It will provide useful descriptive statistics (mean, standard deviation, minimum, maximum, etc.) for column in our DataFrame. Here the output is telling us that our lowest residual is from a prediction that guessed a date more than 13 years before than the actual date of the review. Meanwhile, our highest residual is 13.878532. For that review, the model predicted a date almost 14 years later than the book review's actual date. 75% of our predictions are between 2.49 and -3.07 years of the book review's labeled date, and our mean residual is about -0.48. 

To look specifically at the distribution of the residuals, we can use a histogram or a kernel density estimate (KDE) plot. With the Seaborn library, either plots requires only a few lines of code:

```python
%matplotlib inline 
import seaborn as sns 

# histogram
sns.histplot(data=results_df['residual'])

# kde plot
sns.kdeplot(data=results_df['residual'])
```

This chunk of code imports the Seaborn library and generates both plots using only the `residuals` column of the `results_df` DataFrame. Note that I've written the above chunk with the assumption that you'll be working in a Jupyter Notebook. In this context, the cell magic `%matplotlib inline` will make the graph appear as notebook output. The results should look something like this:

![Histogram of residuals](hist.png)

![ KDE plot of residuals ](dist.png)

From either visualization, we can see that the center values (residuals close to zero) are the most frequent. Our model doesn't appear to be systematically predicting dates that are too low or too high since a residual close to zero is our mean, and the bars of our histogram (and lines of the kde plot) slope steadily downward, which tells us that the larger prediction errors occur with less frequency. Lastly, both plots are generally symmetrical, which means that negative and positive residuals appear to be relatively common. Using a statistical metric called a Shapiro-Wilk test, we can quantify how well this distribution fits the expectations of normality, but a visual evaluation such as the one above is often sufficient. 

__Multicollinearity:__ Collinearity describes a situation in which an independent variable in a model affects another independent variable, or when the pair have a joint effect on the variable being predicted. For example, if one were using various weather indicators--temperature, barometric pressure, precipitation, cloud coverage, wind speeds, etc.--to predict flight delays, it's plausible if not likely that some of those weather indicators would be correlated with each other, or even have causal relationships. When collinearity occurs between more than two factors, it is termed multicollinearity.[^19] Multicollinearity is a concern in machine learning because it can distort a model's standard error, its t-ratios and the p-values of a model's coefficients.[^20] 

Multicollinearity, as a result, can make it difficult to isolate the effects of each independent variable on the dependent variable.[^21] In the context of a linear regression, there may not be a "unique optimum solution" for the line of best fit, which means that the resulting regression coefficients probably aren't stable.[^22] Several strategies can be employed to reduce multicollinearity, including removing redundant or highly correlated features; collecting more data; variable regularization; constrained least-squares estimates of the coefficients; and 
Bayesian methods of estimation in place of least squares where appropriate.[^23] 

One way to assess multicollinearity is to make a heat map of the correlations among independent variables (i.e., a correlation matrix). This can approach can become dicey when working with term frequency data. In computational text analysis, where so many features are used, this is approach is untenable. What's more, there will almost certainly be some highly correlated term frequencies or TF-IDF scores among so many possibilities. Under these circumstances, Gentzkow, Kelly, and Taddy suggest that "the inevitable multicollinearity makes individual parameters difficult to interpret" but they add that "it is still a good exercise to look at the most important coefficients to see if they make intuitive sense in the context of a particular application."[^24] It should also be noted that, with many uses of text mining, our study design doesn't reflect our theory of causality. In our case, we (hopefully) don't believe that a book review's term frequencies or TF-IDF scores cause that book review to be from a different time period. If anything, we think the date of a review might help shape its term frequencies or TF-IDF scores, but it's most likely the case that unknown factors (historic events, shifting trends in desirable book topics, etc.) have some influence on what was reviewed or how reviews were written. In some disciplines, using a regression model in this way is frowned upon or eschewed, but it has become the norm in many fields.

__Homoscedasticity:__ Homoscedasticity, also called "homogeneity of variance," describes a situation in which a model's residuals are similar across the ranges of the independent and dependent variables.[^25] Homoscedasticity is necessary because it's one of the core assumptions of a linear regression model. Heteroscedasticity or non-homogeneity of variance could signal an underlying bias to the error or an underlying pattern that better explains the relationship between the independent variable(s) and the dependent variable. This concept may sound complex, but it makes more sense if you think about what could happen if you try to squeeze a non-linear relationship into a linear model. 

If a model's predictions are accurate for the values in the middle range of the data but seem to perform worse on high and low values, this could be a sign that the underlying pattern is curvilinear. Like any straight line through any curve, the two might line up reasonably well for some small range of the curve but, eventually, the curved data would veer off and the line would maintain its course. 

If a model's predictions seem strong everywhere except the high values or the low values, you could have a relationship that flattens at some theoretical maximum or minimum value. The relationship between headlines about an epidemic and Google searches for the disease causing it could be very strong, to point, and then Google searches could plateau after the headlines reach a certain saturation point. Alternatively, this kind of heteroscedasticity could be a sign of a positive correlation that peaks at some value and then starts to drop and become a negative correlation. For example, outdoor temperature could be a positive indicator of outdoor activity up to a certain threshold (maybe 78 degrees) and then become a negative indicator of outdoor activity beyond that threshold, with each degree increase making outdoor activity less likely. 

This is not an exhaustive list of the signs of heteroscedasticity you might encounter but, in evaluating homoscedasticity, these are the kinds of patterns you should be looking for; that is, indications that the model makes good predictions in one or more pockets of the data and poor predictions elsewhere. One simple way to discover such heteroscedasticity is to make a scatter plot of the model's performance on the test set, with the model's predictions on one axis and the test values on other other axis. A straight line representing the plane where predicted and test values are equal can be added to this graph to make it easier to see patterns. Here is a block of Python code making such a plot for the book review predictions:

```python
import matplotlib.pyplot as plt
plt.xlim(1906, 1925)
plt.ylim(1895, 1935)
plt.scatter(results_df['actual'], results_df['predicted'], alpha=.35)
plt.plot([1895, 1935], [1895, 1935], color='black')
plt.title("Plot of Linear Regression Test Values, Predicted vs. Actual")
plt.subplots_adjust(top=0.85)
plt.show()
```

In this block of code, we have imported `pyplot` as `plt` so it's a bit easier to type. We set the limits of the x-axis to 1906 on the low end and 1925 on the high end because we know all of our labels fall between that range. In contrast, we set the limits of the y-axis to 1895 on the low end and 1935 on the high end because we know that some of our inaccurate predictions were as high as 1935 and as low and 1895. (These were the high and low values from running the `summary()` method.) The matplotlib `scatter()` method creates our scatter plot, and we use the `actual` and `predicted` columns of `results_df` for our x and y values respectively. We use the `alpha` property to make the scatter plot points 35% percent transparent. 

In the next line of code, we add a black, straight line to the plot. This line begins at the position y=1895, x=1895 and represents an angle of ascent where x and y are always equal. If our scatter plot points overlap with this line, this means the predicted and labeled values are equal or close to equal. Each point's vertical distance from the black line represents how different the prediction was from the test set label. 

Finally, we add a title to the plot with the `title()` method and use `subplots_adjust` to create some extra space for the title at the top of the plot. If you copy and paste this code chunk, the results should look something like this:

![Plot of Linear Regression Test Values, Predicted vs. Actual](predicted_actual.png)

If you look closely at this image, you'll notice a few things. First, there are several extreme values are outside the 1906-1924 range (12 values equal to or greater than 1925 and three values equal to or less than 1906.)  Focusing on the reviews published between 1906 and 1911, the predictions tend to have positive residuals, which means the model tends to predict that they are from later years. Looking at the reviews published between 1918 and 1926, the predictions tend to have negative residuals, which means the model tends to predict that they are from earlier years. Reviews published between 1912 and 1917 tends to have a more even mix of positive and negative residuals. That said, there are numerous values above and below the line in all ranges, and there is no sign of any large bias, but rather a model that tends to make predictions marginally closer to the middle range of the data, which helps explain our relatively low r&#178; value. Overall, the majority of values are relatively close to the line where the residuals equal zero. (About 78% of the predictions have residuals between -5 and 5, and abut 22% of the predictions are off by more than five years in one direction or the other.)

### Some Brief Remarks on F-Statistics

Depending on the context and scholarly discipline, a metric called an F-Statistics can be a crucial aspect of assessing a linear regression model. With multiple linear regression, an F-test evaluates the statistical significance of the independent variables. Like many statistical tests of significance, it computes both a test statistic and a p-value. In this case, it tests against the null hypothesis that the independent variable coefficients are zero; or, put another way, that the predictor variables provide no real information about the value of the thing we are trying to predict. With any isolated sample of data, there is a possibility that the observed effect is just a coincidence so this statistical test, like others, attempt to use the sample size and the magnitude of the observed effect as factors in assessing how likely one might be to end up with this kind of sample if the true coefficients were zero. Generally speaking, if the model is not statistically significant (p-value less than 0.05), the r&#178; score cannot be considered meaningful.[^26] In our case, use an F-Statistic for as a performance metrics wouldn't be meaningful because we have used F-Statistic p-values to select features. 

### Step 10: Examine Model Intercept and Coefficients

Now that we have assessed the performance of our model and validated the assumptions of linear regression, we can look at the intercept and coefficients. Remember, the intercept tells us what our Y value will be when X equals zero, and coefficients give us the slope or rise-over-run multiplier for each feature. In our `lr` model, the intercept can be accessed with the code `lr.intercept_`. Our intercept is about 1913.44 so, if we had a review with none of our selected features in it, the predicted date would be 1913.44.

However, for most (and hopefully all) of our predictions, we should have some non-zero TF-IDF scores for our features. For each feature, we generate our prediction by multiplying the TF-IDF value by its coefficient and then add all the products together with the intercept. For example, if we had a book review with only two of our words in it, with the TF-IDF scores of 0.8 and 0.5 respectively, and coefficients of 25 and -18 respectively, our equation would look like this:

```
predicted_date = (0.8*25) + (0.5*-18) + 1913.44
```

which is equivalent to ...

```
predicted_date = (20) + (-9) + 1913.44
```

and is also equivalent to ... 

```
predicted_date = 1924.44
```

The closer any given coefficient is to zero, the less influence that term will have on the final prediction. If any of our coefficients or TF-IDF values are exactly zero, that feature will have no influence in either direction. As a result, it can be illuminating to look at the kind of features with very high or low coefficients.  

To accomplish this goal, we will make a DataFrame of terms and their coefficient scores. DataFrames are useful for these types of lists because they can be sorted and filtered easily, and they can be quickly exported into a variety of file formats, including CSV and HTML.  

```python
features = SelectKBest(f_regression, k=3500).fit(Z, date_labels)

selected = features.get_support()

features_df = pd.DataFrame()
features_df['term'] = v.feature_names_
features_df['selected'] = selected
features_df = features_df.loc[features_df['selected'] == True]
features_df['coef'] = lr.coef_

coefficients = features_df.sort_values(by='coef', ascending=False).reset_index(drop=True)
```

In this block of code, we begin by backing up to the feature selection stage and run a `fit` method instead of `fit_transform` so that we can line up the selected features with the names of the terms from our vocabulary. We can then use the `get_support()` method to return a list of True or False values for all 10,000 terms in our `DictVectorizer` instance. The True and False values here represent whether a given term was selected by the `SelectKBest` method. The output of `get_support()` is already in the same order as `v.feature_names_`, so we don't need to do anything to align these two lists. Instead, we can create an empty pandas DataFrame, create a column of all 10,000 features names, and create a second column of all our True and False values. We can then use the `loc()` method to filter out all the features with False values. The resulting DataFrame has 3,500 rows, and the original order has been preserved, so this list is in the same order has the coefficient values in `lr.coef_`. We create a new column in our DataFrame for these coefficients and, finally, we sort the entire DataFrame by coefficient values, with the largest coefficient on top. After these steps are complete, we can browse the top 25 terms and coefficients with one line of code:

```python
coefficients.iloc[0:25]
```

If you have followed the steps above, your top 25 coefficient output should look like this:

| index | term        | selected | coef        |
|-------|-------------|----------|-------------|
| 0     | today       | TRUE     | 48.73025541 |
| 1     | hut         | TRUE     | 37.95476112 |
| 2     | action      | TRUE     | 32.7580998  |
| 3     | expansion   | TRUE     | 32.22799018 |
| 4     | di          | TRUE     | 26.94660532 |
| 5     | paragraphs  | TRUE     | 26.59646481 |
| 6     | recounted   | TRUE     | 25.73118544 |
| 7     | deemed      | TRUE     | 25.58949141 |
| 8     | paragraph   | TRUE     | 25.4695864  |
| 9     | victorian   | TRUE     | 25.43889262 |
| 10    | eighteenth  | TRUE     | 24.96393149 |
| 11    | bachelor    | TRUE     | 24.69907017 |
| 12    | feeling     | TRUE     | 24.28307742 |
| 13    | garibaldi   | TRUE     | 24.18361705 |
| 14    | interpreter | TRUE     | 24.04869859 |
| 15    | continued   | TRUE     | 24.03201786 |
| 16    | hot         | TRUE     | 23.64065207 |
| 17    | output      | TRUE     | 23.53388803 |
| 18    | living      | TRUE     | 23.38540528 |
| 19    | emma        | TRUE     | 23.30372737 |
| 20    | renewed     | TRUE     | 23.28669294 |
| 21    | hence       | TRUE     | 23.10776443 |
| 22    | hoy         | TRUE     | 23.01967989 |
| 23    | par         | TRUE     | 23.01131685 |
| 24    | review      | TRUE     | 22.92900629 |

When it comes to interpreting these top scoring coefficients, it is important to bear in mind that term lists like these will stir possibilities in the mind of the reader, but the patterns causing these terms to become good predictors may not be the patterns you are noticing, and they might be the result of interpretative noise rather than signal. 

From this list, for example, we might wonder if _emma_ is associated with more recently published book reviews because Jane Austen's _Emma_ enjoyed a resurgence, or perhaps the name _Emma_ was just becoming more popular over time. However, if we look more closely at our corpus, we can discover that at least one of our reviews refers to English spiritualist Emma Hardinge Britten, one is a reference to Emma Watson from Jane Austen's _The Watsons_, and one is a review of a book about Queen Wilhelmina, whose mother was Emma of Waldeck and Pyrmont. With single-word coefficients, a mix of various fictional characters, book reviewers, authors, and other names mentioned in review could suggest a trend that doesn't exist. 

To add to our list of caveats, let's remember that our original feature selection strategy first isolated the top 10,000 words in the corpus by frequency, and then culled that list to 3,500 terms using p-values from F-tests on TF-IDF transformed term scores. What's more, a high degree of multicollinearity probably means that the specific rankings of coefficients are not meaningful. 

Regression coefficients with this kind of analysis, then, are best viewed as the starting point for further research rather than the end of a trail. On the hand, the fact that words like _review_,  _paragraph_, _paragraphs_, and _victorian_ are associated with later reviews raises some interesting questions that one might pursue. Did reviews become more self-referential over time? Was there an increase in books on the Victorian Age as the era became more distant?  

In turn, we can look more closely at terms most associated with earlier book reviews. Remember, coefficients at or near zero are basically unimportant to the value, but coefficients at either extreme--positive or negative--are exerting the most influence on our predictions. High coefficient scores will push the prediction to a later date and low coefficient scores will push it to a later date. Just as we did with the top 25 coefficients, we can view the 25 lowest coefficient values with a single `iloc` statement:

```python
coefficients.iloc[-25:]
```

If you're following along, the output of this line of code should look like this:

| index | term         | selected | coef         |
|-------|--------------|----------|--------------|
| 3475  | mitchell     | TRUE     | -23.7954173  |
| 3476  | unpublished  | TRUE     | -23.8369814  |
| 3477  | imported     | TRUE     | -23.88409368 |
| 3478  | careless     | TRUE     | -23.93616947 |
| 3479  | strange      | TRUE     | -24.34135893 |
| 3480  | condemnation | TRUE     | -24.43852897 |
| 3481  | destroy      | TRUE     | -24.75801894 |
| 3482  | addressed    | TRUE     | -24.84150245 |
| 3483  | strong       | TRUE     | -24.87008756 |
| 3484  | hunted       | TRUE     | -24.971894   |
| 3485  | presumably   | TRUE     | -25.1690956  |
| 3486  | delayed      | TRUE     | -25.64993146 |
| 3487  | estimated    | TRUE     | -25.76258457 |
| 3488  | unnecessary  | TRUE     | -26.71165398 |
| 3489  | reckless     | TRUE     | -27.0190841  |
| 3490  | painter      | TRUE     | -27.38461758 |
| 3491  | questioned   | TRUE     | -27.4071934  |
| 3492  | uncommon     | TRUE     | -27.9644468  |
| 3493  | cloth        | TRUE     | -28.06872431 |
| 3494  | salon        | TRUE     | -28.37312216 |
| 3495  | enhance      | TRUE     | -31.65955902 |
| 3496  | establishing | TRUE     | -31.78036166 |
| 3497  | capt         | TRUE     | -31.82279355 |
| 3498  | discussion   | TRUE     | -32.60202105 |
| 3499  | appreciation | TRUE     | -34.41473242 |

Note that, for this DataFrame, the lowest coefficients (and therefore mostnimformative to the model) are at the bottom of the list, meaning that terms like _appreciation_, _discussion_, and _capt_ are more suggestive of an earlier publication date than _enhance_ or _salon_. When it comes to interpreting these term coefficients, all the caveats from above are applicable.  Nevertheless, again we see some terms that raise questions. Was the word _unpublished_ associated with reviews of earlier years because unpublished reviews were more likely to be reviewed? Does the word _appreciation_ refer to the genre known as an appreciation and, if so, were these more common at the turn of the century? Does the presence of the term _uncommon_ in some reviews suggest the declining use of _uncommon_ as a compliment meaning 'remarkably great' or 'exceptional in kind or quality', especially when describing a person's moral character?[^27] Each of these questions is one of many threads we might pull.

## Overview of Logistic Regression

As with linear regression, a high-level appraisal of logistic regression is easiest to describe when a problem with one continuous independent variable and one binary, nominal dependent variable is presented. For example, we might attempt to use a continuous variable such as the relative frequency of a particular word to predict a binary such as "book review or not book review" or "author assumed to be male" vs "author assumed to be female." Where raw counts of term frequencies would be considered discrete variables, relative frequencies are treated as continuous data because they can take on any value within an established range, in this case any decimal value between 0.0 and 1.0. Likewise, TF-IDF scores are weighted (in in this case scaled), continuous variables. 

Regarding the selection of a binary variable to predict, many humanists will be wary of the word _binary_ from the outset, as post-structuralism and deconstruction are both rooted in the idea that conceptual binaries are rooted in linguistic conventions, inconsistent with human experience, and used in expressions of social control. I will return to this topic later in the lesson but, for now, I would offer the perspective that many variables can be framed as binary for the purposes of logistic regression analysis that might otherwise be better regarded as ordinal, nominal, discrete or continuous data. As I state in my article for _Cultural Analytics_, "my work seeks to adopt a binary, temporarily, as a way to interrogate it."[^28] Later in this lesson, I'll go a step further than I did in that article by demonstrating what happens when you use a binary regression model to make predictions on non-binary data.  

Consider the following plot visualizing the relationship between "presumed gender" and the relative frequency of the word _she_: 

![Bar plot of gender label split for frequency ranges of the word 'she'](book_reviews_she_logit.png)

This stacked bar chart shows three ranges of frequency values for the term _she_. In the first range or bucket (farthest to the left), the lowest frequencies for the term _she_ are represented. The second bucket (in the center) contains the middle range of values, and the third bucket (farthest to the right) contains the highest frequencies of the word _she_. The two colors in each bar represent the number of reviews labeled male and female respectively, such that the ratio of male labels to female labels is demonstrated for each frequency range. From this visualization, we can see that there are many more male-labeled reviews in the data than female-labeled reviews and that, in the mid-range and higher-range buckets, there are more female labels than male labels. In the lowest frequency range, the majority but not all of the reviews have male labels. In turn, most of the reviews with male labels are found in this range. It's also the case that the majority of the reviews with female labels are found in this range. This apparent contradiction is made possible the overall ratio of male to female labels in the data. 

Based on our data, a higher frequency of the term _she_ seems to suggest a greater likelihood of a female label. A logistical regression function, however, does merely solve for "the conditional probabilities of an outcome" but rather generates a  "mathematical transformation of those probabilities called logits."[^29] The term _logit_ itself is a shortened version of "logistic unit," and a logistic regression model is sometimes called a logit model for short.   

The math behind this function is more complicated than a linear regression, but the usage is quite similar. When a given predictor value is a supplied, a probability of a binary label is mathematically calculated. As with a linear regression, the sigmoid function requires an input variable (such as the frequency of _she_ in our case), along with a coefficient and an intercept. The relationship of all possible values to their derived probabilities will form an S shape, or a sigmoid curve. As a result, a logistic regression model is a type of sigmoid function.  

Our logit model can convert any real number input to a value between zero and one.[^30] The mathematical formula looks like this:

$$
P(Yi = 1|Xi = v) = \frac {e^{(a + bXi)}}{[1 + e^{(a + bXi)}]}
$$
In this equation, _P(Yi = 1|Xi = v)_ represents the given probability we wish to calculate. _e_ represents the natural log, _a_ represents the intercept, _b_ represents the coefficient, and _Xi_ represents the predictor variable's value. Putting this all together, we get the following procedure. 

1. Multiply the variable's coefficient (_x_) by the predictor value and add the intercept (_a_) to that product.
2. Calculate the natural log of that product (_e^(a+ bXi)_) 
3. Divide that natural log by the sum of that natural log and the number 1 (making sure that the sum is calculated before division occurs)

Of course, you can still get a lot of utility out of a logit model without understanding all of its mathematical underpinnings.

You can always train a model using the code below and come back to this math later to make sure the coefficients and intercepts produce the predictions you were expecting. For now, it's important to understand that, as the value of the predictor variable increases, the probability of the binary response variable rises or falls. How much it rises or falls is based on the values of the intercept and the coefficient. It's also import to understand that the coefficient and the predictor variable's value are multiplied together, so their importance to the model is a combination of both. This way, if the variable has little or no predictive relationship with the binary response variable, the probability for each predictor value will either be the same as it is for every other value, or only slightly different. However, no matter how high or low the predictor goes, the derived probability will be somewhere between 0 and 1, which can also be expressed as a percentage.

## Logistic Regression Procedure

### Step 1: Loading metadata

As with linear regression, we can load our metadata from `metadata.csv` and `meta_cluster.csv` and join them together with a `pd.concat()` method. And don't forget to import pandas as pd!

```python
import pandas as pd
df = pd.read_csv("metadata.csv")
df_cluster = pd.read_csv("meta_cluster.csv", dtype={'cluster_id': str})
df_all = pd.concat([df,df_cluster], axis=0, ignore_index=True, sort=True).fillna('none')
```

### Step 2: Preparing The Data and Creating Binary Gender Labels

In this step, we will prepare DataFrames for logistic regression analysis. 

```python  
df_binary = df_all.query("perceived_author_gender == 'm' or perceived_author_gender == 'f'").reset_index(drop=True)
df_non_binary = df_all.query("perceived_author_gender == 'none' or perceived_author_gender == 'dual'").reset_index(drop=True)
```

Using `loc()` statements to the filter the data, we set one DataFrame to consist of samples where the `perceived_author_gender` is labeled either `m` or `f` and then create a separate DataFrame for our non-binary gender labels, where `perceived_author_gender` is labeled either `none` or `dual` (meaning two or more authors with more than one gender label was used). In both cases, we use `reset_index(drop=True)` to renumber the DataFrame indices for our new samples. 

For our binarized data, we also need to convert our `m` and `f` values to zeros and ones so scikit-learn can read them as labels. In this case, we set `f` to 0 and `m` to 1, but this is an arbitrary choice. 

```python
y_binary = list(df_binary['perceived_author_gender'])
y_binary = [0 if i == 'f' else 1 for i in y_binary]
```

We will use these labels later for training and testing our logistic regression model. 

### Step 3: Loading Term Frequency Data, Converting to Lists of Dictionaries

As with linear regression, we need to load our term frequency data from CSV files and convert our data to a list of dictionaries. This block of code is identical to the linear regression version, except for the fact that we runs the `iterrows()` method on `df_binary` instead of `df_all`.

```python
list_of_dictionaries_binary = []
for row in df_binary.iterrows():
    if row[1]['cluster_id'] == 'none':
        txt_file_name = ''.join(['term-frequency-tables/', row[1]['nyt_id'], '.csv'])
    else:
        txt_file_name = ''.join(['term-frequency-tables/', row[1]['nyt_id'], '-', row[1]['cluster_id'], '.csv'])

    df = pd.read_csv(txt_file_name).dropna().reset_index(drop=True).set_index('term')
    mydict = df['count'].to_dict()

    list_of_dictionaries_binary.append(mydict)

len(list_of_dictionaries_binary)
```

After this loop executes, the length of `list_of_dictionaries_binary` should be 2,888. This number represents the number of book reviews in the sample with either an `m` or `f` label.  

### Step 4: Converting data to a document-term matrix

As with our linear regression model, we need to instantiate a `DictVectorizer` object. To differentiate it from the linear model `DictVectorizer`, let's call it `v_binary`.

```python
from sklearn.feature_extraction import DictVectorizer
v_binary = DictVectorizer()
```

### Step 5: TF-IDF Transformation, Feature Selection, and Splitting Data

Next, we will use the same two functions we made above to find our top 10,000 terms and cull our term frequency dictionaries. The top term list should be similar to the linear regression list, but it could differ since we're using a different sample of book reviews. 


```python
from collections import Counter 

def top_words(number, list_of_dicts):
    totals = {}
    for d in list_of_dicts:
        for k,v, in d.items():
            try:
                totals[k] += v
            except: 
                totals[k] = v
    totals = Counter(totals)
    return [i[0] for i in totals.most_common(number)]

def cull_list_of_dicts(term_list, list_of_dicts):
    results = []
    for d in list_of_dicts:
        result = {}
        for term in term_list:
            try:
                result[term] = d[term]
            except:
                pass 
        results.append(result)
    return results

top_term_list_binary = top_words(10000, list_of_dictionaries_binary)
new_list_of_dicts_binary = cull_list_of_dicts(top_term_list_binary, list_of_dictionaries_binary)
```

The top term list should be similar to the linear regression list, but it could differ since we're using a different sample of book reviews. As a result, I have used the variable suffix `_binary` to create new versions of all the variables created in this code block. 

Next, we can execute our TF-IDF transformation just like we did with linear regression:

```python
from sklearn.feature_extraction.text import TfidfTransformer

X_binary = v_binary.fit_transform(new_list_of_dicts_binary)
tfidf_binary = TfidfTransformer()
Z_binary = tfidf_binary.fit_transform(X_binary)
```

If you're noticing some repetition here, it's not just you. I've written this part of the lesson to use as much code-in-common as possible so that you can see how convenient it can be to work with one well-documented library like scikit-learn. As above, I have added `_binary` to all the relevant variable names. 

Next, we can adapt our `SelectKBest` code block to use a method that makes more sense for a binary classification task. Previously, we used the scikit-learn `f_regression()` scoring function to select the most promising 3,500 TF-IDF features out of the top 10,000 terms from the vocabulary, based on linear correlations. Here we will use the `f_classif` scoring function, which uses the variance between the means of two populations as its evaluation metric. 

```python
from sklearn.feature_selection import SelectKBest, f_classif
Z_new_binary = SelectKBest(f_classif, k=3500).fit_transform(Z_binary, y_binary)
```

Next, our `train_test_split` code block is basically identical to the linear regression example, except I have changed the variable names and the `random_state` value. 

```python
from sklearn.model_selection import train_test_split
X_train_binary_binary, X_test_binary, y_train_binary, y_test_binary = train_test_split(Z_new_binary, y_binary, test_size=0.33, random_state=11)
```

### Step 6: Training the Model

When instantiating the LogisticRegression class, I have opted for the convention of adding the qualifier `_binary`because we have already used the abbreviation `lr` for our linear model instance.

```python
lr_binary = LogisticRegression(class_weight={0:0.72, 1:0.28})
lr_binary.fit(X_train_binary, y_train_binary)
```

Unlike the linear regression model, this example sets the `class_weight` parameter with weights between 0 and 1 for the two labels, which we set to 0 and 1 earlier in the process. The idea behind class weighting is that we have training and test data with an unequal proportion of our two labels, so we want to adjust the model so that it accounts from this difference. In our case, label 0 (originally __perceived_author_gender__ = 'f') receives a weight of 0.72 and label 1 (originally __perceived_author_gender__ = 'm') receives a weight of 0.28. 

Without class weighting, a well trained logistic regression model might just predict that all the test reviews were male, and thus achieve an overall accuracy of 70-75%, while providing no insight into the difference in classes. This is a very common error with classification models, and learning to avoid it is crucial. We can do so by setting the `class_weight` parameter, or by training a model with balanced classes, e.g. 50% of the observations are one label, and 50% are a second label. In our case, male-labeled-reviews are more frequent in the data, so it makes sense to use class balancing. 


### Step 7: Generate Predictions

```python
results_binary = lr_binary.predict(X_test_binary)
probs_binary = lr_binary.predict_proba(X_test_binary)
```

As with our linear model, we use the `predict()` method to generate predictions on book reviews that our model has never before see, We will evaluate the accuracy of these predictions in a moment but, first, we can also use the logit model to generate class probabilities for each review. In theory, the model should make more accurate predictions with reviews that have higher class probabilities, which is something we can check for to help validate our model. 

### Step 8: Evaluating Performance

Evaluating the performance of a logistic regression model is substantially different from a linear regression model. Our class predictions are either right or wrong, so there are no residuals to look at. Instead, we can start by calculating the ratio of correctly labeled observations to total observations, which is the overall accuracy of the model. `Scikit-learn` has a function called accuracy score, and we can use it to obtain the score by supplying it with the test labels and the predictions, which are both list-like. 

```python
from sklearn.metrics import accuracy_score
accuracy_score(y_test_binary, results_binary)
```

The result of running this code should be about 88.26%. If we had an equal number of male-labeled and female-labeled reviews, this score would give an initial sense of the model's performance, but what we really need to know in this case is whether the model is always, or almost always guessing that a review has a male label. We can get a better sense of this by creating a visualization called a confusion matrix, and then looking directly that three more targeted performance statistics. 

```python
from sklearn.metrics import confusion_matrix
confusion_matrix(y_test_binary, results_binary)
```

If you're following along, you should see Python output that looks something like this:

```
array([[181,  54],
       [ 58, 661]])
```

In information retrieval and machine learning, the classes are often described, respectively, as negative and positive. If you were looking for cancerous tumors, for example, you might treat patients with cancerous tumors as the positive class. This setup creates the distinction of 'False Positives', 'False Negatives', 'True Positives', and 'True Negatives', which can be useful for thinking about the different ways a machine learning model can succeed or fail. 

In our case, either class could be viewed as the negative or positive class, but we have elected to treat _f_ labels as our 0 value, so we adopt the term _true positive_ for reviews that were predicted to be _f_ and were labeled _f_. In turn, we can adopt the term _true negative_ for reviews that were predicted to be _m_ and were labeled _m_. The above confusion matrix result tells us that 181 reviews were predicted to be _f_ and were labeled _f_ (true positives); 54 reviews were predicted to be _m_ but were labeled _f_ (false negatives); 58 reviews were predicted to be _m_ but were labeled _f_ (false positives); and 661 reviews were correctly predicted to be _m_ (true negatives). 

A confusion matrix gives a nice snapshot of a classification model's performance for each class, but we can quantify this performance further with several metrics, the most common being __recall__, __precision__, and __f1 score__. In some fields, it's also typical to speak of __sensitivity__ and __specificity__. 

__Recall__ is defined as the number of True Positives divided by the "selected elements" (the sum of True Positives and False Negatives). A value of 1 would mean that there are only True Positives, and a value of 0.5 would suggest that, each item correctly identified has one member of the class that the model failed to identify. Anything below 0.5 means the model is missing more members of the class than it is correctly identifying. 

__Precision__ is calculated by the number of True Positives divided by the "relevant elements" (the sum of True Positives and False Positives). As with recall, a value of 1 is optimal because it means that there are no False Positives. Similarly, a score of 0.5 means that for every correctly labeled member of the positive class, one member of the negative class has been false labeled. 

To put these measures into perspective, let's consider some well known examples of classification problems. We want to know how often it allows junk mail to slip through, and how often it labels non-spam (or "ham" emails) as spam. In that case, the consequences of a false positive (ham sent to the junk mail folder) might be much worse than a false negative (spam allowed into the inbox) so we would a model with the highest possible precision, not recall. In contrast, if we train a model to analyze tissues samples and identify potentially cancerous tumors, it's probable ok if we have a model with more false positives, as long as there are fewer false negatives. In this example, we want to optimize for the recall rate.  

In both cases, it's not enough to know if our model is mostly accurate. If most of your email isn't spam, a poorly designed spam detector could be 98% accurate but move one ham email to the junk folder for every piece of spam it correctly flags. Likewise, since cancerous tumors could be as rare as 1 in 100, a tumor detector could be 99% accurate and fail to identify a single cancerous tumor. 

__Sensitivity__ and __specificity__ are the terms most often used when discussing a model like this hypothetical tumor detector. __Sensitivity__ is the number of True Positives divided by the sum of True Positives and False Negatives, which is the same as recall. __Specificity__ is the number of True Negatives divided by the sum of True Negatives and False Positives, which is actually the same as recall if we were to invert which label we regard as the positive class.[^31]

In the case of predicting the labeled gender of reviewed authors, we want to balance __recall__ and __precision__. The __f1 score__ is ideal for this use case because it is calculate by multiplying  __recall__ and __precision__, dividing that number by the sum of the __recall__ and __precision__ scores, and then multiply that quotient by 2. If we work through this formula, we can see that a model with perfect __recall__ and __precision__ scores would have an __f1 score__ of 1.0, and that a model with, say, 0.99 recall and 0.5 precision would have an __f1 score__ of 0.63. The __f1 score__ does not tell you which metric is low, but it will always be a value above the lower and below the higher of the two.  

Scikit-learn has built-in functions for all of these metrics, and they are all coded to accept two parameters: a list-like object of correct labels, and a list-like object of equal length and order representing predictions for those observations.  Using these functions, we can calculate separate __recall__, __precision__, and __f1 scores__ for each of our labels by inverting which label we regard as the positive class.

```python
f1_female = f1_score(y_test_binary, results_binary, pos_label=0, average='binary')
f1_male = f1_score(y_test_binary, results_binary, pos_label=1, average='binary')

precis_female = precision_score(y_test_binary, results_binary, pos_label=0, average='binary')
precis_male = precision_score(y_test_binary, results_binary, pos_label=1, average='binary')
     
recall_female = recall_score(y_test_binary, results_binary, pos_label=0, average='binary')
recall_male = recall_score(y_test_binary, results_binary, pos_label=1, average='binary')
```

In this code block, the `pos_label` parameter (which all these metrics functions have in common) tells the function which label belongs to the positive class, in this case `0` or `1`. The parameter `average='binary'` tells the function that   the labels should be evaluated as a binary choice between the positive and negative labels. These scoring functions also allow `average` to be set to `'micro'`, `'macro'`, `'weighted'`, and `'samples'`. [^32] If you are following along, the results of these metrics should looks something like this:

|        | Recall | Precision | F1     |
| ------ | ------ | --------- | ------ |
| Female | 0.8766 | 0.671     | 0.7601 |
| Male   | 0.8595 | 0.9551    | 0.9048 |

As we can see, the model still performs better with the _m_ label than it does with the _f_ label, but recall and precision are relatively well balanced for both classes. If you like, you can go back and try changing the `class_weight` parameter, then rerun all the code for calculating metrics. If you do, you will notice that Female __recall__ starts to drop as female __precision__ increases, so the __f1 score__ for the _f_ label is fairly closed to maximized for this sample.[^33]

### Step 9: Model Validation

Model validation with a logistic regression model is different from a linear regression model because the assumptions behind the models are different. We don't need to worry about the distribution of the residuals because there are no residuals to compute. Likewise, we don't have to worry about homoscedasticity, but multicollinearity is still a concern, and all the caveats from the linear regression section about interpreting the model's coefficients are applicable here as well. 

Next, we do want to establish that the labels predicted with higher probabilities are typically more accurate than the labels predicted with lower probabilities. We can get an initial sense of whether this is the case by creating buckets for our probability ranges and looking at their various accuracy rates. As we did with our linear regression example, let's make a pandas DataFrame for our results and use it to make a bar chart of the accuracy rates for each bucket.

```python
results_df_binary = pd.DataFrame()
results_df_binary['predicted'] = list(results_binary)
results_df_binary['actual'] = list(y_test_binary)
results_df_binary['probability_f'] = [i[0] for i in list(probs_binary)]
results_df_binary['probability_m'] = [i[1] for i in list(probs_binary)]
results_df_binary['highest_prob'] =results_df_binary[['probability_f', 'probability_m']].max(axis=1)
results_df_binary['correct'] = (results_df_binary['predicted'] == results_df_binary['actual']).astype(int)
results_df_binary
```

As with the linear regression DataFrame, we begin by creating an empty DataFrame and inserting two lists: our predicted values and our "ground truth" labels. We next want to add the logistic regression probabilities we stored in the variable `probs_binary`, but this is actually a numpy array with the dimensions `954 x 2`, with two probability scores for each observation: the class 0 probability followed by the class 1 probability, so the code chunk above uses list comprehensions to isolate the first or second elements, respectively, for each position in the array. 

We can then add a third probability column, which stores whichever probability is higher. (This will come in handy in moment.) Lastly, we create a column called `correct`, which stores values of 0 and 1. (The addition of `.astype(int)` converts the values from True and False to 0 and 1.) This column represents if the prediction was correct, which is necessarily the case if the predicted and actual values in any particular row are the same as one another. If you have been following along, the start of output of the above code block should look something like this:

|      | predicted | actual | probability_f | probability_m | highest_prob | correct |
| ---- | --------- | ------ | ------------- | ------------- | ------------ | ------- |
| 0    | 1         | 1      | 0.338258      | 0.661742      | 0.661742     | 1       |
| 1    | 1         | 1      | 0.303751      | 0.696249      | 0.696249     | 1       |
| 2    | 1         | 1      | 0.310691      | 0.689309      | 0.689309     | 1       |
| 3    | 1         | 1      | 0.223170      | 0.776830      | 0.776830     | 1       |
| 4    | 1         | 1      | 0.194012      | 0.805988      | 0.805988     | 1       |

Next, we need to create bins for our data based on the value of the `highest_prob` column. These bins should al be about the same size as one another, and each bin should have enough rows in it so that the number of correct rows can be convert to an accuracy percentage (correct/total). The following code chunk uses the `pd.qcut()` function to create seven of these bins:

```python
results_df_binary['bin'] = pd.qcut(results_df_binary['highest_prob'], q=7) 
idx = pd.IntervalIndex(results_df_binary['bin'])
results_df_binary['low'] = idx.left
results_df_binary['high'] = idx.right
results_df_binary['prob range'] = results_df_binary['low'].round(2).astype(str) + "-" + results_df_binary['high'].round(2).astype(str)
df_bins_grouped = results_df_binary.groupby('prob range').mean().reset_index()
df_bins_grouped
```

The `qcut` function returns a pandas `Series` of `Interval` objects, which are a bit tricky to work with, but the next few lines of code convert these `Interval` objects into three new columns: the `low` value of the bucket to which each rows belongs, the `high` value of the bucket to which each rows belongs, and a `label` column showing the entire probability range for each row's corresponding bucket. Lastly, the block uses a pandas `groupby` function to create a DataFrame with one row per bucket, and the mean of all the values in each bucket for each column in the original DataFrame.  If you've been following along, the output should look something like this:

|      | prob range | predicted | actual   | probability_f | probability_m | highest_prob | correct  | low   | high  |
| ---- | ---------- | --------- | -------- | ------------- | ------------- | ------------ | -------- | ----- | ----- |
| 0    | 0.5-0.6    | 0.510949  | 0.510949 | 0.495122      | 0.504878      | 0.547628     | 0.620438 | 0.499 | 0.595 |
| 1    | 0.6-0.66   | 0.713235  | 0.661765 | 0.443741      | 0.556259      | 0.627575     | 0.816176 | 0.595 | 0.657 |
| 2    | 0.66-0.7   | 0.794118  | 0.823529 | 0.393464      | 0.606536      | 0.679832     | 0.911765 | 0.657 | 0.701 |
| 3    | 0.7-0.73   | 0.882353  | 0.882353 | 0.333624      | 0.666376      | 0.717180     | 0.955882 | 0.701 | 0.732 |
| 4    | 0.73-0.76  | 0.897059  | 0.911765 | 0.303906      | 0.696094      | 0.746621     | 0.955882 | 0.732 | 0.760 |
| 5    | 0.76-0.79  | 0.845588  | 0.860294 | 0.309866      | 0.690134      | 0.775189     | 0.970588 | 0.760 | 0.791 |
| 6    | 0.79-0.96  | 0.605839  | 0.627737 | 0.453201      | 0.546799      | 0.833979     | 0.948905 | 0.791 | 0.955 |

In this DataFrame, we really only care about two columns: `probability range` and `correct`. Everything else is just something we used to generate these two values. Now we can use the `matplotlib` and `seaborn` libraries to make a bar chart of our accuracy rates for the seven data buckets we've calculated:

```python
%matplotlib inline
import matplotlib.pyplot as plt
import seaborn as sns
plt.figure(figsize=(11,9))
plt.subplots_adjust(top=0.85)

ax = sns.barplot(x='prob range', y='correct', data=df_bins_grouped)
plt.title("Logistic Regression Accuracy by Probability Range")
plt.ylabel('Percent correct')
plt.xlabel('Probability range')
plt.show()
```

Note that, once again, `%matplotlib inline` is a cell magic for a Jupyter Notebook. If all goes well, your plot should look something like this:

![Logistic regression accuracy by probability range](Logit_Probabilities_Binned.png)

As the bar chart suggests, the predictions between 0.5 and 0.6, on average, have the lowest accuracy of all predictions. Predictions with probabilities between 0.6 and 0.66 see a substantial bump in average accuracy, as do predictions with probabilities between 0.66 and 0.67. After that, average accuracy seems to level off and then drop slightly for predictions with probabilities between 0.79 and 0.96. This apparent drop-off could be a coincidence of the train/test split, or simply the result of a cluster of reviews that represent the exception to the rules our model has applied. To get a better sense of how consistent these results are, we can rerun our train/test split with different random seeds and aggregate the results, but this is enough of an initial indication that our model predictive accuracy improves as class probabilities increase. 

The last assumption we need to validate with a logistic regression model is that there are linear associations between our independent variables and the log probability of one class or another. This is a subtle point, but it's crucial. As a particular feature's score goes up (in our case, a TF-IDF score for a term), the log probability of one class or the other should go up or down.[^34] The more consistently this relationship exists, the better the logistic regression will perform. In this sense, strong performance itself is validator of the linear association assumption, but we can go a bit further by looking more closely at one of our top coefficients. 

To explain the logic of a logistic regression model above, I showed a bar chart of three term frequency ranges for the word _she_. Let's write code to do something similar with the word _her_ but, this time, let's use actual TF-IDF weights and create a few more bins so we can see if the trend is consistent across the range of TF-IDF values. In a moment, we will write some code to display the actual term coefficients and their scores, but we can hypothesize that _her_ will be a relatively strong predictor of a female-labeled-review, as it was in my article on gender dynamics in _The New York Times Book Review_.[^35] The methods in the article version differ slightly from this lesson, but I'm comfortable predicting that this feature to remain consistent. 

Let's put together a DataFrame of TF-IDF scores for the term _her_ and gender labels for each review labeled _m_ or _f_ and see if the reviews with higher TF-IDF scores tend to be labeled _f_:

```python

pos = features_df.loc[features_df['term'] == 'her'].index[0]
her_tfidf = [i[pos] for i in Z_new_binary.toarray()]
her_tfidf_df = pd.DataFrame()
her_tfidf_df['tf_idf'] = her_tfidf
her_tfidf_df['gender_label'] = y_binary
her_tfidf_df['bin'] = pd.qcut(her_tfidf_df['tf_idf'], q=11, duplicates='drop') 
her_idx = pd.IntervalIndex(her_tfidf_df['bin'])
her_tfidf_df['low'] = her_idx.left
her_tfidf_df['high'] = her_idx.right
her_tfidf_df['tfidf range'] = her_tfidf_df['low'].round(2).astype(str) + "-" + her_tfidf_df['high'].round(2).astype(str)
her_tfidf_df
```

This code block should look a lot like the code we used to create probability buckets. Using the line of code `features_df.loc[features_df['term'] == 'her'].index[0]`, we can extract the index number for the feature _her_ and build up a list of the TF-IDF score for that single feature from each book review. The variable `her_tfidf` represents that list, and has the same length and ordering as the gender labels in `y_binary`. This makes it easy to create an empty DataFrame and add columns for the TF-IDF scores and gender labels. We can then use a `qcut` function (as above) to bin our data, but this time we want to creates bins based on the TF-IDF scores. We also need to add the `duplicates='drop'` parameter because there are enough rows with the same TF-IDF score that our bin edges are not unique.[^36] As before, we also need to create an `IntervalIndex` to access the lower and upper values of our bins and make our bin labels. 

If you run this code in a Jupyter Notebook, your DataFrame should look something like this:

|      | tf_idf   | gender_label | bin               | low     | high    | tfidf range |
| ---- | -------- | ------------ | ----------------- | ------- | ------- | ----------- |
| 0    | 0.021558 | 1            | (0.0175, 0.0308]  | 0.0175  | 0.03080 | 0.02-0.03   |
| 1    | 0.065845 | 1            | (0.0518, 0.0869]  | 0.0518  | 0.08690 | 0.05-0.09   |
| 2    | 0.077677 | 1            | (0.0518, 0.0869]  | 0.0518  | 0.08690 | 0.05-0.09   |
| 3    | 0.000000 | 1            | (-0.001, 0.00748] | -0.0010 | 0.00748 | -0.0-0.01   |
| 4    | 0.239199 | 1            | (0.153, 0.488]    | 0.1530  | 0.48800 | 0.15-0.49   |

As above, we now need to use a `grouby` statement to end up with one row per bin range, with a the proportion of _m_ and _f_ labels for each TF-IDF range. 

```python
her_tfidf_df_grouped = her_tfidf_df.groupby('tfidf range').mean().reset_index()
her_tfidf_df_grouped['percent male'] = her_tfidf_df_grouped['gender_label']
her_tfidf_df_grouped['total'] = 1.0
her_tfidf_df_grouped['percent female'] = her_tfidf_df_grouped['total'] - her_tfidf_df_grouped['gender_label']
her_tfidf_df_grouped
```

This code block groups the data and add columns for the percent male and female (in decimal forms). The column `total` is one because `percent male` and `percent female` will add up to 1.0, and we will use that number when making our stacked bar chart in a moment. The output of this code block should look like this:

|      | tfidf range | tf_idf   | gender_label | low      | high    | percent male | total | percent female |
| ---- | ----------- | -------- | ------------ | -------- | ------- | ------------ | ----- | -------------- |
| 0    | -0.0-0.01   | 0.000498 | 0.964966     | -0.00100 | 0.00748 | 0.964966     | 1.0   | 0.035034       |
| 1    | 0.01-0.02   | 0.012120 | 0.927481     | 0.00748  | 0.01750 | 0.927481     | 1.0   | 0.072519       |
| 2    | 0.02-0.03   | 0.023136 | 0.779468     | 0.01750  | 0.03080 | 0.779468     | 1.0   | 0.220532       |
| 3    | 0.03-0.05   | 0.040464 | 0.652672     | 0.03080  | 0.05180 | 0.652672     | 1.0   | 0.347328       |
| 4    | 0.05-0.09   | 0.067615 | 0.528517     | 0.05180  | 0.08690 | 0.528517     | 1.0   | 0.471483       |
| 5    | 0.09-0.15   | 0.116141 | 0.320611     | 0.08690  | 0.15300 | 0.320611     | 1.0   | 0.679389       |
| 6    | 0.15-0.49   | 0.220138 | 0.243346     | 0.15300  | 0.48800 | 0.243346     | 1.0   | 0.756654       |

As you may notice, there are only seven bins here despite having made 11. If you recall, we added the `duplicates='drop'` parameter because our bin edges were not unique. Here, our `groupby` statement has grouped any bins with duplicate names together. This means that some of our bins represent more rows than others, but this shouldn't affect our results. We can see that, in the lowest TF-IDF range for the word _her_, the split of labels is more than 96% _m_ and about 3.5% _f_. As TF-IDF scores for _her_ go up, the proportion of _f_ labels also rises. In the bin with the highest TF-IDF scores for the word _her_, the split of labels is about 24% _m_ and about 76% _f_.  

To better appreciate this breakdown, let's make a stacked bar chart of the proportion of _m_ and _f_ labels in each TF-IDF range. 

```python
%matplotlib inline
import matplotlib.pyplot as plt
import seaborn as sns

plt.figure(figsize=(11,9))
plt.subplots_adjust(top=0.85)

bar1 = sns.barplot(x='tfidf range', y='total', data=her_tfidf_df_grouped, color='lightblue')
bar2 = sns.barplot(x='tfidf range', y='percent female', data=her_tfidf_df_grouped, color='darkblue')

# add labels
plt.title("Proportions of Male and Female Labels for TF-IDF Ranges of the Word 'Her'")
plt.ylabel('Proportion Male/Female')
plt.xlabel('TFIDF Range')

# add legend
top_bar = mpatches.Patch(color='darkblue', label='Percent labeled female')
bottom_bar = mpatches.Patch(color='lightblue', label='Percent labeled male')
plt.legend(handles=[top_bar, bottom_bar])
plt.show()
```

This code chunk differs from the previous bar plot because here, we want to visualization the proportion of book reviews with _m_ and _f_ labels. We could do this is several ways, but a stacked bar chart with bars of equal height provides a strong basis for comparing the proportion, better than bars of unequal height or a pie chart. Because we want to emphasize the categories and not the bins, we set the colors by class label. If you are following along, your plot should look like this:

![Gender Label split for TF-IDF value ranges of the word 'her'](MF_Labels_TFIDF_Her.png)

As we can see from the data table and the bar plot, the frequency (or probability) of an _f_ label rises steadily as the TF-IDF scores rise, but the _m_/_f_ split never goes lower than 76/24. This helps us confirm this assumption of linearity between one independent variable and the log odds of the female-labeled class. It also demonstrates that a very low TF-IDF score for _she_ is a stronger indication of an _m_ label than a very high TF-IDF score is for an _f_ label. 

This effect appears to be a combination of the fact that _f_-labeled reviews almost always use the pronoun _her_ at least once (about 94% of the  _f_-labeled reviews in our sample), and that it's a fairly common occurrence for an _m_-labeled review to use the pronoun _her_ at least once (almost 47% of the _m_-labeled reviews in our sample). What's more it's not that rare for an _m_-labeled review to use the pronoun _her_ 5 or 10 times (about 15% and 6% of _m_-labeled reviews in our sample respectively). What drives this trend? Perhaps it's typical for reviewed books with presumed male authors to have female characters.  Perhaps these characters get discussed disproportionately in reviews. To see if it's also typical for reviewed books with presumed female authors to mention the pronoun _his_, we would have to look directly at that term, and that's something we now know how to do!

### Step 10: Examine Model Intercept and Coefficients

On that note, let's look at the top term coefficients for both of our labels. In the following code block, we will take an approach almost identical to the linear regression example:

```python
features_binary = SelectKBest(f_classif, k=3500).fit(Z_binary, y_binary)

selected_binary = features_binary.get_support()

features_df_binary = pd.DataFrame()
features_df_binary['term'] = v_binary.feature_names_
features_df_binary['selected'] = selected_binary
features_df_binary = features_df_binary.loc[features_df_binary['selected'] == True]
features_df_binary['coef'] = lr_binary.coef_[0]

coefficients_binary = features_df_binary.sort_values(by='coef', ascending=False).reset_index(drop=True)
```

As with linear regression coefficients, this block of code uses the `fit()` and `get_support()` methods to get the features selected by `SelectKBest`. It then creates an empty DataFrame and adds columns for `term` and `selected`, which indicates if `SelectKBest` selected that term. It then uses a `loc()` statement identical to the linear regression example to reduce the DataFrame to selected features. Finally, we add the `coef` column, sort by `coef` value in descending order, and reset the index. The only real difference between this version and the linear regression example is the use of `features_df_binary['coef'] = lr_binary.coef_[0]` instead of `features_df_binary['coef'] = lr_binary.coef_`. The linear regression model's `coef_` parameter is always a one-dimensional array with a length equal to the number of features, but the logistic regression model's `coef_` parameter can have the dimensions (1 x number of features) or (number of classes x number of features). 

Looking at our top 25 positive coefficients is also the same as our linear regression version:

```python
coefficients.iloc[0:25]
```

The results should look more or less like this:

|      | term        | selected | coef     |
| ---- | ----------- | -------- | -------- |
| 0    | he          | True     | 2.572227 |
| 1    | mr          | True     | 2.412406 |
| 2    | his         | True     | 2.059346 |
| 3    | the         | True     | 0.988710 |
| 4    | was         | True     | 0.668281 |
| 5    | of          | True     | 0.638194 |
| 6    | that        | True     | 0.510740 |
| 7    | dr          | True     | 0.508211 |
| 8    | on          | True     | 0.494741 |
| 9    | prof        | True     | 0.488638 |
| 10   | professor   | True     | 0.418418 |
| 11   | tile        | True     | 0.364163 |
| 12   | man         | True     | 0.349181 |
| 13   | himself     | True     | 0.348016 |
| 14   | british     | True     | 0.341043 |
| 15   | president   | True     | 0.331676 |
| 16   | law         | True     | 0.311623 |
| 17   | in          | True     | 0.295170 |
| 18   | science     | True     | 0.289051 |
| 19   | lie         | True     | 0.285332 |
| 20   | shakespeare | True     | 0.285233 |
| 21   | political   | True     | 0.283920 |
| 22   | ship        | True     | 0.282800 |
| 23   | air         | True     | 0.274412 |
| 24   | adventures  | True     | 0.267063 |

Despite using different text processing and feature selection methods, these coefficients share many terms in common with some of the results I shared in my article on gender dynamics in _The New York Times Book Review_.[^37] Gendered pronouns such as _he_, _him_, and _himself_, as well as gendered honorifics like _mr_, _dr_, _prof_, and _professor_ all make the list, as do some ostensible content words like _science_, _political_, _law_, and _shakespeare_.

Turning to the 25 coefficients with strongest indicators of an _f_ label, we use another `iloc()` statement:

```python
coefficients.iloc[-25:]
```

The results should look something like this:

|      | term     | selected | coef      |
| ---- | -------- | -------- | --------- |
| 3475 | girl     | True     | -0.395204 |
| 3476 | letters  | True     | -0.402026 |
| 3477 | anna     | True     | -0.407688 |
| 3478 | child    | True     | -0.420118 |
| 3479 | mary     | True     | -0.421888 |
| 3480 | herself  | True     | -0.461949 |
| 3481 | story    | True     | -0.467393 |
| 3482 | love     | True     | -0.467837 |
| 3483 | children | True     | -0.474891 |
| 3484 | garden   | True     | -0.476721 |
| 3485 | jane     | True     | -0.481835 |
| 3486 | life     | True     | -0.493846 |
| 3487 | wife     | True     | -0.499350 |
| 3488 | home     | True     | -0.501617 |
| 3489 | mother   | True     | -0.510301 |
| 3490 | family   | True     | -0.520028 |
| 3491 | their    | True     | -0.530106 |
| 3492 | lady     | True     | -0.592740 |
| 3493 | and      | True     | -0.789409 |
| 3494 | woman    | True     | -0.806953 |
| 3495 | women    | True     | -0.973704 |
| 3496 | miss     | True     | -2.211015 |
| 3497 | mrs      | True     | -2.578966 |
| 3498 | she      | True     | -4.585606 |
| 3499 | her      | True     | -5.372169 |

As predicted, _her_ is a strong predictor of the _f_ label (the strongest, in fact), along with _she_ and _herself_, as well as _mrs_, _miss_, _lady_, _woman_, _women_, _wife_, _mother_, and _children_. Several gendered forenames appear on the list, and apparent content words like _family_, _home_, _garden_, _letters_, and _story_ are reminiscent of the results from the article version on my analysis. [^38] 

### Step 11: Make Predictions on Non-Binary Data

Above, I mentioned the idea of using a binary classification model to make predictions with non-binary data. We also created a DataFrame called `df_non_binary` for single work book reviews that were coded as either having no clear indication of presumed gender or indicators of male and female genders, as would be the case if a book were written by two authors, one presumed male and one presumed female. Adapting the code from above, we can use this DataFrame to load term frequency tables and fit the terms to our already trained logistic regression model.

```python
# Load term frequency data, convert to list of dictionaries
dicts_non_binary = []
for row in df_non_binary.iterrows():
    if row[1]['cluster_id'] == 'none':
        txt_file_name = ''.join(['term-frequency-tables/', row[1]['nyt_id'], '.csv'])
    else:
        txt_file_name = ''.join(['term-frequency-tables/', row[1]['nyt_id'], '-', 
        row[1]['cluster_id'], '.csv'])
        
    df = pd.read_csv(txt_file_name).dropna().reset_index(drop=True)
    mydict = dict(zip(list(df['term']), list(df['count'])))
    
    dicts_non_binary.append(mydict)

# Transform to document-term matrix
X_non_binary = v_binary.transform(dicts_non_binary)
# Transform to TF-IDF values
Z_non_binary = tfidf_binary.transform(X_non_binary)
# Apply feature selection model 
Z_non_binary_selected = features_binary.transform(Z_non_binary)
# Make label predictions on new data
results_non_binary = lr_binary.predict(Z_non_binary_selected)
# Get probability scores for predictions
probs_non_binary = lr_binary.predict_proba(Z_non_binary_selected)
# Make results DataFrame
results_df_non_binary = pd.DataFrame()
results_df_non_binary['predicted'] = list(results_non_binary)
results_df_non_binary['prob_f'] = [i[0] for i in list(probs_non_binary)]
results_df_non_binary['prob_m'] = [i[1] for i in list(probs_non_binary)]
results_df_non_binary['highest_prob'] = results_df_non_binary[['prob_f', 'prob_m']].max(axis=1)
results_df_non_binary = results_df_non_binary.merge(df_non_binary, left_index=True, right_index=True)
results_df_non_binary = results_df_non_binary.sort_values(by='highest_prob', ascending=False).reset_index(drop=True)
```

This code chunk combines multiple steps from above into one set of operations.  Since these steps are all familiar by now, I've used code comments to flag each steps. You'll noticed new variable names like `dicts_non_binary`, `X_non_binary`, and `Z_non_binary`, but I've maintained consistency with the naming conventions of `X`, `Y`, `Z`, and others, this time adding the suffix `_non_binary`. Take note, as well, of the fact that this code block uses the scikit-learn method `transform()` instead of `fit()` or `fit_transform`. The `transform()` method is common to many directs the code scikit-learn classes, and works by fitting new data to an existing model, whether that model be TF-IDF features, features selected by a `SelectKBest` instance, or or actual regression model. The pandas `merge()` statements is also new here. We use that to merge `results_df_non_binary` and `df_non_binary` into one DataFrame. The parameters `left_index=True` and `right_index=True` tells the method to merge on the respective indices rather than any column values in either DataFrame.

Using the results DataFrame, we can look at some examples of what happens when we use a binary gender model to predict the gender of book reviews that don't fit into the model. This line of code will display the URL for the pdf file of the book review with the highest probability score:

```python
results_df_non_binary.iloc[0]['nyt_pdf_endpoint']
```

In this case, our model assigns this book review almost a 98% chance of having an _f_ label. If we visit the review's pdf endpoint (https://timesmachine.nytimes.com/timesmachine/1905/05/27/101758576.pdf), we can see that this review is for _A Bookful of Girls_ by Anna Fuller (Putnam, 1905).[^39] In my original data, I labeled this book review _none_ rather than _f_ because the reviewer does not assign a gender to Fuller. The review begins with a mention of Fuller's full name and switches quickly to a discussion of the book's characters. Nevertheless, gender is central from the very first lines of the review:

> Six of the very nicest girls one would ever care to meet are to be found in Anna Fuller's 'Bookful of Girls.' They are such happy, wholesome, honest sort of young things, with such very charming ways about them, that they beguile even older readers into following their adventures in spite of the fact that he, or more properly speaking she, for this is distinctly a feminine book—knows all the time that they were never written for her, but rather for her daughter or younger sister.[^40]

Here we several of the top coefficients indicative of the _f_ label, including _she_, _her_, _girls_, _daughter_, and _sister_, but there are several other _f_-leaning coefficients here as well. The most obvious is _feminine_ but, according to our model, _anna_, _wholesome_, _young_ and _charming_ are all indicators leaning toward the _f_ label, and so is the word _written_. More broadly, we see a review that's deeply invested in binaristic notions of gender, which is a good reminder that the word _binary_, when used to describe a predictive model, is not synonymous with the idea of a _binary_ as it used in poststructural and deconstructionist theory. 

The non-binary book review with the most even split between the two class probabilities (i.e. closest to 50/50) is found in the last row of the `results_df_non_binary` DataFrame. We can access the URL for the pdf file for this book review with the following code:

```python
results_df_non_binary.iloc[-1]['nyt_pdf_endpoint']
```

This review was originally labeled as having authors of more than one gender, and our binary model predicted it had a 49.95% chance of being labeled _f_ and a 50.05% chance of being labeled _m_. The URL (https://timesmachine.nytimes.com/timesmachine/1905/11/18/101332714.pdf) leads to a review of _Mrs. Brookfield and Her Circle_ by Charles and Frances Brookfield (Scribner's, 1905).[^41] The book is a collection of "letter and anecdotes" about Jane Octavia Brookfield, a novelist who maintained a literary salon. She had been friends with William Makepeace Thackeray. Her husband William Henry Brookfield was an Anglican clergyman, who had come friends with Alfred Tennyson in college. The reviewed book was written by Charles Brookfield, the son of Jane and William, and Charles's wife Frances. (Information on Frances appears hard to come by, but the review describes them as Mr. and Mrs. Brookfield.)

The fact that this reviews ambiguous in terms of gender is not especially surprising. The book's authors are presented as husband and wife and is reviewed giving nearly equal weight to Jane Octavia Brookfield and William Henry Brookfield. Perhaps the significance here is that a book ostensibly focused on Jane Octavia Brookfield (as the title seems to indicate) frames Brookfield's identity and importance in relation to the men in her life. What's more, the review may amplify the extent to which the book engages in that rhetorical strategy.

To learn more about the terms that drive the predicted probability, we can multiply each of the TF-IDF scores for this book review by their respective coefficients and see which combinations have the highest products. In reality, this product is only part of the probability formula (see above), but calculating a groups of products can give us a good snapshot of where we stand. 

```python
one_review = pd.DataFrame()
one_review['term'] = v_binary.feature_names_
one_review['selected'] = selected_binary
one_review = one_review.loc[one_review['selected'] == True]
one_review.reset_index(drop=True)
one_review['coef'] = lr_binary.coef_[0]
original_review_index = df_non_binary.loc[df_non_binary['nyt_id'] == '4fc0532f45c1498b0d251a13'].index[0]
one_review['tfidf_score'] = Z_non_binary_selected[original_review_index].toarray()[0]
one_review['product'] = one_review['tfidf_score'] * one_review['coef']
```

In this code block, we create an empty DataFrame and add columns for the feature names and whether they were selected by `SelectKBest`, as previously. We then drop all unselected features and add a column for our coefficient scores, as we did above. We also need the TF-IDF scores for the book review we want to look at, so we use a `loc` statement to find that review's index in `df_non_binary`. We then calculate the product of the `tfidf_score` column and the `coefficient` column and assign it to a new column called `product`. Now we can sort in either descending or ascending order to view the top negative or positive products.

```python
one_review = one_review.sort_values(by='product', ascending=True)
one_review.iloc[0:10]
```

|      | term  | selected | tfidf_score | coef      | product   |
| ---- | ----- | -------- | ----------- | --------- | --------- |
| 4195 | her   | True     | 0.079270    | -5.372169 | -0.425849 |
| 8068 | she   | True     | 0.063839    | -4.585606 | -0.292742 |
| 5882 | mrs   | True     | 0.085458    | -2.578966 | -0.220394 |
| 375  | and   | True     | 0.180745    | -0.789409 | -0.142682 |
| 5052 | lady  | True     | 0.077727    | -0.592740 | -0.046072 |
| 0    | a     | True     | 0.227537    | -0.140946 | -0.032070 |
| 4035 | had   | True     | 0.092804    | -0.316078 | -0.029333 |
| 9865 | with  | True     | 0.063842    | -0.343074 | -0.021903 |
| 9879 | woman | True     | 0.024593    | -0.806953 | -0.019845 |
| 7758 | s     | True     | 0.080108    | -0.190876 | -0.015291 |

```python
one_review = one_review.sort_values(by='product', ascending=False)
one_review.iloc[0:10]
```

|      | term | selected | tfidf_score | coef     | product  |
| ---- | ---- | -------- | ----------- | -------- | -------- |
| 4141 | he   | True     | 0.134595    | 2.572227 | 0.346209 |
| 8953 | the  | True     | 0.335669    | 0.988710 | 0.331880 |
| 4252 | his  | True     | 0.113851    | 2.059346 | 0.234460 |
| 6176 | of   | True     | 0.294356    | 0.638194 | 0.187856 |
| 9700 | was  | True     | 0.148996    | 0.668281 | 0.099571 |
| 5881 | mr   | True     | 0.034251    | 2.412406 | 0.082627 |
| 4532 | in   | True     | 0.180933    | 0.295170 | 0.053406 |
| 8951 | that | True     | 0.085153    | 0.510740 | 0.043491 |
| 6212 | on   | True     | 0.052097    | 0.494741 | 0.025774 |
| 581  | as   | True     | 0.098149    | 0.223826 | 0.021968 |

For this review, the top negative and positive products of coefficients and TF-IDF scores are for seemingly insignificant but generally predictive terms. first we have words with obvious gendering, such as _she_, _her_, _mrs_, _lady_, _woman_, _he_, _his_, and _mr_, but the other terms with high products are function words with variance by gender. The terms _and_, _a_, and _with_ are apparently feminized, whereas _the_, _of_, _in_, _that_, _on_, and _as_ are associated with male labels. Their relatively high TF-IDF scores here make them significant in terms of the eventual prediction of a label for this review. 


# End Notes

[1] Lavin, Matthew. “Gender Dynamics and Critical Reception: A Study of Early 20th-Century Book Reviews from The New York Times.” _Journal of Cultural Analytics_, January 30, 2020. https://doi.org/10.22148/001c.11831. Note that, as of January 2021, the _New York Times_ has redesigned its APIs, and the `nyt_id`s listed in `metadata.csv` and `meta_cluster.csv` no longer map to ids in the API. 

[2] https://libguides.usc.edu/writingguide/variables

[3] https://libguides.usc.edu/writingguide/variables

[4] http://sites.utexas.edu/sos/variables/

[5] Jarausch, Konrad H., and Kenneth A. Hardy. _Quantitative Methods for Historians: A Guide to Research, Data, and Statistics_. UNC Press Books, 2016: 122. 

[6] Bruce, Peter, Andrew Bruce, and Peter Gedeck. _Practical Statistics for Data Scientists: 50+ Essential Concepts Using R and Python_. O’Reilly Media, Inc., 2020: 148.

[7] Jarausch and Hardy, 122.

[8] See https://pandas.pydata.org/pandas-docs/stable/user_guide/merging.html for differences among merge, join, concatenate, and compare operations 

[9] See also https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.concat.html

[10 ] See https://programminghistorian.org/en/lessons/analyzing-documents-with-tfidf

[11] See https://docs.scipy.org/doc/scipy/reference/sparse.html for documentation on sparse matrices and https://numpy.org/doc/stable/user/basics.types.html for documentation on numpy's float64 class. 

[12] See https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.html for documentation on pandas' series class.

[13] See https://scikit-learn.org/stable/modules/model_evaluation.html#r2-score and https://scikit-learn.org/stable/modules/generated/sklearn.metrics.r2_score.html.

[14] Note that the scikit-learn `r2()` function may return a slightly different value than the `r_square_scratch` function, as there are differences in precision between numpy's mathematical operations (used by scikit-learn) and standard Python (used by me).

[15] https://scikit-learn.org/stable/modules/generated/sklearn.metrics.r2_score.html

[16] Drost, Ellen A. "Validity and Reliability in Social Science Research" _Education Research and Perspectives_ 38.1 (2011): 105-123. 114. https://www3.nd.edu/~ggoertz/sgameth/Drost2011.pdf

[17] Drost, 114.

[18] See Drost, 106, 114-120. Statistical conclusion validity is concerned with "major threats" to validity such as "low statistical power, violation of assumptions, reliability of measures, reliability of treatment, random irrelevancies in the experimental setting, and random heterogeneity of respondents" (115). Internal validity "speaks to the validity of the research itself" (115). Construct validity "refers to how well you translated or transformed a concept, idea, or behaviour – that is a construct – into a functioning and operating reality, the operationalisation" (116). External validity relates to generalizing "to other persons, settings, and times" with different concerns for generalizing "to well-explained target populations" versus generalizing "across populations" (120).

[19] Nisbet, Robert, John Elder, and Gary Miner. _Handbook of Statistical Analysis and Data Mining Applications_. Academic Press, 2009: 8.

[20] Schroeder, Larry D., David L. Sjoquist, and Paula E. Stephan. _Understanding Regression Analysis: An Introductory Guide_. SAGE Publications, 2016: 72.

[21] Ibid.

[22] Nisbet et. al., 74.

[23] Fox, John. _Regression Diagnostics: An Introduction_. SAGE, 1991: 252-255.

[24] Gentzkow, Matthew, Bryan Kelly, and Matt Taddy. "Text as Data." _Journal of Economic Literature_ 57, no. 3 (September 2019): 535–74. https://doi.org/10.1257/jel.20181020.

[25] See Feinstein, Charles H. and Mark Thomas, _Making History Count: A Primer in Quantitative Methods for Historians_. Cambridge University Press, 2002: 309-310.

[26]  Feinstein and Thomas, 269-272.

[27] "uncommon, adj. (and adv.)". _OED Online_. June 2021. Oxford University Press. https://www.oed.com/view/Entry/210577 (accessed July 06, 2021).

[28]  Lavin, 9.

[29] Jarausch and Hardy, 132.

[30] Jarausch and Hardy, 160.

[31] See, for example, Glaros, Alan G., and Rex B. Kline. “Understanding the Accuracy of Tests with Cutting Scores: The Sensitivity, Specificity, and Predictive Value Model.” _Journal of Clinical Psychology_ 44, no. 6 (1988): 1013–23. https://doi.org/10.1002/1097-4679(198811)44:6<1013::AID-JCLP2270440627>3.0.CO;2-Z. 

[32] See, for example, https://scikit-learn.org/stable/modules/generated/sklearn.metrics.precision_recall_fscore_support.html

[33] See https://scikit-learn.org/stable/modules/generated/sklearn.metrics.precision_recall_curve.html#sklearn.metrics.precision_recall_curve

[34] For more on this topic, see https://www.restore.ac.uk/srme/www/fac/soc/wie/research-new/srme/modules/mod4/9/index.html.

[35] Lavin, 14.

[36] For more on `pd.qcut()`, see https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.qcut.html

[37] See Lavin, 14-17.

[38] See Lavin, 19.

[39] "Six Girls," _The New York Times Book Review_, 27 May 1905. 338. https://timesmachine.nytimes.com/timesmachine/1905/05/27/101758576.html

[40] "Six Girls," 338.

[41] "Mrs. Brookfield," _The New York Times Book Review_, 18 November 1905. 779. https://timesmachine.nytimes.com/timesmachine/1905/11/18/101332714.html


