---
title: "Introducción a la codificación de textos en TEI"
collection: lessons
layout: lesson
slug:
date:
translation_date:
authors:
 - Nicolás Vaughan
reviewers:
 -
editors:
 -
translator:
 -
translation-editor:
 -
translation-reviewer:
 -
original:
review-ticket:
difficulty:
activity:
topics:
abstract:
doi:
---


## Contenidos
{:.no_toc}

* TOC
{:toc}


# Contenidos

# Introducción

Tradicionalmente uno de los problemas centrales de las humanidades digitales ha sido el trabajo con y sobre textos:
su captura, reconocimiento, transcripción, codificación, procesamiento, transformación y análisis.
En esta lección nos centraremos exclusivamente en la *codificación de textos*, es decir, en su categorización semántica por medio de etiquetas (*tags*).


Un ejemplo puede ayudar a aclarar esta idea.
Supongamos que tenemos un documento que hemos escaneado previamente; digamos, un documento impreso, esto es, uno producido en una prensa o imprenta; no un manuscrito.
Tenemos las imágenes de sus páginas (en formato PNG, TIFF, etc.) y, con ayuda de un software de [reconocimiento óptico de caracteres (OCR, en inglés)](https://es.wikipedia.org/wiki/Reconocimiento_%C3%B3ptico_de_caracteres),  extraemos ahora el texto contenido en ellas.
Este paso es absolutamente necesario.
Las imágenes escaneadas originalmente no tienen texto alguno: tan solo son "mapas de bits" que representan píxeles en distintos tonos e intensidades.
En efecto, no podemos "seleccionar el texto" en una imagen que aún no haya sido procesada por OCR para obtenerlo.
Este texto es lo que suele llamarse [texto plano](https://www.ecured.cu/Texto_plano), es decir, texto sin formato alguno (sin cursivas, negritas, etc.) ni ninguna otra estructuración semántica.


Aunque pueda parecer contraintuitivo, el texto plano carece completamente de estructura y, estrictamente hablando,contenido.
Para un *computador* es solo una larga cadena de caracteres (incluyendo puntuación, espacios en blanco y saltos de línea, etc.) en alguna [codificación](https://es.wikipedia.org/wiki/Codificaci%C3%B3n_de_caracteres) ([UTF-8](https://es.wikipedia.org/wiki/UTF-8), [ASCII](https://es.wikipedia.org/wiki/ASCII), etc.) de algún [alfabeto](https://es.wikipedia.org/wiki/Sistema_de_escritura) (latino, griego, cirílico, etc.).
Somos *nosotros* quienes, cuando lo leemos, identificamos palabras (en una o varias lenguas), líneas, párrafos, etc.
Somos *nosotros* quienes identificamos asimismo nombres de personas y de lugares, títulos de libros y artículos, fechas, citas, epígrafes, referencias cruzadas (internas y externas), notas a pie de página y notas al final del texto.
Pero, de nuevo, el computador es completamente "ignorante" con respecto a dichas estructuras textuales en un texto plano sin procesar o codificar.


Sin asistencia humana (p. ej. por medio de codificación TEI) el computador no puede "entender" o detectar ninguna estructura semántica en el texto plano.
Eso implica, entre otras, que no podemos hacer búsquedas estructuradas sobre ese texto (de nombres de personas, lugares, fechas, etc.), ni podemos extraer y procesar sistemáticamente dicha información, sin antes haberle indicado al computador qué cadenas de caracteres corresponden a qué estructuras semánticas:
este es un nombre propio de persona, aquel otro nombre de persona se refiere a la misma persona que este, este es un nombre de lugar, esta es una nota al margen hecha por una tercera persona, este párrafo pertenece a esta sección del texto, etc., etc., etc.
**Codificar el texto** es indicar (por medio de etiquetas u otros recursos) que ciertas cadenas de texto plano tienen cierta significación.
Y esa es la diferencia entre texto plano y texto semánticamente estructurado.


Puede haber muchas formas de codificar un texto.
Por ejemplo, podemos encerrar entre asteriscos simples los nombres propios de personas: `*Simón Bolívar*`, `*Soledad Acosta*`, etc.
Y entre asteriscos dobles los de lugares: `**Bogotá**`, `**Framingham**`, etc.
Podemos asimismo usar guiones bajos para denotar los nombres de libros: `_La divina comedia_`, `_Cien años de soledad_`, etc.
Estos signos sirven para *etiquetar* o *marcar* el texto que encierran, con el objetivo de otorgarle un cierto contenido semántico.
Las posibilidades de codificación son casi infinitas, como es fácil de imaginar.

Ahora bien, el problema de usar signos como estos para etiquetar un texto es que o bien pueden ser muy pocas las estructuras semánticas codificadas si limitamos el número de signos disponibles (p. ej. `*, **, _, !, ?`) (además de que pueden confundirse con los signos que aparezcan originalmente en el texto: `?ejemplo??`); o bien, si no limitamos su numero, puede llegar a ser difícil recordar el significado de todas las etiquetas.
En esta lección aprenderemos a codificar textos usando un lenguaje de computador especialmente diseñado para ello: TEI.



## Software que usaremos en esta lección

Cualquier editor de texto plano nos servirá para hacer todo lo que necesitemos en esta lección:
el [Bloc de Notas (*Notepad*) de Windows](https://es.wikipedia.org/wiki/Bloc_de_notas), por ejemplo, es perfectamente adecuado para ello.

Ahora bien, hay otros editores de texto que ofrecen herramientas o funcionalidades para facilitar el trabajo con XML e incluso con TEI.
Uno de los más recomendados actualmente es [Oxygen XML Editor](https://www.oxygenxml.com), disponible para Windows, MacOS y Linux.
Sin embargo, no es un software gratuito (la licencia académica cuesta unos $100 USD) ni de código abierto, por lo que no lo usaremos en esta lección.
Vamos a recomendar dos aplicaciones gratuitas y de código abierto.
El lector podrá escoger la que le plazca.


### Opción 1: Visual Studio Code

La primera opción es el editor [Visual Studio Code](https://code.visualstudio.com/) (VS Code, más brevemente), creado por Microsoft y mantenido actualmente por una gran comunidad de programadores de software libre.
Es una aplicación completamente gratuita y de [código abierto](https://github.com/microsoft/vscode), disponible para Windows, MacOS y Linux.


Descarguen la versión más reciente de VS Code en el enlace https://code.visualstudio.com/ e instálenla en su computador.
Ahora ábranlo y verán una pantalla como la siguiente:

<figure>
<a href="vscode01.png">
    <img src="vscode01.png" alt="Vista inicial de VS Code">
	</a>
<figcaption>
    <p>Vista inicial de VS Code</p>
</figcaption>
</figure>

{% include figure.html filename="vscode01.png" caption="Vista inicial de VS Code" %}

Es probable que en su computador VS Code se vea algo distinto que en esta imagen.
(Yo lo estoy corriendo ahora en Linux.)
Sin embargo, las diferencias son básicamente estéticas y podremos obviarlas.


Ahora instalaremos una extensión de VS Code llamada XML Complete, para trabajar más fácilmente con documentos XML.
Para ello piquen en el botón de extensiones en la barra lateral de herramientas, a la izquierda en la ventana principal:

<figure>
<a href="vscode02.png">
    <img src="vscode02.png" alt="Extensiones de VS Code">
	</a>
<figcaption>
    <p>Extensiones de VS Code</p>
</figcaption>
</figure>

{% include figure.html filename="vscode02.png" caption="Extensiones de VS Code" %}

Escriban `Xml complete` en el campo de búsqueda:

<figure>
<a href="vscode03.png">
    <img src="vscode03.png" alt="Búsqueda de extensiones de VS Code">
	</a>
<figcaption>
    <p>Búsqueda de extensiones de VS Code</p>
</figcaption>
</figure>

{% include figure.html filename="vscode03.png" caption="Búsqueda de extensiones de VS Code" %}

Finalmente piquen en "Install":

<figure>
<a href="vscode04.png">
    <img src="vscode04.png" alt="Instalar XML Complete en VS Code">
	</a>
<figcaption>
    <p>Instalar XML Complete en VS Code</p>
</figcaption>
</figure>

{% include figure.html filename="vscode04.png" caption="Instalar \"XML Complete\" en VS Code" %}

La extensión XML Complete nos permite, entre otras, validar sintácticamente documentos XML.
Si hay un error sintáctico —por ejemplo si hemos olvidado cerrar una etiqueta—, VS Code nos lo mostrará en la barra de abajo:

<figure>
<a href="vscode05.png">
    <img src="vscode05.png" alt="Detectar errores sintácticos en VS Code">
	</a>
<figcaption>
    <p>Detectar errores sintácticos en VS Code</p>
</figcaption>
</figure>

{% include figure.html filename="vscode05.png" caption="Detectar errores sintácticos en VS Code" %}

<figure>
<a href="vscode06.png">
    <img src="vscode06.png" alt="Detectar errores sintácticos en VS Code (detalle)">
	</a>
<figcaption>
    <p>Detectar errores sintácticos en VS Code (detalle)</p>
</figcaption>
</figure>

{% include figure.html filename="vscode06.png" caption="Detectar errores sintácticos en VS Code (detalle)" %}

Esta extensión ofrece asimismo otras herramientas útiles para autocompletar el código de XML. Para más detalles, pueden consultar la [documentación](https://github.com/rogalmic/vscode-xml-complete).


### Opción 2: BaseX

La segunda opción, mucho más robusta, es la aplicación [BaseX](https://basex.org/).
Más que un editor, BaseX es una "base de datos XML y procesador XQuery 3.1, con soporte completo para la actualización W3C y las extensiones de texto-completo", como se dice en su página.

Para descargarlo, vamos a la página de descargas: https://basex.org/download/
Ahí veremos varias opciones, dependiendo del sistema operativo que tengamos.
En cualquier caso, puesto que BaseX es una aplicación Java, debemos tener instalado previamente en nuestro computador el  [Java Runtime Environment (JRE)](https://es.wikipedia.org/wiki/M%C3%A1quina_virtual_Java), disponible gratuitamente aquí: https://www.java.com/es/download/
(Es probable que el JRE ya esté instalado en su computador.
[Verifiquen](https://www.poftut.com/how-to-find-and-verify-installed-java-runtime-version/) que la versión instalada sea al menos la 8, pues es la requerida por BaseX 9.)


Entonces, si estamos en Microsoft Windows, podemos descargar e instalar la opción que dice "Windows Installer", aquella cuya extensión es `.exe`:

<figure>
<a href="basex01.png">
    <img src="basex01.png" alt="Descargar BaseX para Windows">
	</a>
<figcaption>
    <p>Descargar BaseX para Windows</p>
</figcaption>
</figure>

{% include figure.html filename="basex01.png" caption="Descargar BaseX para Windows" %}


Si estamos en MacOS o en Linux, podemos descargar la primera opción (el archivo `.jar`) o la segunda opción (el archivo `.zip`).
Una vez descargado el `.jar` (o una vez descomprimido el `.zip`), debemos ejecutarlo desde el [terminal](https://es.wikipedia.org/wiki/Emulador_de_terminal) con el comando:

```sh
java -jar BaseX946.jar
```

(`BaseX946.jar` es el archivo que corresponde a la versión 9.46, la más reciente a la fecha de la redacción de esta lección.)

Esta es la pantalla inicial de la aplicación BaseX en Windows:

<figure>
<a href="basex02.png">
    <img src="basex02.png" alt="Pantalla principal de BaseX en Windows">
	</a>
<figcaption>
    <p>Pantalla principal de BaseX en Windows</p>
</figcaption>
</figure>

{% include figure.html filename="basex02.png" caption="Pantalla principal de BaseX en Windows" %}


Si queremos, podemos cerrar los dos paneles inferiores, para quedarnos solo con los marcos del navegador de archivo y del editor, picando con el botón derecho del ratón:

<figure>
<a href="basex03.png">
    <img src="basex03.png" alt="Cerrar los paneles inferiores de BaseX">
	</a>
<figcaption>
    <p>Cerrar los paneles inferiores de BaseX</p>
</figcaption>
</figure>

{% include figure.html filename="basex03.png" caption="Cerrar los paneles inferiores de BaseX" %}

y luego sobre "Cerrar":

<figure>
<a href="basex04.png">
    <img src="basex04.png" alt="Cerrar los paneles inferiores de BaseX">
	</a>
<figcaption>
    <p>Cerrar los paneles inferiores de BaseX</p>
</figcaption>
</figure>

{% include figure.html filename="basex04.png" caption="Cerrar los paneles inferiores de BaseX" %}

También podemos configurar el idioma de la aplicación.
Para ello picaremos en el menú sobre Opciones -> Preferencias, y entonces podremos escoger el idioma que deseemos:

<figure>
<a href="basex05.png">
    <img src="basex05.png" alt="Selección de idioma en BaseX">
	</a>
<figcaption>
    <p>Selección de idioma en BaseX</p>
</figcaption>
</figure>

{% include figure.html filename="basex05.png" caption="Selección de idioma en BaseX" %}



### Otras opciones de software

Si el lector lo prefiere, puede usar en lugar de VS Code el editor [Atom](https://atom.io), donde podrá instalar extensiones similares a la que hemos recomendado en esta lección.
O incluso puede instalar una versión prueba de 30 días del Oxygen XML Editor, que contiene toda clase de herramientas para trabajar con, y manipular, documentos XML.
Sea como fuere, lo importante es tener en cuenta que es posible trabajar con documentos XML, y por tanto TEI, con cualquier editor de texto plano.

Sin embargo, es importante *nunca* usar un procesador de palabras como Microsoft Word o Libreoffice Writer para editar código de computador (XML, Python, Java, etc.).
Los procesadores de palabras no trabajan con texto plano sino con lo que se conoce como *texto con formato*, esto es, texto que incluye códigos no editables por un usuario para cambiar el formato del texto (fuentes, colores, niveles de párrafo, etc.).
Asimismo, los archivos creados por los procesadores de palabras (en formato `.docx`. `.odt`, `.rtf`, etc.) no pueden ser utilizados por un compilador o por otro software diseñado para transformar o procesar archivos de texto plano.



### Formato de archivo XML

Ya sea que trabajemos en VS Code o en BaseX, debemos siempre guardar nuestros documentos XML (y TEI) con la extensión `.xml`.
De lo contrario los editores no reconocerán el formato de archivo apropiado.
Para el primer ejemplo de abajo usaremos el nombre `postal.xml`; para el segundo, `Acosta.xml`.
Desde luego, el lector podrá escoger los nombres que desee para sus documentos.



## Visualización vs. categorización

Quienes estén familiarizados con el lenguaje de marcado [Markdown](https://daringfireball.net/projects/markdown/syntax)
—hoy en día ubicuo en foros técnicos en Internet, así como en [GitHub](https://github.com), [GitLab](https://gitlab.com) y otros repositorios de código—
reconocerán seguramente el uso de asteriscos (`*`), guiones bajos (`_`), numerales (`#`), etc., para hacer que el texto aparezca de cierto modo en el navegador.
Por ejemplo, un texto encerrado entre asteriscos simples será mostrado en *cursivas* y uno encerrado entre asteriscos dobles lo será en **negritas**.
(De hecho, el texto mismo de esta lección está escrito en Markdown siguiendo esas convenciones.)


Es importante saber que tal uso del marcado tiene como finalidad principal la *visualización* del texto, no su categorización o estructuración semántica.
En otras palabras, las marcas o etiquetas de Markdown no indican que un texto sea de cierta categoría semántica (p. ej. el nombre de una persona, de un lugar o de una obra), sino únicamente que el texto ha de ser visualizado o mostrado de cierto modo en un navegador o en otro medio.


Algo parecido ocurre cuando usamos un procesador de palabras para producir un documento de texto con formato (a diferencia de un texto plano producido con un editor como VS Code).
En un procesador de palabras podemos poner el texto en cursivas, negritas o versalitas, o podemos también subrayarlo.
Aun así, el texto formateado de esa manera *no significará nada en sí mismo*:
las cursivas no significarán en sí mismas que el texto sea un título, el subrayado no significará en sí mismo que el texto sea una cita, etc.
Simplemente será mostrado en la pantalla y será impreso en una impresora de ciertas maneras.
De nuevo, para el computador tan será texto con formato, aunque no tendrá una estructura semántica determinada.



Entender la diferencia entre entre *marcado de visualización* (como el de Markdown) y *marcado semántico* (o estructural, como el que veremos a continuación en TEI) es crucial para entender el objetivo de la codificación de textos.
Cuando marcamos un fragmento de texto para codificarlo, lo hacemos *sin* importarnos en principio cómo fue representado originalmente ni cómo pueda ser eventualmente representado en el futuro.
Nos interesa únicamente la función semántica o estructural que un texto particular tenga.
En otras palabras, la representación visual de un texto es en principio independiente de su categorización semántica o estructural, e irrelevante para ella.
En efecto, dos fragmentos de texto pueden tener la misma categoría semántica (p. ej. pueden ser notas aclaratorias) y sin embargo ser representados visualmente de maneras distintas (p. ej. como una nota a pie y como una nota al margen, como un hipervínculo, como un [globo de información](https://es.wikipedia.org/wiki/Informaci%C3%B3n_sobre_herramientas), etc.), y viceversa.
Por eso debemos procurar identificar con precisión las funciones o categorías de los textos, haciendo caso omiso, en la medida de lo posible, del modo como son mostrados en el papel o la pantalla.


Aclaremos mejor esto volviendo a nuestro ejemplo inicial.
Supongamos que en el texto escaneado del que partimos los nombres propios aparecen consistentemente impresos en versalitas.
Por ejemplo [así](quijote.pdf):

<figure>
<a href="quijote.png">
    <img src="quijote.png" alt="Texto escaneado">
	</a>
<figcaption>
    <p>Texto escaneado</p>
</figcaption>
</figure>

{% include figure.html filename="quijote.png" caption="Texto escaneado" %}

Podríamos entonces utilizar una etiqueta de TEI, como por ejemplo [`<name>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-name.html), para marcar o *codificar* los nombres propios como tales:

```xml
Despidióse del cabrero <name>don Quijote</name> y, subiendo otra
vez sobre <name>Rocinante</name>, mandó a <name>Sancho</name> que le siguiese,
el cual lo hizo, con su jumento, de muy mala gana.
```

Luego veremos en detalle qué es y cómo funciona una etiqueta (o más precisamente un *elemento*) en XML y TEI.
Por ahora notemos que la etiqueta *no* significa que el texto haya sido representado originalmente en versalitas (o en ningún otro modo).
Ni tampoco significa que cuando terminemos de codificar el texto y lo transformemos en otros formatos, el texto haya de ser representado de una manera u otra.
Esta etiqueta solo significa que el texto contenido en ella cae bajo la categoría semántica de nombre propio, independientemente de cómo sea —y si lo sea— representado.
(De hecho, podemos codificar exhaustivamente un documento con cientos o miles de etiquetas, sin que ninguna de ellas *aparezca* al final en una eventual representación.)


Cuando uno está empezando a codificar textos en TEI, con frecuencia tiende a confundir los dos tipos de codificación.
Por ejemplo, uno puede querer codificar todos los fragmentos que aparecen en cursivas en el texto original, independientemente de su función o categoría semántica, con una etiqueta de TEI que indica énfasis (p. ej. [`<hi rend="italics">`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-hi.html)).
Esto en sí mismo no necesariamente es un error.
TEI nos permite hacerlo así si eso es lo que queremos
(por ejemplo, si queremos hacer una [facsímil digital](https://www.tei-c.org/release/doc/tei-p5-doc/en/html/PH.html#PHFAX) del documento original).
Sin embargo, bien sabemos que muchas veces el uso de las cursivas no indica énfasis; puede indicar que el texto es un término técnico o el título de una obra, entre otras posibilidades.
En ese último caso, lo más correcto sería codificarlo como un título y no como un caso de énfasis (p. ej. con el elemento  [`<title>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-title.html) de TEI), independientemente —de nuevo— de cómo haya sido originalmente representado y cómo haya de ser representado luego.


Ahora bien, incluso si quisiéramos codificar el uso enfático de las cursivas (digamos, porque nos parece que afecta el sentido el texto), también podríamos hacerlo en TEI, pero nuevamente sin preocuparnos por cómo fue representado o por cómo pudiera eventualmente ser representado después.
Lo que nos interesa ahí es la categoría semántica de énfasis, no su visualización.






# XML y TEI: hacia un estándar de codificación de textos

Desde los inicios de las humanidades digitales en la década de 1960, hubo muchas aproximaciones a la codificación de textos.
Casi que cada proyecto de codificación tenía su propio estándar de codificación, lo que conducía a que los proyectos fueran incompatibles e intraducibles entre sí, entorpeciendo e incluso imposibilitando el trabajo colaborativo.


Para resolver ese problema, hacia la década de 1980 surgió un nuevo estándar de codificación de textos, convenido por numerosos investigadores del todo el mundo, especialmente de universidades anglosajonas:
el *Text Encoding Initiative* (TEI).
"TEI" no solo es el nombre del estándar, sino también el del consorcio internacional encargado de administrarlo (en adelante usaremos las siglas "TEI" sin más para referirnos al estándar).


TEI está construido sobre el lenguaje de marcado [XML](https://es.wikipedia.org/wiki/Extensible_Markup_Language) y es por ello que suele ser denominado a veces como "TEI-XML" (o también "XML/TEI").
Por su parte, XML (que es la sigla para *eXtensible Markup Language*) es un metalenguaje de computador cuyo propósito es describir, por medio de una serie de marcas o etiquetas (*tags* en inglés), un determinado texto objeto.
XML y TEI son *lenguajes de marcado semántico* y en eso se diferencian de los lenguajes de programación como C, Python o Java, que describen objetos, funciones o procedimientos que han de ser *ejecutados* por un computador.



## XML

En ese sentido, para aprender a codificar textos en TEI es necesario conocer un poco de la sintaxis de XML.
Consideremos un brevísimo documento XML de solo dos líneas:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<raíz>mi texto</raíz>
```

(Antes de continuar, vale notar que este código es *representado* con ciertos colores y quizás ciertos tipos de fuentes en el navegador
—de acuerdo con una convenciones establecidas por los diseñadores de la página web—,
aunque en realidad solo sea texto plano.
Este tipo de representación, denominada ["resaltado de sintaxis"](https://es.wikipedia.org/wiki/Resaltado_de_sintaxis) ([*syntax highlighting*](https://en.wikipedia.org/wiki/Syntax_highlighting)), sirve para ayudarnos a identificar partes del código (elementos, comentarios, declaraciones, etc.), pero en realidad es inesencial al código mismo.
El resaltado de sintaxis también es usado en los editores de texto como VS Code.)


La línea 1 es obligatoria en todo documento XML (y en consecuencia en TEI).
Empieza con un `<?` y termina con un `?>`, a diferencia de la mayoría de elementos de XML, que van encerrados simplemente entre `<` y `>`.
Esta es una [declaración de procesamiento](https://www.w3.org/TR/REC-xml/#sec-pi) y por eso tiene los signos de interrogación en las etiquetas de apertura y cierre.
Su función aquí es identificar el tipo de documento como uno de XML, establecer la versión de XML (1.0, que es la actual a la fecha) y la codificación de caracteres usada (UTF-8, que es lo recomendado para textos en español).
Nótense los dos "atributos" en esta declaración: `@version`, cuyo valor es `1.0`; y `@encoding`, cuyo valor es `UTF-8`.
(El signo de `@` no aparece en el código mismo sino solo en la documentación, para facilitar la identificación de atributos. Más abajo volveremos a hablar de ellos.)



La línea 2 contiene propiamente el documento XML.
Consta de una etiqueta de apertura (`<raíz>`), una etiqueta de cierre (`</raíz>`) y un contenido (`mi texto`).
A todo este conjunto —la etiqueta de apertura, el contenido y la etiqueta de cierre— se lo denomina un [elemento](https://www.w3.org/TR/REC-xml/#elemdecls) de XML.
Nótese que la etiqueta de apertura y la de cierre tienen la misma denominación (`raíz`).
Lo que denota a la etiqueta de cierre como tal es que su nombre va precedido de una barra (`/`).
Toda *etiqueta* en XML empieza con un signo de mayor-que (`<`) y termina con uno de menor-que (`>`).
Y todo *elemento* de XML, de nuevo, empieza con una etiqueta de apertura y termina con una de cierre.
Ahora bien, cuando decimos que XML es un lenguaje de marcado por medio de etiquetas estamos diciendo algo solo parcialmente cierto.
Estrictamente hablando, el marcado se hace por medio de los *elementos* de XML, no de etiquetas aisladas, que en sí mismas carecen de contenido.



Los siguientes son algunos ejemplos de elementos *válidos* en XML (el texto encerrado en `<!--  -->` es un comentario de código, que luego aclararemos):

```xml
<!-- primer ejemplo -->
<cita>Caracteres Unicode: áéíóú āēīōū ăĕĭŏŭ ł ž … </cita>

<!-- segundo ejemplo -->
<cita>
  <url>https://archive.org</url>
</cita>

<!-- tercer ejemplo -->
<texto>
  En un lugar de la Mancha, de cuyo nombre no quiero acordarme, no ha
  mucho tiempo que vivía un hidalgo de los de lanza en astillero, adarga
  antigua, rocín flaco y galgo corredor.

  Una olla de algo más vaca que carnero, salpicón las más noches, duelos
  y quebrantos los sábados, lantejas los viernes, algún palomino de
  añadidura los domingos, consumían las tres partes de su hacienda.

  El resto della concluían sayo de velarte, calzas de velludo para las
  fiestas, con sus pantuflos de lo mesmo, y los días de entresemana se
  honraba con su vellorí de lo más fino.
</texto>

<!-- cuarto ejemplo -->
<pb></pb>

<!-- quinto ejemplo -->
<pb/>
```

El primer ejemplo contiene una corta cadena de texto plano.
De acuerdo con la definición del estándar de XML v.1.0, casi cualquier caracter Unicode puede estar en el nombre de un elemento válido, de sus atributos o de su contenido.
Solo hay cinco [caracteres "reservados"](https://es.wikipedia.org/wiki/Anexo:Referencias_a_entidades_de_caracteres_XML_y_HTML) en XML, a saber: `& < > " '`.
Técnicamente se los denomina "entidades de caracter predefinidas" (*predefined character entities*), y no pueden usarse directamente como caracteres normales en los nombres de elementos y atributos, ni en su contenido, por cuanto ya tienen una significación propia en el metalenguaje.
Los signos `< >`, como ya sabemos, construyen etiquetas; las comillas simples (`'`) y dobles (`"`) se usan para indicar el valor de atributos; y el `&` se usa en el nombre de entidades predefinidas.
Es por eso que deben ser introducidos por medio de una serie de códigos, a saber: `&amp; &lt; &gt; &quot; &apos;`, respectivamente (nótese que todos empiezan con un `&` y terminan con un `;`).
Por ejemplo, para introducir el caracter `&` en el título de una obra, usaríamos: `<title>Jack &amp; Jill</title>`.




El segundo ejemplo muestra cómo se anida un elemento (`<url>`, que contiene una dirección de Internet) en otro elemento (`<cita>`).
En efecto, `<url>` sería un "hijo" de `<cita>` (o lo que es lo mismo, `<cita>` sería el "padre" de `<url>`).
Estrictamente hablando, el texto `https://archive.org` hace parte del contenido del elemento `<url>`, no del de su padre, `<cita>`.
El contenido de `<cita>` es la totalidad del elemento `<url>` (que incluye, desde luego, el texto anterior).



El tercer ejemplo muestra que un elemento puede contener saltos de línea;
de hecho, como ya dijimos, puede contener casi cualquier caracter Unicode y ser potencialmente infinito en extensión (limitada tan solo por la memoria del computador).



Los últimos dos ejemplos (`<pb></pb>` y `<pb/>`) son totalmente equivalentes en XML.
Ambos son válidos en XML, aunque su contenido sea *vacío*.
A elementos como este se los denomina [elementos vacíos](https://www.w3.org/TR/REC-xml/#sec-starttags).
Este tipo de elementos es muy común en XML.
Se usa, por ejemplo, cuando se quiere codificar un salto de una página a otra, o de una columna a otra, o de una línea a otra; se puede entonces introducir un elemento vacío cuyo único fin es señalar con precisión dicho salto.


Es recomendable abreviar los elementos vacíos así: `<pb/>` (o equivalentemente `<pb />`; el espacio es insignificante).
Nótese que en la abreviatura la barra (`/`) se pone *antes* de signo de cierre `>`: `<pb/>`
(nunca al principio, puesto que en ese caso indicaría una etiqueta de cierre (`</pb>`), no un elemento vacío).
A las etiquetas de la forma `<pb/>`, que abrevian elementos vacíos, se los suele llamar "etiquetas de auto-cerrado" (*self-closing tags*).



## Validez sintáctica en XML

Todo documento XML debe cumplir dos reglas sintácticas básicas para ser *válido*:

1. debe haber *un solo* elemento raíz (el cual contiene a todos los demás elementos, si los hay) y
2. toda etiqueta de apertura debe tener una etiqueta de cierre.

Una forma equivalente de expresar lo anterior sería diciendo que debe haber un elemento que contenga a todos los demás elementos; y que todo elemento se compone de una etiqueta de apertura, un contenido (que puede ser vacío).

Dado lo anterior, el siguiente sería un ejemplo de un documento XML *inválido*:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<texto>mi texto</texto>
<nota>otro texto</nota>
```

Es inválido porque viola la regla 1 al tener dos elementos raíces: `<texto>` y `<nota>`, ambos independientes el uno del otro.
Para corregirlo, podríamos hacer algo como esto:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<texto>mi texto<nota>otro texto</nota></texto>
```

Vale notar que en XML los caracteres de espacio en blanco (` `, que podemos representar aquí así: `␣`) se colapsan automáticamente: p. ej. esto: `␣␣␣␣␣` se colapsa en esto: `␣`.
Asimismo, los saltos de línea se transforman automáticamente en espacios en blanco: p. ej. esto:

```xml
a
b
```

se colapsa en esto:

```xml
a␣b
```

Así pues, podemos reformatear el anterior documento en una forma más legible así:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<texto>
  mi texto
  <nota>otro texto</nota>
</texto>
```

(Hemos introducido tres saltos de línea que no estaban antes y hemos sangrado el texto dos espacios a la derecha en aras de la legibilidad.
Sin embargo, ambos documentos son esencialmente equivalentes por las razones indicadas.)

El documento es ahora válido, pues solo hay un elemento raíz (el elemento `<texto>`), que incluye al otro elemento (el elemento `<nota>`).


Por otro lado, el siguiente sería un ejemplo de un documento *inválido*, en la medida en viola la segunda regla:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<texto>
  mi texto
  <nota>otro texto
</texto>
```

En este caso, la cuarta línea contiene un elemento incompleto (e inválido), puesto que solo tiene una etiqueta de apertura sin una de cierre correspondiente.


De manera más interesante, el siguiente sería otro ejemplo de un documento *inválido*:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<texto><a></texto></a>
```

Aunque pareciera ser un documento válido —pues aparentemente los dos elementos se abren y se cierran—, lo cierto es que no lo es.
Podemos verlo mejor si lo reformateamos así:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<texto>
  <a>
    </texto>
  </a>
```

En este caso la etiqueta de apertura `<texto>` *no* tiene una etiqueta de cierre correspondiente.
Pero ¿acaso la etiqueta `</texto>` en la cuarta línea no lo es?
No, pues *hace parte del contenido* del elemento `<a>`.
Todo lo que se incluye en el contenido de un elemento pertenece a él, y su significado y alcance, por tanto, se restringen a él.


Este documento es inválido por dos razones:

1. la etiqueta `<texto>` en la línea 2 nunca es cerrada, y
2. la etiqueta de cierre `</texto>` en la línea 4 nunca fue abierta.

Por eso tenemos dos elementos incompletos y en consecuencia inválidos.

Es muy usual cometer errores de sintaxis como el anterior, en el cual se abre una etiqueta y nunca se la cierra (o se cree equivocadamente que se la cerró, al interior de otro elemento inferior).
Esto ocurre, por ejemplo, cuando uno se olvida de incluir la barra final en un elemento vacío como `<pb>`.
Por eso hay que estar muy alertas para evitar que eso suceda.
(Editores especializados para trabajar con XML, como Oxygen XML Editor y BaseX, así como las extensiones para XML en VS Code, pueden ayudarnos a detectar automáticamente ese tipo de errores.)



**Todo documento de XML debe ser sintácticamente válido** o, lo que es lo mismo, debe cumplir las dos reglas anteriores.
Recuérdese que XML es un lenguaje de computador (de marcado, no de ejecución).
Más exactamente, XML es un metalenguaje de computador que describe un lenguaje objeto.
En consecuencia, un documento XML debe poder ser procesado por un computador y por esto es necesario que sea estructuralmente correcto.
Esto nunca lo debemos olvidar: aunque un documento XML sea legible e inteligible para *nosotros* (en especial si lo sangramos apropiadamente), debe sin embargo ser procesable por el *computador*, lo cual requiere mínimamente que sea formalmente válido.
En otras palabras, si el documento no es válido, simplemente no podrá ser visualizado, procesado o transformado por el software diseñado para ello (como mencionaremos al final de esta lección).


También es importante saber que XML es agnóstico con respecto al *contenido* mismo de los documentos.
Esto quiere decir que un documento XML es válido independientemente del *nombre* de sus elementos y atributos, así como del *contenido* y las relaciones existentes entre dichos elementos.
(Esto es lo que "*eXtensible*" —en la sigla "XML"— quiere decir: puede extenderse para describir todo tipo de contenido.)
Mientras las dos reglas anteriores se cumplan, el documento XML será válido, independientemente de su contenido.
Y el contenido de un documento XML se reduce a los tipos de elementos que tenga, al contenido y atributo de estos, y sus relaciones.


## Validación sintáctica de documentos XML

Podemos determinar si un documento XML es sintácticamente válido con ayuda de nuestro editor de texto (VS Code con la extensión XML Complete, o BaseX).
También hay disponibles aplicaciones de validación gratuitas en Internet, por ejemplo esta: https://codebeautify.org/xmlvalidator
o también esta: https://www.xmlvalidation.com

Si copiamos pegamos el último ejemplo en esta (o si subimos el archivo correspondiente), nos arrojará el siguiente error:

<figure>
<a href="xmlvalidator.png">
    <img src="xmlvalidator.png" alt="Validación en línea del último ejemplo">
	</a>
<figcaption>
    <p>Validación en línea del último ejemplo</p>
</figcaption>
</figure>

{% include figure.html filename="xmlvalidator.png" caption="Validación en línea del último ejemplo" %}




## Atributos de los elementos y comentarios en XML

Antes de concluir esta sección es preciso mencionar otras dos cosas que hacen parte del lenguaje XML: los [comentarios](https://www.w3.org/TR/REC-xml/#sec-comments) y los [atributos](https://www.w3.org/TR/REC-xml/#attdecls).
Consideremos el siguiente ejemplo:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<texto xml:lang="es">
  mi texto
  <!-- la siguiente es una nota a pie: -->
  <nota tipo="pie-de-pagina">otro texto</nota>
</texto>
```

La línea 4 contiene un *comentario* en XML (y seguramente el navegador lo visualizará en otro color y/o estilo de fuente), esto es, un texto que sirve para documentar o glosar el código, pero que es ignorado por el computador cuando procesa el documento.
En XML los comentarios se abren con `<!--` y se cierran con `-->`, y pueden contener más de una línea.


Ahora examinemos la línea 5.
Véase cómo dentro de la etiqueta de apertura del elemento `<nota>` tenemos el texto: `tipo="pie-de-pagina"`.
Aquí, `@tipo` es un *atributo* de ese elemento. Sirve para añadir información adicional (opcional y obligatoria) sobre el elemento y su contenido.
En este caso, indica que la nota es a pie de página y no —digamos— una nota al final o al margen.
(Como ya lo dijimos antes, en la documentación —como esta lección— se acostumbra a usar el signo de arroba (`@`) para denotar los atributos de un elemento: p. ej. `@tipo`, aunque ese signo *no* se usa en el código mismo.)
Su valor aquí es `pie-de-pagina` (y se pone entre comillas dobles —como aquí— o comillas simples).


Un mismo elemento puede tener muchos atributos diferentes, como por ejemplo:

```xml
<titulo tipo="canción" genero="bossa-nova" id="342" idioma="portugués">
  Pra machucar meu coraçao
</parrafo>
```

que contiene los atributos `@tipo`, `@genero`, `@id` e `@idioma`, con sus respectivos valores: `canción`, `bossa-nova`, `342` y `portugués`.
Como ya dijimos, los atributos sirven para añadir información estructurada a los elementos de XML.
En la medida en que es un metalenguaje general y abstracto, XML es en sí mismo agnóstico frente a qué elementos son permitidos en qué elementos.
La única restricción sintáctica es que *no se repitan atributos* en un mismo elemento, independientemente de sus valores.
Este elemento, por lo tanto, sería *inválido* en XML:

```xml
<texto tipo="nota" tipo="cita">...</texto>
```

Finalmente, examinemos la línea 2 del ejemplo de arriba:

```xml
<texto xml:lang="es">
```

Tenemos ahí el atributo `@xml:lang`, cuyo valor es `es`.
Nótese el signo `:` en el nombre del atributo.
El nombre que antecede `:` (aquí `xml`) es lo que se denomina "*namespace*" del atributo, en la jerga de XML.
Este es un tema técnico que se escapa a los límites de esta lección.
Baste decir, por ahora, que los *namespaces* sirven para evitar colisiones o cruces de nombres en XML.
`xml:lang` significa que vamos a tomar el atributo `lang` del [*namespace*](https://www.w3.org/TR/xml-names/#sec-namespaces) `xml`.


Arriba habíamos dicho que XML no tiene ningún contenido en sí mismo, debido a que es un metalenguaje abstracto.
Eso es solo parcialmente cierto, sin embargo.
XML sí contiene unos atributos que son comunes a todo elemento posible en dicho lenguaje, independientemente de sus [múltiples implementaciones](https://en.wikipedia.org/wiki/List_of_XML_markup_languages) en concreto.
Esos atributos deben siempre ir con el prefijo `xml:` que los identifica dentro del *namespace* de XML.
Son los siguientes cuatro:

- `xml:id`
- `xml:lang`
- `xml:base`
- `xml:space`

Los primeros dos atributos son muy útiles en TEI.
`xml:id` contiene un identificador único del elemento al que pertenece, algo así como un nombre propio de ese elemento.
(En efecto, si en un documento hubiera más de un elemento con el mismo `xml:id`, el documento sería inválido.)


Por su parte, el atributo `xml:lang` sirve para especificar el idioma del elemento correspondiente: `es` para español, `en` para inglés, etc. (según la especificación [ISO 639-3](https://iso639-3.sil.org/code_tables/639/data)).
Aunque estrictamente hablando a XML no le "importa" en qué idioma esté escrito un documento (o un elemento), podemos usar esa información para fines ulteriores de procesamiento y análisis.
Por ejemplo, si queremos indicar en TEI que una cita está en griego clásico, podemos codificarla así:

```xml
Según Homero,
<quote xml:lang="grc">
  ἄνδρα μοι ἔννεπε, μοῦσα, πολύτροπον, ὃς μάλα πολλὰ
  πλάγχθη, ἐπεὶ Τροίης ἱερὸν πτολίεθρον ἔπερσεν:
</quote>
```

Finalmente, los últimos dos atributos genéricos —`xml:base` y `xml:space`— sirven para especificar respectivamente el [URI](https://es.wikipedia.org/wiki/Identificador_de_recursos_uniforme) de base de un elemento y su *namespace*.
Por ahora no serán de mucho interés para nosotros.




## ¿Qué es TEI, al fin y al cabo?

Hemos dicho que XML es un metalenguaje tan general y tan abstracto que es agnóstico respecto de su contenido (al menos hasta cierto punto, como acabamos de aclarar).
Puede, y hecho es, usado para describir cosas tan disímiles como un texto en griego clásico del siglo VIII [a.e.c.](https://en.wikipedia.org/wiki/List_of_XML_markup_languages) y el mensaje que un termostato inteligente le envía a una aplicación de un *smartphone* usada para controlarlo.


*TEI es una implementación particular de XML.*
Es decir, es una serie de reglas que determinan qué elementos y qué atributos son permitidos en un documento de cierto tipo.
A diferencia de XML, que solo contiene *reglas sintácticas* de validez, TEI (y cualquier otra implementación de XML) contiene además *reglas semánticas*: determina qué tipos elementos y de atributos puede contener un documento.


¿Qué tipo de documento?
TEI está diseñado para describir de una manera exhaustiva y detallada toda clase de *textos* y sus propiedades:
manuscritos, textos impresos, textos de actuación (obras de teatro, libretos, etc.), cartas, ediciones críticas, transcripciones diplomáticas, transcripciones de emisiones orales, facsímiles, diccionarios, corpus lingüísticos, etc.
En efecto, según la [documentación de TEI](https://www.tei-c.org/release/doc/tei-p5-doc/en/html/AB.html#ABTEI2), este pretende —entre otras cosas—

> […] apoyar la codificación de todo tipo de rasgos de todo tipo de textos estudiados por los investigadores.


En ese sentido, **TEI es un lenguaje de marcado para codificar textos de toda clase**, a fin de que sean procesados por un computador, de modo que puedan ser analizados, transformados, reproducidos, almacenados, etc., dependiendo de las necesidades e intereses de los usuarios (tanto los de carne y hueso como los computacionales).
Es por eso que podemos decir, en efecto, que TEI está en el corazón de las humanidades digitales, o al menos en uno de sus corazones.
Es un estándar para trabajar computacionalmente con una clase de objetos tradicionalmente central a las humanidades: los textos.
En ese orden de ideas, mientras que a XML le es indiferente si los elementos de un documento describen textos (o propiedades de textos), TEI está diseñado exclusivamente para trabajar con ellos.


El tipo de elementos y atributos permisibles en TEI, y las relaciones permisibles entre ellos, son prescritos por las reglas semánticas de TEI.
Por ejemplo, si queremos codificar un poema, podemos usar el elemento [`<lg>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-lg.html) (de *line group*, "grupo de líneas") de TEI.
Las reglas de TEI determinan qué tipos de atributos puede tener ese elemento, y qué elementos puede a su vez contener o ser contenidos por él.
TEI prescribe que todo elemento elemento `<lg>` debe tener al menos un elemento elemento [`<l>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-l.html) (de *line*).
A modo de ilustración, examinemos los primeros cuatro versos del soneto *Amor constante más allá de la muerte* de Francisco de Quevedo (a continuación en texto plano):

```
Cerrar podrá mis ojos la postrera
sombra que me llevare el blanco día;
y podrá desatar esta alma mía
hora a su afán ansioso lisonjera;
```

Podemos proponer la siguiente codificación en TEI para él:

```xml
<lg rhyme="abba">
 <l met="x/x/x/x/x/x/x/x/x/x/x/" n="1">Cerrar podrá mis ojos la postrera</l>
 <l n="2">sombra que me llevare el blanco día;</l>
 <l n="3">y podrá desatar esta alma mía</l>
 <l n="4">hora a su afán ansioso lisonjera;</l>
</lg>
```

En este caso, nos hemos valido del atributo `@rhyme` del elemento `<lg>`, para hacer explícito el tipo de rima del pasaje; del atributo `@met` para indicar el tipo de métrica del primer verso (endecasílabo)
(esto tendríamos que hacerlo en cada uno de los versos, aunque por claridad del código lo hemos hecho solo en el primero);
y finalmente el atributo `@n` para indicar el número del verso dentro el grupo.


La comparación entre el texto plano del fragmento del soneto con su codificación nos permite empezar a ver las grandes posibilidades de TEI como un lenguaje de marcado semántico para textos.
No solo queda explícitamente dicho que las líneas (en el código anterior) 2-5 son versos de un poema, sino que ellas tienen un tipo de rima y de métrica.
Una vez codificado todo el poema, o todos los poemas de una colección, podemos —por ejemplo— usar un software para realizar búsquedas estructuradas, de modo que nos arroje todos los poemas que tienen cierto tipo de rima o todas las líneas que tienen cierto tipo de métrica.
O podemos usar (o crear) una aplicación para determinar cuántos versos de los sonetos de Quevedo —si los hay— tienen métrica imperfecta.
O podemos comparar las distintas versiones (los "testigos" o "testimonios" manuscritos e impresos) de los sonetos, para realizar una edición crítica de ellos.


Ahora bien, todo eso y mucho más es posible solo en virtud de que hemos hecho explícito, gracias a TEI, el *contenido* de esos sonetos.
Si solo tuviéramos el texto plano de ellos, sería técnicamente imposible aprovechar herramientas computacionales diseñadas para editar, transformar, visualizar, analizar o publicarlos.








# Un documento mínimo de TEI

A diferencia del pequeño documento de XML que vimos arriba, que constaba de un par de líneas, el documento mínimo de TEI es un poco más largo, aunque no mucho más.
Consideremos el siguiente ejemplo, que posteriormente nos servirá de plantilla para nuestros dos ejercicios:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
      <fileDesc>
         <titleStmt>
            <title>Título</title>
         </titleStmt>
         <publicationStmt>
            <p>Información de publicación</p>
         </publicationStmt>
         <sourceDesc>
            <p>Información sobre la fuente</p>
         </sourceDesc>
      </fileDesc>
  </teiHeader>
  <text>
      <body>
         <p>Algún texto...</p>
      </body>
  </text>
</TEI>
```

La primera línea ya la conocemos; es la declaración del documento XML.
La segunda línea contiene el elemento principal o *raíz* de este documento: el elemento `<TEI>`. El atributo `@xmlns` con el valor `http://www.tei-c.org/ns/1.0` simplemente declara que todos los elementos y atributos hijos del elemento `<TEI>` pertenencen al *namespace* de TEI (representado aquí por ese URL). Eso no tendrá que preocuparnos más en lo sucesivo.


Lo interesante sigue en las líneas 3 y 16, que contienen respectivamente a los dos hijos inmediatos del elemento raíz:

- [`<teiHeader>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-teiHeader.html)
- [`<text>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-text.html)



## El elemento `<teiHeader>`

El elemento `<teiHeader>` contiene todos los metadatos del documento: título, autor, dónde fue publicado, cuándo fue publicado, cómo fue publicado, de dónde se tomó la fuente, etc.
Quienes se inician en el aprendizaje de TEI suelen pasar de largo esa información, llenando estos campos con datos genéricos e incompletos.
Sin embargo, la información del `<teiHeader>` es esencial a la tarea del codificador,
pues sirve para identificar exhaustivamente el texto codificado.


Mínimamente, el `<teiHeader>` contiene un elemento llamado `<fileDesc>` (de *file description*, "descripción del archivo"), que a su vez contiene tres elementos hijos:

- [`<titleStmt>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-titleStmt.html) (de *title statement*, "enunciado de título"): la información sobre el título del documento (dentro del elemento [`<title>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-title.html)); opcionalmente también puede incluir datos sobre el autor si este es conocido (dentro del elemento [`<author>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-author.html)).
- [`<publicationStmt>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-publicationStmt.html) (de *publication statement*, "enunciado de publicación"): la información de cómo está publicado o disponible el documento (el documento mismo TEI, *no* su fuente). En ese sentido es análogo a la información del editor/imprenta en el *imprint* o "página legal" de un libro. Puede ser un párrafo descriptivo (dentro del elemento genérico de párrafo, [`<p>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-p.html)), o puede estar estructurada en uno o varios campos dentro los siguientes elementos:
  - [`<address>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-address.html): la dirección postal del editor/codificador
  - [`<date>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-date.html): la fecha de publicación del documento
  - [`<pubPlace>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-pubPlace.html): el lugar de publicación del documento
  - [`<publisher>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-publisher.html): el editor/codificador del documento
  - [`<ref>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-ref.html)  (o también [`<ptr>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-ptr.html)): una referencia externa (URL) donde está disponible el documento
- [`<sourceDesc>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-sourceDesc.html) (de *source description*, "descripción de la fuente"): la información sobre la *fuente* de la que se toma el texto que está siendo codificado. Puede ser un párrafo descriptivo (dentro del elemento genérico de párrafo, `<p>`). También puede estar estructurada de varias formas. Por ejemplo, puede tener un elemento [`<bibl>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-bibl.html), que incluye una referencia bibliográfica sin estructurar (p. ej. `<bibl>Miguel de Cervantes Saavedra, "Don Quijote de La Mancha", Madrid: Espasa-Calpe, 2010</bibl>`); o puede contener una referencia estructurada en el elemento [`<biblStruct>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-biblStruct.html) (que contiene a su vez otros elementos relevantes).



Supongamos que vamos a codificar el *Quijote* de Cervantes, partiendo de [esta edición](https://archive.org/details/donquijotedelama01cerv) disponible gratuitamente en el [Internet Archive](https://archive.org).
El `<teiHeader>` podría ser el siguiente:

```xml
<teiHeader>
  <fileDesc>
    <titleStmt>
      <title>El ingenioso hidalgo Don Quijote de La Mancha</title>
      <author>Miguel de Cervantes Saavedra</author>
    </titleStmt>
    <publicationStmt>
      <p>
        Codificado en TEI por Nicolás Vaughan en enero de 2021.
        Disponible en https://github.com/nivaca/quijoteuno
      </p>
    </publicationStmt>
    <sourceDesc>
      <p>
        Texto tomado de:
        Miguel de Cervantes Saavedra, "El ingenioso hidalgo Don Quijote de La Mancha". Edición y notas de Francisco Rodríguez Marín. Madrid: Ediciones de La Lectura, 1911.
        Disponible aquí: https://archive.org/details/donquijotedelama01cerv
      </p>
    </sourceDesc>
  </fileDesc>
</teiHeader>
```

Ahora bien, también podríamos estructurarlo más detalladamente así:

```xml
<teiHeader>
  <fileDesc>
    <titleStmt>
      <title>El ingenioso hidalgo Don Quijote de La Mancha</title>
      <author>Miguel de Cervantes Saavedra</author>
    </titleStmt>
    <publicationStmt>
      <publisher>Nicolás Vaughan</publisher>
      <pubPlace>Bogotá, Colombia</pubPlace>
      <date>2021</date>
      <availability>
        <p>Esta es una obra de acceso abierto licenciada bajo una licencia Creative Commons Attribution 4.0 International.</p>
      </availability>
      <ref target="https://github.com/nivaca/quijoteuno"/>
    </publicationStmt>
    <sourceDesc>
      <biblStruct>
        <monogr>
          <author>Miguel de Cervantes Saavedra</author>
          <editor>Francisco Rodríguez Marín</editor>
          <title>El ingenioso hidalgo Don Quijote de La Manchat</title>
          <edition>1</edition>
          <imprint>
            <publisher>Ediciones de La Lectura</publisher>
            <pubPlace>Madrid</pubPlace>
            <date>1911</date>
          </imprint>
        </monogr>
        <ref target="https://archive.org/details/donquijotedelama01cerv"/>
      </biblStruct>
    </sourceDesc>
  </fileDesc>
</teiHeader>
```

Desde luego, la decisión sobre la exhaustividad de la información en el `<teiHeader>` depende de su disponibilidad y obedece a los fines de la codificación.
Por ejemplo, si en un futuro quisiéramos buscar (o visualizar) todas las obras publicadas por cierto editor, sería preciso que incluyéramos pormenorizadamente su nombre dentro de un elemento `<publisher>` (como en este último ejemplo).
Sin embargo, si eso no nos importa, podemos codificar esta información menos detalladamente dentro de un elemento `<p>` (como en el primer ejemplo).



## El elemento `<text>`

Como vimos en el documento mínimo, `<text>` es el segundo hijo de `<TEI>`.
Contiene todo el texto del documento.
De acuerdo con la [documentación de TEI](https://tei-c.org/guidelines/p5/), `<text>` puede contener una serie de elementos en los que el texto objeto se ha de estructurar:

<figure>
<a href="textcontains.png">
    <img src="textcontains.png" alt="Elementos posibles de <code>&lt;text&gt;</code>">
	</a>
<figcaption>
    <p>Elementos posibles de <code>&lt;text&gt;</code></p>
</figcaption>
</figure>

{% include figure.html filename="textcontains.png" caption="Elementos posibles de <text>" %}

El más importante de estos elementos, y el que con mayor frecuencia usaremos, es [`<body>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-body.html), que contiene el cuerpo principal del texto.
Sin embargo, otros elementos importantes como hijos de `<text>` son [`<front>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-front.html), que  contiene lo que se conoce como el *frontmatter* o "páginas preliminares" de un texto (introducción, prólogo, etc.), y [`<back>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-back.html), que contiene el *backmatter* o "páginas finales" (los apéndices, índices, etc.).



Por su parte, `<body>` puede contener muchos otros elementos:

<figure>
<a href="bodycontains.png">
    <img src="bodycontains.png" alt="Elementos posibles de <code>&lt;body&gt;</code>">
	</a>
<figcaption>
    <p>Elementos posibles de <code>&lt;body&gt;</code></p>
</figcaption>
</figure>

{% include figure.html filename="bodycontains" caption=""Elementos posibles de <body>" %}


Toda esta variedad de posibilidades puede abrumarnos a primera vista.
Con todo, debemos pensar que nuestro texto suele dividirse naturalmente en secciones o partes constitutivas.
Es recomendable, entonces, usar el elemento [`<div>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-div.html) para cada una de ellas y usar atributos como `@type` o `@n` para cualificar sus diferentes clases y posición en el texto (p. ej. `<div n="3" type="subsección">...</div>`).


Si nuestro texto es corto o simple, podríamos usar un solo `<div>`.
Si es más complejo, usaríamos varios.
Por ejemplo:


```xml
<text>
  <body>
    <div>
      <!-- aquí iría la primera sección o división -->
    </div>
    <div>
      <!-- aquí iría la segunda sección o división -->
    </div>
    <!-- etc. -->
  </body>
</text>
```

La estructura de nuestro documento TEI debe buscar replicar, en la medida de lo posible y de nuestros intereses, la estructura del texto objeto.
En otras palabras, el documento TEI debe tender a ser *isomorfo* a su texto objeto.
Si nuestro texto objeto se divide en capítulos, y estos se dividen en secciones o apartados, y a su vez estos en párrafos, debemos buscar replicar esa estructura en el documento TEI.
Para los capítulos y las secciones podemos usar el elemento `<div>`. Y para los párrafos, el elemento [`<p>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-p.html).
Considérese, por ejemplo, el siguiente esquema:

```xml
<text>
  <body>
    <div type="capítulo" n="1">
      <!-- este es el primer capítulo -->
      <div type="sección" n="1">
        <!-- esta es la primera sección -->
        <p>
          <!-- este es el primer párrafo -->
        </p>
        <p>
          <!-- este es el segundo párrafo -->
        </p>
        <!-- ... -->
      </div>
    </div>
    <!-- ... -->
  </body>
</text>
```

Quizás debamos explicar en mayor detalle aquello de "en la medida ... de nuestros intereses".
TEI nos permite codificar exhaustivamente muchos los aspectos y propiedades de un texto.
Sin embargo, en ocasiones no nos interesan todos ellos.
Es más, el proceso de codificación puede extenderse innecesariamente en el tiempo si codificamos elementos que nunca hayamos de aprovechar.

Por ejemplo, si estamos codificando el texto de una edición impresa, puede ser que las divisiones de línea en los párrafos no sean relevantes para nuestra codificación.
En ese caso podemos obviarlas y quedarnos solo con las divisiones de párrafo, sin descender más allá de ellas.
O quizás nos sintamos tentados a codificar sistemáticamente todas las fechas y los nombres de lugares (con los elementos [`<date>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-date.html) y [`<placeName>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-placeName.html) respectivamente) que aparezcan en nuestro texto objeto, aun cuando nunca los aprovechemos posteriormente.
Hacerlo no es un error, desde luego; pero quizás perdamos tiempo valioso en ello.


Podemos formular este principio así:
**Codifiquemos todos los elementos que tengan una determinada significación para nosotros, teniendo en cuenta que eventualmente los habremos de aprovechar para un fin concreto.**

La última parte de este principio concierne a los usos eventuales (muchas veces impredecibles) de nuestra codificación.
Seguramente usaremos el lenguaje de transformaciones [XSLT](https://www.w3.org/TR/xslt/) para convertir luego nuestro documento XML-TEI en otros tipos de documento (texto plano, XHTML, CSV, LaTeX, etc.).
En dicho caso, las plantillas (*templates*) de transformación XSLT que usemos tendrán que corresponder a cada uno de los tipos de elementos que nuestro documento TEI tenga (p. ej. una plantilla para todos los elementos `<p>`, otra para todos los elementos `<note>`, etc.); de modo que si para nuestros fines inmediatos (o eventuales) ciertos elementos son irrelevantes, lo mejor es no codificarlos en absoluto.




# Dos ejemplos

A continuación examinaremos dos ejemplos de codificación de textos breves, a fin de ilustrar las posibilidades que TEI ofrece.


## Primer ejemplo: una postal

Consideremos la siguiente [postal](https://commons.wikimedia.org/wiki/File:Postal_de_Federico_a_Antonio_de_Luna.jpg) de Federico García Lorca.

<figure>
<a href="postal.jpg">
    <img src="postal.jpg" alt="Postal de Federico García Lorca">
	</a>
<figcaption>
    <p>Postal de Federico García Lorca</p>
</figcaption>
</figure>

{% include figure.html filename="postal.jpg" caption="Postal de Federico García Lorca" %}

Como es obvio, las postales tiene dos caras: la frontal, que contiene una foto, y la de atrás, que contiene la dirección, la estampilla y el texto.
En TEI podríamos usar dos elementos `<div>` para cada cara.
De hecho, podríamos usar el atributo `@type` para distinguirlas (con los valores `recto` y `verso` respectivamente), así:

```xml
<text>
  <body>
    <div type="recto">
      <!-- aquí iría la cara frontal -->
    </div>
    <div type="verso">
      <!-- aquí iría la cara de atrás -->
    </div>
  </body>
</text>
```

Para este primer ejemplo solo tenemos la parte de atrás, aunque esto será suficiente por ahora.
(De hecho, a menos que la fotografía de la cara frontal contuviera algún texto, no podríamos codificarla apropiamente.)
Podemos identificar al menos cuatro partes estructurales en nuestra postal:

- el mensaje
- los saludos ("Saludos de Salvador D.")
- la dirección
- las estampillas

Recordemos que nuestra codificación no debe ser una representación gráfica —una visualización— del texto, sino una respresentación semántica de este.
En ese sentido, podemos usar cuatro elementos `<div>` para cada una de las partes de nuestra postal, sin tener en cuenta su ubicación espacial exacta.
(Si dicha ubicación nos interesara, sin embargo, podríamos valernos de los elementos que TEI ofrece para codificar [facsímiles digitales](https://tei-c.org/release/doc/tei-p5-doc/en/html/PH.html#PHFAX).
Por ahora los pasaremos por alto.)
Podemos empezar entonces con la siguiente estructura:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <fileDesc>
      <titleStmt>
        <title>Postal a Antonio Luna del 14 de mayo de 1926</title>
        <author>Federico García Lorca</author>
      </titleStmt>
      <publicationStmt>
        <publisher>Nicolás Vaughan</publisher>
        <pubPlace>Bogotá, Colombia</pubPlace>
        <date>2021</date>
        <availability>
          <p>Esta es una obra de acceso abierto licenciada bajo una licencia Creative Commons Attribution 4.0 International.</p>
        </availability>
      </publicationStmt>
      <sourceDesc>
        <biblStruct>
          <monogr>
            <author>Federico García Lorca</author>
            <title>Postal a Antonio Luna</title>
            <imprint>
              <pubPlace>Cadaqués, Barcelona</pubPlace>
              <date>1926</date>
            </imprint>
          </monogr>
          <ref target="https://commons.wikimedia.org/wiki/File:Postal_de_Federico_a_Antonio_de_Luna.jpg"/>
        </biblStruct>
      </sourceDesc>
    </fileDesc>
  </teiHeader>
  <text>
    <body>
      <div type="saludos">
        <!-- aquí va el texto de los saludos -->
      </div>
      <div type="mensaje">
        <!-- aquí va el texto del mensaje -->
      </div>
      <div type="dirección">
        <!-- aquí va el texto de la dirección-->
      </div>
      <div type="estampillas">
        <!-- aquí va el texto de las estamillas y los sellos postales -->
      </div>
    </body>
  </text>
</TEI>
```

El `<teiHeader>` de este código contiene los datos básico de la postal (disponible libremente en la página de [Wikimedia Commons](https://commons.wikimedia.org/).)
En el `<text>` hemos incluido los tres elementos `<div>` correspondientes a las partes que hemos identificado.
Asimismo, hemos asignado los valores `mensaje`, `dirección` y `estampillas` (así, en español) al atributo `@type`.
El uso de este atributo es opcional: el documento bien podría no tenerlo y seguir siendo válido.
Sin embargo, este atributo nos sirve a nosotros para distinguir los diferentes tipos de `<div>` en nuestro documento.
De nuevo, vale la pena que los codifiquemos (así como hicimos atrás) solo si esperamos eventualmente valernos de esa información para algo en concreto (p. ej. si quieremos extraer solo la información de los sellos postales).

En lugar del atributo `@type`, también es usual utilizar el [atributo global](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.html) [`@n`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.html#tei_att.n), que sirve para enumerar los elementos de un mismo tipo.
Por ejemplo:

```xml
<text>
  <body>
    <div n="1">
      <!-- aquí va el texto de los saludos -->
    </div>
    <div n="2">
      <!-- aquí va el texto del mensaje -->
    </div>
    <div n="3">
      <!-- aquí va el texto de la dirección-->
    </div>
    <div n="4">
      <!-- aquí va el texto de las estamillas y los sellos postales -->
    </div>
  </body>
</text>
```

Para nuestros fines, sin embargo, el atributo `@type` estará bien.
Continuemos.

### Primer `<div>`: los saludos

Puesto que este es un texto manuscrito, va a ser importante para nosotros tener en cuenta los saltos de línea.
Usaremos para ello el elemento de autocerrado [`<lb/>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-lb.html).
Empecemos, pues, a codificar el primer `<div>`:

```xml
<div type="saludos">
  <p>
    <lb n="1"/>Saludos de Salvador Da.
  </p>
</div>
```

Nótese, primero, que el hijo inmediato del `<div>` es un elemento de párrafo `<p>`.
Eso se debe a que, de acuerdo con [las reglas semánticas de TEI para los `<div>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-div.html), estos elementos *no pueden contener texto plano inmediatamente*, sino que deben contener otros elementos (como por ejemplo `<p>`).
Hay personas que prefieren usar aquí el elemento [`<ab>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-ab.html) (*anonymous block*, "bloque anónimo") en lugar del elemento `<p>`.
Hacen eso porque consideran, con cierta razón, que este no es propiamente un párrafo de texto sino un bloque genérico de texto.
Para nosotros esta distinción no será tan importante por ahora, por lo que usaremos tranquilamente un elemento `<p>`.


Segundo, nótese que  el elemento vacío `<lb/>` va *al principio* de la línea que identifica, no al final, como podría esperarse.
Como mencionamos arriba, este tipo de elementos —denominados "mojones" (*milestones*)— sirve para indicar lugares liminales en el texto (saltos de línea, en este caso, pero también saltos de página o de columna, entre otros).

Veamos, asimismo, que los saludos nombran a "Salvador Da.", seguramente Salvador Dalí.
Haremos entonces dos cosas.
Primero, pondremos dicho nombre en el contenido de un elemento [`<persName>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-persName.html).
(Podríamos hacerlo también en un elemento [`<name>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-name.html), aunque la elección de `<persName>` es semánticamente más precisa.)

```xml
<div type="saludos">
  <p>
    <lb n="1"/>Saludos de <persName>Salvador Da.</persName>
  </p>
</div>
```

Segundo, es evidente que "Da." (incluido el punto) es una abreviatura para "Dalí".
TEI nos ofrece el elemento [`<abbr>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-abbr.html) para codificar abreviaturas
y el elemento [`<expan>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-expan.html) para hacer otro tanto con sus expansiones.
El conjunto de una abreviatura y su expansión deben ponerse dentro de un elemento [`<choice>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-choice.html) (que más adelante volveremos a ver cuando hagamos normalizaciones) a fin de conectarlos, así:

```xml
<choice>
  <abbr></abbr>
  <expan></expan>
</choice>
```

Todo el `<div>` quedaría entonces así:

```xml
<div type="saludos">
  <p>
    <lb n="1"/>Saludos de
    <persName>
      Salvador
      <choice>
        <abbr>Da.</abbr>
        <expan>Dalí</expan>
      </choice>
    </persName>
  </p>
</div>
```

(De nuevo, los saltos de líneas en el código son irrelevantes y los incluimos aquí para facilitar su legilibilidad.)

Ahora bien, en la imagen de nuestra postal el saludo aparece subrayado.
¿Cuál es el propósito de dicho subrayado?
En mi opinión, la raya solo sirve aquí para separar este texto del resto.
Su función es estructural, no enfática.
Por esa razón no la vamos a codificar; simplemente incluimos estos "saludos" en un `<div>` independiente.
Sin embargo, si opináramos que su función es enfática, podríamos usar el elemento [`<hi>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-hi.html) (*highlight*, "resaltado"), con el atributo [`@rend`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.rendition.html) (*rendition*, "representación") y el valor `underline` para codificar tal uso enfático, así:


```xml
<div type="saludos">
  <p>
    <hi rend="underline">
      <lb n="1"/>Saludos de
      <persName>
        Salvador
        <choice>
          <abbr>Da.</abbr>
          <expan>Dalí</expan>
        </choice>
      </persName>
    </hi>
  </p>
</div>
```




### Segundo `<div>`: el mensaje

Continuemos ahora con el texto del mensaje, que va dentro de nuestro segundo `<div>`.
Transcribamos las trece líneas del texto y codifiquémoslas inicialmente así:

```xml
<div type="mensaje">
  <p>
    <lb n="1"/>Querido Antonito: Enmedio de
    <lb n="2"/>un ambiente delicioso de mar,
    <lb n="3"/>fotografos y cuadros cubistas
    <lb n="4"/>te saludo y te abrazo.
    <lb n="5"/>Dali y yo preparamos una
    <lb n="6"/>cosa que estará moll bé.
    <lb n="7"/>Una cosa moll bonic.
    <lb n="8"/>Sin darme cuenta me he
    <lb n="9"/>impuesto en el Catalan.
    <lb n="10"/>Adios Antonio. Saluda a tu padre.
    <lb n="11"/>Y saludate tu con mi mejor inalterable
    <lb n="12"/>amistad. ¡Has visto lo que han hecho con Paquito! (Silencio)
    <lb n="13"/>Federico
  </p>
</div>
```

Notemos que no hemos corregido o "normalizado" la ortografía en nuestra transcripción del texto.
Esto es importante porque hemos querido capturar al texto mismo, sin mayores intervenciones editoriales.
(Esto es lo que se denomina una "transcripción diplomática".)
Sin embargo, en el presente caso nos interesa también intervenir editorialmente el texto, normalizando su ortografía.
Para ello usaremos el elemento [`<orig>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-orig.html) para codificar el texto original (antes de la normalización),
y el elemento [`<reg>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-reg.html) para codificar el texto regularizado o normalizado.
Como con las abreviaturas y sus expansiones, debemos incluir la pareja de elementos en un elemento `<choice>`, así:

```xml
<choice>
  <orig></orig>
  <reg></reg>
</choice>
```

Normalicemos entonces todo lo que lo requiera, así:


```xml
<div type="mensaje">
  <p>
    <lb n="1"/>Querido Antonito:
    <choice>
      <orig>Enmedio</orig>
      <expan>En medio</expan>
    </choice>
    de
    <lb n="2"/>un ambiente delicioso de mar,
    <lb n="3"/>
    <choice>
      <orig>fotografos</orig>
      <expan>fotógrafos</expan>
    </choice>
    y cuadros cubistas
    <lb n="4"/>te saludo y te abrazo.
    <lb n="5"/>
    <choice>
      <orig>Dali</orig>
      <reg>Dalí</reg>
    </choice>
    y yo preparamos una
    <lb n="6"/>cosa que estará moll bé.
    <lb n="7"/>Una cosa moll bonic.
    <lb n="8"/>Sin darme cuenta me he
    <lb n="9"/>impuesto en el
    <choice>
      <orig>Catalan</orig>
      <reg>catalán</reg>
    </choice>.
    <lb n="10"/>
    <choice>
      <orig>Adios</orig>
      <reg>Adiós</reg>
    </choice>
    Antonio. Saluda a tu padre.
    <lb n="11"/>Y
    <choice>
      <orig>saludate tu</orig>
      <reg>salúdate tú</reg>
    </choice>
    con mi mejor inalterable
    <lb n="12"/>amistad. ¡Has visto lo que han hecho con Paquito! (Silencio)
    <lb n="13"/>Federico
  </p>
</div>
```

Tenemos también varios nombres propios: "Antonito", "Dalí", "Antonio", "Paquito" y "Federico".
Codifiquémoslos ahora con ayuda del elemento `<persName>`:

```xml
<div type="mensaje">
  <p>
    <lb n="1"/>Querido <persName>Antonito</persName>:
    <choice>
      <orig>Enmedio</orig>
      <expan>En medio</expan>
    </choice>
    de
    <lb n="2"/>un ambiente delicioso de mar,
    <lb n="3"/>
    <choice>
      <orig>fotografos</orig>
      <expan>fotógrafos</expan>
    </choice>
    y cuadros cubistas
    <lb n="4"/>te saludo y te abrazo.
    <lb n="5"/>
    <persName>
      <choice>
        <orig>Dali</orig>
        <reg>Dalí</reg>
      </choice>
    </persName>
    y yo preparamos una
    <lb n="6"/>cosa que estará moll bé.
    <lb n="7"/>Una cosa moll bonic.
    <lb n="8"/>Sin darme cuenta me he
    <lb n="9"/>impuesto en el
    <choice>
      <orig>Catalan</orig>
      <reg>catalán</reg>
    </choice>.
    <lb n="10"/>
    <choice>
      <orig>Adios</orig>
      <reg>Adiós</reg>
    </choice>
    <persName>Antonio</persName>. Saluda a tu padre.
    <lb n="11"/>Y
    <choice>
      <orig>saludate tu</orig>
      <reg>salúdate tú</reg>
    </choice>
    con mi mejor inalterable
    <lb n="12"/>amistad. ¡Has visto lo que han hecho con <persName>Paquito</persName>! (Silencio)
    <lb n="13"/><persName>Federico</persName>
  </p>
</div>
```

Nótese que en el caso de "Dalí" todo el elemento `<persName>` contiene a la pareja normalizada.

```xml
<persName>
  <choice>
    <orig>Dali</orig>
    <reg>Dalí</reg>
  </choice>
</persName>
```

Ahora bien, las líneas 6 y 7 (en el texto de la imagen) contiene texto en otra lengua, el catalán.
TEI nos permite codificar el cambio de idioma con el elemento [`<foreign>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-foreign.html).
Para identificar el idioma usamos el atributo de XML `@xml:lang` con el valor [`cat`](https://iso639-3.sil.org/code/cat).
Esas dos líneas quedarán así:

```xml
<lb n="6"/>cosa que estará <foreign xml:lang="cat">moll bé</foreign>.
<lb n="7"/>Una cosa <foreign xml:lang="cat">moll bonic</foreign>.
```

Aunque no es obligatorio, sí es recomendable hacer explícito el idioma del texto principal, en este caso español.
Esto lo hacemos con el atributo de XML `@xml:lang` y el valor [`spa`](https://iso639-3.sil.org/code/spa) en el elemento `<text>`:

```xml
<text xml:lang="spa">
  <!-- aquí va todo el texto del documento -->
</text>
```

¿Qué más podemos codificar aquí?
Primero, notemos que hace falta una coma en la línea 3 (en el texto de la imagen).
Introducirla en el etexto sería también una forma de intervención editorial.
TEI nos ofrece el elemento [`<corr>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-corr.html) para introducir una corrección editorial, así:

```xml
y cuadros cubistas<corr>,</corr>
```

Eso significa que el editor (o codificador, en este caso nosotros) ha introducido `,` en el texto.
(Nótese que *no* hemos dejado un espacio en blanco entre `cubistas` y `<corr>,</corr>`.)



Por otro lado, notemos que "Federico", en la línea 13 (en el texto de la imagen), es la firma del autor de la postal.
TEI tiene el elemento [`<signed>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-signed.html) para codificarlo.
Si leemos la documentación de TEI, este elemento no puede ser un hijo de `<p>` sino solo de los siguientes elementos:

<figure>
<a href="signedcontained.png">
    <img src="signedcontained.png" alt="<code>&lt;signed&gt;</code> puede estar contenido aquí">
	</a>
<figcaption>
    <p><code>&lt;signed&gt;</code> puede estar contenido aquí</p>
</figcaption>
</figure>

{% include figure.html filename="signedcontained.png" caption="<signed> puede estar contenido aquí" %}


Aquí usaremos el elemento [`<closer>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-closer.html), que codifica el cierre de una carta o postal.
Lo que haremos ahora será sacar el código `<persName>Federico</persName>` del elemento `<p>` que lo contiene, lo meteremos en un elemento `<signed>` y finalmente lo incluiremos en un nuevo elemento `<closer>`, así:

```xml
<closer>
  <signed><persName>Federico</persName></signed>
</closer>
```

Nótese que hemos eliminado el `<lb n="13"/>` de esto.
La razón es que los mojones `<lb/>` hacen parte elemento `<p>`, es decir, son líneas de un párrafo.
Como hemos sacado la firma del párrafo y hemos creado una nueva división (`<closer>`), ya no es necesario que introduzcamos un nuevo salto de línea.
Dicho con otras palabras, este salto de línea cumple una función estructural, al igual que el subrayado de los "saludos" y en la firma misma.
(Sin embargo, si alguien quisiera introducir el `<lb n="13"/>`, bien podría hacerlo antes del `<signed>`. TEI no lo prohíbe.)


Solo nos hace falta una última cosa por codificar en el mensaje de la postal.
La palabra "inalterable" (en la línea 11) está subrayada.
A diferencia de los "saludos" y de la firma, la función del subrayado parece ser en este caso de énfasis.
Usaremos el elemento `<hi>` con el atributo `@rend` y el valor `underline` para codificarlo:

```xml
con mi mejor <hi rend="underline">inalterable</hi>
```


### Tercer `<div>`: la dirección
TEI nos ofrece el elemento [`<address>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-address.html), compuesto de varios elementos [`<addrLine>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-addrLine.html), para codificar esta información.
De acuerdo con la documentación de TEI, sin embargo, `<address>` debe estar contenido —entre otras— en un elemento [`<opener>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-opener.html), que sirve para codificar el inicio (*opener*) de una carta o postal.
Nuestro código será entonces el siguiente:

```xml
<div type="dirección">
  <opener>
    <address>
      <addrLine>Sr D. Antonio Luna</addrLine>
      <addrLine>Acera de Dairo 62</addrLine>
      <addrLine>Granada</addrLine>
    </address>
  </opener>
</div>
```

Podemos hacer al menos tres cosas aún.
Primero, vamos a expandir las abreviaturas "Sr" y "D." a "Señor" y "Don", respectivamente
(y vamos también a normalizar "Sr" como "Sr.")
Segundo, vamos a codificar "Antonio Luna" como un nombre de persona, con ayuda del elemento `<persName>`.
Y tercero, vamos codificar "Granada" como un nombre de lugar, con ayuda del elemento [`<placeName>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-placeName.html).


Finalmente, en la segunda línea de la dirección, la caligrafía no es del todo clara —al menos para mí—.
¿Dice "Dairo" o "Darío"?
Para casos de ilegilibilidad (o dificultad para leer), TEI nos ofrece varias opciones.
Una es usar el elemento [`<unclear>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-unclear.html) para encerrar el texto involucrado.
Otra es usar el atributo [`@cert`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.responsibility.html), con los valores `low`, `mid` o `high`, para indicar el grado de certeza que tiene el transcriptor o editor con respecto a un cierto texto.
Este atributo se incluye en el elemento inmediatamente superior, en este caso el segundo `<addrLine>`.
Ahora bien, como el texto dudoso no es toda la línea sino solo una palabra, acaso lo más conveniente sea usar la opción de `<unclear>`.

El código completo quedaría así:

```xml
<div type="dirección">
  <opener>
    <address>
      <addrLine>
        <choice>
          <abbr>
            Sr<corr>.</corr>
          </abbr>
          <expan>Señor</expan>
        </choice>
        <choice>
          <abbr>D.</abbr>
          <expan>Don</expan>
        </choice>
        <persName>Antonio Luna</persName>
      </addrLine>
      <addrLine>
        Acera de <unclear>Dairo</unclear> 62
      </addrLine>
      <addrLine>
        <placeName>Granada</placeName>
      </addrLine>
    </address>
  </opener>
</div>
```

### Cuarto `<div>`: los sellos

El último `<div>` contiene los sellos postales y demás información impresa.
Aquí tenemos tres textos: "TARJETA POSTAL", "CORRESPONDENCIA" y un sello parcialmente legible que quizás diga "BARCELONA".
Para ellos usaremos el elemento [`<stamp>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-stamp.html) de TEI.
Según la documentación, puede ir incluido —entre otras posibilidades— en un elemento `<ab>` (aunque no en un `<p>`).


Asimismo, encima del sello hallemos un pedazo de una estampilla verde.
Como no podemos descifrar su contenido, no podemos codificar nada de él.
La opción más común sería excluirlo por completo del documento TEI.
Sin embargo, otra opción sería usar el elemento [`<gap>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-gap.html) para indicar una laguna en el texto.
Como no tiene contenido (pues no lo conocemos), podemos usar la forma abreviada `<gap/>`
Hagámoslo así por mor de la exhaustividad.

El código completo sería:

```xml
<div type="estampillas">
  <ab>
    <stamp>Tarjeta Postal</stamp>
    <stamp>Correspondencia</stamp>
    <stamp><unclear>Barcelona</unclear></stamp>
    <stamp><gap/></stamp>
  </ab>
</div>
```

Hemos decido no transcribir en mayúsculas estos textos puesto que su representación visual es irrelevante para su contenido.

### Código completo del documento

El [código completo](postal.xml) del documento TEI de la postal es el siguiente:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <fileDesc>
      <titleStmt>
        <title>Postal a Antonio Luna del 14 de mayo de 1926</title>
        <author>Federico García Lorca</author>
      </titleStmt>
      <publicationStmt>
        <publisher>Nicolás Vaughan</publisher>
        <pubPlace>Bogotá, Colombia</pubPlace>
        <date>2021</date>
        <availability>
          <p>Esta es una obra de acceso abierto licenciada bajo una licencia Creative Commons Attribution 4.0 International.</p>
        </availability>
      </publicationStmt>
      <sourceDesc>
        <biblStruct>
          <monogr>
            <author>Federico García Lorca</author>
            <title>Postal a Antonio Luna</title>
            <imprint>
              <pubPlace>Cadaqués, Barcelona</pubPlace>
              <date>1926</date>
            </imprint>
          </monogr>
          <ref target="https://commons.wikimedia.org/wiki/File:Postal_de_Federico_a_Antonio_de_Luna.jpg"/>
        </biblStruct>
      </sourceDesc>
    </fileDesc>
  </teiHeader>
  <text xml:lang="spa">
    <body>
      <div type="saludos">
        <p>
          <lb n="1"/>Saludos de
          <persName>
            Salvador
            <choice>
              <abbr>Da.</abbr>
              <expan>Dalí</expan>
            </choice>
          </persName>
        </p>
      </div>
      <div type="mensaje">
        <p>
          <lb n="1"/>Querido <persName>Antonito</persName>:
          <choice>
            <orig>Enmedio</orig>
            <expan>En medio</expan>
          </choice>
          de
          <lb n="2"/>un ambiente delicioso de mar,
          <lb n="3"/>
          <choice>
            <orig>fotografos</orig>
            <expan>fotógrafos</expan>
          </choice>
          y cuadros cubistas<corr>,</corr>
          <lb n="4"/>te saludo y te abrazo.
          <lb n="5"/>
          <persName>
            <choice>
              <orig>Dali</orig>
              <reg>Dalí</reg>
            </choice>
          </persName>
          y yo preparamos una
          <lb n="6"/>cosa que estará <foreign xml:lang="cat">moll bé</foreign>.
          <lb n="7"/>Una cosa <foreign xml:lang="cat">moll bonic</foreign>.
          <lb n="8"/>Sin darme cuenta me he
          <lb n="9"/>impuesto en el
          <choice>
            <orig>Catalan</orig>
            <reg>catalán</reg>
          </choice>.
          <lb n="10"/>
          <choice>
            <orig>Adios</orig>
            <reg>Adiós</reg>
          </choice>
          <persName>Antonio</persName>. Saluda a tu padre.
          <lb n="11"/>Y
          <choice>
            <orig>saludate tu</orig>
            <reg>salúdate tú</reg>
          </choice>
          con mi mejor <hi rend="underline">inalterable</hi>
          <lb n="12"/>amistad. ¡Has visto lo que han hecho con <persName>Paquito</persName>! (Silencio)
        </p>
        <closer>
          <signed><persName>Federico</persName></signed>
        </closer>
      </div>
      <div type="dirección">
        <opener>
          <address>
            <addrLine>
              <choice>
                <abbr>
                  Sr<corr>.</corr>
                </abbr>
                <expan>Señor</expan>
              </choice>
              <choice>
                <abbr>D.</abbr>
                <expan>Don</expan>
              </choice>
              <persName>Antonio Luna</persName>
            </addrLine>
            <addrLine>
              Acera de <unclear>Dairo</unclear> 62
            </addrLine>
            <addrLine>
              <placeName>Granada</placeName>
            </addrLine>
          </address>
        </opener>
      </div>
      <div type="estampillas">
        <ab>
          <stamp>Tarjeta Postal</stamp>
          <stamp>Correspondencia</stamp>
          <stamp><unclear>Barcelona</unclear></stamp>
          <stamp><gap/></stamp>
        </ab>
      </div>
    </body>
  </text>
</TEI>
```

Aunque VS Code y BaseX nos dicen que nuestro código es sintácticamente válido en XML, podemos verificar que también es semánticamente válido en TEI con ayuda del [TBE Validation Service](https://teibyexample.org/tools/TBEvalidator.htm):

<figure>
<a href="postalvalidation.png">
    <img src="postalvalidation.png" alt="Validación TEI del código de la postal">
	</a>
<figcaption>
    <p>Validación TEI del código de la postal</p>
</figcaption>
</figure>

{% include figure.html filename="postalvalidation.png" caption="Validación TEI del código de la postal" %}












## Segundo ejemplo

Para nuestro segundo ejemplo hemos escogido un fragmento de un manuscrito de la escritora colombiana Soledad Acosta de Samper (1833-1913), su *Pequeño manual del estudiante de historia universal* (sin fecha).
Este fragmento es muy interesante para nuestros fines pues introduce notas y correcciones, entre otros rasgos textuales.
Como veremos, TEI es lo bastante potente como para lidiar con todos ellos.


La imagen de la p.59 (disponible libremente en la [Biblioteca Digital Soledad Acosta de Samper](https://soledadacosta.uniandes.edu.co/items/show/408)) es la siguiente:

<figure>
<a href="SA_059.png">
    <img src="SA_059.png" alt="'Pequeño manual del estudiante de historia universal', tomo 1, p.59">
	</a>
<figcaption>
    <p><em>Pequeño manual del estudiante de historia universal</em> de Soledad Acosta de Samper, tomo 1, p.59</p>
</figcaption>
</figure>

{% include figure.html filename="SA_059.png" caption="\"Pequeño manual del estudiante de historia universal\" de Soledad Acosta de Samper, tomo 1, p.59" %}


### El `<teiHeader>`
En este caso, el `<teiHeader>` de nuestro documento será el siguiente:

```xml
<teiHeader>
  <fileDesc>
    <titleStmt>
      <title>Pequeño manual del estudiante de historia universal, tomo 1, p.59</title>
      <author>Soledad Acosta de Samper</author>
    </titleStmt>
    <publicationStmt>
      <publisher>Nicolás Vaughan</publisher>
      <pubPlace>Bogotá, Colombia</pubPlace>
      <date>2021</date>
      <availability>
        <p>Esta es una obra de acceso abierto licenciada bajo una licencia Creative Commons Attribution 4.0 International.</p>
      </availability>
    </publicationStmt>
    <sourceDesc>
      <biblStruct>
        <monogr>
          <author>Soledad Acosta de Samper</author>
          <title>Pequeño manual del estudiante de historia universal, tomo 1, p.59</title>
          <imprint>
            <pubPlace>Sin lugar</pubPlace>
            <date>Sin fecha</date>
          </imprint>
        </monogr>
        <ref target="https://soledadacosta.uniandes.edu.co/items/show/408"/>
      </biblStruct>
    </sourceDesc>
  </fileDesc>
</teiHeader>
```

Como solo hemos codificado un página para este ejercicio, la hemos indicado explícitamente en los metadatos de nuestro documento.
Si quisiéramos codificar todo el texto de Soledad Acosta, no sería necesario explicitar dicha información.
Por otro lado, puesto que nuestro texto objeto es un manuscrito cuyo lugar y fecha de elaboración nos son desconocidos, debemos dejar eso claro en el `<sourceDesc>`.



### El `<text>`

Con respecto al cuerpo del texto (que se encuentra contenido en el elemento `<text>` del documento, como ya hemos visto), lo primero que haremos es identificar los tipos de texto según su función estructural.
A primera vista podemos hallar ocho tipos básicos, ilustrados con colores y números en la siguiente imagen:

<figure>
<a href="SA_059cc.png">
    <img src="SA_059cc.png" alt="Análisis de la p.59">
	</a>
<figcaption>
    <p>Análisis de la p.59</p>
</figcaption>
</figure>

{% include figure.html filename="SA_059cc.png" caption="Análisis de la p.59" %}

Los textos son los siguientes:

1. nota marginal
2. título (encabezado) de la sección
3. paginación
4. texto principal
5. corrección (en el texto principal)
6. cita (en la corrección)
7. nota a pie explicatoria (con referencia bibliográfica)
8. nota a pie bibliográfica

Ahora bien, podemos ver que los textos 1, 7 y 8 son notas textuales (la primera marginal, las otras dos a pie de página) y están en cierto modo "ancladas" en los textos que anotan.
Eso significa que aunque visualmente puedan parecer desarticulados y separados del texto principal (textos 4, 5 y 6), los tres hacen parte de él, estructuralmente hablando.
De nuevo, su representación visual —esto es, su diseño gráfico en la composición de la página— es independiente de su función y categoría estructural con respecto al texto.



#### La paginación (texto 3)

En nuestro texto podemos distinguir dos formas de paginación.
La primera es la *visual*, esto es, los números 47 y 59 que aparecen escritos (por manos diferentes) en la esquina superior derecha de la página.
Es probable que el número 47 corresponda a una primera paginación del manuscrito hecha por la autora misma, y que el número 59 corresponda a una paginación posterior hecha quizás por la Biblioteca Nacional de Colombia (o por algún propietario/lector anterior del manuscrito).


La segunda forma de paginación es la *lógica (o estructural)*, esto es, el puesto que la página o folio ocupa en la secuencia ordenada del texto completo del manuscrito.
Si examinamos el PDF del manuscrito completo, podemos ver que la paginación lógica parece coincidir en líneas generales con la del segundo número de la paginación visual (59, en nuestro caso).
(Vale notar que la Biblioteca Nacional de Colombia ha eliminado del PDF las páginas en blanco, seguramente para reducir su tamaño.)


Ahora bien, hay editores/codificadores —entre quienes que yo me cuento— que consideran innecesario incluir explícitamente la primera forma de paginación, debido a que por lo general esta solo cumple una función estructural y por lo tanto ya se halla explícitamente incluida en la segunda.
(Del mismo modo que el subrayado puede indicar un rasgo estructural y por lo tanto no ha de codificarse por separado con un elemento `<hi @rend="underline">`, por ejemplo.)


En aras de la exhaustividad, sin embargo, codificaremos ambas paginaciones para este ejemplo.
Para la primera usaremos dos elementos `<ab>` dentro de un elemento `<div>` que los incluye juntos; para la segunda usaremos el mojón `<pb/>` con el atributo `@n="59"`, así:

```xml
<body>
  <pb n="59"/>
  <div>
    <ab>47</ab>
    <ab>59</ab>
  </div>
  <!-- aquí continúa el resto del texto -->
</body>
```

Nótese que hemos puesto el `<pb/>` justo al principio de la página, pues de lo contrario indicaríamos que los números (aquellos dos escritos por distintas personas) están en la página anterior.

TEI tiene [diversas formas](https://tei-c.org/release/doc/tei-p5-doc/en/html/PH.html#PHDH) de indicar la identidad de las personas que escriben un documento.
En crítica textual se las denomina "manos" cuando se trata de un texto manuscrito.
Podemos usar el atributo `@hand` en muchos de los elementos de TEI para hacer explícita esta responsabilidad.

En el caso de los números de página, claramente hay dos manos involucradas.
Podemos codificarlas así:

```xml
<ab hand="#SAS">47</ab>
<ab hand="#BNC">59</ab>
```

El signo de numeral (`#`) significa que estamos haciendo *referencia* a un valor previamente definido.
Esta es precisamente la manera como el atributo `@hand` se suelen codificar en TEI (de hecho esta es la forma de codificar referencias internas y externas en XML).
Aunque aún no hayamos definido a qué se refieren `SAS` y `BNC` (hemos usado las siglas de "Soledad Acosta de Samper" y "Biblioteca Nacional de Colombia", suponiendo que ellos sean los responsables), por ahora queda claro al menos que se trata de dos "manos" diferentes.


En otro lugar de nuestro documento TEI podemos definir esas referencias, usando el elemento [`listPerson`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-listPerson.html).
Un buen lugar para hacerlo es dentro de un tercer hijo de `<TEI>` entre `<teiHeader>` y `<text>`: el elemento [`standOff`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-standOff.html), por ejemplo así:


```xml
<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <!-- metadatos del texto -->
  </teiHeader>
  <standOff>
    <listPerson>
      <person xml:id="SAS">
        <persName>Soledad Acosta de Samper</persName>
      </person>
      <person xml:id="BNC">
        <name>Biblioteca Nacional de Colombia</name>
      </person>
    </listPerson>
  </standOff>
  <text xml:lang="spa" hand="#SAS">
    <body>
      <!-- cuerpo del texto -->
    </body>
  </text>
</TEI>
```

El atributo `@hand`, cuyos valores son `#SA` y `#BN` respectivamente, en últimas se refiere a los dos elementos [`<person>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-person.html) (previamente definidos dentro del elemento [`<listPerson>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-listPerson.html)) por medio de los atributos genéricos de XML `@xml:id`.
(Como dijimos arriba, XML requiere que los valores de `@xml:id` sean únicos.)


Puede verse que *no* hemos usado el elemento [`<persName>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-persName.html) para el caso de la Biblioteca Nacional de Colombia, sino el elemento [`<name>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-name.html), por cuanto se trata de una institución, no una persona de carne y hueso.
Asimismo, si quisiéramos incluir información adicional sobre ellos (años de nacimiento y de muerte, ocupación, localización geográfica, etc.) podríamos hacerlo dentro del elemento `<person>`.


Nótese finalmente que hemos decidido incluir el atributo `@hand="#SAS"` en el elemento `<text>`, a fin de identificar a Soledad Acosta como la persona que escribió de su puño y letra el manuscrito que estamos codificando.



#### El texto principal (textos 2, 4, 5 y 6)

El texto 2 es un encabezado que la autora usó para titular esta sección del documento.
Vamos a usar el elemento [`<header>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-header.html) para codificarlo.
Sin embargo, lo haremos dentro de un `<div>` que contenga el resto del texto principial (textos 4, 5 y 6), ya que todos ellos hacen parte de la sección que empieza en esta página.

Antes de continuar, es importante aclarar que el elemento `<header>` contiene un texto que efectivamente aparece en el documento objeto y que funciona como encabezado en una división; en otras palabras, no es meramente una división lógica de este.
(Si quisiéramos —digamos en una edición crítica— introducir encabezados que no aparecen efectivamente el texto, sino que contienen un texto introducido por el editor, TEI ofrece el elemento [`<supplied>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-supplied.html) para ello.
Por ejemplo: `<header><supplied>Argumentos en contra</supplied></header>`.)


Empecemos entonces transcribiendo el manuscrito en este punto:

```xml
<div>
  <lb n="1"/><head>4</head>
  <p>
    <lb n="2"/>Misterio de la Historia de la humanidad
    <lb n="3"/>antes del Diluvio universal, puesto que el histor
    <lb n="4" break="no"/>riador *reconocido* más antiguo —<persName>Moisés</persName>— encierra todo
    <lb n="5"/>aquel tiempo transcurrido <unclear>enteros</unclear> cortos acá
    <lb n="6"/>justos. Se ha calculado que solo duró 1659 a
    <lb n="7" break="no"/>ños, <choice><orig>segun</orig><reg>según</reg></choice> unos y 2,000 según otros. Como los
    <lb n="8"/>hombres gozaban de una longevidad extra
    <lb n="9" break="no"/>ordinaria (1) naturalmente alcanzaban <choice><orig>á</orig><reg>a</reg></choice> per
    <lb n="10" break="no"/>feccionarse muchísimo, y como sus <unclear>conveinen
    <lb n="11" break="no"/>tas</unclear> fueron asombrosas<corr>,</corr> se llenaron de soberbia, y
    <lb n="12"/>esa soberbia se convirtió en corrupción y esta
    <lb n="13"/>en completa perversión, leemos en el <title>Génesis</title> (1)
    <lb n="14"/>"Y había gigantes sobre la tierra en aque
    <lb n="15" break="no"/>llos días .... poderosos desde la <choice><orig>antigue</orig><reg>antigüe</reg></choice>
    <lb n="16" break="no"/>dad, varones de fama ... Y viendo Dios que
    <lb n="17"/>era mucha la malicia de los hombres,
    <lb n="18"/>y que todos los pensamientos del corazón<sic>,</sic>
    <lb n="19"/>eran inclinados al mal en todo tiempo, y entonces
  </p>
</div>
```

Varias cosas deben señalarse sobre esta primera versión.

Primero, hemos codificado con el elemento `<persName>` el nombre propio "Moisés", y con el elemento `<title>` el nombre del *Génesis*.


Segundo, hemos incluido el mojón `<lb n="1"/>` antes del encabezado, puesto que este hace parte del texto principal y es una línea que debe contarse.

Tercero, cuando hay una ruptura de palabra al final de la línea *no* debemos escribir un guión (`-`).
En ese caso debemos usar el atributo `@break="no"` en el siguiente salto de línea, para indicar que la palabra no se rompe ahí sino que continúa en la siguiente línea del texto.
Esto ocurre en las líneas 4, 7, 9, 10, 11, 15 y 16.

Cuarto, en la línea 11 hemos incluido una coma (con `<corr>,</corr>`) y en la línea 18 hemos señalado que hay una coma que sobra (usando el elemento [`<sic>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-sic.html), así: `<sic>,</sic>`). Ambas son intervenciones editoriales debidamente codificadas.

Quinto, en las líneas 5 y 10-11 hay unas palabras que no hemos entendido bien.
Las hemos incluido dentro de sendos elementos `<unclear>`.
(Nótese de paso la utilidad del elemento de autocerrado `<lb/>` en la línea 11: nos permite encerrar la palabra `coveinentas` en un elemento `<unclear>` sin violar las reglas sintácticas de XML.)


Sexto, hemos usado temporalmente unos asteriscos en la línea 4 para indicar una corrección hecha por la autora misma.
(La caligrafía parece ser la misma en la corrección y en el texto principal, por lo que es muy probable que ambas sean de la autora.)
TEI nos permite codificar estas correcciones con el elemento [`<add>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-add.html), que indica que el texto contenido en él es un añadido introducido a modo de corrección en el texto objeto (y no una corrección editoral nuestra, que como sabemos se codifica con el elemento `<corr>`).
Usaremos el atributo `@place="arriba"` para señalar su ubicación en el manuscrito.
Así pues, la línea 4 quedaría así en una nueva versión del documento:

```xml
<lb n="4" break="no"/>riador <add place="arriba">reconocido</add> más antiguo —<persName>Moisés</persName>— encierra todo
```


##### Correcciones

Nótese que entre las líneas 3 y 4 la palabra "historiador" parece ser una corrección o enmienda.
La autora parece haber borrado algo en lápiz y luego haberlo corregido con esa palabra.
Como no podemos descifrar qué palabra ha sido borrada, debemos usar el elemento de autocerrado `<gap/>`, con los atributos `@quantity="1"` y `@unit="palabra"` para codificar eso.
Dicho elemento señala que hay una laguna textual.


Ahora bien, para indicar que hay una corrección en la que un texto ha sido eliminado y otro ha sido introducido usamos los elementos [`<del>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-del.html) y `<add>`, encerrados juntos en un elemento [`<subst>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-subst.html), que indica una sustitución:

```xml
<subst>
  <del>texto eliminado</del>
  <add>texto añadido</add>
</subst>
```

En consecuencia, las líneas 3 y 4 quedarían así en una nueva versión de la codificación:

```xml
<lb n="3"/>antes del Diluvio universal, puesto que el <subst><del><gap quantity="1" unit="palabra"/></del><add>histo
  <lb n="4" break="no"/>riador</add></subst> <add place="arriba">reconocido</add> más antiguo —<persName>Moisés</persName>— encierra todo
```

(Recuérdese que los saltos de línea en XML, así como el sangrado, no es semánticamente significativo, sino que solo se usa para la legibilidad de las personas que leen el texto.
La línea 4 aparece sangrada simplemente para indicar que su inicio (`riador</add>`) está contenido en el elemento `<subst>`, que inicia en la línea anterior.
Para el computador —más precisamente para el procesador de XML— estos sangrados y saltos de línea son irrelevantes.)


Ahora bien, las líneas 13-19 son una corrección hecha por la autora.
Ella recortó una hoja de su cuaderno con la corrección y la pegó sobre la hoja de esta página.
(Este es un buen ejemplo del proverbial "corte y pega", literalmente hablando.)
En consecuencia codificaremos esas líneas dentro de un elemento `<subst>` así:

```xml
<subst>
  <del>
    <gap quantity="7" unit="líneas" reason="ilegible"/>
  </del>
  <add>
    <lb n="13"/>en completa perversión, leemos en el <title>Génesis</title> (1)
    <lb n="14"/>"Y había gigantes sobre la tierra en aque
    <lb n="15" break="no"/>llos días .... poderosos desde la <choice><orig>antigue</orig><reg>antigüe</reg></choice>
    <lb n="16" break="no"/>dad, varones de fama ... Y viendo Dios que
    <lb n="17"/>era mucha la malicia de los hombres,
    <lb n="18"/>y que todos los pensamientos del corazón<sic>,</sic>
    <lb n="19"/>eran inclinados al mal en todo tiempo, y entonces
</add>
</subst>
```

Hemos indicado con el elemento `<gap/>` que ignoramos el contenido del texto eliminado.
Con los atributos `@quantity="7"` y `@unit="líneas"` indicamos su extensión.
Y hemos añadido finalmente una explicación con el atributo opcional `@reason="ilegible"`.


##### Citas

Entre las líneas 14 y 19 tenemos una cita del libro del *Génesis*.
(De hecho, la cita se extiende a la siguiente página del manuscrito, aunque para los fines de este ejemplo supondremos que termina acá.)
Para codificarla tenemos a nuestra disposición dos posibilidades.

La más simple es usar el elemento [`<q>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-q.html) (de *quoted*, "citado"), para indicar que hay una texto entre comillas (nótese que hemos eliminado los signos de `"`, pues estos cumplen estructuralmente la misma función realizada por `<q>`).
Sería entonces algo como esto:

```xml
<lb n="14"/>
<q>
  Y había gigantes sobre la tierra en aque
  <lb n="15" break="no"/>llos días .... poderosos desde la <choice><orig>antigue</orig><reg>antigüe</reg></choice>
  <lb n="16" break="no"/>dad, varones de fama ... Y viendo Dios que
  <lb n="17"/>era mucha la malicia de los hombres,
  <lb n="18"/>y que todos los pensamientos del corazón<sic>,</sic>
  <lb n="19"/>eran inclinados al mal en todo tiempo, y entonces
</q>
```


La segunda posibilidad es un poco más sofisticada.
Podemos usar el elemento [`<cit>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-cit.html) para crear una citación que incluya el texto citado (dentro de un elemento [`<quote>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-quote.html)) y una referencia bibliográfica (dentro de un elemento `<bibl>`).
Su estructura es la siguiente:

```xml
<cit>
  <quote>texto de la cita</quote>
  <bibl>referencia bibliográfica de la cita</bibl>
</cit>
```

Notemos que —como en el caso del elemento `<head>` de arriba— tanto el texto de la cita (dentro de `<quote>`) como el de la referencia bibliográfica (dentro de `<bibl>`) deben efectivamente encontrarse en el texto.
Por fortuna para nosotros, la autora nos ha proporcionado la información bibliográfica en una nota a pie de página (texto 8).
(En la siguiente sección discutiremos cómo codificarla correctamente.)
Podríamos entonces codificar la citación así:

```xml
<lb n="14"/>
<cit>
  <quote>
    Y había gigantes sobre la tierra en aque
    <lb n="15" break="no"/>llos días .... poderosos desde la <choice><orig>antigue</orig><reg>antigüe</reg></choice>
    <lb n="16" break="no"/>dad, varones de fama ... Y viendo Dios que
    <lb n="17"/>era mucha la malicia de los hombres,
    <lb n="18"/>y que todos los pensamientos del corazón<sic>,</sic>
    <lb n="19"/>eran inclinados al mal en todo tiempo, y entonces
  </quote>
  <bibl>
    <title>Génesis</title>,
    Cap. IV<corr>,</corr> ver 4, 5, 6, 7
  </bibl>
</cit>
```

(Véase la coma que hemos introducido, por medio de un elemento `<corr>`, para separar el capítulo de los versículos.)

La ventaja de esta manera más exhaustiva de codificar las citaciones es que hemos vinculado semánticamente la cita con su referencia bibliográfica, independientemente de cómo haya sido representada visualmente.



#### Notas textuales (textos 1, 7 y 8)

Como dijimos arriba, en este fragmento del texto manuscrito tenemos tres notas:
una marginal (margen izquierdo) y dos a pie de página (margen inferior).
TEI cuenta con el elemento [`<note>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-note.html) para codificar toda clase de notas textuales.
Este elemento tiene una variedad de atributos para especificar el tipo de la nota, su función, ubicación, responsable, etc.
Los más importantes para nosotros serán estos:

- `@type`, el tipo de la nota; para nuestros ejemplo, sus valores podrán ser `estructural`, `aclaratoria` y `bibliográfica`
- `@place`, el lugar de ubicación: `margen-izquierdo` y `margen-inferior` en nuestro caso

El valor `estructural` para el atributo `@type` de la nota significa que esta sirve para indicar la estructura del texto; en este caso el contenido será `La historia antes del Diluvio`.
Es evidente que no es una nota aclaratoria, sino que sirve casi como encabezado del texto principal (textos 4, 5 y 6).



##### Nota estructural (texto 1)

Su código será el siguiente:

```xml
<note type="estructural" place="margen-izquierdo">
  La historia antes del Diluvio
</note>
```

Nótese que no hemos encerrado el texto en un elemento `<div>`.
¿Dónde lo pondremos en nuestro documento, entonces?
Es posible esta sea una nota marginal estructural con respecto a toda la sección.
Si esto es correcto, sería una nota que iría ubicada al principio de esta y podríamos codificarla así:

```xml
<div>
  <lb n="1"/><head>4</head>
  <p>
    <note type="estructural" place="margen-izquierdo">
      La historia antes del Diluvio
    </note>
    <lb n="2"/>Misterio de la Historia de la humanidad
    <!-- aquí continua el resto del texto -->
  </p>
</div>
```

Es importante aclara aquí que, aunque en el manuscrito este texto aparezca separado por guiones (ya que de lo contrario no cabría en el margen), para nosotros esta partición no es significativa.
La razón de esto es que dicha partición no constituye en sí misma saltos de línea (análogos a los del texto principal).
En general, la convención es no codificar los saltos de línea de los textos periféricos (notas marginales, notas a pie de página), sino solo los del texto principal en la página.
Con todo, nada en TEI impide que codifiquemos cada línea en una superficie textual.



##### Nota aclaratoria (texto 7)

La segunda nota está anclada en la línea 9 del texto, luego de la palabra "extraordinaria".
En el manuscrito hay un llamado a pie de página: "(1)".
Podemos eliminarlo de nuestra codificación, puesto que su función es puramente estructural.
Así pues, el código será el siguiente:

```xml
<lb n="9" break="no"/>ordinaria
<note type="aclaratoria" place="margen-inferior">
  Los años de <persName>Mathusalem</persName> fueron 965 y los de <persName>Lamech</persName> 777.
  (<bibl>
    <title>
      <choice>
        <orig>Genesis</orig>
        <reg>Génesis</reg>
      </choice>
    </title>
    Cap. V, ver. 27-29
  </bibl>)
</note>
naturalmente alcanzaban <choice><orig>á</orig><reg>a</reg></choice> per
```

Como puede verse, hemos incluido los nombres "Mathusalem" y "Lamech" en sendos elementos `<persName>`.

Más interesante es el uso del elemento `<bibl>` para introducir "información bibliográfica ligeramente estructurada (*loosely-structured*) ", como lo define la documentación de TEI.
(Si quisiéramos introducir una bibliografía completamente estructurada, por ejemplo en el caso de una edición crítica, podríamos utilizar el elemento [`<biblStruct>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-biblStruct.html).)

Dentro del elemento `<bibl>` tenemos dos hijos: un elemento [`<title>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-title.html), que codifica el título de una obra (en este caso "Génesis", título que hemos normalizado a partir de "Genesis" en el manuscrito—), y un texto: "Cap. V, ver. 27-29" que dejamos tal cual aparece.
Nótese todo el `<bibl>` va entre paréntesis, exactamente como aparece en el manuscrito de la autora.


Si para nuestros propósitos fuera importante codificar los números de llamado a nota (p. ej. "(1)", "(2)", etc.),
podríamos utilizar el elemento [`<metamark>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-metamark.html) de TEI.
Su uso es un poco más complicado, pues requiere referencias cruzadas (con el signo `#`, como vimos arriba).
Sería algo como lo siguiente:

```xml
<lb n="9" break="no"/>ordinaria <metamark target="#nota1">(1)</metamark>
<note xml:id="nota1" type="aclaratoria" place="margen-inferior">
  <!-- aquí va el texto de la nota -->
</note>
```

Esto podría ser importante si —por ejemplo— quisiéramos indicar que no existe claridad con respecto a la ubicación de los "llamados" a pie de página que anclan las notas (si la numeración no es clara, o si hay un número distinto de "llamados" y de notas, etc.).
Sin embargo, no haremos eso en la versión final de nuestro documento.



##### Nota bibliográfica (texto 8)

Como vimos antes, la autora nos ha proporcionado amablemente la información bibliográfica para la cita del *Génesis* contenida en las líneas 14-19.
Esa información está en una nota a pie de página (correspondiente al texto 8 en nuestro esquema).
Lo que haremos ahora es incluir el elemento `<bibl>` de la citación en un elemento `<note>`.
El código de toda la citación será entonces el siguiente:

```xml
<lb n="14"/>
<cit>
  <quote>
    Y había gigantes sobre la tierra en aque
    <lb n="15" break="no"/>llos días .... poderosos desde la <choice><orig>antigue</orig><reg>antigüe</reg></choice>
    <lb n="16" break="no"/>dad, varones de fama ... Y viendo Dios que
    <lb n="17"/>era mucha la malicia de los hombres,
    <lb n="18"/>y que todos los pensamientos del corazón<sic>,</sic>
    <lb n="19"/>eran inclinados al mal en todo tiempo, y entonces
  </quote>
  <note type="bibliográfica" place="margen-inferior">
    <bibl>
      <title>
        <choice>  
          <orig>Genesis</orig>
          <reg>Génesis</reg>
        </choice>
      </title>
      Cap. VI<corr>,</corr> ver. 4, 5, 6, 7
    </bibl>
  </note>
</cit>
```



### Código completo del documento

El [código completo](Acosta.xml) del documento TEI del fragmento de Soledad Acosta es este:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <fileDesc>
      <titleStmt>
        <title>Pequeño manual del estudiante de historia universal, tomo 1, p.59</title>
        <author>Soledad Acosta de Samper</author>
      </titleStmt>
      <publicationStmt>
        <publisher>Nicolás Vaughan</publisher>
        <pubPlace>Bogotá, Colombia</pubPlace>
        <date>2021</date>
        <availability>
          <p>Esta es una obra de acceso abierto licenciada bajo una licencia Creative Commons Attribution 4.0 International.</p>
        </availability>
      </publicationStmt>
      <sourceDesc>
        <biblStruct>
          <monogr>
            <author>Soledad Acosta de Samper</author>
            <title>Pequeño manual del estudiante de historia universal, tomo 1, p.59</title>
            <imprint>
              <pubPlace>Sin lugar</pubPlace>
              <date>Sin fecha</date>
            </imprint>
          </monogr>
          <ref target="https://soledadacosta.uniandes.edu.co/items/show/408"/>
        </biblStruct>
      </sourceDesc>
    </fileDesc>
  </teiHeader>
  <standOff>
    <listPerson>
      <person xml:id="SAS">
        <persName>Soledad Acosta de Samper</persName>
      </person>
      <person xml:id="BNC">
        <name>Biblioteca Nacional de Colombia</name>
      </person>
    </listPerson>
  </standOff>
  <text xml:lang="es" hand="#SAS">
    <body>
      <pb n="59"/>
      <div>
        <ab hand="#SAS">47</ab>
        <ab hand="#BNC">59</ab>
      </div>
      <div>
        <lb n="1"/><head>4</head>
        <p>
          <note type="estructural" place="margen-izquierdo">
            La historia antes del Diluvio
          </note>
          <lb n="2"/>Misterio de la Historia de la humanidad
          <lb n="3"/>antes del Diluvio universal, puesto que el <subst><del><gap quantity="1" unit="palabra"/></del><add>histo
            <lb n="4" break="no"/>riador</add></subst> <add place="arriba">reconocido</add> más antiguo —<persName>Moisés</persName>— encierra todo
          <lb n="5"/>aquel tiempo transcurrido <unclear>enteros</unclear> cortos acá
          <lb n="6"/>justos. Se ha calculado que solo duró 1659 a
          <lb n="7" break="no"/>ños, <choice><orig>segun</orig><reg>según</reg></choice> unos y 2,000 según otros. Como los
          <lb n="8"/>hombres gozaban de una longevidad extra
          <lb n="9" break="no"/>ordinaria
          <note type="aclaratoria" place="margen-inferior">
            Los años de <persName>Mathusalem</persName> fueron 965 y los de <persName>Lamech</persName> 777.
            (<bibl>
              <title>
                <choice>
                  <orig>Genesis</orig>
                  <reg>Génesis</reg>
                </choice>
              </title>
              Cap. V, ver. 27-29
            </bibl>)
          </note>
          naturalmente alcanzaban <choice><orig>á</orig><reg>a</reg></choice> per
          <lb n="10" break="no"/>feccionarse muchísimo, y como sus <unclear>conveinen
            <lb n="11" break="no"/>tas</unclear> fueron asombrosas<corr>,</corr> se llenaron de soberbia, y
          <lb n="12"/>esa soberbia se convirtió en corrupción y esta
          <subst>
            <del>
              <gap quantity="7" unit="líneas" reason="ilegible"/>
            </del>
            <add>
              <lb n="13"/>en completa perversión, leemos en el <title>Génesis</title> (2)
              <lb n="14"/>
              <cit>
                <quote>
                  Y había gigantes sobre la tierra en aque
                  <lb n="15" break="no"/>llos días .... poderosos desde la <choice><orig>antigue</orig><reg>antigüe</reg></choice>
                  <lb n="16" break="no"/>dad, varones de fama ... Y viendo Dios que
                  <lb n="17"/>era mucha la malicia de los hombres,
                  <lb n="18"/>y que todos los pensamientos del corazón<sic>,</sic>
                  <lb n="19"/>eran inclinados al mal en todo tiempo, y entonces
                </quote>
                <note type="bibliográfica" place="margen-inferior">
                  <bibl>
                    <title>
                      <choice>
                        <orig>Genesis</orig>
                        <reg>Génesis</reg>
                      </choice>
                    </title>
                    Cap. VI<corr>,</corr> ver. 4, 5, 6, 7
                  </bibl>
                </note>
              </cit>
            </add>
          </subst>
        </p>
      </div>
    </body>
  </text>
</TEI>
```

Aunque VS Code y BaseX nos dicen que nuestro código es sintácticamente válido en XML, podemos verificar que también es semánticamente válido en TEI con ayuda del [TBE Validation Service](https://teibyexample.org/tools/TBEvalidator.htm):


<figure>
<a href="Acostavalidation.png">
    <img src="Acostavalidation.png" alt="Validación TEI del código del manuscrito de Soledad Acosta">
	</a>
<figcaption>
    <p>Validación TEI del código del manuscrito de Soledad Acosta</p>
</figcaption>
</figure>

{% include figure.html filename="Acostavalidation.png" caption="Validación TEI del código del manuscrito de Soledad Acosta" %}



# OxGarage: Transformaciones básicas sin XSLT

Ya hemos aprendido a codificar en TEI dos textos simples: una postal y el fragmento de un manuscrito con correcciones y notas.
¿Qué podemos hacer ahora con dichas codificaciones?

En su ingenuidad, esta pregunta puede parecer en principio injustificada.
La codificación es un fin en sí mismo, en la medida en que constituye un ejercicio analítico sobre un texto.
Es más, si recordamos las recomendaciones que hemos hecho repetidamente con respecto a distinguir entre marcado de visualización y marcado semántico, la pregunta por cómo podemos visualizar el "resultado" de nuestra codificación parece ser desatinada.

Sin embargo, también hay que saber que la codificación TEI es solo uno de los pasos, en una cadena probablemente muy extensa, de la reutilización, procesamiento y análisis de textos con herramientas de humanidades digitales.
En ese sentido es natural que nos preguntemos cómo aprovechar las codificaciones realizadas.

En sí mismo, TEI no es más que un lenguaje de codificación de textos.
En consecuencia, TEI no permite mostrar, transformar, analizar, reutilizar, etc. los documentos codificados.
Para eso precisamos de otros lenguajes y otras tecnologías, particularmente el lenguaje de transformaciones [XSLT](https://www.w3.org/TR/xslt/), al que aludimos de pasada más atrás.
XSLT es un lenguaje altamente sofisticado, cuya explicación no podemos cubrir en esta lección.

Ahora bien, existen herramientas gratuitas (y comerciales) que nos permiten transformar los documentos TEI en otros formatos.
Una de las más usadas es [OxGarage](https://oxgarage.tei-c.org/), creada por el consorcio TEI.
Podemos usar OxGarage en línea o también podemos [instalarla localmente](https://github.com/sebastianrahtz/oxgarage) en nuestro computador.
Para nuestros fines usaremos la versión en línea.


Antes de comenzar, debemos asegurarnos de que nuestros documentos TEI sean sintáctica y semánticamente válidos, pues de lo contrario no podrán ser procesados por OxGarage (ni por ningún otro procesador, a decir verdad).
Para ello podemos usar una herramienta como la del [TBE Validation Service](https://teibyexample.org/tools/TBEvalidator.htm), mencionada arriba.


Una vez abierta la página web de OxGarage, picaremos en la opción "Documents":

<figure>
<a href="oxgarage01.png">
    <img src="oxgarage01.png" alt="OxGarage: opción documentos">
	</a>
<figcaption>
    <p>OxGarage: opción documentos</p>
</figcaption>
</figure>

{% include figure.html filename="oxgarage01.png" caption="OxGarage: opción documentos" %}


Luego seleccionaremos "TEI P5 XML Document" en la columna "Convert from":

<figure>
<a href="oxgarage02.png">
    <img src="oxgarage02.png" alt="OxGarage: formato de entrada">
	</a>
<figcaption>
    <p>OxGarage: formato de entrada</p>
</figcaption>
</figure>

{% include figure.html filename="oxgarage02.png" caption="OxGarage: formato de entrada" %}


Entonces nos aparecerá la columna de opciones para elegir el formato de salida, donde tenemos 19 posibilidades: LaTeX, ePub, DOCX, PDF, etc.
Para nuestro ejemplo escojeremos la opción "PDF":


<figure>
<a href="oxgarage03.png">
    <img src="oxgarage03.png" alt="OxGarage: formato de salida: PDF">
	</a>
<figcaption>
    <p>OxGarage: formato de salida PDF</p>
</figcaption>
</figure>


{% include figure.html filename="oxgarage03.png" caption="OxGarage: formato de salida: PDF" %}



Ahora subiremos nuestro documento TEI al servidor, picando en el botón "Browse..." de la izquierda.
(Si nuestro documento hubiera incluido imágenes, como por ejemplo en un facsímil digital, podríamos subirlas en un archivo .zip con el botón "Browse..." de la derecha.)



<figure>
<a href="oxgarage04.png">
    <img src="oxgarage04.png" alt="OxGarage: subir el documento TEI">
	</a>
<figcaption>
    <p>OxGarage: subir el documento TEI</p>
</figcaption>
</figure>


{% include figure.html filename="oxgarage04.png" caption="OxGarage: subir el documento" %}


Finalmente picaremos en el botón "Convert" y esperaremos a que el servidor descargue el resultado en el navegador.
(Si nada sucede, es probable que exista un error en el documento TEI de entrada; OxGarage *no* reporta dichos errores, infortunadamente.)


<figure>
<a href="oxgarage05.png">
    <img src="oxgarage05.png" alt="OxGarage: convertir">
	</a>
<figcaption>
    <p>OxGarage: convertir</p>
</figcaption>
</figure>


{% include figure.html filename="oxgarage05.png" caption="OxGarage: convertir" %}



Hagamos la prueba primero con la postal y luego con el fragmento del manuscrito.

Este es el [resultado](postal_out.pdf) para el ejemplo de la postal:

<figure>
<a href="postal_out.png">
    <img src="postal_out.png" alt="OxGarage: PDF resultante de la postal">
	</a>
<figcaption>
    <p>OxGarage: PDF resultante de la postal</p>
</figcaption>
</figure>

{% include figure.html filename="postal_out.png" caption="Garage: PDF resultante de la postal" %}



Nótese cómo los elementos `<foreign>` han sido representados en cursivas en el PDF.

Finalmente, este es el [resultado](postal_out.pdf) para la codificación del manuscrito:

<figure>
<a href="Acosta_out.png">
    <img src="Acosta_out.png" alt="OxGarage: PDF resultante del manuscrito">
	</a>
<figcaption>
    <p>OxGarage: PDF resultante del manuscrito</p>
</figcaption>
</figure>

{% include figure.html filename="Acosta_out.png" caption="Garage: PDF resultante del manuscrito" %}



En este caso OxGarage hay usado paréntesis angulares (`⟨⟩`) para indicar los añadidos, y incluido un `[?]` luego de las palabras dudosas (correspondientes a los elementos `<unclear>`).

Quizás los resultados puedan parecerle al lector algo decepcionantes.
Eso se debe a que el motor conversión de OxGarage realiza transformaciones XSLT muy elementales y genéricas.
Sin embargo, puede ser muy útil para extraer el texto de codificaciones de documentos extensos, para los cuales aún no hayamos programado transformaciones XSLT más elaboradas.



# Referencias recomendadas

- La documentación completa de TEI (los *TEI Guidelines*) está disponible en la página del consorcio: https://tei-c.org/guidelines/ Aunque se la ofrece en varios idiomas, solo está completa en inglés.

- Una buena introducción (en inglés) a TEI es el libro *What Is the Text Encoding Initiative* de Lou Burnard, disponible gratuitamente en línea aquí: https://books.openedition.org/oep/426?lang=en

- Un buen tutorial para XML está disponible aquí: https://www.w3schools.com/xml/ y aquí: https://www.tutorialspoint.com/xml/index.htm

- El consorcio TEI también ofrece una buena introducción a XML: https://www.tei-c.org/release/doc/tei-p5-doc/en/html/SG.html

- La documentación oficial de XML está disponible en la página del consorcio W3C: https://www.w3.org/XML/ También está disponible la documentación para toda la familia XSL (incluido XSLT) aquí: https://www.w3.org/Style/XSL/

- La Mozilla Foundation también ofrece una buena página sobre XSLT y tecnologías asociadas: https://developer.mozilla.org/es/docs/Web/XSLT (en español) y https://developer.mozilla.org/en-US/docs/Web/XSLT (en inglés)



<!--
%%% Local Variables:
%%% mode: markdown
%%% eval: (ispell-change-dictionary "spanish")
%%% End:
-->
