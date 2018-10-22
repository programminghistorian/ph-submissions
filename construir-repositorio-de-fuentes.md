---
title: Construir un repositorio de fuentes históricas con Omeka Classic
collection: lessons
layout: lesson
slug: 
date: 
authors:
- Jairo Antonio Melo Flórez
reviewers:
- 
editors:
- José Antonio Motilla
review-ticket: 
difficulty: 
activity: 
topics: [website]
abstract: 
---

# Contenido

{% include toc.html %}

* Instalar plugins
* Uso "avanzado" de etiquetas y colecciones.
* Gestión de metadatos: Crear y usar "tipos de elementos" para tipos documentales.
* Inclusión de fuentes primarias, secundarias, biográficas y contextuales.
* Inclusión de fuentes digitalizadas: imágenes y PDF.
* Relación de elementos: construir una red de elementos interconectados. (Item Relations plugin)
* Transcripción colaborativa de fuentes: Scripto.
* Modificación de la plantilla básica para ordenar los elementos por fecha.

# Antes de empezar

Actualmente el <a href="https://omeka.org" target="_blank">proyecto Omeka</a> se encuentra dividido en tres productos: Omeka Classic, una plataforma de publicación Web para construir y compartir colecciones digitales; Omeka.net, un servicio de alojamiento web específicamente diseñado para Omeka; y Omeka Semantic o S, lanzada en 2017, enfocada en la conexión de las colecciones con la Web semántica. Esta lección se basa en Omeka Classic[^version] por estar enfocada en proyectos particulares, de individuos o grupos medianos. Para construir grandes colecciones institucionales de documentos, bibliotecas o archivos, recomendamos usar Omeka S.

<div class="alert alert-warning">
  Esta lección plantea modificaciones menores a la base de datos y archivos de la plataforma. Antes de iniciar realice una copia de seguridad de toda la instalación o realice las prácticas con una instalación nueva o que no comprometa información actualmente en uso.
</div>

# Introducción

La abundancia de información documental que tenemos a disposición es cada vez mayor. Las fuentes primarias que se encuentran publicadas por archivos y bibliotecas han facilitado significativamente nuestro trabajo de recolección de información histórica. Sin embargo, esto ha conllevado un problema de abundancia de digitalizaciones y transcripciones de documentos que muchas veces quedan almacenadas anárquicamente en nuestros ordenadores. En esta lección aprovecharemos las capacidades de Omeka para desarrollar repositorios, individuales o colaborativos, para almacenar, analizar y exhibir fuentes primarias; con el propósito de presentar una opción para la sistematización de documentación primaria que posteriormente podrá ser utilizada en tareas de investigación o exhibiciones Web.

Para seguir esta lección requieres una instalación de Omeka. Puedes seguir la lección [*Installing Omeka*](http://programminghistorian.org/lessons/installing-omeka) disponible en el sitio en inglés (la versión en español se encuentra en proceso de traducción). En caso de que necesites conocer el funcionamiento básico de la plataforma es importante que entiendas como [crear sitios, elementos, colecciones](https://programminghistorian.org/es/lecciones/poniendo-omeka-a-funcionar) y [exhibiciones](https://programminghistorian.org/es/lecciones/crear-exposicion-con-omeka).

Asimismo es importante que en caso de querer ampliar la información sobre el funcionamiento de Omeka recurras al <a href="https://omeka.org/classic/docs/" target="_blank">manual de usuario</a> de la versión clásica. También es posible que consultes o participes en el <a href="https://forum.omeka.org/c/omeka-classic" target="_blank">foro</a> para obtener información adicional o respuesta a un problema específico.

# Instalación local de Omeka

Instalar un servidor Web en tu ordenador brinda la posibilidad de ejecutar aplicaciones como Omeka de manera privada y gratuita; lo que representa una ventaja significativa para experimentar con proyectos que aún se encuentren en desarrollo o para utilizar Omeka con información privada que no se desea subir a un servidor Web accesible desde la Internet. 

La arquitectura de Omeka está basada en PHP-MySQL, esto significa que la información que se agrega, modifica y lee desde el entorno de la plataforma escrito en <a href="https://es.wikipedia.org/wiki/PHP" target="_blank">PHP</a>; queda almacenada en una base de datos <a href="https://es.wikipedia.org/wiki/MySQL" target="_blank">MySQL</a>; y se procesa mediante un servidor <a href="https://en.wikipedia.org/wiki/Apache_HTTP_Server" target="_blank">Apache</a>. No es necesario entender exactamente el funcionamiento de la tecnología de servidor (se requeriría de una especialización en informática para ello), pero es importante familiarizarse con los conceptos de servidor Web, plataforma y base de datos para los ejercicios posteriores. 

El sentido básico de este esquema puede resumirse con la siguiente imagen:

{% include figure.html filename="img_1.1.jpg" caption="Síntesis de la tecnología de servidor" %}

Para realizar la instalación local y configurar Omeka en tu ordenador, te recomendamos seguir las instrucciones del paso 2A de la lección [*Installing Omeka*](https://programminghistorian.org/en/lessons/installing-omeka#step-2a-for-vps-hosting). También es recomendable consultar el <a href="http://www.rubenalcaraz.es/manual-omeka/" target="_blank">manual elaborado por Manuel Alcaraz</a> (bibliotecónomo con grado en ingeniería informática), en el cual cubre los aspectos necesarios para gestionar una instalación en Omeka desde la interface de administración del sitio. 

En este tutorial te ayudaremos a instalar una <a href="https://es.wikipedia.org/wiki/M%C3%A1quina_virtual" target="_blank">máquina virtual</a>, es decir, una serie de programas que permiten <a href="https://es.wikipedia.org/wiki/Script_del_lado_del_servidor" target="_blank">ejecutar aplicaciones que requieren tecnología de servidor</a> (como Omeka) sin necesidad de tener contratado un servidor Web. También te mostraremos una forma común de gestionar la base de datos a través del aplicativo <a href="https://es.wikipedia.org/wiki/PhpMyAdmin" target="_blank">phpMyAdmin</a>, una herramienta ampliamente difundida para administrar MySQL.

## Instalar la máquina virtual

 Para los fines de esta lección usaremos el entorno <a href="https://www.apachefriends.org/es/index.html" target="_blank">XAMPP</a>, disponible para Windows, Linux y OS X. Después de descargar el paquete correspondiente a su sistema operativo instale el entorno siguiendo las instrucciones del instalador.[^xampp_instrucciones] A continuación le solicitará que escoja un directorio para albergar los archivos de la máquina virtual, en nuestro caso realizamos la instalación en Windows 10 y escogeremos la opción predeterminada `C:\xampp`; en el caso de Linux-Ubuntu será obligatoriamente `/opt/lampp` y en Mac OS X `/aplications/XAMPP`.

Para ejecutar el instalador en Linux deberás iniciar la terminal y dirigirte al directorio donde lo descargarte y hacerlo ejecutable mediante el siguiente comando (recuerda cambiar el nombre del ejemplo por el del archivo que descargaste):

```terminal
sudo chmod +x xampp-linux-x64-7.2.10-0-installer.run
```

Luego ejecuta el archivo mediante el comando:

```terminal
sudo ./xampp-linux-x64-7.2.10-0-installer.run
```
A partir de allí sigue las instrucciones del instalador.

Tras la instalación, la primera acción que debemos realizar será activar los módulos "Apache" y "MySQL" para poner a funcionar nuestro servidor.[^advertencia_Ubuntu] Para eso sólo debes hacer click en los botones "Start" de la columna "Actions", tras lo cual los módulos se pondrán de color verde.

{% include figure.html filename="img_1.1-modact.jpg" caption="Módulos XAMPP activados" %}

Para probar que todo funciona correctamente, ingresa desde tu navegador a la dirección <http://localhost/> o <http://127.0.0.1>. Si la instalación es correcta te mostrará la pantalla de inicio:

{% include figure.html filename="img_1.1-xampp-dashboard.jpg" caption="Pantalla de inicio (dashboard) de XAMPP" %}

Deberás tener en el menú de inicio de Windows un menú de XAMPP con tres opciones desplegables. Las más útiles para nuestro trabajo serán "XAMPP Control Panel", que abre el panel de control para activar o desactivar los módulos, y "XAMPP htdocs folder", un enlace al directorio donde se guardarán los archivos de Omeka para realizar la instalación, por lo general es `C:\xampp\htdocs` para Windows. En Linux este directorio se encuentra en la ruta `/opt/lampp/htdocs`.

Errores comunes en Windows que pueden surgir de este proceso pueden derivarse de haber instalado la máquina virtual sin desactivar el antivirus, conflictos con otras máquinas virtuales previamente instaladas, o haber escogido un directorio, para el caso de Windows 10, en la carpeta `C:\Program Files (x86)`. En todos estos casos la opción más sencilla consiste en reinstalar la máquina y evitar estas advertencias.

En el caso de Linux tal vez sea necesario instalar instancias adicionales como "net-tools"[^instalar-net-tools]. Si va a utilizar XAMPP de manera frecuente lo más recomendable es crear un *script* para iniciar la aplicación automáticamente en cada reinicio del ordenador[^instrucciones_autom_xampp]. 

## Gestionar las bases de datos desde *phpMyAdmin*

Para la instalación de Omeka es necesario crear una base de datos que albergará información que permite relacionar elementos, tipos de elementos, colecciones, entre sí y con otros objetos, como textos, documentos o imágenes. 

Para crear la base de datos es posible utilizar los métodos explicados en el paso 2 de [*Installing Omeka*](https://programminghistorian.org/en/lessons/installing-omeka#step-2-install-your-server-and-database). También podemos utilizar *phpMyAdmin* para crear la base de datos de la instalación e incluso para editarla después.

El primer paso consiste en ingresar al entorno de *phpMyAdmin* a través de la dirección <http://localhost/phpmyadmin/> XAMPP te dejará ingresar sin contraseña, pero otros servicios (como Bitnami) te exigirán permisos de usuario para ingresar.[^bitnami_ingreso] La página de inicio te mostrará una página con la configuración general del servidor de la base de datos, el servidor web y de la aplicación. Esta pantalla será importante al momento de requerir la versión de MySQL ("Servidor de base de datos >> Versión del servidor"), la versión de PHP ("Servidor web >> Versión de PHP"), o incluso el nombre de usuario del servidor (por lo general "root@localhost"). Esta pantalla es útil no sólo en instalaciones locales, servirá también para comprobar que algún servicio de alojamiento web corresponda con la tecnología necesaria para ejecutar ciertas aplicaciones.

En *phpMyAdmin* seleccionaremos la pestaña "Bases de datos" donde veremos un pequeño formulario para crear la base de datos, sólo tenemos que ingresar el nombre e indicar el cotejamiento. Seleccionaremos el cotejamiento `utf8_spanish_ci` ya que representará una mayor precisión al momento de ordenar los elementos (*items*) en Omeka.[^collate] 

{% include figure.html filename="img_1.2-crear-baseddatos.jpg" caption="Crear base de datos en phpMyAdmin" %}

Después de crear la base de datos la plataforma lo llevará al escritorio donde podrá gestionar las tablas, ejecutar código SQL, importar y exportar tablas, gestionar los permisos de los usuarios, entre otras acciones. Por el momento la base de datos estará vacía puesto que no hemos creado ninguna tabla. Asegúrese de que haya un usuario vinculado a la base de datos (pestaña "Privilegios") y que tenga todos los privilegios. En caso contrario puede seleccionar "editar privilegios" y hacer clic en la casilla "Seleccionar todo". También puede crear y dar permisos a otros usuarios (sólo en caso de administrar colaborativamente la base de datos) desde el menú "Agregar cuenta de usuario".

Antes de salir anota los siguientes datos que te servirán para [configurar el archivo db.ini](https://programminghistorian.org/en/lessons/installing-omeka#step-4-configure-omeka-to-use-your-database):

* Nombre del servidor
* Nombre de la base de datos
* Nombre de usuario
* Contraseña del usuario

### Cambiar el idioma a español

La configuración predeterminada de Omeka hace que la interface del respositorio se muestre en inglés. Lastimosamente, el panel de administración no tiene una opción para seleccionar el idioma y hacer que el sitio se muestre en español. Por lo tanto, debemos hacer este cambio de manera manual modificando el archivo `config.ini` que se encuentra en el directorio `application/config`. Desde un editor de texto o de código abre el archivo y busca la línea que dice `locale.name = ""` y entre paréntesis escribe la palabra "es", que corresponde al código de lenguaje ISO 639 para el castellano.

{% include figure.html filename="image_1.3-locale.png" caption="cambiar idioma a español en la configuración"}

# Un vistazo al "esqueleto" de Omeka

Si vamos a [phpMyAdmin](http://localhost/phpmyadmin) veremos que la base de datos vacía está ahora llena con 19 tablas interdependientes. La estructura de la base de datos (*database schema*) puede describirse de manera sintética agrupando las tablas en cinco grupos de información: datos para los elementos y colecciones, etiquetas, metatados de los tipos de elementos, información de usuarios, texto para búsqueda, y tablas para procesos del sistema. Un mapa resumido de las interdependencias entre las tablas se puede ver en la siguiente imagen:

{% include figure.html filename="img_2.1-omeka_mysql_schema.png" caption="Esquema de la interdependencia de la base de datos de Omeka" %}

Como en un circuito eléctrico, cada tabla contiene información necesaria para un conjunto de procesos, por ejemplo, cuando se muestra un elemento se toma información de las tablas `omeka_collections` y `omeka_elements_text`, pero, para saber cuál texto corresponde a cual elemento y colección las interrelaciona en la tabla `omeka_items` que cruza el número de identificación de la colección con el del elemento. A medida que vayamos progresando en esta lección se hará más claro el funcionamiento de la base de datos y en la parte final daremos una pequeña mirada a los archivos de la plataforma.

# Uso "avanzado" de etiquetas y colecciones

Las categorías y etiquetas son cadenas de texto que ayudan a ordenar la información en un repositorio o base de datos, en general agrupas en diferentes niveles los contenidos y que de otra manera se dispersarían de tal manera que harían muy difícil su consulta. Debe tenerse en cuenta que las categorías y etiquetas comprenden dos niveles jerárquicos diferentes: las primeras definen temas generales en tanto las segundas corresponden a palabras claves que definen el elemento. 
Al progresar el ingreso de información en el repositorio se multiplicarán las categorías y etiquetas, por lo tanto, es importante definir de antemano las principales categorías que van a ser incluidas en el repositorio y, de ser posible, las etiquetas propuestas para identificar los elementos. Lo ideal es que cada categoría y etiqueta agrupe una cantidad significativa de elementos, por ello es importante escoger términos generales que puedan abarcar temas y conceptos. Tampoco debería utilizarse como etiqueta o categoría información que ya estará contenida en los metadatos, como fechas, lugares, nombres, archivos, entre otros; ya que estos se pueden buscar fácilmente con las herramientas de búsqueda y ordenación disponibles en Omeka y en *phpMyAdmin*.
Otro aspecto que se tiene que tener en cuenta es que las categorías y  etiquetas seguramente serán editadas, renombradas, reasignadas y eliminadas con la acumulación de información, por lo cual es importante conocer algunos mecanismos para editar de manera masiva las cadenas de texto en phpMyAdmin o directamente desde un editor de SQL, eso lo trataremos al final de esta lección.

### Categorías y colecciones

La manera de agregar categorías en Omeka es bastante simple. En primer lugar, desde el panel de administración escogemos la pestaña "categorías" y posteriormente solo escogemos "Agregar una Colección"

![button\_cat.fw](./Categorías,%20colecciones%20y%20etiquetas%20_%20Cibercliografía_files/button_cat.fw_.png){.aligncenter
.size-full .wp-image-448 width="354" height="73"
sizes="(max-width: 354px) 100vw, 354px"
srcset="http://cibercliografia.org/wp-content/uploads/2016/07/button_cat.fw_.png 354w, http://cibercliografia.org/wp-content/uploads/2016/07/button_cat.fw_-300x62.png 300w"}

De inmediato se abre un formulario de *Dublin Core* idéntico al utilizado para agregar elementos. En este sólo es indispensable el campo "Título", los demás pueden ser incluidos en caso de querer presentar una descripción de la categoría o cualquier otra información que se considere relevante. Esto es importante en caso de estar construyendo un repositorio colaborativo o haber recurrido al *crowdsourcing* para
alimentar el sitio.

Después de agregar la categoría ya puede ser asociada a los elementos relacionados en el módulo de selección de colecciones.

[![sel\_coleccion.fw](./Categorías,%20colecciones%20y%20etiquetas%20_%20Cibercliografía_files/sel_coleccion.fw_-183x300.png){.aligncenter
.wp-image-449 .size-medium width="183" height="300"
sizes="(max-width: 183px) 100vw, 183px"
srcset="http://cibercliografia.org/wp-content/uploads/2016/07/sel_coleccion.fw_-183x300.png 183w, http://cibercliografia.org/wp-content/uploads/2016/07/sel_coleccion.fw_.png 338w"}](http://cibercliografia.org/wp-content/uploads/2016/07/sel_coleccion.fw_.png)

En Omeka las categorías y colecciones son sinónimos, sin embargo en esta lección se van a diferenciar pues vamos a utilizar un *plugin* llamado [Collection Tree](http://omeka.org/add-ons/plugins/collection-tree/) con el cual podremos jerarquizar entre categorías. El siguiente es un ejemplo de jerarquización que he realizado para mi fichero de investigación doctoral:

[![cat-tags.fw](./Categorías,%20colecciones%20y%20etiquetas%20_%20Cibercliografía_files/cat-tags.fw_-245x300.png){.aligncenter
.wp-image-446 .size-medium width="245" height="300"
sizes="(max-width: 245px) 100vw, 245px"
srcset="http://cibercliografia.org/wp-content/uploads/2016/07/cat-tags.fw_-245x300.png 245w, http://cibercliografia.org/wp-content/uploads/2016/07/cat-tags.fw_.png 452w"}](http://cibercliografia.org/wp-content/uploads/2016/07/cat-tags.fw_.png)

En el ejemplo anterior existe una colección cuya única función consiste en ser utilizada como insumo para la elaboración de una línea de tiempo, es decir, su información es básicamente de "presentación" de la información. En este sentido es importante entender que algunos elementos pueden ser agrupados con el propósito de apoyar la explicación misma de la investigación o servir como contexto de la misma.

En la opción de configuración es posible elegir entre ordenar el árbol de categorías de manera alfabética o "jerárquica", aunque en realidad en este último caso ordena según la columna `id` en la tabla `omeka_collections`). En este sentido se puede personalizar el orden de las categorías en el árbol editando directamente la base de datos, con la precaución necesaria ya que sencillamente puede deteriorarse la estructura de ésta o incluso eliminar información, por eso antes de realizar cualquier modificación es imprescindible realizar una copia de seguridad de la base de datos con el fin de poder recuperar la información. Más adelante presentaré una manera de hacer esta reordenación.

### Etiquetas

El etiquetado es un proceso aún más sencillo. Simplemente al agregar un nuevo elemento se selecciona la pestaña "Etiquetas" y allí se escriben las palabras claves separadas por comas. En caso de repetir etiquetas la plataforma despliega una lista donde se encuentran las palabras que coinciden con las primeras letras que se insertan en la casilla.

[![tagg\_add.fw](./Categorías,%20colecciones%20y%20etiquetas%20_%20Cibercliografía_files/tagg_add.fw_-300x295.png){.aligncenter
.wp-image-450 .size-medium width="300" height="295"
sizes="(max-width: 300px) 100vw, 300px"
srcset="http://cibercliografia.org/wp-content/uploads/2016/07/tagg_add.fw_-300x295.png 300w, http://cibercliografia.org/wp-content/uploads/2016/07/tagg_add.fw_.png 371w"}](http://cibercliografia.org/wp-content/uploads/2016/07/tagg_add.fw_.png)

Las etiquetas pueden ser editadas desde el panel dispuesto en la configuración del sitio. Allí es posible renombrar la etiqueta o eliminarla (esto no modifica los elementos, sólo la etiqueta). También se pueden modificar las etiquetas desde el panel de edición de cada elemento.

[![edit\_tags.fw](./Categorías,%20colecciones%20y%20etiquetas%20_%20Cibercliografía_files/edit_tags.fw_-300x195.png){.aligncenter
.wp-image-451 .size-medium width="300" height="195"
sizes="(max-width: 300px) 100vw, 300px"
srcset="http://cibercliografia.org/wp-content/uploads/2016/07/edit_tags.fw_-300x195.png 300w, http://cibercliografia.org/wp-content/uploads/2016/07/edit_tags.fw_-768x498.png 768w, http://cibercliografia.org/wp-content/uploads/2016/07/edit_tags.fw_.png 786w"}](http://cibercliografia.org/wp-content/uploads/2016/07/edit_tags.fw_.png)

Omeka cuenta con la posibilidad de navegar por etiquetas, para lo cual presenta una nube de etiquetas, que no sólo es útil para buscar las palabras claves sino además para interpretar su frecuencia.

[![cloudword.fw](./Categorías,%20colecciones%20y%20etiquetas%20_%20Cibercliografía_files/cloudword.fw_-300x184.png){.aligncenter
.wp-image-452 .size-medium width="300" height="184"
sizes="(max-width: 300px) 100vw, 300px"
srcset="http://cibercliografia.org/wp-content/uploads/2016/07/cloudword.fw_-300x184.png 300w, http://cibercliografia.org/wp-content/uploads/2016/07/cloudword.fw_-768x471.png 768w, http://cibercliografia.org/wp-content/uploads/2016/07/cloudword.fw_.png 960w"}](http://cibercliografia.org/wp-content/uploads/2016/07/cloudword.fw_.png)

### Categorías desde la base de datos

Al abrir el editor de MySQL se identifican rápidamente las tablas en las cuales se almacena la información de las categorías y etiquetas: `omeka_collections` y `omeka_tags`. La estructura de la primera tabla consta de seis columnas:

-   `id`: El número único de identificación de la categoría.
-   `public`: Determina si la categoría es pública (1) o privada (0).
-   `featured`: Muestra si la categoría es destacada (1) o no (0).
-   `added` y `modified`: Guardan la fecha y hora de adición de la
    categoría y cuando fue modificada.
-   `owner_id`: Identifica al usuario que administra cada categoría.

![structure\_omeka\_collections.fw](./Categorías,%20colecciones%20y%20etiquetas%20_%20Cibercliografía_files/structure_omeka_collections.fw_.png){.aligncenter
.size-full .wp-image-455 width="1111" height="627"
sizes="(max-width: 1111px) 100vw, 1111px"
srcset="http://cibercliografia.org/wp-content/uploads/2016/07/structure_omeka_collections.fw_.png 1111w, http://cibercliografia.org/wp-content/uploads/2016/07/structure_omeka_collections.fw_-300x169.png 300w, http://cibercliografia.org/wp-content/uploads/2016/07/structure_omeka_collections.fw_-768x433.png 768w, http://cibercliografia.org/wp-content/uploads/2016/07/structure_omeka_collections.fw_-1024x578.png 1024w"}

Con respecto a omeka\_tags, esta tiene una estructura bastante simple de dos columnas:

-   `id`: El número único de identificación de la etiqueta.
-   `name`: La palabra clave.

![structure\_omeka\_tags.fw](./Categorías,%20colecciones%20y%20etiquetas%20_%20Cibercliografía_files/structure_omeka_tags.fw_.png){.aligncenter
.size-full .wp-image-456 width="1125" height="573"
sizes="(max-width: 1125px) 100vw, 1125px"
srcset="http://cibercliografia.org/wp-content/uploads/2016/07/structure_omeka_tags.fw_.png 1125w, http://cibercliografia.org/wp-content/uploads/2016/07/structure_omeka_tags.fw_-300x153.png 300w, http://cibercliografia.org/wp-content/uploads/2016/07/structure_omeka_tags.fw_-768x391.png 768w, http://cibercliografia.org/wp-content/uploads/2016/07/structure_omeka_tags.fw_-1024x522.png 1024w"}

Cualquier modificación que se haga a esos *items* se verá reflejado en la plataforma, pero si se hacen modificaciones a los `id` la  información simplemente no podrá ser leída correctamente. En ese sentido, si se quieren reorganizar las categorías por ejemplo o reasignar las etiquetas desde MySQL se debe tener en cuenta cuál es la relación entre las tablas.

En primer lugar Omeka crea la colección en la tabla `omeka_collections` donde asigna la información que señalamos anteriormente. Después Omeka crea el texto de la categoría en las tablas `omeka_element_texts` y `omeka_search_text`. Para identificar entre categorías y elementos ambas tablas tienen una columna llamada `record_type` en la cual se señala si es "Collection" o "Item". En la columna `text` el nombre de la  categoría.

Finalmente, para relacionar el item con la categoría se señala en la tabla `omeka_items` el `id` del elemento y se asigna la categoría en la columna `collection_id`.

[![omeka\_collections.fw](./Categorías,%20colecciones%20y%20etiquetas%20_%20Cibercliografía_files/omeka_collections.fw_-300x140.png){.aligncenter
.wp-image-459 .size-medium width="300" height="140"
sizes="(max-width: 300px) 100vw, 300px"
srcset="http://cibercliografia.org/wp-content/uploads/2016/07/omeka_collections.fw_-300x140.png 300w, http://cibercliografia.org/wp-content/uploads/2016/07/omeka_collections.fw_-768x359.png 768w, http://cibercliografia.org/wp-content/uploads/2016/07/omeka_collections.fw_.png 920w"}](http://cibercliografia.org/wp-content/uploads/2016/07/omeka_collections.fw_.png)

En este caso las modificaciones que se hagan a una columna, por ejemplo al `id` de la colección deben replicarse a las demás tablas, incluyendo `omeka_collection_trees` en el caso de haber una correlación jerárquica.

Hagamos un ejercicio sencillo. En este caso quiero que la colección "cronotopología" quede al final del árbol de categorías, en este caso tendré que reasignar el id de la categoría para hacer que sea el último de la tabla. Una búsqueda sencilla en la tabla `omeka_element_texts` me indica que el `id` de la colección es igual a 17. 

Para realizar la búsqueda usé la siguiente solicitud:

```sql
SELECT * FROM `omeka_element_texts` WHERE `text` LIKE 'cronotopología' ORDER BY `id` ASC 
```

Lo que hace este *query* es pedirle a `SQL` que busque en la tabla `omeka_element_texts` todas las filas (`SELECT * FROM`) donde (`WHERE`) la columna `text` contenga (`LIKE`) la palabra "cronotopología" y la ordene por orden ascendente de acuerdo con su `id`. 

Como tengo 27 categorías tendré que asignar un número mayor, en este caso voy a asignarle el 28.

Es posible hacer esta modificación de manera manual cambiando el valor de cada casilla, o utilizar el siguiente script:

```sql
START TRANSACTION; 
UPDATE `omeka_collections` 
	SET `id` = '28' 
	WHERE `omeka_collections`.`id` = 17; 
UPDATE `omeka_element_texts` 
	SET `record_id` = '28' 
	WHERE `omeka_element_texts`.`record_id` = 17; 
UPDATE `omeka_items` 
	SET `collection_id` = '28' 
	WHERE `omeka_items`.`collection_id` = 17; 
UPDATE `omeka_collection_trees` 
	SET `collection_id` = '28' 
	WHERE `omeka_collection_trees`.`id` = 17; 
COMMIT; 
```

En este caso, ya no le solicito a `SQL` que busque una fila o casilla sino que haga una modificación a varias 

De esta manera la categoría que estaba en la mitad de las colecciones ahora se encuentra al final del árbol de categorías:

[![cat\_tree-rearange.fw](./Categorías,%20colecciones%20y%20etiquetas%20_%20Cibercliografía_files/cat_tree-rearange.fw_-292x300.png){.aligncenter
.wp-image-463 .size-medium width="292" height="300"
sizes="(max-width: 292px) 100vw, 292px"
srcset="http://cibercliografia.org/wp-content/uploads/2016/07/cat_tree-rearange.fw_-292x300.png 292w, http://cibercliografia.org/wp-content/uploads/2016/07/cat_tree-rearange.fw_.png 482w"}](http://cibercliografia.org/wp-content/uploads/2016/07/cat_tree-rearange.fw_.png)

### Etiquetas desde la base de datos

Las etiquetas responden a la relación de dos tablas: `omeka_tags` que identifica y agrega el texto, y `omeka_records_tags` que relaciona el elemento con la etiqueta. Al igual que las categorías, los cambios que se realicen en el identificador de una tabla deberán actualizarse en la siguiente.

[![omeka\_tags.fw](./Categorías,%20colecciones%20y%20etiquetas%20_%20Cibercliografía_files/omeka_tags.fw_-300x148.png){.aligncenter
.wp-image-465 .size-medium width="300" height="148"
sizes="(max-width: 300px) 100vw, 300px"
srcset="http://cibercliografia.org/wp-content/uploads/2016/07/omeka_tags.fw_-300x148.png 300w, http://cibercliografia.org/wp-content/uploads/2016/07/omeka_tags.fw_-768x380.png 768w, http://cibercliografia.org/wp-content/uploads/2016/07/omeka_tags.fw_.png 797w"}](http://cibercliografia.org/wp-content/uploads/2016/07/omeka_tags.fw_.png)

En ocasiones el *script* de las etiquetas no funciona, en especial en entornos WAMPP, en este caso es posible insertar las etiquetas de manera manual directamente en la base de datos al editar las tablas. También puede utilizarse un script para insertar una misma etiqueta en varios elementos al mismo tiempo. Por ejemplo, quiero aplicar la etiqueta "comunicaciones" a tres elementos.

Primero busco el id en la tabla `omeka_tags` con el
query `` SELECT * FROM `omeka_tags` WHERE `name` LIKE 'comunicaciones' ORDER BY `name` ASC.  ``

Después inserto las nuevas etiquetas con el siguiente query:

`` INSERT INTO `omeka_records_tags` (`id`, `record_id`, `record_type`, `tag_id`, `time`) VALUES (NULL, '218', 'Item', '169', CURRENT_TIMESTAMP), (NULL, '217', 'Item', '169',CURRENT_TIMESTAMP), (NULL, '216', 'Item', '169', CURRENT_TIMESTAMP); ``



# Notas

[^version]: Esta lección se probó en la versión 2.6.1. (02/05/2018). En caso de tener una instalación anterior a Omeka 2.x se recomienda actualizar según las instrucciones del [manual de usuario](https://omeka.org/classic/docs/Installation/Upgrading/).
[^xampp_instrucciones]: [^xampp_instrucciones]: Un video que explica la instalación del software puede consultarse en <https://www.youtube.com/watch?v=h6DEDm7C37A>.
[^advertencia_Ubuntu]: La ventana de gestión de servidores (*manage servers*) en Linux muestra la opción de activar el servidor `ProFTPD`. Como Omeka se ejecuta con Apache no es necesario iniciarlo.
[^bitnami_ingreso]: En Bitnami de manera predeterminada el usuario de phpMyAdmin será "root" y la contraseña será la que fue solicitada en la instalación de la máquina virtual.
[^instalar-net-tools]: Para instalar net-tools sólo debe ejecutar el comando `sudo apt install net-tools`
[^instrucciones_autom_xampp]: Las instrucciones las puedes encontrar en <https://jairomelo.github.io/tutoriales/ayuda/script-iniciar-xampp-ubuntu>