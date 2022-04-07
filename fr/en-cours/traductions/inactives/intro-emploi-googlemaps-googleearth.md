---
title: Introduction à l’emploi de Google Maps et Google Earth
collection: lessons
layout: lesson
slug: e.g. introduction-to-sentiment-analysis
date: YYYY-MM-DD
translation_date: YYYY-MM-DD (translations only)
authors:
- Jim Clifford
- Josh MacFadyen
- Daniel Macfarlane
reviewers:
- Finn Arne Jørgensen
- Sarah Simpkin
editors:
- Adam Crymble
translator:
- Olivier Jacquot
translation-editor:
- Prénom Nom
translation-reviewer:
- Prénom Nom
original: googlemaps-googleearth
review-ticket: 
difficulty: 1
activity: presenting
topics:
 - mapping
abstract: "Google Maps et Google Earth offrent une excellente alternative pour créer des cartes numériques et géolocaliser des données. Avec un compte Google, vous pouvez créer et modifier des cartes personnelles en cliquant sur Mes Lieux."
avatar_alt: An old man consulting a large globe with a compass
---

{% include toc.html %}

{% comment %} 

##Sommaire##
- Google Maps
	- Prise en main
	- Création de calques vectoriels
	- Partagez votre carte personnalisée
- Google Earth
- KML : Fichiers de langage à base de balises géolocales
- Ajout de cartes historiques numérisées 

{% endcomment %} 

##Google Maps##

Google My Maps et Google Earth offrent une excellente alternative pour créer des cartes numériques et géolocaliser des données. Avec un compte Google, vous pouvez créer et modifier des cartes personnelles en cliquant sur Mes lieux.

My Maps vous permet de choisir entre différentes cartes de base (y compris les cartes satellites, physiques et standard habituelles) et d'ajouter des points, des lignes et des polygones. Il est également possible d'importer des données à partir d'une feuille de calcul si vous avez des colonnes contenant des informations géographiques (longitudes et latitudes ou noms de lieux). Ceci automatise une tâche qui était autrefois fastidieuse et connue sous le nom de géocodage. Non seulement c'est l'un des moyens les plus faciles pour commencer à localiser des informations historiques sur une carte, mais l’outil offre également la puissance du moteur de recherche de Google. Ainsi, l’outil permet d’identifier et de géolocaliser des noms de lieux peu courants ou inconnus repérés dans des documents historiques, des articles de revues ou des livres, en marquant plusieurs endroits pour explorer comment ils sont reliés géographiquement les uns aux autres. Vos cartes personnelles sont stockées par Google (dans son nuage), ce qui signifie que vous pourrez y accéder depuis n'importe quel ordinateur avec une connexion Internet. Vous pouvez les conserver à titre privé ou les embarquer sur votre site Web ou votre blog. Enfin, vous avez la possibilité d'exporter vos points, lignes et polygones sous forme de fichiers KML et de les ouvrir dans Google Earth ou Quantum GIS.

##Commencer
 * Ouvrez votre navigateur préféré.
 * Connectez-vous à [Google My Maps](https://www.google.com/maps/d/).
 * Connectez-vous avec votre compte Google si vous n'êtes pas encore connecté (suivez les instructions simples pour créer un compte si nécessaire).

![Illustration 1](https://programminghistorian.org/images/googlemaps-googleearth/geo1.png)

*Illustration 1*

* Cliquez sur le point d'interrogation en bas à droite et cliquez sur Visite guidée pour une introduction au fonctionnement de My Maps.

![Illustration 2](https://programminghistorian.org/images/googlemaps-googleearth/geo2.png)

*Illustration 2*

 - Dans le coin supérieur gauche, un menu avec le titre "Carte sans titre" apparaît. En cliquant sur le titre, vous pouvez le renommer "Ma carte de test" ou ce que vous préférez.
 - Ensuite, employez la barre de recherche. Essayez de trouver un emplacement pour votre projet de recherche. Cliquez ensuite sur l'emplacement et ajoutez-le à votre carte en choisissant "Add to map". C'est la façon la plus simple d'ajouter des points à votre nouvelle carte. Essayez de trouver des noms de lieux historiques qui n'existent plus (comme Berlin ou Constantinople en Ontario). Vous obtiendrez des résultats mitigés, dans lesquels Google identifie souvent correctement l'emplacement mais propose également des alternatives incorrectes. Il est important de garder cela à l'esprit lors de la création d'une feuille de calcul. Il est généralement préférable d'utiliser des noms de lieux modernes pour éviter le risque que Google choisisse le mauvais Constantinople.

![Illustration 3](https://programminghistorian.org/images/googlemaps-googleearth/geo3.png)

*Illustration 3*

![Illustration 4](https://programminghistorian.org/images/googlemaps-googleearth/geo4.png)

*Illustration 4*

 - Ensuite, vous pouvez importer un ensemble de données. Cliquez sur le bouton Importer sous le calque sans titre.

![](https://programminghistorian.org/images/googlemaps-googleearth/geo5.png)

 - Une nouvelle fenêtre s'ouvre et vous donne la possibilité d'importer un fichier CSV (comma separated value), XLXS (Microsoft Excel), KML (format de fichier spatial de Google) ou GPX (format de fichier GPS). Il s'agit de deux formats de feuilles de calcul courants : CSV est simple et universel, XLXS est le format MS Excel. Vous pouvez également travailler avec un tableur Google à partir de votre compte Drive. 

![Illustration 6](https://programminghistorian.org/images/googlemaps-googleearth/geo6.png)

 - Téléchargez ce jeu de données et enregistrez-le sur votre ordinateur : [UK Global Fat Supply CSV file](https://github.com/programminghistorian/jekyll/files/148984/UK.Global.Fat.Supply.1894-1896.-.Sheet1.csv.zip). Si vous ouvrez le fichier dans Excel ou dans un autre tableur, vous trouverez un ensemble de données simple à deux colonnes avec une liste des différents types de graisses et la liste des lieux associés. Ces données ont été créées à partir des tableaux des importations britanniques de 1896.

![Illustration 7](https://programminghistorian.org/images/googlemaps-googleearth/geo7.png)
 
 - Faites glisser le fichier dans la fenêtre qui s'est ouverte dans Google Maps.
 - Vous serez ensuite invité à choisir la colonne que Google doit utiliser pour identifier l'emplacement à placer sur la carte. Sélectionnez "Place".
 
![Illustration 8](https://programminghistorian.org/images/googlemaps-googleearth/geo8.png)

 - Vous serez ensuite de nouveau invité à choisir la colonne à utiliser pour l'étiquette qui va servir à nommer le point de repère sur la carte. Choisissez "Commodity" et cliquez sur "Finish".
 - Vous devriez maintenant disposer d’une carte mondiale des principaux exportateurs de matières grasses vers la Grande-Bretagne au milieu des années 1890.

![Illustration 9](https://programminghistorian.org/images/googlemaps-googleearth/geo9.png)

 - Vous pouvez maintenant explorer les données plus en détail.
 - Pour changer le style pour distinguer les différents types de graisses, cliquez sur le calque "UK Global Fats" donnant les chiffres globaux pour le Royaume-Uni, puis cliquez sur "Style" et enfin sur "Uniform Style" et changez-le en "Style by Data Column: Commodities". Dans le navigateur de gauche, sur la droite, la légende indiquera le nombre d'occurrences de chaque style entre parenthèses, par exemple "Flax Seeds (4)".

![Illustration 10](https://programminghistorian.org/images/googlemaps-googleearth/geo10.png)

![Illustration 11](https://programminghistorian.org/images/googlemaps-googleearth/geo11.png)

 - Continuez à jouer avec les options.
 - Les fonctionnalités offertes forment un puissant outil pour afficher un ensemble de données historiques. L'outil a pourtant ses limites, car Google Maps n'importe que les 100 premières lignes d'une feuille de calcul. À ce stade, il ne vous permet d'inclure que trois ensembles de données dans une carte, soit un maximum de 300 entrées.
 
![Illustration 12](https://programminghistorian.org/images/googlemaps-googleearth/geo12.png)

##Création de calques vectoriels

Vous pouvez également créer de nouvelles couches cartographiques (appelées plus proprement des calques vectoriels). Les calques vectoriels forment l'une des principales caractéristique de la cartographie numérique (y compris les systèmes d'information géographiques - SIG -). Il s'agit simplement de points, de lignes ou de polygones utilisés pour représenter des entités géographiques. Les points peuvent être utilisés pour identifier et étiqueter les emplacements clés, les lignes sont souvent utilisées pour les rues ou les voies ferrées, et les polygones vous permettent de représenter des zones (champs, bâtiments, quartiers de ville, etc.). Ils fonctionnent de la même manière dans Google Maps et dans les SIG. La grande limitation est que vous ne pouvez ajouter que des informations limitées dans les tables de la base de données associées aux points, lignes ou polygones. Cela constitue un frein dès lors que l'on souhaite développer un important projet  de cartographie numérique, mais ce n'est pas un problème lorsqu'on débute. Dans Google Maps, vous pouvez ajouter une étiquette, une description textuelle et des liens vers un site Web ou une photo. Davantage d'informations sur la création de vecteurs historiques dans un SIG sont disponibles dans [Creating New Vector Layers in QGIS 2.0](https://programminghistorian.org/lessons/vector-layers-qgis).

 - Pour ajouter un calque, vous pouvez cliquer sur le calque qui a été créé pour vous dans la boîte de menu, avec le nom "Untitled Layer". Cliquez sur "Untitled Layer" et renommez-le "Layer 1". Vous pouvez aussi créer un autre calque : cliquez sur le bouton "Add layer" : ceci ajoutera un nouveau calque sans titre "Untitled Layer" que vous pouvez nommer "Calque 2". Cela devrait ressembler à ceci :

![Illustration 13](https://programminghistorian.org/images/googlemaps-googleearth/geo13.png)

 - Notez la case à cocher à la gauche du calque - en la décochant le calque est désactivé (c'est-à-dire que le calque et ses informations n'apparaissent plus sur la carte). Décochez le calque "UK Global Fats" et cliquez sur le Calque 1.
 - Avant d'ajouter des calques vectoriels, il faut réfléchir au fond de carte de base à utiliser. Au bas de la fenêtre du menu, la ligne "Base map" permet de choisir son fond de carte. Une carte de base est une carte fournissant des informations de référence telles que les routes, les frontières, les reliefs, etc. sur lesquelles on peut placer des calques contenant d'autres types d'informations spatiales. Google Maps vous permet de choisir parmi une variété de cartes de base, selon le type de carte que vous souhaitez créer. L'imagerie satellitaire est en train de devenir une forme standard de carte de base, mais elle sa riche d'informations peut nuire à d'autres caractéristiques de la carte que vous essaierez de mettre en évidence. Parmi les solutions de rechange simples, citons la carte "Light Landmass", ou encore la "Light Political" si vous avez besoin de frontières politiques.
 - Cliquez sur la flèche située à droite de la ligne "Base map" dans la fenêtre ; un sous-menu apparaît vous permettant de choisir différents types de cartes de base. Choisissez "Satellite.
 - Commencez par ajouter quelques Placemarks (l'équivalent d'un point pour Google). Cliquez sur le bouton "Add markers" sous la barre de recherche en haut de la fenêtre. Cliquez à l'endroit de la carte où vous voulez que le repère apparaisse.

![Illustration 14](https://programminghistorian.org/images/googlemaps-googleearth/geo14.png)

 - Une boîte de dialogue apparaîtra et vous donnera la possibilité d'étiqueter la marque et d'ajouter une description dans la boîte de texte. Nous avons ajouté Charlottetown et inclus qu'elle a été fondée en 1765 dans la boîte de description.

![Illustration 15](https://programminghistorian.org/images/googlemaps-googleearth/geo15.png) 

 -  Ajoutez quelques points supplémentaires, y compris les étiquettes et les descriptions.
 - Vous remarquerez que votre marque apparaît maintenant sous le Calque 1 à gauche de l'écran dans votre fenêtre de menu. Il est possible de changer la forme et la couleur des icônes si vous cliquez sur le symbole juste à droite du nom de la marque. De même, le lien figurant sous le titre Calque 1, permet de grouper les lieux et d'agir sur les Étiquettes. Un clic sur le nom du point figurant sur le calque permet de le modifier (ajouter une photographie, modifier le style, éditer les rubriques.

![Illustration 16](https://programminghistorian.org/images/googlemaps-googleearth/geo16.png)

 - Nous allons maintenant ajouter quelques lignes et formes (appelées polygones dans le logiciel SIG). L'ajout de lignes et de polygones est un processus très similaire. Nous allons tracer quelques lignes dans un nouveau calque (les différents types de points, lignes et formes doivent être dans des calques séparés).
 - Sélectionnez le Calque 2 dans votre menu (le calque sélectionné est identifié par une barre verticale bleue à gauche du calque).
 - Cliquez sur l'icône "Add directions".
 - Choisissez une route et cliquez avec votre souris le long de celle-ci, en traçant l'itinéraire pendant un certain temps. Appuyez sur "Entrée" lorsque vous voulez terminer la ligne.
 - Comme auparavant, vous pouvez ajouter une étiquette (c’est-à-dire nommer le trajet) et des informations descriptives.

  ![Illustration 18](https://programminghistorian.org/images/googlemaps-googleearth/geo18.png)

 - Pour créer un polygone (une forme), vous pouvez relier des points pour créer une forme fermée. Pour ce faire, cliquez sur l'icône "Draw a lign" directement à droite du symbole "Add markers" et dessinez un contour en posant des points avec votre souris puis terminez en revenant à votre point de départ pour fermer le polygone dessiné.
 - Appuyez sur "Save" lorsque vous voulez enregistrer votre polygone.
 - Vous pouvez également modifier la couleur et la largeur de la ligne et de l'aire. Pour ce faire, trouvez l'aire que vous avez dessinée dans le Calque 2 du menu, et cliquez à droite de son nom.
 - Vous pouvez créer des formes simples, comme le champ d'un agriculteur, ou des formes beaucoup plus complexes, comme le contour d'une ville (voir les exemples ci-dessous). N'hésitez pas à expérimenter avec la création de lignes et de polygones.
![Illustration 19](https://programminghistorian.org/images/googlemaps-googleearth/geo19.png) 
![Illustration 20](https://programminghistorian.org/images/googlemaps-googleearth/geo20.png)
 - Comme les repères et les lignes, vous pouvez changer le nom et la description d'un polygone. Vous pouvez également modifier la couleur et la largeur de ligne en cliquant sur l'icône à droite de votre nom de polygone dans le menu déroulant. Ici, vous pouvez également modifier la transparence, dont il est question ci-dessous.
 - Notez que la zone délimitée (c'est-à-dire l'intérieur) d'un polygone est ombrée de la même couleur que le contour du polygone. Vous pouvez changer l'opacité de cet ombrage en jouant avec le curseur "Polygon transparency" qui modifie l'opacité du polygone par rapport à l'image de fond (le fond de carte).

##Partagez votre carte personnalisée
 
 - La meilleure façon de partager la carte en ligne est d'utiliser le bouton "**Share**" dans le menu. Il fournit un lien qui peut être partagé dans un email ou via les médias sociaux comme Google+, Facebook ou Twitter.
 - Une autre façon de partager une version dynamique de votre carte est de l'intégrer dans un blog ou un site web en utilisant le menu déroulant de l'option "Embed on my site" à droite du bouton de sauvegarde. En sélectionnant cette option, une fenêtre permet de récupérer un balise `iframe` que vous pouvez ensuite insérer dans un site HTML. Vous pouvez modifier la hauteur et la largeur du cadre en changeant les chiffres figurant entre guillemets.
 - Note : il n'y a actuellement aucun moyen de définir l'échelle par défaut ou les options de légende de la carte intégrée, mais si vous devez éliminer la légende de la carte qui apparaît sur votre site HTML, vous pouvez le faire en réduisant la largeur du code `iframe` à 580 ou moins.
 - Vous pouvez également exporter les données sous forme d'un fichier KML/KMZ en utilisant le même menu déroulant. Il vous donnera l'option d'exporter toute la carte ou de ne sélectionner qu'un calque en particulier. Essayez d'exporter le calque "UK Global Fats" en tant que calque KML. Vous pourrez importer ces données dans d'autres programmes, dont Google Earth et QGIS. C'est une fonction importante, car elle vous permet de commencer à travailler avec des cartes numériques à l'aide de Google Map tout en continuant à exporter votre travail dans une base de données SIG à l'avenir.
 - Vous pouvez arrêter la leçon ici si vous pensez que ce service gratuit de Google Map fournit tous les outils dont vous avez besoin pour votre sujet de recherche. Vous pouvez aussi continuer et en apprendre davantage sur Google Earth et sur le système d'information géographique QGIS dans la leçon 2, QGIS.

![Illustration 21](https://programminghistorian.org/images/googlemaps-googleearth/geo21.png)
![Illustration 22](https://programminghistorian.org/images/googlemaps-googleearth/geo22.png)

## Google Earth
Google Earth fonctionne à peu près de la même manière que Google Maps, mais avec des fonctionnalités supplémentaires. Par exemple, il fournit des cartes 3D et l'accès à des données provenant de nombreuses sources tierces, y compris des collections de cartes historiques. Google Maps ne vous oblige pas à installer un logiciel et vos cartes sont enregistrées dans le nuage. En revanche, Google Earth nécessite l'installation d'un logiciel et n'est pas basé sur le cloud, bien que les cartes que vous créez puissent être exportées.

 - Installer Google Earth : [http://www.google.com/earth/index.html](http://www.google.com/earth/index.html)
 - Ouvrez le programme et familiarisez-vous avec le globe numérique. Utilisez le menu pour ajouter et supprimer des couches d'informations. C'est très semblable à la façon dont fonctionnent les programmes SIG plus avancés. Vous pouvez ajouter et supprimer différents types d'informations géographiques, y compris les limites politiques (polygones), les routes (lignes) et les lieux (points). Voir les flèches rouges dans l'image suivante pour l'emplacement de ces calques.

[Illustration 22 : Cliquez pour agrandir l'image](https://programminghistorian.org/images/googlemaps-googleearth/geo23.png) 
 -  Remarquez que sous la rubrique "Layers" en bas à gauche du navigateur de gauche, Google fournit un certain nombre de calques prêts à l'emploi qui peuvent être activés en cochant la case correspondante.

![Illustration 23](https://programminghistorian.org/images/googlemaps-googleearth/geo24.png) 
 - Google Earth contient également des cartes historiques numérisées et des photographies aériennes (dans les SIG, ces types de cartes, qui sont composées de pixels, sont appelées données matricielles). Sous "Gallery", vous pouvez trouver et cliquer sur "Rumsey Historical Maps". Cela ajoutera des icônes partout dans le monde (avec une concentration aux États-Unis) de cartes scannées qui ont été géoréférencées (étirées et épinglées pour correspondre à un emplacement) sur le globe numérique. Ceci donne un aperçu d'une méthodologie clé des SIG historiques. (Vous pouvez également trouver des couches cartographiques historiques et d'autres couches du Système d'Information Géographique Historique (HGSI) dans Earth Gallery). Prenez le temps d'explorer un certain nombre de cartes historiques. Voyez s'il y a des cartes incluses dans la collection Rumsey qui pourraient être utiles pour votre recherche ou votre enseignement. (Vous pouvez trouver beaucoup plus de cartes numérisées, mais non géoréférencées, à l'adresse suivante [www.davidrumsey.com](http://www.davidrumsey.com/).)

![Illustration 24](https://programminghistorian.org/images/googlemaps-googleearth/geo25.png) 
 - Vous devrez peut-être faire un zoom avant pour voir toutes les icônes de la carte. Pouvez-vous trouver le Globe mondial de 1812 ?

![Illustration 25](https://programminghistorian.org/images/googlemaps-googleearth/geo26.png)

  - Une fois que vous cliquez sur une icône, un panneau d'information s'affiche. Cliquez sur la vignette de la carte pour voir la carte collée sur le globe numérique. Nous apprendrons à géoréférencer correctement les cartes dans la leçon [Georeferencing in QGIS 2.0](https://programminghistorian.org/lessons/georeferencing-qgis).

![Illustration 26](https://programminghistorian.org/images/googlemaps-googleearth/geo27.png)

![Illustration 27: Cliquez pour agrandir l'image](https://programminghistorian.org/images/googlemaps-googleearth/geo28.png)

## Fichiers KML: Keyhole Markup Language

 - Google a développé un format de fichier pour sauvegarder et partager les données cartographiques : KML. C'est l'abréviation de Keyhole Markup Language, et c'est un type de fichier très portable (c'est-à-dire qu'un KML peut être utilisé avec différents types de logiciels SIG) qui peut stocker de nombreux types différents de données SIG, y compris des données vectorielles.
 - Les cartes et les images que vous créez dans Google Maps et Google Earth peuvent être sauvegardées sous forme de fichiers KML. Cela signifie que vous pouvez sauvegarder le travail effectué dans Google Maps ou Google Earth. Avec les fichiers KML, vous pouvez transférer des données entre ces deux plates-formes et importer vos données cartographiques dans QGIS ou ArcGIS.
 - Par exemple, vous pouvez importer les données que vous avez créées dans Google Maps. Si vous avez créé une carte dans l'exercice ci-dessus, vous pouvez la trouver en cliquant sur "Open Map" sur le bouton My Maps de la page d'accueil. Cliquez sur l'icône du dossier à gauche de la légende sous le titre de la carte et cliquez sur "export to KML". (Vous pouvez également télécharger et explorer la carte de la voie maritime de [Dan Macfarlane](https://github.com/programminghistorian/jekyll/files/148993/seaway.zip) pour cette partie de l'exercice).
 
## Importer votre fichier KML dans Google Earth
 - Téléchargez le fichier KML depuis Google Maps (comme décrit ci-dessus).
 - Double-cliquez sur le fichier KML dans votre dossier de téléchargement.
 - Trouvez les données dans le dossier temporaire de Google Earth.

![Illustration 28: Cliquez pour agrandir l'image](https://programminghistorian.org/images/googlemaps-googleearth/geo29.png)

• Vous pouvez maintenant explorer ces éléments cartographiques en 3D ou ajouter de nouvelles lignes, points et polygones à l'aide des différentes icônes situées en haut à gauche de votre fenêtre Google Earth (voir image ci-dessous). Cela fonctionne essentiellement de la même manière que pour Google Maps, bien qu'il y ait plus de fonctionnalités et d'options. Dans la carte de la Voie maritime de Dan, les anciens canaux et le tracé actuel de la voie maritime ont été tracés dans différentes couleurs et largeurs de lignes à l'aide de la fonction de ligne (cela a été rendu possible grâce à la superposition de cartes historiques, qui est décrite ci-dessous), tandis que divers éléments ont été marqués avec les Placemarks appropriées. Pour ceux qui le souhaitent, il est également possible d'enregistrer une visite guidée qui peut être utile pour des présentations ou pour l'enseignement (lorsque l'icône "record a tour" est sélectionnée, les options d'enregistrement apparaissent en bas à gauche de la fenêtre).

![Illustration 29](https://programminghistorian.org/images/googlemaps-googleearth/geo30.png)

 - Essayez d'ajouter une nouvelle fonction aux données de la voie maritime de Dan. Nous avons créé un polygone (dans la terminologie SIG, un polygone est une forme fermée de n'importe quel type - un cercle, un hexagone ou un carré) du Lake St. Clair sur l'image suivante. Trouvez le Lake St. Clair (à l'est de Detroit) et essayez d'ajouter un polygone. 

![Illustration 30: Cliquez pour agrandir l'image](https://programminghistorian.org/images/googlemaps-googleearth/geo31.png)

![Illustration 31](https://programminghistorian.org/images/googlemaps-googleearth/geo32.png) 

 - Étiquetez le nouveau polygone Lake St. Clair. Vous pouvez ensuite le faire glisser sur les données de la Voie maritime de Dan et l'ajouter à la collection. Vous pouvez ensuite sauvegarder cette version étendue de la carte de la Voie maritime sous forme de fichier KML à la partager par courriel, la télécharger dans Google Maps ou en exporter les données dans QGIS. Trouvez l'option d'enregistrement en cliquant avec le bouton droit de la souris sur la collection de la Voie maritime et choisissez Save Place As ou Email.

![Illustration 32](https://programminghistorian.org/images/googlemaps-googleearth/geo33.png)

![Illustration 33](https://programminghistorian.org/images/googlemaps-googleearth/geo34.png)

![Illustration 34](https://programminghistorian.org/images/googlemaps-googleearth/geo35.png)

## Ajouter de cartes historiques numérisées
Dans Google Earth, vous pouvez télécharger une copie numérique d'une carte historique. Il peut s'agir d'une carte qui a été numérisée ou d'une image nativement numérique (pour des conseils sur la recherche de cartes historiques en ligne, voir l'encadré) : [Mobile Mapping and Historical GIS in the Field](http://niche-canada.org/2011/12/14/mobile-mapping-and-historical-gis-in-the-field/)). L'objectif principal du téléchargement d'une carte numérique, d'un point de vue historique, est de la placer au-dessus d'une image Google Earth dans le navigateur. C'est ce qu'on appelle une superposition. L'exécution d'une superposition permet des comparaisons utiles de l'évolution dans le temps.

 - Commencez par identifier les images que vous voulez utiliser : l'image dans Google Earth, et la carte que vous voulez superposer. Pour la carte que vous voulez superposer, le fichier peut être au format JPEG ou TIFF, mais pas PDF.
 - Dans Google Earth, identifiez la zone de la carte que vous souhaitez superposer. Notez que vous pouvez remonter dans le temps (c.-à-d. regarder des photos satellites plus anciennes) en cliquant sur l'icône "Show historical imagery" dans la barre d'outils supérieure, puis en ajustant le curseur d'échelle de temps qui apparaîtra. 
![Illustration 35](https://programminghistorian.org/images/googlemaps-googleearth/geo36.png)

![Illustration 36](https://programminghistorian.org/images/googlemaps-googleearth/geo37.png)
Une fois que vous avez identifié les images que vous prévoyez d'utiliser, cliquez sur l'icône "Add Image Overlay" dans la barre d'outils supérieure.

![Illustration 37](https://programminghistorian.org/images/googlemaps-googleearth/geo38.png)
Une nouvelle fenêtre apparaîtra. Commencez par lui donner un titre différent si vous le souhaitez (la valeur par défaut est "Untitled Image Overlay").

![Illustration 38: Cliquez pour agrandir l'image](https://programminghistorian.org/images/googlemaps-googleearth/geo39.png)

 - A la droite du champ "Link", cliquez sur le bouton "Browse" pour sélectionner dans vos fichiers la carte sur laquelle vous souhaitez superposer l'image.
 - Déplacez la fenêtre New Image Overlay (ne la fermez pas ou cliquez sur "Cancel" ou "OK") pour que vous puissiez voir le navigateur Google Earth. La carte que vous avez téléchargée apparaîtra maintenant au-dessus de l'image satellite Google Earth dans le navigateur Google Earth.
 - Des marqueurs verts fluorescents apparaissent au milieu et sur les bords de la carte téléchargée. Ceux-ci peuvent être utilisés pour étirer, rétrécir et déplacer la carte afin qu'elle s'aligne correctement avec l'image satellite. Il s'agit d'une forme simple de géoréférencement (voir [Georeferencing in QGIS 2.0](https://programminghistorian.org/lessons/georeferencing-qgis)). L'image ci-dessous montre les étapes décrites ci-dessus à l'aide d'une vieille carte de la ville d'Aultsville superposée à l'imagerie satellite de Google datant de 2008, sur laquelle sont visibles les vestiges des routes de la ville et les fondations des bâtiments du fleuve Saint-Laurent (Aultsville était l'un des villages perdus inondés par le projet St. Lawrence Seaway et le Power Project).

![Illustration 39: Cliquez pour agrandir l'image](https://programminghistorian.org/images/googlemaps-googleearth/geo40.png)

 - De retour dans la fenêtre New Image Overlay, notez qu'il existe une gamme d'options (Description, View, Altitude, Refresh, Location) que vous pouvez sélectionner. À ce stade, vous n'avez probablement pas besoin de vous inquiéter à ce sujet, bien que vous puissiez souhaiter ajouter des informations sous l'onglet Description.
 - Une fois que vous êtes satisfait de votre superposition, dans la fenêtre New Image Overlay, cliquez sur OK dans le coin inférieur droit.
 - Vous voudrez sauvegarder votre travail. Sous File dans la barre de menus de votre ordinateur, vous avez deux options. Vous pouvez enregistrer une copie de l'image (File -> Save -> Save Image… / Fichier -> Enregistrer -> Enregistrer l'image...) que vous avez créée sur votre ordinateur au format jpg, et vous pouvez également enregistrer la superposition dans Google Earth pour qu'elle soit accessible ultérieurement (File -> Save -> Save My Places / Fichier -> Enregistrer -> Enregistrer Mes lieux). Cette dernière est enregistrés sous forme de fichier KML.
 -  Pour partager des fichiers KML, il vous suffit de localiser le fichier que vous avez enregistré sur votre ordinateur et de le télécharger sur votre site Web, vos réseaux sociaux ou l'envoyer en pièce jointe dans un courriel.
 
**Vous avez appris à utiliser Google Maps et Earth. Veillez à sauvegarder votre travail !**

*Cette leçon fait partie du programme [Geospatial Historian](http://geospatialhistorian.wordpress.com/)*

Super ! Vous êtes maintenant prêt à passer à la [leçon suivante](https://programminghistorian.org/en/lessons/qgis-layers).

----------

#####A propos des auteurs
Jim Clifford est professeur adjoint au département d'histoire de l'Université du Saskatchewan.
Josh MacFadyen est coordonnateur de la Nouvelle initiative Canadienne en histoire de l'environnement (NiCHE).
Daniel Macfarlane est chercheur invité à l'École d'études canadiennes de l'Université Carleton.

#####Citation suggérée
Jim Clifford, Josh MacFadyen et Daniel Macfarlane, "Introduction à l’emploi de Google Maps et Google Earth", The Programming Historian 2 (2013), [https://programminghistorian.org/en/lessons/googlemaps-googleearth](https://programminghistorian.org/en/lessons/googlemaps-googleearth).
