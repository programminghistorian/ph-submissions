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

Ce cours est une introduction à l’utilisation d'[Heurist ](https://heuristnetwork.org/), logiciel Open Source  développé par l’université de Sydney afin de permettre aux chercheurs en SHS de gérer leurs données acquises sur le terrain.
Le lecteur sera guidé à travers plusieurs étapes telles que :

- la création et la structuration d’un modèle de données dans Heurist
- l’import du jeu de données fourni dans Heurist
- la navigation et la visualisation des données
- la mise en ligne des données

## Présentation de Heurist

Heurist est un système de gestion de base de données ([SGBD](https://fr.wikipedia.org/wiki/Syst%C3%A8me_de_gestion_de_base_de_donn%C3%A9es)).  Élaboré en 2005 par le professeur [Ian Johnson](https://sydney.academia.edu/Johnson)[^Remerciements] en collaboration avec des dizaines de projets de recherche en sciences humaines, il vise à redonner au chercheur le contrôle sur ses données plutôt que de le déléguer aux développeurs informatique[^5].

Si Heurist peut être utilisé pour gérer tous types de données, il a été pensé pour résoudre des problématiques liées aux recherches en SHS. Il intègre donc nativement la gestion et la visualisation de données spatiales et temporelles ainsi que des éléments permettant de décrire de façon fine des lieux ou des personnes.  

Ses fonctionnalités sont nombreuses, elles comprennent entre autres :

1. La modélisation
2. L'import
3. La visualisation
4. La publication
5. L'export dans un format ouvert
6. Le travail collaboratif
7. L'analyse



{% include figure.html filename="introduction-a-heurist-1.png" caption="Fig. 1. Cycle de recherche Heurist. Image : Ian Johnson." %}

## Science ouverte

Dans une optique d'ouverture et de pérénisation des données de la recherche, les chercheurs peuvent s'appuyer sur différents outils conceptuels pour aider à partager et rendre accessibles leurs données dans le temps.

### Principes FAIR 

Les principes [FAIR](https://fr.wikipedia.org/wiki/Fair_data) se présentent sous forme d'objectifs clairs à viser dans le cadre de la production, du partage et de la publication de ses données de recherche. Les données doivent être :

- ***F**indable* - Facilement trouvables, 
- ***A**ccessible* - Accessibles,
- ***I**nteroperable* - Interopérables,
- ***R**eusable* - Réutilisables.

Les moyens ne sont pas donnés dans la définition même de ces objectifs, mais il est toutefois possible d'extraire de chaque principe un certain nombre de sous-axes permettant de garantir leur bonne application. La section dédiée aux principes FAIR sur [Doranum](https://doranum.fr/enjeux-benefices/principes-fair/) est à ce sujet très pédagogique. 

### 5 Star Open Data

Un outil similaire et complémentaire aux principes FAIR est le [5 Star Open Data](https://www.w3.org/2011/gld/wiki/5_Star_Linked_Data).
Si les données FAIR répondent à des objectifs et nous donnent donc un résultat à viser, les 5 Star Data nous fournissent une échelle d'évaluation de l'ouverture de nos données en fonction de différents critères comme le format, la description des données, le droit d'usage, l'identification et le lien avec d'autres données accessibles sur le web. Le site [5startdata](https://5stardata.info/fr/) communique des informations très utiles pour visualiser concrètement ce que sont des données considérées comme ouvertes pour ce modèle.


### Plan de gestion de données  

Le [plan de gestion de données](https://fr.wikipedia.org/wiki/Plan_de_gestion_des_donn%C3%A9es) (PGD) ou *Data Management Plan (DMP)* est un outil qui offre au chercheur ou au responsable d'un projet de recherche la possibilité d'organiser et de planifier la gestion et l'évolution de ces données de recherche tout au long de son projet afin d'en garantir la pérennité et l'accessibilité.
Il est utilisé, entre autres, dans le cadre de projets financés par la Commission Européenne ou encore, en France, par l'ANR.
L'outil [DMP OPIDOR](https://dmp.opidor.fr/) aide les chercheurs, à travers l'utilisation de modèles prédéfinis, à rédiger leur plan de gestion de données.

### Heurist et la science ouverte

Comment Heurist peut-il aider à répondre aux objectifs de la science ouverte ? 

- En donnant la possibilité de décrire les données à travers des ontologies et des standards ([DCMI-TERMS](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/), [BIBO](https://bibliontology.com/), [BIO](https://vocab.org/bio/), [FOAF](https://en.wikipedia.org/wiki/FOAF_(ontology)), [DOAP](https://lov.linkeddata.es/dataset/lov/vocabs/doap), [RDF](https://fr.wikipedia.org/wiki/Resource_Description_Framework), [SKOS](https://fr.wikipedia.org/wiki/Simple_Knowledge_Organization_System)),
- En exportant des données sous des formats ouverts et réexploitables par de nombreux autres logiciels ([CSV](https://fr.wikipedia.org/wiki/Comma-separated_values), [GEPHI](https://fr.wikipedia.org/wiki/Gephi), [XML](https://fr.wikipedia.org/wiki/Extensible_Markup_Language), [JSON](https://fr.wikipedia.org/wiki/JavaScript_Object_Notation), [GEOJSON](https://fr.wikipedia.org/wiki/GeoJSON), [KML](https://fr.wikipedia.org/wiki/Keyhole_Markup_Language), [IIIF](https://fr.wikipedia.org/wiki/International_Image_Interoperability_Framework), [MySQL](https://fr.wikipedia.org/wiki/MySQL)), 
- En liant les vocabulaires sur Heurist à des référentiels exposés sur le web à l'aide d'identifiants [URI](https://fr.wikipedia.org/wiki/Uniform_Resource_Identifier).
- En rendant accessibles et interopérables les données sur le web via la publication d'un site web ou la génération de *feeds* ou [flux web](https://fr.wikipedia.org/wiki/Flux_web)
- En permettant la récupération de données exportées depuis d'autres systèmes de gestion de base de données (par exemple Mysql, Filemaker ou Access) en s'appuyant sur des formats ouverts (CSV, XML)

Il permet donc :

- de construire des données compatibles avec le niveau 5 des *5 star data*,
- de générer des données réutilisables (critère R des principes FAIR),
- d'alimenter d'autres bases de données ou plateformes via l'utilisation de flux web ou d'exports en formats ouverts (critère I des principes FAIR),
- de publier les données sous forme de site web (critère A des principes FAIR) 

Il n'est pas:

- une plateforme de dépots d'archives ouvertes telles que [OpenAire](https://provide.openaire.eu/home), [Zenodo](https://zenodo.org/), [Nakala](https://documentation.huma-num.fr/nakala/) ou [HAL-SHS](https://halshs.archives-ouvertes.fr/) et qui répondent globalement à l'ensemble des critères FAIR.

<div class="alert alert-warning">
  Il paraît difficile de trouver un seul outil pour répondre à l'ensemble de ces principes. S'agissant, la plupart du temps, de données liées entre elles, sur internet, à travers l'utilisation de standards du web de données, l'utilisation d'un outil exclusif paraîtrait même paradoxal. De la même façon, chaque plateforme ne répond pas de la même manière à chaque critère. C'est, entre autres, le rôle d'un plan de gestion de données de définir quels outils, procédures ou plateformes seront utilisés pour gérer les données et de préciser les objectifs auxquels chacun répond. 
</div>

## Quelques éléments techniques

Heurist est un logiciel Open Source, il se base sur une infrastructure serveur de type [LAMP](https://fr.wikipedia.org/wiki/LAMP) très utilisée dans le développement web. 

Les chercheurs peuvent y avoir accès moyennant la création d'un compte sur [un serveur hébergeant Heurist](https://heuristnetwork.org/using-heurists-servers/).

Dans le cadre de cette leçon, nous utiliserons une instance hébergée par la [TGIR Huma-Num](https://www.huma-num.fr/) qui [met à disposition Heurist](https://heurist.huma-num.fr) pour la communauté de recherche en SHS.


<div class="alert alert-warning">
  L'utilisation d'un service mis en place ou hébergé par une [Très Grande Infrastructure de Recherche](https://www.enseignementsup-recherche.gouv.fr/fr/strategie-nationale-des-infrastructures-de-recherche-50288) (TGIR) spécialisée dans le domaine des SHS comme Huma-Num dans le cas présent, ou encore [Progedo](https://www.progedo.fr/), est un gage de sécurité pour le stockage et l'exposition des données de recherche dans le temps.
</div>

Pour les personnes souhaitant tester Heurist hors ligne, il est également possible d'héberger Heurist localement sur un ordinateur. Les informations pour son installation sont disponibles en anglais [sur le site officiel d'Heurist](https://heuristnetwork.org/installation/). 


<div class="alert alert-warning">
  Cette installation demande des compétences techniques minimales d'administration d'un serveur web pour pouvoir être effectuée.
</div>

Heurist s'appuie sur une conception [relationnelle](https://fr.wikipedia.org/wiki/Base_de_donn%C3%A9es_relationnelle) des données mais simplifie certains aspects de cette modélisation afin de faciliter son utilisation. Nous abordons brièvement quelques concepts clés du modèle relationnel dans la partie [**Modélisation des données**](#modelisation).



## Organisation de la leçon

Dans cette leçon, nous partirons d'un jeu de données brut, discuterons sa modélisation, répercuterons cette modélisation dans Heurist afin d'importer les données pour enfin les publier en ligne.

<div class="alert alert-warning">
   Cette leçon et les captures d'écran qu'elle contient ont été realisées en avril 2021 sur la version 6 d'Heurist (notée h6). Heurist évoluant constamment, ses fonctionnalités et son interface sont amenées à se modifier au fil du temps à travers de nombreuses sous-versions (par exemple h6.2.26 en janvier 2022). Dans la plupart des cas cela ne devrait pas gêner la compréhension des indications qui suivent, la logique fonctionnelle restant la même au sein de la version 6 du logiciel. Pour toutes questions ou interrogations il est possible de consulter la documentation en ligne (en anglais) sur le site officiel d'[Heurist](https://heuristnetwork.org/tutorials/) dans la rubrique *Learn* ou encore de demander de l'aide auprès d'autres usagers d'Heurist via la liste francophone [d'utilisateurs Heurist](https://groupes.renater.fr/sympa/subscribe/heurist-utilisateurs).   
</div>


## Données utilisées pour le cours

Nous utiliserons tout au long du cours le jeu de données de [*Localisation des sites de fouille archéologiques de l'INRAP*](https://www.data.gouv.fr/fr/datasets/localisation-des-sites-de-fouille-archeologiques-de-l-inrap-576210/), libre de droit et recensant 625 sites de fouilles en France.

<div class="alert alert-warning">
  Nous utilisons ces données archéologiques uniquement à titre d'exemple, pour illustrer le présent tutoriel. Heurist ayant une approche plutôt généraliste, il peut gérer des données archéologiques mais n'est pas un outil spécialisé à cette fin. Pour aller plus loin sur la gestion des données archéologiques, nous vous invitons à consulter, entre autres, les travaux du [Consortium MASA](https://masa.hypotheses.org/) ainsi que les outils qu'ils mettent à disposition de la communauté de recherche en archéologie et dont certains peuvent également servir pour d'autres disciplines en SHS.
</div>

Comme son nom l'indique, il localise des sites de fouilles archéologiques de l'[INRAP](https://www.inrap.fr/) et est enrichi d'informations de localisation précises comme:
- les coordonnées géographiques du site de fouille, 
- un nom de site, 
- des informations de localisation utilisant le découpage administratif français:
  * région
  * département
  * commune
- des données temporelles concernant l'intervention archéologique
- des thèmes et des périodes historiques relatifs à ce qui a été découvert sur le site  

Il s'agit d'un tableau de données [CSV](https://fr.wikipedia.org/wiki/Comma-separated_values) (format ouvert) dont les colonnes sont séparées par des points-virgules. Il peut être lu et édité avec un simple éditeur de texte ou un tableur.

Ces données, bien que relativement limitées et peu complexes, nous permettront d'utiliser les fonctionnalités de visualisation cartographique et chronologique de Heurist.
Comme nous le verrons plus loin, Heurist porte bien son nom, car il permet, par la visualisation et une exploration différente de ses données (notamment via des fonctionnalités de visualisation cartographiques et de graphes), de découvrir et de corriger très rapidement des erreurs ou encore d'approfondir une analyse. Ces données peuvent par la suite être exportées vers d'autres logiciels spécialisés comme par exemple [QGIS](https://fr.wikipedia.org/wiki/QGIS)[^QGIS] et [Gephi](https://fr.wikipedia.org/wiki/Gephi).

Il facilite également la recherche et la navigation dans les données à travers de nombreux filtres configurables à des fins de recherche individuelle, de travail collaboratif ou encore de diffusion à destination d'un plus large public. 

Pour les besoins de l'exercice et l'intégration correctes des données, certaines opérations de consolidation et de transformation ont été effectuées à l'aide de l'outil [Open Refine](https://programminghistorian.org/fr/lecons/nettoyer-ses-donnees-avec-openrefine) pour :

- la création de nouvelles colonnes **coordonnées décimales lat/long** et la conversion des coordonnées géospatiales, notées initialement en [Lambert 93](https://fr.wikipedia.org/wiki/Projection_conique_conforme_de_Lambert), en notation décimale latitude/longitude afin de permettre leur intégration dans Heurist et de les référencer précisément, indépendamment de la période concernée ou des évolutions toponymiques,
- l'ajout d’une colonne **Id** pour identifier de façon non ambiguë une intervention archéologique,
- le renommage de la colonne **nom de site** en **nom d’intervention** après avoir observé que les infromations qu'elle contenait pouvaient concerner des éléments autres que ceux du site proprement dit comme par exemple la date de l'intervention,
- la désambiguïsation des noms de site afin d’identifier un lieu d’intervention de façon unique en procédant à :
  * la création d'une nouvelle colonne **nom de site** à partir de la colonne **nom d'intervention**,
  * l'extraction d'informations, comme l'année d'intervention, relatives à l'intervention plutôt qu'au site,
  * l'homégénisation orthographique des noms de lieux possédant les mêmes coordonnées géographiques.
     

L'ensemble des données que nous utiliserons pour cette leçon sont à télécharger
[sur le répertoire github de l'auteur ](https://github.com/vpaillusson/tuto-heurist/raw/master/donnees_inrap.zip).


Vous y trouverez 4 fichiers:

- donnees_inrap_ph.csv
- periodes.csv
- themes.csv
- type_intervention.csv

Ces fichiers CSV contiennent les informations descriptives d'une intervention incorporant les modifications nécessaires à une intégration dans Heurist ainsi que la liste des termes décrivant les périodes, les thèmes et les types d'intervention telles qu'elles ont été définies dans le fichier source de l'INRAP. 



## <a name="modelisation"></a>Modélisation des données

Nous ne ferons pas un cours[^coursMerise] sur la modélisation relationelle des données, mais Heurist s'appuyant sur une conception relationnelle des données, il est important de rappeler certains éléments théoriques afin de comprendre son fonctionnement.

Cette modélisation relationnelle permet de garantir :

- **L'unicité de chaque enregistrement** : Un site archéologique ne sera renseigné qu'une seule fois dans la base de données. La création d'un doublon provoquera une erreur.

- **La non redondance des données saisies**: Si un site fait l'objet de plusieurs interventions archéologiques, il ne sera pas nécessaire de saisir à chaque fois les données le concernant.  De même, en cas de correction concernant ce site il suffira de ne la réaliser qu'une seule fois pour la voir répercutée sur toute la base.

{% include figure.html filename="introduction-a-heurist-2.png" caption=" Fig. 2. Modélisation de l'unicité. Image: Vincent Paillusson." %}



- **Une organisation structurée des connaissances** : <a name="vocabulaires1"></a>Les éléments d'une base de données sont organisés entre eux à travers des concepts descriptifs définis qui peuvent prendre la forme de [vocabulaires contrôlés](#vocabulaires2) ou d'[ontologies](https://fr.wikipedia.org/wiki/Ontologie_(informatique)). Cela permet une cohérence dans la manière de décrire les objets au sein d'une même base de données ou d'un collectif de travail. 

<div class="alert alert-warning">
	La conception intellectuelle d'une base de données fait partie intégrante de la réflexion scientifique. Elle doit être effectuée en amont de la modélisation dans Heurist et aura un impact significatif sur les résultats et analyses qui résulteront de son exploitation. Toutefois, Heurist apporte une aide non négligeable pour débuter dans la conception d'une base de données, en mettant à disposition un ensemble de types d'enregistrement qui peut servir de socle à un nombre important de base de données en SHS (cf. Fig. 3). Par ailleurs, Heurist offre une grande souplesse dans la conception et l'alimentation des bases de données qu'il héberge, offrant ainsi une fonctionnalité de type "bac à sable", permettant de faire et défaire au gré de l'évolution conceptuelle de la base de données.  
</div>

{% include figure.html filename="introduction-a-heurist-3.png" caption="Fig. 3. Types d'enregistrement proposés par Heurist pour toutes nouvelles bases de données. Image: Vincent Paillusson." %}

### Entités et champs

Ouvrez le fichier **donnees_inrap_ph.csv** avec le tableur de votre choix (par exemple Open Office Calc ou MS Excel). Ce tableau reprend les noms de colonnes du fichier CSV source de l'INRAP avec quelques colonnes supplémentaires nécessaires à l'import dans Heurist.
Les colonnes de ce tableau peuvent être regroupées en 2 types d'objets distincts :


{% include figure.html filename="introduction-a-heurist-4.png" caption="Tableau INRAP" %}


1. Localisation :
    - Nom du site
    - Coordonnées Lambert 93 X
    - Coordonnées Lambert 93 Y
    - Coordonnées décimales longitude
    - Coordonnées décimales latitude
    - Région 
    - Département
    - Commune

2. Intervention :
    - Id
    - Nom d'intervention
    - Date début
    - Date fin
    - Type d’intervention
    - Thèmes
    - Périodes


Nous appellerons ces objets des **entités**. Dans Heurist elles portent le nom de **types d'enregistrement** (*record types*). Les colonnes qui composent ces types d'enregistrement sont appelées **champs** (*fields*) dans Heurist.


{% include figure.html filename="introduction-a-heurist-5.png" caption="Fig. 5. Modélisation des entités et de leurs champs descriptifs. Image: Vincent Paillusson" %}


Dans notre exemple, Intervention serait donc un type d'enregistrement, tandis qu'une intervention précise, par exemple celle d'Id  **INRAPI0002**,  sera une instance de l'entité Intervention et sera appelée un **enregistrement** (*record* ) dans Heurist.


{% include figure.html filename="introduction-a-heurist-6.png" caption="Fig. 6. Modélisation des instances d'une entité. Image: Vincent Paillusson" %}


Parmi ses attributs chaque entité dispose d'un identifiant unique permettant d'y faire référence de façon non ambigüe.

Cet identifiant peut être un simple nombre incrémenté pour chaque occurrence de l'entité ou être construit de façon plus élaborée en fonction des besoins et du volume d'occurrences. 
Dans le cadre de nos données, l'attribut **Id** identifie une intervention de façon non ambiguë et  **nom de site** fait référence à une et une seule localisation.

En pratique nous pouvons donc générer un identifiant de deux façons:

- En le construisant de façon arbitraire pour la cohérence de notre modèle conceptuel (champ **Id**),
- En sélectionnant un attribut qui porte déjà ce rôle dans notre base de données (champ **nom de site**)



### Les relations

Les entités ne sont pas des objets isolés dans notre base de données. Au contraire, elles sont reliées entre elles afin de décrire des événements ou des objets complexes. Par exemple, étant donné que nous souhaitons conserver le lien entre un lieu et une opération archéologique spécifique, une intervention archéologique sera liée à une localisation. Nous verrons plus loin comment Heurist gère ce type de relations en pratique.


### Champs multivalués et cardinalité

Les cellules des colonnes **Thèmes** et **Périodes**, peuvent comporter plusieurs thèmes ou périodes séparés par le symbole « # ». Pour permettre l'interrogation de celles-ci de façon fine, nous devons les séparer tout en maintenant leur relation avec l'opération archéologique qu'elles décrivent.

Cela veut donc dire que l'intervention d'Id **INRAPI0002** sera reliée aux thèmes  
**Protohistoire** et **Antiquité** et non au thème **#Protohistoire#Antiquité**.


{% include figure.html filename="introduction-a-heurist-7.png" caption="Fig. 7. Modélisation des champs multivalués. Image: Vincent Paillusson" %}


Il faut indiquer quelque part dans notre modèle qu'une intervention peut avoir plusieurs thèmes. C'est la [cardinalité](https://fr.wikipedia.org/wiki/Cardinalit%C3%A9_(programmation)). Elle permet de préciser si l'entité décrite peut être reliée à d'autres entités ou encore si des informations descriptives du même type peuvent être répétées. Enfin elle détermine le caractère obligatoire ou optionnelle de cette relation. Elle répond aux questions du type : 

- Une intervention est-elle obligatoirement liée à un thème? (information descriptive)
- Une intervention est-elle liée à plusieurs thèmes? (information descriptive)
- Une intervention est-elle obligatoirement liée à un site? (relation à une autre entité)
- une intrevention est-elle liée à plusieurs sites? (relation à une autre entité)

Nous ne détaillerons pas ici la formalisation de la notation de ces cardinalités mais en pratique dans Heurist cela sera défini pour un champ donné par les paramètres *Repeatability* et *Requirement* :


{% include figure.html filename="introduction-a-heurist-8.png" caption="Fig. 8. Champs multivalués dans Heurist. Image: Vincent Paillusson" %}


### Vocabulaires contrôlés

Nous venons de rencontrer le cas des thèmes ou périodes qui pouvaient décrire une même intervention. De même, **Type d'intervention** fait référence à un vocabulaire, même si celui-ci compte uniquement deux termes.

<a name="vocabulaires2"></a>Nous avons déjà abordé rapidement ce point dans la partie sur la [cohérence des données](#vocabulaires1). 
Fonctionnellement, les [vocabulaires contrôlés](https://fr.wikipedia.org/wiki/Vocabulaire_contr%C3%B4l%C3%A9) s'opposent à une saisie textuelle libre.

Concrètement, il s'agit de lister, de catégoriser et hiérarchiser des concepts, en nombre fini, afin d'éviter certains biais courants lors des saisies textuelles libres tels que : 

- la cohérence orthographique (M ≠ m, Moyen-Âge ≠ Moyen Âge)
- la synonymie (habitats ≈ édifices ≈ architecture)
- l'inclusion (pratiques funéraires ⊆ cultes) 

L'utilisation de vocabulaires contrôlés permet d'optimiser les requêtes et l'analyse sur des données en : 

- réduisant le nombre de termes descriptifs (en supprimant les synonymies et en corrigeant les incohérences orthographiques), 
- en organisant hiérarchiquement les concepts (une requête pouvant par exemple se limiter à une branche hiérarchique au sein d'un même vocabulaire contrôlé).


C'est aussi une façon de se mettre d'accord, au sein d'un collectif de travail, sur une certaine description du monde comme le font les [*thesaurus*](https://fr.wikipedia.org/wiki/Th%C3%A9saurus_documentaire) ou les [ontologies](https://fr.wikipedia.org/wiki/Ontologie_(informatique)). 

Dans une optique de science ouverte, utiliser des vocabulaires partagés par une communauté scientifique plus large est également un gage d'interopérabilité et de compréhension mutuelle. 

Afin de gérer ces listes de termes, Heurist utilise des **vocabulaires** (*vocabularies*). Chaque **vocabulaire** (*vocabulary*) contient des **termes** (*terms*).

Heurist intègre nativement un certain nombre de vocabulaires, dont certains sont issus de standards du web de données et qui pourront être très utiles aux chercheurs en SHS. 

{% include figure.html filename="introduction-a-heurist-9.png" caption="Fig. 9. Vocabulaires contrôlés. Image: Vincent Paillusson" %}

Par ailleurs, Heurist propose un système de modèles préétablies de types d'enregistrement (*templates*), organisés thématiquement, et que n'importe quel utilisateur peut utiliser dans sa propre base via le mode *Design* (cf. Fig. 9b). C'est aussi une source d'inspiration très intéressante car, en plus des modèles proposés par Heurist, il est possible de consulter et d'importer des modèles de bases de données d'autres utilisateurs (cf. Fig. 9c).

{% include figure.html filename="introduction-a-heurist-9b.png" caption="Fig. 9. Modèles descriptifs intégrés à Heurist. Image: Vincent Paillusson" %}

{% include figure.html filename="introduction-a-heurist-9c.png" caption="Fig. 9. Importation d'un type d'enregistrement à partir d'un modèle. Image: Vincent Paillusson" %}

En complément d'Heurist, des outils comme [Opentheso](https://opentheso.hypotheses.org/), soutenu notamment par le Consortium MASA ou encore [Loterre](https://www.loterre.fr/), de l'INIST CNRS, peuvent être très utiles pour organiser ou consulter des thesaurus scientifiques mulitlingue et multi-hiérarchique compatibles conforme aux standards du web des données ouvertes. 



## Créer une base de données sur Heurist

Une fois ces quelques informations théoriques rappelées, nous pouvons passer à leur mise en pratique dans Heurist.


### Création d'un compte utilisateur

Rendez-vous sur l'instance d'[Heurist hébergée sur Huma-Num](https://heurist.huma-num.fr/) puis suivez les instructions pour créer un compte ainsi qu'une base de données.

Une fois connectés à cette nouvelle base vous êtes redirigés vers l'interface de Heurist.

{% include figure.html filename="introduction-a-heurist-10.png" caption="Fig. 10. Page d'accueil de Heurist. Image: Vincent Paillusson " %}

La colonne de navigation à gauche est organisée par groupes fonctionnels :

- **Explore** : Ce mode donne accès à la navigation dans les données. C'est la fonction clef de l'exploitation d'une base Heurist.
- **Design** : Ce mode permet la modélisation des données.
- **Populate** : Vous pourrez ajouter de nouveaux enregistrements dans ce mode.
- **Publish** : Vous pourrez gérer la publication de vos données en ligne via un site web ou une page dédiée.
- **Admin** : Vous pourrez gérer vos bases de données ainsi que les utilisateurs dans cette partie.

Une rubrique d'aide est accessible pour chaque mode via le ? entouré d'un cercle.


{% include figure.html filename="introduction-a-heurist-11.png" caption="Fig. 11. Aide Heurist. Image: Vincent Paillusson" %}


### Création de notre modèle de données

1. Cliquez sur **Design**.
2. Puis sur **Record types**.
3. Par défaut le premier groupe de types d'enregistrement est sélectionné.
4. Chaque type d'enregistrement est résumé sur une ligne dans la fenêtre de visualisation de droite.

{% include figure.html filename="introduction-a-heurist-12.png" caption="Fig. 12. Record types. Image: Vincent Paillusson" %}


#### Création de l'entité de localisation

Comme nous l'avons vu précédemment nous avons :

- 2 entités principales :
    - Localisation
    - Intervention
- 3 vocabulaires :
    - Thèmes
    - Périodes
    - Type d'intervention

Afin de mieux organiser les données, ajoutez un nouveau groupe de types d'enregistrement en cliquant sur **add** et nommez-le **INRAP**.


{% include figure.html filename="introduction-a-heurist-13.png" caption="Fig. 13. Record types group. Image: Vincent Paillusson " %}


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
    Même si nous avons converti les coordonnées géographiques en notation décimale afin de les intégrer dans Heurist nous conservons les données Lambert 93 sous forme de champ texte afin de garder trace de ces données initiales.
</div>


Ajoutez un type d'enregistrement pour définir l'entité de localisation.

1. Cliquez sur **add**.
2. Dans la fenêtre vous prévenant que vous pouvez importer des *record type* existants cliquez sur **continue**.


{% include figure.html filename="introduction-a-heurist-14.png" caption="Fig. 14. Ajout d'un record type. Image: Vincent Paillusson" %}


Remplissez les informations concernant le type d'enregistrement de localisation auquel vous donnerez le nom de **Site**.


{% include figure.html filename="introduction-a-heurist-15.png" caption="Fig. 15. Entité de localisation. Image: Vincent Paillusson" %}


Il vous est ensuite demandé de choisir le champ par défaut de ce type d'enregistrement. Laissez le choix par défaut et continuez.

Dans Heurist, chaque champ est décrit à l’aide des informations suivantes :

-	Un nom
-	Un type de donnée :
    - Texte libre
    - Liste de vocabulaires
    - Information geospatiale
    - Zone de texte
-	Une taille (*field width*) : une limite dans le nombre de caractères du formulaire de saisie
-	Un statut :
    - Caché (grisé)
    - Optionnel
    - Obligatoire (génère une erreur si l'information n'est pas remplie)
    - Recommandé
-	Une répétabilité : une seule ou plusieurs occurrences de ce champ (par exemple il peut y avoir plusieurs thèmes ou périodes pour une même intervention)

Renommez le champ **name/title** par défaut en **nom du site**. Conservez les autres paramères avec leur par défaut (*required*, *single*, *field width*).


{% include figure.html filename="introduction-a-heurist-16.png" caption="Fig. 16. Champ nom du site. Image: Vincent Paillusson" %}


Il y a cinq autres champs textuels dans notre type d'enregistrement.
Nous allons en créer un ensemble et vous pourrez créer les autres vous-mêmes en suivant la même procédure.

Cliquez sur **Insert field**.


{% include figure.html filename="introduction-a-heurist-17.png" caption="Fig. 17. Insertion d'un champ. Image: Vincent Paillusson" %}


Remplissez les éléments obligatoires en rouge:

- Field name
- Help text
- Data type

Sélectionnez le **type de donnée** (*data type*) => *text single line* car il correspond aux champs textuels attendus.


{% include figure.html filename="introduction-a-heurist-18.png" caption="Fig. 18. Champ Lambert 93 X. Image: Vincent Paillusson" %}


Gardez les autres valeurs par défaut et sauvegardez.

Répétez la même opération pour les champs:

- Coordonnées Lambert 93 Y
- Région
- Département
- Commune

Cela vous donne l'organisation suivante:


{% include figure.html filename="introduction-a-heurist-19.png" caption="Fig. 19. Champ textuel. Image: Vincent Paillusson" %}


Il ne reste que les informations géoréférencées. La démarche sera la même, seul le type de donnée sera différent. Le type geospatial de Heurist prend des données en format lat/long, un seul champ permettra donc d'intégrer les deux valeurs latitude et longitude de notre fichier CSV :


{% include figure.html filename="introduction-a-heurist-20.png" caption="Fig. 20. Champ géoréférencé. Image: Vincent Paillusson" %}


Ajoutez le champ suivant avec le type de donnée suivant:

- Coordonnées décimales

La création de l'ensemble des champs du type d'enregistrement **Site** est ainsi terminée.


{% include figure.html filename="introduction-a-heurist-21.png" caption="Fig. 21. Ensemble des champs du type d'enregistrement Site. Image: Vincent Paillusson" %}


#### Création des vocabulaires

1. Cliquez sur **vocabularies**.
2. La 2e colonne en partant de la gauche liste les catégories ou groupes de vocabulaires. Par défaut elle se trouve sur la catégorie **User-defined**.
3. La colonne suivante liste les vocabulaires de ce groupe. Ici voys voyez deux vocabulaires :
    - Country
    - Place type
4. Enfin, la partie la plus à droite liste l'ensemble des termes de ce vocabulaire.


{% include figure.html filename="introduction-a-heurist-22.png" caption="Fig. 22. Vocabulaires. Image: Vincent Paillusson" %}



Le groupe **user-defined**  convient bien, vous allez donc créer les 3 vocabulaires dans celui-ci en cliquant sur **add**.


{% include figure.html filename="introduction-a-heurist-23.png" caption="Fig. 23. Ajouter un vocabulaire. Image: Vincent Paillusson" %}



1. Renseignez le label : **Thèmes**  ainsi qu'une courte description.
2. Il est également possible d'ajouter une URI relative à un terme de vocabulaire ou d'une ontologie. Ce n'est pas nécessaire dans le cas présent.
3. Sauvegardez.

Une fois le vocabulaire créé, plusieurs fonctionnalités sont disponibles:

1. Ajouter un terme de vocabulaire manuellement
2. Ajouter une liste de termes par référence à un autre vocabulaire
3. Exporter les termes
4. Importer les termes


{% include figure.html filename="introduction-a-heurist-24.png" caption="Fig. 24. Editer un vocabulaire. Image: Vincent Paillusson" %}


Pour ne pas avoir à saisir manuellement les termes de vocabulaires, vous allez utiliser la fonctionnalité d'import proposée par Heurist pour intégrer les contenus des fichiers *periodes.csv*, *themes.csv* et *type_intervention.csv* téléchargés en début de leçon.

Cliquez sur **Import**.

1. Copiez et collez la liste des thèmes du  fichier *themes.csv* du zip que vous venez de télécharger dans la fenêtre prévue à cet effet en étape 1.
2. Cochez la case **Labels in line 1** puis cliquez sur **Analyse**.
3. Vérifiez que la liste importée ne présente pas d’erreur.
4. Vérifiez que *Term (label)* est bien rempli avec le nom du vocabulaire (ici **Thèmes**) et cliquez sur **Import**.


 {% include figure.html filename="introduction-a-heurist-25.png" caption="Fig. 25. Import des thèmes INRAP dans Heurist. Image: Vincent Paillusson" %}

Suivez exactement la même opération que précédemment avec le vocabulaire **Périodes** en utilisant le fichier *periodes.csv*.

Pour **Type d'intervention**, la liste ne contenant que deux termes (Diagnostic et Fouille), vous pouvez soit réitérer la même opération, soit les insérer manuellement un par un en cliquant sur **Add** dans le vocabulaire **Type d'intervention** que vous aurez créé.

 {% include figure.html filename="introduction-a-heurist-26.png" caption="Fig. 26. Liste des vocabulaires. Image: Vincent Paillusson" %}


#### Création de l'entité **Intervention**


1. Retournez sur Record-Type > INRAP
2. Pour ajouter un type d'enregistrement, cliquez sur **add** comme précédemment avec le type d'enregistrement **Site**.


 Sélectionnez les champs par défaut pour notre entité : **Name/title**, **start date**, **end date**.


 {% include figure.html filename="introduction-a-heurist-27.png" caption="Fig. 27. Entité Intervention. Image: Vincent Paillusson " %}


 Pour rappel, nous avons besoin des champs suivants:

- Intervention :
    - Identifiant d'intervention
    - Nom d'intervention
    - Date de début
    - Date de fin
    - Type d’intervention -> se réfère au vocabulaire du même nom
    - Thèmes -> se réfère au vocabulaire du même nom
    - Périodes -> se réfère au vocabulaire du même nom
    - Localisation -> se réfère a l'entité du même nom

Renommez les champs comme suit:

- Name/title => **Identifiant d'intervention**
- Start date => **Date de début**
- End date => **Date de fin**


 {% include figure.html filename="introduction-a-heurist-28.png" caption="Fig. 28. Renommage des champs par défaut. Image: Vincent Paillusson" %}


Vous allez ajouter les 3 champs de vocabulaires contrôlés.

1. Cliquez sur **insert**.
2. Renseignez le label du champ ainsi que sa description et sélectionnez le type de champ.
3. Par défaut, **dropdown (terms)** est sélectionné. Cliquez sur **use this field type**.


 {% include figure.html filename="introduction-a-heurist-29.png" caption="Fig. 29. Ajout d'un champ de vocabulaire. Image: Vincent Paillusson" %}


Enfin, sélectionnez le vocabulaire **Thèmes**, rendez le répétable et sauvegardez.


 {% include figure.html filename="introduction-a-heurist-30.png" caption="Fig. 30. Ajout du champ Thèmes. Image: Vincent Paillusson" %}


Effectuez la même opération pour **Périodes** et **Type d'intervention** à la seule différence que Type d'intervention ne sera pas répétable.

Ajoutez maintenant la référence à **Site** en sélectionnant le *data type*  **Record pointer**.


 {% include figure.html filename="introduction-a-heurist-31.png" caption="Fig. 31. Ajout du champ Site. Image: Vincent Paillusson" %}


Pour finaliser la création de ce champ, sélectionnez le type d'enregistrement que nous souhaitons référencer. Sélectionnez le type d'enregistrement **Site** dans le groupe de types d'enregistrement **INRAP**.


 {% include figure.html filename="introduction-a-heurist-32.png" caption="Fig. 32. Sélection de l'entité Site. Image: Vincent Paillusson" %}



Pour terminer, ajoutez le champ **Nom de l'intervention** qui sera de type *text single line*  en suivant la même procédure que pour les champs textuels du type d'enregistrement **Site**.

Vous obtenez une type d'enregistrement **Intervention** composée des champs ci-dessous :


{% include figure.html filename="introduction-a-heurist-33.png" caption="Liste des champs de l'entité Intervention" %}


## Importer des données dans Heurist

### Import des données de localisation

Le modèle Heurist est terminé, vous allez pouvoir l'alimenter avec les données INRAP à votre disposition.
Pour ce faire, nous allons changer de mode et passer dans la fonctionnalité **Populate**.


{% include figure.html filename="introduction-a-heurist-34.png" caption="Fig. 34. Mode Populate. Image: Vincent Paillusson" %}



Comme son nom l'indique, ce mode regroupe les fonctionnalités permettant d'alimenter le modèle que nous avons élaboré dans la partie **Design**.

Dans ce mode nous pouvons :

- Ajouter un enregistrement individuel,
- Effectuer des imports en lots *via* des fichiers structurés au format CSV, HML (Heurist XML).
- Effectuer une synchronisation avec une collection [Zotero](https://fr.wikipedia.org/wiki/Zotero).

Dans notre cas, le fichier source étant un fichier CSV, cliquez sur **Delimited text/ CSV**.


{% include figure.html filename="introduction-a-heurist-35.png" caption="Fig. 35. Import CSV. Image: Vincent Paillusson" %}



Cliquez sur **Upload file** et chargez le fichier **donnees_inrap_ph.csv** téléchargé en début de leçon.


{% include figure.html filename="introduction-a-heurist-36.png" caption="Fig. 36. Chargement du fichier CSV. Image: Vincent Paillusson" %}

<div class="alert alert-warning">
    Le même fichier source nous permet de créer les enregistrements de type **Site** et **Intervention** en ne sélectionnant, pour chaque import, que les champs qui nous intéresse pour un type d'enregistrement donné.
</div>


1. Conservez les 4 premiers paramètres par défaut et modifiez **Multivalue separator**  en **#** via la liste déroulante afin de séparer les occurrences multiples de périodes et de thèmes telles qu'elles sont représentées dans notre fichier CSV.

2. Cliquez sur **Analyse data** pour afficher une visualisation des données, vérifiez qu’elles sont correctement interprétées et cliquez sur **Continue** (cf. Fig. 37).

3. Dans **select record type**, choisissez **Site** et cliquez sur **OK** (cf. Fig. 38).

{% include figure.html filename="introduction-a-heurist-37.png" caption="Fig. 37. Analyse du fichier CSV. Image: Vincent Paillusson" %}


{% include figure.html filename="introduction-a-heurist-38.png" caption="Fig. 38. Sélection de l'entité à alimenter. Image: Vincent Paillusson" %}


Une fois les données analysées et chargées dans Heurist, la première étape consiste à vérifier si des enregistrements de type **Site** existent déjà dans le système. Heurist effectue une recherche via un ou des champs que vous pouvez sélectionnez lors de la procédure d'import (par exemple un champ de type identifiant n'amenant pas d'ambiguïté). Si Heurist trouve des valeurs dans sa base correspondant à celles présentes dans le fichier CSV, il les met à jour si nécessaire ou bien les créé s'ils ne trouve rien.

Pour ce faire : 

1. Cochez la case **Nom du site** dans la colonne de gauche correspondant aux données du fichier CSV et sélectionnez **Nom du site** dans la colonne correspondant au type d'enregistrement **Site** dans Heurist.
2. Cliquez sur  **Match against existing records**.


{% include figure.html filename="introduction-a-heurist-39.png" caption="Fig. 39. Correspondance avec des enregistrements existants. Image: Vincent Paillusson" %}


La deuxième étape consiste à indiquer à Heurist quelle colonne du tableau va renseigner quel champ dans le type d'enregistrement Site. Il suffit donc de cocher les cases des colonnes à importer et de renseigner dans la colonne de droite à quels champs elles correspondent:

1. Cochez les champs du fichier CSV à importer et sélectionnez en face les champs qu'ils doivent alimenter.
2. Vous pouvez visualiser et naviguer dans les enregistrements qui vont être créés dans la colonne de droite.
3. Cliquez sur **prepare** puis **start insert**.


{% include figure.html filename="introduction-a-heurist-40.png" caption="Fig. 40. Insertion des données CSV. Image: Vincent Paillusson" %}


L'ensemble des entrées ont été créées et une fenêtre de résumé vous indique les opérations effectuées :


{% include figure.html filename="introduction-a-heurist-41.png" caption="Fig. 41. Résumé des opérations effectuées. Image: Vincent Paillusson" %}


<div class="alert alert-warning">
    Nous voyons que le fichier contient 625 lignes mais que seules 609 localisations seront créées. S'agissant d'un tableau recensant les interventions, cela vient du fait que plusieurs interventions se sont déroulées dans le même lieu. Il y a donc moins de lieux que d'interventions.
</div>


### Import des données relatives aux interventions sur site

Après avoir chargé nos données de localisation il nous reste à importer les interventions.
Pour ce faire:

Cliquez sur **back to Start** pour retourner au chargement du fichier CSV.


{% include figure.html filename="introduction-a-heurist-42.png" caption="Fig. 42. Retour au chargement du fichier. Image: Vincent Paillusson" %}


Pour finir ce projet, nous devons charger le reste des données liées aux interventions. Pour ce faire, nous allons effectuer les mêmes opérations de chargement du fichier que précédemment.

Arrivés à **select record type**, choisissez cette fois-ci **Intervention**, cochez la case **Site** pour gérer les dépendances entre les enregistrements puis validez.



{% include figure.html filename="introduction-a-heurist-43.png" caption="Fig. 43. Sélection de l'entité Intervention pour import. Image: Vincent Paillusson" %}


Comme à chaque import, Heurist vérifie d'abord si des enregistrements existent déjà. Sachant qu'une Intervention est liée à un Site, Heurist vérifie en premier si les sites qui sont dans le fichier CSV sont déjà présents dans la base de données. Il faut donc faire correspondre le champ **Nom du site** du fichier CSV avec le champ **Nom du site** du type d'enregistrement Site dans Heurist.


{% include figure.html filename="introduction-a-heurist-44.png" caption="Fig. 44. Correspondance avec des sites déjà présents dans la base de données. Image: Vincent Paillusson" %}


Heurist vérifie les éléments et, chose relativement classique, le fichier source n'étant pas parfait, trouve des doublons dans les noms de site et propose de nous aider à lever les ambiguïtés.

En l'occurrence, il s'agit de la même chaîne de caractères mais avec une majuscule à l'initiale pour un site et sans majuscule pour l'autre.

1. Cliquez sur **Resolve ambiguous matches**.
2. Vérifiez les enregistrements déjà intégrés dans la base de données .
3. Puis alignez les enregistrements avec les données trouvées dans le fichier CSV.


{% include figure.html filename="introduction-a-heurist-45.png" caption="Fig. 45. Résolution des ambiguïtés. Image: Vincent Paillusson" %}


Une fois les doublons résolus, nous effectuons la même opération pour les interventions.


{% include figure.html filename="introduction-a-heurist-46.png" caption="Fig. 46. Correspondance avec des interventions déjà présentes dans la base de données. Image: Vincent Paillusson" %}


Renseignez ensuite les champs d'Intervention que vous souhaitez remplir *via* votre fichier CSV, avant de valider la préparation et de finir l’import.


{% include figure.html filename="introduction-a-heurist-47.png" caption="Fig. 47. Import des données d'Intervention. Image: Vincent Paillusson" %}


Une fenêtre vous indique l'insertion de 625 nouveaux enregistrements.


{% include figure.html filename="introduction-a-heurist-48.png" caption="Fig. 48. Résumé des opérations d’import des données relatives aux interventions. Image: Vincent Paillusson" %}


## Explorer et éditer les données


### Explorer et éditer les données de localisation

L'onglet **Explore** présente un panel de fonctionnalités permettant d'explorer et filtrer les données chargées dans la base Heurist.

Pour afficher les sites que vous venez d'importer:
Cliquez sur **Explore** dans la colonne de gauche, placez votre curseur sur **Entities** puis sélectionnez Site.

{% include figure.html filename="introduction-a-heurist-49.png" caption="Fig. 49. Repasser en mode Explore. Image: Vincent Paillusson" %}

{% include figure.html filename="introduction-a-heurist-50.png" caption="Fig. 50. Afficher les enregistrements. Image: Vincent Paillusson" %}


Les sites sont listés par leur identifiant Heurist (H-ID), ce qui donne un label du type *Record 1250*.
Nous allons voir comment modifier ce label peu intelligible un peu plus loin dans la leçon.

<div class="alert alert-warning">
    Nous pouvons également vérifier que le nombre d'enregistrements chargés correspond bien à ce qui est attendu: ici 609.
</div>



En cliquant sur un enregistrement, les données le concernant apparaissent dans le volet de visualisation de droite, y compris la relation avec une intervention archéologique.

Par défaut le mode **Record View** est sélectionné. Il affiche l'ensemble des informations d'un enregistrement  et donne accès à son édition.


{% include figure.html filename="introduction-a-heurist-51.png" caption="Fig. 51. Afficher le détail d'un enregistrement. Image: Vincent Paillusson" %}



D'autres options de visualisation sont disponibles:


- **Map-Timeline** : permet une visualisation spatiale et temporelle des données


{% include figure.html filename="introduction-a-heurist-52.png" caption="Fig. 52. Visualisation cartographique. Image: Vincent Paillusson " %}

<div class="alert alert-warning">
    Nous observons déjà que certaines données semblent manifestement erronnées, se situant au Mali pour un site ou près des côtes africaines pour deux autres. Le rôle de la visualisation des données spatiales à des fins correctives est ici évident. Nous verrons comment corriger ce type d'erreur un peu plus tard.
</div>



{% include figure.html filename="introduction-a-heurist-53.png" caption="Fig. 53. Visualisation des erreurs de coordonnées géographiques. Image: Vincent Paillusson" %}


- **List view**: permet de lister les enregistrements sous forme de tableau et de les exporter notamment en PDF et EXCEL.


{% include figure.html filename="introduction-a-heurist-54.png" caption="Fig. 54. Liste des enregistrements. Image: Vincent Paillusson" %}


- **Custom reports** (pour utilisateurs plus avancés) : permet de gérer la mise en page des résultats d'une requête à l'aide de [*templates*](https://fr.wikipedia.org/wiki/Template_(programmation)) gérés par le moteur [PHP](https://fr.wikipedia.org/wiki/PHP) [Smarty](https://fr.wikipedia.org/wiki/Smarty)[^Smarty]. La page ainsi générée peut ensuite être mise en ligne.


{% include figure.html filename="introduction-a-heurist-55.png" caption="Fig. 54. Personnalisation de l'affichage d'un enregistrement. Image: Vincent Paillusson" %}


- **Export**: permet l'export de l'ensemble des résultats de la requête en cours sous différents formats pouvant être réutilisés par d'autres logiciels ([CSV](https://fr.wikipedia.org/wiki/Comma-separated_values), [GEPHI](https://fr.wikipedia.org/wiki/Gephi), [XML](https://fr.wikipedia.org/wiki/Extensible_Markup_Language), [JSON](https://fr.wikipedia.org/wiki/JavaScript_Object_Notation), [GEOJSON](https://fr.wikipedia.org/wiki/GeoJSON), [KML](https://fr.wikipedia.org/wiki/Keyhole_Markup_Language), [IIIF](https://fr.wikipedia.org/wiki/International_Image_Interoperability_Framework)).


{% include figure.html filename="introduction-a-heurist-56.png" caption="Fig. 56. Formats d'export. Image: Vincent Paillusson" %}


Les deux fonctionnalités qui suivent servent à visualiser des relations entre enregistrements.

- **Network diagram**: affiche un diagram montrant les liens entre les enregistrements.

- **Crosstabs**: permet d'effectuer des requêtes croisées sur les données.

### Modifier / Editer les données

Nous avons vu précédemment que certaines données géographiques ne semblaient pas correctes.

Cliquez sur l’onglet **Map-Timeline** pour visualiser l’ensemble des sites géolocalisés.

En cliquant sur le drapeau d'un site sur la carte vous pouvez afficher, à l'aide d'une fenêttre secondaire (*popup*), l'ensemble des informations concernant cette enregistrement. Ici, cliquez sur le site situé au Mali. Le nom du site apparaît sous dans uen nouvelle fenêtre et l'enregistrement correspondant est automatiquement sélectionné.

Directement depuis cette fenêtre passez en mode édition, en cliquant sur l’icône du crayon, pour corriger les informations liées à cet enregistrement.


{% include figure.html filename="introduction-a-heurist-57.png" caption="Fig. 57. Édition des coordonnées du site de Boulazac. Image: Vincent Paillusson" %}


Pour éditer ou entrer une donnée GPS, Heurist propose 2 solutions:

1. rechercher dans la base de données d'OpenStreetMap un nom de lieu et lui attribuer un marqueur de point permettant de définir ses coordonnées.
2. insérer les coordonnées, qui auront été récupérées par le moyen de votre choix, directement.

**Option 1**

1. Cliquez sur le champ de saisie de **Coordonnées GPS**.
2. Dans la fenêtre qui s'ouvre effectuez une recherche sur Boulazac dans la base d'[OpenStreetMap](https://www.openstreetmap.fr/)(cf. Fig. 58).
3. Le site est trouvé sur OpenStreetMap. Il faut y adjoindre un marqueur pour enregistrer les coordonnées du point dans Heurist.
4. Cliquez sur le marqueur et déplacez-le jusque sur le pointeur du site trouvé via le moteur de recherche, puis sauvegardez (cf. Fig. 59).


{% include figure.html filename="introduction-a-heurist-58.png" caption="Fig. 58. Recherche des coordonnées GPS de Boulazac. Image: Vincent Paillusson" %}


{% include figure.html filename="introduction-a-heurist-59.png" caption="Fig. 59. Validation des coordonnées GPS à l'aide du marqueur. Image: Vincent Paillusson" %}


**Option 2**

1. Cliquez sur le champ de saisie de **Coordonnées GPS**.
2. puis sur  **Add Geometry** dans la colonne de droite de la carte.
3. Insérez les coordonnées dans le format indiqué, par exemple ici pour un simple point la syntaxe est la suivante : **0.7679869062166365 45.178199165946225** et sauvegardez les modifications.


{% include figure.html filename="introduction-a-heurist-60.png" caption="Fig. 60. Renseigner les coordonnées manuellement. Image: Vincent Paillusson" %}


Afin de vérifier que les modifications des coordonnées GPS ont bien été prises en compte nous allons utiliser l'assistant de filtre :

1.	Ajouter un filtre.
2.	Dans la fenêtre de paramètres qui s’ouvre saisissez les informations nécessaires pour trouver notre enregistrement.
3.	Filtrez.


{% include figure.html filename="introduction-a-heurist-61.png" caption="Fig. 61. Rechercher un enregistrement en filtrant les données. Image: Vincent Paillusson" %}


Un seul élément est trouvé et vous pouvez observer que la modification du lieu a bien été effectuée.


{% include figure.html filename="introduction-a-heurist-62.png" caption="Fig. 62. Vérification de l’enregistrement de la modification cartographique. Image: Vincent Paillusson" %}

<div class="alert alert-warning">
    Il peut être utile de rafraichir la page web en cours de visualisation (**CTRL + R** ou **F5**) pour regénérer complètement la page en cours et ainsi visualiser certaines modifications.
</div>



### Modifier l'étiquette des enregistrements

Nous avons trouvé Boulazac mais son étiquette (*title mask*) dans la liste des enregistrements est toutefois peu intelligible.

Nous pouvons l'éditer depuis n'importe quel enregistrement.

Dans le fenêtre d'édition d'un Site, cliquez sur **Edit title mask**.


{% include figure.html filename="introduction-a-heurist-63.png" caption="Fig. 63. Modification de l'étiquette d'un type d'enregistrement. Image: Vincent Paillusson" %}


1. Sélectionnez le ou les champs que vous souhaitez afficher dans la colonne de gauche.
2. Cliquez sur **Insert field** et agencez les comme vous le souhaitez dans le champ texte.
3. Sélectionnez des enregistrements et testez l'étiquette ainsi générée.
4. Sauvegardez les modifications.


{% include figure.html filename="introduction-a-heurist-64.png" caption="Fig. 64. Edition de l'étiquette. Image: Vincent Paillusson" %}


Rafraichissez de nouveau la page (CTRL+R ou F5) et visualisez les modifications apportées.

Vous savez donc maintenant comment consulter vos données, les modifier et visualiser à la volée les corrections ou ajouts effectués.

### Utilisation des filtres

Toujours en mode **Explore**, si le dernier filtre que nous avons inséré est toujours actif, utilisez le filtre par entité dans la colonne de gauche pour n'afficher que les entités de type **Intervention**.


{% include figure.html filename="introduction-a-heurist-65.png" caption="Fig. 65. Lister les interventions. Image: Vincent Paillusson" %}


Comme avec les données de localisation, nous pouvons visualiser les informations de chaque intervention dans la fenêtre de visualisation via l'onglet **record view**.

Nous observons que les valeurs des champs multivalués comme thèmes et périodes sont correctement séparées, le nom du site apparaît bien comme un élément lié et en cliquant dessus une fenêtre secondaire affiche les données le concernant.


{% include figure.html filename="introduction-a-heurist-66.png" caption="Fig. 66. Visualiser le détail d'une intervention. Image: Vincent Paillusson" %}


En revanche, si vous tentez de visualiser les informations géographiques liées à une intervention via le mode **map timeline**, cela ne fonctionne pas. Seules les informations temporelles de chaque intervention apparaissent.

En effet, actuellement la requête de filtre ne demande que d'afficher les interventions et de récupérer les données qui y sont directement attachées. En revanche il n'a pas encore été demandé à Heurist de récupérer le détail des informations géographiques liées à chaque intervention.

Pour enrichir notre requête nous allons créer un filtre spécifique :

1. Cliquez sur **save filter**.
2. Renseignez le nom et le type d'enregistrement filtré par défaut (cf. Fig. 67).
3. Editez la règle qui permet de remonter les informations de localisation via la relation de **record pointer** entre Intervention et Site, puis sauvegardez la règle et le filtre.


<div class="alert alert-warning">
    Si vous avez déjà effectué un filtre par exemple pour visualiser des interventions alors la requête textuelle sera déjà préremplie ici. Dans l'exemple qui nous concerne *t:55*  se lit comme *affiche moi l'ensemble des enregistrements pour le type d'enregistrement qui a pour identifiant Heurist (H-ID) 55*.
</div>

{% include figure.html filename="introduction-a-heurist-67.png" caption="Fig. 67. Création d'un filtre avancé. Image: Vincent Paillusson" %}
{% include figure.html filename="introduction-a-heurist-68.png" caption="Fig. 68. Afficher les informations du *record pointer* site. Image: Vincent Paillusson" %}


Lorsque vous sélectionnez le filtre que vous venez de créer dans la rubrique **Saved filters > My filters** vous pouvez maintenant visualiser directement les données spatiales attachées aux interventions.


{% include figure.html filename="introduction-a-heurist-69.png" caption="Fig. 69. Visualisation des informations spatiales. Image: Vincent Paillusson" %}



## Mettre en ligne les données gérées dans Heurist

Les opérations de modélisation, de visualisation et d'édition offrent les outils pour gérer ses données de recherche. Elles oeuvrent également à préparer le partage des données avec des collaborateurs ou encore à les publier auprès d’un public plus large .

Heurist propose plusieurs fonctionnalités de mise en ligne :

- La création d'un filtre de visualisation à facettes qui sera intégré dans une page web hébergée sur un autre site (Wordpress, Drupal, etc.),
- La création d'une page web directement dans Heurist,
- La génération d'un site web complet avec gestion du contenu des pages et personnalisation de l'affichage.

Ces solutions s'appuient sur la création préalable d'un filtre (que nous venons de décrouvrir) ou d'une recherche à facettes.

<div class="alert alert-warning">
  Les filtres ainsi que les recherches à facettes peuvent être sauvegardés dans d'autres **workgroups** que **My filters** les rendant ainsi accessibles à d'autres utilisateurs membres de ces groupes de travail.
</div>



### Création d'un filtre de recherche à facettes

1. Sélectionnez l'éditeur de filtre à facettes dans les fonctionnalités du mode **Explore**.
2. Dans la fenêtre de paramètres du filtre, remplissez les champs pour indiquer que le filtre porte sur le type Intervention et que l’affichage des champs doit se faire sous forme de ligne (cf. Fig. 70).
3. Comme pour le filtre de recherche, éditez la règle qui permet de de remonter aux informations de localisation *via* la relation de *record pointer* entre Intervention et Site, puis sauvegardez la règle et validez.
4. Sélectionnez les champs sur lesquels vous souhaitez pouvoir effectuer des requêtes. Nous pouvons ici sélectionner les attributs de l’entité Intervention mais également ceux de l’entité Site, du fait des données liées (cf. Fig. 71).

{% include figure.html filename="introduction-a-heurist-70.png" caption="Fig. 70. Création d’un filtre de recherche à facettes. Image: Vincent Paillusson" %}

{% include figure.html filename="introduction-a-heurist-71.png" caption="Fig. 71. Construction du filtre de recherche à facettes . Image: Vincent Paillusson" %}


Une fois les critères de filtre validés, une nouvelle fenêtre permet de personnaliser la manière de présenter les champs de recherche à facettes . Plusieurs possibilités sont offertes selon l’utilisation souhaitée et ce, pour chaque champ/critère retenu :

 - **List** : présente une liste de l'ensemble des valeurs possibles d'un champ avec leur nombre d'occurrences.
 - **Wrapped** : présente l'ensemble des valeurs d'un champ sous une forme plus concise.
 - **Search** : permet la recherche par simple saisie textuelle.
 - **Slider**: permet la navigation temporelle à l'aide de curseurs.
 - **Dropdown**: propose une liste sous forme de liste déroulante.

Par défaut tous les champs textuels proposent une recherche par saisie textuelle. Lorsque le nombre de termes le permet, il est possible de proposer une liste ou une présentation plus concise. Modifiez les étiquettes pour les champs liés aux sites, conservez l'affichage par défaut pour chaque champ et validez.


{% include figure.html filename="introduction-a-heurist-72.png" caption="Fig. 72. Modes d'affichage des filtres de champs. Image: Vincent Paillusson" %}


Pour visualiser le résultat de notre filtre :

1. Rendez-vous sur les filtres sauvegardés (*saved filters*) dans Explore ou bien dans **saved filters** au bout de la barre de filtre.
2. Puis sélectionnez le filtre à facettes que nous venons de créer.


{% include figure.html filename="introduction-a-heurist-73.png" caption="Fig. 73. Sélection du filtre à facettes précédemment créé . Image: Vincent Paillusson" %}



{% include figure.html filename="introduction-a-heurist-74.png" caption="Fig. 74. Visualisation de la recherche à facettes. Image: Vincent Paillusson" %}



### Création d'une page web

Pour créer une page web dédiée et personnalisable:

1. Passez en mode **Publish**.
2. Sélectionnez *standalone web page*.
3. Renseignez le nom de votre choix et validez.


{% include figure.html filename="introduction-a-heurist-75.png" caption="Fig. 75. Création d'une page web. Image: Vincent Paillusson" %}


Dans la colonne de gauche, cliquez sur **Edit layout**.


{% include figure.html filename="introduction-a-heurist-76.png" caption="Fig. 76. Éditer la disposition de la page web. Image: Vincent Paillusson" %}


La fenêtre d'édition est composée de plusieurs parties :

1. Une barre de menu vous permettant d'ajouter des widgets, d'ajouter des images ou d'éditer le contenu textuel de votre page.
2. Un contenu textuel par défaut donnant quelques indications. Il sera remplacé par tout contenu de votre choix.
3. Un widget de recherche. Ce widget affiche un filtre à facettes sélectionné précédemment dans Heurist afin d'effectuer des requêtes sur nos données. Les autres widgets affichent les résultats des requêtes effectuées à travers le premier widget de recherche.
4. Une carte géoréférencée.
5. Une liste des enregistrements.


{% include figure.html filename="introduction-a-heurist-77.png" caption="Fig. 77. Organisation des éléments de la page web. Image: Vincent Paillusson" %}


Commençons par le plus important: alimenter la recherche avec le filtre à facettes que nous avons créé.

1. Éditez le widget de recherche.
2. Vérifiez que le groupe de travail sélectionné possède bien le filtre que vous avez créé précédemment (ici, par exemple c'est le groupe de travail **Website filters**).
3. Sélectionnez le filtre à facettes (cf. Fig. 78).
4. Sauvegardez et validez pour visualiser les modifications apportées (cf. Fig. 79).


{% include figure.html filename="introduction-a-heurist-78.png" caption="Fig. 78. Éditer le widget de filtre. Image: Vincent Paillusson" %}


{% include figure.html filename="introduction-a-heurist-79.png" caption="Fig. 79. Validation des modifications apportées. Image: Vincent Paillusson" %}

Nous retrouvons les filtres à gauche, la carte au centre avec l'ensemble des sites archéologiques et, par défaut, aucune intervention dans la colonne de droite tant qu'aucune requête n'a été effectuée.

{% include figure.html filename="introduction-a-heurist-80.png" caption="Fig. 80. Visualisation des modifications. Image: Vincent Paillusson" %}


Pour lister l'ensemble des interventions dès l'affichage de la page, nous allons indiquer à ce widget de les afficher avant même qu'une requête soit effectuée dans la recherche à facettes.

Pour cela, passez de nouveau en mode édition et éditez le widget de résultats de recherche.
Renseignez **t:interventions** ou **t:55** comme filtre initial.

<div class="alert alert-warning">
  À noter que l'utilisation de l'identifiant Heurist (H-ID) pour identifier un type d'enregistrement dans une requête est plus stable dans le temps que l'utilisation du nom du type d'enregistrement. En effet, le nom attribué à un type d'enregistrement peut être modifié à tout moment par le reponsable d'une base Heurist en l'éditant dans le mode **Design**.
</div>


{% include figure.html filename="introduction-a-heurist-81.png" caption="Fig. 81. Filtre par défaut des enregistrements. Image: Vincent Paillusson" %}


Sauvegardez vos modifications et validez pour sortir du mode édition.

Cliquez sur **Refresh** dans la colonne de gauche pour actualiser la page.


{% include figure.html filename="introduction-a-heurist-82.png" caption="Fig. 82. Actualisation de la page. Image: Vincent Paillusson" %}



{% include figure.html filename="introduction-a-heurist-83.png" caption="Fig. 83. Visualisation des modifications. Image: Vincent Paillusson" %}


Pour finir, personnalisons le contenu textuel en passant de nouveau en mode édition.


{% include figure.html filename="introduction-a-heurist-84.png" caption="Fig. 84. Édition du contenu textuel. Image: Vincent Paillusson" %}


Insérez le texte de votre choix, sauvegardez puis validez.


{% include figure.html filename="introduction-a-heurist-85.png" caption="Fig. 85. Validation des modifications. Image: Vincent Paillusson" %}


Maintenant que votre page est personnalisée vous pouvez la partager en récupérant son URL via le bouton de partage et d'intégration.  


{% include figure.html filename="introduction-a-heurist-86.png" caption="Partage de la page" %}


Dans la même fenêtre, Heurist fournit également  le code pour l'intégration d'une page web dans une autre. Cela se fait par des éléments HTML appelés **iframe**.

Pour intégrer notre page web dans une page d'un autre site (par exemple un article de blog Wordpress), il suffit de copier et coller ce code dans l'éditeur de l'article.

<div class="alert alert-warning">
  Pour des questions de sécurité, certains systèmes de gestion de contenu (CMS) ou administrateurs de sites web bloquent la possibilité d'intégrer ces **iframe** ou conditionnent leur utilisation. Rapprochez-vous de l’administrateur du site (webmestre) pour avoir plus d'informations.
</div>



### Gérer les droits d'accès à vos pages

Notre page web est créée, il ne reste plus qu'à en gérer les droits d'accès. Par défaut, les données d'un enregistrement ne peuvent être éditées que par le propriétaire de la base et sont visibles par les utilisateurs connectés à Heurist.

Pour modifier ces droits et rendre vos données accessibles publiquement, repassez en mode **Explore** et, dans la barre d’options figurant au-dessus de la liste des enregistrements, sélectionnez **Ownership/Visibility** dans le menu de gestion de partage.


{% include figure.html filename="introduction-a-heurist-87.png" caption="Fig. 87. Accès en lecture et écriture aux enregistrements. Image: Vincent Paillusson" %}


Définissez le périmètre de votre choix (ici, nous sélectionnons l'ensemble des enregistrements présents), les utilisateurs ou groupes d'utilisateurs ayant l'autorisation de modifier les données, et enfin, les utilisateurs pouvant visualiser les données. Validez pour appliquer les modifications.


{% include figure.html filename="introduction-a-heurist-88.png" caption="Fig. 88. Modifier les options de modification et de visualisation de la base en ligne. Image: Vincent Paillusson" %}


Vous pouvez voir que les changements ont bien été pris en compte en observant le changement de couleur du chiffre à gauche de chaque enregistrement.

En déplaçant le curseur de la souris sur le chiffre ou sur le symbole barré juste à côté, vous obtenez des informations sur la visibilité et les droits d'édition de chaque enregistrement.


{% include figure.html filename="introduction-a-heurist-89.png" caption="Fig. 89. Vérification des modifications. Image: Vincent Paillusson" %}


## Conclusion

Heurist est un outil en constante évolution depuis 2005, fonctionnellement très riche à destination des chercheurs. Si son accès n'est pas réservé aux informaticiens ou développeurs, cette richesse fonctionnelle peut rendre son utilisation délicate pour de nouveaux utilisateurs. Nous espérons que ce tutoriel permettra à un plus grand nombre d'utiliser ce logiciel pour répondre à leurs besoins.

L'utilisation avancée de certaines fonctionnalités peut toutefois nécessiter de l'aide extérieure. La rubrique **Help** est dédiée à cet usage.


{% include figure.html filename="introduction-a-heurist-90.png" caption="Fig. 90. Rubrique d'aide. Image: Vincent Paillusson" %}


Le site web [heuristnetwork](https://heuristnetwork.org) dispose également d'une page [contact](https://heuristnetwork.org/contact/) et d'une rubrique [learn](https://heuristnetwork.org) permettant de compléter le contenu du présent cours.

## Ressources utiles

### Sur l'utilisation d'Heurist

- Page d'aide du site officiel d'Heurist (en anglais) régulièrement augmentée et à consulter sans modération : [https://heuristplus.sydney.edu.au/heurist/?db=Heurist_Help_System&website&id=39&pageid=622](https://heuristplus.sydney.edu.au/heurist/?db=Heurist_Help_System&website&id=39&pageid=622).
- Conférence inaugurale de Ian Johnson à l’Université de Haute-Alsace du 22 janvier 2021 : [https://e-diffusion.uha.fr/video/3668-j1-ian-johnson-conference-inaugurale/](https://e-diffusion.uha.fr/video/3668-j1-ian-johnson-conference-inaugurale/).
- Liste de diffusion francophone des utilisateurs Heurist: [https://groupes.renater.fr/sympa/info/heurist-utilisateurs](https://groupes.renater.fr/sympa/info/heurist-utilisateurs).
- Un autre tutoriel sur Heurist, sorti en mars 2021 et régulièrement mis à jour, rédigé par Régis WITZ de la [MISHA](https://www.misha.fr/) : [https://uncoded.gitlab.io/BDD/](https://uncoded.gitlab.io/BDD/).

### Sur la gestion des données de la recherche

- Leçon "Préserver ses données de recherche", ProgrammingHistorian, [https://programminghistorian.org/fr/lecons/preserver-ses-donnees-de-recherche](https://programminghistorian.org/fr/lecons/preserver-ses-donnees-de-recherche).
- Sur le thème des formats ouverts, Doranum, [https://doranum.fr/stockage-archivage/quiz-format-ouvert-ou-ferme/](https://doranum.fr/stockage-archivage/quiz-format-ouvert-ou-ferme/).
- FACILE, Le service de validation de formats du CINES, [https://facile.cines.fr/](https://facile.cines.fr/).









[^5]: "Heurist, une base de données généraliste pour les sciences humaines et sociales", Paris Time Machine, https://paris-timemachine.huma-num.fr/heurist-une-base-de-donnees-generique-pour-les-sciences-humaines-et-sociales/
[^coursMerise]: Pour en savoir plus: https://ineumann.developpez.com/tutoriels/merise/initiation-merise/
[^Smarty]: Pour aller plus loin, voir le tutoriel d'Eric Pommereau: https://eric-pommereau.developpez.com/tutoriels/initiation-smarty/
[^IdInrap]: Identifiants arbitraires créés pour les besoins de la présente leçon
[^OpenrefinePH]: Nettoyer ses données avec Open refine: https://programminghistorian.org/fr/lecons/nettoyer-ses-donnees-avec-openrefine
[^Remerciements]: Que je remercie tout particulièrement pour la relecture, les conseils et corrections apportés à la présente leçon. 
[^QGIS]: Pour aller plus loin avec QGIS, voir la leçon qui lui est dédiée sur ProgrammingHistorian en anglais: https://programminghistorian.org/en/lessons/geocoding-qgis

 
