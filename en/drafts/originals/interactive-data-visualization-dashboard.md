---
title: "Creating a Dashboard for Interactive Data Visualization with Dash in Python"
slug: interactive-data-visualization-dashboard
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Luling Huang
reviewers:
- Forename Surname
- Forename Surname
editors:
- Caio Mello
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/609
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

To advance open scholarship in humanities, it is important to make the research output more accessible to other scholars and the general public. It would be beneficial for scholars to explore ways to better engage with a broader audience. Creating a web-based interactive dashboard to visualize data and results has become a popular method nowadays to achieve this goal (e.g., [a project that tracks social media data](https://portal.research.lu.se/en/publications/stancexplore-visualization-for-the-interactive-exploration-of-sta), [a study that recreates W. E. B. Du Bois' study of black residents in Philadelphia](http://digitalhumanities.org/dhq/vol/16/2/000609/000609.html), and [a project that visualizes the narrative structure in William Faulkner's work](http://digitalhumanities.org/dhq/vol/15/2/000548/000548.html)). The current lesson will walk you through the process of creating an interactive dashboard based on a publicly available dataset using the open-source [Dash library in Python](https://dash.plotly.com/introduction). For demonstration, this lesson is guided by two sample research questions in the field of media and communication studies. The first research question asks: How do the U.S. television stations cover the war in Ukraine? The dataset used for the first research question is a publicly available dataset of transcription texts of television news. The second research question asks: How have the top non-English languages of newspaper changed in the history of United States dating back to the 1690s? The dataset used for the second research question is another publicly available dataset of newspaper directories.

This lesson contributes to the existing Programming Historian lessons by adding a tutorial focused on creating an interactive web-based dashboard in Python ([see a similar English lesson focused on using Shiny in R](https://programminghistorian.org/en/lessons/shiny-leaflet-newspaper-map-tutorial)). The approach taken by this lesson can be applied to a wide range of digital humanities projects where there is a need to retrieve data from a publicly available source, process and analyze the data, and visualize the research outputs in an engaging way.

## Lesson Goals
You will learn how to use Python to:
  * Retrieve latest data using [Application Programming Interface (API)](https://en.wikipedia.org/wiki/API)
  * Create the frontend of dashboard that determines how it looks
  * Create the backend of dashboard that determines how users interact with it
  * Deploy dashboard onto the web using a free service

Other essential steps such as installing necessary libraries, setting up a [virtual environment](https://docs.python.org/3/library/venv.html#venv-def), and manipulating the downloaded data will be included when appropriate as well. Code to be executed in command line will start with the symbol `$`.

## Research Question 1
The first research question (RQ1) in this lesson concerns whether the U.S. television stations have covered the war in Ukraine in a balance way. One way to address this research question is to compare whether the stations have mentioned the keywords related to Ukraine as frequently as the keywords related to Russia. Further, we can also compare the coverage frequency among some major stations. The quantitative method of content analysis (CA) has long been a tradition in mass communication studies, and the method of algorithmic text analysis (ATA) has become popular given the recent availability of large amount of textual data.[^1] The way I approach the first research question situates somewhere in between CA and ATA. On one hand, this approach only conducts a distant reading that relies less on human coders often required in CA; on another, this approach only measures the manifest features of text (i.e., frequency) and does not involve any algorithmic classification or labeling that is often seen in ATA. This approach of distant reading aims to discover patterns from large amount of data.[^2] 

## Dataset for RQ1
To answer RQ1, this lesson uses a free and open dataset from the Internet Archive's [Television Explorer](https://blog.archive.org/2016/12/20/new-research-tool-for-visualizing-two-million-hours-of-television-news/). This dataset tracks how much airtime of news coverage television stations include certain keywords at the resolution of 15 seconds. The keyword searches are based on the text of closed captioning. The data-retrieval tool is the [2.0 TV API](https://blog.gdeltproject.org/gdelt-2-0-television-api-debuts/) made available by the Global Database of Events, Language and Tone (GDELT).

## Research Question 2
The second research question (RQ2) asks: How have the top non-English languages of newspaper changed in the history of United States dating back to the 1690s? Non-English ethnic newspapers help immigrants track the latest events in the home country, provide more ways immigrants can learn more about the new country, and facilitates transition.[^3] Answering RQ2 helps further investigation into immigration history, the sociolinguistics and ideological landscapes in the U.S.,[^4] and various functions of ethnic media.[^5] 

## Dataset for RQ2
To answer RQ2, this lesson relies on a publicly available dataset from [the Chronicling America project](https://chroniclingamerica.loc.gov/). Specifically, the data come from [the U.S. Newspaper Directory, 1690-Present](https://chroniclingamerica.loc.gov/search/titles/). This dataset tracks the metadata of historic American newspapers including the language of a newspaper. The data-retrieval tool is [Chronicling America's API](https://chroniclingamerica.loc.gov/about/api/).

## Why Dash in Python?
Several alternative tools to create interacitve dashboards are well discussed in [this lesson on Shiny in R](https://programminghistorian.org/en/lessons/shiny-leaflet-newspaper-map-tutorial).[^6] The case for Python is that it is a widely used programming language. Python is flexible and powerful to use in a full data life cycle (i.e., from data collection, to data analysis, and to data visualization). The case for Dash is that it is developed by [plotly](https://plotly.com/), the go-to tool for data visualization in various programming languages including Python, R, and JavaScript. This makes the workflow of publishing an interactive visualization more efficient. You could use both plotly and [Flask](https://flask.palletsprojects.com/en/2.2.x/) (the web application framework underlying Dash) directly, but this requires deep knowledge about JavaScript and HTML. If you want to focus on data visualization rather than the technical details of web development, Dash is highly recommended.

## Prepare for the Lesson

In this lesson, you will write code in a `.py` file stored in a folder on your local machine. You will then run this `.py` file in command line to test your application. Lastly, you will need to use GitHub to deploy your application.

### Prerequisites
  * Python 3 (3.7.13 or later). See [Mac Installation](https://programminghistorian.org/lessons/mac-installation), [Windows Installation](https://programminghistorian.org/lessons/windows-installation), or [Linux Installation](https://programminghistorian.org/lessons/linux-installation)
  * Command line. For introductions, see [Windows here](https://programminghistorian.org/en/lessons/intro-to-powershell) and [macOS/Linux here](https://programminghistorian.org/en/lessons/intro-to-bash)
  * A text editor (e.g., [Atom](https://atom.io/), [Notepad++](https://notepad-plus-plus.org/), [Visual Studio Code](https://code.visualstudio.com/)) to write Python code
  * A web browser
  * A [GitHub](https://github.com) account
  * Have [git](https://git-scm.com/doc) ready to use in command line or have [GitHub Desktop](https://desktop.github.com/) installed

Optional: Jupyter Notebook. If you prefer to run the code example in Jupyter Notebook, you'll need to install it (see [this lesson for instructions](https://programminghistorian.org/en/lessons/jupyter-notebooks#installing-jupyter-notebooks)).

### Create a Virtual Environment
To avoid conflicts in library versions among multiple Python projects, it is a common good practice to create a virtual environment for each project. You will do so for this lesson.

There are several ways to create a virtual environment. One way is to use `conda` ([see this lesson for more details](https://programminghistorian.org/en/lessons/visualizing-with-bokeh#prerequisites)). This is a good option if you are already using [Anaconda](https://docs.conda.io/projects/conda/en/latest/glossary.html?highlight=anaconda#anaconda) for more data-science-oriented projects. Assuming that you are starting fresh, it would be more appropriate to go for a more lightweight method by using [virtualenv](https://virtualenv.pypa.io/en/latest/). To install, open a command line window and run `$pip install virtualenv`.

Next, create a folder at your preferred location for the current lesson and name it *ph-dash*. In your command line, navigate to the *ph-dash* directory. To create a virtual environment called *venv*, run `$virtualenv venv`. Then, you need to activate the virtual environment by running:

```
$venv\Scripts\activate # For Windows
$source venv/bin/activate # For macOS/Linux
```

If properly executed, you will see a pair of parentheses around *venv*, the name of the created virtual environment, at the start of the current line in your command line window. Now, you are in an isolated development environment with a specific version of Python and a specific list of libraries with their specific versions. When you are done writing code for a project, to exit the virtual environment, just run `$deactivate`.

### Install Libraries
Once a virtual environment is set up, you are ready to install several third-party libraries needed for the current lesson. With the virtual environment still in the activated mode, run `$pip install requests pandas dash dash_bootstrap_components`.

  * [requests](https://requests.readthedocs.io/en/latest/): Used in data retrieval for sending and receiving API queries
  * [pandas](https://pandas.pydata.org/docs/index.html): Used in data preparation for manipulating data in tabular forms
  * [dash](https://dash.plotly.com/introduction): Used for creating dashboards
  * [dash_bootstrap_components](https://dash-bootstrap-components.opensource.faculty.ai/): Used for frontend templates for dashboards

## An Idea of a Simple Dashboard
To address the research question, we can envision a dashboard where there are two line graphs, one showing the trend of Russia-related terms and the other for the trend of Ukriane-related terms mentioned by television networks. More specifically, in either of the line graph, the y-axis represents the relative frequency of key terms mentioned by a certain national station, and the x-axis represents dates. In addition, there are multiple lines, each representing one television network. A basic interactive component is a date-range selector where users can specify a range of dates, and the line graphs will be updated upon selection.

## Coding the Dashboards

I will walk you through the major steps in coding for RQ1. Below, the code will be shown in blocks, and an explanation will be provided under each block. If you want to execute the code blocks as you follow along, I have provided [the Jupyter Notebook version of the code here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/interactive-data-visualization-dashboard/interactive-data-visualization-dashboard.ipynb).

For RQ2, due to the restriction of the API, I will have two separate scripts: one for downloading data, and one for the dashboard. You can clone [the repository of this lesson](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/interactive-data-visualization-dashboard) to your machine and run the scripts. Also, because the coding logic is highly similar to RQ1, I will provide the complete code but will not give a detailed explanation considering the space limit. 

### RQ1

#### Import Libraries

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

#### Retrieve Data Using API
```
today = date.today()
today_str = today.strftime("%Y%m%d")
start_day = today - datetime.timedelta(365)
start_day_str = start_day.strftime("%Y%m%d")
```
Code explanation: We can first define a range of dates for the complete dataset to be retrieved using the API. The goal here is to create two string objects: `today_str` and `start_day_str`. Here we restrict the range to be 365 days for demonstration purpose only.

```
query_url_ukr = f"https://api.gdeltproject.org/api/v2/tv/tv?query=(ukraine%20OR%20ukrainian%20OR%20zelenskyy%20OR%20zelensky%20OR%20kiev)%20market:%22National%22&mode=timelinevol&format=html&datanorm=perc&format=csv&timelinesmooth=5&datacomb=sep&timezoom=yes&STARTDATETIME={start_day_str}120000&ENDDATETIME={today_str}120000"
```

```
query_url_rus = f"https://api.gdeltproject.org/api/v2/tv/tv?query=(kremlin%20OR%20russia%20OR%20putin%20OR%20moscow%20OR%20russian)%20market:%22National%22&mode=timelinevol&format=html&datanorm=perc&format=csv&timelinesmooth=5&datacomb=sep&timezoom=yes&STARTDATETIME={start_day_str}120000&ENDDATETIME={today_str}120000"
```

Code explanation: Two string objects are created for query: one for Ukraine-related terms and one for Russia-related terms. The parameters to be specified include keywords, geographic market, output mode, output format, range of dates, etc. See [this documentation](https://blog.gdeltproject.org/gdelt-2-0-television-api-debuts/) for a complete description of query parameters. The encoding characters `%20` and `%22` represent space and double quotation mark ("), respectively.

```
def to_df(queryurl):
  response = requests.get(queryurl)
  content_text = StringIO(response.content.decode('utf-8'))
  df = pd.read_csv(content_text)
  return df
```
Code explanation: The `requests` library is used to execute the queries and transform the results into a `pandas` dataframe. To do this, we create a function called `to_df()` to streamline the workflow.

```
df_ukr = to_df(query_url_ukr)
df_rus = to_df(query_url_rus)
```

```
# Take a look at the retrieved dataframe
df_ukr.head()
```

Now there are two dataframes: one for Ukraine and one for Russia. In either, there are three columns: date, station, and relative frequency of keyword mentions (from left to right).


#### Clean Data for Further Use


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


#### Initiate a Dashboard Instance


```
app = dash.Dash(__name__, external_stylesheets=[dbc.themes.LITERA])
server = app.server
```

Code explanation: This is just the formalities of creating a dashboard. To use a template that controls how our dashboard will look, we use the LITERA theme from [Dash Bootstrap Components](https://dash-bootstrap-components.opensource.faculty.ai/) (`dbc`). You can choose any theme you prefer from [this list](https://dash-bootstrap-components.opensource.faculty.ai/docs/themes/).  

#### Coding the Frontend

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

Code explanation: Here, you need to think about the dashboard layout as a grid with rows and columns. In our dashboard, we have five rows from top to bottom: title, instruction text for the date-range selector, data-range selector, the first line graph, and the second line graph. If you want to add columns within a row, you can easily do so by nesting two `dbc.Col` components under the same `dbc.Row` component. Below is an example of placing the two line graphs side by side on the same row:


```
dbc.Row([
          dbc.Col(dcc.Graph(id='line-graph-ukr'), 
                  ),
          dbc.Col(dcc.Graph(id='line-graph-rus'), 
                  )
  ])
```

Also important to note in the frontend code above is that you explicitly give names to those components that are involved in user interaction. In our case, we have three such components: the data-range selector as input and the two line graphs as output (i.e., reacting to any update in the date-range selector triggered by a user). The names of these components are created using the `id` parameter. These names are very important when you code the backend later.

#### Coding the Backend
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
                     color='Series', title="Coverage of Ukranian Keywords")
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

Code explanation: In the backend, the core concepts are *callback decorator* and *callback function*. In the above code, `@app.callback`, the callback decorator, defines which output variables and input variables are included in a user interaction. For example, remember that when you code the frontend, you name the line graph for Ukraine as 'line-graph-ukr'. Now you refer this name in one of the Output variables. The parameter 'figure' specifies which property of the referred component is updated when needed.

The callback function, `update_output()`, defines how the interaction occurs: The two line graphs are updated whenever the start date or the end date in the date-range selector is changed by a user. This is called *reactive programming*, similar to [the server logic used in R Shiny](https://programminghistorian.org/en/lessons/shiny-leaflet-newspaper-map-tutorial#shiny-and-reactive-programming). The callback functions determine the dynamic nature of the created dashboard. More detailed explanations are provided as comments in the above code. Note that the two returned objects (`line_fig_ukr` and `line_fig_rus`) should be ordered in the same way as how the output variables are ordered in the callback decorator (i.e., Ukraine's line graph goes first).

#### Testing the Dashboard

```
app.run_server(debug=True)
```

Code explanation: Now you can add the above line to actually see and test the created dashboard. It is recommended to turn on the debug mode so that any errors can be looked into when needed.

You need to put all the code you have written so far into a single `.py` file and name it such as `app.py`. The complete code [is provided here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/interactive-data-visualization-dashboard/app.py) for convenience. In command line, execute `$python app.py`. Then, a server address will appear, and you will need to copy and paste this address into a web browser to launch the dashboard. In Jupyter Notebook, you can also choose to review the dashboard as a cell output (again, please refer to [the notebook version of the code](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/interactive-data-visualization-dashboard/interactive-data-visualization-dashboard.ipynb)). 

#### Deploying the Dashboard
After the dashboard code is ready, in most cases, it is desirable to share your dashboards with the public using a URL. This means that you need to deploy your dashboard as a web application. In this section, you will achieve this goal by using a free service that allows us to host a dynamic web application: the free-tier web service provided by [Render](https://render.com/docs/web-services). In Render's free plan, the [RAM](https://en.wikipedia.org/wiki/Random-access_memory) limit is 512 MB at the time of writing. Our demo app takes about 90 MB, so the allocated RAM should be sufficient.[^7]

##### Setting up in GitHub
You will need to upload the code folder, `ph-dash`, as a repository onto GitHub. This can be done in command line or in GitHub Desktop (see [this lesson if you are new to Git or GitHub](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#github--github-pages-)).

Then, install one more library for deployment: `$pip install gunicorn`. This library, [`gunicorn`](https://gunicorn.org/), is needed when Render sets up a web server for you.

In the repository, you need two essential files: A `.py` file that contains all of your Python code, and a file called `requirements.txt` that lists all the required Python libraries for the dashboard. Later, Render will read this file to install the needed Python libraries when you deploy the app. You can easily create this requirements file in command line using `$pip freeze > requirements.txt`. I have [provided a sample repository in this link for your reference](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/interactive-data-visualization-dashboard).

##### Setting up in Render
You can sign up for free using an email address. Then, navigate to the appropriate place to create a new "Web Service." If your GitHub repository is public, you can copy and paste the HTTPS address of the repository into the address of "Public Git repository." Otherwise, you can also link your GitHub account with Render so that Render has access to your private repository.

Then, you will enter several pieces of information on the next screen. In addition to giving your dashboard a name, you need to configure two more settings (assuming all the populated default settings are correct). First, in "Start Command," change the input to `gunicorn app:server`. That is, the name after the colon must be the same as the object name of the server you set in your Python script. The name before the colon must be the same as the `.py` file in the repository.

Second, scroll down and expand the "Advanced" settings. Click "Add Environment Variable" and input `PYTHON_VERSION` as the key and the Python version that you use on your machine as the value. If you don't explicitly specify the Python version this way, Render will use Python 3.7 as default, which may cause conflicts between this old Python version and the libraries' versions specified in `requirements.txt`.

The last step is to "Create Web Service" and wait for several minutes for the application to be built. When finished, you can see your dashboard via a URL like this: https://ph-dash-demo.onrender.com/

### RQ2

#### Download Data

To download the data for RQ2, I have provided [the script here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/interactive-data-visualization-dashboard/rq2-download.py). The key step is to retry a query if there is an error returned by the server. This is probably due to the restriction that Chronicling America sets on how many requests in a given period can be sent to the server for downloads. No matter what your data demand is, always follow the rule set by the server and respect other users.

The data were curated by decade. Basically, the script goes through the list of 92 languages in each decade, and it counts the number of newspapers published in a language in a decade. The downloaded dataset, in CSV, has languages in the rows and decades in the columns. The cell represents the count of a given language within a given decade. 

#### Coding the Dashboard

I have the layout set up slightly differently from the one in RQ1. This time, the dashboard has two pie charts placed side by side, each of which has a dropdown menu for selecting decades. Both charts show the top-10 non-English languages in percentage. [The script can be found here](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/interactive-data-visualization-dashboard/app-rq2.py).  

## Conclusion
Interactive visualization contributes to digital humanities by facilitating knowledge discovery and making the research output more accessible to the public. In this lesson, the key steps of creating and deploying an interactive dashboard using an open-source tool, Dash in Python, are demonstrated with an example in media studies. Like [Shiny in R](https://doi.org/10.46430/phen0105), this is an approach that can be applied in a wide range of applications in digital humanities.

[^1]: Stephen Lacy et al., “Issues and Best Practices in Content Analysis,” *Journalism &amp; Mass Communication Quarterly* 92, no. 4 (September 28, 2015): 791–802, https://doi.org/10.1177/1077699015607338.

[^2]: André Baltz, “What’s so Social about Facebook? Distant Reading of Swedish Local Government Facebook Pages, 2010-2017,” *International Journal of Strategic Communication* 17, no. 2 (February 15, 2023): 118, https://doi.org/10.1080/1553118x.2022.2144324.

[^3]: Hermann W. Haller, “Ethnic-Language Mass Media and Language Loyalty in the United States Today: The Case of French, German and Italian,” *WORD* 39, no. 3 (December 1988): 187, https://doi.org/10.1080/00437956.1988.11435789.

[^4]: Andrew Hartman, “Language as Oppression: The English‐only Movement in the United States,” *Socialism and Democracy* 17, no. 1 (January 2003): 187–208, https://doi.org/10.1080/08854300308428349.

[^5]: K. Viswanath and Pamela Arora, “Ethnic Media in the United States: An Essay on Their Role in Integration, Assimilation, and Social Control,” *Mass Communication and Society* 3, no. 1 (February 2000): 39–56, https://doi.org/10.1207/s15327825mcs0301_03.

[^6]: An additional option is [ArcGIS](https://www.arcgis.com/index.html).

[^7]: If you need more computing power and greater RAM, especially for a heavily used web application that is based on a large dataset, you may need to pay Render a certain fee. At the time of writing, other options that can be used to host dynamic web applications (instead of static sites) include [PythonAnywhere](https://www.pythonanywhere.com/), [Dash Enterprise](https://dash.plotly.com/dash-enterprise), [Heroku](https://devcenter.heroku.com/), [Amazon Web Services](https://aws.amazon.com/), and [Google App Engine](https://cloud.google.com/appengine). If you want to host your own server,or you have someone at your institution who can help you set up a dedicated server, the general approach to take is to find ways to deploy Flask apps (e.g., via [Apache2](https://ubuntu.com/server/docs/web-servers-apache)).

## Bibliography

Baltz, André. “What’s so Social about Facebook? Distant Reading of Swedish Local Government Facebook Pages, 2010-2017,” *International Journal of Strategic Communication* 17, no. 2 (February 15, 2023): 113–133, https://doi.org/10.1080/1553118x.2022.2144324.

Haller, Hermann W. “Ethnic-Language Mass Media and Language Loyalty in the United States Today: The Case of French, German and Italian,” *WORD* 39, no. 3 (December 1988): 187–200, https://doi.org/10.1080/00437956.1988.11435789.

Hartman, Andrew. “Language as Oppression: The English‐only Movement in the United States,” *Socialism and Democracy* 17, no. 1 (January 2003): 187–208, https://doi.org/10.1080/08854300308428349.

Lacy, Stephen, Brendan R. Watson, Daniel Riffe, and Jennette Lovejoy. “Issues and Best Practices in Content Analysis,” *Journalism &amp; Mass Communication Quarterly* 92, no. 4 (September 28, 2015): 791–811, https://doi.org/10.1177/1077699015607338.

Viswanath, K., and Pamela Arora. “Ethnic Media in the United States: An Essay on Their Role in Integration, Assimilation, and Social Control,” *Mass Communication and Society* 3, no. 1 (February 2000): 39–56, https://doi.org/10.1207/s15327825mcs0301_03.
