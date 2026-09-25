---
title: "Instalación de QGIS 3.44 y adición de capas"
slug: qgis-capas
original: qgis-layers
layout: lesson
collection: lessons
date: YYYY-MM-DD
translation_date: YYYY-MM-DD
authors:
- Jim Clifford
- Josh MacFadyen
- Daniel Macfarlane
reviewers:
- Finn Arne Jørgensen
- Sarah Simpkin
editors:
- Adam Crymble
translator:
- Eduardo Godoy Yáñez
translation-editor:
- Forename Surname
translation-reviewer:
- Forename Surname
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/XXX
difficulty: 1
activity: presenting
topics: [mapping]
next: 
previous: 
series_total: 
sequence:  
abstract: En esta lección instalará el software QGIS, descargará archivos geoespaciales de la región latinoamericana como shapefiles y GeoTIFFs, y creará un mapa a partir de varias capas vectoriales y ráster.
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Objetivos de la lección

En esta lección, instalarás el software QGIS, descargarás archivos geoespaciales de la región latinoamericana como _shapefiles_ y _GeoTIFFs_, y crearás un mapa a partir de varias capas vectoriales y ráster. Quantum o QGIS es una alternativa de código abierto al software líder del sector, ArcGIS de ESRI. QGIS es un programa multiplataforma, lo que significa que funciona en Windows, Mac y Linux, y cuenta con muchas de las funciones más utilizadas por los historiadores. ArcGIS es prohibitivamente caro y solo funciona en Windows (aunque se puede comprar software para que funcione en Mac). Sin embargo, muchas universidades tienen licencias institucionales, lo que significa que los estudiantes y empleados tienen acceso a copias gratuitas del software (intenta contactar con el bibliotecario de mapas, el servicio informático o el departamento de geografía de tu universidad).

QGIS es ideal para quienes no tienen acceso a una copia gratuita de ArcGIS y también es una buena opción para aprender habilidades básicas de SIG (Sistemas de Información Geográfica) y decidir si quieres instalar una copia de ArcGIS en tu ordenador. Además, cualquier trabajo que realices en QGIS se exportar a ArcGIS posteriormente si decides actualizar tu software. Los autores suelen usar ambos y se sientes cómodos ejecutando QGIS en ordenadores Mac y Linux para tareas básicas, pero vuelven a ArcGIS para trabajos más avanzados. En muchos casos, no es la falta de funciones, sino los problemas de estabilidad los que pueden llevarlos de vuelta a ArcGIS. Para quienes estén aprendiendo Python con Programming Historian, les alegrará saber que tanto QGIS como ArcGIS utilizan Python como su principal lenguaje de scripting.

## Instalación de QGIS

Diríjase a la [página de descarga de QGIS](https://qgis.org/). El procedimiento varía ligeramente según tu sistema operativo. Haga clic en el sistema operativo correspondiente. Siga las instrucciones a continuación.

## Instrucciones para Windows

 - Diríjase a la [web de QGIS](https://qgis.org/), en la sección “Long Term Release”, haga clic en el banner para descargar la versión 3.44 de QGIS, que es la versión estabilizada del software más actualizada. Usualmente, las versiones más nuevas incluyen herramientas de desarrollo reciente que no son necesarias para el trabajo histórico.

{% include figure.html filename="es-tr-qgis-capas-01.png" alt="Visual description of figure image" caption="Figura 1. Caption text to display" %}


 - A continuación, el archivo se comenzará a ejecutar. Si tiene su ordenador configurado previamente, podrá seleccionar en qué carpeta guardar el instalador antes de que comience la descarga. Es recomendable organizar todos los archivos relativos a QGIS dentro de una misma carpeta.
 
QGIS es muy fácil de instalar en la mayoría de las versiones de Linux. Siga las instrucciones de la página de descarga.

## Datos de la Isla de Pascua

En esta adaptación de la lección, utilizaremos datos públicos generados por organismos del estado chileno relativos a la Isla de Pascua (IP). La Isla de Pascua es un excelente y muy interesante ejemplo para esta lección porque hay suficientes datos disponibles gratuitamente en línea y, al ser la provincia más pequeña de Chile ¡las descargas son rápidas! Es importante tener en cuenta que es posible que los datos geoespaciales de la región latinoamericana no serán tan robustos o de fácil acceso como los de países del norte global, de modo que es fundamental tener esto en cuenta a la hora de seleccionar y planificar su proyecto SIG. Sin embargo, esta misma limitación puede llevar a usos más creativos y críticos del material disponible.

 - Descargue los siguientes archivos shapefiles y ráster de PI.
   - [Línea Costera Isla de Pascua](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/qgis-capas/linea-costera-ip.zip)
   - [Polígono Isla de Pascua](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/qgis-capas/poligono-ip.zip)
   - [Vías Isla de Pascua](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/qgis-capas/vias-ip.zip)
   - [Sitios Moais Isla de Pascua](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/qgis-capas/moais-ip.zip)
   - [Uso de tierra Isla de Pascua](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/qgis-capas/uso-tierra-ip.zip)
   - [Isla de Pascua 1953](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/qgis-capas/isla-de-pascua-1953.tif)

Luego de descargar los siete archivos, muévalos a una carpeta y descomprímalos. Se sugiere nombrar su carpeta de trabajo como “Lección 2 QGIS”, en ella debe guardar toda la documentación de este proyecto. Examine el contenido de las carpetas. Observará cuatro archivos con el mismo nombre, pero de diferentes extensiones. Al acceder a estas carpetas desde QGIS, verá que sólo necesita hacer clic en el archivo .shp y que los otros tres formatos admiten este archivo en segundo plano, sin esto archivos, el archivo .shp no funcionará. Es importante, al mover archivos en su ordenador, mantener siempre los cuatro archivos juntos. Por este motivo, los archivos shapefile se suele compartir mediante compresión ZIP. Recuerde aguardar ordenadamente y a la vista sus carpetas descomprimidas, ya que las necesitará en QGIS en unos minutos.

## Cómo empezar tu proyecto SIG

Abra QGIS. Lo primero que debe hacer es configurar correctamente el “Sistema de Referencia de Coordenadas” (SRC). El SRC es la proyección cartográfica, y las proyecciones son las diferentes formas de representar lugares del mundo real en mapas bidimensionales. El valor predeterminado es WGS84 (esta proyección se ha vuelto la de uso más común al ser compatible con softwares como Google Earth), pero dado que la mayoría de nuestros datos y ejemplos son creados por organismos estatales chilenos, recomendamos utilizar SIRGAS-Chile 2021 (Sistema de Referencia Geocéntrico para las Américas) que para el contexto chileno es generado por el Instituto Geográfico Militar (IGM). Para obtener más información sobre SIRGAS-Chile 2021 consulte el [sitio web de SIRGAS](https://www.sirgaschile.cl/) perteneciente al IGM. La Isla de Pascua (IP) es parte de la proyección de SIRGAS-Chile 2021, de modo que trabajaremos con este SRC. Administrar el SRC de diferentes capas de información y asegurarse de que funcionen correctamente es uno de los aspectos más complicados de los SIG para principiantes. Sin embargo, con un poco de costumbre se volverá una tarea simple y mecánica. Además, si el software esta correctamente configurado, debería convertir el SRC y permitirle trabajar con datos importados de diferentes fuentes. Seleccione “Configuración” en la barra superior de la interfaz de QGIS.

 - Windows: “Nuevo Proyecto” > “Configuración” > “Opciones”.

{% include figure.html filename="es-tr-qgis-capas-02.png" alt="Visual description of figure image" caption="Figura 2. Caption text to display" %}


 - En el panel izquierdo, seleccione “Manejo de SRC”.

La ventana “Manejo de SRC” se divide verticalmente en tres secciones (“SRC para proyectos”; “SRC para capas”; y “Advertencia de precisión”). Para configurar su software debe dirigirse a la primera de estas secciones y seleccionar “Usar un SRC predeterminado” (la segunda opción). Esto le ayudará a personalizar su espacio de trabajo en QGIS si es que piensa desarrollar varios proyectos de una misma zona geográfica. En caso contrario, siempre puede cambiar el SRC desde esta misma sección en función de su proyecto en curso. Es fundamental que este siempre sea su primer paso al trabajar en QGIS.

 - Haga clic en el ícono de la derecha “Seleccionar SRC” como se muestra en la Figura 3.
 
{% include figure.html filename="es-tr-qgis-capas-03.png" alt="Visual description of figure image" caption="Figura 3. Caption text to display" %}


A continuación emergerá una nueva ventana llamada “Coordinate Reference System Selector” (Figura 4). En esta sección podrá definir qué SRC establecerá para su proyecto. Esta ventana, a su vez, se divide verticalmente en tres secciones: un “buscador” en la parte superior y a continuación una sección llamada “Sistema de Referencia de Coordenadas Usados Recientemente” y otra llamada “Sistemas de Referencia de Coordenadas Predefinidos”. Antes de buscar nuestro SRC es importante explicar que los Coordinate Reference System  (SRC) se dividen en varios subgrupos entre los que destacan los sistemas _Geographic (2D)_ y _Geographic (3D)_. La principal diferencia entre ambos es que uno permite gestionar y proyectar objetos en dos dimensiones (Latitud Y; y Longitud X), mientras que el otro añade una tercera dimensión (Altura elipsoidal Z) para la representación de objetos tridimensionales. En este proyecto, y en el trabajo de investigación histórica convencional se representarán sólo objetos bidimensionales, de modo que es más preciso establecer un SRC de la categoría _Geographic (2D)_.

 - En el buscador introduzca “20041”; esto le llevará rápidamente al mejor sistema de referencia de coordenadas para la Isla de Pascua.
 - En la sección “Sistema de Referencia de Coordenadas Usados Recientemente” seleccione “EPSG:20041 – SIRGAS-Chile 2021” y haga clic en aceptar.

{% include figure.html filename="es-tr-qgis-capas-04.png" alt="Visual description of figure image" caption="Figura 4. Caption text to display" %}


Observe que la proyección ha cambiado en la esquina inferior derecha de la interfaz de QGIS, ahora debe decir “EPSG:20041”.

 - En barra superior haga clic en Proyecto y luego en Guardar en la carpeta del proyecto previamente creada (es importante guardar su proyecto después de cada paso)

Ya está todo listo para trabajar en el proyecto del tutorial, pero es posible que tenga algunas preguntas sobre qué SRC usar para su propio proyecto. Si no está seguro de cuál utilizar, WGS83 (World Geodetic System) podría funcionar a corto plazo, especialmente si trabaja a gran escala, pero será difícil trabajar con precisión en mapas locales. Un consejo es averiguar qué SRC o proyección se utiliza en los mapas impresos de la región. Si va a escanear un mapa impreso de buena calidad para usarlo como capa base, podría ser buena idea usar la misma proyección. También puede buscar en internet el SRC más común para una región en particular. Incluso, la misma ventana de SRC de QGIS le permitirá ver dentro de un recuadro rojo qué territorio cubre cada sistema de proyección (ver Figura 4). Para la región latinoamericana los sistemas SIRGAS suelen ser la mejor opción. Aquí tiene algunos enlaces a otros recursos que le ayudarán a elegir un SRC para su proyecto: [Trabajar con proyecciones en QGIS](https://docs.qgis.org/3.44/es/docs/user_manual/working_with_projections/working_with_projections.html).

## Construyendo un mapa base

Ahora que tu ordenador está funcionando correctamente, es hora de añadir información comprensible para los humanos. Tu proyecto debería comenzar con un mapa base, o una selección de información geoespacial que permita a tus lectores reconocer elementos del mundo real en el mapa. Para la mayoría de los usuarios, esto consistirá en varias capas de datos vectoriales y ráster, que se pueden reorganizar, colorear y etiquetar de forma que resulten comprensibles para tus lectores y se ajusten a los objetivos de tu proyecto. Una función relativamente nueva en muchos programas SIG es la disponibilidad de mapas base predefinidos, pero dado que esta tecnología está en desarrollo para plataformas de código abierto como QGIS, en este módulo te mostraremos cómo crear tu propio mapa base añadiendo capas vectoriales y ráster. Si quieres añadir mapas base predefinidos a QGIS, puedes instalar el plugin “QuickMapService” en la barra superior de herramientas diríjase a “Complementos” > “Administrar e instalar complementos…”. Emergerá una ventana llamada “Complementos” que se divide verticalmente en tres secciones. En el panel de la izquierda haga clic en “Todos” y luego escriba “QuickMapService” en el buscador; en el panel lateral derecho se desplegarán los detalles del Plugin, haga clic en “instalar complemento” o “actualizar complemento” según el caso de su software.

{% include figure.html filename="es-tr-qgis-capas-05.png" alt="Visual description of figure image" caption="Figura 5. Caption text to display" %}


Una vez instalado encontrará la herramienta de “QuickMapService” en la derecha del menú superior de su interfaz de trabajo (Figura 6). Pruebe instalar algunas de las capas de Google y OpenStreetMap. Al momento de escribir la actualización este curso, la función de mapas preestablecidos “QuickMapService” reemplazó al complemento original “OpenLayer” que ya no se encuentra disponible. Además, tenga en cuenta que los mapas preestablecidos pueden ralentizar su equipo si es que no tiene suficiente memoria de trabajo. “QuickMapService” no presenta problemas de funcionamiento en las versiones más actuales de Windows. Puede probar con estos mapas y explorar por su cuenta para ponderar nuevas opciones de visualización para sus proyectos. Recuerde que la proyección de estos mapas globales puede que no sea corregida automáticamente, por lo que las imágenes satelitales podrían no estar siempre sincronizadas con los dato proyectados en un sistema de coordenadas diferente.

{% include figure.html filename="es-tr-qgis-capas-06.png" alt="Visual description of figure image" caption="Figura 6. Caption text to display" %}


## Vectores de Apertura

Los SIG utilizan puntos, líneas y polígonos también conocidos como datos vectoriales. Su primera función de estas herramientas es organizar estos puntos, líneas y polígonos y proyectarlos con precisión en mapas. Lo puntos pueden representar pueblos u oficinas gubernamentales; las líneas, ríos, caminos, vías férreas; y los polígonos, parcelas agrícolas, propiedades urbanas o límites políticos más amplios. Sin embargo, también es posible vincular datos históricos a estos lugares geográficos y estudiar cómo las personas interactuaron con su entorno físico y lo modificaron. La población de los pueblos cambió, los ríos cambiaron de curso, las parcelas se subdividieron, los viejos caminos se reorientaron y la tierra se cultivó con diversos productos.

 - En la barra superior de herramientas, al hacer clic en “Capa”, seleccione “Añadir capa” > “Añadir capa vectorial…”.

{% include figure.html filename="es-tr-qgis-capas-07.png" alt="Visual description of figure image" caption="Figura 7. Caption text to display" %}

Emergerá una ventana llamada “Administrador de fuentes de datos”. El panel “Vectorial” se divide horizontalmente en dos secciones (“Tipo de Fuente” y “Fuente”).

 - En “Tipo de Fuente” seleccione la opción “archivo”. La codificación debe mantenerse en la opción “automática”.
 - En la sección “Fuente” haga clic en el ícono de tres punto a la derecha de la barra “Conjunto(s) de datos vectoriales".

Emergerá una ventana que mostrará las carpetas de su escritorio. Diríjase a la carpeta de trabajo en la que previamente descargó los archivos de la lección.

{% include figure.html filename="es-tr-qgis-capas-08.png" alt="Visual description of figure image" caption="Figura 8. Caption text to display" %}


 - Busque la carpeta “Polígono_IP” y seleccione el archivo .shp correspondiente. Haga clic en “abrir”.

A continuación en el panel “Administrado de fuentes de datos” en la sección “Vectorial” aparecerá una tercera sección llamada “Opciones”, no modifique ninguna de las opciones de configuración que ofrece.

 - Haga clic en “añadir” y luego en “cerrar”.

Volverá a su interfaz de trabajo y se visualizará el mapa de la Isla de Pascua, si el color de su polígono es diferente, no se preocupe, QGIS lo modifica automáticamente conforme al añadir nuevas capas vectoriales, veremos rápidamente cómo cambiar el color del polígono.

{% include figure.html filename="es-tr-qgis-capas-09.png" alt="Visual description of figure image" caption="Figura 9. Caption text to display" %}


En el panel izquierdo de su interfaz de QGIS llamado “Capas” usted verá todas las capas vectoriales o ráster que incluya en su proyecto. En este punto sólo debería aparecer la capa del polígono de Isla de Pascua.

 - Haga clic derecho sobre la capa, se desplegará un menú de opciones. Haga clic en “Estilos” al final del menú. Aparecerá una paleta de colores en la que usted podrá escoger el color de su polígono (Figura 10).

{% include figure.html filename="es-tr-qgis-capas-10.png" alt="Visual description of figure image" caption="Figura 10. Caption text to display" %}


Felicitaciones! Ahora que ha cargado y editado el color de su primera capa vectorial con éxito, podemos continuar.

 - Seleccione “Añadir capa vectorial…” nuevamente.
 - Repita los pasos anteriores para buscar la carpeta "Línea_costera_IP"
 - Busque y seleccione el archivo shapefile correspondiente.

Acaba de cargar una capa del la línea costera de la Isla de Pascua. Ahora vamos a resaltar su color sobre la zona delimitada por el polígono.

 - Haga clic derecho y diríjase a “Estilo".
 - Busque y seleccione un color terracota que resalte la línea costera sobre el borde del polígono verde.

Ahora, para darle mayor fuerza visual editaremos el tipo de línea del borde costero.

{% include figure.html filename="es-tr-qgis-capas-11.png" alt="Visual description of figure image" caption="Figura 11. Caption text to display" %}


 - Haga doble clic izquierdo sobre la capa correspondiente en el panel izquierdo de su interfaz de trabajo. Emergerá la ventana “Propiedades de capa".
 - En el panel izquierdo de esta ventana seleccione el apartado “Simbología”. Este panel le permitirá ajustar el estilo de su atributo vectorial, en este caso editaremos la línea costera.
 - A continuación edite la anchura de la línea a 1,06000 en valor de milímetros.
 - Escoja el estilo de línea “dash red” para que su línea se vea punteada y haga clic en aceptar (Figura 11).

Ahora su mapa debería verse así:

{% include figure.html filename="es-tr-qgis-capas-12.png" alt="Visual description of figure image" caption="Figura 12. Caption text to display" %}


Ahora que sabe cómo personalizar este atributo vectorial, vuelva a editar la línea costera de la isla y déjela como una línea continua. Es momento de complejizar nuestro mapa de la Isla de Pascua.

 - Seleccione “Añadir capa vectorial…” nuevamente.
 - Busque en su carpeta de trabajo la carpeta “Uso_tierra_IP".
 - Explore la carpeta y seleccione el archivo shapefile correspondiente.

Esto añadirá un mapa detallado de los diferentes usos de tierra en la Isla de Pascua en la actualidad. No obstante, al cargar la capa, la visualización sólo mostrará las diferentes zonas delimitadas por líneas pero no por colores, tal como se ve en la Figura 13.

{% include figure.html filename="es-tr-qgis-capas-13.png" alt="Visual description of figure image" caption="Figura 13. Caption text to display" %}


Ahora, para poder diferenciar las distintas categorías del uso de suelo, deberá modificar la simbología para representarlas con diferentes colores. Necesitaremos saber qué columna de las tablas de la base de datos contiene la información sobre la categoría de uso de suelo, por lo que el primer paso es abrir e inspeccionar la tabla de atributos.

 - Diríjase al panel izquierdo de su interfaz de trabajo y haga clic derecho sobre la capa cbn_isladepascua_2019.
 - En el menú que se despliega seleccione “Abrir tabla de atributos".

Emergerá una ventana con el detalle de los elementos que integran la capa. Esta ventana se divide en dos secciones, una panel izquierdo en el que se desglosa los nombres de las categorías, las que en este caso no detallan sus atributos, y un panel derecho en el que podrá revisar todos los detalles de cada uno de estos atributos. Pero hay una forma de visualizar estas categorías conjuntamente.

 - Sobre el panel izquierdo haga clic en “NOM_REGION".
 - De desplegará un menú, seleccione “Columns”, la segunda opción desde arriba.

{% include figure.html filename="es-tr-qgis-capas-14.png" alt="Visual description of figure image" caption="Figura 14. Caption text to display" %}


Verá que aparecen todas las categorías de la capa. Entre ellas se encuentra la que nos interesa y nos proporcionará información bastante detallada sobre la distribución en los diversos usos de la tierra en la Isla de Pascua en la actualidad.

 - A continuación cierre la “Tabla de atributos” y haga clic con el botón derecho en la capa cbn_isladepascua_2019 nuevamente y esta vez elija “Propiedades”.
 - En esta ventana emergente diríjase a la parte superior donde dice “Símbolo único", haga clic en “Categorizado".

{% include figure.html filename="es-tr-qgis-capas-15.png" alt="Visual description of figure image" caption="Figura 15. Caption text to display" %}


A continuación están tres secciones (“Valor”, “Símbolo” y Rampa de color”).

 - Despliegue la sección “Valor” y busque la categoría “Uso_tierra".
 - Seleccione esta categoría y más abajo haga clic en “Clasificar".

En este punto se habrá desplegado cada uno de los usos de tierra de la categoría indicando su color y nombre específico como se aprecia en la Figura 16.

 - Haga clic en “aceptar".

{% include figure.html filename="es-tr-qgis-capas-16.png" alt="Visual description of figure image" caption="Figura 16. Caption text to display" %}


 - En el panel izquierdo de su interfaz de QGIS en donde se detallan las capas, haga clic en la pequeña flecha que aparece a la izquierda de cbn_isladepascua_2019 para desplegar la leyenda de la capa.
 - Ahora puede ver los distintos usos de tierra en la Isla de Pascua. Haga zoom a la interfaz e inspeccione los diferentes usos de tierra.

Ahora tiene una visualización de la Isla de Pascua mucho más compleja y que abre una serie de interrogantes y oportunidades de análisis. Su mapa variará en la distribución de colores al de esta lección, no se preocupe, QGIS siempre alterará esto y usted podrá cambiarlo con las herrmientas de edición previamente vistas.

{% include figure.html filename="es-tr-qgis-capas-17.png" alt="Visual description of figure image" caption="Figura 17. Caption text to display" %}


Para poder volver a ver la isla completa puede reajustar el zoom con su ratón o, en cambio, hacer clic derecho sobre cualquiera de las capas y seleccionar “Zoom a la capa(s)”.

{% include figure.html filename="es-tr-qgis-capas-18.png" alt="Visual description of figure image" caption="Figura 18. Caption text to display" %}


A continuación, añadiremos una capa que muestre la red de carreteras.

 - Diríjase a la barra superior de herramientas de su interfaz de QGIS, seleccione “Añadir capa vectorial…”.
 - Examine su carpeta de trabajo y busque la carpeta “Vías_IP".
 - Ingrese a esta carpeta y seleccione el archivo shapefile correspondiente.

Ahora, su panel lateral debe incluir la capa de carreteras.

 - Haga doble clic izquierdo sobre la capa “Vías_IP".
 - En la ventana emergente “Propiedades de capa” seleccione “Simbología” en el panel lateral izquierdo.
 - En la parte superior de la ventana haga clic en “Símbolo único” y luego seleccione “Categorizado".
 - En la sección “Valor” seleccione la primera opción llamada “ROL".
 - A continuación, diríjase a la parte inferior de la ventana y haga clic en “Clasificar".

{% include figure.html filename="es-tr-qgis-capas-19.png" alt="Visual description of figure image" caption="Figura 19. Caption text to display" %}


Verá cómo se despliega el conjunto de vías de la capa identificadas por colores.

 - Haga clic en “Aceptar” y ahora verá en su interfaz de QGIS el desglose de las principales carreteras de Isla de Pascua por tramos señalados por colores.
 - Vuelva a la ventana “Propiedades” de la capa, en la sección “Simbología".
 - En la sección “Símbolo” haga doble clic izquierdo sobre la línea de color.

Emergerá una ventana que tendrá el nombre del tramo de carretera seleccionado, en este caso será “IPA1”. Aquí podrá editar la línea tal como lo hizo anteriormente con el borde costero.

 - En anchura establezca la medida de 0,46000 en milímetros.
 - Repita la misma acción para “IPA2”, “IPA3” e “IPA4".
 - Haga clic en “aceptar".

{% include figure.html filename="es-tr-qgis-capas-20.png" alt="Visual description of figure image" caption="Figura 20. Caption text to display" %}


De vuelta en la ventana “Propiedades de capa” haga clic en “aceptar”. Ahora se encuentra en su interfaz de visualización del mapa.

 - Seleccione la flecha negra a un costado izquierdo de la capa “Vías Isla de Pascua” y se habrá desplegado el detalle de estos caminos.
 - Sólo deje marcados los tramos “IPA1”, “IPA2”, “IPA3” e “IPA4”. Desmarque el resto de los tramos y podrá visualizar los principales tramos de carretera de la isla.
 - Ahora haga clic derecho sobre cada uno de estos atributos en el panel izquierdo de capas de su interfaz de QGIS, y designe un mismo color para las cuatro vías.

Si deselecciona la capa de usos de tierra “cbn_isladepascua_2019”, debería ver los principales tramos de carretera de Isla de Pascua. Puede probar seleccionando y deseleccionando capas en el panel izquierdo de su interfaz de QGIS y comenzar a hacerse preguntas sobre la configuración del territorio insular, su infraestructura y el uso de su suelo.

{% include figure.html filename="es-tr-qgis-capas-21.png" alt="Visual description of figure image" caption="Figura 21. Caption text to display" %}


Ahora añadamos más datos vectoriales al proyecto, esta vez en forma de puntos.

 - En la barra superior de herramientas de su interfaz de QGIS, seleccione “Añadir capa vectorial...".
 - Inspeccione la carpeta de trabajo del proyecto y abra la carpeta “Moais_IP".
 - Dentro de la carpeta seleccione el archivo shapefile correspondiente.
 - En el panel izquierdo de capas de su interfaz, haga doble clic en la capa “Moais".
 - A continuación, haga clic derecho sobre la capa y en el menú desplegado seleccione propiedades, luego en el panel izquierdo de la ventana emergente seleccione “Etiquetas”, justo debajo de “Simbología”. En la parte superior de la ventana donde dice “Sin etiquetas”, haga clic y seleccione “Etiquetas sencillas".
 - Abajo en la sección “Valor”, despliegue las opciones y seleccione “Nom_Moai".

{% include figure.html filename="es-tr-qgis-capas-22.png" alt="Visual description of figure image" caption="Figura 22. Caption text to display" %}


 - Cambie el tamaño de la fuente a 11,0000.
 - Cambie el tipo de letra a “Nirmala UI Semilight".
 - Haga clic en “aceptar” y examine los resultados en el mapa.

{% include figure.html filename="es-tr-qgis-capas-23.png" alt="Visual description of figure image" caption="Figura 23. Caption text to display" %}


 - El etiquetado es donde QGIS se queda muy corto en comparación con la cartografía real: requerirá ajustes para mostrar el nivel de detalle deseado en una presentación. Intente volver a la ventana “Propiedades”, en las secciones “Simbología” y “Etiquetas” y modifique las diferentes configuraciones de las capas del proyecto para ver cómo cambiar los símbolos y las visualizaciones.

Tenga en cuenta que en el panel lateral izquierdo de su interfaz de QGIS puede añadir y eliminar las distintas capas que hemos agregado al mapa, de forma similar a como lo hacía en Google Earth. Haga clic en las casillas cuadradas para seleccionar o deseleccionar las capas. También puede arrastrar y soltar las capas para cambiar su orden. Si arrastra una capa a la parte superior del panel, dicha capa se visualizará por encima de las demás y erá la más visible. Por ejemplo, si arrastra “ipascua_comulin_2022” a la parte superior, verá un contorno simplificado de la isla junto con los nombres de los sitios de los moais como se aprecia en la Figura 23.

Otros elementos importante para el manejo eficiente del espacio de trabajo de QGIS son las herramientas situadas en la parte superior de su interfaz (Figura 24). El símbolo de la mano, por ejemplo, le permite hacer clic en el mapa y moverlo libremente, mientras que los símbolos de la lupa con los signos más y menos le permiten acercar y alejar la imagen. Experimente con ellos y familiarícese con las distintas funciones.

{% include figure.html filename="es-tr-qgis-capas-24.png" alt="Visual description of figure image" caption="Figura 24. Caption text to display" %}


Una vez creado el mapa con capas vectoriales, añadiremos o utilizaremos nuestra primera capa ráster. Este es un buen momento para guardar el trabajo.

 - Guárdelo en la carpeta de proyecto como “Proyecto Isla de Pascua".

## Abrir un Ráster

Los datos ráster son imágenes digitales compuestas por cuadrículas. Todos los datos de teledetección, como imágenes satelitales o fotografías aéreas, son rásteres, pero normalmente no se aprecian las cuadrículas en estas imágenes por están formadas por pixeles diminutos. Cada píxel tiene su propio valor y, cuando estos valores se representan en color o escala de grises, conforman una imagen útil para su visualización o análisis topográfico. Un mapa histórico escaneado también se puede importar a un SIG como ráster.

 - Diríjase a la barra superior en la parte superior de su interfaz de QGIS, en la sección “Capa”, seleccione “Añadir capa” y a continuación “Añadir capa ráster…".
 - 
{% include figure.html filename="es-tr-qgis-capas-25.png" alt="Visual description of figure image" caption="Figura 25. Caption text to display" %}


Emergerá la ventana “Administrador de fuente de datos”. En el panel derecho estará seleccionada la sección “Ráster”, este menú es igual al de la sección “Vectorial” visto anteriormente.

 - En la sección “Fuente”, haga clic en el ícono de tres puntos “explorar” y se abrirá la carpeta del proyecto.
 - Busque el archivo TIF llamado “Isla de Pascua 1953” y haga clic en “aceptar".

Es posible que el software le pida definir el sistema de coordenadas de la capa inmediatamente. Si una ventana le ofrece cambiar el SRC al sistema predefinido del proyecto, haga clic en “aceptar”. En cualquier caso, esto lo puede editar desde la capa del ráster al hacer clic derecho y seleccionar “SRC de la capa”, desde donde podrá cambiarlo. Recuerde que el SRC preestablecido del proyecto es “EPSG:20041 – SIRGAS-Chile 2021”.

{% include figure.html filename="es-tr-qgis-capas-26.png" alt="Visual description of figure image" caption="Figura 26. Caption text to display" %}


De vuelta en la interfaz de QGIS, diríjase al panel lateral izquierdo de capas.

 - Tome la capa del mapa ráster y ubíquelo al final por debajo del resto de capas vectoriales. Esto le permitirá visualizar el resto de los datos sobre el mapa.

{% include figure.html filename="es-tr-qgis-capas-27.png" alt="Visual description of figure image" caption="Figura 27. Caption text to display" %}


Ahora puede ver el mapa ráster de fondo a través de la capa de línea costera “ipascua_comulin_2022”. Amplíe la imagen para una inspección más detallada y podrá ver claramente la capa de línea costera. Observe que la alineación es relativamente buena, pero no perfecta. En la lección 4, profundizaremos en los desafíos de georreferenciar mapas históricos para asignarles coordenadas del mundo real.

{% include figure.html filename="es-tr-qgis-capas-28.png" alt="Visual description of figure image" caption="Figura 28. Caption text to display" %}


Ya ha aprendido a instalar QGIS y a añadir capas ¡No olvide guardar su trabajo!

_Esta lección forma parte del **curso de Historiador Geoespacial**_
