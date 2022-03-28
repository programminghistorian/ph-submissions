---
title: Instalar Omeka
authors:
- Jonathan Reeve
date: 2016-07-24
translation_date: 2018-05-20
editors:
- Fred Gibbs
reviewers:
- M. H. Beals
translator:
- Melisa Castro
translation-editor:
- Jennifer Isasi 
translation-reviewer:
- Joseba Moreno
- Jennifer Isasi 
layout: lesson
original: installing-omeka
redirect_from: /es/lessons/instalar-omeka
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/157
difficulty: 2
activity: presenting
topics: [website]
abstract: "Esta lección te enseñará a instalar tu propia copia de Omeka."
---
{% include toc.html %}

## Introducción
[Omeka.net](http://omeka.net), como se describió en una lección previa, es un servicio útil para principiantes en Omeka, pero existen algunas razones por las cuales preferirás instalar tu propia copia de Omeka. Las razones incluyen:

*  **Actualizaciones**. Instalando Omeka puedes usar la última versión tan pronto como se lanzada, sin tener que esperar a que Omeka.net la actualice su sistema.

* **Complementos (plugins) y Tema (themes)** Puedes instalar el complemento o tema de tu preferencia, sin limitarte solo a aquellos provistos por Omeka.net.

* **Personalizaciones** Puedes comprar un nombre de dominio personalizado, y personalizar tu código para alcanzar la funcionalidad que desees

* **Control** Tienes control sobre tus copias de respaldo, y puedes actualizar el servidor por ti mismo de manera que la seguridad está siempre actualizada.

* **Precio** Ahora existen muchos Servidores privados y virtuales (VPSs) de bajo costo, algunos de los cuales solo cuestan 5USD al mes.

* **Almacenamiento** Ahora, muchos proveedores de hosting compartido ofrecen almacenamiento ilimitado. Esta característica es útil si tienes una biblioteca multimedia extensa.


En este tutorial, vamos a estar utilizando e introduciendo algunos comandos de la línea de comandos. Para hacer el tutorial no es necesario tener conocimiento previo en la línea de comandos, pero si desea tener una orientación más concisa puede consultar la Introducción a BASH en Programming Historian. Aparte del procedimiento presentado en este tutorial para la instalación de Omeka existen muchos otros. Algunos usando exclusivamente herramientas GUI. Algunos provedorees de Hosting incluso ofrecen por medio de sus paneles de control “Instalaciones en un click”. Sin embrago, muchos de estos métodos instalan versiones antiguas de Omeka que se vuelven difíciles de actualizar o mantener. El método que vamos a describir a continuación puede no ser la manera más fácil de instalar Omeka, pero si es un buen ejercicio de práctica en el uso de la línea de comando. Habilidad que le será útil si quiere actualizar su instalación o instalar otros entornos web, manualmente. (Por ejemplo, este método de instalación es bastante similar a WordPress’s “Five-Minute Install”).El proceso va a durar aproximadamente una hora y tiene cuatro pasos.

## Paso 1: Configura tu servidor Host
Primero, crea una cuenta con un proveedor de hosting que te de acceso a SSH.
Hay dos tipos principales de proveedores de hosting: VPS y compartido.
Un servidor (HOST) VPS te da acceso de raíz, lo que quiere decir que tienes más control sobre el servidor, pero el espacio de almacenamiento es con frecuencia limitado.
Para archivos pequeños de 20GB o menos, esta es la mejor opción, pero para archivos más grandes, los planes de hosting compartidos se adaptan mejor.
DigitalOcean es un servidor (Host) fácil de unsar y de bajo costo, y Amazon Web Services (AWS) respalda servidores virtuales similares en su plataforma Elastic Computing (EC2), dirigido más a usuarios avanzados.
Los dos HostGator y DreamHost ofrecen hosting compartido acsequible económicamente y con almacenamiento ilimitado.

Lo primero que te recomendamos hacer al abrir una cuenta con proveedor VPS es crear un servidor virtual utilizando su interfaz.
(Si estás utilizando un servidor compartido este paso ya está hecho).
En DigitalOcean, los (instances) se llaman “droplets,” y puedes crear uno simplemente ingresando y haciendo click en “Create Droplet.”
En AWS EC2, un VPS es llamado “instance,” y puedes crear uno ingresando a la consola EC2 y haciendo click en “Launch Instance”.
En este tutorial estaremos ejecutando comandos Ubunto Linux.
Le recomendamos entonces que en cualquier coso elija instalar un sistema Ubuntu.
Si desea tener ayuda más detallada en estos pasos, puede revisar la guía de Digital Ocean’s : How To Create Your First DigitalOcean Droplet Virtual Server, and Amazon’s guide Launch an Amazon EC2 Instance.

Ahora que tienes tu servidor ejecutandose, debes conectarte a el con un cliente SSH.
Esto es tan simple como abrir un terminal y digitar ```ssh root@hostname```, ```hostname``` debe ser es la dirección de su servidor.
Consulte las instrucciones para ingresar vía SSH en la documentación de su host.
Aquí hay una muestra de guias para host VPS.
* Digital Ocean: How To Connect To Your Droplet with SSH
* Amazon Web Services: Connecting to Your Linux Instance Using SSH
También hay gias para host compartidos:
* DreamHost Wiki: SSH
* HostGator: How Do I Get and Use SSH Access?
Cuando esté conectado debe ver un aviso que luce como este:

>
user@host  #

Es en este lugar donde debe introducir los comandos.

## Paso 2: Instalar el servidor y la base de datos
Los commandos que estamosa apunto de ejecutar son un poco diferentes para hosting VPS y compartido.
Entonces, si tiene hosting VPS debe seguir el paso 2A.
De lo contrario deberá seguir el paso 2B

### Paso 2A: Para servidor VPS
Primero, es necesario instalar una línea de software LAMP.
LAMP soporta Linux, Apache, MySQL, y PHP, y es el conjunto de software que en el que se ejecuta Omeka.
Linux es el Sistema operative que ejecuta el servidor, Apache es el servidor web de software, MySQL es la base de datos, and PHP es el lenguaje en el que está escrito Omeka.
Asegurese de primero ingresar como un Usuario de raíz.
(Un superusuario o usuario raíz es un usuario que posee todos los permisos para ejecutar cualquier comando).
Si eres un usuario raíz, escribe ```whoami``` y 	debería devolverle a root; si no le lleva a un lugar diferente cambie de usuario (su) a usuario raíz usando el comando ``` su root``` o ```sudo su root```.
Si le es solicitado al crear su VPS, ingrese la contraseña para usuario raíz.
El siguiente paso es actualizar nuestro sistema:

``` >apt-get update && apt-get upgrade```

Una vez actualizado en Sistema, es momento de instalar el server stack (la colección de software que forma la infraestructura operacional del servidor):

  ``` >apt-get install lamp-server ^```

``` >apt-get install lamp-server ^```

Asegúrese de incluir el símbolo de intercalación (^) al final.
Esto debe instalar un servidor LAMP, y se le pedirá que ingrese la clave raíz de MySQL.
Ingrese ahí una contraseña y asegúrese de recordarla porque será requerida más adelante.

Para este momento, su servidor debería estar prestándole servicio a páginas web.
Si todo está corriendo de manera adecuada, debería poder abrir su IP pública de VPS en un buscador de la web y le debería aparecer la página Apache2 Ubuntu pre determinada con un aviso que diga “It works”.
En caso de que esto no suceda, tendrá que seguir algunos pasos más para asegurarse que todo este yendo de manera apropiada.
En Amazon EC2, por ejemplo, tus puertos no son enviados automáticamente.
Por este motivo, debe agregar puertos HTTP al sistema de trafico de puertos entrantes de su sistema de seguridad grupal actual.
Diríjase a Network & Security -> Security Groups, luego elija el el tipo de grupo de seguridad que está utilizando, selecione la opción “Inbound”, y posteriormente haga click en “Edit” añadiendo de esta manera los puertos HTML.

Es hora de dejar el módulo ```mod rewrite``` Apache activado lo que permite a Omeka usar las rutas URL personalizadas:

``` >a2enmod rewrite && service apache2 restart ```

El siguiente paso es configurar la base de datos. Primero, debe entrar al programa de base de datos MySQL como un usuario raíz usando el comando:

``` >mysql –u root- ´p ```

El indicador ``` - u ``` te permite especificar el usuario, y el ``` - p ```si no está seguido por una contraseña va a solicitar que se ingrese la contraseña raíz.
En ese momento debe ingresar la contraseña que creó para MySQL cuando instaló el servidor LAMP.
En ese momento debe aparecer un aviso que dice ``` mysql>```.
Ahora vamos a ingresar un comando para crear una base de datos.
Nombraré mi base de datos ``` jonreeve_omeka```; sin embargo, puede nombrar el cómo prefiera.

```<CREATE DATABASE jonreeve_omeka CHARACTER SET utf8 COLLATE utf8_general_ci```

Aquí, ```CHARACTER SET utf8 COLLATE utf8_general``` asegura que podrá usar completamente el set de personaje en su sitio web, y no solamente el set de personaje Latin.
Si el comando es exitoso, MySQL debe decir ``` Query OK, 1 row affected (0.00 sec)```.
Si todo sale bien, para los siguientes comandos debería observarse  un aviso que diga``` Query OK, 0 row affected (0.00 sec) ```

A continuación, crearemos un usuario en una cuenta de base de datos. De manera, que Omeka pueda comunicarse con la base de datos

``` < CREATE USER ‘jonreeve_omeka’@’localhost’ IDENTIFED by’ %8)&2P^TFR2C;```

Para más comodidad he elegido como mi nombre de usuario el mismo que tengo en la base de datos y he elegido como clave ```%8)&2P^TFR2C``` .
Para permitir al nuevo usuario acceder a la recién creada base de datos ingresando el comando:

 ``` > GRANT ALL PRIVILEGES ON ‘jonreeve_omeka’* TO ‘jonreeve_omeka’@’localhost’; FLUSH PRIVILEGES```

 En este punto, su base de datos debe estar lista para usarse con Omeka. Escriba ```exit ```; o presione Control+C para salir de MySQL y volver a su línea de comando.

 ### Paso 2B: para servidor compartido

 Siga los siguientes pasos si usted está usando un servidor compartido. Si usted está usando un servidor VPS puede saltar directamente al paso 3.


 Ingrese al panel de control de su servidor y busque un ítem llamado “MySQL Databases” o algo similar.
 Si su proveedor usa cPane, y debe encontrar algo que luce como la siguiente imagen:

<img src='imagenes\grafico 1 paso 2b.png' alt="img">
**Intalar la nueva base de datos**

En la caja llamada Create New Database ingrese un nombre para la base de datos.
En los proveedores compartidos el prefijo va a ser comúnmente su nombre de usuario (el mío ``` jonreeve```), y usted debe completar el nombre con la palabra de su elección.

Una vez haya elegido el nombre haga click para volver a la pantalla anterior.
En la parte de debajo de la caja de Create New Database va a ver el área para crear un nuevo usuario MySQL. Se debe ver como se muestra la imagen:

<img src='imagenes\grafico 2 paso 2b.png' alt="img">
**Crear un Nuevo usuario**

En la caja llamada ```username ``` digite el mismo nombre que uso en la base de datos (esto es solo una formalidad que te ayudará a mantener todo ordenado).
). Yo, por ejemplo, utilice nuevamente ```omeka ``` para que el nombre completo del usuario se lea ```jonreeve_omeka ```.
En este punto es una buena idea hacer click en la opción click “generate password, porque esto hará que tenga una contraseña muy segura.Es recomendable que anote en un lugar seguro el nombre de usuario (que debe ser el mismo de la base de datos) y la contraseña generada por el sistema, ya que los necesitará más tarde.

<img src='imagenes\grafico 3 paso 2b generador password.png' alt="img">
**Generar contraseña**

El siguiente paso, agregue el usuario que usuario que acaba de crear a la base de datos.
Para hacerlo, elija el usuario y la base de datos que acaba de crear en el menú de opciones y haga click en “añadir”.

<img src='imagenes\grafico 4 paso 2b.png Add User to Database.png' alt="img">
**Agregar usuario a la base de datos**

Su base de datos está lista para ser usada, y puede  continuar con la instalación de Omeka.

## Paso 3: descargar e instalar Omeka

Es hora de descargar Omeka directamente al servidor.
Esta opción ayudará a evadir ciertos procesos de la descarga local que podrían tomar tiempo innecesario mientras se abre localmente y se carga al servidor.
Para hacerlo, primero debe obtener el HTML público.
Usualmente es ```/var/www/html```, pero también puede que sea ```/var/www```, o posiblemente, e algunos servidores compartidos, ```	~/public_html```.
Si no está seguro averigüe con su Host donde guarda el directorio HTML público.

```>cd/var/www/html```

Si llegase a salir que hay un error en los permisos en el servidor VPS, asegúrese de que ha ingresado como el usuario raíz utilizando el código ```su root```.
Ahora copie el URL de http://omeka.org/download, y uselo con el comando ```wget``` de la siguiente forma:

``` >wget http://omeka.org/files/omeka-2.4.zip```.

En este momento es importante que se asegure que tiene el comando ```unzip```.

```>apt-get install unzip```

y con este puede unzip el archivo comprimido de Omeka

```unzip omeka-2.4.zip```

(si se genera un error estando en un servidor VPS, probablemente necesite installar el comando ```unzip``` añadiendo primero ```apt-get install unzip```).
Este paso hará que el unzip del archivo Omeka proseda en el subdirectorio de su sitio web.
En caso de que no desee que su sitio web tenga el URL ```http://your-domain.com/omeka-2.4/``` debe cambiar el nombre del directorio:

```>mv omeka-2.4 omeka```

(En vez de ```omeka-2.4```, substituya la versión que descargó).
Para este momento, debe tener Omeka instaladoy listo para conectar a la base de datos.

## Paso 4: Configurar Omeka para usarlo con la base de datos.

Primero, debe dirigirse al directorio en donde reposa su instalación de Omeka usando el comando ```cd. ```.
De un VP, probablemente el comando requerido sea ```/var/www/html/omeka ``` y en un servidor compartido sea ```	~/public_html/omeka/ ```

```>cd/ver/www/html/omeka```

Si llegase a salir que hay un error en los permisos en el servidor VPS, asegúrese de que ha ingresado como el usuario raíz primero corriendo el comando ```su root```.
Ahora edite el archivo ```db.ini```.
En este tutorial usamos un editor Nano, siga los siguientes pasos a menos de que usted se sienta cómodo utilizado el power editor como Vim.

El editor se va a ver de la siguiente manera:

<img src='imagenes\grafico 1 paso 4.png' alt="img">

**Db.ini, Antes**

Ahora puede editar su archivo cambiando ```XXXXXXXXXXX ``` valores por los valores apropiados para su sistema, pero manteniendo intactas las comillas (“).
El campo ```host ``` debe ser nombrado ```localhost ``` porque la base de datos está en este mismo servidor.
Para el ```username``` y ```dbname```, ingrese su nombre se usuario, contraseña y nombre de la base de datos que creó en el paso dos.
Para este ejemplo los valores son:
-----------
*```host =”localhost”```
*```username=”jonreeve_omeka” ```
*```password=”%8)&2P^TFR2C”```
*```dbname=”jonreeve_omeka” ```

El archivo debe verse al final de la siguiente forma:

<img src='imagenes\grafico 4 paso 2b Add User to Database.png' alt="img">
**Db.ini, Después**

Salga usando (Control+X) y cuando le sea solicitado guarde sus cambios presionando ```Y```.
Por ultimo cambie el dueño de su instalación de Omeka para que sea leída por internet:

```>chown –R www-data:www-data```

¡En hora Buena! Debes tener el programa de Omeka instalado y funcionando.
Puedes acceder al código de instalación en   ```http://your-domain/omeka/install/install.php ```, remplaza ```yourdomain ``` con el nombre de dominio o dirección IP, y ```omeka ``` con el nombre que le dio a su directorio antes.
Llene el formato de configuración de inicio en su instalación de Omeka.
Si tiene algún problema en el proceso consulte la guía de instalación de Omeka o la Omeka Troubleshooting Guide.
