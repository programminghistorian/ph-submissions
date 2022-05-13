---
title: Análisis de corpus con CorTexT Manager
collection: lessons
layout: lesson
slug: analisis-de-corpus-con-cortext-manager
date:
authors:
- Yuri Saldarriaga
- Matthieu de Castelbajac
reviewers:
-
editors:
- Riva Quiroga
review-ticket:
difficulty:
activity:
topics:
abstract:
doi:
---
# Contenidos
{% include toc.html %}
## Introducción

Con la digitalización de grandes corpus, los métodos de análisis textual se han vuelto indispensables para las ciencias sociales y las humanidades. Existen múltiples plataformas en línea que permiten analizar dichos corpus [Análisis de corpus con AntConc](/es/lecciones/analisis-de-corpus-con-antconc). Sin embargo, las plataformas de libre acceso que no requieren competencias en programación, suelen presentar una oferta de métodos bastante limitada, y a menudos son diseñadas para corpus de textos en inglés. En cambio, [CorText Manager](https://perma.cc/QR6Y-NGER)[^1], el programa del cual hablaremos en esta lección, subsana ambas lagunas: ofrece una amplia gama de herramientas de análisis, y funciona con múltiples idiomas, incluyendo el español.

### Objetivos de aprendizaje
- Adquirir competencias básicas para realizar análisis de contenido utilizando el programa CorText Manager.
- Aprender a realizar análisis comparativos relacionados con argumentos de grupos sociales con objetivos opuestos.

### Requisitos previos
Para este tutorial no necesitas ningún conocimiento previo en programación. Únicamente, necesitas [abrir una cuenta con CorText Manager](https://managerv2.Cortext.net/login).

## El Software y los datos que utilizaremos

CorText es una plataforma online de acceso libre creado por el Institute For Research and Innovation in Society (IFRIS). Permite “extraer, analizar y visualizar conocimiento en bases de datos textuales más o menos calibradas de muchos tipos: desde bases de datos científicas y de patentes clásicas, conjuntos de datos de medios hasta rastros digitalizados más actualizados de la web y redes sociales” [^2]. Recientemente, ha sido utilizada para analizar todos los “discursos de la nación” pronunciados por los presidentes de Estados Unidos desde 1790[^2], un vasto corpus de sermones ingleses publicados entre 1660 y 1782[^3], y el contenido de 323 acuerdos de paz firmados entre 1990 y 2018[^4].

### Preparación de los documentos jurídicos objeto de análisis

CorText es ideal para estudiar corpus grandes. Pero para este tutorial, utilizamos un corpus más reducido de dieciséis demandas presentadas ante la Corte Constitucional de Colombia por parte de movimientos sociales a favor y en contra del derecho al aborto, desde 1994 hasta 2020. Las demandas, reflejan los argumentos utilizados por cada uno de esos movimientos, en el intento de convencer a la Corte Constitucional de sus posiciones.

Los documentos fueron obtenidos en formato PDF en el archivo de la Corte Constitucional. Algunos de ellos estaban en formato editable y otros no. Por esa razón, llevamos a cabo un proceso de conversión a formato editable, corregimos los errores gramaticales existentes y eliminamos los anexos de las demandas. El propósito de ese trabajo previo fue estandarizar los documentos para, luego, someterlos al programa de análisis de texto, Cortext. Una vez fueron estandarizados, se convirtieron en formato *txt*.

Los nombres de cada archivo en formato *txt* será la forma de identificar el documento durante los análisis. Por ese motivo, es importante que identifiques cada uno de tus archivos con un nombre corto que te permita identificarlo con claridad durante el análisis. En nuestro caso, como queríamos hacer análisis para cada grupo de demandas por separado, a favor y en contra del aborto, y también el análisis conjunto de todas las demandas, guardamos los archivos en nuestro ordenador en tres carpetas: una para las demandas pro-elección (primera carpeta), otra para las demandas pro-vida (segunda carpeta) y otra, para todas las demandas (tercera carpeta).

## Análisis de datos

A través de un análisis comparativo de contenido, estudiamos las convergencias y divergencias de los argumentos utilizados por ambas movilizaciones. En el análisis, aplicamos técnicas de lectura a distancia en cinco fases: (i) identificación de co-ocurrencias, (ii) indexación del corpus, (iii) evoluciones temporales, (iv) mapas de redes y de calor, y (v) árboles de palabras. En esta sección, a través de esas cinco fases, te mostraremos cómo realizar esos análisis en Cortext.

Lo primero que debes hacer es iniciar sesión en tu cuenta de Cortext y crear un nuevo proyecto, asignándole un nombre.
Una vez creado el proyecto, la plataforma te permitirá cargar los documentos al programa. Para hacer esto, el sistema te da la opción de subir los datos y crear un corpus. Por ejemplo, para nuestro primer análisis, utilizamos la tercera carpeta antes mencionada, esto es, aquella que contenía todas las demandas. Por esa razón, cargamos esa carpeta como un nuevo corpus a Cortext.

Ojo que el sistema solamente acepta carpetas comprimidas cuando se trata de varios documentos. En consecuencia, antes de intentar subir los documentos, debes comprimir la carpeta con la información. Una vez comprimida y a través de la función de cargar un nuevo corpus, podrás iniciar la subida de la información.

Luego de subir la carpeta comprimida, deberás preparar los documentos en el sistema para el análisis. Con ese fin, el sistema te pedirá que le indiques qué tipo de información estás ingresando y en cual formato. En nuestro caso, nuestros datos eran un *dataset* en formato *txt* y eso fue lo que incluimos.

Cuando tienes listo tu corpus, podrás iniciar los análisis. Como te mencionamos antes, en Cortext no tienes que escribir código. El sistema es intuitivo y te irá mostrando opciones que tendrás que escoger para establecer los parámetros con los cuales quieres que se procese tu información.

### Co-ocurrencias identificando multi-términos

Una de las formas tradicionales de hacer análisis de co-ocurrencias es con la identificación de palabras. Sin embargo, Cortext te permite ir un paso más allá y realizar dichos análisis con frases. Esas frases, se denominan multi-términos o n-gramas y consisten en una secuencia de palabras que el programa identifica, a partir de propiedades estadísticas que tendrás que indicarle. En nuestro caso, el primer análisis es uno sencillo de co-ocurrencias de multi-términos. El enfoque de co-ocurrencias induce "categorías basándose en la apariencia conjunta de los términos sobre una unidad de texto en particular" [^1].

Para hacer este tipo de procesos, tendrás que extraer los multi-términos de tus documentos. Para esto, dentro de tu proyecto, deberás iniciar un análisis en la función de *start script*. Como verás, esa función está claramente señalada en color, en esta versión en color verde, en la parte superior de la página principal de tu proyecto. De hecho, todos los análisis que realices comenzarán con esa función del sistema. Cuando inicias el proceso, el programa te despliega diferentes funciones. Con el objetivo de realizar la identificación de co-ocurrencias, lo primero que debes hacer es extraer la lista de los multi-términos. La función para hacerlo, la encuentras en la función denominada *Text*” y, luego, en *Terms extraction*.

{% include figure.html filename="analisis-de-corpus-con-cortext-manager1.png" caption="Figura 1. En esta figura puedes ver las opciones de la función denominada Text" %}

Una vez seleccionas la función de extraer los términos, podrás seleccionar tu corpus (el que cargaste al sistema en primer lugar). Acto seguido, deberás decirle al programa bajo cuáles parámetros deseas que se realice la extracción de los términos. El sistema te irá mostrando brevemente a qué se refiere cada casilla, solamente ubicando el cursor encima de cada opción. En nuestro caso, necesitábamos extraer la información directamente del texto. Por esa razón, seleccionamos *text*. Además, puedes escoger el mínimo de frecuencia de las palabras, el número de términos a extraer, el idioma, la posibilidad de identificar palabras individuales (llamadas monogramas), entre otros criterios.

Sobre la creación de la lista de términos, debes tener especial cuidado en seleccionar el idioma de los documentos que estás analizando. En el caso bajo estudio, nosotros seleccionamos español, porque todos nuestros documentos estaban escritos en español. Esto le permite al sistema realizar de una mejor manera la identificación de los términos. Sin embargo, en Cortext también puedes trabajar documentos en inglés o francés. Aunque el sistema te da la opción de seleccionar otros idiomas (holandés, ruso, etc.), te sugerimos preguntar directamente a los creadores sobre la confiabilidad de esos otros idiomas.
Una vez corrido el programa, el resultado será un listado de los multi-términos más frecuentes. Para visualizar la información, deberás seleccionar la figura con forma de ojo.

Allí, podrás observar una tabla que te arroja los términos que más veces aparecen en el análisis de todos los datos, según los parámetros que le indicaste al programa. Ese listado en forma de tabla se puede editar. Por ejemplo, añadiendo la letra “w” a la última columna, puedes ignorar los n-gramas que no quieres que aparezcan en tus análisis. Si haces alguna modificación, debes cambiarle el nombre a la tabla y guardarla como una tabla nueva. En nuestro caso, el nombre que le asignamos a nuestra tabla editada fue *Edited_extratedterms*. En la Figura 2, puedes ver el ejemplo de nuestra tabla, con la inclusión de la letra “w” para ignorar algunos términos.

{% include figure.html filename="analisis-de-corpus-con-cortext-manager2.png" caption="Figura 2. En esta figura puedes ver la tabla que creamos en Cortext para identificar los multi-términos con los cuales vamos a correr los análisis" %}

Una vez tienes la tabla editada y guardada dentro del programa, debes indexarla al corpus de tus documentos. Esto es necesario para que, en adelante, los análisis que hagas en tu proyecto tengan en cuenta esta información que modificaste. Para indexar la tabla al corpus, debes iniciar una nueva corrida del modelo. Para eso, debes ir a *start script* nuevamente y seleccionar la función de *Corpus Terms Indexer*. Allí, debes seleccionar los parámetros que consideres adecuados según tu caso de estudio. En el primer campo, nosotros seleccionamos el parámetro de *text* y, en el segundo, seleccionamos nuestra lista editada. Además, le asignamos un nuevo nombre a este corpus indexado.

Con el fin de tener esos escenarios para cada uno de nuestros grupos de datos (demandas a favor, demandas en contra y total de demandas), repetimos todo lo mencionado hasta este momento para los datos pro-vida y pro-elección: creamos un nuevo proyecto, subimos la carpeta Zip con los datos, sacamos los co-ocurrencias de los multi-términos, etc.

### Indexar tu corpus

Ahora, cuando tienes el listado de multi-términos indexado a tu corpus, puedes elaborar los mapas de redes y de calor. Sin embargo, es necesario que realices un paso adicional antes de correr el modelo para crear los mapas. Debes indexar en tu corpus los años de cada uno de los datos. La inclusión de los años será fundamental para hacer tanto los mapas, como los análisis sobre evolución temporal que te explicaremos más adelante. En nuestro caso de estudio, cada data era una demanda judicial presentada por los movimientos pro-vida y pro-elección en Colombia. Para indexar los años a tu corpus, debes seguir el siguiente proceso.
Para comenzar, debes descargar en tu computador una lista con los nombres de cada uno de tus archivos. Esto, lo puedes hacer iniciando un nuevo script con la función List Builder. Esa función, te permite crear una lista con datos de tus documentos, como el nombre del archivo. En cuanto creas tu lista, debes ir al panel principal de tu proyecto y descargarla en tu computador. Cuando la descargas, la podrás modificar e incluirle las fechas a cada uno de los nombres de los archivos. Aunque la podrás abrir y modificar en Microsoft Excel, no te recomendamos hacerlo de esa forma. Esto, porque el programa Microsoft Excel te puede agregar información extra al formato original. Por eso, te recomendamos abrir el archivo que descargaste en Google Sheets y hacer la edición en ese programa.

En la tabla que guardaste en Google Sheets debes agregar una columna para incluir el año en cada una de las filas, las cuales contienen los nombres de los archivos. En nuestro caso, no incluimos en esa columna años, sino números de manera cronológica. Así, el número 1 representaba la demanda más antigua y el número 16 representaba la demanda más reciente. Esto, porque teníamos varias sentencias de un mismo año y, si incluimos en esa columna los años, el programa nos unificaría las demandas por años en los análisis. Entonces, en la nueva columna incluimos números que, de manera interna, sabíamos a cuáles años correspondían. Una vez hicimos los cambios en Google Sheets, guardamos la tabla en Google, la descargamos en nuestro computador y la subimos a Cortext. La forma como puedes subir una lista a Cortext es iniciando un script denominado *Corpus List Indexer*. Mediante esa función, puedes incluir en el corpus nueva información, esta vez, correspondiente a los años. Los parámetros que utilizamos en nuestro caso fueron los siguientes:

```
Field: filename
Define a custom list of entities: false
Add a dictionary of equivalent strings: true
Enter a filename with dictionaries of equivalent forms: /srv/local/documents/4442/44428a5c05640dda03305f374223963f/top1000-list-filenametotal-f-top1000-list-filenametotal-f.tsv
List indexation advanced settings: true
New indexation name (optional): Corpus_editedyearandname
```

### Evoluciones temporales

Aunque los mapas de redes y de calor que analizaremos más adelante te permiten ver las relaciones que existen entre los multi-términos y los documentos, éstos no te permiten ver ninguna evolución temporal. Si deseas hacer ese análisis, debes iniciar un script llamado *Demography*. A través de ese proceso, puedes identificar cuál fue la evolución temporal de los multi-términos más recurrentes.

En nuestro caso, la evolución temporal se la aplicamos solamente a dos de nuestros grupos de datos: los datos correspondientes al movimiento pro-life y los datos correspondientes al movimiento pro-elección. Es decir, no realizamos ese análisis para el grupo de datos que incluía la totalidad de las demandas. La razón por la cual lo hicimos de esa manera era porque nos interesaba ver cómo había sido la evolución de algunos multi-términos en uno y en otro grupo de datos, por separado. Después, durante nuestra investigación, queríamos evidenciar tanto las coincidencias como las diferencias de dichas evoluciones.

En el script *Demography*, utilizamos como variable el corpus con la información de los años que indexaste para este proyecto, según los pasos que te indicamos antes en este tutorial. Las figuras 3 y 4 son ejemplos de la evolución temporal de los multi-términos más frecuentes en cada tipo de demanda (pro-life y pro-elección). En esas figuras, puedes ver que también incluimos manualmente una información, en esta oportunidad, los años de las demandas. Aunque el programa claramente los tiene en cuenta para hacer los análisis temporales, los años solamente aparecen si pones el cursor encima de la línea donde está el año. Teniendo en cuenta que nuestra investigación era escrita, decidimos incluir los años de manera manual para que el lector tuviera la información completa en las figuras.


{% include figure.html filename="analisis-de-corpus-con-cortext-manager3.png" caption="Figura 3. Variaciones temporales de los 20 n-gramas más frecuentes para las demandas pro-elección (1994-2020)" %}

{% include figure.html filename="analisis-de-corpus-con-cortext-manager4.png" caption="Figura 4. Variaciones temporales de los 20 n-gramas más frecuentes para juicios provida (1994-2020)" %}

### Mapas de redes y de calor

Indexada la información de los años en el corpus, puedes hacer los mapas de redes y los mapas de calor. Los mapas los hicimos para nuestros tres grupos de datos: las demandas del movimiento pro-elección, las demandas del movimiento pro-vida y todas las demandas, incluyendo ambos movimientos. Por medio de los mapas, puedes representar visualmente los vínculos entre los datos objeto de análisis. Para esto, debes iniciar el script llamado *Network Mapping* e ingresar como variables cada una de las listas indexadas: por un lado, la lista indexada con las co-ocurrencias de los multi-términos y, por el otro, la lista indexada con los años. Esas serán tus dos variables por relacionar. Por otro lado, los parámetros que escogerás son aquellos que mejor se adapten a tus necesidades. En nuestro caso, seleccionamos un número de nodos de 500 y dejamos la mayoría de los parámetros que tenía el proceso por defecto. En nuestro análisis de caso, después de realizar ese proceso, obtuvimos el siguiente mapa.



{% include figure.html filename="analisis-de-corpus-con-cortext-manager5.png" caption="Figura 5. Mapa de redes de todas las demandas sobre aborto presentadas ante la Corte Constitucional de Colombia entre 1992 and 2020" %}

En el mapa, podrás ver que cada círculo es un multi-término que co-ocurre en los documentos analizados. Además, cada triángulo es uno de los documentos que ingresaste al sistema. Por eso, es posible relacionar los n-gramas con los documentos. En atención a que nosotros no incluimos una variable que nos indicara si la demanda era a favor o en contra del derecho al aborto, ingresamos al gráfico, manualmente, las palabras violetas. Aquello, para identificar si la demanda había sido presentada por el movimiento pro-vida (Against) o por el movimiento pro-elección (In favor). Este mapa de redes te permite ver las principales agrupaciones o burbujas de términos. Como puedes ver en el ejemplo, nosotros encontramos que había al menos cuatro agrupaciones de temas. Así, mientras en la burbuja verde, podíamos encontrar principalmente términos médicos, en la burbuja naranja había más términos relacionados con los derechos de las mujeres. Además, comenzamos a ver que, en el centro del mapa, se mostraban una serie de términos que parecían ser los términos más importantes de la red: los relacionados con el lenguaje de derechos.

Sin embargo, si necesitas hacer un análisis comparativo con poco más detallado, puedes acudir a los mapas de calor. Esos mapas son útiles para establecer cuáles términos son más utilizados por un grupo de actores más que por otro. Para la elaboración del mapa, debes seguir los mismos pasos que seguiste para crear el mapa de redes anteriormente descrito. Sin embargo, en el parámetro *Network Analysis and layout* debes agregar una tercera variable. Esa tercera variable, corresponde con la identificación del grupo que presentó cada una de las demandas y la ingresas al corpus de la misma forma como ingresaste la variable año. Esto es, creando una tabla, editándola en Google Sheets e indexándola al corpus. Para ingresar esa tercera variable en el parámetro *Network Analysis and layout*, debes seleccionar las siguientes opciones:

```
Community detection algorithm: louvain resolution
Historical map: false
Project records onto clusters: true
Modify the name of the projected cluster: ''
Assign a unique cluster to each record (best match): true
Penalize large clusters when computing projections: false
Add information from a 3rd variable to tag clusters or produce a heatmap: true
Choose the new field that should be used: filename_custom_Corpus_editedyearandname_name
Tagging/heatmap Specificity Measure: chi2_dir
Heatmap: true
Value of the field you wish to plot the heatmap of: against
Use a logarithmic scale colormap: false
Manually set a maximal value for your heatmap(s): false
Choose a period length for a dynamic profiling of the projected entity: None
Advanced options if you are tagging clusters: false
Network analysis advanced settings: false
```
Después de correr el modelo, tu mapa de calor deberá lucir como la Figura 6.

{% include figure.html filename="analisis-de-corpus-con-cortext-manager6.png" caption="Figura 6. Mapa de calor del léxico utilizado por los movimientos sociales pro-vida y pro-elección" %}

Este mapa de calor te muestra cómo, en nuestro caso, las demandas pro-vida se concentran en ciertas áreas de la red (color rojo oscuro), mientras que las demandas pro-elección se enfocan en otras (color azul oscuro). Por ejemplo, puedes ver que el término *integridad de la mujer* es más utilizada por los movimientos pro-elección, mientras que el n-grama *niñas con discapacidad* es más usado por el movimiento pro-vida.

### Construcción de árboles de palabras

Ahora, ni con los mapas ni con la evolución temporal de los términos puedes conocer el significado de cada n-grama, según el tipo de documento. Por eso, Cortext te permite extraer la información sobre el contenido del término y las palabras asociadas al mismo. Para esto puedes correr el script denominado *Distant Reading*. A través de ese proceso, puedes extraer una lista palabras que te permite ver la relación con otras palabras. Para correr este script, tu variable será el texto de los documentos y el corpus que utilizarás es aquel que indexaste con los términos con mayores co-ocurrencias. La figura 7 es un ejemplo de cómo lucen estos árboles de palabra en uno de nuestros grupos de datos, aquel que incluye las demandas presentadas por el movimiento pro-elección.

{% include figure.html filename="analisis-de-corpus-con-cortext-manager7.png" caption="Figura 7. Árbol de palabras del término 'derecho de' (derecho de) que se encuentra en las demandas pro-elección" %}

## Conclusiones

A través de Cortex puedes realizar análisis conjuntamente y por separados textos de grupos de actores con intereses opuestos. Sin embargo, esta no es la única funcionalidad del programa. Cortext te ofrece la posibilidad de hacer otros tipos de análisis con información de redes sociales como Tweeter. Además, una de las ventajas de este programa es que existe un foro de preguntas que son contestadas oportunamente por los desarrolladores. Este es el enlace donde puedes acceder a ese foro: [https://docs.cortext.net/forum/](https://perma.cc/P3DH-LJUA). Asimismo, existen videos tutoriales en la página de Cortext que te explicarán de una manera detallada y gráfica algunas de las funcionalidades más importantes del programa. Esos videos tutoriales los puedes encontrar en este enlace: [https://docs.cortext.net/video/](https://perma.cc/FB2D-UEN3). Además, si tu interés es realizar análisis con documentos en español, Cortext es una buena opción. No obstante, también tiene sus limitaciones. Como no necesitas tener conocimientos sobre programación, no necesitas saber ni de Python ni de R, el programa adoptará algunas decisiones por ti. Pero, si lees la documentación del programa [(https://docs.cortext.net/)](https://perma.cc/9AN8-EUHR) y aprendes a seleccionar los parámetros adecuados, las decisiones que toma el programa serán mucho más controladas.

## Recursos adicionales
[Cortext Manager Documentation](https://perma.cc/9AN8-EUHR) (en inglés)  
[Tutoriales videos](https://perma.cc/FB2D-UEN3) (en inglés)  
[Foro de preguntas y respuestas](https://perma.cc/P3DH-LJUA)  

## Notas

[^1]:  CorTexT Team, “CorText digital platform”, [https://www.cortext.net/about-us/](https://perma.cc/4BTK-L9DR)

[^2]: Hoffman, Mark Anthony, Jean-Philippe Cointet, Philipp Brandt, Newton Key, Peter Bearman. "The (Protestant) Bible, the (printed) sermon, and the word (s): The semantic structure of the Conformist and Dissenting Bible, 1660–1780." _Poetics_ 68 (2018): 89-103. [https://doi.org/10.1016/j.poetic.2017.11.002](https://doi.org/10.1016/j.poetic.2017.11.002).

[^3]: Rule, Alix, Jean-Philippe Cointet, and Peter S. Bearman. "Lexical shifts, substantive changes, and continuity in State of the Union discourse, 1790–2014." _Proceedings of the National Academy of Sciences_ 112.35 (2015): 10837-10844. [https://doi.org/10.1073/pnas.1512221112](https://doi.org/10.1073/pnas.1512221112).

[^4]: Puetz, Kyle, Andrew P. Davis, and Alexander B. Kinney. "Meaning structures in the world polity: A semantic network analysis of human rights terminology in the world's peace agreements." Poetics (2021): 101598. [https://doi.org/10.1016/j.poetic.2021.101598](https://doi.org/10.1016/j.poetic.2021.101598).
