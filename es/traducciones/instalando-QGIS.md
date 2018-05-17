---
title: Instalando QGIS 2.0 y añadiendo capas
authors:
- Jim Clifford
- Josh MacFadyen
- Daniel Macfarlane
date: 2013-12-13
translation_date:
reviewers:
- Finn Arne Jørgensen
- Sarah Simpkin
editors:
- Adam Crymble
translator:
- Maria José Afanador-Llach
translator-editor:
-
translation-reviewer:
-
-
layout: default
original: qgis-layers
redirect_from: es/lessons/qgis-layers
next: vector-layers-qgis
prev: googlemaps-googleearth
difficulty: 1

---

Objetivos de las lección
------------

En esta lección vas a instalar el software QGIS software, descargar archivos geoespaciales como *shapefiles* y GeoTIFFs, y crear un mapa a partir de un número de capas vectoriales y ráster. Quantum o QGIS es una alternativa de código abierto al líder de la industria ArcGIS de ESRI. QGIS es una multiplataforma, lo que significa que corre en Windows, Mac y Linux y que tiene muchas de las funciones que son más comunmente utilizadas por los historiadores. ArcGIS es demasiado costoso y solamente corre en Windows (aunque se puede comprar software para que pueda correr en Mac). Sin embargo, muchas universidades tienen licencias, lo que significa que estudiantes y empleados pueden tener acceso gratuito al software (intenta contactar a tu bibliotecario de mapas, a los servicios de computación o a los departamentos de geografía).
QGIS es ideal para quienes no tiene acceso a una copia gratuira de Arc y también es una buena opción para aprender las habilidades básicas de GIS y decidir si quieres instalar una copia de ArcGIS en tu máquina. Adicionalmente, cualquier trabajo que hagas en QGIS se puede explorar a ArcGIS más adelante si decides actualizarte. Los autores suelen utilizar ambos y están contentos con correr QGIS en Mac o Linux para las tareas más básicas, pero utilizan ArcGis para trabajos más avanzados. En muchos casos no es una cuestión de falta de funciones sino asuntos de estabilidad lo que nos hace volver a ArcGIS. Para quienes están aprendiendo Python con The Programming Historian, estarán contentos de saber que tanto QGIS como ArcGIS utilizan Python como su lenguaje de programación principal.

Instalando QGIS
---------------

Navega hacia la [página de descargas de QGIS](). El procedimiento será un poco distinto dependiendo de tu sistema operativo. Haz clic en el sistema operativo apropiado. Sigue las siguientes instrucciones.

#### Instrucciones para Mac

-   Para la mayoría de la gente lo mejor sería escoger el *Master release* (el que tiene un único paquete de instalación). Necesitarás instalar otros paquetes de programas antes de instalar QGIS. En "Descarga para Mac OS X", haz clic en el enlace ([KyngChaos Qgis download page][]) y descarga los siguientes dos archivos (mira la captura de pantalla abajo): 1) El paquete de GDAL framework completo 1.11 (debajo del titulo *Requirements*) e instálalo como cualquier programa de Mac. 2) QGIS 2.0.1 (debajo del título *Download*) para el sistema operativo de Mac respectivo (este funciona con versiones desde Lion en adelante). Luego ve al menu de software y haz clic en descargar archivo. Descargalo en la carpeta de "GDAL complete".

{% include figure.html filename="qgis1.png" caption="Figura 1: Haz clic para ver la imagen completa" %}

-   una vez instalados estos paquetes de programas, descarga e instala QGIS.
-   como con cualquier aplicación para Mac que estás utilizando por primera vez, tendrás que buscarla en la carpeta de Aplicaciones.

#### Instrucciones para Windows

-   en *Standalone Installer*, haz clic en el enlace para descargar QGIS

{% include figure.html filename="qgis2.jpg" caption="Figura 2" %}

-   haz doble clic en el archivo `.exe` para ejecutarlo

QGIS es muy simple de instalar en la mayoría de las versiones de Linux. Sigue las instrucciones en la página de descargas.

### Los datos de la Isla del Príncipe Eduardo

Utilizaremos algunos datos del gobierno para la provincia Canadience "Isla del Príncipe Eduardo" (IPE). La IPE es un buen ejemplo por que tiene una gran cantidad de datos gratuitos en línea y por que es la provincia más pequeña de Canadá, lo cual hace que la descarga de datos sea rápida. Descarga las *shapefiles* de la IPE:

-   Entra a los siguientes enlaces en tu navegador, lee y acepta la licencia de uso (*license agreement*) y descarga lo siguiente (te pedirán introducir tu nombre y correo electrónico para cada descarga). Nosotros creamos las últimas dos *shapefiles* así que deben poder descargarse directamente:

1.  <http://www.gov.pe.ca/gis/license_agreement.php3?name=coastline&file_format=SHP>
2.  <http://www.gov.pe.ca/gis/license_agreement.php3?name=lot_town&file_format=SHP>
3.  <http://www.gov.pe.ca/gis/license_agreement.php3?name=hydronetwork&file_format=SHP>
4.  <http://www.gov.pe.ca/gis/license_agreement.php3?name=forest_35&file_format=SHP>
5.  <http://www.gov.pe.ca/gis/license_agreement.php3?name=nat_parks&file_format=SHP>
6.  [PEI Highways][]
7.  [PEI Places][]

-   Una vez los siete archivos hayan sido descargados, muévelos a una carpeta y descomprime los archivos que estan en formato .zip. Revisa el contenido de las carpetas. Notarás cuatro archivos con el mismo nombre, pero diferent tipo. Al navegar estas carpetas desde el software de GIS notarás que solo necesitas hacer clic en el archivo .shp y que los otros tres formatos sirven para apoyar este archivo. Cuando muevas los archivos en el computador, es importante mantener los 4 archivos juntos. Es por eso que los "shapefiles" son compartidos en zip. Recuerda en que carpeta guardaste las versiones descromprimidas de los shapefiles, ya que deberás encontrarlos desde QCIS muy pronto.

Empezando tu proyecto GCIS
-------------------------

Abre QGIS. Lo primero que debes hacer es confirgurar el [Sistema de Referencia de Coordenadas][] (CRS) correctamente. El CRS es la proyeccion en el mapa y las proyecciones son las diferentes maneras de representar el mundo real en mapas de dos dimensiones. Por defecto, el programa esta configurado en WGS84 (el cual se ha vuelto más comun en tanto es compatible con software como Google Earth), pero ya que la mayoría de nuestros datos fueron creados por el gobierno canadiense, recomendamos utilizar NAD83(North American Datum, 1983). Para más información sobre el NAD83 y los datos del Gobierno Federal mira la [Página del NRCan][]. PEI tiene su propio sistema de referencia NAD 83, el cual hace uso de una [Doble proyección Estereografica][]. Uno de los aspectos más complicados de GIS para los principiantes es manejar las diferentes capas de informacion y asegurarse de que funcionen correctamente. Sin embargo, si configuras el software correctamente, debería convertir el CRS y permitirte trabajar con datos importados de fuentes diversas. *Selecciona Propiedades del proyecto (Project Properties)*

-   Mac: Project–\>Project Properties

{% include figure.html filename="qgis3.png" caption="Figure 3" %}

-   Windows: Settings-\> Project Properties

{% include figure.html filename="qgis4.png" caption="Figure 4" %}

-  En el panel de la izquierda selecciona CRS (el segundo de arriba hacia abajo)
-  Haz clic en permitir transformaciones CRS sobre la marcha (Enable 'on the fly' CRS transformatio)

-   En la casilla de filtro (Filter) escribe '2291′ – esto te guiará al mejor sistema de referencia de coordenadas para la Isla Principe Eduardo.
-   Bajo la casilla Sistemas de Referencia de Coordenadas del mundo (Coordinate reference systems of the world) selecciona 'NAD83(CSRS98) / Prince Edward Isl. (Stereographic)' y haz clic en OK.

{% include figure.html filename="qgis5.png" caption="Figure 5" %}

-   La proyección en la esquina inferior derecha de la ventana ha cambiado. Al lado podrás ver la localización geográfica del puntero del mouse en metros.
-   Bajo el menu Proyecto, selleciona Guardar Proyecto (es apropriado guardar después de cada paso)

Ahora estas preparado para desarrollar este tutorial, pero es posible que tengas dudas con respeto a que CRS utilizar en tus proyectos personales. WGS84 puede funcionar a corto plazo, especialmente si trabajas con escalas amplias, pero es dificil de manejar con precision en mapas locales. Una sugerencia sería buscar que CRS o proyección es utilizada en mapas de esa región. Si usas un mapa escaneado como base sería buena idea utilizar la misma proyección. También puedes buscar en internet cual es el CRS más comunmente utilizado en esa región. Una de las mejores opciones para aquellos que trabajan con proyectos Norteamericanos, sería identificar la NAD83 de la región. Otros recursos para elegir la CRS de tu proyecto pueden ser encontrados en: [Tutorial: Trabajando con proyecciones en QGIS][]

### Construyendo un Mapa Base

Ahora que tu computador tiene las direcciones correctas, es hora de añadir informacion que tenga sentido para los seres humanos. Tu proyecto debería empezar con un mapa base, o una selección de información geo-espacial que le permita a tus lectores reconocer características del mundo real en el mapa. En la mayoría de los casos esto se logra con varios 'layers' de información, rasterizada y vectorial, los cuales pueden ser acomodados, coloreados y etiquetados de manera que tengan sentido para los lectores y para los objetivos del projecto. Una caracteristica relativamente nueva en muchos programas de GIS es la disponibilidad de mapas base pre-diseñados. Sin embargo, esta tecnología aún está en proceso para plataformas de código abierto como QCIS, asi que este tutorial presentará el proceso de crear un mapa base propio al añadir layers rasterizados y vectoriales. Para quieren quisieran añadir mapas base pre-diseñados a QCIS, puedes intentar instalar el Plugin 'OpenLayers' bajo Plugins-\>Manage e Instalar Plugins. Selecciona "Conseguir Mas" a la izquierda. Haz click en OpenLayers y luego en Instalar plugin. Haz click en Ok y luego en cerrar. Una vez instaltado, encontrarás OpenLayers en la menú de Plugins. Intenta instalar algunos de los diferentes layers de Google y OpenStreetMaps. Al momento de escribir este tutorial, el plugin OpenLayers (v. 1.1.1) puede instalarse en Macs que usan OSX pero no trabaja apropiadamente. Parece trabajar de manera más consistente en Windows 7. De todas maneras, dale un intento, ya que solo mejorará en los meses que vienen. Ten en cuenta, sin embargo, que la proyección de algunos mapas globales no se auto-corrige, asi que las imágenes de satelite pueden no sincronizar apropriadamente con los datos puestos en una CRS diferente.

Abriendo Vectores
---------------

[Definiendo][] vectores: GIS utiliza puntos, líneas y polígonos, también conocidos como **vectores**. Tu primer trabajo es acomodar estos puntos, líneas y polígonos, y proyectarlos apropiadamente en los mapas. Los puntos pueden ser pueblos o postes telefónicos; las líneas pueden representar ríos, caminos o líneas de tren; los polígonos pueden enmarcar fincas o limites políticos más amplios. Sin embargo, también es posible aplicar datos históricos a estos lugares geográficos y estudiar como las personas han interactuado y alterado el ambiente físico que los rodea, la población de los pueblos ha cambiado, los ríos han alterado su curso, los lotes han sido dividos y la tierra ha sido plantada con diferentes cultivos.

-   En el Layer de la barra de herramientas, elige Añadir Layer de Vectores (el icono que vez al lado de 'Añadir Layer de Vectores' también puede ser seleccionado en la barra de herramientas en la esquina superior izquierda)

{% include figure.html filename="qgis6.png" caption="Figure 6" %}

-   haz click en Browse, y busca los shapefiles que descargaste anteriormente de la Isla Principe Eduardo en la carpeta
-   abre la carpeta coastline\_polygon

{% include figure.html filename="qgis7.png" caption="Figure 7" %}

-   selecciona el archivo coastline\_polygon.shp, y haz click en OK. Deberías poder ver ahora la línea costera de la isla en tu pantalla. En algunas ocasiones QCUS añade fondos coloreados (como en la imágen de arriba). Si tiene uno, sigue los siguientes pasos. Si no, salta hasta la parte \*\*\*.
-   haz clic derecho en el layer (coastline\_polygon) en el menu de Layers y elige Propiedades.\

{% include figure.html filename="qgis8.png" caption="Figure 8" %}

-   En la ventana resultante, haz clic en Estilo en el panel izquierdo

-   Hay un rango de opciones, pero si queremos deshacernos del fondo completamente, hacemos clic en **Relleno simple**.

{% include figure.html filename="qgis9.png" caption="Figure 9" %}

-   Luego selecciona ''**Sin pincel**' en el menu desplegable de **Estilo de relleno**.
    **Haz clic en OK**

{% include figure.html filename="qgis10.png" caption="Figure 10" %}

\*\*\*

-   Selecciona Añadir Layer de Vector nuevamente.
-   haz clic en Buscar y busca las shapefiles que descargaste de la Isla Principe Eduardo en la carpeta
-   selecciona 'PEI\_HYDRONETWORK'
-   haz clic en 'PEI\_HYDRONETWORK.shp' y luego en 'Abrir'
-   haz clic en el menu de Layers y selecciona Propiedades.
-   selecciona la pestaña de Estilo y un color azúl apropiado para la red hídrica. Presiona 'OK' en la parte inferior derecha de la ventana.

{% include figure.html filename="qgis11.png" caption="Figure 11" %}

-   Tu mapa debería verse asi:

{% include figure.html filename="qgis12-300x199.png" caption="Figure 12: Click to see full-size image" %}

-   Selecciona Añadir Layer de Vector nuevamente.
-   haz clic en Buscar y busca las shapefiles que descargaste de la Isla Principe Eduardo en la carpeta
-   haz doble clic en '1935 inventory\_region.shp' y presiona 'Abrir'

Esto añadira un mapa denso que muestra la different cobertura forestal en 1935.
Sin embargo, para ver la diferentes categorías, vas a necesitar cambiar la simbología de manera que colores distintos representen categorías forestales distintas. Para eso necesitamos saber que columnas en las tablas de bases de datos incluyen la infrmación de cateogría forestal. El primer paso entonces es ver la tabla de atributos.

-   haz clic derecho en el layer 1935\_inventory\_region en la ventada de Layers a la izquiera y luego haz clic en Abrir Tabla de Atributos

{% include figure.html filename="qgis13.png" caption="Figure 13" %}

Una tabla de atributos se abrirá. Tiene un número de categorías e identificadores. La categoría LANDUSE es especialmente importante ya que provee la información de la cubierta forestal en 1935. A continuación demóstraremos como hacer visibles estas categorías en el mapa.

{% include figure.html filename="qgis14.png" caption="Figure 14" %}

-   Cierra la tabla de atributos y haz nuevamente clic derecho en el layer 1935\_inventory\_region layer again. Esta vez selecciona Propiedades.
    (Una manera mas rápida de hacerlo es hacer doble clic en 1935\_inventory\_region layer).
-   Haz clic en Estilo a la izquierda

{% include figure.html filename="qgis15.png" caption="Figure 15" %}

-   En el menu que dice 'Single Symbol' selecciona 'Categorized'

{% include figure.html filename="qgis16.png" caption="Figure 16" %}

-   Al lado de Columna selecciona 'Landuse'
-   utiliza la paleta de color para elegir verdes
-   haz clic en 'Clasificar' en la esquina inferior izquierda
-   en la columna Símbolo, selecciona el cuadro de verde oscuro que se encuentra más abajo (y que no tiene marcado ningun valor) y haz clic en 'Eliminar' (el botón se encuentra a la derecha de Clasificar); elimina también la categoría Desarrollado, ya que queremos resaltar las áreas con bosques. Haz clic en 'OK'

{% include figure.html filename="qgis17.png" caption="Figure 17" %}

-   en el menu de la barra lateral, haz clic en la flecha al lado de 1935\_inventory\_region para ver la inscripción.

-   Puedes ver ahora la extension de los bosques en 1935. Intenta usar la lupa para ampliar e inspeccionar los diferentes usos de la tierra (landuses).

{% include figure.html filename="qgis18-300x283.png" caption="Figure 18: Click to see full-size image" %}

-   Para regresar a la vista completa de la isla, haz clic derecho en cualquiera de los layers y selecciona '**Ajustar a extension del layer**'

{% include figure.html filename="qgis19.png" caption="Figure 19" %}

-   A continuación, vamos a añadir un layer de caminos.
-   Bajo Layer en la barra de herramientas, elige Añadir Layer de Vectores
-   Haz clic en Buscar y busca las shapefiles que descargaste de la Isla Principe Eduardo en la carpeta
-   Selecciona 'PEI\_highway.shp'
-   Haz doble clic en 'PEI\_highway\_ship' en el menu de Layers a la izquierda, y selecciona Estilo del menu (si no está seleccionado ya)
-   Haz clic en 'Single Symbol' en la esquina superior izquiera y selecciona 'Categorizado'
-   elige 'TYPO' en la columna contigua
-   haz clic en Clasificar

{% include figure.html filename="qgis20.png" caption="Figure 20" %}

-   en la columna de Simbolo, haz doble-clic al lado de 'Primario' - en la siguiente ventana hay diferentes símbolos. Busca 'camino principal'.

-   De regreo en la ventana de Estilo, repite el proceso para el item 'primary\_link' en la columna Label.

{% include figure.html filename="qgis21.png" caption="Figure 21" %}

-   haz clic en el símbolo al lado de secundario. Cambia el color a negro y el ancho a 0.7
-   repite para el enlace secundario
-   haz clic en OK. Ahora podras ver en el mapa las autopistas y otras carreteras importantes.

{% include figure.html filename="qgis22.png" caption="Figure 22: Click to see full-size image" %}

-   Bajo Layer en la barra de herramientas, elige Añadir Layer de Vectores
-   Haz clic en Buscar y busca las shapefiles que descargaste de la Isla Principe Eduardo en la carpeta
-   selecciona 'PEI\_placenames\_shp'
-   haz doble clic en 'PEI\_placenames' y selecciona 'abrir'
-   En la ventana de Layers, haz doble clic en el layer PEI\_placenames layer.
    Elige la pestaña de Labels a la izquiera (bajo Estilo). En la parte superior, selecciona el cuadro al lado de 'Etiqueta este layer con' y en el menu desplegable selecciona 'Placename'

{% include figure.html filename="qgis23.png" caption="Figure 23" %}

-   Cambia el tamaño de la letra a '18′
-   Haz clic en 'OK' y revisa los resultados en el mapa

{% include figure.html filename="qgis24.png" caption="Figure 24: Click to see full-size image" %}

-   Es en esto que QGIS queda corto en comparación a la cartografía real – toma algo de trabajo hacer los ajustes necesarios para mostrar el nivel de detalle deseado para una presentación. Intenta regresar a la pestaña de Labels y cambiar las diferentes opciones para ver como los simbolos cambian.

Ten en cuenta que en el menu de Layers, puedes añadir y elimiar los diferentes layers que hemos puesto en el mapa, como lo harías en Google earth. Haz click en las casilla de verificación para quitar o ponerlos. Arrastra layers para cambiar el orden de aparición, con el que está mas arriba siendo el que aparece en frente de todos los demas, y por tanto, el más prominente. Por ejemplo si arrastras 'coastline\_polygon' a la parte superior, tienes un esquema simplificado de la provincia junto con nombres de lugares.

{% include figure.html filename="qgis25.png" caption="Figure 25: Click to see full-size image" %}

-   Hay una serie de íconos que te permiten explorar el mapa. Puedes encontrarlos junto con la barra de herramientas en la parte superior izquierda de la ventana principal. El icono de la mano, por ejemplo, te permite hacer clic en el mapa y moverlo, las lupas con signos de suma y resta te permiten ampliar o reducir el tamaño. Intenta jugar con estas funciones y familiarizarte con ellas.

{% include figure.html filename="qgis26.png" caption="Figure 26" %}

-   ya creamos un mapa usando layers vectoriales. Ahora vamos a añadir o utilizar nuestro primer layer rasterizado. Este es un buen momento para guardar tu trabajo.

**Abriendo layers rasterizados**: Informacion **rasterizada** son imagenes digitales, conformadas por rejillas.
Todos los datos remotos como imagenes por satelite o [fotos aéreas][] son rasterizadas. Las rejillas no son visibles normalmente puesto que estan hechas de pequeños pixeles. Cada pixel tiene su propio valor y cuando estos valores son representados en un color o escala de grises, conforman una imágen útil para visualización o análisis topográficos. Un mapa histórico escaneado también será importado a GIS en este formato.

-   descarga: [PEI_CumminsMap1927.tif][] a la carpeta de tu proyecto.
-   Bajo Layer en la barra de herramientas, elige Añadir Layer Rasterizado (el mismo ícono encontrado al lado de esta opcion también puede ser encontrado en la barra de herramientas a la izquerda de la ventana)

{% include figure.html filename="qgis27.png" caption="Figure 27" %}

-   encuentra el archivo 'PEI_CumminsMap1927.tif' descargado anteriormente
-   se te pedirá que definas el sistema de cordenadas de este layer. En el cuadro de busqueda Filtro, busca '2291', luego selecciona 'NAD83(CSRS98) / Prince Edward Isl. (Stereographic)…'

{% include figure.html filename="qgis28.png" caption="Figure 28" %}

-   Si el programa no te pide el CRS tendrás que cambiarlo manualmente. Haz doble clic en el layer PEI\_CummingMap1927\_compLZW y elige '**General**' en el menu de la izquierda. Luego as clic en '**Specify…**' al lado del cuadro con el sistema de referencia de coordenadas equivocado.
    Luego sigue las instrucciones que escribimos anteriormente (elige 2291).

{% include figure.html filename="qgis29.png" caption="Figure 29" %}

-   En la ventana de Layers, el mapa debería aparecer debajo de la informacion vectorial.
    Muévelo a la parte inferior del menú de ser necesario:

{% include figure.html filename="qgis30.png" caption="Figure 30" %}

-   Nos gustaría hacer la línea costera más notable, así que hacemos doble clic en 'coastline\_polygon' y seleccionamos 'Estilo'.
    En el cuadro bajo Symbol layers selecciona 'Relleno simple'. Las Opciones apareceran en el cuadro de la derecha. Haz clic en el menú al lado de 'borde' y hazlo rojo. Luego cambia su ancho a 0.5. Haz clic en OK.

{% include figure.html filename="qgis31.png" caption="Figure 31" %}

-   Ahora puedes ver el mapa rasterizado através del layer 'coastline\_polygon'. Amplíalo para revisar de cerca. Esto debería permitirte ver la línea costera con claridad. La alineación es relativamente buena pero no perfecta. Aprenderemos más al respecto de eso en la lección 4 sobre las dificultades de georeferenciar mapas históricos para darles coordenadas en el mundo real.

{% include figure.html filename="qgis32.png" caption="Figure 32" %}

**Haz aprendido como instalar QGIS y añadir layers. Asegúrate de guardar tu trabajo!**

*Esta lección es parte de [Historiador Geoespacial][].*

  [QGIS Download page]: http://hub.qgis.org/projects/quantum-gis/wiki/Download
  [KyngChaos Qgis download page]: http://www.kyngchaos.com/software/qgis
  [PEI Highways]: ../assets/PEI_highway.zip
  [alternate Tar file]: https://www.dropbox.com/s/8k81jnmhpoi99fv/pei_highway.tar.gz
  [PEI Places]: ../assets/PEI_placenames.zip
  [1]: https://www.dropbox.com/s/33g19iqhdnxoayd/pei_placenames.tar.gz
  [Coordinate Reference System]: http://en.wikipedia.org/wiki/Spatial_reference_system
  [NRCan's website]: http://www.nrcan.gc.ca/earth-sciences/geography-boundary/mapping/topographic-mapping/10272
  [Double Stereographic projection]: http://www.gov.pe.ca/gis/index.php3?number=77865&lang=E
  [Tutorial: Working with Projections in QGIS]: http://qgis.spatialthoughts.com/2012/04/tutorial-working-with-projections-in.html
  [defined]: http://www.gislounge.com/geodatabases-explored-vector-and-raster-data/
  [aerial photos]: http://en.wikipedia.org/wiki/Orthophoto
  [PEI_CumminsMap1927.tif]: ../assets/PEI_CumminsMap1927_compLZW.tif
  [Geospatial Historian]: http://geospatialhistorian.wordpress.com/
