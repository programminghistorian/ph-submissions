---
title: Visualizing Data with Bokeh and Pandas
authors:
- Charlie Harper
date: 2017-12-06
reviewers:
layout: lesson
---


# Contents

{% include toc.html %}

# Overview

The ability to succinctly load raw data, sample it, and then visually present it is a valuable skill across disciplines. In this tutorial, you will learn how to do this in Python by integrating the Bokeh and Pandas libraries. Specifically, we will work through visualizing aspects of WWII bombing runs conducted by Allied powers. We'll use Bokeh and Pandas to 

- explore and graph the types and weights of munitions dropped during WWII, including high-explosive, fragmentation, and incendiary bombs 
- analyze the quantities of bombs dropped over the course of the war and visualize the relationship between quantities dropped and major military events
- map mission targets to show where Allies bombed in the various theaters of operation

At the end of the lesson you will be able to load data, perform basic data manipulations (such as aggregating and sub-sampling), and create attractive, interactive visualizations of historical data.

## The WWII THOR Dataset

The Theater History of Operations Reports (THOR) lists aerial bombing operations during World War I, World War II, the Korean War, and the Vietnam War undertaken by the United States and Allied Powers. The records were compiled from declassified documents by Lt. Col. Jenns Robertson. THOR is made publicly available through a partnership between the US Department of Defense and [data.world](https://data.world/datamil).

Each row in the THOR dataset contains information on a single mission or bombing run. This information can include the mission date, takeoff and target locations, the target type, aircraft involved, and the types and weights of bombs dropped on the target. The [THOR data dictionary](https://data.world/datamil/thor-data-dictionary) provides detailed information on the structure of the dataset.

For this tutorial, we'll use a modified version of the WWII THOR dataset. The original, full-version of the dataset consists of 62 columns of information digitized from the paper forms. To make this dataset more manageable for our purposes, this has been reduced to 19 columns that include core mission information and bombing data. These columns are discussed below when we first load the data. The unabridged dataset is available for download [here](https://data.world/datamil/world-war-ii-thor-data).

The dataset used in this tutorial is contained in [thor_wwii.csv](https://raw.githubusercontent.com/programminghistorian/ph-submissions/gh-pages/assets/visualizing-with-bokeh/thor_wwii.csv). This file is required to complete most of the examples below.

# Getting Started

## Prerequisites

This tutorial can be completed in any operating systems. It requires Python 3 and a web browser. You may use any text editor to write your code.

This tutorial assumes that you have a basic knowledge of the Python language and its associated data structures, particularly lists. 

If you work in Python 2, you will need to create a virtual environment for Python 3, and even if you work in Python 3, creating a virtual environment for this tutorial is good practice. 

## Creating a Python 3 Virtual Environment

Miniconda is one way to create virtual environments and it's simple to install across operating systems. You should download Miniconda and follow the instructions for [Windows](https://conda.io/docs/user-guide/install/windows.html), [Mac](https://conda.io/docs/user-guide/install/macos.html), or [Linux](https://conda.io/docs/user-guide/install/linux.html) as appropriate for your operating system.

Once you have downloaded and installed Miniconda for your operating system, you can check that it has installed correctly by opening a command line and typing 
```python
conda info
```
If you see version information similar to the following, then you're in business.
```python
Current conda install:
               platform : linux-64
          conda version : 4.3.29
          ...
```
We'll use Miniconda to create a Python 3 virtual environment named *bokeh-env* for this tutorial. In the command line type
```python
conda create --name bokeh-env python=3.6
```
Say yes when you are prompted to install new packages. 

To  activate the *bokeh-env* virtual environment, the command differs slightly depending on your operating system.
```python
source activate bokeh-env #For Linux/MacOS
activate bokeh-env #For Windows
```
Your command line should now show that you are in a the *bokeh-env* virtual environment.

When you'd like to leave the virtual environment, you can type the command appropriate for your operating system.
```python
source deactivate #For Linux/MacOS
deactivate #For Windows
```

## Installing Packages

In your activated *bokeh-env* virtual environment, issue the following command to install the python packages for this tutorial.

```python
pip install pandas bokeh pyproj
```

To get the exact versions used in writing this tutorial you can explicitly pass the following version numbers to `pip`.

```python
pip install pandas==0.20.3 bokeh==0.12.11 pyproj==1.9.5.1
```

## Running Code Examples
It is easiest first to create a single directory and save each code example as a *.py* within it. When you are ready to run the code file, navigate to this directory in your command prompt and make sure your virtual environment is activate. Remember that you can always activate the environment with the following command appropriate for your operating system.
```python
source activate bokeh-env #For Linux/MacOS
activate bokeh-env #For Windows
```

Within the virtual environment, you can run your code by typing

```python
python filename.py
```

A Jupyter Notebook containing the code is also [available](https://raw.githubusercontent.com/programminghistorian/ph-submissions/gh-pages/assets/visualizing-with-bokeh/visualizing-with-bokeh.ipynb) in case  you prefer to work through the tutorial in this manner. You can learn more about Jupyter Notebook [here](http://jupyter.org). If you have created a virtual environment using Miniconda, as discussed above, you can install Jupyter Notebook in the environment by typing `conda install jupyter`

<div class='alert'>

For readers who want more info on Conda and Jupyter, check out Programming Historian's lesson, [Reproducible Digital Humanities Research with Anaconda, Jupyter, and Python]()!

</div>

# The Basics of Bokeh

## Bokeh Overview

Bokeh is a library for creating interactive data visualizations that target web-browsers. It offers a concise, human-readable syntax, which allows for rapidly presenting data in an aesthetically-pleasing manner. It is equally suitable for static and streaming datasets.

From a technical perspective, Bokeh consists of two components. The first is a Python library with which the user interacts to build a visualization. The library offers [a number of modules](https://bokeh.pydata.org/en/latest/docs/reference.html) that allow varying levels of control, and permit the user to work either at a high or low level of abstraction. In this tutorial, we'll generally work at a high level of abstraction by using the `bokeh.plotting` module, which handles most of the behind-the-scenes work of putting together a visualization. This level of abstraction is comparable to that of [Matplotlib](http://matplotlib.org), so that a standard workflow involves the user instantiating a plot (through the Bokeh `figure` object), then adding data to the plot, styling it, and outputting the results. The way in which Bokeh's Python library outputs a plot leads us to the second component of Bokeh.

Because Bokeh targets web-browsers for output, it relies on a stand-alone, client-side JavaScript library called BokehJS to render visualizations and handle user interactions. The JavaScript library uses the HTML5 canvas for visualization and as input, it accepts JSON objects that dictate what the library should render in the canvas. The necessary JSON objects are produced by Bokeh's Python library, and their rendering in the browser is handled seamlessly by Bokeh; the only necessary coding to produce a visualization occurs on the Python side, while the creation of the JSON objects and rendering in the browser is transparent to the user.

## Your First Plot

First, create a new file called `my_first_plot.py` in the same directory as  `wwii_thor.csv` and then open it up in a text editor. We'll be adding lines to this file to run. 

To implement and use Bokeh, we first import some basics that we need from the `bokeh.plotting` module.

```python
#my_first_plot.py
from bokeh.plotting import figure, output_file, show	
```

 `figure` is the core object that we'll be using to create plots. It handles the styling of plots, including title, labels, axes, and grids, and exposes methods for adding data to the plot. The `output_file` function defines how the visualization will be rendered (namely to an html file) and the `show` function will be invoked when the plot is ready for output; this function tells Bokeh it is time to serialize the plot to JSON and send it along to the browser for rendering.

Bokeh recommends that `output_file`, to which we pass a file name, be called at the start of your script. An alternative output function to be aware of is `output_notebook` which is used to show plots in-line in a Jupyter Notebook.

```python
output_file('my_first_graph.html')
```

Next we'll create some data to plot. Data in Bokeh can take on different forms, but at its simplest, data is lists of values. We create one list for our x-axis and one for our y-axis.

```
x = [1, 3, 5, 7]
y = [2, 4, 6, 8]
```

With our output format and data fixed, we can instantiate a `figure`, add the data to it, and output it in only three lines of code.

```python
p = figure()
p.circle(x, y, size=10, color='red')
show(p)
```

<div class="alert alert-warning">

​	*p* is a common variable name for a `figure` object, since a figure is a type of plot.

</div>

After instantiating the figure, we call the `circle` method to plot our data. This type of method is known as a *glyph method*. The term *glyph* in Bokeh refers to the lines, circles, bars, and other shapes that are added to plots to display data. 

When calling a glyph method, at a minimum, we'll pass the data we would like to plot, but frequently we'll add styling arguments. Here, we set a size and color for our circle glyph. Calling `show` and passing the instantiated `figure` outputs the results to the browser.

{% include figure.html filename="visualizing-with-bokeh-1.png" caption="Plotting a Single Glyph" %}

Now let us take a look at it! 

In your command line, make sure you are in the directory where you have saved the file and then run the file with the `python` command like:

```
python my_first_plot.py
```

A web browser will now appear with your output. In that output, the red circles are the result of our glyph method call. Note that Bokeh has automatically handled the creation of the grid-lines and tick labels. At the upper right, the default toolbar is displayed. The tools include drag, box zoom, wheel zoom, save, reset, and help. Using these tools, a user can pan along the plot or zoom in on interesting portions of it. Since this is a stand-alone HTML page, which includes a reference to BokehJS, it can be immediately passed to a coworker for exploration or posted to the web.

## Adding to Your First Plot

A Bokeh plot is not limited to displaying a single dataset or glyph. Each plot can contain multiple glyphs and reference multiple data sets. In the above example, after we call the `circle` glyph method and before we call `show(p)`, let's add a few other glyph methods. Remember, we are still working with the `my_first_plot.py` file.

```python
p.line(x, y, color='blue', legend='line')
p.triangle(x[::-1], y, color='green', size=10, legend='triangle')
p.square(y, x, color='#FF0000', size=20)
```

<div class="alert alert-warning">

​	To vary the data, we have reversed the list of x-coordinates for the triangle and swapped the x- and y-	coordinates for the square.

</div>

If we wanted, we could just keep adding glyphs to the plot! In addition to the `circle`, `line`, `square`, and `triangle` glyphs, there are many others, including:  `asterisk`, `circle_cross`, `circle_x`, `cross`, `diamond`, `diamond_cross`, `inverted_triangle`,  `square_cross`, `square_x`, and `x`. We'll discuss glyphs for plotting bar charts in a later section.

Above, we've styled each of the glyphs individually. Also, note that all we needed to build a legend was to pass a legend argument to at least one glyph method. You can use this argument to add a legend entry for as many glyphs as you like.

The default rendering location of the legend is at the top right, but since this would cover some of the data, let's move it by setting a different location.

```
p.legend.location = 'top_center'
```

This is our first example of setting properties directly on the `figure`.  As we progress, we'll encounter other plot properties that define the plot's styling. If we now call `show(p)`, our new multi-glyph plot will render with a top-centered legend.

{% include figure.html filename="visualizing-with-bokeh-2.png" caption="Plotting Multiple Glyphs with Styling and a Positioned Legend" %}

Your complete code for this plot should now look like this:

```python
#my_first_plot.py
from bokeh.plotting import figure, output_file, show

output_file('my_first_plot.html')

x = [1, 3, 5, 7]
y = [2, 4, 6, 8]

p = figure()

p.circle(x, y, size=10, color='red')
p.line(x, y, color='blue', legend='line')
p.triangle(x[::-1], y, color='green', size=10, legend='triangle')
p.square(y, x, color='#FF0000', size=20)

p.legend.location = 'top_center'

show(p)
```

As a reminder, run it with the following command and you will see the results in your browser:

```
python my_first_plot.py
```

# Bokeh and Pandas: Exploring the WWII THOR Dataset

In the previous example, we manually created two short Python lists for our x and y data. What happens when you have real-world data with tens-of-thousands of rows and dozens of columns stored in an external format? Pandas, a widely-used data science library, provides a ready solution to this problem and integrates seamlessly with Bokeh to supply real-world datasets to plots.

## Pandas Overview

For the purposes of this tutorial, I will only touch on the basic functionality of Pandas that is necessary to produce our visualizations. The Programming Historian tutorial, [Wrangling Museum Collection Data with Pandas](), provides an excellent yet concise overview of Pandas that I would recommend for expanding your knowledge of Pandas.  

Pandas has quickly become the *de facto* Python library for data science workflows; its integration with other major data science and machine learning libraries has only fueled its rise in popularity.[^1] Pandas provides functionality to quickly and efficiently read, write, and modify datasets for analysis. To accomplish this, Pandas provides two major data structures which represent different dimensionalities of data:

-  `Series` for 1-dimensional data 

-  `DataFrame` for 2-dimensional data

To understand this concept of data dimensionality you can think about 1-D `Series` as a single column with rows (dimension = row number)  and a 2-D `DataFrame` as a spreadsheet with rows and columns ( dimensions = row number and column number).

<div class="alert alert-warning">
A data structure, known as a `Panel`, for holding 3-dimensional data (think stacked spreadsheets) is deprecated as of Pandas 0.20.0 and will be removed in future versions.
</div>

With its rows and columns, the `DataFrame` is most frequently used and it is through this object that we'll interact with our WWII THOR dataset. Let's examine the Pandas `DataFrame` object and its basic functionality in context by loading and exploring our dataset.

## Loading Data in Pandas

We start by importing the Pandas library and then calling `read_csv()`  and passing it a filename. Note that the Pandas library is aliased as *pd*. This alias is a convention followed in Pandas' official documentation and it's widely used by the Pandas community. For this reason, I'll use the *pd* alias throughout the tutorial.

Let's create a new file called `loading_data.py`.

```python
#loading_data.py
import pandas as pd

df = pd.read_csv('thor_wwii.csv')
```

[Many other methods](https://pandas.pydata.org/pandas-docs/stable/api.html#input-output) exist for reading various data formats in Pandas, such as JSON, SQL tables, Excel files, and HTML. The result of any read call will alway be one of the Pandas objects discussed above. In this case, `read_csv` creates a `DataFrame` that holds our 2-dimensional csv data. By convention, the variable name *df* is used to represent the initially loaded dataframe in tutorials and basic code examples. 

The `shape` attribute gives the dimensions of our dataframe. 

```python
df.shape
		(178281, 19)
```
We have 178,281 records of missions with 19 columns per record. To see what the 19 columns are, we can access the dataframe's `columns` object.

```python
df.columns.tolist()
		['MSNDATE', 'THEATER', 'COUNTRY_FLYING_MISSION', 'NAF', 'UNIT_ID', 						'AIRCRAFT_NAME', 'AC_ATTACKING', 'TAKEOFF_BASE', 'TAKEOFF_COUNTRY', 					'TAKEOFF_LATITUDE', 'TAKEOFF_LONGITUDE', 'TGT_COUNTRY', 'TGT_LOCATION', 				'TGT_LATITUDE', 'TGT_LONGITUDE', 'TONS_HE', 'TONS_IC', 'TONS_FRAG', 					'TOTAL_TONS']
```
Some of these column names are self explanatory, but it is worth pointing out the following: MSNDATE (mission date), NAF (numbered airforce responsible for mission), AC_ATTACKING (number of aircraft), TONS_HE (high-explosives), TONS_IC (incendiary devices), TONS_FRAG (fragmentation bombs).

To view the first five rows of data, we call the `head` method. The output shown here is abbreviated for the sake of space.

```python
df.head()
MSNDATE THEATER COUNTRY_FLYING_MISSION  NAF   UNIT_ID 	AIRCRAFT_NAME  \
0  03/30/1941     ETO          GREAT BRITAIN  RAF   84 SQDN      BLENHEIM   
1  11/24/1940     ETO          GREAT BRITAIN  RAF  211 SQDN      BLENHEIM   
2  12/04/1940     ETO          GREAT BRITAIN  RAF  211 SQDN      BLENHEIM   
3  12/31/1940     ETO          GREAT BRITAIN  RAF  211 SQDN      BLENHEIM   
4  01/06/1941     ETO          GREAT BRITAIN  RAF  211 SQDN      BLENHEIM   
```
To access data within a dataframe, in this tutorial we'll only rely on two basic approaches that use indexing: 

The first is to reference a column by name as in `df['MSNDATE']`. This returns a `Series` object holding the 1-dimensional column data. To access multiple columns, we pass a list of names to the indexer as in `df[['MSNDATE', 'THEATER']]`, which returns a 2-dimensional `DataFrame` object. 

The second is to use the same approach as Python list slicing in order to get row data. For example, `df[0:100]` returns a `DataFrame` containing the first 100 rows. 

<div class="alert alert-warning">

There are more flexible [methods](https://pandas.pydata.org/pandas-docs/stable/indexing.html) to access data. These are worth exploring if you plan to use Pandas for more advanced work.

</div>

## The Bokeh ColumnDataSource

Now that we have learned how to create a Bokeh plot and how to load data into Pandas, it is time to learn how to link Pandas' data with Bokeh's plots. The Bokeh `ColumnDataSource` provides this functionality. 

The object's constructor accepts a Pandas `DataFrame` as an argument. After it is created, the `ColumnDataSource` can then be passed to glyph methods via the `source` parameter and other parameters, such as our x and y data, can then reference column names within our source. Let's go through an example of this.

Using our THOR dataset, we'll plot the latitude and longitude of the 100 most heavily bombed targets. 

To start, we'll import Pandas, the necessary object and functions from `bokeh.plotting`, and the `ColumnDataSource` object from `bokeh.models`. We'll then immediately set our output file following Bokeh's recommended best practices. Finally, we'll use the `read_csv` method to load our csv.

Let's start a new file called `column_datasource.py`.

```python
#column_datasource.py
import pandas as pd
from bokeh.plotting import figure, output_file, show
from bokeh.models import ColumnDataSource
output_file('columndatasource_example.html')

df = pd.read_csv('thor_wwii.csv')
```

Since we don't want to plot all 170,000+ targets, we'll call Pandas `sort_values` method to sort by the TOTAL_TONS column in descending order. Using the row slice `df[0:100]` we pass the top 100 targets to the `ColumnDataSource` constructor.

```python
df = df.sort_values(by=['TOTAL_TONS'], ascending=False)
source = ColumnDataSource(df[0:100])
```

Next, we create our `figure` object and call the `circle` glyph method to plot our data. Here's where the `ColumnDataSource` variable comes into play. It is passed as our `source` argument to the glyph method and the column names holding longitude and latitude are passed as our `x` and `y` arguments.

```python
p = figure()
p.circle(x='TGT_LONGITUDE', y='TGT_LATITUDE',  source=source, 
         size=25, line_color='green', fill_color='white')
```

Interestingly, we're not limited to just using column names for coordinates. We can also pass a column name for other parameters such as `size`, `line_color`, or `fill_color`. This allows styling options to be determined by columns in the datasource itself. 

<div class="alert alert-warning">

​	Throughout the tutorial, I often pass arguments by name where they could more succinctly be passed by position. This is helpful, in my opinion, for the reader to keep track of what arguments are being passed.

</div>

Before we call  `show` to render the plot, let's add labels and exert more control over the styling by setting some of the `figure` object's properties.

```python
p.plot_width = 900
p.plot_height = 750

p.title.text = 'Target Locations'
p.title.align = 'center'
p.title.text_font_size = '18pt' 

p.background_fill_color = '#edfcff'
p.outline_line_width = 1
p.outline_line_color = 'black'

p.xaxis.axis_label = 'Longitude'
p.xaxis.axis_label_text_font_size = '12pt'
p.xgrid.minor_grid_line_color = 'black'
p.xgrid.minor_grid_line_alpha = 0.1

p.yaxis.axis_label = 'Latitude'
p.yaxis.axis_label_text_font_size = '12pt'
p.ygrid.minor_grid_line_color = 'black'
p.ygrid.minor_grid_line_alpha = 0.1
```

This approach to styling is mostly self-explanatory and this is an advantage of Bokeh, but you can see that sometimes Bokeh takes this too far. Some of its naming conventions are too verbose; for example, `axis_label_text_font_size` could probably just be called *label_font_size* since we already know we're operating on an axis and the use of text and font seems redundant. Hopefully, this verbosity will be reigned in with future releases.

Let's make sure to add the line to show the plot. 

```python
show(p)
```

Now we can run `column_datasource.py` to see how it looks in the browser.

{% include figure.html filename="visualizing-with-bokeh-3.png" caption="Plotting with the ColumnDataSource and More Styling Options" %}

# Categorical Data and Bar Charts: Munitions Dropped by Country

In the preceding examples, we plotted numerical data. Frequently, though, we want to plot categorical data.  Categorical data, in contrast to numeric, is data that can be divided into groups, but doesn't necessarily have a quantitative aspect to it. For example, while your height is numerical, your hair color is categorical. From the perspective of our dataset, features like attacking country or type of munition hold categorical data, while features like target latitude and longitude or the weight of munitions hold numerical data. 

 In this section,  we'll learn how to use categorical data as our x-axis values in Bokeh and how to use the `vbar` glyph method to create a vertical bar chart (an `hbar` glyph method functions similarly to create a horizontal bar chart). In addition, we'll learn about preparing categorical data in Pandas by grouping it and we'll add a bit to our knowledge of Bokeh styling.

To work through this information, we'll create a bar chart that shows the total tons of munitions dropped by each country listed in our csv.

We'll start this example by creating a new file called `munitions_by_country.py` and then importing the Pandas library and the basic elements from Bokeh (i.e. `figure`, `output_file`, `show`, and `ColumnDataSource`). We'll also make two new imports here.`Spectral5` means is a set of five colors from Bokeh's Spectral palette, one of its [pre-made color palettes](https://bokeh.pydata.org/en/latest/docs/reference/palettes.html) and `factor_cmap` is a helper method for coloring bar-charts.

Next set our `output_file`  and load the thor_wwii.csv.   

```python
#munitions_by_country.py
import pandas as pd
from bokeh.plotting import figure, output_file, show
from bokeh.models import ColumnDataSource

from bokeh.palettes import Spectral5
from bokeh.transform import factor_cmap
output_file('munitions_by_country.html')

df = pd.read_csv('thor_wwii.csv')
```

To get from the 170,000+ records of individual missions to one record per attacking country with the total munitions dropped, we use the dataframe's `groupby` method. This method accepts a column by which to group the data and one or more aggregating methods that tell Pandas how to group the data. The output is a new dataframe.

```python
grouped = df.groupby('COUNTRY_FLYING_MISSION')['TOTAL_TONS'].agg(['sum'])
```

Let's take this one piece at a time. The `groupby('COUNTRY_FLYING_MISSION')` sets the column that we're grouping on. In other words, this says that we want the resulting dataframe to have one row per unique entry in the column `COUNTRY_FLYING_MISSION`. Since we don't care about aggregating all 19 columns in the dataframe we choose just the TOTAL_TONS columns with `['TOTAL_TONS']` . Finally, we use the `agg` method and pass it a list of functions to let Pandas know how to aggregate all of the different rows. We pass in `sum`  to tell Pandas to sum the TOTAL_TONS column.

If you look at the variable `grouped`,  you'll see that Pandas has grouped by the five unique countries in our dataset and summed the total tons dropped by each.

```
 						sum
COUNTRY_FLYING_MISSION 	
AUSTRALIA 				479.89
GREAT BRITAIN 			1112598.95
NEW ZEALAND 			2629.06
SOUTH AFRICA 			11.69
USA 					1625487.68

```

To plot this data, let's first reduce the sums. Right now these represent tons, but we'll convert to kilotons by dividing by 1000. This is a convenience that we'll continue to use in future examples.

```python
grouped['sum'] = grouped['sum']/1000
```

Now, we make a `ColumnDataSource` from our grouped data and create a `figure`. Since our x-axis will list the five countries, not numerical data, we need to tell the figure how to handle the x-axis.

To do this, we create a list of countries from our source object, using `source.data` and the column name as key. The list of countries is then passed as the `x_range` to our `figure` constructor. Because this is a list of text data, the figure knows the x-axis is categorical and it also knows what possible values our x range can take (i.e. AUSTRALIA, GREAT BRITAIN, etc.).

```python
source = ColumnDataSource(grouped)
countries = source.data['COUNTRY_FLYING_MISSION'].tolist()
p = figure(x_range=countries)
```

Now we'll plot our data as individually colored bars and add basic labels. To color our bars we use the `factor_cmap` helper function. This create a special color map that matches an individual color to each category (i.e. what Bokeh calls a *factor*). The color map is then passed as the color argument to our glyph method.

For the data in our glyph method, we're passing a source and again referencing column names. Instead of using a `y` parameter, however, the `vbar` method takes a `top` parameter. A `bottom` parameter can equally be specified, but if left out, its default value is 0. 

```python
color_map = factor_cmap(field_name='COUNTRY_FLYING_MISSION', 
                    palette=Spectral5, factors=countries)

p.vbar(x='COUNTRY_FLYING_MISSION', top='sum', source=source, width=0.70, color=color_map)

p.title.text ='Munitions Dropped by Allied Country'
p.xaxis.axis_label = 'Country'
p.yaxis.axis_label = 'Kilotons of Munitions'

show(p)
```

{% include figure.html filename="visualizing-with-bokeh-4.png" caption="A Bar Chart with Categorical Data and Coloring" %}

<div class='alert'>

If you have a chance, it's worth playing around with Bokeh's [color palettes](https://bokeh.pydata.org/en/latest/docs/reference/palettes.html). In the above example, try rewriting the code to use something other than Spectral5, such as Inferno5 or RdGy5. To take it one step further, you can try your hand at using built-in palettes in any example that uses color.

</div>

# Stacked Bar Charts and Sub-sampling Data: Types of Munitions Dropped by Country

Because the previous plot shows that the USA and Great Britain account for the overwhelming majority of bombings, let's focus on these two countries and learn how to make a stacked bar chart that shows the types of munitions each country used. 

Three columns store the types of munitions dropped: TONS_HE, TONS_FRAG, and TONS_IC. Respectively, these represent the tons of high-explosives, fragmentation bombs, and incendiary devices dropped. We'll start with out boilerplate in a new file called `munitions_by_country_stacked.py`, this time importing a three-color Spectral palette, one color for each type of explosive.

```python
#munitions_by_country_stacked.py
import pandas as pd
from bokeh.plotting import figure, output_file, show
from bokeh.models import ColumnDataSource
from bokeh.palettes import Spectral3
output_file('types_of_munitions.html')

df = pd.read_csv('thor_wwii.csv')
```

Since the x-axis is again categorical, we'll need to group and aggregate our data. This time, though, we need to exclude any records which do not have a COUNTRY_FLYING_MISSION with a value of GREAT BRITAIN or USA. To do that, we'll use a Pandas mask.

A mask in pandas is simply a Series (i.e. 1-dimensional data structure) that holds Boolean values.

```python
mask = df['COUNTRY_FLYING_MISSION'].isin(('USA','GREAT BRITAIN'))
df = df[mask]
```

In this code, the statement `df['COUNTRY_FLYING_MISSION'].isin(('USA','GREAT BRITAIN'))` creates our mask. For each row in `df`, the `isin` function checks whether COUNTRY_FLYING_MISSION has a value of USA or GREAT BRITAIN. If it does, its corresponding value in the mask is `True` and if not, it's `False`

Executing `mask.head()` shows what the mask looks like.

```p
0    True
1    True
2    True
3    True
4    True
```

Simply stated, a mask is a list that shows which rows in the dataframe meet our masking criteria. When applied to our dataframe via `df[mask]`, a new dataframe is created in which rows with a `True` mask value are kept and rows with a `False` mask value are discarded. After the mask has been applied here, executing `df.shape` shows that 125,526 rows remain of an original 178,281.

Now that we have reduced the dataframe to show only records for the USA and Great Britain, we'll group our data with `groupby` and aggregate the three columns that hold bomb types. 

```python
cols_to_aggregate = ['TONS_IC', 'TONS_FRAG', 'TONS_HE']
group = df.groupby('COUNTRY_FLYING_MISSION')[cols_to_aggregate].agg(['sum'])

#convert tons to kilotons again
group[cols_to_aggregate] = group[cols_to_aggregate]/1000
```

Like before, we create a source object and make sure our figure uses categorical data for the x-axis.

```python
source = ColumnDataSource(group)
countries = source.data['COUNTRY_FLYING_MISSION'].tolist()
p = figure(x_range=countries)
```

To create the stacked bar chart, we call the `vbar_stack` glyph method. Rather than passing a single column name to a `y` parameter, we instead pass a list of column names as `stackers`. The order of this list determines the order that the columns will be stacked from bottom to top (after you've worked through this example, try switching the column order to see what happens). The `legend` argument supplies text for each stacker and the `Spectral3` palette provides colors for each stacker. 

```python

p.vbar_stack(stackers=['TONS_HE_sum', 'TONS_FRAG_sum', 'TONS_IC_sum'], 
             x='COUNTRY_FLYING_MISSION', source=source, 
             legend = ['High Explosive', 'Fragmentation', 'Incendiary'],
             width=0.5, color=Spectral3)
```

We'll add basic styling and labeling, and then output the plot.

```python
p.title.text ='Types of Munitions Dropped by Allied Country'
p.legend.location = 'top_left'

p.xaxis.axis_label = 'Country'
p.xgrid.grid_line_color = None	#remove the x grid lines

p.yaxis.axis_label = 'Kilotons of Munitions'

show(p)
```

{% include figure.html filename="visualizing-with-bokeh-5.png" caption="A Stacked Bar Chart with Categorical Data and Coloring" %}

# Time-Series, Annotations, and Multiple Plots: Bombing Operations over Time

You've had some time to get used to Bokeh's syntax, so now that we're getting into deeper concepts, let's dive right in with a full code example in a file named `my_first_timeseries.py`.

```python
#my_first_timeseries.py
import pandas as pd
from bokeh.plotting import figure, output_file, show
from bokeh.models import ColumnDataSource
output_file('simple_timeseries_plot.html')

df = pd.read_csv('thor_wwii.csv')

#make sure MSNDATE is a datetime format
df['MSNDATE'] = pd.to_datetime(df['MSNDATE'], format='%m/%d/%Y')

group = df.groupby('MSNDATE')['TOTAL_TONS'].agg(['sum'])

group['sum'] = group['sum'].fillna(0)
group['sum'] = group['sum']/1000

source = ColumnDataSource(group)

p = figure(x_axis_type='datetime')
p.line(x='MSNDATE', y='sum', line_width=2, source=source)
p.yaxis.axis_label = 'Kilotons of Munitions Dropped'

show(p)
```

Really, only two items should stand out as new here. 

First, the statement `df['MSNDATE'] = pd.to_datetime(df['MSNDATE'], format='%m/%d/%Y')` makes sure our MSNDATE column is, in fact, a datetime. This is important because often data loaded from csv will not be properly typed as datetime. Supplying the `format` argument isn't required, but it significantly speeds up the process of type conversion.

Second, we pass the argument `x_axis_type='datetime'` to our figure constructor to tell it that our x data will be datetimes. Otherwise, Bokeh works seamlessly with time data just like any other type of numerical data! 

Looking at the output, though, you might notice an issue.

{% include figure.html filename="visualizing-with-bokeh-6.png" caption="A Basic Time-Series Plot" %}

This data is volatile and, perhaps, too fine-grained for our needs. Having daily data over the course of five years is great, but plotting it as such obfuscates larger trends. To successfully plot time-series data, we need a way to change the time-scale we're looking at so that, for example, we can plot summarized data by weeks, months, or years.

Thankfully, Pandas offers a quick and easy way to do this. By modifying a single line of code in the above example, we can *resample* our time-series data to any valid unit of time. 

## Resampling Time-Series Data

Resampling time-series data can involve either upsampling (creating more records) or downsampling (creating fewer records). For example, a list of daily temperatures could be upsampled to a list of hourly temperatures or downsampled to a list of weekly temperatures. we'll only be downsampling in this tutorial, but upsampling is very useful when you are trying to match a sporadically-measured dataset with one that is more periodically measured.

To resample our data, we use a Pandas `Grouper` object, to which we pass the column name holding our datetimes and a code representing the desired resampling frequency. In the case of our data, the statement `pd.Grouper(key='MSNDATE', freq='M') ` will be used to resample our MSNDATE column by *M*onth. We could equally resample by *W*eek, *Y*ear, *H*our, and [so forth](http://pandas.pydata.org/pandas-docs/stable/timeseries.html#offset-aliases). These frequency designations can also be prefaced with numbers so that, for example, `freq='2W'` resamples at two week intervals! 

To complete the process of resampling and plotting our data, we pass the above `Grouper` object to our `groupby` function in place of the raw column name. The `groupby` statement from the previous code example should now look like this:

``` python
group = df.groupby(pd.Grouper(key='MSNDATE', freq='M'))['TOTAL_TONS'].agg(['sum'])
```

Rerunning the above code sample will produce a much cleaner plot with obvious trends. The plot now shows how in both the Spring of 1944 and 1945, the scale of Allied bombing operations reached new highs, and it shows a smaller spike in the summer of 1945 during the acceleration of bombings against the Japanese after Germany's surrender.

{% include figure.html filename="visualizing-with-bokeh-7.png" caption="A Time-Series Plot with Data Resampled to Months" %}

## Annotating Trends in Plots

Let's look more closely at the increased bombings in Europe in 1944 and 1945 and point out some of these trends in our plot. To do this, we'll mask our dataset so that we work only with bombings in the European Theater of Operations (ETO), resample the data at two-week intervals (`freq='2W'`), and then plot the results in the same manner as before. We'll also add some styling to make it look more professional.

```python
#annotating_trends.py
import pandas as pd
from bokeh.plotting import figure, output_file, show
from bokeh.models import ColumnDataSource, BoxAnnotation, Label
from datetime import datetime
output_file('eto_operations.html')

df = pd.read_csv('thor_wwii.csv')

#mask for the European Theater of Operations
mask = df['THEATER']=='ETO'
df = df[mask]

df['MSNDATE'] = pd.to_datetime(df['MSNDATE'], format='%m/%d/%Y')
group = df.groupby(pd.Grouper(key='MSNDATE', freq='2W'))['TOTAL_TONS'].agg(['sum'])
group['sum'] = group['sum'].fillna(0)
group['sum'] = group['sum']/1000

source = ColumnDataSource(group)

p = figure(x_axis_type="datetime", width=900, height=750)

p.line(x='MSNDATE', y='sum', line_width=2, source=source)

p.title.text = 'European Theater of Operations'
p.title.align = 'center'
p.title.text_font_size = '14pt'

p.xaxis.major_label_orientation = -45
p.xaxis.major_label_text_font_style = 'bold'
p.xaxis.major_label_text_font_size = '10pt'

p.yaxis.axis_label = 'Kilotons of Munitions Dropped'
p.yaxis.axis_label_text_font_size = '12pt'
p.yaxis.axis_label_text_font_style = 'normal'
p.yaxis.major_label_text_font_size = '10pt'
p.ygrid.minor_grid_line_color = '#f7f7f7'

show(p)
```

{% include figure.html filename="visualizing-with-bokeh-8.png" caption="A Time-Series Plot of the ETO with Data Resampled to Months" %}

In the above example, try your hand at resampling this data using any of [Pandas' time frequencies](http://pandas.pydata.org/pandas-docs/stable/timeseries.html#offset-aliases). Remember, you can preface these frequencies with numbers as well (e.g. if you were working with historical stock market data, 2Q would give you bi-quarterly data!)

Bokeh provides a number of useful ways to annotate trends in plots or add additional labels. Let's use this functionality to highlight the time between D-Day and the surrender of Germany in our previous graph.

To do this, we'll create a `BoxAnnotation` and `Label`, then add these to our `figure` before showing it. To create the box, we first need to determine its coordinates. 

Coordinates for Bokeh annotations can be either absolute (i.e. positioned using screen units), meaning they always stay in one place, or they can be positioned in relation to data. Our annotations will all be positioned using data coordinates. 

```python
box_left = pd.to_datetime('6-6-1944')
box_right = pd.to_datetime('5-8-1945')
box_top = source.data['sum'].max() + 5
box_bottom = 0
```

The box's left will be June 6, 1944 (D-Day) and its right will be May 8, 1945 (VE Day). In this case, the dates follow a month-day-year format, but `to_datetime` also works with [day-first and year-first formats](https://pandas.pydata.org/pandas-docs/stable/generated/pandas.to_datetime.html). We'll place the box's top just a little above the maximum peak of the line in our plot and its bottom at 0. We actually don't have to specify all of these coordinates; not specifying a coordinate means that dimension is infinite, so, for example, we could leave out the top and bottom. 

We pass these coordinates to the `BoxAnnotation` constructor along with some styling arguments. Then, we add it to the our figure using the `add_layout()` method.

```python
box = BoxAnnotation(left=box_left, right=box_right, bottom=box_bottom, top=box_top,
                    line_width=1, line_color='black', line_dash='dashed',
                    fill_alpha=0.2, fill_color='orange')

p.add_layout(box)
```

Adding labels for D-Day and VE Day is equally easy. We pass `x` and `y` coordinates in data space, the text of the label, and some styling arguments to the `Label` constructor. Then we again call `add_layout()`.

```python
d_day = Label(x=box_left, y=box_top, text='D-Day', 
              text_align='center', text_font_style='italic', text_font_size='10pt')
p.add_layout(d_day)

ve_day = Label(x=box_right, y=box_top, text='V-E Day', 
               text_align='center', text_font_style='italic', text_font_size='10pt')
p.add_layout(ve_day)
```

{% include figure.html filename="visualizing-with-bokeh-9.png" caption="A Time-Series Plot of the ETO with Annotations Added" %}

<div class="alert alert-warning"> 

​	Try to create a similar plot for the Pacific Theater of Operations (PTO). Annotate the invasion of Iwo Jima (February 19, 1945) and Japan's announcement of surrender (August 15, 1945).

</div>

# Spatial Data: Mapping Target Locations

Bokeh provides [built-in tile providers](https://bokeh.pydata.org/en/latest/docs/reference/tile_providers.html) that render base maps of the world. These are contained in the `bokeh.tile_providers` module. For this example, we'll use the CartoDB Tile Service (CARTODBPOSITRON).

We'll also be using functions imported from the `pyproj` library. Bokeh tile providers use the Web Mercator projection for mapping and since our coordinates are stored as latitude/longitude, we'll define a custom function to convert them before mapping. Although the subject coordinate systems and projections is outside the scope of this tutorial, there are many useful web resources for the interested reader.

<div class="alert alert-warning">
If your own dataset has place names, but not latitude and longitude, don't worry! You can find ways to easily get coordinates from place names in Programming Historian's [Geocoding Historical Data using QGIS](programminghistorian.org/lessons/geocoding-qgis) or [Web Mapping with Python and Leaflet](https://programminghistorian.org/lessons/mapping-with-python-leaflet#geocoding-with-python)
</div>

The boilerplate imports and our conversion function are defined below.

```python
#target_locations.py
import pandas as pd
from bokeh.plotting import figure, output_file, show
from bokeh.models import ColumnDataSource, Range1d
from bokeh.layouts import layout
from bokeh.tile_providers import CARTODBPOSITRON
from pyproj import Proj, transform 
output_file('mapping_targets.html')

#helper function to convert lat/long to easting/northing for mapping
#this relies on functions from the pyproj library
def LongLat_to_EN(long, lat):
    try:
      easting, northing = transform(
        Proj(init='epsg:4326'), Proj(init='epsg:3857'), long, lat)
      return easting, northing
    except:
      return None, None
```

We'll load our data and then apply our conversion function to create new E and N columns that store our Web Mercator easting and northing.

```python
df = pd.read_csv('assests/thor_wwii.csv')
#convert all lat/long to webmercator and store in new column
df['E'], df['N'] = zip(*df.apply(lambda x: LongLat_to_EN(x['TGT_LONGITUDE'], x['TGT_LATITUDE']), axis=1))
```

Because a single target can appear in multiple records, we need to group the data by E and N to get unique target locations. Otherwise, we'd end up mapping the same target every time it appears in a record. 

The `reset_index` function applied after aggregating is new here. By default, when Pandas groups these two columns it will make E and N the index for each row in the new dataframe. Since we just want E and N to remain as normal columns for mapping, we call `reset_index`.

```python
group = df.groupby(['E', 'N'])['TOTAL_TONS'].agg(['sum']).reset_index()
source = ColumnDataSource(group)
```

To set bounds for our map, we'll set a minimum and maximum value for our plot's  `x_range` and `y_range`.  We use the `Range1D` object, which represents bounded 1-dimensional data in Bokeh. 

```python
left = -2150000
right = 18000000
bottom = -5300000
top = 11000000

p = figure(x_range=Range1d(left, right), y_range=Range1d(bottom, top))
```

Finally, we call `add_tile` and pass the tile provider we imported. Then, we use glyph methods just like in any other plot. Here, we call `circle` and pass the easting and northing columns as our x and y data.

```python
p.add_tile(CARTODBPOSITRON)
p.circle(x='E', y='N', source=source, line_color='grey', fill_color=None)

p.axis.visible = False

show(p)
```

{% include figure.html filename="visualizing-with-bokeh-11.png" caption="A Map of Target Locations" %}

<div class="alert alert-warning"> 

​	Two maps can be linked together just like other plots by passing along one plot's `x_range` and `y_range` to another plot. This is very handy for showing multiple types of spatial information.

</div>

# Further Resources

Bokeh User Guide: https://bokeh.pydata.org/en/latest/docs/user_guide.html

Bokeh Gallery: https://bokeh.pydata.org/en/latest/docs/gallery.html

Pandas Documentation: https://pandas.pydata.org/pandas-docs/stable/index.html

Pandas Cheat Sheet: https://www.kdnuggets.com/2017/01/pandas-cheat-sheet.html

Bokeh Cheat Sheet: https://www.kdnuggets.com/2017/03/bokeh-cheat-sheet.html



[^1]: https://stackoverflow.blog/2017/09/14/python-growing-quickly/