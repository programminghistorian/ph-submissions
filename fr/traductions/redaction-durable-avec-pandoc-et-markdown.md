---
title: Rédaction durable avec Pandoc et markdown
layout: lesson
slug: redaction-durable-pandoc-markdown
date: 2014-03-19
authors:
- Dennis Tenen
- Grant Wythoff
editors:
- Fred Gibbs
translation_date: 2020-05-31
translator:
- Marie-Christine Boucher
difficulty: 2
activity: sustaining
topics: [website, data-management]
abstract: "Cette leçon vous apprendra les notions de base de Markdown — une syntaxe de balisage facile à lire et écrire — ainsi que Pandoc, un outil en ligne de commande qui permet de convertir du texte brut en différents types de fichiers bien formatés: PDF, .docx, HTML, LaTeX, diaporama, et plus encore."
exclude_from_check:
  - reviewers
  - review-ticket
original: /en/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown
avatar_alt: Homme assis devant une table à dessin
---
{% include toc.html %}





{% include figure.html filename="lexoriter.jpg" caption="" %}

## Objectifs

Cette leçon vous apprendra d'abord les notions de base de Markdown — une syntaxe de balisage facile à lire et écrire — ainsi que [Pandoc](http://johnmacfarlane.net/pandoc/), un outil en ligne de commande qui permet de convertir du texte brut en différents types de fichiers bien formatés: PDF, .docx, HTML, LaTeX, diaporama, et plus encore.[^1] À l'aide de Pandoc comme outil de composition numérique, vous pouvez utiliser la syntaxe Markdown pour ajouter des illustrations ou une bibliographie, et facilement changer de style de citation, par exemple de Chicago à MLA, en utilisant du texte brut.

Cette leçon ne requiert pas de connaissances techniques avancées, mais elle s'adapte à votre niveau d'expérience, puisque nous suggérons souvent des méthodes plus poussées vers la fin d'une section. Celles-ci sont clairement indiquées, et peuvent être revues après avoir expérimenté et acquis un peu d'expérience.

Au lieu de suivre cette leçon de façon mécanique, nous vous recommandons de chercher à comprendre les solutions qui vous sont offertes ici comme une *méthodologie* qui devra probablement être ajustée à votre environnement et votre workflow. L'installation des outils nécessaires représentera probablement le plus grand obstacle à la réalisation de ce tutoriel. Armez-vous de sufisamment de temps et de patience afin de tout installer comme il se doit, ou travaillez avec un ou une collègue qui a une configuration semblable afin de vous aider mutuellement. Consultez les [Ressources utiles](#ressources-utiles) au bas de cette page si vous avez des difficultés.[^2]

## Philosophie

La rédaction, le stockage et la consultation de documents sont des étapes cruciales du processus de travail dans le domaine des humanités. Et pourtant, le travail de nombre d'auteur(e)s repose sur des outils et des formats propriétaires qui n'arrivent parfois même pas à rencontrer les exigences de base de la rédaction scientifique. Vous connaissez sûrement l'exaspération que peut engendrer la fragilité des notes de bas de page, bibliographies, illustrations et ébauches de livres rédigés dans Microsoft Word ou Google Docs. Et pourtant, la plupart des revues scientifiques insistent encore à ce que les contributions soient soumises en format .docx.

Plus qu'une simple frustration personnelle, cette dépendance aux outils et formats propriétaires a des implications négatives à long terme pour la communauté scientifique. Dans un tel environnement, les revues doivent sous-traiter la mise en page, éloignant par le fait même les auteur(e)s du contexte matériel de la publication et ajoutant d'avantage d'obstacles inutiles à la circulation sans entraves du savoir.[^3]

Quand vous utilisez MS Word, Google Docs ou Open Office pour écrire des textes, vous ne voyez pas ce qui se passe en coulisses. Sous une surface de mots, phrases et paragraphes visibles à l'écran se cache une autre couche, de code celle-là, que seule la machine peut comprendre. À cause de cette couche de code dissimulée, vos documents en format .docx et  .pdf dépendent de logiciels propriétaires pour être affichés correctement. Il est donc diffile d'effectuer des recherches dans ces documents, de les imprimer et de les convertir en d'autre formats.

De plus, le temps que vous passez à formater votre document dans MS Word ou Open Office est du temps perdu, puisque celui-ci sera retiré par l'éditeur au moment de la publication. Autant les auteur(e)s que les éditeurs et éditrices gagneraient à s'échanger des fichiers contenant un minimum de formatage, en réservant la mise en page pour l'étape finale du processus de publication.

C'est donc ici qu'excelle Markdown. Markdown est une syntaxe qui permet le marquage sémantique des éléments à l'intérieur même du document, et non dans une couche dissimulée sous la surface. Il s'agit d'identifier les unités porteuses de sens pour les humains, comme les titres, sections, sous-sections, notes de bas de page et illustrations. Ainsi, vos fichiers resteront à tout le moins lisibles pour vous, même si le programme d'édition que vous utilisez ne fonctionne plus ou "cesse ses activités".

Écrire ce cette façon libère l'auteur(e) de son outil. Vous pouvez écrire en Markdown dans n'importe quel éditeur de texte brut, et la syntaxe dispose d'un riche écosystème de logiciels qui peuvent transformer ces textes en de magnifiques documents. C'est pour cette raison que Markdown connaît actuellement une hausse de popularité, non seulement comme outil de rédaction d'articles scientifiques, mais aussi comme norme pour l'édition en général.

[Atom](https://atom.io/) (disponible sur toutes les plateformes) et [Notepad++](http://notepad-plus-plus.org) (Windows seulement) sont parmi les éditeurs de texte brut tout usage les plus populaires.

Il est important de comprendre que Markdown est seulement une norme. Les fichiers Markdown sont enregistrés en texte brut, ce qui contribue d'autant plus à la flexibilité de ce format. Les fichiers en texte brut existent depuis l'apparition des machines à écrire électroniques. La longévité de cette norme fait du texte brut un format intrinsèquement plus durable et plus stable que les formats propriétaires. Alors que des fichiers créés avec Microsoft Word et Apple Pages il y a à peine dix ans peuvent causer des maux de têtes lorsqu'ils sont affichés dans une version plus récente de ces logiciels, il est encore possible aujourd'hui d'afficher sans problème un fichier créé avec un des nombres d'éditeurs de texte brut "disparus" depuis quelques décénnies: AlphaPlus, Perfect Writer,
Text Wizard, Spellbinder, WordStar, ou le préféré d'Isaac Asimov, SCRIPSIT 2.0, créé par la chaîne de magasins d'électronique Radio Shack. Écrire en texte brut permettra à vos fichiers d'être encore lisibles dans 10, 15 ou 20 ans. Cette leçon propose un processus de rédaction qui libère les chercheurs et chercheuses des logiciels de traitement de texte propriétaires et des formats non durables.

Il est maintenant possible d'écrire tout un éventail de documents en un même format - qu'il s'agisse d'articles, de billets de blogue, de wikis, de plans de cours ou de lettres de recommandation - et d'utiliser un seul et même ensemble d'outils et de techniques afin de rechercher, découvrir, sauvegarder et distribuer notre matériel. Vos notes, entrées de blogue, documentation de code et wikis peuvent tous être rédigés en Markdown. Un nombre croissant de plateformes, dont Wordpress, Reddit et GitHub supportent l'écriture en Markdown. Sur le long terme, votre recherche bénificiera d'une organisation du travail uniformisée qui vous permettra d'enregistrer, rechercher, et organiser vos documents plus facilement.

## Principes
Influencés par diverses disciplines, nous avons été guidés par les principes suivants:

1. *Pérennité.* Le texte brut permet d'assurer la transparence et répond aux normes de préservation à long terme. MS Word pourrait dispraître comme l'a déjà fait Word Perfect, mais le texte brut restera toujours facile à lire, cataloguer, explorer et transformer. De plus, le texte brut facilite un versionnage de document simple et puissant, une fonction très utile à la collaboration et à l'organisation des brouillons. Vos fichiers en texte brut seront accessibles sur les téléphones, tablettes et possiblement même sur un ordinateur en manque de puissance dans une bibliothèque isolée. Le texte brut est à compatibilité déscendante et à l'épreuve du temps. Peu importe quels logiciels et matériel informatique le futur nous réserve, ils seront en mesure de comprendre le texte brut.

2. *Priorité à la lisibilité humaine* Ce que vous écrivez dans Word ou Google Docs n'est pas tel-tel. Le document .doc cache des caractères de formatage générés automatiquement créant une couche de formatage obscure qui rendent le dépannage difficile pour les novices. Une tâche pourtant simple, comme coller une image ou du textes copiés d'un navigateur Web peuvent avoir des effets inattendus sur la mise en page du document.

3. *Division entre la forme et le contenu* Formater en écrivant est une source de distraction. L'idée est donc d'écrire d'abord, et de formater plus tard, le plus près possible du moment de la publication. Passer de Chicago à MLA devrait se faire sans heurts. Les éditeurs de revues scientifiques qui ne veulent pas perdre de temps en formatage et révision inutiles devraient pouvoir fournir à leurs auteurs un modèle de formatage qui prendra en charge les détails de la mise en page.

4. *Compatibilité avec la recherche universitaire* Le processus de travail doit être en mesure de manipuler les notes de bas de pages, illustrations, caractères internationaux et ainsi que les bibliographies avec élégance.

5. *Indépendance des plateformes* Avec la multiplication des moyens de publication, nous devons être en mesure de générer une multitude de formats pour entre autres les diaporamas, l'imprimé, le web et les appareils mobiles. Idéalement, nous voulons pouvoir générer les formats les plus communs sans briser les dépendances bibliographiques. Notre processus de travail se doit aussi d'être portable – l'idéal serait de pouvoir copier un seul dossier sur une clé USB en sachant qu'il contient tout les éléments nécessaires à la publication. Par exemple, un plan de cours écrit en Markdown peut être enregistré en PDF, imprimé sur un feuillet, et converti en HTML pour le web, à partir d'un seul et même format. Les documents web et imprimés devraient être publiés à partir du même document source et se ressembler, préservant ainsi la mise en forme logique du matériel.

Markdown et LaTeX rencontrent tous ces critères. Nous avons choisi Markdown (et non LaTeX) puisqu'il offre la syntaxe la plus simple et légère (d'où le nom, mark *down*), et puisqu'il assure, en combinaison avec Pandoc, la plus grande flexibilité au niveau des formats d'exportation (incluant les fichiers .docx et .tex).[^5]

## Exigences en matière de logiciels

Nous omettons délibérément certains détails précis du processus d'installation, qui dépendent des différentes plateformes ou systèmes d'exploitation. Il nous est inutile de fournir des instructions d'installation pour LaTeX, alors que les instructions en ligne standard pour votre système d'exploitation resteront toujours plus actuelles et plus complètes. De même, il est préférable que vous exploriez les mécanismes d'installation de Pandoc en cherchant "installer Pandoc" sur Google, puisque le premier résultat généré sera probablement la page d'accueil de Pandoc.

- **Éditeur de texte brut**. Faire incursion dans le monde des éditeurs de texte brut augmente considérablement la gamme d'outils de création innovants qui vous sont accessibles. Cherchez "éditeur texte markdown" sur le Web et testez différentes options. Peu importe l'éditeur de vous choisirez, assurez-vous seulement qu'il s'agisse d'un éditeur de texte brut, comme Atom ou Notepad++. Souvenez-vous que puisque vous n'êtes plus dépendant à un outil particulier, vous pouvez changer d'éditeur à tout moment.

- **Terminal en ligne de commande**.  Travailler en "ligne de commande" consiste à saisir des commandes dans le terminal. Sur un Mac, vous n'avez qu'à chercher "Terminal" dans le Finder. Sur Windows, utilisez PowerShell. Les utilisateurs Linux sont probablement déjà l'habitude d'utiliser de leur terminal. Nous allons expliquer les fonctions et l'utilisation de base de la ligne de commande plus bas dans le texte.

- **Pandoc**. Des instructions d'installation détaillées spécifiques à chaque plateforme sont disponibles en anglais sur le [site web de Pandoc](https://pandoc.org/installing.html). *L'installation de Pandoc sur votre machine est une étape cruciale à la réalisation de cette leçon*, veuillez-donc vous assurer de prendre le temps de bien lire les instructions. Pandoc a été créé et est maintenu par John MacFarlane, professeur de philosophie à l'Université de Californie à Berkeley. Ce projet d'humanités numériques par excellence servira de moteur à notre processus de travail. Avec Pandoc, vous pourrez transformer des textes et des bibliographies en documents flexibles et magnifiquement formatés. Lorsque vous aurez procédé à l'installation, assurez-vous que Pandoc est bien installé en saisissant `pandoc --version` dans votre terminal. Nous prenons pour acquis que vous disposez au moins de le version 1.12.3, sortie en janvier 2014.

Les deux logiciels suivants sont recommandés, mais ne sont pas requis pour compléter ce tutoriel.

- **Zotero ou Endnote**. Les logiciels de gestion bibliographique sont des outils indispensables à l'organisation et au formatage des citations d'un article scientifique. Ce programmes vous permettent d'exporter vos bibliothèques en fichiers BibTex (vous en apprendrez plus là-dessus plus tard dans cette leçon.) Ce fichier contenant toutes les citations, lui aussi formaté en texte brut, vous pemettra de citer rapidement et facilement en utilisant des `@tags`. Notez qu'il est aussi possible de saisir toutes vos références bibliographiques à la main en vous servant de [notre bibliographie](https://github.com/dhcolumbia/pandoc-workflow/blob/master/pandoctut.bib) comme modèle.

- **LaTeX**. Des instructions d'installation détaillées spécifiques à chaque plateforme sont disponibles sur le [site web de Pandoc](https://pandoc.org/installing.html). Ce tutoriel n'aborde pas le sujet, mais Pandoc se sert de LaTeX pour créer des .pdf. Les utilisateurs avancés convertissent souvent les documents directement en LaTeX pour avoir un contrôle plus précis sur la mise en page du fichier .pdf. Les débutants peuvent choisir de sauter cette étape. Sinon, tapez `latex -v` pour voir si LeTeX est installé correctement (vous obtiendrez une erreur s'il ne l'est pas, et des informations sur la version s'il est bel et bien installé).

## Les rudiments de Markdown

Markdown est une norme qui régit la structure sémantique de documents en texte brut. Cela permet d'identifier les structures logiques de votre document (titres, sections, sous-sections, notes de bas de page, etc.) et de les délimiter avec des caractères peu gênants, pour ensuite "compiler" le résultat avec un traducteur typographique qui formatera le document de manière cohérente, selon un style déterminé.

Il existe différentes "saveurs" de la norme Mardown utilisées dans différents contextes, comme des blogues, des wikis et des dépôt de code. La saveur de Markdown qu'utilise Pandoc est conçue pour un usage universitaire. Ses règles d'utilisation se trouvent sur le page de [Markdown pour Pandoc](http://pandoc.org/README.html#pandocs-markdown). Ses conventions comprennent le [bloc "YAML"](http://johnmacfarlane.net/pandoc/README.html#yaml-metadata-block), qui contient des métadonnées utiles.[^ft-1]

Créons maintenant un simple document Markdown. Ouvrez d'abord l'éditeur de texte brut de votre choix et commencez à écrire. Votre texte devrait ressembler à ceci:

  ---
  title: Processus de rédaction en texte brut
  author: Dennis Tenen, Grant Wythoff
  date: 20 janvier 2014
  fontfamily: times
  ---

  Le Markdown à saveur Pandoc stocke chacune de valeurs ci-dessus et les "imprime" dans l'emplacement approprié de votre document produit lorsque vous arriverez à l'étape de la mise en page. Nous apprendrons plus tard à ajouter des champs plus poussés au bloc YAML. Pour l'instant, supposons que écrivons un article qui contient trois sections, chacune étant divisée en deux sous-sections. Laissez une ligne vide après le trois derniers tirets du bloc YAML et collez-y le texte suivant:

      # Section 1

      ## Sous-section 1.1

      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

      Le paragraphe suivant doit commencer ainsi. N'ajoutez pas d'identations.

      ## Sous-section 1.2

      Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque  ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.

      # Section 2

      ## Sous-section 2.1
      Lancez-vous en insérant d'abord du faux-texte dans votre document. Les espaces sont importantes en Markdown, il ne faut donc pas mettre d'alinéa au début des paragraphes. Divisez-les plutôt en laissant une ligne vide. Les en-têtes de sections doivent aussi être précédées d'une ligne vide.

      Vous pouvez vous servir des astérisques pour mettre vos mots en gras ou en italique, comme suit: `*italique*` et `**gras**`. Ajoutons aussi un lien et une note de bas de page, pour faire le tour des éléments de base d'un article moyen. Écrivez:

        Une phrase qui requiert une note.[^1]

        [^1]: Ma première note de bas de page! Ajoutez un [lien](https://www.eff.org/).

Si le texte lié et l'adresse sont équivalents, il est plus rapide d'écrire  `<www.eff.org>` au lieu de `[www.eff.org](www.eff.org)`.

Enregistrons maintenant notre document avant d'aller plus loin. Créez un nouveau dossier qui contiendra votre projet. Vous avez sûrement un système d'organisation pour vos documents, projets, illustrations et bibliographies. Mais souvent, vos documents, illustrations et bibliographies se trouvent dans différents dossiers, ce qui les rend difficiles à repérer. Notre objectif est de créer un seul dossier pour chaque projet, qui contiendra tout le matériel pertinent. La règle générale est d'un projet, un article, un dossier. Nommez votre fichier quelque chose comme 'projet.md', où 'md' signifie markdown.

Une fois le fichier enregistré, ajoutons-y une illustration. Copiez n'importe quelle image de petite taille dans votre dossier, et ajoutez ceci au corps du texte: `![légende de l'image](votre_image.jpg)`.

À ce stade, le fichier 'main.md' devrait ressembler au texte suivant. Vous pouvez télécharger ce fichier modèle [ici](https://raw.githubusercontent.com/programminghistorian/jekyll/gh-pages/assets/sample.md).

    ---
    title: Processus de rédaction en texte brut
    author: Dennis Tenen, Grant Wythoff
    date: 20 janvier 2014
    ---

    # Section 1

    ## Sous-section 1.1

    Lorem *ipsum* dolor sit amet, **consectetur** adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

    Le paragraphe suivant doit commencer ainsi. N'ajoutez pas d'identations.

    ## Sous-section 1.2

    Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque  ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.

    # Section 2

    ## Sous-section 2.1

    ![légende de l'image](votre_image.jpg)

    ## Sous-section 2.2

    Une phrase qui requiert une note.[^1]

    [^1]: ma première note de bas de page! Ajoutez un [lien](https://www.eff.org/).

Comme nous le verrons bientôt, ce fichier en texte brut peut être rendu sous la forme d'un très chic PDF:

{% include figure.html filename="Screen-Shot-2014-11-06.png" caption="Capture d'écran d'un PDF rendu par Pandoc" %}

Si vous voulez avoir une idée de la façon dont ce type de balisage sera interprété en format HTML, utilisez cette [*sandbox* en ligne](http://daringfireball.net/projects/markdown/dingus) pour tester différents types de syntaxe. Souvenez-vous que certains éléments de Markdown à saveur *Pandoc* (comme le bloc de titre et les notes de bas de page) ne fonctionneront pas dans ce formulaire web qui n'accepte que le formatage de base.

Prenez maintenant un peu de temps pour explorer d'autres fonctions de Markdown, comme les citations (désignées par ce symbole: `>`), les listes à puces, qui débutent par `*` ou `-`, les blocs de citations qui débutent par `|` (très utile pour la poésie), les tableaux ainsi que quelques autres fonctions mentionnées sur la page Markdown du site web de Pandoc.

Portez une attention particulière aux espaces vides et au découpage des paragraphes. La documentation définit un paragraphe de manière succincte comme étant "une ou plusieurs lignes de texte suivies d'une ou plusieurs lignes vides". Notez que "les retours de chariots sont traités comme des espaces" et que "si vous avez besoin d'un saut de ligne, mettez deux espaces ou plus à la fin d'une ligne". La meilleure façon de comprendre ce que cela signifie est d'expérimenter sur le tas. Utilisez le mode de prévisualisation de votre éditeur ou lancez simplement Pandoc pour voir les résultats de vos expériences.

Avant tout, résistez à la tentation de formater le texte. Souvenez-vous que vous identifiez des unités *sémantiques*: sections, sous-sections, emphase, notes de bas de page et illustrations. En Markdown, même les `*italiques*` et les `**caractères gras**` ne sont pas vraiment des marques de formatage; ils indiquent plutôt différents niveaux d'emphase. La mise en page viendra plus tard, lorsque vous connaîtrez le lieu et les conditions de publication.

Certains programmes vous permettent de voir un aperçu en direct du formatage de votre fichier Markdown pendant que vous écrivez. Vous en trouverez des exemples dans la section Ressources utiles à la fin de cette leçon. Cependant, peu d'entre elles supportent les notes de bas de page, les illustrations et les bibliographies. Pour profiter pleinement de Pandoc, nous vous recommandons de conserver de simples fichiers en texte brut, stockés localement, sur votre ordinateur.

## Entrez en contact avec votre terminal intérieur

Avant de publier notre fichier `main.md` en d'autres formats, nous devons nous familiariser avec la ligne de commande en utilisant le terminal de notre ordinateur, la seule (et meilleure) façon d'utiliser Pandoc.

La ligne de commmande est un environnement agréable, une fois qu'on s'y est habitué. Si vous êtes déjà familiarisé avec l'utilisation de la ligne de commande, n'hésitez pas à sauter cette section. Pour les autres, il est important de comprendre que le fait de pouvoir utiliser directement le programme de votre terminal vous permettra de recourir à un large éventail d'outils de recherche puissants que vous ne pourriez pas utiliser autrement, et qui peuvent servir de base à des tâches plus avancées. Pour les besoins de ce tutoriel, vous n'avez besoin d'apprendre que quelques commandes très simples.

Commencez par ouvrir une fenêtre de ligne de commande. Si vous utilisez macOS, ouvrez l'application Terminal dans le répertoire "Applications/Utilitaires". Sous Windows, nous vous recommandons d'utiliser PowerShell ou, pour une solution plus robuste, d'installer le sous-système Windows pour Linux et d'utiliser le terminal fourni avec votre distribution Linux préférée.  Pour une excellente introduction à la ligne de commande, vous pouvez consulter cette leçon (en anglais) de Ian Milligan et James Baker: "[Introduction to the Bash Command Line](/en/lessons/intro-to-bash)"

Dans le terminal, vous devriez voir une fenêtre de texte et une invite qui ressemble à ceci: `nom-de-l'ordinateur:~nomd'utilisateur$`. Le tilde indique votre répertoire de base, et vous pouvez en effet taper `$ cd ~` à n'importe quel moment pour revenir à celui-ci. Ne saisissez pas le symbole `$`, il représente simplement l'invite de commande de votre terminal, qui vous invite à taper quelque chose dans votre terminal (au lieu de le saisir dans un document); n'oubliez pas d'appuyer sur la touche d'entrée après chaque commande.

Il est très probable que votre dossier "Documents" se trouve ici. Tapez `$ pwd` (= imprimer le répertoire de travail) et appuyez sur la touche d'entrée pour afficher le nom du répertoire actuel. Utilisez `$ pwd` chaque fois que vous vous avez l'impression de perdre le nord.

La commande `$ ls` (= list) liste simplement les fichiers qui se trouvent dans le répertoire courant. Enfin, vous pouvez utiliser `$ cd>` (= changer de répertoire) comme suit: `$ cd NOM_DU_RÉPERTOIRE` (où `NOM_DU_RÉPERTOIRE` est le nom du répertoire que vous aimeriez consulter). Vous pouvez utiliser `$ cd ..` pour de remonter automatiquement d'un niveau dans la structure des répertoires (le parent du répertoire dans lequel vous êtes actuellement). Une fois que vous avez commencé à taper le nom du répertoire, utilisez la touche de tabulation pour remplir automatiquement le texte, une fonction particulièrement utile pour les noms de répertoires particulièrement longs, ou pour ceux qui contiennent des espaces[^6].

Ces trois commandes de terminal, `pwd`, `ls` et `cd`, sont tout ce dont vous avez besoin pour cette leçon. Pratiquez-les pendant quelques minutes pour apprendre vous déplacer dans votre fichier et réfléchissez à la façon dont vous avez organisé vos dossiers. Si vous le souhaitez, gardez la structure de votre programme de gestion de fichiers habituel afin de ne pas perdre vos repères.

## Utilisation de Pandoc pour convertir le Markdown en document MS Word

Nous voilà maintenant prêts à faire la mise en page ! Ouvrez la fenêtre de votre terminal, utilisez `$ pwd` et `$ cd NOM-DU-RÉPERTOIRE` pour naviguer vers le dossier qui contient votre projet. Une fois que vous y êtes, tapez `$ ls` dans le terminal pour lister les fichiers. Si vous voyez votre fichier .md et vos images, vous êtes au bon endroit. Pour convertir le fichier .md en .docx, tapez

```
$ pandoc projet.md -o projet.docx
```

Ouvrez le fichier avec MS Word pour vérifier vos résultats. Vous pouvez également utiliser Open- ou LibreOffice :

```
$ pandoc projet.md -o projet.odt
```
Si vous êtes débutant en matière de ligne de commande, imaginez que vous interprétez la commande ci-dessus de cette façon: "Pandoc, créez un fichier MS Word à partir de mon fichier Markdown." Le `-o`, dans ce cas-ci, signale quelque chose comme: "Au lieu que j'aie à vous nommer explicitement le format des fichiers source et cible, devinez-les à l'aide de l'extension des fichiers" ou, tout simplement, "output" (sortie). De nombreuses options sont disponibles grâce à ces drapeaux dans Pandoc. Vous pouvez en voir la liste complète sur le [site web de Pandoc](http://johnmacfarlane.net/pandoc/README.html) ou en tapant `$ man pandoc` dans le terminal.

Tentez maintenant d'exécuter la commande suivante:

```
$ pandoc projet.md -o projet.html
```
Retournez ensuite au répertoire de votre projet. Pouvez-vous expliquer ce qui s'est passé ?

Les utilisateurs plus avancés qui ont installé LaTeX voudront peut-être expérimenter en convertissant leur Markdown en fichiers .tex ou en fichiers .pdf spécialement mis en page. Une fois LaTeX installé, un fichier PDF magnifiquement formaté peut être créé en utilisant la même structure de commande :

```
$ pandoc projet.md -o projet.pdf
```
Si votre document est rédigé dans une autre langue que l'anglais, vous devrez probablement utiliser le moteur XeLaTeX au lieu du moteur LaTeX ordinaire pour la conversion en .pdf :

```
pandoc projet.md --pdf-engine=xelatex -o projet.pdf
```
Assurez-vous que votre éditeur de texte prend en charge le codage UTF-8. Lorsque vous utilisez XeLaTeX pour la conversion en .pdf, au lieu de l'attribut `fontfamily` en YAML pour changer de police, spécifiez l'attribut `mainfont`, ce qui donnera quelque chose comme suit :

```
    ---
    title: Processus de rédaction en texte brut
    author: Dennis Tenen, Grant Wythoff
    date: 20 janvier 2014
    mainfont: times
    ---
```

[^ft-1]: Notez que le bloc YAML reproduit souvent une partie, mais pas la totalité, de l'argument ou des options en ligne de commande. Par exemple, les styles de police peuvent être transmis à Pandoc de la manière suivante: `pandoc main.md --mainfont=times -o target.pdf`. Cependant, nous préférons utiliser les options d'en-tête YAML dans la mesure du possible, puisque cela donne des incantations en ligne de commande plus faciles à taper et à se rappeler. L'utilisation d'un outil de contrôle de versions tel que Git préservera vos modifications YAML, alors que ce que vous tapez dans le terminal est plutôt éphémère. Consultez la section "Templates" du manuel Pandoc (`man pandoc`) pour la liste des variables YAML disponibles.

## Gestion des bibliographies

Dans la section qui suit, nous ajouterons une bibliographie à notre document, puis nous convertirons celle-ci du format Chicago au format MLA.

Si vous n'utilisez pas encore de gestionnaire de référence comme Endnote ou Zotero, vous devriez vous y mettre. Nous préférons Zotero, car, comme Pandoc, il a été créé par la communauté universitaire et, comme d'autres projets en source libre, il est publié sous la licence publique générale GNU. Le critère plus important, à notre avis, est la capacité de votre gestionnaire de référence de générer des bibliographies en format texte brut, pour rester fidèle à notre principe "tout en texte brut". Allez-y, ouvrez un gestionnaire de référence de votre choix et ajoutez quelques exemples d'entrées. Lorsque vous êtes prêt, trouvez l'option d'exportation de la bibliographie au format BibTeX (.bib). Enregistrez votre fichier .bib dans votre répertoire de projet, et donnez-lui un titre sensé comme "projet.bib".

Il est préférable de conserver vos sources organisées dans une base de données bibliographiques centralisée, tout en générant des fichiers .bib spécifiques et beaucoup plus petits qui se trouveront dans le même répertoire que votre projet. Ouvrez votre fichier .bib avec l'éditeur de texte de votre choix[^4].

Votre fichier .bib devrait contenir plusieurs entrées qui ressemblent à ceci :

    @article{fyfe_digital_2011,
        title = {Digital Pedagogy Unplugged},
        volume = {5},
        url = {http://digitalhumanities.org/dhq/vol/5/3/000106/000106.html},
        number = {3},
        urldate = {2013-09-28},
        author = {Fyfe, Paul},
        year = {2011},
        file = {fyfe_digital_pedagogy_unplugged_2011.pdf}
    }

Vous devrez rarement les modifier à la main (bien que vous puissiez le faire). Dans la plupart des cas, vous "exporterez" simplement le fichier .bib à partir de Zotero ou d'un gestionnaire de référence similaire. Prenez un moment pour vous orienter ici. Chaque entrée consiste en un type de document, "article" dans notre cas, un indentifiant unique (fyfe\_digital\_2011), et les métadonnées pertinentes sur le titre, volume, auteur, etc. Ce qui nous importe le plus, c'est l'identification unique qui suit immédiatement l'accolade sur la première ligne de chaque entrée. L'identifiant unique est ce qui nous permet de relier la bibliographie au document principal. Laissez ce dossier ouvert pour l'instant et retournez à votre fichier `projet.md`.

Modifiez la note de bas de page de la première ligne de votre fichier `projet.md` pour qu'elle ressemble aux exemples suivants, où `@nom_titre_date` peut être remplacé par l'un des les identifiants uniques de votre fichier `projet.bib`:
- `Une référence formatée de cette manière sera affichée correctement sous forme de citation dans le corps du texte ou de note de bas de page [@name_title_date, 67].`[^7]
- `"Pour les citations entre guillemets, mettez la virgule en dehors des guillemets" [@name_title_2011, 67].`

Une fois que nous aurons passé le fichier Markdown dans Pandoc, "@fyfe\_digital\_2011" deviendra une citation complète dans le style de votre choix. Vous pouvez utiliser la syntaxe `@citation` comme bon vous semble : dans le corps du texte ou en notes de bas de page. Pour générer une bibliographie, il suffit d'inclure une section appelée `# Bibliographie`  à la fin du document.

Retournez maintenant à l'en-tête de vos métadonnées en haut de votre document .md, et préciser le fichier bibliographique à utiliser, comme ceci:

```
---
title: Processus de rédaction en texte brut
author: Dennis Tenen, Grant Wythoff
date: 20 janvier 2014
bibliography: projet.bib
---
```

Cela indique à Pandoc de chercher votre bibliographie dans le fichier `projet.bib`, situé dans le même répertoire que votre fichier `projet.md`. Voyons si cela fonctionne. Sauvegardez votre fichier, passez à la fenêtre du terminal et exécutez cette commande :

```
$ pandoc projet.docx --filtre pandoc-citeproc -o projet.md
```

Le filtre "pandoc-citeproc" analysera toutes les balises de citation trouvées dans votre document. Le résultat doit être un fichier MS Word correctement formaté. Si vous avez installé LaTeX, convertissez le fichier en un .pdf en utilisant la même syntaxe pour des résultats plus jolis. Ne vous inquiétez pas si les choses ne sont pas encore tout à fait à votre goût - souvenez-vous que vous allez affiner le formatage d'un seul coup, plus tard dans le processus, au plus près possible du moment de la publication. Pour l'instant, nous ne faisons que créer des projets basés sur des valeurs par défauts convenables.

## Changer de style de citation

Le style de citation par défaut de Pandoc est Chicago Auteur-Date. On peut spécifier un style différent en utilisant une feuille de style écrite en "Citation Style Language" (voilà une autre convention de texte simple, qui dans ce cas décrit les styles de citation) et désignée par l'extension de fichier .csl. Heureusement, le projet CSL maintient un dépôt de styles de citation communs, certains étant même adaptés à des revues spécifiques. Visitez le site <http://editor.citationstyles.org/about/> pour trouver le fichier .csl de Modern Language Association, téléchargez `modern-language-association.csl`, et sauvegardez-le dans le répertoire de votre projet sous le nom `mla.csl`. Maintenant, nous devons signaler à Pandoc d'utiliser la feuille de style MLA au lieu du style par défaut, Chicago. Nous faisons ceci en mettant à jour l'en-tête YAML :

```
---
title: Processus de rédaction en texte brut
author: Dennis Tenen, Grant Wythoff
date: 20 janvier 2014
bibliography: projet.bib
csl: mla.csl
---
```

Répétez ensuite l'incantation Pandoc pour lancer votre fichier Mardown dans le format cible désiré (.pdf ou .docx) :

```
$ pandoc projet.md --filter pandoc-citeproc -o projet.pdf
```

Analysez la commande en anglais au fur et à mesure que vous la tapez. Dans ma tête, je traduis ce qui précède par quelque chose comme "Pandoc, prends mon fichier Markdown, passe-le dans un filtre de citation, et génère un fichier PDF." Lorsque vous vous familiariserez avec les feuilles de style de citation, pensez à ajouter à l'archive du projet CSL vos fichiers .csl personnalisés pour les revues de votre domaine, afin de rendre service à la communauté.

## Résumé

Vous devriez maintenant être en mesure de rédiger des articles en Markdown, de créer des brouillons en plusieurs formats, d'ajouter des bibliographies et de changer facilement de style de citation. Un dernier coup d'oeil au répertoire du projet révèle un certain nombre de "documents d'origine" : votre fichier `projet.md`, votre fichier `projet.bib`, votre fichier `mla.csl` et quelques images. Outre les documents d'origine, vous devriez voir quelques document "cibles" que nous avons créés au cours du tutoriel : `projet.docx` ou `projet.pdf`. Le contenu de votre dossier devrait ressembler à quelque chose comme ceci :

```
    tutoriel-pandoc/
        projet.md
        projet.bib
        mla.csl
        image.jpg
        projet.docx
```

Traitez vos fichiers sources comme une version faisant autorité de votre texte, et vos fichiers cibles comme des "impressions" jetables que vous pouvez facilement générer à la volée avec Pandoc. Toutes les révisions doivent aller dans le fichier `projet.md`. Le fichier `projet.docx` sert au nettoyage final et au formatage. Par exemple, si le journal nécessite des manuscrits à double interligne, vous pouvez rapidement les mettre en double interligne dans Open Office ou Microsoft Word. Mais ne passez pas trop de temps à formater. N'oubliez pas que tout est effacé lorsque votre manuscrit est imprimé. Vous profiterez du temps gagné en évitant la mise en forme inutile pour peaufiner la prose de votre projet.

## Ressources utiles

### En anglais:
En cas de problème, il n'y a pas de meilleur endroit pour commencer votre recherche que le site web du créateur de Pandoc, [John MacFarlane](http://johnmacfarlane.net/pandoc/) et sa [liste d'envoi affiliée](https://groups.google.com/forum/#!forum/pandoc-discussion). Au moins deux sites de type "Questions-réponses" peuvent répertorier des questions sur Pandoc :
[Stack Overflow](http://stackoverflow.com/questions/tagged/pandoc) et [Digital Humanities Q&A] (http://web.archive.org/web/20190203062832/http://digitalhumanities.org/answers/). Les questions peuvent également être posées en direct, sur la chaîne Pandoc de Freenode IRC, qui est fréquentée par un groupe d'habitués plutôt sympathiques. Au fur et à mesure que vous en apprendrez davantage sur Pandoc, vous pouvez également explorer l'une de ses fonctionnalités les plus puissantes : les [filtres](https://github.com/jgm/pandoc/wiki/Pandoc-Filters).

Bien que nous suggérions de commencer avec un simple éditeur de texte, nombre d'alternatives MS Word (plus de 70, d'après [cette entrée de blogue](http://web.archive.org/web/20140120195538/http://mashable.com/2013/06/24/markdown-tools/)) spécifiques à Markdown, sont disponibles en ligne, et souvent sans frais. Parmi les projets autonomes, nous apprécions particulièrement
[Mou](http://mouapp.com/), [Write Monkey](http://writemonkey.com), et [Sublime Text](http://www.sublimetext.com/). Plusieurs plateformes sur le Web ont récemment vu le jour et fournissent des interfaces graphiques élégantes pour l'écriture collaborative et le suivi des versions à l'aide de Markdown. Il s'agit entre autres de [prose.io](http://prose.io), [Authorea](http://www.authorea.com), [Penflip](http://www.penflip.com), [Draft](http://www.draftin.com), et [StackEdit](https://stackedit.io).

Cependant, l'écosystème ne se limite pas aux éditeurs de texte. [Gitit](https://github.com/jgm/gitit)
et [Ikiwiki](https://github.com/dubiousjim/pandoc-iki) supportent la rédaction en Markdown avec Pandoc comme analyseur de syntaxe. À cette liste, nous pouvons ajouter une gamme
d'outils qui génèrent des pages web rapides et statiques, [Yst](https://github.com/jgm/yst),
[Jekyll](http://github.com/fauno/jekyll-pandoc-multiple-formats), [Hakyll](http://jaspervdj.be/hakyll/), et [bash shell script](https://github.com/wcaleb/website), un projet de l'historien Caleb McDaniel.

Enfin, des plates-formes d'édition entières se développent autour de l'utilisation de Markdown. Un marché de l'édition en Markdown, comme le fait déjà [Leanpub](https://leanpub.com), pourrait être une alternative intéressante au modèle d'édition traditionnel. Nous-mêmes expérimentons avec la conception de revues universitaires basées sur GitHub et [readthedocs.org](http://readthedocs.org) (ces outils sont habituellement utilisés pour la documentation technique).

### En français (N.D.L.R.: il s’agit de notes ajoutées à la version traduite):

Ce guide créé par l'École polytechnique fédérale de Lausanne, [Élaboration et conversion de documents avec Markdown et Pandoc](https://enacit.epfl.ch/cours/markdown-pandoc/), peut servir de référence pour comprendre les subtilités de la syntaxe Markdown et des extensions Pandoc.

## Notes

[^1] :  Ne vous inquiétez pas si vous ne comprenez pas encore toute cette terminologie !

[^2] :  Les documents d'origine peuvent être [téléchargés à partir de GitHub](https://github.com/dhcolumbia/pandoc-workflow). Utilisez l'option "raw" lors de la visualisation dans GitHub pour voir la source en Markdown. Les auteurs tiennent à remercier Alex Gil et ses collègues du Digital Humanities Center de Columbia, ainsi que les participants du studio openLab de la Bibliothèque Butler, qui ont testé le code de ce tutoriel sur diverses plateformes.

[^3] :  Voir l'excellente réflexion de Charlie Stross sur ce sujet: [Why Microsoft Word Must Die](http://www.antipope.org/charlie/blog-static/2013/10/why-microsoft-word-must-die.html).

[^4] :  Notez que l'extension .bib peut être "rattachée" automatiquement à Zotero par votre système d'exploitation. Cela signifie que lorsque vous cliquez sur un fichier .bib, il est probable que Zotero sera appelé pour l'ouvrir, alors que nous voulons l'ouvrir dans un éditeur de texte. Il pourrait être judicieux d'associer le format .bib à votre éditeur de texte.

[^5] :  Il n'y a pas de bonnes solutions pour passer directement de LaTeX à MS Word.

[^6] :  C'est une bonne idée de prendre l'habitude de ne pas utiliser d'espaces dans les noms de dossiers ou de fichiers. Des tirets ou des traits de soulignement au lieu d'espaces dans vos noms de fichiers assurent une compatibilité durable entre les plateformes.

[^7] :  Merci à [@njbart](https://github.com/njbart) pour la correction. En réponse à notre
suggestion originale, `Une phrase qui requiert une citation.^[C'est aussi ce qu'affirme @fyfe_digital_2011.]`, [il écrit](https://github.com/programminghistorian/jekyll/issues/46#issuecomment-59219906) :
"Ce format n'est pas recommandé car cela vous empêche de passer facilement d'un style avec notes de bas de page à un style auteur-date. Il est préférable d'utiliser la \[version modifiée\] (pas de circonflexe, pas de point final à l'intérieur des crochets, et ponctuation finale de la phrase après les crochets ; pour les styles avec notes de bas de page, Pandoc ajuste automatiquement la position de la ponctuation finale)".
