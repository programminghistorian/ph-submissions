---
title: "Instalando o QGIS e adicionando camadas"
slug: qgis-camadas
original: qgis-layers
layout: lesson
collection: lessons
date: 2013-12-13
translation_date: YYYY-MM-DD
authors:
- Jim Clifford
- Josh MacFadyen
- Daniel Macfarlane
reviewers:
- Finn Arne Jørgensen
- Sarah Simpkin
editors:
- Adam Crymble
translator:
- Luanna Kaori
translator-editor:
- Joana Vieira Paulino
translation-reviewers:
- Forename Surname
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/566
difficulty: 1
activity: presenting
topics: [mapping]
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}


## Objetivos da lição

Com essa lição, você poderá instalar o programa QGIS, baixar arquivos geoespaciais como shapefiles e GeoTIFFs, e criar um mapa a partir de um número de vetor e camadas raster. O Quantum, ou QGIS, é uma alternativa <open-source> para o líder da indústria, o ArcGIS da ESRI. O QGIS é uma multi-plataforma, o que lhe permite rodar no Windows, Mac e Linux, e conta com diversas das funções mais utilizadas por historiadores. O ArcGIS é proibitivamente caro e apenas funciona no Windows (apesar de que um software pode ser comprado para permitir seu funcionamento no Mac). Entretanto, várias universidades possuem licenças e sites, permitindo que alunos e funcionários tenham acesso a cópias gratuitas do programa (entre em contato com sua biblioteca de mapas, equipe de TI, ou o departamento de Geografia). O QGIS é ideal para aqueles sem acesso à cópia gratuita do Arc, e também é uma boa opção para aprender o básico de SIG e decidir se você quer ou não instalar uma cópia do ArcGIS na sua máquina. Além disso, qualquer trabalho realizado no QGIS pode ser exportado para o ArcGIS futuramente, caso opte por um upgrade. Os autores tendem a usar ambos programas, satisfeitos com o desempenho do QGIS para operações básicas em computadores Mac e Linux, mas ainda voltando-se ao ArcGIS para projetos mais avançados. Em diversos casos, não é uma deficiência de funções, mas problemas de estabilidades que nos levam de volta ao ArcGIS. Para aqueles aprendendo Python com o Programming Historian, vocês ficarão felizes em saber que tanto o QGIS quanto o ArcGIS usam o Python como seu principal idioma de codificação.

## Instalando QGIS

Abra [página de download do QGIS](https://qgis.org/pt_BR/site/forusers/download.html#). O processo varia um pouco dependendo do seu sistema operacional. Clique no Sistema Operacional adequado. Siga as instruções abaixo.


### Instrições para Mac

-  Clique no link de download. Para macOS, essa versão do QGIS requer o macOS High Sierra (10.13) ou mais recente.

{% include figure.html filename="pt-or-qgis-camadas-01.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 1. TEXTO DA LEGENDA" %}

-   Baixe e instale o QGIS.
-   Como os demais programas a serem utilizados pela primeira vez no Mac, você terá que encontrar o QGIS em Programas.

### Instruções para Windows

-   Clique no link para baixar o QGIS.

{% include figure.html filename="pt-or-qgis-camadas-02.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 2. TEXTO DA LEGENDA" %}

-   Clique-duplo no arquivo `.exe` para executá-lo

O QGIS é bastante simples de se instalar na maior parte das versões do Linux. Siga as instruções na página de download.

## Os dados de *Prince Edward Island*

Estaremos utilizando alguns dados governamentais da província canadense de Prince Edward Island. A PEI é um ótimo exemplo, pois conta com vários dados disponíveis online gratuitamente e porque é a menor província canadense, o que torna os downloads rápidos! Baixe os *shapefiles* da PEI:

-   Entre nos links abaixo em seu navegador, leia/aceite os termos de licenciamento, e então baixe os seguintes arquivos (será solicitado o seu nome e e-mail em cada download). Nós criamos os dois últimos *shapefiles*, então eles devem baixar automaticamente:

1.  [http://www.gov.pe.ca/gis/download.php3?name=coastline&file_format=SHP](http://www.gov.pe.ca/gis/download.php3?name=coastline&file_format=SHP)
2.  [http://www.gov.pe.ca/gis/download.php3?name=lot_town&file_format=SHP](http://www.gov.pe.ca/gis/download.php3?name=lot_town&file_format=SHP)
3.  [http://www.gov.pe.ca/gis/download.php3?name=hydronetwork&file_format=SHP](http://www.gov.pe.ca/gis/download.php3?name=hydronetwork&file_format=SHP)
4.  [http://www.gov.pe.ca/gis/download.php3?name=forest_35&file_format=SHP](http://www.gov.pe.ca/gis/download.php3?name=forest_35&file_format=SHP)
5.  [http://www.gov.pe.ca/gis/download.php3?name=nat_parks&file_format=SHP](http://www.gov.pe.ca/gis/download.php3?name=nat_parks&file_format=SHP)
6.  [PEI Highways](https://programminghistorian.org/assets/PEI_highway.zip)
7.  [PEI Places](https://programminghistorian.org/assets/PEI_placenames.zip)

-   Após baixar os sete arquivos, coloque-os em uma pasta e descomprima os arquivos .zip. Confira o conteúdo das pastas. Você irá encontrar quatro arquivos com o mesmo nome, mas sendo de formatos diferentes. Quando você abrir essas pastas no programa SIG, você perceberá que é necessário apenas clicar no arquivo .shp e que os outros três formatos sejam compatíveis com esse arquivo no plano de fundo. Ao mover os arquivos em seu computador, é sempre importante manter os quatro arquivos juntos. Esse é o único porquê de Shapefiles serem normalmente compartilhados comprimidos em zip. Lembre-se em qual pasta você salvou as pastas shapefile descomprimidas, já que você precisará encontrá-las dentro do QGIS em alguns minutos.

## Criando o seu projeto SIG

Abra o QGIS. A primeira coisa que precisamos é configurar o Sistema De Referenciamento Coordenado (SRC) corretamente. O SRC é a projeção do mapa e as projeções são as diversas formas de representar lugares reais em mapas bidimensionais. A projeção padrão é WGS84 (está sendo cada vez mais comum utilizar WGS 84, que é compatível com softwares tipo Google Earth), mas já que a maior parte de nossos dados e exemplos são criados pelos governos canadenses, nós recomendamos utilizar NAD 83 (North American Datum, 1983). Para mais informações acerca do NAD 83 e o datum do Governo Federal, consulte o [site do NRCan](http://www.nrcan.gc.ca/earth-sciences/geography-boundary/mapping/topographic-mapping/10272). PA PEI tem seu próprio sistema de referenciamento coordenado NAD 83, que utiliza uma [Dupla projeção Estereográfica](http://www.gov.pe.ca/gis/index.php3?number=77865&lang=E). Administrar o SRC de diferentes camadas informacionais e garantir que estejam funcionando corretamente é um dos mais complicados aspectos do SIG para iniciantes. De qualquer forma, se o software estiver configurado corretamente, ele deve converter o SRC e permitir o manuseio de dados importados de diferentes fontes. *Selecione Propriedades*

-   Windows: Projeto —> Propriedades


{% include figure.html filename="pt-or-qgis-camadas-03.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 3. TEXTO DA LEGENDA" %}

-  No painel esquerdo, selecione SRC (quarta opção de cima para baixo)
-  Na barra de pesquisa Filtro, digite ‘2291’ — isso funciona como um atalho para o melhor Sistema de referenciamento coordenado para Prince Edward Island
-   Abaixo da janela intitulada Sistemas de referenciamento coordenados mundiais, selecione ‘NAD83(CSRS98) / Prince Edward Isl. (Stereographic)’ e pressione OK.

{% include figure.html filename="pt-or-qgis-camadas-04.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 4. TEXTO DA LEGENDA" %}

-   Perceba que a projeção mudou no canto inferior direito da janela do QGIS. Próximo a ela, você verá a localização geográfica do seu cursor em metros
-   Abaixo do Menu do projeto, selecione Salvar Projeto (é recomendado salvar seu projeto após cada etapa)

Agora você está pronto para trabalhar no projeto de tutorial, mas pode ser que tenha algumas perguntas sobre qual SRC utilizar para o seu próprio projeto. O WGS83 pode funcionar a curto prazo, principalmente se você estiver trabalhando em uma escala consideravelmente maior, mas apresentará dificuldades em trabalhar para mapas locais. Uma dica é aprender quais SRC ou Projeções são utilizadas em mapas físicos da região. Se você estiver escaneando um mapa físico de alta qualidade para utilizar como camada base, pode ser uma boa ideia utilizar a mesma projeção. Você também pode tentar buscar na internet quais os SRCs mais comuns para determinada região. Para aqueles trabalhando em projetos norte americanos, identificar o NAD83 correto par a sua região vai ser, geralmente, o melhor SRC. Aqui estão alguns links para outros recursos que lhe ajudarão a escolher um SRC para o seu próprio projeto: [Tutorial: Trabalhando com Projeções](http://web.archive.org/web/20180715071501/http://www.qgistutorials.com/pt_BR/docs/working_with_projections.html)

### Construindo um mapa base

Agora que seu computador está navegando na direção certa, está na hora de adicionar alguns dados que fazem sentido para humanos. O seu projeto deve começar com um mapa base, ou uma seleção de informação geo-espacial que permite que seus leitores reconheçam traços do mundo real no mapa. Para a maior parte dos usuários, isso será composto por várias “camadas” de vetor e dados raster, que podem ser reorganizadas, coloridas, e identificadas de uma maneira que faça sentido para os seus leitores e para os objetivos do seu projeto. Um recurso relativamente novo em diversos programas SIGs é a disponibilidade de mapas base pré-prontos, mas já que essa tecnologia está sob desenvolvimento para plataformas de código aberto, como o QGIS, iremos, nesse módulo, passar pelo processo de criar o nosso próprio mapa base adicionando vetores e camadas raster. Para aqueles que desejarem adicionar mapas base pré-prontos ao QGIS, pode-se tentar instalar o plugin “OpenLayers” em Plugins -> Administrar e Instalar plugins. Selecione “Adicionar Outros” à esquerda. Clique OpenLayers e então Instalar plugin. Clique OK e depois feche a aba. Uma vez instalado, você encontrará o OpenLayers no menu de plugins. Tente instalar alguns das várias camadas Google e OpenStreetMaps. Na data da produção desse módulo, o plugin OpenLayers (v. 1.1.1) pode ser instalado, mas não funciona corretamente em computadores Mac utilizando OSX. Aparentemente, ele funciona mais consistentemente no QGIS instalado no Windows 7. Dê-lhe uma chance, pois esperamos que seu funcionamento vai apenas melhorar nos próximos meses. Tenha em mente, porém, que a projeção para alguns desses mapas globais não se corrige automaticamente, então as imagens de satélite podem nem sempre sincronizar com os dados projetados em um SRC diferente.

## Abrindo vetores

[Definindo](http://www.gislounge.com/geodatabases-explored-vector-and-raster-data/)vetores: o SIG utiliza pontos, linhas e polígonos, também conhecidos como dados vetoriais. Sua principal função é organizar esses pontos, linhas e polígonos, e projetá-los com precisão sobre os mapas. Os pontos podem ser cidades ou postes de telefone; as linhas podem representar rios, estradas ou ferrovias; e os polígonos podem compreender o terreno de uma fazenda ou fronteiras políticas maiores. No entanto, também é possível atribuir dados históricos a esses espaços geográficos e estudar como as pessoas interagiam com os seus ambientes e como mudavam-nos. A população das cidades mudaram, os rios desviaram seu rumo, terrenos foram divididos e nas terras se cultivaram diversas plantações.

-   No menu Camada, na barra de ferramentas, selecione Adicionar Camada e então Adicionar Camada Vetorial (também pode-se usar o comando Ctrl + Shift + V)

{% include figure.html filename="pt-or-qgis-camadas-05.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 5. TEXTO DA LEGENDA" %}

-  Clique em ‘...’, e encontre os seus shapefiles *Prince Edward Island*
-   Abra a pasta coastline_polygon

{% include figure.html filename="pt-or-qgis-camadas-06.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 6. TEXTO DA LEGENDA" %}

-   Selecione coastline_polygon.shp, e então clique OK, e a costa da ilha deve aparecer na sua tela. Às vezes, o QGIS adiciona um fundo colorido (veja a imagem acima). Caso este seja o seu caso, siga as etapas abaixo. Caso não, pule para \*\*\*.
-   Clique com o mouse direito na camada (coastline_polygon) no menu de camadas e selecione Propriedades.

{% include figure.html filename="pt-or-qgis-camadas-07.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 7. TEXTO DA LEGENDA" %}

-   Na janela que abrir, clique em Simbologia no painel esquerdo
-   Existe uma variedade de opções, mas queremos nos livrar completamente do plano de fundo. Clique em **Preenchimento simples**.

{% include figure.html filename="pt-or-qgis-camadas-08.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 8. TEXTO DA LEGENDA" %}

-   Em seguida, selecione **Sem Pincel** no menu **Estilo de preenchimento**. **Clique em OK**

{% include figure.html filename="pt-or-qgis-camadas-09.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 9. TEXTO DA LEGENDA" %}

\*\*\*

- Selecione Adicionar Camada Vetorial novamente.
- clique em Navegação, encontre os shapefiles de Prince Edward Island baixos na pasta
- selecione ‘PEI_HYDRONETWORK’
- clique em ‘PEI_HYDRONETWORK.shp’ e então em ‘Abrir’
- com um clique-direito na camada, no menu de Camadas, e então selecione Propriedades.
- selecione a aba Simbologia, e escolha um tom de azul adequado para colorir o hydronetwork e clique ‘OK’ no canto inferior direito da janela

{% include figure.html filename="pt-or-qgis-camadas-10.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figure 10. TEXTO DA LEGENDA" %}

-   O seu mapa deve estar assim:

{% include figure.html filename="pt-or-qgis-camadas-11.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 11. TEXTO DA LEGENDA" %}

- Selecione Adicionar Camada Vetorial novamente.
- clique em Navegação, encontre os seus shapefiles de Prince Edward Island baixados na pasta
- clique-duplo em ‘1935 inventory_region.shp’ e então em ‘Abrir’

Isso irá adicionar um mapa denso, mostrando as diferentes coberturas florestais em 1935. Entretanto, para consultar as diferentes categorias, você terá que trocar a simbologia para representar os diferentes tipos de florestas com cores diferentes. Nós teremos que saber qual coluna das tabelas de banco de dados inclui as informações de categorias florestais, então o primeiro passo é abrir e examinar a tabela de atributos.

-   clique-direito na camada 1935_inventory_region na janela Camadas à esquerda, e clique em Abrir Tabela de Atributos

{% include figure.html filename="pt-or-qgis-camadas-12.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 12. TEXTO DA LEGENDA" %}

Uma Tabela de Atributos será aberta. Ela contém um número de categorias e identificadores. Aqui pertinente é a categoria LANDUSE, que nos dá informações sobre as coberturas florestais em 1935. Nós iremos demonstrar como <projetar> essas categorias no mapa.

{% include figure.html filename="pt-or-qgis-camadas-13.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 13. TEXTO DA LEGENDA" %}

-  Feche a Tabela de Atributos, e novamente dê um clique-direito na camada 1935_invetory_region, e dessa vez selecione Propriedades (ou então, para o atalho, dê um clique-duplo na camada 1935_inventory_region).
- clique em Simbologia do lado esquerdo

{% include figure.html filename="pt-or-qgis-camadas-14.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 14. TEXTO DA LEGENDA" %}

-   No menu 'Símbolo Simples', selecione 'Categorizado'

{% include figure.html filename="pt-or-qgis-camadas-15.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 15. TEXTO DA LEGENDA" %}

- Na barra 'Valor', selecione ‘Landuse’
- No dropdown 'Gradiente de Cores', selecione 'Greens'
- clique em ‘Classificar’ abaixo e à esquerda
- na coluna Símbolos, selecione o quadrado com o verde mais escuro (sem Valor ao seu lado) e clique no botão ‘-’ (à direita de Classificar); também delete a categoria Developed, já que queremos destacar as áreas florestais. Clique em ‘OK’

{% include figure.html filename="pt-or-qgis-camadas-16.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 16. TEXTO DA LEGENDA" %}

- No menu da barra lateral Camadas, clique na pequena flecha ao lado de 1935_inventory_region para visualizar a legenda.
- Agora, você pode ver a extensão das florestas em 1935. Experimente usar a ferramenta Lupa para dar zoom e inspecionar os diferentes LANDUSES.

{% include figure.html filename="pt-or-qgis-camadas-17.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 17. TEXTO DA LEGENDA" %}

- Para voltar ao mapa completo, dê um clique-direito em qualquer uma das camadas e selecione <‘Zoom to Layer Extent’>.


{% include figure.html filename="pt-or-qgis-camadas-18.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 18. TEXTO DA LEGENDA" %}

- Em seguida, iremos adicionar uma camada de estradas.
- sob Camada na barra de ferramentas, selecione Adicionar Camada Vetorial
- clique em Navegação, encontre os seus shapefiles de Prince Edward Island baixados na pasta
- selecione ‘PEI_highway.shp’
- no menu de Camadas à esquerda, dê um clique-duplo em ‘PEI_highway_ship’ e selecione Estilo no meno à esquerda (se já não estiver selecionado)
- clique em 'Símbolo Simples' no topo esquerdo e selecione 'Categorizado'
- ao lado de Valor, selecione ‘TYPE’
- clique em Classificar

{% include figure.html filename="pt-or-qgis-camadas-19.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 19. TEXTO DA LEGENDA" %}

- na coluna Símbolo, dê um clique-duplo ao lado de ‘primary’ — na janela subsequente, há uma caixa com diferentes símbolos. Desça a página e encontre 'topo main road'.
- Você está de volta na janela Estilo. Repita o processo para o item nomeado ‘primary_link’.

{% include figure.html filename="pt-or-qgis-camadas-20.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 20. TEXTO DA LEGENDA" %}

- clique em Símbolo ao lado de <secondary> e troque a cor para preto e a largura para 0.7
- Repita o processo para o link secundário
- clique em OK. Agora, você terá as rodovias e outras estradas principais representadas no mapa

{% include figure.html filename="pt-or-qgis-camadas-21.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 21. TEXTO DA LEGENDA" %}

- Em Camada, sob a barra de ferramentas, selecione Adicionar Camada Vetorial
- clique em '...' e encontre os seus shapefiles de Prince Edward Island baixados na pasta.
- selecione ‘PEI_placenames_shp’
- dê um clique-duplo em ‘PEI_placenames’ e selecione ‘Abrir’
- na aba Camadas, dê um clique duplo na camada PEI_placenames. Selecione a aba Rótulos no lado esquerdo (embaixo de Simbologia). No topo, selecione 'Rótulos Individuais' e na janela seguinte, em 'Valor', selecione 'Placenames'

{% include figure.html filename="pt-or-qgis-camadas-22.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 22. TEXTO DA LEGENDA" %}

- Troque o tamanho da fonte para ‘18’
- Clique em ‘OK’ e veja o resultado no mapa

{% include figure.html filename="pt-or-qgis-camadas-23.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 23. TEXTO DA LEGENDA" %}

- Catalogar é um dos pontos fracos do QGIS em comparação à cartografia verdadeira — será preciso ajustar as configurações para projetar os detalhes desejados para a apresentação. Experimente voltar à aba de <Labels> e trocar as diferentes configurações para ver como os símbolos e projeções mudam.

Tenha em mente que no menu de Camadas é possível adicionar ou remover as diversas camadas que adicionamos ao mapa da mesma forma que fizemos no Google Earth. Clique nas caixas de verificação para remover e adicionar as várias camadas. Arraste e solte camadas para mudar a ordem na qual aparecem. Arrastar uma camada para o topo vai colocá-la acima das demais camadas e torná-la a mais proeminente. Por exemplo, se você arrastar ‘coastline_polygon’ para o topo, você terá um contorno simplificado da província, junto com os nomes dos lugares.

{% include figure.html filename="pt-or-qgis-camadas-24.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 24. TEXTO DA LEGENDA" %}

- Ao longo da barra de ferramentas no canto superior esquerdo da janela principal existem ícones que te permitem explorar o mapa. O símbolo de mão, por exemplo, permite-lhe clicar no mapa e movê-lo, enquanto os símbolos de lupa com um mais e um menos lhe permitem aumentar ou diminuir o zoom. Brinque com essas ferramentas e se familiarize com as diversas funções

{% include figure.html filename="pt-or-qgis-camadas-25.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 25. TEXTO DA LEGENDA" %}

- após criar o mapa utilizando camadas vetoriais, agora nós iremos adicionar ou utilizar a nossa primeira camada <raster>. Esse é um bom momento para salvar o seu progresso.

**Abrindo camadas raster**: dados **raster** são imagens digitais quadriculadas. Todos os dados de detecção remota, como imagens de satélite ou fotos aéreas, são rasters, mas geralmente não se pode enxergar o quadriculado dessas imagens, pois elas são compostas por pequenos píxeis. Cada píxel tem o seu próprio valor e, quando esses valores estão simbolizados em cores ou em greyscale, eles compõem uma figura útil para projeção ou para análise topográfica. Um mapa histórico escaneado também é trazido para o SIG em formato raster.

- baixe: [PEI_CumminsMap1927.tif](https://programminghistorian.org/assets/PEI_CumminsMap1927_compLZW.tif) para a pasta do seu projeto
- embaixo de Camada na barra de ferramentas, selecione Adicionar Camada Raster

{% include figure.html filename="pt-or-qgis-camadas-26.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 26. TEXTO DA LEGENDA" %}

- encontre o arquivo baixado com o nome ‘PEI_CumminsMap1927.tif’
- será solicitado que você defina o sistema de coordenadas dessa camada. Na opção Filtro, busque por ‘2291’, e então na seção abaixo, selecione ‘NAD83(CSRS98) / Prince Edward Isl. (Stereographic)...’

{% include figure.html filename="pt-or-qgis-camadas-27.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 27. TEXTO DA LEGENDA" %}

- Caso o programa não solicite o SRC, você terá que modificá-lo por conta própria. Dê um clique-duplo na camada PEI_CummingMap1927_compLZQ e selecione 'Fonte' no menu à esquerda. No dropdown, selecione 'NAD83(CSRS98) / Prince Edward Isl. Stereographic (NAD83)'

{% include figure.html filename="pt-or-qgis-camadas-28.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 28. TEXTO DA LEGENDA" %}

- Na janela de camadas, o mapa deve estar abaixo do dado vetorial. Se necessário, desloque-o para o final do menu:

{% include figure.html filename="pt-or-qgis-camadas-29.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 29. TEXTO DA LEGENDA" %}

- Agora, para aumentar a visibilidade da costa, dê um clique-duplo em ‘coastline_polygon’ e selecione ‘Simbologia’ à esquerda. Na caixa Preenchimento, clique em 'Preenchimento Simples' e opções vão aparecer na caixa à direita. Clique no menu ao lado de 'Cor do traço' e coloque a cor vermelho, em seguida, ao lado de Largura do traço, mude para 0.5, e clique OK.

{% include figure.html filename="pt-or-qgis-camadas-30.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 30. TEXTO DA LEGENDA" %}

- Agora, será possível ver o fundo do mapa raster através da camada ‘coastline_polygon’. Aumente o zoom para uma inspeção mais detalhada, e será possível ver claramente a camada da costa. Perceba como o alinhamento, apesar de bom, não está perfeito. Iremos discutir, na lição 4, sobre os desafios de georreferenciar mapas históricos para dar a eles coordenadas reais.

{% include figure.html filename="pt-or-qgis-camadas-31.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 31. TEXTO DA LEGENDA" %}

<div class="alert alert-info">
Você aprendeu a instalar o QGIS e a adicionar camadas. Certifique-se de salvar o seu trabalho!
</div>

*Essa lição é parte do [Geospatial Historian](https://geospatialhistorian.wordpress.com/).*
