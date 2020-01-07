---
title: Débuter avec Markdown
layout: lesson
slug: debuter-avec-markdown
date: 2015-11-13
authors:
- Sarah Simpkin
reviewers:
- John Fink
- Nancy Lemay
translators:
- Sofia Papastamkou
translation-date: 2020-01-07
translation-reviewers:
translation-editors:  
difficulty: 1
review-ticket: https://github.com/programminghistorian/jekyll/pull/61
editors:
- Ian Milligan
activity: presenting
topics: [data-management]
abstract: "Cette leçon est une introduction à Markdown, une syntaxe en texte brut pour le formatage de documents. Vous allez découvrir pourquoi l'utiliser, comment formater des fichiers Markdown et comment prévisualiser de tels fichiers sur le web."
exclude_from_check:
  - reviewers
original: getting-started-with-markdown
avatar_alt: Manuel typographique aux caractères décorés de fleurs
---

{% include toc.html %}





### Objectifs de la leçon
Cette leçon propose une introduction à Markdown, qui est une syntaxe en texte brut pour le formatage de documents. Vous allez découvrir pourquoi l'utiliser, comment formater des fichiers Markdown et comment prévisualiser de tels fichiers sur le web. 

Puisque les tutoriels du Programming Historian sont soumis sous forme de fichiers Markdown, je mobilise des examples maison chaque fois que cela est possible. J'espère que ce quide vous sera utile si vous envisagez de rédiger un tutoriel en tant qu'auteur(e). 

## Qu'est-ce que le Markdown?
Développé en 2004 par [John Gruber](http://daringfireball.net/projects/markdown/ "Markdown on Daring Fireball"), Markdown est à la fois un langage de balisage de fichiers textes et une fonctionnalité du langage Perl permettant de convertir des fichiers Markdown en HTML. Notre leçon traite davantage du premier aspect, puisque nous apprendrons à utiliser la syntaxe Markdown pour préparer des fichiers.

Les fichiers texte brut présentent plusieurs avantages comparés aux autres formats. Non seulement ils sont compatibles avec tout type d'appareil et de système d'exploitation, mais ils s'avèrent aussi plus pérennes. Si jamais vous avez tenté d'ouvrir un document sauvegardé dans un format de traitement de texte hérité, vous devez sans doute saisir facilement les problèmes de compatibilité que cela peut impliquer.

L'utilisation de la syntaxe Markdown vous permettra de produire des fichiers à la fois lisibles en texte brut et prêts à recevoir davantage de traitement sur une autre plateforme. Plusieurs systèmes de gestion de blogs, des générateurs de sites web statiques ou encore des plateformes comme [GitHub](http://github.com "GitHub") prennent en charge des fichiers Markdown pour les convertir en HTML et les publier sur le web. De plus, des outils comme Pandoc peuvent convertir des fichiers depuis et vers Markdown. Pour apprendre plus sur Pandoc, vous pouvez faire un tour sur [cette leçon](/en/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown) de Dennis Tenen et Grant Wythoff.      

## La syntaxe Markdown 
Les fichiers Markdown portent l'extension `.md`. Il est possible de les ouvrir avec un éditeur de texte comme TextEdit, Notepad, Sublime Text ou Vim. Plusieurs sites web et des plateformes de publication proposent des éditeurs de texte en ligne et/ou des extensions pour insérer du texte avec la syntaxe Markdown. 

Dans ce tutoriel, nous allons pratiquer la syntaxe Markdown à partir du navigateur en utilisant [StackEdit](https://stackedit.io) (*N.D.L.R. la leçon a été écrite en utilisant la version 4 de StackEdit qui est maintenant désuète. Des instructions sur la version 5 sont disponibles ci-dessous*). Cet éditeur de traitement vous permet d'insérer du texte formaté en Markdown à gauche et en avoir le rendu directement à côté, à droite.   

Puisque toutes les leçons du Programming Historian sont écrites en Markdown, nous pouvons aussi explorer ces fichiers avec StackEdit. Une fois sur la fenêtre de [l'éditeur Stackedit](https://stackedit.io/editor), cliquer sur `#` en haut à gauche pour accéder au menu, choisir `Import from URL` (*Importer URL*) puis coller l'URL suivante pour faire apparaître la leçon "Introduction to the Bash Command Line" (*Introduction au langage de commande Bash*):       
 
```
https://raw.githubusercontent.com/programminghistorian/jekyll/gh-pages/en/lessons/intro-to-bash.md
```
*N.D.L.R pour la traduction en français. La version 4 de StackEdit étant désormais désuète, afin de reproduire l'étape de l'exercice décrite ci-dessus, merci de tenir compte des changements suivants sur la version 5. Cette version ne proposant plus l'importation d'un fichier depuis une URL, au moins deux options s'offrent à vous: 
*1) A partir de l'adresse ci-dessus indiquée, copier l'ensemble du texte puis le coller dans le panel à gauche de l'éditeur de StackEdit qui se trouve désormais [ici](https://stackedit.io/app#).   
*2) A partir de l'adresse ci-dessus indiquée, copier l'ensemble du texte puis le coller dans un nouveau fichier en utilisant un éditeur de traitement de texte de votre préférence. Sauvegarder ce fichier sous format .md en local et aller sur l'éditeur de StackEdit accessible désormais [ici](https://stackedit.io/app#). Cliquer sur `#`, en haut **à droite** cette fois, pour accéder au menu puis choisir `Import Markdown` (*Importer Markdown*). Indiquer le chemin pour accéder au fichier que vous avez stocké en local puis ouvrir.*

Vous remarquez que, même si la fénêtre à droite offre un rendu plus élégant du texte, le fichier initial en Markdown, à gauche, reste bien lisible.

Maintenant, attaquons notre leçon pour rédiger notre propre syntaxe Markdown. Veuillez créer un nouveau document dans StackEdit en cliquant sur l'icône en haut à droite (*N.D.L.R. Attention, si vous êtes sur StackEdit version 5, l'icône se trouve en haut à gauche*) et en choisissant `New Document` (*Nouveau document*). Vous pouvez introduire un titre pour le document dans la boîte de texte en haut de la page.   

### En-têtes
Il y a quatre niveaux d'en-têtes disponibles en Markdown; ils sont indiqués par le nombre de `#` précédant le texte de l'en-tête. Merci de copier et coller les exemples suivants dans la boîte de texte à gauche.    

```
# En-tête de premier niveau
## En-tête de deuxième niveau
### En-tête de troisième niveau
#### En-tête de quatrième niveau
```

Les en-têtes de premier et de deuxième niveau peuvent aussi être signalés comme suit: 
```
En-tête de premier niveau
=======

En-tête de deuxième niveau
----------
```

**Le rendu aura l'aspect de ceci:**

# En-tête de premier niveau

## En-tête de deuxième niveau

### En-tête de troisième niveau

#### En-tête de quatrième niveau


Vous remarquez que la syntaxe Markdown reste compréhensible même dans sa version texte brut.

### Paragraphes et sauts de ligne

Insérez la phrase suivante dans la boîte de texte:  

```
Bienvenue au Programming Historian.

Aujourd'hui, nous allons travailler sur la syntaxe Markdown. 
Cette phrase se sépare de la précédente par un saut de ligne.
```
**Cela s'affiche de la manière suivante:**

Bienvenue au Programming Historian.

Aujourd'hui, nous allons travailler sur la syntaxe Markdown. 
Cette phrase se sépare de la précédente par un saut de ligne.

Les paragraphes doivent être séparés par une ligne vide. Tentez de laisser une ligne vide entre `syntaxe Markdown.` et `Cette phrase` pour vous rendre compte comment ça marche. Parfois, certaines configurations nécessitent de signaler les simples sauts de ligne avec en plus deux espaces vides à la fin de chaque ligne (qui précède). Ceci n'est toutefois pas le cas avec la [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/) version que StackEdit utilise par défaut.   


### Mise en forme

Vous pouvez mettre du texte en italique en le plaçant entre astérisques `*` ou tirets bas `_`. De même, pour le mettre en gras, placez le entre deux astérisques `**` ou deux tirets bas `__`.

Essayez de mettre en forme certaines parties du texte selon ces principes: 

```
Je suis **vraiment** ravie des tutoriels du _Programming Historian_.
```

**Ceci s'affiche comme suit:**

 Je suis **vraiment** ravie des tutoriels du _Programming Historian_.

### Listes 

Markdown permet de créer des listes ordonnées et non ordonnées. Essayez de créer la liste suivante dans la boîte de dialogue:

```
Liste de courses
----------
* Fruits
  * Pommes
  * Oranges
  * Raisins
* Produits laitiers
  * Lait
  * Fromage
```
Indenter l'astérisque `*` vous permet de créer des objets imbriqués. 

**Le rendu de ceci est comme suit:**

Liste de courses
-------------
* Fruits
  * Pommes
  * Oranges
  * Raisins
* Produits laitiers
  * Lait
  * Fromage

Les listes ordonnées sont rédigées en numérotant chaque ligne. Répétons-le, l'objectif de Markdown est de produire des documents qui sont à la fois lisibles en texte brut et transformables en d'autres formats. 

```
Liste à faire
----------
1. Achever le tutoriel Markdown
2. Aller à l'épicerie
3. Préparer le déjeuner
```

**Cella s'affiche comme suit:**

Liste à faire
----------
1. Achever le tutoriel Markdown
2. Aller à l'épicerie
3. Préparer le déjeuner

### Blocs de code
Représenter les blocs de code de manière distincte du reste du texte est une bonne pratique qui offre davantage de lisibilité. Habituellement le code est affiché à caractères à chasse fixe. Puisque Markdown ne distingue pas les polices, nous pouvons placer les blocs de code entre des guillements inverses tels `` ` ``. Par exemple, écrire `` `<br />` ``. Nous pouvons insérer des ensembles de code entre trois guillements inverses au début et trois à la fin. Dans la fenêtre de prévisualisation de StackEdit, cela donnera une boîte ombragée avec du texte en chasse fixe.        

Insérez le code suivant dans la boîte de dialogue: 

    ```html
    <html>
        <head>
            <title>Titre de site web</title>
        </head>
        <body>
        </body>
    </html>
    ```

**Cela donne:**

```
    <html>
        <head>
            <title>Titre de site web</title>
        </head>
        <body>
        </body>
    </html>
```

Remarquez comment le code s'affiche en police à chasse fixe.

### Blocs de citation

Ajouter une balise fermante `>` avant chaque paragraphe le fera apparaître comme élément de citation. 

Essayez de taper le texte suivant dans le panel: 

```
> Bonjour, je suis un paragraphe de texte englobé dans un bloc de citation. Regardez comment je suis décalé par rapport à la marge gauche. 
```

**Ceci s'affiche comme suit:**

> Bonjour, je suis un paragraphe de texte englobé dans un bloc de citation. Regardez comment je suis décalé par rapport à la marge gauche. 

### Liens

Les liens peuvent être signalés selon deux styles.

Pour insérer des liens à l'intérieur du texte, on place d'abord le texte d'accroche entre crochets puis l'URL (et éventuellement du texte supplémentaire) entre parenthèses.  
`Pour accéder à davantage de tutoriels, merci de visiter la page d'accueil du [Programming Historian](/ "Programming Historian main page").`

**Ceci s'affiche comme suit:**

Pour accéder à davantage de tutoriels, merci de visiter la page d'accueil du [Programming Historian](/ "Programming Historian main page").

Les liens de références sont très pratiques pour créer des notes de bas de page et permettent de garder votre document en texte brut propre. Ces liens s'écrivent entre une paire de crochets supplémentaire pour leur créer essentiellement un identifiant unique.

`Le site web du [Programming Historian][1] fournit un exemple.`

Puis vous pouvez ajouter l'URL dans une autre partie du document:

`[1]: http://programminghistorian.org/ "The Programming Historian"`

**Ceci s'affiche comme suit:**

Le site web du [Programming Historian][1] fournit un exemple.

[1]: http://programminghistorian.org/ "The Programming Historian"


### Images

Les images peuvent être référencées en utilisant un point d'exclamation `!` suivi par du texte supplémentaire entre crochets et, entre parenthèses, l'URL de l'image et éventuellement un titre entre guillemets. Les images ne s'affichent pas dans votre document en texte brut, mais elles seront intégrées à la page convertie en HTML.  

`![Logo de Wikipedia](https://upload.wikimedia.org/wikipedia/en/8/80/Wikipedia-logo-v2.svg "Logo de Wikipedia")`

**Ceci s'affiche comme cela:**

![Logo de Wikipedia](https://upload.wikimedia.org/wikipedia/en/8/80/Wikipedia-logo-v2.svg "Logo de Wikipedia")

#### Règles horizontales
Les règles horizontales sont créées lorsqu'au moins trois tirets `-`, astérisques `*` ou tirets bas `_` s'alignent seuls, avec ou sans espaces entre eux. Toutes les combinaisons suivantes vont donner des règles horizontales: 

```
___
* * *
- - - - - -
```

**Ceci donne cela:**

---
***
- - - - - - -

### Tables

Contrairement aux spécifications de base de Markdown, il en existe des variantes utilisées par des sites et des applications qui peuvent permettre la création de tables et d'autres fonctionnalités. [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/) est une de ces variantes, principalement utilisée pour afficher des fichiers `.md` dans le navigateur sur le site web de Github. 
 is one of these variants, and is used to render `.md` files in the browser on the GitHub site.

Il est possible de créer une table dans Github en utilisant des barres verticales `|` pour séparer les colonnes et des tirets `-` au milieu de vos en-têtes et du contenu de la table. Les barres verticales sont strictement nécessaires seulement entre les colonnes, vous pouvez néanmoins les utiliser des deux côtés de votre table pour obtenir un résultat plus soigné. Il n'y a pas de limitation quant à la longueur du contenu des cellules et il n'est pas nécessaire d'aligner les barres verticales. 

```
| En-tête 1 | En-tête 2 | En-tête 3 |
| --------- | --------- | --------- |
| Ligne 1, colonne 1 | Ligne 1, colonne 2 | Ligne 1, colonne 3|
| Ligne 2, colonne 1 | Ligne 2, colonne 2 | Ligne 2, colonne 3|
| Ligne 3, colonne 1 | Ligne 3, colonne 2 | Ligne 3, colonne 3|
```

**Cela s'affiche comme suit:**

| En-tête 1 | En-tête 2 | En-tête 3 |
| --------- | --------- | --------- |
| Ligne 1, colonne 1 | Ligne 1, colonne 2 | Ligne 1, colonne 3|
| Ligne 2, colonne 1 | Ligne 2, colonne 2 | Ligne 2, colonne 3|
| Ligne 3, colonne 1 | Ligne 3, colonne 2 | Ligne 3, colonne 3|

Pour régler l'alignement de chaque colonne, les deux points `:` peuvent être ajoutés dans la ligne de l'en-tête comme suit:

```
| Aligner à gauche | Centrer | Aligner à droite |
| :-------- | :-------: | --------: |
| Pommes | Rouge | 5000 |
| Bananes | Jaune | 75 |
```
**Cela s'affiche comme suit:**

| Left-aligned | Centered | Right-aligned |
| :-------- | :-------: | --------: |
| Pommes | Rouge | 5000 |
| Bananes | Jaune | 75 |


## Les limites de Markdown
Même si Markdown devient de plus en plus populaire, notamment pour formatter des documents exposés sur le web, beaucoup de gens et d'éditeurs sollicitent des documents traditionnels en Word, PDF et d'autres formats de fichiers. Certains outils de conversion exécutables en ligne de commande, comme [Pandoc](http://johnmacfarlane.net/pandoc/), offrent une solution, sans toutefois offrir toutes les fonctionnalités des logiciels de traitement de texte, notamment le versionnage. Pour savoir plus sur Pandoc, merci de consulter la leçon du Programming Historian intitulé [Sustainable authorship in plain text using Pandoc and Markdown](/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown) (en anglais).


## Conclusion
Markdown est une solution utile à mi-chemin entre les fichiers textes bruts et les logiciels de traitement de texte aux formats hérités. Sa syntaxe simple est facile à apprendre et lisible non seulement en tant que telle, mais aussi après conversion en HTML et vers d'autres formats. Opter pour écrire ses documents en Markdown c'est s'assurer que ceux-ci seront utilisables et lisibles à long terme. 
