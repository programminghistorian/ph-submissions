---
title: Generadores de texto usando imágenes y gramáticas libres de contexto en Aventura.js
collection: lessons
layout: lesson
slug: generadores-aventura
date:
translation_date:
authors:
- Sergio Rodríguez Gómez
reviewers:
editors:
- Nicolás Llano Linares
translator:
translation-editor:
translation-reviewer:
original:
review-ticket:
difficulty:
activity:
topics:
abstract: "Esta lección te permite enseña a crear generadores de texto e imágenes usando la librería Aventura.js para el lenguaje de programación JavaScript"
---

# Table of Contents

{% include toc.html %}

--
# Generadores de texto usando imágenes y gramáticas libres de contexto en Aventura.js

## Introducción

Además de permitir procesos como el almacenamiento masivo de archivos o el análisis algorítmico de objetos culturales, las herramientas digitales ofrecen oportunidades para desarrollar ideas creativas por medio de la computación. La creatividad computacional puede entenderse como un ejercicio expresivo con el que es posible crear texto, sonido, imagen, o video, entre otros medios, a través del código, los algoritmos y las interfaces digitales. Esta forma de expresión puede resultar útil para las artes y las humanidades de muchas maneras: como un medio de indagación ingeniosa de un objeto o un fenómeno cultural, como una forma atractiva de divulgación y comunicación de una investigación para un público general, o como una exploración individual o colectiva que permita interpretaciones artísticas de un tema de interés.
Siguiendo esta línea, esta lección explica cómo desarrollar una forma particular de creatividad computacional: crear generadores de texto e imágenes —mediante un sistema algorítmico denominado gramáticas libres de contexto— usando la librería Aventura.js para el lenguaje de programación JavaScript. Primero, para situarnos, hablaremos de la literatura electrónica, luego veremos en qué consisten este tipo de gramáticas y generadores, y posteriormente descubriremos paso a paso cómo crear un generador de poemas y otro de collages a partir de un archivo textual y de un archivo de imágenes.

## La literatura electrónica

La literatura electrónica hace uso de herramientas computacionales y código de programación para la producción de obras literarias, y es por lo tanto un ejercicio de creatividad computacional. Estas obras pueden involucrar procesos digitales tanto en su forma de producción, es decir en la manera como se construye y se compone el texto, como en su lectura, es decir, en la manera como la audiencia navega el texto y recorre las partes de la estructura narrativa. Por ejemplo, en el primer caso, un generador automático de textos, como los que encontramos en los bots de la red social Twitter, podría componer las partes del texto a través de un sistema de reglas definido algorítmicamente; por su parte, en el segundo caso, una obra hipertextual puede navegarse a través de enlaces en una interfaz gráfica que llevan a múltiples derivaciones en el relato y así a múltiples posibilidades narrativas. Partiendo de esta distinción, es posible crear infinidad de obras que intervienen la producción y la navegación del texto.

Para hacernos una idea de esta diversidad, aquí podemos mencionar algunos ejemplos de literatura electrónica producida por autores latinoamericanos: las exploraciones poéticas y visuales con los recursos multimedia de la internet de los años noventa en los Anipoemas y Tipoemas de [Ana María Uribe](https://www.vispo.com/uribe/); los bots de Twitter de Leonardo Flores, como su generador de conmemoraciones ficticias de vidas de [“Santos Olvidados”](https://twitter.com/SantosOlvidados), y de Élika Ortega, como su [Bot Poesías Carrión](https://twitter.com/UC_Poesias_Bot), que produce textos generados basados en la poesía de Ulises Carrión; el mezclador de discursos políticos [Promesas](https://promesaspromesas.com/) de la artista Ana María Montenegro; o el cómic interactivo [Muerte en el bosque](https://muerteenelbosque.com/) de los autores Catalina Holguín y Joni B. Sin embargo, la producción de literatura electrónica es tan extensa en nuestro contexto, y en el mundo en general, que, para tener un panorama más amplio, vale la pena visitar compendios como la [Cartografía de la literatura digital latinoamericana](https://www.cartografiadigital.cl/), el [Atlas da literatura Digital Brasilera](https://www.observatorioldigital.ufscar.br/atlas-da-literatura-digital-brasileira/) y las [antologías de la Red de Literatura Electrónica Latinoamericana Lit(e)Lat](https://litelat.net/).

## Generadores, una estrategia mecánica-azarosa

En esta lección nos concentraremos en un tipo particular de literatura electrónica centrado en la producción de texto: los generadores automáticos.

Existe una larga tradición del uso de procesos mecánicos combinados con elementos azarosos para la creación en las artes y la literatura. Con mecánicos nos referimos a que están guiados por sistemas de reglas claramente definidos, es decir, si usamos términos computacionales, por algoritmos. Y por azarosos queremos decir que alguna parte del proceso creativo está definido por una fuente de incertidumbre, como el lanzamiento de una moneda o la selección espontánea de elementos en una lista. Esta combinación creativa entre orden y azar permite un equilibrio entre el control sobre los resultados de una obra creativa y la sorpresa con respecto a la configuración final de la misma obra. Pensemos, por ejemplo, en el ejercicio [S + 7](https://www.oulipo.net/fr/contraintes/s7) propuesto por el poeta surrealista Jean Lescure en los años sesenta: el ejercicio consiste en tomar un texto preexistente, por ejemplo un poema, y reemplazar cada sustantivo por la séptima palabra que se encuentre después de este en un diccionario de sustantivos. Aquí podemos ver que hay una parte mecánica, las reglas que definen cómo proceder con el ejercicio, y una parte azarosa, el resultado impredecible de cómo resultará el nuevo texto causado por el orden fortuito del diccionario usado.
Este tipo de estrategias creativas, que en principio no requieren de un computador, han sido posteriormente adaptadas por la literatura electrónica, pues sus autores comúnmente aprovechan los sistemas algorítmicos que permiten los lenguajes de programación y el azar que proveen los generadores de números aleatorios para dar lugar a la conjunción mecánica-azarosa. Un ejemplo concreto de esta estrategia en el campo computacional es la producción de generadores de texto —y otros medios como imágenes o sonido— por medio de sistemas algorítmicos llamados gramáticas libres de contexto; este es justamente el sistema que usaremos en esta lección.

## ¿Qué son gramáticas libres de contexto?

La idea original detrás de las gramáticas libres de contexto surgió de los estudios realizados por el lingüista Noam Chomsky en los años cincuenta. Chomsky buscaba proponer un modelo formal y general para entender las estructuras sintácticas del lenguaje, es decir, la manera como los elementos de un lenguaje se organizan para formar expresiones habladas o escritas. Posteriormente, estas ideas encontraron caminos fructíferos por fuera de la lingüística; fueron apropiadas por las ciencias de la computación y se crearon aplicaciones como el análisis de código de programación y, lo que nos ocupa en esta lección, la producción de generadores automáticos de texto.
En términos generales una gramática libre de contexto se compone de dos partes: una **lista de elementos** que componen el lenguaje y un **orden** en el que pueden disponerse esos elementos. Por ejemplo, supongamos que describimos una gramática en la que, como regla, primero va un artículo, luego un sustantivo y luego un adjetivo. Y que tenemos una lista de artículos: la, una; una lista de sustantivos: araña, ardilla, marmota; y una lista de adjetivos: valiente, elegante, generosa. Dentro del mundo de posibilidades de esa gramática, entonces, algunas frases posibles serían: “una araña generosa”, “la ardilla valiente” o “una marmota valiente”. Como puedes notar, la gramática describe qué tipos de combinaciones son posibles en este lenguaje.

Si representáramos esta gramática con un esquema que se ramifica como un árbol se vería algo como se ve en la Figura 1:

{% include figure.html filename="generadores-aventura1.png" caption="La gramática de un texto representada como un árbol" %}

Ahora, una gramática puede ser mucho más compleja, pues puede incluir sub-gramáticas, es decir, sistemas de reglas que se ramifican incluso en las ramas, como veremos más adelante.

Las gramáticas libres de contexto nos ofrecen entonces una manera de describir claramente un sistema de reglas con el que se pueden generar textos diversos; en otras palabras, nos proporcionan la parte mecánica de nuestro proceso creativo. Sin embargo, de acuerdo con lo que dijimos antes, también queremos añadir un elemento azaroso para llevar a cabo un ejercicio de creatividad computacional que pueda dar como resultado textos sorprendentes. Así, supongamos que justo al final de un árbol gramatical ponemos unas bolsitas de papel que contienen las categorías de palabras de nuestro léxico. Algo como lo que se ve en la Figura 2:

{% include figure.html filename="generadores-aventura2.png" caption="La gramática de un texto representada como un árbol con opciones que se pueden escoger al azar" %}

El elemento de azar ocurre cuando metemos la mano en cada una de estas bolsas y sacamos una palabra sin que intervenga nuestra elección voluntaria.

## Programar un generador de texto con Aventura.js

Ahora podemos pasar de estos árboles y bolsas de palabras imaginarias a escribir código de programación que nos permita crear un generador de textos automático. Usaremos [Aventura.js](https://github.com/srsergiorodriguez/aventura/blob/master/README_es.md)[^1], una librería de programación creada para desarrollar distintas formas de literatura electrónica: cadenas de markov, historias hipertextuales, y, por supuesto, gramáticas libres de contexto. Esta librería está escrita en el lenguaje de programación JavaScript y por lo tanto funciona dentro de los exploradores de internet; es apropiada para crear proyectos que circulan en la web. Cabe añadir también que Aventura es una librería creada específicamente para funcionar en inglés y en español, y busca ayudar a cerrar brechas idiomáticas en las prácticas que involucran la escritura de código en las artes y las humanidades.

Para desarrollar todo el ejercicio es necesario usar un editor de texto que permita escribir código de programación. En esta lección usaremos el editor [Visual Studio Code](https://code.visualstudio.com/), que está disponible gratuitamente en Windows, MACOS y Linux, pero tú puedes usar el editor de tu preferencia.

### Preparar el entorno

El primer paso consiste en crear una carpeta que contendrá todos los elementos de nuestro proyecto. La carpeta del proyecto de esta lección se llamará *generador*.

Ahora, en el editor de texto crearemos un archivo con el nombre *index.html* y lo guardaremos en la carpeta. Este es el documento de base que contendrá todo lo relacionado con nuestro proyecto. Pon el siguiente código de base en tu archivo html y guárdalo:

```html
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="utf-8">
  </head>
  <body>
  </body>
  <script src="aventura.js"></script>
  <script src="main.js"></script>
</html>
```

En términos generales, este código html describe los elementos básicos de un documento que se presenta en el explorador web, es decir, describe los elementos de un sitio web donde se alojará nuestro generador de texto. Concretamente, la etiqueta `<head>` contiene los elementos que describen los metadatos del sitio web, la etiqueta `<body>` contiene los elementos que serán visibles en el sitio web (cosas como los títulos, párrafos, imágenes, botones, etc.), y la etiqueta `<script>` se usa para cargar los archivos que contienen programación en JavaScript; aquí cargaremos dos archivos: *main.js*, en donde escribiremos nuestro código, y *aventura.js*, desde donde cargaremos la librería que nos facilitará el trabajo. Si te interesa entrar en más detalle acerca de cómo funciona un documento html te recomiendo visitar la lección de Programming Historian llamada [Para entender páginas web y HTML](https://programminghistorian.org/es/lecciones/ver-archivos-html) de William J. Turkel y Adam Crymble.

Lo siguiente es cargar la librería Aventura. Para eso debemos dirigirnos al repositorio de GitHub que la aloja y buscar el lanzamiento (o *release*) más reciente. En esta lección usaremos la versión 2.4.1. En [esta página](https://github.com/srsergiorodriguez/aventura) encontrarás un enlace con el que podrás descargar el archivo *aventura.js* como se ve en las Figuras 3 y 4. Una vez descargado, pónlo en la carpeta del proyecto.

{% include figure.html filename="generadores-aventura3.png" caption="El enlace a los releases de la librería en github" %}

{% include figure.html filename="generadores-aventura4.png" caption="El enlace al archivo descargable de la librería" %}

Finalmente, para esta etapa de preparación, debes crear un archivo llamado *main.js*. En este archivo escribiremos todo el código que hará parte de nuestro generador de texto, así que de ahora en adelante ese es el lugar en el que trabajaremos.

Así, debemos tener estos tres archivos en nuestra carpeta: *index.html*, *aventura.js*, *main.js*, como se ve en la Figura 5:

{% include figure.html filename="generadores-aventura5.png" caption="La lista de archivos necesarios para el proyecto" %}

### Programar la gramática

En esta lección crearemos un generador de poemas basado a grandes rasgos en el texto Al carbón de José Asunción Silva, un poeta colombiano de finales del siglo XIX, sacado de su libro de Obras Completas (Silva, 1977).

Primero tenemos que entender la estructura general del texto que nos servirá como referencia. En el caso de Al carbón vemos que el texto describe los elementos atmosféricos, la textura y los objetos representados en un dibujo hecho al carboncillo. En más detalle, el texto habla primero de la sensación lumínica que proporciona la luz que entra por una ventana, luego describe los elementos que están regados en varias partes de un cuarto, luego habla de las texturas de los muros, luego habla de la silueta de un burro que está en la escena, luego nos revela que lo que se había estado describiendo todo este tiempo era un dibujo al carboncillo y no un cuarto real, y finalmente hace un recuento de los objetos descritos y en qué partes del dibujo son más evidentes las luces y las sombras.

Para simplificar nuestro generador, vamos a tomar solo algunas partes de la estructura general del texto original: la descripción atmosférica, la lista de objetos, la revelación de que se trata de un dibujo, y la descripción de los lugares del dibujo que tienen luces y sombras. Si representáramos esto en un árbol, tendríamos un esquema como el de la Figura 6:

{% include figure.html filename="generadores-aventura6.png" caption="La representación de una gramática basada en Al Carbón de José Asunción Silva" %}

Para representar esta estructura en código entendible para Aventura debemos crear un [objeto](https://developer.mozilla.org/es/docs/Web/JavaScript/Guide/Working_with_Objects) de JavaScript que contenga la gramática en nuestro archivo *main.js*. Dentro de este objeto pondremos un conjunto de propiedades[^2] que representan qué ramas llevan a otras ramas dentro de nuestro árbol, y, al final de cada rama, qué lista de opciones tenemos; las bolas de papel, por así decirlo. Cada una de estas propiedades es una [Array](https://developer.mozilla.org/es/docs/Web/JavaScript/Reference/Global_Objects/Array) (es decir, una lista de elementos, encerrada en corchetes cuadrados), que contiene [Strings](https://developer.mozilla.org/es/docs/Web/JavaScript/Reference/Global_Objects/String) (es decir, una cadena de caracteres, encerrada en comillas). Por ahora, empezamos por crear el tronco de nuestro generador con referencias a las ramas necesarias. Para hacer una referencia a una nueva rama, en Aventura se usa como convención poner el nombre de la rama entre corchetes angulares, o sea, los signos de menor que y mayor que. Entonces, en un principio, el diseño de nuestra gramática se vería así:

```JavaScript
let gramatica = {
  base: ["<atmosferica> <objetos> <revelacion> <lucesYsombras>"]
}
```

Ahora debemos crear una rama por cada referencia. Por el momento, podemos poner textos fijos en cada rama, y poco a poco crearemos nuevas derivaciones y opciones. Estos textos fijos son equivalentes a poner una bolsa con solo una opción. Algo como esto:

```JavaScript
let gramatica = {
  base: ["<atmosferica> <objetos> <revelacion> <lucesYsombras>"],
  atmosfera: ["La luz fría, intercalada por la sombra de los árboles, se cuela por la ventana."],
  objetos: ["Al pie de la ventana hay unos colchones viejos, a la izquierda un armario vacío, a la derecha una tina de zinc, y sobre el piso botellas vacías"],
  revelacion: ["Es un estudio al carbón, hecho con imperceptibles transiciones entre el blanco y el negro."],
  lucesYsombras: ["La luz brilla en el borde de la tina, y en las botellas, la penumbra domina el espacio del armario y el espaldar de los colchones."]
}
```

En este punto podemos introducir variaciones que serán seleccionadas al azar cuando generemos nuevos textos. Como ejemplo sencillo, podemos cambiar la palabra árboles en la regla `atmosfera` por una lista de árboles concretos. Digamos, nogales, saucos y urapanes. Simplemente debemos reemplazar la palabra árboles en esa rama por una referencia a `<arboles>` y crear un nuevo parámetro en nuestra gramática con la lista de opciones:


```JavaScript
let gramatica = {
  base: ["<atmosferica> <objetos> <revelacion> <lucesYsombras>"],
  atmosfera: ["La luz fría, intercalada por la sombra de los <arboles>, se cuela por la ventana."],
  arboles: ["nogales", "saucos", "urapanes"] // esta es una nueva lista de opciones
// … INCLUIR LAS OTRAS PARTES DE LA GRAMÁTICA, AQUÍ SOLO SE MUESTRAN LAS QUE HAN CAMBIADO
}
```

Una vez estamos familiarizados con el proceso, podemos crear nuevas reglas y opciones. Para crear la lista de opciones nos apoyaremos en los datos recogidos por el proyecto [Sobremesa Digital](http://clementinagrillo.com/sobremesadigital/) de Clementina Grillo. Este proyecto hizo un recuento de todos los objetos que se mencionan en la novela De Sobremesa escrita por José Asunción Silva, y ofrece ese recuento, diferenciado por capítulos y tipos de objetos, en un [archivo json](http://clementinagrillo.com/sobremesadigital/flare.json). Estos datos son muy adecuados para el proyecto de esta lección, así que los usaremos como insumo para la siguiente parte. Así, en vez de poner elementos fijos en la rama de objetos, pondremos elementos escogidos al azar tomados de la base de datos de Sobremesa digital:

```JavaScript
let gramatica = {
  base: ["<atmosferica> <objetos> <revelacion> <lucesYsombras>"],
  atmosferica: ["La luz fría, intercalada por la sombra de los <arboles>, se cuela por la ventana."],
  arboles: ["nogales", "saucos", "urapanes"],
  objetos: ["Al pie de la ventana hay <mueblesPlural>, a la izquierda <vestuarioSingular>, a la derecha una <vestuarioSingular>, y sobre el piso, <instrumentosPlural>."],
  mueblesPlural: ["Sábanas heladas","Viejas tapicerías desteñidas","Edredones","Cortinas de gasa japonesa","Porcelanas","Lienzos","Cartones","Tapices","Almohadas","Cirios","Muebles sobrios","Brocateles de iglesias desteñidos por el tiempo","Mesas de tocador de cristal y níquel","Lámparas del salón","Diván","Cuadros de Vasquez","Marcos españoles de oro desteñido","Sábanas de raso negro","Paredes tendidas de sedería japonesa bordados de oro y plata","Sábanas gruesas","Mesas redondas de grandes hoteles","Persianas","Cortinas blancas caidas","Mobiliarios y obras de arte que me rodearon en Paris","Mesas de hierro","Escaparates de nogal","Miniaturas encuadradas de diminutos diamantes","Lienzos españoles","Espadas árabes","Moharras árabes","Sillones de consulta","Impresiones de arte","Cuadros de Gainsbourgh y Reynolds","Brocateles","Mantas","Pieles","Almohadones","Colección de tapices persas","Campanas de oro","Punteros","Jardineras llenas de flores","Veladores de malaquita","Restos de estatuas","Pantallas de encaje","Cálices de las flores de un ramo","Cajas de terciopelo y raso","Blandos cojines","Baúles","Cortinas de terciopelo","Objetos dignos de museo","Triclinios de marfil","Muebles antiguos","Retratos","Paredes cubiertas de cuero de Córdoba","Vasos","Floreros de Murano","Alfombras de oriente","Objetos de arte"],
  instrumentosPlural:["Lentes de vidrio negro","una Caja llena de tiquetes","Anteojos negros","Velas del barco","Espejos","Guillotinas","Bombas","Telégrafos","Telegramas","Maletas de viaje","Llaves de la casa","Vainas de cuero","Platones de madera","Bayonetas","Explosivos","Granadas","Seis baúles llenos de sombreros y vestidos","Antiparras","Diminutas tazas de frágil porcelana","Cajas de cristal","Vasos de nácar","Curiosos instrumentos de observación","Varios aparaticos","Vendas","Alfileres","Pesas","Globos de caucho","Brújulas","Estuches","Hachas","Lanzas","Termómetros","Quevedos de oro","Llaves","Guitarras","Gabinetes de experimentación","Lentes de microscopio","Copas de whisky","Bujías de candelabro","Cofres de hierro","Partes telegráficos","Telegramas","Cucharas de plata","Punteros de oro"],
  vestuarioSingular:["Corpiño florecido","Vestido de crespón de seda","Guirnalda de rosa de Bengala","Frac negro","Tules diáfanos","Chaleco de seda bordado","Zapato femenino para hacer piruetas","Pechera de batista plegada y rizada","Solapa del frac","Puño de la camisa","Vestido nuevo","Corpiño bajo de gasa verde","Camisa de dormir","Enaguas bordadas","Pañuelo de baile","Vestido con estilo masculino","Calzado","Corbateado de rosa","Abrigo de viaje","Sombrero","Guante de Suecia","Vestido de seda roja","Toca negra","Vestido gris de refinada elegancia","Mano enguantada de cabritilla oscura","Negro frac","Pañuelo de batista","Vestido de franela","Corpiño de seda roja","Orla de dibujo bizantino","Cartera de cuero de caimán y esquineras de oro","Camisa de batista","Fantástico traje","Manto blanco","Pechera abotonada con una perla negra","Camisa de fuerza","Pesado abrigo de pieles","Guante de esgrima","Levitón negro","Vestido de opaca seda negra","Ornamentada de azabaches","Sombrero de fieltro ornamentado de plumas negras","Cartera forrada en cuero de Rusia","Zapato bajo de charol","Media de seda negra fina como un encaje","Pañuelo de batista y encajes","Negra manga de opaca seda ornamentada de azabaches","Falda negra con brillo mate de azabaches","Corpiño de rerciopelo negro sujeto por ramo de gloxinias y gardenias","Largo sobretodo gris de viaje","Pañuelo blanco","Abrigo de amplios bolsillos","Perla negra abotona pechera","Cartera"],
  revelacion: ["Es un estudio al carbón, hecho con imperceptibles transiciones entre el blanco y el negro."],
  lucesYsombras: ["La luz brilla en el borde de la tina, y en las botellas, la penumbra domina el espacio del armario y el espaldar de los colchones"]
}
```

Para ver el resultado de nuestro generador de texto primero debemos fijar la gramática en la instancia de Aventura que creamos anteriormente, así:

`aventura.fijarGramatica(gramatica);`

Y luego debemos expandir la gramática, es decir, hacer que el programa recorra automáticamente el árbol parte por parte y escoja elementos entre las opciones disponibles. En la función `expandirGramatica` debemos poner el nombre de la propiedad que contiene nuestra regla inicial:

`let texto = aventura.expandirGramatica('base');`

El texto guardado en esta variable se puede usar en cualquier parte del sitio web y se puede estilizar de acuerdo con tus preferencias. Aquí sólo veremos el resultado del texto en la consola:

`console.log(texto);`

Un ejemplo del texto generado con la gramática de esta lección es el siguiente:

*La luz fría, intercalada por la sombra de los urapanes, se cuela por la ventana. Al pie de la ventana hay Almohadones, a la izquierda Enaguas bordadas, a la derecha Frac negro, y sobre el piso, Quevedos de oro. Es un estudio al carbón, hecho con imperceptibles transiciones entre el blanco y el negro. La luz brilla en el borde de la tina, y en las botellas, la penumbra domina el espacio del armario y el espaldar de los colchones*

Cabe decir aquí que, una vez se hace más compleja la gramática, es posible que por descuido dejemos ramas que no llevan a ningún lado. Convenientemente, Aventura cuenta con un sistema de errores que nos permite ver qué partes de la gramática están incompletas. Esto debemos hacerlo antes de expandir la gramática:

`aventura.probarGramatica(gramatica)`;

Si queremos, incluso pueden encadenarse todas las funciones en una sola línea:

```JavaScript
let texto = aventura.fijarGramatica(gramatica).probarGramatica(gramatica).expandirGramatica('tronco');
console.log(texto);
```

### Recordar elementos escogidos al azar

Aunque en este punto nuestra gramática ya es funcional y produce textos automáticos, cabe mencionar que con Aventura también es posible otro tipo de opciones avanzadas, como es el caso de crear nuevas reglas sobre la marcha que puede ser utilizado para recordar fragmentos de texto que se han escogido al azar. Esta funcionalidad es útil, por ejemplo, para crear narraciones en las que es necesario ser consistentes con el nombre de un personaje que, aunque fue escogido al azar inicialmente, debe repetirse varias veces en el texto. En esta lección usaremos esta funcionalidad para recordar los elementos escogidos al azar en la regla `objetos` y reusarlos en la regla `lucesYsombras`.
Para crear una nueva regla sobre la marcha debemos definir un nombre para la regla (encerrado en el signo `$`), seguido de un set de subreglas, encerradas en paréntesis cuadrados: `[clave1:valor1,clave2,valor2...]`. En la gramática que hemos venido construyendo se vería así:

```JavaScript
let gramatica = {
  // ...INCLUIR LAS OTRAS REGLAS DE LA GRAMÁTICA, AQUÍ SOLO SE MUESTRA LAS QUE CAMBIARON
  objetos: ["$mueble1$[obj:mueblesPlural]$vestuario1$[obj:vestuarioSingular]$vestuario2$[obj:vestuarioSingular]$instrumento1$[obj:instrumentosPlural]Al pie de la ventana hay <mueble1.obj>, a la izquierda <vestuario1.obj>, a la derecha <vestuario2.obj>, y sobre el piso, <instrumento1.obj>."],
  lucesYsombras: ["Vemos brillos de luz en <vestuario1.obj> y <mueble1.obj>, la penumbra domina <instrumento1.obj> y <vestuario2.obj>"]
}
```

Un resultado de texto generado es el siguiente:

*"La luz fría, intercalada por la sombra de los saucos, se cuela por la ventana. Al pie de la ventana hay Mesas redondas de grandes hoteles, a la izquierda Vestido de seda roja, a la derecha Media de seda negra fina como un encaje, y sobre el piso, Brújulas. Es un estudio al carbón, hecho con imperceptibles transiciones entre el blanco y el negro. Vemos brillos de luz en Vestido de seda roja y Mesas redondas de grandes hoteles, la penumbra domina Brújulas y Media de seda negra fina como un encaje"*

Siguiendo el mismo método podríamos sofisticar nuestra gramática gradualmente e incluir nuevas reglas y opciones. Por ejemplo, artículos adecuados (un, una, la, él, etc.) antes de cada uno de los objetos que se describe en el texto.

## Crear un generador de imágenes con Aventura.js

Las gramáticas libres de contexto no solo sirven para crear textos generativos sino también otros tipos de medios. Con Aventura es posible además crear generadores de imágenes, llamados "igramas" en Aventura. En esta lección, finalmente, crearemos un generador de collages basado en fragmentos de las acuarelas de Edward Walhouse Mark disponibles en la [Colección de Arte del Banco de la República de Colombia](https://www.banrepcultural.org/coleccion-de-arte). El procedimiento es casi igual al de la gramática textual que hicimos antes, los principios que implican establecer un árbol y una lista de opciones son idénticos; sin embargo, debemos definir algunos elementos extra: las posiciones y los tamaños de los fragmentos de imagen que usaremos.
Para ayudarnos, usaremos la aplicación [igrama](https://srsergiorodriguez.github.io/igrama/) que nos facilitará los pasos necesarios para construir la gramática. En la página inicial de igrama debemos hacer clic en el recuadro de estructura, como lo muestra la Figura 7. Allí definiremos el tamaño que queremos que tenga nuestra imagen y la cantidad de secciones que queremos que tenga nuestro generador, es decir, de ramas que recombinan fragmentos de imagen. En esta lección crearemos una imagen de 400 x 400 píxels con 4 secciones.

{% include figure.html filename="generadores-aventura7.png" caption="La interfaz inicial de la aplicación igrama" %}

En la nueva interfaz que se despliega podemos definir los tamaños y las posiciones de las secciones. En esta lección dejaremos la sección 0 como fondo, así que ocupará todo el tamaño de la imagen; la sección 1 tendrá personajes y la pondremos en el lado izquierdo, la sección 2 incluirá edificaciones y la pondremos a la derecha; la sección 3 incluirá objetos y la pondremos en la parte inferior de la imagen. Una vez definidas las secciones hacemos clic en el símbolo de descargar (una flecha apuntando hacia abajo) y le daremos los nombres adecuados a las secciones, también debemos activar la opción de exportar plantillas.

{% include figure.html filename="generadores-aventura8.png" caption="Seleccionar las posiciones y tamaños de las secciones en la aplicación igrama" %}

{% include figure.html filename="generadores-aventura9.png" caption="Poner nombres a las secciones y exportar plantillas en la aplicación igrama" %}

Al dar clic en continuar el explorador descargará un archivo json con un modelo de igrama y una serie de imágenes en blanco con las proporciones de nuestras secciones. Usaremos esas imágenes en blanco como plantillas para, por medio de un programa de edición, crear los fragmentos de imagen que se remezclarán en nuestro generador.

El archivo que descarga la aplicación está en un formato muy similar a la gramática de texto, pero con información adicional para que pueda crearse una composición visual: el tamaño de la imagen, el color de fondo, los tamaños y posiciones de cada una de las secciones, etc. Toda esta información define un modelo de igrama. Así, si abres el archivo json, el modelo de igrama se vería algo como esto:

```JSON
{
  "metadata": {
    "width": 400,
    "height": 400,
    "bg": "#FFFFFF",
    "sectionsNames": [
      "fondo", "personaje", "edificacion", "objeto"
    ],
    "attributes": [
      false,false,false,false
    ],
    "sectionsN": 4
  },
  "sections": [
    { "w": 400, "h": 400, "i": 0, "x": 0, "y": 0 },
    { "w": 201, "h": 288, "i": 1, "x": 0, "y": 112 },
    { "w": 232, "h": 335, "i": 2, "x": 168, "y": 65 },
    { "w": 290, "h": 133, "i": 3, "x": 67, "y": 267 }
  ],
  "grammar": {
    "base": [
      "<fondo>|<personaje>|<edificacion>|<objeto>"
    ]
  },
  "sketch": "MCxOYU4="
}
```

Lo que sigue es preparar una serie de imágenes usando las plantillas que se descargaron con las dimensiones de cada sección: fondo, personaje, edificación, objeto, así como una plantilla del tamaño final de la imagen que puede servir como referencia. En este punto es posible usar cualquier software de edición para ajustar los fragmentos de imagen que queremos incluir en nuestro generador. Por ejemplo, [Gimp](https://www.gimp.org/) es un programa de manipulación de imágenes gratuito y de acceso abierto con el que se puede hacer este proceso. Puedes exportar cada uno de los fragmentos de imagen en formato png con fondo transparente.

Para esta lección preparamos cinco imágenes por cada una de las secciones. Es decir, nuestra gramática visual tendrá cinco opciones para escoger en la composición por cada una de las secciones definidas. Para seguir la lección, puedes descargar las imágenes en [este enlace](./imagenes).

Ahora debemos poner nuestro modelo y la carpeta con imágenes en nuestra carpeta de proyecto.

Para hacer referencia a las imágenes que creamos dentro de la gramática de nuestro modelo de igrama, es decir, la sección del archivo json con el nombre "grammar", debemos seguir la misma lógica que con una gramática convencional. Sin embargo, como le indicaremos al programa que busque una imagen, no un fragmento de texto, debemos usar una sintaxis especial: `url%%URL_AL_ARCHIVO_DE_IMAGEN%%`. Así se vería nuestra gramática con referencias a las imágenes que tenemos en la carpeta de nuestro proyecto:

```JSON
{
  // ...OTROS METADATOS DEL MODELO
  "grammar": {
    "base": [
      "<fondo>|<personaje>|<edificacion>|<objeto>"
    ],
    "fondo": [
      "url%%./imgs/fondo/imagen_1.png%%",
      "url%%./imgs/fondo/imagen_2.png%%",
      "url%%./imgs/fondo/imagen_3.png%%",
      "url%%./imgs/fondo/imagen_4.png%%",
      "url%%./imgs/fondo/imagen_5.png%%"],
    "personaje": [
      "url%%./imgs/personaje/imagen_1.png%%",
      "url%%./imgs/personaje/imagen_2.png%%",
      "url%%./imgs/personaje/imagen_3.png%%",
      "url%%./imgs/personaje/imagen_4.png%%",
      "url%%./imgs/personaje/imagen_5.png%%"],
    "edificacion": [
      "url%%./imgs/edificacion/imagen_1.png%%",
      "url%%./imgs/edificacion/imagen_2.png%%",
      "url%%./imgs/edificacion/imagen_3.png%%",
      "url%%./imgs/edificacion/imagen_4.png%%",
      "url%%./imgs/edificacion/imagen_5.png%%"],
    "objeto": [
      "url%%./imgs/objeto/imagen_1.png%%",
      "url%%./imgs/objeto/imagen_2.png%%",
      "url%%./imgs/objeto/imagen_3.png%%",
      "url%%./imgs/objeto/imagen_4.png%%",
      "url%%./imgs/objeto/imagen_5.png%%"]
  },
  // ...OTROS METADATOS DEL MODELO
}
```

Finalmente, para mostrar la imagen en el explorador, debemos usar el siguiente código:

```JavaScript
aventura.cargarJSON("./modelo.json").then(gramatica => {
  aventura.fijarIgrama(gramatica);
  let capas = aventura.expandirIgrama("base");
  aventura.mostrarIgrama(capas, "png");
});
```

En términos generales, el código anterior usa `cargarJSON` para leer un archivo json, en este caso el modelo de igrama, y devuelve una promesa. Una vez se termina de leer el json y se resuelve la promesa, se devuelve la gramática de igrama que se fija a Aventura con `fijarIgrama`. Luego de esto se debe expandir el igrama pasando la regla inicial a `expandirIgrama`; las capas del igrama expandido se guardan en la variable "capas". Finalmente se usa la función `mostrarIgrama` para presentar la imagen resultante en el explorador. `mostrarIgrama` recibe como argumentos la lista de capas, el formato de la imagen (png o gif) y, opcionalmente el id de un elemento de html que sirva como contenedor de la imagen. Recuerda que debes haber creado una instancia de aventura con `let aventura = new Aventura("es")` para poder acceder a todas estas funciones.

La Figura 10 muestra tres collages producidos con nuestro generador:

{% include figure.html filename="generadores-aventura10.png" caption="Collages producidos con un generador de imágenes igrama" %}

Opcionalmente puedes ahorrarte el trabajo de escribir una por una de las urls de la gramática de igrama si, en un archivo .zip, guardas el modelo de igrama y una serie de carpetas con las imágenes de la gramática. Las carpetas deben tener los nombres exactos de las reglas; piensa que son las bolsas de papel con los fragmentos de imagen que se sacarán al azar para obtener el resultado final. Puedes arrastrar este archivo zip a la [aplicación de igrama](https://srsergiorodriguez.github.io/igrama/) para convertirlo en un modelo que contiene en sí mismo la información de las imágenes, de la gramática y todos sus metadatos, como lo muestra la Figura 11:

{% include figure.html filename="generadores-aventura11.png" caption="Interfaz para crear modelos autocontenidos" %}

Puedes usar este modelo autocontenido en tu proyecto usando el mismo código que se ejemplificó arriba, sin necesidad de subir las carpetas con imágenes a la carpeta del proyecto, pues ahora el modelo contiene toda la información. Puedes verificar el funcionamiento de tu modelo autocontenido arrastrándolo al [generador de la aplicación igrama](https://srsergiorodriguez.github.io/igrama/generador/).

# Notas

[^1]: El autor de la librería Aventura es Sergio Rodríguez Gómez, quien escribe la versión en español de esta lección.

[^2]: Es importante recordar que en JavaScript los objetos funcionan a través de combinaciones del nombre de propiedad seguida de dos puntos y luego su valor. En el caso del diseño de la gramática, el nombre de propiedad es el nombre de la rama y el valor es la Array con opciones en esa rama. Como regla general, el nombre de propiedad no puede contender espacios, acentos como tildes o diéresis, ni puede iniciar con un número. Por convención, en JavaScript se suele usar un formato llamado *camel case*, en el que, para evitar los espacios, se ponen las palabras que siguen a la primera palabra con la inicial en mayúsculas, así: NombreDeUnaVariable. Esto en contraste con otro tipo de convenciones como los guiones bajos, o *snake case* que se suelen usar en python: nombre_de_una_variable.

# Bibliografía

Chomsky, Noam. (1956). “Three models for the description of language”. IEEE Transactions on Information Theory, 2(3) (1956), 113–124. https://doi.org/10.1109/TIT.1956.1056813

Silva, José Asunción. Obras Completas. (1977). Biblioteca Ayacucho.
