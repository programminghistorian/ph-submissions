---
title: "Crear nuevas capas vectoriales en QGIS 2.0"
slug: capas-vectoriales-qgis
original: vector-layers-qgis
layout: lesson
collection: lessons
date: 2013-12-13
translation_date: YYYY-MM-DD
authors:
- Jim Clifford
- Josh MacFadyen
- Daniel Macfarlane
reviewers:
- Finn Arne Jørgensen
- Peter Webster
- Abby Schreiber
editors:
- Adam Crymble
translator:
- Eduardo Godoy Yáñez
translation-editor:
- Forename Surname
translation-reviewer:
- Forename Surname
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/710
difficulty: 2
activity: presenting
topics: [mapping, data-visualization]
abstract: In this lesson you will learn how to create vector layers based on scanned historical maps.
avatar_alt: Map of city streets
doi: XX.XXXXX/phen0000
---

{% include toc.html %}


## Objetivos de la lección

En esta lección aprenderás cómo crear capas vectoriales a partir de mapas históricos digitalizados. En el curso [Intro to Google Maps and Google Earth](https://programminghistorian.org/en/lessons/googlemaps-googleearth) usted utilizó capas vectoriales y creó atributos en Google Earth. En esta lección haremos lo mismo, aunque a un nivel más avanzado, utilizando el software QGIS.

Las capas vectoriales son, junto con las capas ráster, uno de los dos tipos básicos de estructuras de datos que almacenan data. Las capas vectoriales usan las tres características básicas de los SIG -líneas, puntos y polígonos- para representar las características del mundo real en formato digital. Los puntos pueden utilizarse para representar ubicaciones específicas como pueblos, edificios, eventos, etc. (la escala de su mapa determinará lo que usted represente como un punto -en el mapa de una provincia, un pueblo sería un punto, mientras que en el mapa de un pueblo, un edificio podría ser un punto-). Las líneas pueden representar efectivamente características como caminos, canales, líneas de ferrocarriles, entre otras. Los polígonos (formas efectivamente cerradas con más de unos pocos lados) son utilizados para representar objetos más complejos como los bordes de un lago, un país, o una circunscripción electoral (nuevamente, la escala afectará su elección -grandes edificios en el plano de una ciudad pueden ser mejor representados como polígonos que como puntos-).

En esta lección usted creará archivos shape (que son un tipo de datos vectoriales) para representar el desarrollo histórico de comunidades y caminos en la Prince Edward Island. Cada archivo shape puede crearse como uno de los tres tipos de elementos: líneas, puntos y polígonos (aunque estos elementos no se pueden combinar en un mismo archivo shape). Cada elemento que usted cree en un archivo shape tiene un conjunto correspondiente de datos que son almacenados en una tabla de atributos. Usted creará elementos y aprenderá cómo modificarlos, lo que incluye no sólo la creación visual de los tres tipos de elementos, sino que también la modificación de sus atributos. Para hacerlo, utilizaremos los documentos de la lección [Installing QGIS 2.0 and Adding Layers](https://programminghistorian.org/en/lessons/qgis-layers) relacionados a la isla Prince Edward.

## Comenzando

Comenzaremos descargando el [*PEI_Holland Map*](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/vector-layers-qgis/PEI_HollandMap1798_compLZW.tif) a la carpeta del proyecto:

Abra el archivo que guardó al final de [Installing QGIS 2.0 and Adding Layers](https://programminghistorian.org/lessons/qgis-layers). Debería tener las siguientes capas en su Ventana de Capas:

 - *PEI_placenames*
 - *PEI_highway*
 - *PEI HYDRONETWORK*
 - *1935 inventory_region*
 - *coastline_polygon*
 - *PEI-CumminsMap1927*

Deseleccione todas estas capas excepto por las capas *PEI_placenames*, *coastline_polygon* y *PEI_CumminsMap1927*

{% include figure.html filename="en-or-vector-layers-qgis-01.png" alt="Visual description of figure image" caption="Figura 1. Clic para ver la imagen en tamaño completo." %}


Ahora, vamos a añadir un según mapa histórico como capa ráster.


{% include figure.html filename="en-or-vector-layers-qgis-02.png" alt="Visual description of figure image" caption="Figura 2. Caption text to display" %}


 - En Capa en la barra de herramientas seleccione “Add Raster” (alternativamente, también puede seleccionar el mismo ícono que usted ve junto a la opción “Add Raster Layer” en la barra de herramientas).
 - Busque el archivo que ha descargado bajo el título “*PEI_HollandMap1798*”.
 - En una ventana emergente se le pedirá que el sistema de coordenadas de esta capa. En la caja “filtrar” busque “2291”, entonces en la caja de abajo seleccione “*NAD83(CSR98) / Prince Edward Isl. Stereographic*”.
 - Si no le solicita definir el sistema de coordenadas de la capa, deberá definirlo en la configuración. Haga clic en Configuración y luego en Opciones. Cliquee la sección SRC en la parte de la derecha del menú y seleccione la opción “preguntar por SRC” desde las opciones bajo el título “cuando se crea una capa o cuando se carga una capa que no tiene SRC”. Haga clic en “Aceptar”. Quite el “Holland Map” (clic derecho en él y seleccione la opción quitar) y pruebe añadiéndolo nuevamente. Esta vez le debería pedir que indique el SRC y usted podrá seleccionar la opción “NAD83” (ver arriba).


{% include figure.html filename="en-or-vector-layers-qgis-03.png" alt="Visual description of figure image" caption="Figura 3. Caption text to display" %}

En los pasos previos usted seleccionó y deseleccionó capas en la Pestaña de Capas al marcar y desmarcar los recuadros junto a ella. Esas capas están organizadas en orden de visibilidad descendente, es decir, la capa de hasta arriba en la capa superior en su interfaz de visualización (siempre que esté seleccionada). Usted puede mover las capas hacia la parte de arriba o de abajo en la pestaña de capas para cambiar el orden en que ellas se verán en su ventana de visualización. La capa ráster *coastline_polygon* no será en este momento porque se encuentra debajo de las capas *PEI_Holland1789* y *PEI_Cummins1927*. En general es mejor mantener las capas vectoriales arriba de las capas ráster.

Desmarque la capa *PEI_Cummins1927* para que la única capa que aparezca sea *PEI_HollandMap1789*. Note que el aparece torcido en la pantalla. Esto es porque ya ha sido georreferenciado por los autores de la lección para que coincida con las capas vectoriales del GIS. Obtenga más información georreferenciación en [QGIS 2.0](https://programminghistorian.org/en/lessons/georeferencing-qgis)


{% include figure.html filename="en-or-vector-layers-qgis-04.png" alt="Visual description of figure image" caption="Figura 4. Caption text to display" %}

Ahora vamos a crear un archivo _.shape_ de puntos, que es una capa vectorial. Cliquee en “Capa”, luego en “Nueva”, y finalmente en “Nueva Capa de Archivo Shape”.

 - Alternativamente usted puede seleccionar el ícono de “Nueva Capa de Archivo Shape” en la barra de herramientas en la parte superior de la ventana GIS.


{% include figure.html filename="en-or-vector-layers-qgis-05.png" alt="Visual description of figure image" caption="Figura 5. Caption text to display" %}


Después de seleccionar “nueva capa de archivo shape”, aparecerá una ventana llamada “Nueva Capa Vectorial”.

 - En la categoría “Tipo”, usted seleccionará la opción “Puntos”. Haga clic en el botón “especificar SRC” y seleccione *NAD83(SRCS98) / Prince Edward Isl. Stereographic (EPSG: 2291)*, luego cliquee en “Aceptar” (más información en [cómo entender y seleccionar la zona UTM](https://perma.cc/TA7Z-V3SZ).


{% include figure.html filename="en-or-vector-layers-qgis-06.png" alt="Visual description of figure image" caption="Figura 6. Caption text to display" %}


De vuelta en la ventana “Nueva Capa Vectorial”, vamos a hacer algunos atributos. Para crear el primer atributo:

 - Bajo la sección Nuevo Atributo, en el campo en blanco junto a Nombre, escriba “Nombre_Asentmiento” (note que cuando trabaja en bases de datos usted no puede usar espacio vacíos en los nombre, lo convencional es usar guiones bajos en su lugar).
 - Haga clic en Añadir atributo a la lista.

Ahora vamos a crear un segundo atributo.

 - Bajo la sección Nuevo atributo, en el campo en blanco junto a Nombre, escriba “Año”
 - Esta vez vamos a cambiar el “Tipo” a “Número Entero”
 - Haga clic en Añadir atributos a la lista

Para el tercer Atributo:

 - Bajo la sección Nuevo atributo, en el campo en blanco junto a Nombre, escriba “Año_Fin” (los SIG no siempre son óptimos para lidiar con cambio a lo largo del tiempo, de modo que en algunos casos es fundamental tener campos para identificar aproximadamente cuando algo dejó de existir).
 - Cambie el “Tipo” a “Número Entero”
 - Haga clic en Añadir atributo a la lista


{% include figure.html filename="en-or-vector-layers-qgis-07.png" alt="Visual description of figure image" caption="Figura 7. Caption text to display" %}


 - Cuando complete estos tres pasos, finalice creando este archivo shape haciendo clic en “Aceptar” en la parte de abajo a la derecha de la ventana Nueva Capa Vectorial. Aparecerá una ventana emergente, nómbrela “Asentamientos” and guárdela con sus otros archivos GIS en la misma carpeta de trabajo.

Note que la capa llamada “Asentamientos” ahora aparece en su ventana de capas. Reubíquela arriba de las capas ráster.


{% include figure.html filename="en-or-vector-layers-qgis-08.png" alt="Visual description of figure image" caption="Figura 8. Caption text to display" %}


Desmarque todas las capas excepto “asentamientos”. Usted notará que ahora interfaz de visualización está en blanco ya que no hemos creado ningún dato. Ahora vamos a crear datos nuevos a partir del (insertar enlace) y del (insertar enlace) para mostrar el aumento de los asentamiento entre fines del siglo XVIII e inicios del siglo XX.

 - Vamos a empezar con el mapa más reciente y generalmente también más preciso. Seleccione (es decir, marque los recuadros ubicados a un lado) de *coastline_polygon* y *PEI_CumminsMap1927*.
 - En su interfaz de visualización, haga un acercamiento en Charlottetown (pista: Charlottetown esta cerca de la mitad de la isla en la parte sur, en la confluencia de los tres ríos)
 - Seleccione la capa de asentamientos en la ventana de Capas
 - En la barra de menú, seleccione en “Conmutar Edición”.


{% include figure.html filename="en-or-vector-layers-qgis-09.png" alt="Visual description of figure image" caption="Figura 9. Caption text to display" %}

 - Luego de seleccionar “Conmutar edición”, los botones de edición estarán disponibles a la derecha en la barra de menú. Seleccione el botón “Anadir Punto” con el ícono de tres puntos.

{% include figure.html filename="en-or-vector-layers-qgis-10.png" alt="Visual description of figure image" caption="Figura 10. Caption text to display" %}


 - Su cursor ahora aparece en forma de una mira circular. Apunte la mira en Charlottetown (si no sabe la geografía de PEI, puede hacer trampa añadiendo la capa *PEI_placenames*), manteniéndolo dentro de la línea costera actual, y haga clic (la digitalización es siempre un compromiso entre precisión y funcionalidad, dependiendo de la calidad del mapa original y de la digitalización. Para la mayoría de las aplicación históricas la precisión extrema no es necesaria).
 - Aparecerá una ventana de atributos. Deje el campo “id” en blanco (al momento de escribir, QGIS crea dos capos de “id” y este es innecesario). En el campo “asentamiento” escriba “Charlottetown”. En el campo “año” escriba “1764”. Haga clic en aceptar.

Vamos a repetir los pasos que usamos para Charlottetown y los aplicaremos a Montague, Summuerside y Cavendish (de nuevo, puede encontrar esas localizaciones añadiendo la capa *PEI_placenames*). Encuentre Montague en el mapa, seleccione el botón de función de tres puntos y haga clic en Montague en el mapa. Cuando la ventana de atributos aparezca introduzca “Montague” y “1732” en los campos respectivos. Repita estos pasos para Summerside (1876) y para Cavendish (1790).


{% include figure.html filename="en-or-vector-layers-qgis-11.png" alt="Visual description of figure image" caption="Figura 11. Caption text to display" %}


En la ventana de Capas, seleccione la capa *PEI_Cummins1927* y seleccione la capa *PEI_HollandMap1798*. Ahora vamos a identificar dos asentamientos (Princetown y Havre-St-Pierre), que ya no existen.

 - Para identificar Princetown mire cerca de Richmond Bay y de Cape Aylebsury (en la costa norte al oeste de Cavendish), aquí encontrará Princetown (sombreado), cerca del límite entre el amarillo y el azul.
 - Si usted mira en la [entrada de Wikipedia](https://en.wikipedia.org/wiki/Prince_Royalty,_Prince_Edward_Island) de la ciudad, notará que debido a la poca profundidad de su puerto Princetown no se transformó en un asentamiento importante. En 1947 fue renombrado y luego degradado a una aldea. Por esta razón incluiremos “1947” como la fecha fin de este asentamiento.
-  Con la mira, haga clic en Princetown. En la Tabla de atributos que aparecerá escriba “Princetown” en el campo Asentamiento, “1764” en el campo Año y “1947” en el campo Año_Fin. Haga clic en Aceptar.


{% include figure.html filename="en-or-vector-layers-qgis-12.png" alt="Visual description of figure image" caption="Figura 12. Caption text to display" %}


 - Haga clic en el ícono de Guardar Edición en la barra de menú (se ubica entre los botones “Conmutar edición” y “Añadir Punto”).
 - Haga doble clic sobre la capa de asentamientos en la ventana de capas, elija la pestaña Etiquetas en la parte superior de la ventana subsiguiente. Cliquee en el recuadro junto a la opción de mostrar etiquetas. En el campo que contiene la etiqueta, seleccione Año. Si es necesario, cambie el tamaño de fuente a 18.0, cambie la ubicación a Arriba a la izquierda y, a continuación, haga clic en Aceptar.

En la costa norte del Lote 39 (Lot 39) entre Britain’s Pond y St. Peters Bay, ahora vamos a colocar un punto para la locación de un pueblo perdido hace tiempo, Havre-St-Pierre.

 - Havre-St-Pierre fue el primer asentamiento acadiano de la isla, pero está deshabitado desde la deportación de los acadianos en 1758.
 - Con la mira circular del cursor haga clic en Havre-St-Pierre. En la Tabla de Atributos que aparecerá, escriba Havre-St-Pierre en el campo de asentamiento, y añada 1720 en el campo de año, y escriba 1758 en el campo Año_Fin. Haga clic en aceptar.


{% include figure.html filename="en-or-vector-layers-qgis-13.png" alt="Visual description of figure image" caption="Figura 13. Caption text to display" %}


Ahora, vamos a crear otra capa vectorial. Esta capa será un vector de línea. Haga clic en Capa, luego en Nueva, Luego en Nueva Capa de Archivo Shape. La ventana de la Nueva Capa Vectorial aparecerá (en el Tipo categoría de hasta arriba, seleccione “Línea”).

 - Haga clic en el botón para especificar el SRC, y seleccione *NAD83(SRCS98) /Prince Edward Isl. Stereographic (EPSG: 2291)*, y luego cliquee en “Aceptar”.
 - Bajo la sección “Nuevo Atributo”, en el campo en blanco junto a Nombre, escriba “Nombre_Camino”.
 - Haga clic en Añadir atributo a la lista.

Cree un segundo atributo

 - Bajo la sección “Nuevo Atributo”, en el campo en blanco junto a Nombre, escriba “Año”
 - Cambie el Tipo a Número Entero
 - Haga clic en añadir atributo a la lista
 - Para finalizar la creación de este archivo shape, cliquee en el botón “Aceptar” al fondo a la derecha de la ventana “Nueva Capa Vectorial”. Aparecerá una ventana emergente para guardar el archivo, nómbrelo “Caminos” y guárdelos con sus otros archivos SIG.

Ahora vamos a trazar los caminos desde el mapa de 1798 para que podamos compararlos con los caminos modernos. Asegúrese de tener marcadas las capas *PEI_Holland1798* Y Asentamientos en la Ventana de Capas. Seleccione la capa de carreteras en la Ventana de Capas, seleccione “Conmutar Edición” en la barra superior, y luego seleccione Añadir Línea.


{% include figure.html filename="en-or-vector-layers-qgis-14.png" alt="Visual description of figure image" caption="Figura 14. Caption text to display" %}


 - Primero, trace el camino desde Charlottetown a Princetown. Haga clic en Charlottetown y luego haga clic repetidamente en punto a lo largo del camino hasta Princetown y usted verá la línea que está creando. Repita hasta llegar a Princetown, entonces haga clic derecho. En la ventana de atributos de caminos resultante, en el campo Nombre escriba “Princetown” y en el campo Año escriba 1798. Haga clic en Aceptar.


{% include figure.html filename="en-or-vector-layers-qgis-15.png" alt="Visual description of figure image" caption="Figura 15. Caption text to display" %}


 - Repita este paso para 3 o 4 caminos más del *PEI_HollandMap1798*.
 - Haga clic en Guardar Edición y luego en Conmutar Edición para quitar la función.

Deseleccione la capa *PEI_HollandMap1798* en la Ventana de Capas y seleccione *PEI_Highway map*. Compare los caminos representados en el mapa *PEI_Highway* (las líneas rojas punteadas) con los caminos trazados por usted.


{% include figure.html filename="en-or-vector-layers-qgis-16.png" alt="Visual description of figure image" caption="Figura 16. Caption text to display" %}


 - Podemos ver que algunos de estos caminos se corresponden de manera muy cercana a los caminos actuales, mientras otros no se corresponden en absoluto. Se necesitaría una investigación histórica más profunda para determinar si esto se debe simplemente a que el mapa de *Holland* no cartografió suficientemente los caminos en aquel momento, o si los caminos han cambiado.

Ahora, vamos a crear el tercer tipo de capa vectorial: un polígono vectorial. Haga clic en “Capa”, luego en “Nueva” y finalmente en “Nueva Capa de Archivo Shape”. La nueva capa vectorial aparecerá, en la categoría de Tipo de arriba seleccione “Polígono”.

 - Haga clic en el para especificar el SRC y seleccione *NAD83(SRCS98) /Prince Edward Isl. Stereographic (EPSG:2291)*, y luego haga clic en “Aceptar”.
 - Debajo de la sección de “Nuevo Atributo”, en el campo en blanco junto a Nombre, escriba “Nombre_Lote” en el campo junto a Año.
 - Haga clic para añadir el atributo a la lista.

Cree un segundo atributo

 - Bajo la sección de “Nuevo Atributo”, en el campo en blanco junto a nombre, escriba Año
 - Cambie el Tipo a “Número Entero”.
 - Haga clic para añadir el atributo a la lista.


{% include figure.html filename="en-or-vector-layers-qgis-17.png" alt="Visual description of figure image" caption="Figura 17. Caption text to display" %}


Comience creando un polígono para el Lote 66, el que es el único lote rectangular de la isla.

 - Haga clic en “Conmutar Edición” en la barra en la parte superior, y luego cliquee en “Añadir Polígono”.
 - Haga clic en cada una de las cuatro esquinas del Lote 66 y verá su polígono creado.
 - Haga clic derecho en la última esquina y aparecerá una ventana de Atributos. Escriba “66” en la sección Nombre_Lote y “1764” (ese año los lotes fueron catastrados) en la sección “Año”.


{% include figure.html filename="en-or-vector-layers-qgis-18.png" alt="Visual description of figure image" caption="Figura 18. Caption text to display" %}


Ahora, vamos a trazar el lote 38, el que se encuentra justo al oeste de Havre-St-Pierre. Asegúrese de que la capa de PEI_HollandMap1798 está marcada en la ventana de capas.

Haga clic en Conmutar Edición en la barra de herramientas superior, y a continuación cliquee en Añadir Polígono.

Trace una línea sobre el contorno del Lote 38, el cual es más difícil debido a su línea costera, con la mayor precisión posible. Para enseñarle la función de autoensamblaje (Snap) queremos que siga el trazado de la costa moderna (el autoensamblaje es una operación automática de edición que modifica el trazado que usted ha realizado para hacerlo coincidir o se alinee de manera exacta con las coordenadas y la forma de otro trazado cercano).

 - Seleccione Configuración, luego vaya a Opciones de Autoensamblaje


{% include figure.html filename="en-or-vector-layers-qgis-19.png" alt="Visual description of figure image" caption="Figura 19. Caption text to display" %}


 - Una ventana de opciones de autoensamblaje se abrirá: haga clic en el recuadro junto a *coastline_polygon*. En la columna para las categorías de Modo seleccione “del vértice al segmento”, deje la Tolerancia en 10.0 y la Unidad en pixeles. Finalice haciendo clic en “Aceptar”.


{% include figure.html filename="en-or-vector-layers-qgis-20.png" alt="Visual description of figure image" caption="Figura 20. Caption text to display" %}


Asegúrese de que la capa de lotes esté marcada en la Ventana de Capas, luego seleccione Añadir Polígono desde la barra de herramientas

 - Con su cursor haga clic en las dos esquinas inferiores de su polígono de la misma forma que lo hizo antes con el Lote 38. Notará que en la línea costera tiene una serie de líneas que trazar en torno a Savage Harbour. Aquí es cuando la función de autoensamblaje se vuelve útil. A medida que trabaje para trazar la línea costera moderna usted mejorará significativamente su precisión al colocar sus clics directamente sobre la línea existente. A más clics usted realice mayor será su precisión, pero tenga en cuenta que para muchos fines GIS, tener una extrema precisión a veces produce rendimientos menos eficientes.


{% include figure.html filename="en-or-vector-layers-qgis-21.png" alt="Visual description of figure image" caption="Figura 21. Caption text to display" %}


Cuando haya terminado de trazar el polígono, seleccione y deseleccione las diferentes capas que usted ha creado, para comparar y observar qué relaciones puede deducir.

En Google Earth había limitaciones en los tipos de características, atributos y datos proporcionados por Google, y Google Earth hacía mucho del trabajo por usted. Eso está bien cuando usted está aprendiendo o quiere crear mapas rápidamente. La ventaja de usar el software QGIS para crear nuevas capas vectoriales es que usted tiene mucha libertad y control el tipo de información que puede usar así como en las características y atributos que puede crear. A su vez, esto significa que usted puede crear mapas personalizados que vayan mucho más allá de lo que puede lograr en _Google Earth_ o en _Google Maps Engine Lite_. Usted ha podido ver esto de primera mano con las capas vectoriales de puntos, líneas y polígonos que aprendió a crear en esta lección. Si, por ejemplo, usted tuviera datos de registro sobre salud pública del Siglo 18, podría crear una nueva capa con las que ya ha creado para mostrar brotes de fiebre tifoidea y ver si hay correlación entre los principales caminos y los asentamientos. Además, el software SIG le permite no solo presentar y representar datos espaciales de manera mucho más sofisticada, sino que también analizar y crear nuevos datos de manera que no sería posible de otro modo.

Ha aprendido cómo crear capas vectoriales. Asegúrese de guardar su trabajo!

Esta lección es parte de [curso del Historiador Geoespacial](https://geospatialhistorian.wordpress.com/)

 [PEI_Holland map]: https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/vector-layers-qgis/PEI_HollandMap1798_compLZW.tif
