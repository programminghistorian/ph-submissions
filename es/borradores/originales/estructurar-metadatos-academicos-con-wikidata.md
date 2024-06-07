---
title: "Promoviendo la ciencia abierta con Wikidata: visibilidad y apertura de los Portales de Revistas Académicas"
slug: estructurar-metadatos-academicos-con-wikidata
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Cláudia De Souza
- Dinah M. Wilson Fraites
reviewers:
- Forename Surname
- Forename Surname
editors:
- Jennifer Isasi
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/589
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}


## Introducción

Seguramente ya has escuchado hablar sobre metadatos, datos abiertos y datos abiertos enlazados. No obstante, antes de iniciar esta lección, es importante clarificar y profundizar nuestro entendimiento sobre estos conceptos y explorar brevemente sus interconexiones, con el objetivo de fortalecer nuestra comprensión.

El prefijo ‘meta’ viene del griego, idioma en el que esto significa ‘después’ o ‘más allá’. Así que, de manera abstracta, lo usamos para indicar que un concepto se aplica sobre sí mismo. La palabra ‘metadatos’, por lo tanto, sería algo como ‘datos sobre los datos’. Precisamente, los metadatos son ‘datos que hablan acerca de los datos’, en el sentido de que describen, identifican, ubican o facilitan la comprensión de los datos de los archivos o la información que estos traen en su interior. Especialmente en el ámbito interdisciplinar de la ciencia de información, los metadatos proporcionan contexto y estructura, permitiendo una gestión eficiente, búsqueda y organización de la información, así como facilitando la interoperabilidad entre sistemas, distintas plataformas y la preservación a largo plazo de los recursos digitales. Hoy en día, con internet, los metadatos son cada vez más utilizados debido a la enorme cantidad de información disponible en línea, ya que son esenciales para facilitar la clasificación de páginas, optimizar motores de búsqueda y mejorar la navegación del usuario (Daudinot Founier, 2006; Torres Pombert, 2006; Cuba Rodríguez & Olivera Batista 2018).

En los últimos años, en un mundo cada vez más digitalizado y conectado, el interés por los datos abiertos (lo que en inglés serían los _Open Data_) también ha crecido exponencialmente, dada la necesidad de promover la transparencia y la reutilización de la información en diversas disciplinas. Cada vez más los metadatos son puestos a disposición con las características técnicas y jurídicas necesarias para que puedan ser usados, reutilizados y redistribuidos libremente por cualquier persona, en cualquier momento y en cualquier lugar, desde la investigación científica hasta la gestión de recursos culturales (Cadena López, Ramos Luna, & Rivera González, 2022). La adopción de estándares abiertos para metadatos no solo facilita la comprensión y el intercambio de datos, sino que también impulsa la innovación al permitir que todo se comunique de manera más efectiva. En este contexto, los datos abiertos se han convertido en un componente esencial para la construcción de infraestructuras de datos sostenibles y accesibles, promoviendo un enfoque colaborativo hacia la gestión de la información en la era digital.

En el marco de esta filosofía de los datos abiertos, ha surgido una forma de presentar y publicar datos en la web para que puedan ser consumidos y reutilizados en cualquier lugar y mediante procesos automatizados: los datos abiertos enlazados o vinculados (_Linked Open Data_\-LOD, en inglés). El origen de los LOD se remonta a un principio que manifiesta el poder establecer vinculaciones de significado entre datos con atributos similares que están disponibles en diferentes fuentes de la web, lo cual supone el establecimiento de un entorno con interoperabilidad global (Ávila-Barrientos, 2022). Por lo tanto, este término se refiere a un conjunto de mejores prácticas para publicar y conectar datos estructurados en la web. Como forma novedosa y diferente a otras aproximaciones, la información en Wikidata se almacena en tripletas siguiendo el Marco de Descripción de Recursos (_Resource Description Framework_\-RDF), que se conocen convencionalmente como sujeto, predicado y objeto. Si todavía tienes dudas o quieres profundizar tu conocimiento sobre este tema, puedes consultar más detalles en la [lección de Jonathan Blaney, que ofrece una introducción breve y concisa a los datos abiertos enlazados](https://doi.org/10.46430/phes0038).  

### Objectivos de la lección

Este tutorial se enmarca en el ámbito de la organización, gestión y recuperación de la información. En primer lugar, se explica brevemente los conceptos de metadatos y datos abiertos enlazados, estableciendo las bases para una comprensión más profunda de la lección. Posteriormente se detalla qué es Wikidata y su aplicación práctica. Es decir, los procedimientos que deben seguirse y ejecutarse para la inserción, edición y publicación de metadatos en esta plataforma. Finalmente, exploraremos cómo utilizar Wikidata para describir de manera precisa y detallada diferentes elementos relacionados con el mundo académico y de la investigación. Abordaremos las revistas y los datos de autoridades de personas detrás de ellas. Aprenderemos cómo estructurar y enlazar los datos en Wikidata para promover el acceso abierto y contribuir a la apertura, la visibilidad y la interoperabilidad de este tipo de recursos.

### Prerrequisitos 

No es necesario ningún conocimiento previo.

## ¿Qué es Wikidata?

Wikidata es una plataforma libre, completamente abierta, que está totalmente construida con datos abiertos enlazados. Se trata de una base de datos lanzada en octubre de 2012, como de uno de los proyectos más novedosos para poder centralizar los datos de las diversas temáticas y comunidades operadas por la Fundación Wikimedia (Figura 1). Esa institución es una organización sin fines lucrativos que, a través de múltiples proyectos, aporta información y conocimiento de manera libre para todas las personas del mundo.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-01.png" alt="Visual description of figure image" caption="Figura 1. Un resumen de los diversos proyectos de la Fundación Wikimedia" %}

Según la definición de su propia [web](https://www.wikidata.org/wiki/Wikidata:Introduction/es), tanto el contenido como la estructura de Wikidata se encuentran en dominio público; esto significa que podemos copiar, modificar, distribuir y presentar los datos, incluso con fines comerciales, sin necesidad de pedir permiso. Además, Wikidata tiene las siguientes características:

- **Accesible para otros proyectos:** los datos almacenados en Wikidata están disponibles para ser utilizados por otros proyectos de Wikimedia, como Wikipedia, por ejemplo. Esto proporciona una fuente centralizada de información que puede ser aprovechada por diversas aplicaciones y sitios web.
- **Colaborativa**: La creación y edición de contenido en Wikidata se enriquece con usuarios voluntarios de todo el mundo.
- **Actualización continua**: La comunidad contribuye a la mejora y expansión continua de la base de datos, que se actualiza constantemente. Esto garantiza que la información esté al día y refleje cambios y descubrimientos recientes.
- **Historial de versiones**: Wikidata registra un historial de revisiones para cada elemento y declaración, permitiendo el seguimiento de cambios a lo largo del tiempo. Esa funcionalidad asegura la transparencia y la posibilidad de revertir cambios, si fuera necesario.
- **Multilingüe**: permite la representación de elementos y sus descripciones en más de 300 idiomas.
- **Datos estructurados**: esto es clave, ya que la información está organizada en campos específicos y categorías (es decir, siguiendo un modelo, con una serie de reglas y restricciones). Esto mejora la consistencia y facilita la búsqueda, el acceso, recuperación, actualización y reutilización de datos tanto por humanos como por máquinas.

En 2019 Wikidata contaba con aproximadamente 55 millones de elementos creados, mientras que, cuatro años más tarde, ya ha superado los 100 millones de elementos (Figura 2) de temáticas tan diversas como objetos, personas, lugares, informes, arte, edificios de interés cultural, animales, personas, y mucho más

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-02.png" alt="Visual description of figure image" caption="Figura 2. Creación de elementos por fecha para Wikidata" %}

Fuente: <https://commons.wikimedia.org/wiki/File:Wikidata_item_creation_progress_no_text.svg>

Wikidata ofrece, además, una gran variedad de herramientas para editar, consultar y visualizar sus datos. Este modelo de web semántica contribuye a fomentar la justicia social, ya que, a través del acceso, aplicación y generación de conocimiento en abierto, comunidades pequeñas que no hacen parte de la corriente principal de la ciencia, pueden tener un impacto global mayor y de un modo mucho más eficiente. Obregón Sierra (2022), por ejemplo, la ha utilizado para inserir información sobre las bibliotecas de España, con la intención de que sean accesibles para cualquier usuario que quiera utilizarla alrededor de todo el mundo. Antes de comenzar con la introducción de los datos en Wikidata, el autor afirma que existían únicamente 303 elementos que se correspondían con bibliotecas situadas en España. Tras introducir todas las bibliotecas recogidas en el fichero del Gobierno de España, se crearon 7861 bibliotecas más, y se mejoraron los datos de 206 de esos elementos ya creados. En cuanto al número de galerías, bibliotecas, archivos y museos (GLAMs, del inglés _Galleries, Libraries, Archives, and Museums_) en España, existían 2424 elementos creados, siendo el 13º país con mayor número, muy por detrás de los 47.586 con los que contaba Estados Unidos. Tras la introducción de todas las bibliotecas, España se situó en el segundo lugar del ranking.

Dado que Wikidata es capaz de combinar los metadatos locales con los globales, muchas instituciones con colecciones digitales han comenzado a trabajar con ella para incrementar su acceso global. Ya son varios los desarrollos que ha experimentado. Entre ellos, cabe destacar la gran difusión de uso que ha tenido en la catalogación bibliotecaria, donde los identificadores de Wikidata han permitido a las bibliotecas acceder a información de Wikidata en relación con los fondos que poseen.

## La estructura de Wikidata

En esta sección exploraremos la organización de Wikidata, examinando sus componentes y comprendiendo sus funciones específicas. Este análisis nos facilitará un entendimiento más sólido de la estructura jerárquica y modular que tiene Wikidata.

Uno de los primeros términos que debemos de ir familiarizándonos es el de los elementos. Ellos son las unidades fundamentales de Wikidata. Los elementos representan conceptos únicos, que pueden abarcar una amplia gama de entidades, como personas, lugares, eventos, ideas, cuerpos celestes, especies de seres vivos, películas, obras literarias, etc.

Cada elemento de Wikidata está formado por una etiqueta, que es un nombre descriptivo corto utilizado para identificar el concepto, seguido por un identificador único, que tiene como formato la letra "Q" seguido de un número, por ejemplo: la revista ‘_The Programming Historian en español_’ tiene como identificador Q96737788 (Figura 3). Esta designación única permite referenciar y acceder fácilmente a un elemento específico, independientemente del idioma en el que esté descrito. No es necesario memorizar el número Q de cada elemento, ya que los identificadores universales proporcionan una forma fácil de referenciar y localizar a la información sin depender de la retención de números específicos.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-03.png" alt="Visual description of figure image" caption="Figura 3. Ejemplo de identificador en Wikidata: el número Q de la revista con Programming Historian en español" %}

Las etiquetas en Wikidata pueden ser ambiguas, como en el caso de ‘San Martín’, que puede referirse a una persona, una ciudad, una isla o una región del Perú. Sin embargo, los identificadores son universalmente aplicables y eliminan la necesidad de un identificador por cada idioma. Dicha característica facilita la lectura para las máquinas y también habilita a los _bots_ para editar Wikidata de manera eficiente.

A continuación de la etiqueta y del identificador encontraremos una breve descripción, que ofrece detalles adicionales para ayudar a distinguirlo de otros elementos que pudieran tener similitudes. Esta descripción es clave para que podamos entender el contexto del elemento.

Los elementos también pueden tener alias, que son nombres alternativos o apodos. Estas distintas variantes adicionales de la etiqueta ayudan a facilitar la búsqueda de los elementos y que estos sean reconocibles por distintas comunidades (Figura 4).

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-04.png" alt="Visual description of figure image" caption="Figura 4. Ejemplo de etiqueta, identificador, descripción y distintas variantes de nombre (alias) en Wikidata" %}

Luego de este primer apartado (en donde incluye la etiqueta, el identificador precedido por la letra "Q", la descripción y los alias), encontraremos la sección de idiomas, que amplía la accesibilidad y utilidad de la información al proporcionar traducciones de los elementos a varios idiomas. La Figura 5 muestra el ejemplo del elemento 'lluvia' en Wikidata, acompañado de sus correspondientes traducciones en español, inglés y portugués. Esta sección multilingüe hace que la información sea más accesible y útil para una audiencia global, ya que facilita la comprensión del contenido en varios idiomas.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-05.png" alt="Visual description of figure image" caption="Figura 5. Ejemplo del multilingüismo en Wikidata: el caso del Elemento 'lluvia'" %}

Al describir un elemento en Wikidata, debemos de hacerlo mediante declaraciones. Se tratan de afirmaciones que representan información estructurada específica sobre un elemento en la base de datos. Los elementos están conectados entre sí a través de una serie de propiedades (atributos o características) y valores asociados que forman estas declaraciones (Figura 6). Son ellas las que establecen las relaciones y conforman la estructura jerárquica y modular que tiene Wikidata.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-06.png" alt="Visual description of figure image" caption="Figura 6. Las declaraciones en Wikidata: ejemplos de propiedades y valores" %}

Cada propiedad tiene un identificador único en Wikidata, que se utiliza para referirse a ella de manera única en la base de datos. Estos identificadores tienen la forma de una letra "P" seguida de un número. Las propiedades en Wikidata están diseñadas para ser reutilizables en diferentes contextos. Esto significa que una propiedad puede aplicarse a múltiples tipos de elementos y no está limitada a un solo uso. Cada propiedad tiene su propia página de documentación en Wikidata donde se proporciona información detallada sobre su propósito, su uso adecuado y ejemplos de su aplicación. Por otro lado, los valores en Wikidata representan la información concreta asociada a propiedades específicas para describir elementos en la base de datos. Los valores en Wikidata pueden ser de varios tipos, incluyendo texto, números, fechas, enlaces a otros elementos de Wikidata, coordenadas geográficas, archivos multimedia, entre otros. Los valores deben cumplir con las restricciones establecidas por el tipo de datos de la propiedad a la que están asociados. Por ejemplo, si una propiedad tiene un tipo de dato de "fecha", el valor asignado a esa propiedad debe ser una fecha válida. Además, los valores en Wikidata son susceptibles de ser editados por cualquier usuario de la plataforma. Esto permite una colaboración abierta y comunitaria para mantener y mejorar la calidad de la información en la base de datos.

## Paso a paso crear una cuenta y un elemento en Wikidata

Aunque no es estrictamente necesario tener cuenta de usuario para editar en Wikidata, se recomienda crear una porque esto mejorará tu experiencia como editor y te permitirá una participación más efectiva con la comunidad de Wikidata. Con la cuenta, es posible rastrear tus contribuciones, es decir, ver tu historial de ediciones. Esto también facilita la comunicación con otros usuarios, una vez que puedes dejar mensajes en las páginas de discusión de otros editores y recibir notificaciones sobre cambios en los elementos que estás siguiendo. Además, la comunidad tiende a confiar más en las ediciones realizadas por usuarios registrados. La figura resalta el botón con el enlace específico para iniciar este proceso.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-07.png" alt="Visual description of figure image" caption="Figura 7. Detalle del apartado de creación de cuenta en Wikidata" %}

Puedes usar tu cuenta de Wikimedia o crear una nueva específicamente para Wikidata. En este caso (caso), debes de dirigirte a la página principal de Wikidata (<https://www.wikidata.org/>) y hacer clique en "crear una cuenta" (_Create Account_) en la esquina superior derecha.

Después de iniciar sesión, antes de agregar un nuevo elemento, se recomienda que realices una búsqueda en Wikidata para asegurarte de que el elemento no exista ya. Si encuentras un elemento similar, puedes contribuir a él en lugar de crear uno nuevo. Si no encuentras un elemento existente, puedes crear uno nuevo. Haz clic en el botón "crear un nuevo ítem" en la parte superior derecha de la página principal de Wikidata (Figura 8).

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-08.png" alt="Visual description of figure image" caption="Figura 8. Proceso para crear un nuevo elemento en Wikidata" %}

A partir de entonces ya puedes empezar a completar los campos, rellenando la información requerida para tu nuevo elemento. Se suele incluir al menos un nombre y una descripción para el nuevo ítem (Figura 9). Ten en cuenta que existen algunas convenciones preestablecidas que debemos de seguir para mantener una consistencia en la presentación de la información en todo el proyecto:

- **Minúsculas:** Las descripciones de los elementos generalmente comienzan con minúscula, a menos que la primera palabra sea un nombre propio que requiera mayúscula inicial.
- **Brevedad y claridad:** Las descripciones en Wikidata deben ser breves y claras. Se busca proporcionar información concisa sobre el elemento de manera que sea fácilmente comprensible para los usuarios.
- **Evitar redundancias:** Se evita repetir información ya presente en el nombre del elemento. La descripción debería agregar información adicional o aclarar el contexto del elemento.
- **Sin artículo inicial:** Al omitir los artículos iniciales (como "un" o "una") se busca mantener la uniformidad y la simplicidad en las descripciones de Wikidata. Así se mantienen más concisas y neutrales.
- **No llevan punto final:** Esto se hace para mantener la coherencia en el estilo de redacción y porque las descripciones son más parecidas a etiquetas informativas concisas que a oraciones completas.
- **Idioma local:** Las descripciones deben seguir el idioma local del proyecto Wikidata. Por ejemplo, si estás contribuyendo en la versión en español de Wikidata, las descripciones deben estar en español.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-09.png" alt="Visual description of figure image" caption="Figura 9. Rellenando información para un nuevo elemento en Wikidata" %}

Posteriormente, es hora de empezar a introducir las declaraciones sobre este nuevo ítem, para enriquecer la información del elemento.

En Wikidata, la primera declaración que se realiza comúnmente es la declaración "instancia de” (P31) (_instance of_), que indica el tipo de entidad a la que pertenece el elemento. Esta declaración ayuda a clasificar y organizar la información en Wikidata. La diversidad de elementos en Wikidata permite una amplia gama de posibilidades para esta declaración "instancia de". Dependiendo del elemento que estés creando, deberías seleccionar el tipo de entidad que mejor se ajuste a la naturaleza del objeto o concepto que estás representando.

Por ejemplo, si estás creando un elemento para una persona famosa, podrías tener "instancia de: humano" (en inglés, "_instance of_: human"), mientras que para describir a París, la primera declaración podría ser "instancia de: ciudad" (en inglés, "_instance of_: city"). Esto ayuda a establecer la naturaleza básica del elemento y a conectarlo con otros elementos similares en la base de datos. Te dejo algunos otros ejemplos de casos:

- Instancia de: Ser Humano - Para una entidad que representa a una persona específica.
- Instancia de: Ciudad - Para describir una entidad que representa una ciudad.
- Instancia de: País - Para una entidad que representa un país específico.
- Instancia de: Obra de Arte - Para elementos que representan obras de arte, como pinturas o esculturas.
- Instancia de: Animal - Para describir entidades que representan animales específicos.
- Instancia de: Libro - Para elementos que representan libros o publicaciones escritas.
- Instancia de: Organización No Gubernamental - Para una entidad que representa una ONG específica.
- Instancia de: Película - Para elementos que representan películas cinematográficas.
- Instancia de: Edificio - Para describir entidades que representan edificios o estructuras arquitectónicas.
- Instancia de: Evento Deportivo - Para una entidad que representa un evento deportivo específico.

Después de la declaración "instancia de", puedes agregar más declaraciones para seguir proporcionando información adicional sobre el elemento, como propiedades específicas y valores asociados.

## Describiendo datos de revistas en Wikidata

Para comprender cómo Wikidata puede ser utilizada para describir entidades relacionadas con el ámbito académico y de investigación, consideremos el caso de la publicación anual de la Sociedad de Bibliotecarios de Puerto Rico, que fue fundada en 1998 y se llama Acceso: Revista Puertorriqueña de Bibliotecología y Documentación. Su identificar único en Wikidata es el Q116681177.

Las declaraciones en Wikidata constan de (al menos) un par propiedad-valor. La figura 10 muestra los que han sido insertados para la primera declaración (“instancia de”) de este elemento: revista académica, revista científica y publicación en acceso abierto. Vale la pena destacar que como Wikidata admite información en varios idiomas, también es factible asignar valores en inglés a un elemento en español.

En este contexto, se ha establecido además la categoría "_library science journal_". Esto permite que la información sea accesible para usuarios de diferentes regiones y culturas.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-10.png" alt="Visual description of figure image" caption="Figura 10. Ejemplo de la declaración “instancia de” para una revista" %}

En Wikidata, no hay un límite específico en la cantidad de propiedades y valores que puedes agregar a una instancia. La elección dependerá de la información que desees incluir sobre la revista científica. Puedes usar tantas como sean relevantes y necesarias para describir completamente al elemento que estás representando. Por lo tanto, algunos otros valores que también podrían haber sido incluidos son "revista especializada" o "revista de la sociedad". Sin embargo, es importante tener en cuenta la relevancia y la precisión de la información que estás agregando. No se trata de agregar tantas como sea posible, sino de proporcionar información significativa y útil para los usuarios.

Como se puede observar en la figura 11, la siguiente propiedad que se ha agregado a este elemento en Wikidata ha sido “nombre corto” (P1813). En el caso de las revistas, se utiliza para registrar las abreviaturas del título de la revista. Seguidamente, se ha incluido el título oficial juntamente con su respectiva referencia. Siempre que sea posible, es buena práctica proporcionar referencias para respaldar la información que estás ingresando. Esto ayuda a mantener la fiabilidad y la verificabilidad de los datos en Wikidata. Las referencias pueden ser enlaces a fuentes fiables, como sitios web oficiales, bases de datos reconocidas, libros, artículos, o cualquier otra publicación académica que respalde la afirmación hecha en la declaración. Importante resaltar que las redes sociales no son consideradas fuentes adecuadas para proporcionar referencias en Wikidata.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-11.png" alt="Visual description of figure image" caption="Figura 11. Ejemplo de descripción de datos de una revista en Wikidata: título, titulo corto y campo de trabajo" %}

Las referencias en Wikidata suelen seguir un formato estándar que incluye información como el título de la fuente, el autor (si está disponible), la fecha de publicación y un enlace URL o un identificador único (como un DOI-_Digital Object Identifier_ o un ISBN- _International Standard Book Number_) que permite acceder a la fuente original.

Posteriormente, se ha incluido la propiedad “campo de trabajo” (P101). Se trata del área de especialización de la publicación, pero también es conocido como disciplina o ámbito científico. Para el caso de la revista Acceso, se ha registrado una variedad de términos relacionados al manejo, organización y preservación de la información en diferentes contextos: ciencias de la información, archivística, ciencia documental, museología. Muchos de estos conceptos han sido repetidos en la propiedad “tema principal de la obra (P921)”

Aun en lo que respecta a la información básica de una revista, otras propiedades que pueden ser utilizadas en Wikidata son:

- país de origen (P495) - para indicar el país desde el cual se publica la revista.
- lugar de publicación (P291) - para indicar la ciudad o país donde la revista tiene su sede editorial o donde se publica regularmente. Esto proporciona información sobre el contexto geográfico de la revista y puede ser útil para comprender su alcance y audiencia.
- idioma de la obra (P407) - para indicar el idioma en el que se publican los artículos de la revista. Esta propiedad ayuda a identificar el idioma en el que está disponible la obra y facilita la búsqueda y clasificación por idioma en la base de datos de Wikidata.
- página web oficial (P856) - para indicar la dirección URL del sitio web oficial de la revista. Proporcionar este enlace ayudaría a los usuarios a acceder fácilmente a más información sobre la publicación.
- estado de acceso en línea (P6954) - para indicar si la revista está disponible en línea de forma gratuita, si requiere una suscripción para acceder a su contenido en línea, o si no está disponible en línea.
- editorial (P123) - para especificar la entidad o individuo responsable de la edición y gestión de la publicación. En el caso de la revista Acceso, el valor incluido allí ha sido “Sociedad de Bibliotecarios de Puerto Rico”.

La figura 12 muestra un ejemplo del uso de la propiedad “indexado en la base de datos bibliográfica” (P8875) en Wikidata. Es posible observar que, mediante los datos enlazados, los elementos se vinculan con otras bases de datos y catálogos externos.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-12.png" alt="Visual description of figure image" caption="Figura 12. Ejemplo del uso de la propiedad “indexado en la base de datos bibliográfica” en Wikidata" %}

## Describiendo datos de personas en Wikidata

La creación de datos abiertos enlazados sobre personas es un paso importante para la descripción de entidades en el ámbito académico y de investigación, en tanto permite vincular la autoría de un artículo con la revista en la que está publicado dicho trabajo. De esta manera, Wikidata puede servir para otorgarle mayor visibilidad a la producción científica de una institución.

El uso de Wikidata para crear registros de personas también apoya la gestión de identidades (_identity management_) en bibliotecas, archivos y museos. La gestión de identidades depende del uso y vinculación de identificadores únicos provenientes de distintas fuentes. La inclusión de diferentes identificadores para una misma persona en Wikidata promueve la exploración, el descubrimiento y el acceso a información fuera de silos de metadatos como pueden ser los catálogos de bibliotecas (Werf, 2022).

Para crear datos sobre personas, particularmente personas vivas, es importante tener presente consideraciones éticas sobre la dignidad, la seguridad y la privacidad. La página [Wikidata:Personas vivas](https://www.wikidata.org/wiki/Wikidata:Living_people/es) establece que sólo debemos incluir información verificable sobre una persona que no viole las expectativas razonables de privacidad. Las declaraciones sobre una persona deben estar respaldadas por fuentes fiables; recuerda que las redes sociales no son una fuente aceptable de información.

El primer paso para crear datos sobre personas en Wikidata es asegurarte de que no exista un registro creado. Si no existe un registro, puedes crear un nuevo ítem. En la etiqueta, debes registrar la forma del nombre bajo la cual se conoce comúnmente a la persona. Además, debes redactar una descripción breve sobre la persona. Por último, puedes registrar otras variantes del nombre. Luego de completar la casilla de etiqueta y descripción, puedes comenzar con las declaraciones. La primera declaración es “instancia de” (P31) con el valor de “ser humano” (Q5). La Figura 13 ilustra el establecimiento de etiqueta, descripción y variantes del nombre para el filósofo puertorriqueño Francisco José Ramos (Q105725041).

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-13.png" alt="Visual description of figure image" caption="Figura 13. Etiqueta, descripción y variantes del nombre en Wikidata" %}

Las siguientes declaraciones están relacionadas con el nombre. Puedes registrar el “nombre de pila” (P735), el “apellido” (P734) y el “segundo apellido” (P1950). Para nombres compuestos, debes registrar cada nombre como un valor independiente bajo la misma propiedad de “nombre de pila” y añadir el calificativo “orden dentro de la serie” (P1545) para designar el primer nombre y luego el segundo nombre. La Figura 14 ilustra el proceso para registrar el nombre de pila compuesto “Francisco José”.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-14.png" alt="Visual description of figure image" caption="Figura 14. Nombre de pila compuesto en Wikidata" %}

Para registrar apellidos hispanos, debes utilizar dos propiedades. La propiedad “apellido” (P734) se utiliza para registrar el apellido paterno, mientras que “segundo apellido” (P1950) designa el apellido materno.

Otra propiedad muy común en la descripción de personas es el “campo de trabajo” (P101). Esta propiedad permite designar la especialización o campo de estudio de una persona u organización. Se pueden registrar todos los valores que sean necesarios para describir adecuadamente los campos del saber o de actividad en los que se destaca una persona.

También podemos registrar la “ocupación” (P106) relacionada con el campo de trabajo. Esta propiedad admite valores múltiples y es útil para registrar las distintas facetas profesionales o artísticas de una persona. Recuerda que toda la información sobre personas debe provenir de fuentes confiables y accesibles. Dichas fuentes pueden registrarse como referencias en cada uno de los valores asociados a una propiedad. La Figura 15 muestra los valores para la propiedad de “ocupación”, junto con las referencias tomadas de un artículo de Wikipedia.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-15.png" alt="Visual description of figure image" caption="Figura 15. Valores para la propiedad de “ocupación” en Wikidata" %}

El registro de identificadores asociados a una persona es uno de los aspectos más importantes en Wikidata. Cada identificador asociado a una persona se registra como una propiedad individual. Por ejemplo, podemos registrar el número ORCID (P496), el identificador de Scopus (P1153), el identificador VIAF (P214), el ISNI (P213), o identificadores de bibliotecas como la Biblioteca del Congreso (P244) o la Biblioteca Nacional de España (P950). La Figura 16 muestra una serie de identificadores para la misma persona.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-16.png" alt="Visual description of figure image" caption="Figura 16. Identificadores asociados a una persona en Wikidata" %}

Estas son sólo algunas de las propiedades que se pueden utilizar en la creación de datos abiertos enlazados para personas en Wikidata. A continuación, se mencionan otras propiedades relevantes que pueden brindar información más detallada sobre una persona. Sin embargo, debemos ser cuidadosos al registrar información de personas vivas y perder de vista las consideraciones éticas relacionadas con la dignidad, seguridad y privacidad de las personas.

- Lugar de nacimiento (P19): para indicar el lugar en que nació la persona. Se debe indicar el lugar específico conocido.
- Fecha de nacimiento (P569): para indicar la fecha en la cual nació la persona.
- País de nacionalidad (P27): para indicar la ciudadanía de la persona. Si se opta por registrar esta propiedad, debes tener en cuenta que la ciudadanía es un término jurídico y no cultural; no necesariamente da cuenta de la procedencia cultural o étnica de una persona.
- Lenguas habladas, escritas o signadas (P1412): para indicar el idioma en que habla o escribe una persona.
- Afiliación (P1416): para indicar la organización a la cual una persona está afiliada.
- Empleador (P108): se usa para indicar la empresa u organización para la cual trabaja una persona. Es una subpropiedad de “afiliación”.
- Educado en (P69): para indicar la institución académica en la que estudió la persona.
- Sexo o género (P21): para indicar el sexo o género con el cual se identifica la persona. Es una propiedad que puede resultar controversial o significar una violación de privacidad, por lo que se recomienda cautela si se decide utilizar.

## Herramientas sugeridas para la descripción de elementos en Wikidata

Wikidata ofrece diferentes herramientas o accesorios para facilitar el trabajo. Las herramientas están disponibles en el menú de Preferencias, bajo la sección de Accesorios (Figura 17). Una herramienta útil para la creación y edición de entidades es Recoin (_Relative Completeness Indicator_) (Figura 18), que permite desplegar una lista en la página de la entidad con propiedades relevantes que podrías incluir. Esto es especialmente útil para usuarios nuevos que aún no están familiarizados con las propiedades en Wikidata.

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-17.png" alt="Visual description of figure image" caption="Figura 17. Menú de preferencias de Wikidata" %}

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-18.png" alt="Visual description of figure image" caption="Figura 18. Herramienta Recoin en Wikidata" %}

Una vez activada, la herramienta Recoin aparecerá en la página de la entidad. Puedes darle clic para ver la lista de propiedades relevantes que podrías incluir. A continuación, se muestran propiedades relevantes para la descripción de una persona (Figura 19).

{% include figure.html filename="es-or-estructurar-metadatos-academicos-con-wikidata-19.png" alt="Visual description of figure image" caption="Figura 19. Propiedades relevantes según la herramienta Recoin en Wikidata" %}

Si te interesa seguir aprendiendo y profundizando sobre este tema de los datos abiertos enlazados y Wikidata, te recomiendo [la lección de Gustavo Candela et al. (2021),](https://programminghistorian.org/es/lecciones/reutilizando-colecciones-digitales-glam-labs) que muestra cómo reutilizar colecciones digitales publicadas por instituciones de patrimonio cultural.

## Referencias

Ávila-Barrientos, Eder. (2022). Recuperación de información con Linked Open Data. _Investigación bibliotecológica_, _36_(91), 125-146. Epub 15 de noviembre de 2022. <http://rev-ib.unam.mx/ib/index.php/ib/article/view/58567>

Cadena López, Aydé, Ramos Luna, Lorena Litai, & Rivera González, Gibrán. (2022). Los datos abiertos en los estudios organizacionales: Reflexiones e implicaciones. _Trace (México, DF)_, (82), 41-65. Epub 02 de diciembre de 2022. <https://trace.org.mx/index.php/trace/article/view/819>

Cuba Rodríguez, Yariannis, & Olivera Batista, Dianelis. (2018). Los metadatos, la búsqueda y recuperación de información desde las Ciencias de la Información. _E-Ciencias de la Información_, _8_(2), 146-158. <https://dx.doi.org/10.15517/eci.v8i2.30085>

Daudinot Founier, Isabel. (2006). Organización y recuperación de información en Internet: teoría de los metadatos. _ACIMED_, _14_(5) Recuperado en 27 de febrero de 2024, de <http://scielo.sld.cu/scielo.php?script=sci_arttext&pid=S1024-94352006000500006&lng=es&tlng=es>

Torres Pombert, Ania. (2006). ¿Catalogación en el entorno digital?: una breve aproximación a los metadatos. _ACIMED_, _14_(5) Recuperado en 27 de febrero de 2024, de <http://scielo.sld.cu/scielo.php?script=sci_arttext&pid=S1024-94352006000500009&lng=es&tlng=es>

Werf, Titia van der. (2022). Gestión de la identidad del autor en la cadena del libro. Traducción de Francesc García Grimau. _Hanging Together: the OCLC Research Blog_. Recuperado en 15 de mayo de 2024, de <https://hangingtogether.org/gestion-de-la-identidad-del-autor-en-la-cadena-del-libro/>
