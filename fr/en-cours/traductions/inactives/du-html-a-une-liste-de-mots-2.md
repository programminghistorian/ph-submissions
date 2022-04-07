---
title: Du Html à une liste de mots (partie 2)
layout: lesson
slug: du-html-a-une-liste-de-mots-2
date: 2012-07-17
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
translation_date: 2021-10-01 
translation-editor:
translation-reviewer:
difficulty: 2
original: from-html-to-list-of-words-2
review-ticket:
activity: transforming
topics: [python]
abstract: 
categories: [lessons, python, original-ph]
python_warning: false
avatar_alt: Un homme qui imite une girafe
doi:
---

{% include toc.html %}

# Objectifs de la leçon 

Dans cette leçon, nous allons finaliser l'algorithme que nous avons commencé lors du tutoriel précédant : [Du Html à une liste de mots (partie 1)]()
La première moitié de celui-ci charge le contenu d'une page HTML et ne sauvegarde que le contenu présent entre la première balise `<p>` et la dernière balise `<br/>`. La seconde moitié de celui-ci réalise la procédure suivante :

-   Inspecter chaque caractères présents dans la chaîne *contenuPage* 
-   Si le caractère à gauche est un crochet ouvrant, nous sommes alors à l'intérieur d'une balise et nous ignorons donc les caractères suivants
-   Si le caractère est un crochet fermant (\>) cela signifie que nous ressortons de la balise; nous ignorons donc le caractère courant et inspectons alors avec attention les suivant
-   Si nous ne sommes pas dans une balise, nous ajoutons alors le caractère courant à un variable appelée *texte*
-   Nous découpons ensuite la chaîne de caractères *texte* en une liste de mots individuels que nous manipulerons par la suite.

## Fichiers nécessaires au suivi de la leçon

-   *obo.py*
-   *trial-content.py*

Si vous n'avez pas déjà ces fichiers, vous pouvez télécharger le fichier python-lessons2.zip issu de la leçon précédente.

# Boucles et tests conditionnels en Python

La prochaine étape dans l'implémentation de l'algorithme sera maintenant d'inspecter chaque caractères de la chaîne *contenuPage* un à un et de tester si le caractère courant est un marqueur HTML ou le contenu de la transcription du procès. Mais avant cela nous allons apprendre quelques techniques nous permettant de répéter une tache ou bien de tester si une condition est remplie.

## Les boucles


Comme de nombreux autres langages, Python propose plusieurs moyens de réaliser des *boucles*. La plus adaptée à notre problématique est ici la *boucle for*. Cette instruction permet de demander à l'interpréteur de réaliser un tâche sur chaque caractère de la chaîne *contenuPage*. Une variable *caract* contiendra alors le caractère courant de la chaîne *contenuPage* que nous parcourons. Nous avons ici nommé cette variable *caract*; mais cela n'a pas d'importance particulière dans le fonctionnement du programme car nous aurions pu la nommer *clochette* ou bien encore *k* si cela nous le disait. Cependant certains noms ne sont pas mobilisables, car déjà attribués à une fonction Python déjà définie (comme par exemple *for*), pour vérifier si cela est le cas vous pouvez utiliser la fonction de coloration de texte de Komodo Edit afin de savoir si cela un nom de variable est disponible au nommage (comme ici *caract*). Il est évidemment plus astucieux de donner aux variables des noms qui nous informes sur leurs contenus. Il sera ainsi plus simple de revenir sur un programme plus tard. Avec cela en tête, on comprends donc facilement que nommer sa variable '*clochette*' n'est pas forcement le meilleurs choix de nom de variable.


``` python
for caract in contenuPage:
    # faire quelque chose avec le caractère courant (caract)
```

## Les instructions conditionnelles

Nous avons maintenant besoin d'un mécanisme de contrôle concernant le contenu de notre chaîne de caractères. Encore une fois, comme d'autres langages de programmation, Python propose différents moyens de réaliser des *tests conditionnels*. Celui dont nous avons besoin est l'instruction conditionnelle *if*. Le code ci-dessous utilise celle-ci pour vérifier si la chaîne de caractères nommée *caract* est égale à un crochet ouvrant. Comme nous l'avons déjà mentionné, Python n'exécutera le code contenu dans ce block que si la condition est vraie.

Notez que la syntaxe Python privilégie l'utilisation du signe égal (=) pour réaliser des *affectations*, ce qui permet de donner une valeur à une variable. Pour tester une *égalité*, il faudra alors user du doubler signe égal (==). Les programmeurs débutant ont souvent tendance à confondre ces deux utilisations. 


``` python
if caract == '<':
    # faire quelque chose
```
Une forme plus générale de *l'instruction si* permet de spécifier ce que nous souhaitant faire si l'instruction est fausse.

``` python
if caract == '<':
    # faire quelque chose
else:
    # faire quelque chose d'autre
```
Python laisse aussi la possibilité de vérifier d'autres conditions après la première instruction, et ceci en utilisant *l'instruction elif* (qui est une contraction de 'else if').

``` python
if caract == '<':
    # do something
elif caract == '>':
    # do another thing
else:
    # do something completely different
```

# Utiliser l'algorithme  pour supprimer le balisage HTML

Vous en savez maintenant suffisamment pour implémenter la seconde partie de l'algorithme qui consiste à supprimer toute les balises HTML. Dans cette partie nous souhaitons :

-   Inspecter chaque caractère de la chaîne *contenuPage* un à un
-   Si le caractère courant est une balise ouvrante (\<) cela signifie que nous entrons dans une balise et qui faille ignorer ce caractère et les suivants
-   Si le caractère courant est une balise fermante (\>), cela signifie que nous ressortons de la balise et qui faille ignorer ce caractère seulement
-   Si nous ne sommes pas dans une balise, nous ajouterons donc le caractère courant à une nouvelle variable : *texte*.

Pour réaliser cela, nous allons utiliser une *boucle for* qui vous permettra d'inspecter de manière itérative chaque caractère de la chaîne. Vous utiliserez une suite d'instruction conditionnelle (*if* / *elif*) pour déterminer si le caractère courant est inclus dans une balise ou s'il fait parti du contenu, nous ajouterons alors le texte du contenu dans la chaîne de caractère *texte*. Cependant comment pourrions nous gardez en mémoire le fait que nous soyons ou non au sein d'une balise ? Nous utiliserons à ce titre un variable de type entier, qui vaudra 1 (vrai) si nous sommes dans une balise et qui vaudra 0 (faux) si ce n'est pas le cas (dans l'exemple plus bas nous avons appelé cette variable *dedans*).

## La fonction de suppression de balises 

Assemblons maintenant ce que nous avons pu apprendre et projeter jusque là tout ensemble, la version finale de la fonction *supprimerBalises* nous permettant d'atteindre notre objectif est décrite plus bas. Faites encore une fois bien attention à l'indentation de manière à ce qu'elle soit bien équivalente à ce qui est illustré ci-dessous lorsque vous remplacerez l'ancienne fonction *supprimerBalises* dans *obo.py* avec la nouvelle.

Si vous avez tenté de construire votre fonction vous même, il est tout à fait normal qu'elle puisse être différente que celle que nous vous présentons. Il existe souvent plusieurs moyens d'arriver à la même fin, l'essentiel est pour le moment que cela réalise bien l'objectif que nous nous entions fixé. Cependant à titre de vérification nous vous conseillons de vérifier que votre fonction nous renvoies bien le même résultat que la notre.

``` python
# obo.py
def supprimerBalises(contenuPage):
    contenuPage = str(contenuPage)
    locDebut = contenuPage.find("<p>")
    locFin = contenuPage.rfind("<br/>")

    contenuPage = contenuPage[locDebut:locFin]

    dedans = 0
    texte = ''

    for caract in contenuPage:
        if caract == '<':
            dedans = 1
        elif (dedans == 1 and caract == '>'):
            dedans = 0
        elif dedans == 1:
            continue
        else:
            texte += caract

    return texte
```

Nous ici face à deux nouveaux concepts Python : *continue* et *return*.

L'instruction Python *continue* demande à l'interpréteur de boucler repartir au sommet de la boucle. Quand nous arrivons à un caractère inclus au sein d'une balise HTML, nous pouvons par ce moyen passer directement au prochain caractère sans avoir à ajouter celui-ci à la variable *texte*.

Dans notre exemple précédant nous avons amplement usé de la fonction *print*. Elle permet d'afficher à l'écran le résultat d'un programme pour qu'il puisse être lu par l'utilisateur. Cependant, et dans la majorité des cas, nous souhaitons simplement faire parvenir une information d'une partie d'une partie d'un programme à une autre. A ce titre quand l'exécution d'une fonction se termine, elle renvoies une valeur au code qui l'a appelé via l'instruction *return*. Si nous souhaitons appeler la fonction *supprimerBalises* dans un autre programme voici maintenant devons nous y prendre :


``` python
# Pour comprendre comment fonctionne l'instruction return

import obo

monTexte = "Ceci est un message <h1>HTML</h1>"

leResultat = obo.supprimerBalises(monTexte)
```

En utilisant l'instruction *return*, nous sommes alors capable de sauvegarder la sortie de la fonction *supprimerBalises* directement dans une variable appelé '*leResultat*', que nous pourront ensuite investir si besoin par la suite.

Vous remarquerez que le contenu retourné par l'exemple d'utilisation de  *supprimerBalises* ci-dessus ne renvois pas le contenu de *monTexte* mais bien le contenu sans balise HTML.

Pour tester notre nouvelle fonction *supprimerBalises*, vous pouvez relancer *trial-content.py*. Depuis que nous avons redéfini *supprimerBalises*, le programme *trial-content.py* réalise maintenant autre chose (un autre chose plus proche de ce que l'on souhaite obtenir). Avant de continuer, vérifiez que vous avez bien compris pourquoi le comportement de *trial-content.py* change lorsque l'on édite *obo.py*.

# Les listes Python 

Maintenant que nous avons la possibilité d'extraire le texte d'une page web, nous devons maintenant transformer ce texte de manière à ce qu'il soit plus facile à traiter. Jusqu'à présent, quand vous aviez besoin de stocker de l'information dans un programme Python, nous avons généralement choisi de le faire au format chaîne de caractère. Mais cela n'a pas été toujours le cas, comme par exemple dans la fonction *supprimerBalises*, où nous avons utilisé le format *entier* (Integer) pour stocker 1 quand nous entions au sein d'une balise et 0 lorsque ce n'était pas le cas. Avec les entier vous pouvez réaliser des opérations mathématiques mais il n'est pas possible d'y stocker des fractions et des nombres décimaux.

``` python
dedans = 1
```
De plus, sans le savoir, à chaque fois que vous avez eu besoin de lire ou d'écrire dans un fichier, vous avez utilisé un objet de type fichier spécifique comme *f* dans l'exemple ci-dessous.

``` python
f = open('helloworld.txt','w')
f.write('hello world')
f.close()
```
Un autre type d'objet proposé par Python est cependant aussi très utile, il s'agit des *listes*, qui sont des collections ordonnées d'autres objets (pouvant inclure potentiellement des listes). Convertir une chaîne de caractères en liste de caractères ou de mots est assez simple. Copiez ou tapez le programme suivant dans votre éditeur de texte pour comprendre les deux moyens de réaliser cette opération. Sauvegardez le fichier en le nommant *chaine-en-liste.py* et exécutez-le. Comparez ensuite les deux listes obtenues dans la sortie de la commande et à la vue de ces résultats essayez de comprendre comment fonctionne ce bout de code.

``` python
# chaine-en-liste.py

# deux chaine de caractères
s1 = 'hello world'
s2 = 'bonjour le monde'

# liste de 'caractères'
caractlist = []
for caract in s1:
    caractlist.append(caract)
print(caractlist)

# liste de 'mots'
liste_mots = s2.split()
print(liste_mots)
```

La première routine utilise une boucle for pour parcourir chaque caractères de la chaîne *s1*, elle ajoute ainsi chaque caractère à la fin de *caractlist*. 

La seconde routine utilise une opération de découpage (*split*) pour briser la chaîne *s2* où se trouve des blancs (espaces, tabulations, retour charriot et autres caractères similaires). 

 Pour le moment nous avons simplifié un peu les choses concernant la procédure utilisée pour le découpage de la chaîne en liste de mots. Modifiez la chaîne *s2* utilisé dans le programme et donnez lui la valeur ‘salut le monde!’ puis relancer le programme. Qu'est-il arrivé au point d'exclamation ? Notez, que vous devez sauvegardez le fichier et ces modifications avant de pouvoir le relancer tel quel avec Python.

Comptes tenu de vos nouvelles connaissances, ouvrez maintenant l'URL, téléchargez la page web, sauvegardez son contenu dans une chaîne de caractères et comme nous l'avons vu à l'instant découpez celle-ci en une liste de mots. Exécutez alors le programme suivant. 

``` python
#html-to-list1.py
import urllib.request, urllib.error, urllib.parse, obo

url = 'http://www.oldbaileyonline.org/print.jsp?div=t17800628-33'

response = urllib.request.urlopen(url)
html = response.read()
texte = obo.supprimerBalises(html)
liste_mots = texte.split()

print((liste_mots[0:120]))
```
Vous devirez obtenir quelques chose ressemblant à cela :

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

Pour le moment, disposer d'une liste ne vous avance pas à grand à chose. En tant qu'être humain vous avez la capacité de lire ce texte, mais cette représentation comme vous le verrez dans les prochaines leçon est très utile pour traiter des textes avec des programmes.

## Lectures suggérées

-   Lutz, *Learning Python*
    -   Ch. 7: Strings
    -   Ch. 8: Lists and Dictionaries
    -   Ch. 10: Introducing Python Statements
    -   Ch. 15: Function Basics

# Synchronisation du code

Pour suivre les leçons à venir, il est important que vous ayez les bons fichiers et programmes dans votre répertoire ```programming-historian```. A la fin de chaque chapitre, vous pouvez télécharger le fichier zip contenant le matériel de cours du the programming-historian afin de vous assurer d'avoir le bon code.

-   python-lessons3.zip ([zip sync][])

  [From HTML to a List of Words (part 1)]: /lessons/from-html-to-list-of-words-1
  [integer]: http://docs.python.org/2.4/lib/typesnumeric.html
  [types]: http://docs.python.org/3/library/types.html
  [zip]: /assets/python-lessons2.zip
  [zip sync]: /assets/python-lessons3.zip
