---
title: Descarga aplicada de archivos con Wget
layout: lesson
date: 2013-09-13
authors:
- Kellen Kurschinski
reviewers:
- Nick Ruest
- Konrad Lawson
editors:
- Ian Milligan
translation_date: 2018-06-21
translator:
- Leonardo Bareño
translation-editor:
- Maria José Afanador-Llach
translation-reviewer:
- 
- 
difficulty: 2
review-ticket: 
activity: acquiring
topics: [web-scraping]
abstract: "Ahora que ya has aprendido cómo es que Wget puede ser usado para duplicar o descargar archivos específicos desde sitios web por medio de la línea de comandos, es hora de expandir tus habilidades de recolección web mediante algunas lecciones más, enfocadas en otros usos de la función de recuperación recursiva de Wget."
previous: 
original: applied-archival-downloading-with-wget
---

{% include toc.html %}





Antecedentes y objetivos de la lección
--------------------------------------

Ahora que ya has aprendido cómo es que Wget puede ser usado para
duplicar o descargar archivos específicos desde sitios web como
[ActiveHistory.ca][] por medio de la línea de comandos, es hora de 
expandir tus habilidades de recolección web mediante algunas lecciones
más, enfocadas en otros usos de la función de recuperación recursiva
de Wget. El siguiente tutorial proporciona tres ejemplos de cómo puede
ser usado Wget para descargar colecciones grandes de documentos desde
páginas web archivísticas con la ayuda del lenguaje de programación 
Python. Te enseñará cómo subdividir y generar una lista de URLs usando
un script sencillo en Python y también te dará a conocer algunas otras
características útiles de Wget. Funciones similares a las que son
demostradas en esta lección se pueden realizar usando [curl][], un
software de fuente abierta capaz de llevar a cabo descargas
automatizadas desde la línea de comandos. No obstante, esta lección
se enfocará en Wget y en fortalecer destrezas en Python. 

Las páginas web archivísticas ofrecen una gran cantidad de recursos a
los historiadores, pero su elevada accesibilidad no siempre se refleja
en utilidad incrementada. Dicho de otra forma, mientras que a menudo las
colecciones en línea permiten a los historiadores acceder a materiales
que hasta ahora han estado indisponibles o son de alto costo, también
pueden verse limitadas por la manera en la que el contenido está siendo
presentado y organizado. Un ejemplo de ello es la [Base de datos de reportes
anuales sobre asuntos indígenas de Canadá][] alojado en la página web de la 
Library and Archives Canada [LAC]. Supongamos que deseas descargar un
reporte entero, o reportes que abarcan varias décadas. El sistema actual
le permite a un usuario la opción de leer una versión en archivo plano de
cada pagina, o dar clic en el enlace de "Ver una página escaneada del
reporte original", el cual conducirá al usuario a una página que contiene
el visor de imágenes incorporado de LAC. Esto te permite ver el documento
original, pero es incómodo porque requiere que te desplaces por cada
página individual. Por otra parte, si necesitas este documento para
visualizarlo fuera de línea, la única opción es *dar clic derecho* ->
*Guardar como* a cada imagen y almacenarlo en un directorio de tu
computador. Si deseas consultar reportes anuales por un periodo de varias
décadas, puedes apreciar con facilidad las limitaciones de los actuales
medios de presentación. Esta lección te permitirá superar tales
obstáculos.

Recuperación recursiva y URLs secuenciales: un ejemplo en Library and Archives Canada
-------------------------------------------------------------------------------------

Empecemos. El primer paso tiene que ver con construir un script para
generar URLs secuenciales usando los *bucles For* de Python. Primero,
necesitarás identificar la URL inicial en la serie de documentos que deseas
descargar. Debido a su tamaño pequeño, se estará utilizando como ejemplo el
diario de guerra del [Hospital General Canadiense No. 14][]. El diario entero
tiene un total de 80 páginas. La URL de la página 1 es
<http://data2.archives.ca/e/e061/e001518029.jpg>, y la de la página 80 es
<http://data2.archives.ca/e/e061/e001518109.jpg>. Observa que están en
orden secuencial. Deseamos descargar las imágenes .jpeg de *todas* las
páginas del diario. Para hacer esto, necesitamos escribir un script que
genere las URLs de todas las páginas del diario, desde la primera hasta
la última.

Abre el editor de texto de tu preferencia (por ejemplo, Komodo Edit) e
ingresa el codigo que se encuentra abajo. En donde dice 'integer1'
reemplázalo por '8029', y en donde dice 'integer2' reemplázalo por '8110'.
El bucle For generará una lista de números entre '8029' y '8110', pero no
imprimirá el último número en el rango (es decir, 8110). Para poder
descargar todas las 80 páginas del diario hemos sumado 1 al valor máximo
del rango (8109) porque es en 8110 en donde el bucle For se
detendrá. Esto aplica para cualquier secuencia de números que vayas a
generar con la sentencia de control For. Adicionalmente, el script no
se ejecutará apropiadamente si son colocados [ceros a la izquierda][]
en los dígitos de los rangos de enteros, de modo que tienes que
eliminarlos del rango y colocarlos en la cadena donde está la URL
inicial. En este ejemplo he subdividido la URL para que únicamente los
cuatro últimos dígitos de la cadena sean manipulados por el bucle For.


``` python
#URL-Generator.py

urls = '';
f=open('urls.txt','w')
for x in range('integer1', 'integer2'):
    urls = 'http://data2.collectionscanada.ca/e/e061/e00151%d.jpg\n' % (x)
    f.write(urls)
f.close
```

Reemplaza 'integer1' e 'integer2' con los valores inferior y superior del
rango de URLs que deseas descargar. El resultado final será:

``` python
#URL-Generator.py

urls = '';
f=open('urls.txt','w')
for x in range(8029, 8110):
    urls = 'http://data2.collectionscanada.ca/e/e061/e00151%d.jpg\n' % (x)
    f.write(urls)
f.close
```

Guarda el programa como un archivo .py, y luego ejecuta el script.


El bucle For generará automáticamente una lista secuencial de URLs
dentro del rango de 2 enteros que hayas especificado en los parámetros
del bucle, y los almacenará en un archivo .txt de tu computador. 
Los caracteres `%d` te permitirán colocar cada número secuencial generado
por el bucle For en una posición exacta dentro de la cadena. Se agrega
`\n` (caracter de salto de línea) al final de la cadena para separar una
URL de otra, permitiendo que Wget lea correctamente el archivo .txt.

No tienes que colocar todos los dígitos de la URL para especificar el
rango - sólo aquellos que estés interesado en modificar. Por este motivo
es que se tomaron únicamente los 4 últimos dígitos de la cadena, y la
porción de `00151` fue dejada intacta.

Antes de ir a la siguiente etapa del proceso de descarga, asegúrate de
que hayas creado un directorio en donde desees guardar tus archivos;
y, por facilidad en el uso, ubícalo en el directorio principal en donde
conserves tus documentos. Tanto para usuarios de Mac como de Windows,
normalmente será el directorio 'Documentos'. Para el presente ejemplo,
nuestro directorio se llamará 'LAC'. Debes mover el archivo urls.txt que
fue creado por el script de Python hacia dicho directorio. A fin de
ahorrar tiempo en futuras descargas, es recomendable ejecutar el programa
desde el mismo directorio en el que planeas que los archivos queden
descargados. Esto se puede hacer guardando el archivo URL-Generator.py
en tu directorio 'LAC'.

Para usuarios de Mac, bajo tu lista de aplicaciones selecciona
*Utilities -\> Terminal*. Para usuarios de Windows, necesitarás abrir
un utilitario de línea de comandos.

Una vez tengas abierta una ventana de consola, necesitas 'entrar' al
directorio donde quieres guardar tus archivos .jpeg descargados. Escribe:


``` bash
cd ~/Documents
```

y pulsa Enter. Luego escribe:

``` bash
cd 'LAC'
```

y presiona Enter de nuevo. Ahora estás ubicado en el directorio seleccionado
y estás listo para empezar la descarga.

Basado en lo que aprendiste en
[la lección anterior de Wget](../lessons/(PENDIENTE)automated-downloading-with-wget),
ingresa lo siguiente en la consola (observa que puedes colocar cualquier valor 
para tu 'tasa límite', ¡pero sé un buen usuario de la red y mantenlo por 
debajo de 200kb/s!):

``` bash
wget -i urls.txt -r --no-parent -nd -w 2 --limit-rate=100k
```
*(Nota: al colocar '-nd' en la línea de comando, Wget recreará la misma 
estructura de directorios de la página web, haciendo que tus archivos sean 
más fáciles de acceder y organizar).*

En pocos momentos, deberás tener todas las 80 páginas del diario de guerra
descargadas en el directorio. Podrás copiarlas o moverlas a cualquier otro
directorio de tu preferencia.

Segundo ejemplo: Archivos Nacionales de Australia
-------------------------------------------------

{% include alert.html text='Posterior a la publicación inicial de esta lección, los Archivos Nacionales de Australia cambiaron sus patrones de URL, con lo cual quedaron inservibles los enlaces proporcionados en el presente tutorial. Hemos preservado el texto original para propósitos de referencia; no obstante, es posible que desees [pasar a la siguiente sección](#recursive-retrieval-and-wgets-accept--a-function).' %}

Vamos a intentar un ejemplo más utilizando este método de recuperación
recursiva. Esta lección puede ser aplicada en general a una buena
cantidad de archivos, ¡no solo a los canadienses!

Supongamos que quieres descargar un manuscrito de los Archivos Nacionales
de Australia, el cual tiene un visor en línea con muchos más elementos
estéticos que el de LAC, pero que todavía se encuentra limitados para
mostrar una imagen a la vez. Usaremos el "Cuaderno y lista de amotinados,
1789" de William Bligh, que proporciona un reporte de los motines a
bordo del HMS *Bounty*. [En la página del visor][] observarás que hay
131 'ítems' (páginas) en el cuaderno. Esto es algo engañoso. Haz clic
en la primera imagen en miniatura en la parte superior derecha para ver
la página entera. Ahora haz *clic derecho -\> ver imagen*. La URL debe
ser '<http://nla.gov.au/nla.ms-ms5393-1-s1-v.jpg>'. Si navegas a través
de las miniaturas, la última es 'Part 127', que está ubicada en
'<http://nla.gov.au/nla.ms-ms5393-1-s127-v.jpg>'. La discrepancia entre
el rango de las URLs y el número total de archivos significa que has
omitido una o dos páginas en la descarga automática - en este caso hay
unas pocas URLs que incluyen una letra en el nombre del .jpeg
(por ejemplo, 's126a.v.jpg' o 's126b.v.jpg'). Esto ocurrirá de vez en
cuando a la hora de descargar, por lo que no hay que sorprenderse si
hace falta una página o dos durante una descarga automatizada.

Observa que una solución alternativa podría ser el uso de expresiones
regulares para elaborar búsquedas más complicadas, si esto es lo
apropiado (para más detalles ver la lección [Entender las expresiones regulares](/lessons/understanding-regular-expressions) 
).

Vamos a ejecutar el script y el comando Wget una vez más:

``` python
#Bligh.py

urls = '';
f=open('urls.txt','w')
for x in range(1, 128):
    urls = 'http://www.nla.gov.au/apps/cdview/?pi=nla.ms-ms5393-1-s%d-v.jpg\n' % (x)
    f.write(urls)
f.close
```

Y:

``` bash
wget -i urls.txt -r --no-parent -nd -w 2 --limit-rate=100k
```

Ahora tienes una copia (casi) completa del cuaderno de William Bligh.
Las páginas faltantes pueden ser descargadas manualmente por medio de
*clic derecho -\> guardar imagen como*.

Recuperación recursiva y la función 'Accept' (-A) de Wget
---------------------------------------------------------

En ocasiones, la descarga automatizada requiere trabajar alrededor de
barreras de codificación. Es común encontrar URLs que contienen conjuntos
múltiples de ceros a la izquierda, o URLs que pueden ser demasiado
complejas para alguien con antecedentes limitados en programación como
para poder diseñar un script en Python. Afortunadamente, Wget tiene una
función pre-incorporada llamada 'Accept' (expresada como '-A') que te
permite definir qué tipo de archivos te gustaría descargar de una página
web o directorio abierto específico.

Para el presente ejemplo usaremos una de las colecciones disponibles
más grandes en la página web de la Biblioteca del Congreso: los
Documentos de Thomas Jefferson. Al igual que con LAC, el visor para estos
archivos es anticuado y requiere que navegues página por página. 
Estaremos descargando una selección de la [Serie 1: Correspondencia
general. 1651-1827][]. Abre el enlace y luego haz clic en la imagen
(el visor .jpeg se ve muy familiar, cierto?) La URL de la imagen también
tiene un patrón similar al del diario de guerra de LAC que descargamos
previamente en esta lección, pero los ceros a la izquierda complican
las cosas y no nos permiten generar con facilidad las URLs con el primer
script que habíamos usado. No obstante, hay una alternativa. Haz clic
en este enlace:

<http://memory.loc.gov/master/mss/mtj/mtj1/001/0000/>

La página que acabas de abrir es un subdirectorio de la página web que
lista los archivos .jpeg de una selección de los Documentos de
Jefferson. Esto significa que podemos usar la función '-A' de Wget para
descargar todas las imágenes .jpeg (100 de ellas) listadas en esta
página. Pero supongamos que quieres ir más allá y descargar el rango
entero de archivos de este conjunto de fechas en la Serie 1 - es decir,
1487 imágenes. Para una tarea como esta, donde hay relativamente pocas
URLs no necesitas realmente escribir un script (aunque podrías utilizar
mi ejemplo final, que abordará el problema de los ceros a la izquierda).
En vez de ello, simplemente se manipularán las URLs en un archivo .txt
de la siguiente manera:

<http://memory.loc.gov/master/mss/mtj/mtj1/001/0000/>

<http://memory.loc.gov/master/mss/mtj/mtj1/001/0100/>

<http://memory.loc.gov/master/mss/mtj/mtj1/001/0200/>

... y así mismo hasta 

<http://memory.loc.gov/master/mss/mtj/mtj1/001/1400>

Este es el último subdirectorio en la página de la Biblioteca del
Congreso para estas fechas en la Serie 1. La última URL contiene las
imágenes de 1400 a 1487.

Tu archivo .txt completo debe tener un total de 15 URLs. Antes de hacer
algo más, guarda el archivo como 'Jefferson.txt' en el directorio que
has colocado para almacenar tus archivos descargados.

Ahora, ejecuta el siguiente comando de Wget:

``` bash
wget –i Jefferson.txt –r --no-parent -nd –w 2 –A .jpg, .jpeg --limit-rate=100k
```

¡Listo! Luego de esperar un poco, tendrás 1487 páginas de documentos
presidenciales al alcance de tu mano.

Recuperación recursiva más complicada: Script en Python para ceros a la izquierda
---------------------------------------------------------------------------------

La Biblioteca del Congreso, como muchos repositorios en línea, organiza
sus colecciones usando un sistema de numeración que agrega ceros a la
izquierda dentro de cada URL. Si el directorio está abierto, la función
-A de Wget es una buena forma de manejar esto sin tener que elaborar más
código. ¿Pero qué hacer si el directorio es cerrado y sólo tienes acceso
a una imagen a la vez? Este último ejemplo mostrará cómo usar un script
en Python para agregar dígitos con ceros a la izquierda en una lista
de URLs. Para este ejemplo usaremos la [Colección de Carteles Médicos 
Históricos][], disponibles en la Biblioteca Médica Harvey
Cushing/Jack Hay Whitney (Yale University).

Primero, necesitaremos identificar las URLs del primer y del último
archivo que queremos descargar. También necesitaremos las versiones
en alta resolución de cada cartel. Para localizar la URL de la imagen
en alta resolución haz clic en la primera miniatura (arriba a la
izquierda), luego busca abajo del cartel un enlace que diga 'Click
HERE for Full Image'. Si sigues el enlace, aparecerá una imagen en alta
resolución con una URL compleja. Como en el ejemplo de los archivos
australianos, para obtener la URL simplificada debes hacer *clic derecho
-\> ver imagen* usando el navegador web. La URL del primer cartel debe
ser:

<http://cushing.med.yale.edu/images/mdposter/full/poster0001.jpg>

Siguiendo los mismos pasos para el último cartel en la galería, la URL
debería ser:

<http://cushing.med.yale.edu/images/mdposter/full/poster0637.jpg>.

El script que utilizamos para descargar desde LAC no funcionará porque
la función de rango no puede manejar ceros a la izquierda. El script
de abajo proporciona una alternativa efectiva  que ejecuta tres bucles
For diferentes y exporta las URLs a un archivo .txt en una forma casi
igual a la del script original. Este enfoque también podría funcionar
con los Documentos Jefferson, pero escogí usar la función -A a fin de
demostrar su utilidad y efectividad como alternativa menos complicada.

En este script, la URL del cartel es tratada en forma casi igual que
como las del ejemplo de LAC. La diferencia clave es que los ceros a la
izquierda son incluidos como parte de la cadena. En cada bucle, el
número de ceros en la cadena disminuye a medida que los dígitos del
conteo se incrementa de 1, a 2 y a 3. El script puede ser expandido o
reducido según sea necesario. En este caso, necesitamos repetir el
proceso tres veces porque nos estamos moviendo de tres ceros a la
izquierda a uno solo. A fin de asegurar que el script itere
apropiadadmente, se debe agregar un '+' a cada bucle For en el ejemplo
de abajo.

No es recomendable realizar esta descarga debido al número y tamaño de
los archivos. Este ejemplo sólo tiene por propósito mostrar cómo
construir y ejecutar el script de Python.

``` python
#Leading-Zeros.py

urls = '';
f=open('leading-zeros.txt','w')

for x in range(1,10):
    urls += 'http://cushing.med.yale.edu/images/mdposter/full/poster000%d.jpg\n' % (x)

for y in range(10,100):
    urls += 'http://cushing.med.yale.edu/images/mdposter/full/poster00%d.jpg\n' % (y)

for z in range(100,638):
    urls += 'http://cushing.med.yale.edu/images/mdposter/full/poster0%d.jpg\n' % (z)

f.write(urls)
f.close
```

Conclusión
----------

Estos tres ejemplos sólo exploran superficialmente el potencial de
Wget. Los archivos digitales organizan, almacenan y presentan su
contenido en una variedad de formas, algunas de las cuales
son más accesibles que otras. En efecto, muchos repositorios
digitales almacenan sus archivos usando URLs que deben ser 
manipuladas en formas que son diferentes a las manejadas por Wget.
Cualquiera que sea tu descarga, habrán nuevos desafíos y oportunidades.
Este tutorial te ha brindado las destrezas básicas para trabajos
futuros en depósitos digitales y, seguramente, te llevarán a realizar
tus propias pruebas en un esfuerzo de agregar nuevas herramientas
para el historiador digital. A medida que nuevos métodos para explorar
repositorios en línea estén disponibles, continuaremos actualizando
esta lección con ejemplos adicionales que muestren el poder y
potencial de Wget.

  [ActiveHistory.ca]: http://www.activehistory.ca
  [curl]: http://chronicle.com/blogs/profhacker/download-a-sequential-range-of-urls-with-curl/41055
  [Base de datos de reportes anuales sobre asuntos indígenas de Canadá]: http://www.collectionscanada.gc.ca/databases/indianaffairs/index-e.html
  [View a scanned page of original Report]: http://www.collectionscanada.gc.ca/databases/indianaffairs/001074-119.02-e.php?page_id_nbr=1
  [Hospital General Canadiense No. 14]: http://collectionscanada.gc.ca/pam_archives/index.php?fuseaction=genitem.displayItem&lang=eng&rec_nbr=2005110&rec_nbr_list=3366167,3203123,2005097,2005100,2005101,2005099,2005096,2005110,2005108,2005106
  [http://data2.archives.ca/e/e061/e001518109.jpg]: http://data2.archives.ca/e/e061/e001518029.jpg
  [ceros a la izquierda]: http://en.wikipedia.org/wiki/Leading_zero
  [En la página del visor]: http://www.nla.gov.au/apps/cdview/?pi=nla.ms-ms5393-1
  [Serie 1: Correspondencia general. 1651-1827]: http://memory.loc.gov/cgi-bin/ampage?collId=mtj1&fileName=mtj1page001.db&recNum=1&itemLink=/ammem/collections/jefferson_papers/mtjser1.html&linkText=6
  [Colección de Carteles Médicos Históricos]: http://cushing.med.yale.edu/gsdl/collect/mdposter/
