---
title: "Introduction à l'interface en ligne de commande Bash et Zsh"
slug: intro-a-bash-et-zsh
original: intro-to-bash
layout: lesson
collection: lessons
date: 2014-09-20
translation_date: YYYY-MM-DD
authors:
- Ian Milligan
- James Baker
reviewers:
- M. H. Beals
- Allison Hegel
- Charlotte Tupman
editor:
- Adam Crymble
translator:
- Melvin Hersent
translation-editor:
- prénom nom
translation-reviewers:
- prénom nom
- prénom nom
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/568
difficulty: 1
activity: transforming
topics: [data-manipulation, get-ready]
abstract: Cette leçon vous apprendra comment entrer des commandes dans une interface en ligne de commande, plutôt qu'à travers une interface graphique. Les interfaces en ligne de commande présentent des avantages pour les utilisateurs qui ont besoin de plus de précision dans leur travail. Elles permettent plus de détails en lançant certains programmes, en permettant l'ajout d'argument pour spécifier exactement la façon dont vous voulez que votre programme tourne. De plus, elles peuvent facilement être automatisés en créant des scripts, qui sont au fond des recettes de commandes au format textuel.
avatar_alt: Soldats en armure antique avec des lances
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

De nombreuses leçons du *Programming Historian* vous demande d'entrer des commandes à travers une **Interface en ligne de commande**, aussi appelée Invite de commande ou CLI pour *Command-Line Interface*. Aujourd'hui, la façon classique pour un utilisateur d'interagir avec le système de son ordinateur se fait à travers une **Interface graphique**, ou GUI pour *Graphical-User Interface*, grâce à sa souris. Cela signifie que lorsque vous allez dans un répertoire (ou dossier) vous cliquez sur une image d'un dossier, lorsque vous lancez un programme vous double-cliquez dessus et lorsque vous naviguez sur internet vous interagissez avec les éléments de la page web. Néanmoins, avant la popularisation des interfaces graphiques à la fin des années 1980, la façon principale d'interagir avec un ordinateur était à travers une Interface en ligne de commande.

{% include figure.html filename="GUI.png" alt="Interface graphique de l'ordinateur de Ian Milligan" caption="Figure 1. GUI de l'ordinateur de Ian Milligan" %}

Les Interfaces en ligne de commande présentent des avantages pour les utilisateurs qui nécessitent plus de précision dans leur travail, tel que les chercheurs en humanités numériques. Elles permettent plus de détails en lançant certains programmes, car vous pouvez ajouter des modificateurs pour spécifier *exactement* comment vous voulez que le programme s'exécute. De plus, cela peut être facilement automatisé avec des [scripts](http://www.tldp.org/LDP/Bash-Beginners-Guide/html/chap_01.html), qui peuvent être vus comme une recette à suivre composée de commandes écrites en texte.

Il existe deux familles d'interfaces en ligne de commande : celle utilisée par les systèmes [Unix](https://fr.wikipedia.org/wiki/Unix) (Linux et macOS pour résumer) et celle utilisé par les systèmes Windows. Sur de nombreuses distributions Linux et jusqu'à macOS Mojave, le shell `bash`, ou 'Bourne-again shell' est utilisé par défaut. Depuis macOS Catalina, c'est le shell `zsh`, ou 'Z shell', très proche de bash qui est utilisé par défaut. Les commandes que nous utiliserons dans cette leçon seront les mêmes pour les deux.
Enfin, pour les utilisateurs de Windows, l'interface en ligne de commande est par défaut basé sur `MS-DOS`, qui utilise des commandes et une syntaxe différentes mais permet d'effectuer les même tâches. Ce tutoriel propose une introduction basique à `bash`/`zsh` et les utilisateurs Windows peuvent aussi le suivre en installant un shell bash, comme présenté un peu plus loin.

Cette leçon utilise un **[shell Unix](https://fr.wikipedia.org/wiki/Shell_Unix)**, qui est un interpréteur de commande procurant une interface utilisateur pour le système d'exploitation Unix et d'autres systèmes basés sur celui-ci. Cette leçon couvrira un nombre restreint de commandes basiques. À la fin de ce tutoriel vous serez capable de naviguer à travers votre système de fichier, d'ouvrir un fichier, d'effectuer des manipulations simples dessus tel que les copier, les lire, en combiner plusieurs ou de faire des éditions simples. Ces commandes constituent les bases permettant de construire d'autres commandes plus complexes pouvant s'adapter à vos données de recherches ou vos projets. Les lecteurs souhaitant un guide de référence plus complet que cette leçon peuvent lire l'ouvrage (en anglais) de Deborah S. Ray et Eric J. Ray, *Unix and Linux: Visual Quickstart Guide*, 5th édition (2014).

## Windows: Installation d'un shell

Pour les utilisateurs Windows une étape en plus est nécessaire, car vous devrez installer un shell bash.
Vous avez plusieurs outils à votre disposition, mais la méthode recommandée est d'installer le **Sous-système Windows pour Linux** (WSL), disponible depuis Windows 10.
Vous trouverez un tutoriel détaillé sur le [site de Microsoft](https://learn.microsoft.com/fr-fr/windows/wsl/install).
En cas de version Windows plus ancienne ou si vous préférez ne pas installer une distribution Linux complète, vous avez deux autre choix :
vous pouvez installer Git Bash en téléchargeant la dernière version sur [cette page](https://git-for-windows.github.io/) et en suivant les instructions ici sur [Open Hatch](https://web.archive.org/web/20190114082523/https://openhatch.org/missions/windows-setup/install-git-bash).
Enfin, vous pouvez choisir d'installer [Cygwin](https://www.cygwin.com/).

## Ouvrir notre shell

Maintenant que nous avons installé notre shell, démarrons le.

Pour **Windows**, lancez votre distribution Linux (Ubuntu par défaut) installé via WSL, vous arriverez automatiquement sur un terminal. Si vous avez choisi d'installer Git Bash ou cygwin, démarrez cette application.

{% include figure.html filename="tr-fr-WSL_Ubuntu.png" alt="Icônes des programmes Sous-système Windows pour Linux et Ubuntu sous Windows 10" caption="Figure 2. Les programmes WSL et Ubuntu sous Windows 10" %}

Sous **Mac OS**, par défaut le terminal se trouve ici :

`Applications -> Utilitaires -> Terminal`

{% include figure.html filename="Terminal.png" alt="Icône du programme Terminal.app sur OS X" caption="Figure 3. Le programme Terminal.app sur OS X" %}

Sous **Linux**, vous pouvez utiliser le raccourci "Ctrl + alt + T" pour ouvrir le terminal ou vous pouvez simplement rechercher "terminal" dans vos applications.

Une fois lancé, vous verrez cette fenêtre :

{% include figure.html filename="Blank-Terminal.png" alt="Un terminal ouvert sur un bureau OS X" caption="Figure 4. Un écran de terminal vide sur notre bureau OS X" %}

Vous pourriez avoir envie de changer l'apparence par défaut de votre terminal, car du texte noir sur un fond blanc peut être vite fatiguant pour les yeux. Dans l'application OS X par défaut, cliquez sur l'onglet 'Paramètres' et changez le schéma de couleur. Nous préférons personnellement quelque chose avec moins de contraste entre le fond et le texte, car nous regarderons beaucoup le terminal. Les palettes de couleurs 'Novel' et [Solarisée](http://ethanschoonover.com/solarized) sont plus reposantes. Pour les utilisateurs Windows, un effet similaire peut être obtenu dans Git Bash avec l'onglet `Propriétés` : cliquez n'importe où sur la bar du haut et vous pourrez sélectionner `Propriétés`.

{% include figure.html filename="Settings.png" alt="L'écran des paramètres du terminal sur OS X" caption="Figure 5. L'écran des paramètres de notre terminal sur OS X" %}

Une fois que vous êtes satisfait avec l'interface, nous pouvons démarrer.

## Se déplacer dans le système de fichiers de votre ordinateur

Si vous êtes incertain d'où vous vous trouvez dans le système de fichier de votre ordinateur la première étape est d'obtenir cette information. Vous pouvez trouver dans quel dossier vous vous trouver grâce à la commande `pwd`, qui est la contraction de "print working directory". Tapez

```bash
pwd
```

et pressez la touche "entrée". Si vous êtes sur Mac ou Linux, votre ordinateur affichera sûrement `/users/USERNAME` avec votre propre nom d'utilisateur à la place de `USERNAME`. Par exemple, le chemin pour Ian sur Ubuntu est `/users/ianmilligan1/`.

Ici vous pouvez voir qu'il y a de légères différences en fonction de votre système d'exploitation. Sur Windows, l'utilisateur James est à:

`c/users/jbaker`

Il y a des différences mineures, mais ne vous inquiétez pas; une fois que vous vous déplacerez et que vous manipulerez des fichiers, ces différences s'effaceront.

Pour nous orienter, affichons une liste des fichiers présent dans notre dossier. Entrez la commande

```bash
ls
```

et vous verrez alors une liste de tous les fichiers et dossiers présents à votre position. Votre dossier peut être encombré ou vide, mais vous verrez à minima quelques endroits familiers. Sur Os X, par exemple, vous verrez `Applications`, `Desktop`, `Documents`, `Downloads`, `Library`, `Pictures`, etc.

Si vous désirez obtenir plus d'informations que simplement une liste de fichiers, vous pouvez spécifier différents arguments, ou *flags*, à ajouter à nos commandes basiques.
Ces arguments sont des additions à notre commande pour fournir à l'ordinateur des précisions sur la façon d'exécuter la commande. Cela permet de modifier par exemple le format de sortie de notre commande ou bien la façon de manipuler nos données.
Pour obtenir une liste de ces arguments, les utilisateurs OS X/Linux peuvent utiliser la commande présente par défaut `man` (pour *manual*). Ainsi, ces derniers peuvent taper

```bash
man ls
```

{% include figure.html filename="man-ls.png" alt="La page de manuel sur le terminal pour la commande ls" caption="Figure 6. La page du Manuel pour la commande LS" %}

Ici vous pouvez voir une liste avec le nom de la commande et les différents arguments que vous pouvez utiliser, accompagnés de la description de leurs effets. **Pour le moment, beaucoup de ces informations ne vous seront pas compréhensible, mais ne vous inquiétez pas vous deviendrez plus familier avec ces commandes au fil du temps.** Vous pouvez explorer cette page de plusieurs façon: la barre d'espacement permet de déplacer la page vers le bas ou vous pouvez utiliser les flèches haut et bas.

Pour quitter la page du manuel, pressez

`q`

et vous retournerez à l'interface en ligne de commande où vous étiez avant d'entrer dans la page du manuel.

Vous pouvez essayer la commande `man` pour la commande que nous avons vu précédemment, `pwd`, ainsi que pour celles que nous verrons après. Vous pouvez même taper `man man`.

Les utilisateurs Windows peuvent utiliser la commande `help` à la place de `man`, même si cette commande présente moins de fonctionnalités que son équivalent sur OS X/Linux. Essayez `help` pour voir l'aide disponible, et `help pwd` pour un exemple de sortie de la commande.

Essayons quelques-unes des options que nous avons vu sur la page `man` pour ls. Peut être souhaitez vous voir uniquement les fichiers TXT présents dans votre dossier d'accueil. Tapez

```bash
ls *.txt
```

Cette commande retourne une liste de fichiers texte si vous en avez dans votre dossier d'accueil. La commande \* est un **métacaractère** (**wildcard** ou **joker** en anglais) - il signifie zéro, un ou plusieurs caractères quelconques. Donc dans notre cas vous indiquez que tout ce qui correspond au modèle

`anything.txt`

sera affiché.
Essayons différentes combinaisons. Si par exemple vous avez différents fichiers `1-Canadian.txt`, `2-Canadian.txt` et ainsi de suite, la commande `ls *-Canadian.txt` affichera ces fichiers tout en excluant les autres ne respectant pas ce modèle.

Imaginons que vous vouliez plus d'informations. Sur la page `man`, vous avez vu une option qui peut être utile:

>     -l      use a long listing format

Donc si vous entrez

```bash
ls -l
```

l'ordinateur retournera une "liste longue" des fichiers contenant les informations similaires que vous trouveriez dans votre *explorateur* de fichier : la taille des fichiers en bits, sa date de création ou de dernière modification et le nom du fichier. La taille exprimée en bits peut être déroutante, prenons pour exemple un fichier "test.html" mesurant '6020' bits. Nous avons plutôt l'habitude de parler en octet (ou bytes), kilooctet, mégaoctet, gigaoctet, etc.

Heureusement, il y existe un autre argument:

>     -h      Utilisé avec l'option -l, exprime la taille du fichier en: octet, kilooctet,
>             mégaoctet, gigaoctet, téraoctet and pétaoctet afin de réduire le nombre
>             de chiffres à trois ou mois en utilisant la base 2.

Quand vous souhaitez utiliser deux arguments, vous pouvez simplement les exécuter ensemble. Ainsi en tapant

```bash
ls -lh
```

vous recevrez un affichage dans un format lisible par un humain; vous apprendrez ainsi que 6020 bits est équivalent à 5.9Ko (ou KB), qu'un autre fichier mesure 1Mo et ainsi de suite.

Ces arguments sont *très* importants. Vous les rencontrerez dans d'autres leçon au sein de *the Programming Historian*, comme [Wget](https://programminghistorian.org/en/lessons/applied-archival-downloading-with-wget), [MALLET](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet), et [Pandoc](https://programminghistorian.org/fr/lecons/redaction-durable-avec-pandoc-et-markdown), qui utilisent tous la même syntaxe. Heureusement, vous n'avez pas besoin de mémoriser celle-ci. Vous pouvez conserver ces leçons à portée de main afin de pouvoir y jeter un oeil si vous désirez. Ces leçons peuvent être suivies dans le sens que vous désirez.

Nous avons passé un bon moment dans notre dossier d'accueil, il est temps de nous déplacer. Vous pouvez faire cela avec la commande `cd`(pour Change Directory)

Si vous entrez

`cd desktop`

vous serez désormais sur votre bureau. Ceci est semblable au fait de 'double-cliquer' sur le dossier 'bureau' au sein de votre explorateur de fichier. Pour vérifier, tapez `pwd` et vous devriez voir s'afficher quelque chose comme:

`/Users/ianmilligan1/desktop`

Essayez les commandes que vous venez d'apprendre: explorez votre dossier courant en utilisant la commande `ls`.

Si vous voulez revenir en arrière, vous pouvez taper

```bash
`cd ..`
```

ou bien, avec le shell zsh, simplement

```zsh
..
```

Cela nous déplace "en haut" d'un dossier, nous faisant revenir à `/Users/ianmilligan1/`. Si vous êtes complètement perdu, vous pouvez taper

```bash
cd
```

et vous retournerez au dossier d'accueil, là où vous aviez démarré.

Essayer d'explorer: visitez vos bibliothèques, vos images, vos dossiers présents sur votre ordinateur. Habituez vous à vous déplacer dans les dossiers et à en sortir. Imaginez que vous naviguez au travers d'une [arborescence](https://fr.wikipedia.org/wiki/Arborescence). Si vous êtes sur votre bureau, vous ne pourrez pas vous déplacer vers vos documents avec `cd documents`, car il est un 'enfant' de votre dossier d'accueil et donc un 'adelphe' de votre dossier Documents. Pour aller vers un dossier 'adelphe', vous devez retourner au parent commun. Pour faire cela vous avez besoin de revenir à votre dossier d'accueil avec `cd ..` et ensuite aller vers le dossier voulu avec `cd documents`.

Être capable de naviguer à travers votre système de fichier en utilisant un shell (bash ou zsh) est important pour beaucoup de leçons dans le *Programming Historian*. Avec l'habitude, vous naviguerez directement au dossier qui vous intéresse. Dans notre cas, depuis n'importe quel endroit, vous pouvez taper :

`cd /users/ianmilligan1/mallet-2.0.7`

ou, sur Windows, quelque chose comme

`cd c:\mallet-2.0.7\`

et vous serez amené directement à votre dossier MALLET pour des leçons de [topic modeling](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet).

Enfin, testez

`open .`

sous OS X ou

`explorer .`

dans Windows. Cette commande ouvrira votre GUI dans le dossier courant. Faites attention de bien laisser un espace entre votre commande (`open` ou `explorer`) et le point, qui sert à signifier 'à cet endroit'.

## Interagir avec des fichiers

De la même façon que vous pouvez naviguer entre les répertoires, vous pouvez interagir avec les fichiers depuis l'interface en ligne de commande: vous pouvez les lire, les ouvrir, les exécuter ou même les éditer, souvent sans même avoir besoin de quitter l'interface. La principale raison d'utiliser l'interface de cette façon est de pouvoir travailler sans avoir à utiliser la souris et, même si la courbe d'apprentissage est raide, cela peux même devenir le seul lieu d'écriture. De plus, beaucoup de programmes requièrent de passer par l'interface en ligne de commande pour les utiliser. Ainsi, comme vous utiliserez des programmes en ligne de commande, il est souvent plus rapide d'effectuer des modifications mineures sans changer de programme. Pour quelques-uns de ces arguments, vous pouvez voir Jon Beltran de Heredia's ["Why, oh WHY, do those #?@! nutheads use vi?"](http://www.viemu.com/a-why-vi-vim.html).

Nous allons désormais voir quelques façons simples d'interagir avec des fichiers.

Premièrement, vous pouvez créer un nouveau répertoire avant d'y créer des fichiers textes. Pour des raisons de simplicité, nous allons le créer sur notre bureau. Naviguez vers votre bureau en utilisant votre shell, et tapez:

```bash
mkdir ProgHist-Text
```

Cette commande (`make directory`) crée ici un répertoire nommé 'ProgHist-Text.'

De manière général, il est préférable d'éviter les espaces dans les noms de fichiers et de répertoires lorsque l'on utilise l'interface en ligne de commande (ce n'est bien sûr pas impossible, c'est juste plus simple). Vous pouvez regarder votre bureau pour vérifier que la commande à bien fonctionné. Maintenant, déplacez vous dans ce répertoire, avec la commande `cd`.

C'est le moment de vous donner un conseil qui vous ferra gagner du temps : il existe une fonction d'auto-complétion dans votre shell et voici comment l'utiliser : Retournez sur votre bureau si vous vous êtes déjà déplacé dans votre nouveau dossier (`cd ..`). Pour vous déplacer dans le répertoire `ProgHist-Text` vous pouvez taper `cd ProgHist-Text` en entier ou alors, pour utiliser l'auto-complétion, tapez `cd Prog` et ensuite pressez la touche "tabulation". Vous remarquerez que l'interface complète la ligne en `cd ProgHist-Text`. **Enfoncez la touche tabulation à n'importe quel moment dans le shell lui demandera de tenter d'autocompléter la ligne, basé sur les répertoires et fichiers présent dans le répertoire courant. En fonction de votre shell (bash notamment) cette fonction est sensible à la casse, ainsi dans notre exemple précédent `cd prog` ne se complétera pas automatiquement en `ProgHist-Text`. Lorsque deux possibilités ou plus existent (exemple : `ProgHist-Text` et `ProgHist-Picture`) l'autocomplétion s'arrêtera à la première différence rencontrée (ici `ProgHist-`). Nous vous encourageons à utiliser cette méthode tout au long de cette leçon pour voir comment elle se comporte.**

Vous aurez alors un fichier nommé "test" avec l'extension ".txt".
**Sous Windows, ces extensions sont invisible par défaut. Si vous souhaitez manipuler des fichiers sous Windows, nous vous recommandons d'activer l'affichage des extensions de fichier. Pour faire cela, ouvrez votre explorateur de fichiers et dans l'onglet Affichage, cochez la case**
*a finir cf [ce site](https://www.papergeek.fr/windows-10-comment-afficher-masquer-extensions-fichiers-19268)*

Nous avons désormais besoin d'un fichier texte pour nos futurs commandes. Nous pouvons utiliser un livre connu pour sa longueur, l'épique *Guerre et Paix* de Léon Tolstoy. Le fichier est disponible, en anglais, via le [Projet Gutenberg](http://www.gutenberg.org/ebooks/2600). Si vous avez déjà installé [wget](https://programminghistorian.org/en/lessons/applied-archival-downloading-with-wget), vous pouvez juste taper

```bash
wget http://www.gutenberg.org/files/2600/2600-0.txt
```

Si ce n'est pas le cas, vous pouvez télécharger le texte directement depuis votre navigateur grâce au lien précédent. Une fois sur la page, faites un clic droit pour utilisez la commande 'Enregistrer sous...' et sauvegardez le fichier dans votre dossier récemment créé. Désormais, lorsque vous tapez

```bash
ls -lh
```

vous voyez

> -rw-r--r--+ 1 ianmilligan1  staff   3.1M  1 May 10:03 2600-0.txt

'2600-0.txt' étant ici le fichier que vous avez téléchargé, il peut donc être différent.
Vous pouvez lire le texte contenu dans le fichier de différentes manières. Premièrement vous pouvez dire à votre ordinateur que vous voulez le lire en utilisant le programme standard que vous utilisez pour ouvrir des fichiers textes. Par défaut, cela peut être TextEdit sur Mac ou Notepad sur Windows. Pour ouvrir un fichier de cette façon, tapez

```bash
open 2600-0.txt
```

sur OS X et Linux, ou

```bash
explorer 2600-0.txt
```

sous Windows.

Cela sélectionne le programme par défaut pour ouvrir ce type de fichier et ouvre le fichier demandé.

Néanmoins, vous voudrez la plupart du temps travaillez dans votre interface en ligne de commande sans la quitter. Vous pouvez aussi lire les fichiers au sein de cet environnement. Pour faire cela, nous allons utiliser la commande 'concatenate' en tapant:

```bash
cat 2600-0.txt
```

La fenêtre du terminal va alors affichez l'intégralité du contenu de votre fichier. En théorie c'est intéressant, mais ici vous ne pouvez pas faire grand chose du résultat obtenu à cause de la quantité de texte. Vous pouvez avoir envie de juste regarder le début ou la fin de votre fichier.

La commande

```bash
head 2600-0.txt
```

vous fourni les dix premières lignes, tandis que

```bash
tail 2600-0.txt
```

procure une vue des dix dernières. C'est une bonne façon de rapidement déterminer le contenu de votre fichier. Vous pouvez ajouter un paramètre à votre commande pour modifier le nombre de lignes affichées: `head -20 2600-0.txt` par exemple affichera les vingt premières lignes.

Vous pourriez aussi avoir envie de changer le nom de votre fichier en quelque chose de plus descriptif. Vous pouvez le 'déplacer' ('*move*') à un nouveau nom en tapant

```bash
mv 2600-0.txt tolstoy.txt
```

Après, en effectuant la commande `ls`, vous verrez que votre fichier s'appelle bien `tolstoy.txt`. Si vous souhaitez le dupliquer, vous pouvez utilisez la commande 'copy' en tapant

```bash
cp 2600-0.txt tolstoy.txt
```

Nous reverrons ces commandes peu après.

Maintenant que vous avez utilisé quelques nouvelles commandes, il est temps pour une nouvelle astuce. Enfoncez la flèche du haut de votre clavier. Notez que la dernière commande réalisée apparaît devant votre curseur. Vous pouvez continuer à utiliser la flèche du haut pour remonter dans l'historique de vos commandes précédentes. La flèche du bas vous ramène à vos commandes plus récentes.

Après avoir lu et renommé quelques fichiers, vous pourriez avoir envie de joindre leur texte en un seul fichier. Pour combiner (ou concaténer) deux fichiers ou plus vous pouvez utiliser la commande `cat`. Commençons par copier le fichier Tolstoy si ce n'est pas déjà fait ( `cp tolstoy.txt tolstoy2.txt`). Maintenant que nous avons deux copies de *War and Peace*, assemblons les pour créer un livre **encore plus long**.

Tapez

```bash
cat tolstoy.txt tolstoy2.txt
```

et pressez entrée. Cela imprimera, ou affichera, la combinaison des fichiers dans votre shell. Néanmoins, le résultat est trop long pour être lu dans votre fenêtre. Heureusement, en utilisant la commande `>`, vous pouvez envoyer le résultat dans un nouveau fichier plutôt que dans votre terminal. Tapez

```bash
cat tolstoy.txt tolstoy2.txt > tolstoy-twice.txt .
```

Maintenant, lorsque vous tapez `ls` vous verrez `tolstoy-twice.txt` apparaître dans votre répertoire.

Lorsque vous combinez plus de deux fichiers, utiliser un métacaractère peut éviter d'écrire le nom de chaque fichier. Comme nous avons vu avant, le symbole `*` représente zéro ou plus caractère quelconque. Ainsi, si vous tapez

```bash
cat *.txt > everything-together.txt`
```

et pressez entrée, une combinaison par ordre alphabétique de tous les fichiers .txt présent dans le répertoire courant sera enregistré dans le fichier `everything-together.txt`. Cela peut être très utile si vous souhaitez concaténer un grand nombre de fichiers présent dans un répertoire afin de travailler avec eux dans un programme d'analyse de texte. Un autre métacaractère intéressant est le symbole `?` qui permet de substituer un caractère ou un chiffre. Ainsi la commande

```bash
cat tolstoy?.txt`
```

afficherai le texte de notre fichier 'tolstoy2.txt'.

## Éditer des fichiers texte directement en ligne de commande

Si vous souhaitez lire un fichier dans son intégralité sans quitter le terminal, vous pouvez lancer [vim](https://fr.wikipedia.org/wiki/Vim). Vim est un éditeur de texte très puissant, parfait pour l'utiliser avec des programmes tels que [Pandoc](http://johnmacfarlane.net/pandoc/) pour faire de l'édition de texte ou pour éditer votre code sans avoir besoin de passer par un autre programme. Il est inclu par défaut sur la plupart des distributions Linux, mac OS et Windows. Vim possède une courbe d'apprentissage assez raide, nous nous limiterons donc à quelques fonctionnalités de base.

Tapez

```bash
vim tolstoy.txt`
```

Vous devriez voir vim se lancer, un éditeur de texte en ligne de commande.

{% include figure.html filename="vim.png" alt="l'éditeur de texte en ligne de commande Vim" caption="Figure 7. Vim" %}

Si vous souhaitez vous lancer dans l'apprentissage de Vim, il existe un [bon guide (en anglais)](http://vimdoc.sourceforge.net/htmldoc/quickref.html) disponible.

Utiliser Vim pour lire des fichiers est relativement simple. Vous pouvez utiliser les flèches du clavier pour naviguer dans votre fichier et vous pourriez théoriquement lire *Guerre et Paix* de cette façon, bien que ce ne soit pas particulièrement agréable.

Voici quelques commandes basiques pour naviguer dans votre fichier:

`Ctrl+F` (En maintenant la touche 'control' et en pressant la lettre F) vous déplacera d'une page vers le bas (`Shift+UpArrow` pour Windows).

`Ctrl+B` vous déplacera d'une page vers le haut. (`Shift+DownArrow` pour les utilisateurs Windows).

Si vous voulez vous déplacer rapidement à la fin d'une ligne, vous pouvez presser `$` et pour vous déplacer au début d'une ligne pressez `0`. Vous pouvez aussi vous déplacer entre les phrases en tapant `)` (en avant) ou `(` (en arrière). Pour les paragraphes, tapez `}` et `{`. Puisque vous êtes en train de faire tout avec votre clavier, plutôt que de maintenir votre flèche du bas pour vous déplacer dans votre document, cela vous laisse vous déplacer rapidement en avant ou en arrière.

Retournons au début de notre document et effectuons une modification mineure, comme ajouter un champ `Reader` dans l'en-tête. Déplacez votre curseur entre **Author** et **Translators**, tel que présenté ici:

{% include figure.html filename="about-to-insert.png" alt="Notre fichier tolstoy.txt ouvert dans Vim, avant d'y insérer du texte" caption="Figure 8. Sur le point de faire une insertion" %}

Si vous essayez d'écrire, vous aurez un message d'erreur ou le curseur commencera à se déplacer. C'est parce que vous devez spécifier que vous souhaitez éditer. Pressez la lettre

`a` ou `i`

En bas de l'écran vous verrez

`-- INSERT --`

Cela signifie que vous êtes en mode insertion. Vous pouvez désormais écrire et éditer le texte comme si vous étiez dans un éditeur de texte standard. Pressez `Entrée` deux fois, ensuite `flèche du haut`, et tapez

`Reader: A Programming Historian`

Lorsque vous avez terminé, pressez `Échap` pour retourner en mode lecture.

Pour quitter Vim ou sauvegarder, vous devez entrer une suite de commandes. Pressez `:` et vous lancerez *l'invite de commande* de Vim. Si vous souhaitez sauvegarder le fichier tapez `w` pour 'écrire' ('write') le fichier, puis tapez `Entrée` pour exécuter cette commande. Vous verrez alors

> "tolstoy.txt" [dos] 65009L, 3291681C written

{% include figure.html filename="after-writing.png" alt="Notre fichier tolstoy.txt ouvert dans Vim, après avoir inséré du texte" caption="Figure 9. Après avoir écrit sur notre fichier" %}

Si vous souhaitez quitter, pressez `:` à nouveau, puis `q` (pour `quit`). Vous retournerez alors à l'interface en ligne de commande. Comme en bash, vous auriez pu ici combiner les deux commandes. Ainsi, presser `:` puis taper `wq` aurait écrit le fichier puis quitté Vim. Si vous aviez voulu quitter **sans** sauvegarder, la commande `q!` vous aurait permis de faire cela en ignorant les modifications effectuées, qui auraient alors été perdues.

Vim est sûrement différent de ce que vous avez l'habitude d'utiliser et vous demandera plus de pratique pour vous y habituer. Mais si vous voulez effectuer de petites modifications dans vos fichiers, c'est un bon point de départ. En devenant plus à l'aise, vous pourriez même finir par écrire des articles avec, en profitant [des notes de bas de page et du formatage proposé par Pandoc et Markdown](https://programminghistorian.org/fr/lecons/redaction-durable-avec-pandoc-et-markdown).

## Déplacement, copie et suppression de fichiers

Disons que vous en avez terminé avec ce repértoire et que vous souhaitez déplacer `tolstoy.txt` ailleurs. Premièrement, vous devriez créer une sauvegarde. Le shell ne pardonne pas les erreurs et sauvegarder est encore plus important qu'avec les GUI. Si vous supprimez quelque chose ici il n'y a pas de corbeille pour repécher vos fichiers. Pour créer une backup, vous pouvez taper

```bash
cp tolstoy.txt tolstoy-backup.txt
```

Désormais, lorsque vous lancer la commande `ls` vous verrez plusieurs fichiers dont au moins deux sont identiques: `tolstoy.txt` et `tolstoy-backup.txt`.

Déplaçons le premier ailleurs. Pour l'exercice, créons un deuxième répertoire sur votre bureau. Déplacez vous sur votre bureau (`cd ..`) et créez (`mkdir`) un autre répertoire. Nommons le `proghist-dest`.

Pour copier `tolstoy.txt` vous avez différentes options. Vous pouvez lancer ces commandes depuis n'importe où dans le shell ou vous pouvez vous trouver dans le repértoire d'origine ou de destination. Pour l'exercice, lançons la commande depuis le répertoire courant. Le format basique pour la commande 'copy' est `cp [source] [destination]`. Ce qui signifie que vous tapez d'abord `cp`, puis vous entrez le ou les fichiers que vous souhaitez copier suivi de l'emplacement où ils devront aller.

Dans notre cas, la commande

```bash
cp /users/ianmilligan1/desktop/proghist-text/tolstoy.txt /users/ianmilligan1/desktop/proghist-dest/
```

copiera Tolstoy depuis le premier répertoire dans le second. Vous aurez à insérer votre propre nom d'utilisateur à la place de 'ianmilligan1'.
Cela signifie que vous avez désormais trois copie de l'ouvrage sur votre ordinateur. L'original, la sauvegarde et la nouvelle copie dans le deuxième répertoire. Nous aurions pu choisir de **déplacer** ('move') le fichier, donc de ne pas laisser de copie dans le fichier source, en remplaçant la commande `cp` par `mv`; mais ne testons pas cela tout de suite.

Vous pouvez aussi copier plusieurs fichiers en une seule commande. Si vous souhaitiez copier le fichier original et sa sauvegarde, vous pouvez utiliser un *métacaractère*.

```bash
cp /users/ianmilligan1/desktop/proghist-text/*.txt /users/ianmilligan1/desktop/proghist-dest/
```

Cette commande copie **tous** les fichiers textes depuis le répertoire d'origine vers répertoire de destination.

Note: Si vous vous trouvez dans le répertoire depuis ou vers lequel vous déplacer des fichiers, vous n'avez pas besoin d'écrire tout le chemin du répertoire. Faisons deux exemples rapides. Déplacez vous dans le répertoire `proghist-text`. Depuis cet emplacement, si vous souhaitez copier vos fichiers vers `proghist-dest`, cette commande fonctionnera:

```bash
cp *.txt /users/ianmilligan1/desktop/proghist-dest/
```

De la même façon, si vous êtes dans le répertoire `proghist-dest`, la même commande s'écrit:

```bash
cp /users/ianmilligan1/desktop/proghist-text/*.txt ./
```

La commande `./` ou `.` représente le **répertoire courant** dans lequel vous vous trouvez. **C'est une commande très importante**.

Enfin, si vous souhaitez effacer un fichier, vous devrez utiliser la commande `rm` ('remove'). **Soyez très prudent avec la commande `rm`** afin de ne pas supprimer des fichiers par erreur. Contrairement à la suppression en passant par le GUI, **il n'y a pas de corbeille ou de retour en arrière possible**. Pour ces raisons, si vous avez un doute soyez très prudent ou effectuez une sauvegarde régulière de vos données. Ces conseils sont d'autant plus valable si vous utilisez des métacaractères pour supprimer plusieurs fichiers d'un coup.

Déplacez vous dans `proghist-text` et supprimez le fichier original en tapant

```bash
rm tolstoy.txt
```

Vérifiez que le fichier n'est plus là avec la commande `ls`.

Si vous souhaitez supprimer un répertoire entier, vous avez deux options. Vous pouvez utiliser `rmdir`, l'opposé de `mkdir`, pour supprimer un répertoire **vide**. Pour supprimer un répertoire avec des fichiers, vous pouvez utiliser depuis le bureau:

```bash
rm -r proghist-text
```

## Conclusion

Arrivé à ce point vous avez sans doute envie de prendre une pause et de fermer votre terminal. Pour faire cela taper

```bash
exit
```

Il existe de nombreuses autre commandes à essayer lorsque vous serez plus à l'aise avec l'interface en ligne de commande. Une commande très utilie est `du`, qui permet de connaître combien de mémoire est utilisé (`du -h` affiche la mémoire d'une façon lisible par l'humain). Pour ceux sur Linux ou mac OS, `top` procure un aperçu des processus en cours (`mem` sous Windows) et `touch FILENAME` permet de créer un fichier texte basique sur tous les systèmes.

Nous espérons qu'arrivé ici vous aurez une bonne compréhension des fonctionnalités de base de l'interface en ligne de commande : vous déplacer à travers les répertoires, déplacer, copier et supprimer des fichiers ou répertoires, ainsi qu'effectuer de petites modifications dans les fichiers. Cette leçon destinée aux débutants avait pour but de vous faire découvrir les bases et de vous faire gagner en confiance dans l'utilisation du terminal. À l'avenir, vous pourriez avoir envie de vous mettre à écrire des scripts.

Amusez vous et expérimentez ! Avant même de vous en rendre compte, vous pourriez vous retrouver à apprécier la commodité et la précision de l'interface en ligne de commande - pour certains usages, en tout cas - beaucoup plus léger que le GUI fournit avec votre système. Votre boîte à outils vient de s'aggrandir.

## Guide de référence

Pour qu'il soit plus facile de retrouver les commandes vu durant la leçon, voici un tableau récapitulatif:

| Commande              | Ce qu'elle fait                                                                                                                      |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `pwd`                | Imprime le répertoire courant ('present working directory') pour vous permettre de savoir où vous êtes                                                           |
| `ls`                 | Liste les fichiers présents dans le répertoire courant                                                                                          |
| `man *`              | Affiche le manuel pour une commande nommée `*`                                            |
| `cd *`               | Change le répertoire courrant pour `*`                                                                                              |
| `mkdir *`            | Créé un répertoire nommé `*`                                                                                                       |
| `open *` or `explorer *` | Ouvre un fichier nommé `*` (`open` pour Linux ou Mac et `explorer` pour Windows)      |
| `cat *`              | `cat` est une commande versatile : elle lira un fichier si vous substituez `*` par un fichier, mais peut aussi être utilisé pour combiner plusieurs fichiers |
| `head *`             | Affiche les dix premières ligne de `*`                                                                                               |
| `tail *`             | Affiche les dix dernières ligne de `*`                                                                                                |
| `mv`                 | Déplace un fichier ou un répertoire                                                                                                                      |
| `cp`                 | Copie un fichier ou un répertoire                                                                                                                     |
| `rm`                 | Supprime un fichier                                                                                                                    |
| `vim`                | Ouvre l'éditeur de document `vim`  
