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
- La Herramienta Map Warper y sus beneficios 
  - Registrarse
   - Cargar Mapa (Upload Map)
   - Editar (Edit)
   - Metadatos (Metadata)
 - Georreferenciar mapa
   - Visualización del mapa (Show)
   - Georectificación (Rectify)
   - Recorte (Crop)
   - Alinear (Align)
   - Previsualización (Preview)
  - Usos de la imagen georreferenciada
    - Exportar (Export)
    - Actividad (Activity)
   - Comentar mapa

## La herramienta Map Warper y sus beneficios

[Map Warper](http://mapwarper.net/), desarrollado por [Tim Waters](https://thinkwhere.wordpress.com/), es una herramienta de acceso libre y   funciona bajo una licencia Creative Commons. Permite georreferenciar imágenes ráster (mapa de bits donde cada píxel tiene un color definido) sin necesidad de instalar un programa informático. Su interfaz web está disponible hasta el momento en tres idiomas: Inglés, Neerlandés y Catalán. Map Warper permite la georreferenciación de mapas antiguos, fotografías aéreas, imágenes de satélites y demás materiales cartográficos. A su vez, la herramienta posibilita la vinculación del material cartográfico georreferenciado a toda clase de sistemas de información geográfico (QGIS, JOSM, ArcGIS, Google Earth, World Map, otros), catálogos y motores de búsqueda automatizados. 

Gracias a sus características, Map Warper ayuda a descentralizar los procesos de georreferenciación y catalogación, ya que su plataforma crea un espacio virtual de colaboración abierta. La herramienta puede ser útil tanto para los investigadores como para las instituciones que estén desarrollando procesos de digitalización de patrimonio cartográfico, como es el caso del proyecto [Mapoteca Digital](http://bibliotecanacional.gov.co/es-co/colecciones/biblioteca-digital/mapoteca) de la Biblioteca Nacional de Colombia. 

En este contexto, la lección se concibe como el primer componente de un módulo más amplio orientado al manejo de herramientas digitales para extraer y organizar de forma sistemática la información geoespacial contenida en los mapas antiguos.  

### Lo que aprenderás en este tutorial

Al finalizar este tutorial tendrás la capacidad de georreferenciar materiales cartográficos (mapas, planos, fotografías aéreas y otros), mediante la herramienta libre Map Warper. La lección es un complemento a otras lecciones de *Programming Historian*, referentes a la utilización de Sistemas de Información Geográfica para el análisis espacial: [Georeferencing in QGIS](https://programminghistorian.org/en/lessons/georeferencing-qgis) e [Introducción a Google Maps y Google Earth](https://programminghistorian.org/es/lecciones/intro-a-google-maps-y-google-earth). En este caso, además de conocer las pautas técnicas esenciales para la georreferenciación de mapas antiguos, te familiarizarás con el patrimonio cartográfico y su potencialidad en la investigación histórica.

### Registrarse
Desde tu navegador favorito ingresa en [www.mapwarper.net](http://www.mapwarper.net) y ve a la pestaña “Create Account”, ubicada en la esquina superior derecha del portal. En Create Account introduce la información correspondiente según los campos solicitados. Recuerda que puedes utilizar tu cuenta de Facebook, OpenstreetMap y GitHub para agilizar el proceso de registro.

![Registrarse en Map Warper](https://i.imgur.com/MXAKDDx.gif)

### Cargar Mapa (Upload Map) 
Para cargar un material cartográfico en Map Warper selecciona la pestaña “Upload Map”. Ahí podrás vincular el mapa directamente desde un archivo local o anclarla desde un repositorio web por medio de la URL correspondiente. En este paso también puedes ir agregando los metadatos del material a georreferenciar. Para concluir debes hacer click en la opción “Create”.
### Editar (Edit)
En este paso se añaden los metadatos a la imagen cargada. Si bien esto es opcional, vale la pena insistir en su importancia para los procesos de catalogación y organización de los materiales cartográficos. Debido a la naturaleza colaborativa y colectiva de Map Warper, recomendamos complomentar la información de los siguientes metadatos solicitados.
  
   - Title: Número de registro y criterio de titulación que permita organizar la información para ubicarla en su repositorio de origen.
   - Description: Referencia de la imagen cartográfica.
   - Issue Year: Año de elaboración o publicación del mapa.
   - Tags: Tres a cinco etiquetas que describan el material.
   - Subject Area: Tipología del material cartográfico.
   - Source: URL de la visualización del documento.
   - Place of publication: Lugar de publicación o de elaboración del documento.
   - Scale: Escala numérica.
  - Metadata Projection: Proyección cartográfica.
 
### Metadatos (Metadata)
La pestaña “Metadata” visualiza la información cumplimentada en la etapa de Upload Map y Edit. Se recomienda vincular la mayor cantidad de información del recurso compartido, para que otros usuarios de la herramienta cuenten con datos sobre el contenido.

## Georreferenciar mapa
 **Mapa Cafetero de Colombia** 
En este tutorial georreferenciarás el [Mapa Cafetero de Colombia](http://catalogoenlinea.bibliotecanacional.gov.co/custom/web/content/mapoteca/fmapoteca_984_figac_16/fmapoteca_984_figac_16.html) [fmapoteca_984_figac_16], elaborado en 1933 por la Federación Nacional de Cafeteros de Colombia. Así pues, además de la orientación sobre el uso de Map Warper, con este tutorial también se ofrecen pautas sobre los aspectos generales a tener en cuenta para la georreferenciación de mapas antiguos y la importancia de este tipo de procesos para el análisis histórico. (ALGO MÁS CONCRETO)

### Visualización del mapa (Show)
Esta pestaña nos presenta la visualización del documento cartográfico vinculado. Entre las herramientas de navegación contamos con la opción de acercar y mover. En este segmento es importante explorar el documento cartográfico y formularse las siguientes preguntas: ¿Qué lugar está representando en el material cartográfico? ¿Cuáles fueron los cambios a lo largo del tiempo del espacio representado? ¿Reconoces algún punto de referencia geográfica vigente? También es importante preguntarse cuál es el sentido de la georreferenciación de mapas antiguos.  

Por su parte, en términos del análisis histórico es importante identificar los componentes temáticos del material cartográfico a georreferenciar (componentes urbanos y naturales, jurisdicciones, distribución de recursos, entre otros) y los diferentes referentes documentales con los cuales se podría cruzar y complementar la información brindada (estadísticas, reportes gubernamentales, documentos personales o incluso otros materiales cartográficos elaborados posterior o anteriormente al utilizado). Estas consideraciones son fundamentales para desarrollar el siguiente paso de forma adecuada no solo en el aspecto técnico, sino también en función del uso interpretativo que se hará del material.

### Georectificación (Rectify)
En este segmento realizaremos la georreferenciación del documento cartográfico vinculado. La ventana principal nos presentará dos recuadros: el recuadro de la izquierda contiene al mapa vinculado y el recuadro de la derecha contiene el mapa base, que de forma predeterminada aparece asociado a la capa base de OpenStreetMap.
[Video (3 min)].
### Recorte (Crop)
La pestaña "Crop" permite recortar el área de interés del mapa trabajado, por lo que resulta útil para dividir mapas compuestos. El recuadro de visualización integra las siguientes acciones: ![enter image description here](https://i.imgur.com/qltUq7S.gif) *Move around Map* -mover mapa-, ![enter image description here](https://i.imgur.com/AcjK6gG.gif) *draw new polygon to mask* -dibujar polígono- y ![enter image description here](https://i.imgur.com/gcXUDga.gif) *delete a polygon* -eliminar polígono-. Una vez que hayamos demarcado el área a mantener, hacemos clic en “Mask Map” para finalizar el recorte de la imagen.

![enter image description here](https://i.imgur.com/hYGuouI.gif)
### Alinear (Align)
La pestaña “Align” permite organizar como mosaico un conjunto de cartografías. Es una herramienta adecuada para conectar mapas fragmentados, fotografías aérea y demás documentos cartográficos que comparten un mosaico. No olvides hacer click en “align map” para realizar la alineación de las imágenes.

![enter image description here](https://i.imgur.com/qd3j7pw.gif)
### Previsualización (Preview)
Esta pestaña permite visualizar los resultados ejecutados del paso “Rectify”. Es útil para hacer seguimiento al proceso de georreferenciación llevado en curso. Al mismo tiempo, el recuadro de visualización integra las herramientas de mover, zoom -ampliar o diminuir- , transparencia y *layer* ![layer](http://mapwarper.net/assets/openlayers/theme/dark/layer_switcher_maximize.png).
## Usos de la imagen georreferenciada
### Exportar (Export)
La pestaña “Export” permite descargar la imagen georreferenciada en diferentes formatos estándar en distintos Sistemas de Información Geográfica (SIG). Los formatos se agrupan en tres categorías:

- Images: GeoTiff, PNG rectificado. Estos formatos agregan coordenadas geográficas y un sistema de proyección al documento cartográfico, por ello los metadatos geográficos permiten enlazar el documento georreferenciado a un Sistema de Información Geográfica. Se recomienda utilizar estos formatoS para trabajar en computadoras sin conectividad a Internet.

- Map Services: KML, WMS, Tiles. Los formatos geográficos de esta categoría cumplen una función homóloga a los enunciado en *Images*; sin embargo, solo se pueden utilizar en computadoras que cuentan con conectividad a Internet.

- Ground Control Points: CSV. Esta categoría permite descargar la tabla Control Points confeccionada en el paso “Rectify”. La tabla agrupa los puntos de control entre la imagen ráster (mapa antiguo) con el mapa vectorial de OpenStreetMap, es decir, que asocia x,y a la longitud y la latitud, respectivamente.

>La imagen georreferenciada puede tener diferentes comportamientos debido a la proyección, el sistema de coordenadas, el elipsoide y el datum que utilice el Sistema de Información Geográfica correspondiente.

### Actividad (Activity)
La pestaña “Activity” ayuda a monitorear el registro de intervención del documento cartográfico. La actividad reconoce los campos: “Time” (fecha), “User” (usuario), “Map” (código de imagen), “Activity summary” (resumen de la actividad), “Version” (versión de intervención) y “Further details” (detalles de la intervención). Por su parte, todos los usuarios de Map Warper pueden monitorear los cambios del material cartográfico. A la par, en el segmento Activity, pueden hacer click en ![enter image description here](http://mapwarper.net/assets/feed-icon-14x14-c61922c8668fd4f58ea3660692ba7854.png) “RSS Feed” para descargar un informe general de las intervención ejecutadas, en formato `.rss.`.
## Comentar mapa
La pestaña “Comments” permite agregar comentarios sobre el documento cartográfico. Es un canal abierto que permite establecer comunicación con el usuario que compartió el material cartográfico. A su vez, el espacio posibilita alimentar los proceso de descripción y catalogación en la medida que usuarios comparten información sobre el documento cartográfico. No olvides hacer click en “add comment” para agregar el comentario.
