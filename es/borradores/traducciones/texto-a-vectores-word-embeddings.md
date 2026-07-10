---
title: "Del texto a los vectores: cómo funcionan y se crean los word embeddings"
slug: texto-a-vectores-word-embeddings
original: understanding-creating-word-embeddings
layout: lesson
collection: lessons
date: 2026-07-09
translation_date: YYYY-MM-DD
authors:
- Avery Blankenship
- Sarah Connell
- Quinn Dombrowski
reviewers:
- Anne Heyer
- Ruben Ros
editors:
- Yann Ryan
translator:
- Patricia A. Loto
translation-editor:
- Isabelle Gribomont
translation-reviewer:
- Forename Surname
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/706
difficulty: 2
activity: analyzing
topics: [python, word-embeddings, machine-learning]
abstract: Los *word embeddings* permiten analizar el uso de distintos términos en un corpus de textos, capturando información sobre cómo se emplean en contexto. Desde una perspectiva principalmente teórica, esta lección te enseñará a preparar un corpus y entrenar un modelo de *word embeddings*. Explorarás cómo funcionan los vectores de palabras, cómo interpretarlos y cómo usarlos para responder preguntas de investigación en humanidades.
avatar_alt: Simple line drawing of a round goblin in a cloak and hat, tucked inside a chestnut.
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

Los *word embeddings* permiten analizar el uso de distintos términos en un corpus de textos, capturando información sobre cómo se emplean en contexto. Desde una perspectiva principalmente teórica, esta lección te enseñará a preparar un corpus y entrenar un modelo de *word embeddings*. Explorarás cómo funcionan los vectores de palabras (en inglés, *word vectors*), cómo interpretarlos y cómo usarlos para responder preguntas de investigación en humanidades.

## Objetivos de la lección

Esta lección está diseñada para que puedas dar tus primeros pasos con los modelos de *word embeddings*. Desde una perspectiva principalmente teórica, aprenderás a preparar tu corpus, cargarlo en una sesión de Python y entrenar un modelo. Explorarás cómo funcionan los vectores de palabras, cómo interpretarlos y cómo realizar algunas consultas exploratorias con ellos. Incluimos código introductorio para que puedas comenzar a trabajar con vectores de palabras, pero el foco principal está en proporcionarte los conocimientos fundamentales y los conceptos clave para utilizar modelos de *word embeddings* en tu propia investigación.

Si bien los *word embeddings* pueden implementarse de muchas formas distintas mediante diferentes algoritmos, esta lección no busca ofrecer una comparación en profundidad de dichos algoritmos —aunque en algunos momentos haremos referencia a ellos—. En cambio, nos centraremos en el algoritmo `word2vec`, que ha sido utilizado en una variedad de proyectos de humanidades digitales y ciencias sociales computacionales.[^1]

Esta lección emplea como caso de estudio el [corpus de novelas hispanoamericanas del siglo XIX](https://github.com/cligs/conha19).[^2] Elegimos este corpus en particular para demostrar algunas de las ventajas potenciales de trabajar con un corpus bien delimitado, así como para señalar algunas consideraciones específicas a tener en cuenta al trabajar con un corpus pequeño.

Hay muchas otras aplicaciones de investigación posibles para los modelos entrenados. Por ejemplo, la lección avanzada de *Programming Historian* sobre [*word embeddings*](https://programminghistorian.org/en/lessons/clustering-visualizing-word-embeddings) - Disponible en inglés- explica cómo agrupar y visualizar documentos mediante modelos de *word embeddings*. El [Women Writers Project](https://www.wwp.northeastern.edu/) también ha publicado una [serie de tutoriales en R y Python](https://github.com/NEU-DSG/wwp-public-code-share/tree/main/WordVectors) - Disponible en inglés- que cubren los aspectos básicos de ejecución de código, entrenamiento y consulta de modelos, validación de modelos entrenados y producción de visualizaciones exploratorias.

Al finalizar esta lección, habrás aprendido:

- Qué son los modelos de *word embeddings* y los vectores de palabras, y qué tipo de preguntas podemos responder con ellos
- Cómo crear e interrogar vectores de palabras usando Python
- Qué considerar al armar el corpus que quieres analizar con vectores de palabras
- Las limitaciones de los vectores de palabras como metodología para responder preguntas habituales

## Prerequisitos

Esta lección implica ejecutar código en Python: tener una familiaridad básica con Python es útil, aunque no se requiere ningún conocimiento técnico especializado. *Programming Historian* cuenta con una serie de [lecciones introductorias sobre Python](https://programminghistorian.org/es/lecciones/?topic=python&sortType=difficulty&sortOrder=asc) que podrías revisar. También puedes consultar esta breve [introducción a Python](https://github.com/NEU-DSG/wwp-public-code-share/blob/main/WordVectors/python/python-fundamentals.ipynb) - Disponible en inglés- publicada por el Women Writers Project, orientada a quienes se inician en los modelos de vectores de palabras.

Para ejecutar el código, puedes usar el [cuaderno Jupyter](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/texto-a-vectores-word-embeddings/texto-a-vectores-word-embeddings.ipynb) (*Jupyter notebook*, en inglés) de la lección en tu propia computadora. Si no estás familiarizada con los cuadernos Jupyter, puede resultarte útil revisar la [lección de *Programming Historian* sobre el tema](https://programminghistorian.org/en/lessons/jupyter-notebooks) - Disponible en inglés-.

### Requisitos del sistema

Esta lección está escrita pensando en el uso de Python, aunque la mayoría de los conceptos generales también aplican a R. Damos por supuesto que ya tienes conocimientos básicos de Python y que cuentas con un [entorno de desarrollo integrado](https://es.wikipedia.org/wiki/Entorno_de_desarrollo_integrado) (IDE, por las siglas en inglés de *Integrated Development Environment*) —como IDLE, Spyder o Jupyter Notebooks— instalado en tu computadora. Por eso, no explicamos cómo descargar e instalar Python ni las bibliotecas relevantes. El código de esta lección usa [Python 3.8.3](https://www.python.org/downloads/release/python-383/) y [Gensim 4.2.0](https://pypi.org/project/gensim/4.2.0/). [Gensim](https://en.wikipedia.org/wiki/Gensim) - Disponible en inglés- es una biblioteca de Python de código abierto desarrollada por Radim Řehůřek que permite representar un corpus como vectores.

La implementación específica de vectores de palabras que usa Gensim es [word2vec](https://code.google.com/archive/p/word2vec/), un algoritmo desarrollado en 2013 por Tomáš Mikolov y un equipo de Google para representar palabras en un espacio vectorial, publicado bajo una [licencia Apache](https://es.wikipedia.org/wiki/Apache_License) de código abierto. Si bien gran parte del código seguirá siendo aplicable en distintas versiones de Python y Gensim, es posible que sea necesario realizar algunos ajustes de sintaxis.

### Tamaño del corpus

Los *word embeddings* requieren una gran cantidad de texto para representar estas relaciones de manera razonable: no se obtendrán resultados significativos si se utilizan solo un par de novelas o un puñado de documentos históricos. El algoritmo aprende a predecir los contextos en que las palabras pueden aparecer a partir del corpus con el que fue entrenado, por lo que cuantas menos palabras tenga el corpus de entrenamiento, menos información tendrá para aprender.

Dicho esto, no existe un mínimo absoluto de palabras necesario para entrenar un modelo de *word embeddings*. El rendimiento varía según cómo se entrene el modelo, qué tipo de documentos se usen, cuántas palabras únicas aparecen en el corpus, y una variedad de otros factores. Aunque los corpus más pequeños pueden producir vectores menos estables,[^3] puede tener sentido trabajar con un corpus pequeño según el tipo de preguntas que te interese explorar. Si tu propósito es exploratorio, incluso un modelo entrenado con un corpus bastante pequeño debería producir resultados interesantes. Sin embargo, si encuentras que el modelo no parece coherente, eso podría indicar que necesitas agregar más textos a tu corpus de entrada o ajustar la configuración del entrenamiento.

## Teoría: introducción de conceptos

### *Word Embeddings*

¿Cuándo fue reemplazado el concepto astronómico de *revolución* orbital por el de levantamiento político? ¿Cómo cambian con el tiempo los métodos populares para cocinar pollo? ¿Cómo varían las asociaciones de palabras como *gracia* o *amor* entre oraciones y novelas románticas? Este tipo de indagaciones humanísticas puede resultar difícil de responder mediante métodos tradicionales como la lectura cercana.

Sin embargo, al usar *word embeddings*, podemos identificar rápidamente relaciones entre palabras y comenzar a responder este tipo de preguntas. Los *word embeddings* asignan valores numéricos a las palabras de un texto a partir de su relación con otras palabras. Estas representaciones numéricas, o "vectores de palabras" (*word vectors*, en inglés), nos permiten medir la distancia entre palabras y comprender mejor cómo se usan en contextos similares. Escalados a un corpus completo, los *word embeddings* pueden revelar relaciones entre palabras o conceptos dentro de un período histórico, un género de escritura o las obras completas de una persona autora.

A diferencia de los [modelos de tópicos](https://en.wikipedia.org/wiki/Topic_model) (*topic models*, en inglés) - Disponible en inglés- que se basan en la frecuencia de las palabras para comprender mejor el tema general de un documento, los *word embeddings* se orientan más hacia cómo se usan las palabras a lo largo de un corpus. Este énfasis en las relaciones y el uso contextual hace que los *word embeddings* estén especialmente equipados para abordar muchas preguntas que quienes trabajamos en humanidades podemos tener sobre un corpus determinado. Por ejemplo, puedes pedirle a tu modelo de *word embeddings* que identifique las diez palabras principales que se usan en contextos similares al de la palabra *gracia*. También puedes pedirle que genere esa misma lista, esta vez excluyendo el concepto *sagrada*. Incluso puedes pedirle que muestre las palabras de tu corpus más similares al concepto combinado de *gracia* y *sagrada*. La capacidad de realizar operaciones matemáticas básicas con conceptos —aunque bajo el capó ocurre una matemática mucho más compleja— para formular preguntas muy específicas sobre un corpus es uno de los beneficios clave de usar *word embeddings* para el análisis textual.

### Vectores de palabras

Los modelos de *word embeddings* representan las palabras mediante una serie de números que se denominan "vector de palabras" (*word vector*, en inglés). Un vector de palabras representa la posición de una palabra en un espacio multidimensional. Así como podríamos realizar operaciones matemáticas básicas con objetos que mapeamos en un espacio bidimensional (por ejemplo, visualizaciones con ejes X e Y), podemos realizar operaciones matemáticas algo más complejas con palabras mapeadas en un espacio multidimensional.

Un "vector" es un punto en el espacio que tiene tanto "magnitud" (o "longitud") como "dirección". Esto significa que los vectores se parecen menos a puntos aislados y más a líneas que trazan un recorrido desde un punto de origen hasta la posición designada del vector, en lo que se denomina "espacio vectorial". Los modelos creados con vectores de palabras, llamados "modelos de *word embeddings*", usan vectores de palabras para capturar las relaciones entre palabras según qué tan cerca están unas de otras en el espacio vectorial.

Puede sonar complicado y abstracto, pero comencemos con un tipo de vector de palabras más directo: la [matriz documento-término](https://es.wikipedia.org/wiki/Matriz_t%C3%A9rmino-documento).

### Matrices documento-término

Una forma de representar un corpus de textos es mediante una "matriz documento-término": una tabla de gran tamaño en la que cada fila representa una palabra y cada columna representa un texto del corpus. Las celdas se completan con la cantidad de apariciones de esa palabra en ese texto específico. Si se incluyen absolutamente todas las palabras de todos los textos en esta matriz —incluyendo nombres propios, errores tipográficos y palabras poco frecuentes—, se obtendrá una tabla donde la mayoría de las celdas tendrá valor 0, porque la mayoría de las palabras simplemente no aparece en la mayoría de los textos. Esta configuración se denomina "representación vectorial dispersa" (*sparse vector representation*, en inglés). Además, la matriz se vuelve más difícil de manejar a medida que aumenta el número de palabras, llenándose con cada vez más ceros. Esto resulta problemático porque se necesita una gran cantidad de palabras para tener suficientes datos que representen el lenguaje de forma significativa.

La innovación de algoritmos como `word2vec` consiste en representar las relaciones entre palabras de forma "densa". Los distintos algoritmos adoptan enfoques diferentes con consecuencias en la salida del modelo, pero todos utilizan un proceso llamado "incrustación" (*embedding*, en inglés) para hacer que el vector sea más pequeño y mucho más eficiente. En lugar de un vector con decenas de miles de dimensiones —que incluiría información sobre la relación de cada palabra única con todas las demás—, estos modelos de *word embeddings* suelen utilizar solo unos pocos cientos de dimensiones abstractas que, aun así, logran capturar la información más esencial sobre las relaciones entre distintos grupos de palabras.

### word2vec

`word2vec` fue el primer algoritmo desarrollado para crear modelos de *word embeddings* y sigue siendo uno de los más populares. Es un modelo predictivo, lo que significa que calcula la probabilidad de que: 1) una palabra aparezca en un contexto determinado (usando el método de bolsa continua de palabras, o CBOW, por las siglas en inglés de *Continuous Bag of Words*), o bien 2) que un contexto determinado ocurra para una palabra dada (usando el método *skip-gram*).

Para esta introducción, no necesitas preocuparte por las diferencias entre estos métodos. Si quieres aprender más sobre cómo se entrenan los modelos de *word embeddings*, hay muchos recursos disponibles en línea, como la guía ["Word2vec ilustrado"](https://jalammar.github.io/illustrated-word2vec/) de Jay Alammar - Disponible en inglés-. Ambos métodos tienden a rendir de manera similar, pero *skip-gram* suele funcionar mejor con conjuntos de datos más pequeños y representa con mayor éxito las palabras menos frecuentes; el método CBOW, en cambio, tiende a representar mejor las palabras más comunes.

Por ejemplo, considerá este conjunto de frases con la palabra *honor* en el centro, tomadas del tipo de contextos que podemos encontrar en las novelas del corpus conha19 (Henny-Krahmer, 2021):

- El honor de su familia dependía
- Defender el honor a cualquier precio
- Manchado el honor por aquella infamia
- Restituir el honor perdido ante

`word2vec` toma muestras de distintos contextos alrededor de cada palabra a lo largo del corpus, pero también recopila ejemplos de contextos que nunca ocurren alrededor de cada palabra: esto se conoce como "muestreo negativo" (*negative sampling*, en inglés). El muestreo negativo podría generar ejemplos como:

- El honor celeste bailaba despacio
- Mi azul honor se comió el
- El honor redondo cantaba furioso

A partir de estos datos, el modelo aprende a predecir qué palabras tienen más o menos probabilidad de aparecer junto a la palabra *honor*. Dado que el muestreo es aleatorio, es probable que al ejecutar `word2vec` varias veces sobre un mismo corpus los resultados presenten pequeñas variaciones.

<div class="alert alert-info">
Si al ejecutar <code>word2vec</code> varias veces se obtienen variaciones muy grandes, es posible que el corpus sea demasiado pequeño para usar vectores de palabras de forma significativa.
</div>

El modelo aprende un conjunto de "pesos" (probabilidades) que se ajustan constantemente durante el entrenamiento para que el modelo sea más preciso en sus predicciones. Al finalizar el entrenamiento, los valores de esos pesos se convierten en las dimensiones de los vectores de palabras que forman el modelo de *embeddings*.

`word2vec` funciona especialmente bien para identificar sinónimos, es decir, palabras que podrían sustituirse en un contexto particular. En ese sentido, es probable que *dignidad* acabe estando más cerca de *honor* que de *espada*, ya que tiene más sentido sustituir *dignidad* que *espada* en una frase como "Defender el \[*PALABRA*\] a cualquier precio".

### Distancia en el espacio vectorial

Recordemos que los vectores tienen tanto dirección (¿hacia dónde va?) como longitud (¿qué tan lejos llega en esa dirección?). Ambas propiedades reflejan las asociaciones de palabras en el corpus. Si dos vectores apuntan en la misma dirección y tienen una longitud similar, significa que están muy cerca entre sí en el espacio vectorial y que tienen un conjunto similar de asociaciones de palabras.

La "similitud coseno" (*cosine similarity*, en inglés) es un método habitual para medir la "cercanía" entre palabras (para más ejemplos de medición de distancias, ver [esta lección](https://programminghistorian.org/en/lessons/common-similarity-measures) de *Programming Historian* - Disponible en inglés-). Al comparar dos vectores del mismo corpus, se están comparando dos líneas que comparten un punto de origen. Para determinar qué tan similares son esas palabras, solo necesitamos conectar su posición en el espacio vectorial con una línea adicional, formando un triángulo. La distancia entre los dos vectores puede calcularse entonces usando el [coseno](https://en.wikipedia.org/wiki/Sine_and_cosine) - Disponible en inglés- de esa nueva línea. Cuanto mayor sea este número, más cercanos están esos vectores en el espacio vectorial. Por ejemplo, dos palabras muy distantes entre sí (como *correo electrónico* y *labrador*) podrían tener una similitud coseno baja, de alrededor de 0,1, mientras que dos palabras cercanas (como *feliz* y *alegre*, o incluso *feliz* y *triste*) podrían tener una similitud coseno alta, de alrededor de 0,8.

Las palabras cercanas en el espacio vectorial son aquellas que el modelo predice que es probable que se usen en contextos similares. Suele ser tentador interpretarlas como sinónimos, pero eso no siempre es así. De hecho, los antónimos suelen estar muy cerca entre sí en el espacio vectorial de `word2vec`. Las palabras que tienden a usarse en los mismos contextos pueden tener algún tipo de relación semántica, pero su relación también podría ser estructural o sintáctica. Por ejemplo, en una colección de cartas, es posible que *atentamente*, *cordialmente*, *amiga* y *afectuosamente* estén cerca entre sí porque todas tienden a aparecer en los saludos finales de las cartas. Esto no significa que *amiga* sea sinónimo de *afectuosamente*. De manera similar, los días de la semana y los meses del año suelen estar muy cerca en el espacio vectorial: *viernes* no es sinónimo de *lunes*, pero ambas palabras tienden a usarse en los mismos contextos.

Cuando observes que ciertas palabras están cerca en tus modelos (alta similitud coseno), conviene volver al corpus para comprender mejor cómo el uso del lenguaje puede estar reforzando esa proximidad.

### Álgebra vectorial

Dado que los vectores de palabras representan el lenguaje natural de forma numérica, es posible realizar operaciones matemáticas con ellos. Supongamos, por ejemplo, que queremos hacerle al corpus la siguiente pregunta: "¿Cómo se usa la palabra *patria* en las novelas hispanoamericanas del siglo XIX cuando no se refieren a la guerra?" La álgebra vectorial nos permite plantear esta consulta muy específica a nuestro modelo.

La ecuación que podríamos usar para hacerle esta pregunta exacta al corpus sería: "*patria* - *guerra* = x".

Para ser más precisas aún: ¿cómo se habla de patria en relación con la identidad nacional cuando no se refiere al conflicto armado? Esa ecuación podría verse así: "*patria* + *nación* - *guerra* = x".

Cuanto más compleja sea la operación matemática, mayor será el corpus que probablemente necesitemos para obtener resultados coherentes. Si bien los conceptos tratados hasta aquí pueden parecer bastante abstractos, resultan más fáciles de comprender cuando se analizan ejemplos concretos. Pasemos ahora a trabajar con un corpus específico y comencemos a ejecutar algo de código para entrenar y consultar un modelo `word2vec`.

## Práctica: explorando novelas hispanoamericanas del siglo XIX

El [corpus](https://github.com/cligs/conha19) que utilizamos en esta lección es el **conha19** (*Corpus de novelas hispanoamericanas del siglo XIX*), un conjunto de 234 novelas de dominio público escritas por autoras y autores argentinos, cubanos y mexicanos entre 1830 y 1910.[^2] Elegimos este corpus porque nos permite explorar cómo el lenguaje literario latinoamericano del siglo XIX construye conceptos como el honor, la patria, el amor romántico o el cuerpo femenino, y cómo esos conceptos varían según el género literario o el país de publicación.

Los modelos de *word embeddings* nos permiten formular preguntas como: "¿Qué vocabulario rodea a la palabra *patria* en las novelas históricas si excluimos referencias directas a la guerra?" o "¿Qué palabras se usan en contextos similares a *mujer* en las novelas sentimentales argentinas?". Nuestra pregunta de investigación para esta lección es: **¿Cómo refleja el lenguaje de nuestro corpus las tensiones entre el ideal romántico y la representación del cuerpo y la vida cotidiana en la narrativa hispanoamericana decimonónica?** Dado que el corpus incluye novelas románticas, realistas y naturalistas de tres países, podemos explorar si el contexto de palabras como *amor* o *honor* varía según la corriente literaria o la nacionalidad de quienes las escribieron.

### Obtención del código y los datos

El primer paso para construir el modelo de *word embeddings* es identificar los archivos que usaremos como corpus. Trabajaremos con el corpus **conha19**, preparado por Ulrike Henny-Krahmer como parte del grupo de investigación CLiGS (*Computational Literary Genres Stylistics*, en español: Estilística computacional de géneros literarios) de la Universidad de Würzburg.[^2]

Puedes descargar el [cuaderno Jupyter](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/texto-a-vectores-word-embeddings/texto-a-vectores-word-embeddings.ipynb) de esta lección y el [corpus](https://github.com/cligs/conha19) completo para entrenar un modelo en tu propia computadora. Los archivos en texto plano se encuentran en la carpeta `txt/` del repositorio. Para clonar el repositorio completo desde la terminal, puedes usar:

```bash
git clone https://github.com/cligs/conha19.git
```

Si prefieres descargar solo la carpeta `txt/` sin clonar el repositorio completo, tienes dos opciones. La más sencilla es descargar el ZIP completo del repositorio desde la interfaz de GitHub (botón *Code* → *Download ZIP*), descomprimirlo y quedarte solo con la carpeta `txt/`. La segunda opción es usar *sparse checkout* desde la terminal, que descarga únicamente la carpeta que necesitas sin traer el resto del repositorio:

```bash
git clone --depth 1 --filter=blob:none --sparse https://github.com/cligs/conha19.git
cd conha19
git sparse-checkout set txt
```

> **Nota:** El *sparse checkout* es el método más recomendable si el ancho de banda es una limitación, especialmente relevante para lectoras del Sur Global donde la conexión puede ser costosa o lenta.

Los archivos siguen una convención de nombres simple, con el identificador correlativo del corpus CLiGS seguido de la extensión `.txt` (por ejemplo, `nh0001.txt`, `nh0002.txt`, y así sucesivamente hasta `nh0256.txt`). Los datos sobre país de publicación, autoría y demás metadatos de cada novela no están en el nombre del archivo, sino en el archivo `metadata_free.csv` que acompaña al corpus, donde cada fila se vincula al identificador correspondiente (por ejemplo, `nh0001`).

El corpus **conha19** también incluye un archivo de metadatos (`metadata_free.csv`) con información sobre cada novela: país, década de publicación, corriente literaria (romántica, realista, naturalista) y subgénero temático (novela sentimental, histórica, costumbrista, etc.). Resulta muy útil para orientar las preguntas de investigación y seleccionar subconjuntos del corpus, por ejemplo, filtrando primero por país o corriente literaria en el CSV, y usando luego esos identificadores para localizar los archivos `.txt` correspondientes.

Comenzamos importando las bibliotecas de Python necesarias para esta lección. En programación, es una buena práctica agrupar las instrucciones de importación al principio del código. El bloque de código que aparece a continuación importa cada una de las bibliotecas de Python que vamos a utilizar:

```python
import re                                   # para expresiones regulares
import os                                   # para consultar información sobre el sistema operativo
import string                               # para manipular cadenas de caracteres
import glob                                 # para localizar un tipo de archivo específico
from pathlib import Path                    # para acceder a archivos en otros directorios
import gensim                               # para acceder a Word2Vec
from gensim.models import Word2Vec          # para acceder a la versión de Word2Vec de Gensim
import pandas as pd                         # para ordenar y organizar datos
```

Es posible que tengas que instalar algunas de las bibliotecas que se utilizan en esta lección. Puedes consultar la lección de [Installing Python Modules with pip](https://programminghistorian.org/en/lessons/installing-python-modules-pip) - Disponible en inglés- de *Programming Historian* para obtener más información sobre cómo instalar bibliotecas externas de Python.

Ahora que tenemos las bibliotecas necesarias, debemos cargar los datos en Python. Necesitarás almacenar el corpus localmente en tu computadora, idealmente en un lugar de fácil acceso. Por ejemplo, puedes colocar los datos en una carpeta dentro de tu carpeta `Documentos`, o en el mismo repositorio que tu archivo de código. En cualquier caso, necesitarás conocer la ruta de acceso (*file path*, en inglés) a esa carpeta.

El bloque de código a continuación lee la ruta hacia tu corpus, recorre esa carpeta, extrae el texto de cada archivo y lo almacena en un diccionario. Deberás proporcionar la ruta de acceso a la carpeta `txt/` del corpus conha19 que descargaste desde GitHub. Cuando ingreses la ruta de acceso, debes usar la ruta completa. Por ejemplo, en una computadora con Windows, esa ruta podría verse así: `C:/users/admin/Documents/conha19/txt`. En una Mac, la ruta podría ser: `/Users/admin/Documents/conha19/txt`.

<div class="alert alert-info">
Si quieres trabajar con tipos de archivo diferentes, tendrás que cambiar la variable <code>file_type = ".txt"</code> para que la extensión coincida con el tipo de archivo que tienes. Para usar archivos <code>.csv</code> en lugar de <code>.txt</code>, cambia <code>file_type = ".txt"</code> por <code>file_type = ".csv"</code>. Sin embargo, ten en cuenta que los archivos que uses siempre deben estar en formato de <a href="https://es.wikipedia.org/wiki/Archivo_de_texto">texto plano</a>: los archivos <code>.docx</code> o <code>.pdf</code>, por ejemplo, no funcionarán con este código. Si tienes archivos <code>.pdf</code>, consulta <a href="https://programminghistorian.org/en/lessons/working-with-batches-of-pdf-files">esta lección</a> - Disponible en inglés- sobre cómo transformar <code>.pdf</code> a <code>.txt</code>. Si tienes archivos <code>.docx</code>, puedes guardarlos como <code>.txt</code> desde Microsoft Word, en <strong>Archivo</strong> &gt; <strong>Guardar como</strong>.
</div>

El código comienza identificando los archivos y luego cargándolos en memoria:

```python
dirpath = r'COMPLETAR CON LA RUTA A LA CARPETA txt/'
file_type = ".txt"           # si tus datos no están en formato de texto plano, puedes cambiar esto
filenames = []
data = []

# recorrer todos los archivos del directorio indicado
for file in glob.glob(os.path.join(dirpath, '*' + file_type)):
    with open(file, 'r', encoding='utf-8') as f:
        text = f.read()
        data.append(text)
        filenames.append(Path(file).stem)

print(f"Se encontraron {len(filenames)} archivos.")
print("Primeros 5 nombres de archivo:", filenames[:5])
print("Primeros 500 caracteres del primer archivo:", data[0][:500])
```

> **Nota:** A diferencia del corpus original en inglés, los archivos del conha19 están codificados en UTF-8 e incluyen caracteres propios del español (tildes, ñ, signos de apertura de interrogación y exclamación, etc.). Por eso es importante especificar `encoding='utf-8'` al abrir cada archivo, como se muestra en el bloque anterior.

### Construcción del vocabulario del modelo

Al entrenar el modelo con texto en español, el vocabulario que este aprenderá incluirá todas las palabras del corpus tal como aparecen en los archivos. El corpus conha19 ya fue sometido a un proceso de control ortográfico y normalización básica, pero conserva la ortografía histórica de los textos originales. Por ejemplo, puedes encontrar variantes como *muger* en lugar de *mujer*, o *triste* y *tristísima* como formas distintas. Como en cualquier corpus histórico, conviene evaluar si estas variantes son relevantes para tu pregunta de investigación antes de decidir si normalizarlas.

Una ventaja del conha19 es que ofrece versiones alternativas de los archivos que ya tienen algunas de estas decisiones tomadas: la carpeta `txt_annotated_corr/` contiene los textos en minúsculas y con la puntuación normalizada, y `txt_annotated_stop/` contiene versiones sin *stopwords* (en español, "palabras vacías": artículos, preposiciones, conjunciones frecuentes). Puedes experimentar con estas versiones para ver cómo impactan en los resultados del modelo.

### Limpieza del corpus

La función `clean_text()` de la lección original funciona bien para el español con una pequeña modificación: es necesario asegurarse de que no elimine caracteres propios del español como la `ñ` o las vocales acentuadas (`á`, `é`, `í`, `ó`, `ú`). La versión estándar de Python 3 con `str.isalpha()` reconoce correctamente estos caracteres en cadenas UTF-8, por lo que el código puede usarse sin cambios. Sin embargo, si tu sistema tiene configuración regional diferente, puede ser necesario verificarlo.

```python
def clean_text(text):
    # separar el texto en tokens y convertirlo a minúsculas
    tokens = text.split()
    tokens = [t.lower() for t in tokens]

    # eliminar puntuación, incluyendo signos de apertura propios del español (¿ y ¡)
    # que no forman parte de string.punctuation de Python 3 de manera predeterminada
    extra_punct = '¿¡'
    re_punc = re.compile('[%s]' % re.escape(string.punctuation + extra_punct))
    tokens = [re_punc.sub('', token) for token in tokens]

    # eliminar números y tokens vacíos; isalpha() reconoce ñ y vocales acentuadas en UTF-8
    tokens = [token for token in tokens if token.isalpha()]
    return tokens

data_clean = []
for x in data:
    data_clean.append(clean_text(x))

# comprueba que el número de textos procesados sea el mismo que el de los textos originales
print(len(data))
print(len(data_clean))

# comprueba que el primer token del primer texto procesado coincida con el original
print(data[0].split()[0])
print(data_clean[0][0])

# comprueba que el último token del primer texto procesado coincida con el original
print(data[0].split()[-1])
print(data_clean[0][-1])
```

### Creación del modelo

Dado que el conha19 tiene alrededor de 18,3 millones de *tokens* en total (el corpus completo), es un corpus de tamaño moderado para `word2vec`. Si decides trabajar con un subconjunto —por ejemplo, solo las novelas argentinas o solo las de corriente realista— ten en cuenta que el tamaño reducido puede afectar la estabilidad de los vectores.

Para entrenar un modelo `word2vec`, el código primero extrae el vocabulario del corpus y genera a partir de él un conjunto aleatorio de vectores de palabras iniciales. Luego, mejora su capacidad predictiva ajustando sus pesos, a partir del muestreo de contextos en los que la palabra existe (contextos positivos) y contextos en los que no existe (muestreo negativo).

#### Parámetros

Además de la selección y limpieza del corpus descritas anteriormente, en ciertos momentos del proceso puedes decidir ajustar lo que se conoce como "parámetros" de configuración. Estos son casi tan importantes como los textos que seleccionas para tu corpus. Puedes pensar en el proceso de entrenamiento —en el que tomamos un corpus y creamos un modelo a partir de él— como una especie de operación industrial:

- Se introducen materias primas en una gran máquina, que produce un resultado al otro extremo.
- Esta máquina hipotética tiene una serie de perillas y palancas que usas para controlar los ajustes (los parámetros).
- Dependiendo de cómo ajustes los parámetros, obtienes productos diferentes (modelos entrenados de manera distinta).

Estos parámetros tendrán un impacto significativo en los modelos que produzcas. Controlan aspectos como el algoritmo específico que se usará en el entrenamiento, cómo manejar las palabras poco frecuentes en tu corpus, y cuántas veces el algoritmo debe recorrer el corpus mientras aprende.

No existe un enfoque de configuración único que funcione para todos los casos. Los parámetros más efectivos dependerán de la longitud de tus textos, la variedad del vocabulario que contienen, su idioma y estructura —y, por supuesto, del tipo de preguntas que quieras investigar—. Parte del trabajo con modelos de vectores de palabras consiste en ajustar las perillas de esa máquina industrial metafórica, para probar cómo distintos parámetros impactan en los resultados. Por lo general, es mejor variar los parámetros de uno en uno, para poder observar cómo cada uno afecta el modelo resultante.

Un desafío particular de trabajar con vectores de palabras es justamente cuánto impactan los parámetros en los resultados. Si vas a compartir tu investigación, necesitarás poder explicar cómo elegiste los parámetros que usaste. Por eso es tan importante probar distintos parámetros y examinar múltiples modelos. A continuación se describen algunos parámetros de especial interés:

`sentences`:   
El parámetro `sentences` es donde le indicas a `word2vec` con qué datos entrenar el modelo. En nuestro caso, vamos a establecer este atributo con nuestros datos textuales ya limpios.

`min_count` (conteo mínimo):   
`min_count` indica cuántas veces debe aparecer una palabra en el corpus para que "cuente" como una palabra en el modelo. El valor por defecto es 5. Puedes querer cambiar este valor según el tamaño de tu corpus, pero en la mayoría de los casos 5 es un mínimo razonable. Las palabras que aparecen con menor frecuencia no tienen suficientes datos como para producir resultados coherentes.

`window`:   
Este parámetro te permite establecer el tamaño de la ventana deslizante que recorre el texto durante el entrenamiento del modelo. El valor por defecto es 5, lo que significa que la ventana analizará cinco palabras a la vez: dos palabras antes de la palabra objetivo, la palabra objetivo en sí, y dos palabras después. Tanto las palabras que preceden como las que siguen a la palabra objetivo formarán el contexto de esa palabra. Cuanto más grande sea la ventana, más palabras se incluirán en ese cálculo de contexto. Sin embargo, dentro de la ventana, todas las palabras se tratan de manera indiscriminada en cuanto a su relevancia para el contexto calculado.

`workers` (opcional):   
El parámetro `workers` representa cuántos "hilos" (*threads*, en inglés) quieres que procesen tu texto al mismo tiempo. El valor por defecto es 3. Aumentar este parámetro hará que tu modelo entrene más rápido, pero también consumirá más capacidad de procesamiento de tu computadora. Si te preocupa la carga sobre tu equipo, deja este parámetro en el valor por defecto.

`epochs` (opcional):   
El número de épocas indica cuántas iteraciones sobre el texto serán necesarias para entrenar el modelo. No existe una regla sobre qué número funciona mejor. En general, cuantas más épocas, mejor; pero demasiadas podrían en realidad disminuir la calidad del modelo, debido al "sobreajuste" (*overfitting*, en inglés): el modelo aprende tan bien los datos de entrenamiento que rinde peor con cualquier otro conjunto de datos. Para determinar qué número de épocas funcionará mejor con tus datos, puede ser útil que experimentes con algunos valores (por ejemplo, 5, 10, 50 y 100).

`sg` (*skip-gram*):   
El parámetro `sg` le indica a la computadora qué algoritmo de entrenamiento usar. Las opciones son CBOW (bolsa continua de palabras, o *Continuous Bag of Words* en inglés) o *skip-gram*. Para seleccionar CBOW, establece `sg` en 0; para seleccionar *skip-gram*, establece `sg` en 1. La mejor opción de algoritmo de entrenamiento depende realmente de cómo son tus datos.

`vector_size` (opcional):   
El parámetro `vector_size` controla la dimensionalidad del modelo entrenado, con un valor por defecto de 100 dimensiones. Un mayor número de dimensiones puede hacer que tu modelo sea más preciso, pero también aumentará tanto el tiempo de entrenamiento como la posibilidad de errores aleatorios.

Dado que `word2vec` toma muestras de los datos antes del entrenamiento, no obtendrás el mismo resultado cada vez. Puede valer la pena ejecutar un modelo `word2vec` algunas veces para asegurarte de que no obtienes resultados muy diferentes para las cosas que te interesan. Si buscas hacer afirmaciones precisas sobre cambios en el significado o el uso del lenguaje, necesitas tomar especial cuidado para minimizar la variación aleatoria (por ejemplo, manteniendo las mismas semillas aleatorias y usando la misma ventana de *skip-gram*).

El código a continuación entrenará el modelo, usando algunos de los parámetros analizados anteriormente:

```python
# entrenar el modelo
model = Word2Vec(sentences=data_clean, window=5, min_count=3, workers=4, epochs=5, sg=1)

# guardar el modelo
model.save("word2vec_conha19.model")
```

#### Parámetros recomendados para este corpus

Algunas consideraciones específicas para el conha19:

- **`min_count=3`**: razonable para el corpus completo. Si trabajas con un subconjunto pequeño (por ejemplo, solo las 49 novelas cubanas), la sugerencia es utilizar `min_count=2`, ya que esto puede ayudar a retener más vocabulario relevante.
- **`window=5`**: adecuado para prosa literaria. Un valor mayor (como `window=8` o `window=10`) puede capturar relaciones semánticas más amplias, útiles para conceptos abstractos como *honor* o *virtud*.
- **`sg=1`** (*skip-gram*): recomendado dado que el corpus, aunque amplio, tiene distribución desigual de géneros y épocas.

### Consulta al modelo mediante búsquedas exploratorias

Es importante comenzar verificando que la palabra que queremos examinar forme parte del vocabulario de nuestro modelo.

```python
# verificar si una palabra existe en el vocabulario
word = "honor"

# si esa palabra está en el vocabulario
if word in model.wv.key_to_index:

    # imprimir un mensaje para confirmarlo
    print("La palabra %s está en el vocabulario del modelo" % word)

# de lo contrario, informar que no está
else:
    print("%s no está en el vocabulario del modelo" % word)
```

Ahora podemos usar las potentes funciones integradas de `word2vec` para consultarle al modelo cómo comprende el texto proporcionado. A continuación recorremos cada una de estas llamadas a funciones.

Un aspecto importante a recordar es que los resultados que obtienes de cada una de estas funciones no reflejan palabras con definiciones similares, sino palabras que se usan en los mismos contextos. Si bien es probable que algunas de las palabras que aparezcan en los resultados tengan significados parecidos, el modelo puede devolver algunas palabras extrañas o confusas. Esto no indica necesariamente que haya algo incorrecto en tu modelo o corpus, sino que puede reflejar que esas palabras tan diferentes se usan de maneras similares en tu corpus. Siempre ayuda volver al corpus para comprender mejor cómo se usa realmente el lenguaje en tus textos.

`most_similar`   
Esta función te permite recuperar palabras similares a la palabra elegida. En este caso, le estamos pidiendo al modelo las diez palabras de nuestro corpus más cercanas a la palabra *honor*. Si quieres una lista más larga, cambia el número asignado a `topn` por el número deseado. El código a continuación devolverá las diez palabras con mayor similitud coseno respecto de la palabra *honor* (o cualquier otro término de búsqueda que indiques). Cuanto mayor sea la similitud coseno, más "cercanas" están las palabras a tu término de búsqueda en el espacio vectorial (recuerda que la cercanía en el espacio vectorial significa que las palabras se usan en los mismos tipos de contextos).

```python
# devuelve una lista con las diez palabras usadas en contextos más similares a "honor"
model.wv.most_similar('honor', topn=10)
```

También puedes proporcionarle a la función `most_similar` información más específica sobre la(s) palabra(s) de tu interés. En el bloque de código a continuación, notarás que una palabra (*patria*) está asociada al parámetro positivo y la otra (*guerra*) al negativo. Esta llamada a `most_similar` devolverá una lista de palabras contextualmente más similares a *patria*, pero que no comparten el contexto de *guerra*.

```python
# devuelve las diez palabras más similares a "patria" que son disímiles de "guerra"
model.wv.most_similar(positive=["patria"], negative=["guerra"], topn=10)
```

También puedes incluir más de una palabra en el parámetro positivo, como se muestra a continuación:

```python
# devuelve las diez palabras más similares tanto a "honor" como a "virtud"
model.wv.most_similar(positive=["honor", "virtud"], topn=10)
```

`similarity`   
Esta función devuelve una puntuación de similitud coseno para las dos palabras que le proporcionas. Cuanto mayor sea la similitud coseno, más similares son esas palabras.

```python
# devuelve una puntuación de similitud coseno para las dos palabras proporcionadas
model.wv.similarity("honor", "vergüenza")
```

`predict_output_word`   
Esta función predice la palabra con mayor probabilidad de aparecer a continuación a partir de un conjunto de palabras de contexto, según las palabras proporcionadas. Esta función opera infiriendo el vector de una palabra no vista previamente.

```python
# devuelve una predicción para las otras palabras en una oración que contiene "amor", "pasión" y "virtud"
model.predict_output_word(["amor", "pasión", "virtud"])
```

Recuerda que los resultados no reflejan sinónimos sino palabras que aparecen en contextos similares. Por ejemplo, que *honor* y *vergüenza* tengan alta similitud coseno no significa que sean equivalentes, sino que el corpus las usa en situaciones narrativas parecidas, lo cual en sí mismo es un hallazgo interpretable.

### Validación del modelo

Ahora que exploramos algunas de sus funcionalidades, es importante evaluar el modelo con el que estamos trabajando. ¿Responde a nuestras consultas de la manera esperada? ¿Está cometiendo errores evidentes?

La validación de modelos de vectores de palabras es actualmente un problema sin solución definitiva, especialmente para modelos de investigación en humanidades entrenados con corpus históricos. La prueba que se presenta a continuación ofrece una muestra de un enfoque posible para evaluar un modelo, que consiste en verificar qué tan bien funciona el modelo con pares de palabras que probablemente tengan alta similitud coseno. Este enfoque es solo un ejemplo y no sustituye procesos de evaluación más rigurosos. Los pares de palabras serán muy específicos al corpus que se está evaluando, ¡y lo ideal sería utilizar muchos más pares de los que aparecen en este ejemplo de demostración!

El código a continuación evalúa el modelo comenzando por abrir la carpeta de modelos que indiques e identificar todos los archivos de tipo `.model`. Luego, el código toma una lista de pares de palabras de prueba y calcula sus similitudes coseno. Los pares de palabras son palabras que, como lectora o lector del corpus, esperarías que tengan alta similitud coseno. Finalmente, el código guarda las similitudes coseno de cada par de palabras en cada modelo en un archivo `.csv` para consulta futura.

Si quisieras adaptar este código a tus propios modelos, deberías seleccionar pares de palabras que tengan sentido para el vocabulario de tu corpus. En nuestro caso, elegimos pares de palabras propios de la narrativa hispanoamericana del siglo XIX que podemos esperar razonablemente que tengan alta similitud coseno. Elegir pares de palabras de un campo completamente diferente (por ejemplo, buscar *barco* y *nave* en un corpus de novelas decimonónicas) claramente no sería efectivo si esos términos no aparecen en el corpus con suficiente frecuencia. La selección de los pares de palabras es una cuestión de criterio y de conocimiento del propio corpus.

Si pruebas varios pares de palabras similares y encuentras que sus vectores no están cerca entre sí en el modelo, deberías revisar el corpus con tus propios ojos. Busca las palabras: ¿cuántas veces aparece cada una en el corpus? ¿Están apareciendo en contextos similares? ¿Aparece una con mucha mayor frecuencia que la otra? El corpus de ejemplo de esta lección funciona a pesar de ser bastante pequeño porque los textos pertenecen al dominio relativamente acotado de la novela hispanoamericana del siglo XIX. Si pruebas pares de palabras que deberían ser similares y la distancia coseno entre ellos es alta, es posible que necesites un corpus más grande.

En este ejemplo, encontramos un conjunto de modelos (archivos con extensión `.model`) en un directorio especificado, los agregamos a una lista y luego evaluamos la distancia coseno para un conjunto de pares de palabras de prueba. Luego agregamos todos los resultados a un *dataframe*.

<div class="alert alert-info">
Existen otros métodos para realizar la evaluación de un modelo. Por ejemplo, un método popular para evaluar un modelo <code>word2vec</code> es usar la función integrada <code>evaluate_word_analogies()</code> para evaluar analogías sintácticas. También puedes evaluar pares de palabras usando la función integrada <code>evaluate_word_pairs()</code>, que incluye un conjunto de datos predeterminado de pares de palabras. Puedes leer más sobre la evaluación de modelos en la <a href="https://radimrehurek.com/gensim/auto_examples/tutorials/run_word2vec.html#evaluating">documentación de Gensim</a> - Disponible en inglés-.
</div>

```python
import os
from pathlib import Path
from gensim.models import Word2Vec
import pandas as pd

# COMPLETAR CON LA RUTA A LA CARPETA DONDE GUARDASTE LOS MODELOS
# Ejemplo en Google Colab: r'/content/'
# Ejemplo en Windows:      r'C:/Users/tuusuario/Documents/conha19/'
# Ejemplo en Mac/Linux:    r'/Users/tuusuario/Documents/conha19/'
models_folder = r'/content/'

# buscar todos los archivos .model en la carpeta indicada
model_files = list(Path(models_folder).glob('*.model'))
print(f"Se encontraron {len(model_files)} modelos: {[f.name for f in model_files]}")

model_list = []
model_filenames = []

for filename in model_files:
    file_path = str(filename)
    print(f"Cargando modelo: {file_path}")
    model = Word2Vec.load(file_path)
    model_list.append(model)
    model_filenames.append(file_path)

# pares de palabras de prueba para evaluar los modelos
# seleccionados a partir del vocabulario de la narrativa hispanoamericana del siglo XIX
test_words = [('amor', 'pasión'),
              ('patria', 'nación'),
              ('honor', 'virtud'),
              ('muerte', 'sepulcro'),
              ('indio', 'mestizo'),
              ('ciudad', 'pueblo')]

# crear un dataframe vacío con los encabezados de columna necesarios
evaluation_results = pd.DataFrame(columns=['Modelo', 'Palabras de prueba', 'Similitud coseno'],
                                   dtype=object)

# contador acumulativo para el índice del dataframe
row_index = 0

# iterar por model_list
for i in range(len(model_list)):

    # para cada modelo, evaluar todos los pares de palabras
    for x in range(len(test_words)):

        # verificar que ambas palabras del par estén en el vocabulario del modelo
        word1, word2 = test_words[x]
        if word1 in model_list[i].wv and word2 in model_list[i].wv:
            # calcular la puntuación de similitud coseno para el par
            similarity_score = model_list[i].wv.similarity(word1, word2)
        else:
            # si alguna palabra no está en el vocabulario, registrar None
            similarity_score = None
            print(f"Advertencia: '{word1}' o '{word2}' no están en el vocabulario de {model_filenames[i]}")

        # agregar la fila al dataframe usando el índice acumulativo
        evaluation_results.loc[row_index] = [model_filenames[i], test_words[x], similarity_score]
        row_index += 1

# guardar evaluation_results como archivo .csv
evaluation_results.to_csv('evaluacion_modelo_word2vec.csv', index=False)
print("\nResultados de la evaluación:")
print(evaluation_results)
```

El archivo `.csv` resultante contiene una lista de los modelos que fueron evaluados, los pares de palabras utilizados y la similitud coseno de cada par en ese modelo en particular. Guardamos este archivo como `.csv` para consulta futura, pero también puedes ver los resultados directamente ejecutando el código a continuación:

```python
print(evaluation_results)
```

## Aplicación: cómo armar un corpus para tu propia investigación

Ahora que tuviste la oportunidad de explorar el entrenamiento y la consulta de un modelo usando un corpus de ejemplo, puedes considerar aplicar los *word embeddings* a tu propia investigación.

### Consideraciones preliminares importantes

Para determinar si los vectores de palabras pueden ser útiles en tu investigación, es importante evaluar si las preguntas que quieres responder pueden abordarse analizando patrones de uso del lenguaje a lo largo de un corpus amplio. Esto implica considerar las siguientes cuestiones:

- ¿Es posible armar un corpus que ofrezca suficiente información sobre el fenómeno que quieres investigar? Por ejemplo, si estás investigando cómo quienes escribían historia en la América colonial temprana distinguían su trabajo del de sus predecesores medievales europeos, podrías armar dos corpus: uno de crónicas coloniales y otro de historias medievales peninsulares.

- ¿Las "relaciones entre palabras" son una heurística útil para tu investigación? ¿Puedes identificar términos o grupos de términos que representen los espacios conceptuales más amplios que estás estudiando? Siguiendo el ejemplo de la historia colonial, podrías analizar qué tan cercanas están palabras como *ficción*, *mentira* o *falsedad* —que sugieren relatos no verídicos del pasado— respecto de referencias a historiadores medievales europeos (mediante términos como *monje*, *medieval* o *cronista*).

Otra consideración importante para armar tu corpus es la composición de los textos. Conviene reflexionar sobre las siguientes preguntas:

- ¿Los textos de tu corpus están en un solo idioma o en más de uno? Si hay varios idiomas, ¿cómo se distribuyen? Ten en cuenta que si tienes múltiples idiomas, no existe una capa mágica de traducción en la creación de vectores de palabras: la información sobre los contextos de *gato* (en español) no se fusionará con los contextos de *cat* (en inglés). Mezclar varios idiomas en un corpus puede dar resultados significativos e interesantes si estás estudiando, por ejemplo, novelas de la frontera entre México y Estados Unidos donde el *code-switching* entre idiomas es un recurso literario importante. Sin embargo, incluir documentos solo en español y documentos solo en inglés en un único corpus simplemente produce dos conjuntos de palabras que, en el mejor de los casos, no co-ocurren entre sí, y en el peor, generan resultados engañosos. Por ejemplo, un modelo no puede diferenciar entre *con* como preposición en español y *con* (abreviatura de *convict*, o convicto) como sustantivo en inglés. Si tu pregunta de investigación implica analizar palabras en inglés relacionadas con el crimen, el vector de *con* en inglés quedará sesgado por la palabra homógrafa en español.

- ¿Tus textos varían en otras características, como extensión, género o forma? Sé deliberada respecto de qué incluyes en tu corpus y por qué. Si quieres trabajar con el lenguaje de la poesía hispanoamericana del siglo XIX y encuentras que todos tus poemas juntos no alcanzan el recuento de palabras necesario para obtener buenos resultados, no empieces a agregar novelas del mismo período sin ajustar tus preguntas de investigación en consecuencia. Cuando las grandes empresas tecnológicas crean *word embeddings* masivos para tareas como la traducción automática, trabajan con corpus inimaginablemente grandes, a una escala donde factores como el género o la forma tienen poco impacto. Sin embargo, cuanto más pequeños son los datos, más cuidado hay que tener, especialmente cuando se busca sostener afirmaciones académicas a partir de los resultados.

- ¿Qué criterios usarás para delimitar tu corpus: fecha, editorial, lugar de publicación, autoría? Asegúrate de que los principios de selección sean coherentes con el tipo de preguntas que quieres investigar. Esto aplica incluso cuando la tentación sea ampliar la red para conseguir más texto.

- Si no vas a incluir todos los textos posibles dentro de tus parámetros de alcance —lo que probablemente no harás—, ¿cómo garantizarás que los textos que sí seleccionas sean ampliamente representativos del conjunto total posible? ¿Cómo puedes al menos asegurarte de que no haya desequilibrios serios entre los textos que incluyes? Volviendo al ejemplo de la historia colonial, sería problemático que un corpus de historias del siglo XVII estuviera compuesto por 59 textos publicados en 1699 y uno solo publicado en 1601.

En términos generales, deberías apuntar a un equilibrio en las características más relevantes de los textos que seleccionas (fecha de publicación, género, lugar de publicación, idioma) y a una estrecha alineación entre los textos de tu corpus y tu objetivo de investigación. Si estás comparando corpus, asegúrate de que la única diferencia entre ellos sea la característica que estás investigando. Recuerda que los vectores de palabras te van a dar información sobre las relaciones entre palabras, ¡así que las palabras concretas que forman tus corpus son cruciales!

### Preparación de los textos de tu corpus

Cuando prepares tu corpus, ten en cuenta que el modelo se entrena con todas las palabras que contiene. Como los resultados dependen en gran medida de los datos de entrada, siempre debes incluir una fase de análisis de datos al comienzo de tu investigación para asegurarte de incluir solo las palabras que realmente te interesan. De hecho, la preparación y el análisis de datos deben ser un proceso iterativo: revisa los textos, identifica dónde necesitan ajustarse, haz los cambios, revisa los resultados, identifica ajustes adicionales, y así sucesivamente. Esto hace que sea fundamental llevar un registro de todos los cambios que realizas en tus textos.

Si obtienes textos desde Project Gutenberg, querrás eliminar el texto introductorio estándar del proyecto que aparece al principio y al final de cada archivo. Considera eliminar también: texto de autoría editorial (como anotaciones o descripciones de imágenes), números de página y etiquetas. Quitar estos elementos es preferible porque probablemente no sean de interés y podrían sesgar las distancias entre términos relacionados.

Los objetivos del proyecto influirán en qué características documentales conviene conservar o eliminar. Estas incluyen paratextos —como índices, tablas de contenidos y avisos publicitarios— y elementos como acotaciones escénicas. Por último, puedes optar por manipular directamente el lenguaje de tus documentos: regularizar o modernizar la ortografía, corregir errores o lematizar el texto. Ten en cuenta que si modificas el lenguaje de tus documentos, también querrás conservar el corpus sin modificar, para poder analizar el impacto de tus intervenciones sobre los datos.

Una vez que hayas identificado un corpus y preparado tus textos, puedes adaptar el código presentado anteriormente para entrenar, consultar y validar tu modelo. Recuerda: ¡este es un proceso iterativo! Lo más probable es que necesites hacer cambios adicionales en tus datos y en tus parámetros a medida que vayas comprendiendo mejor lo que tu modelo revela sobre los textos de tu corpus. Cuanto más experimentes con tus datos y tus modelos, mejor entenderás cómo estos métodos pueden ayudarte a responder nuevos tipos de preguntas, y más preparada estarás para explorar aplicaciones más avanzadas de los modelos de vectores de palabras.

## Próximos pasos

Ahora que aprendiste a construir y analizar *word embeddings*, puedes consultar la lección relacionada de *Programming Historian* [Clustering and Visualizing Documents using Word Embeddings](https://programminghistorian.org/en/lessons/clustering-visualizing-word-embeddings) - Disponible en inglés- para aprender métodos más avanzados de análisis con vectores de palabras.

A continuación, algunos recursos adicionales para quienes quieran profundizar en el tema:

- El Women Writers Project ofrece un conjunto completo de tutoriales para entrenar modelos de vectores de palabras en Python, que puedes descargar junto con datos de muestra desde el [repositorio de Public Code Share en GitHub del WWP](https://github.com/NEU-DSG/wwp-public-code-share) - Disponible en inglés-.

- El [Women Writers Vector Toolkit](https://wwp.northeastern.edu/lab/wwvt/) - Disponible en inglés- es una interfaz web para explorar vectores de palabras, acompañada de glosarios, fuentes, estudios de caso y tareas de ejemplo. Este *toolkit* incluye enlaces a un [repositorio de GitHub con tutoriales en formato RMD](https://github.com/NEU-DSG/wwp-public-code-share/tree/main/WordVectors) - Disponible en inglés- con código para entrenar modelos `word2vec` en R, así como [recursos descargables sobre preparación de corpus de texto](https://wwp.northeastern.edu/outreach/resources/wordvectors.html) - Disponible en inglés-.

- La [página de recursos del Women Writers Project](https://wwp.northeastern.edu/outreach/resources/wordvectors.html) - Disponible en inglés- incluye guías sobre búsqueda en corpus, análisis y preparación de corpus, validación y evaluación de modelos, y más.

Para tener un panorama más amplio de cómo se pueden usar los vectores de palabras en investigación y en el aula, puedes consultar esta [serie de entradas de blog](https://wwp.northeastern.edu/blog/) - Disponible en inglés- y esta [lista anotada de lecturas](https://wwp.northeastern.edu/lab/wwvt/resources/sources/index.html) - Disponible en inglés-.

A continuación se presentan lecturas e investigaciones individuales que ilustran las aplicaciones de los modelos de vectores de palabras en la investigación humanística:

- Heuser, Ryan. [Word Vectors in the Eighteenth Century](https://ryanheuser.org/word-vectors/) [Vectores de palabras en el siglo XVIII]. 2016. - Disponible en inglés-

- Gavin, Michael, Collin Jennings, Lauren Kersey y Brad Pasanek. [Spaces of Meaning: Vector Semantics, Conceptual History, and Close Reading](https://doi.org/10.5749/j.ctvg251hk.10) [Espacios de significado: semántica vectorial, historia conceptual y lectura cercana]. En *Debates in the Digital Humanities 2019*. University of Minnesota Press, 2019. - Disponible en inglés-

- Nelson, Laura. [Leveraging the alignment between machine learning and intersectionality: Using word embeddings to measure intersectional experiences of the nineteenth century U.S. South](https://doi.org/10.1016/j.poetic.2021.101539) [Aprovechando la alineación entre el aprendizaje automático y la interseccionalidad: uso de *word embeddings* para medir experiencias interseccionales en el Sur de Estados Unidos del siglo XIX]. *Poetics* 88 (2021): 101539. - Disponible en inglés-

- Lang, Anouk. [Spatial Dialectics: Pursuing Geospatial Imaginaries with Word Embedding Models and Mapping](https://doi.org/10.1093/llc/fqac076) [Dialécticas espaciales: explorando imaginarios geoespaciales con modelos de *word embeddings* y cartografía]. *Digital Scholarship in the Humanities* 38, n.° 2 (2023): 668–682. - Disponible en inglés-

- Grayson, Siobhan, Maria Mulvany, Karen Wade, Gerardine Meaney y Derek Greene. [Novel2Vec: Characterising 19th Century Fiction via Word Embeddings](https://doi.org/10.1007/978-3-319-73949-6) [Novel2Vec: caracterización de la ficción del siglo XIX mediante *word embeddings*]. En *AICS 2016: Proceedings of the 24th Irish Conference on Artificial Intelligence and Cognitive Science*, 2016. - Disponible en inglés-

- Schmidt, Benjamin. [Vector Space Models for the Digital Humanities](https://bookworm.benschmidt.org/posts/2015-10-25-Word-Embeddings.html) [Modelos de espacio vectorial para las Humanidades Digitales]. *Bookworm* (blog), 25 de octubre de 2015. - Disponible en inglés-

## Agradecimientos

Agradecemos a Mark Algee-Hewitt y Julia Flanders por sus contribuciones a distintos aspectos de esta lección.

## Notas

[^1]: Véanse, por ejemplo, los trabajos de [Benjamin Schmidt](https://bookworm.benschmidt.org/posts/2015-10-25-Word-Embeddings.html), "Vector Space Models for the Digital Humanities" - Disponible en inglés-; [Ryan Heuser](https://ryanheuser.org/word-vectors/), "Word Vectors in the Eighteenth Century" - Disponible en inglés-; y [Laura Nelson](https://doi.org/10.1016/j.poetic.2021.101539), "Leveraging the alignment between machine learning and intersectionality" - Disponible en inglés-.

[^2]: Henny-Krahmer, Ulrike (ed.) (2021). *Corpus de novelas hispanoamericanas del siglo XIX (conha19)*. Versión 1.0.1. Github.com. URL: [https://github.com/cligs/conha19](https://github.com/cligs/conha19). DOI: [https://doi.org/10.5281/zenodo.4766987](https://doi.org/10.5281/zenodo.4766987).

[^3]: Muchas preguntas de investigación en las humanidades abordan conceptos de gran alcance como género, identidad o justicia. Un corpus del tamaño del que usamos aquí sería poco adecuado para este tipo de preguntas, porque los términos relevantes se usan en un conjunto muy diverso de contextos. Como referencia general, un millón de palabras es un punto de partida mínimo para este tipo de consultas. En nuestro ejemplo, analizamos un conjunto de términos que aparecen con cierta frecuencia en un conjunto de contextos muy consistente, lo que hace posible obtener resultados razonables con un corpus más pequeño. Wevers y Koolen desarrollan con más detalle un conjunto de consideraciones sobre el tamaño del corpus, y vale la pena consultarlos al momento de pensar en el propio. Véase Wevers, Melvin y Koolen, Marijn. "Digital begriffsgeschichte: Tracing semantic change using word embeddings" [*Begriffsgeschichte* digital: rastreo del cambio semántico mediante *word embeddings*]. *Historical Methods: A Journal of Quantitative and Interdisciplinary History* 53, n.° 4 (2020): 226-243. [https://doi.org/10.1080/01615440.2020.1760157](https://doi.org/10.1080/01615440.2020.1760157) - Disponible en inglés-.

[^4]: Véase, por ejemplo, Cordell, Ryan. "'Q i-Jtb the Raven': Taking Dirty OCR Seriously" ["'Q i-Jtb the Raven': tomarse en serio el OCR con errores]. *Book History* 20, n.° 1 (2017): 188–225. [https://doi.org/10.1353/bh.2017.0006](https://doi.org/10.1353/bh.2017.0006) - Disponible en inglés- para una discusión sobre cómo los errores de OCR pueden aportar información útil en la investigación. Véase también Rawson, Katie y Muñoz, Trevor. "Against Cleaning" [En contra de la limpieza]. *Curating Menus*, 6 de julio de 2016. [http://www.curatingmenus.org/articles/against-cleaning/](http://www.curatingmenus.org/articles/against-cleaning/) - Disponible en inglés- para una discusión sobre las múltiples y significativas complejidades que suelen ocultarse bajo el concepto de "limpieza" de datos. Una versión republicada está disponible en [*Debates in the Digital Humanities* (2019)](https://dhdebates.gc.cuny.edu/read/untitled-f2acf72c-a469-49d8-be35-67f9ac1e3a60/section/07154de9-4903-428e-9c61-7a92a6f22e51) - Disponible en inglés-.
