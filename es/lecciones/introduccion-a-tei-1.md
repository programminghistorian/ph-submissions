---
title: Introducción a la codificación de textos en TEI (parte 1)
collection: lessons
layout: lesson
authors:
  - Nicolás Vaughan
editors:
  - Jennifer Isasi
difficulty: 2
---

{% include toc.html %}

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

Para esta lección usaremos el editor [Visual Studio Code](https://code.visualstudio.com/) (VS Code, más brevemente), creado por Microsoft y mantenido actualmente por una gran comunidad de programadores de software libre.
Es una aplicación completamente gratuita y de [código abierto](https://github.com/microsoft/vscode), disponible para Windows, MacOS y Linux.


Descarguen la versión más reciente de VS Code en el enlace https://code.visualstudio.com/ e instálenla en su computador.
Ahora ábranlo y verán una pantalla como la siguiente:

{% include figure.html filename="vscode01.png" caption="Vista inicial de VS Code" %}

Es probable que en su computador VS Code se vea algo distinto que en esta imagen.
(Yo lo estoy corriendo ahora en Linux.)
Sin embargo, las diferencias son básicamente estéticas y podremos obviarlas.


Ahora instalaremos una extensión de VS Code llamada XML Complete, para trabajar más fácilmente con documentos XML.
Para ello piquen en el botón de extensiones en la barra lateral de herramientas, a la izquierda en la ventana principal:

{% include figure.html filename="vscode02.png" caption="Extensiones de VS Code" %}

Escriban `Xml complete` en el campo de búsqueda:

{% include figure.html filename="vscode03.png" caption="Búsqueda de extensiones de VS Code" %}

Finalmente piquen en "Install":

{% include figure.html filename="vscode04.png" caption="Instalar \"XML Complete\" en VS Code" %}

La extensión XML Complete nos permite, entre otras, validar sintácticamente documentos XML.
Si hay un error sintáctico —por ejemplo si hemos olvidado cerrar una etiqueta—, VS Code nos lo mostrará en la barra de abajo:

{% include figure.html filename="vscode05.png" caption="Detectar errores sintácticos en VS Code" %}

{% include figure.html filename="vscode06.png" caption="Detectar errores sintácticos en VS Code (detalle)" %}

Esta extensión ofrece asimismo otras herramientas útiles para autocompletar el código de XML. Para más detalles, pueden consultar la [documentación](https://github.com/rogalmic/vscode-xml-complete).


### Otras opciones de software

Si el lector lo prefiere, puede usar en lugar de VS Code el editor [Atom](https://atom.io), donde podrá instalar extensiones similares a la que hemos recomendado en esta lección.
También puede usar la aplicación [BaseX](https://basex.org/) o el editor [XML Code Editor] (https://xml-copy-editor.sourceforge.io/), ambos de código abierto.

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

{% include figure.html filename="quijote.png" caption="Texto escaneado" %}

Podríamos entonces utilizar una etiqueta de TEI, como por ejemplo [`<name>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-name.html), para marcar o *codificar* los nombres propios como tales:

```
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

```
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

```
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

```
<?xml version="1.0" encoding="UTF-8"?>
<texto>mi texto</texto>
<nota>otro texto</nota>
```

Es inválido porque viola la regla 1 al tener dos elementos raíces: `<texto>` y `<nota>`, ambos independientes el uno del otro.
Para corregirlo, podríamos hacer algo como esto:

```
<?xml version="1.0" encoding="UTF-8"?>
<texto>mi texto<nota>otro texto</nota></texto>
```

Vale notar que en XML los caracteres de espacio en blanco (` `, que podemos representar aquí así: `␣`) se colapsan automáticamente: p. ej. esto: `␣␣␣␣␣` se colapsa en esto: `␣`.
Asimismo, los saltos de línea se transforman automáticamente en espacios en blanco: p. ej. esto:

```
a
b
```

se colapsa en esto:

```
a␣b
```

Así pues, podemos reformatear el anterior documento en una forma más legible así:

```
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

```
<?xml version="1.0" encoding="UTF-8"?>
<texto>
  mi texto
  <nota>otro texto
</texto>
```

En este caso, la cuarta línea contiene un elemento incompleto (e inválido), puesto que solo tiene una etiqueta de apertura sin una de cierre correspondiente.


De manera más interesante, el siguiente sería otro ejemplo de un documento *inválido*:

```
<?xml version="1.0" encoding="UTF-8"?>
<texto><a></texto></a>
```

Aunque pareciera ser un documento válido —pues aparentemente los dos elementos se abren y se cierran—, lo cierto es que no lo es.
Podemos verlo mejor si lo reformateamos así:

```
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

{% include figure.html filename="xmlvalidator.png" caption="Validación en línea del último ejemplo" %}




## Atributos de los elementos y comentarios en XML

Antes de concluir esta sección es preciso mencionar otras dos cosas que hacen parte del lenguaje XML: los [comentarios](https://www.w3.org/TR/REC-xml/#sec-comments) y los [atributos](https://www.w3.org/TR/REC-xml/#attdecls).
Consideremos el siguiente ejemplo:

```
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

```
<titulo tipo="canción" genero="bossa-nova" id="342" idioma="portugués">
  Pra machucar meu coraçao
</parrafo>
```

que contiene los atributos `@tipo`, `@genero`, `@id` e `@idioma`, con sus respectivos valores: `canción`, `bossa-nova`, `342` y `portugués`.
Como ya dijimos, los atributos sirven para añadir información estructurada a los elementos de XML.
En la medida en que es un metalenguaje general y abstracto, XML es en sí mismo agnóstico frente a qué elementos son permitidos en qué elementos.
La única restricción sintáctica es que *no se repitan atributos* en un mismo elemento, independientemente de sus valores.
Este elemento, por lo tanto, sería *inválido* en XML:

```
<texto tipo="nota" tipo="cita">...</texto>
```

Finalmente, examinemos la línea 2 del ejemplo de arriba:

```
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

```
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

```
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

```
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

```
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

```
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

{% include figure.html filename="textcontains.png" caption="Elementos posibles de `<text>`" %}

El más importante de estos elementos, y el que con mayor frecuencia usaremos, es [`<body>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-body.html), que contiene el cuerpo principal del texto.
Sin embargo, otros elementos importantes como hijos de `<text>` son [`<front>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-front.html), que  contiene lo que se conoce como el *frontmatter* o "páginas preliminares" de un texto (introducción, prólogo, etc.), y [`<back>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-back.html), que contiene el *backmatter* o "páginas finales" (los apéndices, índices, etc.).



Por su parte, `<body>` puede contener muchos otros elementos:


{% include figure.html filename="bodycontains.png" caption="Elementos posibles de `<body>`" %}


Toda esta variedad de posibilidades puede abrumarnos a primera vista.
Con todo, debemos pensar que nuestro texto suele dividirse naturalmente en secciones o partes constitutivas.
Es recomendable, entonces, usar el elemento [`<div>`](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-div.html) para cada una de ellas y usar atributos como `@type` o `@n` para cualificar sus diferentes clases y posición en el texto (p. ej. `<div n="3" type="subsección">...</div>`).


Si nuestro texto es corto o simple, podríamos usar un solo `<div>`.
Si es más complejo, usaríamos varios.
Por ejemplo:


```
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

```
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



## Conclusiones
En esta primera parte de la lección hemos aprendido:

1. qué quiere decir códificar un texto;
2. qué son los documentos XML y XML-TEI.

En la segunda parte mostraremos en detalle dos ejemplos de codificación de textos.



## Referencias recomendadas

- La documentación completa de TEI (los *TEI Guidelines*) está disponible en la página del consorcio: https://tei-c.org/guidelines/ Aunque se la ofrece en varios idiomas, solo está completa en inglés.

- Una buena introducción (en inglés) a TEI es el libro *What Is the Text Encoding Initiative* de Lou Burnard, disponible gratuitamente en línea aquí: https://books.openedition.org/oep/426?lang=en

- Un buen tutorial para XML está disponible aquí: https://www.w3schools.com/xml/ y aquí: https://www.tutorialspoint.com/xml/index.htm

- El consorcio TEI también ofrece una buena introducción a XML: https://www.tei-c.org/release/doc/tei-p5-doc/en/html/SG.html

- La documentación oficial de XML está disponible en la página del consorcio W3C: https://www.w3.org/XML/ También está disponible la documentación para toda la familia XSL (incluido XSLT) aquí: https://www.w3.org/Style/XSL/

- La Mozilla Foundation también ofrece una buena página sobre XSLT y tecnologías asociadas: https://developer.mozilla.org/es/docs/Web/XSLT (en español) y https://developer.mozilla.org/en-US/docs/Web/XSLT (en inglés)

- La página [TTHUB](https://tthub.io) contiene una excelente "Introducción a la Text Encoding Initiative" por Susanna Allés Torrent (2019): https://tthub.io/aprende/introduccion-a-tei/
