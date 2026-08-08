---
title: "Visualización de juicios de aceptabilidad con tidyplots y ggplot2: gráficos rápidos e interpretables para la adquisición de segundas lenguas"
slug: visualizacion-juicios-aceptabilidad-tidyplots-ggplot2
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Zuzana Nadova
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/711
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introducción y motivación

La adquisición de segundas lenguas (ASL) es un campo de investigación en el que los investigadores recogen con frecuencia datos en forma de tareas de [juicios de aceptabilidad](https://perma.cc/H3NQ-2LXT) en las cuales los aprendientes de una L2 y los hablantes nativos evalúan distintos tipos de estímulos lingüísticos, dependiendo del objetivo del experimento (i.e., según qué fenómeno lingüístico se está poniendo a prueba). Los estímulos evaluados pueden ser oraciones aisladas, continuaciones de oración, pares mínimos, mini-discursos, diálogos, estímulos audiovisuales (por ejemplo vídeos cortos y frases que describen las escenas) y los participantes evalúan su aceptabilidad gramatical, naturalidad, coherencia discursiva, plausibilidad semántica, interpretabilidad en contexto o adecuación pragmática. Estos datos son ricos en información, pero también muy complejos porque presentan distribuciones asimétricas, alta variabilidad entre participantes e interacciones entre múltiples variables lingüísticas e individuales. Visualizarlos de forma clara y reproducible es, por tanto, un paso esencial antes de cualquier análisis estadístico. 

### ¿Por qué visualizar juicios de aceptabilidad?

Uno de los tipos de juicios de aceptabilidad más utllizado en ASL consiste en presentar a los participantes una serie de  estímulos lingüísticos y pedirles que evalúen su aceptabilidad mediante una [escala de Likert](https://perma.cc/4BB7-SWES ) con un número finito de puntos ordenados (p. ej., del 1 al 7), cuyos extremos están etiquetados para indicar los números mínimo y máximo de aceptabilidad. En este contexto, el juicio de aceptabilidad es un valor numérico que por sí solo proporciona información limitada y adquiere significado únicamente cuando lo analizamos en relación con el conjunto de datos. El análisis nos permite examinar si existen diferencias entre aprendientes de una L2 y hablantes nativos, entre aprendientes con distintos niveles de la L2 o en función de variables individuales, como la edad de adquisición, los años de exposición a la L2, o el contexto de aprendizaje. Asimismo, permite determinar si los juicios tienden a concentrarse en los extremos de la escala o, por el contrario, alrededor de los valores centrales. Aunque las tablas de medias y otras medidas de tendencia central responden parcialmente a estas preguntas, no reflejan la variabilidad ni la forma de la distribución de las respuestas. Las representaciones gráficas complementan esta información al ofrecer una visión más completa de los datos. Por ejemplo, un gráfico de violín muestra simultáneamente la distribución, la densidad y la dispersión de los juicios de aceptabilidad, mientras que un diagrama de dispersión facilita la exploración de la relación entre los juicios y variables continuas, como los años de aprendizaje y la exposición a la L2. 

### Características de los juicios de aceptabilidad en ASL

Los juicios de aceptabilidad presentan varias características que condicionan su visualización:

- Naturaleza ordinal: las respuestas son categorías ordenadas (1, 2, 3, 4, 5, 6, 7), no distancias iguales entre valores continuos 
- Variabilidad interindividual elevada: los aprendientes con el mismo nivel de competencia pueden diferir considerablemente en sus juicios 
- Estructura de medidas repetidas: cada participante evalúa múltiples ítems, lo que crea dependencia en los datos 
- Diferencias individuales relevantes: variables como la edad de adquisición (AoA), los años de aprendizaje o el tipo de instrucción recibida (clases de ELE vs. instrucción bilingüe) modulan los juicios.

### Objetivos de la lección
Esta lección tiene los siguientes objetivos:   
(1) demostrar cómo se pueden visualizar los datos lingüísticos (recogidos mediante una prueba de juicios de aceptabilidad) con el paquete tidyplots y en qué situaciones conviene complementar tidyplots con el paquete ggplot2  
(2) ilustrar cómo se pueden crear diagramas de dispersión, gráficos de barras y gráficos de violín con el paquete tidyplots  
(3) mostrar cómo personalizar colores, etiquetas y temas de los gráficos y cómo crear gráficos facetados  
(4) ejemplificar cómo analizar dichos datos mediante modelos lineales mixtos de enlace acumulativo  

### Panorama de herramientas: tidyplots frente a ggplot2

Esta lección utiliza dos herramientas complementarias:

tidyplots es un paquete de R construido sobre ggplot2 que proporciona una interfaz simplificada y encadenable mediante el operador `|>`. Está diseñado para generar rápidamente gráficos de alta calidad con poco código, lo que lo hace especialmente útil en la fase exploratoria del análisis. Sus funciones cubren los tipos de gráficos más habituales en ciencias sociales y lingüística experimental: gráficos de violín, gráficos de barras con barras de error, diagramas de caja y gráficos de dispersión.  

ggplot2 es el sistema de visualización de referencia en R, basado en la gramática de gráficos. Ofrece un control total sobre cada elemento del gráfico, lo que lo hace indispensable para publicaciones, para tipos de gráficos no disponibles en tidyplots (como la matriz de dispersión) y para personalizaciones avanzadas.

### Más allá del caso de estudio: otros contextos de aplicación

Aunque esta lección utiliza juicios de aceptabilidad gramatical como hilo conductor, las técnicas de visualización y el marco estadístico que se presentan son directamente transferibles a cualquier diseño que recoja respuestas en escala ordinal o continua con estructura de medidas repetidas. Los siguientes ejemplos ilustran esta transferibilidad.

1. Otros usos de los juicios de aceptabilidad en lingüística. Las tareas de juicios de aceptabilidad se emplean ampliamente más allá de la morfología verbal. En sociolingüística, se usan para evaluar la aceptabilidad de variantes dialectales o de contacto (por ejemplo, construcciones de español en contacto con el inglés entre hablantes de herencia en EE. UU.), y las visualizaciones por grupo etario, de género o generacional siguen exactamente la misma lógica que la comparación nativos/aprendientes de esta lección. En pragmática experimental, se emplean para valorar la adecuación de actos de habla (peticiones, rechazos, disculpas) en diferentes contextos culturales o interlingüísticos. En fonología, se recogen juicios de naturalidad sobre secuencias de sonidos o sobre el acento de hablantes no nativos.

2. Cuestionarios con escala Likert en educación y psicología. Cualquier instrumento que pida a los participantes valorar su acuerdo, satisfacción o frecuencia en una escala de varios puntos genera datos estructuralmente parecidos a los de esta lección. Por ejemplo: encuestas sobre motivación para el aprendizaje de lenguas (una escala del 1 al 5 sobre el grado de acuerdo con afirmaciones como Estudio español porque me gusta su cultura), cuestionarios de autoevaluación de competencia, o escalas de actitud lingüística hacia variedades del español. En todos estos casos, los gráficos de violín y los modelos de enlace acumulativo mixto son igualmente apropiados.

3. Tareas de tiempo de reacción y lectura. En psicolingüística experimental, los tiempos de lectura palabra por palabra o los tiempos de reacción en tareas de decisión léxica son variables continuas con estructura de medidas repetidas (cada participante responde a múltiples estímulos). Aunque en ese caso los datos no son ordinales, por lo cual se usaría un modelo lineal mixto en lugar de un CLMM, las estrategias de visualización con tidyplots y ggplot2 que se presentan en esta lección se aplican directamente: gráficos de violín por condición, dispersión entre variables individuales y tiempos medios, y facetas por grupo.

4. Estudios de producción y corpus. En análisis de corpus o estudios de producción oral o escrita, es habitual contar frecuencias de uso de una construcción gramatical por participante o por texto, o asignar puntuaciones de corrección a producciones de aprendientes. Estos datos que representan frecuencias por condición o puntuaciones por rasgo analizado pueden visualizarse y analizarse con los mismos modelos mixtos que se describen en la sección de análisis estadístico.

En todos estos contextos, la pregunta de investigación es la misma: ¿Cómo varía la respuesta en función de las condiciones experimentales y de las características individuales de los participantes, teniendo en cuenta que cada participante contribuye con múltiples observaciones? Es precisamente esa pregunta la que los modelos mixtos están diseñados para responder.

---

## Estudio de caso integrador

Para seguir esta lección, descarga el archivo [datos_aceptabilidad.csv](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/visualizacion-juicios-aceptabilidad-tidyplots-ggplot2/datos_aceptabilidad.csv) del repositorio de la lección. Una vez descargado, colócalo en el directorio de trabajo de tu proyecto de R Studio. Este conjunto de datos proviene de un estudio sobre la adquisición del aspecto verbal en español como L2. Los participantes son 60 aprendientes eslovacos de español de nivel avanzado y 20 hablantes nativos de español peninsular. Todos evaluaron en una escala Likert de 7 puntos la aceptabilidad de 18 pares de oraciones que combinaban dos tiempos verbales: el pretérito perfecto simple (canté) y el pretérito perfecto compuesto (he cantado) con tres tipos de modificadores temporales: los modificadores temporales que aluden a anterioridad inmediata (hace un rato), los modificadores temporales que aluden a anterioridad más lejana (hace dos meses) y los modificadores temporales que aluden al momento no terminado (hoy, esta mañana, esta semana).  Dentro del grupo de aprendientes, las diferencias individuales de interés son:
- `instruction`: instrucción bilingüe vs. clases de ELE (variable categórica nominal)
- `aoa`: edad de adquisición del español (variable continua)
- `years_learning`: años de aprendizaje (variable continua)

### Preparación del entorno y carga de datos

El primer paso es instalar y cargar los paquetes necesarios. Si es la primera vez que los usas, instálalos con `install.packages()`:

```r
install.packages(c("tidyverse", "tidyplots", "ordinal", "emmeans"))
```

A continuación, carga los paquetes:

```r
library(tidyverse)
library(tidyplots)
```
Para poder seguir esta lección, descarga el archivo [datos_aceptabilidad.csv](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/visualizacion-juicios-aceptabilidad-tidyplots-ggplot2/datos_aceptabilidad.csv), y guárdalos en tu ordenador. Después, establece el directorio de trabajo (indicándole a R e qué carpeta del ordenador está guardado el archivo) y guárdalo con el nombre datos:   

```r
setwd("/Users/zuzana/Documents") 
datos <- read_csv("datos_aceptabilidad.csv") 
```

También puedes revisar la estructura del conjunto de datos antes de continuar:

```r
glimpse(datos)
```

Si las variables `group`, `instruction`, `tense` y `adverb_type` aparecen como tipo `character`, conviértelas a factor:

```r
datos <- datos |>
  mutate(across(c(group, instruction, tense, adverb_type), as.factor))
```

### Cálculo de puntuaciones medias por condición

Para muchos gráficos es útil contar con un resumen por condición. Lo calculamos con `dplyr`:

```r
resumen <- datos |>
  group_by(group, tense, adverb_type) |>
  summarise(
    media = mean(rating, na.rm = TRUE),
    ee    = sd(rating, na.rm = TRUE) / sqrt(n()),
    .groups = "drop"
  )
  resumen
```

## Gráficos rápidos con tidyplots

### Filosofía de tidyplots

Aunque ggplot2 es la opción estándar para la visualización de datos, el paquete tidyplots, desarrollado por Jan Broder Engler (2025), representa una excelente opción para visualizar los datos en ASL debido a su facilidad de uso y su estilo limpio y orientado a publicaciones científicas. Tidyplots es especialmente apropiado tanto para los estudiantes como para los investigadores en ASL debido a su código más conciso, su gramática simplificada y su curva de aprendizaje más baja en comparación con ggplot2. 
En [la página oficial de tidyplots](https://jbengler.github.io/tidyplots/articles/Visualizing-data.html) se encuentran tres artículos que resumen la guía completa para crear y personalizar gráficos con este paquete: [Visualizing data](https://perma.cc/3KYT-4GAC), [Advanced plotting](https://perma.cc/4Q7B-EDXR) y [Color schemes](https://perma.cc/9FTX-XXLP).[^1]  

La estructura básica de Tidyplots es:

```r
datos |>
  tidyplot(x = variable_x, y = variable_y, color = variable_grupo) |>
  add_[tipo_de_gráfico]() +
  adjust_[aspecto]()
```
Esta estructura sigue una lógica de capas encadenadas mediante el operador pipe (|>). Primero se pasa el conjunto de datos (`datos`) a la función `tidyplot()`, donde se especifican las variables que corresponden a cada eje y al color. A continuación, se añade el tipo de gráfico deseado con una función `add_*()`, por ejemplo, `add_violin()`, `add_boxplot()`, etc. Finalmente, se pueden modificar aspectos visuales o etiquetas mediante funciones `adjust_*()`, por ejemplo, `adjust_title()`, `adjust_x_axis_title()`, `adjust_legend_title()`, etc. Cada línea construye sobre la anterior, lo que hace que el código sea fácil de leer y modificar.

### Gráficos de violín con tidyplots

Para aplicar esta estructura básica a nuestro estudio de caso, podemos empezar con un simple gráfico de violín para visualizar la distribución de juicios de los dos tiempos verbales entre los dos grupos de participantes según su lengua materna: 

```r
violinchart00 <- datos |>
    tidyplot(x = l1, y = rating, color = tense) |> 
    add_violin(draw_quantiles = 0.5) |> 
    adjust_title("Distribución de juicios por L1 y tiempo verbal") |>
    adjust_x_axis_title("L1") |>
    adjust_y_axis(limits = c(1, 7), breaks = 1:7)
violinchart00 
```    
Puedes guardar el gráfico con la función `ggsave("violinchart00.png", plot = violinchart00)`. Los gráficos se guardan en tu directorio de trabajo. 
    
El resultado es el gráfico en la Figura 1 que revela una tendencia interesante con respecto a la interacción entre la L1 y el tiempo verbal. Los hablantes nativos muestran una preferencia más clara por el PPS sobre el PPC (media ≈  5.5 para el PPS, media ≈ 4 para el PPC), mientras que los juicios del PPC y el PPS por los aprendientes muestran una distribución diferente (media ≈  4 para el PPS, media ≈  5 para el PPC).

{% include figure.html filename="es-or-visualizacion-juicios-aceptabilidad-tidyplots-ggplot2-01.png" alt="La Figura 1 es un gráfico de violín que muestra la distribución completa de los juicios de aceptabilidad (escala 1-7) para dos grupos de L1 (eslovaco y español) y dos tiempos verbales (PPC y PPS), con una línea horizontal marcando la mediana de cada distribución. En el grupo de L1 eslovaco, ambas distribuciones son similares y bastante amplias, con medianas cercanas (PPC: 5; PPS: 4). En el grupo de L1 español, la distribución de PPC es más dispersa con mediana más baja (4), mientras que la de PPS se concentra más hacia valores altos con mediana más alta (5.5). En general, ambos grupos muestran una alta dispersión de juicios a lo largo de casi toda la escala, sin una preferencia extrema y clara por un solo valor." caption="Figura 1. Distribución de los juicios de aceptabilidad según la L1 (eslovaco vs. español) y el tiempo verbal (PPC vs. PPS). Las líneas horizontales dentro de cada violín indican la mediana." %}
   
Sin embargo, para visualizar nuestro conjunto de datos, necesitaremos gráficos más detallados. Específicamente, necesitaremos visualizar la distribución de las combinaciones de los dos tiempos verbales con los tres tipos de modificadores adverbiales según la L1 de los participantes. Esto se puede lograr mediante un gráfico de violín facetado (o sea, dos gráficos idénticos para los dos subconjuntos del mismo conjunto de datos), dividido según la variable L1 mediante la función `split_plot()`.

```r
violinchart01 <- datos |>
  tidyplot(x = tense, y = rating, color = adverb_type) |>
  add_violin() |>
  add_mean_dot() |>
  split_plot(by = l1) |>
  adjust_x_axis_title("Tiempo verbal") |> 
  adjust_y_axis_title("Juicio de aceptabilidad (1–7)") |>
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |>
  adjust_colors(c("#1B7837", "#762A83")) |>
  adjust_title("Los juicios según el tiempo verbal y el modificador adverbial: Hablantes nativos vs. aprendientes de español")   
violinchart01  
```
La función `add_violin()` dibuja el violín; `add_mean_dot()` superpone el punto de la media`, y `split_plot()` divide el gráfico en dos paneles separados. Con `adjust_colors()` asignamos colores a los dos grupos, uno por cada grupo de participantes. [^2]

{% include figure.html filename="es-or-visualizacion-juicios-aceptabilidad-tidyplots-ggplot2-02.png" alt="La Figura 2 es un diagrama de violín con dos paneles que muestra la distribución completa de los juicios de aceptabilidad (escala 1-7) según el tiempo verbal (PPC, PPS) y el tipo de modificador adverbial (anterioridad inmediata, anterioridad lejana, momento no terminado), con un punto marcando la media de cada distribución. En el panel de los aprendices, las distribuciones son amplias y se superponen considerablemente entre los tres tipos de modificador, tanto en PPC como en PPS, indicando poca diferenciación clara entre condiciones. En el panel de los nativos, en cambio, las distribuciones son más estrechas y polarizadas: en PPC, anterioridad lejana se concentra en valores bajos (1-2) y momento no terminado en valores altos (5-7); en PPS, este patrón se invierte, con anterioridad inmediata y anterioridad lejana concentrados en valores altos (5-7) y momento no terminado más disperso hacia valores bajos y medios." caption="Figura 2. Gráfico de violín que muestra la distribución de los juicios de aceptabilidad según el tiempo verbal (PPC vs. PPS) y el tipo de modificador adverbial, comparando hablantes nativos (Spanish) y aprendices (Slovak). Los puntos indican la media de cada distribución." %}

Este gráfico revela patrones más detallados con respecto a la interacción entre el tiempo verbal, el tipo de modificador adverbial y la L1: los hablantes nativos concentran sus juicios de los adverbios de momento no terminado en los valores altos con el PPC (media ≈ 6.1) y en los valores bajos con el PPS (media ≈ 2.6), mientras que sus juicios de los adverbios de anterioridad lejana son bajos con el PPC (media ≈ 1.8) y altos con el PPS (media ≈ 5.8). Los adverbios de anterioridad inmediata son aceptados por este grupo más con el PPS que con el PPC (media ≈ 5.8 vs. 3.6). Los aprendientes muestran más variabilidad en sus juicios (con ambos tiempos verbales, las medias de los tres adverbios están entre 3.4 y 5.5), posiblemente porque en su L1 no se conceptualiza esta distinción aspectual de la misma manera: los conceptos semánticos relacionados con el PPC y el PPS en español se expresan a través de un solo tiempo verbal en eslovaco (el tiempo pasado simple). 

Tidyplots nos permite dividir el gráfico por dos variables a la vez. Por ejemplo, para mostrar el efecto del tiempo verbal y del tipo de instrucción (bilingüe vs. ELE), podemos crear otro gráfico de violín facetado, esta vez incorporando las funciones `filter(group == "learner")` y `split_plot(by = instruction)`. Con la primera función filtramos las filas del dataframe antes de pasarlas a tidyplots para que el gráfico solo incluya los datos donde la variable **group** tiene el valor **learner**, mientras que con la segunda dividimos el gráfico en dos paneles según el tipo de instrucción recibida.

```r
violinchart02 <-datos |>
  filter(group == "learner") |>
  tidyplot(x = tense, y = rating, color = adverb_type) |>
  add_violin() |>
  add_mean_dot() |>
  split_plot(by = instruction) |>
  adjust_x_axis_title("Tiempo verbal") |>
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |>
  adjust_y_axis_title("Juicio de aceptabilidad (1–7)") |>
  adjust_colors(c("#1B7837", "#762A83")) |>
  adjust_title("Los juicios según el tiempo verbal y el modificador adverbial: Instrucción bilingüe vs. ELE")
violinchart02
```
{% include figure.html filename="es-or-visualizacion-juicios-aceptabilidad-tidyplots-ggplot2-03.png" alt="La Figura 3 es un gráfico de violín con dos paneles (bilingüe y ELE) que muestra la distribución completa de los juicios de aceptabilidad (escala 1-7) según el tiempo verbal (PPC, PPS) y el tipo de modificador adverbial (anterioridad inmediata, anterioridad lejana, momento no terminado), con un punto marcando la media de cada distribución. Los dos paneles muestran patrones muy similares entre sí: en ambos grupos, anterioridad inmediata tiene la media más alta en PPC (~5.4-5.6) y baja notablemente en PPS (~3.2-3.5), mientras que anterioridad lejana y momento no terminado se mantienen en valores intermedios en ambos tiempos verbales, con distribuciones amplias y bastante solapadas entre los tres tipos de modificador." caption="Figura 3. Gráfico de violín que muestra la distribución de los juicios de aceptabilidad según el tiempo verbal (PPC vs. PPS) y el tipo de modificador adverbial (anterioridad inmediata, anterioridad lejana, momento no terminado), comparando aprendices con instrucción bilingüe y con instrucción ELE. Los puntos indican la media de cada distribución." %}

Este gráfico responde directamente a una pregunta de investigación interesante: ¿difieren los juicios de los aprendientes con instrucción bilingüe y los que recibieron clases de ELE? Como se puede observar en el gráfico, parece que los juicios de ambos grupos son comparables y no cambian mucho con el tipo de instrucción. El gráfico indica que ambos grupos prefieren los adverbios de anterioridad inmediata con el PPC (media grupo bilingüe ≈  5.6, media grupo ELE ≈ 5.4) y los adverbios de anterioridad lejana con el PPS (media grupo bilingüe ≈ 4.4, media grupo ELE ≈ 4.6) y momento no terminado con el PPC (media grupo bilingüe ≈ 4.3, media grupo ELE ≈  4.4). Las similitudes en los juicios por los dos grupos se podrían atribuir al contexto geográfico (aunque uno de los grupos recibe clases de ELE y el otro tiene algunas de sus asignaturas impartidas en español, ambos grupos estudian español en su país de origen).
 
### Diagramas de caja y de líneas con tidyplots

Un tipo de gráfico que se puede utilizar para comparar las medias de los juicios entre condiciones e identificar valores extremos es el diagrama de caja con barras de error que representan el error estándar de la media.

```r
boxplot01 <- datos |>
     tidyplot(x = adverb_type, y = rating, color = l1) |>
     add_boxplot() |>
     adjust_x_axis(rotate_labels = TRUE) |>
     adjust_x_axis_title("Tipo de modificador adverbial") |>
     adjust_y_axis(limits = c(1, 7), breaks = 1:7) |>
     adjust_y_axis_title("Juicio de aceptabilidad (1–7)") |>
     split_plot(by = tense)  |>
     adjust_title("Juicios de aceptabilidad por grupo y modificador adverbial: PPC vs. PPS") |>
     adjust_legend_title("L1")  
boxplot01
```
Este gráfico confirma que los nativos tienden que mostrar una distinción más marcada entre el PPS y el PPC según el tipo de adverbio, lo que sugiere mayor sensibilidad gramatical. Los aprendientes de español muestran distribuciones más uniformes entre estas condiciones. En ambos grupos, podemos observar algunos valores atípicos, sobre todo con el PPC. 
Para añadir una raya de la media o un punto de la media al diagrama de caja, puedes insertar la función `add_mean_dash() |>` o `add_mean_dot() |>` después de la función `add_boxplot() |>`.

{% include figure.html filename="es-or-visualizacion-juicios-aceptabilidad-tidyplots-ggplot2-04.png" alt="La Figura 4 es un diagrama de cajas con dos paneles (PPC y PPS) que muestra la distribución de los juicios de aceptabilidad (escala 1-7) según el tipo de modificador adverbial (anterioridad inmediata, anterioridad lejana, momento no terminado) y la lengua materna (eslovaco, español), con la mediana marcada dentro de cada caja y los valores atípicos como puntos. En PPC, el grupo español tiene medianas más bajas que el eslovaco en anterioridad inmediata (3 vs. 6) y anterioridad lejana (2 vs. 4), pero una mediana más alta en momento no terminado (6-7 vs. 4). En PPS, este patrón se invierte: el grupo español tiene medianas más altas en anterioridad inmediata (6 vs. 3) y anterioridad lejana (6 vs. 5), pero más baja en momento no terminado (3 vs. 4). En general, el grupo español muestra cajas más compactas (menor dispersión) en las condiciones donde tiene medianas extremas, mientras que el grupo eslovaco mantiene rangos intercuartílicos más amplios en casi todas las condiciones." caption="Figura 4. Gráfico de cajas comparando juicios de aceptabilidad de los dos tiempos verbales (PPC vs. PPS) según el tipo de modificador adverbial (anterioridad inmediata, anterioridad lejana, momento no terminado) y la lengua materna (eslovaco vs. español). La línea dentro de cada caja indica la mediana, los puntos representan valores atípicos." %}

Si sustituimos la función `add_boxplot() |>` con `add_line() |>`, podemos visualizar los juicios medios mediante un gráfico de líneas: 

```r
linechart01 <- resumen |>
     tidyplot(x = adverb_type, y = media, color = group) |>
     add_line() |>
     adjust_x_axis_title("Tipo de modificador adverbial") |>
     adjust_y_axis_title("Juicio medio de aceptabilidad") |>
     adjust_y_axis(limits = c(1, 7), breaks = 1:7) |>
     adjust_legend_title("Grupo") |>
     split_plot(by = tense) |>
     adjust_colors(new_colors = c("#2C7BB6", "#D7191C")) |>
     adjust_x_axis(rotate_labels = TRUE)
linechart01
```
{% include figure.html filename="es-or-visualizacion-juicios-aceptabilidad-tidyplots-ggplot2-05.png" alt="La Figura 5 es un diagrama de líneas con dos paneles que comparan los juicios medios de aceptabilidad (escala 1-7) de dos grupos, los aprendientes y los nativos, frente a tres tipos de modificador adverbial (anterioridad inmediata, anterioridad lejana y momento no terminado). Cada panel corresponde a un tiempo verbal: PPC y PPS. En PPC, los nativos asignan juicios bajos a anterioridad lejana y juicios altos a momento no terminado, invirtiendo su relación con los aprendices; en PPS, los nativos puntúan alto la anterioridad lejana pero caen por debajo de los aprendices en momento no terminado." caption="Figura 5. Juicios medios de aceptabilidad por tipo de modificador adverbial y grupo, divididos por el tiempo verbal." %}

A diferencia del gráfico de violín en la Figura 4 que muestra los valores centrales y la dispersión, el gráfico de líneas muestra el patrón de interacción entre el tiempo verbal y el tipo de adverbio para los dos grupos (los hablantes nativos vs. los aprendientes).  

### Más gráficos facetados para comparar grupos

Como ya hemos visto en el apartado anterior, las facetas permiten dividir un gráfico en varios paneles según los niveles de una variable categórica, lo que facilita la comparación visual entre grupos. Por ejemplo, si queremos comparar los juicios medios de los dos grupos por separado, podemos combinar un gráfico de barras con la función `split_plot(by = group)` para generar un panel independiente para cada grupo.

```r
barchart01 <- datos |>
  tidyplot(x = tense, y = rating, color = adverb_type) |>
  add_mean_bar(alpha = 0.7) |>
  add_sem_errorbar() |>
  add_mean_value() |>
  split_plot(by = group) |>
  adjust_x_axis_title("Tiempo verbal") |>
  adjust_y_axis_title("Juicio de aceptabilidad (1–7)") |>
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |>
  adjust_legend_title("Tipo de modificador")  |>
  adjust_title("Las medias de los juicios por grupo, tiempo verbal y modificador adverbial")
barchart01
```
{% include figure.html filename="es-or-visualizacion-juicios-aceptabilidad-tidyplots-ggplot2-06.png" alt="La Figura 6 es un gráfico de barras con dos paneles que muestran las medias de juicios de aceptabilidad (1-7) y barras de error que indican el error estándar. El gráfico compara los juicios de los hablantes nativos y los aprendices de español, según tiempo verbal (PPC, PPS) y tipo de modificador adverbial (anterioridad inmediata, anterioridad lejana, momento no terminado). Cada panel corresponde a un grupo: aprendientes y nativos. Los nativos muestran un patrón claro de complementariedad: anterioridad inmediata y anterioridad lejana se prefieren con el PPS, momento no terminado con el PPC. Los aprendices muestran diferencias generalmente más moderadas entre condiciones." caption="Figura 6. Juicios medios de aceptabilidad (escala 1–7) para las combinaciones de tiempo verbal (PPC, PPS) y tipo de modificador adverbial en aprendientes de español y hablantes nativos. Las barras representan la media de cada condición y las líneas de error indican el error estándar." %}

El gráfico de barras también muestra que en el grupo de los aprendientes, las medias son similares entre los tres tipos de adverbios con cada tiempo verbal, mientras que los hablantes nativos prefieren el PPC con momento no terminado, seguido de anterioridad inmediata y anterioridad lejana y el PPS con anterioridad lejana, seguida de anterioridad inmediata y momento no terminado. Un dato interesante es la puntuación (media ≈ 2.6) de la combinación del PPS con el momento no terminado por los hablantes nativos, la cual se puede explicar por el tipo de modificadores adverbiales de momento no terminado utilizados en este estudio (hoy, esta mañana, esta semana, este mes, en vez de todavía, aún, etc.). Estos modificadores adverbiales refieren a un momento temporal que puede ser conceptualizado como aludiendo a un momento concluido dentro de un marco temporal más amplio (por ejemplo: esta mañana = un período de tiempo que ya terminó el día de hoy).

Para visualizar las correlaciones entre la variable dependiente y las variables independientes, tidyplots nos permite crear gráficos de dispersión. Por ejemplo, si nos interesa explorar la relación entre la edad de adquisición del español *aoa* y los juicios medios de aceptabilidad para los dos grupos de aprendientes *bilingual* vs. *ELE*, filtramos los datos para seleccionar solo los aprendientes, los agrupamos por participante, edad de adquisición y tipo de instrucción, calculamos medias por participante y visualizamos la relación entre la edad de adquisición y los juicios de aceptabilidad, diferenciando entre aprendientes bilingües y aprendientes con ELE.

```r
scatterplot01 <- datos |>
  filter(group == "learner") |>
  group_by(participant_id, aoa, instruction) |>
  summarise(media_juicio = mean(rating), .groups = "drop") |>
  tidyplot(x = aoa, y = media_juicio, color = instruction) |>
  add_data_points() |>
  adjust_x_axis_title("Edad de adquisición del español") |>
  adjust_y_axis_title("Juicio medio de aceptabilidad") |>
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |>
  adjust_legend_title("Tipo de instrucción") |>
  adjust_colors(new_colors = c("#1B7837", "#762A83")) 
scatterplot01
```
{% include figure.html filename="es-or-visualizacion-juicios-aceptabilidad-tidyplots-ggplot2-07.png" alt="La Figura 7 es un diagrama de dispersión que muestra la relación entre la edad de adquisición del español (7-18 años, eje X) y los juicios medios de aceptabilidad (1–7, eje Y) para los aprendientes con instrucción bilingüe y para los de instrucción ELE. No hay una diferencia clara y consistente entre los dos grupos en cuanto a nivel de aceptabilidad, y los juicios se distribuyen de manera relativamente similar en todo el rango de edades, sin una tendencia clara asociada a la edad de adquisición." caption="Figura 7. Gráfico de dispersión que representa la relación entre la edad de adquisición del español y los juicios medios de aceptabilidad en el grupo de aprendientes por tipo de instrucción (bilingüe vs. ELE). Cada punto representa la media de juicios de un participante." %}

El gráfico de dispersión indica que ambos grupos tienen sus juicios concentrados cerca del punto medio de la escala y los puntos de los dos grupos están entremezclados entre sí, sin mostrar una correlación con la edad de adquisición. 

### Tidyplots vs. ggplot2

ggplot2 se basa en la idea de que todo gráfico puede describirse como la combinación de: un conjunto de datos, un mapeo de variables a propiedades visuales (*aesthetics*: posición, color, forma, tamaño) y uno o más objetos geométricos (*geoms*: puntos, líneas, barras, violines). Esta estructura modular hace que ggplot2 sea más verboso que tidyplots, pero también mucho más flexible.

La estructura básica de un gráfico con ggplot2 es:

```r
ggplot(datos, aes(x = variable_x, y = variable_y, color = grupo)) +
  geom_[tipo]() +
  labs(x = "etiqueta x", y = "etiqueta y") +
  theme_classic()
```
Para aprender a visualizar los gráficos que hemos visto en esta lección hasta ahora (gráficos de dispersión, diagramas de barras y diagramas de caja) con ggplot2, te recomendamos la lección de Programming Historian [Visualizing Urban and Demographic data in R with ggplot2](https://programminghistorian.org/en/lessons/urban-demographic-data-r-ggplot2). Si te gustaría aprender cómo organizar tus datos en el formato tidy y cómo utilizar el paquete dplyr para manipular tus datos, te recomendamos la lección [Data Wrangling and management in R](https://programminghistorian.org/en/lessons/data-wrangling-and-management-in-r). 

En la siguiente sección vamos a ver algunos gráficos para ejemplificar cómo podemos complementar tidyplots con ggplot2 o recurrir al ggplot2 para combinar múltiples tipos de geometrías o facetas en dos dimensiones (filas y columnas). 
 
### Complementar tidyplots con ggplot2 mediante la función add()
tidyplots se puede complementar con ggplot2 mediante la función `add()` dentro de una cadena de pipes de tidyplots con |> para añadir funciones `geom`, por ejemplo `geom_hline()`, `geom_point()` o `geom_text()`. En nuestro caso, podríamos modificar en ggplot2 al gráfico de dispersión en la Figura 6 añadiendo una línea de regresión sin intervalo de confianza y/o una línea horizontal punteada en el valor de la media global de todas las medias de aceptabilidad:

```r
scatterplot02 <- scatterplot01 |>
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |>
  add(ggplot2::geom_smooth(method = "lm", se = FALSE))  |> 
  add(ggplot2::geom_hline(yintercept = mean(resumen$media),
  linetype = "dotted", color = "black")) 
scatterplot02  
```
El resultado de esta modificación muestra dos líneas de regresión para cada grupo y una línea de la media global de los juicios de todos los aprendientes, lo que permite no solo ver si los participantes con **aoa** más alta tienden a estar por debajo de esa media, sino también comparar la tendencia de cada grupo (**bilingual** vs. **ELE**) con respecto al rendimiento medio general:

{% include figure.html filename="es-or-visualizacion-juicios-aceptabilidad-tidyplots-ggplot2-08.png" alt="La Figura 8 es un diagrama de dispersión que muestra la relación entre la edad de adquisición del español (7-18 años, eje X) y los juicios medios de aceptabilidad (1-7, eje Y) para los aprendientes con instrucción bilingüe y ELE, con una línea de tendencia añadida para cada grupo. La línea del grupo bilingüe muestra una leve tendencia positiva, mientras que la del grupo ELE se mantiene prácticamente plana. Aun así, ambas líneas convergen alrededor de un valor similar (~4.2-4.5) en las edades más altas, por lo que la diferencia entre grupos sigue sin ser marcada." caption="Figura 8. Gráfico de dispersión que representa la relación entre la edad de adquisición del español y los juicios medios de aceptabilidad en el grupo de aprendientes por tipo de instrucción (bilingüe vs. ELE), con líneas de tendencia. Cada punto representa la media de juicios de un participante." %}

La línea verde (instrucción bilingüe) indica que entre los participantes con la instrucción bilingüe, la edad más alta (18 años) se relaciona con juicios más altos (media ≈ 4.5) y la edad más temprana (7 años) con juicios más bajos (media ≈ 3.8), mientras que para los participantes con la instrucción ELE (línea morada), no se asocia con cambios en juicios medios (media ≈ 4.2 - 4.3 en todo el rango de edades). 

Para resaltar visualmente las diferencias entre los dos grupos de participantes, podemos diferenciar los dos grupos mediante puntos de dos colores distintos y dos formas distintas mediante la función add `ggplot2::geom_point`. Primero, calculamos las medias por participante y después creamos un gráfico de dispersión con círculos naranjas (grupo: **bilingual**) y triángulos azules (grupo **ELE**).

```r
library(dplyr)

datos_means <- datos |>
  filter(group == "learner") |> 
  group_by(participant_id, aoa, instruction) |>
  summarise(mean_rating = mean(rating, na.rm = TRUE), .groups = "drop")
  
scatterplot03 <- datos_means |>
        tidyplot(x = aoa, y = mean_rating, color = instruction) |>
        adjust_colors(new_colors = c("bilingual" = "#E69F00", "ELE" = "#0072B2")) |>
        adjust_title("Juicios medios según el tipo de instrucción: Bilingüe vs. ELE") |>
        adjust_y_axis(limits = c(1, 7), breaks = 1:7) |>
        add(ggplot2::geom_point(aes(shape = instruction), size = 2)) 

scatterplot03
```
El resultado de este código es el siguiente gráfico: 

{% include figure.html filename="es-or-visualizacion-juicios-aceptabilidad-tidyplots-ggplot2-09.png" alt="La Figura 9 es un diagrama de dispersión que muestra la relación entre la edad de adquisición del español (eje X, 7-18 años) y el juicio medio de aceptabilidad (eje Y, escala 1-7), diferenciando el tipo de instrucción mediante forma y color: círculos naranjas para bilingüe y triángulos azules para ELE. Al igual que en el diagrama de dispersión anterior, no hay una diferencia clara y consistente entre los dos grupos, y los juicios se distribuyen de manera relativamente similar en todo el rango de edades." caption="Figura 9. Gráfico de dispersión que muestra la relación entre la edad de adquisición del español y los juicios medios de aceptabilidad por tipo de instrucción (bilingüe vs. ELE). Cada punto representa la media de juicios de un participante." %}

### Faceting con facet_grid para comparar dos factores

En esta lección hemos visto que tidyplots nos permite incorporar facetas para dividir el gráfico en paneles, lo que facilita la comparación visual entre grupos. Sin embargo, si queremos crear un gráfico de violin parecido a la Figura 3, pero preferimos dividirlo en una cuadrícula de paneles según dos variables simultáneamente (una en filas y otra en columnas), necesitamos recurrir a la función`facet_grid()` de ggplot2 . Esto es muy útil cuando se quiere visualizar la interacción entre el tiempo verbal (filas) y el tipo de instrucción (columnas) para los aprendientes en un solo gráfico:

```r
matrix <- datos |>
  filter(group == "learner") |>
  ggplot(aes(x = adverb_type, y = rating, fill = tense)) +
  geom_violin(alpha = 0.3, trim = TRUE, bounds = c(1, 7)) +
  geom_boxplot(width = 0.15, alpha = 0.8, outlier.size = 0.8) +
  facet_grid(tense ~ instruction,
             labeller = labeller(
               tense       = c(PPS = "Pret. Perf. simple", PPC = "Pret. Perf. compuesto"),
               instruction = c(bilingual = "Bilingüe", ELE = "ELE"))) +
  scale_fill_manual(values = c(PPS = "#4DAC26", PPC = "#D01C8B"),
                    guide = "none") +
  scale_y_continuous(limits = c(1, 7), breaks = 1:7) +
  labs(x = "Tipo de modificador adverbial",
       y = "Juicio de aceptabilidad") +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 55, hjust = 1),
        strip.background = element_rect(fill = "grey90"))
 matrix
 ```       

{% include figure.html filename="es-or-visualizacion-juicios-aceptabilidad-tidyplots-ggplot2-10.png" alt="La Figura 10 es una matriz de gráficos de violín con diagramas de caja que muestra los juicios de aceptabilidad (1–7) según el tipo de instrucción (Bilingüe vs. ELE), el tiempo verbal (PPC vs. PPS) y el tipo de modificador adverbial. El PPC con anterioridad inmediata muestra puntuaciones más altas en ambos grupos que anterioridad lejana y momento no terminado, mientras que el PPS obtiene las puntuaciones más altas con anterioridad lejana, seguida por el momento no terminado y anterioridad inmediata." caption="Figura 10. Matriz de diagramas de violín que muestra la distribución de los juicios de aceptabilidad por tipo de instrucción (Bilingüe vs. ELE), tiempo verbal (pretérito perfecto compuesto vs. pretérito perfecto simple) y tipo de modificador adverbial. Cada violín muestra la densidad de las respuestas y el diagrama de caja integrado indica la mediana y el rango intercuartílico. Los puntos representan valores atípicos." %}

La matriz de gráficos de violín con diagramas de caja indica una interacción entre tiempo verbal y tipo de adverbio: la anterioridad lejana y momento no terminado obtienen las puntuaciones más bajas con el PPC (ambos grupos: mediana ≈ 4), pero más altas con el PPS (grupo bilingüe: mediana ≈ 4, grupo ELE: mediana ≈ 5). La anterioridad inmediata se mantiene en valores altos en combinación con PPC (ambos grupos: mediana ≈ 6-7) y más bajos con el PPS (ambos grupos: mediana ≈ 3). Interesantemente, los dos grupos de aprendientes muestran patrones bastante parecidos en las dos filas, aunque el grupo ELE presenta una distribución más dispersa con el PPC y puntuaciones ligeramente más altas en la fila de PPS.


### Matriz de gráficos de dispersión 

Para explorar simultáneamente las relaciones entre todas las variables continuas de los aprendientes, la matriz de diagramas dispersión es una herramienta muy eficiente. Se genera con la función `pairs()` del paquete base R. 

```r
slovak <- datos[datos$l1 == "Slovak", ]

slovak_means <- slovak %>%
   group_by(participant_id, instruction, aoa, years_learning) %>%
   summarise(mean_rating = mean(rating, na.rm = TRUE), .groups = "drop")
   
pairs(slovak_means[, c("mean_rating", "aoa", "years_learning")],
      col  = c("red", "green")[slovak_means$instruction],
      pch  = c(1, 4)[slovak_means$instruction],
      main = "Matriz de Gráficos de dispersión",
      oma  = c(4, 4, 6, 6))   

legend("right",
       legend = levels(slovak_means$instruction),
       col    = c("red", "green"),
       pch    = c(1, 4),
       title  = "Instruction",
       cex    = 0.4,  xpd    = NA)     
```
{% include figure.html filename="es-or-visualizacion-juicios-aceptabilidad-tidyplots-ggplot2-11.png" alt="La Figura 11 es una matriz de diagramas de dispersión de 3x3 paneles que muestra las relaciones entre tres variables (juicio medio de aceptabilidad, edad de adquisición del español y años de aprendizaje) para los aprendices, diferenciando el tipo de instrucción mediante símbolo y color (círculos rojos para bilingüe y cruces verdes para ELE). La relación entre el juicio medio de aceptabilidad y las otras dos variables no muestra una tendencia clara, con puntos dispersos en todo el rango sin importar el tipo de instrucción. La relación entre la edad de adquisición y años de aprendizaje muestra una tendencia negativa." caption="Figura 11. Matriz de gráficos de dispersión entre tres variables: juicio medio de aceptabilidad de los aprendientes, edad de adquisición del español y años de aprendizaje, diferenciando el tipo de instrucción (bilingüe: círculos rojos; ELE: cruces verdes)." %}

Esta matriz de diagramas de dispersión muestra las asociaciones entre el juicio medio de aceptabilidad (**mean_rating**), la edad de adquisición (**aoa**) y los años de aprendizaje (**years_learning**) según el grupo (círculos rojos y cruces verdes). En general, no se observan correlaciones lineales fuertes entre las variables, aunque destaca una posible correlación negativa entre **aoa** y **years_learning**. Los dos grupos presentan una distribución solapada en la mayoría de los paneles, con diferencias leves en **mean_rating**. 

### Análisis estadístico: modelo de enlace acumulativo mixto

#### ¿Qué son los modelos mixtos y para qué sirven?

Un modelo mixto (también llamado modelo de efectos mixtos o modelo multinivel) es un modelo estadístico que incluye dos tipos de efectos:

- Efectos fijos: los predictores cuyo efecto queremos estimar y generalizar, en nuestro caso, el tiempo verbal, el tipo de modificador adverbial, y el grupo (nativo/aprendiente) y las diferencias individuales. Se llaman "fijos" porque asumimos que representan efectos constantes en la población de interés.
- Efectos aleatorios: fuentes de variabilidad que no nos interesa estimar directamente, pero que debemos tener en cuenta para no distorsionar las estimaciones de los efectos fijos. En un diseño con medidas repetidas, los participantes y los ítems son efectos aleatorios típicos: cada participante tiene su propio "nivel de base" de aceptabilidad, y cada ítem tiene su propio nivel de dificultad, independientemente de la condición experimental.

#### ¿Cuándo conviene usar un modelo mixto? 

Los modelos mixtos son apropiados cuando se cumplen una o más de las siguientes condiciones:

- Los datos tienen estructura de medidas repetidas: cada participante contribuye con más de una observación (como en cualquier experimento con múltiples ítems).
- Los datos tienen estructura jerárquica o anidada: los participantes están agrupados dentro de aulas, centros educativos, regiones, etc.
- Se trabaja con muestras de participantes e ítems que son representativas de poblaciones más amplias y se quieren generalizar las conclusiones más allá de los participantes e ítems concretos del estudio.
- La variabilidad entre unidades (participantes, ítems, grupos) es grande y podría enmascarar o inflar los efectos de interés.

#### Efectos aleatorios: interceptos y pendientes

El tipo más sencillo de efecto aleatorio es el intercepto aleatorio: permite que cada participante (o ítem) tenga su propio punto de partida en la escala de respuesta. En notación de R con los paquetes `lme4` u `ordinal`, se especifica como `(1 | participant_id)`.

Un paso más es incluir también pendientes aleatorias: permiten que el efecto de una variable experimental, por ejemplo, el efecto del tiempo verbal, varíe entre participantes. Si algunos aprendientes son muy sensibles a la distinción PPS/PPC y otros no, una pendiente aleatoria para `tense` capturará esa heterogeneidad. En R: `(1 + tense | participant_id)`. Las pendientes aleatorias hacen el modelo más realista, pero también más exigente en términos de datos; con muestras pequeñas pueden generar problemas de convergencia. 

#### Instalación y carga del paquete ordinal

```r
install.packages("ordinal")
library(ordinal)
library(emmeans)
```

#### Modelo 1: efecto del grupo y las variables lingüísticas


Primero, preparamos las variables para todos nuestros modelos estadísticos: transformamos la variable dependiente en factor ordenado para su uso en el CLMM y convertimos las variables **group**, **instruction**, **tense**, y **adverb_type** en factores. Después estandardizamos las variables continuas (**aoa** y **years_learning**) mediante puntuaciones z (M = 0, DT = 1). También filtramos el dataframe **datos** para incluir solo los aprendientes (para luego utilizarlo en los modelos 2.1 y 2.2).  

```r
datos <- datos |>
  mutate(across(c(group, instruction, tense, adverb_type), as.factor))
datos$rating_ord <- factor(datos$rating, ordered = TRUE)
datos_aprendientes <- datos |>
  filter(group == "learner")
datos_aprendientes$aoa_s <- as.numeric(scale(datos_aprendientes$aoa))
datos_aprendientes$years_learning_s <- as.numeric(scale(datos_aprendientes$years_learning))
```
#### Ajuste y selección del modelo 1

El primer modelo compara hablantes nativos y aprendientes, incluyendo como efectos fijos el grupo, y también el tiempo verbal y el tipo de modificador adverbial y su interacción. 
Con respecto a la especificación de los efectos aleatorios, se recomienda seguir las recomendaciones de [Barr et al. (2013)](https://pmc.ncbi.nlm.nih.gov/articles/PMC3881361/) sobre estructuras de efectos aleatorios máximas (especificar la estructura máxima justificada teóricamente para el diseño experimental). En un experimento con nuestro diseño (cada participante evaluó ítems en ambos tiempos verbales en combinación con los tres tipos de modificadores adverbiales), esto significa que incluiremos un intercepto aleatorio y pendientes aleatorias para el tiempo verbal, el tipo de adverbio y su interacción, agrupados por el participante  `(1 + tense * adverb_type | participant_id) `. Para controlar la variabilidad asociada a los ítems lingüísticos, añadiremos un intercepto aleatorio por ítem  `(1 | item_id) `. La variable **group** no se incluyó como pendiente aleatoria porque cada participante pertenece a un único grupo, por lo cual su efecto no varía dentro de cada participante:  

```r
modelo1.1 <- clmm(
  rating_ord ~ group * tense * adverb_type +
   (1 + tense * adverb_type | participant_id) + (1 | item_id),
  data = datos,
  link = "logit",
  threshold = "flexible"
)
summary(modelo1.1)
```
También podemos ajustar un segundo modelo con la estructura de efectos aleatorios simplificada, eliminando la pendiente aleatoria para el tipo de modificador adverbial y su interacción con el tiempo verbal, manteniendo únicamente la pendiente aleatoria para el tiempo verbal `(1 + tense | participant_id)`: 

```r
modelo1.2 <- clmm(
  rating_ord ~ group * tense * adverb_type +
    (1 + tense | participant_id) +
    (1 | item_id),  
  data = datos,
  link = "logit",
  threshold = "flexible"
)
summary(modelo1.2)
```
Podemos comparar los modelos 1.1 y 1.2 mediante las siguientes pruebas: 

```r
AIC(modelo1.1, modelo1.2) 
BIC(modelo1.1, modelo1.2) 
anova(modelo1.1, modelo1.2)
summary(modelo1.1)
summary(modelo1.2)
```
El modelo con el valor más bajo de AIC y BIC es preferible y si el valor p de anova es significativo (p < .05), el modelo más complejo ajusta significativamente mejor los datos y debería preferirse. En nuestro caso, los valores de AIC y BIC son más bajos para el modelo 1.2 y la prueba de anova no resultó ser estadísticamente significativa, lo que implica que el modelo más complejo (modelo1.1.) no ajusta los datos mejor. [^3]
Podemos reportar e interpretar el output del modelo1.1 de la siguiente manera: 

| Term | β | SE | z | p |
|---|---:|---:|---:|---:|
| group (native) | -2.51333 | 0.33600 | -7.480 | 7.42e-14 |
| tense (PPS) | -2.66148 | 0.21019 | -12.662 | < 2e-16 |
| adverb_type (anterioridad_lejana) | -2.35648 | 0.19970 | -11.800 | < 2e-16 |
| adverb_type (momento_no_terminado) | -1.45610 | 0.19534 | -7.454 | 9.05e-14 |
| group:tense | 5.65698 | 0.42559 | 13.292 | < 2e-16 |
| group:adverb_type (anterioridad_lejana) | -0.11794 | 0.39330 | -0.300 | 0.764 |
| group:adverb_type (momento_no_terminado) | 5.07471 | 0.41145 | 12.334 | < 2e-16 |
| tense:adverb_type (anterioridad_lejana) | 3.71661 | 0.28346 | 13.111 | < 2e-16 |
| tense:adverb_type (momento_no_terminado) | 2.23242 | 0.27384 | 8.152 | 3.57e-16 |
| group:tense:adverb_type (anterioridad_lejana) | 0.02454 | 0.56621 | 0.043 | 0.965 |
| group:tense:adverb_type (momento_no_terminado) | -9.96643 | 0.59353 | -16.792 | < 2e-16 |


El modelo1.2 indica que, en la condición de referencia (PPC con anterioridad inmediata), los hablantes nativos muestran juicios significativamente más bajos que los aprendientes (β = −2.51, z = −7.48, p < .001). Asimismo, para los aprendientes, el PPS recibe juicios significativamente más bajos que el PPC en esta condición (β = −2.66, z = −12.66, p < .001), y tanto la anterioridad lejana (β = −2.36, z = −11.80, p < .001) como el momento no terminado (β = −1.46, z = −7.454, p < .001) reciben juicios significativamente más bajos que la anterioridad inmediata cuando se combinan con el PPC.
Con respecto a las interacciones de dos vías, la diferencia entre PPC y PPS mostró diferencias estadísticamente significativas entre nativos y aprendientes (β = 5.66, z = 13.292, p < .001). Mientras que los aprendientes puntúan el PPC más alto que el PPS, este patrón se invierte en los nativos, quienes puntúan el PPS más alto que el PPC en la condición de anterioridad inmediata. De forma similar, la diferencia entre el momento no terminado y la anterioridad inmediata (dentro del PPC) varió significativamente entre grupos (β = 5.07, z = 12.33, p < .001). En cambio, la diferencia correspondiente para la anterioridad lejana no varió significativamente entre grupos (β = −0.12, z = −0.300, p = .76). Por otro lado, las interacciones entre tiempo verbal y tipo de adverbio revelan que, para los aprendientes, tanto la anterioridad lejana (β = 3.72, z = 13.11, p < .001) como el momento no terminado (β = 2.23, z = 8.15, p < .001) reciben juicios relativamente más altos, respecto a la anterioridad inmediata, bajo el PPS que bajo el PPC.
Por último, el modelo reveló una interacción triple significativa entre grupo, tiempo verbal y tipo de adverbio para el momento no terminado (β = −9.97, z = −16.79, p < .001), lo que indica que el patrón de interacción entre tiempo verbal y adverbio difiere significativamente entre nativos y aprendientes específicamente para este modificador. En cambio, la interacción triple correspondiente para la anterioridad lejana no alcanzó significancia (β = 0.02, z = 0.04, p = .965).

Para obtener medias marginales estimadas y comparaciones por pares con corrección de Bonferroni, utilizamos el paquete emmeans: 

```r
emm1 <- emmeans(modelo1.2, ~ group | tense * adverb_type)
emm1
pairs(emm1, adjust = "bonferroni")
```
Los resultados muestran las diferencias entre los dos grupos de participantes en todas las combinaciones del PPC y PPS con los modificadores adverbiales: 

| Tense | Adverb type | Contrast | Estimate | SE | z | p |
|---|---|---|---:|---:|---:|:---|
| PPC | anterioridad_inmediata | learner - native | 2.51 | 0.336 | 7.480 | < .0001 |
| PPS | anterioridad_inmediata | learner - native | -3.14 | 0.322 | -9.769 | < .0001 |
| PPC | anterioridad_lejana | learner - native | 2.63 | 0.356 | 7.400 | < .0001 |
| PPS | anterioridad_lejana | learner - native | -3.05 | 0.350 | -8.711 | < .0001 |
| PPC | momento_no_terminado | learner - native | -2.56 | 0.355 | -7.206 | < .0001 |
| PPS | momento_no_terminado | learner - native | 1.75 | 0.305 | 5.722 | < .0001 |


#### Modelo 2: Diferencias individuales en el grupo de los aprendientes

El segundo modelo se ajusta únicamente con los datos de los aprendientes, por lo cual era necesario primero filtrar el dataframe **datos** para incluir solo los aprendientes e incluir como predictores adicionales las diferencias individuales. 

```r
modelo2.1 <- clmm(
  rating_ord ~ tense * adverb_type +
               instruction + aoa_s + years_learning_s +
              (1 + tense * adverb_type | participant_id) + (1 | item_id),
  data      = datos_aprendientes,
  link      = "logit",
  threshold = "flexible"
)
summary(modelo2.1)
```
Igual que con el modelo 1, aquí también podemos ajustar un segundo modelo con la estructura de los efectos aleatorios simplificada y comparar los dos modelos:  

```r
modelo2.2 <- clmm(
  rating_ord ~ tense * adverb_type +
               instruction + aoa_s + years_learning_s +
               (1 + tense | participant_id) + (1 | item_id),     
  data      = datos_aprendientes,
  link      = "logit",
  threshold = "flexible"
)
summary(modelo2.2)
```
Igual que en el caso anterior, la comparación de los dos modelos indica que el modelo 2.2 es suficiente para explicar nuestros datos. 

El output del modelo está resumido en la siguiente tabla:

| Term | β | SE | z | p |
|---|---:|---:|---:|---:|
| tense (PPS) | -2.64508 | 0.21284 | -12.427 | < 2e-16 |
| adverb_type (anterioridad_lejana) | -2.34493 | 0.20142 | -11.642 | < 2e-16 |
| adverb_type (momento_no_terminado) | -1.45910 | 0.19646 | -7.427 | 1.11e-13 |
| instruction (ELE) | 0.17933 | 0.18327 | 0.978 | 0.328 |
| aoa_s | 0.12557 | 0.08840 | 1.420 | 0.155 |
| years_learning_s | -0.03803 | 0.08778 | -0.433 | 0.665 |
| tense:adverb_type (anterioridad_lejana) | 3.68159 | 0.28551 | 12.895 | < 2e-16 |
| tense:adverb_type (momento_no_terminado) | 2.22037 | 0.27412 | 8.100 | 5.49e-16 |

El modelo 2.2. reveló que, en la condición de referencia (PPC con anterioridad inmediata), los aprendientes juzgan el PPS como significativamente menos aceptable que el PPC (β = −2.64, z = −12.43, p < .001). Asimismo, tanto la anterioridad lejana (β = −2.34, z = −11.64, p < .001) como el momento no terminado (β = −1.46, z = −7.43, p < .001) reciben juicios significativamente más bajos que la anterioridad inmediata cuando se combinan con el PPC.
Con respecto a las interacciones, la anterioridad lejana (β = 3.68, z = 12.89, p < .001) y el momento no terminado (β = 2.22, z = 8.10, p < .001) son más compatibles con el PPS que con el PPC por parte de los aprendientes.
Interesantemente, ninguna de las variables individuales resultó ser estadísticamente significativa. 

### ¿Qué revelan los gráficos que las tablas no muestran?

La tabla de medias del modelo en el apartado anterior puede reportar, por ejemplo, que la diferencia entre los juicios del PPC con los adverbios de anterioridad inmediata entre los aprendientes y los hablantes nativos es de 2.51. Pero esa diferencia puede esconder distribuciones muy distintas, por ejemplo, en los puntos exactos de la escala en los que los aprendientes bilingües y los de ELE dispersan sus juicios. Los  gráficos de violín que hemos aprendido a hacer en esta lección (Figuras 2, 3 y 10) hace estas diferencias inmediatamente visibles.

Del mismo modo, los diagramas de dispersión con líneas de tendencia (Figura 8) revelan si la relación entre los años de aprendizaje y los juicios es lineal o no, si hay valores atípicos que puedan estar influenciando el modelo, y si la relación difiere cualitativamente entre los dos grupos de instrucción. Nada de eso aparece en una tabla de coeficientes.

---

### Referencias

- Barr, Dale J., Roger Levy, Christoph Scheepers, and Harry J. Tily. "Random effects structure for confirmatory hypothesis testing: Keep it maximal." Journal of memory and language 68, no. 3 (2013): 255-278.
- Bross, Fabian. Acceptability ratings in linguistics: A practical guide to grammaticality judgments, data collection, and statistical analysis. Version 1.0. Mimeo, 2019.
- Bürkner, Paul-Christian, and Matti Vuorre. "Ordinal regression models in psychology: A tutorial." Advances in Methods and Practices in Psychological Science 2, no. 1 (2019): 77-101.
- Engler, Jan Broder. "Tidyplots empowers life scientists with easy code‐based data visualization." Imeta 4, no. 2 (2025): e70018.
- Heisig, Jan Paul, and Merlin Schaeffer. "Why you should always include a random slope for the lower-level variable involved in a cross-level interaction." European Sociological Review 35, no. 2 (2019): 258-279.  
- Langsford, Steven, Amy Perfors, Andrew T. Hendrickson, Lauren A. Kennedy, and Danielle J. Navarro. "Quantifying sentence acceptability measures: Reliability, bias, and variability." (2019): 37.
- Matuschek, Hannes, Reinhold Kliegl, Shravan Vasishth, Harald Baayen, and Douglas Bates. "Balancing Type I error and power in linear mixed models." Journal of memory and language 94 (2017): 305-315.
- Sprouse, Jon. "Acceptability judgments and grammaticality, prospects and challenges." Syntactic structures after 60 (2018): 195-224. 
- Schütze, Carson T., and Jon Sprouse. 2018. “Judgment Data.” In Cambridge University Press eBooks, 27–50. https://doi.org/10.1017/cbo9781139013734.004.
- Taylor, Jack E., Guillaume A. Rousselet, Christoph Scheepers, and Sara C. Sereno. "Rating norms should be calculated from cumulative link mixed effects models." Behavior research methods 55, no. 5 (2023): 2175-2196.


---

*Esta lección fue desarrollada usando R 4.5.3, RStudio 2026.01.1+403, tidyverse 2.0.0, tidyplots 0.3.1 y ordinal 2023.12-4 bajo macOS Ventura 13.5.1. El conjunto de datos y el código completo están disponibles en el repositorio de la lección en GitHub.* 

## Notas
[^1]: Los requisitos para usar tidyplots son: 1. una versión reciente de R (3.6.0 o superior), 2. una versión reciente de ggplot2 (≥ 3.5.0), 3. tener los datos estructurados en formato tidy, es decir, cada variable debe tener su propia columna, cada observación debe tener su propia fila y cada valor debe tener su propia celda. Si los datos están en un formato amplio o desordenado, será necesario reformatearlos primero (por ejemplo, usando tidyr).
[^2]: Los esquemas de colores de tidyplots están disponibles en [la página oficial de tidyplots](https://jbengler.github.io/tidyplots/articles/Color-schemes.html)
[^3]: Debido a que el modelo más complejo (modelo1.1) no mostró problemas de convergencia ni singularidad, también podrían reportarse los resultados de este modelo (los modelos 1.1. y 1.2. muestran que los mismos efectos e interacciones son estadísticamente significativas). La decisión de seleccionar el modelo con la estructura de los efectos aleatorios máxima, recomendada por [Barr et. al. (2013)](https://pmc.ncbi.nlm.nih.gov/articles/PMC3881361/) vs. mediante la selección del modelo recomendado por [Matuschek et al (2017)](https://www.sciencedirect.com/science/article/pii/S0749596X17300013) depende de varios factores: el tamaño de la muestra, la complejidad del diseño experimental, el objetivo del análisis, etc., sobre los cuales se puede leer detalladamente en los dos artículos.  


