---
title: "Georreferenciación y visualización de itinerarios con Recogito y Visone"
slug: georreferenciacion-visualizacion-con-recogito-y-visone
layout: lesson
collection: lessons
date: 2024-MM-DD
authors:
- Gabriel Calarco
- Gimena del Río Riande
reviewers:
- Anthony Picón Rodríguez
- Sebastian Diaz Angel
editors:
- Maria José Afanador-Llach
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/570
difficulty: 
activity: 
topics: 
abstract: "En este tutorial aprenderás sobre tecnologías de anotación, georreferenciación y visualización de datos en un flujo de trabajo con dos softwares gratuitos que se han venido desarrollando al interior de la comunidad global de humanistas digitales: Recogito y Visone. No exploraremos todas las posibilidades de estas herramientas, sino que apenas usaremos las que nos permitirán visualizar un itinerario sobre un mapa."
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

# Introducción
En este tutorial aprenderás sobre tecnologías de anotación, georreferenciación y visualización de datos en un flujo de trabajo con dos softwares gratuitos que se han venido desarrollando al interior de la comunidad global de humanistas digitales: **[Recogito](https://recogito.pelagios.org/)** y **[Visone](https://visone.ethz.ch/)**. No exploraremos todas las posibilidades de estas herramientas, sino que apenas usaremos las que nos permitirán visualizar un itinerario sobre un mapa. Así, este tutorial se estructura en dos partes bien diferenciadas pero íntimamente relacionadas en tanto proceso o flujo de trabajo, en las que:
1. Georreferenciarás lugares anotados automáticamente y curados manualmente en Recogito
2. Agregarás relaciones entre esos lugares marcados en Recogito
3. Exportarás esas relaciones marcadas en Recogito en formato [`.csv`](https://es.wikipedia.org/wiki/Valores_separados_por_comas)
4. Importarás esa red en Visone
5. Visualizarás tu red sobre un mapa
6. Exportarás tu red como un archivo de imagen

Para poner en práctica estas actividades, volveremos sobre un fragmento del texto ya utilizado para el tutorial [Introducción a la publicación web de archivos TEI con CETEIcean](https://programminghistorian.org/es/lecciones/publicar-archivos-tei-ceteicean): _La Argentina Manuscrita_, de Ruy Díaz de Guzmán. Ruy Díaz fue un militar mestizo guaraní-español y que dio forma al primer relato en español de la exploración, conquista y colonización de las tierras del Río de la Plata. Puedes encontrar más información y el texto completo de esta obra en [esta edición](https://hdlab.space/La-Argentina-Manuscrita/) elaborada por el [Laboratorio de Humanidades Digitales del Conicet](https://hdlab.space/). Si bien usaremos este ejemplo para este tutorial, el flujo de trabajo que aprenderás aquí te será de utilidad para trabajar con diferentes tipologías textuales, siempre que tengan una cantidad sustancial de topónimos, como diarios de viajes, descripciones geográficas, novelas, o cualquier tipo de texto rico en referencias de lugares.

No es necesario tener experiencia previa en informática para seguir este tutorial.

# Anotación semántica de lugares y georreferenciación con Recogito

En la primera parte de este tutorial usaremos la herramienta gratuita y de código abierto Recogito, que permite un trabajo en línea y de almacenamiento en la nube. Esta herramienta ha sido desarrollada por [Pelagios Network](https://medium.com/pelagios). Recogito es una plataforma de anotación semántica. Ofrece un espacio personal de trabajo donde se pueden cargar, recopilar y organizar materiales fuente ‒textos, imágenes y datos tabulares‒ y/o colaborar en anotaciones y tareas grupales de georreferenciación. A pesar de que Recogito permite anotar personas, lugares y eventos, en este tutorial solo trabajaremos anotando lugares. 

La georreferenciación es un proceso que consiste identificar los topónimos y asignarles las coordenadas de su localización geográfica asociándolos con una entrada correspondiente en un gazetteer de información geográfica (un gazeteer es un diccionario histórico - geográfico. Puedes encontrar más información sobre este proceso en el tutorial [Georreferencias con QGIS 2.0](https://programminghistorian.org/es/lecciones/georreferenciar-qgis)). La georreferenciación de textos a través de herramientas digitales se ha convertido en una metodología importante en diferentes disciplinas, y su impulso en los últimos años ha dado lugar a un auge de las "Humanidades Espaciales". 

## Crea una cuenta 

En primer lugar, crea una cuenta en [Recogito](https://recogito.pelagios.org/) con un correo electrónico y nombre de usuario.
 
## Sube un documento y aplica NER

Con Recogito puedes anotar una variedad de documentos digitales (incluidos los formatos de imagen), pero en este tutorial nos centramos en documentos de texto. Para cargar un documento de texto en Recogito, recomendamos utilizar el formato `.txt` (si el documento estuviera en otro formato de texto, por ejemplo, un .doc de Word o de otro procesador de texto, primero debes convertirlo al formato UTF-8 Unicode. Esto puede hacerse en cualquier editor de texto, como Word o Google Docs, simplemente usando la opción "guardar como"). 

En este caso, sube (en "New" > "File") [este fragmento de *La Argentina Manuscrita*](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/georreferenciacion-visualizacion-con-recogito-y-visone/fragmento_La_Argentina_manuscrita_tutorial_recogito_visone.txt)
Ojo, Recogito **no es un editor de texto**, por lo cual no podrás realizar cambios en el texto una vez que se haya cargado.

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-01.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 1. Librería de documentos subidos por una cuenta a Recogito." %} 

Posiciónate sobre el documento que acabas de subir, ve a "Options" y de allí a "Named Entity Recognition" (NER). El reconocimiento de entidades nombradas (NER) es un método de procesamiento de lenguaje natural (NLP) automatizado que extrae información del texto. NER implica la detección y categorización de cualquier información que de antemano se considere importante en el texto y se decida marcar o extraer. 

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-02.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 2. Posición de Named Entity Recognition en el menú de opciones de Recogito." %} 

En este paso, Recogito "leerá" todo tu documento automáticamente con dos diccionarios, uno para lenguas, a través de los [Stanford NLP Engines ](https://nlp.stanford.edu/software/CRF-NER.html)(los motores de procesamiento del lenguaje natural para varias lenguas) y otro para lugares. Como el texto está en español, te recomendamos añadir el "Stanford NLP – ES (Español)" y dejar todos los Authority Files (Diccionarios de autoridad de lugares, también llamados diccionarios histórico-geográficos o gazetteers) porque el texto puede mencionar no solo lugares en América Latina sino también de otras latitudes:

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-03.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 3. Diccionarios disponibles para el reconocimiento automático de entidades." %} 

Luego presiona "Start NER". El algoritmo analiza el texto e intenta identificar todas las palabras que pueden ser nombres de lugares. Cuando NER reconoce una palabra como un posible nombre de lugar, también intentará hacerla coincidir automáticamente con un registro de autoridad en alguno de los diccionarios geográficos de Recogito.

Cuando Recogito termine de leer el texto, ábrelo con un doble click y verás que se han marcado automáticamente distintas palabras. En algunos casos, Recogito también marcará nombres de personas (algunos, porque son además nombres de lugares), pero el NER reconoce principalmente lugares.

Para el caso de este tutorial, no publicaremos el texto con el que trabajaremos. Recuerda que si quieres hacer público tu trabajo debes completar todos los metadatos que puedas sobre él en la sección _Document Settings_ (configuración de documento) del menú superior. Allí puedes asimismo agregar colaboradores y compartir sus anotaciones. Te sugerimos, por el momento dejarlo en la opción **Off**. 

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-04.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 4. Opciones para compartir un documento en Recogito." %} 

## Crea anotaciones

Crear anotaciones en Recogito es simple. Solo debes resaltar la palabra o las palabras en el texto que deseas anotar. Por ejemplo, un lugar que reconozcas. Esta acción mostrará una pequeña ventana emergente de anotación, que te pedirá que asignes una categoría a la anotación. Puedes elegir entre **lugar, persona y evento**.

En este caso selecciona "Place" (lugar). Recogito tratará de ayudarte a desambiguar o encontrar el significado exacto entre varias opciones a tu anotación, comparándola con registros de autoridad o identificadores únicos de uno o más diccionarios geográficos (gazetteers). Recogito actualmente utiliza [seis diccionarios geográficos históricos](https://recogito.pelagios.org/help/faq), así como uno contemporáneo y de alcance global, [Geonames](https://www.geonames.org/). En nuestro caso, el más útil probablemente sea [Indias](https://medium.com/pelagios/interim-report-on-the-latam-gazetteer-of-colonial-latin-america-713613fb592c), gazetteer de lugares de América colonial basado en el [HGIS de las Indias](https://www.hgis-indias.net/) de Werner Stangl.

Cuando resaltes el lugar y elijas "place" (lugar), vas a ver algo similar a esta imagen:

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-05.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 5. Sugerencia automática al seleccionar el nombre de un lugar." %} 

Si crees que la opción es correcta, haz click en "Confirm", y luego Recogito te preguntará si quieres confirmar solo está ocurrencia o todas las que aparecen en el texto. Si crees que tienes que cambiar la opción (como es el caso de nuestro ejemplo), haz click en **Change**. Entonces verás algo similar a esta imagen:

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-06.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 6. Opciones a partir de una búsqueda de lugar en Recogito." %} 

En la columna izquierda, Recogito te dará la posibilidad de elegir entre distintas opciones de lugares relacionadas con la marca del texto, y lo que Recogito leyó automáticamente y contrastó con sus gazetteers o diccionarios histórico-geográficos. En este caso, dado que estamos trabajando con un texto que describe los territorios de lo que luego será el Virreinato del Río de la Plata, el gazetteer más apropiado para marcar los lugares mencionados es **Indias**. Si esa opción no estuviera disponible, también podríamos usar otros diccionarios para lugares utilizados en la actualidad para mapas online, como **Geonames**. Elige la opción que te parezca correcta con un click y aparecerá una marca automática en el mapa, similar a la que se observa en la siguiente imagen: 

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-07.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 7. Selección de una de las opciones de lugar proporcionadas por Recogito." %} 

Haz click otra vez en ese último recuadro y ya habrás añadido la georreferencia a tu texto. Luego haz click en "Confirm" nuevamente y la operación de georreferenciación habrá terminado. Si quieres, puedes añadir **comentarios** (*comment*) y **etiquetas** (*tags*) en tu marca. Por ejemplo, en el **comentario** puedes añadir que no estás seguro de esa marca o que en hoy en día tiene otro nombre, etc. Las **etiquetas** son personalizadas y nos permiten agregar cualquier tipo de información o clasificación a nuestras marcas, por ejemplo, a los efectos de este tutorial, las utilizaremos (de forma un poco arbitraria) para distinguir lugares cuyos topónimos están formados por una sola palabra, como "Tucumán" o "Perú" (para los cuales utilizaremos, a los fines de este tutorial, la etiqueta "nombre simple") de aquellos cuyo nombre incluye dos o más palabras, como "San Salvador" o "Santiago del Estero" (a los que asignaremos la etiqueta "nombre compuesto"):

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-08.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 8. añadido de etiquetas a los lugares marcados en Recogito." %}

El añadido de una etiqueta te ayudará luego a ver ese lugar a través de dicha etiqueta en la vista de mapa (_Map View_). Si deseas abrir la vista de mapa, debes hacer click en el segundo ícono de la barra superior y podrás visualizar los lugares que georreferenciaste en el texto. Para diferenciar estos lugares de acuerdo a sus etiquetas debes elegir la opción **Change the colour and filter settings** que se encuentra el el extremo inferior izquierdo de la pantalla y seleccionar **Colour by Tag** (color por etiqueta).

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-09.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 9. Visualización de mapa en Recogito." %}

En el fragmento que utilizamos como ejemplo en este tutorial hay varios lugares que puedes georreferenciar, pero para continuar con el ejercicio que estamos realizando vamos a centrarnos en los siguientes, así que ya debes tenerlos marcados, etiquetados y georreferenciados correctamente para continuar con el siguiente paso:
```
Santa Fe (línea 2) 
Tucumán  (línea 3)
Santiago del Estero  (línea 4)
Córdoba  (línea 6)
Perú  (línea 10)
San Salvador  (línea 11)
```
Puedes encontrar entradas correspondientes a casi todos estos lugares en el gazetteer de Indias, con excepción de "Perú", para el cual puedes usar la entrada de Geonames. 

## Introduce relaciones

Existe otro tipo de anotación que puede realizarse en Recogito. Esto se conoce como "etiquetado relacional", mediante el cual se puede crear una conexión o relación entre dos anotaciones (de entidades) existentes. Para marcar relaciones entre entidades,  **cambia el modo de anotación de Recogito a "Relations**, y luego simplemente haz click en la primera entidad anotada, y arrastra el puntero a la segunda. Aparecerá una línea punteada que conecta las dos anotaciones, junto con un cuadro de texto: puedes completar esto para describir (o etiquetar) la relación. Para este tutorial, simplemente colocaremos una cantidad arbitraria de días para señalar la distancia entre ubicaciones, pero estas se introducen sólo a modo de ejemplo y no se relaciona directamente con la narración. La línea también tiene una flecha, que indica la "dirección" de la relación. Esta característica resulta conveniente para marcar relaciones que son jerárquicas, o como en nuestro caso, donde se pueden utilizar para indicar la dirección de un viaje. En este caso, podemos simplemente marcar las relaciones con números o con una imaginaria cantidad de días, tal como puedes ver en la imagen:

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-10.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 10. Texto anotado en Recogito." %} 

## Descarga los datos de tu texto georreferenciado

Como veremos en la siguiente parte de este tutorial, se pueden descargar los textos anotados y/o datos de anotaciones en diferentes formatos para usar en otras aplicaciones. Recogito ofrece varias opciones de descargas, a continuación nos centraremos en las que nos servirán para visualizar en un mapa el itinerario que acabamos de marcar utilizando el software Visone.

Ve a **Download Options** (opciones de descarga) en la barra superior. Descarga las anotaciones de lugares como un archivo `.csv`. En el apartado **Annotations**, haz clic en el botón `.csv` y guarda el archivo. Puedes cambiarle el nombre al archivo. Verás que en esta sección Recogito también ofrece la opción de descargar el texto marcado en diferentes formatos, como KML, que puede ser recuperado en la aplicación [Google Earth](https://www.google.com/intl/es-419/earth/about/), [XML-TEI](https://tei-c.org/), uno de los estándares de codificación de texto más utilizados en las Humanidades y Ciencias Sociales.

Si no realizaste el marcado del texto en Recogito, puedes [descargar un archivo ya marcado aquí](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/georreferenciacion-visualizacion-con-recogito-y-visone/lugares-marcados.csv).

Descarga las anotaciones de las relaciones en el botón **Edges** del apartado **Relations**. 

<div class="alert alert-warning">
Revisa bien los apartados, ya que puedes bajarte los `.csv` para ambos. Sigue la imagen que te ofrecemos a continuación, para descargar los archivos correctos
</div>

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-11.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 11. Opciones de descarga en Recogito." %}

Te recomendamos que abras el archivo `.csv` que descargaste de la sección **Annotations** y revises que todas las entradas tengan cargadas los datos de longitud y latitud, ya que si esto sucede debes cambiar la entrada de gazetteer utilizada para marcar ese lugar por otra que sí incluya la información geográfica.

# Visone

**[Visone](https://visone.ethz.ch/)** (en italiano, visón; acrónimo de  visual social networks o redes sociales visuales) es un software de descarga gratuita para la creación, transformación, exploración, análisis y representación visual de datos en red, desarrollado conjuntamente entre la Universidad de Konstanz y el Instituto de Tecnología de Karlsruhe desde 2001.

Visone permite generar y visualizar diferentes tipos de redes. Las redes son estructuras de vínculos e interacciones que nos permiten trazar relaciones de acuerdo a la proximidad o distancia existente entre determinados puntos. Una red está formada por agentes (vértices o nodos -nodes, en inglés) y las relaciones existentes entre ellos (aristas, -edges en inglés).

## Descarga e instala Visone

A diferencia de Recogito, necesitaremos instalar [Visone](http://visone.ethz.ch/html/download.html). La versión de descarga recomendada para todos los sistemas operativos es visone-2.26.jar. Sin embargo, antes de inciar la instalación de Visone, debemos asegurarnos de tener instalado en nuestra computadora Java 8 o posterior. Si no tienes Java instalado en tu computadora puedes descargarlo [aquí](https://www.java.com/en/download/). 

Una vez completada la instalación, inicia Visone. 

## Importa las relaciones desde Recogito

En la barra del menú superior, selecciona **File Open**. Navega hasta el archivo **edges** que acabas de crear en Recogito y selecciónalo. Cuando se te solicite que especifiques un formato de datos, elige **CSV files**.

En el siguiente cuadro de diálogo, asegúrate de que el **data format** (*formato de datos*) sea **link list** (*lista de enlaces*), que **cell delimiter** (*delimitador de celda*) sea una coma, y que el valor de **encoding** (*codificación*) sea UTF-8 (si no no tomará bien las tildes y las ñ). (ver imagen más abajo)

**Header** (*encabezado*)y **directed edges**  deben estar marcados, el **network type** (*tipo de red*) debe ser **one mode** (*una dirección*) y el estado de las columnas **source, target y label** (*fuente, destino y etiqueta*), debe ser **source, target, enabled** (*fuente, destino y habilitado*), respectivamente (estos probablemente se establecerán de forma predeterminada).

Luego haz clic en OK.

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-12.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 12. Opciones de importación en Visone." %}

En la ventana principal de la aplicación, ahora deberías ver una cadena de nodos con enlaces dirigidos entre ellos (es posible que debas hacer zoom para ver esto con mayor claridad; puedes hacerlo con las opciones en la parte superior izquierda de la ventana).

A continuación le agregaremos las etiquetas con las que describimos las relaciones entre los nodos (en nuestro ejemplo, la cantidad de días de viaje). Abre el **Attribute Manager** (*administrador de atributos*) con el icono de "cuadro de diálogo" en la parte superior de la ventana principal.

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-13.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 13. Ícono del Administrador de atributos en Visone." %}

Selecciona el botón **configure** (*configuración*) a la izquierda y el botón **link** (*enlace*) en la parte superior. Esto te permitirá configurar cómo se representan los enlaces. Selecciona la columna **label** (*etiqueta*). Haz clic en **apply** (*aplicar*). Esto mostrará el texto de las etiquetas que creamos en Recogito.

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-14.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 14. Importación de enlaces en Visone." %}

Hasta ahora, Visone solo ha importado información sobre los enlaces, pero no hay datos de atributos para los nodos (de hecho, Visone simplemente ha inferido la existencia de los nodos del hecho de que los enlaces existen). Los únicos atributos que tienen los nodos son sus ID únicos en la columna **source** (*fuente*).

## Importa los nodos (lugares marcados) desde Recogito

En **Attribute Manager** (ver figura 15), haz clic en la pestaña **import & export** (*importación y exportación*) a la izquierda y la pestaña **node** (*nodo*) en la parte superior. En la sección de **import** (*importar*), haz clic en el botón con puntos suspensivos (…) para elegir el archivo de nodos que exportaste desde Recogito (el que descargaste con la opción `.csv` de la sección "Annotations"). Esto abrirá un segundo cuadro de diálogo (figura 16). Asegúrate de que **header** esté seleccionado, que el atributo de red sea **source**, que el atributo de archivo sea **UUID**, que el encoding sea **UTF-8** y que el delimitador de celda sea una **coma**(,). Esto intentará hacer coincidir la identificación única de cada fila en el archivo de nodos, con la identificación única de cada nodo que ha generado Visone. Si hay coincidencia, se agregarán los atributos a ese nodo. Si creaste alguna etiqueta para las entidades en Recogito, también se mostrará aquí. Finalmente, haz clic en OK.

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-15.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 15. Importación de nodos en Visone 1." %}

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-16.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 16. Importación de nodos en Visone 2." %}

Selecciona **show and edit** (*mostrar y editar*) en el **Attribute Manager**. Ahora deberías ver una tabla con todos los atributos importados para cada nodo.

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-17.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 17. Importación de nodos en Visone 3." %}

Vuelve a seleccionar la pestaña **configure** en **Attribute Manager**. Debajo de la columna **label**, marca la casilla en la misma fila que tiene "QUOTE_TRANSCRIPTION" debajo de la columna **name**. Haz clic en **apply**. Los nodos ahora deberían mostrarse con los nombres correctos importados de Recogito.

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-18.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 18. Configuración de etiquetado de los nodos importados." %}

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-19.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 19. Visualización de los nodos y las relaciones importadas desde Recogito antes de aplicar estilos." %}

## Posiciona esta red sobre un mapa

Ahora has importado la red, pero es un poco aburrida, porque es solo una secuencia lineal. Sin embargo, al menos podemos ponerla en su contexto geográfico. En la ventana principal, haz clic en la pestaña **visualization**. Establece: la categoría (**category**) en **mapping**, el tipo (**type**) en **coordinates** y la propiedad (property) en **geographic** (Mercator)". La longitud debe asignarse al atributo "LNG" y la latitud debe asignarse al atributo "LAT" que has importado. 

Haz clic en **visualize** (es posible que debas esperar unos momentos). Ahora deberías ver los nodos y enlaces situados sobre un mapa (ver la figura en la página siguiente). Si esto no sucede:

Comprueba que los nodos se han redistribuido en el panel de descripción general en la parte superior izquierda. Intenta hacer clic en el área correspondiente. Puede ser que solo necesites desplazarte y hacer zoom al nivel correcto.

Si los nodos todavía están en línea recta, podría haber un problema con tus datos. Abre el **Attribute Administrator** y selecciona **show & edit** y la pestaña  **node**. Desplázate por la tabla para asegurarte de que cada uno de tus nodos tenga coordenadas.

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-20.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 20. Visualización de itinerario en Visone." %}

Si bien este mapeo le ha dado al conjunto una ubicación basada en las coordenadas, la posición de los nodos también se puede ajustar manualmente, simplemente haz click en el nodo que quieres mover y arrástralo hasta la ubicación deseada.

Finalmente, si deseas mejorar la presentación gráfica de esta visualización, puedes modificar el aspecto de los nodos y de sus etiquetas. Para esto, debes hacer click en la pestaña "nodes" del menú superior, elegir "select all" y luego "properties…". En la pestaña "general" podrás modificar el aspecto de los nodos (por ejemplo, puedes cambiarle forma, color y tamaño), mientras que en la pestaña "label" puedes cambiar el formato del texto que acompaña a cada nodo (en nuestro ejemplo, el nombre de los lugares que forman el itinerario). 

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-21.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 21. Opciones de visualización de nodos en Visone." %}

## Guarda tu trabajo y exporta la visualización

Guarda tu archivo de red como un archivo graphML. Este archivo te permitirá volver a abrir tu red en Visone cuando desees modificarla o seguir trabajando en ella.

Finalmente, exporta tu red final como un archivo de imagen usando **File Export** Luego, en **types of file** (archivos de tipo), selecciona el tipo de archivo de salida que deseas generar (Visone permite exportar visualizaciones en las extensiones más utilizadas para archivos de imagen, como jpg y bpm) y haz clic en **save**.

{% include figure.html filename="es-or-georreferenciacion-visualizacion-con-recogito-y-visone-22.jpg" alt="DESCRIPCIÓN VISUAL DE LA IMAGEN" caption="Figura 22. Resultado final de la exportación del itinerario desde Visone." %}

# Conclusión

A lo largo de este tutorial aprendimos a: 
- Georreferenciar los lugares mencionados en un texto y relacionarlos entre sí para formar un itinerario utilizando Recogito.
- Exportar la información geográfica añadida por Recogito para seguir trabajándola con otras herramientas. 
- Utilizar el software Visone para procesar los datos exportados desde Recogito y elaborar una visualización en el mapa del itinerario que creamos. 
- Exportar la visualización de nuestro itinerario como un archivo de imagen.

Puedes encontrar un ejemplo del uso de este flujo de trabajo aplicado a la visualización del espacio geográfico en un trabajo de investigación sobre el *Libro de Alexandre* en: Gabriel Calarco, [La visualización del espacio geográfico en las écfrasis del Libro de Alexandre con Recogito y Visone](https://revistas.unlp.edu.ar/publicaahd/article/view/14361).

Si deseas ver más ejemplos del uso de Recogito para el marcado de información geográfica, te sugerimos visitar las ediciones de [*La Argentina Manuscrita*, de Ruy Díaz de Guzmán](https://hdlab.space/La-Argentina-Manuscrita/) y [*Relación de un viaje al Río de la Plata*, de Acarette du Biscay](https://hdlab.space/Relacion-de-un-viaje/) del [Laboratorio de Humanidades Digitales del CONICET](https://hdlab.space/). en particular, te invitamos a explorar la [sección de recursos](https://hdlab.space/argentina-y-conquista-del-rio-de-la-plata/recursos/) en donde encontrarás enlaces a los textos marcados con Recogito.

También te recomendamos visitar el sitio de [Pelagios Network](https://pelagios.org/), en donde encontrarás más información sobre las herramientas y actividades que ofrece esta red.

# Otros tutoriales para trabajar con Recogito y Visone

Hay muchos tutoriales adicionales disponibles para Recogito y Visone. Te recomendamos los siguientes:

- El sitio oficial de Visone tiene [varios tutoriales en inglés](https://visone.info/wiki/index.php/Tutorials#Basic_tutorials) sobre las diferentes aplicaciones de esta herramienta. 

- El tutorial de Recogito de Gimena del Rio y Valeria Vitale, [Recogito-in-a-Box: From Annotation to Digital Edition](https://ri.conicet.gov.ar/handle/11336/134134) (en inglés).

## Nota 

La segunda parte de este tutorial se basa en el tutorial para Visone creado por Leif Isaksen y traducido y adaptado al español y a textos en español por Gabriel Calarco y Gimena del Rio Riande.
