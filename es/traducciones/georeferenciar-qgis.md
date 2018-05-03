---
title: |
    Georeferenciar con QGIS 2.0
authors:
- Jim Clifford
- Josh MacFadyen
- Daniel Macfarlane
date: 2013-12-13
reviewers:
- Finn Arne Jørgensen
- Peter Webster
- Abby Schreiber
editors:
- Adam Crymble
- traductores:
- Maria José Afanador y Lorena Campuzano
revisores:
layout: default
redirect_from: /es/lessons/georeferenciar-qgis
prev: vector-layers-qgis
difficulty: 2

---


Objetivos de la lección
------------

En esta lección aprenderá cómo georrefereciar mapas históricos para que puedan añadirse a un SIG (Sistema de Información Geográfica) como una capa ráster. Georreferenciar es requerido para cualquier persona que quiera digitalizar con precisión datos encontrados en un mapa de papel, y como los historiadores trabajan sobre el todo en el reino del papel, georreferenciar es una de las herramientas que más utilizamos. La técnica utiliza una serie de puntos de control para darle a un objetos de dos dimensiones como un mapa de papel las coordenadas reales que necesita para alinearse con las características tridimensionales de la tierra en el software SIG (en [Intro to Google Maps and Google Earth][] vemos un 'overlay' que en Google Earth es una especie de una versión atajo de la georreferenciación).
Georreferenciar un mapa histórico requiere un conocimiento de la geografía e historia del lugar que estás estudiando para así asegurar precisión. Los paisajes construidos y naturales cambian a través del tiempo y es importante confirmar si la ubicación de tus puntos de control--sean casas, intersecciones o pueblos--se han matenido constantes. Introducir puntos de control en un SIG es fácil, pero detrás de bambalinas, la georreferenciación utiliza procesos complejos de transformación y compresión. Estos se utilizan para corregir las distorsiones e inexactitudes que se encuentran en muchos mapas históricos y estirar los mapas para que quepan dentro de coordenadas geográficas. En cartografía esto se conoce como *[rubber-sheeting][]* porque se trata al mapa como si estuviera hecho de caucho (*rubber* en inglés) y a los puntos de control como si fueran tachuelas "clavando" el documento histórico en una superficie tridimensional como el globo terránqueo.       

Para ofrecer algunos ejemplos de mapas históricos georreferenciados, hemos preparado algunos mapas de la National Topographic Series que se encuentran en el sitio web de la biblioteca de la Universidad de Toronto, cortesía de Marcel Fortin, y los hemos superpuesto en un mapa web de Google. Se les puede ajustar la transparencia con la barra deslizante en la esquina superior derecha, ver el mapa histórico superpuesto en imágenes de terreno o satelitales, o hacer clic en 'Earth' para cambiar al modo Earth y ver las elevaciones y edificios modernos en 3D (en Halifax y Darthmouth).   
Nota: estos mapas históricos son grandes y van a aparecer en a pantalla lentamente, especialmente cuando acercas la imagen en el mapa de Google.


-   [National Topographic System Maps][] – Halifax, 1920s
-   [National Topographic System Maps][1] – Western PEI, 1939-1944
-   [National Topographic System Maps][2] – Eastern PEI 1939-1944

## Para empezar

Antes de empezar a georreferenciar en Quantun GIS, necesitamos activar unos *plugins*. En la barra de herramientas vaya a "Plugins" -\>Manage and Install Plugins

{% include figure.html filename="geo110.png" caption="Figura 1" %}

Una ventana llamada "Plugin Manager" se abrirá. Desplázate hacia abajo hasta "Georeference GDAL" y activa la casilla que está a su lado y haz clic en OK.

{% include figure.html filename="geo210.png" caption="Figura 2" %}

-   En este momento necesita cerrar y volver a abrir QGIS. Para el propósito de este ejemplo, y para mantener las cosas lo más simple posible, no vuelva a cargar su proyecto sino que mejor comience un nuevo projecto.
-   Configure el *[Coordinate Reference System][]* (CRS) correctamente (ver [Installing QGIS 2.0 and adding Layers][] para recordar como hacerlo)
-   Guarde este nuevo proyecto (en el menú de *File*, selecciona *"Save Project"*) y nómbrelo 'georreferenciar.'
-   Añade la capa *'coastline\_polygon'* (ver [Installing QGIS 2.0 and
    adding Layers][] para recordar como)

## Abre las capas de GIS necesarias 

Para el estudio de caso de la isla del príncipe Edward (PEI), vamos a usar las fronteras de la municipilalidad como puntos de control debido a que estas fronteras fueron establecidas en 1764 por Samuel Holland, están identificadas en la mayoría de los mapas de PEI y han cambiado muy poco desde que fueron creadas. 

*Descargar lot\_township\_polygon:*

Este es el shapefile (entidades vectoriales) que contiene la capa de vectores indicando las divisiones municipales modernas que usaremos para georrefereciar el mapa histórico.  Note que las municipalidades no tenían nombres en 1764, sin embargo, tenían números asignados a cada lote, razón por la cual son referidos como "Lots" en PEI. De ahi que el archivo se llame 'lot\_township\_polygon'.

-   Navegue al siguiente enlace, acepte la licencia de uso y descargue 'lot\_township\_polygon'  (Le preguntarán su nombre y correo electrónico antes de poder descargar el archivo).

<http://www.gov.pe.ca/gis/license_agreement.php3?name=lot_town&file_format=SHP>
    
-  Después de descargar el archivo llamado 'lot \ _township \ _polygon', muévalo a una carpeta que pueda encontrar más adelante y descomprima el archivo. (Recuerde mantener los archivos juntos ya que todos son necesarios para abrir esta capa en su SIG)

{% include figure.html filename="geo310.png" caption="Figure 3" %}

*Añadir lot\_township\_polygon to QGIS:*

-   En la barra de herramientas vaya a "Layer", escoja "Add Vector Layer" (alternativamente, el mismo ícono que ve al lado de "Add Vector Layer" también se puede seleccionar desde la barra de herramientas)
-   Haga clic en "Browse". Navegue a su archivo descomprimido y seleccione el archivo 'lot \ _township \ _polygon.shp'
-   Haga clic en "Open"
  
{% include figure.html filename="geo41.png" caption="Figure 4" %}

Para más información sobre añadir y visualizar capas ver [Installing
QGIS 2.0 and adding Layers][].

{% include figure.html filename="geo51.png" caption="Figure 5" %}

## Abrir la herramienta para georreferenciar (Georeferencer Tool) 

"Georeferencer" ahora está disponible en el menú "Ráster" en la barra de herramientas: selecciónelo.

{% include figure.html filename="geo61.png" caption="Figure 6" %}

*Añadir su mapa histórico:*

-  En la ventana resultante, haga clic en "Open Raster" en la izquierda arriba,  (el cual luce idéntico a "Add Raster layer").

{% include figure.html filename="geo71.png" caption="Figure 7" %}

-   Busque el archivo 'PEI\_LakeMap1863.jpg' en su computador y seleccione "Open" (el archivo [puede descargarse aquí][] o en su locación original en la web [Island Imagined][])
-   El programa le pedirá definir el sistema coordenado de la capa. Busque en "Filter" el número '2291′, y luego en el cuadro debajo de éste seleccione 'NAD83(CSRS98) / Prince Edward …'

El resultado lucirá así:

{% include figure.html filename="geo81.png" caption="Figure 8" %}

*Añadir puntos de control*

Planificar los lugares que se van a utilizar como puntos de control antes de los pasos que siguen. Es mucho más fácil navegar primero por el mapa histórico, así que recórralo para hacerse a una idea de los mejores puntos para usar como puntos de control y téngalos en cuenta. Algunas sugerencias para escoger los puntos de referencia:

-   **Cuántos** puntos necesita? Usualmente, entre más puntos asigne, más preciso será su mapa georeferenciado. Dos puntos hará que el SIG rote y escale el mapa según esos puntos, pero para extender el mapa hisórico y hacerlo cubrir el mapa real se necesitan añadir más puntos. 
-   **Dónde** debe poner los puntos de control? Seleccione puntos en áreas lo más cerca posible de las cuatro esquinas de su mapa para que estas áreas externas no se omitan de la extensión del mapa. 
-  Seleccione puntos de control adicionales cerca de su área de interés.  Todo lo que esté entre los cuatro puntos de control de las esquinas debería georreferencia uniformemente, pero si le preocupa la precisión de un lugar en particular, asegúrese de seleccionar puntos de control adicionales en esa área.
- Seleccione puntos de control en el medio de intersecciones y caminos, porque los bordes de los caminos pudieron haber cambiado a medida que se fueron mejorando.
- Verifique que sus puntos de control no hayan cambiado de ubicación a lo largo del tiempo. Las carreteras a menudo se redirigían y las casas y otros edificios se han movido, especialmente [in Atlantic Canada][]!

*Añadir su primer punto de control:*

**Primero**, navegue a la ubicación de su primer punto de control en el ** mapa histórico **.

-  Haga clic "Zoom In Magnifying Glass" en la barra de herramientas o magnifique el punto con el mouse.

{% include figure.html filename="geo91.png" caption="Figure 9" %}

-  Acerquese y magnifique un punto que puede reconocer tanto en su mapa impreso como en su SIG.

-  Haga clic  "Add Point" en la barra de herramientas.

{% include figure.html filename="geo101.png" caption="Figure 10" %}

-  Haga clic en el lugar del mapa impreso que pueda localizar en su SIG (es decir, el punto de control). La ventana de georeferenciación se minimizará automáticamente. Si no lo hace (algunas versiones tienn un problema en este plugin), hágalo manualmente.  
-  Haga clic en el lugar en el SIG que coincide con el punto de control del mapa impreso. 

{% include figure.html filename="geo111.png" caption="Figure 11" %}

-   
{% include figure.html filename="geo121.png" caption="Figure 12" %}

En esta etapa identificamos un problema en los límites de los lotes. Habíamos planeado usar la ubicación donde el límite sur del lote 1 en el extremo oeste de la provincia contiene un pliege abrupto cerca del centro de la masa terrestre. Sin embargo, se observa que no todos estos quiebres abruptos en los límites de los lotes coincidían con el mapa histórico. Es posible que los límites de los lotes hayan cambiado algo en los 250 años desde que se establecieron, por lo que es mejor elegir el punto del que se está más seguro. En este caso, el pliegue abrupto entre el Lote 2 y el Lote 3 estaba bien (ver flecha roja en la figura). Fue el límite de los Lote 3 y 4 que ha cambiado. La discrepancia en el borde de 1 y 2 muestra que se necesitan más puntos de control para estirar el mapa hasta que coincida con el SIG.

*Añadir al menos otro punto de control más:*

-   Vuelva a la ventana "Georeferencer" y repita los pasos de '* Añadir su primer punto de control *' arriba para añadir puntos de control adicionales.
-  Agregue un punto cerca del lado opuesto de su mapa impreso (cuanto más separados estén los puntos de control, más exacto será el proceso de georreferenciación) y otro cerca de Charlottetown
-  Vuelva a la ventana "Georeferencer". Debería ver tres puntos rojos en el mapa impreso y tres registros en la tabla de BPC en la parte inferior de la ventana (en rojo en la siguiente imagen).

{% include figure.html filename="geo131.png" caption="Figure 13" %}

*Determinar la configuración de la transformación:*

Antes de que haga clic en "Play" y comience el proceso automático de georeferenciación, usted debe especificarle a QGIS donde salvar el archivo (el cual será una imagen ráster), cómo el programa debe interpretar sus puntos de control, y cómo debe comprimir la imagen.  

-   Haga clic en "Transformation Settings"

{% include figure.html filename="geo141.png" caption="Figure 14" %}

La mayoría de las opciones de configuración pueden dejarse como estén predeterminadas: "Linear transformation type", "Nearest neighbour resampling method", and "LZW compression". (El [world file][] no es necesario, a menos que desee georreferenciar la misma imagen otra vez en otro SIG o si alguien más necesita georreferenciar la imagen y no tiene acceso a su información SIG, sistema de referencia de coordenadas, etc.) El SRS final no es importante, pero podría usar esta función para darle al nuevo ráster un sistema de referencia diferente.

-   Asigne una carpeta para su nuevo archivo de ráster georreferenciado. [Tif] [] es el formato predeterminado para los rásteres georeferenciados en QGIS.
-   Tenga en cuenta que un archivo Tif va a ser mucho más grande que su mapa original, incluso con compresión LZW, así que asegúrese de tener suficiente espacio si está utilizando un disco externo o USB. ((*Advertencia:* El archivo TIF producido a partir de este 6.8 Mb .jpg será de ** más de 1 GB** una vez georeferenciada. Una forma de controlar el tamaño del archivo raster georreferenciado manteniendo una resolución lo suficientemente alta para la legibilidad es recortar únicamente el área del mapa necesaria para el proyecto. En este caso, también está disponible una opción de menor resolución del repositorio de mapas en línea [Island Imagined] [].
- Deje la resolución del mapa georeferenciado en el valor predeterminado
- Puede seleccionar ‘Use 0 transparency when needed’ para eliminar espacios negros alrededor de los bordes del mapa, pero esto no es necesario y puede experimentar según sea necesario.
- Asegúrese de que esté seleccionado 'Load in QGIS'. Esto agregará automáticamente el nuevo archivo a la tabla de contenido de su SIG para que no tenga que ir a buscar el archivo Tif más tarde.

{% include figure.html filename="geo151.png" caption="Figure 15" %}

## ¡Georeferenciar!

-  Haga clic en "Play" en la barra de herramientas ( al lado de "Add Raster"). Esto inicia el proceso de georeferenciación.

{% include figure.html filename="geo161.png" caption="Figure 16" %}

{% include figure.html filename="geo171.png" caption="Figure 17" %}

-   Una ventana debe aparecer pidiendo que defina CRS. Seleccione 2291 y presione OK.

{% include figure.html filename="geo181.png" caption="Figure 18" %}

*Explorar su mapa:*

-   Arrastre la nueva capa 'PEI\_LakeMap1863\_modified' al final de su "Table of Contents" (debajo de la capa 'lot\_township\_polygon')

{% include figure.html filename="geo191.png" caption="Figure 19" %}

-   Cambie el llenado de la capa 'lot\_township\_polygon'  a "no brush" seleccionando la capa -\> "Properties" y haciendo clic en "Symbol Properties". Oprima OK.

{% include figure.html filename="geo201.png" caption="Figure 20" %}

-   Ahora debería ver la capa SIG moderna con el mapa histórico atrás.

{% include figure.html filename="geo211.png" caption="Figure 21" %}

Ahora que tiene el mapa georeferenciado en su SIG, puede explorar la capa, ajustar la transparencia, el contraste y el brillo, y nuevamente [Crear nuevas capas de vectores en QGIS] [] para digitalizar parte de la información histórica que ha creado. Por ejemplo, este mapa georreferenciado de PEI muestra las ubicaciones de todas las casas en 1863, incluido el nombre del jefe de hogar. Al asignar puntos en el mapa, puede ingresar las ubicaciones de inicio y los nombres de propietario y luego analizar o compartir esa nueva capa geoespacial como un shapefile. 

Al digitalizar vectores de línea como carreteras o costas, puede comparar la ubicación de estas características con otros datos históricos, o simplemente compararlos visualmente con la capa 'lot\_township\_polygon' en este SIG. 

En procesos más avanzados, puede incluso cubrir esta imagen georreferenciada con un DEM (modelo de elevación digital) para darle un juego de sombras que indiquen altura ("hillshade") o un efecto 3D y realizar un sobrevuelo ("fly-over") de hogares PEI en el siglo XIX.

*Este tutorial es parte de [Geospatial Historian][].*

  [Intro to Google Maps and Google Earth]: ../lessons/googlemaps-googleearth
  [rubber-sheeting]: http://en.wikipedia.org/wiki/Rubbersheeting
  [National Topographic System Maps]: http://maps.library.utoronto.ca/datapub/digital/3400s_63_1929/maptile/Halifax/googlemaps.html
  [1]: http://maps.library.utoronto.ca/datapub/PEI/NTS/west/
  [2]: http://maps.library.utoronto.ca/datapub/PEI/NTS/east/
  [Coordinate Reference System]: http://en.wikipedia.org/wiki/Spatial_reference_system
  [Installing QGIS 2.0 and adding Layers]: ../lessons/qgis-layers
  [can be downloaded here]: http://geospatialhistorian.files.wordpress.com/2013/02/pei_lakemap1863.jpg
  [Island Imagined]: http://www.islandimagined.ca/fedora/repository/imagined%3A208687
  [in Atlantic Canada]: http://books.google.ca/books?id=TqCNZYXWXAUC&dq=tilting&source=gbs_navlinks_s
  [world file]: http://en.wikipedia.org/wiki/World_file
  [Tif]: http://en.wikipedia.org/wiki/Tagged_Image_File_Format
  [Creating New Vector Layers in QGIS]: ../lessons/vector-layers-qgis
  [Geospatial Historian]: http://geospatialhistorian.wordpress.com/
