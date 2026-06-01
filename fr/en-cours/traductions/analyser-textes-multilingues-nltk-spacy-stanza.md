---
title: "Analyser des textes multilingues en français et russe en utilisant NLTK, spaCy, et Stanza"
slug: analyser-textes-multilingues-nltk-spacy-stanza
original: analyzing-multilingual-text-nltk-spacy-stanza
layout: lesson
collection: lessons
date: 2024-11-13
translation_date: YYYY-MM-DD
authors:
- Ian Goodale
reviewers:
- William Mattingly
- Merve Tekgürler
editors:
- Laura Alice Chapot
translator:
- Felix Vanden Borre
translation-editor:
- Émilien Schultz
translation-reviewer:
- Forename Surname
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/677
difficulty: 2
activity: analyzing
topics: [python, data-manipulation, distant-reading]
abstract: Cette leçon introduit la tokénisation, l’étiquetage morpho-syntaxique, et la lemmatisation, ainsi que la détection automatique de langage pour des textes non anglais et multilingues. Vous apprendrez à utiliser les packages Python NLTK, spaCy, et Stanza pour analyser un texte multilingue russo-français.
avatar_alt: Lettre manuscrite en forme de rébut (les symboles et les images représentent des syllabes).
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

<div class="alert alert-warning">
Note de la traduction : cette version française de la leçon a été mise à jour par rapport à la version originale anglophone afin de tenir compte de l'évolution des bibliothèques utilisées. Le code a été adapté pour Python 3.12, spaCy 3.8.11 et Stanza 1.11.1 (la version originale reposait sur Python 3.10, spaCy 3.7.4 et Stanza 1.8.2). En particulier, la section sur la détection de langue avec <code>spacy_langdetect</code> a été réécrite pour suivre le nouveau pattern <code>@Language.factory</code> requis par les versions récentes de spaCy, et les index de phrases utilisés dans les exemples de tokénisation avec spaCy ont été ajustés.
</div>

## But de la leçon

Une grande partie des ressources destinée à l’apprentissage de méthodes informatiques d’analyse de texte se concentre sur des textes et corpus de langue anglaise et omettent souvent d’inclure les explications nécessaires pour travailler avec des sources non anglophones. Pour remédier à ce problème, cette leçon propose une introduction à l’analyse de texte non anglophone et multilingue (c'est-à-dire écrit en plus d’une langue) via Python. En ayant recours à un texte multilingue composé en russe et en français, cette leçon montrera comment utiliser des méthodes informatiques pour accomplir trois tâches de prétraitement fondamentales : la tokénisation, l’étiquetage morpho-syntaxique, et la lemmatisation. Ensuite, la leçon vous apprendra à automatiquement détecter les langues présentes dans un texte prétraité.

Afin d’accomplir ces trois tâches de prétraitement essentielles, cette leçon utilisera trois packages Python régulièrement utilisés pour le traitement automatique du langage naturel, aussi dit TALN (en anglais, Natural Language Processing ou NLP); Natural Language Toolkit (NLTK), spaCy, et Stanza. Nous commencerons par introduire ces packages avant de passer en revue et comparer leurs fonctionnalités afin que vous puissiez comprendre comment ils fonctionnent et discerner quel outil est le bon pour vos usages et styles de programmation personnels.

## Préparation

### Prérequis

Cette leçon est destinée à celles et ceux qui ne sont pas familier avec les méthodes de traitement automatique du langage naturel, en particulier celles·eux souhaitant appliquer ces méthodes sur des corpus multilingues ou des textes écrits en langues autres que l’anglais. Bien qu’une connaissance de Python ne soit pas nécessaire, il sera utile de comprendre la structure du code. Avoir une connaissance rudimentaire de la syntaxe de Python ainsi que de ses fonctionnalités est recommandé. Il serait par exemple utile pour les lectrices·eurs de s’être familiarisé avec l’importation de bibliothèques, la construction de fonctions, la manipulation de chaînes de caractères, et l'utilisation de boucles.

Le code pour cette leçon est écrit en Python 3.12 et utilise les bibliothèques NLTK (v3.8.1), spaCy (v3.8.11), et Stanza (v1.11.1) pour effectuer du traitement automatique du langage naturel. Si vous n’avez jamais utilisé Python auparavant, il vous sera utile de consulter cette autre leçon du [_Programming Historian_](https://programminghistorian.org/en/lessons/introduction-and-installation) avant de commencer la leçon (à noter que les leçons complémentaires du _Programming Historian_ qui seront indiquées ici ne sont pas encore disponibles en traduction francophone).

## Installation et mise en place

Pour commencer, il vous faudra installer Python3 ainsi que les bibliothèques NLTK, spaCy, et Stanza, qui sont toutes disponibles via le [Python Package Index (PyPI)](https://pypi.org/.). Pour plus d’informations sur l’installation de bibliothèque en utilisant PyPI, veuillez consulter leur [guide d’installation de packages](https://perma.cc/VQK8-K33R).

## Les bases du traitement automatique du langage naturel et travailler avec du texte non anglais et multilingue

L’analyse automatique de texte est un terme qui regroupe une grande variété d’approches, méthodologies, et bibliothèques Python qui servent à numériquement manipuler et analyser des textes à grande échelle. L’utilisation d'outils de TALN permet de rapidement compléter des tâches qui sont bien plus difficiles à accomplir autrement. Par exemple, l’étiquetage morpho-syntaxique décrit dans cette leçon peut être utilisé pour rapidement identifier tous les verbes ainsi que leurs sujets et objets associés à travers un corpus de textes. Ceci peut ensuite être utilisé pour développer des analyses d’agencement et de subjectivité dans le corpus (tel que dans l’article anglophone de Dennis Tenen [Distributed Agency in the Novel](https://doi.org/10.1353/nlh.2022.a898333)).

En outre des méthodes présentées dans cette leçon, d’autres tâches de traitement automatique du langage naturel qui sont facilitées par une approche numérique sont l’analyse de sentiments (qui génère une évaluation quantitative du sentiment d’un texte, généralement sur une échelle numérique, et qui indique si ce sentiment est négatif ou positif) et la reconnaissance d’entités nommées (qui sert à reconnaître et classifier des entités dans un texte à travers diverses catégories, telles que lieux, personnes, et cetera).

Pour plus de lecture concernant ces méthodes, veuillez consulter les leçons du _Programming Historian_ [Sentiment Analysis for Exploratory Data Analysis](https://programminghistorian.org/en/lessons/sentiment-analysis) et [Sentiment Analysis with ‘syuzhet’ using R](https://programminghistorian.org/en/lessons/sentiment-analysis-syuzhet) pour l’analyse de sentiments, et [Finding Places in Text with the World Historical Gazetteer](https://programminghistorian.org/en/lessons/finding-places-world-historical-gazetteer) ainsi que [Corpus Analysis with spaCy](https://programminghistorian.org/en/lessons/corpus-analysis-with-spacy) pour la reconnaissance d’entités nommées. La leçon [Introduction to Stylometry with Python](https://programminghistorian.org/en/lessons/introduction-to-stylometry-with-python) peut servir à celles·eux souhaitant explorer davantage de possibilités offertes par l’analyse numérique de textes.

Afin de préparer le texte, il faut d’abord accomplir certaines tâches de « prétraitement ». Ces tâches peuvent être particulièrement importantes (et parfois particulièrement compliquées) en travaillant avec du texte multilingue.

Par exemple, il vous faudra peut-être commencer par rendre vos documents lisibles par machine en utilisant des méthodes telles que [l’Optical Character Recognition](https://perma.cc/KK5H-PEVL) (OCR). L’océrisation fonctionne très bien sur de nombreux types de documents, mais peut s’avérer moins efficace quand elle est appliquée à des textes manuscrits ou sur des documents où le texte n’est pas clairement délimité (tels qu’un document avec peu de contraste entre le texte imprimé et le papier). En fonction des langues et textes avec lesquels vous travaillez (et de la qualité des méthodes d’océrisation), il vous faudra peut-être d’abord « nettoyer » votre texte – c’est-à-dire corriger les erreurs faites par l’océrisation – avant de pouvoir procéder à l’analyse. Pour une introduction à l’océrisation et le nettoyage de texte, veuillez consulter ces leçons du _Programming Historian_: [OCR with Google Vision API and Tesseract](https://programminghistorian.org/en/lessons/ocr-with-google-vision-and-tesseract) et [Cleaning OCR’d text with Regular Expressions](https://programminghistorian.org/en/lessons/cleaning-ocrd-text-with-regular-expressions).

### Étapes et concepts clés de l'analyse de textes

Une fois que vous disposez d’un texte propre qui est lisible par machine, il faudra encore effectuer des tâches de prétraitement afin de préparer ce texte à l’analyse. Cependant, ces tâches peuvent de nouveau impliquer certains défis à prendre en compte en fonction des types de langages et textes avec lesquels vous travaillez.

Dans cette leçon, nous nous concentrerons sur trois tâches clés du prétraitement : la tokénisation, l’étiquetage morpho-syntaxique, ainsi que la lemmatisation. Nous montrerons comment ces tâches peuvent être appliquées au texte multilingue et non anglais.

**La tokénisation**

La tokénisation est la segmentation d’un texte en ses parties composées ou « tokens ». Ces tokens peuvent varier en taille, mais un texte est généralement tokénisé soit en mots, soit en phrases. Une phrase pourrait par exemple être tokénisée en une liste de mots : [And, now, for, something, completely, different] (cet exemple est tiré du chapitre 5 du [NLTK Book](https://perma.cc/KU9D-H8FW)). Pour cette leçon, nous nous concentrons sur la tokénisation de textes en listes de mots telles que celle-ci. Dans d’autres contextes, comme pour la tokénisation de texte pour un Large Language Model (Grand Modèle de Langage), d’autres méthodes de tokénisation devraient être employées (il faut par exemple parfois donner une valeur numérique unique à chaque token individuel (lettres, symboles de ponctuation)).

Dans cette leçon, nous commencerons par tokéniser notre texte. Ceci nous permettra ensuite d’effectuer l’étiquetage morpho-syntaxique et la lemmatisation de nos données textuelles. Sans cette tokénisation préalable, il ne serait pas possible d’accéder au texte en tant que série de mots, ce qui est pourtant nécessaire pour effectuer l’étiquetage et la lemmatisation.

**L’étiquetage morpho-syntaxique**

L’étiquetage morpho-syntaxique est un procédé par lequel chaque mot dans un texte est étiqueté avec sa valeur morpho-syntaxique (tel que « nom propre », « verbe », « adjectif », et cetera). L’étiquetage morpho-syntaxique peut suivre des algorithmes à base de règles prédéfinies, utilisant des définitions fixes pour estimer le label à correctement attacher à un mot, ou bien suivre une approche [stochastique](https://perma.cc/XU5R-KWMD) (probabiliste), grâce à laquelle l’étiqueteur calcule la probabilité qu’une combinaison d’étiquettes se produise. La phrase utilisée comme exemple de tokénisation plus haut pourrait ainsi ressembler à ceci une fois étiqueté par NLTK : (‘And’, ‘CC’), (‘now’, ‘RB’), (‘for’, ‘IN’), (‘something’, ‘NN’), (‘completely’, ‘RB’), (‘different’, ‘JJ’) (à noter que ces étiquettes représentent des étiquettes anglophones). La phrase est divisée en liste de mots, et chaque mot est mis dans un [tuple](https://perma.cc/N8UU-UZUM) avec son étiquette morpho-syntaxique.

{% include figure.html filename="en-or-analyzing-multilingual-text-nltk-spacy-stanza-01.png" alt="Figure 1: capture d'écran de l'étiquetage morpho-syntaxique, chapitre 5 du NLTK Book." caption="Figure 1: capture d'écran de l'étiquetage morpho-syntaxique, chapitre 5 du NLTK Book." %}


**La lemmatisation**

La lemmatisation réduit un mot à sa forme de base communément appelée le « lemme ». La forme lemmatisée du mot codage, par exemple, est code, sans le suffixe -age.

## Problèmes posés par l’analyse de texte non anglais et multilingue

La tokénisation, l’étiquetage morpho-syntaxique et la lemmatisation sont présentés dans cette leçon comme des exemples pratiques des différentes façons dont les packages NLTK, spaCy, et Stanza approchent ces tâches fondamentales de traitement automatique du langage naturel. En effet, la manière dont les packages d’analyse de texte implémentent certaines tâches peuvent varier selon un nombre de critères : le choix de l’algorithme, le choix des modèles de langage, les données sur lesquelles ceux-ci ont été entraînés, et cetera. La capacité des différents packages à analyser certaines langues dépend donc de la disponibilité et de la qualité de ces composants. Certains modèles peuvent reproduire des présupposés qui s’alignent avec les caractéristiques de la langue anglaise, mais qui ne sont pas forcément transférables à d’autres langues. Par exemple, certaines procédures essentielles de traitement automatique du langage naturel considèrent qu’un mot est représenté par une série de caractères séparée par un espace. Ceci fonctionne pour l’anglais et d'autres langues écrites avec un alphabet, telles que le français, mais des langues à base de symboles, comme le mandarin, utilisent d'autres méthodes qu'un espace pour indiquer les frontières entre les mots. Tokéniser un texte en mandarin peut donc nécessiter l’insertion artificielle d’espace entre chaque symbole, un procédé qui s’appelle la segmentation (veuillez consulter la leçon de Melanie Walsh [Text Pre-Processing for Chinese](https://perma.cc/62C3-9VNY) pour une introduction). De même, si l’on souhaite tokéniser un mot écrit en alphabet latin ou cyrillique au niveau des ses lettres composantes, les [signes diacritiques combinés](https://perma.cc/KU5K-U5G9) poseraient un problème, car ceux-ci sont représentés par des symboles Unicode qui sont rajouté aux lettres en question.

Une grande partie des ressources disponibles pour l’apprentissage de méthodes informatiques d’analyse de texte privilégie l’utilisation de textes et corpus de langue anglaise. Ces ressources omettent souvent des informations essentielles pour travailler avec des sources non anglophones, et il peut être difficile de comprendre comment utiliser ou adapter certains de ces outils à d’autres langues. Cependant, de plus en plus de modèles de haute qualité et capables de traiter un grand nombre de langues sont rendus publics. Par exemple, grâce à l’introduction de nouveaux modèles par spaCy et Stanza, il est désormais possible d’utiliser ces bibliothèques pour l’étiquetage morpho-syntaxique du russe et du français. Malgré cela, la plupart des tutoriels et outils que vous rencontrerez seront par défaut axés vers l’anglais. Il faut également noter que les formes d’anglais représentées par ces outils et tutoriels ont tendance à être limitées à l’anglais standard, et que d’autres formes de la langue sont également sous-représentées.

Il existe d'autres défis au traitement automatique du langage naturel lorsque l'on travaille avec des textes multilingues, tels que reconnaître quelles langues sont présentes dans le texte ou encore travailler avec différents systèmes d’encodage de texte. Si certaines méthodes se basent sur des présupposés tirés de l’anglais et de ses structures grammaticales, celles-ci sont également souvent conçues pour des textes monolingues et ne fonctionnent pas bien sur des textes qui contiennent plusieurs langues. Par exemple, comme nous le verrons plus tard dans la leçon, le tokéniseur de phrases recommandé pour le package NLTK (PunktSentenceTokenizer) est configuré pour fonctionner sur une seule langue à la fois, et ne sera donc pas la meilleure option si l’on souhaite travailler avec des textes multilingues. Cette leçon vous montrera comment utiliser des modèles pour cibler des langues spécifiques dans un texte afin d’éviter de commettre des erreurs.

Dans cette leçon, nous comparerons les bibliothèques NLTK, spaCy, et Stanza qui contiennent chacune des modèles capables d’analyser différentes langues. Cependant, il vous faudra tout de même ajuster vos approches et flux de travail en fonction des langues et textes que vous analysez. Il y a plusieurs choses à prendre en compte en analysant des textes non anglais par ordinateur et qui sont souvent spécifiques aux langues présentes dans vos textes. Des facteurs tels que le système d’écriture utilisé dans un texte, la syntaxe, et l’existence d’algorithmes capables d’exécuter certaines tâches, ainsi que la disponibilité de données d’entraînement appropriées, peuvent tous affecter les résultats des méthodes de traitement automatique du langage naturel. Dans votre propre travail, il est toujours nécessaire de réfléchir à l’approche la plus adéquate aux besoins de votre recherche et de prendre en compte les présupposés incorporés dans certaines méthodes (en consultant la documentation de packages particuliers) avant d’appliquer un algorithme à votre texte. Être ouvert d’esprit et disposé à modifier votre flux de travail au fur et à mesure que votre travail avance sera également utile.

## Packages Python Essentiels

Les bibliothèques Python utilisés dans cette leçon (NLTK, spaCy, et Stanza) ont été choisies pour leur capacité à traiter des textes multilingues, leurs communautés d’utilisatrices·eurs régulières·ers, ainsi que leur statut de code ouvert. Bien que les trois packages soient couramment utilisés et fiables, ils possèdent chacun différents point forts et caractéristiques : ils couvrent différentes langues, utilisent différentes syntaxes et structurations de données, et chacun se concentre sur des usages légèrement différents. En examinant leurs différentes caractéristiques et en comparant leur utilisation, vous serez capable de développer une familiarité de base avec chacun de ces packages, ce qui vous aidera à choisir celui qui sera le mieux adapté à vos projets.

### Le Natural Language Toolkit (NLTK)

[NLTK](https://www.nltk.org/index.html) est une suite de modules pour construire des scripts Python pour travailler avec des données linguistiques. Ayant été rendu public en 2001, NLTK possède une excellente documentation et une communauté d’utilisatrices·eurs actifs·ves et engagé·es, ce qui en fait un outil excellent pour les débutant·es du traitement automatique du langage naturel. Les utilisatrices·eurs plus avancé·es trouveront également sa grande variété de bibliothèques et corpus utile, et sa structure rend NLTK facile à intégrer dans des pipelines et tâches de travail.

NLTK supporte un nombre variable de langues et tâches : il contient des listes de mots vides pour 23 langues mais ne permet la tokénisation de mots qu'en 18 langues. Les « mots vides » sont des mots qui sont retirés du texte avant de le traiter, généralement parce qu’ils sont considérés comme sans importance pour une tâche particulière (par exemple le mot "le" peut être retiré pour se concentrer sur le restant du vocabulaire présent dans le texte).

Pour plus d’informations, le [NLTK Book](https://www.nltk.org/book/) est une excellente référence, tout comme la documentation officielle du package indiquée plus haut. Malheureusement, ce livre ainsi que la documentation ne sont disponibles qu’en anglais.

### spaCy

[spaCy](https://perma.cc/HXY2-6R3Z) soutient une plus grande variété de langues que NLTK grâce à des modèles plus ou moins complexes entraînés au préalable. En règle générale, spaCy est un outil plus autonome que NLTK. Alors que NLTK doit par exemple se contenter de bibliothèques de visualisation séparées telle que [matplotlib](https://matplotlib.org/), spaCy dispose de ses propres outils de visualisation qui peuvent être utilisés en même temps que ses outils d’analyse pour visualiser vos résultats, tels que [displaCy](https://demos.explosion.ai/displacy).

spaCy est connu pour sa vitesse et son efficacité, et est souvent plus rapide que NLTK et Stanza. En outre, si vous voulez gagner du temps sur la vitesse de traitement, vous pouvez utiliser des modèles plus petits et moins précis pour accomplir des tâches comme l’étiquetage morpho-syntaxique sur du texte simple plutôt que d’utiliser un modèle plus complexe qui pourrait produire des résultats plus précis mais serait plus long à télécharger et à déployer.

La documentation de spaCy et uniquement disponible en anglais, mais le package contient des pipelines pour 25 langues différentes. Plus d’une vingtaine d’autre langues sont aussi prises en charge, mais ne disposent pas encore de pipelines (ce qui signifie que seulement une partie des fonctionnalités, tels que les listes de mots vides, sont disponibles pour ces langues). Pour plus d’informations quant aux langues prises en charge, veuillez consulter [leur documentation](https://perma.cc/A239-R44S).

### Stanza

Stanza a été spécifiquement conçu pour le multilinguisme, ce qui rend le traitement automatique du langage naturel en différentes langues très intuitif et naturel avec la syntaxe de cette bibliothèque. Lancer un pipeline sur du texte vous permet d’accéder à ses différents composants tels que par exemple l’étiquetage morpho syntaxique et les lemmes avec très peu de code.

Bien que souvent plus lent que NLTK et spaCy, [Stanza](https://perma.cc/PGU6-EZ27) contient des modèles de langage qui ne sont pas disponibles à travers les autres bibliothèques. Ce package contient des modèles neuraux pré-entraînés pour plus de [70 langues](https://stanfordTALN.github.io/stanza/models.html#human-languages-supported-by-stanza). Une liste exhaustive de ses modèles est disponible sur le [GitHub de StanfordTALN](https://perma.cc/RZ38-AACK), et plus d’informations quant à ses pipeline sont disponibles [ici](https://stanfordTALN.github.io/stanza/neural_pipeline.html). Les pipelines de Stanza sont construites avec des composants de réseaux de neurones artificiels entraînés sur des corpus plurilingues, ce qui signifie qu’elles utilisent des algorithmes de machine-learning entraînées sur du texte annoté plutôt que des approches de traitement automatique du langage naturel à base de paramètres (comme comparer les mots d’un texte à un dictionnaire défini au préalable). Par exemple, si l’on entreprend de l’étiquetage morpho-syntaxique sur un texte, les algorithmes de Stanza générerons leurs propres étiquettes basées sur des prédictions entraînées sur un large corpus de texte étiqueté et prenant en compte le contexte de chaque mot (c’est-à-dire sa position relative aux autres mots de la phrase). En revanche, un algorithme à base de paramètres chercherait chaque terme dans un dictionnaire prédéfini et identifierait son étiquette en fonction des résultats sans prendre en compte le contexte dans lequel chaque mot apparaît.

La documentation pour Stanza est uniquement disponible en anglais. Pour plus d’informations, veuillez consulter cet article sur [Stanza](https://perma.cc/B4G2-ND2S).

En résumé, chaque package peut s’avérer être un outil très efficace pour l’analyse d’un texte dans une langue autre que l’anglais (ou écrit en plusieurs langues), et cela vaut la peine d’examiner la syntaxe et les fonctionnalités de chaque package de plus près pour décider lequel serait le mieux adapté à vos besoins et à ceux de vos projets.

## Développer du code Python pour l’analyse de texte multilingue

Pour la partie programmation de cette leçon, vous prendrez un extrait du texte du roman Guerre et Paix (1869) de Léon Tolstoï en russe et qui contient une grande partie de texte francophone. Nous verrons comment diviser le texte en phrases, comment détecter la langue dans laquelle chacune de ces phrases est écrite, et comment effectuer certaines analyses sur le texte. Le fichier de texte que nous utiliserons contient un extrait du premier livre du roman qui a été obtenu via Wikipédia. Ceci est le seul texte dont vous aurez besoin pour la leçon et il peut être téléchargé depuis le [dépôt du _Programming Historian_](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/analyser-textes-multilingues-nltk-spacy-stanza/guerre-et-paix-extrait.txt). Si vous souhaitez suivre la leçon depuis un Jupyter notebook, nous en avons préparé un qui contient tout le code de cette leçon et qui est [accessible ici](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/analyser-textes-multilingues-nltk-spacy-stanza/analyser-textes-multilingues-nltk-spacy-stanza.ipynb).

Pour poursuivre la leçon sans télécharger le fichier texte, vous pouvez utiliser le texte qui suit comme chaîne de caractères à la place.

``` python
war_and_peace = """
— Eh bien, mon prince. Gênes et Lucques ne sont plus que des apanages, des поместья, de la famille Buonaparte. Non, je vous préviens, que si vous ne me dites pas, que nous avons la guerre, si vous vous permettez encore de pallier toutes les infamies, toutes les atrocités de cet Antichrist (ma parole, j’y crois) — je ne vous connais plus, vous n’êtes plus mon ami, vous n’êtes plus мой верный раб, comme vous dites. Ну, здравствуйте, здравствуйте. Je vois que je vous fais peur, садитесь и рассказывайте.

Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер. Анна Павловна кашляла несколько дней, у нее был грипп, как она говорила (грипп был тогда новое слово, употреблявшееся только редкими). В записочках, разосланных утром с красным лакеем, было написано без различия во всех:

«Si vous n’avez rien de mieux à faire, M. le comte (или mon prince), et si la perspective de passer la soirée chez une pauvre malade ne vous effraye pas trop, je serai charmée de vous voir chez moi entre 7 et 10 heures. Annette Scherer».

— Dieu, quelle virulente sortie! — отвечал, нисколько не смутясь такою встречей, вошедший князь, в придворном, шитом мундире, в чулках, башмаках, и звездах, с светлым выражением плоского лица.

Он говорил на том изысканном французском языке, на котором не только говорили, но и думали наши деды, и с теми тихими, покровительственными интонациями, которые свойственны состаревшемуcя в свете и при дворе значительному человеку. Он подошел к Анне Павловне, поцеловал ее руку, подставив ей свою надушенную и сияющую лысину, и покойно уселся на диване.

— Avant tout dites moi, comment vous allez, chère amie? Успокойте меня, — сказал он, не изменяя голоса и тоном, в котором из-за приличия и участия просвечивало равнодушие и даже насмешка.
"""
```

### Charger et préparer le texte

Il nous faut tout d’abord charger notre fichier texte afin de l’utiliser avec différents packages de traitement automatique du langage naturel. Pour commencer, ouvrons le fichier et attribuons-lui la variable que l’on nommera `war_and_peace`. Ensuite, imprimons les contenus de ce fichier pour être certain qu’il a été lu correctement. Pour cette leçon, nous n’utiliserons qu’un court extrait du roman.

``` python
#il n'est pas nécessaire d'exécuter la cellule important le fichier guerre-et-paix-extrait.txt si la cellule précédente, plaçant directement le contenu du texte dans la variable war_and_peace sans télécharger le fichier, a déjà été exécutée
with open("guerre-et-paix-extrait.txt") as file:
    war_and_peace = file.read()
    print(war_and_peace)
```

Lancer ce code devrait afficher le texte tel qu’il est montré ci-dessus.

Nous allons maintenant retirer les [caractères de fin de ligne](https://perma.cc/UX3B-R2WF). Ces caractères sont utilisés pour indiquer la fin d’une ligne en encodage de caractères tel que l’Unicode. Nous allons remplacer toutes les fins de ligne (représentés ici par `\n`) par un espace et nous sauvegarderons ce texte nettoyé dans une nouvelle variable intitulée `cleaned_war_and_peace` avant de l’imprimer pour vérifier les résultats. Remplacer les caractères de fin de ligne par un espace sert à combiner et homogénéiser le texte en une chaîne de caractères continue. Ceci permet de s’assurer que le tokéniseur n’identifie pas des phrases là où il n’y en a pas. C’est la seule modification que nous apporterons au texte dans le cadre de cette leçon, mais si vous êtes intéressé par les différentes étapes que vous pouvez entreprendre pour préparer votre texte à des analyses multilingues, veuillez consulter [cet article](https://perma.cc/Z4VX-RHT2).

``` python
cleaned_war_and_peace = war_and_peace.replace("\n", " ")
print(cleaned_war_and_peace)
```
Le résultat du code ci-dessus sera une copie du texte sans caractères de fin de ligne.

Maintenant que nous avons lu le fichier et préparé notre texte, nous pouvons commencer à le traiter. Il faudra d’abord installer et importer les bibliothèques (NLTK, spaCy, Stanza).

Afin d’installer ces bibliothèques, lancez cette commande dans votre terminal :

``` python
#note: si vous travaillez depuis un Jupyter notebook, rajout "!" au début de chaque ligne d'installation
pip install nltk
pip install spacy
pip install stanza
```

Ensuite, pour les importer après installation, écrivez ces lignes dans votre code Python.

``` python
import nltk
import spacy
import stanza
```

### La Tokénisation

Maintenant que ces bibliothèques ont été importées, nous pouvons commencer à tokéniser le texte en phrases. [La tokénisation](https://perma.cc/GZM4-C5S4) se réfère tout simplement au fait de diviser le texte en plus petites unités, telles que des phrases ou des mots, ce qui vous permet de rendre le texte plus propice à l’analyse. Si nous travaillons avec une phrase en tant que [chaîne de caractères](https://perma.cc/V7QC-LXMH) (appelée "string" en anglais), par exemple, notre code ne sera pas capable de la diviser en ses parties composées, telles que des mots ou des lettres. Il nous faudra alors tokéniser la phrase pour pouvoir travailler chacun des mots qui la constituent comme une donnée séparée. Pour cette partie de la leçon, nous commencerons par tokéniser en utilisant NLTK avant de détecter la langue utilisée dans chaque phrase.

Il existe plusieurs tokéniseurs de phrases dans le package NLTK. Le package recommande d’utiliser le `PunktSentenceTokenizer` pour une langue spécifiée par l’utilisatrice·eur (veuillez consulter [ce lien](https://www.nltk.org/api/nltk.tokenize.html) pour plus d’information), mais si vous travaillez avec plusieurs langues dans un même texte, ceci n’est peut-être pas la meilleure approche. Si vous avez à votre disposition un extrait de texte qui contient plusieurs langues, utiliser un modèle de tokénisation qui a été entraîné pour fonctionner sur une seule langue produira des résultats moins précis (si par exemple, nous sélectionnons le français, les méthodes utilisées par le modèle pour tokéniser du texte français seraient également appliquées au russe qui se trouve dans notre texte et pour lequel le modèle risque d’être moins efficace). Ces modèles spécifiques à certains langages prennent en considération des cas particuliers qui ne s’appliquent qu’à ces langues – tel que des caractéristiques de délimitation de mots ou phrases propres à ces langues – plutôt que de simplement séparer les phrases par voie de ponctuation.

#### Tokéniser avec NLTK

Dans cette partie de la leçon, nous utiliserons la méthode `sent_tokenize` du package NLTK sans préciser de langue, ce qui nous permettra d’utiliser un algorithme de tokénisation rudimentaire qui fonctionnera avec les phrases russe et françaises de notre exemple. À des fins plus avancées, où la précision sur un large corpus de texte est importante, il est préférable d’utiliser des modèles de langage plus spécialisés. Pour consulter des exemples où l’on spécifie une langue avec le tokéniseur NLTK, veuillez consulter [ce commentaire Stack Overflow](https://perma.cc/2TKK-SDDK) qui montre les langues contenues dans NLTK.

Pour commencer, téléchargeons l’algorithme `punkt` pour utiliser le tokéniseur.

``` python
nltk.download('punkt')
```

Ensuite, nous allons importer la méthode `sent_tokenize` et l’appliquer à notre variable `war_and_peace`.

``` python
from nltk.tokenize import sent_tokenize
nltk_sent_tokenized = sent_tokenize(cleaned_war_and_peace)
# si vous comptiez spécifier une langue, la syntaxe a utiliser serait: nltk_sent_tokenized = sent_tokenize(war_and_peace, language="russian"
```

L’entièreté du texte contenu dans la variable `cleaned_war_and_peace` est désormais accessible en tant que liste de phrases dans la variable `nltk_sent_tokenized`. Il est maintenant plus simple d’établir quelle phrase est écrite en quelle langue, car nous disposons dorénavant d’une plus petite sélection de textes à analyser. Lorsque l’on travaille avec des quantités de données textuelles plus élevées, trouver des phrases particulières peut nécessiter une analyse plus approfondie du texte. L’extrait de code ci-dessous va itérer à travers toutes nos phrases et les imprimer une par une sur une nouvelle ligne pour en faciliter l’analyse.

``` python
# imprimer chaque phrase de notre liste
for sent in nltk_sent_tokenized:
  print(sent)
```
Le fait de tokéniser le texte en phrases nous permet d’analyser l’extrait avec plus grande précision. Nous allons imprimer trois phrases avec lesquelles nous travaillerons : une entièrement en russe, une entièrement en français, et une qui contient les deux langues. Les langues utilisées dans les phrases deviendront importantes lorsque nous y appliquerons différentes méthodes au fur et à mesure de la leçon.

``` python
# imprimer la phrase russe en 5ième position de l'index de notre liste
rus_sent = nltk_sent_tokenized[5]
print('Russian: ' + rus_sent)

# imprimer la phrase française en 13ième position
fre_sent = nltk_sent_tokenized[13]
print('French: ' + fre_sent)

# imprimer la phrase en français et russe en 4ième position
multi_sent = nltk_sent_tokenized[4]
print('Multilang: ' + multi_sent)
```

Résultats:
``` python
Russian: Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер.
French: — Avant tout dites moi, comment vous allez, chère amie?
Multilang: Je vois que je vous fais peur, садитесь и рассказывайте.
```
#### Tokéniser avec spaCy

Nous allons maintenant répéter cette tokénisation de phrases avec spaCy et réutiliser les trois phrases qui nous ont servies d’exemples ci-dessus. Comme vous pouvez le voir, la syntaxe de spaCy est assez différente : la bibliothèque dispose notamment par défaut d’un tokéniseur de phrases multilingues. Pour accéder à la liste de phrases tokénisées par l’algorithme de spaCy, il vous faudra d’abord appliquer cet algorithme au texte en utilisant la méthode `nlp` avant d’assigner les tokens `doc.sents` à une liste.

``` python
# télécharger le tokéniseur de phrases multilingue
#note: si vous travaillez depuis un Jupyter notebook, rajout "!" au début de la ligne d'installation
python -m spacy download xx_sent_ud_sm
```
``` python
# charger le tokéniseur multilingue dans notre code
nlp = spacy.load("xx_sent_ud_sm")
# déployer le modèle spaCy sur la variable de texte
doc = nlp(cleaned_war_and_peace)

# mettre les phrases tokénisées dans une liste pour y accéder plus facilement par la suite
spacy_sentences = list(doc.sents)

# imprimer les phrases
print(spacy_sentences)
```

Nous pouvons désormais sauvegarder nos phrases dans des variables, tel que nous l’avons fait avec NLTK. spaCy ne retourne pas les phrases comme chaîne de caractères mais en tant que tokens spaCy. Afin de les imprimer comme nous l’avons fait avec NLTK, il faudra d’abord les convertir en chaîne de caractères (pour plus d’informations sur les types de données supportés par Python, tels que les chaînes de caractères et les nombres entiers, veuillez consulter [cette documentation](https://perma.cc/PJ99-H9DP)). Ceci nous permettra d’attacher un préfixe qui identifie la langue des phrases, car Python ne permet pas de combiner une chaîne de caractères avec un autre type de donnée. Étant donné la petite taille de nos données, il est facile de spécifier les phrases qui nous intéressent en utilisant leur indexation dans notre liste. Pour examiner l’entièreté d’une liste de phrases, comme on pourrait le faire avec une base de données plus large, on utiliserait une méthode différente pour examiner les chaînes de caractères, comme par exemple en itérant à travers chaque objet de la liste (il nous faudra faire ceci avec nos tokens Stanza ci-dessous).

``` python
# combiner la phrase russe et son label de langage
spacy_rus_sent = str(spacy_sentences[6])
print('Russian: ' + spacy_rus_sent)

# combiner la phrase française et son label de langage
spacy_fre_sent = str(spacy_sentences[14])
print('French: ' + spacy_fre_sent)

# combiner la phrase russe et française et son label de langage
spacy_multi_sent = str(spacy_sentences[5])
print('Multilang: ' + spacy_multi_sent)
```

Résultats:
``` python
Russian: Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер.
French: — Avant tout dites moi, comment vous allez, chère amie?
Multilang: Je vois que je vous fais peur, садитесь и рассказывайте.
```

Comme vous pouvez l’observer, les deux algorithmes ont tokénisé les phrases de la même manière car les index des listes de phrases créés par NLTK et spaCy sont identiques (les phrases qui nous intéressent se trouvent en position 6, 14, et 5).

#### Tokéniser avec Stanza

Nous allons maintenant répéter cette opération avec Stanza en utilisant son pipeline multilingue. Stanza a recours à des pipelines pour pré-télécharger et enchaîner une série de processeurs qui effectuent chacun une tâche de traitement automatique du langage naturel spécifique (la tokénisation, l’analyse syntaxique, ou encore la reconnaissance d’entités nommées). Pour plus d’information sur les pipelines de Stanza, veuillez consulter [leur documentation](https://perma.cc/R3DS-UE2E).

``` python
from stanza.pipeline.multilingual import MultilingualPipeline

# définir notre pipeline pour tokéniser
nlp = MultilingualPipeline(processors='tokenize')

# appliquer ce pipeline à notre texte
doc = nlp(cleaned_war_and_peace)

# imprimer toutes les phrases pour voir comment elles ont été tokénisées
print([sentence.text for sentence in doc.sentences])
```

Essayons maintenant de retrouver les trois phrases que nous avons utilisées avec NLTK et spaCy ci-dessus. Tout comme spaCy, Stanza convertit le texte traité en tokens qui ne se comportent pas comme des chaînes de caractères.

Nous allons d’abord mettre les tokens de phrases dans une liste pour les convertir en chaîne de caractères. Ceci nous permettra de trouver les phrases spécifiques plus facilement via leur index. Stanza tokénise les phrases dans le texte différemment. Il faut donc changer notre indexation de la phrase en français de la treizième à la douzième position pour s’assurer que les phrases stockées dans les variables restent les mêmes.

``` python
# créer une liste vide pour y rajouter nos phrases
stanza_sentences = []

# itérer à travers chaque token de phrase créé par le pipeline de tokénisation et la rajouter à notre liste
for sentence in doc.sentences:
  stanza_sentences.append(sentence.text)

# imprimer la phrase en russe
stanza_rus_sent = str(stanza_sentences[5])
print('Russian: ' + stanza_rus_sent)

# imprimer la phrase en français
stanza_fre_sent = str(stanza_sentences[12])
print('French: ' + stanza_fre_sent)

# imprimer la phrase en russe et en français
stanza_multi_sent = str(stanza_sentences[4])
print('Multilang: ' + stanza_multi_sent)
```

Résultats:

``` python
Russian: Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер.
French: — Avant tout dites moi, comment vous allez, chère amie?
Multilang: Je vois que je vous fais peur, садитесь и рассказывайте.
```

### Détection automatique de différentes langues

Maintenant que les trois phrases qui nous serviront d’exemples sont prêtes, nous pouvons commencer à les analyser. D’abord, nous allons détecter les langues utilisées dans chaque phrase en commençant par les exemples monolingues.

NLTK contient un module qui s’appelle `TextCat` capable d’identifier des langues en utilisant l’algorithme du même nom. Pour plus d’informations, veuillez consulter la documentation de ce module [ici](https://perma.cc/7EJZ-J5AR). Cet algorithme examine les fréquences de [n-grammes](https://perma.cc/9FJ9-SKC5) (les n-grammes sont des séquences de symboles côte à côte, tels que des lettres ou des syllabes, qui suivent un ordre précis) pour analyser la langue et texte sur lequel nous travaillons. Ensuite, il compare les deux en utilisant une mesure de distance pour estimer la langue du texte. Il faut noter que `TextCat` ne permet pas d’imprimer ses calculs de probabilité pour estimer quelle langue est représentée. Essayons d’utiliser ce module sur les phrases que nous avons précédemment mises dans nos variables.

``` python
# télécharger un lecteur de corpus NLTK requis par le module TextCat
nltk.download('crubadan')

# charger le module TextCat et l'appliquer à chacune de nos phrases
tcat = nltk.classify.textcat.TextCat()
rus_estimate = tcat.guess_language(rus_sent)
fre_estimate = tcat.guess_language(fre_sent)
multi_estimate = tcat.guess_language(multi_sent)

# imprimer les résultats
print('Russian estimate: ' + rus_estimate)
print('French estimate: ' + fre_estimate)
print('Multilingual estimate: ' + multi_estimate)
```

Résultats:

``` python
Russian estimate: rus
French estimate: fra
Multilingual estimate: rus
```

Comme vous pouvez le voir, `TextCat` a correctement identifié les phrases écrites en russe et en français. L’algorithme n’est cependant pas capable d'identifier plus d’une langue par phrase, et a donc estimé que notre phrase multilingue est écrite en russe.

Nous examinerons d’autres manières de détecter les langues dans des phrases multilingues une fois que nous aurons classifié nos phrases en utilisant spaCy et Stanza.

Commençons par spaCy.

``` python
# D’abord, il nous faut installer le package `spacy_langdetect` depuis le Python Package Index.
!pip install spacy_langdetect

# Ensuite, nous pouvons l’importer afin de l’utiliser pour détecter les langues de nos textes.
from spacy.language import Language
from spacy_langdetect import LanguageDetector

nlp = spacy.load("xx_sent_ud_sm")

# Création de la fonction de détection de langage
@Language.factory("language_detector")
def create_language_detector(nlp, name):
    return LanguageDetector()

# ajouter l'outil à notre pipeline
nlp.add_pipe('language_detector', last=True)
```
``` python
# lancer la détection de langue sur chaque phrase et imprimer les résultats
rus_doc = nlp(spacy_rus_sent)
print(rus_doc._.language)

fre_doc = nlp(spacy_fre_sent)
print(fre_doc._.language)

multi_doc = nlp(spacy_multi_sent)
print(multi_doc._.language)
```


Résultats:

```
{'language': 'ru', 'score': 0.9999978739911013}
{'language': 'fr', 'score': 0.999995246346788}
{'language': 'ru', 'score': 0.7142842829707301}
```

Comme attendu, nous obtenons des résultats similaires avec spaCy. Notez que le score de certitude (imprimé après l’abréviation signalant la langue) et bien plus bas pour notre phrase multilingue.

Nous allons maintenant répéter cette opération avec Stanza, qui dispose d’une fonction d'identification de langue intégrée.

``` python
# importer les modèles requis pour la détection de langue
from stanza.models.common.doc import Document
from stanza.pipeline.core import Pipeline

# établir notre pipeline
nlp = Pipeline(lang="multilingual", processors="langid")

# indiquer les phrases à traiter et ensuite lancer le code de détection de langue
docs = [stanza_rus_sent, stanza_fre_sent, stanza_multi_sent]
docs = [Document([], text=text) for text in docs]
docs = nlp(docs)

# imprimer le texte de chaque phrase à côté de l'estimation de langue
print("\n".join(f"{doc.text}\t{doc.lang}" for doc in docs))
```

Résultats

```
Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер.	ru
— Avant tout dites moi, comment vous allez, chère amie?	fr
Je vois que je vous fais peur, садитесь и рассказывайте.	fr
```

Nous pouvons observer que Stanza, contrairement aux autres bibliothèques, a classifié la dernière phrase comme étant de langue française.

Identifier plusieurs langues dans une seule et même phrase n’est pas un problème qui est facile à résoudre ; il requiert une analyse plus poussée qu’une simple approche par phrase. Une méthode potentielle serait de tokéniser la phrase afin de la diviser en ses mots composants, avant d’essayer de détecter la langue de chaque mot. Ensuite, nous pourrions regrouper les mots écrits dans la même langue dans de nouvelles chaînes de caractères, qui chacune contiendrait des mots issus d’une seule langue. Dans notre cas, on pourrait également diviser la chaîne de caractère dans les différentes langues qui la composent en détectant et séparant tous les écrits en alphabet non-romain dans une chaîne de caractères qui leur est propre. Voici à quoi ressemblerait l’implémentation de cette méthode.

Nous commençons par tokéniser la phrase en mots en utilisant le module `wordpunct_tokenize`. Comme nous l’avons vu précédemment, le fait de tokéniser notre texte en phrases nous permet d’accomplir d’autres opérations par la suite.

``` python
from nltk.tokenize import wordpunct_tokenize
tokenized_sent = wordpunct_tokenize(multi_sent)
```

Ensuite, nous allons examiner chaque mot pour voir s’il contient des caractères [cyrilliques](https://perma.cc/7FQY-LMHK) et diviser les tokens de mots en deux chaînes de caractères : une contenant les mots écrits en cyrillique et une contenant ceux écrits avec l’alphabet latin. Pour nous simplifier la tâche, nous ne prendrons pas en compte les symboles de ponctuation dans cet exemple. Nous utilisons ensuite une expression régulière (une séquence de caractères qui indique les caractères à identifier dans un texte) pour détecter les caractères cyrilliques. (Pour en apprendre plus sur les expressions régulières, [cette leçon du _Programming Historian_](https://programminghistorian.org/en/lessons/understanding-regular-expressions) est une bonne ressource).


``` python
# importer le package regex pour utiliser des expressions régulières
import regex
# importer le package string pour détecter la ponctuation
from string import punctuation

# créer des listes vides pour y mettre nos mots plus tard
cyrillic_words = []
latin_words = []
```

Nous allons ensuite itérer sur chaque mot de notre phrase avec RegEx pour détecter les caractères cyrilliques. Si des caractères cyrilliques sont identifiés, nous rajoutons le mot auquel ils appartiennent à notre liste `cyrillic_words` ; sinon, nous rajoutons le mot à la liste `latin_words`. Si un de nos mots tokénisés consiste uniquement de ponctuation, nous continuons sans le rajouter à aucune des deux listes. Nous pouvons ensuite imprimer les listes pour voir ce qui y a été ajouté.

``` python
for word in tokenized_sent:
  if word in punctuation:
    continue
  else:
    if regex.search(r'\p{IsCyrillic}', word):
      cyrillic_words.append(word)
    else:
        latin_words.append(word)


print(cyrillic_words)
print(latin_words)
```

Résultats:

```
['садитесь', 'и', 'рассказывайте']
['Je', 'vois', 'que', 'je', 'vous', 'fais', 'peur']
```

Enfin, nous pouvons transformer nos listes en chaînes de caractères, ce qui nous permettra d’y appliquer l’algorithme `TextCat`.

``` python
# rejoindre les listes en chaînes de caractères, où chaque mot est séparé par un espace (' ')
cyrillic_only_list = ' '.join(cyrillic_words)
latin_only_list = ' '.join(latin_words)

# réutilser TextCat pour détecter les langues
tcat = nltk.classify.textcat.TextCat()
multi_estimate_1 = tcat.guess_language(cyrillic_only_list)
multi_estimate_2 = tcat.guess_language(latin_only_list)

# imprimer les estimations
print('Cyrillic estimate: ' + multi_estimate_1)
print('Latin estimate: ' + multi_estimate_2)
```

Résultats:

```
Cyrillic estimate: rus
Latin estimate: fra
```

Il est évident que cette méthode ne peut pas fonctionner sur chaque texte, étant donné que nous bénéficions de l’avantage d’avoir un texte dont une seule langue est écrite en alphabet cyrillique. Si notre texte contenait plusieurs langues écrites en cyrillique, il faudrait adopter une approche différente. L’on pourrait par exemple tenter d’identifier certains caractères cyrilliques qui sont uniques à une de ces langues, ou bien qui y soient au moins utilisés plus couramment.

### L'étiquetage morpho-syntaxique

Nous allons désormais procéder à l’étiquetage morpho-syntaxique de nos phrases en utilisant spaCy et Stanza.

Le package NLTK ne permet pas d'effectuer l’étiquetage morpho-syntaxique de langues autre que l’anglais, mais il est possible d’entraîner votre propre modèle en utilisant un corpus étiqueté dans la langue de votre choix. La documentation concernant l’étiqueteur et comment en développer un vous-même est disponible [ici](https://perma.cc/XZ9M-7UR4).

#### L’étiquetage morpho-syntaxique avec spaCy

Étiqueter nos phrases avec spaCy est très facile. Étant donné que nous savons que nous travaillons avec du russe et du français, nous pouvons télécharger les modèles spaCy de ces langues et les utiliser pour attribuer les étiquettes morpho-syntaxiques aux mots de nos phrases. La syntaxe est la même pour chaque modèle de langage que nous utilisons. Commençons par le russe.

``` python
# télécharger le modèle de langage russe depuis spaCy
#note: si vous travaillez depuis un Jupyter notebook, rajout "!" au début de la ligne d'installation
python -m spacy download ru_core_news_sm
```
``` python
# charger le modèle
nlp = spacy.load("ru_core_news_sm")

# appliquer le modèle
doc = nlp(spacy_rus_sent)

# imprimer chaque mot et son étiquette
for token in doc:
    print(token.text, token.pos_)
```

Résultats:

```
Так ADV
говорила VERB
в ADP
июле NOUN
1805 ADJ
года NOUN
известная ADJ
Анна PROPN
Павловна PROPN
Шерер PROPN
, PUNCT
фрейлина NOUN
и CCONJ
приближенная ADJ
императрицы NOUN
Марии PROPN
Феодоровны PROPN
, PUNCT
встречая VERB
важного ADJ
и CCONJ
чиновного ADJ
князя NOUN
Василия PROPN
, PUNCT
первого ADJ
приехавшего VERB
на ADP
ее DET
вечер NOUN
. PUNCT
```

Faisons maintenant de même avec notre phrase en français.

``` python
# charger le corpus
nlp = spacy.load("fr_core_news_sm")

# appliquer le modèle
doc = nlp(spacy_fre_sent)

# imprimer chaque mot et son étiquette
for token in doc:
    print(token.text, token.pos_)
```
Résultats:

```
— PUNCT
Avant ADP
tout ADV
dites VERB
moi PRON
, PUNCT
comment ADV
vous PRON
allez VERB
, PUNCT
chère ADJ
amie NOUN
? PUNCT
```

Pour le texte multilingue, nous pouvons utiliser les mots que nous avons généré au préalable pour étiqueter chaque langue séparément avant de recombiner les mots pour former une phrase complète.

Ci-dessous, nous divisons notre phrase en mots russe et français comme nous l’avons fait auparavant, mais nous gardons cette fois-ci la ponctuation. Nous accomplissons ceci en rajoutant les signes de ponctuation à la dernière liste à laquelle nous avons rajouté un mot : ceci préserve le bon emplacement de chaque signe de ponctuation (la ponctuation sera ajoutée à la même liste que le mot qui l’a précédé). Ce procédé sera utile à quiconque souhaite pouvoir préserver la ponctuation originelle du texte dans leur analyse. Pour y parvenir, nous avons besoin de créer une nouvelle variable – `last_appended_list` – pour pouvoir vérifier quelle est la dernière liste à laquelle nous avons rajouté des données. Par exemple, si un point suit le mot bonjour, alors notre variable `last_appended_list` devrait montrer que la dernière liste à laquelle nous avons ajouté un mot est `latin_words`. Nous pouvons donc ajouter le point à la liste `latin_words` où il suivra correctement le mot qui l’a précédé.

``` python
# créer des listes vides pour y rajouter des données plus tard
cyrillic_words_punct = []
latin_words_punct = []

# créer une chaîne de caractères vide pour savoir quelle est la dernière liste à laquelle des données ont été ajoutées
last_appended_list = ''

# itérer sur chaque mot et les rajouter aux listes en fonction de si un caractère cyrillique est détecté
for word in tokenized_sent:
  if regex.search(r'\p{IsCyrillic}', word):
    cyrillic_words_punct.append(word)
    # mettre la variable à jour pour tenir compte de la dernière liste à laquelle des données ont été ajoutées
    last_appended_list = 'cyr'
  else:
    # joindre les symboles de ponctuation à la dernière liste à laquelle un mot a été rajoutée
    if word in punctuation:
        if last_appended_list == 'cyr':
            cyrillic_words_punct.append(word)
        elif last_appended_list == 'lat':
            latin_words_punct.append(word)
    else:
        latin_words.append(word)
        last_appended_list = 'lat'

print(cyrillic_words)
print(latin_words)
```

Résultats:
```
['садитесь', 'и', 'рассказывайте', '.']
['Je', 'vois', 'que', 'je', 'vous', 'fais', 'peur', ',']
```

Nous pouvons ensuite combiner ces listes en chaînes de caractères, ce qui nous permettra d’appliquer l’algorithme de détection de langue. Nous utilisons une expression régulière pour enlever l’espace devant chaque point de ponctuation (cette espace a été créé lorsque nous avons tokénisé la phrase en mots). Ceci préserve la ponctuation telle qu’elle était présente dans la phrase d’origine.

``` python
# joindre les listes en chaînes de caractères
cyrillic_only_list = ' '.join(cyrillic_words)
latin_only_list = ' '.join(latin_words)

# utiliser les expressions régulières pour enlever les espaces devant les points de ponctuation
cyr_no_extra_space = regex.sub(r'\s([?.!,"](?:\s|$))', r'\1', cyrillic_only_list)
lat_no_extra_space = regex.sub(r'\s([?.!,"](?:\s|$))', r'\1', latin_only_list)

# vérifier les résultats de l'expression régulière
print(cyr_no_extra_space)
print(lat_no_extra_space)
```

Résultats:

```
садитесь и рассказывайте.
Je vois que je vous fais peur,
```

Enfin, nous pouvons étiqueter chaque liste de mots en utilisant le modèle de langage approprié. Il suffit de charger le modèle et l’appliquer au texte russe et français avant d’imprimer les résultats.

``` python
# charger et appliquer le modèle
nlp = spacy.load("ru_core_news_sm")
doc = nlp(cyr_no_extra_space)

# imprimer chaque mot et son étiquette
for token in doc:
    print(token.text, token.pos_)

# et faire de même pour la phrase en français
nlp = spacy.load("fr_core_news_sm")
doc = nlp(lat_no_extra_space)
for token in doc:
    print(token.text, token.pos_)
```

Résultats:

```
садитесь VERB
и CCONJ
рассказывайте VERB
. PUNCT
Je PRON
vois VERB
que SCONJ
je PRON
vous PRON
fais VERB
peur NOUN
, PUNCT
```

#### L’étiquetage morpho-syntaxique avec Stanza

Faisons maintenant de même avec Stanza. Commençons par le russe : il faut charger le pipeline russe, l’appliquer à notre phrase, et imprimer les étiquettes morpho-syntaxique détectées par Stanza.

``` python
# charger le pipeline et l'appliquer à notre phrase en spécifiant la langue comme étant le russe ('ru')
nlp = stanza.Pipeline(lang='ru', processors='tokenize,pos')
doc = nlp(stanza_rus_sent)

# imprimer les mots et leurs étiquettes
print(*[f'word: {word.text}\tupos: {word.upos}' for sent in doc.sentences for word in sent.words], sep='\n')
```

Résultats:

```
word: Так	upos: ADV
word: говорила	upos: VERB
word: в	upos: ADP
word: июле	upos: NOUN
word: 1805	upos: ADJ
word: года	upos: NOUN
word: известная	upos: ADJ
word: Анна	upos: PROPN
word: Павловна	upos: PROPN
word: Шерер	upos: PROPN
word: ,	upos: PUNCT
word: фрейлина	upos: NOUN
word: и	upos: CCONJ
word: приближенная	upos: VERB
word: императрицы	upos: NOUN
word: Марии	upos: PROPN
word: Феодоровны	upos: PROPN
word: ,	upos: PUNCT
word: встречая	upos: VERB
word: важного	upos: ADJ
word: и	upos: CCONJ
word: чиновного	upos: ADJ
word: князя	upos: NOUN
word: Василия	upos: PROPN
word: ,	upos: PUNCT
word: первого	upos: ADJ
word: приехавшего	upos: VERB
word: на	upos: ADP
word: ее	upos: DET
word: вечер	upos: NOUN
word: .	upos: PUNCT
```

Nous ferons maintenant de même pour notre phrase en français, en utilisant la même syntaxe, mais avec le modèle de langage francophone.


``` python
# charger le pipeline et l'appliquer à notre phrase en spécifiant la langue comme étant le français ('fr')
nlp = stanza.Pipeline(lang='fr', processors='tokenize,mwt,pos')
doc = nlp(stanza_fre_sent)

# imprimer les mots et leurs étiquettes
print(*[f'word: {word.text}\tupos: {word.upos}' for sent in doc.sentences for word in sent.words], sep='\n')
```
Résultats:

```
word: —	upos: PUNCT
word: Avant	upos: ADP
word: tout	upos: PRON
word: dites	upos: VERB
word: moi	upos: PRON
word: ,	upos: PUNCT
word: comment	upos: ADV
word: vous	upos: PRON
word: allez	upos: VERB
word: ,	upos: PUNCT
word: chère	upos: ADJ
word: amie	upos: NOUN
word: ?	upos: PUNCT
```

Pour l’analyse multilingue, le pipeline multilingue de Stanza nous permet d’appliquer une approche plus simple qu’avec spaCy, étant donné qu’elle peut produire les étiquettes morpho-syntaxique en utilisant la même syntaxe que les exemples précédents. Il nous faut importer le pipeline multilingue, l’appliquer à notre texte, et ensuite imprimer les résultats.

``` python
# imports requis pour utiliser la MultilingualPipeline de Stanza
from stanza.models.common.doc import Document
from stanza.pipeline.core import Pipeline
from stanza.pipeline.multilingual import MultilingualPipeline

# lancer le pipeline multilingue sur les phrases françaises, russes, et multilingue en même temps 
nlp = MultilingualPipeline(processors='tokenize,pos')
docs = [stanza_rus_sent, stanza_fre_sent, stanza_multi_sent]
docs = nlp(docs)

# imprimer les résultats
print(*[f'word: {word.text}\tupos: {word.upos}' for sent in doc.sentences for word in sent.words], sep='\n')
```
Résultats:

```
word: Так	upos: ADV
word: говорила	upos: VERB
word: в	upos: ADP
word: июле	upos: NOUN
word: 1805	upos: ADJ
word: года	upos: NOUN
word: известная	upos: ADJ
word: Анна	upos: PROPN
word: Павловна	upos: PROPN
word: Шерер	upos: PROPN
word: ,	upos: PUNCT
word: фрейлина	upos: NOUN
word: и	upos: CCONJ
word: приближенная	upos: VERB
word: императрицы	upos: NOUN
word: Марии	upos: PROPN
word: Феодоровны	upos: PROPN
word: ,	upos: PUNCT
word: встречая	upos: VERB
word: важного	upos: ADJ
word: и	upos: CCONJ
word: чиновного	upos: ADJ
word: князя	upos: NOUN
word: Василия	upos: PROPN
word: ,	upos: PUNCT
word: первого	upos: ADJ
word: приехавшего	upos: VERB
word: на	upos: ADP
word: ее	upos: DET
word: вечер	upos: NOUN
word: .	upos: PUNCT
```

### La lemmatisation

Pour finir, nous allons lemmatiser nos phrases en utilisant spaCy et Stanza (NLTK ne dispose pas d’algorithme de lemmatisation intégré pour des langues autres que l’anglais). La lemmatisation est le procédé par lequel on remplace toutes les formes [infléchies](https://perma.cc/VXG6-4SG5) d’un mot (vois, vue) par un seul objet que l’on appelle le lemme, qui représente la forme la plus basique du mot (dans ce cas, voir). Par exemple, la phrase, « j’ai écrit une lettre » serait « je avoir écrire une lettre ».

#### Lemmatiser avec spaCy

Pour couper au court, nous utilisons uniquement la phrase multilingue comme exemple pour montrer la lemmatisation avec spaCy. Cependant, spaCy ne contient pas de corpus de lemmatisation multilingue. Il faut donc d’abord diviser la phrase multilingue en une liste de mots qu’elle contient. Nous pouvons ensuite y appliquer les différents modèles de langue russe et français. Pour plus d’informations concernant la lemmatisation avec spaCy, y compris une liste de langues intégrées dans la bibliothèque, visiter la [documentation de lemmatisation](https://perma.cc/JE4M-CN7D) de spaCy.

Il faut d'abord charger nos modèles avant de les appliquer à nos textes et imprimer les lemmes produits par spaCy. Commençons avec le russe.

``` python
# charger et appliquer le modèle
nlp = spacy.load("ru_core_news_sm")
doc = nlp(cyr_no_extra_space)

# imprimer les mots et leurs lemmes
for token in doc:
    print(token, token.lemma_)
```

Résultats:

```
садитесь садитесь
и и
рассказывайте рассказывать
. .
```

Et maintenant le texte français :

``` python
# charger et appliquer le modèle

nlp = spacy.load("fr_core_news_sm")
doc = nlp(lat_no_extra_space)

# imprimer les mots et leurs lemmes
for token in doc:
    print(token, token.lemma_)
```

Résultats:

```
Je je
vois voir
que que
je je
vous vous
fais faire
peur peur
, ,
```

#### Lemmatiser avec Stanza

Pour finir, procédons maintenant à la lemmatisation des phrases russes, françaises, et multilingue avec Stanza. La syntaxe est très similaire à celle utilisée pour l’étiquetage morpho-syntaxique avec le pipeline multilingue.

``` python
# imports requis pour le pipeline multilingue
from stanza.models.common.doc import Document
from stanza.pipeline.core import Pipeline
from stanza.pipeline.multilingual import MultilingualPipeline

# rajouter le processeur de lemmes au pipeline et l'appliquer à nos phrases
nlp = MultilingualPipeline(processors='tokenize,lemma')
docs = [stanza_rus_sent, stanza_fre_sent, stanza_multi_sent]
nlped_docs = nlp(docs)

# itérer à travers chaque mot de chaque phrase et imprimer les lemmes
for doc in nlped_docs:
  lemmas = [word.lemma for t in doc.iter_tokens() for word in t.words]
  print(lemmas)
```

Nos résultats montrent les phrases russes, françaises, et multilingues lemmatisées et imprimées en liste de mots.

```
['так', 'говорить', 'в', 'июль', '1805', 'год', 'известный', 'Анна', 'Павловна', 'Шерер', ',', 'фрейлить', 'и', 'приближенный', 'императрица', 'Мария', 'феодоровнянный', ',', 'встречать', 'важный', 'и', 'чиновный', 'князь', 'Василий', ',', 'первый', 'приехать', 'на', 'она', 'вечер', '.']
['успокойте', 'я', ',', '—ат', 'сказать', 'он', ',', 'не', 'изменять', 'голос', 'и', 'тон', ',', 'в', 'который', 'из-за', 'приличие', 'и', 'участие', 'просвечивальский', 'равнодушие', 'и', 'даже', 'насмешка', '.']
['moi', 'voir', 'que', 'moi', 'vous', 'faire', 'peur', ',', 'садитесь', 'и', 'рассказывайте', '.']
```

Comme nous pouvons observer, la lemmatisation des phrases a remplacé nos mots avec leurs formes infléchies, telles que l’on les trouverait dans le dictionnaire. Le verbe **vois** dans la phrase française par exemple a été remplacé par son infinitif **voir**, et le russe **говорила** a été remplacé par son infinitif **говорить**.

Ce procédé est utile lorsque vous voulez identifier toutes les instances d’un mot particulier dans un texte : par exemple, si vous souhaitiez examiner plusieurs thèmes liés à la vue et la vision dans le texte, la lemmatisation vous permettrait d’identifier chaque apparition du lemme voir sans que ne deviez vous préoccuper de toutes ses potentielles déclinaisons. Pour cette même raison, la lemmatisation permet également de compter les fréquences avec lesquelles les mots apparaissent de manière bien plus précise et ce particulièrement pour des langues hautement flexionnelles.

## Conclusion

Vous possédez désormais d’une connaissance de base des différents packages que vous pouvez utiliser pour l’analyse de texte multilingue et qui pourra, nous l’espérons, vous guider dans vos projets personnels. Vous avez également pu comprendre comment approcher du texte non anglais en utilisant des méthodes de TALN et avez découvert quelques stratégies pour travailler avec du texte multilingue qui vous aideront à développer des méthodologies adaptées à vos propres besoins.

Nous avons appris comment tokéniser du texte, reconnaître des langues de manière automatique, identifier les composants morpho-syntaxiques et lemmatiser un texte comprenant plusieurs langues. Ces étapes de prétraitement permettent de préparer le texte à des analyses plus approfondies telles que l’analyse des sentiments ou le topic modelling, ou pourrait également déjà vous permettre d’obtenir quelques résultats d’analyses qui seraient bénéfiques à vos travaux. Et surtout, vous avez désormais une base de connaissance et quelques exemples de code qui vous ouvrent de nouvelles opportunités pour comprendre et appliquer des outils informatiques à des textes multilingues et non anglais. Ceci va élargir les champs de recherche avec lesquels vous pouvez interagir et approfondir votre compréhension des humanités numériques telles qu’elles sont exercées sur du texte non anglais ou multilingue.

## Lecture suggérée

**Leçons similaires de _Programming Historian_**

Les leçons qui suivent peuvent vous aider avec différents aspects du traitement automatique du langage naturel non anglais et multilingue.

- [Corpus Analysis with spaCy](/en/lessons/corpus-analysis-with-spacy): Cette leçon est une explication approfondie de l'utilisation de spaCy pour analyser un corpus de texte, et explique les capacités et fonctionnement de spaCy avec plus de détails. C'est une lecture plus que recommandée si vous souhaitez utiliser spaCy pour vos travaux.

- [Normalizing Textual Data with Python](/en/lessons/normalizing-data): Cette leçon explique les différentes méthodes de normalisation de texte avec Python et sera particulièrement utile à celles et ceux qui ont besoin d'aide pour préparer leurs données textuelles à l'analyse numérique.

**Autres ressources en rapport au traitement automatique du langage naturel multilingue et aux humanités numériques**

- [Multilingual Digital Humanities](https://doi.org/10.4324/9781003393696): Un livre publié récemment qui couvre plusieurs sujets et projets d'humanités numériques multilingues, rassemblant un vaste spectre d'auteur et tourné vers une audience internationale (Spoiler: l'auteur a un chapitre dans ce livre).
  
- [multilingualdh.org](https://multilingualdh.org/en/): Le site web du groupe Multilingual DH, un "réseau souple de chercheurs et chercheuses qui appliquent les outils et les méthodes des humanités numériques à d’autres langues que l’anglais". Le [dépot Github du groupe](https://github.com/multilingual-dh) contient également des ressources utiles, y compris [cette bibliographie](https://github.com/multilingual-dh/multilingual-dh-bibliography) ainsi que [cette liste d'outils pour le traitement automatique du langage naturel multilingue](https://github.com/multilingual-dh/TALN-resources).

- Agarwal, M., Otten, J., & Anastasopoulos, A. (2024). Script-agnostic language identification. arXiv.org. [https://doi.org/10.48550/arXiv.2406.17901](https://doi.org/10.48550/arXiv.2406.17901): Cet article démontre que la randomisation de mots et l'exposition à une langue écrite en plusieurs écritures est important pour une identification de langue qui soit indépendante de l'écriture utilisée, et sera d'intérêt pour celles et ceux qui explorent les écrits scientifiques sur la reconnaissance de langue par voie d'ordinateur.

- Dombrowski, Q. (2020). Preparing Non-English Texts for Computational Analysis. Modern Languages Open, 1. [https://doi.org/10.3828/mlo.v0i0.294](https://doi.org/10.3828/mlo.v0i0.294): Cette leçon couvre quelques défis majeurs au traitement automatique du langage naturel posés par la grammaire ou système d'écriture de plusieurs langues autres que l'anglais et démontre comment surmonter ces problématiques. Il sera utile pour celles et ceux qui cherchent à étendre leurs compétences quand il s'agit d'appliquer des méthodes de traitement automatique du langage naturel sur des langues autre que l'anglais.

- Dombrowski, Q. (2020). What’s a "Word": Multilingual DH and the English Default. [https://quinndombrowski.com/blog/2020/10/15/whats-word-multilingual-dh-and-english-default/undefined.](https://perma.cc/A5YS-2DUU): Cette présentation donnée à l'édition de 2020 de la _McGill DH Spectrums of DH series_ contient une excellente introduction à l'importance et la valeur du fait de travailler et populariser avec des langues autres que l'anglais dans les humanités numériques.

- Velden, Mariken A. C. G. van der, Martijn Schoonvelde, and Christian Baden. 2023. “Introduction to the Special Issue on Multilingual Text Analysis.” Computational Communication Research 5 (2). [https://doi.org/10.5117/CCR2023.2.1.VAND](https://doi.org/10.5117/CCR2023.2.1.VAND): Cette édition sera particulièrement intéressante pour celles et ceux qui cherchent des cas de recherche scientifique de traitement automatique du langage naturel multilingue, ou qui s'intéressent à l'état de l'analyse de texte multilingue dans la littérature scientifique contemporaine.
