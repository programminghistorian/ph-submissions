---
title: "Analyse du corpus avec Voyant Tools"
slug: analyse-voyant-tools
original: analisis-voyant-tools
layout: lesson
collection: lessons
date: 2019-04-20
translation_date: YYYY-MM-DD
authors:
- Silvia Gutiérrez De la Torre
reviewers:
- Daniela Ávido
- Jennifer Isasi
editors:
- Jennifer Isasi
translator:
- Rudy Chaulet
translation-editor:
- Vy Cao
translation-reviewer:
- Forename Surname
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/718
difficulty: 1
activity: analyzing
topics: [distant-reading]
abstract: En este tutorial se aprenderá cómo organizar y analizar un conjunto de textos con Voyant-Tools.
avatar_alt: Gafas con diferentes graduaciones de oftanmología
mathjax: true
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

<div class="alert alert-warning">
Voyant Tools est temporairement indisponible le temps que s'achève un transfert de serveur prévu. En attendant, deux services miroirs en ligne sont accessibles via le site web de Voyant Tools. Nous avons contacté le développeur afin d'obtenir des informations sur l'avancement du transfert et la date prévue de rétablissement du service principal. [Septembre 2026]
</div>

Ce tutoriel vous apprendra à organiser un ensemble de textes pour la recherche, les différentes étapes pour la création d'un corpus et les principales métriques de l'analyse quantitative de texte. À cette fin, vous  apprendrez à utiliser une plate-forme qui ne nécessite pas d'installation (juste une connexion Internet) : [Voyant Tools](https://voyant-tools.org/?lang=fr)[^1]. Ce tutoriel est conçu comme une première étape dans une série de plus en plus complexe de méthodes de linguistique de corpus. Cette méthode est l’une des possibilités d’analyse de corpus que vous pouvez trouver dans PH (en voir une autre, par exemple : [Analyse de corpus avec AntConc](https://programminghistorian.org/fr/lecons/analyse-corpus-antconc)).

## Analyse du Corpus

L'analyse de corpus est un type [d'analyse de contenu](https://shs.cairn.info/l-analyse-de-contenu--9782130627906) qui permet de faire des comparaisons à grande échelle sur un ensemble de textes ou de corpus.

Depuis le début de l'informatique, les linguistes informatiques et les spécialistes de [la récupération d'informations](https://guides.data.gouv.fr/guides/reutiliser-des-donnees/guide-traitement-et-analyse-de-donnees/recuperer-des-donnees) ont créé et utilisé des logiciels pour distinguer des modèles qu'on verrait mal dans une lecture traditionnelle ou pour corroborer les hypothèses dont ils avaient l'intuition lors de la lecture de certains textes, mais qui nécessitaient un travail laborieux, coûteux et répétitif. Par exemple, afin de mettre en lumière les tendances d'utilisation et de déclin de certains termes à un moment donné, il était nécessaire d'embaucher des personnes qui examinaient manuellement un texte et annotaient le nombre de fois où apparaissait le terme recherché. Très vite, en examinant les capacités de « comptage » des ordinateurs, ces spécialistes se sont mis à écrire des programmes qui faciliteraient la tâche de créer des listes de fréquences ou des tables de correspondance (c.-à-d. des tables avec les contextes gauche et droit d'un terme). Le programme que vous apprendrez à utiliser dans ce tutoriel s'inscrit dans ce contexte.

## Ce que vous allez apprendre dans ce tutoriel

Voyant Tools est un outil Web qui ne nécessite pas l'installation d'un logiciel spécialisé car il fonctionne sur n'importe quel ordinateur avec une connexion Internet.
Comme cela a été dit dans cet autre [tutoriel](https://programminghistorian.org/fr/lecons/analyse-corpus-antconc), cet outil est une bonne passerelle vers d’autres méthodes plus complexes.

À la fin de ce tutoriel, vous serez capable de :

- Mettre en place un corpus en texte brut
- Chargez votre corpus dans Voyant Tools
- Comprendre et appliquer différentes techniques de segmentation de corpus
- Identifiez les caractéristiques de base de votre jeu de texte :
    - Extension des documents téléchargés
    - Densité lexicale (appelée densité de vocabulaire sur la plateforme)
    - Nombre de mots moyens par phrase
- Lire et comprendre différentes statistiques : fréquence absolue, fréquence normalisée, asymétrie statistique et mots différenciés
- Rechercher des mots-clés en contexte et exporter des données et des visualisations dans différents formats (csv, png, html)

## Créer un corpus en texte brut

Alors que VoyantTools peut fonctionner avec de nombreux formats (HTML, XML, PDF, RTF et MS Word), dans ce tutoriel, nous allons utiliser du texte brut (.txt). Le texte brut présente des avantages fondamentaux : il n'a pas de mises en forme spécifiques, il ne nécessite pas de programme spécial ni de connaissances supplémentaires. Les étapes pour créer un corpus en texte brut sont :

### 1. Rechercher des textes

La première chose que vous devez faire est de rechercher les informations qui vous intéressent. Pour ce tutoriel en français, un corpus de 94 discours politiques sur l'esclavage prononcés entre 1998 et 2026 par des personnalités françaises a été préparé, textes qui ont été puisés sur le site gouvernemental français : https://www.vie-publique.fr/.  Ce corpus a été publié avec une licence Creative Commons CC BY 4.0 et vous pouvez l'utiliser tant que vous le citez  ainsi :

 [Rudy Chaulet. « Corpus esclavage 1.0 ». Zenodo, 20 septembre 2026](https://zenodo.org/records/22864293)

### 2. Copier dans l'éditeur de texte brut

Une fois l'information localisée, la deuxième étape consiste à copier le texte qui vous intéresse du premier mot au dernier et à le sauvegarder dans un éditeur de texte brut. Par exemple :

- sous Windows, il pourrait être enregistré dans [Notepad](https://apps.microsoft.com/detail/9msmlrh6lzf3?hl=fr-FR&gl=FR)
- sous Mac, dans [TextEdit](https://apps.apple.com/fr/app/textedit-éditeur-texte/id1070883678) ;
- et  sous Linux, dans [Gedit](https://doc.ubuntu-fr.org/gedit).

### 3. Enregistrer le fichier

Lorsque vous enregistrez le texte, vous devriez considérer trois choses essentielles :
La première chose est de **sauvegarder vos textes en [UTF-8](https://fr.wikipedia.org/wiki/UTF-8)**, qui est un format d'encodage standard pour le français et d'autres langues.

**Sous Windows :**

1. Ouvrir le bloc-notes.  
2. Après avoir collé ou tapé le texte, cliquez sur « Enregistrer sous ».  
3. Dans la fenêtre « coder » sélectionnez « UTF-8 ».  
4. Choisissez le nom du fichier et enregistrez comme `.txt`.

{% include figure.html filename="fr-tr-analyse-voyant-tools-01.gif" alt="Visual description of figure image" caption="Figure 1. Enregistrer dans le format UTF-8 sous Windows." %}


**Sous Mac :**

1. Ouvrir TextEdit.
2. Coller le texte que vous souhaitez enregistrer.
3. Convertir en texte brut (cliquez sur le menu « Format »).
4. Lorsque vous enregistrez, sélectionnez l'encodage « UTF-8 ».  

{% include figure.html filename="fr-tr-analyse-voyant-tools-02.gif" alt="Visual description of figure image" caption="Figure 2. Enregistrer dans UTF-8 sous Mac." %}

**Sous Linux :**

1. Ouvrir Gedit.
2. Après avoir collé le texte, lors de l'enregistrement, sélectionnez « UTF-8 » dans la fenêtre « Encodage de caractère ».

{% include figure.html filename="fr-tr-analyse-voyant-tools-03.gif" alt="Visual description of figure image" caption="Figure 3. Enregistrer dans UTF-8 dans Ubuntu." %}

La seconde est que **le nom de votre fichier** ne **doit pas contenir d'accents ou d'espaces**, cela garantira qu'il peut être ouvert dans d'autres systèmes d'exploitation

La troisième consiste **à intégrer** des **métadonnées contextuelles (par exemple date, auteur, genre, origine) dans le nom du fichier** qui vous permet de diviser votre corpus en fonction de différents critères et de mieux lire les résultats. Pour ce tutoriel, nous avons nommé les archives avec l'année du discours présidentiel, et le nom de famille de la personne qui a prononcé le discours.

> [`2025-04-24_Berge.txt`](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/analyse-voyant-tools/corpus-esclavage/2025-04-24_Berge.txt) indique qu'il s'agit d'un discours prononcé le 24 avril 2025 par la ministre déléguée chargée de l'égalité entre les femmes et les hommes et de la lutte contre les discriminations, de l'époque, Aurore Bergé (sans accent).

## Chargement du corpus

Sur la page d'entrée de Voyant Tools, vous trouverez quatre options simples pour télécharger du texte[^2]. Les deux premières options se trouvent dans la zone blanche. Dans cette zone, vous pouvez coller directement un texte que vous avez copié de quelque part ; ou, coller des adresses Web – séparées par des virgules – des endroits où se trouvent les textes que vous souhaitez analyser. Une troisième option consiste à cliquer sur « Ouvrir » et à sélectionner l’un des trois corpus que Voyant a préchargé (les pièces de Shakespeare, les romans de Jane Austen ou *Frankenstein* de Mary Shelley : tous trois en anglais).

Enfin, il y a l'option que nous allons utiliser dans ce tutoriel, dans lequel vous pouvez télécharger directement les documents que vous avez sur votre ordinateur. Dans ce cas, nous soulèverons le [corpus complet](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/analyse-voyant-tools/corpus-esclavage.zip) des discours sur l'esclavage.

Pour télécharger les matériaux, cliquez sur l’icône qui indique « Télécharger », ouvrez votre explorateur de fichiers et, en laissant la touche « Maj » appuyée, sélectionnez tous les fichiers que vous souhaitez analyser.

{% include figure.html filename="fr-tr-analyse-voyant-tools-04.png" alt="Visual description of figure image" caption="Figure 4. Télécharger des documents." %}


## Explorer le corpus

Une fois que vous avez téléchargé tous les fichiers, vous voyez apparaître l'interface  qui dispose, par défaut, de cinq outils :

**Cirrus** : nuage de mots qui montre les termes les plus fréquents.

{% include figure.html filename="fr-tr-analyse-voyant-tools-05.png" alt="Visual description of figure image" caption="Figure 5. Caption text to display" %}


**Lecteur** : espace permettant d'examiner et lire les textes complets avec un graphique à barres indiquant la quantité de texte de chaque document.

{% include figure.html filename="fr-tr-analyse-voyant-tools-06.png" alt="Visual description of figure image" caption="Figure 6. Caption text to display" %}

**Tendances** : graphique de distribution indiquant les termes dans tout le corpus (ou dans un document lorsqu'un seul est chargé).

{% include figure.html filename="fr-tr-analyse-voyant-tools-07.png" alt="Visual description of figure image" caption="Figure 7. Caption text to display" %}


**Résumé** : donne un aperçu de certaines statistiques textuelles du corpus actuel.

{% include figure.html filename="fr-tr-analyse-voyant-tools-08.png" alt="Visual description of figure image" caption="Figure 8. Caption text to display" %}


**Contextes** : concordance qui montre chaque occurrence d'un mot clé avec un petit contexte environnant (à gauche et à droite).

{% include figure.html filename="fr-tr-analyse-voyant-tools-09.png" alt="Visual description of figure image" caption="Figure 9. Caption text to display" %}
    

### Résumé : caractéristiques de base de votre jeu de textes

L'une des fenêtres les plus riches d'informations dans Voyant est celle du résumé. Ici, nous avons une vue d’ensemble sur certaines statistiques de notre corpus, ce qui en fait un bon point de départ. Dans les sections suivantes, on explique les différentes mesures qui apparaissent dans cette fenêtre.

#### Nombre de textes, de mots et de formes uniques

La première phrase que nous lisons :	

> Ce corpus comporte 94 documents avec 130.612 mots au total et 18.550 formes uniques. Créé il y a 2 secondes

À partir de cette information, nous savons exactement combien de documents différents ont été téléchargés (94), combien il y a de mots au total dans le corpus (130.612)  et combien de formes uniques (11.825).

> Dans les lignes suivantes, vous trouverez neuf activités qui peuvent être résolues en groupe ou individuellement. Pour six d'entre elles des réponses sont indiquées à la fin du texte pour servir de guide. Les quatre dernières sont ouvertes à la réflexion/discussion de ceux qui les réalisent.

**Activité 1 :**

Si notre corpus était composé de deux textes, l’un contenant : « J’ai faim » et l'autre : « J'ai beaucoup dormi », quelles informations apparaîtraient sur la première ligne du résumé ? Complétez :

> Ce corpus a __ textes avec un total de mots de __ et __ formes uniques.

#### Taille du document

La deuxième information que nous découvrons est la section « taille du document ». Les éléments suivants apparaissent :

- **Les textes les plus longs** : `1998-04-28-Queyranne (4510); 2026-05-21_Macron (4235); 2015-05-10_b_Hollande (3295); 2001-05-10_Paul (3286); 2024-05-10_Attal (3180)`
- **Les textes les plus courts** : `2002-06-10_BGirardin (96); 2005-05-22_BGirardin (105); 2002-05-27_BGirardin (131); 2017-11-23_Loiseau (146); 2017-11-21_a_Loiseau (249)`

**Activité 2 :**

1.  Que peut-on conclure à propos des textes les plus longs et les plus courts, compte tenu des métadonnées dans le nom du fichier (date : année, mois, jour, locuteur) ?
2.  À quoi cela sert-il de connaître la longueur des textes ?

#### Densité de vocabulaire

La densité de vocabulaire est mesurée en divisant le nombre de formes uniques par le nombre de mots totaux. La densité la plus importante (la plus proche de 1) indique que le vocabulaire a une plus grande variété de mots, qu'il est sémantiquement plus dense.

**Activité 3 :**

1\. Calculez la densité de chacune des deux strophes suivantes, comparez et commentez les résultats :

- Juana Inés de la Cruz : « Hommes méchants [^3]  »
    
>Hommes méchants qui accusez
 sans raison les femmes 
sans voir que c'est vous la cause,
de tout ce dont vous vous plaignez...
    
-   Jacques Prévert : « Le cancre [^4] »
 > Il dit non avec la tête
 mais il dit oui avec le cœur
 il dit oui à ce qu'il aime
il dit non au professeur...
    

2\. Lisez les données de densité lexicale des documents du corpus, que vous indiquent-elles ?

Densité du vocabulaire :

- **Ordre décroissant** : `2002-06-10_BGirardin (0.729); 2017-11-23_Loiseau (0.726); 2005-05-22_BGirardin (0.686); 2002-05-27_BGirardin (0.656); 2017-11-21_a_Loiseau (0.631)`

- **Ordre croissant** : `1998-04-28_Queyranne (0.177); 2001-05-10_Paul (0.271); 2026-05-21_Macron (0.276); 2024-05-10_Attal (0.312); 1998-05-26_Trautmann (0.337)`

3\. Comparez-les avec les informations concernant leur longueur, que remarquez-vous ?

####  Mots par phrase

La façon dont Voyant calcule la longueur des phrases doit être considérée comme assez approximative, notamment en raison de la difficulté à distinguer le rôle du point (fin d'une abréviation, fin d'une phrase) ou d'autres usages de la ponctuation (par exemple, dans certains cas, un point-virgule peut marquer la limite entre des phrases). L’analyse de phrase est effectuée par un modèle avec des instructions ou une « classe » du langage de programmation Java appelée [BreakIterator](https://docs.oracle.com/javase/tutorial/i18n/text/about.html).

**Activité 4 :**

1. Observez les statistiques des mots par phrase par (mpp) : quel modèle ou quels modèles pouvez-vous discerner si vous examinez l’index « mpp » et les métadonnées de la date et de l'identité du locuteur contenues dans le nom du document ?

2. Cliquez sur les noms de certains documents qui vous intéressent pour leur index « mpp ». Regardez la fenêtre « Lecteur » et lisez quelques lignes, la lecture du texte original ajoute-t-elle de nouvelles informations à votre lecture des données ? Dites pourquoi.

### Cirrus et résumé : fréquences et filtres de mots vides

Puisque vous avez maintenant une idée de certaines caractéristiques globales des documents, il est temps de vous pencher sur les caractéristiques des mots de votre corpus et l’un des points de départ les plus courants est de comprendre ce que signifie analyser un texte à partir de ses fréquences.

#### Fréquences sans filtre

Le premier aspect avec lequel nous allons travailler est la **fréquence brute** et pour cela nous allons utiliser la fenêtre Cirrus.

**Activité 5 :**

1. Quels sont les mots les plus courants dans le corpus ?
2. Que nous disent ces mots du corpus ? Sont-ils tous significatifs ?

> ☞  survolez les mots pour obtenir leurs fréquences

#### Mots vides

La quantité n’est pas une valeur en soi et dépendra toujours de nos objectifs, Voyant offre la possibilité de filtrer certains mots. Une procédure courante pour obtenir des mots pertinents consiste à filtrer les unités lexicales grammaticales ou les *mots vides* : articles, prépositions, interjections, pronoms, etc[^5].

**Activité 6 :**

1. Quels mots vides sont dans le nuage de mots ?
2. Lesquels élimineriez-vous et pourquoi ?

Voyant a déjà chargé une liste de mots vides en français. Cependant, vous pouvez l'éditer comme suit : 

1\. Placez votre curseur supérieur droit de la fenêtre Cirrus et cliquez sur l'icône qui ressemble à un commutateur.

{% include figure.html filename="fr-tr-analyse-voyant-tools-10.png" alt="Visual description of figure image" caption="Figure 10. Caption text to display" %}

2\.Une fenêtre avec différentes options apparaîtra, nous sélectionnons la première « Modifier la liste »

{% include figure.html filename="fr-tr-analyse-voyant-tools-11.png" alt="Visual description of figure image" caption="Figure 11. Caption text to display" %}

3\. On ajoute les mots  vides, toujours séparés par un saut de ligne (touche *Entrée*)


4\. Une fois ajoutés les mots que vous voulez filtrer, cliquez sur « Sauvegarder ».

<div class="alert alert-warning">
Une option « Appliquer partout » est sélectionnée par défaut ; si on la laisse ainsi sélectionnée, le filtrage de mots affectera les métriques de tous les autres outils. Il est très important que vous documentiez vos décisions. Une bonne pratique est de sauvegarder la liste des mots vides dans un fichier texte (.txt) Pour ce tutoriel, nous avons créé <a href='https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/analyse-voyant-tools/mots-a-filtrer.txt'>une liste de mots à filtrer</a> et vous pouvez l'utiliser si vous le souhaitez, rappelez-vous simplement que cela affectera vos résultats. Par exemple : dans la liste des mots filtrés, ont été inclus « tous » et « toutes » ; or ces mots pourraient être intéressants s’ils montrent que « tous » est beaucoup plus utilisé que « toutes », car pourrait donner des indices sur l’utilisation d'un langage genré.
</div>

#### Fréquences avec des mots vides filtrés

Revenons alors à la section du résumé. Comme nous l'avons dit précédemment, les mots vides filtrés (c'est-à-dire : enlevés du corpus) affectent d'autres champs de Voyant. Dans ce cas, avec la case « Appliquer à tout » sélectionnée, dans la liste ci-dessous : **Mots les plus fréquents** dans le corpus, seront affichés les mots qui sont répétés le plus souvent sans compter ceux qui ont été filtrés. Dans le cas présent, on :

> l'esclavage (843); mémoire (472); france (454); république (382); aujourd'hui (306)

Alors que, si dans l'onglet **mots vides** des options on choisit : **aucune**, on obtiendra, dans le cadre **Résumé** la liste suivante des **Mots les plus fréquents** dans ce corpus : 

>de (7498); la (4961); et (3784); à (2869); les (2838)

**Activité 7 :**

1.  Pensez à ces mots et réfléchissez aux informations qu’ils fournissent et à la façon dont cette information se distingue de celle que vous obtenez en regardant le nuage de mots.
    
2.  Si vous êtes dans un groupe, discutez des différences de vos résultats avec ceux des autres
    

### Termes

Alors que les fréquences peuvent nous communiquer une information à propos de nos textes, il existe de nombreuses variables qui peuvent rendre ces nombres insignifiants. Les sections suivantes expliqueront différentes statistiques qui peuvent être obtenues dans l’onglet « Termes » qui se trouve à droite du bouton « Cirrus » dans la présentation par défaut de Voyant.

#### Fréquence normalisée

Dans la section précédente, nous avons observé la « fréquence brute » des mots. Cependant, si nous avions un corpus de six mots et 3.000 mots, les fréquences brutes sont peu informatives. Trois mots dans un corpus de six mots représentent 50% du total, trois mots dans un corpus de 6.000 représentent 0,1% du total. Pour éviter la surreprésentation d’un terme, les linguistes ont conçu une autre mesure appelée « fréquence relative normalisée ». Ceci est calculé comme suit : Fréquence brute * 1,000.000 / Nombre total de mots. Voyons un vers comme un exemple. Prenons les vers cités plus haut « il dit non avec la tête mais il dit oui avec le cœur », qui ont 13 mots au total. Si on calcule les fréquences brute et relative des noms, on obtient :

| mots | fréquence brute | fréquence relative      |
|------|-----------------|-------------------------|
| cœur | 1               |1 * 1.000.000/8 = 125.000|
| dit  | 2               |2 * 1.000.000/8 = 111.000|

Quel est l'avantage de cette méthode ? Si nous avions un corpus dans lequel le mot cœur avait la même proportion, par exemple 1.000 occurrences entre 8.000 mots ; bien que la fréquence brute soit très différente, la fréquence normalisée serait la même, car 1.000 * 1.000.000/8.000 est également de 125.000.

Voyons comment cela fonctionne dans Voyant Tools :

1.  Dans la section Cirrus (nuage de mots), nous cliquons sur « Termes ». Cela ouvrira un tableau qui comporte par défaut trois colonnes : « Termes » (avec la liste des mots dans les documents, sans les mots vides), « Total » (avec la fréquence brute ou nette de chaque terme) et « Tendance » (avec un graphique de la distribution d'un mot prenant en compte sa fréquence relative). 
2.  Pour obtenir de l'informations sur la fréquence relative d’un terme, dans la barre de nom de la colonne, le plus à droite, cliquez sur la flèche orientée vers le bas qui offre plus d’options et dans « Colonnes », sélectionnez l’option « Proportion » comme indiqué dans l’image ci-dessous :

{% include figure.html filename="fr-tr-analyse-voyant-tools-12.png" alt="Visual description of figure image" caption="Figure 12. Caption text to display" %}

3\. Si vous triez les colonnes par ordre décroissant comme vous le feriez dans un tableur, vous remarquerez que l’ordre de la fréquence brute (« Total ») et la fréquence relative (« Proportion ») l’ordre est le même. Alors, à quoi cette mesure nous sert-elle ? À comparer différents corpus. Un corpus est un ensemble de textes avec quelque chose en commun. Dans ce cas, Voyant interprète tous les discours comme un seul corpus. Si nous voulions que chaque locuteur, par exemple soit un corpus différent, nous devrions enregistrer notre texte dans un tableau, en HTML ou XML, où les métadonnées étaient exprimées en colonnes (dans le cas de la table) ou en tags (dans le cas de HTML ou XML)[^6].

#### Asymétrie statistique

Bien que la fréquence relative ne serve pas à comprendre la distribution de notre corpus, il existe une mesure qui, elle, nous donne des informations sur la constante d'un terme tout au long des documents : l'asymétrie statistique.

Cette mesure nous donne une idée de la distribution de probabilité d'une variable sans avoir à en faire la représentation graphique. Elle est calculée est en observant les écarts de fréquence à la moyenne, pour savoir si ceux qui se produisent à droite de la moyenne (asymétrie négative) sont plus grands que ceux de gauche (asymétrie positive). Plus le degré d'asymétrie statistique est proche de zéro, plus la distribution de ce terme est régulière (c'est-à-dire qu'elle se produit avec une moyenne très similaire dans tous les documents). Une chose pas très intuitive : si un terme a une asymétrie statistique avec des **nombres positifs**, cela signifie que ce terme est **inférieur** à la moyenne, et plus le nombre est grand, plus le terme est asymétrique (c'est-à-dire que cela se produit beaucoup dans un document mais  guère dans le corpus). Les **chiffres négatifs**, quant à eux, indiquent que ce terme a tendance à être **supérieur** à la moyenne.

{% include figure.html filename="en-tr-corpus-analysis-voyant-tools-14.png" alt="Visual description of figure image" caption="Figure 13. Asymétrie statistique." %}

Pour obtenir cette mesure dans Voyant, nous devons répéter les étapes que nous avons faites pour obtenir la fréquence relative, mais cette fois-ci, sélectionnez « Coefficient de dissymétrie »). Cette mesure permet d'observer alors que le mot « traite » par exemple, bien qu'ayant une fréquence élevée, non seulement n'a pas de fréquence constante le long du corpus, mais qu'il a tendance à être inférieur à la moyenne car son asymétrie statistique est positive (2,4).

#### Mots distinctifs

Comme vous pouvez déjà le soupçonner, l’information la plus intéressante n’est généralement pas trouvée dans les mots les plus fréquents, car ceux-ci ont tendance à être aussi les plus évidents. Dans le domaine de la recherche d'informations, d'autres mesures ont été inventées qui permettent de localiser des termes qui font qu'un document se distingue d'un autre. L'une des mesures les plus couramment utilisées est appelée tf-idf (de l'anglais : *frequency – inverse document frequency*). Cette mesure cherche à exprimer numériquement à quel point un document est pertinent dans une certaine collection ; c’est-à-dire, dans un corpus de textes sur les « pommes » le mot pommes peut apparaître plusieurs fois, mais il ne nous dit rien de nouveau sur le corpus. Ainsi, nous ne voulons pas connaître la fréquence brute des mots (*term frequency*, *tf*, fréquence des termes) mais la peser pour savoir si elle est unique ou commune dans le corpus donné (*inverse document frequency*, *idf*, fréquence inverse du document).

Dans Voyant, le *tf-idf* est calculé comme suit :

$$ Fréquence brute (tf) / Nombre de mots (N) * log10 (Nombre de documents / Nombre de fois que le terme apparaît dans les documents) $$ 

$$ tfidf_{t,d} = \left( \frac{tf_{t,d}}{N_i} \right) \cdot \log_{10} \frac{|D|}{\{ d \in D : t \in d \}} $$

**Activité 8 :**

Regardez les **mots distinctifs (par rapport au reste du corpus)** de chacun des documents et écrivez quelle hypothèse vous pouvez en tirer.

1. **1998-04-07-Trautmann**: `célébration (5), l'outre (7), francophone (2), l'esclave (4), identité (5)`
2. **1998-04-07_Fabius**: `l'assemblée (4), musiques (2), avancées (2), asservis (2), ouverte (2)`
3. **1998-04-23_Chirac**: `d'intégration (4), leçon (5), royaume (2), printemps (2), provisoire (5)`
4. **1998-04-25_Fabius**: `réglé (3), asservis (3), timbre (2), vis (2), chants (2)`
5. **1998-04-26_Jospin**: `voeu (4), champagney (7), métropole (7), respect (9), imposer (3)`
6. **1998-04-26_Trautmann**: `schoelcher (16), marge (3), victor (13), sociologue (2), partielles (2)`
7. **1998-04-28_Josselin**: `posée (2), intéressant (2), armateurs (2), l'expression (3), s'il (3)`
8. **1998-04-28_Queyranne**: `célébration (16), culturelle (15), traumatisme (8), racine (6), l'accession (6)`
9. **1998-05-08_Chirac**: `droits (29), ligue (5), devoirs (5), manifeste (3), citoyen (6)`
10. **1998-05-22_a_Queyranne**: `l’esclavage (22), l’abolition (11), l’homme (9), c’est (9), d’une (8)`
11. **1998-05-22_b_Queyranne**: `l’histoire (7), qu’elle (5), exposition (7), intimement (4), l’événement (3)`
12. **1998-05-26_Queyranne**: `l’esclavage (24), l’abolition (12), d’une (11), l’homme (9), aujourd’hui (8)`
13. **1998-05-26_Trautmann**: `delgrès (12), imposé (4), écouter (4), résistance (11), victoire (6)`
14. **1998-12-19_Queyranne**: `maloya (14), pierrefonds (9), l'aéroport (4), fénoir (3), musique (5)`
15. **1998-12-20_Queyranne**: `mascareignes (3), décision (5), d'appliquer (2), 1796 (2), réunion (9)`
16. **1999-02-18_Queyranne**: `dune (5), l’esclavage (6), paysan (2), n’avaient (2), na (2)`
17. **1999-02-18_Sarre**: `sert (2), citoyenneté (4), soudan (1), s'interdisait (1), s'insurger (1)`
18. **1999-02-18_Taubira**: `n’est (10), l’esclavage (8), c’est (5), allons (5), l’économie (3)`
19. **2000-03-23_Queyranne**: `proposition (8), l'article (6), juridique (5), xxème (3), condamnation (3)`
20. **2000-11-17_Vedrine**: `européen (4), l'objectif (3), l'immigration (3), transporteurs (2), irrégulier (2)`

### Mots en contexte

Le projet que certaines histoires des humanités numériques placent à l'origine de cette discipline est *L’Index Thomisticus*, une table de concordance et d'indexation de l'œuvre de Thomas d’Aquin, projet dirigé par le philologue et religieux Roberto Busa [^7], auquel des dizaines de femmes ont participé lors de la codification des données[^8] . Un des outils de ce projet qui a duré des dizaines années (la table de contextes), est aujourd'hui une fonction intégrée dans Voyant Tools : dans le coin inférieur droit, dans la fenêtre « Contextes » il est possible de faire des requêtes des concordances gauche et droite de termes spécifiques.

Le tableau possède les colonnes par défaut suivantes :

1.  **Document** : Titre du document dans lequel se trouve le(s) mot(s)-clé(s) de la requête
2.  **Gauche** : Contexte gauche du mot-clé (celui-ci peut être modifié pour présenter davantage de mots si on clique sur la cellule + tout à gauche)
3.  **Terme** : mot(s) clé(s)
4.  **Droite** Contexte droit (comme pour le gauche, on peut voir davantage de mots avec la touche + située tout à gauche)

Vous pouvez ajouter la colonne **Position** qui indique l'endroit dans le document où se trouve le terme demandé :

{% include figure.html filename="fr-tr-analyse-voyant-tools-14.png" alt="Visual description of figure image" caption="Figure 14. Caption text to display" %}

> **Recherche avancée** Voyant permet l'utilisation de jokers pour rechercher les variations d'un mot. Voici quelques-unes des combinaisons :
> 
> -   **esclav`*`** : cette interrogation donnera tous les mots qui commencent par le préfixe « esclav » : esclave (34), esclaves (252), esclavage (37), esclavages (12), esclavagiste (25), esclavagistes (10), esclavagisme(1), soit au total 371 formes, mais pas « l'esclavage » ou tout autre forme de racine identique utilisée avec l'apostrophe,  qui est pourtant la forme très largement majoritaire  dans le corpus (843 occurrences). Pour l'intégrer il suffira de formuler l'interrogation suivante :
> -    **esclav`*`**,**l'esclav`*`** : par laquelle on obtiendra un total de 1252 formes, les 371 citées plus haut plus « l'esclavage (843), l'esclave (34), l'esclavagisme (3), l'esclavagiste (1). »
>   On peut ainsi rechercher plusieurs mots en les séparant par une virgule (sans espace).
> -   On peut aussi rechercher une expression exacte en la plaçant entre guillemets :
> -   **"traite des Noirs"** : 4 occurrences, contre  **"traite négrière"** 48 occurrences.
> -   On peut aussi vérifier que le terme « esclavisé », défendu par des universitaires spécialistes des questions d'esclavage moderne[^9], est absent du corpus. Bien qu'utilisé depuis une quinzaine d'années, il n'a toujours pas pénétré la sphère politique gouvernementale.
> -   **"esclavage crime"~ 5** : recherche les termes entre guillemets (l’ordre n’a pas d’importance) séparés par 5 mots maximum (La consultation donne 2 résultats : "Tout esclavage est un crime..." et "...inscrive la mise en esclavage comme un crime imprescriptible").

**Activité 9 :**

1.  Après avoir choisi un terme du corpus qui vous semble particulièrement intéressant, utilisez certaines des stratégies de la consultation avancée.
2.  Triez les lignes en utilisant les différentes colonnes (document, gauche, droite et position) : Quelles conclusions pouvez-vous tirer à propos des termes choisis en fonction des informations fournies dans ces colonnes ?

> **Conseil** : tenez compte du contexte et de l'emplacement du terme pour comprendre comment il est utilisé. Apparaît-il principalement au début ou à la fin du discours ? Le ton est-il cohérent ?

#### Exporter des tableaux

Pour exporter les données, cliquez sur la case avec la flèche qui apparaît lorsque vous survolez le coin droit de « Contextes ». L’option ** Exporter les données actuelles** est ensuite sélectionnée.

Ce qui ouvre une page ainsi constituée :

{% include figure.html filename="fr-tr-analyse-voyant-tools-15.png" alt="Visual description of figure image" caption="Figure 15. Caption text to display" %}


Sélectionnez toutes les données (Ctrl+A ou Ctrl+E) ; copiez-les (Ctrl+C) et collez-les dans une feuille de calcul (Ctrl+V). Si cela ne fonctionne pas, enregistrez les données comme dans un simple éditeur de texte comme .txt (n’oubliez pas l’encodage UTF-8) et ensuite dans votre feuille de calcul importez les données. Voir la méthode pour [Libre Office](https://help.libreoffice.org/latest/fr/text/shared/guide/data_dbase2office.html), pour [Excel](https://support.microsoft.com/fr-fr/excel/get-started/import-or-export-text-txt-or-csv-files).


## Activités : réponses

**Activité 1 :**

Ce corpus contient 2 documents avec un total de 6 mots et 4 formes verbales uniques : *(j'ai, faim, beaucoup, dormi)*

**Activité 2 :**

À quoi cela sert-il de connaître la longueur des textes ?

1. On peut observer que parmi les textes les plus longs, deux appartiennent à la première période du corpus (1998-2001) et deux à la période la plus récente (2024-2026) ; deux ont été prononcés par des présidents de la république, un par un premier ministre et deux par des secrétaires d'État à l'Outre-mer, tous sont des hommes, alors que les textes les plus courts ont été prononcés par deux femmes (notons que 43,6% des textes ont été dits par des femmes (41) et 56,4% par des hommes (53).

2. Connaître l’étendue de nos textes nous permet de comprendre l’homogénéité ou la disparité de notre corpus, ainsi que de comprendre certaines tendances (périodes pendant lesquelles les discours tendent à être plus ou moins long, le rapport entre la fonction politique du locuteur et la longueur de son discours, etc.) y compris des clivages politiques, de genre, questions qu'il conviendra d'approfondir. On pourra aussi remarquer, grâce aux métadonnées, que de nombreux textes sont prononcés au mois de mai, qui est, en France, celui des commémorations : 10 mai, Journée nationale des mémoires de la traite, de l'esclavage et de leur abolition, et 23 mai, Journée nationale en hommage aux victimes de l'esclavage colonial.

**Activité 3 :**

1. La première strophe a 22 mots et 19 formes uniques, donc 19/22, cela donne une densité de vocabulaire de 0.864. La seconde strophe, 25 mots et 16 formes uniques, donc 16/25 équivaut à une densité de vocabulaire de 0.640.

2. Comme on peut le voir, la différence entre une strophe de Juana Inés de la Cruz et une autre composée par Jacques Prévert ont une différence de densité de 0,224, ce qui est assez élevé. Nous devons être prudents lors de l'interprétation de ces résultats car ils ne sont qu'un indicateur quantitatif de la richesse du vocabulaire et n'incluent pas d'autres paramètres.

Dans le corpus "esclavage" il semble y avoir une correspondance entre les discours les plus courts et les plus denses, c’est normal car plus un texte est court et moins il a d'occasion de se répéter. Cependant, cela peut aussi nous donner des informations qui vont au-delà de ce constat (en croisant avec d'autres données comme la date du discours, le genre du locuteur, son appartenance politique, etc.).

**Activité 4 :**

Il semble, dans ce corpus, que le nombre de mots par phrases recoupent celui de la densité du vocabulaire du discours dans son ensemble.

On peut aussi observer que, parmi les dix premiers discours qui utilisent les phrases comptant le plus de mots, trois ont été prononcés par la ministre de la culture et de la communication en 1998, cinq par des hommes et cinq par des femmes, quatre appartenant à des gouvernements étiquetés à gauche, quatre à droite et deux au centre (alors que le corpus compte 50% d'orateurs classés à gauche, 26,5% à droite et 24,5% au centre[^10]). Les dix textes contenant les phrases les plus courtes ont été dits par 8 femmes et deux hommes, 6 du centre, 3 de droite et une de gauche.

**Activité 5 :**

1.  `l'esclavage (843) ; mémoire (472) ; france (454) ; république (382) ; aujourd'hui (306)`
2.  Ces mots sont significatifs dans la mesure où ils représentent la thématique principale des discours qui est « l'esclavage » (843 occurrences) ; « mémoire » (472 occurrences) renvoie à l'esclavage historique, colonial, principalement pratiqué par la France (mot qui apparaît en troisième position, 454 occurrences) dans l'espace caraïbe et dans l'océan Indien ; « république » (382 occurrences) est le régime sous lequel l'esclavage a été aboli pour la première fois (1794), puis rétabli sous le consulat de Napoléon Bonaparte (1802) et enfin définitivement aboli sous la seconde république (1848) ; « aujourd'hui » (306 occurrences) signale le moment d'où parlent les 38 personnes ayant prononcé les 94 discours et peut aussi renvoyer à l'esclavage contemporain, illégal, qui sévit dans de nombreux pays et qui est parfois évoqué dans ces discours.

**Activité 6 :**

Voici le nuage sans filtre, avec tous les mots « vides » : 

{% include figure.html filename="fr-tr-analyse-voyant-tools-16.png" alt="Visual description of figure image" caption="Figure 16. Caption text to display" %}

Même si « l'esclavage » parvient à surnager, il n'est qu'en 19e position et est dépassé par « de », « la », « et », « à », « les », « le », « des », « que », « en », « qui », etc. 
Voilà des mots qui n'apportent guère à l'analyse de ce corpus, qu'on pourra donc qualifier de vides et filtrer. 
Examinez la liste de termes en cliquant sur l'onglet à gauche de « Cirrus », et constituez une liste de *mots vides*.

## Notes :
[^1]: Sinclair S., Rockwell G. (2016) [*Voyant Tools*](http://voyant-tools.org/).
[^2]: Il existe d'autres manières plus complexes de charger des corpus, consultables dans la [documentation complète de Voyant, en anglais](https://beta.voyant-tools.org/docs/tutorial-start.html).
[^3]: Traduction de J. M. G. Le Clézio (2026), *Trois Mexique*, Paris, d'après Juana Inés de la Cruz (1997) [1689], *Obras completas*, Mexico, p. 109.
[^4]: Jacques Prévert (1972), *Paroles*, Paris, 1972, p. 65.
[^5]: Le Floch V. (2013) « L'extraction terminologique à partir d'un corpus de termes techniques. Étude de cas appliquée au domaine de la sécurité informatique », [*Traduire* 228: 81-91](https://journals.openedition.org/traduire/537?lang=en).
[^6]: Pour plus d'informations, voir la documentation en anglais.
[^7]: Hockey S. (2004), « [The History of Humanities Computing](https://companions.digitalhumanities.org/DH/?chapter=content/9781405103213_chapter_1.html) », *A companion to digital humanities*, Oxford.
[^8]: Terras M. (2013), « [For Ada Lovelace Day – Father Busa’s Female Punch Card Operatives](https://melissaterras.blogspot.com/2013/10/for-ada-lovelace-day-father-busas.html) », *Melissa Terras' Blog. Adventures in Digital Humanities and digital cultural heritage. Plus some musings on academia.*
[^9]: Cottias M., Flory C. (2019), « [Éditorial](https://journals.openedition.org/slaveries/322) », *Esclavages et post-esclavages / Slavery and post-slaveries* 1:1-2.
[^10]: Se définissent comme de gauche les gouvernements dirigés par le premier ministre Jospin (4 juin 1997-6 mai 2002) et ceux du président Hollande (15 mai 2012-14 mai 2017) ; du centre les gouvernements du président Macron (15 mai 2017-2026) ; de droite les autres.
