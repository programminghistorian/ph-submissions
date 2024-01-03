---
title: Web Scraping utilizando 'Selenium'
slug: web-scraping-utilizando-selenium
layout: lesson
collection: lessons
date: 2023-07-10
authors:
- Jose Hernández Pérez
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/567
difficulty: 
activity: acquiring
topics: [web-scraping]
abstract: En esta lección aprenderás a utilizar la herramienta WebDriver que es parte de Selenium para extraer datos de una página web.
avatar_alt:
doi: XX.XXXXX/phen0000
---
{% include toc.html %}

## Introduccion y Objetivos

En esta leccion aprenderemos a implementar el paquete de Python Selenium para automatizar nuestro acceso a páginas web y la extraccion de datos. Al final de esta lección usted va a poder:

- Utilizar la función de WebDriver del paquete Selenium
- Interactuar con una página web de una manera automatizada
- Exportar los datos adquiridos para futuro uso en su analisis en formato CSV (Comma Separated Values; Valores Separados por Comas) -  el cual es el formato 'default' de Microsoft Excel.

Para facilitar nuestro aprendizaje estaremos haciendo una mini-investigacion para identificar las areas deinovacion en el mundo agricola hispanohablante hoy. Para hacer esto qsuieramos [poder analizar un resumen de nuevas patentes que estan ocuriendo en ese campop para ver si podemos obsrvar cambio sociales que esten llevando a un alza en inovacion en distintas areas de Latinoamerica. Pero antes de llegar a esta parte de la investigacio necesitamos allaos datos , en este caseo las desciripciones de las uevas patentes en el mundo agricola.

Por esto estaremos usando la página [Latipat](https://lp.espacenet.com/?locale=es_LP) la cual es una colección de patentes a través de los países iberoamericanos. En esta página someteremos una búsqueda para patentes que tengan que ver con la industria agrícola y vamos a extraer los títulos y resúmenes de las primeras 10 patentes de la búsqueda a un documento CSV para futuro uso.

Asi mismo como usamos el raspado web para adquirir estos datos hay muchos otros casos de bases de datos en las cuales la informacion no esta accesible para bajar pero nosotros la necesitamos en nuestras investigaciones. Por ejempo si quisieramos datos electorales de una jusridiccion, los comentarios en una red social/publicacion digital/foro digital, o incluso los metadatos de obras de una coleccion literaria. Estas son simplemente algunas de las muchas aplicaciones que usted podria explorar con el raspado Web.


## Pre-requisitos

Para utilizar esta lección no se necesita conocimiento extensivo en el lenguaje de programación Python, pero se recomienda que el lector tenga alguna experiencia en el lenguaje. Un conocimiento de la estructura e implementación básica de Python, le permitirá al usuario editar fácilmente el código de ejemplo en esta lección para sus futuros proyectos.

También se recomienda que el lector se familiarice con XPath que es la forma de navegar documentos HTML en páginas web para encontrar los elementos deseados para la extracción de datos.

Se recomienda que usted se familiarize con el contenido de las siguientes lecciones si no ha trabajado con Python y/o HTML antes:
- [Introduccion a Python e Instalacion](https://programminghistorian.org/es/lecciones/introduccion-e-instalacion)
- [Instalar modulos de Python con pip](https://programminghistorian.org/es/lecciones/instalar-modulos-python-pip)
- [Para entender paginas web y HTML](https://programminghistorian.org/es/lecciones/ver-archivos-html)

## ¿Que es Web-Scraping o el raspado web?

Cuando hablamos del raspado web nos referimos a la extracción de datos del Internet. Usualmente esta extracción es automatizada y resulta en una colección de datos con toda la información extraída organizada de alguna manera coherente. En nuestro mundo digital hay múltiples herramientas que se dedican a facilitar el raspado web que suelen automatizar todo el proceso desde acceder a la página deseada hasta copiar la información a una base de datos local. Una de estas herramientas que automatiza todo el proceso de principio a fin es Selenium.

## Selenium: una introducción

Selenium es una colección de herramientas para automatizar navegadores web. Dentro de esta amplia definición, Selenium ofrece apoyo para múltiples navegadores web y lenguajes de programación. Debido a la facilidad de aprendizaje, una de sus implementaciones más famosas es la biblioteca WebDriver en Python la cual permite al usuario automatizar el acceso a una página y navegarla a través de código y no una interfaz. Una interfaz es la manera usual de interactuar con una página web utilizando su cursor y el teclado.

Es importante aclarar que para muchos proyectos no se necesita usar Selenium ya que existen herramientas más fáciles para extraer data. Por ejemplo muchos sitios web hoy ofrecen la forma de descargar su data en distintos formatos y muchos de los que no tiene este acceso fácil permite el uso de API (Application Programming Interface) la cual muchas veces facilita el acceso a data.

Pero si usted se encuentra con un proyecto que necesita datos de una página que no ofrece un API o la descarga fácil, Selenium y otras herramientas de raspado web le permitirán continuar y cumplir sus metas.

## Instalación de Selenium según tu browser

Aunque es una gran herramienta, la instalación de __Selenium__ va a depender del browser que usted utilice, ya sea Chrome, Firefox, Edge, Internet Explorer, o Safari. Por lo tanto esta sección va a discutir los puntos comunes de la instalación e indicará cuando sea necesario hacer variaciones para cada browser. Es importante notar que estas variaciones solo occuren en la instalación ya que el resto del codígo es identicó en todas las implementaciones. 

### Instalacion en Python

Antes de hacer cambios dependiendo del browser que seleccione lo primero que debe hacer es es instalar __Selenium__ en su ambiente de Python que usualmente se puede hacer con la siguiente línea en el terminal:

```
pip install selenium
```

Para nuestro tutorial también es necesario que se instale el paquete `csv`:

```
pip install csv
```

Después de esas instalaciones la forma de usar estos paquetes en su documento de Python es:

```
from selenium import webdriver
import csv
```

En adición a estas dos líneas __Selenium__ tiene muchos sub-paquetes que se utilizan en su implementación por lo que se recomienda que estas líneas también se corran al principio del documento para tener acceso a la funcionalidad básica completa de Selenium:

```
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait 
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support import expected_conditions as EC
```

Todas estas no son usadas por el tutorial pero le permite la mayor flexibilidad en sus proyectos iniciales. Es importante saber que estamos usando las herramientas para usar Selenium con el browser Chrome y estas líneas cambiaran dependiendo del browser que utilice.

### Instalación del webdriver

Una vez usted seleccione que buscador va a utilizar y usted alla instalado el paquete __Selenium__ en Python, tiene que descargar el driver específico (programa que inicializa la búsqueda automatizada) a ese buscador. Por ejemplo, para Chrome el driver especifico se conoce como Chromedriver y se descarga [aquí](https://chromedriver.chromium.org/downloads).

Para otra plataforma como Firefox se conoce como el geckodriver y se descarga [aquí](https://github.com/mozilla/geckodriver/releases).

Todos los webdriver que funcionan con Selenium para las demás plataformas se encuetran en la siguiente [página](https://www.selenium.dev/documentation/webdriver/drivers/). Por favor mantenga en mente que la versión de su webdriver debe coincidir con la versión de su buscador, ya que estas cambian con frecuencia!!

Después de seleccionar su browser y descargar el driver específico tiene que inicializar el driver en su codigo de Python. Si su código y el programa descargado se encuentran en el mismo folder en su sistema la siguiente línea es suficiente:

Chrome:
```
driver = webdriver.Chrome()
```

Firefox: 
```
driver = webdriver.Firefox()
```

Pero se __recomienda fuertemente__ que se detalle el camino completo de donde se encuentra el documento. Por ejemplo: 

Chrome:
```
driver = webdriver.Chrome('/Users/Pepito/Documents/chromedriverfolder/chromedriver')
```

Firefox: 
```
driver = webdriver.Firefox('/Users/Pepito/Documents/geckodriverfolder/geckodriver')
```

¡¡Una vez esta línea corra, _Felicidades!!_ Usted ha inicializado una instancia automatizada para acceder a una página web y está listo para empezar su raspado web.

## Acceso a la página web

Hasta ahora su código en su documento de Python se supone que se vea asi:

```
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait 
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support import expected_conditions as EC
import csv

#Iniciacion del driver- por favor recuerde incluir el nombre del programa final y no solamente el ultimo folder!

driver = webdriver.Chrome('/Users/joseh/Downloads/chromedriverfolder/chromedriver')

```
<div class="alert alert-info">
Reiteramos que nuestro ejemplo solamente utilizara Chrome, pero fácilmente puede hacer lo mismo con los demás browsers.
</div>

Ahora que tenemos el `driver` inicializado siempre que queramos interactuar con el buscador con la pagina web vamos a empezar con el comando `driver.`. Este comando permite acceso a todos los métodos que tiene el driver de Selenium; desde interactuar con elementos específicos de la página hasta cerrar nuestro buscador. Por esta razon todas las instrucciones que siguen, excepto las de procesamiento de data, usan `driver.` antes del método. Veamos la primera `driver.get` !

Esta nueva línea le ordena al `driver` a abrir una página especifica, en este caso Latipat, que usa el siguiente URL [https://lp.espacenet.com/?locale=es_LP](https://lp.espacenet.com/?locale=es_LP):

```
driver.get('https://lp.espacenet.com/?locale=es_LP')
```

Una vez se corra este código el driver abre la página web automáticamente, pero todavía no tiene instrucciones de como interactuar con ella.


## Navegación en la Página web

Al abrir nuestra página web, nuestras próximas acciones son casi infinitas ya que podemos hacer todo lo que haríamos normalmente en una página: hacer click en distintos botones, usar la barra de búsqueda, cerrar la página, etc. 

Para el propósito del taller ahora usaremos el buscador para hacer una búsqueda de las patentes que nos interesan en este caso las que tengan que ver con la industria agrícola llenando el buscador con la palabra 'agrícola'.

Para llegar a someter la palabra al buscador primero lo tenemos que encontrar y aqui es donde nos resulta útil saber que estas páginas estan organizadas utilizando HTML y por lo tanto tienen una estructura regular y facil de leer. 

### Buscando un elemento

Si usa su clic derecho encima del elemento de interés en este caso el buscador le debe salir la opción de **Inspect** (inspeccionar). Si le da clic a esta opción le va a salir un panel usualmente en su mano derecha del Código HTML de la página en cuestión. Este proceso suele variar dependiendo de su buscador pero esta estandarizado en los buscadores prominentes como Chrome, Firefox, y Edge.

{% include figure.html filename="es-or-web-scraping-utilizando-selenium-01.png" alt="Enseñando el panel que aparece al presionar el clicl-derecho en el elemento de interés " caption="Figura 1. Caption text to display" %}

Panel de inspección:

{% include figure.html filename="es-or-web-scraping-utilizando-selenium-02.png" alt="Enseñando el panel de inspeccion que aparece cuando se le da clic a la opcion de Inspect/inspeccionar en el panel que aparece en la imagen anterior" caption="Figura 2. Caption text to display" %}

Aquí usted puede notar que cada elemento en HTML suele tener unos atributos que nos permiten identificar y distinguir distintos elementos fácilmente. Por ejemplo, alugnos usan 'id' y otros usan, como en este caso, 'name'. Por lo tanto, sabemos que el buscador es el único elemento con el nombre 'query' lo cual lo hace facil de buscar con la siguiente línea: 

```
search_box = driver.find_element(By.NAME,'query')
```

En esta línea definimos una variable llamada `search_box` la cual le dice al driver que busque el elemento `find_element` con el nombre 'query' `By.NAME, 'query'`.

Es importante notar que esta no es la unica manera de encontrar un elemento. Por ejemplo el mismo elemento de la caja del search se puede buscar por su camino de XPath o su camino largo a través de la estructura de HTML con la siguiente linea:

```
search_box= driver.find_element(By.XPATH,'/html/body/div/div[6]/div/div/form/div[1]/span[3]/textarea')
```

Para encontrar este XPath completo va a copiar el elemento en el mismo panel de la derecha que abrimos cuando buscamos el nombre del atributo 'query'.

Este método se explicara en detalle más adelante cuando se use para la busqueda de datos específicos pero se recomienda que si lo va a usar defina el XPath como una variable para evitar errores de transcripción.

```
xpath1 = ''/html/body/div/div[6]/div/div/form/div[1]/span[3]/textarea'
search_box= driver.find_element(By.XPATH, xpath1)
```

### Interactuando con el elemento 

Ya que encontramos la caja de búsqueda ahora la podemos utilizar usando las siguientes líneas: 

```
#Termino para la búsqueda
search_box.send_keys('agricultura')

#Sometemos búsqueda
search_box.send_keys(Keys.RETURN)
```

Ahora su código completo se debe ver así:

```
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait 
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support import expected_conditions as EC
import csv

#Iniciación del driver- por favor recuerde incluir el nombre del programa final y no solamente el ultimo folder!

driver = webdriver.Chrome('/Users/joseh/Downloads/chromedriverfolder/chromedriver')

driver.get('https://lp.espacenet.com/?locale=es_LP')

search_box = driver.find_element(By.NAME,'query')

#Termino para la busqueda
search_box.send_keys('agricultura')

#Sometemos busqueda
search_box.send_keys(Keys.RETURN)
```

Y en vez de la página principal de Latipat debe estar viendo esta (sus resultados pueden ser distintos dependiendo de la fecha en la que corra esta programa):

{% include figure.html filename="es-or-web-scraping-utilizando-selenium-03.png" alt="Lista de resultados en LATIPAT una vez se ejecuta la busqueda" caption="Figura 3. Caption text to display" %}

### Integrando loops con búsqueda de elementos

Las instrucciones anteriores funcionan perfectamente si tenemos un solo elemento de interés como la barra de búsqueda. Pero después de haber buscado los elementos ahora queremos extraer datos que se repite en múltiples instancias.

Ahora vamos a extraer los títulos y los resúmenes de cada patente. Para hacer esto tenemos que hacer el siguiente proceso en tres pasos: 

 - Paso 1: Acceder a la primera patente

 - Paso 2: Copiar la informacion al CSV

 - Paso 3: Movernos a la siguiente patente y repetir el paso 2

#### La primera patente

Para acceder a la primera patente tenemos que verificar su XPath o camino y asignarle una variable. Esto lo va a hacer con el mismo panel que utilizamos para encontrar el identificador para la barra de búsqueda, pero ahora copiara el XPath del elemento directamente.

{% include figure.html filename="es-or-web-scraping-utilizando-selenium-04.png" alt="Demostrabdo como copiar el XPATh de un elemento" caption="Figura 4. Caption text to display" %}

Para realizar esta búsqueda asignamos este XPath a una variable y después buscamos el elemento con el driver. Finalmente le damos click al link de la patente para entrar a la próxima página, la cual se puede ver en la imagen que sigue:

```
xpath1='//*[@id="publicationId1"]'
publicacion1= driver.find_element(By.XPATH,xpath1)
driver.execute_script("arguments[0].click();", publicacion1)
driver.implicitly_wait(10)
```

Como puede ver aquí tenemos dos métodos nuevos:
 - El primero es `.execute_script()` el cual le dice al driver que le de click al botón apropiado.
 - El segundo es `.implictly_wait()` el cual le dice al driver que espere 10 segundos o menos en lo que sube la pagina buscada. Este metodo se usa para websites lentos o para asegurarse que los elementos están presentes en la página antes de extraer cualquier infromacion.

Con este metodo le damos click a el elemento `piblicacion1` con el XPath apropriado `xpath1`.

#### Copiando la información al CSV

Ahora identificaremos los elementos que queremos extraer de cada página de la patente (el `título` y el `resumen`):

{% include figure.html filename="es-or-web-scraping-utilizando-selenium-05.png" alt="Pagina de la patente individual y su descripcion" caption="Figura 5. Caption text to display" %}

Al identificar los elementos que queremos, tenemos que copiar sus XPath en la misma manera que lo hicimos para el botón de la primera patente.

{% include figure.html filename="es-or-web-scraping-utilizando-selenium-06.png" alt="Segunda deostracion de la copia del XPATH" caption="Figura 6. Caption text to display" %}

Los caminos se pueden identificar de la siguiente manera: 

```
    xpathres='//*[@id="body"]/div[2]/p[1]'
    xpathtitulo='//*[@id="pagebody"]/h3'
```

y para extraer su texto vamos a utilizar el método de `get_attribute`:

```
    titulo= driver.find_element(By.XPATH,xpathtitulo).get_attribute('innerText')
    resumen=driver.find_element(By.XPATH,xpathres).get_attribute('innerText')
```

Despues de tener su texto extraído podemos usar las funciones de la biblioteca `csv` para escribir nuestra data al nuevo documento: 

```
    data=[titulo,resumen]

    with open('output.csv', 'a', encoding='UTF8', newline='') as document:
        writer= csv.writer(document)
        writer.writerow(data)
```

Preste atención que el documento se abrió con el argumento `a` que significa 'append' (añadir). Si utiliza el argumento `w` cada línea nueva va a borrar la entrada anterior.

#### Pasando a la siguiente patente

Para darle clic al botón vamos a usar otra función de Selenium que se llama `WebDriverWait`. Esta función le dice al driver que espere hasta que una acción ocurra. En nuestro caso estamos esperando (un máximo de 10 segundos) hasta que el botón _siguiente_ aparezca y le vamos a dar clic con el método `.click` en vez de la linea de código que usamos antes. Esta línea se ve de la siguiente manera para nuestro boton de _siguiente_: 

```
WebDriverWait(driver,10).until(EC.element_to_be_clickable((By.ID,'nextDocumentLink'))).click()
```

Aquí podemos observar que buscamos el elemento usando su id unico que se puede verificar en el panel de la derecha.

#### Loop final

Uniendo el acceso a la primera patente (que nada más se ejecutará una vez), la extracción de datos y la transferencia a la próxima patente podemos ahora unirlo todo en un `for` loop en Python. Este loop nos permitirá repetir las acciones la cantidad de veces que queramos para añadir todos los datos extraidos en un solo documento.

```
xpath1='//*[@id="publicationId1"]'
publicacion1= driver.find_element(By.XPATH,xpath1)
driver.execute_script("arguments[0].click();", publicacion1)
driver.implicitly_wait(10)

for i in range(1,16):

    xpathres='//*[@id="body"]/div[2]/p[1]'
    xpathtitulo='//*[@id="pagebody"]/h3'
    titulo= driver.find_element(By.XPATH,xpathtitulo).get_attribute('innerText')
    resumen=driver.find_element(By.XPATH,xpathres).get_attribute('innerText')
   
    data=[titulo,resumen]

    WebDriverWait(driver,10).until(EC.element_to_be_clickable((By.ID,'nextDocumentLink'))).click()

    with open('output.csv', 'a', encoding='UTF8', newline='') as f:
        writer= csv.writer(f)
        writer.writerow(data)
```

Si usted no sabe cómo funciona el loop `for` en Python por favor lea esta [página web](https://www.freecodecamp.org/espanol/news/bucle-for-en-python-ejemplo-de-for-i-en-range/).

## Codigo final 

Ya hemos cubierto todos los elementos por separado así que nuestro código final se vería de la siguiente manera:

```
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait 
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support import expected_conditions as EC
import csv

#Iniciación del driver- por favor recuerde incluir el nombre del programa final y no solamente el último folder!

driver = webdriver.Chrome('/Users/joseh/Downloads/chromedriverfolder/chromedriver')

driver.get('https://lp.espacenet.com/?locale=es_LP')

search_box = driver.find_element(By.NAME,'query')

#Termino para la búsqueda
search_box.send_keys('agricultura')

#Sometemos búsqueda
search_box.send_keys(Keys.RETURN)

# Añadimos una pausa para que el sistema tenga tiempo a completar la busqueda
driver.implicitly_wait(10)

xpath1='//*[@id="publicationId1"]'
publicacion1= driver.find_element(By.XPATH,xpath1)
driver.execute_script("arguments[0].click();", publicacion1)
driver.implicitly_wait(10)

for i in range(1,16):

    xpathres='//*[@id="body"]/div[2]/p[1]'
    xpathtitulo='//*[@id="pagebody"]/h3'
    titulo= driver.find_element(By.XPATH,xpathtitulo).get_attribute('innerText')
    resumen=driver.find_element(By.XPATH,xpathres).get_attribute('innerText')
   
    data=[titulo,resumen]

    WebDriverWait(driver,10).until(EC.element_to_be_clickable((By.ID,'nextDocumentLink'))).click()

    with open('output.csv', 'a', encoding='UTF8', newline='') as f:
        writer= csv.writer(f)
        writer.writerow(data)

driver.close()
```

La última línea del programa cierra el driver para no dejar el buscador automático corriendo. 

Al final, este programa debe producir un documento `.csv` con los primeros 8 títulos y resúmenes de las patentes. Para aumentar la cantidad de patentes raspadas simplemente cambie el ultimo numero del la funcion range: 

```
range(1,16)
```

<div class="alert alert-warning">
 En este ejemplo, entiendase esta pagina web, existe un error de doble clic en el cursor de siguiente y por lo tanto repite las entradas dos veces. Esta repetición se puede limpiar después con herramientas como Excel/OpenRefine o utilizando Python más complicado como un `if` para comparar las entradas y borrar las repetidas. Este error no esta presente en otras paginas web.
</div>

El CSV abre como un documento normal en Microsoft Excel, LibreOffice o en editores de texto.

## Conclusión

Con esta lección hemos cubierto los elementos básicos de Selenium en Python desde como instalarlo hasta como extraer datos con su ayuda. Para continuar u desarrollo en Selenium por favor consulte su documentación [aquí](https://www.selenium.dev/documentation/) y [aquí](https://selenium-python.readthedocs.io/installation.html). ¡Espero que este conocimiento le sirva de base para sus proyectos investigativos!
