---
title: "Créer des visualisations interactives avec Plotly"
slug: visualisations-interactives-plotly
original: interactive-visualization-with-plotly
layout: lesson
collection: lessons
date: 2023-12-13
translation_date: YYYY-MM-DD
authors:
- Grace Di Méo
reviewers:
- Mario Bañuelos
- Rob Lewis
editors:
- Scott Kleinman
translator:
- Axel Morin
translation-editor:
- Émilien Schultz
translation-reviewer:
- Paul Guille-Escuret
- Daniela Boaventura
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/651
difficulty: 2
activity: presenting
topics: [python, data-visualization]
abstract: Cette leçon montre comment créer des visualisations de données interactives avec la bibliothèque *open-source* Plotly. Le jeu de données utilisé provient d'une étude sociologique portant sur des articles de sciences sociales parus ces 20 dernières années.
avatar_alt: Dessin en noir et blanc d'un cygne contemplant son reflet dans l'eau.
mathjax: true
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

### Objectifs de la leçon

Cette leçon montre comment créer des visualisations de données interactives avec la bibliothèque *open-source* Plotly. En particulier, vous apprendrez :

- La différence entre les modules Plotly Express, Plotly Graph Objects et Plotly Dash.
- Comment créer et exporter des visualisations à l'aide des modules Plotly Express et Plotly Graph Objects.
- Comment personnaliser vos visualisations.

### Les prérequis

Afin de pouvoir suivre la leçon, il est nécessaire d'avoir :

- installé python 3 et le gestionnaire de paquets (*package*) `pip`.
- un niveau de compréhension intermédiaire du langage de programmation Python.
- une connaissance générale des bibliothèques Pandas et Numpy (ces deux bibliothèques doivent être installées).
- une connaissance de quelques techniques de base en visualisation de données (en particulier les histogrammes, les diagrammes en barres et les nuages de points).
- Des notions de traitement des données (nous utiliserons Pandas).

### Qu'est ce que Plotly ? 

Plotly est une société qui fournit un certain nombre de modules *open source* permettant aux utilisateurs de construire des visualisations interactives. Celles réalisées avec Plotly se démarquent des images statiques de par leur interactivité, à l'aide de boutons, d'outils pour se déplacer et zoomer, de visualisations en mosaïque et bien plus encore. La bibliothèque Plotly est disponible à la fois en Python - le sujet de cette leçon - ainsi que dans d'autres langages de programmation comme R et Julia[^1]. Les modules de Plotly permettent de réaliser une large variété de visualisations et ce à de nombreuses fins : statistiques, scientifiques, financières ou géographiques. Ces visualisations peuvent être affichées de plusieurs manières : à travers des *notebooks Jupyter*, des pages web (HTML) ou dans des applications web développées avec l'environnement Dash de Plotly. Il est aussi possible d'exporter les visualisations sous forme d'images statiques (non interactives) en pixels (*raster*) ou vectorielles.

> Tout le long de cette leçon, les visualisations générées à l'aide de Plotly seront affichées comme des images statiques. Pour utiliser les fonctionnalités interactives il faudra cliquer sur l'image ou bien le lien dans la description de l'image.

### Plotly, une Librairie Graphique de Python : Plotly Express vs Plotly Graph Objects vs Plotly Dash

Afin de comprendre comment utiliser Plotly, il est fondamental de comprendre les différences entre Plotly Express, Plotly Graph Objects et Plotly Dash.

Il s'agit essentiellement de 3 modules distincts - dont les fonctionnalités peuvent se superposer - qui ont leurs propres objectifs :

- Plotly Express (`plotly.express` souvent importé avec l'alias `px`) est une interface de représentation graphique *de haut niveau*, facile à prendre en main, et qui permet de créer près de 30 différents types de représentations. Le module fournit des fonctions permettant de créer des visualisations avec une seule ligne de code (bien que plusieurs lignes de code sont nécessaires à la personnalisation de certains éléments), rendant les visualisations rapides et faciles à créer. Puisque `plotly.px` est une interface *de haut niveau*, cela signifie que l’utilisateur.ice n’a pas besoin de s'attarder sur la structure sous-jacente des visualisations. Plotly recommande aux débutant.e.s de commencer avec Express avant de travailler avec Plotly Graph Objects.
- Les objets graphiques de Plotly - associés aux module Plotly Graph Objects (`plotly.graph_objects` souvent importé avec l'alias `go`) sont les véritables objets que Plotly créé lorsque l'on fait appel à Plotly Express. Plotly génère des `plotly.graph_objs` pour garder en mémoire les données de la visualisation. Ces données incluent les informations à visualiser avec de nombreux autres attributs telles que les couleurs, formes et tailles des objets. Il est alors possible de créer une visualisation plus finement avec Plotly Graph Objects. Il est d'ailleurs possible de recréer n'importe quelle figure créée par Plotly Express à l'aide de Plotly Graph Objects. Il est, en général, recommandé d'utiliser Plotly Express là où c'est possible pour réduire le nombre de lignes de code. En revanche, comme nous le verrons par la suite, le recours seul à Plotly Express est impossible et il faudra nécessairement passer par Plotly Graph Objects pour certaines visualisations.
- Le module Plotly Dash (importé avec l'alias `dash`) est un environnement pour créer des applications web interactives (typiquement des dashboards) qui peuvent être incrustées dans des sites web et autres plateformes. on ajoute souvent des figures créées avec Express ou Graph Objects dans les applications Dash, faisant des modules de Plotly la boîte à outils parfaite pour créer, manipuler et publier des représentations graphiques interactives de nos données. Plotly Dash est construit sur `React.js` et `Plotly.js` afin de rendre possible l'intégration sur internet, cela signifie que les utilisateur.ice.s n'ont pas besoin de connaissances en Javascript, CSS ou HTML (seulement en Python)[^2].

Plotly fournit une documentation complète pour travailler avec Express et Graph Objects ainsi que pour utiliser Dash.

### Pourquoi Plotly ? 

Il existe actuellement une pléthore de bibliothèques graphiques sous python comme **Matplotlib**, **Seaborn**, **Bokeh** ou **Pygal**. chaque bibliothèque présente des avantages. Selon le cas d'utilisation, les goûts esthétiques ou la facilité d'utilisation, tous ces points sont des critères qui permettent faire le choix d'une bibliothèque. Les avantages principaux de Plotly sont :

- Plotly est l'une des seules bibliothèque qui est spécifiquement tournée vers les représentations interactives. Matplotlib et Pygal ne fournissent que très peu de fonctionnalités interactives. Bokeh[^3] est aussi prévu pour l'interactivité et se présente comme une alternative viable.
- Plotly est la seule bibliothèque de Python qui assure à la fois une création de visualisations et une intégration dans des pages web simple.
- Plotly intègre parfaitement les objets de Pandas (par exemple, on peut directement passer des `pandas.Dataframe` aux objets graphiques de Plotly).
- Des visualisations 3D interactives sont disponibles (ce qui n'est pas le cas des autres bibliothèques).
- Plotly est simple d'utilisation, les animations et les menus déroulants sont relativement simples à utiliser.

## Données utilisées comme exemple

Le jeu de données utilisé pour cette leçon est issu de l'article « La Part Du Genre. Genre Et Approche Intersectionnelle Dans Les Sciences Sociales Françaises Au Xxie Siècle ».[^3] Celui-ci étudie la part des articles portant sur différentes thématiques, notamment le concept de genre, dans les publications scientifiques de sciences sociales françaises sur les vingt dernières années. Les données de l'enquête ont été rendues publiques dans une démarche de science ouverte, et sont disponibles [ici](https://osf.io/preprints/socarxiv/qamux_v1). La leçon se concentre plus spécifiquement sur le nombre d'articles publiés dans chaque discipline sur la période 2001-2022, ainsi que l'évolution des proportions d'articles mentionnant le genre ou la classe et ce en proposant une mise en perspective avec d'autres critères comme le genre des auteur.ice.s.

## Construire des visualisations avec Plotly Express

### Configurer Plotly Express

1. Avant de commencer, vous aurez besoin d'installer 3 bibliothèques dans votre environnement.[^4]
	- Plotly : dans votre terminal, entrez `pip install plotly`.
	- Pandas : dans votre terminal entrez `pip install pandas`[^5].
	- Kaleido : dans votre terminal entre `pip install kaleido`[^6].
2. Maintenant que ces bibliothèques sont installées, créez un nouveau Jupyter notebook (ou un nouveau fichier python dans votre logiciel d'édition de code). Idéalement, placez votre jeu de données et votre fichier python / notebook dans le même dossier.
3. Importez les modules à l'aide de la commande `import` au début de votre fichier : 

```python
import numpy as numpy
import pandas as pd
import plotly.express as px
```

### Importer et nettoyer les données

La prochaine étape est d'importer le jeu de données et de le nettoyer à l'aide des fonctions de Pandas. Les étapes à réaliser sont :

- Importer uniquement les colonnes du jeu de données qui nous seront utiles.
- Remplacer les données numériques qui pourraient manquer par des `np.nan` (objet Numpy *Not a Number*).
- Renommer et retirer certaines données pour plus de clarté et de précision.

```python
colonnes : list[str] = [
    "annee_publication", "revue", "pourcentage_femme", 
    "inclusif", "genre", "classe", "discipline"
]
df : pd.DataFrame = pd.read_csv("data_article.csv", usecols = colonnes)

# Remplace le code de discipline par son nom
num_discipline : dict = {
    -1 : '<UNK>',           # La discipline est inconnue
    0  : 'Anthropologie',
    1  : 'Aréale',
    2  : 'Autre interdisciplinaire',
    3  : 'Démographie',
    4  : 'Études de Genre',
    5  : 'Géographie',
    6  : 'Histoire',
    7  : 'SIC',
    8  : 'Science politique',
    9  : 'Sociologie',
    10 : 'Économie'
}
df["discipline"] = df["discipline"].replace(num_discipline)

# On remplace les chaînes de caractères par des booléens
df["inclusif"] = df["inclusif"].replace({"true" : True, "false" : False})
# Retirer les lignes où la discipline est inconnue
df = df.drop(df[df["discipline"] == "<UNK>"].index)

# Ne conserver que les disciplines désirées
disciplines_desirees = ['Sociologie','Économie','Géographie','Études de Genre']
df = df.drop(df[
    df["discipline"].apply(
        lambda discipline : discipline in disciplines_desirees
    ) == False].index
)

# Création d'une colonne "A majorité féminine" 
df["maj_feminine"] = df["pourcentage_femme"] >= 0.5
```

### Diagrammes en barres

Maintenant que nous avons créé un `DataFrame` Pandas de notre jeu de donnée, nous pouvons commencer à créer quelques visualisations simples en utilisant Plotly Express. Commençons par créer un diagramme en barres pour représenter le nombre d'articles publiés dans chaque discipline. Puisque notre jeu de données ne contient pas le nombre d'articles (pour le moment, chaque ligne correspond à un article) nous allons d'abord créer un nouveau `DataFrame` qui regroupera les articles écrits pour chaque discipline puis évaluer le nombre d'entrées dans chaque tableau.

```python
# Création d'un nouveau DataFrame
articles_par_discipline : pd.Series = df.\
                                groupby(["discipline"], as_index = False).\
                                size()
articles_par_discipline
```

||discipline|size|
|-|---------|----|
0|       Géographie|  1432|
1|       Sociologie|  6859|
2|         Économie|  6406|
3|  Études de Genre|  1632|

il suffit alors de créer un histogramme en utilisant ce nouveau `DataFrame`. Remarquons que cette visualisation est sauvegardée sous la variable `fig`, qui est une convention lorsqu'on travaille avec Plotly :

```python
# Créer le diagramme en barres (bar chart) en utilisant la fonction .bar()
fig = px.bar(articles_par_discipline, x = "discipline", y = "size")

# Affiche la figure en utilisant la méthode .show()
fig.show()
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-01.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-01.png" alt="Diagramme en barres représentant, sur l'axe des abscisses, 4 disciplines de siences sociales (Géographie, Sociologie, Économie et Études de Genre) et sur l'axe des ordonnées le nombre d'articles publiés dans les disciplines respectives variant entre 1000 et 7000.">
	</a>
<figcaption>
    <p>Figure 1. Un diagramme en barres avec une interactivité simple en utilisant Plotly Express. Si les lecteur.ice.s survolent les barres, on peut y voir apparaître des boîtes flottantes. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-01.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

Vous venez de créer votre première visualisation! Remarquons que cette visualisation est déjà en partie interactive : en passant la souris sur chaque barre, la figure nous spécifie combien d'articles sont représentés et la discipline des articles. Une autre fonctionnalité notable est que l'utilisateur.ice peut sauvegarder la visualisation comme un `.png` (image statique) en cliquant sur l'icône *appareil photo* qui apparaît lorsque la souris se trouve dans le coin haut droit de l'image. Au même endroit on peut trouver des fonctions de zoom, défilement, changement d'échelle et réinitialiser la vue. Toutes ces fonctionnalités seront disponibles pour toutes les visualisations.<br>
En revanche, la visualisation n'est pas des plus agréables, elle manque de couleurs, d'un titre et de titres d'axes plus visibles. Il est possible de préciser ces informations dès le début, en donnant plus d'arguments à la fonction `.bar()`. Par exemple, grâce à l'argument `labels` nous pouvons changer le nom des axes et grâce à l'argument `color` on peut changer la couleur des barres selon une variable de notre jeu de données (ici nous utiliserons « Nombres d'articles » pour l'axe vertical). Pour ajouter un titre, il suffit d'utiliser l'argument `title`.

```python
# Créer un bar chart en utilisant la fonction .bar()
fig = px.bar(
    articles_par_discipline,
    x="discipline",
    y="size",
    title="Titre de votre choix",
    labels={"size": "Nombres d'articles"},

    # Notez que l'argument "color" prend une chaine de caractères se référant à 
    # la colonne "discipline" du jeu de données
    color="discipline"
)

fig.show()
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-02.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-02.png" alt="Diagramme en barres représentant, sur l'axe des abscisses, 4 disciplines de siences sociales (Géographie, Sociologie, Économie et Études de Genre) et sur l'axe des ordonnées le nombre d'articles publiés dans les disciplines respectives variant entre 1000 et 7000. Chaque barre est d'une couleur différente et décrite dans une légende.">
	</a>
<figcaption>
    <p>Figure 2. Un diagramme en barres avec une interactivité simple en utilisant Plotly Express. Cette visualisation est une variante de la Figure 1 avec cette fois-ci des couleurs et une légende interactive qui permet aux lecteur.ice.s d'isoler ou bien de retirer certaines barres. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-02.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

Comme montré ci dessus, Plotly ajoute automatiquement une légende à la visualisation si vous distinguez les objets par des couleurs (à savoir que la légende peut être retirée). La légende est elle aussi interactive : en cliquant une fois sur un élément, la barre correspondante disparaît de la visualisation; en double-cliquant sur un élément, cette fois-ci tous les autres objets disparaissent excepté celui que vous avez sélectionné.

### Courbes

Tâchons maintenant de créer une courbe (*line chart*). De manière générale, la syntaxe pour créer une visualisation avec Plotly Express est toujours `px.type_de_representation()`  où `type_de_representation` représente le type de représentation que l'on souhaite créer. Comme on a utilisé `px.bar()` pour créer un diagramme en barres (*bar chart*), ici nous utiliserons `px.line()` pour créer un *line chart*. Tous les types de représentations disponibles et les fonctions associées peuvent être trouvées dans la [documentation Plotly](https://perma.cc/U4N7-2VM5).

Notre courbe représentera l'évolution du nombre d'articles par discipline à travers les années. Comme précédemment, nous créons un nouveau `DataFrame` qui regroupera les articles par année, par le critère `discipline`:

```python
# Créer un nouveau DataFrame contenant le nombre de d'articles publiés dans une discipline
evolution_nbe_articles_par_annee = df.\
    groupby(["discipline", "annee_publication"], as_index=False).\
    size()
```

Ensuite, nous créons plusieurs courbes en utilisant la fonction `.line()` et utilisons les mêmes paramètres que précédemment à savoir : `label` et `color`. Ici encore il est possible d'ajouter un titre à notre figure, il suffit de retirer le `#` devant l'argument `title` dans l'exemple suivant (et tous ceux qui suivent) :

```python
# Créer des courbes avec la fonction px.line() et ajouter quelques personnalisations
fig = px.line(
    evolution_nbe_articles_par_annee,
    x = "annee_publication",
    y = "size",
    # title = "Ajouter le titre de votre choix",
    labels = {"size" : "Nombre d'articles publiés"},
    color = "discipline"
)

fig.show()
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-03.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-03.png" alt="Courbe du nombre d'articles publiés entre 2001 et 2022 associée à une légende. Quatres courbes sont présentées, une par discipline (Géographie, Sociologie, Économie et Études de Genre), chacune d'une couleur différente. Le nombre de publication par année varie entre 10 et 450.">
	</a>
<figcaption>
    <p>Figure 3. Courbe avec une interactivité simple en utilisant Plotly Express. Survoler les lignes révèle une boîte flottante. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-03.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

Nous avons appris à créer de nouvelles visualisations et de les personnaliser - mais comment faire pour personnaliser notre figure après l'avoir créée ? À la place nous pouvons utiliser la méthode `.update_layout()` sur notre `fig` pour éditer après coup. Cette méthode peut être appliquée à n'importe quelle figure générée avec Plotly Express afin de modifier un large panel de paramètres. Prenons comme exemple la figure générée précédemment et modifions la police, la couleur et la taille de notre titre : 

```python
fig.update_layout(
    font_family = "Courrier New",   # Modification de la police
    font_color = "blue",            # Modification de la couleur du texte
    legend_title_font_color = "red",# Modification de la couleur du titre de la légende
    title = "Un titre formaté"
)

fig.show()
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-04.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-04.png" alt="Courbe du nombre d'articles publiés entre 2001 et 2022 associée à une légende et un titre : « Un titre formaté ». Quatres courbes sont présentées, une par discipline (Géographie, Sociologie, Économie et Études de Genre), chacune d'une couleur différente. Le nombre de publication par année varie entre 10 et 450.">
	</a>
<figcaption>
    <p>Figure 4. Courbe avec une interactivité simple en utilisant Plotly Express. Survoler les lignes révèle une boîte flottante. Cette visualisation est une variante de la Figure 3 avec des polices d'écriture, couleurs et titre différent. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-04.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

### Nuages de points

Les nuages de points (*scatterplots*), généralement utilisés pour visualiser des relations entre 2 variables continues, peuvent être créés à l'aide de Plotly Express en utilisant la fonction `px.scatter()`. Pour notre jeu de données, il peut être intéressant d'utiliser un nuage de points pour montrer la relation entre la proportion d'articles de revue qui parlent de genre et la proportion d'articles de la revue qui mentionnent la classe par discipline. 

Il nous faut créer un nouveau `DataFrame` : 

```python
proportion_genre_classe = df.\
    groupby(["revue","discipline"], as_index=False)[["genre","classe"]].\
    agg(
        proportion_genre = ("genre", lambda x : 100 * x.mean()),
        proportion_classe = ("classe", lambda x : 100 * x.mean()),
    )
```

```python
fig = px.scatter(
    proportion_genre_classe,
    x="proportion_classe",
    y="proportion_genre",
    color="discipline", 
    # title="Titre de votre choix",
)
fig.show()
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-05.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-05.png" alt="Nuage de points plaçant une quarantaine de revues sur un plan. Les axes de ce plan sont : en abscisse, la proportion d'articles de la revue qui mentionne la de classe et en ordonnée la proportion d'articles de la revue qui mentionne le genre. Chaque point est associé à une discipline par une couleur décrite dans la légende.">
	</a>
<figcaption>
    <p>Figure 5. Nuage de points avec une interactivité simple. Survoler un point du jeu de données permet d'afficher la discipline ainsi que la proportion d'articles mentionnant le genre, puis la classe pour une revue donnée (non affichée). De plus, la légende interactive permet d'isoler, comparer, retirer des catégories de points. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-05.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

Comme vous pouvez le voir, les nuages de points contiennent aussi certaines interactions par défaut : survoler les points permet d'afficher les données spécifiques aux points comme les coordonnées du point (ie les proportions d'articles mentionnant la classe et le genre respectivement) et la discipline de la revue. Cliquer ou double-cliquer sur le nom des disciplines dans la légende permet d'isoler certains éléments.

## Créer une visualisation en mosaïque

Les visualisations en mosaïque (*facet plots*) sont des visualisations subdivisées en plusieurs figures. Chaque subdivision illustre la même variable selon les mêmes axes mais pour des sous-ensembles différents. Plotly rend la création de telles visualisations très simple. En reprenant les exemples précédents, il suffit de spécifier le type de représentation que vous souhaitez dans les sous-figures. En deuxième instance il suffit d'utiliser le paramètre `facet_col` qui permet de préciser quelle variable utiliser pour distinguer les sous-figures. Dans l'exemple ci dessous, on créé une grille de 2x1 pour montrer la part d'articles qui mentionnent le genre en fonction de la discipline et si cela a été écrit par une majorité de femmes ou une majorité d'hommes :

```python
proportion_par_discipline_maj_feminine = df.\
    groupby(["maj_feminine","discipline"], as_index=False)[["genre"]].\
    agg(proportion_genre = ("genre", lambda x : 100 * x.mean()))

# Utiliser la fonction px.bar pour spécifier le type de représentation
fig = px.bar(
    proportion_par_discipline_maj_feminine,
    x="discipline",
    y="proportion_genre",
    # Utiliser le paramètre facet_col pour spécifier la colonne qui doit subdiviser
    facet_col="maj_feminine",  
    color="discipline",
    # title="Titre de votre choix",
)
fig.show()
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-06.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-06.png" alt="Une paire de diagrammes en barre partageant un même axe des ordonnées représentant la part d'articles mentionnant le genre par discipline (Géographie, Sociologie, Économie et Étude de genre). Le diagramme de gauche recense les articles écrits par un groupe d'auteurs à majorité masculine et à droite à majorité féminine. Chaque discipline se voit associé une couleur décrite dans une légende.">
	</a>
<figcaption>
    <p>Figure 6. Une mosaïque de 2 diagrammes en barres avec une interactivité simple créée avec Plotly Express en distinguant les articles écrits par une majorité de femmes et ceux écrits par une majorité d'hommes. La légende interactive permet aussi d'isoler, comparer ou retirer certaines disciplines. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-06.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

Notez que cette méthode ne nécessite pas de spécifier les dimensions de la grille puisque Plotly Express divise automatiquement la figure par le nombre de catégories disponibles (ici 2 puisque les 2 catégories disponibles sont majorité masculine / féminine). Cependant, cette méthode ne peut fonctionner que pour des figures ne représentant qu’un seul type de visualisation (ici, des diagrammes en barres). Nous discuterons plus bas de la manière de créer des visualisations contenant des sous-figures de dimensions particulières à l’aide de Graph Objects.

### Ajouter des animations : évolution temporelle

Comme nous l’avons vu, Plotly Express contient des fonctionnalités interactives natives. Et pourtant, il y a encore de nombreuses fonctionnalités qui peuvent être implémentées pour augmenter l'interactivité comme les animations à travers les *animation frames*.

Une *animation frame* représente la manière dont les données changent en fonction d'un certain axe. Dans les recherches historiques, la mesure la plus utile est l'axe temporel bien que d'autres variables numérique avec une relation d'ordre peuvent fonctionner (ex : les entiers, ou un intervalle comme $$[0,1]$$). Une figure Plotly Express avec une animation contient une barre de défilement interactive permettant de jouer/arrêter l'animation mais aussi de se déplacer manuellement dans les données.

Pour créer une visualisation avec une animation, il faut commencer par sélectionner le type de représentation que nous voulons utiliser comme dans les exemples précédents. Puis, à l'intérieur de la fonction on utilise le paramètre `animation_frame` pour spécifier quelle variable doit être utilisée pour visualiser l'évolution. Dans notre exemple, nous reprenons le nombre d'articles mentionnant le genre et affichons l'évolution à travers les années

```python
nbe_articles_genre_animation = df.groupby(["annee_publication","discipline"],
                                as_index = False).size()
# On utilise px.bar pour créer un diagramme en barres
fig = px.bar(
    nbe_articles_genre_animation,
    x="discipline",
    y="size",
    labels={"size": "Nombre d'articles mentionnant le genre publiés"},
    range_y=[0,500],  # Le paramètre range_y permet de customiser l'intervalede l'axe y
    color="discipline",
    # title="Titre de votre choix",
    # Utiliser le paramètre animation_frame pour spécfier l'axe d'évolution
    animation_frame="annee_publication", 
)
fig.show()
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-07.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-07.png" alt="Diagramme en barres animé. Sur l'axe des abscisses on retrouve 4 disciplines (Géographie, Sociologie, Économie et Étude de Genre) et sur l'axe des ordonnées, on le nombre d'articles publiés dans la discipline associée pendant une année. Une barre de défilement permet d'animer la visualisation en changeant l'année, et donc le nombre d'article publiés. Chaque barre est d'une couleur différente décrite dans une légende.">
	</a>
<figcaption>
    <p>Figure 7. Diagramme en barres animé associé à une barre de défilement créés grâce à Plotly Express. Comme précédemment, les lecteur.ice.s peuvent survoler les barres pour faire apparaître des boîtes flottantes. Les lecteur.ice.s peuvent appuyer sur les boutons play/pause ou utiliser la barre de défilement pour naviguer à travers les années. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-07.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

### Ajouter des animations : Menus déroulants

Les menus déroulants sont légèrement plus difficiles que les *animation frames*. Ils permettent à l'utilisateur.ice de passer d'une configuration d'affichage à une autre comprenant une large variété de paramètres permettant de changer les couleurs, lignes, axes et mêmes les variables. Quand on créé une figure avec un menu déroulant, la première étape est de créer la figure initiale *sans menu déroulant* (qui correspondra à la première vue que l'utilisateur.ice verra). Dans cet exemple, nous travaillerons avec le nuage de points qui illustre la part des articles mentionnant la classe et le genre. La construction est donc la suivante : 

```python
fig = px.scatter(
    proportion_genre_classe,
    x="proportion_classe",
    y="proportion_genre",
    color="discipline", 
    # title="Titre de votre choix",
    # labels = {}
)
```

Notons que la figure a été créée mais n'est pas visible puisque nous n'avons pas encore utilisé la fonction `fig.show()`. La figure sera affichée une fois que nous avons ajouté le menu déroulant dans les prochaines étapes.<br>
Après avoir créé la vue initiale, nous pouvons utiliser la méthode `update_layout` à nouveau pour ajouter un menu déroulant.

C'est une étape plus complexe puisque les données de l'objet Plotly Express sont imbriquées à plusieurs niveaux *sous le capot*, donc nous avons besoin de modifier des attributs à un niveau plus profond qu'à l'habitude pour créer le menu.<br>
Une fois qu'on a appelé la méthode `update_layout`:

- nous devons d'abord accéder au paramètre `updatemenus`: c'est une liste de dictionnaires, chaque dictionnaire contient les métadonnées pour plusieurs fonctionnalités.
- la seule fonctionnalité qui nous intéresse est la *dropdown box*, qui est contenue dans le dictionnaire `buttons`.
- la clef `buttons` contient comme valeur, une autre liste de dictionnaires, chaque dictionnaire représente les options disponibles dans le menu déroulant.
- Nous aurons besoin de créer 5 `buttons` — un par sous-groupe de données — donc notre liste `buttons` contiendra 5 dictionnaires.
- chacun de ces cinq dictionnaires devront contenir 3 paires clef-valeur :
    - la première paire, avec pour clef `args` précisera le type de représentation que nous voulons afficher.
    - la deuxième paire, avec pour clef `label` précisera le titre à afficher à côté du menu déroulant.
    - la troisième paire, avec pour clef `method`, précisera comment modifier la figure (modifications possibles `update`, `restyle`, `animate`, etc...).

Dans l'exemple ci dessous, nous regarderons comment utiliser le menu déroulant pour changer la catégorie de la variable affichée. Puisque nous travaillons avec un nuage de points qui affiche la part des journaux qui parlent de genre et de classe, nous ajouterons un menu déroulant qui permet d'afficher toutes les disciplines ensembles, puis seulement les journaux de sociologie, seulement les journaux de géographie, d'économie et d'étude de genre.

Pour créer le menu déroulant nous suivons les étapes suivantes :

 - à la clef `label` nous associons pour valeur, le texte à afficher dans le menu déroulant.
 - à la clef `method`, nous associons la valeur `update` puisque nous modifions l'affichage (`layout`) ET les données (`data`).
 - à la clef `args`, nous associons une autre liste de dictionnaires qui spécifiera quelle données seront `visible`(s) (vous trouverez plus d'informations à ce propos plus bas), le titre de la vue (paramètre optionnel), ainsi que les titres pour les axes x et y de cette vue (paramètre optionnel).

Le paramètre `visible` contient une liste, chaque élément de cette liste indiquera si les données à cet index doivent être affichées où non. Dans notre exemple, la liste doit contenir 4 éléments puisque nous avons 4 catégories à l'écran. Dans notre cas, le premier bouton doit représenter la visualisation telle qu'elle sera initialement présentée à l'utilisateur.ice et doit donc spécifier `[True, True, True, True]` puisque nous souhaitons que toutes les disciplines soient affichées. Cependant, pour les 4 autres vues, nous devons seulement inscrire `True` pour un seul élément puisque nous souhaitons n’afficher qu’une discipline à la fois.
Passons à la pratique :

```python
# Nous utilisons la méthode .update_layout pour ajouter le menu déroulant
fig.update_layout(
    updatemenus = [dict(
        buttons = [
            # Création de la liste  de dictionaires pour chaque boutons du menu déroulant.
            dict(
                label = "Toutes les disciplines", # Nom pour la première vue
                method = "update",
                args = [
                    # Cette vue montre les 4 disciplines
                    {"visible" : [True, True, True, True]},
                    {
                        "title" : "Toutes les disciplines",
                        "xaxis" : {"title" : "Part des articles mentionnant la classe"},
                        "yaxis" : {"title" : "Part des articles mentionnant le genre"}
                    }
                ]
            ),
            dict(
                label = "Géographie", # Nom pour la deuxième vue
                method = "update",
                args = [
                    # Cette vue montre seulement la première discipline
                    {"visible" : [True, False, False, False]}, 
                    {
                        "title" : "Géographie",
                        "xaxis" : {"title" : "Part des articles mentionnant la classe"},
                        "yaxis" : {"title" : "Part des articles mentionnant le genre"}
                    }
                ]
            ),
            dict(
                label = "Sociologie", # Nom pour la troisième vue
                method = "update",
                args = [
                    # Cette vue montre uniquement la deuxième discipline
                    {"visible" : [False, True, False, False]}, 
                    {
                        "title" : "Sociologie",
                        "xaxis" : {"title" : "Part des articles mentionnant la classe"},
                        "yaxis" : {"title" : "Part des articles mentionnant le genre"}
                    }
                ]
            ),
            dict(
                label = "Économie", # Nom pour la quatrième vue
                method = "update",
                args = [
                    # Cette vue montre la 3è discipline
                    {"visible" : [False, False, True, False]},
                    {
                        "title" : "Économie",
                        "xaxis" : {"title" : "Part des articles mentionnant la classe"},
                        "yaxis" : {"title" : "Part des articles mentionnant le genre"}
                    }
                ]
            ),
            dict(
                label = "Études de Genre", # Nom pour la cinquième vue
                method = "update",
                args = [
                    # Cette vue montre la 4è discipline
                    {"visible" : [False, False, False, True]},
                    {
                        "title" : "Études de Genre",
                        "xaxis" : {"title" : "Part des articles mentionnant la classe"},
                        "yaxis" : {"title" : "Part des articles mentionnant le genre"}
                    }
                ]
            ),
        ]
    )]
)

fig.show()
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-08.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-08.png" alt="Nuage de points plaçant une quarantaine de revues sur un plan. Les axes de ce plan sont : en abscisse, la proportion d'articles de la revue qui mentionne la de classe et en ordonnée la proportion d'articles de la revue qui mentionne le genre. Chaque point est associé à une discipline par une couleur décrite dans la légende. Un menu déroulant permet de sélectionner une discipline à afficher.">
	</a>
<figcaption>
    <p>Figure 8. Nuage de points avec un filtre interactif sous la forme d'un menu déroulant créé grâce à Plotly Express. Cette figure contient une légende interactive qui permet au lecteur d'isoler, comparer et retirer des données. De plus survoler des points permet de faire apparaître des boîtes flottantes. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-08.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

Créer ce menu déroulant dans l’exemple ci-dessus permet aux utilisateur·ice·s d’isoler (et d’examiner) des éléments spécifiques à partir d'une visualisation plus générale. Nous avions découvert cette fonctionnalité de Plotly plus tôt en notant qu'un double-clic sur une catégorie de la légende permettait de retirer tous les autres groupes de la figure. Cependant, le menu déroulant apporte d'autres avantages : il nous permet de créer des titres dynamiques qui peuvent changer en fonction de ce que nous avons sélectionné.

L'exemple ci-dessus montre qu'il est très facile de créer des visualisations avec Plotly Express et qu'il est relativement simple de rajouter de l'interactivité comme des animations ou des menus déroulants. Nous allons maintenant passer à la création de visualisations avec Plotly Graph Objects. Plus précisément, nous allons nous concentrer sur ce que sont les Graph Objects, comment ils fonctionnent et quand (ou pourquoi) vous pourriez avoir envie de créer des visualisations en utilisant Plotly Graph Objects plutôt qu'avec Plotly Express.

## Création des visualisations avec Plotly Graph Objects

### Configuration de Plotly Graph Objects

Pour commencer à travailler avec Plotly Graph Objects, vous aurez besoin d'importer le module `graph_objects` :

```python
import plotly.graph_objects as go 
```

> **Notons que dans un script `.py` conventionnel, les modules devraient être importés au début du script. On importe les modules ici pour un soucis de claireté.**

### Ce ne sont que des Objets ! La structure des données de Plotly Graph Objects 

Comme mentionné en introduction de cette leçon, toutes les figures créées avec Plotly Express sont en fait des Graph Objects *sous le capot*. Cela signifie que, lorsque nous créons une figure avec `plotly.px`, vous êtes en fait en train de créer une instance de Graph Object.

Cela devient évident si l'on utilise la fonction `type` avec la variable `fig` :

```python
# Résultat du type de la figure
print(type(fig))
```

```python
<class 'plotly.graph_objs._figure.Figure'>
``` 

Il est alors important de toujours garder en tête que les figures créées avec Plotly sont des Graph Objects.

Les `Graph Objects` sont représentés comme des structure de données en arbre (ie. hiérarchiques) avec trois racines :

- la racine `data` — *données* — contient des informations comme le type de représentation, les catégories disponibles, les points associés à chaque catégorie, l'option d'affichage dans la légende, le type de marqueurs utilisés, les informations à afficher lorsque l'on survole les points.
- la racine `layout` — *affichage* — contient des informations telles que les dimensions de la figure, les polices et couleurs d'écriture à utiliser, les annotations, les coordonnées des sous-figures (*subplots*), et si des images doivent être utilisées comme arrière plan.
- la racine `frames` contient toutes les informations reliées aux animations utilisées dans la figure, comme les données à afficher à chaque *frame*. Cet attribut ne sera pas créé si vous n'ajoutez pas d'animation à la figure.

Il est facile de voir la structure de données sous-jacente d'une figure en l'imprimant comme un dictionnaire avec la fonction `fig.to_dict()`. Pour lire ces données plus facilement, on peut utiliser le format `JSON` avec la fonction `fig.to_json(pretty = True)`. Dans l'exemple ci dessous, nous ne montrons que les 500 premiers caractères comme extrait de sortie après utilisation de cette fonction (une fois encore, en utilisant la variable `fig` créée précédemment).

```python
# print(fig.to_dict())
print(fig.to_json(pretty = True)[0:500] + "\n...")
```

```json
 {
  "data": [
    {
      "hovertemplate": "discipline=Sociologie\u003cbr\u003eproportion_classe=%{x}\u003cbr\u003eproportion_genre=%{y}\u003cextra\u003e\u003c\u002fextra\u003e",
      "legendgroup": "Sociologie",
      "marker": {
        "color": "#636efa",
        "symbol": "circle"
      },
      "mode": "markers",
      "name": "Sociologie",
      "orientation": "v",
      "showlegend": true,
      "x": [
        47.467166979362105,
        26.486486486486488,
        23.076923076923077,
...
```

Examiner la sortie affichée devrait pouvoir vous aider à comprendre la structure de données sous-jacente et les propriétés d'un `Graph Object`. Si vous imprimez la sortie entière (en utilisant `fig.to_dict()`) vous noterez que : 

- la structure de données contient des `data` pour chaque discipline (Géographie, Économie, Sociologie et Études de genre) chaque discipline dispose de son propre dictionnaire.
- l'attribut `data` qualifie quel type de représentation est utilisé (ici `Scatter`).
- l'attribut `layout` contient le titre de la figure.
- l'attribut `layout` contient les données associées aux `buttons` (ie le menu déroulant).
- Il n'y a pas d'attribut `frames` puisqu'il n'y a pas d'animation associée à la figure.

### Utiliser `Plotly Graph Objects` vs `Plotly Express`

Un autre point qu'il est important d'avoir à l'esprit c'est que créer des visualisations avec `plotly.go` requiert, en général, bien plus de code que pour créer les mêmes visualisations avec `plotly.px`.

Voyez plutôt l'exemple suivant : construisons un diagramme en barres horizontal pour montrer le nombre d'articles mentionnant le genre par catégorie. Premièrement, créons un `DataFrame` qui compte le nombre d'articles mentionnant le genre par discipline :

```python
articles_par_discipline_mention_genre : pd.Series = df.\
    groupby(["discipline"], as_index = False).\
    size()
```

Construisons maintenant le diagramme en barres horizontal avec ces données, grâce à `plotly.go` :

```python
fig = go.Figure(
    # On utilise go.Bar() pour spécifier le type de chart à utiliser
    go.Bar(
        x = articles_par_discipline_mention_genre["size"], 
        y = articles_par_discipline_mention_genre["discipline"],
        orientation = "h",
        # Nous devons formatter le "hover text" alors que c'est automatique avec plotly.px
        hovertemplate = "Discipline : %{y}<br>Nombre d'articles : %{x}<extra></extra>"  
    ),
    # layout = {"title" : "Ajouter le titre de votre choix"},
)

fig.update_layout(
    # Il est nécessaire d'utiliser la méthode update_layout pour ajouter des titres d'axes alors que c'est automatique avec plotly.px
    xaxis = {"title" : "Nombre d'articles"},
    yaxis = {"title" : "Discipline"}
)

fig.show()
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-09.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-09.png" alt="Diagramme en barres représentant, sur l'axe des abscisses, 4 disciplines de siences sociales (Géographie, Sociologie, Économie et Études de Genre) et sur l'axe des ordonnées le nombre d'articles publiés dans les disciplines respectives variant entre 1000 et 7000.">
	</a>
<figcaption>
    <p>Figure 9. Diagramme en barres horizontal avec une interactivité simple créé avec Plotly Graph Objects. Les lecteur.ices peuvent survoler les barres pour faire apparaître les boîtes flottantes. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-09.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

Notons que lorsque l'on utilise `Plotly Graph Objects`, on peut fournir un titre en utilisant l'argument `layout`, qui prend un dictionnaire contenant la clef `title` et sa valeur.

Maintenant créons la même visualisation avec `plotly.px` :

```python
fig = px.bar(
    articles_par_discipline_mention_genre,
    x = "size", y = "discipline",
    orientation = "h",
    #title = "Titre de votre choix",
    labels = {"size" : "Nombre d'articles"}
)
fig.show()
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-10.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-10.png" alt="Diagramme en barres représentant, sur l'axe des abscisses, 4 disciplines de siences sociales (Géographie, Sociologie, Économie et Études de Genre) et sur l'axe des ordonnées le nombre d'articles publiés dans les disciplines respectives variant entre 1000 et 7000.">
	</a>
<figcaption>
    <p>Figure 10. Diagramme en barres horizontal avec une interactivité simple créé avec `Plotly Express`. Les lecteurices peuvent survoler les barres pour faire apparaître les boîtes flottantes. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-10.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

Il est clair d'après les exemples précédents que `plotly.go` requiert plus de code que `plotly.px` car de nombreuses fonctionnalités nécessitent d'être manuellement créées dans `plotly.go`. Ainsi, il est en général recommandé d'utiliser `plotly.px` quand c'est possible.

### Pourquoi utiliser `Graph Objects`

Ceci devrait nous amener à la question centrale : si c'est si simple d'utiliser `plotly.px` pour créer des visualisations, pourquoi devrions nous nous embêter avec `plotly.go`? La réponse simple est qu'il y a en réalité de nombreuses fonctionnalités utiles qui ne sont accessibles qu'à travers `plotly.go`. Nous jetons un œil à deux de ces fonctionnalités dans cette section du tutoriel : les tableaux et les compositions de figures (*subplots*).

#### Tableaux

L'une des fonctionnalités de `plotly.go` la plus utile est l'option de créer des tableaux interactifs et propres.

Pour cela, suivons les 4 étapes suivantes :

1. Créer une figure avec la fonction `.Figure()`
2. à la racine `data`, utiliser la fonction `.Table()` pour spécifier que la figure doit être une table.
3. Dans la fonction `.Table()`, créer un dictionnaire entête (`header`) pour stocker la liste des colonnes de l'entête
4. Dans la fonction `.Table()`, ajouter un dictionnaire cellules (`cells`) pour y mettre les valeurs du tableau

Il est aussi possible de personnaliser grâce à des labels, couleurs, et des options d'alignement

Dans l'exemple ci dessous, nous créons un tableau pour stocker l'entièreté de la base de données de l'article.

```python
fig = go.Figure(
    data = [
        go.Table(
            header = {
                "values" : df.columns,
                "fill_color" : "paleturquoise",
                "align" : "left"
            },
            cells = {
                "values" : df.transpose().values.tolist(),
                "fill_color" : "lavender",
                "align" : "left"
            }
        )
    ]
)

fig.show()
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-11.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-11.png" alt="Tableau montrant une partie du jeu de données. Les colonnes visibles sont : annee_publication, revue, pourcentage_femme, inclusif, genre, classe, discipline, maj_feminine.">
	</a>
<figcaption>
    <p>Figure 11. Tableau contenant les données de nos articles et créé avec Plotly Graph Object. Les Lecteur.ices peuvent faire défiler toutes les entrées du jeu de données comme iels le feraient dans un tableur. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-11.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

De la même manière qu'avec `plotly.px`, les figures de `plotly.go` permettent une certaine interactivité native. Les tableaux par exemple permettent aux utilisateur.ices de faire défiler les lignes du tableau (en utilisant le trackpad ou la bar de défilement sur la droite). Ces objets sont ainsi excellents pour économiser de la place. Il est aussi facile de déplacer des colonnes en cliquant sur l'entête d'une colonne et la déplaçant à droite ou à gauche. 

#### La compositions de figures (*subplots*)

Une autre fonctionnalité très utile de `plotly.go` est le fait de pouvoir créer des compositions de figures. Bien que `plotly.px` permette de créer des visualisations en mosaïque, le champ des possibles est relativement limité puisque les sous-figures générées doivent toutes partager le même type de représentation, les axes et les variables à afficher. La composition de figures permet elle de créer des grilles contenant différents types de représentations avec leurs axes et variables propres afin de transformer les figures en des objets proches des *dashboard*.

Puisque le code est particulièrement long pour créer des compositions de figures, cet exemple sera présenté pas à pas. Nous créerons une grille de 3x1 contenant 3 différentes figures : le premier sera un diagramme en barres standard pour quantifier le nombre d'articles mentionnant le genre à travers les disciplines; le deuxième sera une courbe affichant l'évolution de la part des articles mentionnaient le genre à travers les années. Enfin la dernière figure sera un diagramme en boîte (avec la représentation du minimum, maximum, interquartile d'une distribution) sur la distribution de la part d'auteurices dans les articles en fonction de si l'article est écrit en écriture inclusive ou non.

**Étape 1 : importer le module subplots et préparer les données**

```python
# Importer make_subplots
from plotly.subplots import make_subplots

# Préparation des données
articles_par_discipline_mention_genre = df.\
    loc[df["genre"] == 1, :].\
    groupby("discipline", as_index = False).\
    size()

proportion_d_articles_mentionnant_le_genre_par_annee = df.\
    loc[:,["discipline", "annee_publication", "genre"]].\
    groupby(["discipline", "annee_publication"], as_index = False).\
    mean()

pourcentage_d_auteurice_femme_si_genre = df.\
    groupby("genre")
```

**Étape 2 : Création d'une composition de sous-figures vide avec une grille 3x1 grâce à la fonction `make_subplots`**

```python
# 1 ligne, 3 colonnes
fig = make_subplots(rows = 1, cols = 3)
```

**Étape 3 création de la première figure (le diagramme en barres) grace à la méthode `.add_trace()`**

```python
fig.add_trace(
    # la fonction go.Bar permet de spécifier le type de représentation à créer
    go.Bar(
        x = articles_par_discipline_mention_genre["size"],
        y = articles_par_discipline_mention_genre["discipline"],
        orientation = "h",
        name = "Nombre d'articles publiés mentionnant le genre par discipline",
        hovertemplate = ("<b>Discipline :</b> %{y}<br><b>Nombre d'articles "
                         "publiés</b> : %{x}<extra></extra>")
    ),
    # Les paramètres row et col permettent de positionner la figure dans la bonne case
    row = 1, col = 1 
)
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-12.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-12.png" alt="Une visualisation à trois colonnes, avec dans la colonne de gauche un diagramme en barres. La colonne centrale et de droite sont vides.">
	</a>
<figcaption>
    <p>Figure 12. Une composition de figures avec 3 colonnes et une interactivité simple créée avec le module Plotly Graph Object, et avec un diagramme en barres sur la gauche montrant le nombre d'articles mentionnant le genre par discipline, et deux colonnes vides sur la droite. Les lecteur.ices peuvent survoler les barres pour faire apparaître les boîtes flottantes. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-12.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

> **Nota : si vous créez une composition de figure dans un Notebook Jupyter, relancer le code pourrait dupliquer la trace que vous venez d'ajouter et donc doubler la légende. Si vous avez besoin de relancer le code, il vaudrait mieux relancer à partir de la cellule qui définit la variable `fig` que vous modifiez.**

**Étape 4 : Ajouter la seconde figure (courbe)**

```python
# Pour chaque discipline il faut créer un objet go.Scatter différent afin de créer 
# les différentes courbes. 
# Pour se faire, on divise notre DataFrame par discipline et on procède comme 
# précédemment en ne travaillant qu'avec les sous-dataset
for discipline, df_discipline in proportion_d_articles_mentionnant_le_genre_par_annee.\
                                    groupby("discipline") :
    fig.add_trace(
        # la fonction go.Scatter permet de spécifier le type de représentation à créer
        go.Scatter(
            x = df_discipline["annee_publication"],
            y = df_discipline["genre"],
            name = discipline,
            mode = "markers+lines",
            hovertemplate = (f"<b>Discipline :</b> {discipline}"
                             "<br><b>Année :</b> %{x}<br><b>Propotion des "
                             "particles :</b> %{y}")  

        ),
        # Les paramètres row et col permettent de positionner la figure dans la bonne case
        row = 1, col = 2 
    )   
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-13.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-13.png" alt="Une visualisation à trois colonnes, avec dans la colonne de gauche un diagramme en barres et dans la colonne centrale quatres courbes de couleurs. Une légende décrit les éléments affichés. La colonne de droite est vide.">
	</a>
<figcaption>
    <p>Figure 13. Une composition de figures avec 3 colonnes et une interactivité simple créée avec le module Plotly Graph Object, et avec un diagramme en barres sur la gauche montrant le nombre d'articles mentionnant le genre par discipline, une courbe au centre montrant l'évolution de la proportion d'articles mentionnant le genre par discipline et une colonnes vide sur la droite. Les lecteur.ices peuvent survoler les barres pour faire apparaître les boîtes flottantes. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-13.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

**Étape 5 : Ajouter la dernière figure (diagramme en boîte)**

Nous n'avons pas encore exploré les diagrammes en boîte (*boxplot*), mais ils sont créés de la même manière que les autres figures et ont une interactivité native similaire (survoler une boîte nous montrera la valeur minimum, maximum, médiane, et les interquartiles des données affichées).

```python
fig.add_trace(
    # On utilise la fonction go.Box() pour spécifier qu'on créé un diagramme en boîte
    go.Box(
        y = pourcentage_d_auteurice_femme_si_genre.\
            get_group(True)["pourcentage_femme"],
        name = "Genre"),
        row = 1, col = 3 # puisque c'est la troisième, on le met sur la 3è colonne
)

# On ajoute le deuxième diagramme en boîte puisqu'on a deux groupes distincts pour 
# les articles avec et sans écriture inclusive
fig.add_trace(
    go.Box(
        y = pourcentage_d_auteurice_femme_si_genre.\
            get_group(False)["pourcentage_femme"],
        name = "Pas genre"),
    row = 1, col = 3 
)
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-14.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-14.png" alt="Une visualisation à trois colonnes, avec dans la colonne de gauche un diagramme en barres et dans la colonne centrale quatres courbes de couleurs. Une légende décrit les éléments affichés. Dans la colonne de droite on trouve 2 diagrammes en boîte.">
	</a>
<figcaption>
    <p>Figure 14. Une composition de figures avec 3 colonnes et une interactivité simple créée avec le module Plotly Graph Object, et avec un diagramme en barres sur la gauche montrant le nombre d'articles mentionnant le genre par discipline, une courbe au centre montrant l'évolution de la proportion d'articles mentionnant le genre par discipline et deux diagrammes en boîte représentant la distribution de la part d'autrices dans les articles selon s'il mentionne le genre ou non. Les lecteur.ices peuvent survoler les barres pour faire apparaître les boîtes flottantes. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-14.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

**Étape 6 : Formattage de la Figure**

Il est nécessaire d'ajuster certains paramètres, comme ajouter un titre général à la figure et des sous-titres pour tous les sous-figures. Vous pourriez aussi vouloir changer la police d'écriture, changer la position du texte, la taille de la figure -- vous pouvez utiliser la méthode `.update_layout()` pour changer toutes ces propriétés :

```python
fig.update_layout(
    # Changement de la police d'écriture pour toute la figure
    font_family = "Times New Roman", 
    # Changement de la police d'écriture pour les notes hover
    hoverlabel_font_family = "Times New Roman", 
    # changement de la taille d'écriture pour les notes hover
    hoverlabel_font_size = 16, 
    # title_text = "Ajouter un titre ici", # Titre principal
    # Positionnement du titre principal au centre de la visualisation 
    # (note : le paramètre title_x ne prend que des entiers (integers) 
    # ou des réels (floats))
    # title_x = 0.5 
    # ajout d'un titre d'axe pour l'absisse de la première figure
    xaxis1_title_text = "Nombre d'articles mentionnant le genre",
    # ajout d'un titre d'axe pour les ordonnées de la première figure
    yaxis1_title_text = "Catégorie du journal", 
    yaxis2_title_text = "Part des articles mentionnant le genre",
    xaxis2_title_text = "Année de publication",
    yaxis3_title_text = "Distribution du pourcentage de femmes autrice de chaque article",
    showlegend = False, # Retire la légende
    # Ajuste la taille de la visualisation  - pas toujours nécessaire mais peut s'avérer utilse si les figures sont publiées sur internet
    height = 650
)
``` 

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-15.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-15.png" alt="Une visualisation à trois colonnes, avec dans la colonne de gauche un diagramme en barres et dans la colonne centrale quatres courbes de couleurs. Dans la colonne de droite on trouve 2 diagrammes en boîte.">
	</a>
<figcaption>
    <p>Figure 15. Une composition de figures avec 3 colonnes et une interactivité simple créée avec le module Plotly Graph Object, et avec un diagramme en barres sur la gauche montrant le nombre d'articles mentionnant le genre par discipline, une courbe au centre montrant l'évolution de la proportion d'articles mentionnant le genre par discipline et deux diagrammes en boîte représentant la distribution de la part d'autrices dans les articles selon s'il mentionne le genre ou non. Cette visualisation est une variante de la Figure 14 avec une personalisation avancée. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-15.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

**Étape 7 : Ajout d'annotations aux courbes**

Puisque la légende a été retirée, il est impossible de distinguer une discipline des autres. Nous pouvons utiliser la méthode `.update_layout` pour ajouter des flèches pointant vers chaque ligne avec une annotation : 

```python
fig.update_layout(
    # Entre comme paramètre la list de dictionnaires où chaque dictionnaire 
    # représente une annotation
    annotations = [
        # Notre première annotation sera pour identifier la catégorie "Études de Genre"
        dict(
            # coodinées du points de référence de l'annotation
            x = 2005, y = 0.897,
            # Spécifie fans quel référentiel on se place, ici comme on annote la
            # figure n°2 on donne comme référence x2, y2
            xref = "x2", yref = "y2",
            # Permet de spécifier la longueur de la flèche, et donc du déport du point
            ax = 30, ay = 100,
            text = "Études de Genre",
            showarrow = True, # Utilisez False si vous ne voullez pas de la tête
            # de flèche dans l'annotation
            arrowhead = 1, # change la taille de la tête de flèche
        ),
        # Notre deuxième annotation sera pour identifier la catégorie "Sociologie"
        dict(
            x = 2007, y = 0.1514,
            xref = "x2", yref = "y2",ax =-30, ay = -100,
            text = "Sociologie",showarrow = True, arrowhead = 1, 
        ),
        # Notre troisième annotation sera pour identifier la catégorie "Géographie"
        dict(
            x = 2008, y = 0.04054,
            xref = "x2", yref = "y2",ax = 30, ay = -100,
            text = "Géographie",showarrow = True, arrowhead = 1, 
        ),
        # Notre deuxième annotation sera pour identifier la catégorie "Économie"
        dict(
            x = 2014, y = 0.083,
            xref = "x2", yref = "y2",ax = 30, ay = -100,
            text = "Économie",showarrow = True, arrowhead = 1, 
        ),
    ]
)
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-16.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-16.png" alt="Une visualisation à trois colonnes, avec dans la colonne de gauche un diagramme en barres et dans la colonne centrale quatres courbes de couleurs. Des annotations sont présentes pour indiquer la discipline associée à chacune des quatre courbes. Dans la colonne de droite on trouve 2 diagrammes en boîte.">
	</a>
<figcaption>
    <p>Figure 16. Une composition de figures avec 3 colonnes et une interactivité simple créée avec le module Plotly Graph Object, et avec un diagramme en barres sur la gauche montrant le nombre d'articles mentionnant le genre par discipline, une courbe au centre montrant l'évolution de la proportion d'articles mentionnant le genre par discipline et deux diagrammes en boîte représentant la distribution de la part d'autrices dans les articles selon s'il mentionne le genre ou non. Cette visualisation est une variante de la Figure 15 des annotations pour repérer les courbes du sous-figure du milieu. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-16.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

**Étape 8 : Ajout d'annotations en dessous de la figure**

Nous pourrions avoir besoin d'ajouter des annotations en dessous de la figure pour spécifier la direction choisie pour notre analyse (cela s'avère très utile lorsqu'on publie des articles académiques), ce qui peut être fait grâce à la méthode `.add_annotation()`:

```python
fig.add_annotation(
    dict(
        font=dict(color="black", size=15),  # Change la police d'écriture
        x=0.5,  # Utilise x et y pour la position de l'annotation
        y=-0.2,
        showarrow=False,
        text=(
            "Nombre d'articles publiés par discipline (gauche);"
            "Proportion d'articles mentionnant le genre à travers les années "
            "(centre);<br>"
            "Distribution de la part de femmes autrices lorsque l'article est "
            "publié en écriture inclusive (droite)."),
        # Option pour changer l'orientation de l'écriture, utile pour la gestion de l'espace
        textangle=0,  
        xanchor="center",
        # Régler xref et yref à 'paper' pour que les valeurs de x et y soient 
        # des coordonées absolues
        xref="paper",  
        yref="paper",
    )
)
# On ajoute une petite marge pour que laisser la place aux annotations
fig.update_layout(margin = {"b" : 100})
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-17.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-17.png" alt="Une visualisation à trois colonnes, avec dans la colonne de gauche un diagramme en barres et dans la colonne centrale quatres courbes de couleurs. Des annotations sont présentes pour indiquer la discipline associée à chacune des quatre courbes. Dans la colonne de droite on trouve 2 diagrammes en boîte. Une annotation décrit chacun des graphe : Nombre d'articles publiés par discipline (gauche); Proportion d'articles mentionnant le genre à travers les années (centre); Distribution de la part de femmes autrices losque l'article mentionne le genre ou non.">
	</a>
<figcaption>
    <p>Figure 17. Une composition de figures avec 3 colonnes et une interactivité simple créée avec le module Plotly Graph Object, et avec un diagramme en barres sur la gauche montrant le nombre d'articles mentionnant le genre par discipline, une courbe au centre montrant l'évolution de la proportion d'articles mentionnant le genre par discipline et deux diagrammes en boîte représentant la distribution de la part d'autrices dans les articles selon s'il mentionne le genre ou non. Cette visualisation est une variante de la Figure 16 avec des annotations supplémentaires sous les figures. <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-17.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

## Afficher et Exporter les visualisations

Dans les sections précédentes de la leçon, nous avons vu comment créer et modifier les visualisations interactives avec Plotly Express et Plotly Graph Objects. Nous allons maintenant apprendre comment faire apparaître les visualisations et les exproter pour les publier ou les partager.

La méthode illustrée ici exportera la figure 3 créée plus tôt dans la leçon :
```python
fig = px.line(
    evolution_nbe_articles_par_annee,
    x = "annee_publication",
    y = "size",
    # title = "Ajouter le titre de votre choix",
    labels = {"size" : "Nombre d'articles publiés"},
    color = "discipline"
)
```

### Afficher la visualisation

Comme nous l'avons vu tout le long de cette leçon, la méthode `.show()` peut être utilisée pour faire apparaître la figure. Par défaut, cette méthode utilise le générateur d'image Plotly qui fournit l'interactivité native :

```python
fig.show()
```

<figure style="">
<a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-03.html" style="" target="_blank">
    <img src="https://programminghistorian.github.io/ph-submissions/images/interactive-visualization-with-plotly/fr-tr-visualisations-interactives-plotly-03.png" alt="Courbe du nombre d'articles publiés entre 2001 et 2022 associée à une légende. Quatres courbes sont présentées, une par discipline (Géographie, Sociologie, Économie et Études de Genre), chacune d'une couleur différente. Le nombre de publication par année varie entre 10 et 450.">
	</a>
<figcaption>
    <p>Figure 18. Reproduction de la Figure 3, illustrant la fonction fig.show(). <a href="https://programminghistorian.github.io/ph-submissions/assets/visualisations-interactives-plotly/fr-tr-visualisations-interactives-plotly-03.html" target="_blank">Cliquez pour explorer une version interactive de cette figure</a>.</p>
</figcaption>
</figure>

### Export des visualisations

Les figures Plotly peuvent être exportées en version statique (donc sans interactivité) ou en version interactive. Les visualisations interactives sont utiles pour les sites de recherches et certaines publications numériques, tandis que les versions statiques sont plus appropriées aux publications imprimées.

#### Export en HTML 

Exporter les figures en HTML conserve l'interactivité lorsqu'on les ouvre avec un moteur de recherche. Toute figure peut être sauvegardée en format HTML grâce à la fonction `.write_html()` :

```python
# Sauvegarde de la visualisation en format HTML (figure que nous avons conservé sous la variable 'fig' pendant toute la leçon)
fig.write_html("nom_visualisation.html")
```

Par défaut toute figure exportée sera sauvegardée dans le même dossier que celui où se trouve le script. Si vous voulez sauvegarder la figure dans un autre dossier, vous pouvez spécifier le chemin exact vers ce dossier (par exemple `fig.write_html("your_path/nom_visualisation.html")`)

#### Export d'images statistiques

Plotly fournit de nombreuses options pour exporter des images pixellisées (`.png` ou `.jpg`) et images ej vectoriel (`.pdf` ou `.svg`). Pour cela, il suffit d'utiliser la méthode `write_image()` et spécifier quel type d'image nous souhaitons dans le nom du fichier :

```python
# Export en images classiques (raster ?):
fig.write_image("nom_visualisation.png")
fig.write_image("nom_visualisation.jpeg")

# Export en images vectorielles :
fig.write_image("nom_visualisation.svg")
fig.write_image("nom_visualisation.pdf")
```

## Sommaire

Plotly offre la possibilité de créer des images de qualité, interactives en utilisant Python ou bien d'autres langages de programmation. Cette leçon fournit un apperçu de Plotly, pourquoi cette librairie est utile et comment on peut l'utiliser sous Python. Elle montre aussi comment utiliser différents modules de Plotly (**Plotly Express** et **Plotly Graph Objects**) et les méthodes nécessaires pour créer, éditer et exporter des visualisations. Les syntaxes clefs sont : 

- Installer Plotly en utilisant `pip install plotly`.
- Importer **Plotly Express** et **Plotly Graph Objects** à l'aide de `import plotly.express as px` et `import plotly.graph_objects as go`.
- Dans **Plotly Express**
    - Créer des visualisations à l'aide de `px.bar()`, `px.line()` et `px.scatter()`.
    - Ajouter des personalisations tels qu'un titre, des titres d'axes ou modifier les couleurs à l'aide des paramètres (`title`, `labels` et `color`) et même ajouter des animations avec le paramètre `animation_frames`.
    - Modifier les visualisations après leur création à l'aide de la méthode `.update_layout()` et ajouter des menus déroulants.
- Avec **Plotly Graph Objects**:
    - Reconnaitre la structure sous-jacente de toutes les figures à travers les attributs `data`, `layout` et `frames`.
    - Créer de nouvelles visualisations vides avec la fonction `go.Figure()`.
    - Créer des visualisations avec les fonctions `go.Bar()`, `go.Box()`, `go.Scatter()` et des tables avec `go.Table()`.
    - Créer des mosaïques (en important le module `from plotly.subplots import make_subplots`, et réaliser l'implémentation grâce à la fonction `make_subplots` puis ajouter des données grâce à la méthode `.add_trace()`).
    - Modifier les figures après leur création à l'aide de la méthode `.update_layout()`.
- Exporter des visualisations créés avec **Plotly Express** ou **Plotly Graph Objects** avec la méthode `.write_html()` ou bien `.write_image()`.

## Notes de fin

[^1]: `Plotly.Dash` est en dehors du cadre de cette leçon, qui se concentre plutôt sur Plotly Express et Plotly Graph Objects

[^2]: Pour plus d'informations sur Bokeh, voir la leçon de Charlie Harper sur [Visualizing Data with Bokeh and Pandas](https://programminghistorian.org/en/lessons/visualizing-with-bokeh) dans la revue *Programming Historian*.

[^3]: Ollion, Etienne, Julien Boelaert, Samuel Coavoux, Estelle Delaine, Altaïr Desprès, Sibylle Gollac, Narguesse Keyhani, et al. 2025. “La Part Du Genre. Genre Et Approche Intersectionnelle Dans Les Sciences Sociales Françaises Au Xxie Siècle.” SocArXiv. March 19. doi:10.31235/osf.io/qamux_v1.

[^4]: Si vous travaillez avec des notebooks Jupiter, il y a une bonne chance que certaines dépendances soient déjà installées. En revanche, si vous travaillez avec un nouvel environnement Python ou dans un logiciel d'édition de code comme VS Code, il sera peut être nécessaire d'installer `ipykernel` (`pip install ipykernel`) et `nbformat` (`pip install nbformat`).

[^5]: Nous utiliserons aussi Numpy mais cette librairie est automatiquement téléchargée avec l'installation de Pandas.

[^6]: Kaleido est une bibliothèque python de génération d'images statiques (comme les formats JPG et SVG) et sera donc nécessaire pour exporter des visualisations statiques.

