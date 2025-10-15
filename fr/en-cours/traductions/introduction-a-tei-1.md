---
title: "Introduction à l'encodage de texte TEI (partie 1)"
slug: introduction-a-tei-1
original: introduccion-a-tei-1
layout: lesson
collection: lessons
date: 2021-07-27
translation_date: 20YY-MM-DD
authors:
  - Nicolás Vaughan
editors:
  - Jennifer Isasi
reviewers:
  - Rocío Méndez
  - Iñaki Cano
translator:
  - Maritza Beatriz García Rodríguez
translation-editor:
  - Alexandre Wauthier
translation-reviewer:
  -
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/671
difficulty: 2
activity: transforming
topics: [data-manipulation, website]
abstract: "Cette leçon (à laquelle suivra une deuxième partie) vous enseigne les rudiments de la TEI-XML pour encoder des textes."
avatar_alt: Gravure d'une coupe transversale du sol avec ses étiquettes correspondantes.
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

<div class="alert alert-warning">Note de la traductrice :
Dans la leçon originale, Nicolás Vaughan utilise des exemples tirés du *Quichotte* de Miguel de Cervantes, ainsi que les quatre premiers vers du sonnet «Amor constante más allá de la muerte» (« Amour constant au-delà de la mort ») de Francisco de Quevedo. Afin de mieux adapter la traduction à un lectorat francophone, lui proposant des textes originalement écrits en langue française, j’ai choisi de remplacer :
1.	L’extrait du *Quichotte* par un extrait des *Misérables* de Victor Hugo, dans les exemples comprenant des petites capitales et la balise <name> ;
2.	Les informations qui correspondent aux métadonnées de l’édition du *Quichotte* par des informations sur les métadonnées de l’édition des *Misérables*, lors de l’explication de l’élément <teiHeader> ;
3.	Les quatre premiers vers du sonnet de Quevedo par les quatre premiers vers du « Sonnet VIII » de Louise Labé, lors de l’explication de l’encodage de textes en vers.
L’éditeur de code proposé lors de cette leçon sera Visual Studio Code (VSCode), un logiciel libre créé par Microsoft, mais qui inclut de la télémétrie par défaut et dont certaines extensions ne sont pas libres. Il nous semble donc important de mentionner une alternative, VSCodium, proposée par une communauté open-source. À la différence de VSCode, VSCodium n'active pas la télémétrie par défaut, ne met à disposition que des extensions non propriétaires et offre systématiquement une licence MIT de réutilisation.</div>


# Introduction

Dans les humanités numériques, l'un des problèmes centraux consiste à travailler avec et sur les textes : leur capture (numérisation), reconnaissance, transcription, encodage, traitement, transformation et analyse. Dans cette leçon, nous nous concentrerons exclusivement sur l'encodage de texte, c'est-à-dire, sur leur catégorisation au moyen de balises (tags).

Un exemple peut aider à éclaircir cette idée. Supposons que nous avons un document imprimé que nous avons préalablement numérisé.
Nous avons les images numérisées des pages et, à l'aide d'un logiciel de reconnaissance optique de caractères ([OCR](https://fr.wikipedia.org/wiki/Reconnaissance_optique_de_caractères), en anglais), nous extrayions le texte contenu dans ces images. Ce texte est ce que l'on appelle habituellement [texte brut](https://fr.wikipedia.org/wiki/Texte_brut) (ou texte numérisé), c'est-à-dire, le texte sans aucun format (sans italiques, gras, etc.) ni aucune autre structuration sémantique.

Même si cela peut paraître étrange, le texte brut est complètement dépourvu de contenu. Pour un ordinateur, ce n'est qu'une longue chaîne de caractères (y compris la ponctuation, les espaces, les sauts de ligne, etc.) dans un [encodage](https://fr.wikipedia.org/wiki/Codage_des_caractères) (par exemple [UTF-8](https://fr.wikipedia.org/wiki/UTF-8) ou [ASCII](https://fr.wikipedia.org/wiki/American_Standard_Code_for_Information_Interchange)) d'un alphabet (latin, grec ou cyrillique, par exemple). C'est nous qui, lorsque nous le lisons, identifions des mots (dans une ou plusieurs langues), des lignes, des paragraphes, etc. C'est nous qui identifions aussi les noms de personnes et de lieux, les titres de livres et d'articles, les dates, les citations, les épigraphes, les références croisées (internes et externes), les notes en bas de page et les notes à la fin du texte. Mais, de nouveau, l'ordinateur est complètement "ignorant" à l'égard desdites structures textuelles dans un texte brut sans traitement ou encodage.

Sans assistance humaine, par exemple, au moyen de l'encodage [TEI](https://tei-c.org/) (Text Encoding Initiative), l'ordinateur ne peut "comprendre" ou détecter aucun contenu dans le texte brut. Cela veut dire, entre autres choses, que nous ne pouvons pas faire des recherches structurées sur ce texte (de noms de personnes, de lieux ou de dates, par exemple), et que nous ne pouvons ni extraire ni traiter systématiquement une information, sans avoir préalablement indiqué à l'ordinateur quelles chaînes de caractères correspondent à quelles structures sémantiques. Par exemple, cette chaîne de caractères correspond à un nom propre de personne, cet autre nom de personne fait référence à la même personne que le premier, cette chaîne de caractères est un nom de lieu, cette autre est une note en marge faite par une tierce personne, ce paragraphe appartient à cette section du texte.
Encoder le texte, c'est indiquer (au moyen de balises et d'autres ressources) que certaines chaînes de caractères en texte brut ont une signification donnée. Et celle-ci est la différence entre le texte brut et le texte sémantiquement structuré.

On peu encoder un texte de différentes façons. Par exemple, nous pouvons mettre entre astérisques uniques les noms de personnes : `*Simón Bolívar*`, `*Soledad Acosta*`, etc. Et entre astérisques doubles ceux de lieux : `**Bogotá**`, `*Firmingham*`, etc. Nous pouvons aussi utiliser des tirets bas pour indiquer les noms d'œuvres et de livres : `_La Divine comédie_`, `_Cent ans de solitude_`, etc. Ces signes servent à baliser ou marquer le texte qu'ils contiennent, afin d'identifier dans le texte un contenu donné. Comme il est facile de l'imaginer, les possibilités d'encodage sont presque infinies.

Dans cette leçon, vous apprendrez à encoder des textes en utilisant un langage d'ordinateur spécialement conçu pour cela : la TEI (Text Encoding Initiative).

## Le logiciel que nous utiliserons

N'importe quel éditeur de texte brut (en format `.txt`) nous servira pour faire tout ce dont nous aurons besoin dans cette leçon : le [Bloc-notes (Notepad) de Windows](https://fr.wikipedia.org/wiki/Bloc-notes_(Windows)), par exemple, est parfaitement approprié pour cela. Néanmoins, il y a d'autres éditeurs de texte qui offrent des outils ou des fonctionnalités conçus pour faciliter le travail avec du XML (Extensible Markup Language), voire avec de la TEI. [Oxygen XML Editor](https://www.oxygenxml.com) est l'un des plus recommandés actuellement, disponible pour Windows, macOS et Linux. Néanmoins, ce n'est pas un logiciel gratuit (la licence académique coûte environ 84€) ni à code source ouvert, par conséquent nous ne l'utiliserons pas dans cette leçon.

Pour cette leçon, nous utiliserons l'éditeur [Visual Studio Code](https://code.visualstudio.com/) (VS Code, plus brièvement), créé par Microsoft et entretenu actuellement par une grande communauté de programmeur·euse·s de logiciels libres. C'est une application complètement gratuite et à [code source ouvert](https://github.com/microsoft/vscode), disponible pour Windows, macOS et Linux.

Téléchargez la version la plus récente de VS Code sur le lien [https://code.visualstudio.com/](https://code.visualstudio.com/) et installez-la sur votre ordinateur. Ouvrez-le et il s'affichera un écran comme le suivant :

{% include figure.html filename="fr-tr-introduction-a-tei-1-01.png" alt="Vue initiale de VS Code, figure obtenue par capture d'écran de la page de bienvenue de VS Code. Celle-ci se divise en trois sections : 'Start', 'Recent' et 'Walkthroughs'. En haut de cette page se trouvent la barre de menu et, à gauche, la barre latérale." caption="Figure 1. Vue initiale de VS Code." %}

Maintenant, nous allons installer une extension de VS Code pour travailler plus facilement avec des documents XML et XML-TEI : [Scholarly XML](https://marketplace.visualstudio.com/items?itemName=raffazizzi.sxml).

Pour ce faire, cliquez sur le bouton "Extensions" dans la barre latérale sur le côté gauche de fenêtre principale :

{% include figure.html filename="fr-tr-introduction-a-tei-1-02.png" alt="Extensions de VS Code, figure obtenue par la capture d'écran d'une fenêtre de VS Code. Sur la barre latérale et entouré par un cercle rouge, l'icône des extensions, à côté duquel la liste d'extensions installées et recommandées se déploie à la verticale." caption="Figure 2. Extensions de VS Code." %}

Écrivez `Scholarly XML` sur la barre de recherche :

{% include figure.html filename="fr-tr-introduction-a-tei-1-03.png" alt="Recherche d'une extension sur VS Code, figure obtenue par la capture d'écran d'une fenêtre de VS Code. En haut à gauche et entourée en rouge, la recherche de 'Scholarly XML' sur la barre de recherche des extensions." caption="Figure 3. Recherche d'une extension sur VS Code." %}

Enfin, cliquez sur "Install" :

{% include figure.html filename="fr-tr-introduction-a-tei-1-04.png" alt="Installer Scholarly XML sur VS Code, figure obtenue par la capture d'écran d'une fenêtre de VS Code. À gauche et entouré en rouge, le bouton d'installation de l'extension Scholarly XML." caption="Figure 4. Installer Scholarly XML sur VS Code." %}

Cette extension nous permet de faire plusieurs choses avec le code :

**Premièrement**, Scholarly XML permet de sélectionner n'importe quel texte dans un document XML, d'utiliser des raccourcis clavier et d'inclure automatiquement le texte sélectionné à l'intérieur d'un élément XML. Lorsque nous appuyons sur `Ctrl+E` (sur Windows ou Linux) ou `Cmd+E` (sur macOS), VS Code ouvre une petite fenêtre avec l'instruction `Enter Abbreviation (Press Enter to confirm or Escape to cancel)` — "Introduisez le raccourci (Appuyez sur 'Entrée' pour confirmer votre saisie, ou sur 'Échap' pour l'annuler)". Ensuite, nous écrivons le nom de l'élément et appuyons sur la touche `Entrée`. Ainsi, l'éditeur intégrera le texte sélectionné entre une balise d'ouverture et une autre de fermeture avec le nom de l'élément. Lorsque nous travaillons avec XML, automatiser l'introduction de balises d'ouverture et de fermeture peut nous faire économiser beaucoup de temps, tout en diminuant la probabilité d'introduire des erreurs typographiques dans le code.

{% include figure.html filename="fr-tr-introduction-a-tei-1-05.png" alt="Introduire automatiquement un élément XML sur VS Code, figure obtenue par la capture d'écran d'une fenêtre de VS Code. En haut, dans la barre de recherche, le mot 'quote' est entouré en rouge. Dans le corps du document modele.xml et entouré en rouge, le mot 'publication' est entre deux balises quote, l'une d'ouverture et l'autre de fermeture." caption="Figure 5. Introduire automatiquement un élément XML sur VS Code." %}

**Deuxièmement**, Scholarly XML permet de déterminer si un document est bien formé selon la syntaxe XML et, en outre, s'il est valable sémantiquement à l'égard d'un schéma de validation de type [RELAX NG](https://fr.wikipedia.org/wiki/Relax_NG), par exemple, le schéma `tei-all` de la TEI, qui contient la totalité des modules de marquage pour tous les types de documents prévus par le consortium de la TEI. (Ci-dessous nous expliquerons les concepts de validité syntaxique et sémantique.) L'extension réalise automatiquement les deux choses.

{% include figure.html filename="fr-tr-introduction-a-tei-1-06.png" alt="Détecter des erreurs XML sur VS Code, figure obtenue par la capture d'écran d'une fenêtre de VS Code. En raison d'une erreur dans le nom de la balise ouvrante 'publicationStmts', celle-ci et la balise fermante 'publicationStmt' sont soulignées en rouge." caption="Figure 6. Détecter des erreurs XML sur VS Code." %}

{% include figure.html filename="fr-tr-introduction-a-tei-1-07.png" alt="Détecter des erreurs XML sur VS Code, figure obtenue par la capture d'écran d'une fenêtre de VS Code. À l'intérieur du body, la présence de texte non contenu entre des balises ne respecte pas les règles de la TEI, cela produit une erreur signalée en rouge et expliquée en bas de la fenêtre." caption="Figure 7. Détecter des erreurs XML sur VS Code" %}

Cependant, pour réaliser le deuxième type de validation, il est nécessaire que, sur le document, on spécifie l'URI du schéma dans une déclaration `<?xml-model>` au début du document, par exemple, ainsi :

```XML
<?xml-model href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml"
  schematypens="http://purl.oclc.org/dsdl/schematron"?>
```

Vous pouvez télécharger un [modèle basique d'un document XML-TEI](https://raw.githubusercontent.com/programminghistorian/ph-submissions/refs/heads/gh-pages/assets/introduction-a-tei-1/modele-TEI.xml) depuis le dépôt _Programming Historian_, avec ces lignes déjà incluses.

**Troisièmement**, l'extension offre également des outils pour saisir semi-automatiquement le code XML à partir du schéma de validation RELAX NG. Par exemple, si nous avons introduit dans le document un élément `<q>` : ["quoted"](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-q.html) (pour marquer un texte entre guillemets, par exemple une citation), nous pouvons appuyer sur la barre d'espace après le `q` de la balise d'ouverture et VS Code affichera une liste d'attributs possibles à sélectionner dans le menu :

{% include figure.html filename="fr-tr-introduction-a-tei-1-08.png" alt="Menu d'autocomplétion de code XML sur VS Code, figure obtenue par capture d'écran de l'élément body d'un document XML sur VS Code. À l'intérieur de la balise ouvrante <q>, l'espace entre q et le chevron fermant déploie un menu avec la liste d'attributs." caption="Figure 8. Menu d'autocomplétion de code XML sur VS Code." %}

Cependant, pour pouvoir utiliser cette extension ou d'autres dans VS Code, il est nécessaire que l'éditeur **ne** soit **pas** en mode restreint (*Restricted Mode*), comme ce qui s'affiche sur cette fenêtre :

{% include figure.html filename="fr-tr-introduction-a-tei-1-09.png" alt="Avertissement du mode restreint sur VS Code, figure obtenue par la capture d'écran d'une fenêtre de VS Code. En haut, l'avertissement du mode restreint s'affiche en bleu, offrant les options cliquables : 'Manage' et 'Learn More'." caption="Figure9. Avertissement du mode restreint sur VS Code." %}

Ce mode évite que les extensions ou le code du document exécutent des instructions pouvant endommager notre système. Étant donné que nous sommes en train de travailler avec nos documents et que l'extension recommandée est hautement fiable, nous pouvons désactiver le mode restreint en cliquant sur l'hyperlien situé en haut, qui indique *Manage* ("Administrer") et puis cliquer sur le bouton *Trust* ("Faire confiance"), ainsi :

{% include figure.html filename="fr-tr-introduction-a-tei-1-10.png" alt="Quitter le mode restreint sur VS Code, figure obtenue par capture d'écran de la fenêtre 'Workspace Trust' sur VS Code. Celle-ci affiche à gauche l'option de quitter le mode restreint avec le bouton 'Trust' en bleu, et à droite l'option de rester en mode restreint." caption="Figure 10. Quitter le mode restreint sur VS Code." %}

Maintenant que nous avons configuré notre éditeur, nous pouvons commencer à travailler en XML-TEI.

## Visualisation vs. catégorisation

Celles et ceux qui sont familiarisé·e·s avec le langage de marquage [Markdown](https://daringfireball.net/projects/markdown/syntax) – de nos jours habituel dans des forums techniques sur Internet, ainsi que dans [GitHub](https://github.com), [GitLab](https://gitlab.com) et d'autres répertoires de code – reconnaîtront certainement l'usage d'éléments tels que des astérisques (`*`), des tirets bas (`_`) et des dièses (`#`) pour faire en sorte que le texte apparaisse d'une certaine manière dans le navigateur. Par exemple, un texte placé entre deux astérisques simples sera montré en italique, tandis qu'un autre entre astérisques doubles le sera en gras. De fait, le texte de cette leçon est écrit en Markdown suivant ces conventions.

Cet usage du marquage a comme finalité principale la visualisation du texte, non pas sa catégorisation. Autrement dit, les marques ou balises de Markdown n'indiquent pas qu'un texte est d'une catégorie (par exemple, le nom d'une personne, d'un lieu ou d'une œuvre), mais seulement que le texte doit être visualisé ou montré d'une certaine manière dans un navigateur ou dans un autre médium.

Comprendre la différence entre le marquage de visualisation (comme le Markdown) et le marquage sémantique (ou structurel, comme celui que nous verrons plus tard en TEI) est crucial pour comprendre l'objectif de l'encodage de textes. Lorsque nous marquons un fragment de texte pour l'encoder, nous le faisons sans nous soucier en principe de comment cela a été représenté originalement, ni comment cela pourra éventuellement être représenté dans le futur. Nous sommes uniquement intéressés par la fonction sémantique ou structurelle qu'un texte particulier possède. Pour cela, nous devons parvenir à identifier avec précision les fonctions ou les catégories des textes, tout en laissant de côté, dans la mesure du possible, la manière dans laquelle ils sont montrés sur le papier ou sur l'écran.

Clarifions cela en revenant à notre exemple initial. Supposons que, dans le texte numérisé de départ, les noms propres apparaissent toujours imprimés en [petites capitales](https://fr.wikipedia.org/wiki/Petite_capitale), comme dans le fragment qui suit :

{% include figure.html filename="fr-tr-introduction-a-tei-1-11.png" alt="Court extrait de texte numérisé tiré des Misérables, figure obtenue par la capture d'écran d'une page Word. Quatre lignes de texte dont la source est Victor Hugo, _Les Misérables_. Cinquième partie : Jean Valjean I, Paris : Pagnerre, 1862, p. 28. Nous ajoutons les petites capitales pour servir les propos de la leçon."  caption="Figure 11. Court extrait de texte numérisé tiré des _Misérables_." %}

Comme nous le verrons plus tard, la TEI nous permet d'encoder, par le moyen d'une série de balises, le texte que nous voulons catégoriser. Par exemple, nous pouvons utiliser une balise comme [`<name>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-name.html) pour démarquer les noms propres contenus dans le texte, ainsi :

```
Quand <name>Zoïle</name> insulte <name>Homère</name>, quand <name>Mævius</name> insulte <name>Virgile</name>, quand <name>Visé</name> insulte <name>Molière</name>, 
quand <name>Pope</name> insulte <name>Shakespeare</name>, quand <name>Fréron</name> insulte <name>Voltaire</name>, c’est une vieille loi d’envie 
et de haine qui s’exécute ; les génies attirent l’injure, les grands hommes sont toujours plus ou moins aboyés.
```
Plus tard, nous verrons en détail ce qu'est et comment fonctionne une balise (ou plus précisément un élément) en XML et TEI. Pour le moment, remarquons qu'une balise ne signifie pas que le texte ait été représenté originalement en petite capitale (ni d'une autre manière). Cela signifie seulement que le texte qu'elle contient a la catégorie de nom propre, indépendamment de comment il est représenté. De fait, nous pouvons encoder exhaustivement un document avec des centaines ou des milliers de balises, sans qu'aucune d'elles n'apparaisse, à la fin, dans une éventuelle représentation.

# XML et TEI : vers un standard de l'encodage de textes

Depuis les débuts des humanités numériques, dans les années 1960, il y a eu beaucoup d'approximations à l'encodage de textes. Presque chaque projet d'encodage contenait son propre standard, ce qui conduisait au fait que les projets étaient incompatibles et intraduisibles entre eux, entravant, voire rendant impossible, le travail collaboratif.

Pour résoudre ce problème, une vingtaine d'années plus tard, on a établi un nouveau standard d'encodage de textes, rassemblant un grand nombre de chercheurs et chercheuses à travers le monde, particulièrement dans les universités anglosaxonnes : la [Text Encoding Initiative (TEI)](https://fr.m.wikipedia.org/wiki/Text_Encoding_Initiative).

La TEI est également construite sur le langage de marquage [XML](https://fr.m.wikipedia.org/wiki/Extensible_Markup_Language), c'est pourquoi elle est parfois dénommée comme "XML-TEI" (ou encore "TEI-XML"). De son côté, le XML (le sigle d'"eXtensible Markup Language") est un langage d'ordinateur dont le propos est de décrire, par le moyen d'une série de marques ou de balises (_tags_ en anglais), un objet-texte donné.

Le XML et la TEI sont des langages de marquage et c'est en cela qu'ils se différencient des langages de programmation comme C, Python ou Java, qui décrivent des objets, des fonctions ou des procédures qui doivent être exécutés par un ordinateur.

## XML

Dans cette leçon, nous n'entrerons pas dans le détail de la syntaxe ni du fonctionnement de XML. Nous recommandons donc que le lecteur ou la lectrice jette un coup d'œil à [cette autre leçon](https://programminghistorian.org/en/lessons/transforming-xml-with-xsl) (en anglais) pour plus d'information sur le XML, ainsi qu'à la bibliographie et aux références suggérées à la fin de cette leçon.

Pour le moment nous devons seulement savoir que tout document XML doit respecter deux règles essentielles pour être valable :

1. Il ne doit y avoir qu'un seul élément racine (qui contient tous les autres éléments, s'il y en a d'autres).
2. Toute balise d'ouverture doit avoir une balise de fermeture.

Heureusement, les éditeurs de code XML comme VS Code (avec l'extension Scholarly XML) ou OxygenXML nous permettent de détecter facilement des erreurs de ce type.

## Qu'est-ce que la TEI ?

Le XML est un langage si général et abstrait qu'il est totalement indifférent à l'égard de son contenu. Il peut être utilisé, par exemple, pour décrire des choses très différentes, allant d'un texte en grec classique du VIIIe siècle av. notre ère à un message qu'un thermostat intelligent envoie à une application de smartphone utilisée pour le contrôler.

La TEI est une implémentation particulière de XML. C'est-à-dire que c'est une série de règles qui déterminent quels éléments et quels attributs sont permis dans un document d'un certain type. Plus précisément, la TEI est un langage de marquage pour encoder tous types de textes. Cela permet qu'ils soient traités par un ordinateur, de sorte qu'ils puissent être analysés, transformés, reproduits et stockés, selon les besoins et les intérêts des usager·e·s (tant en chair et en os que numériques). C'est pourquoi nous pouvons dire que la TEI est au cœur des humanités numériques (ou du moins dans l'un de ses cœurs !). C'est un standard pour travailler informatiquement avec une classe d'objets traditionnellement centrale aux humanités : les textes.
Ceci étant, alors que le XML reste indifférent lorsque les éléments d'un document décrivent des textes (ou des propriétés de textes), la TEI est conçue pour travailler avec eux.

Les types d'éléments et d'attributs permissibles en TEI, et les relations existantes entre eux, sont spécifiés par les [règles de la TEI](https://tei-c.org/release/doc/tei-p5-doc/fr/html/index.html). Par exemple, si nous voulons encoder un poème, nous pouvons utiliser l'élément [`<lg>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-lg.html) (de _line group_, "groupe de lignes") de la TEI. Les règles de la TEI déterminent quels types d'attributs peut avoir cet élément et quels éléments peuvent, eux-mêmes, contenir ou être contenus par lui. La TEI détermine que tout élément <`lg`> doit avoir au moins un élément [`<l>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-l.html) (de _line_, "ligne").

Pour illustrer nos propos, examinons les quatre premiers vers du *Sonnet VIII* de Louise Labé (ci-dessous, en texte brut) :

```XML
Je vis, je meurs : je me brûle et me noie,
J’ai chaud extrême en endurant froidure ;
La vie m’est et trop molle et trop dure,
J’ai grands ennuis entremêlés de joie.
```

Nous pouvons proposer l'encodage en TEI qui suit :

```XML
<lg met="10,10,10,10" rhyme="abba">
<l n="1">Je vis, je meurs : je me brûle et me noie,</l>
<l n="2">J’ai chaud extrême en endurant froidure ;</l>
<l n="3">La vie m’est et trop molle et trop dure,</l>
<l n="4">J’ai grands ennuis entremêlés de joie.</l>
</lg>
```

Dans le cas présent, nous avons fait appel à l'attribut `@rhyme` de l'élément `<lg>`, pour faire encoder le type de rime du passage ; à l'attribut `@met` pour indiquer le type de métrique du premier vers – décasyllabe – (nous aurions dû faire cela pour chacun des vers, mais pour la clarté du code, nous l'avons fait seulement dans le premier) ; et finalement à l'attribut `@n` pour indiquer le numéro du vers à l'intérieur de chaque groupe.

La comparaison entre le texte brut du fragment du sonnet et son encodage nous permet de commencer à voir les avantages de la TEI en tant que langage de marqueur de texte. Il n'est pas seulement indiqué explicitement que les lignes (dans le code précédent) deux à cinq sont des vers d'un poème, mais qu'elles ont un type de rime et de métrique. Une fois tout le poème encodé, ou tous les poèmes d'un recueil, nous pouvons, par exemple, utiliser un logiciel pour réaliser des requêtes structurées, de sorte que cela donne comme résultat tous les poèmes qui possèdent une certaine métrique. Ou alors, nous pouvons utiliser (ou créer) une application pour déterminer combien de vers des sonnets de Louise Labé – s'il y en a – ont une métrique imparfaite. Ou alors, nous pouvons comparer les différentes versions (les "témoins" ou les "témoignages" manuscrits et imprimés) des sonnets, pour réaliser leur édition critique.

Toutefois, tout cela et bien plus encore est possible seulement en vertu d'avoir rendu explicite le contenu de ces sonnets grâce à la TEI. Si nous avions seulement leur texte brut, il serait techniquement impossible de profiter des outils informatiques conçus pour les éditer, transformer, visualiser, analyser ou publier.

# Structure minimale d'un document TEI

Examinons maintenant la structure minimale d'un document TEI :

```XML
<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
      <fileDesc>
         <titleStmt>
            <title>Titre</title>
         </titleStmt>
         <publicationStmt>
            <p>Information de publication</p>
         </publicationStmt>
         <sourceDesc>
            <p>Information sur la source</p>
         </sourceDesc>
      </fileDesc>
  </teiHeader>
  <text>
      <body>
         <p>Du texte...</p>
      </body>
  </text>
</TEI>
```

La première ligne est la déclaration traditionnelle du document XML. 

La deuxième ligne contient l'élément principal ou "racine" de ce document : l'élément `<TEI>`. L'attribut `@xmlns` avec la valeur `http://www.tei-c.org/ns/1.0` déclare simplement que tous les éléments et les attributs enfants de l'élément `<TEI>` appartiennent au "namespace" de la TEI (représenté ici par cette URL). Désormais, cela ne devra plus nous préoccuper.

Ce qui nous intéresse arrive après, dans les lignes 3 et 16, qui contiennent respectivement les deux enfants immédiats de la racine :

- [`<teiHeader>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-teiHeader.html)
- [`<text>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-text.html)

Voyons maintenant en quoi consistent ces deux éléments.

## L'élément \<teiHeader\>

Toutes les métadonnées du document sont encodées dans l’élément `<teiHeader>` : le titre, les auteurs ou les autrices, où, quand et comment il a été publié, sa source, d'où a été tirée la source, etc. Il est courant que les personnes qui commencent à encoder des textes en TEI passent outre ces informations, remplissant ces champs avec des données génériques et incomplètes. Cependant, l'information du `<teiHeader>` est essentielle à la tâche de l'encodeur·euse, car elle sert à identifier avec précision le texte encodé.

Le `<teiHeader>` doit contenir au moins un élément nommé `<fileDesc>` (_file description_ ou description du fichier), qui contient trois éléments enfants en même temps :

- [`<titleStmt>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-titleStmt.html) (_title statement_ ou énoncé de titre) : l'information sur le titre du document (à l'intérieur de l'élément [`<title>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-title.html)) ; optionnellement, il peut aussi inclure des données sur l'auteur·e  ou les auteur·e·s (à l'intérieur de l'élément [`<author>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-author.html)).
- [`<publicationStmt>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-publicationStmt.html) (_publication statement_ ou énoncé de publication) : l'information sur comment le document est publié ou est rendu disponible (autrement dit, le document TEI lui-même, non pas sa source). En ce sens, il est analogue à l'information de l'éditeur/imprimerie dans l'"imprint" ou la page de mentions légales d'un livre. Il peut être un paragraphe descriptif (à l'intérieur d'un élément générique de paragraphe [`<p>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-p.html)) ou il peut être structuré dans un ou plusieurs champs à l'intérieur des éléments suivants :
  - [`<address>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-address.html) : l'adresse postale de la personne qui édite ou encode ;
  - [`<date>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-date.html) : la date de publication du document ;
  - [`<pubPlace>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-pubPlace.html) : le lieu de publication du document ;
  - [`<publisher>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-publisher.html) : la personne qui édite ou encode le document ;
  - [`<ref>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-ref.html) (ou alors [`<ptr>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-ptr.html)) : une référence externe (URL) où le document est disponible.
- [`<sourceDesc>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-sourceDesc.html) (_source description_ ou description de la source) : l'information sur la source dont on tire le texte qui est en train d'être encodé. Il peut être un paragraphe descriptif (à l'intérieur d'un élément générique de paragraphe, `<p>`). Il peut aussi être structuré de plusieurs façons. Par exemple, il peut avoir un élément [`<bibl>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-bibl.html), qui inclut une référence bibliographique non structurée (par exemple, `<bibl>Victor Hugo, "Les Misérables", Paris : Pagnerre, 1862`) ; ou il peut contenir une référence structurée à l'intérieur de l'élément [`<biblStruct>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-biblStruct.html) qui contient à son tour d'autres éléments remarquables.

Supposons que nous voulons encoder la cinquième partie des *Misérables* de Victor Hugo, à partir de [cette édition](https://gallica.bnf.fr/ark:/12148/bpt6k411301m/f4.item) disponible librement sur [Gallica](https://gallica.bnf.fr/accueil/fr/html/accueil-fr). Le `<teiHeader>` de notre document pourrait bien être le suivant :

```XML
<teiHeader>
  <fileDesc>
    <titleStmt>
      <title>Les Misérables</title>
      <author>Victor Hugo</author>
    </titleStmt>
    <publicationStmt>
      <p>
        Encodage en TEI par Maritza Beatriz García Rodríguez en juillet 2025.
      </p>
    </publicationStmt>
    <sourceDesc>
      <p>
        Texte issu de :
        Victor Hugo, "Les Misérables". Cinquième partie : "Jean Valjean" I, Paris : Pagnerre, 1862.
        Disponible ici : https://gallica.bnf.fr/ark:/12148/bpt6k411301m/f4.item
      </p>
    </sourceDesc>
  </fileDesc>
</teiHeader>
```

Il s'agit des informations minimales nécessaires à l'identification du document encodé. Elles indiquent le titre et l'auteur du texte, la personne responsable de l'encodage et la source d'où provient le texte.

Cependant, il est possible – et parfois souhaitable – de spécifier plus en détail les métadonnées du document. Par exemple, considérons cette autre version du `<teiHeader>` pour le même texte :

```XML
<teiHeader>
  <fileDesc>
    <titleStmt>
      <title>Les Misérables</title>
      <author>Victor Hugo</author>
    </titleStmt>
    <publicationStmt>
      <publisher>Maritza Beatriz García Rodríguez</publisher>
      <pubPlace>Lyon, France</pubPlace>
      <date>2025(</date>
      <availability>
        <p>Cette œuvre est en accès libre sous la licence Creative Commons Attribution 4.0 International.</p>
      </availability>
      <ref target="https://github.com/ElvisKarlsson"/>
    </publicationStmt>
    <sourceDesc>
      <biblStruct>
        <monogr>
          <author>Victor Hugo</author>
          <title>Les Misérables</title>
          <edition>1</edition>
          <imprint>
            <publisher>Pagnerre</publisher>
            <pubPlace>Paris</pubPlace>
            <date>1862</date>
          </imprint>
          <biblScope unit="partie" n="5">Jean Valjean</biblScope>
          <bibleScope unit="tome" n="1">I</biblScope>
        </monogr>
        <ref target="https://gallica.bnf.fr/ark:/12148/bpt6k6558010n/f9.item"/>
      </biblStruct>
    </sourceDesc>
  </fileDesc>
</teiHeader>
```

Le choix sur l'exhaustivité de l'information du `<teiHeader>` dépend de sa disponibilité, et obéit aux objectifs de l'encodage et aux intérêts de la personne qui édite ou encode. Cependant, bien que les métadonnées contenues dans le `<teiHeader>` d'un document TEI n'apparaissent pas nécessairement de façon littérale dans le texte encodé, cela ne signifie pas qu'elles ne sont pas pertinentes pour le processus d'encodage, d'édition et d'éventuelle transformation. De même, dans la mesure où le `<teiHeader>` a été correctement et exhaustivement encodé, on pourra extraire et transformer l'information contenue dans le document.

Par exemple, s'il était important pour nous de distinguer les différentes éditions et impressions des *Misérables*, l'information contenue dans les `<teiHeader>` des différents documents transcrits serait suffisante pour pouvoir les discriminer automatiquement. En effet, on pourrait profiter des éléments `<edition>` et `<imprint>` à cette fin, et avec l'aide de technologies comme [XSLT](https://www.w3.org/TR/xslt/), [XPath](https://www.w3.org/TR/xpath/) et [XQuery](https://www.w3.org/TR/xquery/), nous pourrions situer, extraire et traiter toute cette information.

En définitive, plus les métadonnées des textes sont encodées de manière complète et minutieuse dans le `<teiHeader>` de nos documents TEI, plus nous arriverons à contrôler son identité et sa nature.

# L'élément \<text\>

Comme nous l'avons vu ci-dessus dans la structure minimale, `<text>` est le deuxième enfant de `<TEI>`. Il contient tout le texte du document, proprement dit. Selon la [documentation de la TEI](https://guidelines.tei-c.de/fr/html/index.html), `<text>` peut contenir une série d'éléments dans lesquels l'objet-texte doit être structuré :

{% include figure.html filename="fr-tr-introduction-a-tei-1-12.png" alt="Liste des éléments qui peuvent être contenus dans la balise text, organisés selon leur fonction." caption="Figure 12. Des éléments possibles de `<text>`." %}

Le plus important parmi ces éléments est [`<body>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-body.html), qui contient le corps principal du texte. Néanmoins, d'autres éléments importants enfants de `<text>` sont [`<front>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-front.html), qui contient le _frontmatter_ (les pages préliminaires) d'un texte (introduction, prologue, etc.), et [`<back>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-back.html), qui contient le _backmatter_ (les pages finales, des annexes, des index, etc.).

Pour sa part, l'élément `<body>` peut lui-même contenir beaucoup d'autres éléments :

{% include figure.html filename="fr-tr-introduction-a-tei-1-13.png" alt="Liste des éléments qui peuvent être contenus dans la balise body, organisés selon leur fonction." caption="Figure 13. Des éléments possibles de `<body>`." %}

Bien que toutes ces possibilités puissent nous accabler à première vue, nous devons nous rappeler que, d'habitude, un texte se divise naturellement en sections ou parties constitutives. Il est donc recommandable d'utiliser l'élément [`<div>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-div.html) pour chacune d'elles et d'utiliser des attributs tels que `@type` ou `@n` pour qualifier leurs différentes classes et positions dans le texte (par exemple, `<div n="3" type="sous-section">...</div>`).

Si notre texte est court ou simple, nous pourrions utiliser qu'un seul `<div>`. Par exemple :

```XML
<text>
  <body>
    <div>
      <!-- tout notre texte se trouverait ici -->
    </div>
  </body>
</text>
```

Mais si notre texte est plus complexe, nous utiliserions plusieurs éléments `<div>` :

```XML
<text>
  <body>
    <div>
      <!-- la première section ou division se trouverait ici -->
    </div>
    <div>
      <!-- la deuxième section ou division se trouverait ici -->
    </div>
    <!-- etc. -->
  </body>
</text>
```

En principe, la structure de notre document TEI doit être similaire à la structure de l'objet-texte, c'est-à-dire, du texte que nous voulons encoder. Ainsi, si notre objet-texte se divise en chapitres, et ceux-ci, en même temps, en paragraphes, alors nous recommandons de reproduire la même structure dans le document TEI.

Pour les chapitres et les sections, nous pouvons utiliser l'élément `<div>` et pour les paragraphes l'élément `<p>`(https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-p.html).
Observons, par exemple, le schéma suivant :

```XML
<text>
  <body>
    <div type="chapitre" n="1">
      <!-- ceci est le premier chapitre -->
      <div type="section" n="1">
        <!-- celle-ci est la première section -->
        <p>
          <!-- ceci est le premier paragraphe -->
        </p>
        <p>
          <!-- ceci est le deuxième paragraphe -->
        </p>
        <!-- ... -->
      </div>
    </div>
    <!-- ... -->
  </body>
</text>
```

Bien que la TEI nous permette d'encoder exhaustivement beaucoup d'aspects et de propriétés d'un texte, parfois il ne nous intéresse pas nécessairement tous. De plus, le processus d'encodage peut s'étaler dans le temps de manière inutile si nous encodons des éléments dont nous ne profiterons pas lors d'une éventuelle transformation. Par exemple, si nous sommes en train d'encoder le texte d'une édition imprimée, il peut arriver que les divisions de ligne dans les paragraphes ne soient pas pertinentes pour notre encodage.

Dans ce cas, nous pouvons les ignorer et garder seulement les divisions de paragraphe, sans descendre au-delà de celles-ci. Peut-être ressentons-nous aussi la tentation d'encoder systématiquement toutes les dates et les noms de lieux (avec les éléments [`<date>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-date.html) et [`<placeName>`](https://tei-c.org/release/doc/tei-p5-doc/fr/html/ref-placeName.html), respectivement) qui apparaissent dans notre objet-texte, même si nous n'en profiterons pas ultérieurement. Faire cela n'est pas une erreur, mais nous risquons de perdre un temps précieux là-dessus.

En somme, nous pourrions ainsi formuler la "règle d'or" de l'encodage : encodons tous les éléments qui ont pour nous une signification déterminée, et seulement ceux-là, tout en prenant en compte le fait que nous pourrons éventuellement en profiter de manière concrète.

## Conclusion

Dans cette première partie de la leçon, vous avez appris :

1. Ce que signifie encoder un texte.
2. Ce que sont les documents XML et XML-TEI.

Dans [la deuxième partie](https://programminghistorian.org/es/lecciones/introduccion-a-tei-2), qui n'existe actuellement qu'en espagnol, vous verrez en détail deux exemples d'encodages de textes.

## Références recommandées

- La documentation complète de la TEI (les *TEI Guidelines*) disponible sur [le site du consortium](https://tei-c.org/guidelines/). Bien qu'elle soit disponible en plusieurs langues, seule la version anglophone est complète.

- Le livre *Qu'est-ce que la Text Encoding Initiative ?* de Lou Burnard (Marseille: OpenEdition Press, 2015), [disponible gratuitement en ligne](https://doi.org/10.4000/books.oep.1237), est une bonne introduction à la TEI.

- Un bon tutoriel pour XML est disponible sur : [https://www.w3schools.com/xml/](https://www.w3schools.com/xml/) (ressource en anglais).

- Le consortium de la TEI offre aussi [une bonne introduction à XML](https://www.tei-c.org/release/doc/tei-p5-doc/en/html/SG.html) en anglais.

- La documentation officielle de XML est disponible en anglais sur [le site du consortium W3C](https://www.w3.org/XML/). [La documentation pour toute la famille XSL](https://www.w3.org/Style/XSL/) (y compris XSLT) est aussi disponible en anglais.

- La Mozilla Foundation offre aussi un bon site sur XSLT et des technologies associées [en français](https://developer.mozilla.org/fr/docs/Web/XML/XSLT) et [en anglais](https://developer.mozilla.org/en-US/docs/Web/XSLT).

- Le site [TTHUB](https://tthub.io) contient une excellente ["Introducción a la Text Encoding Initiative"](https://tthub.io/aprende/introduccion-a-tei/), en langue espagnole, par Susanna Allés Torrent (2019).

- Une leçon d'introduction de _Programming Historian_ à XML et aux transformations XSL est [*Transforming Data for Reuse and Re-publication with XML and XSL*](https://programminghistorian.org/en/lessons/transforming-xml-with-xsl), de M. H. Beals (ressource en anglais).
