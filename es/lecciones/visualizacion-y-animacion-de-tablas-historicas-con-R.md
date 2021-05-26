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

Esta lección te mostrará cómo cruzar, graficar y animar un conjunto de datos históricos. Aprenderás a importar en *RStudio* una tabla disponible en una hoja de cálculo y a utilizar funciones que te permitan transformar esos datos para representarlos como una tabla de contingencia. También sabrás cómo utilizar funciones de nuevas librerías que te permitirán visualizar tus datos cruzados en forma gráfica e inclusive llegar a animarlos en perspectiva temporal.  

# Objetivos

Con esta lección aprenderás a: 
1.  Ordenar y transformar tablas históricas para realizar análisis exploratorios.
2.  Generar gráficos estáticos y animados para visualizar datos históricos.

# Introducción

Es indudable que entre los historiadores predomina el tratamiento cualitativo de los documentos y fuentes que el pasado nos ha legado. Pero, como ha señalado Roderick Floud, “aunque estemos básicamente más interesados en las cuestiones ‘cualitativas’ que en las ‘cuantitativas’, ambas están inextricablemente unidas”[^1]. Es decir, no compiten, no se reemplazan, sino que se complementan. Una forma de combinar ambas metodologías, es a través de la búsqueda de regularidades o patrones ocultos o a la inversa, de anomalías, acercando a quienes hacen investigación histórica a un mejor conocimiento de las coordenadas donde situar sus interpretaciones. Y si esa comprensión global de los datos puede visualizarse gráficamente, posibilita “que el investigador descubra fácilmente relaciones, similitudes y diferencias entre sus casos”. Desde que escribió Floud -a mediados de los años ‘70- la tecnología informática y la programación han avanzado de tal manera que hacen muy fácil el cruce entre perspectivas metodológicas. De esta manera, si un trabajo histórico cualitativo apunta a profundizar aspectos de fenómenos que sucedieron en el pasado, uno cuantitativo te permitirá saber con qué frecuencia sucedieron, observar patrones y anomalías, y a establecer las relaciones temporales existentes entre las diferentes categorías de análisis existentes.

Quien se propone hacer un análisis histórico cuantitativo, debe partir de un ejercicio de codificación de las fuentes documentales que el pasado nos ha legado, y plasmarlas en una matriz de datos. Es decir, demanda un proceso de conversión de nuestras fuentes de información, para transformar los datos textuales (palabras) en datos simbólicos operables digitalmente (números). Lo anterior consta de varias pasos: 1) *clasificar* los documentos a los que se ha accedido de forma que permitan su puesta en común según criterios determinados, 2) *categorizar* descriptiva, interpretativa o analíticamente, con ideas, categorías o conceptos el contenido de las fuentes, 3) *codificar*, poniendo a las distintas expresiones particulares de cada caso un símbolo (números, palabras), 4) *tabular*, es decir representar los casos organizados en forma de una matriz en un soporte informático, habitualmente una hoja de cálculo.

En esta lección te mostraremos una de las tantas formas en que se pueden analizar cuantitativamente archivos que reúnen información sistemática y seriada (como son casos de productores de documentación permanente como el Estado, empresas o la prensa) utilizando el lenguaje R. El objetivo es que adquieras conocimientos que te permitan efectuar un análisis exploratorio de datos inicial, trabajando principalmente la distribución de frecuencias de distintas variables a través de tablas de contingencia, visualizarlas, generar gráficos, y finalmente crear una animación de los mismos en perspectiva temporal. 

# Requisitos

Esta lección requiere que cuentes con nociones básicas de R, que tratan las lecciones [Datos tabulares en R](https://programminghistorian.org/es/lecciones/datos-tabulares-en-r) de Trayn Dewar y [Administración de datos en R](https://programminghistorian.org/es/lecciones/administracion-de-datos-en-r) de Nabeel Siddiqui.

Además del lenguaje R, deberás tener instalado el entorno de desarrollo RStudio. Si no lo tienes, este tutorial te ayudará a hacerlo: [https://www.youtube.com/watch?v=Nmu4WPdJBRo](https://www.youtube.com/watch?v=Nmu4WPdJBRo)

# Los datos explorados

El conjunto de datos que aquí se presenta servirá para que veas cómo R te puede ayudar a analizar dinámicas de la violencia política en Argentina a finales de la década de 1950, a partir de documentos policiales de espionaje. Habitualmente estos archivos de inteligencia se han utilizado para el estudio histórico de casos particulares, pero rara vez se ha apuntado a lograr grados de agregación que permitan hacer *comparaciones* entre distintos casos. Contar con algunos elementos básicos de programación facilita dar pasos en esa dirección.

La fuente que te proponemos codificar es un legajo muy especial del archivo de la ex Dirección de Inteligencia de la Policía de Buenos Aires (Argentina): contiene varios informes de inteligencia que contabilizan ‘actos terroristas’ durante los años del período de conflictividad política y social que se conoce en la historia argentina como ‘Resistencia peronista’[^2]. Lo interesante es que la información cruda se presenta de una manera que facilita su tabulación:

![](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/images/visualizacion-y-animacion-de-tablas-historicas-con-R/visualizacion-y-animacion-de-tablas-historicas-con-R-legajo.jpg?raw=true)

Este documento fue transformado en un conjunto de datos procesables cuantitativamente. Se construyó una *tabla* a partir información sobre algunas localidades de la provincia de Buenos Aires en 1959, año en el que el número de 'actos terroristas' o atentados fue muy alto. Los datos representan los valores de ciertas *variables* de análisis comunes a todos los registros, como son la *ciudad* (dónde) y la *fecha* del atentado (cuándo). Desde la información descriptiva de la policía (atributos del atentado), fue posible generar variables como: *objeto* utilizado en el atentado (con qué elemento se realizó), *sitio* (lugar/espacio) y *objetivo* (contra quién). Con esta categorización, buscamos ahorrar un paso, ya que se ingresan los datos limpios y ordenados según los preceptos *tidy data*: cada variable forma una columna, cada observación forma una fila, cada valor debe tener su propia celda, cada tipo de unidad observacional forma una tabla[^3].

| fecha | ciudad | objeto | sitio | objetivo |
| :----------: | :----------: | :----------: | :----------: | :----------:|
| 18/01/1959 | La Plata | bomba | sede | institucion extranjera |
| 19/01/1959 | La Plata | petardo | vias ffcc | ferrocarril |
| 19/01/1959 | Matanza | bomba | vias ffcc | ferrocarril |
| 20/01/1959 | Avellaneda | molotov | comercio | comercio |
| 20/01/1959 | Avellaneda| bomba | vias ffcc | ferrocarril |
| 20/01/1959 | Lomas | bomba | vias ffcc | ferrocarril |
| 20/01/1959 | Matanza | bomba | vias ffcc | ferrocarril |

La tabla correspondiente a los atentados en cinco ciudades durante 1959, está disponible en formato de hoja de cálculo: [atentados1959.xlsx](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/visualizacion-y-animacion-de-tablas-historicas-con-R/atentados1959.xlsx)


# Tratamiento y limpieza de los datos con R

En esta sección te mostraremos cómo cargar los datos en RStudio para comenzar a procesarlos. No esperes estar listo para trabajar una vez importada la hoja de cálculo, pues siempre será necesaria una adecuación de tus datos para que R pueda interpretarlos. En lo que atañe a este caso, por ejemplo, luego de importarlos deberás asignarle un tipo a las variables, convertirlas, hacer algunas modificaciones en los datos y luego ordenarlos temporalmente.

El primer paso será importarlos desde su formato de hoja de cálculo al entorno de RStudio. Para poder hacerlo, primero deberás instalar el *package* (paquete) que te dará los recursos necesarios: *readxl*[^4]. La instalación se hace por defecto desde el repositorio CRAN, lo que ejecutarás a través de la consola de RStudio. Harás lo mismo con la colección de paquetes *tidyverse*[^5], una de las más utilizados para el tipo de análisis que te proponemos, ya que permite realizar fácilmente tareas tales como leer, transformar, tratar, manipular, organizar y visualizar distinto tipo de datos, y contiene varios de los paquetes que necesitaras luego:

```
install.packages("readxl")
install.packages("tidyverse")
```

A continuación, para cargar el paquete al entorno R:

```
library(readxl)
library(tidyverse)
```

Ahora estás en condiciones de importar el dataset, usando la función ´read_excel()´. Deberás pasarle como argumento la ruta y nombre donde almacenaste la hoja de cálculo y de paso lo dejarás asignado a un nuevo objeto con un nombre abreviado, como *at59*:

```
at59 <- read_excel("C:/Users/X/Documents/R/atentados1959.xlsx")
```

Es fundamental entender en qué forma fue almacenada la información. En *R* todo es un *objeto*, por lo tanto,los datos importados serán transformados como tal, en este caso, del tipo *estructura de datos*. *R* maneja varias estructuras que se diferencian por tener distinta cantidad de dimensiones y por si pueden guardar o no datos de diverso tipo. La más conocida es el *vector*, que es una colección de una dimensión de datos de igual tipo. Otra estructura es la *matriz*, que es similar al vector, pero permite trabajar en dos dimensiones. 

Además, *R* cuenta con una forma particular de estructura de datos, la cual tiene dos dimensiones y nos da la posibilidad de contener datos de distinto tipo (enteros junto a fechas, caracteres, etcétera). Esta estructura es denominada *data frame*, y se compone por filas y columnas; cada fila corresponde a una observación o registro, mientras que cada columna es un vector que representa una variable de análisis. El *data frame* es una de las estructuras más utilizadas en *R* y los datos al ser importados, se almacenarán de esta manera. Muchas funciones al aplicarse en un *data frame* -como *readxl()*- devuelven un objeto *tibble*, que también es un *data frame*, pero con características mejoradas de visualización de datos. Esto lo podrás apreciar al usar la función `head()`, la cual te permitirá ver sólo los primeros registros del mismo y te indicarán el tipo de dato utilizado debajo del nombre de la variable: la fecha en formato *datatime* (fecha y hora) y el resto de las columnas como *character* (carácter).

```
> head(at59)
# A tibble: 6 x 5
  fecha               ciudad          objeto  sitio       objetivo 
  <dttm>              <chr>           <chr>   <chr>       <chr>    
1 1959-06-23 00:00:00 Almirante Brown bomba   via publica ns       
2 1959-06-30 00:00:00 Almirante Brown bomba   domicilio   ns       
3 1959-07-30 00:00:00 Almirante Brown bomba   domicilio   ns       
4 1959-08-02 00:00:00 Almirante Brown bomba   domicilio   ns       
5 1959-09-15 00:00:00 Almirante Brown bomba   taller      industria
6 1959-01-20 00:00:00 Avellaneda      molotov comercio    comercio 
```

Con la tabla ya cargada en *RStudio* puedes empezar el tratamimiento de los datos para poder trabajar con ellos. Así, por ejemplo, podemos partir reemplazando determinados valores de la estructura de datos para corregir o cambiar contenidos masivamente. Para tal efecto, una de las maneras que ofrece R es a través de la función `ifelse()`, la cual te permite seleccionar elementos de una estructura de datos según se cumpla o no alguna condición, operando globalmente sobre ella, ya que aprovecha la vectorialización del lenguaje R -al aplicar una función a un objeto, la hace efectiva sobre todos sus elementos- y evita la necesidad del uso de bucles (`for` o `while`, por ejemplo) para recorrer las filas. Lo recomendable es que hagas estas operaciones sobre los datos antes de realizar alguna conversión sobre su tipo.

Supon que deseas reemplazar todos los casos donde el *objeto* figura como ‘bomba’, por el término ‘explosivo’. Para tal efecto puedes utilizar la función `ifelse()` pasándole sólo tres argumentos. Primero se vuelca la condición a cumplir, tomando la variable correspondiente, en este caso los valores ‘bomba’ de la columna *objeto* de *at59*, que es seleccionada con el símbolo `$`. El segundo argumento refiere a lo que la función asignará en el caso de cumplirse: lo reemplazará por ‘explosivo’. El tercer argumento, es el valor asignado en el caso negativo y aquí lo dejarás equivalente al valor original:

```
at59$objeto <- ifelse(at59$objeto == "bomba", "explosivo", at59$objeto)
```

Si te arrepientes de los cambios, puedes hacer la misma operación pero a la inversa:

```
at59$objeto <- ifelse(at59$objeto == "explosivo", "bomba", at59$objeto)
```

A continuación, te convendrá transformar el *tipo* de los datos para que puedan ser interpretados por el lenguaje, lo que también te permitirá aprovechar mejor las funciones de visualización. Primero, puedes comenzar por adecuar las fechas -no interesa que tengan la hora- de manera muy sencilla utilizando la función `as.Date()` sobre la columna *fecha*. Segundo, puedes transformar el resto de las variables de análisis a *factor*, que es el tipo de dato que brinda *R* para trabajar con *variables categóricas* (las que representan un conjunto fijo y conocido de valores posibles). A continuación deberías hacer algo idéntico con cada una las cuatro columnas restantes (*ciudad, objeto, sitio* y *objetivo*) al aplicarles la función `factor ()`. Esto implica que escribas cinco sentencias (una por cada variable), con una sintáxis `variable <- función(variable)`. Si te interesa practicar escritura de código prolijo, uno de sus preceptos apunta a evitar la repetición de sentencias si no son necesarias, y aprovechar el potencial que brinda el lenguaje que estemos utilizando para resolverlo. En el caso de *R* puedes hacerlo de otra manera muy sencilla, con funciones que permiten aplicar de manera generalizada otras funciones a una estructura de datos.

Entre diversas opciones, te invitamos a usar a `map_df()` del paquete *purrr*[^6] (incluido en *tidyverse*), que te permite asignar una función -en este caso será una para cambiar el tipo de datos- a diversos elementos de un *data frame*, y que almacena el resultado en un objeto de esta misma clase. Como argumento de la función, se envía en primer término el nombre de las columnas -en un formato vectorizado con `c()`- y luego la función que quieras aplicar a dicha columna. Para unificar el código en sólo una sentencia, reúne las dos transformaciones con la función `tibble()`, lo que te dará como resultado un *tibble* con las columnas organizadas y convertidas tal como estaban originalmente:

```
at59 <- tibble(map_df(at59[,c('fecha')], as.Date), map_df(at59[,c('ciudad','objeto','sitio','objetivo')], factor))
```

Para finalizar esta etapa de limpieza y transformación de los datos, es necesario ordenarlos. Para ello dispones de la función `arrange()`, del paquete *dplyr*[^7] (tambien parte de *tidyverse*), que te permitirá reordenar las filas del *data frame*. Por defecto lo hace de forma ascendente, aunque debes tener en cuenta que la mayoría de las funciones en R son parametrizables y nos permiten variaciones; la cuestión es buscar y explorar la documentación de las funciones, fácilmente accesible en la web. En este caso, la función pide que pases como primer argumento la estructura de datos y en segundo lugar la variable que será el criterio ordenador. Si lo haces por fecha deberás ingresar:

```
at59 <- arrange(at59, fecha)
```

Con `head()` podrás apreciar cómo quedó reorganizado y listo tu conjunto de datos para que comiences ahora sí a analizarlos
```
# A tibble: 6 x 5
  fecha      ciudad     objeto  sitio     objetivo              
  <date>     <fct>      <fct>   <fct>     <fct>                 
1 1959-01-18 La Plata   bomba   sede      institucion extranjera
2 1959-01-19 La Plata   petardo vias ffcc ferrocarril           
3 1959-01-19 Matanza    bomba   vias ffcc ferrocarril           
4 1959-01-20 Avellaneda molotov comercio  comercio              
5 1959-01-20 Avellaneda bomba   vias ffcc ferrocarril           
6 1959-01-20 Lomas      bomba   vias ffcc ferrocarril 
```

# Explorando los datos

A continuación realizaremos un *análisis exploratorio* elemental de nuestros datos históricos, con el fin de encontrar relaciones entre los casos locales. La idea de este tipo de metodología es identificar las principales características de un conjunto de datos (en tanto patrones, diferencias, tendencias, anomalías, discontinuidades y distribuciones) con el objetivo de conocer su *variabilidad*. Al representar dicha variabilidad de manera numérica, y sobre todo en forma de gráficos y visualizaciones, el análisis exploratorio de datos se transforma en un medio para desarrollar nuevas perspectivas analíticas, preguntas o hipótesis: con una breve mirada, podemos estar al tanto de concentraciones de datos, valores atípicos, saltos, etcétera.

Con nuestra base de datos, vamos a trabajar con una de las formas primarias en que se manifiesta la variabilidad en la información: la *distribución de frecuencias*. Lo haremos en modo bivariado, es decir, veremos cómo se pueden construir *tablas de contingencia* que contabilicen los casos resultantes del cruce de dos variables dentro del conjunto de los atentados efectuados durante 1959.

Para tal efecto, cuentas con una sencilla función denominada `table()`, que toma variables tipo factor como parámetros, y regresa la frecuencia de aparición de las categorías de la variable. Un aspecto interesante de esta función es que también te permite pasarle una sola columna como argumento. Por ejemplo, si quieres saber cuántos atentados hay por ciudad puedes conocer la cifra con la sentencia:
```
table(at59$ciudad)

Almirante Brown      Avellaneda        La Plata           Lomas         Matanza 
              5              54              52               9              14
```

Si quieres empezar a probar las capacidades gráficas que te da *R*, puedes transformar esa tabla de una dimensión en un cuadro de barras, con una función base llamada `barplot()`, aplicando como parámetro la función:

```
barplot(table(at59$ciudad))
```

Verás aparecer en la pestaña *Plots* de la ventana de utilidades el siguiente gráfico:

![](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/images/visualizacion-y-animacion-de-tablas-historicas-con-R/visualizacion-y-animacion-de-tablas-historicas-con-R-barplot.jpg?raw=true)

Para analizar posibles relaciones entre variables y categorías, es muy sencillo confeccionar una tabla de contingencia. A la función `table()` aplicas como argumento las dos columnas que te interesen cruzar. Por ejemplo, si quieres saber con qué tipo de elementos u objetos se perpetraron los atentados según la ciudad de ocurrencia del hecho, deberías ingresar a la consola :

```
table(at59$ciudad, at59$objeto)
          
                  alquitran bomba armas de fuego bomba liquido inflamable molotov petardo proyectil
  Almirante Brown               0              0     5                  0       0       0         0
  Avellaneda                    1              0    40                  1       5       7         0
  La Plata                      2              1    37                  0       4       7         1
  Lomas                         0              1     5                  2       1       0         0
  Matanza                       0              0    12                  0       2       0         0
```
Existen muchas formas de hacer más amigable la visualización de tablas de contingencia utilizando diversas librerías disponibles en *CRAN*. Una que sin ser complicada te dará unos cuadros mejorados estéticamente es *kableExtra*[^8]. El procedimiento tiene dos partes: primero debes darle formato *html* a la tabla con la función `kable()` y almacenarla en una variable (por ejemplo *at59k*), y con este argumento llamar a `kable_styling()`, lo que te permitirá visualizar la tabla y manejar varios atributos de estilo, tal como el tamaño de letra. Dicho esto, prueba instalar, cargar y probar el paquete, sumando al cuadro un título:

```
install.packages("kableExtra")
library(kableExtra)
at59k <- kable(table(at59$ciudad, at59$objeto), caption = 'Objeto vinculado al atentado por ciudad')
kable_styling(at59k, font_size = 10)
```
Verás el resultado nuevamente en *Viewer* y tendrás la posibilidad de guardarlo como imagen *jpg* o *png*, por medio de la pestaña *Export*.

![](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/images/visualizacion-y-animacion-de-tablas-historicas-con-R/visualizacion-y-animacion-de-tablas-historicas-con-R-kable.jpg?raw=true)

# Visualizando tablas con *ggplot2*

Como te hemos mostrado con las tablas generadas en esta lección, R se destaca por su capacidad para ilustrar conjuntos de datos. El paquete *ggplot2*[^9] es uno de los más usados para hacer gráficas por quienes utilizan este lenguaje. Tiene una lógica inspirada en la denominada gramática de los gráficos (*the grammar of graphics*)[^10], la cual consiste en el uso de capas o *layers*, que se ajustan según determinados parámetros. Un gráfico es la combinación de las capas, donde cada una cumple una función determinada sobre los datos, sus aspectos estéticos (tamaño, forma, color, etc.), los objetos geométricos que van a representar los datos (puntos, líneas, polígonos, áreas, etc.); estas capas son esenciales, es decir, no pueden faltar. Opcionalmente, es posible sumar otras capas que puedes facetar en subgrupos, dar coordenadas, usar estadísticas y cambiar la apariencia general del gráfico. *ggplot2* estáincluida en *tidyverse*, por lo tanto no necesitas realizar instalaciones adicionales.

En términos abstractos, una sentencia básica de esta gramática tiene la siguiente estructura: `ggplot(datos, variables) + función geométrica`. Los datos corresponden al conjunto total que estamos manejando, y que para *ggplot2* deben estar en formato *data frame*. Las variables se interpretan aquí como la expresión estética (en tanto distancia horizontal/vertical) de las columnas elegidas. La función geométrica (*geom*) nos permite elegir el objeto visual con el que se representarán los datos. Como es una lógica de capas, el signo `+` permite ir agregando todas las que consideres necesarias para que tu gráfico incluya la información que consideres relevante.

Si deseas ver gráficamente la tabla de contingencia que construiste anteriormente, puedes empezar haciendo la equivalencia de un atentado = un *punto* en el plano, a lo que correspondería la sentencia mínima:

```
ggplot(at59, aes(x = ciudad, y = objeto)) +
geom_point()
```

Y obtendrás este resultado:

![](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/images/visualizacion-y-animacion-de-tablas-historicas-con-R/visualizacion-y-animacion-de-tablas-historicas-con-R-point.jpg?raw=true)

Sin embargo, debe reconocerse que la acumulación de puntos, uno sobre otro, en una misma coordenada (*overplotting*), da como resultado en una visualización muy poco aprovechable, ya que -como sí lo hace la tabla- no llega a la representación visual de frecuencias, y sólo muestra la existencia de cruces de variables. Para esto es recomendable reemplazar la función `geom_point()` por otra que contabilice el número de ocurrencias de cada combinación; una imagen que te dé una pista rápida sobre las variaciones en la frecuencia de los atentados. Para ello está disponible `geom_count()`, que además del efecto visual, añade al gráfico una escala de frecuencias.

Si te interesa además enriquecer la visualización mediante la adición de etiquetas al gráfico (ponerle un título, cambiar nombre de variables, etcétera), puedes agregar una capa mediante la función `labs()`. Incluso, puedes cambiar la apariencia general si agregas una capa con alguna de las variantes que te provee `theme_()`, función que permite controlar los elementos del gráfico no vinculados a los datos.

```
ggplot(at59, aes(x = ciudad, y = objeto)) +
geom_count() +
labs(title = 'Atentados durante 1959', subtitle = 'Objeto utilizado según ciudad', x = 'CIUDAD', y = 'OBJETO') +
theme_bw()
```

![](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/images/visualizacion-y-animacion-de-tablas-historicas-con-R/visualizacion-y-animacion-de-tablas-historicas-con-R-count.jpg?raw=true)

Para almacenar el gráfico en un archivo, cuentas con la función `ggsave()`, que guardará tu imagen en el directorio de trabajo (lo puedes averiguar con `getwd()`):

```
ggsave("archivo.png")
```

Otra forma de aprovechar las ventajas de visualización que te da R y evitar la superposición de puntos, es utilizando la propiedad *jitter*, que afecta la posición de los mismos. La función gráfica `geom_jitter()` te permite agregar una pequeña variación aleatoria a la ubicación de cada punto; esto es muy útil si trabajas posiciones discretas y conjuntos de datos pequeños. Para explorar otras capacidades estéticas, por ejemplo prueba aplicar como parámetro que el color de los puntos sea diferente según la ciudad, esto mediante `colour`. Como el argumento debe ser en formato numérico, debes convertirlo con `as.numeric()`. Además de establecer la coloración, tienes la posibilidad de manipular el tamaño de los puntos mediante `size`,  su transparencia con `alpha`, y la distancia interpuntos vertical u horizontal con `width` o `height`.

```
ggplot(at59, aes(x = ciudad, y = objeto)) +
geom_jitter(colour = as.numeric(at59$ciudad), size = 3) +
labs(title = "Atentados durante 1959", subtitle = "Objeto utilizado según ciudad", x = "CIUDAD", y = "OBJETO") +
theme_bw()
```

![](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/images/visualizacion-y-animacion-de-tablas-historicas-con-R/visualizacion-y-animacion-de-tablas-historicas-con-R-jitter.jpg?raw=true)

# Animando la visualización de los datos con *gganimate*

Si bien existen distintas bibliotecas para animar visualizaciones en R, te invitamos a hacerlo con *gganimate*[^11], la cual es una extensión del paquete *ggplot2* que te permitirá crear una animación a partir de un gráfico *ggplot* y ver de forma dinámica cómo tus datos evolucionan según estados (variables) o en el tiempo. Las funciones centrales de *gganimate* son el grupo de las transiciones  (*transition*), que interpretan los datos de la trama para distribuirlos según algún criterio específico en varios cuadros (*frames*). Para instalar y activar el paquete:

```
install.packages("gganimate")
library (gganimate)
```
Si deseas generar una animación que represente la ocurrencia de atentados según una progresión temporal, la función indicada es `transiton_time()`. El procedimiento es muy sencillo; al código que escribiste para hacer el gráfico le sumas esta función, poniendo como argumento la variable temporal *fecha*. Pero, para los efectos de realizar una visualización más clara de tus datos, es conveniente que al código le agregues un par de elementos.

Por un lado, como en *gganimate* la animación resultante es un conjunto de imágenes (instantáneas) desplegadas en serie consecutiva, cada nuevo *frame* -si no le indicas lo contrario- al mostrarse oculta el anterior y sólo lograrás ver puntos parpadeando. Para manejar esto, cuentas con el grupo de funciones *shadow*, que te deja elegir cómo se muestran los datos que ya no se corresponden con los del *frame* actual. En el caso de este gráfico, para que permanezcan todos los datos anteriores de fondo, es necesario utilizar `shadow_mark()` acompañada del argumento que te permite dejar visibles los cuadros anteriores. Por otra parte, como puede ser bastante difícil entender una animación sin ninguna indicación sobre el significado de cada punto temporal, *gganimate* te proporciona un conjunto de variables (*frame variables*) para cada fotograma, los cuales puedes insertar en las etiquetas de los gráficos utilizando la sintaxis llamada *glue*, que utiliza los símbolos `{}`. Con ello dispondrás de una serie de metadatos, según la variante de transición que ensayes. Para `transition_time()` cuentas con `{frame_time}`, que te retornará el valor del argumento que procesa la función durante el fotograma en curso. El código quedaría de esta manera:

```
ggplot(at59, aes(x = ciudad, y = objeto)) +
geom_jitter(colour = as.numeric(at59$ciudad), size = 4) +
labs(title = "Atentados durante 1959", subtitle = "Objeto utilizado según ciudad - Fecha: {frame_time}", x = "CIUDAD", y = "OBJETO") +
theme_bw() +
transition_time(at59$fecha) +
shadow_mark (past = TRUE)
```

Al ingresar el código directamente en la consola, comienza el proceso  de generación de la animación, denominado *rendering*. Este proceso tiene una duración relativa, en este caso sólo serán unos segundos. Cuando concluya, en la pestaña *Viewer*, de la ventana de utilidades, podrás observar la animación. Si presionas el ícono *Show in the new window*, se abrirá un *gif* en el navegador asociado por defecto, que podrás almacenar. En caso de que te interese continuar practicando con la consola, puedes crear el *gif* de la última animación realizada con la función `anim_save()`, que será guardado en el directorio de trabajo:

```
anim_save(archivo.gif)
```

Ahora bien, es recomendable que no ejecutes el código *ggplot* directamente por la consola, sino que lo asignes a un objeto, ya que esto te dará la posibilidad de manejar velocidad y pausas en la animación por medio de la función `animate()`. Con ella podrás ajustar, entre diversos parámetros, la cantidad total de *frames*, la duración total y los *frames* por segundo. Para ensayarlo, dale a `fps` un parámetro de 5 cuadros por segundo y añade una pausa final de 15 segundos con `end_pause`:

```
atentados <- ggplot(at59, aes(x = ciudad, y = objeto)) +
geom_jitter(colour = as.numeric(at59$ciudad), size = 4) +
labs(title = "Atentados durante 1959", subtitle = "Objeto utilizado según ciudad - Fecha: {frame_time}", x = "CIUDAD", y = "OBJETO") +
theme_bw() +
transition_time(at59$fecha) + shadow_mark(past = TRUE)
animate(atentados, fps = 5, end_pause = 15)
```

![](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/images/visualizacion-y-animacion-de-tablas-historicas-con-R/visualizacion-y-animacion-de-tablas-historicas-con-R-animacion.gif?raw=true)

A esta altura y con estos resultados, puedes considerar que has realizado un análisis exploratorio de tus datos y estas en condiciones de plantear hipótesis al respecto. En el caso trabajado, y si te dedicas a la historia de las luchas sociales y políticas en Argentina contemporánea, las tablas de contingencia y los gráficos estáticos trabajadas en esta lección, por ejemplo, te permiten encontrar similitudes entre Avellaneda y La Plata, tanto entre las frecuencias de los atentados, como de su tipo (en tanto objeto utilizado). Además disponemos del ritmo temporal (intensidad) de los mismos, lo que te invita a enfocar sobre posibles patrones o relaciones de corte más histórico, entre casos que no suelen estar conectados en las investigaciones, por su diferente estructura socio-económica para la época.

# Conclusión

Esta lección buscó darte una idea de las diversas tareas que deberías hacer para preparar y llevar adelante un primer análisis exploratorio de datos sobre alguna serie de documentos históricos. De manera sencilla, puedes realizar cálculos básicos con ellos y analizarlos visualmente, para pensar, preguntarte e hipotetizar sobre ellos.

En esta lección te hemos ofrecido sólo un punto de partida para el análisis de tus tablas históricas, trabajando con el cruce de tan sólo un par de variables. Como desafío, y a partir de lo que aprendiste en este tutorial, te proponemos que continúes probando variantes. Finalmente, te invitamos a que te animes a trabajar directamente con la fuente (https://gganimate.com/index.html) y descubrir por ti mismo la potencia de *ggplot* y *gganimate*.


# Notas

[^1]: Roderick Floud (1983). *Métodos cuantitativos para historiadores*. Alianza Editorial. Madrid.

[^2]: Pueden encontrar una detallada referencia del archivo en el sitio de la Comisión Provincial por la Memoria de la provincia de Buenos Aires: (https://www.comisionporlamemoria.org/extra/archivo/cuadroclasificacion/)

[^3]:Los fundamentos y significado de los 'datos ordenados' puedes encontrarlos en: [http://vita.had.co.nz/papers/tidy-data.pdf](http://vita.had.co.nz/papers/tidy-data.pdf)

[^4]: Hadley Wickham and Jennifer Bryan (2019). readxl: Read Excel Files. R package version 1.3.1. https://CRAN.R-project.org/package=readxl

[^5]: Hadley Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source Software, 4(43), 1686, https://doi.org/10.21105/joss.01686

[^6]: Lionel Henry and Hadley Wickham (2020). purrr: Functional Programming Tools. R package version 0.3.4. https://CRAN.R-project.org/package=purrr

[^7]: Hadley Wickham, Romain François, Lionel Henry and Kirill Müller (2021). dplyr: A Grammar of Data Manipulation. R package version 1.0.4. https://CRAN.R-project.org/package=dplyr

[^8]: Hao Zhu (2021). kableExtra: Construct Complex Table with 'kable' and Pipe Syntax. R package version 1.3.2. https://CRAN.R-project.org/package=kableExtra

[^9]: Hadley Wickham (2016). ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag. New York. https://cran.r-project.org/web/packages/ggplot2/index.html

[^10]: El referente del concepto es Leland Wilkinson, con su obra *The Grammar of Graphics*, de la que puedes consultar algunas páginas en: [https://www.springer.com/gp/book/9780387245447](https://www.springer.com/gp/book/9780387245447)

[^11]: Thomas Lin Pedersen and David Robinson (2020). gganimate: A Grammar of Animated Graphics. R package version 1.0.7. https://CRAN.R-project.org/package=gganimate
