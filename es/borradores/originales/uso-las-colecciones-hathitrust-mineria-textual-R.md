---
title: "Uso de las colecciones del HathiTrust para el análisis de textos literarios en R"
slug: uso-las-colecciones-hathitrust-mineria-textual-R
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- José Eduardo González
reviewers:
- Forename Surname
- Forename Surname
editors:
- Joshua G. Ortiz Baco
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/579
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

# Objetivos

El propósito de esta lección es difundir el uso de conjuntos de datos con atributos extraídos (_Extracted Features_) que proporciona el Centro de Investigación de *HathiTrust* (o HTRC, por sus siglas en inglés) como una manera rápida y fácilmente accesible para comenzar a estudiar tendencias históricas y culturales a gran escala en textos literarios. Aunque esta lección se enfoca en los estudios literarios, podrás aplicar sin mayor problema las herramientas y estrategias que se presentan aquí a otras disciplinas. 

Al finalizar esta lección habrás aprendido a:

- Usar el lenguaje de programación R para accesar datos para miles de libros en español disponibles por el *HathiTrust*.
- Saber cómo crear y utilizar las “colecciones” de *HathiTrust* para obtener un conjunto de datos de los textos que estés interesado en estudiar.
- Aplicar técnicas de minería textual para seleccionar, filtrar y explorar los datos obtenidos.

# Introducción

Uno de los obstáculos mayores para avanzar el estudio de la humanidades digitales fuera del mundo anglosajón es la escasez de textos digitalizados a escala masiva. Aunque de los más de 15 millones de volúmenes que posee [*HathiTrust*](https://www.hathitrust.org/) solo una pequeña fracción [no es en inglés](https://www.hathitrust.org/blogs/ten-million-and-counting/), para muchos investigadores estos números pueden representar más de lo que está disponible en su idioma en otros sitios. Por ejemplo, un 6% de los volúmenes en *HathiTrust* son en español, lo que significa que hay más de medio millón de textos disponibles. En el caso de la literatura, significa que existen miles de volúmenes de diferentes géneros literarios producidos en los diferentes países de habla hispana. El Centro de Investigación ha puesto a tu alcance los datos de todos los volúmenes que poseen, gratis y ya pre-procesados. Esto incluye tanto los volúmenes cuyos derechos de autor han expirado como los que no. Es decir, aunque no puedes tener acceso directo a muchos de los textos debido a la ley de derechos de autor, el Centro te proporciona conjuntos de datos que contienen los “atributos extraídos” (“Extracted Features”) de esos volúmenes, incluyendo las frecuencias con que aparecen los _tokens_ (palabras y símbolos) en cada página. 

## Requisitos

Esta lección presupone que posees nociones básicas de R. De no ser así, te recomendamos completar primero los tutoriales [Datos tabulares básicos con R](https://programminghistorian.org/es/lecciones/datos-tabulares-en-r) de Trayn Dewar y [Administración de datos en R](https://programminghistorian.org/es/lecciones/administracion-de-datos-en-r) de Nabeel Siddiqui, ambos traducidos al español por Jennifer Isasi.

Aunque en teoría puedes practicar el código de este tutorial en una línea de comandos de R, estaremos usando el entorno de desarrollo [RStudio](https://www.rstudio.com/products/rstudio/download/#download) en nuestros ejemplos y te recomendamos que lo instales. Si no lo tienes aún, [en este video](https://www.youtube.com/watch?v=Nmu4WPdJBRo) encontrarás una guía sobre cómo descargarlo e instalarlo en Windows y en [este otro video](https://www.youtube.com/watch?v=OW66f1sBQOc) para hacer lo mismo en una Mac.

## Instalar y cargar paquetes

Para comenzar esta lección necesitas instalar el paquete de R llamado [hathiTools](https://github.com/xmarquez/hathiTools), el cual te proporcionará una interfaz para poder obtener los atributos extraídos y los metadatos de los libros en *HathitTrust*. Este paquete no es parte de CRAN, así que instalarlo requiere un paso adicional: tener instalado primero el paquete [remotes](https://cran.r-project.org/web/packages/remotes/index.html) y utilizarlo para instalar `hathiTools`. 

```{r}
install.packages("remotes")
remotes::install_github("xmarquez/hathiTools")
library(hathiTools)
```

Para manipular nuestros datos e importar algunos archivos, necesitas además tener instalados y cargados [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html), [readr](https://cran.r-project.org/web/packages/readr/index.html), [readxl](https://cran.r-project.org/web/packages/readxl/) y [stringr](https://cran.r-project.org/web/packages/stringr/index.html) y, por último, necesitas tener instalado **pero no cargado** el paquete de [plyr](https://cran.r-project.org/web/packages/plyr/index.html). Es conocido que `plyr` genera conflictos con el paquete de `dplyr` que es parte de `tidyverse` así que no recomendamos cargar ambos al mismo tiempo. La parte final de esta lección incluye la visualización de datos y necesitas tener los siguientes paquetes: [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html), [tmap](https://cran.r-project.org/web/packages/tmap/index.html), [rnaturalearth](https://cran.r-project.org/web/packages/rnaturalearth/index.html), [sf](https://cran.r-project.org/web/packages/sf/index.html).[^1]

```{r}
#para manipular datos y archivos
library(tidyverse)
library(readr)
library(readxl)
library(stringr)

#para mapas y visualización
library(rnaturalearth)
library(ggplot2)
library(tmap)
library(sf)
```

# Obtener los atributos extraídos de un volumen

Cada libro o volumen en *HathiTrust* posee un número de identificación único (o el "htid") el cual permite que obtengamos datos sobre el volumen. Cuando el libro no está limitado por los derechos de autor, puedes verlo añadiendo su número de identificación a un URL de la siguiente manera: `http://hdl.handle.net/2027/{número de identificación}`. Por ejemplo, el número que identifica una de las primeras ediciones de la clásica novela colombiana, *María* de Jorge Isaacs, es `uc1.31175010656638` y una visita al enlace [http://hdl.handle.net/2027/uc1.31175010656638](http://hdl.handle.net/2027/uc1.31175010656638) nos lleva a una copia de la obra.

{% include figure.html filename="es-or-uso-las-colecciones-hathitrust-mineria-textual-R-01.png" alt="Ejemplar de la novela María en el sitio HathiTrust" caption="Figura 1. 'María' de Jorge Isaacs" %}

Si estás buscando un libro escribiendo su título o autor en el cuadro de búsqueda de *HathiTrust*, tienes que asegurarte de seleccionar la opción de "Full View" para encontrar su número de identificación. El mismo número de identificación te permite utilizar `hathiTools` para tener acceso a los atributos extraídos. El comando `get_hathi_counts` va a guardar en la variable “maria” un `tibble` o marco de datos que contiene varios tipos de datos sobre la novela. 

```{r}
maria<-get_hathi_counts("uc1.31175010656638")

head(maria)

# A tibble: 6 × 6
  htid               token  POS   count section  page
  <chr>              <chr>  <chr> <int> <chr>   <int>
1 uc1.31175010656638 ww     UNK       1 body        4
2 uc1.31175010656638 -      UNK       1 body        4
3 uc1.31175010656638 NMARÍA UNK       1 body        7
4 uc1.31175010656638 II     PROPN     1 body        8
5 uc1.31175010656638 Plaza  PROPN     1 body        8
6 uc1.31175010656638 Isabel PROPN     1 body        8

```

Es muy probable que te encuentres con casos en que el número no funciona y no obtienes los datos extraídos como esperabas. Este es un problema conocido y la única solución es encontrar otra versión del volumen que te interesa y utilizar ese número nuevo. 

Antes de explorar los detalles de los resultados recibidos, hagamos un pequeño ejercicio. Parte de la información que obtenemos de *HathiTrust* es los tokens y las páginas en las que aparecen. Ya que recibes los datos en forma de marco de datos, puedes utilizar las técnicas del paquete `dplyr` que has aprendido en [otros tutoriales](https://programminghistorian.org/es/lecciones/administracion-de-datos-en-r#requisitos), como filtrar (`filter`) y resumir (`summarise`). Puedes así filtrar todos los tokens según la página asociada y contar cuántos tokens existen por páginas con solo una línea de código.

```{r}
tokens_maria <- maria %>%
  group_by(page) %>%
  summarise(num_tokens = sum(count))

head(tokens_maria)
# A tibble: 6 × 2
   page num_tokens
  <int>      <int>
1     4          2
2     7          1
3     8         12
4     9         25
5    11        304
6    12        434
```

Visualizar los resultados te muestra que el número de palabras por página es bastante uniforme, excepto por el comienzo y el final del volumen donde tienes muchas páginas en blanco o con información que no es parte de la narración principal. 

```{r}
plot(tokens_maria$page, tokens_maria$num_tokens, col="blue", type="l", lwd=1, xlab="páginas", ylab="tamaño")
```
Tu resultado debe ser similar a este:

{% include figure.html filename="es-or-uso-las-colecciones-hathitrust-mineria-textual-R-02.png" alt="Visualización de la distribución de tokens por página en la novela María" caption="Figura 2. Tokens por página en 'María'" %}

Podemos filtrar nuestros datos para encontrar las divisiones entre capítulos y añadirlos al gráfico. Para lograrlo, sin embargo, es necesario saber la palabra exacta que el texto utiliza para ser dividido en partes. EN este caso, la palabra es "capítulo" en letras mayúsculas. 

```{r}
capitulos<-maria  %>% filter(token %in% "CAPÍTULO") 

#gráfico
plot(tokens_maria$page, tokens_maria$num_tokens, col="blue", type="l", lwd=1, xlab="páginas por capítulo", ylab="palabras")
abline(v = capitulos$page, col="red", lwd=1, lty=1)
```

Como ves en la figura 3, es interesante que la novela comienza con una serie de capítulos cortos y los más extensos aparecen después de casi el primer cuarto del texto.

{% include figure.html filename="es-or-uso-las-colecciones-hathitrust-mineria-textual-R-03.png" alt="Visualización de la distribución de tokens por capítulo en la novela María" caption="Figura 3. Tokens por capítulo en 'María'" %}

Además, es una buena idea deshacerse de la sección del volumen que viene antes del primer capítulo. En este caso porque, entre otras cosas, contiene un prólogo que no es parte de la narración. En este caso sabemos que la novela comienza en la página 17, y ahora hay que encontrar la página donde se acaba la historia y eliminar lo que venga después, ya sean índices o glosarios.

```{r}
maria %>%
  filter(token %in% "FIN") %>%
  select(page)

# A tibble: 1 × 1
   page
  <int>
1   443
```
Ya que sabes donde comienza y termina el texto narrativo, puedes eliminar las páginas que no se necesitan (incluyendo los _tokens_ que están en ellas). Para verificar el cambio, cuenta cuántos tokens hay en el marco de datos antes y después de la operación.

```
#cuenta los tokens que nos han llegado de HathiTrust
maria %>% summarise(num_tokens = sum(count))

# A tibble: 1 × 1
  num_tokens
       <int>
1     111886

#elimina  las secciones no deseadas
maria<-maria %>% filter(page >= 17 & page =<443)

#cuenta otra vez

maria %>% summarise(num_tokens = sum(count))

# A tibble: 1 × 1
num_tokens
       <int>
1     109892

``` 

El nuevo marco de datos `maria` solo contiene lo que se encuentra entre las páginas 17 y 443. En esta digitalización de la novela fue muy fácil encontrar dónde estaban los capítulos y el fin de la narración con solo filtrar los datos, pero no todos los volúmenes que tiene *HathiTrust* están en tan buenas condiciones. A veces será necesario que vayas a la página en su web para encontrar lo que necesitas y eso solo será posible si el libro no está protegido por los derechos de autor. 

## Una mirada global a nuestro marco de datos

Además de la información sobre tokens y páginas, en los atributos extraídos del volumen encuentras varios otros detalles. Cada columna del marco de datos posee un nombre que describe un atributo extraído. El primero, “htid”, es el número de identificación del volumen, el cual usaste para obtener sus datos. El segundo es “token” o una palabra o símbolo en el texto. “POS” es la parte del habla (o discurso) a que corresponde cada token -- etiquetado siguiendo los ["universal dependencies"](https://universaldependencies.org/u/pos/all.html) (en inglés). Le siguen “count” o la frecuencia de cada palabra en la página, "section" o la sección de la página en la que se encuentra el token, y por último el número de página. Los valores posibles en la columna "section" incluyen “header” (encabezado), “body” que es el cuerpo principal de la página, y “footer” (el pie de la página). Por ejemplo, podemos leer en la tabla de abajo que la palabra “dulce” es un adjetivo que ocurre una vez en el cuerpo de la página 37 y "Salomón" es un nombre propio que aparece tres veces en la misma página. Nótese que el número de página no coincide necesariamente con el número impreso en las páginas del libro cuando miras la reproducción de imagen en el sitio de web. El número que nos da *HathiTrust* como parte de los datos corresponde a las páginas creadas en el proceso de escanear el volumen. 

<div class="table-wrapper" markdown="block">
	
| htid | token | POS | count | section | page |
| -----| ----- | --- |-------|---------|------|
| uc1.31175010656638 | sentada | ADJ | 1 | body | 37 |
| uc1.31175010656638 | Salomón | PROPN | 3 | body | 37 |
| uc1.31175010656638 | arreglar | VERB | 1 | body | 37 |
| uc1.31175010656638 | poniéndo | VERB | 1 | body | 37 |
| uc1.31175010656638 | dulce | ADJ | 1 | body | 37 |
| uc1.31175010656638 | sollozando | VERB | 1 | body | 37 |
| uc1.31175010656638 | derramando | VERB | 1 | body | 37 |
| uc1.31175010656638 | pies | NOUN | 3 | body | 37 |

</div>

### Número de tokens por página
Las opciones para clasificar los tokens que te proporciona este marco de datos son muchas. Digamos que quieres solamente contar los tokens en el cuerpo principal del texto. Al incluir el nombre de la columna puedes indicar la sección que te interesa. 

```{r}
maria %>%
  filter(section == "body") %>%
  group_by(page) %>%
  summarise(num_tokens = sum(count))


#A tibble: 425 × 2
    page num_tokens
   <int>      <int>
 1    18        242
 2    19        253
 3    20        274
 4    21        219
 5    22        271
 6    23        278
 7    24        219
 8    25        245
 ```
 
Algunas páginas tienen ahora una cantidad menor de tokens. Si en adición a esto quieres eliminar todo lo que no sea una palabra (números, signos) o errores que hayan sido introducidos al texto como resultado del proceso de digitalización, he aquí una de las muchas maneras en que puedes hacerlo. Filtra todos los tokens en el cuerpo principal (“body”)  que sean de caracter alfabético y elimina lo que no lo sea.

```{r}
maria %>%
  filter(section == "body", !str_detect(token, "[^[:alpha:]]")) %>%
  group_by(page) %>%
  summarise(num_tokens = sum(count))

# A tibble: 6 × 2
   page num_tokens
  <int>      <int>
1    18        217
2    19        227
3    20        242
4    21        199
5    22        239
6    23        248
```

Notarás que ahora el número de tokens por página se ha reducido todavía más. 

### Análisis de las partes del discurso por página

La columna "POS" que clasifica las palabras según la parte del habla a la que se refiere, te será muy útil en casos cuando trabajes con textos publicados después de 1928[^3] a los que no tienes acceso completo y necesites saber el contexto en que una palabra está siendo utilizada. Por ejemplo, digamos que te interesa localizar la frecuencia con que aparecen en *María* las palabras que aluden a las enfermedades, no sólo de la protagonista sino de otros personajes en la historia. Con frecuencia el autor también utiliza la palabra “mal” (“había muerto de un mal”, “síntomas de su mal”) para referirse a las enfermedades, pero en otras ocasiones la misma palabra podría ser un un adjetivo o un adverbio. Los siguientes comandos ayudan a solucionar este problema.

```{r}

#crea un vector con las palabras que quieres encontrar
palabras_a_buscar<-c("enfermar", "enferma","enfermedad","enfermedades", "mal","enfermo","enfermos")

#busca esas palabras filtrando nuestra columna de tokens
enfermedad_maria<-maria  %>% filter((str_to_lower(token) %in% palabras_a_buscar))

#elimina la palabra "mal" si aparece como un adjetivo o un adverbio  
enfermedad_maria<-enfermedad_maria %>% filter(!(token=="mal" & POS=="ADJ"))
enfermedad_maria<-enfermedad_maria %>% filter(!(token=="mal" & POS=="ADV"))

#observa los resultados
head(enfermedad_maria)

# A tibble: 6 × 6
  htid               token      POS   count section  page
  <chr>              <chr>      <chr> <int> <chr>   <int>
1 uc1.31175010656638 mal        NOUN      1 body       58
2 uc1.31175010656638 mal        NOUN      1 body       59
3 uc1.31175010656638 enfermedad NOUN      1 body       61
4 uc1.31175010656638 enferma    ADJ       2 body       65
5 uc1.31175010656638 enfermar   PROPN     1 body       66
6 uc1.31175010656638 enfermedad NOUN      1 body       67

```

# Trabajar con colecciones de HathiTrust

Aventurarse en el mundo de estudiar tendencias culturales o literarias requiere que uses mucho más que un par de volúmenes. Si vas a sacar provecho de los recursos de *HathiTrust* necesitas una manera eficaz de obtener los libros que quieres para tu tema, sus números de identificación y los metadatos correspondientes. En inglés existen conjuntos de datos que ya contienen los números de identificación de *HathiTrust* para varios grupos de textos, tanto dentro de este sitio de web, como en otros lugares de la internet. Véase por ejemplo [este conjunto de datos](https://view.data.post45.org/mlphathi) que contiene los libros de ficción en inglés que han ganado premios literarios importantes desde principios del siglo 20, o [este otro](https://view.data.post45.org/nytfull), exclusivamente enfocado en las listas de libros más vendidos publicadas por el *New York Times*. En español, lamentablemente, todavía no contamos con colecciones similares. 

La escasez de recursos hace indispensable que crees tus propias listas de volúmenes y sus números de identificación. Recomiendo por eso que empieces tu investigación creando una “colección” de los libros que te interesa estudiar. El primer paso consiste en crear una cuenta en el portal de [*HathiTrust*](https://www.hathitrust.org/). En la página principal vas a ir a la sección de “Log in”, en la parte superior derecha, y allí te vas a encontrar con dos opciones: 
1. Si perteneces a una de las instituciones afiliadas a *HathiTrust* puedes seleccionar esa opción y continuar.
2. Crear una cuenta como usuario invitado siguiendo el enlace [“See options to log in as guest”](https://babel.hathitrust.org/cgi/wayf?) que aparece en la parte de abajo del mensaje. Esa es la opción que usaremos en este tutorial.

{% include figure.html filename="es-or-uso-las-colecciones-hathitrust-mineria-textual-R-04.png" alt="Ventana para crear una cuenta en HathiTrust" caption="Figura 4. Enlace para usuarios invitados" %}

El [enlace](https://babel.hathitrust.org/cgi/wayf?) que ves en la figura 4 te lleva a página para crear tu cuenta y allí te da entre sus opciones conectarla a alguna de tus cuentas de redes sociales como Facebook o tu identidad de Google. Selecciona lo que prefieras. Una vez creada la cuenta, te encontrarás de nuevo en la página principal. 

En la parte superior de la página principal verás un menú pequeño llamado "The Collection" y de él vas a seleccionar la opción "Featured Collections" (colecciones destacadas) o puedes utilizar [este enlace](https://babel.hathitrust.org/cgi/mb?colltype=featured) para ir allí directamente. 
 
En "Featured Collections" tendrás la opción de mirar colecciones que otros hayan hecho o puedes crear la tuya. Un apartado a la izquierda te dará varias opciones. Puedes, por ejemplo, buscar entre las más de ocho mil "Shared Collections" (colecciones que los usuarios han hecho públicas y las puedes ver, copiar o usar), o dentro de "Featured Collections" (las colecciones más destacadas, seleccionadas por los que trabajan para *HathiTrust*), y, finalmente, una sección dedicada a colecciones creadas por ti, "My Collections", que estará vacía en este momento. 

## Crear tu propia colección

Vamos a crear una colección. Usa el botón “New Collection” de la parte derecha de [esta página](https://babel.hathitrust.org/cgi/mb?colltype=featured) y te lleva a una ventana donde podemos darle un nombre a la colección, añadir información descriptiva sobre la misma (lo que hará que sea más fácil que otros la encuentren), y declarar la lista como privada o pública. La mía se va a llamar "Novelas de los 60 (México)". Una vez creada la nueva categoría o colección, puedes buscar los volúmenes que quieres incluir en tu grupo. Para este ejemplo, vamos a buscar un par de novelas. La primera será *Los recuerdos del porvenir* de Elena Garro, la cual podemos encontrar usando el catálogo. Visita la siguiente página: [https://catalog.hathitrust.org/Record/001589298](https://catalog.hathitrust.org/Record/001589298)

{% include figure.html filename="es-or-uso-las-colecciones-hathitrust-mineria-textual-R-05.png" alt="Información sobre la novela de Elena Garro" caption="Figura 5. Los recuerdos del porvenir de Garro" %}

Un par detalles importantes hay que notar de esta sección que contiene la información sobre el libro de Garro. La primera es que nos informa que no podemos ver este volumen, como hicimos en el caso de *María*, y que solo tenemos un acceso limitado de búsqueda (“Limited (search only)”). Esto, como ya he explicado, para nada afecta el acceso a los tokens y los metadatos sobre el libro a través del lenguaje R. Tenemos tres enlaces que dicen "Limited" lo cual significa que hay tres copias digitales de esta misma impresión de 1963 y que vienen de tres universidades diferentes. Esto no significa que no hayan otras versiones de *Los recuerdos del porvenir* publicadas en otros años en la biblioteca de *HathiTrust*. Tener tantas copias disponibles es beneficioso para los usuarios, pues si una de las copias es de mala calidad (o por razones técnicas no está disponible), puedes usar otra--o puedes usar una edición de fecha diferente. 

Si sigues uno de los tres enlace de “Limited (search only)” te encuentras con una nueva página y allí, a la izquierda, verás el menú “Collections”. Como ya has creado tu colección para estas novelas, ahora tienes la opción de fácilmente añadirla al grupo. Hagamos eso antes de continuar. Si te fijas en el URL que te ha traído a esta sección del sitio ([https://babel.hathitrust.org/cgi/pt?id=uc1.32106010929724](https://babel.hathitrust.org/cgi/pt?id=uc1.32106010929724)), verás que contiene también el número de identificación de *HathiTrust* (`uc1.32106010929724`) para ese volumen. 
 	
{% include figure.html filename="es-or-uso-las-colecciones-hathitrust-mineria-textual-R-06.png" alt="La página para crear tus propias colecciones en HathiTrust" caption="Figure 6. MyCollections" %}
	

Vamos a añadir dos novelas más a la colección. Visita los próximos enlaces y tal como hiciste con *Los recuerdos del porvenir*, usando el enlace “Limited (search only)”, añade cada uno de estos libros a la colección. 

- *Oficio de tinieblas* de Rosario Castellanos [https://catalog.hathitrust.org/Record/008321507](https://catalog.hathitrust.org/Record/008321507)
- *La muerte de Artemio Cruz* de Carlos Fuentes [https://catalog.hathitrust.org/Record/001037543](https://catalog.hathitrust.org/Record/001037543)

Puedes añadir otros libros que te interesen. Una vez hayas terminado de incluir todo lo que quieras, regresa a la página de ["Featured Collections"](https://babel.hathitrust.org/cgi/mb?colltype=featured). El menú "The Collection" aparece en todas las páginas de *HathiTrust* y siempre puedes usarlo para encontrar tu camino de vuelta a tus colecciones. Te encontrarás con que la sección “My Collections” contiene el grupo que acabas de crear, "Novelas de los años 60 (México)". Selecciona la colección y te lleva a una página donde puedes modificar (añadir o eliminar elementos, etcétera) su contenido. A mano izquierda, te vas a encontrar con una sección llamada “Download Metadata” donde puedes descargar a tu computadora los metadatos asociados con los volúmenes en esta colección. Notarás que entre las opciones para el formato de lo que vas a descargar se encuentra “Tab-Delimited Text (TSV)” que es un tipo de archivo donde los valores se encuentran separados por tabuladores (puede ser leído por programas de hojas de cálculo). Si lo descargas obtendrás un archivo de terminación .txt cuyo nombre tiene más de veinte números. Cada vez que descargues el archivo poseerá un número diferente. Es una buena idea darle a este archivo un nombre relacionado a tu proyecto y cambiar la terminación a `.tsv`. En la próxima sección de esta lección aprenderás a usar tus colecciones para  proyectos de humanidades digitales.

# Geografía en la novela ecuatoriana

Para este ejemplo vamos a utilizar una colección que ya hemos preparado de antemano y clasificado de “pública” para que cualquier persona pueda tener acceso a ella y lo que es más importante para este tutorial, descargar los metadatos. Construir una colección depende mucho del conocimiento que posees sobre tu tema previo a la búsqueda de los libros que incluirás en ella. Por ejemplo, sería imposible usar las opciones de búsqueda disponibles en *HathiTrust* para encontrar novelas ecuatorianas ya que es una categoría demasiado específica. Lo mismo sucederá con la mayoría de los temas en que te interese estudiar. Utilizar libros de consulta o artículos de investigación especializada sobre tu tema es lo más apropiado, aunque puede tener la desventaja de que tu colección se limite a los libros más conocidos o a lo que los expertos han decidido que es importante. 

Vamos a comenzar esta sección de la lección siguiendo [este enlace](https://babel.hathitrust.org/cgi/mb?a=listis&c=665267101) que te llevará a nuestra colección de novelas ecuatorianas. En "Download Metadata" descarga el archivo con los datos y cambia su nombre a `100_Novelas_de_Ecuador.tsv` (También puedes obtenerlo como parte de [los archivos incluidos para esta lección](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/uso-las-colecciones-hathitrust-mineria-textual-R/100_Novelas_de_Ecuador.tsv). Una vez tienes una copia descargada, puedes importar este archivo a R. Por supuesto, antes de hacerlo, debes asegurarte que estás en la carpeta correcta. Para leer un documento `.tsv` desde R necesitas llamar la librería `reader` primero y después usar el comando `read_tsv`. Una vez el archivo ha sido importado, podemos ver las diferentes categorías de metadatos que contiene con tan solo leer los nombres de las columnas. 
```{r}
>metadatos<- read_tsv("100_Novelas_de_Ecuador.tsv")

>colnames(metadatos)

#[1] "htid"                    "access"                  "rights"                 
[4] "ht_bib_key"              "description"             "source"                 
[7] "source_bib_num"          "oclc_num"                "isbn"                   
[10] "issn"                    "lccn"                    "title"                  
[13] "imprint"                 "rights_reason_code"      "rights_timestamp"       
[16] "us_gov_doc_flag"         "rights_date_used"        "pub_place"              
[19] "lang"                    "bib_fmt"                 "collection_code"        
[22] "content_provider_code"   "responsible_entity_code" "digitization_agent_code"
[25] "access_profile_code"     "author"                  "catalog_url"            
[28] "handle_url"             
```

La columnas que usarás para este ejercicio son “htid”, “author”, “title” y “rights_date_used”. En “htid” vas a encontrar el número de identificación que asigna *HathiTrust* al volumen. Las columnas de “author” (autor) y “title” (título) poseen la misma información que has visto en la página de “Catalog Record”. Y, finalmente, “rights_date_used” (fecha para decidir los derechos) es la fecha en la que esa edición de la obra ha sido publicada. Esta fecha puede coincidir con la fecha de publicación, si el volumen que se encuentra en *HathiTrust* es la publicación original. Es la fecha que se utiliza para decidir si los usuarios tienen acceso libre al texto completo del volumen o no.[^2] Las otras columnas no las usaremos para este tutorial, pero puedes encontrar detalles de lo que significan en [esta página](https://www.hathitrust.org/hathifiles_description), por si acaso te son útiles en el futuro. 

Ahora que tenemos los metadatos de la colección, el próximo paso es "limpiarlos" un poco. Primero selecciona las columnas que te interesan.

```{r}
metadatos<-metadatos %>% select(htid, author, title, rights_date_used)
```

Ya que para este proyecto necesitamos saber con exactitud cuándo las novelas fueron publicadas, hemos creado un documento en una hoja de cálculo con la columna de los números de htid y la columna “rights_date_used” que están en el [`100_Novelas_de_Ecuador.tsv`](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/uso-las-colecciones-hathitrust-mineria-textual-R/100_Novelas_de_Ecuador.tsv) de la colección, y hemos corregido las fechas para que reflejen el año de la primera publicación de la obra. El archivo, [`fechas.xls`](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/uso-las-colecciones-hathitrust-mineria-textual-R/fechas.xls), lo encuentras en [los documentos que acompañan a esta lección](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/uso-las-colecciones-hathitrust-mineria-textual-R). El próximo paso será combinar ese archivo con los metadatos de las novelas.

```{r}
fechas <- read_excel("fechas.xls")

#usamos los htid para combinar la nueva columna de fechas
metadatos<-cbind(publicacion=fechas$publicacion[match(metadatos$htid, fechas$htid)], metadatos)

#eliminamos la columna con las fechas equivocadas
metadatos<-metadatos %>% select(htid, author, title, publicacion)
```

En los metadatos, los nombres de los autores y títulos posiblemente fueron creados automáticamente y pueden presentar errores o necesitar corrección. Por ejemplo, veamos lo que ocurre si queremos saber cuántos de nuestros libros fueron escritos por el autor indigenista Jorge Icaza. 

```{r}
metadatos %>% filter(str_detect(author, "Icaza")) %>% select(author, title)

# A tibble: 4 × 2
  author                   title                                    
  <chr>                    <chr>                                    
1 Icaza, Jorge, 1906-1978. En las calles (novela) [por] Jorge Izaca.
2 Icaza, Jorge, 1906-1978. Huairapamushcas; novela.                 
3 Icaza, Jorge, 1906-1978. Cholos : novela. --                      
4 Icaza, Jorge.            Huasipungo              
```

El proceso de transformación de tus datos será diferente para cada colección, dependiendo de los problemas que encuentres, pero algunos de los próximos pasos fucionarán para muchos casos. Si miras el ejemplo de Icaza, notarás varios patrones en los que están escritos los nombres de los autores. En uno de ellos las fechas de un autor siempre siguen la segunda coma; en otro caso, no hay fechas y al final solo hay un punto. Es obvio que la manera más fácil de uniformar esta columna es eliminar las fechas para todos. 

Usa el siguiente comando con una [expresión regular](https://es.wikipedia.org/wiki/Expresión_regular) para borrar todo lo que aparece después de la segunda coma:

```{r}
metadatos$author<-sub("^([^,]*,[^,]*),.*", "\\1", metadatos$author)
```
Repite el comando anterior para ver el cambio en estas filas:

```{r}
metadatos %>%
  filter(str_detect(author, "Icaza")) %>%
  select(author, title)

#       author          title
1  Icaza, Jorge 	En las calles (novela) [por] Jorge Izaca.
2  Icaza, Jorge         Huairapamushcas; novela.
3  Icaza, Jorge        	Cholos : novela. --
4  Icaza, Jorge.        Huasipungo
```

Todavía quedan cuatro nombres que no se han modificado (las filas 3, 36, 77, 94). Si los revisas, verás que tres de ellos siguen un segundo patrón en el que las fechas siguen un punto después del nombre. Antes de hacer más cambios, vamos a ver las cuatro filas que nos interesa cambiar:

```{r}
filtro_regex <- metadatos[c(3, 36, 77, 94), "author"]
print(paste("Antes de modificar:", filtro_regex))

[1] "Antes de modificar: Tobar, Carlos R. 1854-1920." 
[2] "Antes de modificar: Martínez, Luis A. 1869-1909."
[3] "Antes de modificar: Lemos R., Gustavo 1878-1936."
[4] "Antes de modificar: Rendón, Víctor M. 1859-1940."

```
Las tres que siguen el patrón con el punto después del nombre, se pueden modificar de la siguiente manera:

```{r}
metadatos$author[c(3,36,94)]<-sub("\\...*", "", metadatos$author[c(3,36,94)])

#Veamos el resultado de nuestro comando:
filtro_regex <- metadatos[c(3, 36, 77, 94), "author"]
print(paste("Después de modificar:", filtro_regex))

[1] "Después de modificar: Tobar, Carlos R"             
[2] "Después de modificar: Martínez, Luis A"            
[3] "Después de modificar: Lemos R., Gustavo 1878-1936."
[4] "Después de modificar: Rendón, Víctor M"
```

Nos falta por arreglar el nombre de un autor que sigue un patrón diferente a los demás porque sus fechas vienen después de un espacio (y no de coma o punto).

```{r}
metadatos$author[77]<-sub("\\s+[^ ]+$", "", metadatos$author[77])

#Una vez más, veamos cómo ha quedado después de nuestra modificación:
filtro_regex <- metadatos[c(3, 36, 77, 94), "author"]
print(paste("Después de modificar:", filtro_regex))

[1] "Después de modificar: Tobar, Carlos R"  
[2] "Después de modificar: Martínez, Luis A" 
[3] "Después de modificar: Lemos R., Gustavo"
[4] "Después de modificar: Rendón, Víctor M" 
```

Si queda algún punto al final de los nombres, vamos a eliminarlo. Y para asegurarnos que no hay información que nos impida contar correctamente cuántos escritores tenemos, vamos a convertir todos los nombres al mismo formato, eliminando de paso los acentos o tildes.

```{r}
metadatos$author<-stringr::str_remove(metadatos$author, "\\.*$")

metadatos$author<-iconv(metadatos$author,from="UTF-8",to="ASCII//TRANSLIT")

```

Finalmente, podemos crear una tabla y ver la frecuencia de los nombres de autores. 

```{r}
as.data.frame(table(metadatos$author)) %>% filter(Freq > 3)

#                            Var1 Freq
1                   Icaza, Jorge    4
2           Moscoso Vega, Luis A    4
3 Pareja y Diez Canseco, Alfredo    6
4             Salvador, Humberto    4
```

Hay muchas razones por las que se puede querer limpiar los metadatos. Por ejemplo, dependiendo de tu proyecto, la cantidad de textos que vienen del mismo autor puede ser un factor importante para obtener una representación que refleje correctamente el tema que estudias. Si quieres, un buen ejercicio sería intentar limpiar los títulos de las novelas de manera similar a lo que hicimos con los autores. Por último, recuerda que los metadatos se encuentran en un documento de formato `.tsv` y que puedes leerlo con un programa de hojas de cálculo y modificarlo para añadir información (por ejemplo, el género de los autores) o corregir errores antes de importarlo a R. 

## Obtener los atributos extraídos para el proyecto

Como ya sabes, la columna de “htid” en los metadatos es importante porque te permitirá obtener los archivos que poseen atributos extraídos de los volúmenes en tu colección. El primer método para obtener esta información que voy a describir usa el programa [Rsync](https://es.wikipedia.org/wiki/Rsync) que los sistemas operativos de Linux y Mac ya tienen instalados. Este programa se utiliza para copiar archivos entre computadoras, entre otras funciones, y representa la manera más rápida para obtener grandes cantidades de archivos del sitio de *HathiTrust*. Si estás utilizando el sistema operativo Windows, puedes instalar Rsync de manera que funcione con R, pero éste puede ser un proceso complicado que va más allá de lo que cubre esta lección. Por eso, para los que trabajan en Windows, y los que tengan problemas con el funcionamiento de Rsync en su sistema, en la próxima sección de este tutorial presentamos una manera alternativa de obtener los atributos extraídos. 

El primer paso para obtener los datos que necesitamos es designar una carpeta temporal en la que guardarás los archivos que vengan de *HathiTrust*. En los próximos dos pasos, vas a usar la lista de "htids" para obtener los archivos con atributos extraídos (“EF files”), guardarlos en tu carpeta y luego ponerlos en la memoria temporal de tu sistema para que puedas usarlos en tu sesión de R. Para este ejemplo vamos a descargar los cien volúmenes en la colección, pero si solo quisieras algunos de ellos puedes indicar los que necesitas usando el número de fila (por ejemplo, si solo quieres los primeros diez, `metadatos$htid[1:10]`). Finalmente, guardamos todos los resultados en una variable. Ten paciencia, el tiempo que los próximos pasos se tomen en tu computadora dependerá de factores como la capacidad de tu máquina y el tamaño de tu colección. Procedamos a ejecutar los siguientes comandos:

```{r}
#selecciona una carpeta temporal donde guardar los archivos
tmpdir<-"~/documentos/tmp"

#adquiere los archivos
rsync_from_hathi(metadatos$htid, dir = tmpdir)

#pon los archivos en la memoria temporal para usarlos con Rstudio
cache_htids(metadatos$htid, dir = tmpdir)

#guarda los atributos extraídos (EF) en una variable
novelas<-read_cached_htids(metadatos$htid, dir=tmpdir, cache_type = "ef")
```

Concluído el proceso revisamos las dimensiones de nuestro marco de datos  y vemos que contiene más de cuatro millones de filas y seis columnas. 
```{r}
dim(novelas)
```

Podemos reducir su tamaño si eliminamos todo lo que no sean palabras o que forme parte del cuerpo principal de los libros:

```{r}
novelas<-novelas %>% filter(section == "body", !str_detect(token, "[^[:alpha:]]"))

dim(novelas)
```

Ahora puedes obtener la frecuencia de los tokens y el resultado será un marco de datos con tres variables: el número de identificación de cada novela, el token y su frecuencia en ese texto.


```{r}
novelas <- novelas %>%
  group_by(token, htid) %>%
  summarise(num_tokens = sum(count))

dim(novelas)

head(novelas)
# A tibble: 6 × 3
# Groups:   token [1]
  token htid               num_tokens
  <chr> <chr>                   <int>
1 A     hvd.32044018906883        197
2 A     inu.30000027536063         46
3 A     inu.32000004726644         64
4 A     inu.32000004730166        130
5 A     inu.32000004794600        291
6 A     inu.32000004798858         88

```

Con este marco de datos y los metadatos que descargaste de *HathiTrust*, estás listo para analizar y visualizar tus datos.

### Windows: Otra manera de construir el marco de datos

Antes de proceder a analizar este conjunto de novelas, veamos una manera alternativa de obtener los atributos extraídos de *HathiTrust*. Es un poco más lento, probablemente demandará más recursos de tu sistema, pero representa una alternativa si trabajas en Windows y no tienes Rsync, o si por alguna razón tu instalación de Rsync no funciona correctamente. Si regresas al ejemplo con que empezamos esta lección, la novela *María*, recordarás que usamos la función `get_hathi_counts()` y su número de "htid" para obtener los tokens de ese libro. 

Como ese método solo es capaz de adquirir un volumen a la vez, necesitamos crear nuestra propia función con un bucle *for* que vaya guardando la información para cada número htid que tenemos. Para este tutorial hemos incluido una función que no sólo logra este cometido, sino que además te notifica si algunos de tus números de htid no funcionan. El código se encuentra en el archivo  [`obtener_tokens.r`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/uso-las-colecciones-hathitrust-mineria-textual-R/obtener_tokens.r) y necesitas ponerlo en la misma carpeta en la que tienes tu proyecto de R. Para cargarlo usa el siguiente comando.

```{r}
source("obtener_tokens.r")
```

Ahora simplemente puedes usar la lista de números htid que tienes en los metadatos de tu colección y guardar el resultado en una variable:

```
resultado<-obtener_tokens(metadatos$htid)
```

El resultado es una lista que contiene dos elementos. El primero son los atributos extraídos y el segundo son los números htid de los archivos que no fueron encontrados por alguna razón.

```{r}
novelas<- resultado[1]
no_encontrado<-resultado[2]
```

El primer elemento del resultado se convierte en nuestro marco de datos con atributos extraídos. Si alguno de tus archivos no se descargó, puedes ver su número en la variable “no_encontrado”.

```{r}
novelas<-as.data.frame(novelas)
```

Notarás que tu marco de datos posee las mismas dimensiones que cuando usas Rsync y a partir de este punto puedes seguir los mismos pasos que en el apartado anterior para limpiar los datos y obtener las frecuencias.

```{r}

novelas<-novelas %>% filter(section == "body", !str_detect(token, "[^[:alpha:]]"))

novelas <- novelas %>%
  group_by(token, htid) %>%
  summarise(num_tokens = sum(count))


```

## Análisis y visualización de datos 

Ahora tienes un conjunto de datos en un formato que es perfecto para cualquier tipo de proyecto de minería textual que te interese. En términos generales, nuestro ejemplo trata de estudiar los cambios que las menciones de lugares geográficos en la novela ecuatoriana han experimentado a través de los años. Este tipo de análisis textual enfocado en la presencia de localizaciones geográficas en la ficción no es, por supuesto, nuevo y se ha realizado con éxito en la literatura anglosajona.[^4] Empezaremos por usar una división tradicional de la novela en Ecuador que ve los comienzos de este género literario en tres periodos: el siglo 19, las décadas de 1900 a 1925, y finalmente los años que van de 1925 a 1950.[^5] En los metadatos vamos a crear tres grupos que corresponden a esas fechas. 
```
metadatos<-metadatos %>%
  mutate(GRUPO = case_when(
    publicacion > 1860 & publicacion <= 1900  ~ "Pre-1900",
    publicacion > 1900 & publicacion <= 1925 ~ "1900-25",
    publicacion > 1925 & publicacion <= 1950 ~ "1925-50",
    TRUE ~ NA_character_
  ))
```

Nuestro conjunto de datos posee 100 documentos publicados entre 1861 y 1949, cuya longitud varía de menos de diez mil palabras a casi doscientos mil, con una media de 59,558. Para contar la frecuencia de las ciudades habrá que tomar en cuenta el aspecto de la extensión del texto para determinar la importancia de estas menciones. Así que antes de buscar las ciudades vamos a añadir una columna que contenga la longitud de cada volumen individual. 

```{r}
para_comparar_ciudades <- novelas %>%
  group_by(htid) %>%
  mutate(total_volumen = sum(num_tokens))
```

Para filtrar las ciudades que son mencionadas en las novelas, [tenemos ya preparada una hoja de cálculos que podemos importar con los nombres de las ciudades más importantes](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/uso-las-colecciones-hathitrust-mineria-textual-R/ciudades.xls). No es difícil encontrar información sobre cualquier país que te interese y su población según el último censo. La mía viene de [Wikipedia](https://es.wikipedia.org/wiki/Anexo:Ciudades_de_Ecuador). Además de los nombres de las ciudades, en mi archivo he incluído los nombres de las provincias en las que están las ciudades y el número de identificación de [Woe](https://es.wikipedia.org/wiki/WOEID)) de las provincias, el cual usaremos para identificar esas regiones en el mapa.

Para ver cuáles ciudades aparecen en nuestros libros, filtra los tokens. Notarás que se crea un nuevo marco de datos con las frecuencias para cada ciudad según el número de htid del libro. 

```{r}
ciudades<-read_excel("ciudades.xls")

ciudades_encontradas<-para_comparar_ciudades %>% filter(token %in% ciudades$Ciudad_breve)
```

El próximo paso es unir información de los metadatos con los resultados de nuestra búsqueda y añadir los nombres de las provincias de cada ciudad encontrada.

```
#añade las fechas de publicación
ciudades_encontradas<-cbind(fecha_pub=metadatos$publicacion[match(ciudades_encontradas$htid, metadatos$htid)], ciudades_encontradas)

#añade los grupos
ciudades_encontradas<-cbind(GRUPO=metadatos$GRUPO[match(ciudades_encontradas$htid, metadatos$htid)], ciudades_encontradas)

#añade las provincias
ciudades_encontradas<-cbind(prov=ciudades$Provincia[match(ciudades_encontradas$token, ciudades$Ciudad_breve)], ciudades_encontradas)

#añade en número Woe para cada provincia
ciudades_encontradas<-cbind(woe_id=ciudades$woe_id[match(ciudades_encontradas$prov, ciudades$Provincia)], ciudades_encontradas)
```

Una observación que ya podemos hacer, sin tener que complicar el proceso mucho, está relacionada con la diversidad de ciudades mencionadas en cada grupo. Quito y Guayaquil fueron los centros urbanos más grandes de Ecuador a principios del siglo 20, y por supuesto están presentes en nuestros resultados, pero de los otros cientos de ciudades que buscamos, ¿cuántas ciudades se mencionan?

```{r}
ciud_unicas<-unique(ciudades_encontradas[c("GRUPO", "token")])
table(ciud_unicas$GRUPO)

 1900-25  1925-50 Pre-1900 
      71      133       54 
```

Es interesante ver en el tercer grupo (1925-50), la presencia de ciudades que antes no habían aparecido en los textos narrativos. Vamos a utilizar una manera bastante sencilla de comparar frecuencias en diferentes grupos de textos. El primer paso es dividir las frecuencias de las ciudades por la cantidad total de tokens en cada libro y después multiplicar esa división por 50,000 que es aproximadamente la media de nuestros textos en la colección.[^6]

```{r}
ciudades_encontradas <- ciudades_encontradas |>
  group_by(htid) %>%
  mutate(ocurrencias_por_50_mil = (num_tokens * 50000) / total_volumen)

```

El próximo paso agrupa los datos primero por fechas y luego por provincias para que así sumemos las  "ocurrencias por 50 mil" de las ciudades en cada provincia según los periodos históricos.

```
ciudades_encontradas <- ciudades_encontradas |>
  group_by(GRUPO, prov) |>
  mutate(num_por_prov = sum(ocurrencias_por_50_mil))```

Ahora puedes crear los mapas para cada periodo histórico para visualizar los resultados. Para ello, necesitas cargar la librería `rnaturalearth` y `tmap`, si no lo has hecho, y luego los datos para el país de Ecuador en [formato "sf"](https://en.wikipedia.org/wiki/Simple_Features).

```
ecuador <- ne_states(country = "ecuador", returnclass = "sf")
ggplot(data = ecuador) +
  geom_sf()
```

Como verás el mapa ya tiene las divisiones administrativas (provincias) del país, así que solo necesitarás combinar la información del grupo de novelas que quieres visualizar con la del mapa. Veamos los pasos para hacerlo para el periodo que abarca el siglo 19. Seleccionamos primero las columnas necesarias del grupo "Pre-1900", y una de ellas va a ser la que tiene el número de WOE. El marco de datos del mapa también posee la misma columna, así que podremos usar "inner_join" para combinar los dos.

```
#selecciona las columnas que combinaremos

grupo_a_usar<-"Pre-1900"
#grupo_a_usar<-"1900-25"
#grupo_a_usar<-"1925-50"

pre_1900 <- ciudades_encontradas |>
  filter(GRUPO == "Pre-1900") |>
  select(GRUPO, woe_id, prov, num_por_prov) |>
  unique()
nuestros_datos <- pre_1900


#combina tus datos con la información del mapa usando "woe_id"

mapa_ecuador <- inner_join(
  nuestros_datos,
  ecuador,
  by = "woe_id"
)


#al combinar los datos se pierden las coordenadas del país, así que recupéralas con el siguiente comando
mapa_ecuador <- st_as_sf(mapa_ecuador)

#si quieres, verifica que funcionó
st_crs(mapa_ecuador)

```

Ahora podemos ver una visualización simple del mapa con `qtm`.

```
qtm(mapa_ecuador, fill = "num_por_prov")
```

O podemos hacer una más elaborada, añadiendo las dos ciudades principales. 

```

nombre <- c('Guayaquil', 'Quito')
lat <- c(-2.21, -0.19)
long<-c(-79.9, -78.5)

#marco de datos con las coordenadas
ciudades_en_mapa <- data.frame(nombre,lat,long)

#crear los objetos/puntos
ciudades_en_mapa <- ciudades_en_mapa %>%
  st_as_sf(coords = c("long", "lat"), crs = 4326) %>%
  st_cast("POINT")
 
##mapa pre-1900
tm_shape(mapa_ecuador) +
  tm_polygons(col = "num_por_prov", midpoint = 0, title="")+
  tm_shape(ciudades_en_mapa) +
  tm_text("nombre")+
  tm_layout(legend.text.size = 0.4,
            legend.position = c("right","bottom"),
            legend.bg.alpha = 0.3)
 
```

{% include figure.html filename="es-or-uso-las-colecciones-hathitrust-mineria-textual-R-07.png" alt="Visualización del periodo anterior a 1900" caption="Figura 7. Mapa pre-1900" %}

Sigue los mismos pasos para crear gráficos para los otros periodos (cambia la variable "grupo_a_usar" más arriba). Después de crear los mapas, compáralos. Verás que el foco de atención va cambiando de Quito a Guayaquil hacia principios de siglo 20. También notarás que en esos primeros dos mapas casi no hay casi representación del resto del país. El tercer mapa muestra que ambos Quito y Guayaquil siguen siendo el foco de atención, pero también otros territorios surgen con frecuencias más altas.

# Limitaciones y recomendaciones

El propósito de este tutorial es presentar un ejemplo de cómo obtener y manipular los datos de *HathiTrust* para la minería textual. Nuestra lección es simple y también lo es el método (una lista de ciudades) que usamos para localizar lugares geográficos. Realizar una investigación seria, enfocada en la geografía literaria, requiere (1) utilizar programas especializados que ayuden a localizar las entidades geográficas en un texto y (2) utilizar textos completos (no solo tokens) en los que se pueda verificar los contextos de las palabras por si hay duda en cuanto las referencias. También se necesitaría incluir otras entidades (regiones, parques, lagos, calles, etc, que pudieran contarse como alusiones a ciudades específicas). A pesar de sus limitaciones, los datos que podemos obtener de *HathiTrust* son un fantástico recurso para explorar nuevas ideas, desarrollar teorías, o investigar una tesis de manera preliminar a estudios más rigurosos. 

Cuando selecciones los volúmenes para crear tu colección, escoge de ser posible la primera edición del libro pues de esa manera no tendrá introducciones, prólogos u otro material que puede introducir tokens no relacionados al texto principal. Si estás trabajando con cientos de volúmenes es posible que estos tokens adicionales no representen un gran problema por la escala del proyecto, pero es una buena idea evitarlos ya que no siempre será posible (o práctico) eliminarlos como hicimos en el ejemplo de *María*. Trabajar con los datos de cientos de volúmenes puede ocasionar que `Rstudio` deje de funcionar y en esos casos una solución será trabajar directamente en la consola de R, o utilizar un entorno que funcione con pocos recursos como [Rcommander](https://es.wikipedia.org/wiki/R_Commander), para el cual puedes encontrar [varios](https://estadistica-dma.ulpgc.es/cursoR4ULPGC/12-Rcommander.html) [manuales](https://www.uv.es/conesa/CursoR/material/Manual-R-commander.pdf) en internet.

Por último, si creas una colección interesante en *HathiTrust*, hazla pública y compártela con otros que estén interesados en tu tema.


# Notas

[^1]: La versión actual de `tmap` va a dar paso pronto a una nueva y es posible que recibas un mensaje sobre esto al instalar el paquete. Si deseas empezar a utilizar ya la versión más reciente, puedes instalarla con el paquete [remotes](https://cran.r-project.org/web/packages/remotes/index.html) que usaste anteriormente para instalar `hathiTools`. Usa el siguiente comando: `remotes::install_github('r-tmap/tmap')`.
[^2]: *HathiTrust* se rige por la [ley de derechos de autor](https://es.wikipedia.org/wiki/Ley_de_derechos_de_autor_de_los_Estados_Unidos) de los Estados Unidos, la cual declara que los derechos expiran después de 95 años (es decir 1928 desde nuestro punto de vista en 2023) de una obra ser publicada. 
[^3]: Es decir, aunque *María* haya sido publicada inicialmente en 1867, si la edición que estás tratando de ver en *HathiTrust* fue editada después de 1928, entonces no tendrás acceso directo al texto, pero sí a las características extraídas de antemano. 
[^4]: Véase el trabajo de Matthew Wilkens, "The geographic imagination of Civil War-era American fiction." *American literary history* 25, no. 4 (2013): 803-840, y "Too isolated, too insular: American Literature and the World." *Journal of Cultural Analytics* 6, no. 3 (2021). 
[^5]: Angel F. Rojas, *La novela ecuatoriana*, Fondo de Cultura Económica, 1948.
[^6]: Véase Douglas Bieber, Susan Conrad, y Randi Reppen. *Corpus linguistics: Investigating language structure and use*. Cambridge University Press, 1998. (página 263). Wilkens usa este método de normalizar las frecuencias, pero de una manera más sofisticada como lo explica en sus artículos (nota 2).
 
