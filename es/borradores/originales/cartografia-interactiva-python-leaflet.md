---
title: "Creación de una cartografía web interactiva de rutas e itinerarios con Python y Leaflet"
slug: cartografia-interactiva-python-leaflet
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Ana Luna San Eugenio
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/715
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

---

## Introducción
La difusión de la Historia está indisolublemente ligada a la representación del espacio en el que se produjeron los hechos objeto de análisis. Antes del surgimiento de las herramientas tecnológicas, la cartografía se empleaba como una herramienta estática. Sin embargo, gracias al desarrollo de los Sistemas de Información Geográfica, a las herramientas de programación libres y gratuitas y a la popularización de las herramientas de Inteligencia Artificial (particularmente los modelos de lenguaje natural) aquel escenario ha cambiado completamente. En estos días, podemos concebir los mapas como recursos dinámicos para la difusión de la Historia, la Geografía u otras Ciencias Sociales, así como para la investigación académica.

En *Programming Historian* se han explorado previamente diversas aproximaciones al mapeo web. Lecciones como [*Web Mapping with Python and Leaflet*](https://programminghistorian.org/en/lessons/mapping-with-python-leaflet) de Kim Pham muestran cómo transformar datos geoespaciales para visualizarlos con la librería Leaflet (JS). Asimismo, metodologías como la propuesta por Gabriel Calarco y Gimena del Río Riande en [*Georreferenciación y visualización de itinerarios con Recogito y Visone*](https://programminghistorian.org/es/lecciones/georreferenciacion-visualizacion-con-recogito-y-visone) demuestran la utilidad de utilizar software de terceros para dibujar mapas y rutas. No obstante, la dependencia de plataformas externas, habitualmente cerradas y de carácter comercial, plantea varios problemas críticos para el conocimiento y el trabajo de los, podríamos denominar, humanistas digitales: 1) la pérdida de control sobre el entorno técnico; 2) las limitaciones de personalización; 3) el riesgo de que la herramienta de un tercero desaparezca, comprometiendo la preservación digital a largo plazo.

La presente propuesta nace de la necesidad de integrar soluciones geotecnológicas en los entornos docentes y de investigación en los que la autora de la presente lección trabaja habitualmente. Inspirada además en conceptos como el de la soberanía digital y la computación mínima, y con el pleno convencimiento de promocionar el conocimiento libre, en esta lección se propondrá construir, desde cero, una aplicación web cartográfica interactiva utilizando tecnologías libres, gratuitas y de código abierto.

Al controlar completamente tanto el *backend* (con Python y Flask) como el *frontend* (con HTML, CSS y JavaScript), podrás aprender a desplegar un mapa independiente de servidores externos o de conexiones a  Internet. Esto asegura un proyecto sostenible, transparente, fácil de adaptar a tus necesidades, de traducir, etcétera. Además, por su sencillez, asegura su funcionamiento en ordenadores básicos o en contextos con limitaciones de conectividad.

## Objetivos de la lección
En esta lección aprenderás a crear mapas interactivos que muestren rutas e itinerarios a través del desarrollo de una pequeña aplicación web con Python y Javascript, utilizando además la librería Leaflet como motor de mapas. En los distintos apartados se mostrará:
+ Cómo configurar un servidor web local desde cero.
+ Cómo escoger mapas base y cómo descargarlos para utilizarlos de modo local.
+ Cómo representar puntos y líneas.
+ Cómo realizar mapas de rutas con un alto atractivo estético, completamente personalizables.
+ Cómo introducir una capa dinámica interactiva de carácter narrativo para explicar la ruta creada.

Todo ello utilizando herramientas libres, abiertas y gratuitas, escribiendo completamente el código desde cero y controlando hasta la última coma de tu proyecto. Sin dependencias de complejos softwares de terceros o herramientas cerradas o comerciales.

## Creación del entorno web con Flask
Para que la cartografía web interactiva que se va a desarrollar pueda ser accesible a través de un navegador web (como Chrome, Firefox o Edge), es necesario disponer de un servidor web local. En esta lección se utilizará Flask, un framework de Python extraordinariamente ligero y básico. Por esta razón, es una herramienta magnífica para poner en marcha un servidor local rápidamente, con un control absoluto de la aplicación.

Para programar este servidor, es necesario preparar tu sistema operativo instalando algunas herramientas básicas de desarrollo: Python, pip y Flask.

### Instalación de Python y pip
Para el desarrollo de la aplicación web, es necesario tener instalado en tu sistema el lenguaje de programación Python y el gestor de paquetes `pip`, el cual será el medio que se utilizará para instalar las librerías necesarias para hacer funcionar la aplicación.

La instalación difiere en función del sistema operativo que se utilice. En esta lección indicaremos cómo llevar a cabo la instalación en Linux (adaptado a Ubuntu/Debian) y en Windows. Una vez instalado Python, el funcionamiento es similar en ambos sistemas operativos.

Si ya tienes instalado Python, puedes omitir este paso.

#### En Linux 
Python y `pip` suelen venir instalados en la mayoría de distribuciones. No obstante, si no estuvieran instalados, puedes abrir la terminal y usar `apt` para instalarlos:

```bash
sudo apt install python3 python3-pip
```

Para comprobar si la instalación es correcta, abre una terminal y escribe:

```bash
python3 --version
pip3 --version
```

Si todo es correcto, deberías ver las versiones instaladas tanto de Python como de `pip`.

#### En Windows
La instalación en Windows difiere de la de Linux. La mejor opción es descargar el instalador de la última versión estable de Python. Ten en cuenta que debes descargar la versión más adaptada a tu sistema. En la mayoría de los equipos actuales la versión más adecuada es la de 64-bit.

Una vez ejecutado el instalador, asegúrate de seleccionar la opción `Add Python to PATH`. Este paso es fundamental para que los futuros comandos que escribas puedan ejecutarse. A continuación, sigue los pasos del instalador hasta completar el proceso.

Para comprobar si la instalación es correcta, abre el Símbolo del sistema (puedes buscarlo como tal o escribir `cmd` en el buscador de la barra de tareas de Windows) y escribe:

```cmd
python --version
```

Si todo es correcto, deberías recibir un mensaje indicándote la versión de Python instalada en tu sistema. Puedes hacer la misma comprobación para `pip` escribiendo `pip --version`.

En el resto de la lección, usaremos la palabra *terminal* tanto para referirnos a una terminal en Linux como para el *Símbolo del sistema* de Windows.

### Instalación de la primera librería: Flask
Como se indicó anteriormente, para el desarrollo de la aplicación usaremos Flask, un microframework web para Python. A pesar de que hay otros frameworks mucho más completos, para este caso concreto Flask proporciona una base muy sencilla y extraordinariamente ligera. Para instalar Flask tan solo es necesario abrir una terminal y escribir:

```cmd
pip install flask
```

No obstante, en algunas distribuciones de Linux, y particularmente en Ubuntu/Debian, la ejecución directa de `pip` está bloqueada. Para ello deberás crear un entorno virtual. Abre una terminal y navega hasta una carpeta donde quieras instalar este entorno. A continuación, escribe:

```bash
python3 -m venv venv
```

A continuación, ejecuta el nuevo entorno virtual:

```bash
source venv/bin/activate
```

Sabrás que está activo porque verás escrito un `(venv)` al principio de la línea de tu terminal. Ahora puedes instalar Flask con `pip`:

```bash
pip3 install flask
```

Si quieres salir del entorno virtual, solo tienes que escribir `deactivate` en la terminal.

### Primeros pasos con Flask
Para su correcto funcionamiento, Flask necesita disponer de una estructura de carpetas concreta para localizar los archivos necesarios para su funcionamiento (como los archivos HTML, los estilos CSS o los scripts de Javascript).

En consecuencia, deberás crear en tu ordenador una carpeta para albergar el proyecto. Puedes denominarla como quieras, aunque lo recomendable es un nombre corto y sin caracteres especiales. Esa carpeta tendrá, por el momento, la siguiente estructura de carpetas y subcarpetas:

```text
/mapa
  /templates
  /static
    /css
	/js
```

Una vez creada esta estructura, deberás crear dos archivos mínimos para hacer funcional la aplicación. Para ello, puedes utilizar cualquier editor de código (por ejemplo, Notepad++ o VS Code).

#### La base del sistema: app.py
El primer archivo nos servirá para hacer funcionar el servidor web e indicarle las rutas adecuadas. Se trata de `app.py`. Para ello, abre un archivo en blanco y complétalo con este código:

```Python
from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
```

A continuación, guarda este archivo en la carpeta raíz del proyecto con el nombre app.py. Cuando ejecutes este código Python en la terminal, estarás indicando que 1) inicie Flask; 2) defina cuál la carpeta raíz; 3) renderice el archivo html principal (que crearás en el siguiente paso); 4) inicie el servidor local en modo desarrollo.

#### La página inicial que se mostrará en el navegador: index.html
Abre un nuevo archivo en blanco en tu editor de código. Por el momento solo crearás un HTML mínimo para comprobar que funciona:

```HTML
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mapa Web Interactivo - Lección de Programming Historian</title>
</head>
<body>
    <h1>¡Mi servidor Flask está funcionando correctamente!</h1>
</body>
</html>
```

Debes guardar este archivo como `index.html` dentro de la carpeta "/templates" de tu proyecto.

#### Iniciando el servidor
Una vez creados estos archivos mínimos, abre la terminal, navega hasta la carpeta raíz del proyecto y ejecuta el código python que has guardado escribiendo `python3 app.py` (en Linux) o `python app.py` (en Windows). Recuerda que si estás ejecutando la aplicación desde Linux, deberás iniciar en primer lugar el entorno virtual con `venv`, tal y como se indicó en el epígrafe relativo a la instalación de Flask.

Una vez ejecutado el código, aparecerán unos mensajes en la terminal indicando que el servidor está corriendo. Para comprobarlo, abre tu navegador web e introduce la siguiente dirección: `http://127.0.0.1:5000/`. Si todo es correcto, debería abrirse una página web con el mensaje "¡Mi servidor Flask está funcionando correctamente!" que indicaste en `index.html`. Para detener el servidor, solo tienes que pulsar `Ctrl + C` en la terminal.

## Integración de un motor de mapas: Leaflet
Una vez creado el servidor local, el siguiente paso es integrar en la aplicación web un motor de mapas. Para ello se empleará Leaflet, una de las librerías de JavaScript de código abierto más populares y utilizadas del mundo para la creación de mapas interactivos adaptados a entornos web.

Leaflet es completamente gratuita y libre. Se puede usar de forma ilimitada, gratuita y sin ninguna clase de restricción. El control del código es total. Es, además, extraordinariamente ligera y eficiente. Además, gracias a ser un proyecto comunitario, cuenta con una gran comunidad de desarrolladores que comparten y desarrollan diversos *plugins* para aumentar las funcionalidades del sistema.

En los siguientes pasos, conectaremos esta librería a nuestra plantilla HTML para integrar en ella un mapa dinámico. Es posible cargar el motor de mapas de dos formas: haciendo que el código llame a un servidor externo para cargar Leaflet o descargando el código e integrarlo en la aplicación web que estás desarrollando de forma local.

### Instalación local de Leaflet
Para integrar el motor de mapas de forma local en el proyecto, deberás descargar Leaflet de la [página oficial de descargas de Leaflet](https://leafletjs.com/download.html). Elige la última versión estable y descárgala. Se descargará un archivo .zip. Ábrelo y busca los archivos `leaflet.css` y `leaflet.js`. Cópialos y pégalos en tu proyecto: `leaflet.css` a la carpeta `/static/css/` y `leaflet.js` a la carpeta `/static/js/`.

A continuación deberás incluir en tu archivo `templates/index.html` la llamada a Leaflet. Puedes eliminar el texto de prueba que pusiste para probar el funcionamiento. El archivo final debería quedar de este modo:

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mapa Web Interactivo - Lección de Programming Historian</title>

    <link rel="stylesheet" href="{{ url_for('static', filename='css/leaflet.css') }}">
</head>

<body>

    <div id="mi_mapa"></div>
    <script src="{{ url_for('static', filename='js/leaflet.js') }}"></script>
</body>
</html>
```

En ese código habrás incluido la llamada a la hoja de estilos y al motor en Javascript de Leaflet. Además, habrás reservado en el cuerpo de la página una contenedor denominado "mi_mapa", donde insertaremos posteriormente la cartografía.

### Alternativa: carga de Leaflet desde un servidor externo (opcional, no recomendado)
Aunque no es la opción recomendada, también es posible cargar Leaflet desde un servidor externo. Puedes utilizar una red de distribución de contenidos para pedir a un servidor de internet los archivos de Leaflet cada vez que cargas la página.

Solo tienes que sustituir las líneas de código del HTML anterior que llaman al css y al js de Leaflet por estas:

```html
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
```

<div class="alert alert-warning">
<b>¡Atención!</b> El hash que ves tras <code>integrity=</code> cambiará con otras versiones de Leaflet. Deberás comprobar el modo de cargar desde un servidor externo cuando lo programes. Esta opción no es la recomendada.
</div>

### Inicialización y visualización del mapa

Hasta este momento has preparado el servidor local y has enlazado la librería Leaflet. Es el momento de definir el contenedor del mapa en la página web y pedir a Leaflet que dibuje un mapa en su interior.

#### Estilo para el contenedor del mapa (CSS)
Para que el mapa sea visible, debes definir qué ancho y alto ocupará en la página web. Para ello, deberás crear un archivo de estilos CSS. Abre tu editor de código y crea un archivo nuevo en blanco. En este ejemplo se realizará un mapa que ocupe la ventana de forma completa:

```css
body {
    margin: 0;
    padding: 0;
}

#mi_mapa {
    width: 100%;
    height: 100vh;
}
```

Una vez insertado el código, debes guardar el archivo en `/static/css/` con el nombre que desees. Una sugerencia estándar es denominarlo `styles.css`. A continuación, debes llamar a la hoja de estilos que has creado en CSS desde `index.html`, agregando esta línea de código entre las etiquetas `<head>`:

```html
<link rel="stylesheet" href="{{ url_for('static', filename='css/styles.css') }}">
```

#### Iniciación del mapa (JS)

Una vez que se ha definido el contenedor donde se mostrará el mapa, se utilizará JavaScript para, por fin, ejecutar el mapa. Para hacerlo correctamente, Leaflet requiere tres elementos: las coordenadas geográficas iniciales donde se centrará el mapa al iniciarse, el nivel de zoom y el mapa base que se utilizará.

Para ello, crea un nuevo archivo en blanco en tu editor y escribe el siguiente código:

```javascript
const mapa = L.map('mi_mapa').setView([40.416775, -3.703790], 5); 

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: 'OpenStreetMap'
}).addTo(mapa);
```

La primera línea de código inciará el mapa en unas coordenadas específicas. Para este ejemplo hemos elegido la ciudad de Madrid (España) y un nivel de zoom 5. La segunda línea de código añadirá un mapa base desde el servidor de OpenStreetMap; definirá el zoom máximo a 19 y atribuirá el mapa a OpenStreetMap.

Una vez escrito este código, deberás guardar el archivo en `/static/js/` con el nombre que desees. Para esta lección puedes elegir, sencillamente, el nombre genérico de `mapa.js`.

Una vez escrito y guardado el archivo JS que dará inicio al motor de mapas, deberás llamarle desde tu HTML. Para ello, abre de nuevo `index.html` y escribe al final esta línea de código:

```html
<script src="{{ url_for('static', filename='js/mapa.js') }}"></script>
```

Con este último paso, ya tienes todos los elementos mínimos necesarios para ejecutar el motor de mapas. Tu `index.html` debería ser similar a este:

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mapa Web Interactivo - Lección de Programming Historian</title>

    <link rel="stylesheet" href="{{ url_for('static', filename='css/leaflet.css') }}">
	<link rel="stylesheet" href="{{ url_for('static', filename='css/styles.css') }}">
</head>

<body>

    <div id="mi_mapa"></div>
	
    <script src="{{ url_for('static', filename='js/leaflet.js') }}"></script>
	<script src="{{ url_for('static', filename='js/mapa.js') }}"></script>
</body>
</html>
```

Una vez realizados estos pasos, si ejecutas `app.py` (o actualizas la página si ya tenías el servidor corriendo) podrás ver el motor de mapas corriendo en tu página web a pantalla completa.


{% include figure.html filename="es-or-cartografia-interactiva-python-leaflet-01.png" alt="Visual description of figure image" caption="Figura 1. Vista del navegador con el motor de mapas corriendo en el servidor local." %}


## Opcional: Modificación del mapa base e integración local de las teselas (tiles)
El mapa base utilizado en esta lección está compuestos cuadrículas de imágenes. Cada una de estas imágenes se denomina tesela (tile), la cual contiene fragmentos de los mapas a un determinado nivel de zoom. El motor de mapas renderiza estas imágenes y las sitúa correlativamente en una cuadrícula, montando un mapa completo a partir de estos fragmentos. En el paso anterior, estas teselas se cargan desde un servidor externo de OpenStreetMap. No obstante, puedes elegir cualquier otro mapa base, como se indicará a continuación. Del mismo modo, con el objeto de evitar la dependencia de servidores externos y de conexiones a internet, puedes opcionalmente descargar las teselas y, en lugar de llamarlas desde un servidor externo, hacerlo desde tu propio sistema.

### Elección de otros mapas base
Gracias a la gran popularidad del proyecto Leaflet, hay multitud de proveedores de mapas base. Quizá el mejor modo de consultarlos es a través del [visualizador de mapas base de leaflet-extras en GitHub](https://leaflet-extras.github.io/leaflet-providers/preview/). Al seleccionar el mapa base de tu gusto, aparecerá en la parte superior la ruta del servidor desde donde las cargarás. Deberás sustituirla en tu archivo `mapa.js`, así como el resto de parámetros que te interesen.

Por ejemplo, un mapa base atractivo para algunos proyecto son los mapas de ortofotografías del Geoportail France. La integración en tu `mapa.js` quedaría de este modo:

```javascript
const mapa = L.map('mi_mapa').setView([40.416775, -3.703790], 5); 

L.tileLayer('https://data.geopf.fr/wmts?REQUEST=GetTile&SERVICE=WMTS&VERSION=1.0.0&STYLE=normal&TILEMATRIXSET=PM&FORMAT=image/jpeg&LAYER=ORTHOIMAGERY.ORTHOPHOTOS&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}', {
    attribution: '<a target="_blank" href="https://www.geoportail.gouv.fr/">Geoportail France</a>'
}).addTo(mapa);
```

### Descargar las teselas en local

Como se ha indicado con anterioridad, evitar la depedencia de servidores externos y de una conexión a internet impulsa a la realización de algunos cambios en la aplicación con el fin de almacenar y cargar las teselas de un modo local. Esta práctica además asegura la preservación a largo plazo de la aplicación web generada: aunque los servidores dejen de funcionar, o, con el paso de los años se retiren de internet, la cartografía seguirá funcionando.

La descarga de teselas puede ser problemática. No todos los servicios de mapas son libres y gratuitos, y, aún siéndolo, en algunos casos los términos de licencia restringen su descarga. Para esta lección puedes utilizar las teselas de CartoDB Positron por su diseño minimalista y por estar basadas en OpenStreetMap y estar distruibuidas de forma abierta y libre por CARTO. Además, desde un punto de vista estético, sus tonalidades suaves son una gran elección para, posteriormente, incluir líneas, rutas o marcadores personalizados.

Para guardarlas en local, crearemos un pequeño script en Python que automatice la descarga de estas imágenes y las organice en la estructura de carpetas jerárquica (`{z}/{x}/{y}`) que Leaflet emplea.

#### Script de descarga de teselas (`tiles.py`)

Abre tu editor de código, crea un archivo llamado `tiles.py` con el siguiente código y guárdalo en la carpeta raíz de tu proyecto.

```python
import os
import time
import requests

base_folder = "tiles"

url_template = "https://basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png"

for z in range(3, 6):
    num_tiles = 2 ** z
    for x in range(num_tiles):
        for y in range(num_tiles):
            folder = f"{base_folder}/{z}/{x}"
            os.makedirs(folder, exist_ok=True)
            
            url = url_template.format(z=z, x=x, y=y)
            r = requests.get(url)
            if r.status_code == 200:
                with open(f"{folder}/{y}.png", "wb") as f:
                    f.write(r.content)
            else:
                print(f"Fallo {z}/{x}/{y}")
            
            time.sleep(0.1)
```

Una vez escrito el código, ejecútalo desde la terminal con `python3 tiles.py` (Linux) o `python tiles.py`. Este código recorrerá de forma automática los niveles de zoom del 3 al 5. En esta lección se han escogido estos niveles de zoom para tener una vista relativamente panorámica del mundo y no descargar enormes cantidades de datos. 

<div class="alert alert-warning">
**¡Precaución!** Debes tener en cuenta que, a mayor nivel de zoom, el número de imágenes a descargar crecerá de forma exponencial.
</div>

Por ejemplo, para los niveles que procesa el script propuesto, se descargan las siguientes imágenes:

<div class="table-wrapper" markdown="block">

| Nivel de Zoom | Escala visual | Número de Teselas | Espacio en Disco |
| --------- | --------- | --------- | --------- |
| 3 | Mundial | 64 | 268 KB |
| 4 | Hemisférica | 256 | 888 KB |
| 5 | Continental | 1.024 | 2,56 MB |

</div>


Para indicar el espacio en disco, se han utilizado los datos descargados de CartoDB Positron. No obstante, otra cartografía podría ocupar un espacio notablemente superior. 

Como se puede observar, en este proyecto se han utilizado tan solo 3,69 MB distribuidos en 1.344 teselas. No obstante, si se eligiera descargar un rango de zoom de 1-19 para todo el planeta, el volumen total crecería hasta 366.503.875.924 teselas y el peso total ascendendería a miles de Gigabytes.

Cuando hayas ejecutado el script y se hayan descargado las imágenes, verás que se ha creado una nueva carpeta llamada `/tiles`. Debes mover esta carpeta completa dentro del directorio estático de tu aplicación web: `/static/tiles/`.

#### Adaptación de Leaflet para leer las teselas en local.

Una vez que las imágenes están guardadas en local, el último paso es indicarle a Leaflet que no obtenga las teselas de un servidor externo (como estaba previsto) y lea los archivos locales.

Para ello, debes abrir el archivo `/static/js/mapa.js` y modificar la URL de la capa de teselas. Puedes mantener, si lo deseas, las coordenadas de Madrid y el zoom inicial 5 que se definieron inicialmente, pero apuntando a la ruta interna en lugar de al servidor externo. Además, deberás limitar el zoom entre 3 y 5 (o entre los niveles de zoom que hayas descargado). El código resultante debería ser el siguiente:

```javascript
const mapa = L.map('mi_mapa').setView([40.416775, -3.703790], 5); 

L.tileLayer('/static/tiles/{z}/{x}/{y}.png', {
    minZoom: 3,
    maxZoom: 5,
    attribution: 'OpenStreetMap, CARTO'
}).addTo(mapa); 
```

Una vez realizado este cambio, si reinicias el servidor (o actualizas la página en tu navegador si seguía corriendo), verás que el mapa se inicia exactamente en la posición prevista. Sin embargo, a partir de este momento la carga de las teselas se realiza de forma completamente local. Ya no depende ni de la disponibilidad del servidor ni de una conexión a internet activa. Aun sin conexión, el mapa seguirá cargándose, renderizándose y funcionando sin mayor dificultad.


{% include figure.html filename="es-or-cartografia-interactiva-python-leaflet-02.png" alt="Visual description of figure image" caption="Figura 2. Vista del navegador y del inspector con la cartografía renderizada utilizando teselas descargadas en local (Dominio: 127.0.0.1:5000)." %}


## Generación de puntos y de líneas sobre el mapa para la creación de rutas
Una vez con el motor de mapas corriendo en el servidor de forma completamentemente local y autónoma, es el momento de abordar la creación de puntos y líneas con el fin de crear rutas. Para ello, guardaremos los datos espaciales en archivos JSON (JavaScript Object Notation) y posteriormente los leeremos para insertar estas entidades en el mapa.

En esta lección se trabajará con un ejemplo de una ruta histórica concreta y posteriormente se mostrará un ejemplo de cómo integrar capacidades interactivas a los elementos representados en la cartografía. La ruta elegida es la [primera travesía aérea del Atlántico Sur](https://es.wikipedia.org/wiki/Primera_traves%C3%ADa_a%C3%A9rea_del_Atl%C3%A1ntico_sur), una expedición realizada en el año 1922 por los aviadores portugueses Carlos Viegas Gago Coutinho y Artur de Sacadura Freire Cabral que unió las ciudades de Lisboa y Río de Janeiro, en una travesía que duró 79 días y recorrió 8383 kilómetros. 

La ruta contiene los siguientes puntos: Lisboa (Portugal), Las Palmas de Gran Canaria (España), São Vicente (Cabo Verde), Praia (Cabo Verde), archipiélago de Fernando de Noronha (Brasil), Recife (Brasil), Salvador de Bahía (Brasil), Porto Seguro (Brasil), Vitória (Brasil) y Río de Janeiro (Brasil). Las líneas unirán en orden sucesivo cada pareja de puntos: Lisboa-Las Palmas de Gran Canaria; Las Palmas de Gran Canaria-São Vicente, etc.

### Creación de un archivo de puntos (puntos.json)
Para representar los lugares de la ruta en el mapa, es necesario almacenar sus coordenadas geográficas en un archivo de datos. Como se indicó anteriormente, se utilizará el formato JSON.

La obtención de las coordenadas puede realizarse de diversos modos. Una opción es la de la recolección manual de los datos utilizando cualquier fuente que contenga estas referencias geográficas y posteriormente componer un archivo JSON. Sin embargo, el método más rápido y eficiente es solicitárselo a cualquier Inteligencia Artificial de uso habitual (como ChatGPT, Claude, Gemini, Copilot...). El prompt adecuado para este fin puede ser el siguiente:

> "Necesito las coordenadas geográficas en formato [latitud, longitud] de los siguientes lugares para un mapa de Leaflet: Lisboa, Las Palmas de Gran Canaria, São Vicente (Cabo Verde), Praia (Cabo Verde), Fernando de Noronha, Recife, Salvador de Bahía, Porto Seguro, Vitória y Río de Janeiro. Devuélveme los datos estructurados en un formato JSON completo listo para producción, que contenga el nombre del lugar, el país y las coordenadas. Escribe cada item en una sola línea."

La respuesta de la IA debería ser muy parecida a esta:

```json
[
{"name":"Lisboa","country":"Portugal","coordinates":[38.7223,-9.1393]},
{"name":"Las Palmas de Gran Canaria","country":"España","coordinates":[28.1235,-15.4363]},
{"name":"São Vicente","country":"Cabo Verde","coordinates":[16.8901,-24.9804]},
{"name":"Praia","country":"Cabo Verde","coordinates":[14.9330,-23.5133]},
{"name":"Fernando de Noronha","country":"Brasil","coordinates":[-3.8547,-32.4233]},
{"name":"Recife","country":"Brasil","coordinates":[-8.0476,-34.8770]},
{"name":"Salvador de Bahía","country":"Brasil","coordinates":[-12.9777,-38.5016]},
{"name":"Porto Seguro","country":"Brasil","coordinates":[-16.4447,-39.0647]},
{"name":"Vitória","country":"Brasil","coordinates":[-20.3155,-40.3128]},
{"name":"Río de Janeiro","country":"Brasil","coordinates":[-22.9068,-43.1729]}
]
```

Cuando tengas el resultado, deberás abrir en tu editor de código un archivo nuevo y pegar el código. A continuación, guarda el archivo con el nombre que desees (por ejemplo, `puntos.json`). Puedes crear en tu proyecto una carpeta concreta para guardar estos datos, como por ejemplo `/static/data/`.

### Creación de un archivo de líneas (rutas.json)
Una vez que se han indicado los lugares geográficos en `puntos.json`, el siguiente paso es definir cómo se conectan entre sí para mostrar el itinerario. Para ello crearemos un archivo que contenga las rutas. Al igual que para la creación del archivo de puntos, se puede recurrir a la Inteligencia Artificial para generar las rutas. El prompt sugerido es el siguiente:

> "Tengo este archivo JSON: [pegar el código íntegro de puntos.json]. Necesito generar un archivo JSON listo para producción que represente la secuencia de la ruta, conectando cada punto con el siguiente en una lista de trayectos, utilizando solo los nombres en su forma exacta. Escribe cada item en una sola línea."

La respuesta de la IA debería ser muy parecida a esta:

```json
[
{"from":"Lisboa","to":"Las Palmas de Gran Canaria"},
{"from":"Las Palmas de Gran Canaria","to":"São Vicente"},
{"from":"São Vicente","to":"Praia"},
{"from":"Praia","to":"Fernando de Noronha"},
{"from":"Fernando de Noronha","to":"Recife"},
{"from":"Recife","to":"Salvador de Bahía"},
{"from":"Salvador de Bahía","to":"Porto Seguro"},
{"from":"Porto Seguro","to":"Vitória"},
{"from":"Vitória","to":"Río de Janeiro"}
]
```

Cuando tengas el resultado, al igual que con el archivo de puntos, guarda el archivo con el nombre que desees (por ejemplo, `rutas.json`) y guárdalo en la misma carpeta (como en el caso anterior, en `/static/data/`).

### Representación de los datos geoespaciales en el mapa
Una vez creados los dos archivos de datos geoespaciales estructurados y escritos de forma relacional (puntos.json y rutas.json), el siguiente paso es programar la lógica en JavaScript para que el navegador los lea, asocie los nombres con sus coordenadas correspondientes y renderice tanto los puntos como las líneas de las rutas. Para lograrlo de manera eficiente, modificaremos el archivo `/static/js/mapa.js`. El archivo debería quedar de este modo:

```javascript
const mapa = L.map('mi_mapa').setView([40.416775, -3.703790], 5); 

L.tileLayer('/static/tiles/{z}/{x}/{y}.png', {
    minZoom: 3,
    maxZoom: 5,
    attribution: 'OpenStreetMap, CARTO'
}).addTo(mapa); 

Promise.all([
    fetch('/static/data/puntos.json').then(res => res.json()),
    fetch('/static/data/rutas.json').then(res => res.json())
])
.then(([puntos, rutas]) => {
    
    const mapaPuntos = {};
    puntos.forEach(punto => {
        mapaPuntos[punto.name] = punto;
    });

    puntos.forEach(punto => {
        const iconoPunto = L.divIcon({
            className: 'marcador-punto',
            iconSize: [8, 8],
            iconAnchor: [4, 4]
        });

        const marcador = L.marker(punto.coordinates, { icon: iconoPunto }).addTo(mapa);
        
        marcador.bindPopup(`<b>${punto.name}</b><br>${punto.country}`, {
            className: 'popup'
        });
    });

    rutas.forEach(trayecto => {
        const puntoOrigen = mapaPuntos[trayecto.from];
        const puntoDestino = mapaPuntos[trayecto.to];

        if (puntoOrigen && puntoDestino) {
            const coordenadasLinea = [
                puntoOrigen.coordinates,
                puntoDestino.coordinates
            ];

            L.polyline(coordenadasLinea, {
                className: 'linea-ruta'
            }).addTo(mapa);
        }
    });
})
.catch(error => console.error('Error al cargar o procesar los datos geoespaciales:', error));
```

La primera parte del código queda como estaba anteriormente escrita, con el mapa iniciándose con Madrid (España) en el centro y a un nivel de zoom 5. A partir de entonces, el código pide lo siguiente: 1) Carga con `fetch` los dos archivos JSON preparados en los pasos anteriores; 2) crea un mapa de búsqueda rápido indexado por el nombre del lugar; 3) dibuja los puntos de las escalas de la travesía. Se le da un nombre de clase (para editar su estilo posteriormente en CSS), con `iconSize` se indica su tamaño en píxeles y con `iconAnchor` se centra el punto en la coordenada exacta; 4) añade una ventana emergente básica con información del punto (el nombre y el país, leídos del JSON); 5) traza las líneas de las rutas, buscando el nombre en el mapa de búsqueda rápido creado en el punto 2, se validan y se dibuja la línea, dándole además su propio nombre de clase para editar su apariencia en el CSS.

Para modificar su apariencia, se deben incluir estilos CSS para las clases que se han definido. Para ello, abre el archivo `/static/css/styles.css` del proyecto e incluye, por ejemplo, estas líneas de código. No borres el código CSS que tuvieras anteriormente:

```css
/* Estilos para los puntos y las líneas de la travesía */
.linea-ruta {
    stroke: #f1c40f;
    stroke-width: 2.5;
    stroke-dasharray: 6, 8;
    stroke-opacity: 0.85;
    stroke-linecap: round;
}

@keyframes move {
    from { stroke-dashoffset: 30; }
    to { stroke-dashoffset: 0; }
}

.marcador-punto {
    background-color: #2c3e50;
    border: 1.5px solid #ffffff;
    border-radius: 50%;
    box-shadow: 0 0 3px rgba(0,0,0,0.3);
}
```


{% include figure.html filename="es-or-cartografia-interactiva-python-leaflet-03.png" alt="Visual description of figure image" caption="Figura 3. Vista del navegador renderizando la ruta propuesta una vez establecidos los puntos, las líneas y los estilos CSS." %}


Puedes probar a cambiar los parámetros de la hoja de estilos CSS para adaptarlos a tu gusto. Recuerda que también hemos creado una clase denominada `popup` por si quieres editar el modo en el que se visualizan las ventanas emergentes.

## Generación de un mapa interactivo narrativo
Una vez creado un mapa básico, las posibilidades de generar un mapa interactivo se abren como un abanico infinito. En esta lección crearemos una capa de interactividad en nuestra aplicación web cartográfica, de modo que el usuario pueda ejecutar la ruta seguida por los aviadores de forma dinámica. En cualquier caso, podrás adaptar con total flexibilidad el proyecto a tus necesidades.

### Código JS para el motor narrativo interactivo
En esta lección podrás generar, a modo de ejemplo, un motor narrativo que recorra y explique la ruta que siguieron aquellos aviadores. Para ello, con el fin de no romper el código que se había escrito hasta el momento, deberás generar otro código en JavaScript, donde irá integrado todo el código y el texto que se mostrará, incluidos los estilos. Abre un nuevo archivo en tu editor de código, pega el siguiente código y guárdalo, por ejemplo, como `narrativa.js` en la carpeta `/static/js/`.

```javascript
const textosHistoricos = {
    "Lisboa": `<b>Lisboa (Origen)</b><br><br>El viaje se inició desde el río Tajo, en frente de la Torre de Belém en Lisboa, a las cuatro y media de la tarde del 30 de marzo de 1922, en un avión monomotor Fairey IIID Mk II especialmente diseñado para este viaje, equipado con un motor Rolls-Royce y bautizado con el nombre de <i>Lusitania</i>. Sacadura Cabral ejercía las funciones de piloto y Gago Coutinho las de navegante. Este último había creado —y empleó durante el viaje— un sextante al que había adaptado un horizonte artificial. Este invento revolucionó la navegación aérea de la época.`,
    "Las Palmas de Gran Canaria": `<b>Gran Canaria</b><br><br>La primera etapa del viaje concluyó el mismo día en Las Palmas de Gran Canaria (Islas Canarias, España), donde los dos tripulantes notaron que el avión amarrado había consumido más combustible del que tenían pensado.`,
    "São Vicente": `<b>São Vicente</b><br><br>El 5 de abril partieron rumbo a la isla de São Vicente, en el archipiélago de Cabo Verde, recorriendo 850 millas. Allí tuvieron que permanecer hasta el 17 de abril debido a reparaciones en el hidroavión.`,
    "Praia": `<b>Praia</b><br><br>De ahí partieron a la cercana isla de Santiago, y desde su capital Praia pusieron rumbo al archipiélago de San Pedro y San Pablo, ya en aguas brasileñas.`,
    "Fernando de Noronha": `<b>Fernando de Noronha</b><br><br>Llegarían a San Pedro y San Pablo sin ayuda del viento el día 18. Debido al mar revuelto que había en ese lugar, el Lusitania perdió uno de sus flotadores. Los dos tripulantes fueron recogidos por un crucero de la Marina Portuguesa, que los condujo a Fernando de Noronha (archipiélago brasileño). A pesar de estar exhaustos después de haber recorrido 1700 kilómetros, y tras su amerizaje accidentado, habían llegado a aquel punto del Atlántico Sur contando únicamente con el sextante con horizonte artificial creado por Gago Coutinho.`,
    "Recife": `<b>Recife</b><br><br>Tras reanudar el vuelo con un nuevo aparato, los aviadores alcanzaron las playas de Recife en la costa continental brasileña, donde fueron recibidos con enorme entusiasmo por la población local, marcando el éxito del cruce oceánico.`,
    "Salvador de Bahía": `<b>Salvador de Bahía</b><br><br>Muy poco después, llegaron a Salvador de Bahía siguiendo su rumbo hacia el sur. Las dificultades técnicas continuaban, pero el sistema de navegación astronómica demostraba una precisión impecable en cada etapa.`,
    "Porto Seguro": `<b>Porto Seguro</b><br><br>Su siguiente parada fue Porto Seguro. En este punto de la costa, la expedición portuguesa ya había captado la atención de los medios internacionales, que seguían día a día las hazañas de los pilotos.`,
    "Vitória": `<b>Vitória</b><br><br>A escasa distancia de su meta, el hidroavión tocó aguas en Vitória. La tripulación realizó las últimas comprobaciones técnicas antes de emprender el tramo final hacia la capital cultural e histórica del país.`,
    "Río de Janeiro": `<b>Río de Janeiro (Destino Final)</b><br><br>El 17 de junio de 1922 amerizaron en la Bahía de Guanabara, en Río de Janeiro, donde Alberto Santos Dumont, considerado uno de los pioneros de la aviación, les abrazó emocionado.<br><br>Aclamados efusivamente como héroes en todas las ciudades brasileñas donde amerizaron, Gago Coutinho y Sacadura Cabral habían concluido con éxito la primera travesía aérea del Atlántico Sur, y por primera vez se había volado sobre el Océano Atlántico únicamente con la ayuda de la navegación astronómica.`
};

let capasRutasDibujadas = [];
let marcadorViajeroInstancia = null;

const iconoViajero = L.divIcon({
    html: `<div class="pulso-viajero"></div>`,
    className: 'marcador-viajero',
    iconSize: [20, 20],
    iconAnchor: [10, 10]
});

function inicializarCapaNarrativa() {
    const modalHTML = `
        <div id="modal-bienvenida" class="modal-overlay">
            <div class="modal-content">
                <h2>El primer vuelo a través del Atlántico Sur (1922)</h2>
                <p>Descubre la primera travesía aérea del Atlántico Sur. Un viaje de 79 días y 8.383 kilómetros que revolucionó la navegación aérea gracias a la ciencia y la tenacidad de los aviadores portugueses Gago Coutinho y Sacadura Cabral.</p>
                <button id="btn-comenzar" class="btn-play">
                    <svg viewBox="0 0 24 24" width="24" height="24"><path d="M8 5v14l11-7z" fill="currentColor"/></svg>
                    Iniciar Travesía
                </button>
            </div>
        </div>`;
    document.body.insertAdjacentHTML('afterbegin', modalHTML);

    const modal = document.getElementById('modal-bienvenida');
    const btnComenzar = document.getElementById('btn-comenzar');

    const mapa = window.mapaObjeto;
    const rutasCargadas = window.datosRutas;
    const puntosCargados = window.datosPuntos;

    btnComenzar.addEventListener('click', () => {
        modal.classList.add('oculto');
        
        mapa.eachLayer((layer) => {
            if (layer instanceof L.Polyline && layer.options.className === 'linea-ruta') {
                mapa.removeLayer(layer);
            }
        });
        // ------------------------------------
        
        setTimeout(() => {
            const coordenadasLisboa = puntosCargados["Lisboa"].coordinates;
            mapa.flyTo(coordenadasLisboa, 5, { animate: true, duration: 2 });

            mapa.once('moveend', () => {
                marcadorViajeroInstancia = L.marker(coordenadasLisboa, { icon: iconoViajero }).addTo(mapa);
                
                let contenidoLisboa = `<div class="popup-narrativo">${textosHistoricos["Lisboa"]}<br><br><small style="color:#777;">Fuente: <a href="https://es.wikipedia.org/wiki/Primera_traves%C3%ADa_a%C3%A9rea_del_Atl%C3%A1ntico_sur" target="_blank" style="color: inherit; text-decoration: none;">Wikipedia</a></small></div>`;
                contenidoLisboa += `<br><button id="btn-avanzar-inicio" style="width:100%; background:#2c3e50; color:white; border:none; padding:6px; cursor:pointer; border-radius:3px; font-weight:bold;">Continuar viaje</button>`;

                const popupInicial = L.popup({ maxWidth: 320, closeOnClick: false, closeButton: false })
                    .setLatLng(coordenadasLisboa)
                    .setContent(contenidoLisboa)
                    .openOn(mapa);

                let viajeIniciado = false;
                const iniciarVueloAnimado = () => {
                    if (viajeIniciado) return;
                    viajeIniciado = true;
                    mapa.closePopup(popupInicial);
                    animarTrayectos(mapa, marcadorViajeroInstancia, rutasCargadas, puntosCargados);
                };

                setTimeout(() => {
                    const btnInicio = document.getElementById("btn-avanzar-inicio");
                    if (btnInicio) btnInicio.addEventListener('click', iniciarVueloAnimado);
                }, 100);
            });
        }, 500);
    });
}

function animarTrayectos(mapa, marcador, rutas, mapaPuntos) {
    let indiceTrayecto = 0;
    const velocidadPixelsPorSegundo = 150; 

    function ejecutarSiguienteTramo() {
        if (indiceTrayecto >= rutas.length) return;

        const trayecto = rutas[indiceTrayecto];
        const origen = mapaPuntos[trayecto.from];
        const destino = mapaPuntos[trayecto.to];

        if (!origen || !destino) return;

        const nuevaLinea = L.polyline([origen.coordinates, destino.coordinates], {
            className: 'linea-animada'
        }).addTo(mapa);
        capasRutasDibujadas.push(nuevaLinea);

        const pOrigen = origen.coordinates;
        const pDestino = destino.coordinates;

        const puntoA = mapa.latLngToLayerPoint(pOrigen);
        const puntoB = mapa.latLngToLayerPoint(pDestino);
        const distanciaPixels = puntoA.distanceTo(puntoB);
        
        const duracionTramo = Math.max(1000, (distanciaPixels / velocidadPixelsPorSegundo) * 1000);

        mapa.panTo(pDestino, { animate: true, duration: duracionTramo / 1000 });

        let inicioTiempo = null;

        function darPasoAnimacion(tiempoActual) {
            if (!inicioTiempo) inicioTiempo = tiempoActual;
            const progreso = (tiempoActual - inicioTiempo) / duracionTramo;

            if (progreso < 1) {
                const latIntermedia = pOrigen[0] + (pDestino[0] - pOrigen[0]) * progreso;
                const lngIntermedia = pOrigen[1] + (pDestino[1] - pOrigen[1]) * progreso;
                marcador.setLatLng([latIntermedia, lngIntermedia]);
                requestAnimationFrame(darPasoAnimacion);
            } else {
                marcador.setLatLng(pDestino);
                finalizarTramo(destino);
            }
        }

        requestAnimationFrame(darPasoAnimacion);
    }

    function finalizarTramo(destino) {
        const nombreDestino = destino.name;
        let contenidoPopup = "";
        const esUltimoDestino = (indiceTrayecto === rutas.length - 1);

        if (textosHistoricos[nombreDestino]) {
            contenidoPopup = `<div class="popup-narrativo">${textosHistoricos[nombreDestino]}<br><br><small style="color:#777;">Fuente: <a href="https://es.wikipedia.org/wiki/Primera_traves%C3%ADa_a%C3%A9rea_del_Atl%C3%A1ntico_sur" target="_blank" style="color: inherit; text-decoration: none;">Wikipedia</a></small></div>`;
        } else {
            contenidoPopup = `<div class="popup-narrativo" style="text-align:center; padding: 15px 0 5px 0;"><b>Llegada a ${nombreDestino}</b></div>`;
        }

        const idBoton = "btn-avanzar-" + indiceTrayecto;
        if (esUltimoDestino) {
            contenidoPopup += `<br><button id="${idBoton}" style="width:100%; background:#c0392b; color:white; border:none; padding:6px; cursor:pointer; border-radius:3px; font-weight:bold;">Finalizar travesía</button>`;
        } else {
            contenidoPopup += `<br><button id="${idBoton}" style="width:100%; background:#2c3e50; color:white; border:none; padding:6px; cursor:pointer; border-radius:3px; font-weight:bold;">Continuar viaje</button>`;
        }

        const popup = L.popup({ maxWidth: 320, closeOnClick: false, closeButton: false })
            .setLatLng(destino.coordinates)
            .setContent(contenidoPopup)
            .openOn(mapa);

        const avanzarHandler = () => {
            mapa.closePopup(popup);
            
            if (esUltimoDestino) {
                if (marcadorViajeroInstancia) mapa.removeLayer(marcadorViajeroInstancia);
                capasRutasDibujadas.forEach(linea => mapa.removeLayer(linea));
                capasRutasDibujadas = [];
                const modal = document.getElementById('modal-bienvenida');
                modal.classList.remove('oculto');
            } else {
                indiceTrayecto++;
                ejecutarSiguienteTramo();
            }
        };

        setTimeout(() => {
            const btn = document.getElementById(idBoton);
            if (btn) btn.addEventListener('click', avanzarHandler);
        }, 100);
    }

    ejecutarSiguienteTramo();
}

window.addEventListener('mapaBaseListo', () => {
    inicializarCapaNarrativa();
});
```


{% include figure.html filename="es-or-cartografia-interactiva-python-leaflet-04.png" alt="Visual description of figure image" caption="Figura 4. Vista del navegador con la página de inicio de la capa de interactividad iniciada." %}


Para aquellas personas que no sean avezadas programadoras, la fórmula más adecuada para crear una capa de personalización es con la ayuda de una Inteligencia Artificial, a la que se le puede pedir en el *prompt*, con lenguaje natural todas las características que se desean. No obstante, en función de la versión utilizada, este procedimiento puede ser tedioso. Es altamente probable que se tengan que repetir instrucciones, corregir errores o solicitar cambios para mejorar la capa interactiva.

### Código CSS para los estilos del motor narrativo interactivo
A continuación, es imprescindible crear una nueva hoja de estilos que contenga las especificaciones estéticas de la capa interactiva. Abre tu editor de código y crea un archivo llamado, por ejemplo, `narrativa.css`. A continuación pega el siguiente código y guárdalo en `/static/css/`:

```css
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100vh;
    background-color: rgba(244, 241, 234, 0.75);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
    transition: opacity 1s ease, visibility 1s;
}

.modal-overlay.oculto {
    opacity: 0;
    visibility: hidden;
    pointer-events: none;
}

.modal-content {
    background: #ffffff;
    padding: 40px;
    border-radius: 8px;
    max-width: 520px;
    text-align: center;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
    border-top: 5px solid #2c3e50;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

.modal-content h2 {
    font-family: 'Georgia', serif;
    margin-top: 0;
    color: #2c3e50;
    font-size: 28px;
}

.modal-content p {
    font-size: 15px;
    line-height: 1.6;
    color: #555;
    margin-bottom: 30px;
}

.btn-play {
    background-color: #2c3e50;
    color: white;
    border: none;
    padding: 12px 24px;
    font-size: 15px;
    font-weight: bold;
    border-radius: 4px;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 10px;
    transition: background-color 0.3s;
}

.btn-play:hover {
    background-color: #34495e;
}

.pulso-viajero {
    width: 14px;
    height: 14px;
    background-color: #e74c3c;
    border: 3px solid #ffffff;
    border-radius: 50%;
    box-shadow: 0 0 10px #e74c3c;
}

.popup-narrativo {
    font-family: 'Georgia', serif;
    font-size: 13.5px;
    line-height: 1.6;
    color: #2c3e50;
    max-height: 220px;
    overflow-y: auto;
    padding-right: 5px;
}

.popup-narrativo {
    scrollbar-width: thin;
    scrollbar-color: #bdc3c7 #f4f1ea;
}

.popup-narrativo::-webkit-scrollbar {
    width: 4px;
}

.popup-narrativo::-webkit-scrollbar-track {
    background: #f4f1ea;
    border-radius: 10px;
}

.popup-narrativo::-webkit-scrollbar-thumb {
    background: #bdc3c7; 
    border-radius: 10px;
}

.popup-narrativo::-webkit-scrollbar-thumb:hover {
    background: #95a5a6; 
}


.linea-animada {
    stroke: #f1c40f !important;
    stroke-linecap: round;
    stroke-dasharray: 8;
    animation: move 1s linear infinite;
    cursor: pointer;
    filter: drop-shadow(0 0 5px #f1c40f);
    stroke-opacity: 1 !important;
    stroke-width: 4 !important;
}
```

Puedes hacer todos los cambios que creas adecuados. Si no manejas las hojas de estilo CSS, puedes utilizar la herramienta "Inspeccionar" disponible en los navegadores e ir modificando parámetros para ver los cambios en tiempo real. Del mismo modo, también puedes pedirle a una IA que te ayude.

### Modificación del motor inicial (mapa.js)
Con el fin de integrar la capa de interactividad, deberás hacer un pequeño cambio en el archivo JS que controlaba el motor de los mapas, `mapa.js`. Deberás añadir esta pieza de código para unir ambos códigos inmediatamente antes de las tres líneas finales de `.catch`:

```javascript
    window.mapaObjeto = mapa;        
    window.datosRutas = rutas;       
    window.datosPuntos = mapaPuntos; 
    
    window.dispatchEvent(new Event('mapaBaseListo'));
})
```

El archivo `mapa.js` completo debería quedar de este modo:

```javascript
const mapa = L.map('mi_mapa').setView([40.416775, -3.703790], 5); 

L.tileLayer('/static/tiles/{z}/{x}/{y}.png', {
    minZoom: 3,
    maxZoom: 5,
    attribution: 'OpenStreetMap, CARTO'
}).addTo(mapa); 

Promise.all([
    fetch('/static/data/puntos.json').then(res => res.json()),
    fetch('/static/data/rutas.json').then(res => res.json())
])
.then(([puntos, rutas]) => {
    
    const mapaPuntos = {};
    puntos.forEach(punto => {
        mapaPuntos[punto.name] = punto;
    });

    puntos.forEach(punto => {
        const iconoPunto = L.divIcon({
            className: 'marcador-punto',
            iconSize: [8, 8],
            iconAnchor: [4, 4]
        });

        const marcador = L.marker(punto.coordinates, { icon: iconoPunto }).addTo(mapa);
        
        marcador.bindPopup(`<b>${punto.name}</b><br>${punto.country}`, {
            className: 'popup'
        });
    });

    rutas.forEach(trayecto => {
        const puntoOrigen = mapaPuntos[trayecto.from];
        const puntoDestino = mapaPuntos[trayecto.to];

        if (puntoOrigen && puntoDestino) {
            const coordenadasLinea = [
                puntoOrigen.coordinates,
                puntoDestino.coordinates
            ];

            L.polyline(coordenadasLinea, {
                className: 'linea-ruta'
            }).addTo(mapa);
        }
    });

    window.mapaObjeto = mapa;        
    window.datosRutas = rutas;       
    window.datosPuntos = mapaPuntos; 
    
    window.dispatchEvent(new Event('mapaBaseListo'));
})
.catch(error => console.error('Error al cargar o procesar los datos geoespaciales:', error));
```

### Integración de la capa interactiva en index.html
Para que la nueva capa interactiva funcione, debes llamar en `index.html` a los nuevos archivos que has creado. Deberás incluir las líneas para llamar a `narrativa.js` y a `narrativa.css`. Abre el archivo con tu editor de código y añade las llamadas. El archivo final debería quedar de este modo:


```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mapa Web Interactivo - Lección de Programming Historian</title>

    <link rel="stylesheet" href="{{ url_for('static', filename='css/leaflet.css') }}">
    <link rel="stylesheet" href="{{ url_for('static', filename='css/styles.css') }}">
    <link rel="stylesheet" href="{{ url_for('static', filename='css/narrativa.css') }}">
</head>

<body>

    <div id="mi_mapa"></div>
	
    <script src="{{ url_for('static', filename='js/leaflet.js') }}"></script>
    <script src="{{ url_for('static', filename='js/mapa.js') }}"></script>
    <script src="{{ url_for('static', filename='js/narrativa.js') }}"></script>

</body>
</html>
```


{% include figure.html filename="es-or-cartografia-interactiva-python-leaflet-05.png" alt="Visual description of figure image" caption="Figura 5. Vista del navegador con la aplicación interactiva en funcionamiento durante la parada en Cabo Verde de la ruta propuesta." %}


## Del entorno local a un servidor o página web: exportación de la app
El proyecto presentado en esta lección funciona actualmente en un entorno local (`http://127.0.0.1:5000/`). Sin embargo, si deseas que la aplicación sea pública, hay varios modos de proceder en función de la estructura donde quieras integrar el mapa.

### Despliegue directo de la aplicación Flask
Al ser una aplicación basada en Python, puedes alojar el proyecto completo en servidores web que soporten este lenguaje. Al hacerlo, el mapa tendrá su propio dominio web público. Esta es una solución adecuada cuando se trata de proyectos más completos y complejos.

### Integración de la aplicación en una página web existente
Una de las ventajas de este proyecto es que, aunque se ha empleado Flask como servidor local, la aplicación no depende de una base de datos ni de un procesamiento extraordinariamente complejo en el servidor. Todo lo que el navegador necesita para renderizar el mapa son archivos estáticos: HTML, CSS, JavaScript y, en su caso, las imágenes de las teselas.

Puedes adaptar la estructura para una web estática prescindiendo de Flask. Para ello, deberás eliminar las etiquetas Flask del HTML y modificar los JS para que utilicen rutas relativas limpias (por ejemplo, cambiando `static/data/puntos.json` por simplemente `data/puntos.json`). Con esta base, la aplicación será publicable en casi cualquier entorno. Sin embargo, debido a la elevada casuística respecto a la publicación en la web, deberás revisar las especificaciones de tu servidor o de los recursos que manejes (Wordpress, GitHub Pages, página institucional de la Universidad...). Pídele a una IA que te ayude a hacerlo si no sabes cómo desarrollarlo para tu caso en concreto.


## Conclusiones

En esta lección has podido crear una cartografía web de forma completamente autónoma, tanto para representar puntos y líneas sobre un mapa como para crear una experiencia interactiva más completa. A lo largo del proceso, se ha podido aprender a configurar un servidor local con Flask y a desplegar un motor de mapas como Leaflet con el fin de disponer de pleno control sobre la cartografía.

El almacenamiento de los datos geoespaciales en formatos abiertos (como JSON), la personalización completa de la estética de la aplicación mediante CSS y, fundamentalmente, el almacenamiento de las teselas de forma local, convierten este proyecto en un sistema completamente autónomo. La aplicación web generada no dejará de funcionar si una empresa externa cierra sus servidores, o modifica sus políticas de utilización o de precios. Con la infraestructura propuesta, el mapa seguirá activo mientras se disponga de un navegador y de los archivos creados.

La estructura es además es flexible y escalable. A partir de aquí, las posibilidades de expansión son tan amplias como tus propias necesidades: puedes adaptar este sistema a tu propia investigación y datos. Del mismo modo, es posible enriquecer sin límites los archivos JSON para incluir más datos o imágenes, etc. El desarrollo de la interactividad depende únicamente de tus ideas. En el caso propuesto, se podrían añadir controles temporales para marcar los 79 días que duró la travesía, o adaptar el motor narrativo para mostrar cualquier otro elemento de interés. Al controlar cada una de las líneas de código, la aplicación puede adaptarse, literalmente, a cualquier necesidad.

Si bien esta lección se ha inspirado en los principios de computación mínima y de autonomía digital, no se ha querido prescindir de las potencialidades de las herramientas de Inteligencia Artificial más habituales. No obstante, se ha indicado solo su utilización como un recurso interesante para agilizar y automatizar procesos manuales. En cualquier caso, no son una piedra angular de la lección: se podría prescindir de ellas sin impacto sobre los resultados. Del mismo modo, si no se desea utilizar las herramientas de IA de carácter cerrado como ChatGPT, Gemini, Claude o Copilot, se podría recurrir a modelos abiertos ejecutados en local. No obstante, para alcanzar un nivel de eficacia adecuado para las tareas propuestas, se necesitarían equipos con recursos más elevados que un equipo informático básico.
