---
title: "Extraire, nettoyer et analyser un corpus avec Pandore Toolbox"
slug: extraire-nettoyer-analyser-avec-pandore-toolbox
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Floriane Chiffoleau
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/716
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

### Objectifs de la leçon
Cette leçon a pour objectif de vous initier à l'utilisation de certaines des fonctionnalités de la Pandore Toolbox, un ensemble de modules permettant d'effectuer automatiquement les tâches les plus courantes liées au traitement de corpus pour la recherche en humanités numériques.
À travers cette leçon, vous découvrirez et apprendrez à utiliser diverses techniques d'analyse et de récupération d'informations.

La leçon se déroulera en trois étapes avec des tâches spécifiques pour certaines : 
1. Extraction du corpus
	* Récupération du corpus
	* Transcription du corpus
2. Nettoyage du corpus
3. Analyse du corpus
	* Étiquetage morphosyntaxique
	* Reconnaissance d'entités nommées
	* Analyse linguistique
	* Analyse statistique


### Prérequis
L'utilisation de la Pandore Toolbox ne requiert rien d'autre qu'une connexion Internet afin d'avoir accès à l'instance, ainsi qu'un accès, à portée de clic, à votre dossier de "Téléchargements", où s'enregistreront les diverses sorties de l'interface.

## L'outil : Pandore Toolbox
### Histoire de l'outil
La Pandore Toolbox a été mise en place par l'équipe de l'[Observatoire des Textes, des Idées et des Corpus (ObTIC)](https://obtic.sorbonne-universite.fr/) afin de fournir une série d'outils faciles d'utilisation et d'accès, d'abord aux étudiants et chercheurs de Sorbonne Université, à laquelle appartient l'équipe, puis à la communauté scientifique.  

La boîte à outils a fait l'objet de présentations lors de diverses conférences, tels que [TALN Récital 2022](https://hal.science/TALN-RECITAL2022/hal-03701464), [DH2025](https://hal.science/hal-04986730) et [Humanistica 2026](https://hal.science/hal-05635965v1), ainsi que de formations au sein de Sorbonne Université.

### Composition de l'outil

{% include figure.html filename="fr-or-extraire-nettoyer-analyser-avec-pandore-toolbox-01.png" alt="Page d'accueil de la Pandore Toolbox" caption="Figure 1. Page d'accueil de la Pandore Toolbox." %}

L'instance Pandore Toolbox présente un certain nombre de tâches, contenant elles-mêmes divers outils. Cela va de la collecte de corpus à la conversion de formats, de l'annotation automatique à l'extraction d'informations, du prétraitement à l'analyse de texte.

Chaque outil contient un descriptif précisant ce qu'il réalise, ce qu'il faut soumettre en entrée et ce qui sera généré en sortie. De plus, une documentation approfondie est également fournie pour chacune des tâches et ses actions. Dans les cas où l'outil peut s'avérer trop compliqué pour un simple descriptif, un tutoriel détaillé est proposé.

## Extraction du corpus
### Récupération du corpus
#### Choisir sa bibliothèque numérique
Pandore Toolbox offre plusieurs options pour la collecte de corpus, dont notamment trois bibliothèques numériques : 

* Wikisource, qui est une bibliothèque numérique de textes du domaine public, hébergée par la fondation Wikimédia, comme Wikipédia, avec un contenu librement améliorable, et qui a pour objet de rendre accessibles de manière plus facile et pérenne des textes déjà publiés par ailleurs.
* Project Gutenberg, qui est une bibliothèque de plus de 75 000 livres numériques gratuits, contenant des chefs-d’œuvre littéraires, avec une prédilection pour les œuvres anciennes dont les droits d’auteur américains ont expiré.
* Gallica, qui est la bibliothèque numérique de la BNF, qui offre un accès libre et gratuit de plusieurs millions de documents numérisés de toutes époques et de tous supports.

Cependant, parmi ces trois options, les deux premières ne fournissent que des versions texte du contenu. Ainsi, pour cette leçon, la démonstration se fera avec Gallica, afin de récupérer des documents image pour l'étape suivante.

#### Collecte des images avec Gallica
Depuis la page d'accueil où vous trouverez toutes les tâches disponibles, cliquez sur "Collecte de corpus". Ensuite, choisissez la deuxième option : "Gallica". Depuis cet outil, qui est lié à l'API de Gallica, vous avez la possibilité d'extraire des documents de la bibliothèque numérique de la BNF.

Afin de découvrir l'interface Pandore et ses outils, le texte qui a été choisi pour les diverses tâches sera extrait de l'édition de 1884 de l'ouvrage *Guerre et Paix - Tome 1* écrit par Léon Tolstoï [https://gallica.bnf.fr/ark:/12148/bpt6k96461k].

<div class="alert alert-warning">
L'API ne permet pas de télécharger un nombre illimité de documents de Gallica. De plus, il est nécessaire de ne pas surcharger le serveur où est hébergée l'instance Pandore afin de permettre le bon déroulement du processus d'analyse.
</div>

Depuis la page de l'outil "Gallica", vous avez la possibilité de récupérer deux types de format : Images IIIF et Texte (HTML), ce dernier n'étant possible seulement si une version texte est disponible elle-même sur la bibliothèque numérique. Dans le cas où vous souhaitez extraire la version texte d'ouvrages du domaine public, il sera conseillé d'utiliser plutôt les outils 'Wikisource' et 'Project Gutenberg' également présents dans la tâche 'Collecte de corpus', comme mentionné plus tôt.

Après vous être assurés que l'option "Images IIIF" était bien l'option cochée, mettez votre curseur sur la zone de texte et collez-y l'information suivante : `bpt6k96461k 43 5`.

* La première suite de caractères alphanumériques fait référence à l'ark de l'ouvrage *Guerre et Paix* de 1884, c'est-à-dire l'identifiant de l'ouvrage dans le catalogue numérique de la BNF.
* Le nombre trouvé ensuite fait référence à la page à partir de laquelle vous souhaitez extraire des images de l'ouvrage tel qu'il est présenté dans le catalogue de la BNF. Dans ce cas précis, cela représente la première page du chapitre X de l'ouvrage, dont la foliation indique "38".
* Le dernier chiffre désigne le nombre de pages que vous souhaitez extraire de l'ouvrage. Le comptage se fait à partir de la page même d'où cela commence. Ainsi, vous aurez les pages 38 à 42.

Une fois l'information copiée dans la zone de texte, cliquez sur  le bouton **Envoyer**.

Après un temps de chargement plus ou moins long, le contenu récupéré sera disponible dans votre dossier de `Téléchargements` dans un fichier zip dont le nom sera `gallica_XXXXX`, les cinq X étant remplacés par une suite aléatoire de caractères alphabétiques.

<div class="alert alert-warning">
Cette méthode de nommage de dossier ou fichier est utilisée pour toutes les tâches de l'interface Pandore. Vous trouverez donc cela pour chacun des exercices pratiques qui seront présentés sous la forme `tache_XXXXX`
</div>

{% include figure.html filename="fr-or-extraire-nettoyer-analyser-avec-pandore-toolbox-02.png" alt="Contenu du dossier ZIP avec cinq images et un rapport de téléchargement" caption="Figure 2. La sortie Gallica fournit les images, au format JPG, avec leur numéro et un rapport de téléchargement." %}

Le contenu du dossier, comme montré dans l'image ci-dessus, se compose des images de l'ouvrage, ainsi qu'un fichier `download_report.txt` qui contient le texte suivant, indiquant que le téléchargement a été fait avec succès :

`1 ARK(s) traité(s) avec succès.  
https://gallica.bnf.fr/iiif/ark:/12148/bpt6k96461k/f43/full/full/0/default.jpg  
https://gallica.bnf.fr/iiif/ark:/12148/bpt6k96461k/f44/full/full/0/default.jpg  
https://gallica.bnf.fr/iiif/ark:/12148/bpt6k96461k/f45/full/full/0/default.jpg  
https://gallica.bnf.fr/iiif/ark:/12148/bpt6k96461k/f46/full/full/0/default.jpg  
https://gallica.bnf.fr/iiif/ark:/12148/bpt6k96461k/f47/full/full/0/default.jpg  
`

Afin de pouvoir procéder correctement à l'étape suivante, les images devront être extraites du fichier zip. Le fichier texte, lui, peut être supprimé sans risque.

### Transcription du corpus 
#### Choisir son outil
Pour la reconnaissance automatique de texte, Pandore Toolbox propose deux options :

* Le logiciel Tesseract, qui est un moteur de reconnaissance de caractères *open source*, principalement conçu pour la reconnaissance de texte imprimé. Il offre de bonnes performances sur des documents bien structurés et prend en charge de nombreuses langues, de diverses parties du monde.
* Le logiciel Kraken, qui est un moteur de reconnaissance de caractères *open source* orienté vers la reconnaissance de documents historiques et manuscrits. Il combine des modèles de segmentation de pages et de lignes avec des modèles de reconnaissance neuronale entraînables, particulièrement adapté aux écritures non standardisées, anciennes ou dégradées.

Dans le cas de la leçon qui est proposée ici, les images extraites depuis Gallica sont tirées d'un ouvrage imprimé. Ainsi, la démonstration se fera à partir de Tesseract.

#### Reconnaissance de texte avec Tesseract
Selon où vous vous trouvez sur l'interface Pandore, vous avez plusieurs moyens d'avoir accès à la tâche "Reconnaissance automatique de texte (ATR)" à partir de laquelle vous trouverez Tesseract :

* Si vous êtes encore sur la page de l'outil Gallica, vous pouvez cliquer en haut à gauche de la page sur "Retour aux tâches", puis cliquez en haut à droite sur "Tâche suivante". Vous vous retrouverez alors sur la page de tâche "Reconnaissance automatique de texte (ATR)".
* Si vous êtes sur la page d'accueil, il vous suffit de cliquer sur la deuxième tâche présentée dans la ligne : "Reconnaissance automatique de texte (ATR)".
* Si vous êtes sur une quelconque autre page, vous pouvez passer votre curseur sur la barre de navigation jusqu'à "Tâches" et à partir du menu déroulant, trouvez "Reconnaissance automatique de texte (ATR)" et cliquez dessus.

Une fois sur la page de la tâche "Reconnaissance automatique de texte (ATR)", cliquez sur l'outil "Reconnaissance automatique de texte (ATR)" avec l'icône contenant le T.

Depuis cet outil, vous avez la possibilité de récupérer automatiquement tout texte venant d'images, tant que celles-ci contiennent du texte imprimé. 

L'outil donne la possibilité de travailler avec des textes dans différentes langues. Vous avez ainsi la possibilité de choisir la langue pour votre reconnaissance de texte depuis "Modèle". De plus, si vous avez des textes bilingues, il vous est possible de sélectionner une deuxième langue en appuyant sur le bouton "Ajouter". Une fois cliqué, cela vous proposera les mêmes modèles.

Par défaut, la langue choisie pour la reconnaissance est "Français (fr)". Vous n'aurez donc pas à changer, ici, la langue dans le menu déroulant, puisque la leçon se fait avec du texte en français. Ce sera également le cas pour la suite des exercices qui seront proposés dans cette leçon.

Une fois la langue sélectionnée, vous devez importer les images que vous avez téléchargées à partir de Gallica. Pour ce faire, vous avez deux options :

* Sur votre ordinateur, depuis le dossier où vous avez les images récupérées de Gallica, sélectionnez-les toutes et faites-les glisser dans la zone de dépôt.
* Depuis la page de l'outil, cliquez sur la zone de dépôt. Cela ouvrira votre explorateur de fichiers. A partir de là, trouvez le dossier des images Gallica, sélectionnez-les toutes puis cliquez sur "Ouvrir"

Dès que les images ont été importées, cliquez sur le bouton **Reconnaissance de texte**.

Une fois que le traitement est fini, un fichier texte `ocr_XXXXX` est produit, qui contient le texte de toutes les pages concaténées dans un même document.

Ouvrez le fichier dans un éditeur de texte, qui devra contenir notamment le bout de texte ci-dessous.

{% include figure.html filename="fr-or-extraire-nettoyer-analyser-avec-pandore-toolbox-03.png" alt="Version transcrite du téléchargement Gallica" caption="Figure 3. Sortie diplomatique, avec sauts de ligne et coupure de mots, de la transcription des images." %}

## Nettoyage du corpus
L'exercice suivant se fait à partir de la tâche "Prétraitement" et se nomme "Nettoyage de texte". Cet outil propose plusieurs fonctionnalités en fonction du type de nettoyage que vous souhaitez faire avec votre document. Il est ainsi possible de modifier, de manière importante, le texte en enlevant la ponctuation (option 2), en mettant tout en minuscule (option 1) ou même en supprimant des mots, et plus particulièrement les mots-vides (option 3). Cela a généralement vocation à être fait pour préparer son texte en vue d'analyse précise, et donc d'enlever tout ce qui pourrait représenter du bruit pour l'analyse. 

Dans le cas de l'exercice ici, l'objectif est de supprimer le bruit qui a été créé par la sortie de reconnaissance de texte, dû à la structure même du texte dans les images reconnues ou même à la manière dont Tesseract produit ses sorties.

Vous allez donc sélectionner l'option 4, qui permet d'enlever les lignes vides ou ne contenant que des caractères spéciaux, ainsi que l'option 5, qui s'occupent des retours d'OCR, c'est-à-dire qu'ils enlèvent tous les sauts de lignes, dû à la largeur des livres, contenus dans le texte et joint les mots qui auraient pu être coupés par le retour de ligne, en enlevant le tiret qui avait été créé.

Importez votre texte de sortie OCR `ocr_XXXXX` dans la zone de dépôt et cliquez sur le bouton **Prétraitement**.

Cela générera un dossier `removing_XXXXX` qui contiendra votre fichier texte transformé. Ce fichier devrait avoir un nouveau nom du type `ocr_XXXXX_fix_ocr_linebreaks_remove_excessive_lines`. Cela a pour but d'indiquer le type de modification qui a été faite durant le prétraitement.

Ouvrez le fichier dans un éditeur de texte. Vous devriez observer, comme montré dans l'image ci-dessous, que le texte est beaucoup plus compact qu'auparavant.

{% include figure.html filename="fr-or-extraire-nettoyer-analyser-avec-pandore-toolbox-04.png" alt="Version nettoyée de la transcription" caption="Figure 4. Sortie de lecture, avec la suppression des sauts de ligne et coupure de mots." %}


## Analyse du corpus
Nous avons maintenant un fichier texte propre avec lequel il sera possible de travailler afin de conduire diverses analyses. C'est en cela que va consister la partie suivante de cette leçon, où on réalisera les tâches suivantes :

* Récupération de l'étiquetage morphosyntaxique
* Reconnaissance d'entités nommées
* Collecte des hapax
* Relevé d'éléments statistiques

A partir de maintenant, pour chacun des exercices que vous pratiquez dans la leçon, cela se fera toujours à partir du même texte : la version que vous venez d'obtenir après le nettoyage de texte. 

Ainsi, vous devez tout d'abord extraire ce texte du fichier zip dans lequel il se trouve et le placer dans un dossier facile à trouver sur votre ordinateur. Ensuite, pour une meilleure clarté par la suite, renommez votre fichier `guerre_et_paix.txt`. 

### Étiquetage morphosyntaxique
L'étiquetage morphosyntaxique, plus connu sous son appellation anglaise de *part-of-speech tagging* se définit, selon [Wikipédia](https://fr.wikipedia.org/wiki/%C3%89tiquetage_morpho-syntaxique) comme un "processus qui consiste à associer aux mots d'un texte les informations grammaticales correspondantes comme la catégorie grammaticale (nom, verbe, adjectif, adverbe, etc.), le genre, le nombre, etc. à l'aide d'un outil informatique".

Il existe plusieurs outils ou bibliothèques pour réaliser cette tâche automatiquement. Dans le cas de la Pandore Toolbox, c'est la bibliothèque [spaCy](https://spacy.io/usage/linguistic-features#pos-tagging) qui est utilisée.

Vous choisissez la tâche "Tâches d'annotation automatique" puis l'outil "Étiquetage morphosyntaxique".

Vous sélectionnez la langue "Français (fr)".

Importez votre texte de sortie OCR `guerre_et_paix.txt` dans la zone de dépôt et cliquez sur le bouton **Annoter**.

Cela générera un dossier `posttagging_XXXXX` qui contiendra un fichier texte contenant l'étiquetage morphosyntaxique pour chacun des éléments présents dans le texte.

Vous obtiendrez deux types d'informations avec cette sortie.

Tout d'abord, vous obtenez les informations suivantes, qui vous permettent de disséquer la composition grammaticale de votre texte :

``
Token: la --> POS: DET  
Token: promesse --> POS: NOUN  
Token: qu' --> POS: PRON  
Token: il --> POS: PRON  
Token: avait --> POS: AUX  
Token: faite --> POS: VERB  
Token: à --> POS: ADP  
Token: la --> POS: DET  
Token: princesse --> POS: NOUN  
Token: Droubetzkoï --> POS: PROPN  
``

Ensuite, afin d'évaluer la répartition de la composition grammaticale de votre texte, un comptage est proposé :

`
--- Comptage des POS ---
NOUN: 457  
PUNCT: 382  
DET: 295  
ADP: 294  
VERB: 263  
PRON: 219  
ADV: 125  
ADJ: 118  
AUX: 95  
PROPN: 76  
CCONJ: 75  
SPACE: 51  
SCONJ: 43  
NUM: 16  
X: 11  
`

### Reconnaissance d'entités nommées
La reconnaissance d'entités nommées, plus connu également sous son appellation anglaise de *named entity recognition* se définit, selon [Wikipédia](https://fr.wikipedia.org/wiki/Reconnaissance_d%27entit%C3%A9s_nomm%C3%A9es) comme le fait de "rechercher des objets textuels (c'est-à-dire un mot, ou un groupe de mots) catégorisables dans des classes telles que noms de personnes, noms d'organisations ou d'entreprises, noms de lieux, quantités, distances, valeurs, dates, etc.".

Tout comme pour la tâche précédente, il existe plusieurs outils ou bibliothèques pour réaliser cette tâche automatiquement. Dans le cas de la Pandore Toolbox, trois moteurs différents sont proposées, et il est possible de les utiliser tous, l'un après l'autre : 

- [spaCy](https://spacy.io/usage/linguistic-features#pos-tagging)
- [Flair](https://github.com/flairnlp/flair)
- [Bert](https://huggingface.co/google-bert)

Vous choisissez la tâche "Tâches d'annotation automatique" puis l'outil "Reconnaissance d'entités nommées".

Pour le format de votre corpus, sélectionnez "Texte". Pour le moteur de REN, sélectionnez tout d'abord *Spacy*

Ensuite, sélectionnez la langue "Français (fr)".

Importez votre texte de sortie OCR `guerre_et_paix.txt` dans la zone de dépôt et cliquez sur le bouton **Annoter**.

Cela générera un dossier `ner_XXXXX` qui contiendra un fichier texte contenant une classification pour tout élément que le moteur de REN aura reconnu comme une entité nommée.

Répétez l'exercice en choisissant tout d'abord *Flair*, puis *Bert*, tout en vérifiant que le modèle "Français (fr)" est bien le modèle sélectionné. 

<div class="alert alert-warning">
La sortie Bert ne fournira pas un fichier texte mais un fichier CSV. Vous pouvez tout de même l'ouvrir avec un éditeur de texte si vous voulez en découvrir le contenu.
</div>

Avec les trois sorties que vous avez générées, vous pouvez observer les différences dans ce qui a été reconnu comme une entitée ou non, et le changement de classification possible dans certains cas, comme ci-dessous. Cela vous permettra de choisir plus aisément celui qui semble le plus approprié pour votre texte, si vous décidez d'agrandir votre corpus par exemple.

` Spacy
T4    PER 138 150    Mlle Schérer  
T5    PER 186 196    l'Empereur  
T6    ORG 299 318    régiment Séménovsky  
T7    PER 375 380    Boris  
T8    LOC 414 423    Koutouzow  
T9    LOC 482 488    Moscou  
T10    LOC 500 506    Rostow  
`

` Bert
Droubetzkoï, PER, 84, 96, 0.99831575  
Mlle Schérer, PER, 111, 124, 0.8961335  
l, PER, 159, 161, 0.9366914  
Empereur, PER, 162, 170, 0.988947  
Séménovsky, MISC, 281, 292, 0.889915  
Boris, PER, 348, 354, 0.97729295  
Koutouzow, PER, 387, 397, 0.814427  
`

` Flair
T4    PER 138 150    Mlle Schérer  
T5    PER 308 318    Séménovsky  
T6    PER 375 380    Boris  
T7    PER 414 423    Koutouzow  
T8    LOC 482 488    Moscou  
T9    PER 500 506    Rostow  
T10    MISC 593 598    Boris  
`

### Analyse linguistique
Après avoir récupéré l'étiquetage morphosyntaxique et les entités nommées, il est possible de passer à une étude un peu plus approfondie, avec l'analyse linguistique, qui consiste à s'intéresser aux spécificités de langage contenues dans le texte étudié.

Vous choisissez la tâche "Analyse" puis l'outil "Analyse linguistique".

L'outil propose plusieurs options d'analyse. Pour cet exercice, vous en utiliserez une seule, l'option 2. Celle-ci permet, dans un texte, de récupérer les hapax, c'est-à-dire que, d'après la [définition Wikipédia](https://fr.wikipedia.org/wiki/Hapax), cela représente un "mot qui n'a qu'une seule occurrence dans un corpus donné"

Une fois l'option cochée, importez votre texte de sortie OCR `guerre_et_paix.txt` dans la zone de dépôt et cliquez sur le bouton **Lancer l'analyse**.

Cela générera un dossier `linguistics_XXXXX` qui contiendra un fichier texte avec `_hapax` ajouté au nom de fichier et contenant la liste des mots uniques du fichier texte, tels que les éléments présentés ci-dessous :

`
mieux, recevoir, soutenir, jeunes-gens, souciaïent, prendre, part, réception, tenaient, chambres, intérieures, conite, ahait, rencontre, arrivants, reconduisant, énigägeait, obligé, disait-il, indifféremment, inférieurs, qu'aux, supérieurs, merci, celle, dont, célébrons, viendrez, faute, est-ce, autrement, m'offenseriez, supplie, venir,
`

### Analyse statistique
Après avoir étudié les spécificités du langage du texte étudié, il est également possible de récupérer des informations statistiques sur certains éléments du texte, comme cela a pu déjà être obtenu, par exemple, avec le nombre de catégories grammaticales, lors de l'étiquetage morphosyntaxique.

Vous choisissez la tâche "Analyse" puis l'outil "Analyse statistique".

L'outil propose plusieurs options d'analyse. Pour cet exercice, vous en utiliserez deux, l'option 1 et l'option 2, dans ses deux versions. 

L'option 1 permet, dans un texte, de calculer le nombre moyen de mots par phrase dans un texte donné, afin de donner un aperçu de la complexité et de la lisibilité du texte. 

L'option 2 a pour but de fournir des informations sur les fréquences des mots dans le texte, c'est-à-dire connaître la fréquence absolue, soit le nombre brut d’occurrences d’un mot dans un corpus, et la fréquence relative, soit la fréquence absolue rapportée à la taille totale du corpus. Pour cette option, il est possible de l'avoir avec ou sans les mots vides, c'est-à-dire un mot non significatif dans le cadre d'une analyse de texte tels que des déterminants, des auxiliaires ou des noms très communs. Afin d'obtenir une analyse précise, vous cochez les deux versions de cette option. 

Les mots vides étant spécifiques à la langue du texte, une fois l'option 2 (sans mots vides) cochée, une option de choix de modèles de langue s'ouvrira. Comme pour les fois précédentes où cela est apparu, sélectionnez la langue "Français (fr)".

Une fois les options cochées et le modèle choisi, importez votre texte de sortie OCR `guerre_et_paix.txt` dans la zone de dépôt et cliquez sur le bouton **Lancer l'analyse**.

Cela générera un dossier `statistics_XXXXX` qui contiendra cinq fichiers, dont deux fichiers texte et trois images. 

L'une des images, qui doit s'appeler `guerre_et_paix_sentences_lengths.png` et ressembler à l'image ci-dessous, présente un diagramme exposant la composition des phrases dans le texte soumis, avec notamment la production des totaux de mots et phrases, ainsi que la moyenne du premier sur le second.

{% include figure.html filename="fr-or-extraire-nettoyer-analyser-avec-pandore-toolbox-05.png" alt="Diagramme exporté par la tâche de calcul de longueur de phrases" caption="Figure 5. Diagramme du nombre de mots par phrase, avec nombre total de phrases et moyenne de mots." %}

Ensuite, il y a deux couples de documents, le second étant la représentation par un nuage de mots de l'information donnée dans le premier : 

* `guerre_et_paix_wordsfrequency.txt` et `guerre_et_paix_wordcloud.png`
* `guerre_et_paix_wordsfrequency_stopwords.txt` et `guerre_et_paix_wordcloud_nostopwords.png`

Les documents avec `wordsfrequency` dans le nom de fichier fournissent la fréquence absolue puis celle relative, de chacun des mots du texte, classée dans les deux par nombre d'occurrences, puis le nombre de total de mots dans le texte.

Comparer les sorties des deux versions permet par exemple d'observer la quantité de mots retirés avec l'option de mots vides :

* `guerre_et_paix_wordsfrequency.txt` : `Total number of words:2377`
* `guerre_et_paix_wordsfrequency_stopwords.txt` : `Total number of words:1554`

Enfin, les nuages de mots vous permettent d'observer de manière explicite la liste de fréquence relative fournie dans les documents texte. Vous pouvez observer ci-dessous une comparaison entre la version avec les mots-vides (en haut) et sans (en bas).

{% include figure.html filename="fr-or-extraire-nettoyer-analyser-avec-pandore-toolbox-06.png" alt="Deux nuages de mots en comparaison" caption="Figure 6. Nuages de mots avec (haut) et sans (bas) les mots vides." %}


## Conclusion
Grâce à la Pandore Toolbox et à la multitude et diversité d'outils qu'elle propose, il est possible de faire, à portée de main et sans aucune compétence avancée en programmation, une analyse étendue de texte, ainsi que de récupérer un certain nombre d'informations. De plus, les tâches sont indépendantes les unes des autres, donnant toute liberté à l'utilisateur de choisir le travail qu'il souhaite réaliser.

Le contenu de cette leçon s'est limité à présenter seulement les outils les plus essentiels dans le cadre d'une étude de texte, mais la Pandore Toolbox contient bien plus d'options, tels que la récupération des tokens, des lemmes ou des phrases de votre texte, son encodage en XML-TEI, l'extraction de ses mots-clés ou de ses citations, ou encore l'analyse de sentiments ou de relations présents dans le texte.
