--- 
title: Introduction à Beautiful Soup
collection: lecons
layout: lesson
slug: intro-a-beautifulsoup
date: 2012-12-30
translation_date: 2021-04-01
authors:
- Jeri Wieringa
editors:
- Fred Gibbs
- Frederik Elwert
translator:
- Lucas Terriel
translation-editor:
- Prénom Nom
translation-reviewer:
- Prénom Nom 
original: intro-to-beautiful-soup
review-ticket: 
difficulty: 2
activity: transforming
topics: [web-scraping, python]
abstract: "Beautiful Soup est une librairie Python permettant d'extraire des données du HTML, XML et d'autres langages de balisage."
avatar_alt: Une soupière
---

{% include toc.html %}





Version : Python 3.6 et BeautifulSoup 4.

Cette leçon suppose des connaissances de base en HTML, en CSS et sur le [*Document Object Model*](https://fr.wikipedia.org/wiki/Document_Object_Model) (DOM). Cela suppose également une certaine connaissance du langage de programmation Python. Pour une introduction basique de Python, consultez la leçon [Travailler avec des fichiers textes](https://programminghistorian.org/fr/lecons/travailler-avec-des-fichiers-texte) de William J. Turkel et Adam Crymble.

La plupart du travail est effectué dans le terminal. Pour une introduction à l'utilisation du terminal, reportez-vous la leçon du [Scholar's Lab Command Line Bootcamp](http://praxis.scholarslab.org/resources/bash/).

## Qu'est ce que BeautifulSoup ?

### Vue d'ensemble

«Vous n’avez pas écrit cette terrible page. Vous essayez simplement d'en tirer des données. Beautiful Soup est là pour vous aider.» ([lignes d'ouverture de la documentation Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/)).

Beautiful Soup est une bibliothèque Python permettant d'extraire des données du HTML, du XML, et d'autres langages de balisage. Supposons que vous ayez trouvé des pages Web qui affichent des données pertinentes pour votre recherche, telles que des informations sur la date ou l'adresse, mais qui ne fournissent aucun moyen de télécharger les données directement. Beautiful Soup vous aide à extraire un contenu particulier d'une page Web, à supprimer le balisage HTML, et à sauvegarder ces informations. C'est un outil de *scraping* Web qui vous aide à nettoyer et à parser les documents que vous avez extraits du Web.

La [documentation de Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/) vous donnera une idée de la variété des choses que la bibliothèque Beautiful Soup vous aidera à faire, de l'isolement des titres et des liens, à l'extraction de l'ensemble du texte dans les balises HTML, en passant par la modification du HTML dans le document sur lequel vous travaillez.

### Installer Beautiful Soup

L'installation de Beautiful Soup est plus simple si vous avez déjà installé pip ou tout autre gestionnaire de paquets Python. Si vous ne disposez pas de pip, parcourez la courte leçon sur l'[installation de bibliothèques Python avec pip](https://programminghistorian.org/fr/lecons/installation-modules-python-pip) pour le faire fonctionner. Une fois pip installé, exécutez la commande suivante dans le terminal pour installer Beautiful Soup :

```bash
$ pip install beautifulsoup4
```

Vous devrez peut-être faire précéder la ligne de «sudo», ce qui donne à votre ordinateur la permission d'écrire dans vos répertoires racines et qui vous oblige à saisir à nouveau votre mot de passe. C'est la même logique qui se trouve derrière, lorsqu'on vous demande d'entrer votre mot de passe pour installer un nouveau programme.

Avec sudo, la commande est :

```bash
$ sudo pip install beautifulsoup4
```

<div class="image" style="text-align:center;">
  <img src="https://imgs.xkcd.com/comics/sandwich.png" alt="«Sandwich» par XKCD">
  <div>Le pouvoir de sudo : «Sandwich» par XKCD</div>
</div>

De plus, vous devrez installer un parseur pour interpréter le HTML. Pour ce faire, exécutez dans le terminal :

```bash
$ pip install lxml
```

ou

```bash
$ sudo pip install lxml
```

Enfin, pour que ce code fonctionne avec Python 2.x ou Python 3.x, vous aurez besoin d'une bibliothèque d'aide. Exécutez dans le terminal :

```bash
$ pip install future
```

ou 

```bash
$ sudo pip install future
```

## Cas d'usage : extraction de noms et d'URL à partir d'une page HTML

### Aperçu : où allons-nous ?

Parce que j'aime voir où se trouve la ligne d'arrivée avant de commencer, je débuterai par une vue de ce que nous essayons de créer. Nous essayons de nous diriger, à partir d'une page de résultats de recherche HTML qui ressemble à ceci :

```html
<table border="1" cellspacing="2" cellpadding="3">
    <tbody>
        <tr>
            <th>Member Name</th>
            <th>Birth-Death</th>
        </tr>
        <tr>
            <td>
                <a href="http://bioguide.congress.gov/scripts/biodisplay.pl?index=A000035">ADAMS,
                    George Madison</a>
            </td>
            <td>1837-1920</td>
        </tr>
        <tr>
            <td>
                <a href="http://bioguide.congress.gov/scripts/biodisplay.pl?index=A000074">ALBERT,
                    William Julian</a>
            </td>
            <td>1816-1879</td>
        </tr>
        <tr>
            <td>
                <a href="http://bioguide.congress.gov/scripts/biodisplay.pl?index=A000077">ALBRIGHT,
                    Charles</a>
            </td>
            <td>1830-1880</td>
        </tr>
    </tbody>
</table>

```
vers un fichier CSV avec les noms et les URL qui ressemble à ceci :

```
"ADAMS, George Madison",http://bioguide.congress.gov/scripts/biodisplay.pl?index=A000035
"ALBERT, William Julian",http://bioguide.congress.gov/scripts/biodisplay.pl?index=A000074
"ALBRIGHT, Charles",http://bioguide.congress.gov/scripts/biodisplay.pl?index=A000077
```
en utilisant un script Python comme celui-ci :

```python
from bs4 import BeautifulSoup
import csv

soup = BeautifulSoup (open("43rd-congress.html"), features="lxml")

final_link = soup.p.a
final_link.decompose()

f = csv.writer(open("43rd_Congress.csv", "w"))
f.writerow(["Name", "Link"])    # Écrire les en-têtes des colonnes comme première ligne

links = soup.find_all('a')
for link in links:
    names = link.contents[0]
    fullLink = link.get('href')

    f.writerow([names,fullLink])
```

Cette leçon explique comment assembler le code final.

### Obtenez une page Web pour en extraire du contenu

La première étape consiste à obtenir une copie d'une ou des pages HTML dont vous souhaitez extraire le contenu. Vous pouvez combiner BeautifulSoup avec [urllib3](https://urllib3.readthedocs.io/en/latest/) pour travailler directement avec des pages Web. Cette leçon, cependant, se concentre sur l'utilisation de BeautifulSoup avec des copies locales (téléchargées) de fichiers HTML.

La base de données du Congrès que nous utilisons n'est pas facile à extraire car l'URL des résultats de recherche reste la même quelque soit ce que vous recherchez. Bien que cela puisse être contourné par un programme, il est plus facile pour nos besoins d'aller sur
[http://bioguide.congress.gov/biosearch/biosearch.asp](http://bioguide.congress.gov/biosearch/biosearch.asp), de rechercher le numéro de congrès 43 et d'enregistrer une copie de la page de résultats.

<div class="image" style="text-align:center;">
  <img src="https://programminghistorian.org/images/intro-to-beautiful-soup/Congressional-Biographical-Directory-CLERKWEB-2013-08-23-12-22-12.jpg" alt="Figure 1 : L'interface de recherche BioGuide pour le 43ème Congrès">
  <div>Figure 1 : L'interface de recherche BioGuide pour le 43ème Congrès</div>
</div>


<div class="image" style="text-align:center;">
  <img src="https://programminghistorian.org/images/intro-to-beautiful-soup/Congressional-Biographical-Directory-Results-2013-08-23-12-25-09.jpg" alt="Figure 2 : Les résultats du BioGuide nous voulons télécharger le HTML derrière cette page">
  <div>Figure 2 : Les résultats du BioGuide nous voulons télécharger le HTML derrière cette page</div>
</div>

Sélectionnez «Fichier» et «Enregistrer sous…» depuis la fenêtre de votre navigateur qui accomplira cela (Simplifiez vous la vie, en évitant d'utiliser des espaces dans le nommage de votre fichier). J'ai utilisé le nom «43rd-congress.html». Déplacez le fichier dans le dossier dans lequel vous souhaitez travailler.

(Pour savoir comment automatiser le téléchargement des pages HTML avec Python, consultez les leçons [Téléchargement automatisé avec Wget](https://programminghistorian.org/en/lessons/automated-downloading-with-wget) de Ian Milligan et [Téléchargement de plusieurs archives à l'aide de requêtes](https://programminghistorian.org/en/lessons/downloading-multiple-records-using-query-strings) d'Adam Crymble.)

### Identifier le contenu 

L'une des premières choses pour laquelle Beautiful Soup peut nous aider, concerne la localisation précise de contenu  enfoui dans une structure HTML. Beautiful Soup vous permet de sélectionner le contenu en fonction des balises (exemple: `soup.body.p.b` trouve le premier élément en gras (`<b>`) dans une balise paragraphe (`<p>`) à l'intérieur de la balise `<body>` dans le document). Pour avoir une bonne représentation de la façon dont les balises sont imbriquées dans le document, nous pouvons utiliser la méthode `.prettify()` sur notre objet `soup`.

Créez un nouveau fichier texte nommé «soupexample.py» au même emplacement que votre fichier HTML téléchargé. Ce fichier contiendra le script Python que nous développerons au cours de cette leçon.

Pour commencer, importez la bibliothèque BeautifulSoup, ouvrer le fichier HTML et passez-le à BeautifulSoup, puis affichez la version «lisible» (*pretty*) dans le terminal.

```python
from bs4 import BeautifulSoup

soup = BeautifulSoup(open("43rd-congress.html"), features="lxml")

print(soup.prettify())
```

Sauvegardez «soupexample.py» dans le répertoire contenant votre fichier HTML et allez sur la ligne de commande. Naviguez (en utilisant `cd`) vers le répertoire dans lequel vous travaillez et exécutez ce qui suit :

```shell
$ python soupexample.py
```

Vous devriez voir la fenêtre de votre terminal se remplir d'une version du code HTML original joliment indentée (voir la Figure 3). Il s'agit d'une représentation visuelle de la relation hiérarchique entre les différentes balises.

<div class="image" style="text-align:center;">
  <img src="https://programminghistorian.org/images/intro-to-beautiful-soup/Beautiful-Soup-Tutorial-103x40-2013-08-23-13-13-01.jpg" alt="Figure 3 : Affichage «jolie» des résultats du BioGuide">
  <div>Figure 3 : Affichage «jolie» (<i>pretty</i>) des résultats du BioGuide</div>
</div>

### Utilisation de BeautifulSoup pour sélectionner un contenu particulier 

N'oubliez pas que seuls les noms et URL des différents membres du 43ème Congrès nous intéressent. En regardant la version «lisible» (*pretty*) du fichier, la première chose à remarquer est que les données que nous voulons ne sont pas trop profondément intégrées dans la structure HTML.

Les noms et les URL sont, fort heureusement, intégrés dans des balises `<a>`. Nous devons donc isoler toutes les ancres `<a>`. Nous pouvons le faire en mettant à jour le code dans «soupexample.py» comme suit :

```python
from bs4 import BeautifulSoup

soup = BeautifulSoup (open("43rd-congress.html"), features="lxml")

# print(soup.prettify())

links = soup.find_all('a')

for link in links:
    print(link)
```

Notez que nous avons ajouté un `#` au début de la ligne `print(soup.prettify())`. Le croissillon ou dièse «commente» le code ou transforme une ligne de code en commentaire. Cela indique à l'ordinateur de sauter la ligne lors de l'execution du programme. Commenter du code qui n'est plus utilisé est un moyen de garder une trace de ce que nous avons fait dans le passé.

Enregistrez et exécutez le script à nouveau pour voir toutes les balises d'ancre dans le document.

```bash
$ python soupexample.py
```

Une chose à noter est qu'il y a un lien supplémentaire dans notre fichier - le lien pour une recherche supplémentaire.

<div class="image" style="text-align:center;">
  <img src="https://programminghistorian.org/images/intro-to-beautiful-soup/Beautiful-Soup-Tutorial-101x26-2013-08-23-13-25-56.jpg" alt="Figure 4 : Les URLs et les noms, plus un ajout">
  <div>Figure 4 : Les URLs et les noms, plus un ajout</div>
</div>

Nous pouvons nous en débarrasser avec seulement quelques lignes de code. Pour en revenir à la version «lisible» (*pretty*), notez que cette dernière balise `<a>` n'est pas dans le tableau (balise `<table>`) mais dans une balise `<p>`. 

<div class="image" style="text-align:center;">
  <img src="https://programminghistorian.org/images/intro-to-beautiful-soup/Beautiful-Soup-Tutorial-103x40-2013-08-23-13-23-07.jpg" alt="Figure 5 : Le mauvais lien">
  <div>Figure 5 : Le mauvais lien</div>
</div>

Parce que BeautifulSoup nous permet de modifier le HTML, nous pouvons supprimer l'élément d'ancre `<a>` qui se trouve sous `<p>` avant de rechercher toutes les balises `<a>`.

Pour ce faire, nous pouvons utiliser la méthode `.decompose()`, qui supprime le contenu spécifié de la `soup`. Soyez prudent lorsque vous utilisez `.decompose()` - vous supprimez à la fois la balise HTML et toutes les données à l'intérieur de cette balise. Si vous n'avez pas correctement isolé les données, vous supprimerez peut-être les informations que vous vouliez extraire. Mettez à jour le fichier comme ci-dessous et exécutez à nouveau.

```python
from bs4 import BeautifulSoup

soup = BeautifulSoup (open("43rd-congress.html"), features="lxml")

# print(soup.prettify())

final_link = soup.p.a
final_link.decompose()

links = soup.find_all('a')

for link in links:
    print(link)
```
<div class="image" style="text-align:center;">
  <img src="https://programminghistorian.org/images/intro-to-beautiful-soup/Beautiful-Soup-Tutorial-101x26-2013-08-23-13-28-04.jpg" alt="Figure 6 : Seuls les noms et les URLs ont été isolés avec succès">
  <div>Figure 6 : Seuls les noms et les URLs ont été isolés avec succès</div>
</div>

Succès ! Nous avons isolé tous les liens que nous voulons et aucun des liens que nous ne voulons pas !

### Suppression de balises et écriture de contenu dans un fichier CSV 

Mais nous n'avons pas encore fini ! Il reste des balises HTML entourant les données URL que nous voulons. Nous devons enregistrer les données dans un fichier afin de les utiliser pour d'autres projets.

Afin de nettoyer les balises HTML et de séparer les URL des noms, nous devons isoler les informations des éléments d'ancre. Pour ce faire, nous utiliserons deux méthodes Beautiful Soup puissantes et couramment utilisées: `.contents` et `.get()`.

Là où auparavant nous disions à l'ordinateur d'afficher chaque lien, nous voulons maintenant que l'ordinateur sépare le lien en parties et les affiche séparément. Pour les noms, nous pouvons utiliser `link.contents`. L'attribut  `.contents` isole le texte des balises HTML. Par exemple, si vous avez commencé avec

```html
<h2>Ceci est mon texte d'en-tête</h2>
```

il vous restera «Ceci est mon texte d'en-tête» après avoir appliqué l'attribut  `.contents`. Dans ce cas, nous voulons le contenu à l'intérieur de la première balise dans `<link>`. (Il n'y a qu'une seule balise dans `<link>`, mais comme l'ordinateur ne s'en rend pas compte, nous devons lui dire d'utiliser la première balise.)

Pour l'URL, cependant, `.contents` ne fonctionne pas car l'URL fait partie de la balise HTML. Au lieu de cela, nous utiliserons la méthode `.get()`, qui nous permet d'extraire le texte associé à (qui est de l'autre côté du «=» de) l'attribut `href`.

```python
from bs4 import BeautifulSoup

soup = BeautifulSoup (open("43rd-congress.html"), features="lxml")

# print(soup.prettify())

final_link = soup.p.a
final_link.decompose()

links = soup.find_all('a')
for link in links:
    names = link.contents[0]
    fullLink = link.get('href')
    print(names)
    print(fullLink)

```

<div class="image" style="text-align:center;">
  <img src="https://programminghistorian.org/images/intro-to-beautiful-soup/Beautiful-Soup-Tutorial-101x26-2013-08-23-14-13-13.jpg" alt="Figure 7 : Toutes les balises HTML ont été supprimées">
  <div>Figure 7 : Toutes les balises HTML ont été supprimées</div>
</div>

Enfin, nous souhaitons utiliser la bibliothèque CSV pour écrire le fichier. Tout d'abord, nous devons importer la librairie CSV dans le script avec `import csv`. Ensuite, nous créons le nouveau fichier CSV lorsque nous l'«ouvrons» (`open()`) en utilisant `csv.writer()`. Le paramètre `"w"` indique à l'ordinateur d'«écrire» dans le fichier. Pour que le tout reste organisé, nous écrivons quelques en-têtes de colonne. Enfin, au fur et à mesure que chaque ligne est traitée, le nom et les informations d'URL sont écrits dans notre fichier CSV.

```python
from bs4 import BeautifulSoup
import csv

soup = BeautifulSoup (open("43rd-congress.html"), features="lxml")

# print(soup.prettify())

final_link = soup.p.a
final_link.decompose()

f = csv.writer(open("43rd_Congress.csv", "w"))
f.writerow(["Name", "Link"]) # Écrire les en-têtes de colonnes comme première ligne

links = soup.find_all('a')
for link in links:
    names = link.contents[0]
    fullLink = link.get('href')
    # print(names)
    # print(fullLink)
    f.writerow([names, fullLink])
```

Une fois exécuté, cela nous donne un fichier CSV propre que nous pouvons ensuite utiliser à d'autres fins.

<div class="image" style="text-align:center;">
  <img src="https://programminghistorian.org/images/intro-to-beautiful-soup/43rd_Congress-2-2013-08-23-14-18-27.jpg" alt="Figure 8 : Le fichier CSV de résultats">
  <div>Figure 8 : Le fichier CSV de résultats</div>
</div>

Nous avons résolu notre casse-tête et extrait les noms et les URL du fichier HTML.

## Mais attendez! Et si je veux récupérer TOUTES les données?

Étendons notre projet pour capturer toutes les données de la page Web. Nous savons que toutes nos données peuvent être trouvées dans un tableau (`<table>`), alors utilisons les balises `<tr>` pour isoler le contenu que nous voulons.

```python
from bs4 import BeautifulSoup
import csv

soup = BeautifulSoup (open("43rd-congress.html"), features="lxml")

# print(soup.prettify())

final_link = soup.p.a
final_link.decompose()

trs = soup.find_all('tr')
for tr in trs:
    print(tr)

# f = csv.writer(open("43rd_Congress.csv", "w"))
# f.writerow(["Name", "Link"])    # Écrire les en-têtes de colonnes comme première ligne

# links = soup.find_all('a')
# for link in links:
#     names = link.contents[0]
#     fullLink = link.get('href')
#     # print(names)
#     # print(fullLink)

#     f.writerow([names,fullLink])
```

En regardant l'affichage dans le terminal, vous pouvez voir que nous avons sélectionné beaucoup plus de contenu que lorsque nous avons recherché les balises `<a>`. Nous devons maintenant trier toutes ces lignes pour séparer les différents types de données.

<div class="image" style="text-align:center;">
  <img src="https://programminghistorian.org/images/intro-to-beautiful-soup/Beautiful-Soup-Tutorial-142x40-2013-08-23-16-51-22.jpg" alt="Figure 9 : Toutes les données des lignes du tableau">
  <div>Figure 9 : Toutes les données des lignes du tableau</div>
</div>

### Extraire les données 


Nous pouvons extraire les données en deux étapes. Tout d'abord, nous isolerons les informations de lien ; ensuite, nous parserons le reste des données de la ligne du tableau.

Pour la première, créons une boucle pour rechercher toutes les éléments d'ancres et «obtenir» les données associées à `href`.

```python
from bs4 import BeautifulSoup
import csv

soup = BeautifulSoup (open("43rd-congress.html"), features="lxml")

# print(soup.prettify())

final_link = soup.p.a
final_link.decompose()

trs = soup.find_all('tr')

for tr in trs:
    for link in tr.find_all('a'):
        fulllink = link.get ('href')
        print(fulllink) # Afficher dans le terminal pour vérifier les résultats

# f = csv.writer(open("43rd_Congress.csv", "w"))
# f.writerow(["Name", "Link"])    # Écrire les en-têtes de colonnes comme première ligne

# links = soup.find_all('a')
# for link in links:
#     names = link.contents[0]
#     fullLink = link.get('href')
#     # print(names)
#     # print(fullLink)

#     f.writerow([names,fullLink])
```

Nous devons ensuite lancer une recherche des données du tableau dans les lignes du tableau. (Le `print()` ici nous permet de vérifier que le code fonctionne mais n'est pas nécessaire.)

```python
from bs4 import BeautifulSoup
import csv

soup = BeautifulSoup (open("43rd-congress.html"), features="lxml")

# print(soup.prettify())

final_link = soup.p.a
final_link.decompose()

trs = soup.find_all('tr')

for tr in trs:
    for link in tr.find_all('a'):
        fulllink = link.get ('href')
        print(fulllink) # Afficher dans le terminal pour vérifier les résultats

    tds = tr.find_all("td")
    print(tds)

# f = csv.writer(open("43rd_Congress.csv", "w"))
# f.writerow(["Name", "Link"])    # Écrire les en-têtes de colonnes comme première ligne

# links = soup.find_all('a')
# for link in links:
#     names = link.contents[0]
#     fullLink = link.get('href')
#     # print(names)
#     # print(fullLink)

#     f.writerow([names,fullLink])
```

Ensuite, nous devons extraire les données souhaitées. Nous savons que tout ce que nous voulons pour notre fichier CSV se trouve dans les balises de données du tableau (`<td>`). Nous savons également que ces éléments apparaissent dans le même ordre dans la ligne. Parce que nous avons a faire à des listes, nous pouvons identifier les informations par leur index dans la liste. Cela signifie que le premier élément de données de la ligne est identifié par `[0]`, le second par `[1]`, etc.

Étant donné que toutes les lignes ne contiennent pas le même nombre d'éléments de données, nous devons indiquer au script de continuer s'il rencontre une erreur. C'est la logique du bloc `try...except`. Si une ligne particulière échoue, le script continuera à la ligne suivante.

```python
from bs4 import BeautifulSoup
import csv

soup = BeautifulSoup (open("43rd-congress.html"), features="lxml")

final_link = soup.p.a
final_link.decompose()

trs = soup.find_all('tr')

for tr in trs:
    for link in tr.find_all('a'):
        fulllink = link.get ('href')
        print(fulllink) # Afficher dans le terminal pour vérifier les résultats

    tds = tr.find_all("td")

    try: # Nous utilisons "try" car le tableau n'est pas bien formaté. Cela permet au programme de continuer après avoir rencontré une erreur.
        names = str(tds[0].get_text()) # Cette structure isole l'élément par sa colonne dans le tableau et le convertit en chaîne de caractères.
        years = str(tds[1].get_text())
        positions = str(tds[2].get_text())
        parties = str(tds[3].get_text())
        states = str(tds[4].get_text())
        congress = tds[5].get_text()

    except:
        print(f"bad tr string: {tds}")
        continue # Cela indique à l'ordinateur de passer à l'élément suivant après avoir rencontré une erreur
        
    print(names, years, positions, parties, states, congress)

# f = csv.writer(open("43rd_Congress.csv", "w"))
# f.writerow(["Name", "Link"])    # Écrire les en-têtes de colonnes comme première ligne

# links = soup.find_all('a')
# for link in links:
#     names = link.contents[0]
#     fullLink = link.get('href')
#     # print(names)
#     # print(fullLink)

#     f.writerow([names,fullLink])

```
Dans ce cadre, nous utilisons la structure suivante :

```python
years = str(tds[1].get_text())
```

Nous appliquons la méthode `.get_text()` au 2ème élément de la ligne (car les ordinateurs comptent en commençant par 0) et créons une chaîne de caractères à partir du résultat. Nous attribuons cela à la variable `years`, que nous utiliserons pour créer le fichier CSV. Nous répétons cela pour chaque élément du tableau que nous voulons capturer dans notre fichier.

### Écriture du fichier CSV 

La dernière étape de ce fichier consiste à créer le fichier CSV. Ici, nous utilisons le même processus comme nous l'avons fait dans la partie I, seulement avec plus de variables.

Par conséquent, notre fichier ressemblera à :

```python
from bs4 import BeautifulSoup
import csv

soup = BeautifulSoup (open("43rd-congress.html"), features="lxml")

# print(soup.prettify())

final_link = soup.p.a
final_link.decompose()

f = csv.writer(open("43rd_Congress_all.csv", "w"))   # Ouvrir le fichier de sortie pour l'écriture dans ce dernier avant la boucle
f.writerow(["Name", "Years", "Position", "Party", "State", "Congress", "Link"]) # Écrire les en-têtes de colonnes comme première ligne

trs = soup.find_all('tr')

for tr in trs:
    for link in tr.find_all('a'):
        fullLink = link.get ('href')

    tds = tr.find_all("td")

    try: # Nous utilisons "try" car le tableau n'est pas bien formaté. Cela permet au programme de continuer après avoir rencontré une erreur.
        names = str(tds[0].get_text()) # Cette structure isole l'élément par sa colonne dans le tableau et le convertit en chaîne de caractères.
        years = str(tds[1].get_text())
        positions = str(tds[2].get_text())
        parties = str(tds[3].get_text())
        states = str(tds[4].get_text())
        congress = tds[5].get_text()

    except:
        print("bad tr string: {}".format(tds))
        continue # Cela indique à l'ordinateur de passer à l'élément suivant après avoir rencontré une erreur.

    f.writerow([names, years, positions, parties, states, congress, fullLink])
    
# f = csv.writer(open("43rd_Congress.csv", "w"))
# f.writerow(["Name", "Link"])    # Écrire les en-têtes de colonnes comme première ligne

# links = soup.find_all('a')
# for link in links:
#     names = link.contents[0]
#     fullLink = link.get('href')
#     # print(names)
#     # print(fullLink)

#     f.writerow([names,fullLink])
```

Vous l'avez fait! Vous avez créé un fichier CSV à partir de toutes les données du tableau, en créant des données utilisables à partir de la confusion de la page HTML.

----

#### A propos de l'auteur 

Jeri Wieringa est doctorant en Histoire à l'Université George Mason 
