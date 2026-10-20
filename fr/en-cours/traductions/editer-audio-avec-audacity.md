---
title: "Éditer des fichiers audio avec Audacity"
slug: editer-audio-avec-audacity
original: editing-audio-with-audacity
layout: lesson
collection: lessons
date: 2016-08-05
translation_date: YYYY-MM-DD
authors:
- Brandon Walsh
reviewers:
- Joanna Swafford
- Celeste Tường Vy Sharpe
editors:
- Jeri Wieringa
translator:
- Alexandre Wauthier
translation-editor:
- Forename Surname
translation-reviewer:
- Forename Surname
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/730
difficulty: 1
activity: transforming
topics: [data-manipulation]
abstract: Dans cette leçon, vous apprendrez à utiliser Audacity pour charger, enregistrer, éditer, mixer et exporter des fichiers audio.
avatar_alt: Deux gramophones placés l'un en face de l'autre
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Objectifs de la leçon

Pour celles et ceux qui s’intéressent à l’audio, avoir des compétences fondamentales en édition sonore peut s'avérer très utile. Savoir manipuler des fichiers de ce type permet de maîtriser votre objet d’étude : vous pouvez zoomer et extraire des extraits précis pour les analyser, traiter l’audio et mettre en ligne les fichiers sur un serveur pour compléter un article de blog sur le sujet. D'un point de vue plus pratique, ces compétences permettent également d’enregistrer et de diffuser des enregistrements produits par vous-même ou par d’autres personnes. Une conférence invitée organisée dans votre département universitaire ? Enregistrez-la et éditez-la vous-même ! Il s'agit d'une méthode simple pour partager des ressources entre différentes institutions, ce qui permet également de rendre les contenus plus accessibles pour un lectorat ou un audioire aux besoins variés.

Dans cette leçon, vous apprendrez à utiliser [*Audacity*](https://www.audacityteam.org/) pour charger, enregistrer, éditer, ==mixer== et exporter des fichiers audio. Les logiciels d’édition sonore sont souvent coûteux et proposent des fonctionnalités avancées qui peuvent intimider les débutants, mais *Audacity* est une alternative gratuite et open source, offrant des outils puissants avec une prise en main facile.

Pour cette leçon, nous travaillerons avec deux fichiers audio : un enregistrement des [*Variations Goldberg* de Jean-Sébastien Bach](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/editing-audio-with-audacity/bach-goldberg-variations.mp3) et un enregistrement de votre propre voix, que vous réaliserez durant cette leçon.

Ce tutoriel utilise *Audacity* 3.7.9, sorti en septembre 2026. ==De manière concomitante, une [version 4.0](https://github.com/audacity/audacity/releases) a également vu le jour.==

## Travailler avec Audacity

Commencez par télécharger les fichiers nécessaires.

Vous aurez besoin du [fichier MP3 des Variations Goldberg de Bach](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/editing-audio-with-audacity/bach-goldberg-variations.mp3). Pour le télécharger, faites un clic droit [ici](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/editing-audio-with-audacity/bach-goldberg-variations.mp3) et sélectionnez « Enregistrer la cible du lien sous » pour télécharger le fichier MP3 sur votre ordinateur.

Ensuite, téléchargez et installez *Audacity*, disponible sur [le site du projet](http://audacityteam.org/) ==, ou bien sur le [dépôt GitHub](https://github.com/audacity/audacity/releases)==. Le logiciel est compatible avec Mac OSX, Windows et Linux.

Téléchargez le programme et double-cliquez pour l’installer.

Pour commencer, ouvrez l’enregistrement de Bach que vous venez de télécharger en utilisant le menu « Fichier », puis « Ouvrir... » d’*Audacity*.

L’interface affichera alors les données chargées :

{% include figure.html filename="fr-tr-editer-audio-avec-audacity-01.png" alt="Visual description of figure image" caption="Figure 1. Forme d’onde de Bach dans *Audacity*" %}

*Audacity* convertit votre son sous la forme d’une onde, un mode de représentation répandu pour l’audio. L’axe horizontal - x, en abscisse - représente le temps en secondes (ou en minutes et secondes, selon la durée de l’extrait). Le début du son se situe à gauche de l’interface, et *Audacity* affiche des repères temporels réguliers à mesure que l’onde progresse vers la droite. Si vous cliquez sur le bouton « Lecture », *Audacity* parcourra le son de gauche à droite, avec une ligne verticale indiquant votre position dans l’extrait.

L’axe vertical - y, en ordonnée - représente l’amplitude, ce que nous appelons plus couramment "volume" ou "intensité sonore". Par défaut, l’axe y mesure le volume sur une échelle linéaire de -1 à 1 : les valeurs -1 et 1 correspondent au son le plus fort enregistrable sans distorsion, tandis que 0 représente le silence. Ainsi, le silence apparaît comme une ligne plate, et le son devient plus « haut » et « profond » à mesure que son intensité augmente. Pour en savoir plus sur les valeurs négatives, vous pouvez consulter ce [cours d’acoustique](http://web.archive.org/web/20161119231053/http://www.indiana.edu:80/~emusic/acoustics/amplitude.htm) de Jeffrey Hass (contenu en anglais).

La représentation du temps et de l’amplitude dans *Audacity* est le premier point de repère, et le plus simple, pour l'édition audio. Le logiciel propose des fonctions pratiques permettant de s'y retrouver facilement. Nous parlons d'une onde, mais pour l'instant, elle n'en a pas vraiment l'apparence. Observons-la de plus près en sélectionnant un extrait de la piste audio.

- Cliquez n'importe où sur la courbe pour commencer la sélection.
- Faites glisser le curseur pour sélectionner une portion de la courbe (toute partie contenant du son convient). Si la sélection ne vous convient pas, vous pouvez ajuster ses limites en faisant glisser les bords.
- Une fois que l'échantillon vous convient, dans le menu « Affichage », sélectionnez « Zoom », puis « Zoom avant » .

Si vous effectuez un zoom à six ou sept reprises, vous commencerez à voir quelque chose qui ressemble davantage à une onde sinusoïdale :

{% include figure.html filename="fr-tr-editer-audio-avec-audacity-02.png" alt="Visual description of figure image" caption="Figure 2. Vue zoomée de la forme d’onde de Bach" %}

Vous remarquerez que, dans *Audacity*, les incréments de temps s’ajustent également lorsque vous zoomez. Les fréquences de hauteur (*pitch*) sont mesurées en ondes par seconde, et le programme doit compresser les données pour afficher l’intégralité du clip dans une fenêtre exploitable. Le résultat est la forme d’onde que nous voyons lorsque nous revenons à la vue normale en sélectionnant « Zoom normal » dans le menu « Affichage » → « Zoom ». Chaque vue — micro et macro — a ses propres utilités. Nous y reviendrons.

Avant de continuer, il est utile d’observer les différentes palettes qu’*Audacity* propose pour ses fonctions les plus courantes. La palette de lecture affiche des symboles qui vous seront probablement familiers : des boutons pour mettre en pause, lire, arrêter, avancer rapidement au début ou à la fin d’un fichier audio, et enregistrer.

La palette d’outils est, quant à elle, probablement nouvelle pour vous. Nous n’aborderons pas toutes les fonctionnalités d’*Audacity*, certains boutons resteront donc inutilisés. Cependant, notez que nous utiliserons l'outil « Sélection » (en haut à gauche) dans cette leçon =="et « Déplacement temporel » (en bas, au centre)" **/!\\** cet outil n'existe plus sous cette forme ([source](https://manual.audacityteam.org/man/time_shift_tool.html))==. À l'ouverture d'*Audacity*, l’outil « Sélection » est activé par défaut.

## Enregistrer de l’audio

Nous avons chargé la musique d’introduction de notre podcast. Continuons en enregistrant notre propre voix.

- Par défaut, *Audacity* rejouera et réenregistrera votre piste originale lorsque vous voudrez en enregistrer une nouvelle. Pour éviter cela, vous pouvez temporairement couper le son de la piste de Bach pendant l’enregistrement de votre voix. Pour ce faire, cliquez sur le bouton « Mute » à gauche de la forme d’onde de Bach. La piste deviendra grise, indiquant qu’elle ne sera pas lue.

- Pour commencer l’enregistrement dans *Audacity*, appuyez sur le grand cercle rouge situé en haut à gauche de la fenêtre. Il ne faut pas trop s'inquiéter de la qualité de l'enregistrement ; nous éditerons le fichier ensuite.

- Faites de votre mieux pour imiter un animateur ou une animatrice de radio, puis appuyez sur le carré « Arrêter » une fois terminé.

Vous obtiendrez ce type de résultat :

{% include figure.html filename="fr-tr-editer-audio-avec-audacity-03.png" alt="Visual description of figure image" caption="Figure 3. Deux pistes chargées dans *Audacity*" %}

L’enregistrement original de Bach reste en haut de l’interface, tandis que notre nouvel enregistrement est ajouté en dessous. Par défaut, *Audacity* n'écrase pas l’enregistrement précédent : il isole les deux pistes sonores, ce qui permet de manipuler chaque composante séparément avant de les ==mixer== dans un enregistrement final. Vous pouvez modifier l’une sans affecter l’autre. Notez que, temporellement, la nouvelle piste commence par défaut au début du projet *Audacity*. Pour l’instant, la piste Bach et la piste de votre voix commencent en même temps. Votre enregistrement peut présenter d’autres imperfections, que nous corrigerons en partie.

Enfin, remarquez que, dans notre exemple, la piste de Bach comporte deux formes d’onde, tandis que notre enregistrement vocal n’en a qu’une. L’enregistrement de Bach a été réalisé en *stéréo* (deux canaux d’entrée), alors que le mien est en *mono*. *Audacity* permet d’enregistrer dans les deux formats, et chacun conviendra pour cette leçon. Il n'y a donc pas de quoi s'inquiéter si votre enregistrement apparaît en stéréo. Vous pouvez basculer entre *mono* et *stéréo* via la barre d’outils « Édition », accessible depuis « Barres d’outils » dans le menu « Affichage ». ==À vérifier sur la version récente d'Audacity== Pour en savoir plus sur la différence entre *mono* et *stéréo*, vous pouvez consulter [cet article (en anglais)](http://www.diffen.com/difference/Mono_vs_Stereo).

Une petite précision : il peut souvent s'avérer utile de rediriger la sortie audio de votre ordinateur vers son entrée, afin d'enregistrer les sons qu'il diffuse sans être gêné par des bruits ambiants extérieurs, ou pour réenregistrer de l'audio numérique. Pour savoir comment procéder, consultez [Soundflower](https://github.com/mattingalls/Soundflower).

## Éditer l’audio

L’ingénierie audio est un domaine vaste, qui peut faire l’objet d’une carrière longue et enrichissante. Nous ne prétendons pas couvrir tous les sujets possibles dans cette leçon, mais nous proposerons quelques techniques de base utiles pour travailler avec de l’audio numérique. Votre expérience peut varier en fonction des caractéristiques propres à votre enregistrement.

Pour utiliser la piste enregistrée, nous devons d’abord la nettoyer, en isolant et en affinant les parties que nous souhaitons conserver. Une première étape consistera à supprimer les silences indésirables créés entre le début de l’enregistrement et le moment où vous commencez à parler.
    
- Faites un zoom sur le début du clip pour visualiser le silence. En cliquant et en faisant glisser la souris sur les sections de la forme d’onde, vous pouvez les supprimer en appuyant sur la touche « Supprimer » de votre clavier.

{% include figure.html filename="fr-tr-editer-audio-avec-audacity-04.png" alt="Visual description of figure image" caption="Figure 4. Début de la piste vocale prêt à être supprimé" %}  
{% include figure.html filename="fr-tr-editer-audio-avec-audacity-05.png" alt="Visual description of figure image" caption="Figure 5. Début de la piste après la suppression" %}

Ces petites pauses peuvent sembler insignifiantes, mais elles constituent des éléments importants dans n'importe quelle piste audio. Nous voulons que le début et la fin de la nouvelle piste vocale ne contiennent aucune donnée superflue. Après suppression, vous devriez obtenir un clip audio bien délimité, avec seulement une infime trace de silence à chaque extrémité.

Pour garantir des transitions fluides entre les pistes, nous devons introduire des fondus sonores, c’est-à-dire des transitions à amplitudes progressives. Il est conseillé d’ajouter un très court fondu d’entrée au début de la piste et un fondu de sortie à la fin, pour revenir au silence. Cela permet d’éviter les clics et les sons parasites en empêchant le son d'apparaître ou de disparaître brutalement.
    
- Faites un zoom sur le début de la piste, surlignez le début de l’onde (en incluant une infime partie du son cible), puis sélectionnez « Fondu en ouverture » dans le menu « Effets ».

Si vous n’avez sélectionné qu’une très petite portion, les changements causés par les fondus peuvent sembler invisibles. Ces captures d’écran ultra-zoomées vous aideront à visualiser l’effet :

{% include figure.html filename="fr-tr-editer-audio-avec-audacity-06.png" alt="Visual description of figure image" caption="Figure 6. Piste avant fondu d’entrée" %}

{% include figure.html filename="fr-tr-editer-audio-avec-audacity-07.png" alt="Visual description of figure image" caption="Figure 7. Piste après fondu d’entrée" %}

Le fondu d’entrée a considérablement réduit l’amplitude initiale et introduit des changements très progressifs sur la portion surlignée, lissant ainsi la transition et créant l’impression d’une augmentation progressive du volume.
    
- Répétez l'opération à la fin du clip, mais cette fois avec un « Fondu de sortie ».

Votre échantillon est désormais prêt à être inséré de manière fluide à n’importe quel endroit du fichier.

La suppression des silences et des sons indésirables a permis de préparer l'échantillon, mais nous devons encore le déplacer vers le moment souhaité. Nous allons le positionner à l’endroit approprié du podcast, après que la musique d’introduction a joué quelques secondes. Pour déplacer un extrait horizontalement sur l’axe temporel (abscisses) et lui attribuer une nouvelle position, utilisez l’outil ==« Déplacement temporel ». Avec cet outil sélectionné, un clic sur un échantillon sonore vous permet de le déplacer horizontalement dans le temps, par rapport aux autres pistes. **/!\\** cet outil n'existe plus sous cette forme, je n'ai pas trouvé d'[autre module à montrer](https://manual.audacityteam.org/man/time_shift_tool.html)==

- Déplacez votre extrait vocal vers la droite, de sorte qu’il commence après que la musique d’introduction a joué pendant quelques secondes.

{% include figure.html filename="fr-tr-editer-audio-avec-audacity-08.png" alt="Visual description of figure image" caption="Figure 8. Repositionnement de l'extrait audio dans le temps" %}

Si le volume de votre voix par rapport à la musique d’introduction vous semble inégal, vous pouvez les ajuster pour un meilleur équilibre. Le volume global d’une piste peut être modifié à l’aide du curseur de volume situé à gauche de chaque panneau de piste. Il ressemble à une petite ==échelle== -/+ :

{% include figure.html filename="fr-tr-editer-audio-avec-audacity-09.png" alt="Visual description of figure image" caption="Figure 9. Curseur du volume de la piste" %}

==**La traduction de ce paragraphe est-elle compréhensible ?**
But we will eventually want to transition the track's focus away from the intro music entirely and give new emphasis to the recording of our voice. A crossfade like this is easy to implement in *Audacity*.==

==Cependant, nous voulons finalement faire une transition complète de la musique d’introduction vers votre enregistrement vocal, en mettant l’accent sur ce dernier. Un fondu enchaîné (*crossfade*) est facile à réaliser dans *Audacity*.==
    
- D'abord, supprimez tout sauf les cinq premières secondes environ de l’introduction de Bach. Placez le curseur à l’endroit où vous souhaitez commencer la suppression, puis appuyez sur « Maj + K » ou rendez-vous dans le menu « Édition » et cliquez sur « Sélection/Curseur jusqu’à la fin de la piste » . Cela permettra de sélectionner l'ensemble de la piste situé après le curseur.
    
- Alignez ce qui reste avec votre piste vocale à l’aide de l’outil « ==Déplacement temporel » afin que les deux pistes se chevauchent légèrement. **/!\\** cet outil n'existe plus sous cette forme, je n'ai pas trouvé d'[autre module à montrer](https://manual.audacityteam.org/man/time_shift_tool.html)==
    
- Utilisez ensuite l’outil de sélection pour cliquer et faire glisser afin de surligner la section de chevauchement, en commençant par la piste du haut et en terminant par celle du bas. Les deux pistes doivent être ==surlignées==.

{% include figure.html filename="fr-tr-editer-audio-avec-audacity-10.png" alt="Visual description of figure image" caption="Figure 10. Surlignage des pistes pour le fondu enchaîné" %}
    
- Sélectionnez « Fondu-enchaîné de pistes » dans le menu « Effets » → « Steve Daulton » pour indiquer à *Audacity* de faire un fondu de sortie sur la piste du haut tout en faisant un fondu d’entrée sur celle du bas. Dans notre cas, l’ordre des pistes est important .

*Audacity* vous proposera des options pour le fondu enchaîné, mais pour l’instant, il est suffisant d'appliquer les paramètres par défaut « Gain constant ». Ce réglage garantit que les deux pistes s’estomperont de manière linéaire. Pour plus d’informations, consultez la [documentation d’*Audacity* sur les fondus enchaînés](http://manual.audacityteam.org/man/crossfade_tracks.html)  (en anglais).

{% include figure.html filename="fr-tr-editer-audio-avec-audacity-11.png" alt="Visual description of figure image" caption="Figure 11. Résultat après fondu enchaîné" %}

Une fois le ==mixage== finalisé, le résultat correspondra à une transition fluide entre les deux éléments.

## Exporter le fichier

Par défaut, tout ce que vous faites dans *Audacity* est enregistré dans le format propre au logiciel (.aup). Pour finaliser ce mini-projet, nous devons exporter le fichier dans un format lisible par la plupart des programmes audio.
    
- Dans le menu « Fichier », sélectionnez « Exporter l’audio... ».

Cela mixera les pistes multiples en un seul fichier audio et vous permettra d’ajouter des métadonnées à votre travail.

Plusieurs options s’offrent à vous pour affiner le processus d’exportation, mais la plus importante coorespond au « Type de fichier ». Les formats MP3 et Ogg sont de bons choix pour l’audio destiné au Web, car ils compressent les fichiers pour un chargement plus rapide. Pour des résultats optimaux, vous pouvez inclure les deux formats et n’afficher que l’un en secours si l’autre n’est pas supporté par le navigateur de l’utilisateur. Pour plus d’informations techniques, [NCH Software propose une analyse détaillée des différentes options](http://www.nch.com.au/acm/formats.html), tandis que Jonathan Sterne a réalisé des [travaux passionnants](https://www.dukeupress.edu/mp3) sur les implications culturelles de ces choix de formats. Enfin, [W3Schools](http://www.w3schools.com/html/html5_audio.asp) offre une bonne comparaison de ces formats pour le développement Web. Toutes ces ressources sont accessibles en langue anglaise.

Félicitations ! Vous venez de produire un mini-podcast. Cela peut sembler modeste, mais il est possible d'utiliser ces mêmes techniques pour des présentations, des sites Web et des projets académiques. Cette leçon n’a évidemment pas épuisé tous les sujets liés à l’audio, mais il vous a fourni des outils de base utiles pour travailler avec le son dans des projets numériques en sciences humaines et sociales.
