---
title: "Création d'un modèle de classification d’images"
slug: creer-modele-classification-images
layout: lesson
collection: lessons
layout: lesson
date: YYYY-MM-DD
authors:
- Pierre Brochard
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
difficulty:
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/685
activity:
topics:
abstract: "Short abstract of this lesson"
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

Ce tutoriel présente une méthode simple et efficace pour explorer des corpus contenant plusieurs milliers d’images dont seules certaines sont des cartes. Il s'agit d'entraîner un modèle capable de repérer ces éléments. L’objectif est d’enrichir les sources d’un projet comme TOPAMA.


Le projet TOPAMA est un système d’information géographique couvrant l’Europe occidentale et l’Afrique du Nord entre l’Antiquité et le Moyen Âge. Il permet de localiser et d’analyser des données historiques (évêchés, monastères, territoires, etc.). Il propose plus d’une centaine de cartes géographiques au format ouvert, modifiables par tous les utilisateurs. Ces cartes géographiques sont en partie issues de la vectorisation de grandes séries documentaires, comme le livre *Géographie de la Gaule au VIe siècle*, écrit par Auguste Longnon (1878). Toutes les données intégrées font l’objet d’une validation scientifique rigoureuse.

Pour parvenir à cet objectif, nous développerons un modèle prototype de classification d’images capable de distinguer quatre catégories visuelles propres au projet (Cartes, Dessins, Photographies et Tableaux). Ce modèle a avant tout une vocation pédagogique et vise à détailler les différentes étapes de création d’un modèle de classification, de la constitution du jeu de données à son évaluation et à son application sur un corpus d’images. Le jeu de données utilisé dans le cadre de ce tutoriel reste toutefois trop limité et ne permet pas une utilisation en production. Une des pistes d'amélioration possibles serait l'augmentation de la taille du corpus ainsi qu'une plus grande diversité.

L’objectif est de présenter les différentes étapes nécessaires à la création d’un modèle de classification d'images. Dans ce tutoriel, nous constituerons donc un corpus d’images à partir de la base de connaissances Wikidata. Nous diviserons ce corpus en trois sous-ensembles nécessaires à la construction et à la validation du modèle (entraînement, validation et test). Puis nous appliquerons le modèle créé à un corpus de test et nous évoquerons les limites et les biais de ce modèle créé.


## Connaissances préalables recommandées

Le tutoriel s'appuyant sur des commandes Unix, l’utilisateur doit disposer d’un accès à un terminal et d’un environnement permettant d’exécuter des commandes shell. Nous préciserons également les principaux prérequis logiciels nécessaires au lancement du fine-tuning, notamment Python, ainsi que les dépendances du projet.

## Matériel requis

Pour suivre ce tutoriel, il est recommandé de disposer d’une carte graphique (GPU) avec au moins 8 Go de VRAM.

---

## 1 Création du modèle de classification

L’objectif est de développer un modèle capable de classifier automatiquement les images extraites des EPUB. Pour cela, nous avons choisi de nous appuyer sur un modèle de classification de la famille **YOLO**, proposé par **Ultralytics**, plutôt que de construire et d’entraîner un réseau de neurones à partir de zéro.

Le modèle utilisé, `yolo26n-cls.pt`, est un modèle pré-entraîné à **poids ouverts (*open weights*)** destiné à la classification d’images : les paramètres appris lors de son entraînement sont accessibles et peuvent être réutilisés pour spécialiser le modèle. 

Pour chaque image, le modèle attribue une probabilité d’appartenance à chaque catégorie :

- carte géographique
- dessin
- photographie
- tableau

Cela permet d’identifier rapidement les cartes géographiques dans un grand volume d’images.

### 1.1 Installation du framework Yolo

Pour entraîner et déployer notre modèle, nous utiliserons la bibliothèque Ultralytics YOLO26, un framework d’intelligence artificielle modulaire et performant, spécialisé dans les tâches de vision par ordinateur. La bibliothèque **Ultralytics** fournit l'environnement nécessaire pour charger ce modèle, configurer son entraînement, effectuer le fine-tuning sur notre jeu de données et évaluer ses performances.

Bien que le framework YOLO puisse fonctionner sur des configurations modestes, l’utilisation d’une carte graphique (GPU) est fortement recommandée pour accélérer les phases d’entraînement du modèle. Cependant, il est tout à fait possible de réaliser ce tutoriel avec le processeur de son ordinateur (CPU) standard, même si les temps de calcul seront plus longs.

Ultralytics YOLO26 nécessite un environnement Python 3.8 ou supérieur, ainsi que la bibliothèque PyTorch 1.8 ou version ultérieure pour fonctionner de manière optimale.

Étapes pour configurer l’environnement :

#### Création d’un environnement virtuel Python (recommandé pour isoler les dépendances) :

```python
python3 -m venv .
```

#### Activation de l’environnement :

```python
source bin/activate .
```

#### Installation des bibliothèques nécessaires au projet :

```python
pip install ultralytics==8.4.6 splitfolders==0.6.1
```
La bibliothèque ultralytics est nécessaire à la création du modèle et la bibliothèque splitfolders à la création des jeux de données.

### 1.2 Validation de l'installation et test du modèle par défaut

Les modèles de classification sont pré-entraînés sur le corpus [ImageNet](https://www.image-net.org/index.php).

Pour vérifier que l'installation s'est déroulée correctement, nous allons utiliser le modèle de classification par défaut. Ce modèle peut reconnaître une large variété de catégories d'images.

**Exécution d'un test de démonstration**

```bash
yolo classify predict model=yolo26n-cls.pt source='https://ultralytics.com/images/bus.jpg'
```

Le modèle YOLO attribue des scores de probabilité pour chaque catégorie possible. Par exemple, pour l’image du [bus](https://ultralytics.com/images/bus.jpg), le modèle retourne les informations suivantes :

{% include figure.html filename="fr-or-creer-modele-classification-images-01.png" alt="Sortie dans une console de la commande de test proposée pour la bibliothèque YOLO avec l'analyse d'une photo comprenant un bus." caption="Figure 1. Test de la bibliothèque YOLO" %}

0.57 pour la catégorie mini-bus

0.34 pour la catégorie police_van

Ces scores indiquent la confiance du modèle dans sa prédiction. Plus le score est proche de 1, plus le modèle est certain que l'image appartient à cette catégorie.

---

## 2 Constitution des données d'apprentissage

Pour entraîner notre modèle de classification, la deuxième étape consiste à construire un corpus d’images représentatif et équilibré destiné à trois usages : le jeu de données d’apprentissage permettant la spécialisation du modèle, le jeu de données de validation permettant de tester les performances du modèle et enfin le jeu de données de test permettant d'évaluer le modèle final.

De la qualité des données d'apprentissage va dépendre la qualité du modèle ainsi créé. Nous nous appuierons sur Wikimedia Commons pour plusieurs raisons :


- Wikimedia Commons est une médiathèque mettant à disposition des images de qualité, en haute résolution et bien documentées.
- Le contenu de Wikimedia Commons est très diversifié et son accès est gratuit.
- Wikimedia Commons permet de télécharger aisément un échantillon significatif d'images pour chaque catégorie.

Pour ce tutoriel, nous choisirons quatre catégories (Dessin, Tableau, Photo, Carte). Ces quatre catégories sont présentes dans les livres patrimoniaux que nous explorons et possèdent des caractéristiques facilement identifiables et la catégorie Carte répond au besoin initial.


### 2.1 Introduction à Wikidata

Wikidata est une base de connaissances libre et collaborative qui permet d'interroger des données structurées grâce au langage SPARQL. À l'aide de différentes requêtes, nous allons utiliser Wikidata pour récupérer des listes d’images correspondant à nos quatre catégories.

Ces images sont hébergées sur Wikimedia Commons et librement accessibles.

### 2.2 Exécution de requêtes SPARQL et téléchargement des résultats

À partir des requêtes SPARQL, nous obtenons des fichiers CSV contenant des liens vers les images dans lesquels nous sélectionnons 500 éléments pour chaque catégorie.

Les images sont ensuite téléchargées dans des dossiers séparés (Dessin, Tableau, Photo, Carte).

Voici les étapes à suivre :

1. Dans un premier temps, il faut ouvrir [l'interface de requête SPARQL de Wikidata](https://query.wikidata.org/) dans son navigateur.
2. Exécuter les différentes requêtes SPARQL fournies ci-dessous pour chaque catégorie.
3. Télécharger les résultats des requêtes au format CSV.

Les requêtes SPARQL sont décrites dans la leçon [Introduction aux principes des données ouvertes liées](https://programminghistorian.org/fr/lecons/intro-donnees-ouvertes-liees)

Il est possible d'interroger la base Wikidata à travers une interface SPARQL.

#### 2.2.1 Constitution des données d'apprentissage pour la catégorie Tableau

Pour constituer cette catégorie, nous nous appuierons sur la [base de données Joconde](https://www.culture.gouv.fr/espace-documentation/bases-de-donnees/Fiches-bases-de-donnees/Joconde-catalogue-collectif-des-collections-des-musees-de-France), gérée par le ministère de la Culture français.
Joconde est un catalogue collectif qui référence les collections des musées français, notamment des peintures. Cependant, ce choix introduit un biais dans le modèle, puisque les données proviennent majoritairement d'œuvres françaises.

**Requête SPARQL pour extraire des peintures référencées dans la base Joconde**

```sparql
SELECT ?image  WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],mul,en". }
  ?paintings wdt:P18 ?image;  # Récupère l'URL de l'image
    wdt:P347 ?joconde. # Filtre : œuvres avec un identifiant de la base Joconde
  ?paintings wdt:P31 wd:Q3305213. # Filtre : entités de type "peinture"
  FILTER regex(STR(?image), "\\.jpg$")

}
LIMIT 1000
```
Exemple d'exécution de la requête :

{% include figure.html filename="fr-or-creer-modele-classification-images-02.png" alt="Requête en SPARQL exécutée sur l'interface Web de Wikidata permettant d'interroger les données de la base Joconde présente sur Wikidata" caption="Figure 2. Requête Wikidata sur la base de données Joconde" %}

#### 2.2.2 Constitution des données d’apprentissage pour la catégorie Dessin

Pour constituer cette catégorie, nous avons choisi de réutiliser les numérisations des œuvres de quelques artistes. Cette contrainte limite l'apprentissage du modèle à ces seuls artistes.

**Requête SPARQL pour extraire une liste des dessins de plusieurs auteurs**

Cette requête SPARQL permet de récupérer les images des œuvres de Sawrey Gilpin, Fúlvia Gonçalves, James Ensor, Johan Tobias Sergel, Thomas Hastings, Robert Smirke, John Flaxman, Jean-Louis Forain, Jean-Auguste-Dominique Ingres, Edme Bouchardon disponibles sur Wikimedia Commons.

```sparql
SELECT ?dessin ?dessinLabel ?image ?creator ?creatorLabel
WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],mul,en". }
  ?dessin wdt:P31 wd:Q93184. # nature dessin
  ?dessin wdt:P170 ?creator. # creator
  ?dessin wdt:P18 ?image. # afficher les images
  VALUES ?creator { wd:Q7428677 wd:Q108128364 wd:Q158840 wd:Q924618 wd:Q18672468 wd:Q983719 wd:Q366066 wd:Q719614 wd:Q23380 wd:Q987687 } # Liste des valeurs possibles pour le créateur
 FILTER regex(STR(?image), "\\.jpg$")
}
LIMIT 10000
```


#### 2.2.3 Constitution des données d'apprentissage pour la catégorie Photo

Pour constituer cette catégorie, nous utiliserons la [base de données Mérimée](https://www.culture.gouv.fr/espace-documentation/bases-de-donnees/Fiches-bases-de-donnees/merimee-une-base-de-donnees-du-patrimoine-monumental-francais-de-la-prehistoire-a-nos-jours), dédiée au patrimoine monumental et architectural français, de la Préhistoire à nos jours.

Ce choix nous permet de disposer rapidement d’un corpus varié et exploitable. Cependant, il introduit un biais dans le modèle, puisque les données décrivent majoritairement des objets du patrimoine.

**Requête SPARQL pour extraire des photos de monuments référencés dans la base Mérimée**

```sparql
SELECT ?image WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],mul,en". }
   ?photos wdt:P18 ?image;  # Récupère l'URL de l'image
        wdt:P380 ?merimee. # Filtre : éléments avec un identifiant de la base Mérimée
   FILTER regex(STR(?image), "\\.jpg$")

}
LIMIT 1000
```


#### 2.2.4 Constitution des données d’apprentissage pour la catégorie Carte géographique

La catégorie Carte géographique est plus difficile à constituer, car Wikidata référence relativement peu de cartes géographiques. Pour pallier ce manque, nous utiliserons l’ensemble des cartes géographiques référencées dans Wikidata, puis nous effectuerons une sélection manuelle afin de constituer un corpus divers et représentatif.


**Requête SPARQL pour extraire l'ensemble des cartes géographiques**

```sparql
SELECT ?image WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],mul,en". }
  ?carte wdt:P31 wd:Q4006; # Filtre : entités de type "carte géographique"
    wdt:P18 ?image. # Récupère l'URL de l'image associée
 FILTER regex(STR(?image), "\\.jpg$")
}
LIMIT 1000
```

### 2.3 Téléchargement des images depuis Wikimedia Commons

À l’issue des différentes requêtes SPARQL, nous disposons de quatre fichiers CSV contenant les liens vers les images :

- query_dessin.csv (Dessins)

- query_tableau.csv (Tableaux)

- query_photo.csv (Photographies)

- query_carte.csv (Cartes géographiques)

#### 2.3.1 Sélection aléatoire et préparation des fichiers

Pour chaque catégorie, nous sélectionnons aléatoirement 500 images parmi les résultats issus des requêtes SPARQL grâce à la commande shuf.

```bash
shuf -n 500 query_dessin.csv > dessin_final.csv
shuf -n 500 query_tableau.csv > tableau_final.csv
shuf -n 500 query_photo.csv > photo_final.csv
```
Il existe peu de cartes enregistrées dans la base Wikidata. Notre corpus doit contenir un nombre équivalent de chaque élément. Il est donc nécessaire de sélectionner et de télécharger des cartes diverses et de compléter le fichier query_carte.csv avec ces nouveaux éléments.


#### 2.3.2 Téléchargement respectueux des règles de Wikimedia

Pour télécharger les images, nous devons respecter la politique d’utilisation des robots de Wikimedia (Robot Policy), qui impose :

- Une limitation de la bande passante
- Un délai entre chaque téléchargement pour éviter de surcharger les serveurs.

Nous utiliserons la commande wget avec des paramètres adaptés pour respecter ces contraintes :

```bash
wget -i dessin_final.csv -P Dessin/ -nc --limit-rate=1M --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" -w 15
wget -i tableau_final.csv -P Tableau/ -nc --limit-rate=1M --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" -w 15
wget -i photo_final.csv -P Photo/ -nc --limit-rate=1M --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" -w 15
wget -i query_carte.csv -P Carte/ -nc --limit-rate=1M --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" -w 15
```

Explications des options :

- -i fichier.csv : Spécifie le fichier contenant les URLs à télécharger.
- -P Dossier/ : Enregistre les images dans un dossier dédié (ex : Dessin/, Tableau/).
- -nc : Évite de retélécharger les fichiers déjà présents (no-clobber).
- --limit-rate=1M : Limite la bande passante à 1 Mo/s.
- -w 15 : Attend 15 secondes entre chaque téléchargement.
- --user-agent : Simule un navigateur web pour éviter d’être bloqué par les serveurs.


Un exemple des tableaux téléchargés

{% include figure.html filename="fr-or-creer-modele-classification-images-03.png" alt="Une capture d'écran de quelques miniatures des tableaux téléchargés présents dans le dossier" caption="Figure 3. Un exemple des tableaux téléchargés" %}

Un exemple des dessins téléchargés

{% include figure.html filename="fr-or-creer-modele-classification-images-04.png" alt="Une capture d'écran de quelques miniatures des dessins téléchargés présents dans le dossier" caption="Figure 4. Un exemple des dessins téléchargés" %}


Un exemple des photos téléchargées

{% include figure.html filename="fr-or-creer-modele-classification-images-05.png" alt="Une capture d'écran de quelques miniatures des photos téléchargées présentes dans le dossier" caption="Figure 5. Un exemple des photos téléchargés" %}

Un exemple des cartes géographiques téléchargées

{% include figure.html filename="fr-or-creer-modele-classification-images-06.png" alt="Une capture d'écran de quelques miniatures des cartes téléchargées présentes dans le dossier" caption="Figure 6. Un exemple des cartes téléchargées" %}


#### 2.3.3 Organisation des données

À la fin de cette étape, vous obtiendrez une structure de dossiers claire :

```
Data/
├── Dessin/
│   ├── image1.jpg
│   ├── image2.jpg
│   └── ...
├── Tableau/
│   ├── image1.jpg
│   └── ...
├── Photo/
│   ├── image1.jpg
│   └── ...
└── Carte/
    ├── image1.jpg
    └── ...
```

---

## 3 Création de notre modèle à partir des images issues de Wikimedia Commons

### 3.1 Préparation et organisation du dataset

Pour entraîner efficacement notre modèle de classification, il est essentiel d’organiser les données selon une structure séparant les images destinées à l’entraînement de celles réservées à la validation et au test.

```
Yolo/
├── train/               # Dossier pour les données d'entraînement
│   ├── Photo/
│   ├── Carte/
│   ├── Tableau/
│   └── Dessin/
├──val/                 # Dossier pour les données de validation
│   ├── Photo/
│   ├── Carte/
│   ├── Tableau/
│   └── Dessin/
└── test/                 # Dossier pour les données de test
    ├── Photo/
    ├── Carte/
    ├── Tableau/
    └── Dessin/
```

Le dossier **train** et ses sous-dossiers contiennent les images utilisées pour entraîner les modèles.
Le dossier **val** et ses sous-dossiers contiennent les images utilisées pour comparer les performances des modèles et sélectionner le meilleur.
Le dossier **test** et ses sous-dossiers contiennent les images utilisées pour évaluer le modèle final sur des données inédites.


### 3.2 Construction du dataset :

Pour automatiser la répartition aléatoire des images entre les dossiers d'entraînement (train/), de validation (val/) et de test (test/), nous allons utiliser le script Python suivant :

```python
import splitfolders
splitfolders.ratio("./Data", output="./Yolo", seed=42, ratio=(0.8, 0.1, 0.1))
```


### 3.3 Entraînement du modèle YOLO26

Nous lançons en ligne de commande la spécialisation (fine-tuning) du modèle de classification `yolo26n-cls.pt`. Il s’agit de partir du modèle de base fourni par la société Ultralytics, puis de le spécialiser sur nos données d’apprentissage.

L’entraînement est réalisé sur 200 époques (epochs). À chaque époque, les poids du modèle créé sont progressivement ajustés puis évalués sur le jeu de données de validation. Le modèle obtenant les meilleures performances est sélectionné. Les métriques finales sont calculées avec le jeu de données de test indépendant.

```bash
yolo mode=train task=classify \
    model=yolo26n-cls.pt \
    data=Yolo/ \
    epochs=200 \
    imgsz=640 \
    batch=-1 \
    patience=100 \
    workers=8
```

**Explications des paramètres :**

```
mode=train task=classify : Nous entraînons un modèle pour une tâche de classification.

model=yolo26n-cls.pt : Spécifie le modèle de base utilisé pour le fine-tuning.

data=Yolo/ : Chemin vers le dossier contenant les données organisées selon la structure définie précédemment.

epochs=200 : Nombre d’époques sur l’ensemble des données pour affiner le modèle.

imgsz=640 : Taille des images en entrée (640 × 640 pixels), adaptée pour équilibrer précision et performance.

batch=-1 : Utilise la taille de lot maximale possible en fonction de la mémoire disponible sur votre machine.

patience=100 : Nombre d’époques à attendre avant d’arrêter l’entraînement si aucune amélioration n’est détectée (mécanisme d’early stopping).

workers=8 : Nombre de processus parallèles utilisés pour charger les données, optimisant ainsi la vitesse d’entraînement.
```

Il existe de nombreux autres [paramètres](https://docs.ultralytics.com/fr/usage/cfg) pour ajuster le processus de spécialisation.

---


### 3.4 Évaluation du modèle

Les graphiques produits par la bibliothéque YOLO pendant l'entraînement permettent de suivre l’évolution du modèle à l'aide de différents indicateurs.

{% include figure.html filename="fr-or-creer-modele-classification-images-09.png" alt="Les graphiques produits par la bibliothéque YOLO" caption="Figure 8. Les graphiques produits par la bibliothéque YOLO" %}

L’accuracy Top-1 permet de suivre le pourcentage d’images que le modèle classe correctement.

Les champs train/loss et val/loss permettent de suivre l’évolution de l’erreur du modèle pendant l’apprentissage et la validation.

L’évaluation finale est réalisée sur le jeu de test, constitué d’images qui n’ont pas été utilisées pour entraîner le modèle. La matrice de confusion permet de visualiser les prédictions pour chacune des quatre catégories et d’identifier d’éventuelles confusions entre elles.
Dans notre cas, la matrice de confusion ne présente aucune erreur de classification sur le jeu de test : toutes les images ont été correctement attribuées à leur catégorie.

{% include figure.html filename="fr-or-creer-modele-classification-images-10.png" alt="Matrice de confusion" caption="Figure 8. Matrice de confusion" %}

L’entraînement, effectué sur une carte graphique (NVIDIA RTX 2060 SUPER, 8 Go de VRAM), a requis 108 époques et 1,2 heures de calcul.

{% include figure.html filename="fr-or-creer-modele-classification-images-07.png" alt="Capture d'écran de la sortie console de la fin de l'entraînement du modèle" caption="Figure 7. Fin de l'entraînement du modèle" %}

Le meilleur modèle est le fichier runs/classify/train7/weights/best.pt.

### 3.5 Application du modèle sur une nouvelle image

Une fois l’entraînement terminé, nous testons les performances du modèle sur une carte géographique représentative : une [carte de l'Europe](https://magrit.cnrs.fr/example_map_europe_1.png).

```bash
yolo classify predict \
    model=runs/classify/train7/weights/best.pt \
    source='https://magrit.cnrs.fr/example_map_europe_1.png'
```

Réponse :

{% include figure.html filename="fr-or-creer-modele-classification-images-08.png" alt="Capture d'écran de la sortie console du test du modèle sur une carte" caption="Figure 8. Test du modèle" %}

**Interprétation des résultats**

Carte 1.00 : le modèle attribue un score de confiance de 1,00 à la catégorie Carte.

Tableau 0.00, Photo 0.00, Dessin 0.00 : Aucune probabilité n’est attribuée aux autres catégories.

43,6 ms : Temps nécessaire pour traiter l’image.

---

## 4 Application du modèle à des EPUB téléchargés

Nous procédons à l’application du modèle créé sur les EPUB téléchargés à l'aide d'un script Python.

### 4.1 Le projet Gutenberg

Dans le cadre de ce tutoriel, nous testerons le contenu de deux livres d'histoire disponibles au format EPUB au sein du projet Gutenberg.

- [Cassell's History of England, Vol. 1](https://www.gutenberg.org/ebooks/48451)

- [Cassell's History of England, Vol. 2](https://www.gutenberg.org/ebooks/50710)

Ces deux volumes retracent l’histoire de l’Angleterre, de l’invasion romaine jusqu’à la dynastie des Tudors.

Le [projet Gutenberg](https://www.gutenberg.org) est une bibliothèque virtuelle qui propose des milliers de livres électroniques, disponibles dans divers formats (EPUB, TXT, HTML). Ces ouvrages sont numérisés à partir de livres physiques, appartenant principalement au domaine public.

### 4.2 Le format EPUB : structure et intérêt

Un fichier EPUB est en réalité un fichier ZIP contenant :

- du texte : fichiers .xhtml
- des feuilles de style : .css
- des métadonnées : content.opf
- des images : .png, .jpg, .jpeg, .svg, etc.

Les images sont généralement situées dans le répertoire OEBPS.

**Commande d’extraction :**

Les commandes suivantes permettent de télécharger les fichiers EPUB et d'en extraire les images de test.

```bash
wget https://www.gutenberg.org/ebooks/48451.epub3.images

unzip 48451.epub3.images

wget https://www.gutenberg.org/ebooks/50710.epub3.images

unzip 50710.epub3.images
```

Après extraction, les répertoires OEBPS propres à chaque EPUB contiendront au total 1 862 images.
Ces images serviront de base pour la classification.

### 4.3 Le script Python pour le traitement

Le script final permet :

- de parcourir les dossiers EPUB
- d’identifier les images
- de les classer automatiquement
- d’enregistrer les résultats dans un fichier JSON

Chaque image est associée à :

- son chemin
- sa catégorie prédite
- un score de confiance

```python
from ultralytics import YOLO
import os
import json

def main():

    liste_data = []
    dossier_epub = "./Epub/"
    dossier_json = "./Json/"
    repertoires_epub = [os.path.join(dossier_epub, dir, "OEBPS") for dir in os.listdir(dossier_epub)]
    model = YOLO("./runs/classify/train7/weights/best.pt")
    for repertoire_epub in repertoires_epub:
        fichiers_jpg = [os.path.join(repertoire_epub, f) for f in os.listdir(repertoire_epub) if f.lower().endswith('.jpg')]
        if len(fichiers_jpg) > 0:
            results = model(fichiers_jpg, stream=True)
            for result in results:
                dict_data = {}
                dict_data["name"] = result.path
                dict_data["result"] = result.summary()[0]
                liste_data.append(dict_data)

    os.makedirs(dossier_json, exist_ok=True)

    with open(os.path.join(dossier_json, "data.json"), "w") as f:
        json.dump(liste_data, f, indent=4)


if __name__ == "__main__":
    main()
```

La structure des résultats :

Le fichier JSON généré contient pour chaque image :

```
    {
        "name": "./Epub/48451.epub3/OEBPS/6209511897615429371_i_106big.jpg",
        "result": {
            "name": "Carte",
            "class": 0,
            "confidence": 1.0
        }
    },
```

### 4.4 Les résultats

Voici les résultats avec un score de confiance de 1,0 pour la catégorie Tableau :

{% include figure.html filename="fr-or-creer-modele-classification-images-09.png" alt="Capture d'écran des miniatures de quelques images classées comme Tableau avec un score égal à 1" caption="Figure 9. Les résultats pour la catégorie Tableau" %}

Voici les résultats avec un score de confiance de 1,0 pour la catégorie Carte géographique :

{% include figure.html filename="fr-or-creer-modele-classification-images-10.png" alt="Capture d'écran des miniatures de quelques images classées comme Carte avec un score égal à 1" caption="Figure 10. Les résultats pour la catégorie Carte" %}

Les résultats contiennent également des images mal classées. Elles ont un score de confiance élevé malgré une classification incorrecte. Ces images permettent d'identifier les cas difficiles et peuvent dans un deuxième temps servir à la constitution d'une nouvelle version des données d'apprentissage.


### 4.5 Limites et biais liés au jeu de données d’apprentissage

Les images utilisées pour l’entraînement proviennent majoritairement de Wikimedia Commons et sont sélectionnées à partir de bases patrimoniales (Joconde, Mérimée, œuvres d’art documentées).

Ce choix introduit plusieurs biais :

- Les dessins proviennent d'un nombre limité d'artistes.

- Les tableaux correspondent majoritairement à des œuvres muséales françaises.

- Les photographies représentent surtout du patrimoine architectural.

- Les cartes géographiques issues de Wikimedia Commons sont souvent bien contrastées, centrées et propres. Les cartes géographiques anciennes, manuscrites ou fortement décorées peuvent être sous-représentées.

Le modèle apprend donc des éléments visuels propres aux sources utilisées, et non une définition abstraite et universelle des catégories. Un score de confiance élevé indique que l’image ressemble fortement aux exemples appris, mais ne garantit pas l’exactitude de la classification.

## 5 Conclusion

Pour améliorer les performances de notre modèle, il est nécessaire d’enrichir le jeu de données :

- en intégrant davantage d’exemples variés.

- en prenant en compte les cas limites et en intégrant les les erreurs de classification détectés dans la première version du modèle afin d'en améliorer les performances.

Des jeux de données complémentaires peuvent être utilisés comme [Gallica : jeu d'images annotées pour la classification](https://api.bnf.fr/fr/node/181) ou [Nubis – Carte (Version 1). https://doi.org/10.34847/NKL.9E96QOS6](https://doi.org/10.34847/NKL.9E96QOS6).

Une version améliorée du modèle est disponible à cette [URL](https://huggingface.co/LaMOP/Yolo26n-Cls-Carte).

Ce modèle a ensuite été utilisé pour analyser un corpus important de fichiers EPUB issus du projet Kiwix [World History (Europe, Asia, Africa, Australia)](https://browse.library.kiwix.org/viewer#gutenberg_en_lcc-d_2025-12/Home).
Les résultats de cette analyse ont été enrichis de métadonnées et publiés dans un [entrepôt de données](https://nakala.fr/10.34847/nkl.264878np).
