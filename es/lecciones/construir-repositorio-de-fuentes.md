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

## Gestionar las bases de datos desde phpMyAdmin

Para la instalación de Omeka es necesario crear una base de datos que albergará información que permite relacionar elementos, tipos de elementos, colecciones, entre sí y con otros objetos, como textos, documentos o imágenes. 

Para crear la base de datos es posible utilizar los métodos explicados en el paso 2 de [*Installing Omeka*](https://programminghistorian.org/en/lessons/installing-omeka#step-2-install-your-server-and-database). También podemos utilizar phpMyAdmin para crear la base de datos de la instalación e incluso para editarla después.

El primer paso consiste en ingresar al entorno de phpMyAdmin a través de la dirección <http://localhost/phpmyadmin/> XAMPP te dejará ingresar sin contraseña, pero otros servicios (como Bitnami) te exigirán permisos de usuario para ingresar.[^bitnami_ingreso] La página de inicio te mostrará una página con la configuración general del servidor de la base de datos, el servidor web y de la aplicación. Esta pantalla será importante al momento de requerir la versión de MySQL ("Servidor de base de datos >> Versión del servidor"), la versión de PHP ("Servidor web >> Versión de PHP"), o incluso el nombre de usuario del servidor (por lo general "root@localhost"). Esta pantalla es útil no sólo en instalaciones locales, servirá también para comprobar que algún servicio de alojamiento web corresponda con la tecnología necesaria para ejecutar ciertas aplicaciones.

En phpMyAdmin seleccionaremos la pestaña "Bases de datos" donde veremos un pequeño formulario para crear la base de datos, sólo tenemos que ingresar el nombre e indicar el cotejamiento. Seleccionaremos el cotejamiento `utf8_spanish_ci` ya que representará una mayor precisión al momento de ordenar los elementos (*items*) en Omeka.[^collate] 

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

# Entender el "esqueleto" de Omeka

Si vamos a [phpMyAdmin](http://localhost/phpmyadmin) veremos que la base de datos vacía está ahora llena con 19 tablas. 



# Uso "avanzado" de etiquetas y colecciones



# Notas

[^version]: Esta lección se probó en la versión 2.6.1. (02/05/2018). En caso de tener una instalación anterior a Omeka 2.x se recomienda actualizar según las instrucciones del [manual de usuario](https://omeka.org/classic/docs/Installation/Upgrading/).
[^xampp_instrucciones]: [^xampp_instrucciones]: Un video que explica la instalación del software puede consultarse en <https://www.youtube.com/watch?v=h6DEDm7C37A>.
[^advertencia_Ubuntu]: La ventana de gestión de servidores (*manage servers*) en Linux muestra la opción de activar el servidor `ProFTPD`. Como Omeka se ejecuta con Apache no es necesario iniciarlo.
[^bitnami_ingreso]: En Bitnami de manera predeterminada el usuario de phpMyAdmin será "root" y la contraseña será la que fue solicitada en la instalación de la máquina virtual.