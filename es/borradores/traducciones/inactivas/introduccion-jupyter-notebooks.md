---
title: Introducción a los Jupyter Notebooks
collection: lessons
layout: lesson
slug: introduccion-jupyter-notebooks
date: 2019-12-08
translation_date:
authors:
- Quinn Dombrowski
- Tassie Gniady
- David Kloster
reviewers:
- Patrick Burns
- Jeri Wieringa
editors:
- Brandon Walsh
translator:
- Santiago Ojeda Ramírez
translation-editor:
-
translation-reviewer:
-
dificulty: 1
activity: presenting
topics: [python, website]
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/
Abstract: Los Jupyter notebooks proporcionan un entorno donde se puede combinar libremente la narrativa legible por las personas con el código computacional. Esta lección describe cómo instalar el software de los Jupyter Notebooks, cómo ejecutar y crear archivos de Jupyter Notebooks y contextos en los que los Jupyter Notebooks pueden ser particularmente útiles.
redirect_from: "/lessons/jupyter-notebooks"
avatar_alt: El planeta Júpiter
doi: 

---

{% include toc.html %}

## Introducción

Cuando la computación es una parte intrínseca de tu trabajo académico y de investigación, ¿cómo se publica un argumento académico de manera que el código sea tan accesible y legible como la prosa que lo acompaña? En las humanidades, la publicación académica toma principalmente la forma de prosa escrita, en forma de artículo o monografía. Si bien los editores están cada vez más abiertos a la inclusión de enlaces con código suplementario y otros materiales, esa configuración los relega intrínsecamente a un segundo plano en relación con el texto escrito.

¿Qué pasaría si se pudieran publicar textos académicos en un formato que diera la misma importancia a la prosa y al código? La realidad de las actuales directrices de publicación académica significa que la separación forzosa del código y la argumentación escrita puede ser una necesidad, y su reunificación puede ser imposible sin sortear numerosos obstáculos. En la actualidad, el código suele publicarse por separado en GitHub o en otro repositorio, donde los lectores tienen que buscar una nota a pie de página en el texto para saber a qué guiones se hace referencia, encontrar la URL del repositorio, ir a la URL, buscar los guiones, descargarlos junto con los archivos de datos asociados, y luego ejecutarlos. Sin embargo, si tiene los derechos y permisos necesarios para volver a publicar el texto de su trabajo académico en otro formato. Ante esto, los Jupyter Notebooks proporcionan un entorno en el que el código y la prosa pueden yuxtaponerse y presentarse con igual peso y valor.

Los Jupyter Notebooks han sido adoptados con entusiasmo por la comunidad de la ciencia de datos, hasta el punto de que están sustituyendo cada vez más a Microsoft Word como entorno de autoría por defecto para la investigación. Dentro de la literatura de humanidades digitales, se pueden encontrar referencias a los Jupyter Notebooks (separados de *iPython*, o los Notebooks interactivos Python, en 2014) que datan de 2015.

Los Jupyter Notebooks también han ganado impulso dentro de las Humanidades Digitales como herramienta pedagógica. Múltiples tutoriales de Programación Histórica como [Minería de Texto en Python a través del HTRC Feature Reader](/en/lessons/text-mining-with-extracted-features), y [Extracting Illustrated Pages from Digital Libraries with Python](/en/lessons/extracting-illustrated-pages#jupyter-notebooks), así como otros materiales pedagógicos para talleres, hacen referencia a poner el código en un Jupyter Notebook o a utilizar los Jupyter Notebooks para guiar a los alumnos, permitiéndoles al mismo tiempo mezclar y editar libremente el código. El formato de cuaderno, no ‘notebook’ es ideal para la enseñanza, especialmente cuando los estudiantes tienen diferentes niveles de competencia técnica y comodidad para escribir y editar código.

El propósito de los Jupyter Notebooks es proporcionar una interfaz más accesible para el código utilizado en la investigación o la pedagogía con soporte digital. Herramientas como los Jupyter Notebooks son menos significativas para aprender o enseñar en el vacío, porque los Jupyter Notebooks por sí mismos no *hacen* nada para avanzar directamente en la investigación o la pedagogía. Antes de comenzar esta lección, piensa en lo que quieres obtener al usar los Jupyter Notebooks. ¿Quieres organizar el flujo de trabajo de un proyecto? ¿Quieres trabajar analizando sus datos, haciendo un seguimiento de las cosas que intentas a lo largo del camino? ¿Quieres que los lectores de tu trabajo académico puedan seguir los aspectos teóricos y técnicos de tu argumento sin tener que cambiar entre un PDF y una carpeta de guiones? ¿Quieres enseñar talleres de programación que sean más accesibles para los asistentes con una gama de antecedentes técnicos? ¿Quiere usar o adaptar Notebooks que otras personas han escrito? Tenga en cuenta su objetivo mientras trabaja en esta lección: según cómo se imagine que va a utilizar los Jupyter Notebooks, es posible que pueda saltarse secciones que son, en su mayoría, aplicables en otro contexto.


## Objetivos de la lección

En esta lección aprenderá:

- Qué son los Jupyter Notebooks
- Cómo instalar, configurar y usar el software de Jupyter Notebooks
- Cuándo los Notebooks pueden ser útiles en contextos de investigación y pedagógicos

En esta lección, trabajaremos con un escenario en que se utilizará Jupyter Notebooks para analizar datos, y luego adaptaremos ese mismo cuaderno y los datos para su uso en el aula.

La lección también tocará temas más avanzados relacionados con los Jupyter Notebooks, como:

- Uso de los Jupyter Notebooks para otros lenguajes de programación que no sean Python.
- Convertir el código Python existente en Jupyter Notebooks
- Usar los Jupyter Notebooks para ampliar la computación en entornos como los clusters de computación de alto rendimiento.


## Requisitos previos...

Esta lección está diseñada para principiantes intrépidos, suponiendo poca experiencia previa. De hecho, los Jupyter Notebooks son un gran recurso para la gente que está aprendiendo a programar y escribir código.

Dependiendo del cuaderno que quieras ejecutar, puedes necesitar [instalar algunos módulos de Python con pip](/en/lessons/installing-python-modules-pip), lo que supone cierta familiaridad con la línea de comandos (para [Windows aquí](/en/lessons/intro-to-powershell), o [Mac/Linux aquí](/en/lessons/intro-to-bash)).

La lección fue escrita usando Jupyter Notebook 6.0, pero la interfaz de usuario y la funcionalidad del software ha sido bastante consistente en todas las versiones.


## Computación alfabetizada
La relación entre el código legible por ordenador y el texto legible por el ser humano ganó visibilidad dentro de la informática en los años 70, cuando Donald Knuth propuso el paradigma de la "programación literaria". En lugar de organizar el código de acuerdo con los requisitos que privilegian la ejecución del código por parte del ordenador, la programación alfabetizada trata un programa como literatura comprensible para los seres humanos, priorizando el propio proceso de pensamiento del programador. La programación literaria, tal como fue diseñada por Knuth, toma la forma de prosa escrita, con código ejecutable por computadores incrustado en macros (un formato abreviado para escribir código). Las herramientas de programación literaria se utilizan para generar dos salidas del programa literario: código "enredado" que puede ser ejecutado por la computadora, y documentación formateada "tejida".[^1]

Fernando Pérez, el creador del entorno de programación iPython que finalmente se convirtió en el Proyect Jupyter, acuñó el término *computación alfabetizada* para el modelo utilizado por los Jupyter Notebooks:
> Un entorno de computación letrada es aquel que permite a los usuarios no sólo ejecutar comandos sino también almacenar en un formato de documento letrado los resultados de estos comandos junto con cifras y texto de forma libre que puede incluir expresiones matemáticas formateadas. En la práctica, puede verse como una mezcla de un entorno de línea de comandos como el shell de Unix con un procesador de textos, ya que los documentos resultantes pueden leerse como texto, pero contienen bloques de código que fueron ejecutados por el sistema computacional subyacente.[^2]

Jupyter no es ni el primer ni el único ejemplo de Notebooks de cálculo. Ya en los años 80, las interfaces de los Notebooks estaban disponibles a través de software como Wolfram Mathematica y MATLAB. En 2013, Stéfan Sinclair y Geoffrey Rockwell propusieron “Voyant Notebooks” basados en el modelo de Mathematica, los cuales expondrían algunas de las suposiciones que sostienen [Voyant Tools](https://voyant-tools.org) y las harían configurables por el usuario.[^3] Este concepto fue mejor desarrollado en [*The Art of Literary Text Analysis Spyral Notebooks*] (https://voyant-tools.org/spyral/alta).

Jupyter ha ganado tracción a través de muchos campos como un entorno de código abierto que es compatible con numerosos lenguajes de programación. El nombre *Jupyter* es una referencia a los tres lenguajes centrales soportados por el proyecto (**Ju**lia, **Py**thon, y **R**), pero [hay núcleos disponibles que hacen a Jupyter compatible con decenas de lenguajes](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels), incluyendo Ruby, PHP, Javascript, SQL, y Node.js. Puede que no tenga sentido implementar proyectos en todos estos lenguajes usando Jupyter Notebooks (por ejemplo, Omeka no le permitirá instalar un plugin escrito como un Jupyter Notebook), pero el entorno Jupyter puede seguir siendo valioso para documentar código, enseñar lenguajes de programación, y proporcionar a los estudiantes un espacio en el que pueden experimentar fácilmente con los ejemplos proporcionados.

## Instalar Jupyter Notebooks

A partir de finales de 2019, hay dos entornos principales que puedes usar para ejecutar los Jupyter Notebooks: Jupyter Notebook (no confundir con los propios archivos del Jupyter Notebook, que tienen una extensión .ipynb), y el más reciente Jupyter Lab. El Jupyter Notebook es ampliamente utilizado y bien documentado, y proporciona un simple navegador de archivos junto con el entorno para crear, editar y ejecutar los Notebooks. Jupyter Lab es más complejo, con un entorno de usuario que recuerda más a un Entorno de Desarrollo Integrado (discutido en los anteriores tutoriales del Historial de Programación para [Windows](/en/lecciones/instalación de Windows), [Mac](/en/lecciones/instalación de Mac), y [Linux](/en/lecciones/instalación de Linux)). Aunque Jupyter Lab está pensado para reemplazar eventualmente a Jupyter Notebook, no hay ninguna indicación de que Jupyter Notebook deje de ser compatible en un futuro próximo. Debido a su simplicidad y su uso fácil para  principiantes, este tutorial utiliza Jupyter Notebook como el software para ejecutar los archivos del cuaderno. Ambos paquetes de software están incluidos en Anaconda, que se describe a continuación. Es más fácil usar Anaconda para instalar Jupyter Notebook, pero si ya tienes Python instalado en tu sistema y no quieres lidiar con el gran paquete Anaconda, puedes ejecutar `pip3  installl jupyter` (para Python 3).

### Anaconda

Anaconda es una distribución gratuita y de código abierto de Python y R que viene con más de 1.400 paquetes, el gestor de paquetes Conda para instalar paquetes adicionales, y Anaconda Navigator, que permite gestionar entornos (por ejemplo, se pueden instalar diferentes conjuntos de paquetes para diferentes proyectos, de modo que no se produzcan conflictos entre ellos) mediante una interfaz gráfica. Después de instalar Anaconda, puedes usar Anaconda Navigator para instalar nuevos paquetes (o <code>conda install</code> a través de la línea de comandos), pero muchos paquetes están disponibles sólo a través de pip (es decir, usando <code>pip install</code> a través de la línea de comandos o en un Jupyter Notebook).

Para la mayoría de propósitos, querrás descargar la versión Python 3 de Anaconda, pero algún código anterior puede estar aún escrito en Python 2. En esta lección se usará Python 3. El instalador de Anaconda tiene más de 500 MB, y después de la instalación puede ocupar más de 3 GB de espacio en el disco duro, así que asegúrate de tener suficiente espacio en tu ordenador y una conexión de red rápida antes de empezar.

<div class="alert alert-warning">Si el espacio en el disco duro es una preocupación, puedes empaquetar un notebook para que se pueda ejecutar usando recursos de computación en nube gratuitos, en lugar de hacer que los usuarios instalen Anaconda. Esto puede ser especialmente útil en situaciones como talleres. Ver la sección <a href="#cloud">sobre Binder abajo</a>.</div>

Para descargar e instalar Anaconda, ve al [sitio web de Anaconda](https://www.anaconda.com/distribution/). Asegúrate de que has pulsado el icono de tu sistema operativo (que debería cambiar el texto *Anaconda \[número de versión]\N por el instalador del sistema operativo seleccionado* para indicar tu sistema operativo), y luego pulsa el botón *Descargar* en la casilla de la versión actual de Python 3. Si estás en Windows, esto debería descargar un archivo .exe; en Mac, es .pkg; en Linux es .sh.

Abre el archivo para instalar el software como lo harías normalmente en tu sistema operativo. Más detalles de la instalación están disponibles en el [Anaconda docs](https://docs.anaconda.com/anaconda/install/), incluyendo cómo instalar Anaconda a través de la línea de comandos en cada sistema operativo. Si su computadora no puede abrir el archivo que ha descargado, asegúrese de haber seleccionado el sistema operativo correcto antes de descargar el instalador. En Windows, asegúrese de elegir la opción "Agregar Anaconda a la variable PATH" durante el proceso de instalación, o no podrá ejecutar los Jupyter Notebooks desde la línea de comandos.

## Usando  Jupyter Notebooks para investigación

Esta lección describe cómo se puede escribir inicialmente un Jupyter Notebook para el análisis de datos como parte de un proyecto de investigación, y luego adaptarlo para su uso en el aula. Si bien este ejemplo en particular se extrae de los estudios sobre fans, se centra en la conversión de fechas, que es muy necesaria en el análisis de datos históricos y literarios.

### Ejecutando Jupyter Notebooks

Asumiendo que ya has instalado Anaconda como se describe arriba, puedes ejecutar el Anaconda Navigator como cualquier otra aplicación de software. (Puede cerrar el aviso sobre la creación de una cuenta en Anaconda Cloud; no necesita una cuenta para trabajar con Anaconda). En la pantalla de inicio, deberías ver un conjunto de íconos y breves descripciones sobre cada aplicación incluida con Anaconda.

Haz clic en el botón "Launch” debajo del icono *Jupyter Notebook*.

{% include figure.html filename="anaconda-navigator.png" caption="Anaconda Navigator interface" %}

Si prefieres usar la línea de comandos en lugar del Anaconda Navigator, una vez que tengas instalado Anaconda, deberías poder abrir una nueva ventana Terminal (Mac) o Command Prompt (Win) y ejecutar <código>jupyter notebook</código> para iniciar el navegador con la aplicación Jupyter Notebook. Si está usando la línea de comandos para ejecutar el Jupyter Notebook, presta atención al directorio en el que se encuentra cuando lo ejecuta. Esa carpeta se convierte en el directorio principal que aparecerá inmediatamente en la interfaz de Jupyter Notebook, como se describe a continuación.

Cualquiera de los dos métodos abrirá una nueva ventana o pestaña en tu navegador predeterminado con la interfaz de Jupyter Notebook. El Jupyter Notebook está basado en el navegador: sólo se interactúa con él a través del navegador, incluso cuando el Jupyter Notebook se ejecuta en su propio ordenador.

<div class="alert alert alert">
Si estás usando Notebooks que importan paquetes Python, que tienen dependencias en versiones específicas de otros paquetes, deberías configurar un <i>entorno</i> para usar con esos Notebooks, para que no te encuentres con conflictos de versiones (por ejemplo, si un cuaderno requiere la versión 1.0 de un paquete, y otro requiere la versión 2.0). La <a href="https://docs.anaconda.com/anaconda/navigator/tutorials/manage-environments/">Documentación de Anaconda Navigator para la gestión de entornos</a> (o, si prefieres usar la línea de comandos, la <a href="https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html">Documentación de Conda</a>) proporciona instrucciones paso a paso para crear, actualizar y activar un entorno. Para ejecutar el Jupyter Notebook dentro de  un ambiente particular, primero tienes que activar ese ambiente.
</div>

### Navigando en la interfaz del Jupyter Notebook

La interfaz del navegador de archivos del Jupyter Notebook es la principal forma de abrir un archivo del Jupyter Notebook (.ipynb). Si intentas abrir uno en un editor de texto plano, el cuaderno se mostrará como un archivo JSON, no con bloques de código interactivo. Para ver un cuaderno a través de la interfaz Jupyter, tiene que iniciar primero el Jupyter Notebook (que se mostrará en una ventana del navegador), y abrir el archivo desde dentro del Jupyter Notebook. Desafortunadamente, no hay forma de configurar el Jupyter Notebook como la aplicación de software predeterminada para abrir los archivos .ipynb cuando se hace doble clic en ellos.

Cuando inicie el Jupyter Notebook desde el Anaconda Navigator, éste muestra automáticamente su directorio principal. Este es usualmente el directorio con su nombre de usuario en una Mac (/Usuarios/*su-nombre-de-usuario*). En una PC suele ser C:\\N. Si ejecuta Jupyter Notebook desde la línea de comandos, mostrará el contenido de la carpeta en la que se encontraba cuando lo ejecutó. (Usando la línea de comandos, también puede ejecutar directamente un cuaderno específico, por ejemplo, "ejemplo de Jupyter Notebook.ipynb").

Para evitar desordenar esta carpeta, puedes crear una nueva carpeta dentro de este directorio para sus Notebooks. Puede hacer esto en su interfaz habitual de administración de archivos (Finder en Mac, o File Explorer en Windows), o dentro del propio Jupyter Notebook, ya que Jupyter Notebook, al igual que Google Drive, proporciona una interfaz de administración de archivos dentro de un navegador, así como una interfaz de menú y barra de herramientas para la creación de archivos. Para añadir una nueva carpeta dentro de Jupyter Notebooks, haz clic en *Nuevo* en la parte superior derecha y selecciona *Carpeta*. Esto creará una nueva carpeta llamada "Carpeta sin título". Para cambiar el nombre, haz clic en la casilla de verificación a la izquierda de "Carpeta sin título", luego haz clic en el botón "Renombrar" que aparece bajo la pestaña "Archivos". Nombra la carpeta *libros*. Haz clic en él para abrir esa carpeta.

### Subir los datos que utilizaremos

El archivo CSV de ejemplo para esta lección es un extracto de los metadatos de fan fiction de *Harry Potter* obtenidos del sitio italiano de fan-fiction [https://efpfanfic.net](https://efpfanfic.net), luego limpiados usando una combinación de [expresiones regulares](/en/lecciones/entendimiento-expresionesregulares) y [OpenRefine](/en/lecciones/limpieza-datos-con-openrefine). El CSV tiene tres columnas: la clasificación de la historia (similar a la clasificación de una película), la fecha en que se publicó originalmente y la fecha más reciente en que se actualizó. Las opciones de clasificación son *verde* (verde), *giallo* (amarillo), *arancione* (naranja), y *rosso* (rojo). Las fechas de publicación y actualización se crean automáticamente cuando la historia se publica en el sitio o se actualiza, por lo que puedes contar con que serán consistentes.

Gracias a la consistencia de las fechas generadas automáticamente, debería ser posible convertir todas ellas en días de la semana usando Python. Pero si no tienes mucha experiencia en hacer conversiones de fechas usando Python, un Jupyter Notebooks puede proporcionar una interfaz conveniente para experimentar con diferentes módulos y enfoques.

Descarga [el archivo CSV de muestra]({{ site.baseurl }}/assets/jupyter-notebooks/ph-jupyter-notebook-example.csv).

Dentro del navegador de archivos de Jupyter Notebook, deberías estar dentro del directorio *notebooks* que acabas de crear. Hacia la parte superior derecha, haz clic en el botón "Subir" y sube el archivo CSV de muestra. Será más fácil acceder a él si está en el mismo directorio que el Jupyter Notebook que crearás en el siguiente paso para convertir las fechas.

{% include figure.html filename="jupyter-upload.png" caption="Subir archivos en la interfaz del Jupyter Notebook" %}

Es importante tener en cuenta que esta no es la única forma de hacer que los archivos aparezcan en el navegador de archivos del Cuaderno de Jupyter. La carpeta *notebooks* que ha creado es un directorio normal de su ordenador, por lo que también puede utilizar su interfaz habitual de gestión de archivos (por ejemplo, Finder en Mac o File Explorer en Windows) para poner archivos .ipynb y/o de datos en este directorio. Los Jupyter Notebooks utilizan la ubicación del propio archivo del cuaderno (el archivo .ipynb) como ruta de inicio por defecto. Para los talleres y cursos, puede tener sentido crear una carpeta en la que se pueda guardar el cuaderno, las imágenes adjuntas y los datos con los que se va a trabajar, todo junto. Si no todo está en la misma carpeta, tendrás que incluir la ruta al referirte a ella, o usar código Python dentro del cuaderno para cambiar el directorio de trabajo.

### Crear un nuevo Notebook

<a id="creating"></a>
Dentro de la carpeta de *Notebooks*, crea un nuevo Jupyter Notebook para usar para convertir las fechas de tu proyecto de investigación. Haz clic en el botón "Nuevo" en la parte superior derecha de la interfaz del navegador de archivos del Jupyter Notebook. Si acabas de instalar Anaconda como se describe arriba, tu única opción será crear un Jupyter Notebook usando el *kernel* de Python 3 (el componente del backend que realmente ejecuta el código escrito en el cuaderno), pero a continuación discutiremos cómo añadir kernels para otros idiomas. Haz clic en "Python 3", y el Jupyter Notebook abrirá una nueva pestaña con la interfaz para los Jupyter Notebooks propios. Por defecto, el cuaderno se llamará "Sin título"; puede hacer clic en ese texto en la parte superior de la pantalla para cambiarle el nombre.

{% include figure.html filename="jupyter-createnew.png" caption="Crear un nuevo Jupyter Notebook" %}

### Trabajar en Jupyter notebooks

Un cuaderno se compone de *células*: cajas que contienen código o texto legible por el hombre. Cada celda tiene un tipo, que puede ser seleccionado en las opciones desplegables del menú. La opción por defecto es "Código"; las cajas de texto legibles por el hombre deben utilizar el tipo "Markdown", y deberán ser escritas utilizando las convenciones de formato de Markdown. Para obtener más información sobre Markdown, consulta la lección ["Getting Started With Markdown"](/en/lessons/getting-started-with-markdown) Programming Historian.

Cuando crees un nuevo Jupyter Notebook, la primera celda será una celda de código. En la parte superior de la interfaz del Jupyter Notebook hay una barra de herramientas con funciones que se aplican a la celda seleccionada actualmente. Una de las funciones es un desplegable que dice "Código" por defecto. Haz clic en este desplegable y selecciona "Markdown". (También puedes usar un atajo de teclado, *esc + m*, para cambiar la celda actual a "Markdown", y *esc + y* la vuelve a cambiar a una celda de código). Empezaremos este cuaderno con un título y una breve explicación de lo que hace el cuaderno. Por el momento, esto es sólo para tu propia memoria y referencia; no quieres invertir demasiado en prosa y formato en esta etapa del proyecto, cuando no sabes si terminarás usando este código como parte de tu proyecto final, o si usarás una herramienta o método diferente. Pero aún así puede ser útil incluir algunas celdas de reducción con notas para ayudarte a reconstruir tu proceso.

Pega lo siguiente en la primera celda. Si no aparece con la primera línea en una fuente grande (como un encabezado), asegúrate de haber seleccionado "Reducción" en el menú desplegable de la parte superior.


```
# Conversión de fechas de fanfic
Convirtiendo las fechas publicadas y actualizadas de los fanfics italianos en días de la semana.
```

{% include figure.html filename="jupyter-editing.png" caption="Editing Markdown cell in a Jupyter notebook" %}

Cuando estás editando una celda, puedes usar Ctrl + Z (Win) o Comando + Z (Mac) para deshacer los cambios que has hecho. Cada celda conserva su propio historial de edición; incluso si te mueves a una celda diferente y realizas ediciones allí, puedes volver a hacer clic en la primera celda y deshacer los cambios anteriores allí, sin perder los cambios en la segunda celda.

Para dejar el modo de edición y "ejecutar" esta celda (en el caso de una celda de Markdown, esto no *hace* nada, sólo se mueve más abajo en el Notebook), puedes hacer clic en <i class="fa-step-forward fa">/i> en la barra de herramientas o pulsar Ctrl+Enter (Ctrl+Return en Mac). Si quieres volver a editarlo más tarde, puedes hacer doble clic en él, o seleccionar la celda (que mostrará una línea azul vertical a la izquierda una vez que esté seleccionada) haciendo clic una vez, y luego pulsando la tecla Intro (Win) o Retorno (Mac). Para salir del modo de edición, puedes hacer clic en <i class="fa-step-forward fa">/i> en la barra de herramientas o presionar Ctrl+Enter (Ctrl+Return en Mac). Si quieres ejecutar tu celda actual y añadir una nueva celda (por defecto, una celda de código) inmediatamente debajo de ella, puedes pulsar Alt+Enter (Option+Enter en Mac).

A continuación, debes averiguar cómo realizar la conversión. La búsqueda de términos relevantes puede llevarte a [esta discusión sobre StackOverflow](https://stackoverflow.com/questions/2265357/parse-date-string-and-change-format), y la primera respuesta implica el uso del módulo *datetime* Python. Como primer paso, necesitas importar *datetime*, usando una celda de código. También sabes que tu archivo de entrada es un CSV, así que debes importar el módulo *csv* también.

Para añadir una nueva celda, haz clic en el botón más <i class="fa fa-plus"></i> de la barra de herramientas (o usa el atajo de teclado *esc + b*). Esto creará una nueva celda de código debajo de la celda actualmente seleccionada. Crea una nueva celda de código, y pega el siguiente código para importar un módulo Python:

``` py
import datetime
import csv
```

Pensando en la posibilidad de compartir este cuaderno o algún derivado, puede ser útil dividir las importaciones del módulo en una celda, y poner el código en sí mismo en otra celda, para poder incluir una celda de Markdown entre ellas que explique lo que hace cada una.

Los dos paquetes que estás importando a este cuaderno ya están instalados como parte de Anaconda, pero hay muchos paquetes de nicho relevantes para la investigación (por ejemplo, el [Classical Languages Toolkit, CLTK](https://github.com/cltk/cltk), para hacer análisis de texto sobre lenguas históricas) que no están incluidos en Anaconda, y no están disponibles a través del instalador *conda*. Si necesitas un paquete como ese, tienes que instalarlo usando *pip*.  Instalar paquetes desde dentro de Notebookes Jupyter puede ser un poco complicado, porque puede haber diferencias entre el *kernel Jupyter* que utiliza el Notebook, y otras versiones de Python que puedas tener instaladas en tu ordenador. Puedes encontrar una larga y técnica discusión de los temas [en esta entrada del blog](https://jakevdp.github.io/blog/2017/12/05/installing-python-packages-from-jupyter/).

Si estás trabajando en un Notebook que quieres compartir, y se trata de paquetes menos comunes, puedes incluir instrucciones en una celda de Markdown que los usuarios deben instalar los paquetes usando conda o pip por adelantado, o puedes usar:

``` py
import sys
!conda install --yes --prefix {sys.prefix} ElNombreDeTuModuloAqui
```
para instalar algo del cuaderno usando conda; la sintaxis `!` indica que el código está ejecutando algo desde la línea de comandos, en lugar del núcleo de Jupyter. O, si el paquete no está disponible en conda (muchos paquetes de nicho relevantes para la investigación no lo están), puedes usar pip:

``` py
import sys
!{sys.executable} -m pip install ElNombreDeTuModuloAqui
```

Si no había instalado Python en su computadora antes de instalar Anaconda para esta lección, es posible que necesite agregar el paquete *pip* para poder usarlo para instalar otros paquetes. Puede agregarlo a través de la interfaz gráfica de usuario del Anaconda Navigator, o ejecutar `conda install pip` desde la línea de comandos.

Volviendo a nuestro ejemplo, a continuación agrega otra nueva celda de código, y pega el siguiente código (asegurándose de incluir los espacios como aparece abajo):

``` py
with open('ph-jupyter-notebook-example.csv') as f:
    csv_reader = csv.reader(f, delimiter=',')
    for row in csv_reader:
        datetime.datetime.strptime(row[1], '%d/%m/%Y').strftime('%A')
        print(row)
```

Haciendo clic en el botón <i class="fa-step-forward fa">/i> de la barra de herramientas cuando se tiene seleccionada una celda de código, se ejecuta el código dentro de la celda. (Si intentas ejecutar este código después de haber ejecutado las declaraciones de importación, verás un error: "ValueError: los datos de tiempo '1/7/18' no coinciden con el formato '%d/%m/%Y'". No te preocupes... lo arreglaremos a continuación).

Después de ejecutar una celda de código, un número aparecerá entre paréntesis a la izquierda de la celda. Este número indica el orden en el que la celda fue ejecutada. Si regresas y ejecutas la celda de nuevo, el número se actualiza.

Si un número no aparece inmediatamente junto a la celda, verás un asterisco entre paréntesis. Esto significa que la celda de código no ha terminado de ejecutarse. Esto es común en el caso de código de alta tecnología (por ejemplo, el procesamiento de lenguaje natural) o en tareas de larga duración como el web scraping. Siempre que una celda de código se está ejecutando, el favicon de la pestaña del navegador del Notebook cambia a un reloj de arena <i class="fa fa-hourglass-start"></i>. Si quieres cambiar de pestaña y hacer otra cosa mientras el código se está ejecutando, puedes decir que está hecho cuando el reloj de arena cambia de nuevo al icono del cuaderno <i class="fa-book fa">/i>.

{% include figure.html filename="jupyter-running-code.png" caption="Running a code cell in a Jupyter notebook" %}

Corre las dos celdas de código en el cuaderno, comenzando desde arriba.

<div class="alert alert-block alert-warning">
Los Jupyter Notebooks funcionan mejor si se ejecutan las células de forma secuencial. A veces puedes obtener errores o resultados incorrectos si ejecutas las celdas fuera de orden o intentas editar y ejecutar de forma iterativa diferentes partes del cuaderno. Si has hecho muchos cambios y ejecutas bloques de código de forma no lineal y encuentras que obtienes salidas extrañas, puedes reiniciar el Jupyter Notebook haciendo clic en <i>Núcleo</i> en el menú y eligiendo <i>Reiniciar y limpiar salida</i>. Incluso si no notas nada extraño, es una buena idea hacer <i>Restart & Clear Output</i> y volver a ejecutar tu código una vez que hayas terminado de escribirlo, para asegurarte de que la salida es precisa.</div>

Después de ejecutar la segunda célula de código, verás un error. Para averiguar lo que está pasando, puedes [consultar la documentación de la fecha y hora](https://docs.python.org/2/library/datetime.html?highlight=strftime#strftime-and-strptime-behavior) que explica cada una de las diferentes opciones de formato. Allí encontrarás que la única opción para los valores de los días asume fechas sin relleno (es decir, los días de un solo dígito se anteponen a un 0). Mirando los datos de ejemplo, los meses (listados en segundo lugar en este orden de fechas) tienen un relleno cero, pero no los días. Tienes dos opciones: puedes intentar cambiar los datos o puede intentar cambiar tu código.

Digamos que quieres probar un enfoque diferente, pero quieres dejar lo que ha hecho hasta ahora, en caso de que quiera volver a visitar ese código, y tal vez usarlo después de cambiar los datos. Para ayudarte a recordar lo que pasó, añade una celda de Markdown encima de tu segunda celda de código. Haz clic en la primera celda de código, luego haz clic en el botón más <i class="fa fa-plus"></i> en la barra de herramientas. Si sólo pulsas el botón más <i class="fa fa-plus">/i> en la barra de herramientas después de ejecutar la última celda de código, la nueva celda aparecerá en la parte inferior del cuaderno. Puedes moverla hasta donde quieras haciendo clic en el botón arriba <i class="fa fa-arrow-up"></i>. Asegúrate de que estás en el modo Markdown, y pega el siguiente texto:

```
### No funciona, necesita fechas con ceros [documentación de fecha y hora](https://docs.python.org/2/library/datetime.html?highlight=strftime#strftime-and-strptime-behavior). ¿Modificar el archivo fuente?
```

Leyendo [más adelante en el debate sobre StackOverflow](https://stackoverflow.com/a/16115575), hay otro enfoque que utiliza una biblioteca diferente, *dateutil*, que parece ser más flexible con los tipos de fechas que acepta. Vuelve a la celda que usaste para importar módulos, y edítala para añadir(en cualquier lugar de esa celda, siempre que cada declaración de importación esté en su propia línea):

``` py
import dateutil
```

Vuelva a ejecutar esa celda de código; nota que el número junto a la celda cambia la segunda vez que la ejecuta.

Ahora crea una nueva celda de Markdown en la parte inferior del cuaderno, y pégala:

```
### Intenta usar dateutil para analizar fechas, como en https://stackoverflow.com/a/16115575
```

Debajo de ella, añade una nueva celda de código con el siguiente código (prestando atención a las pestañas, para que el código esté separado tal y como lo ves abajo):

``` py
with open('ph-jupyter-notebook-example.csv') as f:
    csv_reader = csv.reader(f, delimiter=',')
    for row in csv_reader:
        parseddate = dateutil.parser.parse(row[1])
        print(parseddate)
```

Ejecuta el celular con el código que acabas de agregar. Puede tardar más tiempo; sigue esperando hasta que el asterisco junto a la celda del código se convierta en un número. El resultado debería mostrar la lista de fechas de publicación, con un formato diferente, con guión en lugar de barras oblicuas, y con las horas, minutos, segundos añadidos (como ceros, porque las fechas registradas no incluyen esos datos). A primera vista, parece que esto funcionó, pero si lo comparas más de cerca con el archivo fuente, verás que no está siendo consistente en la forma en que analiza las fechas. Las fechas en las que el valor del día es mayor que 12 se analizan correctamente (sabe que un valor mayor que 12 no puede ser un mes), pero cuando el valor de la fecha es 12 o menos, la fecha se analiza primero con el mes. La primera línea del archivo fuente tiene la fecha 1/7/18, que se analiza como "2018-01-07 00:00:00". En la documentación de dateutil, encontrarás que puedes [especificar dayfirst=true](https://dateutil.readthedocs.io/en/stable/parser.html) para arreglar esto. Edita la última celda de código, y cambia la penúltima línea para que se lea:

``` py
parseddate = dateutil.parser.parse(row[1], dayfirst=True)
```

Cuando vuelvas a poner la línea, verás que todas las fechas han sido analizadas correctamente.

El análisis de la fecha es sólo el primer paso... todavía necesitas usar el módulo date-time para convertir las fechas en días de la semana.

Borra la última línea del bloque de código y reemplázala por la siguiente (asegúrese de que tiene el mismo nivel de separación que la última línea anterior, para ambas líneas):

``` py
        	dayofweek = datetime.date.strftime(parseddate, '%A')
        	print(dayofweek)
```

Vuelve a ejecutar el bloque de código. Esto debería darte una lista de los días de la semana.

Ahora que tienes código para analizar y reformatear una fecha, necesitas hacerlo para ambas fechas en cada línea de tu archivo fuente. Como sabes que tienes código de trabajo en la celda de código actual, si no te sientes muy cómodo con Python, tal vez quieras copiar la celda de código actual antes de hacer las modificaciones. Selecciona la celda que quieres copiar y haz clic en el botón de copiar <i class="fa fa fa-files-o"></i> en la barra de herramientas; el botón de pegar <i class="fa fa-clipboard"></i> pegará la celda debajo de cualquier celda que esté seleccionada actualmente. Hacer una copia te permite hacer libremente cambios en el código, sabiendo que siempre puedes volver fácilmente a una versión que funcione.

Si no quieres trabajar por tu cuenta, puedes copiar y pegar este código en una nueva celda de código o reemplazar la celda de código actual:

``` py
#identifies the source file to open, calls it f
with open('ph-jupyter-notebook-example.csv') as f:
    #creates an output file (referred to as "out" in the notebook) for you to write to
    with open('ph-jupyter-notebook-example-dayofweek.csv', 'w') as out:
        #defines "csv_reader" as running the function csv.reader on the file
        csv_reader = csv.reader(f, delimiter=',')
        #defines "csv_writer" as running the functin csv.writer to "out" (the output file)
        csv_writer = csv.writer(out)
        #for each row that's being read by csv_reader...
        for row in csv_reader:
            #defines "csv_reader" as running the function csv.reader on the file
            csv_reader = csv.reader(f, delimiter=',')
            #for each row that's being read by csv_reader...
            for row in csv_reader:
            #creates a list called "values" with the contents of the row
              values = list(row)
              #defines "rating" as the first thing in the list
              #counting in Python starts with 0, not 1
              rating = values[0]
              #defines "parseddatepub" as the second thing (1, because we start with 0) in the list,
              #converted into a standard date format using dateutil.parser
              #and when those dates are parsed, the parser should know
              #that the first value in the sequence is the day
              parseddatepub = dateutil.parser.parse(values[1], dayfirst=True)
              #same as above for the updated date, the third thing (2) in the list
              parseddateupdate = dateutil.parser.parse(values[2], dayfirst=True)
              #defines "dayofweekpub" as parseddatepub (defined above), converted to the day of week
              #%A is what you use to change it to the day of the week
              #You can see othe formats here: https://docs.python.org/3/library/datetime.html#strftime-and-strptime-behavior
              dayofweekpub = datetime.date.strftime(parseddatepub, '%A')
              #same thing for update date
              dayofweekupdate = datetime.date.strftime(parseddateupdate, '%A')
              #creates a list of the rating and the newly formatted dates
              updatedvalues = [rating, dayofweekpub, dayofweekupdate]
              #writes all the values under this code cell
              csv_writer.writerow(updatedvalues)
              print(updatedvalues)
```

Después de ejecutar este código, tendrás un nuevo archivo, *ph-jupyter-notebook-example-dayofweek.csv*, con sus datos en el formato que necesita para el análisis.

Ahora que tienes el código de trabajo para convertir las fechas del formulario que tienes al formulario que necesitas, puedes limpiar los falsos comienzos y notas para ti mismo. Querrás conservar la primera celda de código con las declaraciones de importación y la primera celda de Markdown con el título y la descripción, pero deberías eliminar otras celdas de Markdown y de código que no sean tu código final. Para borrar una celda, haz clic en ella y luego en el botón de las tijeras <i class="fa fa-scissors">/i> de la barra de herramientas. Si borras una celda por error, puedes hacer clic en *Editar* en el menú y elegir "Deshacer Borrar Celdas".

### Guardando, exportando y publicando Jupyter Notebooks

Jupyter guarda su trabajo periódicamente creando "puntos de control" o “checkpoints”. Si algo va mal con su cuaderno, puede volver a un punto de control anterior yendo a “File”, luego “Revert to checkpoint“, y eligiendo una marca de tiempo. Dicho esto, sigue siendo importante guardar el cuaderno (usando el botón de Guardar <i class="fa fa-floppy-o"></i>), porque si cierras y apagas el núcleo del cuaderno (incluyendo el reinicio del núcleo), los checkpoints se perderán.

También puedes descargar el cuaderno (*File > Download as*) en varios formatos de archivo diferentes. La descarga del formato del cuaderno (.ipynb) es útil si quieres compartir tu código en su formato completo de cuaderno. También puedes descargarlo como código en cualquier idioma en el que esté tu cuaderno (por ejemplo, .r si está en R o .py si está en Python o .js si está en JavaScript), como un archivo .html, como un archivo de markdown (.md), o como un PDF a través de LaTeX. Si lo descargas como código, las celdas de Markdown se convierten en comentarios. (Si quieres convertir un archivo .ipynb a otro formato después de haberlo descargado, puedes usar la utilidad [nbconvert](https://github.com/jupyter/nbconvert).)

Si estás trabajando en un proyecto de investigación, puedes usar un Jupyter Notebooks, o una serie de Notebooks, a lo largo del camino para llevar un seguimiento de tu flujo de trabajo. Algunos académicos publican estos Notebooks en GitHub, junto con diapositivas o pósters en formato PDF, y datos de origen (o metadatos, si los derechos de autor lo permiten), para acompañar las presentaciones y charlas. GitHub ofrece versiones no interactivas de los archivos de los Notebooks, para que puedan ser vistos con anterioridad en un repositorio. Alternativamente, se puede pegar la URL de un repositorio GitHub que tenga Jupyter Notebooks en [nbviewer](https://nbviewer.jupyter.org/), lo que a veces permite una vista previa más rápida y fiable. Tal vez desee incluir una celda de Markdown con una cita recomendada para su Jupyter Notebook, y un puntero al repositorio GitHub donde se almacena, especialmente si su cuaderno incluye código que otros podrían reutilizar para análisis similares.

El código que acabas de desarrollar como parte de esta lección pertenece a algún lugar en medio de un proyecto real. Si estás usando Notebooks para documentar tu flujo de trabajo, puedes elegir añadir la nueva celda de código a un cuaderno existente, en lugar de descargarlo como un cuaderno separado e independiente. Los Jupyter Notebooks pueden ser particularmente útiles para documentar los flujos de trabajo de los proyectos cuando se trabaja con colaboradores que pueden estar involucrados sólo por un corto período de tiempo (como los pasantes universitarios durante el verano). Con colaboradores de corto plazo, es importante ayudarles a entender y comenzar a usar los flujos de trabajo del proyecto sin mucho tiempo de inicio, y los Jupyter Notebooks pueden presentar estos flujos de trabajo paso a paso, explicar dónde y cómo se almacenan los archivos, y proporcionar indicaciones sobre tutoriales externos y materiales de capacitación para ayudar a los colaboradores que están menos familiarizados con los fundamentos técnicos del proyecto a comenzar. Por ejemplo, dos proyectos que han utilizado Jupyter Notebooks para publicar flujos de trabajo son el [Proyecto de Realismo Socialista] de Sarah McEleney (https://github.com/sarahrahrah/Socialist-Realism-Project) y el ["minería de textos de la literatura infantil inglesa 1789-1914 para la representación de insectos y otros rastreros espeluznantes"] de Mary Chester-Kadwell (https://github.com/mchesterkadwell/bughunt-analysis).

A medida que su proyecto progresa, si está publicando a través de canales de acceso abierto, y sus conjuntos de datos pueden ser redistribuidos libremente, los Jupyter Notebooks pueden proporcionar un formato ideal para hacer que el código que sustenta su argumento académico sea visible, comprobable y reutilizable. Aunque las revistas y las editoriales no acepten los Jupyter Notebooks como formato de presentación, puede desarrollar una "versión" de su trabajo que incluya el texto completo (como las celdas de Markdown), con celdas de código integradas en el flujo de la narrativa académica como una ilustración inmediatamente accesible del análisis que está describiendo. También podría incluir las celdas de código que conforman los flujos de trabajo de preparación de datos como un apéndice, ya sea en el mismo cuaderno o en uno separado. Integrar el código con el texto de un artículo académico hace que sea mucho más probable que los lectores se comprometan realmente con el código, ya que pueden simplemente ejecutarlo dentro del mismo cuaderno donde están leyendo el argumento. Algunos académicos, particularmente en Europa, también envían sus Notebooks a [Zenodo](https://zenodo.org/), un archivo para la investigación sin importar el país de origen, el financiador o la disciplina. Zenodo soporta conjuntos de datos de hasta 50 GB (frente al límite de 100 MB de tamaño de archivo en Github), y proporciona DOI para el material cargado, incluyendo los Notebooks. Algunos académicos combinan el archivo en Zenodo para la sostenibilidad con la publicación en GitHub para la localizabilidad, incluyendo el DOI de Zenodo como parte del archivo readme.md en el repositorio de GitHub que incluye los Notebooks. Por ejemplo, el cuaderno de taller ["Applied Data Analytics"] de Giovanni Colavizza y Matteo Romanello para DHOxSS 2019](https://github.com/mromanello/ADA-DHOxSS2019) se publica en GitHub pero incluye un Zenodo DOI.

Si bien la argumentación y el código totalmente integrados siguen siendo difíciles de encontrar debido a la falta de un lugar donde publicar este tipo de trabajo, los académicos han comenzado a utilizar los Jupyter Notebooks como un paso incremental más interactivo hacia las publicaciones computacionales dinámicas. José Calvo tiene un ejemplo de un [cuaderno que acompaña un artículo sobre estilometría (en español)](https://github.com/morethanbooks/publications/tree/master/Cervantes_Conquista), y Jed Dobson publicó [un conjunto de Notebooks](https://github.com/jeddobson/cdh) para acompañar su libro *Critical Digital Humanities: The Search for a Methodology*, que aborda directamente los Jupyter Notebooks como objetos académicos (p. 39-41).

## Usando los Jupyter Notebooks para la enseñanza

Los Jupyter Notebooks son una gran herramienta para la enseñanza de la codificación, o para enseñar conceptos como el modelado de temas o los vectores de palabras que implican la codificación. La capacidad de proporcionar instrucciones y explicaciones como Markdown permite a los educadores dar notas detalladas sobre el código a través de la alternancia de celdas de Markdown y de código, de modo que el texto de Markdown explica el código en la celda de abajo. Esto es útil para los talleres prácticos, ya que las instrucciones y el código pueden ser escritos con antelación. Esto permite a los asistentes abrir el cuaderno, descargar un conjunto de datos y ejecutar el código tal cual está. Si esperas impartir un taller en el que los estudiantes tengan diferentes niveles de familiaridad con la codificación, puedes configurar el cuaderno para que tenga tareas suplementarias para los estudiantes que se sientan cómodos modificando el código. Al mismo tiempo, incluso los estudiantes que duden en tocar el código podrán lograr el resultado principal del taller con sólo ejecutar celdas de código pre-escrito.

Otro enfoque es usar los Jupyter Notebooks para escribir código sobre la marcha. En un taller, los estudiantes pueden empezar con un cuaderno en blanco y escribir el código junto contigo. Las celdas ayudan a segmentar el código a medida que lo escribes, a diferencia de utilizar un editor de texto o un IDE (Integrated Development Environment) que no descompone el código tan nítidamente y puede causar confusión, especialmente cuando se enseña a principiantes.

Puedes usar los Jupyter Notebooks para las tareas de clase dando instrucciones en Markdown y haciendo que los estudiantes escriban el código en una celda en blanco basándose en las instrucciones. De esta manera, puede crear una tarea de codificación interactiva que enseñe a los estudiantes no sólo la sintaxis y el vocabulario de un lenguaje de codificación, sino que también pueda explicar las mejores prácticas de programación en general.

Si ya estás utilizando los Jupyter Notebooks para documentar el flujo de trabajo de su proyecto, puedes volver a enmarcar estos Notebooks de investigación para su uso en el aula, como una forma de llevar su investigación al aula. Este [ejemplo de cuaderno pedagógico]({{ site.baseurl }}/assets/jupyter-notebooks/ph-jupyter-notebook-example.ipynb) es un híbrido de algunos de los enfoques pedagógicos descritos anteriormente. La primera sección del cuaderno está destinada a los estudiantes que tienen poca o ninguna experiencia previa en la ejecución de código; el principal resultado del aprendizaje es comparar el tiempo que se tarda en convertir manualmente los formatos de datos, en comparación con hacerlo con código. Podrías usar este cuaderno para una sesión práctica de laboratorio en una introducción a las humanidades digitales o a la historia digital, donde todos los estudiantes instalan Anaconda y aprenden los fundamentos de los Jupyter Notebooks. Si la clase tiene una mezcla de estudiantes sin conocimientos técnicos y estudiantes con exposición previa a Python, podrías dirigir a los estudiantes con experiencia en programación para que trabajen juntos en grupos de dos o tres para proponer soluciones a las indicaciones de la segunda parte del cuaderno. Ten en cuenta que si utiliza una tarea de clase como esta como una forma de hacer que los estudiantes de informática escriban código que ayude a su proyecto de investigación, deberían ser acreditados como colaboradores y reconocidos en las publicaciones subsiguientes que provengan del proyecto[^4].

Hay muchos cursos y talleres de humanidades digitales "Introducción a Python" que utilizan Jupyter Notebooks (entre ellos [Introduction à Python et au développement web avec Python pour les sciences humaines](https://github.com/PonteIneptique/cours-python) de Thibault Clérice, traducido del material original de Matthew Munson). Los Jupyter Notebooks también se utilizan comúnmente en los talleres de análisis de textos, como el [taller sobre vectores de la palabra en DH 2018](https://github.com/sul-cidr/dh2018-word-vector-workshops), impartido por Eun Seo Jo, Javier de la Rosa y Scott Bailey.

<a id="cloud"></a>
Enseñar con los Jupyter Notebooks no siempre tiene que implicar el largo proceso de descarga e instalación de la Anaconda, especialmente si se prevé tener sólo una o dos lecciones que impliquen Notebooks. Si las actividades de su clase con los Jupyter Notebooks implican el uso de datos de ejemplo que ya ha preparado, y si ya ha escrito al menos parte del código, es posible que desee explorar la ejecución de Jupyter Notebooks utilizando recursos de computación en nube gratuitos, siempre y cuando sus estudiantes tengan garantizada una conexión a Internet fiable en la clase. Ejecutar los Notebookes en la nube también proporciona un entorno consistente para todos los estudiantes, evitándole tener que negociar las diferencias entre Windows y Mac, o proporcionar una alternativa para los estudiantes cuyos Notebooks carecen del espacio en el disco duro o la memoria para ejecutar Anaconda de forma efectiva.

Debido a que las opciones están evolucionando rápidamente, es mejor utilizar su motor de búsqueda favorito para encontrar una lista reciente de opciones de computación en la nube para Jupyter Notebooks. Un proyecto que ha tenido una particular aceptación entre los usuarios académicos de Notebooks es [MyBinder](https://mybinder.org/), que usa un repositorio GitHub que contiene datos relacionados con los archivos .ipynb de Jupyter Notebooks (imágenes incrustadas, conjuntos de datos en los que quieres usar los Notebooks, etc.), e información sobre los paquetes y dependencias necesarios (en un archivo requirements.txt o environment.yml), y lo hace ejecutable usando un servidor en nube. Una vez que tengas el paquete MyBinder en tu repositorio GitHub, puedes añadir una "insignia" de Binder al archivo "readme" para el repositorio. Cualquiera que vea el repositorio puede ejecutar el cuaderno directamente desde su navegador, sin tener que descargar o instalar nada.

Dado que los datos a los que el cuaderno debe acceder deben estar incluidos en el repositorio, esto no funcionará en todas las situaciones (por ejemplo, si los datos no pueden ser redistribuidos legalmente en GitHub, exceden el tamaño máximo de archivo de GitHub y no pueden ser descargados de otro lugar como parte de la configuración del entorno de Binder, o si se quiere que la gente utilice el cuaderno con sus propios datos), pero es una gran opción para los talleres o clases en los que todos trabajan con los mismos datos compartidos.

Si quieres empezar a explorar las opciones de nubes, Shawn Graham ha creado algunas [plantillas para configurar los Notebooks de Python y R Jupyter para su uso en Binder](https://github.com/o-date/notebooks).

Por último, si necesitas mantener tus Notebooks *fuera* de la nube (por ejemplo, debido a datos sensibles o de otra manera restringidos) pero quieres proporcionar un entorno coherente para todos tus estudiantes, puedes explorar [JupyterHub](https://jupyterhub.readthedocs.io/en/stable/), que ha sido adoptado como infraestructura técnica básica para un número creciente de programas de ciencia de datos.

## Convertir el código Python existente

Aunque te guste la idea de usar los Jupyter Notebooks, cualquier conversión de formato requiere un trabajo adicional. Si ya tienes tu código escrito como código em Python, la conversión a Jupyter Notebooks es bastante sencilla. Puede copiar y pegar el código de su archivo .py en una sola celda de código de un nuevo cuaderno, y luego dividir la celda de código en segmentos y agregar celdas adicionales de Markdown según sea necesario.

Alternativamente, puede ser más fácil segmentar a medida que transfiere el código, copiando un segmento a la vez en una nueva celda de código. Cualquiera de los dos métodos funciona y es una cuestión de preferencia personal.

También hay herramientas como el [paquete p2j](https://pypi.org/project/p2j/) que convierten automáticamente el código Python existente en Jupyter Notebooks, siguiendo un conjunto documentado de convenciones (por ejemplo, convertir los comentarios en celdas de Markdown).


## Jupyter Notebooks para otros lenguajes de programación

Los Jupyter Notebooks permiten usar muchos lenguajes de programación diferentes, incluyendo R, Julia, JavaScript, PHP o Ruby. Una lista actual de los lenguajes disponibles se puede encontrar en la página de GitHub [Jupyter Kernels](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels).

Mientras que Python es soportado por defecto cuando se instala Jupyter Notebook a través de la Anaconda, los otros lenguajes de programación necesitan tener sus kernels de lenguaje instalados antes de que puedan ser ejecutados en Jupyter Notebook. Las instrucciones de instalación son diferentes para cada kernel de lenguaje, por lo que es mejor simplemente encontrar y seguir las instrucciones para su lenguaje preferido. Al menos para la R, esto es relativamente sencillo. La página de GitHub [Jupyter Kernels](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels) tiene enlaces a las instrucciones para todos los kernels de idiomas disponibles.

Una vez que tengas instalado el núcleo para tu(s) lenguaje(s) deseado(s), puedes ejecutar Notebooks escritos en ese lenguaje de programación, o puedes crear tus propios Notebooks que ejecuten ese lenguaje. Cada idioma con un núcleo instalado en su computadora estará disponible como una opción cuando cree un nuevo cuaderno como se describió anteriormente.

Como ejemplo de un cuaderno R, ver [esta adaptación de Jupyter del código R de Andrew Piper de "Enumeraciones"](https://github.com/quinnanya/enumerations).


## Escalando la computación con los Jupyter Notebooks

Especialmente si eres nuevo en la escritura de Python, hacer que cualquier cosa funcione puede sentirse como una victoria. Sin embargo, si empiezas a trabajar con conjuntos de datos más grandes, puedes descubrir que algunas de las "soluciones" iniciales que encontraste (como usar `.readlines()` para leer un archivo de texto línea por línea) resultan ser computacionalmente ineficientes, hasta el punto de causar problemas. Una forma de empezar a entender las ineficiencias en su código es añadir "%%%timeit" a la parte superior de una celda. El cuaderno elegirá un número de iteraciones para ejecutar el código, dependiendo de la complejidad de la tarea, e imprimirá el número de iteraciones y el tiempo promedio. Hacer múltiples iteraciones, en lugar de una sola, puede ser útil para tener en cuenta pequeños retrasos a nivel de sistema (por ejemplo, si su Notebook está momentáneamente atascado con otros procesos.) Si quieres cronometrar múltiples iteraciones de una sola línea, en lugar de toda la celda, puedes agregar `%timeit` delante de la línea. Ten cuidado con la forma en que aplicas esto: clasificar una lista tomará mucho más tiempo para la primera iteración que para la segunda, después de que la lista ya esté en orden. En casos como el ordenamiento de listas donde no tiene sentido medir múltiples iteraciones, o para tareas de larga duración donde los pequeños retrasos a nivel de sistema no tendrán un impacto significativo, puedes usar `%%time` en la parte superior de una celda, o `%time` delante de una línea, que mide el tiempo que tarda una sola ejecución. Estos comandos son parte de una familia de "comandos mágicos" incorporados y disponibles en los Jupyter Notebooks; ver la [documentación de Jupyter](https://ipython.readthedocs.io/en/stable/interactive/magics.html) para más detalles.

Tener alguna idea de en cuánto tiempo es probable que su código se ejecute es un requisito previo importante para la ampliación a recursos de computación más grandes, como los clústeres de computación de alto rendimiento (HPC) financiados centralmente y disponibles en muchas instituciones. Una abrumadora mayoría de los investigadores que utilizan estos recursos se dedican a las ciencias, pero normalmente cualquier miembro de la universidad puede solicitar acceso. También puede obtener acceso a los recursos de HPC regionales o nacionales. Estos recursos de computación pueden acelerar significativamente los trabajos de computación de gran tamaño, especialmente las tareas como el modelado en 3D que pueden aprovechar los nodos de computación con potentes unidades de procesamiento gráfico (GPU). Aprender a utilizar los clústeres de HPC es un tema suficientemente amplio para su propia lección, pero los Jupyter Notebooks pueden permitirle tomar un atajo. Algunos grupos de investigación en computación ofrecen maneras más fáciles para que los investigadores ejecuten los Jupyter Notebooks usando los recursos de los clusters HPC, y puedes encontrar [múltiples guías y ejemplos de uso general](https://ask.cyberinfrastructure.org/t/how-can-i-run-jupyter-notebooks-on-my-institutions-hpc-cluster/74) para hacerlo. Si puedes tener acceso a los recursos HPC, vale la pena contactar con el personal de TI de investigaciones en computación y preguntar cómo puedes ejecutar tus Jupyter Notebooks en el clúster, si no ves la documentación en su sitio web. El personal de TI de investigación que trabaja principalmente con científicos puede comunicarse de forma más brusca de la que estás acostumbrado, pero no dejes que eso te desanime: la mayoría de los grupos de TI de investigación están entusiasmados con los humanistas que utilizan sus recursos y quieren ayudar, porque la diversidad disciplinaria entre su base de usuarios es importante para sus métricas a nivel universitario.


## Conclusión

Desde la experimentación con el código hasta la documentación de los flujos de trabajo, desde la pedagogía hasta la publicación académica, los Jupyter Notebooks son un instrumento flexible y polivalente que puede servir de apoyo a la investigación digital en muchos contextos diferentes. Incluso si no estás seguro de cómo los vas a usar exactamente, es bastante fácil instalar el software de los Jupyter Notebooks y descargar y explorar los Notebooks existentes, o experimentar con algunos de los tuyos. Los Jupyter Notebooks son muy prometedores para unir las facetas críticas y computacionales de la investigación digital en humanidades. Para concluir con una cita de *Critical Digital Humanities: The Search for a Methodology* de Jed Dobson:
> Los Notebooks son teoría - no sólo el código como teoría, sino la teoría como un compromiso reflexivo con el trabajo teórico y las implicaciones del código en sí mismo. Las normas disciplinarias - incluyendo el encuadre contextual, la teoría y la autocrítica - necesitan acompañar, complementar e informar cualquier crítica computacional. Revelar tanto del código, los datos y los métodos como sea posible es esencial para permitir la conversación disciplinaria en curso. Compilarlos juntos en un solo objeto, uno que pueda ser exportado, compartido, examinado y ejecutado por otros, produce un tipo de teorización dinámica que es modular pero estrechamente ligada a su objeto.[^5]

## Enlaces

- Una creciente [lista de Jupyter Notebooks para DH](https://github.com/quinnanya/dh-jupyter), en múltiples lenguajes humanos y de programación. Gracias a todos los que enviaron sugerencias en Twitter; referencias adicionales son bienvenidas.
- Una detallada descripción técnica de [instalación de paquetes Python de Jupyter](https://jakevdp.github.io/blog/2017/12/05/installing-python-packages-from-jupyter/).


## Agradecimientos

- Gracias a Stéfan Sinclair por las referencias a los debates anteriores sobre el uso de los Notebooks en las humanidades digitales.

- Gracias a Rachel Midura por sugerir el uso de los Jupyter Notebooks para la colaboración.

- Gracias a Paige Morgan por el recordatorio sobre la importancia de enfatizar los asuntos de estado.

[^1]: Knuth, Donald. 1992. *Literate Programming*. Stanford, California: Center for the Study of Language and Information.

[^2]: Millman, KJ and Fernando Perez. 2014. "Developing open source scientific practice". In *Implementing Reproducible Research*, Ed. Victoria Stodden, Friedrich Leisch, and Roger D. Peng. https://osf.io/h9gsd/

[^3]: Sinclair, Stéfan & Geoffrey Rockwell. 2013. "Voyant Notebooks: Literate Programming and Programming Literacy". Journal of Digital Humanities, Vol. 2, No. 3 Summer 2013. http://journalofdigitalhumanities.org/2-3/voyant-notebooks-literate-programming-and-programming-literacy/

[^4]: Haley Di Pressi, Stephanie Gorman, Miriam Posner, Raphael Sasayama, and Tori Schmitt, with contributions from Roderic Crooks, Megan Driscoll, Amy Earhart, Spencer Keralis, Tiffany Naiman, and Todd Presner. "A Student Collaborator's Bill of Rights". https://humtech.ucla.edu/news/a-student-collaborators-bill-of-rights/

[^5]: Dobson, James. 2019. *Critical Digital Humanities: The Search for a Methodology*. Urbana-Champaign: University of Illinois Press. p. 40.



-
