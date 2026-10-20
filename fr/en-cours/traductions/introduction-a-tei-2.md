---
title: "Introduction à l'encodage des textes en TEI (partie 2"
slug: introduction-a-tei-2
original: introduccion-a-tei-2
layout: lesson
collection: lessons
date: 2021-07-27
translation_date: YYYY-MM-DD
authors:
- Nicolás Vaughan
reviewers:
- Rocío Méndez
- Iñaki Cano
editors:
- Jennifer Isasi
translator:
- Nataly Garzón Díaz
translation-editor:
- Forename Surname
translation-reviewer:
- Forename Surname
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/721
difficulty: 2
activity: transforming
topics: [data-manipulation, website, text-encoding]
abstract: Cette leçon (la deuxième de deux parties) vous enseigne les rudiments de TEI-XML pour encoder des textes.
avatar_alt: Gravure montrant la coupe transversale de couches terrestres.
doi: XX.XXXXX/phen0000
previous: introduction-a-tei-1
series_total: 2 lessons
sequence: 2
---

{% include toc.html %}


<div class="alert alert-warning">
  <p><strong>Note de la traductrice :</strong></p>
 <p>
 Cette leçon est une adaptation en français de la deuxième partie de la leçon de Nicolás Vaughan sur l'encodage de textes en TEI. 
 </p>
 <p>
 Dans la leçon originale, l'auteur étudie deux exemples : une carte postale de Federico García Lorca et un manuscrit de Soledad Acosta de Samper. Pour cette version française, deux documents français ont été choisis : une carte postale de Frédéric Mistral à Camille Saint-Saëns, et un extrait du manuscrit des <em>Maîtres sonneurs</em> de George Sand.
 </p>
 <p>
 Cette leçon comporte la même démarche que celle de M. Vaughan : présentation des documents, encodage, explications, code complet, et transformation en HTML avec OxGarage.
 </p>
 <p>
 Enfin, cette leçon est une première contribution à Programming Historian. Elle a été rédigée avec beaucoup de plaisir, et l'espoir est qu'elle soit utile au lecteur.
 </p>
</div>

## Introduction

Cette leçon est la deuxième partie de la leçon d'encodage des textes en langage de balisage [TEI](https://tei-c.org/). La [première](https://programminghistorian.org/fr/lecons/introduction-a-tei-1) a consisté en une brève introduction au concept même d'encodage et son importance dans les Humanités numériques, ainsi qu'aux documents [XML](https://fr.wikipedia.org/wiki/Extensible_Markup_Language) et TEI.

Dans le but d'illustrer les possibilités offertes par la TEI, nous étudierons ici en détail deux exemples d'encodage de textes brefs. 

Bien qu'en principe les deux leçons soient indépendantes dans le sens où l'une peut être comprise sans l'autre, il est vivement recommandé de réviser [la première partie](https://programminghistorian.org/fr/lecons/introduction-a-tei-1) avant de continuer avec les exemples de celle-ci.


### Le logiciel que nous utiliserons

De la même manière que dans la première partie, nous utiliserons l'éditeur de texte [Visual Studio Code](https://code.visualstudio.com/) (abrégé en VS Code) et le *plugin* ou extension [XML Complete](https://marketplace.visualstudio.com/items?itemName=rogalmic.vscode-xml-complete). Les détails de l'installation sont disponibles dans la première leçon.


## Premier exemple : une carte postale

Considérons [la carte postale](https://commons.wikimedia.org/wiki/File:Carte_postale_de_Fr%C3%A9d%C3%A9ric_Mistral_%C3%A0_Camille_Saint-Sa%C3%ABns_(manuscrit_autographe)_-_btv1b531998565_(1_of_4).jpg) suivante, de Frédéric Mistral :

{% include figure.html filename="fr-tr-introduction-a-tei-2-01.jpg" alt="Visual description of figure image" caption="Figure 1. Carte postale de Frédéric Mistral à Camille Saint-Saëns." %}

Les cartes postales ont deux faces : le recto, qui contient une image, et le verso, qui contient l'adresse, le timbre et le corps du message.

En TEI, nous pourrions utiliser deux éléments [`<div>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-div.html) (« division ») pour chaque face. Ensuite, nous nous servirions de l’attribut [`@type`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.typed.html) (« type »)[^1] pour les distinguer avec les valeurs `recto` et `verso` respectivement, comme suit : 

```xml
<text>
  <body>
    <div type="recto">
      <!-- Ici, on encode les informations du recto de la carte postale. -->
    </div>
    <div type="verso">
      <!-- Et ici, on encode les informations du verso de la carte postale. -->
    </div>
  </body>
</text>
```

Pour ce premier exemple, nous aborderons le verso de la carte postale et non son recto, car ce dernier contient l'image et nous ne pourrions pas l'encoder adéquatement pour l'instant. Nous pouvons donc identifier six parties structurelles dans notre carte postale : 

- La date
- Le message
- La signature
- Le lieu
- L'adresse
- Les timbres

Notre encodage ne doit pas être une représentation graphique du texte (c'est-à-dire qu'il ne doit pas simuler à quoi il ressemble), mais une représentation sémantique[^2].

Ainsi, nous utiliserons six éléments `<div>` pour chaque partie de notre carte postale, sans tenir compte de leur localisation spatiale exacte.

Si leur localisation nous intéressait, nous utiliserions les éléments TEI prévus à cet effet pour encoder des [facsimilés numériques](https://tei-c.org/release/doc/tei-p5-doc/en/html/PH.html#PHFAX), mais ce n'est pas notre cas pour l'instant. Nous commencerons donc par la structure suivante :

```xml
<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <fileDesc>
      <titleStmt>
        <title>Carte postale de Frédéric Mistral à Camille Saint-Saëns</title>
        <author>Frédéric Mistral</author>
      </titleStmt>
      <publicationStmt>
        <publisher>Y. Nataly Garzón Díaz</publisher>
        <pubPlace>Rouen, France</pubPlace>
        <date>2026</date>
        <availability>
          <p>Œuvre en libre accès sous licence Creative Commons Attribution 4.0 International.</p>
        </availability>
      </publicationStmt>
      <sourceDesc>
        <biblStruct>
          <monogr>
            <author>Frédéric Mistral</author>
            <title>Carte postale de Frédéric Mistral à Camille Saint-Saëns</title>
            <imprint>
              <pubPlace>Maillane, France</pubPlace>
              <date>1907</date>
            </imprint>
          </monogr>
          <ref target="https://gallica.bnf.fr/ark:/12148/btv1b531998565"/>
        </biblStruct>
      </sourceDesc>
    </fileDesc>
  </teiHeader>
  <text>
    <body>
      <div type="date">
        <!-- Ici, on mettra le texte correspondant à la date. -->
      </div>
      <div type="message">
        <!-- Ici, on tapera le message de la carte postale. -->
      </div>
      <div type="signature">
        <!-- Ici, on écrira la signature. -->
      </div>
      <div type="lieu">
        <!-- Ici, on indiquera le lieu. -->
      </div>
      <div type="adresse">
        <!-- Ici, on écrira l'adresse. -->
      </div>
      <div type="timbres">
        <!-- Ici, on placera le texte correspondant aux timbres et aux cachets postaux. -->
      </div>
    </body>
  </text>
</TEI>
```

Le [`<teiHeader>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-teiHeader.html) de cet encodage contient les données de base de la carte postale (disponibles sur le site de [Wikimedia Commons](https://commons.wikimedia.org/)), ainsi que les métadonnées de l'encodage.

À l'intérieur de [`<text>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-text.html) (texte) nous avons inclus les six éléments `<div>` correspondants aux parties identifiées et nous leur avons attribué l'attribut  `@type` avec les valeurs `date`, `message`, `signature`, `lieu`, `adresse`, et `timbres`.

L'utilisation de cet attribut est facultative, donc il n'est pas nécessaire pour que l'encodage soit valide. Néanmoins, il est utile pour distinguer les différents types de `<div>` de notre encodage, et cela vaut la peine de préciser le type de chacun (comme nous l'avons fait) uniquement si nous pensons nous servir de cette information dans un but précis. Par exemple, si nous souhaitons extraire seulement les informations relatives aux timbres.

Au lieu de l'attribut  `@type`, il est également courant d'utiliser l'attribut global [`@n`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.html#tei_att.n), qui sert à numéroter les éléments du même type.

Par exemple : 

```xml
<text>
  <body>
    <div n="1">
      <!-- Ici, le texte de la date. -->
    </div>
    <div n="2">
      <!-- Ici, le texte du message. -->
    </div>
    <div n="3">
      <!-- Ici, la signature. -->
    </div>
    <div n="4">
      <!-- Ici, le lieu. -->
    </div>
    <div n="5">
      <!-- Ici, le texte de l'adresse. -->
    </div>
    <div n="6">
      <!-- Et enfin, le texte correspondant aux timbres et aux cachets. -->
    </div>
  </body>
</text>
```

Cependant, dans le cas de notre carte postale, l’attribut `@type` nous convient parfaitement.

### Notre premier `<div>` : la date

Comme il s'agit d'un texte manuscrit, il est important de tenir compte des sauts de ligne. Nous utiliserons l’élément autofermant [`<lb/>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-lb.html) (*line break* ou saut à la ligne[^3]). Nous commencerons donc l'encodage par notre premier `<div>` :

```xml
<div type="date">
  <p>
    <lb/>4 juin 1907
  </p>
</div>
```

Si nous analysons cet encodage, nous remarquerons trois phonomènes :

Premièrement, l'enfant immédiat du `<div>` est un élément de paragraphe [`<p>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-p.html). La raison en est que, d'après [les règles sémantiques de la TEI pour les `<div>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-div.html), ces éléments ne peuvent pas contenir directement du texte brut : ils doivent contenir d'autres éléments (par exemple `<p>`).[^4]

Deuxièmement, l'élément vide `<lb/>` se place au début de la ligne qu'il identifie, et non à la fin comme on pourrait s'y attendre. Comme nous l'avons mentionné plus haut, ce type d'éléments — appelés « jalons » ou « marqueurs » (*milestones*) — servent à indiquer des endroits précis dans le texte (ici, des sauts de ligne, mais aussi, par exemple, des sauts de page ou de colonne).

Troisièmement, la date « 4 juin 1907 » est écrite de la main de Mistral, en haut de la partie « Correspondance » de la carte. Nous l'encodons donc simplement comme texte dans un `<p>`, sans autre élément pour l'instant.


### Notre deuxième `<div>` : le message

Passons maintenant au texte du message, qui se trouve dans notre deuxième `<div>`. Ce message est écrit sur cinq lignes. Transcrivons-le d'abord fidèlement, en marquant chaque saut de ligne avec `<lb/>` :

```xml
<div type="message">
  <p>
    <lb/>mes félicitations et mes
    <lb/>très vifs remerciements
    <lb/>pour le discours superbe
    <lb/>et juste en l'honneur
    <lb/>de Gounod !
  </p>
</div>
```

Notons que nous n'avons corrigé ni l'orthographe ni la ponctuation du texte. Nous avons voulu capturer le texte tel qu'il apparaît sur la carte, sans intervention éditoriale : c'est ce qu'on appelle une transcription diplomatique.

Intéressons-nous à présent au nom « Gounod ». Il s'agit d'un nom de personne : le compositeur Charles Gounod (1818-1893), mentionné par Mistral dans son message. Nous pouvons encoder ce nom avec l'élément [`<persName>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-persName.html) (_person name_, « nom de personne ») :
:

```xml
<div type="message">
  <p>
    <lb n="1"/>mes félicitations et mes
    <lb n="2"/>très vifs remerciements
    <lb n="3"/>pour le discours superbe
    <lb n="4"/>et juste en l'honneur
    <lb n="5"/>de <persName>Gounod</persName> !
  </p>
</div>
```

Nous aurions également pu utiliser l'élément [`<name>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-name.html) (« nom »), mais `<persName>` est sémantiquement plus précis : il indique explicitement qu'il s'agit d'un nom de personne, ce qui pourra être utile si nous souhaitons plus tard extraire automatiquement tous les noms de personnes de la carte postale, par exemple.

Intéressons-nous maintenant à la première lettre du message. Mistral a écrit « mes » avec une minuscule, alors qu'orthographiquement, en début de message, on attendrait une majuscule. C'est le genre de cas où la TEI nous permet de distinguer la forme originale de la forme régularisée.

Pour cela, nous utilisons deux éléments :

-   [`<orig>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-orig.html) (_original form_, « forme originale ») pour la forme telle qu'écrite par Mistral.
-   [`<reg>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-reg.html) (_regularization_, « régularisation ») pour la forme normalisée.

Comme pour les abréviations, ces deux éléments doivent être placés dans un élément [`<choice>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-choice.html), afin de les relier :

```xml
<choice>
  <orig></orig>
  <reg></reg>
</choice>
```

Nous pouvons maintenant normaliser le premier mot du message :

```xml
<div type="message">
 <p>
	 <lb n="1"/>
		 <choice>
			 <orig>mes</orig>
			 <reg>Mes</reg>
		 </choice> félicitations et mes
 <lb n="2"/>très vifs remerciements
 <lb n="3"/>pour le discours superbe
 <lb n="4"/>et juste en l'honneur
 <lb n="5"/>de <persName>Gounod</persName> !
 </p>
</div>
```

Le message est maintenant entièrement encodé.


### Notre troisième `<div>`: la signature
Passons maintenant à la signature, qui se trouve dans notre troisième `<div>` et sur une ligne séparée. Comme pour les autres éléments, transcrivons-la d'abord telle qu'elle apparaît sur la carte :

```xml
<div type="signature">
 <p>
	 <lb n="1"/>F. Mistral
 </p>
</div>
```

La signature « F. Mistral » contient deux choses différentes :

1.  Un nom de personne (« F. Mistral »), que nous pouvons encoder avec `<persName>`, comme nous l'avons fait pour « Gounod ».
2.  Une abréviation (« F. »), que nous pouvons encoder avec des éléments spécifiques.

Commençons par encoder le nom de personne :

```xml
<div type="signature">
  <p>
    <lb n="1"/><persName>F. Mistral</persName>
  </p>
</div>
```

Intéressons-nous maintenant à l'abréviation « F. ». Elle correspond au prénom « Frédéric ». La TEI nous offre deux éléments pour encoder ce type d'information :

-   [`<abbr>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-abbr.html) (_abbreviation_, « abréviation ») pour la forme abrégée.
-   [`<expan>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-expan.html) (_expansion_, « expansion ») pour la forme développée.

Comme pour `<orig>` et `<reg>` (que nous avons vus dans le message), ces deux éléments doivent être placés dans un élément [`<choice>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-choice.html) afin de les relier :

```xml
<choice>
  <abbr></abbr>
  <expan></expan>
</choice>
```

Nous pouvons maintenant encoder l'abréviation « F. » comme suit :

```xml
<div type="signature">
  <p>
    <lb n="1"/>
	    <persName>
	      <choice>
	        <abbr>F.</abbr>
	        <expan>Frédéric</expan>
	      </choice>
      Mistral
	    </persName>
  </p>
</div>
```

La signature est ainsi codée : « F. » est reconnu comme une abréviation de « Frédéric », et « Mistral » complète le nom de personne.

Intéressons-nous maintenant à la fonction de cette signature. Dans une lettre ou une carte postale, la signature marque la fin du texte. La TEI nous offre l'élément [`<signed>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-signed.html) (_signed_, « signé ») pour indiquer que le texte qui suit est une signature.

Attention : `<signed>`  ne peut pas être un enfant de `<p>`. Il doit être placé dans un élément de niveau supérieur, comme `div` ou `<closer>`. Nous devons donc sortir la signature de `<p>` ainsi :

```xml
<div type="signature">
 <signed>
 <persName>
 <choice>
 <abbr>F.</abbr>
 <expan>Frédéric</expan>
 </choice>
 Mistral
 </persName>
 </signed>
</div>
```

Notez que nous avons également supprimé le `<p>` et son `<lb n="1"/>` : la signature n'étant plus un paragraphe, elle n'a plus besoin d'être marquée comme une ligne de paragraphe. Elle constitue à elle seule une unité structurelle[^5].

Puisque `<signed>` ne peut pas être contenu dans `<p>`, nous devons réorganiser notre encodage : nous retirons le `<p>` et son `<lb/>`, et nous plaçons la signature dans un `<closer>` qui clôt le `<div>`[^6].

Nous verrons plus loin comment encoder d'autres éléments de la carte (le lieu, l'adresse, les timbres).


### Notre quatrième `<div>` : le lieu

Passons maintenant au lieu, qui se trouve dans notre quatrième `<div>`, sous la signature. Transcrivons-le d'abord tel qu'il apparaît sur la carte :

```xml
<div type="lieu">
 <p>
 <lb n="1"/>Maillane (Provence)
 </p>
</div>
```

Contrairement à la signature, le lieu n'a pas de fonction de clôture. C'est une simple indication géographique : Mistral écrit depuis Maillane, en Provence. Nous pouvons donc utiliser un `<p>` normal, comme pour la date et le message.

Intéressons-nous maintenant au nom « Maillane (Provence) ». Il s'agit d'un nom de lieu : la commune de Maillane, dans la région de la Provence, où Mistral a vécu et écrit une grande partie de son œuvre. La TEI nous offre l'élément [`<placeName>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-placeName.html) (_place name_, « nom de lieu ») pour encoder ce type d'information :

```xml
<div type="lieu">
 <p>
 <lb n="1"/><placeName>Maillane (Provence)</placeName>
 </p>
</div>
```

Nous aurions également pu utiliser l'élément `<name>` (« nom »), comme pour les personnes, mais `<placeName>` est sémantiquement plus précis : il indique explicitement qu'il s'agit d'un nom de lieu, ce qui pourra être utile si nous souhaitons plus tard extraire automatiquement tous les lieux mentionnés dans la carte[^7].


### Notre cinquième `<div>` : l'adresse

Passons maintenant à l'adresse, qui se trouve dans notre cinquième `<div>`. Sur la carte, elle est écrite sur plusieurs lignes, dans la partie droite du verso (la partie « Adresse »). Transcrivons-la d'abord telle qu'elle apparaît :

```xml
<div type="adresse">
	 <p>
		 <lb n="1"/>Monsieur Saint-Saëns,
		 <lb n="2"/>Membre de l'Institut,
		 <lb n="3"/>Paris
 </p>
</div> 
```

Pour encoder une adresse, la TEI nous offre un élément spécifique, c'est [`<address>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-address.html) (« adresse »), qui contient une ou plusieurs lignes d'adresse, chacune encodée dans un élément [`<addrLine>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-addrLine.html) (_address line_, « ligne d'adresse »).

Nous devons également placer `<address>` dans un élément [`<opener>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-opener.html) (« ouverture »), qui sert à encoder le début d'une lettre ou d'une carte postale. C'est une contrainte de la TEI : `<address>` ne peut pas être utilisé seul, il doit être contenu dans un `<opener>`.

Voici ce que cela donne :

```xml
<div type="adresse">
	<opener>
	 <address>
		 <addrLine>Monsieur Saint-Saëns,</addrLine>
		 <addrLine>Membre de l'Institut,</addrLine>
		 <addrLine>Paris</addrLine>
	 </address>
	</opener>
</div>
```

Comme pour le message, nous pouvons maintenant encoder les éléments significatifs. Le nom « Saint-Saëns » est un nom de personne : nous le codons avec `<persName>`. Le nom « Paris » est un nom de lieu : nous le codons avec `<placeName>`. Ces deux éléments ont déjà été introduits plus haut :

```xml
<div type="adresse">
 <opener>
 <address>
 <addrLine>Monsieur <persName>Saint-Saëns</persName>,</addrLine>
 <addrLine>Membre de l'Institut,</addrLine>
 <addrLine><placeName>Paris</placeName></addrLine>
 </address>
 </opener>
</div>
```

Intéressons-nous maintenant à un détail : sous les mots « Rue » et « champ » (de « Longchamp »), on observe deux traits tracés à la main, dans une encre différente de celle de Mistral[^8]. Ces traits semblent marquer une insistance sur ces deux mots. Comment encoder cette insistance ?

La TEI nous offre l'élément [`<hi>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-hi.html) (_highlight_, « mise en évidence ») pour encoder une mise en valeur graphique du texte. Cet élément prend un attribut [`@rend`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.rendition.html) (_rendition_, « rendu ») qui précise la nature de cette mise en valeur. Ici, la valeur sera `underline` (« souligné »).

Nous encodons donc la ligne concernée ainsi :

```xml
<addrLine>17, <hi rend="underline">Rue</hi> du Long<hi rend="underline">champ</hi></addrLine>
```

Ainsi, notre `<div>` complet deviendrait :

```xml
<div type="adresse">
 <opener>
	 <address>
		 <addrLine>Monsieur <persName>Saint-Saëns</persName>,</addrLine>
		 <addrLine>Membre de l'Institut,</addrLine>
		 <addrLine><placeName>Paris</placeName></addrLine>
		 <addrLine>17, <hi rend="underline">Rue</hi> du Long<hi rend="underline">champ</hi></addrLine>
	 </address>
 </opener>
</div>
```

Nous verrons dans la partie suivante comment encoder les timbres et les cachets postaux.


### Notre sixième `<div>` : les timbres et les cachets

Le dernier `<div>` de notre carte postale contient les timbres et les cachets postaux. Transcrivons d'abord les éléments visibles pour après, détailler cet encodage.

```xml
<div type="timbres">
  <ab>
    <stamp>REPUBLIQUE FRANÇAISE 10c POSTES</stamp>
    <stamp>MAILLANE B.-DU-RHÔNE <gap/></stamp>
    <stamp>MUSÉE DE DIEPPE</stamp>
    <stamp>8/4</stamp>
  </ab>
</div>
```

La TEI nous offre l'élément [`<stamp>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-stamp.html) (« cachet », « timbre ») pour encoder les marques apposées sur un document : timbres-poste, cachets de la poste, cachets administratifs, etc. Chaque marque est encodée dans un `<stamp>` distinct.

L'élément [`<ab>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-ab.html) (_anonymous block_, « bloc anonyme ») sert à contenir ces différents `<stamp>` lorsqu'ils ne forment pas un texte continu. C'est le cas ici : les timbres et cachets sont dispersés un peu partout sur la carte, et ne forment pas un ensemble ordonné. Le `<ab>` permet donc de les regrouper dans une même unité.

Enfin, l'élément [`<gap/>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-gap.html) (« lacune ») sert à signaler une partie du texte qui n'est pas lisible ou qui n'a pas été transcrite. Dans le cachet de Maillane, les deux premiers chiffres du centre sont illisibles : nous les marquons par un `<gap/>`. Comme cet élément n'a pas de contenu, on utilise sa forme autofermante[^9].

Notons que nous avons conservé la casse originale des cachets et du timbre en majuscules, car elle fait partie de leur apparence graphique. Ce choix éditorial est assumé par la traductrice[^10].


### Code complet de notre document : la carte postale 

Le [code complet](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/introduction-a-tei-2/carte-postale.xml) du document TEI de la carte postale est le suivant :

```xml
<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
 <teiHeader>
 <fileDesc>
 <titleStmt>
 <title>Carte postale de Frédéric Mistral à Camille Saint-Saëns</title>
 <author>Frédéric Mistral</author>
 </titleStmt>
 <publicationStmt>
 <publisher>Y. Nataly GARZON DIAZ</publisher>
 <pubPlace>Mondeville, France</pubPlace>
 <date>2026</date>
 <availability>
 <p>Œuvre en libre accès sous licence Creative Commons Attribution 4.0 International.</p>
 </availability>
 </publicationStmt>
 <sourceDesc>
 <biblStruct>
 <monogr>
 <author>Frédéric Mistral</author>
 <title>Carte postale de Frédéric Mistral à Camille Saint-Saëns</title>
 <imprint>
 <pubPlace>Maillane, France</pubPlace>
 <date>1907</date>
 </imprint>
 </monogr>
 <ref target="https://gallica.bnf.fr/ark:/12148/btv1b531998565"/>
 </biblStruct>
 </sourceDesc>
 </fileDesc>
 </teiHeader>
 <text>
 <body>
 <div type="date">
 <p>
 <lb n="1"/>4 juin 1907
 </p>
 </div>
 <div type="message">
 <p>
 <lb n="1"/><choice>
 <orig>mes</orig>
 <reg>Mes</reg>
 </choice> félicitations et mes
 <lb n="2"/>très vifs remerciements
 <lb n="3"/>pour le discours superbe
 <lb n="4"/>et juste en l'honneur
 <lb n="5"/>de <persName>Gounod</persName> !
 </p>
 </div>
 <div type="signature">
 <signed>
 <persName>
 <choice>
 <abbr>F.</abbr>
 <expan>Frédéric</expan>
 </choice>
 Mistral
 </persName>
 </signed>
 </div>
 <div type="lieu">
 <p>
 <lb n="1"/><placeName>Maillane (Provence)</placeName>
 </p>
 </div>
 <div type="adresse">
 <opener>
 <address>
 <addrLine>Monsieur <persName>Saint-Saëns</persName>,</addrLine>
 <addrLine>Membre de l'Institut,</addrLine>
 <addrLine><placeName>Paris</placeName></addrLine>
 <addrLine>17, <hi rend="underline">Rue</hi> du Long<hi rend="underline">champ</hi></addrLine>
 </address>
 </opener>
 </div>
 <div type="timbres">
 <ab>
 <stamp>REPUBLIQUE FRANÇAISE 10c POSTES</stamp>
 <stamp>MAILLANE B.-DU-RHÔNE <gap/></stamp>
 <stamp>MUSÉE DE DIEPPE</stamp>
 <stamp>8/4</stamp>
 </ab>
 </div>
 </body>
 </text>
</TEI>
```

Bien que VS Code nous indique que notre code est syntaxiquement valide en XML, nous pouvons vérifier qu'il est également sémantiquement valide en TEI à l'aide du [TBE Validation Service](https://teibyexample.org/tools/TBEvalidator.htm) :

{% include figure.html filename="fr-tr-introduction-a-tei-2-02.png" alt="Visual description of figure image" caption="Figure 2. Validation TEI de notre encodage de la carte postale en *TBE Validation Service*. La couleur verte après *Validation Result* indique que notre validation a eu du succès. S'il y avait des erreurs, nous aurions un message en rouge." %}


## Le deuxième exemple : un manuscrit de George Sand

> **Note de la traductrice :**
>Pour ce deuxième exemple, nous étudierons un extrait du manuscrit des _Maîtres sonneurs_ de George Sand (1857). Dans la leçon originale en espagnol, l'auteur travaille sur un manuscrit de Soledad Acosta de Samper particulièrement riche : sur une même page, il y trouve des notes marginales, des corrections, des citations et plusieurs mains. 
>Nous avons choisi ici un manuscrit qui permet de retrouver la plupart de ces éléments. Certains aspects, propres au document d'Acosta de Samper, ne seront pas repris directement dans l'encodage de Sand. Nous les signalerons dans les notes de bas de page, où le lecteur trouvera des réflexions sur ces éléments.
>

Pour ce deuxième exemple, nous étudierons un extrait du manuscrit de _Les Maîtres sonneurs_, un roman de George Sand publié en 1857. Ce fragment est intéressant pour nos fins, car il introduit des corrections, des ratures et une citation, entre autres particularités textuelles.

L'image de la première du manuscrit, où figure le titre de l'œuvre et de la veillée, est la suivante :

{% include figure.html filename="fr-tr-introduction-a-tei-2-03.png" alt="Visual description of figure image" caption="Figure 3. Page 1 du manuscrit des Maîtres sonneurs : titre, mention du second volume et de la 16e veillée." %}

Nous travaillerons sur un extrait de la 16e veillée, correspondant à la page 6 du manuscrit. L'image de cette page est la suivante :

{% include figure.html filename="fr-tr-introduction-a-tei-2-04.png" alt="Visual description of figure image" caption="Figure 4. Page 6 du manuscrit des Maîtres sonneurs (16e veillée)." %}

### Le `<teiHeader>`

Dans notre cas, le  `<teiHeader>` de ce document sera le suivant : 

```xml
<teiHeader>
 <fileDesc>
 <titleStmt>
 <title>Les Maîtres sonneurs, 16e veillée, page 6 du manuscrit</title>
 <author>George Sand</author>
 </titleStmt>
 <publicationStmt>
 <publisher>Y. Nataly GARZON DIAZ</publisher>
 <pubPlace>Mondeville, France</pubPlace>
 <date>2026</date>
 <availability>
 <p>Œuvre en libre accès sous licence Creative Commons Attribution 4.0 International.</p>
 </availability>
 </publicationStmt>
 <sourceDesc>
 <biblStruct>
 <monogr>
 <author>George Sand</author>
 <title>Les Maîtres sonneurs</title>
 <imprint>
 <pubPlace>Paris</pubPlace>
 <date>1857</date>
 </imprint>
 </monogr>
 <ref target="https://gallica.bnf.fr/ark:/12148/btv1b531998565"/>
 </biblStruct>
 </sourceDesc>
 </fileDesc>
</teiHeader>
```

Comme nous n'encodons qu'une seule page pour cet exercice, nous l'avons indiquée explicitement dans les métadonnées de notre document. Si nous voulions encoder tout le texte des _Maîtres sonneurs_, il ne serait pas nécessaire de préciser cette information. Par ailleurs, comme notre texte objet est un manuscrit dont le lieu et la date de composition sont connus (Paris, 1857), nous les indiquons dans le `<sourceDesc>`.


### Le `<text>`

L'élément [`<text>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-text.html) contient tout le texte du document. Il est composé d'un élément [`<body>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-body.html) (corps), qui contient le corps principal du texte. C'est dans le `<body>` que nous placerons notre `<div>`.

Avant d'encoder le dialogue lui-même, encadrons-le dans un élément [`<div>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-div.html) (division), comme nous l'avons fait pour la carte postale. Nous utilisons ici deux attributs. Le premier, `@type`, prend la valeur `veillee`, pour indiquer qu'il s'agit d'une veillée du roman. Le second, `@n`, prend la valeur `16`, pour indiquer qu'il s'agit de la 16e veillée. Cela nous permet de situer le passage dans l'œuvre.

xml

<text>
 <body>
 <div type="veillee" n="16">
 <p>
 ...
 </p>
 </div>
 </body>
</text>

À première vue, nous pouvons distinguer plusieurs phénomènes sémantiques intéressants dans notre page, illustrés avec des couleurs sur l'image suivante :

{% include figure.html filename="fr-tr-introduction-a-tei-2-05.png" alt="Visual description of figure image" caption="Figure 5. Page 6 du manuscrit des Maîtres sonneurs, avec les différents phénomènes sémantiques signalés par des couleurs." %}


Les phénomènes identifiés sont les suivants :

1. Le numéro de page (cercle bleu turquoise)
2. Le texte principal (encadré vert clair)
3. Une citation (encadré marron)
4. Des ratures avec mot visible (encadré jaune)
5. Des ratures illisibles (encadré rouge)
6. Des substitutions (encadré noir)
7. Des graphies anciennes (encadré orange)
8. Un mot illisible (encadré pourpre)


Maintenant, nous verrons comment encoder chacun de ces phénomènes.

#### 1. La pagination (bleu turquoise)

Dans le manuscrit de George Sand, il y a une seule forme de pagination. Nous trouvons le numéro tapé à la machine à écrire à droite, en haut de la page. Ce numéro ne fait pas partie du texte manuscrit. Probablement, il a été ajouté ultérieurement, par quelqu'un (un archiviste ou un bibliothécaire, par exemple).

La TEI nous offre l'élément `<pb/>` (*page break*, saut de page) pour marquer le passage d'une page à une autre. Cet élément, placé au début de la nouvelle page, c'est un jalon (*milestone*), comme `<lb/>` que nous avons déjà mentionné dans notre exercice de la carte postale.

Comme nous nous intéressons uniquement à ce qui a été écrit à la main dans cette page, nous ne l'encoderons pas. Mais si le numéro avait été manuscrit, nous aurions pu l'encoder de deux manières.

La première consiste à utiliser `<pb/>` avec l'attribut `@n`. L'attribut `@n` sert à donner un numéro ou un identifiant à un élément. Ici, il indiquerait le numéro de la page. Cela donnerait :

```xml
<pb n="6"/>
```

Dans ce cas, `<pb/>` marque le début de la page 6, et `@n="6"` précise son numéro. C'est la manière la plus simple et la plus courante d'encoder une pagination.

La deuxième manière consiste à utiliser l'élément `<ab>` (bloc anonyme) avec l'attribut `@hand` (main). L'attribut `@hand` sert à indiquer la main qui a écrit un texte. Cela permet de distinguer, par exemple, un texte écrit par Sand d'un texte écrit par un archiviste. Pour utiliser `@hand`, il faut d'abord définir les mains dans un endroit du document prévu à cet effet. On utilise pour cela l'élément `<standOff>` et une liste de personnes (`<listPerson>`). Voici comment cela se présenterait :

```xml
<standOff>
 <listPerson>
 <person xml:id="GS">
 <persName>George Sand</persName>
 </person>
 <person xml:id="LA">
 <name>L'Archiviste</name>
 </person>
 </listPerson>
</standOff>
```

Dans cette liste, on définit deux personnes. La première est George Sand, avec un identifiant (`@xml:id="GS"`) et son nom (`<persName>George Sand</persName>`). La seconde est L'Archiviste, avec un identifiant (`@xml:id="LA"`) et son nom (`<name>L'Archiviste</name>`). Comme il ne s'agit pas d'une personne identifiée par un nom propre, on utilise `<name>` plutôt que `<persName>`.

Une fois ces définitions faites, on peut y faire référence ailleurs dans le document en utilisant le signe `#`. C'est pourquoi on écrit `@hand="#GS"` ou `@hand="#LA"` : le `#` indique que l'on renvoie à un identifiant déjà défini. Cela donnerait, pour le numéro de page :

```xml
<ab hand="#GS">6</ab>
```

ou, si le numéro avait été écrit par l'archiviste :

```xml
<ab hand="#LA">6</ab>
```

Cette seconde manière est plus complexe, mais elle permet de distinguer précisément qui a écrit quoi. Dans le cas où un manuscrit contiendrait plusieurs mains, il faudrait définir ces mains dans un élément `<standOff>`, placé entre le `<teiHeader>` et le `<text>`, comme nous l'avons vu dans l'encodage du manuscrit d'Acosta de Samper, dans [la leçon originale en espagnol](https://programminghistorian.org/es/lecciones/introduccion-a-tei-2). Cet élément contient une liste de personnes (`<listPerson>`), où chaque main est identifiée par un identifiant unique (`@xml:id`). C'est cet identifiant que l'on utilise ensuite dans l'attribut `@hand` pour indiquer qui a écrit quoi.

Dans notre cas, le numéro est tapé à la machine. Il ne fait donc pas partie du texte manuscrit. Or, dans cette leçon, nous nous concentrons uniquement sur ce qui a été écrit à la main. Cependant, nous avons tenu à mentionner ces hypothèses parce qu'elles montrent une richesse de la TEI : la possibilité d'encoder non seulement le texte, mais aussi qui l'a écrit, quand, et comment. C'est une dimension essentielle pour les manuscrits qui contiennent plusieurs mains.

Pour notre encodage final, nous ne tiendrons donc pas compte du numéro de page. Nous nous concentrerons uniquement sur le texte manuscrit, et sur les phénomènes que nous avons identifiés ensemble.

#### 2. Le texte principal (vert clair)

Le texte principal est constitué de l'ensemble qui court sur les 28 lignes de la page 6 du manuscrit. Il forme une unité structurelle, encadrée en vert clair sur l'image de la présentation du document.

Commençons par encoder avec les éléments que nous connaissons déjà : [`<p>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-p.html) (paragraphe) et [`<lb/>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-lb.html) (saut de ligne). Chaque ligne est numérotée, comme nous l'avons fait pour la carte postale, avec l'attribut `@n`.

```xml
<p>
  <lb n="1"/>—non, répondit <persName>Huriel</persName>, avec une grande assurance
  <lb n="2"/>à moins que Joseph ne soit mort si bien guéri
  <lb n="3"/>de son amour et de sa maladie qu'il puisse
  <lb n="4"/>renoncer à elle. J'aime Joseph autant que vous
  <lb n="5"/>l'aimez, mes bons enfans ; et d'ailleurs, il m'a fait
  <lb n="6"/>ses confidences, il m'a pris pour son conseil et
  <lb n="7"/>son soutien, je ne le veux pas tromper, ni
  <lb n="8"/>le contrecarrer.
  <lb n="9"/>—mais Brulette ne veut pas de lui pour amant
  <lb n="10"/>et mari, et peutêtre vaudrait-il mieux qu'il
  <lb n="11"/>le sut le plus tot possible. Je me chargerais
  <lb n="12"/>bien de le raisonner, si personne n'osai, et il
  <lb n="13"/>y a chez vous une personne qui pourrait rendre
  <lb n="14"/>Joseph heureux, tandis qu'il ne le sera point par
  <lb n="15"/>Brulette. Il aura beau attendre, plus il se flattera,
  <lb n="16"/>plus le coup lui paraîtra dur à porter : au lieu
  <lb n="17"/>que, s'il ouvrait les yeux sur la véritable attache
  <lb n="18"/>qu'il peut trouver ailleurs....
  <lb n="19"/>—Laissons cela, répondit <persName>Huriel</persName> en fronçant un peu
  <lb n="20"/>le sourcil, ce qui lui fit faire la grimace d'un homme
  <lb n="21"/>qui souffre d'un grand trou à la tête, comme il
  <lb n="22"/>l'avait justement tout frais sous son mouchoir
  <lb n="23"/>rouge : toutes choses sont en la main de Dieu ;
  <lb n="24"/>et, dans notre famille, personne n'est
  <lb n="25"/>pressé de faire son
  <lb n="26"/>bonheur aux dépens de celui des autres. Il faut, quant
  <lb n="27"/>à moi, que je parte, car je répondrais trop mal
  <lb n="28"/>aux gens qui me demanderaient où a passé Malzac
</p>
```

Plusieurs choses doivent être signalées sur cette première version.

Premièrement, nous avons encodé le texte ligne par ligne avec [`<lb/>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-lb.html) et l'attribut `@n`, comme nous l'avons fait pour la carte postale. Cela permet de conserver la structure matérielle du manuscrit, et de retrouver chaque ligne dans la transcription.

Deuxièmement, nous avons encodé le nom « Huriel » avec l'élément [`<persName>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-persName.html) (_person name_, nom de personne), comme nous l'avons fait pour « Gounod » et « Saint-Saëns » dans la carte postale. Cela permet d'identifier les noms de personnes dans le texte.

Troisièmement, nous avons encodé les deux substitutions de la ligne 12 : « personne » remplacé par « les autres », et « n'osai » remplacé par « n'osaient ». Pour cela, nous utilisons l'élément [`<subst>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-subst.html) (substitution), qui relie le texte supprimé ([`<del>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-del.html)) et le texte ajouté ([`<add>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-add.html)). Nous reviendrons plus en détail sur cet encodage dans la partie consacrée aux substitutions.

Quatrièmement, lorsqu'un mot est coupé en fin de ligne, on n'écrit pas de trait d'union. On utilise l'attribut [`@break`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.html#tei_att.break) avec la valeur `no` pour indiquer que le mot continue sur la ligne suivante.[^11] Dans notre page, aucun mot n'est coupé en fin de ligne, donc nous n'utilisons pas cet attribut ici. Mais il est utile de le mentionner, car il apparaîtra dans d'autres pages du manuscrit.

Nous verrons dans les parties suivantes comment intégrer les autres phénomènes identifiés (ratures, graphies anciennes, citation, mot illisible) dans ce texte.


#### 3. Les ratures avec mot visible (jaune)

Aux lignes 2 et 8, nous trouvons des ratures sous lesquelles un mot reste visible. Ces ratures sont encadrées en jaune sur l'image.

La TEI nous offre l'élément [`<del>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-del.html) (deletion, suppression) pour encoder un passage qui a été supprimé dans le manuscrit. Cet élément peut contenir du texte, ou d'autres éléments.

Lorsque le mot raturé est difficile à lire, on peut l'encoder avec l'élément [`<unclear>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-unclear.html), qui signale une lecture difficile ou une difficulté à reconnaître ce qui a été raturé.

À la ligne 2, le mot raturé est « mort », alors notre encodage serait :

```xml
<del><unclear>mort</unclear></del>
```
À la ligne 8, le mot raturé est « le » :

```xml
<del><unclear>le</unclear></del>
```

Ces deux ratures s'intègrent dans le texte principal de la manière suivante :

```xml

<lb n="2"/>à moins que Joseph ne soit <del><unclear>mort</unclear></del> si bien guéri
...
<lb n="8"/><del><unclear>le</unclear></del> contrecarrer.
```

Nous verrons dans la partie suivante comment encoder les ratures dont le contenu est complètement illisible.

#### 4. Les ratures illisibles (rouge)

Aux lignes 24 et 25, nous trouvons des ratures dont le contenu est impossible à déchiffrer. Ces ratures sont encadrées en rouge sur l'image.

La TEI nous offre l'élément [`<gap/>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-gap.html) (lacune) pour signaler qu'un passage du texte n'est pas lisible, ou n'a pas été transcrit. Cet élément n'a pas de contenu : on utilise donc sa forme autofermante. Il peut être imbriqué dans [`<del>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-del.html) pour indiquer qu'il s'agit d'un passage supprimé et illisible.

```xml
<del><gap reason="rature illisible"/></del>
```

L'attribut [`@reason`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.html#tei_att.reason) (raison) est optionnel, mais il permet de documenter la raison de la lacune. Ici, il indique que la lacune est due à une rature illisible.

Ces deux ratures s'intègrent dans le texte principal de la manière suivante :

```xml
<lb n="24"/>et, dans notre famille, personne n'est <del><gap reason="rature illisible"/></del>
<lb n="25"/><del><gap reason="rature illisible"/></del> pressé de faire son
```

#### 5. Les substitutions (noir)

À la ligne 12, deux cas apparaissent. Sand a modifié le texte de deux manières différentes. Ces modifications sont encadrées en noir sur l'image.

**Premier cas : une substitution**

Sand a raturé « personne » et a ajouté « les autres » au-dessus. C'est une substitution.

La TEI nous offre trois éléments pour encoder une substitution :

-   [`<subst>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-subst.html) (substitution), qui relie les deux parties.
-   [`<del>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-del.html) (deletion, suppression), pour le texte supprimé.
-   [`<add>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-add.html) (addition, ajout), pour le texte ajouté.
    

Ces trois éléments s'imbriquent de la manière suivante :

```xml
<subst>
 <del>texte supprimé</del>
 <add>texte ajouté</add>
</subst>
```
Lorsque l'ajout est ailleurs que dans le flux du texte, on précise son emplacement avec l'attribut [`@place`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.place.html). Ici, « les autres » est écrit au-dessus de la rature, donc on utilise `@place="au-dessus"`.[^12]

Dans notre cas, cela donne :

```xml
si <subst><del>personne</del><add place="au-dessus">les autres</add></subst>
```

**Second cas : un ajout**

Sand n'a pas raturé « n'osai ». Elle a ajouté « nt » à la fin du mot, qui devient ainsi « n'osaient ». Elle a également repassé le verbe à l'encre d'une autre couleur, mais le mot d'origine reste lisible.

C'est un ajout, encodé avec l'élément [`<add>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-add.html) seul :

```xml
n'osai<add>nt</add>
```

La ligne 12 complète donne donc :

```xml
<lb n="12"/>bien de le raisonner, si <subst><del>personne</del><add>les autres</add></subst> n'osai<add>nt</add>, et il
```

#### 6. Les graphies anciennes (orange)

Aux lignes 5, 10 et 11, nous trouvons des graphies anciennes telles que « enfans », « peutêtre », « sut », « tot ». La TEI nous offre deux manières d'encoder ces formes. 

La première consisterait à utiliser les éléments [`<sic>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-sic.html) (ainsi, en latin) et [`<corr>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-corr.html) (correction) :

```xml
<choice><sic>enfans</sic><corr>enfants</corr></choice>
```

La seconde consiste à utiliser les éléments [`<orig>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-orig.html) (forme originale) et [`<reg>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-reg.html) (forme régularisée), que nous avons déjà vus dans l'exercice de la carte postale :

```xml
<choice><orig>enfans</orig><reg>enfants</reg></choice>
```

La différence entre les deux paires d'éléments est une décision éditoriale. `<sic>` et `<corr>` signalent une erreur ou une graphie que l'on corrige. `<orig>` et `<reg>` signalent une variation orthographique que l'on normalise. 

Nous devons donc nous demander ce que nous voulons encoder. 
- Voulons-nous signaler que l'écriture manuscrite de Sand comporte des erreurs selon les règles d'écriture actuelles, et que nous en apportons les corrections ?
-  Souhaitons-nous montrer que ces mots appartiennent à une écriture correspondant à une autre époque, et que nous voudrions faciliter leur compréhension dans le monde actuel ?

Dans notre cas, nous avons choisi `<orig>` et `<reg>`, parce que ces formes étaient en usage à l'époque de Sand : « enfans », « peutêtre », « sut » et « tot » n'étaient pas des erreurs, mais des variantes orthographiques[^13].

Nous encodons donc les quatre formes comme suit :

```xml
<choice><orig>enfans</orig><reg>enfants</reg></choice>
<choice><orig>peutêtre</orig><reg>peut-être</reg></choice>
<choice><orig>sut</orig><reg>sût</reg></choice>
<choice><orig>tot</orig><reg>tôt</reg></choice>
```

Dans le texte, cela donne, aux lignes 5, 10 et 11 :

```xml
<lb n="5"/>l'aimez, mes bons <choice><orig>enfans</orig><reg>enfants</reg></choice> ; et d'ailleurs, il m'a fait
<lb n="10"/>et mari, et <choice><orig>peutêtre</orig><reg>peut-être</reg></choice> vaudrait-il mieux qu'il
<lb n="11"/>le <choice><orig>sut</orig><reg>sût</reg></choice> le plus <choice><orig>tot</orig><reg>tôt</reg></choice> possible. Je me chargerais
```

#### 7. Le mot illisible (pourpre)

À la ligne 15, un mot est difficile à identifier. Il est encadré en pourpre sur l'image.

La TEI nous offre l'élément [`<unclear>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-unclear.html) pour signaler un passage dont la lecture est incertaine. Nous l'avons déjà utilisé pour les ratures avec mot visible, mais ici il est utilisé seul, pour un mot qui n'est pas raturé mais dont la graphie est difficile à déchiffrer.

```xml
<unclear>Il</unclear>
```

Dans le texte, cela donne, à la ligne 15, où nous devinons plutôt grâce au texte qui suit qu'il s'agit du mot « Il », mais de manière isolée, il aurait été dur à dévoiler. Donc, nous encodons comme suit :

```xml
<lb n="15"/>Brulette. <unclear>Il</unclear> aura beau attendre, plus il se flattera,
```

L'élément `<unclear>` peut prendre un attribut [`@cert`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.responsibility.html) (certainty, certitude) pour indiquer le degré de certitude de la lecture, avec les valeurs `low`, `mid` ou `high`. Cet attribut est optionnel. Nous ne l'utilisons pas ici, car nous ne cherchons pas à quantifier notre incertitude.

#### 8. La citation (marron)

À la ligne 23, Huriel prononce une phrase qui est une citation biblique : « toutes choses sont en la main de Dieu ». Cette phrase est encadrée en marron sur l'image.

La TEI nous offre l'élément [`<quote>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-quote.html) pour encoder une citation, c'est-à-dire un passage de texte attribué à quelqu'un d'autre que l'auteur du document.

```xml
<quote>toutes choses sont en la main de Dieu</quote>
```

Dans le manuscrit, la citation n'est pas encadrée par des guillemets. Nous les ajoutons pour faciliter la lecture, et nous les encodons avec une balise que nous avons introduit tout à l'heure : [`<corr>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-corr.html). En effet, cet élément nous permet de signaler une intervention éditoriale de notre part :

```xml
<corr>« </corr><quote>toutes choses sont en la main de Dieu</quote><corr> »</corr>
```

Dans le texte, cela donne, à la ligne 23 :

```xml
<lb n="23"/>rouge : <corr>« </corr><quote>toutes choses sont en la main de Dieu</quote><corr> »</corr> ;
```

Et de cette manière. nous avons fait le tour par tous les phénomènes énoncés.


### Code complet du document


Après tout ce voyage grâce à la main de George Sand, nous pouvons présenter le code complet du document TEI de la page 6 du manuscrit des _Maîtres sonneurs_ :

```xml
<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
 <teiHeader>
 <fileDesc>
 <titleStmt>
 <title>Les Maîtres sonneurs, 16e veillée, page 6 du manuscrit</title>
 <author>George Sand</author>
 </titleStmt>
 <publicationStmt>
 <publisher>Y. Nataly Garzón Díaz</publisher>
 <pubPlace>Rouen, France</pubPlace>
 <date>2026</date>
 <availability>
 <p>Œuvre en libre accès sous licence Creative Commons Attribution 4.0 International.</p>
 </availability>
 </publicationStmt>
 <sourceDesc>
 <biblStruct>
 <monogr>
 <author>George Sand</author>
 <title>Les Maîtres sonneurs</title>
 <imprint>
 <pubPlace>Paris</pubPlace>
 <date>1857</date>
 </imprint>
 </monogr>
 <ref target="https://gallica.bnf.fr/ark:/12148/btv1b531998565"/>
 </biblStruct>
 </sourceDesc>
 </fileDesc>
 </teiHeader>
 <text>
 <body>
 <div type="veillee" n="16">
 <p>
 <lb n="1"/>—non, répondit <persName>Huriel</persName>, avec une grande assurance
 <lb n="2"/>à moins que Joseph ne soit <del><unclear>mort</unclear></del> si bien guéri
 <lb n="3"/>de son amour et de sa maladie qu'il puisse
 <lb n="4"/>renoncer à elle. J'aime Joseph autant que vous
 <lb n="5"/>l'aimez, mes bons <choice><orig>enfans</orig><reg>enfants</reg></choice> ; et d'ailleurs, il m'a fait
 <lb n="6"/>ses confidences, il m'a pris pour son conseil et
 <lb n="7"/>son soutien, je ne le veux pas tromper, ni
 <lb n="8"/><del><unclear>le</unclear></del> contrecarrer.
 <lb n="9"/>—mais Brulette ne veut pas de lui pour amant
 <lb n="10"/>et mari, et <choice><orig>peutêtre</orig><reg>peut-être</reg></choice> vaudrait-il mieux qu'il
 <lb n="11"/>le <choice><orig>sut</orig><reg>sût</reg></choice> le plus <choice><orig>tot</orig><reg>tôt</reg></choice> possible. Je me chargerais
 <lb n="12"/>bien de le raisonner, si <subst><del>personne</del><add place="au-dessus">les autres</add></subst> n'osai<add>nt</add>, et il
 <lb n="13"/>y a chez vous une personne qui pourrait rendre
 <lb n="14"/>Joseph heureux, tandis qu'il ne le sera point par
 <lb n="15"/>Brulette. <unclear>Il</unclear> aura beau attendre, plus il se flattera,
 <lb n="16"/>plus le coup lui paraîtra dur à porter : au lieu
 <lb n="17"/>que, s'il ouvrait les yeux sur la véritable attache
 <lb n="18"/>qu'il peut trouver ailleurs....
 <lb n="19"/>—Laissons cela, répondit <persName>Huriel</persName> en fronçant un peu
 <lb n="20"/>le sourcil, ce qui lui fit faire la grimace d'un homme
 <lb n="21"/>qui souffre d'un grand trou à la tête, comme il
 <lb n="22"/>l'avait justement tout frais sous son mouchoir
 <lb n="23"/>rouge : <corr>« </corr><quote>toutes choses sont en la main de Dieu</quote><corr> »</corr> ;
 <lb n="24"/>et, dans notre famille, personne n'est <del><gap reason="rature illisible"/></del>
 <lb n="25"/><del><gap reason="rature illisible"/></del> pressé de faire son
 <lb n="26"/>bonheur aux dépens de celui des autres. Il faut, quant
 <lb n="27"/>à moi, que je parte, car je répondrais trop mal
 <lb n="28"/>aux gens qui me demanderaient où a passé Malzac
 </p>
 </div>
 </body>
 </text>
</TEI>
```

Bien que VS Code nous indique que notre code est syntaxiquement valide en XML, nous pouvons vérifier qu'il est également sémantiquement valide en TEI à l'aide du [TBE Validation Service](https://teibyexample.org/tools/TBEvalidator.htm) :

{% include figure.html filename="fr-tr-introduction-a-tei-2-06.png" alt="Visual description of figure image" caption="Figure 6. Validation TEI de notre encodage des Maîtres sonneurs en TBE Validation Service. La couleur verte après *Validation Result* indique que notre validation a eu du succès. S'il y avait des erreurs, nous aurions un message en rouge." %}


## Conclusion


Dans cette deuxième partie de la leçon, nous avons étudié deux exemples d'encodage de textes brefs en TEI.

Le premier exemple était une carte postale de Frédéric Mistral à Camille Saint-Saëns. Nous avons appris à :

-   structurer un document TEI en divisions (`<div>`).
-   encoder des noms de personnes (`<persName>`) et de lieux (`<placeName>`).
-   distinguer une forme originale d'une forme régularisée (`<orig>`, `<reg>`).
-   encoder une abréviation et son développement (`<abbr>`, `<expan>`).
-   encoder une signature (`<signed>`).
-   encoder une adresse (`<address>`, `<addrLine>`, `<opener>`).
-   encoder une mise en évidence graphique (`<hi rend="underline">`).
-    encoder des timbres et des cachets (`<stamp>`, `<ab>`, `<gap/>`).
    
Le second exemple était un extrait du manuscrit des _Maîtres sonneurs_ de George Sand. Nous avons appris à :

-   encoder une pagination (`<pb/>`).
-   encoder des ratures et des suppressions (`<del>`).
-   encoder des mots difficiles à lire (`<unclear>`).
-   encoder des lacunes (`<gap/>`).
- encoder des substitutions (`<subst>`) et des ajouts (`<add>`).
- encoder des graphies anciennes (`<orig>`, `<reg>`).
- encoder une citation (`<quote>`).
- signaler une intervention éditoriale (`<corr>`).
    

Nous avons également vu que la TEI offre souvent plusieurs manières d'encoder un même phénomène, et que le choix dépend des objectifs du projet. C'est ce qui fait la richesse et la souplesse de la TEI.


## Épilogue : transformer un document TEI


Nous avons appris à encoder deux textes en TEI : une carte postale et un extrait du manuscrit des _Maîtres sonneurs_. Mais maintenant, nous pouvons nous demander que faire de ces encodages ?

L'encodage est un but en soi. Il s'agit d'un travail analytique sur le texte. Mais il s'inscrit aussi dans une chaîne plus longue de traitement, de transformation et de publication. Donc, une deuxième tâche de réflexion, c'est de se demander ce que l'on veut faire avec notre encodage en XML-TEI. Pour transformer un document TEI en un autre format (HTML, PDF, DOCX, ePub, etc.), il faut d'autres outils. La TEI n'est qu'un langage d'encodage.

Il existe des outils simples pour transformer un document TEI sans avoir à écrire de code XSLT. L'un d'eux est [OxGarage](https://oxgarage.tei-c.org/), un service en ligne créé par le consortium TEI. Il permet de convertir un document TEI en XHTML, PDF, DOCX, ePub, etc.

Avant de commencer, il faut s'assurer que le document TEI est syntaxiquement et sémantiquement valide. Sinon, OxGarage ne pourra pas le traiter. Pour cela, on utilise un outil comme le [TBE Validation Service](https://teibyexample.org/tools/TBEvalidator.htm), que nous avons déjà mentionné. Nos deux documents ont été validés avec cet outil, nous pouvons donc passer à la transformation. Il faut également avoir sous la main le fichier .xml que nous avons créé dans Visual Studio Code (ou dans l'éditeur de votre choix), car c'est ce fichier que nous allons téléverser sur le site d'OxGarage.

Une fois la page d'OxGarage ouverte, on clique sur l'option « Documents » :

{% include figure.html filename="fr-tr-introduction-a-tei-2-07.png" alt="Visual description of figure image" caption="Figure 7. OxGarage : option Documents." %}

Ensuite, on sélectionne « TEI P5 XML Document » dans la colonne « Convert from » :

{% include figure.html filename="fr-tr-introduction-a-tei-2-08.png" alt="Visual description of figure image" caption="Figure 8. OxGarage *TEI Garage Conversion* : format d'entrée." %}

On choisit le format de sortie. OxGarage propose 19 possibilités : LaTeX, ePub, DOCX, PDF, XHTML, etc. Pour notre exemple, nous choisissons « XHTML » :

{% include figure.html filename="fr-tr-introduction-a-tei-2-09.png" alt="Visual description of figure image" caption="Figure 9. OxGarage : format de sortie XHTML." %}

On téléverse notre document TEI en cliquant sur « Parcourir », nous téléversons notre fichier .xml et nous vérifions que le nom de notre fichier s'affiche bien. Si notre document contient des images, on peut les téléverser dans une archive .zip avec l'option « Téléverser des images » (*Upload images*) de droite.

{% include figure.html filename="fr-tr-introduction-a-tei-2-10.png" alt="Visual description of figure image" caption="Figure 10. OxGarage : téléversement du document." %}

Enfin, on clique sur « Convert » et on attend que le serveur renvoie le résultat. Si rien ne se passe, il y a probablement une erreur dans le document TEI. OxGarage ne signale malheureusement pas les erreurs.

{% include figure.html filename="fr-tr-introduction-a-tei-2-11.png" alt="Visual description of figure image" caption="Figure 11. OxGarage : conversion." %}

Faisons le test avec la carte postale, puis avec le manuscrit. On peut ouvrir les fichiers .html obtenus dans n'importe quel navigateur, en double-cliquant dessus.

Voici le résultat de la transformation pour notre carte postale :

{% include figure.html filename="fr-tr-introduction-a-tei-2-12.png" alt="Visual description of figure image" caption="Figure 12. Résultat de la conversion de notre encodage de la carte postale en XHTML, ouvert dans un navigateur." %}

Et voici le résultat pour le manuscrit :

{% include figure.html filename="fr-tr-introduction-a-tei-2-13.png" alt="Visual description of figure image" caption="Figure 13. Résultat de la conversion de notre encodage des Maîtres sonneurs en XHTML, ouvert dans un navigateur." %}


Comme on peut le voir, OxGarage a transformé notre encodage en un document lisible, avec les éléments TEI rendus visuellement. Par exemple, les mots encodés avec `<add>` apparaissent entre crochets, et les mots encodés avec `<unclear>` sont suivis d'un point d'interrogation.

Une troisième partie de cette série, consacrée à CETEIcean, est également prévue.


## Références recommandées

-   La documentation complète de la TEI (les _TEI Guidelines_) est disponible sur le site du consortium : [https://tei-c.org/guidelines/](https://tei-c.org/guidelines/). Bien qu'elle soit disponible en plusieurs langues, seule la version anglophone est complète.
    
-   Une bonne introduction (en anglais) à la TEI est le livre _What Is the Text Encoding Initiative_ de Lou Burnard, disponible gratuitement en ligne : [https://books.openedition.org/oep/426?lang=en](https://books.openedition.org/oep/426?lang=en)
    
-   Un bon tutoriel pour XML est disponible en anglais sur : [https://www.w3schools.com/xml/](https://www.w3schools.com/xml/) et sur : [https://www.tutorialspoint.com/xml/index.htm](https://www.tutorialspoint.com/xml/index.htm)
    
-   Le consortium TEI offre aussi une bonne introduction à XML : [https://www.tei-c.org/release/doc/tei-p5-doc/en/html/SG.html](https://www.tei-c.org/release/doc/tei-p5-doc/en/html/SG.html)
    
-   La documentation officielle de XML est disponible sur le site du consortium W3C : [https://www.w3.org/XML/](https://www.w3.org/XML/). La documentation pour toute la famille XSL (y compris XSLT) est également disponible : [https://www.w3.org/Style/XSL/](https://www.w3.org/Style/XSL/)
    
-   La Mozilla Foundation offre aussi une bonne page sur XSLT et les technologies associées : [https://developer.mozilla.org/fr/docs/Web/XSLT](https://developer.mozilla.org/fr/docs/Web/XSLT) (en français) et [https://developer.mozilla.org/en-US/docs/Web/XSLT](https://developer.mozilla.org/en-US/docs/Web/XSLT) (en anglais)
    
-   La page [TTHUB](https://tthub.io/) contient une excellente « Introducción a la Text Encoding Initiative » par Susanna Allés Torrent (2019) : [https://tthub.io/aprende/introduccion-a-tei/](https://tthub.io/aprende/introduccion-a-tei/)
    
-   Dans Programming Historian, une leçon d'introduction à XML et aux transformations XSL est déjà publiée : _[Transformer des données avec XML et XSL pour leur réutilisation](https://fr/lecons/transformer-des-donnees-avec-xml-et-xsl)_, de M. H. Beals.


## Notes de fin

[^1]: Le signe `@` n'apparaît pas dans le code lui-même, mais il est utilisé dans la documentation. Par exemple, dans la ligne de code `<div type="recto">`, `@type` désigne l'attribut `type`.

[^2]: Il existe déjà une [première leçon](https://programminghistorian.org/fr/lecons/introduction-a-tei-1).

[^3]: Un « élément autofermant », c'est un élément en XML qui n'a pas de contenu. Par exemple : `<name></name>` devient `<name/>`. Ces deux écritures sont équivalentes.

    Attention à la barre oblique `/` avant le > (chevron de fermeture). Elle est utilisée en TEI pour les éléments ou balises « jalons » (*milestones*). C'est le cas du saut à la ligne (`<lb/>`), du saut de page (`<pb/>`) et du saut de colonne (`<cb/>`), qui n'ont pas de contenu et sont uniquement utilisés pour marquer un endroit précis dans le texte.
    Les processeurs XML (comme les navigateurs web) développent automatiquement ces éléments sous leur forme longue (`<pb></pb>`), de sorte qu'ils sont complètement synonymes.

[^4]: Certains préfèrent utiliser ici l'élément `<ab>` (*anonymous block*, « bloc anonyme ») plutôt que l'élément `<p>`. Ils le font parce qu'ils considèrent — non sans quelque raison — que ce dernier n'est pas véritablement un paragraphe, mais un bloc de texte générique.

[^5]:  `<signed>` sert à encoder une signature. Il peut être utilisé seul, à l'intérieur d'un `<div>`, ou bien à l'intérieur d'un `<closer>` (qui encode la clôture d'une lettre, d'une carte postale ou de tout autre texte épistolaire). Cependant, la TEI impose des contraintes de hiérarchie : `<closer>` ne peut pas être le premier enfant d'un `<div>`. Comme notre `<div type="signature">` ne contient que la signature, nous utilisons `<signed>` seul. Dans d'autres contextes (par exemple, si la signature venait après un message dans le même `<div>`), il serait recommandé d'utiliser `<closer>`.

[^6]: La TEI offre souvent plusieurs manières d'encoder un même texte : par exemple, on pourrait encoder la signature de Mistral comme un simple `<p>`, ou comme un `<persName>` seul, ou encore comme nous l'avons fait avec `<signed>`. Ces différentes options sont toutes valides en TEI, mais elles ne disent pas la même chose : elles n'ont pas la même valeur sémantique. Choisir une option plutôt qu'une autre, c'est interpréter le texte. C'est pourquoi il est important de bien connaître la hiérarchie des éléments TEI : certains éléments peuvent contenir d'autres éléments, mais pas l'inverse. Par exemple, `<signed>` ne peut pas être contenu dans `<p>`, mais `<p>` peut être contenu dans `<div>`. Cette hiérarchie est définie par les règles de la TEI (le *schema*), que nous ne détaillerons pas ici, mais qu'il est utile de garder en tête.

[^7]: Il existe plusieurs façons d'encoder « Maillane (Provence) », et le choix dépend de ce que l'on souhaite mettre en valeur.

    - On pourrait par exemple écrire `<placeName>Maillane (Provence)</placeName>`, ce qui traite l'ensemble comme un seul nom de lieu.
    - On pourrait aussi écrire `<placeName>Maillane</placeName> (<placeName>Provence</placeName>)`, ce qui distingue deux entités géographiques : la commune (Maillane) et la région (Provence). 
    - Enfin, on pourrait imbriquer les deux : `<placeName>Maillane (<placeName>Provence</placeName>)</placeName>`, ce qui indique que la Provence est une précision à l'intérieur du nom de lieu principal. 

    Ces trois options sont toutes valides en TEI ; elles ne disent simplement pas exactement la même chose. C'est un choix éditorial, qui dépend de l'usage que l'on veut faire de l'information par la suite. Par exemple, si l'on souhaite indexer séparément les communes et les régions.

[^8]: La quatrième ligne de cette adresse (« 17, Rue du Longchamp ») ne fait probablement pas partie du texte écrit par Mistral. Elle est tracée dans une encre différente et d'une autre main, ce qui suggère qu'elle a été ajoutée plus tard, peut-être par le destinataire lui-même ou par un archiviste. En toute rigueur, on ne devrait donc pas l'encoder dans le même `<div>` que le reste de l'adresse, mais plutôt avec un élément spécifique pour les ajouts (comme `<add>`, que nous ne détaillerons pas ici). Nous choisissons cependant de l'inclure dans le même `<div>` à des fins pédagogiques, afin de disposer d'un cas concret pour introduire l'élément `<hi rend="underline">` et discuter du traitement des mises en évidence graphiques. Il s'agit donc d'un choix éditorial assumé, et non d'une description fidèle de la structure de la carte.

[^9]: Le cachet « 8/4 » est un marquage administratif dont la signification exacte n'est pas certaine. Il pourrait s'agir d'un numéro de tournée du facteur, d'un numéro de secteur postal, ou d'une cote d'archivage. Ce type de marquage est courant sur les cartes postales anciennes. On peut l'encoder avec `<stamp>` puisqu'il s'agit d'une marque apposée sur le document, mais on pourrait également le considérer comme une lacune (avec `<gap/>`) si l'on n'est pas sûr de sa nature. Nous choisissons ici de l'encoder comme un cachet, par simplicité.

[^10]: Choix éditorial de cette leçon. Contrairement à ce qui est fait dans la version originale de la leçon, où les cachets et timbres sont transcrits en minuscules (la casse étant jugée non pertinente pour le contenu), nous avons choisi ici de conserver les majuscules telles qu'elles apparaissent sur la carte, afin de rester plus fidèle à la représentation visuelle du document. Ce choix n'a pas d'incidence sur le contenu sémantique. Pour plus de détails sur la distinction entre représentation visuelle et représentation sémantique, le lecteur pourra se reporter à la [première leçon](https://programminghistorian.org/fr/lecons/introduction-a-tei-1).

[^11]: L'attribut `@break="no"` est utilisé lorsqu'un mot est coupé en fin de ligne. Il se place sur le `<lb/>` de la ligne suivante. Voir la [documentation TEI](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.html#tei_att.break) pour plus d'informations. Dans notre page, aucun mot n'est coupé en fin de ligne, mais cet attribut apparaît dans d'autres pages du manuscrit.

[^12]: L'attribut `@place` accepte des valeurs en langue naturelle. Dans cette leçon, nous utilisons `@place="au-dessus"`, en français. La TEI recommande également des valeurs en anglais, comme `above`, `margin`, `inline`, etc. Mais les deux sont valides.
