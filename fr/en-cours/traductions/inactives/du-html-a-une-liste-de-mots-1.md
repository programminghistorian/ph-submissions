---
title: "Du Html à une liste de mots"
slug: du-html-a-une-liste-de-mots-1
original: from-html-to-list-of-words-1
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
- Forename Surname
translation-reviewers:
- Forename Surname
- Forename Surname
difficulty: 2
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/560
activity: transforming
topics: [python]
abstract: "Dans cette leçon en deux parties, nous allons partir de ce que nous avons pu apprendre avec la leçon Télécharger des pages web avec Python, et voir comment supprimer les balises HTML de la page de la transcription du procès verbal de Benjamin Bowsey’s 1780. Nous réaliserons cette tâche en tirant parti d'opérateur de chaînes, de méthode de chaînes et de compétences en lecture de près. Nous introduirons ensuite les concepts de boucles et d'instructions conditionnelles afin de répéter notre processus de traitement et de tester certaines conditions nous permettant de séparer le contenus des balises HTML. Pour finir, nous convertirons les données obtenues et enregistrées sous la forme de texte long en une liste de mots qui pourra par la suite être triée, indexée et servir pour des comptages."
categories: [python]
avatar_alt: Un homme qui imite une girafe
doi: TBC
---

{% include toc.html %}

# Objectifs de la leçon 

Dans cette leçon en deux parties, nous allons partir de ce que nous avons pu apprendre avec la leçon [Télécharger des pages web avec Python](/fr/lecons/telecharger-des-pages-web-avec-python), et voir comment supprimer les *balises HTML* de la page de la [transcription du procès verbal de Benjamin Bowsey’s 1780](http://www.oldbaileyonline.org/browse.jsp?id=t17800628-33÷=t17800628-33). Nous réaliserons cette tâche en tirant parti *d'opérateur de chaînes*, *de méthode de chaînes* et de compétences en *lecture de près*. Nous introduirons ensuite les concepts de *boucles* et *d'instructions conditionnelles* afin de répéter notre processus de traitement et de tester certaines conditions nous permettant de séparer le contenus des balises HTML. Pour finir, nous convertirons les données obtenues et enregistrées sous la forme de *texte long* en une *liste de mots* qui pourra par la suite être triée, indexée et servir pour des comptages.

# Le défi

Pour rendre plus clair l'objectif de la séance, ouvrez le fichier ```obo-t17800628-33.html``` que vous avez créé lors de la leçon [Télécharger des pages web avec Python](/fr/lecons/telecharger-des-pages-web-avec-python) ( [téléchargez et ouvrez le fichier](https://programminghistorian.org/assets/obo-t17800628-33.html) si ce n'est pas le cas ),  inspectez ensuite le code HTML de celui-ci en cliquant sur ```Tools -> Web Developer -> Page Source``` . Vous remarquerez lors du parcours de ce fichier que celui-ci est composé de balises HTML mélangées avec du texte. Si vous êtes néophytes en matière de HTML, nous vous recommandons de consulter [les tutoriels de la W3 School](https://www.w3schools.com/html/) pour vous familiariser avec la grammaire de ce format. Si votre travail vous demande de supprimer régulièrement des balises  HTML, cela vous permettra de comprendre à quoi celles-ci correspondent lorsque vous les rencontrerez.

## Fichiers nécessaires au suivi de la leçon

- *[obo-t17800628-33.html](https://programminghistorian.org/assets/obo-t17800628-33.html)*

# Conception de l'algorithme

Puisque le but est de se débarrasser du HTML, la  première étape de ce tutoriel est donc de créer un algorithme nous  permettant d'extraire seulement le texte de cet article (sans balises HTML). Un algorithme est une procédure qui est spécifiée avec suffisamment de détail pour être implémentée sur un ordinateur. Lors de la conception d'un algorithme, il est conseillé dans un premier temps, de poser sur le papier son fonctionement, c'est un moyen qui permet d'expliciter ce que l'on souhaite faire avant de traduire cela en un code informatique. Pour construire cet algorithme, une lecture attentive de la page et de sa structure sera notamment nécessaire afin de pouvoir envisager par la  suite un moyen de capturer le contenu de la biographie.

À la lecture du code source de ```obo-t17800628-33.html``` vous remarquerez que le contenu des transcriptions n'est pas visible dès le début du fichier. Au lieu de cela, vous trouverez pléthore de balises HTML ainsi que des informations liées à des citations. Ainsi ce qui nous intéresse n'est effet visible qu'à partir de la ligne 81 !

```html
<p>324.                                  <a class="invisible" name="t17800628-33-defend448"> </a>                     BENJAMIN                      BOWSEY                                                                                                          (a blackmoor                  ) was indicted for                                                          that he together with five hundred other persons and more, did, unlawfully, riotously, and tumultuously assemble on the 6th of June
```

Nous nous intéressons uniquement aux transcriptions, et non pas aux méta-données contenues dans les balises. De plus, vous remarquerez que la fin de ces méta-données correspond au début des transcriptions. L'emplacement de ces méta-données est donc potentiellement un indice utile nous permettant d'isoler le texte des transcriptions.

En un coup d'œil, vous remarquerez que la transcription du procès commence avec une balise HTML : ```<p>```, qui marque ici le début d'un paragraphe. Il s'agit de là du premier paragraphe de notre document. Nous allons donc utiliser cette information pour identifier le début du texte de la transcription. Nous sommes dans notre cas plutôt chanceux, car il s'avère que cette  balise est un moyen fiable nous permettant de repérer le début de la transcription d'un procès (en guise de vérification, vérifier que cela est bien le cas des procès suivant).

Le texte du procès se termine à la ligne 82 avec une autre balise HTML :  ```<br/>```, qui indique un passage à la ligne. Il s'agit ici du DERNIER passage à la ligne du document. Ces deux balises (balise de début de paragraphe et le dernier saut de ligne) nous offrent un moyen d'isoler le texte que nous ciblons. Les sites web bien conçus ont la plupart du temps une syntaxe unique permettant de signaler la fin d'un contenu. Il est donc souvent question de pouvoir repérer ces indices.

La prochaine étape sera donc de supprimer les balises HTML contenues au sein du contenu textuel. Maintenant, que vous savez que les balises HTML sont toujours contenues dans une paire de crochets, nous avons fort à parier que si nous  supprimons tout ce qui est contenus entre crochets, alors nous  supprimerons par la même occasion tout ce qui est attribué à la  grammaire HTML afin de n'obtenir que le contenu de nos transcriptions. Notez que nous faisons ici l'hypothèse que celles-ci ne contiennent pas de symboles mathématiques tels que "inférieur à" ou "supérieur à". Si Bowsey était un mathématicien, cette hypothèse serait alors plus fragile.

Nous allons maintenant décrire la procédure de notre algorithme explicitement en français :

Pour isoler le contenu :

- Charger le texte des transcriptions
- Chercher dans le code HTML et mémoriser l'emplacement de la première balise```<p>```
- Chercher dans le code HTML et mémoriser l'emplacement de la  dernière balise ```</br>```
- Sauvegarder dans une variable de type *chaîne de caractères* nommée *pageContents* tout ce qui se situe entre la balise  ```<p>``` et ```</br>```.

Nous avons maintenant la transcription du texte, avec en plus des balises HTML. Nous allons donc :
- Inspecter un à un chaque caractère de la chaine *pageContents* 
- Si le caractère passé en revue est un crochet ouvrant  (<) nous sommes donc à partir de celui au sein d'une balise HTML, nous allons donc ignorer les prochains caractères.
- Si le caractère passé en revue est un crochet fermant, (>) nous ressortons donc d'une balise HTML, nous ignorerons donc ce caractère, mais serons à partir de celui-ci attentifs aux prochains.
- Si nous ne sommes pas à l'intérieur d'une balise HTML, nous ajouterons alors le caractère courant dans une nouvelle variable : *text*

Enfin:
- Nous découperons notre chaîne de caractères en une liste de mots que nous investirons ensuite.

# Isoler le contenu d'intérêt

La suite de ce tutoriel tirera parti des commandes Python introduites dans la leçon  [[Manipuler des chaînes de caractères en Python](https://programminghistorian.org/fr/lecons/manipuler-chaines-caracteres-python) notamment dans la première partie de notre algorithme : afin de supprimer tous les caractères avant la balise```<p>``` et après la balise ```</br>```.

Récapitulons, notre algorithme réalisera donc :
- Le chargement du texte de la transcription
- Cherchera dans le code HTML la location de la première balise```<p>``` et enregistrera sa position
- Cherchera dans le code HTML la location de la dernière balise ```</br>``` et enregistrera sa position
- Sauvegardera tout ce qui se situe après la balise ```<p>``` et avant la balise ```</br>``` dans une *chaîne de caractères* : *pageContents*

Pour réaliser cela, nous utiliserons la *méthode de chaîne de caractères* ```find``` ainsi que la méthode ```.rfind()``` (qui renvois la dernière position dans une chaîne d'un caractère donné) et nous créerons grace à celà une sous-chaîne de caractères contenant le contenu textuel compris entre les deux indices renvoyés par ces méthodes.

Au fur et à mesure de l'implémentation, nous prendrons soin de bien séparer nos fichier de travail. Nous appelerons  ```obo.py``` (for “Old Bailey Online”) le fichier dans lequel nous inscrirons le code que nous souhaiterons par la suite réuitiliser;  ```obo.py``` sera alors un module. Nous avons discuté la notion de module dans le tutoriel [Code Reuse and Modularity](https://programminghistorian.org/lessons/code-reuse-and-modularity) durant lequel nous avions enregistré nos fonctions dans un fichier nommé ```greet.py```.

Créez donc un nouveau fichier nommé ```obo.py``` et sauvegardez le dans votre répertoire ```programming-historian```. Nous utiliserons ce fichier pour faire appel aux fonctions dont nous aurons besoin durant le traitement de The Old Bailey Online. Saisissez ou copiez à ce titre le code suivant de votre fichier.

```python
# obo.py

def stripTags(pageContents):
    pageContents = str(pageContents)
    startLoc = pageContents.find("<p>")
    endLoc = pageContents.rfind("<br/>")

    pageContents = pageContents[startLoc:endLoc]
    return pageContents
```

Créez ensuite un nouveau fichier :  ```trial-content.py```, dans lequel vous copierez par la suite le code suivant :

```python
# trial-content.py

import urllib.request, urllib.error, urllib.parse, obo

url = 'http://www.oldbaileyonline.org/browse.jsp?id=t17800628-33&div=t17800628-33'

response = urllib.request.urlopen(url)
HTML = response.read()

print((obo.stripTags(HTML)))
```

Lorsque vous lancez ```trial-content.py```,  cela ira dans un premier temps rechercher le contenu de la page web de la transcription du procès de Bowsey, puis cela ira rechercher dans le module ```obo.py```  la fonction ```stripTags``` . Le programme utilisera cette fonction pour extraire le contenu compris entre la première balise```<p>``` et la dernière balise ```</br>```.  Si tout est bon cela nous renverra bien le contenu de la transcription de Bowsey, avec comme nous le prévoyons quelques balises HTML.  Il se peut que vous obteniez en réponse une épaisse ligne noire dans votre sortie de commande, mais ne vous inquiétiez pas. La sortie de l'éditeur de texte Komodo Edit est limité à un nombre maximum de caractères qu'il est possible d'afficher, après lequel les caractères s'écriront littéralement les uns sur les autres à l'écran, donnant l'apparence d'une tache noire. Pas de panique, le texte est dans ce cas bien ici, mais vous ne pouvez pas le lire; afin de résoudre ce problème d'affichage, vous pouvez copier/coller ce texte dans un nouveau fichier à titre de vérification.

Prenons maintenant un moment pour être sur que vous ayez bien compris comment fonctionne  ```trial-contents.py``` qui est capable d'utiliser les fonctions présentes dans ```obo.py```. La fonction ```stripTags```  du module ```obo.py``` requiert à son appel un argument. Pour lancer cette fonction correctement, nous avons donc besoin de lui fournir une information. Rappelez-vous de [l'exemple du chien dressé de la leçon précédente](/fr/lecons/travailler-avec-des-fichiers-texte#cr%C3%A9er-et-%C3%A9crire-dans-un-fichier-texte). Pour aboyer le chien avait besoin de deux choses : de l'air et d'une friandise. La fonction ```stripTags``` de ```obo.py```  a besoin d'une seule chose : une chaîne de caractères nommée *pageContents*. Mais vous remarquerez que lorsque l'on appelle la fonction ```stripTags``` à la fin de notre programme (```trialcontents.py```) nous ne mentionnant pas de variable nommée “*pageContents*“.  Au lieu de cela, la fonction reçoit une variable nommée HTML comme argument. Cela peut être déroutant pour de nombreuses personnes lorsqu'elles commencent à programmer. Quand l'on déclare une fonction et ses arguments, nous ne sommes pas obligés de nommer les variables d'entré de la même manière. Tant que le type de l'argument est le bon, tout devrait fonctionner comme prévu,  peu importe le nom que nous lui donnons. Dans notre cas, nous souhaitons faire passer à l'argument *pageContents* le contenu de notre variable *HTML*. Vous auriez pu lui passer n'importe quelle chaîne de caractères, y compris celle que vous aviez saisie directement entre les parenthèses. Essayez de relancer *trial-content.py*,  en remplaçant l'argument fourni  à  ```stripTags``` par “J'aime beaucoup les chiens.” et observez ce qu'il s'en suit. Notez que cela dépend de la manière dont vous définissez votre fonction (et ce qu'elle est censée faire) , votre argument peut être autre chose qu'une chaîne de caractères : un *entier* par exemple.


# Lectures suggérées

- Lutz,   Learning Python
  - Ch. 7: Strings
  - Ch. 8: Lists and Dictionaries
  - Ch. 10: Introducing Python Statements
  - Ch. 15: Function Basics

# Synchronisation du code

Pour suivre les leçons à venir, il est important que vous ayez les bons fichiers et programmes dans votre répertoire ```programming-historian```. A la fin de chaque chapitre, vous pouvez télécharger le fichier zip contenant le matériel de cours du the programming-historian afin de vous assurer d'avoir le bon code. Notez que nous avons supprimé les fichiers inutiles des leçons précédentes. Votre répertoire peut contenir plus de fichiers, ce n'est pas grave, l'important est de s'assurer que les codes que nous ré-investirrons fonctionneront.

- programming-historian-2 ([zip](https://programminghistorian.org/assets/python-lessons2.zip))
