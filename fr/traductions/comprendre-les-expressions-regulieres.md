---
title: Comprendre les expressions régulières
layout: lesson
date: 2013-06-22
authors:
- Doug Knox
reviewers:
- Dave Shepard
- Patrick Burns
editors:
- Adam Crymble
translator: Alix Chagué
translation-date: 2019-09-26
translation-editors:
translation-reviewers:
difficulty: 2
exclude_from_check:
  - review-ticket
activity: transforming
topics: [data-manipulation]
abstract: |
  Dans cette leçon, nous allons voir une utilisation avancée de la fonciton "rechercher-remplacer" d'un logiciel de traitement de texte dans le but de rendre utilisable la structure d'un court document historique, qui n'est en essence rien d'autre d'un tableau en prose."
avatar_alt:
---

{% include toc.html %}

## Objectifs de la leçon

Dans cet exercice, nous utilisons les fonctionnalités avancées de l'outil
"rechercher-remplacer" d'une application de traitement de texte afin
de valoriser la structure implicite d'un court document historique. Ce
dernier est essentiellement un tableau en forme de prose. Sans utiliser
un langage de programmation, nous aurons affaire à certains aspects de la
pensée computationnelle, en particulier le filtrage par motif. Il peut
être utile aux historien.ne.s en activité (et aux autres) qui utilisent
des traitements de texte et peut constituer une base pour de futurs
apprentissages avec des environnements de développement (IDE) plus
généraux.

Nous commencons avec quelque chose qui ressemble à ceci:

```
Arizona. — Quarter ended June 30, 1907. Estimated population,
 122,931. Total number of deaths 292, including diphtheria 1, enteric
 fever 4, scarlet fever 11, smallpox 2, and 49 from tuberculosis.
```


Et nous utilisons un filtrage par motif pour obtenir quelque chose qui
ressemble à ceci:

|          |                              |        |               |      |
| :------- | :--------------------------- | :----- | :------------ | :--- |
| Arizona. | Quarter ended June 30, 1907. | Deaths | diphtheria    | 1    |
| Arizona. | Quarter ended June 30, 1907. | Deaths | enteric fever | 4    |
| Arizona. | Quarter ended June 30, 1907. | Deaths | scarlet fever | 11   |
| Arizona. | Quarter ended June 30, 1907. | Deaths | smallpox      | 2    |
| Arizona. | Quarter ended June 30, 1907. | Deaths | tuberculosis  | 49   |


## Les expressions régulières : pour qui, pour quoi ?

Peut-être n'êtes-vous pas encore sûr.e de vouloir faire partie des
historien.ne.s *qui programment*, et vous voulez simplement travailler
plus efficacement avec vos sources. Les historien.ne.s, les bibliothécaires
et d'autres spécialistes des sciences humaines et sociales travaillent
souvent avec des sources textuelles dont la structure est implicite. Il
n'est pas rare non plus en sciences humaines d'avoir à faire un travail
textuel fastidieux avec des notes semi-structurées et des références
bibliographiques. Dans ce cas, il peut être utile de connaître les options
de filtrage par motif.

Un exemple simple : si vous voulez trouver dans un document une référence
à une année précise, disons 1857, il est facile de chercher uniquement
cette date. Par contre, si on veut trouver toutes les références
à des années de la deuxième moitié du XIXe siècle, chercher plusieurs
dizaines de dates à la suite n'est pas pratique du tout. En utilisant
les expressions régulières, on peut faire appel à un motif concis comme
"18[5-9][0-9]" pour trouver efficacement n'importe quelle année entre
1850 et 1899.

Pour cet exercice, nous utilisons LibreOffice Writer et LibreOffice
Calc, des logiciels libres de type application de bureau, utilisés
respectivement pour le traitement de texte et les feuilles de calcul.
Les paquets d'installation pour Linux, Mac ou Windows peuvent être
téléchargés depuis <http://www.libreoffice.org/download>. D'autre logiciels
de traitement de texte et même des langages de programmation
ont des fonctionalités similaires de recherche de motifs. Cet exercice
utilise LibreOffice car la suite bureautique est disponible librement
et sa syntaxe pour les expressions régulières est la plus proche de ce
que vous trouverez dans des environnements de programmation, par rapport à
la syntaxe de Microsoft Office. Toutefois, si vous terminez cet exercice
et trouvez les expressions régulières utiles, il vous sera relativement
facile d'adapter ce que vous aurez appris pour l'appliquer dans d'autres
contextes.

Même si nous commençons avec des motifs simples, nous allons rapidement
parvenir à des structures plus complexes voire intimidantes. Le but ici
est de partager ce que l'on peut utilement mettre en place avec un exemple
concret. Nous n'allons pas nous attarder sur des exemples bateaux servant
uniquement à illustrer les principes de base. Si vous faire cette leçon
sans prendre trop de temps, vous devriez pouvoir parcourir les exemples
assez rapidement en copiant et collant les motifs proposés, sans nécessairement
suivre chaque détail, afin d'avoir une idée générale de ce qui est possible.
Si le résultat est prometeur, vous relirez une deuxième fois pour décider
quels détails sont utiles pour votre travail. Ceci étant dit tout taper
soi-même est la meilleure façon de s'approprier le texte.

## Récupérer le texte

{% include figure.html filename="regex_ia_image.png" caption="Figure 1: Capture d'écan du texte non structuré" %}

Internet Archive conserve des copies de centaines de rapports de santé
publique américains du début du XXe siècle, tombés dans le domaine public.
Ils ont été numérisés via JSTOR et sont rangés sous le titre "Early Journal
Content". Ils sont d'une bonne longueur pour un exeercice et sont représentatifs
de différents types de ressources textuelles utilisées pour toutes sortes
de recherche en histoire. Pour notre exercice, nous allons utiliser un rapport
de cinq pages contenant des statistiques mensuelles sur la morbidité et la
mortalité des États et de villes des États-Unis, publié en février 1908. Il
est disponible ici : <http://archive.org/details/jstor-4560629/>.

Prenez un moment pour parcourir brièvement les pages du document grâce au
[lien pour lire en ligne][], afin de vous familiariser avec. Ce document est
organisé en paragraphes plutôt qu'en tableaux. Mais on voit bien que
sa structure sous-jacente peut nous aider à présenter les données sous
forme de tableau. Presque tous les paragraphes du rapport commencent par
des informations géographiques, précisent un laps de temps pour les
statistiques, éventuellement incluent une estimation de la population, et
ensuite, font le compte des morts et des cas de maladie non mortelles.

L'interface de retournement de page nous montre à quoi ressemblait le
document original. Mais si nous voulons tabuler des chiffres et faire en
sorte que de faire des comparaisons et des calculs sur la géographie, nous
devrons représenter le document sous forme de texte et de chiffres, et
pas seulement d'images. En plus d'offrir plusieurs formats d'images à télécharger,
Internet Archive met à disposition des versions en texte brut créées au moyen
de logiciels de reconnaissance optique de caractères (*Optical Character
Recognition* - OCR). La reconnaissance optique de caractères est souvent
imparfaite sur les textes anciens, mais ce qu'elle produit est déjà plus
utile que des images. En effet, ce texte peut être recherché, copié
et modifié.

Passez à l'affichage en [Texte intégral][]. Nous partirons de cette base,
en ignorant la dernière partie du rapport précédent. Dans un nouveau document
LibreOffice, copiez le texte depuis "STATISTICAL REPORTS..." jusqu'à la fin.
Lorsque vous travaillez avec des données qui vous sont essentielles, assurez-vous
d'en sauvegarder une copie dans un endroit séparé de votre copie de travail.
Cela vous permettra de revenir vers l'original si quelque chose ne se passe
pas comme prévu.

## Usage ordinaire de "Rechercher-Replacer"

Nous pouvons voir quelques erreurs de reconnaissance de caractères (là où le
logiciel de transcription automatisée d'Internet Archive a fait des erreurs)
même si globalement, cela semble être une bonne transcription. Il y a deux
endroits où l'OCR a inséré par erreur des guillemets doubles dans ce fichier,
dans les deux cas en les mettant entre une virgule après un mois et une année
à quatre chiffres, comme dans

```
December," 1907.
```

Nous pouvons les trouver en faisant une recherche (`Editer → Trouver` avec le
raccourci Ctrl-F ou Cmd-F sur un Mac) portant sur les guillemets doubles. Il
faut ensuite confirmer que ce sont les deux seules instances de guillemets
dans le fichier. Dans le cas présent, nous pouvons simplement les supprimer.
Plutôt que de le faire à la main, essayons d'utiliser la fonction de recherche
et de remplacement de LibreOffice (`Ctrl-H` ou `Cmd-Alt-F` sur Mac).

*Remplacer* `"` *avec rien.*

{% include figure.html filename="regex_01_findquote.png" caption="Figure 2: Capture d'écran de l'option \"Rechercher & remplacer\"" %}

## Trouver une structure pour les lignes

Nous ne faisons que commencer, mais pour estimer jusqu'où nous devons aller,
sélectionnez tout le texte dans LibreOffice Writer (`Ctrl-A`) et collez-le
dans LibreOffice Calc (`Fichier → Nouveau → Feuille de calcul`). Chaque ligne
de texte devient une rangée unicellulaire de la feuille de calcul. Ce que
nous aimerions, c'est que chaque ligne de la feuille de calcul représente un
type d'enregistrement dans une forme cohérente. Ce serait un travail
fastidieux de faire à la main un tableau de ceci. Dans ce qui suit, nous
allons réaliser cette tâche avec des expressions régulières dans Writer, mais
gardez Calc ouvert dans l'arrière-plan : nous pourrons y retourner pour copiez
nos futures modifications et jauger nos progrès.

De retour dans Writer, nous voulons nous débarrasser des sauts de ligne
dont nous n'avons pas besoin. Il y a cependant quelques césures de fin de
ligne que nous devrions nettoyer en premier. Cette fois-ci, nous allons
commencer à utiliser des expressions régulières. Attention, l'implémentation
des expressions régulières diffère dans la manière de gérer les retours à la
ligne, bien plus que dans leur façon de trouver des motifs dans les lignes.

Les expressions régulières dans LibreOffice ne correspondent pas facilement
aux modèles de texte qui s'étendent au-delà des sauts de ligne, nous adoptons
donc une stratégie indirecte. Nous allons d'abord remplacer les sauts de
ligne par un caractère de remplacement - disons `#` - qui n'apparaît pas
ailleurs dans notre texte.

Dans la boîte de dialogue de l'outil "Rechercher & remplacer", activer
"Plus d'options" ("Autres options" sur Mac) et assurez-vous que l'option
`expressions régulières` est cochée. Ceci nous permet désormais d'utiliser
des symboles spéciaux pour définir des motifs généraux que nous cherchons.

En utilisant `Rechercher & remplacer`, *remplacer* `$` *par* `#`.

{% include figure.html filename="regex_02_moreoptions.png" caption="Figure 3: L'onglet \"Autres Options\" dans la fenêtre \"Rechercher & remplacer\" d'Open Offi" %}

Le symbole du dollar est un symbole spécial qui correspond
habituellement à la fin de chaque ligne afin d'ancrer un motif plus
grand. Cependant, même s'il peut avoir cette fonction dans
LibreOffice dans des modèles plus larges, LibreOffice ne nous
permettra pas de trouver une portion de texte qui s'étend de
part et d'autre d'un saut de ligne. En revanche, avec LibreOffice
nous pouvons utiliser le caractère `$` seul, sans autre motif,
afin de trouver les sauts de ligne indépendamment des autres
caractères et les remplacer.

Pour réaliser une opération de type "rechercher & remplacer",
vous pouvez commencer par cliquer sur "Rechercher" puis sur
"Remplacer" lorsque vous constatez que la portion sélectionnée
correspond à vos attentes. Après l'avoir répété plusieurs fois,
vous pouvez cliquer sur "Tout remplacer" pour remplacer tout le
reste en une seule fois. Si vous faites une erreur ou en cas de
doute, vous pouvez annuler les étapes récentes avec `Editer →
Annuler` dans la barre de menu, ou le raccourci clavier `Ctrl+Z`
(`Cmd+Z` sur Mac).

Dans ce document, le remplacement des fins de ligne entraîne 249
remplacements (ce nombre peut varier légèrement selon la quantité
de texte que vous avez copié). Cette séquence de remplacements
rendra le texte moins lisible temporairement, mais c'est nécessaire
car nous ne pouvons pas transformer une sélection qui s'étend de
part et d'autre d'un saut de ligne. En revanche, nous pouvons le
faire de part et d'autre d'un caractère `#`.

A présent, refermons les césures de mots. Cela peut désormais se
faire à l'aide d'un remplacement littéral, sans utiliser
d'expression régulière.

En utilisant encore "Rechercher & remplacer", *remplacez tous
les* `- #`*(tiret-espace-dièse) par rien.*

Cela refermera les césures comme "tuber- #culosis" en
"tuberculosis" en une seule ligne, avec un total de 27
remplacement dans notre cas.

Ensuite,  *remplacez tous les* `##` par `\n`.

Il en résulte 71 remplacements. Dans cette étape, nous prenons
ce qui était à l'origine des sauts de paragraphe, qui prenaient
la forme de 2 sauts de ligne, puis d'un dièse doublé (`##`),
et nous les transformons à nouveau en sauts de ligne simples.
Ils fonctionneront dans le classeur comme des marqueurs pour
commencer une nouvelle ligne.

Pour finir notre travail sur les sauts de lignes, *remplacez
tous les `#` par ` `* (un espace simple). Cela nous débarrasse
de 122 sauts de lignes qui n'étaient pas des sauts de paragraphes
dans le texte original.

A première vue, ce qui se passe ici peut ne pas sembler clair.
Cela a en réalité fait de chaque paragraphe, un seul paragraphe,
une seule ligne logique. Dans LibreOffice (et dans les éditeurs
de texte similaires), vous pouvez activer l'affichage des
caractères non imprimables (en utilisant `Ctrl-F10` sur
Windows ou Linux) pour voir les lignes et les sauts de
paragraphes.

{% include figure.html filename="regex_03_lines.png" caption="Figure 4: Caractères non imprimable dans LibreOffice" %}

Une dernière manière de confirmer que nous commençons à
obtenir une structure plus pratique : copions à nouveau tout
le texte de Writer et collons-le dans une nouvelle feuille
de calcul. Ceci devrait confirmer que chaque fiche de santé
est maintenant sur une ligne distincte dans le tableur (bien
que nous ayons encore les en-têtes de page et les notes de
bas de page mélangées au milieu de tout cela - nous allons
les nettoyer bientôt).

{% include figure.html filename="regex_04_calclines.png" caption="Figure 5: La structure améliorée, affichée dans LibreOffice Calc" %}

## Trouver une structure pour les colonnes

Les feuilles de calcul organisent l'information en deux dimensions,
lignes et colonnes. Nous avons vu que les lignes dans Writer
correspondent aux lignes dans Calc. Comment faire des colonnes ?

Le logiciel de tableur peut lire et écrire des fichiers
de texte brut à en suivant plusieurs conventions pour
représenter le passage à une nouvelle colonne. Un format
très commun utilise la virgule pour séparer les colonnes,
et de tels fichiers sont souvent stockés avec l'extension
".csv" pour "comma-separated values" (valeurs séparées par
des virgules). Un format courant utilise la tabulation, un
type d'espace spécial, pour séparer les colonnes. Parce que
notre texte contient des virgules, pour éviter toute confusion,
nous utiliserons un caractère de tabulation pour séparer
les colonnes. Même si l'on peut sauvegarder un fichier de
texte brut en guise d'intermédiaire, dans cet exercice,
nous supposerons que nous copions et collons directement de
Writer à Calc.

De retour dans Writer, commençons à faire des colonnes en
séparant les informations sur le lieu et l'heure des chiffres
rapportés. Presque tous les rapports contiennent les mots
`Total number of deaths`.

Cherchez cette expression et remplacez-la par exactement
la même phrase, mais avec "\\t" au début de la chaîne de
caractères (`\t` représentant un caractère de tabulation) :

`\tNombre total de décès`

Après avoir fait ce remplacement (53 changements dans notre
cas), sélectionnez tout le texte et copiez-collez-le à
nouveau dans une feuille de calcul vide.

Rien n'a changé ? LibreOffice Calc met le texte complet de chaque
paragraphe dans une seule cellule, tabulations comprises. Nous
devons forcer une interprétation en texte clair pour que Calc nous
demande ce qu'il faut faire avec les tabulations. Essayons encore
une fois. Vous pouvez vider la feuille de calcul facilement en
sélectionnant tout (`Ctrl-A`) et en supprimant la sélection.

Dans une feuille de calcul vide, sélectionnez `Editer →
Collage spécial` (ou faites un clic droit pour y accéder),
puis sélectionnez "texte non formaté" dans les options de la
fenêtre qui apparaît. Cela devrait ouvrir une fenêtre "Import
de texte". Assurez-vous que la case "Tabulation" est cochée
sous "Options de séparateur", puis cliquez sur "OK". (Avant
de cliquer sur OK, vous pouvez essayer de cocher et décocher
les options "Virgule" ou "Espace" comme séparateurs pour
prévisualiser ce qu'ils feraient ici, mais nous ne voulons
pas les traiter comme séparateurs dans ce contexte).

Nous voyons maintenant le début prometteur d'une structure de
tableau, avec la géographie et l'intervalle de temps toujours
dans la colonne A, mais avec le "nombre total de décès" et le
texte suivant clairement alignés dans une colonne séparée.

{% include figure.html filename="regex_05_2col.png" caption="Figure 6 : La nouvelle version des données délimitée par les tabulations, affichée dans LibreOffice Calc" %}

Vous avez des cas qui sont passés dans une troisième colonne ou
au-delà ? Il se peut que vous ayez, par inadvertance, mis trop
d'onglets. Dans la structure que nous avons actuellement, nous
ne nous attendons pas à voir deux onglets de suite. De retour
dans LibreOffice Writer, nous pouvons vérifier cela et résoudre
le problème en recherchant `\t\t`et en les remplaçant par `\t`,
**en répétant au besoin** jusqu'à ce qu'il n'y ait plus de
double-tabulation.

Parfois, appliquer plusieurs fois le remplacement d'un motif introduit
des changements supplémentaires qui peuvent être ou non intentionnels.
D'autres fois, répéter le remplacement n'aura aucun effet après la
première application. Il vaut la peine de garder cette distinction
à l'esprit quand on travaille avec des expressions régulières.


## L'idée générale des expressions régulière

Avant de reprendre les travaux pratiques avec la gestion des
fichiers, c'est le moment de faire une courte introduction aux
expressions régulières. Les expressions régulières (ou "regex"
pour faire court) sont une façon de définir un motif qui peut
s'appliquer à une séquence d'éléments. Elles ont ce nom rigolo
en raison de leurs origines dans le monde de l'informatique et
des languages formels théoriques et elles sont incorporées à
la plupart des languages de programmation généraux.

Les regex sont souvent accessibles sous une forme ou une autre
dans les logiciels de traitement de texte avancés, nous procurant
ainsi une option "rechercher et remplacer" plus puissante que
simplement le remplacement d'une séquence exacte, lettre par
lettre. Il existe différentes syntaxes et différentes
implémentations des expressions régulières et ce dont on peut
disposer dans un logiciel de traitement de texte est souvent
moins poussé, moins robuste et moins conforme à la pratique
la plus courante que ce que l'on peut trouver dans le contexte
d'un langage de programmation, mais il y a des principes
essentiels communs



|         |                                                                                                                                                               |
| ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `A b 1` | Littéral - les lettres, les chiffres et les espaces sont représentés par eux-même                                                                             |
| `[Ab1]` | Une classe de caractères, on sélectionne alors `A` ou `b` ou `1` dans ce cas-là                                                                               |
| `[a-z]` | Toutes les minuscules, dans un interval donné                                                                                                                 |
| `[0-9]` | Tous les chiffres                                                                                                                                             |
| `.`     | N'importe quel caractère                                                                                                                                      |
| `*`     | Zéro ou plus                                                                                                                                                  |
| `()`    | Si le contenu entre parenthèses correspond, cela définit un groupe auquel il sera possible de faire référence par la suite                                    |
| `$1`    | Fait référence à un groupe sélectioné auparavant (Ceci est la notation utilisée par LibreOffice ; d'autres notations, tel que \1 peuvent aussi être utilisées |
| `\t`    | Tabulation                                                                                                                                                    |
| `^`     | Début de ligne                                                                                                                                                |
| `$`     | Fin de ligne                                                                                                                                                  |

Pour une liste plus complète d'expressions régulières dans
LibreOffice, voir la [Liste des expressions régulières][]


## Appliquer les expressions régulières

Commençons à en utiliser quelques-unes pour supprimer les
en-têtes de page avec la date et le numéro de page. Revenez
à votre fenêtre LibreOffice Writer.

**Remplacer :** `^.*February 21.*1908.*$` **par** rien (4 résultats).

**Remplacer :** `^.*Received out of regular order..*$`  **par**
rien (2 resultats).

Ici, `^` (accent circonflexe) correspond au début de la ligne.
Le `.` (point) correspond à n'importe quel caractère. Le `*`
(astérisque) correspond à toute séquence de zéro caractère ou
plus. Enfin, `$` (signe dollar) correspond à la fin de la ligne.
En épelant la date, nous apparierons seulement les lignes où
cette séquence apparaît, lettre par lettre, et en utilisant
`.*` aux deux extrémités nous apparierons toutes les lignes avec
cette séquence indépendamment de ce qui est avant ou après elle
sur la ligne. Après avoir effectué ce remplacement, il nous
restera quelques lignes vierges.

Pour supprimer les lignes vides dans LibreOffice, **remplacer**
`^$` *par rien* (5 résultats).

(Dans d'autres environnements d'expressions régulières, d'autres
techniques seront nécessaires pour travailler avec les fins de
lignes. Certaines peuvent être plus pratiques que ce que
LibreOffice offre, mais cela fonctionnera maintenant pour nos
besoins.

Certains documents listent un État, d'autres une ville dont
l'État est implicite, d'autres encore une ville et son État
ensemble. Le texte n'est pas assez structuré pour nous donner
une façon fiable de distinguer les rapports de la Californie
et d'Oakland, d'une manière qui nous permette de classer
automatiquement "Californie" dans une colonne "État", et
"Oakland" dans une colonne "ville". Nous devrons à terme
faire quelques éditions à la main, en nous appuyant sur nos
propres connaissances. Mais les références aux périodes de temps
sont très uniformes. Nous pouvons utiliser ces références pour
créer des structures qui nous aideront à maintenir des segments
similaires alignés entre les lignes.

Par commodité, mettons dans le texte des marqueurs qui ne seront
pas confondus avec ce qui est déjà présent. Nous pouvons facilement
distinguer ces marqueurs du texte existant, et les supprimer plus
tard quand nous n'en avons plus besoin. Cherchons les références
temporelles et mettons "\<t\>" au début et "\</t\>" à la fin,
avec la mnémonique "t" pour "temps". Nous pourrions mettre un
marqueur plus verbeux, comme "\<time\>" ou un marqueur plus
insignifiant et désordonné, comme "asdfJKL ;" (tant que cette
suite de caractère n'existe pas déjà, quelle qu'en soit la raison,
dans notre texte). Mais dans cet exercice, nous utiliserons des
marqueurs comme "\<t\>". Si vous connaissez HTML ou XML, nos
marqueurs ressemblent beaucoup aux balises qui marquent les
éléments. Nous ne créons pas du HTML acceptable ou du XML bien
formé en faisant cela, et nous supprimerons ces marqueurs
rapidement, mais il y a une ressemblance.

**Avertissement:** Les expressions régulières sont puissantes,
mais elles ont leurs limites et (lorsqu'elles sont utilisées
pour modifier du texte auquel vous tenez) elles peuvent être
dangereuses : une erreur et vous pouvez rapidement supprimer
ou altérer de nombreuses informations par inadvertance. De plus,
comme certain.e.s aficionadxs du XML pourront vous le dire
avec insistance, les expressions régulières ne suffisent pas
pour réaliser le même travail d'analyse générale que permet le
XML. Après avoir vu à quel point les expressions régulières sont
utiles pour traiter certains types de motifs, on est tenté de penser,
chaque fois qu'on voit un motif, qu'un ordinateur devrait être
capable d'aider, que les expressions régulières sont tout ce
dont on a besoin. Dans de nombreux cas, cela s'avérera faux.
Les expressions régulières ne sont pas adéquates pour traiter
les modèles hiérarchiquement imbriqués qu'on décrit facilement
en revanche avec XML.

Mais ce n'est pas grave. Dans le cadre de ce tutoriel, nous ne
prétendons pas savoir quoi que ce soit sur XML, ni ne nous
soucions-nous de la grammaire formelle des langages. Nous
voulons simplement mettre des marqueurs pratiques dans un
texte afin d'obtenir un certain effet de levier pour rendre
une structure implicite relativement simple un peu plus
explicite, et nous allons retirer ces marqueurs avant d'en
avoir fini.

Il y a une raison pour laquelle de tels marqueurs sont utiles.
Si ce qui peut être fait avec les modèles dans cet exercice
vous intrigue, vous voudrez sans doute en apprendre davantage
sur HTML et sur XML, et apprendre ce que leurs structures
plus explicites permettent de faire.


## Définir les segments

Les quelques modèles suivants deviendront rapidement plus
compliqués. Si vous prenez le temps de regarder la documentation
pour voir comment les symboles définissent les motifs, toutefois,
ils commençeront à avoir sens.

Les références géographiques dans notre texte sont suivies de
cadratin (tirets plus ou moins aussi large que la lettre "m" ;
plus larges que le trait d'union). On peut les remplacer par des
tabulations, ce qui va nous aider à mettre les Etats et les
villes dans des colonnes séparées dans la feuille de calcul.

**Remplacer** `[ ]?—[ ]?` **par** `\t`.

Vous devriez avoir 42 occurrences (une manière facile d'insérer
le cadratin dans le motif de recherche est de copier-coller un
cadratin déja existant dans le texte lui-même). Les crochets ne
sont pas vraiment nécessaires ici, mais ils aident à rendre
visible le fait qu'on cherche un espace vide.	Cela signifie
que notre motif acceptera un cadratin avec ou sans espace de
part et d'autres.)

Maintenant nous allons chercher des références explicites au temps
et nous allons les encadrer de "\<t\>" et "\</t\>". Une fois que
nous avons ces marqueurs ils fourniront une base à partir de laquelle
construire de nouveaux motifs. Notez que dans le prochain motif,
nous devons nous assurer d'appliquer le remplacement une fois
seulement, sinon, certaines références de temps risquent d'être
encadrées plusieurs fois. Il sera leplus efficace d'utiliser
"Tout Remplacer" juste une fois pour chaque modèle encadré.

**Remplacer** `(Month of [A-Z][a-z, 0-9]+ 19[0-9][0-9].)` **par**
`<t>$1</t>`.

{% include figure.html filename="regex_06_timemarkup.png" caption="Figure 7 : Trouver le temps en utilisant les expressions régulières" %}

Ici nous utilisons des parenthèses pour définir tout ce que nous
visons au sein du motif de recherche pour en faire un groupe que
nous utilisons dans le motif de remplacement avec `$1`, pour tout
simplement répéter la cible, avec quelques caractères supplémentaires
avant et après.

Nous avons besoin d'appliquer une approche similaire, cette fois-ci
pour les rapports trimestriels :

*Rmeplacer* `([-A-Za-z ]+ ended [A-Z][a-z, 0-9]+ 19[0-9][0-9].)` *par*
`<t>$1</t>`

Vous devriez avoir 7 occurrences supplémentaires. On dirait que nous
avons fini de traiter les références au temps. Continuons cette stratégie
pour traiter les autres types d'informations que nous avons ici. Nous
pouvons utiliser `<p>` pour les estimations de population, `<N>` pour
les nombres totaux de morts, et `<c>`pour le mot "Cases", qui sépare
mortalité et maladies. (Si vous connaissez un peu HTML ou XML, il vous
semblera peut-être reconnaître "<p>", le marqueur de paragraphe. Ici
toutefois, nous ne l'utilisons pas dans ce sens.)

Voici quelques motifs pour entourer chacuns de ces types d'information,
toujours en suivant la même stratégie :

*Remplacer* `(Estimated population, [0-9,]+.)` *par* `<p>$1</p>` (34
occurrences).

*Remplacer* `(Total number of deaths[A-Za-z ,]* [0-9,]+)` *par*
`<N>$1</N>` (48 occurrences).

*Remplacer* `(Cases ?:)` *par* `<c>$1</c>` (49 occurrences).

La partie suivante est un peu plus compliquée. Ce serait super si nous
pouvions capturer les maladies (utilisons `<d>` (pour *desease*) et
compter (`<n>`) les segments. Comme la langue utilisée dans ce document
est très standardisée, surtout pour les passages qui concernent le
décompte des morts, nous allons pouvoir aller assez loin sans avoir
à chercher chaque nom de maladie, un par un. Tout d'abord, ciblons les
paires maladie-décompte qui sont données après le mot "including" (y
compris):

*Remplacer* `</N> including ([A-Za-z ]+) ([0-9]+),` *par*
`</N> including <d>$1</d> <n>$2</n>` (29 occurences).

Ensuite, on cible de manière itérative les paires maladie-décompte qui
apparaissent après nos marqueurs existants :

*Remplacer* `> ([A-Za-z ]+) ([0-9]+)([.,])` *par* `> <d>$1</d> <n>$2</n>`

Remarquez que nous nous débarrassons des virgules après le décompte du
nombre de victimes de la maladie en ne faisant pas référence au troisième
groupe dans le motif de remplacement.

**Répétez** ce remplacement autant de fois que nécessaire, jusqu'à ce
qu'il n'y ait plus aucun résultat correspondant à la recherche. Cela
devrait vous prendre plusieurs itérations.

Notre motif n'a eu aucun effet sur les phrases comme "and 3 from
tuberculosis" ("et 3 de la tubercolose"). Nous pouvons cibler ces
phrases et changer l'ordre des élements pour la maladie apparaisse
avant le décompte :

*Remplacer* `and ([0-9])+ from ([a-z ]+)` *par* `<d>$2</d> <n>$1</n>`
(32 occurrences).

On dirait que nos marqueurs ont désormais encapsulé beaucoup de structures
sémantiques qui nous intéressent. A présent, copions et collons
(`collage spécial` -> `non formaté`) le texte dans LibreOffice Calc
afin de voir à quel point nous nous rapprochons de la structure d'un
tableau. Nous parvenons désormais à séparer les données de localisation
dans des cellules, mais ces cellules ne sont pas encore alignées
verticalement. Nous voulons avoir toutes les références de temps
dans la troisième colonne.

{% include figure.html filename="regex_09_calc_3col.png" caption="Figure 8: Mesurons nos progrès en utilisant LibreOffice Calc" %}

Cela ne pose pas de problème lorsque deux colonnes contiennent des
informations de localisation. Ce sont les lignes avec une seule colonne
pour la localisation qui ont besoin d'être complétées. Pour la plupart,
il s'agit de villes, donc nous avons besoin de déplacer manuellement le
nom de l'état dans la première colonne; Retournez dans la fenêtre de
LibreOffice Writer et :

*Remplacez* `^([A-Za-z .]+\t<t>)` *par* `\t$1` (30 occurrences).

A présent, réglez les cas qui ne contiennent aucune information sur la
localisation, où la localisation est implicitement la même que celle de
la ligne précédente, mais où la période de temps est différente.

*Remplacez* `^<t>` *par* `\t\t<t>` (19 occurrences)

{% include figure.html filename="regex_10_loc_columns.png" caption="Figure 9: Affinage approfondi des résultats" %}

Les premières colonnes devraient avoir meilleure allure si vous les
collez dans Calc. Le texte dans Writer est toujours notre copie de
travail, donc si vous voulez corriger le nom des Etats, il vous faut
le faire dans Writer en supprimant des tabulations (`\t`) avant le nom
de l'Etat et en introduisant un nouveau caractère de tabulation après.
Ou bien vous pouvre attendre que nous en ayons fini avec notre travail
dans Writer, pour corriger ces erreurs dans Calc, une fois que nous
sommes prêts à en faire notre copie de travail directement. Mais nous
n'en sommes pas encore là !

Il nous faut décider comment gérer les listes de maladies. Les lignes
contiennent des listes de longueurs variables. Même s'il serait facile
à ce stade d'introduire un caractère de tabulation pour placer chaque
maladie et le nombre de victimes ou de malades dans des colonnes
différentes, ces colonnent ne seraient pas très pratiques. Les maladies
et les décomptes ne seraient pas alignés. A la place, nous pouvons
plutôt créer de nouvelles lignes pour chaque maladie. Les rapports
distinguent décomptes des victimes et décomptes des malades, qui sont
déjà séparés par "cases:". (Il y a un cas, pour l'Indiana, où le texte
indique cette section avec le terme "Morbidity". Notre motif de recherche
l'a manqué. Vous pouvez réparer le balisage à la main à présent, si vous
le souhaitez, ou bien l'ignorer puisqu'il s'agit ici d'un exercice. C'est
un bon exemple qui montre à quel point les outils d'automatisation ne
constituent pas le seul et unique moyen d'éditer vos source et ne vous
empêchent pas de les regarder. Ce ne sera pas le seul exemple de ce type.)

Nous pouvons commencer en créant une nouvelle ligne pour la liste des cas
("cases"), afin que nous puissions les gérer séparément. De retour dans
LibreOffice Writer :

{% include figure.html filename="regex_11_writer_cases_together_hi.png" caption="Figure 10: Création de nouvelles lignes pour les 'cas'" %}

*Remplacez* `^(.*\t)(.*\t)(<t>.*</t>)(.*)(<c>.*)` *par* `$1$2$3$4\n$1$2$3\t$5`
(47 occurrences).

Remarquez ici que nous utilisons certains des modèles de remplacement
deux fois. Nous ciblons les trois champs jusqu'à la référence temporelle,
puis tout ce qui précède `<c>` dans un quatrième groupe, et enfin tout ce
qui se trouve après `<c>` dans un cinquième. Dans le modèle de remplacement,
nous remettons les groupes 1 à 4 dans l'ordre, puis nous introduisons une
nouvelle ligne et imprimons à nouveau les groupes 1 à 3, suivis d'une
tabulation et du groupe 5. Nous avons ainsi déplacé les listes des cas
sur leurs propres lignes, et avons reproduit mot pour mot les champs
lieu et temps.

Allons plus loin et séparons chaque cas listé pour le mettre dans sa
propre ligne :

*Remplacez* `^(.*\t)(.*\t)(<t>.*</t>)(.*<c>.*)(<d>.*</d>) (<n>.*</n>)`
*par* `$1$2$3$4\n$1$2$3\tCases\t$5$6`

et **répétez** autant de fois que nécessaire jusqu'à ce qu'il n'y ait
plus de remplacement possible (7 itérations).

Maintenant, faisons de même pour séparer les listes de victimes dans
leurs lignes propres :

*Remplacez* `^(.*\t)(.*\t)(<t>.*</t>)(.*<N>.*)(<d>.*</d>) (<n>.*</n>)`
*par* `$1$2$3$4\n$1$2$3\tDeaths\t$5$6`

et **répétez** autant de fois que nécessaire jusqu'à ce qu'il n'y ait
plus de remplacement possible (8 itérations).

Cela se rapproche de plus en plus d'une structure tabulaire, comme vous
pouvez vous en rendre compte si vous collez le texte dans Calc à nouveau.
Encore un peu de patience toutefois : il nous faut encore nettoyer notre
travail avec de très simples motifs de remplacement rapide à utiliser. De
cette manière, le gros du travail aura déjà été fait.

*Remplacez* `.*</c> $` *avec rien*

*Remplacez* `^$` *avec rien*

*Remplacez* `<n>` *par* `\t`

*Remplacez* `</n>` *avec rien*

*Remplacez* `<d>and` *par* `<d>`

*Remplacez* `</?[tdp]>` *avec rien*

{% include figure.html filename="regex_17_writer_done.png" caption="Figure 11: Vue finale dans LibreOffice Writer" %}

Maintenant, copiez et collez tout cela dans Calc, et vous devriez
avoir un tableau relativement bien structuré.

{% include figure.html filename="regex_18_calc_done.png" caption="Figure 12: Vue finale dans LibreOffice Calc" %}

Si ce n'était pas un exercice mais une source que nous éditons
pour une publication ou pour la recherche, il resterait des choses
à régler. Nous n'avons pas traité les chiffres donnés pour les
estimations de population. Notre système de motif n'était pas
assez sophistiqué pour tout gérer. Dans les lignes qui n'avaient
pas de motifs comme "Total number of deaths 292, including", nos
motifs de cherche n'ont pas pu fonctionner s'ils nécessitaient
qu'on ait déjà mis un marquer `</N>`.

## Possibilités pour la suite

Certains de ces problèmes pourraient être résolus par des étapes
supplémentaires de comparaison de motifs, d'autres par une édition
manuelle du document entre certaines étapes de notre travail.
D'autres, encore, supposeraient que l'on modifie en bout de course
les données, une fois qu'elles sont sous une forme tabulaire.

Nous pourrions aussi envisager d'autres structures pour ce tableau.
Par exemple, peut-être que la mortalité ou l'infectiosité seraient
plus faciles à compter si elles se trouvaient dans des colonnes
différentes. Les logiciels de traitement de texte ne sont pas les
meilleurs outils pour utiliser ce genre de structure. Les feuilles
de calcul, XML et les outils programmatiques qui servent à traiter
les données sont bien mieux susceptibles de correspondre à nos
besoins. Mais ces mêmes logiciels ont des fonctionnalités avancées
pour "rechercher & remplacer" qui sont utiles à connaître. Les
expressions régulières et la recherche avancée de motifs sont
très utiles pour l'édition. Elles permettent de construire des
passerelles entre des séquences dont la structure est implicite
et une structure plus explicite que l'on peut vouloir créer ou
cibler.

Il y a plus de 400 rapports de santé publique comme celui-ci, disponibles
en ligne depuis l'Internet Archive. Si vous voulez vous amuser à toutes
les tabuler, LibreOffice n'est pas le meilleur outil de départ. Ce
serait mieux d'apprendre un peu de Python, de Ruby ou de script
avec Shell. Les éditeurs de texte brut orientés pour la programmation,
y compris des classiques comme Emacs et Vi ou Vim, supportent très
bien les expressions régulières ainsi que d'autres paramétrages
utiles pour traiter le texte brut de façon programmatique. Si vous
êtes à l'aise pour ouvrir une ligne de commande de type Unix (sous
Mac ou Linux, ou sous Windows avec une machine virtuelle ou
l'environnement Cygwin), vous pouvez apprendre et très bien
utiliser les expressions régulières avec des outils comme `grep`
pour recherche et `sed` pour le templacement orienté-ligne
(*line-oriented replacing*).

Les expressions régulières peuvent être extrêmement utiles quand on
a affaire à des motifs sur plusieurs centaines de fichiers à la fois.
Les motifs que nous avons utilisés dans cet exemple gagneraient à
être précisés et complétés pour gérer des hypothèses qui seront
certainement erronées lorsqu'elles seront appliquées à des textes
plus longs ou à des ensembles de textes plus larges. Cependant,
avec un langage de programmation, nous pourrions enregistrer ce
que nous faisons sous la forme d'un petit script, l'améliorer et
le réexécuter autant de fois que nécessaire pour nous rapprocher
de nos objectifs.

## Pour en apprendre plus

La page Wikipedia sur les [expressions régulières][] est un endroit
utile pour trouver un bref historique des expressions régulières et
de leur lien avec la théorie du langage formel. Vous y trouverez
aussi un résumé des variations syntaxiques et des efforts de
standardisation formel.

Quel que soit l'outil que vous utilisez, sa documentation est
importante pour les cas pratiques, en particulier pour le
travail dans des environnements de traitement de texte où
les implémentations d'expressions régulières peuvent être
particulièrement idiosyncrasiques. Il existe de nombreuses
ressources disponibles pour apprendre comment utiliser les
expressions régulières dans un contexte de programmation. La
meilleure solution pour vous peut dépendre du langage de
programmation qui vous est le plus familier ou avec lequel
il est le plus pratique de commencer.

Il existe de nombreux éditeurs d'expressions régulières en ligne
gratuitement. [Rubular][], construit à partir de Ruby, dispose
d'une interface très utiles qui vous permet de tester les expressions
régulières sur des échantillons de texte. Il vous montre dynamiquement
les motifs ciblés ou les groupes. David Birnbaum, directeur du
département des langues et littératures slaves de Pittsburg, a de
bons cas de figures sur la manière de travailler avec des
[expressions régulières et des outils pour XML][] - dans le but de
baliser des fichiers de texte brut pour en faire des fichiers XML.

  [lien pour lire en ligne]: http://archive.org/stream/jstor-4560629/4560629#page/n0/mode/2up
  [Texte intégral]: http://archive.org/stream/jstor-4560629/4560629_djvu.txt
  [Liste des expressions régulières]: https://help.libreoffice.org/Common/List_of_Regular_Expressions
  [regular expressions]: http://en.wikipedia.org/wiki/Regular_expressions
  [Rubular]: http://rubular.com/
  [expressions régulières et des outils pour XML]: http://dh.obdurodon.org/regex.html
 
