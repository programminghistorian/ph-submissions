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
  Esta lección plantea modificaciones menores a la base de datos y archivos de la plataforma. Antes de iniciar realice una copia de seguridad de toda la instalación o realice las prácticas con una instalación nueva que no comprometa información actualmente en uso.
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

Como en un circuito eléctrico, cada tabla contiene información necesaria para un conjunto de procesos, por ejemplo, cuando se muestra un elemento se toma información de las tablas `omeka_collections` y `omeka_elements_text`, pero, para saber cuál texto corresponde a cual elemento y colección las interrelaciona en la tabla `omeka_items` que cruza el número de identificación de la colección con el del elemento. A medida que vayamos progresando en esta lección se hará más claro el funcionamiento de la base de datos.

Además de la base de datos, Omeka funciona gracias a los archivos que permiten leer la información para mostrarla en una página web y los formularios que hacen posible ingresar nueva información en la base de datos sin necesidad de hacerlo directamente en las tablas, un proceso que sería demasiado tedioso como para ser funcional. 

Al instalar Omeka exploramos un poco el directorio raíz de la plataforma, específicamente la carpeta `application\config`. No vamos a explorar a profundidad la estructura de archivos de Omeka, pero quisiera indicar algunos directorios claves para el manejo avanzado de la plataforma:

1. `/plugins`: En esta dirección se almacenan los paquetes de "plugins" o complementos que añaden capacidades adicionales a la plataforma. De manera predeterminada vienen incorporados "CoinS" (lectura de metadatos bibliográficos en HTML), "ExhibitBuilder" (crear presentaciones) y "SimplePages" (crear páginas). Otros "plugins" pueden descargarse de <https://omeka.org/classic/plugins/>
2. `/themes`: El directorio de las plantillas de Omeka. Con la instalación se incluyen tres temas: "default" ("Thanks, Roy"), Berlin y Seasons. Estos tres temas presentan las configuraciones clásicas de Omeka a partir de las cuales se desarrollan las plantillas disponibles en <https://omeka.org/classic/themes/>, que para instalarse deben subirse o copiarse a este directorio.
3. `/files`: En este directorio se guardan las imágenes en sus diferentes tamaños después de haberse subido y pasado por ImageMagick, también los PDF y cualquier otro archivo que se haya subido por medio de la plataforma. Cada archivo es renombrado con una cadena alfanumérica aleatoria que asegura la identificación del objeto. El nombre original con el cual fue subido el archivo se almacena en la columna `original_filename` de la tabla `omeka_files`.
4. `/application`: Este directorio puede considerarse como el corazón de la plataforma y contiene los archivos que hacen funcionar los complementos, los temas, las páginas de búsqueda, etc. Sólo mencionaré dos subcarpetas de cierta relevancia: `\application\config` que ya conocemos, y `application\languages`, que alberga los archivos de traducción de la plataforma en formato `.mo`. El archivo para el idioma español se llama `es.mo` y puede ser editado en caso de requerirse modificar alguna expresión o palabra[^transifex].

La mayoría de los proyectos que involucran Omeka tendrán que interactuar con los dos primeros directorios y, dependiendo de la complejidad del desarrollo, con los siguientes.

Lo importante, tanto para la base de datos como para el directorio de archivos, consiste en familiarizarse con la plataforma y de esta manera responder ante una falla de manera más rápida de lo que podríamos hacerlo si ignoramos como encontrar un archivo o consultar la base de datos para hacer una pregunta en un <a href="https://forum.omeka.org/" target="_blank">foro de soporte</a> o buscar una posible solución en la web.

# Plugins o complementos

Un plugin es un pequeño programa que añade una función específica a un programa, por ejemplo, un CMS puede incorporar una casilla de comentarios, pero un plugin puede hacer que esta casilla se conecte con las redes sociales y comentar desde su perfil de Facebook o Twitter. En esta lección sólo veremos cómo añadir plugins a nuestra instalación de Omeka[^omeka.net], si desea profundizar en la manera de desarrollar un complemento lo más recomendable es consultar la documentación <a href="http://omeka.org/codex/Plugin_Writing_Best_Practices#Plugin_Directory_Structure" target="_blank">disponible en la página de Omeka</a>.

Las dos fuentes principales de plugins para Omeka son el repositorio oficial de complementos <https://omeka.org/classic/plugins/> y <a href="https://github.com/search?q=omeka+plugin" target="_blank">Github</a>. Ambos listados son bastante dinámicos, por lo que recomendamos visitar periódicamente estos lugares para conocer novedades y actualizaciones.

Para instalar un plugin sólo es necesario descargar el complemento de nuestro interés, descomprimirlo (se encuentran almacenados en archivos \*.zip) y copiarlo en el interior de la carpeta plugins. Después ingresamos al panel de control de Omeka y a la administración de plugins (desde el menú superior) donde aparecerá el nombre de cada plugin que hayamos copiado en la carpeta, de manera similar a la siguiente imagen:

{% include figure.html filename="img_3.1-plugins.png" caption="Panel de administración de plugins" %}

Desde este panel de administración es posible:

- **Instalar**: Con este botón se ejecuta el script que instala el plugin.
- **Desinstalar**: Desinstala el plugin y borra la información de configuración del mismo.
- **Desactivar**: Todos los plugins quedan activos después de instalados, si por alguna razón no van a ser usados en el momento pero no quiere desinstalarlos puede aplicar esta opción y dejar el contenido de configuración y los archivos intactos.
- **Activar:** Revierte la anterior acción.
- **Configurar**: Enlaza con la página de configuración del plugin. Algunos complementos necesitan cierta información para poder funcionar, otros pueden ser personalizados para que su funcionamiento o presentación se adapte a los requerimientos de los usuarios.

### Solución de problemas

Cuando se descarga un plugin directamente de Github puede aparecer la advertencia "No es un plugin válido." En ese caso, asegúrese de que el nombre del directorio no contenga la palabra `-master` o `-plugin`. También puede comprobar que el nombre del directorio corresponda con el archivo del plugin que obligatoriamente tiene esta forma: `NombreComplementoPlugin.php`. Si estas opciones no funcionan lo más probable es que el plugin simplemente no corresponda a la versión o aún se encuentre en desarrollo, en cuyo caso no podrá instalarse.

También puede suceder que un plugin se instale y genere conflictos en la plataforma que generarán un mensaje de error o incluso impedirán que se cargue el sitio. En este caso solamente deberá borrar los archivos del plugin y el sitio regresará a la normalidad. 

## Algunos plugins recomendados

En el uso cotidiano de Omeka hay plugins que son necesarios y otros opcionales, en general la decisión de optar por instalar un complemento depende de qué necesitemos hacer. Por ejemplo, un trabajo con información proveniente de archivos en PDF necesitará algunos complementos para que los archivos puedan ser visualizados y su contenido indexado para la búsqueda, en ese caso requeriremos los plugins <a href="https://omeka.org/classic/plugins/PdfEmbed" target="_blank">PDF Embed</a> y <a href="https://omeka.org/classic/plugins/PdfText" target="_blank">PDF Text</a>, el primero inserta el archivo en la página de visualización de los elementos, el segundo extrae el texto del PDF para poderse insertar y buscar. Otra opción consiste en visualizar los archivos PDF, Google Docs, Power Point, archivos TIFF y algunos documentos de Microsoft Word con <a href="https://omeka.org/classic/plugins/DocsViewer" target="_blank"> Docs Viewer</a>, aunque en este caso no se hace una indexación para su consulta.

Las líneas de tiempo son otra herramienta de gran utilidad no sólo para la referencia de ciertos contenidos sino para preparar la presentación de resultados. Para ello Omeka cuenta con una serie de plugins: 
- .[Neatline](https://omeka.org/classic/plugins/Neatline), que permite hacer líneas de tiempo
sencillas. 
- .[NeatlineFeatures](https://omeka.org/classic/plugins/NeatlineFeatures), que permite dibujar mapas y asociarlos con un ítem. 
- .[Neatline Widget ~ SIMILE Timeline](https://omeka.org/classic/plugins/NeatlineSimile), permite insertar líneas de tiempo
[SIMILE](http://www.simile-widgets.org/timeline/) en Omeka.
- .[Neatline Widget ~ Text](https://omeka.org/classic/plugins/NeatlineText), conecta documentos de texto con la línea de tiempo Neatline. 
- .[Neatline Time](https://omeka.org/classic/plugins/NeatlineTime), crea líneas de tiempo en Omeka.
- .[Neatline Widget ~ Waypoints](https://omeka.org/classic/plugins/NeatlineWaypoints), que permite ubicar puntos de referencia geográficos en una línea de tiempo.


# Notas

[^version]: Esta lección se probó en la versión 2.6.1. (02/05/2018). En caso de tener una instalación anterior a Omeka 2.x se recomienda actualizar según las instrucciones del [manual de usuario](https://omeka.org/classic/docs/Installation/Upgrading/).
[^xampp_instrucciones]: [^xampp_instrucciones]: Un video que explica la instalación del software puede consultarse en <https://www.youtube.com/watch?v=h6DEDm7C37A>.
[^advertencia_Ubuntu]: La ventana de gestión de servidores (*manage servers*) en Linux muestra la opción de activar el servidor `ProFTPD`. Como Omeka se ejecuta con Apache no es necesario iniciarlo.
[^bitnami_ingreso]: En Bitnami de manera predeterminada el usuario de phpMyAdmin será "root" y la contraseña será la que fue solicitada en la instalación de la máquina virtual.
[^instalar-net-tools]: Para instalar net-tools sólo debe ejecutar el comando `sudo apt install net-tools`
[^instrucciones_autom_xampp]: Las instrucciones las puedes encontrar en <https://jairomelo.github.io/tutoriales/ayuda/script-iniciar-xampp-ubuntu>
[^transifex]: Es recomendable que antes de iniciar una tarea de traducción completa de la plataforma se consulte el sitio oficial del proyecto de traducción de omeka en [Transifex](https://www.transifex.com/omeka/omeka/). 
[^omeka.net]: Para el servicio de Omeka.net puede consultar la lección [poniendo Omeka a funcionar](https://programminghistorian.org/es/lecciones/poniendo-omeka-a-funcionar#instala-algunos-plugins).