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
avatar_alt: Squelette du Bouc d'Angora, dessin de Bouvée, 1755, Gallica
doi:
--- 

{% include toc.html %}

## Introduction : le défi conceptuel de penser en termes de données

 
Au moment de faire ses premiers pas dans le monde des humanités numériques, le chercheur ou la chercheuse en sciences humaines se confronte à plusieurs défis. Tout d’abord, les défis techniques&nbsp;: l’emploi des outils numériques n’est pas toujours évident et la maitrise d’une méthode, d’un logiciel ou encore plus d’un langage de programmation exige souvent une pratique longue et parfois ardue. Mais, aussi, un autre type de défi tout à fait différent mais également difficile&nbsp;: le besoin de réfléchir à sa recherche en termes de &laquo;&nbsp;données&nbsp;&raquo;. Mais, de quoi parle-t-on quand on parle de &laquo;&nbsp;données&nbsp;&raquo; ?
 
De manière générale, nous pouvons définir les [données](https://fr.wikipedia.org/wiki/Donn%C3%A9e_(informatique)) (en anglais, &laquo;&nbsp;data&nbsp;&raquo;) comme des informations structurées en unités discrètes et se prêtant au traitement automatique. Ces informations doivent être constituées de telle manière que, si quelqu'un d'autre les utilise et réalise sur elles les mêmes opérations que nous, il ou elle doit arriver au même résultat. 

Transformer une recherche en données implique un certain travail de traduction&nbsp;: il faut traduire nos informations depuis leur forme de base à une forme structurée. La donnée, contrairement à ce qu'on peut croire, n’est pas du tout &laquo;&nbsp;donnée&nbsp;&raquo;&nbsp;: elle n’est pas disponible dans la réalité, elle n'attend pas qu'on la cueille – elle est, au contraire, le produit d’un travail d’interprétation et de transformation. Afin de produire ses données, le chercheur ou la chercheuse doit lire ses sources en suivant une problématique définie, en extraire les informations pertinentes et les consigner de manière structurée. [^8]

Celles et ceux qui font de la recherche en sciences humaines recontrent souvent des problèmes à ce stade, car la notion même de &laquo;&nbsp;donnée&nbsp;&raquo; n'est pas limpide. En histoire, en anthropologie ou en littérature, nous pouvons réfléchir aux phénomènes que nous étudions en termes flexibles, ouverts et souvent incertains. Nous avons l'habitude de réfléchir à la subjectivité du chercheur et de donner une place centrale à la contingence. Nous savons analyser les phénomènes politiques, sociaux et culturels que en tant qu'objets complexes, difficiles à réduire à un &laquo;&nbsp;ensemble de données&nbsp;&raquo;. Comme le dit Miriam Posner [dans un billet de blog](https://miriamposner.com/blog/humanities-data-a-necessary-contradiction/) à ce sujet&nbsp; (traduction mienne):
 
>Nous, les chercheurs et chercheuses en sciences humaines, entretenons un rapport avec nos preuves tout à fait différent de celui qu'ont les autres scientifiques, même ceux des sciences sociales. Nous connaissons les choses d'une manière différente des chercheurs et chercheuses d'autres disciplines. Nous pouvons savoir que quelque chose est vrai sans être en mesure de présenter un ensemble de données, comme on l'entend traditionnellement.[^1] 
 
Ainsi, pour les chercheurs et chercheuses en sciences humaines, cela peut sembler contre-intuitif de lire leurs sources, leurs documents ou leurs notes ethnographiques pour en tirer des informations destinées à être insérées dans des catégories fixes, discrètes, structurées dans un tableur. Cela peut même sembler simpliste et superficiel&nbsp;: comment pourrait-on traduire en termes de &laquo;&nbsp;données&nbsp;&raquo; une tradition politique; la dimension affective d'une pratique culturelle locale; les enjeux conceptuels de la philosophie moderne, ou la psychologie d’un personnage littéraire ?

Pourtant, penser notre recherche en termes de données n'amène pas forcément à une simplification ou un aplatissement de notre objet d'étude, comme le montre la [nouvelle vague de travaux en histoire quantitative](https://www.cambridge.org/core/journals/annales-histoire-sciences-sociales/issue/F8D13390297D6B8FA490E5A240886184), qui semble faire un retour en force. Ces travaux nous montrent qu'il est possible d'adopter une démarche méthodologique qui fait appel aux données, tout en réservant une place à la complexité et à la subjectivité. Comme le rappelle Johanna Drucker, spécialiste en design graphique, les données receuillies ne sont jamais indépendentes de l'opération de recueil dont elles résultent&nbsp;: au contraire, un travail d'interprétation s'effectue toujours pour capter, saisir et découper ces données de la réalité. Autrement dit, &laquo;&nbsp;all data is capta&nbsp;&raquo; (toute donnée est captée).[^2]. 

Pour sa part, l'historien Manfred Thaller insiste sur le fait que les données peuvent représenter la réalité, mais sont insuffisantes si elles n'émanent pas d'un travail d'interprétation. Il propose un schéma hiérarchique qui distingue &laquo;&nbsp;données&nbsp;&raquo;, &laquo;&nbsp;information&nbsp;&raquo; et &laquo;&nbsp;savoir&nbsp;&raquo;. Les données sont des symboles qui peuvent être rangés dans un système de représentatation&nbsp;; il en résulte de l'information lorsqu'elles sont interprétées dans un contexte défini. Le savoir, lui, est le produit d'informations qui génèrent une prise de décision ou d'une action.[^3] 
 
En reconnaissant la complexité mais aussi la nature structurée des données, concevoir notre recherche en termes de données nous offre des avantages importants.

D'abord, enregistrer nos informations en forme de données nous permet de les traiter ensuite par des méthodes numériques automatiques, et de les prêter à des analyses quantitatives. Cela s’avère utile lorsque notre recherche nous demande de manipuler une grande quantité d’information, ou lorsqu'on peut directement prélever des séries de données depuis nos sources (inventaires, données démographiques etc.). 

De plus, le processus même de traduire nos informations en données exige que nous définissions de manière claire et nette les éléments de notre investigation, nos hypothèses et nos questions de recherche. Ceci nous apporte donc un avantage conceptuel. Autrement dit, on devient obligé de formaliser les objets de notre recherche, les relations qui les relient mutuellement, ainsi que la nature et les conséquences de leurs intéractions.

Enfin, enregistrer des informations dans une base de données nous permet de les partager facilement avec le reste de la communauté scientifique.
 
Dans cette leçon, nous discuterons des difficultés auxquelles on est susceptible de se confronter au moment de concevoir une base de données dans le cadre d'une recherche en sciences humaines, en tant débutant dans le domaine du numérique. Nous allons donc&nbsp;:
* [aborder les notions et les dispositifs techniques nécessaires pour concevoir un modèle de données](#entre-le-modèle-et-la-base-de-données) 
* [faire les premiers pas dans la construction d’une base de données en se servant de l’environnement en ligne *nodegoat*](#construire-une-base-de-données-avec-nodegoat)
 
Ainsi, nous espérons pouvoir faire comprendre les avantages d’une méthode de travail dont la logique n’est pas toujours évidente pour ceux et celles qui ont reçu une formation en sciences humaines.


## Entre le modèle et la base de données
 
Comme nous l'avons déjà mentionné, plus nous inspectons nos sources, plus notre recherche produit une quantité conséquente d’informations&nbsp;; dans ce cas, il est souvent préférable de consigner ces informations de manière organisée et structurée. Par exemple, imaginons que nous menions une recherche historique sur un ensemble de livres&nbsp;: un projet hypothétique portant sur les ouvrages produits par les écrivains dissidents des régimes communistes d’Europe de l’Est. 

Si nous le voulions, nous pourrions enregistrer des informations sur ces livres de manière intuitive, en utilisant les fonctionnalités offertes par un [tableur](https://fr.wikipedia.org/wiki/Tableur), comme ceci&nbsp;:

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


Ce tableau à trois colonnes constitue une première saisie qui nous permet de visualiser nos informations très simplement. Nous commençons à construire déjà, de manière plutôt élémentaire, ce qui pourrait ensuite devenir un [«&nbsp;jeu de données&nbsp;»](https://fr.wikipedia.org/wiki/Jeu_de_donn%C3%A9es) (en anglais, &laquo;&nbsp;dataset&nbsp;&raquo;). Chaque ligne dans le tableau représente un &laquo;&nbsp;cas&nbsp;&raquo;, ou &laquo;&nbsp;enregistrement&nbsp;&raquo;, et chaque colonne représente une &laquo;&nbsp;caractéristique&nbsp;&raquo;, ou &laquo;&nbsp;attribut&nbsp;&raquo; de ces cas&nbsp;. Ici, ce sont le titre, la ville d’édition et l’auteur de chaque ouvrage.
 
Pour l’instant, cet outil nous suffit car nous n'y conservons qu'une quantité peu conséquente d’information. Mais imaginons que, au fur et à mesure que nous approfondissons notre enquête, nous commençions à nous poser des questions additionelles à propos des ouvrages et des auteurs. Ainsi, nous multiplirions les informations enregistrées. Nous pourrions, par exemple, élargir le tableau comme suit&nbsp;:

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

Grâce à ce nouveau tableau, nous pouvons maintenant croiser des informations et ainsi approfondir l'analyse. Cela nous permettrait d'interroger les relations entre les caractéristiques des livres, celles des maisons d'édition et celles des auteurs. Nous pourrions, par exemple, formuler et vérifier l'hypothèse que les auteurs russes publient plus souvent en français, ou nous demander éventuellement si certaines maisons d'édition préfèrent les auteurs d'un certain âge, ou d'une certaine nationalité.

Cependant, plus nous multiplions les cas analysés et les questions posées, plus l’information se multiplie. Ce tableau devient alors bien moins pratique. Dans certains cas, l'information elle-même est compliquée. L’ouvrage *The Intellectuals on the Road to Class Power*, par exemple, a plus d’un auteur. La maison d’édition Harvester Press n'a pas de date de fondation (car les informations sur cette petite maison d’édition anglaise sont plutôt limitées) – un exemple classique de l’incertitude qui caractérise la recherche en sciences humaines. Il devient donc de plus en plus difficile de lire, croiser et interpréter toutes ces informations. 

Quand cela arrive, il est souvent plus utile de commencer à réfléchir aux &laquo;&nbsp;relations&nbsp;&raquo; qui relient les différents objets de notre recherche et de construire un tableau qui les représente - une [table de données](https://fr.wikipedia.org/wiki/Table_(base_de_donn%C3%A9es)) - avant de les rassembler dans une [base de données](https://fr.wikipedia.org/wiki/Base_de_donn%C3%A9es).
 
Qu’est-ce qu’une &laquo;&nbsp;base de données&nbsp;&raquo; ? De manière générale, il s’agit d’un contenant qui organise des informations selon une certaine structure. Plus spécifiquement, comme le dit Georges Gardarin, une base de données est &laquo;&nbsp;un ensemble de données modélisant les objets d’une partie du monde réel et servant de support à une application informatique&nbsp;&raquo;.[^5] Les données dans une base de données doivent pouvoir être &laquo;&nbsp;interrogeables&nbsp;&raquo;&nbsp;: nous devons pouvoir retrouver toutes les données qui satisfont un certain critère (dans notre exemple, tous les auteurs de nationalité russe ou tous les ouvrages parus en français). C’est cette interrogeabilité qui fait de la base de données un outil puissant d’exploration et d’analyse de nos informations.

Dans cette leçon, nous nous concentrerons sur un type particulier et assez fréquent de base de données&nbsp;: la [base de données relationnelle](https://fr.wikipedia.org/wiki/Mod%C3%A8le_relationnel#La_mod%C3%A9lisation_relationnelle_et_sa_transcription_en_base_de_donn%C3%A9es). On pourrait imaginer cette structure telle qu'un ensemble de tableaux, reliées de façon à ce que l’on puisse circuler de l'un à l'autre. La base de données contient notamment deux types d’éléments&nbsp;: les objets et les relations entre ces objets. Chaque objet représente une réalité complexe. Il comporte de nombreuses caractéristiques (ou les &laquo;&nbsp;attributs&nbsp;&raquo;, dans les colonnes) qui s’expriment dans des cas particuliers (les &laquo;&nbsp;enregistrements&&nbsp;&raquo;, sur les lignes). Avant de pouvoir construire cette base de données, nous devons donc d'abord définir les objets, les attributs qu'ils contiennent et la façon dont ils se relient les uns aux autres. Cela nous oblige à passer par ce que l’on appelle un [modèle de données](https://fr.wikipedia.org/wiki/Mod%C3%A8le_relationnel#Principe_du_mod%C3%A8le_relationnel).
 
Dans notre exemple, nous avons identifié trois objets qui nous intéressent&nbsp;: les ouvrages, les maisons d’édition et les auteurs. Comment sont-ils reliés&nbsp;? La réponse dépendra surtout de notre problématique de recherche. Dans le cas proposé ici, si notre attention porte sur &laquo;&nbsp;le livre en tant qu’objet de circulation&nbsp;&raquo;, nous pouvons par exemple imaginer un graphique élémentaire reliant ouvrage, auteur et maison d’édition&nbsp;:

 
{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-01.png" alt="Schéma logique constitué de trois cercles qui représentent ouvrage, maison d'édition et auteur. Deux flèches partent des ouvrages : une pointe vers les maisons d'éditions, et une autre vers les auteurs" caption="Figure 1. Schéma logique représentant les relations entre livres, maisons d'édition et auteurs." %}

Ce schéma correspond plus ou moins à un &laquo;&nbsp;modèle conceptuel de données&nbsp;&raquo; (Gardarin 2003, 17) qui représente les entités qui nous intéressent et les relations qui les relient. Ici, chaque ouvrage est ainsi lié à un certain auteur qui l'a écrit et à une certaine maison d’édition qui l'a publié.

Nous devons ensuite nous demander, comme nous l’avons déjà évoqué&nbsp;:
- quelle information contient chaque object ?
- de quels éléments est-il est composé ?
- comment exactement ces objets sont-ils reliés entre eux ?

Cela dépendra de leurs attributs respectifs. En suivant le tableau original de notre recherche hypothétique, nous pouvoons définir nos objets comme contenant les attributs suivants et comme étant connectés ainsi&nbsp;:
 
 
{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-02.png" alt="Modèle de données avec les trois objets, leurs attributs et les relations qui se tissent entre les objets à travers des attributs." caption="Figure 2. Modèle de données avec objets, attributs et relations." %} 

Ceci correspond maintenant à ce que l’on appelle généralement un &laquo;&nbsp;modèle logique de données&nbsp;&raquo;, qui nous permet de définir plus clairement nos objets et leurs relations et, ainsi, d'implémenter le modèle conceptuel. Sur la base de ce schéma, nous pouvons maintenant créer des tableaux pour enregistrer les charactéristiques de chaque objet séparément&nbsp;:

**Table 1: ouvrage**  

| Titre | Langue de la premiére édition | Date de parution | Maison d’édition | Auteur | 
| :------ | :--------- | :------ | :-------------------- | :---------|
| L’Archipel du Gulag | Français | 1973 | Le Seuil  | Alexandre  Soljenitsyne | 
| Vie et destin | Français | 1980 | L’age de l’homme | Vassili Grossman | 
| The New Class | Anglais | 1957 | Praeger |  Milovan Djilas | 
| The Captive Mind | Anglais | 1953 | Instytut Literacki | Czesław Miłosz | 
| La machine et les rouages | Français | 1985 | Calmann-Lévy | Michel Heller | 
| The Intellectuals on the Road to Class Power| Anglais | 1979 | Harvester Press |Geoge Konrad, Ivan Szelenyi |

**Table 2 : auteur**

| Prénom | Nom | Nationalité | Ville de naissance | Date de naissance |  
| :------ | :------ | :---------------- | :-------------------- | :--------------------- | 
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
 
Nous avons maintenant organisé ces informations en trois tableaux qui représentent notre jeu de données. Afin de pouvoir naviguer entre ces tableaux, en suivant les relations que nous avons établies dans le modèle, il faut maintenant les relier. Pour ce faire, on définit les possibilités et les restrictions qui se manifestent dans leurs relations - nous appelons cela la [cardinalité](https://fr.wikipedia.org/wiki/Cardinalit%C3%A9_(programmation))[^6].

Quand on construit une base de données relationnelle, on doit toujours s’interroger sur les relations qui existent entre les tableaux&nbsp;: chaque élément du tableau se rapporte-t-il exclusivement à un élément individuel d’un autre tableau, entretient-il des relations multiples et croisées ? Dans le cas exemple des relations entre auteurs et ouvrages : chaque ouvrage a-t-il seulement un auteur (cardinalité 1,1) ? Ou peut-il en avoir deux ou plus, comme *The Intellectuals on the Road to Class Power* (cardinalité 1,N) ? À l'inverse, chaque auteur d'un livre avec plusieurs auteurs ne pourrait-il pas être l'auteur de plusieurs ouvrages (cardinalité N,N) ? Ces questions se posent certainement au moment de constituer notre base de données[^4]. Les réponses dépenderont de notre jeu de données. Dans [la partie suivante](#créer-et-paramétrer-une-base-dans-nodegoat), nous verrons comment mettre tout ceci en pratique.

## Construire une base de données avec nodegoat
 
La constitution d’une base de données relationnelle se fait à l’aide de logiciels spécialisés, les [systèmes de gestion de base de données (SGBD)](https://fr.wikipedia.org/wiki/Syst%C3%A8me_de_gestion_de_base_de_donn%C3%A9es), qui permettent d'interroger et de manipuler les données selon les principes du langage de requête [SQL](https://fr.wikipedia.org/wiki/Structured_Query_Language). Il existe une multitude de SGBD, sous licence libre ou propriétaires (comme Microsoft Access). Il faut noter que ces logiciels peuvent vite devenir difficiles à manier. C'est pourquoi nous allons nous servir ici du logiciel en ligne [nodegoat](https://nodegoat.net/), spécifiquement conçu pour faciliter ce processus pour les chercheurs et chercheuses en sciences humaines. Comme nous allons le constater, il permet de concevoir un modèle de données de manière flexible; de gérer et conserver des données en ligne; d’introduire des informations historiques ayant un certain degré d’incertitude; d’exporter et importer ces données de manière simple et, enfin, de produire des visualisations telles que cartes ou réseaux.[^4]
 
### Démarrer avec nodegoat
nodegoat est un logiciel en ligne qui permet aux utilisateurs et aux utilisatrices de modéliser, de construire et de partager leur base de données, plus ou moins intuitivement. Les données sont hébergées en ligne, mais il est aussi possible de les exporter, notamment en format [CSV](https://fr.wikipedia.org/wiki/Comma-separated_values) (format répandu et courant dans la gestion de données, représentant des données tabulaires) et en format texte, ce qui permet de faire des sauvegardes locales régulièrement. nodegoat est un logiciel libre et il est aussi possible de [l’installer localement](https://github.com/nodegoat/nodegoat), mais cela exige néanmoins des compétences informatiques poussées. À défaut, les usagers individuels peuvent utiliser librement l’application en ligne pour un projet, moyennant l'ouverture d’un compte gratuit. Dans les deux cas (installation locale ou application en ligne), l’utilisation de fonctionnalités plus avancées, notamment pour travailler sur plusieurs projets ou de manière collaborative, requiert de souscrire à l'un des abonnements proposés par la société qui le développe. 

L’approche que prend le logiciel ressemble fortement à celle qu'on a décrite plus haut pour conceptualiser notre recherche&nbsp;: essentiellement, elle traite les personnes, les groupes et les choses comme des objets, connectés par des relations diverses.[^7] nodegoat offre aussi des outils d’analyse relationnelle et de production de visualisations telles que cartes ou réseaux. Surtout, le logiciel accepte de consigner des informations incertaines ou ambiguës, courantes en sciences humaines. Par exemple, il peut suggérer d'utiliser un intervalle de temps si on ne dispose pas de dates exactes, ou de dessiner polygone si on ne dispose pas de coordonnées géographiques exactes.

Certes, l’objet de cette leçon n’est pas l’utilisation de nodegoat &laquo;&nbsp;per se&nbsp;&raquo; - vous pouvez tout à fait utiliser [d'autres logiciels de gestion de bases de données spécifiquement conçus pour la recherche en sciences humaines et sociales](/fr/lecons/introduction-a-heurist). Malgré tout, en combinant tous ces outils dans un même environnement, nodegoat facilite considérablement l'exercice de concevoir sa recherche en données. Son avantage majeur pour nous, dans cette leçon, est qu’il facilite particulièrement la définition et l'exécution du modèle que nous avons décrit de façon abstraite ci-dessus. 

Cette leçon a été conçue en se servant de la version 7.3 de nodegoat, mais nous avons vérifié qu'elle marche tout aussi bien avec la version 8.2 (version en vigueur au moment de la publication de cette leçon). Notez bien que ni l’interface, ni la documentation du logiciel ne sont disponibles en français. Il faut par conséquent avoir une connaissance élémentaire de la langue anglaise afin d'utiliser nodegoat. Les instructions qui suivent visent à guider les lectrices et les lecteurs dans la création d'une base de données sur nodegoat, selon les principes expliqués [dans la première partie de la leçon](#la-logique-de-notre-recherche--entre-le-modèle-de-données-et-la-base-de-données). Pour mettre en pratique ces principes, il faut commencer par demander l'ouverture d'un compte pour utliser (gratuitement) nodegoat en ligne. Attention, nodegoat peut prendre jusqu'à 48 heures pour vous accorder votre compte.

### Créer et paramétrer une base dans nodegoat

En se connectant à nodegoat pour la première fois, nous nous trouvons face à notre **Domain** (espace de travail), vide pour l'instant, où l’on voit trois onglets&nbsp;: **Data** (données), **Management** (gestion) et **Model** (modèle). Dans **Model**, nous allons construire notre modèle de données selon la logique expliquée dans la section précédente. Dans **Management**, nous définirons les paramètres pour mettre en œuvre ce modèle. Enfin, dans **Data**, nous consignerons nos données selon la structure définie par le modèle, et nous examinerons ces données.

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-03.png" alt="Fonds vide avec les trois onglets" caption="Figure 3. Le domaine de nodegoat encore vide." %} 

Nous allons d’abord créer notre projet, puis définir notre modèle de données et construire notre base. En cliquant sur l'onglet **Management**, créons notre projet (via _Add project_) et attribuons-lui un titre en utilisant la barre qui s'affiche (**Name**)&nbsp;: &laquo;&nbsp;Ouvrages de l'Est&nbsp;&raquo;. 

Nous allons ensuite naviguer vers l'onglet **Model** afin de définir notre modèle de données. Commençons par ajouter un &laquo;&nbsp;type&nbsp;&raquo; d’objet. Dans notre modèle, nous avons déjà défini nos trois types &nbsp;: l’ouvrage, l’auteur, et la maison d’édition. 

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-04.png" alt="Le volet Model et l'option Add Object Type qui nous permet de commencer à définir notre modèle de données" caption="Figure 4. Le volet Model et l'option qui nous permet de commencer à définir notre modèle de données." %} 

Commençons donc par cliquer sur _Add Object Type_ pour créer le premier objet de notre jeu de données, l’ouvrage. Sous **Name**, nous pouvons établir le nom de l'objet et, sous **Descriptions**, définir ses attributs. Par exemple, le titre, la date de parution ou la langue de la première édition. Pour chacun de ses attributs, il faut bien préciser le type de valeur dont il s’agit&nbsp;: &laquo;&nbsp;string&nbsp;&raquo; (chaine de caractères) pour les valeurs textuelles comme le titre de l'ouvrage, &laquo;&nbsp;Date&nbsp;&raquo; pour des formats spécifiques comme la date de parution d'un ouvrage, ou [&laquo;&nbsp;autre&nbsp;&raquo;](https://nodegoat.net/documentation.s/116/objects#descriptions) en fonction de la nature du jeu de données.

Ici, attention&nbsp;: étant donné que nous incluons le titre de l'ouvrage comme attribut dans **Descriptions**, il faut désactiver l'option **Fixed Field** (qui fixe la définition de **Name**) et choisir à la place l'option **Name** sous notre premier attribut `Titre`;. Le nom de l'objet dans la base de donnée prendra alors la valeur donnée à l'attribut `Titre`.

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-05.png" alt="Le volet Ouvrages et les cases de trois attributs (titres, langue, date de parution)" caption="Figure 5. Définition d'un premier objet pour notre modèle de données à travers l'option Add Object Type." %} 

Ensuite, à l'exemple de l'*ouvrage*, nous devons créer les deux autres objets de notre modèle, à savoir l’*auteur* et la *maison d’édition*. Tout comme dans le cas de l’ouvrage, nous les définissons en tant qu’objets par leur nom et par l’ensemble de leurs attributs selon le modèle logique établi auparavant. Ici aussi nous désactivons l'option Fixed Field pour le nom et nous choisissons quelle valeur s'affichera comme nom de l'élément. Pour l'auteur, nous faisons le choix de cocher l'option Name dans deux attributs, Prénom et Nom. Ainsi, sur l'aperçu de notre base de données, le nom de chaque auteur sera la combinaison de ceux deux valeurs. Par contre, pour l'ouvrage, nous cliquons exclusivement sur Titre. Ensuite, si nous le souhaitons, afin d'éviter que l'aperçu de la base de données affiche le titre de l'ouvrage deux fois (en tant que nom de l'objet et en tant qu'attribut Titre, qui sont en fin de compte pareils), nous pouvons désactiver sur le champ Name l'option Overview, ayant comme conséquence que l'objet n'aura pas de nom sur l'aperçu de notre base&nbsp;: il y aura uniquement l'attribut Titre.

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-06.png" alt="Les cases des attributs Prénom et Nom, avec l'option Name activée." caption="Figure 6. Choix des attributs Prénom et Nom comme valeurs bases du nom de l'objet." %} 

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-07.png" alt="L'option in Overview desactivée" caption="Figure 7. L'option in Overview desactivée, ayant comme conséquence que sur l'aperçu de nos ouvrages, il n'y aura que l'attribut 'Titre' comme indication du  nom de l'objet." %} 

Ensuite, nous retournons dans l'onglet **Management** (gestion), où il faut choisir quels sont les Types (objets) que nous allons utiliser dans ce projet-ci. Nous faisons cela parce qu’il est tout à fait possible d'introduire plusieurs objets dans notre base de données, mais de décider de les explorer de manières différentes selon le type de projet ou au long du même projet. Par ailleurs, comme nous le verrons par la suite, nodegoat offre certains objets embarqués que nous pouvons, ou pas, utiliser. Pour définir donc les objets que nous souhaitons effectivement mobiliser dans notre projet, nous cliquons sur l’option Edit qui s'affiche à droite du nom de notre projet une fois que nous y avons accédé depuis Management&#x202F;:  

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-08.png" alt="Le volet Management, avec les objets que nous avons créés" caption="Figure 8. Volet Management permettant de gérer le projet et de choisir quels objets seront utilisés." %} 

Aussi, il faut prendre en compte ici qu’au-delà des objets créés par chaque utilisateur dans sa base de données, *nodegoat* vient par défaut avec deux objets (Types) préétablis: City (&laquo;&#x202F;ville&#x202F;&raquo;) et Geometry (&laquo;&#x202F;géométrie&#x202F;&raquo;), qui fait référence à des régions, des pays ou d’autres unités politiques du passé et du présent. Les données géospatiales attachées à ces deux objets (périmètres, coordonnées géographiques etc) proviennent de certaines bases de données géographiques comme [GeoNames](https://www.geonames.org/) qui sont reliées à *nodegoat*. Il s’agit ainsi de deux objets très utiles et prêts à l’emploi, dont chaque utilisateur et utilisatrice peuvent se servir dans le cadre de leur recherche et, inversement, contribuer à les enrichir. Dans le cadre de notre projet, nous décidons de nous servir de l'objet City qui contient des informations utiles sur les villes. En réalité, le logiciel vient de nous aider d'améliorer notre modèle de données, qui compte maintenant quatre objets au lieu de trois, comme au début (ouvrage, auteur, maison d’édition, ville). Nous profitons d'ailleurs de la disponibilité d'attributs que nous n'avions pas pensé à comprendre dans notre modèle d'origine (par exemple, le pays auquel appartient une ville) ou dont nous n'aurions pas pu disposer autrement (ou alors très difficilement&#x202F;!).    

Nous avons maintenant hâte d’aller dans l’onglet **Data** pour commencer à alimenter notre base avec des données sur nos ouvrages, nos auteurs et nos maisons d’éditions&nbsp;! Mais il nous reste encore une étape fondamentale à réaliser&#x202F;: établir les relations entre ces objets. Car jusque-là, nous avons seulement fourni les informations pour chaque Type individuellement en remplissant les cases. Mais l’essentiel de la base de données relationnelle est précisément la possibilité de relier ces objets.

Pour rappel, nous avons établi notre modèle en créant d'abord les objets (Model), que nous avons par la suite activés dans notre projet dans l'onglet **Management** (gestion). À présent, il faut revenir dans l'onglet du modèle (Model) pour intervenir sur chaque objet (Type) de nouveau. Comme tous nos objets sont définis, nous pouvons maintenant les connecter les uns aux autres à travers les attributs qui, selon notre modèle de données, fonctionnent comme connecteurs. Allons donc sur l'objet (Type) Ouvrage. Via le bouton Edit, nous accédons à l'onglet Object Types et à partir de là aux attributs (Descriptions). De ceux-là, deux nous intéressent tout particulièrement: Auteur et Maison d’édition. Le premier de ces deux attributs (Auteur) relie notre objet "Ouvrage" avec l'objet "Auteur"&nbsp;; le second relie l'objet "Ouvrage" avec l'objet "Maison d'édition". Pour chacun, nous activons dans le menu déroulant à droite l’option «&nbsp;Reference: Object Type&nbsp;». Ce faisant, un autre menu déroulant apparait à côté qui affiche la liste des objets de notre modèle&nbsp;; nous choisissons respectivement Auteur et Maison d’édition. Cela veut dire que nous avons référencé ces objets comme source des informations qui vont être intégrées dans notre objet "Ouvrage". L’essentiel étant que, maintenant, l'objet "Ouvrage" est, tout comme dans notre modèle, effectivement relié à l'objet "Auteur" et à l'objet "Maison d’édition" à travers ses attributs «&nbsp;Auteur&nbsp;» et «&nbsp;Maison d’édition&nbsp;». Nous avons ainsi réalisé dans les faits les liens que nous avions définis de manière abstraite dans notre modèle.


{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-09.png" alt="Case de l'attribut 'Auteur' avec l'option Reference: Object Type et avec un séparateur" caption="Figure 9. Action pour connecter les objets à travers de certains attributs via l'option Reference: Object Type." %}

Aussi, nous devons ici cocher la case *multiple* pour «&nbsp;Auteur&nbsp;», afin d’indiquer que certains ouvrages peuvent avoir plus d’un auteur, comme dans le cas de *The Intellectuals on the Road to Class Power*. Par ailleurs, nous devons aussi sélectionner le symbole que *nodegoat* utilisera comme séparateur des données lorsqu’il existe des auteurs multiples dans une même case. Les séparateurs les plus fréquemment utilisés sont `,` ou `;` ou encore `|`, mais attention&nbsp;: votre choix dépend aussi de quel sera le séparateur de vos données en format tabulaire au moment de l’export du CSV, car si le séparateur est le même, cela risque de dérégler la structure des données au moment de l’export.


Enfin, une dernière question qui peut se poser lors de la définition de nos objets et de leurs structures est celle de l’incertitude de l’information historique. L’exemple de l’ouvrage *The Intellectuals on the Road to Class Power* illustre bien ce cas, car nous n’avons pas la date exacte de fondation de la maison d’édition Harvester Press&nbsp;! Comment faire dans un cas comme celui-ci&nbsp;? Si notre recherche indique que les publications de cet éditeur commencent à partir des années 1970, nous pouvons formuler l'hypothèse que ses débuts d'activité doivent se trouver quelque part entre l’année 1970 et l’année 1979 qui est celle de la parution de notre ouvrage. Pour ce type de cas, quand nous avons des pistes mais pas d’information exacte, *nodegoat* permet de consigner une information temporaire en forme d’intervalle de temps (ce que l’on appelle Chronology). 

Pour cela, nous revenons sur l’onglet **Model** afin d’examiner le Type «&nbsp;Maison d’édition&nbsp;». En toute probabilité, lorsque nous avions défini la date de fondation comme l’un des attributs de la maison d’édition, nous l’avons fait de la même manière que la date de naissance d’un auteur&nbsp;: à l’intérieur de l’onglet **objects**, sur la liste des «&nbsp;Descriptions&nbsp;» et en choissisant le type de donnée «&nbsp;date&nbsp;».

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-10.png" alt="L'Attribut Date de fondation" caption="Figure 10. Attribut « Date de fondation » comme Description." %}

Néanmoins, cette possibilité nous permet uniquement de renseigner une date exacte et ce dans un format normalisé. Mais nous savons que cela ne convient pas à nos données sur les maisons d’édition, puisqu'il y a des dates que nous ignorons. Afin de pouvoir consigner une date en forme d’intervalle de temps, nous devons en revanche nous servir de l’onglet **sub-object**. Ici, il faut créer un sub-object appelé « Date de fondation » et cocher l’option **Chronology**.

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-11.png" alt="Sous-onglet avec l'objet Chronology" caption="Figure 11. Création d’un sous-objet Chronology pour le Type « Maisons d’édition »." %}

Désormais, le Type «&nbsp;Maison d’édition&nbsp;» comporte un attribut différent de celui de «&nbsp;Auteur&nbsp;», qui permet d’introduire des informations temporelles comme un intervalle de temps. 

Maintenant, notre modèle étant déjà défini avec ses objets et ses relations, nous pouvons revenir sur **Management** (gestion) pour le visualiser. Si nous cliquons sur le nom de notre projet, *nodegoat* nous donne une visualisation du modèle qui, comme vous le remarquerez, ressemble beaucoup à notre modèle original&nbsp;:

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-12.png" alt="modèle de données connectant quatre tableurs, respectivement Auteurs, Maisons d'édition, Ouvrages et Villes" caption="Figure 12. Visualisation de notre modèle de données sur nodegoat." %}

Et maintenant, si nous allons sur l'onglet **Data** (données), nous pouvons en toute liberté renseigner manuellement les champs que nous avons définis pour chacun des objets de notre base de données avec les valeurs que nous collectons au fur et à mesure que notre recherche avance. Cela se fait avec l’option Add (ajouter) sur l’onglet respectif pour chacun de nos objets. Ensuite, en ce qui concerne l'objet « Maison d’édition », nous verrons que l’attribut «&nbsp;Date de fondation&nbsp;» ne s’affiche pas comme un attribut comme les autres, mais comme un élément de Sub-objects dans lequel la date est définie comme une chronologie. L'éditeur nous permet ici de fournir nos informations sur la chronologie à l'aide de trois options&nbsp;: 1) une date exacte, nous pouvons l’indiquer comme un «&nbsp;Point&nbsp;» ; 2) une période après ou avant une certaine année, mois ou jour, nous l’indiquons comme une «&nbsp;déclaration&nbsp;» (en anglais, un Statement) ; 3) une période *comprise entre deux dates* (comme dans notre cas, entre 1970 et 1979), nous l’indiquons comme «&#x202F;entre déclarations&#x202F;».

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-13.png" alt="Onglet pour créer une chronologie" caption="Figure 13. Création d’une chronologie." %}

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-14.png" alt="Onglet avec deux cases pour dates, pour créer une période entre les deux" caption="Figure 14. Exemple de chronologie définie comme période « entre déclarations »." %}

Enfin, après avoir rempli les informations sur nos ouvrages, auteurs et maisons d’éditions, la base de données va ressembler à ce que vous pouvez voir sur les images ci-dessous. Il suffira alors de cliquer sur chaque élément afin de retrouver les informations le concernant&#x202F;:

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-15.png" alt="Table portant sur les ouvrages avec les informations en cinq colonnes" caption="Figure 15. Aperçu des ouvrages sur notre base de données." %}


{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-16.png" alt="Table portant sur les auteurs avec les informations en six colonnes" caption="Figure 16. Aperçu des auteurs sur notre base de données." %}


Nous pouvons aussi importer l'ensemble de nos données après la fin du dépouillement de nos sources, à l'aide de fichiers CSV, plutôt que les enregistrer manuellement au fur et à mesure. Indépendamment de l'option choisie, une fois notre base de données constituée et peuplée, nous pouvons aussi utiliser les outils que le logiciel nous propose pour explorer davantage nos objets et les relations qui les relient à l'aide de visualisations. Voici par exemple une visualisation des lieux de naissance des auteurs (en bleu) sur le fond de carte fourni par *nodegoat*&nbsp;:

{% include figure.html filename="fr-or-concevoir-recherche-donnees-nodegoat-17.png" alt="Carte d'Europe avec des points sur les villes de naissance des auteurs en Europe de l'Est" caption="Figure 17. Visualisation géographique des villes de naissance de nos auteurs sur nodegoat." %}

Somme toute, *nodegoat* nous permet de définir notre modèle de données et de constituer une base de données de manière relativement simple. Il propose en outre des possibilités multiples pour consigner les informations géographiques et temporelles avec des intervalles d’incertitude qui correspondent au type d’information que nous recueillons souvent dans le domaine des sciences humaines. Par ailleurs, les outils de visualisation permettent d’apprécier l’évolution de notre recherche et d’identifier certaines tendances. Enfin, cet environnement de recherche permet de stocker et de gérer nos données en ligne, tout en offrant la possibilité de les exporter pour les exploiter ces données à l'aide d’autres outils, mais aussi les sauvegarder.

## Conclusion

Ce tutoriel a pour but d’encourager les chercheurs et les chercheuses en sciences humaines à concevoir leur recherche en termes de données en les initiant par la pratique à des notions élémentaires de conception et de réalisation de bases de données, souvent difficiles à saisir pour les néophytes. Nous avons essayé ici de donner certains éléments introductifs en se servant du logiciel en ligne *nodegoat* qui est particulièrement adapté aux besoins de celles et ceux qui débutent dans la gestion numérique des données. 

Certes, *nodegoat* comporte aussi certaines limitations&nbsp;: l’accès individuel gratuit à *nodegoat* est limité à la réalisation d'un seul projet hébérgé sur le site du logiciel. Si l’objectif est de gérer plusieurs projets, d'avoir plusieurs comptes ou d'héberger le projet sur un serveur propre, il devient nécessaire d'accéder à un abonnement payant, pour lequel il est souvent nécessaire d'avoir le soutien financier et/ou technique d’une institution de recherche ou d’enseignement. 

Dans tous les cas, pour approfondir dans l’utilisation de*nodegoat* et explorer tout son potentiel, nous vous invitons à explorer les [Guides](https://nodegoat.net/guides) préparés par l’équipe de LAB1100, qui expliquent en détail le fonctionnement du logiciel. Sur le site de *nodegoat* vous pouvez aussi explorer [d'autres exemples de modèles de données proposés par les créateurs](https://nodegoat.net/blog.s/20/what-is-a-relational-database), ainsi que des exemples de recherches historiques mobilisant des bases de données. 


[^1]: Posner, Miriam, (2015), "Humanities Data: A Necessary Contradiction", *Miriam Posner's Blog* https://miriamposner.com/blog/humanities-data-a-necessary-contradiction/

[^2]: Drucker, Johanna (2011), "Humanities Approaches to Graphical Display", *Digital Humanities Quarterly* 5, n. 1.

[^3]: Thaller, Manfred (2018), "On Information in Historical Sources", *A Digital Ivory Tower*, https://ivorytower.hypotheses.org/56

[^4]: Bree, P. van, Kessels, G., (2013). nodegoat: a web-based data management, network analysis & visualisation environment, http://nodegoat.net from LAB1100, http://lab1100.com 

[^5]: Gardarin, Georges (2003), *Bases de données*, Paris : Eyrolles. Le livre est librement accessible depuis [le site web de l'auteur](http://georges.gardarin.free.fr/Livre_BD_Contenu/XX-TotalBD.pdf). 

[^6]: Voir cette notice de Wikipédia pour plus d’éléments sur la notion de « cardinalité » : « Modèle relationnel », [https://fr.wikipedia.org/wiki/Mod%C3%A8le_relationnel#Relation_1:N](https://fr.wikipedia.org/wiki/Mod%C3%A8le_relationnel#Relation_1:N). Voir aussi Gardarin, ouvrage cité, 412-413.

[^7]: Les créateurs de *nodegoat* décrivent l’approche relationnelle du logiciel comme « orienté-objet ». Ce concept étant le plus souvent utilisé pour décrire un paradigme de programmation informatique, nous préférons donc éviter l’emploi de ce terme afin d’éviter des confusions.

[^8]: Lemercier Claire et Claire Zalc, *Méthodes quantitatives pour l'historien*, Paris, Repères/La Découverte, 2008. DOI&#x202F;: https://doi.org/10.3917/dec.lemer.2008.01 

