---
title: Du Html à une liste de mots (partie 2)
slug: du-html-a-une-liste-de-mots-2
original: from-html-to-list-of-words-2
layout: lesson
collection: lessons
date: 2012-07-17
translation_date: YYYY-MM-DD 
authors:
- William J. Turkel
- Adam Crymble
reviewers:
- Jim Clifford
- Frederik Elwert
editors:
- Miriam Posner
translator: 
- Célian Ringwald
translation-editor:
- Émilien Schultz
translation-reviewers:
- Forename Surname
- Forename Surname
difficulty: 2
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/584
activity: transforming
topics: [python]
abstract: Dans cette leçon, nous allons concrètement implémenter l'algorithme que nous avons discuté lors de la leçon précédante "Du Html à une liste de mots (partie 1). Nous avons jusque là pu écrire une procédure chargeant le contenu d'une page HTML et retournant le contenu présent entre la première balise `<p>` et la dernière balise `<br/>`. 
categories: [lessons, python]
avatar_alt: Un homme qui imite une girafe
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

# Objectifs de la leçon 

Dans cette leçon, nous allons concrètement implémenter l'algorithme que nous avons discuté lors de la leçon précédante : [Du Html à une liste de mots (partie 1)](https://programminghistorian.org/en/lessons/from-html-to-list-of-words-1). Nous avons jusque là pu écrire une procédure chargeant le contenu d'une page HTML et retournant le contenu présent entre la première balise `<p>` et la dernière balise `<br/>`. 

La seconde partie de notre algorithme devra réaliser la procédure suivante :


- Inspecter chaque caractère de la chaîne `pageContents` un à un :
    * Si le caractère est un crochet ouvrant, nous sommes alors à l'intérieur d'une balise : nous ignorons donc ce caractère et nous ignorerons aussi les suivants;
    * Si le caractère est un crochet fermant (`>`) cela signifie que nous ressortons de la balise : nous ignorons le caractère courant et inspecterons alors avec attention les suivants;
    * Si nous ne sommes pas dans une balise, nous ajoutons alors le caractère courant à une variable appelée `text`;

Nous découperons ensuite la chaîne de caractères `text` en une liste de mots individuels que nous manipulerons par la suite.

## Fichiers nécessaires au suivi de la leçon

-   `obo.py`
-   `trial-content.py`

Si vous n'avez pas déjà ces fichiers, vous pouvez télécharger le fichier [`python-lessons2.zip`](https://programminghistorian.org/assets/python-lessons2.zip) issu de la leçon précédente.

# Boucles et instructions conditionnelles en Python

La prochaine étape dans l'implémentation de l'algorithme consiste à inspecter chaque caractère de la chaîne `pageContents` un à un et de tester si le caractère courant est un élement d'une balise HTML ou bien le contenu de la transcription du procès. 

Mais avant cela, nous allons découvrir quelques techniques nous permettant de **répéter une tache** et **d'évaluer si** une condition est remplie.

## Les boucles


Comme de nombreux autres langages de programmation, Python propose plusieurs moyens de réaliser des boucles . Le plus adaptée à notre problématique est ici la boucle `for`. Cette instruction permet de demander à l'interpréteur de réaliser une tâche sur chaque caractère de la chaîne `pageContents`. Une variable `char` contiendra alors le caractère courant de la chaîne `pageContents` que nous parcourons. 

Nous avons ici nommé cette variable `char`; mais cela n'a pas d'importance particulière dans le fonctionnement du programme, car nous aurions pu la nommer *trucbidule* ou bien encore *k* si nous en avions envie. Cependant, certaines nominations ne sont pas mobilisables, car déjà attribuées à une fonction Python bien définie (comme par exemple `for`). Pour vérifier si cela est le cas, vous pouvez vous reposer sur la fonction de coloration de votre éditeur de texte afin de savoir si le nom d'une variable est disponible au nommage (comme ici `char`). Il est évidemment plus astucieux de donner aux variables des noms qui nous informent sur leurs contenus. Il sera ainsi plus simple de revenir sur un programme plus tard. Pour ces raisons nommer sa variable '*trucbidule*' n'est pas forcément le meilleur choix de nom de variable.


``` python
for char in pageContents:
    # faire quelque chose avec le caractère courant (char)
```

## Les instructions conditionnelles

Nous avons maintenant besoin d'un mécanisme de contrôle concernant le contenu de notre chaîne de caractères. Python propose différents moyens de réaliser des *tests conditionnels*.

Celui dont nous avons besoin est l'instruction conditionnelle `if`. Le code ci-dessous utilise l'instruction `if` pour vérifier si la chaîne de caractères nommée `char` est égale à un crochet ouvrant. Comme nous l'avons déjà mentionné, l'identation est très importante en Python. Si le code est bien indenté, Python n'exécutera le code que si la condition définie est vérifiée.

Notez que la syntaxe Python privilégie l'utilisation du signe égal (=) pour réaliser des *affectations*, ce qui permet de donner une valeur à une variable. Pour tester une *égalité*, il faudra alors user du doubler signe égal (==). Les programmeurs débutants ont souvent tendance à confondre ces deux utilisations. 


``` python
if char == '<':
    # faire quelque chose
```
Une forme plus générale de *l'instruction si* permet de spécifier ce que nous souhaitons faire dans le cas où la condition spécifiée n'est pas réalisée.

``` python
if char == '<':
    # faire quelque chose
else:
    # faire quelque chose d'autre
```
Python laisse aussi la possibilité de vérifier d'autres conditions après la première instruction, et ceci en utilisant *l'instruction elif* (qui est une contraction de 'else if').

``` python
if char == '<':
    # faire quelque chose
elif char == '>':
    # faire quelque chose d'autre
else:
    # faire quelque chose de complètement différent
```

# Utiliser l'algorithme pour supprimer le balisage HTML

Vous en savez maintenant suffisamment pour implémenter la seconde partie de l'algorithme qui consiste à supprimer toutes les balises HTML. Dans cette partie, nous souhaitons :

-  Inspecter chaque caractère de la chaîne `pageContents` un à un :
    * Si le caractère courant est une chevron ouvrant (`<`) cela signifie que nous entrons dans une balise, dans ce cas nous ignorons ce caractère et ignorerons les suivants;
    * Si le caractère courant est un chevron fermant (`>`), cela signifie que nous ressortons de la balise, nous ignorons alors seulement ce caractère et prêterons attention aux suivants;
    * Si nous ne sommes pas au sein d'une balise, nous ajoutons le caractère courant dans une variable nommée `text`;

Pour réaliser cela, nous allons utiliser une *boucle for* qui vous permettra d'inspecter de manière itérative chaque caractère de la chaîne. Vous utiliserez une suite d'instructions conditionnelles (`if` / `elif`) pour déterminer si le caractère courant est inclus dans une balise. Ou s'il fait partie au contraire du contenu à extraire, dans quel cas nous, ajouterons alors le caractère courant à la variable `text`. 

Cependant comment pourrions nous garder en mémoire le fait que nous soyons ou non au sein d'une balise ? Nous utiliserons à ce titre une variable de type entier, qui vaudra 1 (vrai) si nous sommes dans une balise et qui vaudra 0 (faux) si ce n'est pas le cas (dans l'exemple plus bas nous avons appelé cette variable `inside`).

## La fonction de suppression de balises 

Mettons désormais en pratique ce que nous avons pu apprendre ensemble, la version finale de la fonction `stripTags` nous permettant d'atteindre notre objectif est décrite plus bas. Faites encore une fois bien attention à l'indentation de manière à ce qu'elle soit bien équivalente à ce qui est illustré ci-dessous lorsque vous remplacerez l'ancienne fonction `stripTags` dans `obo.py` avec la nouvelle.

Si vous avez tenté de construire la fonction vous-même, il est tout à fait normal qu'elle puisse être différente que celle que nous vous présentons ici. Il existe souvent plusieurs moyens d'arriver à la même fin, l'essentiel est pour le moment que cela réalise bien l'objectif que nous nous étions fixé.

Cependant, à titre de vérification, nous vous conseillons de vérifier que votre fonction renvoie bien le même résultat que la nôtre :

``` python
# obo.py
def stripTags(pageContents):
    # Typer le contenu du code source de la page
    pageContents = str(pageContents)
    # Retourne indice du premier paragraphe
    startLoc = pageContents.find("<p>")
    # Retourne indice du dernier passage à la ligne
    endLoc = pageContents.rfind("<br/>")
    # Ne garde que le contenu entre le premier paragraphe et le dernier passage à la ligne
    pageContents = pageContents[startLoc:endLoc]
    
    # Initialisation 
    inside = 0 # booléen pour repérage contenu 
    text = '' # variable contenant contenu

    # Pour chaque caractère...
    for char in pageContents:
        
        if char == '<':
            inside = 1
        elif (inside == 1 and char == '>'):
            inside = 0
        elif inside == 1:
            continue
        else:
            text += char

    return text
```

Nous voici ici face à deux nouveaux concepts Python : `continue` et `return`.

L'instruction Python `continue` est mobilisable seulement dans les boucles. Il permet lorsqu'une condition est remplie de passer à l'itération suivante. Quand nous arrivons à un caractère inclus au sein d'une balise HTML, nous pouvons par ce moyen passer directement au prochain caractère sans avoir à ajouter celui-ci à la variable `text`.

Dans l'exemple précédant, nous avons amplement usé de la fonction *print*. Elle permet d'afficher à l'écran le résultat d'un programme pour qu'il puisse être lu par l'utilisateur. Cependant, et dans la majorité des cas, nous souhaitons simplement faire parvenir une information d'une partie d'un programme à une autre. À ce titre, quand l'exécution d'une fonction se termine, elle renvoie une valeur au code qui l'a appelé via l'instruction `return`. Si nous souhaitons appeler la fonction `stripTags` dans un autre programme voici maintenant devons nous y prendre :


``` python
# Pour comprendre comment fonctionne l'instruction return

import obo

myText = "Ceci est un message <h1>HTML</h1>"

theResult = obo.stripTags(myText)
```

En utilisant l'instruction `return`, nous sommes alors capables de sauvegarder la sortie de la fonction `stripTags` directement dans une variable appelé '*theResult*', que nous pourront ensuite réutiliser si besoin par la suite.

Vous remarquerez que le contenu retourné par l'exemple d'utilisation de  `stripTags` ci-dessus, n'est plus égale au contenu de *myText*, mais bien au contenu sans balises HTML.

Pour tester notre nouvelle fonction `stripTags`, vous pouvez relancer `trial-content.py`. Depuis que nous avons redéfini `stripTags`, le programme `trial-content.py` réalise maintenant autre chose (plus proche de notre objectif). Avant de continuer, vérifiez que vous avez bien compris pourquoi le comportement de `trial-content.py` change lorsque l'on édite `obo.py`.

# Les listes Python 

Maintenant que nous avons la possibilité d'extraire le texte d'une page web, nous souhaitons transformer ce texte de manière à ce qu'il soit plus facile à traiter. 

Jusqu'à présent, quand vous aviez besoin de stocker de l'information dans un programme Python, nous avons généralement choisi de le faire au format chaîne de caractère.

Mais cela n'a pas été toujours le cas, comme par exemple dans la fonction `stripTags`, où nous avons utilisé le format *entier* ([Integer](http://docs.python.org/2.4/lib/typesnumeric.html)) pour stocker 1 quand nous entions au sein d'une balise et 0 lorsque ce n'était pas le cas. Avec les entiers, vous pouvez réaliser des opérations mathématiques mais il n'est pas possible d'y stocker des fractions et des nombres décimaux.

``` python
inside = 1
```
De plus, sans le savoir, à chaque fois que vous avez eu besoin de lire ou d'écrire dans un fichier, vous avez utilisé un objet de type fichier spécifique comme *f* dans l'exemple ci-dessous.

``` python
f = open('helloworld.txt','w')
f.write('hello world')
f.close()
```
Un autre type d'objets ([types](http://docs.python.org/3/library/types.html)) proposé par Python est cependant aussi très utile, il s'agit des *listes*, qui sont des collections ordonnées d'autres objets (pouvant inclure potentiellement des listes).

Convertir une chaîne de caractères en liste de caractères ou de mots est assez simple. Copiez ou tapez le programme suivant dans votre éditeur de texte pour comprendre les deux moyens de réaliser cette opération. Sauvegardez le fichier en le nommant `string-to-list.py` et exécutez-le. Comparez ensuite les deux listes obtenues dans la sortie de la commande et à la vue de ces résultats, essayez de comprendre comment fonctionne ce bout de code.

``` python
# string-to-list.py
# deux chaînes de caractères
s1 = 'hello world'
s2 = 'howdy world'


# liste de 'caractères'
charlist = []
for char in s1:
    charlist.append(char)
print(charlist)

# liste de 'mots'
wordlist = s2.split()
print(wordlist)
```

La première routine utilise une boucle for pour parcourir chaque caractère de la chaîne `s1`, elle ajoute ainsi chaque caractère à la fin de *charlist*. 

La seconde routine utilise l'opération `split` qui permet de découper la chaîne `s2` là où se trouvent des blancs (espaces, tabulations, retour charriot et autres caractères similaires). 

Pour le moment, nous avons simplifié un peu les choses concernant la procédure utilisée pour le découpage de la chaîne en liste de mots. Modifiez la chaîne `s2` utilisé dans le programme et donnez lui la valeur ‘salut le monde!’ puis relancer le programme. 
 
Qu'est-il arrivé au point d'exclamation ? 
 
Notez, que vous devez sauvegardez le modifications apportées à notre programme avant de pouvoir le relancer Python.

Compte tenu de vos nouvelles connaissances, ouvrez maintenant l'URL, téléchargez la page web, sauvegardez son contenu dans une chaîne de caractères et comme nous l'avons vu à l'instant découper celle-ci en une liste de mots. Exécutez alors le programme suivant. 

``` python
#html-to-list1.py
import urllib.request, urllib.error, urllib.parse, obo

url = 'http://www.oldbaileyonline.org/print.jsp?div=t17800628-33'

response = urllib.request.urlopen(url) # requête la page et récupère le code source
html = response.read().decode('UTF-8') # lit le contenu 
text = obo.stripTags(html) # Nous utilisons ici notre fonction
wordlist = text.split() # et transformons ici le texte en liste de mots

print((wordlist[0:120]))

```
Vous devriez obtenir quelque chose ressemblant à cela :

``` python
['324.', '\xc2\xa0', 'BENJAMIN', 'BOWSEY', '(a', 'blackmoor', ')', 'was',
'indicted', 'for', 'that', 'he', 'together', 'with', 'five', 'hundred',
'other', 'persons', 'and', 'more,', 'did,', 'unlawfully,', 'riotously,',
'and', 'tumultuously', 'assemble', 'on', 'the', '6th', 'of', 'June', 'to',
'the', 'disturbance', 'of', 'the', 'public', 'peace', 'and', 'did', 'begin',
'to', 'demolish', 'and', 'pull', 'down', 'the', 'dwelling', 'house', 'of',
'\xc2\xa0', 'Richard', 'Akerman', ',', 'against', 'the', 'form', 'of',
'the', 'statute,', '&amp;c.', '\xc2\xa0', 'ROSE', 'JENNINGS', ',', 'Esq.',
'sworn.', 'Had', 'you', 'any', 'occasion', 'to', 'be', 'in', 'this', 'part',
'of', 'the', 'town,', 'on', 'the', '6th', 'of', 'June', 'in', 'the',
'evening?', '-', 'I', 'dined', 'with', 'my', 'brother', 'who', 'lives',
'opposite', 'Mr.', "Akerman's", 'house.', 'They', 'attacked', 'Mr.',
"Akerman's", 'house', 'precisely', 'at', 'seven', "o'clock;", 'they',
'were', 'preceded', 'by', 'a', 'man', 'better', 'dressed', 'than', 'the',
'rest,', 'who']
```

Pour le moment, disposer d'une liste ne vous avance pas à grand à chose. En tant qu'être humain, vous avez la capacité de lire le texte intial. Cependant ce format, comme nous le verrons dans les prochaines leçons, est plus adapté pour l'automatisation d'un traitement sur des textes.

## Lectures suggérées

- Lutz, Mark. Learning Python (5th edition). O'Reilly Media, Inc., 2013.
    -   Ch. 7: Strings
    -   Ch. 8: Lists and Dictionaries
    -   Ch. 10: Introducing Python Statements
    -   Ch. 15: Function Basics

# Synchronisation du code

Pour suivre les leçons à venir, il est important que vous ayez les bons fichiers et programmes dans votre répertoire ```programming-historian```. À la fin de chaque chapitre, vous pouvez télécharger le fichier zip contenant le matériel de cours afin de vous assurer une version mise à jour du code.

-   python-lessons3.zip ([zip sync](https://programminghistorian.org/assets/python-lessons3.zip))
