---
title: |
  Visualización y animación de tablas históricas con R
collection: lessons
layout: lesson
slug: visualizacion-y-animacion-de-tablas-historicas-con-R
date:
authors:
- Marcelo Raimundo
reviewers:
- Por definir
editor:
- Riva Quiroga
review-ticket:
difficulty:
activity:
topics:
abstract:
doi:
---

## Contenidos
{:.no_toc}

* TOC
{:toc}

# Resumen

Esta lección te mostrará cómo cruzar, graficar y animar un conjunto de datos históricos. Partiendo desde una tabla que dispongas en una hoja de cálculos, podrás importarla a RStudio y así aprender a utilizar funciones básicas que te permitirán transformar y organizar tus datos para presentarlos rápidamente como tablas de contingencia. También sabrás cómo utilizar funciones de nuevas librerías que te permitirán presentar tus datos cruzados en forma gráfica e inclusive llegar a animarlos en perspectiva temporal.  

# Objetivos

Luego de practicar esta lección:


1.  Podrás transformar y organizar tus datos para trabajar con ellos en un entorno *RStudio*.

2.  Sabrás cómo utilizar distintas funciones e instalar librerías para cruzar, graficar y animar tus series de datos históricos.

# Introducción

Es indudable que entre los historiadores predomina el tratamiento cualitativo de los documentos y fuentes que el pasado nos ha legado. Pero como ha señalado Roderick Floud, “aunque estemos básicamente más interesados en las cuestiones ‘cualitativas’ que en las ‘cuantitativas’, ambas están inextricablemente unidas”[¹]. No compiten, no se reemplazan, sino que se complementan. Una forma de poner en juego ambas metodologías, es que a través del hallazgo de tanto regularidades o patrones ocultos o a la inversa, de anomalías, sean útiles acercando a quienes hacen investigación histórica, a un mejor conocimiento de las coordenadas donde ubican sus interpretaciones. Y si esa comprensión global de los datos puede visualizarse gráficamente, posibilita además “que el investigador descubra fácilmente relaciones, similitudes y diferencias entre sus casos”. Desde que escribió Floud -a mediados de los años ‘70- la tecnología informática y la programación han avanzado de tal manera que hacen muy fácil el cruce entre perspectivas metodológicas.

Quien se propone hacer un análisis histórico cuantitativo, debe partir de codificar un pasado y plasmarlo como matriz de datos. Es decir, demanda en primer lugar, un trabajo de conversión de un conjunto de fuentes o documentos, una transformación de datos textuales en datos simbólicos operables digitalmente. La cuestión tiene varias pasos: 1) *clasificar* los documentos a los que se ha accedido de forma que permitan su puesta en común según criterios determinados, 2) *categorizar* descriptiva, interpretativa o analíticamente, con ideas, categorías o conceptos el contenido de las fuentes, 3) *codificar*, poniendo a las distintas expresiones particulares de cada caso un símbolo (números, palabras), 4) *tabular*, es decir representar los casos organizados en forma de una matriz en un soporte informático, habitualmente una hoja de cálculo.

*En esta lección, te mostraremos una de las tantas formas en que se pueden aprovechar cuantitativamente archivos que reúnen información sistemática y seriada (como son casos de productores de documentación permanente como el estado, empresas o la prensa) utilizando el lenguaje R*. El objetivo es que adquieras conocimientos que te permitan efectuar un *análisis exploratorio de datos* inicial, trabajando principalmente la *distribución de frecuencias* de distintas variables a través de tablas de contingencia, visualizarlas luego generando gráficos, y finalmente ensayar una animación de los mismos en perspectiva temporal. De esta manera, si un trabajo histórico cualitativo apunta a profundizar aspectos de fenómenos que sucedieron en el pasado, uno cuantitativo te permitirá saber con qué frecuencia sucedieron, observar patrones y anomalías y encontrar temporalidad en las relaciones que existen entre categorías de análisis.

# Requisitos

Esta lección asume que manejas los tópicos básicos de R tratados en las lecciones de [Taryn Dewar](https://programminghistorian.org/es/lecciones/datos-tabulares-en-r) y [Nabeel Siddiqui](https://programminghistorian.org/es/lecciones/administracion-de-datos-en-r).

Además del lenguaje R, deberás tener instalado el entorno de desarrollo RStudio. Si no lo tienes, este tutorial te ayudará a hacerlo: [https://www.youtube.com/watch?v=Nmu4WPdJBRo](https://www.youtube.com/watch?v=Nmu4WPdJBRo)

# Los datos explorados

El conjunto de datos que aquí se presenta servirá para que veas cómo R te puede ayudar a analizar dinámicas de la violencia política en Argentina a finales de la década de 1950, a partir de utilizar documentos policiales de espionaje. Habitualmente estos archivos de inteligencia se han utilizado para el estudio histórico de casos particulares, pero rara vez se ha apuntado a lograr grados de agregación que permitan hacer *comparaciones* entre distintos casos. Sin embargo, contar con algunos elementos básicos de programación facilita dar pasos en esa dirección.

La fuente que te proponemos codificar es un legajo muy especial del archivo de la ex Dirección de Inteligencia de la Policía de Buenos Aires (Argentina): contiene varios informes de inteligencia que contabilizan ‘actos terroristas’ durante los años del período de conflictividad política y social que se conoce en la historia argentina como ‘Resistencia peronista’[²]. Lo interesante es que la información cruda se presenta de una manera que facilita su tabulación:

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-1.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Este documento fue transformado en un conjunto de datos procesables cuantitativamente, construyendo una *tabla* (matriz de datos) a partir de la información existente sobre algunas localidades de Buenos Aires para 1959, un año donde el número de 'actos terroristas' o atentados fue muy alto. Los datos representan los valores de ciertas *variables* de análisis comunes a todos los registros, como son la *ciudad* (dónde) y la *fecha* del atentado (cuándo). Desde la información descriptiva de la policía (atributos del atentado) fue posible generar variables como: *objeto* utilizado en el atentado (con qué elemento se perpetra), *sitio* (en qué lugar/espacio) y *objetivo* (contra quién). Con este tipo de categorización, buscamos ahorrar un paso, ya que se ingresan los datos limpios y ordenados según los preceptos *tidy data*: cada variable forma una columna, cada observación forma una fila, cada valor debe tener su propia celda, cada tipo de unidad observacional forma una tabla.

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-2.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

La tabla de atentados correspondientes a 5 ciudades durante 1959 la tienes disponible en formato hoja de cálculo aquí [atentados1959.xlsx] (https://drive.google.com/file/d/1EwbmekwN-E7o4JiBmCqY0U4eDf12ZKFs/view?usp=sharing)


# Tratamiento y limpieza de los datos con R

En esta sección te mostraremos cómo traer los datos a RStudio para comenzar a procesarlos. No esperes que una vez importada la hoja de cálculo ya estás listo para trabajar, pues siempre será necesaria una adecuación de tus datos para que R pueda interpretarlos. En lo que atañe a este caso por ejemplo luego de importarlos deberás darle un tipo a las variables, convertirlas, hacer algunas modificaciones en los datos y luego ordenarlos temporalmente.

El primer paso entonces, será importarlos desde su formato de hoja de cálculo al entorno de RStudio. Para poder hacerlo deberás antes instalar una *library* (biblioteca) que te de los recursos para hacerlo. Cada *library* contiene una colección de funciones -reunidas siempre con algún criterio- que organizadas en módulos, amplían las posibilidades de tratar los datos con más profundidad de lo que te ofrece la instalación base de R. Son también conocidas como *packages* (paquetes) y a veces uno de ellos puede contener un conjunto de paquetes, como es el caso del que instalarás en primer término: *tidyverse*. Es uno de los más utilizados para análisis exploratorios pues te permite realizar fácilmente tareas tales como leer, transformar, tratar, manipular, organizar y visualizar distinto tipo de datos.

Para acceder a él hay que instalarlo y lo harás a través de la consola de RStudio (donde verás un símbolo `>` apuntando al cursor) ejecutando el primer comando de esta lección:

`install.packages("tidyverse")`

 La instalación se hace por defecto desde el repositorio CRAN. A continuación, para cargar el paquete al entorno R, pon en la consola:

`library(tidyverse)`

Ahora estas en condiciones de importar desde RStudio el dataset. Elige *File* de la barra de menús de RStudio, y luego las opciones *Import Dataset/From Excel*.

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-3.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Una vez que abre la nueva ventana, con *Browse* busca la carpeta correspondiente, y selecciona en la carpeta donde lo almacenaste el archivo *atentados1959.xlsx* y al cargarlo te mostrará sus primeros registros. Si lo deseas puedes cambiar el nombre del dataset modificando *Name* en la parte inferior de la ventana. Te sugerimos ponerle *at59* para abreviarlo. Al dar la orden de *Import*, rápidamente verás cómo se cargaron los datos en el panel de edición (arriba a la derecha). Es el equivalente a poner en la consola:

`view(at59)`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-4.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Algo fundamental es entender en qué forma fue almacenada la información. En *R* todo es un *objeto* y por ello los datos importados serán transformados en uno también, en este caso uno del tipo *estructura de datos*. R maneja varias estructuras que se diferencian por tener distinta cantidad de dimensiones y por si puede guardar o no datos de diverso tipo. La más conocida es el *vector*, una colección de una dimensión de datos de igual tipo, la *matriz* es similar pero permite trabajar en dos dimensiones. Pero *R* también cuenta con una forma particular de estructura de datos, también de dos dimensiones pero que puede contener datos de distinto tipo (enteros junto a fechas, caracteres, etc): el *data frame*, donde cada fila corresponde a una observación o registro, mientras que cada columna es un vector que representa una variable de análisis. El *data frame* es una de las estructuras más utilizadas en *R* y los datos al ser importados, se almacenarán de esta manera. La función `head()` te  permitirá ver los primeros registros del mismo y encerrados entre los símbolos `<>` te indicarán el tipo de dato en que se han organizado: la fecha en formato *datatime* (fecha y hora) y el resto de las columnas como *character* (carácter).

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-5.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Con la tabla ya cargada en *RStudio* puedes empezar el tratamimiento de los datos para hacerlos operables, por ejemplo, viendo cómo reemplazar determinados valores de la estructura de datos, para corregir o cambiar contenidos masivamente. Una de las maneras que ofrece R para hacerlo es a través de la función `ifelse()`. Esta te permite seleccionar elementos de una estructura de datos según se cumpla o no alguna condición, operando globalmente sobre ella, ya que aprovecha la vectorialización del lenguaje y evita la necesidad del uso de bucles para recorrer las filas. Lo recomendable es que hagas estas operaciones sobre los datos antes de realizar alguna conversión sobre su tipo.

Suponte que deseas reemplazar todos los casos donde el *objeto* figura como ‘bomba’, por ‘explosivo’. Perfectamente puedes usar la función `ifelse()` pasándole sólo tres argumentos. Primero se vuelca la condición a cumplir, tomando la variable correspondiente, en este caso los valores ‘bomba’ de la columna *objeto* de *at59*, que es seleccionada con el símbolo `$`. El segundo argumento refiere a lo que la función asignará en el caso de cumplirse: lo reemplazará por ‘explosivo’. El tercer argumento, es el valor asignado en el caso negativo y aquí lo dejarás equivalente al valor original:

`at59$objeto<-ifelse(at59$objeto=="bomba", "explosivo", at59$objeto)`

Si te arrepientes de los cambios, puedes hacer la misma operación pero a la inversa:

`at59$objeto<-ifelse(at59$objeto=="explosivo", "bomba", at59$objeto)`

A continuación, te convendrá transformar el *tipo* de los datos para que puedan ser interpretados por el lenguaje, y además, eso te permitirá aprovechar mejor las funciones de visualización. Comienza por adecuar las fechas -no interesa que tengan la hora- de manera muy sencilla utilizando la función `as.Date()` sobre la columna *fecha*:

`at59$fecha<-as.Date(at59$fecha)`

Luego, puedes continuar con el resto de las variables de análisis transformándolas a *factor*, que es el tipo de dato que brinda *R* para trabajar con *variables categóricas* (las que representan un conjunto fijo y conocido de valores posibles), ingresando en la consola:

`at59$ciudad<-factor(at59$ciudad)`

Suguiendo con el análisis aquí propuesto, a continuación deberías hacer algo idéntico con las tres columnas restantes (*objeto, sitio* y *objetivo*). Pero si te interesa practicar escritura de código prolijo, uno de sus preceptos apunta a evitar la repetición de sentencias si no es necesaria, y a aprovechar el potencial que brinda el lenguaje que estemos utilizando. En el caso de *R*, puedes hacerlo de otra manera muy sencillamente, utilizando funciones que permiten aplicar de manera generalizada otras funciones a una estructura de datos.

Entre diversas opciones, aquí te invitamos a usar a `map_df()` del paquete *purrr* (incluido en *tidyverse*), que te permite asignar una función -que en este caso será una para cambiar el tipo de datos- a diversos elementos de un data frame, almacenando el resultado en un objeto de esta misma clase. Como argumento de la función se envía en primer término el nombre de las columnas -en un formato vectorizado con `c()`- y luego la función que quieras aplicar a dicha columna. Para unificar el código en sólo una sentencia, reúne las dos transformaciones con la función `tibble()`, lo que te dará como resultado un data frame con propiedades de *tibble* y con las columnas organizadas y convertidas tal como estaban originalmente:

`at59<-tibble(map_df(at59[,c('fecha')], as.Date), map_df(at59[,c('ciudad','objeto','sitio','objetivo')], factor))`

Para finalizar esta etapa de limpieza y transformación de los datos, te quedaría por ver cómo es posible dar un orden a los mismos. Para ello dispones de la función `arrange()`, del paquete *dplyr* (incluido en *tidyverse*), que te permitirá reordenar las filas del data frame. Por defecto lo va hacer de forma ascendente, aunque siempre debes tener en cuenta que la mayoría de las funciones en R son parametrizables y nos permiten variaciones: la cuestión es buscar y explorar la documentación de las funciones, fácilmente accesible en la web. En este caso, la función pide que pases como primer argumento la estructura de datos y en segundo lugar la variable que será el criterio ordenador. Si lo haces por fecha deberás ingresar:

`at59<-arrange(at59, fecha)`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-6.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```
Puedes apreciar cómo queda ahora reorganizado y listo tu conjunto de datos para que comiences ahora sí a analizarlos.

# Explorando los datos

En lo que sigue verás cómo realizar un elemental *análisis exploratorio* de estos datos históricos en búsqueda de relaciones entre casos locales. La idea de este tipo de metodología es identificar las principales características de un conjunto de datos (en tanto patrones, diferencias, tendencias, anomalías, discontinuidades, distribuciones) con el objetivo de conocer la *variabilidad* de los mismos. Al representar esta variación de datos en números, pero sobre todo en forma de gráficos y visualizaciones, el análisis exploratorio de datos se transforma en medio para desarrollar nuevas perspectivas analíticas, preguntas o hipótesis: con una breve mirada, podemos estar al tanto de concentraciones de datos, valores atípicos, saltos, etc.

Con nuestra base vamos a trabajar con una de las formas primarias en que se manifiesta la variabilidad en los datos: la *distribución de frecuencias*. Lo haremos en modo bivariado, es decir veremos cómo se pueden construir *tablas de contingencia* que contabilicen los casos resultantes del cruce de 2 variables dentro del conjunto de los atentados efectuados durante 1959.

Para hacerlo contamos con una sencilla función justamente denominada `table()`, que toma variables tipo factor como parámetros y regresa la frecuencia de aparición de las categorías de la variable. Un aspecto interesante de esta función es que también nos permite pasarle una sola columna como argumento. Por ejemplo, si queremos saber cuántos atentados hay por ciudad o según qué se utilizó para hacerlos, podemos conocer la cifra con las sentencias:

`table(at59$ciudad)`

`table(at59$objeto)`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-7.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Si quieres empezar a probar las capacidades gráficas que te da *R*, puedes transformar alguna de esas tablas de 1 dimensión en un cuadro de barras con una función base llamada `barplot()`, usando como parámetro a la anterior función:

`barplot(table(at59$ciudad))`

Verás aparecer en la pestaña *Plots* de la ventana de utilidades el siguiente gráfico:

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-8.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Para pensar en posibles relaciones entre variables y categorías, confeccionar una tabla de contingencia es muy simple: en lugar de una, a la función `table()` le pasas las dos columnas que te interesen cruzar. Si quiers saber con qué tipo de elementos se atentó según la ciudad de ocurrencia del hecho, deberías ingresar a la consola:

`table(at59$ciudad, at59$objeto)`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-9.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Existen muchas formas de hacer más amigable la visualización de tablas de contingencia utilizando diversas librerías disponibles en *CRAN*. Una que sin ser complicada te dará unos cuadros mejorados estéticamente es *kableExtra*. El procedimiento tiene dos partes: primero debes darle formato *html* a la tabla con la función `kable()` y almacenarla en una variable at59k, y con este argumento llamar a `kable_styling()`, que te permitirá visualizarlos y manejar varios atributos de estilo, como el tamaño de letra. Dicho esto vamos a instalar, cargar y probar el paquete, sumando al cuadro un título:

`install.packages("kableExtra")`

`library(kableExtra)`

`at59k<-kable(table(at59$ciudad, at59$objeto), caption = 'Objeto vinculado al atentado por ciudad')`

`kable_styling(at59k, font_size =10)`

Verás el resultado nuevamente en *Viewer* y tendrás también vía la pestaña *Export*, la posibilidad de guardarlo como imagen *jpg* o *png*.

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-10.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

# Visualizando tablas con *ggplot2*

R se destaca por su capacidad de ilustrar conjuntos de datos y te mostraremos ahora como aplicarlo en tablas como éstas. El paquete *ggplot2* es uno de los más usados para hacer gráficas por quienes utilizan este lenguaje. Tiene una lógica inspirada en la denominada gramática de los gráficos (*the grammar of graphics*), consistente en el uso de capas o *layers*, que se ajustan según parámetros que se le pasan. Un gráfico es la combinación de las capas, donde cada una cumple una función determinada sobre: los datos, los aspectos estéticos de los mismos (tamaño, forma, color, etc.), los objetos geométricos que van a representar los datos (puntos, líneas, polígonos, áreas, etc), siendo estas capas esenciales que no pueden faltar. Luego, opcionalmente, sumando otras capas puedes facetar en subgrupos, dar coordenadas, usar estadísticas y cambiar la apariencia general del gráfico. Como *ggplot2* está ya incluida en *tidyverse*, no necesitas instalar nada nuevo.

Considerada en términos abstractos, una sentencia básica de esta gramática tiene la siguiente estructura: `ggplot(datos, variables) + función geométrica`. Los datos corresponden al conjunto total que estamos manejando, y que para *ggplot2* deben estar en formato data frame. Las variables, se interpretan aquí como la expresión estética (en tanto distancia horizontal/vertical) de las columnas elegidas. La función geométrica (*geom*) nos permite elegir el objeto visual con el que se representarán los datos. Como es una lógica de capas, el signo `+` permite ir agregando todas las que consideres necesarias para que tu gráfico incluya la información que te interese.

Si deseas ver gráficamente la tabla de contingencia que construiste anteriormente, puedes empezar haciendo la equivalencia un atentado = un *punto* en el plano, a lo que correspondería la sentencia mínima:

`ggplot(at59, aes(x=ciudad, y=objeto)) +`

`geom_point()`

Y obtendrás este resultado:

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-10.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Sin embargo, debe reconocerse que la acumulación de los puntos uno sobre otro en una misma coordenada (*overplotting*) redunda en una visualización muy poco aprovechable ya que -como sí lo hace la tabla- no llega a la representación visual de frecuencias, y sólo muestra la existencia de cruces de variables. Prueba entonces reemplazando a `geom_point()` por otra función que contabilice el número de ocurrencias de cada combinación: una imagen que te dé una rápida pista acerca de las variaciones en la frecuencia de los atentados. Para ello está disponible `geom_count()`, que además del efecto visual, añade al gráfico una escala de frecuencias.

Si te interesa enriquecer la visualización sumando diferentes etiquetas al gráfico (ponerle un título, cambiar nombre de variables, etc) le agregas una capa con la función `labs()`. Incluso puedas cambiar la apariencia general agregando una capa con alguna de las variantes que te provee `theme_()`, función que permite controlar los elementos del gráfico no vinculados a los datos.

`ggplot(at59, aes(x=ciudad, y=objeto)) +`

`geom_count() +`

`labs(title = “Atentados durante 1959”, subtitle= “Objeto utilizado según ciudad”, x= “CIUDAD”, y= “OBJETO”) +`

`theme_bw()`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-12.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Otra forma de aprovechar las ventajas de visualización que te da R y evitar la superposición de puntos, es utilizando la propiedad *jitter*, que afecta la posición de los puntos. La función gráfica `geom_jitter()` te permite agregar una pequeña cantidad de variación aleatoria a la ubicación de cada punto, y es muy útil si te manejas con posiciones discretas y conjuntos de datos pequeños. También para explorar otras capacidades estéticas, prueba por ejemplo pasarle como parámetro que el color de los puntos sea diferente según la ciudad, utilizando `colour`. Como el argumento debe ser en formato numérico, debes convertirlo con `as.numeric()`. Además de manejar la coloración, tienes la posibilidad de manejar por ejemplo el tamaño de los puntos con `size`, o su transparencia con `alpha`.

`ggplot(at59, aes(x=ciudad, y=objeto)) +`

`geom_jitter(colour=as.numeric(at59$ciudad)) +`

`labs(title = "Atentados durante 1959", subtitle= "Objeto utilizado según ciudad", x="CIUDAD", y="OBJETO") +`

`theme_bw()`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-13.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

# Animando la visualización de los datos con *gganimate*

Si bien existen distintas bibliotecas para animar visualizaciones en R, aquí te invitaremos a hacerlo con *gganimate*, una extensión del paquete *ggplot2* que te permitirá crear una animación a partir de un gráfico *ggplot* y ver de forma dinámica cómo tus datos evolucionan según estados (variables) o en el tiempo. Las funciones centrales de *gganimate* son el grupo de las transiciones  (*transition*), que interpretan los datos de la trama para distribuirlos según algún criterio específico en varios cuadros (*frames*). También deberás instalar el paquete *gifski*, un codificador de *gifs* que te será útil para disponer de tu animación en otras plataformas:

`install.packages("gganimate")`

`install.packages("gifski")`

`library (gganimate)`

`library(gifski)`

Para generar una animación que represente la ocurrencia de atentados según una progresión temporal, la función indicada es `transiton_time()`. El procedimiento es muy sencillo: al código que escribiste para hacer el gráfico le sumas esta función, poniendo como argumento la variable temporal *fecha*. Pero a los efectos de realizar una visualización más clara de tus datos, conviene que le agregues al código un par de elementos.

Por un lado, como en *gganimate* la animación resultante es un conjunto de imágenes (instantáneas) desplegadas en serie consecutiva, cada nuevo frame -si no le indicas lo contrario- al mostrarse oculta el anterior y sólo lograrás ver puntos parpadeando. Para manejar esto, cuentas con el grupo de funciones `shadow`, que te deja elegir cómo se muestran los datos que ya no se corresponden con los del *frame* actual. En el caso de este gráfico, para que permanezcan todos los datos anteriores de fondo, corresponde utilizar `shadow_mark()` acompañada del argumento que te permite dejar visibles los cuadros anteriores. Por otra parte, como puede ser bastante difícil entender una animación sin ninguna indicación sobre a qué refiere cada punto temporal, *gganimate* te proporciona un conjunto de variables (*frame variables*) para cada fotograma, que puedes insertar en las etiquetas de los gráficos utilizando la sintaxis llamada *glue*, que utiliza los símbolos `{}`. Con ello dispondrás de una serie de metadatos, según la variante de transición que ensayes. Para `transition_time()` cuentas con `{frame_time}`, que te retornará el valor del argumento que procesa la función durante el fotograma en curso. El código quedaría entonces así:

`ggplot(at59, aes(x=ciudad, y=objeto)) + geom_jitter(colour=as.numeric(at59$ciudad), size=4) + labs(title = "Atentados durante 1959", subtitle= "Objeto utilizado según ciudad - Fecha: {frame_time}", x="CIUDAD", y="OBJETO") +
 theme_bw() +`

`transition_time(at59$fecha) +`

`shadow_mark (past = TRUE)`

Al ingresarlo directamente en la consola, comienza el denominado *rendering* -proceso de generación de la animación- que tiene duración relativa, en este caso sólo serán unos segundos:

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-14.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Cuando concluya, en la pestaña *Viewer* de la ventana de utilidades podrás observar la animación. Si presionas el ícono *Show in the new window*, se abrirá un *gif* en el navegador asociado por defecto, que prodrás almacenar.

Ahora bien, lo recomendable sería que no ejecutes el código *ggplot* directamente por la consola, sino que lo asignes a un objeto, pues te dejará la posibilidad de manejar velocidad y pausas en la animación por medio de la función `animate()`. Con ella podrás ajustar la cantidad total de *frames*, la duración total y los *frames* por segundo entre otras cosas. Para ensayarlo dale a `fps` un parámetro de 5 cuadros por segundo y añade una pausa final de 15 segundos con `end_pause`:


`atentados<-ggplot(at59, aes(x=ciudad, y=objeto)) +`

`geom_jitter(colour=as.numeric(at59$ciudad), size=4) +`

`labs(title = "Atentados durante 1959", subtitle= "Objeto utilizado según ciudad - Fecha: {frame_time}", x="CIUDAD", y="OBJETO") +`

`theme_bw() +`

`transition_time(at59$fecha) + shadow_mark(past = TRUE)`

`animate(atentados, fps = 5, end_pause = 15)`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-15.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```


*A esta altura y con estos resultados, puedes considerar que has realizado un análisis exploratorio tus datos y empezar a pensar en hipótesis al respecto. En este caso concreto y si te dedicas a la historia de las luchas sociales y políticas en Argentina contemporánea, las tablas de contigencia y los gráficos estáticos permitieron encontrar por ejemplo similitudes entre Avellaneda y La Plata, tanto entre las frecuencias de los atentados como de su tipo (en tanto objeto utilizado), y además disponemor del ritmo temporal (intensidad) de los mismos, lo que te invita a enfocar sobre posibles patrones o relaciones de corte más histórico, entre casos que no suelen estar conectados en las investigaciones, por su diferente estructura socio-económica para la época.*

# Conclusión

Esta lección buscó darte una idea de las diversas tareas que deberías hacer para preparar y llevar adelante un primer análisis exploratorio de datos sobre alguna serie de documentos históricos que dispongas. Con muy poco esfuerzo, puedes hacer unos cálculos básicos con ellos y volcarlos visualmente, para pensar, preguntarte e hipotetizar sobre ellos.

La propuesta de trabajo que te hicimos se ha planteado como un puntapié inicial, cruzando sólo un par de variables, dejandoté como desafío práctico otras para que continues probando variantes, y también invitarte a que te animes a llegar directamente con a la fuente (https://gganimate.com/index.html) y descubrir por tí mismo la potencia de *ggplot* y *gganimate*.


# Notas

[¹] Floud, Roderick (1983). *Métodos cuantitativos para historiadores*. Madrid: Alianza Editorial.

[²] Pueden encontrar una detallada referencia del archivo en el sitio de la Comisión Provincial por la Memoria de la provincia de Buenos Aires: (https://www.comisionporlamemoria.org/extra/archivo/cuadroclasificacion/)
