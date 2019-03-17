---
title: Travailler avec des fichiers texte en Python
layout: lesson
date: 2012-07-17
authors:
- William J. Turkel
- Adam Crymble
reviewers:
- Jim Clifford
editors:
- Miriam Posner
translator:
- Sylvain Machefert
translation-editor:
- Sofia Papastamkou
translation-reviewers:
- Alix Chagué
- François Dominic Laramée
translation_date: 2018-01-26
difficulty: 2
exclude_from_check: review-ticket
activity: transforming
topics: [python]
abstract: "Cette leçon vous expliquera comment manipuler des fichiers texte en Python."
python_warning: true
original: en/lessons/working-with-text-files 

---

{% include toc.html %}


## Objectifs de la leçon

Au cours de cette leçon, vous apprendrez à manipuler des fichiers texte
en Python : ouvrir, fermer, lire et écrire des fichiers `.txt` à l'aide de
programmes informatiques.

Les prochaines leçons de cette série auront pour objectif de télécharger une
page web avant de réorganiser le contenu sous forme d'information exploitable
de manière automatique. La plupart des opérations se feront à l'aide de code
Python exécute depuis Komodo Edit.

## Travailler avec des fichiers texte

Python propose des solutions simples pour travailler avec les fichiers et le texte.
Commençons par les fichiers.

## Créer et écrire dans un fichier texte

Commençons par une petite explication de terminologie. Lors d'une leçon précédente
(selon votre système d'exploitation : [Mac Installation][], [Windows
Installation][] ou [Linux Installation][]), vous avez appris comment envoyer des
informations dans la fenêtre "Command Output" de votre éditeur de texte en
utilisation la commande Python [print][].

``` python
print('hello world')
```

Le langage de programmation Python est un langage *orienté objet*. Cela signifie
qu'il est construit autour d'un concept particulier : l'*objet*, qui contient à
la fois les *données* et les *méthodes* permettant d'accéder à ces données et
de les modifier. Dès lors qu'un objet est créé, il peut interagir avec d'autres
objets.

Dans l'exemple ci-dessus, nous voyons un type d'objet, la chaîne de caractères
(*string*) "hello world". Cette chaîne est une suite de caractères délimités par
des guillemets. Vous pouvez définir une chaîne de caractères de trois manières :

```
message1 = 'hello world'
message2 = "hello world"
message3 = """hello
hello
hello world"""
```

On retiendra qu'il est possible d'utiliser des apostrophes ou des guillemets
pour définir la chaîne. Il n'est par contre pas possible de mixer les deux dans
la déclaration d'une chaîne de caractères.

Les déclarations suivantes ne fonctionneront pas :

```
message4 = "hello world'
message5 = 'hello world"
message6 = 'I can't eat pickles'
```

Comptez le nombre d'apostrophes dans le message6. Pour que cet exemple fonctionne,
il est nécessaire d'*échapper* (escape) l'apostrophe :

``` python
message6 = 'I can\'t eat pickles'
```

Ou réécrire la ligne sous la forme suivante :

``` python
message6 = "I can't eat pickles"
```

Dans le message3 plus haut, les triples guillemets signifient que la chaîne
se poursuit sur plusieurs lignes.

`Print` est une commande qui affiche l'objet sous forme textuel. La commande
print, combinée à la chaîne de caractère correspond à une *instruction*.

On utilise la commande `print` de cette manière lorsque l'on a besoin
d'une information en direct. Il sera cependant parfois nécessaire de créer
des informations que l'on souhaitera enregistrer, envoyer à quelqu'un, ou qu'on
voudra traiter à l'aide d'un autre programme. Pour cela, il sera préférable
d'envoyer l'information vers un fichier du disque dur plutôt que dans la
fenêtre "Command output". Afin de comprendre comment cela fonctionne, entrez
le code suivant dans votre éditeur de texte et sauvegardez le fichier sous le
nom `file-output.py`.

``` python
# file-output.py
f = open('helloworld.txt','w')
f.write('hello world')
f.close()
```

En python, une ligne qui commence par le signe dièse (\#) est considérée
comme un *commentaire* et est ignorée par l'interpréteur de code. Les
commentaires sont prévus pour que le développeur puisse laisser des messages
à destination d'autres développeurs qui repredraient son code (ou pour se
souvenir de ce que fait le code lorsqu'ils le reprendront quelques mois ou
années plus tard). De manière générale, les programmes sont écrits d'une
manière qui permet aux développeurs de se comprendre le plus facilement
possible lors de la reprise de code ou de travail à plusieurs sur le même
outil. Quand du code est très proche des instructions que comprend le
processeur de la machine, on parle de langage de *bas niveau*, alors que du
code proche du langage naturel est considéré comme de *haut niveau*. Un des
avantages de Python est que c'est un langage de très haut niveau, et qu'il
est ainsi plus facile de comprendre le but des programmes décrits dans ces
leçons (avec un coût en terme d'efficacité, puisque l'ordinateur aura besoin
d'un travail d'analyse plus complexe qu'avec des langages de bas niveau).

Dans le programme ci-dessus, *f* est un *file object* (objet de type fichier)
et `open`, `write` et `close` sont des *file methods* (méthodes sur fichier).
En d'autres termes, open, write et close agissent sur l'objet *f* qui dans le
cas présent est défini comme un fichier '.txt'. Ce n'est pas forcément
l'usage habituel du terme méthode, et de temps en temps vous noterez que des
termes ont, dans le contexte de la programmation, un sens différent du sens
communément admis. Dans la situation, retenez simplement que les méthodes
sont des morceaux de code qui vont réaliser des actions définies avant de
retourner un résultat. Vous pouvez imaginer cela en transposant le principe
à un exemple concret : le chien. Le chien (objet) comprend des commandes (
dispose de "méthodes") telles que "aboyer", "s'assoir", "faire le mort", etc.
D'autres méthodes prédéfinies seront présentées par la suite.

*f* est un nom de variable que nous avons choisi mais nous aurions pu choisir
(quasiment) n'importe quelle chaîne de caractère. En Python, les noms de
variables sont constitués de lettres majuscules, minuscules, chiffres et
underscores. Une des seules limites est qu'il est interdit d'utiliser le
nom des commandes de base de Python comme nom de variables : si vous
essayez par exemple de nommer une variable "print", votre programme ne
s'exécutera pas car c'est un [mot réservé][] par le langage.

Les noms de variable en python sont *sensibles à la casse*, c'est à dire que
toto, Toto et TOTO seront trois variables différentes.

Lorsque vous lancez le programme ci-dessus, la méthode `open` indique
à votre ordinateur de créer un nouveau fichier `helloworld.txt` dans le
répertoire où se trouve `file-output.py`. Le *paramètre w* spécifie que le
fichier ouvert est destiné à l'écriture (***w***rite) de contenus par Python.

On notera que le nom de fichier et le paramètre sont entourés de guillemets,
et qu'ils sont donc stockés tous les deux sous la forme de chaîne de caractères.
Si l'on oublie ces guillemets le programme ne fonctionnera pas.

À la ligne suivante, votre programme écrit le message "hello world" (une autre
chaîne de caractères) dans le fichier puis ferme ce dernier. (Pour plus
d'informations sur ces opérations, consultez la section [File Objects][] de
la documentation de la bibliothèque standard Python).

Double-cliquez sur le bouton "Run Python" dans Komodo Edit pour exécuter
le programme (ou la fonctionnalité équivalente disponible dans votre éditeur,
par exemple "\#!" et "Run" dans TextWrangler). Bien que rien ne s'affiche dans
la fenêtre "Command Output", vous verrez un message de statut qui indique
quelque chose du type :

``` python
`/usr/bin/python file-output.py` returned 0.
```

sur Mac et Linux, ou

``` python
'C:\Python27\Python.exe file-output.py' returned 0.
```

sur Windows.

Cela signifie que le déroulement du programme s'est effectué avec
succès. Si vous allez dans le menu *File -> Open -> File*, vous pourrez
ouvrir le fichier `helloworld.txt`. Il devrait contenir la ligne
suivante :

```
Hello World!
```

Étant donné que les fichiers texte n'incluent que peu (voire pas)
d'indications de formatage, ils ont tendance à rester léger et faciles
à échanger entre différentes plateformes (par exemple de Windows à Linux
ou Mac, et vice versa), et facile à transférer entre ordinateurs. Ils
peuvent en règle générale par toute personne possédant un éditeur de
texte (y-compris un éditeur ultra-basique du type "bloc notes").


### Lire depuis un fichier texte

Python dispose aussi d'une méthode qui permet de récupérer l'information
contenue dans des fichiers. Copiez le programme suivant dans votre éditeur
et enregistrez le sous `file-input.py`. Lorsque vous cliquez sur "Run" pour
l'exécuter, il va lire le fichier que l'on a créé à l'étape précédent, lire
la ligne qu'il contient et l'afficher dans la fenête "Command Output".

``` python
# file-input.py
f = open('helloworld.txt','r')
message = f.read()
print(message)
f.close()
```

Cette fois, le paramètre *r* est utilisé pour indiquer que le fichier
est ouvert en lecture (***r***ead). Les paramètres vous permettent de
spécifier différentes options comprises par la méthode. Si l'on revient
à l'exemple du chien cite précédemment, celui-ci pourrait être dressé à
aboyer une fois lorsqu'on lui donne un snack au boeuf, et deux-fois pour
snack au poulet. Le goût du snack est un paramètre. Chaque méthode diffère
sur le plan des paramètres possibles. Il ne sera ainsi pas possible de
demander au chien d'aboyer un opéra italien (à moins que votre chien soit
très talentueux). Le site web de Python vous permet de prendre connaissance
des paramètres disponibles pour les principales commandes, et une recherche
dans un moteur de recherche de la commande accompagnée du terme Python vous
permettra souvent de retrouver ces informations.

`Read` est une autre méthode. Le contenu du fichier (le message Hello world)
est copié dans la variable *message*, puis la commande `print` va afficher
le contenu de *message* dans la fenêtre "Command Output".

### Ajouter du contenu à un fichier texte existant

Une troisième option est d'ouvrir un fichier pré-existant pour y ajouter
du contenu. Attention, si vous ouvrez un fichier en écriture (w) et que ce
fichier existe, si vous utilisez la méthode `write`, le contenu précédent
sera écrasé. Si vous souhaitez ajouter de nouveaux contenus à un fichier,
on ouvrira plutôt le fichier en ajout avec le paramètre `a` (***a***ppend).

Copiez le programme suivant dans votre éditeur
et enregistrez le sous `file-append.py`. Lorsque vous cliquez sur "Run" pour
l'exécuter. Ce programme va ouvrir le fichier précédemment créé et y ajouter
une seconde ligne "hello world". Le code '\\n' correspond à un retour à la
ligne.

``` python
# file-append.py
f = open('helloworld.txt','a')
f.write('\n' + 'hello world')
f.close()
```

Après avoir exécuté le programme, ouvrez le fichier `helloworld.txt` et
regardez ce qui s'est passé. Fermez alors le fichier puis exécutez à nouveau
`file-append.py` quelques fois. Si vous ouvrez le fichier `helloworld.txt`
vous verrez que plusieurs lignes contenant le message 'hello world' sont
apparus.

Dans la prochaine section, nous aborderons la modularité et la réutilisation
du code.

Lectures recommandées
---------------------

-   [Non-Programmer’s Tutorial for Python 2.6/Hello, World][]

  [Mac Installation]: /lessons/mac-installation
  [Windows Installation]: /lessons/windows-installation
  [Linux Installation]: /lessons/linux-installation
  [print]: https://docs.python.org/2/reference/simple_stmts.html#the-print-statement
  [mot réservé]: http://docs.python.org/release/2.5.4/ref/keywords.html
  [File Objects]: https://docs.python.org/2/library/stdtypes.html#bltin-file-objects
  [Non-Programmer’s Tutorial for Python 2.6/Hello, World]: http://en.wikibooks.org/wiki/Non-Programmer%27s_Tutorial_for_Python_2.6/Hello,_World
