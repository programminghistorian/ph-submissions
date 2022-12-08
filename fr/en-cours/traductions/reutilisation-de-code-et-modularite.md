---
title: Réutilisation de code et modularité
collection: lessons
layout: lesson
slug: reutilisation-de-code-et-modularite
date: 2012-07-17
authors:
- William J. Turkel
- Adam Crymble
reviewers:
- Jim Clifford
editors:
- Miriam Posner
translation_date: 2021-04-30 
translator: 
- Célian Ringwald
translation-editor:
- Marie Flesch
translation-reviewer:
- Prénom Nom
original: code-reuse-and-modularity
difficulty: 2
review-ticket: ajouter-url-ticket-relecture-sur-ph-submissions
activity: transforming
topics: [python]
next: telecharger-des-pages-web-avec-python
previous: travailler-avec-des-fichiers-texte
series_total: 15 lessons
sequence: 4
categories: [lessons, original-ph, python]
avatar_alt: Trois visages caricaturés
abstract: "Un programme informatique peut vite devenir un très long fichier et ainsi devenir peu commode à maintenir, notamment quand  aucune stratégie n'a été mise en place afin de contrôler cette  complexité. Cette leçon sera l'occasion de vous expliquer comment ré-utiliser des parties de votre code à l'aide de l'écriture de fonctions, mais aussi comment organiser un programme en modules, de manière à rendre celui-ci plus concis et plus facile à débugger."
doi: 
---

{% include toc.html %}

# Objectifs de la leçon

Un programme informatique peut vite devenir un très long fichier et ainsi devenir peu commode à maintenir, notamment quand aucune stratégie n'a été mise en place afin de contrôler cette  complexité. Cette leçon sera l'occasion de vous expliquer comment ré-utiliser des parties de votre code à l'aide de l'écriture de *fonctions*, mais aussi comment organiser un programme en *modules*, de manière à rendre celui-ci plus concis et plus facile à débugger. En effet être capable de repérer et de supprimer un module dysfonctionnel vous permettra d'économiser en temps et en efforts.

## Les fonctions

Dans la pratique, vous vous rendrez compte qu'il est souvent nécessaire de répéter certaines séries d'instructions,  généralement parce que l'on est amené à réaliser certaines tâches à plusieurs reprises. Les programmes sont, pour la plupart, composés de routines qui sont assez robustes et générales pour être réutilisées. Elles sont connues sous le nom de fonction et Python propose un moyen de définir de nouvelles fonctions. Pour illustrer cela observons un exemple simple de fonction. Supposez que vous souhaitez définir une fonction qui saluerait des personnes. Copiez la définition de cette fonction dans un éditeur de texte et sauvegardez là dans un fichier nommé ```salutation.py```.

``` python
# salutation.py

def saluer(x):
    print("Bonjour " + x)

saluer("tout le monde")
saluer("Programming Historian")
```

La première ligne commençant par ```def``` est la déclaration de la fonction. Nous y définissons ("def") une fonction qui s'appelle "saluer". Le *paramètre* de la fonction est ```(x)```, vous comprendrez bientôt à quoi celui-ci va nous servir. La seconde ligne contient le code de notre fonction. Une fonction peut contenir autant de lignes que vous le souhaitez, dans notre cas, elle n'est composée que d'une ligne.

Notez que *l'indentation* est très importante en Python. L'espace avant le ```print``` contenu dans notre fonction ```saluer``` indique à l'interpréteur que nous nous situons au sein de la fonction. Nous en apprendrons plus à ce sujet plus tard; pour le moment vérifier seulement que l'indentation dans votre fichier soit bien la même que celle que vous nous présentons. 
Lancez le programme, vous devriez à cette issue obtenir quelque chose ressemblant à cela :

``` python
Bonjour tout le monde
Bonjour Programming Historian
```

Cet exemple ne contient qu'une seule fonction *saluer*. Celle-ci est "appelée" deux fois (on peut aussi dire que celle-ci est "invoquée"). Appeler une fonction ou l'invoquer signifie juste que nous demandons au programme d'exécuter le code compris dans celle-ci. Pour reprendre l'exemple précédemment évoqué, c'est comme lorsque l'on donne à notre chien un délicieux snack au poulet et que celui-ci abouie deux fois (*woof* *woof*). Nous avons ici appelé notre fonction avec deux paramètres différents. Éditez le fichier ```salutation.py```en invoquant à la fin de celui-ci une nouvelle fois notre fonction en remplaçant le paramètre par votre prénom. Lancez le programme, cela devrait éclairer ce que ```(x)``` représente dans la déclaration de la fonction.

Avant de passer à la prochaine étape, éditez ```salutation.py``` de manière à supprimer les appels de fonctions et en ne gardant que la déclaration de la fonction et son contenu. Nous allons maintenant apprendre à appeler une fonction depuis un autre programme. Lorsque vous aurez terminé, votre fichier ```salutation.py``` devrait ressembler à cela :

``` python
# salutation.py

def saluer(x):
    print("Bonjour " + x)
```

# Modularité

Dans notre exemple le programme est très court et tout tiens naturellement dans un unique fichier. Lorsque vous souhaitez lancer un de vos programmes, il vous suffit de le soumettre à l'interpréteur. Mais quand un programme commence à devenir plus important en terme de  nombre de lignes, il sera alors judicieux de le séparer en plusieurs  fichiers appelés *modules*.  Cette modularité facilitera grandement la maintenance de votre code, qui ne serait pas aussi évidente si stockez celui-ci dans un grand fichier. En effet, cette méthode de travail permet alors de travailler de manière indépendante sur chaque partie de votre code avant de les faire tenir toutes ensembles, ainsi vous ne simplifierez pas seulement la réutilisation de votre code mais serrez alors capable de fixer les erreurs en repérant rapidement leur source. Quand l'on sépare un programme en module, nous ne sommes alors plus obligé de ré-écrire le détail de chaque procédure que nous  souhaitons réaliser. De plus, chaque module n'a pas  besoin de savoir comment quelque chose s'accomplit s'il n'est pas responsable de cette tache. Ce principe est appelé *"l'encapsulation"*.

Supposons que vous construisiez une voiture. Vous pourriez dans ce cadre commencer par ajouter une à une des pièces à celle-ci, mais il serait peut-être enviable de commencer par construire et tester un module — comme par exemple un moteur — avant de d'ajouter le reste. Le moteur lui-même pourrait être envisagé comme composé d'un certain nombre de modules, plus petits, comme un carburateur, un système  d'allumage, qui pourraient eux-mêmes être composés de modules, encore plus basiques et plus petits. Il en est de même lorsque l'on travaille sur un code informatique, on  essaye de décomposer chaque problème en petits morceaux et de résoudre ceux-ci un à un.

Vous avez déjà créé un module quand nous écrit le programme ```salutation.py```. Vous allez maintenant en écrire un second ```utiliser-salutation.py``` qui comme l'indique son nom va *importer* le code du module pour en tirer parti. Python possède une instruction spécifique appelée ```import``` qui permet à un programme d'accéder au contenu d'un autre programme. C'est ce que nous allons utiliser.

Copiez ce code dans Komodo Edit et sauvegarder le dans un fichier nommé `utiliser-salutation.py`. Ce fichier est votre programme, `salutation.py`est ici un module.

``` python
# utiliser-salutation.py

import salutation
salutation.saluer("Tout le monde")
salutation.saluer("Programming Historian")
```

Nous faisons ici plusieurs choses : premièrement, nous demandons à l'interpréteur d'*importer* (commande ```import``` ) le module ```salutation.py``` que nous avons créé précédemment.

Vous remarquerez aussi que nous ne pouvons pas appeler une fonction directement à travers son nom de cette manière : saluer("Tout le monde"), nous devons faire précéder celui-ci du nom du module suivi d'un point (.). Ce qui en clair signifie : lancez la fonction *saluer*, que vous devriez trouver dans le module  ```salutation.py```.

Vous pouvez lancer alors le programme ```utiliser-salutation.py``` avec la commande “Run Python” de Komodo Edit . Notez que vous n'avez pas à lancer vous-même le module... mais seulement un programme qui fait appel à celui-ci. Si tout se passe bien, vous devriez voir les lignes suivantes s'afficher dans la sortie de Komodo Edit : 

``` python
Bonjour tout le monde
Bonjour Programming Historian
```

Avant de poursuivre les tutoriels suivants,  assurez-vous de bien avoir compris la différence entre le chargement  d'un fichier de données (ex. `helloworld.txt`) et l'importation d'un programme (e.g. `salutation.py`).

# Lectures suggérées

- [Python Basics](http://www.astro.ufl.edu/~warner/prog/python.html)
