---
title: Descarga múltiples registros mediante cadenas de consulta
layout: lesson
date: 2012-11-11
authors:
- Adam Crymble
reviewers:
- Luke Bergmann
- Sharon Howard
editors:
- Fred Gibbs
translator:
- Víctor Gayol
translation-editor:
- José Antonio Motilla
translation-reviewers:
- 
- 
original: downloading-multiple-records-using-query-strings
difficulty: 2
activity: acquiring
topics: [web-scraping]
abstract: "Descargar un solo registro de un sitio web es fácil, pero la descarga de muchos registros a la vez –una necesidad cada vez más frecuente de un/a historiador/a– es mucho más eficiente utilizando un lenguaje de programación como Python. En esta lección, escribiremos un programa que descargará una serie de registros de Old Bailey Online usando criterios de búsqueda personalizada y los guardará en un directorio de nuestro equipo."
previous: salida-palabras-clave-contexto-ngrams
python_warning: true
redirect_from: /lessons/downloading-multiple-records-using-query-strings
---

{% include toc.html %}




## Metas del módulo

Descargar un solo registro de un sitio web es fácil, pero la descarga de muchos registros a la vez –una necesidad cada vez más frecuente de un/a historiador/a– es mucho más eficiente utilizando un lenguaje de programación como Python. En esta lección escribiremos un programa que descargará una serie de registros del [Old Bailey Online][] utilizando criterios de búsqueda personalizados y los guardará en un directorio de nuestro ordenador. Este proceso implica la interpretación y manipulación de *cadenas de consulta* en el URL. En este caso, el tutorial tratará de descargar fuentes que contengan referencias a personas de ascendencia africana que fueron publicadas en el *Old Bailey Proceedings* entre 1700 y 1750.

## ¿Para quién es útil esto?

Automatizar el proceso de descarga de registros de una base de datos en línea será útil para cualquier persona que trabaje con fuentes históricas almacenadas en línea de manera ordenada y accesible, y que desea guardar copias de esas fuentes en su propio ordenador. Es particularmente útil para quien quiere descargar muchos registros específicos, en lugar de sólo unos cuantos. Si deseas descargar *todos* o *la mayoría* de los registros de una base de datos determinada, el tutorial de Ian Milligan sobre [Automated Downloading with WGET][] (Descarga automatizada con WGET, en inglés), puede ser más adecuado.

El presente tutorial te permitirá descargar registros específicos de manera selectiva, aislando aquellos que satisfagan tus necesidades. La descarga automática de varias fuentes ahorra un tiempo considerable. Lo que hagas con las fuentes descargadas depende de tus objetivos de investigación. Es posible que quieras crear visualizaciones, aplicar diversos métodos de análisis de datos o simplemente reformatearlos para facilitar la navegación. Quizá solo desees guardar una copia de seguridad para acceder a ellos cuando no tengas acceso a Internet.

Esta lección es para usuarios intermedios de Python. Si aún no has probado las lecciones de [Programación básica en Python][], puedes encontrar un punto de partida útil.

## Aplicar nuestro conocimiento histórico

En esta lección tratamos de crear nuestro propio corpus de casos relacionados con personas de ascendencia africana. A partir del [caso de Benjamin Bowsey][] en el Old Bailey en 1780, notamos que "*black*"[^1] es una palabra clave útil para localizar otros casos que involucren a acusados que eran de ascendencia africana. Sin embargo, cuando buscamos "*black*" en el sitio web de Old Bailey, encontramos que a menudo se refiere a otros usos de la palabra: caballos negros o tela negra. La tarea de desambiguar este uso del lenguaje tendrá que esperar a otra lección. Por ahora, vamos a los casos más fáciles. Como historiadores/as, probablemente podamos pensar en palabras clave relacionadas con los descendientes de africanos que valdría la pena explorar. La infame palabra "*n-word*",[^2] no es útil por supuesto, ya que ese término no entró en uso regular hasta mediados del siglo XIX. Pero "*negro*" y "*mulatto*" eran muy utilizadas a principios del siglo XVIII. Estas palabras clave son menos ambiguas que "*black*" y es mucho más probable que sean referencias inmediatas a personas de nuestro grupo demográfico objetivo. Si intentamos buscar por separado estos dos términos en el sitio web de Old Bailey, obtenemos resultados como en estas capturas de pantalla:

{% include figure.html filename="SearchResultsNegro.png" caption="Resultados de búsqueda para 'negro' en The Old Bailey Online" %}

{% include figure.html filename="SearchResultsMulatto.png" caption="Resultados de búsqueda para 'mulatto' en The Old Bailey Online" %}

Después de analizar estos resultados, resulta evidente que se trata de referencias a personas y no a caballos, ropa u otras cosas que pueden ser negras. Queremos tener todos estos registros en nuestra computadora para usarlos en nuestro análisis así que podríamos descargarlos manualmente uno por uno. Pero encontremos una manera programática de automatizar esta tarea.

## La búsqueda avanzada en OBO

Las características de búsqueda de cada sitio web funcionan de manera diferente. Si bien las búsquedas funcionan de manera similar, la complejidad en la que están estructuradas las búsquedas en bases de datos pueden no ser del todo obvias. Por lo tanto, es importante pensar críticamente sobre las opciones de búsqueda en la base de datos y, cuando esté disponible, leer la documentación proporcionada en el sitio web. La o el historiador prudente siempre critica sus fuentes, por lo que los procedimientos que hay detrás de los cuadros de búsqueda deben recibir la misma atención de nuestra parte. El [formulario de búsqueda avanzada][] de Old Bailey Online te permite refinar tus búsquedas en diez campos diferentes, incluidas palabras clave simples, un rango de fechas y un tipo de delito. Como la función de búsqueda de cada sitio web es diferente siempre vale la pena tomarse un tiempo para jugar y leer acerca de las opciones disponibles. Como ya hemos hecho una búsqueda simple de los términos "*negro*" y "*mulatto*", sabemos que habrá resultados. Usaremos la búsqueda avanzada para limitar nuestros resultados a los registros de juicios del *Old Bailey Proceedings* publicados entre 1700 y 1750 solamente. Por supuesto, puedes ajustar la búsqueda como quieras, pero si sigues el ejemplo será más fácil comprender la lección. Ejecuta la búsqueda que se muestra en la imagen de abajo. Asegúrate de marcar el botón de opción "*Advanced*" y usa los comodines `*` para incluir entradas en plural o aquellas con una “e” adicional al final.

{% include figure.html filename="AdvancedSearchExample.png" caption="Ejemplo de búsqueda avanzada en Old Bailey" %}

Efectúa la búsqueda y luego haz clic en el enlace "*Calculate total*" (calcular el total) para ver cuántas entradas hay. Deben ser 13 resultados (si tienes un número diferente, vuelve atrás y asegúrate de haber copiado exactamente el ejemplo anterior). Vamos a descargar estas transcripciones de juicios para analizarlas más a fondo. Por supuesto que puedes decargar cada uno de los 13 registros manualmente. Sin embargo, a medida que se ponen más datos en línea, será necesario manejar descargas de 1,300 o incluso 130,000 registros. La descarga de registros individuales resulta poco práctica y saber cómo automatizar el proceso es una herramienta muy valiosa. Para automatizar el proceso de descarga debemos retroceder y aprender cómo se crean las URL de búsqueda en el sitio web de Old Bailey, un método común en muchas bases de datos y sitios web en línea.

## Comprender las consultas en URL 

Echa un vistazo al URL producido con la última página de resultados de búsqueda. Debe tener un aspecto como este:

``` xml
https://www.oldbaileyonline.org/search.jsp?gen=1&form=searchHomePage&_divs_fulltext=mulatto*+negro*&kwparse=advanced&_divs_div0Type_div1Type=sessionsPaper_trialAccount&fromYear=1700&fromMonth=00&toYear=1750&toMonth=99&start=0&count=0 
```

Ya hemos visto los URL en la lección [Para entender páginas web y HTML][] y éste parece mucho más complicado. Pero, aunque es más largo, en realidad *no* es mucho más complejo. Es sencillo entenderlo al observar cómo se representan nuestros criterios de búsqueda en el URL.

``` xml
https://www.oldbaileyonline.org/search.jsp
?gen=1
&form=searchHomePage
&_divs_fulltext=mulatto*+negro*
&kwparse=advanced
&_divs_div0Type_div1Type=sessionsPaper_trialAccount
&fromYear=1700
&fromMonth=00
&toYear=1750
&toMonth=99
&start=0
&count=0 
```

En esta vista observamos más claramente los 12 datos importantes que necesitamos para realizar nuestra búsqueda (uno por línea). La primera es el URL del sitio web de Old Bailey seguida de una consulta: "?" (No te preocupes por el bit `gen=1`; los desarrolladores de Old Bailey Online dicen que no hace nada) y una serie de 10 *pares de nombre/valor* junto con los caracteres "&". Juntos, estos 10 pares de nombre/valor forman la cadena de consulta que le dice al motor de búsqueda qué variables utilizar en etapas específicas de la búsqueda. Observa que cada par de nombre/valor contiene un nombre de variable, por ejemplo, "toYear", a la que luego se le asigna un valor: 1750. Esto funciona exactamente de la misma manera que los *argumentos de función* cuando pasamos cierta información a variables específicas. En este caso, la variable más importante de la cadena de consulta es `_divs_fulltext=` a la que se le ha dado el valor:

```
mulatto*+negro*
```

Este valor contiene el término de consulta que hemos escrito en el cuadro de búsqueda. El programa ha agregado automáticamente un signo + en lugar de un espacio en blanco ya que los URL no pueden contener espacios. Esto es exactamente lo que le hemos pedido al sitio de Old Bailey que nos encuentre. Las otras variables tienen valores que también definimos. *fromYear* y *toYear* contienen nuestro intervalo de fechas. Como ningún año tiene 99 meses como se sugiere en la variable *toMonth*, podemos asumir que así es como el algoritmo de búsqueda garantiza que se incluyan todos los registros de ese año. No hay reglas estrictas para determinar qué hace cada variable porque las personas que construyeron el sitio les han asignado un nombre arbitrario. A menudo podemos hacer una conjetura basada en nuestra experiencia y conocimiento. Todos los campos de búsqueda posibles en la página de búsqueda avanzada tienen su propio par de nombre/valor. Si deseas averiguar el nombre de la variable para poder usarla, busca de nuevo y asegúrate de poner un valor en el campo de tu interés. Después de enviar tu búsqueda, verás el valor y el nombre asociado a él como parte del URL de la página de resultados. Con el Old Bailey Online, al igual que con muchos otros sitios web, el formulario de búsqueda (avanzado o no) te ayuda esencialmente a construir URLs que le indiquen a la base de datos qué debe buscar. Si comprendes cómo se representan los campos de búsqueda en el URL, que a menudo es bastante sencillo, entonces es relativamente fácil construir los URL mediante programación y, por lo tanto, automatizar el proceso de descarga de registros.

Cambia ahora "**start=0**" por "**start=10**" en el URL y presiona intro. Debes obtener los resultados del 11 al 13. La variable "*start*" le dice al sitio web qué entrada debe mostrarse en la parte superior de la lista de resultados de búsqueda. Deberíamos aprovecharnos de este conocimiento para crear una serie de URL que nos permitirán descargar los 13 archivos. Veamos eso ahora.

## Descarga sistemática de archivos

En [Descargar páginas web con Python][] aprendimos que Python puede descargar una página web siempre que tengamos el URL. En esa lección usamos el URL para descargar la transcripción del proceso de Benjamin Bowsey. En este caso, estamos intentando descargar varias transcripciones de juicios que cumplan con los criterios de búsqueda que describimos anteriormente sin tener que volver a ejecutar el programa repetidamente. En su lugar, queremos un programa que descargue todo lo que necesitamos de una sola vez. En este punto, tenemos el URL de una página de resultados de búsqueda que contiene las diez primeras entradas de nuestra consulta. También sabemos que al modificar el valor de "*start*" en el URL podemos llamar secuencialmente a cada página de resultados de búsqueda y, finalmente, recuperar todos los registros de juicios. Por supuesto, las páginas de resultados no nos dan los los registros de los juicios sino enlaces a ellos. Así que necesitamos extraer el enlace a los registros contenidos en los resultados de búsqueda. En el sitio web de Old Bailey Online, los URL de los registros individuales (los archivos de transcripción de los juicios) se pueden encontrar como enlaces en las páginas de resultados de búsqueda. Sabemos que todas los URL de transcripciones contienen una identificación formada por una "t" seguida de al menos 8 números (por ejemplo, t17800628-33). Al buscar los enlaces que contengan ese patrón, podemos identificar los URL de las transcripciones de los juicios. Al igual que en las lecciones anteriores, desarrollaremos un algoritmo para abordar el problema de tal manera que la computadora lo pueda manejar. Al parecer esta tarea se puede lograr en cuatro pasos. Necesitaremos:

-   Generar los URL para cada página de resultados de búsqueda incrementando en una cantidad fija la variable "start" por un número apropiado de veces.
-   Descargar cada página de resultados de búsqueda como un archivo HTML.
-   Extraer los URL de cada juicio (utilizando el ID de juicio como se describe anteriormente) contenidos en los archivos HTML de los resultados de la consulta.
-   Recorrer esos URL extraídos para descargar cada transcripción de prueba y guardarlas en una carpeta de nuestra computadora.

Recordarás que esto es bastante similar a las tareas que realizamos en [Descargar páginas web con Python][] y [De HTML a lista de palabras (parte 2)][]. Primero descargamos, luego analizamos la información que buscamos y, en este caso, descargamos un poco más.

### Descargar las páginas de resultados de consulta

Primero necesitamos generar los URL para descargar cada página de resultados de consulta. Ya tenemos el primero utilizando el formulario en el sitio web:

``` xml
https://www.oldbaileyonline.org/search.jsp?gen=1&form=searchHomePage&_divs_fulltext=mulatto*+negro*&kwparse=advanced&_divs_div0Type_div1Type=sessionsPaper_trialAccount&fromYear=1700&fromMonth=00&toYear=1750&toMonth=99&start=0&count=0 
```

Podríamos escribir esta URL dos veces y alterar la variable '*start*' para obtener las 13 entradas, pero escribamos un programa que funcione sin importar cuántas páginas de resultados de búsqueda o registros tengamos que descargar, y sin importar qué decidimos buscar. Estudia este código y luego agrega esta función a un módulo llamado `obo.py` (crea un archivo con ese nombre y guárdalo en el directorio donde deseas hacer tu trabajo). Los comentarios en el código están destinados a ayudarte a descifrar las distintas partes.


```python
def obtenResultadosConsulta(query, kwparse, fromYear, fromMonth, toYear, toMonth):

    import urllib2

    startValue = 0

    #Separa cada parte del URL para leerlo mejor.
    url = 'https://www.oldbaileyonline.org/search.jsp?gen=1&form=searchHomePage&_divs_fulltext='
    url += query
    url += '&kwparse=' + kwparse
    url += '&_divs_div0Type_div1Type=sessionsPaper_trialAccount'
    url += '&fromYear=' + fromYear
    url += '&fromMonth=' + fromMonth
    url += '&toYear=' + toYear
    url += '&toMonth=' + toMonth
    url += '&start=' + str(startValue)
    url += '&count=0'

    #Descarga y salva el resultado.
    respuesta = urllib2.urlopen(url)
    contenidoWeb = respuesta.read()
    nombreArchivo = 'resultado-consulta'
    f = open(nombreArchivo + ".html", 'w')
    f.write(contenidoWeb)
    f.close
```

En esta función hemos dividido los diversos componentes de la *cadena de consulta* y hemos utilizado *argumentos de función* para que pueda reutilizarse más allá de nuestras necesidades específicas del momento. Cuando llamamos a esta función, reemplazaremos los argumentos con los valores que queremos buscar. Luego, descargamos la página de resultados de búsqueda de una manera similar a como se hace en [Descargar páginas web con Python][]. Ahora, crea un nuevo archivo: `descarga-consultas.py` y copia en él el siguiente código. Ten en cuenta que los valores que hemos utilizado como argumentos son exactamente los mismos que los del ejemplo anterior. Siéntete libre de jugar con estos para obtener diferentes resultados o ver cómo funcionan.

``` python
#descarga-consultas.py
import obo

query = 'mulatto*+negro*'

obo.obtenResultadosConsulta(query, "advanced", "1700", "00", "1750", "99")
```

Cuando ejecutes este código encontrarás un nuevo archivo llamado `resultado-consulta.html` en tu carpeta de trabajo. Este archivo contiene la primera página de los resultados de búsqueda. Comprueba que se haya descargado correctamente y luego bórralo. Vamos a adaptar nuestro programa para descargar la otra página que contiene las otras 3 entradas al mismo tiempo, por lo que debemos asegurarnos de obtener ambas. Refinemos nuestra función `obtenResultadosConsulta` agregando otro argumento de función llamado “entradas” para que podamos decirle al programa cuántas páginas de resultados necesitamos descargar. Usaremos el valor de las entradas y algunos cálculos matemáticos simples para determinar cuántas páginas de resultados de búsqueda hay. Esto es bastante sencillo ya que sabemos que hay diez transcripciones enumeradas por página. Podemos calcular el número de páginas de resultados dividiendo el valor de las entradas por 10. Guardaremos este resultado en una variable entera llamada `contarPaginas`.[^3] Se parece a esto:


``` python
#determina la cantidad de archivos a descargar.
contarPaginas = entradas / 10
```

Sin embargo, debido a que `contarPaginas` es un número entero y no puede tener decimales ni residuo, Python eliminará el sobrante. Prueba esto ejecutando el siguiente código en tu Terminal (Mac y Linux) / cmd o PowerShell (Windows) e imprimiendo el valor contenido en `contarPaginas`. (Nota, de aquí en adelante, usaremos la palabra Terminal para referirnos al intérprete de línea de comandos).


``` python
entradas = 13
contarPaginas = entradas / 10
print(contarPaginas)
-> 1
```

Sabemos que deberíamos leer "2" (una página que contiene las entradas 1 a 10, y otra que contiene las entradas 11 a 13). Dado que hay un residuo o resto en esta operación (de 3, pero no importa cuál sea), los últimos 3 resultados no se descargarán ya que solo capturaremos 1 página de 10 resultados. Para solucionar este problema utilizaremos el operador [modulo][] (%) en lugar del operador de división habitual (/). `Modulo` divide el primer valor por el segundo y devuelve el resto. Entonces, si el residuo es mayor que 0, sabemos que hay una página parcial de resultados y necesitamos aumentar el valor de `contarPaginas` en uno. El código ahora debería verse así:


``` python
#determina la cantidad de archivos a descargar.
contarPaginas = entradas / 10
resto = entradas % 10
if resto > 0:
    contarPaginas += 1
```

Si agregamos esto a nuestra función `obtenResultadosConsulta` justo debajo de la línea `startValue = 0`, nuestro programa podrá calcular el número de páginas que deben descargarse. Sin embargo, en esta etapa solo se descargará la primera página ya que hemos indicado, en la sección de la función de descarga, que se ejecute solamente una vez. Para corregirlo, debemos agregar un bucle `for` al código de descarga que trabajará una vez por cada número que se indique en la variable `contarPaginas`. Si lee 1, entonces descargará una vez; si lee 5 descargará cinco veces, y así sucesivamente. Inmediatamente después de la instrucción `if` que acabas de escribir, agrega la siguiente línea y todo lo que está debajo de `f.close` con un tabulador adicional para que esté se incluya en el bucle `for`:


``` python
for paginas in range(1, contarPaginas+1):
    print(paginas)
```

Dado que este es un bucle `for`, todo el código que queremos ejecutar repetidamente debe estar bien planeado. Puedes saber si lo has hecho correctamente al ver el ejemplo de código terminado a continuación. Este bucle aprovecha la función [range][] de Python. Para entender esto, es mejor pensar que `contarPaginas` es igual a 2 como se muestra en el ejemplo. Estas dos líneas de código significan: "comienza a ejecutarlo con un valor de bucle inicial de 1, y cada vez que ejecutes agrega 1 más a ese valor. Cuando el valor del bucle es el mismo que `contarPaginas`, ejecuta una vez más y luego detente." Esto es particularmente valioso para nosotros porque significa que podemos decirle a nuestro programa que se ejecute exactamente una vez para cada página de resultados y proporciona una nueva habilidad, flexible, para controlar cuántas veces se ejecuta el bucle `for`. Si deseas practicar con esta nueva y poderosa forma de escribir bucles, puedes abrir tu Terminal y jugar.


``` python
contarPaginas = 2
for paginas in range(1, contarPaginas+1):
    print(paginas)

-> 1
-> 2
```

Antes de agregar todo este código a nuestra función `obtenResultadosConsulta`, tenemos que hacer dos ajustes finales. Al final del bucle `for` (pero aún dentro del bucle), y después de que se haya ejecutado nuestro código de descarga, necesitaremos cambiar la variable `startValue` que se usa para crear el URL de la página que queremos descargar. Si no lo hacemos, nuestro programa descargará repetidamente la primera página de resultados pues no estamos cambiando nada en la URL inicial. La variable `startValue`, como se discutió anteriormente, es lo que controla qué página de resultados queremos descargar. Por lo tanto, podemos solicitar la siguiente página de resultados de búsqueda aumentando el valor de `startValue` en 10 una vez que se haya completado la descarga inicial. Si no tienes idea de dónde colocar esta línea, puedes echar un vistazo al ejemplo de código terminado, más abajo.

Finalmente, debemos asegurarnos que el nombre del archivo que hemos descargado sea diferente para cada registro. De lo contrario, cada descarga se guardará sobre escribiendo la descarga anterior, lo que nos dejará con un solo archivo de resultados. Para resolver esto, debemos ajustar el contenido de la variable `nombreArchivo` para incluir el valor contenido en `startValue`. Así, cada vez que descarguemos una nueva página obtendremos un nombre diferente. Como `startValue` es un entero, tendremos que convertirlo en una cadena antes de poder agregarlo a la variable de nombre de archivo. Ajusta la línea en tu programa que pertenece a la variable `nombreArchivo` para que se vea así:

``` python
nombreArchivo = 'resultado-consulta' + str(startValue)
```

Ahora puedes agregar estas nuevas líneas de código a tu función `obtenResultadosConsulta`. Recordemos que hemos hecho las siguientes adiciones:

-   Agregamos entradas como un argumento de función adicional justo después de toMonth
-   Calculamos el número de páginas de resultados e incluimos esto inmediatamente después de la línea que comienza con "startValue = 0" (antes de crear la URL y comenzar a descargar)
-   Inmediatamente después de esto añadimos un bucle `for` que le indicará al programa que se ejecute una vez para cada página de resultados de búsqueda. Es importante indentar el resto del código de la función para que quede dentro del nuevo bucle.
-   La última línea en el bucle `for` debe aumentar el valor de la variable *startValue* cada vez que se ejecuta el bucle.
-   Ajustamos la variable `nombreArchivo` existente para que cada vez que se descargue una página de resultados se le dé un nombre único al archivo.

El código de función terminado en el archivo `obo.py` deberá verse de la siguiente manera:

```python
#crea URLs para las paginas de resultados de consulta y gurda los archivos
def obtenResultadosConsulta(query, kwparse, fromYear, fromMonth, toYear, toMonth, entradas):

    import urllib2

    startValue = 0

    #esta es nueva! Determina la cantidad de archivos que debemos descargar.
    contarPaginas = entradas / 10
    resto = entradas % 10
    if resto > 0:
        contarPaginas += 1

    #Esta linea es nueva
    for paginas in range(1, contarPaginas +1):

        #Separa cada parte del URL para leerlo mejor.
        url = 'https://www.oldbaileyonline.org/search.jsp?gen=1&form=searchHomePage&_divs_fulltext='
        url += query
        url += '&kwparse=' + kwparse
        url += '&_divs_div0Type_div1Type=sessionsPaper_trialAccount'
        url += '&fromYear=' + fromYear
        url += '&fromMonth=' + fromMonth
        url += '&toYear=' + toYear
        url += '&toMonth=' + toMonth
        url += '&start=' + str(startValue)
        url += '&count=0'

        #Descarga y salva el resultado.
        respuesta = urllib2.urlopen(url)
        contenidoWeb = respuesta.read()
        nombreArchivo = 'resultado-consulta' + str(startValue)
        f = open(nombreArchivo + ".html", 'w')
        f.write(contenidoWeb)
        f.close

        #esto es nuevo!
        startValue = startValue + 10
```

Para ejecutar esta nueva función hay que agregar un argumento extra al archivo `descarga-consultas.py`. Deberás ejecutar el programa de nuevo:

``` python
#descarga-consultas.py
import obo

query = 'mulatto*+negro*'

obo.obtenResultadosConsulta(query, "advanced", "1700", "00", "1750", "99", 13)
```

¡Estupendo! Ahora tenemos dos páginas de resultados de búsqueda, llamadas `resultado-consulta0.html` y `resultado-consulta10.html`. Pero antes de ir al siguiente paso en el algoritmo, vamos a ocuparnos de algunas tareas de limpieza. Nuestra carpeta de trabajo se volverá difícil de manejar si descargamos varias páginas de resultados y transcripciones de juicios en ella. Por tanto, con Python crearemos un nuevo directorio con el nombre de nuestros términos de búsqueda. Estudia y luego copia el siguiente código a `obo.py`.

``` python
def nuevoDirectorio(nuevoDirectorio):
    import os

    dir = nuevoDirectorio

    if not os.path.exists(dir):
        os.makedirs(dir)
```

Vamos a llamar a esta nueva función en `obtenResultadosConsulta`, para que nuestras páginas de resultados se descarguen en un directorio con el mismo nombre que nuestra consulta. Esto mantendrá nuestra carpeta de trabajo más organizada. Para hacer esto, crearemos un nuevo directorio usando la biblioteca `os`, abreviatura de *operative system* o “sistema operativo”. Esa biblioteca contiene una función llamada `makedirs`, que, como es de esperar, crea un nuevo directorio. Puedes probar esto usando la Terminal.


``` python
import os

query = "miNuevoDirectorio"
if not os.path.exists(query):
    os.makedirs(query)
```

Este programa verificará si tu computadora ya tiene un directorio con este nombre. Si no, ahora deberías tener un directorio llamado `miNuevoDirectorio` en tu computadora. En una Mac lo encontrarás en tu directorio `/Users/username/`, y en Windows deberías quedar en el directorio `Python` de tu computadora, el mismo en el que abriste tu intérprete de línea de comandos. Si esto funcionó, puedes eliminar el directorio de tu disco duro ya que fue solo para practicar. Como queremos crear un nuevo directorio con el nombre de la consulta que ingresamos en el sitio web de Old Bailey Online, haremos uso directo del argumento de función `query` en la función `obtenResultadosConsulta`. Para hacer esto, importa el directorio `os` después de haber importado `urllib2` y luego agrega el código que acabas de escribir inmediatamente a continuación. Tu función `obtenResultadosConsulta` ahora debería verse así:

```python
#crea URLs para las paginas de resultados de consulta y gurda los archivos
def obtenResultadosConsulta(query, kwparse, fromYear, fromMonth, toYear, toMonth, entradas):

    import urllib2, os

    #Esta linea es nueva! Crea un nuevo directorio
    if not os.path.exists(query):
        os.makedirs(query)

    startValue = 0

    #Determina la cantidad de archivos que debemos descargar.
    contarPaginas = entradas / 10
    resto = entradas % 10
    if resto > 0:
        contarPaginas += 1

    for paginas in range(1, contarPaginas +1):

        #Separa cada parte del URL para leerlo mejor.
        url = 'https://www.oldbaileyonline.org/search.jsp?gen=1&form=searchHomePage&_divs_fulltext='
        url += query
        url += '&kwparse=' + kwparse
        url += '&_divs_div0Type_div1Type=sessionsPaper_trialAccount'
        url += '&fromYear=' + fromYear
        url += '&fromMonth=' + fromMonth
        url += '&toYear=' + toYear
        url += '&toMonth=' + toMonth
        url += '&start=' + str(startValue)
        url += '&count=0'

        #Descarga y salva el resultado.
        respuesta = urllib2.urlopen(url)
        contenidoWeb = respuesta.read()

	#Guarda el resultado en el nuevo directorio
        nombreArchivo = 'resultado-consulta' + str(startValue)

        f = open(nombreArchivo + ".html", 'w')
        f.write(contenidoWeb)
        f.close

        startValue = startValue + 10
```

El último paso de esta función es asegurarse que guardemos nuestras páginas de resultados de búsqueda en este nuevo directorio. Para ello, podemos ajustar ligermente la variable de nombre del archivo para que el archivo termine en el lugar correcto. Podemos hacerlo de muchas maneras, pero la más sencilla es agregar el nuevo nombre del directorio más una barra al nombre del archivo:

``` python
nombreArchivo = query + '/' + 'resultado-consulta' + str(startValue)
```

Si tu computadora ejecuta Windows, necesitarás usar una barra invertida en lugar de la barra inclinada en el ejemplo anterior. Agrega la línea anterior a tu página `obtenResultadosConsulta` en lugar de la descripción actual de `nomnbreArchivo`.

Tambnién, si estás ejecutando Windows, es probable que tu programa `descarga-consultas.py` se bloquee al ejecutarlo porque está tratando de crear un directorio con un \* en él. A Windows no le gusta esto. Para solucionar este problema podemos usar [expresiones regulares][] (*regular expressions*) para eliminar cualquier carácter no compatible con Windows. Ya usamos expresiones regulares previamente en la lección [Contar frecuencias de palabras con Python][]. Para eliminar caracteres no alfanuméricos de la consulta, primero importa la biblioteca de expresiones regulares `re` inmediatamente después de haber importado la biblioteca `os`, luego utiliza la función `re.sub()` para crear una nueva cadena llamada `limpiarConsulta` que contenga solo caracteres alfanuméricos. Luego tendrás que incluir `limpiarConsulta` como variable en las declaraciones `os.path.exists()`, `os.makedirs()` y `nombreArchivo`. 


``` python
import urllib2, os, re
limpiarConsulta = re.sub(r'\W+', '', query)
if not os.path.exists(limpiarConsulta):
        os.makedirs(limpiarConsulta)

...

nombreArchivo = limpiarConsulta + '/' + 'resultado-consulta' + str(startValue)
```

La versión final de tu función debería verse de la siguiente manera:

```python
#crea URLs para las paginas de resultados de consulta y gurda los archivos
def obtenResultadosConsulta(query, kwparse, fromYear, fromMonth, toYear, toMonth, entradas):

    import urllib2, os, re

    limpiarConsulta = re.sub(r'\W+', '', query)

    #Crea un nuevo directorio
    if not os.path.exists(limpiarConsulta):
        os.makedirs(limpiarConsulta)

    startValue = 0

    #Determina la cantidad de archivos que debemos descargar.
    contarPaginas = entradas / 10
    resto = entradas % 10
    if resto > 0:
        contarPaginas += 1

    for paginas in range(1, contarPaginas +1):

        #Separa cada parte del URL para leerlo mejor.
        url = 'https://www.oldbaileyonline.org/search.jsp?gen=1&form=searchHomePage&_divs_fulltext='
        url += query
        url += '&kwparse=' + kwparse
        url += '&_divs_div0Type_div1Type=sessionsPaper_trialAccount'
        url += '&fromYear=' + fromYear
        url += '&fromMonth=' + fromMonth
        url += '&toYear=' + toYear
        url += '&toMonth=' + toMonth
        url += '&start=' + str(startValue)
        url += '&count=0'

        #Descarga y salva el resultado.
        respuesta = urllib2.urlopen(url)
        contenidoWeb = respuesta.read()

	#Guarda el resultado en el nuevo directorio
        nombreArchivo = limpiarConsulta + '/' +  'resultado-consulta' + str(startValue)
        f = open(nombreArchivo + ".html", 'w')
        f.write(contenidoWeb)
        f.close

        startValue = startValue + 10
```

Esta vez le decimos al programa que descargue los juicios y los coloque en el nuevo directorio en lugar de en nuestra carpeta de trabajo. Ejecuta `descarga-consultas.py` una vez más para asegurarte de que funcione y entiendas cómo guardar archivos en un directorio en particular usando Python. 

### Descargar las entradas individuales de los juicios

A estas alturas, hemos creado una función que puede descargar todos los archivos HTML con los resultados de consulta del sitio web de Old Bailey Online, para realizar la búsqueda avanzada que hemos definido. Todo lo hemos hecho mediante programación. Para el siguiente paso del algoritmo extrae las URL de cada juicio de los archivos HTML. En las lecciones que preceden a ésta (por ejemplo, [Descargar páginas web con Python][]), hemos trabajado con las versiones amigables para imprimir de los juicios, por lo que continuaremos haciéndolo. Sabemos que la versión para imprimir del juicio contra Benjamin Bowsey se encuentra en la URL:

``` xml
http://www.oldbaileyonline.org/print.jsp?div=t17800628-33
```

De la misma manera que al cambiar las cadenas de consulta en las URL se producen resultados de búsqueda diferentes, al cambiar la URL por registros de juicios –es decir, sustituyendo la ID de un juicio por otra–, obtendremos la transcripción de otro proceso. Esto significa que, para encontrar y descargar los 13 archivos coincidentes, todo lo que necesitamos son los ID de los juicios. Como sabemos que las páginas de resultados de búsqueda en los sitios web generalmente contienen un enlace a las páginas descritas, es muy probable que podamos encontrar estos enlaces incrustados en el código HTML. Si en otras lecciones pudimos eliminar esta información de la página que descargamos, ahora podemos usar esa información para generar una URL que nos permita descargar cada transcripción de juicio. Esta es una técnica que se puede usar en la mayoría de las páginas de resultados de búsqueda, no solo la de Old Bailey Online. Para hacerlo, primero debemos encontrar dónde están los ID de cada juicio en medio del código HTML de los archivos descargados. Luego, tendremos que buscar una forma de aislarlos, que sea constante, usando el código de tal forma que no importe qué página de resultados de búsqueda descarguemos del sitio, siempre podamos encontrar las transcripciones de los juicios. Primero, abre el archivo `resultado-consulta0.html` en Komodo Edit y échale un vistazo a la lista de los juicios. La primera entrada comienza con "Anne Smith", por lo que puedes usar `Find` (`menu->edit->find`, N. del T.) en Komodo Edit para ir inmediatamente al lugar correcto. Observa que el nombre de Anne es parte de un enlace:


``` xml
browse.jsp?id=t17160113-18&amp;div=t17160113-18&amp;terms=mulatto*_negro*#highlight 
```

¡Perfecto, el enlace contiene el ID del juicio! Desplázate por las entradas restantes y encontrarás lo mismo. Por suerte para nosotros, el sitio está bien construido y parece que cada enlace comienza con "browse.jsp?id=" seguido del ID del juicio y finaliza con un `&`, en el caso de Anne: "browse.jsp?id=t17160113-18&". Vamos a escribir algunas líneas de código que aislen estos identificadores al final de nuestro archivo `obo.py`. Echa un vistazo a la siguiente función. También utiliza la biblioteca `os`, en este caso para enumerar todos los archivos ubicados en el directorio creado en la sección anterior. La biblioteca `os` contiene una gama de funciones útiles que reflejan los tipos de tareas que podrías realizar con tu ratón en el Finder de Mac o el explorador de Windows, como abrir, cerrar, crear, eliminar y mover archivos y directorios. Es una excelente biblioteca que deberíamos dominar o, al menos, familiarizarnos con ella.


``` python
def obtenJuiciosIndiv(query):
    import os, re

    limpiarConsulta = re.sub(r'\W+', '', query)
    resultadosBusqueda = os.listdir(limpiarConsulta)

    print(resultadosBusqueda)
```

Crea y ejecuta un muevo programa llamado `extrae-id-juicios.py` con el siguiente código. Asegúrate de introducir el mismo valor en el argumento de consulta como en el ejemplo anterior.

``` python
import obo

obo.obtenJuiciosIndiv("mulatto*+negro*")
```

Si todo sale bien, deberías ver la lista de los nombres de todos los archivos que están en la nueva carpeta "mulatto\* + black\*". Por ahora deberen ser solamente las dos páginas con los resultados de búsqueda. Asegúrate de que esto funcione antes de seguir adelante. Dado que guardamos todas las páginas de resultados de búsqueda con un nombre de archivo que incluye "resultados de búsqueda", queremos abrir cada archivo con un nombre que contenga "resultados de búsqueda" y extraer todos los ID de los juicios que se encuentran en él. En este caso, sabemos que tenemos 2, pero queremos que nuestro código sea lo más reutilizable posible (¡razonablemente, por supuesto!) Restringir esta acción a los archivos denominados "resultados de búsqueda" significará que este programa funcionará como se espera, incluso si el directorio contiene muchos otros archivos no relacionados porque el programa saltará cualquier cosa con un nombre diferente. Agrega lo siguiente a tu función `obtenJuiciosIndiv()`, que verificará si cada archivo contiene "resultados de búsqueda" en su nombre. Si lo hace, el archivo se abrirá y los contenidos se guardarán en una variable llamada texto. El texto de la variable se analizará buscando el ID del juicio, que sabemos que siempre sigue a "browse.jsp?id=". Cuando se encuentre ese ID del juicio, se guardará en una lista y se imprimirá en la salida de comandos de Komodo, lo que nos deja con toda la información que necesitamos para escribir en ese programa que descargará las pruebas deseadas.

``` python
    import os, re

    limpiarConsulta = re.sub(r'\W+', '', query)
    resultadosBusqueda = os.listdir(limpiarConsulta)

    urls = []

    #encuentra las paginas resultados consulta
    for archivos in resultadosBusqueda:
        if archivos.find("resultado-busqueda") != -1:
            f = open(limpiarConsulta + "/" + files, 'r')
            texto = f.read().split(" ")
            f.close()

            #buscar los IDs de juicios
            for palabras in texto:
                if palabras.find("browse.jsp?id=") != -1:
                    #aisla el id
                    urls.append(palabras[palabras.find("id=") +3: palabras.find("&")])

    print(urls)
```

La última línea del bucle `for` puede parecer complicada, pero asegúrate de entenderla antes de continuar. La variable `palabras` comprueba que contenga los caracteres "id =" (sin las comillas) que, por supuesto, se refieren al ID de una transcripción de juicio específica. Si lo hace, usamos el método de segmentación de cadena (`slice string`) para capturar solo la subcadena que hay entre `id=` y `&`, agregándola a la lista de url. Si conociéramos las posiciones de índice exactas de esta subcadena, podríamos haber utilizado sus valores numéricos. Sin embargo, al utilizar el método `find()`, hemos creado un programa mucho más flexible. El siguiente código hace exactamente lo mismo que la última línea, pero de una manera menos condensada.


``` python
idInicio = palabras.find("id=") + 3
idFinal = palabras.find("&")
IDJuicio = palabras[idInicio: idFinal]

urls.append(IDJuicio)
```

Cuando vuelvas a ejecutar `extrae-id-juicios.py`, verás una lista de todos los ID de los juicios. Podemos agregar un par de líneas adicionales para convertirlas en URL adecuados y descargar la lista completa en nuestro nuevo directorio. También usaremos la biblioteca `time` para pausar nuestro programa durante tres segundos entre las descargas. Esta técnica es llamada "limitación". Se considera una buena forma de no golpear el servidor de alguien con muchas solicitudes por segundo; y el ligero retraso hace que sea más probable que todos los archivos se descarguen antes de agotar nuestro tiempo de conexión (ver [time out][]). Agrega el siguiente código al final de la función `obtenJuiciosIndiv()`. Este código generará la URL de cada página individual, la descargará en tu computadora, la colocará en su nuevo directorio, guardará el archivo y se detendrá por 3 segundos antes de pasar al siguiente juicio. Este trabajo está contenido en un bucle `for` que se ejecutará una vez por cada juicio en tu lista de urls.


``` python
def obtenJuiciosIndiv(query):
    #...
    import urllib2, time

    #importa las funciones incorporadas de Python para construir rutas de archivos
    from os.path import join as pjoin

    for items in urls:
        #genera el URL
        url = "http://www.oldbaileyonline.org/print.jsp?div=" + items

        #descarga la pagina
        respuesta = urllib2.urlopen(url)
        contenidoWeb = respuesta.read()

        #crea el nombre de archivo y colocalo en el nuevo directorio
        nombreArchivo = items + '.html'
        rutaArchivo = pjoin(limpiarConsulta, nomnbreArchivo)

        #guarda el archivo
        f = open(rutaArchivo, 'w')
        f.write(contenidoWeb)
        f.close

        #pausa de 3 segundos
        time.sleep(3)
```

Si juntamos todo en una sola función debería verse algo como lo que sigue. (Ten en cuenta que hemos puesto todas las llamadas de "importación" de bibliotecas de Python en la parte superior para mantener las cosas más limpias).


``` python
def obtenJuiciosIndiv(query):
    import os, re, urllib2, time

    #importa las funciones incorporadas de Python para construir rutas de archivos
    from os.path import join as pjoin

    limpiarConsulta = re.sub(r'\W+', '', query)
    resultadosBusqueda = os.listdir(limpiarConsulta)

    urls = []

    #encuentra las paginas resultados consulta
    for archivos in resultadosBusqueda:
        if archivos.find("resultado-consulta") != -1:
            f = open(limpiarConsulta + "/" + archivos, 'r')
            texto = f.read().split(" ")
            f.close()
            
            #buscar los IDs de juicios
            for palabras in texto:
                if palabras.find("browse.jsp?id=") != -1:
                    #aisla el ID
                    urls.append(palabras[palabras.find("id=") +3: palabras.find("&")])

    #nuevo desde aqui para abajo
    for items in urls:
        #genera el URL
        url = "http://www.oldbaileyonline.org/print.jsp?div=" + items

        #descarga la pagina
        respuesta = urllib2.urlopen(url)
        contenidoWeb = respuesta.read()

        #crea el nombre de archivo y colocalo en el nuevo directorio
        nombreArchivo = items + '.html'
        rutaArchivo = pjoin(limpiarConsulta, nomnbreArchivo)

        #guarda el archivo
        f = open(rutaArchivo, 'w')
        f.write(contenidoWeb)
        f.close

        #pausa de 3 segundos
        time.sleep(3)
```

Agreguemos la misma pausa de tres segundos a nuestra función `getSearchResults` para ser amables con los servidores de Old Bailey Online:

``` python
#crea URLs para las paginas de resultados de consulta y guarda los archivos
def obtenResultadosConsulta(query, kwparse, fromYear, fromMonth, toYear, toMonth, entradas):

    import urllib2, os, re, time

    limpiarConsulta = re.sub(r'\W+', '', query)
    if not os.path.exists(limpiarConsulta):
        os.makedirs(limpiarConsulta)

    startValue = 0

    #Determina la cantidad de archivos que debemos descargar.
    contarPaginas = entradas / 10
    resto = entradas % 10
    if resto > 0:
        contarPaginas += 1

    for paginas in range(1, contarPaginas +1):

        #Separa cada parte del URL para leerlo mejor.
        url = 'https://www.oldbaileyonline.org/search.jsp?gen=1&form=searchHomePage&_divs_fulltext='
        url += query
        url += '&kwparse=' + kwparse
        url += '&_divs_div0Type_div1Type=sessionsPaper_trialAccount'
        url += '&fromYear=' + fromYear
        url += '&fromMonth=' + fromMonth
        url += '&toYear=' + toYear
        url += '&toMonth=' + toMonth
        url += '&start=' + str(startValue)
        url += '&count=0'

        #Descarga y salva el resultado.
        respuesta = urllib2.urlopen(url)
        contenidoWeb = respuesta.read()

	#Guarda el resultado en el nuevo directorio
        nombreArchivo = limpiarConsulta + '/' +  'resultado-consulta' + str(startValue)
        f = open(nombreArchivo + ".html", 'w')
        f.write(contenidoWeb)
        f.close

        startValue = startValue + 10

        #pausa de 3 segundos
        time.sleep(3)
```

Finalmente, llama a la función desde el archivo de programa `descarga-consultas.py`.

``` python
#descarga-consultas.py
import obo

query = 'mulatto*+negro*'

obo.obtenResultadosConsulta(query, "advanced", "1700", "00", "1750", "99", 13)

obo.obtenJuiciosIndiv(query)
```

Has creado un programa que puede solicitar y descargar archivos del sitio web de Old Bailey según los parámetros de búsqueda que defiste, ¡todo sin visitar el sitio!

### En caso de que los archivos no se descarguen

Comprueba que los trece archivos se hayan descargado correctamente. Si es así, ¡genial! Sin embargo, existe la posibilidad de que el programa se atore en el proceso. Esto se debe a que, aunque el programa se ejecute en nuestra propia máquina, se basa en dos factores que están fuera de nuestro control inmediato: la velocidad de Internet y el tiempo de respuesta del servidor Old Bailey Online en ese momento. Una cosa es pedirle a Python que descargue un solo archivo; pero cuando le pedimos que descargue un archivo cada 3 segundos, existe una gran probabilidad de que el servidor agote el tiempo de conexión o no nos envíe el archivo que buscamos.

Si estuviéramos usando un navegador web para hacer estas solicitudes, eventualmente recibiríamos un mensaje diciendo que "la conexión se ha agotado" o algo por el estilo. Todos vemos esto de vez en cuando. Sin embargo, nuestro programa no está diseñado para manejar o transmitir dichos mensajes de error. En su lugar, te darás cuenta cuando descubras que el programa no ha devuelto el número esperado de archivos o que simplemente no hace nada. Para evitar la frustración y la incertidumbre, queremos un programa a prueba de fallas que intente descargar cada juicio. Si por alguna razón falla, lo anotaremos y pasaremos al siguiente juicio.

Para hacer esto, haremos uso del mecanismo de manejo de errores y excepciones de Python [try / except][] (ver [errores y excepciones][]), así como una nueva biblioteca: `socket`. `Try / Except` se parece mucho a una declaración `if / else`. Cuando le pides a Python que *pruebe* algo (`try`), intentará ejecutar el código. Si el código no logra hacer lo que se ha definido, ejecutará el código `except`. Esto se usa a menudo cuando se trata de errores, conocido como *manejo de errores*. Podemos tomar ventaja de esto diciéndole a nuestro programa que intente descargar una página. Si falla, le pediremos que nos informe qué archivo falló y luego seguiremos adelante. Para esto necesitamos usar la biblioteca `socket`, que nos permitirá poner un límite de tiempo en un intento de descarga antes de continuar. Esto implica alterar la función `obtenJuiciosIndiv`.

Primero debemos cargar la biblioteca `socket`, que debe hacerse de la misma manera que todas nuestras importaciones de bibliotecas anteriores. También tendremos que establecer la duración predeterminada del tiempo de espera de `socket`: cuánto tiempo intentaremos descargar una página antes de darnos por vencidos. Esto debe escribirse inmediatamente después del comentario que comienza con `#descargar la página`

```
import os, urllib2, time, socket

    #...
        #descargar la pagina
        socket.setdefaulttimeout(10)
```

Luego, necesitamos una nueva lista de Python que contendrá todas las direcciones URL que no se pudieron descargar. Llamaremos a esto `intentosFallidos` y puedes insertarlo inmediatamente después de las instrucciones `import`:

```
 intentosFallidos = []
```

Ahora agregaremos la declaración `try / except`, que se inserta de la misma manera que una declaración `if / else`. En este caso, pondremos todo el código diseñado para descargar y guardar los juicios en la declaración `try`, y en la declaración `exception` le diremos al programa lo que queremos que haga si eso falla. Aquí, agregaremos la url que no se pudo descargar a nuestra nueva lista, `intentosFallidos`.


``` python
#...

        socket.setdefaulttimeout(10)

        try:
            respuesta = urllib2.urlopen(url)
            contenidoWeb = respuesta.read()

            #crea el nombre de archivo y colocalo en el nuevo directorio
            nombreArchivo = items + '.html'
            rutaArchivo = pjoin(limpiarConsulta, nombreArchivo)

            #guarda el archivo
            f = open(rutaArchivo, 'w')
            f.write(contenidoWeb)
            f.close
        except:
            intentosFallidos.append(url)
```

Para terminar, le indicaremos al programa que imprima el contenido de la lista en la salida de comandos para saber qué archivos no se pudieron descargar. Esto debe agregarse como la última línea en la función.

```
print "error de descarga: " + str(intentosFallidos) 
```

Si surge un problema al descargar un archivo en particular cuando ejecutes el programa, recibirás un mensaje en la ventana de salida de comandos de Komodo Edit. Este mensaje contendrá cualquier URL de archivos que no se hayan podido descargar. Si solo hay uno o dos, probablemente sea más rápido visitar las páginas manualmente y usar la función "Guardar como" de tu navegador. Pero si tienes espíritu de aventura puedes modificar el programa para descargar automáticamente los archivos restantes. La versión final de las funciones `obtenResultadosConsulta()`, `obtenJuiciosIndiv()` y `nuevoDirectorio ()` ahora deberían tener este aspecto en `obo.py`:


``` python
def obtenResultadosConsulta(query, kwparse, fromYear, fromMonth, toYear, toMonth, entries):

    import urllib2, os, re, time

    limpiarConsulta = re.sub(r'\W+', '', query)
    if not os.path.exists(limpiarConsulta):
        os.makedirs(limpiarConsulta)

    startValue = 0

    #Determina la cantidad de archivos que debemos descargar.
    contarPaginas = entradas / 10
    resto = entradas % 10
    if resto > 0:
        contarPaginas += 1

    for paginas in range(1, contarPaginas +1):

        #Separa cada parte del URL para leerlo mejor.
        url = 'https://www.oldbaileyonline.org/search.jsp?gen=1&form=searchHomePage&_divs_fulltext='
        url += query
        url += '&kwparse=' + kwparse
        url += '&_divs_div0Type_div1Type=sessionsPaper_trialAccount'
        url += '&fromYear=' + fromYear
        url += '&fromMonth=' + fromMonth
        url += '&toYear=' + toYear
        url += '&toMonth=' + toMonth
        url += '&start=' + str(startValue)
        url += '&count=0'

        #Descarga y salva el resultado.
        respuesta = urllib2.urlopen(url)
        contenidoWeb = respuesta.read()

        nombreArchivo = limpiarConsulta + '/' +  'resultado-consulta' + str(startValue)        
	f = open(nombreArchivo + ".html", 'w')
        f.write(contenidoWeb)
        f.close

        startValue = startValue + 10

        #pausa de 3 segundos
        time.sleep(3)

def obtenJuiciosIndiv(query):
    import os, re, urllib2, time, socket

    intentosFallidos = []

    #importa las funciones incorporadas de Python para construir rutas de archivos
    from os.path import join as pjoin

    limpiarConsulta = re.sub(r'\W+', '', query)
    resultadosBusqueda = os.listdir(limpiarConsulta)

    urls = []

    #encuentra las paginas resultados consulta
    for archivos in resultadosBusqueda:
        if archivos.find("resultado-consulta") != -1:
            f = open(limpiarConsulta + "/" + archivos, 'r')
            texto = f.read().split(" ")
            f.close()
            
            #buscar los IDs de juicios
            for palabras in texto:
                if palabras.find("browse.jsp?id=") != -1:
                    #aisla el ID
                    urls.append(palabras[palabras.find("id=") +3: palabras.find("&")])

    for items in urls:
        #genera el URL
        url = "http://www.oldbaileyonline.org/print.jsp?div=" + items

        #descarga la pagina
        socket.setdefaulttimeout(10)
        try:
            respuesta = urllib2.urlopen(url)
            contenidoWeb = respuesta.read()

            #crea el nombre de archivo y colocalo en el nuevo directorio
            nombreArchivo = items + '.html'
            rutaArchivo = pjoin(limpiarConsulta, nombreArchivo)

            #guarda el archivo
            f = open(rutaArchivo, 'w')
            f.write(contenidoWeb)
            f.close
        except:
            intentosFallidos.append(url)
        #pausa de 3 segundos
        time.sleep(3)
    print "error de descarga: " + str(intentosFallidos)

def nuevoDir(nuevoDir):
    import os

    dir = nuevoDir

    if not os.path.exists(dir):
        os.makedirs(dir)
```

## Otras lecturas

Para usuarias/os más avanzadas/os, o para adquirir más destreza, vale la pena leer acerca de cómo lograr este mismo proceso utilizando las interfaces de programación de aplicaciones (API). Un sitio web con una API generalmente proporcionará instrucciones sobre cómo solicitar ciertos documentos. Es un proceso muy similar al que acabamos de hacer interpretando las cadenas de consulta de URL, pero sin el trabajo adicional de detective que hicimos para descifrar el comportamiento de cada variable. Si tienes interés en el Old Bailey Online, el sitio cuenta con una API y su documentación es muy útil.

-   Old Bailey Online API (<http://www.oldbaileyonline.org/static/DocAPI.jsp>) 
-   Python Best way to create directory if it doesn’t exist for file write? (<http://stackoverflow.com/questions/273192/python-best-way-to-create-directory-if-it-doesnt-exist-for-file-write>) 

## Recursos en español

* **_Tutorial de Python v2.7.0_**, (<http://docs.python.org.ar/tutorial/2/index.html>)


[^1]: __N. del T.__ Se dejan los términos de búsqueda en inglés ya que son los que arrojan resultados en la página web de *Old Bailey Online*.  
[^2]: __N. del T.__ El eufemismo "n-word" se refiere a una de las palabras más ofensivas que existe en lengua inglesa para designar a los afrodescendientes. Puede verse la explicación [aquí].  
[^3]: __N. del T.__ Al establecer los nombres de variables y funciones en Python 2.x.x hay que evitar acentos, tildes y otros signos diacríticos dado que el intérprete solamente reconoce caracteres ASCII a menos que se indique otra codificación de caracteres como UTF-8. 

  [Old Bailey Online]: http://www.oldbaileyonline.org/
  [Automated Downloading with WGET]: /lessons/automated-downloading-with-wget
  [caso de Benjamin Bowsey]: http://www.oldbaileyonline.org/browse.jsp?id=t17800628-33&div=t17800628-33
  [formulario de búsqueda avanzada]: http://www.oldbaileyonline.org/forms/formMain.jsp
  [Para entender páginas web y HTML]: /lecciones/ver-archivos-html
  [Descargar páginas web con Python]: /lecciones/trabajar-con-paginas-web
  [De HTML a lista de palabras (parte 2)]: /lecciones/de-html-a-lista-de-palabras-2
  [modulo]: http://docs.python.org/release/2.5.2/ref/binary.html
  [range]: http://docs.python.org/2/tutorial/controlflow.html#the-range-function
  [expresiones regulares]: http://docs.python.org/2/library/re.html
  [Contar frecuencias de palabras con Python]: /lecciones/contar-frecuencias
  [time out]: http://www.checkupdown.com/status/E408.html
  [Programación básica en Python]: /lecciones/introduccion-e-instalacion
  [try / except]: http://docs.python.org/tutorial/errors.html
  [errores y excepciones]: http://docs.python.org.ar/tutorial/2/errors.html
  [aquí]: http://www.wordreference.com/es/translation.asp?tranword=nigger
