# BLOC 1 =======================================================================
# Imports 
import numpy as numpy
import pandas as pd
import plotly.express as px
# Importing for saving the html files
from images_interactives.save import save_html
# END BLOC 1 ===================================================================

# BLOC 2 =======================================================================
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

# La colonne "inclusif" contient des chaînes de caractères "true" et "false" 
# et pas des booléens, on doit donc arranger ça.
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

# Création d'une colonne "A majorité féminine" qui indique s'il y avait plus 
# d'autrices que d'auteurs
df["maj_feminine"] = df["pourcentage_femme"] >= 0.5
# END BLOC 2 ===================================================================

# BLOC 3 =======================================================================
# Création d'un nouveau DataFrame
articles_par_discipline : pd.Series = df.\
                                groupby(["discipline"], as_index = False).\
                                size()
articles_par_discipline
# END BLOC 3 ===================================================================

# BLOC 4 =======================================================================
# Créé le diagramme en barres (bar chart) en utilisant la fonction .bar()
fig = px.bar(articles_par_discipline, x = "discipline", y = "size")

# Affiche la figure en utilisant la méthode .show()
# fig.show()
fig.update_layout(width = 800,height = 600)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-1.png")
save_html(fig, 1, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-1.html")
# END BLOC 4 ===================================================================

# BLOC 5 =======================================================================
# Créé un bar chart en utilisant la fonction .bar()
fig = px.bar(
    articles_par_discipline,
    x="discipline",
    y="size",
    title="Titre de votre choix",
    labels={"size": "Nombres d'articles"},

    # Notez que l'argument "color" prend une chaine de caractères se référent à 
    # la colonne "maj_feminine" du jeu de donnée
    color="discipline"
)

# fig.show()
fig.update_layout(width = 800,height = 600)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-2.png")
save_html(fig,2, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-2.html")
# END BLOC 5 ===================================================================

# BLOC 6 =======================================================================
# Créé un nouveau DataFrame contenant le nombre de d'articles écrits par une 
# majorité de femmes par année
evolution_nbe_articles_par_annee = df.\
    groupby(["discipline", "annee_publication"], as_index=False).\
    size()
# END BLOC 6 ===================================================================

# BLOC 7 =======================================================================
# Créé des courbes avec la fonction px.line() et ajoute quelques customisations
fig = px.line(
    evolution_nbe_articles_par_annee,
    x = "annee_publication",
    y = "size",
    # title = "Ajouter le titre de votre choix",
    labels = {"size" : "Nombre d'articles publiés"},
    color = "discipline"
)

# fig.show()
fig.update_layout(width = 800,height = 600)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-3.png")
save_html(fig,3, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-3.html")
# END BLOC 7 ===================================================================

# BLOC 8 =======================================================================
fig.update_layout(
    font_family = "Courrier New",   # Modification de la police
    font_color = "blue",            # Modification de la couleur du texte
    legend_title_font_color = "red",# Modification de la couleur du titre de la légende
    title = "Un titre formatté"
)

# fig.show()
fig.update_layout(width = 800,height = 600)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-4.png")
save_html(fig,4, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-4.html")
# END BLOC 8 ===================================================================

# BLOC 9 =======================================================================
proportion_genre_classe = df.\
    groupby(["revue","discipline"], as_index=False)[["genre","classe"]].\
    agg(
        proportion_genre = ("genre", lambda x : 100 * x.mean()),
        proportion_classe = ("classe", lambda x : 100 * x.mean()),
    )
# END BLOC 9 ===================================================================

# BLOC 10 ======================================================================
fig = px.scatter(
    proportion_genre_classe,
    x="proportion_classe",
    y="proportion_genre",
    color="discipline", 
    # title="Titre de votre choix",
)
# fig.show()
fig.update_layout(width = 800,height = 600)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-5.png")
save_html(fig,5, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-5.html")
# END BLOC 10 ==================================================================

# BLOC 11 ======================================================================
proportion_par_discipline_maj_feminine = df.\
    groupby(["maj_feminine","discipline"], as_index=False)[["genre"]].\
    agg(proportion_genre = ("genre", lambda x : 100 * x.mean()))

# Utilisation de la fonction px.bar pour spécifier le type de représentation
fig = px.bar(
    proportion_par_discipline_maj_feminine,
    x="discipline",
    y="proportion_genre",
    facet_col="maj_feminine",  # On utilise le paramètre facet_col pour spécifier la colonne qui doit distinguer les figures
    color="discipline",
    # title="Titre de votre choix",
)
# fig.show()
fig.update_layout(width = 800,height = 600)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-6.png")
save_html(fig,6, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-6.html")
# END BLOC 11 ==================================================================

# BLOC 12 ======================================================================
proportion_genre_animation = df.groupby(["annee_publication","discipline"],
                                as_index = False).size()
# On utilise px.bar pour créer un diagramme en barres
fig = px.bar(
    proportion_genre_animation,
    x="discipline",
    y="size",
    labels={"size": "Nombre d'articles mentionnant le genre publiés"},
    range_y=[0,500],  # Le paramètre range_y permet de customiser l'intervalede l'axe y
    color="discipline",
    # title="Add a title here",
    animation_frame="annee_publication", # Use animation_frame to specify which variable to measure for change
)
# fig.show()
fig.update_layout(width = 800,height = 600)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-7.png")
save_html(fig,7, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-7.html")
# END BLOC 12 ==================================================================

# BLOC 13 ======================================================================
fig = px.scatter(
    proportion_genre_classe,
    x="proportion_classe",
    y="proportion_genre",
    color="discipline", 
    # title="Titre de votre choix",
    # labels = {}
)
# END BLOC 13 ==================================================================

# BLOC 14 ======================================================================
# Nous utilisons la méthode .update_layout pour ajouter le menu déroulant
fig.update_layout(
    updatemenus = [dict(
        buttons = [
            # Création de la liste de boutson pour stocker un dictionnaire pour chaque option du menu déroulant.
            dict(
                label = "Toutes les disciplines", # Nom pour ma première vue
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
                label = "Géographie", # Nom pour ma deuxième vue
                method = "update",
                args = [
                    # Cette vue montre les seulement la première discipline
                    {"visible" : [True, False, False, False]}, 
                    {
                        "title" : "Géographie",
                        "xaxis" : {"title" : "Part des articles mentionnant la classe"},
                        "yaxis" : {"title" : "Part des articles mentionnant le genre"}
                    }
                ]
            ),
            dict(
                label = "Sociologie", # Nom pour ma troisième vue
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
                label = "Économie", # Nom pour ma quatrième vue
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
                label = "Études de Genre", # Nom pour ma cinquième vue
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

# fig.show()
fig.update_layout(width = 1000,height = 600)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-8.png")
save_html(fig,8, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-8.html")
# END BLOC 14 ==================================================================

# BLOC 15 ======================================================================
import plotly.graph_objects as go 
# END BLOC 15 ==================================================================

# BLOC 16 ======================================================================
# Résultat du type de la figure
print(type(fig))

# <class 'plotly.graph_objs._figure.Figure'>
# END BLOC 16 ==================================================================

# BLOC 17 ======================================================================
# print(fig.to_dict())
print(fig.to_json(pretty = True)[0:500] + "\n...")

#  {
#   "data": [
#     {
#       "hovertemplate": "discipline=Sociologie\u003cbr\u003eproportion_classe=%{x}\u003cbr\u003eproportion_genre=%{y}\u003cextra\u003e\u003c\u002fextra\u003e",
#       "legendgroup": "Sociologie",
#       "marker": {
#         "color": "#636efa",
#         "symbol": "circle"
#       },
#       "mode": "markers",
#       "name": "Sociologie",
#       "orientation": "v",
#       "showlegend": true,
#       "x": [
#         47.467166979362105,
#         26.486486486486488,
#         23.076923076923077,
#
# ...
# END BLOC 17 ==================================================================

# BLOC 18 ======================================================================
articles_par_discipline_mention_genre : pd.Series = df.\
    groupby(["discipline"], as_index = False).\
    size()
# END BLOC 18 ==================================================================

# BLOC 19 ======================================================================
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

# fig.show()
fig.update_layout(width = 800,height = 600)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-9.png")
save_html(fig,9, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-9.html")
# END BLOC 19 ==================================================================

# BLOC 20 ======================================================================
fig = px.bar(
    articles_par_discipline_mention_genre,
    x = "size", y = "discipline",
    orientation = "h",
    #title = "Titre de votre choix",
    labels = {"size" : "Nombre d'articles"}
)
# fig.show()
fig.update_layout(width = 800,height = 600)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-10.png")
save_html(fig,10, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-10.html")
# END BLOC 20 ==================================================================

# BLOC 21 ======================================================================
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

# fig.show()
fig.update_layout(width = 800,height = 600)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-11.png")
save_html(fig,11, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-11.html")
# END BLOC 21 ==================================================================

# BLOC 22 ======================================================================
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
# END BLOC 22 ==================================================================

# BLOC 23 ======================================================================
# 1 ligne, 3 colonnes
fig = make_subplots(rows = 1, cols = 3)
# END BLOC 23 ==================================================================

# BLOC 24 ======================================================================
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

fig.update_layout(width = 1200,height = 400)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-12.png")
save_html(fig,12, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-12.html")
# END BLOC 24 ==================================================================

# BLOC 25 ======================================================================
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
fig.update_layout(width = 1200,height = 400)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-13.png")
save_html(fig,13, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-13.html")
# END BLOC 25 ==================================================================

# BLOC 26 ======================================================================
fig.add_trace(
    # On utilise la fonction go.Box() pour spécifier qu'on créé un diagramme en boîte
    go.Box(
        y = pourcentage_d_auteurice_femme_si_genre.\
            get_group(True)["pourcentage_femme"],
        name = "Genre"),
        row = 1, col = 3 # puisque c'est la troisième, on le met sur la 3è colonne
)

# On ajoute le deuxième diagramme en boîte puisqu'on a 2 groupes distincts pour
# les articles avec et sans écriture inclusive
fig.add_trace(
    go.Box(
        y = pourcentage_d_auteurice_femme_si_genre.\
            get_group(False)["pourcentage_femme"],
        name = "Pas genre"),
    row = 1, col = 3 
)
fig.update_layout(width = 1200,height = 400)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-14.png")
save_html(fig,14, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-14.html")
# END BLOC 26 ==================================================================

# BLOC 27 ======================================================================
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

fig.update_layout(width = 1200)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-15.png")
save_html(fig,15, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-15.html")
# END BLOC 27 ==================================================================

# BLOC 28 ======================================================================
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
fig.update_layout(width = 1200,height = 650)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-16.png")
save_html(fig,16, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-16.html")
# END BLOC 28 ==================================================================

# BLOC 29 ======================================================================
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
fig.update_layout(width = 1200,height = 650, margin = {"b" : 100})
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-17.png")
save_html(fig,17, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-17.html")
# END BLOC 29 ==================================================================

# BLOC 30 ======================================================================
fig = px.line(
    evolution_nbe_articles_par_annee,
    x = "annee_publication",
    y = "size",
    # title = "Ajouter le titre de votre choix",
    labels = {"size" : "Nombre d'articles publiés"},
    color = "discipline"
)
# END BLOC 30 ==================================================================

# BLOC 31 ======================================================================
# fig.show()
fig.update_layout(width = 800,height = 600)
fig.write_image("./images_statiques/VISUALISATIONS-INTERACTIVES-PLOTLY-18.png")
save_html(fig,18, "./images_interactives/VISUALISATIONS-INTERACTIVES-PLOTLY-18.html")
# END BLOC 31 ==================================================================

# BLOC 32 ======================================================================
# Sauvegarde de la visualisation en format HTML (figure que nous avons conservé 
# sous la variable 'fig' pendant toute la leçon)
fig.write_html("nom_visualisation.html")
# END BLOC 32 ==================================================================

# BLOC 33 ======================================================================
# Export en images classiques (raster ?):
# fig.write_image("nom_visualisation.png")
# fig.write_image("nom_visualisation.jpeg")

# Export en images vectorielles :
# fig.write_image("nom_visualisation.svg")
# fig.write_image("nom_visualisation.pdf")
# END BLOC 33 ==================================================================