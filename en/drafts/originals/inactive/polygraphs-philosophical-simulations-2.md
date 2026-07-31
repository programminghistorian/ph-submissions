---
title: "PolyGraphs: Running Philosophical Simulations and Analyzing Synthetic Data (part 2)"
slug: polygraphs-philosophical-simulations-2
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Brian Ball
- David Freeborn
- Frederica Imbriale
- Amil Mohanan
- Nicolas Kuri Perez Villaman
reviewers:
- Forename Surname
- Forename Surname
editors:
- Nabeel Siddiqui
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/697
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

This (advanced) lesson in two parts sketches how to use the PolyGraphs Python package to (i) run philosophical simulations (part 1) and (ii) analyze the synthetic data it generates (part 2), so as to better understand social processes of knowledge production.

In part 2, users are shown how to analyze the output data that the PolyGraphs simulation framework generates. The lesson uses PolyGraphs’ built-in functionality to load that synthetic data, returning a pandas dataframe with key information about each simulation. It shows how graphs on which simulations are run can be visualized (using networkx), and how to plot the evolution of opinion within the simulated community over time. Finally, it uses a case study involving data from experiments on the epistemic consequences of mis- and disinformation (shared in a compressed .tar.gz file), to show users how you can dig deeper into your (and indeed our) synthetic PolyGraphs data using class inheritance in Python, as well as the visualization libraries matplotlib and seaborn.

## Data Analysis

To begin to analyze the output data from PolyGraphs, you will need to open a new interactive Python notebook (.ipynb file) - which you might call (e.g.) ‘PolyGraphs Data Analysis’.

Recall (from part 1) that you will need the PolyGraphs code base available for import within that notebook. To achieve this, we will use a version of Jupyter Lab that (in part 1) we installed within the PolyGraphs virtual environment on your machine.

But first, we will need some (synthetic) data to analyze. Of course, if you have completed part 1 of this lesson, you will have the test data available (in your `results` sub-directory of the `polygraphs-cache` directory). And you may have generated further data by running simulations with other configuration files. Nevertheless, to show you some of what is possible in the way of PolyGraphs data analysis, we will analyze a (much richer) dataset that we ourselves have generated.

You can download the (2GB) dataset for our case study on mis- and disinformation [here][data\cleaned_data_v3_pt.tar.gz].

Once you have a local copy on your machine, you may want to move it (using the command line, or your graphic user interface) to `polygraphs-cache\results` (though you will be able to analyze it no matter where it is, provided you can specify the relevant folder path). You will then need to decompress it. Within the terminal, navigate to the folder containing the (compressed) dataset, and run:

```
tar -xzf cleaned_data_v3_pt.tar.gz
```

This should create a new folder (within 'polygraphs-cache\results', if that is where you are working) that contains our decompressed dataset. (It is the path to this folder that you will need to specify below.)

### Preliminaries

If you are not already there, open your terminal, navigate to the polygraphs directory, and activate your virtual environment. (If you are already there, you can tell whether your virtual environment is activated: if it is, you will see '(.venv)' on the left of your command line, in which case you can skip ahead; otherwise you will need to take the step that follows.) Recall that this last (activation) step is different for users of different operating systems.

For Linux/macOS, the command is:

```
source .venv/bin/activate
```

For Windows it is:

```
.venv\Scripts\activate
```

Now, within the terminal, from within the polygraphs directory, and with your virtual environment activated, open Jupyter Lab with the command:

```
jupyter lab
```

This should open a tab in a web browser (though you do not need to be online). You can then use the graphic user interface to open a notebook, which you can name as above.

### Data Exploration

You are now ready to analyze PolyGraphs output data! 

In your notebook, begin by importing the libraries you will use. You will need to make sure to include the Processor from `polygraphs.analysis`.

```
import numpy as np
import pandas as pd
import networkx as nx
import matplotlib.pyplot as plt
import seaborn as sns
from polygraphs.analysis import Processor
```
We will use numpy and pandas for basic data analysis, networkx for network analysis, matplotlib and seaborn for data visualization, and the PolyGraphs Processor to load and manipulate the output data from our simulations.

Next, choose a new variable name for an object of the Processor class. It does not matter much what you call this, as at this stage we are just making sure things work, and you are able to load your data – the real data analysis will be done later, with a different object, belonging to a class that inherits from Processor. You will need to specify a path to the folder containing the PolyGraphs output data you want to analyze – in your case, this might be the ‘polygraphs-cache/results’ folder in the directory where you have installed PolyGraphs (which is the Processor’s default location in any case).[^1] To avoid errors, you can set `config_check=False` (rather than `=True`, which is the default value). 

```
processor = Processor('the path to your directory', config_check=False)
```

Your Processor object has a method called .get() which returns a pandas dataframe – as can be seen by inquiring after its type. (In fact, the dataframe that is returned is an attribute of the Processor object. It can also be accessed - more directly - by replacing .get() with .sims in the line of code below.)

```
type(processor.get())
```

It is, we think, instructive to see the shape (attribute) of this dataframe: 

```
processor.get().shape
```

There should be many rows (36,646 to be precise), and 13 columns. The rows correspond to the various simulations whose output data we have loaded from the directory path we specified. Let's also list the columns explicitly:

```
processor.get().columns
```

You should see that there are five columns – from ‘trials’ to ‘epsilon’ - that contain the values of various key parameters that were set in the config file. Then there are five columns – from ‘steps’ to ‘polarized’ – that tell us about the result of running the simulation using those parameters. (Below, we will largely focus on the effects on ‘steps’ of various factors – though which ‘action’ was taken by all agents at the end of the simulation is also crucially important.) Finally, there are three columns containing the paths to the various files containing the data from the simulation in question.[^2] 

You can get a feel for what is in the dataframe with the pandas .head() method:

```
processor.get().head()
```

It can also be quite helpful to get a count of how many sims there are of each variety that one anticipates investigating. We can do that using `.groupby()` and `.count()`:

```
processor.get().groupby(['network_kind', 'op']).count()
```

In our case, we have data from sims involving data from three different network kinds, and a variety of operations. When we move to analyzing our data, we will begin by focussing on the so-called ‘random’ (Erdos-Renyi) networks: these are generated by an algorithm that simply creates an edge between any two nodes with a certain fixed probability p. Notice that, although this probability is a parameter that we specify in the config file, the Processor has not returned a column containing this information. Similarly, we have data from sims  run using a number of operations that involve a reliability parameter r: this specifies the probability that a given node will communicate reliable information (if not, it will be unreliable); and yet the processor has no column returning that parameter value.

Luckily, the Processor has a built in method of fetching such information for any parameter whose values are specified in the configuration file: it is called .add_config().

```
processor.add_config('reliability')
```

The code above adds a column to the dataframe returned by the .get() method, as can be seen using .shape:

```
processor.get().shape
```

For much of our analysis, we will be working with the dataframe returned by the .get() method. But before diving into that analysis, we want to highlight two further key functionalities of our Processor: one of these allows us to access the graphs of the networks on which the sims are run; the other gives us access to the stored beliefs for the nodes.

To begin, let’s pick a particular sim to look at (setting the value of a new variable, here called `sim`). We can do this using .iloc:

```
sim = 22700
processor.get().iloc[sim]
```

Running the above code, you will see that this particular sim (22700) is run on a random graph of size 64, using the UnreliableNetworkBasicGullibleNegativeEpsOp with reliability 0.75: that is, there is a one in four chance that any given one of the 64 nodes will be an unreliable communicator who disseminates disinformation, or lies (i.e. reports of outcomes of coin tosses drawn from the negative epsilon distribution), with the remaining nodes designated ‘reliable’; and the recipients of that information will nonetheless be ‘gullible’, fully trusting it. Despite this, the community has converged on the consensus opinion that action B is the one to take after 4123 simulation steps.

Using .graphs we can see the graph data for our sim: 

```
processor.graphs[sim].pg
```

The above code reveals that the data associated with the nodes (‘ndata’) is stored as a collection of tensors.[^3] The ‘reliability’ tensor, for example, lists, for each node, whether that node is reliable (1) or not (0). (The ‘beliefs’ listed are just the initial beliefs – at step 0 when the simulation begins.) There is no edge data (‘edata’).

Using networkx’s draw function, we can visualize the graph on which this simulation was run. Further refinement is possible (for example, you can use draw_circular if you prefer) – but this gives us an idea of the community structure we are working with in this instance.

```
nx.draw(processor.graphs[sim])
```

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-01.png" alt="A collection of 64 blue dots ('nodes') densely connected by black lines ('edges')" caption="Figure 1. The random graph on which simulation 22700 in our dataframe was run." %}

Turning to the beliefs, we can see that, for each simulation (corresponding to a row of the processor.get() dataframe), we can retrieve a multi-indexed dataframe containing the relevant data. (The first index is the iteration, or step, of the simulation in question; the second index is the node of the graph. For each pair of iteration and node we get a degree of belief that the hypothesis under investigation is true. This is a number between 0 and 1.)

```
processor.beliefs[sim]
```

This can also be visualized (using built in functionality in pandas). Here we plot the mean of all the nodes’ credences (or beliefs) at each iteration – but you can equally well plot other statistical summaries, such as the maximum (`.max()`), or the standard  deviation (`.std()`). Go ahead – try it out! (Don't forget to adjust the title of the plot if you do.)

```
processor.beliefs[sim].groupby('iteration').mean().plot(title='Average Credence')
```

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-02.png" alt="A visualization with a jagged blue line (called 'beliefs') plotting an upwards trajectory from about 0.5 to nearly 1.0 as the simulation step, or iteration, progresses from 0 beyond 4000." caption="Figure 2. The mean of nodes' credences at each recorded step in simulation 22700." %}

Notice that the average (i.e. mean) credence here increases over (simulation) ‘time’ (i.e. iterations, or steps) in fits and starts, until eventually all the nodes have a credence (or belief) above 0.99 (at step 4123) and the simulation ends (with a consensus having been achieved that B is the better action to perform). Plenty more can be done, of course – see the PolyGraphs documentation [here](https://akoliousis.com/polygraphs/guide/simulations/processing-results) for some pointers.

### Adapting the Processor

In our case study, we want to explore the effects on the community’s efficiency in getting to the truth, first, of certain structural features of the graph (i.e. of the channels of communication within the community), and second, of the quality of the informational environment (within that community). In particular, we will explore the effect of network density – the proportion of all the possible edges between nodes that actually exist in the graph; and the effect of the exact number of reliable nodes - i.e. of agents telling the truth about what they observe.

Notice, however, that although this information can be worked out from data that we have, the Processor does not have a method for retrieving it. To remedy this, we can adapt the Processor, through class inheritance.[^4] To that end, we will define a new class, called `DR_Processor` (for ‘density’ and ‘reliability’), which inherits from the Processor class. And we make sure to initialize it in such a way that it inherits the abilities to include or exclude sims with various parameter values, and to run a config_check.

```
class DR_Processor(Processor):
	
	def __init__(self, path, include=None, exclude=None, config_check=True)
		super().__init__(path, include, exclude, config_check)
```

We then define two functions, one that calculates density for each of the graphs loaded, and one that works out how many nodes in the graph are reliable communicators. They store these as lists, which they use to populate a new column of the dataframe returned by the DR_Processor.

```
	def density(self)
		"""Use NetworkX to calculate the density of the graph for each sim"""
		density_list = [nx.density(graph) for graph in self.graphs]
		self.dataframe['density'] = density_list

	def reliable_node_count(self)
		"""Use basic arithmetic to calculate the number of reliable nodes in each sim"""
		rel_count_list = []
		for graph in self.graphs:
			try:
				rel_count_list.append(int(graph.pg['ndata']['reliability'].sum().item()))
			except KeyError:
				rel_count_list.append(np.nan)
		self.dataframe['reliable_node_count'] = rel_count_list
```

Of course, we need to make sure that these functions get called when a new object of the class we are defining is initialized. So, putting the above together, we get the following (which you should run all at once in a separate cell of your notebook):

```
class DR_Processor(Processor):
    
    def __init__(self, path, include=None, exclude=None, config_check=True):
        super().__init__(path, include, exclude, config_check)
        # Add the columns when the processor is initialized
        self.add(self.density(), self.reliable_node_count())

    def density(self):
        # Use NetworkX to calculate the density of each grap
        density_list = [nx.density(graph) for graph in self.graphs]
        self.dataframe['density'] = density_list

    def reliable_node_count(self):
        rel_count_list = []
        for graph in self.graphs:
            try:
                rel_count_list.append(int(graph.pg['ndata']['reliability'].sum().item()))
            except KeyError:
                rel_count_list.append(np.nan)
        self.dataframe['reliable_node_count'] = rel_count_list
```
Now that we have defined this new class, we should put it to use. To begin with, we set the data_path variable to point at the `unique_runs` sub-directory of the `cleaned_data_v3_pt` folder (making sure to copy the full path specification):

```
data_path = '~/cleaned_data_v3_pt/unique_runs'
```

In our data analysis, we want to look, in the first instance, at random networks only. And since we are interested in the quality of the informational environment, we can exclude any sims that use the `BalaGoyalOp`, which has no unreliable nodes at all. Since our new DR_Processor performs calculations on the data it loads, it is a good idea not to load data that we are not interested in! The code below should not take very long to execute – but bear in mind that if you want to work out the structural features of large graphs (in ways we will touch on below), it can!

```
er = DR_Processor(data_path, include={'network.kind': 'random'}, exclude={'op':'BalaGoyalOp'}, config_check=False)
```

We should add the configuration parameters for ‘reliability’ and the random network ‘probability’ of forming an edge between two nodes.

```
er.add_config('reliability', 'network.random.probability')
```

If we .get() our dataframe, we can see that our data has loaded, and that there are columns corresponding to the new functions we added to the DR_Processor class, and to the config parameters we added.

```
er.get()
```

Running this code, you should already see some interesting things. First, the reliability column indicates that there is a 0.75 chance of any given one of the 64 nodes being reliable in the first few rows – and yet the reliable node count varies from row to row. Second, and in a similar spirit, you should see that the probability of there being a connection between two nodes in these graphs is 0.22, and yet the density varies. This is because the algorithms that determine whether there is an edge between two nodes, and whether a given node is reliable or not, are stochastic, or chancy. Our first task, then, is to describe the data that we have, before looking at the effects of density and reliable node count on steps.

### Descriptive Statistics

What structural properties do the graphs of our communities exhibit? We know that the network size, and the probability of an edge forming between any two nodes, are the factors that can be specified in our configuration files which will affect network structure. If we do a `.groupby()` and `.count()` we can see, first, that all of our sims are run on size 64 networks, and second, that there are seven different probabilities specified.

```
er.get().groupby(['network_size','network_random_probability']).count()
```

Focussing on probability, then, how does this affect density? We can find out, using the .describe() method applied to the ‘density’ column:

```
er.get().groupby('network_random_probability').density.describe()
```

But we can perhaps more readily understand how density varies with probability using a simple scatterplot in matplotlib – which reveals that density is roughly equal to the probability of connection between nodes, subject to a certain amount of random noise:

```
plt.scatter(er.get()['network_random_probability'], er.get()['density'])
plt.title("Density vs Probability in Random Graphs")
plt.xlabel("Probability")
plt.ylabel("Density")
plt.show()
```

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-03.png" alt="A visualization of Density (on the y axis) vs Random Probability (on the x axis). Density matches probability, plus or minus some noise." caption="Figure 3. A plot of density as a function of edge probability in random networks." %}

Other specifiable configuration parameters that are relevant to epistemic outcomes include ‘reliability’ and ‘epsilon’. A `.groupby()` and `.count()` reveals that all of our sims have the same overall reliability of 0.75 and an epsilon value of 0.001. 

```
er.get().groupby(['reliability', 'epsilon']).count()
```

A .describe() of sims in the same ‘reliability’ group reveals, however, that there is considerable variation in the number of reliable nodes within this group:

```
er.get().groupby('reliability').reliable_node_count.describe()
```

A visualization – this time produced with seaborn’s histogram function – may make this information more immediately available, however:

```
sns.histplot(er.get()['reliable_node_count'], discrete=True).set(title='Histogram of Reliable Node Counts')
```

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-04.png" alt="A visualization of the number of simulations with each reliable node count from less than 35 to almost 60. There is a peak at 48, with over 400 sims having this reliable node count, with a gradual, and roughly symmetrical, drop in each direction along the x axis." caption="Figure 4. Histogram of reliable node count for size 64 networks with 0.75 reliability." %}

These two factors – the structure of the network, as measured through its density, and the quality of the informational environment, as measured through the number of reliable nodes in the network – will have a bearing on the efficiency of the simulated community in arriving at the truth. This is what we turn our attention to next.

### Efficiency Analysis

In order to analyze the effects on steps to convergence of these structural and environmental factors, we first need to isolate those sims that were conducted under a particular operation. We can list the various values in the ‘op’ column using the .unique() method:

```
er.get()['op'].unique()
```

Here we restrict attention to the ‘op’ that corresponds to unreliable nodes spreading disinformation, with recipients of all messages being trusting (or ‘gullible’). We recommend you do the same on your first exploration of this data – you will have a chance to investigate other settings below.

```
disinfo_trust = er.get()[er.get()['op'] == 'UnreliableNetworkBasicGullibleNegativeEpsOp']
```

First, let us attempt to understand the effects of density on steps in these sims – a simple scatterplot can help with this.

```
plt.scatter(disinfo_trust['density'], disinfo_trust['steps'])
plt.title('Steps vs Density in Random Graphs')
plt.xlabel('Density')
plt.ylabel('Steps')
plt.show()
```

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-05.png" alt="A scatterplot of simulation steps for sims involving disinformation plus trust, with four discernible clusters of dots along the x axis (density): just above 0.1; above 0.2; just below 0.4; and near 0.5. On the y axis, steps range from 0 to 100,000: the lower density clusters have more dots nearer the top of the range." caption="Figure 5. A scatterplot of simulation steps vs density in simulations on size 64 random networks, with unreliable agents sharing disinformation, and all agents trusting what they are told." %}

We can also get more precise information about the relationship between, on the one hand, density – or the configuration parameter that most directly controls it, probability – and, on the other, steps, using `.groupby()` and `.describe()`. The mean number of steps clearly decreases with probability group – itself a proxy for density; and the percentage of sims reaching the limit of 100,000 steps likewise decreases as density/probability increases.

```
disinfo_trust.groupby('network_random_probability').steps.describe()
```

How does reliable node count affect steps? Since density has a clear effect on steps, we should isolate various density buckets amongst our sims.

```
dt1 = disinfo_trust[disinfo_trust['network_random_probability'] < 0.14]
dt2 = disinfo_trust[(disinfo_trust['network_random_probability'] > 0.14) & (disinfo_trust['network_random_probability'] < 0.28)]
dt3 = disinfo_trust[(disinfo_trust['network_random_probability'] > 0.28) & (disinfo_trust['network_random_probability'] < 0.42)]
dt4 = disinfo_trust[disinfo_trust['network_random_probability'] > 0.42]
```

As this scatterplot reveals, the more reliable nodes there are in sims in the third density (or probability) bucket, the fewer steps it typically takes for the sim to converge.

```
plt.scatter(dt3['reliable_node_count'], dt3['steps'])
plt.title('Steps vs Reliable Node Count in Density Bucket 3')
plt.xlabel('Reliable Node Count')
plt.ylabel('Steps')
plt.show()
```

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-06.png" alt="A scatterplot of simulation steps (up to 100,000) vs reliable node count (c. 40 to 60) in disinfo_trust simulations on medium-high density size 64 random networks. There is a clear downwards trend in steps as reliable node count increases." caption="Figure 6. A scatterplot of simulation steps against reliable node count in the current collection of sims on medium-high density size 64 random networks." %}

You should find similar – though perhaps less obvious – results if you select other density/probability buckets instead. Go ahead and try for yourself!

## Generalizations

You should now have grasped the basics of how to analyze the synthetic output data from simulations in social epistemology using PolyGraphs. Of course, the kinds of analysis we have done can be generalized in various ways.

### Further Operations

One generalization is to compare the behaviours of communities under different operations. For example, agents might be sceptical, rather than trusting, towards testimony they receive when they are aware that there is disinformation present in their environment (aligning their level of trust in testimony encounterd to the general reliability in the network). Here we select all of the disinformation sims and group them by density/probability.

```
disinfo = er.get()[(er.get()['op'] == 'UnreliableNetworkBasicGullibleNegativeEpsOp') | (er.get()['op'] == 'UnreliableNetworkModifiedAlignedNegativeEpsOp')]
dis1 = disinfo[disinfo['network_random_probability'] < 0.14]
dis2 = disinfo[(disinfo['network_random_probability'] > 0.14) & (disinfo['network_random_probability'] < 0.28)]
dis3 = disinfo[(disinfo['network_random_probability'] > 0.28) & (disinfo['network_random_probability'] < 0.42)]
dis4 = disinfo[disinfo['network_random_probability'] > 0.42]
```

Seaborn allows us to plot data concerning ‘gullible’ agents side by side with data concerning more sceptical agents whose level of trust is ‘aligned’ to the level of reliability in the network (by setting the column of the plot, or `col` variable, equal to the `op` in a catplot). In both cases, the more reliable nodes there are, the fewer steps are typically required to converge to the truth – but, as is apparent, the more sceptical information processing strategy requires more steps. The benefits of doubting bad information appear to be outweighed by the costs of doubting the good information!

```
sns.catplot(data = dis2, x = "reliable_node_count", y = "steps", col='op')
```

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-07.png" alt="Two scatterplots side by side: on the right (scepticism), the dots typically indicate higher numbers of steps than on the left (trust)." caption="Figure 7. A comparison of how reliable node count affects steps in a disinformative environment when agents are trusting (left) or sceptical (right)." %}

In a similar spirit, we can ask after the comparative effects of unreliable node behaviour amongst agents pursuing the same information processing strategy. Here we isolate the sims involving sceptical agents, and again group them into density buckets.

```
sceptical = er.get()[(er.get()['op'] == 'UnreliableNetworkModifiedAlignedBinomialOp') | (er.get()['op'] == 'UnreliableNetworkModifiedAlignedNegativeEpsOp')]
scep1 = sceptical[sceptical['network_random_probability'] < 0.14]
scep2 = sceptical[(sceptical['network_random_probability'] > 0.14) & (sceptical['network_random_probability'] < 0.28)]
scep3 = sceptical[(sceptical['network_random_probability'] > 0.28) & (sceptical['network_random_probability'] < 0.42)]
scep4 = sceptical[sceptical['network_random_probability'] > 0.42]
```

Amongst sceptical agents, (‘binomial’) misinformation has a much lesser adverse effect on steps to convergence than does (‘negative epsilon’) disinformation!

```
sns.catplot(data = scep4, x = "reliable_node_count", y = "steps", col='op')
```

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-08.png" alt="Two more scatterplots side by side: on the left (misinformation), the dots indicate many fewer steps, especially at low reliable node counts, than on the right (disinformation)." caption="Figure 8. A comparison of how reliable node count affects steps amongst sceptical agents in the presence of misinformation (left) or disinformation (right)." %}

You should go ahead and explore similar questions on your own.

### Alternative Network Kinds

So far we have looked only at so-called ‘random’ (or ‘Erdos-Renyi’) graphs. But PolyGraphs allows you to run simulations on a range of different graph types. For example, Barabasi-Albert graphs are those generated by an algorithm of ‘preferential attachment’: when nodes are added to the graph, they have a fixed number of ‘attachments’, or new edges to form; but which nodes they attach to is determined probabilistically, with the chance of connecting to a given node proportional to the number of edges it already has.

It may be helpful to see a visualization of such a graph. First we load the relevant data, using the `DR_Processor`, and add the crucial configuration parameters:

```
ba = DR_Processor(data_path, include={'network.kind': 'barabasialbert'}, exclude={'op':'BalaGoyalOp'}, config_check=False)
ba.add_config('reliability', 'network.barabasialbert.attachments')
```

Then we select a Barabasi-Albert network of size 32 with just 1 attachment per node, and draw it with functionality from networkx:

```
ba_sim = 1500
nx.draw(ba.graphs[ba_sim])
```

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-09.png" alt="A visualization of a graph, with 32 blue dots (nodes) sparsely connected black lines (edges)." caption="Figure 9. Graph of the (32 node, 1 attachment) Barabasi-Albert network from sim 1500." %}

Note that the density of graphs generated in this way is completely determined by this number of attachments... for a given size of network. Hereafter we restrict attention to networks of size 64:

```
ba64 = ba.get()[ba.get()['network_size'] == 64]
```

This effect of attachments on density should be evident in the scatterplot below. Clearly, as the number of attachments increases, so does the density of the graph; but there is no variation in density for a fixed number of attachments (and network size).

```
plt.scatter(ba64['network_barabasialbert_attachments'], ba64['density'])
plt.title('Density vs Attachments in Size 64 BA Networks')
plt.xlabel('Attachments')
plt.ylabel('Density')
plt.show()
```

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-10.png" alt="A scatterplot showing a single density dot for each number of attachments. Density increases with attachments, less so as number of attachments increases." caption="Figure 10. Density as a Function of Attachments in BA Networks of Size 64." %}

In these Barabasi-Albert networks, density – which is determined by attachments – also affects steps to convergence. Here is a description of some steps data concerning sceptical agents in the presence of misinformation, for reliability `r=0.75`:

```
ba64[ba64['reliability'] == 0.75].groupby('network_barabasialbert_attachments').steps.describe()
```

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-11.png" alt="A table of descriptive statistics." caption="Figure 11. Descriptive Statistics for Simulation Steps Grouped By BA Attachments." %}

It is worth noting that there are yet further network kinds available in PolyGraphs. In the dataset provided, for instance, there are so-called 'Watts-Strogatz' networks, with various numbers of nearest neighbours, and probabilities of rewiring.[^4] Feel free to use the techniques you have developed here to explore this data on your own!

### Additional Structure Metrics

Network scientists have articulated a wide range of concepts for structural features of graphs, and introduced measures of them – yet we have here only discussed density. NetworkX has built-in functionality to extract many of these graph features, much as we were able to determine density above by calling `nx.density(graph)` in our definition of the `DR_Processor` above. We encourage you to explore these further aspects of network structure and their effects, if any, on epistemic outcomes within our data - you should know enough know to be able to do so (in consultation with the NetworkX [documentation](https://networkx.org/documentation/stable/reference/index.html)). Recall that you will need to build a new class of Processor and re-load the data using it!

### Interaction Effects

One question that interests us is how the quality of the informational environment interacts with network structure to affect the community’s ability to discern the truth. This is something that can be investigated within PolyGraphs in a number of ways. Here we very briefly sketch one approach.

Networkx has algorithms that allow us to calculate how 'central' (or important) each of the nodes in a given network is (relative to the other nodes), according to various metrics. For example, the betweenness centrality of a node is a (relative) measure of how frequently that node occurs on the shortest path (or sequence of edges) between other nodes in the network; while its degree centrality is a measure of how many nodes it is directly connected to (relative to other nodes).

Using variations on coding the strategies already explained, we recorded the mean centrality of the top four unreliable nodes in the graph for each simulation, divided these into four groups, and produced boxplots of steps for each of the quartiles. Across the three kinds of networks mentioned above, we found a consistent pattern: as the betweenness centrality of the top four unreliable nodes increased, so did the number of simulation steps. Here we show the clearest case - that of random graphs.

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-12.png" alt="Five collections of four boxplots (one for each op) clearly showing that the number of steps increases as the mean betweenness centrality of the top 4 unreliable nodes increases - especially when unreliable nodes are disinformants." caption="Figure 12. Boxplots for each quartile of mean betweenness centrality for the top four unreliable nodes, for each operation in our dataset, on random graphs." %}

Perhaps more surprisingly, the number of steps decreased with an increase in mean degree centrality for the top four unreliable nodes!

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-2-13.png" alt="Five collections of four boxplots (one for each op) clearly showing that the number of steps decreases as the mean degree centrality of the top 4 unreliable nodes increases - especially when unreliable nodes are disinformants." caption="Figure 13. Boxplots for each quartile of mean  degree centrality for the top four unreliable nodes, for each operation in our dataset, on random graphs." %}

We suspect there are many more such findings to be uncovered in this dataset, and in others you might generate, using the kinds of techniques we have outlined. Happy explorations!

### Statistical Testing

Up to this point, we have investigated the synthetic output data from PolyGraphs simulations, primarily from our case study of mis- and disinformation. In particular, we have: loaded the data, having refined the Processor to extract information about network structure, as well as the character of the informational environment; visualized the graphs on which simulations run, and the evolution of the agents' beliefs within a simulation over time (technically, iterations); obtained and plotted descriptive statistics; and more. These methods yield real insights; and yet, to be confident that our findings are robust, we may need to conduct statistical testing.

If you are a quantitative social scientist, you will be aware that there are a great many different statistical methods, and that which ones are needed depends very much on the task at hand. In any case, we will not begin here to give you a systematic orientation to the variety of techniques that are available to you, both mathematically, and in Python; but we note that, when it comes to the efficiency of PolyGraphs simulations, one approach to satistical significance testing has been fully developed [here](https://github.com/alexandroskoliousis/polygraphs/blob/main/examples/analysis/zollman-effect/mann-whitney-steps.ipynb). We hope this may be helpful in guiding your next steps, if this is a direction you wish to pursue.

## Conclusion

In this advanced, two-part lesson, we have seen, first (in part 1), how to install the PolyGraphs code package, and use it to run philosophical simulations, and then (in part 2), how to load and analyze the synthetic data it generates, using output data from experiments we have run on the effects on opinion formation of trust and scepticism in the presence of mis- and disinformation. 

From a technical perspective, we have covered a lot of ground, from building and activating a virtual environment for the PolyGraphs code, using configuration (`.yaml`) files, building and loading graph datasets (`.gml` files), to using and modifying the Processor class of objects for data analysis, and visualization with matplotlib and seaborn.

Conceptually, we have discussed agent-based modelling and the advantages of the simulational method it enables, as well as a variety of network-theoretic notions - and we have leveraged these to begin to see how insights can be gleaned about opinion formation within social groups and communities under a variety of conditions. Indeed, we hope to have shared some such insights with you, based on the output data provided in our case study.

Most importantly of all, you should now know enough to be able to further explore our data to learn more about how communicative structures and information quality affect knowledge production in a social setting; and even to devise and conduct your own experiments that allow you to address the 'what if?' questions in social epistemology that interest you!

## Endnotes

[^1]: You can find the name of the path to your directory by right clicking on it and choosing 'Copy as path' (Windows) or 'Copy as Pathname' (macOS). You may need to adjust the direction of the slashes (from `\` to `/`) after pasting into your notebook.
[^2]: A couple of comments are in order. First, if you load a different dataset - for example, the data from your PolyGraphs test run - the dataframe may have a different number of columns. (In particular, there should be a 'duration' column, giving the number of seconds it took to run the simulation, and a 'uid' column giving the folder containing the output data files.) Second, while one of the file path columns is called `bin_file_path`, in fact the file at that location is now (in the ptgraph branch of the repository to which we swithced using git, when setting up our virtual environment) a .pt file. Much previous PolyGraphs work - including that done for the pedagogical materials in this [Human and Network Sciences Jupyter book](https://brianandrewball.github.io/humannetworkscience/intro.html) - was carried out using the code in the main branch (which produces .bin files). But the new branch used here makes the installation process much simpler!
[^3]: A tensor is a multidimensional array of numbers. Thus, a scalar is simply a number, a vector is a list of numbers, a matrix is a two-dimensional array of numbers (roughly, a list, or sequence, of vectors). A tensor is simply a further generalization in this same spirit.
[^4]: Recall from part 1 that you can learn more about class inheritance from W3Schools at https://www.w3schools.com/Python/python_oop.asp.
[^5]: You can see the names of the `wattsstrogatz` parameters immediately following line 292 in the code available [here](https://github.com/alexandroskoliousis/polygraphs/blob/main/polygraphs/graphs.py).
