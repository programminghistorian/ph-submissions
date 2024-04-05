---
title: "Simulations in Historical Research: How to Create an Agent-Based Model of Communication Networks"
slug: agent-based-model-communication-networks
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Jascha Schmitz
- Malte Vogl
reviewers:
- Forename Surname
- Forename Surname
editors:
- Agustín Cosovschi
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/605
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}


### Overview
In this lesson, we want to give you an introduction to the simulation method of Agent-based Modeling (often abbreviated ABM) via the example of an Agent-based model based on a historical letter sending network, implemented with the python-package 'mesa'.

In the first part, you will learn what historical simulation methods are all about, what their methodological and epistmeological quirks are, and how to start applying Agent-based Modeling for your own research needs.

In the second part, you can follow a step-by-step guide to build your first Agent-based Model with 'mesa', based on letter network data. This will be accompanied by further comments and reflections on the methoodlogy of Agent-based Modeling.

The case study will use openly available letter data from the period of the 'Republic of Letters', sourced from the [LetterSampo](https://lettersampo.demo.seco.cs.aalto.fi/en)-project (more on that below). The model which we will build together will incorporate some basic interactions like letter sending that lead to correspondence networks similar to those observed in the data-set. The goal of this (very basic) model is to better understand the social dynamics of correspondence networks and how those shape which letters survive until today and which are destroyed or forgotten over time. It won't be sufficiently complex to give genuinely valuable perspectives on this research goal, but it will highlight some key properties of Agent-based Modeling and ways to implement them. By the end of this lesson, you will be able to extend the model further with more complex functionalities.

We will also mention alternative approaches to the data as well as Agent-based Modeling applications for research areas and data types other than letter networks. In any case, the technical basics we teach about 'mesa' will be of use to you, even if you don't work with letters or networks in general!

---
---

### Lesson Goals Summarized
This lesson intends to:
- teach conceptual basics of simulation methods and 'Agent-based Modeling' for historians,
- teach fundamentals of the python-package 'mesa' for programming Agent-based Modeling,
- give you guidance and resources for extending your Agent-based Modeling knowledge beyond this tutorial, as well as
- give an overview over methodological and epistemological caveats, challenges, and things to think about when programming your own historical Agent-based Modelings.

Users of different skill levels and interests will find this lesson useful, for example if:
- you are completely unfamiliar with simulation methods and Agent-based Modeling and want a thorough introduction,
- you already know about Agent-based Modeling conceptually and are wondering whether it can be useful for your own research project,
- you already know that Agent-based Modeling might be useful for your research and now want to learn about how the process of modeling and technical implementation of an Agent-based Modeling can work,
- you are familiar with all of the above and need a starting point for implementing Agent-based Modelings with 'mesa'.

---
---

### Technical Requirements

For this lesson, only mesa and its dependencies are necessary. Of course, for your own research, you can use other libraries such as pandas or numpy to transform your data. Mesa should be compatible with other python libraries in almost all cases.

Execute the following code block to install mesa and its dependencies. If you want to follow through the tutorial on your local machine, you need to set up an environment with mesa installed. If you don't know how to do this, we have a simple [step-by-step instruction](https://gitlab.gwdg.de/modelsen/Agent-based Modeling-workshop-setup-instructions), which we compiled for a workshop.

If you already have Python installed, running the following code in a terminal should give you a new virtual environment with the mesa package:

```
python3 -m venv env
source env/bin/activate
pip install mesa
```

If you would like to have a more gentle and comprehensive introduction, head over to the tutorial introducing [Python](https://programminghistorian.org/en/lessons/introduction-and-installation).

try:
  import mesa
except:
  !pip install mesa

## Part 1: Introduction to Simulations and Agent-based Modeling
Before we dive into the technical side of Agent-based Modeling, we want to give you some background on what Simulation and Agent-based Modeling is about, what it has to offer for historical research, and how it might relate to your research!

### 1.2: What is Simulation?


Simulation describes a number of different methods of model-based, experimental reproduction of a real-world or hypothetical process or system.

The basis of every simulation is an executable simulation model. This is a class of models - similar to data models - that can be expressed conceptually, logically or mathematically. To execute a simulation model, however, it must be formalized, i.e., converted into a computer-readable form. In addition, simulation models are created iteratively and sometimes interactively. Experimenting with the parameters and properties of the model is an important part of simulation methods.

The process of building a simulation model is constantly cycling between phases of running the model, interpreting the results and then adapting the model for further experiments. This way, simulation methodology is  comparable to the hermeneutic circle of heuristics, critique, and interpretation.

Part of a simulation can be a visualization or a user interface that makes the simulation process readable or even interactive for the user and displays the results of the simulation in real-time.

In the historical sciences, simulations are used partly as an analytical tool with clearly stated research goals, partly as a didactic tool for interactive and immersive teaching, and they are themselves the subject of research, for example in the history of science, philsophy of history or in media/games history.

In this lesson, we talk about historical simulations, by which we mean analytical simulations that have a specifically historical research interest or make extensive use of historical source material.

Historical simulations have been around for a perhaps surpring amount of time, as far as we currently know at least since the 1960s. Some of the earlier historical simulations were done by prominent figures of the early digital humanities and digital history, such as Michael Levison or Peter Laslett of the Cambridge Group for ... . The latter also coined this simulative approach to history "experimental history", to underline the experimental, iterative and nature of the process.

#### (as info box) Some examples of historical simulation history
Here are some examples of different historical simulation projects of the last years:
- Peter Laslett's Statistical Studies in Historical Population Studies
- Tom Brughmans on Ancient Roman Economy and Trade
- Innovation Diffusion

### 1.2: What is Agent-based Modeling?

Agent-based modeling (Agent-based Modeling for short) is a simulation method where relations and interactions of individual entities, for example humans, organizations, items, etc., with each other and with their environment are simulated. Ideally, these interactions make some emergent patterns appear, meaning they are not prescribed in the simulation, but dynamically arise out of the system. A common and fascinating example for this comes from biology, where ant colonies show some remarkable emergent properties. Ants on their own have no behavioral process or central governing body that tells them to form big communal structures, practice husbandry or wage war - in fact, on their own, they are quite unintelligent. Yet, collectively, they exhibit all these sophisticated behaviors. Their behavioral tendency to form hierarchical states, care for and "milk" aphids or go after competitors in an organized way emerges from their highly complex chemical interactions with each other.

The similarity in these emergent phenomena to human practices is hopefully quite clear. Humans of course are noticeably more intelligent than individual ants and our practices and the associated phenomena are often quite a bit more complicated. The emergence of similar phenomena in human activity and behavior pose a number of questions that are of central interest and feature much debate in history. Historians deal with those kinds of questions all the time, such as: how and why did a society change, why did some states get the upper hand over others in some time frame, how did some new technology or idea spread from one group of people to another? Agent-based Modeling offers the opportunity to formally and systematically pursue these kinds of questions by building models of the pertaining case study and experiment with that model.

info box: more concrete examples of historical Agent-based Models and what topics/questions they are on

Agent-based modeling is a form of individual-based (sometimes also called micro-level) approach that differs from equation-based (or macro-level) approaches, in which only macro processes and at most aggregated groups of actors are modeled, not single agents or individuals {cite}davidsson_types_2017. Agent-based modeling differs from other micro-level approaches as well, in that each agent is "explicitly and individually represented in the model" and the intensity and variability of the interaction between the agents is particularly high. Apart from this explicit, individual representation, "no further assumptions are made." {cite}galan_checking_2017.

While mathematics can still play a major role in it, Agent-based Modeling is not as dependent on equations as other approaches and hence is more flexible. Purely mathematical approaches, while very effective for certain applications, are limiting in a number of ways that are especially relevant for history. Some of the aspects that are much harder to model mathematically rather than with Agent-based Modeling are agent heterogeneity, interdependencies between processes, out-of-equilibrium dynamics, local interactions, the role of physical space and finally the micro-macro link, so how macro-level phenomena are interconnected to individual behavior {cite}epstein_growing_1996.

To summarize, the goal of this method is to link the emergent patterns and phenomena at the systemic macro-level with the individual micro-level behavior of interacting entities, the name-giving "Agents". The focus are often rather the regularities and patterns in history than any unique case on its own.

### 1.3: Brief Historical Context of Agent-based Modeling

Agent-based Modeling was conceived as a separate simulation method during the 1990s, pioneered among others by Robert Axtell... . Similar, individual-based simulation approaches have existed for at least the 1960s, though. Tim Gooding puts the origins of Agent-based Modeling at 1933, when Enrico Fermi first used the so-called Monte-Carlo-Method with mechanical computing machines (Agent-Based Model History and Development, 2019).

A number of distinguishing factors and changes since then: increase in power of hardware + affordability of higher perfomances, object-oriented programming languages / PLs specifically designed for Agent-based Modeling (such as NetLogo), complex adaptive systems thought / in particular phenomenons of emergence and adaptation/learning, coupling of macro and micro levels, emphasis on heterogeneity of actors, emphasis on theory-agnosticism. Historical Agent-based Modelings, ie., Agent-based Modelings that try to model historical processes, were part of the method community from the start, although often without the participation of actual historians. Mostly sociologists, economists, or other social and natural scientists that worked also with historial data. Exception are Archaeologists, which adopted the method also quite early and developed an active community. In historical science itself, until now only sporadic and often exploratory application, although a noticeable uptick of Agent-based Modeling research and general interest in simulation methods for historians in recent years. Discussions around the prerequisites of applying Agent-based Modeling for historical research are still ongoing, and there is also some fundamental pushback by some scholars, but .... the discussion is becoming more and more constructive, concentrating the scholarly effort on how to make the method increasingly useful for historians .....

### 1.4: Fundamentals of Agent-based Modeling for Historians

In this section we want to go into more detail what Agent-based Models are about, what kind of research questions they are trying to help with and what some central methodological and epistemological elements of them are and how those relate to historical inquiry.

#### 1.4.1 What are Historical Agent-based Models?

As we explained in the previous section, Agent-based Modeling is "particularly well suited to exploring how the aggregate characteristics of some system arise from the behaviour of its parts (Lake 2015). Agent-based Modeling is used to understand how the interaction of parts over time dynamically form a whole, i.e., the characteristics of a system, and how that system influences its parts in turn. Agent-based Modeling is less about establishing clear-cut, one-way causalities (although those may also play an important part) but more about uncovering complex webs of mutual influences, sometimes called 'feedbacks' or 'feedback loops'.

We want to give you a couple of examples of what historically motivated questions with possible Agent-based Modeling application might look like:
  - How could changing climate conditions during the small ice age have influenced the interactions of brandenburgian peasants with their environment? Where they able to continue previous practices of extraction? Did they change them, and if yes, how, under which individual, economic, social, and environmental conditions? What change in these interactions could have led to the abandonment or continued survival of villages?
  - How did the changes in the built environment after Haussmann's 'renovation of Paris' influence the mobility of Parisians of different quarters? How do the effects on individual mobility compare to similar urban restructuring in London, Berlin, or other cities? How might different groups of people have adapted? Where subsequent urban building decisions more a reaction to the resulting mobility deficits / demands of citizens, or rather driven by policy visions (e.g., car-friendly cities in later decades)
  - What structural changes and individual decisions by farmers have led to the widespread adoption of high-intensive farming (i.e., machinization, motorization, and chemization of farming)? Was one of those more impactful than the other, e.g., were farmers 'forced' into it or did they push the structural changes by pioneering the technology? If the latter, what could be the reasons?

As you can see, all of these questions revolve around interactions of systemic changes (like climate, policy, or economy) and individual decisions (choosing how to extract resources from nature, choosing a mobility mode, choosing a farming practice). These kinds of questions are not necessarily typical of todays historical sciences, especially for those which concentrate on the micro-perspective of particular individuals. It won't be possible to make an Agent-based Model of, for example, the decisions of the individual Henry V. or, say, the life of one particular nun at a particular monastery - at least none that has a lot of use for answering a research question.

While they do emphasise heterogeneity in a group of individual actors, Agent-based Models do deal in aggregates and abstractions of people. This is because a model of anything must be a simplification of the real thing (or person). The crucial part is to choose all those elements of a thing or a person that are the most relevant in the processes the researcher is interested in. The end result of a historical Agent-based Modeling will always be one of many possible, narrowed down perspectives on history, not a perfectly complex, 1-to-1 reconstruction of historical reality. In that, Agent-based Modeling mirrors the hermeneutical process of interpretation in traditional historical science, a point we will elaborate on in the next section.

For that reason, it would be a misconception to characterize this approach as merely reductionist, as some historians have cautioned in the past - because at the same time, as hinted at above, fundamental for Agent-based Modeling (and its epistemological parent, systems science) is also the acknowledgement that any complex system will inherently be irreducible to just attributes of their parts, i.e., be explained just by that. This core concept of 'emergence' is a radically anti-reductionst view on reality a majority of historians probably share at least implicitly.

#### 1.4.2 Why do Agent-based Modeling in history?
The general description of Agent-based Modeling might have given you an idea already why this method might be of interest for historians. We already hinted in the end of the last section that the similarities on a methodological and even epistemological level to historical research can be rather striking. But we want to elaborate on some of those points and give you some more concrete arguments for how and why Agent-based Models can be useful for us historians.

**1) Modeling (Complex) Dynamics and Processes of History**
    
Agent-based Modeling pushes into a gap that other currently discussed digital humanities methods leave open, which are often concerned with static data and not the dynamics that connect different data points. A lot of historical inquiry however is revolving around dynamical, complex situations that change over time, as well as around corresponding questions of why and how these situations occurred in a specific way. Current DH methods and purely hermeneutic historical research, too, are not well equipped to model or analyze such time-sensitive dynamics of complex historical systems in a stringent and reproducible way.

**2) Modeling heterogenous historical agents**
    
Agent-based Modeling allows a huge amount of variability and freedom in modeling the behavior and interactions of agents. This makes Agent-based Modeling appealing for historians, who traditionally put a lot of emphasis on complex and creative behavior of human agents. That focus sets Agent-based Modeling apart from solely mathematical simulation methods which are usually less or even *un*able to model heterogeneous individual behavior, as explained briefly above.
    
**3) Theory-agnostic modeling of historical behaviors**
    
Agent-based Modeling makes it possible to model assumptions and theories about past behavior of diverse sets of agents with a diverse set of possible interactions. Contrary to a common conception, these assumptions and theories are not limited to a rational-choice paradigm at all (although there exists a large body of research using it for Agent-based Modeling). Of course, the formal modeling of behavior sets technical boundaries to the types of theories that can be represented, so the actual degree of freedom to use a specfic theory needs to be determined in practice.

**4) Extensive body of research in adjacent fields**
    
Not only might this method give a unique perspective to history, it is also tried and tested in many research fields adjacent to history, such as Archaeology, Sociology, Philosophy, or Economics. Especially the first field, Archaeology, has a lot to offer in terms of methodological and epistemological discussions, lessons learned, and specific application questions. A good place to get familiar with some discussions of Agent-based Modeling in Archaeology that are of interest for historians might be {cite}`wurzer_agent-based_2015`.

**5) Similarity to Hermeneutic Methodology**

*In this subsection, we will spend some time to discuss differences and similarities both in methodological and epistemological regards in relation to the more commonplace hermeneutic approaches to history.*

- DIFF: strict formalization of concepts / people / behavior!
- SIM: iterative, interpretative modeling -> "hermeneutic figure-8" (Gavin 2015)
- SIM/DIFF: counter-factuals (ie., mental hypothesizing), but explicated and testable
- DIFF: experiments!
- ...

#### 1.5 Key technical concepts of Agent-based Models

In this section, we will to go over some central concepts that are used in our case study in the next section, and any Agent-based model for that matter.

- Agents
- model(ing)
- space(es)
- time
- data collection and "simulated" or "synthetic data"
- running many iterations with differerent parameters: Experimentation

# Part 2: Programming Agent-based Models with Mesa
### 2.2 Case Study - An Agent-based Modeling of the Republic of Letters

Case Study Goals, Data, general Information

- Republic of Letters, where, when?
-## (2.2.2?)what kind of data, where does it come from?
- whats the research goal?
- why Agent-based Modeling for this?
- what other goals could be achieved with this data and Agent-based Modeling?
- what could NOT be done with Agent-based Modeling and this data?
- (other possible applications of Agent-based Modeling for typical historical data beyond this case study)
- Outline of what will be modeled in this tutorial, and what is left out


# Part II: Case Study and Introduction to Mesa

This chapter is partly based on the official tutorials of [Mesa](https://mesa.readthedocs.io). We have adapted it to suit the needs of this lesson and to the data-set at hand.



### 2.1 Overview of Mesa

In this tutorial we will make use of `mesa`, an open-source Agent-based Modeling framework written in Python. Mesa offers predefined functions to implement the key ingredients of an Agent-based Modeling. The package is in development since 2015 and has aquired a large community of users and contributors [LINK]. Its relative longevity and popularity makes it a good choice to start using Agent-based Modeling.

If you are more familiar with other programming languages, you can consider applying the ideas of this tutorial, e.g., in the frameworks [NetLogo (a dedicated Agent-based Modeling language)](https://ccl.northwestern.edu/netlogo/) or [MASON (based on Java)](https://cs.gmu.edu/~eclab/projects/mason/).

In `mesa` a minimal Agent-based Modeling implementation consists of a definition of an "agent" class and a "model" class. The "model" class holds the model-level attributes (for example attributes of the environment or other external factors), manages the agents, and generally handles the global processing level of our model.

Each instantiation of the model class will be a specific model run. Each model will contain multiple agents, all of which are instantiations of the agent class. Both the model and agent classes are child classes of Mesa’s generic model and agent classes. In line with the above introduced idea of *individual-based* modeling, each agent should have a unique id to allow tracking during the simulation.

Another important aspect of mesa is the `scheduler`. The scheduler keeps track of which agent should act when. This process is called "activation" in the terms of mesa, and there are a number of predifined activation procedures: random, simultaneous, or staged activation. For this tutorial we will make use of random activation, meaning that all agents act one after another, but the order is random at each new step of the model.

Some research questions might require the agents to interact in/with a `space`. This could be a geographical space or something more abstract. Sometimes, like in this tutorial, a simple abstracted representation of relative distance is sufficient, for example in form of a two-dimensional *grid*. Mesa also supports hexagonal, continues or network grids, which are useful for e.g. covering a geographical space or simulating social relations. If a simulation relies on geographical map projections, an additional package from the mesa project might be useful: [mesa-geo](https://github.com/projectmesa/mesa-geo).

# Model description

The tutorial model is a very simple simulated agent-based letter network. The rules of our tutorial model:

1. There are some number of agents.

2. All agents begin with 0 letters.

3. At every step of the model, an agent sends a letter to some other agent, based either on randomness or distance to the other agents.

Let’s get started!

"""To start with, let's import the mesa module"""
import mesa

## Setting up the model
To begin writing the model code, we start with two core classes: one for the overall `model`, the other for the `agents`. The model class holds the model-level attributes, manages the agents, and generally handles the global level of our model. Each instantiation of the model class will be a specific model run. Each model will contain multiple agents, all of which are instantiations of the agent class. Both the model and agent classes are child classes of Mesa’s generic [Model and Agent classes](https://mesa.readthedocs.io/en/stable/apis/init.html).

This is seen in the code with `class LetterModel(mesa.Model)` or `class LetterAgent(mesa.Agent)`.

For now, each agent has only two variables: how much letters it currently has sent and received. Each agent will also have a unique identifier (i.e., a name), stored in the `unique_id` variable. Giving each agent a unique id is a good practice when doing agent-based modeling.

There is only one model-level parameter: how many agents the model contains. When a new model is started, we want it to populate itself with the given number of agents.

The beginning of both classes looks like this:
class LetterAgent(mesa.Agent):
    """An agent with a fixed amount of initial letters, namely 0."""

    def __init__(self, unique_id, model):
        super().__init__(unique_id, model)
        self.letters_sent = 0
        self.letters_received = 0


class LetterModel(mesa.Model):
    """A model with some number of agents."""

    def __init__(self, N):
        self.num_agents = N
        # Create N number of agents
        for i in range(self.num_agents):
            a = LetterAgent(i, self)


## Adding the scheduler

Time in most agent-based models moves in steps, sometimes also called ticks. At each step of the model, one or more of the agents – usually all of them – are activated and take their own step, changing internally and/or interacting with one another or the environment.

The scheduler is a special model component which controls the order in which agents are activated. For example, all the agents may activate in the same order every step, their order might be shuffled, we may try to simulate all the agents acting at the same time, and more. Mesa offers a few different built-in scheduler classes, with a common interface. That makes it easy to change the activation regime a given model uses, and see whether it changes the model behavior. This may not seem important, but scheduling patterns can have an impact on your results [Comer2014].

For now, let's use one of the simplest ones: `RandomActivation`*, which activates all the agents once per step, in random order. Every agent is expected to have a ``step`` method. The step method is the action the agent takes when it is activated by the model schedule. We add an agent to the schedule using the `add` method; when we call the schedule's `step` method, the model shuffles the order of the agents, then activates and executes each agent's ```step``` method.

*Unlike `mesa.model` or `mesa.agent`, `mesa.time` has multiple classes (e.g. `RandomActivation`, `StagedActivation` etc). To ensure context, time is used in the import as evidenced below with `mesa.time.RandomActivation`.  You can see the different time classes as [mesa.time](https://github.com/projectmesa/mesa/blob/main/mesa/time.py).

With that in mind, the model code with the scheduler added looks like this:
class LetterAgent(mesa.Agent):
    """An agent with a fixed amount of initial letters, namely 0."""

    def __init__(self, unique_id, model):
        super().__init__(unique_id, model)
        self.letters_sent = 0
        self.letters_received = 0

    def step(self):
        # The agent's step will go here.
        # For demonstration purposes we will print the agent's unique_id
        print("Hi, I am agent " + str(self.unique_id) + ".")

class LetterModel(mesa.Model):
    """A model with some number of agents."""

    def __init__(self, N):
        self.num_agents = N
        self.schedule = mesa.time.RandomActivation(self)
        # Create N number of agents
        for i in range(self.num_agents):
            a = LetterAgent(i, self)
            self.schedule.add(a)

    def step(self):
        """Advance the model by one step."""
        self.schedule.step()

At this point, we have a model which runs – it just doesn’t do anything. You can see for yourself with a few easy lines:

empty_model = LetterModel(10) # create a model with 10 agents
empty_model.step() # execute the step function once

## Agent Step

Now we just need to have the agents do what we intend for them to do: send each other letters.

To allow the agent to choose another agent at random, we use the `model.random` random-number generator. This works just like Python’s `random` module, but with a fixed seed set when the model is instantiated, that can be used to replicate a specific model run later.

To pick an agent at random, we need a list of all agents. Notice that there isn’t such a list explicitly in the model. The scheduler, however, does have an internal list of all the agents it is scheduled to activate.

With that in mind, we rewrite the agent `step` method, like this:

class LetterAgent(mesa.Agent):
    """An agent with a fixed amount of initial letters, namely 0."""

    def __init__(self, unique_id, model):
        super().__init__(unique_id, model)
        self.letters_sent = 0
        self.letters_received = 0

    def step(self):

        other_agent = self.random.choice(self.model.schedule.agents)
        other_agent.letters_received += 1
        self.letters_sent += 1


## Running your first model

With that last piece in hand, it’s time for the first rudimentary run of the model. Let’s create a model with 10 agents, and run it for 10 steps.

model = LetterModel(10)
for i in range(20):
    model.step()

Next, we need to get some data out of the model.
Specifically, we want to see how many letters each agent sent and received. We can get the letters values with list comprehension, and then use `matplotlib` (or another graphics library) to visualize the data in a histogram.

# import matplotlib for our visualization
import matplotlib.pyplot as plt


plt.show()

#agent_letters_sent = [a.letters_sent for a in model.schedule.agents]
agent_letters_recd = [b.letters_received for b in model.schedule.agents]

#plt.hist(agent_letters_sent)
plt.hist(agent_letters_recd)

You’ll should see something like the distribution above. Yours will almost certainly look at least slightly different, since each run of the model is random and unique, after all.

To get a better idea of how a model behaves, we can create multiple model runs and see the distribution that emerges from all of them. We can do this with a nested for loop:

all_letters = []

# This runs the model 100 times, each model executing 10 steps.
for j in range(100):
    # Run the model
    model = LetterModel(10)
    for i in range(10):
        model.step()

    # Store the results
    for agent in model.schedule.agents:
        all_letters.append(agent.letters_received)

plt.hist(all_letters, bins=range(max(all_letters) + 1))

This runs 100 instantiations of the model, and runs each for 10 steps. (Notice that we set the histogram bins to be integers, since agents can only have whole numbers of letters). This distribution looks a lot smoother. By running the model 100 times, we smooth out some of the ‘noise’ of randomness, and get to the model’s overall expected behavior.

For now, the letter distribution looks pretty normal in a mathematical sense, because it is basically random. These results are not too surprising, yet. Let's add some more comparably realistic behavior by introducing space between the agents and let that influence the letter sending decision.

## Adding space

Many ABMs have a spatial element, with agents moving around and interacting with nearby neighbors. Mesa currently supports two overall kinds of spaces:
`grid`, and `continuous`. Grids are divided into cells, and agents can only be on a particular cell, like pieces on a chess board. Continuous space, in contrast, allows agents to have any arbitrary position. Both grids and continuous spaces are frequently toroidal, meaning that the edges of this 'world' wrap around, with cells on the right edge connected to those on the left edge, and the top to the bottom. This prevents some cells having fewer neighbors than others, or agents being able to go off the edge of the environment.

Let’s add a simple spatial element to our model by putting our agents on a grid and make them walk around at random. Instead of sending a letter to any random agent, they’ll give it to an agent on the same cell. We could imagine that this represents them being close enough to know of one another and have reason to send a letter in the first place.

Mesa has two main types of grids: `SingleGrid` and `MultiGrid`*. `SingleGrid` enforces at most one agent per cell; `MultiGrid` allows multiple agents to be in the same cell. Since we want agents to be able to share a cell, we use `MultiGrid`.

*However there are more types of space to include `HexGrid`, `NetworkGrid`, and the previously mentioned `ContinuousSpace`. Similar to `mesa.time` context is retained with `mesa.space.[enter class]`. You can see the different classes as `mesa.space`.

We instantiate a grid with width and height parameters, and a boolean as to whether the grid is toroidal. Let’s make width and height model parameters, in addition to the number of agents, and have the grid always be toroidal. We can place agents on a grid with the grid’s `place_agent` method, which takes an agent and an (x, y) tuple of the coordinates to place the agent.

class LetterModel(mesa.Model):
    """A model with some number of agents."""

    def __init__(self, N, width, height):
        self.num_agents = N
        self.grid = mesa.space.MultiGrid(width, height, True)
        self.schedule = mesa.time.RandomActivation(self)

        # Create agents
        for i in range(self.num_agents):
            a = LetterAgent(i, self)
            self.schedule.add(a)

            # Add the agent to a random grid cell
            x = self.random.randrange(self.grid.width)
            y = self.random.randrange(self.grid.height)
            self.grid.place_agent(a, (x, y))

Under the hood, each agent’s position is stored in two ways: the agent is contained in the grid in the cell it is currently in, and the agent has a `pos` variable with an (x, y) coordinate tuple. The `place_agent` method adds the coordinate to the agent automatically.

Now we need to add to the agents’ behaviors, letting them move around and only send letters to other agents in the same cell.

First, let’s handle movement, and have the agents move to a neighboring cell. The grid object provides a `move_agent` method, which, like you would imagine, moves an agent to a given cell. That still leaves us to get the possible neighboring cells to move to. There are a couple ways to do this. One is to use the current coordinates, and loop over all coordinates +/- 1 away from it. For example:

```python
neighbors = []
x, y = self.pos
for dx in [-1, 0, 1]:
    for dy in [-1, 0, 1]:
        neighbors.append((x+dx, y+dy))
```


But there’s an even simpler way, using the grid’s built-in `get_neighborhood` method, which returns all the neighbors of a given cell. This method can get two types of cell neighborhoods: [Moore](https://en.wikipedia.org/wiki/Moore_neighborhood) (includes all 8 surrounding squares), and [Von Neumann](https://en.wikipedia.org/wiki/Von_Neumann_neighborhood) (only includes the 4 top, bottom, left and right neighboring squares). It also needs an argument as to whether to include the center cell itself as one of the neighbors.

With that in mind, the agent’s move method looks like this:

```python
class LetterAgent(mesa.Agent):
   #...
    def move(self):
        possible_steps = self.model.grid.get_neighborhood(
            self.pos,
            moore=True,
            include_center=False)
        new_position = self.random.choice(possible_steps)
        self.model.grid.move_agent(self, new_position)
```

Next, we need to get all the other agents present in a cell, and sent them a letter. We can get the contents of one or more cells using the grid's `get_cell_list_contents` method, or by accessing a cell directly. The method accepts a list of cell coordinate tuples, or a single tuple if we only care about one cell.

```python
class LetterAgent(mesa.Agent):
    #...
    def send_letter(self):
        cellmates = self.model.grid.get_cell_list_contents([self.pos])
        if len(cellmates) > 1:
            other = self.random.choice(cellmates)
            other.letters_received += 1
            self.letters_sent -= 1
```

And with those two methods, the agent's ``step`` method becomes:

```python
class LetterAgent(mesa.Agent):
    # ...
    def step(self):
        self.move()
        self.send_letter()
```

Now, putting that all together should look like this:

class LetterAgent(mesa.Agent):
    """An agent with letters sent and received."""

    def __init__(self, unique_id, model):
        super().__init__(unique_id, model)
        self.letters_sent = 0
        self.letters_received = 0

    def move(self):
        possible_steps = self.model.grid.get_neighborhood(
            self.pos, moore=True, include_center=False
        )
        new_position = self.random.choice(possible_steps)
        self.model.grid.move_agent(self, new_position)

    def send_letter(self):
        cellmates = self.model.grid.get_cell_list_contents([self.pos])
        if len(cellmates) > 1:
            other_agent = self.random.choice(cellmates)
            other_agent.letters_received += 1
            self.letters_sent += 1

    def step(self):
        self.move()
        self.send_letter()


class LetterModel(mesa.Model):
    """A model with some number of agents."""

    def __init__(self, N, width, height):
        self.num_agents = N
        self.grid = mesa.space.MultiGrid(width, height, True)
        self.schedule = mesa.time.RandomActivation(self)
        # Create agents
        for i in range(self.num_agents):
            a = LetterAgent(i, self)
            self.schedule.add(a)
            # Add the agent to a random grid cell
            x = self.random.randrange(self.grid.width)
            y = self.random.randrange(self.grid.height)
            self.grid.place_agent(a, (x, y))

    def step(self):
        self.schedule.step()

Let's create a model with 50 agents on a 10x10 grid, and run it for 20 steps.

model = LetterModel(50, 10, 10)
for i in range(20):
    model.step()

Now let's use `matplotlib` and `numpy` to visualize the number of agents residing in each cell. To do that, we create a numpy array of the same size as the grid, filled with zeros. Then we use the grid object's `coord_iter()` feature, which lets us loop over every cell in the grid, giving us each cell's coordinates and contents in turn.

import numpy as np

agent_counts = np.zeros((model.grid.width, model.grid.height))
for cell in model.grid.coord_iter():
    cell_content, x, y = cell
    agent_count = len(cell_content)
    agent_counts[x][y] = agent_count
plt.imshow(agent_counts, interpolation="nearest")
plt.colorbar()

### Collecting Data

So far, at the end of every model run, we've had to go and write our own code to get the data out of the model. This has two problems: it isn't very efficient, and it only gives us end results. If we wanted to know the letter counts of each agent at each step, we'd have to add that to the loop of executing steps, and figure out some way to store the data.

Since one of the main goals of agent-based modeling is generating data for analysis, Mesa provides a class which can handle data collection and storage for us and make it easier to analyze.

The data collector stores three categories of data: model-level variables, agent-level variables, and tables (which are a catch-all for everything else). Model- and agent-level variables are added to the data collector along with a function for collecting them. Model-level collection functions take a model object as an input, while agent-level collection functions take an agent object as an input. Both then return a value computed from the model or each agent at their current state. When the data collector’s `collect` method is called, with a model object as its argument, it applies each model-level collection function to the model, and stores the results in a dictionary, associating the current value with the current step of the model. Similarly, the method applies each agent-level collection function to each agent currently in the schedule, associating the resulting value with the step of the model, and the agent’s `unique_id`.

Let's add a `DataCollector` to the model with [`mesa.DataCollector`](https://github.com/projectmesa/mesa/blob/main/mesa/datacollection.py), and collect two variables at the agent level. We want to collect every agent's letters sent and letters received at every step.

class LetterAgent(mesa.Agent):
    """An agent with letters sent and letters received."""

    def __init__(self, unique_id, model):
        super().__init__(unique_id, model)
        self.letters_sent = 0
        self.letters_received = 0

    def move(self):
        possible_steps = self.model.grid.get_neighborhood(
            self.pos, moore=True, include_center=False
        )
        new_position = self.random.choice(possible_steps)
        self.model.grid.move_agent(self, new_position)

    def send_letter(self):
        cellmates = self.model.grid.get_cell_list_contents([self.pos])
        if len(cellmates) > 1:
            other_agent = self.random.choice(cellmates)
            other_agent.letters_received += 1
            self.letters_sent += 1

    def step(self):
        self.move()
        self.send_letter()


class LetterModel(mesa.Model):
    """A model with some number of agents."""

    def __init__(self, N, width, height):
        self.num_agents = N
        self.grid = mesa.space.MultiGrid(width, height, True)
        self.schedule = mesa.time.RandomActivation(self)
        # Create agents
        for i in range(self.num_agents):
            a = LetterAgent(i, self)
            self.schedule.add(a)
            # Add the agent to a random grid cell
            x = self.random.randrange(self.grid.width)
            y = self.random.randrange(self.grid.height)
            self.grid.place_agent(a, (x, y))

        self.datacollector = mesa.DataCollector(
            agent_reporters={"Letters_sent": "letters_sent", "Letters_received": "letters_received"}
        )

    def step(self):
        self.datacollector.collect(self)
        self.schedule.step()

At every step of the model, the datacollector will collect and store each agent's letters_sent and letters_received value.

We run the model just as we did above. The `DataCollector` can export the data its collected as a pandas `DataFrame`, for easy interactive analysis.

model = LetterModel(50, 10, 10)
for i in range(100):
    model.step()

We can now get the agent-letters data like this:

agent_letters = model.datacollector.get_agent_vars_dataframe()
agent_letters.tail()

You'll see that the DataFrame's index is pairings of model step and agent ID. You can analyze it the way you would any other DataFrame. For example, to get a histogram of agent's letters sent at the model's end:

end_letters = agent_letters.xs(99, level="Step")["Letters_sent"]
end_letters.hist(bins=range(agent_letters.Letters_sent.max() + 1))

Or to plot the letters received of a given agent (in this example, agent 14):

one_agent_letters = agent_letters.xs(14, level="AgentID")
one_agent_letters.Letters_received.plot()

You can also use `pandas` to export the data to a CSV (comma separated value), which can be opened by any common spreadsheet application or opened by `pandas`.

If you do not specify a file path, the file will be saved in the local directory. After you run the code below you will see two files appear (*model_data.csv* and *agent_data.csv*)

# save the agent data (stored in the pandas agent_letters object) to CSV
agent_letters.to_csv("agent_data.csv")


## Visualization and Interactive Features of Mesa

///

## Next steps and open questions

Now we have a very simple model where agents send each other letters when they are close enough to each other, but otherwise walking aimlessly through their grid-like world. Of course, this model does not yet capture actual letter sending in a meaningful way.

In the real world, for example in the time of the Republic of Letters, people wouldn't have wandered at random, but maybe stayed at certain places and only on special, purposeful occasions change place. They would also know and remember the people they write to or receive letters from. Based on their familiarity and, crucially, the topical content of the communication, people would choose to write certain people more than others, not just their immediate neighbors. Out of this, an actually interesting social-epistemic network might arise and be analysed.

All of these features would be possible to implement with python and the simple methods we mentioned here and most of these we actually tried to model in the projects actual LetterModel on which we will have a look at next!

If you want more information and a more thorough introduction to mesa, you can either head to [the documentation of mesa](https://mesa.readthedocs.io/en/stable/overview.html), which features a variant of this tutorial and more on advanced features, especially built-in javascript-based visualization methods, or you can head to youtube [for a video tutorial](https://www.youtube.com/playlist?list=PLF0b3ThojznRpQOd7iFukqXybbMV_vwZn) in a similar vein like the official mesa tutorials.

### Literature

[Comer2014] Comer, Kenneth W. “Who Goes First? An Examination of the Impact of Activation on Outcome Behavior in AgentBased Models.” George Mason University, 2014. http://mars.gmu.edu/bitstream/handle/1920/9070/Comer_gmu_0883E_10539.pdf

# Part 3: Conclusion

–	Give hints and resources for readers to play around with and extend the model
–	Give reading and coding resources for getting more in-depth into Agent-based Modeling
–	Reiterate how this type of model could be a starting place for own research;
–	Reiterate peculiarities of Agent-based Modeling for historical research
–	Share data-set?!
–	Invite to get in touch :)
