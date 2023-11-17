---
title: "Démarrer avec Omeka"
slug: demarrer-avec-omeka
original: up-and-running-with-omeka
layout: lesson
collection: lessons
date: 2016-02-17
translation_date: 2023-MM-DD
authors:
- Miriam Posner
editor:
- Adam Crymble
exclude_from_check:
  - reviewers
  - review-ticket
translators:
- Elina Leblanc
translation-editor:
- David Valentine
translation-reviewers:
- Forename Surname
- Forename Surname
difficulty: 1
activity: presenting
topics: [website]
abstract: Omeka.net permet de créer un site web facilement afin de valoriser une collection de contenus
avatar_alt: Squelette de dinosaure au musée
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

# Démarrer avec Omeka Classic

[Omeka Classic](https://omeka.org/classic/) est un logiciel libre qui permet de créer un site web facilement afin de valoriser une collection de contenus (items). Vous pouvez installer Omeka Classic sur un serveur ou utiliser une installation existante proposée par un hébergeur. La leçon anglaise [Installing Omeka](https://programminghistorian.org/en/lessons/installing-omeka) explique comment déployer Omeka Classic sur un serveur. La suite de cette leçon, quant à elle, présente Omeka Classic par l'offre d'hébergement [Omeka.net](http://www.omeka.net) proposée par l'éditeur du logiciel.

## Créer un compte Omeka

{% include figure.html filename="or-en-up-and-running-01.png" alt="Inscription à l’offre d’essai" caption="Figure 1. Inscrivez-vous avec l’offre d’essai" %}

Depuis la page [Omeka.net](http://www.omeka.net), cliquez sur **Pricing**. Précisons que cette offre n'est pas soumisse à une durée contrairement à ce que son nom peut laisser penser. Choisissez l’**offre d’essai** (*Start your free Omeka trial*). Remplissez le formulaire d’inscription. Dans votre boîte de messagerie, vérifiez que vous avez reçu le lien pour activer votre compte.

## Créer votre nouveau site Omeka

{% include figure.html filename="or-en-up-and-running-02.png" alt="Création d’un site Omeka.net" caption="Figure 2. Page d’un compte Omeka.net" %}

Après avoir cliqué sur le lien reçu dans votre boîte de messagerie, cliquez sur **Add a site** (Ajouter un site).

Ajoutez l’URL de votre site, le titre que vous voulez utiliser et une description si vous le souhaitez. Cliquez sur **Add your site** (Ajouter votre site).

## Vous avez un nouveau site Omeka&#x00A0;!

{% include figure.html filename="or-en-up-and-running-03.png" alt="Visualisation d’un site Omeka.net" caption="Figure 3. Voir votre site" %}

Pour voir à quoi il ressemble, cliquez sur **View site** (Voir le site).

## Un site Omeka vide

{% include figure.html filename="or-en-up-and-running-04.png" alt="Vue publique d’un site Omeka.net" caption="Figure 4. Vue publique" %}

Voici votre site Omeka vide qui n’attend que d’être rempli. Pour revenir sur votre tableau de bord, cliquez sur le bouton retour de votre navigateur ou entrez l’URL suivante&#x00A0;: **https://www.omeka.net/dashboard**. Cette fois, cliquez sur **Manage site** (Administrer le site).

## Changer de thèmes

{% include figure.html filename="tr-fr-demarrer-avec-omeka-05.png" alt="Paramètrage des thèmes" caption="Figure 5. Page permettant de paramétrer le thème" %}

Omeka vous permet de modifier l’apparence de votre site public en changeant de thème. Pour cela, cliquez sur **Appearance** (Apparence), en haut à droite de votre tableau de bord. Changez de thème en sélectionnant l’une des options proposées sur la page. Pour activer un nouveau thème, cliquez sur le bouton vert **Use this theme** (Utiliser ce thème). Ensuite, visitez votre site public en cliquant sur son nom, en haut à gauche de votre tableau de bord.

## Vous avez un nouveau thème&#x00A0;!

{% include figure.html filename="or-en-up-and-running-06.png" alt="Visualisation d’un nouveau thème sur le site public" caption="Figure 6. Vue publique du nouveau site" %}

Après avoir découvert votre nouveau thème, retournez sur votre tableau de bord. Vous pouvez réactiver votre ancien thème, garder le nouveau ou en sélectionner un autre parmi ceux proposés dans la liste.

## Installer des extensions

{% include figure.html filename="tr-fr-demarrer-avec-omeka-07.png" alt="Liste des extensions" caption="Figure 7. Page des extensions" %}

Votre site Omeka s’accompagne d’extensions qui offrent des fonctionnalités supplémentaires. Ces extensions doivent être activées. Pour cela, cliquez sur **Plugins** en haut à droite de l’écran. Parmi les extensions proposées, cliquez sur le bouton **Install** (Installer) de l’extension **Exhibit Builder**, en laissant par défaut les options qui vous seront proposées, et de l’extension **Simple Pages**.

## Configurer votre site en français (note du traducteur)

{% include figure.html filename="tr-fr-demarrer-avec-omeka-08.png" alt="Activation de l’extension Locale" caption="Figure 8. Changer la langue du site avec l’extension Locale" %}

La configuration par défaut d’Omeka est en anglais. Cependant, vous pouvez changer la langue de votre site grâce à une extension. Pour effectuer cette configuration, suivez les étapes ci-dessous&#x00A0;:
* Dans la liste des extensions, cherchez l’extension *Locale* et cliquez sur le bouton **Install**
* Une nouvelle page s’affiche vous invitant à sélectionner, dans une liste déroulante, la langue que vous souhaitez utiliser pour votre interface&#x202F;; une fois que vous avez choisi une langue, cliquez sur **Save changes**
* Automatiquement, l’interface est traduite dans la langue choisie, dans notre cas le français&#x202F;; si vous souhaitez traduire l’interface dans une autre langue ou revenir à l’anglais, cliquez sur **Configurer**.

## Ajouter un contenu à votre site

{% include figure.html filename="tr-fr-demarrer-avec-omeka-09.png" alt="Ajout d’un contenu" caption="Figure 9. Ajouter un contenu" %}

Cliquez sur **Contenus** à gauche du menu, puis sur **Ajouter un contenu**.

## Décrire un contenu

{% include figure.html filename="tr-fr-demarrer-avec-omeka-10.png" alt="Case à cocher permettant de rendre un contenu public" caption="Figure 10. Rendez votre contenu public en utilisant la case à cocher entourée sur l’image" %}

Pour rappel, Dublin Core fait référence aux métadonnées descriptives que vous renseignez à propos de votre contenu. Toutes les métadonnées sont optionnelles ; vous ne pouvez pas vraiment faire d’erreurs. Toutefois, essayez d’être constant.

Vérifiez que la case **Public** est cochée afin que votre contenu soit visible par le public de votre site. Si vous ne cochez pas cette case, seuls les utilisateurs et les utilisatrices qui seront connectés à votre site pourront le voir.

Pour ajouter plusieurs champs de métadonnées — par exemple, si vous souhaitez ajouter plusieurs mots-clés à votre contenu — cliquez sur le bouton **Ajouter une entrée** à gauche de l’éditeur de texte.

## Une question épineuse

{% include figure.html filename="or-en-up-and-running-11.png" alt="Photographie d’un chien appelé Bertie" caption="Figure 11. Qu’est-ce que c’est ?" %}

Imaginons que je crée un contenu pour mon chien, Bertie. Est-ce que je décris Bertie lui-même ou une photo de Bertie&#x202F;? Dans le premier cas, le **Créateur** serait... Eh bien, j’imagine que cela dépend de vos opinions religieuses. Dans le second cas, le créateur serait Brad Wallace, qui a pris la photo.

La décision de savoir si vous décrivez un objet ou sa représentation vous revient. Toutefois, une fois que vous vous êtes décidés, soyez constant.

## Ajouter un fichier à votre contenu

{% include figure.html filename="tr-fr-demarrer-avec-omeka-12.png" alt="Page permettant d’associer des fichiers à un contenu" caption="Figure 12. Ajouter des fichiers à un contenu" %}

Après avoir ajouté les métadonnées Dublin Core, vous pouvez associer à votre contenu un fichier en cliquant sur **Fichiers** en haut du formulaire Dublin Core. Il n’est pas nécessaire de cliquer sur **Ajouter un contenu** avant d’ajouter un fichier&#x202F;; Omeka enregistrera automatiquement les métadonnées. Vous pouvez ajouter plusieurs fichiers dans la limite des 500 MB de stockage autorisés par l’offre d’essai d’Omeka.

Une fois que vous avez ajouté un ou plusieurs fichiers, vous pouvez leur attribuer des **Mots-clés** en cliquant sur le bouton du même nom. Il est également possible de cliquer sur **Métadonnées du type de contenu** pour préciser la nature de votre contenu (personne, animal, végétal, minéral, lieu). Si vous ne trouvez pas de type approprié pour votre contenu, ne vous inquiétez pas. Vous pourrez en ajouter un nouveau plus tard.

Lorsque vous avez fini, cliquez sur le bouton vert **Ajouter un contenu**.

## Vous avez un contenu&#x202F;!

{% include figure.html filename="tr-fr-demarrer-avec-omeka-13.png" alt="Liste des contenus depuis la vue administrateur" caption="Figure 13. Parcourir les contenus (vue administrateur)" %}

Cette liste contient tous les contenus que vous avez créés. Si un contenu n’est pas public, la mention (Réservé) apparaîtra à côté de son titre. Pour voir à quoi ressemble la page de votre contenu, cliquez sur son nom.

## Ceci n’est pas la page publique de votre contenu

{% include figure.html filename="tr-fr-demarrer-avec-omeka-14.png" alt="Notice d’un contenu depuis la vue administrateur" caption="Figure 14. Affichage du contenu (vue administrateur)" %}

Contrairement aux apparences, ce n’est pas la page que vos utilisateurs et vos utilisatrices non connectés verront lorsqu’ils consulteront ce contenu sur votre site. Pour avoir un aperçu de l’affichage public, cliquez sur le bouton bleu **Voir la page publique**. Vous pouvez également éditer le contenu en cliquant sur **Modifier** au-dessus.

## Voici la page publique de votre contenu

{% include figure.html filename="tr-fr-demarrer-avec-omeka-15.png" alt="Notice d’un contenu sur le site public" caption="Figure 15. Affichage du contenu (vue publique)" %}

Voici ce que le public verra lorsqu’il consultera cette page.

## Créer une collection

{% include figure.html filename="tr-fr-demarrer-avec-omeka-16.png" alt="Création d’une collection" caption="Figure 16. Ajouter une collection" %}

Vous pouvez ordonner votre liste de contenus en les regroupant au sein d’une collection. Pour cela, retournez sur votre tableau de bord, cliquez sur **Collections**, puis sur **Ajouter une collection**.

## Décrire une collection

{% include figure.html filename="tr-fr-demarrer-avec-omeka-17.png" alt="Ajout de métadonnées à une collection" caption="Figure 17. Ajouter des métadonnées à la collection" %}

Dans Omeka, les métadonnées sont reines&#x202F;! Ajoutez des informations à propos de votre nouvelle collection. N’oubliez pas de cocher la case **Public**, à droite de l’écran. Enfin, sauvegardez votre collection.

## Ajouter des contenus à votre collection

{% include figure.html filename="tr-fr-demarrer-avec-omeka-18.png" alt="Ajout de contenus par lot à une collection" caption="Figure 18. Cliquez sur les cases à cocher des contenus à éditer par lot" %}

Pour compléter la collection que vous venez de créer, cliquez sur l’onglet **Contenus** dans le menu de navigation. Depuis la liste **Parcourir les contenus**, sélectionnez les contenus qui appartiennent à votre nouvelle collection, puis cliquez sur le bouton **Modifier**.

## Choisir une collection

{% include figure.html filename="tr-fr-demarrer-avec-omeka-19.png" alt="Association de plusieurs contenus à une collection" caption="Figure 19. Sélectionner une collection dans la liste déroulante" %}

Depuis la page **Edition par lot de contenus**, sélectionnez la collection à laquelle vous souhaiteriez ajouter vos contenus. (Prenez également note de tout ce que vous pouvez faire sur cette page.)

## Contrôler votre nouvelle collection

{% include figure.html filename="tr-fr-demarrer-avec-omeka-20.png" alt="Aperçu de la nouvelle collection sur le site public" caption="Figure 20. Parcourir les collections (vue publique)" %}

Retournez sur votre site public. Si vous cliquez sur l’onglet **Parcourir les collections**, vous devriez désormais avoir une nouvelle collection contenant les éléments que vous lui avez associés.

Maintenant que vous avez ajouté quelques contenus et que vous les avez regroupés dans des collections, prenez le temps de jouer avec votre site. Il commence à prendre forme maintenant que vous avez aussi bien des contenus individuels que des collections thématiques. Toutefois, Omeka permet de faire bien plus que cela, comme la création d'expositions virtuelles, présentée dans la leçon anglaise [Creating an Omeka Exhibit](https://programminghistorian.org/en/lessons/creating-an-omeka-exhibit).

## Pour aller plus loin
Les créateurs d’Omeka ont rassemblé de nombreuses ressources utiles sur les [pages d’aide officielles](https://info.omeka.net/help/) du logiciel. Le [forum](https://forum.omeka.org/) est un bon lieu pour poser des questions en anglais. Il existe également une association rassemblant [les usagers francophones d'Omeka](https://omeka.fr/) qui met à disposition une liste de discussion ([omekafr-asso](https://groupes.renater.fr/sympa/review/omekafr-asso)), propose de la documentation en français, une liste de projets utilisant ce *Content Management System* (CMS) et des informations relatives à la communauté francophone des utilisateurs et des utilisatrices d’Omeka.
