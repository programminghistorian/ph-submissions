---
title: |
  Introducción a Google Maps y Google Earth
layout: lesson
date: 2013-12-13
authors:
- Jim Clifford
- Josh MacFadyen
- Daniel Macfarlane
reviewers:
- Finn Arne Jørgensen
- Sarah Simpkin
editors:
- Adam Crymble
translators:
- Andrés Gattinoni
translator-reviewer:
difficulty: 1
activity: presenting
topics: [mapping]
abstract: "Google My Maps y Google Earth son una buena alternativa para comenzar
a crear mapas digitales. Con una cuenta de Google puedes crear y editar mapas
personales haciendo click en Mis Sitios"
next: qgis-layers
---

{% include toc.html %}





## Google Maps

Google My Maps y Google Earth son una buena alternativa para comenzar
a crear mapas digitales. Con una cuenta de Google puede crear y editar
mapas personales haciendo click en Mis Sitios.

En My Maps puede elegir entre diferentes mapas de base (incluyendo los
habituales satelital, físico y estándar) y agregar puntos, líneas y polígonos.
También es posible importar datos de una hoja de cálculos si tiene columnas
con información geográfica (esto es, longitudes y latitudes o nombres de
lugares). Esto automatiza una tarea que solía ser tediosa conocida como
geocodificación. Esta no es sólo una de las formas más sencillas de comenzar a
trazar su información histórica en un mapa, sino que también ofrece el poder
del motor de búsqueda de Google. A medida que vaya leyendo acerca de lugares
desconocidos en documentos históricos, artículos de revistas o libros, puede
buscarlos con Google Maps. De ese modo, es posible marcar numerosas ubicaciones
y explorar cómo se relacionan geográficamente entre sí. Sus mapas personales son
almacenados por Google (en su nube), lo cual quiere decir que podrá acceder a
ellos desde cualquier computadora con una conexión a internet. Puede
mantenerlos privados o incluirlos en su sitio web o blog. Por último, puede
exportar sus puntos, líneas y polígonos como archivos KML y abrirlos en Google
Earth o Quantum GIS.

### Comenzar

-   Abra su navegador favorito
-   Vaya a [Google My Maps](https://www.google.com/maps/d/)
-   Identifíquese con su cuenta de Google si no está conectado ya (en caso de
    ser necesario, siga las sencillas instrucciones para crear una cuenta)

{% include figure.html filename="geo-es1.png" caption="Figura 1" %}

-   Haga click en el signo de pregunta en la esquina inferior derecha y luego
    en Visita guiada para una introducción de cómo funciona My Maps.


{% include figure.html filename="geo-es2.png" caption="Figura 2" %}

-   En la esquina superior izquierda aparece un menú con el título "Mapa sin
    nombre". Haciendo click en el título lo puede renombrar como "Mi mapa de
    pruebas" o lo que prefiera.

-   Luego, puede utilizar la barra de búsqueda.
    Pruebe buscar una ubicación de su proyecto de investigación actual. Luego,
    puede clickear en la ubicación y agregarla a su mapa eligiendo "Agregar al
    mapa". Éste es el método más sencillo para agregar puntos a su nuevo mapa.
    Pruebe buscar algunos nombres de lugares históricos que ya no existen
    (como Berlin o Constantinople en Ontario). Obtendrá resultados mezclados,
    en los cuales Google a menudo identifica correctamente la ubicación pero
    también ofrece alternativas incorrectas. Esto es algo importante para tener
    en cuenta al crear una hoja de cálculos. Normalmente es preferible utilizar
    los nombres modernos de los lugares y evitar el riesgo de que Google elija
    la Constantinopla equivocada.

{% include figure.html filename="geo-es3.png" caption="Figura 3" %}

{% include figure.html filename="geo-es4.png" caption="Figura 4" %}

-   Luego, puede importar un set de datos. Haga click en "Importar" abajo de
    "Capa sin título".

{% include figure.html filename="geo-es5.png" caption="Figura 5" %}

-   Se abrirá una nueva ventana que le dará la opción de importar un archivo
    CSV (valores separados por coma), un XLSX (Microsoft Excel), un KML
    (formato de archivo para datos geográficos de Google) o GPX (un formato de
    archivo común para GPS). Los primeros dos son formatos comunes de hojas de
    cálculo. CSV es simple y universal y XLSX es el formato de MS Excel.
    También puede utilizar una hoja de cálculo de Google a través de su cuenta
    de Drive.

{% include figure.html filename="geo-es6.png" caption="Figura 6" %}

-   Descargue estos datos de ejemplo y guárdelos en su computadora
    [Archivos CSV del Suministro global de grasa de Reino Unido][].
    Si abre el archivo en Excel u otro programa de hojas de cálculo, encontrará
    un set de datos sencillo de dos columnas con una lista de diferentes tipos
    de grasas con los lugares asociados. Estos datos fueron construidos
    utilizando tablas de importaciones británicas de 1896.

{% include figure.html filename="geo-es7.png" caption="Figura 7" %}

-   Arrastre el archivo al recuadro provisto por Google Maps.
-   Se le pedirá que solicite qué columna debe utilizar Google para colocar
    las marcas de posición. Elija "Lugar".

{% include figure.html filename="geo-es8.png" caption="Figura 8" %}

-   Luego, se le solicitará que que elija qué columna debe ser utilizada para
    los marcadores. Elija "Producto".
-   Ahora debería tener un mapa global de los mayores exportadores de grasa a
    Gran Bretaña a mediados de la década de 1890.

{% include figure.html filename="geo-es9.png" caption="Figura 9: Click para ver imagen en tamaño completo" %}

-   Ahora puede explorar los datos en mayor detalle y modificar el Estilo para
    distinguir entre tipos diferentes de grasas.
-   Haga click en "Estilo uniforme", debajo de la etiqueta UK Global Fats y
    elija la opción "Estilo por columna de datos: Producto". A la izquierda,
    la leyenda mostrará la cantidad de ocurrencias de cada estilo entre
    paréntesis, por ejemplo: "Semillas de lino (4)".

{% include figure.html filename="geo-es10.png" caption="Figura 10" %}

{% include figure.html filename="geo-es11.png" caption="Figura 11" %}

-   Siga jugando con las opciones.
-   Esta funcionalidad es una herramienta poderosa para mostrar sets de datos
    históricos. Sin embargo, tiene límites, porque Google Maps sólo importa las
    primeras 100 líneas de una hoja de cálculos. Por el momento sólo permite
    incluir hasta tres sets de datos en un mapa, es decir, un máximos de 300
    items.

[//]: # PENDIENTE
{% include figure.html filename="geo12.png" caption="Figura 12" %}

### Crear capas de vectores

También puede crear nuevas capas del mapa (conocidos formalmente como capas
de vectores). Las capas de vectores son uno de los múltiples componentes del
mapeo digital (incluido SIG). Son, sencillamente, puntos, líneas o polígonos
utilizados para representar características geográficas. Los puntos pueden ser
empleados para identificar y etiquetar ubicaciones clave, las líneas se usan
a menudo para calles o vías ferroviaras, y los polígonos le permiten representar
áreas (campos, edificios, distritos, etc.). En Google Maps funcionan del mismo
modo en que lo hacen en SIG. La gran limitacion es que sólo se puede agregar
una cantidad limitada de información a las tablas de la base de datos asociadas
con puntos, líneas o polígonos. Esto se convierte en una dificultad a medida que
crece su investigación con mapas digitales, pero no es un problema cuando está
comenzando. En Google Maps puede agregar un marcador, un texto de descripción
y enlaces a un sitio web o una foto. Puede encontrar más información acerca
de cómo crear vectores históricos en un SIG completo en
[Creating New Vector Layers in QGIS 2.0][].

-   Para agregar una capa puede utilizar la que ya ha sido creada con el
    nombre "Capa sin título", haciendo click en ella y renombrándola a "Capa 1".
    O bien, puede crear otra capa: haga click en el botón de "Agregar capa".
    Esto creará una nueva "Capa sin título" que podrá renombrar como "Capa 2".
    Debería verse así:

{% include figure.html filename="geo-es13.png" caption="Figura 13" %}

-   Fíjese que a la izquierda de la capa hay una casilla de verificación:
    al desmarcarla se desactiva una capa (es decir, deja de verse en el mapa) y
    su información. Desmarque la capa de UK Global Fats y haga click en Capa 1.
-   Antes de agregar capas de vectores debemos considerar qué mapa base
    utilizar. Al final de la ventana del menú hay una línea que dice "Mapa
    base". Un mapa base es uno que muestra información de fondo como rutas,
    fronteras, accidentes geográficos, etc., sobre el cual se pueden ubicar
    capas con distintos tipos de información espacial. Google Maps le permite
    elegir entre una variedad de mapas base, dependiendo del tipo de mapa que
    desee crear. Las imágenes de satélite se están convirtiendo en un formato
    estándar para el mapa base, pero tiene mucha información y puede restarle
    valor a otros aspectos del mapa que uno quiera destacar. Hay algunas
    alternativas sencillas como "Físico claro" o incluso "Político claro", si
    necesita las divisiones políticas.

-   Haga click en la flecha a la izquierda de "Mapa base" en el menu. Se abrirá
    un submenú que le permitirá elegir diferentes tipos de mapas base. Elija
    "Satélite".

-   Comience agregando algunos Marcadores (el equivalente de Google de un punto).
    Haga click en el botón de agregar marcadores debajo de la barra de búsqueda
    en la parte superior de la ventana. Luego haga click en el lugar del mapa
    donde quiere que aparezca el marcador.

{% include figure.html filename="geo-es14.png" caption="Figura 14" %}

-   Aparecerá un recuadro que le dará la oportunidad de etiquetar el marcador y
    agregar una descripción en un campo de texto. Agregamos Charlottetown y
    anotamos en la descripción que fue fundada en 1765.

{% include figure.html filename="geo-es15.png" caption="Figura 15" %}

-   Agregue algunos puntos más, incluyendo etiquetas y descripciones.


[//]: # Aquí las opciones que ofrece Google Maps variaron respecto de la versión
[//]: # con la que se hizo el original en inglés.
-   Notará que su marcador ahora aparece bajo "Capa 1" a la izquierda de su
    pantalla en la ventana del menú. Allí hay una opción para modificar la forma
    y el color del ícono haciendo click en el símbolo ubicado a la derecha del
    nombre del marcador. Además, abajo del título "Capa 1" hay un link con el
    texto "Estilos individuales" que abre un menú que permite controlar
    distintos aspectos de la apariencia de la capa.

{% include figure.html filename="geo-es16.png" caption="Figura 16" %}

-   Ahora agregaremos algunas líneas y formas (llamados polígonos en el software
    de SIG). Agregar líneas y polígonos es un proceso bastante similar.
    Dibujaremos algunas líneas en una nueva capa (los diferentes tipos de puntos,

-   Seleccione la "Capa 2" en el menú (sabrá qué capa ha seleccionado por el
    borde azul a la izquierda del item).
-   Haga click en el ícono de "Trazar una línea" a la derecha del símbolo de
    marcador y luego en "Agregar línea o forma":

{% include figure.html filename="geo-es17.png" caption="Figura 17" %}

-   Elija una calle y haga click con su mouse a lo largo de ella, calcando un
    poco la ruta. Apriete "Enter" cuando quiera terminar la línea.

-   Nuevamente, aquí puede agregar una etiqueta (por ejemplo, ponerle nombre a
    una calle) e información descriptiva.
-   También puede cambiar el color y el grosor de la línea. Para hacer esto,
    busque la calle que acaba de dibujar en la Capa 2 en el menú y haga click
    a la derecha de su nombre.
-   You can also change the colour and width of the line. To do this,
    find the road you have drawn in Layer 2 in the menu box, and click
    to the right of the name of the road.

{% include figure.html filename="geo-es18.png" caption="Figura 18" %}

-   Para crear un polígono (una forma) puede conectar los puntos de la línea
    hasta alcanzar una forma cerrada. Para hacer esto, comience a dibujar y
    finalice haciendo click en el primer punto de su línea. Puede crear formas
    simples, como el campo de un granjero, u otras mucho más complejas, como
    los límites de una ciudad (ver ejemplos abajo). Siéntase libre de
    experimentar creando líneas y polígonos.

{% include figure.html filename="geo-es19.png" caption="Figura 19" %}

{% include figure.html filename="geo-es20.png" caption="Figura 20" %}

-   Como con los marcadors y líneas, puede cambiar el nombre y la descripción de
    un polígono. También puede cambiar el color y el ancho de la línea haciendo
    click en el ícono a la derecha del nombre de su polígono en el menú. Aquí
    también puede cambiar la transparencia, que será abordada a continuación.

-   Verá que el área comprendida por un polígono está sombreada con el mismo
    color que el borde. Puede cambiar la opacidad de esta sombra modificando la
    "transparencia", lo cual altera el punto hasta el cual puede ver claramente
    la imagen de fondo (su mapa base).
-  

### Compartir su mapa personalizado

-   La mejor manera de compartir el mapa online es utilizando el botón de
    **Compartir** en el menú. Éste provee un enlace que puede ser enviado por
    correo electrónico o mediante redes sociales como G+, Facebook o Twitter.

-   Otra forma de compartir una versión dinámica de su mapa es insertarlo en
    un blog o sitio web utilizando la opción "Insertar en mi sitio" del menú
    desplegable que se encuentra a la derecha del nombre del mapa.
    Al seleccionar esta opción se obtiene una etiqueta de marco incorporado o
    \<iframe\> que puede incluir en un sitio HTML. Puede modificar la altura y
    el ancho del marco cambiando los números entre comillas.

-   Nota: actualmente no hay forma de configurar la escala por defecto o las
    opciones de las leyendas de un mapa insertado, pero si necesita eliminar la
    leyenda del mapa que aparece en su sitio HTML puede hacerlo reduciendo el
    ancho del \<iframe\> a 580 o menos.

-   También puede exportar los datos a un archivo KML utilizando el mismo menú
    desplegable. Le dará la opción de exportar todo el mapa o seleccionar una
    capa en particular. Pruebe exportando la capa "Suministro global de grasa de
    Reino Unido". Podrá importar estos datos en otros programas, incluyendo
    Google Earth y Quantum GIS. Esta es una funcionalidad importante ya que
    significa que puede comenzar a trabajar con mapas digitales utilizando
    Google Maps y luego exportar su trabajo a una base de datos SIG en el futuro.

-   Puede finalizar la lección aquí si cree que el servicio gratuito de Google
    Maps le ofrece todas las herramientas que necesita para su tema de
    investigación. También puede continuar y aprender acerca de Google Earth y,
    en la lección 2, sobre Quantum GIS.

{% include figure.html filename="geo-es21.png" caption="Figura 21" %}

{% include figure.html filename="geo-es22.png" caption="Figura 22" %}

## Google Earth

Google Earth funciona en buena medida del mismo modo que Google Maps Engine Lite,
pero tiene funcionalidades adicionales. Por ejemplo, ofrece mapas 3D y acceso a
datos de numerosas fuentes de terceros, incluyendo colecciones de mapas
históricos. Google Maps no le solicita que instale software y sus mapas son
guardados en la nube. Google Earth, en cambio, debe ser instalado y no está
basado en la nube, aunque los mapas que cree pueden ser exportados.

-   Instale Google Earth: <http://www.google.com/earth/index.html>

-   Abra el programa y familiarísese con el globo terráqueo digital.
    Utilice el menú para agregar y quitar capas de información. Esto es muy
    similar al modo en que funcionan programas más avanzados de SIG. Puede
    agregar y sacar distinto tipo de informaciones geográficas incluyendo
    fronteras políticas (polígonos), rutas (líneas) y lugares (puntos). Vea las
    flechas rojas en la siguiente imagen para ver la ubicación de estas capas.

{% include figure.html filename="geo-es23.png" caption="Figura 23: Click para ver la imagen en tamaño completo" %}

-   Note que bajo el título "Capas" en el costado inferior izquierdo del margen
    de la ventana, Google ofrece una serie de capas listas para usar que pueden
    ser activadas seleccionando la casilla correspondiente.

{% include figure.html filename="geo-es24.png" caption="Figura 24" %}

-   Google Earth también incluye algunos mapas históricos escaneados y
    fotografías aéreas (en SIG este tipo de mapas, que están hechos de pixeles,
    se conocen como datos ráster). Dentro de "Galería" puede encontrar y
    seleccionar los mapas históricos de la colección Rumsey. Esto agregará
    íconos alrededor de todo el globo (con una mayor concentración en los
    Estados Unidos) de mapas escaneados que han sido georeferenciados (estirados
    y fijados para coincidir con una ubicación) sobre el globo terráqueo digital.
    Esto anticipa una metodología clave en los SIG históricos. (También puede
    encontrar capas de mapas históricos y otras capas SIG en la Galería de
    Google Earth). Tómese un tiempo para explorar algunos mapas históricos. Vea
    si hay algún mapa incluido en la colección Rumsey que pueda ser útil para su
    investigación o sus clases. (Puede encontrar muchos más mapas digitalizados
    pero no georeferenciados en [www.davidrumsey.com][].)

{% include figure.html filename="geo-es25.png" caption="Figura 25" %}

-   Posiblemente necesite hacer zoom para ver todos los íconos de mapas.
    ¿Puede encontrar el globo terráqueo de 1812?

{% include figure.html filename="geo-es26.png" caption="Figura 26" %}

-   Cuando hace click en un ícono se abre un panel de información. Haga click en
    la miniatura del mapa para verlo adherido al globo terráqueo digital.
    Aprenderá a georeferenciar mapas correctamente en [Georeferenciando en QGIS
    2.0][].

{% include figure.html filename="geo-es27.png" caption="Figura 27" %}

{% include figure.html filename="geo-es28.png" caption="Figura 28: Click para ver imagen en tamaño completo" %}

## KML: archivos de Keyhole Markup Language

-   Google desarrolló un formato de archivo para guardar y compartir datos de
    mapas: KML. Este acrónimo deriva de Keyhole Markup Language y es un tipo de
    archivo fácilmente portable (es decir que un KML puede ser utilizado en
    distintos tipos de software SIG) que puede almacenar muchos tipos diferentes
    de datos SIG, incluyendo vectores.

-   Los mapas e imágenes que cree en Google Maps y Google Earth pueden ser
    guardados como archivos KML. Esto quiere decir que puede guardar trabajo
    hecho en ambos programas. Utilizando archivos KML puede transferir datos
    entre las dos plataformas y llevar sus datos de mapa a Quantum GIS o ArcGIS.

-   Por ejemplo, puede importar los datos que creó en Google Maps Engine Lite.
    Si creó un mapa en el ejercicio anterior, puede encontrarlo haciendo click
    en "Mi mapa de prueba" en la página de inicio de [Maps Engine Lite][]. Haga
    click en el ícono con tres puntos a la derecha del título del mapa y luego
    seleccione "Exportar a KML". (También puede descargar y explorar el
    [mapa de la vía marítima][] de Dan Macfarlane para esta parte del ejercicio).

**Importar su archivo KML en Google Earth**

-   Descargue el archivo KML de Google Maps Engine Lite (como fue descripto
    arriba).
-   Haga doble click en el archivo KML en su carpeta de Descargas.
-   Busque los datos en la carpeta de "Lugares Temporales" de Google Earth.

{% include figure.html filename="geo-es29.png" caption="Figura 29: Click para ver imagen en tamaño completo" %}

-   Ahora puede explorar estos recursos cartográficos en 3D o puede agregar
    nuevas líneas, puntos y polígonos utilizando los distintos íconos ubicados
    en la parte superior izquierda de su ventana de Google Earth (ver imagen más
    abajo). Esto funciona esencialmente de la misma manera que en Google Maps,
    aunque hay mayores funcionalidades y opciones. En el mapa de la vía marítima
    de Dan, los viejos canales y la actual vía marítima fueron trazados con distintos
    colores y anchos de línea utilizando la herramienta de línea (esto fue
    posible superponiendo mapas históricos, lo cual se explica más abajo),
    mientras que varios recursos fueron señalados con los marcadores
    correspondientes. Para quienes les interese, también está la opción de
    grabar un viaje que podría ser útil para presentaciones o con fines didácticos
    (cuando se selecciona el ícono de "Guarda un viaje" las opciones de grabación
    aparecen en la sección inferior izquierda de la ventana).

{% include figure.html filename="geo-es30.png" caption="Figura 30" %}

-   Pruebe agregar un nuevo recurso a los datos de la vía marítima de Dan. Hemos
    creado un polígono (en la terminología de SIG, un polígono es una forma
    cerrada de cualquier tipo: un círculo, un hexágono o un cuadrado son todos
    ejemplos de polígonos) del lago St. Clair, que puede verse en la siguiente
    imagen. Busque el lago St. Clair (al este de Detroit) e intente agregar un
    polígono.

{% include figure.html filename="geo-es31.png" caption="Figura 31: Click para ver la imagen en tamaño completo" %}

{% include figure.html filename="geo-es32.png" caption="Figura 32" %}

-   Etiquete el nuevo recurso como Lago St Claire. Luego, puede arrastrarlo
    encima de los datos de la vía marítima de Dan y agregarlo a la colección.
    Puede guardar esta versión extendida del mapa de la vía marítima como un KML
    para compartir por correo electrónico, subirlo a Google Maps, o exportar
    estos datos a QGIS. Busque la opción de buscar haciendo click derecho en la
    colección de la vía marítima y elija "Guardar lugar como".

{% include figure.html filename="geo-es33.png" caption="Figura 33" %}

{% include figure.html filename="geo-es34.png" caption="Figura 34" %}

{% include figure.html filename="geo-es35.png" caption="Figura 35" %}

## Agregar mapas históricos escaneados

En Google Earth es posible utilizar una copia digital de un mapa histórico.
Este puede ser un mapa que ha sido escaneado o una imagen que ya está en formato
digital (para consejos sobre cómo encontrar mapas históricos online vea:
[Mobile Mapping and Historical GIS in the Field][]). El principal objetivo de
utilizar un mapa digital, desde un punto de vista histórico, es ubicarlo encima
de una imagen de Google Earth en el navegador. Esto se conoce como superposición
(*overlay*). Realizar superposiciones nos permite realizar comparaciones útiles
de los cambios a través del tiempo.

-   Comience identificando las imágenes que quiere utilizar: la imagen en Google
    Earth y el mapa que quiere superponer. Para esto último, el
    archivo puede ser en formato JPEG o TIFF, pero no PDF.

-   En Google Earth, identifique el área del mapa que donde quiere aplicar la
    superposición. Tenga en cuenta que puede ir atrás en el tiempo (i.e. ver
    fotos satelitales más antiguas) haciendo click en el ícono de "Mostrar
    imágenes históricas" en la barra superior y luego ajustando el control
    deslizable de la escala temporal que aparecerá.

{% include figure.html filename="geo-es36.png" caption="Figura 36" %}

{% include figure.html filename="geo-es37.png" caption="Figura 37" %}

-   Una vez que haya identificado las imágenes que quiere utilizar, haga click
    en el ícono de "Añadir superposición de imagen" en la barra superior.

{% include figure.html filename="geo-es38.png" caption="Figura 38" %}

-   Aparecerá una nueva ventaa. Comience poniéndole un título diferente si lo
    desea (por defecto es "Superposición de imágenes sin título").

{% include figure.html filename="geo-es39.png" caption="Figura 39: Click en la imagen para ver en tamaño completo" %}

-   Haga click en el botón "Examinar", a la derecha del campo "Vínculo", para
    seleccionar de sus archivos el mapa que desee que sea la imagen a superponer.

-   Corra la ventana de "Nueva Superposición de Imágenes" (no la cierre ni
    haga click en "Cancelar" o "Aceptar") para poder ver el navegador de Google
    Earth. El mapa que subió aparecerá sobre la imagen satelital de Google Earth
    en el navegador.

-   Hay marcadores de verde fosforescente en el medio y en los bordes del mapa
    subido. Éstos pueden ser utilizados para estirar, achicar y mover el mapa
    para que se alinee correctamente con la imagen del satélite. Éste es un modo
    sencillo de georeferenciar (vea [Georeferencing in QGIS 2.0][]). La imagen
    de abajo muestra los pasos anteriores utilizando un viejo mapa de la ciudad
    de Aultsville superpuesto a imágenes satelitales de Google de 2008 en el
    cual se pueden ver los restos de las calles y los cimientos de los edificios
    en el río St. Lawrence (Aultsville fue uno de los "pueblos perdidos" que
    fueron inundados por el proyecto de Vía Marítima y Energía de St. Lawrence).

{% include figure.html filename="geo-es40.png" caption="Figura 40: Click en la imagen para ver en tamaño completo" %}

-   Volviendo a la ventana de "Nueva Superposición de Imágenes", vea que hay una
    serie de opciones que puede seleccionar ("Descripción", "Ver", "Altitud",
    "Actualizar", "Ubicación"). En esta instancia probablmente no necesite
    preocuparse por ellas, pero quizás quiera agregar información bajo la
    pestaña de Descripción.

-   Una vez que esté satisfecho con su superposición, haga click en "Aceptar" en
    la esquina inferior derecha de la ventana de "Nueva Superposición de
    Imágenes".

-   Es importante guardar su trabajo. En "Archivo", en la barra del menú tiene
    dos opciones. Puede guardar una copia de la imagen (Archivo -\> Guardar -\>
    Guardar imagen...) que ha creado en su computadora en formato JPG y también
    puede guardar la superposición de Google Earth para poder acceder a ella en
    el futuro (Archivo -> Guardar -> Guardar en Mis Sitios). Esta última es
    guardada como un archivo KML.

-   Para compartir archivos KML simplemente ubique el archivo que guardó en su
    computadora y súbalo a su sitio web, perfil de redes sociales o envíelo como
    adjunto en un correo electrónico.

**Ya aprendió a utilizar Google Maps y Google Earth. ¡Asegúrese de guardar su
trabajo!**

*Esta lección es parte de [Geospatial Historian][].*

  [Google Maps Engine Lite]: https://mapsengine.google.com
  [geo-es1]: /images/intro-a-google-maps-y-google-earth/geo-es1.png
  [geo-es2]: /images/intro-a-google-maps-y-google-earth/geo-es2.png
  [geo-es3]: /images/intro-a-google-maps-y-google-earth/geo-es3.png
  [geo-es4]: /images/intro-a-google-maps-y-google-earth/geo-es4.png
  [geo-es5]: /images/intro-a-google-maps-y-google-earth/geo-es5.png
  [geo-es6]: /images/intro-a-google-maps-y-google-earth/geo-es6.png
  [Archivos CSV del Suministro global de grasa de Reino Unido]: https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/Suministro global de grasa de Reino Unido 1894-1896.zip
  [geo-es7]: /images/intro-a-google-maps-y-google-earth/geo-es7.png
  [geo-es8]: /images/intro-a-google-maps-y-google-earth/geo-es8.png
  [geo-es9]: /images/intro-a-google-maps-y-google-earth/geo-es9.png
  [geo-es10]: /images/intro-a-google-maps-y-google-earth/geo-es10.png
  [geo-es11]: /images/intro-a-google-maps-y-google-earth/geo-es11.png
  [geo-es12]: /images/intro-a-google-maps-y-google-earth/geo-es12.png
  [Creating New Vector Layers in QGIS 2.0]: /lessons/vector-layers-qgis
  [geo-es13]: /images/intro-a-google-maps-y-google-earth/geo-es13.png
  [geo-es14]: /images/intro-a-google-maps-y-google-earth/geo-es14.png
  [geo-es15]: /images/intro-a-google-maps-y-google-earth/geo-es15.png
  [geo-es16]: /images/intro-a-google-maps-y-google-earth/geo-es16.png
  [geo-es17]: /images/intro-a-google-maps-y-google-earth/geo-es17.png
  [geo-es18]: /images/intro-a-google-maps-y-google-earth/geo-es18.png
  [geo-es19]: /images/intro-a-google-maps-y-google-earth/geo-es19.png
  [geo-es20]: /images/intro-a-google-maps-y-google-earth/geo-es20.png
  [geo-es21]: /images/intro-a-google-maps-y-google-earth/geo-es21.png
  [geo-es22]: /images/intro-a-google-maps-y-google-earth/geo-es22.png
  [geo-es23]: /images/intro-a-google-maps-y-google-earth/geo-es23.png
  [geo-es24]: /images/intro-a-google-maps-y-google-earth/geo-es24.png
  [www.davidrumsey.com]: http://www.davidrumsey.com/
  [geo-es25]: /images/intro-a-google-maps-y-google-earth/geo-es25.png
  [geo-es26]: /images/intro-a-google-maps-y-google-earth/geo-es26.png
  [Georeferencing in QGIS 2.0]: /lessons/georeferencing-qgis
  [geo-es27]: /images/intro-a-google-maps-y-google-earth/geo-es27.png
  [geo-es28]: /images/intro-a-google-maps-y-google-earth/geo-es28.png
  [Maps Engine Lite]: https://mapsengine.google.com/map/
  [mapa de la vía marítima]: https://github.com/programminghistorian/jekyll/files/148993/seaway.zip
  [geo-es29]: /images/intro-a-google-maps-y-google-earth/geo-es29.png
  [geo-es30]: /images/intro-a-google-maps-y-google-earth/geo-es30.png
  [geo-es31]: /images/intro-a-google-maps-y-google-earth/geo-es31.png
  [geo-es32]: /images/intro-a-google-maps-y-google-earth/geo-es32.png
  [geo-es33]: /images/intro-a-google-maps-y-google-earth/geo-es33.png
  [geo-es34]: /images/intro-a-google-maps-y-google-earth/geo-es34.png
  [geo-es35]: /images/intro-a-google-maps-y-google-earth/geo-es35.png
  [Mobile Mapping and Historical GIS in the Field]: http://niche-canada.org/2011/12/14/mobile-mapping-and-historical-gis-in-the-field/
    "Mobile Mapping and Historical GIS in the Field"
  [geo-es36]: /images/intro-a-google-maps-y-google-earth/geo-es36.png
  [geo-es37]: /images/intro-a-google-maps-y-google-earth/geo-es37.png
  [geo-es38]: /images/intro-a-google-maps-y-google-earth/geo-es38.png
  [geo-es39]: /images/intro-a-google-maps-y-google-earth/geo-es39.png
  [geo-es40]: /images/intro-a-google-maps-y-google-earth/geo-es40.png
  [Geospatial Historian]: http://geospatialhistorian.wordpress.com/
