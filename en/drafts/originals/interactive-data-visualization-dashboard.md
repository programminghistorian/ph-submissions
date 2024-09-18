---
title: "Creating a Dashboard for Interactive Data Visualization with Dash in Python"
slug: interactive-data-visualization-dashboard
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Luling Huang
reviewers:
- Diego Alves
- Johannes Breuer
editors:
- Caio Mello
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/609
difficulty: 3
activity: presentation
topics: data visualization, web development
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

To advance open scholarship in the humanities, it is important to make research outputs more accessible to other scholars and the general public. Creating a web-based interactive dashboard to visualize data results has become a popular method to achieve this goal. There are a wide range of examples, such as [this project that tracks social media data](https://portal.research.lu.se/en/publications/stancexplore-visualization-for-the-interactive-exploration-of-sta), [a study that recreates W. E. B. Du Bois' study of black residents in Philadelphia](http://digitalhumanities.org/dhq/vol/16/2/000609/000609.html), and [a project that visualizes the narrative structure in William Faulkner's work](http://digitalhumanities.org/dhq/vol/15/2/000548/000548.html)). 

Unlike static graphs, interactive dashboards allow readers to explore patterns in the data based on their specific interests by filtering, sorting, or changing data views. Features like hover-over tooltips can also provide additional information without cluttering the main display. This lesson will walk you through the process of creating interactive dashboards based on publicly available datasets using the open-source [Dash library in Python](https://dash.plotly.com/introduction).

For demonstration, this lesson is guided by two sample research questions in the field of media and communication studies, each representing a different temporal focus. The first research question (RQ1) is focused on contemporary news and asks: How do U.S. television stations cover the war in Ukraine? The dataset used for RQ1 is a publicly available dataset of transcription texts from television news. This lesson uses RQ1 as an example to guide the majority of the procedure steps in this lesson. If you wonder what the end product will look like, Figure 1 shows a screenshot of the dashboard for RQ1:

{% include figure.html filename="en-or-interactive-data-visualization-dashboard-01.png" alt="A screenshot showing what the RQ1 dashboard looks like. There are two line graphs: one shows how media attention to Ukraine-related words in TV stations changes over time; the other shows the same but for Russia-related words" caption="Screenshot of the RQ1 dashboard." %}

To demonstrate more of the range of applications available with web-based dashboards, this lesson also explores a historical example with the second research question. RQ2 asks, "How has the ranking of top non-English languages of American newspapers changed from the 1690s to the present? The dataset used for RQ2 is a publicly available dataset of newspaper directories. Although I will only provide an overview of the procedure for RQ2, the code for RQ2 is provided so that you can learn, test, or adapt it for your own purposes. Figure 2 shows a screenshot of the dashboard for RQ2:

{% include figure.html filename="en-or-interactive-data-visualization-dashboard-02.png" alt="A screenshot showing what the RQ2 dashboard looks like. There are two pie graphs: one shows the top 10 non-English newspapers in the U.S. in the 1690s; the other shows the same but for 2020s" caption="Screenshot of the RQ2 dashboard. Each chart shows the top-10 non-English newspapers in a given decade. The percentage is the count of newspaper titles in a given non-English language divided by the sum of non-English newspaper titles." %}

This lesson contributes to the existing Programming Historian lessons by adding a tutorial focused on creating an interactive web-based dashboard in Python ([see a similar English lesson focused on using Shiny in R](https://programminghistorian.org/en/lessons/shiny-leaflet-newspaper-map-tutorial)). The approach taken by this lesson can be applied to a wide range of digital humanities projects where there is a need to retrieve data from a publicly available source, process and analyze the data, and visualize the research outputs in an interactive manner. In addition, this lesson also shows how to deploy the RQ1 dashboard via a free (freemium) web service, which helps to make similar dashboards widely and easily accessible.

# Lesson Goals
In this lesson you will learn how to use Python to:
  * Retrieve data using an [Application Programming Interface (API)](https://en.wikipedia.org/wiki/API)
  * Create the dashboard frontend that determines how it looks
  * Create the dashboard backend that determines how users interact with it
  * Deploy the dashboard onto the web for free

Other essential steps such as installing necessary libraries, setting up a [virtual environment](https://docs.python.org/3/library/venv.html#venv-def), and manipulating the downloaded data will be included when appropriate as well. The code to be executed in the command line will start with the symbol `$`.

## Research Question 1
The first research question (RQ1) in this lesson concerns how U.S. television stations have covered the current war between Russian and Ukraine. One way to approach RQ1 is to compare whether the stations have mentioned the keywords related to Ukraine as frequently as the keywords related to Russia. Further, we can also compare the coverage frequency among some major stations. 

Quantitative methods for content analysis (CA) have long been a tradition in mass communication studies, and the method of algorithmic text analysis (ATA) has become popular given the rising availability of large amounts of textual data.[^1] Both methods aim to infer meanings from text through classification or measurement. Whereas CA relies heavily on a carefully crafted codebook based on research questions and multiple human coders to ensure the reliability and validity of a systematic analysis,[^2] [^3] ATA relies on algorithms and models (a more general term for this method is [text mining](https://en.wikipedia.org/wiki/Text_mining) or [natural language processing](https://en.wikipedia.org/wiki/Natural_language_processing)).[^4] 

The approach to address RQ1 in this lesson situates somewhere in between CA and ATA. On the one hand, this approach only conducts a distant reading, relying less on human coders often required in CA. On the other hand, this approach only measures the manifest features of text (i.e., frequency) and does not involve the types of algorithmic classification that is often seen in ATA. This approach of distant reading aims to discover patterns from large amount of data.[^5] 

### Dataset for RQ1
To answer RQ1, this lesson uses a free and open database from the Internet Archive's [Television Explorer](https://blog.archive.org/2016/12/20/new-research-tool-for-visualizing-two-million-hours-of-television-news/). This database tracks the amount of airtime television stations give to certain keywords, with a resolution of 15 seconds. The keyword searches are based on the text of closed captioning. The data-retrieval tool is the [2.0 TV API](https://blog.gdeltproject.org/gdelt-2-0-television-api-debuts/) made available by the Global Database of Events, Language and Tone (GDELT).

Our goal is to retrieve the relevant data for RQ1 via the 2.0 TV API. Regarding keyword, some appropriate Ukraine-related terms can include "Ukrainian" and "Zelenskyy," and the Russia-related terms can include "Russian" and "Putin." With the 2.0 TV API, we also specify the TV geographic market to be "National;" the output mode is the normalized percentage of airtime (the y-axis of the line graph that we will create later); and the time range covers the last 365 days, including today. After data retrieval, we will prepare a dataset like this for visualization:

{% include figure.html filename="en-or-interactive-data-visualization-dashboard-03.png" alt="A screenshot showing what the RQ1 dataset looks like. There are three columns: date collected, Series, and Value." caption="Screenshot of the RQ1 dataset." %}

In Figure 3, the Value column represents the daily percentage of airtime that mentions certain keywords for a given station (e.g., "CNN"). This dataset is the one that the dashboard will be based on.

## Research Question 2
The second research question (RQ2) asks: How has the ranking of top non-English languages of American newspapers changed from the 1690s to the present? Specifically, the dashboard will be designed to show the top ten languages for each decade dating back to the 1690s, highlighting any shifts in their rankings and the emergence or decline of different languages over time. 

Whereas non-English Native American newspapers serve as a crucial medium for preserving cultural values, educating about Euro-American society, and negotiating tribal sovereignty,[^6] [^7] non-English immigrant newspapers help newcomers track the latest events in their home countries, provide ways to learn about the new country, and facilitates transition.[^8] 

Answering RQ2 helps further investigation into the history of Native Americans, immigration history, the sociolinguistics and ideological landscapes in the U.S.,[^9] and various functions of ethnic media.[^10] 

### Dataset for RQ2
To answer RQ2, this lesson relies on a publicly available dataset from [the Chronicling America project](https://chroniclingamerica.loc.gov/). Specifically, the data comse from [the U.S. Newspaper Directory, 1690-Present](https://chroniclingamerica.loc.gov/search/titles/). This dataset tracks the metadata of historic American newspapers including the language of a newspaper. 

The data-retrieval tool is [Chronicling America's API](https://chroniclingamerica.loc.gov/about/api/). Just like RQ1, we can use the API to retrieve the needed data and prepare it for visualization in a tabular structure like this:

{% include figure.html filename="en-or-interactive-data-visualization-dashboard-04.png" alt="A screenshot showing what the RQ2 dataset looks like. The rows represent languages, the columns represent decades, and the cells represent count of newspapers." caption="Screenshot of the RQ2 dataset." %}

In Figure 4, the rows represent languages, the columns represent decades (from the 1690s to the 2020s), and the cells represent counts of newspaper. 

We can use the cell values to calculate the percentage for a given newspaper language in a certain decade. The percentage is calculated by dividing the number of newspapers for a given language in a certain decade by the total number of non-English newspapers in that decade, and then multiplying by 100. This gives the proportion of newspapers for that language relative to all non-English newspapers in the same decade. 

Then, we can visualize what the top 10 non-English newspapers are in a certain decade.

## Why Dash in Python?
Several alternative tools to create interactive dashboards are well discussed in [this lesson on Shiny in R](https://programminghistorian.org/en/lessons/shiny-leaflet-newspaper-map-tutorial).[^12] The case for Python is that it is a widely used programming language. Python is flexible and powerful to process a dataset in its full life cycle (i.e., from data collection, to data analysis, and to data visualization). 

If you are using Python, Dash is a good option, as it is developed by [plotly](https://plotly.com/), the go-to tool for data visualization in various programming languages including Python, R, and JavaScript. This makes the workflow of publishing an interactive visualization more efficient. 

As an alernative, you could use both plotly and [Flask](https://flask.palletsprojects.com) (the web application framework underlying Dash) directly, but this requires deep knowledge of JavaScript and HTML. If you want to focus on data visualization rather than the technical details of web development, Dash is highly recommended.

# Prepare for the Lesson

In this lesson, you will write code in a `.py` file stored in a folder on your local machine. You will then run this `.py` file in the command line to test your application. Lastly, you will need to use GitHub to deploy your application.

## Prerequisites
  * Python 3 (3.7.13 or later). See [Mac Installation](https://programminghistorian.org/lessons/mac-installation), [Windows Installation](https://programminghistorian.org/lessons/windows-installation), or [Linux Installation](https://programminghistorian.org/lessons/linux-installation)
  * Command line. For introductions, see [Windows here](https://programminghistorian.org/en/lessons/intro-to-powershell) and [macOS/Linux here](https://programminghistorian.org/en/lessons/intro-to-bash)
  * A text editor (e.g., [Atom](https://atom.io/), [Notepad++](https://notepad-plus-plus.org/), [Visual Studio Code](https://code.visualstudio.com/)) to write Python code
  * A web browser
  * A [GitHub](https://github.com) account
  * Have [git](https://git-scm.com/doc) ready to use in command line. You could also use either of the following (not covered in this lesson):
    * [GitHub Desktop](https://desktop.github.com/)
    * [GitHub CLI](https://cli.github.com/)
    * [GitHub Codespaces](https://github.com/features/codespaces) ([costs may be incurred after you exceed the free quota](https://docs.github.com/en/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces))

Optional: [Jupyter Notebook](https://jupyter.org/). If you prefer to run the code example for RQ1 in Jupyter Notebook, you'll need to install it (see [this lesson for instructions](https://programminghistorian.org/en/lessons/jupyter-notebooks#installing-jupyter-notebooks)).

## Create a Virtual Environment
To avoid conflicts in library versions among multiple Python projects, it is a good practice to create a virtual environment for each project.[^11] 

There are several ways to create a virtual environment. One way is to use `conda` ([see this lesson for more details](https://programminghistorian.org/en/lessons/visualizing-with-bokeh#prerequisites)). This is a good option if you are already using [Anaconda](https://docs.conda.io/projects/conda/en/latest/glossary.html?highlight=anaconda#anaconda) for more data-science-oriented projects. Assuming that you are starting fresh, it would be more appropriate to go for a more lightweight method by using [virtualenv](https://virtualenv.pypa.io/en/latest/). To install, open a command line window and run `$pip install virtualenv`.

Next, create a folder at your preferred location for the current lesson and name it *ph-dash*. In your command line, navigate to the *ph-dash* directory. To create a virtual environment called *venv*, run `$virtualenv venv`. Then, you need to activate the virtual environment by running:

```
$venv\Scripts\activate # For Windows
$source venv/bin/activate # For macOS/Linux
```

If properly executed, you will see a pair of parentheses around *venv*, the name of the created virtual environment, at the start of the current line in your command line window. 

Now, you are in an isolated development environment with a specific version of Python and a specific list of libraries with their specific versions. When you are done writing code for a project, to exit the virtual environment, just run `$deactivate`.

## Install Libraries
Once a virtual environment is set up, you are ready to install several third-party libraries needed for the current lesson. With the virtual environment still in the activated mode, run `$pip install requests pandas dash dash_bootstrap_components`.

  * [requests](https://requests.readthedocs.io/en/latest/): Used in data retrieval for sending and receiving API queries
  * [pandas](https://pandas.pydata.org/docs/index.html): Used in data preparation for manipulating data in tabular forms
  * [dash](https://dash.plotly.com/introduction): Used for creating dashboards
  * [dash_bootstrap_components](https://dash-bootstrap-components.opensource.faculty.ai/): Used for frontend templates for dashboards

Alternatively, you can also download the file called `requirements.txt` from [here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/interactive-data-visualization-dashboard/requirements.txt) to the same folder and run `$pip install -r requirements.txt`. This will also install the required packages.
 
# Coding the Dashboards

The next section will walk you through the major steps in coding for RQ1. If you want to execute the code blocks as you follow along, I have provided [the Jupyter Notebook version of the code here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/interactive-data-visualization-dashboard/interactive-data-visualization-dashboard.ipynb). 

For RQ2, because the coding logic is highly similar to RQ1, the lesson will provide the complete code but will not give a detailed explanation, considering the space limit. 

# RQ1 - TV Airtime

To address RQ1, we can envision a dashboard where there are two line graphs, one showing the trend of Russia-related terms and the other for the trend of Ukraine-related terms mentioned by television networks. 

More specifically, in either of the line graph, the y-axis represents the percentage of airtime mentioning certain keywords by a certain national station, and the x-axis represents dates. 

In addition, there are multiple lines, each representing one television network. A basic interactive component is a date-range selector where users can specify a range of dates, and the line graphs will be updated upon selection.

## Import Libraries

[EXPLAIN code with commentary. Why these libraries?]

```
import datetime
import requests
import pandas as pd
from io import StringIO
from datetime import date
import dash
from dash import dcc
from dash import html
from dash.dependencies import Input, Output
import dash_bootstrap_components as dbc
import plotly.express as px
```

## Retrieve Data Using API

We can first define a range of dates for the complete dataset to be retrieved using the API. The goal here is to create two string objects: `today_str` and `start_day_str`. 

```
today = date.today()
today_str = today.strftime("%Y%m%d")
start_day = today - datetime.timedelta(365)
start_day_str = start_day.strftime("%Y%m%d")
```

Here we restrict the range to be 365 days for demonstration purpose only.

```
query_url_ukr = f"https://api.gdeltproject.org/api/v2/tv/tv?query=(ukraine%20OR%20ukrainian%20OR%20zelenskyy%20OR%20zelensky%20OR%20kiev%20OR%20kyiv)%20market:%22National%22&mode=timelinevol&format=html&datanorm=perc&format=csv&timelinesmooth=5&datacomb=sep&timezoom=yes&STARTDATETIME={start_day_str}120000&ENDDATETIME={today_str}120000"
```

```
query_url_rus = f"https://api.gdeltproject.org/api/v2/tv/tv?query=(kremlin%20OR%20russia%20OR%20putin%20OR%20moscow%20OR%20russian)%20market:%22National%22&mode=timelinevol&format=html&datanorm=perc&format=csv&timelinesmooth=5&datacomb=sep&timezoom=yes&STARTDATETIME={start_day_str}120000&ENDDATETIME={today_str}120000"
```

Two string objects are created for query: one for Ukraine-related terms and one for Russia-related terms. The parameters to be specified include keywords, geographic market, output mode, output format, range of dates, etc. 

For the purpose of this lesson, the Ukraine-related keywords are "Ukraine," "Ukrainian," "Zelenskyy," "Kyiv," or "Kiev;" the Russia-related keywords are "Russia," "Russian," "Putin," "Kremlin," or "Moscow;" the geographic market is "National;" the output mode is the normalized percentage of airtime (the y-axis of the line graph that we will create later); the output format is set to [CSV (comma-separated values)](https://en.wikipedia.org/wiki/Comma-separated_values); the start date and the end date are specified with the corresponding object names (`start_day_str` and `today_str`). 

See [this documentation](https://blog.gdeltproject.org/gdelt-2-0-television-api-debuts/) for a complete description of query parameters. The encoding characters `%20` and `%22` represent space and double quotation mark ("), respectively.

Next, once we have the data retrieved, we need to prepare the data in a way that is ready for visualization. Our goal is to transform the data into the shape shown in Figure 3, above.

```
def to_df(queryurl):
  response = requests.get(queryurl)
  content_text = StringIO(response.content.decode('utf-8'))
  df = pd.read_csv(content_text)
  return df
```
The `requests` library is used to execute the queries and transform the results into a `pandas` dataframe. To do this, we create a function called `to_df()` to streamline the workflow.

Once we have the function created, we can now put it to work:

```
df_ukr = to_df(query_url_ukr)
df_rus = to_df(query_url_rus)
```

Optional: You can use the `df.head()` function to take a look at the first five rows of the output dataframe from the above action. 

```
# If in Jupyter: Take a look at the first five rows of the retrieved dataframe for Ukraine 
df_ukr.head()

# If you execute a .py file, add the print() function to see the first five rows
print(df_ukr.head())
```

You can also use the shape() function to see how many columns and rows there are in the dataframe. Give it a try!

Now there are two dataframes: one for Ukraine and one for Russia. In either, there are three columns: date, station, and relative frequency of keyword mentions (from left to right).

## Clean Data for Further Use
[EXPLAIN code with commentary before and after]
 
```
# Rename the first column to something shorter for convenience
df_ukr = df_ukr.rename(columns={df_ukr.columns[0]: "date_col"})
df_rus = df_rus.rename(columns={df_rus.columns[0]: "date_col"})
```

```
# Transform the first column to the datetime format
df_ukr['date_col'] = pd.to_datetime(df_ukr['date_col'])
df_rus['date_col'] = pd.to_datetime(df_rus['date_col'])
```

```
# Select three stations for comparison
# CNN: Presumed to represent an ideological middle ground
# FOXNEWS: Presumed to represent the ideological conservative
# MSNBC: Presumed to represent the ideological liberal
df_rus = df_rus[[x in ['CNN', 'FOXNEWS', 'MSNBC'] for x in df_rus.Series]]
df_ukr = df_ukr[[x in ['CNN', 'FOXNEWS', 'MSNBC'] for x in df_ukr.Series]]
```

## Initiate a Dashboard Instance

This is just the formalities of creating a dashboard. To use a template that controls how our dashboard will look, we use the LITERA theme from [Dash Bootstrap Components](https://dash-bootstrap-components.opensource.faculty.ai/) (`dbc`). 

```
app = dash.Dash(__name__, external_stylesheets=[dbc.themes.LITERA])
server = app.server
```

You can choose any theme you prefer from [this list](https://dash-bootstrap-components.opensource.faculty.ai/docs/themes/).  

### Coding the Frontend

```
app.layout = dbc.Container(
    [   dbc.Row([ # row 1
        dbc.Col([html.H1('US National Television News Coverage of the War in Ukraine')],
        className="text-center mt-3 mb-1")
    ]
    ),
        dbc.Row([ # row 2
            dbc.Label("Select a date range:", className="fw-bold")
    ]),
    
     dbc.Row([ # row 3
              dcc.DatePickerRange(
                id='date-range',
                min_date_allowed=df_ukr['date_col'].min().date(),
                max_date_allowed=df_ukr['date_col'].max().date(),
                initial_visible_month=df_ukr['date_col'].min().date(),
                start_date=df_ukr['date_col'].min().date(),
                end_date=df_ukr['date_col'].max().date()
              )
    ]),

     dbc.Row([ # row 4
              dbc.Col(dcc.Graph(id='line-graph-ukr'), 
                      )
     ]),

    dbc.Row([ # row 5
              dbc.Col(dcc.Graph(id='line-graph-rus'), 
                      )
     ])

    ])
```

Here, you need to think about the dashboard layout as a grid with rows and columns. In our dashboard, we have five rows from top to bottom: title, instruction text for the date-range selector, data-range selector, the first line graph, and the second line graph. 

If you want to add columns within a row, you can easily do so by nesting two `dbc.Col` components under the same `dbc.Row` component. Below is an example of placing the two line graphs side by side on the same row:


```
dbc.Row([
          dbc.Col(dcc.Graph(id='line-graph-ukr'), 
                  ),
          dbc.Col(dcc.Graph(id='line-graph-rus'), 
                  )
  ])
```

Also important to note in the frontend code above is that you explicitly give names to those components that are involved in user interaction. In our case, we have three such components: the data-range selector as input and the two line graphs as output (i.e., reacting to any update in the date-range selector triggered by a user). The names of these components are created using the `id` parameter. These names are very important when you code the backend later.

### Coding the Backend

In the backend, the core concepts are *callback decorator* and *callback function*. 

In the following code, `@app.callback`, the callback decorator, defines which output variables and input variables are included in a user interaction. For example, remember that when you code the frontend, you name the line graph for Ukraine as 'line-graph-ukr'. Now you refer this name in one of the Output variables. The parameter 'figure' specifies which property of the referred component is updated when needed.

```
# callback decorator
@app.callback(
    Output('line-graph-ukr', 'figure'),
    Output('line-graph-rus', 'figure'),
    Input('date-range', 'start_date'),
    Input('date-range', 'end_date')   
)

# callback function
def update_output(start_date, end_date):
    # filter dataframes based on updated data range
    mask_ukr = (df_ukr['date_col'] >= start_date) & (df_ukr['date_col'] <= end_date)
    mask_rus = (df_rus['date_col'] >= start_date) & (df_rus['date_col'] <= end_date)
    df_ukr_filtered = df_ukr.loc[mask_ukr]
    df_rus_filtered = df_rus.loc[mask_rus]
    
    # create line graphs based on filtered dataframes
    line_fig_ukr = px.line(df_ukr_filtered, x="date_col", y="Value", 
                     color='Series', title="Coverage of Ukrainian Keywords")
    line_fig_rus = px.line(df_rus_filtered, x='date_col', y='Value', 
                     color='Series', title="Coverage of Russian Keywords")

    # set x-axis title and y-axis title in line graphs 
    line_fig_ukr.update_layout(
                   xaxis_title='Date',
                   yaxis_title='Percentage of Airtime')
    line_fig_rus.update_layout(
                   xaxis_title='Date',
                   yaxis_title='Percentage of Airtime')
    
    # set label format on y-axis in line graphs 
    line_fig_ukr.update_xaxes(tickformat="%b %d<br>%Y")
    line_fig_rus.update_xaxes(tickformat="%b %d<br>%Y")
    
    return line_fig_ukr, line_fig_rus
```

The callback function, `update_output()`, defines how the interaction occurs: The two line graphs are updated whenever the start date or the end date in the date-range selector is changed by a user. This is called *reactive programming*, similar to [the server logic used in R Shiny](https://programminghistorian.org/en/lessons/shiny-leaflet-newspaper-map-tutorial#shiny-and-reactive-programming). The callback functions determine the dynamic nature of the created dashboard. More detailed explanations are provided as comments in the above code. Note that the two returned objects (`line_fig_ukr` and `line_fig_rus`) should be ordered in the same way as how the output variables are ordered in the callback decorator (i.e., Ukraine's line graph goes first).

### Testing the Dashboard

Now you can add the following line to actually see and test the created dashboard.

```
app.run_server(debug=True)
```

It is recommended to turn on the debug mode so that any errors can be looked into when needed.

You need to put all the code you have written so far into a single `.py` file and name it such as `app.py`. The complete code [is provided here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/interactive-data-visualization-dashboard/app.py) for convenience. 

In the command line, execute `$python app.py`. Then, a server address will appear, and you will need to copy and paste this address into a web browser to launch the dashboard. Do not close the command line program when the server is running. 

When you are done, in the command line, press `ctrl`+`c` on keyboard to stop the server. 

In a Jupyter Notebook, you can also choose to review the dashboard as a cell output (again, please refer to [the notebook version of the code](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/interactive-data-visualization-dashboard/interactive-data-visualization-dashboard.ipynb)). 

{% include figure.html filename="en-or-interactive-data-visualization-dashboard-01.png" alt="A screenshot showing what the RQ1 dashboard looks like. There are two line graphs: one shows how media attention to Ukraine-related words in TV stations changes over time; the other shows the same but for Russia-related words" caption="Screenshot of the RQ1 dashboard." %}

### Deploying the Dashboard
After the dashboard code is ready, in most cases, it is desirable to share your dashboards with the public using a URL. This means that you need to deploy your dashboard as a web application. In this section, you will achieve this goal by using a free service that allows us to host a dynamic web application: the free-tier web service provided by [Render](https://render.com/docs/web-services). In Render's free plan, the [RAM](https://en.wikipedia.org/wiki/Random-access_memory) limit is 512 MB at the time of writing. Our demo app takes about 90 MB, so the allocated RAM should be sufficient.[^13]

## Setting up in GitHub
You will need to upload the code folder, `ph-dash`, as a repository onto GitHub. This can be done in command line or in GitHub Desktop (see [this lesson if you are new to Git or GitHub](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#github--github-pages-)).

Then, install one more library for deployment: `$pip install gunicorn`. This library, [`gunicorn`](https://gunicorn.org/), is needed when Render sets up a web server for you.

In the repository, you need two essential files: A `.py` file that contains all of your Python code, and a file called `requirements.txt` that lists all the required Python libraries for the dashboard. Later, Render will read this file to install the needed Python libraries when you deploy the app. You can easily create this requirements file in command line using `$pip freeze > requirements.txt`. I have [provided a sample repository in this link for your reference](https://github.com/hluling/ph-dash).

### Setting up in Render
You can sign up for free using an email address. Then, navigate to the appropriate place to create a new "Web Service." If your GitHub repository is public, you can copy and paste the HTTPS address of the repository into the address of "Public Git Repository." Otherwise, you can also link your GitHub account with Render so that Render has access to your private repository.

Then, you will enter several pieces of information on the next screen. In addition to giving your dashboard a name, you need to configure two more settings (assuming all the populated default settings are correct). First, in "Start Command," change the input to `gunicorn app:server`. That is, the name after the colon must be the same as the object name of the server you set in your Python script. The name before the colon must be the same as the `.py` file in the repository.

Second, scroll down and find the section called "Environment Variables." Click "Add Environment Variable" and input `PYTHON_VERSION` as the key and the Python version that you use on your machine as the value (use `$python -V` in command line to check your Python version). If you don't explicitly specify the Python version this way, Render will use Python 3.7 as default, which may cause conflicts between this old Python version and the libraries' versions specified in `requirements.txt`.

The last step is to "Create Web Service" and wait for several minutes for the application to be built. When finished, you can see your dashboard via a URL like this: https://ph-dash-demo.onrender.com/

# RQ2 - Non-English American Newspapers
For RQ2, let's create two pie charts side by side. The pie chart will show the top 10 non-English languages in percentage. Both charts will allow users to specify a decade, so the results from any two decades can be compared.

Regarding workflow, the following steps will be the same as described above: the same prerequisites will be needed; follow the same steps to create a new virtual environment; the same Python libraries will be needed; and you can follow the same steps to deploy the RQ2 dashboard on Render. The data downloading procedure and the specific code used for the RQ2 dashboard will be different from RQ1. However, the underlying logic is the same: We start with data retrieval, prepare the data for visualization, code the dashboard frontend, then code the dashboard backend. I will briefly describe these in the next two sections.

## Download Data

Because the download can take a long time, for the purpose of this lesson, it may be more helpful to focus on the dashboard-coding part directly. Thus, I provide the downloaded data in CSV [here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/interactive-data-visualization-dashboard/data_lang_asrow.csv). Feel free to download this dataset directly and move on to the next section.[^14]

## Coding the Dashboard

The dashboard has two pie charts placed side by side, each of which has a dropdown menu for selecting decades. Both charts show the top-10 non-English languages in percentage. [The script for coding the dashboard can be found here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/interactive-data-visualization-dashboard/app-rq2.py). If you have downloaded the data in CSV (see the previous section, above), you can run the script (`app-rq2.py`) directly without retrieving the data from Chronicling America.

{% include figure.html filename="en-or-interactive-data-visualization-dashboard-02.png" alt="A screenshot showing what the RQ2 dashboard looks like. There are two pie graphs: one shows the top 10 non-English newspapers in the U.S. in the 1690s; the other shows the same but for 2020s" caption="Screenshot of the RQ2 dashboard. Each chart shows the top-10 non-English newspapers in a given decade. The percentage is the count of newspaper titles in a given non-English language divided by the sum of non-English newspaper titles." %}

# Conclusion
Interactive visualization contributes to digital humanities by facilitating knowledge discovery and making the research output more accessible to the public. In this lesson, the key steps of creating and deploying an interactive dashboard using an open-source tool, Dash in Python, are demonstrated with an example in media studies. Like [Shiny in R](https://doi.org/10.46430/phen0105), this is an approach that can be applied in a wide range of applications in digital humanities.

[^1]: Stephen Lacy et al., “Issues and Best Practices in Content Analysis,” *Journalism &amp; Mass Communication Quarterly* 92, no. 4 (September 28, 2015): 791–802, https://doi.org/10.1177/1077699015607338.

[^2]: Matthew Lombard, Jennifer Snyder‐Duch, and Cheryl Campanella Bracken. "Content Analysis in Mass Communication: Assessment and Reporting of Intercoder Reliability," *Human Communication Research* 28, no. 4 (2002): 587-604, https://doi.org/10.1111/j.1468-2958.2002.tb00826.x.

[^3]: Kimberly A. Neuendorf, *The Content Analysis Guidebook* (Thousand Oaks: Sage, 2017).

[^4]: Gross, Justin, and Dana Nestor. "Algorithmic Text Analysis: Toward More Careful Consideration of Qualitative Distinctions," in *Oxford Handbook of Engaged Methodological Pluralism in Political Science*, eds. Janet M. Box-Steffensmeier, Dino P. Christenson, and Valeria Sinclair-Chapman (Oxford Academic, 2023).

[^5]: André Baltz, “What’s so Social about Facebook? Distant Reading of Swedish Local Government Facebook Pages, 2010-2017,” *International Journal of Strategic Communication* 17, no. 2 (February 15, 2023): 118, https://doi.org/10.1080/1553118x.2022.2144324.

[^6]: Sharon Murphy, “Neglected Pioneers: 19th Century Native American Newspapers,” *Journalism History* 4, no. 3 (1977): 79, https://doi.org/10.1080/00947679.1977.12066850.

[^7]: Patty Loew and Kelly Mella, “Black Ink and the New Red Power: Native American Newspapers and Tribal Sovereignty,” *Journalism & Communication Monographs* 7, no. 3 (2005): 101, https://doi.org/10.1080/00947679.1977.12066850.

[^8]: Hermann W. Haller, “Ethnic-Language Mass Media and Language Loyalty in the United States Today: The Case of French, German and Italian,” *WORD* 39, no. 3 (December 1988): 187, https://doi.org/10.1080/00437956.1988.11435789.

[^9]: Andrew Hartman, “Language as Oppression: The English‐only Movement in the United States,” *Socialism and Democracy* 17, no. 1 (January 2003): 187–208, https://doi.org/10.1080/08854300308428349.

[^10]: K. Viswanath and Pamela Arora, “Ethnic Media in the United States: An Essay on Their Role in Integration, Assimilation, and Social Control,” *Mass Communication and Society* 3, no. 1 (February 2000): 39–56, https://doi.org/10.1207/s15327825mcs0301_03.

[^11]: A virtual environment in Python is a self-contained directory that contains a specific version of Python and a set of libraries. It allows you to manage dependencies for different projects separately, ensuring that changes in one project do not affect others. This is especially useful for maintaining consistent development environments and avoiding conflicts between package versions.

[^12]: An additional option is [ArcGIS](https://www.arcgis.com/index.html).

[^13]: If you need more computing power and greater RAM, especially for a heavily used web application that is based on a large dataset, you may need to pay Render a certain fee. At the time of writing, other options that can be used to host dynamic web applications (instead of static sites) include [PythonAnywhere](https://www.pythonanywhere.com/), [Dash Enterprise](https://dash.plotly.com/dash-enterprise), [Heroku](https://devcenter.heroku.com/), [Amazon Web Services](https://aws.amazon.com/), and [Google App Engine](https://cloud.google.com/appengine). If you want to host your own server, or you have someone at your institution who can help you set up a dedicated server, the general approach to take is to find ways to deploy Flask apps (e.g., via [Apache2](https://ubuntu.com/server/docs/web-servers-apache)).

[^14]: If you wonder how to download the data for RQ2, I have provided [the script here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/interactive-data-visualization-dashboard/rq2-download.py). The key step is to retry a query if there is an error returned by the server. This is probably due to the restriction that Chronicling America sets on how many requests in a given period can be sent to the server for downloads. No matter what your data demand is, always follow the rule set by the server and respect other users.
