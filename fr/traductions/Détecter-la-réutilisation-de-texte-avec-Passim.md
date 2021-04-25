---
title: Détecter la réutilisation de texte avec Passim
collection: lessons
layout: lesson
slug: Detecting-Text-Reuse-with-Passim
date: 2020-08-26
authors:
- Matteo Romanello
- Simon Hengchen
topics: [text-reuse]
editors: Anna-Maria Sichani
reviewers: LEAVE BLANK
review-ticket: LEAVE BLANK
difficulty: LEAVE BLANK
activity: LEAVE BLANK
abstract: LEAVE BLANK
---

{% include toc.html %}

<!--
TO DO: traduction de la citation l. 45
-->


[TODO: intro to the lesson that is saying what this lesson will cover in brief before the audience note below]

À la fin de ce cours, vous serez capable de :
1. installer et exécuter Passim;
2. préparer vos textes comme un fichier source adapté à une utilisation avec Passim;
3. traiter la sortie générée par Passim pour effectuer des analyses basiques

Ce cours s'adresse aux personnes travaillant dans les humanités numériques (DH). Aucune connaissance préalable de la réutilisation de texte n'est requise, toutefois il est nécessaire d'avoir une compréhension basique du [bash scripting](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) et de Python, ainsi que des manipulations de données. Si vous souhaitez des tutoriels pour scripter en bash et pour coder en [Python](https://en.wikipedia.org/wiki/Python_(programming_language)), vous pouvez vous réferez au tutoriel de Programming Historian [“Introduction to the Bash Command Line](https://programminghistorian.org/en/lessons/intro-to-bash) et à la [library of current Python lessons](https://programminghistorian.org/en/lessons/?topic=python) sur le site *Programming Historian*.

Ce cours donne un aperçu de [Passim](https://github.com/dasmiq/Passim), un outil open source conçu pour la détection automatique de la réutilisation de texte. Bien que cet outil ait été employé dans des projets DH, grands comme petits, une documentation conviviale avec des exemples et des instructions fait défaut. Ainsi, nous visons à combler cette lacune grâce au cours *Programming Historian*.
<!-- 
je ne comprends pas pourquoi il y a des " avant Introduction à la ligne 33.7
-->
<!--
Cette leçon s'adresse aux praticiens en DH. Aucune connaissance préalable de la réutilisation de texte n'est requise, mais une compréhension basique de [scripting bash](https://programminghistorian.org/en/lessons/intro-to-bash) et de [Python](https://programminghistorian.org/en/lessons/?topic=python), ainsi que de *quelques* connaissances en manipulation de données. Nous offrons un tutoriel sur l'utilisation de [`passim`](https://github.com/dasmiq/passim), un outil open source visant à aider la détection automatique de réutilisation de texte. Bien que l'outil ait �t� utilis� dans le cadre d'un certain nombre de petits et grands projets en humanit�s num�riques, il existe un vrai manque de documentation conviviale pr�sentan des exemples et des instructions de configuration, une lacune que nous visons � combler avec cette le�on de ProgrammingHistorian.
-->

# Introduction à la réutilisation de texte

La réutilisation de texte peut être définie comme "the meaningful reiteration of text, usually beyond the simple repetition of common language" (Romanello et al. 2014). Il s'agit d'un concept si large, qu'il peut être compris à différents niveaux et être étudié dans une grande variété de contextes. Dans un contexte de publication ou d'enseignement, par exemple, les cas de réutilisation de texte peuvent être considérés comme du plagiat, si des parties de texte d'un.e autre auteur.e sont employées sans une attribution appropriée. Un autre exemple, dans le cadre des études littéraires, la réutilisation de texte n'est bien souvent qu'un syonyme pour désigner des phénomènes littéraires tels que les allusions, les paraphrases et les citations directes.

<!--
La r�utilisation de texte peut �tre d�finie comme "the meaningful reiteration of text, usually beyond the simple repetition of common language" (� la r�it�ration significative de texte, g�n�ralement au-del� de la simple r�p�tition d'un langage commun �, Romanello et al. 2014). C'est un concept si large qu'il peut �tre compris � diff�rents niveaux et �tudi� dans une grande vari�t� de contextes. Dans un contexte de publication ou d'enseignement, par exemple, les instances de r�utilisation de texte peuvent constituer un **plagiat** dans le cas o� des parties de texte d'un.e auteur.e sont r�p�t�es sans attribution appropri�e. Un autre exemple, dans le contexte des �tudes litt�raires, la r�utilisation de texte n'est bien souvent qu'un synonyme pour d�signer des ph�nom�nes litt�raires tels que les **allusions**, les **paraphrases**, et les **citations directes**.
-->
La liste ci-dessous comportent une partie des bibliothèques disponibles qui effectuent la détection automatique de la réutilisation de texte :

- Le [R textreuse package](https://docs.ropensci.org/textreuse/) (R) rédigé par Lincoln Mullen
- [TRACER](https://www.etrap.eu/research/tracer/) (Java) développé par Marco Büchler et ses collaborateurs
- [Basic Local Alignment Search Tool (BLAST)](https://blast.ncbi.nlm.nih.gov/Blast.cgi)
- [MatchMaker](https://github.com/JSTOR-Labs/matchmaker) (Python) dévloppé par les "JSTOR Labs"
- [Tesserae](https://github.com/tesserae/tesserae) (PHP, Perl)
- [TextPAIR (Pairwise Alignment for Intertextual Relations)](https://github.com/ARTFL-Project/text-pair)
- [Passim](https://github.com/dasmiq/Passim) (Scala) développé par [David Smith](http://www.ccs.neu.edu/home/dasmith/
  ) (Northeastern University)

<!--
Il existe de nombreuses biblioth�ques permettant d'effectuer de la r�utilisation de texte de mani�re automatique:
- Le [package R "textreuse"](https://docs.ropensci.org/textreuse/) (R) par Lincoln Mullen
- [TRACER](https://www.etrap.eu/research/tracer/) (Java) d�velopp� par Marco B�chler et collaborateurs
- [Basic Local Alignment Search Tool (BLAST)](https://blast.ncbi.nlm.nih.gov/Blast.cgi)
- [MatchMaker](https://github.com/JSTOR-Labs/matchmaker) (Python) d�velopp� par les "JSTOR Labs"
- [Tesserae](https://github.com/tesserae/tesserae) (PHP, Perl)
- [TextPAIR (Pairwise Alignment for Intertextual Relations)](https://github.com/ARTFL-Project/text-pair)
- [`passim`](https://github.com/dasmiq/passim) (Scala) d�velopp� par [David Smith](http://www.ccs.neu.edu/home/dasmith/) (Northeastern University)
-->
Pour ce tutoriel, nous avons choisi de nous concentrer sur la bibliothèque Passim et cela pour trois raisons principales. Premièrement, car celle-ci peut être adaptée à une grande variété d'utilisation, puisqu'elle fonctionne autant sur une petite collection de texte que sur un corpus de grande échelle. Deuxièmement, parce que, bien que la documentation au sujet de Passim soit exhaustive, et cela à cause que ses utilisateurs soient relativement avancés, un guide "pas-à-pas" de la détection de la réutilisation de texte avec passim plus axé sur l'utilisateur serait bénéfique pour l'ensemble des utilisateurs.

<!--
Nous utilisons dans ce tutoriel `passim`, et ce pour deux raisons : premi�rement, puisque l'outil fonctionne aussi bien sur des petites collections de texte que de gros datasets, `passim` s'adapte tr�s bien � tout type de projets. Une deuxi�me raison est le manque de guide "�tape-par-�tape" : malgr� une [documentation tr�s exhaustive](https://github.com/dasmiq/passim)), elle reste tr�s technique et d�s lors rend l'utilisation de `passim` relativement compliqu�e, de premier abord.
-->
Finalement, les exemples suivants illustrent de la variété de scénarios dans lesquels la réutilisation de texte est une méthodologie utile :

- Pour déterminer si une bibliothèque numérique contient plusieurs éditions de mêmes oeuvres
- Pour trouver des citations dans un texte, à condition que les oeuvres choisies soient connues (par exemple, pour trouver des citations de la Bible au sein de la littérature anglaise du 17ème siècle) 
- Pour étudier la viralité et la diffusion des textes (par exemple [Viral Texts](https://viraltexts.org/) par Cordell and Smith pour les journaux historiques)
- Pour identifier (et si possible filtrer) les documents en double dans une collection de texte avant d'effectuer d'autres étapes de traitement (par exemple, la modélisation de sujet comme illustré par Schofield et al. (2017))

<!--
Dans quels contextes puis-je utiliser des outils de d�tection de r�utilisation de texte ? Voici quelques exemples :

- to determine whether a digital library contains multiple editions of the same work(s);
- to find quotations in a text, provided that the target works are known (e.g. find quotations of the Bible within 17c English literature);  
- to study the virality and spread of texts (e.g. [Viral Texts](https://viraltexts.org/) by Cordell and Smith for historical newspapers);
- to identify (and possibly filter out) duplicate documents within a text collection before performing further processing steps (e.g. topic modelling as illustrated by Schofield et al. (2017)).
-->
Pour ces raisons, Passim devient un excellent choix. Passim vous aidera à automatiser la recherche de passages textuels répétés dans un corpus – qu’il s’agisse d’annonces publicitaires dans les journaux, de copies multiples du même poème ou de citations directes (et légèrement indirectes) dans l’ouvrage d’un.e autre auteur.e.  
La détection de réutilisation de texte telle que mise en place dans Passim vise à identifier ces copies et répétitions automatiquement, et produit des groupes de passages qui ont été jugés comme étant liés les uns aux autres. Par exemple, Passim peut regrouper des copies d'un même article qui ne diffèrent que par des erreurs de reconnaissance optique de caractères (OCR), mais il peut aussi aider à retrouver des textes qui partagent le même modèle journalistique, comme des horoscopes ou des publicités.

<!--
# Learning Objectives

Upon completing this lesson, you will be able to:
1. install and run `passim`;
2. prepare your texts as input files suitable for use with `passim`;
3. process the output generated by `passim` to carry out basic analyses
-->
# Prérequis

Ce tutoriel nécessite les connaissances suivantes :
- Une compréhension basique du script Bash. Pour les lecteurs qui auraient besoin d’informations au sujet du script Bash, vous pouvez lire le cours *Programming Historian* ["Introduction to the Bash Command Line"](https://programminghistorian.org/en/lessons/intro-to-bash).
- -	Des connaissances en JSON. Pour apprendre davantage au sujet de JSON, vous pouvez lire le cours *Programming Historian* ["Reshaping JSON with jq"](https://programminghistorian.org/en/lessons/json-and-jq).

De plus, bien qu'une compréhension de base de Python - et une installation de Python fonctionnelle - ne soient pas strictement nécessaires pour travailler avec Passim, elles sont requises pour exécuter certaines parties de ce tutoriel (par exemple le carnet Jupyter avec l'exploration des données, ou le script de préparation des données Early English Books Online (EEBO)). Si vous n'êtes pas familier avec Python, veuillez lire la leçon *Programming Historian* ["Python Introduction and Installation"](https://programminghistorian.org/en/lessons/introduction-and-installation).   

Notez que l’installation de Passim sur Windows est plus difficile que celle pour macOS ou pour Linux. Par conséquent, nous vous recommandons d'utiliser macOS ou Linux (ou un environnement virtuel) pour ce cours.

# Installation de Passim

L'installation de `passim` exige l’installation des logiciels ci-dessous :
- [Java JDK (version 8)](https://www.oracle.com/ch-de/java/technologies/javase/javase-jdk8-downloads.html)
- [Scala Build Tool](https://www.scala-sbt.org/) (SBT)
- [Apache Spark](https://spark.apache.org/)

Mais pourquoi toutes ces dépendances sont-elles nécessaires ?

Passim est écrit dans un langage de programmation appelé Scala. Pour exécuter un logiciel écrit en Scala, ses sources doivent être compilées en un fichier JAR exécutable, ce qui est réalisé par sbt, l'outil de construction interactif de Scala. Enfin, puisque Passim est conçu pour travailler également sur des collections de textes de grande taille (avec plusieurs milliers ou millions de documents), il utilise en coulisse Spark, un framework de calcul en cluster écrit en Java. L'utilisation de Spark permet à Passim de gérer le traitement distribué de certaines parties du code, ce qui est utile lors de la manipulation de grandes quantités de données. Le [Spark glossary](https://spark.apache.org/docs/latest/cluster-overview.html#glossary) est une ressource utile pour apprendre la terminologie de base de Spark (des mots comme "driver", "executor", etc.) mais apprendre cette terminologie n’est pas indispensable si vous exécutez Passim sur un petit ensemble de données.

Avant d’installer cet ensemble de logiciel, vous aurez besoin de télécharger le code source de Passim depuis GitHub :

```bash
>>> git clone https://github.com/dasmiq/passim.git
```

Si vous n’êtes pas familier avec Git et Github, nous vous recommandons de lire le cours *Programming Historian* ["An Introduction to Version Control Using GitHub Desktop"](https://doi.org/10.46430/phen0051).

## Instructions pour macOS

Ces instructions sont destinées aux utilisateurs de macOS d'Apple et ont été testées sous la version 10.13.4 (alias High Sierra).

### Vérification de l'installation de Java

Assurez-vous que vous disposez du kit de développement Java 8 en tapant la commande suivante dans une nouvelle fenêtre de l'invite de commande :


```bash
>>> java -version
```

Si le résultat de cette commande ressemble à l'exemple suivant, alors Java 8 est installé sur votre ordinateur.

```
openjdk version "1.8.0_262"
OpenJDK Runtime Environment (AdoptOpenJDK)(build 1.8.0_262-b10)
OpenJDK 64-Bit Server VM (AdoptOpenJDK)(build 25.262-b10, mixed mode)
```

### Installation de Java 8

Si une autre version de Java est déjà installée sur votre ordinateur, suivez les prochaines étapes afin d’installer Java 8 en même temps que la version existante de Java.

Ceci est important afin de ne pas endommager les logiciels déjà installés qui ont besoin de versions plus récentes de Java.

1. Installez le gestionnaire de paquets `brew` en suivant les instructions d'installation sur le site [Brew.sh](https://brew.sh/). Une fois l'installation achevée, exécutez `brew --help` pour qu'elle fonctionne.

2. Utilisez `brew` pour installer Java 8.

```bash
>>> brew cask install adoptopenjdk/openjdk/adoptopenjdk8
```
Vérifiez que Java 8 est bien installé.

```bash
>>> /usr/libexec/java_home -V
```
Cette commande devrait produire quelque chose de similaire à ce qui suit :

```bash
Matching Java Virtual Machines (2):
    13.0.2, x86_64:	"Java SE 13.0.2"	/Library/Java/JavaVirtualMachines/jdk-13.0.2.jdk/Contents/Home
    1.8.0_262, x86_64:	"AdoptOpenJDK 8"	/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

/Library/Java/JavaVirtualMachines/jdk-13.0.2.jdk/Contents/Home
```

3. Installez `jenv`, un outil qui vous permet de gérer plusieurs versions de Java installées sur le même ordinateur et qui vous permet de passer facilement de l’un à l’autre.

```bash
>>> brew install jenv
```

Pour être capable d'appeler `jenv` sans spécifier le chemin complet du fichier, n’oubliez pas d’ajouter `jenv` à votre variable d’environnement `$PATH` en ouvrant le fichier `~/.bashrc` avec votre éditeur de texte préféré et en ajoutant les lignes suivantes à la fin du fichier :

```bash
# activate jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
```
Après avoir ajouté ces lignes, vous devez ouvrir une autre fenêtre de de l'invite de commande ou exécuter la ligne suivante pour que la variable `$PATH` soit mise à jour avec le changement que vous venez de faire (la commande `source` déclenche le rechargement de votre configuration `bash`).

```bash
>>> source ~/.bashrc
```
Une fois installé, ajoutez les versions existantes de Java à `jenv` (c'est-à-dire celles listées par la commande `/usr/libexec/java_home -V`):

```bash
# your mileage may vary, so make sure you replace this path
# with the actual path to the JAVA_HOME in your machine
>>> jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
```
Maintenant vous pouvez définir la version par défaut de Java pour ce projet en exécutant ce qui suit :

```bash
>>> jenv local 1.8

# Vérifiez
>>> java -version
```

### Compilation de Passim à partir des sources (macOS)

Passim est écrit dans un langage de programmation appelé Scala. Avant de pouvoir exécuter un logiciel écrit en Scala, ses sources doivent être compilées. Cette tâche est effectuée par `sbt`, le Interactive Build Tool.

Pour déterminer si `sbt` est installé sur votre ordinateur, exécutez la commande suivante :

```bash
>>> sbt about
```
Si votre commande affiche `bash: sbt: command not found` cela signifie que `sbt` n'est pas installé.
Cependant, Passim est livré avec un script utile  (`build/sbt`) qui téléchargera et installera SBT automatiquement avant de compiler les sources de Passim.

**NB**: L'utilisation d'un SBT externe (c'est-à-dire déjà installé) peut conduire à des problèmes, nous recommandons la méthode suivante pour compiler Passim.

Pour compiler le programme, exécutez la commande suivante depuis le fichier où vous avez précédemment cloné le dépôt GH de Passim :

```bash
>>> cd Passim/
>>> build/sbt package
```
Cette commande prendra un certain temps (environ 3 minutes sur une connexion moderne), mais vous informera de la progression. Au fur et à mesure que votre ordinateur commence à télécharger les fichiers requis, un journal sera imprimé à l'écran. A la fin de ce processus, `sbt` aura créé une archive `.jar` contenant les sources compilées pour Passim. Ce fichier se trouve dans le fichier `target`: `target/scala-2.11/Passim_2.11-0.2.0.jar`. Selon la version de Scala et de Passim, le chemin réel peut être légèrement différent sur votre ordinateur.

Le fichier `bin` contient un fichier Passim : c'est l'exécutable qui va lancer Passim. Pour que votre ordinateur connaisse l'emplacement de ce fichier, et donc pour qu'il reconnaisse la commande Passim, nous devons ajouter le chemin à la variable d'environnement`PATH`.

```bash
# remplacez /home/simon/Passim par le fichier où vous avez installé Passim
>>> export PATH="/home/simon/Passim/bin:$PATH"
```
Pour ajouter le chemin de façon permanente à la variable d'environnement `PATH` ouvrez le `~/.bashrc` avec votre éditeur de texte préféré et ajoutez la ligne suivante n'importe où dans le fichier (puis exécutez `source ~/.bashrc` pour appliquer ce changement):

```bash
# remplacez /home/simon/Passim par le fichier où vous avez installé Passim
export PATH="/home/simon/Passim/bin:$PATH"
```

### Installation de Spark

1. Accédez à la [section de téléchargement](http://spark.apache.org/downloads) du site Web de Spark et sélectionnez la version de Spark '2.4.x' (où '*x*' signifie toute version commençant par '2.4'), et le type de paquetage 'Pre-built for Apache Hadoop 2.7' dans les menus déroulants.

2. Extrayez les données binaires compressés dans un fichier de votre choix (par exemple `/Applications`):
```bash
>>> cd /Applications/
>>> tar -xvf ~/Downloads/spark-2.4.x-bin-hadoop2.7.tgz
```

3. Ajoutez le fichier où vous avez installé Spark à votre variable d'environnement `PATH`. Pour ce faire, exécutez temporairement la commande suivante :

```bash
>>> export PATH="/Applications/spark-2.4.x-bin-hadoop2.7:$PATH"
```
Pour ajouter le fichier d'installation du chemin de façon permanente à votre variable d'environnement `PATH`, ouvrez le fichier `~/.bashrc` avec votre éditeur de texte préféré et ajoutez la ligne suivante n'importe où dans le fichier :
```bash
export PATH="/Applications/spark-2.4.x-bin-hadoop2.7:$PATH"
```

Après avoir édité `~/.bashrc`, ouvrez une autre fenêtre de l'invite de commande ou exécutez la commande suivante :
```bash
>>> source ~/.bashrc
```
## Instructions pour Linux

Ces instructions sont destinées aux distributions Debian-based (Debian, Ubuntu, Linux Mint, etc.). Si vous utilisez un autre type de distribution (Fedora, Gentoo, etc.), remplacez les commandes spécifiques à la distribution (par exemple `apt`) par celles utilisées par votre distribution spécifique.

### Vérifiez l'installation de Java

Pour vous assurer que le kit de développement Java 8 est installé, exécutez la commande suivante :

```bash
>>> java -version
```

Si la commande ci-dessus renvoie à `1.8.0_252` ou à quelque chose de semblable, alors vous avez installé le kit de développement Java 8 (le `8` vous indique que le kit correct a été installé et sélectionné par défaut). Si votre résultat est différent, choisissez l'une des commandes suivantes en conséquence :

```bash
# Si vous ne l'avez pas, installez-le
>>>> apt install openjdk-8-jdk
```

```bash
# si votre JDK *par défaut* n'est pas la version 8
>>> sudo update-alternatives --config java
```

### Compilation de Passim à partir des sources

Reportez-vous aux [instructions de compilation pour macOS](#compiling-passim-from-the-sources-(macOS)), car elles sont les mêmes que pour l'environnement Linux.

### Installation de Spark

1. Téléchargez les données binaires Spark en utilisant la commande `wget`:
  ```bash
  >>> wget -P /tmp/ http://apache.mirrors.spacedump.net/spark/spark-2.4.6/spark-2.4.6-bin-hadoop2.7.tgz
  ```
2. Extrayez les données binaires compressées dans un fichier de votre choix :
  ```bash
  >>> tar -xvf /tmp/spark-2.4.6-bin-hadoop2.7.tgz -C /usr/local/
  ```
3.  Ajoutez le fichier où vous avez installé Spark à votre variable d'environnement `PATH`. Pour ce faire, exécutez temporairement la commande suivante :

 ```bash
>>> export PATH="/Applications/spark-2.4.x-bin-hadoop2.7:$PATH"
```
Pour ajouter le fichier à votre variable d'environnement `PATH` de façon permanente, ouvrez le fichier `~/.bashrc` avec votre éditeur de texte préféré et ajoutez la ligne suivante n'importe où dans le fichier :
  ```bash
export PATH="/Applications/spark-2.4.x-bin-hadoop2.7:$PATH"
```

Après avoir modifié `~/.bashrc`, vous devez ouvrir une autre fenêtre de l'invite de commande ou exécuter la ligne suivante pour que votre variable `PATH` soit mise à jour avec le changement que vous venez de faire.
  ```bash
  >>> source ~/.bashrc
  ```

## Vérifiez l'installation

À ce stade, vous avez installé Passim et tous les paquets nécessaires sur votre ordinateur. Si vous tapez  `Passim --help` dans la ligne de commande, vous devriez voir une sortie similaire à ce qui suit :

```bash
Ivy Default Cache set to: /Users/matteo/.ivy2/cache
The jars for the packages stored in: /Users/matteo/.ivy2/jars
:: loading settings :: url = jar:file:/Applications/spark-2.4.6-bin-hadoop2.7/jars/ivy-2.4.0.jar!/org/apache/ivy/core/settings/ivysettings.xml
com.github.scopt#scopt_2.11 added as a dependency
graphframes#graphframes added as a dependency
:: resolving dependencies :: org.apache.spark#spark-submit-parent-bb5bd11f-ba3c-448e-8f69-5693cc073428;1.0
	confs: [default]
	found com.github.scopt#scopt_2.11;3.5.0 in spark-list
	found graphframes#graphframes;0.7.0-spark2.4-s_2.11 in spark-list
	found org.slf4j#slf4j-api;1.7.16 in spark-list
:: resolution report :: resolve 246ms :: artifacts dl 4ms
	:: modules in use:
	com.github.scopt#scopt_2.11;3.5.0 from spark-list in [default]
	graphframes#graphframes;0.7.0-spark2.4-s_2.11 from spark-list in [default]
	org.slf4j#slf4j-api;1.7.16 from spark-list in [default]
	---------------------------------------------------------------------
	|                  |            modules            ||   artifacts   |
	|       conf       | number| search|dwnlded|evicted|| number|dwnlded|
	---------------------------------------------------------------------
	|      default     |   3   |   0   |   0   |   0   ||   3   |   0   |
	---------------------------------------------------------------------
:: retrieving :: org.apache.spark#spark-submit-parent-bb5bd11f-ba3c-448e-8f69-5693cc073428
	confs: [default]
	0 artifacts copied, 3 already retrieved (0kB/6ms)
20/07/17 15:23:17 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
20/07/17 15:23:19 INFO SparkContext: Running Spark version 2.4.6
20/07/17 15:23:19 INFO SparkContext: Submitted application: Passim.PassimApp
20/07/17 15:23:19 INFO SecurityManager: Changing view acls to: matteo
20/07/17 15:23:19 INFO SecurityManager: Changing modify acls to: matteo
20/07/17 15:23:19 INFO SecurityManager: Changing view acls groups to:
20/07/17 15:23:19 INFO SecurityManager: Changing modify acls groups to:
20/07/17 15:23:19 INFO SecurityManager: SecurityManager: authentication disabled; ui acls disabled; users  with view permissions: Set(matteo); groups with view permissions: Set(); users  with modify permissions: Set(matteo); groups with modify permissions: Set()
20/07/17 15:23:20 INFO Utils: Successfully started service 'sparkDriver' on port 62254.
20/07/17 15:23:20 INFO SparkEnv: Registering MapOutputTracker
20/07/17 15:23:20 INFO SparkEnv: Registering BlockManagerMaster
20/07/17 15:23:20 INFO BlockManagerMasterEndpoint: Using org.apache.spark.storage.DefaultTopologyMapper for getting topology information
20/07/17 15:23:20 INFO BlockManagerMasterEndpoint: BlockManagerMasterEndpoint up
20/07/17 15:23:20 INFO DiskBlockManager: Created local directory at /private/var/folders/8s/rnkbnf8549qclh_gcb_qj_yw0000gv/T/blockmgr-f42fca4e-0a6d-4751-8d3b-36db57896aa4
20/07/17 15:23:20 INFO MemoryStore: MemoryStore started with capacity 366.3 MB
20/07/17 15:23:20 INFO SparkEnv: Registering OutputCommitCoordinator
20/07/17 15:23:20 INFO Utils: Successfully started service 'SparkUI' on port 4040.
20/07/17 15:23:20 INFO SparkUI: Bound SparkUI to 0.0.0.0, and started at http://192.168.0.24:4040
20/07/17 15:23:20 INFO SparkContext: Added JAR file:///Users/matteo/.ivy2/jars/com.github.scopt_scopt_2.11-3.5.0.jar at spark://192.168.0.24:62254/jars/com.github.scopt_scopt_2.11-3.5.0.jar with timestamp 1594992200488
20/07/17 15:23:20 INFO SparkContext: Added JAR file:///Users/matteo/.ivy2/jars/graphframes_graphframes-0.7.0-spark2.4-s_2.11.jar at spark://192.168.0.24:62254/jars/graphframes_graphframes-0.7.0-spark2.4-s_2.11.jar with timestamp 1594992200489
20/07/17 15:23:20 INFO SparkContext: Added JAR file:///Users/matteo/.ivy2/jars/org.slf4j_slf4j-api-1.7.16.jar at spark://192.168.0.24:62254/jars/org.slf4j_slf4j-api-1.7.16.jar with timestamp 1594992200489
20/07/17 15:23:20 INFO SparkContext: Added JAR file:/Users/matteo/Documents/Passim/target/scala-2.11/Passim_2.11-0.2.0.jar at spark://192.168.0.24:62254/jars/Passim_2.11-0.2.0.jar with timestamp 1594992200489
20/07/17 15:23:20 INFO Executor: Starting executor ID driver on host localhost
20/07/17 15:23:20 INFO Utils: Successfully started service 'org.apache.spark.network.netty.NettyBlockTransferService' on port 62255.
20/07/17 15:23:20 INFO NettyBlockTransferService: Server created on 192.168.0.24:62255
20/07/17 15:23:20 INFO BlockManager: Using org.apache.spark.storage.RandomBlockReplicationPolicy for block replication policy
20/07/17 15:23:20 INFO BlockManagerMaster: Registering BlockManager BlockManagerId(driver, 192.168.0.24, 62255, None)
20/07/17 15:23:20 INFO BlockManagerMasterEndpoint: Registering block manager 192.168.0.24:62255 with 366.3 MB RAM, BlockManagerId(driver, 192.168.0.24, 62255, None)
20/07/17 15:23:20 INFO BlockManagerMaster: Registered BlockManager BlockManagerId(driver, 192.168.0.24, 62255, None)
20/07/17 15:23:20 INFO BlockManager: Initialized BlockManager: BlockManagerId(driver, 192.168.0.24, 62255, None)
Usage: Passim [options] <path>,<path>,... <path>

  --boilerplate            Detect boilerplate within groups.
  --labelPropagation       Cluster with label propagation.
  -n, --n <value>          index n-gram features; default=5
  -l, --minDF <value>      Lower limit on document frequency; default=2
  -u, --maxDF <value>      Upper limit on document frequency; default=100
  -m, --min-match <value>  Minimum number of n-gram matches between documents; default=5
  -a, --min-align <value>  Minimum length of alignment; default=20
  -L, --min-lines <value>  Minimum number of lines in boilerplate and docwise alignments; default=5
  -g, --gap <value>        Minimum size of the gap that separates passages; default=100
  -c, --context <value>    Size of context for aligned passages; default=0
  -o, --relative-overlap <value>
                           Minimum relative overlap to merge passages; default=0.8
  -M, --merge-diverge <value>
                           Maximum length divergence for merging extents; default=0.3
  -r, --max-repeat <value>
                           Maximum repeat of one series in a cluster; default=10
  -p, --pairwise           Output pairwise alignments
  -d, --docwise            Output docwise alignments
  --linewise               Output linewise alignments
  -N, --names              Output names and exit
  -P, --postings           Output postings and exit
  -i, --id <value>         Field for unique document IDs; default=id
  -t, --text <value>       Field for document text; default=text
  -s, --group <value>      Field to group documents into series; default=series
  -f, --filterpairs <value>
                           Constraint on posting pairs; default=gid < gid2
  --fields <value>         Semicolon-delimited list of fields to index
  --input-format <value>   Input format; default=json
  --schema-path <value>    Input schema path in json format
  --output-format <value>  Output format; default=json
  --aggregate              Output aggregate alignments of consecutive seqs
  -w, --word-length <value>
                           Minimum average word length to match; default=2
  --help                   prints usage text
  <path>,<path>,...        Comma-separated input paths
  <path>                   Output path
20/07/17 15:23:20 INFO SparkContext: Invoking stop() from shutdown hook
20/07/17 15:23:20 INFO SparkUI: Stopped Spark web UI at http://192.168.0.24:4040
20/07/17 15:23:21 INFO MapOutputTrackerMasterEndpoint: MapOutputTrackerMasterEndpoint stopped!
20/07/17 15:23:21 INFO MemoryStore: MemoryStore cleared
20/07/17 15:23:21 INFO BlockManager: BlockManager stopped
20/07/17 15:23:21 INFO BlockManagerMaster: BlockManagerMaster stopped
20/07/17 15:23:21 INFO OutputCommitCoordinator$OutputCommitCoordinatorEndpoint: OutputCommitCoordinator stopped!
20/07/17 15:23:21 INFO SparkContext: Successfully stopped SparkContext
20/07/17 15:23:21 INFO ShutdownHookManager: Shutdown hook called
20/07/17 15:23:21 INFO ShutdownHookManager: Deleting directory /private/var/folders/8s/rnkbnf8549qclh_gcb_qj_yw0000gv/T/spark-dbeee326-7f37-475a-9379-74da31d72117
20/07/17 15:23:21 INFO ShutdownHookManager: Deleting directory /private/var/folders/8s/rnkbnf8549qclh_gcb_qj_yw0000gv/T/spark-9ae8a384-b1b3-49fa-aaff-94ae2f37b2d9
```
<!--
Doit-on traduire la doccumentation de Passim ?
-->

# Préparation de Data pour Passim

Le but de l'utilisation de Passim est d'automatiser la recherche de passages de texte répétés dans un corpus. Par exemple, un corpus de journaux contient de multiples copies d'un même article, identiques ou légèrement différentes les unes des autres, ainsi que des répétitions de plus petites portions d'une page de journal (par exemple, publicité, liste d'événements, etc.).

Comme le précise la documentation de Passim, "the input to Passim is a set of documents. Depending on the kind of data you have, you might choose documents to be whole books, pages of books, whole issues of newspapers, individual newspaper articles, etc. Minimally, a document consists of an identifier string and a single string of text content" (Referrez-vous à l'exemple de saisie JSON minimale dans la section suivante pour davantage d'informations sur la structure de la saisie pour Passim).

La figure 1 donne une représentation schématique des données d'entrée et de sortie pour Passim. Étant donné un ensemble de documents en entrée, divisé en séries de documents, Passim tentera d'identifier la réutilisation de texte à partir de documents de différentes séries, et non au sein de ces séries. Dans le cas d'un corpus de journaux, les articles d'un même journal appartiendront à la même série de documents, car nous ne sommes pas intéressés par la détection de la réutilisation au sein d'un même journal, mais entre différents journaux.

En fin de compte, ce qui constitue un document et comment ces documents devraient être divisés en séries sont les choix que vous devrez faire lorsque vous préparerez vos données pour Passim.  Naturellement, la décision sur ce qui constitue une *series* de documents dépend directement de vos objectifs ou de vos questions de recherche. Trouver des citations de la Bible dans un corpus de livres est un cas "one-to-many" de détection de réutilisation de texte, qui exige que les documents soient groupés en deux séries (`bible` and `non_bible`). Au contraire, la comparaison entre plusieurs éditions de la Bible (également appelée par collection) peut être considérée comme un cas "many-to-many", où chaque édition correspondra et constituera une série de documents (par exemple des pages).  Si vos questions de recherche changent à un moment donné, qui requiert ainsi une redéfinition des séries de documents, vous devrez également produire de nouvelles données d'entrée pour Passim, afin de refléter ce changement.

{% include figure.html filename="textreuse-generic.png" caption="Figure 1. Schematic representation of text reuse clusters; each cluster consists of similar passages found in several series of documents." %}

## Format JSON de base

Le format d'entrée de Passim consiste en des documents JSON au format [JSON lines format](http://jsonlines.org/) (c'est-à-dire que chaque ligne de texte contient un seul document JSON).

Le contenu suivant d'un fichier nommé `test.json` illustre un exemple minimal du format d'entrée requis pour Passim :

```json
{"id": "d1", "series": "abc", "text": "This is the text of a document."}
{"id": "d2", "series": "def", "text": "This is the text of another document."}
```

Les champs `id`, `series` and `text` sont les seuls champs requis par Passim. Avec ce fichier en entrée, le logiciel va essayer de détecter la réutilisation de texte entre les documents de la série `abc`  et ceux de la série `def`, sur la base du contenu de `text`.

Tout au long de ce tutoriel, nous utiliserons l'outil en ligne de commande [`jq`](https://stedolan.github.io/jq/) pour inspecter et effectuer quelques traitements de base sur les données JSON en entrée et en sortie. Notez que, si vous n'avez pas installé `jq` vous devrez exécuter `sudo apt-get install jq` sous Ubuntu ou `brew install jq` sous macOS (pour les autres systèmes d'exploitation [référez-vous à la page officielle d'installation de JQ](https://stedolan.github.io/jq/download/)).

Par exemple, pour sélectionner et imprimer le champ `series` de votre entrée `test.json`, exécutez la commande suivante :

```bash
>>> jq '.series' test.json

# ce qui imprimera
"abc"
"def"

```
Note : Si vous employez `jq` pour consulter vos données JSON, vous devez utiliser le paramètre `--slurp` chaque fois que vous voulez traiter le contenu d'un ou plusieurs fichiers de lignes JSON comme un seul tableau de documents JSON et y appliquer des filtres (par exemple, pour sélectionner et imprimer un seul document, utilisez la commande suivante `jq --slurp '.[-1]' test.json`). Sinon `jq` raitera chaque document séparément, ce qui provoquera alors l'erreur suivante :

```bash
>>> jq '.[0]' test.json

jq: error (at <stdin>:1): Cannot index string with string "series"
jq: error (at <stdin>:2): Cannot index string with string "series"

```
## Note au sujet du Data Packaging

En fonction de la taille totale de vos données, il peut être judicieux de stocker les fichiers d'entrée de Passim sous forme de fichiers compressés. Passim supporte plusieurs schémas de compression comme .gzip et .bzip2. Notez qu'un flux de données compressé sera plus lent à traiter qu'un flux non compressé, donc l'utilisation de cette option ne sera bénéfique que si vos données sont volumineuses (par exemple des gigaoctets de texte), si vous avez accès à de nombreux cœurs, ou si vous disposez d'une quantité limitée d'espace disque.

Cette commande (ou, mieux, cette chaîne de commandes) produira le premier document dans un fichier de lignes JSON compressé par bzip2 (certains champs ont été tronqués pour des raisons de lisibilité) :

```bash
>>> bzcat impresso/GDL-1900.jsonl.bz2 | jq --slurp '.[0]'
```

Et produira le résultat suivant :
```json
{
  "series": "GDL",
  "date": "1900-12-12",
  "id": "GDL-1900-12-12-a-i0001",
  "cc": true,
  "pages": [
    {
      "id": "GDL-1900-12-12-a-p0001",
      "seq": 1,
      "regions": [
        {
          "start": 0,
          "length": 13,
          "coords": {
            "x": 471,
            "y": 1240,
            "w": 406,
            "h": 113
          }
        },
        {
          "start": 13,
          "length": 2,
          "coords": {
            "x": 113,
            "y": 1233,
            "w": 15,
            "h": 54
          }
        },
        ...
      ]
    }
  ],
  "title": "gratuitement ,la §azette seia envoyée",
  "text": "gratuitement\n, la § azette\nseia envoyée\ndès ce jour au 31 décembre, aux personnes\nqui s'abonneront pour l'année 1901.\nLes abonnements sont reçus par l'admi-\nnistration de la Gazette de Lausanne et dans\ntous les bureaux de poste.\n"
}

```


## Personnalisation du format JSON

(Note : Cette sous-section n'est pas strictement nécessaire pour exécuter Passim, comme le montrera la deuxième étude de cas. Néanmoins, ces étapes peuvent être utiles aux lecteurs ayant des besoins avancés en ce qui concerne le format et la structure des données d'entrée).

Il y a des cas où vous pouvez vouloir inclure des informations supplémentaires (c'est-à-dire des champs JSON) dans chaque document d'entrée, en plus des champs obligatoires (`id`, `series`, `text`). Par exemple, lorsque vous travaillez avec des données OCR, il est possible que vous souhaitiez passer les informations de coordonnées de l'image avec le texte de l'article. Passim supporte l'utilisation de données d'entrée qui suivent un format JSON personnalisé, car en coulisses, il s'appuie sur Spark pour déduire la structure des données d'entrée (c'est-à-dire le schéma JSON). Passim n'utilisera pas directement ces champs, mais il les conservera dans la sortie produite.

Cependant, il peut y avoir des cas où Spark ne parvient pas à déduire la structure correcte des données d'entrée (par exemple, en déduisant un type de données erroné pour un champ donné). Dans ces cas, vous devez informer Passim du schéma correct des données d'entrée. 

L'exemple suivant montre une approche pas à pas pour résoudre cette situation relativement rare où l'on doit corriger le schéma JSON déduit. Passim est livré avec la commande `json-df-schema`, qui exécute un script (Python) pour déduire le schéma à partir de n'importe quelle entrée JSON. Les étapes suivantes sont nécessaires pour déduire la structure à partir de n'importe quelle donnée JSON :

1. Installez les bibliothèques Python nécessaires.
  ```bash
  >>> pip install pyspark
  ```
2. Extrayez un exemple d'entrée à partir de l'un de nos fichiers d'entrée compressés.
  ```bash
  # ici nous prenons le 3ème document dans le fichier .bz2
  # et nous le sauvegardons dans un nouveau fichier local
  >>> bzcat impresso/data/GDL-1900.jsonl.bz2 | head | jq --slurp ".[2]" > impresso/data/impresso-sample-document.json
  ```
3. Demandez à `json-df-schema` de déduire le schéma de nos données à partir de notre fichier d'exemple.
  ```bash
  >>> json-df-schema impresso/data/impresso-sample-document.json > impresso/schema/Passim.schema.orig
  ```

`json-df-schema` tentera de deviner le schéma JSON des données d'entrée et de le sortir dans un fichier. L'exemple suivant nous montre à quoi ressemble le schéma généré par Passim  (`Passim.schema.orig`) :

```json
{
  "fields": [
    {
      "metadata": {},
      "name": "cc",
      "nullable": true,
      "type": "boolean"
    },
    {
      "metadata": {},
      "name": "date",
      "nullable": true,
      "type": "string"
    },
    {
      "metadata": {},
      "name": "id",
      "nullable": true,
      "type": "string"
    },
    {
      "metadata": {},
      "name": "pages",
      "nullable": true,
      "type": {
        "containsNull": true,
        "elementType": {
          "fields": [
            {
              "metadata": {},
              "name": "id",
              "nullable": true,
              "type": "string"
            },
            {
              "metadata": {},
              "name": "regions",
              "nullable": true,
              "type": {
                "containsNull": true,
                "elementType": {
                  "fields": [
                    {
                      "metadata": {},
                      "name": "coords",
                      "nullable": true,
                      "type": {
                        "fields": [
                          {
                            "metadata": {},
                            "name": "h",
                            "nullable": true,
                            "type": "long"
                          },
                          {
                            "metadata": {},
                            "name": "w",
                            "nullable": true,
                            "type": "long"
                          },
                          {
                            "metadata": {},
                            "name": "x",
                            "nullable": true,
                            "type": "long"
                          },
                          {
                            "metadata": {},
                            "name": "y",
                            "nullable": true,
                            "type": "long"
                          }
                        ],
                        "type": "struct"
                      }
                    },
                    {
                      "metadata": {},
                      "name": "length",
                      "nullable": true,
                      "type": "long"
                    },
                    {
                      "metadata": {},
                      "name": "start",
                      "nullable": true,
                      "type": "long"
                    }
                  ],
                  "type": "struct"
                },
                "type": "array"
              }
            },
            {
              "metadata": {},
              "name": "seq",
              "nullable": true,
              "type": "long"
            }
          ],
          "type": "struct"
        },
        "type": "array"
      }
    },
    {
      "metadata": {},
      "name": "series",
      "nullable": true,
      "type": "string"
    },
    {
      "metadata": {},
      "name": "text",
      "nullable": true,
      "type": "string"
    },
    {
      "metadata": {},
      "name": "title",
      "nullable": true,
      "type": "string"
    }
  ],
  "type": "struct"
}

```

Passim n'a pas reconnu que le champ de coordonnées contient des valeurs entières et il l'a interprété comme un type de données longues.  A ce stade, nous devons changer le type des sous-champs de `coords` (c'est-à-dire `h`, `w`, `x`, et `y`) de `"type": "long"` à `"type": "integer"`. Ce décalage de type doit être corrigé, sinon Passim traitera les valeurs `int` comme si elles étaient  `long`, menant potentiellement à des problèmes ou des incohérences dans la sortie générée.

Nous pouvons maintenant enregistrer le schéma dans un nouveau fichier  (`passim.schema`) pour une utilisation ultérieure. Ce schéma est nécessaire pour traiter les données d'entrée fournies pour [la deuxième étude de cas](#case-study-2:-text-reuse-in-a-large-corpus-of-historical-newspapers) présentée dans ce cours.

# Exécuter Passim

Dans cette section, nous illustrons l'utilisation de Passim avec deux études de cas distinctes : 1) la détection de citations bibliques dans des textes du XVIIe siècle et 2) la détection de réutilisation de textes dans un large corpus de journaux historiques. La première étude de cas met en évidence certaines bases de l'utilisation de Passim, tandis que la deuxième étude de cas contient de nombreux détails et les meilleures pratiques qui seraient utiles pour un projet de réutilisation de texte à grande échelle.

Dans le tableau suivant, nous nous basons sur la documentation originale de Passim et expliquons les paramètres les plus utiles que cette bibliothèque offre. Les études de cas ne vous obligent pas à maîtriser ces paramètres, alors n'hésitez pas à passer directement à la section [Téléchargement de Data](#downloading-the-data) et à revenir à cette section lorsque vous serez suffisamment à l'aise pour utiliser Passim sur vos propres données.

Paramètre | Valeur par défaut | Description | Explication
--------- | ------------- | ----------- | -----------
`--n` | 5 | Ordre des N-grammes pour la détection de réutilisation de textes | N-grammes sont des chaînes de mots de longueur N. Ce paramètre vous permet de décider de quel type de n-gramme (unigramme, bigramme, trigramme...) Passim doit utiliser lors de la création d'une liste de candidats possibles à la réutilisation de textes.<br /><br />Régler ce paramètre à une valeur plus faible peut aider dans le cas de textes très bruyants (c'est-à-dire lorsque de nombreux mots d'un texte sont affectés par une ou plusieurs erreurs d'OCR). En effet, plus le n-gramme est long, plus il est susceptible de contenir des erreurs d'OCR.
`--minDF` (`-l`) | 2 | Limite inférieure de la fréquence de document des n-grammes utilisés | Puisque les n-grammes sont utilisés dans Passim pour retrouver des paires de documents candidats, un n-gramme n'apparaissant qu'une seule fois n'est pas utile car il ne retrouvera qu'un seul document (et non une paire). Pour cette raison, la valeur par défaut de `--minDF` est de `2`.
`--maxDF` (`-u`)| 100 | Limite supérieure de la fréquence du document pour les n-grammes utilisés. | Ce paramètre permettra de filtrer les n-grammes trop fréquents, donc apparaissant de nombreuses fois dans un document donné. <br /><br />Cette valeur a un impact sur les performances, car elle va réduire le nombre de paires de documents récupérés par Passim qui devront être comparés.
`--min-match` (`-m`)| 5 | Nombre minimum de n-grams correspondants entre deux documents | Ce paramètre vous permet de décider combien de n-grams doivent être trouvés entre deux documents.
`--relative-overlap` (`-o`)| 0.8 | Proportion que deux passages alignés différents du même document doivent se chevaucher pour être regroupés, mesurée sur le passage le plus long. <!-- TODO SH: Current mismatch between official doc and code, see what is going to be changed after David answers to this issue https://github.com/dasmiq/Passim/issues/10 --> | Ce paramètre détermine le degré de similarité des chaînes de caractères que deux passages doivent avoir pour être regroupés.<br /><br />Dans le cas de textes très bruyants, il peut être souhaitable de fixer ce paramètre à une valeur plus petite.
`--max-repeat` (`-r`)| 10 | Répétition maximale d'une série dans un groupe | Ce paramètre vous permet de préciser la quantité potentiellement présente d'une série donnée dans un groupe.


## Downloading the data

Sample data needed to run the command examples in the two case studies can be downloaded from the [dedicated GitHub repository](https://github.com/impresso/PH-Passim-tutorial). Before continuing with the case studies, download a local copy of the data by cloning the repository.

```bash
>>> git clone https://github.com/impresso/PH-Passim-tutorial.git
```

Alternatively, it is possible to download the data for this lesson from Zenodo at the address https://zenodo.org/badge/latestdoi/250229057.



## Case study 1: Bible Quotes in Seventeenth Century Texts

In this first case study, we will look at text reuse using texts taken from [EEBO-TCP](https://textcreationpartnership.org/tcp-texts/eebo-tcp-early-english-books-online/) Phase I, the publicly available keyed-in version of Early English Books Online provided by the Text Creation Partnership. This case study is a special case of text reuse, as we are not focusing at inter-authors text reuse, but rather at the influence a single book — in this case, the Bible in its published-in-1611 King James version — had on several authors. Can we detect what documents contain extracts from the Bible?

As this is a small-scale example of what an actual research question making use of text reuse methods could look like, we will only use some of the 25,368 works available in EEBO-TCP, taken randomly. This smaller selection size should also allow anyone reading this tutorial to run this example on their personal laptop. Ideally, we recommend using a corpus such as [Early Modern Multiloquent Authors (EMMA)](https://www.uantwerpen.be/en/projects/mind-bending-grammars/emma-corpus/), compiled by the University of Antwerp's [Mind Bending Grammars](https://www.uantwerpen.be/en/projects/mind-bending-grammars/) project, should someone want to properly study the use of Bible quotes in seventeenth century texts. This corpus has the advantage of providing hand-curated metadata in an easily parseable format, allowing any researcher to focus on specific authors, periods, etc.

### Extracting the Data

At the root of the newly-created directory is a JSON file: `passim_in.json`. This file contains all our data, in the format described above: one document per line (`text`), structured with the bare minimum of required metadata (`id`, `series`). As this is a small file, we encourage you to open the file using a text editor such as Notepad++ on Windows or Sublime on Linux/macOS to familiarise yourself with how the data is formatted. Because our case study focuses on the detection of Bible passages in several documents and not on text reuse within all documents, we have formatted the data so that the `series` field contains `bible` for the Bible (last line of our JSON file), and `not_bible` for all other documents. Passim does not analyse documents that belong to the same series, so this effectively tells the software to only compare all documents with the Bible — not with each other.

The [accompanying Github repository](https://github.com/impresso/PH-Passim-tutorial/) contains a [Python script](https://github.com/impresso/PH-Passim-tutorial/blob/master/eebo/code/main.py) to transform EEBO-TCP into the JSON format required by Passim and used in this lesson. We encourage the readers to reuse it and adapt it to their needs.

### Running Passim

Create a directory where you want to store the output of Passim (we use `Passim_output_bible` but any name will work). If you decide to use the default `Passim_output_bible` directory, ensure you remove all of its content (i.e. pre-computed Passim output) either manually or by running `rm -r ./eebo/Passim_output_bible/*`.

As we will see in more detail in the second use case, Passim, through Spark, allows for many options. By default Java does not allocate much memory to its processes, and running Passim even on very little datasets will cause Passim to crash because of an `OutOfMemory` error — even if you have a machine with a lot of RAM. To avoid this,  when calling Passim we add some additional parameters that will tell Spark to use more RAM for its processes.

You are now ready to go forward with your first text reuse project. 

1. Move to the sub-directory `eebo` by executing the command `cd eebo/`, starting from the directory where, earlier on, you cloned the repository [`PH-Passim-tutorial`](https://github.com/impresso/PH-Passim-tutorial/).

2. Run the following command and go have a cup of your favorite hot beverage:
```bash
>>> SPARK_SUBMIT_ARGS='--master local[12] --driver-memory 8G --executor-memory 4G' passim passim_in.json passim_output_bible/
```

For now, do not worry about the additional arguments `SPARK_SUBMIT_ARGS='--master local[12] --driver-memory 8G --executor-memory 4G'`; in the section ["Case Study 2"](#case-study-2:-text-reuse-in-a-large-corpus-of-historical-newspapers) we will explain them in detail.

This test case takes approximatively eight minutes on a recent laptop with eight threads. You can also follow the progress of the detection at http://localhost:4040 — an interactive dashboard created by Spark (Note: the dashboard will shut down as soon as Passim has finished running).

## Case study 2: Text Reuse in a large corpus of historical newspapers

The second case study is drawn from [impresso](https://impresso-project.ch/), a recent research project aimed at enabling critical text mining of newspaper archives with the implementation of a technological framework to extract, process, link, and explore data from print media archives.

In this project, we use Passim to detect text reuse at scale. The extracted text reuse clusters are then integrated into the [impresso tool](https://impresso-project.ch/app) in two ways. First, in the main article reading view users can readily see which portions of an article were reused by other articles in the corpus. Second, users can browse through all clusters in a dedicated page (currently more than 6 million), perform full-text searches on their contents, and filter the results according to a number of criteria (cluster size, time span covered, lexical overlap, etc.).

More generally, detecting text reuse in a large-scale newspaper corpus can be useful in many of the following ways:
* Identify (and possibly filter out) duplicated documents before performing further processing steps (e.g. topic modelling)
* Study the virality and spread of news
* Study information flows, both within and across national borders
* to allow users discover which contents, within in their own collections, generated text reuse (e.g. famous political speeches, portions of national constitutions, etc.)

For this case study we consider a tiny fraction of the *impresso* corpus, consisting of one year's worth of newspaper data (i.e. 1900) for a sample of four newspapers. The corpus contains 76 newspapers from Switzerland and Luxembourg, covering a time span of 200 years. The sample data necessary to run step by step this case study are contained in the folder [`impresso/`](https://github.com/impresso/PH-Passim-tutorial/tree/master/impresso).

### Data preparation

The format used in impresso to store newspapers data is slightly different from Passim's input format so we need a script to take care of transforming the former into the latter. While discussing how this script works goes well beyond the scope of this lesson, you can find the conversion script on the [impresso GitHub repository](https://github.com/impresso/impresso-pycommons/blob/master/impresso_commons/text/rebuilder.py) should you be interested. The output of this script is one JSON line file per newspaper per year, compressed into a `.bz2` archive for the sake of efficient storage. Examples of this format can be found in the directory `impresso/data` and shown in the following example:

```
>>> ls -la impresso/data/
EXP-1900.jsonl.bz2
GDL-1900.jsonl.bz2
IMP-1900.jsonl.bz2
JDG-1900.jsonl.bz2
```

Each newspaper archive is named after the newspaper identifier: for example, `GDL` stands for *Gazette de Lausanne*. In total, these four `.bz2` files contain 92,000 articles through Passim, corresponding to all articles published in 1900 in the four sampled newspapers.

Sometimes it's not easy to inspect data packaged in this way. But some Bash commands like `bzcat` and `jq` can help us. For example, with the following chain of commands we can find out how many documents (newspaper articles) are contained in each of the input files by counting their IDs:

```
>>> bzcat impresso/data/GDL-1900.jsonl.bz2 | jq --slurp '[.[] |del(.pages)| .id]|length'
28380
```

And similarly, in all input files:
```
>>> bzcat impresso/data/*-1900.jsonl.bz2 | jq --slurp '[.[] |del(.pages)| .id]|length'
92514
```

What these commands do is to read the content of the `.bz2` file by means of `bzcat` and then *pipe* this content into `jq` which
- iterates through all docouments in the JSON line file
- for each document it removes the `pages` field as it's not needed and selects only the `id` field
- finally, with `length` `jq` computes the size of the list of IDs created by the previous expression

### Running Passim

To run the impresso data through Passim, execute the following command in a `Terminal` window:

```
SPARK_SUBMIT_ARGS='--master local[12] --driver-memory 10G --executor-memory 10G --conf spark.local.dir=/scratch/matteo/spark-tmp/' Passim --schema-path="impresso/schema/Passim.schema" "impresso/data/*.jsonl.bz2" "impresso/Passim-output/"
```

This command is made up of the following parameters:
- **`SPARK_SUBMIT_ARGS`** passes some configuration parameters to Spark, the library that takes care of parallel execution of processes.
    - `--master local[10]`: `local` means we are running Spark in single machine-mode; `[10]` specifies the number of workers (or threads, in this specific case) over which processes should be distributed (`local [*]` will make use of the maximum number of threads);  
    - `--executor-memory 4G`: The equivalent of the maximum heap size when running a regular JAVA application. It's the amount of memory that Spark allocates to each executor.
    - `--conf spark.local.dir=/scratch/matteo/spark-tmp/`: A directory where Spark stores temporary data. When working with large datasets, it is important to specify a location with sufficient free disk space.
- **`--schema-path`**: Specifies the path to the JSON schema describing the input data to be ran through Passim (see section ["Custom JSON format"](#custom-json-format) for more information about how to generate such schema).
- **`impresso/data/*.jsonl.bz2`**: Specifies the input files (i.e. all files contained in `impresso/data/` with `.jsonl.bz2` in the file name);
- **`impresso/Passim-output/`**: Specifies where Passim should write its output

If you want to limit the processing to a couple of input files — for example to limit memory usage — you can specify the input using the following command:

```
impresso/data/{EXP-1900.jsonl.bz2,GDL-1900.jsonl.bz2}.jsonl.bz2
```

You can monitor Passim's progress while running by pointing your browser to the address `localhost:4040` where the Spark dashboard can be accessed (Figure 2).

{% include figure.html filename="spark-dashboard.png" caption="Figure 2. Screenshot of the Spark dashboard while running Passim." %}

Running Passim with eight workers (and 4 Gb of executor memory) takes about five minutes to process the 92,514 articles published in 1900 in the newspapers GDL, JDG, EXP, IMP (but your mileage may vary).

If you provide as input a folder with `*.bz2` files, ensure these files are not found within subdirectories or Passim will not be able to find them automatically.

It is important that the output folder where Passim will write its output is empty. Especially when running the first experiments and getting familiar with the software it can very easily happen to specify a non-empty output folder. Specifying a non-empty output folder usually leads to an error as Passim processes the folder content and does not simply overwrite it.

### Inspecting Passim's Output

Once Passim has finished running, the output folder `impresso/Passim-output/` will contain a sub-folder `out.json/` with the extracted text reuse clusters. If you specified `--output=parquet` instead of `--output=json`, this sub-folder will be named `out.parquet`.

In the JSON output each document corresponds to a text reuse passage. Since passages are aggregated into clusters, each passage contains a field `cluster` with the ID of the cluster to which it belongs.

To obtain the total number of cluster, we can count the number of unique cluster IDs with the following one-line command:


```bash
>>> cat impresso/Passim-output/out.json/*.json | jq --slurp '[.[] | .cluster] | unique | length'

2721
```
Similarly, we can print the 100th cluster ID:
```bash
>>> cat impresso/Passim-output/out.json/*.json | jq --slurp '[.[] | .cluster] | unique | .[100]'

77309411592
```
And with a simple `jq` query we can print all passages belonging to this text reuse cluster:
```
>>> cat impresso/Passim-output/out.json/*.json | jq --slurp '.[] | select(.cluster==77309411592)|del(.pages)'
```

```json
{
  "uid": -6695317871595380000,
  "cluster": 77309411592,
  "size": 2,
  "bw": 8,
  "ew": 96,
  "cc": true,
  "date": "1900-07-30",
  "id": "EXP-1900-07-30-a-i0017",
  "series": "EXP",
  "text": "nouvel accident de\nmontagne : Le fils dû guide Wyss, de\nWilderswil, âgé de 17 ans, accompagnait\nvendredi un touriste italien dans l'as-\ncension du Petersgrat En descendant sur\nle glacier de Tschingel, le jeune guide\ntomba dans une crevasse profonde de\n25 mètres. La corde était trop courte\npour l'en retirer, et des guides appelés\nà son secours ne parvinrent pas non\nplus à le dégager. Le jeune homme crie\nqu'il n'est pas blessé. Une nouvelle co-\nlonne de secours est partie samedi de\nLauterbrunnen.\nAarau, 28 juillet.\n",
  "title": "DERNIÈRES NOUVELLES",
  "gid": -8329671890893709000,
  "begin": 53,
  "end": 572
}
{
  "uid": -280074845860282140,
  "cluster": 77309411592,
  "size": 2,
  "bw": 2,
  "ew": 93,
  "cc": true,
  "date": "1900-07-30",
  "id": "GDL-1900-07-30-a-i0016",
  "series": "GDL",
  "text": "NOUVEAUX ACCIOENTS\nInterlaken. 29 juillet.\nLe fils du guide Wyss, de Wilderswil, âgé\nde dix-sept ans, accompagnait, vendredi, un\ntouriste italien dans l'ascension du Peters-\ngrat.\nEn descendant sur le glacier de Tschingel,\nU jeune guide tomba dans une crevasse pro-\nfonde de vingt-cinq mètres. La corde était trop\ncourte pour l'en retirer, et des guides appelés\nà son secours ne parvinrent pas non plus à le\ndégager. Le jeune homme crie qu'il n'est pas\nblessé. Une nouvelle colonne de secours est\npartie samedi de Lauterbrunnen.\nChamonix, 28 juillet.\n",
  "title": "(Chronique alpestre",
  "gid": 2328324961100034600,
  "begin": 20,
  "end": 571
}
```

As you can see from the output above, this cluster contains the same piece of news — a mountain accident which happened in Interlaken on 30 July 1900 — reported by two different newspapers on the very same day with slightly different words.

# Using Passim's Output

Since the usage of text reuse data ultimately depends on the research questions at hand — and there many possible applications of text reuse, as we have seen above — covering how to use Passim's output falls beyond the scope of this lesson.

Code that 'does something' with the data output by Passim can be written in many different programming languages. Extracted clusters can be used to deduplicate documents in a corpus, or even collate together multiple witnesses of the same text, but this will entirely depend on the research context and specific use case.

To given an example of where to go next, for those who want to manipulate and further analyse text reuse data in Python, we provide a Jupyter notebook ([`explore-Passim-output.ipynb`](https://github.com/impresso/PH-Passim-tutorial/blob/master/explore-Passim-output.ipynb)) that shows how to import Passim's JSON output into a `pandas.DataFrame` and how to analyse the distribution of text reuse clusters in both uses cases presented above. For readers that are not familair with the Python library `pandas`, the *Programming Historian* lesson written by Charlie Harper on [*Visualizing Data with Bokeh and Pandas*](https://programminghistorian.org/en/lessons/visualizing-with-bokeh) is a nice (and required) introductory reading.

The code contained and explained in the notebook will produce the two plots of Figures 3 and 4, showing how the sizes of text reuse clusters are distributed in the impresso and Bible data respectively.


{% include figure.html filename="plot-impresso.png" caption="Figure 3. Distribution of text reuse cluster sizes in the impresso sample data." %}

{% include figure.html filename="plot-bible.png" caption="Figure 4. Distribution of text reuse cluster sizes in the Bible sample data." %}

As you can see from the plots, in both cases the majority of text reuse clusters contains at most two passages. In the impresso sample data, however, there is much more variance in the size of clusters, with 10% of them having a size comprised between 6 and 296 passages, as opposed to the Bible data where the maximum cluster size is 3.

# Further readings

**Passim**
- Smith et al. (2015) introduce in detail the text reuse detection algorithm implemented in Passim
- Cordell (2015) applied Passim to study text reuse within a large corpus of American newspapers

**textreuse**

- Vogler et al. (2020) apply the `textreuse` R package \cite{mullen2016} to study the phenomenon of *media concentration* in contemporary journalism

**TRACER**
- Büchler et al. (2014) explain the algorithms for text reuse detection that are implemented in TRACER;
- Franzini et al. (2018) use and evaluate TRACER for the extraction of quotations from a Latin text (the *Summa contra Gentiles* of Thomas Aquinas)

**BLAST**
- Vierthaler et al. (2019) use the BLAST alignment algorithm to detect reuse in Chinese texts
- Vesanto et al. (2017) and Salmi et al. (2019) apply BLAST to a comprehensive corpus of newspapers published in Finland

# Acknowledgements

A sincere thanks goes to Marco Büchler and Ryan Muther for reviewing this lesson, as well as to our colleagues Marten Düring and David Smith for their constructive feedback on an early version of this tutorial. Additional thanks go to Anna-Maria Sichani for serving as editor.

The authors warmly thank the newspaper [Le Temps](https://letemps.ch/) — owner of *La Gazette de Lausanne* (GDL) and the *Journal de Genève* (JDG) — and the group [ArcInfo](https://www.arcinfo.ch/) — owner of *L’Impartial* (IMP) and *L’Express* (EXP) —  for accepting to share their data for academic purposes.

MR gratefully acknowledges the financial support of the Swiss National Science Foundation (SNSF) for the project [*impresso – Media Monitoring of the Past*](https://impresso-project.ch/) under grant number CR-SII5_173719. SH's work was supported by the European Union’s Horizon 2020 research and innovation programme under grant 770299 ([NewsEye](https://www.newseye.eu/)). SH was affiliated with the University of Helsinki and the University of Geneva for most of this work, and is currently funded by the project *Towards Computational Lexical Semantic Change Detection* supported by the Swedish Research Council (20192022; dnr 2018-01184).

# Bibliography

1. Greta Franzini, Maria Moritz, Marco Büchler, Marco Passarotti. Using and evaluating TRACER for an Index fontium computatus of the Summa contra Gentiles of Thomas Aquinas. In *Proceedings of the Fifth Italian Conference on Computational Linguistics (CLiC-it 2018)*. (2018). [Link](http://ceur-ws.org/Vol-2253/paper22.pdf)
2. David A. Smith, Ryan Cordell, Abby Mullen. Computational Methods for Uncovering Reprinted Texts in Antebellum Newspapers. *American Literary History* **27**, E1–E15 Oxford University Press, 2015. [Link](http://dx.doi.org/10.1093/alh/ajv029)
3. Ryan Cordell. Reprinting Circulation, and the Network Author in Antebellum Newspapers. *American Literary History* **27**, 417–445 Oxford University Press (OUP), 2015. [Link](http://dx.doi.org/10.1093/alh/ajv028)
4. Daniel Vogler, Linards Udris, Mark Eisenegger. Measuring Media Content Concentration at a Large Scale Using Automated Text Comparisons. *Journalism Studies* **0**, 1–20 Taylor & Francis, 2020. [Link](http://dx.doi.org/10.1080/1461670x.2020.1761865)
5. Lincoln Mullen. textreuse: Detect Text Reuse and Document Similarity. (2016). [Link](https://github.com/ropensci/textreuse)
6. Marco Büchler, Philip R. Burns, Martin Müller, Emily Franzini, Greta Franzini. Towards a Historical Text Re-use Detection. 221–238 In *Text Mining: From Ontology Learning to Automated Text Processing Applications*. Springer International Publishing, 2014. [Link](http://dx.doi.org/10.1007/978-3-319-12655-5_11)
8. Paul Vierthaler, Meet Gelein. A BLAST-based, Language-agnostic Text Reuse Algorithm with a MARKUS Implementation and Sequence Alignment Optimized for Large Chinese Corpora. *Journal of Cultural Analytics* (2019). [Link](http://dx.doi.org/10.22148/16.034)
9. Aleksi Vesanto, Asko Nivala, Heli Rantala, Tapio Salakoski, Hannu Salmi, Filip Ginter. Applying BLAST to Text Reuse Detection in Finnish Newspapers and Journals, 1771-1910. 54–58 In *Proceedings of the NoDaLiDa 2017 Workshop on Processing Historical Language*. Linköping University Electronic Press, 2017. [Link](https://www.aclweb.org/anthology/W17-0510)
10. Hannu Salmi, Heli Rantala, Aleksi Vesanto, Filip Ginter. The long-term reuse of text in the Finnish press, 1771–1920. **2364**, 394–544 In *CEUR Workshop Proceedings*. (2019).
11. Axel J Soto, Abidalrahman Mohammad, Andrew Albert, Aminul Islam, Evangelos Milios, Michael Doyle, Rosane Minghim, Maria Cristina de Oliveira. Similarity-Based Support for Text Reuse in Technical Writing. 97–106 In *Proceedings of the 2015 ACM Symposium on Document Engineering*. ACM, 2015. [Link](http://dx.doi.org/10.1145/2682571.2797068)
12. Alexandra Schofield, Laure Thompson, David Mimno. Quantifying the Effects of Text Duplication on Semantic Models. 2737–2747 In *Proceedings of the 2017 Conference on Empirical Methods in Natural Language Processing*. Association for Computational Linguistics, 2017. [Link](http://dx.doi.org/10.18653/v1/D17-1290)
13. Matteo Romanello, Aurélien Berra, Alexandra Trachsel. Rethinking Text Reuse as Digital Classicists. *Digital Humanities conference*, 2014. [Link](http://dharchive.org/paper/DH2014/Panel-106.xml)
