---
title: "Des sources aux données, concevoir sa recherche en sciences humaines à l'aide de nodegoat"
collection: lessons
layout: lesson
slug: concevoir-recherche-donnees-nodegoat
date: YYYY-MM-DD
authors:
- Agustín Cosovschi
reviewers:
- Octave Julien
- Solenn Huitric
editors:
- Sofia Papastamkou
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/459
difficulty: 1
activity: transforming
topics: [data-manipulation]
abstract: Ce tutoriel permet de prendre en main le logiciel nodegoat pour construire une base de données relationnelle dans le cadre d'une recherche en sciences humaines.
avatar_alt:
doi:
--- 

{% include toc.html %}

## Introduction : le défi conceptuel de penser en termes de données

 
Au moment de faire ses premiers pas dans le monde des humanités numériques, le chercheur ou la chercheuse en sciences humaines se confronte à plusieurs défis. Tout d’abord, les défis techniques : l’emploi des outils numériques n’est pas toujours évident et la maîtrise d’une méthode, d’un logiciel ou encore plus d’un langage de programmation exige souvent une pratique longue et parfois ardue. L’initiation aux méthodes numériques pose néanmoins aussi un autre défi, tout à fait différent mais également difficile : le besoin de réfléchir à sa recherche en termes de *données*. Mais, de quoi parle-t-on quand on parle de *données* ?
 
De manière générale, nous pouvons définir les [données](https://fr.wikipedia.org/wiki/Donn%C3%A9e_(informatique)) (en anglais, *data*) comme des informations structurées en unités discrètes et se prêtant au traitement automatique. Ces informations doivent être constituées de telle manière que, si quelqu'un d'autre les utilise et réalise sur elles les mêmes opérations que nous, il ou elle doit arriver au même résultat. 

Produire des données sur la base d’une recherche implique un certain travail de *traduction* : il faut traduire nos informations de leur forme de base à une forme structurée. La donnée, contrairement à ce que l’on nous fait croire souvent, **n’est pas du tout donnée** : elle n’est pas disponible dans la réalité, elle n'attend pas à ce qu’elle soit recueillie, elle est au contraire le produit d’un travail d’interprétation et de transformation. Afin de produire ses données, le chercheur ou la chercheuse doit lire ses sources selon une problématique définie, en extraire des informations et les consigner de manière structurée. 

Pour ceux et celles qui font de la recherche en sciences humaines, c’est souvent ici que commencent les problèmes, car la notion même de *donnée* est parfois problématique. En histoire, en anthropologie ou en littérature, nous pouvons réfléchir aux phénomènes que nous étudions en termes flexibles, ouverts et souvent incertains. Nous avons l'habitude de réfléchir à la subjectivité du chercheur, à donner une place centrale à la contingence et enfin, et à voir les phénomènes politiques, sociaux et culturels que nous analysons comme des objets complexes que l'on ne peut pas tout simplement réduire à « un ensemble de données ». Comme le dit Miriam Posner [dans un billet de blog](https://miriamposner.com/blog/humanities-data-a-necessary-contradiction/) à ce sujet :
 
>Nous les chercheur(e)s en sciences humaines avons un rapport à la preuve tout à fait différent de celui d’autres scientifiques, même de celui des chercheur(e)s en sciences sociales. Nous avons des manières différentes de connaître les choses que les chercheur(e)s travaillant dans d’autres champs d'études. Nous pouvons savoir que quelque chose est vrai sans forcément pouvoir renvoyer à un jeu de données tel que l'on le conçoit traditionnellement.[^1] 
 
Ainsi, pour les chercheur(e)s en sciences humaines, l’idée de lire leurs sources, leurs documents ou leurs notes ethnographiques pour en tirer des informations que l’on insérera dans des catégories fixes, discrètes et structurées dans un tableur est souvent contre-intuitive. Cela nous semble souvent même simpliste et superficiel : comment pourrait-on traduire en termes de *données* une tradition politique, la dimension affective d'une pratique culturelle locale, les enjeux conceptuels de la philosophie moderne ou la psychologie d’un personnage littéraire ?

Or, réfléchir à notre recherche en termes de données n'amène pas forcément à une simplification ou un applatissment de notre objet d'étude. Les chercheurs en sciences humaines pouvons adopter une démarche méthodologique impliquant un travail avec des données structurées tout en nous efforçant de donner une place à la complexité et à la subjectivité. Comme le rappelle Johanna Drucker dans un article qui porte sur les défis de donner une place à la subjectivité et l'incertitude dans la visualisation de données, les chercheurs en sciences humaines ne devons pas nous laisser emporter par la temptation réaliste de croire que les donneés sont indépendentes de l'opération de recueil dont elles resultent : au contraire, nous devons travailler tout en sachant que *all data is capta*, autrement dit que les toutes les données sont captées, saisies et découpées de la réalité par un chercheur ou une chercheuse qui fait un travail d'interprétation sur son objet d'étude.[^2]. 

Pour sa part, Manfred Thaller insiste non seulement sur le besoin de ne pas confrondre les données avec la réalité elle-même, mais aussi, sur l'insuffisance de la donnée en elle-même, si elle n'est pas l'objet d'un travail d'interprétation de la part d'un agent cognitif. Il propose ainsi une distinction entre *données*, *information* et *savoir* : si les données sont des marques sur un système de représentation, l'information est en revanche la valeur que ces données aquièrent quand elles sont interprétées dans un contexte, et le savoir arrive pour sa part quand ces informations deviennent la base d'une prise de décision ou d'une action.[^3] Thaller représente les données, l'information et le savoir selon un schéma hiérarchique :

 
 {% include figure.html filename="triangle.png" caption="Figure 1: Schéma proposé par Manfred Thaller pour représenter les données, l'information et le savoir." %} 
 
 
Si nous reconnaissons la compléxité du travail avec les données, mais que nous sommes aussi bien conscients de la nature construite de la donnée, concevoir notre recherche en termes de données offre de grands avantages. 

Dans un premier temps, aborder une recherche en termes de données nous permet d’enregistrer nos informations de façon telle qu’elles puissent être traitées de manière automatique par des méthodes numériques et se prêter à des analyses quantitatives. Cela s’avère surtout utile quand on se confronte à une investigation qui doit manipuler une grande masse d’informations ou lorsque des séries de données peuvent être directement prélevées par les sources (inventaires, données démographiques etc.). Nous sommes ainsi en mesure d'articuler des analyses qualitatives et quantitatives dans notre travail. Dans un deuxième temps, consigner ces informations dans une base de données nous permet de partager facilement ces informations avec le reste de la communauté scientifique. Enfin, concevoir la recherche en termes de données offre des avantages non seulement techniques et pratiques, mais aussi conceptuels, car le processus même de traduire nos informations en données exige que nous définissions de manière claire et nette les éléments de notre investigation, nos hypothèses et nos questions de recherche. Autrement dit : quand on réfléchit en termes de données et on se demande quelle est la structure selon laquelle on doit consigner ses informations, on est aussi obligé de se demander clairement quel sont les objets de notre recherche, quelles relations les relient mutuellement, comment ils interagissent et quels sont les conséquences de ces interactions.
 

Dans cette leçon, nous discuterons des difficultés auxquelles on doit se confronter au moment de concevoir la recherche en termes de données. Nous donnerons aussi un ensemble d’éléments afin de faciliter ce processus aux chercheur(e)s moins expérimenté(e)s. Dans cette leçon, nous allons donc :


1. Présenter de manière générale un ensemble de notions qui permettent d’aborder le travail avec des données, en particulier ceux de « base de données», « base de données relationnelle », « cardinalité » et « modèle de données ».

2. Faire les premiers pas dans la construction d’une base de données pour une recherche en sciences humaines. Pour cela, nous nous servirons de l’environnement de recherche *nodegoat*[^4] qui permet aux chercheurs et aux chercheuses de concevoir leur modèle de données de manière flexible, de gérer et conserver leurs données en ligne, d’introduire des informations historiques avec un certain degré d’incertitude, d’exporter et importer ces données de manière simple et enfin, de produire des formes de visualisation géographique et de réseaux, entre autres.
 
Ainsi, nous espérons pouvoir donner aux chercheur(e)s débutant dans le domaine du numérique un ensemble d’outils conceptuels et techniques qui leur permettront de comprendre les avantages d’une forme de travail dont la logique n’est pas toujours évidente pour ceux et celles formé(e)s en sciences humaines.


## La logique de notre recherche : entre le modèle de données et la base de données
 
Comme mentionné auparavant, au fur et à mesure que nous dépouillons nos sources, notre recherche produit une quantité conséquente d’informations; dans ce cas, il est souvent préférable de consigner ces informations de manière organisée et structurée. Par exemple, disons que nous menons une recherche historique sur un ensemble de livres. Nous parlerons ici d’une recherche hypothétique : un projet portant sur les ouvrages produits par les écrivains dissidents des régimes communistes d’Europe de l’Est. 

Si nous voulions consigner des informations sur ces livres, nous le ferions de manière intuitive en utilisant les fonctionnalités offertes par un [tableur](https://fr.wikipedia.org/wiki/Tableur), comme cela :

<div class="table-wrapper" markdown="block"> 

| Titre | Ville de parution | Auteur |
| :------ | :-------------------- | :---------|
| L’Archipel du Gulag | Paris | Alexandre  Soljenitsyne |
| Vie et destin | Génève | Vassili Grossman |
| The New Class | New York | Milovan Djilas |
| The Captive Mind | Paris | Czesław Miłosz |
| La machine et les rouages | Paris | Michel Heller |
| The Intellectuals on the Road to Class Power| Brighton | Geoge Konrad, Ivan Szelenyi |

</div>


Ce tableau avec trois colonnes nous permet de consigner nos informations de manière très simple. D'une certaine manière, nous commençons à construire déjà, de manière plutôt élémentaire, ce que l’on pourrait appeler un [« jeu de données »](https://fr.wikipedia.org/wiki/Jeu_de_donn%C3%A9es) (en anglais, *dataset*). Chaque ligne dans le tableau représente un cas (un « enregistrement »), alors que chaque colonne représente une caractéristique (un « attribut ») de ces cas : le titre, la ville d’édition et l’auteur de chaque ouvrage.
 
Pour l’instant, cela suffit comme instrument et ne pose pas de problème, parce que nous y conservons une masse d’informations peu conséquente. Mais disons que, au fur et à mesure que nous approfondissons notre enquête, nous commençons à nous poser de nouvelles questions sur les ouvrages et sur les auteurs et nous multiplions les informations enregistrées. Nous pourrions, par exemple, élargir le tableau comme suit :

<div class="table-wrapper" markdown="block">
 
| Titre | Ville de parution | Langue de la première édition | Date de parution | Maison d’édition | Date de fondation de la maison d’édition | Auteur | Nationalité de l’auteur | Ville de naissance de l’auteur | Date de naissance de l’auteur |
| :------ | :------------- | :--------- | :------ | :-------------------- |:--------- |:---------| :---------| :---------| :---------|
| L’Archipel du Gulag | Paris | Français | 1973 | Le Seuil  | 1930 | Alexandre  Soljenitsyne | Russe | Kislovodsk | 1918 |
| Vie et destin | Genève | Français | 1980 | L’age de l’homme | 1955 |Vassili Grossman | Russe | Berdytchiv | 1905 |
| The New Class | New York | Anglais | 1957 | Praeger |  1950 | Milovan Djilas | Monténégrine | Podbišće |  1911 |
| The Captive Mind | Paris | Anglais | 1953 | Instytut Literacki | 1946 | Czesław Miłosz | Polonaise | Szetejnie | 1911 |
| La machine et les rouages | Paris | Français | 1985 | Calmann-Lévy | 1920 | Michel Heller | Russe | Moguilev | 1922 |
| The Intellectuals on the Road to Class Power| Brighton | Anglais | 1979 | Harvester Press | ? |George Konrad, Ivan Szelenyi | Hongrois, Hongrois | Berettyóújfalu, Budapest | 1933, 1938 |

</div> 

Ce nouveau tableau nous permet d’approfondir dans l’analyse en ajoutant de nouvelles informations. Pourquoi voudrait-on faire cela ? Nous pourrions nous intérroger sur les relations entre les caractéristiques des livres, celles des maisons d'édition et celles des auteurs. Nous pourrions, par exemple, nous demander si les auteurs russes publient plus souvent en français ou nous demander éventuellement si certaines maisons d'édition priorisent des auteurs d'un certain age ou d'une certaine nationalité.

Mais ce tableau devient maintenant un peu moins pratique, car au fur et à mesure que l’on commence à multiplier les cas analysés et les questions posées, l’information se multiplie. Aussi, dans certains cas comme celui de l’ouvrage *The Intellectuals on the Road to Class Power*, nous avons même plus d’un auteur, ce qui multiplie encore plus la complexité de nos données. Enfin, dans certains cas, comme celui de la maison d’édition Harvester Press, nous ne sommes même pas certains de la date de fondation (car les informations sur cette petite maison d’édition anglaise sont plutôt limitées), un exemple classique de l’incertitude qui caractérise parfois la recherche en sciences humaines. Bref, si nos questions et nos cas se multiplient, aussi se multiplient les colonnes dans notre tableau et il devient de plus en plus difficile de lire, croiser et interpréter toutes ces informations. 

Quand cela arrive, au lieu de rassembler toutes nos informations dans un même tableau, il est souvent plus utile de commencer à réfléchir aux *relations* qui connectent les différents objets de notre recherche, de faire un tableau pour chacun d’entre eux - une [table de données](https://fr.wikipedia.org/wiki/Table_(base_de_donn%C3%A9es)) - et, enfin, de les relier dans une [base de données](https://fr.wikipedia.org/wiki/Base_de_donn%C3%A9es).
 
Qu’est-ce qu’une *base de données* ? De manière générale, nous pourrions dire qu’il s’agit d’un conteneur qui organise des informations selon une certaine structure. Plus spécifiquement, comme le dit Georges Gardarin, une base de données est « un ensemble de données modélisant les objets d’une partie du monde réel et servant de support à une application informatique ».[^5] Les données dans une base de données doivent pouvoir être interrogeables par le contenu, autrement dit, nous devons pouvoir retrouver toutes les données qui satisfont à un certain critère (dans notre exemple : tous les auteurs de nationalité russe ou tous les ouvrages parus en français). Entre autres, c’est cette *interrogeabilité* qui fait de la base de données un outil puissant d’exploration et d’analyse de nos informations.


Dans cet article, nous nous concentrons sur un type particulier et assez fréquent de base de données : la [base de données relationnelle](https://fr.wikipedia.org/wiki/Mod%C3%A8le_relationnel#La_mod%C3%A9lisation_relationnelle_et_sa_transcription_en_base_de_donn%C3%A9es). Il s’agit d’une structure que l’on peut envisager comme un ensemble de tables reliées pour que l’on puisse circuler entre elles. La base de données contient notamment deux types d’éléments : des objets et des relations entre ces objets. Chacun de ces objets est une réalité complexe qui comporte de nombreuses caractéristiques (« attributs », les colonnes) qui s’expriment dans des cas particuliers (les « enregistrements », les lignes). Mais pour pouvoir construire notre base de données, nous devons définir les objets, les attributs qu'ils contiennent et la façon dont ils se connectent les uns aux autres. Cela nous oblige à passer tout d’abord par ce que l’on appelle un [*modèle de données*](https://fr.wikipedia.org/wiki/Mod%C3%A8le_relationnel#Principe_du_mod%C3%A8le_relationnel).
 
Dans notre exemple, nous avons identifié trois objets qui nous intéressent : les ouvrages, les maisons d’éditions et les auteurs. La question que l’on doit se poser est : comment sont-ils connectés entre eux ? La réponse dépend surtout des questions que nous voulons poser et de notre manière de conceptualiser le phénomène, autrement dit de notre problématique de recherche. Dans le cas proposé ici, si le centre de notre attention est sur le *livre en tant qu’objet de circulation*, nous pouvons par exemple imaginer un graphique élémentaire comme celui-ci connectant ouvrage, auteur et maison d’édition :
 
 
{% include figure.html filename="nodegoat-01.png" caption="Figure 2: Schéma logique représentant les relations entre livres, maisons d'édition et auteurs." %}
 

Ce schéma correspond, plus ou moins, à ce que l’on appelle généralement un *modèle conceptuel de données* (Gardarin 2003, 17). Ici, chaque ouvrage est ainsi lié à un certain auteur qui l'a écrit et à une certaine maison d’édition qui l'a publié. Mais nous devons ensuite nous demander, comme on l’a évoqué, ce que chacun de ces objets contient comme information, de quels éléments est-il composé et comment exactement ces objets sont-ils reliés entre eux. Tout cela dépend de leurs attributs, qui sont définis selon les questions que nous nous posons. En suivant le tableau original de notre recherche hypothétique, nous pourrons définir nos objets comme contenant les attributs suivants et comme étant connectés ainsi :
 
 
{% include figure.html filename="nodegoat-02.png" caption="Figure 3: Modèle de données avec objets, attributs et relations." %} 


Ceci correspond maintenant à ce que l’on appelle généralement un *modèle logique de données*, qui nous permet de définir plus clairement quels sont nos objets et comment ils sont connectés les uns avec les autres. Sur la base de ce schéma, nous pouvons maintenant créer des tables pour consigner les informations de chaque objet séparément :


**Table 1: ouvrage**  

| Titre | Langue de la premiére édition | Date de parution | Maison d’édition |Auteur | 
| :------ | :--------- | :------ | :-------------------- | :---------|
| L’Archipel du Gulag | Français | 1973 | Le Seuil  | Alexandre  Soljenitsyne | 
| Vie et destin | Français | 1980 | L’age de l’homme | Vassili Grossman | 
| The New Class | Anglais | 1957 | Praeger |  Milovan Djilas | 
| The Captive Mind | Anglais | 1953 | Instytut Literacki | Czesław Miłosz | 
| La machine et les rouages | Français | 1985 | Calmann-Lévy | Michel Heller | 
| The Intellectuals on the Road to Class Power| Anglais | 1979 | Harvester Press |Geoge Konrad, Ivan Szelenyi |


 
**Table 2 : auteur**

| Prénom | Nom | Nationalité | Ville de naissance | Date de naissance |  
| :------ | :---------------- | :-------------------- | :--------------------- | 
| Alexandre | Soljenitsyne | Russe | Kislovodsk | 1918 |
| Vassili | Grossman | Russe | Berdytchiv | 1905 |
| Milovan | Djilas | Monténégrine | Podbišće |  1911 |
| Czesław | Miłosz | Polonaise | Szetejnie | 1911 |
| Michel | Heller | Russe | Moguilev | 1922 |
|Geoge | Konrad | Hongrois| Berettyóújfalu | 1933 |
| Ivan | Szelenyi | Hongrois | Budapest | 1938 |




**Table 3 : maison d’édition**  

| Nom | Ville | Date de fondation | 
| :-------------------- | :------ | :-------------------- | 
| Le Seuil | Paris | 1930 | 
| L'âge de l’homme | Genève | 1955 |
| Praeger | New York |  1950 |
| Instytut Literacki | Paris | 1946 | 
| Calmann-Lévy | Paris | 1920 | 
| Harvester Press | Brighton | ? |

 
Nous avons maintenant les informations de notre recherche en trois tables qui représentent notre jeu de données. Afin de pouvoir naviguer entre elles en suivant les relations que nous avons établies dans le modèle, on doit maintenant les relier. Pour ce faire, il faut définir la [*cardinalité*](https://fr.wikipedia.org/wiki/Cardinalit%C3%A9_(programmation))[^6], à savoir les possibilités qui existent et les restrictions qui peuvent se poser dans la manière dont elles se relient.   



## Construire et gérer ses bases de données avec *nodegoat*
 

La constitution d’une base de données relationnelle se fait à l’aide de logiciels spécialisés, les [systèmes de gestion de base de données (SGBD)](https://fr.wikipedia.org/wiki/Syst%C3%A8me_de_gestion_de_base_de_donn%C3%A9es), qui permettent d'interroger et de manipuler nos données selon les principes du langage de requête [SQL](https://fr.wikipedia.org/wiki/Structured_Query_Language). Il existe une multitude de SGBD, sous licence libre ou propriétaires (comme Microsoft Access). Il n'est pas toujours aisé de manier un tel dispositif, et c'est pourquoi, dans ce tutoriel, nous allons nous servir du logiciel en ligne nodegoat qui est spécifiquement conçu pour faciliter ce processus pour les chercheur(e)s en sciences humaines. 
 

[*nodegoat*](https://nodegoat.net/) est un logiciel en ligne qui permet aux utilisateurs et aux utilisatrices de modéliser, de construire et de partager leur base de données, plus ou moins intuitivement. Les données sont hébergées en ligne, mais il est aussi possible de les exporter, notamment en format [CSV](https://fr.wikipedia.org/wiki/Comma-separated_values) (format répandu et courant dans la gestion de données, représentant des données tabulaires) et en format de texte, ce qui rend possible de faire des sauvegardes locales régulièrement. *nodegoat* est un logiciel libre et il est aussi possible de [l'installer localement](https://github.com/nodegoat/nodegoat), cela exige néanmoins d'avoir des compétences informatiques poussées. À défaut, les usagers individuels peuvent utiliser librement l'application en ligne pour un projet, moyennant l'ouverture d'un compte gratuit. Dans les deux cas (installation locale ou application en ligne), l'utilisation de fonctionnalités plus avancées, notamment pour travailler sur plusieurs projets et/ou de manière collaborative, sont sujettes à la souscription à l'un des modèles économiques proposés par la société qui le développe. 

L’approche du logiciel correspond à ce que l’on a proposé ici pour conceptualiser notre recherche : l’idée centrale est que les personnes, les groupes et les choses peuvent tous être traités comme des objets connectés par des relations diverses.[^7] *nodegoat* offre aussi des outils d’analyse relationnelle et des formes de visualisation géographique et de réseaux. En plus, il permet de consigner certaines informations en respectant l’incertitude et l'ambiguïté qui caractérisent la recherche en sciences humaines, par exemple en proposant des intervalles de temps quand on ne dispose pas de dates exactes pour un phénomène ou en permettant de marquer des polygones quand on ne dispose pas de coordonnées géographiques exactes. Certes, l’objet de cette leçon n’est pas l’utilisation de *nodegoat* *per se* - il est tout à fait possible de vous expérimenter avec [d'autres logiciels de gestion de bases de données spécifiquement conçus pour la recherche en sciences humaines et sociales](/fr/lecons/introduction-a-heurist). Mais en combinant tous ces outils dans un même environnement, *nodegoat* facilite considérablement la tâche de concevoir sa recherche en données aux chercheurs moins expérimentés. Pour nous, sa qualité principale pour cette leçon est qu'il rend particulièrement aisé de définir et d'exécuter le modèle que nous avons décrit de manière abstraite auparavant. Dans le cadre de cette leçon, nous nous servons de *nodegoat* dans sa version 7.3. <!-- mettre à jour: v. 8.1, février 2023-->

Les instructions qui suivent visent à guider les lecteurs et les lectrices dans le processus de création d'une base de données sur *nodegoat* selon les principes expliqués [précédemment](#la-logique-de-notre-recherche--entre-le-modèle-de-données-et-la-base-de-données). Pour les exécuter, nous devons disposer d'un compte d'utilisateur/utilisatrice pour l'application en ligne. Après connexion à *nodegoat*, au début, nous nous retrouvons face à notre *domaine* (espace de travail) vide où l’on trouve trois onglets : **Data** (données), **Management** (gestion) et **Model** (modèle). 


{% include figure.html filename="nodegoat-03.png" caption="Figure 4: Le domaine de nodegoat encore vide." %} 


Dans **Model**, nous construisons notre modèle de données selon la logique que nous avons expliquée dans la section précédente. Dans **Management**, nous définissons les paramètres pour mettre en œuvre ce modèle. Enfin, dans **Data**, nous consignons nos données dans la structure définie selon le modèle et nous examinons ces données.

Nous allons d’abord créer notre projet puis définir notre modèle de données et construire notre base. En cliquant sur l'onglet Management, nous créons notre projet (via Add project) et lui attribuons un titre à partir de la barre qui s'affiche (Name), qui dans notre cas est: Ouvrages de l'Est. 

L'étape suivante est la définition du modèle. Cela se fait depuis l'onglet Model. Nous commençons par ajouter un type d’objet : un Type - dans notre modèle, nous avons défini trois objets: l’ouvrage, l’auteur, la maison d’édition. 


{% include figure.html filename="nodegoat-04.png" caption="Figure 5: Le volet Model et l'option qui nous permet de commencer à définir notre modèle de données." %} 


Nous commençons donc par créer le premier objet de notre jeu de données, l’*ouvrage*. En appuyant sur __Add Object Type__, nous devons définir ce qu’est un *ouvrage*. Il est nécessaire d'établir un nom (ici, Name) et un ensemble d’attributs (ici appelées Descriptions). Pour chacun de ses attributs, il faut aussi préciser le type de valeurs dont il s’agit : chaine de caractères (**String**) pour les valeurs textuelles, par exemple pour le titre d'ouvrage, format spécifique date (**Date**), par exemple pour la date de parution d'un ouvrage, ou [autre](https://nodegoat.net/documentation.s/116/objects#descriptions) en fonction de la nature du jeu de données. 

{% include figure.html filename="nodegoat-05.png" caption="Figure 6: Définition d'un premier objet pour notre modèle de données à travers l'option Add Object Type." %} 

Ensuite, après avoir défini qu’est-ce qu’un *ouvrage*, nous devons faire la même chose avec les deux autres objets de notre modèle, à savoir l’*auteur* et la *maison d’édition*. Tout comme dans le cas de l’ouvrage, nous les définissons en tant qu’objets par leur nom et par l’ensemble de leurs attributs.

Ensuite, nous retournons dans l'onglet Management (gestion), où il faut choisir quels sont les Types (objets) que nous allons utiliser dans ce projet (si nous avons introduit plusieurs objets dans notre base de données, nous pouvons décider de les explorer de manières différentes selon le type de projet ou au long du même projet). Nous faisons cela en appuyant sur l’option Edit de notre projet :

{% include figure.html filename="nodegoat-06.png" caption="Figure 7: Volet Management permettant de gérer le projet et de choisir quels objets seront utilisés." %} 

Aussi, il faut prendre en compte ici qu’au-delà des objets crées par chaque utilisateur dans sa base de données, *nodegoat* vient par défaut avec deux objets (Types) préétablis: City (&laquo;&#x202F;ville&#x202F;&raquo;) et Geometry (&laquo;&#x202F;géométrie&#x202F;&raquo;), qui fait référence à des régions, des pays ou d’autres unités politiques du passé et du présent. Les données géospatiales attachées à ces deux objets (périmètres, coordonnées géographiques etc) proviennent de certaines bases de données géographiques comme GeoNames qui sont reliées à *nodegoat*. Il s’agit ainsi de deux objets très utiles et prêts à l’emploi, dont chaque utilisateur peut se servir dans le cadre de sa recherche et, inversement, contribuer à les enrichir. Dans le cadre de notre projet, nous décidons de nous servir de l'objet City qui contient des informations utiles sur les villes. Autrement dit : nous allons structurer nos données sous le prisme des relations entre ouvrages, auteur, maisons d’éditions et aussi villes. Cela rendra notre modèle de données encore plus complexe, parce qu’il compte maintenant quatre objets (au lieu de trois, comme au début).

Nous avons maintenant hâte d’aller dans l’onglet Data pour commencer à alimenter notre base avec des données sur nos ouvrages, nos auteurs et nos maisons d’éditions! Mais il nous reste encore une étape fondamentale à remplir : établir les relations entre ces objets. Car jusque-là, nous avons seulement fourni les informations pour chaque Type individuellement en remplissant les cases. Mais l’essentiel de la base de données relationnelle est précisément la possibilité de relier ces objets.

Pour rappel, nous avons établi notre modèle en créant d'abord les objets (Model), que nous avons par la suite activés dans notre projet dans l'onglet Management (gestion). À présent, il faut revenir dans l'onglet du modèle (Model) pour intervenir sur chaque objet (Type) de nouveau. Comme tous nos objets sont définis, nous pouvons maintenant les connecter les uns aux autres à travers les attributs qui, selon notre modèle de données, fonctionnent comme connecteurs. Allons donc sur l'objet (Type) Ouvrage; via le bouton Edit, nous accédons à l'onglet Object Types et à partir de là aux attributs (Descriptions). De ceux-là, deux nous intéressent tout particulièrement: Auteur et Maison d’édition. Le premier de ces deux attributs (Auteur) relie notre objet "Ouvrage" avec l'objet "Auteur"; le second relie l'objet "Ouvrage" avec l'objet "Maison d'édition". Pour chacun, nous activons dans le menu déroulant à droite l’option « Reference: Object Type ». Ce faisant, un autre menu déroulant apparaît à côté affichant la liste des objets de notre modèle; nous choisissons respectivement Auteur et Maison d’édition. Cela veut dire que nous avons référencé ces objets comme source des informations qui vont être intégrées dans notre objet "Ouvrage". L’essentiel étant que, maintenant, l'objet "Ouvrage" est, tout comme dans notre modèle, effectivement relié à l'objet "Auteur" et à l'objet "Maison d’édition" à travers ses attributs «&#x202F;Auteur&#x202F;» et «&#x202F;Maison d’édition&#x202F;». Nous avons ainsi réalisé dans les faits les liens que nous avions défini de manière abstraite dans notre modèle.


{% include figure.html filename="nodegoat-07.png" caption="Figure 8: Action pour connecter les objets à travers leurs attributs à travers l'option Reference: Object Type." %}

Aussi, un rappel : nous devons ici cocher la case *multiple* pour « Auteur », afin d’indiquer que certains ouvrages peuvent avoir plus d’un auteur, comme dans le cas de *The Intellectuals on the Road to Class Power*. Cela revient à indiquer ce que nous avons défini auparavant comme une cardinalité de relation 1 : N. Par ailleurs, nous devons aussi sélectionner le symbole que *nodegoat* utilisera comme séparateur des données quand on à faire avec des auteurs multiples dans une même case. Les séparateurs les plus fréquemment utilisés sont `,` ou `;` ou encore `|`, mais attention : votre choix dépend aussi de quel sera le séparateur de vos données en format tabulaire au moment de l’export du CSV, car si le séparateur est le même, cela risque de dérégler la structure des données au moment de l’export.


Enfin, une dernière question concernant la définition de nos objets et de leurs structures : celle de l’incertitude de l’information. L’exemple de l’ouvrage *The Intellectuals on the Road to Class Power* pose bien cette question, car nous n’avons pas la date exacte de fondation de la maison d’édition Harvester Press ! Comment faire dans un cas comme celui-ci ? Si notre recherche indique que les publications de cet éditeur commencent à partir des années 1970, nous pouvons formuler l'hypothèse que ses débuts d'activité doivent se trouver quelque part entre l’année 1970 et l’année 1979 qui est celle de la parution de notre ouvrage. Pour ce type de cas, quand nous avons des pistes mais pas d’information exacte, *nodegoat* permet de consigner une information temporaire en forme d’intervalle de temps (ce que l’on appelle Chronology). 

Pour cela, nous revenons sur l’onglet Model afin d’examiner le Type « Maison d’édition ». En toute probabilité, lorsque nous avions défini la date de fondation comme l'un des attributs de la maison d’édition, nous l’avons fait de la même manière que la date de naissance d’un auteur : à l’intérieur de l’onglet *objects*, sur la liste des « Descriptions » et en choissisant le type de donnée « date ».

{% include figure.html filename="nodegoat-08.png" caption="Figure 9: Attribut « Date de fondation » comme Description." %}

Néanmoins, cette possibilité nous permet uniquement de renseigner une date exacte et ce dans un format normalisé. Mais nous savons que cela ne convient à pas nos données sur les maisons d’édition, puisqu'il y a des dates que nous ignorons. Afin de pouvoir consigner une date en forme d’intervalle de temps, nous devons en revanche nous servir de l’onglet « sub-object ». Ici, il faut créer un sub-object appelé « Date de fondation » et cocher l’option « Chronology ».

{% include figure.html filename="nodegoat-09.png" caption="Figure 10: Création d’un sous-objet Chronology pour le Type « Maisons d’édition »." %}

Désormais, le Type « Maison d’édition » comporte un attribut différent de celui de « Auteur », qui permet d’introduire des informations temporelles comme un intervalle de temps. 

Maintenant, notre modèle étant déjà défini avec ses objets et ses relations, nous pouvons revenir sur Management (gestion) pour le visualiser. Si nous cliquons sur le nom de notre projet, *nodegoat* nous donne une visualisation du modèle :

{% include figure.html filename="nodegoat-10.png" caption="Figure 11: Visualisation de notre modèle de données sur nodegoat." %}

Et maintenant, si nous allons sur l'onglet Data (données), nous pouvons en toute liberté renseigner manuellement les champs que nous avons définis pour chacun des objets de notre base de données avec les valeurs que nous collectons au fur et à mesure que notre recherche avance. Cela se fait avec l’option Add (ajouter) sur l’onglet respectif pour chacun de nos objets. Ensuite, en ce qui concerne les « Maison d’édition », nous verrons que l’attribut « Date de fondation » ne s’affiche pas comme un attribut comme les autres, mais comme un élément de Sub-objects dans lequel la date est définie comme une chronologie. L'éditeur nous permet ici de fournir nos informations sur la chronologie à l'aide de trois options : 1) une date exacte, nous pouvons l’indiquer comme un « Point » ; 2) une période après ou avant une certaine année, mois ou jour, nous l’indiquons comme une « déclaration » (en anglais, un Statement) ; 3) une période *comprise entre deux dates* (comme dans notre cas, entre 1970 et 1979), nous l’indiquons comme « entre déclarations ».

{% include figure.html filename="nodegoat-11.png" caption="Figure 12: Création d’une chronologie." %}

{% include figure.html filename="nodegoat-12.png" caption="Figure 13: Exemple de chronologie définie comme période « entre déclarations »." %}

Enfin, après avoir rempli les informations sur nos ouvrages, auteurs et maisons d’éditions, la base de données prendra une forme comme celle fourni dans l'image ci-dessous. Nous pourrons alors cliquer sur chaque élément afin de retrouver ses informations :

{% include figure.html filename="nodegoat-13.png" caption="Figure 14: Aperçu de notre base de données." %}


Nous pouvons aussi importer l'ensemble de nos données après la fin du dépouillement de nos sources, à l'aide de fichiers CSV. Indépendamment de l'option choisie, une fois notre base de données constituée, nous pouvons aussi utiliser les outils que le logiciel nous propose pour explorer davantage nos objets et les relations qui les relient à l'aide de visualisations. Voici par exemple une visualisation des lieux de naissance des auteurs (en bleu) sur le fond de carte fourni par *nodegoat* :

{% include figure.html filename="nodegoat-14.png" caption="Figure 15: Visualisation géographique des villes de naissance de nos auteurs sur nodegoat." %}

Somme toute, *nodegoat* nous permet de définir notre modèle de données et de constituer une base de données de manière relativement simple. Il propose en outre des possibilités multiples pour consigner les informations géographiques et temporelles avec des intervalles d’incertitude qui correspondent au type d’information que nous recueillons souvent dans le domaine des sciences humaines. Par ailleurs, les outils de visualisation permettent d’apprécier l’évolution de notre recherche et d’identifier certaines tendances. Enfin, cet environnement de recherche permet de stocker et de gérer nos données en ligne, tout en offrant la possibilité de les exporter pour les exploiter ces données à l'aide d’autres outils, mais aussi les sauvegarder.

## Conclusion

Ce tutoriel a pour but d’encourager les chercheurs et les chercheuses en sciences humaines à concevoir leur recherche en termes de données et à les initier par la pratique à des notions élémentaires liées aux bases de données, souvent difficiles à saisir (base de données, modèle de données, cardinalité). Nous avons essayé ici de donner ces éléments introductifs en se servant du logiciel en ligne *nodegoat* qui est particulièrement adapté aux besoin des chercheur(e)s débutant dans la gestion numérique des données. 

Il ne reste que de mentionner que *nodegoat* comporte aussi certaines limitations : l’accès individuel gratuit à *nodegoat* est limité à la réalisation d'un seul projet hébérgé sur le site du logiciel. Si l’objectif est de gérer plusieurs projets, d'avoir plusieurs comptes ou d'hébérger le projet sur un serveur propre, il devient nécessaire d'accéder à un plan supérieur, pour lequel il est souvent nécessaire d'avoir le soutien financier et/ou technique d’une institution de recherche ou d’enseignement. 

Dans tous les cas, pour approfondir dans l’utilisation de*nodegoat* et explorer tout son potentiel, nous vous invitons à explorer les [Guides](https://nodegoat.net/guides) préparées par l’équipe de LAB1100, qui expliquent en détail le fonctionnement du logiciel.



[^1]: Posner, Miriam, (2015)., Humanities Data: A Necessary Contradiction, https://miriamposner.com/blog/humanities-data-a-necessary-contradiction/

[^2]: Drucker, Johanna (2011), Humanities Approaches to Graphical Display, Digital Humanities Quarterly, vol. 5, n. 1.

[^3]: Thaller, Manfred (2018), On Information in Historical Sources, A Digital Ivory Tower, https://ivorytower.hypotheses.org/56

[^4]: Bree, P. van, Kessels, G., (2013). nodegoat: a web-based data management, network analysis & visualisation environment, http://nodegoat.net from LAB1100, http://lab1100.com 

[^5]: Gardarin, Georges (2003), Bases de données, Paris : Eyrolles. Le livre est librement accessible depuis [le site web de l'auteur](http://georges.gardarin.free.fr/Livre_BD_Contenu/XX-TotalBD.pdf). 

[^6]: Voir cette notice de Wikipédia pour plus d’éléments sur la notion de « cardinalité » : « Modèle relationnel », https://fr.wikipedia.org/wiki/Mod%C3%A8le_relationnel#Relation_1:N . Voir aussi Gardarin, ouvrage cité, 412-413.

[^7]: Les créateurs de *nodegoat* décrivent l’approche relationnelle du logiciel comme « orienté-objet ». Ce concept étant le plus souvent utilisé pour décrire un paradigme de programmation informatique, nous préférons donc éviter l’emploi de ce terme afin d’éviter des confusions.

