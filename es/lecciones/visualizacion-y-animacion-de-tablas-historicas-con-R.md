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

Esta lección les mostrará cómo cruzar, graficar y animar un conjunto de datos históricos. Partiendo desde una tabla que dispongan en una hoja de cálculos, podrán importarla a RStudio y así aprender a utilizar funciones básicas que permitirán transformar y organizar sus datos para presentarlos rápidamente como tablas de contingencia. Luego podrán saber cómo incorporar y utilizar funciones de nuevas librerías con las que podrán aprovechar las posibilidades de graficación de datos cruzados discretos, e inclusive llegar a animarlos en perspectiva temporal.  

# Objetivos

que luego de practicar esta lección,


1.  Podrán transformar y organizar tus datos para trabajar con ellos en un entorno *RStudio*.

2.  Sabrán cómo utilizar distintas funciones e instalar librerías para cruzar, graficar y animar sus series de datos históricos

# Introducción

Es indudable que entre los historiadores predomina el tratamiento cualitativo de los documentos y fuentes que el pasado nos ha legado. Pero como ha señalado Roderick Floud, “aunque estemos básicamente más interesados en las cuestiones ‘cualitativas’ que en las ‘cuantitativas’, ambas están inextricablemente unidas”[^1]. No compiten, no se reemplazan, sino que se complementan. Es decir, poner en juego ambas metodologías puede ayudar a encontrar regularidades, patrones ocultos, como también registrar anomalías, y por lo tanto ser muy útiles a quienes hacen investigación histórica pues los acerca a un mejor conocimiento de las coordenadas donde ubican sus interpretaciones. Y si esa comprensión global de los datos puede visualizarse gráficamente, posibilita además “que el investigador descubra fácilmente relaciones, similitudes y diferencias entre sus casos”. Desde que escribió Floud -a mediados de los años ‘70- la tecnología informática y la programación han avanzado de tal manera que nos hacen muy fácil el cruce entre perspectivas metodológicas.


Quien se propone hacer un análisis histórico cuantitativo, debe partir de codificar un pasado y plasmarlo como matriz de datos, una hoja de cálculo. Es decir, demanda en primer lugar, un trabajo de conversión de un conjunto de fuentes o documentos, una transformación de datos textuales en datos simbólicos operables digitalmente. La cuestión tiene varias pasos: 1) *clasificar* los documentos a los que se ha accedido de forma que permitan su puesta en común según criterios determinados, 2) *categorizar* descriptiva, interpretativa o analíticamente, con ideas, categorías o conceptos el contenido de las fuentes, 3) *codificar*, poniendo a las distintas expresiones particulares de cada caso un símbolo (números, palabras), 4) *tabular*, es decir representar los casos organizados en forma de una matriz en un soporte informático.


*En esta lección, les mostraremos una de las tantas formas en que se pueden aprovechar cuantitativamente archivos que reúnen información sistemática y seriada (casos de productores de documentación permanente como el estado, empresas o la prensa) utilizando el lenguaje R.*

Haremos un *análisis exploratorio de datos*, trabajando principalmente la *distribución de frecuencias* de distintas variables, a través de tablas de contingencia. Luego presentaremos formas de visualizarlas a través de gráficos, para finalmente ensayar una animación de los mismos, para destacar la variable temporal. De esta manera, si un trabajo cualitativo apunta profundizar sobre las cosas que suceden, lo cuantitativo nos hará saber con qué frecuencia suceden, además temporalizar la búsqueda de relaciones entre categorías de análisis.

# Requisitos

Esta lección asume que manejas los tópicos básicos de R tratados en las lecciones de [Taryn Dewar](https://programminghistorian.org/es/lecciones/datos-tabulares-en-r) y  [Nabeel Siddiqui](https://programminghistorian.org/es/lecciones/administracion-de-datos-en-r).

Además del lenguaje R, deberás tener instalado el entorno de desarrollo RStudio. Si no lo tienes, este tutorial te ayudará a hacerlo: [https://www.youtube.com/watch?v=Nmu4WPdJBRo](https://www.youtube.com/watch?v=Nmu4WPdJBRo)

# Los datos explorados

La propuesta concreta que aquí trabajaremos es cómo aprovechar R para analizar dinámicas de la violencia política en Argentina a finales de la década de 1950, a partir de un conjunto de documentos policiales de espionaje. Habitualmente los archivos de espionaje se han utilizado para el estudio histórico de casos particulares, pero rara vez se ha apuntado a lograr grados de agregación que permitan hacer comparaciones entre distintos casos. Sin embargo, contar con algunos elementos básicos de programación nos puede facilitar dar un paso en esa dirección.

La fuente que traemos para analizar es un legajo muy especial del archivo de la ex Dirección de Inteligencia de la Policía de Buenos Aires (Argentina). Este legajo contiene varios informes de inteligencia que contabilizan ‘actos terroristas’ durante los años del período de conflictividad política y social que se conoce en la historia argentina como ‘Resistencia peronista’[^2]. La información cruda se presenta de esta manera:

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-1.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Para transformarlo en un conjunto de datos procesables cuantitativamente, decidimos construir una *tabla* (matriz de datos) seleccionando información de algunas localidades de Buenos Aires para 1959, un año con un muy alto número de atentados. Los datos se organizaron en base a ciertas *variables* de análisis comunes a todos los registros, como son la *ciudad* (dónde) y la *fecha* del atentado (cuándo). Desde la información descriptiva de la policía (clase de atentado) fue posible generar variables como: *objeto* utilizado en el atentado (con qué elemento se perpetra), *sitio* (en qué lugar/espacio) y *objetivo* (contra quién). Con este tipo de categorización, buscamos ahorrar un paso, ya que se ingresan los datos limpios y ordenados según los preceptos *tidy data*: cada variable forma una columna, cada observación forma una fila, cada valor debe tener su propia celda, cada tipo de unidad observacional forma una tabla.

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-2.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

La tabla de atentados correspondientes a 5 ciudades durante 1959 está disponible en formato hoja de cálculo [atentados1959.xlsx] (https://drive.google.com/file/d/1EwbmekwN-E7o4JiBmCqY0U4eDf12ZKFs/view?usp=sharing)


# Tratamiento y limpieza de los datos con R

En esta sección veremos cómo traer nuestros datos a RStudio para comenzar a procesarlos. Pero no nos creamos que una vez importada la hoja de cálculo ordenada ya estamos listos para trabajar, pues siempre es necesaria una adecuación de nuestros datos para que R pueda interpretarlo. En lo que atañe a nuestro caso, luego de importarlos deberemos darle un tipo a nuestras variables, convertirlas, hacer algunas modificaciones en los datos y luego ordenarlos temporalmente.

Empecemos por importarlos desde su formato de hoja de cálculo al entorno de RStudio. Para poder hacerlo deberemos antes instalar una *library* (biblioteca) que nos de los recursos para hacerlo. Cada *library* contiene una colección de funciones -reunidas siempre con algún criterio- que organizadas en módulos, amplían las posibilidades de tratar los datos con más profundidad de lo ofrecido por la instalación base de R. Son también conocidas como *packages* (paquetes) y a veces uno de ellos puede contener un conjunto de paquetes, como es el caso del que instalaremos en primer término: *tidyverse*. Es uno de los más utilizados para análisis exploratorios pues permite realizar fácilmente tareas tales como leer, transformar, tratar, manipular, organizar y visualizar distinto tipo de datos.

Para acceder a él hay que instalarlo y lo haremos a través de la consola de RStudio (donde veremos un símbolo > apuntando al cursor) ejecutando el primer comando de esta lección:

`install.packages("tidyverse")`

 La instalación se hace por defecto desde el repositorio CRAN. A continuación, para cargar el paquete al entorno R, ponemos en la consola:

`library(tidyverse)`

Ahora estamos en condiciones de importar desde RStudio nuestro dataset. Elegimos *File* de la barra de menús de RStudio, y luego las opciones *Import Dataset/From Excel*.

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-3.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Una vez que abre la nueva ventana, con *Browse* buscamos la carpeta correspondiente, seleccionamos nuestro archivo *atentados1959.xlsx* y al cargarlo nos mostrará sus primeros registros. Si lo deseamos podemos cambiar el nombre del dataset modificando Name en la parte inferior de la ventana. Nosotros le pondremos *at59* para abreviarlo. Al dar la orden de *Import*, rápidamente veremos cómo se cargaron nuestros datos en el panel de edición (arriba a la derecha). Es el equivalente a poner en la consola:

`view(at59)`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-4.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Ahora nos toca saber en qué forma está almacenada nuestra información. En R todo es un *objeto* y por ello nuestros datos serán transformados en uno también, en este caso uno del tipo  *estructura de datos*. R maneja varias estructuras que se diferencian por tener distinta cantidad de dimensiones y por si puede guardar o no datos de diverso tipo. La más conocida es el *vector*, una colección de una dimensión de datos de igual tipo, la *matriz* es similar pero permite trabajar en dos dimensiones. Pero en R también contamos una forma particular de estructura de datos, también de dos dimensiones pero puede contener datos de distinto tipo (enteros junto a fechas, caracteres, etc): el *data frame*, donde cada fila corresponde a una observación o registro, mientras que cada columna es un vector que representa una variable de análisis. El *data frame* es una de las estructuras más utilizadas en R y nuestros datos al ser importados, se almacenan de esta manera. La función `head()` nos permitirá ver los primeros registros del mismo y encerrados entre los símbolos `<>` indica el tipo de dato en que se han organizado: la fecha en formato *datatime* (fecha y hora) y el resto de las columnas como *character* (carácter).

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-5.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Podemos comenzar el tratamiento de nuestra tabla, viendo cómo podemos reemplazar determinados valores de esta estructura de datos, por ejemplo para corregir o cambiar contenidos masivamente. Una de las maneras que nos ofrece R para hacerlo es a través de la función `ifelse()`. Esta nos permite seleccionar elementos de una estructura de datos según se cumpla o no alguna condición, operando globalmente, ya que aprovecha la vectorialización del lenguaje y nos evita la necesidad del uso de bucles para recorrer las filas. Lo recomendable es hacer estas operaciones cuando los datos antes de realizar alguna conversión.

Supongan que deseamos reemplazar todos los casos donde el objeto figura como ‘bomba’, por ‘explosivo’. Perfectamente podemos usar la función `ifelse()` pasándole sólo tres argumentos. Primero se vuelca la condición a cumplir, tomando la variable correspondiente, en este caso los valores ‘bomba’ de la columna *objeto* de *at59*, que es seleccionada con el símbolo $. El segundo argumento refiere a lo que la función asignará en el caso de cumplirse: lo reemplazará por ‘explosivo’. El tercer argumento, es el valor asignado en el caso negativo y nosotros aquí lo haremos equivalente al valor original:

`at59$objeto<-ifelse(at59$objeto=="bomba", "explosivo", at59$objeto)`

Si nos arrepentimos, podemos hacer la operación pero a la inversa:

`at59$objeto<-ifelse(at59$objeto=="explosivo", "bomba", at59$objeto)`

Ahora bien, como decíamos, los historiadores tenemos de base una perspectiva cualitativa, por lo que nos convendrá transformar el *tipo* de los datos para procesarlos mejor y nos permitirá luego aprovechar mejor las funciones de visualización. Comenzaremos por adecuar las fechas -ya que no nos interesa que tenga la hora- y lo haremos de manera muy sencilla utilizando la función as.Date() sobre la columna *fecha*:

`at59$fecha<-as.Date(at59$fecha)`

Luego, tomaremos el resto de nuestras variables de análisis y las transformaremos al tipo *factor*, que es el que nos brinda R para trabajar con variables categóricas (las que representan un conjunto fijo y conocido de valores posibles), ingresando en la consola:

`at59$ciudad<-factor(at59$ciudad)`

A los efectos de nuestro análisis, a continuación deberíamos hacer algo idéntico con las tres columnas restantes (*objeto, sitio y objetivo*). Pero si aspiramos a practicar la escritura de código prolijo, uno de sus preceptos apunta a evitar la repetición de sentencias si no es necesaria, y a aprovechar el potencial que nos brinda el lenguaje que estemos utilizando. En el caso de R, lo podemos hacer de otra manera muy sencillamente, utilizando funciones que nos permiten aplicar de manera generalizada otras funciones a una estructura de datos.

Recurriremos a `map_df()` del paquete *purrr* (incluido en *tidyverse*), que nos permite asignar una función -que en nuestro caso es una para cambiar el tipo de datos- a diversos elementos de un data frame, almacenando el resultado en un objeto de esta misma clase. Como argumento de la función se envía en primer término las columnas de nuestros datos -en un formato vectorizado con `c()`- y luego la función que queremos aplicar a dicha columna. Si queremos unificar el código en sólo una sentencia, podemos reunir las dos transformaciones que necesitamos con la función `tibble()`, que nos da como resultado un data frame con propiedades de *tibble* y con las columnas organizadas y convertidas tal como estaban originalmente:

`at59<-tibble(map_df(at59[,c('fecha')], as.Date), map_df(at59[,c('ciudad','objeto','sitio','objetivo')], factor))`

Para finalizar esta etapa de limpieza y transformación de nuestros datos, nos queda hablar de cómo podemos dar un orden a nuestra tabla de datos. Para ello disponemos de la función `arrange()`, del paquete *dplyr* (incluido en *tidyverse*), que nos permitirá reordenar las filas de nuestro data frame. Por defecto lo va hacer de forma ascendente, aunque siempre debemos tener en cuenta que la mayoría de las funciones en R son parametrizables y nos permiten variaciones: la cuestión es buscar y explorar la documentación de las funciones, fácilmente accesible en la web. En este caso, la función nos pide que pasemos como primer argumento nuestra estructura de datos y en segundo orden la variable que será el criterio ordenador. Nosotros lo haremos por fecha:

`at59<-arrange(at59, fecha)`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-6.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```
Se puede apreciar cómo queda ahora reorganizado y listo nuestro conjunto de datos para que comencemos ahora sí a analizarlos.

# Explorando los datos

En lo que sigue veremos cómo realizar un elemental *análisis exploratorio* nuestro conjunto de datos en búsqueda de relaciones entre casos locales. La idea de este tipo de metodología es identificar las principales características de un conjunto de datos (en tanto patrones, diferencias, tendencias, anomalías, discontinuidades, distribuciones) con el objetivo de conocer la *variabilidad* de los mismos. Al representar esta variación de datos en números, pero sobre todo en forma de gráficos y visualizaciones, el análisis exploratorio de datos se transforma en medio para desarrollar nuevas perspectivas analíticas, preguntas o hipótesis: con una breve mirada, podemos estar al tanto de concentraciones de datos, valores atípicos, saltos, etc.

Con nuestra base vamos a trabajar con una de las formas primarias en que se manifiesta la variabilidad en los datos: la *distribución de frecuencias*. Lo haremos en modo bivariado, es decir veremos cómo se pueden construir *tablas de contingencia* que contabilicen los casos resultantes del cruce de 2 variables dentro del conjunto de los atentados perpetrados durante 1959.

Para hacerlo contamos con una sencilla función justamente denominada `table()`, que toma a variables tipo factor como parámetros y regresa la frecuencia de aparición de las categorías de la variable. Un aspecto interesante de esta función es que también nos permite pasarle una sola columna como argumento. Por ejemplo, si queremos saber cuántos atentados hay por ciudad o según qué se utilizó para hacerlos, podemos conocer la cifra con las sentencias:

`table(at59$ciudad)`

`table(at59$objeto)`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-7.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Si también queremos ir probando algunas de las capacidades gráficas que nos da R, podemos transformar nuestra tabla de 1 dimensión en un cuadro de barras con una función base llamada `barplot()`, usando como parámetro a la anterior función:

`barplot(table(at59$ciudad))`

Verán aparecer en la pestaña *Plots* de la ventana de utilidades el siguiente gráfico:

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-8.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Para confeccionar una tabla de contingencia que nos permita ver relaciones entre categorías, en lugar de una variable, a la función `table()` se le pasan las dos columnas que nos interesa cruzar. Si queremos saber con qué tipo de elementos se atentó según ciudad de ocurrencia del hecho, deberíamos ingresar a la consola:

`table(at59$ciudad, at59$objeto)`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-9.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Existen muchas formas de hacer más amigable la visualización de tablas de contingencia, utilizando diversas librerías disponibles. Aquí sólo para mostrar que no es muy complicado tener cuadros mejorados estéticamente, tomaremos a *kableExtra*. El procedimiento tiene dos partes: primero darle otro formato *html* a la tabla con la función `kable()`, y con este resultado llamar a la función `kable_styling()` que permitirá visualizarlos y manejar varios atributos de estilo, como por ejemplo el tamaño de letra. Lo novedoso ahora es que usaremos el operador *pipe* `%>%`, una sintaxis basada en el flujo, el encadenamiento de funciones, que permite pasar los resultados de la función ubicada a la izquierda del operador como argumentos de siguiente. A la hora de escribir *scripts* (pequeños programas simples interpretados) en R, el operador *pipe* resulta clave para escribir código de forma transparente y estructurada. Dicho esto vamos a instalar, cargar y probar el paquete, sumando al cuadro un título:

`install.packages("kableExtra")`

`library(kableExtra)`

`kable(table(at59$ciudad, at59$objeto), caption = 'Objeto vinculado al atentado por ciudad') %>%
kable_styling(font_size =10)`

Veremos el resultado nuevamente en la ventana de visualizaciones, en la pestaña *Viewer*. Tenemos también, vía la pestaña *Export*,  la posibilidad de guardarlo como imagen *jpg* o *png*.

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-10.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

# Visualizando tablas con *ggplot2*

R se destaca por su capacidad de ilustrar conjuntos de datos. Trataremos ahora de aprovecharla en tablas como las que venimos cruzando. El paquete *ggplot2* es uno de los más usados para hacer gráficas por quienes utilizan este lenguaje. Tiene una lógica inspirada en la denominada gramática de los gráficos (the grammar of graphics), consistente en el uso de capas o *layers*, que se ajustan según parámetros que les pasamos. Un gráfico entonces es la combinación de las capas, donde cada una cumple una función determinada: sobre los datos, los aspectos estéticos de los mismos (tamaño, forma, color, etc.), los objetos geométricos que van a representar los datos (puntos, líneas, polígonos, áreas, etc), siendo estas capas esenciales que no pueden faltar. Luego, opcionalmente, se puede facetar en subgrupos, dar coordenadas, usar estadísticas y cambiar la apariencia general del gráfico.  *Ggplot2* está ya incluida en *tidyverse*, por lo que no necesitamos instalar nada nuevo.

Si la consideramos en términos abstractos, una sentencia básica de esta gramática tiene la siguiente estructura: `ggplot(datos, variables) + función geométrica`. Los datos corresponden al conjunto total que estamos manejando, y que para *ggplot2* deben estar en formato data frame. Las variables, se interpretan aquí como la expresión estética (en tanto distancia horizontal/vertical) de las columnas elegidas. La función geométrica (*geom*) nos permite elegir el objeto visual con el que se representarán los datos. Como es una lógica de capas, el signo `+` permite ir agregando todas las que consideremos necesarias para que nuestro gráfico incluya la información necesaria.

Entonces, si queremos ver gráficamente la tabla de contingencia que hicimos más arriba, haciendo la equivalencia un atentado = un *punto* en el plano, la sentencia mínima correspondiente debería ser:

`ggplot(at59, aes(x=ciudad, y=objeto)) +`

`geom_point()`

Y obtendremos este resultado:

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-10.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Para mejorar la visualización sumando diferentes etiquetas al gráfico (ponerle un título, cambiar nombre de variables, etc) le agregamos una capa con la función `labs()`. Incluso podemos cambiar la apariencia general agregando una capa con alguna de las variantes que nos provee `theme_()`, función que permite controlar los elementos del gráfico no vinculados a los datos.

Sin embargo, debemos reconocer que la acumulación de los puntos uno sobre otro en una misma coordenada (*overplotting*) redunda en una visualización muy poco aprovechable, ya que como si lo hace la tabla no llega a la representación visual de frecuencias, mostrando sólo la existencia de cruces de variables. Probaremos entonces reemplazando a `geom_point()` por otra función que contabilice el número de ocurrencias de cada combinación, para lograr una imagen que nos dé una rápida pista acerca de las variaciones en la frecuencia de los atentados. Para ello `geom_count()`, que además del efecto visual, añade al gráfico una escala de frecuencias:

`ggplot(at59, aes(x=ciudad, y=objeto)) +`

`geom_count() +`

`labs(title = “Atentados durante 1959”, subtitle= “Objeto utilizado según ciudad”, x= “CIUDAD”, y= “OBJETO”) +`

`theme_bw()`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-12.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

Otra forma de aprovechar las ventajas de visualización que da R y evitar la superposición de puntos, es utilizando la propiedad *jitter*, que afecta la posición de los puntos. La función gráfica `geom_jitter()` permite agregar una pequeña cantidad de variación  aleatoria a la ubicación de cada punto, y es muy útil cuando nos manejamos con posiciones discretas y conjuntos de datos pequeños. También para mostrar otras capacidades estéticas, vamos a pasarle como parámetro que el color de los puntos sea diferente según la ciudad, utilizando. Como el argumento debe ser en formato numérico, lo convertimos con `as.numeric()`. Además de manejar la coloración con *colour*, se pueden parametrizar por ejemplo el tamaño de los puntos con *size*, o su transparencia con *alpha*.

`ggplot(at59, aes(x=ciudad, y=objeto)) +`

`geom_jitter(colour=as.numeric(at59$ciudad)) +`

`labs(title = "Atentados durante 1959", subtitle= "Objeto utilizado según ciudad", x="CIUDAD", y="OBJETO") +`

`theme_bw()`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-13.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

# Animando la visualización de los datos con *gganimate*

Si bien existen distintas bibliotecas para animar visualizaciones en R, aquí probaremos hacerlo con *gganimate*, una extensión del paquete *ggplot2* que hace posible crear una animación a partir de un gráfico *ggplot*. De esta forma podemos ver de forma dinámica cómo nuestros datos evolucionan según estados o en el tiempo. Las funciones centrales de *gganimate* son el grupo de las transiciones  (*transition*), que interpretan los datos de la trama para distribuirlos de alguna manera específica en varios cuadros (*frames*). Al instalarlo el paquete también bajaremos *gifski*, un codificador de *gifs* que nos será útil para disponer de nuestra animación en otras plataformas:

`install.packages("gganimate")`

`install.packages("gifski")`

`library (gganimate)`

`library(gifski)`

La función `transiton_time()` es la que usaremos para mostrar una animación que represente la ocurrencia de atentados según una progresión temporal. El procedimiento es muy sencillo: se puede asignar a un objeto el código del gráfico y luego sumarle esta función, poniéndole como argumento nuestra variable temporal *fecha*. Pero a los efectos de realizar una visualización más clara de nuestros datos, nos conviene agregar al código un par de elementos.

Por un lado, como en *gganimate* la animación resultante es un conjunto de imágenes (instantáneas) desplegadas en serie consecutiva, cada nuevo frame -si no se le indica lo contrario- al mostrarse oculta el anterior y sólo lograremos ver un parpadeo de nuestros puntos. Para manejar esto, contamos con el grupo de funciones `shadow` para manejar cómo se muestran los datos que ya no son los del actual *frame*. En nuestro gráfico como queremos que permanezcan todos los datos anteriores de fondo, corresponde utilizar `shadow_mark()` acompañada del argumento que permite dejar visibles los cuadros anteriores. Por otra parte, como puede ser bastante difícil entender una animación sin ninguna indicación sobre a qué refiere cada punto temporal, *gganimate* nos proporciona un conjunto de variables (*frame variables*) para cada fotograma, que se pueden insertar en las etiquetas de los gráficos utilizando la sintaxis llamada *glue*, que utiliza los símbolos `{}`. Así podemos obtener una serie de metadatos, según la variante de transición que probemos. Para `transition_time()` contamos con `{frame_time}`, que nos retorna el valor del argumento que procesa la función durante el fotograma actual. El código quedaría entonces así:

`ggplot(at59, aes(x=ciudad, y=objeto)) + geom_jitter(colour=as.numeric(at59$ciudad), size=4) + labs(title = "Atentados durante 1959", subtitle= "Objeto utilizado según ciudad - Fecha: {frame_time}", x="CIUDAD", y="OBJETO") +
 theme_bw() +`

`transition_time(at59$fecha) +`

`shadow_mark (past = TRUE)`

Al ingresarlo directamente en la consola, comienza el denominado *rendering* -proceso de generación de la animación- que tiene duración relativa, en nuestro caso sólo serán unos segundos:

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-14.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```
Y en la pestaña *Viewer* de la ventana de utilidades podremos observar la animación. Si presionamos el ícono *Show in the new window*, abrirá un *gif* en el navegador asociado por defecto, que podremos almacenar.

De todas maneras, lo recomendable no sería no entrar el código directamente por la consola, sino asignarlo a un objeto, pues nos deja la posibilidad de manejar la velocidad y pausa en la animación con la función `animate()`. Se pueden ajustar la cantidad total de *frames*, la duración en segundos y los *frames* por segundo entre otras cosas. Para probar el último y hacer más interpretable Con `fps` le damos un parámetro de 5/seg. y también le añadiremos una pausa final de 15 segundos con `end_pause`:


`atentados<-ggplot(at59, aes(x=ciudad, y=objeto)) +`

`geom_jitter(colour=as.numeric(at59$ciudad), size=4) +`

`labs(title = "Atentados durante 1959", subtitle= "Objeto utilizado según ciudad - Fecha: {frame_time}", x="CIUDAD", y="OBJETO") +`

`theme_bw() +`

`transition_time(at59$fecha) + shadow_mark(past = TRUE)`

`animate(atentados, fps = 5, end_pause = 15)`

```
{% include figure.html filename="visualización-y-animación-de-datos-tabulares-con-R-15.jpg" caption="LEYENDA O PIE DE IMAGEN CON \"CARACTER DE ESCAPE\" PARA LAS COMILLAS/CITAS" %}
```

*Si bien con los gráficos estáticos podíamos ya ver similitudes entre Avellaneda y La Plata, tanto entre las frecuencias de los atentados como de su tipo (en tanto objeto utilizado), ahora disponemos del ritmo (intensidad) de los mismos, lo que nos permite enfocar sobre posibles patrones o relaciones de corte más histórico, entre casos que no suelen estar conectados, por su diferente estructura socio-económica de la época.*

# Conclusión

Esta lección buscó darles una idea de la cantidad de tareas que deberían hacer para preparar y realizar un primer análisis exploratorio si disponen de alguna serie de datos históricos y les interesa con muy poco esfuerzo hacer unos cálculos básicos con ellos y volcarlos visualmente, para pensar, preguntarse e hipotetizar sobre ellos.

Se ha planteado como un puntapié inicial, cruzando sólo un par de variables, quedando para los lectores el resto para probar, y también el animarse a llegar directamente con la fuente (https://gganimate.com/index.html) y descubrir por sí mismos la potencia de *ggplot* y *gganimate*.


# Notas
[^1] Floud, Roderick (1983). *Métodos cuantitativos para historiadores*. Madrid: Alianza Editorial.
[^2] Pueden encontrar una detallada referencia del archivo en el sitio de la Comisión Provincial por la Memoria de la provincia de Buenos Aires: (https://www.comisionporlamemoria.org/extra/archivo/cuadroclasificacion/)
