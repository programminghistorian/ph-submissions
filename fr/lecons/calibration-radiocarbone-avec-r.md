---
title: Calibrer des âges radiocarbone avec R
collection: lessons
layout: lesson
slug: calibration-radiocarbone-avec-r
authors:
- Nicolas Frerebeau
- Brice Lebrun
date: 2020-11-30
reviewers:
-
-
editors:
- Sofia Papastamkou
review-ticket: e.g. https://github.com/programminghistorian/ph-submissions/issues/108
difficulty: 2
activity: UNIQUEMENT UN PARMI: acquiring, transforming, analyzing, presenting, sustaining
topics:
 - data-manipulation
abstract: |
	Cette leçon explique comment calibrer des âges radiocarbone avec le langage R. 
avatar_alt: Description de l'image de la leçon
doi: 
---

{% include toc.html %}

# Calibrer des âges radiocarbones avec R

Depuis sa découverte et la "révolution" qui s'en est suivie, la méthode de datation par le radiocarbone est devenue d'usage courant pour l'archéologue ou l'historien. Soit parce qu'elle constitue la seule source d'information chronologique, soit parce qu'elle intervient en complément d'autres sources, matérielles ou textuelles.

L'objectif de la leçon est d'apprendre à calibrer des âges radiocarbone individuels, à combiner plusieurs âges en un seul et à en tester les différences. La méthode du radiocarbone est une méthode de datation dite *absolue*[^1] qui possède son propre référentiel temporel. La calibration est alors une étape indispensable, permettant le passage du référentiel radiocarbone à un référentiel calendaire.

Cette leçon explique comment calibrer des âges radiocarbone avec le langage R. L'utilisation de R permet de mettre en place des routines de traitement des données et de garantir la reproductibilité des résultats au moment de leur publication. Cette leçon nécessite comme prérequis d'être à l'aise avec [un usage basique de R](https://programminghistorian.org/en/lessons/r-basics-with-tabular-data) et des notions élémentaires de statistiques (tests statistiques)[^11]. Cette leçon se limite aux cas simples de calibration et ne couvre pas les cas avancés (calibration marine, problèmes de réservoirs, etc.) ni les problèmes de modélisation bayésienne.

## Le principe de la datation par le radiocarbone

Proposée à la fin des années 1940 par Willard Libby et ses collègues[^2], la méthode du radiocarbone utilise la décroissance radioactive du carbone 14 (^14^C) pour construire un chronomètre. Ce dernier permet d'estimer des âges, c'est-à-dire des intervalles de temps mesurés depuis le présent[^8]. Par convention, les âges radiocarbone sont ainsi exprimés en (kilo) années BP (*Before Present*, avant 1950[^6]).

L'élaboration d'un chronomètre suppose de vérifier trois conditions nécessaires :

- Le phénomène choisi doit suivre une loi qui varie au cours du temps ;
- La loi en question doit être indépendante des conditions du milieu ;
- Un événement initial doit pouvoir être déterminé.

Le ^14^C est un est des trois [isotopes](https://fr.wikipedia.org/wiki/Isotope) du carbone avec le ^12^C et le ^13^C. Le ^14^C est un isotope radioactif : il tend à se désintégrer au cours du temps selon une loi exponentielle décroissante. Il s'agit d'un phénomène nucléaire, indépendant du milieu. Pour un isotope donné, ce phénomène de décroissance radioactive peut être décrit à l'aide une grandeur particulière, la *période radioactive* (notée $T$, également appelée *demi-vie*). Cette dernière correspond au temps nécessaire à la désintégration de la moitié d'une quantité intiale d'atomes.

La période du ^14^C est de 5730 ± 40 ans : pour une quantité initiale $N_0$ d'atomes de ^14^C, il en reste $\frac{N_0}{2}$ au bout de 5730 ans, $\frac{N_0}{4}$ au bout de 11460 ans, etc. (fig. 1). Au bout de 8 à 10 périodes (environ 45000 à 55000 ans), on considère que la quantité de ^14^C est trop faible pour être mesurée : c'est la limite de la méthode.

{% include figure.html filename="decroissance.png" caption="Figure 1 : Décroissance exponentielle d'une quantité initiale d'atomes radioactifs au cours du temps (exprimé en périodes radioactives)." %}

Le carbone 14 est produit naturellement en haute atmosphère sous l'effet des rayonnements cosmiques. Il est ensuite progressivement absorbé par les organismes vivants au fil de la chaîne trophique (en commençant par les organismes photosynthétiques). On considère alors que la teneur en ^14^C dans les organismes vivants est constante et à l'équilibre avec la teneur atmosphérique[^10].

Lorsqu'un organisme meurt, les échanges avec le milieu s'arrêtent. En supposant qu'il n'y ait pas de contamination extérieure, on considère que le système est clos : la décroissance radioactive est le seul phénomène affectant la quantité de ^14^C contenue dans l'organisme. L'événement daté par le radiocarbone est ainsi la mort de l'organisme.

Sauf à rechercher spécifiquement à quand remonte la mort d'un organisme, le radiocarbone fournit donc un *teminus post-quem* pour l'événement archéologique que l'on souhaite positionner dans le temps. C'est-à-dire le moment après lequel a eu lieu l'événement archéologique ou historique d'intérêt (abandon d'un objet, combustion d'un foyer, dépôt d'une couche sédimentaire, etc.).

Grâce à la loi de décroissance radioactive, si on connaît la quantité initiale ($N_0$) de ^14^C contenue dans un organisme à sa mort (instant $t_0$) et la quantité restante de ^14^C à un instant $t$, il est possible de mesurer le temps écoulé entre $t_0$ et $t$ : l'âge radiocarbone d'un objet archéologique.

* La quantité actuelle de ^14^C dans un objet peut être déterminée en laboratoire, soit en comptant les noyaux de ^14^C, soit en comptant le nombre de désintégration par unité de temps et par quantité de matière (*activité spécifique*).
* Pour déterminer la quantité initiale, la méthode du radiocarbone repose sur l'hypothèse suivante : la quantité de ^14^C dans l'atmosphère est constante dans le temps et égale à la teneur actuelle.

Ce postulat de départ a permis à Libby et ses collègues de démontrer la faisabilité de la méthode en réalisant les premières datations radiocarbones sur des objets d'âge connus par ailleurs[^3]. Au regard des résultats alors obtenus, il apparaît qu'il existe une relation linéaire entre les âges radiocarbone mesurés et les âges calendaires connus par d'autres méthodes (fig. 2A).

## Pourquoi calibrer des âges radiocarbone ?

Les études menées dans la seconde moitié du XX<sup>e</sup> siècle, à mesure que des objets de plus en plus anciens sont datés, ont néanmoins permis de mettre en évidence un écart de plus en plus important entre l'age mesuré et l'âge attendu.

Contrairement au postulat de Libby, la teneur en ^14^C dans l'atmosphère n'est pas constante au cours du temps, expliquant en partie les écarts observés. La teneur atmosphérique en ^14^C varie en fonction de phénomènes naturels (variations du champ magnétique terrestre, activité solaire, activité volcanique, cycle du carbone...) et anthropiques. Ces phénomènes peuvent être contradictoires : l'usage des combustibles fossiles libère du carbone très ancien et tend à diminuer la teneur relative de ^14^C (effet Suess), à l'inverse les essais nucléaires atmosphériques ont produit de grandes quantités de ^14^C.

Le chronomètre que constitue la méthode du radiocarbone n'a donc pas un rythme régulier (car la teneur atmosphérique en ^14^C varie au cours du temps). En conséquence, les âges radiocarbone (on utilisera par la suite l'expression d'*âges conventionnels*) appartiennent à un référentiel temporel qui leur est propre.

L'utilisation du postulat de Libby demeure néanmoins la seule façon accessible pour estimer la quantité initiale de ^14^C à la fermeture du système. Il est donc nécessaire de réaliser une opération dite de *calibration* pour transformer un âge conventionnel en âge calendaire. Cette opération est réalisée à l'aide d'une courbe[^4], régulièrement mise à jour par la communauté scientifique[^5]. La courbe de calibration est construite en datant des échantillons à la fois par le radiocarbone et par une méthode indépendante, offrant ainsi une table d'équivalence entre temps radiocarbone et temps calendaire (fig. 2B).

{% include figure.html filename="intcal.png" caption="Figure 2 : Âges mesurées par le radiocarbone en fonction des âges calendaires attendus. (A) *Curve of Knowns*, âges radiocarbones d'objets archéologiques dont l'âge calendaire est connu par des méthodes indépendantes (d'après Arnold et Libby, 1949). La droite 1:1, pour laquelle un âge conventionnel est égal à un âge calendaire, est représentée en tirets. (B) Courbes de calibration IntCal09, IntCal13 et IntCal20 (Reimer *et al.* 2009, 2013 et 2020). L'écart à la droite 1:1 (tirets) est d'autant plus marqué que les âges sont anciens." %}

## Comment calibrer ?

Nous venons donc de voir qu'il était nécessaire de calibrer ses âges radiocarbone. Sur le papier, le processus de calibration est relativement simple, grâce à la table d'équivalence entre temps radiocarbone et temps calendaire. Dans les faits, le processus de calibration se trouve complexifié par la prise en compte des erreurs inévitablement associées aux mesures physiques.

Un âge conventionnel (noté ici $t$) est le résultat d'une mesure et, comme il n'existe pas de mesure parfaite, il est toujours accompagné d'un terme correspondant à l'incertitude analytique ($\Delta t$) et exprimé sous la forme $t \pm \Delta t$ (l'âge *plus ou moins* son incertitude). Cette incertitude résulte de la combinaison des différents sources d'erreur au sein du laboratoire : il s'agit d'une incertitude *aléatoire* inhérente à la mesure.

Un âge conventionnel est ainsi un *estimateur* du vrai âge radiocarbone de l'objet daté. Si on répète un très grand nombre de fois la datation d'un même échantillon, sa valeur est susceptible de varier et il y a très peu de chance qu'elle coïncide exactement avec l'âge radiocarbone vrai.

Il est donc préférable de s'attacher à un intervalle dont il est hautement probable qu'il contienne la vrai valeur (inconnue) de âge conventionnel. De fait, l'incertitude caractérise la dispersion des valeurs qui pourraient raisonnablement être attribuées à l'âge vrai. Un âge conventionnel est la réalisation d'un processus aléatoire, la décroissance radioactive, il peut être ainsi modélisé à l'aide d'une loi de probabilité particulière : la [loi normale](https://fr.wikipedia.org/wiki/Loi_normale)[^7].

Seuls deux paramètres sont nécessaires pour caractériser la distribution des valeurs selon une loi normale : la moyenne $\mu$ (tendance centrale) et l'écart-type $\sigma$ (dispersion des valeurs). Les propriétés de la distribution normale sont telles que l'intervalle défini par $\mu \pm \sigma$ contient 67 % des valeurs. Si on multiplie l'écart-type par deux, l'intervalle $\mu \pm 2\sigma$ contient quant à lui 95 % des valeurs (fig. 3).

Ainsi, si on exprime l'incertitude d'un âge conventionnel en fonction de l'écart-type, il y a 68 % de chance que l'intervalle à $1\sigma$ contienne l'âge conventionnel vrai. De même, l'intervalle à $2\sigma$ a 95 % de chance de contenir l'âge conventionnel vrai. L'intervalle à $1\sigma$ est plus précis (moins dispersé), mais moins juste qu'à $2\sigma$ : la plage de valeurs retenues est plus resserrée, mais elle a moins de chance de contenir l'âge conventionnel vrai.

{% include figure.html filename="gauss.png" caption="Figure 3 : Loi normale de moyenne 0 et d'écart-type 1 avec les plage de normalité aux niveaux de confiance 68, 95 et 99 %. La distribution des valeurs est telle que la dispersion est symétrique autour de la tendance centrale." %}

L'approche la plus élémentaire pour la calibration d'un âge radiocarbone consiste à intercepter la courbe de calibration entre les bornes d'incertitude ($t - \Delta t$ et $t + \Delta t$ dans le cas à $1\sigma$) pour obtenir l'intervalle d'âges calendaires correspondants (fig. 4). Cette approche ne tient cependant pas compte du fait qu'un âge radiocarbone est décrit par une distribution normale. Dans la plage définie par l'âge radiocarbone plus ou moins son incertitude, toutes les valeurs n'ont la même probabilité de coïncider avec l'âge radiocarbone vrai, or la calibration par simple interception suppose l'inverse. De fait, l'approche aujourd'hui courante[^9] consiste à prendre également en compte la distribution normale des âges radiocarbones. On trouve parfois l'expression de *calibration probabiliste* pour la désigner. Cette méthode de calibration recourt à des méthodes numériques et la distribution des âges calendaires qui en résulte n'est pas équiprobable (fig. 5).

{% include figure.html filename="calibration.png" caption="Figure 4 : Calibration d'un âge conventionnel de 2725 ± 50 ans BP par interception de la courbe de calibration IntCal20 (trait plein). L'épaisseur du bandeau gris représente l'incertitude associé à la courbe de calibration." %}

S'il est aisé de décrire un âge conventionnel et son incertitude avec une loi normale, il va en tout autrement d'un âge calendaire une fois calibré. Il n'est en effet pas possible de décrire la distribution d'un âge calendaire avec une loi de probabilité particulière. Ceci est dû à la nature de la courbe de calibration qui n'est pas linéaire, mais présente une allure en dents de scie. Si la valeur et l'incertitude d'un âge radiocarbone suffisent à le décrire, un âge calendaire ne peut être exprimé que sous la forme d'un intervalle. Retenir la seule valeur centrale ou la valeur la plus probable d'un âge calibré n'a donc pas de sens statistique.

L'intervalle auquel appartient un âge calendaire résulte à la fois de l'incertitude de l'âge conventionnel, de l'allure de la courbe de calibration et de l'incertitude associée à cette dernière. Il existe ainsi des périodes qui sont plus ou moins propices à des datations radiocarbones, en fonction de l'allure de la courbe. Le cas le moins favorable est l'existence de plateaux au sein de la courbe de calibration.

Un cas typique est le plateau de l'Âge du Fer (fig. 5). Par exemple, un âge conventionnel de 2450 ± 75 ans BP correspond, une fois calibré à $2\sigma$, à un âge calendaire compris entre 2719 et 2353 ans BP (soit 769-403 avant notre ère). Ainsi, malgré un âge conventionnel avec une incertitude assez faible (3 %), l'âge calendaire correspondant a 95 % de chance de se trouver dans un intervalle de temps qui couvre la quasi-totalité du premier Âge du Fer (fig. 5). On pourrait alors être tenté de réaliser la calibration avec une incertitude à $1\sigma$ pour réduire l'intervalle de l'âge calendaire. Dans ce cas, le résultat n'est guère meilleur et on se retrouve confronté à une autre difficulté, liée aux oscillations de la courbe de calibration : l'âge calendaire a 68 % de chance d'appartenir à l'union des intervalles 748-684 (18 %), 665-637 (8 %), 586-580 (2 %), 568-452 (32 %) et 444-415 (8 %) avant notre ère et non à un unique intervalle (fig. 5).

{% include figure.html filename="hallstatt.png" caption="Figure 5 : Plateau de l'Âge du Fer. En haut à droite : extrait de la courbe IntCal20 (trait plein). L'épaisseur du bandeau gris représente l'incertitude associée à la courbe de calibration. En haut à gauche : distribution d'un âge radiocarbone de 2450 ± 75 ans BP. En bas à droite : distribution de l'âge radiocarbone calibré (âge calendaire)." %}

On comprend ainsi que ces particularités, si elles sont mal comprises, peuvent rapidement conduire à des sur-interprétations. Au cours de l'étude d'un corpus de datations ou lors de sa publication, il est donc particulièrement important de présenter l'ensemble des données et des choix ayants concouru à l'obtention des âges calendaires. L'usage d'outils libres favorise à la fois la transparence et la reproductibilité des résultats, deux aspects particulièrement importants dans le cas de la calibration d'âges radiocarbone.

## Applications avec R

De nombreux outils sont aujourd'hui disponibles pour calibrer des âges radiocarbone. [OxCal](https://c14.arch.ox.ac.uk/oxcal/) et [ChronoModel](https://chronomodel.com) offrent cette possibilité, mais sont plutôt destinés à traiter des problèmes de modélisation bayésienne. Le langage R offre une alternative intéressante. Distribué sous licence libre, il favorise la reproductibilité et permet d'intégrer le traitement d'âges radiocarbone à des études plus larges (analyse spatiale etc.).

Plusieurs bibliothèquespackages R permettent de réaliser des calibrations d'âges radiocarbone ([Bchron](https://cran.r-project.org/package=Bchron), [oxcAAR](https://cran.r-project.org/package=oxcAAR)...) et sont souvent orientés vers la modélisation (approche bayésienne, modèles âges-profondeur, etc.). La solution retenue ici est [rcarbon](https://cran.r-project.org/package=rcarbon) (Bevan et Crema 2020). Ce package permet de calibrer simplement et d'analyser des âges radiocarbone.

### Cas d'étude

Afin d'aborder concrètement la question de la calibration d'âges radiocarbone, nous allons nous pencher sur l'exemple de la datation du Suaire de Turin. Réalisée à la fin des années 1980, cette dernière constitue un cas d'école en matière de datation d'un objet historique par la méthode du radiocarbone. Trois datations indépendantes d'un même prélèvement ont été réalisées en aveugle, avec des échantillons de contrôle.

En avril 1988, un échantillon de tissu est prélevé sur le Suaire de Turin. Trois laboratoires différents ont été sélectionnés l'année précédente et reçoivent chacun un fragment de ce même échantillon. En complément, trois autres tissus dont les âges calendaires sont connus par d'autres méthodes sont également échantillonnés. Ces trois échantillons supplémentaires doivent servir d'échantillons de contrôle, afin de valider les résultats de chaque laboratoire et de s'assurer que les résultats des différents laboratoires sont bien compatibles entre eux. Chaque laboratoire a reçu quatre échantillons et réalisé les mesures en aveugle, sans savoir lequel correspond au Suaire (Damon *et al.*, 1989). Les résultats obtenus sont reproduits dans le tableau 1.

| Laboratoire | Éch. 1   | Éch. 2   | Éch. 3    | Éch. 4   |
|:------------|:---------|:---------|:----------|:---------|
| Arizona     | 646 ± 31 | 927 ± 32 | 1995 ± 46 | 722 ± 43 |
| Oxford      | 750 ± 30 | 940 ± 30 | 1980 ± 35 | 755 ± 30 |
| Zurich      | 676 ± 24 | 941 ± 23 | 1940 ± 30 | 685 ± 34 |

*Tableau 1* : Âges radiocarbone ($1\sigma$) obtenus dans le cadre de l'étude du Suaire de Turin (Damon *et al.*, 1989). Éch. 1 : Suaire de Turin. Éch. 2 : fragment de lin provenant d'une tombe de Qasr Ibrîm (Égypte), daté des XI^e^-XII^e^ siècles de notre ère. Éch. 3 : fragment de lin associé à une momie de Thèbes (Égypte), daté entre -110 et 75. Éch. 4 : fils de la chape de St Louis d'Anjou (France), daté entre 1290 et 1310.

### Importer les données

La première étape consiste à créer le tableau de données (`data.frame`) où chaque ligne correspond à un laboratoire, les 4 premières colonnes correspondent aux âges conventionnels et les 4 dernières aux incertitudes.

```r
turin <- utils::read.table(
  header = TRUE,
  sep = " ",
  dec = ".",
  row.names = 1,
  strip.white = TRUE,
  blank.lines.skip = TRUE,
  text = "
lab age1 age2 age3 age4 err1 err2 err3 err4
Arizona 646 927 1995 722 31 32 46 43
Oxford 750 940 1980 755 30 30 35 30
Zurich 676 941 1940 685 24 23 30 34"
)
```

Ensuite, on remet en forme les données dans un `array`, obtenant ainsi un tableau à 3 dimensions : la 1^ère^ dimension (lignes) correspond aux laboratoires, la 2^ème^ dimension (colonnes) correspond aux échantillons, la 3^ème^ dimension permet de distinguer les âges et leurs incertitudes.

```r
turin <- as.matrix(turin)
dim(turin) <- c(3, 4, 2)
dimnames(turin) <- list(
  c("Arizona", "Oxford", "Zurich"),
  paste("Ech.", 1:4, sep = " "),
  c("age", "erreur")
)
```

```r
turin
```

```
## , , age
##
##         Ech. 1 Ech. 2 Ech. 3 Ech. 4
## Arizona    646    927   1995    722
## Oxford     750    940   1980    755
## Zurich     676    941   1940    685
##
## , , erreur
##
##         Ech. 1 Ech. 2 Ech. 3 Ech. 4
## Arizona     31     32     46     43
## Oxford      30     30     35     30
## Zurich      24     23     30     34
```

Avant de calibrer les âges radiocarbones obtenus, plusieurs questions peuvent être explorées.

### Comment visualiser les données produites ?

Dans le cas présent, plusieurs laboratoires ont daté les même objets. Dans un premier temps, on cherche donc à savoir si les âges obtenus pour chaque objet par les différents laboratoires sont compatibles entre eux. Cette compatibilité s'entend en prenant en compte les incertitudes associées aux âges.

Une fois les données importées et mises en forme, une première approche consiste à les visualiser. On peut ainsi se faire une première idée quant à la compatibilité des résultats fournis par les différents laboratoires pour chaque objet daté. Le code suivant permet de générer la figure 6 où sont figurées les distributions des âges conventionnels de chaque échantillon.

```r
## On fixe les paramètres graphiques
## 'mfrow' permet d'afficher les 4 graphiques sur 2 lignes et 2 colonnes
par(mfrow = c(2, 2), mar = c(3, 4, 0, 0) + 0.1, las = 1)
couleurs <- c("#DDAA33", "#BB5566", "#004488")

## Pour chaque objet daté...
for (j in 1:ncol(turin)) {
  ## On défini l'étendue des valeurs en abscisse (années)
  k <- range(turin[, j, 1])
  x <- seq(min(k) * 0.8, max(k) * 1.2, by = 1)
  ## On défini un graphique vide auquel ajouter les distributions
  plot(x = NULL, y = NULL, xlim = range(x), ylim = c(0, 0.02),
       xlab = "", ylab = "", type = "l")

  ## On affiche le nom de l'échantillon
  text(x = min(k) * 0.9, y = 0.02, labels = colnames(turin)[j], pos = 1)

  ## Pour chaque âge obtenu...
  for (i in 1:nrow(turin)) {
    ## On calcule la fonction de densité de la distribution normale
    y <- dnorm(x = x, mean = turin[i, j, 1], sd = turin[i, j, 2])

    ## On trace la courbe
    lines(x = x, y = y, type = "l", lty = 1, lwd = 1.5, col = couleurs[[i]])
  }
}

## On ajoute une légende au dernier graphique
legend("topright", legend = rownames(turin), lty = 1, lwd = 1.5, col = couleurs)
```

{% include figure.html filename="turin-uncal.png" caption="Figure 6 : Distribution des âges conventionnels par laboratoire." %}

La figure 6 permet de constater que l'échantillon 1 présente des âges ne se recouvrant que faiblement entre eux, au contraire des trois autres échantillons datés. Partant de cette première observation, on va donc tester l'homogénéité des résultats des différents laboratoires.

### Les résultats des différents laboratoires sont-ils homogènes ?

Pour répondre à cette question, les auteurs de l'étude de 1988 suivent la méthodologie proposée par Ward et Wilson (1978). Celle-ci consiste à réaliser un test statistique d'homogénéité dont l'hypothèse nulle ($H_0$) peut être formulée comme suit : "les âges mesurés par les différents laboratoires sur un même objet sont égaux".

Pour cela, on commence par calculer l'âge moyen de chaque objet ($\bar{x}$). Celui-ci correspond à la moyenne pondérée des âge obtenus par chaque laboratoire. L'usage d'un facteur de pondération (l'inverse de la variance, $w_i = \frac{1}{\sigma_i^2}$) permet d'ajuster la contribution relative de chaque date ($x_i$) à la valeur moyenne.

$$ \bar{x}  = \frac{\sum_{i=1}^{n}{w_i x_i}}{\sum_{i=1}^{n}{w_i}} $$

À cette âge moyen est également associée une incertitude ($\sigma$) :
$$ \sigma = \left(\sum_{i=1}^{n}{w_i}\right)^{-1/2} $$

À partir de cette valeur moyenne, on peut calculer une variable de test statistique ($T$) permettant la comparaison des âges mesurés à un âge théorique (ici l'âge moyen) pour achaque objet daté.

$$ T = \sum_{i=1}^{n}{\left( \frac{x_i - \bar{x}}{\sigma_i} \right)^2} $$

$T$ est une variable aléatoire qui suit une loi du $\chi^2$ avec $n-1$ degrés de liberté ($n$ est le nombre de datations par objet, ici $n = 3$). À partir de $T$, il est possible de calculer la valeur $p$, c'est-à-dire le risque de rejeter l'hypothèse nulle alors que celle-ci est vraie. En comparant la valeur $p$ à un seuil $\alpha$ fixé à l'avance, on peut déterminer s'il est possible ou non de rejeter $H_0$ (si $p$ est supérieure à $\alpha$, alors on ne peut rejeter l'hypothèse nulle). On fixe ici cette valeur $\alpha$ à 0,05. On estime ainsi qu'un risque de 5% de se tromper est acceptable.

Le code suivant permet de calculer pour chaque échantillon, son âge moyen, l'incertitude associée, la statistique $T$ et la valeur $p$.

```r
## On construit un data.frame pour stocker les résultats
## Chaque ligne correspond à un échantillon
## Les colonnes correspondent à :
## - L'âge moyen
## - L'incertitude associée à l'âge moyen
## - La statistique du test d'homogénéité
## - La valeur p du test d'homogénéité
dates <- as.data.frame(matrix(nrow = 4, ncol = 4))
rownames(dates) <- paste("Ech.", 1:4, sep = " ")
colnames(dates) <- c("age", "erreur", "chi2", "p")

## Pour chaque objet daté...
for (j in 1:ncol(turin)) {
  age <- turin[, j, 1] # On extrait les âges
  inc <- turin[, j, 2] # On extrait les incertitudes

  # On calcule la moyenne pondérée
  w <- 1 / inc^2 # Facteur de pondération
  moy <- stats::weighted.mean(x = age, w = w)

  # On calcule l'incertitude associée à la moyenne pondérée
  err <- sum(1 / inc^2)^(-1 / 2)

  # On calcule la statistique du test
  chi2 <- sum(((age - moy) / inc)^2)

  # On calcule la valeur-p
  p <- 1 - pchisq(chi2, df = 2)

  # On stocke les résultats
  dates[j, ] <- c(moy, err, chi2, p)
}
```

```r
dates
```

```
##              age   erreur      chi2          p
## Ech. 1  689.1192 16.03791 6.3518295 0.04175589
## Ech. 2  937.2838 15.85498 0.1375815 0.93352200
## Ech. 3 1964.4353 20.41230 1.3026835 0.52134579
## Ech. 4  723.8513 19.93236 2.3856294 0.30336618
```

En les calculs, on constate que l'échantillon 1 présente une valeur $p$ de 0,04. Comme celle-ci est inférieure au seuil $\alpha$ fixé, l'hypothèse $H_0$ peut être rejetée. Cela signifie que les différences observées entre les âges obtenus sur cet échantillon sont significatives. Les valeurs $p$ obtenues pour les autres échantillons sont respectivement de 0,92, 0,52 et 0,30 : l'hypothèse $H_0$ ne peut être donc rejetée dans ces cas.

Cette fluctuation des âges de l'échantillon 1 est vraissemblablement liée à une hétérogénéité des mesures au sein d'un des laboratoires[^12].

### Calibration des âges

Conformément aux résultats des tests précédents, on va pouvoir calibrer l'âge moyen des échantillons 2, 3 et 4. Pour l'échantillon 1, les différents âges seront calibrés séparément. La calibration est réalisée avec la fonction `calibrate()` du package rcarbon.

```r
## On charge le package rcarbon
library(rcarbon)

## On calibre les âges de l'échantillon 1
ages_ech1 <- calibrate(
  x = turin[, 1, 1],      # On sélectionne les âges de l'échantillon 1
  errors = turin[, 1, 2], # On sélectionne les incertitudes associées
  ids = rownames(turin),  # On précise les noms des âges (laboratoires)
  calCurves = "intcal20", # On choisit la courbe IntCal20
  verbose = FALSE
)
## On affiche les âges calibrés
summary(ages_ech1)
```

```
##    DateID MedianBP OneSigma_BP_1 OneSigma_BP_2 TwoSigma_BP_1 TwoSigma_BP_2
## 1 Arizona      600    653 to 631    590 to 561    667 to 623    612 to 555
## 2  Oxford      682    718 to 710    690 to 667    726 to 660      NA to NA
## 3  Zurich      648    667 to 648    582 to 571    671 to 633    589 to 563
```

```r
## On calibre les âges moyens des échantillons 2, 3 et 4
ages_ech234 <- calibrate(
  x = dates$age[-1],
  errors = dates$erreur[-1],
  ids = rownames(dates)[-1],
  calCurves = "intcal20",
  verbose = FALSE
)
## On affiche les âges calibrés
summary(ages_ech234)
```

```
##   DateID MedianBP OneSigma_BP_1 OneSigma_BP_2 OneSigma_BP_3 OneSigma_BP_4
## 1 Ech. 2      850    905 to 897    889 to 865    857 to 845    831 to 794
## 2 Ech. 3     1893  1925 to 1870  1851 to 1842      NA to NA      NA to NA
## 3 Ech. 4      670    676 to 664      NA to NA      NA to NA      NA to NA
##   TwoSigma_BP_1 TwoSigma_BP_2 TwoSigma_BP_3
## 1    910 to 839    837 to 792      NA to NA
## 2  1981 to 1981  1979 to 1966  1943 to 1829
## 3    683 to 653      NA to NA      NA to NA
```

On obtient ainsi le tableau des intervalles calibrés à 1 et 2$\sigma$ pour chaque âge. Attention, les âges calibrés par le package rcarbon sont exprimés en années BP. Il est courant dans certains contextes de conserver des âges calibrés exprimés en années BP, dans ce cas il est recommandé de préciser *cal* BP pour éviter toute confusion par le lecteur. Ces âges calendaires en années BP peuvent être convertis en dates exprimées avant ou après notre ère (BC/AD, *before Christ/anno Domini*). Pour cela, il suffit de retrancher 1950 aux âges calibrés.

On peut également représenter les distributions des âges conventionnels et calendaires avec la courbe de calibration (fig. 7) :

```r
## On fixe les paramètres graphiques
## 'mfrow' permet d'afficher les 6 graphiques sur 2 lignes et 3 colonnes
par(mfrow = c(2, 3), mar = c(3, 4, 2, 0) + 0.1, las = 1)

## Pour l'échantillon 1...
for (i in 1:3) {
  plot(
    x = ages_ech1,
    ind = i,
    HPD = TRUE,
    credMass = 0.95,
    calendar = "BCAD",
    xlab = "",
    ylab = ""
  )
  mtext(text = paste("Ech. 1", rownames(turin)[[i]], sep = " "), side = 3)
}

## Pour les échantillons 2, 3 et 4...
for (i in 1:3) {
  plot(
    x = ages_ech234,
    ind = i,
    HPD = TRUE,
    credMass = 0.95,
    calendar = "BCAD",
    xlab = "",
    ylab = ""
  )
  mtext(text = rownames(dates)[-1][[i]], side = 3)
}
```

{% include figure.html filename="turin-cal.png" caption="Figure 7 : Distribution des âges conventionnels et calendaires des différents échantillon. Les zones gris foncé correspondent à l'intervalle 2σ. Courbe IntCal20." %}

### Comment interpréter ces âges ?

On s'intéresse en premier aux échantillons de contrôle 2, 3 et 4. On constate que leurs âges calibrées sont en accord avec les datations connues par ailleurs.

* L'âge calendaire de l'échantillon 2 a 68% de chance (calibration à 1$\sigma$) de se trouver entre 1045 et 1053, en accord avec une datation attendue autour des XI^e^-XII^e^ siècles de notre ère.
* L'âge calendaire de l'échantillon 3 a 68% de chance (calibration à 1$\sigma$) de se trouver entre 25 et 80, en accord avec une datation attendue entre -110 et 75.
* L'âge calendaire de l'échantillon 4 a 68% de chance (calibration à 1$\sigma$) de se trouver entre 1274 et 1286, en accord avec une datation attendue autour de 1290 et 1310.

Les âges radiocarbones obtenus par les différents laboratoires pour l'échantillon 1 ont été calibrés séparément. La fonction `multiplot()` permet de représenter les distributions des âges calibrés (exprimés en années BC/AD) pour les trois laboratoires (fig. 8).

```r
## On fixe les paramètres graphiques
par(mar = c(4, 1, 0, 1) + 0.1)

## On représente les âges obtenus par les trois laboratoires (éch. 1)
multiplot(
  x = ages_ech1,
  type = "d",
  decreasing = TRUE,
  HPD = TRUE,
  credMass = 0.95,   # 2σ
  calendar = "BCAD"  # Référence calendaire
)
```

{% include figure.html filename="turin-plot.png" caption="Figure 8 : Distribution des âges calendaires (calibrés à 2σ) de l'échantillon 1." %}

Si l'analyse des âges conventionnels obtenus par les différents laboratoires pour l'échantillon 1 révèle une certaine hétérogénéité, on constate néanmoins que les âges calibrés appartiennent tous aux XIII^e^ et XIV^e^ siècles. Bien qu'on ne puisse donner un intervalle plus précis, ces résultats sont en accord avec l'apparition des premières mentions écrites du Suaire et permettent raisonnablement d'exclure l'hypothèse d'authenticité de la relique.

### Comment présenter ses résultats ?

Pour communiquer ou publier des âges radiocarbone de manière rigoureuse et en permettant la reproductibilité des résultats, il est nécessaire de toujours faire figurer un certain nombre d'éléments. Par exemple, on écrira :

> L'échantillon ETH-3883 est daté à 676 ± 24 ans BP, calibré à [667;648] ans cal BP ou [1283;1302] ans AD (1$\sigma$) avec IntCal20 (Reimer *et al.* 2020) et le package rcarbon 1.4.0 (Crema et Bevan, 2020).

Sous cette forme, on dispose ainsi des éléments suivants :

* L'âge conventionnel et son incertitude (676 ± 24 ans BP), accompagnés du numéro d'identification donné par le laboratoire (ETH-3883) ;
* L'âge calibré sous la forme d'un ou plusieurs intervalles (du fait de sa distribution particulière, un âge calibré est toujours donné sous la forme d'intervalles), en précisant si la calibration est réalisée à 1 ou 2$\sigma$ et le référentiel temporel utilisé : [667;648] ans cal BP ou [1283;1302] ans AD (1$\sigma$) ;
* La courbe de calibration utilisée et la référence correspondante : IntCal20 (Reimer *et al.* 2020) et la version du logiciel utilisé pour la calibration (ici R 4.0.3 et le package rcarbon 1.4.0).

## Conclusion

La calibration des âges radiocarbones permet leur transposition dans un référentiel temporel calendaire. Cette étape est indispensable à l'interprétation des résultats, d'autant plus que le rythme de l'horloge du carbone 14 varie au cours du temps. Dans cette leçon, nous avons ainsi appris à combiner des âges conventionnels et à tester leur homogénéité avant de les calibrer. Nous avons également vu comment représenter graphiquement ces âges et comment présenter les résultats avec l'ensemble des informations nécessaires à leur reproduction.

## Bibliographie

Anderson, E. C., W. F. Libby, S. Weinhouse, A. F. Reid, A. D. Kirshenbaum, et A. V. Grosse. 1947. "Radiocarbon From Cosmic Radiation". *Science* 105 (2735): 576‑77. https://doi.org/10.1126/science.105.2735.576.

Arnold, J. R., et W. F. Libby. 1949. "Age Determinations by Radiocarbon Content: Checks with Samples of Known Age". *Science* 110 (2869): 678‑80. https://doi.org/10.1126/science.110.2869.678.

Crema, E. R. et Bevan, A. 2020. "Inference From Lage Sets of Radiocarbon Dates: Software and Methods". *Radiocarbon*. https://doi.org/10.1017/RDC.2020.95.

Bevan, A. et Crema, E. R. 2020. *rcarbon: Methods for calibrating and analysing radiocarbon dates*. Package R, v1.4.0. https://CRAN.R-project.org/package=rcarbon

Colman, S. M., K. L. Pierce, et P. W. Birkeland. 1987. "Suggested Terminology for Quaternary Dating Methods." *Quaternary Research* 28 (2): 314-19. https://doi.org/10.1016/0033-5894(87)90070-6.

Damon, P. E., D. J. Donahue, B. H. Gore, A. L. Hatheway, A. J. T. Jull, T. W. Linick, P. J. Sercel, et al. 1989. "Radiocarbon dating of the Shroud of Turin". *Nature* 337 (6208): 611‑15. https://doi.org/10.1038/337611a0.

Dean, J. S. "Independent Dating in Archaeological Analysis". In *Advances in Archaeological Method and Theory*, 223‑55. Elsevier, 1978. https://doi.org/10.1016/B978-0-12-003101-6.50013-5

Libby, W. F. "Radiocarbon Dating". *Nobel Lecture*. Stockholm, 12 décembre 1960. http://www.nobelprize.org/nobel_prizes/chemistry/laureates/1960/libby-lecture.html.

Millot, G. *Comprendre et réaliser les tests statistiques à l'aide de R - Manuel de biostatistique*. Troisième édition. Louvain-la-Neuve : De Boeck, 2014.

O'Brien, M. J, et R. L. Lyman. *Seriation, Stratigraphy, and Index Fossils: The Backbone of Archaeological Dating*. Dordrecht : Springer, 2002.

Reimer, P. J., M. G. L. Baillie, E. Bard, A. Bayliss, J. W. Beck, P. G. Blackwell, C. Bronk Ramsey, *et al.* 2009. "IntCal09 and Marine09 Radiocarbon Age Calibration Curves, 0–50,000 Years Cal BP". *Radiocarbon* 51 (4): 1111‑50. https://doi.org/10.1017/S0033822200034202.

Reimer, P. J., E. Bard, A. Bayliss, J. W. Beck, P. G. Blackwell, C. Bronk Ramsey, C. E. Buck, *et al.* 2013. "IntCal13 and Marine13 Radiocarbon Age Calibration Curves 0-50,000 Years cal BP". *Radiocarbon* 55 (4): 1869‑87. https://doi.org/10.2458/azu_js_rc.55.16947.

Reimer, P. J., W. E. N. Austin, E. Bard, A. Bayliss, P. G. Blackwell, C. Bronk Ramsey, M. Butzin, et al. 2020. "The IntCal20 Northern Hemisphere Radiocarbon Age Calibration Curve (0-55 Cal KBP)". *Radiocarbon*, 1‑33. https://doi.org/10.1017/RDC.2020.41.

Scott, E. M., G. T Cook, et P. Naysmith. 2007. "Error and Uncertainty in Radiocarbon Measurements". *Radiocarbon* 49 (2): 427‑40. https://doi.org/10.1017/S0033822200042351.

Ward, G. K., et S. R. Wilson. 1978. "Procedures for Comparing and Combining Radiocarbon Age Determinations: A Critique". *Archaeometry* 20 (1): 19‑31. https://doi.org/10.1111/j.1475-4754.1978.tb00208.x.

Walsh, B., et Schwalbe, L. 2020. "An Instructive Inter-Laboratory Comparison: The 1988 Radiocarbon Dating of the Shroud of Turin". Journal of Archaeological Science: Reports 29 (février): 102015. https://doi.org/10.1016/j.jasrep.2019.102015.

## Notes

[^1]: Par opposition à une datation *relative* qui ordonne une séquence d'événements. À proprement parler, il n'existe pas de méthode de datation absolue car toutes s'inscrivent dans un référentiel particulier. Certains auteurs préfèrent ainsi parler de datation *quantifiable* (O'Brien et Lyman, 2002). Néanmoins, par commodité, on conserve ici cette terminologie, étant entendu qu'une date absolue est exprimée comme un point sur une échelle standard de mesure du temps (Dean, 1978).

[^2]: Anderson *et al.* 1947.

[^3]: Arnold et Libby, 1949. Libby, 1960.

[^4]: Il existe actuellement trois séries de courbes de calibration : *IntCal* pour l'hémisphère nord, *SHCal* pour l'hémisphère sud et *Marine* pour les échantillons marins.

[^5]: Au moment de la rédaction de cette leçon, la courbe IntCal20 vient d'être publiée. Reimer *et al.*, 2009, 2013, 2020.

[^6]: L'année 1950 est utilisée comme référence, car elle correspondait lors des premiers développements du radiocarbone à l'époque astronomique standard. Aujourd'hui, le choix de 1950 permet également d'avoir une référence qui précède suffisamment les conséquences des essais nucléaires atmosphériques.

[^7]: Scott, Cook et Naysmith, 2007.

[^8]: Colman, Pierce et Birkeland, 1987.

[^9]: Dans les faits, la calibration par simple interception n'a plus lieu d'être utilisée.

[^10]: Fractionnement isotopique.

[^11]: La lecture des premiers chapitres du *Manuel de biostatistique* de Millot (2014) constitue un bon support pour aborder cette leçon.

[^12]: Les raisons de cette hétérogénéité dépassent le cadre de cette leçon. Une discussion détaillée est disponible dans la littérature, voir par exemple Walsh et Schwalbe (2020).
