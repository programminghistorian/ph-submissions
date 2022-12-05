---
title: La lecture multi-échelles de données structurées
collection: lecons
layout: lesson
slug: lecture-multi-echelles-donnees-structurees
date: AAAA-MM-JJ
translation_date: 2022-07-06
authors:
- Max Odsbjerg Pedersen 1
- Josephine Møller Jensen 2
- Victor Harbo Johnston 3
- Alexander Ulrich Thygelsen 4
- Helle Strandgaard Jensen 5
reviewers:
- Frédéric Clavert
- Tiago Sousa Garcia
editors:
- James Baker
translator:
- Anne-Laure Fréant
translation-editor:
- Sofia Papastamkou
translation-reviewer:
- Hugues Pecout
- Thomas Soubiran
original: scalable-reading-of-structured-data
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/482
difficulty: 2
activity: analyzing
topics: [api]
abstract: Cette leçon offre une introduction à la lecture multi-échelles et à son application à l'analyse de données structurées
avatar_alt: 
doi:
---

{% include toc.html %}


# Objectifs de la leçon 

Une fois cette leçon complétée, les lecteurs et lectrices seront en mesure de :
 * configurer un processus de travail où la lecture exploratoire distante est utilisée en tant que contexte pour guider la sélection de points de données en vue d'une lecture proche 
 * faire appel aux analyses exploratoires pour identifier des schémas au sein de données structurées
 * appliquer et combiner des filtres de base et ajuster les fonctions dans R (si vous n'avez pas ou peu de connaissances de R, nous recommandons de consulter la leçon [&laquo;&#x202F;Les bases de R avec des données tabulaires&#x202F;&raquo;](/en/lessons/r-basics-with-tabular-data) (en anglais).


# Structure de la leçon

Dans cette leçon, nous introduisons un processus de travail pour une lecture multi-échelles (*scalable reading*) de données structurées - une combinaison d'interprétation rigoureuse de points de données individuels et d'analyse statistique du jeu de données entier. 
Cette leçon est structurée en deux cheminements parallèles :
* un cheminement général qui suggère une façon de travailler analytiquement avec des données structurées où la lecture distante d'un grand jeu de données est 
utilisée comme contexte pour une lecture proche de points de données distincts ;
* un cheminement basé sur un exemple dans lequel nous utilisons des fonctions simples du langage de programmation R pour analyser des données Twitter.
En combinant ces deux cheminements, nous montrons comment la lecture multi-échelles peut être employée pour analyser une large variété de données structurées.
Notre processus de travail évolutif suggéré inclut deux types de lectures distantes qui peuvent aider à explorer et analyser les caractéristiques globales de grands jeux de données (chronologiquement et en relation avec des structures binaires), en plus de permettre l'utilisation de la lecture distante pour sélectionner des points de données individuels pour une lecture proche (*close reading*) de manière systématique et reproductible.

# La lecture multi-échelles, une introduction aux méthodes digitales pour les débutant(e)s

La combinaison de lecture distante (*distant reading*) et de lecture proche (*close reading*) introduites dans cette leçon est entendue comme une introduction aux méthodes digitales pour les étudiants et les chercheurs qui débutent dans l'incorporation du raisonnement computationnel à leur travail. En connectant la lecture distante de grands jeux de données à la lecture proche de points de données individuels, vous créez un pont entre les méthodes computationnelles et les méthodes de curation manuelles communément employées dans les humanités. D'après notre expérience, la lecture multi-échelles - où l'analyse d'un jeu de données entier représente un ensemble de contextes pour la lecture proche - prévient les difficultés que les personnes débutantes peuvent rencontrer en interrogeant leur matériel via le raisonnement computationnel. La manière reproductible de sélectionner chaque cas individuellement pour un examen approfondi éclaire, par exemple, les questions centrales au sein de disciplines comme l'histoire et la sociologie concernant les relations entre un contexte général et un cas d'étude particulier, mais peut aussi être utile à d'autres disciplines des humanités qui travaillent avec des cadres analytiques similaires. 

# La lecture multi-échelles

Nous avons utilisé à l'origine le processus de travail présenté ci-dessous pour analyser les souvenirs que les enfants états-uniens ont du programme télévisé *Sesame Street* sur Twitter. Nous avons utilisé une combinaison de lecture proche (*close reading*) et de lecture distante (*distant reading*) pour découvrir comment certains évènements ont généré des discussions sur l'histoire de *Sesame Street*, quels utilisateurs de Twitter dominaient le discours à propos de l'histoire de *Sesame Street*, et quelles parties de l'histoire de l'émission étaient mises en exergue. Notre exemple ci-dessous utilise un petit jeu de données en lien avec les tweets concernant *Sesame Street*. Toutefois, le même cadre analytique peut être utilisé pour analyser de nombreux autres types de données structurées.
Afin de démontrer l'applicabilité du processus de travail sur d'autres types de données, nous abordons comment ce dernier pourrait être appliqué à des ensembles de données structurées depuis les collections numérisées de la [Galerie nationale du Danemark](https://fr.wikipedia.org/wiki/Statens_Museum_for_Kunst). Les données de la Galerie nationale sont très différentes des données Twitter utilisées dans l'exemple, mais l'idée d'utiliser la lecture distante pour contextualiser un travail de lecture proche s'applique aussi bien qu'avec des données Twitter.

Le processus de travail pour la lecture multi-échelles de données structurées que nous proposons ci-dessous se présente en trois étapes :

1. **L'exploration chronologique du jeu de données**. Dans le jeu de données Twitter, nous explorons comment un phénomène spécifique génère de l'intérêt sur la plateforme durant une certaine période de temps. Dans le cas des données de la Galerie Nationale, nous aurions pu analyser la distribution temporelle de leurs collections, c'est-à-dire classer les données par année d'acquisition ou par année de création des oeuvres.
2. **Explorer un jeu de données en créant des catégories analytiques binaires**. Cette étape suggère l'utilisation de catégories existantes de métadonnées pour créer des questions de nature binaire, soit des questions qui appellent une réponse de type oui/non ou vrai/faux. Nous utilisons la création d'une structure analytique binaire comme moyen d'étudier les tendances générales d'un jeu de données. Dans le jeu de données Twitter, nous explorons l'usage des hashtags (versus leur non usage); la distribution des tweets via des comptes vérifiés versus des comptes non vérifiés, et le niveau d'interaction pour ces deux types de comptes. Dans le cas de la Galerie nationale, nous aurions pu utiliser les métadonnées sur le type d'oeuvre d'art, le genre et la nationalité pour explorer la représentation des artistes danois versus les autres nationalités d'artistes; les peintures versus les autres types d'oeuvres; ou encore les artistes par genre, etc.
3. **Sélection systématique de points de données uniques pour la lecture proche**. Cette étape suggère une manière systématique et reproductible de sélection de points de données uniques pour la lecture proche. Dans le jeu de données Twitter, nous avons sélectionné pour la lecture proche les 20 tweets les plus likés. Dans le cas de la Galerie nationale, nous aurions pu choisir par exemple les 20 oeuvres les plus exposées, empruntées ou annotées.

Ci-dessous, les trois étapes sont expliquées en des termes généraux mais aussi plus spécifiquement à partir de l'exemple des données Twitter.

# Données et prérequis

Si vous souhaitez reproduire l'analyse que nous présentons ci-dessous, en utilisant non seulement le cadre conceptuel de travail mais aussi le code, nous partons du principe que vous avez déjà à disposition un jeu de données contenant des données Twitter au format JSON. Si ce n'est pas le cas, vous pouvez vous en acquérir un par les méthodes suivantes :

1. Utiliser l'une des APIs de Twitter, c'est-à-dire leur API dite essentielle (*Essential access*) que nous avons utilisée pour récupérer le jeu de données utilisé dans l'exemple (pour en savoir plus sur les APIs, vous pouvez consulter [cette section de la leçon sur introduire et peupler un site web avec des données API](/en/lessons/introduction-to-populating-a-website-with-api-data#what-is-application-programming-interface-api)(en anglais). Ce lien vous mènera [aux options API de Twitter](https://developer.twitter.com/en/docs/twitter-api/getting-started/about-twitter-api). Vous pouvez utiliser le paquet 'rtweet' , avec vos propres identifiants Twitter pour accéder à l'API Twitter via R, comme décrit ci-dessous.
2. Utiliser la [leçon pour débuter avec les données Twitter](/en/lessons/beginners-guide-to-twitter-data) par Programming Historian. Choisissez de préférence un export des données en JSON au lieu du CSV.

Dans R, vous travaillez avec des paquets (*packages*), chacun ajoutant des fonctionnalités aux fonctions de base de R. Les paquets sont souvent créés de manière communautaire et rendus disponibles à la réutilisation. En recourant aux paquets, vous vous tenez sur les épaules d'autres codeurs. Dans cet exemple, les paquets que nous allons utiliser sont les suivants : rtweet, tidyverse, libridate et jsonlite. Pour installer ces paquets dans R, consultez [cette section de la leçon sur le traitement de texte dans R](/en/lessons/basic-text-processing-in-r#package-set-up) (en anglais). Pour utiliser les paquets dans R, il faut les charger via la fonction `library()` comme ci-dessous :

```
library(rtweet)
library(tidyverse)
library(lubridate)
library(jsonlite)
```
     
Afin de pouvoir suivre les exemples de code, assurez-vous d'avoir installé et chargé les paquets R suivants :

## tidyverse
Le paquet tidyverse est un paquet parapluie qui charge plusieurs librairies toutes utiles lorsqu'il s'agit de travailler avec des données. Pour plus d'informations et savoir comment utiliser tidyverse, voir [https://www.tidyverse.org](https://www.tidyverse.org)[^1].

## lubridate
Le paquet lubridate est utilisé pour manipuler différents formats de dates dans R, ainsi qu'effectuer des opérations sur ces dates. Le paquet a été créé par le même groupe que celui derrière tidyverse mais ne fait pas partie de ce dernier[^2].

## jsonlite
Le paquet jsonlite permet de manipuler le format Javascript Object Notation (json), format utilisé pour échanger des données sur internet. Pour plus d'informations sur le paquet jsonlite, voir : [https://cran.r-project.org/web/packages/jsonlite/index.html3](https://cran.r-project.org/web/packages/jsonlite/index.html3)[^3]

Si vous êtes déjà en possession d'un fichier json contenant vos données twitter, vous pouvez utiliser la fonction `fromJSON` dans le paquet jsonlite pour importer les données dans votre environnement R.

## rtweet
Le paquet rtweet est une implémentation d'appels destinés à collecter et à organiser des données Twitter via l'API REST et l'API stream de Twitter, qui se trouve à l'adresse suivante : [https://developer.twitter.com/en/docs](https://developer.twitter.com/en/docs)[^4]

Si vous avez déjà acquis des données Twitter et que vous souhaitez suivre les exemples de code étape par étape, vous pouvez utiliser votre compte Twitter et la fonction `search_tweets()` du paquet rtweet, pour importer vos données Twitter dans votre environnement R. Cette opération va retourner jusqu'à 18 000 tweets datant des 10 derniers jours. Les données vont être structurées en tableau de données (*dataframe*). Tout comme une feuille de calcul, un tableau de données organise vos données en un tableau à deux dimensions avec des lignes et des colonnes. En copiant le code ci-dessous, vous serez capable de générer un tableau de données basé sur une recherche textuelle libre du terme "sesamestreet" pour suivre notre exemple. Le paramètre q représente votre requête. C'est à cette place qu'il faut taper le contenu qui vous intéresse. Le paramètre n indique le nombre de tweets à retourner.

```
sesamestreet_data <- search_tweets(q = "sesamestreet", n = 18000)
```

# Etape 1 - Exploration chronologique du jeu de données

Explorer les dimensions chronologiques d'un jeu de données peut faciliter la première analyse globale de vos données. Dans le cas où vous étudiez l'évolution d'un phénomène au cours du temps (comme notre intérêt autour des évènements précis ayant déclenché des discussions sur Sesame Street), comprendre comment ce phénomène a généré de l'attention et/ou comment cet intérêt diminue peut être révélateur de son importance. Cela peut constituer la première étape de compréhension de la manière dont les données collectées se rapportent au phénomène au cours du temps. L'intérêt pour la dispersion temporelle peut aussi se raporter non pas à un évènement mais plutôt à la distribution totale d'un jeu de données sur la base d'un ensemble de catégories.
Par exemple, dans le cas où vous travaillez avec les données de la Galerie Nationale, il peut s'avérer utile d'explorer la distribution des collections en fonction des différentes périodes d'histoire de l'art afin d'établir quelles périodes sont les mieux représentées dans le jeu de données de la Galerie Nationale. Connaître la dispersion temporelle de l'ensemble du jeu de données aide à contextualiser les points de données individuels sélectionnés pour une lecture proche à l'étape 3 en cela qu'elle donne une idée de la relation spécifique entre le point de donnée et la chronologie du jeu de données entier, en comparaison de tous les autres points de données.

## Exemple de dispersion temporelle du jeu de données avec les données Twitter

Dans cet exemple, vous allez découvrir à quel point Sesame Street est discuté sur Twitter pendant une certaine période de temps. Vous allez aussi voir combien de tweets utilisent le hashtag officiel #sesamestreet durant cette période.
Dans ce qui suit, vous commencez par un traitement de la donnée avant de passer à la visualisation. Vous interrogez les données via une question en deux parties:
- premièrement, vous voulez connaître la dispersion des tweets au cours du temps,
- deuxièmement, vous voulez savoir combien de ces tweets contiennent le hashtag "#sesamestreet" <br/>

La deuxième question requiert un tri préalable des données avant qu'il soit possible d'y répondre.

```
sesamestreet_data %>% 
mutate(has_sesame_ht = str_detect(text, regex("#sesamestreet", ignore_case = TRUE))) %>% 
mutate(date = date(created_at)) %>% 
count(date, has_sesame_ht)
```



        ## # A tibble: 20 x 3
    ##    date       has_sesame_ht     n
    ##    <date>     <lgl>         <int>
    ##  1 2021-12-04 FALSE            99
    ##  2 2021-12-04 TRUE             17
    ##  3 2021-12-05 FALSE           165
    ##  4 2021-12-05 TRUE             53
    ##  5 2021-12-06 FALSE           373
    ##  6 2021-12-06 TRUE             62
    ##  7 2021-12-07 FALSE           265
    ##  8 2021-12-07 TRUE             86
    ##  9 2021-12-08 FALSE           187
    ## 10 2021-12-08 TRUE             93
    ## 11 2021-12-09 FALSE           150
    ## 12 2021-12-09 TRUE             55
    ## 13 2021-12-10 FALSE           142
    ## 14 2021-12-10 TRUE             59
    ## 15 2021-12-11 FALSE           196
    ## 16 2021-12-11 TRUE             41
    ## 17 2021-12-12 FALSE           255
    ## 18 2021-12-12 TRUE             44
    ## 19 2021-12-13 FALSE            55
    ## 20 2021-12-13 TRUE             35

Ce processus permet la création d'une nouvelle colonne à laquelle est attribuée une valeur TRUE (vrai) si le tweet contient le hashtag et FALSE (faux) si ce n'est pas le cas. Ceci est obtenu avec la fonction `mutate()`, qui crée une nouvelle colonne nommée "has_sesame_ht" (contient le hashtag "sesame"). Pour ajouter les valeurs TRUE/FALSE dans cette colonne, la fonction utilisée est `str_detect()`. Cette fonction a pour instruction de détecter, dans la colonne "text" dans laquelle se trouvent le tweet. Puis la fonction est ensuite renseignée avec ce qu'elle doit détecter. Ici on utilise la fonction `regex()` dans `str_detect()`, et ce faisant il est possible de préciser que vous êtes intéressé par toutes les variations du hashtag (par exempe #SesameStreet, #Sesamestreet, #sesamestreet, #SESAMESTREET, etc.). Ceci est obtenu en paramétrant "ignore_case = TRUE" dans la fonction `regex()` qui applique une expression régulière à vos données. Les expressions régulières peuvent être vues comme une fonction "rechercher et remplacer" étendue. Si vous souhaitez explorer les expressions régulières de manière plus approfondie, vous pouvez consulter notre leçon [&laquo;&#x202F;Comprendre les expressions régulières&#x202F;&raquo;](/fr/lecons/comprendre-les-expressions-regulieres).

La prochaine étape est une autre fonction `mutate()` où vous créez une nouvelle colonne "date". Cette colonne va contenir seulement la date des tweets et non le timestamp complet de Twitter qui contient également les heures, les minutes et les secondes du tweet. Ceci est obtenu avec la fonction `date()` du paquet lubridate, auquel on donne l'instruction d'extraire la date depuis la colonne "created_at". Enfin, la fonction de comptage du paquet tidyverse est utilisée pour compter les valeurs TRUE/FALSE de la colonne "has_sesame_ht" par date dans le jeu de données. La fonction "pipe" (%>%) est utilisée pour attacher les commandes de code entre elles et fait l'objet de plus d'explications plus tard, au moment de rattacher plusieurs commandes ensemble. Attention, vos données vont être un peu différentes car elles n'ont pas été collectées aux mêmes dates que les nôtres et que la conversation à propos de Sesame Street représentée dans votre jeu de données sera différentes ce qu'elle était avant le 13 décembre lorsque nous avons collecté nos données.

```
    sesamestreet_data%>% 
      mutate(has_sesame_ht = str_detect(text, regex("#sesamestreet", ignore_case = TRUE))) %>% 
      mutate(date = date(created_at)) %>% 
      count(date, has_sesame_ht) %>% 
      ggplot(aes(date, n)) +
      geom_line(aes(linetype=has_sesame_ht)) +
      scale_linetype(labels = c("Sans #sesamestreet", "Avec #sesamestreet")) +
      scale_x_date(date_breaks = "1 day", date_labels = "%b %d") +
      scale_y_continuous(breaks = seq(0, 400, by = 50)) +
      theme(axis.text.x=element_text(angle=40, hjust=1)) +
      labs(y="Nombre de tweets", x="Date", caption = "Nombre total de tweets: 2432") +
      guides(linetype = guide_legend(title = "Présence ou non dans le\ntweet du hashtag \n#sesamestreet"))
```

{% include figure.html filename="scalable-reading-of-structured-data-1.png" alt="Graphique montrant la distribution de tweets collectés du 4 au 13 décembre 2021" caption="Fig. 1 Distribution journalière de tweets de la période allant du 4 au 13 décembre selon qu'ils contiennent ou pas le hashtag #sesamestreet. La collecte a sollicité le mot-clé sesamestreet sans le hashtag et a recolté un nombre total de 2432 tweets." %}

Vous allez maintenant visualiser vos résultats. Dans le code ci-dessus, vous avez ajouter le code pour la visualisation des quatre premières lignes de code utilisées pour transformer les données et nous aider à explorer la chronologie des tweets avec ou sans le hashtag officiel "#sesamestreet".<!--la traduction ici doit être revue; il faut vraiment expliquer l'original qui est mal formulé-->
Pour reprendre là où le dernier bloc de code s'était arrêté, vous poursuivez avec la fonction `ggplot`, un paquet graphique associé à tidyverse. On donne l'instruction à cette fonction de nommer l'axe x avec la date et le total du comptage des occurrences TRUE/FALSE sur l'axe y. La ligne suivante est la création de la visualisation avec la fonction `geom_line()`, où vous spécifiez `linetype=has_sesame_ht`, ce qui crée deux lignes dans la visualisation, une pour TRUE et une pour FALSE.
Les lignes de code suivant l'argument de `geom_line()` ajustent les propriétés esthétiques de la visualisation. Dans ce contexte, l'esthétique décrit la représentation visuelle des données de la visualisation. `scale_linetype()` indique à R quelles lignes doivent être étiquetées en tant que `scale_x_date()` et `scale_y_continuous()` et modifie l'aspect des axes x et y, respectivement. Enfin, les arguments `labs()` et `guides()` sont utilisés pour créer le texte descriptif de la visualisation.
N'oubliez pas de changer les titres dans le code ci-dessous pour correspondre à votre jeu de données (comme nous l'écrivions plus haut, vous ne faisez probablement pas cet exercice le 13 décembre 2021). Vous trouverez les titres dans la fonction `labs()`.
Vous devriez maintenant obtenir un graphique illustrant la dispersion des tweets de votre jeu de données. Nous allons maintenant procéder à l'exploration binaire de certaines caractéristiques de votre jeu de données.

# Etape 2 - Explorer un jeu de données en créant des catégories binaires analytiques

Utiliser une logique binaire pour explorer un jeu de données peut être une première et - en comparaison à d'autres méthodes numériques - relativement simple manière de saisir des relations importantes dans votre jeu de données. Les relations binaires sont faciles à compter en utilisant du code et peuvent révéler des éléments structurants au sein de vos données. Dans notre cas, nous étions intéressés par les relations de pouvoir sur Twitter et dans la sphère publique de manière générale. Nous avons en conséquence étudié les différences entre les comptes dits vérifiés et les comptes non vérifiés, sachant que les comptes vérifiés sont ainsi marqués en raison du statut public des personnes en dehors de la plateforme. Vous pourriez être intéressé(e)s par combien de tweets étaient des retweets ou bien des tweets originaux. Dans les deux cas, vous pouvez utiliser les métadonnées enregistrées pour créer une question pouvant être répondue via une logique binaire: le tweet provient-il d'un compte vérifié, oui ou non ? le tweet est-il un retweet, oui ou non ?. 

Supposons que vous travaillez avec les données de la Galerie nationale. Dans ce cas, vous pourriez souhaiter explorer un éventuel biais de genre dans les collections et savoir si l'institution a davantage fait l'acquisition d'oeuvres dont le créateur est catégorisé masculin dans le catalogue. Dans ce cas vous pourriez classer le jeu de données afin de pouvoir dénombrer le nombre d'artistes masculins. Si vous étiez intéressé(e)s par la répartition de la collection entre les artistes danois versus les artistes internationaux, les données pourraient être remaniées en une structure binaire permettant de demander si les artistes sont enregistrés comme Danois ou non. La relation binaire peut créer un contexte pour la lecture proche de points de données sélectionnés à l'étape 3.

Connaître la distribution des données en deux catégories va aussi vous permettre d'établir la représentativité d'un seul point de donnée vis-à-vis de la distribution de sa catégorie pour le jeu de données entier. Par exemple, si à l'étape 3 vous choisissez de travailler sur les 20 tweets les plus likés, vous pourriez être en mesure de voir que même s'il y avait beaucoup de tweets provenant de comptes vérifiés dans cette sélection, ces comptes n'étaient pas bien représentés dans le jeu de données  global. Les 20 tweets les plus likés que vous avez sélectionné ne sont ainsi pas représentatifs des tweets de la plupart des comptes de votre jeu de données. Ils représentent un petit pourcentage de tweets plus likés que la majorité de votre échantillon.
Si vous choisissiez de travailler sur les 20 oeuvres d'art les plus explosées du jeu de données de la Galerie nationale, une exploration binaire des artistes danois versus les non-danois peut révéler que les oeuvres les plus exposées sont toutes issues d'artistes internationaux, une catégorie par ailleurs peu représentée dans les collections du musée.

## Exemple avec une exploration binaire sur des données Twitter

Dans cet exemple, vous vous intéressez à l'exploration de la distribution du statut (vérifié ou non vérifié) des comptes qui tweetent à propos de Sesame Street. Dans ce premier exemple de manipulation de données, vous suivez chaque étape qui montre la logique du tuyau (*pipe*) (`%>%`) dans R. Une fois que vous serez à l'aise avec cette logique, le reste de la manipulation de données sera plus facile à lire et à comprendre. Le but général de cette section est de découvrir comment les tweets se répartissent entre comptes vérifiés et non vérifiés, puis de visualiser le résultat.

```
    sesamestreet_data %>% 
      count(verified)
```
      
<br/>

    ## # A tibble: 2 x 2
    ##   verified     n
    ## * <lgl>    <int>
    ## 1 FALSE     2368
    ## 2 TRUE        64

En utilisant le tuyau `%>%` vous filtrez progressivement vos données. La donnée circule à travers le tuyau comme de l'eau ! Ici nous versons vos données
dans la fonction `count` et nous demandons de compter la colonne "comptes vérifiés" qui contient deux valeurs, soit VRAI si le compte est vérifié et FAUX lorsqu'il ne l'est pas.
Vous obtenez donc le décompte - mais il est plus intéressant d'obtenir ces données en pourcentages (plutôt qu'en valeurs absolues). Notre prochaine étape est donc d'ajouter un autre tuyau et un morceau de code afin de créer une nouvelle colonne qui contient le nombre total de tweets dans notre jeu de données, ce dont nous aurons besoin pour calculer les pourcentages ensuite.

```
    sesamestreet_data %>% 
    count(verified) %>% 
    mutate(total = nrow(sesamestreet_data))
```
    
<br/>
    
     ## # A tibble: 2 x 3
     ##   verified     n total
     ## * <lgl>    <int> <int>
     ## 1 FALSE     2368  2432
     ## 2 TRUE        64  2432
   
Vous obtenez le nombre total de tweets en utilisant la fonction `nrow()` qui retourne le nombre de lignes depuis un tableau de données. Dans votre jeu de données, une ligne équivaut à un tweet.
En utilisant un autre tuyau, vous créez maintenant une colonne nommée "pourcentages" où vous calculez et stockez le pourcentage de dispersion entre les tweets
issus de comptes vérifiés et non vérifiés :
```
    sesamestreet_data %>% 
    count(verified) %>% 
    mutate(total = nrow(sesamestreet_data)) %>% 
    mutate(pct = (n / total) * 100)
```
<br/>

    ## # A tibble: 2 x 4
    ##   verified     n total   pct
    ## * <lgl>    <int> <int> <dbl>
    ## 1 FALSE     2368  2432 97.4 
    ## 2 TRUE        64  2432  2.63
    
La prochaine étape est de visualiser le résultat. Ici nous utilisons le paquet `ggplot2` pour créer un graphique en barres :
```
    sesamestreet_data %>% 
    count(verified) %>% 
    mutate(total = nrow(sesamestreet_data)) %>% 
    mutate(pct = (n / total) * 100) %>% 
    ggplot(aes(x = verified, y = pct)) +
    geom_col() +
    scale_x_discrete(labels=c("FALSE" = "Not Verified", "TRUE" = "Verified"))+
        labs(x = "Verified status",
        y = "Percentage",
        title = "Figure 2 - Percentage of tweets coming from verified and non-verified\naccounts in the sesamestreet-dataset",
        subtitle = "Period: 4 December 2021 - 13 December 2021", 
        caption = "Total number of tweets: 2435") + 
     theme(axis.text.y = element_text(angle = 14, hjust = 1))
```

   
{% include figure.html filename="scalable-reading-of-structured-data-2.png" alt="Diagramme en batons de données Twitter montrant que 98% des tweets contenant le hashtag #sesamestreet ont été émis de comptes non vérifiés" caption="Fig. 2 Pourcentage des tweets du jeu de données sesamestreet qui ont été émis de comptes vérifiés and non-vérifiés pendant la période allant du 4 au 13 décembre 2021. Le nombre total des tweets était 2432." %}

À la différence des visualisations précédentes qui montraient les tweets de manière chronologique, vous utilisez ici la fonction `geom_col` pour créer des colonnes.
En démarrant avec ggplot, le tuyau (`%>%`) est remplacé par un `+`.

### Interaction avec les comptes vérifiés versus non vérifiés

Dans cette partie de l'exemple vous souhaitez savoir dans quelle mesure les gens intéragissent avec les tweets des comptes vérifiés versus avec les tweets des comptes non vérifiés. Nous avons choisi de compter les mentions J'aime (*like*) comme une mesure du niveau d'interaction par exemple. Comparer les niveaux d'interaction avec ces deux types de  comptes va vous aider à estimer si les comptes vérifiés moins représentés ont plus d'influence et de pouvoir malgré leur faible représentation, parce que les gens interagissent beaucoup plus avec leurs tweets qu'avec ceux des comptes non vérifiés.

```
    sesamestreet_data %>% 
      group_by(verified) %>% 
      summarise(gns = mean(favorite_count))
```   


    ## # A tibble: 2 x 2
    ##   verified     gns
    ## * <lgl>      <dbl>
    ## 1 FALSE      0.892
    ## 2 TRUE     114.

Dans le code ci-dessus, vous groupez le jeu de données en vous basant sur le statut "vérifié" de chaque tweet. Une fois que vous avez utilisé la fonction `group_by`, toutes les opérations à suivre sont effectuées en prenant en compte les groupes. Autrement dit, l'ensemble des tweets provenant des comptes non vérifiés d'une part, et des comptes vérifiés d'autre part, seront désormais considérés comme des groupes. La prochaine étape est d'utiliser la fonction `summarise` pour calculer la moyenne des “favorite_count” (nombre de likes), c'est-à-dire la moyenne (gns) du nombre de like par tweets provenant des comptes non vérifiés versus des comptes vérifiés.

Dans cette prochaine étape, vous ajoutez le résultat obtenu ci-dessus à un tableau de données, avec une nouvelle colonne "interaction" où vous spécifiez qu'il s'agit de "favorite_count".
```
    interactions <- sesamestreet_data %>% 
      group_by(verified) %>% 
      summarise(gns = mean(favorite_count)) %>% 
      mutate(interaction = "favorite_count")
```
      
De cette manière vous obtenez un tableau de données avec les moyennes des différentes interactions, ce qui rend possible maintenant l'utilisation du paquet ggplot pour visualiser les données, comme ci-dessous :

```
    interactions  %>% 
      ggplot(aes(x = verified, y = gns)) +
      geom_col() +
      facet_wrap(~interaction, nrow = 1) +
      labs(caption = "Total number of tweets: 2411",
           x = "Verified status",
           y = "Average of engagements counts") +
      scale_x_discrete(labels=c("FALSE" = "Not Verified", "TRUE" = "Verified"))
```   
{% include figure.html filename="scalable-reading-of-structured-data-3.png" alt="Diagramme en batons montrant la moyenne des likes et retweets pour les tweets émis de comptes vérifiés et non vérifiés. La moyenne est 1 pour les comptes non vérifiés et approximativement 108 pour les comptes vérifiés." caption="Fig. 3 Means of different interaction count dispersed on verified status in the period from 4 December 2021 until 13 December 2021. The total number of tweets was 2432." %}

La visualisation ressemble fortement au graphique en barres précédent, mais la différence ici est l'utilisation de `facet_wrap` qui génère deux graphiques en barres pour chaque type d'interaction. Elle montre à quel point les tweets en provenance de comptes vérifiés attirent plus d'attention comparés aux tweets émis de comptes non-vérifiés. 

# Etape 3 - Sélection reproductible et systématique de points de données pour la lecture proche

L'un des avantages à combiner la lecture proche (*close reading*) avec la lecture distante (*distant reading*) est la possibilité d'effectuer des sélections systématiques et reproductibles de points de données pour la lecture proche. Une fois l'exploration de votre jeu de données effectuée au moyen des deux types de lectures distantes (étape 1 et étape 2), vous pouvez utiliser ces informations pour sélectionner de manière systématique des points de données pour une lecture plus proche. Cette démarche vous permet d'explorer plus en détail les tendances de vos données, d'analyser un phénomène précis ou d'autres points d'intérêts que vous souhaitez examiner plus en profondeur.

Le nombre de points de données choisis pour la lecture proche va dépendre du phénomène sur lequel vous enquêtez, de combien de temps vous disposez et de la complexité générale des données. Par exemple, analyser une par une des productions artistiques peut prendre beaucoup plus de temps que la lecture individuelle de tweets, mais bien entendu cela dépend de votre objectif. Il est donc important d'être systématique dans la sélection de points de données afin de rester conforme à vos questions de recherche. Dans notre cas, nous souhaitions en savoir plus sur comment les tweets les plus likés représentent Sesame Street, comment ils parlent de l'émission et de son histoire, s'ils contiennent des liens vers d'autres médias et comment l'émission était visuellement représentée (par des images, des liens vers des vidéos, des memes, etc.) ?

Connaissant la relation intéressante entre la faible représentation, mais les hauts niveaux d'interactions des tweets provenant de comptes vérifiés, nous voulions effectuer une lecture proche des 20 tweets les plus likés, non seulement pour tout le corpus, mais aussi les 20 tweets les plus likés émis par des comptes non vérifiés. Ceci afin de nous permettre de voir si l'on pouvait identifier des différences dans la manière dont ces tweets parlent de l'émission et de son histoire. Nous avons choisi le top 20 parce que cela correspondait à une charge de travail faisable compte tenu du temps dont nous disposions.

Si vous aviez travaillé avec les données de la Galerie nationale, peut-être qu'une sélection du top 5 ou du top 10 des oeuvres les plus exposées ou les plus empruntées des artistes danois versus internationaux auraient suffi pour étudier plus en détail leurs différences et points communs via une lecture proche des artistes, du type d'oeuvre, de la taille, du contenu, de la période historique, etc.

## Exemple de sélection reproductible et systématique pour la lecture proche à partir des données Twitter 

Dans cet exemple vous vous intéressez à la sélection du top 20 des tweets les plus likés pour l'ensemble du corpus. Sachant que beaucoup de ces tweets proviennent probablement de comptes vérifiés, vous souhaitez également sélectionner le top 20 des tweets issus de comptes non vérifiés afin de pouvoir comparer ces deux catégories.
Pour examiner les tweets originaux seulement, vous commencez par exclure les tweets qui sont des retweets.
Dans le coin supérieur droit de l'interface du Studio R, vous trouverez l'environnement global de R (*Global environment*) contenant le tableau de données *sesamestreet_data*. En cliquant sur le tableau de données, vous pourrez voir les lignes et les colonnes contenant les données Twitter. En regardant la colonne "is_retweet", vous verrez que cette colonne indique si le tweet est un retweet ou non par les valeurs TRUE ou FALSE.

En retournant dans votre fichier R Markdown, le document dans lequel vous écrivez votre code, vous êtes maintenant en mesure d'utiliser la fonction de `filter` afin de retenir uniquement les lignes pour lesquelles on sait que le tweet n'est pas un retweet. R Markdown est un format de fichier qui supporte à la fois le code R et le texte. Vous pouvez ensuite classer les tweets restant en fonction du nombre de likes, que l'on trouve dans la colonne "favorite_count".

La fonction `filter` et la fonction `arrange` proviennent toutes les deux du paquet dplyr, qui fait partie de tidyverse.
```
    sesamestreet_data %>% 
      filter(is_retweet == FALSE) %>% 
      arrange(desc(favorite_count)) (Output removed because of privacy reasons) 
```    
Comme vous pouvez le voir dans l'environnement global, votre jeu de données *sesamestreet_data* a un total de 2435 observations (ce nombre va varier en fonction de la date et de la durée de collecte des données). Après avoir exécuté ce morceau de code, vous pouvez maintenant lire dans votre tableau de données combien de tweets uniques votre jeu de données contient. Dans notre exemple, c'était 852, mais cela peut varier en fonction de vos données.

En regardant la colonne "favorite_count", vous pouvez observer combien de mentions J'aime, ou likes, totalise votre top 20. Dans notre exemple, le top 20 a pour valeur minimale de "likes" 50. Ces nombres sont des variables qui changeront lorsque vous reproduirez l'expérience par vous-mêmes. Assurez-vous de bien vérifier ces nombres.

### Créer un nouveau jeu de données du top 20 des tweets les plus likés des comptes vérifiés et non vérifiés

Comme vous le savez maintenant, la valeur minimale de "favorite_count" est de 50, vous pouvez ajouter une deuxième fonction `filter` à notre morceau de code précédent afin de retenir seulement les lignes avec une valeur "favorite_count" supérieure à 50. 
Maintenant que vous avez le top 20 des tweets les plus likés, vous pouvez créer un nouveau jeu de données appelé *sesamestreet_data_favorite_count_over_50*.
```
    sesamestreet_data %>% 
      filter(is_retweet == FALSE) %>%
      filter(favorite_count > 50) %>% 
      arrange(desc(favorite_count)) -> sesamestreet_data_favorite_count_over_50
``` 
### Inspecter notre nouveau tableau de données

Pour créer une vue d'ensemble rapide de notre nouveau jeu de données, utilisons la fonction `select` du paquet dplyr pour isoler les variables à inspecter. Dans ce cas, nous souhaitons isoler les colonnes favorite_count, screen_name, verified et text. 
```
    sesamestreet_data_favorite_count_over_50 %>% 
      select(favorite_count, screen_name, verified, text) %>% 
      arrange(desc(favorite_count)) (Output removed because of privacy reasons) 
```   
Vous pouvez ensuite les classer par la valeur "favorite_count" en utilisant la fonction `arrange`.
Ce morceau de code retourne un tableau de données contenant les valeurs déjà évoquées. Il est plus facile à inspecter que si l'on regardait l'ensemble du jeu de données sesamestreet_data_favorite_count_over_50 dans notre environnement global.

### Exporter le nouveau jeu de données dans un fichier JSON

Pour exporter votre nouveau jeu de données hors de l'environnement R et le sauvegarder sous forme d'un fichier JSON, vous pouvez utiliser la fonction `toJSON` du paquet jsonlite. Nous choisissons le format de fichier JSON car nos données twitter sont relativement complexes avec des exemples de listes entre les lignes. Par exemple plusieurs hashtags sont stockés sous forme de listes au sein d'une ligne. Cette situation est difficile à gérer dans les formats de données rectangulaires comme le CSV, raison pour laquelle nous avons opté pour le format JSON.

Afin de vous assurer que vos données sont stockées de la manière la plus gérable et structurée possible, l'ensemble de vos fichiers de données sont doublés avec les mêmes informations :
1. Le nombre de tweets / observations contenus dans le jeu de données
2. Quelle variable détermine le tri des données
3. Si les tweets proviennent de tous les types de comptes ou juste les comptes vérifiés
4. L'année de production des données
```
       Top_20_liked_tweets <- jsonlite::toJSON(sesamestreet_data_favorite_count_over_50)
```
Après avoir converti vos données au format JSON, vous êtes en mesure d'utiliser la fonction `write` de base dans R pour exporter les données et les sauvegarder sur votre machine.
```
       write(Top_20_liked_tweets, "Top_20_liked_tweets.json")
``` 
### Créer un nouveau jeu de données du top 20 des tweets les plus likés (comptes non vérifiés seulement)

Vous souhaitez maintenant voir le top 20 des tweets les plus likés par les comptes non vérifiés.

    sesamestreet_data %>% 
      filter(is_retweet == FALSE) %>%
      filter(verified == FALSE) %>% 
      arrange(desc(favorite_count)) (Output removed because of privacy reasons)
      
Pour cela, vous suivez le même mode opératoire que précedemment, mais dans notre premier bloc de code nous incluons un filtre supplémentaire `filter` depuis le paquet dyplr, qui ne retient que les lignes avec les valeurs "false" (faux) dans la colonne "vérified" (vérifiés). Ceci exclut tous les tweets produits par des comptes vérifiés de vos données.
Ici vous pouvez observer combien, sur le total de 2435 tweets n'étant pas des retweets, ont été créés par des comptes non vérifiés. Dans notre exemple, ce nombre était de 809. Ce nombre va différer dans votre cas.

En observant à nouveau la colonne "favorite_count", il vous faut maintenant chercher le tweet numéro 20 des tweets les plus likés. Observez combien de likes ce tweet a, puis paramétrez "favorite_count" sur cette valeur. Dans notre exemple, le top 20 des tweets issus de comptes non vérifiés a un compte (de like) au dessus de 15. Cette fois, deux tweets sont à la 20ème et 21ème place. Dans ce cas, vous allez jusqu'aux 21 tweets les plus likés pour cette analyse.
```
    sesamestreet_data %>% 
      filter(is_retweet == FALSE) %>%
      filter(verified == FALSE) %>%
      filter(favorite_count > 15) %>% 
      arrange(desc(favorite_count)) -> sesamestreet_data_favorite_count_over_15_non_verified
```     
Vous pouvez à présent filtrer les tweets qui ont été likés plus que 15 fois, puis les afficher du plus au moins liké, et créer un nouveau jeu de données dans notre Environnement Global, nommé sesamestreet_data_favorite_count_over_15_non_verified.

### Inspecter notre nouveau tableau de données

A nouveau vous avez la possibilité de créer une rapide vue d'ensemble de votre nouveau jeu de données en utilisant les fonctions `select` et `arrange`, puis d'inspecter les valeurs choisies dans le tableau de données retourné.
```
    sesamestreet_data_favorite_count_over_15_non_verified %>% 
      select(favorite_count, screen_name, verified, text) %>% 
      arrange(desc(favorite_count)) <span style="color: green">(Output removed because of privacy reasons)</span>
```     
### Exporter le nouveau jeu de données en fichier JSON

A nouveau nous utilisons la fonction `toJSON` pour exporter nos données dans un fichier local JSON.
```
     Top_21_liked_tweets_non_verified <- jsonlite::toJSON(sesamestreet_data_favorite_count_over_15_non_verified)
     write(Top_21_liked_tweets_non_verified, "Top_21_liked_tweets_non_verified.json")
```
Vous devriez maintenant avoir deux fichiers JSON stockés dans votre répertoire désigné, prêts à être chargés dans une autre fenêtre R Markdown pour une lecture proche. Vous pouvez aussi inspecter les colonnes de texte du jeu de données dans l'environnement global R.
Vous êtes maintenant en mesure de copier les URLs du tableau de données pour inspecter les tweets individuellement sur Twitter. Rappelez-vous de bien relire les conditions générales de Twitter et d'agir en les respectant. Ces conditions générales stipulent par exemple que vous n'êtes pas autorisé à partager votre jeu de données avec d'autres, à l'exception d'une liste d'ID de tweets. Il est également précisé que le matching de comptes Twitter et d'individus s'effectuant hors de Twitter doivent respecter des règles très strictes et comporte de nombreuses limites. Enfin, vous êtes également restreints si vous souhaitez publier vos données ou citer des tweets, etc.

# Conclusion: poursuivre avec la lecture proche

Quand vous avez sélectionné les points de données individuels à examiner de manière plus attentive (étape 3), les étapes initiales d'exploration via la lecture distante (étapes 1 et 2) peuvent être utilisées en combinaison pour constituer un contexte hautement qualifié pour nourrir l'analyse plus détaillée. En retournant à l'exploration chronologique (étape 1), vous saurez où se situent les points de données vous avez sélectionnés pour analyser individuellement se situent dans le jeu de données global et serez en mesure de considérer l'impact de cette information sur votre analyse. Par exemple, ces points de données sont-ils situés parmi les premiers ou les derniers tweets de la distribution ? Font-ils partie d'un pic ? Comment interpréter cette information ? 
En considérant les structures binaires (étape 2), la lecture distante peut aider à déterminer si un point de donnée est une anomalie ou s'il est représentatif d'une tendance plus générale dans les données, et de déterminer la taille de la portion du jeu de données qu'il représente en relation avec un paramètre donné. Dans l'exemple utilisant les données Twitter, la lecture proche de points de données sélectionnés peut être contextualisée par la lecture distante de la manière suivante : l'exploration chronologique aide à déterminer comment les 20 tweets sélectionnés pour la lecture proche sont situés en relation avec un évènement considéré comme pertinent. Peut-être qu'un tweet a été posté plus tôt que les autres, indiquant une première réaction à chaud sur un sujet. Peut-être qu'un tweet considéré comme en retard par rapport aux autres peut indiquer une perspective plus réfléchie sur un sujet.
Pour déterminer cela, il est nécessaire d'effectuer une lecture attentive et d'analyser les tweets sélectionnés en recourant aux méthodes traditionnelles de sciences humaines et sociales, mais la lecture distante peut aider à qualifier et à contextualiser votre analyse. Le même raisonnement s'applique pour les structures binaires et les critères utilisés pour sélectionner le top 20 des tweets les plus likés. Savoir si un tweet provient ou non d'un compte vérifié, et s'il a été l'un des plus likés, permet de comparer cela avec les tendances générales sur ces paramètres. Cela aide à qualifier et à argumenter la conduite de l'analyse détaillée d'un seul point de données, car vous savez ce qu'il représente en relation avec le sujet général que vous étudiez.

# Conseils pour le travail avec les données Twitter 

Comme évoqué au début de cette leçon, il y a différentes manières d'obtenir vos données. Cette section peut vous aider à utiliser le code de cette leçon sur des données n'ayant pas été collectés avec le paquet rtweet.
Si vous avez collecté vos données en suivant la leçon [Débuter avec les données Twitter](/en/lessons/beginners-guide-to-twitter-data), vous découvrirez que la date des tweets est affichée d'une manière qui n'est pas compatible avec le code de cette leçon. Pour rendre le code compatible avec les données de la leçon en question, la colonne "date" doit être manipulée avec des expressions régulières. Ces dernières sont assez complexes et utilisées pour dire à l'ordinateur quelle partie du texte de la colonne doit être comprise comme un jour, un mois, une année et une heure.
```
    df %>% 
      mutate(date = str_replace(created_at, "^[A-Z][a-z]{2} ([A-Z][a-z]{2}) (\\d{2}) (\\d{2}:\\d{2}:\\d{2}) \\+0000 (\\d{4})",
                             "\\4-\\1-\\2 \\3")) %>% 
      mutate(date = ymd_hms(date)) %>% 
     select(date, created_at, everything())
    df$Time <- format(as.POSIXct(df$date,format="%Y-%m-%d %H:%M:%S"),"%H:%M:%S")
    df$date <- format(as.POSIXct(df$date,format="%Y.%m-%d %H:%M:%S"),"%Y-%m-%d")
```
D'autres colonnes qui n'ont pas les mêmes noms dans nos données que dans les données collectées via la leçon "Dèbuter avec les données Twitter" sont les colonnes "verified" et "text" qui sont nommées "user.verified" et "full_text". Ici vous avez deux options : soit changer le code, afin qu'il soit écrit partout "verified" ou "text" ou "user.verified" et "full_text". Une autre approche consiste à changer les noms des colonnes dans le tableau de données, ce qui peut être fait via le code suivant : 
```
    df %>% 
     rename(verified = user.verified) %>% 
     rename(text = full_text) -> df
```

# Références

[^1]: Hadley Wickham, Mara Averick, Jennifer Bryan, Winston Chang, Lucy D’Agostino McGowan, Romain François, Garrett Grolemund, Alex Hayes, Lionel Henry, Jim Hester, Max Kuhn, Thomas Lin Pedersen, Evan Miller, Stephan Milton Bache, Kirill Müller, Jeroen Ooms, David Robinson, Dana Paige Seidel, Vitalie Spinu, Kohske Takahashi, Davis Vaughan, Claus Wilke, Kara Woo, and Hiroaki Yutani (2019). “Welcome to the tidyverse.” Journal of Open Source Software, 4(43), 1686, 1-6. doi: [10.21105/joss.01686](https://joss.theoj.org/papers/10.21105/joss.01686)  

[^2]: Garrett Grolemund and Hadley Wickham (2011). “Dates and Times Made Easy with lubricate", Journal of Statistical Software, 40(3), 1-25. [www.jstatsoft.org/v40/i03/](www.jstatsoft.org/v40/i03/)  

[^3]: Ooms, Jeroen (2014). “The jsonlite Package: A Practical and Consistent Mapping Between JSON Data and R Objects.”, [arxiv.org/abs/1403.2805](https://arxiv.org/abs/1403.2805)

[^4]: Kearney, (2019). "rtweet: Collecting and analyzing Twitter data". Journal of Open Source Software, 4(42), 1829, [https://doi.org/10.21105/joss.01829](https://doi.org/10.21105/joss.01829)
