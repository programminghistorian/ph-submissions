---
title: "PolyGraphs: Running Philosophical Simulations and Analyzing Synthetic Data (part 1)"
slug: polygraphs-philosophical-simulations-1
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

This (advanced) lesson in two parts sketches how to use the PolyGraphs Python package to run philosophical simulations (part 1) and analyze the synthetic data it generates (part 2), so as to better understand social processes of knowledge production.

This first part introduces key concepts of network theory (e.g. ‘graph’, 'node', and 'edge'), as well as those of social epistemology. It shows users how to install PolyGraphs and run philosophical simulations, manipulating (.yml) configuration files, and importing your own (.gml) graph datasets.


## Introduction

In this (advanced) lesson, we will explore PolyGraphs[^1], a Python package for running philosophical simulations[^2] (part 1) and analyzing the synthetic data[^3] it produces (part 2). In particular, PolyGraphs can be used to understand the effects on belief formation and knowledge production within various types of communities of a range of independently manipulable factors. In short, it is a computational tool for use in social epistemology - the study of knowledge in a social, or group, setting.[^4]

To date, this specialized research software has been used to explore issues in the philosophy of science[^5] and the theory of knowledge,[^6] as well as (the role of women) in intellectual history,[^7] and the impact on public opinion of mis- and disinformation.[^8] But (as we will see) the code base is adaptable – and as PolyGraphs allows users to run computational experiments, it is ultimately up to you to think of new and exciting further issues to explore, and hypotheses to test! With that in mind, let us begin.

### Overview

In order to understand the case study on misinformation we will pursue in (the companion) part 2 of this lesson, it is important to have some awareness of the range of possibilities that PolyGraphs currently affords. As a user, the software allows you to algorithmically generate, or import, representations of the (hypothetical or, respectively, real-world) communities you wish to study, and to choose various aspects of the (cognitive and communicative) behaviour of the individuals that make up those communities. For example, you can model small, face-to-face groups in which everyone talks to everyone else; or you can load social media data to study communication online. You can also decide whether any of the community members are ‘unreliable’ communicators, how such unreliable agents behave (e.g. as incompetent misinformants or deceptive disinformants), and whether those who encounter their messages are sceptical or trusting of the information they receive. Finally, as we will see, PolyGraphs allows you to (store and subsequently) analyze the synthetic data it generates about the dynamics of belief within the community – e.g. how agents’ confidence in the truth changes over time, in response to the information available to them.

In (the accompanying) part 2 of this lesson we will focus on the effects of community structure, and the quality of the informational environment (as determined by the number, and behaviour, of unreliable communicators), on the efficiency of the community in arriving at a consensus accepting the truth. That is, our case study surrounds the effects of misinformation on public opinion in relatively small, trusting communities with simplified structures.

After walking through the (conceptual and technical) prerequisites for this lesson (next), we will help you to get started with PolyGraphs, sketching how to install the software and use it to run simulations – and in doing so we will show you how to manipulate some of the factors that can make a difference to outcomes in this framework. 

In part 2, we will proceed to the heart of the case study, showing you how to load and visualize the output data (both your own, and some from simulations that we ourselves have run), before explaining how to adapt the code so as to look specifically at the effects of fine-grained network structure and informational environment variables on community opinions. Finally, we will then indicate ways in which you can generalize what we have done here, so that you are equipped to put PolyGraphs to use for your own purposes, before briefly concluding.

### Conceptual Prerequisites

As already indicated, PolyGraphs is a tool for running computer simulations. If you have no familiarity with this approach to humanities (and/or natural or social scientific) research, we strongly advise reading the Programming Historian’s excellent (‘high difficulty’) lesson on simulating communication networks (in Python, no less) by way of introduction.[^9] Two key conceptual points from that article are worth stressing here.

First, simulations require a model of the phenomenon being simulated – specifically, in our case study, opinion formation within communities, in the presence of misinformation – in order to ensure computational tractability (that is, the applicability of computational methods to their investigation). In PolyGraphs, the various simulation operations, or ‘ops’, correspond to (computational implementations of) the abstract mathematical models deployed. You will not need to understand the models it uses in great detail in order to follow this lesson, and in any case they are explained thoroughly elsewhere,[^10] so here we will confine ourselves to a few basic points.

PolyGraphs treats communities as ‘networks’ of individuals connected by channels of communication. It represents these networks using what are known as ‘graphs’ – namely, collections of ‘nodes’ (standing for the individuals) and ‘edges’ (representing channels of communication). 

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-1-01.png" alt="A collection of 34 blue dots ('nodes') connected by 78 black lines ('edges')" caption="Figure 1. An example of a graph. In PolyGraphs, the nodes represent agents, and the edges lines of communication between them." %}

The individual community members themselves are treated as rational agents: they take one of two actions (A or B), depending on which they expect will have a better outcome (in fact B does, on average); and they update their beliefs about this (represented as decimal numbers between 0 and 1) in light of the information at their disposal (through their own observations following the action taken, and the reports of their network neighbours – e.g. their social media ‘friends’). The actions taken are chancy - they lead to successful outcomes only with a certain probability (0.5 in the case of A; 0.5 + positive epsilon in the case of B). Indeed, we can think of these actions as tosses of a fair or (positively) biased coin (A and B respectively). Simulations repeat for a number of such steps, until all agents have a degree of belief, or confidence, in the truth (that B is better) above a certain threshold (we use 0.99 here), or they converge on a mistaken consensus (that A is better).[^11]

Crucially, then, PolyGraphs assumes an underlying ‘agent-based model’ corresponding to each operation; and it uses notions from network science to model communities. Familiarity with either or both will be an advantage in pursuing this lesson; though neither is strictly required, and we will continue to explain key notions as needed (much as we have done with the notion of a graph above).

Second, when you employ the method of simulation, you do not need independent datasets for analysis – the simulations themselves generate their own (synthetic) data as outputs. That is the case with PolyGraphs – in two different ways. In particular, PolyGraphs is able to generate its own (synthetic) graph representations of hypothetical community networks - although, as we shall see, it is also possible to import graph datasets in order to study real-world communities. Moreover, as the simulations run, the computations performed also generate (synthetic) belief data for each of the nodes in graphs employed.

This point is worth stressing - for it reveals at least two distinct advantages of the simulational method of investigation. Consider the synthetic belief data that PolyGraphs generates. In empirical studies, there are deep difficulties - both practical and conceptual - in measuring agents' beliefs. Since beliefs cannot be directly observed, they must be somehow attributed on the basis of what can - e.g. their linguistic expressions. But how exactly do the behaviours we can observe (and measure) relate to the underlying beliefs that are responsible for producing them? After all, people may be dishonest, or simply mistaken, about what they themselves think! (Similar points apply to other behavioural indicators of belief.) Simulational studies using PolyGraphs, however, do not need to address this issue: by stipulation, the agents' beliefs **are** as PolyGraphs records them to be! In short, there is no gap between what is measured and its measurement in these simulations: the researcher is effectively omniscient in this regard! That is the first advantage.

The second advantage is that simulation allows us to investigate what might happen if things were different to how they actually are - that is, to explore counterfactual histories, and hypothetical (in our case, communicative) interactions between individuals. But how can we obtain (empirical) data from such situations? In effect, through its reliance on synthetic data, PolyGraphs allows us to 'observe' (or at least measure) merely possible scenarios! We think that is quite useful, and hope it will motivate you to learn how the code base can be deployed.

### Technical Prerequisites

From a technical point of view, some familiarity with Python is assumed in what follows. If you do not already have such familiarity, you can begin with the Programming Historian’s introductory lesson.[^12] This said, it is anticipated that you may further your knowledge of Python through this lesson – and can deepen your understanding (e.g. of class inheritance, which we will use in part 2) with materials available elsewhere.[^13] Similar remarks apply to a range of further Python libraries. In particular, over the two parts of this lesson, we will import and use: [numpy][3]; [pandas][4]; [matplotlib][5]; [networkx][6]; and [seaborn][7]. 

At a more basic level, we assume you are able to use a terminal on your machine – this will be key in installing the PolyGraphs code, and is convenient (though, as we shall see, not strictly necessary) when running simulations. Note, crucially, that for installation to proceed in the manner described below, Git must be available on the terminal you use;[^14] and in part 2 we will make use of (the file archiver) tar to decompress some PolyGraphs output data for use in our case study. 

Finally, we assume that you have some experience of using (interactive) iPython notebooks (.ipynb files). This said, (in part 2) we will walk you through the installation of Jupyter Lab - even if you already have it installed on your machine - so that you have the PolyGraphs code available for use in your notebooks, and are able to analyze the synthetic data it produces. 

Note that, after installation is complete, you will not need to connect to the internet to follow (either part of) this lesson (except to download the dataset at the start of part 2).[^15]

## Getting Started

In this section, we will briefly discuss installation, before turning to the task of running simulations in PolyGraphs.

### Installation

To install PolyGraphs (locally) on your own machine,[^16] or (remotely) on a high performance computing (HPC) cluster,[^17] you will need to use the command line to create a virtual environment that contains it.[^18] As indicated above, we will do this using the source code manager, Git, as well as the package installer for Python, pip.

Instructions are slightly different for macs and machines running Linux, on the one hand, and for those running Windows on the other. Nevertheless, in each case, you will want to open the terminal, and use the command line to navigate to the directory in which you would like to install PolyGraphs, then run each of the instructions below, one at a time.

``` 
git clone https://github.com/alexandroskoliousis/polygraphs.git
cd polygraphs
python -m venv .venv
```

This uses git to copy the PolyGraphs source code, then navigates to the polygraphs directory created by doing so, and finally begins to create your PolyGraphs virtual environment.

The next step is to activate that environment. It differs, depending on your operating system. For Linux/macOS, the command is:

```
source .venv/bin/activate
```

By contrast, those on Windows should run:

```
.venv\Scripts\activate
```

Thereafter, all users should execute the following, one command at a time:

```
git switch ptgraph
pip install -e .
pip install jupyter
pip install seaborn
```

This ensures that your environment employs the correct version of the PolyGraphs code (that in the ptgraph branch of the GitHub repository); and it ensures that you have a version of Jupyter Lab that can access both the PolyGraphs code and the seaborn library (for data visualization).

### Running Simulations

PolyGraphs should now be installed, and your virtual environment should be activated (meaning that commands you run will be executed in the appropriate directory within your machine, and draw on the correct versions of the code you have installed). (If you are returning to this after a pause, you may need to open the command line, navigate to the polygraphs folder, and then run the relevant command above to 'activate' this environment once again.) Thus puts you in a position to use the software to run simulations in social epistemology!

#### Running the Test

Let us begin by running a test, to establish that the code is working properly:[^19]

```
python run.py -f configs/test.yaml
```

This tells your machine to interpret the file 'run.py' using python, and to supply the file 'test.yaml', stored in the sub-directory 'configs' as argument.

You should see the following printout:

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-1-02.png" alt="Image displaying text and numbers." caption="Figure 2. The printout from the PolyGraphs test run." %}

We can see here that we have run five simulations ('Sim #0005') and then printed 'Bye'.

We can also see, for each simulation: how many steps it ran for and how many seconds it took; that in each case action B was chosen in the end; that the result of the simulation was not undefined (the value here is 0, not 1); and that it converged, and was not polarized. 

Finally, we can see that, as each simulation runs, we get a readout out, at the first and last steps, and at every 100 steps in between, of how many thousands simulations steps are being completed every second, as well as what fraction of the nodes believe in taking action A vs B.

Having run this test, you should also be able to verify that a new directory called 'polygraphs-cache' has been created (outside of the 'polygraphs' folder), itself containing a 'results' sub-directory with a further sub-directory within it named for the current date. Inside that folder will be (further folders containing) all of the output data from simulations run on the date in question. In particular, (within the only such folder that exists at present) you should see:
* a .json file that records the settings of the various parameters used in these simulations
* a .csv file telling us, for each simulation, the same information as we saw printed out previously about action, etc. (though if we open this in our favourite spreadsheet software, we will see that the 1s and 0s have been converted to TRUEs and FALSEs), plus the name ('uid') of the folder containing the output data pertaining to that sim
* five .pt and five .hd5 files, one each for each of the five simulations.

It is this (synthetic) data that will get analyzed in part 2 of this lesson, and from which insights in social epistemology can be gleaned.

#### Configuration Files

We saw, when running the test, that the python script 'run.py' takes a .yaml (or .yml) file as argument. (Note that 'yaml' stands for 'yet another markup language', or alternatively 'YAML ain't markup language'. Be that as it may, it is simply a text file saved with the relevant extension name.) If you open the file 'test.yaml' in the 'configs' sub-directory of the 'polygraphs' directory (which you can do e.g. in notepad), you will see that it records the values of certain parameters determining what is being simulated. Here we comment on a select few.

{% include figure.html filename="en-or-polygraphs-philosophical-simulations-1-03.png" alt="Text containing lines numbered 1 to 20. Some lines contain comments. Others specify parameter names and their values, separated by a colon." caption="Figure 3. The configuration file for the PolyGraphs test run." %}

The value of the epsilon parameter in test.yaml is 0.01. This means that, where the chance that action A is successful is one half, or 0.5, the chance that B is successful is one half plus epsilon, or 0.51. This parameter makes a big difference to the outcomes of the simulations - feel free to manipulate this (by editing and saving the test configuration file), and observe the effects (e.g. by re-running the test with the new value recorded). 

We can see that network.kind is set to "complete": this means that all the nodes in the network the simulation runs on will be connected to one another by an edge. You will also see that network.size is set to 16, meaning that the network has 16 nodes (not 10, as erroneously claimed in the comment). Again, these parameter values make a big difference to the way the simulations behave, and you should feel free to experiment. Changing network sizes should be self-explanatory (just edit the number of nodes specified). When it comes to network kinds, you can see the range of built in options available in the 'graphs.py' file, located within the 'polygraphs' sub-directory of the 'polygraphs' folder. You can choose any of 'wheel', 'cycle', 'star', 'line', or 'grid' and run simulations on networks of these kinds without further ado. Some other network kind choices will, by contrast, require you to specify values of certain further parameters - as we will see in due course.

Crucially, which operation, or 'op', the simulation runs is a parameter in PolyGraphs which specifies how the agents in the model behave. In test.yaml the value of this parameter is (the string) 'BalaGoyalOp'. This tells us that agents communicate their observations competently and honestly, so that their reports are true (even if they turn out, by chance, to be misleading). It also tells us agents trust the information they receive from (themselves and) their neighbours. In part 2 of this lesson, we will analyze data from simulations run using different operations (which, as with certain network kinds, will require us to specify values for additional parameters, depending on the model).

There are, of course, other parameters whose values are specified in 'test.yaml'. Some of these (like init.kind) tell us how things are to be within a given simulation (in this case, the value is 'uniform', meaning that the intial beliefs of the agents in the model are to be chosen with an equal probability of falling anywhere in the [0-1] interval); others (like simulation.repeats) tell us how the computational job PolyGraphs is to do will be governed (in this case telling us that 5 simulations will be run, as we saw in the printout above - and not 10 as specified in the comment text). You can learn about the effects of these various parameters by experimenting, and/or reading the academic literature that uses these models; and if all else fails, you can reach out to the authors and ask! 

#### Loading Graph Datasets

One thing that is likely to be of interest to new users of PolyGraphs is the ability to load graph datasets specifying the structure of some target community of interest. 

You can easily load a graph dataset, if you have a file containing it written in the graph markup language (.gml) format. To do this, in your configuration file you simply specify network.kind to be 'gml', and then add two further parameters (and their values): network.gml.name (a string giving the name of your graph); and network.gml.path (also a string, this time specifying the path to your .gml file).

```
network.kind: 'gml'
network.gml.name: 'graph_name'
network.gml.path: 'path_to_file.gml'
```

Of course, you may not have a .gml file containing the graph of the community you wish to study. But you can create one, if you have what is known as an edge list, specifying which nodes are connected to which others. Make sure that you name your nodes as integers (i.e. whole numbers)! [^20]

## Conclusion

In part 1 of this lesson, we have seen how to run philosophical simulations using PolyGraphs. In particular, we have covered how PolyGraphs uses agent-based modelling, treating communities of inquiring agents as networks of (or graphs comprising) nodes (standing for persons), connected by edges (serving as channels of communication), to generate synthetic data about community members' beliefs for subsequent analysis. We have seen how to install PolyGraphs; we have run a test, and seen both what output data there is, and where it is stored; we have also looked at the configuration files (such as test.yaml) that specify the values of various parameters, and how to create these; and finally, we have looked at how to load your own graph dataset.

In part 2, we will turn to the question of how to analyze the synthetic data that PolyGraphs generates, so as to understand how communities form opinions over time.

## Endnotes
[^1]: See the PolyGraphs [project website][1], as well as the associated [GitHub repository][2] for further information.
[^2]: The term ‘philosophical simulations’ was coined in Ball, B., Koliousis, A., Mohanan, A., & Peacey, M. (2024). Computational philosophy: reflections on the PolyGraphs project. Humanities and Social Sciences Communications, 11(1), 1-9.  
[^3]: Synthetic data is data that is not input manually, or recorded through sensors, but instead is the result of computations that generate it.
[^4]: For an overview of social epistemology, see O’Connor, Cailin, Sanford Goldberg, and Alvin Goldman, "Social Epistemology", The Stanford Encyclopedia of Philosophy (Summer 2024 Edition), Edward N. Zalta & Uri Nodelman (eds.), URL = <https://plato.stanford.edu/archives/sum2024/entries/epistemology-social/>.
[^5]: The paper cited above by Ball et al. (2024), for example, reproduces findings to the effect that greater communication between scientists leads to faster, but less reliable, epistemic decisions. These results were first reported in Zollman, K. J. (2007). The communication structure of epistemic communities. Philosophy of science, 74(5), 574-587.
[^6]: Ball, B., Koliousis, A., Mohanan, A., & Peacey, M. (forthcoming). Ignorance in Social Networks: Discount Delays and Shape Matters. In Kaminski et al. (eds.), Trust and Disinformation, Springer. This paper makes use of models of distrust presented in O'Connor, C., & Weatherall, J. O. (2019). The misinformation age: How false beliefs spread. Yale University Press. 
[^7]: Ball, B., Gore, T., Mohanan, A., Weber, M., and West, P. (manuscript). Margaret Cavendish and the Royal Society: A Computational Case Study of Early Modern Intellectual Networks.
[^8]: Ball, B., Koliousis, A., Mohanan, A., & Peacey, M. (2024). Misinformation and higher-order evidence. Humanities and Social Sciences Communications, 11(1), 1-12.
[^9]: Jascha Schmitz, Malte Vogl, Aleksandra Kaye, and Raphael Schlattmann, "Simulating Historical Communication Networks in Python," Programming Historian 14 (2025), https://doi.org/10.46430/phen0122.
[^10]: See previous notes for references.
[^11]: We can also impose a limit on the number of steps for which a simulation will run: we have chosen 100,000 steps in the data analyzed in part 2.
[^12]: William J. Turkel and Adam Crymble, "Python Introduction and Installation," Programming Historian 1 (2012), https://doi.org/10.46430/phen0009.
[^13]: Python is an object-oriented language. Object and class are therefore central notions. Classes are, in effect, ‘blueprints’ for constructing objects. These ‘blueprints’ can themselves be copied and rendered more specific through a mechanism known as inheritance. There is a nice explanation of object-oriented programming in Python, including class inheritance, available at https://www.w3schools.com/Python/python_oop.asp. 
[^14]: Apple ships a version of [Git with Xcode Command Line Tools][8] which you can install with:
```
xcode-select --install
Debian/Chromebooks
sudo apt update
sudo apt install git
```
See the [installation instructions for Linux][9] on the git website for other distributions.
If you are working in Windows, download and install [Git for Windows][10]. This includes Git Bash, which add a bash shell for Windows. When it asks whether you would like to use a credential manager, select none. Otherwise, everything else should be the default option.
[^15]: That said, you can run PolyGraphs simulations in e.g. Google Colab if you wish - see below.
[^16]: Note that, if you are able to access the internet, and have a gmail account, it is possible to install and run the PolyGraphs code in Google colab. To do this, go to https://colab.google.com and open a new notebook (.ipynb file). You then need to run the following commands in the opening cell(s):
```
!git clone https://github.com/alexandroskoliousis/polygraphs.git
%cd polygraphs
!git switch ptgraph
!pip install -e .
```
This should suffice to have the PolyGraphs source code available to you for use in Colab. If you have done this, you can skip ahead to Running the Test.
[^17]: A high performance computing cluster is a collection (or network) of (interconnected) computers that facilitates the efficient performance of large-scale computations. Although we will not discuss how to exploit this feature of PolyGraphs, it is a virtue of the code package that it is amenable for use in such contexts. Indeed, the dataset that we will share for analysis in part 2 was generated on such a facility.
[^18]: A virtual environment is simply an isolated directory, or folder, on your computer that contains a particular version of a programming language (in our case, Python), along with its various dependencies.
[^19]: If you are operating in Colab, add an exclamation mark at the start of the line.
[^20]: Of course, we are not yet operating within an interactive Python environment - we will explain how to do that in part 2; but once you are in such an environment, the following code shows proof of concept for how to build a graph dataset in .gml format that can be used within PolyGraphs:
```
import networkx as nx
G = nx.Graph()
edgelist = [(1, 2), (2, 3)]
G.add_edges_from(edgelist)
nx.write_gml(G, 'test.gml')
```
A fully developed example is also available on the PolyGraphs GitHub repository [here][11]. 

[1]: https://polygraphs.sites.northeastern.edu
[2]: https://github.com/alexandroskoliousis/polygraphs
[3]: https://numpy.org/
[4]: https://pandas.pydata.org/
[5]: https://matplotlib.org/
[6]: https://networkx.org/documentation/stable/index.html
[7]: https://seaborn.pydata.org/
[8]: https://developer.apple.com/documentation/xcode/installing-the-command-line-tools
[9]: https://git-scm.com/install/linux
[10]: https://gitforwindows.org/
[11]: https://github.com/alexandroskoliousis/polygraphs/blob/main/scripts/sixdegreesoffrancisbacon.ipynb
