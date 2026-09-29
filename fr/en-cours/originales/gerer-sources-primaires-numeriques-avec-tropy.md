---
title: Gérer des fichiers image de sources primaires avec Tropy
collection: lessons
layout: lesson
slug: gerer-sources-primaires-numeriques-avec-tropy
date: YYYY-MM-DD
authors:
- Sofia Papastamkou
reviewers:
- Forename Surname
- Forename Surname
editors:
- David Valentine
- Émilien Schultz 
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/712
difficulty: 1
activity: analyze
topics: [data-manipulation, data-management]
abstract: "Découvrir comment organiser et annoter des images numériques de sources primaires avec Tropy pour faciliter leur analyse scientifique."
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

Cette leçon montre comment organiser et annoter des images numériques de sources primaires à l'aide du logiciel Tropy en anticipant leur analyse à des fins de recherche scientifique. Elle ne nécessite pas de connaissance particulière de code informatique. La leçon peut être utile aux historiens et historiennes, mais aussi à quiconque souhaite disposer d'un système facile à prendre en main pour centraliser et faciliter la gestion de sources numériques dans le cadre d'une recherche en sciences humaines et sociales. 

## Présenter Tropy en un clin d'oeil

[Tropy](https://tropy.org/) est un logiciel qui permet de gérer les images numériques de [sources primaires](https://fr.wikipedia.org/wiki/Source_(information)#Source_primaire) tels les documents d'archives, les monuments, les &oelig;uvres d'art ou, au final, tout ce qui, dans un contexte de recherche précis, constitue une source dont on dispose sous forme d'image numérique. Il s'agit d'un logiciel à code source ouvert et gratuit qui peut être librement téléchargé à partir de son [site web](https://tropy.org/) - ce que nous recommandons de faire à celles et ceux qui souhaitent exécuter cette leçon.

Le logiciel a été conçu et développé depuis 2016 au sein d'établissements d'enseignement supérieur et de recherche interdisciplinaires, tel le Centre pour l'histoire et les nouveaux médias [Roy Rosenzweig](https://rrchnm.org/tropy/) de l'université George Mason (Virginie, Etats-Unis) et le [Centre pour l'histoire contemporaine et digitale](https://www.uni.lu/c2dh-fr/) de l'université du Luxembourg. Tropy bénéficie en outre de l'appui de l'organisation à but non lucratif [Digital Scholar](https://digitalscholar.org/) qui promeut la production et diffusion de logiciels à code source ouvert à des fins d'usage académique.  

En ce qui concerne la documentation d'utilisation, un guide officiel est [disponible en anglais](https://docs.tropy.org/). De surcroît, un [forum Tropy](https://forums.tropy.org/) existe aussi pour les utilisatrices et les utilisateurs qui souhaitent aborder des questions spécifiques avec la communauté (notamment en anglais). Par ailleurs, Tropy dispose d'une [chaîne sur YouTube](https://www.youtube.com/channel/UCQ3QCuNGz825BGSHG9JryeA) proposant des vidéos éducatives notamment en anglais et en espagnol, mais pas en français à l'heure où cette leçon est publiée. Enfin, Tropy est présent sur les principaux réseaux sociaux en ligne – davantage d'informations sont disponibles sur son site web. 

Le lectorat francophone peut tirer profit de [la traduction de la documentation du logiciel par la Bibliothèque universitaire des langues et civilisations (BULAC)](https://www.bulac.fr/document/documentation-tropyfr-avril-2023), effectuée en 2023, mais également de divers tutoriels listés dans la [section afférente des références bibliographiques](#tutoriels-et-ressources-éducatives).   

## Pourquoi utiliser Tropy 

Tropy est une application assez unique en son genre qui permet d'organiser et d'annoter, à partir d'une seule interface, les fichiers image de sources primaires. Elle a été spécialement conçue pour répondre à l'évolution des pratiques de collecte et d'organisation des sources historiques à l'ère numérique et pour faciliter leur exploitation à des fins d'analyse. C'est ce que nous décrivent d'expérience un historien de l'intégration européenne [sur son blog](https://www.e-mourlon-druol.com/destructuration-et-restructuration-de-larchive-a-lere-numerique/) ou encore une historienne de la Première guerre mondiale [dans une bande dessinée](https://www.uni.lu/c2dh-fr/news/gazengel-ooooh-tropy/). 

Depuis les années 2000, la multiplication des bibliothèques et archives numériques a rendu accessibles — et souvent téléchargeables — des collections patrimoniales considérables. À cela s'ajoute la généralisation de la reproduction photographique lors des visites en archives (appareil photo numérique, smartphone), qui permet à chaque chercheur ou chercheuse de constituer sa propre archive hybride. Ces pratiques ne sont pas sans conséquences&nbsp;: si tout n'est pas numérisé — en France, les fonds déjà numérisés des archives nationales, départementales et régionales ne représentent qu'un pourcentage minime des collections conservées[^1] — les historiens et historiennes doivent néanmoins gérer des masses de fichiers croissantes. Déjà dans sa forme analogique, l'archive se prêtait à la métaphore du flux&nbsp;: &laquo;&nbsp;démesurée&nbsp;&raquo;, &laquo;&nbsp;envahissante comme les marées d'équinoxes, les avalanches ou les inondations&nbsp;&raquo;.[^2] L'archive numérique semble côtoyer le chaos&nbsp;:

> &laquo;&nbsp;[...] L'impératif de photographier le plus [de documents] possible amène à dissocier les objets de leur contexte, atomise les documents en les transformant en fragments et, tout en promettant l'abondance, débouche sur du chaos [...]. Il n'existe pas de solution technologique rapide [...] pour les chercheurs et chercheuses à la dérive devant une mer silencieuse de fichiers JPG&nbsp;&raquo;.[^3] *(Extrait librement traduit par l'auteure).*

Tropy vise à offrir une infrastructure logicielle légère pour répondre à ces défis. Elle permet d'abriter des fichiers en provenance de divers centres d'archives, de combiner différentes temporalités d'une recherche et de faire coexister des formats hétéroclites (PDF, JPEG, PNG, etc.). C'est ainsi que Tropy permet de (re)construire l'archive d'une recherche et d'effectuer les opérations suivantes&nbsp;:

* Rassembler des photos de sources primaires issues de centres d'archives, de collections numériques en ligne ou collectées par ses propres moyens
* Classer et organiser ces matériaux en séries cohérentes pour une recherche spécifique
* Contextualiser les sources en leur attribuant des métadonnées descriptives (date, série et sous-série du fonds d'archive, etc.)
* Annoter les sources, produire des transcriptions, prendre des notes et indexer le tout dans un environnement unifié
* Croiser facilement les sources lors de la rédaction, ce qui optimise le temps de travail
* Naviguer rapidement entre les différents sous-ensembles des sources

## Les données de la leçon

La leçon a été pensée dans le cadre d'une série de formations qui ciblaient des doctorant(e)s en histoire contemporaine pour tenir compte, d'une part, de la pluralité des sources et, d'autre part, des besoins réels d'organisation de sources fréquemment rencontrées dans le cadre d'une recherche en histoire. C'est pourquoi la leçon explore certaines les fonctionnalités du logiciel en mobilisant des données variées, tout en s'efforçant de maintenir la cohérence de la démonstration. 

### Les affiches du Printemps érable 

Le jeu de données principal consiste en un corpus de 352 affiches nativement numériques créées dans le cadre de la grève étudiante contre la hausse des frais de scolarité déclenchée au printemps 2012 au Québec, aussi appelée [Printemps érable](https://fr.wikipedia.org/wiki/Gr%C3%A8ve_%C3%A9tudiante_qu%C3%A9b%C3%A9coise_de_2012). Ces affiches sont librement accessibles via le site web [*Printemps érable archives*](https://www.printempserable.net/), qui sert ainsi d'archive non-institutionnelle et vivante de la production graphique du mouvement. 

[Lien pour accéder aux fichiers des affiches du Printemps érable déposés sur Zenodo](https://doi.org/10.5281/zenodo.13936156). Merci de télécharger ces fichiers avant de commencer la section suivante. 

### Les journaux de tranchées

Un journal de tranchées daté de février 1915, [le numéro 3 de *L'écho des marmites*](https://argonnaute.parisnanterre.fr/ark:/14707/9tks6j4d0bvf), sert à démontrer [comment représenter comme une seule entité, dans Tropy, un document avec plusieurs pages, où chaque page égale à un fichier image distinct](#fusionner-des-fichiers-images-en-un-seul-objet).  Les journaux que nous avons téléchargés pour l'exercice font partie d'une riche collection de journaux de tranchées numérisés conservés à la bibliothèque [La Contemporaine](http://www.lacontemporaine.fr/). 

[Lien pour accéder aux fichiers des journaux de tranchées numérisés](/assets/gerer-sources-primaires-numeriques-avec-tropy/journaux-tranchees-14-18). Merci de télécharger ces fichiers avant de commencer la section suivante. 
  

## Démarrer avec Tropy 

Cette section fournit les informations préalables à la création d'un projet Tropy. La leçon mobilise la version 1.16.2 du logiciel et a été réalisée sur Windows 11.

### Installer Tropy 

Tropy est un logiciel multi-plateformes (distributions Linux, Windows, macOS) dont l'installation se fait en local. Les projets sont stockés sur le disque dur des utilisateurs et non en ligne, ce qui exclut le travail collaboratif synchrone sur un serveur partagé. 

Le téléchargement est gratuit depuis le [site web](https://tropy.org/) de Tropy. L'installation est simple et il suffit de suivre les instructions.   

### Les éléments d'un projet dans Tropy 

Avant de commencer, il est important de comprendre les éléments de base qui structurent toute la logique de Tropy. Ces éléments sont les suivants&nbsp;: 
* projet
* objet 
* liste
* tag

Un projet Tropy consiste en un ensemble d'objets organisables en listes et classables à l'aide de tags.

Le projet est une collection de fichiers image correspondant à une recherche sur un sujet donné&nbsp;: une ébauche de publication, une thèse, un mémoire... C'est le premier point d'entrée dans Tropy, depuis lequel on accède aux sources pour les organiser et les annoter (transcription, prise de notes, indexation...).

L'objet représente une source comme entité&nbsp;: la photo d'un document d'archives, d'un monument, d'une œuvre d'art, d'une affiche... Un objet équivaut à un ou plusieurs fichiers image selon la nature de la source. Une affiche correspond ainsi le plus souvent à un seul fichier, tandis qu'un télégramme de plusieurs pages nécessite de [regrouper les photos de chaque page en un seul objet](#fusionner-des-fichiers-image-en-un-seul-objet).

Les listes permettent de classer les objets selon une caractéristique commune : thématique, chronologique, géographique, provenance...

Les tags sont des mots-clés librement définis qui décrivent les caractéristiques d'un objet, le plus souvent au niveau de son contenu, et permettent une indexation transversale des sources.

## Créer un projet

Cette section explique comment construire un premier projet pas à pas dans Tropy.

Lançons à présent Tropy - comme vous le verrez, nous avons aussitôt accès à une boîte de dialogue et aussi, en haut, au menu principal. La boîte de dialogue nous invite à créer un projet, d'abord en le nommant puis en sélectionnant son type&nbsp;: standard ou avancé - nous expliquons dans [la partie qui suit](#configurer-un-projet) de quoi il s'agit. Nous pouvons aussi créer notre projet à partir du menu principal&nbsp;: `Fichier` > `Nouveau` > `Projet`. Nous n'allons pas explorer davantage le menu à ce point, sauf si nous souhaitons [paramétrer la langue de l'interface](#paramétrer-la-langue). 

Une fois le type de projet choisi et la langue paramétrée, créons donc notre projet en lui attribuant le titre de notre préférence. Ensuite, nous pouvons [explorer l'interface de Tropy](#se-familiariser-avec-linterface-de-tropy) puis de se lancer dans [l'importation de nos photos](#importer-les-fichiers-image-de-ses-sources).  

{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-01.png" alt="Capture d'écran de boîte de dialogue pour créer un projet dans Tropy" caption="Figure 1. La boîte de dialogue pour créer un projet dans Tropy" %} 

### Configurer un projet standard ou avancé

Au moment de [créer un projet](#créer-un-projet), il faut préalablement définir s'il est de type standard ou avancé - l'option par défaut étant le projet standard. Il s'agit là d'[une fonctionnalité disponible à partir de la version 1.13 de Tropy](https://tropy.org/blog/new-project-types-in-tropy-1-13). Mais de quoi s'agit-il exactement&nbsp;? 

Un projet standard, au moment de l'importation des fichiers des images, crée aussitôt des copies de ces image pour les stocker dans un répertoire spécifique de Tropy. L'avantage dans ce cas est que le projet devient intégralement portable. Par exemple, en le copiant sur une clé USB et en l'important dans un autre environnement de travail que notre ordinateur habituel, nous pouvons le retrouver tel que nous l'avions laissé dans son environnement d'origine, et continuer à travailler dessus sans interruption. L'inconvénient d'un projet standard est cependant qu'il nécessite des machines performantes avec beaucoup de mémoire disponible, car les fichiers image sont des fichiers volumineux. 

En revanche, un projet avancé n'effectue pas de copies des images d'origine. Celles-ci ne sont donc pas stockées dans un répertoire intégré au projet, même si nous pouvons toujours les voir via l'interface de Tropy. Ici, comme il le faisait dans ses versions précédentes, Tropy établit des liens, que nous appelons des chemins, vers les répertoires que nous avons initialement choisi comme emplacement pour stocker nos fichiers. Par exemple, cet emplacement peut se trouver sur le disque dur de notre PC dans `Documents`. L'avantage des projets avancés est qu'ils sont légers, puisqu'ils ne contiennent que les données que nous ajoutons (structure de notre projet, notes, libellés, transcriptions...). En revanche, pour assurer la portabilité d'un projet avancé, il faudra veiller à l'accompagner, dans son nouvel environnement, des répertoires dans lesquels nous avons stocké nos images et d'intervenir pour rétablir les chemins cassés, le cas échéant. Si vous ne souhaitez pas mettre la main dessus ou ne savez pas trop comment s'y prendre, il vaut mieux sélectionner le mode standard, mais n'ayez pas peur de vous expérimenter plus tard.  

Pour suivre les étapes suivantes de la leçon, le choix de type de projet n'a pas vraiment d'incidence. En ce qui nous concerne, nous optons pour créer un projet avancé pour éviter d'avoir un projet lourd, mais, encore une fois, le choix vous appartient selon vos propres contraintes et préférences.

Admettons que nous avons créé notre projet, par défaut celui-ci est stocké dans le répertoire `Documents` et son extension est .TPY. Il est tout à fait possible de sauvegarder un projet Tropy à l'emplacement de notre préférence, que nous choisissons via la boîte de dialogue qui s'ouvre après avoir entré le nom de notre projet et appuyé sur le bouton `Create Project`. 
       
### Paramétrer la langue 

Tropy est disponible dans plusieurs langues dont le français. Pour paramétrer la langue à laquelle nous souhaitons rendre disponible l'interface, rendons-nous, à partir du menu principal, à `Édition` > `Préférences` > `Paramètres`. Une fois là, il est possible de sélectionner la langue de notre préférence à partir de la liste déroulante. Attention, la première fois que nous lançons Tropy le menu peut apparaître en anglais. Dans ce cas, suivre `Edit` > `Preferences` > `Settings` > `Locale` pour définir la langue de préférence.     

### Se familiariser avec l'interface de Tropy

Une fois notre projet créé et lancé, nous accédons à la zone d'affichage en mode projet qui permet d'effectuer les opérations globales le concernant. Pour travailler au plus près de nos sources, il existe aussi la zone d'affichage en mode objet, mais nous n'en sommes pas encore là&nbsp;! Restons pour le moment à la zone d'affichage en mode projet. Celle-ci offre accès au menu principal en haut à gauche. La zone latérale à gauche offre un accès unifié aux listes créées, aux dernières importations de fichiers effectuées, aux tags et aux objets supprimés. Il est maintenant temps d'importer nos sources pour pouvoir explorer davantage les fonctionnalités qui nous sont offertes&nbsp;!

{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-02.png" alt="Zone d'affichage en mode projet de Tropy après la création de projet et avant l'importation de fichiers" caption="Figure 2. Zone d'affichage en mode projet de Tropy" %} 

## Importer les fichiers image de ses sources

Les étapes ci-dessous requièrent d'avoir préalablement téléchargé [le jeu de données principal](#les-affiches-du-printemps-érable) et [le jeu de données supplémentaire](#les-journaux-de-tranchées) fourni avec la leçon.  

### Importer des fichiers image depuis un emplacement de stockage

Les formats de fichiers que Tropy peut prendre en charge sont les principaux formats qui peuvent abriter des images dont JPG/JPEG, PNG, SVG, TIFF, GIF, PDF. Il s'agit là de formats communément rencontrés dans le cadre de recherches historiques, mais pour consulter la liste complète, merci de se référer à la documentation de Tropy disponible sur son site web.  
 
Admettant que nous avons lancé Tropy, créé un projet et sommes à présent devant la zone d'affichage en mode projet, comme décrit dans la section précédente. Il est possible d'importer les fichiers image de deux façons&nbsp;:
* Soit les glisser, après avoir ouvert au préalable le répertoire d'origine, un par un ou en les sélectionnant tous, directement dans la zone du milieu du menu, réservée aux objets
* Soit utiliser le menu principal&nbsp;; pour ce faire, aller à 
	- `Fichier` > `Importer` > `Photos`, pour importer un ou plusieurs fichiers d’image depuis un répertoire
	- `Fichier` > `Importer` > `Dossier`, si vous souhaitez importer tout un répertoire de fichiers

{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-03.png" alt="Menu principal d'importation de fichiers" caption="Figure 3. Menu principal d'importation de fichiers dans un projet Tropy" %} 

Nous avons testé, via le menu principal, l'importation des fichiers du jeu de données des affiches du Printemps érable des deux manières ci-dessus évoquées&nbsp;: via `Photos`, en sélectionnant tous les fichiers à la fois, et via `Dossier`, qui nous semble plus pratique pour les répertoires volumineux. Les deux ont été aussi bien efficaces. Au passage, Tropy a la possibilité de repérer à ce stade des doublons dans le jeu de données qu'il est possible de ne pas importer (c'était le cas du jeu de données importé pour cette leçon). 

Depuis la zone du milieu, nous avons maintenant une vue d'ensemble des objets de notre projet. Un menu spécifique en haut permet de naviguer dans les objets à l'aide d'une barre de recherche à droite. Il est possible d'ajuster la vue en réglant le curseur, qui se trouve en haut à gauche, pour afficher les objets du projet en mode liste ou en mode vignettes, et ce en alternant les échelles, allant d'une vue de l'ensemble à la vue d'un seul objet. Par ailleurs, sélectionner un objet permet de faire afficher, dans le menu latéral à droite, des informations qui lui sont spécifiques&nbsp;: métadonnées de description, tags, le(s) fichier(s) de photo(s) qui se rapportent à cet objet. 

À ce stade il n'y a pas autre chose à afficher que le nom du fichier, puisque nous venons d'importer nos fichiers et n'avons pas encore procédé à [leur description plus détaillée (soit à la saisie des métadonnées)](#décrire-ses-sources). Nous allons voir cela dans un instant, mais il est important de retenir que, le mieux nous décrivons nos fichiers, le plus les fonctionnalités de Tropy deviennent efficaces.

{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-04.png" alt="Menu principal après dernière importation de fichiers" caption="Figure 4. Vue d'ensemble en mode vignettes de fichiers importés dans un projet Tropy" %}

### Importer des images depuis une page web

Il est possible d'importer des images statiques qui ont leur propre [URL](https://fr.wikipedia.org/wiki/Uniform_Resource_Locator) directement dans un projet Tropy. Pour ce faire, il suffit de glisser l'URL de l'image depuis le navigateur vers l'interface de Tropy (zone d'affichage en mode projet). 

Pour tenter la manipulation avec [la collection des affiches du Printemps érable](https://www.printempserable.net/portfolio-item/affiches1/), il faudra cliquer droit sur l'affiche de votre préférence pour ouvrir l'image dans un nouvel onglet et obtenir ainsi son URL. C'est ainsi que nous obtenons par exemple le lien pour l'image statique de [cette affiche-ci](https://www.printempserable.net/wp-content/uploads/DSCN0008.jpg).  

Attention, l'importation est différente selon que le type du projet soit standard ou avancé. Dans le premier cas, l'image est téléchargée au cours de l'opération et intégrée dans le projet. Dans le second cas, seulement un lien est créé vers l'adresse web de l'image, sans que celle-ci ne soit téléchargée. Il faut alors soit double-cliquer sur l'icône de l'objet créé dans notre interface pour accéder, via le web, à l'image d'origine&nbsp;; soit effectivement la télécharger de son emplacement d'origine pour ensuite l'importer dans le projet comme décrit dans la partie qui précède. 

Les opérations décrites ci-dessus ne sont pas possibles avec des images accessibles via des pages générées dynamiquement (en interrogeant par exemple une bibliothèque numérique en ligne). 
Pour des images en format PDF, [la leçon en espagnol sur Tropy](/es/lecciones/gestionar-fuentes-primarias-digitales-con-tropy) explique la démarche à suivre avec ce format, qui implique généralement de les télécharger pour ensuite pouvoir les intégrer dans un projet Tropy. 

Indépendamment de la manière dont nous avons importé nos photos, maintenant qu'elles sont bien là, promenons-nous à nouveau dans la zone d'affichage en mode projet. Cela nous permettra de régler l'affichage de nos photos dans la vue d'ensemble de la manière qui nous convienne le plus (en liste ou vignettes). Nous pouvons aussi à présent accéder à l'affichage en mode objet, en double cliquant sur l'un des objets, mais au stade où nous en sommes, cela n'est pas nécessaire. Nous pouvons néanmoins profiter, en cliquant droit sur une des photos importées, d'accéder à un menu supplémentaire permettant d'effectuer des opérations spécifiques aux objets. Au point où nous en sommes, nous pouvons, par exemple, [tourner à gauche ou à droite des images](#opérations-techniques), si cela est nécessaire. Attention, le click droit marche sur Windows&nbsp;; sur Mac ou une distribution Linux, il faut maintenir la touche `Ctrl` enfoncée tout en cliquant (gauche) sur l'objet.  


{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-05.png" alt="Menu objet accédé via click droit sur un objet" caption="Figure 5. Menu au niveau de l'objet accédé après click droit sur un objet (source) du projet" %}

## Décrire ses sources

Au moment d'importer les fichiers image des sources primaires dans un projet Tropy, il est judicieux de les décrire avec des informations qui sont communément appelées [métadonnées](https://doranum.fr/metadonnees-standards-formats/metadonnees-standards-formats-fiche-synthetique_10_13143_vbjs-6288/). Il s'agit des informations que les historiens et les historiennes ont l'habitude de retenir pour décrire, contextualiser et rappeler leurs sources dans leurs travaux&nbsp;: le titre d'un document, un nom d'auteur, une date de création... Dans un contexte documentaire, les métadonnées sont des informations qui décrivent d'autres données - dans notre cas les sources historiques - et qui deviennent signifiantes dans un système défini. C'est l'essentiel à retenir sur ce terme intimidant que nous allons apprivoiser par la pratique à l'aide du fomulaire spécifique de Tropy, accessible dans la partie droite de la zone d'affichage en mode projet, ou alors depuis la zone d'affichage en mode objet. 

L'opération de saisie systématique de ces informations descriptives relie la photo à la source et permet ensuite d'y accéder facilement et rapidement autant de fois que souhaité. Par ailleurs, elle est importante pour analyser correctement la source puisqu'elle facilite sa contextualisation et vérification. Enfin, l'opération de description des sources les rend citables dans un travail de recherche scientifique. En plus de ce type d'information, au final très classique, Tropy permet de saisir des informations importantes pour les environnements numériques (bases de données, sites web, dépôts de données...) dans lesquels les sources peuvent désormais circuler, y compris les droits d'utilisation ou encore des informations techniques sur les fichiers des images. 

Tropy fournit trois principaux modèles de saisie de métadonnées&nbsp;: générique (`Tropy Generic`), description de correspondance (`Tropy Correspondence`) et de type Dublin Core. Il est possible de les inspecter depuis le menu déroulant du formulaire au point où le titre du modèle est indiqué pour explorer davantage les champs à remplir. Les deux premiers modèles ci-dessus évoqués conviennent à la description de la plupart des sources historiques. Le troisième reproduit un format simple du [standard](https://youtu.be/S-Hw_04ojCc) de métadonnées [Dublin Core](https://fr.wikipedia.org/wiki/Dublin_Core), largement utilisé pour décrire des collections patrimoniales dans des bibliothèques et archives numériques. 

Il existe aussi deux modèles supplémentaires dont l'un est destiné à abriter les informations techniques embarquées des fichiers image (`Tropy Photo`) et l'autre à fournir les métadonnées des sélections qui peuvent être faites à partir d'un fichier image d'un projet, métadonnées qui sont hérités de l'objet dont la sélection émane. Il est rare d'avoir à intervenir sur ce type de modèles. 

Les deux sections qui suivent expliquent comment décrire les objets d'un projet [de manière groupée](#attribuer-des-métadonnées-par-lot), mais aussi [de manière isolée](#attribuer-des-métadonnées-par-objet) à l'aide du formulaire générique de Tropy, qui convient parfaitement au jeu de données utilisé. Nous expliquons aussi [comment tailler un formulaire sur mesure](#personnaliser-le-modèle-de-saisie-des-métadonnées) pour l'adapter aux besoins de ses sources, si nécessaire, dans une section spéciale de la leçon. Comme celle-ci mobilise des données davantage adaptées à cela, elle est placée à part pour éviter de perturber votre projet actuel.    

### Attribuer des métadonnées par lot

Il est possible de décrire chaque objet à l'unité, en se rendant à son formulaire de métadonnées depuis le menu d'objet. Cependant, si nos objets sont homogènes, par exemple lorsque nous importons un ensemble de photos de documents en provenance de la même archive, carton ou autre, ils peuvent partager un certain nombre de métadonnées communes. Dans ce cas, nous pouvons attribuer les métadonnées communes par lot, ce qui peut faire gagner du temps lorsque l'importation comprend un grand nombre de photos. Pour ensuite aller renseigner, au niveau d'objet, des métadonnées plus spécifiques à l'unité. En vérité, dans la plupart de cas, nous combinons l'attribution de métadonnées de manière globale au travail plus personnalisé pour bien décrire chaque objet. 

Une bonne pratique pour attribuer des métadonnées communes à un lot de photos est de se positionner au niveau de la dernière importation. Pour cela, il suffit d'aller placer son curseur sur `Dernière importation ` accessible depuis le menu latéral de la zone d'affichage en mode projet. Pourquoi faire cela&nbsp;? Au fil d'un projet, plusieurs importations de fichiers d'images peuvent se succéder de manière différée, selon la temporalité d'une recherche. Si des métadonnées sont attribuées après chaque nouvelle importation, d'abord c'est là un gage contre l'oubli et le risque de finir avec des photos insuffisamment décrites et difficiles à exploiter pour l'analyse. Mais cela préserve aussi les anciennes couches du projet de modifications accidentelles et non-intentionnelles qui peuvent corrompre le projet. 

Pour prendre l'exemple du corpus d'affiches du Printemps érable, celui-ci se compose de plus de trois cents objets. La figure ci-dessous représente le formulaire de métadonnées saisies pour une affiche selon le modèle générique fourni par Tropy. Pour celle-ci, les champs `Type`, `Source`, `Droits` ont été remplis en effectuant une description par lot pour l'ensemble des objets puisque ces caractéristiques étaient communes à tous. Seul le champ `Créateur` a été rempli manuellement par nos soins, en allant au niveau du menu objet pour travailler plus minutieusement. Le reste des champs (titre, date) s'est rempli automatiquement de métadonnées embarquées au moment de l'importation des fichiers dans Tropy. Attention, tant le nombre que la qualité des métadonnées embarquées peut varier et dépend beaucoup de la qualité de description des fichiers d'origine (dans le cas que nous décrivons, nous avons eu de la chance&nbsp;!). *A minima* les métadonnées embarquées sont toujours présentes au niveau du formulaire Tropy photo, qui décrit tecnhiquement le fichier image, et au niveau du titre dans le formulaire de description de la source. 

{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-06.png" alt="Formulaire de saisie de métadonnées d'une affiche du Printemps érable" caption="Figure 6. Description d'une affiche du Printemps érable québécois en utilisant le modèle générique de Tropy" %}

Voyons donc comment faire pour attribuer de manière groupée des métadonnées. Depuis la zone d'affichage en mode projet, nous nous plaçons au niveau de la zone du milieu avec la vue d'ensemble des objets que nous avons importés. Nous les sélectionnons tous. Ensuite, nous plaçons le curseur au formulaire qui s'affiche dans la partie droite de l'interface sous l'onglet `Métadonnées`. Nous pouvons utiliser les modèles générique ou correspondance de Tropy qui sont efficaces pour la description de la plupart des sources mobilisées dans les recherches en histoire ou [un modèle personnalisé](#personnaliser-le-modèle-de-saisie-des-métadonnées) (la démonstration ci-dessous mobilise `Tropy Generic`). Nous avons identifié au préalable les informations communes à tous les objets de notre corpus&nbsp;: la source, qui est le site web d'où les fichiers image ont été collectés, le type de la création visuelle (affiche), et les droits d'utilisation, où nous respectons la licence déclarée sur le site web d'origine. Nous n'avons plus qu'à renseigner ces champs pour que les métadonnées soient appliquées à tous les objets sélectionnés. De la même manière il est aussi possible d'attribuer des tags pour indexer les objets de manière globale.  

### Attribuer des métadonnées par objet

Nous allons maintenant travailler au niveau de l'objet. Nous venons d'[attribuer massivement des métadonnées](#attribuer-des-métadonnées-par-lot) qui sont communes à tous nos objets&nbsp;; à présent, nous souhaitons renseigner plus de métadonnées qui peuvent être spécifiques à un objet, comme par ex. un auteur, une date... Nous pouvons le faire à partir de la zone d'affichage en mode projet, dans le volet à droite qui décrit l'objet à l'aide de deux onglets, métadonnées et tags. Mais nous pouvons aussi explorer à l'occasion la zone d'affichage en mode objet à laquelle il est possible d'accéder en double-cliquant sur l'objet de notre prédilection. Une fois là, nous pouvons renseigner les champs pertinents à l'aide du modèle de métadonnées adapté à nos sources, dans l'onglet `Métadonnées`. Si nous le souhaitons, nous pouvons d'ores et déjà [indexer](#indexer) nos sources ou retourner pour le faire au moment de l'analyse dans l'onglet `Tags`. 

## Organiser et annoter les fichiers image importés

Cette partie démontre essentiellement les mécanismes qui permettent de classer et d'annoter dans Tropy nos sources pour préparer l'analyse&nbsp;: les [listes](#classer-en-listes) qui permettent d'établir un schéma logique et possible à hiérarchiser, au niveau du projet&nbsp;; la possibilité d'[indexation par mots-clés](#indexer) et de [prise de notes](#transcrire-et-prendre-des-notes), au niveau des objets.  

### Classer en listes 

Les listes permettent de classer les objets (les photos des sources primaires) de manière thématique, chronologique ou selon toute autre catégorisation qui puisse être signifiante selon la problématique d'une recherche. Une classification cohérente des sources peut faciliter considérablement leur analyse puis leur rappel lors de la phase de l'écriture. Pour créer une liste, aller au menu principal de Tropy et sélectionner `Fichier` > `Nouveau` > `Liste`. Cela peut se faire aussi depuis le menu latéral situé dans la partie gauche de la zone d'affichage en mode projet en cliquant droit (ou la manipulation équivalente sur Mac et distributions Linux) sur cette zone-ci et en choisissant `Nouvelle liste`. Ensuite, l'icône d'un répertoire apparaît dans le menu latéral de gauche suivi d'une boîte qu'il faut renseigner avec le nom de la liste. Nous intégrons les objets dans une liste ou plusieurs en les glissant, depuis la zone d'affichage en mode projet, sur le nom de la liste visée. La suppression d’une liste n’a pas d’incidence sur les objets qui, eux, continuent d’exister dans le projet. 

Par ailleurs, il est tout à fait possible de créer des listes imbriquées pour organiser une arborescence.

La figure ci-dessous illustre comment classer un fichier dans une liste thématique. En outre, il est possible de voir un exemple d'arborescence de listes thématiques (qui reproduisent celle de l'archive conservant les sources) en consultant les figures de la partie qui explique comment [regrouper plusieurs fichiers en un seul objet](#fusionner-des-fichiers-image-en-un-seul-objet).

{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-07.png" alt="Objet sélectionné et en cours d'être glissé pour être classé dans une liste thématique" caption="Figure 7. Cet objet Tropy correspond à une affiche du Printemps érable. L'objet est sélectionné et en cours d'être glissé vers une des listes thématiques, définies selon ce que les affiches représentent, pour y être classé." %}

### Indexer

Ensuite, nous avons la possibilité d'indexer nos sources avec des tags, des mots-clés pertinents qui aident à les classer. Si nous le souhaitons, nous pouvons d'ores et déjà indexer nos objets en insérant des tags pertinents à partir de la boîte de dialogue en haut à gauche, onglet `Tags`, à droite de celui des métadonnées, ou retourner pour le faire au moment de l'analyse. 

Ceux-ci sont des moyens d'[indexation personnelle informelle](https://fr.wikipedia.org/wiki/Folksonomie) des objets que nous créons dans Tropy. Cette indexation peut être thématique (par exemple, le nom d'une personnalité politique qui apparaît dans plusieurs documents du projet) ou fonctionnelle (par exemple, *à transcrire*, pour les documents du projet dont nous souhaitons insérer une transcription en note). En tout cas, elle doit être systématique et cohérente.

Les tags permettent de constituer des ponts entre les listes&nbsp;: ils facilitent l'accès, de manière transversale, à des sources qui peuvent faire partie de différentes listes et leur réorganisation suivant une ou plus de caractéristiques communes. Cet accès latéral à nos sources selon un critère spécifique peut permettre de les croiser de manière élémentaire et facilite largement la rédaction. Il vaut mieux réfléchir en amont sur un système pertinent de mots-clés, selon la nature d'une recherche et sa problématique, et d'établir une liste à utiliser systématiquement. Cette liste peut bien sûr s'étendre au fil d'une recherche, elle permet néanmoins de se fixer sur des termes stables en évitant des formes différentes et des incohérences qui pourraient rendre finalement l'indexation moins efficace. 

Bien indexer les sources au moment de les enregistrer peut parfois être jugé chronophage. En réalité, c'est du temps bien investi et pleinement récupéré lors de l'analyse et de la rédaction. 

### Transcrire et prendre des notes

Au dessous de la zone de l'image de l'objet, un éditeur de texte permet la prise de notes. Il est possible de créer autant de notes que souhaité, celles-ci apparaissent ensuite sous forme de liste tout en bas à gauche dans la zone du menu objet. La transcription du contenu d'une image, si celle-ci représente un texte, est aussi possible à faire sous forme de note. Tropy ne dispose pas de logiciel de reconnaissance optique de caractères intégré, par conséquent l'exportation automatique de texte à partir des images du projet n'est pas possible.

Si l’objet Tropy a émané d’une fusion de plusieurs fichiers image, les notes peuvent néanmoins s’insérer séparément pour chaque fichier. Les notes sont exportables soit via [un export global du projet Tropy](#extensions-dun-projet-tropy) soit séparément en cliquant droit dessus et en choisissant de les exporter dans le menu qui s'affiche. 

{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-08.png" alt="Zone d'affichage en mode objet d'une affiche du Printemps érable" caption="Figure 8. Zone d'affichage en mode objet d'une affiche du Printemps érable avec les métadonnées renseignées et transcription du contenu en note" %}


{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-09.png" alt="Onglet de tags de la zone d'affichage en mode objet d'une affiche du Printemps érable" caption="Figure 9. Onglet de tags de la zone d'affichage en mode objet d'une affiche du Printemps érable" %}

### Améliorer les fichiers image 

Tropy offre des fonctionnalités élémentaires pour améliorer la qualité des photos des sources (régler la luminosité, le contraste, etc.) en se servant du menu qui se trouve en haut de la zone où s'affiche l'image. Il est possible aussi de zoomer sur une image pour mieux lire ou observer, d'inverser les couleurs pour, par exemple, lire plus facilement des microfilms. Ou encore, nous pouvons sélectionner une partie de l'image qui nous intéresse particulièrement et sauvegarder cette sélection, qui reste accessible depuis le menu latéral à gauche, pour y revenir aussi souvent que nécessaire. En outre, une sélection peut être sauvegardée en tant qu'image autonome avec ses propres métadonnées. Cela est possible en cliquant droit sur le nom de la sélection, depuis la zone du menu latéral gauche où elle apparaît, et choisir `Exporter la photo` dans le menu qui apparaît.       

## Fusionner des fichiers image en un seul objet  

Certains types de sources, notamment des documents composés de plusieurs pages (journaux, documents diplomatiques, lettres...) peuvent bénéficier de la fonctionnalité de fusionner plusieurs images en un seul objet, lorsque chaque page correspond à un fichier image.

Pour reproduire les étapes ci-dessous décrites, [les fichiers des journaux de tranchées](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/gerer-sources-primaires-numeriques-avec-tropy/journaux-tranchees-14-18) sont fournis et peuvent être téléchargés et utilisés pour créer un projet séparé Tropy.  

Il est possible de regrouper plusieurs fichiers de photos en un seul objet en les fusionnant. Pourquoi faire cela&nbsp;? Le but n'est pas de faire une collection quelconque - pour cela, il existe la fonctionnalité [des listes](/#organiser-les-objets-en-listes) - mais plutôt de relier les parties qui représentent différentes facettes d'une seule source. Il se peut, plus particulièrement, que plusieurs photos se rapportent toutes à la même source primaire sans faire du sens indépendamment l'une de l'autre, par exemple lorsqu'elles représentent les pages d'un document numérisé. Ne pas établir le lien entre aurait comme résultat de créer des fichiers orphelins, et, à terme, un projet désorganisé. Les figures ci-dessous illustrent l'exemple de huit photos correspondant aux différentes pages du même numéro d'un journal de tranchées daté de février 1915 - [le numéro 3 de *L'écho des marmites*](https://argonnaute.parisnanterre.fr/ark:/14707/9tks6j4d0bvf), conservé et numérisé par [La Contemporaine](http://www.lacontemporaine.fr/). Dans un projet Tropy, ces photos ne constituent pas des objets distincts, puisque nous savons à présent qu'un objet est égal à une source primaire. Nous pouvons donc regrouper ces photos pour qu'elles correspondent à une seule source, le numéro spécifique du journal. 

Pour ce faire, il faut d'abord identifier la photo qui représente la première page, en tout cas la partie d'entrée vers la source. En l'occurrence il s'agit de la une du journal, mais dans d'autres projets cela pourrait être la première page d'une correspondance, la couverture d'un livre... Après donc avoir identifié ce fichier image principal, il existe deux manières de faire. 
1. La première consiste à sélectionner les photos que nous souhaitons fusionner avec la photo principale (à ce stade, nous n'avons pas à sélectionner cette dernière, il suffit de l'avoir identifiée). Ensuite, il suffit de glisser les fichiers sélectionnés sur le fichier image principal pour créer un objet Tropy fusionné. S'il existe plusieurs fichiers à fusionner, attention à sélectionner de la fin vers le début soit à l'ordre inverse d'une pagination, c'est-à-dire d'abord le fichier qui représente la dernière page puis celui qui représente l'avant dernière et ainsi de suite, pour glisser l'ensemble vers le fichier image principal. Cela garantit le bon ordre de la pagination de la source représentée. 
2. L'autre manière de faire consiste à sélectionner tous les fichiers image à fusionner y compris le fichier image principal - via la manipulation `Ctrl` + cliquer pour choisir les fichiers). Ensuite, il faut accéder au menu au niveau de l'objet en cliquant droit (ou l'équivalent pour Mac ou distributions Linux) et choisir `Fusionner les objets sélectionnés`. Attention, pour s'assurer que les fichiers fusionnés respectent l'ordre de la pagination de l'original, la sélection cette fois-ci doit commencer par le fichier qui représente la première page du document puis continuer avec ceux qui suivent dans l'ordre souhaité. L'exemple qu'illustrent les figures ci-dessous a suivi cette manière de faire (pour éviter des problèmes de confusion dans l'ordre, bien que le nommage embarqué lors du téléchargement de ces fichiers depuis Argonnaute ait été maintenu, des préfixes-chiffres ont été ajoutés pour indiquer l'ordre des pages).

Si un objet émane d’une fusion de fichiers, c'est le premier fichier image qui hérite aux autres une série de caractéristiques, dont [les métadonnées](#décrire-ses-sources) sont le plus important. Des opérations telle la prise de notes ou la transcription peuvent toujours d'effectuer au niveau de chaque fichier image. 

Un objet fusionné peut toujours être décomposé - via le menu au niveau de l'objet, en choisissant `Exploser l'objet`.

Les figures ci-dessous illustrent d'abord la sélection de plusieurs fichiers puis l'objet qui émane après leur fusion, avant de montrer comment classer l'objet fusionné dans une liste (comme démontré dans la partie [Classer en listes](#classer-en-listes)).

{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-10.png" alt="Sélection des fichiers représentant les pages du numéro 3 du journal L'écho des marmites pour les fusionner en un seul objet Tropy" caption="Figure 10. Sélection des fichiers représentant les pages du numéro 3 du journal L'écho des marmites pour les fusionner en un seul objet Tropy. Les métadonnées saisies décriront alors le numéro et se rapporteront à tous les fichiers à l'identique. Source des fichiers numérisés: Argonnaute, La Contemporaine. Licence Ouverte Etalab" %}

{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-11.png" alt="Objet Tropy à la suite de la fusion de plusieurs documents" caption="Figure 11. Cet objet Tropy correspond à un numéro du journal des tranchées L'écho des marmites. Il a émané de la fusion du fichier qui représente la une avec les sept fichiers qui représentent une page du journal chaque. Source des fichiers numérisés: Argonnaute, La Contemporaine. Licence Ouverte Etalab" %}

{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-12.png" alt="Objet fusionné sélectionné et en cours d'être glissé pour être classé dans une liste" caption="Figure 12. Cet objet Tropy correspond à un numéro du journal des tranchées L'écho des marmites. L'objet est sélectionné et en cours d'être glissé vers une liste thématique pour y être classé. Source des fichiers: Argonnaute, La Contemporaine" %}

## Personnaliser le modèle de saisie des métadonnées 

Tropy offre la possibilité de personnaliser le formulaire de description pour décrire de manière fine tout type de source, si le besoin se fait sentir à cause de la nature spécifique de celle-ci (par exemple, une épigraphie, un monument, un mème internet...) ou encore de la finalité d'un projet (analyse scientifique, préparation pour une mise en ligne sur le web...).

[Nous l'avons vu](#décrire-ses-sources),Tropy propose trois types de formulaires pour décrire une source&nbsp;: générique, spécifique aux correspondances et Dublin Core (élémentaire). Derrière les formulaires se trouvent des modèles de saisie qui eux-mêmes s'appuient sur des schémas de métadonnées, c'est-à-dire des systèmes qui établissent des règles sur la manière de nommer et d'utiliser les éléments d'information qui décrivent une ressource. Le formulaire Dublin Core de Tropy se repose entièrement sur des propriétés du schéma du même nom, qui est un standard utilisé pour décrire des ressources documentaires en vue de leur publication numérique. Les deux autres types de formulaires embarqués (générique et correspondance) combinent des propriétés issues du schéma Dublin Core à d'autres créées par l'équipe de Tropy (par exemple, carton ou dossier dans le modèle générique) pour correspondre au mieux aux besoins de description des sources les plus communément rencontrées dans les recherches historiennes. Il s'agit ici de la création d'un [profil d'application](https://fr.wikipedia.org/wiki/Profil_d%27application) soit un schéma localisé et plus ou moins informel. 

Tropy permet donc de combiner des schémas différents,  mais attention: ceci nécessite un minimum de réflexion pour ne pas réinventer la roue, un véritable besoin, et un peu de familiarité avec le monde des métadonnées, pour ne pas finir avec un modèle mal façonné qui puise sur des différents schémas sans raison valable. 

La forme la plus élémentaire de personnalisation est de réutiliser l'un des formulaires embarqués pour renommer un ou plusieurs de ses champs, et/ou définir des règles sur le contenu à renseigner. 
Toute intervention de ce type doit néanmoins se faire par affinité avec le champ initial: par exemple, attribuer le label Auteur à la propriété Créateur, mais pas le label Titre pour cette même propriété.

Un deuxième niveau de personnalisation implique l'ajout (ou plus rarement la suppression) d'un ou plusieurs champs dans le formulaire de description, ce qui correspond à l'ajout d'une ou plusieurs propriétés dans le modèle de saisie. Attention toutefois à bien identifier le besoin et à pouvoir justifier le recours à l'un ou l'autre schéma des métadonnées le cas échéant.  

Dans les deux cas, la démarche implique de s'appuyer sur un des modèles de saisie déjà intégrés dans Tropy pour soit renommer des champs existant (intervenir au lineau du Label), soit en ajouter de nouveaux ou alors, plus rarement en supprimer ceux qui s'avèrent pas nécessaires (intervenir au niveau de la Propriété). Par ailleurs, recourir systématiquement à la documentation utilisateur de Tropy et/ou des schémas de métadonnées fait aussi partie des bonnes pratiques à suivre.

Admettons que nous souhaitons disposer d'un formulaire de description de correspondances diplomatiques de l'après-Seconde guerre mondiale en provenance de différents centres d'archives diplomatiques localisés dans des pays variés. Dans ce cas, nous pouvons nous appuyer sur le modèle de saisie spécifique aux correspondances (`Tropy Correspondence`) pour l'affiner davantage et l'adapter au sous-type de correspondance diplomatique.  Comment faire? Les paragraphes qui suivent décrivent une possible manière de faire dans le but d'encourager l'expérimentation, plutôt que de proposer un workflow formalisé. 

À partir du menu principal, aller à `Édition` > `Préférences` > `Modèle de saisie`. Dans le menu déroulant qui s'affiche, choisir puis dupliquer le modèle existant `Tropy Correspondence`, pour servir de base afin de créer le nouveau modèle. Après avoir dupliqué l'original, nommer le modèle créé (par exemple,`Correspondance diplomatique`). 

Disons que nous souhaitons effectuer les opérations de personnalisation suivantes pour distinguer notre modèle de saisie par rapport au `Tropy Correspondence` existant&nbsp;:

* Renommer le champ `Public` en `Destinataire`
* Dans le champ `Type` éliminer l'affichage par défaut de *Correspondance* pour pouvoir spécifier davantage les types de correspondances diplomatiques: télégramme, note diplomatique, mémorandum, lettre...
* Disposer d'un champ `Lieu de création` pour saisir l'endroit géographique de production de la correspondance

 Avant toute chose, nous inspectons les champs qui existent déjà dans le modèle copié, nommés à ce niveau `Propriétés`, afin de garder celles qui conviennent sans trop de modifications, si possible. 

Pour renommer un champ, repérer la propriété correspondante (*Public* qui s'appuie sur le terme de Dublin Core *Audience*) et agir au niveau de `Label` pour insérer l'intitulé personnalisé, ici *Destinataire*. 

Pour supprimer *Correspondence* en tant que valeur par défaut de la propriété *Type*, repérer la propriété correspondante (qui s'appuie sur le terme de Dublin Core *Type*) et effectuer l'opération. La documentation de Tropy [explique qu'il est possible de modifier ce champ](https://docs.tropy.org/before-you-begin/metadata#type-1) afin de pouvoir insérer des valeurs plus spécifiques.

Pour ajouter un nouveau champ, il faut essentiellement ajouter une nouvelle propriété. Le besoin identifié est de disposer d'un champ pour renseigner l'endroit géographique où la correspondance est produite. Est-il vraiment nécessaire de créer un nouveau champ&nbsp;?
* Le formulaire embarqué spécifique aux correspondances de Tropy, dispose d'un champ *Couverture* (en anglais nommé Location, qui s'appuie sur le terme de Dublin Core *Coverage*) qui, [selon la documentation de Tropy](https://docs.tropy.org/before-you-begin/metadata#location) a vocation à servir pour renseigner le lieu de production d'une correspondance. La possibilité s'offre ici de suivre une solution simple qui consisterait à renommer ce champ à l'aide de *Label* comme indiqué plus haut.
* Dans le cas précédent, Tropy assume une ambiguité structurelle de la propriété *Coverage* de Dublin Core: celle-ci est relativement générique et sert à décrire aussi bien une couverture spatiale que temporelle. La documentation de Dublin Core [recommande ainsi l'utilisation des sous-propriétés plus spécifiques *Temporal Coverage* et/ou *Spatial Coverage* à la place](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/terms/coverage/).C'est pourquoi il peut être préférable d'ajouter une nouvelle propriété au modèle de saisie. Cela se fait à partir du menu déroulant en choisissant, depuis la liste des termes Dublin Core, `Couverture spatiale dcterms: spatial`. Une fois la propriété ajoutée, il est possible d'insérer l'initutlé dans *Label* l'intitulé *Lieu de création*. 

{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-13.png" alt="Modèle de saisie Tropy Correspondence qui vient d'être dupliqué pour personnalisation" caption="Figure 13. Modèle de saisie Tropy Correspondence qui vient d'être dupliqué afin d'être personnalisé avant d'intégrer de nouveaux champs" %}


{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-14.png" alt="Modèle de saisie spécifique aux correspondances diplomatiques en cours de création" caption="Figure 14. Modèle de saisie en cours de personnalisation avec création d'une nouvelle propriété" %}

Le cas d'affiches nativement numériques invite à réfléchir à un modèle de saisie spécifique à cette source. Ainsi, le modèle de saisie générique de Tropy`Tropy Generic` pourrait être personnalisé pour inclure un champ supplémentaire pour renseigner un titre forgé (phénomène fréquent dans le catalogage d'affiches sans titre) ou encore spécifier le format.

{% include figure.html filename="fr-or-gerer-sources-primaires-numeriques-avec-tropy-15.png" alt="Modèle de saisie spécifique aux affiches" caption="Figure 15. Modèle de saisie personnalisé imaginé pour des affiches intitulé Tropy Poster" %}

## Extensions d'un projet Tropy

Il est possible d'exporter un projet Tropy à l'aide du menu principal en format JSON-LD ou PDF. 
 
Par ailleurs, une série de [plugins](https://fr.wikipedia.org/wiki/Plugin) sont disponibles à l'installation à l'aide du menu des préférences. Nous distinguons ici&nbsp;: 

* le [plugin CSV](https://github.com/tropy/tropy-plugin-csv) (v.3.2.0) pour exporter en format CSV les métadonnées, les notes et les tags des objets d'un projet - [la documentation de Tropy explique comment l'installer](http://www.bulac.fr/media/13726) 
* le [plugin CSL](https://github.com/tropy/tropy-plugin-csl) (v. 1.1.0) pour combiner Tropy au logiciel de gestion de références bibliographiques Zotero - se référer aux tutoriels qui expliquent comment [installer](https://tutos.bu.univ-rennes2.fr/c.php?g=702342&p=5133086) et [utiliser](https://bulac.hypotheses.org/64818) le plugin CSL
* le [plugin Omeka](https://github.com/tropy/tropy-plugin-omeka) pour exporter un projet Tropy afin de le publier en ligne à l'aide [d'un site web Omeka S](https://hal.science/hal-04221115v1). 

## Bibliographie

Les références bibliographiques rassemblées dans cette section sont principalement en français.  

### Généralités 

Mourlon-Druol, Emmanuel. &laquo;&nbsp;Déstructuration et restructuration de l’archive à l’ère numérique&nbsp;&raquo;. Billet de blog. Site web d'Emmanuel Mourlon-Druol https://www.e-mourlon-druol.com/. 7 novembre 2019. URL: [https://www.e-mourlon-druol.com/destructuration-et-restructuration-de-larchive-a-lere-numerique/](https://www.e-mourlon-druol.com/destructuration-et-restructuration-de-larchive-a-lere-numerique/), date de consultation 15 août 2024.

Gandanger, Aliénor et Valentine Gandanger. &laquo;&nbsp;Gazengel - Ooooh Tropy&nbsp;!&nbsp;&raquo;. 
Site web Luxembourg Centre for Contemporary and Digital History (C²DH). 22 février 2024 https://www.uni.lu/c2dh-fr/news/gazengel-ooooh-tropy/ 

Denoyelle, Martine et Johanna Daniel. *Guide pratique pour la recherche et la réutilisation des images d’&oelig;uvres d’art 2021. Institut national d'histoire de l'art*. [https://hal.science/hal-03267948](https://hal.science/hal-03267948)

### Documentation et tutoriels

Arènes, Cécile, Meriç Akdogan, & Aurélien Moisan. *Tropy, un outil pour gérer les corpus iconographiques*. Love Data Week Sorbonne Université. Zenodo. Version 2. 16 février 2024 https://doi.org/10.5281/zenodo.10684529

Galdemar, Michèle. Préparer ses données avec Tropy. Ecole d’été du Consortium DISTAM (Digital Studies
Africa, Asia, and the Middle East), Couvent de la Tourette. École thématique. Les humanités numériques en
études aréales, Eveux, France. 2024, pp.42. [⟨halshs-05412088⟩](https://shs.hal.science/halshs-05412088v1)

Gérer ses photos de recherche avec Tropy. Tutoriel de l'atelier de formation de la Bibliothèque universitaire de l'université Rennes 2. Date de dernière mise à jour: 18 juillet 2024. [https://tutos.bu.univ-rennes2.fr/c.php?g=702342](https://tutos.bu.univ-rennes2.fr/c.php?g=702342) 

Laillier, Benjamin. *Tutoriel Tropy* (version 4), août 2019 https://doi.org/10.5281/zenodo.3381981

Larguèche, Aladin. Tropy : le retour, ou comment convertir ses données photographiques en références bibliographiques dans Zotero. *Le Carreau de la BULAC*. https://doi.org/10.58079/14pdk, date de consultation 10 mai 2026 

Documentation Tropy_FR (avril 2023). Dernière mise à jour de la traduction : Aladin Larguèche, avril 2023. http://www.bulac.fr/media/13726

Valmalle, Delphine. &laquo;&nbsp;Utiliser Tropy pour la gestion de ses photos d'archives&nbsp;&raquo;. YouTube, *Geneatech*, 22 février 2021, [https://youtu.be/AiPqbdwP67E](https://youtu.be/AiPqbdwP67E) 

### Jeux de données pour Tropy

Dans le cadre de la préparation de cette leçon, fournir un corpus de sources visuelles pertinentes pour un public francophone s'est avéré être une tâche compliquée, à cause des restrictions appliquées sinon à la collecte, définitivement au partage des images en provenance d'archives institutionelles ou de réseaux sociaux numériques, même pour un usage pédagogique. Les deux jeux de données référencés ci-dessous ne rendent pas directement disponibles les fichiers image, mais fournissent des instructions de collecte.   

Papastamkou, Sofia, et Thomas Soubiran. « Les affiches numérisées de mai 68 ». Zenodo, 17 mars 2025. [https://doi.org/10.5281/zenodo.15042019](https://doi.org/10.5281/zenodo.15042019).

Papastamkou, Sofia, et Thomas Soubiran. « Les Photos d'Occupy Wall Street Sur Flickr ». Zenodo, 17 mars 2025. [https://doi.org/10.5281/zenodo.15041921](https://doi.org/10.5281/zenodo.15041921).

## Notes de fin

[^1]: Ministère de la Culture (France), Département des études, de la prospective, des statistiques et de la documentation (DEPS). &laquo;&nbsp;Chiffres clés. Statistiques de la culture et de la communication 2022&nbsp;&raquo;, p. 177-178. [URL](https://web.archive.org/web/20240104142707/https://www.culture.gouv.fr/Thematiques/Etudes-et-statistiques/Publications/Collections-d-ouvrages/Chiffres-cles-statistiques-de-la-culture-et-de-la-communication-2012-2022/Chiffres-cles-2022). 

[^2]: Arlette Farge, *Le goût de l'archive*, Paris, Éditions du Seuil, 1989, 10.  

[^3]: Sean Takats, &laquo;&nbsp;Tropy&nbsp;&raquo;, billet de blog, _Quintessence of Ham_, 26 octobre 2017, <http://quintessenceofham.org/2017/10/26/tropy>. Date de consultation 1<sup>er</sup> septembre 2023.
