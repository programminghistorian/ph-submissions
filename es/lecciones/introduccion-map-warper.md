---
title: |
    Introducción a Map Warper
authors:
   - Anthony Picón Rodríguez
   - Miguel Cuadros
   
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

[Map Warper](http://mapwarper.net/), es una herramienta de código abierto, acceso libre, desarrollada y soportada desde 2008 por [Tim Waters](https://thinkwhere.wordpress.com/), para georreferenciar y visualizar imágenes de áreas geográficas sin necesidad de instalar un programa informático. La herramienta es implementada en distintos proyectos digitales, de distintas instituciones del mundo y utilizada por diversos profesionales no especializados en el campo de la cartografía. 

Map Warper fue diseñada para georreferenciar mapas antiguos -mapamundis, portulanos, cartas náuticas, planos topográficos, planos arquitectónicos, cartas geográficas-, fotografías aéreas y demás materiales cartográficos contenidos en las colecciones de caracter patrimonial. En tal sentido, la herramienta nos posibilita la generación de material georreferenciado para trabajo en escritorio -rásteres- o en linea -Map Server-, útiles para vincular a sistemas de información geográfico (QGIS, JOSM, ArcGIS, Google Earth, World Map, otros). Asimismo, la herramienta ayuda a descentralizar y agilizar los procesos de georreferenciación, catalogación y visualización, ya que su plataforma crea un entorno de colaboración abierta.

Debido a sus características, la herramienta es útil a investigadores, profesores y estudiantes, como a instituciones que estan desarrollando procesos de digitalización, visualización y experimentación del material cartográfico de sus colecciones, o para el desarrollo de proyectos en humanidades espaciales, como son los caso de la [Mapoteca Digital](http://bibliotecanacional.gov.co/es-co/colecciones/biblioteca-digital/mapoteca) de la Biblioteca Nacional de Colombia, [Cartografía de Bogotá](http://cartografia.bogotaendocumentos.com/) de la Universidad Nacional de Colombia, [Paisajes coloniales: redibujando los territorios andinos en el siglo XVII](https://historia.uniandes.edu.co/index.php/mapa-paisajes-coloniales) de la Universidad de los Andes, y otros tantos. 


### Lo que aprenderás en este tutorial

El ambiente global que vivimos de las últimas décadas ha estado marcado por un profundo desarrrollo técnico y un cambio epistemológico que ha dado mayor atención al espacio y a la espacialidad. Esto ha permitido a las tecnologías influir y modificar las formas en que reflexionamos y comprendemos las Ciencias Sociales y Humanas. Gracias a las posibilidades que genera dichas tecnologías para potenciar la investigación y visualización de resultados, en ese sentido, también evidenciamos una renovación en las formas en que pensamos e interpretamos el pasado. Por tanto, la herramienta abordada en esta lección es producto y productora de estas relaciones tecnológicas que han permitido generar y expandir nuevas interpretaciones, desde estas nuevas narrativa espacial. 

La lección se concibe como el primer componente de un módulo más amplio, orientado al manejo de herramientas digitales para georreferencias, vectorizar, extraer, organizar y experimentar con información geográfica, presente en la documentación bibliográfica y cartográfica antigua que los distintos centros de documentación (archivos, bibliotecas, museos) estan digitalizando.

Al finalizar este tutorial tendrás la capacidad de georreferenciar materiales cartográficos (mapas, planos, fotografías aéreas y otros) mediante la herramienta de Map Warper. La lección es un complemento a otras lecciones de *Programming Historian*, referentes a la utilización de Sistemas de Información Geográfica para el análisis espacial: [Georeferencing in QGIS](https://programminghistorian.org/en/lessons/georeferencing-qgis) e [Introducción a Google Maps y Google Earth](https://programminghistorian.org/es/lecciones/intro-a-google-maps-y-google-earth). En este caso, además de conocer las pautas técnicas esenciales para la georreferenciación de mapas antiguos, te familiarizarás con el patrimonio cartográfico y su potencialidad en la investigación histórica.

### Registrarse
Desde tu navegador favorito ingresa en [www.mapwarper.net](http://www.mapwarper.net) y ve a la pestaña “Create Account”, ubicada en la esquina superior derecha del portal. En Create Account introduce la información correspondiente según los campos solicitados. Recuerda que puedes utilizar tu cuenta de Facebook, OpenstreetMap y GitHub para agilizar el proceso de registro.

![Registrarse en Map Warper](https://i.imgur.com/MXAKDDx.gif)

### Cargar Mapa (Upload Map) 
Para cargar un material cartográfico en Map Warper selecciona la pestaña “Upload Map”. Ahí podrás vincular el mapa directamente desde un archivo local o anclarla desde un repositorio web por medio de la URL correspondiente. En este paso también puedes ir agregando los metadatos del material a georreferenciar. Para concluir debes hacer click en la opción “Create”.

En caso de no tener un mapa para cargar a la herramienta, no preocupar, puede realizar el tutorial seleccionando uno del siguiente [listado](https://docs.google.com/spreadsheets/d/1Lm_S6E8JfPSHrmcimBNye3g7QcfQ8xe-fUx8n_Nr8iY/edit?usp=sharing), y así además de aprender, también ayudará a georreferenciar un mapa del proyecto colaborativo de la Mapoteca Digital de la Biblioteca Nacional de Colombia. 

### Editar (Edit)
En este paso se añaden los metadatos a la imagen cargada. Si bien esto es opcional, vale la pena insistir en su importancia para los procesos de catalogación y organización de los materiales cartográficos. Debido a la naturaleza colaborativa y colectiva de Map Warper, recomendamos incluir la información de los siguientes metadatos solicitados.
  
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
En este tutorial explicaremos el proceso de georreferenciación con el [Mapa Cafetero de la República de Colombia](http://catalogoenlinea.bibliotecanacional.gov.co/custom/web/content/mapoteca/fmapoteca_984_figac_16/fmapoteca_984_figac_16.html) de la Mapoteca Digital de la Biblioteca Nacional de Colombia. El documento cartográfico lo publicó la Federación Nacional de Cafeteros de Colombia en 1933, en una época en donde el café era la industria agrícola rectora de la economía colombiana, como resultado del primer censo cafetero del país realizado en 1932. 

Recordamos que en caso de no tener cargada cartografía alguna, podrá utilizar los mapas del siguiente listado, y en caso de recurrir al [listado](https://docs.google.com/spreadsheets/d/1Lm_S6E8JfPSHrmcimBNye3g7QcfQ8xe-fUx8n_Nr8iY/edit?usp=sharing), resalte el mapa seleccionado al interior del listado.

### Visualización del mapa (Show)
Esta pestaña nos presenta la visualización del documento cartográfico vinculado. Entre las herramientas de navegación contamos con la opción de acercar y mover. En este segmento es importante explorar el documento cartográfico y formularse las siguientes preguntas: ¿Qué lugar está representando en el material cartográfico? ¿Cuáles fueron los cambios a lo largo del tiempo del espacio representado? ¿Reconoces algún punto de referencia geográfica vigente? También es importante preguntarse sobre cuál es el sentido de la georreferenciación del mapa antiguo a realizar.  

Por su parte, en términos del análisis histórico es importante identificar los componentes temáticos del material cartográfico a georreferenciar (componentes urbanos y naturales, jurisdicciones, distribución de recursos, entre otros) y los diferentes referentes documentales con los cuales se podría cruzar y complementar la información brindada (estadísticas, reportes gubernamentales, documentos personales o incluso otros materiales cartográficos elaborados posterior o anteriormente al utilizado). Estas consideraciones son fundamentales para desarrollar el siguiente paso de forma adecuada no solo en el aspecto técnico, sino también en función del uso interpretativo que se hará del material.

### Georectificación (Rectify)
En este segmento realizaremos la georreferenciación del documento cartográfico seleccionado. En la ventana de "Rectify" se encontrá con dos recuadros: el recuadro de la izquierda contiene al mapa vinculado o seleccionado del listado; el recuadro de la derecha contiene el mapa base -OpenStreetMap-, es decir, la capa de referencia sobre la cual georreferenciaremos el mapa. También en el costado inferior de la ventana, encunetra un caja de herramientas llamada "Control Panel", interesada en complejizar y expandir las posibilidades de georreferenciación.

En este aspecto, para comprender mejor el desarrollo de esta acción técnica, detallamos cada una de las funciones y opciones disponibles a tener en cuenta en el segmento de "Rectify":

: El botón “Layer” (capa) nos permite seleccionar la capa base de OpenStreetMap o la de Mapbox Satellite. Además incluye la función “Overlays” (superponer) que permite sobreponer el mapa de trabajo -el Mapa Cafetero de la República de Colombia o el que usted seleccionó- después de confrimar la georreferenciación.

: El botón “Add Custom Basemap” (agregar mapa base), ubicado en el recuadro del lado derecho, nos permite añadir otra capa base de servidor, tipo XYZ Tiles, tal es el caso de las capas disponibles de: OpenStreetMap, Google Maps, Bing, CARTO, ESRI, Stamen, entre otras. También las cartografías georreferenciadas contenidas en la aplicación de Map Warper. 

: El botón “Add control point” (agregar punto de control), ubicado en ambos recuadros, sirve para posicionar los puntos de control que relacionan el mapa vinculado o selccionado con la capa base predeterminada o establecida. 

Al hacer click en el botón, debemos ubicar un punto de control en ambos recuadros, buscando la debida correspondencia entre el mapa vinculado con el mapa base y, luego de tener certeza de las respectivas ubicaciones, se da click en [imagen]  para confirmar el punto. Luego la acción se replica hasta alcanzar el número de puntos de control deseados (>3) y la confirmación de los resultados se da al hacer clip en "WARP IMAGEN!". 

>La precisión entre la correspondencia geométrica de la georreferenciación es proporcional al número de puntos de control asignados. 
>Recomendamos siempre acerca la visualización, al interior de ambos ventanas de visualización, para confirmar al realizar la ubicación de cada uno de los puntos de control.

: El botón “Mover around map” (mover punto de control) permite desplazar los puntos de control añadidos en ambas ventanas.

: El botón “Pan” (vista panorámica) al estar sin asegurar permite un acercamiento y movimiento independiente en cada una. 
“Zoom lock” (acercamiento bloqueado) Esta función permite sincronizar el zoom de las dos pantallas, Cuando está asegurado el aumento del zoom es proporcional en ambas pantallas  / 

 [gif]

Control Panel: [párrafo explicativo]
Control points (puntos de control): Párrafo explicativo, incluir la opción “Download points as CSV”


“Add control point manually” (agregar manualmente un punto de control): Agregar un punto de control de manera manual, útil cuando se conoce la coordenadas de píxel y las coordenadas geográficas del mismo. que asocia x,y a la longitud y la latitud, 

“Add control points from CSV” (agregar punto de control desde un archivo CSV): click en la selección del archivo y despues le damos cargar para que nos vincule la malla de puntos que relaciona  x,y a la longitud y la latitud, 

Double-click on both maps, then click . Do this for at least three points.Warp Image! Para aplicar la georreferenciación 

Apply clipping mask when rectifying? true or false. Aplicar la opción de recorte (crop) explicada más adelante. 

Se recomienda hacer un acercamiento detallado en los dos mapas para verificar la correspondencia de los puntos seleccionados. Este paso se debe repetir mínimo tres veces para que el sistema tengas los parámetros de orientación para hacer la georeferenciación. Con mayores puntos de control se incrementa las posibilidades de correspondencia entre las geometrías de los dos mapas.  


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
La pestaña “Activity” ayuda a monitorear el registro de intervención del documento cartográfico. La actividad reconoce los campos: “Time” (fecha), “User” (usuario), “Map” (código de imagen), “Activity summary” (resumen de la actividad), “Version” (versión de intervención) y “Further details” (detalles de la intervención). Por su parte, todos los usuarios de Map Warper pueden monitorear los cambios del material cartográfico. A la par, en el segmento Activity, pueden hacer click en ![enter image description here](http://mapwarper.net/assets/feed-icon-14x14-c61922c8668fd4f58ea3660692ba7854.png) “RSS Feed” para descargar un informe general de las intervención ejecutadas, en formato `rss`.
## Comentar mapa
La pestaña “Comments” permite agregar comentarios sobre el documento cartográfico. Es un canal abierto que permite establecer comunicación con el usuario que compartió el material cartográfico. A su vez, el espacio posibilita alimentar los proceso de descripción y catalogación en la medida que usuarios comparten información sobre el documento cartográfico. No olvides hacer click en “add comment” para agregar el comentario.
