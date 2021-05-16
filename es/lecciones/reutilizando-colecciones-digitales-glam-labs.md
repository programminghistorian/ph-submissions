---
title: 
    Reutilizando colecciones digitales: GLAM Labs
collection: lessons
layout: lesson
slug: 
date: 
translation_date: 
authors:
    - Gustavo Candela
    - María Dolores Sáez
    - María Pilar Escobar
    - Manuel Marco Such
reviewers:
editors:
translator:
translation-editor:
translation-reviewer:
original: 
review-ticket: 
difficulty: 
activity: 
topics: 
abstract: 
---
 


# Reutilizando colecciones digitales: GLAM Labs

## Objetivos de la lección
Esta lección muestra cómo reutilizar colecciones digitales publicadas por instituciones de patrimonio cultural y tiene como objetivos principales los siguientes:

* Conocer qué es un Lab en el marco de una institución GLAM
* Reutilizar de forma innovadora y creativa colecciones digitales
* Enriquecer los datos a través de diferentes técnicas


## Prerrequisitos

En esta lección asumimos que tienes cierto conocimiento sobre Python. Saber otro lenguaje de programación también te será útil. Si necesitas un lugar donde empezar, recomendamos trabajar con los excelentes tutoriales sobre [Python](https://programminghistorian.org/es/lecciones/?topic=python) en *The Programming Historian en español*. También necesitarás conocimientos sobre Jupyter Notebooks y para ello te recomendamos la lección de [Jupyter Notebooks](https://programminghistorian.org/en/lessons/jupyter-notebooks). Además, será necesario tener pequeños conocimientos sobre MARCXML, Linked Open Data y SPARQL para los ejemplos de reutilización y te será útil la lección de [datos abiertos enlazados](https://programminghistorian.org/es/lecciones/introduccion-datos-abiertos-enlazados).


## Introducción

Tradicionalmente las instituciones de patrimonio de cultural conocidas como GLAM (del inglés, Galleries, Libraries, Museums and Archives) han publicado colecciones digitales que incluían todo tipo de materiales con el objetivo de facilitar el acceso a la información a la sociedad.
El avance de las tecnologías ha favorecido un nuevo contexto en el que las colecciones digitales pueden ser aplicadas en investigación por medio de diferentes métodos como visión por computador o técnicas de aprendizaje automático. Actualmente, las instituciones GLAM promueven e incentivan la reutilización de sus colecciones digitales a través de programas de colaboración directamente con investigadores pero también con empresas e instituciones académicas.

Las instituciones de patrimonio cultural han comenzado a experimentar con las colecciones digitales que tradicionalmente han puesto a disposición del público. Este nuevo contexto ha favorecido la creación de nuevos espacios en el seno de las instituciones para experimentar con las colecciones digitales de forma creativa e innovadora conocidos como Labs. Uno de los primeros Labs, y líder en este ámbito sentando las bases para el resto, corresponde al de la [Biblioteca Británica](http://labs.bl.uk) que ha sido financiado por la [Mellon Foundation](https://mellon.org/). Como resultado a dos encuentros de carácter internacional en la sede de la Biblioteca Británica y en la Biblioteca Real de Dinamarca en Copenhague, se creó la [Comunidad Internacional GLAM Labs](https://glamlabs.io) compuesta por numerosas instituciones como se muestra en la siguiente figura. 


{% include figure.html filename="map-labs.png" caption="Mapa que representa las instituciones de la comunidad GLAM Labs" %}


En septiembre de 2019, 16 personas pertenecientes a dicha comunidad se reunieron en Doha para escribir a partir de la metodología Book Sprint el libro [Open a GLAM Lab](https://glamlabs.io/books/open-a-glam-lab/) que actualmente ha sido traducido a diversos idiomas, entre ellos castellano y árabe.

A la hora de reutilizar una colección digital existen diferentes aspectos que deben ser tenidos en cuenta como por ejemplo la licencia o el tipo de material. Las instituciones han comenzado a utilizar licencias abiertas, pero en algunos casos la licencia no es evidente impidiendo su reutilización. Dependiendo del método de investigación a aplicar será necesario un tipo específico de material. Por ejemplo, si deseamos realizar renocimiento de formas necesitaremos un repositorio que se base en imágenes.

Recientemente se publicó el estudio [Collections as data](https://collectionsasdata.github.io/) que proporciona un nuevo enfoque para publicar las colecciones digitales que facilitan el procesamiento por parte de las computadoras. Por ejemplo, un investigador puede utilizar un corpus de miles de textos para identificar personas o lugares de forma automática. Las computadoras permiten la aplicación de métodos de investigación en Humanidades Digitales como text mining, visualización de datos o el uso de sistemas de información geográfica (GIS) como también procesamiento del lenguaje natural, inteligencia artificial y visión por computador. 

La combinación de las colecciones digitales proporcionadas por las instituciones GLAM junto a código y narrativa proporcionan el marco ideal para la reproducción de los resultados de investigación.
En este sentido, los Jupyter Notebooks permiten integrar los tres elementos y se han convertido en un elemento muy popular tanto en la comunidad investigadora como en la educativa. Numerosos proyectos se centran en la publicación de colecciones de notebooks como por ejemplo [GLAM Workbench](https://glam-workbench.github.io/) o [GLAM Jupyter Notebooks](http://data.cervantesvirtual.com/blog/notebooks/). Los Labs favorecen un espacio para poner de manifiesto estas nuevas tendencias para mejorar y mantener la relevancia de las instituciones de patrimonio cultural.

En esta lección se incluyen varias opciones para localizar colecciones digitales publicadas por instituciones GLAM para su reutilización. A continuación, se introducen dos ejemplos implementados como Jupyter Notebooks que muestran de forma reproducible cómo reutilizar las colecciones digitales a través de diferentes técnicas que se encuentran disponibles en [GitHub](https://github.com/hibernator11/notebook-ph). El último apartado corresponde a las conclusiones.


## Buscando colecciones digitales para su reutilización
Actualmente existen numerosos sitios web donde localizar colecciones digitales para su reutilización. Muchos de ellos corresponden al espacio Lab dentro de una institución GLAM. En otros casos, la colección digital se puede localizar en plataformas como Zenodo que permite la publicación de datasets. La siguiente tabla proporciona un resumen de instituciones GLAM donde localizar colecciones digitales con licencias abiertas para su reutilización.

| Institución   | Colección | URL |
| ------------- | ------------- | ------------- |
| Bibliotèque nationale de France | BnF API et jeux de données | http://api.bnf.fr/ | 
| Bibliothèque nationale du Luxembourg | BnL Open Data | https://data.bnl.lu/ |
| British Library | data.bl.uk | https://data.bl.uk/ | 
| Biblioteca Virtual Miguel de Cervantes | BVMC Labs | http://data.cervantesvirtual.com/blog/labs | 
| Det Kgl. Bibliotek | KB Labs | https://labs.kb.dk/ | 
| Europeana | Europeana IIIF APIs | https://pro.europeana.eu/page/iiif | 
| History Trust of South Australia | Learn section | https://history.sa.gov.au/ | 
| National Library of Netherlands | KB Lab | https://lab.kb.nl/ |
| National Library of Scotland | Data Foundry | https://data.nls.uk/ |
| Library of Congress | LC for Robots | https://labs.loc.gov/lc-for-robots/ |
| Österreichische Nationalbibliothek | ONB Labs |https://labs.onb.ac.at/en/|
| Staatsbibliothek zu Berlin | SBB Labs | https://lab.sbb.berlin/?lang=en|
| State Library New South Wales | DX Lab | https://dxlab.sl.nsw.gov.au|

Las instituciones GLAM publican colecciones digitales en diferentes formatos y materiales. Tradicionalmente han publicado diversos tipos de materiales como imágenes, textos y mapas. Recientemente, nuevas formas de publicación han aparecido que utilizan tecnologías basadas en la Web Semántica. Estas técnicas permiten el enriquecimiento con repositorios externos de a partir de la creación de enlaces. [Wikidata](https://www.wikidata.org) se ha convertido en un repositorio muy popular en el ámbito de las instituciones GLAM y muchas de ellas ya disponen de propiedades específicas para enlazar sus recursos como autores y obras. Por ejemplo, la [Biblioteca Virtual Miguel de Cervantes](http://www.cervantesvirtual.com/) dispone de la propiedad [P2799](https://www.wikidata.org/wiki/Property:P2799) para enlazar autores desde su repositorio de datos abiertos hacia Wikidata.




## Ejemplo 1: Extracción y visualización de datos

Para este ejemplo vamos a utilizar la colección [Moving Image Catalogue](https://data.nls.uk/data/metadata-collections/moving-image-archive/) proporcionada por el [Data Foundry de la Biblioteca Nacional de Escocia](https://data.nls.uk/), publicada bajo dominio público y que contiene alrededor de 6.000 registros descritos con el estándar [MARC 21 XML](https://www.loc.gov/standards/marcxml/). Esta colección contiene información sobre imágenes en movimiento como vídeos, películas y documentales creadas por aficionados y profesionales, y relacionadas con Escocia. Este ejemplo está disponible en [GitHub](https://nbviewer.jupyter.org/github/hibernator11/notebook-texts-metadata/blob/master/dataset-extraction-images.ipynb) y puede ser ejecutado en [binder](https://mybinder.org/v2/gh/hibernator11/notebook-texts-example/master).
 
Para poder procesar de forma sencilla la colección digital vamos a cambiar de MARCXML a un formato más sencillo de manipular como el CSV. Posteriormente, haciendo uso de las librerías vistas en el ejemplo anterior, es posible identificar y obtener un listado de los temas favoreciendo así el descubrimiento de nuevo conocimiento.

En primer lugar, importamos las librerías que vamos a necesitar para trabajar con la colección incluyendo librerías para el manejo de MARC, CSV, expresiones regulares, visualización y empaquetado de datos.

```python
# importamos las librerías
# https://pypi.org/project/pymarc/
import pymarc, re, csv
import pandas as pd
from pymarc import parse_xml_to_array
```

Después, creamos un fichero CSV con el contenido de la colección descrito en MARCXML y que previamente hemos descargado. El fichero CSV debe incluir la cabecera con los campos que vamos a extraer.

```python
csv_salida = csv.writer(open('registros_marc.csv', 'w'), delimiter = ',', quotechar = '"', quoting = csv.QUOTE_MINIMAL)
csv_salida.writerow(['titulo', 'autor', 'lugar_produccion', 'fecha', 'extension', 'creditos', 'materias', 'resumen', 'detalles', 'enlace'])
```

A continuación, comenzamos a extraer la información del fichero MARCXML. El formato MARC21 facilita la descripción de los registros bibliográficos estructurándolos en campos (que identifica mediante números) y subcampos (que identifica por caracteres). Por ejemplo, el campo 245 $a corresponde al título principal de una obra y el campo 100 $a representa su autor principal. Como se observa en el siguiente fragmento de código, mediante la librería pymarc recorremos los registros y localizamos los campos que deseamos recuperar mediante sus identificadores para generar y almacenar el resultado en el fichero CSV.

```python
registros = parse_xml_to_array(open('Moving-Image-Archive/Moving-Image-Archive-dataset-MARC.xml'))

for registro in registros:
    
    titulo = autor = lugar_produccion = fecha = extension = creditos = materias = resumen = detalles = enlace =''
    
    # titulo
    if registro['245'] is not None:
      titulo = registro['245']['a']
      if registro['245']['b'] is not None:
        titulo = titulo + " " + registro['245']['b']
    
    # autor
    if registro['100'] is not None:
      autor = registro['100']['a']
    elif registro['110'] is not None:
      autor = registro['110']['a']
    elif registro['700'] is not None:
      autor = registro['700']['a']
    elif registro['710'] is not None:
      autor = registro['710']['a']
    
    # lugar de producción
    if registro['264'] is not None:
      lugar_produccion = registro['264']['a']
    
    # fecha
    for f in registro.get_fields('264'):
        fechas = f.get_subfields('c')
        if len(fechas):
            fecha = fechas[0]
            
            if fecha.endswith('.'): fecha = fecha[:-1]
    
    
    # Physical Description - extent
    for f in registro.get_fields('300'):
        extension = f.get_subfields('a')
        if len(extension):
            extension = extension[0]
            # TODO cleaning
        detalles = f.get_subfields('b')
        if len(detalles):
            detalles = detalles[0]
            
    # creditos
    if registro['508'] is not None:
      creditos = registro['508']['a']
    
    # Resumen
    if registro['520'] is not None:
      resumen = registro['520']['a']
    
    # Materia
    if registro['653'] is not None:
        materias = '' 
        for f in registro.get_fields('653'):
            materias += f.get_subfields('a')[0] + ' -- '
        materias = re.sub(' -- $', '', materias)
    
    
    # enlace
    if registro['856'] is not None:
      enlace = registro['856']['u']
    
    
    csv_salida.writerow([titulo,autor,lugar_produccion,fecha,extension,creditos,materias,resumen,detalles,enlace])
``` 

Una vez que ya hemos generado el fichero CSV, podemos cargarlo mediante la librería de software Pandas que permite cargar y manipular datos tabulados por medio de su estructura básica DataFrame.

```python    
# Este comando añade el contenido del fichero a un Pandas DataFrame
df = pd.read_csv('registros_marc.csv')
```

Para ver el contenido del DataFrame debemos mostrar la variable df. También podemos comprobar las columnas existentes así como el número de registros.

```python    
df  
```

{% include figure.html filename="df-overview.png" caption="El contenido del DataFrame" %}

También podemos mostrar las columnas que tiene nuestro fichero CSV llamando al método **df.columns**. Para obtener el número de registros en nuestro DataFrame ejecutamos el comando **len(df)**.

{% include figure.html filename="df-columns.png" caption="Mostrando las columnas del DataFrame" %}

Pandas permite la manipulación y visualización del Dataframe de diferentes formas. Por ejemplo, podemos identificar la lista de materias (corresponde a la columna subjects) y ordenarla alfabéticamente.

Cada registro contiene el metadato materia que consiste en un listado de elementos separados por la secuencia --. Por ejemplo, 'Ceremonies -- Emotions, Attitudes and Behaviour -- Local Government -- Transport -- Edinburgh -- amateur'. Pandas permite dividir este tipo de cadenas para tratar como elementos individuales mediante el comando [split](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.str.split.html) que recibe como parámetros el carácter a usar para dividir la cadena de texto y mediante la opción expand=True crea una nueva columna para cada elemento. El método [stack](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.stack.html) permite convertir las columnas a un índice. El resto de código ordena alfabéticamente los elementos.


```python    
# Obtener valores únicos
materias = pd.unique(df['materias'].str.split(' -- ', expand=True).stack()).tolist()
for materia in sorted(materias, key=str.lower):
    print(materia)
```

{% include figure.html filename="subjects.png" caption="Listado de materias ordenadas alfabéticamente" %}

Con el objetivo de demostrar que el código se puede adaptar y modificar a otras colecciones digitales, se ha incluido un ejemplo adicional basado en la [Bibliografía Española de Cartografía](https://datos.gob.es/es/catalogo/e00123904-bibliografia-espanola-de-cartografia-2017) es una publicación cuyo objetivo principal es dar a conocer el material cartográfico publicado en España, que ingresa en la Biblioteca Nacional de España que incluye mapas, planos, cartas náuticas, atlas, etc., tanto en formato impreso como electrónico.


## Ejemplo 2: Creación de mapas a partir de Linked Open Data

Para el segundo ejemplo nos vamos a basar en un repositorio creado usando tecnologías avanzadas como Linked Open Data. La plataforma [BNB Linked Data](https://bnb.data.bl.uk/) provee acceso a la British National Bibliography (BNB) como Linked Open Data proporcionando acceso a través de SPARQL. 

Este ejemplo se basa en la recuperación de localizaciones geográficas relacionadas con las obras de un autor. La localización corresponde al lugar de publicación original de una obra en particular. Una vez recuperadas las localizaciones y gracias a que los datos están enlazados a GeoNames, es posible obtener información adicional sobre esa localización, como por ejemplo la latitud y longitud que nos servirá para representarla en un mapa.

En este sentido, este ejemplo pretende introducir los pasos necesarios para reutilizar una colección digital publicada siguiendo los principios de Linked Open Data que facilita el establecimiento de enlaces a repositorios externos. Los repositorios semánticos publicados por instituciones GLAM son una fuente de información de gran valor que se encuentran a disposición de los investigadores sin ningún tipo de restricción para su uso. Sin embargo, su reutilización no es sencilla ya que requiere conocimientos avanzados en tecnologías como RDF (del inglés Resource Description Framework) o SPARQL para poder realizar las consultas.

Este ejemplo utiliza los metadatos del repositorio que indican localizaciones, como por ejemplo las propiedades blt:publication y blt:projectedPublication que indican lugares de publicación. Gracias a que los registros están enlazados a [GeoNames](https://www.geonames.org/), vamos a poder acceder a Wikidata para recuperar las coordenadas geográficas de las localizaciones, mostrando los beneficios de Linked Open Data. El vocabulario utilizado por BNB Linked Data es [Bibliographic Ontology](http://bibliontology.com/) (BIBO) que es un vocabulario sencillo que permite describir los metadatos de un repositorio bibliográfico.

En primer lugar, importamos las librerías necesarias para procesar esta colección: [folium](https://pypi.org/project/folium/0.1.4/) es necesario para visualizar información geográfica en un mapa; csv y json para el procesamiento de los formatos de entrada y salida; request para la realización de peticiones HTTP; pandas para la gestión de datos tabulares con columnas de tipo heterogéneo y matplotlib para la creación de gráficas.

```python
import folium
import requests
import pandas as pd
import json
import csv
import matplotlib.pyplot as plt
from pandas.io.json import json_normalize
```

A continuación, vemos un ejemplo de consulta SPARQL que recupera las obras publicadas en un lugar en concreto “York”. Las sentencias SPARQL de este apartado las podemos ejecutar en el punto de acceso [SPARQL](https://bnb.data.bl.uk/flint-sparql).

```sql
SELECT ?libro ?isbn ?titulo WHERE {
  ?lugar rdfs:label "York" .
  ?publicacion event:place ?lugar.
 ?libro 
        blt:publication ?publicacion;
        bibo:isbn10 ?isbn;
        dct:title ?titulo.
}
LIMIT 50
```

{% include figure.html filename="flint-sparql.png" caption="Punto de acceso SPARQL para la plataforma BNB Linked Data" %}


El resultado de la sentencia SPARQL anterior no proporciona las coordenadas geográficas a pesar de que algunos datos se encuentren enlazados a GeoNames mediante la relación c4dm:place. Con la siguiente sentencia SPARQL recuperamos las obras del autor Miguel de Cervantes Saavecra que tienen un lugar de publicación y que además está enlazado a GeoNames. En el modelo de la plataforma BNB Linked Data, un recurso de tipo publicación contiene una propiedad c4dm:place que enlaza a GeoNames en alrededor de 4 millones de registros (un 50% del catálogo completo).


```sql
PREFIX blt: <http://www.bl.uk/schemas/bibliographic/blterms#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX schema: <http://schema.org/>
PREFIX c4dm: <http://purl.org/NET/c4dm/event.owl#>

SELECT DISTINCT ?resource ?title ?date ?place WHERE {
  ?recurso ?p <http://bnb.data.bl.uk/id/person/CervantesSaavedraMiguelde1547-1616> ;
     dct:title ?titulo ;
     schema:datePublished ?fecha .
  ?recurso blt:publication ?publicacion .
     ?publicacion c4dm:place ?lugar .
     FILTER regex(?lugar, "geonames", "i")        
} LIMIT 500
```

Para poder ejecutar esta sentencia SPARQL en Python, necesitamos especificar el punto de acceso SPARQL y la sentencia SPARQL a ejecutar:

```python

url = 'https://bnb.data.bl.uk/sparql'

sentencia = """
PREFIX blt: <http://www.bl.uk/schemas/bibliographic/blterms#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX schema: <http://schema.org/>
PREFIX c4dm: <http://purl.org/NET/c4dm/event.owl#>

SELECT DISTINCT ?recurso ?titulo ?fecha ?lugar WHERE {
  ?recurso ?p <http://bnb.data.bl.uk/id/person/CervantesSaavedraMiguelde1547-1616> ;
     dct:title ?titulo ;
     schema:datePublished ?fecha .
  ?recurso blt:publication ?publicacion .
     ?publicacion c4dm:place ?lugar .
     FILTER regex(?lugar, "geonames", "i")        
} LIMIT 500
"""
```

A continuación, recuperamos el resultado configurando la cabecera de la petición para que devuelva como resultado un objeto JSON.

```python
cabeceras = {'Accept': 'application/sparql-results+json'}
r = requests.get(url, params = {'format': 'application/sparql-results+json', 'query': sentencia}, headers=cabeceras)
print(r.text)
```

{% include figure.html filename="json-result.png" caption="Resultados de la petición a la plataforma BNB Linked Data" %}

Y almacenamos el resultado en un fichero CSV más sencillo de manipular. En primer lugar cargamos en un objeto JSON el resultado obtenido.

```python
bnbdatos = json.loads(r.text)
```

Después creamos el fichero CSV y volcamos el contenido del objeto JSON a este fichero. Para ello, recorreremos cada ítem del listado de resultados dentro del objeto JSON usando la variable bnbdata y accediendo a los atributos ['results']['bindings']. Cada propiedad tiene un atributo value que contiene el valor que necesitamos recuperar.

```python
with open('bnb_registros.csv', 'w', newline='') as file:
    csv_salida = csv.writer(file, delimiter = ',', quotechar = '"', quoting = csv.QUOTE_MINIMAL)    
    csv_salida.writerow(['recurso', 'lugar', 'titulo', 'fecha'])

    for i in bnbdatos['results']['bindings']:
        recurso = place = title = date =''

        recurso = i['recurso']['value']
        lugar = i['lugar']['value']
        titulo = i['titulo']['value']
        fecha = i['fecha']['value']

        csv_salida.writerow([recurso,lugar,titulo,fecha])
```

Una vez que tenemos creado el fichero CSV, podemos cargarlo en un objeto DataFrame de pandas que nos facilita el análisis y tratamiento.

```python
df = pd.read_csv('bnb_registros.csv')
df
```

{% include figure.html filename="df-bnb.png" caption="Visualización del objeto DataFrame con los resultados" %}

A continuación, podemos analizar cuántos enlaces diferentes tenemos a GeoNames en el listado de resultados. Pandas permite acceder a las columnas del objeto DataFrame mediante el operador groupby. En este ejemplo agrupamos por la columna lugar de publicación (place) y en la segunda posición marcamos la columna que queremos utilizar para realizar la agregación, en este caso, la obra (resource). 

```python
lugares_por_recurso = df.groupby("lugar")["recurso"].count()
```

{% include figure.html filename="geonames-links.png" caption="Enlaces a GeoNames en el listado de resultados" %}

La plataforma BNB Linked Data proporciona los enlaces a GeoNames pero no contiene las coordenadas geográficas. Sin embargo, esta información puede ser recuperada de otros repositorio, como por ejemplo Wikidata. Las entidades en Wikidata disponen de un conjunto de propiedades que las describen y también incluyen un segundo apartado para identificadores externos. La siguiente imagen corresponde a la entidad [Londres en Wikidata](https://www.wikidata.org/wiki/Q84?uselang=es) y podemos observar el identificador de GeoNames.

Hasta ahora disponemos de las URIs de cada elemento de GeoNames. Para poder enlazar a Wikidata necesitamos únicamente el identificador. El siguiente código extrae los identificadores haciendo tratamiento de cadenas.

{% include figure.html filename="entidad-londres.png" caption="Enlaces a GeoNames en el listado de resultados" %}

```python
lugares = pd.unique(df['lugar']).tolist()
cadena_lugares = ''
for a in sorted(lugares):
    print(a)
    cadena_lugares = cadena_lugares + ' \"' + a.replace("http://sws.geonames.org/", "").replace("/", "") + '\"'
print(cadena_lugares)
```

{% include figure.html filename="ids-geonames.png" caption="Extracción de identificadores de GeoNames" %}


Una vez tenemos preparado nuestro listado de identificadores a GeoNames, vamos a recuperar las coordenadas geográficas de Wikidata. Para ello es necesario crear una consulta SPARQL. Vamos a utilizar la instrucción VALUES que permite especificar los valores para una determinada variable, en nuestro caso, los identificadores de GeoNames. La propiedad P1566 corresponde al identificador de GeoNames en Wikidata y la propiedad P625 corresponde a las propiedades geográficas.

```python
url = 'https://query.wikidata.org/sparql'
sentencia = """
PREFIX bibo: <http://purl.org/ontology/bibo/>
SELECT ?idgeonames ?lat ?lon ?x ?xLabel 
{% raw %}WHERE {{ {% endraw %}
   {% raw %}values ?idgeonames {{ {0} }}{% endraw %}
   ?x wdt:P1566 ?idgeonames ; 
    p:P625 [
      psv:P625 [
        wikibase:geoLatitude ?lat ;
        wikibase:geoLongitude ?lon ;
        wikibase:geoGlobe ?globe ;
      ];
      ps:P625 ?coord
    ]
    {% raw %}SERVICE wikibase:label {{ bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }}{% endraw %}
{% raw %}}}{% endraw %}
"""
sentencia = sentencia.format(cadena_lugares)
print(sentencia)

r = requests.get(url, params = {'format': 'json', 'query': sentencia})
puntos_geo = r.json()
```

Finalmente, creamos un objeto folium para implementar un mapa y añadir las coordenadas recuperadas desde Wikidata en el paso anterior. Recuperamos cada coordenada geográfica (variables lat y lon) y montamos el texto (popup) que se mostrará al hacer click sobre cada localización en el mapa. Finalmente, añadimos al mapa cada elemento (marker).

```python
mapa = folium.Map(location=[0,0], zoom_start=1.5)

for geo in puntos_geo['results']['bindings']:
    idwikidata = geo['x']['value']
    lat = geo['lat']['value']
    lon = geo['lon']['value']
    idgeonames = geo['idgeonames']['value']
    etiqueta = geo['xLabel']['value']
    print(lat, lon)
    
    # insertar el texto en el popup
    count = lugares_por_recurso[['http://sws.geonames.org/' + idgeonames + '/']][0]
    texto_popup = str(count) + " registros publicados en <a hreh='" + str(idwikidata) + "'>" + etiqueta + "</a>"
    
    folium.Marker([lat,lon], popup= texto_popup).add_to(mapa)
```

Y como resultado se obtiene un mapa con los lugares de publicación de las obras del autor seleccionado, en nuestro caso, Miguel de Cervantes.

{% include figure.html filename="map.png" caption="Lugares de publicación de las obras de William Shakespeare" %}




## Conclusiones
Las instituciones GLAM se están adaptando al nuevo entorno proporcionando colecciones aptas para el procesamiento por computador. Los labs en el seno de las instituciones GLAM desempeñan un papel fundamental en este sentido para promover las colecciones digitales y su reutilización de forma innovadora. Sin embargo, todavía es posible mejorar en lo que respecta a las licencias para proporcionar colecciones digitales libres de derechos como también a la publicación de ejemplos y prototipos de uso. En ese sentido, los Jupyter Notebooks pueden promover la creación de prototipos basados en métodos de investigación de Humanidades Digitales facilitando su reproducibilidad en entornos basados en la nube. 


## Glosario
<dl>
  <dt><strong>Collections as data</strong></dt> 
  <dd>Movimiento para promover el acceso computacional a las colecciones digitales.</dd>
  <dt><strong>CSV (del inglés Comma Separated Values)</strong></dt>
  <dd>Un archivo CSV consiste en un fichero de texto que contiene filas formadas columnas y separadas por comas.</dd>
  <dt><strong>DataFrame</strong></dt>
  <dd>Estructura que permite almacenar y manipular datos tabulados en filas formadas por columnas de variables.</dd>
  <dt><strong>Folium</strong></dt>
  <dd>Biblioteca de software Python que permite crear mapas interactivos.</dd>
  <dt><strong>GeoNames</strong></dt> 
  <dd>Repositorio geográfico gratuito que proporciona un identificador único para cada recurso</dd>
  <dt><strong>GLAM Workbench</strong></dt> 
  <dd>Conjunto de herramientas, tutoriales y ejemplos basados en collectiones digitales publicadas por instituciones GLAM y desarrollado por el australiano Tim Sherratt.</dd>
  <dt><strong>Jupyter Notebook</strong></dt>
  <dd>Plataforma de código abierto que permite crear y compartir documentos compuestos por código, gráficas y documentación.</dd>
  <dt><strong>Linked Open Data</strong></dt> 
  <dd>Publicación de información basada en RDF y conectada con repositorios externos de diferentes fuentes e instituciones.</dd>
  <dt><strong>MARCXML</strong></dt>
  <dd>Formato para la codificación de un registro MARC en XML.</dd>
  <dt><strong>MyBinder</strong></dt>
  <dd>Plataforma gratuita para la ejecución de Jupyter Notebooks alojados en repositorios como GitHub o zenodo evitando la instalación de software.</dd>
  <dt><strong>Pandas</strong></dt>
  <dd>Biblioteca de software Python que permite crear y manipular conjuntos de datos.</dd>
  <dt><strong>Python</strong></dt>
  <dd>Lenguaje de programación interpretado y multiplataforma, de libre uso y con una cruva de aprendizaje amigable y corta.</dd>
  <dt><strong>RDF (del inglés Resource Description Framework)</strong></dt>
  <dd>Marco de descripción de recursos publicado por el W3C para publicar información en Internet a modo de tripletas.</dd>  
  <dt><strong>SPARQL</strong></dt> 
  <dd>Lenguaje de consulta para información almacenada en formato RDF.</dd>
  <dt><strong>URI (del inglés Universal Resource Identifier)</strong></dt>
  <dd>identificador uniforme de recursos para la web</dd>
</dl>
