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

Com essa lição, você poderá instalar o programa QGIS, baixar ficheiros geoespaciais como shapefiles e GeoTIFFs, e criar um mapa a partir de diversas camadas vetoriais e raster. O Quantum, ou QGIS, é uma alternativa em código aberto para o líder da indústria, o ArcGIS da ESRI. O QGIS é multi-plataformas, o que lhe permite funcionar no Windows, Mac e Linux, e conta com diversas das funções mais utilizadas por historiadores. O ArcGIS é proibitivamente caro e apenas funciona no Windows (apesar de que um software pode ser comprado para permitir seu funcionamento no Mac). Entretanto, várias universidades  possuem licenças, permitindo que alunos e funcionários tenham acesso a cópias gratuitas do programa (entre em contato com o seu bibliotecário da área de cartografia, equipe de TI, ou o departamento de Geografia). O QGIS é ideal para aqueles sem acesso à cópia gratuita do Arc, e também é uma boa opção para aprender o básico de SIG e decidir se você quer ou não instalar uma cópia do ArcGIS no seu computador. Além disso, qualquer trabalho realizado no QGIS pode ser exportado para o ArcGIS futuramente, caso opte por um upgrade. Os autores tendem a usar ambos programas, satisfeitos com o desempenho do QGIS para operações básicas em computadores Mac e Linux, mas ainda voltam ao ArcGIS para projetos mais avançados. Em diversos casos, não é uma deficiência de funções, mas problemas de estabilidade que nos levam de volta ao ArcGIS. Para aqueles aprendendo Python com o Programming Historian, vocês ficarão felizes em saber que, tanto o QGIS quanto o ArcGIS, usam o Python como sua principal linguagem de programação.

## Instalando QGIS

Abra a [página de download do QGIS](https://qgis.org/pt_BR/site/forusers/download.html#). O processo varia um pouco dependendo do seu sistema operacional. Clique no Sistema Operacional adequado. Siga as instruções abaixo.


### Instruções para Mac

-  Clique no link de download. Para macOS, essa versão do QGIS requer o macOS High Sierra (10.13) ou mais recente.

{% include figure.html filename="qgis1.png" caption="Figura 1" %}

-   Baixe e instale o QGIS.
-   Como os demais programas a serem utilizados pela primeira vez no Mac, você terá que encontrar o QGIS em Programas.

### Instruções para Windows

-   Clique no link para baixar o QGIS

{% include figure.html filename="qgis2.jpg" caption="Figura 2" %}

-   Clique-duplo no ficheiro `.exe` para executá-lo

O QGIS é bastante simples de se instalar na maior parte das versões do Linux. Siga as instruções na página de download.

## Os dados de *Prince Edward Island*

Estaremos utilizando alguns dados governamentais da província de Prince Edward Island (PEI), no Canadá. A PEI é um ótimo exemplo, pois conta com vários dados disponíveis online gratuitamente e porque é a menor província canadense, o que torna os downloads rápidos! Baixe os *shapefiles* da PEI:

-   Entre nos links abaixo em seu navegador. Desenvolvemos os dois últimos *shapefiles*, então eles devem baixar automaticamente:

1.  <http://www.gov.pe.ca/gis/download.php3?name=coastline&file_format=SHP>
2.  <http://www.gov.pe.ca/gis/download.php3?name=lot_town&file_format=SHP>
3.  <http://www.gov.pe.ca/gis/download.php3?name=hydronetwork&file_format=SHP>
4.  <http://www.gov.pe.ca/gis/download.php3?name=forest_35&file_format=SHP>
5.  <http://www.gov.pe.ca/gis/download.php3?name=nat_parks&file_format=SHP>
6.  [PEI Highways](https://programminghistorian.org/assets/PEI_highway.zip)
7.  [PEI Places](https://programminghistorian.org/assets/PEI_placenames.zip)

-   Após baixar os sete ficheiros, coloque-os em uma pasta e descomprima os ficheiros .zip. Confira o conteúdo das pastas. Você irá encontrar quatro ficheiros com o mesmo nome, mas sendo de formatos diferentes. Quando você abrir essas pastas no programa SIG, você perceberá que é necessário apenas clicar no ficheiro .shp e que os outros três formatos apenas dão suporte a esse ficheiro em plano de fundo. Ao mover os ficheiros em seu computador, é sempre importante manter os quatro ficheiros juntos. Esta é uma das razões dos Shapefiles serem normalmente compartilhados comprimidos em zip. Lembre-se em qual pasta você salvou as pastas shapefile não comprimidas, já que será necessário encontrá-las a partir do QGIS em alguns minutos.

## Criando o seu projeto SIG

Abra o QGIS. A primeira coisa que precisamos fazer é configurar o Sistema De Referenciamento Coordenado (SRC) corretamente. O SRC (Coordenate Reference System (CRS), em inglês) é a projeção cartográfica e as projeções são as diversas formas de representar lugares do mundo real em mapas bidimensionais. A projeção padrão é WGS84 (está sendo cada vez mais comum utilizar WGS 84, que é compatível com softwares como o Google Earth), mas já que a maior parte de nossos dados e exemplos são criados pelos governos canadenses, nós recomendamos utilizar NAD 83 (North American Datum, 1983). Para mais informações acerca do NAD 83 e o datum do Governo Federal, consulte o [site do NRCan](http://www.nrcan.gc.ca/earth-sciences/geography-boundary/mapping/topographic-mapping/10272) (em inglês). A PEI tem seu próprio sistema de referência de coordenadas NAD 83, que utiliza uma [projeção Estereográfica Dupla](http://www.gov.pe.ca/gis/index.php3?number=77865&lang=E) (em inglês). Administrar o SRC de diferentes camadas de informação e garantir que estejam funcionando corretamente é um dos mais complicados aspectos do SIG para iniciantes. De qualquer forma, se o software estiver configurado corretamente, ele deve converter o SRC e permitir o manuseio de dados importados de diferentes fontes. *Selecione Propriedades do Projeto*

-   Windows: Projeto —> Propriedades


{% include figure.html filename="qgis4.png" caption="Figura 3" %}

-  No painel esquerdo, selecione SRC (quarta opção de cima para baixo)
-  Na barra de pesquisa Filtro, digite ‘2291’ — isso funciona como um atalho para o melhor Sistema de referenciamento coordenado para Prince Edward Island
-   Selecione 'NAD83(CSRS98)' / Prince Edward Isl. (Stereographic)’ e pressione OK.

{% include figure.html filename="qgis5.png" caption="Figura 4" %}

-   Perceba que a projeção mudou no canto inferior direito da janela do QGIS. Próximo a ela, você verá a localização geográfica do seu cursor em metros
-  Na janela Projeto, selecione Salvar Projeto (é recomendado salvar seu projeto após cada etapa)

Agora você está pronto para trabalhar no projeto de tutorial, mas pode ser que tenha algumas perguntas sobre qual SRC utilizar para o seu próprio projeto. O WGS83 pode funcionar a curto prazo, principalmente se você estiver trabalhando em uma escala consideravelmente maior, mas apresentará dificuldades em trabalhar com precisão em mapas locais. Uma dica é saber quais SRC ou Projeções são utilizados para os mapas em papel da região. Caso digitalize um mapa físico de alta qualidade para utilizar como camada base, pode ser uma boa ideia utilizar a mesma projeção. Pode-se também tentar buscar na internet quais os SRC mais comuns para determinada região. Para aqueles trabalhando em projetos norte americanos, identificar o NAD83 correto par a sua região vai ser, geralmente, o melhor SRC. Aqui estão alguns links para outros recursos que lhe ajudarão a escolher um SRC para o seu próprio projeto: [Tutorial: Trabalhando com Projeções no QGIS](http://web.archive.org/web/20180715071501/http://www.qgistutorials.com/pt_BR/docs/working_with_projections.html) (em inglês).

### Construindo um mapa base

Agora que seu computador está navegando na direção certa, está na hora de adicionar alguns dados que fazem sentido para humanos. O seu projeto deve começar com um mapa base, ou uma seleção de informação geoespacial que permite que seus leitores reconheçam traços do mundo real no mapa. Para a maior parte dos usuários, isso será composto por várias "camadas" de dados vetor e raster, que podem ser reorganizados, coloridos e identificados de forma que faça sentido para os seus leitores e para os objetivos do seu projeto. Um recurso existente em diversos programas SIG é a disponibilidade de mapas base pré-fabricados, mas para este módulo iremos passar pelo processo de criar o nosso próprio mapa base adicionando camadas vetoriais e raster. Para aqueles que desejarem adicionar mapas base pré-prontos ao QGIS, pode-se tentar instalar o plugin “OpenLayers” em Plugins ("Módulos" em PT-PT) -> Administrar e Instalar plugins ("Gerir e instalar módulos" em PT-PT). Selecione “Adicionar Outros” à esquerda. Clique OpenLayers e então Instalar plugin. Clique OK e depois feche a aba. Uma vez instalado, você encontrará o OpenLayers no menu de plugins. Tente instalar alguns das várias camadas Google e OpenStreetMaps. Tenha em mente, porém, que a projeção para alguns desses mapas globais não se corrige automaticamente, portanto as imagens de satélite podem nem sempre coincidir com os dados projetados em um SRC diferente.

### Abrindo vetores

[Definição](http://www.gislounge.com/geodatabases-explored-vector-and-raster-data/) de vetores: o SIG utiliza pontos, linhas e polígonos, também conhecidos como dados vetoriais. A sua primeira ordem de trabalho é organizar esses pontos, linhas e polígonos e projetá-los com precisão nos mapas. Os pontos podem ser cidades ou postes de telefone; as linhas podem representar rios, estradas ou ferrovias; e os polígonos podem compreender o terreno de uma fazenda ou fronteiras políticas maiores. No entanto, também é possível associar dados históricos com esses espaços geográficos e estudar como as pessoas interagiam e alteraram os seus ambientes físicos. No entanto, também é possível associar dados históricos com esses espaços geográficos e estudar como as pessoas interagiam e alteraram os seus ambientes físicos. A população das cidades mudou, os rios mudaram os seus cursos, os terrenos foram subdivididos e as terras foram plantadas com várias culturas.

-   No menu Camada, na barra de ferramentas, selecione Adicionar Camada e então Adicionar Camada Vetorial (também pode-se usar o comando Ctrl + Shift + V)

{% include figure.html filename="qgis6.png" caption="Figura 5" %}

-  Clique em ‘...’, e encontre os seus shapefiles *Prince Edward Island*
-   Abra a pasta coastline_polygon

{% include figure.html filename="qgis7.png" caption="Figura 6" %}

-   Selecione coastline_polygon.shp, e então clique OK, e a costa da ilha deve aparecer na sua tela. Às vezes, o QGIS adiciona um fundo colorido (veja a imagem acima). Caso este seja o seu caso, siga as etapas abaixo. Caso não, pule para \*\*\*. 
-   Para a versão PT-PT do QGIS, após selecionar coastline_polygon.shp, clique em "Abrir", e então em "Adicionar" para adicionar a camada.
-   Clique no botão direito do mouse na camada (coastline_polygon) no menu de camadas e selecione Propriedades.

{% include figure.html filename="qgis8.png" caption="Figura 7" %}

-   Na janela que abrir, clique em Simbologia no painel esquerdo
-   Existe uma variedade de opções, mas o que pretendemos é eliminar totalmente o fundo. Clique em **Preenchimento simples** ("Sem preenchimento" em PT-PT).

{% include figure.html filename="qgis9.png" caption="Figura 8" %}

-   Em seguida, selecione **Sem Pincel (Sem Preenchimento, em PT-PT)** no menu **Estilo de preenchimento**. **Clique em OK**

{% include figure.html filename="qgis10.png" caption="Figura 9" %}

\*\*\*

- Selecione Adicionar Camada Vetorial novamente.
- clique em '...' e encontre os shapefiles de Prince Edward Island baixos na pasta
- selecione ‘PEI_HYDRONETWORK’
- clique em ‘PEI_HYDRONETWORK.shp’ e então em ‘Abrir’ (na versão PT-PT do QGIS, será preciso em seguida clicar em 'Adicionar')
- com um clique-direito na camada, no menu de Camadas, e então selecione Propriedades.
- selecione a aba Simbologia, e escolha um tom de azul adequado para colorir a hydronetwork (rede hidráulica) e clique ‘OK’ no canto inferior direito da janela

{% include figure.html filename="qgis11.png" caption="Figure 10" %}

-   O seu mapa deve estar assim:

{% include figure.html filename="qgis12.png" caption="Figura 11" %}

- Selecione Adicionar Camada Vetorial novamente.
- clique em Navegação, encontre os seus shapefiles de Prince Edward Island baixados na pasta
- clique-duplo em ‘1935 inventory_region.shp’ e então em ‘Abrir’ (na versão PT-PT do QGIS, será preciso em seguida clicar em 'Adicionar').

Isso irá adicionar um mapa denso, mostrando as diferentes coberturas florestais em 1935. Porém, para consultar as diferentes categorias, você terá que trocar a simbologia para representar os diferentes tipos de florestas com cores diferentes. Será necessário saber qual a coluna das tabelas de base de dados que inclui as informações de categorias florestais, então o primeiro passo é abrir e examinar a tabela de atributos.

-   Clique com o botão direito do mouse na camada 1935_inventory_region na janela “Camadas, e clique em Abrir Tabela de Atributos

{% include figure.html filename="qgis13.png" caption="Figura 12" %}

Uma Tabela de Atributos será aberta. Ela tem uma série de categorias e identificadores. De particular interesse é a categoria “LANDUSE” (land use, ou seja, uso da terra em português), que fornece informações sobre a cobertura florestal em 1935. Iremos agora demonstrar como visualizar essas categorias no mapa.

{% include figure.html filename="qgis14.png" caption="Figura 13" %}

-  Feche a Tabela de Atributos, e e clique novamente com o botão direito do mouse na camada 1935_inventory_region e, desta vez, selecione Propriedades (em alternativa, como atalho, pode fazer duplo clique na camada 1935_inventory_region) 1935_inventory_region).
- clique em Simbologia do lado esquerdo

{% include figure.html filename="qgis15.png" caption="Figura 14" %}

-   na barra de menu em que se lê “Símbolo simples” ("Símbolo único" em PT_PT), selecione "Categorizado”
-   Na barra 'Valor', selecione ‘LANDUSE’


{% include figure.html filename="qgis16.png" caption="Figura 15" %}

- no menu da barra “Gradiente de Cores” (“Rampa de cores” em PT-PT), selecione ‘Greens’
- clique em ‘Classificar’ abaixo e à esquerda
- Na coluna “Símbolo”, selecione o quadrado com a cor verde mais escura mais abaixo (sem qualquer valor ao lado) e clique no sinal “-“(a vermelho à direita de “Classificar”); elimine também a categoria “DEVELOPED”(desenvolvido/urbanizado em português), uma vez que pretendemos destacar as zonas florestais. Clique em ‘OK’

{% include figure.html filename="qgis17.png" caption="Figura16" %}

-   Caso não esteja ainda visível, em “Camadas”, clique no pequeno triângulo preto ao lado da camada 1935_inventory_region para visualizar a legenda.
-   Agora, você pode ver a extensão das florestas em 1935. Experimente usar a ferramenta Lupa para dar zoom e inspecionar os diferentes usos da terra (LANDUSES).

{% include figure.html filename="qgis18" caption="Figura 17" %}

-   “Para voltar ao mapa inteiro da ilha, dê um clique-direito em qualquer uma das camadas e selecione "Aproximar para camada(s)" (“Zoom to Layer(s)” na versão em PT-PT)


{% include figure.html filename="qgis19.png" caption="Figura 18" %}

- Em seguida, iremos adicionar uma camada de estradas.
- Selecione de novo Adicionar Camada Vetorial
- clique em “…” e encontre os shapefiles de Prince Edward Island baixados na pasta
- selecione ‘PEI_highway.shp’ e clique em "Adicionar"
- Em “Camadas”, faça clique-duplo em “PEI_highway”, e de seguida selecione “Simbologia” à esquerda (se ainda não estiver selecionado)
- na barra de menu em que se lê “Símbolo simples” ("Símbolo único" em PT-PT), selecione "Categorizado"
- Na barra ‘Valor’, selecione “TYPE” (tipo em português)
- clique em Classificar

{% include figure.html filename="qgis20.png" caption="Figura 19" %}

-   na coluna Símbolo, dê um clique-duplo no símbolo da linha ao lado de ‘primary’ (primário em português) – na janela seguinte, há uma caixa com diferentes símbolos. Desça a página e encontre ‘topo main road’ (“topologia estrada principal” em português). Clique “OK”.
- Está de volta à janela “Simbologia”. Repita o processo para o item nomeado 'primary_link' (ligação primária em português) na coluna “legenda”.
- Faça duplo-clique no símbolo ao lado de ‘secondary’ (secundário em português) e altere a cor para preto e a espessura/largura para 0,7.

{% include figure.html filename="qgis21.png" caption="Figura 20" %}

- Repita o processo para ‘secondary link’ (ligação secundária em português)
- clique em OK. Agora, você terá as rodovias e outras estradas principais representadas no mapa

{% include figure.html filename="qgis22.png" caption="Figura 21" %}

- Escolha de novo “Adicionar Camada Vetorial
- clique em '...' e encontre os seus shapefiles de Prince Edward Island baixados na pasta.
- selecione ‘PEI_placenames_shp’
- dê um clique-duplo em ‘PEI_placenames’ e depois clique em “Adicionar”
- Em “Camadas”, dê um clique-duplo na camada PEI_placenames. Selecione a aba “Rótulos” (“Etiquetas” em PT-PT) no lado esquerdo (sob “Simbologia”). No topo, escolha ‘Rótulos Individuais’ (“Etiquetas simples” em PT-PT), e de seguida, na barra ‘Valor’, selecione “Placename” (place name, nome do local em português).

{% include figure.html filename="qgis23.png" caption="Figura 22" %}

- Altere o tamanho da fonte para ‘18’
- Clique em ‘OK’ e veja o resultado no mapa


{% include figure.html filename="qgis24.png" caption="Figura 23" %}

- Etiquetar é um dos pontos fracos do QGIS em comparação à cartografia verdadeira — será preciso ajustar as configurações para projetar os detalhes desejados para a apresentação. Experimente voltar à aba de Etiquetas e trocar as diferentes configurações para ver como os símbolos e projeções mudam.

Tenha em mente que na janela de Camadas é possível adicionar ou remover as diversas camadas que adicionamos ao mapa da mesma forma que fizemos no Google Earth. Clique nas caixas de verificação para remover e adicionar as várias camadas. Arraste e solte camadas para mudar a ordem na qual aparecem. Arrastar uma camada para o topo vai colocá-la acima das demais camadas e torná-la a mais proeminente. Por exemplo, se você arrastar ‘coastline_polygon’ para o topo, você terá um contorno simplificado da província, junto com os nomes dos lugares.

{% include figure.html filename="qgis25.png" caption="Figura 24" %}

-   Ao longo da barra de ferramentas no canto superior esquerdo da janela principal existem ícones que te permitem explorar o mapa. O símbolo de mão, por exemplo, permite-lhe clicar no mapa e movê-lo, enquanto os símbolos de lupa com um mais e um menos lhe permitem aumentar ou diminuir o zoom. Brinque com essas ferramentas e se familiarize com as diversas funções

{% include figure.html filename="qgis26.png" caption="Figura 25" %}

-  Após criar um mapa utilizando camadas vetoriais, agora nós iremos adicionar ou utilizar a nossa primeira camada raster


**Abrindo camadas raster**: dados **raster** são imagens digitais constituídas por redes quadriculadas. Todos os dados de detecção remota, como imagens de satélite ou [fotos aéreas](https://pt.wikipedia.org/wiki/Aerofotogrametria#Ortofotografia), são rasters, mas geralmente não se pode enxergar o quadriculado dessas imagens, pois elas são compostas por pequenos píxeis. Cada pixel tem o seu próprio valor e, quando esses valores são simbolizados em cores ou em escala de cinzentos, formam uma imagem que é útil para visualização ou análise topográfica. Um mapa histórico digitalizado também é integrado no SIG em formato raster.


-   faça o download de: [PEI_CumminsMap1927.tif](https://programminghistorian.org/assets/PEI_CumminsMap1927_compLZW.tif) para a pasta do seu projeto
-   embaixo de Camada na barra de ferramentas, selecione Adicionar Camada Raster

{% include figure.html filename="qgis27.png" caption="Figura 26" %}

- encontre o ficheiro baixado com o nome ‘PEI_CumminsMap1927.tif’
- será solicitado que você defina o sistema de coordenadas dessa camada. Na caixa Filtro, busque por ‘2291’, e então na seção abaixo, selecione ‘NAD83(CSRS98) / Prince Edward Isl. (Stereographic)...’

{% include figure.html filename="qgis28.png" caption="Figura 27" %}

-   Caso o programa não solicite o SRC, você terá que modificá-lo por conta própria. Dê um clique-duplo na camada PEI_CummingMap1927 e selecione 'Fonte' no menu à esquerda. No menu do SRC, selecione “SRC do projeto: EPSG: 2291 – NAD83 (...)”. Clique em “OK”.

{% include figure.html filename="qgis29.png" caption="Figura 28" %}

- Na janela de Camadas, o mapa deve aparecer sob os dados vetoriais. Se necessário, desloque-o mais para baixo no menu:

{% include figure.html filename="qgis30.png" caption="Figura 29" %}

-   Agora, para aumentar a visibilidade da linha de costa, dê um clique-duplo em ‘coastline_polygon’ e selecione ‘Simbologia’ à esquerda. Na caixa Preenchimento, clique em 'Preenchimento Simples' e opções vão aparecer na caixa à direita. Clique no menu ao lado de “Cor do traço” e coloque a cor vermelha, e em seguida, ao lado de “Largura do traço”/(”Espessura do traço” em PT-PT) mude para 0.5, e clique “OK”.

{% include figure.html filename="qgis31.png" caption="Figura 30" %}

-   Agora será possível ver o mapa raster de fundo “por detrás” da camada 'coastline_polygon'. Aumente o zoom para uma inspeção mais detalhada, e será possível ver claramente a camada da linha de costa. Perceba como o alinhamento, apesar de bom, não está perfeito. Iremos aprender mais, na lição 4, sobre os desafios de georreferenciar mapas históricos para lhes dar coordenadas do mundo real.

{% include figure.html filename="qgis32.png" caption="Figura 31" %}

**Você aprendeu a instalar o QGIS e a adicionar camadas. Certifique-se de salvar o seu trabalho!**

*Essa lição é parte do Geospatial Historian.*

  [QGIS Download page]: http://hub.qgis.org/projects/quantum-gis/wiki/Download
  [KyngChaos Qgis download page]: http://www.kyngchaos.com/software/qgis
  [PEI Highways]: ../assets/PEI_highway.zip
  [alternate Tar file]: https://www.dropbox.com/s/8k81jnmhpoi99fv/pei_highway.tar.gz
  [PEI Places]: ../assets/PEI_placenames.zip
  [1]: https://www.dropbox.com/s/33g19iqhdnxoayd/pei_placenames.tar.gz
  [Coordinate Reference System]: http://en.wikipedia.org/wiki/Spatial_reference_system
  [NRCan's website]: http://www.nrcan.gc.ca/earth-sciences/geography-boundary/mapping/topographic-mapping/10272
  [Double Stereographic projection]: http://www.gov.pe.ca/gis/index.php3?number=77865&lang=E
  [Tutorial: Working with Projections in QGIS]: http://qgis.spatialthoughts.com/2012/04/tutorial-working-with-projections-in.html
  [defined]: http://www.gislounge.com/geodatabases-explored-vector-and-raster-data/
  [aerial photos]: http://en.wikipedia.org/wiki/Orthophoto
  [PEI_CumminsMap1927.tif]: ../assets/PEI_CumminsMap1927_compLZW.tif
  [Geospatial Historian]: http://geospatialhistorian.wordpress.com/
