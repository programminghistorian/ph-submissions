---
title: Des sources aux données: concevoir sa recherche en sciences humaines à l'aide de nodegoat
collection: lessons
layout: lesson
slug: concevoir-recherche-donnees-nodegoat
date: 2022-01-11
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
topics: 
- data-manipulation
abstract: | 
  Ce tutoriel permet de prendre en main le logiciel nodegoat pour construire une base de données relationnelle dans le cadre d'une recherche en sciences humaines.
avatar_alt:
doi:
--- 

{% include toc.html %}

## Introduction : le défi conceptuel de penser en termes de données

 
Au moment de faire ses premiers pas dans le monde des humanités numériques, le chercheur ou la chercheuse en sciences humaines se confronte à plusieurs défis. Tout d’abord, les défis techniques : l’emploi des outils numériques n’est pas toujours évident et la maîtrise d’une méthode, d’un logiciel ou encore plus d’un langage de programmation exige souvent une pratique longue et parfois ardue. L’initiation aux méthodes numériques pose néanmoins aussi un autre défi, tout à fait différent mais également difficile : le besoin de réfléchir à sa recherche en termes de *données*. Mais, de quoi parle-t-on quand on parle de *données* ?
 
De manière générale, nous pouvons définir les [données](https://fr.wikipedia.org/wiki/Donn%C3%A9e_(informatique)) (en anglais, *data*) comme des informations structurées en unités discrètes et se prêtant au traitement automatique. Ces informations doivent être constituées de telle manière que, si quelqu'un d'autre les utilise et réalise sur elles les mêmes opérations que nous, il ou elle doit arriver au même résultat. 

Produire des données sur la base d’une recherche implique un certain travail de *traduction* : il faut traduire nos informations de leur forme de base à une forme structurée. La donnée, contrairement à ce que l’on nous fait croire souvent, **n’est pas du tout donnée** : elle n’est pas disponible dans la réalité, elle n'attend pas à ce qu’elle soit recueillie, elle est au contraire le produit d’un travail d’interprétation et de transformation. Afin de produire ses données, le chercheur ou la chercheuse doit savoir comment lire ses sources, en extraire des informations et les consigner de manière structurée. 

Pour ceux et celles qui font de la recherche en sciences humaines, c’est souvent ici que commencent les problèmes, car le concept même de *donnée* est parfois problématique. En histoire, en anthropologie ou en littérature, nous sommes habitués à réfléchir aux phénomènes que nous étudions en termes flexibles, ouverts et souvent incertains. Nous sommes habitués à réfléchir à la subjectivité du chercheur, à donner une place centrale à la contingence et enfin, et à voir les phénomènes politiques, sociaux et culturels que nous analysons comme des objets complexes que l'on ne peut pas tout simplement réduire à « un ensemble de données ». Comme le dit Miriam Posner [dans un billet de blog](https://miriamposner.com/blog/humanities-data-a-necessary-contradiction/) à ce sujet :
 
>Nous les chercheur(e)s en sciences humaines avons un rapport à la preuve tout à fait différent de celui d’autres scientifiques, même de celui des chercheur(e)s en sciences sociales. Nous avons des manières différentes de connaître les choses que les chercheur(e)s travaillant dans d’autres champs d'études. Nous pouvons savoir que quelque chose est vrai sans forcément pouvoir renvoyer à un jeu de données tel que l'on le conçoit traditionnellement.[^1] 
 
Ainsi, pour les chercheur(e)s en sciences humaines, l’idée de lire leurs sources, leurs documents ou leurs notes ethnographiques pour en tirer des informations que l’on insérera dans des catégories fixes, discrètes et structurées dans un tableur est souvent contre-intuitive. Cela nous semble souvent même simpliste et superficiel : comment pourrait-on traduire en termes de *données* une tradition politique, la dimension affective d'une pratique culturelle locale, les enjeux conceptuels de la philosophie moderne ou la psychologie d’un personnage littéraire ?
 
Concevoir notre recherche en termes de données offre pourtant des grands avantages. Dans un premier temps, aborder une recherche en termes de données nous permet d’enregistrer nos informations de façon telle qu’elles puissent être traitées de manière automatique par des méthodes numériques. Cela s’avère surtout utile quand on se confronte à une investigation qui doit manipuler une grande masse d’informations. Dans un deuxième temps, consigner ces informations dans une base de données nous permet de partager facilement ces informations avec le reste de la communauté scientifique. Enfin, concevoir la recherche en termes de données offre des avantages non seulement techniques et pratiques, mais aussi conceptuels, car le processus même de traduire nos informations en données exige que nous définissions de manière claire et nette les éléments de notre investigation, nos hypothèses et nos questions de recherche. Autrement dit : quand on réfléchit en termes de données et on se demande quelle est la structure selon laquelle on doit consigner ses informations, on est aussi obligé de se demander clairement quel sont les objets de notre recherche, quelles relations le relient mutuellement, comment ils interagissent et quels sont les conséquences de ces interactions.
 

Dans cette leçon, nous discuterons des difficultés auxquelles on doit se confronter au moment de concevoir la recherche en termes de données. Nous donnerons aussi un ensemble d’éléments afin de faciliter ce processus aux chercheur(e)s moins expérimenté(e)s. Dans cette leçon, nous allons donc :


1. Présenter de manière générale un ensemble de concepts qui permettent d’aborder le travail avec des données, en particulier ceux de « base de données», « base de données relationnelle », « cardinalité » et « modèle de données ».

2. Faire les premiers pas dans la construction d’une base de données pour une recherche en sciences humaines. Pour cela, nous nous servirons de l’environnement de recherche *nodegoat*[^2] qui permet aux chercheurs et aux chercheuses de concevoir leur modèle de données de manière flexible, de gérer et conserver leurs données en ligne, d’introduire des informations historiques avec un certain degré d’incertitude, d’exporter et importer ces données de manière simple et enfin, de produire des formes de visualisation géographique et de réseaux, entre autres.
 
Ainsi, nous espérons pouvoir donner aux chercheur(e)s débutant dans le domaine du numérique un ensemble d’outils conceptuels et techniques qui leur permettront de comprendre les avantages d’une forme de travail dont la logique n’est pas toujours évidente pour ceux et celles formé(e)s en sciences humaines.


## La logique de notre recherche : entre le modèle de données et la base de données
 
Comme mentionné auparavant, si notre recherche produit une quantité conséquente d’informations, il est souvent préférable de consigner ces informations de manière organisée et structurée. Par exemple, disons que nous menons une recherche historique sur un ensemble de livres. Nous parlerons ici d’une recherche hypothétique : un projet portant sur les ouvrages produits par les écrivains dissidents des régimes communistes d’Europe de l’Est. 

Si nous voulions consigner des informations sur ces livres, nous le ferions de manière intuitive dans un [tableur](https://fr.wikipedia.org/wiki/Tableur), comme cela :
 

| Titre | Ville de parution | Auteur |
| :------ | :-------------------- | :---------|
| L’Archipel du Gulag | Paris | Alexandre  Soljenitsyne |
| Vie et destin | Génève | Vassili Grossman |
| La nouvelle classe | New York | Milovan Djilas |
| La pensée captive | Paris | Czesław Miłosz |
| La machine et les rouages | Paris | Michel Heller |
| The Intellectuals on the Road to Class Power| Brighton | Geoge Konrad, Ivan Szelenyi |



Ce tableau avec trois colonnes nous permet de consigner nos informations de manière très simple. Cela constitue déjà, de manière plutôt élémentaire, ce que l’on pourrait appeler un [« jeu de données »](https://fr.wikipedia.org/wiki/Jeu_de_donn%C3%A9es) (en anglais, *dataset*). Chaque ligne dans le tableau représente un cas (un « enregistrement »), alors que chaque colonne représente une caractéristique (un « attribut ») de ces cas : le titre, la ville d’édition et l’auteur de chaque ouvrage.
 
Pour l’instant, cela suffit comme instrument et ne pose pas de problème, parce que nous y conservons une masse d’informations peu conséquente. Mais disons que nous voulons approfondir notre enquête et nous poser de nouvelles questions sur les ouvrages et sur les auteurs. Nous pourrions élargir le tableau comme suit :

 
| Titre | Ville de parution | Langue de la première édition | Date de parution | Maison d’édition | Date de fondation de la maison d’édition | Auteur | Nationalité de l’auteur | Ville de naissance de l’auteur | Date de naissance de l’auteur |
| :------ | :------------- | :--------- | :------ | :-------------------- |:--------- |:---------| :---------| :---------| :---------|
| L’Archipel du Gulag | Paris | Français | 1973 | Le Seuil  | 1930 | Alexandre  Soljenitsyne | Russe | Kislovodsk | 1918 |
| Vie et destin | Genève | Français | 1980 | L’age de l’homme | 1955 |Vassili Grossman | Russe | Berdytchiv | 1905 |
| La nouvelle classe | New York | Anglais | 1957 | Praeger |  1950 | Milovan Djilas | Monténégrine | Podbišće |  1911 |
| La pensée captive | Paris | Polonais | 1953 | Instytut Literacki | 1946 | Czesław Miłosz | Polonaise | Szetejnie | 1911 |
| La machine et les rouages | Paris | Français | 1985 | Calmann-Lévy | 1920 | Michel Heller | Russe | Moguilev | 1922 |
| The Intellectuals on the Road to Class Power| Brighton | Anglais | 1979 | Harvester Press | ? |Geoge Konrad, Ivan Szelenyi | Hongrois, Hongrois | Berettyóújfalu, Budapest | 1933, 1938 |

 

Ce nouveau tableau nous permet d’approfondir dans l’analyse en ajoutant de nouvelles informations. Pourquoi voudrait-on faire cela ? Par exemple, pour examiner s’il existe des relations entre les caractéristiques des livres et celles des auteurs. Nous pourrions éventuellement nous poser des questions concernant la relation entre  la nationalité d’un auteur et la première langue de parution de son ouvrage : est-ce qu’il y a une tendance chez les auteurs de nationalité russe à faire paraître leurs ouvrages en français, contrairement aux monténégrins (à l’époque, yougoslaves), hongrois et polonais ? Cela pourrait éventuellement suggérer l’existence de certains réseaux de traduction et d’édition qui peuvent être d’intérêt pour une recherche historique.

Mais ce tableau devient maintenant un peu moins pratique, car au fur et à mesure que l’on commence à multiplier les cas analysés et les questions posées, l’information se multiplie. Aussi, dans certains cas comme celui de l’ouvrage *The Intellectuals on the Road to Class Power*, nous avons même plus d’un auteur, ce qui multiplie encore plus la complexité de nos données. Enfin, dans certains cas, comme celui de la maison d’édition Harvester Press, nous ne sommes même pas certains de la date de fondation (car les informations sur cette petite maison d’édition anglaise sont plutôt limitées), un exemple classique de l’incertitude qui caractérise parfois la recherche en sciences humaines. Bref, si nos questions et nos cas se multiplient, aussi se multiplient les colonnes dans notre tableau et il devient de plus en plus difficile de lire, croiser et interpréter toutes ces informations. 

Quand cela arrive, au lieu de rassembler toutes nos informations dans un même tableau, il est souvent plus utile de commencer à réfléchir aux *relations* qui connectent les différents objets de notre recherche, de faire un tableau pour chacun d’entre eux - une [table de données](https://fr.wikipedia.org/wiki/Table_(base_de_donn%C3%A9es)) - et, enfin, de les relier dans une [base de données](https://fr.wikipedia.org/wiki/Base_de_donn%C3%A9es).
 
Qu’est-ce qu’une *base de données* ? De manière générale, nous pourrions dire qu’il s’agit d’un conteneur qui organise des informations selon une certaine structure. Plus spécifiquement, comme le dit Georges Gardarin, une base de données est « un ensemble de données modélisant les objets d’une partie du monde réel et servant de support à une application informatique ».[^3] Les données dans une base de données doivent pouvoir être interrogeables par le contenu, autrement dit, nous devons pouvoir retrouver toutes les données qui satisfont à un certain critère (dans notre exemple : tous les auteurs de nationalité russe ou tous les ouvrages parus en français). Entre autres, c’est cette *interrogeabilité* qui fait de la base de données un outil puissant d’exploration et d’analyse de nos informations.


Dans cet article, nous nous concentrons sur un type particulier et assez fréquent de base de données : la base de données relationnelle. Il s’agit d’une structure que l’on peut envisager comme un ensemble de tables reliés pour que l’on puisse circuler entre eux. La base de données contient notamment deux types d’éléments : des objets et des relations entre ces objets. Chacun de ces objets est une réalité complexe qui comporte de nombreuses caractéristiques (« attributs », les colonnes) qui s’expriment dans des cas particuliers (les « enregistrements », les lignes). Mais pour pouvoir construire notre base de données, nous devons définir les objets, les attributs qu'ils contiennent et la façon dont ils se connectent les uns aux autres. Cela nous oblige à passer tout d’abord par ce que l’on appelle un *modèle de données*.
 
Dans notre exemple, nous avons identifié trois objets qui nous intéressent : les ouvrages, les maisons d’éditions et les auteurs. La question que l’on doit se poser est : comment sont-ils connectés entre eux ? La réponse à cette question dépend surtout des questions que nous voulons poser et de notre manière de conceptualiser le phénomène. Dans le cas proposé ici, si le centre de notre attention est sur le *livre en tant qu’objet de circulation*, nous pouvons par exemple imaginer un graphique élémentaire comme celui-ci connectant ouvrage, auteur et maison d’édition :
 
 
{% include figure.html filename="nodegoat-01.png" caption="Figure 1: Schéma logique représentant les relations entre livres, maisons d'édition et auteurs." %}
 

Ce schéma correspond, plus ou moins, à ce que l’on appelle généralement un *modèle conceptuel de données*. Ici, chaque ouvrage est ainsi lié à un certain auteur et à une certaine maison d’édition. Mais nous devons ensuite nous demander, comme on l’a évoqué, ce que chacun de ces objets contient comme information, de quels éléments est-il composé et comment exactement ces objets sont-ils reliés entre eux. Tout cela dépend de leurs attributs, qui sont définis selon les questions que nous nous posons. En suivant le tableau original de notre recherche hypothétique, nous pourrons définir nos objets comme contenant les attributs suivants et comme étant connectés ainsi :
 
 
{% include figure.html filename="nodegoat-02.png" caption="Figure 2: Modèle de données avec objets, attributs et relations." %} 


Ceci correspond maintenant à ce que l’on appelle généralement un *modèle logique de données*, qui nous permet de définir plus clairement quels sont nos objets et comment ils sont connectés les uns avec les autres. Sur la base de ce schéma, nous pouvons maintenant créer des tables pour consigner les informations de chacun de ces objets.


**Table 1: ouvrages**  

| Titre | Ville de parution | Langue de la premiére édition | Date de parution | Maison d’édition |Auteur | 
| :------ | :------------- | :--------- | :------ | :-------------------- | :---------|
| L’Archipel du Gulag | Paris | Français | 1973 | Le Seuil  | Alexandre  Soljenitsyne | 
| Vie et destin | Genève | Français | 1980 | L’age de l’homme | Vassili Grossman | 
| La nouvelle classe | New York | Anglais | 1957 | Praeger |  Milovan Djilas | 
| La pensée captive | Paris | Polonais | 1953 | Instytut Literacki | Czesław Miłosz | 
| La machine et les rouages | Paris | Français | 1985 | Calmann-Lévy | Michel Heller | 
| The Intellectuals on the Road to Class Power| Brighton | Anglais | 1979 | Harvester Press |Geoge Konrad, Ivan Szelenyi |


 
**Table 2 : auteurs**

| Nom | Nationalité | Ville de naissance | Date de naissance |  
| :------ | :---------------- | :-------------------- | :--------------------- | 
| Alexandre Soljenitsyne | Russe | Kislovodsk | 1918 |
| Vassili Grossman | Russe | Berdytchiv | 1905 |
| Milovan Djilas | Monténégrine | Podbišće |  1911 |
| Czesław Miłosz | Polonaise | Szetejnie | 1911 |
| Michel Heller | Russe | Moguilev | 1922 |
|Geoge Konrad | Hongrois| Berettyóújfalu | 1933 |
| Ivan Szelenyi | Hongrois | Budapest | 1938 |




**Table 3 : maisons d’édition**  

| Nom | Date de fondation | 
| :-------------------- | :-------------------- | 
| Le Seuil  | 1930 | 
| L'âge de l’homme | 1955 |
| Praeger |  1950 |
| Instytut Literacki | 1946 | 
| Calmann-Lévy | 1920 | 
| Harvester Press | ? |

 
Nous avons maintenant les informations de notre recherche en trois tables : chacun d’entre eux représente un jeu de données à part, qui peut être conservé et utilisé de manière indépendante. Afin de pouvoir naviguer entre elles en suivant les relations que nous avons établies dans le modèle, on doit maintenant les **relier**. Mais tout d’abord, pour ce faire, il faut succinctement mentionner une question que nous n’adresserons pas en profondeur dans le cadre de cette leçon, mais qui doit être rapidement discutée : celle de la [*cardinalité*](https://fr.wikipedia.org/wiki/Cardinalit%C3%A9_(programmation)).  

Quand on a à avoir avec une base de données relationnelle, on doit toujours s’interroger sur la nature des relations qui existent entre les tables : est-ce que chaque élément d’une table se rapporte exclusivement à un élément individuel d’un autre tableau ou est-ce que les relations sont multiples et croisées ? Par exemple, si l’on réfléchit aux relations entre auteurs et ouvrages : est-ce que chaque ouvrage peut avoir seulement un auteur (cardinalité 1 :1) ? Ou est-ce que chaque ouvrage peut avoir deux auteurs ou plus, comme dans le cas de *The Intellectuals on the Road to Class Power* (cardinalité 1 : N) ? Ou est-ce que chaque ouvrage peut avoir deux auteurs ou plus et aussi chaque auteur peut être liée á deux ouvrages ou plus (cardinalité N :N) ? Ce sont des questions que l’on ne peut pas adresser en détail dans le cadre de cette leçon, mais qui se poseront certainement au moment de constituer notre base de données.[^4]


## Construire et gérer ses bases de données avec *nodegoat*
 

La constitution d’une base de données relationnelle se fait souvent sur une application comme Excel qui permet de connecter des tableurs multiples, à l’aide d’un logiciel spécialisé comme Microsoft Access ou en faisant appel à des systèmes de gestion de base de données et des langages de requête comme SQL. Dans ce tutoriel, nous allons pourtant nous servir du logiciel en ligne *nodegoat* qui est spécifiquement conçu pour faciliter ce processus pour les chercheur(e)s en sciences humaines.
 


[*nodegoat*](https://nodegoat.net/) est un logiciel en ligne qui permet aux chercheur(e)s de construire leurs bases de données à partir de leur propre modèle de données et conserver ces données en ligne. Il est aussi possible de faire des exports de ces données, notamment en format CSV (format répandu et courant dans la gestion de données, représentant des données tabulaires) et en format de texte, ce qui donne ainsi aux chercheur(e)s la possibilité de faire des sauvegardes locales régulièrement.


L’approche du logiciel correspond à ce que l’on a proposé ici pour conceptualiser notre recherche : l’idée centrale est que les personnes, les groupes et les choses peuvent tous être traités comme des « objets » connectés par des relations diverses.[^5] *nodegoat* offre aussi des outils d’analyse relationnelle et des formes de visualisation géographique et de réseaux. En plus, il permet de consigner certaines informations en respectant l’incertitude et l'ambiguïté qui caractérisent la recherche en sciences humaines, par exemple en proposant des intervalles de temps quand on ne dispose pas de dates exactes pour un phénomène ou en permettant de marquer des polygones quand on ne dispose pas de coordonnées géographiques exactes. En combinant tous ces outils dans un même environnement, *nodegoat* facilite considérablement la tâche de concevoir sa recherche en données aux chercheurs moins expérimentés. Dans le cadre de cette leçon, nous nous servons de *nodegoat* dans sa version 7.3.
 
L’objet de cette leçon n’est pas l’utilisation de *nodegoat* per se. Il faut néanmoins rappeler que pour les usagers individuels, l’équipe de *nodegoat* offre un compte gratuit pour héberger leurs données en ligne.
 
Sur *nodegoat* , nous devons d’abord définir notre modèle de données et construire notre base de données. Au début, nous nous retrouvons face à notre *domaine* (espace de travail) vide où l’on trouve trois onglets : **Data** (données), **Management** (gestion) et **Model** (modèle). 


{% include figure.html filename="nodegoat-03.png" caption="Figure 3: Le domaine de nodegoat encore vide." %} 

Dans **Model**, nous construisons notre modèle de données selon la logique que nous avons expliquée dans la section précédente. Dans **Management**, nous définissons les paramètres pour mettre en œuvre ce modèle. Enfin, dans **Data**, nous consignons nos données dans la structure définie selon le modèle et nous examinons ces données.
 
Le point de départ sera donc la définition du modèle. C’est peut-être la qualité principale de *nodegoat* pour cette leçon, car c’est à travers cet outil que nous pourrons exécuter le modèle que nous avons décrit de manière abstraite auparavant. Le logiciel nous propose de commencer par ajouter un type d’objet : un Type (pour nous, un objet, comme l’ouvrage, l’auteur ou la maison d’édition). 


{% include figure.html filename="nodegoat-04.png" caption="Figure 4: Le volet Model et l'option qui nous permet de commencer à définir notre modèle de données." %} 


Nous devons donc définir le premier objet de notre recherche hypothétique, l’*ouvrage*. En appuyant sur __Add Object Type__, nous devons définir ce qu’est un *ouvrage*. Nous devons nécessairement établir un nom (ici, Name) et un ensemble d’attributs (ici appelées Descriptions). Pour chacun de ses attributs, nous devons définir de quel type de donnée s’agit : chaine de caractères, nombre entier, date ou autre. 

{% include figure.html filename="nodegoat-05.png" caption="Figure 5: Définition d'un premier objet pour notre modèle de données, à travers l'option Add Object Type." %} 

Ensuite, après avoir défini ce qu’est un *ouvrage*, nous devons faire la même chose avec les deux autres objets de notre modèle, à savoir l’*auteur* et la *maison d’édition*. Tout comme dans le cas de l’ouvrage, nous les définissons en tant qu’objets par leur nom et par l’ensemble de leurs attributs.

Ensuite, dans Management (gestion), il faut choisir quels sont les Types (objets) que nous allons utiliser dans ce projet (si nous avons introduit plusieurs objets dans notre base de données, nous pouvons décider de les explorer de manières différentes selon le type de projet ou au long du même projet). Nous faisons cela en appuyant sur l’option Edit de notre projet :

{% include figure.html filename="nodegoat-06.png" caption="Figure 6: Volet Managament nous permettant de gérer le projet et de choisir quels objets seront utilisés." %} 

Aussi, il faut prendre en compte ici qu’au-delà des objets crées par chaque utilisateur dans sa base de données, *nodegoat* vient par défaut avec deux Types (objets) préétablis: City (« ville ») et Geometry (« géométrie », qui fait référence à des régions, des pays ou d’autres unités politiques du passé et du présent). Les informations sur ces deux objets, comme par exemple leurs périmètres et leurs coordonnées géographiques, viennent prédéfinies sur nodegoat par le biais de certaines bases de données géographiques comme Geonames auxquelles *nodegoat* est lié). Il s’agit ainsi de deux objets très utiles et prêts pour l’emploi, dont chaque utilisateur peut se servir dans le cadre de sa recherche. Dans le cadre de ce projet, nous décidons de nous servir du Type City qui contient des informations utiles sur les villes. Autrement dit : nous allons structurer nos données sous le prisme des relations entre ouvrages, auteur, maisons d’éditions et aussi villes. Cela rendra notre modèle de donnés encore plus complexe, parce qu’il compte maintenant quatre objets (au lieu de trois, comme au début).

En principe, nous serions en conditions d’aller d’ores et déjà dans l’onglet Data et commencer ainsi à remplir les informations sur nos ouvrages, nos auteurs et nos maisons d’éditions. Mais il nous reste encore une partie fondamentale : établir les relations entre ces objets. Jusque-là, nous avons défini les informations de chaque Type en remplissant les cases. Mais l’essentiel de la base de données relationnelle est précisément la possibilité de relier ces objets.

Pour cela, après avoir établi les Types dans Model (modèle) et les avoir activés dans Management (gestion), il faut revenir sur Model et éditer chaque Type de nouveau. Comme tous nos objet sont définis, nous pouvons maintenant *les connecter les uns aux autres à travers les attributs qui, selon notre modèle de données, fonctionnent comme connecteurs*. Nous devons donc éditer le Type *ouvrage* et dans les cases Auteur et Maison d’édition nous activons comme source de ces informations l'option « Reference: Object Type ». Cela veut dire que cette information vient directement d’un autre Type. Après, nous choisissons respectivement Auteur et Maison d’édition. L’essentiel : **maintenant le Type *ouvrage* est, tout comme dans notre modèle, relié au Type *auteur* et au Type *maison d’édition* à travers ses attributs « Auteur » et « Maison d’édition ».** 


{% include figure.html filename="nodegoat-07.png" caption="Figure 7: Action pour connecter les objets à travers leurs attributs, à travers l'option Reference: Object Type." %}

Aussi, un rappel : nous devons ici cocher la case *multiple* pour « Auteur », afin d’indiquer que certains ouvrages peuvent avoir plus d’un auteur, comme dans le cas de *The Intellectuals on the Road to Class Power*. Cela revient à indiquer ce que nous avons défini auparavant comme une cardinalité de relation 1 : N. Nous devons aussi établir le symbole que *nodegoat* utilisera comme séparateur des données quand on à faire avec des auteurs multiples dans une même case. Les séparateurs les plus fréquemment utilisés sont `,` ou `;` ou encore `|`, mais attention : votre choix dépend aussi de quel sera le séparateur de vos données en format tabulaire au moment de l’export du CSV, car si le séparateur est le même, cela risque de dérégler la structure des données au moment de l’export.


Enfin, une dernière question concernant la définition de nos objets et de leurs structures : celle de l’incertitude de l’information. L’exemple de l’ouvrage *The Intellectuals on the Road to Class Power* pose bien cette question, car nous n’avons pas la date exacte de fondation de la maison d’édition Harvester Press ! Comment faire dans un cas comme celui-ci ? Si nous savons par exemple que leurs publications commencent à partir des années 1970, nous pouvons sans doute supposer que leurs origines doivent se trouver quelque part entre l’année 1970 et l’année 1979 qui est celle de la parution de notre ouvrage. Pour ce type de cas, quand nous avons des pistes mais pas d’information exacte, *nodegoat* permet de consigner une information temporaire en forme d’intervalle de temps (ce que l’on appelle Chronology). 

Pour cela, nous revenons sur l’onglet Model afin d’examiner le Type « Maison d’édition ». En toute probabilité, au moment de définir la date de fondation de la maison d’édition, nous l’avons fait de la même manière que la date de naissance d’un auteur : à l’intérieur de l’onglet *objects*, sur la liste des « Descriptions » et choissisant le type de donnée « date ».

{% include figure.html filename="nodegoat-08.png" caption="Figure 8: Attribut « Date de fondation » comme Description." %}

Néanmoins, cette possibilité nous permet uniquement d’établir une date exacte et cela ne convient à pas nos données sur les maisons d’édition. Afin de pouvoir consigner une date en forme d’intervalle de temps, nous devons en revanche nous servir de l’onglet « sub-object ». Ici, il faut créer un sub-object appelé « Date de fondation » et cocher l’option « Chronology ».

{% include figure.html filename="nodegoat-09.png" caption="Figure 9: Création d’un sub-objet Chronology pour le Type « Maisons d’édition »." %}

Désormais, le Type « Maison d’édition » comporte un attribut différent de celui de « Auteur », qui permet d’introduire des informations temporelles comme un intervalle de temps. 

Maintenant, notre modèle étant déjà défini avec ses objets et ses relations, nous pouvons revenir sur Management (gestion) pour le visualiser. Si nous cliquons sur le nom de notre projet, *nodegoat* nous donne une visualisation du modèle :

{% include figure.html filename="nodegoat-10.png" caption="Figure 10: Visualisation de notre modèle de données sur nodegoat." %}

Et maintenant, si nous allons sur l'onglet Data (données), nous pouvons avec toute liberté introduire les informations sur chacun de nos cas dans la base de données au fur et à mesure que notre recherche avance. Cela se fait avec l’option Add (ajouter) sur l’onglet respectif pour chacun de nos objets. Ensuite, en ce qui concerne les « Maison d’édition », nous verrons que l’attribut « Date de fondation » ne s’affiche pas comme un attribut comme les autres, mais comme un élément de Sub-objects dans lequel la date est définie comme une chronologie. L'éditeur nous permet ici de fournir nos informations sur la chronologie avec trois options : s’il s’agit d’un date exacte, nous pourrons l’indiquer comme un « Point » ; s’il s’agit d’une période après ou avant une certaine année, mois ou jour, nous l’indiquerons comme une « déclaration » (en anglais, un Statement) ; enfin, s’il s’agit d’une période *comprise entre deux dates* (comme dans notre cas, entre 1970 et 1979), nous l’indiquons comme « entre déclarations ».

{% include figure.html filename="nodegoat-11.png" caption="Figure 11: création d’une chronologie." %}

{% include figure.html filename="nodegoat-12.png" caption="Figure 12: exemple de chronologie définie comme période « entre déclarations »." %}

Enfin, après avoir rempli les informations sur vos ouvrages, auteurs et maisons d’éditions, la base de données prendra une forme comme celle-là. Nous pourrons alors cliquer sur chaque élément afin de retrouver ses informations :

{% include figure.html filename="nodegoat-13.png" caption="Figure 13: Aperçu de notre base de données." %}


Enfin, avec notre base de données constituée, nous pouvons aussi utiliser les outils que le logiciel nous propose pour visualiser ces objets et ses relations. Voici par exemple une visualisation des lieux de naissance des auteurs (en bleu) sur la carte de *nodegoat* :

{% include figure.html filename="nodegoat-14.png" caption="Figure 14: Visualisation géographique des villes de naissance de nos auteurs sur nodegoat." %}

Somme toute, *nodegoat* nous permet de constituer une base de données de manière relativement simple et en définissant nous-mêmes notre modèle de données. Aussi, le logiciel permet de conserver et de gérer ces données en ligne et il propose des possibilités multiples pour consigner les informations géographiques et temporelles avec des intervalles d’incertitude qui correspondent au type d’information que nous recueillons souvent dans le domaine des sciences humaines. Les outils de visualisation permettent d’apprécier l’évolution de notre recherche et d’identifier certaines tendances. Enfin, *nodegoat* nous donne aussi la possibilité d’exporter facilement nos données dans un document en format CSV pour exploiter ces données par d’autres utiles.

## Conclusion

Ce tutoriel a pour but d’encourager les chercheur(e)s en sciences humaines à concevoir leur recherche en termes de données et les familiariser avec des concepts souvent difficiles à saisir comme celui de *base de données*, *modèle de données* et *cardinalité*. Nous avons essayé ici de donner des éléments introductifs pour appliquer ces principes en se servant du logiciel en ligne *nodegoat* qui est particulièrement adapté aux besoin des chercheur(e)s débutant dans la gestion numérique des données. 

Il ne reste que de mentionner que *nodegoat* comporte aussi certaines limitations : outil exclusif et donc pas entièrement ouvert, il n’est pas toujours le choix le plus adéquat pour des projets financés par des fonds publics qui privilégient en revanche des outils d’accès ouvert. Dans ce sens, il faut aussi rappeler que l’accès gratuit à *nodegoat* est limité à un compte individuel avec une base de données, hébérgés sur le site du logiciel. Si l’objectif est de gérer plusieurs projets, d'avoir plusieurs comptes ou d'hébérger le projet sur un serveur propre, il devient donc nécessaire d'accéder à un plan supérieur, pour lequel il est souvent nécessaire d'avoir le soutien financier d’une institution de recherche ou d’enseignement.

Dans tous les cas, pour approfondir dans l’utilisation de*nodegoat* et explorer tout son potentiel, nous vous invitons à explorer les [Guides](https://nodegoat.net/guides) préparées par l’équipe de LAB1100, qui expliquent en détail le fonctionnement du logiciel.



[^1]: Posner, Miriam, (2015)., Humanities Data: A Necessary Contradiction, https://miriamposner.com/blog/humanities-data-a-necessary-contradiction/

[^2]: Bree, P. van, Kessels, G., (2013). nodegoat: a web-based data management, network analysis & visualisation environment, http://nodegoat.net from LAB1100, http://lab1100.com 

[^3]: Gardarin, Georges (2003), Bases de données, Paris : Eyrolles.

[^4]: Voir cette notice de Wikipédia pour plus d’éléments sur la notion de « cardinalité » : « Modèle relationnel », https://fr.wikipedia.org/wiki/Mod%C3%A8le_relationnel#Relation_1:N 

[^5]: Les créateurs de *nodegoat* décrivent l’approche relationnelle du logiciel comme « orienté-objet ». Ce concept étant le plus souvent utilisé pour décrire un paradigme de programmation informatique, nous préférons donc éviter l’emploi de ce terme afin d’éviter des confusions.

