---
title: |
    Creación de corpus paralelo con LF Aligner
authors:
    - Armando Luza
date: 2018-08-13
reviewers:
editors:
  - Maria José Afanador-Llach
layout: lesson
difficulty: 2
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/197
activity: analyzing
topics: [data-manipulation, network-analysis]
abstract: |
  "Esta lección enseña a crear corpus con traducciones a distintas lenguas, de forma que queden perfectamente alineados para una mejor visualización y consulta."
---

Un corpus paralelo o *bitexto* consiste en la recopilación de varias versiones de un texto de partida. En este tutorial aprenderás a alinear el texto original con sus traducciones para poder cotejarlos con facilidad.

## Introducción
LF Aligner es un software gratuito, basado en un [algoritmo de código abierto de alineación de oraciones](https://github.com/danielvarga/hunalign), que pertenece al conjunto de herramientas digitales llamadas ***CATs*** (*Computer Assisted Translation Tools*, por sus siglas en inglés) o herramientas de traducción asistida. Principalmente se usa para la creación de bitextos que facilitan la búsqueda de términos especializados y sus traducciones. Sitios como [Linguee](https://www.linguee.es/) utilizan este tipo de herramientas para crear enormes corpus paralelos que el usuario puede consultar fácilmente. En ciencias sociales y humanidades podemos aprovechar este software para crear textos que faciliten las tareas de lectura distante y [análisis estilístico](http://vocabularios.caicyt.gov.ar/portal/index.php?task=fetchTerm&arg=134&v=42). La aplicación puede importar texto de documentos en múltiples formatos y de memorias de traducción generadas con programas de código libre o privativo. En este tutorial nos centraremos en la importación de texto de fuentes digitales usadas comunmente por los investigadores como páginas web o documentos de texto plano, ya que, además, agilizan el proceso de alineación del corpus.

Para este tutorial necesitarás los siguientes materiales y conocimientos:
---

* El software [LF Aligner](https://sourceforge.net/projects/aligner/), disponible para Windows, Mac y Linux.
* Un texto de partida -digitalizado- y por lo menos una traducción de este. En este caso, alinearemos distintas traducciones de la Declaración Universal de Derechos Humanos: en [español](https://www.ohchr.org/en/udhr/pages/Language.aspx?LangID=spn), [inglés](https://www.ohchr.org/en/udhr/pages/Language.aspx?LangID=eng), [francés](https://www.ohchr.org/en/udhr/pages/Language.aspx?LangID=frn) y [portugués](https://www.ohchr.org/en/udhr/pages/Language.aspx?LangID=por)
* Conocimiento básico de las lenguas de traducción, ya que en algunos casos tendremos que modificar algunos de los segmentos alineados.

Adicionalmente, podemos utilizar este programa para alinear distintas versiones de un texto en una misma lengua, lo que es útil para [análisis relacional](http://vocabularios.caicyt.gov.ar/portal/index.php?task=fetchTerm&arg=136&v=42), pero hay otras iniciativas que cumplen mejor con esta tarea como [Collatex](https://collatex.net/) o [Juxta](http://www.juxtasoftware.org/).

Es importante ser sistemático con la clasificación de los documentos. El nombre de nuestros archivos txt debe acompañarse con el código que alude a la lengua del texto. Con ello aseguramos que la información con la que trabajamos siga convenciones oficiales que serán útiles a la hora de comunicar los resultados de nuestra investigación Para ello nos basaremos en el código [ISO 639-1](http://utils.mucattu.com/iso_639-1.html) que identifica a cada lengua con dos letras. Así, el español se identifica con *es*, el inglés con *en*, el francés con *fr* y el portugués con *pt*.

Si trabajas con lenguas que no estén incluidas en ese código, puedes recurrir al código [ISO 639-3](https://www.ecured.cu/ISO_639-3) que utiliza descriptores de 3 letras y abarca la totalidad de las lenguas del mundo.

Como resultado, obtendrás algo así:

{% include figure.html filename="lfaligner-1.jpg" %}


## Carga de documentos en el programa
### Eligiendo el formato apropiado:
Antes de comenzar a utilizar el programa, debemos extraer la información que nos interesa y almacenarla en un documento txt. Se recomienda hacer una revisión previa de cada texto, por separado, para identificar elementos que podrían interferir en el proceso de alineación de los textos. Es importante que cada texto tenga una puntuación, cuando menos, consistente, así como una tabulación regular. En lo posible, las palabras y oraciones deben estar separadas por un solo espacio y los párrafos por una cantidad de espacios regular.

```
{% include figure.html filename="lfaligner-2.jpg" caption="Documentos de texto plano" %}
```

### Interfaz de carga
Al ejecutar el programa, nos mostrará inmediatamente la interfaz de carga de documentos con las opciones que se describen a continuación:

```
{% include figure.html filename="lfaligner-3.jpg" caption="Interfaz de carga: selección de tipo de documentos" %}
```

1. txt (UTF-8), rtf, doc o docx: permite importar texto plano o guardado en formatos de procesadores de texto como Microsoft Word y Libreoffice Writter. Es la opción más común, puesto que, por lo general, modificaremos un poco los textos antes de trabajar con ellos.
2. pdf o pdf exportado a txt: algunos documentos con formato .pdf permiten exportar todo el texto que contienen a un archivo txt. Por lo general, podremos hacer esto desde el menú de *archivo* de nuestro lector de documentos pdf favorito, con la opción *guardar como* y eligiendo el formato txt para guardar.
3. Archivo HTML almacenado en nuestro equipo: permite cargar una página descargada y almacenada en nuestro equipo o unidad de almacenamiento portátil. Debemos asegurarnos que dicho sitio web solo contenga el texto que nos interesa, ya que el programa importará indiscriminadamente todo lo que ese sitio contenga, incluyendo el texto del menú del sitio y de otros enlaces ahí presentes.
4. webpage (página web):  permite insertar la dirección web en la que se encuentra el texto para cargarlo automáticamente. Al igual que con la opción anterior, debemos procurar que el sitio solo contenga el texto que nos interesa para asegurar una alineación satisfactoria.
5. EU legislation by CELEX number (legislación de la UE según número CELEX): esta opción permite ingresar el número identificador de un documento legislativo de la Unión Europea para que el programa descargue e importe automáticamente los documentos en las lenguas que nos interesan. La numeración CELEX clasifica los documentos según tipo, tema y otros rasgos característicos.
6. European Parliament reports (informes del Parlamento Europeo): permite descargar estos informes según año y número, en las lenguas que posteriormente especifiquemos.

Para efectos de este tutorial, debemos seleccionar la primera opción, *txt (UTF-8), rtf, doc o docx*, y presionar el botón *next*.

### Especificando las lenguas de tus textos:
```
{% include figure.html filename="lfaligner-4.jpg" caption="Interfaz de selección de lenguas" %}
```
Las opciones que la interfaz de selección de lenguas ofrece por defecto son las siguientes:
* Cantidad de lenguas
* Lengua 1
* Lengua 2

LF Aligner puede alinear hasta 11 documentos de forma simultánea. Por defecto, ofrece la opción de comenzar con el par lingüístico inglés-húngaro, pero podemos cambiar la opción que presenta por defecto si editamos el archivo LF_aligner_setup.txt que se encuentra en la carpeta del software.

```
{% include figure.html filename="lfaligner-5.jpg" caption="Configuración por defecto: inglés y húngaro" %}
```

```
{% include figure.html filename="lfaligner-6.jpg" caption="Aquí se ha modificado el par a español-inglés" %}
```

De momento, regresemos a la interfaz por defecto. En nuestro caso, alinearemos cuatro textos, por lo que en la opción *Number of languages* debemos cambiar la cantidad de 2 a 4.

Del mismo modo, debemos especificar cuál será el texto principal o de partida que servirá como eje para el cotejo. Sin embargo, puedes cambiar el orden de las lenguas, si así lo deseas, luego de alinear los textos. Si trabajas con muchas lenguas y quieres cotejar traducciones respecto de una lengua en específico, colocar el texto fuente en una posición central (y no a la extrema izquierda) podría ser útil. De momento, posicionaremos el texto en español en la primera columna de nuestro bitexto. En la opción *Language 1* cambiaremos la lengua a español (*Spanish*). Debemos hacer lo mismo con las lenguas 2 (*English*), 3 (*French*) y 4 (*Portuguese*). Una vez lista esta configuración, presiona el botón *next*.

```
{% include figure.html filename="lfaligner-7.jpg" caption="Interfaz de selección de lenguas con la configuración deseada" %}
```

### Cargando los documentos:
Los documentos se cargan uno a uno. Presiona el botón *Browse* junto a la etiqueta de cada lengua para buscar el documento correspondiente. Es importante separar los archivos en una carpeta fácil de localizar y que se use exclusivamente para almacenar los documentos que queremos integrar en nuestro corpus paralelo.

```
{% include figure.html filename="lfaligner-8.jpg" caption="Interfaz de carga de documentos" %}
```

Podemos observar que cada archivo está debidamente nombrado, con código de dos letras, según lengua. Al cargar todos los archivos, la interfaz se verá así:

```
{% include figure.html filename="lfaligner-9.jpg" %}
```

Presiona el botón *next* para que el software proceda con la alineación automática.

## Resultados de la alineación

```
{% include figure.html filename="lfaligner-10.jpg" caption="Resultados del proceso de alineación" %}
```

Antes de exportar el nuevo documento, el programa nos informará sobre los resultados del proceso de alineación automática. El algoritmo reconoce segmentos que corresponden a oraciones y organiza todos los textos de ese modo para proceder con la alineación.

En la imagen mostrada arriba, podemos observar que el texto en español tenía originalmente 92 segmentos; el software ha aumentado esta cifra a 99. Este ligero aumento en la cantidad de oraciones corresponde a la descomposición de los párrafos de cada documento. Del mismo modo, las oraciones de los demás textos han sido reorganizadas gracias al algoritmo y, en lo posible, alineadas con los segmentos correspondientes de las traducciones. Este resultado es esperable y se requiere de la intervención del usuario para completar el proceso de alineación. La práctica de esa tarea aporta al análisis preliminar del corpus, ya que seremos capaces de notar algunas diferencias estructurales en la composición de los textos. Esta ligera disimilitud entre las distintas versiones puede ser producto de omisiones o adiciones en las traducciones de la obra, o de diferencias sustanciales en las pausas utilizadas en el discurso, es decir, la puntuación.

Por esta razón, la interfaz de resultados ofrece dos opciones:

1. *Al parecer, la segmentación fue exitosa, así que usaré los textos segmentados por oración*: En nuestro caso, esta es la opción que debemos escoger. En comparación con nuestro texto de partida, las traducciones tienen solo 2 o 3 segmentos más. Como se menciona arriba, explorar los elementos que produjeron este resultado nos ayudan a tener un primer acercamiento a texto, como veremos a continuación.
2. Revertir a las versiones segmentadas por párrafo: Si las diferencias en la segmentación son muy grandes, tanto de cada texto por separado como entre ellos, podemos recurrir a esta opción. Revertir a las versiones segmentadas por párrafo también es útil cuando trabajamos con lenguas que son muy diferentes entre sí o que el algoritmo no soporta de manera oficial. Esto permite continuar con el proceso de alineación, aunque se pierda un poco del potencial de la visualización.

Luego de haber tomado una decisión al respecto -lo que también obedecerá a las necesidades de nuestro proyecto de investigación- debemos presionar el botón *next* para continuar.

**Importante**. Seleccionar la opción de *Generate xls in background after review* (crear documento en formato xls después de la revisión), para poder exportar nuestro documento perfectamente alineado de manera automática, una vez completada la revisión.

## Edición del bitexto
Ahora solo falta decidir cómo revisaremos y editaremos el texto antes de exportarlo. El editor gráfico de LF Aligner es una herramienta que facilita esta tarea, pero también podemos exportar el texto inmediatamente y modificarlo con nuestra suite de ofimática preferida.

Las opciones que el software ofrece son las siguientes:

```
{% include figure.html filename="lfaligner-11.jpg" %}
```

1. Usar el editor gráfico de LF Aligner
2. Generar un documento xls y abrirlo para revisar
3. **No revisar**: Escogeremos esta opción solo cuando los valores de la segmentación mostrados en la interfaz anterior calcen perfectamente.

Para este proyecto utilizaremos la herramienta de LF Alinger, por lo que debemos escoger la primera opción y presionar *next*.

### Interfaz de edición del bitexto
Se abrirá una nueva ventana con la interfaz de la herramienta de edición de los textos alineados.

```
{% include figure.html filename="lfaligner-12.jpg" caption="Herramienta gráfica de edición" %}
```

La primera columna marca el número de cada segmento y las subsiguientes contienen el texto en las lenguas que ingresamos. Respecto a los segmentos, podemos apreciar que la versión en español contiene uno inexistente en las demás traducciones y, por tanto, el software ha creado un segmento vacío, marcando que no hay correspondencia en las otras lenguas. Esta simple diferencia puede suscitar preguntas relacionadas con el ámbito de la retórica contrastiva: ¿Por qué las demás versiones omiten esta información? ¿Acaso en español se exige la presencia de los datos de adopción y proclamación de un documento jurídico?

Retomemos la numeración de los segmentos:

```
{% include figure.html filename="lfaligner-13.jpg" caption="Segmentos numerados" %}
```

El software ha hecho calzar el número de segmentos de las traducciones con el de nuestro texto guía y, por esa razón, es necesario revisar el documento de forma más acuciosa, no perdiendo de vista los resultados expuestos en la fase anterior. En este caso, la estructura del texto ha facilitado enormemente la labor, pero, aun así, es posible encontrar algunos errores como el siguiente:

```
{% include figure.html filename="lfaligner-14.jpg" caption="Error en uno de los segmentos" %}
```

Parte del texto que debería de estar en el segmento 11 ha quedado en el segmento 10, presumiblemente por diferencias en la puntuación. El algoritmo no ha reconocido los dos puntos como una marca de término de la oración y esto ha provocado un desfase en esta versión respecto de las otras.

Para solucionar este problema, debemos recurrir a los comandos representados por los botones de la barra inferior:
1. *Merge* (fusionar): sirve para combinar el texto de dos segmentos distintos en uno solo.
2. *Split* (separar): sirve para trasladar una porción de texto a otro segmento.
3. *Shift up* (desplazar hacia arriba): sirve para desplazar todo el texto de un segmento a una celda anterior, desplazando consigo el resto de los segmentos.
4. *Shift down* (desplazar hacia abajo): sirve para desplazar todo el texto de un segmento a una celda posterior, desplazando consigo el resto de los segmentos.

En este caso, debemos usar el comando *Split* para desplazar la porción de texto que está fuera de lugar a su casilla correspondiente. Para ello, debemos colocar el cursor del teclado en donde inicia el fragmento que deseamos mover y presionar el botón correspondiente de la barra inferior.

```
{% include figure.html filename="lfaligner-15.jpg" caption="El cursor del teclado está al comienzo del fragmento que queremos desplazar" %}
```

```
{% include figure.html filename="lfaligner-16.jpg" caption="Al presional *split*, obtendremos este resultado" %}
```

Como todavía hay una porción de texto que debe colocarse en la celda siguiente, repetimos el procedimiento.

```
{% include figure.html filename="lfaligner-17.jpg" caption="Presionamos nuevamente *split* al comienzo del fragmento que queremos desplazar" %}
```

Gracias a nuestra gestión, el texto de los segmentos 10, 11 y 12 ha quedado perfectamente alineado.

## Cierre del programa
Cuando termines de revisar el documento, escoge la opción *save & exit* (guardar y salir) en el menú *file* (archivo).

```
{% include figure.html filename="lfaligner-18.jpg" %}
```

Tras hacer esto, la herramienta de edición se cerrará. Regresa a la ventana principal del programa para cerrarlo completamente.

```
{% include figure.html filename="lfaligner-19.jpg" caption="El programa nos da la opción de generar un archivo de memoria de traducción" %}
```

LF Aligner ofrece la opción de exportar nuestro documento con formato de memoria de traducción (en este caso tmx). Este tipo de archivos sirven exclusivamente para alimentar software de traducción asistida, ya sea para creación de bases terminológicas personalizadas o para apoyo en las tareas de traducción asistida como traducción automática de segmentos. Para efectos de este tutorial, no es necesario hacer esto. Escoge la opción *no* y presiona *next* para finalizar. Aparecerá una última ventana avisándonos que el programa se ha cerrado exitosamente.

## Ubicación del documento alineado
Si seguiste las indicaciones anteriores sobre el nombramiento y almacenamiento de los textos, te será muy fácil encontrar el documento. Abre la carpeta en cuestión. Ahí verás una nueva carpeta cuyo nombre comienza con la palabra *align*. Dentro de ella encontrarás los documentos individuales en formato txt que corresponden al texto segmentado por el software y un archivo de planilla de datos (formato xls) que contiene el texto alineado y editado por nosotros.

``` 
{% include figure.html filename="lfaligner-20.jpg" caption="El archivo exportado en formato xls aparecerá en la carpeta correspondiente" %}
```

## Visualización y búsquedas simples
Si deseamos editar el documento de formas que la herramienta gráfica de LF Aligner no cubre, recomendamos abrirlo con un paquete de ofimática potente como [Libreoffice](https://es.libreoffice.org/descarga/libreoffice-estable/); su aplicación *Calc* es un excelente procesador de planillas de cálculo. No obstante, como ya nos dimos por satisfechos con nuestro trabajo de revisión anterior, exportaremos el archivo en formato *html* para poder hacer búsquedas de manera sencilla en el documento, desde nuestro navegador web. Escoge *guardar como*, en el menú *archivo* y elige *html* como formato de guardado. La herramienta de búsqueda de texto de un navegador como Google Chrome (*ctrl+f*) bastará para hacer consultas sencillas.

```
{% include figure.html filename="lfaligner-21.jpg" caption="Búsqueda simple con el navegador Google Chrome" %}
```

Sobre la base de la imagen anterior, podemos plantear algunas preguntas que podrían ser útiles para nuestra investigación; tanto en la fase preliminar de un proyecto, en la cual no se tiene claridad sobre lo que se quiere observar, como en una fase avanzada, en la que hacemos búsquedas motivadas por preguntas y criterios previamente establecidos. El tutorial sobre [AntConc](https://programminghistorian.org/es/lecciones/analisis-de-corpus-con-antconc) alojado en este sitio profundiza más en el concepto de lectura distante.

Como vemos con el ejemplo de *persona* -búsqueda basada en una lectura exploratoria del texto- tanto las similitudes como las diferencias en las traducciones del término son decidoras; por un lado, permiten conocer sus distintas traducciones y, por otro, permiten describir y comprender la naturaleza de las regularidades y variaciones de estas, lo que nos acerca más al estudio de las técnicas de traducción empleadas y las características de cada texto. En otras palabras, visualizar los textos de este modo nos permite observar, cuantificar y calificar los fenómenos discursivos y de traducción que pueden encontrarse en el texto.


## Referencias bibliográficas

- Froehlich, Heather, "Análisis de corpus con AntConc", traducido por Carlos Manuel Varón Castañeda, _The Programming Historian en español_ 3 (2018), https://programminghistorian.org/es/lecciones/analisis-de-corpus-con-antconc.

- Luna, R., “El corpus: herramienta de investigación traductológica”, *Temas de traducción*, Lima, Universidad Femenina del Sagrado Corazón (2002), pp. 57-72.

- Tiedemann, Jörg, *Bitext Alignment*, San Rafael CA, Morgan & Claypool (2011).

