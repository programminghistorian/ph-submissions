---
title: "Préserver et rendre identifiables les logiciels de recherche avec Software Heritage"
slug: preserver-logiciels-recherche
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Sabrina Granger 
- Baptiste Mélès 
- Frédéric Santos
reviewers:
- Forename Surname
- Forename Surname
editors:
- Daphné Mathelier
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/616
difficulty: 1 
activity: sustaining 
topics: [data-management]
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## L'archivage des logiciels&nbsp;: une des conditions de la reproductibilité scientifique

Une recherche reproductible est une recherche plus robuste et plus transparente. Or il existe plusieurs formes de reproductibilité&nbsp;: ainsi, dans certaines disciplines, ce qui compte est davantage de pouvoir reproduire la méthode que d'obtenir les mêmes résultats. Dans cette leçon, l'accent est mis sur la reproductibilité computationnelle&nbsp;: la capacité à retrouver les mêmes résultats en utilisant les mêmes méthodes et les mêmes outils que l'auteur initial.

Si [l'archivage et l'ouverture des données de recherche](/fr/preserver-ses-donnees-de-recherche) sont de plus en plus répandus au sein de nombreuses communautés académiques, ces pratiques ne répondent que partiellement à la question de la reproductibilité des travaux scientifiques. En effet, ainsi que le soulignent Davenport et ses co-auteurs, comment comprendre ou reproduire des résultats sans accéder également au logiciel qui a permis de traiter les données&nbsp;?

> «&nbsp;A common theme is a growing emphasis on "reproducibility" being discussed in many disciplines [...]. This goes beyond "data" and requires software and analysis pipelines to be published in a usable state alongside papers[^1].&nbsp;»

Archiver les logiciels est donc un prérequis pour garantir un accès partagé aux auteurs, contributeurs, utilisateurs et lecteurs de logiciels[^2].

Quoique essentiel à la compréhension des résultats, le logiciel n'est pourtant pas toujours identifié comme une ressource à préserver&nbsp;; faute de réel archivage, maint renvoi pointe vers des sources déplacées ou perdues. Selon D. Spinellis, la demi-durée de vie d'une URL citée dans un texte publié n'est que d'environ quatre ans[^10]. Le site web d'un individu ou même d'un laboratoire n'offre aucune garantie de pérennité&nbsp;: un simple changement de fournisseur d'accès à Internet, un départ à la retraite, le changement de nom d'une institution peuvent suffire à rendre tous les liens obsolètes.

Même les «&nbsp;forges[^3]&nbsp;», plateformes de développement collaboratif en ligne telles que GitHub et GitLab — dont l'usage s'est très fortement accru ces dernières années, y compris dans le monde académique[^4] — n'offrent pas de garantie d'accès pérenne. Leurs conditions d’utilisation peuvent être modifiées et les espaces de travail fonctionnant avec une technologie donnée ne seraient alors plus maintenus. Pire encore, ces plateformes peuvent être intégralement désactivées, coupant même aux auteurs de logiciels tout accès à leur contenu — mésaventure qu'ont connue les [utilisateurs de Google Code](https://opensource.googleblog.com/2015/03/farewell-to-google-code.html). Même les forges institutionnelles offrant de plus grandes garanties en termes de services peuvent être désactivées. Les forges sont donc de puissants outils de collaboration mais ne constituent pas la solution optimale pour mettre du code informatique à disposition des lecteurs d'un article académique. Elles facilitent l'écriture du code, non sa préservation.

L'absence de recours à de vraies solutions d'archivage, tant pour les développeurs que pour les utilisateurs de logiciel, a donc des conséquences en chaîne sur tout le système de citation académique et la reproductibilité des travaux — autrement dit, en définitive, sur la qualité de la science. Aussi est-il crucial de disposer d'un archivage dans un entrepôt dédié.

## L'accès au code source des logiciels

Sous quelle forme les logiciels doivent-ils être archivés&nbsp;? Leur conception traverse en effet trois phases&nbsp;: le code source, la compilation, l'exécutable. Définissons d'abord ces termes.

### Définitions&nbsp;: code source, exécutable, compilation 

Le développement d'un logiciel commence par l'écriture d'un «&nbsp;code source&nbsp;», c'est-à-dire d'une série d'instructions écrites dans un ou plusieurs langages informatiques (par exemple Python, R, etc.), lisibles et compréhensibles par des humains. Il s'agit donc d'une représentation textuelle de l'architecture du programme et des algorithmes qui en sous-tendent le fonctionnement.

À l'autre bout de la chaîne, un «&nbsp;exécutable&nbsp;» désigne la version transformée du code source pour la rendre lisible par la machine. Cette traduction pour la machine – non lisible par les humains – prend la forme d'une série de 0 et de 1 (d'où le nom de «&nbsp;binaire&nbsp;» parfois donné comme synonyme d'«&nbsp;exécutable&nbsp;»), codant les impulsions électriques nécessaires à l'exécution du programme.

La «&nbsp;compilation&nbsp;» est le processus transformant le code source écrit par des humains en un programme exécutable pour la machine. On peut donc imaginer le code source comme une recette de cuisine, l'exécutable comme le plat obtenu en suivant la recette, et la compilation comme le travail culinaire.

L'archive Software Heritage, qui sera présentée ultérieurement, ne collecte pas d'exécutables, mais le code source correspondant car il constitue le composant du logiciel exploitable sur le long terme. En effet, la compilation n'est pas un processus aisément réversible&nbsp;: si l'on peut immédiatement passer du code source à l'exécutable, l'inverse est beaucoup plus délicat et incertain — de même qu'il ne suffit généralement pas de goûter un plat pour connaître sa recette. De plus, le code source d'un logiciel, comme une recette de cuisine, peut être inspecté, compris, éventuellement modifié et à nouveau transmis par ses utilisateurs.

Autrement dit, renvoyer vers le code source constitue la manière la plus sûre et efficace de partager du logiciel sur le long terme.

### Ce que nous apprend le code source&nbsp;: illustration 

Illustrons le fait que le code source nous donne strictement plus d'informations que le code exécutable.

Observons par exemple [un fragment de code de la mission Apollo](https://archive.softwareheritage.org/swh:1:cnt:0c1741c1fb0150f111625d02277407f628c31bac;origin=https://github.com/virtualagc/virtualagc;visit=swh:1:snp:cdcd2bc43331a436e8c659ba93175ef7d7eb339b;anchor=swh:1:rev:4e5d304eb7cd5589b924ffb8b423b6f15511b35d;path=/Luminary116/THE_LUNAR_LANDING.agc;lines=250-254). On voit que parallèlement au code «&nbsp;efficace&nbsp;», voué à dicter le comportement la machine, se trouvent en fin de ligne, derrière les croisillons (`#`), des informations destinées au lectorat humain. Ces commentaires fournissent la «&nbsp;raison d'être&nbsp;» du code destiné à la machine&nbsp;: les auteurs y expliquent pourquoi ils ont jugé pertinent d'ajouter telle ou telle ligne de code. Cela permet de s'orienter rapidement dans le code, d'identifier les lignes responsables d'un certain comportement et éventuellement de les modifier.

À la compilation, les commentaires sont purement et simplement supprimés. De ce fait, si un humain essayait de lire le code exécutable, il n'aurait pas accès à ces précieuses informations.

## Software Heritage, une infrastructure spécialisée dans l'archivage du code source 

[Software Heritage](https://www.softwareheritage.org/?lang=fr), infrastructure portée par l'Inria et l'Unesco, est dédiée à l'archivage du «&nbsp;[patrimoine logiciel mondial de l'humanité](https://www.inria.fr/fr/software-heritage-archive-mondiale-logiciel)&nbsp;».  Les trois missions de Software Heritage sont la collecte, la préservation et le partage du code des logiciels rendus publics. Pour les raisons exposées dans la section précédente, Software Heritage conserve le code source des logiciels, c'est-à-dire la partie du logiciel compréhensible par l'être humain[^5].

Le premier avantage de Software Heritage est de fournir un point d'entrée central vers des millions de logiciels, développés et disséminés dans une multitude de plateformes. Le second bénéfice pour l'utilisateur est d'accéder à des collections régulièrement mises à jour de manière automatisée. Ainsi, la personne voulant renvoyer vers une version donnée d'un logiciel a le choix parmi les différentes versions archivées. De plus, la personne qui a développé un logiciel peut compter sur une version archivée de son travail.

### Les options d'archivage 

Software Heritage fournit plusieurs options pour l'archivage des logiciels&nbsp;:

1. Un archivage automatisé&nbsp;: les contenus publics des forges les plus couramment utilisées sont archivés automatiquement, à échéance régulière&nbsp;; [la liste des forges dont le contenu est périodiquement «&nbsp;moissonné&nbsp;»](https://archive.softwareheritage.org/) inclut toutes les forges les plus populaires. La plupart des logiciels *open source* que vous utilisez sont donc très probablement déjà archivés dans Software Heritage.

2. Un archivage manuel&nbsp;: il est aussi possible d'archiver un logiciel ou de mettre à jour son archivage manuellement. En effet, ce service permet de résoudre la question de la mise à jour des contenus entre deux vagues d'archivage automatisé. Cette fonctionnalité est utilisable sans créer de compte, et il n'est pas nécessaire d'être l'auteur du logiciel pour y recourir. En revanche, si le logiciel n'est pas public, son archivage est bloqué. La [documentation](https://docs.softwareheritage.org/#landing-preserve) présente les différentes options.

La pérennité de l'accès aux logiciels archivés est garantie par des identifiants spécialisés, les *SoftWare Hash Identifiers* (SWHID), que nous découvrirons de manière plus détaillée dans les sections suivantes. À la différence d'un identifiant généraliste tel que le DOI, le SWHID est dédié au logiciel. Ainsi, le SWHID permet non seulement de renvoyer vers une version donnée, mais aussi vers différents composants du logiciel plutôt qu'au programme dans son ensemble. [Un SWHID s'obtient instantanément et gratuitement](https://annex.softwareheritage.org/public/tutorials/getswhid_dir.gif) dès lors que le logiciel est archivé dans Software Heritage.

### Les fonds de Software Heritage 

Software Heritage permet un accès unifié à des fonds issus d'une grande diversité de gisements. Outre les plateformes de développement et de distribution les plus communément utilisées, Software Heritage fournit aussi&nbsp;:

* Des contenus publics de [forges désactivées](https://archive.softwareheritage.org/browse/search/?q=googlecode.com&visit_type=git&with_content=true&with_visit=true)  comme Google Code.
* Des contenus des forges institutionnelles basées sur GitLab (par exemple [l'instance GitLab de l'IN2P3 du CNRS](https://gitlab.in2p3.fr/)) ayant fait la demande d'être versées dans l'archive.
* Des codes sources associés à des articles, grâce à ses partenariats avec des revues en sciences et technologies.
* Des [codes sources de logiciels déposés dans l'archive ouverte nationale HAL](https://archive.softwareheritage.org/browse/search/?q=hal.archives-ouvertes.fr&visit_type=deposit&with_content=true&with_visit=true). Le [dépôt dans HAL](https://hal.science/hal-01872189) permet de créer une description citable du logiciel alors que l'archivage dans Software Heritage est principalement dédié à rendre identifiable des composants techniques du logiciel (voir le chapitre de la leçon sur les identifiants pérennes). Multidisciplinaire, HAL permet de partager en libre accès les résultats de recherche, publiés ou non.

La politique documentaire de Software Heritage s'applique à l'échelle d'un gisement d'informations (forge, plateforme) et non pas logiciel par logiciel. L'enjeu est d'offrir la couverture la plus large possible. Cet objectif est motivé par la nature composite du logiciel&nbsp;: un logiciel de recherche peut ainsi s'appuyer sur des éléments issus de communautés de l'administration publique ou de l'industrie. C'est pourquoi les fonds de Software Heritage excèdent le périmètre académique.

En outre, la plus-value de Software Heritage est de préserver l'historique de développement des logiciels issus des forges, en plus du code source. L'historique de développement documente la genèse d'un logiciel et peut fournir des explications sur son fonctionnement. Voici l'exemple d'une [révision (*commit*) de 2008](https://archive.softwareheritage.org/browse/revision/64ac24e738823161693bf791f87adc802cf529ff/?origin_url=git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git&snapshot=fc7706e4c177714475a4886831486ad0979983ea#swh-revision-changes-list) rédigée par Matthew Wilcox&nbsp;:

> «&nbsp;Generic semaphore implementation       
> Semaphores are no longer performance-critical, so a generic C implementation is better for maintainability, debuggability and extensibility. Thanks to Peter Zijlstra for fixing the lockdep warning. Thanks to Harvey Harrison for pointing out that the unlikely() was unnecessary.      
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>       
> Acked-by: Ingo Molnar <mingo@elte.hu>&nbsp;»     

Lorsqu'un code source est développé dans une forge, chaque modification peut être documentée à l'aide d'une "révision" (*commit*). L'ensemble des révisions permettent de reconstituer l'historique des changements apportés. Dans l'exemple ci-dessus, Matthew Wilcox justifie sa démarche visant à simplifier une partie du noyau Linux en remplaçant 7679 lignes complexes par 314 lignes élémentaires dans 113 fichiers. La révision incarne l'unité intellectuelle qui sous-tend toute cette diversité de modifications ponctuelles. Un historique de développement peut ainsi fournir des informations contextuelles précieuses pour comprendre la structure d'un logiciel.

Enfin, si le code source d'un logiciel est supprimé de son emplacement d'origine, cela n'a pas d'impact sur les fonds de Software Heritage. Les évolutions du code source sont archivées mais si la ressource est supprimée, ce changement n'est pas répercuté, ce qui prémunit du risque de lien brisé.

## Rendre les logiciels identifiables 

Les logiciels constituent des ressources particulièrement difficiles à identifier sur le long terme. Comment surmonter ces difficultés&nbsp;?

### Les besoins d'identification spécifiques au logiciel 

Pourquoi est-il si difficile d'identifier un logiciel&nbsp;? Certaines raisons sont contextuelles&nbsp;:

* la liste ou le rôle des contributeurs d'un logiciel peut évoluer&nbsp;: une personne qui faisait partie des auteurs principaux de la version 1 peut devenir un testeur de la version 2 ;
* les logiciels peuvent changer de noms comme de plateforme de développement. Les articles contenant des liens vers des forges ou des sites web classiques sont alors des liens brisés.

D'autres raisons sont inhérentes à la nature même du logiciel&nbsp;:

* les logiciels connaissent des montées de versions mineures comme majeures, et on peut souhaiter citer une version, voire une étape précise du développement d'une version ;
* les logiciels, même simples en apparence, font intervenir de nombreux composants et leur architecture peut être complexe. Autrement dit, on peut avoir besoin de faire référence uniquement à un élément du logiciel et pas au produit dans son intégralité.

Ainsi, l'archivage des logiciels est une tâche fondamentalement différente de l'archivage de jeux de données. Les données associées à un article ou un projet scientifique sont généralement dans un état «&nbsp;figé&nbsp;», unique et définitif, dont il suffit d'assurer la disponibilité de long terme, à l'aide d'un entrepôt dédié et d'un identifiant de type DOI. Inversement, le code source est un contenu fortement évolutif&nbsp;: il convient donc de garder la trace de toutes les versions mises à disposition du public. De plus, chaque production de code informatique, y compris dans le cas des scripts les plus simples, possède généralement une structure sous-jacente très complexe&nbsp;: aucun extrait de code ne peut exister en dehors d'un environnement d'exécution élaboré, devant donc à son tour être archivé et versionné. La nature fondamentalement évolutive et modulaire des logiciels appelle donc des solutions spécifiques en termes d'archivage et d'identification.

### Pourquoi citer les logiciels 

Citer un logiciel s'avère nécessaire lorsque celui-ci a joué un rôle déterminant dans la réalisation des travaux de recherche. La question suivante peut servir de repère&nbsp;: dans quelle mesure le logiciel a-t-il un impact direct sur les résultats obtenus&nbsp;? S'il n'est pas pertinent de citer un outil de traitement de texte, il est par exemple judicieux de citer le logiciel de reconnaissance optique de caractères utilisé. Il est courant de voir cité un article décrivant le logiciel plutôt que le logiciel lui-même.  Or, cette pratique n'est pas la plus adaptée car elle ne permet pas d'identifier facilement et avec certitude le logiciel en question, ainsi que le démontre M. Jackson&nbsp;:

> «&nbsp;The authors had cited an OGSA-DAI paper that should have meant they were using a version of the software between OGSA-DAI 1 and 6. Later in their paper, the authors mentioned a component that was specific to OGSA-DAI versions 2.5 to 6. However, the authors then talked of another component and a toolkit, which was only available  with a completely different version of the software. Without my highly detailed knowledge of the OGSA-DAI project, it would have been impossible to determine what software was used[^6].&nbsp;»

Par ailleurs, il n'existe pas toujours d'article associé au logiciel&nbsp;: il peut avoir été développé en dehors d'une communauté académique, ou simplement, n'avoir jamais été présenté dans une revue. Cela renforce donc le besoin de citer le logiciel lui-même, au même titre qu'une autre ressource académique. Les pratiques de citation de logiciels ne sont pas encore très codifiées dans les communautés académiques. Il n'existe pas de standard descriptif. Sur la base de recommandations d'experts, voici une proposition de noyau minimal d'informations à mentionner[^7]:

* le nom du logiciel de la manière la plus précise possible (par exemple le nom du *package*) ;
* la date de mise à disposition de la version ou, à défaut, la date d’utilisation du logiciel par l’utilisateur à l'instar de ce qui se pratique pour les citations de pages web ;
* l’auteur du logiciel ;
* la localisation initiale (par exemple le lien vers la plateforme de développement) ;
* l’identifiant pérenne (par exemple le SWHID).

Les utilisateurs de LaTeX peuvent utiliser le [biblatex-software *package*](https://ctan.org/pkg/biblatex-software) pour faciliter la tâche.

### Utiliser des identifiants pérennes adaptés

Les identifiants pérennes sont un moyen d'assurer un accès stable à une ressource, par exemple un document en ligne ou une description de document. Ils permettent d'établir des liens entre des informations de différentes natures&nbsp;: on sait par exemple qu'un article donné, identifié par un DOI, a été rédigé par telle personne, identifiée à son tour par sa référence [ORCID (*Open Researcher or Contributor ID*)](https://orcid.org/). Et cette personne exerce dans une institution elle-même identifiée *via* le [*Research Organization Registry* (ROR)](https://ror.org/about/).

Le Comité pour la science ouverte définit ainsi un identifiant pérenne&nbsp;:

> «&nbsp;numéro ou une étiquette alphanumérique, opaque ou explicite, lisible par des machines et par des humains, permettant de désigner et de retrouver de manière univoque et pérenne un objet, un document, une personne, un lieu, un organisme, ou toute entité, dans le monde réel et sur internet[^8].&nbsp;»

Les identifiants réduisent les ambiguïtés&nbsp;: il peut en effet parfois être difficile de savoir si tel auteur ayant publié dans une discipline donnée est l'homonyme d'un autre auteur publiant dans un domaine proche, ou s'il s'agit d'une seule personne active dans plusieurs champs. On peut également citer le cas des institutions, dont le nom peut changer au fil du temps. Plusieurs institutions peuvent fusionner et former une nouvelle entité à décrire. Ces changements rendent difficiles l'identification des ressources produites par ces instances.

On peut également noter que les objets académiques à identifier se sont diversifiés et le logiciel fait partie des ressources vers lesquelles il est nécessaire de créer des liens valables sur le long terme.

### Obtenir et utiliser un *SoftWare Hash Identifier* (SWHID) 

Comme nous l'avons vu précédemment, même si le DOI est l'identifiant le plus connu et le plus utilisé dans le monde académique, il n'est pas le plus adapté à l'identification des logiciels&nbsp;: on n'a généralement pas de DOI associé à chaque composant du logiciel — encore moins à chaque étape fine de son processus de développement.

Le *SoftWare Hash Identifier* permet de pointer vers différents composants du logiciel, ainsi que vers des actions de son historique de développement. Il en existe cinq types différents en fonction de la façon dont on souhaite faire référence à un logiciel donné. La [documentation technique](https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html#id5) détaille les types de SWHIDs disponibles. En voici une synthèse&nbsp;:

<div class="table-wrapper" markdown="block">

| Type de contenus à identifier | Type de SWHID à utiliser |
|-------------------------------|--------------------------|
| L'accent est mis sur un point de l'historique de développement | [*snapshot*](https://archive.softwareheritage.org/swh:1:dir:d198bc9d7a6bcf6db04f476d29314f157507d505;visit=swh:1:snp:c7c108084bc0bf3d81436bf980b46e98bd338453;anchor=swh:1:rev:50d91bdfc94cb9d3aa01634ac0b003d76e799bf1), [*release*](https://archive.softwareheritage.org/swh:1:rel:22ece559cc7cc2364edc5e5593d63ae8bd229f9f), [*revision*](https://archive.softwareheritage.org/swh:1:rev:309cf2674ee7a0749978cf8265ab91a60aea0f7d) |
| L'accent est mis sur l'ensemble des contenus du code source à un moment donné | [*directory*](https://archive.softwareheritage.org/swh:1:dir:d198bc9d7a6bcf6db04f476d29314f157507d505) |
| L'accent est mis sur une portion précise de code source à un moment donné | [*content*](https://archive.softwareheritage.org/swh:1:cnt:94a9ed024d3859793618152ea559a168bbcbb5e2) |

</div>


### Quel identifiant pour quel besoin&nbsp;? 

Le tableau suivant résume les informations présentées dans cette section.

<div class="table-wrapper" markdown="block">

| Citer un logiciel ... | Effectuer des vérifications techniques ... |
| ------ | ------ |
| ... pour attribuer correctement les responsabilités intellectuelles, pour renvoyer vers une version donnée. | ... pour s'assurer de la reproductibilité des résultats obtenus avec le logiciel, pour obtenir des informations sur le processus de développement lui-même. |
| ... nécessite qu'un identifiant pérenne soit attribué à chaque version. L'identifiant doit renvoyer vers des objets et vers leur description générale. | ... nécessite qu'un identifiant pérenne renvoie à des composants précis du logiciel, qu'il s'agisse du code source comme d'explications fournies par les développeurs pour documenter leurs actions. L'identifiant doit renvoyer directement vers le contenu de l'objet. |
| Type d'identifiants : [DOI](https://doi.org/10.5281/zenodo.6375528), [HAL-ID](https://hal.science/hal-03516539v1) | Type d'identifiant : [SWHID](https://archive.softwareheritage.org/swh:1:cnt:353bd74b1b29c30b9b47843ddc8dc0180b37a465;origin=https://github.com/rdicosmo/parmap;visit=swh:1:snp:2128ed4f25f2d7ae7c8b7950a611d69cf4429063;anchor=swh:1:dir:2dc0f462d191524530f5612d2935851505af41dd;path=/dune-project) |
| Analogie : la carte d'identité | Analogie : les empreintes digitales, l'échantillon d'ADN |
| Obtenir ce type d'identifiant : information sur la page du logiciel déposé au préalable sur [une plateforme d'archivage](https://zenodo.org/records/6461551), [une archive ouverte](https://hal.science/hal-03516539v1) | Obtenir ce type d'identifiant : le logiciel est [archivé dans Software Heritage](https://archive.softwareheritage.org/swh:1:dir:2dc0f462d191524530f5612d2935851505af41dd;origin=https://github.com/rdicosmo/parmap;visit=swh:1:snp:2128ed4f25f2d7ae7c8b7950a611d69cf4429063) |

</div>

Ces différents identifiants sont complémentaires car ils répondent à des besoins différents. Ainsi, un HAL-ID renvoie vers une description de logiciel incluant un SWHID chargé de pointer vers un contenu donné. Si l'on souhaite renvoyer vers un fichier précis, il faut recourir au SWHID.

## En pratique&nbsp;: trouver et référencer des logiciels archivés

Dans cette section, nous voyons comment trouver dans l'archive Software Heritage les logiciels que vous utilisez et comment obtenir les identifiants dont vous avez besoin pour les citer correctement dans vos productions académiques. Référencer un logiciel signifie lui attribuer un identifiant pérenne.

### Naviguer et rechercher des logiciels sur Software Heritage 

Pour consulter ou citer du code source sur Software Heritage, il faut déjà l'avoir trouvé dans l'archive. Mais comment s'orienter dans une archive aussi foisonnante&nbsp;? Selon le degré d'information que vous possédez sur la ressource recherchée, vous vous trouverez dans l'une des situations suivantes&nbsp;:

1. Vous ne connaissez que le _nom du projet_, par exemple «&nbsp;Linux&nbsp;».
2. Vous possédez un _fichier du code source_, par exemple le texte de la GNU General Public License v3. 
3. Utilisateur avancé, vous connaissez un _extrait du code_, par exemple `unsigned three = 1;`.
4. Vous connaissez l'_adresse du dépôt de référence_ du projet, par exemple <https://github.com/torvalds/linux>.
5. Utilisateur avancé, vous possédez un _code de hachage_ permettant d'identifier un certain fichier, un répertoire, une version ou une révision.
6. Vous possédez un *SoftWare Hash Identifier* (SWHID).

#### Cas d'étude quand vous explorez Software Heritage 

Examinons chacun des cas présents, en allant du point de départ le plus imprécis vers le plus précis. Les options 1, 2, 4 et 6 permettent une interrogation facilitée de Software Heritage (Fig. 1).

{% include figure.html filename="fr-or-preserver-logiciels-recherche-01.png" alt="Logigramme représentant les différents points d'entrée à partir desquels rechercher un logiciel sur Software Heritage." caption="Figure 1. Tous les chemins mènent à Software Heritage." %}

##### Option 1. Vous ne connaissez que le _nom du projet_
Par exemple pour le projet «&nbsp;Linux&nbsp;», le plus simple est de chercher son dépôt officiel dans un moteur de recherche ou un catalogue de logiciels (tel que le [catalogue des logiciels du MédiaLab de SciencesPo](https://medialab.sciencespo.fr/outils/)). En tapant «&nbsp;Linux source code&nbsp;» dans un moteur de recherche, vous tomberez assez rapidement sur une page intitulée «&nbsp;GitHub - torvalds/linux: Linux kernel source tree&nbsp;» à l'adresse <https://github.com/torvalds/linux>. Cette adresse est celle de l'«&nbsp;origine&nbsp;», c'est-à-dire du dépôt distant de référence. Elle permet de retrouver très facilement le code source sur Software Heritage, comme vous le verrez dans le point 4 ci-dessous.

##### Option 2. Vous possédez un _fichier du code source_
Par exemple pour le texte de la GNU Public Licence v3, rendez-vous à l'adresse <https://www.softwareheritage.org/>. Glissez et déposez votre fichier dans l'encadré intitulé «&nbsp;Vérifiez si le code source qui vous intéresse est déjà présent dans l’archive&nbsp;», puis cliquez sur «&nbsp;Search&nbsp;». Un menu déroulant vous indiquera alors si le code figure sur Software Heritage et quel est son code de hachage, par exemple `8624bcdae55baeef00cd11d5dfcfa60f68710a02`. Cliquer sur «&nbsp;Browse&nbsp;» vous permettra de visualiser ce fichier à l'adresse <https://archive.softwareheritage.org/browse/content/8624bcdae55baeef00cd11d5dfcfa60f68710a02/?path=GPL-3>.

##### Option 3. Vous connaissez un _extrait du code_
Considérons par exemple l'extrait `unsigned three = 1;`. Vous pouvez chercher davantage d'informations à son sujet à l'aide d'un moteur de recherche. Jonglez avec les guillemets pour cibler l'expression exacte (comme lorsque vous effectuez une recherche dans un catalogue ou un moteur de recherche, ajouter des guillemets permet de faire porter la recherche sur l'expression telle que formulée), et ajoutez des mots-clefs pour affiner les résultats. En tapant par exemple «&nbsp;"unsigned three = 1" source code&nbsp;», vous trouverez rapidement un lien vers la page <https://github.com/torvalds/linux/blob/master/fs/ext4/resize.c>, ce qui vous indique l'adresse d'origine du projet et vous conduit une fois de plus à la situation décrite dans le point 4 ci-dessous.

##### Option 4. Vous connaissez l'_adresse du dépôt de référence_ d'un projet
Si vous connaissez par exemple l'adresse <https://github.com/torvalds/linux> du projet Linux, il suffit de la saisir dans la [barre de recherche de Software Heritage](https://archive.softwareheritage.org/browse/search/). Vous serez alors automatiquement redirigé vers [la page correspondante de l'archive](https://archive.softwareheritage.org/browse/origin/directory/?origin_url=https://github.com/torvalds/linux), qui vous permettra de naviguer dans le code source de Linux. Vous pouvez par exemple explorer le fichier `fs/ext4/resize.c` jusqu'à trouver la ligne contenant l'instruction paradoxale `unsigned three = 1;`&nbsp;;

##### Option 5. Vous connaissez un _code de hachage_
Vous êtes un utilisateur suffisamment expérimenté et possédez le _code de hachage_ (SHA-1) permettant d'identifier un certain fichier, un répertoire, une version ou une révision. Par exemple, en visitant l'adresse <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=64ac24e738823161693bf791f87adc802cf529ff>, vous avez trouvé le numéro de révision (*commit*) `64ac24e738823161693bf791f87adc802cf529ff`, ou bien vous savez que le code de hachage d'un fichier est `8624bcdae55baeef00cd11d5dfcfa60f68710a02`. Vous pouvez alors explorer la page correspondante en rajoutant l'un des préfixes suivants, selon le type de la ressource&nbsp;:

	* pour un fichier&nbsp;: <https://archive.softwareheritage.org/browse/content/> ;
	* pour un répertoire&nbsp;: <https://archive.softwareheritage.org/browse/directory/> ;     
	* pour une capture&nbsp;: <https://archive.softwareheritage.org/browse/snapshot/> ;    
	* pour une version&nbsp;: <https://archive.softwareheritage.org/browse/release/> ;    
	* pour une révision&nbsp;: <https://archive.softwareheritage.org/browse/revision/>.

    On trouvera donc la révision `64ac24e738823161693bf791f87adc802cf529ff` à l'adresse <https://archive.softwareheritage.org/browse/revision/64ac24e738823161693bf791f87adc802cf529ff>, et le fichier dont le code est `8624bcdae55baeef00cd11d5dfcfa60f68710a02` à l'adresse 	<https://archive.softwareheritage.org/browse/content/8624bcdae55baeef00cd11d5dfcfa60f68710a02>. Vous pouvez également, pour chacun de ces types de ressources — à l'exception notable des fichiers —, obtenir un *SoftWare Hash Identifier* (SWHID) en ajoutant le préfixe correspondant&nbsp;:

	* `swh:1:dir:` pour un répertoire ;    
	* `swh:1:snp:` pour une capture ;    
	* `swh:1:rel:` pour une version ;    
	* `swh:1:rev:` pour une révision.

   Vous vous trouverez alors dans la situation abordée dans le point 6 ci-dessous.

##### Option 6. Vous possédez un identifiant _SoftWare Hash Identifier_ (SWHID)
Vous pouvez alors le taper dans la [barre de recherche de l'archive](https://archive.softwareheritage.org/browse/search/). Par exemple, si vous y saisissez l'identifiant `swh:1:dir:1fee702c7e6d14395bbf5ac3598e73bcbf97b030`, vous serez redirigé vers la page <https://archive.softwareheritage.org/browse/directory/1fee702c7e6d14395bbf5ac3598e73bcbf97b030/>.

À noter&nbsp;: le recours aux catalogues de logiciels reste une pratique peu répandue, y compris parmi les développeurs. Pourtant, ces outils spécialisés permettent des recherches plus ciblées que les moteurs généralistes. Vous connaissez les institutions dont les domaines d'expertise sont proches des vôtres&nbsp;: vérifiez s'il n'existe pas un catalogue recensant la production logicielle de cet établissement. Votre propre institution a peut-être développé un tel outil.

#### Exercice&nbsp;: mettre en œuvre sa stratégie de recherche

Mettons à présent ces notions en pratique. Trouvez dans l'archive Software Heritage&nbsp;:

1. Le code du programme LanguageTools.
2. Le code contenant les mots «&nbsp;you are not expected to understand this&nbsp;».
3. Le code correspondant aux dépôts <https://github.com/CatalaLang/catala> et [rsync://ftp.gnu.org/gnu/gcc/gcc-4.9.3](rsync://ftp.gnu.org/gnu/gcc/gcc-4.9.3).
4. Le fichier composé des lignes suivantes&nbsp;: 
	```c
	#include <stdio.h>

	int main(void) {
		printf("Hello, World!\n");
	}
	```
5. Le répertoire dont le SWHID est `swh:1:dir:f72ab78156c5a4f05d394afa7a2f5911e1f33e27`.

### Choisir l'identifiant pérenne à intégrer dans une citation 

Maintenant que vous savez naviguer dans l'archive et que vous avez vu ci-dessus les différents types de SWHIDs permettant de répondre aux différents besoins de citation d'un logiciel, donnons ci-dessous deux cas concrets. Dans ces situations, des identifiants pérennes bien choisis sont nécessaires pour répondre aux besoins des chercheurs qui souhaitent faire référence à des logiciels ou des portions de code source dans leurs productions académiques.

1. Une doctorante souhaite citer les logiciels utilisés pendant sa thèse pour permettre à ses lecteurs d'identifier et retrouver le code source correspondant, et de reproduire les résultats présentés dans son manuscrit. Elle a notamment utilisé le *package* R `{rdss}` pour une partie de ses analyses statistiques. Comme de nombreux autres *packages* R, `{rdss}` est seulement [disponible sur la forge GitLab.com](https://gitlab.com/f-santos/rdss). Bien que librement téléchargeable, ce *package* pourrait ne plus être disponible du jour au lendemain, si la forge GitLab.com fermait soudainement ses portes, ou si son auteur en retirait ce *package* sans préavis. Les résultats présentés dans la thèse de cette doctorante seraient alors impossibles à auditer et à reproduire par les membres de son jury, ou par les futurs lecteurs de son travail. Comment peut-elle fournir un identifiant pérenne pour permettre à ses lecteurs d'accéder durablement à la version de `{rdss}` utilisée dans son manuscrit, à savoir la version (ou  *release*) 1.1.1&nbsp;?

2. Un chercheur rédige un article cherchant à comparer la performance de divers algorithmes de fouille de textes, ou *text mining*, une méthode utile notamment aux historiens. Un lot de méthodes efficaces en fouille de textes est par exemple implémenté dans le [*package* R `{tm}`](https://archive.softwareheritage.org/browse/origin/directory/?origin_url=https://cran.r-project.org/package%3Dtm&snapshot=99204e5a7070f348901b0e966a7ffbbe3db0a9b9&visit_type=cran). Notre chercheur pense avoir développé des fonctions en langage R encore plus rapides et économes en temps de calcul sur de grands jeux de données, en apportant des améliorations décisives à certains endroits du *package* `{tm}`. Par exemple, en considérant la version 0.7-9 du *package* `{tm}`, il souhaite signaler qu'il a mis au point une version plus rapide d'une fonction nommée`tm_scan_one`, dont le code est situé dans le [fichier `src/scan.c`](https://archive.softwareheritage.org/browse/content/sha1_git:e76e4f8b6a1d34dcb55cebaa0f4b91e5a186dd08/?origin_url=https://cran.r-project.org/package%3Dtm&path=tm/src/scan.c&snapshot=99204e5a7070f348901b0e966a7ffbbe3db0a9b9&visit_type=cran) du package. En particulier, ce chercheur a apporté une amélioration décisive à la portion de code comprise entre les lignes 46 à 65, écrite en langage C. Comment peut-il faire référence de manière pérenne à cette portion de code dans son projet de publication&nbsp;?

**Solutions**

1. Le but est ici de citer une *version* d'un logiciel&nbsp;: le bon identifiant SWHID est donc un identifiant portant sur la *release*. Sur [la page adéquate](https://archive.softwareheritage.org/browse/origin/directory/?origin_url=https://gitlab.com/f-santos/rdss) de l'archive Software Heritage, on peut sélectionner la "release" 1.1.1, puis obtenir l'identifiant de version `swh:1:rel:ef8ba743282a602d8b105ce82e1f6f48779d7998` grâce au menu Permalinks situé à droite de l'écran (Fig. 2). 

{% include figure.html filename="fr-or-preserver-logiciels-recherche-02.gif" alt="Gif animé présentant les manipulations nécessaires pour trouver le package R rdss dans l'archive Software Heritage." caption="Figure 2. Trouver et citer une version précise d'un package R dans l'archive Software Heritage." %}

2\. Le but est ici de citer un *extrait de code* contenu dans un fichier source, à une étape donnée du développement d'un logiciel. Le bon identifiant SWHID est donc un identifiant de type *content*, c'est-à-dire, portant sur le contenu d'un fichier précis. Sur [la page adéquate](https://archive.softwareheritage.org/browse/content/sha1_git:e76e4f8b6a1d34dcb55cebaa0f4b91e5a186dd08/?origin_url=https://cran.r-project.org/package=tm&path=tm/src/scan.c&snapshot=99204e5a7070f348901b0e966a7ffbbe3db0a9b9&visit_type=cran#L46-L65) ] de l'archive Software Heritage, on peut sélectionner la "release" 0.7-9 du *package*, puis les lignes 46 à 65, pour enfin obtenir l'identifiant de contenu `swh:1:cnt:e76e4f8b6a1d34dcb55cebaa0f4b91e5a186dd08` grâce au menu Permalinks situé à droite de l'écran (Fig. 3).    

{% include figure.html filename="fr-or-preserver-logiciels-recherche-03.gif" alt="Gif animé présentant les manipulations nécessaires pour sélectionner un extrait de code du package R tm dans l'archive Software Heritage." caption="Figure 3. Trouver et citer un extrait de code source précis dans l'archive Software Heritage." %}

## Archiver du code source 

Dans cette section, vous allez principalement vous placer du point de vue des producteurs de code source, en créant un dépôt contenant un bref extrait de code et en assurant son archivage sur Software Heritage. Toutefois, rappelons qu'il n'est pas nécessaire d'être l'auteur d'un logiciel pour en demander l'archivage sur Software Heritage.

### Dans quels cas archiver manuellement du code source 

La grande majorité du code source archivé sur Software Heritage provient des «&nbsp;moissons&nbsp;» automatiques effectuées périodiquement depuis différentes sources. Notons que ces moissons automatiques sont faites «&nbsp;sans filtre&nbsp;»&nbsp;: Software Heritage n'effectue pas de test technique pour vérifier si un logiciel fonctionne.

Entre ces moissons périodiques, tout auteur ou utilisateur de logiciel a la possibilité de déclencher manuellement l'archivage d'un nouveau dépôt, ou la mise à jour d'un dépôt existant. Il s'agit de l'option «&nbsp;[Save Code Now](https://archive.softwareheritage.org/save/)&nbsp;», permettant de soumettre l'URL d'un dépôt de code source qui sera alors inspecté puis archivé par Software Heritage dans son état le plus récent. Il existe au moins deux cas où vous pourrez souhaiter utiliser cette option&nbsp;:

1. Vous êtes utilisateur d'un logiciel et avez utilisé sa toute dernière version pour produire les résultats d'un article que vous vous préparez à soumettre. Vous souhaitez utiliser un SWHID judicieusement choisi (en l'occurrence, un SWHID de type `release`) pour citer ce logiciel dans votre article. Malheureusement, la dernière version de ce logiciel n'a pas encore été moissonnée automatiquement par Software Heritage, et le SWHID correspondant ne peut donc pas être encore être produit. Vous souhaitez donc utiliser l'option «&nbsp;Save Code Now&nbsp;» afin que Software Heritage visite à nouveau le dépôt de ce logiciel, et en archive la dernière version. Le SWHID dont vous avez besoin sera alors disponible. 
2. Vous êtes auteur d'un logiciel développé sur la forge GitLab.com et vous souhaitez le publier rapidement. Vous ne pouvez pas attendre que le dépôt GitLab soit moissonné automatiquement et souhaitez en déclencher l'archivage tout de suite afin de pouvoir fournir une URL stable (et un SWHID) dans l'article de présentation de votre logiciel.

Étudions concrètement le premier de ces deux cas, avec le point de vue d'un utilisateur non-développeur.

### Vérifier que la version archivée d'un dépôt est à jour 

À un instant donné, il se peut que la version d'un logiciel actuellement disponible sur l'archive Software Heritage corresponde à une version antérieure à celle disponible sur la source officielle. Cela est particulièrement susceptible de se produire pour les logiciels en développement très actif dont l'évolution est rapide, avec parfois plusieurs dizaines de nouvelles révisions par jour. En effet, Software Heritage est une archive et non une forge, et n'a donc pas vocation à offrir en temps réel les dernières versions de l'ensemble des logiciels référencés. On peut néanmoins vérifier aisément si la version disponible sur l'archive Software Heritage est à jour.

Prenons l'exemple d'un logiciel libre développé collaborativement sur la forge logicielle GitHub&nbsp;: le *package* `citar` pour l'éditeur de texte [Emacs](https://www.gnu.org/software/emacs/). En naviguant sur le dépôt correspondant de l'archive Software Heritage (Fig. 4), on peut repérer la date du dernier *snapshot* effectué sur le dépôt GitHub (ici encadrée en bleu), ainsi que le *hash* (c'est-à-dire l'identifiant) de la dernière modification connue sur ce dépôt (ici encadré en vert). En comparant ces éléments avec la date et le *hash* de la dernière modification effectuée sur [le dépôt GitHub d'origine](https://github.com/emacs-citar/citar), on peut donc savoir si la version archivée est à jour ou non.

{% include figure.html filename="fr-or-preserver-logiciels-recherche-04.png" alt="Capture d'écran mettant en évidence les endroits où repérer la date d'archivage et le code de hachage d'une version précise du package citar dans l'archive Software Heritage." caption="Figure 4. Capture d'écran de la version archivée du *package* Emacs `citar`." %}

Notons qu'une extension de navigateur, [UpdateSWH](https://www.softwareheritage.org/browser-extensions/), disponible pour les principaux navigateurs web, facilite cette opération. Après l'avoir installée, il suffit de visiter le dépôt d'origine d'un logiciel sur une forge moissonnée par Software Heritage. Une icône s'affiche alors à droite de l'écran, accompagnée d'une infobulle précisant si la version de la forge de développement coïncide ou non avec celle de Software Heritage (Fig. 5). Ici, la dernière version de `citar` disponible sur GitHub est plus récente que celle archivée sur Software Heritage&nbsp;: les modifications les plus récentes n'ont donc pas encore été archivées.

{% include figure.html filename="fr-or-preserver-logiciels-recherche-05.png" alt="Capture d'écran mettant en évidence la manière de repérer si un dépôt est à jour ou non dans l'archive Software Heritage." caption="Figure 5. Capture d'écran du dépôt GitHub du *package* Emacs `citar`. Le plug-in de navigateur Software Heritage fournit des informations dans l'infobulle à droite." %}

### En pratique&nbsp;: archiver du code source que vous avez écrit 

Afin de reprendre le cas d'usage le plus fréquent, vous allez créer un dépôt sur une forge logicielle basée sur [Git](https://git-scm.com/), avant d'y éditer des extraits de code. Git est un logiciel de versionnement avancé, permettant de gérer finement les versions successives de fichiers (au format texte brut principalement) d'un même projet lors de l'avancée du travail, de garder la trace de chaque modification effectuée (date, auteur, contenu) et de pouvoir revenir à des versions antérieures de ces fichiers. Il existe d'autres systèmes de gestion de version (par exemple Mercurial ou SVN), mais la plupart des forges logicielles actuelles utilisent Git, et offrent ainsi une plateforme web centralisant l'avancée d'un projet, en particulier dans le cas d'un développement collaboratif.

<div class="alert alert-warning"> 
Vous n'avez pas besoin d'avoir déjà utilisé Git pour faire les exercices. Nous proposons la création d'un compte sur la forge logicielle GitLab.com, et vous utiliserez l'éditeur de code en ligne directement intégré sur cette forge.

Mais si vous êtes au contraire déjà un utilisateur régulier de Git, vous pouvez effectuer l'exercice en utilisant votre compte sur une autre forge logicielle (par exemple GitHub, ou une forge institutionnelle), et en utilisant Git en ligne de commande avec les instructions <code>add</code>, <code>commit</code>, <code>push</code>, etc., si vous en avez l'habitude. 
</div>

#### Créer un dépôt GitLab 

1. Si ce n'est pas déjà fait, commencez par [vous créer un compte sur GitLab.com](https://gitlab.com/users/sign_up). 
2. Vous pourrez ensuite [vous connecter sur cette forge](https://gitlab.com/users/sign_in) avec vos identifiants. 
3. Dans l'interface de GitLab, ou [en suivant ce lien](https://gitlab.com/projects/new), choisissez l'option «&nbsp;Créer un projet vide&nbsp;», dans lequel vous hébergerez par la suite du code source. 
4. Choisissez par exemple `Test SWH` comme nom de projet, et veillez à ce que le «&nbsp;Niveau de visibilité&nbsp;» du projet soit réglé sur «&nbsp;Public&nbsp;». (Sans cela, le code source du projet ne serait accessible que par vous, et ne pourrait donc pas être moissonné par Software Heritage.) 
5. Validez enfin la création de ce nouveau projet en cliquant sur le bouton «&nbsp;Créer le projet&nbsp;» (Fig. 6).

{% include figure.html filename="fr-or-preserver-logiciels-recherche-06.png" alt="Capture d'écran indiquant les informations correctes à renseigner pour créer un nouveau projet sur la forge GitLab.com : nom, slug et visibilité." caption="Figure 6. Créer un nouveau projet dans l'interface de GitLab.com." %}

#### Écrire une portion de code 

Vous devriez alors arriver sur la page du nouveau projet `Test SWH` ainsi créé. Ce projet est pour l'instant vide, à l'exception d'un fichier `README.md` prérempli.

Vous pouvez à présent insérer un extrait de code dans votre projet. Par exemple, vous pouvez réutiliser l'extrait de code suivant (en langage Bash), prenant en argument une année, et déterminant si cette année est bissextile ou non.

```bash
#!/usr/bin/env bash

# Check arguments:
if [[ $# -ne 1 || ! $1 =~ ^[0-9]*$ ]]
then
    echo "Usage: leap.sh <year>"
    exit 1
fi

# Do we have a leap year?
if (($1 % 400 == 0)) || ( (($1 % 4 == 0)) && (($1 % 100 != 0)) )
then
    echo "true"
else
    echo "false"
fi

exit 0
```

Pour ce faire, dans l'interface de GitLab.com, cliquez sur le bouton `+` situé en haut de la page du dépôt, puis choisissez «&nbsp;Nouveau fichier&nbsp;». Dans la nouvelle fenêtre qui s'ouvre, collez l'extrait de code ci-dessus, puis attribuez le nom `leap.sh` à ce fichier source dans le champ Filename. Enfin, en bas de la page, cliquez sur Valider les modifications pour effectuer une révision (ou *commit*). Après cela, le fichier `leap.sh` est ajouté à votre dépôt, et une révision associée à la création de ce fichier a bien été enregistrée (Fig. 7).

{% include figure.html filename="fr-or-preserver-logiciels-recherche-07.gif" alt="Gif animé montrant les manipulations nécessaires pour ajouter un nouveau fichier dans le dépôt sur l'interface en ligne de GitLab.com, et effectuer un nouveau commit après cela." caption="Figure 7. Ajout du fichier `leap.sh` dans votre dépôt." %}

#### Ajouter une licence 

Maintenant que votre dépôt comporte du code, il est nécessaire de lui ajouter une licence pour en spécifier les conditions d'utilisation. Cela peut être réalisé très aisément dans l'interface de GitLab.com, en cliquant sur le lien «&nbsp;Ajouter une LICENCE&nbsp;» dans la page d'accueil du dépôt. Vous pouvez alors choisir la licence de votre choix dans la liste déroulante «&nbsp;Appliquer un modèle&nbsp;». Choisissez par exemple la licence GNU Affero General Public License v3.0, puis cliquez à nouveau sur «&nbsp;Valider les modifications&nbsp;» en bas de la page. Cela crée une nouvelle révision associée à l'ajout du fichier `LICENSE` dans votre dépôt (Fig. 8).

{% include figure.html filename="fr-or-preserver-logiciels-recherche-08.gif" alt="Gif animé montrant les manipulations nécessaires pour ajouter une licence dans le dépôt sur l'interface en ligne de GitLab.com." caption="Figure 8. Ajout d'une licence." %}

#### Déclencher l'archivage du dépôt 

Votre dépôt GitLab possède désormais un contenu raisonnable&nbsp;: un fichier de code en langage Bash, une licence en spécifiant les conditions d'utilisation, et un template de fichier README. Ce dépôt peut à présent être archivé sur Software Heritage. Deux options sont possibles pour cela&nbsp;:

1\. Manuellement, avec l'option «&nbsp;Save Code Now&nbsp;». Visitez [la page dédiée](https://archive.softwareheritage.org/save/) sur le site de Software Heritage. Entrez l'URL de votre dépôt `Test SWH` créé sur GitLab.com. Notons que, par défaut, le champ «&nbsp;Origin type&nbsp;» est correctement attribué, avec la valeur `git` (qui correspond effectivement au cas d'un dépôt GitLab). Collez dans le champ «&nbsp;Origin URL&nbsp;» l'adresse que vous pouvez récupérer sur la page GitLab de votre dépôt, en cliquant sur le bouton «&nbsp;Code&nbsp;», puis «&nbsp;Cloner avec HTTPS&nbsp;» (Fig. 9). 

{% include figure.html filename="fr-or-preserver-logiciels-recherche-09.gif" alt="Gif animé montrant comment archiver manuellement un dépôt GitLab dans l'interface de Software Heritage : dans le menu Save code now, indiquer l'URL du dépôt dans le champ Origin url." caption="Figure 9. Archiver manuellement un dépôt." %}

2\. Alternative&nbsp;: vous pouvez également choisir d'utiliser à la place le [plug-in de navigateur](https://www.softwareheritage.org/browser-extensions/) déjà mentionné plus haut. Cliquez sur l'icône «&nbsp;disquette&nbsp;» affichée à droite de votre écran afin de déclencher l'archivage (Fig. 10).    

{% include figure.html filename="fr-or-preserver-logiciels-recherche-10.gif" alt="Gif animé montrant comment archiver un dépôt GitLab à l'aide du plug-in de navigateur : cliquer sur l'icône Disquette qui apparaît à droite de l'écran." caption="Figure 10. Archiver un dépôt à l'aide du plug-in de navigateur." %}

## Pour aller plus loin&nbsp;: décrire un logiciel avec CodeMeta 

Fournir [un fichier README](https://www.makeareadme.com/) suffisamment détaillé (voir par exemple le fichier README du [package R `{tapas}`](https://archive.softwareheritage.org/swh:1:cnt:0918fd32b5eddc85aaaeb35da83a749795e703bc;origin=https://github.com/wfinsinger/tapas;visit=swh:1:snp:fb13c70f7d5edc7515756d6f1c01a3f3b1a69e72;anchor=swh:1:rev:5f3d58423904da1b0bf368886ccf31d97956f7b3;path=/README.Rmd)) constitue une étape importante pour expliquer les finalités d'un logiciel. Ajouter un fichier descriptif CodeMeta facilite l'identification d'un logiciel.

### Ajouter des métadonnées pour rendre son logiciel identifiable 

Les logiciels sont des ressources labiles&nbsp;: leur cycle de vie peut s'étendre sur plusieurs décennies, leurs fonctionnalités évoluent, leur nom n'est pas toujours fixe, leur plateforme d'origine peut aussi changer, y compris en cours du développement d'une même version.

De fait, ces ressources peuvent être difficiles à identifier. Dans le cas des logiciels, les métadonnées doivent entre autres permettre d’exprimer les auteurs, les changements de versions, la ou les licences, mais aussi les relations entre les différentes productions académiques. Les métadonnées aident à identifier le logiciel ainsi que son contexte de création et d'utilisation. Il existe deux grandes catégories de métadonnées.

1. Les métadonnées intrinsèques fournissent des informations essentielles pour assurer la préservation et l'utilisabilité à long terme des logiciels. Elles sont contenues dans un fichier texte à vocation descriptive, souvent intitulé `README` ou `DESCRIPTION`, situé à la racine du répertoire du code source du logiciel. C'est pourquoi, très souvent, les auteurs de logiciels sont les premiers et les principaux fournisseurs de métadonnées intrinsèques.

2. Les métadonnées extrinsèques peuvent fournir quant à elles des informations importantes sur le contexte et la provenance du logiciel&nbsp;: par exemple, sur quelle forge le logiciel a été développé. Ces informations aident les utilisateurs à localiser le logiciel, à identifier la communauté qui l'utilise. Ces métadonnées renseignent aussi sur la relation entre le logiciel et d’autres produits de recherche&nbsp;: des publications, des jeux de données. Ces métadonnées ne sont pas incluses dans les fichiers du code source, c'est pourquoi elles sont qualifiées d'extrinsèques. Elles peuvent être ajoutées par des opérateurs extérieurs&nbsp;: des services éditoriaux, des agrégateurs, [des catalogues](https://zbmath.org/software/), etc. Elles peuvent être aussi fournies par la personne qui a écrit le code source, comme c'est le cas avec l'archive ouverte HAL. Les informations à compléter sont indiquées dans un [formulaire de saisie](http://doc.hal.science/deposer/deposer-le-code-source/#).

La personne à l'origine du logiciel joue un rôle majeur dans le processus descriptif du logiciel. Des métadonnées riches contribuent à la réutilisation et l'identification des logiciels.

### CodeMeta, la pierre de Rosette des auteurs de logiciels 

Fournir des métadonnées intrinsèques incombe à l'auteur du logiciel. Or, décrire un logiciel est une pratique bien moins codifiée que décrire un ouvrage ou un article. Si certaines métadonnées semblent relever de l'évidence (nom du logiciel, auteurs, version, licence), il n'existe pas de standard indiquant un noyau minimal d'informations à fournir. La liste des métadonnées dépend de l'usage ciblé ainsi que le note S. Morrissey&nbsp;:

> «&nbsp;How do we describe software effectively&nbsp;? The list of properties to be described will vary according to the purposes for which we collect software[^9].&nbsp;»

De plus, il existe de nombreux vocabulaires descriptifs, ayant chacun leurs spécificités. Non seulement il faut déterminer les éléments à décrire, mais il faut également considérer dans quel vocabulaire les exprimer. Voici un exemple de correspondances entre métadonnées issues de différentes plateformes&nbsp;:

<div class="table-wrapper" markdown="block">

| Propriété CodeMeta  | GitHub        | PyPI                                |
|---------------------|---------------|-------------------------------------|
| programmingLanguage | languages_url | classifiers['Programming Language'] |
| author              | login         | author                              |

</div>


De même, cette fois à l'échelle du logiciel et non plus de la plateforme, comparez [le fichier `DESCRIPTION` d'un *package* R](https://archive.softwareheritage.org/browse/content/sha1_git:29c0f87d31f0dad1b55bb6d9fed4e7d45b77b19d/?origin_url=https://cran.r-project.org/package%3Dtm&path=tm/DESCRIPTION&snapshot=99204e5a7070f348901b0e966a7ffbbe3db0a9b9&visit_type=cran) et [le fichier `Project.toml` d'un *package* Julia](https://archive.softwareheritage.org/browse/content/sha1_git:4869ca4be8d0b31d1f41ee164b658f0c617a8030/?origin_url=https://github.com/JuliaGeometry/Meshes.jl&path=Project.toml). Ces deux fichiers ont le même objectif (indiquer auteurs, versions, dépendances, etc.), mais vous pouvez constater que leur syntaxe diffère sensiblement en fonction du langage, ce qui rend difficile leur moisson et leur traitement automatiques.

CodeMeta résout ces problèmes en jouant le rôle de [connecteur entre une vingtaine de vocabulaires](https://codemeta.github.io/crosswalk/)&nbsp;: il est comparable à une table de concordance. CodeMeta présente aussi l'avantage d'être adapté aux besoins académiques. Il permet ainsi d'indiquer un financement, un lien avec une publication, un domaine disciplinaire. Les métadonnées sont lisibles par l'humain comme par les machines, ce qui augmente le potentiel de "découvrabilité" d'un logiciel décrit *via* un fichier CodeMeta, conçu avec le CodeMeta Generator.

### En pratique&nbsp;: utilisation de CodeMeta Generator pour documenter votre dépôt 

Ajoutez un fichier CodeMeta dans le dépôt de la leçon afin de renseigner quelques métadonnées utiles sous un format unifié. Ce fichier, qui sera nommé `codemeta.json`, est donc au format [JavaScript Object Notation](https://fr.wikipedia.org/wiki/JavaScript_Object_Notation), l'un des formats populaires de stockage de (méta)données. Cette syntaxe est néanmoins très fastidieuse à saisir manuellement, et on utilise donc plutôt habituellement des interfaces de saisie pour générer de tels fichiers.

En effet, consultez par exemple [ce fichier CodeMeta](swh:1:cnt:3f28ad2b83ae59ff2ab85c95aab666f0dca8487b;origin=https://github.com/damienbelveze/plagiator;visit=swh:1:snp:3dd49cc39bde69ed9fc8819a745ff0441cf86495;anchor=swh:1:rev:c89473931599243de3893ef0de9fc128e8a086e4;path=/codemeta.json), fournissant les métadonnées pour le *serious game* Plagiator. Bien que l'on puisse comprendre la structure globale d'un tel fichier, et deviner le sens de la plupart des champs (`contributor`, `email`, `dateCreated`, etc.), il semble clair que la saisie manuelle de ce genre de fichier serait inconfortable pour l'auteur d'un logiciel.

Vous pourrez donc préférer utiliser des interfaces graphiques intuitives telles que [CodeMeta Generator](https://codemeta.github.io/codemeta-generator/) (il en existe d'autres&nbsp;?) pour produire des fichiers CodeMeta.

**Exercice**. Créons un fichier CodeMeta correspondant à votre dépôt.

1. Sur le site de [CodeMeta Generator](https://codemeta.github.io/codemeta-generator/), remplissez au moins les champs les plus essentiels (par exemple&nbsp;: `Name`, `Authors`, `License(s)`, `Programming Language`, `Code    repository`) avec les informations adéquates. 
2. Cliquez sur le bouton «&nbsp;Generate codemeta.json v3.0&nbsp;» en bas de la page afin d'obtenir le contenu d'un fichier `codemeta.json`.

{% include figure.html filename="fr-or-preserver-logiciels-recherche-11.gif" alt="Gif animé du site CodeMeta Generator indiquant les informations correctes à renseigner dans différents champs : Name, License, Programming language, Code repository, Author name." caption="Figure 11. Créer un fichier CodeMeta." %}

**Exercice**. Pour terminer, placez ce fichier `codemeta.json` à la racine de votre dépôt.

1. Copiez le contenu proposé par CodeMeta Generator à l'issue de l'étape précédente. 
2. Dans votre dépôt sur GitLab.com, créez un nouveau fichier nommé `codemeta.json`, et collez-y ce contenu. 
3. Cliquez sur «&nbsp;Valider les modifications&nbsp;» afin de créer une nouvelle révision (*commit*) associée à la création de ce fichier.

{% include figure.html filename="fr-or-preserver-logiciels-recherche-12.gif" alt="Gif animé montrant les manipulations nécessaires pour ajouter le fichier CodeMeta dans le dépôt GitLab, à l'aide de l'interface graphique : bouton Nouveau fichier, ajout du contenu, puis bouton Valider." caption="Figure 12. Ajouter le fichier CodeMeta à votre dépôt." %}

## Résumé

Cette leçon a présenté des modalités d'archivage adaptées aux spécificités du logiciel et à différents profils d'utilisateurs. Elle a recommandé l'utilisation d'un identifiant permettant de référencer les différents composants d'un logiciel. Cette leçon a fourni des conseils pour citer les logiciels, ainsi que des méthodes pour explorer efficacement les fonds de Software Heritage. Enfin, cette leçon est aussi l'occasion de s'initier à des concepts de développement logiciel.

Ces pratiques peuvent facilement et progressivement s'intégrer dans un *workflow* de recherche ouverte, que l'on développe ou non du code source. Le but de ce guide est de fournir de premiers repères pour s'orienter dans un contexte qui évolue rapidement.

## Avez-vous plus de questions&nbsp;?

Les auteur(e)s se feront un plaisir de répondre à toute question que vous pouvez avoir.

* Pour toute demande relative à Software Heritage, consulter [la Foire Aux Questions](https://www.softwareheritage.org/faq/) ou utiliser [le formulaire de contact](https://www.softwareheritage.org/contact/).
* Pour suivre l’actualité de Software Heritage, consulter [le blog dédié](https://www.softwareheritage.org/blog/) ou abonnez-vous à [la newsletter](https://www.softwareheritage.org/newsletter/).

## Remerciements

Les auteurs souhaitent remercier Joenio Marques da Costa, *backend developer* de [la plateforme CorTexT](https://www.cortext.net/).

## Notes de fin 

[^1]: Davenport, James Harold, James Grant, et Catherine Mary Jones. «&nbsp;Data Without Software Are Just Numbers&nbsp;». Data Science Journal 19, nᵒ 1 (22 janvier 2020): 3. <https://doi.org/10.5334/dsj-2020-003>. 
[^2]: Le lecteur confronté à un lien brisé peut certes tenter de rechercher et d'obtenir le logiciel mentionné par d'autres moyens, mais il sera probablement difficile d'obtenir la même version logicielle que celle vers laquelle pointait le lien désormais mort. 
[^3]: Une *forge* est une plateforme en ligne permettant à plusieurs auteurs de travailler ensemble à la production de fichiers au format texte, le cas le plus fréquent (mais pas unique) étant la production de code informatique. Nous reviendrons plus tard dans cette leçon sur la notion de forge logicielle. 
[^4]: Escamilla, Emily, Martin Klein, Talya Cooper, Vicky Rampin, Michele C. Weigle, et Michael L. Nelson. «&nbsp;The Rise of GitHub in Scholarly Publications&nbsp;». arXiv, 9 août 2022. <https://doi.org/10.48550/arXiv.2208.04895>. 
[^5]: [Techniquement, Software Heritage peut archiver des exécutables](https://www.softwareheritage.org/faq/#26_Do_you_also_archive_software_executables_aka_binaries), mais insistons sur le fait qu'il ne s'agit alors que d'un effet secondaire dans l'hébergement du logiciel dans son ensemble. La priorité est la collecte du code source. 
[^6]: Jackson, Mike. «&nbsp;How to Cite and Describe Software&nbsp;». Software Sustainability Institute, s.d. [https://www.software.ac.uk/how-cite-software](https://www.software.ac.uk/how-cite-software). 
[^7]: Chue Hong, Neil P., Alice Allen, Alejandra Gonzalez-Beltran, Anita de Waard, Arfon M. Smith, Carly Robinson, Catherine Jones, et al. «&nbsp;Software Citation Checklist for Authors (0.9.0)&nbsp;». FORCE11 Software Citation Implementation Working Group, 15 octobre 2019. https://doi.org/10.5281/zenodo.3479199. Katz, Daniel S, Daina Bouquin, Neil P Chue Hong, Jessica Hausman, Daniel Chivvis, Tim Clark, Mercè Crosas, et al. «&nbsp;Software Citation Implementation Challenges&nbsp;», 2019, 26. <https://doi.org/10.48550/arXiv.1905.08674>. 
[^8]: Collège Europe Et International et Comité pour la science ouverte. «&nbsp;Des identifiants ouverts pour la science ouverte&nbsp;». Report. Comité pour la science ouverte, 3 juillet 2019. <https://doi.org/10.52949/22>. 
[^9]: Morrissey, Sheila M. «&nbsp;Preserving Software: Motivations, Challenges and Approaches&nbsp;». Digital Preservation Coalition, août 2020. <https://doi.org/10.7207/twgn20-02>. 
[^10]: Spinellis, Diomidis, «&nbsp;The decay and failures of web references&nbsp;», Communications of the ACM, janvier 2003, vol. 46, nᵒ 1, p. 71‑77, <https://doi:10.1145/602421.602422>.
