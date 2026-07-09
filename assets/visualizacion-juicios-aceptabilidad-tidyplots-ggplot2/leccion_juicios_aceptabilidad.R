## ============================================================================
## VISUALIZACIÓN DE JUICIOS DE ACEPTABILIDAD CON TIDYPLOTS Y GGPLOT2
## Gráficos rápidos e interpretables para la adquisición de segundas lenguas
## VERSIÓN ANOTADA: cada operación se explica en detalle
## ============================================================================
##
## Estudio de caso: adquisición del aspecto verbal en español como L2.
## 60 aprendientes eslovacos de español (nivel avanzado) y 20 hablantes
## nativos de español peninsular evaluaron en una escala Likert de 7 puntos
## la aceptabilidad de 18 pares de oraciones que combinaban dos tiempos
## verbales (PPS: pretérito perfecto simple "canté"; PPC: pretérito perfecto
## compuesto "he cantado") con tres tipos de modificadores temporales.
##
## Archivo de datos necesario: datos_aceptabilidad.csv
## ============================================================================


## ============================================================================
## 1. PREPARACIÓN DEL ENTORNO Y CARGA DE DATOS
## ============================================================================

install.packages(c("tidyverse", "tidyplots", "ordinal", "emmeans")) # descarga e instala paquetes desde CRAN.

library(tidyverse) # carga los paquetes instalados
library(tidyplots)


setwd("/Users/zuzana/Documents") # establece el directorio de trabajo indicándole a R en qué carpeta del ordenador debe buscar el archivo
datos <- read_csv("datos_aceptabilidad.csv") # lee el archivo de texto
glimpse(datos) # revisa las variables del archivo datos_aceptabilidad.csv
datos <- datos |>
  mutate(across(c(group, instruction, tense, adverb_type), as.factor)) # conviete las variables group, instruction, tense, adverb_type en factores


## ============================================================================
## 2. CÁLCULO DE PUNTUACIONES MEDIAS POR CONDICIÓN
## ============================================================================

# Esta cadena de pipes calcula, para cada combinación de grupo (nativo/
# aprendiente), tiempo verbal y tipo de modificador adverbial, 
# error estándar de los juicios de aceptabilidad (rating).
resumen <- datos |> # calcula la media y el error estándar de los juicios de cada tiempo verbal en combinación con cada modificador adverbial para cada grupo de participantes
  group_by(group, tense, adverb_type) |>
  summarise(
    media = mean(rating, na.rm = TRUE),
    ee    = sd(rating, na.rm = TRUE) / sqrt(n()),
    .groups = "drop"
  )
resumen # visualizamos el resumen


## ============================================================================
## 3. GRÁFICOS RÁPIDOS CON TIDYPLOTS
## ============================================================================

## ---- 3.1 Gráfico de violín simple: rating por L1 y tiempo verbal (Fig. 1) --

violinchart00 <- datos |> 
  tidyplot(x = l1, y = rating, color = tense) |> # especifica las variables 
  add_violin(draw_quantiles = 0.5) |> # el tipo de gráfico
  adjust_title("Distribución de juicios por L1 y tiempo verbal") |> # cambia el título del gráfico
  adjust_x_axis_title("L1") |> #cambia la etiqueta del eje X.
  adjust_y_axis(limits = c(1, 7), breaks = 1:7)  # fija el rango visible del eje entre 1 y 7 (los extremos reales de la escala Likert usada en el estudio) y  genera las marcas del eje en cada entero de 1 a 7
violinchart00 # imprime el objeto "violinchart00" en la consola/visor de gráficos
ggsave("violinchart00.png", plot = violinchart00) # guarda el último gráfico como archivo de imagen en el directorio de trabajo fijado con setwd().

## ---- 3.2 Gráfico de violín facetado por L1 (Fig. 2) ------------------------

violinchart01 <- datos |>
  tidyplot(x = tense, y = rating, color = adverb_type) |> # especifica las variables de los ejes x, y, y asigna un color diferente a cada divel de adverb_type 
  add_violin() |> # especifica el typo de gráfico
  add_mean_dot() |> # añade, dentro de cada violín, un punto que marca la media de las puntuaciones de esa condición
  split_plot(by = l1) |> # divide el gráfico en varios paneles, uno por cada nivel de la columna l1 
  adjust_x_axis_title("Tiempo verbal") |> # cambia la etiqueta del eje X
  adjust_y_axis_title("Juicio de aceptabilidad (1-7)") |> # cambia la etiqueta del eje Y
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |> # fija el rango visible del eje entre 1 y 7 (los extremos reales de la escala Likert usada en el estudio) y  genera las marcas del eje en cada entero de 1 a 7
  adjust_colors(c("#1B7837", "#762A83")) |> # reemplaza la paleta de colores por defecto con un vector de colores 
  adjust_title("Los juicios según el tiempo verbal y el modificador adverbial: Hablantes nativos vs. aprendientes de español") #cambia el título del gráfico
violinchart01 # imprime el objeto "violinchart01"


## ---- 3.3 Gráfico de violín facetado por tipo de instrucción (Fig. 3) -------

violinchart02 <- datos |>  
  filter(group == "learner") |> # conserva las filas con los datos de los aprendientes 
  tidyplot(x = tense, y = rating, color = adverb_type) |> # especifica las variables de los ejes x, y, y asigna un color diferente a cada divel de adverb_type 
  add_violin() |> # especifica el typo de gráfico
  add_mean_dot() |> # añade, dentro de cada violín, un punto que marca la media de las puntuaciones de esa condición
  split_plot(by = instruction) |> # crea un panel por cada nivel de instruction (bilingüe vs. ELE)
  adjust_x_axis_title("Tiempo verbal") |>  # cambia la etiqueta del eje X
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |>  # fija el rango visible del eje entre 1 y 7 (los extremos reales de la escala Likert usada en el estudio) y  genera las marcas del eje en cada entero de 1 a 7
  adjust_y_axis_title("Juicio de aceptabilidad (1-7)") |> # fija el rango visible del eje entre 1 y 7 (los extremos reales de la escala Likert usada en el estudio) y  genera las marcas del eje en cada entero de 1 a 7
  adjust_colors(c("#1B7837", "#762A83")) |> # reemplaza la paleta de colores por defecto con un vector de colores 
  adjust_title("Los juicios según el tiempo verbal y el modificador adverbial: Instrucción bilingüe vs. ELE") # cambia el título de gráfico 
violinchart02 # imprime el objeto "violinchart02"


## ---- 3.4 Diagrama de caja con barras de error (Fig. 4) ---------------------

boxplot01 <- datos |>
  tidyplot(x = adverb_type, y = rating, color = l1) |> # especifica las variables de los ejes x, y, y asigna un color diferente a cada divel de L1
  add_boxplot() |> # dibuja un diagrama de caja: la caja marca el rango intercuartílico (percentiles 25 y 75), la línea interior la mediana, y los bigotes se extienden
  # hasta el valor más extremo dentro de 1.5 veces el rango intercuartílico (los puntos más allá de eso se dibujan como valores atípicos).
  # adjust_x_axis(rotate_labels = TRUE) gira las etiquetas del eje X (los nombres largos como "anterioridad_inmediata") en diagonal, para que no se superpongan entre sí.
  adjust_x_axis(rotate_labels = TRUE) |> # gira las etiquetas del eje X para que no se superpongan
  adjust_x_axis_title("Tipo de modificador adverbial") |> # cambia la etiqueta del eje X
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |> # fija el rango visible del eje entre 1 y 7 (los extremos reales de la escala Likert usada en el estudio) y  genera las marcas del eje en cada entero de 1 a 7
  adjust_y_axis_title("Juicio de aceptabilidad (1-7)") |>  # cambia la etiqueta del eje Y
  split_plot(by = tense) |> # crea un panel por cada tiempo verbal (PPC, PPS)
  adjust_title("Juicios de aceptabilidad por grupo y modificador adverbial: PPC vs. PPS") |>
  adjust_legend_title("L1")  # cambia el texto que encabeza la leyenda
boxplot01 # imprime el gráfico

## ---- 3.5 Gráfico de líneas con las medias por condición (Fig. 5) -----------

linechart01 <- resumen |> # especifica el dataframe de entrada "resumen" (las medias calculadas en la sección 2)
  tidyplot(x = adverb_type, y = media, color = group) |> # especifica las variables del eje X e Y, asigna un color diferente a cada divel de grupo (native, learner) 
  add_violin() |> # especifica el typo de gráfico
  add_line() |>  # conecta con una línea los puntos de "media" a lo largo del eje X (adverb_type), una línea por cada nivel de color (group) 
  adjust_x_axis_title("Tipo de modificador adverbial") |> # cambia la etiqueta del eje X
  adjust_y_axis_title("Juicio medio de aceptabilidad") |>  # cambia la etiqueta del eje Y
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |> # fija el rango visible del eje entre 1 y 7 (los extremos reales de la escala Likert usada en el estudio) y  genera las marcas del eje en cada entero de 1 a 7
  adjust_legend_title("Grupo") |> # cambia el texto que encabeza la leyenda
  split_plot(by = tense) |> # separa el gráfico en dos paneles: PPC  y PPS
  adjust_colors(new_colors = c("#2C7BB6", "#D7191C")) |> # asigna la paleta de colores
  adjust_x_axis(rotate_labels = TRUE) # gira las etiquetas del eje X para que no se superpongan
linechart01 # imprime el gráfico


## ---- 3.6 Gráfico de barras con medias y errores estándar (Fig. 6) ----------

barchart01 <- datos |>
  tidyplot(x = tense, y = rating, color = adverb_type) |> # especifica las variables del eje X e Y, asigna un color diferente a cada divel de adverb_type
  add_mean_bar(alpha = 0.7) |> # calcula la media de rating para cada combinación de x y color, dibújala como una barra y controla la opacidad de las barras (0 opaco, 1 completamente transparente)
  add_sem_errorbar() |> # añade, sobre cada barra, una línea de error
  add_mean_value() |> # imprime, como texto sobre o junto a cada barra, el valor numérico exacto de la media representada 
  split_plot(by = group) |> #crea un panel para nativos y otro para aprendientes
  adjust_x_axis_title("Tiempo verbal") |> # cambia la etiqueta del eje X
  adjust_y_axis_title("Juicio de aceptabilidad (1-7)") |> # cambia la etiqueta del eje Y
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |> # fija el rango visible del eje entre 1 y 7 (los extremos reales de la escala Likert usada en el estudio) y  genera las marcas del eje en cada entero de 1 a 7
  adjust_legend_title("Tipo de modificador") |> # cambia el texto que encabeza la leyenda
  adjust_title("Las medias de los juicios por grupo, tiempo verbal y modificador adverbial")
barchart01 # imprime el gráfico


## ---- 3.7 Diagrama de dispersión: AoA vs. juicio medio (Fig. 7) -------------

scatterplot01 <- datos |>
  filter(group == "learner") |> # filtra los datos para incluir solo los aprendientes
  group_by(participant_id, aoa, instruction) |> # agrupa las filas por participante y por sus valores fijos de aoa e instruction
  summarise(media_juicio = mean(rating), .groups = "drop") |> # calcula, para cada participante la media de todos sus juicios de aceptabilidad y elimina el  agrupamiento tras el cálculo
  tidyplot(x = aoa, y = media_juicio, color = instruction) |> #  especifica las variables del eje X e Y, # especifica las variables del eje X e Y, asigna un color diferente a cada divel de instruction (bilingual vs. ELE)
  add_data_points() |> # dibuja un punto por cada participante en la posición (aoa, media_juicio) correspondiente
  adjust_x_axis_title("Edad de adquisición del español") |> # cambia la etiqueta del eje X
  adjust_y_axis_title("Juicio medio de aceptabilidad") |> # cambia la etiqueta del eje Y
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |> # fija el rango visible del eje entre 1 y 7 (los extremos reales de la escala Likert usada en el estudio) y  genera las marcas del eje en cada entero de 1 a 7
  adjust_legend_title("Tipo de instrucción") |>  # cambia el texto que encabeza la leyenda
  adjust_colors(new_colors = c("#1B7837", "#762A83")) # asigna la paleta de colores
scatterplot01 # imprime el gráfico


## ============================================================================
## 4. COMPLEMENTAR TIDYPLOTS CON GGPLOT2
## ============================================================================
##
## La función add() permite insertar, dentro de una cadena de pipes de
## tidyplots, cualquier capa geom_*() u otra función de ggplot2 que no
## tenga un equivalente directo en tidyplots.
## ----------------------------------------------------------------------------

## ---- 4.1 Añadir líneas de regresión y línea de la media global (Fig. 8) ----

scatterplot02 <- scatterplot01 |>  # utiliza el gráfico de dispersión01 como base para modificarlo de la siguiente manera:
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |> # fija el rango visible del eje entre 1 y 7 (los extremos reales de la escala Likert usada en el estudio) y  genera las marcas del eje en cada entero de 1 a 7
  add(ggplot2::geom_smooth(method = "lm", se = FALSE)) |> # add() inserta una capa de ggplot2 dentro de la cadena de tidyplots
  add(ggplot2::geom_hline(yintercept = mean(resumen$media), # calcula la media de la columna "media" del dataframe "resumen" y usa ese valor como posición en el eje Y donde se dibuja la línea horizontal, inserta una línea horizontal de referencia, 
                         linetype = "dotted", color = "black"))
scatterplot02 # imprime el gráfico nuevo 


## ---- 4.2 Diferenciar grupos con colores y formas distintas (Fig. 9) --------

library(dplyr) 

datos_means <- datos |> # carga el paquete dplyr
  filter(group == "learner") |> # filtra los datos para incluir solo los aprendientes
  group_by(participant_id, aoa, instruction) |> # agrupa las filas por participante y por sus valores fijos de aoa e instruction
  summarise(mean_rating = mean(rating, na.rm = TRUE), .groups = "drop") # calcula, para cada participante la media de todos sus juicios de aceptabilidad y elimina el agrupamiento tras el cálculo

scatterplot03 <- datos_means |> 
  tidyplot(x = aoa, y = mean_rating, color = instruction) |> # especifica las variables del eje X e Y, asigna un color diferente a cada divel de instruction
  adjust_colors(new_colors = c("bilingual" = "#E69F00", "ELE" = "#0072B2")) |> # asigna explícitamente el color naranja (#E69F00) al nivel "bilingual" y el azul (#0072B2) al nivel "ELE
  adjust_title("Juicios medios según el tipo de instrucción: Bilingüe vs. ELE") |> # modifica el título del gráfico
  adjust_y_axis(limits = c(1, 7), breaks = 1:7) |> # fija el rango visible del eje entre 1 y 7 (los extremos reales de la escala Likert usada en el estudio) y  genera las marcas del eje en cada entero de 1 a 7
  add(ggplot2::geom_point(aes(shape = instruction), size = 2))  # añade una capa de puntos adicional aes(shape = instruction) -> mapea la forma del punto (círculo,
#     triángulo, etc.) al nivel de instruction, además del color ya
#     definido en tidyplot(); esto hace que los dos grupos se disting, especifica el tamaño de los puntos (size = 2) 
scatterplot03 #  imprime el gráfico


## ============================================================================
## 5. FACETING CON facet_grid() PARA COMPARAR DOS FACTORES SIMULTÁNEAMENTE
## ============================================================================ 

## ---- 5.1 Matriz de violines + boxplots: tiempo verbal x instrucción (Fig.10)

matrix <- datos |>
  filter(group == "learner") |> # filtra los datos para incluir solo los aprendientes
  ggplot(aes(x = adverb_type, y = rating, fill = tense)) + # aes() (aesthetic mappings) define qué columnas se asignan a qué propiedades visuales
  #   alpha = 0.3       -> opacidad baja, para que los boxplots superpuestos
  #     se vean con claridad a través del violín
  #   trim = TRUE        -> recorta los extremos del violín para que no se
  #     extiendan más allá del rango observado de los datos
  #   bounds = c(1, 7)   -> restringe la estimación de densidad al rango
  #     válido de la escala (1 a 7), evitando que el violín se extienda
  #     visualmente fuera de los límites posibles de la variable
  geom_violin(alpha = 0.3, trim = TRUE, bounds = c(1, 7)) + #  en ggplot2, las capas se añaden con el operador + (no con pipes), geom_violin() dibuja las formas de violín
  geom_boxplot(width = 0.15, alpha = 0.8, outlier.size = 0.8) +  # geom_boxplot() superpone un diagrama de caja delgado dentro de cada violín
  facet_grid(tense ~ instruction,  # facet_grid(filas ~ columnas) divide el gráfico en una cuadrícula de paneles
             labeller = labeller(
               tense       = c(PPS = "Pret. Perf. simple", PPC = "Pret. Perf. compuesto"),
               instruction = c(bilingual = "Bilingüe", ELE = "ELE"))) + #  reemplaza las etiquetas técnicas de cada panel (los nombres exactos de los niveles del factor, p. ej. "PPS") por etiquetas más legibles, sin cambiar los datos subyacentes.
  scale_fill_manual(values = c(PPS = "#4DAC26", PPC = "#D01C8B"),
                     guide = "none") + # scale_fill_manual() controla manualmente los colores usados por el mapeo fill = tense definido en aes().
  scale_y_continuous(limits = c(1, 7), breaks = 1:7) + # controla el eje Y numérico continuo, fijando el rango visible entre 1 y 7 y colocando una marca en cada entero de 1 a 7
  labs(x = "Tipo de modificador adverbial",
       y = "Juicio de aceptabilidad") +   # labs() define las etiquetas de los eje
  theme_bw(base_size = 11) + # theme_bw(base_size = 11) aplica un tema predefinido de ggplot2 (fondo
  # blanco con líneas de cuadrícula grises) y fija el tamaño base de fuente en 11 puntos
  theme(axis.text.x = element_text(angle = 55, hjust = 1),
        strip.background = element_rect(fill = "grey90")) # theme() permite ajustes finos adicionales sobre el tema ya aplicado:
#   axis.text.x = element_text(angle = 55, hjust = 1) rota las etiquetas
#     del eje X 55 grados y las alinea horizontalmente (hjust = 1, es
#     decir, ancladas por su extremo derecho) para que no se solapen
#   strip.background = element_rect(fill = "grey90") cambia el color de
#     fondo de las franjas de título de cada panel (donde aparecen
#     "Bilingüe", "ELE", etc.) a un gris claro
matrix #  imprime el gráfico


## ============================================================================
## 6. MATRIZ DE GRÁFICOS DE DISPERSIÓN (Fig. 11)
## ============================================================================
##
## Se usa la función pairs() de R base (no tidyplots ni ggplot2) para
## explorar simultáneamente las relaciones entre varias variables continuas.
## ----------------------------------------------------------------------------

slovak <- datos[datos$l1 == "Slovak", ] # datos$l1 extrae la columna l1 como vector; == "Slovak" genera un vector
# lógico (TRUE/FALSE) que indica, para cada fila, si su valor de l1 es
# "Slovak". El resultado es un data frame que conserva solo esas filas.

slovak_means <- slovak %>%
  group_by(participant_id, instruction, aoa, years_learning) %>%
  summarise(mean_rating = mean(rating, na.rm = TRUE), .groups = "drop")  #agrupa los datos por participante y por sus variables individuales

pairs(slovak_means[, c("mean_rating", "aoa", "years_learning")], # pairs() genera una cuadrícula de diagramas de dispersión, seleccionando solo esas tres columnas numéricas del data frame
      col  = c("red", "green")[slovak_means$instruction], # especifica vector de dos colores; indexalo con los niveles del factor instruction 
      pch  = c(1, 4)[slovak_means$instruction], # especifica la forma de los puntos
      main = "Matriz de Gráficos de dispersión", # fija el título general de la matriz de gráficos
      oma  = c(4, 4, 6, 6)) # (outer margins) reserva espacio extra alrededor de  toda la figura, en el orden abajo, izquierda, arriba, derecha (en líneas de texto), para que quepan el título y la leyenda 
legend("right",
       legend = levels(slovak_means$instruction),
       col    = c("red", "green"),
       pch    = c(1, 4),
       title  = "Instruction",
       cex    = 0.4, xpd = NA) # legend() añade una leyenda fuera del área de los paneles gracias al margen extra reservado con oma.


## ============================================================================
## 7. ANÁLISIS ESTADÍSTICO: MODELOS DE ENLACE ACUMULATIVO MIXTO (CLMM)
## ============================================================================
##
## Un modelo mixto incluye:
##   - Efectos fijos: predictores cuyo efecto se quiere estimar y generalizar.
##   - Efectos aleatorios: fuentes de variabilidad (participantes, ítems) que
##     deben controlarse para no distorsionar las estimaciones de los efectos
##     fijos.
## ----------------------------------------------------------------------------

install.packages("ordinal") #instala el paquete "ordinal", que contiene la función clmm() (Cumulative Link Mixed Model) para ajustar el modelo y emmeans para calcular medias marginales estimadas
library(ordinal) # carga los paquetes ordinal y emmeans
library(emmeans)


## ---- 7.1 Preparación de las variables para los modelos ---------------------

datos <- datos |>
  mutate(across(c(group, instruction, tense, adverb_type), as.factor)) # convierte en factor las variables group, instruction, tense, adverb_type 
datos$rating_ord <- factor(datos$rating, ordered = TRUE) # crea una nueva columna  "rating_ord", convierte la columna numérica en un factor ordenado para que clmm() lo trate como una variable ordinal    
datos_aprendientes <- datos |> # crea ub subconjunto del data frame que contiene solo las filas de aprendientes (para usarlos en los modelos 2.1. y 2.2)
  filter(group == "learner")
datos_aprendientes$aoa_s <- as.numeric(scale(datos_aprendientes$aoa)) # estandariza el vector numérico aoa
datos_aprendientes$years_learning_s <- as.numeric(scale(datos_aprendientes$years_learning)) # estandariza el vector numérico years_learning
# Estandarizar los predictores continuos facilita la interpretación de los
# coeficientes del modelo (cada unidad representa una desviación estándar)
# y suele mejorar la convergencia numérica del modelo.


## ============================================================================
## 7.2 MODELO 1: efecto del grupo (nativo vs. aprendiente) y las variables
##     lingüísticas (tiempo verbal, tipo de modificador adverbial)
## ============================================================================

## ---- Modelo 1.1: estructura de efectos aleatorios máxima -------------------

# Los efectos aleatorios incluyen:
# para los participantes: un intercepto aleatorio, pendientes aleatorias para tense
# pendientes aleatorias para adverb_type, pendientes aleatorias para la interacción tense × adverb_type
# además de todas las correlaciones entre estos efectos aleatorios, 
# para los ítems: un intercepto aleatorio.

modelo1.1 <- clmm(
  rating_ord ~ group * tense * adverb_type +
    (1 + tense * adverb_type | participant_id) + (1 | item_id),
  data = datos,
  link = "logit",
  threshold = "flexible"
)
summary(modelo1.1) # imprimimos el output del modelo1.1

## ---- Modelo 1.2: estructura de efectos aleatorios simplificada -------------

# La fórmula de efectos fijos es idéntica a la del modelo 1.1, pero la parte
# de efectos aleatorios se simplifica: (1 + tense | participant_id) solo
# incluye intercepto aleatorio y pendiente aleatoria para tense, eliminando
# la pendiente aleatoria para adverb_type y su interacción con tense (que en
# el modelo 1.1 podían estar generando problemas de convergencia o de
# sobreajuste por exceso de parámetros a estimar con estos datos).
modelo1.2 <- clmm(
  rating_ord ~ group * tense * adverb_type +
    (1 + tense | participant_id) +
    (1 | item_id),
  data = datos,
  link = "logit",
  threshold = "flexible"
)
summary(modelo1.2) # imprimimos el output del modelo1.2

## ---- Comparación de los modelos 1.1 y 1.2 -----------------------------------

# AIC() (Akaike Information Criterion) y BIC() (Bayesian Information
# Criterion) calculan, para cada modelo pasado como argumento, un índice que
# penaliza tanto el mal ajuste como el exceso de parámetros; valores más
# bajos indican mejor equilibrio entre ajuste y parsimonia. Pasar los dos
# modelos como argumentos separados por coma hace que la función devuelva
# una tabla comparativa.
AIC(modelo1.1, modelo1.2)
BIC(modelo1.1, modelo1.2)

# anova(modelo1.1, modelo1.2) realiza una prueba de razón de verosimilitudes
# (likelihood ratio test) entre los dos modelos anidados, para determinar si
# la estructura aleatoria más compleja del modelo 1.1 ajusta
# significativamente mejor los datos que la del modelo 1.2 (H0: no hay
# diferencia significativa).
anova(modelo1.1, modelo1.2)

# summary() imprime la salida completa de un modelo ajustado: coeficientes
# de los efectos fijos (estimación, error estándar, valor z, valor p),
# varianzas y covarianzas de los efectos aleatorios, y los umbrales
# estimados entre categorías.
summary(modelo1.1) # imprimimos el output del modelo2.1
summary(modelo1.2) # imprimimos el output del modelo2.2. 
# Inspeccionamos los coeficientes del modelo para asegurarnos de que el modelo no presenta singularidad (coeficientes cercanos a -1)

## ---- Medias marginales estimadas y comparaciones por pares -----------------

emm1 <- emmeans(modelo1.2, ~ group | tense * adverb_type) #  calcula las medias marginales estimadas (estimated marginal means) del modelo1.2 para cada nivel de group (nativo/aprendiente) para cada combinación de tense y adverb_type
# Imprime la tabla de medias marginales estimadas, con su error estándar e
# intervalos de confianza.
emm1 # Imprime la tabla de medias marginales estimadas, con su error estándar e intervalos de confianza
pairs(emm1, adjust = "bonferroni") # calcula, dentro de cada combinación de tense y adverb_type, la comparación por pares entre los niveles de group


## ============================================================================
## 7.3 MODELO 2: diferencias individuales dentro del grupo de aprendientes
## ============================================================================

## ---- Modelo 2.1: estructura de efectos aleatorios máxima -------------------

# Los efectos aleatorios incluyen:
# para los participantes: un intercepto aleatorio, pendientes aleatorias para tense
# pendientes aleatorias para adverb_type, pendientes aleatorias para la interacción tense × adverb_type
# además de todas las correlaciones entre estos efectos aleatorios, 
# para los ítems: un intercepto aleatorio.

modelo2.1 <- clmm(
  rating_ord ~ tense * adverb_type +
    instruction + aoa_s + years_learning_s +
    (1 + tense * adverb_type | participant_id) + (1 | item_id),
  data      = datos_aprendientes,
  link      = "logit",
  threshold = "flexible"
)
summary(modelo2.1) # imprimimos el output del modelo2.1

## ---- Modelo 2.2: estructura de efectos aleatorios simplificada -------------

# Misma fórmula de efectos fijos que modelo2.1, pero con la estructura de
# efectos aleatorios simplificada (solo pendiente aleatoria para tense),
# análogamente a la relación entre modelo1.1 y modelo1.2.
modelo2.2 <- clmm(
  rating_ord ~ tense * adverb_type +
    instruction + aoa_s + years_learning_s +
    (1 + tense | participant_id) + (1 | item_id),
  data      = datos_aprendientes,
  link      = "logit",
  threshold = "flexible"
)
summary(modelo2.2) # imprimimos el output del modelo2.2

## ---- Comparación de los modelos 2.1 y 2.2 -----------------------------------

# AIC() (Akaike Information Criterion) y BIC() (Bayesian Information
# Criterion) calculan, para cada modelo pasado como argumento, un índice que
# penaliza tanto el mal ajuste como el exceso de parámetros; valores más
# bajos indican mejor equilibrio entre ajuste y parsimonia. Pasar los dos
# modelos como argumentos separados por coma hace que la función devuelva
# una tabla comparativa.
AIC(modelo2.1, modelo2.2)
BIC(modelo2.1, modelo2.2)

# anova(modelo2.1, modelo2.2) realiza una prueba de razón de verosimilitudes
# (likelihood ratio test) entre los dos modelos anidados, para determinar si
# la estructura aleatoria más compleja del modelo 2.1 ajusta
# significativamente mejor los datos que la del modelo 2.2 (H0: no hay
# diferencia significativa).
anova(modelo2.1, modelo2.2)

# summary() imprime la salida completa de un modelo ajustado: coeficientes
# de los efectos fijos (estimación, error estándar, valor z, valor p),
# varianzas y covarianzas de los efectos aleatorios, y los umbrales
# estimados entre categorías. Inspeccionamos los coeficientes del modelo para asegurarnos de que el modelo no presenta singularidad (coeficientes cercanos a -1)
summary(modelo2.1) # imprimimos el output del modelo2.1
summary(modelo2.2) # imprimimos el output del modelo2.2
# Inspeccionamos los coeficientes del modelo para asegurarnos de que el modelo no presenta singularidad (coeficientes cercanos a -1)

## ============================================================================
## FIN DEL SCRIPT
## ============================================================================
##
## Resumen de los principales resultados:
## - Modelo 1.2: los hablantes nativos y los aprendientes difieren
##   significativamente en sus juicios según el tiempo verbal y el tipo de
##   modificador adverbial (efectos principales e interacciones dobles y
##   triples significativas, salvo para la anterioridad lejana en la
##   interacción triple).
## - Modelo 2.2: dentro del grupo de aprendientes, el tiempo verbal y el tipo
##   de modificador adverbial (y su interacción) son significativos, pero
##   ninguna de las diferencias individuales (instrucción, edad de
##   adquisición, años de aprendizaje) resultó significativa.
## ============================================================================
