---
title: "TowSty : concevoir un site web avec l’éditeur de texte Stylo et le langage Julia"
slug: concevoir-web-avec-stylo-julia-1
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Josselin Morvan
- Antoine Fauchié
- Julien Dehut
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/679
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

Lorsque l’on souhaite aujourd’hui publier des textes en ligne, l’offre est importante. WordPress, par exemple, utilisé par plus de 40 % des sites web[^1], s’est imposé comme une solution auprès d’un public qui n’est pas composé que de spécialistes en informatique. Une partie de ce succès nous semble ainsi venir de l’interface d’écriture qu’il propose. Cette interface a subi de nombreuses évolutions, plus ou moins appréciées par la communauté d’ailleurs. Elle permet de structurer facilement du contenu pour le web sans avoir besoin de connaître au préalable le HTML ou le CSS, et cela dans une logique qui se révèle relativement proche de celle de l’interface d’un traitement de texte[^2]. Cette interface propose également un moyen simple pour prévisualiser et publier ce contenu structuré.

L’infrastructure du côté du serveur reste cependant assez lourde, avec notamment MySQL et PHP qui demandent un suivi constant et des mises à jour régulières. Si l’on prend en plus en compte les différents *plugins* produits par l’écosystème profitable de cette plateforme, la surface d’attaque se révèle alors importante. Déployer seul une instance de WordPress n’est pas toujours simple, et ce n’est certainement pas trivial à maintenir dans le temps.

Il reste toujours la possibilité de créer un site \_ex nihilo\_, ce qui induit de produire le HTML pour chaque page, une feuille de styles CSS, et de mettre tout cela en ligne avec SSH ou FTP. Cette approche, pourtant garante d’une certaine indépendance technique, d’une très faible maintenance et d’une grande légèreté pour le serveur, apparaît contraignante au quotidien. Il faut baliser -- préalablement à la publication -- chacun des paragraphes et des titres. Si de surcroit on prend en compte le style avec les différentes résolutions des écrans et tout ce qui permet un accès au contenu, par exemple les liens entre les articles ou un index, le développement complet d’un site web prend du temps. Au contraire de WordPress, qui permet de se concentrer sur le contenu[^3].

Une autre hypothèse consiste à utiliser un générateur de site statique. L’utilité de cette approche permet de simplifier l’écriture de contenus grâce au langage Markdown[^4] et de permettre la structuration d’un site sans avoir besoin de gérer manuellement le HTML, le CSS ou même le SQL. En général, une commande permet de construire le site, c’est-à-dire de convertir le Markdown en HTML et d’en générer la structure, dont les index. Lorsque l’on est prêt à publier un texte et donc à le copier sur un serveur, ces générateurs de site doivent être exécutés localement et préalablement afin de produire la nouvelle page ainsi que toutes ses relations aux autres[^5].

Toutes ces approches ont évidemment un intérêt, et de nombreux universitaires s’en sont emparés afin de produire un site _ad hoc_ pour leur recherche, que ce soit un simple carnet ou même des sites plus complexes[^6]. En ce qui concerne les carnets, le monde universitaire francophone connaît bien Hypothèses, c’est-à-dire WordPress. Le succès de cette approche n’est pas à démontrer. Mais la possibilité de créer ces carnets semble aujourd’hui difficile[^7]. Et cela représente toujours un système très complexe et coûteux pour afficher bien souvent des pages de texte simples[^8].

Ces solutions peuvent également induire une certaine dette technique pour les utilisateurs. Si leur grande diversité permet de trouver un système qui s’appuie sur des éléments de syntaxe d’un langage que l’on connaît déjà, par exemple Python, il devient parfois difficile de maîtriser tous les éléments de la chaîne éditoriale. [NPM](https://fr.wikipedia.org/wiki/Npm), par exemple, montre bien pédagogiquement toutes les dépendances obsolètes qui devraient être mises à jour, mais sans moyen pour l’utilisateur de résoudre ce problème facilement, et sans que soit exercé en amont un contrôle sur ces programmes qui peuvent contenir toutes sortes de surprises[^9]. L’installation sur son ordinateur de la structure à même de produire du contenu peut se révéler ainsi difficile à maintenir, mais aussi relativement complexe à évaluer en regard des conséquences pour son propre ordinateur.

De plus, ces générateurs de sites statiques se reposent sur l’éditeur de code du client qui ne propose pas, par défaut, la capacité d’écrire des articles à plusieurs, de versionner simplement, ni même de pouvoir éventuellement exporter le contenu de son document sous la forme de PDF. Et surtout, pour le monde universitaire, de gérer nativement la bibliographie. Cela contrairement à l’éditeur de texte [Stylo](https://stylo.huma-num.fr).

### Intérêt de l’approche TowSty

C’est là, il nous semble, l’intérêt de l’approche portée par TowSty. D’une part, la rédaction des contenus est réalisée depuis Stylo, qui fédère aujourd’hui à raison des usagers dans le monde universitaire, et, de l’autre, TowSty, un programme écrit en [Julia](https://fr.wikipedia.org/wiki/Julia_(langage)) qui permet de produire à partir de quelques fonctions simples un site complet depuis les articles de cet éditeur de texte en ligne.

### Objectifs de la leçon

Cette leçon présente donc comment générer un site web depuis Stylo avec TowSty. Nous montrerons les avantages de ces deux prérequis au sein de développements spécifiques qui leur sont consacrés. Il n’est donc pas nécessaire de connaitre Stylo ou Julia. Nous verrons ensuite point par point comment réaliser le premier article de ce qui pourrait s’apparenter au site d’un carnet de recherche.


## Stylo : un éditeur de texte sémantique et connectable

[Stylo](https://stylo.huma-num.fr/) est un éditeur de texte sémantique conçu pour l’écriture et l’édition de textes – comme des articles et des monographies. Cet outil est pensé pour permettre une reprise en main de la rédaction et de la publication scientifique. Proposé à la communauté universitaire, il repose sur des principes clairs, des standards ouverts et une communauté active de chercheuses et de chercheurs. Enfin, Stylo est à la fois un outil, une preuve de concept, une expérimentation scientifique et un terrain de recherche.


### _Stylosophie_

Stylo a été créé et développé par le Laboratoire de recherche sur les écritures numériques ([https://www.ecrituresnumeriques.ca/](https://www.ecrituresnumeriques.ca/fr)) -- anciennement Chaire de recherche du Canada sur les écritures numériques -- et soutenu par l’infrastructure de recherche française Huma-Num. Il s’agit d’un logiciel libre dont les sources sont disponibles sous licence libre GPL-3 ([https://github.com/EcrituresNumeriques/stylo/](https://github.com/EcrituresNumeriques/stylo/)). Huma-Num propose une instance en ligne, dont l’accès est ouvert à toute personne (la création d’un compte HumanID est recommandée) : [https://stylo.huma-num.fr](https://stylo.huma-num.fr).

<div class="alert alert-warning">
Une connexion Internet est nécessaire pour utiliser cette application web. Néanmoins, les articles sont rédigés au format Markdown, et peuvent être facilement téléchargés pour une utilisation locale avec d'autres logiciels (notamment libres).

Les données stockées par Stylo (et donc par Huma-Num) font l’objet de sauvegardes via des opérations de redondance.
</div>

Le principe central de Stylo est de permettre une écriture et une édition sémantiques via des formats sources structurés, avec des possibilités d’export divers dans des formats adaptés à des usages personnels et professionnels. Les formats sources sont : Markdown pour les contenus, YAML pour les métadonnées et BibTeX pour les références bibliographiques. Les contenus sont ainsi qualifiés (niveaux de titres, paragraphes, listes, citations longues, liens hypertextes, images, références bibliographiques, etc.) afin de pouvoir être convertis vers les formats PDF, XML, DOCX ou ICML.


### Des opérations de conversions

Stylo est en fait une suite de modules, dont l’interface web avec laquelle les utilisateurs et les utilisatrices interagissent représente la partie visible, mais au sein duquel le module d’export – partie invisible – joue un rôle essentiel. En effet celui-ci effectue toutes les conversions en utilisant le logiciel Pandoc. Une des fonctions de Stylo est donc de faciliter les conversions des documents fondés sur le trio Markdown-YAML-BibTeX vers d’autres formats, comme la leçon « [Rédaction durable avec Pandoc et Markdown](https://programminghistorian.org/fr/lecons/redaction-durable-avec-pandoc-et-markdown) » l’explique bien.

Les conversions dépendent de plusieurs paramètres : les gabarits (ou _templates_ en anglais) pour répartir les contenus dans un document ; des feuilles de style bibliographique (parmi les quelques 10 000 styles CSL répertoriés) pour la mise en forme des références bibliographiques (dans le texte et dans la bibliographie) ; ou des paramètres de transformation qui dépendent des formats de sortie. Le module d’export gère tous ces détails, avec des _templates_ préconfigurés et correspondant à des besoins spécifiques selon le type de publication ou la destination (domaine ou pays de la revue scientifique, diffuseur numérique, contraintes d’archivage, etc.).


### Des fonctionnalités de travail

Stylo comporte plusieurs fonctionnalités qui en font autant un outil d’écriture qu’un outil d’édition. Les espaces de travail, ou _workspaces_, permettent de rassembler plusieurs *articles*[^10] et de partager cet espace avec d’autres personnes. Les corpus sont des sous-ensembles de ces espaces, offrant un moyen supplémentaire de les organiser.

Enfin, Stylo dispose d’une fonctionnalité d’édition collaborative : il est possible d’écrire à plusieurs, de façon simultanée, sur un même document. Cette fonctionnalité complète les espaces de travail qui permettent déjà de travailler avec d’autres personnes.

<div class="alert alert-warning">
Stylo comporte bien d'autres fonctionnalités, la documentation les décrit en détail : <a href='https://stylo-doc.ecrituresnumeriques.ca/fr/'>https://stylo-doc.ecrituresnumeriques.ca/fr/</a>.
</div>


### Une interface web et une API

Stylo est d’abord accessible via une interface web, mais il est aussi possible de récupérer les différents contenus via une API GraphQL. Cette API, [documentée](https://stylo-doc.ecrituresnumeriques.ca/fr/tutoriels/api-graphql/), offre plusieurs fonctionnalités, et notamment le fait de pouvoir transférer tous les documents d’un espace de travail, ou tous les documents de tous les corpus d’un espace de travail par exemple. Il est ainsi possible de connecter des logiciels ou programmes à cette API pour télécharger les contenus souhaités, sans passer par l’interface web. C’est précisément cette API qu’utilise TowSty pour générer un site web à partir de Stylo.

<div class="alert alert-warning">
L’utilisation sécurisée de l’API de Stylo nécessite l'utilisation d’une clé qui autorise les applications tierces à récupérer/modifier des contenus. Cette clé est disponible sur la page de profil de Stylo (dans le menu supérieur, cliquer sur votre nom/pseudonyme), sous "Clé d'accès à l'API".

<b>Attention</b> : cette clé doit rester secrète et ne doit pas être partagée avec quelqu’un d’autre ou sur un espace public en ligne.
</div>

Dans la suite de cette leçon nous détaillons les procédures de création d’articles et l’association de ces articles à des espaces de travail et à des corpus dans le cas de l’utilisation de TowSty. Mais avant cela, il nous faut expliquer pourquoi TowSty est écrit en Julia.


## Pourquoi Julia ?

Nous avons fait le choix de développer TowSty avec le langage [Julia](https://julialang.org/). Ce choix peut sembler étonnant au regard de son utilisation qui reste [marginale](https://spectrum.ieee.org/top-programming-languages-2025) face au géant Python. Alors, pourquoi Julia ? Cette question est devenue une sorte de *gimmick* depuis l’[article *Why We Created Julia*](https://julialang.org/blog/2012/02/why-we-created-julia/) annonçant la parution de ce nouveau langage de programmation, et quasiment chaque manuel dispose d’une section « *Why Julia?* ». Ses créateurs l’ont imaginé avec le cahier de charges suivant en tête :

> Nous voulons un langage *open source*, avec une licence libre. Nous voulons la vitesse de C avec le dynamisme de Ruby. Nous voulons un langage [homoiconique](https://fr.wikipedia.org/wiki/Homoiconicit%C3%A9), avec de véritables macros comme Lisp, mais avec une notation mathématique évidente et familière comme Matlab. Nous voulons quelque chose d’aussi généraliste que Python pour la programmation, aussi facile que R pour les statistiques, aussi naturel que Perl pour le traitement des chaînes de caractères, aussi puissant que Matlab pour l’algèbre linéaire, aussi efficace que le shell pour assembler des programmes. Quelque chose qui soit extrêmement simple à apprendre, tout en satisfaisant les hackers les plus sérieux. Nous voulons qu’il soit interactif et compilé.  
> (Avons-nous mentionné qu’il devrait être aussi rapide que C ?)  
> [Jeff Bezanson, Stefan Karpinski, Viral B. Shah, Alan Edelman, Why We Created Julia](https://julialang.org/blog/2012/02/why-we-created-julia/)

Julia est un langage facile d’accès. La syntaxe claire tire pleinement partie d’Unicode tout en étant assez proche des notations mathématiques. Il est également aisé de déployer des environnements et de partager des projets. La gestion des [types](https://fr.wikipedia.org/wiki/Type_(informatique)) est également plus aboutie que ce que propose Python. La communauté est certes plus réduite mais très dynamique et accueillante, et l’organisation de certains *packages* autour de grandes thématiques (l’analyse de réseaux ou les images par exemple) favorise les réflexions et les discussions sur les approches possibles. Enfin, c’est un langage qui permet des passerelles, puisqu’il est possible de faire des appels Python ou R directement depuis Julia : on n’est donc jamais bloqué si d’aventure il manquait une brique à notre projet.

### Installation

Julia est disponible sur GNU Linux, MacOs, Windows et FreeBSD. Plusieurs solutions sont proposées pour l’installation depuis le [site officiel](https://julialang.org/downloads/).

La méthode la plus simple est certainement d’utiliser le script d’installation puis de vous laisser guider en exécutant les commandes Curl ou Winget dans votre terminal :

- GNU Linux et MacOs
```bash
curl -fsSL https://install.julialang.org | sh
```

- Windows
```bash
winget install --name Julia --id 9NJNWW8PVKMN -e -s msstore
```

<div class="alert alert-warning">
À la fin de l’installation, veillez à accepter l’ajout de Julia dans votre <a href='https://perma.cc/HWL8-UMEC'>variable d’environnement</a> (PATH).
</div>

Il est également possible de télécharger directement les exécutables et/ou installeurs, selon votre système, depuis la page des [téléchargements manuels](https://julialang.org/downloads/manual-downloads/).

Pour cette leçon, nous exécuterons Julia directement dans un terminal ; des modules existent afin d’améliorer l’expérience dans les principaux IDE notamment VSCode/VSCodium, Zed, Vim/Neovim.

### Hello, Julia!

Une fois l’installation effectuée, pour lancer Julia il suffit de taper la commande `julia` dans votre terminal. Vous accédez alors au [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop), l’environnement de programmation interactif de Julia.

```julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.12.0 (2025-10-07)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org release
|__/                   |

julia>
```

L’invite `julia>` nous permet de saisir du code à exécuter. Il est d’usage de tester un nouveau langage de programmation avec l’affichage du fameux « Hello, World! », que nous adaptons pour cette leçon. Si nous tapons l’instruction `println("Hello, Julia!")`, après avoir appuyé sur le touche `Entrée`, le REPL affiche :

```julia
julia> println("Hello, Julia!")
Hello, Julia!
```

La présence de parenthèses indique que `println` est une fonction, et les guillemets doubles délimitent la chaîne de caractères que l’on souhaite afficher.

Pour obtenir plus d’information sur cette fonction, on peut passer le REPL en mode *Help* en appuyant sur la touche `?`. L’invite change pour devenir `help?>`, on peut alors appeler une fonction pour obtenir de l’aide :

```julia
help?> println()
  println([io::IO], xs...)

  Print (using print) xs to io followed by a newline. If io is not supplied,
  prints to the default output stream stdout.

  See also printstyled to add colors etc.

  Examples
  ≡≡≡≡≡≡≡≡

  julia> println("Hello, world")
  Hello, world

  julia> io = IOBuffer();

  julia> println(io, "Hello", ',', " world.")

  julia> String(take!(io))
  "Hello, world.\n"
```

Pour quitter le mode *Help*, on peut, au choix, utiliser la touche d’effacement arrière (`backspace`) ou la combinaison `crtl + c`. Cette dernière combinaison permet en outre de mettre fin à tout processus en cours d’exécution.

### Les principaux littéraux et types

Nous avons vu précédemment qu’une chaîne de caractères est placée entre guillemets doubles, mais bien évidemment ce n’est pas le seul type accepté par Julia. Les principaux types sont :

- `"Hello Programming Historian!"::String` → chaîne de caractères
- `'a'::Char` → caractère
- `10::Int` → entier
- `2.0::Float64` → flottant
- `false::Bool` → booléen

La syntaxe `litt::T` associe un littéral `litt` avec un type `T`. Julia repose sur un [typage dynamique](https://fr.wikipedia.org/wiki/Typage_dynamique). L’assertion de type n’est donc pas nécessaire, même si elle peut s’avérer utile pour optimiser son algorithme. On notera toutefois que les types sont toujours identifiés par une capitale et que Julia distingue les chaînes de caractères entre guillemets doubles (`"Hello"`), des caractères entre guillemets simples (`'a'`).

Pour connaître le type d’un littéral, on utilise la fonction `typeof()` :

```julia
julia> typeof(99)
Int64

julia> typeof("10")
String

julia> typeof("a")
String

julia> typeof('a')
Char
```

### Les variables

Pour affecter une valeur à une variable on utilise l’opérateur `=` :
```julia
julia> s = "Hello, Julia!"
"Hello, Julia!"

julia> x = 10
10
```

Et pour appeler une variable, il suffit de la nommer :
```julia
julia> println(s)
Hello, Julia!

julia> x + 9
19
```

Les noms de variable peuvent contenir des lettres, des caractères Unicode, des chiffres (mais pas en première position), des underscores `_`, et même des points d’exclamation `!` (par convention placés à la fin des fonctions comportant des mutations). Certains caractères ou mots-clés sont toutefois réservés comme `@`, `struct`, `function`, `if`, `else`, etc.

Enfin, les abréviations LaTeX peuvent être utilisées pour appeler certains caractères Unicode, il suffit de taper la commande LaTeX correspondante, puis d’appuyer sur tabulation.

```julia
julia> \alpha # + tabulation donne…
julia> α
```

<div class="alert alert-warning">
Attention toutefois, certains caractères cachent une fonction ou une constante :
<code>julia
julia> √16 # \sqrt + tabulation
4.0

julia> π # \pi + tabulation
π = 3.1415926535897...
</code>
</div>

### Opérations courantes

Comme tous les langages de programmation, Julia permet d’effectuer toutes les opérations et comparaisons courantes sur les chaînes de caractères ou les nombres.

#### Les nombres

Les opérateurs arithmétiques permettent d’effectuer les opérations mathématiques fondamentales sur les nombres. L’ordre d’évaluation des opérateurs suit les conventions mathématiques [PEMDAS](https://fr.wikipedia.org/wiki/Ordre_des_op%C3%A9rations).

- `+` : addition
- `-` : soustraction
- `^` : puissance
- `*` : multiplication
- `/` : division
- `\` : division inverse
- `%` : modulo (reste d’une division euclidienne)

```julia
julia> 2*2+2^3-2/2
11.0

julia> 7%3
1
```

#### Les chaînes de caractères

Les concaténations s’effectuent avec l’opérateur `*` ou la fonction `string()`, et les interpolations avec l’opérateur `$`.

```julia
julia> forename, surname = "Victor", "Hugo" # affectation de deux variables
("Victor", "Hugo")

julia> string(forename, " ", surname) # concaténation avec string()
"Victor Hugo"

julia> forename * " " * surname # concaténation avec l’opérateur *
"Victor Hugo"

julia> "L’auteur du Dernier jour d’un condamné est $forename $surname." # interpolation
"L’auteur du Dernier jour d’un condamné est Victor Hugo."
```

Les chaînes peuvent également être vues comme des tableaux (*array*) de caractères. Il devient alors très facile d’accéder à des sous-chaînes ou d’effectuer des itérations :

```julia
julia> fullname = string(forename, " ", surname)
"Victor Hugo"

julia> fullname[1:6] # les tableaux sont indexés à partir de 1 dans Julia
"Victor"

julia> typeof(fullname[1:6])
String

julia> typeof(fullname[1])
Char

julia> fullname[1] + 1 # V + 1 (lettre suivante)
'W': ASCII/Unicode U+0057 (category Lu: Letter, uppercase)

julia> foreach(println, fullname[1:6]) # itération
V
i
c
t
o
r
```

#### Comparaisons

Enfin, les opérateurs de comparaison sont les mêmes que dans la plupart des langages de programmation, à savoir :

- `==` : égalité
- `===` : égalité stricte
- `!=` : inégalité
- `>` : plus grand
- `>=`  : plus grand ou égal
- `<` : plus petit
- `<=` : plus petit ou égal

```julia
julia> x, y = 1, 1.0
(1, 1.0)

julia> x == y
true

julia> x === y
false
```

Nous n’énumérons bien évidemment pas ici toutes les opérations possibles sur les nombres et les chaînes de caractères.

### Utiliser des paquets

Lorsque les fonctions inclues dans la bibliothèque standard de Julia ne suffisent plus, il est nécessaire d’installer des paquets afin d’accéder à de nouvelles fonctionnalités. Le REPL de Julia dispose d’un mode *Package* accessible avec la touche `]` depuis l’invite de commandes `julia>`.

Les instructions `add` et `remove` permettent respectivement d’installer ou de supprimer un paquet, alors que `status` permet de lister les paquets disponibles. Pour installer le paquet [`Example.jl`](https://github.com/JuliaLang/Example.jl) :

```julia
(@v1.12) pkg> add Example
    Updating registry at `~/.julia/registries/General.toml`
   Resolving package versions...
   Installed Example ─ v0.5.5
    Updating `~/.julia/environments/v1.12/Project.toml`
  [7876af07] + Example v0.5.5
    Updating `~/.julia/environments/v1.12/Manifest.toml`
  [7876af07] + Example v0.5.5
Precompiling packages finished.
  1 dependency successfully precompiled in 1 seconds. 88 already precompiled.

(@v1.12) pkg> status
Status `~/.julia/environments/v1.12/Project.toml`
  [7876af07] Example v0.5.5
```

Vous pouvez quitter à présent le mode *Package* afin d’utiliser `Example.jl` (touche `backspace` ou `ctrl + c`). En premier lieu, il convient d’appeler votre paquet nouvellement installé pour bénéficier de sa bibliothèque de fonctions. Pour ce faire, on utilise le mot-clé `using` suivi du nom du paquet :

```julia
julia> using Example
```

Pour prendre connaissance de cette bibliothèque, vous pouvez utiliser le mode *Help* de Julia :

```julia
help?> Example
search: Example

  No docstring found for public module Example.

  Public names
  ≡≡≡≡≡≡≡≡≡≡≡≡

  domath, hello

  ────────────────────────────────────────────────────────────────────────────────

  Package description from README.md: Example Julia package repo.
```

Deux fonctions sont disponibles, `domath()` et `hello()`. Pour en savoir plus sur la première, le mode *Help* reste votre meilleur allié.

```julia
help?> domath
search: domath normpath ispath match popat! coth joinpath detach mkpath

  domath(x::Number)

  Return x + 5.
```

`domath()` est une fonction qui accepte un argument de type `Number` et qui retourne ce nombre augmenté de 5. Essayez-là dans l’invite de commandes Julia !

```julia
julia> domath(14)
19
```

Cette brève introduction à Julia nous a semblé nécessaire pour la bonne compréhension de la section suivante sur le paquet `TowSty.jl`. Nous espérons malgré tout avoir suscité votre curiosité pour cette alternative à Python !

## TowSty en pratique

### Création d’un article type

TowSty rapproche Stylo de la fonction de [CMS](https://fr.wikipedia.org/wiki/Syst%C3%A8me_de_gestion_de_contenu). Toutes les pages de votre site sont construites depuis l’interface de cet éditeur de texte en ligne et s’appuient donc sur les avantages de cet outil, dont la prévisualisation du code en Markdown et la collaboration en temps réel.

La logique de Stylo est de rattacher des articles à des corpus qui peuvent appartenir à différents espaces de travail. TowSty s’appuie profondément sur ces principes d’organisation et structure le site à partir de cette hiérarchie. Dans une première approche, vous pouvez donc créer un espace de travail spécifique qui accueillera votre site.

Par défaut vous disposez d’un seul espace de travail : « Mon espace ». Pour créer un nouvel espace de travail, il faut se rendre dans « Espaces de travail », puis sélectionner « Tous les espaces », et enfin cliquer sur « Créer un espace de travail ».
Il faut alors renseigner un nom, et facultativement une description et une couleur pour faciliter le repérage visuel.

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-01.png" alt="vue de l’espace de travail de Stylo" caption="Figure 1. L’interface pour créer un nouvel espace de travail (workspace en anglais)" %}

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-02.gif" alt="champ de titre de l’espace de travail" caption="Figure 2. Donnez un titre à votre espace de travail" %}

Vous pouvez désormais sélectionner votre nouvel espace de travail.

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-03.png" alt="l’onglet espace de travail de stylo" caption="Figure 3. Votre nouvel espace de travail devrait apparaître dans l’onglet" %}

TowSty génère les différentes sections d’un site depuis les corpus. Les titres de ces corpus sont utilisés pour générer les intitulés du menu de navigation. Pour créer un corpus il faut aller dans l’onglet « Corpus », puis cliquer sur « Créer un corpus », puis renseigner au moins le titre, voire la description, et valider. Les corpus sont rattachés à un espace de travail.

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-04.gif" alt="champ de création d’un corpus" caption="Figure 4. Donnez un titre à votre corpus" %}

Vous pouvez donc créer un corpus « Actualités », par exemple.

Finalement, vous pouvez créer votre premier article.

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-05.png" alt="vue sur la page de création d’article de stylo" caption="Figure 5. Créez le premier article de votre site" %}

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-06.png" alt="champ de titre pour l’article" caption="Figure 6. Donnez un titre à votre article" %}

Et le rattacher à votre corpus : déroulez les options, puis cochez les corpus souhaités pour chaque article.

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-07.gif" alt="rattachement au corpsu" caption="Figure 7. Cliquez sur la flêche  devant le nom de votre article pour faire apparaître le menu de rattachement aux corpus" %}

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-08.png" alt="boutton de rattachement" caption="Figure 8. Il ne vous reste qu’à cliquer sur le case à cocher pour le rattacher" %}

À noter que depuis l’onglet « Corpus », et pour chaque corpus, il est possible de réorganiser l’ordre des articles,  il est également possible d’accéder aux articles _depuis_ les corpus.

Les articles Stylo sont rédigés en Markdown. Il s’agit d’un langage de balisage léger, conçu d’abord pour produire des documents HTML sans avoir besoin d’écrire des balises verbeuses.
À partir de signes typographiques non ambigus et relativement discrets, il est possible de rédiger un texte de façon sémantique : différents niveaux de titre, des paragraphes, des listes, des citations longues, de l’emphase, etc.
Pour plus d’informations sur le Markdown, et notamment les règles de rédaction, voir la leçon « [Bien débuter avec Markdown](https://programminghistorian.org/fr/lecons/debuter-avec-markdown) ».

Les articles peuvent disposer d’une entête YAML qui est placée au tout début du document. Elle contient les métadonnées. YAML est un langage de sérialisation de données qui fonctionnent selon un principe simple : une clef, une valeur.
Ainsi, chaque métadonnée est représentée par un couple clef-valeur séparé par le signe `:`, par exemple :

```yaml
---
title: "Premier article pour TowSty"
---
```

Les trois tirets `---` délimitent le début et la fin des métadonnées.

Stylo propose également un _masque de saisie_ afin de simplifier la rédaction et éviter les erreurs de syntaxe. L’ajout d’une espace avant les deux points ou l’oubli de guillemets peuvent rendre impossible la lecture des métadonnées. 

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-09.png" alt="Masque de saisie" caption="Figure 9. Un premier entête avec le titre de notre article" %}

Pour TowSty, l’entête doit contenir au moins la métadonnée `title`. La valeur de cette clé est alors utilisée par TowSty pour générer le titre de l’article sur le site. Il n’est donc pas nécessaire de le préciser dans le corps du texte.

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-10.png" alt="rendu de l’entête YAML dans stylo" caption="Figure 10. Un premier entête avec le titre de notre article" %}

Vous pouvez bien évidemment ajouter autant de paragraphes et de niveaux hiérarchiques que vous le souhaitez.

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-11.png" alt="article avec des niveaux hiérarchiques" caption="Figure 11. Ajouter en Markdown autant de texte et de paragraphes que vous le souhaitez" %}

L’un des avantages majeurs de cette démarche est de permettre une gestion native de la bibliographie avec l’implémentation par Stylo du format BibTeX et de Zotero. Le format BibTeX est un langage de description de références bibliographiques, qui est également fondé sur un principe de clé-valeur, par exemple :

{% raw %}
```tex
@article{
  title = {{Écrire les SHS en environnement numérique. L’éditeur de texte Stylo}},
  author = {{Vitali-Rosati}, Marcello and Sauret, Nicolas and Fauchié, Antoine and Mellet, Margot},
  year = 2020,
  journal = {Revue Intelligibilité du Numérique},
  doi = {10.34745/numerev_1697},
  urldate = {2020-10-08},
  langid = {french},
}
```
{% endraw %}

Si vous utilisez Zotero pour organiser votre bibliographie, vous pouvez également connecter directement votre compte à Stylo afin d’ajouter un corpus bibliographique :

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-12.png" alt="bouton bibliographie" caption="Figure 12. Cliquez sur le panneau latéral de Stylo puis sur le menu bibliographie" %}

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-13.png" alt="contenu du menu bibliographie" caption="Figure 13. C’est ici que vous pouvez lier votre texte à sa bibliographie Zotero" %}

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-14.png" alt="champ d’ajout de bibliographie" caption="Figure 14. C’est ici que vous pouvez lier votre texte à sa bibliographie Zotero" %}

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-15.png" alt="résultat de l’importation" caption="Figure 15. Les références bibliographiques apparaissent alors sur le côté" %}

Pour aller au plus vite depuis la page jusqu’à sa publication, vous pouvez citer l’intégralité des références présentes dans votre collection. Il suffit alors d’ajouter la mention `nocite` à votre entête YAML qui devient :

```yaml
title: "Premier article pour TowSty"
nocite: |
 @*
```

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-16.png" alt="vu sur l’entête YAML avec la référence pour les citations" caption="Figure 16. Ajoutez simplement cette référence et cette valeur" %}

La bibliographie apparaît alors à la fin de votre document lorsque vous prévisualisez votre page :

{% include figure.html filename="fr-or-concevoir-web-avec-stylo-julia-17.png" alt="vu sur la bibliographie" caption="Figure 17. La bibliographie est générée automatiquement" %}

Maintenant, vous devriez avoir rempli tous les prérequis pour pouvoir
utiliser TowSty.

Un premier déploiement se déroule typiquement en quatre grandes étapes :

1. l’installation des paquets nécessaires à TowSty dans Julia ;
2. l’initialisation du projet ;
3. la récupération des données de Stylo ;
4. la génération du site.

### Installation des paquets TowSty

TowSty a été conçu pour être adaptable, notamment en ce qui concerne la mise en page, mais aussi pour permettre le déploiement rapide d’un site. Il repose ainsi sur un système de modèles (*templates*) écrits en HTML et en CSS qui sont modifiables et accessibles facilement. Le cœur de TowSty est donc découplé de ces modèles afin d’en simplifier la personnalisation et le développement. Pour vous, ici, cela veut dire que vous devez installer deux paquets depuis le mode *package* (en appuyant sur la touche `]`) :

1. les modèles (*templates* responsables du rendu du site) :

```julia
pkg> add https://gitlab.huma-num.fr/ceen/towsty/towstytemplates.jl.git
```

2. le moteur de TowSty (c’est-à-dire le programme en lui-même) :

```julia
pkg> add https://gitlab.huma-num.fr/ceen/towsty/towsty.jl.git
```

Une fois que ces deux paquets sont installés, vous pouvez créer votre premier projet TowSty.

### Initialisation du projet

Avant cela, vous devez dire à Julia que vous souhaitez désormais utiliser ce paquet que vous venez d’installer. Si vous êtes toujours en mode *package*, il vous faut retourner au mode interpréteur de commande (avec la touche `retour arrière/backspace`). Vous pouvez alors taper :

```julia
julia> using TowSty
```

Grâce à Julia, vous bénéficiez de l’aide à la complétion du code et de la documentation. Il vous suffit ainsi de taper « *new* » pour qu’apparaisse en grisé la fonction :

```julia
julia> newproject
```

Le seul paramètre indispensable est le nom donné à votre site TowSty. Mais c’est également depuis cette fonction que l’on peut choisir parmi les *templates* possibles. Nous souhaitons proposer à terme une large bibliothèque de choix pour le rendu. Pour lister les modèles disponibles vous pouvez taper :

```julia
julia> templates()
jj
tinlizzie
```

Par défaut `newproject()` utilise le *template* `jj`.

```julia
julia> newproject("essai")
```

Vous pouvez aussi spécifier avec le mot-clé `template` un autre modèle.

```julia
julia> newproject("essai", template="tinlizzie")
```

Vous êtes alors prêts à récupérer toutes les informations contenues dans les *corpus* Stylo.

### Récupération des informations depuis Stylo

À cette fin, vous avez besoin de l’identifiant de l’espace de travail (*workspace*) mais aussi de la clé API de Stylo. Ces deux informations doivent être fournies comme paramètres de la fonction `getworkspace()`.

```julia
julia> getworkspace("workspace_id", "clé_apistylo")
```

Remplacez ces deux valeurs par les vôtres. TowSty va alors récupérer tous les articles et tous les corpus de cet espace de travail.

### Génération du site hybride

Il ne vous reste alors qu’à saisir :

```julia
julia> toaster()
```

pour que votre site soit généré. La fonction `toaster()` vous informe que votre site est disponible à l’adresse et au port suivant :

```julia
[ Info: Listening on: 127.0.0.1:8888, thread id: 1
```

Vous venez de réaliser ce que nous appelons un site hybride qui peut être mis à jour directement depuis l’interface en ligne du site. Mais cela ne représente qu’une des modalités que propose TowSty. Pour l’instant, afin d’en actualiser le contenu, lorsqu’un nouvel article est ajouté par exemple, vous pouvez utiliser la fonction :

```julia
julia> getworkspace("workspace_id", "clé_apistylo")
```

qui va récupérer l’intégralité des données.

Il est également possible de générer un site statique. Dans ce cas, la seule fonction qui change est `toaster()` qui devient `bake()`.

```julia
julia> bake()
```

Vous obtenez ainsi l’ensemble des répertoires et des fichiers du site qui ne demandent qu’à être recopiés tel quel sur votre serveur web. Afin de mettre à jour les données du site, après avoir rentré la fonction `getworkspace("", "")` comme dans le cas d’un site hybride, vous devez exécuter la fonction :

```julia
julia> reload_data!()
```

Les nouveaux articles ou même les nouveaux corpus sont alors prêts à être transférés. Vous pouvez entrevoir les possibilités de TowSty en consultant une brève démonstration réalisée en 1h [ici](https://towsty.unepage.org/).

## Remerciements

Nous remercions sincèrement nos collègues Hélène Hôte et Élisa Barthélemy pour la  relecture de cette leçon et leurs commentaires constructifs sur la première version de ce tutoriel.


## Bibliographie indicative

Baker, James. « Preserving Your Research Data ». *Programming Historian*, 30 avril 2014. <https://programminghistorian.org/en/lessons/preserving-your-research-data>.

Camden, Raymond, et Brian Rinaldi. *The Jamstack Book: Beyond Static Sites with JavaScript, APIs, and Markup*. Simon and Schuster, 2022. <https://books.google.com?id=nZVsEAAAQBAJ>.

———. *Working with Static Sites: Bringing the Power of Simplicity to Modern Sites*. "O’Reilly Media, Inc.", 2017. <https://books.google.com?id=3NFLDgAAQBAJ>.

« CodeStitch, High Quality HTML and CSS Only Component Library, No Frameworks, No Configurations ». Consulté le 25 février 2026. <https://codestitch.app/>.

« Créer votre blog ». fr.hypotheses.org. Consulté le 25 février 2026. <https://fr.hypotheses.org/creer-et-gerer-votre-blog>.

« Des Packages Npm Compromis Pour Diffuser Des Malwares - Le Monde Informatique ». Consulté le 20 janvier 2026. <https://www.lemondeinformatique.fr/actualites/lire-des-packages-npm-compromis-pour-diffuser-des-malwares-97524.html>.

Diaz, Chris. « Using Static Site Generators for Scholarly Publications and Open Educational Resources ». *The Code4Lib Journal*, nᵒ 42 (8 novembre 2018).<https://journal.code4lib.org/articles/13861?utm_campaign=the%20New%20Dynamic&utm_medium=email&utm_source=Revue%20newsletter>.

« HTML5 UP ». HTML5 UP. Consulté le 25 février 2026. <http://html5up.net/>.

Lincoln, Matthew, Jennifer Isasi, Sarah Melton, et François Dominic Laramée. « Relocating Complexity: The Programming Historian and Multilingual Static Site Generation ». *Digital Humanities Quarterly* 16, nᵒ 2 (25 juin 2022).

Nguyen, Dang-Khoa, Gia-Thang Ho, Quang-Minh Pham, Tuyet A. Dang-Thi, Minh-Khanh Vu, Thanh-Cong Nguyen, Phat T. Tran-Truong, et Duc-Ly Vu. « Taint-Based Code Slicing for LLMs-based Malicious NPM Package Detection », 10 janvier 2026. <https://doi.org/10.48550/arXiv.2512.12313>.

« Official Tailwind UI Components & Templates - Tailwind Plus ». Consulté le 25 février 2026. <https://tailwindcss.com>.

Parviainen, Tero. « Overcoming JavaScript Framework Fatigue », 15 juillet 2015. <https://teropa.info/blog/2015/07/15/overcoming-javascript-framework-fatigue.html>.

Rayarao, Surya Rao, et Naga Donikena. « The Shai-Hulud NPM Supply Chain Attack: A Comprehensive Analysis of Self-Replicating Malware in the JavaScript Ecosystem ». Consulté le 20 janvier 2026.
<https://www.authorea.com/doi/full/10.22541/au.175830854.42750868?commit=9bc3206ca741614366ba5db6e82b14eba325b6d0>.

Risam, Roopika, et Lee Skallerup Bessette. « Introduction: Minimal Computing and EdTech ». *Learning, Media and Technology* 49, nᵒ 5 (6 décembre 2024) : 747‑54.  <https://doi.org/10.1080/17439884.2024.2435200>.

Risam, Roopika, et Alex Gil. « Introduction: The Questions of Minimal Computing ». *Digital Humanities Quarterly* 16, nᵒ 2 (2022). <https://www.proquest.com/docview/2681375031/citation/6C9B1134396C475DPQ/1>.

Schäferhoff, Nick. « WordPress Market Share, Statistics, and More ». Consulté le 19 janvier 2026. <https://wordpress.com/blog/2025/04/17/wordpress-market-share/>.

Simpkin, Sarah. « Getting Started with Markdown ». *Programming Historian*, 13 novembre 2015. <https://programminghistorian.org/en/lessons/getting-started-with-markdown>.

« Static Site Generators ». Consulté le 20 janvier 2026. <https://staticsitegenerators.net/>.

« Static Site Generators - Top Open Source SSGs, Jamstack ». Jamstack.org. Consulté le 20 janvier 2026. <https://jamstack.org/generators/>.

Taylor, Conrad. « Mais qu’est ce qu’ont bien pu nous apporter les systèmes WYSIWYG ? » *Cahiers GUTenberg*, nᵒ 27 (1997) : 5‑33. <https://www.numdam.org/item/CG_1997___27_5_0/>.

Tenen, Dennis, et Grant Wythoff. « Sustainable Authorship in Plain Text Using Pandoc and Markdown ». *Programming Historian*, 19 mars 2014. <https://programminghistorian.org/en/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown>.

Visconti, Amanda. « Building a Static Website with Jekyll and GitHub Pages ». *Programming Historian*, 18 avril 2016. <https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages>.

Visconti, Amanda, Brandon Walsh, et Scholars’ Lab Community. « Running a Collaborative Research Website and Blog with Jekyll and GitHub ». *Programming Historian*, 23 novembre 2020.
<https://programminghistorian.org/en/lessons/collaborative-blog-with-jekyll-github>.

« Welcome to CodeIgniter ». Consulté le 25 février 2026. <https://codeigniter.com/>.

Wikle, Olivia M., et Evan Peter Williamson. « Exploring Static Web in the Digital Humanities Classroom: The Learn-Static Initiative ». *IDEAH* 4, nᵒ 2 (14 mars 2024). <https://doi.org/10.21428/f1f23564.f88a989c>.

## Notes

[^1]: Ce chiffre, dont nous livrons ici une approximation, ne semble pas baisser depuis plusieurs années (Nick Schäferhoff. « WordPress Market Share, Statistics, and More »consulté le 19 janvier 2026. <https://wordpress.com/blog/2025/04/17/wordpress-market-share/>).

[^2]: (Conrad Taylor. « Mais qu’est ce qu’ont bien pu nous apporter les systèmes WYSIWYG ? », *Cahiers GUTenberg*, nᵒ 27 (1997) : 5‑33. <https://www.numdam.org/item/CG_1997___27_5_0/>).

[^3]: Nous plaçons dans cette catégorie le type de ressources que nous trouvons par exemple sur (« HTML5 UP » (HTML5 UP)consulté le 25 février 2026. <http://html5up.net/>) qui en présente une bonne liste. Mais aussi *CodeStitch* (« CodeStitch, High Quality HTML and CSS Only Component Library, No Frameworks, No Configurations »consulté le 25 février 2026.<https://codestitch.app/>), *Tailwind Plus* (« Official Tailwind UI Components & Templates - Tailwind Plus »consulté le 25 février 2026. <https://tailwindcss.com>) ou encore *CodeIgniter* (« Welcome to CodeIgniter »consulté le 25 février 2026. <https://codeigniter.com/>). Il s’agit toujours de modèles de pages produites selon un certain *template* fixe et local. 

[^4]: (Sarah Simpkin. « Getting Started with Markdown », *Programming Historian*, 13 novembre 2015. <https://programminghistorian.org/en/lessons/getting-started-with-markdown>), 
(James Baker. « Preserving Your Research Data », *Programming Historian*, 30 avril 2014. <https://programminghistorian.org/en/lessons/preserving-your-research-data>)

[^5]: Raymond Camden et Brian Rinaldi, *Working with Static Sites: Bringing the Power of Simplicity to Modern Sites* ("O’Reilly Media, Inc.", 2017). <https://books.google.com?id=3NFLDgAAQBAJ>. et (Raymond Camden et Brian Rinaldi, *The Jamstack Book: Beyond Static Sites with JavaScript, APIs, and Markup* (Simon and Schuster, 2022). <https://books.google.com?id=nZVsEAAAQBAJ>) notamment. Les exemples ne manquent pas cf. (« Static Site Generators »consulté le 20 janvier 2026. <https://staticsitegenerators.net/>), et (« Static Site Generators - Top
Open Source SSGs, Jamstack » (Jamstack.org)consulté le 20 janvier 2026. <https://jamstack.org/generators/>)…

[^6]: cf. (Chris Diaz. « Using Static Site Generators for Scholarly Publications and Open Educational Resources », *The Code4Lib Journal*, nᵒ 42 (8 novembre 2018).
<https://journal.code4lib.org/articles/13861?utm_campaign=the%20New%20Dynamic&utm_medium=email&utm_source=Revue%20newsletter>), (Amanda Visconti. « Building a Static Website with Jekyll and GitHub Pages », *Programming Historian*, 18 avril 2016. <https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages>), (Amanda Visconti, Brandon Walsh, et Scholars’ Lab Community. « Running a Collaborative Research Website and Blog with Jekyll and GitHub », *Programming Historian*, 23 novembre 2020. <https://programminghistorian.org/en/lessons/collaborative-blog-with-jekyll-github>), (Olivia M. Wikle et Evan Peter Williamson. « Exploring Static Web in the Digital Humanities Classroom: The Learn-Static Initiative », *IDEAH* 4, nᵒ 2 (14 mars 2024). https://doi.org/[10.21428/f1f23564.f88a989c](https://doi.org/10.21428/f1f23564.f88a989c)).

[^7]: « Créer votre blog » (fr.hypotheses.org)consulté le 25 février 2026. <https://fr.hypotheses.org/creer-et-gerer-votre-blog>.

[^8]: (Roopika Risam et Alex Gil. « Introduction: The Questions of Minimal Computing », *Digital Humanities Quarterly* 16, nᵒ 2 (2022). <https://www.proquest.com/docview/2681375031/citation/6C9B1134396C475DPQ/1>), (Roopika Risam et Lee Skallerup Bessette. « Introduction: Minimal Computing and EdTech », *Learning, Media and Technology* 49, nᵒ 5 (6 décembre 2024) : 747‑54. https://doi.org/[10.1080/17439884.2024.2435200](https://doi.org/10.1080/17439884.2024.2435200)) et (Dennis Tenen et Grant Wythoff. « Sustainable Authorship in Plain Text Using Pandoc and Markdown », *Programming Historian*, 19 mars 2014. <https://programminghistorian.org/en/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown>).

[^9]: (« Des Packages Npm Compromis Pour Diffuser Des Malwares - Le Monde Informatique »consulté le 20 janvier 2026. <https://www.lemondeinformatique.fr/actualites/lire-des-packages-npm-compromis-pour-diffuser-des-malwares-97524.html>), (Dang-Khoa Nguyen et al. « Taint-Based Code Slicing for LLMs-based Malicious NPM Package Detection », 10 janvier 2026. https://doi.org/[10.48550/arXiv.2512.12313](https://doi.org/10.48550/arXiv.2512.12313)), (Surya Rao Rayarao et Naga Donikena. « The Shai-Hulud NPM Supply Chain Attack: A Comprehensive Analysis of Self-Replicating Malware in the JavaScript Ecosystem »consulté le 20 janvier 2026. <https://www.authorea.com/doi/full/10.22541/au.175830854.42750868?commit=9bc3206ca741614366ba5db6e82b14eba325b6d0>) mais aussi  (Tero Parviainen. « Overcoming JavaScript Framework Fatigue », 15 juillet 2015. <https://teropa.info/blog/2015/07/15/overcoming-javascript-framework-fatigue.html>).

[^10]: Au sein de Stylo, l’unité documentaire est nommée *article*.
