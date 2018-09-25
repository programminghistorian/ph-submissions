---
title: Fichas de lectura HTML en Zotero
authors:
- Carlos Manuel Varón Castañeda
date: 2018-08-03
editors: 
- Maria José Afanador-Llach
reviewers: 
- José Antonio Motilla
- 
review-ticket:
layout: lesson 
difficulty: 1
activity: Preservar
topics: 
abstract: "Esta lección instruye respecto del uso de fichas de lectura en lenguaje de etiquetado HTML y su integración en los registros de la base de datos del gestor bibliográfico Zotero."
---


## Introducción

Los gestores bibliográficos son herramientas cada vez más necesarias en el quehacer académico, por cuanto la organización rigurosa de las fuentes consultadas en una investigación es necesaria para que esta sea provechosa. Pese a ello, solemos recurrir a tomar apuntes sobre lo que leemos en medios físicos o digitales sin atender a ningún orden. Esta estrategia, si bien válida y muy común, acarrea dificultades. Dado que tomamos notas en múltiples medios y formatos, perdemos el control respecto de la información que hemos recopilado: las notas escritas se traspapelan; los apuntes en archivos de formato propietario como ".doc" pierden vigencia; y la multiplicidad de archivos y carpetas genera problemas para encontrarlos, entre otros desafíos.

En lo que atañe a las fuentes documentales, los gestores bibliográficos —“programas informáticos que permiten guardar bases de datos de fuentes bibliográficas, hemerográficas o audiovisuales [p. ej. Refworks, Endnote, Zotero, Mendeley]” (Varón Castañeda 2017, 9)— han contribuido a facilitar la labor que mencionamos antes: son aplicaciones fáciles de utilizar que incorporan las funciones de almacenamiento, gestión y exportación de referencias. Algunas, incluso, disponen de componentes sociales para compartir colecciones de elementos. Visto lo anterior, proponemos en este tutorial una estrategia para realizar dos tareas: de un lado, construir fichas de lectura mediante lenguaje HTML; y de otro, aprovechar las capacidades de organización de un gestor bibliográfico gratuito ―Zotero― para organizarlas con eficiencia.

Al finalizar esta lección, serás capaz de:

* Crear un formato de ficha de lectura mediante el lenguaje de etiquetado HTML.
* Incorporar una ficha de lectura en un registro de la base de datos del gestor bibliográfico Zotero.

### ¿Qué son las fichas de lectura?

Es muy probable que hayas utilizado fichas de lectura, aun sin saberlo. En términos concretos, una ficha de lectura es una herramienta que permite recopilar información sobre un documento leído, cualquiera que sea su naturaleza (Universidad Nacional de Colombia, 2013, 1; González Pinzón, 2009, 9). Además de constituir una estrategia de organización de información útil para la vida académica, permite hacer una primera aproximación a lo que se denomina *lectura crítica* de las fuentes: esto es, evaluar la información para que esta sea realmente útil en el trabajo a realizar. 

### Nuevos usos de las fichas de lectura: los gestores bibliográficos y HTML

En un [trabajo previo](https://doi.org/10.25012/isbn.9789585623309) nos cuestionábamos respecto de la posibilidad de hacer compatible la elaboración de fichas de lectura con el uso de gestores bibliográficos. A este respecto, entre las funciones que ostentan varios gestores se encuentra la de asociar archivos a los registros que componen las bases de datos bibliográficas. Dicho de otro modo, si, por ejemplo, tenemos en la colección del gestor la referencia de un libro, podemos “vincular” a esta última el archivo PDF del mismo. En este tutorial mostraremos cómo aprovechar esta característica para incorporar fichas de lectura HTML en cualquier referencia de una colección de Zotero.

### Para esta lección necesitarás:

* Un programa de edición de texto plano: por defecto, los sistemas operativos Mac OS X, Windows y Linux incluyen uno (Text Edit, Bloc de Notas y Gedit, respectivamente). Sin embargo, sugerimos emplear uno con más funcionalidades para trabajar con código HTML; emplearemos [Sublime Text](https://www.sublimetext.com/) para los ejemplos de esta lección.
* Conocimientos básicos en HTML: recomendamos consultar la lección [“Para entender páginas Web y HTML”](ver-archivos-html) si no estás familiarizado con este lenguaje de etiquetado. 
* [Zotero](https://www.zotero.org/): es un gestor bibliográfico de uso gratuito, creado por el Roy Rosenzweig Center for History and New Media, disponible para los sistemas operativos Mac OS X, Windows y Linux. 
* [Zotero Connector](https://www.zotero.org/download/): este es un complemento para el navegador que permite importar referencias de la web a la base de datos de Zotero. Funciona con los navegadores Google Chrome, Mozilla Firefox y Apple Safari.

> Dado que el foco de atención de esta lección se encuentra en la elaboración de fichas de lectura, no hablaremos en detalle de la configuración y creación de registros bibliográficos en Zotero. No obstante, si desconoces el funcionamiento de esta aplicación o requieres información adicional sobre ella, puedes acudir a la documentación oficial disponible en su [página oficial](https://www.zotero.org/support/es/start).

## Elaboración de una plantilla de ficha de lectura en código HTML

### Composición en el editor

1. Abre el editor de texto. Por defecto, la aplicación iniciará un archivo nuevo. 

{% include figure.html filename="/images/fichas-zotero/figura-1.png" caption="Figura 1. Ventana principal del editor de texto. Fuente: elaboración propia." %}

2. Ve a “File - Save As…” En el cuadro de diálogo que se desplegará, asigna un nombre al archivo y selecciona “HTML” en la lista desplegable “Tipo”. No olvides añadir la extensión “.html” al final del nombre que elijas (figura 2). Asegúrate de verificar en el editor de texto que el archivo se guarde con la codificación UTF-8: esto permitirá que todos los elementos tipográficos (tales como las tildes en español) se muestren correctamente.

{% include figure.html filename="/images/fichas-zotero/figura-2.png" caption="Figura 2. Guardado del archivo de la plantilla para la ficha de lectura. Fuente: elaboración propia." %}

3. Llegado este punto, dispones de un archivo que servirá como espacio para construir una plantilla mediante la cual crearás tus fichas de lectura. Ahora, copia y pega el siguiente código en el editor:

   ```html
   <table width="800" border="1">
     <tbody>
       <tr>
         <th scope="row"><p align="left">Tipo de material</p></th>
         <td></td>
       </tr>
       <tr>
         <th scope="row"><p align="left">Referencia bibliográfica</p></th>
         <td></td>
       </tr>
       <tr>
         <th scope="row"><p align="left">Palabras clave</p></th>
         <td></td>
       </tr>
       <tr>
         <th scope="row"><p align="left">Planteamiento global (resumen)</p></th>
         <td></td>
       </tr>
       <tr>
         <th scope="row"><p align="left">Propósito del autor</p></th>
         <td></td>
       </tr>
       <tr>
         <th scope="row"><p align="left">Aportes que hace el texto</p></th>
         <td></td>
       </tr>
       <tr>
         <th scope="row"><p align="left">Referencias a otros autores o textos</p></th>
         <td></td>
       </tr>
         </tbody>
   </table>
   ```

4. Guarda los cambios (“File - Save”).

5. El código anterior creará una tabla con 7 filas y 2 columnas: allí podrás consignar la información básica sobre cualquier material. Si pruebas a abrir el archivo con un navegador, verás una tabla como la que se muestra en la figura 3.

   {% include figure.html filename="/images/fichas-zotero/figura-3.png" caption="Modelo de ficha de lectura mostrado en un navegador. Fuente: elaboración propia." %}

   > El modelo de ficha anterior es una adaptación de la propuesta de Blanca Yaneth González (2009, 25), publicada por la Universidad Sergio Arboleda (Bogotá, Colombia). Desde luego, puedes añadir, sustraer o modificar los campos que consideres oportunos.


Ahora cuentas con un modelo de ficha de lectura en HTML; puedes usarlo a modo de plantilla para consignar información sobre materiales que hayas leído y consideres importantes para tu trabajo académico. A continuación, mostraremos cómo incorporar una ficha a un registro bibliográfico recuperado mediante Zotero.  

## Integración de la ficha en Zotero

Existen dos maneras de integrar fichas como la que produjimos en los registros bibliográficos de Zotero: como un archivo adjunto, o mediante la función “Notas” de la aplicación. Explicaremos ambas, a la espera de que utilices la que encuentres más cómoda y conveniente. Desde luego, la incorporación requiere disponer de, cuando menos, una referencia en tu base de datos de Zotero; recuperaremos una de la base de datos Worldcat a manera de ejemplo.

1. Abre el navegador de tu preferencia (también debes tener abierto Zotero) y dirígete a [Worldcat](https://www.worldcat.org/) (figura 4).

   {% include figure.html filename="/images/fichas-zotero/figura-4.png" caption="Figura 4. Portal de la base de datos WorldCat. Fuente: elaboración propia." %}

2. Busca en esta base de datos la información bibliográfica de una obra de tu interés. Utilizamos un trabajo propio como ejemplo (figura 5).

   {% include figure.html filename="/images/fichas-zotero/figura-5.png" caption="Figura 5. Resultado de búsqueda en WorldCat. Fuente: elaboración propia." %}

3. Haz clic en el registro para desplegar su información e impórtalo en Zotero mediante el botón de Zotero Connector, ubicado en la esquina superior derecha de la ventana del navegador (figura 6)[^1].

   {% include figure.html filename="/images/fichas-zotero/figura-6.png" caption="Figura 6. Información de un registro en WorldCat. Fuente: elaboración propia." %}

4. El registro de la referencia recuperada deberá aparecer en la ventana principal de Zotero (figura 7).

   {% include figure.html filename="/images/fichas-zotero/figura-7.png" caption="Figura 7. Referencia importada en Zotero. Fuente: elaboración propia." %}

   Una vez importado el registro procederemos a incorporar la ficha de lectura en el mismo, como se mostrará a continuación.

### Integración como archivo independiente HTML asociado a un registro existente

1. Abre con Sublime Text el archivo de modelo de ficha de lectura que creaste anteriormente. Ahora, consigna la información de la referencia que hayas importado a Zotero en las etiquetas HTML que corresponden a las celdas vacías de la tabla (marcadas como "<td></td>"), así:

```html
   <table width="800" border="1">
     <tbody>
       <tr>
         <th scope="row"><p align="left">Tipo de material</p></th>
         <td>Libro</td>
       </tr>
       <tr>
         <th scope="row"><p align="left">Referencia bibliográfica</p></th>
         <td>Varón Castañeda, C. M. (2017). <em>Gestores bibliográficos: recomendaciones para su aprovechamiento en la academia</em>. Medellín: Journals & Authors.</td>
       </tr>
       <tr>
         <th scope="row"><p align="left">Palabras clave</p></th>
         <td>alfabetización informacional, gestores bibliográficos, educación superior, investigación</td>
       </tr>
       <tr>
         <th scope="row"><p align="left">Planteamiento global (resumen)</p></th>
         <td>Esta es una cartilla dirigida a estudiantes, profesores e investigadores que muestra algunos beneficios del uso de gestores bibliográficos en la vida académica.</td>
       </tr>
       <tr>
         <th scope="row"><p align="left">Propósito del autor</p></th>
         <td>Sensibilizar a actores de la academia respecto de la importancia de los gestores bibliográficos como herramientas de investigación.</td>
       </tr>
       <tr>
         <th scope="row"><p align="left">Aportes que hace el texto</p></th>
         <td>No se trata de un manual, puesto que no provee instrucciones para usar las herramientas; en lugar de eso, la fortaleza de este trabajo radica en que muestra a sus lectores posibles aplicaciones de las mismas, a la espera de que sean ellos quienes las exploren para enriquecer su labor académica.</td>
       </tr>
       <tr>
         <th scope="row"><p align="left">Referencias a otros autores o textos</p></th>
         <td>Cordón-García, J., Martín Rodero, H., & Alonso-Arévalo, J. (2009). Gestores de referencias de última generación: análisis comparativo de RefWorks, EndNote Web y Zotero. <em>El profesional de la información, 18</em>(4), 445–454. https://doi.org/10.3145/epi.2009.jul.14</td>
       </tr>
         </tbody>
   </table>
   ```

Luego, Ve a “File - Save As…” y guarda el archivo con otro nombre.

2. Ahora, arrastra el archivo al registro de Zotero con el ratón desde el lugar de tu equipo de cómputo donde lo hayas guardado. El gestor bibliográfico creará una copia del archivo que arrastraste en su base de datos y lo vinculará al registro respectivo, como se muestra en la figura 8.

   {% include figure.html filename="/images/fichas-zotero/figura-8.png" caption="Figura 8. Archivo de ficha de lectura vinculado al registro de Zotero. Fuente: elaboración propia." %}

3. Dispones ahora de una copia de la ficha de lectura, a la que podrás acceder desde el registro bibliográfico de Zotero. En este punto puedes borrar el archivo de la ficha que arrastraste originalmente, por cuanto ya se encuentra almacenado en el gestor. 

### Integración como “nota” en un registro existente

Zotero permite crear “notas” asociadas a los registros de su base de datos con un formato propietario, que puede ser exportado como un archivo HTML. A continuación mostraremos cómo hacerlo.

1. En Zotero, haz clic en el registro al cual quieres añadir la nota, ve a la pestaña “Notas” y haz clic en “Añadir nota” (figura 9).

   {% include figure.html filename="/images/fichas-zotero/figura-9.PNG" caption="Figura 9. Añadir una nota a un registro de Zotero. Fuente: elaboración propia." %}

2. El programa mostrará un cuadro para editar el texto de la nota. Sitúa el cursor sobre este espacio, haz clic derecho y selecciona “Código fuente” (figura 10).

   {% include figure.html filename="/images/fichas-zotero/figura-10.PNG" caption="Figura 10. Edición de código fuente de nota en Zotero. Fuente: elaboración propia." %}

3. En la ventana que se desplegará, escribe el siguiente código para insertar una línea en blanco[^2]:

   ```html
   <p></p>
   ```

4. Debajo de lo que escribiste, pega el código del archivo que contiene la ficha de lectura y haz clic en “Ok”. El resultado debería asemejarse a lo que se muestra en la figura 11 cuando completes los campos de la tabla.

   {% include figure.html filename="/images/fichas-zotero/figura-11.PNG" caption="Figura 11. Ficha de lectura añadida a una \"nota\" en Zotero. Fuente: elaboración propia." %}


Con lo anterior tendrás la ficha de lectura dentro de la nota, aunque almacenada en el formato propietario de Zotero. Si requirieras exportarla como archivo HTML, puedes hacer lo siguiente:

1. Ubica el cursor sobre el icono de la nota que creaste, haz clic derecho y elige la opción “Producir un informe a partir del ítem seleccionado…” (figura 12). 

   {% include figure.html filename="/images/fichas-zotero/figura-12.PNG" caption="Figura 12. Exportación de \"nota\" como archivo HTML mediante Zotero. Fuente: elaboración propia." %}

2. Acto seguido, el programa abrirá una ventana nueva en la que se mostrará la ficha que creaste. Para exportarla, Dirígete a “Archivo - Guardar”, asígnale un nombre y guárdala en la ubicación que requieras (si lo necesitas, también puedes imprimirla desde el menú “Archivo”), como se muestra en la figura 13.

   {% include figure.html filename="/images/fichas-zotero/figura-13.PNG" caption="Figura 13. Menú para guardado de archivo HTML en Zotero. Fuente: elaboración propia." %}

3. Ahora podrás manipular el archivo HTML creado por Zotero como lo tengas a bien para modificar la ficha, subirla a la nube, compartirla, etc.

## Para finalizar

Hemos expuesto aquí una estrategia que encontramos de utilidad para adelantar ejercicios básicos de investigación documental con la ayuda de un gestor bibliográfico. No obstante, es importante resaltar que, si bien la aplicación informática agiliza el proceso de obtención, organización y exportación de fuentes, ello no exime al investigador de evaluar la información que llega a sus manos en términos de calidad, necesariedad y pertinencia. En este sentido, sea esta en realidad una invitación no solo a usar las herramientas digitales que mostramos de forma rigurosa, sino a fortalecer habilidades de lectura crítica con estas estrategias, y potenciarlas a través de la capacidad de organización de la máquina.

## Referencias

- González Pinzón, Blanca Yaneth. 2009. *¿Cómo elaborar una ficha de lectura?* Bogotá, Colombia: Universidad Sergio Arboleda.

- Universidad Nacional de Colombia. 2013. “Recomendaciones para elaborar una ficha de lectura”. [http://expresatebien.unal.edu.co/uploads/media/EBCM_ADC_T2__S19_Fichadelectura.pdf](http://expresatebien.unal.edu.co/uploads/media/EBCM_ADC_T2__S19_Fichadelectura.pdf).

- Varón Castañeda, Carlos Manuel. 2017. *Gestores bibliográficos: recomendaciones para su aprovechamiento en la academia*. Medellín, Colombia: Journals & Authors. doi: [https://doi.org/10.25012/isbn.9789585623309](https://doi.org/10.25012/isbn.9789585623309).

## Notas

[^1]: Si estás usando el navegador Apple Safari, el botón de Zotero Connector aparecerá a la izquierda de la barra de direcciones.

[^2]: A simple vista, esta labor puede parecer innecesaria. No obstante, el código de la tabla no se cargará correctamente si no se hace esto.



## Acerca del autor

Carlos Manuel Varón Castañeda es lingüista de la Universidad Nacional de Colombia, especialista en edición de publicaciones de la Universidad de Antioquia y estudiante de la Maestría en Humanidades Digitales de la Universidad de los Andes (Bogotá, Colombia). Sus intereses académicos derivan en torno de la lingüística computacional aplicada, la edición científica y la alfabetización informacional, esta última vinculada de forma estrecha con el contenido de esta lección y otros materiales publicados por el autor en años recientes.
