---
title: "Introduction à la publication web de fichiers TEI avec CETEIcean"
slug: publier-archives-tei-ceteicean
original: publicar-archivos-tei-ceteicean
collection: lessons
layout: lesson
date: 2021-12-14
translation_date: YYYY-MM-DD
authors:
- Gabriel Calarco
- Gimena del Río Riande
reviewers:
- Melissa Jerome
- Aldo Barriente
editors:
- Joshua G. Ortiz Baco
translator:
- Yanet Hernández Pedraza
translation-editor:
- Forename Surname
translation-reviewer:
- Forename Surname
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/672
difficulty: 2
activity: transforming
topics:
- website
abstract: Cette leçon vous enseigne les étapes nécessaires pour publier en ligne un fichier TEI en utilisant CETEIcean.
avatar_alt: Gravure représentant différentes sources typographiques.
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

---



**Note :** Pour suivre ce tutoriel de manière exhaustive, vous devez savoir ce qu'est le langage de balisage XML-TEI développé par la [Text Encoding Initiative ou TEI](https://tei-c.org/) et quelle est sa fonction en tant que langage standard dans l'édition numérique savante de textes en Sciences humaines et sociales. Vous pouvez trouver des ressources et des tutoriels en français sur l'encodage de textes en TEI sur [La TEI Lite](https://www.tei-c.org/release/doc/tei-p5-exemplars/html/tei_lite_fr.doc.html). Nous vous recommandons également les parties 1 et 2 de la leçon [Introduction à l'encodage de textes en TEI par Nicolás Vaughan](/changer-pour-la-version-en-français) et l'[Initiation XML-TEI par Lauranne Bertrand](http://weburfist.univ-bordeaux.fr/wp-content/uploads/2016/12/20161209_BERTRAND-URFIST-TEI-1.pdf). Durant ce tutoriel, d'autres langages informatiques seront utilisés (comme le [JavaScript](https://www.javascript.com/) et le [CSS](https://fr.wikipedia.org/wiki/Feuilles_de_style_en_cascade)), mais il n'est pas nécessaire d'avoir des connaissances préalables sur leur fonctionnement pour utiliser [CETEIcean](https://github.com/TEIC/CETEIcean).

## Introduction et logiciels que nous utiliserons
Pour ceux qui débutent avec la TEI, l'un des obstacles les plus courants est que, une fois que les textes ont été encodés avec ce langage de balisage, il est difficile de savoir comment les publier en ligne. Pour être visualisés dans un navigateur, les fichiers XML-TEI doivent d'abord être transformés en [HTML](https://fr.wikipedia.org/wiki/Hypertext_Markup_Language) à l'aide de modèles [XSLT](https://fr.wikipedia.org/wiki/Extensible_Stylesheet_Language_Transformations). Cependant, ce processus requiert des connaissances techniques et des outils qui ne sont pas toujours à la portée de tous les humanistes numériques, en particulier ceux qui abordent l'utilisation de la TEI pour la première fois, ceux qui ne connaissent pas encore en profondeur l'utilisation de logiciels d'édition, ou ceux qui n'ont pas accès à des serveurs propres. CETEIcean est un logiciel d'édition numérique qui permet de visualiser des fichiers XML-TEI dans le navigateur sans avoir à appliquer une transformation XSLT.

Ce tutoriel vous guidera à travers les étapes nécessaires pour publier un fichier TEI en ligne en utilisant CETEIcean, une librairie ouverte écrite dans le langage de programmation JavaScript. CETEIcean permet d'afficher les documents TEI dans un navigateur web sans les transformer au préalable en HTML. CETEIcean charge le fichier TEI dynamiquement dans le navigateur et change le nom des éléments TEI pour d'autres en HTML, de sorte que ceux-ci nous permettent de visualiser dans le navigateur web les phénomènes textuels que nous marquons dans nos fichiers en utilisant la TEI.

Tout d'abord, une clarification concernant la visualisation de votre travail : la méthode par défaut de CETEIcean pour afficher les fichiers TEI consiste à charger les fichiers depuis un autre emplacement, souvent le navigateur. Cependant, tous les navigateurs ne vous permettront pas de charger les fichiers s'ils sont stockés sur votre ordinateur. Vous pouvez essayer, mais si cela ne fonctionne pas, vous devrez générer un serveur local, placer les fichiers sur un serveur en ligne, ou utiliser un éditeur de code avec des fonctions de prévisualisation. Pour ce tutoriel, nous suivrons cette dernière option, car nous utiliserons l'éditeur [Visual Studio Code](https://code.visualstudio.com/), avec l'extension *HTML Preview* depuis Extensions. Néanmoins, il existe d'autres options libres pour éditer des fichiers TEI et générer des prévisualisations HTML, comme [jEdit](http://www.jedit.org/) ou [Atom](https://atom.io), ainsi que des versions propriétaires comme [Oxygen](https://www.oxygenxml.com/).

<div class="alert alert-warning">
Mise à jour de mars 2025 : La version originale en espagnol a utilisé l'éditeur <em>Atom</em> ; cependant nous ne recommandons pas d'utiliser Atom, car le logiciel n'a pas reçu de maintenance ni de mises à jour depuis sa fermeture en décembre 2022. Nous avons alors decidé d'utiliser <em>VS Code</em> de la même manière, à condition d'installer également l'extension <em>HTML Preview</em> depuis Extensions.
</div>

Vous devrez donc télécharger et installer [Visual Studio Code](https://code.visualstudio.com/) avant de continuer avec ce tutoriel. Une fois VS Code en fonctionnement, installez l'extension *HTML Preview* (créé par George Oliveira) que vous pouvez trouver en ouvrant les Extensions (cinquième bouton de la barre latérale gauche). Dans la barre de recherche, tapez le nom de l'extension *HTML Preview*. Lorsque l'extension que nous recherchons apparaît dans la liste des résultats, vous devez cliquer sur l'extension et ensuite sur le bouton bleu qui dit "Installer" dans la page qui s'ouvre à côté :

{% include figure.html filename="fr-tr-publier-archives-tei-ceteicean-01.png" alt="Capture d'écran de l'application VS Code qui dirige les lecteurs vers Extensions (le cinquième bouton du menu à gauche) et qui montre comment après une recherche pour 'HTML Preview' les lecteurs peuvent installer l'extension." caption="Figure 1. Processus d'installation de l'extension HTML Preview pour prévisualiser les fichiers en HTML" %}

Nous utiliserons en tant que texte de test *La Dernière Incarnation de Vautrin*, quatrième partie du roman *Splendeurs et misères des courtisanes*, par l'écrivain et essayiste français [Honoré de Balzac](https://fr.wikipedia.org/wiki/Honor%C3%A9_de_Balzac). Ce texte du XIXe siècle a paru en feuilleton dans *La Presse* du 13 avril au 17 mai 1847. Ce texte est la conclusion du roman susmentionné, lequel explore les aspects sousterrains, tels que le crime et la prostitutuion, de la société française du XIXe siècle. Vous pouvez trouver une édition numérique complète du texte réalisée par le projet *ANR Phœbus (« Projet d’hypertexte de l’œuvre de Balzac par l’utilisation de similarités »)* sur : [https://www.ebalzac.com/edition/42-splendeurs-miseres-courtisanes/presse](https://www.ebalzac.com/edition/42-splendeurs-miseres-courtisanes/presse).

Nous commencerons avec un fichier simple (bien qu'un peu long) au format TEI P5, que nous voulons rendre visible dans un navigateur web : [`balzac-42-splendeurs-miseres-courtisanes-presse-derniere-incarnation-vautrin.xml`](https://api.nakala.fr/data/10.34847/nkl.4fb47i30/a29cf71aeb3f98543df574d5efddf11c8b34d7ef). Pour télécharger le fichier, faites un clic droit sur le lien de téléchargement et sélectionnez l'option 'Enregistrer sous...'.

## Étape 1 : Créer une structure pour nos fichiers
Nous commencerons par établir une structure pour nos fichiers, c'est-à-dire un dossier conteneur avec le nom 'tutoriel_fr' avec les sous-dossiers et les fichiers que nous vous indiquerons ci-dessous. Vous pouvez télécharger le répertoire complet du dépôt [CETEIcean sur GitHub](https://github.com/TEIC/CETEIcean) et travailler dans le dossier 'tutoriel_fr', ou vous pouvez télécharger les fichiers individuellement, à condition qu'ils conservent la même structure que sur le dépôt git du projet, qui est la suivante :

```
  tutoriel_fr/
      |
      |--- css/
            |
            |--- tei.css
      |
      |--- js/
            |
            |--- CETEI.js
      |
      |--- balzac-42-splendeurs-miseres-courtisanes-presse-derniere-incarnation-vautrin.xml
      |--- README.md (le fichier que vous êtes en train de lire)
```

L'étape suivante consistera à créer un nouveau fichier sur VS Code avec le nom `index.html`. Pour cela, vous pouvez aller à Fichier > Nouveau fichier... ou utiliser le raccourci Ctrl + N (Cmd + N sur Mac). Dans ce document, vous devez copier et coller le contenu suivant :

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">

</head>
<body>

</body>
</html>
```

Ensuite, vous devez enregistrer ce fichier dans le répertoire racine (dans notre cas, le dossier 'tutoriel_fr') ; rappelez-vous que son titre doit être `index.html`. Ce fichier servira de structure dans laquelle nous mettrons les instructions pour afficher nos fichiers TEI. Tels que les fichiers TEI, les fichiers HTML ont un en-tête, appelé `head`, et un corps de texte, appelé `body`. Tout au long de ce tutoriel, nous utiliserons ce fichier pour ajouter des liens vers notre CSS (_Cascading Style Sheet_, également appelée _feuille de style_ ou [_feuille de styles en cascade_](https://fr.wikipedia.org/wiki/Feuilles_de_style_en_cascade) en français) et vers nos fichiers JavaScript, et nous écrirons un peu de JavaScript pour obtenir une visualisation de notre document TEI qui reflète les aspects du balisage que nous souhaitons mettre en évidence. Dans la première ligne vide du `<head>`, écrivez :

```html
  <link rel="stylesheet" href="css/tei.css">
```


Cela connectera notre fichier CSS à notre page HTML, lui donnant accès aux directives de style qu'il contient (il n'y en a que quelques-unes, mais nous en ajouterons d'autres). Ensuite, nous inclurons la librairie CETEIcean, en ajoutant la ligne suivante après le lien vers la feuille de style :

```html
  <script src="js/CETEI.js"></script>
```

À ce stade, notre fichier `index.html` devrait avoir le contenu suivant :

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
<!-- Lignes ajoutées -->
<link rel="stylesheet" href="css/tei.css">
<script src="js/CETEI.js"></script>
<!-- Lignes ajoutées -->
</head>
<body>

</body>
</html>
```

## Étape 2 : Charger et prévisualiser le fichier TEI
Nous sommes maintenant prêts à charger le fichier TEI. Pour cela, nous devons ajouter une séquence de commandes informatiques communément appelée par son nom anglais ["script"](https://fr.wikipedia.org/wiki/Langage_de_script), qui nous permettra de récupérer le document TEI de *La Dernière Incarnation de Vautrin* dans notre fichier HTML (celui que nous éditons en ce moment). Copiez et collez les lignes de code suivantes après le dernier élément que nous avons ajouté (`<script src="js/CETEI.js"></script>`) :

```html
<script>
let c = new CETEI();
 c.getHTML5('balzac-42-splendeurs-miseres-courtisanes-presse-derniere-incarnation-vautrin.xml', function(data) {
   document.getElementsByTagName("body")[0].appendChild(data);
 });
</script>
```

Vous n'avez pas besoin d'être un expert en JavaScript pour utiliser CETEIcean, mais apprendre son fonctionnement de base peut être utile. Si vous souhaitez inclure des fonctions avancées, vous devrez apprendre JavaScript. Sur le réseau pour développeurs de Mozilla, vous pouvez trouver un excellent [guide JavaScript](https://developer.mozilla.org/fr/docs/Web/JavaScript/Guide) dans plusieurs langues, dont le français. Pour ce tutoriel, nous vous dirons seulement que les lignes de code que nous avons ajoutées font plusieurs choses :

- En premier lieu, une variable `c` est définie comme un nouvel objet CETEI. Cela s'occupera de charger et de styler notre fichier source
- Ensuite, nous indiquerons à `c` de charger le fichier source et de le convertir en HTML ([Custom Elements](https://fr.javascript.info/custom-elements)), et nous lui donnerons également une fonction qui prendra les résultats et les mettra dans le `<body>` de notre fichier `index.html`
- Dans la ligne `document.getElementsByTagName('body')`, on appelle une fonction qui recherche tous les éléments `<body>` et les renvoie sous la forme d'une liste ordonnée (une liste dans laquelle on peut accéder aux membres qui la composent à travers leur numéro d'index)
- Dans notre exemple, il n'y a qu'un seul élément `<body>`, nous obtiendrons donc une seule entrée dans notre liste, avec l'index 0. Cet élément, qui est un élément HTML, est attaché en tant qu'enfant du document TEI que nous venons de charger

À ce stade, vous devriez pouvoir exécuter une prévisualisation du fichier HTML. Nous allons le prévisualiser avec l'extension que nous avons installé au début de ce tutoriel. Donc, allez faire un clic droit sur le fichier HTML et choisissez dans le menu déroulant l'option « *Open Preview* » :

{% include figure.html filename="fr-tr-publier-archives-tei-ceteicean-02.png"  alt="Capture d'écran qui montre l'option à choisir dans le menu déroulant qui s'ouvre en faisant un clic droit sur le fichier HTML." caption="Figure 2. Menu des options pour prévisualiser les fichiers en HTML sur VS Code" %}

{% include figure.html filename="fr-tr-publier-archives-tei-ceteicean-03.png"  alt="Capture d'écran qui montre comment trouver l'option pour changer les paramètres de sécurité de l'extension 'HTML Preview' en faisant clic sur le bouton de 'Plus d'actions...' trouvé à la droite de l'écran." caption="Figure 3 Bouton pour changer les paramètres de sécurité de l'extension 'HTML Preview' pour permettre l'execution des scripts pour la prévisualisation des fichiers TEI avec CETEIcean" %}

{% include figure.html filename="fr-tr-publier-archives-tei-ceteicean-04.png"  alt="Capture d'écran qui indique qu'il faut choisir l'option 'Disable' pour pouvoir prévisualiser les fichiers TEI avec CETEIcean." caption="Figure 4. Option à choisir pour activer l'execution des scripts pour la prévisualisation des fichiers TEI avec CETEIcean" %}

{% include figure.html filename="fr-tr-publier-archives-tei-ceteicean-05.png" alt="Capture d'écran de la première prévisualisation de notre fichier TEI avec CETEIcean" caption="Figure 5. Première prévisualisation de notre fichier TEI avec CETEIcean" %}

Si vous n'utilisez pas VS Code, vous pouvez faire la même chose en plaçant vos fichiers sur un serveur web. Si vous connaissez le fonctionnement de GitHub, vous pouvez utiliser GitHub Pages (voici un [tutoriel](https://docs.github.com/fr/pages/quickstart) en français) et créer un dépôt. Si vous avez installé Python sur votre ordinateur, vous pouvez exécuter un serveur web simple dans le répertoire de ce tutoriel (dans notre cas, le dossier 'tutoriel_fr'). À cette fin, vous devez ouvrir la console de commandes et vérifier que vous êtes dans le dossier souhaité (sinon, vous pouvez naviguer jusqu'à ce dossier avec la commande `cd + url du fichier`, par exemple : `cd Documents/tutoriel_fr`) et entrer la commande :

```bash
python -m SimpleHTTPServer
```

Il est également possible que votre ordinateur ait déjà les programmes nécessaires pour exécuter un serveur web, ou vous pouvez installer [MAMP](https://www.mamp.info) ou un autre programme similaire. L'objectif de la création de ce serveur est de visualiser nos fichiers TEI dans le navigateur comme s'il s'agissait d'un contenu en ligne.

## Étape 3 : Améliorer la visualisation de notre fichier
Cette première visualisation aura plusieurs erreurs que nous devrons corriger. Pour cela, nous reviendrons à notre travail sur VS Code. Nous commencerons par ajouter une feuille de style pour manipuler les éléments TEI dans notre fichier, puis nous ajouterons des fonctions de CETEIcean pour faire des modifications plus complexes. Si vous n'avez pas encore jeté un coup d'œil au fichier source XML, c'est le bon moment pour le faire, pour voir ce que CETEIcean fait déjà et ce qu'il ne fait pas. Nous pouvons observer que le contenu du `teiHeader` n'est pas affiché, tout comme les débuts de page et les débuts de lignes. Les éléments `div` et `p`, quant à eux, sont formatés comme des blocs et les notes apparaissent dans le corps du texte entre parenthèses. Avec un peu de recherche sur les possibilités de codage de la TEI, vous verrez qu'il existe huit types d'éléments TEI dans le `body` de notre document source :

 * [div](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-div.html)
 * [head](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-head.html)
 * [note](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-note.html)
 * [p](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-p.html)
 * [q](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-q.html)
 * [hi](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-hi.html)
 * [pb](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-pb.html)
 * [label](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-label.html)

Certains de ces éléments peuvent ne pas nécessiter de styles ou de comportements spéciaux, mais d'autres en auront certainement besoin.
Jetez un coup d'œil au fichier `tei.css` du dossier `css/`. Comme vous pouvez le voir, il n'a que quelques règles pour l'instant :

```css
tei-div {
  display: block;
}
tei-p {
  display: block;
  margin-top: .5em;
  margin-bottom: .5em;
}
```


Quelques points à garder à l'esprit : les noms des éléments dans nos sélecteurs CSS ont le préfixe `tei-`. Ceci est nécessaire pour que CETEIcean puisse convertir les éléments TEI en éléments HTML personnalisés ([Custom Elements](https://fr.javascript.info/custom-elements)). Ces règles établissent que les éléments `<div>` sont visualisés comme des blocs (ils commencent sur une nouvelle ligne et se terminent par une coupure) ; il en va de même pour les paragraphes, qui ont également un espacement supérieur et inférieur.

Décider quels styles appliquer aux éléments qui n'ont pas encore de règles de style peut ne pas être simple, mais nous pouvons commencer par choisir certains des cas les plus simples. Dans notre document source, les en-têtes des différentes sections sont signalés par l'élément `<head>`. Nous souhaiterons probablement que ces en-têtes se distinguent du corps du texte, pour y parvenir, nous pouvons utiliser CSS pour leur donner un style différent. Maintenant, vous devez ouvrir le fichier `tei.css` (que vous trouverez dans le dossier "css") sur VS Code et à la fin du document, ajoutez les lignes suivantes :

```css
tei-head {
  font-size: 2em;
  font-weight: bold;
}
```

Vous verrez que ce n'est pas une solution parfaite, car nous avons différents niveaux d'éléments `<div>`, et il serait approprié que les en-têtes de différents niveaux aient des tailles différentes pour les identifier. Étant donné que les éléments `<div>` de notre fichier TEI n'indiquent pas à quel niveau ils appartiennent, cela peut être difficile à réaliser avec CSS. Cependant, nous pouvons également utiliser les comportements (behaviors) de CETEIcean pour la mise en forme.

En HTML, la convention est de représenter les différents niveaux d'en-têtes avec les éléments `h1`, `h2`, `h3`, etc. (jusqu'à `h6`). Nous pouvons y parvenir en utilisant un comportement. Pour cela, dans votre fichier `index.html`, ajoutez ce qui suit entre la première et la deuxième ligne du code qui se trouve entre les balises `<script></script>` (c'est-à-dire entre `"let c = new CETEI();"` et `"c.getHTML5('balzac-42-splendeurs-miseres-courtisanes-presse-derniere-incarnation-vautrin.xml'…"`):

```js
  let comportements = {
    "tei": {
      "head": function(e) {
        let niveau = document.evaluate("count(ancestor::tei-div)", e, null, XPathResult.NUMBER_TYPE, null);
        let resultat = document.createElement("h" + niveau.numberValue);
        for (let n of Array.from(e.childNodes)) {
          resultat.appendChild(n.cloneNode());
        }
        return resultat;
      }    
    }
  };
  c.addBehaviors(comportements);
```

Cela créera un objet Javascript et lui attribuera la variable `comportements`, que nous lierons ensuite à l'objet `CETEI` que nous avons créé auparavant, en utilisant la méthode `addBehaviors` (qui est déjà incluse dans CETEIcean). À l'intérieur de cet objet, nous avons une section étiquetée comme “tei” (qui est le préfixe pour tous nos éléments personnalisés), et à l'intérieur de celle-ci, les comportements pour les éléments sont définis. Lorsque CETEIcean trouve une correspondance pour le nom d'un élément, comme “head” (notez que le nom de TEI est utilisé sans le préfixe), il applique les comportements correspondants.

Ce nouveau comportement prend une fonction de JavaScript, ce qui fait que l'élément est traité comme un paramètre (le `e`). Cela crée la variable `niveau`, qui contient le niveau d'en-tête de la `<tei-div>` qui contient le `<tei-head>`, crée un élément `<h[niveau]>` avec le niveau correspondant, et copie le contenu de l'élément original dans le nouvel élément d'en-tête. CETEIcean cachera le contenu de `<tei-head>` et, à la place, affichera le contenu du nouvel élément d'en-tête. Notez que ce code a un problème potentiel : un document avec de nombreuses divisions imbriquées les unes dans les autres pourrait finir par produire un élément d'en-tête supérieur à la limite admise par HTML (par exemple, un élément `<h7>`). Notre document source n'a pas plus de deux niveaux d'imbrication, mais pour l'utiliser dans d'autres sources, il serait prudent de vérifier que l'imbrication ne dépasse pas le niveau de l'élément `<h6>`.

Si à ce stade, nous prévisualisons notre HTML sur VS Code, nous obtiendrons le résultat suivant :

{% include figure.html filename="fr-tr-publier-archives-tei-ceteicean-06.png" alt="capture d'écran de la prévisualisation de notre fichier TEI avec style pour les titres" caption="Figure 6. Prévisualisation de notre fichier TEI avec style pour les titres" %}

Avec cette prévisualisation, nous avons considérablement amélioré la présentation de notre document, mais les notes de l'édition rendent toujours la lecture du texte difficile. Pour résoudre ce problème, nous ajouterons encore un autre comportement à notre script. Cependant, pour atteindre cet objectif, nous devrons utiliser une séquence de commandes un peu plus longue et complexe que la précédente. Copiez et collez le texte suivant entre les lignes `"tei": {` et `"head": function(e) {` qui se trouvent dans le deuxième élément `<script>` de notre document `index.html`:


```js
    "note": function(e){
    if (!this.noteIndex){
      this["noteIndex"] = 1;
    } else {
      this.noteIndex++;
    }    
    /* Le premier bloc vérifie s'il y a des notes dans le texte et les ordonne dans une séquence*/

    let id = "note" + this.noteIndex;
    let lien = document.createElement("a");
    lien.setAttribute("id", "src" + id);
    lien.setAttribute("href", "#" + id);
    lien.innerHTML = this.noteIndex;
    let contenu = document.createElement("sup");
    if (e.previousSibling.localName == "tei-note") {
      contenu.appendChild(document.createTextNode(","));
    }
    /* Le deuxième bloc ajoute un numéro à chaque note*/

    contenu.appendChild(lien);
    let notes = this.dom.querySelector("ol.notes");
    if (!notes) {
      notes = document.createElement("ol");
      notes.setAttribute("class", "notes");
      this.dom.appendChild(notes);
    }
    /* Le troisième bloc crée une section de notes à la fin du document */

    let note = document.createElement("li");
    note.id = id;
    note.innerHTML = "<a href=\"#src" + id + "\">^</a> " + e.innerHTML
    notes.appendChild(note);
    return contenu;
  },
    /* Enfin, le quatrième bloc crée une liste avec les notes et les lie avec les références dans le corps du texte */

```

Aux fins de compléter ce tutoriel, il n'est pas nécessaire de comprendre le fonctionnement de chaque ligne de ce comportement. Cependant, si vous observez le résultat de la prévisualisation, vous remarquerez qu'en l'incluant, les notes apparaissent à la fin du texte, hyperliées avec leurs références respectives :

{% include figure.html filename="fr-tr-publier-archives-tei-ceteicean-07" alt="capture d'écran de la prévisualisation de notre fichier TEI avec style pour les notes" caption="Figure 7. Prévisualisation de notre fichier TEI avec style pour les notes" %}

## Étape 4 : Pour continuer à travailler avec CETEIcean

CETEIcean possède un certain nombre de comportements intégrés que vous pouvez remplacer ou désactiver en leur ajoutant des valeurs. Si, par exemple, vous souhaitez afficher le contenu du TEI Header (qui est caché par défaut), vous pouvez ajouter la ligne suivante à notre `<script>` en dessous de `"tei": {`:

```js
  "teiHeader": null,
```

Si vous faites cela, vous voudrez peut-être ajouter des styles CSS ou des comportements pour choisir la manière dont le contenu du TEI Header sera affiché dans le navigateur.

Dans ce tutoriel, nous n'avons pas épuisé toutes les possibilités pour la présentation de notre document source. Nous vous invitons à continuer à expérimenter par vous-même les différentes manières dont un balisage TEI peut être visualisé dans un navigateur en utilisant CETEICean. Vous pouvez trouver plus d'informations sur [CETEIcean](http://teic.github.io/CETEIcean/).


## Références bibliographiques

Bertrand, Lauranne. « Initiation XML-TEI ». URFIST, BORDEAUX, 12 juillet 2016. http://weburfist.univ-bordeaux.fr/wp-content/uploads/2016/12/20161209_BERTRAND-URFIST-TEI-1.pdf.

de Balzac, Honoré. ‘La Dernière Incarnation De Vautrin, Paru En Feuilleton Dans La Presse Du 13 Avril Au 17 Mai 1847’. NAKALA - Https://Nakala.fr (Huma-Num - CNRS), 2017. https://doi.org/10.34847/NKL.4FB47I30.

Honoré de Balzac. « La Dernière Incarnation de Vautrin ». Critical edition. Avec ANR Phoebus e-Balzac. eBalzac, 2017. https://www.ebalzac.com/edition/42-splendeurs-miseres-courtisanes/presse.

Sperberg-McQueen, Lou Burnard et C. M. « Encoder Pour Échanger : Une Introduction à La TEI Lou Burnard et C.M. Sperberg-McQueen. Traduction Française Sophie David ». Text. Consulté le 24 avril 2025. https://www.tei-c.org/release/doc/tei-p5-exemplars/html/tei_lite_fr.doc.html.

Vaughan, Nicolás. 2021. "Introduction au codage de textes en TEI (partie 1)", *Programming Historian en español* 5 (2021), https://doi.org/10.46430/phes0053 (changer pour la version en français)


## Outils techniques

Atom. Un éditeur de texte hackable pour le 21e siècle. https://atom.io

Cayless, Hugh et Viglianti, Raffaele. CETEIcean. http://teic.github.io/CETEIcean/

Jedit. Éditeur de texte pour programmeurs. Version stable : 5.6.0. http://www.jedit.org/

Oxygen. Éditeur XML. https://www.oxygenxml.com/

Visual Studio Code. https://code.visualstudio.com/
