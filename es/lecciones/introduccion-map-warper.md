---
title: |
    Introducción a Map Warper
authors:
    - Miguel Cuadros
    - Anthony Picón
date: 2019-01-14
reviewers:
- 
editors:
  - 
layout: lesson
difficulty: 2
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/
activity: analyzing
topics:
abstract: |
  ""
---



# Introducción a Map Warper

  
## Contenidos
- ¿Qué es Map Warper? 
  - Registrar
 - Vincular cartografía
   - Upload Map
   - Edit (opcional)
   - Metadata
 - Georreferenciar cartografía
   - Show
   - Rectify
   - Crop
   - Align
   - Preview
  - Descargar cartografía
    - Export
    - Activity
   - Comentar cartografía

## ¿Qué es Map Warper?

[Map Warper](http://mapwarper.net/) fue desarrollado por [Tim Waters](https://thinkwhere.wordpress.com/), es una herramienta de acceso libre que permite georreferenciar imágenes raster -mapa de bits donde cada píxel tiene un color definido- sin necesidad de instalar un programa informático. Map Warper permite la georreferenciación de mapas antiguos, fotografías aéreas, imágenes de satélites y demás materiales cartográficos. A su vez, la herramienta posibilita la vinculación del material cartográfico georreferenciado a toda clase de sistemas de información geográfico –QGIS, (Java) OpenStreetMap, ArcGIS, Google Earth, World Map, otros–, catálogos y motores de búsqueda automatizados. 

Gracias a sus características, Map Warper ayuda a descentralizar los procesos de georreferenciación y catalogación, ya que su plataforma crea un espacio virtual de colaboración abierta. La herramienta puede ser útil tanto para los investigadores como para las instituciones que estén desarrollando procesos de digitalización de patrimonio cartográfico, como es el caso del proyecto [Mapoteca Digital](http://bibliotecanacional.gov.co/es-co/colecciones/biblioteca-digital/mapoteca) de la Biblioteca Nacional de Colombia. Por su parte, esta lección se concibe como el primer componente de un módulo más amplio orientado al manejo de herramientas digitales para extraer y organizar de forma sistemática la información geoespacial contenida en las cartografías antiguas.  

### Lo que aprenderás en este tutorial

Al finalizar este tutorial el usuario tendrá la capacidad de georreferenciar materiales cartográficos (mapas, planos, fotografías aéreas y otros), mediante la plataforma libre Map Warper. En ese sentido, la lección es un complemento a otras lecciones de Programming Historian, referentes a la utilización de Sistema de Información Geográfica para el análisis espacial (Georeferencing in QGIS e Introducción a Google Maps y Google Earth). En esta ocasión, además de conocer las pautas técnicas esenciales para la georeferenciación de mapas antiguos, el usuario se familiarizará con el patrimonio cartográfico y su potencialidad en la investigación histórica.

### Registrar
Desde tu navegador favorito ingresa a [www.mapwarper.net](http://www.mapwarper.net), ve a la pestaña “Create Account”, ubicada en la esquina superior derecha del portal. Al ingresar a Create Account introduce la información correspondientes según los campos solicitados. Recuerda que puedes utilizar tu cuenta de Facebook, OpenstreetMap y GitHub para agilizar el proceso de registro.

![Registrarse en Map Warper](https://i.imgur.com/MXAKDDx.gif)
## Vincular cartografía
### Upload Map
Para cargar un material cartográfico en Map Warper, selecciona la pestaña “Upload Map”. Ahí podrás vincular la cartografía directamente desde un archivo local o anclarla desde un repositorio web por medio de la URL correspondiente. En este paso también puedes ir agregando los metadatos correspondientes del material cartográfico a georreferenciar. Para terminar el proceso de carga da click en la opción “Create”.
### Edit (opcional)
Si bien este paso es opcional, vale la pena insistir en su importancia para los procesos de catalogación y organización de los materiales cartográficos. Debido a la naturaleza colaborativa y colectiva de Map Warper recomendamos cumplimentar la información de los siguientes metadatos solicitados.
  

   - Title: Número de registro, criterio de titulación que permita    organizar la información que permita ubicar la información en su    repositorio de origen.
   - Description: Referencia de la imagen cartográfica.
   - Issue Year: Año de elaboración o publicación del mapa.
   - Tags: Introducir entre tres a cinco etiquetas.
   - Subject Area: Tipología del material cartográfico.
   - Source: URL de la visualización del documento.
   - Place of publication: Lugar de publicación o de elaboración del documento.
   - Scale: Escala numérica.
  - Metadata Projection: Proyección cartográfica.

   
### Metadata
La pestaña “Metadata” visualiza la información cumplimentada en la etapa de Upload Map y Edit. En ese sentido, se recomienda vincular la mayor información del recurso compartido, ayudando a los usuarios de la herramienta contar con la mayor información del contenido.
## Georreferenciar cartografía
 **Mapa Cafetero de Colombia** 

El tutorial georeferencia el [Mapa Cafetero de Colombia](http://catalogoenlinea.bibliotecanacional.gov.co/custom/web/content/mapoteca/fmapoteca_984_figac_16/fmapoteca_984_figac_16.html) [fmapoteca_984_figac_16], elaborado en 1933 por la Federación Nacional de Cafeteros de Colombia. Así pues, además de la orientación sobre el uso de Map Warper, con este tutorial también se ofrecen pautas sobre los aspectos generales a tener en cuenta para la georreferenciación de cartografías antiguas y la importancia de este tipo de procesos para el análisis histórico.
### Show
Esta pestaña nos presenta la visualización del documento cartográfico vinculado, entre las herramientas de navegación contamos con la opción de acercar y mover. En este segmento es importante explorar el documento cartográfico y formularse las siguientes preguntas: ¿Qué lugar está representando en el material cartográfico? ¿cuáles fueron los cambios a lo largo del tiempo del espacio representado? ¿reconoces algún punto de referencia geográfica vigente? También es importante preguntarse cuál es el sentido de la georeferenciación de cartografías antiguas.  

Por su parte, en términos del análisis histórico es importante identificar los componentes temáticos del material cartográfico a georreferenciar (componentes urbanos y naturales, jurisdicciones, distribución de recursos, entre otros) y los diferentes referentes documentales con los cuales se podría cruzar y complementar la información brindada (estadísticas, reportes gubernamentales, documentos personales o incluso otros materiales cartográficos elaborados posterior o anteriormente al utilizado). Estas consideraciones son fundamentales para desarrollar el siguiente paso de forma adecuada no solo en el aspecto técnico, también en función del uso interpretativo que se hará del material.

### Rectify
En este segmento realizaremos la georreferenciación del documento cartográfico vinculado. La ventana principal nos presentará dos recuadros, el recuadro de la izquierda contiene al mapa vinculado, el recuadro de la derecha contiene el mapa base, predeterminadamente aparece asociado a la capa base de OpenStreetMap.

[Video (3 min)].
### Crop
La pestaña "Crop" permite recortar el área de interés de la cartografía trabajada, de acuerdo con esto, la opción es útil para dividir mapas compuesto. El recuadro de visualización integra las siguientes acciones: ![enter image description here](https://i.imgur.com/qltUq7S.gif) *Move around Map* -mover mapa-, ![enter image description here](https://i.imgur.com/AcjK6gG.gif) *draw new polygon to mask* -dibujar polígono- y ![enter image description here](https://i.imgur.com/gcXUDga.gif) *delete a polygon* -eliminar polígono-. Por último, después de demarcar el área a mantener, damos click en “Mask Map” para finalizar el recorte de la imagen.

![enter image description here](https://i.imgur.com/hYGuouI.gif)
### Aling
La pestaña "Aling" permite organizar como mosaico un conjunto de cartografías, es una herramienta adecuada para conectar mapas fragmentados, fotografías aérea, y demás documentos cartográficos que comparten un mosaico. No olvides dar click en “align map” para realizar la alineación de las imágenes.

![enter image description here](https://i.imgur.com/qd3j7pw.gif)
### Preview
Esta pestaña permite visualizar los resultados ejecutados del paso “Rectify”, es útil para hacer seguimiento al proceso de georreferenciación llevado en curso. Al mismo tiempo, el recuadro de visualización integra las herramientas de mover, zoom -ampliar o diminuir- , transparencia y *layer* ![layer](http://mapwarper.net/assets/openlayers/theme/dark/layer_switcher_maximize.png).
## Descargar cartografía
### Export
La pestaña “Export” permite descargar la imagen georreferenciada en diferentes formatos, archivos estándar en distintos Sistemas de Información Geográfica (SIG). Los formatos se agrupan en tres categorías:

- Images: GeoTiff, PNG rectificado. Estos formatos agregan coordenadas geográficas y un sistema de proyección al documento cartográfico, por ello los metadatos geográficos permiten enlazar el documento georreferenciado a un Sistema de Información Geográfica. Se recomienda utilizar estos formato para trabajar en computadoras sin conectividad a Internet.

- Map Services: KML, WMS, Tiles. Los formatos geográficos de esta categoría cumplen una función homóloga a los enunciado en *Images*, sin embargo, solo se pueden utilizar en computadoras que cuentan con conectividad a Internet.

- Ground Control Points: CSV. Esta categoría permite descargar la tabla Control Points confeccionada en el paso “Rectify”, la tabla agrupa los puntos de control entre la imagen raster (mapa antiguo) con el mapa vectorial de OpenStreetMap , es decir que asocia x,y a la longitud y la latitud.

**Nota:** La imagen georreferenciada puede tener diferentes comportamientos debido a la proyección, el sistema de coordenadas, el elipsoide y el datum que utilice el Sistema de Información Geográfica correspondiente.
### Activity
La pestaña “Activity” ayuda a monitorear el registro de intervención del documento cartográfico. La actividad reconoce los campos de: “Time” -fecha-, “User” -usuario-, “Map” -código de imagen-, “Activity summary” -resumen de la actividad-, “Version” -versión de intervención- y “Further details” -detalles de la intervención-. Por su parte, todos los usuarios de Map Warper pueden monitorear los cambios del material cartográfico. A la par, en el segmento Activity, pueden hacer click en  ![enter image description here](http://mapwarper.net/assets/feed-icon-14x14-c61922c8668fd4f58ea3660692ba7854.png) “RSS Feed” para descargar un informe general de las intervención ejecutadas, en archivo .rss.
## Comentar cartografía
La pestaña “Comments” permite agregar comentarios sobre el documento cartográfico. Es un canal abierto que permite establecer comunicación con el usuario que compartió el material cartográfico. A su vez, el espacio posibilita alimentar los proceso de descripción y catalogación en la medida que usuarios comparten información sobre el documento cartográfico. No olvides dar click en “add comment” para agregar el comentario.
