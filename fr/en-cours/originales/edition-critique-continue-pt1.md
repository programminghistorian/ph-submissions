---
title: "L’édition critique en continu : publier au rythme de l’encodage (Partie 1 : TEI, ODD, RELAX NG, Schematron, XSLT)"
slug: edition-critique-continue-pt1
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
  - Clément Godbarge
reviewers:
  - Forename Surname
  - Forename Surname
editors:
  - Matthias Gille Levenson
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/674
difficulty:
activity: transforming
topics:
abstract: Cette leçon montre comment mettre en place une édition critique &laquo;&nbsp;en continu&nbsp;&raquo; d’un corpus TEI&nbsp;: définir un ODD, générer un schéma RELAX NG, compléter la validation avec Schematron et produire des sorties (texte/HTML/Markdown) via XSLT 2.0. L’exemple s’appuie sur la correspondance de Filippo Cavriana.
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phfr0000
---

{% include toc.html %}

## Introduction

L’édition critique traditionnelle suit un modèle de publication en bloc. L'intégralité du texte est préparé puis publié lorsque le travail est jugé «&nbsp;achevé&nbsp;». Héritée de l’imprimé, cette logique persiste à l’ère numérique, alors même que celui-ci permettrait d’autres rythmes et modalités de publication. Parce que les opérations techniques (conversion, validation, mise en ligne) sont souvent confiées à des spécialistes en fin de chaîne, la flexibilité du numérique demeure sous-exploitée.

Ce modèle s’adapte mal à l’édition critique de sources primaires. Sa rigidité impose une tolérance à l’erreur quasi nulle, ce qui retarde la diffusion de résultats déjà exploitables par la communauté scientifique. Il dissuade aussi nombre de chercheurs de l’intégrer à leur stratégie de publication, car ce travail de longue haleine, bien qu’essentiel à la recherche, reste peu reconnu. Son rapport coût-bénéfice défavorable en fait souvent une variable d’ajustement.

Face à ces limites, l’édition continue offre une alternative intéressante. Par «&nbsp;édition continue&nbsp;», on entend une publication par incréments. Plutôt que d’attendre la finalisation d’un projet éditorial, on diffuse progressivement les documents au fur et à mesure de leur encodage et de leur révision, tout en facilitant les mises à jour régulières du corpus à mesure que de nouvelles sources apparaissent.

Cette approche repose sur des outils simples mais puissants de gestion de versions, tels que Git, qui permettent de suivre précisément chaque modification tout en favorisant une collaboration transparente. Des plateformes comme GitHub ou GitLab offrent en outre des solutions d’automatisation capables de transformer instantanément les fichiers encodés selon les standards de la *Text Encoding Initiative* (TEI) en ressources publiables sur le web et lisibles par des publics différents.

La clé de cette approche tient à une association entre travail éditorial et développement logiciel&#x202F;: représenter le texte encodé comme une donnée structurée et gérer son cycle de vie avec l'outillage de l'ingénierie logicielle. L’encodage TEI, fondé sur XML, est après tout un code déclaratif&#x202F;: il se versionne, se valide et se transforme. Nous adaptons donc des pratiques éprouvées en programmation, notamment la livraison continue (*Continuous Delivery*)&#x202F;: ODD (*one document does it all*) joue le rôle de spécification, RELAX NG (REgular LAnguage for XML, Next Generation) formalise les contraintes structurelles, Schematron les complète par des contraintes éditoriales spécifiques, et les feuilles XSLT constituent une chaîne de transformation et de déploiement qui produit les formats de sortie (HTML, Markdown, etc). Avec Git et une chaîne d’intégration et de déploiement continus ([CI/CD](https://fr.wikipedia.org/wiki/Int%C3%A9gration_continue) - Continuous Integration/Continuous Deployment), chaque mise à jour du dépôt déclenche un contrôle de conformité et une transformation. Couplées à [Zenodo](https://zenodo.org), ces mêmes plateformes permettent aussi l’archivage à long terme de versions que l'on peut citer avec un identifiant numérique de type DOI.

Cette leçon vous montre comment mettre en place une telle édition continue à partir d'un cas précis&#x202F;: la correspondance de Filippo Cavriana (1536-1606), médecin et espion italien à la cour de France et commentateur avisé des guerres de Religion. Tous les outils mobilisés sont gratuits et compatibles avec tous les systèmes d’exploitation. La mise au point peut nécessiter une phase de débogage, mais cet effort en vaut la peine, car il accroît l’autonomie éditoriale, évite la dépendance à des solutions propriétaires et accélère la diffusion des résultats. 

La première partie couvre toutes les composantes de ce flux de travail éditorial. Vous y apprendrez les bases de la TEI, à définir un schéma adapté pour votre projet, à valider le code, et à le transformer localement. Connaître ces fondamentaux vous permettra d'éviter de nombreuses erreurs par la suite. La seconde partie se concentre sur l’infrastructure&#x202F;: gestion collaborative de versions, automatisations en intégration continue, publication sur site web statique et archivage de versions pérennes.

### Prérequis

- Connaissance basique du terminal/ligne de commande
- Notions de XML (balises, attributs)
- Java Runtime Environment (JRE) installé
- Éditeur de texte (VS Code, Notepad++, Vim, SublimeText, etc.)

### Organisation du projet

Avant de commencer, organisons notre espace de travail. Un projet d'édition TEI doit suivre une structure claire pour séparer les différents types de fichiers. À la racine du projet, créez trois répertoires principaux :
- `letters/` contiendra les fichiers TEI-XML de la correspondance (une lettre par fichier)
- `templates/` regroupera vos fichiers de configuration personnalisés (ODD, schémas, XSLT)  
- `output/` recevra les résultats des transformations

Pour les créer, une simple ligne de commande suffira:

```bash
mkdir -p letters templates output
``` 

Pour les outils de transformation, vous avez deux options&#x202F;: soit installer `jing`, `saxon` et leurs dépendances via des gestionnaires de paquets, soit les installer manuellement. La première option est recommandée, surtout si vous êtes novice.

Si vous utilisez windows, il est fortement recommandé d'installer WSL (Windows Subsystem for Linux). WSL utilise Ubuntu par défaut, qui intègre APT comme gestionnaire de paquets. Les utilisateurs Windows suivront donc les instructions macOS/Linux du tutoriel.

Si vous utilisez macOS, assurez-vous d'avoir installé au préalable Homebrew. Pour l'installer, exécutez cette commande sur le terminal&#x202F;: 

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Puis, vous pouvez l'exécuter pour installer les deux paquets&#x202F;:
```bash
brew install saxon
brew install jing-trang
```

Sur Ubuntu/WSL, APT est déjà installé mais requiert sudo&#x202F;:

```bash
sudo apt install libsaxonhe-java jing
```

Sur macOS, les commandes `saxon` et `jing` sont automatiquement disponibles sur le terminal après installation. Sur Linux il est parfois nécessaire de créer des alias. Pour cela, il faut trouver où `saxon` est installé&#x202F;:

```bash
ls /usr/share/java/*saxon*.jar
```

Une fois que vous avez l'adresse exacte, remplacez [nom-exact.jar] dans la commande ci-dessous et exécutez-la&#x202F;:

```bash
echo 'export SAXON_JAR="$HOME/tools/saxon-he.jar"' >> ~/.bashrc
echo 'alias saxon="java -jar $SAXON_JAR"' >> ~/.bashrc
```

Pour `jing`, vérifiez s'il fonctionne directement&#x202F;:

```bash
jing --version
```

Si cette commande n'aboutit pas, créez également un alias&#x202F;:

```bash
echo 'export JING_JAR="$HOME/tools/jing.jar"' >> ~/.bashrc
echo 'alias jing="java -jar $JING_JAR"' >> ~/.bashrc
```

Activez les alias avec&#x202F;: 

```bash
source ~/.bashrc
```  

Ces deux programmes s'éxécutent sur la machine virtuelle Java. Il faut donc installer un JRE avant de les utiliser. Nous recommandons OpenJDK 17 (LTS) ou plus récent&#x202F;: sous **Ubuntu/WSL**, installez‑le avec `sudo apt install openjdk-17-jre`&#x202F;; sous **macOS** (Homebrew), utilisez `brew install openjdk`. Vérifiez ensuite l’installation avec `java -version`. Si la commande n’est pas trouvée, relancez votre terminal ou ajoutez le chemin d’OpenJDK à votre `PATH`.

Si vous préférez télécharger les paquets manuellement, créez un répertoire tools/ et téléchargez les fichiers [JAR](https://fr.wikipedia.org/wiki/JAR_(format_de_fichier)) (Java ARchive) depuis [Saxonica](https://github.com/Saxonica/Saxon-HE/releases) et [Jing-Trang](https://github.com/relaxng/jing-trang/releases). Télécharger les dépendances s'il le faut.

Créez ensuite des alias&#x202F;:
```bash
echo 'alias saxon="java -jar $(pwd)/tools/saxon.jar"' >> ~/.bashrc
echo 'alias jing="java -jar $(pwd)/tools/jing.jar"' >> ~/.bashrc
source ~/.bashrc
```

Après cette configuration, vous pourrez utiliser saxon de manière identique sur macOS et Ubuntu/WSL.

Télécharger localement les feuilles de style TEI, ODD, et Schematron vous permet de travailler sans vous soucier de votre connexion internet&#x202F;: 

```bash
cd templates
wget https://www.tei-c.org/release/xml/tei/stylesheet/odds/odd2relax.xsl
wget https://www.tei-c.org/release/xml/tei/stylesheet/odds/odd2html.xsl
wget https://raw.githubusercontent.com/Schematron/stf/master/iso-schematron-xslt2/iso_svrl_for_xslt2.xsl
wget https://raw.githubusercontent.com/Schematron/stf/master/iso-schematron-xslt2/iso_dsdl_include.xsl
wget https://raw.githubusercontent.com/Schematron/stf/master/iso-schematron-xslt2/iso_abstract_expand.xsl
cd ..
```


### Qu’est‑ce que la TEI ?

La Text Encoding Initiative (TEI) constitue le standard international pour l’encodage de textes en humanités numériques. Née au milieu des années 1980 avec l’objectif d’un balisage commun en [SGML](https://fr.wikipedia.org/wiki/Standard_Generalized_Markup_Language) (Standard Generalized Markup Language), la TEI évolue à partir des années 2000 et adopte le format XML, plus léger et accessible. Cette réforme en a facilité grandement l’adoption.

Aujourd’hui, la TEI propose un langage de balisage riche et modulaire pour décrire la structure et le contenu de documents de toute nature, des manuscrits médiévaux aux correspondances, pièces de théâtre, poèmes, inscriptions épigraphiques, corpus linguistiques, entretiens oraux ou documents multimédias. Le consortium TEI, qui réunit institutions et spécialistes du monde entier, maintient et développe continûment ce standard pour répondre aux besoins de la recherche.

Contrairement à un traitement de texte centré sur l’apparence visuelle, la TEI se concentre sur la structuration et la sémantique du texte. Autrement dit, là où Word applique une italique, la TEI distingue si cette italique signale le titre d’une œuvre `<title>`, un terme en langue étrangère `<foreign>` ou une emphase `<emph>`. Cette structuration sémantique permet à la machine de comprendre le texte et ses composantes.

Un avantage fondamental de la TEI est sa transparence et sa neutralité technique. Les balises TEI s’insèrent directement dans le texte, sans nécessiter de logiciel propriétaire. N’importe quel éditeur de texte convient&#x202F;: Notepad, Vim, VS Code, voire même la commande `echo` dans un terminal.

L’adoption de la TEI garantit deux avantages cruciaux&#x202F;: la pérennité et la portabilité. La pérennité assure que le travail restera accessible et exploitable, indépendamment des évolutions techniques. Contrairement aux formats propriétaires, le TEI-XML est un standard très répandu, lisible par l’homme comme par la machine, qu’elle soit récente ou qu’elle ait trente ans d’âge. La portabilité du TEI découle de sa structuration sémantique&#x202F;: la machine comprend la structure du texte, ce qui permet des transformations automatiques vers d’autres formats, y compris ceux qui n’existent pas encore.

Pour la correspondance de Filippo Cavriana, la TEI permet d’encoder non seulement le texte des lettres, mais aussi leurs métadonnées (expéditeur, destinataire, date, lieu, etc), leurs particularités matérielles (ratures, ajouts marginaux, etc) et leurs références (personnes mentionnées, lieux évoqués, etc). Chaque phénomène textuel reçoit un balisage spécifique qui en facilite le traitement automatique ainsi que l'analyse statistique.

Tout fichier TEI commence par des éléments récurrents. Concrètement, l’en‑tête d’un fichier XML déclare la version et l’encodage des caractères&#x202F;: `<?xml version="1.0" encoding="UTF-8"?>`. La racine `<TEI>` déclare l’espace de noms par défaut de la TEI&#x202F;: `xmlns="http://www.tei-c.org/ns/1.0"`. Ces deux lignes, qui établissent le cadre syntaxique et le vocabulaire TEI à employer, varient rarement.

Les lignes directrices de la TEI précisent que tous les documents se divisent en deux parties&#x202F;: l’en‑tête (`<teiHeader>`) et le corps (`<text>`). Le minimum requis par TEI P5 pour un en‑tête valide est un élément `<fileDesc>` comportant au moins un `<titleStmt>` avec un `<title>`, un `<publicationStmt>` qui décrit le mode de diffusion (même de manière succincte, par exemple dans un paragraphe `<p>`), et un `<sourceDesc>` qui décrit la ou les sources. Des sections complémentaires comme `<encodingDesc>`, `<profileDesc>` ou `<revisionDesc>` sont vivement recommandées, sans être obligatoires.

Voici un extrait d’une lettre de Filippo Cavriana encodée en TEI, tirée du corpus&#x202F;:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <fileDesc>
      <titleStmt>
        <title>Update on Nevers' condition - 3 July 1568</title>
        <author>Filippo Cavriana</author>
      </titleStmt>
      <publicationStmt>
        <p>Exemple minimal</p>
      </publicationStmt>
      <sourceDesc>
        <msDesc>
          <msIdentifier>
            <settlement>Mantua</settlement>
            <repository>Archivio di Stato di Mantova</repository>
            <collection>Archivio Gonzaga</collection>
            <idno>b654, fols. 924r-924v</idno>
          </msIdentifier>
        </msDesc>
      </sourceDesc>
    </fileDesc>
    <profileDesc>
      <correspDesc>
        <correspAction type="sent">
          <persName ref="#pers-cavriana-f">Filippo Cavriana</persName>
          <placeName ref="#place-nevers">Nevers</placeName>
          <date when="1568-07-03"/>
        </correspAction>
        <correspAction type="received">
          <persName ref="#pers-gonzaga-g">Guglielmo Gonzaga</persName>
          <placeName ref="#place-mantova">Mantova</placeName>
        </correspAction>
      </correspDesc>
    </profileDesc>
  </teiHeader>
  <text>
    <body>
      <div type="letter">
        <pb n="924r"/>
        <opener>
          <salute><choice><abbr>Ill.mo</abbr><expan>Illustrissimo</expan></choice> et <choice><abbr>Ecc.mo</abbr><expan>Eccellentissimo</expan></choice> 
          <choice><abbr>S.or</abbr><expan>Signor</expan></choice> mio <choice><abbr>oss.mo</abbr><expan>osservandissimo</expan></choice></salute>
        </opener>
        <p>Il <persName ref="#pers-gonzaga-l-nev">Duca</persName> mio padrone è così ben disposto della<lb/> 
        persona (Dio mercè) che non si potria desiderar<lb/> 
        meglio rispetto al tempi dove siamo, et alla in<lb break="no"/>fermità grave, che ha patito...</p>
        <closer>
          <dateline>Di <placeName ref="#place-nevers">Nevers</placeName>, il <date when="1568-07-03">3 di luglio 1568</date></dateline>
          <salute>Di <choice><abbr>V.E.</abbr><expan>Vostra Eccellenza</expan></choice></salute>
          <signed><choice><abbr>Humiliss.o</abbr><expan>Humilissimo</expan></choice> et <choice><abbr>devotiss.o</abbr><expan>devotissimo</expan></choice> servitore<lb/> 
          <persName ref="#pers-cavriana-f">Filippo Cavriana</persName></signed>
        </closer>
      </div>
    </body>
  </text>
</TEI>
```

Dans cet exemple, le `<teiHeader>` contient des métadonnées telles que l'identification du manuscrit à Mantoue et la description de la correspondance (expéditeur, destinataire, lieu, date). Le corps utilise quelques éléments structurels&#x202F;: `<opener>` et `<closer>` décrivent les formules d'ouverture et de clôture de la lettre, tandis que `<p>` signale les paragraphes. Les sauts de ligne diplomatiques sont signalés par `<lb/>`, balise dite «&nbsp;vide&nbsp;» car elle se ferme toute seule. Lorsqu'un saut de ligne coupe un mot en deux, l'attribut `break="no"` précise qu'il s'agit d'une contrainte de mise en forme et non d'une coupure du contenu. Cela est utile lors de la phase de transformation, car la machine saura alors quand recomposer le mot sans espace ni saut de ligne, se libérant ainsi de la mise en page originale.

Pour ce projet particulier, le choix éditorial est d'offrir au lecteur la forme étendue des abréviations pour améliorer la lisibilité du texte. L'encodage TEI permet de conserver simultanément les deux formes grâce à l'élément `<choice>` qui regroupe `<abbr>` (l'abréviation telle qu'elle apparaît dans le manuscrit original) et `<expan>` (sa forme développée). Cette double conservation présente un avantage majeur&#x202F;: elle maintient la fidélité à la source tout en offrant une flexibilité éditoriale. Lors de la transformation pour publication, on peut choisir d'afficher uniquement la version étendue pour faciliter la lecture, tout en préservant dans le fichier TEI une transcription diplomatique fidèle du texte original. Cette approche garantit que l'information paléographique reste accessible pour les chercheurs qui souhaiteraient étudier les pratiques d'écriture et d'abréviation du scripteur, sans pour autant imposer cette complexité au lecteur général.

Le code TEI comprend aussi les éléments sémantiques `<persName>` et `<placeName>`, qui décrivent des entités nommées. Ils portent des attributs `@ref` renvoyant à un index de personnes et de lieux. Dans un corpus de correspondance, il est recommandé de centraliser ces informations dans des fichiers d’autorité séparés pour garantir la cohérence de l’ensemble ; selon les besoins du projet, elles peuvent aussi être intégrées dans l’en-tête du document.

En voici un exemple&#x202F;:

```xml
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <fileDesc>
      <titleStmt><title>Entités Personnes</title></titleStmt>
      <publicationStmt><p>exemple minimal</p></publicationStmt>
      <sourceDesc><p>...</p></sourceDesc>
    </fileDesc>
    <profileDesc>
      <particDesc>
        <listPerson>
          <person xml:id="pers-cavriana-f">
            <persName>Filippo Cavriana</persName>
            <persName type="alias" xml:lang="it">Vincenzo da Castello</persName>
            <persName type="alias" xml:lang="it">Chi ella sà</persName>
            <sex value="1">male</sex>
            <occupation xml:lang="fr">Médecin et diplomate</occupation>
          </person>
          <person xml:id="pers-gonzaga-g">
            <persName>Guglielmo Gonzaga</persName>
            <sex value="1">male</sex>
            <roleName type="title" xml:lang="fr">Duc de Mantoue</roleName>
            <idno type="VIAF">51953916</idno>
            <birth when="1538-04-24"/>
            <death when="1587-08-14"/>
          </person>
        </listPerson>
      </particDesc>
    </profileDesc>
  </teiHeader>
  <text>
    <body/>
  </text>
</TEI>
```

La TEI étant très flexible, nous pouvons nourrir chaque entrée d'informations supplémentaires. On peut, par exemple, complémenter une entité de lieu avec des coordonnées géographiques, ou des liens à des bases de données d'information géographiques telles que le Getty Thesaurus of Geographic Names (TGN). Dans l'exemple ci-dessus, nous avons choisi de référencer les personnages à la Virtual International Authority File (VIAF) lorsque cela est possible. Ces informations peuvent être utiles, notamment pour faciliter l'interopérabilité entre différents projets numériques, permettre des recherches plus précises et enrichir l'analyse des données textuelles. Elles offrent également la possibilité d'enrichir la publication de ce texte avec des informations contextuelles supplémentaires.

Cet aperçu de la TEI est minimal. Pour découvrir les centaines d'éléments et attributs propres à cette convention, on se reportera à la documentation officielle, *TEI: Recommandations pour l'encodage et l'échange de textes électroniques* ([https://tei-c.org/guidelines/](https://tei-c.org/release/doc/tei-p5-doc/fr/html/index.html)), et aux tutoriels de Nicolás Vaughan dans le _Programming Historian_ en espagnol&#x202F;: _Introducción a la codificación de textos en TEI_([https://programminghistorian.org/es/lecciones/introduccion-a-tei-1](https://programminghistorian.org/es/lecciones/introduccion-a-tei-1)).

### Prévention des erreurs, conformité syntaxique et validité

Le XML est strict&#x202F;: un guillemet manquant, un caractère mal placé ou un espace de trop peut rendre le document illisible pour la machine. Pour limiter les problèmes, encodez toujours vos fichiers Unicode (UTF-8) et normalisez-les en NFC. Unicode offre deux possibilités&#x202F;: «&nbsp;é&nbsp;» peut être encodé soit en un seul point de code précomposé (U+00E9), soit comme «&nbsp;e&nbsp;» suivi de l’accent aigu combinant (U+0065 + U+0301). Visuellement identiques, ces deux formes diffèrent techniquement. La normalisation NFC privilégie la forme précomposée lorsqu’elle existe, ce qui stabilise les caractères accentués et fiabilise recherches, comparaisons et transformations XSLT.

Certaines applications peuvent normaliser le texte en unicode NFC pour vous. Dans Ubuntu/WSL &nbsp;:

```bash
sudo apt install icu-devtools
uconv -x any-nfc -o normalise.xml entree.xml
```

Dans macOS &nbsp;:
```bash
brew install icu4c
/opt/homebrew/opt/icu4c/bin/uconv -x any-nfc -o normalise.xml entree.xml
```

En XML (et donc en TEI), on distingue deux niveaux de conformité. Un document «&nbsp;bien formé&nbsp;» respecte les règles syntaxiques de base&#x202F;: les balises sont correctement imbriquées, les attributs sont entre guillemets, etc. Par exemple, `<p>Ceci est un paragraphe</p>` est «&nbsp;bien formé&nbsp;», alors que `<p>Ceci est un paragraphe<p>` ne l’est pas. Un document «&nbsp;valide&nbsp;» va plus loin&#x202F;: non seulement il est «&nbsp;bien formé&nbsp;», mais il respecte un schéma qui définit quels éléments sont autorisés, dans quel ordre, avec quels attributs et quelles contraintes. En TEI, un fichier peut être «&nbsp;bien formé&nbsp;» mais «&nbsp;pas valide&nbsp;» s’il emploie un élément qui n’existe pas dans la TEI (par exemple `<paragraph>`), s’il place un élément à un endroit non autorisé (par exemple une `<note>` directement sous `<teiHeader>`) ou s’il omet un attribut exigé par le schéma que nous avons  défini au préalable (par exemple un `@ref` obligatoire sur `<persName>`).

Valider régulièrement le code garantit la cohérence des choix éditoriaux. Par exemple, imposer `@place="margin"` sur `<add>` (où @place indique l’emplacement matériel de l’ajout et margin signifie “écrit en marge, hors de la ligne”) aligne tous les contributeurs sur la même convention, ce qui facilite la collaboration, l’interopérabilité avec d’autres corpus et la fiabilité des transformations XSLT.

## Créer un schéma de validation

Pour qu’un projet d’édition soit solide et cohérent, il est essentiel de définir un schéma de validation. Un schéma de validation est un document qui énumère les éléments et attributs autorisés, décrit leur structure et précise les valeurs acceptées. Il agit comme un contrat entre éditeurs et encodeurs&#x202F;: chaque fichier TEI sera comparé à ce schéma, et toute non-conformité sera signalée. Ce mécanisme garantit que tous les fichiers respectent les mêmes conventions, prévient l’introduction d’éléments ou d’attributs imprévus et réduit les incohérences d’encodage. En pratique, le schéma encadre la liberté laissée aux encodeurs&#x202F;: il impose une rigueur technique tout en reflétant les choix éditoriaux propres au projet.

Trois familles de schémas coexistent. La [DTD](https://fr.wikipedia.org/wiki/Document_Type_Definition) (Document Type Definition), héritée du SGML, reste supportée mais n'est pratiquement plus utilisée. [XML Schema (XSD)](https://fr.wikipedia.org/wiki/XML_Schema) permet un typage fin et une validation détaillée, au prix d'une complexité importante. Cependant, la TEI préconise RELAX NG (REgular LAnguage for XML, Next Generation), car sa flexibilité et concision en fait le meilleur choix pour la plupart des éditions. C’est le format que nous utiliserons ici.

 L’application web Roma (https://roma.tei-c.org/) permet de générer un schéma RELAX NG sur mesure via une interface visuelle. Pour une correspondance comme celle de Cavriana, on sélectionne les modules `tei`, `core`, `header`, `textstructure`, `namesdates`, `transcr`, et `msdescription`. Puis on spécialise le schéma afin de refléter les conventions&#x202F;: @type="letter" imposé sur <div>, @ref obligatoire sur <persName> et <placeName> (pointeurs internes #pers-…/#place-…), @when (ISO 8601) requis sur <date> à l’intérieur de <correspAction> et @type restreint à sent/received, @n exigé sur <pb>, autorisation explicite de @break="no" sur <lb/> pour noter une césure non lexicale, restriction de <choice> à la paire <abbr>/<expan>, par exemple, et pourquoi pas la présence d’un <msIdentifier> complet dans <msDesc> (settlement, repository, collection, idno). Ce resserrage fait coïncider le schéma avec votre pratique et fiabilise recherches et transformations XSLT.

Dans la pratique de la TEI, ces choix sont formalisés dans un ODD (One Document Does it all). L’ODD combine la documentation des règles éditoriales et la spécification technique du schéma. Il constitue à la fois un manuel d’encodage et la source à partir de laquelle sont générés les schémas. Autrement dit, il ne s’agit pas seulement d’un document de référence destiné aux éditeurs, mais du point central à partir duquel la validation peut être automatisée. Pour que vos fichiers TEI puissent être contrôlés, l’ODD doit être transformé en un schéma RELAX NG. C’est ce schéma, et non l’ODD directement, que les outils de validation utiliseront pour vérifier la conformité des encodages.

L’exemple suivant montre comment un ODD peut imposer des contraintes&#x202F;: l’attribut `@ref` est rendu obligatoire sur `persName` et `placeName`, et l'attribut `place` de `add` est restreint aux seules valeurs `margin` ou `interlinear`:

```xml
<TEI xmlns="http://www.tei-c.org/ns/1.0"
     xmlns:sch="http://purl.oclc.org/dsdl/schematron">
  <teiHeader>
    <fileDesc>
      <titleStmt><title>ODD Cavriana — MWE</title></titleStmt>
      <publicationStmt><p>Document de Travail</p></publicationStmt>
      <sourceDesc><p>TEI pour correspondance 16e s.</p></sourceDesc>
    </fileDesc>
  </teiHeader>
  <text><body>
    <schemaSpec ident="cavriana" start="TEI">
      <moduleRef key="tei"/>
      <moduleRef key="core"/>
      <moduleRef key="header"/>
      <moduleRef key="namesdates"/>
      <moduleRef key="transcr"/>
      <moduleRef key="textstructure"/>

      <elementSpec ident="persName" mode="change">
        <attList><attDef ident="ref" usage="req"/></attList>
      </elementSpec>
      <elementSpec ident="placeName" mode="change">
        <attList><attDef ident="ref" usage="req"/></attList>
      </elementSpec>

      <elementSpec ident="add" mode="change">
        <attList>
          <attDef ident="place">
            <valList type="closed">
              <valItem ident="margin"/>
              <valItem ident="interlinear"/>
            </valList>
          </attDef>
        </attList>
      </elementSpec>

      <elementSpec ident="correspAction" mode="change">
        <attList>
          <attDef ident="type">
            <valList type="closed">
              <valItem ident="sent"/>
              <valItem ident="received"/>
            </valList>
          </attDef>
        </attList>
      </elementSpec>

      <elementSpec ident="pb" mode="change">
        <attList><attDef ident="n" usage="req"/></attList>
      </elementSpec>

      <elementSpec ident="choice" mode="change">
        <content>
          <sequence>
            <elementRef key="abbr"/>
            <elementRef key="expan"/>
          </sequence>
        </content>
      </elementSpec>
    </schemaSpec>
  </body></text>
</TEI>
```

Après avoir défini l'ODD, il faut le transformer en RELAX NG pour être utilisable par les outils de validation. Cette opération consiste à appliquer une feuille de transformation XSLT au fichier ODD, soit via l'interface Roma, soit en ligne de commande. L'exemple suivant montre comment effectuer cette conversion avec Saxon-HE (Home Edition), un processeur XSLT gratuit et open source développé par Saxonica. A la racine du projet, on exécute&#x202F;: 

```bash
saxon -s:templates/cavriana.odd -xsl:templates/odd2relax.xsl -o:templates/schema-cavriana.rng
```

Ici, `saxon` lance Saxon-HE, `-s` indique le fichier ODD source, `-xsl` précise la feuille XSLT permettant la conversion en RELAX NG que nous avons téléchargé précédement, et `-o` définit le nom du fichier produit, ici `schema-cavriana.rng`. Cette transformation est à effectuer lors de la mise en place initiale du projet et à chaque modification de l'ODD, afin que le schéma de validation reflète toujours les règles éditoriales les plus récentes.

### Valider les documents localement

Une fois le schéma de validation créé, la vérification des fichiers TEI peut se faire localement avec un validateur RELAX NG comme Jing. Cette étape permet de détecter toute erreur structurelle introduite lors de l'encodage, avant tout envoi dans un dépôt ou dans une chaîne d'intégration continue. La validation locale joue ainsi le rôle de premier garde-fou&#x202F;: elle garantit que les fichiers respectent les contraintes définies dans l'ODD, compilées en schéma RELAX NG. Des garde-fous, il en faut beaucoup, car l'expérience nous enseigne que de nombreuses coquilles peuvent s'introduire subrepticement à chaque étape de la manipulation d'un fichier.

Pour valider un fichier unique à partir du schéma RELAX NG généré précédemment&#x202F;:

```bash
jing templates/schema-cavriana.rng letters/1568-07-03.xml
```

Si le document est conforme au schéma, Jing ne produit aucune sortie. En cas d’erreur, il affiche un message sous la forme&#x202F;:

```
fichier:ligne:colonne: error: description de l’erreur
```

Par exemple&#x202F;:

```
letters/1574-10-15.xml:45:12: error: element "persName" not closed
letters/1574-10-15.xml:32:8: error: attribute "type" not allowed here
```

Ces messages lapidaires intimident souvent les débutants. Pourtant, à l'instar de Barthes qui écrivait «&nbsp;lis tes ratures&nbsp;» pour comprendre le travail de l'écriture, l'encodeur doit apprendre à lire ses erreurs. Ces messages ne signalent pas l'échec. Et bien que parfois cryptiques, ils révèlent l'origine de chaque erreur avec, à la clé, une possible solution.

Pour valider un ensemble de fichiers sous macOS ou Linux on utilisera cette commande:

```bash
jing templates/schema-cavriana.rng letters/*.xml
```

Dans un flux de travail efficace, la validation locale est effectuée après chaque session d’encodage et avant tout envoi au dépôt, en complément des validations automatisées exécutées par la chaîne CI/CD.

Si la validation d’un ou plusieurs fichiers peut se faire manuellement, cette approche devient vite fastidieuse dès que le corpus s’étoffe ou que la validation doit être répétée fréquemment. Pour gagner du temps et éviter les oublis, il est préférable d’automatiser cette étape à l’aide d’un script. Un tel script peut parcourir l’ensemble des fichiers d’un répertoire, exécuter la validation pour chacun d’eux, afficher un résumé clair des résultats et renvoyer un code de sortie indiquant si des erreurs ont été détectées. Cette automatisation facilite le contrôle régulier du corpus. En voici un exemple avec Bash.

```bash
#!/bin/bash
SCHEMA="templates/schema-cavriana.rng"
LETTERS="letters/*.xml"
ERRORS=0

echo "Validation du corpus..."
for file in $LETTERS; do
  [ -f "$file" ] || continue
  if jing "$SCHEMA" "$file" 2>/dev/null; then
    echo "OK  $(basename "$file")"
  else
    echo "ERR $(basename "$file")"
    jing "$SCHEMA" "$file"
    ERRORS=$((ERRORS+1))
  fi
done
exit $ERRORS
```

Cette validation peut s'intégrer directement dans les environnements de développement modernes (Visual Studio Code, Sublime Text, Vim) qui exécutent automatiquement la commande à chaque sauvegarde ou via un simple raccourci clavier. Des extensions dédiées facilitent cette automatisation, permettant de détecter les erreurs en temps réel sans quitter l'interface de travail. Le même principe de validation systématique s'appliquera ensuite aux chaînes d'intégration continue sur GitHub ou GitLab.

La validation RELAX NG vérifie que le document respecte à la fois la syntaxe XML et les contraintes structurelles définies dans l'ODD&#x202F;: types de données, règles de présence et de répétition des éléments et attributs. Mais certaines règles échappent à ce cadre purement déclaratif – les contraintes conditionnelles, les vérifications croisées entre parties du document, toute cette logique éditoriale qui dépasse la simple grammaire du schéma. C'est là qu'intervient Schematron, avec ses assertions précises capables de capturer ces cas particuliers.

### Validation éditoriale avec Schematron

RELAX NG valide la forme. Pour exprimer des contraintes de logique éditoriale, on ajoute Schematron. Par exemple, dans une correspondance, on exige à la fois une action d’envoi et une action de réception, et on impose qu’au moins une date soit fournie pour l’action `sent`&#x202F;:

```xml
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:tei="http://www.tei-c.org/ns/1.0">
  <pattern id="correspondance">
    <rule context="tei:teiHeader/tei:profileDesc/tei:correspDesc">
      <assert test="tei:correspAction[@type='sent'] and tei:correspAction[@type='received']">
        correspDesc doit contenir correspAction[@type='sent'] et correspAction[@type='received'].
      </assert>
      <assert test="tei:correspAction[@type='sent']/tei:date[@when or @notBefore or @notAfter]">
        L'action 'sent' doit comporter une date (@when|@notBefore|@notAfter).
      </assert>
    </rule>
  </pattern>
</schema>
```

On compile ensuite le schéma en XSLT&#x202F;:

```bash
saxon -s:templates/cavriana.sch -xsl:templates/iso_svrl_for_xslt2.xsl -o:templates/cavriana-schematron.xsl

```

puis on l’applique aux documents&#x202F;:

```bash
saxon -s:letters/1568-07-03.xml -xsl:templates/cavriana-schematron.xsl -o:output/rapport-schematron.svrl
```

Le rapport SVRL est un fichier XML produit par la transformation Schematron ; il dresse la liste des règles qui n’ont pas été respectées, chacune accompagnée du message défini dans le schéma. En parcourant ce rapport, on identifie rapidement les divergences par rapport aux conventions éditoriales. Ce contrôle complémentaire est particulièrement utile dans un projet collaboratif&#x202F;: il permet de repérer et de corriger immédiatement les incohérences introduites par différents contributeurs, avant qu’elles ne s’accumulent dans le corpus.

Avec la validation terminée et le corpus conforme aux règles définies, on peut passer à une étape essentielle du flux éditorial continu&#x202F;: la transformation des fichiers TEI en formats exploitables par les lecteurs ou par les systèmes de publication.

### La transformation XSLT

La validation garantit la qualité de l'encodage, mais les fichiers TEI restent illisibles pour le grand public. Dans une édition continue, chaque document validé doit être immédiatement publiable. C'est ici qu'intervient XSLT (*eXtensible Stylesheet Language Transformations*), le pont entre l'encodage savant et la diffusion publique.

XSLT transforme le XML-TEI vers n'importe quel format de sortie&#x202F;: HTML pour le web, Markdown pour les générateurs de sites statiques comme Docusaurus, LaTeX pour l'impression, ou même CSV pour l'analyse de données. Cette polyvalence est cruciale pour l'édition continue&#x202F;: une seule source TEI alimente automatiquement plusieurs canaux de publication.

Pour transformer un document, il faut d'abord pouvoir l'interroger. XPath (*XML Path Language*) est un langage de requête conçu pour extraire des informations précises d'un document XML, à l'instar de SQL, qui interroge une base de données relationnelle. En informatique, XPath est omniprésent&#x202F;: les navigateurs web l'utilisent pour manipuler le [DOM](https://fr.wikipedia.org/wiki/Document_Object_Model) (Document Object Model), les outils de test automatisé pour localiser des éléments d'interface, les systèmes de configuration pour extraire des paramètres. Dans notre contexte d'édition numérique, XPath nous permet de cibler précisément les parties du document TEI à transformer.

Un document XML forme un arbre où chaque élément peut avoir des enfants, des attributs et du contenu textuel. XPath navigue dans cet arbre avec une syntaxe qui ressemble aux chemins de fichiers dans un système d'exploitation, mais avec des capacités de recherche bien plus puissantes. Reprenons la lettre de Cavriana du 3 juillet 1568 pour visualiser sa structure&#x202F;:

```

TEI ├── teiHeader │ ├── fileDesc │ │ ├── titleStmt │ │ │ ├── title: "Update on Nevers' condition..." │ │ │ └── author: "Filippo Cavriana" │ │ └── sourceDesc │ │ └── msDesc │ │ └── msIdentifier │ │ ├── settlement: "Mantua" │ │ ├── repository: "Archivio di Stato..." │ │ ├── collection: "Archivio Gonzaga" │ │ └── idno: "b654, fols. 924r-924v" │ └── profileDesc │ └── correspDesc │ ├── correspAction [@type="sent"] │ │ ├── persName [@ref="#pers-cavriana-f"]: "Filippo Cavriana" │ │ ├── placeName [@ref="#place-nevers"]: "Nevers" │ │ └── date [@when="1568-07-03"] │ └── correspAction [@type="received"] │ ├── persName [@ref="#pers-gonzaga-g"]: "Guglielmo Gonzaga" │ └── placeName [@ref="#place-mantova"]: "Mantova" └── text └── body └── div [@type="letter"] ├── pb [@n="924r"] ├── opener │ └── salute │ └── choice (multiple)... ├── p │ ├── persName [@ref="#pers-gonzaga-l-nev"]: "Duca" │ ├── (texte) │ └── lb (multiple) └── closer ├── dateline │ ├── placeName [@ref="#place-nevers"]: "Nevers" │ └── date [@when="1568-07-03"]: "3 di luglio 1568" ├── salute └── signed └── persName [@ref="#pers-cavriana-f"]: "Filippo Cavriana"

```

Dans cet arbre, XPath agit comme un langage de requête. La barre oblique `/` représente la racine, la double barre oblique `//` permet de chercher à n'importe quelle profondeur, le point `.` désigne le nœud courant, deux points `..` remontent au parent, l'arobase `@` accède aux attributs, et les crochets `[]` filtrent selon des conditions.

Prenons des exemples concrets. Pour trouver l'expéditeur de la lettre, on formule cette requête&#x202F;: chercher n'importe où dans le document (`//`) un élément `correspAction` dans l'espace de noms TEI (`tei:correspAction`), mais seulement celui qui a un attribut type égal à "sent" (`[@type='sent']`), puis descendre vers son enfant `persName` (`/tei:persName`). L'expression complète `//tei:correspAction[@type='sent']/tei:persName` nous donne "Filippo Cavriana".

Pour trouver toutes les personnes mentionnées dans le corps de la lettre, on commence par chercher l'élément `body` n'importe où (`//tei:body`), puis on cherche tous les `persName` qu'il contient, peu importe leur profondeur (`//tei:persName`). L'expression `//tei:body//tei:persName` retourne "Duca" et "Filippo Cavriana" de la signature.

Si on veut extraire une date précise, on peut naviguer vers l'élément `date` et récupérer la valeur de son attribut `when` avec l'arobase&#x202F;: `//tei:date/@when` nous donne "1568-07-03". On peut même être plus spécifique et demander uniquement la date d'envoi&#x202F;: `//tei:correspAction[@type='sent']/tei:date/@when`.

Ces requêtes XPath permettent à XSLT de cibler précisément les éléments à transformer. Sans XPath, XSLT serait aveugle. XSLT est un langage déclaratif&#x202F;: on définit des règles indiquant comment transformer chaque partie du document identifiée par une expression XPath.

Commençons par extraire simplement le texte d'une lettre&#x202F;:

```xml
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei">
  <xsl:output method="text" encoding="UTF-8"/>

  <xsl:template match="/">
    <xsl:text>De : </xsl:text>
    <xsl:value-of select="//tei:correspAction[@type='sent']/tei:persName"/>
    <xsl:text>&#xA;À : </xsl:text>
    <xsl:value-of select="//tei:correspAction[@type='received']/tei:persName"/>
    <xsl:text>&#xA;Date : </xsl:text>
    <xsl:value-of select="//tei:correspAction[@type='sent']/tei:date/@when"/>
    <xsl:text>&#xA;&#xA;</xsl:text>
    <xsl:apply-templates select="//tei:body"/>
  </xsl:template>

  <xsl:template match="tei:p">
    <xsl:apply-templates/>
    <xsl:text>&#xA;&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="tei:persName[@ref]">
    <xsl:text>**</xsl:text><xsl:apply-templates/><xsl:text>** [</xsl:text>
    <xsl:value-of select="substring-after(@ref,'#')"/><xsl:text>]</xsl:text>
  </xsl:template>

  <xsl:template match="tei:persName[not(@ref)]">
    <xsl:text>**</xsl:text><xsl:apply-templates/><xsl:text>**</xsl:text>
  </xsl:template>

  <xsl:template match="text()|@*|node()">
    <xsl:apply-templates select="node()"/>
  </xsl:template>
</xsl:stylesheet>
```

Le processeur XSLT parcourt l'arbre XML. Quand il trouve un nœud correspondant à l'expression XPath dans `match`, il applique la transformation définie. L'instruction `apply-templates` poursuit le parcours dans les nœuds enfants.

Pour l'exécuter&#x202F;:

```bash
saxon -s:letters/1568-07-03.xml -xsl:templates/tei-to-text.xsl -o:output/1568-07-03.txt
```

Enrichissons la transformation en naviguant plus précisément dans l'arbre&#x202F;:

```xml
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei">

  <xsl:output method="text" encoding="UTF-8"/>

  <xsl:template match="/">
    <xsl:text>De : </xsl:text>
    <xsl:value-of select="normalize-space(//tei:correspAction[@type='sent']/tei:persName)"/>
    <xsl:text>&#x0A;À : </xsl:text>
    <xsl:value-of select="normalize-space(//tei:correspAction[@type='received']/tei:persName)"/>
    <xsl:text>&#x0A;Date : </xsl:text>
    <xsl:value-of select="//tei:correspAction[@type='sent']/tei:date/@when"/>
    <xsl:text>&#x0A;&#x0A;</xsl:text>
    <xsl:apply-templates select="//tei:body"/>
  </xsl:template>

  <xsl:template match="tei:p">
    <xsl:apply-templates/>
    <xsl:text>&#x0A;&#x0A;</xsl:text>
  </xsl:template>

  <xsl:template match="tei:choice">
    <xsl:choose>
      <xsl:when test="tei:expan"><xsl:apply-templates select="tei:expan"/></xsl:when>
      <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:lb[not(@break) or @break='yes']">
    <xsl:text>&#x0A;</xsl:text>
  </xsl:template>
  <xsl:template match="tei:lb[@break='no']"/>

  <xsl:template match="tei:persName[@ref]">
    <xsl:text>**</xsl:text><xsl:apply-templates/><xsl:text>** [</xsl:text>
    <xsl:value-of select="substring-after(@ref,'#')"/><xsl:text>]</xsl:text>
  </xsl:template>
  <xsl:template match="tei:persName[not(@ref)]">
    <xsl:text>**</xsl:text><xsl:apply-templates/><xsl:text>**</xsl:text>
  </xsl:template>

</xsl:stylesheet>

```

Cette feuille navigue dans l'arbre pour extraire les métadonnées depuis le `teiHeader`, parcourt le `body` pour le contenu, et distingue les éléments selon leurs attributs. Le prédicat `[@ref]` sélectionne les éléments avec cet attribut, tandis que `[not(@ref)]` sélectionne ceux qui ne l'ont pas. La fonction `substring-after(@ref, '#')` extrait la partie après le dièse dans la référence.

Dans le flux d'édition continue, cette transformation s'exécutera automatiquement après chaque validation réussie, convertissant instantanément les nouvelles lettres encodées en format publiable.

## Conclusion

Ce tutoriel a posé le socle local de l’édition continue&#x202F;: personnalisation de la TEI via un ODD, génération d’un schéma RELAX NG, validation (RELAX NG et Schematron) et transformations XSLT vers Markdown et HTML. Ces pratiques assurent cohérence, interopérabilité et portabilité du corpus. Elles permettent déjà de produire localement une édition de qualité professionnelle. 
En intégrant ces pratiques dans des chaînes d'automatisation (Git, CI/CD), nous la publication instantanée et l'archivage pérenne est rendu possible. La seconde partie branchera ce socle sur une chaîne d’intégration et de déploiement continus&#x202F;: gestion de versions avec Git, automatisation (GitHub Actions/GitLab CI/CD), assignation d’un DOI à des instantanés sur Zenodo et publication d’un site statique à chaque modification. L’objectif est que la moindre modification d’un fichier TEI déclenche automatiquement contrôle, transformation et mise en ligne, réalisant ainsi la promesse de l’édition continue.



