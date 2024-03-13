---
title: Del caos hacia el orden, gestionar fuentes primarias digitales con Tropy
slug: gestionar-fuentes-primarias-digitales-con-tropy
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Douglas McRae
- Anita Lucchesi
- Sofia Papastamkou
reviewers:
- 
editors:
- 
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/598
difficulty: 1
activity: analyzing
topics: [data-manipulation, data-management]
abstract: "El propósito de este tutorial es enseñar a los investigadores cómo iniciar un proyecto de Tropy con la finalidad de gestionar las imágenes (fotos, digitalizaciones) de sus fuentes primarias." 
avatar_alt: 
doi: 
---

{% include toc.html %}

## Introducción
Muchos si no la mayoría de historiadores han comenzado a trabajar en alguna forma con fuentes digitalizadas. Además de la disponibilidad de repositorios digitales con fuentes primarias digitalizadas de una manera profesional y sistemática, muchos investigadores pueden sacar fotografías en los mismos archivos físicos, según la política de la institución. El resultado ha sido una transformación de la manera en la que los investigadores trabajan en los archivos. Uno puede recopilar cientos y hasta miles de fotos durante las jornadas investigativas en el archivo. Este fenómeno a su vez puede crear cierto caos, ya que se necesita una forma para organizar una cantidad tan grande de imágenes y tratarlas como fuentes históricas.

Tropy es una herramienta desarrollada justamente para abarcar este problema de sobrecarga. Es un software de apoyo para el investigador contemporáneo para organizar y facilitar el análisis de las fuentes digitales. Además de proporcionar una interfaz para organizar imágenes recopiladas a través de la investigación, permite la descripción y gestión de materiales con metadatos y plantillas flexibles. Tropy cuenta con diferentes funciones para editar imágenes y agregar transcripciones y notas, incluso a selecciones dentro de una imagen. Es posible, además exportar datos para compartir con otros o integrar con otras herramientas digitales. En síntesis, Tropy busca poner orden en el caos que suele manifestar en proyectos dependientes de una gran cantidad de fuentes digitalizadas.

## Descripción de Tropy

-   Tropy es una herramienta digital sin costo de código abierto que ayuda a los investigadores con la organización, descripción y exportación de sus materiales de investigación digitalizados, ya sean fotos de documentos u objetos provenientes de repositorios en línea. Fue creado para aquellos investigadores que buscan soluciones para la organización de grandes cantidades de materiales digitalizados, una situación actualmente muy común entre los investigadores archivales.

-   Tropy fue estrenado en 2016 por el Roy Rosenzweig Center for History and New Media en George Mason University ([RRCHNM](https://rrchnm.org/))  en Fairfax, Virgínia, (EEUU). Su desarrollo prosiguió con el apoyo del RRCHNM y el Center for Contemporary and Digital Scholarship ([C2DH](https://www.c2dh.uni.lu/)) de la Universidad de Luxemburgo, y [Digital Scholar](https://digitalscholar.org/), la misma organización sin fines de lucro que administra otras herramientas de código abierto establecidas como Omeka y Zotero.

-   Tropy cuenta con diferentes recursos para orientar al principiante, la mayoría de los cuales son accesible por la página de web principal, [tropy.org](http://tropy.org). El código de Tropy reside en [el repositorio del proyecto en Github](https://github.com/tropy). Tropy tiene una [documentación completa](https://docs.tropy.org/) (en inglés) que proporciona una orientación textual a la herramienta. Además, es posible hacer preguntas, comentarios o sugerencias a través del [foro comunitario](https://forums.tropy.org/). El [canal de Youtube](https://www.youtube.com/tropy) de Tropy aloja videotutoriales en inglés y español--además, es posible encontrar grabaciones de talleres, tutoriales y webinars hechos por otros usuarios.

-   Tropy es una herramienta útil para historiadores así como estudiosos de humanidades digitales. También tiene gran utilidad para cualquier investigador archival contemporáneo fuera de su conocimiento sobre programación. Aprender a usarlo es intuitivo, principalmente porque es un organizador de fotos diseñado para historiadores.
  
## Dataset

De modo de ejemplo, este tutorial hace uso de una colección de expedientes judiciales de la colección "[Sección Civiles-Esclavos](https://archivo.redhistoriave.org/?_ga=2.88974747.1008451912.1691784501-889984938.1690214108&_gl=1*9i0xod*_ga*ODg5OTg0OTM4LjE2OTAyMTQxMDg.*_ga_64130MY5HV*MTY5MTc4NDUwMC4zLjEuMTY5MTc4NDUwOS4wLjAuMA..*_ga_JSBL2XLMXD*MTY5MTc4NDUwMC4zLjEuMTY5MTc4NDUwOS4wLjAuMA..)" del archivo de la Academia Nacional de la Historia de Venezuela (ANHV), digitalizada por la [Red Historia Venezuela](https://archivo.redhistoriave.org/) (RHV) (Figura 1). Se trata de 404 entradas, repartidas en 381 tomos y 23 cajas con expedientes sueltos. Son unos 123.800 folios, en poco más de 61.900 capturas. Para acceder a la colección, es necesario registrarse. A través de este tutorial, el usuario comprenderá cómo crear proyectos en Tropy basados en colecciónes digitales como ésta. 

{% include figure.html filename="es-or-gestionar-fuentes-primarias-digitales-con-tropy-01.png" alt="Página principipal de la Red Historia Venezuela con ménu de Archivo Digital abierto" caption="Figura 1. Página principal de la Red Historia Venezuela, repositorio digital de la colección utilizada en este tutorial" %}

## Para empezar: Instalación y configuración de proyecto

### Instalación

Tropy es una aplicación de escritorio. Para instalarla, basta entrar a [la página web principa](http://tropy.org)l y hacer clic en el botón "Download Tropy for [nombre de sistema auto-detectado]. Después, busca el instalador en tu disco duro y sigue las instrucciones según tu sistema operador (Mac, Windows, o Linux). Además, siempre se encontrará la versión más actualizada además de versiones previas y beta en [el repositorio de Github](https://github.com/tropy/tropy/releases) (busca la etiqueta "Latest.")

### Tipo de Proyecto 

Un proyecto en Tropy es el archivo donde se guardan las fotos de archivo con sus datos y metadatos acompañantes.

Al abrir Tropy por primera vez, deberás dar un nombre al proyecto y escoger qué tipo de proyecto prefieres. Se recomienda concebir a los proyectos de la forma más amplia: a nivel de un manuscrito de libro, o tesis de doctorado, o un tema general que puede abarcar múltiples posibilidades. Por ejemplo, para este proyecto, en lugar de nombrarlo por el archivo o repositorio, uno podría escoger un nombre que refleja un tema general, como "Afro-venezolanos" (Es posible cambiar el nombre dentro del proyecto más adelante).

También deberás escoger entre un proyecto convencional (.tpy) o avanzado (.tropy). La diferencia queda en la forma en la que Tropy vincula las fotos con el archivo de proyecto. Al importar una foto, Tropy establece una ruta entre el proyecto y la foto, visualizando la imágen dentro de la interfaz del proyecto  En un proyecto convencional, Tropy hace copias de las imágenes importada, y las guarda en el directorio del archivo, estableciendo la ruta por esa ubicación. En un proyecto avanzado, Tropy establece una ruta entre el proyecto y la foto en su ubicación original, sin hacer una copia.

Con un proyecto convencional, es más fácil reubicar el proyecto: transferirlo a otra computadora o compartirlo con otro usuario. Con un proyecto avanzado, al reubicar el archivo será necesario restablecer la ruta entre las imágenes y el proyecto a través de un proceso de consolidación. Para consolidar una imagen con la ruta rota (indicado por una bandera con un punto de exclamación) sólo basta hacer clic derecho, seleccionar "Consolidar objeto" del menú contextual, y buscar la nueva ubicación de la imágen. Tropy muchas veces pedirá revincular otras imágenes en el mismo directorio, si es que faltan otras imágenes para consolidar. 

### Ubicación de Proyecto

La ubicación del proyecto deberá depender del tamaño proyectado del proyecto. Si has escogido un proyecto convencional, habrá que verificar que hay espacio en la computadora, el disco duro, o una carpeta de la nube para almacenarlo.  

### Idioma

Tropy cuenta con diferentes locales de idioma. Puedes escoger su lengua preferida a través de Archivo>Preferencias en Mac OS y Editar >Preferencias en Windows, seleccionado su preferencia del menú desplegable.

## Importación de fotos

El proceso de importación es la manera en la que Tropy establece rutas entre imágenes y el proyecto para facilitar el descubrir o localizar las fuentes. Es posible importar imágenes en los siguientes formatos: JPG/JPEG, PNG, SVG, TIFF, GIF, PDF, JP2000, WEBP, HEIC, AVIF. 

En el caso de los expedientes judiciales de la ANHV, todos provienen de escaneos de alta calidad guardados en formato PDF. Antes de importar en PDF, es importante verificar [la resolución en píxeles (ppi)](https://es.wikipedia.org/wiki/Píxeles_por_pulgada) en el menú Tropy>Preferencias>Parámetros. El valor por defecto es 72 ppi, el cual facilita la importación rápida de archivos PDF; sin embargo puede disminuir la calidad de la visualización. Se recomienda aumentar el valor entre 144 a 288 ppi si la calidad por defecto no es suficiente.

### Importación del web 

Tropy puede importar fotos estáticas desde el internet. Arrastra la imagen escogida desde la ventana del navegador de web hasta la ventana principal de Tropy (la vista del proyecto). Si estás trabajando con un proyecto convencional, Tropy hará una copia de la imagen. Si estás trabajando con un proyecto avanzado, Tropy establecerá una ruta con la URL de la imagen estática.

En el caso de los expedientes Sección Civil-Esclavos, los documentos están en formato PDF y entonces es necesario descargarlos antes de importar en este mismo formato. Por otro lado, [esta imagen ](https://www.loc.gov/item/90682931/)(parte de la colección cartográfica de la Biblioteca del Congreso de los Estados Unidos) es estática y puede ser importada desde la web. Cualquier imagen estática incrustada en una página web que cuenta con su propia URL puede ser importada. Antes de importar, es importante verificar que la imagen a importar sea de una calidad adecuada, ya que la imagen importada será de la misma resoluction.

>verifica que está clarificación sea suficiente sobre la calidad de imagenes importadas del web

### Fotos

Es posible arrastrar fotos desde su computadora o desde una diapositiva adjunta (como memoría USB, disco duro externo, o carpeta en la nube) a un proyecto de Tropy. Simplemente arrastra un archivo o conjunto de archivos a la interfaz principal (la vista de proyecto). Tropy comenzará a importarlas al proyecto uno por uno. También es posible seleccionar imágenes para importar a través de Archivo>Importar>Fotos.

### Carpetas

Es posible también importar una carpeta de imágenes a través del menú Archivo>Importar>Carpeta.

Si descargas tomos de la Sección Civil-Esclavos, puedes guardarlos en su disco preferido y luego importarlos a través de cualquier de los métodos mencionados. En el menú Tropy>Preferencias (Edit>Preferencias en Windows)>Proyecto, es posible designar una Carpeta monitoreada--cada vez que un formato compatible sea agregado a la carpeta designada, se importará al proyecto de Tropy. Usa el botón Navegar (Figura 2) para vincular una carpeta. <div class="alert alert-warning"> OJO: en el caso de descargar archivos de tamaño grande para importar a un proyecto convencional, debe considerar borrar las imagenes de la carpeta monitoreada, ya que Tropy hará una copia dentro del archivo del proyecto.</div>

{% include figure.html filename="es-or-gestionar-fuentes-primarias-digitales-con-tropy-02.png" alt="Sección de la venta de Preferencias, mostrando los parámetros del proyecto" caption="Figura 2. En la sección de Proyecto bajo preferencias, es posible designar una carpeta monitoreada para facilitar la importación" %}

## Acciones masivas

Siempre después de importar un conjunto de imágenes, es recomendable procesarlos e agregar algunos metadatos inmediatamente. Esta sección del tutorial describe algunas de las acciones masivas que puedes ejecutar después de importar un grupo de imágenes. Nota: es posible visualizar las últimas imágenes importadas a un proyecto a través de la lista automática "Última importación," ubicada en la barra izquierda en la vista de proyecto.

### Orientación

Como en muchas aplicaciones de fotos, es posible cambiar la orientación de las imágenes. Haz clic derecho (Control+clic izquierda en Mac) en una imagen, y después selecciona "Rotar a la derecha" o "Rotar a la izquierda" del menú contextual. Al seleccionar varias imágenes, es posible rotar múltiples simultáneamente, facilitando la lectura y análisis de las fuentes después.

### Editar múltiples campos de metadatos

En la mano derecha de la vista de proyecto, se encuentra la plantilla de metadatos. La plantilla por defecto, "Tropy Generic" contiene una serie de propiedades convencionales para describir un objeto de archivo--es posible elegir otras plantillas incluidas con Tropy en el menú desplegable. "Tropy Correspondence" por ejemplo está diseñado para documentos corresponsales: cartas, telegramas, y similares. Además, Tropy viene con una plantilla con los quince elementos de metadatos de [Dublin Core](https://es.wikipedia.org/wiki/Dublin_Core), y otro para grabar los metadatos del archivo de la foto.

Los tomos de "Seccíon Civil-Esclavos" del ANHV llevan muchos metadatos en común; por ejemplo: Tipo, Fuente y Colección. Otros pueden variar según el tomo o expediente particular (Título, Creador, Fecha). Más adelante, se explicará cómo desarrollar plantillas de metadatos personalizados para colecciones específicas. Es posible agregar campos adicionales para un objeto individual haciendo clic derecho (Ctrl+clic en Mac) en la plantilla de metadatos activa y seleccionado "Nuevo campo" del menú de contexto. Luego, usas la barra de búsqueda para encontrar la propiedad más apta. Tropy contiene una gran cantidad de vocabularios de metadatos, de la cual se hablará más adelante.

### Fusionar/Deconstruir

Tropy puede fusionar imágenes individuales en objetos con múltiples fotos. De esta manera, es posible combinar una secuencia de fotos sacadas individualmente para reconstituir un documento del archivo: una carta, un informe, un manuscrito, etc. Para fusionar, selecciona las fotos en las imágenes, abre el menú contextual (clic derecha en Windows o Control+clic izquierda en Mac) y elige "Fusionar"--la portada del nuevo objeto fusionado será la primera imagen seleccionada. También, si arrastras una imagen encima de otra, las dos se fusionarán (con la segunda como portada). Puedes reorganizar el orden de las fotos en el panel bajo la plantilla de metadatos a la mano derecha de la interfaz.

En el caso de un documento PDF con múltiples páginas, tal como en el caso de los tomos de la Sección Civil Esclavos de la ANHN, se importarán las imágenes como objetos fusionados. En ciertos casos, será necesario deconstruir un objeto fusionado, lo cual se puede hacer seleccionado el objeto, eligiendo "Deconstruir" del menú contextual. El resultado será la separación de las fotos o imágenes individuales, todavía con los metadatos y anotaciones agregadas previamente.

En el caso de los expedientes de la Sección Civil-Esclavos: podría ser más provechoso para el investigador tener los expedientes apartados de los tomos anuales (Figura 3). Después de deconstruir un tomo importado, puedes fusionar de nuevo las imágenes de los folios separados para recrear los expedientes individuales, luego para agregar los metadatos únicos de cada expediente. 

{% include figure.html filename="es-or-gestionar-fuentes-primarias-digitales-con-tropy-03.png" alt="Sección de la vista de galeria con el menú de contexto destacado, mostrando la función de Deconstruir." caption="Figura 3. La opción de fusionar y deconstruir objectos puede facilitar la transformación de imágenes individuales y PDF imensos en documentos digitales, según la preferencia del investigador" %}

## Descripción de fotos

Una de las funciones más importantes de Tropy es la de describir las fuentes a través de metadatos y anotaciones. Además, es posible organizar imágenes usando un sistema de etiquetas y listas personalizadas. Estas descripciones agregadas por el propio investigador ayuda con la descubribilidad de las fuentes y la creación manual de referencias de tus fuentes primarias.

Al hacer doble clic en un objeto (una imagen individual o imágenes fusionadas), el proyecto pasará a la vista de objeto (haz clic en la flecha en la parte superior izquierda para volver a la vista de galería), donde además de continuar ingresando metadatos, puedes editar ligeramente la(s) foto(s) en un objeto y agregar notas o anotaciones. En la vista de objeto, la plantilla de metadatos aparece a la mano izquierda de la interfaz. En esta vista, es más fácil analizar la imagen para agregar metadatos individuales. Siempre es recomendable ingresar los metadatos de una manera consistente. Por ejemplo, si ingresas el nombre del creador (autor) de un expediente por apellidos seguidos por primeros nombres, deberías seguir con este formato. De la misma manera, es recomendado que uses el formato de [fecha ISO](https://es.wikipedia.org/wiki/Organizaci%C3%B3n_Internacional_de_Normalizaci%C3%B3n) (AAAA-MM-DD, es decir, año con cuatro numerales, mes y día con dos numerales) para los valores en el campo para "Fecha." (1730-02-01 se convertirá en 1 feb 1730). Tropy reproducirá la fecha legible para organizar en columnas de forma cronológica. {% Agregué el enlace--es correcto decir que a ingresar 1730-02-01 en el campo de Fecha, se convertirá a 1 feb 1730. %}

Personalizando metadatos

Tropy cuenta con un editor de plantillas para facilitar la creación de plantillas de metadatos personalizadas. En Preferencias, navega a plantillas, donde puedes revisar cualquier plantilla en la instalación.

Para los documentos de "Sección Civil-Esclavos" de la ANHV, es posible crear una plantilla para los expedientes individuales (si ya deconstruiste los tomos para luego fusionar en expedientes). Esta plantilla personalizada puede ser usada para grabar los metadatos a nivel del expediente, lo cual podría ser una forma más propicia para la organización y facilidad de búsqueda (Figura 4).

{% include figure.html filename="es-or-gestionar-fuentes-primarias-digitales-con-tropy-04.png" alt="VIsta de objeto en Tropy, mostrando una plantilla personalizada para un expediente digitalizada a al derecha y la imagen del documento a la izquierda" caption="Figura 4. Se ha aplicado una plantilla personalizada para este expediente, correspondiendo a los metadatos disponibles en el repositorio digital" %}

Para hacer una nueva plantilla desde cero, asegura que "Nueva plantilla" aparece en el menú desplegable e ingresa los metadatos requeridos para identificar la plantilla: Nombre, Tipo, Creador y Descripción (no se recomienda modificar la URI generada por el editor). Después haz clic en "Crear." Usando los botones de (+) y (-), puedes agregar (o suprimir) nuevas propiedades a la nueva plantilla. Estas propiedades pueden ser parte de cualquier vocabulario instalado en Tropy: elementos y términos de Dublin Core, [vocabularios RDF](https://es.wikipedia.org/wiki/RDF_Schema), y [European Data Model](https://es.wikipedia.org/wiki/Europeana) y vocabularios relacionados. Tropy te da flexibilidad de mezclar diferentes vocabularios, además de usar elementos únicos de Tropy ('tropy:box', 'tropy:collection')

Cuando agregas una propiedad, puedes modificarlo para indicar que tipo de dato, darle un rótulo diferente del nombre por defecto, poner un consejo (por ejemplo: 'Apellidos, Primeros nombres' para recordar el orden grabar los nombres del autor) y también un valor por defecto. El último puede ayudar en el procesamiento de fuentes, por ejemplo cuando aplicas una plantilla prellenado para cierta colección con múltiples imágenes de la misma.

Para los expedientes de al ANHV, puedes crear una plantilla para los metadatos provenientes de la página de web, por ejemplo Descripción (dc:description) Alcance (dcterms:extent), y Lugar creado (Iptc4xmpExt:Location created). Otras propiedades dependen de qué consideras importante para describir con las fuentes del proyecto.

Es posible también construir una plantilla personalizada basada en otra. Elige una plantilla existente del menú desplegable y haz clic en las dos rectángulos al lado derecho. El editor hará una copia de la plantilla, que puedes guardar después de confirmar los metadatos para la plantilla (cambiar el nombre por ejemplo). La nueva plantilla contendrá las mismas propiedades de la primera, y puedes agregar y suprimir a gusto.

### Campos obligatorios y campos de solo lectura 

En las plantillas por defecto, siempre puedes observar una bandera al lado del campo de "Derechos." Este ícono sirve como recordatorio para llenar el campo. Esta preferencia aparece en el editor de plantillas. Puedes definir un campo de una plantilla personalizada como campo obligatorio o campo de solo lectura. Después de ingresar un valor en un campo obligatorio, se borrará la bandera recordatoria. Por otro lado, si ingresas un valor por defecto para el nombre del Repositorio (dc:collection), solo será posible modificarlo en el editor, y un candado aparecerá al lado del campo correspondiente en el panel de plantilla.

Todas estos parámetros, conjuntamente con los consejos, pueden ayudar para la estandarización de los metadatos: recordando cuáles son más importantes y cómo ingresarlos con el fin de mantener la consistencia. Pueden ayudar a otros usuarios también, si deciden importar una plantilla para sus propios proyectos.

### Vocabularios controlados

En la ventana de Preferencias, puedes revisar los vocabularios que vienen con Tropy en el area de Esquemas. Haz clic izquierda en cualquier de los esquemas para revisar sus elementos.  Es posible agregar otros vocabularios haciendo clic izquierda en el botón de '+' en la parte inferior de la ventana. Los esquemas deberán estar en formato .n3 o .ttl. Es posible ver una lista extensa de esquemas de vocubalorios controlados que se importarán facilmente a Tropy en el repositorio de [Linked Open Vocabularies (LOV).](https://lov.linkeddata.es/dataset/lov)

## Editar y anotar fotos

En la vista de objeto, existen diferentes herramientas para cambiar el aspecto y la legibilidad de una imagen. También es posible hacer anotaciones, tanto en las imágenes como en selecciones.

### Ediciones para Legibilidad

En la parte superior de la vista de objeto, hay una serie de herramientas para ajustar y rotar la imagen actual. En la parte superior derecha, hay un botón para "modificar foto", donde a través de controles deslizantes, puedes ajustar el brillo, contraste, tono, saturación, y nitidez--todos para restaurar legibilidad a documentos borrosos, ya por su condición o por la calidad de la foto sacada en el archivo. Hay la opción de invertir colores, una opción para facilitar la lectura de microfilmes, o para ver el negativo de una fuente visual.

### Selecciones

Una de las herramientas más importantes es la de seleccionar. Haz click en la cuadra de puntas en la parte superior de la vista de objeto y usa el seleccionador para indicar una parte de la imagen. Después de unos segundos, aparecerá la selección. Puedes mirar cada uno haciendo clic en la selección, o usando el panel de fotos a la izquierda. 

### Notas

En el campo de notas (Figura 5), puedes hacer cualquier anotación con texto enriquecido. Este texto también es buscable desde la barra de búsqueda en la vista de proyecto. Según tu preferencia, puedes cambiar el modo de visualización del campo de notas de horizontal a lado a lado. Incluso es posible colocar links en el campo de notas. Puedes también hacer notas tanto en selecciones como en fotos. Para comenzar, simplemente escribe en el campo de notas--se guardará automáticamente en la base de datos del proyecto.

{% include figure.html filename="es-or-gestionar-fuentes-primarias-digitales-con-tropy-05.png" alt="Vista de objeto en Tropy mostrando un documento, controles deslizantes de edición visual, y el campo de notas en moda vertical con un breve texto" caption="Figura 5. Diferentes funciones en la vista de objeto: el campo de notas, edición de imagen, y selecciones (el rectángulo azul). El campo de notas puede ubicarse abajo o al lado del documento." %}

## Organización de fotos

Además de la plantilla de metadatos, puedes describir tus fuentes en Tropy usando metadatos "no estructurados," es decir, metadatos que no pertenecen a ningún esquema o vocabulario formal. Ejemplos de este tipo de metadato pueden ser descripciones temáticas referentes al documento ('enfermedad', 'niño', "forro de libertad"), cronológico ('Siglo XIX') o relacionado con tu flujo de trabajo ('Falta transcripción', "Metadatos completos'). Es posible agregar estos temas usando etiquetas. La barra de etiquetas aparece en la mano izquierda de la vista de proyecto (Figura 6)

Las listas ejercen una función parecida: pueden ser utilizadas para la organización de fuentes en grupos y subgrupos. Estas agrupaciones pueden ser por tópico, o pueden reflejar la organización de una publicación proyectada (Figura 6). En el caso de documentos del periodo colonial en Hispanoamérica, muchos documentos se encuentran en diversos acervos, a veces lejos del sitio donde fue creado. Agrupaciones flexibles como listas y sublistas pueden ayudar para reconstituir documentos separados a través del tiempo, ayudando al investigador de trabajar "contra el grano" del archivo formal.

{% include figure.html filename="es-or-gestionar-fuentes-primarias-digitales-con-tropy-06.png" alt="Sección de la interfaz de Tropy mostrando la barra de listas y barra de etiquetas de varios nombres y colores" caption="Figura 6. Las listas y las etiquetas son flexibles y pueden ser utilizadas para dar otros niveles de organización más allá de los metadatos de la plantilla" %}

### Listas

Para crear una lista, haz clic derecho (Ctrl+clic en Mac) en la barra en la barra de etiquetas. Selecciona "Nueva Lista" del menú contextual y da un nombre a la carpeta que aparece (por ejemplo: 'Capítulo 2'). Después, presiona Intro o haz clic izquierdo. Ahora, puedes arrastrar tus fuentes desde la vista de proyecto hacia la nueva lista. Es posible agregar una fuente a múltiples listas, incluyendo sublistas de la lista matriz. Para quitar un objeto de una lista, puedes seleccionar esta opción del menú contextual. Si seleccionas "Suprimir objeto" el objeto será colocado en "Objetos suprimidos." Para crear una sublista dentro de una lista, haz clic derecho (Ctrl+clic en Mac) en la lista y selecciona "Nueva lista." Puedes cambiar el orden de una lista simplemente arrastrándola a otra ubicación entre las listas (por otro lado, las etiquetas aparecen en orden alfabético).

### Etiquetas

Para crear una nueva etiqueta, hay múltiples opciones. Selecciona un objeto u objetos en la vista del proyecto. A la mano derecha de la vista de proyecto, haz clic en el botón "Etiquetas" para entrar en el editor de etiquetas. Haz clic en "Añadir etiqueta a X objeto" [X es el número de objetos seleccionados] y escribe un nombre para la etiqueta. Un punto aparecerá en la barra de etiquetas y también al lado del título (o en el previsto en la vista de galería). Usando el menú contextual, puedes cambiar o configurar el color de la etiqueta.


## Exportación de fotos

Es posible exportar imágenes individuales, objetos, (con o sin metadatos y anotaciones) y selecciones de imágenes en diferentes formatos. Haz clic derecho en un objeto en la vista de proyecto y selecciona "Exportar objeto" del menú contextual. En el submenú, podrás seleccionar JSON-LD o PDF (y dentro de PDF, puedes seleccionar orientación vertical o horizontal.)  Si exportas en formato .json, sólo exportarás los metadatos y notas asociados con la(s) imágen(es) seleccionadas. Para exportar la imágen con los metadatos y notas, habrá que seleccionar PDF.

Exportar por esta ruta es parecida a "Imprimir" (Archivo>Imprimir) en formato PDF. Los parámetros para imágenes exportadas en PDF se encuentran en Preferencias. Puedes elegir a incluir o no fotos, metadatos, y notas, además de consideraciones de formato (optimizar tamaño y calidad de foto, incluir únicamente fotos con notas, y permitir el contenido de utilizar más de una página).

[Imagen: Opciones de imprimir en Preferencias]

Para exportar una selección, busca el nombre de la selección en el panel de fotos debajo de la plantilla de metadatos. Haz clic derecho (Control+clic en Mac) en su nombre en la lista y elige "Exportar selección" del menú contextual. Se exportará la selección en formato .jpg, sin metadatos. 

## Instalación de programas adicionales (plugins)

Plugins o programas adicionales son extensiones que puedes instalar para facilitar la importación y exportación de imágenes y metadatos. Los plugins oficiales residen en el [repositorio de Github](https://github.com/tropy) de Tropy. También, es posible encontrarlos a través de la página web de Tropy, al fondo de la página principal. Para instalar uno, navega al repositorio y descarga el plugin deseado. Existen plugins para integración con una instalación de Omeka S, exportación de objetos para Zotero (CSL), y exportación en formato .zip y .csv. Adicionalmente es posible importar archivos .csv y manifestos IIIF.

## Caso de uso: Integración con Zotero

En algunos casos, podría ser útil convertir metadatos grabados en Tropy a una referencia en Zotero. Este puede ayudar en el proceso de organizar las fuentes y conectarlos con el proceso de escribir sobre ellas. Antes de comenzar, vale la pena preguntar si necesitar importar de Tropy a [Zotero](https://www.zotero.org/). Si tu proyecto cuenta con documentos o manuscritos de archivo con una estructura de metadatos similar a un elemento de Zotero, o si tu proyecto contiene una serie de objetos con nombre similares que citas seguidamente (boletines, periódicos, etc), importar desde Tropy a Zotero puede ser útil. Los expedientes de Sección Civil-Esclavos podrían ser convertidos, pues consisten en varias páginas y podrán ser citadas continuamente dentro de un manuscrito. Transfiriendo los metadatos de Tropy a un elemento de Zotero puede ahorrar tiempo en este caso. En otros casos, podría ser más fácil trabajar directamente con la fuente en Zotero (si es un objeto en PDF, puedes utilizar el lector de PDF de Zotero) o crear una referencia manualmente en Zotero para citar en trabajos. A continuación, se detalla cómo importar los metadatos elaborados en Tropy de un expediente de la Sección Civil-Esclavos de la ANHV a Zotero.

### Instalar el plugin CSL

1. Descarga el último lanzamiento del plugin [repositorio de Github](https://github.com/tropy/tropy-plugin-csl), bajo 'Releases' [Lanzamientos] ('tropy-plugin-csl-vx.x.x.zip').

2. En tu instalación de Tropy, en la ventana Preferencias > Plugins, selecciona "Instalar Plugin."

3. Selecciona el archivo .zip descargado del repositorio y después selecciona "Activar" en la ventana de Preferencias cuando aparezca. 

### ¿Qué tipo de elemento quieres importar en Zotero?

1.  Abre tu instalación de Zotero, y crea un elemento de muestra que refleja el objeto que quieres importar de Tropy. Por ejemplo, puedes hacer lo siguiente Archivo>Nuevo elemento>'Libro' o 'Caso' con el fin de crear un elemento parecido a un tomo de expedientes de "Sección Civil-Esclavos" de la ANHV.

2.  En el elemento de muestra que has creado, rellena cualquier valor (por ejemplo, 'x') para las propiedades que quieres importar desde tus fuentes en Tropy. Estas propiedades deberían ser los que serán más importante para la construcción de tus referencias. (Título, Fecha, Volumen, etc.)

3.  Haz clic derecho en el elemento de muestra y selecciona 'Exportar elemento...' del menú contextual y exportarlo en formato .json  [CSL JSON].

4.  Abre el archivo .json exportado [se abrirá en el navegador web u otro aplicación por defecto] y toma nota de [los términos CSL usados](https://docs.citationstyles.org/en/stable/specification.html#appendix-iii-types) [en ingles] para cada campo que fue rellenado anteriormente...utilizarás estos términos en el paso 3d. Sólo las propiedades con valores en sus campos respectivos aparecerán en el archivo .json.

### Crear una plantilla personalizada en Tropy para importar objetos a Zotero

1.  En tu instalación de Tropy, bajo el menu Archivo>Preferencias>Plantillas, selecciona la plantilla usada para los objetos que se importarán a Zotero. 

2.  Crea una copia de esta plantilla de metadatos.

3.  Renombra la plantilla para distinguirla en el menú desplegable. (Por ejemplo: agrega 'Zotero' al nombre original de la plantilla.)

4.  Re-etiqueta los rótulos de cada propiedad en la nueva plantilla usando los términos de CSL que aparecieron en el archivo .json del elemento de muestra  copiado en paso 2d, en letra minúscula, con atención a los guiones (Figura 7).
	* Para importar a Zotero con éxito, tu plantilla debe incluir una propiedad de metadatos etiquetada 'type' con un elemento válido de Zotero como 'book', report', or 'article-journal' en el campo de metadatos (véase: [CSL types](https://docs.citationstyles.org/en/stable/specification.html#appendix-iii-types)). Puedes rellenar este campo para cada objeto que pretendes importar o ponerle como "Valor por defecto" para esta propiedad en el editor de plantillas.
	* No se importarán todos los metadatos de Tropy a Zotero en el mismo formato: por ejemplo, valores de fechas o separación de apellidos y nombres. Para importar una fecha, se recomienda usar el término CSL  'issued.'
	* Si cambias la lengua local en Tropy, necesitarás re-etiquetar tu plantilla para importación a Zotero de las etiquetas por defecto a las etiquetas CSL [en inglés]
	* Hasta el momento, no hay ninguna forma de transferir el texto del campo de notas de Tropy a Zotero. Una solución temporal sería agregar una propiedad de metadatos a la plantilla de exportación y etiquetarla con el término CSL 'note', y entonces copiar y pegar las notas en ese campo. Las notas aparecerán en Zotero en el campo 'Extra' incluído en todos los elementos.

{% include figure.html filename="es-or-gestionar-fuentes-primarias-digitales-con-tropy-07.png" alt="Dos ventanas: uno de Firefox mostrando los componentes de un archivo CSL JSON exportado de Zotero, y el otro del editor de plantilla de Tropy, mostrando los parámetros de diferentes propiedades de metadatos" caption="Figura 7. Usan los términos encontrados en el archivo de CSL JSON para construir una plantilla para exportar a Zotero" %}

5.  Aplicar la nueva plantilla a los objetos que deseas importar a Zotero
	* Poco debería cambiar en términos de los valores porque efectivamente estás mapeando nuevas etiquetas encima de las propiedades de metadatos pre-existentes.

### Exportar objeto(s) de Tropy como archivo CSL JSON

1.  En Archivo>Preferencias bajo Plugins, selecciona CSL y luego selecciona Parámetros.

2.  Agrega una nueva instancia del plugin y ponerle un nombre para distinguirla dentro del menú de contexto.

3.  Selecciona la plantilla que acabas de crear.
	* Toma en cuenta que puedes crear múltiples plantillas y opciones de exportar para diferentes elementos de Zotero

4.  Regresa a la vista de proyecto y haz clic derecho en el objeto u objetos que quieres exportar como archivo .json.

5.  Selecciona 'Exportar objeto>[nombre de la instancia del plugin]

6.  Ponerle nombre al archivo .json y guárdalo. Si piensas en crear una nueva colección dentro de Zotero, puedes darle el nombre de la nueva colección, y al importar, se creará una nueva colección con el nombre del archivo.

### Importar a Zotero

1.  En tu instalación de Zotero, selecciona Archivo>Importar... y escoge 'Un archivo'

2.  Selecciona el archivo .json exportado, y después haz clic en Continuar en el cuadro de diálogo de importación (escoge si quieres crear una nueva colección)

3.  Haz clic en 'Done' cuando la importación termine, y revisa para asegurar que los nuevos elementos importados llevan los campos de metadatos deseados (si no, repasa de nuevo el paso 4d)

4.  Ahora puedes manejar y citar estas referencias a través de tu instalación de Zotero.
