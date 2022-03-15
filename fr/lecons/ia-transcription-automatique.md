---
title: IA pour la transcription automatisée de documents historiques
collection: lessons  
layout: lesson  
authors:
- Chahan Vidal-Gorène
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/421
slug: ia-transcription-automatique
---

# Table de matières

{% include toc.html %}

# Abstract

Handwritten Text Recognition (HTR) and OCR systems are increasingly more accurate today in all fields, thanks to Artificial Intelligence, especially on Historical Manuscripts and Documents. These systems need clean, large and annotated datasets to be trained efficiently, and to process large databases. Building relevant datasets is a time consuming task, even with dedicated platforms. The tutorial intend to describe good practices for dataset building and models fine-tuning to suit to a specific HTR or OCR project with non-Latin scripts, and to demonstrate 'Minimal Computing' approaches to the analysis of large-scale digital collections of under-resourced languages. We will focus our tutorial on two examples in ancient Greek and Maghrebi Arabic scripts.

# Résumé

Les systèmes de reconnaissance de texte manuscrit (HTR) et OCR atteignent des résultats de plus en plus précis dans tous les domaines, en particulier sur les manuscrits et documents historiques, grâce à l'intelligence artificielle. Ces systèmes ont classiquement besoin d'ensembles de données propres, volumineux et annotés pour être entraînés efficacement et pour traiter de grandes bases de données. Construire des ensembles de données pertinents est une tâche qui prend du temps, même avec l'aide de plateformes dédiées. Le tutoriel a pour but de décrire les bonnes pratiques pour la création d'ensembles de données et la spécialisation des modèles en fonction d'un projet HTR ou OCR spécifique en graphie non latine, et de montrer les approches de "Minimal computing" pour l'analyse de collections numériques à grande échelle pour des langues peu dotées. Notre tutoriel se concentrera sur deux exemples en grec ancien et en écritures arabes maghrébines.

# Cadre d'étude et objectifs de la leçon

Ce tutoriel présente des stratégies et bonnes pratiques pour constituer des données pertinentes et en quantité suffisantes pour reconnaître des textes en graphies généralement peu ciblées dans les projets de reconnaissance de caractères. Le tutoriel est appliqué au traitement d'un imprimé, la Patrologie Greque, et d'un manuscrit de la BULAC en écriture arabe maghrébi. Ces deux exemples sont très spécifiques mais la stratégie globale présentée et les outils / approches introduits sont adaptés au traitement de tout type de document numérisé, en particulier pour des langues peu dotées pour lesquelles une approche reposant sur la masse est difficilement applicable.

### Note au sujet de la Patrologie Grecque

La Patrologie grecque (PG) est une collection de réimpressions de textes patristiques, théologiques et historiographiques publiée à Paris par Jacques Paul Migne (1800-1875) entre 1857 et 1866. Certains des textes, bien que toujours pertinents scientifiquement, n'ont pas été réédités et ne sont pas disponibles dans le [Thesaurus Linguae Graecae (TLG)](http://stephanus.tlg.uci.edu). Dans le cadre du projet CGPG porté par Jean-Marie Auwers et Véronique Saumers (UCLouvain), en collaboration avec [GRE*g*ORI](https://www.gregoriproject.com) et [Calfa](https://calfa.fr), la création de modèles d'analyse de la PG a pour but de rendre disponibles et d'augmenter ces textes, dans un format interopérable, via des approches automatiques d'OCR et d'analyse de texte.

{% include figure.html filename="figure0_PG_125_625-626.jpg" caption="Figure 0 : Texte de la Patrologie Grecque (PG125, colonnes 625-626 et 1103-1104)" %}

{% include figure.html filename="figure0_PG_125_1103-1104.jpg" caption="Figure 0 : Texte de la Patrologie Grecque (PG125, colonnes 625-626 et 1103-1104)" %}

# Introduction

La transcription automatique de documents imprimés par un OCR (Optical Character Recognition) ou manuscrits par un HTR (Handwritten Text Recognition) est désormais une étape classique des projets d'humanités numériques ou de valorisation des collections au sein de bibliothèques numériques. Celle-ci s'inscrit dans une large dynamique internationale de numérisation des documents, facilitée par le framework IIIF[^1] qui permet l'échange, la comparaison et l'étude d'images au travers d'un unique protocole mis en place entre les bibliothèques et interfaces compatibles. Si cette dynamique donne un accès privilégié et instantané à des fonds jusqu'ici en accès restreint, la masse de données bouleverse les approches que nous pouvons avoir des documents textuels. Traiter cette masse manuellement est difficilement envisageable, et c'est la raison pour laquelle de nombreuses approches en humanités numériques ont vu le jour ces dernières années : outre la reconnaissance de caractères, peuvent s'envisager à grande échelle la reconnaissance de motifs enluminés[^2], la classification automatique de page de manuscrits[^3] ou encore des tâches codicologiques telles que l'identification d'une main, la datation d'un manuscrit ou son origine de production[^4], pour ne mentionner que les exemples les plus évidents. En reconnaissance de caractères comme en philologie computationelle, de nombreuses approches et méthodologies produisent des résultats déjà très exploitables, sous réserve de disposer de données de qualité pour entraîner les systèmes.

Aujourd'hui, il est certes possible d'entraîner des réseaux de neurones pour analyser une mise en page très spécifique ou traiter un ensemble de documents très particulier. Cependant, pour être efficaces et robustes, ces réseaux de neurones doivent être entraînés avec de grands ensembles de données. Il faut donc annoter, souvent manuellement, des documents similaires à ceux que l'on souhaite reconnaître (ce que nous appellons classiquement la création de "[vérité terrain](https://en.wikipedia.org/wiki/Ground_truth)").
Annoter manuellement des documents, choisir une architecture neuronale adaptée à son besoin, et suivre/évaluer l'apprentissage d'un réseau de neurones pour créer un modèle pertinent, etc., sont des activités coûteuses et chronophages, qui nécessitent souvent des investissements et une expérience en machine learning, conditions peu adaptées à un traitement massif et rapide de documents. L'intelligence artificielle est donc une approche qui en nécessite intrinsèquement un volume important, qu'il n'est pas toujous aisé de constituer malgré la multiplicité des plateformes dédiées (voir *infra*). D'autres stratégies doivent donc être mises en place, en particulier dans le cas des langues dites peu dotées.
En effet, si la masse critique de données pour du traitement de manuscrits ou documents imprimés en graphies latines semble pouvoir être atteinte[^5], avec une variété de graphies, polices d'écritures et mises en pages représentées et représentatives des besoins classiques en HTR / OCR des institutions, cela est beaucoup moins évident pour les autres alphabets. Nous nous retrouvons donc dans la situation où des institutions patrimoniales numérisent et rendent disponibles des copies numériques des documents, mais où ces derniers restent "dormants" car pas ou peu interrogeables par des sytèmes automatiques (p. ex: de nombreuses institutions comme la Bibliothèque nationale de France (BnF), au travers de leur interface [Gallica]( https://gallica.bnf.fr), proposent des versions textes des documents en vue de permettre la recherche en plein texte, et donc indisponible pour des documents en arabe par exemple).

Aujourd'hui, une langue ou une graphie peut être considérée comme peu dotée encore à plusieurs niveaux :

* un manque de disponibilité ou d'existance des données : il s'agit du point le plus évident, de nombreuses graphies ne sont tout simplement pas représentées numériquement (au sens de données exploitables), même si des réseaux institutionnels se forment pour intégrer ces langues dans cette transition numérique[^6] ;

* une trop grande spécialisation d'un dataset : *a contrario*, s'il peut exister des données pour une langue ciblée, celles-ci peuvent être trop spécialisées sur l'objectif poursuivi par l'équipe qui les ont produites (p. ex: modernisation de l'orthographe d'une graphie ancienne, ou encore utilisation d'une notion de ligne spécifique), limitant sa reproductibilité et son exploitation dans un nouveau projet ;

* un nombre potentiellement réduit de spécialistes en mesure de transcrire et annoter des données rapidement. Si des initiatives de *crowdsourcing* sont souvent mises en place pour les graphies latines[^7], elles sont plus difficilement applicables pour des écritures anciennes qui nécessitent une haute expertise, souvent paléographiques, limitant considérablement le nombre de personnes pouvant produire les données ;

* une sur-spécialisation des technologies existantes pour les graphies latines, résultant en des approches moins adaptées pour d'autres graphies ;

* une sur-spécialisation des modèles disponibles : il s'agit du pendant au dataset sur-spécialisé, s'il peut exister des modèles gratuits et ouverts (voir *infra*) pour une langue ou un document, celui-ci peut ne pas convenir aux besoins du nouveau projet ;

* la nécessité de disposer de connaissances en apprentissage machine pour exploiter au mieux les outils de reconnaissance automatique des écritures proposés actuellement.

{% include figure.html filename="figure1_composantes.png" caption="Figure 1 : les trois composantes du traitement d'une langue peu dotée" %}

Rien d'insurmontable pour autant. Si le pipeline classique qui consiste donc à apporter *massivement* des *données* (manuellement) *annotées* à une *architecture* neuronale (IA) s'avère manifestement peu adapté au traitement de certaines langues, plusieurs plateformes ont été implémentées pour démocratiser l'accès aux OCR et HTR ces dernières années. Chacune d'elle essaie de jongler avec les trois composantes de la Figure 1, en intégrant par exemple des modèles pré-entraînés pour avancer le travail de transcription[^8]. La plus connue est Transkribus (READ-COOP), utilisée sur un très large spectre de langues, graphies et types de documents. Il existe également des plateformes institutionnelles comme eScriptorium (Université PSL) dédiée aux documents historiques, et OCR4all (Université de Wurtzbourg) particulièrement adaptée aux documents imprimés anciens, ou privées comme [Calfa Vision](https://vision.calfa.fr) (Calfa), plateforme qui ajoute la spécificité de la multi-architecturalité et du fine-tuning itératif pour surmonter les écueils mentionnés pour le traitement de graphies peu dotées, à partir de petits échantillons[^9].

```
<div class="alert alert-warning">
Dans la suite du tutoriel, c'est cette dernière plateforme que nous utiliserons, notamment car elle a été spécifiquement construite pour surmonter les problèmes liés aux documents et graphies peu dotés, qui est notre cible du jour. Néanmoins, l'intégralité du tutoriel et le type d'annotation choisi ici s'applique et est compatible avec les autres plateformes mentionnées.
</div>
```

L'objectif méthodologique est de tirer profit des fonctionnalités de spécialisation de la plateforme d'annotation [Calfa Vision](https://vision.calfa.fr) (le fine-tuning itératif ou spécialisation itérative) et des choix entre les différentes architectures neuronales pour minimiser l'investissement en données, sans expertise particulière en Machine Learning pour évaluer les modèles (voir *infra*). **L'enjeu est donc de surmonter l'ecueil du manque de données par des stratégies de fine-tuning et de définition des besoins.**

# Des données oui, mais pour quoi faire ?

La reconnaissance automatique des écritures n'est possible qu'en associant l'expertise humaine à la capacité de calcul de l'ordinateur. Un important travail scientifique reste donc à notre charge pour définir les objectifs et les sorties d'une transcription automatique. Plusieurs questions se posent donc au moment de se lancer dans l'annotation de nos documents :

1. Créer des données : quel volume possible, pour quels *besoins*, quel public et quelle compatibilité ?
2. Créateur de données : par qui et dans quelle temporalité ?
3. Approche massive et généraliste vs approche spécialisée

Notre objectif est ici de réussir à transcrire automatiquement un ensemble homogène de documents, tout en minimisant l'investissement humain pour la création de modèles. Nous souhaitons donc créer un modèle spécialisé (et non généraliste) pour surmonter les spécificités de notre document. Les spécificités peuvent être de plusieurs ordres et peuvent justifier la création d'un modèle spécialisé : main ou font nouvelle, état variable de conservation du document, mise en page inédite, besoin d'un contenu spécifique, etc.

## Pipeline classique d'un OCR / HTR

Le travail d'un OCR ou d'un HTR se décompose en plusieurs étapes : analyse et compréhension d'une mise en page, reconnaissance du texte, et formatage du résultat. La figure 2 reprend l'essentiel des tâches classiquement présentes et sur lesquelles un utilisateur ou une utilisatrice a la main pour adapter un modèle à son besoin. L'intégralité de ces fonctionnalités est entrainable sur la plateforme Calfa Vision, ce qui nous assure un contrôle complet du pipeline de reconnaissance.

{% include figure.html filename="figure_2_pipeline-htr.jpeg" caption="Figure 2 : pipeline classique d'un traitement OCR / HTR. Les étapes 2 et 3 sont spécialisables aux besoins d'un projet, et l'étape 3 intègre des approches spécifiques à une langue / graphie pour maximiser les résultats en minimisant l'investissement." %}

La figure 2 met en évidence l'un des grands oubliés de la reconnaissance de caractères : l'analyse de la mise en page, qui peut être spécialisée pour ne reconnaître qu'une ou plusieurs régions d'intérêt dans le document et concentrer l'extraction des lignes dans ces régions. La construction d'un modèle d'analyse de la mise en page performant est un des enjeux majeurs pour le traitement de nouvelles collections (voir *infra*).

## Définition des besoins

En effet, si aujourd'hui nous pouvons tout à fait considérer la reconnaissance de caractères comme un problème largement résolu pour les graphies latines, ou les documents unilingues, et une mise en page simple, avec des taux d'erreur inférieurs à 2%[^10], le résultat final peut ne pas être exploitable du tout.

{% include figure.html filename="figure3_CER-layout.png" caption="Figure 3 : Reconnaissance de texte vs reconnaissance de caractères" %}

La Figure 3 met en lumière ce phénomène : en entraînant une architecture de reconnaissance spécialisée sur les caractères, nous obtenons ici un CER (Character Error Rate) de 0%, soit une reconnaissance parfaite. En revanche : 

1. la mise en page par colonnes n'ayant pas été correctement détectée, nous nous retrouvons avec un seul bloc de texte ;
2. la *scriptio continua* du manuscrit, bien respectée par l'HTR, aboutit à un texte dépourvu d'espace difficilement accessible pour l'être humain ;
3. le texte, en arménien classique, comporte un grand nombre d'**abréviations** qui ne sont pas développées dans le résultat final. Si le texte produit correspond donc bien à l'image du manuscrit, la recherche en plein texte s'en retrouve extrêmement limitée.

Avant toute entreprise de transcription automatique, il convient donc de définir les attendus des modèles : mise en page à prendre en compte, zones d'intérêts, cahier des charges de la transcription, format des données, etc.

### Zones d'intérêts

Dans le cadre du traitement de la Patrologie Grecque, nous ne sommes intéressés que par le texte grec des PDF à notre disposition (en rouge dans la Figure 4). Malheureusement, nous sommes confrontés à une mise en page relativement dense et complexe, avec une alternance de colonnes en grec et en latin, des textes parfois à cheval sur les deux colonnes (ici en bleu), des titres courants, des notes de bas de page ainsi que des repères de paragraphes.

{% include figure.html filename="figure4_PG_123_359-360.jpg" caption="Figure 4 : Zones d'intérêts dans la Patrologie Grecque %}

{% include figure.html filename="figure4_PG_125_625-626.jpg" caption="Figure 4 : Zones d'intérêts dans la Patrologie Grecque %}

Cette mise en page ne poserait pas de problème majeur si nous ne nous intéressions pas à la question de la discrimination des zones de texte. Nous ne sommes néanmoins pas concernés par le texte latin et souhaitons obtenir un résultat aussi propre que possible, sans mélange des langues ou confusion probable dans le modèle. Nous identifions donc ici un besoin d'un **modèle de mise en page** spécialisé.

### Choix de transcription et encodage

Nous sommes tout à fait libre de choisir une transcription qui ne corresponde pas tout à fait au contenu de l'image. Des expérimentations sur le latin manuscrit ont par exemple montré que des architectures de reconnaissance word-based, comme celles intégrées sur Calfa Vision, réussissent à développer des formes abrégées avec un taux d'erreur inférieur à 3%[^11]. 

Ici, nous travaillons avec du grec ancien, comportant de nombreuses diacritiques.

<div class="table-wrapper" markdown="block">

| code   | char | name                            |
|--------|------|---------------------------------|
| U+0300 | ◦̀    | COMBINING GRAVE ACCENT          |
| U+0301 | ◦́    | COMBINING ACUTE ACCENT          |
| U+0304 | ◦̄    | COMBINING MACRON                |
| U+0306 | ◦̆    | COMBINING BREVE                 |
| U+0308 | ◦̈    | COMBINING DIAERESIS             |
| U+0313 | ◦̓    | COMBINING COMMA ABOVE           |
| U+0314 | ◦̔    | COMBINING REVERSED COMMA ABOVE  |
| U+0342 | ◦͂    | COMBINING GREEK PERISPOMENI     |
| U+0343 | ◦̓    | COMBINING GREEK KORONIS         |
| U+0344 | ◦̈́    | COMBINING GREEK DIALYTIKA TONOS |
| U+0345 | ◦ͅ    | COMBINING GREEK YPOGEGRAMMENI   |

</div>

Tableau 1: Exemple de diacritiques rencontrés en grec

Conséquence : selon la normalisation unicode considérée, un caractère grec peut avoir plusieurs valeurs différentes, ce dont on peut se convaincre très facilement en python.

```python
char1 = "ᾧ"
char1
>>> ᾧ

len(char1)
>>> 1

char2 = "\u03C9\u0314\u0342\u0345" #Le même caractère mais avec les diacritiques explicitement décrits en unicode.
char2
>>> ᾧ

len(char2)
>>> 4

char1 == char2
>>> False
```

Dès lors, le problème de reconnaissance de caractères n'est plus le même selon la normalisation appliquée. Dans un cas, nous n'aurons qu'une seule classe à reconnaître, le caractère unicode ᾧ, tandis que dans l'autre nous devrons en reconnaître quatre. Il existe plusieurs types de normalisation unicode : NFC, NFD, NFKC et NFKD, dont on peut voir les effets avec le code ci-dessous :

```python
from unicodedata import normalize

len(normalize("NFC", char1))
>>> 1

len(normalize("NFD", char1))
>>> 4

len(normalize("NFC", char2))
>>> 1

normalize("NFC", char1) == normalize("NFC", char2)
>>> True
```

Dans notre exemple, il apparaît que la normalisation NFC (et NFKC) permet de recombiner un caractère en un seul caractère unicode, tandis que la normalisation NFD (et NFKD) réalise la décomposition inverse[^12]. L'avantage de ces dernières normalisation est de regrouper toutes les matérialisations d'une lettre sous un seul sigle afin de traiter la variété seulement au niveau des diacritiques.

Et donc, quelle normalisation choisir ici ?

Au-delà de l'aspect technique sur un caractère isolé, l'approche du problème est sensiblement différente selon le choix.

```python
phrase = "ἀδιαίρετος καὶ ἀσχημάτιστος. Συνάπτεται δὲ ἀσυγ-"
len(normalize("NFC", phrase))
>>> 48
len(normalize("NFD", phrase))
>>> 56
```

Les impressions de la Patrologie Grecque présentent une qualité très variable, allant de caractères lisibles à des caractères pratiquement entièrement effacés ou *a contrario* très empâtés (voir Figure 5). Il y a également présence de bruit résiduel, parfois ambigu avec les diacritiques ou ponctuations du grec.

{% include figure.html filename="figure5_exemples-PG.png" caption="Figure 5 : Exemples d'impression de la PG" %}

Envisager une normalisation NFD ou NFKD permettrait de regrouper chaque caractère sous une méta-classe (p. ex.: α pour ά ᾶ ὰ) et ainsi lisser la grande variété dans la qualité des images. Il nous semble toutefois ambitieux de vouloir envisager de reconnaître chaque diacritique séparemment, au regard de la grande difficulté à les distinguer ne serait-ce que par nous même. Nous choisissons donc une normalisation de type NFC, qui aura donc pour conséquence de démultiplier le nombre de classes. Ce choix entraînera peut-être la nécessité de transcrire davantage de lignes.
Par ailleurs, nous ne sommes pas intéressés par les appels de notes présents dans le texte (voir Figure 5), et ceux-ci ne sont donc pas présents dans la transcription, ce qui créera une ambiguité supplémentaire dans le modèle OCR. Nous identifions donc ici un besoin d'un **modèle d'OCR** spécialisé.

```
<div class="alert alert-warning">
Par défaut, Calfa Vision va procéder au choix de normalisation le plus adapté au regard du jeu de données fourni, afin de simplifier la tâche de reconnaissance, sans qu'il soit nécessaire d'intervenir manuellement. La normalisation est toutefois paramétable avant ou après le chargement des données sur la plateforme.
</div>
```

### Approches architecturales et compatibilité des données

À ce stade, nous avons identifié deux besoins qui conditionnent la qualité escomptée des modèles, le travail d'annotation et les résultats attendus. En termes d'OCR du grec ancien, nous ne partons pas non plus tout à fait de zéro puisqu'il existe déjà des images qui ont été transcrites et rendues disponibles[^13], pour un total de 5100 lignes. Un dataset plus récent, ```GT4HistComment```[^14], est également disponible, avec des imprimés de 1835-1894 et des mises en pages plus proches de la PG. Le format de données est le même que pour les datasets précédents (voir *infra*). Nous ne retenons pas ce dataset en raison du mélange d'alphabets présent dans la vérité terrain (voir tableau 2).

<div class="table-wrapper" markdown="block">

| Source   | Data |
|--------|------|
| greek-cursive | ![line-greek_cursive](assets/cursive/000005.png) |
| GT | Αλῶς ἡμῖν καὶ σοφῶς ἡ προηγησαμένη γλῶσσα τοῦ σταυροῦ τὰς ἀκτῖ- |
| gaza-iliad | ![line-gaza-iliad](assets/gaza/000014.png) |
| GT | Τρῳσὶ, ποτὲ δὲ παρὰ τὸν Σιμοῦντα ποταμὸν, τρέχων |
| voulgaris-aeneid | ![line-voulgaris-aeneid](assets/voulgaris/000007.png) |
| GT | θὺς συνεῤῥύη ἀνδρῶντε καὶ γυναικῶν τῶν ὁμοπατρίων, καὶ ἄλ- |
| GT4HistComment | ![line-voulgaris-aeneid](assets/gtcommantaries/cu31924087948174_0063_70.png) |
| GT | νώπαν θυμόν), yet αἴθων, which directly |

</div>

Tableau 2: Exemples de vérités terrain disponibles pour le grec ancien

Les données du tableau 2 montrent une nette différence de qualité et de police entre ces données et la Patrologie Grecque. L'intégration et l'évaluation de ces données sur Calfa Vision donnent un modèle avec un taux d'erreur de 2,24%[^15], qui servira de base de spécialisation pour le modèle de Patrologie Grecque. Néanmoins, il s'avère indispensable d'envisager un modèle spécialisé sur la PG afin de gérer les difficultés mises en évidence en figure 5.

Les données sont disponibles dans le format originellement proposé par Ocropus[^16], c'est à dire une paire composée d'une image de ligne et de sa transcription (voir tableau 2).

```
├── dataset
│   ├── 000001.gt.txt
│   ├── 000001.png
│   ├── 000002.gt.txt
│   ├── 000002.png
│   ├── 000003.gt.txt
│   └── 000003.png
```

Il s'agit d'un format ancien, la ligne de texte étant contenue dans une bouding-box parfaitement adaptée aux documents sans courbure, ce qui n'est pas tout à fait le cas de la Patrologie Grecque, dont les scans sont parfois courbés sur les tranches (voir figure 6). Ces données ne permettront pas non plus d'entraîner un modèle d'analyse de la mise en page.

{% include figure.html filename="figure6_PG_123_202.jpg" caption="Figure 6 : Gestion de la courbure des lignes sur Calfa Vision" %}

Une approche par baselines (en rouge sur la figure 6) est ici justifiée puisqu'elle permet de prendre en compte cette courbure, afin d'extraire la ligne de texte avec un polygone encadrant (en bleu sur la figure 6) et non plus une bouding-box. Cette fois-ci les données ne sont plus exportées explicitement en tant que fichiers de lignes, mais l'information est contenue dans un XML contenant les coordonnées de chaque ligne.

Le mélange des formats aboutit en général, dans les OCR disponibles, à une perte de qualité. Il est néanmoins possible de les combiner sur Calfa Vision afin d'extraire non pas un polygone mais une bouding-box à partir de la baseline. Cette fonctionnalité a été mise en place pour précisemment convertir des datasets habituellement incompatibles pour exploiter des données plus anciennes et assurer une continuité dans la création de données[^17].

**Et maintenant ?**

En résumé, à l'issue de cette étape de description des besoins, il en résulte que :

1. **zones de texte** : Nous souhaitons concentrer la détection et la reconnaissance du texte sur les colonnes principales en grec, en excluant le texte latin, les titres courants, les notes inter-colonnes, l'apparat critique et toute note marginale.
2. **lignes de texte** : Nous avons à prendre en compte des lignes courbes et choisissons donc une approche par baseline.
3. **modèle de base** : Un modèle de base est disponible mais entraîné avec des données plus anciennes. Nous utiliserons une approche combinant baseline et bouding-box pour tirer profit au maximum des données existantes.
4. **choix de transcription** : Nous partons sur une transcription avec normalisation de type NFC, sans intégrer les signes d'éditeur éventuels et les appels de note. La complexité offerte par la PG laisse supposer qu'un jeu de données important devra être produit. Nous verrons en partie suivante comment limiter les données nécessaires en considérant une architecture dédiée et non générique.

```
<div class="alert alert-warning">
À ce stade, nous avons donc clairement identifié les besoins de notre projet OCR : afin de traiter efficacement l'intégralité des pdfs de la PG non encore disponibles, nous devons créer un modèle de mise en page spécialisé et un modèle OCR propre à nos contraintes éditoriales.
</div>
```

# Création des modèles et traitement de la PG

## Méthodologie technique

La plateforme Calfa Vision est une plateforme qui intègre un grand nombre de modèles pré-entraînés pour différentes tâches manuscrites et imprimées, dans plusieurs graphies non latines[^18] : détection et classification de zones de textes, détection et extraction des lignes, reconnaissance de texte (arménien, géorgien, syriaque, graphies arabes, grec ancien, etc.)[^19]. Le travail d'annotation et de transcription peuvent être menés en collaboration avec plusieurs membres d'une équipe et elle prend en charge différents types de formats.

Ces modèles, en mesure de traiter un large spectre non exhaustif de documents, peuvent ne pas être parfaitement adaptés à notre chantier d'annotation de la PG. En revanche, la plateforme repose sur la spécialisation (ou *fine-tuning*) itératif de ses modèles en fonction des annotations des utilisateurs et utilisatrices. Ainsi, partant par exemple d'un modèle de base pour la mise en page, nos relectures et précisions vont progressivement être intégrées dans le modèle afin de correspondre aux besoins de notre projet. Les différentes plateformes mentionnées précedemment intègrent des approches plus ou moins similaires et automatiques pour la spécialisation de leurs modèles, le lecteur ou la lectrice pourra donc réaliser un travail approchant sur ces plateformes. Celle utilisée dans ce tutoriel a l'avantage de limiter l'engagement de l'utilisateur et de l'utilisatrice à l'analyse de ses besoins.

{% include figure.html filename="figure7_defaultLayout.jpeg" caption="Figure 7 : Calfa Vision - Analyse automatique de la mise en page sur deux exemples de la PG. En haut, le modèle détecte bien les multiples zones de texte (sans distinction) et l'ordre de lecture est le bon. En bas, la compréhension du document n'est pas satisfaisante et a entraîné une fusion des différences colonnes et lignes." %}

Nous observons sur la figure 7 que le modèle pré-entraîné du type de projets ```Printed Documents``` de la plateforme propose des résultats allant de très satisfaisant (en haut) à plus mitigés (en bas). Outre la mise sur le même plan de tous les types de régions (catégorisées en ```paragraph```), le modèle ne réussit pas toujours à comprendre la disposition en colonne. En revanche, malgré une fusion de toutes les lignes dans le second cas, l'ensemble des zones et des lignes est correctement détecté, il n'y a pas d'informations perdues. Nous pouvons donc supposer que la spécialisation à notre tâche du modèle sera rapide.

**Quelles annotations de mise en page réaliser** : Pour les pages où l'analyse de la mise est satisfaisante, nous devons préciser à quel type chaque zone de texte correspond, en précisant ce qui relève d'un texte en grec (en rouge sur la figure 4) et ce qui relève d'un texte en latin (en bleu sur la figure 4) et supprimer tout autre contenu jugé inutile dans notre traitement (p. ex.: notes de bas de pages sur le premier exemple de la figure 7).
Pour les pages non satisfaisantes, nous devrons corriger les annotations erronées.

Au niveau de la transcription du texte, le modèle construit précédemment donne un taux d'erreur au niveau du caractère de 68,13% sur la PG, autrement dit il est inexploitable en l'état au regard de la grande différence qui existe entre les données d'entraînement et les documents ciblés. Nous nous retrouvons bien dans un scénario de graphie peu dotée en raison de l'extrême particularité des impressions de la PG.
Au regard des difficultés identifiées en Figure 5 et de la grande dégradation du document, une architecture au caractère pourrait ne pas être la plus adaptée. Nous pouvons supposer l'existence d'un vocabulaire récurrent, au moins à l'échelle d'un volume de la PG. Le problème de reconnaissance pourrait ainsi être simplifié avec un apprentissage au mot plutôt qu'au caractère. Il existe une grande variété d'architectures neuronales qui sont implémentées dans les diverses plateformes de l'état de l'art[^20]. Elles présentent toutes leurs avantages et inconvénients en terme de polyvalence et volume de données nécessaires. Néanmoins, une architecture unique pour tout type de problème peut conduire à un investissement beaucoup plus important que nécessaire dans le meilleur des cas. Dans ce contexte, la plateforme que nous utilisons opère un choix entre des architectures au caractère ou au mot, afin de simplifier la reconnaissance en donnant un poids plus important au contexte d'apparition du caractère et du mot. Il s'agit d'une approche qui a montré de bons résultats pour la lecture des abréviations du latin (i.e. à une forme graphique abrégée dans un manuscrit on transcrit un mot entier)[^21] ou la reconnaissance de graphies arabes maghrébines (i.e. gestion d'un vocabulaire avec diacritiques ambigus et ligatures importantes)[^22].

```
<div class="alert alert-warning">
Le modèle d'analyse de la mise en page semble donc aisément fine-tunable. La reconnaissance de texte, malgré un modèle de grec déjà disponible, s'annonce plus compliquée. Un nouveau choix architectural s'avèrera peut-être pertinent.
</div>
```

### Quel volume de données

Il est très difficile d'anticiper le nombre de données nécessaire pour la spécialisation des modèles. Une évaluation de la plateforme montre une adaptation pertinente de l'analyse de la mise en page et de la classification des zones de texte dès 50 pages pour des mises en page complexes sur des manuscrits arabes[^23]. Le problème est ici plus simple (moins de variabilité du contenu). Pour la détection des lignes, l'ordre de grandeur descend à 25 pages[^24]. Il n'est toutefois pas nécessaire d'attendre d'atteindre ces seuils pour mesurer le gain dans l'analyse et la détection.

Au niveau de la transcription, l'état de l'art met en évidence un besoin minimal de 2000 lignes pour entraîner un modèle OCR / HTR[^25], ce qui peut correspondre à une moyenne entre 75 et 100 pages.

```
<div class="alert alert-warning">
Ströbel et al. montrent par ailleurs qu'au-delà de 100 pages il n'existe pas de grande différence entre les modèles pour un problème spécifique donné. L'important n'est donc pas de miser sur un gros volume de données, mais au contraire concentrer l'attention sur la qualité des données produites et leur adéquation avec l'objectif recherché.
</div>
```

Toutefois, ces volumes correspondent aux besoins de modèles entraînés de zéro. Dans un cas de fine-tuning, les volumes sont bien inférieurs. Via la plateforme Calfa Vision, nous avons montré une réduction de 2,2% du CER pour de l'arménien manuscrit[^26] avec seulement trois pages transcrites, passant de 5,42% à 3,22% pour un nouveau cahier des charges de transcription, ou encore un CER de 9,17% atteint après 20 pages transcrites en arabe maghrebi pour un nouveau modèle (gain de 90,83%)[^27].

Les dernières expériences montrent en général une spécialisation pertinente des modèles après seulement 10 pages transcrites.
En règle général, une bonne stratégie consiste à concentrer l'attention sur les pages les plus problématiques, et l'objectif de ces plateformes d'annotation consiste donc à permettre leur rapide correction.

## Étapes d'annotation

*Nous avons construit un premier dataset composé de 30 pages représentatives de différents volumes de la PG. Ces 30 pages nous servent d'ensemble de test pour évaluer précisément les modèles tout au long de l'annotation. Les annotations produites dans la suite de cette partie constituent l'ensemble d'apprentissage.*

*Gestion du projet d'annotation:*

Après avoir créé un projet Patrologia Graeca de type ```Printed Documents``` (v. 2022/01), nous ajoutons les documents que nous souhaitons annoter au niveau de la mise en page et du texte. L'import peut être réalisé au format image, avec un manifest IIIF ou, dans notre cas, en important un fichier PDF. La figure 8 montre l'interface utilisateur avec les images en attente d'annotation.

{% include figure.html filename="figure8_projet.jpg" caption="Figure 8 : Calfa Vision - Liste des images d'un projet de transcription" %}

Nous disposons de plusieurs actions pour réaliser des analyses automatiques de nos documents :
1. ```Layout Analysis```, qui va détecter et classifier des zones et lignes de texte ;
2. ```Generate Lines```, qui va extraire des lignes détectées la ligne entière à transcrire (détection de la bouding-box ou du polygone encadrant, sous réserve de lignes détectées) ;
3. ```Text Recognition```, qui va procéder à la reconnaissance des lignes détectées et extraites.

Les trois étapes sont dissociées afin de laisser à l'utilisateur et à l'utilisatrice le contrôle complet du pipeline de reconnaissance, avec notamment la possibilité de corriger toute prédiction incomplète ou erronée. Nous procédons à ce stade à l'analyse de la mise en page, massivement sur l'ensemble des images du projet.

*Annotation de la mise en page:*

En accédant à l'inteface d'annotation, les prédictions sont prêtes à être relues. Nous avons trois niveaux d'annotation dans le cadre de ce projet :

```
├── La région de texte (en vert), avec un type associé ;
│   └── La ligne de texte, composée :
|       ├── d'une baseline (en rouge)
|       └── d'un polygone ou d'une bouding-box (en bleu)
|           └── La transcription.
```

{% include figure.html filename="figure9_layout2.jpg" caption="Figure 9 : Calfa Vision - Interface d'annotation et mise en page" %}

Il n'est pas nécessaire de pré-traiter les images et d'en réaliser une quelconque amélioration (redressement, nettoyage, etc.).

Chaque objet (région, ligne et texte) peut être manuellement modifié, déplacé, supprimé, etc. en fonction de l'objectif poursuivi. Ici, nous nous assurons de ne conserver que les zones que nous souhaitons reconnaître, à savoir ```col_greek``` et ```col_latin``` auxquelles nous ajoutons cette information sémantique. C'est l'occasion également de contrôler que les lignes ont bien été détectées, notamment pour les pages qui posent problème (voir Figure 7).

Nous réalisons ce contrôle sur 10, 30 et 50 pages pour mesurer l'impact sur la détection de ces régions de texte.

<div class="table-wrapper" markdown="block">

| meanIU    | 0 image | 10 images | 30 images | 50 images |
|-----------|---------|-----------|-----------|-----------|
| Paragraph | 0.94    | -         | -         | -         |
| Col_greek | -       | 0.86      | 0.91      | 0.95      |
| Col_latin | -       | 0.78      | 0.88      | 0.93      |

</div>

Tableau 3: Évolution de la distinction des colonnes latines et grecques

Nous observons dans le tableau 3 que la distinction des zones de texte s'opère correctement dès 10 images annotées (au niveau des régions). Dès 50 images, le modèle classifie à 95% les colonnes grecques et à 93% les colonnes latines. Les erreurs sont localisées sur les textes traversants, et sur la détection superfétatoire de notes de bas de page, respectivement en grec et en latin. Pour ce dernier cas de figure, il ne s'agit donc pas à proprement parlé d'erreurs, même si cela entraîne un contenu non souhaité dans le résultat.
Avec ce nouveau modèle, l'annotation de la mise en page est donc beaucoup plus rapide. La correction progressive de nouvelles images permettra de surmonter les erreurs observées.

<div class="table-wrapper" markdown="block">

|           | F1-score |
|-----------|----------|
| 0 image   |  0.976        |
| 10 images |  0.982   |
| 30 images |  0.981   |
| 50 images |  0.981   |

</div>

Tableau 4: Évolution de la détection des baselines[^28]

Concernant la détection des lignes, 10 images suffisent à largement contenir le problème de la détection des colonnes, observé en figure 7. L'absence d'annotation des notes de base de page conduit en particulier à créer une ambiguité dans le modèle, d'où la stagnation des scores obtenus, pour lesquels on observe une précision "basse" (toutes les lignes détectées) mais un rappel élevé (toutes les lignes souhaitées détectées). En revanche, cela n'a pas d'incidence pour le traitement des pages pour la suite, puisque seul le contenu des régions ciblées est pris en compte.

*Annotation du texte:*

{% include figure.html filename="figure10_text.jpg" caption="Figure 10 : Calfa Vision - Transcription du texte" %}

La transcription est réalisée ligne à ligne pour correspondre à la vérité terrain dont nous disposons déjà (voir *supra*). Cette transcription peut être réalisée soit entièrement manuellement, soit être assistée par l'OCR intégré (voir note XX), soit provenir d'une transcription existante et importée. Les lignes 1 et 7 mettent en évidence l'absence de transcription des chiffres dans cet exercice. Les données sont exportées dans un format compatible avec les données précédentes (paire image-texte), sans distorsion des images.

Nous allons donc ici transcrire une, puis deux, puis cinq et enfin dix images, en profitant itérativement d'un nouveau modèle de transcription automatique.

<div class="table-wrapper" markdown="block">

|         | 0     | 1     | 2    | 5    | 10   |
|---------|-------|-------|------|------|------|
| CER (%) | 68,13 | 38,45 | 6,97 | 5,42 | 4,19 |

</div>

Tableau 5: Évolution du CER en fonction du nombre d'images transcrites

Deux images suffisent à obtenir un CER inférieur à 7% et une transcription automatique exploitable. Le modèle n'est bien sûr pas encore très polyvalent à toute la variété de la PG mais la transcription de nouvelles pages s'en trouve très accélérée. Dans les simulations réalisées à plus grande échelle, en conservant cette approche itérative, nous aboutissons à un CER de 1,1% après 50 pages transcrites.

{% include figure.html filename="figure11_PG-result.jpeg" caption="Figure 11 : Résultat final sur la Patrologie Grecque" %}

### Et pour le manuscrit ?

La transcription de documents manuscrits (manuscrits anciens, archives modernes, etc.) répond tout à fait la même logique et aux mêmes enjeux : partir de modèles existants, que l'on va spécialiser aux besoins d'un objectif, selon un certain cahier des charges.

La plateforme a ainsi été éprouvée sur un nouvel ensemble graphique, celui des écritures maghrébines, écritures arabes qui représentent classiquement un écueil majeur pour les HTR. L'approche itérative qui a été appliquée a permis d'aboutir à la transcription de 300 images, constituant le dataset RASAM[^29], sous la supervision du GIS MOMM, de la BULAC et Calfa. En partant de zéro pour les écritures maghrebines, cette approche de spécialisation à l'aide d'une interface de transcription comme celle présentée dans ce tutoriel a démontré sa pertinence, en réduisant le temps nécessaire à la transcription de plus de 42% en moyenne (voir figure 12).

{% include figure.html filename="figure12_time_saved_transcription.png" caption="Figure 12 : RASAM Dataset, Springer 2021 - Evolution du CER et du temps de relecture" %}

# Conclusion

Dans ce tutoriel, nous avons décrit les bonnes pratiques pour la transcription rapide de documents en graphies ou en langues peu dotées via la plateforme Calfa Vision. La qualification de "peu dotée" peut concerner un très grand nombre varié de documents, y compris, comme ce fut le cas ici, dans des langues pour lesquelles il existe pourtant déjà des données. La qualité des données ne doit pas être négligée par rapport à la quantité, et l'utilisateur pourra dès lors envisager une transcription, y compris pour des documents inédits. Des questions plus techniques peuvent se poser selon la plateforme utilisée et un accompagnement dans les projets de transcription peut alors être proposé. Définir précisemment les besoins d'un traitement OCR / HTR est essentiel au regard des enjeux, la transcription automatique étant une porte d'entrée à tout projet de valorisation et de traiement de collections.

Les données générées pour cet article et dans le cadre du projet CGPG sont disponibles sur Github [lien à faire]. Le modèle d'analyse de la mise en page reste disponible sur Calfa Vision.

##### Notes de fin

[^1]: Snydman, Stuart, Robert Sanderson, et Tom Cramer. « The International Image Interoperability Framework (IIIF): A community & technology approach for web-based images ». In Archiving Conference, 2015:16‑21. Society for Imaging Science and Technology, 2015.

[^2]: Kaoua, Ryad, Xi Shen, Alexandra Durr, Stavros Lazaris, David Picard, et Mathieu Aubry. « Image Collation: Matching Illustrations in Manuscripts ». In Document Analysis and Recognition – ICDAR 2021, édité par Josep Lladós, Daniel Lopresti, et Seiichi Uchida, 351‑66. Lecture Notes in Computer Science. Cham: Springer International Publishing, 2021. https://doi.org/10.1007/978-3-030-86337-1_24.

[^3]: Emanuela Boros, Emanuela, Alexis Toumi, Erwan Rouchet, Bastien Abadie, Dominique Stutzmann, et Christopher Kermorvant. « Automatic Page Classification in a Large Collection of Manuscripts Based on the International Image Interoperability Framework ». In 2019 International Conference on Document Analysis and Recognition (ICDAR), 756‑62, 2019. https://doi.org/10.1109/ICDAR.2019.00126.

[^4]: Seuret, Mathias, Anguelos Nicolaou, Dalia Rodríguez-Salas, Nikolaus Weichselbaumer, Dominique Stutzmann, Martin Mayr, Andreas Maier, et Vincent Christlein. « ICDAR 2021 Competition on Historical Document Classification ». In Document Analysis and Recognition – ICDAR 2021, édité par Josep Lladós, Daniel Lopresti, et Seiichi Uchida, 618‑34. Lecture Notes in Computer Science. Cham: Springer International Publishing, 2021. https://doi.org/10.1007/978-3-030-86337-1_41.

[^5]: Il existe une grande variété de datasets existants réalisés dans divers cadres de recherche, les personnes intéressées et à la recherche de données pourront notamment trouver un grand nombre de données disponibles dans le cadre de l'[initiative HTR United](https://htr-united.github.io). Alix Chagué, Thibault Clérice, Laurent Romary. HTR-United : Mutualisons la vérité de terrain !. DHNord2021 - Publier, partager, réutiliser les données de la recherche : les data papers et leurs enjeux, MESHS, Nov 2021, Lille, France. (hal-03398740)

[^6]: Nous pouvons par exemple citer le programme « [Scripta-PSL. Histoire et pratiques de l'écrit](https://scripta.psl.eu/en/) » qui vise notamment à intégrer dans les humanités numériques une grande variété de langues et écritures anciennes et rares ; l'[Ottoman Text Recognition Network](https://otrn.univie.ac.at/) pour le traitement des graphies utilisées lors de la période ottomane ; ou encore le [Groupement d'Intérêt Scientifique Moyen-Orient et mondes musulmans (GIS MOMM)](http://majlis-remomm.fr/en/) qui, en partenariat avec la [BULAC](https://www.bulac.fr/) et [Calfa](https://calfa.fr), produit des jeux de données pour le [traitement des graphies arabes maghrébines](https://calfa.fr/blog/26).

[^7]: Le *crowdsourcing* peut prendre la forme d'ateliers dédiés avec un public restreint, mais est aussi largement ouvert à tout public bénévole qui souhaite occasionnellement transcrire des documents, comme le propose la [plateforme Transcrire](https://transcrire.huma-num.fr) proposée par Huma-Num.

[^8]: Reul, Christian, Dennis Christ, Alexander Hartelt, Nico Balbach, Maximilian Wehner, Uwe Springmann, Christoph Wick, Christine Grundig, Andreas Büttner, et Frank Puppe. « OCR4all—An open-source tool providing a (semi-) automatic OCR workflow for historical printings ». Applied Sciences 9, nᵒ 22 (2019): 4853.

[^9]: Vidal-Gorène, Chahan, Boris Dupin, Aliénor Decours-Perez, and Thomas Riccioli. "A modular and automated annotation platform for handwritings: evaluation on under-resourced languages." In International Conference on Document Analysis and Recognition, pp. 507-522. Springer, Cham, 2021.

[^10]: J-B. Camps, "Introduction à la philologie computationnelle. Science des données et science des textes : De l'acquisition du texte à l'analyse", [conférence](https://www.youtube.com/watch?v=DK7oxn-v0YU) donnée le 7 décembre 2020 dans le cadre de la formation en ligne "Etudier et publier les textes arabes avec le numérique". 

[^11]: Camps, J. B., Vidal-Gorène, C., & Vernet, M. (2021, September). Handling Heavily Abbreviated Manuscripts: HTR engines vs text normalisation approaches. In International Conference on Document Analysis and Recognition (pp. 306-316). Springer, Cham.

[^12]: Pour davantage de manipulations unicodes en grec ancien : https://jktauber.com/articles/python-unicode-ancient-greek/ [consulté le 12 février 2022]

[^13]: https://github.com/pharos-alexandria/ocr-greek_cursive, https://ryanfb.github.io/kraken-gaza-iliad/groundtruth/ et https://ryanfb.github.io/kraken-voulgaris-aeneid/groundtruth/

[^14]: Matteo, R., Sven, N. M., & Bruce, R. (2021, September). Optical Character Recognition of 19th Century Classical Commentaries: the Current State of Affairs. In The 6th International Workshop on Historical Document Imaging and Processing (pp. 1-6). Dataset également [disponible sur Github](https://github.com/AjaxMultiCommentary/GT-commentaries-OCR).

[^15]: Le modèle n'est pas évalué sur la Patrologie Grecque à ce stade. Le taux d'erreur est obtenu sur un ensemble de test extrait de ces trois datasets.

[^16]: Breuel, Thomas M. "The OCRopus open source OCR system." In Document recognition and retrieval XV, vol. 6815, p. 68150F. International Society for Optics and Photonics, 2008.

[^17]: Vidal-Gorène, Chahan, Boris Dupin, Aliénor Decours-Perez, et Thomas Riccioli. « A modular and automated annotation platform for handwritings: evaluation on under-resourced languages ». In International Conference on Document Analysis and Recognition, 507‑22. Springer, 2021.

[^18]: Vidal-Gorène, Chahan, Boris Dupin, Aliénor Decours-Perez, et Thomas Riccioli. « A modular and automated annotation platform for handwritings: evaluation on under-resourced languages ». In International Conference on Document Analysis and Recognition, 507‑22. Springer, 2021.

[^19]: L'étape de reconnaissance de texte (OCR ou HTR) est proposée sur demande et dans le cadre de projets dédiés ou partenaires. Les deux premières étapes du traitement sont quant à elles gratuites et utilisables sans limite.

[^20]: Lombardi, Francesco, et Simone Marinai. « Deep Learning for Historical Document Analysis and Recognition—A Survey ». Journal of Imaging 6, nᵒ 10 (octobre 2020): 110. https://doi.org/10.3390/jimaging6100110.

[^21]: Camps, Jean-Baptiste, Chahan Vidal-Gorène, et Marguerite Vernet. « Handling Heavily Abbreviated Manuscripts: HTR engines vs text normalisation approaches ». In International Conference on Document Analysis and Recognition, 306‑16. Springer, 2021.

[^22]: Vidal-Gorène, Chahan, Noëmie Lucas, Clément Salah, Aliénor Decours-Perez, and Boris Dupin. "RASAM–A Dataset for the Recognition and Analysis of Scripts in Arabic Maghrebi." In International Conference on Document Analysis and Recognition, pp. 265-281. Springer, Cham, 2021.

[^23]: Vidal-Gorène, Chahan, Noëmie Lucas, Clément Salah, Aliénor Decours-Perez, and Boris Dupin. "RASAM–A Dataset for the Recognition and Analysis of Scripts in Arabic Maghrebi." In International Conference on Document Analysis and Recognition, pp. 265-281. Springer, Cham, 2021.

[^24]: Vidal-Gorène, Chahan, Boris Dupin, Aliénor Decours-Perez, et Thomas Riccioli. « A modular and automated annotation platform for handwritings: evaluation on under-resourced languages ». In International Conference on Document Analysis and Recognition, 507‑22. Springer, 2021.

[^25]: Ströbel, Phillip Benjamin, Simon Clematide, and Martin Volk. "How Much Data Do You Need? About the Creation of a Ground Truth for Black Letter and the Effectiveness of Neural OCR." (2020): 3551-3559.

[^26]: Vidal-Gorène, Chahan, Kindt, Bastien (2022/à paraître) "From manuscript to tagged corpora", Armeniaca 1.

[^27]: Vidal-Gorène, Chahan, Noëmie Lucas, Clément Salah, Aliénor Decours-Perez, and Boris Dupin. "RASAM–A Dataset for the Recognition and Analysis of Scripts in Arabic Maghrebi." In International Conference on Document Analysis and Recognition, pp. 265-281. Springer, Cham, 2021.

[^28]: Pour en savoir plus sur la métrique utilisée, se référer à Vidal-Gorène, Chahan, Boris Dupin, Aliénor Decours-Perez, et Thomas Riccioli. « A modular and automated annotation platform for handwritings: evaluation on under-resourced languages ». In International Conference on Document Analysis and Recognition, 507‑22. Springer, 2021.

[^29]: Le dataset RASAM est disponible au format pageXML sur [Github](https://github.com/calfa-co/rasam-dataset). Il est le résultat d'un hackathon participatif ayant regroupé 14 personnes organisé par le GIS MOMM, la BULAC, Calfa, avec le soutien du ministère français de l'enseignement supérieur et de la recherche.