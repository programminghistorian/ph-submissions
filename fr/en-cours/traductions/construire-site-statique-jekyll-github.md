---
title: Construire un site web statique avec Jekyll et Github Pages
collection: lessons
layout: lesson
slug: construire-site-statique-jekyll-github
date: YYYY-MM-DD
translation_date: YYYY-MM-DD
authors:
- Amanda Visconti
reviewers:
- Paige Morgan
- Jamie Howe
editors:
- Fred Gibbs
translator:
- Victoria Le Fourner
translation-editor:
- Prénom Nom
translation-reviewer:
- Prénom Nom
original: building-static-sites-with-jekyll-github-pages
review-ticket: 
difficulty: 1 
activity: presenting
topics: [website, data-management]
abstract: "Cette leçon vous aidera à créer un site Web entièrement gratuit, facile à entretenir, facile à préserver et sûr, sur lequel vous avez un contrôle total, comme un blogue savant, un site Web de projet ou un portfolio en ligne."  
avatar_alt: An illustration of Dr. Jekyll transforming into Mr. Hyde
---


**Cette leçon s'adresse à vous si** vous désirez un site Web entièrement gratuit, facile à entretenir, facile à préserver et sécurisé sur lequel vous avez un contrôle total, comme un blogue savant, un site Web de projet ou un portfolio en ligne.

**À la fin de cette leçon**, vous aurez un site Web de base où vous pourrez publier du contenu que d'autres personnes pourront visiter et vous aurez aussi des ressources à explorer si vous voulez personnaliser davantage le site.

**Exigences**&nbsp;: Un ordinateur (Mac/Windows/Linux sont tous corrects, mais cette leçon ne couvre pas certains aspects de l'utilisation de Linux), la possibilité de télécharger et d'installer des logiciels sur l'ordinateur, une connexion Internet qui peut supporter le téléchargement de logiciels. Les utilisateurs ont déclaré avoir besoin de 1 à 3 heures pour compléter toute la leçon.

**Niveau de difficulté**&nbsp;: Intermédiaire (cette leçon comprend l'utilisation de la ligne de commande et de git, mais vous guide à travers tout ce qui est nécessaire pour compléter cette leçon). Les prochaines leçons sur les bases des pages git/GitHub et GitHub seront reliées ici lorsqu'elles seront disponibles, et fourniront une bonne base pour tous ceux qui souhaitent approfondir leur compréhension de la technologie utilisée dans cette leçon.


{% comment %} **A jour&#x202F;?**&nbsp;: Cette leçon a été mise à jour pour la dernière fois le 2 mai 2017 pour corriger les problèmes causés par Jekyll version 3.2. {% endcomment %}
{% comment %} J'ai (Sofia) mis la phrase ci-dessus en commentaire car elle ne correspond pas au fichier de la leçon originale - à vérifier. Par ailleurs, la syntaxe markdown est à vérifier aussi, pour enlever par ex. les hash à la fin des sous-titres {% endcomment %}  

{% include toc.html %}


## Que sont les sites statiques, Jekyll, etc. et pourquoi ça m'intéresse&#x202F;? <a id="section0"></a>

_Ce tutoriel est construit sur la [documentation officielle Jekyll](https://jekyllrb.com/docs/) écrite par la communauté Jekyll. Consultez la section "[En savoir plus](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section9-3)" ci-dessous si vous souhaitez en savoir plus sur ces termes&#x202F;!_

### Sites Web dynamiques, sites Web statiques, & Jekyll <a id="section0-1"></a>

*Les sites Web dynamiques*, tels que ceux créés et gérés par un système de gestion de contenu tel que Drupal, WordPress et Omeka, tirent des informations d'une base de données pour remplir le contenu d'une page Web. Lorsque vous recherchez un livre sur Amazon.com, par exemple, la page de résultats de recherche que vous voyez n'existait pas déjà en tant que page HTML complète&#x202F;; au lieu de cela, Amazon.com a un modèle pour la page de résultats de recherche qui inclut des choses que toutes les pages de résultats partagent (comme le menu principal et le logo Amazon), mais il interroge la base de données pour insérer les résultats de cette recherche dans ce modèle.

*Les sites Web statiques*, d'autre part, n'utilisent pas de base de données pour stocker des informations&#x202F;; au lieu de cela, toutes les informations à afficher sur chaque page Web sont déjà contenues dans un fichier HTML pour cette page Web. Les pages HTML qui composent un site statique peuvent être entièrement écrites à la main, ou vous pouvez décharger une partie de ce travail en utilisant quelque chose comme Jekyll.

*Jekyll* est un logiciel qui vous aide à "générer" ou créer un site web statique (vous pouvez voir Jekyll décrit comme un "générateur de site statique"). Jekyll prend les modèles de page - ces choses comme les menus principaux et les pieds de page que vous aimeriez partager sur toutes les pages Web de votre site, où écrire manuellement le HTML pour les inclure sur chaque page Web prendrait du temps. Ces modèles sont combinés avec d'autres fichiers contenant des informations spécifiques (par exemple, un fichier pour chaque billet de blog sur le site) pour générer des pages HTML complètes que les visiteurs du site peuvent voir. Jekyll n'a pas besoin de faire quoi que ce soit comme interroger une base de données et créer une nouvelle page HTML (ou remplir une page HTML partielle) lorsque vous visitez une page Web&#x202F;; les pages HTML sont déjà entièrement formées et elles sont simplement mises à jour lorsque/si elles changent jamais.

Notez que lorsque quelqu'un fait référence à un "site Web Jekyll", il s'agit en fait d'un site Web statique (HTML simple) qui a été créé avec Jekyll. Jekyll est un logiciel qui crée des sites Web. Jekyll n'est pas vraiment en train d'" exécuter " le site web en direct&#x202F;; Jekyll est plutôt un " générateur de site statique "&nbsp;: il vous aide à créer les fichiers statiques du site, que vous hébergez ensuite tout comme vous le feriez pour tout autre site HTML.

Parce que les sites statiques ne sont en fait que des fichiers texte (pas de base de données pour compliquer les choses), vous pouvez facilement *versionner* un site statique, c'est-à-dire utiliser un outil pour suivre les différentes versions du site dans le temps en suivant comment les fichiers texte qui composent le site ont été modifiés. Le versionnage est particulièrement utile lorsque vous avez besoin de fusionner deux fichiers (par exemple, deux étudiants écrivent un billet de blog ensemble, et que vous voulez combiner leurs deux versions), ou lorsque vous voulez comparer des fichiers pour rechercher des différences entre eux (par exemple, "Comment la page originale A propos de décrire ce projet ?"). Le versionnage est très utile lorsque vous travaillez en équipe (par exemple, il vous aide à combiner et à suivre le travail de différentes personnes), mais il est également utile lorsque vous écrivez ou gérez vous-même un site Web.

Lisez plus sur Jekyll [ici](http://jekyllrb.com/docs/home/), ou sur générateur de site statique [ici](https://davidwalsh.name/introduction-static-site-generators). 

### Pages GitHub & GitHub <a id="section0-2"></a>

*[GitHub Pages](https://pages.github.com/)* est un endroit gratuit pour stocker les fichiers qui gèrent un site Web et héberger ce site Web pour que les gens puissent le visiter (il ne fonctionne que pour des types particuliers de sites Web, comme les sites HTML de base ou les sites Jekyll, et ne contient pas de bases de données).

*[GitHub](https://github.com/)* est un moyen visuel d'utiliser *[git](https://git-scm.com/doc)*, un système de *versioning* : suivre les modifications apportées aux fichiers informatiques (y compris les codes et les documents texte) dans le temps (comme expliqué [ci-dessus](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section0-1)). Si vous êtes curieux, voici [une leçon amicale pour explorer GitHub](https://guides.github.com/activities/hello-world/).

### Quelles sont les raisons d'utiliser un site web statique&#x202F;? <a id="section0-3"></a>

Des options comme [Drupal](https://www.drupal.com/), [WordPress](https://wordpress.org/) et [Omeka](https://omeka.org/) répondent aux besoins de sites Web complexes et interactifs comme Amazon ou une édition numérique interactive d'un roman, mais pour de nombreux blogs, sites Web de projets et portfolios en ligne, un site Web statique (comme un site Web créé avec Jekyll) peut répondre à tous vos besoins tout en offrant quelques beaux avantages&nbsp;:



- **Maintenance**&nbsp;: Les mises à jour et la maintenance sont beaucoup moins fréquentes (moins d'une fois par an par rapport à une fois par mois).

- **Préservation**&nbsp;: L'absence de base de données signifie que les fichiers texte composant votre site sont tout ce dont vous avez besoin de sauvegarder pour préserver et répliquer votre site. Il est facile de sauvegarder votre site ou de le soumettre à un dépôt institutionnel.

- **Apprendre**&nbsp;: Parce qu'il n'y a pas de base de données et qu'il n'y a pas un tas de fichiers de code fournissant des fonctionnalités dont vous n'avez peut-être même pas besoin, il y a beaucoup moins d'éléments réels de votre site Web il est plus facile de les parcourir tous et de savoir ce que chacun fait réellement, si vous en avez envie. Il est donc beaucoup plus facile de devenir un utilisateur Jekyll basique et avancé.

- **Plus de personnalisation possible**&nbsp;: Comme il est plus facile d'apprendre à maîtriser votre site Web, il est beaucoup plus facile d'apprendre à le maîtriser que de modifier l'apparence d'un site créé par Jekyll, comme changer l'apparence (le "thème") d'un site créé par WordPress ou Drupal.

- **Hébergement gratuit**&nbsp;: Alors que de nombreux outils de site Web comme Drupal, WordPress et Omeka sont gratuits, les héberger (payer quelqu'un pour servir les fichiers de votre site Web aux visiteurs) peut coûter cher.

- **Versioning**&nbsp;: L'hébergement sur GitHub Pages signifie que votre site est lié à l'interface visuelle de GitHub pour le versionnage de git, de sorte que vous pouvez suivre les changements sur votre site et toujours revenir à un état antérieur de tout billet de blog, page, ou le site lui-même si nécessaire. Cela inclut les fichiers téléchargés que vous voudrez peut-être stocker sur le site, comme les anciens syllabes et les publications. (Le versionnage est expliqué plus en détail ci-dessus.)

- **Sécurité**&nbsp;: Il n'y a pas de base de données à protéger contre les pirates informatiques.

- **Rapidité**&nbsp;: Un minimum de fichiers sur le site Web et aucune base de données à interroger signifient un temps de chargement des pages plus rapide.

La création d'un site Web statique à l'aide de Jekyll offre plus d'avantages en plus de tous les avantages d'un site Web statique HTML codé à la main :

- **Apprendre**&nbsp;: Il est plus facile de commencer à personnaliser votre site et à écrire son contenu, puisque vous n'aurez pas besoin d'apprendre ou d'utiliser HTML.

- **Conçu pour les blogs**&nbsp;: Jekyll a été conçu pour prendre en charge les articles de blog, il est donc facile de blog (ajouter du nouveau contenu trié par date) et d'effectuer des tâches connexes comme l'affichage d'une archive de tous les articles de blog par mois, ou inclure un lien vers les trois articles les plus récents de blog au bas de chaque article.

- **Templating automatise les tâches répétitives**&nbsp;: Jekyll facilite l'automatisation des tâches répétitives d'un site web grâce à son système de " modèle "&nbsp;: vous pouvez créer du contenu qui doit, par exemple, apparaître sur l'en-tête et le pied de page de chaque page (par exemple, image du logo, menu principal), ou suivre le titre de chaque billet de blog (par exemple, nom de l'auteur et date de publication). Ces informations modèles seront automatiquement répétées sur chaque page Web appropriée, au lieu de vous forcer à réécrire manuellement ces informations sur chaque page Web où vous voulez qu'elles apparaissent. Non seulement cela économise beaucoup de copier-coller - si vous voulez changer quelque chose qui apparaît sur chaque page de votre site Web (par exemple un nouveau logo de site ou un nouvel élément dans le menu principal), mais le changer une fois dans un modèle changera à chaque endroit où il apparaît sur votre site.

## Préparation de l'installation  <a id="section1"></a>

Nous sommes prêts à nous mettre au travail&#x202F;! Dans la suite de cette leçon, nous allons installer quelques programmes sur votre ordinateur, utiliser la ligne de commande pour installer quelques choses qui ne peuvent être installées que de cette façon, regarder et personnaliser une version privée de votre site Web, et enfin rendre votre site accessible publiquement sur le Web. Si vous rencontrez des problèmes à n'importe quel moment de cette leçon, consultez la [section d'aide](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section9) pour savoir comment poser des questions ou signaler des problèmes.

Dans cette section, nous nous assurerons que vous avez quelques choses prêtes sur votre ordinateur pour quand nous en aurons besoin plus tard dans la leçon en couvrant quel système d'exploitation vous pouvez utiliser (i.e. Mac/Windows/Linux), en créant un compte GitHub et en installant l'application GitHub, pourquoi vous devriez utiliser un programme "text editor" pour travailler sur votre site, et comment utiliser la ligne de commande.

Tout ce que cette leçon vous fait installer est un outil de développement web standard et fiable, il n'est donc pas important de savoir exactement ce que chacune de ces choses font avant de l'installer. J'essaierai d'équilibrer plus d'informations sur les choses qu'il est le plus utile pour vous de comprendre pleinement, en fournissant une brève explication pour chaque pièce et aussi un lien vers d'autres informations au cas où vous aimeriez en savoir plus sur ce que vous mettez sur votre ordinateur.

### Systèmes d'exploitation <a id="section1-0"></a>

Ce tutoriel devrait être utilisable par les utilisateurs Mac et Windows. Jekyll peut aussi fonctionner sous Linux&#x202F;; ce tutoriel utilise le logiciel GitHub Desktop (Mac et Windows uniquement) pour plus de simplicité, mais les utilisateurs Linux devront plutôt utiliser git sur la ligne de commande (non couvert ici).

Jekyll n'est pas officiellement supporté pour Windows, ce qui signifie qu'aucune des documentations officielles de Jekyll (les pages qui vous guident dans la configuration de Jekyll et ce que font ses différents éléments, que vous pouvez consulter à la place ou en plus de cette leçon) ne traite de l'utilisation de Windows. J'ai utilisé les instructions Windows de David Burela pour noter les endroits de la section "Installation des dépendances" où les utilisateurs de Windows devraient faire quelque chose de différent&#x202F;; le reste de la leçon devrait fonctionner de la même façon pour les utilisateurs de Mac et de Windows, bien que les captures d'écran de la leçon soient toutes faites sur un Mac (donc les choses peuvent avoir un peu changé pour un utilisateur Windows).

### Compte utilisateur GitHub <a id="section1-1"></a>

*Un compte utilisateur GitHub vous permettra d'héberger votre site web (le rendre disponible pour que d'autres puissent le visiter) gratuitement sur GitHub (nous verrons comment dans une étape ultérieure). En prime, il vous permettra également de garder une trace des versions du site Web et de son écriture au fur et à mesure de sa croissance ou de son évolution dans le temps.*



1. Visitez [GitHub.com](https://github.com/) et cliquez sur le bouton "Inscription" en haut à droite. Inscrivez votre nom d'utilisateur désiré. Ceci sera visible par les autres, vous identifiera sur GitHub, et fera également partie de l'URL de votre site&#x202F;; par exemple, le nom d'utilisateur GitHub de l'auteur est amandavisconti et l'URL de son site démo Jekyll est http://amandavisconti.github.io/JekyllDemo/. *(Notez que vous pouvez également acheter votre propre nom de domaine et l'utiliser pour ce site, mais cela ne sera pas couvert dans ce tutoriel).* Indiquez également l'adresse e-mail et le mot de passe souhaités, puis cliquez sur "Créer un compte".
2. Sur la page suivante, cliquez sur le bouton "Choisir" à côté de l'option "Gratuit", ignorez la case à cocher "Aidez-moi à mettre en place une organisation suivante", puis cliquez sur "Terminer l'inscription".
3. *Facultatif*&nbsp;: Visitez https://github.com/settings/profile pour ajouter un nom complet (peut être votre vrai nom, nom d'utilisateur GitHub, ou autre chose) et d'autres informations de profil public, si désiré.

### GitHub Desktop app <a id="section1-2"></a>

*L'application [GitHub Desktop](https://desktop.github.com/) rendra la mise à jour de votre site web en direct (celle que nous avons mise en place) facile - au lieu d'utiliser la ligne de commande chaque fois que vous voulez mettre à jour votre site, vous pourrez utiliser un outil visuel plus facile pour mettre à jour votre site.*

1. Visitez le site GitHub Desktop et cliquez sur le bouton "Télécharger GitHub Desktop" pour télécharger le logiciel GitHub Desktop sur votre ordinateur (Mac et Windows uniquement&#x202F;; les utilisateurs Linux devront utiliser git uniquement via la ligne de commande, qui n'est pas couverte dans cette version du tutorial).
2.     Une fois le fichier complètement téléchargé, double-cliquez dessus et suivez les instructions suivantes pour installer GitHub Desktop....
3.      Entrez le nom d'utilisateur et le mot de passe du compte GitHub.com que vous avez créé en suivant les étapes ci-dessus. (Ignorez le bouton "Ajouter un compte d'entreprise".) Cliquez sur "Continuer".
4.      Entrez le nom et l'adresse e-mail que vous voulez que le travail sur votre site soit associé à (probablement seulement votre nom public et votre adresse e-mail au travail, mais c'est à vous de choisir&#x202F;!
5.      Sur la même page, cliquez sur le bouton "Installer les outils en ligne de commande" et entrez le nom d'utilisateur et le mot de passe de votre ordinateur si vous y êtes invité (puis cliquez sur le bouton "Install Helper" à l'invite). Après avoir reçu un message popup vous indiquant que tous les outils en ligne de commande ont été installés avec succès, cliquez sur Continuer.
6.      La dernière page demandera "Quels dépôts aimeriez-vous utiliser&#x202F;? Ignorez ceci et cliquez sur le bouton "Terminé".
7.     * Facultatif*&nbsp;: Suivez la procédure de l'application GitHub Desktop qui apparaîtra (ce n'est pas nécessaire&#x202F;; nous couvrirons tout ce que vous devez faire avec GitHub dans cette leçon).

### Éditeur de texte <a id="section1-3"></a>

Vous aurez besoin de télécharger et d'installer un programme "éditeur de texte" sur votre ordinateur pour faire de petites personnalisations du code de votre site Jekyll. Les bonnes options gratuites incluent [TextWrangler](http://www.barebones.com/products/textwrangler/download.html) (Mac) ou [Notepad++](https://notepad-plus-plus.org/) (Windows). Les logiciels de traitement de texte, comme Microsoft Word ou Word Pad, ne sont pas un bon choix parce qu'il est facile d'oublier comment formater et enregistrer le fichier, en ajoutant accidentellement un formatage supplémentaire et/ou invisible et des caractères qui vont casser votre site. Vous voudrez quelque chose qui peut spécifiquement sauvegarder ce que vous écrivez en tant que texte en clair (p. ex. HTML, Markdown).

*Facultatif*&nbsp;: Reportez-vous à la section "Rédiger dans Markdown" ci-dessous pour des notes sur un programme d'édition spécifique à Markdown, que vous souhaiterez peut-être également installer lorsque vous arriverez au point de créer des pages Web et/ou des billets de blog.

### Ligne de commande <a id="section1-4"></a>

La ligne de commande est un moyen d'interagir avec votre ordinateur à l'aide de texte&nbsp;: elle vous permet de taper des commandes pour des actions plus simples telles que "montrer une liste des fichiers dans ce répertoire" ou "changer qui est autorisé à accéder à ce fichier", pour des comportements plus complexes. Il y a parfois de belles façons visuelles de faire les choses sur votre ordinateur (par exemple l'application GitHub Desktop que nous avons installée ci-dessus), et parfois vous aurez besoin d'utiliser la ligne de commande pour taper des commandes pour que votre ordinateur fasse les choses. Le *Programming Historian* a [une leçon approfondie explorant la ligne de commande](https://programminghistorian.org/en/lessons/intro-to-bash) écrite par Ian Milligan et James Baker si vous voulez plus d'informations que celles fournies ici, mais cette leçon couvrira tout ce que vous devez savoir pour compléter la leçon (et nous utiliserons la ligne de commande seulement quand elle est nécessaire ou beaucoup plus facile qu'une interface visuelle).

Là où la ligne de commande utilise des commandes textuelles, une "interface utilisateur graphique" (GUI) est probablement ce que vous utilisez normalement pour travailler avec votre ordinateur&nbsp;: tout ce qui est donné par une interface visuelle contenant des icônes, des images, un clic de souris, etc. est une GUI. Souvent, il est plus simple et plus rapide de taper (ou de copier-coller à partir d'un tutoriel) une série de commandes via la ligne de commande, que de faire quelque chose en utilisant une interface graphique&#x202F;; parfois il y a des choses que vous voudrez faire pour lesquelles personne n'a encore créé une interface graphique, et vous devrez les faire via cette ligne de commande.

Le programme en ligne de commande par défaut s'appelle "Terminal" sur Macs (situé dans *Applications > Utilitaires*), et "Invite de commandes", "Windows Power Shell", ou "Git Bash" sur Windows (ce sont trois options différentes qui diffèrent chacune dans le type de commandes qu'elles acceptent&#x202F;; nous allons entrer en détail sur lesquelles vous devrez utiliser plus tard dans la leçon).

Voici à quoi ressemble une fenêtre en ligne de commande sur le Mac de l'auteur (en utilisant Terminal). Vous verrez quelque chose comme *Macbook-Air&nbsp;:~ DrJekyll$* ci-dessous dans votre fenêtre de ligne de commande&#x202F;; ce texte est appelé le "prompt" (il vous invite à saisir des commandes). Dans la capture d'écran, *Macbook-Air* est le nom de mon ordinateur, et *DrJekyll* est le compte utilisateur actuellement connecté (l'invite utilisera différents noms pour votre ordinateur et nom d'utilisateur). 
 
![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-0.png)

*A quoi ressemble l'invite de commande sur un Mac*

Lorsqu'on vous demande d'ouvrir une fenêtre de ligne de commande et d'entrer des commandes dans cette leçon, gardez à l'esprit ce qui suit&nbsp;:

1. **Les commandes que vous devez taper (ou copier/coller) dans la ligne de commande sont formatées comme ceci**&nbsp;: exemple de formatage de code. Chaque morceau de code formaté doit être copié et collé dans la ligne de commande, suivi de la touche Entrée.
2. **Laissez les processus d'installation s'exécuter complètement avant d'entrer de nouvelles commandes.** Parfois, le fait de taper une commande et d'appuyer sur Entrée produit un résultat instantané&#x202F;; parfois, beaucoup de texte commence à remplir la fenêtre de ligne de commande, ou la fenêtre de ligne de commande semble ne rien faire (mais quelque chose se passe réellement en coulisse, comme télécharger un fichier). **Lorsque vous avez tapé une commande et appuyé sur Entrée, vous devrez attendre que cette commande soit complètement terminée avant de taper *quoi que ce soit d'autre*, ou vous pourriez arrêter un processus au milieu, causant des problèmes.** {0}. Vous saurez que votre commande est terminée lorsque la ligne de commande crache à nouveau l'invite. Voyez la capture d'écran ci-dessous pour un exemple de saisie d'une commande, suivie d'un texte vous montrant ce qui se passait pendant le traitement de cette commande (et vous demandant parfois de faire quelque chose, comme saisir votre mot de passe), et enfin la réapparition de l'invite de commande pour vous faire savoir qu'il est possible de saisir autre chose.
 
![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-4.png)

*Un exemple de saisie d'une commande, suivi d'un texte vous montrant ce qui se passait pendant le traitement de cette commande (et vous demandant parfois de faire quelque chose, comme saisir votre mot de passe), et enfin la réapparition de l'invite de commande pour vous faire savoir qu'il est possible de saisir autre chose.*

Si vous avez besoin de faire autre chose à la ligne de commande et que vous ne voulez pas attendre, ouvrez simplement une fenêtre de ligne de commande séparée (sur un Mac, appuyez sur la commande N ou allez dans *Shell > Nouvelle fenêtre > Nouvelle fenêtre > Nouvelle fenêtre avec Settings-Basic*) et faites les choses en attendant que le processus se termine dans l'autre fenêtre.

1. Vous tapez ou collez souvent les mêmes commandes, ou vous voulez vous souvenir de quelque chose que vous avez tapé plus tôt ? Vous pouvez taper ↑ (flèche vers le haut) sur la ligne de commande pour faire défiler les commandes récemment tapées&#x202F;; appuyez simplement sur Entrée après l'apparition de celle que vous voulez utiliser.

## Installation des dépendances <a id="section2"></a>

Nous allons installer quelques dépendances logicielles (le code dont dépend Jekyll pour pouvoir fonctionner), en utilisant la ligne de commande car il n'y a pas d'interface visuelle pour cela. Cette section est divisée en instructions pour si vous êtes sur un Mac ou sur Windows, alors passez à Sur Windows maintenant si vous utilisez Windows.

### Sur un Mac <a id="sectionMac"></a>

*Si vous utilisez un ordinateur Mac, suivez les instructions ci-dessous jusqu'à ce que vous atteigniez une ligne indiquant que les instructions spécifiques à Windows commencent.*

Ouvrez une fenêtre de ligne de commande (Applications > Utilitaires > Terminal) et entrez le code indiqué dans les étapes ci-dessous (`le code est formaté comme ceci`), en gardant à l'esprit les astuces de ligne de commande du dessus.

### Suite d'outils en ligne de commande <a id="section2-1"></a>

Vous devrez d'abord installer la suite Mac "command line tools" pour pouvoir utiliser Homebrew (que nous installerons ensuite). [Homebrew](https://brew.sh/) vous permet de télécharger et d'installer des logiciels open-source sur Macs depuis la ligne de commande (c'est un "gestionnaire de paquets"), ce qui facilitera l'installation de Ruby (la langue sur laquelle est construit Jekyll).

1. Dans Terminal, collez le code suivant et appuyez sur Entrée&nbsp;:

    `xcode-select --install`

Vous verrez quelque chose comme le texte suivant, suivi d'un popup&nbsp;:

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-1.png)
 
*Après avoir entré le code à l'invite de commande, vous verrez un message indiquant'install requested for command line developer tools'.*

Dans le popup, cliquez sur le bouton "Installer" (*pas* sur le bouton "Obtenir Xcode", qui installera le code dont vous n'avez pas besoin et qui peut prendre des heures à télécharger)&nbsp;:

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-2.png)

Vous verrez un message indiquant que "Le logiciel a été installé" lorsque l'installation sera terminée :

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-2.5.png)

### Homebrew  <a id="section2-2"></a>

Une fois l'installation de la suite d'outils en ligne de commande terminée, revenez à votre fenêtre de ligne de commande et entrez ce qui suit pour installer [Homebrew](https://brew.sh/)&nbsp;:

	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Vous devrez appuyer sur la touche Entrée lorsque vous y serez invité et entrer le mot de passe de votre ordinateur lorsqu'on vous le demandera. Pour référence, voici une capture d'écran de la commande entrée dans la ligne de commande de l'auteur, suivie de tout le texte qui est apparu (y compris l'invite à appuyer sur Entrée, et à entrer mon mot de passe).

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-4.png)

*La commande entrée dans la ligne de commande de l'auteur, suivie de tout le texte qui est apparu (y compris l'invite à appuyer sur Entrée, et à entrer mon mot de passe)*

### Ruby & Ruby Gems  <a id="section2-3"></a>

Jekyll est construit à partir du [langage de codage Ruby](https://en.wikipedia.org/wiki/Ruby_%28programming_language%29). [Ruby Gems](https://rubygems.org/) facilite la configuration de logiciels Ruby comme Jekyll (c'est un gestionnaire de paquets, tout comme Homebrew-au lieu de rendre l'installation facile sur Macs, il ajoute quelques trucs pour simplifier les installations Ruby).

    brew install ruby

N'oubliez pas d'attendre que l'invite de commande apparaisse à nouveau pour taper la commande suivante&nbsp;:

    gem installer rubygems-update

Si vous obtenez une erreur de permissions à ce stade, appliquer `GEM_HOME` à votre répertoire utilisateur peut aider. Essayez en entrant&nbsp;:
`echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc` 
`echo 'export GEM_HOME=$HOME/gems' >> ~/.bashrc` 
`echo 'export PATH=$HOME/gems/bin:$PATH' >> ~/.bashrc` suivi de `source ~/.bashrc`. 

<div class="alert alert-warning">
Certains usagers de macOS Catalina et macOS Big Sur ont signalé avoir rencontrédes difficultés pour installer Ruby & Ruby Gems. La leçon précède la sortie de ces systèmes d'expoitation, mais le code fourni ici a été adapté pour offrir une potentielle solution. Les utilisateurs ou utilisatrices qui continueraient à être confronté(e)s au problème pourraient trouver <a href="https://github.com/monfresh/install-ruby-on-macos">ce script</a> utile. 
</div>  


### NodeJS <a id="section2-4"></a>

[NodeJS](https://nodejs.org/en/) (ou Node.js) est une plate-forme de développement (en particulier, un "environnement d'exécution") qui fait des choses comme faire tourner Javascript plus rapidement.
    
    brew install node

### Jekyll <a id="section2-5"></a>

Jekyll est le code qui crée votre site web (i.e. "génération de site"), facilitant l'exécution de certaines tâches courantes telles que l'utilisation du même modèle (même logo, même menu, même information sur l'auteur...) sur toutes vos pages de blog. Il y a plus d'informations sur ce que sont Jekyll et les sites statiques, et sur les raisons pour lesquelles vous voudriez utiliser Jekyll pour créer un site statique, ci-dessus.

    gem install jekyll

Si vous obtenez une erreur de permissions à ce stade, entrer `usr/local/bin/gem` install jekyll` au lieu de la commande ci-dessus peut aider.

**Sauter les étapes suivantes (qui sont réservées aux utilisateurs de Windows) et sauter à Configurer Jekyll.**

### Sous Windows <a id="sectionWindows"></a>

*Les instructions pour les utilisateurs de Windows diffèrent de celles pour les utilisateurs de Mac dans cette seule section "Installation des dépendances". Ne procédez comme suit que si vous utilisez Windows.*


1. Nous avons besoin d'un outil en ligne de commande qui reconnaît les mêmes commandes que les Macs et les ordinateurs Linux (c'est-à-dire les systèmes d'exploitation Unix). Visitez [https://git-scm.com/downloads](https://git-scm.com/downloads) et cliquez sur le lien "Windows" sous "Téléchargements". Une fois le téléchargement terminé, double-cliquez sur le fichier téléchargé et suivez les étapes pour installer Git Bash (laissez toutes les options telles qu'elles sont déjà).
2.     Ouvrez "Invite de commandes" (ouvrez votre menu Démarrer et recherchez "Invite de commandes" et une application que vous pouvez ouvrir devrait apparaître).
3.         Chocolatey est un "gestionnaire de paquets"&nbsp;: code qui vous permet de télécharger et d'installer facilement des logiciels libres sous Windows depuis la ligne de commande. Nous allons maintenant installer Chocolately *(assurez-vous de mettre en évidence et de copier l'ensemble du club de texte ci-dessous ensemble, et non sur des lignes séparées)*. Entrez le code indiqué dans les étapes ci-dessous (`le code est formaté comme ceci`), en gardant à l'esprit les astuces de la ligne de commande ci-dessus&nbsp;:
 `@powershell -NoProfile -ExecutionPolicy unrestricted -Command "(iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')))) >null 2>&1" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin`
4.      Fermez l'application "Command Prompt" et ouvrez "Git Bash" (que vous avez récemment installé) à la place. Vous allez maintenant utiliser Git Bash à chaque fois que la ligne de commande est appelée.
5.          Jekyll est construit à partir du langage de codage Ruby. Ruby Gems facilite la configuration de logiciels Ruby comme Jekyll (c'est un gestionnaire de paquets, tout comme Homebrew-au lieu de rendre l'installation facile sur Macs, il ajoute quelques trucs pour simplifier les installations Ruby). Nous allons maintenant installer Ruby (cela prendra quelques minutes)&nbsp;:     `choco installer ruby -y`
6.  Fermez le programme en ligne de commande et redémarrez (Ruby ne fonctionnera pas tant que vous ne l'aurez pas fait une fois).
7.  Jekyll est le code qui crée votre site web (i.e. "génération de site"), facilitant l'exécution de certaines tâches courantes telles que l'utilisation du même modèle (même logo, même menu, même information sur l'auteur...) sur toutes vos pages de blog. Il y a plus d'informations sur ce que sont Jekyll et les sites statiques, et sur les raisons pour lesquelles vous voudriez utiliser Jekyll pour créer un site statique, ci-dessus. Nous allons maintenant installer Jekyll (si Windows Security vous donne un avertissement, ignorez le)&nbsp;:
`gem install jekyll`




**Désormais, toutes les instructions s'adressent aussi bien aux utilisateurs de Mac qu'à ceux de PC&#x202F;!**


## Mise en place de Jekyll <a id="section3"></a>

*Vous avez maintenant installé tout ce dont vous avez besoin pour créer votre site web. Dans cette section, nous allons utiliser Jekyll pour générer un nouveau dossier plein des fichiers qui constituent votre site web. Nous localiserons également ce dossier dans un endroit accessible à l'application GitHub Desktop pour qu'il soit au bon endroit lorsque nous voulons le publier comme site web public plus tard dans la leçon.*


1. Vous aurez besoin de connaître le chemin d'accès au dossier GitHub créé en installant l'application GitHub Desktop (il s'agit d'un texte qui indique où se trouve un dossier ou un fichier spécifique dans l'arborescence de votre ordinateur, par exemple, /Desktop/MyRecipes/Spaghetti.doc). Si vous ne connaissez pas le chemin du fichier du dossier GitHub, cliquez sur l'icône de la loupe en haut à droite de l'écran de votre ordinateur (sur un Mac) ou utilisez le champ de recherche dans le menu Démarrer (Windows).
 
![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-5.png)

*L'icône de loupe qui vous permet de rechercher un ordinateur Mac se trouve en haut à droite de l'écran de votre ordinateur.*

Sur les Macs, une boîte de recherche apparaîtra au milieu de l'écran&#x202F;; tapez "GitHub", puis double-cliquez sur l'option "GitHub" qui apparaît sous "Folders" pour afficher le dossier GitHub dans Finder (cela peut paraître légèrement différent sur Windows, mais devrait fonctionner de la même manière).

Notez que sur certains ordinateurs, ce dossier est plutôt intitulé "GitHub for Macs" et peut ne pas apparaître lors d'une recherche&#x202F;; si les étapes précédentes n'ont pas trouvé un dossier GitHub pour vous, allez dans Bibliothèque > Support d'application dans Finder et vérifiez si un dossier "GitHub for Mac" y est situé. Vous pouvez également appuyer sur la touche Option tout en cliquant sur le menu Finder Go pour voir le dossier "Bibliothèque" de votre nom d'utilisateur.  

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-6.png)

*Après avoir recherché'GitHub', une option'GitHub' apparaît sous la rubrique'Dossiers'&#x202F;; double-cliquez sur'GitHub' pour révéler le dossier GitHub dans Finder*

Faites un clic droit sur le dossier "GitHub" et choisissez "Copier'GitHub'". Le chemin d'accès du dossier GitHub est maintenant copié dans votre presse-papiers.

1. En ligne de commande, écrivez `cd`, suivi d'un espace, suivi du chemin d'accès à votre dossier GitHub (soit tapez-le si vous le connaissez, soit appuyez sur Commande-v pour coller le chemin d'accès au fichier copié à l'étape précédente). Sur l'ordinateur de l'auteur (connecté en tant qu'utilisateur DrJekyll) cette commande ressemble à&nbsp;:
 
![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-7.png)

*L'ordinateur de l'auteur après avoir entré cd, suivi d'un espace, suivi du chemin d'accès à son dossier GitHub.*


La commande cd (***c**hange **d**irectory*) demande à votre ordinateur de regarder l'emplacement dans le système de dossiers de l'ordinateur que vous spécifiez par le chemin tapé après lui - dans ce cas, le chemin vers le dossier GitHub créé en installant l'application GitHub Desktop.

<li/>Dans la ligne de commande, tapez ce qui suit et appuyez sur Entrée&nbsp;:

`gem install jekyll bundler`

N'oubliez pas d'attendre que l'invite de commande apparaisse à nouveau pour passer à l'étape suivante.
  
<li/>L'URL publique de votre site prendra la forme http://amandavisconti.github.io/JekyllDemo/, *amandavisconti* étant le nom d'utilisateur GitHub de l'auteur et *JekyllDemo* le nom du site que j'ai saisi à cette étape (*une option pour acheter et utiliser votre propre URL personnalisée est possible, mais non couverte dans cette leçon*). **Les noms de sites Web en minuscules et en majuscules ne pointent pas automatiquement vers le même site Web**, donc contrairement à mon exemple *JekyllDemo*, vous pouvez choisir un nom en minuscules pour vous assurer que les personnes qui entendent parler du site ont tendance à saisir son URL correctement.

En ligne de commande, tapez ce qui suit (mais remplacez *JekyllDemo* par le nom que vous voulez donner à votre site) :

   `jekyll new JekyllDemo`
    
Cette commande demandait à jekyll de créer un nouveau site en installant tous les fichiers nécessaires dans un dossier nommé *JekyllDemo*. **Le dossier que vous créez à cette étape (par exemple *JekyllDemo*) sera appelé "dossier du site web" pour le reste de ce tutoriel.**


<li/>En ligne de commande, tapez ce qui suit pour naviguer dans le dossier de votre site (pendant le reste de cette leçon, remplacez toujours JekyllDemo par le nom que vous avez choisi pour votre site à l'étape précédente)&nbsp;:

 `cd JekyllDemo`

Si vous regardez dans le dossier *GitHub > JekyllDemo* dans Finder, vous verrez qu'un tas de nouveaux fichiers - les fichiers qui exécuteront votre site web&#x202F;!- ont été installés (nous décrirons ce que chacun fait plus loin dans cette leçon)&nbsp;:
</ol>

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-9.png)
 
Dans Finder, nous pouvons voir que beaucoup de nouveaux fichiers - les fichiers qui exécuteront votre site Web&#x202F;!- ont été installés.

## Exécuter un site Web localement <a id="section3a"></a>

*Cette section décrira comment exécuter votre site Web localement, c'est-à-dire que vous pourrez voir à quoi ressemblera votre site Web dans un navigateur Web sur votre ordinateur (ou localement), mais pas ailleurs. Travailler sur une version "locale" d'un site web signifie qu'il est privé à votre ordinateur&#x202F;; personne d'autre ne peut encore voir votre site web (votre site n'est pas "en direct" ou "public" : personne ne peut saisir l'URL et la voir dans son navigateur).*

*Cela signifie que vous pouvez expérimenter tout ce que vous voulez, et ne publier votre site que pour le monde entier pour voir quand il est prêt. Ou, une fois que vous avez fait votre site en direct, vous pouvez continuer à expérimenter localement avec de nouvelles écritures, designs, etc. et ne les ajouter au site public que lorsque vous êtes satisfait de leur apparence sur le site local.*


- En ligne de commande, tapez&nbsp;:

`bundle exec jekyll serve --watch`

C'est la commande que vous lancerez quand vous voudrez voir votre site web localement&nbsp;:

*jekyll* serve demande à votre ordinateur d'exécuter Jekyll localement.

La commande *-watch* avec *bundle exec* indique à Jekyll de surveiller les modifications apportées aux fichiers du site Web, comme la rédaction et l'enregistrement d'un nouveau billet de blog ou d'une nouvelle page Web, et d'inclure ces modifications lors du rafraîchissement de votre navigateur Web. **Une exception à cette règle** est le fichier _config.yml, dont je parlerai plus en détail dans la section suivante (les modifications qui y sont apportées n'apparaîtront que lorsque vous arrêterez et redémarrerez Jekyll).

- Après avoir tapé la commande à l'étape précédente, vous remarquerez que le processus ne se termine jamais. Rappelez-vous comment sur la ligne de commande, si vous tapez quelque chose alors que la commande précédente est encore en cours de traitement, vous pouvez causer des problèmes ? Jekyll est maintenant lancé à partir de cette fenêtre de ligne de commande, vous devrez donc ouvrir une nouvelle fenêtre de ligne de commande si vous voulez taper d'autres commandes alors que votre site local vous est encore accessible (voir la section sur l'utilisation de la ligne de commande ci-dessus.)

 ![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-10.png)
*La ligne de commande après avoir entré la commande pour commencer à servir votre site Web Jekyll*

Les rapports et les messages d'erreur causés par les modifications que vous apportez aux fichiers du dossier du site Web apparaîtront dans cette fenêtre de ligne de commande, et sont un bon premier endroit pour vérifier si quelque chose ne fonctionne pas.

1. Pour arrêter d'exécuter le site localement, appuyez sur control-c (cela libère la fenêtre de ligne de commande pour une nouvelle utilisation). Il suffit d'entrer bundle exec exec jekyll serve --watch à nouveau pour commencer à exécuter le site à nouveau localement.
2. Consultez votre site local en visitant localhost:4000. Vous verrez un site Web Jekyll de base avec du texte standard :

 ![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-11.png)

### Mini cheatsheet <a id="section3a-1"></a>

- Tapez bundle exec jekyll serve --watch à la ligne de commande pour commencer à exécuter votre site web localement. Vous visiteriez localhost:4000 dans un navigateur pour voir votre site local maintenant, mais dans la section suivante, nous allons changer les choses de sorte que vous devrez visiter localhost:4000/JekyllDemo/ pour voir le site à partir de ce moment (en remplissant le nom de votre dossier pour JekyllDemo, et en vous assurant d'inclure le dernier slash).
- Appuyez sur control-c à la ligne de commande pour arrêter l'exécution du site Web localement.
- Pendant que le site est en cours d'exécution, après avoir apporté des modifications aux fichiers du site Web&nbsp;: enregistrez les fichiers et rafraîchissez la page Web pour voir les modifications - sauf pour le fichier _config.yml, pour lequel vous devez arrêter d'exécuter le site Web et redémarrer le site Web pour voir les modifications.
- Dactylographier ou coller dans le paquet exec exec jekyll servir ---regarder beaucoup&#x202F;? Au lieu de cela, vous pouvez taper ↑ (flèche vers le haut) sur la ligne de commande pour faire défiler les commandes récemment tapées&#x202F;; appuyez simplement sur Entrée après l'apparition de la commande que vous voulez utiliser.

## Ajustement des réglages <a id="section4"></a>

Vous disposez désormais d'un site web de base, privé et accessible uniquement sur votre ordinateur. Dans cette section, nous commencerons à personnaliser votre site en changeant le titre du site et les informations sur l'auteur, et en donnant un bref aperçu de ce que font les différents fichiers du site.

### Paramètres de base du site via _config.yml <a id="section4-1"></a>

- Naviguez jusqu'au dossier de votre site Web dans Finder (Macs) ou dans le dossier de répertoire (Windows. Le site Web de l'auteur à /Users/DrJekyll/GitHub/JekyllDemo (DrJekyll est mon nom d'utilisateur connecté et JekyllDemo est le nom du dossier de mon site). Retournez à la section "Configurer Jekyll" si vous avez besoin d'aide pour localiser le dossier de votre site Web.

Vous remarquerez que la génération et l'exécution de votre site dans la section précédente a ajouté un nouveau dossier "_site". C'est ici que Jekyll place les fichiers HTML qu'il génère à partir des autres fichiers dans le dossier de votre site Web. Jekyll fonctionne en prenant divers fichiers comme les paramètres de configuration de votre site (_config.yml) et les fichiers qui ne contiennent que du contenu de message ou de page sans autre information de page Web (par exemple about.md), en les regroupant et en crachant des pages HTML qu'un navigateur Web peut lire et afficher aux visiteurs.

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-18.png)

  *Localisation du dossier du site Web sur l'ordinateur de l'auteur*


- Nous allons commencer par personnaliser le fichier de configuration principal, **'_config.yml**. Vous voudrez ouvrir ce fichier et tous les futurs fichiers du site Web à l'aide de votre éditeur de texte (par exemple, TextWrangler sur Macs ou Notepad++ sur Windows).
 
![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-14.png)

*Ouvrir l'editeur TextWrangler sur le mac de l'auteur*

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-15.png)

*Le nouveau fichier config.yml*

Le fichier *'_config.yml'* est un fichier "destiné aux paramètres qui affectent l'ensemble de votre blog, valeurs pour lesquelles vous êtes censé configurer une seule fois et que vous avez rarement besoin d'éditer par la suite" (comme on dit dans le fichier&#x202F;!). _config.yml est l'endroit où vous pouvez définir le titre de votre site, partager des informations comme votre adresse e-mail que vous voulez associer au site, ou ajouter d'autres "paramètres de base"-type d'informations que vous voulez disponibles sur votre site Web.

Le type de fichier.yml fait référence à la façon dont le fichier est écrit en utilisant [YAML](https://en.wikipedia.org/wiki/YAML) (l'acronyme signifiant "YAML Ain't Markup Language")&#x202F;; YAML est un moyen d'écrire des données qui est à la fois facile à écrire et à lire pour les humains et facile à interpréter pour les machines. Vous n'aurez pas besoin d'en apprendre beaucoup sur YAML, en plus de conserver le format _config.yml tel qu'il est à l'origine, même lorsque vous personnalisez le texte qu'il contient (par exemple, les informations du titre sont sur une ligne séparée de votre email).

 

- Vous pouvez modifier le texte de ce fichier, enregistrer le fichier, puis visiter votre site Web local dans un navigateur pour voir les modifications. Notez que les modifications apportées à _config.yml, contrairement aux autres fichiers de votre site Web, n'apparaîtront pas si elles sont effectuées alors que le site Web est déjà en cours d'exécution&#x202F;; vous devez les effectuer alors que le site Web n'est pas en marche, ou après avoir apporté des modifications à _config.yml arrêter puis commencer à exécuter le site, pour voir les modifications apportées à ce fichier particulier. (Les modifications apportées au fichier _config.yml n'ont pas pu être rafraîchies car ce fichier peut être utilisé pour déclarer des choses comme la structure des liens du site, et les modifier pendant l'exécution du site pourrait gravement casser des choses.)
<br/>

- Apporter de petits changements aux fichiers du site Web (un à la fois pour commencer), sauvegarder, puis rafraîchir pour voir l'effet sur votre site signifie que si vous foirez quelque chose, il sera clair ce qui a causé le problème et comment le résoudre.
	- Notez que toute ligne qui commence par un signe # est un commentaire&nbsp;: les commentaires ne sont pas lus comme du code, et servent plutôt à laisser des notes sur la façon de faire quelque chose ou pourquoi vous avez apporté un changement au code.
	- Les commentaires peuvent toujours être supprimés sans effet sur votre site Web (par exemple, vous pouvez supprimer les lignes commentées 1-6 dans _config.yml si vous ne voulez pas toujours voir ces informations sur l'utilisation de Jekyll).

<br/>

- Editez le fichier _config.yml en suivant ces instructions&nbsp;:
	- **titre**&nbsp;: Le titre de votre site Web, tel que vous voulez qu'il apparaisse dans l'en-tête de la page Web.
	-** e-mail**&nbsp;: Votre adresse e-mail.
	- **description**&nbsp;: Une description de votre site Web qui sera utilisé dans les résultats des moteurs de recherche et le flux RSS du site.
	- **Baseurl**&nbsp;: Remplissez les guillemets avec une barre oblique suivie du nom du dossier de votre site Web (par exemple "/JekyllDemo") pour aider à localiser le site à l'URL correcte.
	- **url**&nbsp;: Remplacez "http://yourdomain.com" par "localhost:4000" pour vous aider à localiser votre version locale du site à l'URL correcte.                                
	- **twitter_username**&nbsp;: Votre nom d'utilisateur Twitter (ne pas inclure le symbole @).
	- **github_username**&nbsp;: Votre nom d'utilisateur GitHub.

  Les modifications que vous avez apportées aux lignes *baseurl* et *url* permettront à votre site de fonctionner à partir des mêmes fichiers à la fois localement sur votre ordinateur et en direct sur le Web, mais **cela a changé l'URL où vous verrez votre site local à partir de maintenant **(pendant que Jekyll tourne) de localhost:4000 à **localhost:4000/JekyllDemo/** (remplacez JekyllDemo par votre nom de dossier du site Web et mémorisez la dernière barre oblique).

  Dans la capture d'écran ci-dessous, j'ai supprimé les premières lignes commentées 1-9 et 12-15, ainsi que le texte commenté indiquant ce que "description" fait (pas nécessaire, juste pour vous montrer que vous pouvez supprimer les commentaires que vous ne voulez pas voir !) et personnalisé le reste du fichier comme indiqué ci-dessus&nbsp;:

 ![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-16.png)

*Le fichier config.yml personnalisé de l'auteur*

- Sauvegardez le fichier et démarrez (ou arrêtez et redémarrez s'il est en cours d'exécution) le site Web, puis visitez localhost:4000/JekyllDemo/ (en remplaçant JekyllDemo par le nom du dossier de votre site Web et en mémorisant la dernière barre oblique) pour voir votre site local personnalisé&nbsp;:

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-17.png)

 
### Où (et comment) sont les choses&#x202F;? <a id="section4-2"></a>
Pour avoir une idée du fonctionnement de votre site et des fichiers que vous expérimenteriez pour faire des choses plus avancées, voici quelques notes sur ce que fait chaque dossier ou fichier dans votre dossier de site Web actuel. N'oubliez pas de toujours ouvrir et éditer les fichiers avec un éditeur de texte (p. ex. TextWrangler) et non un traitement de texte (p. ex. pas Microsoft Word ou tout ce qui vous permet d'ajouter un formatage comme l'italique et le gras)&#x202F;; cela évite que des caractères invisibles de formatage soient enregistrés dans le fichier et endommagent le site Web. Si vous voulez juste commencer à ajouter du contenu à votre site et le rendre public, vous pouvez passer à la section suivante.

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-18.png)

   

- **\_config.yml** est discuté ci-dessus&#x202F;; il fournit des informations de base sur les paramètres de votre site, comme le titre du site et les possibilités supplémentaires que nous n'aborderons pas ici, comme la façon de structurer les liens vers les messages (par exemple, devraient-ils suivre le modèle MySite.com/year/month/day/post-title& #x202F;?).
- **le dossier \_includes** contient des fichiers qui sont inclus dans toutes les pages ou dans certaines d'entre elles (par exemple, un code pour que l'en-tête contienne le titre de votre site et le menu principal sur chaque page du site).
- **le dossier \_layouts** contient le code qui contrôle l'apparence des pages de votre site (default.html), ainsi que les personnalisations de ce code pour personnaliser le style des articles de blog (post.html) et des pages (page.html).
- **le dossier \_posts** contient les fichiers individuels qui représentent chacun un billet de blog sur votre site web. L'ajout d'un nouveau billet à ce dossier fera apparaître un nouveau billet de blog sur votre site Web, dans l'ordre chronologique inverse (du plus récent au plus ancien). Nous couvrirons l'ajout de billets de blog dans la prochaine section.
- **le dossier \_sass** contient les fichiers SCSS qui contrôlent la conception visuelle du site.
- **le dossier \_site** est l'endroit où les pages HTML qui apparaissent sur le Web sont générées et stockées (par exemple, vous écrirez et enregistrerez les messages sous forme de fichiers Markdown, mais Jekyll les convertira en HTML pour affichage dans un navigateur Web).
- **index.md** est un endroit pour ajouter le contenu que vous souhaitez voir apparaître sur votre page d'accueil, tel qu'une biographie à afficher au-dessus de la liste "Posts
- **about.md** est un exemple de page Jekyll. Il est déjà lié dans l'en-tête de votre site, et vous pouvez personnaliser son texte en l'ouvrant et en écrivant dans ce fichier. Nous ajouterons d'autres pages du site dans la section suivante.
- **css** dossier contient CSS converti à partir de SCSS qui contrôle la conception visuelle du site
- **feed.xml** permet aux gens de suivre le flux RSS de vos articles de blog
- **index.html** contrôle la structuration du contenu de la page d'accueil de votre site

## Rédiger des pages et des messages <a id="section5"></a>

*Cette section décrit comment créer des pages et des articles de blog sur votre site Web.*

Les **pages** et les **postes** ne sont que deux types de contenus écrits qui ont un style différent. Les pages sont du contenu (comme une page "À propos") qui n'est pas organisé ou affiché chronologiquement, mais qui pourrait être inclus dans le menu principal de votre site Web&#x202F;; les messages sont destinés à être utilisés pour un contenu mieux organisé par date de publication. Les URL (liens) des pages et des messages sont également différents par défaut (bien que vous puissiez les modifier)&nbsp;: les URL des pages ressemblent à MySite.com/about/, tandis que les URL des messages ressemblent à *MySite.com/2016/02/29/my-post-title.html.*

#### Rédiger dans Markdown <a id="section5-1"></a>

Markdown est un moyen de formater votre écriture pour la lecture sur le Web&nbsp;: il s'agit d'un ensemble de symboles faciles à mémoriser qui indiquent où le formatage du texte doit être ajouté (par exemple, un # devant le texte signifie le formater comme un titre, tandis qu'un * devant le texte signifie le formater comme une liste à puces). Pour Jekyll en particulier, Markdown signifie que vous pouvez écrire des pages Web et des billets de blog d'une manière confortable pour les auteurs (par exemple, pas besoin de chercher/ajouter des balises HTML en essayant d'écrire un essai), mais que cette écriture doit apparaître bien formatée sur le Web (par exemple, un convertisseur texte vers HTML).

Nous ne traiterons pas de Markdown dans cette leçon&#x202F;; si vous n'êtes pas familier avec ce sujet, pour l'instant, vous pouvez simplement créer des messages et des pages sans formatage (c'est-à-dire sans gras/italique, sans en-tête, sans liste à puces). Mais il est facile d'apprendre à les ajouter : il y a une [référence](https://kramdown.gettalong.org/quickref.html) pratique pour la démarque, ainsi qu'[une leçon de Sarah Simpkin sur l'Historien de la programmation sur les comment et les pourquoi de l'écriture avec Markdown](https://programminghistorian.org/en/lessons/getting-started-with-markdown). Consultez ces liens si vous souhaitez formater du texte (italique, gras, en-têtes, listes à puces/numéros) ou ajouter des hyperliens ou des images intégrées et autres fichiers.

Assurez-vous que toutes les cheatsheets de Markdown que vous regardez sont pour la saveur "[kramdown](https://kramdown.gettalong.org/quickref.html)" de Markdown, qui est ce que GitHub Pages (où nous allons héberger notre site) supporte. *(Il y a [plusieurs "saveurs" de Markdown](https://github.com/jgm/CommonMark/wiki/Markdown-Flavors) qui ont des différences subtiles dans ce que font les différents symboles, mais la plupart du temps les symboles fréquemment utilisés comme ceux qui créent le formatage des titres sont les mêmes - donc vous êtes en fait probablement d'accord pour utiliser une cheatsheet qui ne spécifie pas son kramdown, mais si vous avez des erreurs sur votre site qui utilisent des symboles non inclus dans kramdown, ce pourrait être pourquoi).*

Vous pourriez être intéressé par un logiciel "éditeur de démarques" tel que [Typora](http://www.typora.io/) (OS X et Windows&#x202F;; gratuit pendant la période bêta en cours), qui vous permettra d'utiliser des raccourcis clavier populaires pour écrire Markdown (par exemple, mettez en évidence le texte et appuyez sur la commande B pour le rendre en gras) et/ou tapez Markdown mais faites-le afficher comme il aura l'air sur le web (voir titres intitulés comme titres, plutôt que comme texte normal avec un # devant eux).

### Rédiger des pages <a id="section5-3"></a>

1. Pour voir une page existante sur votre site Web (créée comme partie par défaut d'un site Web Jekyll lorsque vous avez créé le reste des fichiers de votre site Web), naviguez dans le dossier de votre site Web et ouvrez le fichier about.md soit dans un éditeur de texte (par exemple TextWrangler) ou un éditeur Markdown (par exemple Typora) pour voir le fichier qui crée la page "About". Cliquez également sur le lien "A propos" en haut à droite de votre page Web pour voir à quoi ressemble la page Web que le fichier crée dans un navigateur.

2. Ce qui se trouve entre les tirets -- s'appelle "front matter" (notez que l'ouverture du fichier dans un éditeur Markdown peut faire apparaître le front sur un fond gris plutôt qu'entre deux tirets). L'élément de couverture indique à votre site s'il faut formater le contenu sous l'élément de couverture comme une page ou un message de blog, le titre du message, la date et l'heure à laquelle le message doit être publié, et toutes les catégories dans lesquelles vous souhaitez que le message ou la page figure. <br/><br/> Vous pouvez changer des choses dans la matière première d'une page&nbsp;:



	- **mise en page**&nbsp;: Gardez ceci tel quel (il devrait être écrit page).
	- **titre**&nbsp;: Modifiez le titre de la page souhaitée (à la différence des messages, pas de guillemets autour du titre). Dans la capture d'écran ci-dessous, j'ai ajouté une page avec le titre "Reprendre".
	- **permalien**&nbsp;: changez le texte entre les deux barres obliques vers le mot (*ou la phrase - mais vous devrez utiliser des tirets et non des espaces&#x202F;!*) que vous voulez suivre l'URL principale de votre site pour atteindre la page. Par exemple, **permalien&nbsp;: /about/** trouve une page sur **localhost:4000/votrenomdedossier/site-web/about/**
<br/><br/>

1. L'espace sous le deuxième tiret (ou sous la boîte grise du premier tiret, si vous utilisez un éditeur Markdown) est l'endroit où vous écrivez le contenu de votre page, en utilisant le formatage Markdown décrit ci-dessus.
2.  Pour créer une nouvelle page en plus de la page "A propos" qui existe déjà sur le site (et qui peut être personnalisée ou supprimée), créez une copie du fichier about.md dans le même dossier (le dossier principal du site) et changez son nom de fichier au titre que vous souhaitez, en utilisant des tirets au lieu des espaces (par ex. resume.md ou contact-me.md). Changez également le titre et le permalien dans la partie frontale du fichier, ainsi que le contenu du fichier. La nouvelle page devrait automatiquement apparaître dans le menu principal de l'en-tête du site&nbsp;:
 
![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-22.png)

*Après l'ajout d'un nouveau fichier de page dans le dossier du site Web, la nouvelle page apparaît dans le menu d'en-tête du site Web.*

Pour référence, vous pouvez consulter [un exemple de page](https://amandavisconti.github.io/JekyllDemo/resume/) sur mon site de démonstration, ou voir l[e fichier qui se trouve derrière cette page](https://raw.githubusercontent.com/amandavisconti/JekyllDemo/gh-pages/resume.md).

### Rédiger des postes <a id="section5-2"></a>

Dans le Finder, naviguez jusqu'au dossier de votre site Web (par exemple *JekyllDemo*) et le dossier **\_posts** qui s'y trouve. Ouvrez le fichier qu'il contient avec un éditeur de texte (par exemple TextWrangler) ou un éditeur Markdown (par exemple Typora). Le fichier sera nommé quelque chose comme *2016-02-28-welcome-to-jekyll.markdown* (la date correspondra à celle à laquelle vous avez créé le site Jekyll).
 
![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-19.png)

*Un exemple d'un fichier de blog de site Web Jekyll ouvert dans un éditeur de texte*

Comme pour les pages, avec les messages, le contenu entre les lignes -- est appelé "matière frontale" (*notez que l'ouverture du fichier dans un éditeur Markdown peut faire apparaître la matière frontale sur un fond gris plutôt qu'entre les tirets*). L'élément de couverture indique à votre site s'il faut formater le contenu sous l'élément de couverture comme une page ou un message de blog, le titre du message, la date et l'heure à laquelle le message doit être publié, et toutes les catégories dans lesquelles vous souhaitez que le message ou la page figure.

1. Nous allons écrire un deuxième message pour que vous puissiez voir à quoi ressemblent plusieurs messages sur votre site. Fermez le fichier 20xx-xx-xx-xx-xx-welcome-to-jekyll.markdown qui était ouvert, puis faites un clic droit sur ce fichier dans le Finder et choisissez "Duplicate". Un deuxième fichier nommé 20xx-xx-xx-xx-welcome-to-jekyll copy.markdown apparaîtra dans le dossier _sites.
2. Cliquez une fois sur le nom de fichier 20xx-xx-xx-xx-welcome-to-jekyll copy.markdown afin de pouvoir modifier le nom du fichier, puis le modifier pour afficher la date du jour et contenir un titre différent, tel que 2016-02-29-a-post-about-of-my-research.markdown (utilisez des tirets entre mots, non des espaces).
3. Ouvrez maintenant votre fichier renommé dans votre éditeur de texte ou de démarques, et personnalisez ce qui suit&nbsp;:


	- **mise en page **&nbsp;: Gardez ceci tel quel (il devrait s'agir d'un message).
	- **titre**&nbsp;: Changez "Welcome to Jekyll&#x202F;!" pour le titre que vous souhaitez pour votre nouveau message (en gardant les guillemets autour du titre). C'est la norme de faire en sorte que le titre soit le même que les mots dans le nom du fichier (sauf avec des espaces et des majuscules supplémentaires). C'est ainsi que le titre apparaîtra sur la page web de l'article).
	- **date**&nbsp;: Changez cette date pour la date et l'heure de publication du message, en veillant à ce qu'elle corresponde à la date qui fait partie du nom du fichier. (La date et l'heure devraient être déjà passées, pour que votre message apparaisse.)
	- **catégories**&nbsp;: Supprimez les mots "jekyll update" pour l'instant, et n'ajoutez rien d'autre ici - le thème actuel ne les utilise pas et ils perturbent les URL des messages. (D'autres thèmes peuvent utiliser ce champ pour trier les billets de blog par catégories.)
	- **L'espace sous la seconde -- (ou sous la boîte grise, si vous utilisez un éditeur Markdown)**&nbsp;: C'est ici que vous écrivez votre billet de blog, en utilisant le formatage Markdown décrit ci-dessus.

Après l'enregistrement, vous devriez maintenant être en mesure de voir votre deuxième message sur la page d'accueil de votre site, et en cliquant sur le lien devrait vous amener à la page du message&nbsp;:

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-20.png)
 
*Le site web d'auteur, ou le blogpost le plus recente s'affiche a la page d'acceuil*

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-21.png)

*La page web du blogpost sur le site d'auteur*

Notez que **l'URL du poste **est l'URL de votre site Web local (par exemple *localhost:4000/JekyllDemo/*) suivi de l'année/du mois/date de publication, suivi du titre comme écrit dans votre nom de fichier et se terminant par.html (par exemple *localhost:4000/JekyllDemo/2016/02/29/a-post-about-my-research.html*). Jekyll convertit le fichier Markdown que vous avez créé dans le dossier _posts en cette page Web HTML.

**Supprimer un fichier** du dossier _posts le supprime de votre site web (vous pouvez l'essayer avec l'exemple de message "Bienvenue chez Jekyll&#x202F;!!

**Pour créer d'autres postes**, dupliquez un fichier existant, puis n'oubliez pas de modifier non seulement le contenu du message comme décrit ci-dessus, mais aussi le nom du fichier (date et titre) du nouveau fichier.

Pour référence, vous pouvez consulter [un exemple de post ](https://amandavisconti.github.io/JekyllDemo/2016/11/12/a-post-about-my-research.html)sur mon site de démonstration, ou voir le [code de ce post](https://raw.githubusercontent.com/amandavisconti/JekyllDemo/gh-pages/_posts/2016-02-29-a-post-about-my-research.markdown).

## Hébergement sur les pages GitHub <a id="section6"></a>

*Vous savez maintenant comment ajouter des pages de texte et des messages à votre site Web. Dans cette section, nous déplacerons votre site local en direct afin que d'autres puissent le visiter sur le Web. ***À ce stade, nous rendons une version de votre site Web accessible au public*** (p. ex. aux moteurs de recherche et à toute personne qui connaît le lien ou qui s'y trouve).*

*Plus tôt dans la leçon, vous avez installé l'application GitHub Desktop. Nous allons maintenant utiliser cette application pour déplacer facilement vos fichiers de site Web à un endroit qui les servira aux visiteurs comme des pages Web (GitHub Pages), où le public peut ensuite les visiter en ligne. Cette première fois, nous déplacerons tous les fichiers de votre site Web vers le Web puisqu'aucun d'entre eux n'existe encore&#x202F;; dans le futur, vous utiliserez cette application chaque fois que vous aurez modifié les fichiers du site Web (contenu ou fichiers ajoutés, modifiés ou supprimés) sur votre version locale du site et que vous serez prêt pour les mêmes changements à apparaître sur le site public (vous trouverez une cheatsheet à la fin de cette section pour cela).*

1. Ouvrez l'application GitHub Desktop. Cliquez sur l'icône + dans le coin supérieur gauche, et cliquez sur l'option "Ajouter" en haut de la boîte qui apparaît (si "Ajouter" n'est pas déjà sélectionné).

2. Cliquez sur le bouton "Choisir..." et choisissez le dossier (JekyllDemo dans mon exemple) contenant vos fichiers de site web (si sur un Mac et incapable de localiser ce dossier, votre dossier Bibliothèque peut être caché&#x202F;; utilisez ces instructions pour le rendre visible afin que l'application GitHub Desktop puisse y naviguer).

3. Cliquez ensuite sur le bouton "Créer et ajouter un référentiel" (Mac) ou sur le bouton "Créer un référentiel" (Windows). Vous verrez maintenant une liste des fichiers auxquels vous avez apporté des modifications (ajouts ou suppressions de fichiers) depuis la dernière fois que vous avez copié le code de votre site Web de votre ordinateur vers GitHub (dans ce cas, nous n'avons jamais copié de code vers GitHub auparavant, donc tous les fichiers sont listés ici comme neufs).

4. Dans le premier champ, tapez une courte description des changements que vous avez effectués depuis que vous avez déplacé votre travail sur le site Web vers GitHub (l'espace est limité). Dans ce premier cas, quelque chose comme " Mon premier commit " est bien&#x202F;; dans le futur, vous voudrez peut-être être plus descriptif pour vous aider à localiser quand vous avez fait un changement donné, par exemple en écrivant " Ajouté une nouvelle page'Contactez-moi ".

Vous pouvez utiliser la plus grande zone de texte en dessous pour écrire un message plus long, si nécessaire (*c'est facultatif*).

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-23.png)
 
*Capture d'écran du dépôt du site Jekyll de l'auteur ouvert dans l'application GitHub. Sur la gauche, nous voyons notre dossier de site Web Jekyll sélectionné&#x202F;; au milieu, nous voyons une liste des fichiers que nous avons modifiés depuis la dernière fois que nous avons modifié le site Web en direct&#x202F;; et en bas, nous voyons des champs pour une brève description des modifications que vous avez apportées et pour une description plus longue (si nécessaire)*
 
- En haut de la fenêtre de l'application, cliquez sur la troisième icône à partir de la gauche (il sera dit "Ajouter une branche" si vous passez dessus). Tapez *gh-pages* dans le champ "Name", puis cliquez sur le bouton "Create branch".

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-24.png)
*Tapez gh-pages dans le champ "Name", puis cliquez sur le bouton "Create Branch"* 

- Cliquez sur le bouton "Commit to gh-pages" en bas à gauche de la fenêtre de l'application.

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-25.png)

*La page "Commit to gh-pages" en bas à  gauche de la fenetre de l'application*

- Cliquez sur le bouton "Publier" en haut à droite.

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-26.png)

- Dans le popup, laissez tout tel quel et cliquez sur le bouton "Publier le référentiel" en bas à droite (*votre fenêtre peut ne pas afficher les options relatives aux référentiels privés affichées dans la capture d'écran*)

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-27.png)

- Cliquez sur le bouton "Sync" en haut à droite.

![](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-28.png)

- Vous pouvez maintenant visiter (et partager le lien vers !) votre site web en direct. L'URL suivra le modèle de votre nom d'utilisateur GitHub DOT github.io SLASH nom de votre site web SLASH. (Par exemple, l'URL de l'auteur est [amandavisconti.github.io/JekyllDemo/](https://amandavisconti.github.io/JekyllDemo/).)


### Mini antisèche <a id="section6-1"></a>

A l'avenir, lorsque vous souhaitez déplacer les changements que vous avez effectués localement sur votre site en direct, il vous suffit de suivre ces étapes&nbsp;:

 
1. Ouvrez l'application GitHub Desktop et tapez une courte description de vos modifications (et éventuellement une description plus longue dans la deuxième zone de texte).
2. Cliquez sur le bouton "valider" sous la zone de texte.
3. Une fois la livraison terminée, cliquez sur le bouton "Sync" en haut à droite.
4. Donnez à GitHub un peu de temps pour recevoir ces changements (environ 10-90 secondes) avant de rafraîchir votre site en direct pour y voir vos changements.

## Devenir imaginatif <a id="section7"></a>
*Cette leçon ne couvrira pas le travail avancé comme changer l'apparence visuelle de votre site ou ajouter de nouvelles fonctionnalités, mais voici quelques informations pour vous aider à commencer par vous même.*

### Design visuel <a id="section7-1"></a>

La conception visuelle d'un site Web est souvent appelée son *thème* (plus précisément, un thème est un ensemble de fichiers de code et d'images qui, ensemble, apportent un changement majeur à l'apparence d'un site Web).

Vous pouvez personnaliser le thème actuel de votre site Web en modifiant les fichiers des dossiers *\_sass* et *css* (malheureusement, la version la plus récente de Jekyll à utiliser SASS au lieu de CSS simple rend l'apprentissage de la personnalisation un peu plus difficile pour les non concepteurs).

Ou, vous pouvez ajouter (et personnaliser, si vous le souhaitez) un thème déjà créé par quelqu'un d'autre en recherchant "Thèmes Jekyll" ou en essayant une de ces ressources&nbsp;:


- Le [thème "Ed" d'Alex Gil pour les éditions numériques minimales](https://elotroalex.github.io/ed/) et sa [documentation](https://elotroalex.github.io/ed/documentation) (gratuit)
- [Le thème de Rebecca Sutton Koeser "Digital Edition"](https://github.com/ecds/digitaledition-jekylltheme) (gratuit)
- L'annuaire [Jekyll Themes](http://jekyllthemes.org/) (gratuit)
- [JekyllThemes.io](https://jekyllthemes.io/) (gratuit et payant)

### Fonctionnalité <a id="section7-2"></a>

- Les [plugins Jekyll](http://jekyllrb.com/docs/plugins/) vous permettent d'ajouter de petits bouts de code qui ajoutent des fonctionnalités à votre site comme la [recherche plein texte](https://github.com/PascalW/jekyll_indextank), [la prise en charge des emoji](https://github.com/yihangho/emoji-for-jekyll) et les nuages de [tags](https://gist.github.com/ilkka/710577).
	- Si vous voulez héberger votre site sur des pages GitHub comme nous l'avons fait dans cette leçon, vous ne pouvez utiliser que les plugins Jekyll déjà inclus dans la gemme GitHub Pages que nous avons installée ([voici une liste complète de ce que vous avez installé](https://pages.github.com/versions/) en ajoutant la gemme GitHub Pages à votre Gemfile précédemment).
	- Si vous choisissez d'héberger votre site Jekyll ailleurs que sur les pages GitHub, vous pouvez utiliser n'importe quel plugin Jekyll (les instructions d'hébergement varient selon l'hébergeur et ne seront pas couvertes ici, mais [cette page](https://jekyllrb.com/docs/plugins/) explique comment installer les plugins une fois que vous avez configuré votre site Jekyll). Vous pouvez rechercher "Jekyll plugin" et les fonctionnalités dont vous avez besoin pour voir si un plugin est disponible, ou consulter la section "plugins disponibles" en bas de [cette page](https://jekyllrb.com/docs/plugins/) pour une liste des plugins.

- Vous pouvez garder l'hébergement gratuit de GitHub Page pour votre site Jekyll, mais donnez au site **un nom de domaine personnalisé** (les noms de domaine sont achetés à un prix annuel raisonnable - généralement autour de 10$ - auprès d'un "registrar de noms de domaine" tel que [NearlyFreeSpeech.net](https://www.nearlyfreespeech.net/services/domains)). Par exemple, le blog LiteratureGeek.com de l'auteur est construit avec Jekyll et hébergé sur les pages GitHub tout comme le site que vous avez construit avec cette leçon, mais il utilise un nom de domaine personnalisé que j'ai acheté et configuré pour pointer vers mon site. Les instructions pour configurer un nom de domaine personnalisé peuvent être trouvées ici.
- Vous pouvez **migrer un blog existant** à partir de plusieurs autres systèmes dont WordPress, Blogger, Drupal et Tumblr en suivant les liens sur le côté droit de [cette page](https://import.jekyllrb.com/docs/home/). Lors de la migration d'un site, assurez-vous de sauvegarder votre site d'origine au cas où il faudrait quelques tentatives pour que les messages vivent à la même URL qu'avant (pour que les résultats des moteurs de recherche et les signets ne cassent pas).

## Aide-mémoire <a id="section8"></a>

**Pour tester des choses en local** (nouveau plugin, thème, apparence d'un nouveau billet de blog)&nbsp;:

 - *Démarrer le site local*&nbsp;: Type ` bundle exec jekyll serve --watch` à la ligne de commande
 - *Visitez le site local*&nbsp;: Ouvrez **localhost:4000/votre nomdedossier** dans un navigateur web (par exemple *localhost:4000/JekyllDemo/*). N'oubliez pas la barre oblique&#x202F;!
 - *Voir les changements sur le site local au fur et à mesure que vous les effectuez*&nbsp;: Pendant que le site est en cours d'exécution, après avoir apporté des modifications aux fichiers du site Web&nbsp;: enregistrez les fichiers et rafraîchissez la page Web pour voir les modifications - **sauf pour le fichier \_config.yml**, pour lequel vous devez arrêter d'exécuter le site Web et redémarrer le site Web pour voir les modifications.
 - *Arrêter le site local*&nbsp;: Appuie sur **control-c** sur la ligne de commande.

**Pour déplacer les changements locaux sur votre site en direct** (nouveau message, modification des paramètres, etc.)&nbsp;:

- Apportez les modifications souhaitées aux fichiers locaux de votre site Web.
- Ouvrez l'application GitHub Desktop, assurez-vous que votre site web est choisi dans la liste des dépôts de la barre latérale gauche, et écrivez votre résumé du message de livraison (et sa description si désiré).
- Cliquez sur "Commit to gh-pages" en bas à gauche.
- Une fois la livraison terminée, cliquez sur "Sync" en haut à droite.
- Accordez 10 à 90 secondes pour que vos changements atteignent les serveurs web de GitHub, puis visitez votre site web et rafraîchissez la page pour voir vos changements en direct.



## Aide, crédits et lectures complémentaires <a id="section9"></a>

### Aide <a id="section9-1"></a>

Si vous rencontrez un problème,[ Jekyll a une page sur le dépannage](https://jekyllrb.com/docs/troubleshooting/) qui pourrait vous aider. Si vous travaillez sur la ligne de commande et obtenez un message d'erreur, n'oubliez pas d'essayer de rechercher ce message d'erreur spécifique en ligne. En plus des moteurs de recherche, [le site StackExchange](http://stackexchange.com/) est un bon endroit pour trouver des questions et réponses de personnes qui ont rencontré le même problème que vous dans le passé.

### Crédits <a id="section9-2"></a>

Merci à Fred Gibbs, rédacteur en chef de *Programming Historian*, pour la révision, la discussion et la révision de cette leçon&#x202F;; Paige Morgan et Jaime Howe pour la révision de cette leçon&#x202F;; Scott Weingart et les élèves pour avoir testé la leçon avec Windows&#x202F;; Tod Robbins et Matthew Lincoln pour leurs suggestions sur le [DH Slack ](http://tinyurl.com/DHSlack)et les sujets à couvrir dans cette leçon et Roxanne Shirazi pour leurs solutions aux problèmes possibles de permission et de navigation.

### Lectures complémentaires <a id="section9-3"></a>

Consultez les liens suivants pour obtenir de la documentation, de l'inspiration et d'autres lectures sur Jekyll&nbsp;:

- [Documentation officielle Jekyll](http://jekyllrb.com/docs/home/)
- Liens "officieux" de Jekyll vers deux ressources Windows + Jekyll&nbsp;: [http://jekyll-windows.juthilo.com/](http://jekyll-windows.juthilo.com/) et [https://davidburela.wordpress.com/2015/11/28/easily-install-jekyll-on-windows-with-3-command-prompt-entries-and-chocolatey/](https://davidburela.wordpress.com/2015/11/28/easily-install-jekyll-on-windows-with-3-command-prompt-entries-and-chocolatey/)
- [https://help.github.com/articles/using-jekyll-with-pages/](https://help.github.com/articles/using-jekyll-as-a-static-site-generator-with-github-pages/)
- Amanda Visconti, "[Introducing Static Sites for Digital Humanities Projects (pourquoi et que sont Jekyll, GitHub, etc.)](http://literaturegeek.com/2015/12/08/WhyJekyllGitHub)".
- Alex Gil, "[Comment (et pourquoi) générer un site Web statique en utilisant Jekyll, partie 1](http://chronicle.com/blogs/profhacker/jekyll1/60913)".
- Eduardo Bouças, "[Introduction aux générateurs statiques de sites](https://davidwalsh.name/introduction-static-site-generators)".
- [Guide de style Jekyll](http://ben.balter.com/jekyll-style-guide/)
- L'éditeur de contenu [Prose](http://prose.io/) (construit sur Jekyll
- [Rejoignez le Digital Humanities Slack](http://tinyurl.com/DHslack) (n'importe qui peut s'inscrire, même si vous n'avez pas d'expérience en DH) et consultez le canal #publishing pour discuter de Jekyll et d'autres plateformes de publication DH.

#### A propos de l'auteur

Amanda Visconti est directrice générale du centre DH Lab de l'Université de Virginie.

#### Citation suggérée

Amanda Visconti, "Construire un site web statique avec Jekyll et GitHub Pages", The Programming Historian 5 (2016), https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages.

