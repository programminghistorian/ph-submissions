---
title: Introduction à Heurist
collection: lessons
layout: lesson
slug: introduction-a-heurist
date: 2021-04-20
authors:
- Vincent Paillusson
reviewers:
editors:
translator:
review-ticket: 
difficulty: see guidance below
activity: transforming
topics:
abstract: |
  see guidance below
avatar_alt: 
doi: 
---

{% include toc.html %}

## Objectifs du cours

Ce cours est une introduction à l’utilisation de [Heurist ](https://heuristnetwork.org/), logiciel Open Source  développé par l’université de Sydney afin de permettre aux chercheurs en SHS de gérer leurs données acquises sur le terrain.
Le lecteur sera guidé à travers plusieurs étapes telles que :

- la création et la structuration d’un modèle de données dans Heurist
- l’import du jeu de données fourni dans Heurist
- la navigation et la visualisation des données
- la mise en ligne des données

## Présentation de Heurist

Heurist est un système de gestion de base de données ([SGBD](https://fr.wikipedia.org/wiki/Syst%C3%A8me_de_gestion_de_base_de_donn%C3%A9es)).  Élaboré en 2005 par le professeur Ian Johnson[^Remerciements] en collaboration avec des dizaines de projets de recherche en sciences humaines, il vise à redonner au chercheur le contrôle sur ses données plutôt que de le laisser aux développeurs informatique[^5].

Si Heurist peut être utilisé pour gérer tous types de données, il a été pensé pour résoudre des problématiques liées aux recherches en SHS. Il intègre donc nativement la gestion et la visualisation de données spatiales et temporelles ainsi que des éléments permettant de décrire de façon fine des lieux ou des personnes.  

Ses fonctionnalités sont nombreuses, elles comprennent entre autres :

1. La modélisation
2. L'import
3. La visualisation
4. La publication
5. L'export dans un format ouvert
6. Le travail collaboratif
7. L'analyse



{% include figure.html filename="introduction-a-heurist-1.png" caption="Cycle de recherche Heurist" %}


### Quelques éléments techniques

Heurist est un logiciel Open Source, il se base sur une infrastructure serveur de type [LAMP](https://fr.wikipedia.org/wiki/LAMP) très utilisée dans le développeent web. 

Les chercheurs peuvent y avoir accès moyennant la création d'un compte sur [un serveur hébergeant Heurist](http://heuristnetwork.org/free-services/).

Dans le cadre de cette leçon, nous utiliserons une instance hébergée par la [TGIR Huma-Num](https://www.huma-num.fr/) qui [met à disposition Heurist](https://heurist.huma-num.fr) pour la communauté de recherche en SHS.


<div class="alert alert-warning">
  L'utilisation d'un service ou d'une instance mis en place par une infrastructure nationale comme Human-Num est un gage de sécurité pour le stockage des données. Dans le cadre d'une publication, il garantit également une continuité de service et de maintenabilité souvent supérieure à des hébergements personnels voire parfois institutionnels.
</div>

Pour les personnes souhaitant tester Heurist hors ligne, il est également possible d'héberger Heurist localement sur un ordinateur. Les informations pour son installation sont disponibles [ici](https://heuristnetwork.org/installation/). 


<div class="alert alert-warning">
  Cette installation demande des compétences techniques minimales d'administration d'un serveur web pour pouvoir être effectuée.
</div>

Heurist s'appuie sur une conception [relationnelle](https://fr.wikipedia.org/wiki/Base_de_donn%C3%A9es_relationnelle) des données mais simplifie certains aspects de cette modélisation afin de faciliter son utilisation. Nous abordons brièvement quelques concepts clés du modèle relationnel dans la partie [**Modélisation des données**](#modelisation).

## Organisation de la leçon

Dans cette leçon, nous partirons d'un jeu de données brut, discuterons sa modélisation, répercuterons cette modélisation dans Heurist afin d'importer les données pour enfin les publier en ligne.


## Données utilisées pour le cours

Nous utiliserons tout au long du cours le jeu de données de [*Localisation des sites de fouille archéologiques de l'INRAP*](https://www.data.gouv.fr/fr/datasets/localisation-des-sites-de-fouille-archeologiques-de-l-inrap-576210/), libre de droit et recensant 625 sites de fouilles en France.

Comme son nom l'indique il localise des sites fouilles archéologiques de l'[INRAP](https://www.inrap.fr/) et est enrichi d'informations de localisation précises comme:
- les coordonnées géographiques du site de fouille, 
- un nom de site, 
- des informations de localisation utilisant le découpage administratif français:
  * région
  * département
  * commune
- des données temporelles concernant l'intervention archéologique
- des thèmes et des périodes historiques relatifs à ce qui a été découvert sur le site  

Il s'agit d'un tableau de données CSV (format ouvert) dont les colonnes sont séparées par des points-virgules. Il peut être lu et édité avec un simple éditeur de texte ou un tableur.

Ces données, bien que relativement limitée, nous permettront d'utiliser les fonctionnalités de visualisation cartographique et chronologique de Heurist.
Comme nous le verrons plus loin, Heurist porte bien son nom car il permet, par la visualisation des données, notamment spatiales, de découvrir et de corriger très rapidement des erreurs qu'il aurait été difficile de percevoir autrement.

Il facilite également la recherche et la navigation dans les données à travers de nombreux filtres configurables à des fins de recherche individuelle, de travail collaboratif ou encore de diffusion à destination d'un plus large public. 

Pour les besoins de l'exercice et l'intégration correctes des données, certaines opérations de nettoyage et de transformation ont été effectuées à l'aide de l'outil [Open Refine](https://programminghistorian.org/fr/lecons/nettoyer-ses-donnees-avec-openrefine):

- Création de nouvelles colonnes **coordonnées décimales lat/long**. Conversion des coordonnées géospatiales, notées initialement en [Lambert 93](https://fr.wikipedia.org/wiki/Projection_conique_conforme_de_Lambert), en notation décimale latitude/longitude afin de permettre leur intégration dans Heurist,
- Ajout d’une colonne **Id** permettant d’identifier de façon non ambiguë une intervention archéologique,
- La colonne **nom de site** a été renommée en **nom d’intervention**,
- Création d’une nouvelle colonne **nom de site** à partir de la colonne **nom d’intervention**. 
- Opérations de nettoyage des noms de site afin d’identifier un lieu d’intervention de façon non ambiguë:
  * Extraction d'informations relatives à l'intervention plutôt qu'au site comme par exemple l'année d'intervention,
  * Homégénisation des noms de lieux possédant les mêmes coordonnées géographiques.
     

L'ensemble des données que nous utiliserons pour cette leçon sont à télécharger
[ici](https://github.com/vpaillusson/tuto-heurist/raw/master/donnees_inrap.zip).


Vous y trouverez 4 fichiers:

- donnees_inrap_ph.csv
- periodes.csv
- themes.csv
- type_intervention.csv


## <a name="modelisation"></a>Modélisation des données

Nous ne ferons pas un cours[^coursMerise] sur la modélisation relationelle des données, mais Heurist s'appuyant sur une conception relationnelle des données, il est important de rappeler certains concepts afin de comprendre son fonctionnement.

Cette modélisation relationnelle permet de garantir :

- **L'unicité de chaque enregistrement** : Un site archéologique ne sera renseigné qu'une seule fois dans la base de données. La création d'un doublon provoquera une erreur.

- **La non redondance des données saisies**: Si un site fait l'objet de plusieurs interventions archéologiques, il ne sera pas nécessaire de saisir à chaque fois les données le concernant.  De même, en cas de correction concernant ce site il suffira de ne la réaliser qu'une seule fois pour la voir répercutée sur toute la base.

{% include figure.html filename="introduction-a-heurist-2.png" caption="Modélisation de l'unicité" %}



- **Cohérence des données** [^6]: Faciliter le travail de l'utilisateur dans la création et l'édition de ses données en proposant l'usage d'un vocabulaire contrôlé.  


{% include figure.html filename="introduction-a-heurist-3.png" caption="Liste déroulante d'un vocabulaire" %}


### Entités et champs

Ouvrez le fichier **donnees_inrap_ph.csv** avec le tableur de votre choix (par exemple Open Office Calc ou MS Excel).
Les colonnes de ce tableau peuvent être regroupées en 2 types d'objets distincts :


{% include figure.html filename="introduction-a-heurist-4.png" caption="Tableau INRAP" %}


1. Localisation :
    - Nom du site
	- Coordonnee Lambert 93 X
	- Coordonnee Lambert 93 Y
	- Coordonnées décimales longitude
	- Coordonnées décimales latitude
	- Région
	- département
	- Commune

2. Intervention :
    - Id
    - Nom d'intervention
    - Date début
    - Date fin
    - Type d’intervention
    - Thèmes
    - Périodes


Nous appellerons ces objets des **entités**. Dans Heurist elles portent le nom de **Record types**. Les colonnes qui composent ces Record types sont appelées **Fields** dans Heurist. Nous utiliserons également son équivalent français **champs** dans le présent tutoriel.


{% include figure.html filename="introduction-a-heurist-5.png" caption="Modélisation entités champs" %}


Dans notre exemple, **Intervention** serait donc un *Record type*, tandis qu'un intervention précise, par exemple celle d'Id  **INRAPI0002**,  sera une instance de l'entité Intervention et sera appelée un **Record** ou **enregistrement** dans Heurist.


{% include figure.html filename="introduction-a-heurist-6.png" caption="Modélisation instances d'entité" %}


Parmi ses attributs chaque entité disposera d'un attribut spécial l'**identifiant unique** permettant de l'identifier et d'y faire référence de façon non ambigüe.

Cet identifiant peut être un simple nombre incrémenté pour chaque occurrence de l'entité ou être construit de façon plus élaboré en fonction des besoins et du volume d'occurrences.
Dans le cadre de nos données, l'attribut **Id** servira à identifier une intervention de façon non ambiguë et l'attribut **nom de site** à identifier une localisation.

En pratique nous pouvons donc générer un identifiant de deux façons:

- En le construisant de façon arbitraire pour la cohérence de notre modèle conceptuel (champ **Id**),
- En sélectionnant un attribut qui porte déjà ce rôle dans notre base de données (champ **nom de site**)



### Les relations

Les *entités* ne sont pas des objets isolés dans notre base de données. Au contraire elles sont reliées entre elles afin de décrire des événements ou des objets complexes. Par exemple, étant donné que nous souhaitons conserver le lien entre un lieu et une opération archéologique spécifique, une intervention archéologique sera liée à une localisation. Nous verrons plus loin comment Heurist gère ce type de relations en pratique.


### Champs multivalués et cardinalité

Les cellules des colonnes **Thèmes** et **Périodes**, peuvent comporter plusieurs thèmes ou périodes séparés par le symbole « # ». Pour permettre l'interrogation de celles-ci de façon fine nous devons les séparer tout en maintenant leur relation avec l'opération archéologique qu'elles décrivent.

Cela veut donc dire que l'intervention d'Id **INRAPI0002** sera reliée aux thèmes  
**Protohistoire** et **Antiquité** et non au thème **#Protohistoire#Antiquité**.


{% include figure.html filename="introduction-a-heurist-7.png" caption="Modélisation champs multivalués" %}


Il faut indiquer quelque part dans notre modèle qu'une intervention peut avoir plusieurs thèmes. C'est la [cardinalité](https://fr.wikipedia.org/wiki/Cardinalit%C3%A9_(programmation)). Elle permet de préciser si une instance peut être reliée à un ou plusieurs enregistrements d'une autre entité et si cette relation est obligatoire ou optionnelle (une intervention est-elle forcément liée à un thème?).
Nous ne détaillerons pas ici la formalisation de la notation de ces cardinalités mais en pratique dans Heurist cela sera défini pour un champ donné par les paramètres **Repeatability** et **Requirement** :


{% include figure.html filename="introduction-a-heurist-8.png" caption="Champs multivalués dans Heurist" %}


### Vocabulaires contrôlés

Nous venons de rencontrer le cas des thèmes ou périodes qui pouvaient décrire une même intervention. De même, le champ **Type d'intervention** fait référence à une liste de vocabulaires, même si celle-ci compte uniquement deux termes.

Les listes de vocabulaires contrôlés s'opposent à une saisie textuelle libre.

Il s'agit la plupart du temps de lister et de catégoriser des concepts ou des objets, en nombre fini, afin d'éviter certains biais courants lors des saisies textuelles libres tels que : 

- la cohérence orthographique (M ≠ m, Moyen-Âge ≠ Moyen Âge)
- la synonymie (habitats ≈ édifices ≈ architecture)
- l'inclusion (pratiques funéraires ⊆ cultes) 

Mettre en place ce type de liste permet d'optimiser les requêtes sur ses données en évitant un bruit important lors des résultats voire parfois des erreurs.
C'est aussi une façon de se mettre d'accord, au sein d'une communauté, sur une certaine description du monde comme le font les [thésaurus documentaires](https://fr.wikipedia.org/wiki/Th%C3%A9saurus_documentaire). 

Dans une optique de science ouverte, utiliser des vocabulaires descriptifs partagés par une communauté scientifique plus large est également un gage d'interopérabilité et de compréhension mutuelle. 

Afin de gérer ces listes de termes, Heurist utilise des entités spéciales appelées **vocabularies**. Chaque *vocabulary* contient des **terms**.


{% include figure.html filename="introduction-a-heurist-9.png" caption="Vocabulaires contrôlés" %}


## Créer une base de données sur Heurist

Une fois ces quelques informations théoriques rappelés nous pouvons passer à leur mise en pratique dans Heurist.


### Création d'un compte utilisateur

Rendez-vous sur l'adresse [suivante](https://heurist.huma-num.fr/) puis suivez les instructions pour créer un compte ainsi qu'une base de données.

Une fois connecté à cette nouvelle base nous sommes redirigés vers l'interface de Heurist.

{% include figure.html filename="introduction-a-heurist-10.png" caption="Page d'accueil" %}

La colonne de navigation à gauche est organisée par groupes fonctionnels :

- **Admin** : vous pourrez gérer vos bases de données ainsi que les utilisateurs dans cette partie.
- **Design** : ce mode permet la modélisation des données
- **Populate** : vous pourrez ajouter de nouveaux enregistrement ici
- **Explore** : ce mode donne accès à la navigation dans les données. C'est la fonction clef de l'exploitation d'une base Heurist.
- **Publish** : la publication en ligne ce gère ici

Une rubrique d'aide est accessible pour chaque mode via le ? entouré d'un cercle.


{% include figure.html filename="introduction-a-heurist-11.png" caption="Aide Heurist" %}


### Création de notre modèle de données

1. Cliquez sur **Design**
2. Puis sur **Record types**
3. Par défaut le premier groupe est sélectionné.
4. Chaque record type est résumé sur une ligne dans la fenêtre de visualisation de droite.

{% include figure.html filename="introduction-a-heurist-12.png" caption="Record types" %}


#### Création de l'entité de localisation

Comme nous l'avons vu précédemment nous avons :

- 2 entités principales :
    - Localisation
    - Intervention
- 3 vocabulaires :
    - Thèmes
    - Périodes
    - Type d'intervention

Afin de mieux organiser nos données, ajoutez un nouveau groupe de record type en cliquant sur **add** et nommez le **INRAP**.


{% include figure.html filename="introduction-a-heurist-13.png" caption="Groupe de Record types" %}


Les champs dont nous avons besoin pour l'entité localisation sont les suivants :

- Localisation :
    - Nom du site (champ texte)
	- Coordonnées Lambert 93 X (champ texte)
	- Coordonnées Lambert 93 Y (champ texte)
	- Coordonnées décimales longitude (champ lat/long)
	- Coordonnées décimales latitude (champ lat/long)
	- Région (champ texte)
	- Département (champ texte)
	- Commune (champ texte)

<div class="alert alert-warning">
    Même si nous avons converti les coordonnées géographiques en notation décimale afin de les intégrer dans Heurist nous conserverons les données Lambert 93 sous forme de champ texte afin de garder trace de ces données initiales.
</div>



Ajoutons un record type pour définir notre entité de localisation.

1) Cliquez sur **add**
2) Dans la fenêtre vous prévenant que vous pouvez importer des record type existants cliquez sur **continue**


{% include figure.html filename="introduction-a-heurist-14.png" caption="Ajout d'un record type" %}


Remplissez les informations concernant notre record type de localisation auquel nous donnerons ici le nom de **Site**.


{% include figure.html filename="introduction-a-heurist-15.png" caption="Entité de localisation" %}


Il vous est ensuite demandé de choisir le champs par défaut de ce record type. Laissez le choix par défaut et continuez.

Dans Heurist, chaque champ est décrit à l’aide des informations suivantes :

-	Un nom
-	Un type de donnée :
    - Texte libre
     - Liste de vocabulaires
    - information geospatial
    - Zone de texte
-	Une taille : une limite dans le nombre de caractères du formulaire de saisie
-	Un statut :
    - Caché (grisé)
    - Optionnel
    - Obligatoire (génère une erreur si l'information n'est pas remplie)
    - Recommandé
-	Une répétabilité : une seule ou plusieurs occurrences de ce champ (par exemple il peut y avoir plusieurs thèmes ou périodes pour une même intervention)

Renommez le champ **name/title** par défaut en **nom du site**. Conservez les autres paramères par défaut (required, single, field width).


{% include figure.html filename="introduction-a-heurist-16.png" caption="champ nom du site" %}


Il y a cinq autres champs textuels dans notre record type.
Nous allons en créer un ensemble et vous pourrez créer les autres vous-mêmes en suivant la même procédure.

Cliquez sur **Insert field**


{% include figure.html filename="introduction-a-heurist-17.png" caption="Insertion d'un champ" %}


Remplissez les éléments obligatoires en rouge:

- Field name
- Help text
- Data type

Nous sélectionnons le *data type* => *text single line* car il correspond aux champs textuels attendus.


{% include figure.html filename="introduction-a-heurist-18.png" caption="Champ lambert X" %}


Gardez les autres valeurs par défaut et sauvegardez.

Répétez la même opération pour les champs

- Coordonnées Lambert 93 Y
- Région
- Département
- Commune

Cela vous donne l'organisation suivante:


{% include figure.html filename="introduction-a-heurist-19.png" caption="champ textuel" %}


Il ne reste que les informations géoréférencées. La démarche sera la même, seul le *data type* sera différent. Le type geospatial de Heurist prend des données en format lat/long, un seul champ permettra donc d'intégrer les deux valeurs lat et long de notre fichier csv :


{% include figure.html filename="introduction-a-heurist-20.png" caption="champ géoréférencé" %}


Ajoutez le champs suivant avec ce *data type*

- Coordonnées décimales

La création de l'ensemble des champs du *record type* **Site** est ainsi terminée


{% include figure.html filename="introduction-a-heurist-21.png" caption="Tous les champs d'un site" %}


#### Création des vocabulaires

1. Cliquez sur **vocabularies**
2. La colonne la plus à gauche liste les catégories ou groupes de vocabulaires. Par défaut elle se trouve sur la catégorie **User-defined**
3. La colonne suivante liste les vocabualaires de ce groupe. Ici nous voyons deux vocabulaires :
    - Country
    - Place type
4. Enfin la partie la plus à droite liste l'ensemble des termes de ce vocabulaire

<div class="alert alert-warning">
    A noter que les vocabulaires peuvent s'organiser de façon hiérarchique.
</div>


{% include figure.html filename="introduction-a-heurist-22.png" caption="Vocabulaires" %}



Le groupe **user-defined** nous convient bien pour notre besoin, nous allons donc créer nos 3 vocabulaires dans celui-ci en cliquant sur **add**


{% include figure.html filename="introduction-a-heurist-23.png" caption="Ajouter un vocabulaire" %}



1. Renseignez le label : **Thèmes**  ainsi qu'une courte description
2. Il est également possible d'ajouter une URI relative à une description de votre vocabulaire dans un schéma ou une ontologie. Nous ne rensegnerons rien ici pour cet exemple.
3. Sauvez

une fois votre vocabulaire créé, plusieurs fonctionnalités sont disponibles:

1. Ajouter un terme de vocabulaire manuellement
2. Ajouter une liste de termes par références à un autre vocabulaire
3. Exporter les termes
4. Importer les termes


{% include figure.html filename="introduction-a-heurist-24.png" caption="Editer un vocabulaire" %}


Pour ne pas avoir à saisir manuellement l'ensemble des items de nos vocabulaires nous allons utiliser l'import. Nous utiliserons pour ce faire les 3 fichiers *periodes.csv*, *themes.csv* et *type_intervention.csv* que vous avez téléchargés en début de leçon.

Cliquez sur **Import**

1. Copiez et collez la liste des thèmes du  fichier *themes.csv* du zip que vous venez de télécharger dans la fenêtre prévue à cet effet en step 1.
2. Cochez la case **Labels in line 1** puis cliquez sur **Analyse**
3. Vérifier que la liste importée ne présente pas d’erreur
4. Vérifiez que Term (label) est bien rempli avec le nom de notre vocabulaire (ici **Thèmes**) et cliquez sur **Import**.


 {% include figure.html filename="introduction-a-heurist-25.png" caption="Import de termes" %}

Suivez exactement la même opération que précédemment avec le vocabulaire **Périodes** en utilisant le fichier *periodes.csv*.

 Pour **Type d'intervention**, la liste ne contenant que deux termes:

 - Diagnostic
 - Fouille

Vous pouvez soit réitérer la même opération, soit les insérer manuellement un par un en cliquant sur **Add** dans le vocabulaire **Type d'intervention** que vous aurez créé.


 {% include figure.html filename="introduction-a-heurist-26.png" caption="Liste des vocabulaires" %}


#### Création de l'entité **Intervention**


1. Retournez sur Record-Type > INRAP
2. Nous souhaitons ajouter un **record type** et cliquons donc sur **add** comme pour le *record type* **Site**.


 Sélectionnez les champs par défaut pour notre entité : **Name/title**, **start date**, **end date**


 {% include figure.html filename="introduction-a-heurist-27.png" caption="Entité Intervention " %}


 Pour rappel nous avons besoin des champs suivants:

- Intervention :
    - Identifiant d'intervention
    - Nom d'intervention
    - Date début
    - Date fin
    - Type d’intervention -> réfère au vocabulaire du même nom
    - Thèmes - > réfère au vocabulaire du même nom
    - Périodes -> réfère au vocabulaire du même nom
    - Localisation -> réfère a l'entité du même nom

Renommez les champs comme suit:

- Name/title => **Identifiant d'intervention**
<div class="alert alert-warning">
    Id apparaît en rouge car c'est le champ qui est défini comme identifiant principal de l'entité.
</div>

- Start date => **Date début**
- End date => **Date fin**


 {% include figure.html filename="introduction-a-heurist-28.png" caption="Renommage des champs par défaut" %}


Nous allons ajouter les 3 champs de vocabulaires contrôlés.

1. Cliquez sur **insert**
2. Renseignez le label du champ ainsi que sa description et sélectionnez le type de champ
3. Par défaut, **dropdown (terms)** est sélectionné. Cliquez sur **use this field type**.


 {% include figure.html filename="introduction-a-heurist-29.png" caption="Ajout d'un champ de vocabulaire" %}


Enfin sélectionnez le vocabulaire **Thèmes**, rendez le répétable et sauvez.


 {% include figure.html filename="introduction-a-heurist-30.png" caption="Ajout du champ Thèmes" %}


Effectuez la même chose pour **Périodes** et **Type d'intervention** à la seule différence que Type d'intervention ne sera pas répétable.

Ajoutons maintenant la référence à Site en sélectionnant le *data type*  **Record pointer**


 {% include figure.html filename="introduction-a-heurist-31.png" caption="Ajout du champ Site" %}


Pour finir la création de ce champ, sélectionnez le *record type* que nous souhaitons référencer. Ici le *record type* **Site** dans le groupe **INRAP**.


 {% include figure.html filename="introduction-a-heurist-32.png" caption="Sélection de l'entité Site" %}



Pour terminer, ajoutez le champ **Nom de l'intervention** qui sera de type *text single line*  en suivant la même procédure que pour les champs textuels de l'entité Site.

Cela nous donne donc une entité intervention composée des champs ci-dessous :


{% include figure.html filename="introduction-a-heurist-33.png" caption="Liste des champs de l'entité Intervention" %}


## Importer des données dans Heurist

### Import des données de localisation

Notre modèle Heurist est terminé, nous allons pouvoir l'alimenter avec les données INRAP à notre disposition.
Pour ce faire, nous allons changer de mode et passer dans la fonctionnalité **Populate**


{% include figure.html filename="introduction-a-heurist-34.png" caption="Mode Populate" %}



Comme son nom l'indique, ce mode regroupe les fonctionnalités permettant de remplir le modèle que nous avons élaboré dans le mode **Design**

dans ce mode nous pouvons :

- ajouter un enregistrement individuel
- effectuer des imports en lot via des fichiers structurés en format csv, xml ou json
- effectuer une synchronisation avec une collection Zotero

dans notre cas, le fichier source étant un fichier csv, nous cliquerons sur **Delimited text/ CSV**


{% include figure.html filename="introduction-a-heurist-35.png" caption="Import CSV" %}



Cliquez sur **Upload file** et chargez le fichier **donnees_inrap_ph.csv** téléchargé en début de leçon


{% include figure.html filename="introduction-a-heurist-36.png" caption="Chargement du fichier CSV" %}

<div class="alert alert-warning">
    Ce même fichier source va nous permettre de créer les enregistrements de type **Site** et **Intervention**. Les interventions devant référer à une localisation précise, nous créerons en premier les enregistrements de ce type.
</div>



1.	Conservez les 4 premiers paramètres par défaut et modifiez **Multivalue separator**  en **#** via la liste déroulante afin de séparer les occurrences multiples de périodes et de thèmes telles qu'elles sont représentées dans notre fichier CSV.

2.	Cliquez sur **Analyse data** pour afficher une visualisation des données et vérifier qu’elles sont correctement interprétées puis cliquez sur **Continue**


{% include figure.html filename="introduction-a-heurist-37.png" caption="Analyse du fichier CSV" %}


3. Dans **select record type**, choisissez **Site** et cliquez sur **OK**


{% include figure.html filename="introduction-a-heurist-38.png" caption="Sélection de l'entité à alimenter" %}


Une fois les données analysées et chargées dans Heurist, la première étape consiste à vérifier si des données de type **Site** existent déjà dans le système. Pour ce faire Heurist vérifie qu'un champ de type identifiant, ou bien plusieurs champs ensemble (comme des terms ou des champs textuels), présents dans les données csv chargées ne soit pas déjà présent dans sa base. Cela permet de mettre en place une mise à jour des données si elles existent ou bien d’en créer de nouvelles dans le cas contraire.

1. Cochez la case **Nom du site** dans la colonne de gauche correspondant aux données du fichier CSV et sélectionnez **Nom du site** dans la colonne correspondant à notre entité *Site* dans Heurist.
2. Cliquez sur  **Match against existing records**


{% include figure.html filename="introduction-a-heurist-39.png" caption="Correspondance avec des enregistrements existants" %}


La deuxième étape consiste à indiquer à Heurist quelle colonne du tableau va renseigner quel champ dans notre entité *Site*. Il suffit donc de cocher les cases des colonnes à importer et de renseigner dans la colonne de droite à quel champ elles correspondent.

1. Cochez les champs du fichier csv à importer et sélectionnez en face les champs qu'ils doivent alimenter
2. Vous pouvez visualiser et naviguer les enregistrements qui vont être créés dans la colonne de droite

<div class="alert alert-warning">
    Nous voyons que le fichier contient 625 lignes mais que seuls 609 localisations seront créés. S'agissant d'un tableau recensant les interventions, cela vient du fait que plusieurs interventions se sont déroulées dans le même lieu. Il y a donc moins de lieux que d'interventions.
</div>



4. Cliquez sur **prepare** puis **start insert**


{% include figure.html filename="introduction-a-heurist-40.png" caption="Insertion des données CSV" %}


L'ensemble des entrées ont été créées et une fenêtre de résumé vous indique les opérations effectuées :


{% include figure.html filename="introduction-a-heurist-41.png" caption="Résumé des opérations effectuées" %}




### Import des données d'intervention

Après avoir chargé nos données de localisation il nous reste à importer les interventions.
Cliquez sur **back to Start** pour retourner au chargement du fichier CSV.


{% include figure.html filename="introduction-a-heurist-42.png" caption="Retour au chargement du fichier" %}


Pour finir ce projet nous devons charger le reste des données liées aux interventions. Pour ce faire nous allons effectuer les mêmes opérations de chargement du fichier que précédemment.

Arrivé à **select record type**, choisissez cette fois-ci **Intervention**, cochez la case **site** pour gérer les dépendences entre les enregistrements puis validez.



{% include figure.html filename="introduction-a-heurist-43.png" caption="Sélection de l'entité Intervention pour import" %}



Comme à chaque import, Heurist vérifie d'abord si des enregistrements existent déjà. Sachant qu'une Intervention est liée à un Site, Heurist vérifie en premier si les sites qui sont dans le fichier csv sont déjà présentes dans la base de données. Il faut donc faire correspondre le champ **nom du site** du fichier csv avec le champ **nom du site** de l'entité Site dans Heurist.


{% include figure.html filename="introduction-a-heurist-44.png" caption="Correspondance avec des sites déjà présents en base de données" %}


Heurist vérifie les éléments et, chose relativement classique, le fichier initial n'étant pas parfait, trouve des doublons dans les noms de site et propose de nous aider à les désambiguïser.

En l'occurrence il s'agit de la même chaîne de caractères mais avec une majuscule à l'initiale pour un site et sans majuscule pour l'autre.

1) cliquez sur **Resolve ambiguous matches**
2) vérifiez les enregistrements déjà en base de données
3) puis alignez les records avec les données trouvées dans le fichier CSV


{% include figure.html filename="introduction-a-heurist-45.png" caption="Résolution des ambiguïtés" %}


une fois les doublons résolus, nous effectuons la même opération pour les interventions


{% include figure.html filename="introduction-a-heurist-46.png" caption="Correspondance avec des interventions déjà présentes en base de données" %}


renseignez ensuite les champs d'intervention que vous souhaitez remplir via votre fichier csv, validez la préparation et finissez l'import


{% include figure.html filename="introduction-a-heurist-47.png" caption="Import des données d'intervention" %}

une fenêtre vous indique l'insertion de 625 nouveaux enregistrements

{% include figure.html filename="introduction-a-heurist-48.png" caption="Résumé des opérations d'import" %}


## Naviguer et éditer les données


### Données de localisation

Cliquez sur **Explore** dans la colonne de gauche.


{% include figure.html filename="introduction-a-heurist-49.png" caption="Explore" %}


L'onglet **Explore** présente un panel de fonctionnalités permettant de naviguer et filtrer les données chargées dans la base Heurist.
Placer votre curseur sur **Entities** puis sur le record type de votre choix. Ici nous souhaitons d'abord afficher les Sites.


{% include figure.html filename="introduction-a-heurist-50.png" caption="Afficher les enregistrements" %}



Les sites sont listés par leur Heurist ID (H-ID) ce qui donne un label du type *Record 1250*.
Nous allons voir comment modifier ce label peu intelligible un peu plus loin dans la leçon.

<div class="alert alert-warning">
    Nous pouvons également vérifier que le nombre d'enregistrement chargé correspond bien à ce qui est attendu. Ici 609.
</div>



En cliquant sur un enregistrement, les données le concernant apparaissent dans le volet de visualisation de droite, y compris la relation avec une intervention archéologique.

Par défaut le mode **Record View** est sélectionné. Il affiche l'ensemble des informations d'un enregistrement  et donne accès à son édition.

![Explore localisation record view](https://raw.githubusercontent.com/vpaillusson/tuto-heurist/master/images-v6/explore-localisation-record-view.png)

{% include figure.html filename="introduction-a-heurist-51.png" caption="Afficher le détail d'un enregistrement" %}



D'autres options de visualisation sont disponibles:


- **Map-Timeline** : permet une visualisation spatiale et temporelle des données


{% include figure.html filename="introduction-a-heurist-52.png" caption="Vue cartographique" %}

<div class="alert alert-warning">
    Nous observons déjà que certaines données semblent manifestement erronnées, se situant au Mali pour un site ou près des côtes africaines pour deux autres. Le rôle de la visualisation des données spatiales à des fins correctives est ici évident. Nous verrons comment corriger ce type d'erreur un peu plus tard.
</div>



{% include figure.html filename="introduction-a-heurist-53.png" caption="Visualisation des erreurs de coordonnées" %}


- **List view**: permet de lister les enregistrements sous forme de tableau et de les exporter notamment en PDF et EXCEL


{% include figure.html filename="introduction-a-heurist-54.png" caption="Liste des enregistrements" %}


- **Custom reports** (pour utilisateurs plus avancés) : permet de gérer la mise en page des résultats d'une requête via des templates utilisant un langage informatique simplifié[^Smarty]. La mise en page ainsi générée peut ensuite être mise en ligne.


{% include figure.html filename="introduction-a-heurist-55.png" caption="Customisation de l'affichage d'un enregistrement" %}


- **Export**: permet l'export de l'ensemble des résultats de la requête en cours sous différents formats (CSV, JSON, GEOJSON, XML, KML)


{% include figure.html filename="introduction-a-heurist-56.png" caption="Formats d'export" %}


Les deux fonctionnalités qui suivent servent à visualiser des relations entre enregistrements.

- **Network diagram**: affiche un diagram montrant les liens entre les enregistrements.

- **Crosstabs**: permet d'effectuer des requêtes croisées sur les données

### Modifier / Editer les données

Nous avons vu précédemment que certaines données géographiques ne semblaient pas correctes.

Cliquez sur l’onglet **Map-Timeline** pour visualiser l’ensemble des sites géolocalisés.

En cliquant sur le drapeau d'un site sur la carte vous pouvez afficher, à l'aide d'un popup, l'ensemble des informations concernant cette enregistrement. Ici nous cliquons sur le site situé au Mali. Le nom du site apparaît sous forme de popup et l'enregistrement correspondant est automatiquement sélectionné.

Directement depuis le popup passez en mode édition pour corriger les informations liées à cet enregistrement.


{% include figure.html filename="introduction-a-heurist-57.png" caption="Correction coordonnées du site de Boulazac" %}


Pour corriger ou entrer une donnée GPS, Heurist propose 2 solutions:

1. rechercher dans la base de données d'OpenStreetMap un nom de lieu et lui attribuer un marqueur de point permettant de définir ses coordonnées
2. insérer les coordonnées, qui auront été récupérées par le moyen de votre choix, directement

**Option 1**

1.	Cliquez sur le champ de saisie de **Coordonnées GPS**
2. Dans la fenêtre qui s'ouvre effectuez une recherche sur Boulazac dans la base d'OpenStreetMap


{% include figure.html filename="introduction-a-heurist-58.png" caption="Recherche Boulazac" %}


3.	Le site est trouvé sur OpenStreetMap. Il faut y adjoindre un marqueur pour enregistrer les coordonnées du point dans Heurist.
4. Cliquez sur le marker et déplacez le jusque sur le pointeur du site trouvé via le moteur de recherche puis sauvegardez.


{% include figure.html filename="introduction-a-heurist-59.png" caption="Placement du marqueur" %}


**Option 2**

1. Cliquez sur le champ de saisie de **Coordonnées GPS**
2. puis sur  **Add Geometry** dans la colonne de droite de la carte.
3. Insérez les coordonnées dans le format indiqué, par exemple ici pour un simple point la syntaxe est la suivante : **0.7679869062166365 45.178199165946225** et sauvegardez les modifications.


{% include figure.html filename="introduction-a-heurist-60.png" caption="Renseigner les coordonnées manuellement" %}


Afin de vérifier que les modifications des coordonnées GPS ont bien été prises en compte nous allons utiliser l'assistant de filtre :

1.	Ajouter un filtre
2.	Dans la fenêtre de paramètres qui s’ouvre saisissez les informations nécessaires pour trouver notre enregistrement
3.	Filtrez


{% include figure.html filename="introduction-a-heurist-61.png" caption="Rechercher un enregistrement" %}


Un seul élément est trouvé et vous pouvez observer que la modification du lieu a bien été effectuée.


{% include figure.html filename="introduction-a-heurist-62.png" caption="Vérification de la modification" %}

<div class="alert alert-warning">
    Il peut être utile de rafraichir la page (CTRL + R) pour regénérer complètement la page en cours et ainsi visualiser certaines modifications.
</div>



### Modifier le label des enregistrements

Nous avons trouvé Boulazac mais son label/titre dans la liste des *records* est toutefois peu intelligible.
Un masque de titre est défini pour chaque *record type*.

Nous pouvons le modifier depuis n'importe quel *record* au sein du même *record type*.

Dans le fenêtre d'édition d'un Site, cliquez sur **Edit title mask**


{% include figure.html filename="introduction-a-heurist-63.png" caption="Modification du masque de titre" %}


1) Sélectionnez le ou les champs que vous souhaitez afficher ans la colonne de gauche
2) Cliquez sur **Insert field** et agencez les comme vous le souhaitez dans le champ texte
3) Sélectionnez des enregistrements et testez votre nouveau masque de titre
4) sauvegardez les modifications


{% include figure.html filename="introduction-a-heurist-64.png" caption="Edition du masque de titre" %}


Rafraichissez la page (CTRL+R) et visualiser les modifications apportées.

Vous savez donc maintenant comment naviguer dans vos données, les modifier et visualiser à la volée les corrections ou ajouts effectués.

### Utilisation des filtres

Toujours en mode Explore, si le dernier filtre que nous avons inséré est toujours actif, utilisez le filtre par entité dans la colonne de gauche pour n'afficher que les entités de type **Intervention**.


{% include figure.html filename="introduction-a-heurist-65.png" caption="Lister les interventions" %}


Comme avec les données de localisation, nous pouvons visualiser les informations de chaque intervention dans la fenêtre de visualisation via le mode **record view**.

Nous observons que les valeurs des champs multivalués comme thèmes et périodes sont correctement séparées, le nom du site apparaît bien comme élément lié et en cliquant dessus un popup affiche les données le concernant.


{% include figure.html filename="introduction-a-heurist-66.png" caption="Visualiser le détail d'une intervention" %}


En revanche, si nous tentons de visualiser les informations géographiques liées à une intervention via le mode **map timeline**, cela ne fonctionne pas. Seules les informations temporelles de chaque intervention aparaissent.

En effet, actuellement notre requête de filtre ne demande que d'afficher les interventions et de récupérer les données qui y sont directement attachées. En revanche nous n'avons pas précisé à Heurist de récupérer le détail des informations géographiques liées à chaque intervention.

Pour enrichir notre requête nous allons créer un filtre spécifique :

1. cliquez sur **save filter**
2. renseignez le nom et le type de record filtré par défaut

<div class="alert alert-warning">
    Si vous avez déjà effectué un filtre par exemple pour visualiser des Interventions alors la requête textuelle sera déjà préremplie ici. Dans l'exemple qui nous concerne *t:55*  se lit comme *affiche moi l'ensemble des enregistrements pour l'entité d'id 55*.
</div>



{% include figure.html filename="introduction-a-heurist-67.png" caption="Création d'un filtre avancé" %}


3. Editez la règle qui permet de remonter les informations de localisation via la relation de **record pointer** entre Intervention et Site, puis sauvegardez la règle et le filtre


{% include figure.html filename="introduction-a-heurist-68.png" caption="Afficher les informations du record pointeur site" %}


Lorsque vous sélectionnez le filtre que vous venez de créer dans la rubrique **Saved filters > My filters** vous pouvez maintenant visualiser directement les données spatiales attachées aux interventions


{% include figure.html filename="introduction-a-heurist-69.png" caption="Visualisez les informations spatiales" %}



## Mettre en ligne les données gérées dans Heurist

Les opérations de modélisation, de visualisation et d'édition offrent les outils pour gérer ses données de recherche. Elles oeuvrent également à préparer le partage des données avec des collaborateurs ou encore à les publier plus largement.

Heurist propose plusieurs fonctionnalités de mise en ligne :

- par la création d'un filtre de visualisation à facettes qui sera intégré dans une page web hébergée sur un autre site (wordpress, drupal, etc.)
- par la création d'une page web directement dans Heurist
- par la génération d'un site web complet avec gestion du contenus des pages et personnalisation de l'affichage

Ces solutions s'appuient sur la création préalable d'un filtre (que nous venons de décrouvrir) ou d'une recherche à facettes.

<div class="alert alert-warning">
  Les filtres ainsi que les recherches à facettes peuvent être sauvegardés dans d'autres **workgroups** que **My filters** les rendant ainsi accessibles à d'autres utilisateurs membres de ces workgroups.
</div>



### Création d'un filtre de recherche à facettes

1. Sélectionnez l'éditeur de filtre à facettes soit dans les fonctionnalités du mode **Explore**.
2. dans la fenêtre de paramètres du filtre, remplissez les champs comme ci-dessous pour indiquer que le filtre portera sur le type Intervention et que nous souhaitons les voir afficher sous forme de ligne.


{% include figure.html filename="introduction-a-heurist-70.png" caption="Création d'un filtre à facettes" %}


3. Comme pour le filtre de recherche, éditez la règle qui permet de remonter les informations de localisation via la relation de **record pointer** entre Intervention et Site, puis sauvegardez la règle et validez.


Sélectionnez les champs sur lesquels vous souhaitez pouvoir effectuer des requêtes. Nous pouvons ici sélectionner les champs de l'entité Intervention mais également ceux de l'entité Site liés par le champ **Site**.


{% include figure.html filename="introduction-a-heurist-71.png" caption="Sélection des champs à filtrer" %}



Une fois validés les champs, une nouvelle fenêtre permet de personnaliser la manière de présenter nos champs de recherche par facettes. Plusieurs sont possibles et seront plus judicieuses en fonction de l'expérience utilisateur souhaitée :

 - **List** : présente une liste de l'ensemble des valeurs possibles d'un champ avec leur nombre d'occurrences
 - **Wrapped** : présente l'ensemble des valeurs d'un champ sous une forme plus concise
 - **Search** : permet la recherche par simple saisie textuelle
 - **Slider**: permet la navigation temporelle à l'aide de curseurs
 - **Dropdown**: propose une liste sous forme de liste déroulante

Par défaut tous les champs texte proposent une recherche par saisie textuelle. Lorsque le nombre de termes le permet il est possible de proposer une liste ou un présentation plus concise. Modifiez les labels pour les champ liés aux sites, conservez l'affichage par défaut pour chaque champ et validez.


{% include figure.html filename="introduction-a-heurist-72.png" caption="Modes d'affichage des filtre de champs" %}


Pour visualiser le résultat de notre filtre :

1. rendez-vous sur les **saved filters** dans Explore ou bien dans **saved filters** au bout de la barre de filtre
2. puis sélectionnez le filtre à facettes que nous venons de créer


{% include figure.html filename="introduction-a-heurist-73.png" caption="Sélection du filtre à facettes" %}



{% include figure.html filename="introduction-a-heurist-74.png" caption="Visualisation de la recherche  facettes" %}



### Création d'une page web autonome

Pour créer une page web dédiée et personnalisable.

1. Passez en mode **Publish**
2. sélectionnez **standalone web page**
3. renseignez le nom de votre choix et validez


{% include figure.html filename="introduction-a-heurist-75.png" caption="Création d'une page web autonome" %}


Dans la colonne de gauche, cliquez sur **Edit layout**.


{% include figure.html filename="introduction-a-heurist-76.png" caption="Editer la page web" %}


La fenêtre d'édition est composée de plusieurs parties :

1. Barre de menu vous permettant d'ajouter des widgets, d'ajouter des images ou d'éditer le contenu textuel de votre page
2. Le contenu textuel par défaut donnant quelques indications. Il sera remplacé par tout contenu de votre choix
3. Widget de recherche. Ce widget affiche un filtre à facettes sélectionné précédemment dans Heurist afin d'effectuer des requêtes sur nos données

Les autres widgets affichent les résultats des requêtes effectuées à travers le premier widget de recherche.

Par défaut, nous avons :

4. la carte géoréférencée
5. la liste des enregistrements


{% include figure.html filename="introduction-a-heurist-77.png" caption="Organisation des éléments de la page web" %}


Commençons par le plus important: alimenter la recherche avec le filtre à facettes que nous avons créé.

1. Editez le widget de recherche
2. vérifiez que le groupe de travail sélectionné possède bien le filtre que vous avez créé précédemment (ici par exemple c'est le groupe de travail **Website filters**)
3. sélectionnez le filtre à facettes


{% include figure.html filename="introduction-a-heurist-78.png" caption="Editer le widget de filtre" %}


4. sauvegardez et validez pour visualiser les modifications apportées


{% include figure.html filename="introduction-a-heurist-79.png" caption="Validation des modifications apportées" %}


{% include figure.html filename="introduction-a-heurist-80.png" caption="Visualisation des modifications" %}


Nous retrouvons les filtres à gauche, la carte au centre avec l'ensemble des sites archéologiques et par défaut aucune intervention dans la colonne de droite tant qu'aucune requête n'a été effectuée.

Pour lister l'ensemble des interventions dès l'affichage de la page, nous allons indiquer à ce widget de les afficher avant même qu'une requête soit effectuée dans la recherche à facettes.

Pour cela, passez de nouveau en mode édition et éditez le widget de résultats de recherche.
Renseignez **t:interventions** ou **t:55** comme filtre initial.

<div class="alert alert-warning">
  A noter que l'utilisation du code Heurist du **record type** pour les filtres est plus stable dans le temps étant donné que le nom du record type peut être modifié à tout moment selon les besoins par les administrateurs de la base.
</div>



{% include figure.html filename="introduction-a-heurist-81.png" caption="Filtre par défaut des enregistrements" %}


Sauvegardez vos modifications et validez pour sortir du mode édition.

Cliquez sur **Refresh** dans la colonne de gauche pour actualiser la page.


{% include figure.html filename="introduction-a-heurist-82.png" caption="Actualisation de la page" %}



{% include figure.html filename="introduction-a-heurist-83.png" caption="Visualisation des modifications" %}


Pour finir, personnalisons le contenu textuel en passant de nouveau en mode édition.


{% include figure.html filename="introduction-a-heurist-84.png" caption="Edition du contenu textuel" %}


Insérez le texte de votre choix, sauvegardez puis validez.


{% include figure.html filename="introduction-a-heurist-85.png" caption="Validation des modifications" %}


Maintenant que votre page est personnalisée vous pouvez la partager en récupérant son URL via le bouton de partage et d'intégration  


{% include figure.html filename="introduction-a-heurist-86.png" caption="Partage de la page" %}


Dans la même fenêtre, Heurist fournit également  le code pour l'intégration d'une page web dans une autre. Cela se fait par des éléments html appelés **iframe**.

Pour intégrer notre page web dans une page d'un autre site (par exemple un article de blog Wordpress), il suffira de copier et coller ce code dans l'éditeur de l'article.

<div class="alert alert-warning">
  Pour des questions de sécurité, certains [systèmes de gestion de contenu](https://fr.wikipedia.org/wiki/Syst%C3%A8me_de_gestion_de_contenu) (CMS) ou administrateurs de sites web bloquent la possibilité d'intégrer ces **iframe** ou conditionnent leur utilisation. Rapprochez-vous de l'administrateur du site ou de son webmestre pour avoir plus d'informations.
</div>



### Gérer les droits d'accès à vos pages

Notre page web est créée, il ne reste plus qu'à en gérer les droits d'accès. Par défaut les données d'un enregistrement ne sont éditables que par le propriétaire de la base et sont visibles par les utilisateurs connectés de Heurist.

Pour modifier ces droits et rendre vos données accessibles publiquement repassez en mode **Explore** et dans la barre d'options au dessus de la liste des enregistrements, sélectionnez **Ownership/Visibility** dans le menu de gestion de partage.


{% include figure.html filename="introduction-a-heurist-87.png" caption="Accès en lecture et écriture aux enregistrements" %}


Définissez le périmètre de votre choix (ici nous sélectionnons l'ensemble des enregistrements présents), les utilisateurs ou groupes d'utilisateurs ayant l'autorisation de modifier les données et enfin les utilisateurs pouvant visualiser les données. Validez pour appliquer les modifications.


{% include figure.html filename="introduction-a-heurist-88.png" caption="Modifier les options de visualisation" %}


Vous pouvez voir que les changement ont bien été pris en compte en observant le changement de couleur du chiffre à gauche de chaque enregistrement.

En passant le curseur de la souris sur le chiffre ou sur le symbole barré juste à côté vous obtenez des informations sur la visibilité et les droits d'édition de chaque enregistrement


{% include figure.html filename="introduction-a-heurist-89.png" caption="Vérification des modifications" %}


## Conclusion

Heurist est un outil en constante évolution depuis 2005, fonctionnellement très riche à destination des chercheurs. Si son accès n'est pas réservé aux informaticiens ou développeurs, cette richesse fonctionnelle peut rendre son utilisation délicate pour de nouveaux utilisateurs. Nous espérons que ce tutoriel permettra à un plus grand nombre d'utiliser ce logiciel pour répondre à leurs besoins.

L'utilisation avancée de certaines fonctionnalités peut toutefois nécessiter de l'aide extérieur. La rubrique **Help** est dédiée à cet usage.


{% include figure.html filename="introduction-a-heurist-90.png" caption="Rubrique d'aide" %}


Le site web [heuristnetwork](https://heuristnetwork.org) dispose également d'une page [contact](https://heuristnetwork.org/contact/) ainsi que d'une rubrique [learn](https://heuristnetwork.org) permettant de compléter le contenu du présent cours.

## Ressources utiles

### Sur l'utilisation de Heurist

- Page d'aide de Heurist (en anglais) régulièrement augmentée et à consulter sans modération : [https://heuristplus.sydney.edu.au/heurist/?db=Heurist_Help_System&website&id=39&pageid=622](https://heuristplus.sydney.edu.au/heurist/?db=Heurist_Help_System&website&id=39&pageid=622)
- Liste de diffusion francophone des utilisateurs Heurist: [https://groupes.renater.fr/sympa/info/heurist-utilisateurs](https://groupes.renater.fr/sympa/info/heurist-utilisateurs)
- Un autre tutoriel sorti en mars 2021 sur Heurist, rédigé par Régis WITZ de l'université de Strasbourg : [https://uncoded.gitlab.io/BDD/](https://uncoded.gitlab.io/BDD/)

### Sur la gestion des données de la recherche

- Leçon "Préserver ses données de recherche", ProgrammingHistorian, [https://programminghistorian.org/fr/lecons/preserver-ses-donnees-de-recherche](https://programminghistorian.org/fr/lecons/preserver-ses-donnees-de-recherche)
- Sur le thème des formats ouverts ou fermés, Doranum, [https://doranum.fr/stockage-archivage/quiz-format-ouvert-ou-ferme/](https://doranum.fr/stockage-archivage/quiz-format-ouvert-ou-ferme/)
- FACILE, Le service de validation de formats du CINES, [https://facile.cines.fr/](https://facile.cines.fr/)









[^5]: "Heurist, une base de données généraliste pour les sciences humaines et sociales", Paris Time Machine, https://paris-timemachine.huma-num.fr/heurist-une-base-de-donnees-generique-pour-les-sciences-humaines-et-sociales/
[^6]: Ce point n'est pas propre aux bases de données relationnelles mais plutôt à tout effort qui peut être fait pour obtenir des données cohérentes et non sujettes à bruits ou défauts
[^coursMerise]: Pour en savoir plus: https://ineumann.developpez.com/tutoriels/merise/initiation-merise/
[^Smarty]: Pour en savoir plus : https://www.smarty.net/
[^IdInrap]: Identifiants arbitraires créés pour les besoins de la présente leçon
[^OpenrefinePH]: nettoyer ses données avec Open refine: https://programminghistorian.org/fr/lecons/nettoyer-ses-donnees-avec-openrefine
[^Remerciements]: Que je remercie pour la relecture, les conseils et corrections apportés à la présente leçon
