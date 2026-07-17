---
title: "Optimización del proceso de transcripción de documentos históricos con AutoHotkey: abreviaturas, preetiquetado y revisión asistida"
slug: optimizacion-transcripcion-con-autohotkey
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Miguel Antonio Di Novella
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/707
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introducción

Esta lección[^1] pretende sumarse al conjunto de lecciones que emplean TEI-XML para la edición digital de textos. En ellas se abordan cuestiones como la estructura básica de un documento o las formas más adecuadas de organizarlo para obtener mejores resultados en su posterior consulta, tratamiento y publicación. Sin embargo, hay un aspecto importante que todavía no ha sido abordado con la profundidad que merece: el proceso mismo de transcripción de un texto.

Aunque las herramientas de reconocimiento óptico de caracteres ([OCR](https://es.wikipedia.org/wiki/Reconocimiento_%C3%B3ptico_de_caracteres), por sus siglas en inglés) son cada vez más eficaces, y el desarrollo de sistemas de reconocimiento de texto manuscrito ([HTR](https://es.wikipedia.org/wiki/Reconocimiento_de_escritura), por sus siglas en inglés) permite transcribir semiautomáticamente buena parte de las escrituras históricas, quienes trabajamos con documentos escritos en [letra cortesana o procesal](https://es.wikipedia.org/wiki/Escritura_espa%C3%B1ola_en_el_siglo_XV#Escritura_cortesana_del_siglo_XV)) todavía no podemos confiar plenamente en estos mecanismos[^2]. De ahí que, en muchos casos, el proceso de transcripción siga siendo total o parcialmente manual.

Por ello, esta lección pretende ser útil si quieres optimizar tu flujo de transcripción manual o etiquetar un texto procedente de OCR, HTR o, en general, de transcripciones realizadas previamente a las que todavía no hayas aplicado ningún marcado TEI.

Ahora bien, ¿cómo puede un _script_ ayudarnos en nuestras tareas de Humanidades Digitales? Eso es lo que aprenderás en esta lección con la ayuda de AutoHotkey (en adelante, AHK), un lenguaje de programación para Windows orientado a la automatización de tareas y a la creación de macros, gratuito y de código abierto. Partiendo de ejemplos sencillos, aprenderás a crear un _script_ de AHK para insertar etiquetas TEI, expandir abreviaturas frecuentes y probar el flujo de transcripción en una interfaz de usuario mínima.

## ¿Qué debes saber?

Al tratarse de una lección centrada en la edición de textos con TEI, te recomendamos que antes hayas leído las dos lecciones de Nicolás Vaughan, tituladas [Introducción a la codificación de textos en TEI](https://programminghistorian.org/es/lecciones/introduccion-a-tei-1), y la guía de Susanna Allés, titulada [Introducción a la Text Encoding Initiative](https://tthub.io/aprende/tutorial/introduccion-text-encoding-initiative). Si después quieres visualizar tus resultados en un entorno web, también puedes consultar la lección de Gabriel Calarco y Gimena del Río Riande sobre [CETEIcean](https://programminghistorian.org/es/lecciones/publicar-archivos-tei-ceteicean).

En particular, para la sección dedicada a las funciones, conviene que tengas algunas nociones básicas de programación. No necesitas experiencia avanzada: los fragmentos de código estarán acompañados de una explicación paso a paso. Sin embargo, te resultará útil entender qué es una función y cómo operan estructuras condicionales como `if`, puesto que AHK comparte algunos principios con otros lenguajes de programación, como Python o R. Para reforzar estos conceptos, te recomendamos consultar las lecciones de William J. Turkel y Adam Crymble, [Reutilización de código y modularidad en Python](https://programminghistorian.org/es/lecciones/reutilizacion-de-codigo-y-modularidad) y [De HTML a lista de palabras](https://programminghistorian.org/es/lecciones/de-html-a-lista-de-palabras-2).

## ¿Qué necesitas? Requerimientos

El primer requisito es disponer de un computador con Windows[^3]. También necesitarás instalar AHK y contar con un editor de texto plano (incluso podrías utilizar el Bloc de notas de Windows). No obstante, conviene trabajar con un editor que cuente con funcionalidades avanzadas, como [Notepad++](https://notepad-plus-plus.org/) o [Visual Studio Code](https://code.visualstudio.com/), ya que facilitará la lectura y edición del código de tu _script_.

El primer paso, entonces, es acceder a la página oficial de [AutoHotkey](https://www.autohotkey.com/) e instalar el programa en tu computador. Los archivos creados para AHK tendrán la extensión `.ahk`.

En la interfaz de inicio verás varias opciones; sin embargo, por ahora solo nos interesa crear un nuevo _script_.

## Tu primer _script_: _hotkeys_ y _hotstrings_

Buena parte de lo que encontrarás en esta sección se basa en la [explicación introductoria de tidbit](https://www.autohotkey.com/docs/v2/Tutorial.htm), aunque aquí ajustaremos sus indicaciones al objetivo de esta lección. Te recomendamos consultarla no solo para resolver dudas, sino también para ampliar tus conocimientos y aprovechar al máximo las posibilidades de AHK.

Lo primero que haremos será crear una carpeta en Windows. Puedes elegir la ubicación que prefieras; en este ejemplo, la crearemos en **Descargas** y la llamaremos `ahk_scripts`. Una vez hecho esto, puedes crear tu _script_ de dos formas:

1. Desde la interfaz de AHK: en este caso, deberás seleccionar la carpeta de destino, indicar un nombre para el archivo y marcar que incorpore la siguiente directiva: `#Requires AutoHotkey v2.0`. Si creas el archivo vacío, esta será la primera línea que deberás añadir.

2. Desde la carpeta `ahk_scripts`: para ello, haz clic derecho en un espacio vacío, selecciona **Nuevo** y, después, **AutoHotkey script** o una opción similar. A continuación, asigna un nombre al archivo y añade al comienzo la línea `#Requires AutoHotkey v2.0`.

Nuestro _script_ se llamará `tph_script`.

<div class="alert alert-warning">
Utilizamos AutoHotkey 2 porque la versión 1 está desaconsejada por su desarrollador y porque la versión más reciente incorpora numerosas mejoras y funcionalidades nuevas[^4].
</div>

Una vez indicado que el archivo debe ejecutarse con AHK 2, aprenderás dos conceptos básicos para empezar a trabajar con este lenguaje: las _hotkeys_ y las _hotstrings_.

Las primeras seguramente te resultarán familiares, aunque no las hayas llamado así hasta ahora. Una _hotkey_ es una combinación de teclas que permite ejecutar una acción o comando, como ocurre con las combinaciones habituales para copiar con `Ctrl + C` o pegar con `Ctrl + V`. Como ves, ¡ya utilizabas _hotkeys_ sin saberlo!

Veamos ahora cómo configurar una _hotkey_. Antes, sin embargo, conviene que conozcas cómo se representan en AHK algunas teclas especiales, como `Ctrl`, `Windows`, `Alt` o `Shift`. Para ello, utilizaremos una versión modificada de la tabla para principiantes de tidbit:

| Tecla | Representación en AHK 2 |
|---|---|
| `Windows` | `#` (almohadilla o numeral) |
| `Alt` | `!` (signo de exclamación de cierre) |
| `Ctrl` | `^` (caret) |
| `Shift` | `+` (signo suma) |

Puedes consultar el resto de combinaciones posibles en la [documentación de AutoHotkey](https://www.autohotkey.com/docs/v2/Hotkeys.htm).

De igual manera, como ocurre en otros lenguajes de programación, AHK cuenta con funciones que permiten ejecutar distintas acciones. Por ahora, nos centraremos en dos funciones que usaremos en los primeros ejemplos:

| Función | Para qué sirve |
|---|---|
| `Send` | Envía pulsaciones de tecla o clics simulados a la ventana activa. |
| `Run` | Ejecuta un programa externo o abre una URL en el navegador predeterminado. |

<div class="alert alert-info">
Más adelante usaremos `SendText`, una variante de `Send` destinada a enviar texto literal y, por ello, más adecuada en algunos de los contextos que veremos.
</div>

Asimismo, debes conocer una parte esencial de la sintaxis de AHK: los dobles dos puntos (`::`). En una _hotkey_, lo situado a la izquierda de los dobles dos puntos indica la combinación de teclas que debes pulsar. Lo situado a la derecha, o dentro del bloque delimitado por llaves (`{}`), indica la acción que se ejecutará.

Dicho esto, creemos nuestra primera _hotkey_. Para ello, abre el archivo que acabas de crear y escribe la siguiente línea. Con `Ctrl + H`, imprimiremos en pantalla nuestro “Hola, mundo”:
```ahk
^h::SendText "Hola, mundo"
```
Recuerda que también puedes escribir la misma instrucción entre llaves, en forma de bloque:
```ahk
^h::	  
{  
	SendText "Hola, mundo"  
}
```
Guarda el archivo, haz doble clic sobre él, abre cualquier campo de texto y presiona `Ctrl + H`: ¡es tu primera _hotkey_ en funcionamiento! Recuerda: no uses ambas formas en el mismo _script_, solo una de ellas.

Hagamos ahora algo más específico para un flujo de trabajo orientado a la edición TEI: introduciremos las marcas `<gap>` y `<supplied>`. Las pautas del estándar TEI P5 definen esta etiqueta así:

> `<gap>` (gap) indicates a point where material has been omitted in a transcription, whether for editorial reasons described in the TEI header, as part of sampling practice, or because the material is illegible, invisible, or inaudible.[^5]

Normalmente, esta etiqueta puede contener atributos como `reason` o `agent`. Para este ejemplo, asumiremos que en nuestra edición solo nos interesa marcar, dentro de `<gap>`, el motivo del vacío:
```ahk
!g::	SendText '<gap reason=""></gap>'
```
En este caso, `Alt + G` insertará lo siguiente:
```xml
<gap reason=""></gap>
```
Las tildes graves se añaden para evitar un error de sintaxis en el _script_.

Por otro lado, la etiqueta `<supplied>` se define como sigue:

> `<supplied>` (supplied) signifies text supplied by the transcriber or editor for any reason; for example because the original cannot be read due to physical damage, or because of an obvious omission by the author or scribe.[^6]

Nuevamente, incluiremos solo el atributo `reason`:
```ahk
!s::	Send "<supplied reason=`"`"></supplied>"
```
Como ves, el procedimiento es sencillo, aunque sería mucho más cómodo que el cursor se colocara directamente donde vamos a escribir. Para ello, podemos combinar dos instrucciones con `Send`: la primera inserta el texto literal, mientras que la segunda permite indicar que el cursor debe moverse tantas veces como queramos. En este caso, lo desplazamos hacia la izquierda, de manera que quede dentro del entrecomillado de `reason`:
```ahk
!s::  
{  
	SendText '<supplied reason=""></supplied>'  
	Send	"{Left 13}"
}
```
En este caso es necesario usar llaves, ya que nuestro _script_ combina dos acciones.

Ahora vamos a conocer la función `Run`. Como indicamos en la tabla, esta función permite abrir programas instalados en el computador, pero también puede utilizarse para abrir enlaces web. Por ejemplo, para abrir una página web con una combinación de teclas, puedes escribir:
```ahk
!1::	Run "https://www.google.com"
```
Para abrir un programa, debes indicar el nombre del ejecutable (`.exe`). Por ejemplo, para abrir el Bloc de notas:
```ahk
!2::	Run "notepad.exe"
```
<div class="alert alert-warning">
En el caso de programas de terceros, conviene comprobar el nombre exacto del ejecutable en la carpeta donde fue instalado.
</div>

Abrir un único acceso directo puede ser útil, pero la mayor utilidad de la función `Run` aparece cuando necesitas abrir varios recursos que forman parte de tu flujo de trabajo. Por ejemplo, supongamos que necesitas abrir PARES para buscar documentación, el _Diccionario de abreviaturas novohispanas_ (DICABENOVO) y LibreOffice Writer para transcribir:
```ahk
!1::  
{  
	Run "https://pares.cultura.gob.es/"
	Run "https://www.iifilologicas.unam.mx/dicabenovo/"  
	Run "swriter.exe" ; LibreOffice Writer  
}
```
<div class="alert alert-info">
Los comentarios deben ir precedidos de un punto y coma, como en el ejemplo anterior: `; LibreOffice Writer`.
</div>

Recuerda que siempre podrás pausar o cerrar tu _script_ desde la barra de tareas de Windows. Para ello, haz clic en la flecha hacia arriba, localiza el icono de AHK, haz clic derecho sobre él y selecciona la opción correspondiente.

Pasemos ahora a las _hotstrings_. A diferencia de las _hotkeys_, no se activan mediante una combinación de teclas, sino al escribir una determinada secuencia de caracteres. Su uso es más localizado, pues básicamente se emplean para expandir abreviaturas, palabras o frases frecuentes mientras escribes.

La sintaxis es sencilla: entre el primer y el segundo par de dos puntos escribimos la abreviatura que queremos desarrollar y, después del segundo par, el texto que AHK debe insertar. Vamos a hacer una pequeña prueba con _The Programming Historian_, que abreviaremos como `tph`:
```ahk
::tph::The Programming Historian
```
Escribe ahora `tph` en cualquier campo de texto y pulsa una tecla de cierre, como espacio, punto o salto de línea. Verás que AHK sustituye automáticamente la abreviatura por _The Programming Historian_.

Como habrás observado, puedes aplicar este procedimiento a cualquier abreviatura frecuente, histórica o no. En tareas como la transcripción manual, resulta especialmente conveniente para expandir abreviaturas tomadas de recursos como el DICABENOVO o para insertar formas ya adaptadas a las necesidades de tu corpus, incluido el marcado que quieras aplicar desde el primer momento.

Según las directrices TEI P5, para indicar que el editor ha expandido una abreviatura, debe encerrarse en la etiqueta `<expan>` la expansión de dicha abreviatura[^7]. Veamos un ejemplo con la palabra ulteriormente y una de sus posibles abreviaturas, tomada del DICABENOVO.

En un texto podemos encontrar la forma abreviada _ulteriormte_. Si queremos transcribirla con la abreviatura desarrollada y marcada en TEI, podemos representarla así: `ulteriorm<expan>en</expan>te`. Para automatizar este proceso, podríamos emplear la siguiente _hotstring_:
```ahk
::ulte.::ulteriorm<expan>en</expan>te
```
En casos como este, conviene evitar secuencias de activación demasiado largas. Es preferible reducirlas al mínimo necesario y asegurarse de evitar que entren en conflicto con otras formas similares. En el DICABENOVO encontramos, por ejemplo, _ulteriormente_, _últimamente_ y _último_. Además, añadiremos _última_. No tienes por qué seguir exactamente esta propuesta, pero una posible solución sería la siguiente:
```ahk
::ulte.::ulteriorm<expan>en</expan>te
::ulti.::ultimam<expan>en</expan>te 
::ulto.::ult<expan>im</expan>o  
::ulta.::ult<expan>im</expan>a
```
Ahora, ¡haz la prueba en cualquier campo de texto! Como actividad, te propongo trabajar con una letra del DICABENOVO, la que prefieras. El objetivo es que practiques la creación de _hotstrings_ y reflexiones sobre cómo puedes adaptarlas a las necesidades de tu corpus. En el _script_ de ejemplo que acompaña a esta lección encontrarás desarrollada la letra U.

Combinando todo lo que hemos aprendido hasta ahora, podríamos crear algo similar al autocompletado que usan los entornos de programación para preetiquetar entidades como nombres, lugares o títulos de obras:
```ahk
:*:@n::<name></name>{Left 7}
:*:@p::<place></place>{Left 8}
:*:@t::<title></title>{Left 8}
```
De este modo, puedes abrir y cerrar automáticamente una etiqueta en cualquier campo de texto y colocar el cursor dentro de ella para seguir escribiendo.

También podríamos aprovechar una _hotstring_ para almacenar una plantilla básica para documentos TEI, como la propuesta por Nicolás Vaughan en [Introducción a la codificación de textos en TEI](https://programminghistorian.org/es/lecciones/introduccion-a-tei-1), y crearla desde cero en pocos segundos. Para hacerlo correctamente, conviene que antes conozcas qué son y cómo trabajan las funciones en AHK.

## Funciones

Como en otros lenguajes de programación, en AHK podemos crear funciones reutilizables. Una función permite agrupar un conjunto de instrucciones bajo un nombre para ejecutarlas más de una vez sin tener que reescribir todo el código.

En esta lección utilizaremos funciones para automatizar tareas frecuentes de transcripción y marcado: envolver un fragmento o término seleccionado con etiquetas TEI, convertir texto a mayúsculas o minúsculas e insertar notas predefinidas. Empezaremos con un caso sencillo: envolver una selección con una etiqueta de apertura y otra de cierre.

### Etiquetar texto seleccionado

Imagina la siguiente situación: tienes un texto parcialmente editado, pero todavía no has etiquetado sus entidades y no es posible hacerlo de forma automática. Podríamos crear una _hotkey_ para cada etiqueta, pero sería poco práctico: todas ellas seguirían la misma lógica y, además, aumentaría el riesgo de errores. Para evitar esta repetición, crearemos una función llamada `tagger()`.

Vamos a seguir trabajando con el _script_ que creamos en la sección anterior, pero antes de definir la función revisaremos y añadiremos algunas líneas generales al inicio del _script_:
```ahk
#Requires AutoHotkey v2.0
#SingleInstance Force
SetTitleMatchMode "RegEx"
SetWinDelay 0
```
La primera línea indica que el archivo requiere AHK 2. La segunda previene que se abran varias copias del mismo _script_. Las restantes ajustan algunos aspectos del comportamiento del programa: reconocer ventanas de forma flexible (esto quiere decir que el _script_ seguirá reconociendo que trabajas en una determinada ventana aunque esta cambie de nombre, gracias al uso de expresiones regulares), la velocidad a la que se envían las pulsaciones simuladas y el tiempo de espera al interactuar con ventanas.

Vamos a definir las _hotkeys_ de los etiquetadores de `<name>`, `<place>` y `<title>`:
```ahk
!n::tagger("<name>", "</name>") 
!p::tagger("<place>", "</place>")  
!t::tagger("<title>", "</title>")
```
Recuerda: lo que está a la izquierda de los dobles dos puntos (`::`) es nuestra combinación de teclas. A la derecha de estos, definimos la acción que deberá ejecutar AHK. En este caso, llamamos a la función `tagger()` con los valores `"<name>"` y `"</name>"`. El primero es la etiqueta de apertura y el segundo la de cierre.

A diferencia de lo que hicimos en la sección anterior, aquí veremos la función en su totalidad y, posteriormente, la explicaremos en detalle:
```ahk
tagger(openTag, closeTag) {
	ClipSaved := ClipboardAll()   ; guarda el portapapeles
	A_Clipboard := ""             ; lo limpia
	Send "^c"                     ; copia la selección

	if !ClipWait(0.3) {
		A_Clipboard := ClipSaved
		EnsureAltUp()
		return
	}

	selectedText := A_Clipboard
	A_Clipboard := ClipSaved      ; restaura el portapapeles original

	; si no hay texto, nada
	if (selectedText = "") {
		EnsureAltUp()
		return
	}

	; escribimos directamente las etiquetas y el texto seleccionado
	SendText openTag . selectedText . closeTag
	EnsureAltUp()                 ; nos aseguramos de que Alt no se quede presionada
}
```
<div class="alert alert-warning">
No te apresures a copiar y pegar el código: todavía no funcionará.
</div>

Con esta función podemos seleccionar cualquier texto y escribir alrededor de él las etiquetas que queramos, dependiendo de la combinación de teclas que usemos. En el ejemplo, si pulsamos `Alt + n` llamaremos a la función con estas etiquetas:
```ahk
tagger("<name>", "</name>")
```
Como puedes ver, van a reemplazar los parámetros `openTag` y `closeTag`. Por tanto, si seleccionamos un fragmento de texto, por ejemplo un nombre como Miguel, se convertiría en:
```xml
<name>Miguel</name>
```
Uno de los inconvenientes de trabajar con el portapapeles es que puede darse el caso de querer utilizarlo a la par que usamos el etiquetador. Entonces, ¿cómo usamos el etiquetador sin perjudicar el portapapeles? Para eso tenemos la primera línea: `ClipSaved := ClipboardAll()`. Esta instrucción permite guardar de forma temporal el contenido que seleccionamos en nuestro portapapeles y, posteriormente, restaurar lo que estuviese copiado. De ese modo no se pierde el flujo de trabajo aunque el etiquetado use el portapapeles.

`A_Clipboard := ""` deja el portapapeles vacío, asegurándonos así de que el contenido copiado coincide con el seleccionado y con `Send "^c"` simulamos la acción `Ctrl + C`, es decir, copiamos al portapapeles el texto que tenemos seleccionado.

Posteriormente, incorporamos la condicional `if !ClipWait(0.3)` para asegurarnos de que el texto se haya copiado correctamente. En ella, el _script_ espera 0.3 segundos. Si no se ha copiado nada, restaura el portapapeles original, llama a la función `EnsureAltUp()` y detiene el _script_ con `return`.

Antes de seguir, ¿para qué llamar a otra función? Tras probar varias combinaciones, un error se repetía frecuentemente: una de las teclas de la combinación, ya fuese `Alt` o `Ctrl`, se mantenía falsamente presionada, de manera que no se podía seguir trabajando a menos que se pulsara nuevamente. Con esta pequeña función nos aseguramos de que esto no ocurra o, al menos, reducimos drásticamente ese riesgo.
```ahk
EnsureAltUp() {
    ; Espera un momento a que Alt se suelte, y si sigue “pulsada”, la suelta a la fuerza

    KeyWait "Alt", "T0.2"              ; espera hasta 0.2 s a que Alt se libere
    if GetKeyState("Alt", "P") {       ; si físicamente sigue abajo...
        Send "{Alt up}"                ; ...la forzamos a soltar
    }
}
```

Esta función se compone de `KeyWait "Alt", "T0.2"`, que verifica si `Alt` sigue pulsada (espera dos décimas de segundo) y fuerza su liberación mediante `Send "{Alt up}"`. Esto subsana uno de los problemas que teníamos inicialmente: la tecla `Alt` se quedaba virtualmente presionada y esto generaba problemas.

Por otro lado, si la copia se ha realizado correctamente, el contenido se guarda en la variable `selectedText` y se restaura el portapapeles original con `A_Clipboard := ClipSaved`. A continuación, el _script_ comprueba nuevamente si el texto está vacío, de esta forma, si no hay texto seleccionado, la función se detiene, evitando crear así etiquetas fantasma:
```ahk
if (selectedText = "") {
	EnsureAltUp()
	return
}
```
Hechas todas estas comprobaciones, pasamos al etiquetado en sí, que se realiza en la operación final:
```ahk
SendText openTag . selectedText . closeTag
```
Con esta acción nos aseguramos de que AHK componga la siguiente estructura: etiqueta de apertura + texto seleccionado + etiqueta de cierre. Estas partes se concatenan mediante el operador `.` (punto).

También en caso de copia exitosa nos aseguramos de que no quede la tecla activa con la función `EnsureAltUp()`. Ahora, crea tus propias _hotkeys_ y añade las funciones `tagger()` y `EnsureAltUp()` a tu _script_.

### Otras funciones de interés

Otras dos funciones útiles durante el proceso son las de conversión a mayúsculas y minúsculas. Aunque los procesadores de texto ya las incluyen, a veces resulta más cómodo seleccionar el texto y pulsar una combinación de teclas.

Para ello, usamos la función `ConvertSelection()` que sigue una lógica muy parecida a la empleada en el etiquetador `tagger()` explicado anteriormente, pero se fija en si recibe el valor `upper` o `lower`:
```ahk
ConvertSelection(mode) {
    ClipSaved := ClipboardAll()
    A_Clipboard := ""
    Send "^c"
    if !ClipWait(0.3) {
        A_Clipboard := ClipSaved
        EnsureAltUp()
        return
    }

    selectedText := A_Clipboard
    A_Clipboard := ClipSaved

    if (selectedText = "") {
        EnsureAltUp()
        return
    }

    if (mode = "upper")
        newText := StrUpper(selectedText)
    else if (mode = "lower")
        newText := StrLower(selectedText)
    else
        newText := selectedText

    ; pegamos el texto transformado
    A_Clipboard := newText
    ClipWait 0.3
    Send "^v"

    EnsureAltUp()
}
```
En caso de recibir el primero, aplica `newText :=` `StrUpper(selectedText)`, pasándolo a mayúsculas, mientras que en el segundo, aplica `newText := StrLower(selectedText)` y lo convierte en minúsculas. Si no recibe ninguno de los anteriores, lo deja igual: `newText := selectedText`. Una vez transformado, lo envía al portapapeles y lo pega encima del texto anterior. Como siempre, nos aseguramos de que `Alt` no se quede presionada.

Una última función que consideramos útil es la que permite incluir notas en el texto de forma sistemática. En la transcripción paleográfica, normalmente es necesario añadir notas o comentarios. Para ello, hemos creado la función `InsertNote()`, que simplemente inserta un texto preparado y lo pega en la interfaz en la que estemos trabajando:
```ahk
InsertNote(noteText) {
    SendText noteText
    EnsureAltUp()
}
```
Como podrás observar, se trata de una misma lógica empleada en múltiples ocasiones y adaptada a diferentes necesidades. Entonces, ¿cómo plantear la creación de la plantilla propuesta por Nicolás Vaughan? A continuación, te dejamos nuestra propuesta:
```ahk
::tei.xml::
{
    template := '
(
<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml"
  schematypens="http://purl.oclc.org/dsdl/schematron"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <fileDesc>
      <titleStmt>
        <title>Título del documento</title>
      </titleStmt>
      <publicationStmt>
        <p>Información sobre la publicación de este documento (no de su fuente).</p>
      </publicationStmt>
      <sourceDesc>
        <p>Información sobre la fuente de este documento.</p>
      </sourceDesc>
    </fileDesc>
  </teiHeader>
  <text>
    <body>
      <p>Algo de texto aquí.</p>
    </body>
  </text>
</TEI>
)'

    A_Clipboard := template
    ClipWait 1
    Send "^v"
}
```
En este caso, usamos la _hotstring_ `tei.xml` y, para evitar que se pegue incorrectamente, la almacenamos en una variable `plantilla` porque, de otra forma, perdería el formato original. Además, hemos añadido una pausa de seguridad para asegurarnos de que el portapapeles reciba toda la plantilla, ya que es un fragmento relativamente largo.

### Transformar marcado sencillo en etiquetas TEI

Esta lógica de trabajo se puede aplicar a casi cualquier etiqueta. Pensemos, por ejemplo, en entidades como nombres de persona, lugares o títulos de obras. Retomando una propuesta sencilla de Nicolás Vaughan en su _Introducción a TEI_:

> Hay muchas formas de codificar un texto. Por ejemplo, podemos encerrar entre asteriscos simples los nombres propios de personas: \*Simón Bolívar\*, \*Soledad Acosta\*, etc. Y entre asteriscos dobles los de lugares: \*\*Bogotá\*\*, \*\*Framingham\*\*, etc. Podemos también usar guiones bajos para indicar los nombres de obras y de libros: \_La divina comedia\_, \_Cien años de soledad\_, etc. Estos signos sirven para etiquetar o marcar el texto que encierran, para así identificar en el texto un determinado contenido. Como es fácil de imaginar, las posibilidades de codificación son casi infinitas.

Partiendo de este marcado sencillo, podemos transformarlo automáticamente con AHK mediante [expresiones regulares](https://es.wikipedia.org/wiki/Expresi%C3%B3n_regular):
```ahk
^!x:: {
    A_Clipboard := ""

    Send "^c"
    if !ClipWait(1)
        return

    text := A_Clipboard

    text := RegExReplace(text, "\*\*([^*]+)\*\*", "<place>$1</place>")
    text := RegExReplace(text, "(?<!\*)\*([^*]+)\*(?!\*)", "<name>$1</name>")
    text := RegExReplace(text, "_([^_]+)_", "<title>$1</title>")

    A_Clipboard := text
    Send "^v"
	EnsureAltUp()
}
```
De forma resumida, las expresiones regulares recogidas en el código hacen lo siguiente:

| Expresión regular | Qué busca | Resultado |
|----|----|----|
| `\*\*([^*]+)\*\*` | Texto entre dobles asteriscos: `**Bogotá**` | `<place>Bogotá</place>` |
| `(?<!\*)\*([^*]+)\*(?!\*)` | Texto entre asteriscos simples: `*Simón Bolívar*` | `<name>Simón Bolívar</name>` |
| `_([^_]+)_` | Texto entre guiones bajos: `_La divina comedia_` | `<title>La divina comedia</title>` |
| `$1` | Recupera el texto capturado dentro de los signos | Conserva el contenido original dentro de la etiqueta |

Estas líneas de código permiten que, al seleccionar esos fragmentos de texto, podamos convertirlos automáticamente a etiquetas TEI.

### Opcional: crea una interfaz

Aunque AHK siempre se ejecuta en la barra de tareas y desde allí puedes controlar el _script_, puede ser de utilidad contar con una interfaz gráfica. Empezaremos por una que llamaremos mínima.
```ahk
global ScriptActive := true
global MainGui, TestEdit, BtnToggle

CreateGUI()

CreateGUI() {
    global MainGui, TestEdit, BtnToggle

    MainGui := Gui("+AlwaysOnTop +Resize +MinimizeBox", "Prueba de script TPH AHK")
    MainGui.SetFont("s10", "Segoe UI")

    MainGui.AddText("w500", "Escribe en la caja para probar los atajos y abreviaturas.")

    TestEdit := MainGui.AddEdit(
        "w500 h180 WantTab",
        "Prueba aquí:`r`n`r`ntph`r`nulte.`r`n@n`r`n@p`r`n@t"
    )

    BtnToggle := MainGui.AddButton("w500 h35", "Desactivar atajos")
    BtnToggle.OnEvent("Click", (*) => ToggleScripts())

    MainGui.Show("AutoSize Center")
}

ToggleScripts() {
    global ScriptActive, BtnToggle

    ScriptActive := !ScriptActive

    if ScriptActive {
        Suspend false
        BtnToggle.Text := "Desactivar atajos"
    } else {
        Suspend true
        BtnToggle.Text := "Activar atajos"
        EnsureAltUp()
    }
}
```
En la primera línea se crea la ventana, para la que, además, hemos definido que se mantenga por encima de las demás (`+AlwaysOnTop`), que pueda cambiar de tamaño (`+Resize`) y minimizarse (`+MinimizeBox`). Asimismo, le asignamos un nombre. Posteriormente, definimos el tipo de letra y tamaño y, a continuación, añadimos un pequeño texto para el usuario.

Con `TestEdit` podemos añadir una caja de texto, que será donde podamos hacer las pruebas que convengamos necesarias antes de trabajar con el _script_ sobre nuestros documentos. En ella definimos el ancho (`w500`), el alto (`h180`) y permitimos el uso del tabulador (`WantTab`) en el campo de texto. Se añaden algunos ejemplos de uso, aunque puedes eliminarlos si así lo prefieres.

Configuramos un botón para activar y desactivar los atajos mediante la función `ToggleScripts()`, que encontrarás definida en el _script_ completo. En último lugar, hemos configurado la ventana para que ajuste su tamaño al contenido (`AutoSize`) y que aparezca centrada en pantalla (`Center`).

Te dejamos a continuación el _script_ completo para que puedas modificarlo como quieras: [`tph_script.ahk`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/optimizacion-transcripcion-con-autohotkey/tph_script.ahk).

## Compilación a exe

Ya hemos construido un _script_ que cubre buena parte del flujo de trabajo vinculado a la edición digital de textos. Sin embargo, si queremos utilizarlo en otros computadores o compartirlo con otras personas, sería conveniente convertirlo en un archivo ejecutable (`.exe`).

AHK incorpora un compilador que permite convertir tus _scripts_ `.ahk` a `.exe`. De esta manera, podrás ejecutar tu _script_ sin necesidad de instalarlo en el equipo de destino, ya que se compila como un programa portable. Por tanto, puedes llevarlo en una memoria USB o en un disco duro portátil.

Para hacerlo, abre AHK y selecciona la opción **Compile**, se te abrirá una nueva ventana con el programa **Ahk2Exe** (Figura 1):

{% include figure.html filename="es-or-optimizacion-transcripcion-con-autohotkey.jpg" alt="Ventana del compilador Ahk2Exe con campos para seleccionar el archivo fuente, el archivo de destino, el icono personalizado y el botón de convertir a ejecutable" caption="Figura 1. Interfaz de usuario de Ahk2exe." %}

Ya en el compilador, deberás seleccionar el _script_ que has creado en la carpeta (`tph_script`) y dejar el resto de opciones predeterminadas, ya que suelen funcionar en la mayoría de computadores Windows. Además, tienes la posibilidad de añadir un icono al `.exe`; recuerda que debe estar en formato `.ico`.

## Conclusiones

Como habrás observado hasta ahora, en esta lección solo hemos explorado una pequeña parte de lo que es posible hacer con AHK. Además, nos hemos centrado en algunas de sus funciones más sencillas, pero con este lenguaje podemos hacer mucho más. AHK no solo permite reducir o simplificar tareas repetitivas, sino también construir herramientas mínimas que se adapten a lo que requiere nuestro corpus, sin necesidad de desarrollar una aplicación compleja desde cero.

Por ello, creemos que puede ser un recurso sumamente útil para quienes quieran mejorar su flujo de trabajo paleográfico o de edición sin necesidad de tener conocimientos avanzados de programación. De hecho, puedes ayudarte con IA generativa para desarrollar tu propio _script_, partiendo de lo aprendido en esta lección y de la documentación oficial.

Te recomendamos echar un vistazo a los repositorios de GitHub basados en AHK, ya que permite imaginar flujos de trabajo mucho más complejos, especialmente aquellos que conectan con APIs, herramientas de OCR o modelos de lenguaje de gran tamaño (LLMs).

Nuestra recomendación final es que programes y pruebes de forma constante. De esa manera, podrás ampliar y mejorar tu _script_ a medida que trabajes con tus propios materiales. Como has visto, AHK ofrece múltiples posibilidades y esa flexibilidad es una gran ventaja para quienes trabajamos en Humanidades Digitales: nuestras necesidades son diversas, nuestros corpus presentan problemas distintos y puede que lo que funcione para ti no lo haga para otra persona.

## Referencias

- Campos Leza, Fernando. «Introducción a AutoHotkey para traductores». La Linterna del Traductor, 4 de abril de 2017. [https://lalinternadeltraductor.org/n14/autohotkey.html](https://lalinternadeltraductor.org/n14/autohotkey.html).  
- Instituto de Investigaciones Filológicas de la Universidad Nacional Autónoma de México. «Diccionario de abreviaturas novohispanas». Abreviaturas castellanas, 2 de noviembre de 2024. [https://www.iifilologicas.unam.mx/dicabenovo/](https://www.iifilologicas.unam.mx/dicabenovo/).  
- «Notepad++». [https://notepad-plus-plus.org/](https://notepad-plus-plus.org/).  
- Río Riande, Gimena del. «Humanidades Digitales o las Humanidades en la intersección de lo digital, lo público, lo mínimo y lo abierto». Publicaciones de la Asociación Argentina de Humanidades Digitales 3 (noviembre de 2022): e038. [https://doi.org/10.24215/27187470e038](https://doi.org/10.24215/27187470e038).  
- Río Riande, Gimena del, Gabriel Calarco, Roy Youdale, y Patience Shell. «Minimal Computing 101». Sobre Minimal Computing, 8 de agosto de 2025. [https://hdlab.space/minimalbook/sobre_minimalcomputing.html](https://hdlab.space/minimalbook/sobre_minimalcomputing.html).  
- Steve Gray, Chris Mallett, AutoIt Team et al. «Hotkeys - Definition & Usage AutoHotkey v2». AutoHotkey v2 Documentation, 2014-. [https://www.autohotkey.com/docs/v2/Hotkeys.htm](https://www.autohotkey.com/docs/v2/Hotkeys.htm).  
- The TEI Consortium. The TEI Guidelines. 2026. [https://guidelines.tei-c.de/en/html/index.html](https://guidelines.tei-c.de/en/html/index.html).  
- tidbit. «Beginner Tutorial AutoHotkey v2». AutoHotkey v2 Documentation, 2014. [https://www.autohotkey.com/docs/v2/Tutorial.htm](https://www.autohotkey.com/docs/v2/Tutorial.htm).  
- «Visual Studio Code». [https://code.visualstudio.com/](https://code.visualstudio.com/).

## Notas

[^1]: El texto de esta lección ha sido revisado con herramientas de inteligencia artificial generativa, en concreto, ChatGPT.  
[^2]: El tipo de letra no es la única barrera a la que nos enfrentamos desde la investigación: las digitalizaciones de los manuscritos no siempre son lo suficientemente fieles para poder aplicar estas herramientas que, además, en algunos casos, son de pago (o limitados a un determinado número de tokens al mes). Las alternativas de código abierto y gratuitas, por su parte, requieren de ciertos conocimientos técnicos superiores a los necesarios para utilizar la herramienta aquí propuesta.  
[^3]: La compatibilidad está garantizada en computadores con SO Windows 7 o superiores. Aunque no se aborda en esta lección, en Linux existe [AutoKey](https://github.com/autokey/autokey), una herramienta independiente de automatización de escritorio con funciones similares. Está diseñada para entornos X11 y presenta problemas de compatibilidad cuando se utiliza Wayland en lugar de Xorg. Algo similar ocurre con implementaciones como [AHK_X11](https://github.com/phil294/AHK_X11).
[^4]: Puedes acceder al listado detallado de cambios aquí: [https://www.autohotkey.com/docs/v2/v2-changes.htm](https://www.autohotkey.com/docs/v2/v2-changes.htm). También encontrarás el enlace a un convertidor de _scripts_ versión 1 a 2.
[^5]: TEI Consortium, _The TEI Guidelines_, 436.
[^6]: TEI Consortium, _The TEI Guidelines_, 436.
[^7]: TEI Consortium, _The TEI Guidelines_, 115.
