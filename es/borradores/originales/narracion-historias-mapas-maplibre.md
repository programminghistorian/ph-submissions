---
title: "Narración de historias con mapas usando el software libre MapLibre"
slug: narracion-historias-mapas-maplibre
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Felipe Valdez
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/708
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Objetivos de la lección

Al finalizar esta lección serás capaz de:

- Identificar el valor de los mapas interactivos como medio para contar historias situadas en el espacio.
- Comprender los conceptos básicos de los mapas web: mapa base, coordenadas, niveles de zoom, cámara y capas.
- Construir una aplicación de narración con desplazamiento (*scrollytelling*) que combina mapas, texto e imágenes usando la biblioteca de software libre MapLibre GL JS.
- Publicar tu aplicación de forma gratuita y sustentable mediante GitHub Pages.

## Introducción

Muchas de las historias que investigamos en las humanidades ocurren en el espacio: una expedición que cruza un océano, una comunidad que se desplaza, un edificio que cambia de uso a lo largo de un siglo. Cuando los lugares y el espacio son parte esencial de la narrativa, un mapa puede hacer mucho más que ilustrar: puede estructurar el relato.

Los *story maps* o mapas narrativos son aplicaciones web que combinan un mapa interactivo con textos, imágenes y otros elementos multimedia. En su variante más difundida, conocida como *scrollytelling* (narración por desplazamiento), el lector avanza por la historia haciendo *scroll*: a medida que cada sección de texto entra en pantalla, el mapa responde volando hacia un nuevo lugar, cambiando de escala, inclinándose para mostrar el relieve o encendiendo nuevas capas de información. El resultado es una experiencia de lectura en la que el mapa y el texto avanzan juntos.

Existen herramientas comerciales muy conocidas para crear este tipo de aplicaciones, como ArcGIS StoryMaps de Esri o las plantillas de narración de Mapbox. Sin embargo, suelen depender de plataformas de pago, de claves de acceso (*API keys*) asociadas a tarjetas de crédito, o de servicios cuyas condiciones pueden cambiar sin aviso. Para proyectos académicos, esa dependencia plantea un problema de sustentabilidad: ¿seguirá funcionando tu proyecto digital dentro de cinco años, cuando termine la suscripción o cambie el modelo de negocio?

Esta lección propone una alternativa libre y gratuita. Usaremos [MapLibre GL JS](https://maplibre.org/), una biblioteca de JavaScript de código abierto para mapas interactivos; [OpenFreeMap](https://openfreemap.org/), un servicio de mapas base que no requiere registro ni clave de API; una [plantilla](https://github.com/digidem/maplibre-storymap) de narración de código abierto desarrollada por la organización [Awana Digital](https://awana.digital/) (antes conocida como Digital Democracy); y [GitHub Pages](https://pages.github.com/) para publicar el resultado sin costo. Todos los componentes son abiertos, todos los archivos quedan bajo tu control y el producto final es un sitio web estático que puede alojarse en cualquier servidor.

No necesitas saber programar para seguir esta lección. La plantilla que usaremos concentra casi todas las decisiones en un solo archivo de configuración, `config.js`, que editaremos paso a paso. Trabajar con este archivo te dará, además, una introducción práctica a conceptos de programación (objetos, propiedades, coordenadas) que son transferibles a muchos otros proyectos de humanidades digitales.

### El caso de estudio: medir la Tierra

Para aprender la herramienta construiremos una historia real, y deliberadamente cartográfica: la de la **Misión Geodésica Francesa al Ecuador (1736–1743)**.

En 1734, la Academia Real de Ciencias de París buscaba resolver una disputa que dividía a la ciencia europea: ¿es la Tierra un esferoide achatado en los polos, como sostenía Isaac Newton, o achatado en el ecuador, como defendía la escuela de Jacques Cassini? Para responder, la Academia envió dos expediciones a medir arcos de meridiano en los extremos del planeta: una a Laponia y otra al territorio de la Real Audiencia de Quito, en el actual Ecuador. La expedición ecuatoriana —integrada por científicos franceses como Charles-Marie de La Condamine y Pierre Bouguer, los oficiales españoles Jorge Juan y Antonio de Ulloa, y colaboradores criollos como el cartógrafo Pedro Vicente Maldonado— pasó ocho años midiendo montañas mediante triangulación. Sus resultados confirmaron la teoría newtoniana y, de paso, dieron nombre a un país: la palabra *équateur*, popularizada por las publicaciones de la expedición, bautizaría a la república del Ecuador en 1830.

Este caso tiene una virtud pedagógica poco común: el medio reproduce el objeto. La expedición midió el espacio andino con triángulos trazados entre cumbres; nuestro *story map* mostrará ese mismo espacio con líneas y puntos sobre un mapa interactivo. Cada recurso técnico que aprenderás tendrá una justificación narrativa literal: la cámara inclinada para ver los volcanes que la expedición escalaba, el vuelo largo sobre el Atlántico que cruzaron en 1735, las capas que dibujan la red de triangulación que ellos dibujaban en papel. Además, casi todo el material visual de la historia —grabados, retratos y mapas del siglo XVIII— está en dominio público, lo que nos permitirá seguir buenas prácticas de derechos de autor sin fricciones.

Puedes ver una [versión funcional del resultado final](https://felipevaldez.com/mision-geodesica/) antes de comenzar, y también revisar otros ejemplos creados con esta misma técnica, como [The Evolution of Fletcher Street's Horse Stables](https://fletcherststorymap.com/) o [A Tour of Temple University Campuses](https://felipevaldez.com/maplibre-storymap_demoTU/). A lo largo de la lección construiremos juntos una versión reducida de esta historia, con tres capítulos que concentran las técnicas esenciales; los archivos terminados de esta versión ([`config.js`](/assets/narracion-historias-mapas-maplibre/config.js) y [`sources.js`](/assets/narracion-historias-mapas-maplibre/sources.js)) acompañan a la lección para que puedas compararlos con los tuyos en cualquier momento.

## Prerrequisitos y requisitos técnicos

Esta lección está diseñada para principiantes. Necesitarás:

- Una cuenta gratuita en [GitHub](https://github.com/). Si nunca has usado GitHub, la lección [Creación de sitios estáticos con Jekyll y GitHub Pages](/es/lecciones/sitios-estaticos-con-jekyll-y-github-pages) ofrece una introducción útil, aunque aquí explicaremos todos los pasos necesarios.
- Un navegador web moderno y una conexión a internet.
- Opcionalmente, un editor de texto como [Visual Studio Code](https://code.visualstudio.com/). También es posible completar toda la lección editando los archivos directamente en el navegador, con el editor web de Gitub (github.dev), por lo que no es indispensable instalar nada.

No se requiere experiencia previa con JavaScript. Sí es útil, aunque no obligatorio, haber trabajado antes con algún archivo de texto estructurado (HTML, JSON o similares), porque el archivo de configuración exige atención a la puntuación: llaves, corchetes, comas y comillas deben respetarse con precisión.

La lección funciona en cualquier sistema operativo (Windows, macOS, Linux) porque todo el trabajo ocurre en el navegador o en un editor de texto.

## La anatomía de un story map

Antes de escribir una sola línea, conviene entender las piezas. Nuestro *story map* será un **sitio web estático**: un conjunto de archivos que cualquier servidor puede entregar tal cual, sin bases de datos ni programas ejecutándose del lado del servidor. Esa simplicidad es la clave de su sustentabilidad.

La plantilla [maplibre-storymap](https://github.com/digidem/maplibre-storymap), creada por Awana Digital a partir de la plantilla de narración original de Mapbox, organiza el proyecto en unos pocos archivos:

- `index.html`: la página web que el lector abre. Contiene la estructura de la aplicación y el código JavaScript que sincroniza el desplazamiento del texto con los movimientos del mapa. **En general no necesitarás tocarlo**, salvo un pequeño ajuste que haremos en la sección de capas personalizadas.
- `config.js`: el corazón del proyecto. Aquí se define todo lo que hace única a tu historia: el título, el mapa base, y la lista de capítulos con sus textos, imágenes y posiciones de cámara. **Este es el archivo que editaremos durante casi toda la lección.**
- `sources.js`: un archivo opcional donde se definen capas de datos propias (puntos, líneas, polígonos) que el mapa puede encender y apagar a medida que avanza la historia.
- `images/`: la carpeta donde colocarás las imágenes de cada capítulo.
- `map/`: una carpeta pensada para alojar estilos y teselas de mapa propias. En esta lección no la usaremos, porque tomaremos el mapa base directamente de OpenFreeMap.

El principio de funcionamiento es simple: la historia se divide en **capítulos**. Cada capítulo es un bloque de texto (con imagen opcional) asociado a una posición de cámara sobre el mapa. Cuando el lector hace *scroll* y un capítulo entra en pantalla, una biblioteca llamada Scrollama lo detecta y ordena al mapa moverse a la posición correspondiente. Opcionalmente, el capítulo puede además encender o apagar capas de datos.

## Paso 1: Obtener la plantilla

Comencemos por copiar la plantilla a tu propia cuenta de GitHub:

1. Inicia sesión en GitHub y visita el repositorio de la plantilla: https://github.com/digidem/maplibre-storymap

{% include figure.html filename="es-or-narracion-historias-mapas-maplibre-01.png" alt="Captura de pantalla mostrando el boton fork" caption="Figura 1. Repositorio de la plantilla en GitHub." %}

1. Haz clic en el botón **Fork** (arriba a la derecha). Esto crea una copia completa del repositorio en tu cuenta, que podrás modificar libremente. Puedes darle un nombre propio, por ejemplo `mision-geodesica`.

{% include figure.html filename="es-or-narracion-historias-mapas-maplibre-02.png" alt="Captura de pantalla mostrando opción de renombrar el fork de la plantilla" caption="Figura 2. Renombrar el fork de la plantilla." %}

1. En tu copia del repositorio, localiza el archivo `config.js.example`. La plantilla lo incluye como modelo: nuestra primera tarea es crear a partir de él el archivo `config.js` que la aplicación realmente lee.

Para crear el archivo sin salir del navegador: abre `config.js.example`, copia todo su contenido, vuelve a la página principal del repositorio, pulsa **Add file > Create new file**, nombra el archivo `config.js`, pega el contenido y confirma con **Commit changes**.

{% include figure.html filename="es-or-narracion-historias-mapas-maplibre-03.png" alt="Captura de pantalla mostrando el proceso de creación de un nuevo archivo config.js" caption="Figura 3. Creación de un nuevo archivo 'config.js' en repositorio." %}

<div class="alert alert-info">
Si prefieres trabajar en tu computadora, puedes clonar el repositorio con Git o descargarlo como archivo ZIP (botón <b>Code > Download ZIP</b>), editar los archivos con tu editor de texto, y abrir <code>index.html</code> en el navegador para previsualizar los cambios localmente. Ambas rutas, navegador o edición local, llegan al mismo resultado.
</div>

Un truco muy útil para editar desde el navegador con comodidad: estando en la página de tu repositorio, presiona la tecla `.` (punto). GitHub abrirá el editor web github.dev, una versión de Visual Studio Code en el navegador que permite editar varios archivos y confirmar los cambios desde un solo lugar.

## Paso 2: La configuración general

Abre tu nuevo `config.js`. Verás que todo el archivo define una sola variable, `config`, que es un **objeto** de JavaScript: una colección de pares `propiedad: valor` encerrada entre llaves. Las primeras propiedades controlan la aplicación en su conjunto; la última, `chapters`, contiene la lista de capítulos.

Reemplaza el bloque inicial por la configuración de nuestro proyecto:

```javascript
var config = {
    style: 'https://tiles.openfreemap.org/styles/liberty',
    showMarkers: false,
    markerColor: '#3FB1CE',
    inset: true,
    legend: false,
    theme: 'dark',
    use3dTerrain: false,
    useCustomLayers: true,
    bookmarks: false,
    chapterReturn: false,
    title: 'Medir la Tierra',
    logo: '',
    subtitle: 'La Misión Geodésica Francesa al Ecuador (1736–1743)',
    byline: 'Por Felipe Valdez',
    footer: 'Fuentes: La Condamine (1745, 1751), Gallica BnF; Juan y Ulloa (1748), BNE. Creado con la plantilla <a href="https://github.com/digidem/maplibre-storymap" target="_blank">MapLibre Storytelling</a> y datos de <a href="https://openfreemap.org" target="_blank">OpenFreeMap</a>.',
    chapters: [
        // aquí irán los capítulos
    ]
};
```
{% include figure.html filename="es-or-narracion-historias-mapas-maplibre-04.png" alt="Captura de pantalla mostrando el proceso de edición del archivo 'config.js' en el editor web." caption="Figura 4. Edición del archivo 'config.js' en el editor web de GitHub." %}

Detengámonos en las propiedades más importantes:

**`style`** define el **mapa base**: la cartografía de fondo sobre la que se contará la historia. Un estilo de MapLibre es un documento JSON que indica qué datos dibujar (calles, ríos, edificios, etiquetas) y con qué apariencia. Aquí usamos el estilo *Liberty* de OpenFreeMap, un servicio comunitario que sirve mapas del mundo entero basados en OpenStreetMap, sin exigir registro, clave de API ni tarjeta de crédito. OpenFreeMap ofrece otros estilos que puedes probar cambiando el final de la dirección: `bright` (colores vivos), `positron` (gris claro, ideal para resaltar datos propios) o `fiord` (oscuro). Si en el futuro quisieras un estilo totalmente personalizado, podrías diseñarlo con el editor libre [Maputnik](https://maplibre.org/maputnik/) y alojarlo en la carpeta `map/` de tu repositorio.

**`showMarkers`** controla si aparece un marcador en el punto central de cada capítulo. Lo desactivamos porque nuestros capítulos usarán vistas panorámicas e inclinadas donde un marcador central resultaría confuso; en su lugar, dibujaremos nuestras propias capas.

**`theme`** ofrece dos apariencias para los recuadros de texto (`light` y `dark`). Elegimos `dark` para que contraste con los tonos claros del estilo Liberty y con los grabados en sepia del siglo XVIII.

**`inset`** activa un minimapa de referencia en una esquina, útil cuando la historia salta entre escalas muy distintas, como la nuestra, que va del planeta entero a una llanura andina.

**`use3dTerrain`** y **`useCustomLayers`** activan funciones que veremos más adelante: el relieve tridimensional (opcional) y las capas de datos propias definidas en `sources.js`. Deja la primera en `false` por ahora y la segunda en `true`.

Las propiedades `title`, `subtitle`, `byline` y `footer` componen la portada y el pie de la historia. Nota que `footer` admite HTML: es el lugar correcto para citar tus fuentes y acreditar las herramientas, una cortesía académica que además exige la buena práctica del software libre.

<div class="alert alert-warning">
La sintaxis de <code>config.js</code> es estricta. Cada propiedad termina en coma, excepto la última de cada objeto; los textos van entre comillas simples; y si tu texto contiene un apóstrofo (por ejemplo, <em>d'un voyage</em>), debes «escaparlo» anteponiendo una barra invertida: <code>d\'un voyage</code>. Un error de puntuación es la causa más común de que la página aparezca en blanco. Si eso ocurre, abre la consola del navegador (tecla F12) y busca el mensaje de error, que suele indicar la línea exacta del problema.
</div>

## Paso 3: El primer capítulo y la cámara del mapa

Ahora crearemos el primer capítulo dentro de la lista `chapters`. Cada capítulo es, de nuevo, un objeto con propiedades. Este es el capítulo de apertura de nuestra historia:

```javascript
        {
            id: 'cap-0-apertura',
            alignment: 'left',
            hidden: false,
            title: '¿Qué forma tiene la Tierra?',
            image: './images/cap0_esferoide_newton.jpg',
            caption: 'Comparación de los dos modelos del esferoide terrestre, siglo XVIII. Dominio público.',
            description: 'En 1734, la Academia Real de Ciencias de París enfrentaba una disputa que dividía a la ciencia europea: ¿es la Tierra un esferoide achatado en los polos, como sostenía Isaac Newton, o achatado en el ecuador, como defendía la escuela de Jacques Cassini? La única forma de resolverlo era medir. La Academia decidió enviar dos expediciones simultáneas a los extremos del planeta: una a Laponia, dirigida por Maupertuis (1736–1737), y otra al territorio de la Real Audiencia de Quito, en el actual Ecuador.',
            location: {
                center: [0.0, 0.0],
                zoom: 1.6,
                pitch: 0,
                bearing: 0
            },
            mapAnimation: 'jumpTo',
            rotateAnimation: false,
            mapInteractive: false,
            callback: '',
            onChapterEnter: [],
            onChapterExit: []
        }
```

Las propiedades narrativas son fáciles de leer: `id` es un identificador único sin espacios (se convierte en el `id` HTML de la sección, por lo que conviene el formato con guiones); `alignment` decide si el recuadro de texto se alinea a la izquierda, derecha o centro sobre el mapa; `title`, `description`, `image` y `caption` son el contenido visible. La `description` admite HTML, así que puedes usar `<em>`, `<strong>` o enlaces dentro del texto.

La parte nueva, y el concepto central de toda la lección, es el objeto `location`, que define la **cámara** del mapa. A diferencia de un mapa impreso, un mapa web se comporta como una cámara de cine suspendida sobre el globo, y tú controlas cuatro parámetros:

- **`center`**: las coordenadas del punto que la cámara enfoca, en el orden `[longitud, latitud]`. Cuidado: este orden es el inverso del habitual "latitud, longitud" de Google Maps, y confundirlo es uno de los errores más frecuentes (tu mapa aparecerá en medio del océano o en otro continente). Para obtener coordenadas puedes hacer clic derecho en Google Maps o usar [OpenStreetMap](https://www.openstreetmap.org/).
- **`zoom`**: el nivel de acercamiento, de 0 (el mundo entero) a 22 (un edificio). Como referencia: 4–5 muestra una región continental, 10–12 una ciudad, 15–16 un barrio o sitio específico.
- **`pitch`**: la inclinación de la cámara en grados. `0` es una vista cenital, perpendicular al suelo, como un mapa tradicional; `60` es una vista muy inclinada, casi de horizonte, que da profundidad y dramatismo.
- **`bearing`**: la rotación respecto al norte, en grados en sentido horario. `0` mantiene el norte arriba; `90` mira hacia el este; `270` (o `-90`) hacia el oeste.

{% include figure.html filename="es-or-narracion-historias-mapas-maplibre-05.png" alt="Captura de pantalla mostrando la adición del primer capitulo al archivo 'config.js' en el editor web." caption="Figura 5. Añadiendo los parámetros del primer capítulo en el archivo 'config.js' en el editor web de GitHub." %}

Nuestro capítulo de apertura usa estos parámetros con intención retórica: `center: [0.0, 0.0]` (la intersección del ecuador con el meridiano de Greenwich), `zoom: 1.6` y `pitch: 0` producen una vista planetaria, abstracta y sin dirección privilegiada, exactamente el tono de la pregunta científica que abre el relato: ¿qué forma tiene la Tierra? Cuando quieras transmitir abstracción y escala global, esta combinación —zoom muy bajo, cámara cenital— es la fórmula.

<div class="alert alert-info">
Una gran ayuda para obtener todos estos parámetros es la web [Location Helper](https://labs.mapbox.com/location-helper/#3/40.78/-73.97) de Mapbox. Muestra un mapa web en el que se puede navegar y obtener los parámetros 'center', 'zoom', 'pitch' y 'bearing' que corresponden al contenido visible en la pantalla.
</div>

Por último, `mapAnimation: 'jumpTo'` indica que el mapa debe presentarse en esta posición sin transición animada. Es la opción natural para el primer capítulo, donde no hay un "antes" desde el cual volar.

Guarda el archivo (o confirma el *commit*) y previsualiza: deberías ver la portada, el globo terráqueo y el primer recuadro de texto.

## Paso 4: Transiciones que narran

Los capítulos siguientes introducen el recurso más expresivo de la plantilla: la **transición** entre posiciones de cámara. La propiedad `mapAnimation` acepta tres valores:

- `flyTo`: la cámara "despega", vuela en arco y "aterriza" en el nuevo destino. Es la transición cinematográfica por excelencia y la opción por defecto.
- `easeTo`: un desplazamiento suave y directo, sin cambio de altura. Útil entre puntos cercanos.
- `jumpTo`: un corte seco, sin animación.

Veamos el segundo capítulo, el embarque de la expedición en el puerto de La Rochelle en mayo de 1735:

```javascript
        {
            id: 'cap-1-la-rochelle',
            alignment: 'left',
            hidden: false,
            title: 'La Rochelle: el embarque',
            image: './images/cap1_la_condamine_carmontelle.jpg',
            caption: 'Retrato de Charles-Marie de La Condamine por Carmontelle. Wikimedia Commons, dominio público.',
            description: 'El 16 de mayo de 1735 zarpa del puerto de La Rochelle el navío <em>Portefaix</em>. A bordo viaja un equipo singular: los académicos Charles-Marie de La Condamine, Pierre Bouguer y Louis Godin; el botánico Joseph de Jussieu; el médico Jean Seniergues; el cartógrafo Jean-Baptiste Verguin; el dibujante Jean-Louis de Morainville; y Hugot, el relojero encargado de mantener vivos los instrumentos. Llevan consigo cuadrantes, relojes de péndulo y toesas de hierro: instrumentos de precisión nunca antes embarcados hacia América.',
            location: {
                center: [-1.1517, 46.1591],
                zoom: 13,
                pitch: 30,
                bearing: 270
            },
            mapAnimation: 'flyTo',
            rotateAnimation: false,
            mapInteractive: false,
            callback: '',
            onChapterEnter: [],
            onChapterExit: []
        }
```

Observa el salto narrativo que produce la combinación de parámetros. Venimos de un `zoom: 1.6` planetario y llegamos a un `zoom: 13` portuario: el `flyTo` convierte ese cambio de escala en un descenso vertiginoso desde la pregunta abstracta hasta el lugar concreto donde comienza la respuesta. Y el `bearing: 270` gira la cámara hacia el oeste, de modo que el lector mira desde el puerto hacia el Atlántico: la dirección exacta del viaje que está por empezar. Un simple número de rotación se convierte así en un gesto narrativo: la cámara *insinúa* el destino.

Este es el principio general que te proponemos adoptar: **cada parámetro de cámara debe poder justificarse con la historia**. Un `pitch` alto no es un adorno; es la manera de mostrar que Quito está rodeada de volcanes. Un `flyTo` largo no es un efecto; es la duración del océano.

Dos parámetros adicionales enriquecen las transiciones:

- `rotateAnimation: true` hace que, al llegar a destino, la cámara gire lentamente 90 grados durante 24 segundos. En nuestro capítulo sobre la medición de la línea base de Yarouquí —donde el equipo pasó semanas colocando toesas de hierro una tras otra— la rotación lenta evoca precisamente ese proceso paciente.
- Dentro de `location` puedes añadir `speed` para regular la velocidad del vuelo (el valor por defecto es 1.2; valores menores lo ralentizan). En el capítulo del descenso del Amazonas usamos `speed: 0.5` para que el vuelo más largo de la historia —de los Andes a la desembocadura atlántica— se sienta como tal.

Con estos elementos ya puedes construir la columna vertebral de la historia. En esta lección nos concentraremos en tres capítulos —la apertura planetaria, La Rochelle y la triangulación de los Andes, que verás en el paso 6—, suficientes para ejercitar cada técnica; el `config.js` de acompañamiento contiene exactamente esos tres capítulos, para que puedas verificar tu trabajo. La historia completa de la expedición, con diez capítulos, está disponible como [ejemplo terminado](https://felipevaldez.com/mision-geodesica/): allí encontrarás recursos adicionales que reutilizan lo aprendido aquí, como un `zoom: 5` regional que narra la travesía por Cartagena y Panamá sin dedicar un capítulo a cada parada, un `pitch: 45` que revela los volcanes en la llegada a Quito, o el `speed: 0.5` del gran descenso por el Amazonas. Recuerda separar cada capítulo del siguiente con una coma, sin coma tras el último.

<div class="alert alert-info">
Un consejo de método: escribe primero tus capítulos en un documento aparte —título, texto, imagen, lugar— y solo después trasládalos al <code>config.js</code>. Separar la escritura de la configuración evita errores de sintaxis y te obliga a pensar cada capítulo como una unidad narrativa: ¿qué debe ver el lector aquí, y desde dónde?
</div>

## Paso 5: Imágenes y derechos de autor

Cada capítulo puede incluir una imagen (`image`) con su leyenda (`caption`). Para añadirlas:

1. Sube tus archivos a la carpeta `images/` del repositorio (en GitHub: **Add file > Upload files** dentro de la carpeta).
2. Escribe la ruta relativa en la propiedad `image`, por ejemplo `'./images/cap4_piramides_la_condamine.jpg'`.
3. Usa la `caption` para identificar la imagen **y su fuente y estatus de derechos**.

Nuestra historia ilustra una situación ideal: casi todo el material visual relevante —los grabados de La Condamine, las láminas de la *Relación histórica* de Jorge Juan y Antonio de Ulloa, el mapa del Amazonas de 1745, el mapa de la Provincia de Quito de Pedro Vicente Maldonado (1750)— es del siglo XVIII y se encuentra en pleno dominio público, digitalizado en repositorios de acceso abierto:

- [Gallica](https://gallica.bnf.fr/), la biblioteca digital de la Biblioteca Nacional de Francia, con las obras completas de La Condamine.
- La [Biblioteca Digital Hispánica](http://bdh.bne.es/) de la Biblioteca Nacional de España, con la *Relación histórica del viaje a la América Meridional* (1748).
- [Wikimedia Commons](https://commons.wikimedia.org/), con retratos, grabados y fotografías contemporáneas bajo licencias claras.

Cuando construyas tu propia historia, este debe ser un criterio de diseño y no una ocurrencia tardía: prefiere materiales en dominio público o con licencias abiertas (Creative Commons), documenta la fuente de cada imagen en su leyenda, y recuerda que publicar tu *story map* en la web es un acto de publicación con todas sus responsabilidades. Reducir el tamaño de las imágenes (un ancho de 800–1200 píxeles suele bastar) también hará tu aplicación más rápida y accesible para lectores con conexiones lentas.

## Paso 6: Capas personalizadas que se encienden con la historia

Hasta aquí, el mapa base ha hecho todo el trabajo visual. El siguiente nivel es dibujar **tus propios datos** sobre el mapa —puntos, líneas, polígonos— y sincronizar su aparición con los capítulos. En nuestra historia, este recurso tiene un momento estelar: cuando el relato llega a la triangulación de los Andes, el mapa dibujará la red de triángulos entre cumbres que la expedición trazaba en papel. El medio reproducirá el objeto.

### GeoJSON: datos geográficos en texto plano

El formato que usaremos es [GeoJSON](https://geojson.org/), un estándar abierto que describe geometrías geográficas en texto legible. Un punto, por ejemplo, se ve así:

```json
{
    "type": "Feature",
    "properties": { "nombre": "Chimborazo" },
    "geometry": {
        "type": "Point",
        "coordinates": [-78.8170, -1.4690]
    }
}
```

Cada rasgo (*feature*) combina una geometría (punto, línea, polígono) con propiedades descriptivas que luego podremos usar, por ejemplo, como etiquetas. Puedes crear archivos GeoJSON dibujando directamente sobre un mapa en el editor web gratuito [geojson.io](https://geojson.io/), o exportarlos desde programas SIG de código abierto como [QGIS](https://www.qgis.org/).

### Definir fuentes y capas en sources.js

La plantilla separa los datos (las **fuentes**, *sources*) de su representación visual (las **capas**, *layers*), siguiendo la lógica de MapLibre: una misma fuente puede alimentar varias capas. Ambas se declaran en el archivo `sources.js`. Este fragmento define la red de triangulación y dos de sus tres capas:

```javascript
var externalData = {
    sources: [
        {
            "name": "triangulacion",
            "source": {
                "type": "geojson",
                "data": {
                    "type": "FeatureCollection",
                    "features": [
                        { "type": "Feature", "properties": { "nombre": "Pichincha" },
                          "geometry": { "type": "Point", "coordinates": [-78.5980, -0.1710] } },
                        { "type": "Feature", "properties": { "nombre": "Chimborazo" },
                          "geometry": { "type": "Point", "coordinates": [-78.8170, -1.4690] } },
                        {
                            "type": "Feature",
                            "properties": { "nombre": "Cadena de triángulos" },
                            "geometry": {
                                "type": "MultiLineString",
                                "coordinates": [
                                    [[-78.5980, -0.1710], [-78.8170, -1.4690]]
                                ]
                            }
                        }
                    ]
                }
            }
        }
    ],
    layers: [
        {
            "id": "triangulacion-lineas",
            "type": "line",
            "source": "triangulacion",
            "filter": ["==", "$type", "LineString"],
            "paint": {
                "line-color": "#1c4587",
                "line-width": 1.5,
                "line-dasharray": [2, 2],
                "line-opacity": 0
            }
        },
        {
            "id": "triangulacion-cumbres",
            "type": "circle",
            "source": "triangulacion",
            "filter": ["==", "$type", "Point"],
            "paint": {
                "circle-radius": 6,
                "circle-color": "#1c4587",
                "circle-stroke-color": "#ffffff",
                "circle-stroke-width": 2,
                "circle-opacity": 0,
                "circle-stroke-opacity": 0
            }
        }
    ]
};
```

Tres detalles merecen atención. Primero, la fuente contiene el GeoJSON **incrustado** en la propiedad `data`; para conjuntos de datos grandes, podrías en cambio guardar el GeoJSON como archivo aparte en tu repositorio y poner su ruta en `data`. Segundo, el `filter` de cada capa selecciona qué geometrías de la fuente dibuja: la capa de líneas ignora los puntos y viceversa. Tercero —y esto es esencial—, **todas las opacidades comienzan en `0`**: las capas existen desde que carga la página, pero invisibles, esperando a que un capítulo las encienda.

El `sources.js` de acompañamiento contiene, con esta misma estructura, la fuente completa de la triangulación con siete cumbres y sus tres capas, incluida una de tipo `symbol` que muestra los nombres de las cumbres tomándolos de la propiedad `nombre` de cada rasgo, con la expresión `"text-field": ["get", "nombre"]`. En el [ejemplo terminado](https://felipevaldez.com/mision-geodesica/) puedes ver el mismo patrón extendido a cuatro fuentes: la línea base de Yarouquí con sus dos pirámides, la red de triangulación, la ruta del descenso del Amazonas y el arco meridiano final con los hitos de la expedición.

{% include figure.html filename="es-or-narracion-historias-mapas-maplibre-06.png" alt="Captura de pantalla mostrando los detalles del archivo 'sources.js' en el editor web." caption="Figura 6. Detalles del archivo 'sources.js' en el editor web de GitHub." %}

Un consejo nacido de la experiencia: el error más frecuente al trabajar con capas es el desajuste de nombres entre los dos archivos — un `id` renombrado en `sources.js` pero no en `config.js`, o viceversa. En la plantilla original, ese desajuste no produce un mensaje claro sino un fallo silencioso que interrumpe todo lo que el capítulo debía hacer a continuación. Cada vez que renombres una capa, busca su nombre en ambos archivos.

### Un pequeño ajuste en index.html

La plantilla fue diseñada originalmente para cargar fuentes alojadas en servidores de teselas, por lo que necesita un ajuste mínimo para aceptar nuestro GeoJSON incrustado. Abre `index.html`, busca el bloque que comienza con `if (config.useCustomLayers)` (cerca de la línea 580) y reemplázalo por:

```javascript
            // add custom layers
            if (config.useCustomLayers) {
                for (i = 0; i < externalData.sources.length; i++) {
                    let currentSource = externalData.sources[i];
                    map.addSource(currentSource.name, currentSource.source);
                }
                for (i = 0; i < externalData.layers.length; i++) {
                    map.addLayer(externalData.layers[i]);
                }
            }
```

El cambio hace dos cosas: pasa a MapLibre la definición completa de cada fuente (en lugar de solo un tipo y una URL) y añade las capas encima del mapa base (el código original intentaba insertarlas bajo una capa llamada `your-layer`, propia de los estilos de Mapbox Studio, que no existe en el estilo de OpenFreeMap).

### Encender y apagar capas con onChapterEnter

Falta el último eslabón: conectar las capas con los capítulos. Para eso sirven las propiedades `onChapterEnter` y `onChapterExit` que hemos dejado vacías hasta ahora. Cada una es una lista de instrucciones de opacidad que se ejecutan cuando el capítulo entra o sale de pantalla. Así queda el capítulo de la triangulación:

```javascript
        {
            id: 'cap-5-triangulacion',
            alignment: 'left',
            title: 'Triangular los Andes',
            image: './images/cap5_chimborazo_relacion.jpg',
            caption: 'El Chimborazo en la <em>Relación histórica</em> (1748). BNE. Dominio público.',
            description: 'El equipo extiende la triangulación hacia el sur por el callejón interandino, acampando durante semanas a más de 4.000 metros para colocar miras en las cumbres y medir los ángulos entre ellas.',
            location: {
                center: [-78.6500, -1.5000],
                zoom: 8,
                pitch: 60,
                bearing: 0
            },
            mapAnimation: 'flyTo',
            rotateAnimation: true,
            mapInteractive: false,
            callback: '',
            onChapterEnter: [
                { layer: 'triangulacion-lineas', opacity: 0.8, duration: 1500 },
                { layer: 'triangulacion-cumbres', opacity: 1, duration: 1500 },
                { layer: 'triangulacion-etiquetas', opacity: 1, duration: 1500 }
            ],
            onChapterExit: [
                { layer: 'triangulacion-lineas', opacity: 0 },
                { layer: 'triangulacion-cumbres', opacity: 0 },
                { layer: 'triangulacion-etiquetas', opacity: 0 }
            ]
        }
```

Cuando el lector llega a este capítulo, la cámara vuela a una vista inclinada (`pitch: 60`) entre el Cotopaxi y el Chimborazo, y sobre las montañas aparece, en un fundido de un segundo y medio (`duration: 1500`), la red de triángulos punteados con sus vértices y nombres. Al salir del capítulo, la red se desvanece. El parámetro `layer` debe coincidir exactamente con el `id` de la capa en `sources.js`; una letra distinta y la capa simplemente no responderá.

Fíjate en la simetría entre `onChapterEnter` y `onChapterExit`: es una buena costumbre apagar en la salida todo lo que se encendió en la entrada, salvo que quieras deliberadamente que una capa persista a través de varios capítulos (en cuyo caso la apagarás en el capítulo donde deba desaparecer).

## Paso 7: Publicar con GitHub Pages

Tu historia ya funciona; ahora hagámosla pública. GitHub Pages convierte cualquier repositorio en un sitio web gratuito:

1. En tu repositorio, ve a **Settings > Pages**.

{% include figure.html filename="es-or-narracion-historias-mapas-maplibre-07.png" alt="Captura de pantalla mostrando la configuracion de GitHub Pages" caption="Figura 7. Opciones de configuración del repositorio para activar GitHub Pages" %}

1. En la sección *Build and deployment*, bajo *Source*, elige **Deploy from a branch**.
2. Selecciona la rama `main` y la carpeta `/ (root)`, y guarda.

{% include figure.html filename="es-or-narracion-historias-mapas-maplibre-08.png" alt="Captura de pantalla mostrando la configuracion de GitHub Pages" caption="Figura 8. Configuración para desplegar la web en GitHub Pages." %}

1. Espera uno o dos minutos. GitHub mostrará la dirección pública de tu sitio, con la forma `https://tu-usuario.github.io/mision-geodesica/`.

Cada vez que confirmes un cambio en el repositorio, el sitio se actualizará automáticamente al cabo de un momento. Esta forma de publicación tiene tres virtudes para un proyecto académico: es gratuita, es transparente (cualquiera puede ver y reutilizar tu código, igual que tú reutilizaste la plantilla) y es sustentable (un sitio estático no depende de servicios que expiran; incluso si GitHub desapareciera, tus archivos funcionarían en cualquier otro servidor sin modificaciones).

Verifica el resultado en varios dispositivos. La plantilla incluye un aviso automático (`mobileview`) que sugiere a los lectores de móviles girar el dispositivo a orientación horizontal, donde la experiencia es mejor.

## Sección avanzada (opcional): terreno en tres dimensiones

Nuestra historia trata de montañas, y MapLibre puede mostrarlas literalmente en relieve. La propiedad `use3dTerrain: true` activa el terreno tridimensional: combinada con el `pitch: 60` del capítulo de la triangulación, hace que el Chimborazo y el Cotopaxi se levanten físicamente de la pantalla.

El terreno 3D requiere un tipo especial de datos: **teselas de elevación**, imágenes que codifican la altitud de cada punto del planeta. OpenFreeMap no las ofrece, pero existe un proveedor abierto que sí: [Mapterhorn](https://mapterhorn.com/), un proyecto comunitario de datos abiertos que sirve teselas de terreno para todo el mundo —con resolución global de 30 metros, la misma de los datos SRTM de la NASA— desde un punto de acceso público, sin registro ni clave de API. Igual que el resto de nuestras herramientas, su código es libre y sus datos provienen de fuentes abiertas.

Para activar el terreno se necesitan dos cambios. Primero, en `config.js`, pon `use3dTerrain: true`. Segundo, en `index.html`, busca el bloque que comienza con `if (config.use3dTerrain)` dentro de `map.on("load", ...)` (cerca de la línea 570) —la plantilla espera allí unas teselas locales que no tenemos— y reemplázalo por la fuente de Mapterhorn:

```javascript
            if (config.use3dTerrain) {
                map.addSource('terrainSource', {
                    'type': 'raster-dem',
                    'tiles': ['https://tiles.mapterhorn.com/{z}/{x}/{y}.webp'],
                    'encoding': 'terrarium',
                    'tileSize': 512,
                    'maxzoom': 12,
                    'attribution': '<a href="https://mapterhorn.com/attribution" target="_blank">Mapterhorn</a>'
                });

                map.setTerrain({ 'source': 'terrainSource', 'exaggeration': 1.3 });
            };
```

Tres detalles de esta configuración merecen explicación. La propiedad `encoding: 'terrarium'` indica a MapLibre cómo descifrar la altitud codificada en los colores de cada tesela (Mapterhorn usa el esquema abierto Terrarium, que MapLibre soporta de forma nativa). El `maxzoom: 12` corresponde al nivel máximo de la cobertura global; a partir de allí MapLibre amplía las teselas existentes, lo que es suficiente para vistas de paisaje como las nuestras. Y la `attribution` es el único requisito de uso del servicio: acreditar la fuente de los datos, algo que en cualquier caso ya practicamos como norma. El parámetro `exaggeration` multiplica el relieve; un valor entre 1 y 1.5 realza las montañas sin distorsionarlas.

Guarda, recarga y desplázate hasta el capítulo de la triangulación: con el `pitch: 60` de ese capítulo, la cordillera se levantará físicamente de la pantalla, y la red de triángulos quedará tendida sobre las mismas cumbres que la expedición escalaba para medirla.

### Ajustar la cámara cuando el terreno está activo

Al recorrer la historia con el terreno activado notarás que algunos capítulos —precisamente los de zoom alto sobre zonas elevadas, como Quito, Yarouquí y Cuenca, ciudades andinas a más de 2.500 metros— pueden aparecer con un encuadre distinto al esperado: demasiado cerca del suelo, o incluso variando según la dirección del desplazamiento. No es un error tuyo. Sin terreno, el nivel de `zoom` se calcula respecto al nivel del mar; con terreno, MapLibre reposiciona la cámara respecto a la elevación real del suelo, y en el momento de escribir esta lección existe un [problema documentado](https://github.com/maplibre/maplibre-gl-js/issues/4688) por el cual los movimientos programáticos de cámara (`flyTo`, `easeTo`, `jumpTo`) pueden dar resultados inconsistentes con el terreno activado. El efecto es mayor cuanto más alta es la zona y más cercano el zoom; a esto se suma que a zoom 14 o 15 las teselas de elevación (cuya cobertura global llega al nivel 12) se sobreamplían y el relieve cercano se ve tosco.

La solución práctica es alejar un poco la cámara en esos capítulos cuando el terreno esté activo: con más distancia al suelo, la corrección de elevación se vuelve imperceptible. En nuestra historia, bajar el capítulo de Quito de `zoom: 14` a `zoom: 12.5`, el de Yarouquí de `zoom: 15, pitch: 60` a `zoom: 13.5, pitch: 55`, y el de Cuenca de `zoom: 14` a `zoom: 12.5` produce encuadres estables (ajusta los valores a tu gusto previsualizando). Prueba siempre la historia desplazándote en ambas direcciones, hacia abajo y hacia arriba, que es donde las inconsistencias se manifiestan. La lección de método es general: **activar el terreno cambia la gramática de la cámara**, así que las vistas de una historia diseñada en plano deben revisarse una a una al pasar a tres dimensiones.

Existe una solución más elegante para historias que combinan capítulos de montaña con capítulos urbanos de primer plano: activar el terreno solo en los capítulos que lo necesitan, usando la propiedad `callback` de cada capítulo para encenderlo y apagarlo dinámicamente. Así, los capítulos de zoom alto conservan sus encuadres originales (el terreno está apagado cuando la cámara los calcula) y las montañas se levantan únicamente donde la narración las convoca. El [ejemplo terminado](https://felipevaldez.com/mision-geodesica/) implementa este patrón —incluido el detalle, nada trivial, de diferir el cambio de terreno hasta que el vuelo de la cámara aterriza— y su código está comentado para quien quiera adoptarlo.

Una nota final de diseño de proyecto: Mapterhorn es un proyecto joven, y toda dependencia externa —incluso una abierta y gratuita— es una decisión que conviene documentar. Su naturaleza abierta ofrece, sin embargo, la mejor garantía posible: los datos completos pueden descargarse como archivos PMTiles y auto-alojarse, de modo que si el servicio cambiara algún día, tu historia podría seguir funcionando con tus propias copias. Es la misma lógica de sustentabilidad que guía toda esta lección.

## Adaptar la plantilla a tu propia historia

El objetivo final de esta lección no es que reproduzcas la historia de la Misión Geodésica, sino que cuentes la tuya. Para adaptarla, este es el recorrido en síntesis:

1. **Escribe primero la historia.** Define tus capítulos en un documento: qué lugar, qué texto, qué imagen. Un buen *story map* rara vez supera los diez o doce capítulos; el *scroll* largo fatiga.
2. **Elige las vistas.** Para cada capítulo, decide `center`, `zoom`, `pitch` y `bearing` con intención narrativa. Pregúntate: ¿desde dónde debería mirar el lector, y por qué?
3. **Reúne materiales con derechos claros.** Prioriza dominio público y licencias abiertas; documenta cada fuente en las leyendas y el pie.
4. **Traduce todo a `config.js`**, capítulo por capítulo, previsualizando con frecuencia.
5. **Añade datos propios** en `sources.js` solo donde aporten a la narración: una ruta, unos puntos, un área. La sobriedad visual suele contar mejor.
6. **Publica y cita.** Activa GitHub Pages, acredita la plantilla, las herramientas y los datos, y comparte también tu repositorio: tu historia puede ser la plantilla de la siguiente persona.

Nuestra historia de ejemplo termina, de hecho, con una lección sobre esto mismo. La Condamine publicó sus datos y sus mapas para que otros pudieran verificarlos y construir sobre ellos; dos siglos y medio después, la palabra que sus libros pusieron en circulación es el nombre de un país. Publicar tu código y tus datos con herramientas abiertas participa de esa misma ética: la del conocimiento que se comparte para durar.

## Conclusiones

En esta lección construiste una aplicación de narración con mapas usando exclusivamente software libre y servicios gratuitos: la biblioteca MapLibre GL JS, el mapa base de OpenFreeMap, una plantilla de código abierto y la publicación con GitHub Pages. En el camino aprendiste los conceptos fundamentales de los mapas web —coordenadas, zoom, cámara, fuentes y capas—, el formato GeoJSON para datos geográficos, y una gramática narrativa para ponerlos al servicio de una historia: la cámara que insinúa, el vuelo que dura lo que el viaje, la capa que aparece cuando el relato la nombra.

Estas habilidades son transferibles. El mismo `config.js` puede contar la migración de una familia, la geografía de una novela, la expansión de una ciudad o el itinerario de un archivo. Y las piezas que aprendiste a manejar —GeoJSON, MapLibre, GitHub Pages— son componentes estándar de un ecosistema abierto mucho más amplio, que otras lecciones de *Programming Historian* te ayudarán a seguir explorando, como [Web Mapping with Python and Leaflet](/en/lessons/mapping-with-python-leaflet) o [Introducción a Map Warper](/es/lecciones/introduccion-map-warper) para georreferenciar los mapas históricos que quizás quieras incorporar a tu próxima historia.

## Referencias y recursos

- Archivos de acompañamiento de esta lección: [`config.js`](/assets/narracion-historias-mapas-maplibre/config.js) y [`sources.js`](/assets/narracion-historias-mapas-maplibre/sources.js) (la versión de tres capítulos construida en la lección)
- Ejemplo terminado con los diez capítulos y terreno 3D: [sitio desplegado](https://felipevaldez.com/mision-geodesica/)
- Plantilla MapLibre Storymap de Awana Digital: https://github.com/digidem/maplibre-storymap (incluye la documentación completa de configuración en `CONFIG.md`)
- Documentación de MapLibre GL JS: https://maplibre.org/maplibre-gl-js/docs/
- OpenFreeMap: https://openfreemap.org/
- Mapterhorn (teselas de elevación abiertas): https://mapterhorn.com/
- Especificación GeoJSON: https://geojson.org/
- Tutorial original en inglés en que se basa esta lección: Felipe Valdez, *Storytelling with Maps using MapLibre*, Temple University Libraries: https://felipevaldez.com/storytelling_maplibre_workshop/
- Sobre la Misión Geodésica: Charles-Marie de La Condamine, *Relation abrégée d'un voyage fait dans l'intérieur de l'Amérique méridionale* (1745) y *Journal du voyage fait par ordre du roi à l'équateur* (1751), disponibles en Gallica (BnF); Jorge Juan y Antonio de Ulloa, *Relación histórica del viaje a la América Meridional* (1748), disponible en la Biblioteca Digital Hispánica (BNE).
