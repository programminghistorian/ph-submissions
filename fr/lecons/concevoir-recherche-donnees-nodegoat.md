---
title: Concevoir une recherche en sciences humaines en termes de données (et ne pas mourir en essayant)
collection: lessons
layout: lesson
slug: concevoir-recherche-donnees-nodegoat
date: 2022-01-11
authors:
- Agustín Cosovschi
reviewers:
- 
- 
editors:
- Sofia Papastamkou
review-ticket: 
difficulty: 1
activity: transforming
topics:
 - data-manipulation
abstract: |

avatar_alt:
doi: 
---

{% include toc.html %}

## Introduction 
 
Au moment de faire ses premiers pas dans le monde numérique, le chercheur ou la chercheuse en sciences humaines se confronte à plusieurs défis. Tout d’abord, les défis techniques : l’emploi des outils numériques n’est pas toujours évident et la maîtrise d’une méthode, d’un logiciel ou encore plus d’un langage de programmation exige souvent une pratique longue et parfois ardue. Mais l’initiation dans les méthodes numériques pose un autre défi, tout à fait différent mais également difficile : le besoin de réfléchir à sa recherche en termes de *données*.
 
Dans cette leçon, nous discuterons des difficultés auxquelles on doit se confronter au moment de concevoir la recherche en termes de données. Nous donnerons aussi un ensemble d’éléments afin de faciliter ce processus aux chercheurs et chercheuses moins expérimenté(e)s. Dans cette leçon, nous allons donc :

1. Discuter des difficultés auxquelles on doit se confronter au moment de concevoir la recherche en termes de données.
2. Présenter les concepts de « base de données orientée objet » et de « modèle de données ».
3. Faire les premiers pas dans la construction d’une base de données pour une recherche en sciences humaines.

Pour ce dernier point, nous nous serviront de l’environnement de recherche *nodegoat* qui permet aux chercheurs de concevoir leur modèle de données de manière flexible, de gérer et conserver leurs données en ligne, d’exporter et importer ces données de manière simple et enfin, de produire des formes de visualisation géographique et de réseaux.
 
## Penser en termes de données : un défi conceptuel
 
De quoi parle-t-on quand on parle de *donnés* ?
 
De manière générale, nous pouvons définir les données (en anglais, *data*) comme des informations structurées en unités discrètes et se prêtant au traitement automatique. Ces informations doivent être constituées de manière telle que si quelqu'un d'autre les utilise et réalise sur elles les mêmes opérations que nous, il ou elle doit arriver au même résultat.
 
Produire des données sur la base d’une recherche implique un certain travail de *traduction* : il faut traduire nos informations de leur forme de base à une forme structurée. La donnée, contrairement à ce que l’on nous fait croire souvent, **n’est pas du tout donnée** : elle n’est pas disponible dans la réalité, elle n'attend pas à ce qu’elle soit recueillie, elle est au contraire le produit d’un travail d’interprétation et de transformation. Afin de produire ses données, le chercheur ou la chercheuse doit savoir comment lire ses sources, en extraire des informations et les consigner de manière structurée.
 
Pour ceux qui font de la recherche en sciences humaines, c’est souvent ici que commencent les problèmes ! Le concept même de *donnée* est parfois problématique. En histoire, en anthropologie ou en littérature, nous sommes habitués à réfléchir aux phénomènes que nous étudions en termes flexibles, ouverts et souvent incertains. Nous sommes habitués à réfléchir à la subjectivité du chercheur, à donner une place centrale à la contingence et enfin, et à voir les phénomènes politiques, sociaux et culturels que nous analysons comme des objets complexes que l'on ne peut pas tout simplement réduire à « un ensemble de données ». Comme le dit Miriam Posner [dans un billet de blog](https://miriamposner.com/blog/humanities-data-a-necessary-contradiction/) à ce sujet :
 
>Les chercheurs en sciences humaines avons un rapport à la preuve tout à fait différent de celui d’autres scientifiques, même celui des chercheurs en sciences sociales. Nous avons de manières différentes de connaître les choses que les chercheurs travaillant dans d’autres champs d'études. Nous pouvons savoir que quelque chose est vrai sans forcément pouvoir indiquer un *dataset* tel que l'on le conçoit traditionnellement. Par exemple, nous sommes capables de comprendre que l’ancien film muet se servait des règles du mélodrame pour créer un récit clair, mais nous ne savons pas cela parce que nous avons une feuille de calcul, nous le savons parce que nous nous sommes plongés tellement dans nos sources que nous sommes devenus particulièrement sensibles à leurs nuances. 
 
Ainsi, pour les chercheurs et chercheuses en sciences humaines, l’idée de lire leurs sources, leurs documents ou leurs notes ethnographiques pour en tirer des informations que l’on insérera dans des catégories fixes, discrètes et structurées dans un tableur est souvent contre-intuitive. Cela nous semble souvent même simpliste et superficielle : comment pourrait-on traduire en termes de *données* une tradition politique, la dimension affective d'une pratique culturelle locale, les enjeux conceptuels de la philosophie moderne ou la psychologie d’un personnage littéraire ?
 
Concevoir notre recherche en termes de données offre pourtant des grands avantages. Dans un premier temps, aborder une recherche en termes de données nous permet d’enregistrer nos informations de façon telle qu’elles puissent être traitées de manière automatique par des méthodes numériques. Cela s’avère surtout utile quand on se confronte à une investigation qui doit manipuler une grande masse d’informations. Dans un deuxième temps, consigner ces informations dans une base de données nous permet de partager facilement ces information avec le reste de la communauté scientifique. Enfin, concevoir la recherche en termes de données offre des avantages non seulement techniques et pratiques, mais aussi conceptuelles, car le processus même de traduire nos informations en données exige que nous définissions de manière claire et nette les éléments de notre investigation, nos hypothèses et nos questions de recherche. Autrement dit : quand on réfléchit en termes de données et on se demande quelle est la structure selon laquelle on doit consigner ses informations, on est aussi obligé de se demander clairement quel sont les objets de notre recherche, quelles relations le relient mutuellement, comment ils interagissent et quels sont les conséquences de ces interactions.
 
## Base de données et modèle de données
 
Comme mentionné auparavant, si notre recherche produit à une quantité conséquente d’informations, c’est souvent préférable de consigner ces informations de manière organisée et structurée. Par exemple, disons que nous menons une recherche historique sur un ensemble de livres. Nous parlerons ici d’une recherche hypothétique : un projet portant sur les ouvrages produits par les écrivains dissidents des régimes communistes d’Europe de l’Est. 

Si nous voulions consigner des informations sur ces livres. Nous le ferions de manière intuitive dans un tableau type feuille de calcul d’Excel, comme ça :
 
 
| Titre | Ville de parution | Auteur |
| ------ | -------------------- | ---------|
| L’Archipel du Gulag | Paris | Alexandre  Soljenitsyne |
| Vie et destin | Génève | Vassili Grossman |
| La nouvelle classe | New York | Milovan Djilas |
| La pensée captive | Paris | Czesław Miłosz |
| La machine et les rouages | Paris | Michel Heller |

 
Ce tableau avec trois colonnes nous permet de consigner nos informations de manière très simple. Cela constitue déjà, de manière plutôt élémentaire, ce que l’on pourrait appeler un « jeu de données » (en anglais, *dataset*). Chaque file dans le tableur représente un cas (un « enregistrement »), alors que chaque colonne représente une caractéristique (un « attribut ») de ces cas : le titre, la ville d’édition et l’auteur de chaque ouvrage.
 
Pour l’instant, cela suffit comme instrument et ne pose pas de problème, parce que nous y conservons une masse d’informations peu conséquente. Mais disons que nous voulons approfondir notre enquête et nous poser de nouvelles questions sur les ouvrages et sur les auteurs. Nous pourrions élargir le tableau comme ça :

| Titre | Ville de parution | Langue de la première édition | Date de parution | Maison d’édition | Date de fondation de la maison d’édition | Auteur | Nationalité de l’auteur | Ville de naissance de l’auteur | Date de naissance de l’auteur |
| ------ | ------------- | --------- | ------ | -------------------- | ---------|---------| ---------| ---------| ---------|
| L’Archipel du Gulag | Paris | Français | 1973 | Le Seuil  | 1930 | Alexandre  Soljenitsyne | Russe | Kislovodsk | 1918 |
| Vie et destin | Genève | Français | 1980 | L’age de l’homme | 1955 |Vassili Grossman | Russe | Berdytchiv | 1905 |
| La nouvelle classe | New York | Anglais | 1957 | Praeger |  1950 | Milovan Djilas | Monténégrine | Podbišće |  1911 |
| La pensée captive | Paris | Polonais | 1953 | Instytut Literacki | 1946 | Czesław Miłosz | Polonaise | Szetejnie | 1911 |
| La machine et les rouages | Paris | Français | 1985 | Calmann-Lévy | 1920 | Michel Heller | Russe | Moguilev | 1922 |

 
Ce nouveau tableau nous permet d’approfondir dans l’analyse en ajoutant de nouvelles informations. Pourquoi on voudrait faire cela ? Par exemple, pour examiner s’il existe des relations entre les caractéristiques des livres avec les caractéristiques des auteures. Nous pourrions éventuellement nous demander si les auteurs des ouvrages emblématiques de la dissidence de l’Est sont surtout des individus nés dans des petites villes, si les auteurs de nationalité russe ont tendance à se faire traduire premièrement en français.
 
Dans tous les cas, au fur et à mesure que l’on commence à multiplier les cas analysés et les questions posées, l’information se multiplie. La gestion et l'analyse de cette information devient donc plus difficile : si nos questions se multiplient, aussi se multiplient les colonnes dans notre tableau et il devient de plus en plus difficile de lire, croiser et interpréter toutes ces informations. Quand cela arrive, au lieu de rassembler toutes nos informations dans un même tableau, il est souvent plus utile de commencer à réfléchir aux *relations* qui connectent les différents objets de notre recherche, de faire un tableau pour chacun d’entre eux et enfin, de les relier dans une *base de données*.
 
Qu’est-ce qu’une *base de données* ? De manière générale, il s’agit d’un conteneur qui organise des informations selon une certaine structure. Dans cet article, nous nous concentrons sur un type particulier et assez fréquent de base de données : la base de données relationnelle. Il s’agit d’un ensemble de tableaux reliés pour que l’on puisse circuler entre eux. La base de données contient notamment deux types d’éléments : des objets et des relations entre ces objets. Chacun de ces objets est une réalité complexe qui comporte de nombreuses caractéristiques (« attributs », les colonnes) qui s’expriment dans des cas particuliers (les « enregistrements », les lignes). Mais pour pouvoir construire notre base de données, nous devons définir quels sont quels sont les objets, quels attributs ils contiennent et comment ils se connectent les uns aux autres. Cela nous oblige à passer tout d’abord par ce que l’on appelle un *modèle de données*.
 
Dans notre exemple, nous avons identifié trois objets qui nous intéressent : les livres, les maisons d’éditions et les auteurs. La question que l’on doit se poser est : comment sont-ils connectés entre eux ? La réponse à cette question dépend surtout des questions que nous voulons poser et de notre manière de conceptualiser le phénomène. Dans le cas proposé ici, si le centre de notre attention est sur le *livre en tant qu’objet de circulation*, nous pouvons par exemple imaginer un graphique élémentaire comme celui-ci connectant ouvrage, auteur et maison d’édition :
 
 
{% include figure.html filename="nodegoat-01.png" caption="Figure 1: Sans titre." %} 
 
 

Chaque ouvrage est ainsi lié à un certain auteur et à une certaine maison d’édition. Mais nous devons aussi nous demander, comme on l’a évoqué, qu’est-ce que chacun de ces objets contient comme information, de quels éléments est-il composé et comment exactement ces objets sont-ils reliés entre eux. Tout cela dépend de quels sont leurs attributs, ce qui dépend à la fois des questions que nous nous posons. En suivant le tableau original de notre recherche hypothétique, nous pourrons définir nos objets comme contenant les attributs suivants et comme étant connectés ainsi  :
 
 
 
{% include figure.html filename="nodegoat-02.png" caption="Figure 2: Sans titre." %}
 

Ce *modèle de données* nous permet de définir plus clairement quels sont nos objets et comment ils sont connectés les uns avec les autres. Sur la base de ce modèle, nous pouvons maintenant créer des tableurs pour consigner les informations de chacun de ces objets.


Table 1: ouvrages  

| Titre | Ville de parution | Langue de la premiére édition | Date de parution | Maison d’édition |Auteur | 
| :------ | :------------- | :--------- | :------ | :-------------------- | :---------|
| L’Archipel du Gulag | Paris | Français | 1973 | Le Seuil  | Alexandre  Soljenitsyne | 
| Vie et destin | Genève | Français | 1980 | L’age de l’homme | Vassili Grossman | 
| La nouvelle classe | New York | Anglais | 1957 | Praeger |  Milovan Djilas | 
| La pensée captive | Paris | Polonais | 1953 | Instytut Literacki | Czesław Miłosz | 
| La machine et les rouages | Paris | Français | 1985 | Calmann-Lévy | Michel Heller | 
 
Table 2 : auteurs
| Auteur | Nationalité | Ville de naissance | Date de naissance |  
| ------ | ---------------- | -------------------- | --------------------- | 
| Alexandre  Soljenitsyne | Russe | Kislovodsk | 1918 |
| Vassili Grossman | Russe | Berdytchiv | 1905 |
| Milovan Djilas | Monténégrine | Podbišće |  1911 |
| Czesław Miłosz | Polonaise | Szetejnie | 1911 |
| Michel Heller | Russe | Moguilev | 1922 |


Table 3 : maisons d’édition
| Maison d’édition | Date de fondation | 
| -------------------- | -------------------- | 
| Le Seuil  | 1930 | 
| L'âge de l’homme | 1955 |
| Praeger |  1950 |
| Instytut Literacki | 1946 | 
| Calmann-Lévy | 1920 | 
 
Nous avons maintenant les informations de notre recherche en trois tableaux : chacun d’entre eux représente un jeu de données à part, qui peut être conservé et utilisé de manière indépendante. Mais on doit maintenant les relier de manière telle que nous puissions naviguer entre eux en suivant les relations que nous avons établies dans le modèle. Ce type d’opération se fait souvent sur une application comme Excel qui permet de connecter des tableurs multiples. Dans ce tutoriel, nous allons pourtant nous servir du logiciel en ligne nodegoat qui est spécifiquement conçu pour faciliter ce processus aux chercheurs en sciences humaines.
 
## Construire et gérer ses bases de données avec *nodegoat*
 
[*nodegoat*](https://nodegoat.net/) est un logiciel en ligne développé par LAB1100 et qui permet aux chercheurs de construire leurs bases de données à partir de leur propre modèle de données et conserver ces données en ligne. L’approche du logiciel est ce que l’on appelle « orienté-objet » qui correspond à ce que l’on a proposé ici pour conceptualiser notre recherche : l’idée centrale est que les personnes, les groupes et les choses peuvent tous être traités comme des « objets » connectés par des relations diverses. *nodegoat* offre des outils d’analyse relationnelle et des formes de visualisation géographique et de réseaux. Aussi, il permet de consigner les informations en respectant l’incertitude et l'ambiguïté qui caractérisent la recherche en sciences humaines, par exemple en proposant des intervalles de temps quand on ne dispose pas de dates exactes pour un phénomène ou en permettant de marquer des polygones quand on ne dispose pas de coordonnées géographiques exactes. En combinant tous ces outils dans un même environnement, *nodegoat* facilite considérablement la tâche de concevoir sa recherche en données aux chercheurs moins expérimentés.
 
L’objet de ce tutoriel n’est pas l’utilisation de *nodegoat* per se. Il faut néanmoins rappeler que pour les usagers individuels, l’équipe de LAB1100 offre un compte gratuit pour héberger leurs données en ligne.
 
Sur *nodegoat* , nous devons d’abord définir notre modèle de données et construire notre base de données. Au début, nous nous retrouvons face à notre *domaine* vide où l’on trouve trois onglets : **Data** (données), **Management** (gestion) et **Model** (modèle). 


{% include figure.html filename="nodegoat-03.png" caption="Figure 3: Sans titre." %}

Dans **Model**, nous construisons notre modèle de données selon la logique que nous avons expliquée dans la section précédente. Dans **Management**, nous définissons les paramètres pour mettre en œuvre ce modèle. Enfin, dans **Data**, nous consignons nos données dans la structure définie selon le modèle et nous examinons ces données.
 
Le point de départ sera donc la définition du modèle. C’est peut-être la qualité principale de *nodegoat* pour ce tutoriel, car c’est à travers cet outil que nous pourrons exécuter le modèle que nous avons décrit de manière abstraite auparavant. Le logiciel nous propose de commencer par ajouter un type d’objet : un Type (pour nous, un objet, comme l’ouvrage, l’auteur ou la maison d’édition). 


{% include figure.html filename="nodegoat-04.png" caption="Figure 4: Sans titre." %}


Nous devons donc définir le premier objet de notre recherche hypothétique, l’*ouvrage*. En appuyant sur __Add Object Type__, nous devons définir qu’est-ce qu’un *ouvrage*. Nous devons nécessairement établir un nom (Name) et un ensemble d’attributs (ici appelées Descriptions). Pour chacun de ses attributs, nous devons définir de quel type de donnée s’agit : chaine de caractères, numéro, date ou autre. 


{% include figure.html filename="nodegoat-05.png" caption="Figure 5: Sans titre." %}

Ensuite, après avoir défini qu’est-ce qu’un *ouvrage*, nous devons faire la même chose avec les deux autres objets de notre modèle, à savoir l’*auteur* et la *maison d’édition*. Tout comme dans le cas de l’ouvrage, nous les définissons en tant qu’objets par leur nom et par l’ensemble de leurs attributs. 

Ensuite, dans Management, il faut choisir quels sont les objets (Types) que nous allons utiliser dans ce projet (si nous avons introduit plusieurs objets dans notre base de données, nous pouvons décider de les explorer de manières différentes selon le type de projet ou au long du même projet). Nous faisons cela en appuyant sur l’option Edit de notre projet :

{% include figure.html filename="nodegoat-06.png" caption="Figure 6: Sans titre." %}


Aussi, il faut prendre en compte ici qu’au-delà des objets crées par chaque utilisateur dans sa base de données, *nodegoat* vient par défaut avec deux Types (objets) préétablis: City (ville) et Geometry (pays). Il s’agit de deux objets très utiles dont chaque utilisateur peut se servir dans le cadre de sa recherche. Dans le cadre de ce projet, nous décidons d’utiliser le Type City qui contient des informations utiles sur les villes, par exemple des coordonnés géographiques. Autrement dit : maintenant nous allons structurer nos données sous le prisme des relations entre ouvrages, auteur, maisons d’éditions et villes. Cela rendra notre modèle de donnés encore plus complexe, parce qu’il compte maintenant quatre objets (au lieu de trois, comme au début).

En principe, nous serions en conditions d’aller d’ores et déjà dans l’onglet Data et commencer à remplir les informations sur nos ouvrages, nos auteurs et nos maisons d’éditions. Mais il nous reste encore une partie fondamentale : établir les relations entre ces objets. Jusque-là, nous avons défini les informations de chaque Type en remplissant les cases. Mais l’essentiel de la base de données relationnelle est précisément la possibilité de relier ces objets.

Pour cela, après avoir établi les Types dans **Model** et les avoir activés dans **Management**, il faut revenir sur **Model** et éditer chaque Type de nouveau. Comme tous nos objet sont définis, nous pouvons maintenant les connecter les uns aux autres à travers les attributs qui fonctionnent comme connecteurs selon notre modèle de données. Nous devons donc éditer le Type *ouvrage* et dans les cases **Auteur** et **Maison d’édition** nous activons comme source de ces informations « Reference: Object Type ». Cela qui veut dire que cette information vient directement d’un autre Type. Après, nous choisissons respectivement Auteur et Maison d’édition. L’essentiel : **maintenant le Type *ouvrage* est, tout comme dans notre modèle, relié au Type *auteur* et au Type *maison d’édition* à travers ses attributs “Auteur” et “Maison d’édition”.**

{% include figure.html filename="nodegoat-07.png" caption="Figure 7: Sans titre." %}



Notre modèle étant déjà défini avec ses objets et ses relations, nous pouvons revenir sur Management pour le visualiser. Si nous faisons click sur le nom de notre projet, *nodegoat* nous donne une visualisation de notre modèle :

{% include figure.html filename="nodegoat-08.png" caption="Figure 8: Sans titre." %}

Maintenant, si nous allons sur l'onglet Data, nous pouvons avec toute liberté introduire les informations sur chacun de nos cas dans la base de données au fur et à mesure que notre recherche avance. Cela se fait avec l’option Add dans l’onglet respectif pour chacun de nos objets. La base de données prendra ainsi une forme comme celle-là :


{% include figure.html filename="nodegoat-09.png" caption="Figure 9: Sans titre." %}

Enfin, avec notre base de données constituée, nous pouvons aussi utiliser les outils que le logiciel nous propose pour visualiser ces objets et ses relations. Voici par exemple une visualisation des lieux de naissance des auteurs (en bleu) sur la carte de *nodegoat* :

{% include figure.html filename="nodegoat-10.png" caption="Figure 10: Sans titre." %}

Somme toute, *nodegoat* nous permet de constituer une base de données de manière relativement simple et en définissant nous-mêmes notre modèle de données. Aussi, le logiciel permet de conserver et de gérer ces données en ligne et il propose des possibilités multiples pour consigner les informations géographiques et temporelles avec des intervalles d’incertitude qui correspondent au type d’information que nous recueillons souvent dans le domaine des sciences humaines. Les outils de visualisation permettent d’apprécier l’évolution de notre recherche et d’identifier certaines tendances. Enfin, *nodegoat* nous donne aussi la possibilité d’exporter facilement nos données dans un document en format CSV pour exploiter ces données avec d’autres utiles.

## Conclusion

Ce tutoriel a pour but d’encourager les chercheurs et chercheuses en sciences humaines à concevoir leur recherche en termes de données et les familiariser avec des concepts souvent difficiles à saisir comme celui de *base de données* et *modèle de données*. Nous avons essayé ici de donner des éléments introductifs pour appliquer ces principes en se servant du logiciel en ligne *nodegoat*. Pour approfondir dans l’utilisation de*nodegoat* et explorer tout son potentiel, nous vous invitons à explorer les [Guides](https://nodegoat.net/guides) préparées par l’équipe de LAB1100, qui expliquent en détail le fonctionnement du logiciel.


