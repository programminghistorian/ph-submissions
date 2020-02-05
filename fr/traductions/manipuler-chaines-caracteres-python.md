---
title: Manipuler des chaînes de caractères en Python
layout: lesson
slug: manipuler-chaines-caracteres-python
date: 2012-07-17
authors:
- William J. Turkel
- Adam Crymble
reviewers:
- Jim Clifford
editors:
- Miriam Posner
translator: 
- Camille Carette
translation-editor:
- François Dominic Laramée
translation-reviewer: 
translation_date: 
difficulty: 2
exclude_from_check:
  - review-ticket
activity: transforming
topics: [python]
abstract: "This lesson is a brief introduction to string manipulation techniques in Python."
next: from-html-to-list-of-words-1
previous: working-with-web-pages
python_warning: false
original: manipulating-strings-in-python
avatar_alt: A man playing a guitar
---

{% include toc.html %}



# Manipuler les chaînes de caractères en Python

Traduit par Camille Carette (Ecole nationale des chartes)


Cette leçon est une brève introduction aux techniques de manipulation des caractères en Python.

##Sommaire
- Objectifs de la leçon
- Manipulation des chaînes Python
- Opérateurs de cordes : Ajout et multiplication
	- Concaténer
	- Multiplier
	- Ajouter
- Méthodes de chaînes de caractères : Trouver, modifier
	- Longueur
	- Trouver
	- Minuscules
	- Remplacer
	- Trancher
- Séquences d'évasion
- Lecture supplémentaire
- Synchronisation de code


## Objectifs du cours

Ce cours est une courte introduction à la manipulation des [chaînes de caractères](https://fr.wikipedia.org/wiki/Cha%C3%AEne_de_caract%C3%A8res) en Python. Pour la plupart des tâches de traitement de texte, il est crucial de savoir comment manipuler les chaînes de caractères. Si vous souhaitez vous entraîner tout au long des cours suivants, vous pouvez écrire et exécuter des programmes courts, comme nous l'avons fait dans les cours précédents de la série, ou vous pouvez ouvrir un terminal en Python pour les tester avec l’interface en ligne de commande.

## Manipuler les chaînes de caractères en Python

Si vous avez déjà été confrontés à un autre langage de programmation auparavant, vous avez peut-être appris que vous aviez besoin de *déclarer* ou de *typer* vos variables avant de pouvoir y stocker quoique ce soit. Ce n’est pas nécessaire lorsque l’on travaille avec Python. En effet, l’on peut simplement créer une chaîne de caractères mettant entre guillemets le contenu de la variable, et en utilisant le signe égal (=) :

	message = "Hello World"

## Les opérateurs de chaînes : additionner et multiplier

Une chaîne de caractère est une classe d’objets qui consiste en une série de caractères. Python sait déjà gérer un certain nombre de représentations générales et puissantes, y compris les chaînes de caractères. L’une des façons de manipuler ces chaînes de caractères est d’utiliser* un opérateur de chaînes*. Ces opérateurs sont représentés par des signes que l’on associe généralement avec les mathématiques, tels que +, -, *, / et =. Lorsqu’on les utilise avec des chaînes de caractères, elles effectuent des actions qui sont comparables, mais non similaires, à leur équivalent mathématique.

## Concaténer

Ce terme signifie “joindre des chaînes de caractères”. Ce processus est appelé *la concaténation de chaînes*, et s’effectue en utilisant l’opérateur plus (+). Notez qu’il vous faut indiquer explicitement là où vous voulez que des espaces apparaissent en les mettant eux aussi entre des guillemets simples.

Dans cette exemple, on attribue le contenu “hello world” à la chaîne de caractères “message1”.

	message1 = 'hello' + ' ' + 'world'
	print(message1)
	-> hello world

## Multiplier

Si vous voulez plusieurs copies d’une chaîne de caractères, utilisez l’opérateur de la multiplication (*). Dans cet exemple, on attribue le contenu “hello” trois fois à la chaîne de caractères *message2a*, et l’on attribue le contenu “world” à la chaîne de caractères *message2b*. Puis, nous imprimons ces deux chaînes.
	
	message2a = 'hello ' * 3
	message2b = 'world'
	print(message2a + message2b)
	-> hello hello hello world

## Ajouter

Que faire si vous souhaitez ajouter quelque chose à la fin d’une chaîne de caractères, à la suite du contenu ? Il  y a un opérateur spécial pour ça (+=).

	message3 = 'howdy'
	message3 += ' '
	message3 += 'world'
	print(message3)
	-> howdy world

## Méthodes pour les chaînes de caractères : trouver, changer

En plus des opérateurs, Python possède des douzaines de méthodes pré-installées pour les chaînes de caractères, qui nous permettent de faire des choses à ces chaînes. Utilisées seules ou de manière combinées, ces méthodes peuvent faire à peu près tout ce à quoi vous pouvez penser aux chaînes de caractères. La bonne nouvelle est que vous pouvez consulter une liste de ces méthodes sur [le site de Python](https://docs.python.org/2/library/stdtypes.html#string-methods), y compris des informations sur la manière de les utiliser correctement. Pour vous assurer que vous avez une connaissance de base des méthodes de chaînes de caractères, ce qui suit est un bref aperçu de quelques-unes des méthodes les plus couramment utilisées :

### Longueur

Vous pouvez déterminer le nombre de caractères d'une chaîne de caractères à l'aide de `len`. Notez que l'espace blanc compte comme un caractère séparé.

	message4 = 'hello' + ' ' + 'world'
	print(len(message4))
	-> 11

### Trouver

Vous pouvez rechercher une chaîne de caractères pour *une sous-chaîne* et votre programme retournera la position de l'index de départ de cette sous-chaîne. Ceci est utile pour la suite du traitement. Notez que les index sont numérotés de gauche à droite et que le comptage commence par la position 0 et non 1.

	message5 = "hello world"
	message5a = message5.find("worl")
	print(message5a)
	-> 6

Si la sous-chaîne n'est pas présente, le programme renvoie une valeur de -1.
	
	message6 = "Hello World"
	message6b = message6.find("squirrel")
	print(message6b)
	-> -1

### Minuscules

Il est parfois utile de convertir une chaîne de caractères en minuscules. Par exemple, si nous standardisons les casses, il est plus facile pour l'ordinateur de reconnaître que "Parfois" et "parfois" sont le même mot.
	
	message7 = "HELLO WORLD"
	message7a = message7.lower()
	print(message7a)
	-> hello world

L'effet inverse, augmenter les caractères en majuscules, peut être obtenu en changeant `.lower()` en `.upper().`

### Remplacer

Si vous avez besoin de remplacer une sous-chaîne à travers une chaîne, vous pouvez le faire avec la méthode `replace`.

	message8 = "HELLO WORLD"
	message8a = message8.replace("L", "pizza")
	print(message8a)
	-> HEpizzapizzaO WORpizzaD

### Couper (Slice)

Si vous voulez couper (`slice`) les parties non désirées d'une chaîne de caractères du début à la fin, vous pouvez le faire en créant une chaîne de caractères. Le même type de technique vous permet également de briser une longue chaîne de caractères en composants plus faciles à gérer.
	
	message9 = "Hello World"
	message9a = message9[1:8]
	print(message9a)
	-> ello Wo

Vous pouvez substituer des variables aux entiers utilisés dans cet exemple.

	startLoc = 2
	endLoc = 8
	message9b = message9[startLoc: endLoc]
	print(message9b)
	-> llo Wo

Cela facilite beaucoup l'utilisation de cette méthode en conjonction avec la méthode `find` comme dans l'exemple suivant, qui vérifie la présence de la lettre "d" dans les six premiers caractères de "Hello World" et nous dit correctement qu'elle n'est pas présente (-1). Cette technique est beaucoup plus utile dans des chaînes de caractères plus longues - des documents entiers par exemple. Notez que l'absence d'un entier avant les deux points signifie que nous voulons commencer au début de la chaîne. Nous pourrions utiliser la même technique pour dire au programme d'aller jusqu'au bout en ne mettant aucun entier après les deux points. Et n'oubliez pas que les positions de l'indice commencent à compter à partir de 0 plutôt que de 1.

	message9 = "Hello World"
	print(message9[:5].find("d"))
	-> -1

Il y en a beaucoup d'autres, mais les méthodes de chaînes ci-dessus sont un bon début. Notez que dans ce dernier exemple, nous utilisons des crochets au lieu de parenthèses. Cette différence de syntaxe signale une distinction importante. En Python, les parenthèses sont généralement utilisées pour passer un argument à une fonction. Donc quand on voit quelque chose comme

	print(len(message7))

cela signifie passer la chaîne de caracteres "chaîne7" à la fonction `len` puis envoyer la valeur retournée de cette fonction à l'instruction d'impression à imprimer. Si une fonction peut être appelée sans argument, vous devez souvent inclure une paire de parenthèses vides après le nom de la fonction. Nous en avons aussi vu un exemple :

	message7 = "HELLO WORLD"
	message7a = message7.lower()
	print(message7a)
	-> hello world

Cette instruction demande à Python d'appliquer la fonction `lower` à la chaîne "message7" et de stocker la valeur retournée dans la chaîne "message7a".

Les crochets ont une fonction différente. Si vous pensez à une chaîne de caractères comme une séquence de caractères, et que vous voulez pouvoir accéder au contenu de la chaîne par leur emplacement dans la séquence, alors vous avez besoin d'un moyen de donner à Python un emplacement dans une séquence. C'est ce que font les crochets : indiquer un emplacement de début et de fin dans une séquence comme nous l'avons vu en utilisant la méthode `slice`.

## Séquence d'échappement

Que faites-vous lorsque vous devez inclure des guillemets dans une chaîne de caractères ? Vous ne voulez pas que l'interpréteur Python se fasse une fausse idée et mette fin à la chaîne lorsqu'il rencontre l'un de ces caractères. En Python, vous pouvez mettre une barre oblique inversée (\) devant un guillemet pour qu'elle ne termine pas la chaîne. C'est ce qu'on appelle les séquences d'échappement.
	
	print('\"') 
	-> "

	print('The program printed \"hello world\"')
	-> The program printed "hello world"

Deux autres séquences d'échappement vous permettent d'imprimer des onglets et des nouvelles lignes :
	
	print('hello\thello\thello\nworld')
	->hello hello hello
	world

## Bibliographie
- Lutz, Learning Python
	- Ch. 7: Strings
	- Ch. 8: Lists and Dictionaries
	- Ch. 10: Introducing Python Statements
	- Ch. 15: Function Basics

## Synchronisation de code

Pour suivre les leçons à venir, il est important d'avoir les bons fichiers et programmes dans votre répertoire programming-historian. A la fin de chaque chapitre, vous pouvez télécharger le fichier zip de programming-historian pour vous assurer que vous avez le bon code. Notez que nous avons supprimé les fichiers inutiles des leçons précédentes. Votre répertoire peut contenir plus de fichiers et c'est OK !

- programming-historian-1 ([zip](https://programminghistorian.org/assets/python-lessons1.zip))

Super ! Vous êtes maintenant prêt à passer à[ la leçon suivante](https://programminghistorian.org/en/lessons/from-html-to-list-of-words-1).
