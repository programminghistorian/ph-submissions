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

{% include toc.html %}

Ce tutoriel présente une méthode simple et efficace pour identifier des cartes géographiques dans différents corpus d’images. L’objectif est d’enrichir les sources d’un projet comme par exemple le projet TOPAMA.

Pour suivre ce tutoriel, il est recommandé de disposer d’une carte graphique (GPU) avec au moins 8 Go de VRAM.

Le projet TOPAMA est un Système d’Information Géographique couvrant l’Europe occidentale et l’Afrique du Nord entre l’Antiquité et le Moyen Âge. Il permet de localiser et d’analyser des données historiques (évêchés, monastères, territoires, etc.). Il propose plus d’une centaine de cartes géographiques au format ouvert, modifiables par tous. Ces cartes géographiques sont en partie issues de la vectorisation de grandes séries documentaires, comme le livre *Géographie de la Gaule au VIe siècle*, écrit par Auguste Longnon (1878). Toutes les données intégrées font l’objet d’une validation scientifique rigoureuse.

Pour parvenir à cette méthode, nous développerons un modèle prototype de classification d’images capable de distinguer quatre catégories visuelles (Cartes, Dessins, Photographies et Tableaux). Ce modèle aura donc pour objectif de réaliser une présélection des données en vue de leur possible intégration au projet TOPAMA.


## 1. Le projet Gutenberg

Dans le cadre de ce tutoriel, nous testerons le contenu de deux livres d'histoire disponible sous le format EPUB au sein du projet Gutenberg.

* [Cassell's History of England, Vol. 1](https://www.gutenberg.org/ebooks/48451)

* [Cassell's History of England, Vol. 2](https://www.gutenberg.org/ebooks/50710)

Ces deux premiers volumes retracent l’histoire de l’Angleterre, de l’invasion romaine jusqu’à la dynastie des Tudors.

Le [projet Gutenberg](https://www.gutenberg.org) est une bibliothèque virtuelle qui propose des milliers de livres électroniques, disponibles dans divers formats (EPUB, TXT, HTML). Ces ouvrages sont numérisées à partir de livres physiques, appartenant principalement au domaine public.

### 1.1 Le format EPUB : structure et intérêt

Un fichier EPUB est en réalité un fichier ZIP contenant :

- du texte : fichiers .xhtml

- des feuilles de style : .css

- des métadonnées : content.opf

- des images : .png, .jpg, .jpeg, .svg, etc.

Les images sont généralement situées dans le répertoire OEBPS.

**Commande d’extraction :**

```bash
wget https://www.gutenberg.org/ebooks/48451.epub3.images

unzip 48451.epub3.images

wget https://www.gutenberg.org/ebooks/50710.epub3.images

unzip 50710.epub3.images
```
Après extraction, le répertoire contiendra 1862 images au format JPG situées dans le répertoire OEBPS.
Ces images serviront de base pour la classification.

---

## 2. Création du modèle de classification

L’objectif est de développer un modèle capable de classifier automatiquement les images extraites des EPUB.

Pour chaque image, le modèle attribue une probabilité d’appartenance à chaque catégorie :

* carte géographique
* dessin
* photographie
* tableau

Cela permet d’identifier rapidement les cartes géographiques dans un grand volume d’images.

### 2.1 Installation du framework Yolo

Pour entraîner et déployer notre modèle, nous utiliserons Ultralytics YOLOv26, un framework d’intelligence artificielle modulaire et performant, spécialisé dans les tâches de vision par ordinateur.

Bien que le framework YOLO puisse fonctionner sur des configurations modestes, l’utilisation d’une carte graphique (GPU) est fortement recommandée pour accélérer les phases d’entraînement du modèle. Cependant, il est tout à fait possible de réaliser ce tutoriel avec un CPU standard, même si les temps de calcul seront plus longs.


Ultralytics YOLOv26 nécessite un environnement Python 3.8 ou supérieur, ainsi que la bibliothèque PyTorch 1.8 ou ultérieure pour fonctionner de manière optimale.

Étapes pour configurer l’environnement :

#### 1. Création d’un environnement virtuel Python (recommandé pour isoler les dépendances) :

```python
python3 -m venv .
```

#### 2. Activation de l’environnement :

```python
source bin/activate .
```

#### 3. Installation de la librairie Ultralytics :

```python
pip install ultralytics
```

### 2.2 Validation de l'installation et test du modèle par défaut

Les modèles de classification sont entraînées sur le corpus [ImageNet](https://www.image-net.org/index.php)
Il est possible de tester le modèle de classification disponible par défaut.

Pour vérifier que l'installation s'est déroulée correctement, nous allons utiliser le modèle de classification par défaut, pré-entraîné sur le corpus [ImageNet](https://www.image-net.org/index.php). Ce modèle peut reconnaître une large variété de catégories d'images.

**Exécution d'un test de démonstration**

```bash
yolo classify predict model=yolo26n-cls.pt source='https://ultralytics.com/images/bus.jpg'
```

Le modèle YOLO attribue des scores de probabilité pour chaque catégorie possible. Par exemple, pour l'image du [bus](https://ultralytics.com/images/bus.jpg), le modèle retourne les informations suivantes :

{% include figure.html filename="fr-or-creer-modele-classification-images-01.png" alt="Sortie dans une console de la commande test proposée pour la librairie Yolo avec l'analyse d'une photo comprenant un bus." caption="Figure 1. Test de la librairie Yolo" %}

0.57 pour la catégorie mini-bus

0.34 pour la catégorie police_van

Ces scores indiquent la confiance du modèle dans sa prédiction. Plus le score est proche de 1, plus le modèle est certain que l'image appartient à cette catégorie.

---

## 3. Constitution des données d'apprentissage

Pour entraîner notre modèle de classification, la deuxième étape consiste à construire un corpus d’images représentatif et équilibré.
Nous nous appuierons sur Wikimedia Commons pour plusieurs raisons :

Wikimedia Commons est une médiathèque mettant à disposition des images de qualité, en haute résolution et bien documentée.
Le contenu de Wikimedia Commons est très diversifié et son accès est gratuit.
Wikimedia permet de télécharger aisément un échantillon significatif d'images pour chaque catégorie afin de construire un modèle simplifié.

### 3.1 Introduction à Wikidata

Wikidata est une base de connaissances libre et collaborative qui permet d'interroger des données structurées
grâce au langage SPARQL. A l'aide de différentes requêtes, nous allons utiliser WIkidata pour récupérer des listes d’images correspondant à nos quatre catégories.

Ces images sont hébergées sur Wikimedia Commons et librement accessibles.

###3.2. Exécution de requêtes SPARQL et téléchargement des résultats

À partir des requêtes SPARQL, nous obtenons des fichiers CSV contenant des liens vers les images.

Pour chaque catégorie, nous sélectionnons aléatoirement 500 images afin de constituer un jeu de données équilibré.

Les images sont ensuite téléchargées dans des dossiers séparés (Dessin, Tableau, Photo, Carte).

Voici les étapes à suivre :

1. Dans un premier temps, il faut ouvrir [l'interface de requête SPARQL de Wikidata](https://query.wikidata.org/) dans son navigateur.
2. Exécuter les différentes requêtes SPARQL fournies ci-dessous pour chaque catégorie.
3. Télécharger les résultat des requêtes au format CSV.


#### 3.2.1 Constitution des données d'apprentissage pour la catégorie Tableau

Pour constituer cette catégorie, nous nous appuierons sur la [base de données Joconde](https://www.culture.gouv.fr/espace-documentation/bases-de-donnees/Fiches-bases-de-donnees/Joconde-catalogue-collectif-des-collections-des-musees-de-France), gérée par le ministère de la Culture français.
Joconde est un catalogue collectif qui référence les collections des musées français, dont des peintures. Cependant, il introduit un biais dans le modèle, puisque les données proviennent majoritairement d'oeuvres françaises.

**Requête SPARQL pour extraire des peintures référencées dans la base Joconde**

```sparql
SELECT ?image  WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],mul,en". }
  ?paintings wdt:P18 ?image;  # Récupère l'URL de l'image"
    wdt:P347 ?joconde. # Filtre : œuvres avec un identifiant de la base Joconde
  ?paintings wdt:P31 wd:Q3305213. # Filtre : entités de type "peinture"
  FILTER regex(STR(?image), "\\.jpg$")

}
LIMIT 1000
```
Exemple de la requête

{% include figure.html filename="fr-or-creer-modele-classification-images-02.png" alt="Requête en Sparql executée sur l'interface Web de Wikidata permettant d'interroger les données de la base Joconde présent sur Wikidata" caption="Figure 2. Requête Wikidata sur la base de données Joconde" %}

#### 3.2.2 Constitution des données d’apprentissage pour la catégorie Dessin

Pour constituer cette catégorie, nous avons choisi de réutiliser les numérisations des œuvres de quelques artistes. Cette contrainte limite l'apprentissage du modèle à ses seuls artistes.

**Requête SPARQL pour extraire un listing des dessins de plusieurs auteurs**

Cette requête SPARQL permet de récupérer les images des œuvres de Sawrey Gilpin, Fúlvia Gonçalves, James Ensor, Johan Tobias Sergel, Thomas Hastings, Robert Smirke, John Flaxman, Jean-Louis Forain, Jean-Auguste Dominique Ingres, Edme Bouchardon disponibles sur Wikimedia Commons.

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


####3.2.3 Constitution des des données d'apprentissage pour la catégorie Photo

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


#### 3.2.4 Constitution des données d’apprentissage pour la catégorie Carte géographique

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

### 3.3 Téléchargement des images depuis Wikimedia Commons

À l’issue des différentes requêtes SPARQL, nous disposons de quatre fichiers CSV contenant les liens vers les images :

query_dessin.csv (Dessins)

query_tableau.csv (Tableaux)

query_photo.csv (Photographies)

query_carte.csv (Cartes géographiques)

####3.3.1 Sélection aléatoire et préparation des fichiers

Pour chaque catégorie, nous allons sélectionner aléatoirement 500 images afin de constituer un corpus équilibré et représentatif.

```bash
shuf -n 500 query_dessin.csv > dessin_final.csv
shuf -n 500 query_tableau.csv > tableau_final.csv
shuf -n 500 query_photo.csv > photo_final.csv
```
Les cartes étant peu nombreuses, leur sélection doit être manuelle.

#### 3.3.2 Téléchargement respectueux des règles de Wikimedia

Pour télécharger les images, nous devons respecter la politique d’utilisation des robots de Wikimedia (Robot Policy), qui impose :

Une limitation de la bande passante
Un délai entre chaque téléchargement pour éviter de surcharger les serveurs.

Nous utiliserons la commande wget avec des paramètres adaptés pour respecter ces contraintes :

```bash
wget -i dessin_final.csv -P Dessin/ -nc --limit-rate=1M --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" -w 15
wget -i tableau_final.csv -P Tableau/ -nc --limit-rate=1M --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" -w 15
wget -i photo_final.csv -P Photo/ -nc --limit-rate=1M --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" -w 15
wget -i query_carte.csv -P Carte/ -nc --limit-rate=1M --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" -w 15
```

Explications des options :

* -i fichier.csv : Spécifie le fichier contenant les URLs à télécharger.
* -P Dossier/ : Enregistre les images dans un dossier dédié (ex: Dessins/, Tableaux/).
* -nc : Évite de retélécharger les fichiers déjà présents (no-clobber).
* --limit-rate=1M : Limite la bande passante à 1 Mo/s.
* -w 15 : Attend 15 secondes entre chaque téléchargement.
* --user-agent : Simule un navigateur web pour éviter d’être bloqué par les serveurs.


Un exemple des tableaux téléchargés

{% include figure.html filename="fr-or-creer-modele-classification-images-03.png" alt="Une capture d'écran de quelques miniatures des tableaux téléchargés présent dans le dossier" caption="Figure 3. Un exemple des tableaux téléchargés" %}

Un exemple des dessins téléchargés

{% include figure.html filename="fr-or-creer-modele-classification-images-04.png" alt="Une capture d'écran de quelques miniatures des dessins téléchargés présent dans le dossier" caption="Figure 4. Un exemple des dessins téléchargés" %}


Un exemple des photos téléchargés

{% include figure.html filename="fr-or-creer-modele-classification-images-05.png" alt="Une capture d'écran de quelques miniatures des photos téléchargés présent dans le dossier" caption="Figure 5. Un exemple des photos téléchargés" %}

Un exemple des cartes géographiques téléchargées

{% include figure.html filename="fr-or-creer-modele-classification-images-06.png" alt="Une capture d'écran de quelques miniatures des cartes téléchargées présent dans le dossier" caption="Figure 6. Un exemple des cartes téléchargées" %}


#### 3.3.3 Organisation des données

À la fin de cette étape, vous obtiendrez une structure de dossiers claire :

```
Dossier_principal/
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

## 4. Création de notre modèle à partir des images issues de Wikimedia Commons

### 4.1. Préparation et organisation du dataset

Pour entraîner efficacement notre modèle de classification, il est essentiel d’organiser les données selon une structure séparant les images destinées à l’entraînement de celles réservées à la validation
```
Yolo/
├── train/               # Dossier pour les données d'entraînement
│   ├── Photo/           
│   ├── Carte/           
│   ├── Tableau/       
│   └── Dessin/         
└── val/                 # Dossier pour les données de validation
    ├── Photo/          
    ├── Carte/           
    ├── Tableau/       
    └── Dessin/         
```

Le dossier **train** et ses sous dossiers contiennent les images utilisées pour entraîner le modèle.
Le dossier **val** et ses sous dossiers contiennent les images utilisées pour valider les performances du modèle après l’entraînement.

##### 4.1.1. Installation de la librairie Scikit-learn :

```python
pip install scikit-learn
```
##### 4.1.2. Construction du dataset :

Pour automatiser la répartition aléatoire des images entre les dossiers d'entraînement (train/) et de validation (val/), nous allons utiliser le script Python suivant :

```python
import os
import shutil
from pathlib import Path
from sklearn.model_selection import train_test_split

def create_directories(base_destination: str, directory_name: str) -> None:
    """
    Crée les répertoires 'train' et 'val' pour une classe donnée dans le chemin de destination.

    Args:
        base_destination (str): Chemin de base où les répertoires 'train' et 'val' seront créés.
        directory_name (str): Nom du répertoire de la classe (ex: 'chat', 'chien').

    Returns:
        None: La fonction crée les répertoires mais ne retourne rien.

    Example:
        >>> create_directories("./Yolo/", "chat")
        # Crée ./Yolo/train/chat/ et ./Yolo/val/chat/ si ils n'existent pas.
    """
    train_dir = Path(base_destination) / "train" / directory_name
    val_dir = Path(base_destination) / "val" / directory_name

    train_dir.mkdir(parents=True, exist_ok=True)
    val_dir.mkdir(parents=True, exist_ok=True)

def copy_images(
    source_base_path: str,
    destination_base_path: str,
    directory_name: str,
    test_size: float = 0.1,
    random_state: int = 42,
) -> None:
    """
    Copie les images d'une classe source vers les répertoires 'train' et 'val' de destination,
    en les répartissant aléatoirement selon un ratio donné.

    Args:
        source_base_path (str): Chemin de base contenant les images sources organisées par classe.
        destination_base_path (str): Chemin de base où les images seront copiées.
        directory_name (str): Nom du répertoire de la classe à traiter.
        test_size (float, optional): Proportion d'images à allouer au répertoire 'val'. Par défaut, 0.1.
        random_state (int, optional): Graine pour la reproductibilité de la séparation aléatoire. Par défaut, 42.

    Returns:
        None: La fonction copie les fichiers mais ne retourne rien.

    Example:
        >>> copy_images("./Data/", "./Yolo/", "chat", test_size=0.2)
        # Copie 80% des images dans ./Yolo/train/chat/ et 20% dans ./Yolo/val/chat/.
    """
    source_path = Path(source_base_path) / directory_name
    train_destination = Path(destination_base_path) / "train" / directory_name
    val_destination = Path(destination_base_path) / "val" / directory_name

    # Récupère tous les fichiers .jpg récursivement
    image_files = list(source_path.rglob("*.jpg"))

    # Séparation aléatoire des fichiers
    train_files, val_files = train_test_split(
        image_files, test_size=test_size, random_state=random_state
    )

    # Copie des fichiers
    for image_path in train_files:
        shutil.copy(image_path, train_destination)

    for image_path in val_files:
        shutil.copy(image_path, val_destination)


def main():
    source_base_path = "./Data/"
    destination_base_path = "./Yolo/"

    # Liste des répertoires dans le chemin source
    directories = [
        name
        for name in os.listdir(source_base_path)
        if (Path(source_base_path) / name).is_dir()
    ]

    for directory in directories:
        create_directories(destination_base_path, directory)
        copy_images(source_base_path, destination_base_path, directory)

if __name__ == "__main__":

    main()

```


### 4.2. Entraînement du modèle YOLOv26

Nous lançons en ligne de commande du fine tuning du modèle de classification yolo26n-cls.pt.


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

mode=train task=classify : Nous entraînons un modèle pour une tâche de classification.

model=yolo26n-cls.pt : Spécifie le modèle de base utilisé pour le fine-tuning.

data=Yolo/ : Chemin vers le dossier contenant les données organisées selon la structure définie précédemment.

epochs=200 : Nombre d’itérations sur l’ensemble des données pour affiner le modèle.

imgsz=640 : Taille des images en entrée (640x640 pixels), adaptée pour équilibrer précision et performance.

batch=-1 : Utilise la taille de lot maximale possible en fonction de la mémoire disponible sur votre machine.

patience=100 : Nombre d’époques à attendre avant d’arrêter l’entraînement si aucune amélioration n’est détectée (mécanisme d’early stopping).

workers=8 : Nombre de processus parallèles utilisés pour charger les données, optimisant ainsi la vitesse d’entraînement.


---

{% include figure.html filename="fr-or-creer-modele-classification-images-07.png" alt="Capture d'écran de la sortie console de la fin de l'entraînement du modèle" caption="Figure 7. Fin de l'entraînement du modèle" %}

Le meilleur modèle est le /runs/classify/train6/weights/best.pt

L'entraînement, effectué sur une carte vidéo (NVIDIA RTX 2060 SUPER, 8 Go de VRAM), a requis 121 epochs et 2,5 heures de calcul.

### 4.3. Test du modèle entraîné

Une fois l’entraînement terminé, nous testons les performances du modèle sur une carte géographique représentative : une [carte du monde](https://magrit.cnrs.fr/example_map_europe_1.png).

```bash
yolo classify predict \
    model=runs/classify/train6/weights/best.pt \
    source='https://magrit.cnrs.fr/example_map_europe_1.png'
```
Réponse:

{% include figure.html filename="fr-or-creer-modele-classification-images-08.png" alt="Capture d'écran de la sortie console du test du modèle sur une carte" caption="Figure 8. Test du modèle" %}

**Interprétation des résultats**

Carte 1.00 : Le modèle est certain à 100% que l’image est une carte géographique.

Tableau 0.00, Photo 0.00, Dessin 0.00 : Aucune probabilité n’est attribuée aux autres catégories.

43.6ms : Temps nécessaire pour traiter l’image.

---

## 5. Application du modèle aux Epubs téléchargés

### 5.1 Le script Python pour le traitement

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
    dossier_epub = "./Data/Epub/"
    repertoires_epub = [os.path.join(dossier_epub, dir, "OEBPS") for dir in os.listdir(dossier_epub)]
    model = YOLO("./Model/Yolo26n-Cls-Carte.pt")
    for repertoire_epub in repertoires_epub:
        fichiers_jpg = [os.path.join(repertoire_epub, f) for f in os.listdir(repertoire_epub) if f.lower().endswith('.jpg')]
        if len(fichiers_jpg) > 0:
            results = model(fichiers_jpg, stream=True)
            for result in results:
                dict_data = {}
                dict_data["name"] = result.path
                dict_data["result"] = result.summary()[0]
                liste_data.append(dict_data)

    with open("Data/Json/data.json", "w") as f:
        json.dump(liste_data, f, indent=4)


if __name__ == "__main__":
    main()
```

**Structure des résultats:**

Le fichier JSON généré contient pour chaque image :
```
    {
        "name": "./Data/Epub/48451.epub3/OEBPS/6209511897615429371_i_106big.jpg",
        "result": {
            "name": "Carte",
            "class": 0,
            "confidence": 1.0
        }
    },


```

### 5.2 Les résultats

Voici les résultats avec un score de confiance de 1.0 pour la catégorie Tableau:

{% include figure.html filename="fr-or-creer-modele-classification-images-09.png" alt="Capture d'écran des miniatures de quelques images classées comment Tableau avec un score égale à 1" caption="Figure 9. Les résultats pour la catégorie Tableau" %}

Voici les résultats avec un score de confiance de 1.0 pour la catégorie Carte Géographique:

{% include figure.html filename="fr-or-creer-modele-classification-images-10.png" alt="Capture d'écran des miniatures de quelques images classées comment Carte avec un score égale à 1" caption="Figure 10. Les résultats pour la catégorie Carte" %}

On observe la présence de faux positifs dans les résultats du modèle. Certaines images sont donc mal classées malgré une forte confiance de prédiction.

**Limites et biais du modèle**

Le modèle présenté dans ce tutoriel est un prototype expérimental.

Plusieurs limites importantes doivent être prises en compte.

**Biais liés au jeu de données d’apprentissage**

Les images utilisées pour l’entraînement proviennent majoritairement de Wikimedia Commons et sont sélectionnées à partir de bases patrimoniales (Joconde, Mérimée, œuvres d’art documentées).

Ce choix introduit plusieurs biais :

* Les dessins proviennent d'un nombre limité d'artistes.

* Les tableaux correspondent majoritairement à des œuvres muséales françaises

* Les photographies représentent surtout du patrimoine architectural.

* Les cartes géographiques issues de Commons Wikimedia sont souvent bien contrastées, centrées et propres. Les cartes géographiques anciennes, manuscrites ou fortement décorées peuvent être sous-représentées.

Le modèle apprend donc des éléments visuels propres aux sources utilisées, et non une définition abstraite et universelle des catégories. Un score de confiance élevé indique que l’image ressemble fortement aux exemples appris, mais ne garantit pas l’exactitude de la classification.

## 6. Conclusion:

Pour améliorer les performances de notre modèle, il est nécessaire d’enrichir le jeu de données, :

* intégrant davantage d’exemples variés.

* ajoutant des cas difficiles et des faux positifs.

Des jeux de données complémentaires peuvent être utilisés comme [Gallica : jeu d'images annotées pour la classification](https://api.bnf.fr/fr/node/181) ou [Nubis – Carte (Version 1) [Data set]. https://doi.org/10.34847/NKL.9E96QOS6.](https://doi.org/10.34847/NKL.9E96QOS6)

Une version améliorée du modèle est disponible à cet [Url](https://huggingface.co/LaMOP/Yolo26n-Cls-Carte).

Ce modèle a ensuite été utilisé pour analyser un corpus important de fichiers EPUB issus de du projet Kiwki [World History (Europe, Asia, Africa, Australia)]([https://browse.library.kiwix.org/viewer#gutenberg_en_lcc-d_2025-12/Home]).
Les résultats de cette analyse ont été enrichis de métadonnées et publiés dans un [entrepôts de données](https://nakala.fr/10.34847/nkl.264878np).
