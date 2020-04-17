---
title: Une introduction aux Bots Twitter avec Tracery
layout: lesson
slug: intro-aux-bots-twitter
authors:
- Shawn Graham
date: 2017-08-29
reviewers:
- Lee Skallerup Bessette
- Adam Crymble
- Nick Ruest
editors:
- Jessica Parr
translator:
- Géraldine Castel
translation-editor: 
- Sofia Papastamkou
translation-reviewer:
- Antoine Courtin
- Sylvain Machefert 
translation_date: 2019-06-21
difficulty: 2
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/256
activity: presenting
topics: [api]
abstract: Cette leçon explique comment créer de simples bots Twitter à l'aide de Tracery et du service Cheap Bots Done Quick. Tracery est disponible dans plusieurs langues et peut être intégré dans des sites web, des jeux ou des bots.
original: intro-to-twitterbots
avatar_alt: A device with several interlocking gears

---

# Une introduction aux bots Twitter avec Tracery

Cette leçon explique comment créer des bots basiques sur Twitter à l’aide de la [grammaire générative Tracery](http://tracery.io) et du service [Cheap Bots Done Quick](http://cheapbotsdonequick.com/). Tracery existe dans de nombreuses langues et peut être intégré dans des sites web, des jeux ou des bots. Vous pouvez en faire une copie (fork) sur github [ici](https://github.com/galaxykate/tracery/tree/tracery2).

## Pourquoi des bots?
Pour être exact, un bot Twitter est un logiciel permettant de contrôler automatiquement un compte Twitter. Lorsque des centaines de bots sont créés et tweetent plus ou moins le même message, ils peuvent façonner le discours sur Twitter, ce qui influence ensuite le discours d’autres médias. Des bots de ce type [peuvent même être perçus comme des sources crédibles d’information](http://www.sciencedirect.com/science/article/pii/S0747563213003129). Des projets tels que [Documenting the Now](http://www.docnow.io/) mettent au point des outils qui permettent aux chercheur(e)s de créer et d’interroger des archives de réseaux sociaux en ligne à propos d’évènements récents qui comprennent très probablement un bon nombre de messages générés par des bots. Dans ce tutoriel, je veux montrer comment construire un bot Twitter basique afin que des historiens et des historiennes, ayant connaissance de leur fonctionnement, puissent plus facilement les repérer dans des archives et, peut-être, même les neutraliser grâce à leurs propres bots.
 
Mais je crois aussi qu’il y a de la place en histoire numérique et dans les humanités numériques de façon plus large pour un travail créatif, expressif, voire artistique. Les historiens et les historiennes qui connaissent la programmation peuvent profiter des possibilités offertes par les médias numériques pour monter des créations autrement impossibles à réaliser pour nous émouvoir, nous inspirer, nous interpeller. Il y a de la place pour de la satire, il y a de la place pour commenter. Comme Mark Sample, je crois qu’il y a besoin de '[bots de conviction](https://medium.com/@samplereality/a-protest-bot-is-a-bot-so-specific-you-cant-mistake-it-for-bullshit-90fe10b7fbaa)'.
Ce sont des bots de contestation, des bots si pointus et pertinents, qu’il devient impossible de les prendre pour autre chose par erreur. Selon Sample, il faudrait que de tels bots soient:

- **d’actualité**: &laquo; Ils traitent les informations du matin et les horreurs qui ne font pas la une des journaux &raquo;.

- **factuels**: &laquo; Ils s’appuient sur de la recherche, des statistiques, des tableurs, des bases de données. Les bots n’ont pas de subconscient. S’ils utilisent des images, elles sont à prendre au pied de la lettre &raquo;.

- **cumulatifs**: &laquo; La répétition s’auto-alimente, le bot reprend le même air encore et encore, imperturbable et inébranlable, empilant les débris sur nos écrans &raquo;.

- **partisans**: &laquo; Les bots de contestation sont engagés. La société étant ce qu’elle est, ce parti pris sera probablement mal vu, peut-être même déstabilisant &raquo;.

- **déroutants**:&laquo; La révélation de ce que nous voulions dissimuler &raquo;.

Je veux voir plus de bots de contestation, des bots qui nous placent face à des vérités implacables, des bots qui, dans leur persévérance dépourvue d'humanité, réclament justice. [_Every 3 minutes_](https://twitter.com/Every3Minutes) de Caleb McDaniel nous fait honte en nous rappelant sans cesse que toutes les trois minutes, un être humain était vendu en esclavage dans le sud des États-Unis avant la guerre civile.

{% include figure.html filename="bot-lesson-every3minutes.png" caption="Capture d'écran de la page Twitter de Every3Minutes" %}

_À lui tout seul, every3minutes justifie la création d’un bot en histoire_.

Pour entamer la réflexion, voici quelques suggestions de personnes sur Twitter qui m’ont répondu lorsque j’ai demandé à quoi pourraient ressembler des bots de conviction en histoire et archéologie: 

> @electricarchaeo un bot qui tweeterait des images en haute résolution issues du patrimoine culturel rendues inaccessibles par des visionneuses en mosaïque et des appropriations de droits d’auteur frauduleuses de la part des institutions où elles se trouvent ?
— Ryan Baumann (@ryanfb) 22 avril 2017

> @electricarchaeo Un bot qui tweeterait des images de lieux sacrés amérindiens profanés au nom de la cupidité des entreprises.
— Cory Taylor (@CoryTaylor_) 22 avril 2017

> @electricarchaeo Un bot qui référencerait les actifs historiques bénéficiant d’une exemption d’impôt sur la succession car supposés être « accessibles » au public
— Sarah Saunders (@Tick_Tax) 22 avril 2017

> @electricarchaeo Un bot qui tweeterait le nom d’esclaves ayant appartenu à des universités prestigieuses ou ayant participé à la construction de bâtiments gouvernementaux tels que la maison blanche.
— Cory Taylor (@CoryTaylor_) 22 avril 2017

> @electricarchaeo A chaque fois que quelqu’un dirait « depuis la nuit des temps, les humains ont », un bot qui répondrait automatiquement CONNERIES.
— Colleen Morgan (@clmorgan) 22 avril 2017

> @electricarchaeo Un bot qui imaginerait la réaction d’afghans, d’irakiens, de syriens, de yéménites quand des membres de leur famille sont tués dans des attaques de drones. 
— Cory Taylor (@CoryTaylor_) 22 avril 2017

Dans la mesure où beaucoup de données historiques en ligne sont disponibles en format [JSON](http://json.org/), en cherchant un peu, vous devriez en trouver à utiliser avec votre bot.

Ma méthode est celle du bricoleur, quelqu’un qui adapte et assemble des morceaux de code trouvés ici et là ; en vérité, la programmation fonctionne en grande partie comme ça. Il existe beaucoup de logiciels pour interagir avec l’API (interface de programmation d'application) de Twitter. Dans cette leçon, il y aura peu de &laquo; programmation &raquo;. Les bots ne seront pas écrits en Python, par exemple. Dans cette leçon d’introduction, je vais vous montrer comment construire un bot qui raconte des histoires, qui compose de la poésie, qui fait des choses merveilleuses à l’aide de Tracery.io comme _grammaire générative_ et du service Cheap Bots Done Quick comme hébergeur du bot. Pour davantage de tutoriels pour apprendre à construire et héberger des bots Twitter sur d’autres services, voir [la liste de tutoriels de Botwiki](https://botwiki.org/tutorials/twitterbots/) (en anglais).

Celui de mes bots qui a connu le plus de succès est [@tinyarchae](http://twitter.com/tinyarchae), un bot qui tweete des scènes de dysfonctionnements au sein d’un horrible projet d’excavation archéologique. Tout projet archéologique est confronté à des problèmes de sexisme, d’insultes, de mauvaise foi. Ainsi, @tinyarchae prend tout ce qui se murmure dans les colloques et le pousse à l’extrême. C’est, en réalité, une caricature qui comporte une part de vérité embarrassante. D’autres bots que j’ai construits détournent de la [photographie archéologique] https://twitter.com/archaeoglitch); l’un est même utile puisqu’il [annonce la sortie de nouveaux articles de revues en archéologie] (https://twitter.com/botarchaeo) et fait donc office d’assistant de recherche. Pour plus de réflexions sur le rôle joué par les bots en archéologie publique, voir ce [discours inaugural](https://electricarchaeology.ca/2017/04/27/bots-of-archaeology-machines-writing-public-archaeology/) tiré du [colloque Twitter sur l’archéologie publique](http://web.archive.org/web/20180131161516/https://publicarchaeologyconference.wordpress.com/)).

# Préparation : que fera votre bot ?

Commençons avec un bloc-notes et du papier. À l'école primaire, une activité que nous faisions souvent pour apprendre les bases de la grammaire anglaise s'appelait " mad-libs " (des improvisations un peu folles). L'enseignant en charge de l’activité demandait par exemple à la classe de donner un nom, puis un adverbe, puis un verbe, puis un autre adverbe. Puis, de l'autre côté de la feuille, il y avait une histoire avec des espaces vides du type :

"Susie la \_nom\_ était \_adverbe\_  \_verbe\_ le \_nom\_."

et les élèves remplissaient les blancs comme demandé. C'était un peu bête et, surtout, c'était amusant. Les Twitterbots sont à ce type d'improvisation ce que les voitures de sport sont aux attelages de chevaux. Les blancs à remplir pourraient, par exemple, être des valeurs dans des graphiques vectoriels svg. Il pourrait s'agir de nombres dans des noms de fichiers numériques (et donc de liens aléatoires vers une base de données ouverte, par exemple). Cela pourrait même être des noms et des adverbes. Comme les bots Twitter vivent sur le web, les blocs de construction à assembler peuvent être autre chose que du texte (même si, pour l'instant, le texte est le plus facile à utiliser).

Nous allons commencer par esquisser une *grammaire de remplacement*. Cette grammaire s’appelle [Tracery.io](http://tracery.io) et ses conventions ont été développées par Kate Compton ([@galaxykate](https://twitter.com/galaxykate) sur Twitter). Elle s’utilise comme une bibliothèque javascript dans des pages web, des jeux, et des bots. Une grammaire de remplacement fonctionne en grande partie comme les improvisations ci-dessus.

*Afin de clarifier d'abord ce que fait la _grammaire_, nous n'allons _pas_ créer un bot en histoire pour l'instant. Je veux expliquer clairement ce que fait la grammaire, et nous allons donc construire quelque chose de surréaliste pour montrer comment cette grammaire fonctionne.*
Imaginons que vous souhaitiez créer un bot qui parle avec la voix d'une plante en pot - appelons-le, _PlanteEnPotBot_. Que pourrait bien dire _PlanteEnPotBot_? Notez quelques idées.

- Je suis une plante en pot. C’est vraiment ennuyeux !
- S'il vous plaît, arrosez-moi. Je vous en supplie.
- Ce pot. Il est si petit. Mes racines sont tellement à l'étroit !
- Je me suis tournée vers le soleil. Mais ce n'était qu'une ampoule.
- Je suis si seule. Où sont toutes les abeilles ?

Voyons maintenant comment ces phrases ont été construites. Nous allons remplacer les mots et les phrases par des _symboles_ afin de pouvoir renouveler les phrases d’origine. Il y a pas mal de phrases qui commencent par &laquo; je &raquo;. Nous pouvons commencer à réfléchir à un _symbole_ pour &laquo; être &raquo;:
```
"être": "suis une plante", "vous en supplie", "suis tellement seule", "me suis tournée vers le soleil"
"being": "am a plant","am begging you","am so lonely","turned towards the sun"

```

Cette notation nous dit que le symbole "être" est équivalent, ou qu'il peut être remplacé par les expressions "suis une plante", "vous en supplie" et ainsi de suite.

Nous pouvons mélanger les symboles et le texte, dans notre bot. Si nous disons au bot de commencer par le mot "je", nous pouvons insérer le _symbole_"être" après celui-ci et compléter la phrase par "suis une plante" ou "me suis tournée vers le soleil" et la phrase sera _grammaticalement_ correcte. Construisons un autre symbole ; appelons le, pourquoi pas, 'endroitoù' :
```

" endroitoù ": "dans un pot", "sur le bord de la fenêtre", "tombé"
"placewhere": "in a pot","on the windowsill","fallen over"
```
("endroitoù " est le _symbole_ et "dans un pot" etc… sont les _règles_ qui le remplacent)

Dans les phrases de notre brainstorming, nous n'avons jamais utilisé l'expression " sur le bord de la fenêtre ", mais une fois que nous avons identifié " dans un pot ", d'autres équivalences possibles surgissent. Notre bot va par la suite utiliser ces _symboles_ pour faire des phrases. Les symboles -'être','endroitoù' - sont comme nos impros où il fallait une liste de noms, d'adverbes et ainsi de suite. Imaginons alors transmettre à notre bot l’expression suivante : 
```
"Je #être# #endroitoù#"
"I #being# #placewhere#"
```

Les résultats possibles seront :

- Je me sens si seule sur le bord de la fenêtre.
- Je me sens si seule dans un pot
- Je me suis tournée vers le soleil tombée

En bricolant, et en décomposant les unités d'expression en symboles plus petits, on peut corriger toute maladresse d'expression (ou même décider de les laisser pour rendre la voix plus 'authentique').

## Prototypage à l’aide d’un éditeur Tracery
Un éditeur Tracery est disponible ici : [www.brightspiral.com/tracery/](http://www.brightspiral.com/tracery). Nous l'utiliserons pour rectifier les imperfections de _plantpotbot_. L'éditeur visualise la façon dont les symboles et les règles de la grammaire interagissent (la façon dont ils sont imbriqués, et le type de résultats que votre grammaire va générer). Ouvrez l'éditeur dans une nouvelle fenêtre. Vous devriez voir ça :

{% include figure.html filename="bot-lesson-editor.png" caption="L'éditeur Tracery sur Brightspiral.com" %}

Le menu déroulant en haut à gauche, marqué 'tinygrammar', contient d'autres exemples de grammaires que l'on peut explorer ; ils montrent à quel point Tracery peut devenir complexe. Pour l'instant, conservez " tinygrammar ". L'un des avantages de cet éditeur est que vous pouvez appuyer sur le bouton 'Afficher les couleurs', qui va coder chaque symbole et ses règles, en codant par couleur le texte généré afin que vous puissiez voir quel élément appartient à quel symbole.

Si vous double-cliquez sur un symbole dans la grammaire par défaut (`name'/nom ou `occupation'/profession) et que vous appuyez sur la touche **Supprimer**, vous enlèverez ce symbole de la grammaire. Faites-le pour "name"/nom et "occupation"/profession, en ne laissant que "origin"/origine. Maintenant, ajoutez un nouveau symbole en cliquant sur le bouton 'new symbol'/nouveau symbole. Cliquez sur le nom (`symbol1`) et renommez-le `être`. Cliquez sur le signe " + " et ajoutez certaines de nos règles ci-dessus. Répétez l'opération pour un nouveau symbole appelé " endroitoù".

{% include figure.html filename="bot-lesson-plantbot.png" caption="Construction de la grammaire pour plantpotbot" %}

À ce moment-là, l'éditeur affichera un message d'erreur en haut à droite, 'ERREUR : symbole 'name' non trouvé dans tinygrammar'. C'est parce que nous avons supprimé `name', mais le symbole ‘origin' a parmi ses règles le symbole `name` ! C'est intéressant : cela nous montre que nous pouvons _imbriquer_ des symboles dans des règles, n'est-ce pas ? Nous pourrions avoir un symbole appelé " character "/personnage, et le personnage pourrait avoir des sous-symboles appelés " first name "/prénom, " last name "/ nom de famille et " occupation " (et chacun d'eux contiendrait une liste de prénoms, noms et professions). Chaque fois que la grammaire serait exécutée, vous obtiendriez par exemple 'Shawn Graham Archéologue' stocké dans le symbole 'personnage'.

Une autre chose intéressante ici, c'est que `origin' est un symbole spécial. C'est celui à partir duquel le texte est généré à la fin (la grammaire est ici _aplatie_). Changeons donc la règle du symbole d'origine pour que _plantpotbot_ puisse parler. (Lorsque vous faites référence à un autre symbole à l'intérieur d'une règle, vous l'entourez de marques " # ", donc vous devriez avoir : " #être#  #endroitoù# ").

Il manque encore quelque chose - le mot "je". Vous pouvez mélanger du texte ordinaire dans les règles. Faites-le maintenant - appuyez sur le `+' à côté de la règle pour le symbole `origin', et ajoutez le mot 'je' pour que ‘origin’ affiche maintenant `Je#être#  #endroitoù##`. Peut-être que votre plantbot parle avec une diction poétique en inversant `#endroitoù# et #être#`.

Si vous appuyez sur 'enregistrer' dans l'éditeur, votre grammaire sera horodatée et apparaîtra dans la liste déroulante des grammaires. Elle sera sauvegardée dans le cache de votre navigateur ; si vous videz le cache, vous la perdrez.

Avant de poursuivre, il y a une dernière chose à examiner. Appuyez sur le bouton JSON dans l'éditeur. Vous devriez voir quelque chose comme ça :

```JSON
{
	"origin": [
		"I #being# #placewhere#"
	],
	"being": [
		"am so lonely",
		"am so lonely",
		"am begging you",
		"am turned towards the sun"
	],
	"placewhere": [
		"in a pot",
		"in a windowsill",
		"fallen over"
	]
}
```

Chaque grammaire Tracery est en fait un objet JSON composé de paires clé/valeur, ce que Tracery appelle symboles et règles. (Pour plus d'informations sur JSON, voir [ce tutoriel de Matthew Lincoln](/lessons/json-and-jq)). C'est le format que nous utiliserons lorsque nous configurerons notre bot pour commencer à tweeter. Le JSON est tatillon. Vous remarquerez que les symboles sont entourés de `"`, tout comme les règles, mais les règles sont également énumérées par des virgules `[`et `]`. Souvenez-vous :

```JSON
{
  "symbole": ["règle"," règle "," règle "],
  "autresymbole": ["règle"," règle "," règle "],
}
```

```JSON
{
  "symbol": ["rule","rule","rule"],
  "anothersymbol": ["rule,","rule","rule"]
}
```

(bien sûr, le nombre de symboles et de règles est sans importance, mais veillez à ce que les virgules soient correctes !)

C'est une bonne pratique de copier ce JSON dans un éditeur de texte et d'enregistrer une copie dans un endroit sûr.

## Mais à quoi pourrait bien ressembler un 'historybot' ?

Maintenant, refaites l'exercice ci-dessus, mais réfléchissez bien à ce à quoi pourrait ressembler un bot en histoire étant donné les contraintes de Tracery. Construisez une grammaire simple pour exprimer cette idée, et veillez à bien la sauvegarder. Voici d'autres éléments à prendre en compte lors de la conception de votre grammaire :

Ce qui est marrant avec les bots Twitter, c’est qu’ils se placent au hasard entre d’autres tweets sur votre fil d’actualité (Il vous faut suivre votre propre bot, pour garder un œil sur ce qu’il fait) :

{% include figure.html filename="bot-lesson-maniacallaughbot.jpg" caption="Maniacallaughbot a encore gagné" %}

N'oubliez pas que votre bot apparaîtra sur le fil d'autres personnes. Le potentiel de juxtaposition du ou des messages de votre bot avec les tweets d'autres personnes influencera également le succès relatif du bot.

{% include figure.html filename="bot-lesson-interaction-with-tinyarchae.png" caption="Une interaction avec Tinyarchae occasionne des réflexions wistful" %}


# Créez un compte Twitter pour votre bot et connectez-le à Cheap Bots Done Quick

Vous pouvez associer un bot à votre propre compte, mais vous ne voulez probablement pas qu'un bot tweete _en_votre_nom_ ou _pour_vous_. Dans ce cas, créez un nouveau compte Twitter. Lorsque vous créez un nouveau compte, Twitter vous demande une adresse e-mail. Vous pouvez utiliser une nouvelle adresse ou, si vous avez un compte Gmail, vous pouvez utiliser l'astuce `+tag', c'est-à-dire qu'au lieu de 'johndoe' @gmail, vous utilisez `johndoe+twitterbot` @gmail. Twitter l’acceptera comme un courriel différent de votre courriel habituel.

Normalement, quand on construit un Twitterbot, il faut créer une application sur Twitter (sur [apps.twitter.com](http://apps.twitter.com)), obtenir les clés d'accès d'utilisateur de l'API, ainsi que le *token* (jeton). Ensuite, vous devez programmer l'authentification pour que Twitter sache que le programme essayant d'accéder à la plate-forme est autorisé.

Heureusement, nous n'avons pas à le faire, puisque George Buckenham a créé le site d'hébergement de bot '[Cheap Bots Done Quick](http://cheapbotsdonequick.com/)'. (Ce site Web montre également la grammaire source en JSON pour un certain nombre de bots différents, ce qui peut donner des idées). Une fois que vous avez créé le compte Twitter de votre bot - et que vous êtes connecté à Twitter en tant que compte du bot - allez sur Cheap Bots Done Quick et cliquez sur le bouton 'Connexion avec Twitter'. Le site vous redirigera vers Twitter pour approuver l'autorisation, puis vous ramènera à Cheap Bots Done Quick.

Le JSON qui décrit votre bot peut être rédigé ou collé dans la case blanche principale. Prenez le JSON dans l'éditeur et collez-le dans la case blanche principale. S'il y a des erreurs dans votre JSON, la fenêtre de résultat en bas deviendra rouge et le site essaiera de vous indiquer ce qui pose problème. Dans la plupart des cas, ce sera à cause d'une virgule ou d'un guillemet erroné. Si vous cliquez sur le bouton **Actualiser** à droite de la fenêtre de résultat (PAS le bouton Actualiser du navigateur !), le site va générer un nouveau texte à partir de votre grammaire.

{% include figure.html filename="bot-lesson-cbdq.png" caption="L'interface de The Cheap Bots Done Quick" %}

Sous la fenêtre JSON se trouvent quelques paramètres qui déterminent la fréquence à laquelle votre bot tweetera, si votre grammaire source sera visible pour les autres, et si votre bot répondra ou non aux messages ou mentions :

{% include figure.html filename="bot-lesson-settings.png" caption="Les paramètres de votre bot" %}

Décidez à quelle fréquence vous voulez que votre bot tweete, et si vous voulez que la grammaire source soit visible. Ensuite... le moment de vérité. Appuyez sur le bouton 'tweet', puis allez vérifier le flux Twitter de votre bot. Cliquez sur 'Save' (Enregistrer).

Félicitations, vous venez de construire un bot Twitter.

## Code de bonne conduite

Comme Cheap Bots Done Quick est un service fourni par George Buckenham dans un esprit de bonne volonté, n'utilisez pas ce service pour créer des bots qui sont offensants ou injurieux ou qui pourraient gâcher le service pour tout autre utilisateur. Comme il l'écrit,

> Si vous créez un bot que je juge injurieux ou désagréable d'une manière ou d'une autre (par exemple, en @mentionnant des personnes qui n'ont pas donné leur consentement, en publiant des insultes ou en proférant des calomnies) je le retirerai.

Darius Kazemi, l'un des grands artistes du bot, donne d'autres conseils en matière de bonnes pratiques liées aux bots [ici](http://tinysubversions.com/2013/03/basic-twitter-bot-etiquette/).

# Aller plus loin avec Tracery
Beaucoup de bots sont beaucoup plus compliqués que ce que nous avons décrit ici, mais c'est suffisant pour vous permettre de commencer. Des bots étonnamment efficaces peuvent être créés en utilisant Tracery.

## Changer des symboles

Tracery est assez intelligent pour savoir comment mettre les mots au pluriel ou en majuscules. Cela signifie que vous pouvez fournir le mot de base dans une règle, puis ajouter des modificateurs le cas échéant. 
Prenez par exemple

```
"origin":["#size.capitalize# #creature.s# are nice"]
"size":["small","big","medium"]
"creature":["pig","cow","kangaroo"]
```

"origine":["#taille.majucule# #créature.s# sont chouettes"]
"taille":["petit","grand","moyen"]
"créature":["cochon","vache","kangourou"]


Ce qui permettrait de créer des phrases comme:

`Big cows are nice`/Les grosses vaches sont chouettes

`Small pigs are nice`/Les petits cochons sont chouettes

Les modificateurs `.majuscule' et `.s' sont ajoutés à l'intérieur du `#' du symbole qu'ils sont destinés à modifier. D'autres modificateurs sont `.ed' pour le passé, et `.a' pour a/an. Il y en a peut-être plus ; Tracery est un travail en cours.

## Utiliser des emoji

Les Emoji peuvent être utilisés avec beaucoup d'efficacité dans des bots Twitter. Vous pouvez copier et coller des emoji directement dans l'éditeur Cheap Bots Done Quick ; chaque emoji doit être entre guillemets comme toute autre règle. Utilisez [cette liste](http://unicode.org/emoji/charts/full-emoji-list.html) pour trouver les emoji que vous souhaitez utiliser, et veillez à copier/coller vos emoji depuis la colonne Twitter pour vous assurer que votre emoji va bien s'afficher.

## Réutilisation de symboles générés avec Actions

Cette fonctionnalité ne serait probablement pas très utile dans le cas d'un Twitterbot, mais si Tracery était employé pour générer une histoire ou un poème plus long, elle pourrait être utilisée pour que Tracery se rappelle la première fois où une règle particulière a été affectée à un symbole - par exemple nous pourrions faire en sorte que la même créature soit toujours utilisée lors de chaque appel suivant de `creature'. C'est ce que Tracery appelle une " action ". Le formulaire est #[someAction]someSymbol#. Cela peut prêter à confusion, et cet aspect de Tracery est encore en cours de développement. Pour le voir en action, copiez-collez le JSON ci-dessous dans cet éditeur Tracery de Beau Gunderson : [https://beaugunderson.com/tracery-writer/](https://beaugunderson.com/tracery-writer/) (sélectionner et supprimer le texte par défaut. L'éditeur Tracery utilisé précédemment ne gère pas très bien la sauvegarde des données, donc cette alternative est un meilleur outil pour nos besoins actuels).


```JSON
{
	"size": [
		"small",
		"big",
		"medium"
	],
	"creature": [
		"pig",
		"cow",
		"kangaroo"
	],
	"poem":["My pet #animalfriend# was a very #animalfriendsize# #animalfriend# indeed. My #animalfriend# was named Lucky"],
 	 "origin":["#[animalfriend:#creature#][animalfriendsize:#size#]poem#"]

}
```

"JSON
{
	"taille" : [
		"petit",
		"Gros",
		"Moyen"
	],
	"créature" : [
		"cochon",
		"vache",
		"kangourou"
	],
	"Poème" :["Mon animal de compagnie #animalami# était un très #animalamitaille# #animalami# #animalami# en effet. Mon #animalami# s'appelait Lucky"],
 	 "Origine" :["#[animalami:#créature#][animalamitaille:#taille#]poème#"]

}
```

Un autre exemple un peu plus complexe est le numéro 5 sur le site du tutoriel de Kate Compton à l'adresse [http://www.crystalcodepalace.com/traceryTut.html](http://www.crystalcodepalace.com/traceryTut.html) :

```JSON
{
	"name": ["Arjun","Yuuma","Darcy","Mia","Chiaki","Izzi","Azra","Lina"]
,	"animal": ["unicorn","raven","sparrow","scorpion","coyote","eagle","owl","lizard","zebra","duck","kitten"]
,	"mood": ["vexed","indignant","impassioned","wistful","astute","courteous"]
,	"story": ["#hero# traveled with her pet #heroPet#.  #hero# was never #mood#, for the #heroPet# was always too #mood#."]
,	"origin": ["#[hero:#name#][heroPet:#animal#]story#"]

}
```


"JSON
{
	"nom" : "Arjun, Yuuma, Darcy, Mia, Chiaki, Izzi, Azra, Lina.
"animal" : "licorne ", " corbeau ", " moineau ", " scorpion ", " coyote ", " aigle ", " hibou ", " lézard ", " zèbre ", " canard ", " chaton "].
"humeur" : "vexé", "indigné", "passionné", "nostalgique", "astucieux", "courtois"]
,	"histoire": ["#héro# a voyage avec son animal de compagnie #héroanimaldecompagnie#.  #héro# n’était jamais #humeur#, car l’ #animaldecompagnie# était toujours trop #humeur#."]
,	"origine": ["#[héro:#nom#][héroAnimaldecompagnie:#animal#]histoire#"]

}
```


Tracery lit l'origine, et avant d'arriver au symbole " histoire ", il voit une action appelée " héros " qu'il définit à partir du symbole " nom ". Il fait la même chose pour `héroanimaldecompagnie' à partir d'`animal'. Avec ces ensembles, il lit alors l’"histoire". Dans l’`histoire' le symbole `héro' lit ce qui vient d'être défini par l'action, et retourne la même valeur à chaque fois. Donc, si 'Yuuma' a été sélectionné par l'action, l'histoire dira 'Yuuma a voyagé avec son animal de compagnie.... Yuuma n'a jamais...``. Si nous n'avions pas défini le nom du héros via l'action, alors l'histoire générée pourrait changer le nom du héros au milieu de l'histoire !


## Répondre à des mentions dans Cheap Bots Done Quick

[Cheap Bots Done Quick](http://cheapbotsdonequick.com/) possède une fonctionnalité bêta qui permet à votre robot de répondre aux mentions. (Attention : si vous créez deux bots, et que l'un mentionne l'autre, la 'conversation' qui s'ensuit peut durer très longtemps ; il y a 5% de chances dans tout échange que le bot ne réponde pas, interrompant ainsi la conversation).

Pour configurer un modèle de réponse, cliquez au bas de la page pour paramétrer le bouton pour 'répondre aux tweets'. Dans la boîte d'édition JSON qui apparaît, configurez le modèle pour les phrases auxquelles votre bot va répondre. Par exemple, une partie de ce que @tinyarchae détecte :

```JSON
{
	"hello":"hello there!",
	"What|what":"#whatanswer#",
	"Who|who":"#whoanswer#",
	"When|when":"#whenanswer#",
	"Where|where":"#whereanswer#.",
	"Why|why":"#whyanswer#",
	"How|how":"#howanswer#",
	"Should|should|Maybe|maybe|if|If":"#shouldanswer#"
}
```

```JSON
{
	"hello":"hello!",
	"Quoi|quoi":"#quoiréponse#",
	"Qui|qui":"#quiréponse#",
	"Quand|quand":"#quandréponse#",
	"Où|où":"#oùréponse#.",
	"Pourquoi|pourquoi":"#pourquoiréponse#",
	"Comment|comment":"#commentréponse#",
	"Devrait|devrait|Peut-être|peut-être|Si|si":"#devraitréponse#"
}
```

Les symboles ici peuvent inclure des motifs d'expressions régulières (Regex) (voir[cette leçon](/lessons/understanding-regular-expressions) sur les expressions régulières). Ainsi, dans l'exemple ci-dessus, le dernier symbole recherche " Devrait " OU " devrait " OU " devrait " OU " peut-être " OU " peut-être " OU " si " OU " SI ". Pour répondre à tout ce qu'on lui lance, le symbole serait le point : `.`'. Les règles peuvent inclure du texte simple (comme dans la réponse à "hello") ou peuvent être un autre symbole. Les règles doivent être incluses dans votre grammaire principale dans la première case d'édition JSON de la page. Ainsi, `#shouldanswer#` est dans la case principale de l'éditeur de grammaire @tinyarchae sous la forme d'une ligne :

```JSON
"shouldanswer":["We asked #name#, who wrote 'An Archaeology of #verb.capitalize#'. The answer is #yesno#.","This isn't magic 8 ball, you know.","This is all very meta, isn't it.","#name# says to tell you, '42'."],
```

"JSON
"devraitrépondre" :["Nous avons demandé à #nom#, qui a écrit'Une Archéologie de #verbe.majuscule#'. La réponse est #ouinon#.", "Ce n'est pas la boule magique 8, vous savez.", "Tout cela est très méta, n'est-ce pas.", "#nom# dit de vous dire],'42'."],


Tout en bas de la page, vous pouvez tester vos mentions en écrivant un exemple de tweet que votre bot va analyser. Si vous avez bien configuré les choses, vous devriez voir une réponse. S'il y a une erreur, la case 'Réponse' devient rouge et vous indique où se trouve l'erreur.

{% include figure.html filename="bot-lesson-response.png" caption="Tester la réponse du bot" %}

## Graphiques SVG
Puisque le SVG est un format de texte qui décrit la géométrie d'un graphique vectoriel, Tracery peut être utilisé pour réaliser un travail plutôt artistique - le bot [Tiny Space Adventure] (https://twitter.com/TinyAdv) dessine un champ d'étoiles, un vaisseau spatial et un descriptif. Sa grammaire [peut être consultée ici] (https://pastebin.com/YYtZnzZ0). Le problème principal avec la génération de .svg avec Tracery, c'est que les composants soient corrects. Le code source du [bot softlandscapes](http://cheapbotsdonequick.com/source/softlandscapes) peut constituer un modèle utile. Ce bot commence par définir le texte critique qui délimite le SVG : 

```
"origine2": ["#préface##defs##bg##montagnes##nuages##fin#"],
"préface":"{svg <svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" height=\"#baseh#\" width=\"#basew#\">"
```
puis :

```
"fin":"</svg>}"
```


```
"origin2": ["#preface##defs##bg##mountains##clouds##ending#"],
"preface":"{svg <svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" height=\"#baseh#\" width=\"#basew#\">"
```
et ensuite :

```
"ending":"</svg>}"
```

Travailler en SVG peut être délicat, car des éléments comme les barres obliques inverses, les fins de ligne, les guillemets et ainsi de suite doivent être adaptées (escaped) pour fonctionner correctement. Comme le dit le site,

> La syntaxe ressemble à ceci : {svg <svg <svg ...> .... </svg>}. Les SVG devront spécifier un attribut de largeur et de hauteur. Notez que les fichiers SVG doivent être terminés (escaped) par \\\", idem pour les \\#s (\\\#). Les {s et les }s peuvent être complétés (escaped) par \\\\{ et \\\\}.
Note : cette fonctionnalité est encore en développement, le bouton tweet sur cette page ne fonctionnera donc pas. Et les informations de débogage sont meilleures dans FF que dans d'autres navigateurs.

Les bots qui génèrent du SVG dépassent le cadre de cette leçon, mais une étude minutieuse des bots existants devrait vous aider si vous souhaitez approfondir cette question.

## Musique
À proprement parler, il ne s'agit plus de bots, mais comme la musique peut être écrite en texte, on peut utiliser Tracery pour composer de la musique et utiliser d'autres bibliothèques pour convertir cette notation en fichiers Midi - voir [http://www.codingblocks.net/videos/generating-music-in-javascript/](http://www.codingblocks.net/videos/generating-music-in-javascript/) et ma [propre expérience](https://electricarchaeology.ca/2017/04/07/tracery-continues-to-be-awesome/).

# Autres tutoriels de bots
- Zach Whalen [Comment faire un bot Twitter à partir du tableur de Google](http://www.zachwhalen.net/posts/how-to-make-a-twitter-bot-with-google-spreadsheets-version-04/)
- Plus d’informations sur Tracery & les Twitterbots [http://cmuems.com/2015b/tracery-twitterbots/](http://cmuems.com/2015b/tracery-twitterbots/)
- Casey Bergman, Suivre la littérature scientifique à l'aide de Twitterbots : L'expérience FlyPapers https://caseybergman.wordpress.com/2014/02/24/keeping-up-with-the-scientific-literature-using-twitterbots-the-flypapers-experiment/ mais aussi https://github.com/roblanf/phypapers ; Cette méthode consiste en fait à collecter le flux RSS des articles de revues, puis à utiliser un service tel que [Dlvr.it](https://dlvrit.com/) pour rediriger les liens vers un compte Twitter.
- Stefan Bohacek a posté les modèles de code pour différents types de bots sur le site de remixage de code [Glitch.com] (https://stefan.glitch.me/). Si vous vous rendez sur sa page, vous verrez une liste de différents types de bots ; cliquez sur le bouton 'remix' puis étudiez attentivement le bouton 'lisez-moi'. Glitch nécessite une identification (login) via un compte Github ou Facebook.
- Enfin, je suggère de rejoindre le groupe BotMakers Slack pour trouver d'autres tutoriels, des personnes partageant les mêmes intérêts, et d'autres ressources : [Inscrivez-vous ici](https://botmakers.org)
- Le Wiki des Botmakers' propose également une liste de [tutoriels sur des bots Twitter](https://botwiki.org/tutorials/twitterbots/)

Enfin, voici une liste de bots fonctionnant avec Tracery tenue à jour par Compton [ici] (https://twitter.com/GalaxyKate/lists/tracery-bots). Amusez-vous bien ! Que vos bots déconcertent, divertissent, inspirent et déroutent.

# Références
Compton, K., Kybartas, B., Mateas, M.: "Tracery: An author-focused generative text tool". In:* Proceedings of the 8th International Conference on Interactive Digital Storytelling*. pp. 154–161 (2015)
