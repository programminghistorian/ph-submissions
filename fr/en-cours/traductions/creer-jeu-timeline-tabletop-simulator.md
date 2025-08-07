---
title: Créer un jeu de cartes Timeline pour une utilisation sur table et dans Tabletop Simulator
slug: creer-jeu-timeline-tabletop-simulator
original: designing-a-timeline-tabletop-simulator
layout: lesson
collection: lessons
date: 2024-03-18
translation_date: YYYY-MM-DD
authors:
- Mita Williams
reviewers:
- Chris Young
- Adam Porter
editors:
- Rolando Rodriguez
translator:
- Émeline Dandeu
translation-editor:
- 
translation-reviewer:
-
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/650
difficulty: 1
activity: transforming
topics: [website, creative-coding]
abstract: "Cette leçon vous montrera comment utiliser nanDECK pour créer et partager votre propre jeu de cartes, en version papier ou numérique, et l'utiliser pour tester les connaissances d'un groupe sur des événements historiques grâce à une mécanique de jeu de type *Timeline*. Cette leçon mettra également en avant les bonnes pratiques liées à la gestion d’images historiques numérisées."
avatar_alt: Image en noir et blanc représentant une carte à jouer as de pique, fabriquée par la National Playing Card Company
doi:  
---

{% include toc.html %}

## Introduction

Nous n'exigeons plus des élèves qu'ils mémorisent par cœur des tableaux d'événements historiques avec leurs dates, comme c'était le cas dans l'Amérique du milieu du dix-neuvième siècle[^1]. Sans entrer dans les divers débats[^2] sur l’intérêt d’enseigner ou non la chronologie en classe, cette leçon part du principe qu'il est utile « d'aider les élèves à développer de solides connaissances de base dans nos disciplines »[^3] et que les jeux constituent un excellent outil pour atteindre cet objectif.

Inviter les élèves à créer leurs propres jeux - ou à proposer une modification d’un jeu existant (un “mod”) - peut être l'occasion de leur apprendre à manipuler et à transformer des fichiers numériques en objets concrets, lesquels peuvent ensuite être réutilisés pour offrir d’enrichissantes expériences pédagogiques. Ce tutoriel montrera comment les élèves peuvent créer leur propre jeu, en version papier ou numérique, en s'appuyant sur la mécanique de construction chronologique popularisée par le jeu commercial de Frédéric Henry : Timeline.

Tout comme les auteurs ou les éditeurs utilisent des traitements de texte pour créer des livres imprimés, les concepteurs de jeux utilisent régulièrement des outils numériques pour réaliser des prototypes papier de leurs créations. Ce tutoriel vous présentera deux de ces outils numériques spécialisés : nanDECK d'Andrea Nini et Tabletop Simulator.

En tant qu'enseignant, vous aurez l'occasion d'attirer l'attention des élèves sur les différentes possibilités offertes par les versions papier et numériques d'un même objet informationnel. Grâce à la possibilité de jouer au même jeu à la fois physiquement et en ligne, les élèves pourront réfléchir à la manière dont le support influence l'expérience de jeu. Grâce à leur nouvelle capacité à modifier les éléments ou les pièces d’un jeu familier, les élèves pourront explorer ce qui se passe lorsque les règles d’un jeu bien connu sont modifiées[^4].


## Aperçu de la leçon

Cette leçon débute par une brève réflexion sur les jeux, envisagés comme une forme de littératie capable de produire de véritables expériences, tout en insistant sur l'importance d’enseigner la conception de jeux à tous. Elle reconnaît également que les jeux de société et les jeux vidéo sont déjà largement utilisés dans l’enseignement de l’histoire depuis au moins cinquante ans.

La leçon présente ensuite *Timeline*, un jeu commercial sur le thème de l'histoire, ainsi que certaines de ses variantes. Les mécaniques de jeu n'étant pas protégées par le droit d'auteur, vous pouvez utiliser celles de *Timeline* pour créer votre propre jeu, que ce soit pour jouer ou pour explorer l'histoire. Une fois ce cadre posé, le tutoriel présente deux outils numériques couramment utilisés par les concepteurs de jeux amateurs comme professionnels : nanDECK et Tabletop Simulator. Il décrit ensuite les étapes nécessaires pour générer son propre jeu de cartes inspiré de *Timeline* : d'abord en utilisant le modèle de jeu fourni par la traductrice et consacré à l’histoire de l’île de La Réunion - France ; puis avec les éléments d’un prototype de deck de 6 cartes que les lecteurs pourront télécharger et imprimer eux-mêmes.

## Jouer à l’ère du “Siècle ludique”

En 2013, le concepteur de jeux Eric Zimmerman a publié un « Manifesto for a Ludic Century »[^5] (Manifeste pour un siècle ludique) dans lequel il expose les principes suivants :


>**Le Siècle ludique est l’ère des jeux.**
>
>Quand l’information devient ludique, les expériences qui s’inspirent du jeu remplacent les média linéaires. L’expression médiatique et la culture, dans le Siècle ludique, sont de plus en plus systémiques, modulaires, modifiables et participatives. Les jeux sont une incarnation très directe de toutes ces caractéristiques.
>
>De plus en plus, les gens vont consacrer leur temps de loisir, consommer de l’art, du design, du divertissement sous forme de jeux – ou au moins sous forme d’expériences qui ressembleront beaucoup à des jeux.
>
>**Les jeux sont comme un langage à acquérir.**
>
>Les systèmes, le jeu, le design : ce ne sont pas seulement des aspects du Siècle ludique, ce sont aussi des éléments de l’alphabétisation ludique. Être alphabétisé, c’est être capable de créer et de comprendre du sens, c’est ce qui permet aux gens d’écrire (créer) et de lire (comprendre).
>
>Dans les dernières décennies, nous avons identifié de nouveaux types d’alphabétisation : visuelle, technologique… Mais dans le Siècle ludique, être vraiment alphabétisé, c’est aussi maîtriser le langage des jeux. La place prise par les jeux dans notre culture est à la fois la cause et la conséquence de l’alphabétisation aux jeux dans le Siècle ludique.
>
>**Dans le Siècle ludique, tout le monde sera game designer.**
>
>Les jeux modifient la nature de la consommation culturelle. La musique est jouée par les musiciens, mais la plupart des gens ne sont pas des musiciens – ils écoutent la musique que quelqu’un d’autre a faite. A l’opposé, les jeux requièrent une participation active.
>
>Le game design implique de maîtriser la logique des systèmes, la psychologie sociale, et d’être un bidouilleur de culture. Quand on joue a un jeu en profondeur, on est naturellement amené à penser comme un game designer – à le remanier, à tenter de comprendre comment il a été conçu, à le modifier pour trouver de nouvelles façons d’y jouer. Dans le Siècle ludique, au fur et à mesure que de plus en plus de personnes joueront en profondeur, la ligne de séparation entre joueurs et game designers sera de plus en plus ténue.


Ces principes clés renforcent l'idée que les jeux devraient être utilisés en classe afin de faciliter l'apprentissage, et que les élèves tireraient profit d'une introduction à la conception de jeux, leur fournissant les moyens de les modifier et d’en créer de nouveaux.

En ce qui concerne cet article, le lecteur n’a pas à être nécessairement convaincu que les jeux doivent continuer à jouer un rôle important dans l’enseignement et l’apprentissage de l’histoire[^6]. Néanmoins, les lecteurs hésitants quant à la place des jeux dans l'éducation sont invités à lire la partie « Why Games » de l'article « Interactive Fiction in the Humanities Classroom: How to Create Interactive Text Games Using Twine »[^7].

## Qu'est-ce qu'un jeu de table ?

La catégorie des [« jeux de table »](https://perma.cc/NSE5-VA2F) englobe tous les jeux physiques qui se jouent sur ou autour d'une table. Alors que le grand public a tendance à séparer les jeux commerciaux en seulement deux catégories - les “jeux vidéo” et les “jeux de société” - de nombreux passionnés et professionnels de l'industrie du jeu préfèrent le terme de « jeux de table » à celui de « jeux de société », car il englobe non seulement les jeux de société, mais aussi les jeux de dés, de cartes, les jeux papier et crayon, ainsi que les jeux de rôle.

Dans cette leçon, vous apprendrez à créer votre propre version d'un jeu de cartes appelé *Timeline*.

### Présentation de *Timeline*

*Timeline* est un jeu de cartes conçu par Frédéric Henry, édité pour la première fois en 2012 et toujours disponible à l'achat auprès de l'éditeur mondial de jeux [Asmodee](https://perma.cc/993M-GRFZ) et de sa filiale [Zygomatic](https://perma.cc/6D8J-PMMY). *Timeline* se joue de 2 à 8 joueurs. Parce qu’il est facile à prendre en main et idéal pour jouer à plusieurs, *Timeline* est fréquemment présenté autant comme un jeu d’ambiance que comme un jeu éducatif. Le jeu est édité en plusieurs langues et décliné en différentes versions thématiques, notamment *Timeline : Inventions*, *Timeline : Musique et cinéma*, *Timeline : Histoire américaine*, et *Timeline Star Wars*.


> **Timeline** est un jeu de cartes où chaque carte représente un événement historique, une invention ou une découverte spécifique, mais où seule une face indique l'année au cours de laquelle cet événement a eu lieu. À tour de rôle, les joueurs placent une carte de leur main dans la rangée de cartes sur la table. Une fois la carte posée, le joueur la retourne pour révéler la date au verso. Si la carte a été placée dans l'ordre chronologique par rapport à toutes les autres cartes sur la table, elle reste en place ; sinon, la carte est retirée du jeu et le joueur prend une autre carte de la pioche. Le premier joueur à s'être débarrassé de toutes ses cartes en les plaçant correctement a gagné.[^8]


La mécanique de jeu consistant à ajouter des cartes à une série chronologique n'est pas exclusive à Timeline. En 2020, Tom James Watson a lancé [Wikitrivia](https://perma.cc/9RPB-U9VP), un jeu en ligne à jouer seul, dans lequel vous essayez de battre votre propre « série » de cartes correctement ajoutées à une frise chronologique d'événements historiques tirés de Wikidata et de Wikipedia. En août 2023, le New York Times a lancé une version bêta d'un quiz historique hebdomadaire appelé [Flashback](https://perma.cc/DDE5-9FFU), dans lequel les joueurs doivent classer huit événements historiques par ordre chronologique.[^9]

Les variantes de jeux comme *Wikitrivia* et *Flashback*, inspirées de *Timeline*, sont autorisées par la législation américaine sur le droit d'auteur puisque les règles d’un jeu ne sont pas protégeables par un copyright. L'article 102(b) du Copyright Act indique : “En aucun cas la protection du droit d'auteur pour une œuvre originale de l’esprit ne s'étend à une idée, une procédure, un processus, un système, une méthode de fonctionnement, un concept, un principe ou une découverte, quelle que soit la forme sous laquelle cela a été décrit, expliqué, illustré ou incorporé dans ladite œuvre”.[^10]

## Pourquoi jouer à *Timeline* en classe ?

Le fait de jouer en classe peut permettre aux élèves de tester leurs connaissances en dehors d'un processus d'évaluation formel et de la pression qui y est associée. Timeline met les joueurs au défi non seulement en leur demandant s'ils maîtrisent la chronologie des événements représentés sur les cartes devant eux, mais il exige également une certaine forme de métacognition, puisqu’une stratégie de jeu efficace suppose que les élèves soient capables d’estimer à quel point ils sont sûrs de ce qu’ils savent.[^11]

### Comment créer votre propre version de *Timeline* avec des fiches bristol ?

Pour créer un jeu qui imite la mécanique de *Timeline*, tout ce dont vous avez besoin, c'est d'un petit ensemble de cartes. Vous pouvez fabriquer vos propres cartes en pliant une feuille de papier en deux, trois fois de suite, puis en découpant le papier le long des plis pour obtenir huit cartes. Vous pouvez également acheter et utiliser un paquet de fiches bristol. Au recto de chaque carte, inscrivez uniquement le nom de l'événement en question et, au verso, inscrivez le nom de l’événement ainsi que l’année correspondante.

En 2018, j'ai fabriqué un petit jeu de cartes *Timeline* à l'aide de fiches bristol pour ma famille. Inspirée par la fascination de mes enfants pour les danses des personnages du jeu vidéo *Fortnite* (au moment où ces danses sont soudainement devenues omniprésentes sur les terrains de sport professionnels et dans les cours de récréation du monde entier), j’ai cherché l'année d'origine de danses comme le Twist, le Carlton et le Nae Nae, et j'ai créé un petit jeu de cartes avec leurs noms et leurs années. J'ai joué à ce jeu avec ma famille et ce fut une expérience agréable pour tout le monde. Même si je n'y ai pas directement joué moi-même, puisque je connaissais les réponses, j'ai pris plaisir à regarder mes enfants tenter de se souvenir et utiliser leur logique pour deviner la chronologie des différentes danses qu'ils connaissaient.

Pour ce type de jeu occasionnel, les cartes faites à la main étaient suffisamment satisfaisantes pour créer une expérience agréable. Cela dit, les cartes que j'ai fabriquées auraient pu être améliorées par l'ajout de photographies des danses, ce qui aurait fourni des indices contextuels supplémentaires pour aider mes enfants à deviner de manière réfléchie la date à laquelle la photo a été prise. Cependant, la collecte des images, l'impression des copies, le découpage et le transfert sur les cartes auraient demandé beaucoup d'efforts et de temps. Heureusement, il existe un certain nombre d'outils numériques que nous pouvons utiliser pour faciliter ce travail.

## Pourquoi concevoir et partager en classe votre propre version de *Timeline* à l’aide d’outils numériques  ?

Il existe de nombreuses raisons d'apprendre à concevoir, modifier et produire des cartes imprimées à l'aide d'outils numériques. Les modèles numériques peuvent être facilement modifiés ou ajustés - par exemple, en cas de confusion ou de réactions inattendues des participants pendant le jeu. Enregistrer le modèle de conception d’un jeu de cartes sous format numérique nous permet, si besoin, de le retrouver et de le reproduire rapidement.

Un modèle numérique (template) peut également être partagé au sein d’un groupe de personnes, par exemple une classe d'élèves, afin que chacun puisse créer ses propres cartes. Une fois terminées, ces cartes peuvent être rassemblées et imprimées ensemble pour former un seul et même jeu. On peut, par exemple, demander à chaque élève de créer un petit ensemble de cartes *Timeline* évoquant les événements d'une période particulière de l'histoire, éventuellement limité à un certain sujet ou à une certaine zone géographique. Le paquet de cartes d’une classe pourrait ainsi combiner une variété de cartes portant sur l'histoire locale du sport, l'histoire de la médecine, les moments clés de l'architecture ou encore une sélection de peintures. C’est ce « mélange d'histoires » qui permet de vivre les moments les plus amusants du jeu *Timeline*, et c'est un aspect que le jeu encourage avec enthousiasme :


>Pouvait-on boire du champagne lorsque Darwin posa les bases de la théorie de l'évolution ? Le fer à repasser a-t-il été inventé avant ou après le premier voyage de l'homme dans l'espace ? Combinez votre intuition et vos connaissances historiques avec le jeu *Timeline*.[^12]


S'il est utilisé en classe, ce tutoriel pourrait être complété par les conseils (ou des recommandations générales) d’un bibliothécaire pour trouver des images historiques pertinentes sur Internet.[^13] Nous pourrions également profiter de cette occasion pour apprendre aux élèves à reconnaître et comprendre les mentions de droits d’auteur liées aux licences Creative Commons, afin de déterminer si les images trouvées peuvent être utilisées en dehors des « dispositions relatives à l'utilisation raisonnable dans un cadre éducatif » aux États-Unis, ou de « l’usage raisonnable dans le cadre de l'exception éducative » prévue par la loi canadienne sur le droit d’auteur.[^14]

## Comment créer votre propre version de *Timeline* à l'aide d'outils numériques ?
A l’heure où nous publions cet article, Microsoft met gratuitement à disposition les versions web de Word et d'Excel pour toute personne disposant d’une adresse e-mail et s’inscrivant sur sa plateforme. Il est possible de générer et d'imprimer des cartes à jouer en utilisant la fonctionnalité de publipostage de Word, qui permet d'importer du texte et des images hébergées localement à partir d'un fichier Excel dans des "étiquettes" (cartes) personnalisées dans Word. Pour la conception de cartes basiques, cette solution, à la fois largement accessible et fonctionnelle, peut pleinement répondre aux besoins.

Cela étant, il se peut que vous soyez intéressé, pour la création de prototypes de cartes, par nanDECK, un outil couramment utilisé par des créateurs de jeux, aussi bien amateurs que professionnels — c’est le cas notamment d’Elizabeth Hargrave.[^15]

## Présentation de nanDECK et mode d’emploi
Un aspect fondamental de la conception d’un jeu réside dans l’ajustement progressif des cartes du jeu, à travers un processus itératif de tests et d’observation des effets des modifications apportées au design. nanDECK est un logiciel développé pour Windows et conçu pour aider les créateurs de jeux dans le processus de conception et d'impression de jeux de cartes destinés au prototypage et aux phases de test.

L'outil a été créé et mis à disposition gratuitement par Andrea 'Nand' Nini. Le logiciel est en cours de développement depuis sa version 1.0 sortie en avril 2006. La version la plus récente (au moment de la rédaction de cet article) est nanDECK 1.273, publiée en novembre 2023.

Bien qu’initialement conçu pour créer des cartes à jouer, nanDECK peut également être utilisé pour générer des graphismes destinés à d’autres éléments de jeu, tels que les jetons ou les tuiles.

### Installation de nanDECK

#### Windows
nanDECK est compatible avec toutes les versions de Windows. [Le logiciel peut être téléchargé](https://nandeck.com/archives/199), décompressé, puis exécuté sans installation préalable. Il peut ainsi être lancé directement depuis une clé USB.

#### Linux
Les utilisateurs de Linux peuvent utiliser nanDECK en installant l'émulateur Windows [Wine](https://www.winehq.org/), ainsi que les [polices de base Microsoft](https://sourceforge.net/projects/corefonts/files/the%20fonts/).

#### macOS
nanDECK peut être téléchargé et exécuté sur MacOS grâce à l'émulateur Windows [Wine](https://www.winehq.org/). Cependant, les utilisateurs d'ordinateurs Apple fonctionnant sous MacOS Catalina ou versions ultérieures devront effectuer des démarches supplémentaires, puisque Wine n’est plus compatible avec les systèmes ayant abandonné la prise en charge des applications 32 bits.

Le manuel officiel de nanDECK[^16] propose une solution de contournement qui consiste à [installer Winebottler](https://winebottler.kronenberg.org/) et [XQuartz](https://www.xquartz.org/) afin de faire fonctionner la version Windows sur un ordinateur MacOS. Les utilisateurs peuvent également envisager d'installer et d'utiliser nanDECK via un émulateur tel que [Virtual Box](https://www.virtualbox.org/) ou recourir à une application payante telle que [Parallels](https://www.parallels.com/products/desktop/).

### Problèmes d'installation
En cas de problème d’installation, vous pouvez consulter plusieurs forums en ligne où des utilisateurs proposent volontiers leur aide. Le développeur de nanDECK, Andrea Nand, participe activement au [forum des utilisateurs de nanDECK sur BoardGameGeek](https://perma.cc/FJ9V-N4VA). Il existe également une communauté plus restreinte, mais toujours active, d'[utilisateurs de nanDECK sur Reddit](https://www.reddit.com/r/nanDECK/).

## Comment utiliser nanDECK pour créer des cartes
Cette partie débute par une présentation de l'interface de nanDECK et de ses principaux éléments. Elle propose ensuite un script de 12 lignes, accompagné d’explications détaillées ligne par ligne, afin d’en clarifier les instructions et le fonctionnement. L'exemple présenté provient d’un projet réalisé par la traductrice de la version française de cet article, destiné à générer un jeu *Timeline" de 59 cartes portant sur l’histoire de l’île de La Réunion (France). Ce cas pratique repose sur un fichier Excel hébergé localement, contenant les libellés de chaque carte ainsi que les emplacements des fichiers image nécessaires à leur illustration. Des instructions spécifiques sont également fournies pour ceux qui préfèrent utiliser Google Sheets à la place d’Excel. Enfin, cette partie propose des liens vers un ensemble de fichiers permettant aux lecteurs de générer leur propre jeu de six cartes *Timeline*.

Cette leçon se limite à l’analyse d’un script permettant de générer un jeu de cartes de type Timeline ; elle ne fournit pas d'instructions générales sur l’utilisation de nanDECK. Pour une introduction vidéo très utile à nanDECK, je recommande la [série de cinq tutoriels de Ryan Langewisch sur YouTube](https://www.youtube.com/watch?v=I1IPl3nT1Og&list=PLdHW9On5G8NJm5m1mULabskVYsM84M_SL). Le manuel de nanDECK, rédigé par Andrea Nini et disponible en ligne sous la forme d'un [document PDF de 188 pages](https://perma.cc/49KL-BJA6), est également très utile.

### L'interface principale de nanDECK
Le manuel de nanDECK commence par cette présentation :


>nanDECK est un programme capable de générer des éléments graphiques à partir de scripts : chaque ligne du script correspond à une commande permettant d’afficher du texte, des rectangles ou d’autres formes graphiques. Bien qu’il ait été conçu principalement pour la création de cartes, il peut également être utilisé pour générer une grande variété d’objets graphiques. Chaque carte est gérée comme une page indépendante sur laquelle vous pouvez dessiner différents éléments.  Pour commencer, il suffit de rédiger le script dans la grande zone d’édition située au centre de la fenêtre :

{% include figure.html filename="fr-tr-creer-jeu-timeline-tabletop-simulator-01.png" alt="Capture d’écran de la fenêtre principale de l’interface de nanDECK version 1.28"  caption="Figure 1. Capture d’écran de la fenêtre principale de l’interface de nanDECK version 1.28" %}

Chaque commande de script dans nanDECK se compose d’un mot-clé, d’un signe égal (`=`) et d’une série de paramètres. Il est indispensable de consulter le manuel de nanDECK pour connaître les paramètres disponibles pour chaque commande. Par exemple, pour la commande `FONT`, le manuel indique :


>FONT
>
>Cette commande définit la police utilisée pour toute commande TEXT qui la suit (voir page 164). Notez qu’elle ne s’applique pas à une plage de cartes. Si vous souhaitez une consigne applicable à une plage, utilisez plutôt FONTRANGE (voir page 105).
>
>Syntaxe :
>
>FONT = "nom de la police", taille de la police, style, couleur html de la police, couleur html de l'arrière-plan, contour x, contour y, axe x, axe y, espace entre les caractères
>
>Paramètres :
>
>* “nom de la police" : nom de la police de caractères (chaîne)
>* taille de la police : taille de la police de caractères, en points typographiques (1 point = 1/72 de pouce)
> * style : style de la police et option de mise en forme (flag) utilisés ; les valeurs acceptées sont : 
	* B : gras
	* I : italique
	* U : souligné
	* S : barré


Ces éléments en tête, examinons maintenant le code suivant :

```
FONT = Arial, 32, B, #0000FF
```

Il définit les paramètres suivants : police Arial, taille 32, style gras, et texte en couleur bleue (en hexadécimal).

La commande `FONT` fait partie des rares instructions dans nanDECK qui s’appliquent à l’ensemble des cartes du jeu. Pour la plupart des autres commandes nanDECK, le premier paramètre sert à indiquer la plage de cartes concernée par l’exécution de la commande. Par exemple, le premier paramètre de `FONT RANGE` est "`range`" (*plage*). Pour utiliser la police Arial, en bleu et en gras uniquement sur les 20 premières cartes, il faudrait utiliser ce code :

```
FONTRANGE = 1-20, Arial, 32, B, #0000FF
```

Parmi les éléments fréquemment utilisés pour la conception des cartes, on retrouve : `BORDER` (*bordure*), `TEXT` (*texte*), `IMAGE` (*image*), `COLOR` (*couleur*), `RECTANGLE` (*rectangle*) et `CIRCLE` (*cercle*).

Il est également possible, dans nanDECK, de définir des paramètres de manière dynamique, à l’aide d’expressions encadrées par `{` et `}`.

```
TEXT="1-{(EVENEMENT)}",\[EVENEMENT]
```

## Comprendre un script nanDECK destiné à créer un jeu de cartes
Pouvoir générer un jeu de cartes *Timeline* avec seulement douze lignes de script illustre parfaitement la puissance de nanDECK.

{% include figure.html filename="fr-tr-creer-jeu-timeline-tabletop-simulator-02.png" alt="Capture d’écran de nanDECK montrant les douze lignes de script servant à créer un jeu de cartes Timeline."  caption="Figure 2. Capture d’écran de nanDECK montrant les douze lignes de script servant à créer un jeu de cartes Timeline." %}

La partie suivante détaille, ligne par ligne, le script afin de montrer comment les différents éléments sont intégrés et assemblés pour former les cartes. Voici le script utilisé par la traductrice pour générer un jeu *Timeline* de 59 cartes représentant des événements historiques de l’île de La Réunion (France), où elle réside actuellement.

### Ligne 1 : COMMENTAIRES
Dans nanDECK, tout texte débutant par un point-virgule n’est pas pris en compte comme une commande, mais comme un « commentaire », c’est-à-dire une note explicative destinée à l’utilisateur.

```
1. ; Ceci est le Timeline_Reunion d’Emeline Dandeu, un mod inspiré du jeu _Timeline_ de Frederic Henry
```

Il est également possible d’ajouter un commentaire en fin de ligne, après une instruction, en doublant le caractère point-virgule :

```
2. PAGE=21,29.7,portrait,HV ;; ceci définit les dimensions de la page en centimètres
```

### Ligne 2 : PAGE
La commande `PAGE` définit la taille et l'orientation du papier,ce qui s’avère utile pour la création et l’impression du PDF.


>Paramètres :
>
>* **height** (hauteur)  : hauteur de la page (en cm)_
>* _**orientation** : l'orientation peut être choisie entre :
>	* LANDSCAPE (paysage) : horizontal
>	* PORTRAIT : vertical
>* **Flags** (options de mise en forme) : pour spécifier un comportement spécial pour les pages, dont les valeurs possibles sont :
>* H : les cartes sont centrées horizontalement
>* V : les cartes sont centrées verticalement


```
2. PAGE=21,29.7,portrait,HV ;; ceci définit les dimensions de la page en centimètres
```

La ligne ci-dessus définit la taille de la page dans l’équivalent métrique du format standard américain 8,5" x 11" (21 x 29,7 cm), en orientation portrait. nanDECK interprétera `HV` comme une instruction lui permettant d’effectuer les calculs nécessaires pour centrer les cartes à la fois horizontalement et verticalement.

### Ligne 3 : TAILLE DE LA CARTE
L’instruction `CARDSIZE` permet de définir la largeur et la hauteur de chaque carte (en centimètres).

```
3. CARDSIZE=4,6.5
```

Si cette ligne est omise, nanDECK applique par défaut une taille de 6 cm x 9 cm. Toutefois, les cartes générées avec cette taille par défaut sont plus grandes que les cartes à jouer classiques, qui mesurent 2,5 x 3,5 pouces, soit environ 5,71 cm x 8,89 cm.

Pour ce jeu, j’ai choisi de créer des cartes de plus petite taille, aux dimensions proches de celles des cartes *Timeline* publiées par Asmodee.

### Ligne 4 : LIEN
La commande `LINK` permet de connecter nanDECK à des données externes, soit sous forme de fichier texte avec des valeurs séparées par des virgules (format CSV), soit sous forme de tableur Excel (`.xls` ou `.xlsx`). Le tableur utilisé par la traductrice dans cet exemple s'intitule `Reunion-Timeline.xlsx`.


Vous pouvez également connecter nanDECK à un tableur Google Sheets en suivant les étapes supplémentaires décrites dans le manuel de nanDECK, dans la partie consacrée à la commande `LINK`.[^16] Elles sont reproduites ci-dessous :


>Vous pouvez également connecter un document Google Sheets en utilisant l'identifiant (ID) du fichier à la place du paramètre "filename” (nom de fichier), mais vous devez d’abord le partager en suivant ces étapes :
>
>• Sélectionnez le fichier dans la page web de Google Drive
>• Cliquez sur l'icône Partager (en haut à droite)
>• Dans la fenêtre, cliquez sur le menu déroulant sous « Accès général »
>• Choisissez une option de partage par lien, par exemple « Tous les utilisateurs qui ont le lien »
>
>Google vous affichera alors un lien du type : `https://docs.google.com/spreadsheets/d/SAMPLE_ID/edit?usp=sharing`
>
>Copiez et collez l'identifiant du lien dans une ligne nanDECK comme ceci : 
>LINK=SAMPLE_ID
>
>Vous pouvez aussi sélectionner une feuille spécifique avec la syntaxe suivante :
>LINK=ID!Nom_de_la_feuille
>Exemple :
>LINK=SAMPLE_ID!Beta
>Mais vous devez activer le partage sur le web en suivant ces étapes :
>• Ouvrez la feuille de calcul dans un navigateur
>• Dans le menu, sélectionnez Fichier → Partager → Publier sur le Web
>• Cliquez sur le bouton "Publier”


À noter : nanDECK part du principe que la première ligne du fichier lié contient les noms des champs importés.

```
LINK = “Reunion-Timeline.xlsx”, “Année”, “Evénement”, “Images”
```

Si les noms des champs sont omis, ils seront attribués à partir de ceux contenus dans la première ligne du fichier. C’est le cas dans notre exemple.

```
4. LINK = "Reunion-Timeline.xlsx"
```

Le tableau ci-dessous reproduit une version tronquée de la feuille de calcul, affichant à la fois la première et la dernière ligne.

|                    | A                   | B                   | C                   |
| --------------------------- | --------------------------- | --------------------------- | --------------------------- |
| 1 | Année | Évènement | Images  |
| 2 | 1153 | Le géographe arabe Al Idrissi cartographie l'île sous le nom de « Dina Morgabin » | Dina-Morgabin.jpg |
| 3 | 1663 | Les français peuplent l’île pour la première fois | francais-peuplent-ile.jpg |
| 4 | 1730 | Le pirate La Buse est exécuté | pirate-calaisien-olivier-levasseur-dit-la-buse.jpg |
| 5 | 1811 | Révolte des esclaves de Saint-Leu | revolte-des-esclaves.jpg |
| 6 | 1841 | Edmond Albius découvre le processus de fécondation de la vanille | edmond-albius-764e6.jpg |
| 7 |  | Le géographe arabe Al Idrissi cartographie l'île sous le nom de « Dina Morgabin » | Dina-Morgabin.jpg |
| 8 |  | Les français peuplent l’île pour la première fois | francais-peuplent-ile.jpg |
| 9 |  | Le pirate La Buse est exécuté | pirate-calaisien-olivier-levasseur-dit-la-buse.jpg |
| 10 |  | Révolte des esclaves de Saint-Leu | revolte-des-esclaves.jpg |
| 11 |  | Edmond Albius découvre le processus de fécondation de la vanille | edmond-albius-764e6.jpg |

### Ligne 5 : BORDURES
Les paramètres de la commande `BORDER` (bordures) sont les suivants :


>* **type** : le type de bordure peut être choisi parmi :
>	* RECTANGLE : dessine un rectangle (valeur par défaut)
>	* ROUNDED : dessine un rectangle aux coins arrondis
>	* MARK : dessine des traits de coupe
>* **couleur html** : noir si non spécifié
>* **épaisseur** : en cm. L’épaisseur de la bordure est mesurée entre deux cartes. Par exemple, une épaisseur de 1 cm correspond à une bordure de 0,5 cm sur chaque carte. Les **repères** permettent de dessiner des traits au-delà des bords des cartes pour aider à la découpe.


```
5. BORDER = RECTANGLE, #000000, 0.25, MARKDOT
```

Dans cet exemple, nanDECK doit tracer une bordure noire et rectangulaire autour de chaque carte, avec des marques de découpe en pointillés.

{% include figure.html filename="fr-tr-creer-jeu-timeline-tabletop-simulator-03.png" alt="Exemple d’une page de cartes créée via nanDECK, avec les bordures noires souhaitées et les lignes de découpe en pointillés visibles."  caption="Figure 3. Exemple d’une page de cartes créée via nanDECK, avec les bordures noires souhaitées et les lignes de découpe en pointillés visibles." %}

### Ligne 6 : IMAGE
nanDECK comprend un éditeur visuel de base qui permet de dessiner des formes ou d'importer des images sur les cartes. Dans ce jeu, nous souhaitons ajouter des images `.jpg` externes, collectées à partir de diverses collections numériques en histoire et stockées dans un répertoire local.

De nombreux paramètres et indicateurs sont associés à la directive `IMAGE`, comme en témoigne sa syntaxe :


>IMAGE = plage, fichier image, position x, position y, largeur, hauteur, angle, option de mise en forme, alpha, largeur de texture, hauteur de texture, inclinaison x, inclinaison y, largeur de l’image, hauteur de l’image, position x, position y, copie x, copie y.


Comprendre l’ordre des éléments dans la syntaxe peut nous aider à interpréter la directive IMAGE dans notre script :

```
6. IMAGE="1-{(IMAGES)}",\[IMAGES],0%,0%,100%,60%,0,PTG
```

nanDECK peut très utilement calculer le nombre d'éléments répertoriés dans un champ donné d'une feuille de calcul. Pour ce faire, il utilise une expression encadrée par des accolades. Dans ce cas, l'expression {(IMAGES)} indique à nanDECK de calculer le nombre d'éléments répertoriés dans le champ `IMAGE`. Ici, il y a 59 images, donc {(IMAGES)} renvoie `59`. Sachant cela, vous remarquerez qu'à la ligne 6 de la figure 4 ci-dessous, `IMAGE="1-{(IMAGES)}"` demande à nanDECK d'imprimer les images des lignes 1 à 59.

Dans la fenêtre d'instruction, il peut parfois être difficile de déterminer précisément à quel paramètre correspondent les nombres ou les termes listés après chaque directive. Si vous souhaitez savoir quel paramètre représente une variable, vous pouvez passer la souris dessus et consulter le rappel de syntaxe ci-dessous : nanDECK affichera en surbrillance le nom du paramètre concerné.


{% include figure.html filename="fr-tr-creer-jeu-timeline-tabletop-simulator-04.png" alt="Le texte en surbrillance correspond à la variable sur laquelle le curseur de la souris est actuellement positionné."  caption="Figure 4. Le texte en surbrillance correspond à la variable sur laquelle le curseur de la souris est actuellement positionné." %}

Le script de la figure 4 demande à nanDECK d'insérer l'image indiquée dans le champ "Image" de la feuille de calcul, de la placer à la position 0,0, et de lui permettre de remplir 100 % de la largeur de la carte (si possible), mais seulement 60 % de la hauteur (si possible). La sélection de l’option P indique à nanDECK de conserver les proportions originales de l'image. J’ai également choisi de convertir toutes les images en niveaux de gris en utilisant l’option G, afin d’apporter une certaine uniformité aux cartes du jeu. Vous pouvez voir le résultat dans l'exemple ci-dessous, où nanDECK a inséré l'image située dans Images/Sandwich_First.jpg :

{% include figure.html filename="fr-tr-creer-jeu-timeline-tabletop-simulator-05.png" alt="Une carte générée avec nanDECK."  caption="Figure 5. Une carte générée avec nanDECK." %}


### Lignes 7 et 9 : POLICE

nanDECK peut utiliser les polices de caractères que vous avez installées sur votre machine. Le code ci-dessous définit le formatage des polices :

```
7. FONT=Arial,14,BT,#000000
8. TEXT="1-{(ANNEE)}",\[ANNEE],25%,60%,52%,9%
9. FONT=Arial,7.5,,#000000
```
À la ligne 7, nanDECK est invité à définir la police à la taille 14, en gras, sur un fond transparent. La ligne 8 demande à nanDECK de générer le texte pour `ANNEE` avec cette police, et la ligne 9 réduit la taille de la police à 7,5 lorsqu'elle est appliquée au texte `EVENEMENT` (généré à la ligne 10). Notez les deux virgules consécutives à la ligne 9 : elles indiquent à nanDECK que le paramètre de `style` est vide, ce qui fait que la mise en forme du texte reste neutre.

### Lignes 8 et 10 : TEXTE

nanDECK propose différentes options pour écrire du `TEXTE` sur les cartes :


>TEXT = "plage", "texte", position x, position y, largeur, hauteur, alignement horizontal, alignement vertical, angle, alpha, épaisseur du contour, décalage circulaire, angle circulaire, facteur de largeur, facteur de hauteur.


Dans cet exemple, la mise en forme du texte est restée simple, mais le placement du texte a posé quelques difficultés. La plupart des cartes à jouer ont deux faces : le recto et le verso. Dans de nombreux jeux, la majeure partie des informations pertinentes se trouve sur le recto de la carte, tandis que le verso est simplement décoratif ou indique le type de carte. Comme vous vous en souvenez peut-être, une carte d'un jeu de *Timeline* possède en réalité deux faces : l’une indiquant le nom ou la description d'un événement, et l’autre portant le nom et la date de l'événement.

```
8. TEXT="1-{(ANNEE)}",\[ANNEE],25%,60%,52%,9%
10. TEXT="1-{(EVENEMENT)}",\[EVENEMENT],4.5%,68.5%,91%,30%,CENTER,WORDWRAP
```

La ligne 8 du script demande à nanDECK d'écrire l'année pour chaque carte à laquelle une année a été attribuée dans le champ "année" de la feuille de calcul. La ligne 10 demande à nanDECK d'écrire une description de l'événement pour chaque carte à laquelle un fait a été attribué dans le champ "évènement" de la feuille de calcul. Comment ce script produit-il les cartes dont nous avons besoin pour jouer à *Timeline* ?

Plutôt que d'utiliser des scripts complexes pour s'assurer que l'année n'apparaisse que sur une seule face de chaque carte imprimée, nous donnons simplement des instructions pour imprimer tout ce qui a été explicitement indiqué dans la feuille de calcul Excel liée. Dans cette feuille de calcul (reproduite dans le tableau ci-dessous), les 59 premières lignes contiennent une image, une description et une année à imprimer sur la face de la carte. Les 59 lignes suivantes ne contiennent qu'une image et une description, le champ "année" ayant été laissé vide.


|                    | A                   | B                   | C                   |
| --------------------------- | --------------------------- | --------------------------- | --------------------------- |
| 1 | Année | Évènement | Images  |
| ... | ... | ... | ... |
| 57 | 1642 | Au nom du roi Louis XIII, les Français s'approprient le territoire, baptisé « île Bourbon » | Louis_XIII_par_de_Champaigne.jpg |
| 58 | 1668 | Anne Mousse est la première femme à naître sur l'île | Anne_Mousse.jpg |
| 59 | 1848 | L'abolition de l'esclavage est proclamée | garreau-abolition-esclavage-reunion.jpg |
| 60 | 1918 | Grippe espagnole : 10% de la population est décimée | grippeespagnole.jpg |
| 61 |  | La Réunion devient un département d’outre-mer | departementalisation.jpg |
| 62 |  | Nicole Robinet de la Serve crée l'association des Francs-Créoles | robinet-de-la-serve.jpg |
| 63 |  | Création du muséum d'histoire naturelle de La Réunion | Le_Muséum_dhistoire_naturelle_de_Saint-Denis_de_la_Réunion_(4128766888).jpg |

Cette méthode n'est certes pas la plus efficace, car les informations nécessaires à la génération de nouvelles cartes doivent être saisies deux fois dans la feuille de calcul (une entrée avec l'année et une autre sans), mais elle permet d'obtenir le résultat souhaité.

### Ligne 11 et 12 : RECTO/VERSO et IMPRESSION

L'un des principaux atouts de nanDECK est sa capacité à générer des faces et des dos de cartes parfaitement synchronisés. Il y parvient grâce aux directives `DUPLEX` (recto/verso) et `PRINT` (impression).


>DUPLEX
>Cette directive permet de copier une carte (ou une plage de cartes) vers une autre position (ou plage de positions) calculée automatiquement par le logiciel. Elle est utile pour gérer les doublons ou synchroniser la face et le dos des cartes en vue d’une impression recto-verso.


```
DUPLEX = “plage de cartes face”, “plage de cartes back”, numéro
```

Afin d'aligner les faces et les dos des cartes, désignez la plage que vous souhaitez dupliquer. Dans le cas de mon jeu personnel, il y a 59 cartes uniques : les rectos seront générés à partir des cartes de la plage 1 à 59, et les versos à partir des cartes de la plage 60 à 118.

```
11. DUPLEX = 1-59,60-118
12. PRINT = DUPLEX
```

Avant de pouvoir imprimer votre jeu de cartes, vous devez d'abord sélectionner le bouton *Validate Deck* pour vérifier que la syntaxe de votre script est correcte. Vous pouvez ensuite cliquer sur le bouton *Build Deck* pour générer votre jeu de cartes : un aperçu des cartes générées s’affichera dans le panneau de droite. Dans cet aperçu, vous verrez peut-être un nombre surprenant de cartes vierges, mais ne vous inquiétez pas. Ces cartes vierges sont insérées dans votre jeu par nanDECK afin de produire un document PDF correctement aligné lors de l'impression.

{% include figure.html filename="fr-tr-creer-jeu-timeline-tabletop-simulator-06.png" alt="Deux pages générées par nanDECK pour l'impression. Notez que les pages sont orientées de manière à pouvoir être pliées ensemble afin d’obtenir des cartes recto-verso parfaitement alignées."  caption="Figure 6 : Deux pages générées par nanDECK pour l'impression. Notez que les pages sont orientées de manière à pouvoir être pliées ensemble afin d’obtenir des cartes recto-verso parfaitement alignées." %}


Enfin, utilisez le bouton *Print Deck* pour demander à nanDECK de générer votre jeu sous forme de fichier PDF, prêt à être imprimé. nanDECK peut imprimer votre jeu de multiples façons : chaque carte générée par le programme peut être enregistrée sous forme d’image séparée, ou bien être toutes les cartes peuvent être regroupées dans un seul PDF, prêt à être imprimé, assemblé, découpé et collé. Étant donné que la conception de jeux passe généralement par plusieurs phases de test en situation réelle — chacune donnant lieu à des ajustements successifs —, la capacité de nanDECK à régénérer facilement différentes versions d'un jeu de cartes est extrêmement précieuse.[^15]

## Créer votre propre *Timeline*

Afin de vous aider à démarrer avec nanDECK et Tabletop Simulator, j'ai mis à votre disposition un kit de fichiers de démarrage [à télécharger sur GitHub](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/designing-a-timeline-tabletop-simulator.zip). Il contient deux sous-dossiers : l'un nommé `nanDECK` et l'autre `Tabletop-Simulator`.

Le sous-dossier `nanDECK` contient :

- [**PH_nandeck_Your_Timeline.txt**](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/nanDECK/PH_nandeck_Your_Timeline.txt) : le script à ouvrir dans nanDECK_
- [**Build-Your-Own-Timeline.xlsx**](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/nanDECK/Build-Your-Own-Timeline.xlsx) : la feuille de calcul que le script utilise dans nanDECK pour localiser les éléments et construire le jeu de cartes_
- Six images au format `.png`_

Comme dans l'exemple précédent, [**PH_nandeck_Your_Timeline.txt**](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/nanDECK/PH_nandeck_Your_Timeline.txt) commence par trois lignes de commentaires, suivies de onze lignes de directives. Contrairement à l'exemple précédent, ce script est relié à un tableur Google Sheets plutôt qu'à un fichier Excel.

```
1   ; This is a template to create your own mod inspired by the game Timeline by Frederic Henry
2   ; This template generates a deck from a Google Sheet
3   ;
4   PAGE=21,29.7,portrait,HV
5   CARDSIZE=4,6.5
6   LINK = 1lP2mFRcxEsJeDniVy8byPMkwRe7JfkI78OR7NDe9zkU
7   BORDER = RECTANGLE, #000000, 0.25, MARKDOT
8   IMAGE="1-{(IMAGES)}",[IMAGES],0%,0%,100.299%,59.743%,0,PTG
9   FONT=Arial,14,BT,#000000
10  TEXT="1-{(YEAR)}",[YEAR],25%,60%,52%,9%
11  FONT=Arial,7.5,,#000000
12  TEXT="1-{(FACT)}",[FACT],4.5%,68.5%,91%,30%,CENTER,WORDWRAP
13  DUPLEX = 1-6,7-12
14  PRINT = DUPLEX
```

La ligne 4 indique à nanDECK que la taille de la page correspond à l'équivalent métrique d'un format 8½ x 11 pouces, qu'elle doit être orientée en mode portrait, et que les cartes doivent être centrées sur la page, à la fois horizontalement et verticalement. La ligne 5 définit la taille de chaque carte, en centimètres.

La ligne 6 exploite le codage dur de nanDECK, qui interprète automatiquement le `LIEN` comme une URL vers une feuille de calcul Google.  L’identifiant `1lP2mFRcxEsJeDniVy8byPMkwRe7JfkI78OR7NDe9zkU` est ainsi compris comme devant remplacer le paramètre `SAMPLE_ID`, dans ce format d'URL : `https://docs.google.com/spreadsheets/d/SAMPLE_ID/edit?usp=sharing`. nanDECK le traduira en https://docs.google.com/spreadsheets/d/1lP2mFRcxEsJeDniVy8byPMkwRe7JfkI78OR7NDe9zkU/edit?usp=sharing.

La capacité de nanDECK à utiliser les ressources d’un dossier externe permet de développer une version personnalisée de *Timeline* (ou d'une autre variante d'un jeu de cartes) sans que cela soit nécessairement un travail individuel. Une classe entière d'étudiants peut ainsi rassembler des images et des évènements dans un dossier et un tableur communs. L'inconvénient de cette approche étant que les "secrets" des cartes de chacun deviennent visibles, ce qui enlève l’effet de surprise lors des futures parties. C'est pourquoi cette leçon recommande que chaque élève crée son propre jeu, avant de les réunir, afin de découvrir par le jeu ce que les autres ont conçu.

La ligne 7 décrit la bordure : rectangulaire, noire, d'une épaisseur de 0,25 cm, avec des pointillés pour faciliter la découpe.

La ligne 8 indique que, dans la mesure du possible, les images doivent être placées sur les cartes à la position 0,0, occuper 100 % de la largeur et 60 % de la hauteur de la carte, tout en conservant les proportions de l'image, et être imprimées en niveaux de gris.

La ligne 9 indique à nanDECK la police dans laquelle le texte suivant doit être imprimé : ici, Arial 14 point en gras et noir, sur un fond transparent.

La ligne 10 indique à nanDECK d'imprimer l'année (`YEAR`) pour chaque ligne de la feuille Google Sheets dont le champ "année" est renseigné, en la positionnant horizontalement au centre, mais un peu au-delà de la moitié de la hauteur de la carte.

La ligne 11 modifie la police, passant de 14 points à 7,5 points (Arial), en noir mais sans gras. Elle définit ainsi le style utilisé à la ligne 12, qui imprime, pour les cartes concernées, l’évènement (`FACT`), centré, sous l’année (`YEAR`). La ligne 12 indique également à nanDECK d'ajuster le texte s'il dépasse les dimensions de la carte.

Les lignes 13 et 14 indiquent que la page imprimée comportera les six premières faces des cartes d'un côté et leurs six dos de l'autre, de manière à ce qu'ils soient correctement alignées en cas d'impression recto-verso.

Une fois que vous avez saisi le script dans la fenêtre d'édition, validé le script et utilisé le bouton *Build* pour créer le jeu de cartes, vos résultats devraient ressembler à cette [image **.pdf**](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/nanDECK/Your-Timeline-Duplex-Printing-Result.pdf).

## Impression professionnelle de cartes avec nanDECK  

Vous avez également la possibilité de faire imprimer vos cartes par des professionnels : le créateur de nanDECK a établi un partenariat avec Game Crafter, une société américaine d'impression à la demande, spécialisée dans la production de cartes et d’autres composants pour jeux de société. Dans le panneau d'interface de nanDECK, vous trouverez un bouton permettant de téléverser vos fichiers directement sur le site de Game Crafter, en vue d’une impression à l’unité et en petite série.

Les éditeurs commerciaux refusent généralement d’imprimer des images qu’ils estiment protégées par le droit d'auteur, même si le jeu est destiné à un usage personnel ou éducatif, et non commercial. Bien que ma version de *Timeline* s’appuie principalement sur des sources du domaine public ou sur des collections dont les licences autorisent explicitement la réutilisation, de nombreuses images que je souhaitais utiliser restaient soumises au droit d'auteur. Par conséquent, il y a de fortes chances qu'un éditeur commercial refuse d’imprimer ne serait-ce qu'un seul exemplaire de mon jeu.

Cependant, il existe d'autres moyens de faire découvrir notre nouveau jeu au public !

## Pourquoi importer votre jeu dans Tabletop Simulator ?

nanDECK s’intègre parfaitement à une autre plateforme appelée Tabletop Simulator. [Tabletop Simulator](https://perma.cc/BKE8-DRRN) est un "bac à sable" physique, dans lequel jusqu'à dix joueurs peuvent manipuler et jouer avec des pièces de jeu numériques. Il est actuellement disponible sur [Steam](https://store.steampowered.com/app/286160/Tabletop_Simulator/) au prix de 19,99 $.

Bien que Tabletop Simulator (TTS) ne soit pas la seule plateforme numérique permettant à des personnes de jouer ensemble à des jeux de cartes ou de société, son nom est bien connu, et elle est utilisée par les créateurs pour observer des joueurs tester les premiers prototypes d’un jeu. Il peut être difficile de réunir, dans son entourage immédiat, suffisamment de volontaires prêts à tester un jeu en cours de développement. TTS permet aux concepteurs de faire tester leurs nouvelles créations à des joueurs répartis dans le monde entier.[^17] TTS n'est pas seulement un espace de rencontre pour les passionnés partageant des centres d’intérêt de niche, c'est aussi une excellente solution pour ceux qui ne peuvent pas jouer en personne, en raison de problèmes de santé, de contraintes de temps, de budget, ou lors de pandémies mondiales.[^18]

## Créer des cartes virtuelles pour Tabletop Simulator

Maintenant que vous savez comment importer vos cartes dans TTS, votre jeu se transforme en une sorte de jeu vidéo, sans besoin de coder les règles. Bien que TTS ne requiert pas de connaissances en programmation pour utiliser sa boîte à outils, il ne s'agit pas pour autant d'un environnement simple ni intuitif. Berserk Games, la société qui développe TTS, propose une série de sept [tutoriels vidéo sur YouTube](https://www.youtube.com/watch?v=6e8RFMtAVac&list=PLA16SF2eexlUtH2AM4V8VF9rDpekW2uYA)  pour apprendre aux nouveaux utilisateurs à créer des jeux et à y jouer dans cet environnement.

La partie suivante explique comment la traductrice de l’article a converti son jeu  "Timeline Réunion" en format numérique pour TTS. Ensuite, des instructions générales vous montreront comment appliquer le même procédé avec les éléments du jeu que nous venons d'utiliser pour créer notre jeu de démarrage de six cartes.

### Créer séparément les faces et les dos des cartes pour “Timeline Réunion”

Contrairement à nanDECK, qui génère chaque carte séparément, Tabletop Simulator exige le téléversement de deux fichiers image (un pour chaque côté du jeu de cartes) dans un format standardisé, afin de pouvoir les découper en plusieurs cartes. Un jeu de cartes classique comporte généralement une illustration au dos de la carte (par exemple un motif en mosaïque), tandis que les informations et les symboles apparaissent sur la face  (par exemple le 4 de Trèfle). En d'autres termes, TTS a besoin d'un fichier image représentant toutes les faces des cartes et d'un autre fichier représentant tous les dos.

Avant de pouvoir importer notre jeu *Timeline* dans TTS, nous devons générer nos cartes au format requis. Pour cela, nous devons diviser notre feuille de calcul initiale en deux. La première feuille de calcul servira à générer les faces des cartes ; elle contiendra donc les informations nécessaires pour afficher les événements, les illustrations et les années. Cette feuille ne comportera plus les lignes sans données dans la colonne « année ». La deuxième feuille de calcul sera identique à la première, mais sans la colonne « année ».

Maintenant que nous avons deux feuilles de calcul, nous devons apporter quelques modifications à notre précédent jeu d'instructions dans l'interface nanDECK avant d’exécuter le script.

Tout d'abord, modifions la commande `LINK` pour qu'elle pointe vers la feuille de calcul qui générera les faces des cartes, que la traductrice a appelée, dans cet exemple, `Reunion-Timeline_pour_Tabletop_Face.xlsx`.

```
LINK = "Reunion-Timeline_pour_Tabletop_Face.xlsx"
```

Comme nous ne générons plus aucun document à imprimer et à plier, nous pouvons supprimer les lignes suivantes de notre code :

```
DUPLEX = 1-59,60-118
PRINT = DUPLEX
```

TTS exige que les fichiers images pour chaque face du jeu de cartes soient fournis dans un certain format standardisé : une page contenant dix cartes horizontalement et sept verticalement. Cette standardisation est nécessaire pour que le programme puisse isoler chaque carte en tant qu’image individuelle. (Si votre jeu comporte plus de 70 cartes, vous devrez répéter cette opération plusieurs fois, en générant à chaque fois des lots de 70 cartes ou moins. Par exemple, si vous souhaitez générer les faces de 200 cartes, vous devrez créer et traiter trois feuilles de calcul : deux feuilles de 70 lignes chacune, et une feuille de 60 lignes).

Voici le script qui génère ce format standardisé :

```
RECTANGLE=70,0,0,100%,100%,#000000
```

nanDECK crée ensuite une image individuelle à l'aide de sa commande `DISPLAY`, une fois le jeu de cartes généré.

```
DISPLAY="Reunion_Timeline_TTS_Face.png"
```

Après avoir cliqué sur *Validate* puis *Build Deck*, nanDECK devrait générer l'image `Reunion_Timeline_TTS_Recto.png` (nommée ainsi pour cet exemple) dans le répertoire courant.

Vous devrez ensuite répéter ce processus pour générer les dos des cartes. Les seules modifications à apporter sont de remplacer le lien `LINK` par `Reunion-Timeline_for_Tabletop_Verso.xlsx` et la commande `DISPLAY` par `Reunion_Timeline_TTS_Verso.png`.

### Créer séparément les faces et les dos des cartes pour votre jeu de démarrage

Dans le [kit de fichiers de démarrage](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/designing-a-timeline-tabletop-simulator.zip), vous trouverez un sous-dossier nommé `Tabletop-Simulator`, qui contient :


- [**PH_nandeck_Your_Timeline_TTS_Face.txt**](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/Tabletop-Simulator/PH_nandeck_Your_Timeline_TTS_Face.txt) : le script à ouvrir dans nanDECK pour générer les faces des cartes
- [**PH_nandeck_Your_Timeline_TTS_Back.txt**](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/Tabletop-Simulator/PH_nandeck_Your_Timeline_TTS_Back.txt) : le script à ouvrir dans nanDECK pour générer les dos des cartes
- [**Build-Your-Own-Timeline-TTS-Face.xlsx**](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/Tabletop-Simulator/Build-Your-Own-Timeline-TTS-Face.xlsx) : la feuille de calcul utilisée par nanDECK pour générer les faces des cartes
- [**Build-Your-Own-Timeline-TTS-Back.xlsx**](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/Tabletop-Simulator/Build-Your-Own-Timeline-TTS-Back.xlsx) : la feuille de calcul utilisée par nanDECK pour générer les dos des cartes
- [**Your_Timeline_TTS_Face.png**](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/Tabletop-Simulator/Your_Timeline_TTS_Face.png) : l’image des faces des cartes produite par nanDECK à partir des éléments ci-dessus, à importer dans TTS
- [**Your_Timeline_TTS_Back.png**)](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/Tabletop-Simulator/Your_Timeline_TTS_Back.png) : l’image des dos des cartes produite par nanDECK à partir des éléments ci-dessus, à importer dans TTS

Si l'on examine le script [**PH_nandeck_Your_Timeline_TTS_Face.txt**](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/Tabletop-Simulator/PH_nandeck_Your_Timeline_TTS_Face.txt), on constate qu'il ne demande plus à nanDECK de générer un document recto-verso destiné à l'impression. À  la place, il génère un unique fichier `.png` nommé [**Your_Timeline_TTS_Face.png**](https://programminghistorian.org/assets/designing-a-timeline-tabletop-simulator/Tabletop-Simulator/Your_Timeline_TTS_Face.png).

```
1   ; This is a template to create your own mod inspired by the game Timeline by Frederic Henry
2   ; This template generates the face of a deck of cards from a Google Sheet and images that are hosted on Google Drive
3   ; This script generates a PDF for uploading into Tabletop Simulator
4   ;
5   PAGE=21,29.7,portrait,HV
6   CARDSIZE=4,6.5
7   LINK = 19abmOKGPc6dixxi38cc1wVDqmMBOYI-2J59qim3wQFw
8   BORDER = RECTANGLE, #000000, 0.25, MARKDOT
9   IMAGE="1-{(IMAGES)}",[IMAGES],0%,0%,100.299%,59.743%,0,PTG
10  FONT=Arial,14,BT,#000000
11  TEXT="1-{(YEAR)}",[YEAR],25%,60%,52%,9%
12  FONT=Arial,7.5,,#000000
13  TEXT="1-{(FACT)}",[FACT],4.5%,68.5%,91%,30%,CENTER,WORDWRAP
14  RECTANGLE=70,0,0,100%,100%,#000000
15  DISPLAY="Your_Timeline_TTS_Face.png",1,55,10
```

Vous êtes désormais prêt à utiliser Tabletop Simulator !

## Créez votre propre *Timeline* dans Tabletop Simulator

Lorsque vous ouvrez Tabletop Simulator pour la première fois, il vous demande si vous souhaitez rejoindre une partie existante ou en créer une nouvelle : choisissez `Create` (créer). Vous serez ensuite invité à charger un jeu classique, un jeu sous licence numérique, un jeu du workshop Steam, ou à `Save and Load` (sauvegarder et charger) votre propre contenu local. Choisissez `Save and Load`, puis quittez cet écran.

Vous devriez maintenant vous retrouver face à une table vide. Dans le menu supérieur, sélectionnez **Objects** (objets), puis **Components** (éléments), puis **Cards** (cartes). Parmi les options proposées, choisissez **Custom Deck** (jeu de cartes personnalisé). Cela ajoutera un jeu de cartes vierge à votre table virtuelle, et vous aurez alors la possibilité d'importer vos fichiers à partir de nanDECK pour créer votre propre jeu de cartes personnalisé (si cette option n’apparaît pas, faites un clic droit sur le jeu de cartes vierge).

Dans ce menu, vous pourrez sélectionner la face du jeu depuis votre disque local. Veillez à cocher la case située à côté de l'option **Unique backs** (dos uniques). Laissez la largeur sur 10 et la hauteur sur 7, mais ajustez le curseur pour qu’il reflète le nombre exact de cartes dans votre jeu. Une fois ces étapes terminées, cliquez sur le bouton *Import* et votre jeu sera prêt pour une partie virtuelle.

Vous pouvez désormais jouer à votre version de Timeline en ligne avec jusqu'à neuf autres joueurs invités. De plus, si vous décidez de téléverser et de partager vos éléments de jeu via le [workshop de Tabletop Simulator sur Steam](https://perma.cc/X5SQ-C87S), vous pourrez ajouter votre jeu à une collection de plus de 11 000 jeux de cartes accessibles à une communauté de plus de 2 millions d’utilisateurs de TTS.[^19]

{% include figure.html filename="en-or-designing-a-timeline-tabletop-simulator-07.png" alt="Bien que l’une des fonctionnalités les plus amusantes de Tabletop Simulator soit de préparer la table, distribuer les cartes est également très plaisant."  caption="Figure 7. Bien que l’une des fonctionnalités les plus amusantes de Tabletop Simulator soit de préparer la table, distribuer les cartes est également très plaisant." %}


## Conclusion

Je conclurai cette leçon par un autre principe tiré du "Manifesto for a Ludic Century” d'Eric Zimmerman :


>**La technologie numérique a donné une nouvelle pertinence aux jeux.**
>
>Dans notre culture, le développement de l’informatique a accompagné la résurgence des jeux. Ce n'est pas un hasard. Les jeux comme les échecs, le go, ou le parcheesi ont un point commun avec les ordinateurs : ce sont des machines créées pour générer et emmagasiner des états numériques. Si on considère les choses ainsi, ce ne sont pas les ordinateurs qui ont créé les jeux, mais les jeux qui ont créé les ordinateurs.


Zimmerman n'est pas le seul à le penser. Les jeux de société ont déjà été décrits comme des "ordinateurs en papier", car ils sont conçus par des humains et " mettent en œuvre des systèmes de règles et de procédures".[^20]

Cette leçon a pour but d’aider les étudiants en histoire et/ou les concepteurs de jeux débutants à créer et générer leurs propres variantes du jeu *Timeline*, en choisissant peut-être un thème ou un aspect spécifique de l'histoire, puis à partager leur travail avec d'autres. Ces jeux de cartes peuvent être combinés pour mêler, par exemple, l'histoire locale et l'histoire internationale. Grâce à ce processus, les joueurs découvriront des moments de simultanéité et de chevauchements historiques à la fois surprenants et fascinants (saviez-vous que l'université d'Oxford est plus ancienne que l'empire aztèque ?)

Espérons que cette expérience incitera d'autres personnes à créer des variantes de jeux existants. On pourrait imaginer créer et ajouter ses propres cartes à des jeux comme “ Trivial Pursuit", "Magic : The Gathering" ou même "Uno". Peut-être cela mènera-t-il à la création d’un tout nouveau jeu.

## Notes de fin

[^1]: Rosenberg, Daniel. “Mark Twain Memory-Builder.” Time OnLine, 2013, https://timeonline.uoregon.edu/twain/pleasures.php.
[^2]: Hodkinson, Alan, and Christine Smith. “Chronology and the New National Curriculum for History: Is It Time to Refocus the Debate?” Education 3-13, vol. 46, no. 6, Sept. 2018, pp. 700–11. Taylor and Francis+NEJM, https://doi.org/10.1080/03004279.2018.1483804.
[^3]: Lang, James M. Small Teaching: Everyday Lessons from the Science of Learning. First edition., Jossey-Bass, 2016.
[^4]: Zimmerman, Eric. (2022). The rules we break: Lessons in play, thinking, and design. Princeton Architectural Press.
[^5]: Zimmerman, Eric. “Manifesto for a Ludic Century.” The Gameful World: Approaches, Issues, Applications, edited by Steffen P. Walz and Sebastian Deterding, The MIT Press, 2015, pp. 19–22.
[^6]: McCall, J. (2016). “Teaching History With Digital Historical Games: An Introduction to the Field and Best Practices”. Simulation & Gaming, 47(4), 517–542. https://doi.org/10.1177/1046878116646693.
[^7]: Kirilloff, G. “Interactive Fiction in the Humanities Classroom: How to Create Interactive Text Games Using Twine”, Programming Historian 10, 2021. https://doi.org/10.46430/phen0095, 2021.
[^8]: “Timeline.” BoardGameGeek. Accessed February 21, 2024. https://boardgamegeek.com/boardgame/128664/timeline.
[^9]: Leonhardt, D. (2023, August 6). “A new Times quiz”. The New York Times. https://www.nytimes.com/2023/08/06/briefing/a-new-times-quiz.html
[^10]: Boyden, Bruce E. Games and Other Uncopyrightable Systems. 1580079, 20 Apr. 2011, Social Science Research Network, https://ssrn.com/abstract=1580079.
[^11]: Timeline & Stag Hunt. Directed by Richard Malena-Webber, vol. 8, 2017. YouTube, https://www.youtube.com/watch?v=dZbkxMuBR_I.
[^12]: Zygomatic, (n.d.), “Games—Dobble”, Retrieved January 26, 2024, from https://www.dobblegame.com/en/games/.
[^13]: Jones, R. A. (n.d.). “LibGuides: Free Images from Libraries, Museums, and Archives”. Retrieved January 26, 2024, from https://libguides.lib.msu.edu/c.php?g=138076&p=7641602.
[^14]: Canada Copyright Act, RSC 1985, c C-42, s 29.
[^15]: Ludology. Ludology: Ludology Episode 203 - Winging It. 203, https://ludology.libsyn.com/ludology-episode-203-winging-it. Accessed 8 Oct. 2022.
[^16]: Nini, Andrea “Nand.” NanDECK Manual Program Version 1.27 – 2022-07-27. Andrea “Nand” Nini, 2022, https://www.nandeck.com/download/204/.
[^17]: Hall, C. “Tabletop gaming in 2021 will be defined by these last 12 months of chaos”, 8 Jan. 2021, Polygon. https://www.polygon.com/2021/1/8/22178462/board-games-rpgs-2021-magic-dungeons-dragons-pandemic-black-lives-matter. Accessed 25 Jan. 2024.
[^18]: Boyle, B. “How Board Gamers Embraced Tabletop Sims During Lockdown”, 29 May 2020, Vice. https://www.vice.com/en/article/pkybxv/board-games-tabletop-simulator-tabletopia-quarantine. Accessed 25 Jan. 2024.
[^19]: Berzerk Games. “Developer & Publisher Information.” Tabletop_Simulator, 2023, https://tabletopsimulator.com/contact/publishers.
[^20]: Sayers, Jentery. Paper Computers. 2018, https://jntry.work/archive/syllabi/508v4/.
