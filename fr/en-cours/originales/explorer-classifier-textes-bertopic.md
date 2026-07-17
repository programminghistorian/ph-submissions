---
title: "Explorer et classifier les thèmes d’un corpus de textes avec BERTopic et Python"
slug: explorer-classifier-textes-bertopic
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Axel Morin
- Émilien Schultz
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/703
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction 

### Objectifs de la leçon 

- Connaître le principe du topic modelling, les cas d'application et les méthodes existantes.
- S'approprier les concepts structurants de BERTopic et identifier les ressources disponibles.
- Utiliser les commandes de bases et implémenter son premier BERTopic 
- Identifier les limites de l'outil ainsi que les bonnes pratiques pour faciliter la reproductibilité.

### Prérequis 

Ce tutoriel requiert d'avoir une certaine aisance avec Python. Par exemple, nous attendons des lecteur.ice.s se savoir: 

- Initialiser son environnement et installer des librairies.
- Utiliser les syntaxes de base de Python (rédaction de fonctions, loupes "for" et conditions).
- Réaliser les manipulations basiques avec les tableaux de données avec Pandas (ouvrir un fichier, création, supression de colonnes)

Ce tutoriel aborde aussi des notions de Natural Language Processing (NLP) et de Machine Learning. Dans ce tutoriel, nous présentons certains concepts dans les grandes lignes mais nous ne rentrons pas dans les détails. Nous redirigeons cependant vers des ressources qui font ce travail. 

Pour une remise à niveau, vous pouvez consulter les ressources suivantes: 

- [Understanding and Creating Word Embeddings](https://programminghistorian.org/en/lessons/understanding-creating-word-embeddings) (en anglais)
- [“The illustrated Transformer” by Jay Alammar](https://jalammar.github.io/illustrated-transformer/) (en anglais)
- [A visual explanation of general concepts behind LLMs by 3Blue1Brown](https://www.youtube.com/watch?v=wjZofJX0v4M) (en anglais)

### Matériel disponible et environnement virtuel 

Dans le cadre de ce tutoriel, nous mettons à disposition plusieurs fichiers sur la plateforme [Zenodo](https://zenodo.org/records/17936091). Vous y trouverez: 

- Le jeux de données complet et nettoyé (700 Mo) : La procédure de nettoyage de données est renseignée [ici (written in English)](https://css-polytechnique.github.io/css-ipp-materials/pages/techy-notes.html#curations-of-the-original-dataset).
- Un extrait stratitifié du jeu de données (30 Mo) : Nous avons tiré 500 lignes par années; en tout, ce jeu de données contient 6500 lignes.
- Un ensemble de jeux de plongements : Nous proposons 9 jeux de plongements pour 3 modèles différents ([Alibaba-NLP/gte-multilingual-base](https://huggingface.co/Alibaba-NLP/gte-multilingual-base), [sentence-transformers/all-MiniLM-L6-v2](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2), [Qwen/Qwen3-0.6B](https://huggingface.co/Qwen/Qwen3-0.6B)), deux langues (anglais et français) et deux techniques de génération différentes (pipeline HuggingFace ou SBERT). Ces jeux de plongements permettent d'étudier rapidement l'impact du changement de modèle sur les résultats du topic model.

<div class="alert alert-info">
Ces données ont été rendues disponibles dans le cadre de la publication de ce tutoriel <a href='https://css-polytechnique.github.io/css-ipp-materials/pages/bertopic-tutorial.html'>The General Inquirer in the time of LLMs: a BERTopic tutorial</a> en anglais, dont le présent tutoriel est une adaptation.
</div>

Pour préparer votre espace Python, nous proposons d'utiliser les versions suivantes: 

```txt
bertopic==0.17.3
datasets==4.3.0
hdbscan==0.8.40
numpy==2.3.5
pandas==2.3.3
plotly==6.3.1
scikit_learn==1.8.0
stopwordsiso==0.6.1
transformers==4.52.4
umap_learn==0.5.7
```

## Le topic modelling, une tâche répendue en sciences sociales

Il est crucial d'avoir une compréhension générale du corpus de texte que nous étudions: Existe-t-il une manière de regrouper des documents ? Que représentent ces groupes ? Comment cette organisation en groupe structure t-elle mon corpus ? Ou encore, quelles sont les différences majeures entre deux groupes ? Pour répondre à ces questions, un.e chercheur.euse en sciences sociales peut utiliser des techniques de **topic modelling**.

Le **topic modelling** est une famille d'algorithmes appartenant au domaine du NLP et visant à extraire les thèmes latents qui structurent un corpus de textes. <br/>
Le **Natural Language Processing** est un domaine issu des sciences informatiques et qui vise à analyser des données textuelles. Parmis les nombreuses tâches de NLP, on peut mentionner la génération de texte, la classification de textes, ou bien le topic modelling. 

Pour illustrer les tâches de topic modelling, on peut mentionner le travail de Jockers & Mimno (2013) qui ont cherché à extraire les thèmes centraux de la littérature anglaise du XIXè siècle, ou bien Bizel-Bizellot et al. (2024) qui ont analysé les conditions de transmission du COVID-19 grâce à des réponses ouvertes d'un sondage. On identifie trois phases pour lesquelles on peut avoir recours à ces outils : 

- Exploratoire : Avoir une vision générale du corpus, identifier les outliers, anticiper le nettoyage et filtrage d'un corpus.
- En cours d'analyse : Sélectionner une diversité de sources, identifier des grands axes pour assister une tâche d'annotation.
- Confirmatoire : Mettre à l'épreuve un cadre d'analyse.

Pendant longtemps, la LDA[^1] a été la technique la plus utilisée pour ce genre de tâche. Cette méthode cherche à représenter un document comme une imbrication de séquences relevant de thèmes différents.

BERTopic se veut comme la mise à jour de ces techniques en mettant à profit les modèles de langue développés après 2017 et qui ont donné naissance à l'ensemble des IA génératives si répandues aujourd'hui.<br/>
Le projet BERTopic regroupe un [preprint](https://arxiv.org/pdf/2203.05794) mais aussi un dépot [Github](https://github.com/MaartenGr/BERTopic), la librairie bertopic publiée sur [Pip](https://pypi.org/project/bertopic/); l'outil développé s'ancre à la fois dans la recherche et la communauté open-source; L'outil tire parti des derniers concepts de la recherche en NLP et Machine Learning et propose une syntaxe simple et modulaire pour garantir la facilité d'utilisation, la mise en place rapide et ce, de manière à s'adapter aisément aux besoins spécifiques. 

Le fort engouement autour de cet outil a donné naissance à une communauté d'utilisateur.ices qui utilisent et proposent des formations à cet outil, comme le présent tutoriel. 

Dans ce tutoriel nous présentons l'algorithme dans les grandes lignes, puis nous illustrons les principales commandes de la librairie.

## Comprendre chaque étape de la pipeline 


La pipeline de BERTopic est relativement simple. En entrée, on renseigne un certain nombre de documents et en sortie, on obtient un certains nombre de groupes (les _topics_) définis par des documents constitutifs du groupe, ainsi que des mots clefs spécifiques. 

{% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-01.jpg" alt="Visual description of figure image" caption="Figure 1. Les entrées sorties de la pipeline BERTopic." %}

La Tableau 1 est un exemple de résultat sous forme de tableau récapitulatif; la Tableau 1 est la représentation visuelle de ces _topics_, leur taille et agencement les uns par rapport aux autres. Dans cet exemple nous avons donné au modèle des résumés de thèses défendues en France. Le résultat du topic model permet de repérer les grandes disciplines comme la Physique, la Biologie ou les Sciences Politiques. 

<div class="table-wrapper" markdown="block">

| Topic | Count | Name | Representation |
|-------|------:|------|----------------|
| 0 | 1037 | Sciences sociales | étude recherche analyse thèse travail siècle politique histoire partie processus |
| 1 | 795 | Médecine et Santé | cellules expression rôle montré in résultats patients gènes cellulaire étude |
| 2 | 707 | Sciences de l'ingénieur, Expérimentation et Simulation | modèle méthode étude thèse résultats comportement modèles numérique temps paramètres |
| 3 | 634 | Analyse de données et Mathématiques | données thèse systèmes système problème modèle proposons temps approche méthodes |
| 4 | 464 | Physique | propriétés synthèse étude matériaux surface température nanoparticules réaction thèse permis |
| 5 | 135 | Droit | droit droits juridique union monétaire politique européenne juge international économique |
| 6 | 13 | Biochimie | détection aptamère adn sers biocapteurs capteur surface adénosine biocapteur pd |

</div>

**Tableau 1**: Topic information of the French theses after tuning the topic model.

{% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-02.jpg" alt="Visual description of figure image" caption="Figure 2. Représentation 2D d'un topic model." %}

Dans cette section, nous nous attardons quelques temps pour comprendre comment sont produits les _topics_. 

La pipeline de BERTopic peut être décrite en 3 grandes étapes: 

1. Transformer les documents (textes) en vecteurs mathématiques. Il s'agit de générer des plongements (_embeddings_) grâce à un modèle de langage.
2. Regrouper les plongements en groupes de sujets latents dans notre corpus.
3. Pour chaque groupe, identifier les mots clefs qui représentent le mieux la spécificité de chaque _topic_.

Revenons plus précisément sur chaque étape et identifions les concepts clefs sur lesquelles se basent BERTopic.

### 1. Transformer les documents en vecteurs mathématiques 

Pour que la machine puisse manipuler des documents textuels, nous avons besoin de transformer les textes en des vecteurs de plusieurs centaines de dimensions : des **plongements** (_embeddings_). Ces plongements sont obtenus grâce à un modèle de languages entraînés à reconnaître des motifs dans les textes observés et à distinguer des textes qui sont sémantiquements proches, de textes qui ne le sont pas. La force de ces modèles est d'encapsuler énormément d'informations présentes dans le texte dans un vecteur (représentation dense) 

{% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-03.png" alt="Visual description of figure image" caption="Figure 3. Schéma explicatif des modèles de plongements." %}

Pour obtenir ces plongements nous utilisons la bibliothèque [Sentence Transformers (ou **SBERT**)](https://sbert.net/) qui permet d'utiliser différents modèles de langue.

Dans le cas du Topic modelling, nous utilisons ces modèles dans l'espoir que les plongements générés encapsule une forme de motif: celui du thème abordé. Un texte abordant les effets de crises économiques sur la population Française devrait être sémantiquement plus proche d'un texte abordant les stratégies de financement de la transition écologique que d'un texte étudiant un accélérateur de particule. 

Cependant, du fait du [fléau de la dimension (_curse of dimensionality_)](https://fr.wikipedia.org/wiki/Fl%C3%A9au_de_la_dimension), il est très difficile et couteux de regrouper des objets dans un espace à 500 dimensions. Ainsi, la procédure inclus une étape de [**réduction de dimensionalité**](https://fr.wikipedia.org/wiki/R%C3%A9duction_de_la_dimensionnalit%C3%A9), qui projette les objets dans un espace de 2 à 10 dimensions en général. Pour ce faire, on utilise l'algorithme **UMAP** pour sa capacité à conserver les structures locales et globales (McInnes et al., 2018). Ainsi, malgré la réduction de dimensions, on conserve la structure générale de l'espace de plongement (deux documents radicalement différents resteront très éloignés) tout en conservant certains détails locaux.

À la fin de cette étape nous disposons, pour chaque texte, d'un plongement compressé encapsulant la signification du texte.

### 2. Regrouper les documents

Puisque nous disposons de nombreux plongements, nous pouvons tenter d'identifier des groupes grâce à un algorithme de [**clustering** (ou _partitionnement de données_)](https://fr.wikipedia.org/wiki/Partitionnement_de_donn%C3%A9es). La Figure 4 illustre parfaitement ce que tente de réaliser cet algorithme. Si à l'oeil nu cette tâche semble simple, son automatisation a nécessité le développement de nombreux algorithmes.

{% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-04.jpg" alt="Visual description of figure image" caption="Figure 4. Schéma de clustering, [scikit-learn](https://scikit-learn.org/stable/modules/clustering.html)." %}

Dans le cas de l'analyse textuelle les groupes ne sont pas si saillants comme on peut le voir à la @fig-final-example. Ainsi la pipeline de BERTopic utilise l'algorithme de classification [**HDBSCAN**](https://hdbscan.readthedocs.io/en/latest/how_hdbscan_works.html) pour sa capacité à détecter des groupes de forme et densité différentes.

### 3. Identifier les mots clefs qui représentent le mieux la spécificité de chaque topic.

Une fois que les groupes sont constitués, il nous reste à identifier les mots clefs qui représentent au mieux la spécificité de chaque _topic_. Pour ce faire, on utilise des techniques basées sur le comptage des mots en utilisant l'objet [`CountVectorizer`](https://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.CountVectorizer.html) de [`scikit-learn`](https://scikit-learn.org/stable/)[^2]. On obtient alors une matrice `terme x document` auquel on applique une transformation. Cette transformation, appelée [c-TF-IDF](https://maartengr.github.io/BERTopic/getting_started/ctfidf/ctfidf.html)[^3], a pour but de sélectionner les mots qui apparaissent le plus au sein du groupe, et n'apparaissent pas dans les autres.

### Conclusion

Nous avons donc définit toutes les briques de la procédure illustrée à la Figure 5:

1. Génération de plongements qui encapsulent la sémantique des textes avec **SBERT**, puis réduction du nombre de dimensions avec **UMAP**.
2. Création de groupes de textes sémantiquement proches avec **HDBSCAN**. 
3. Identification de mots représentant au mieux un thème à partir d'une matrice `terme x document` et une transformation c-TF-IDF.

Ces étapes sont représentées sur le schéma mis en avant dans la documentation: 

{% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-05.png" alt="Visual description of figure image" caption="Figure 5. Les 6 étapes clefs de BERTopic [source](https://maartengr.github.io/BERTopic/algorithm/algorithm.html#visual-overview)." %}

_Nous ne couvrons pas l'étape optionnelle n°7. Cette étape propose d'utiliser une IA générative pour décrire les thèmes trouvés._

<div class="alert alert-warning">
Il est important à ce moment de souligner que les groupes générés ne sont pas garantis d'être des <i>topics</i>. En effet, l'enchaînement de UMAP et HDBSCAN exploitent les saillances les plus fortes entre nos documents, mais ces saillances peuvent être sur le sujet abordé, comme le ton, la source ou bien du bruit. Nous le répétrons plus tard, mais ces techniques demandent une attention particulière au preprocessing et à l'évolution manuelle.
</div>

Pour en apprendre plus sur les différentes étapes de la pipeline, nous vous proposons de consulter les liens suivants: 

- [Understanding UMAP](https://pair-code.github.io/understanding-umap/) (en anglais)
- [Presentation of HDBSCAN by John Healy - PyData NYC 2018](https://youtu.be/dGsxd67IFiU?si=18wnb1nh1oJxyHzH) (en anglais)

## Étude de cas

### Introduction au jeu de données 

Nous illustrons notre tutoriel en utilisant le registre des thèses mis à disposition par l'État français sur le site [data.gouv.fr](https://www.data.gouv.fr/datasets/theses-soutenues-en-france-depuis-1985/) et qui répertorie l'ensemble des thèses défendues en France depuis 1985. Nous cherchons donc à explorer ce jeu de données afin de retrouver les grandes disciplines explorées par les doctorant.e.s en France à partir des résumés. Il a l'avantage d'être relativement propre, avec peu de résumés manquants et des métadonnées qui nous seront utiles pour vérifier les résultats du topic model.

Ce jeu de données a été nettoyés par nos soins[^4], le nouveau jeu de données peut être téléchargé sur le dépot [Zenodo](https://zenodo.org/records/17936091). Nous avons tiré aléatoirement 6500 lignes avec une stratification par année. Nous avons choisi de nous concentrer sur les années 2010-2022 pour des raisons de qualité des données.

L'étape de prétraitement des textes est cruciale pour obtenir de bons résultats. Nous listons quelques pré-traitements : 

- **Qualité des textes**: Il est important de connaître son jeu de données en le parcourant rapidement. Notamment, il peut contenir des artefacts qui peuvent bruiter les plongements (balises HTML, défauts d'encodage (i.e. accents mal repérés) ...). La définition du "bruit" dépend de votre question de recherche, par exemple vous pourriez décider de garder ou pas les emojis. Enfin, les modèles de plongements ne nécessitent pas de retirer les "stop words" comme ça pouvait être le cas avec d'autres méthodes; Nous souhaitons conserver les stop words ainsi que la ponctuation.
- **Éviter les doublons**: Si votre jeu de données comporte de trop nombreux doublons, un document présent plusieurs fois peut devenir un thème à lui tout seul.
- **Homogénéité du corpus**: Le topic modelling utilise les saillance les plus fortes pour distinguer les thèmes. Ainsi, des documents de plusieurs sources peuvent générer des thèmes différents si leurs formes divergent fortement (ton, longueur, densité d'information, etc...). Dépendemment de votre question de recherche, vous pouvez vouloir conserver ces différences, ou bien les exclure.
- **Language des documents**: Dans la même veine que l'homogénéité discutée avant, la langue du document peut être une différente trop saillante. Une alternative est de traduire tous les textes dans une seule langue en amont.
- **Longueur des documents**: Les modèles de plongement présentent une limite de taille de texte (aussi appelée la limite de contexte). Il est donc nécessaire d'accorder le choix du modèle de plongement avec notre corpus.

### Créer son premier topic model 

Pour commencer, chargons notre jeu de données: 

```python
import pandas as pd
df = pd.read_csv("./data/theses-soutenues-curated-stratified.csv")
```

Le jeu de données présente plusieurs colonnes d'intérêt:

- `CI`: un index.
- `oai_set_specs`: un code de discipline, par exemple, `ddc:300` représente `Sciences sociales, sociologie et anthropologie`.
- `resumes.en` et `resumes.fr`: les résumés des thèses en anglais et français

D'autres colonnes existent (titre de la thèse, sujet proposé par l'auteur.ice); elles nous aideront à l'évaluation du modèle.

Il nous suffit alors de choisir un modèle de plongement et créer une instance de `BERTopic` de la manière suivante: 

```python 
from bertopic import BERTopic 

topic_model = BERTopic( 
    language = "french", 
    embedding_model =  "Alibaba-NLP/gte-multilingual-base"
)
```

Puis de _"fit"_ le modèle sur nos données :

```python 
topic_model.fit(documents = df["resumes.fr"])
```

_Nota: la syntaxe `.fit`, `transform` et `fit_transform` reprend la syntaxe définie par Scikit-learn, l'une des premières librairies de Machine Learning et l'une des plus complète! La méthode `.fit` adapte un modèle à nos données, tandis que `.transform` permet d'utiliser le modèle pour faire des prédictions._

Nous pouvons extraire les thèmes de la manière suivante: 

```python 
topics, probabilities = topic_model.transform(documents=df["resumes.fr"])
```

On obtient alors une liste de thèmes, assignant chaque thèse à un groupe, ainsi que des probabilités, un score traduisant la distance d'un document au groupe assigné.

Nous pouvons extraire les informations des groupes comme ceci: 

```python
topic_model.get_topic_info()
```
<div class="table-wrapper" markdown="block">

|   Topic |   Count | Representation |
|---:|---:|:---|
|      -1 |    2754 | ['de', 'la', 'et', 'des', 'les', 'en', 'le', 'une', 'du', 'dans']                                                                                   |
|       0 |     177 | ['comportement', 'de', 'été', 'matériaux', 'des', 'essais', 'est', 'la', 'par', 'en']                                                               |
|       1 |     154 | ['cellules', 'cancer', 'patients', 'expression', 'avons', 'dans', 'tumorale', 'tumeurs', 'de', 'que']                                               |
|       2 |     146 | ['robot', 'images', 'pour', 'objets', 'données', 'de', 'nous', 'une', 'un', 'des']                                                                  |
|       3 |     144 | ['écoulement', 'est', 'méthode', 'de', 'écoulements', 'un', 'sont', 'pour', 'fluide', 'modèle']                                                     |
|       4 |     129 | ['bactéries', 'souches', 'chez', 'de', 'la', 'et', 'été', 'ont', 'des', 'par']                                                                      |
| ... | ... | ... |
|     107 |      10 | ['hépatocytes', 'foie', 'chc', 'hépatique', 'prolifération', 'hépatocytaire', 'mfp', 'tert', 'télomères', 'cellules']                               |
|     108 |      10 | ['mousses', 'bulles', 'solidification', 'mousse', 'liquide', 'congélation', 'friction', 'fibre', 'glace', 'liquides']                               |
|     109 |      10 | ['bâtiment', 'air', 'ventilation', 'bâtiments', 'chauffage', 'thermique', 'chaleur', 'mur', 'paroi', 'confort']                                     |
|     110 |      10 | ['emploi', 'salaire', 'salaires', 'travail', 'secteur', 'marché', 'salariés', 'syndicats', 'salariale', 'entre']                                    |
|     111 |      10 | ['optique', 'fibre', 'optiques', 'signal', 'fibres', 'ondes', 'phase', 'transmission', 'injection', 'linéaire']                                     |

</div>

**Tableau 2**: Topic information of the French theses after tuning the topic model 

Dans la Tableau 2, la colonne représentation renseigne les mots clefs identifiés pour chaque thème. On observe que les mots clefs du groupe bruit (groupe n°-1) ne donnent aucune information. Pour les autres sujets, on retrouve une suite de mots cohérents, par exemple: 

- 'cellules', 'cancer', 'patients' : ce groupe pourrait être représentatif d'un thème lié au à la recherche contre le cancer.
- 'bâtiment', 'air', 'ventilation', 'chauffage': ce groupe pourrait représenter un thème lié à l'étude de la balance énergétique des bâtiments.
- 'écoulement', 'fluide', 'écoulements', 'méthode', 'numériques': ce groupe pourrait représenter un thème lié aux simulation de mécanique des fluides.

Ce tableau **n'est pas** une preuve que le topic model soit satisfaisant, pour l'affirmer, nous devrons explorer chacun des groupes plus en détails. Cependant, trouver des groupes de mots cohérents est un bon signe.

On voit aussi que la majorité des documents sont classifiés comme "bruit". Ceci est le résultat normal de l'algorithme de clustering HDBSCAN qui se focalise sur des régions denses en premier lieu. Tous les thèmes comportent entre 10 et 200 documents, ce qui correspond à 0.1%, 3% du corpus entier. 

Nous pouvons forcer l'assignation d'un thème pour chaque document avec la commande suivante: 

```python 
topics_reduced = topic_model.reduce_outliers(
    documents = docs, 
    topics = topics, 
    probabilities = probabilities, 
    strategy="embeddings" 
)
```

**Cette commande n'a pas pour effet de recalculer les mots clefs**

### Afficher les résultats sous forme de graphe

Dans cette section, on présente 3 graphes très pratiques pour explorer le topic model et commencer le travail d'évaluation. 

**2D plot**

La première chose qu'on souhaite visualiser est l'espace de plongement projeté dans 2 dimensions. Cette visualisation permet de repérer les clusters, leur taille et leur emplacement les uns par rapport aux autres.

```python 
topic_model.visualize_documents(
    docs = df["resumes.fr"],
    hide_annotations = True, # améliore la lisibilité
    topics = [0,1,2,108],      # Sélectionner des groupes à mettre en surbrillance
)
```

{% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-06.png" alt="Visual description of figure image" caption="Figure 6. Projection 2D des documents et des thèmes identifiés." %}

Sur le graphe, on peut voir que le thème "3_écoulement_est_méthode" et "107_hépatocytes_foie_chc" sont proches tandis que "2_robot_images_pour" est à l'opposé. 

**Visualiser les mots clefs par thème**

Dans un deuxième temps, on peut représenter les $n$ mots représentant au mieux chaque thème. Cette représentation peut être utile pour analyser la cohérence interne de chaque thème.

```python 
topic_model.visualize_barchart(nwords=5)
```

{% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-07.png" alt="Visual description of figure image" caption="Figure 7. Visualisation des mots clefs par groupes." %}

Par exemple, le thème n°7 identifie les mots clefs "poésie", "poétique", "écriture" ou encore "littéraire". On constate que ces mots clefs sont cohérents ensemble et on peut facilement imaginer que ce thème regroupe des thèses de littérature qui étudient des oeuvres de poésie.

**Arbres hiérarchiques** 

Enfin, pour comprendre l'agencement des thèmes les uns par rapport aux autres, on peut afficher le topic model sous forme d'un dendogramme. On lit ce graphe de la gauche vers la droite, deux thèmes proches seront regroupés ensemble, et leurs branches se joindront à gauche.

```python
topic_model.visualize_hierarchy()
```

{% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-08.png" alt="Visual description of figure image" caption="Figure 8. Graphe hiérarchique." %}

Tout en haut de ce graphe en rouge, on peut notamment voir que des thèmes liés au droit, au droit constitutionnel et pénal sont placés très proches et que leurs branches se rejoignent très rapidement.

### Mieux choisir ses hyper-paramètres

Dans la section précédente, nous avons utilisés les paramètres par défaut. Nous allons maintenant explorer l'espace des possibles et tenter de comprendre l'effet de chaque paramètre sur le topic model.

Le premier hyperparamètre est le choix du modèle. En effet, la qualité des plongements, et donc la capacité à mesurer la distance sémantique entre deux document aura un impact majeur sur la capacité du topic model à générer des groupes cohérents. 

{% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-09.png" alt="Visual description of figure image" caption="Figure 9. Projection 2D des documents et des thèmes identifiés en utilisant le modèle de plongement Alibaba." %}

{% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-10.png" alt="Visual description of figure image" caption="Figure 10. Projection 2D des documents et des thèmes identifiés en utilisant le modèle de plongement Qwen." %}


| Alibaba Embedding | Qwen Embedding |
|-------------------|----------------|
| {% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-09.png" alt="Visual description of figure image" %} | {% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-10.png" alt="Visual description of figure image" %} |
| Figure 9. Projection 2D des documents et des thèmes identifiés en utilisant le modèle de plongement Alibaba | Figure 10. Projection 2D des documents et des thèmes identifiés en utilisant le modèle de plongement Qwen |

On peut visuellement voir que la Figure 10 et la Figure 11 sont très différentes. La Figure 11 est très éclatée, pouvant indiquer que le topic model a identifié des groupes très distincts. Cependant, en regardant de plus près, les groupes géométriques sont composés de documents provenant de nombreux groupes différents et ne proposent pas la continuité des thèmes observable dans la Figure 10.

Une fois que l'on est assuré de la qualité des plongements, on peut modifier la granularité du topic model en modifiant les paramètres `n_neighbors` et `min_cluster_size`. Plus ces deux paramètres seront petits, plus le topic model sera spécifique, et donc, génerera des thèmes de quelques documents.

Il est important de noter que ces paramètres dépendent de la taille du corpus! En effet, pour un corpus de 5 000 éléments, `n_neighbor=300` est une valeur très grande, mais pour un corpus de 50 000, cette valeur peut être moyenne.

Pour modifier ces valeurs, on utilise les lignes suivantes: 

```python 
from umap import UMAP
from hdbscan import HDBSCAN

# On créé un modèle HDBSCAN et UMAP indépendants
hdbscan_model = HDBSCAN(
    min_cluster_size=70, 
    # Default parameters 
    prediction_data=True
)
umap_model = UMAP(
    n_neighbors = 70,
    # Default parameters
    metric = "cosine",
    n_components = 5,
    min_dist=0.0,
    low_memory = False, 
    random_state = 42 # Permet la complète réplicabilité de la pipeline
)

# Puis on les renseigne quand on créé le topic model
topic_model = BERTopic(
    language = "french",
    umap_model= umap_model,
    hdbscan_model=hdbscan_model
)
topics, probabilities = topic_model.fit_transform(documents=df["resumes.fr"])
```

avec ces paramètres on obtient les résultats suivant: 

<div class="table-wrapper" markdown="block">

| Topic | Count | Representation |
|-------|------:|----------------|
| 0 | 4270 | `['de', 'la', 'des', 'et', 'les', 'le', 'en', 'une', 'dans', 'un']` |
| 1 | 2230 | `['de', 'la', 'et', 'les', 'des', 'le', 'en', 'du', 'une', 'dans']` |

</div>

**Tableau 3**: Topic information of the French theses after tuning the topic model.


{% include figure.html filename="fr-or-explorer-classifier-textes-bertopic-11.png" alt="Visual description of figure image" caption="Figure 11. Projection 2D des documents et des thèmes identifiés en utilisant `n_neighbors=70` et `min_cluster_size=70`." %}

Enfin, jusqu'à maintenant nous n'avons pas pu controller le nombre de thèmes générés par le modèle mais c'est un hyperparamètre qu'on peut régler à la création de l'objet: 

```python
topic_model = BERTopic(
    language = ...,
    nr_topics = 8
)
``` 

Ou bien après coup : 

```python 
topic_model.reduce_topics(docs = docs, nr_topics=8)
```

Attention, cette ligne de code écrase les résultats précédents. On vous conseille alors de sauvegarder régulièrement vos résultats.

### Sauvegarder les données

Pour sauvegarder les résultats on peut sauvegarder chaque graphe, mais on peut aussi sauvegarder l'objet `topic_model` de la manière suivante :

```python
topic_model.save(
    path = "./bertopic-default",
    serialization = "safetensors",
    save_ctfidf = False # garder False pour limiter la taille du fichier
)
```

Puis pour recharger le modèle il suffit d'utiliser la commande suivante :

```python 
topic_model = BERTopic.load("./bertopic-default")
```

Cette sauvegarde ne conserve pas pas les plongements, alors que c'est l'étape de calcul la plus lourde. Pour gagner en reproductibilité et en rapidité, vous pouvez générer vos plongements à en amont [(voir code)](https://css-polytechnique.github.io/css-ipp-materials/pages/bertopic-tutorial.html#precompute-your-embeddings) pour les utiliser dans le code. Les commandes deviennent:

```python 
docs = ....
embeddings = ....

topic_model = BERTopic(...)
topic_model.fit(documents=docs, embeddings=embeddings)

topics, probabilities = topic_model.transform(documents=docs, embeddings=embeddings)

topic_model.visualize_documents(docs = docs,embeddings = embeddings)
```

## Conclusion

Dans ce tutoriel on a présenté ce qu'était un topic model et comment ces modèles étaient utilisés dans les sciences sociales. Nous avons notamment mentionné son utilisation dans une phase exploratoire afin de mieux connaître son corpus ou en phase confirmatoire afin de confronter notre lecture avec un outil automatique. <br/>
Ensuite, nous avons présenté l'outil BERTopic et comment il permettait d'obtenir des thèmes à partir de plongements et un modèle de clustering. <br/>
Enfin, nous avons illustrer un cas simple avec les commandes usuelles pour créer le topic model et créer des visualisation et sauvegarder les résultats.

Tout le long du tutoriel nous avons appuyé l'importance de vérifier les résultats, cependant, nous n'avons pas montré de métrique pour établir la qualité d'un topic model. La raison est qu'il n'en existe pas à ce jour. En effet, l'évaluation des topic models est un domaine actif de la recherche (Hoyle et al., 2022) et les métriques entrent en contradiction avec les avis d'experts (Stammbach et al., 2023). Ainsi, la seule vérification qui vaille est la vérification manuelle à travers la vérification de la cohérence des documents dans un groupe et les délimitations entre les clusters.

Ceci conclut donc ce tutoriel, pour aller plus loin nous vous invitons à consulter la [version extensive de ce tutoriel (en anglais)](https://css-polytechnique.github.io/css-ipp-materials/pages/bertopic-tutorial.html).

## Bibliographie

Bizel-Bizellot, G., Galmiche, S., Charmet, T., Coudeville, L., Fontanet, A., & Zimmer, C. (2024). Extracting Circumstances of COVID-19 Transmission from Free Text with Large Language Models. SSRN. https://doi.org/10.2139/ssrn.4819301

Hoyle, A. M., Goel, P., Sarkar, R., & Resnik, P. (2022). Are Neural Topic Models Broken? Findings of the Association for Computational Linguistics: EMNLP 2022, 5321‑5344. https://doi.org/10.18653/v1/2022.findings-emnlp.390

Jockers, M. L., & Mimno, D. (2013). Significant themes in 19th-century literature. Poetics, 41(6), 750‑769. https://doi.org/10.1016/j.poetic.2013.08.005

McInnes, L., Healy, J., & Melville, J. (2018). UMAP : Uniform Manifold Approximation and Projection for Dimension Reduction (Version 3). arXiv. https://doi.org/10.48550/ARXIV.1802.03426

Stammbach, D., Zouhar, V., Hoyle, A., Sachan, M., & Ash, E. (2023). Revisiting Automated Topic Model Evaluation with Large Language Models. Proceedings of the 2023 Conference on Empirical Methods in Natural Language Processing, 9348‑9357. https://doi.org/10.18653/v1/2023.emnlp-main.581


## Notes de fin

[^1]: [Wikipedia](https://en.wikipedia.org/wiki/Latent_Dirichlet_allocation): La LDA est un modèle statistique génératif qui cherche à décrire une collection de textes avec une liste de "thème" non-connu _a priori_. [Voir une implémentation Python](https://radimrehurek.com/gensim/auto_examples/tutorials/run_lda.html).

[^2]: [Scikit-Learn](https://scikit-learn.org/stable/) est une bibliothèque pionière en machine learning et qui a un large rayonnement sur le domaine.

[^3]: Le nom c-TF-IDF vient de la transformation [TF-IDF](https://fr.wikipedia.org/wiki/TF-IDF) appliquée à chaque groupe, ou classe de documents.

[^4]: La procédure de nettoyage des données est renseignée [ici (written in English)](https://css-polytechnique.github.io/css-ipp-materials/pages/techy-notes.html#curations-of-the-original-dataset).
