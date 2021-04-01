---
title: Criar novas camadas vetoriais com o QGIS 2.0
layout: lesson
slug: camadas-vetoriais-qgis
date: 2013-12-13
translation_date: 2021-03-30
authors:
- Jim Clifford
- Josh MacFadyen
- Daniel Macfarlane
reviewers:
- Finn Arne Jørgensen
- Peter Webster
- Abby Schreiber
editors:
- Adam Crymble
translator:
- Rafael Laguardia
translation-editor:
- Joana Vieira Paulino
translation-reviewer:
- 
- 
difficulty: 2
review-ticket
activity: presenting
topics: [mapping]
abstract: "Nesta lição, você aprenderá como criar camadas vetoriais com base em mapas históricos digitalizados."
redirect_from: /lessons/vector-layers-qgis
original: vector-layers-qgis
avatar_alt: Map of city streets

---

{% include toc.html %}





Objetivos da aula
------------

Nesta lição, você aprenderá como criar camadas vetoriais com base em mapas históricos digitalizados. [Na introdução ao Google Maps e Google Earth](https://programminghistorian.org/en/lessons/googlemaps-googleearth), você usou camadas vetoriais e criou atributos no Google Earth. Faremos a mesma coisa nesta lição, embora em um nível mais avançado, usando o software QGIS.

As camadas vetoriais são, junto com as camadas raster, um dos dois tipos básicos de estruturas de dados que armazenam dados. As camadas vetoriais usam os três recursos básicos do GIS - linhas, pontos e polígonos - para representar traços do mundo real em formato digital. Pontos podem ser usados ​​para representar locais específicos, como cidades, edifícios, eventos, etc. (a escala do seu mapa determinará o que você representa como um ponto - no mapa de uma província, uma cidade seria um ponto, enquanto em um mapa de uma cidade, um edifício pode ser um ponto). Linhas podem representar com eficácia recursos como estradas, canais, ferrovias e assim por diante. Polígonos (formas efetivamente fechadas com mais do que alguns lados) são usados para representar objetos mais complexos, como os limites de um lago, país ou equitação eleitoral (novamente, a escala afetará sua escolha - grandes edifícios em um mapa de close-up de uma cidade pode ser melhor representados como polígonos do que como pontos).

Nesta lição, você criará shapefiles (que são um tipo de dado vetorial) para representar o desenvolvimento histórico de comunidades e estradas na Ilha do Príncipe Eduardo. Cada shapefile pode ser criado como um dos três tipos de recursos: linha, ponto, polígono (embora esses recursos não possam ser misturados em um shapefile). Cada recurso que você cria em um shapefile possui um conjunto correspondente de atributos, que são armazenados em uma tabela de atributos. Você criará recursos e aprenderá como modificá-los, o que envolve não apenas a criação visual dos três tipos de recursos, mas também a modificação de seus atributos. Para fazer isso, usaremos os ficheiros de [instalar o QGIS 2.0 e adicionaremos camadas](https://programminghistorian.org/en/lessons/qgis-layers) referentes à Ilha Prince Edward.  

## Começando

Comece baixando o [mapa PEI_Holland](https://programminghistorian.org/assets/PEI_HollandMap1798_compLZW.tif) para a pasta do projeto:  

Abra o ficheiro que você salvou no final da instalação do [QGIS 2.0 e na adição de camadas](https://programminghistorian.org/en/lessons/qgis-layers). Você deve ter as seguintes camadas na aba Camadas:  :

-   PEI\_placenames
-   PEI\_highway
-   PEI HYDRONETWORK
-   1935 inventory\_region
-   coastline\_polygon
-   PEI-CumminsMap1927

Desmarque todas essas camadas, exceto PEI_placenames, coastline_polygon e PEI_CumminsMap1927. 

{% include figure.html filename="pei1.png" caption="Figure 1: Clique para ver a imagem em tamanho real." %}

Agora vamos adicionar um segundo mapa histórico como uma camada raster. 

{% include figure.html filename="pei2.png" caption="Figure 2" %}

-   Em Camada na barra de ferramentas, escolha Adicionar Camada Raster (alternativamente, o mesmo ícone que você vê ao lado de 'Adicionar Camada Raster' também pode ser selecionado na barra de ferramentas)
-   Encontre o ficheiro que você baixou intitulado 'PEI_HollandMap1798'
-   Você será solicitado a definir o sistema de coordenadas desta camada. Na caixa de filtro, pesquise por '2291' e, na caixa abaixo, selecione 'NAD83 (CSRS98) / Prince Edward Isl. Stereographic '
-   Se você não for solicitado a definir o sistema de coordenadas da camada, será necessário alterar uma configuração. Clique em Configurações e, então, em Opções. Clique em CRS no menu à direita e escolha 'Solicitar CRS' a partir das opções abaixo 'Quando uma nova camada é criada, ou quando uma camada é carregada sem CRS'. Clique OK. Remova o Mapa da Holanda (clique com o botão direito nele e clique em Remover) e tente adicioná-lo novamente. Desta vez, você deve ser solicitado a fornecer um CRS e pode selecionar a opção NAD83 (veja acima).

{% include figure.html filename="pei3.png" caption="Figure 3" %}

Nas etapas anteriores, você selecionou e desmarcou camadas na janela Camadas marcando e desmarcando as caixas ao lado delas. Essas camadas são organizadas em ordem decrescente de visibilidade - ou seja, a camada superior é a camada superior da janela do visualizador (desde que esteja selecionada). Você pode arrastar as camadas para cima e para baixo na janela de camadas para alterar a ordem em que ficarão visíveis na janela de visualização. A camada raster "litoral_polygon" não está visível no momento porque está abaixo das camadas "PEI_HollandMap1798" e "PEI_Cummins1927". Em geral, é melhor manter as camadas vetoriais acima das camadas raster.

Desmarque "PEI_Cummins1927" para que a única camada restante seja PEI_HollandMap1798. Observe que o mapa aparece torto na tela; isso ocorre porque ele já foi georreferenciado pelos redatores da lição para coincidir com as camadas do vetor GIS. Saiba mais sobre georreferenciamento em [georreferenciamento no QGIS 2.0](https://programminghistorian.org/en/lessons/georeferencing-qgis).

{% include figure.html filename="pei4.png" caption="Figure 4" %}

Agora criaremos um ficheiro de forma de ponto, que é uma camada vetorial. Clique em Layer -> New -> New Shapefile Layer

-   Alternativamente, você pode selecionar o ícone New Shapefile Layer no topo da janela da barra de ferramentas QGIS 

{% include figure.html filename="pei5.png" caption="Figure 5" %}

Depois de selecionar New Shapefile Layer, uma janela intitulada New Vector Layer aparece

-   Na categoria Tipo, ponto já está selecionado para você. Clique no botão Especificar CRS e selecione NAD83 (CSRS98) / Prince Edward Isl. Estereográfico (EPSG: 2291) e, em seguida, clique em OK (para obter informações sobre como entender e selecionar a zona UTM: [https://lib.uwaterloo.ca/locations/umd/digital/clump_classes.html](https://lib.uwaterloo.ca/locations/umd/digital/clump_classes.html)

{% include figure.html filename="pei6.png" caption="Figure 6: Clique para ver a imagem em tamanho real." %}

Retornando à janela Nova Camada vetorial, iremos criar alguns atributos. Para criar o primeiro atributo:  

-   Em Novo atributo, no campo ao lado de Nome, digite 'Nome_de_conjunto' (observe que ao trabalhar em bancos de dados você não pode usar espaços vazios nos nomes, então a convenção é usar sublinhados em seus lugares)
-   Clique em Adicionar à lista de atributos 

Agora vamos criar um segundo atributo:  

-   Em Novo Atributo, no campo ao lado de Nome, digite 'Ano'
-   Desta vez, vamos mudar o tipo para número inteiro
-   Clique em Adicionar à lista de atributos

Para o terceiro atributo:

-   Sob Novo atributo, no campo ao lado de Nome, digite "End_Year" (GIS nem sempre é ideal para lidar com mudanças ao longo do tempo, então em alguns casos é importante ter um campo para identificar aproximadamente quando algo deixou de existir)
-   Mude o tipo novamente para número inteiro
-   Clique em Adicionar à lista de atributos

{% include figure.html filename="pei7.png" caption="Figura 7" %}

-   Ao concluir essas três etapas, termine de criar este ficheiro de forma clicando em OK na parte inferior direita da janela New Vector Layer. Um pop-up irá surgir, nomeie-o de "settlements" e salve-o com seus outros ficheiros GIS.

Observe que uma camada chamada "settlements"agora aparece na janela Camadas. Reposicione-a acima das camadas raster.

{% include figure.html filename="pei8.png" caption="Figura 8" %}

Desmarque todas as camadas, exceto "settlements". Você notará que sua janela de visualização agora está em branco, pois não criamos nenhum dado. Agora criaremos novos dados do <mark>PEI_HollandMap 1798 e do PEI_CumminsMap1927{c:red}texto vermelho.{/c}</mark> para mostrar o aumento da ocupação entre o final do século 18 e o início do século 20. 

-   Nós começaremos com o mapa mais recente e, portanto, geralmente mais preciso. Selecione novamente (ou seja,  marque as caixas ao lado) coast_polygon e PEI_CumminsMap1927.
-   Na janela de visualização, aumente o zoom em Charlottetown (dica: Charlottetown fica perto do meio da ilha no lado sul, na confluência de três rios).
-   Selecione a camada de "settlements" na janela Camadas.
-   Na barra de menu, selecione Alternar Edição.

{% include figure.html filename="pei9.png" caption="Figura 9" %}

-   Depois de selecionar Aternar Edição, os botões de edição ficarão disponíveis à direita na barra de menus. Selecione o botão 3 dot feature.

{% include figure.html filename="pei10.png" caption="Figura 10" %}

-   Seu cursor agora aparece como uma cruz - aponte a cruz para Charlottetown (se por acaso você não conhecer a geografia do PEI, você pode avançar adicionando a camada PEI_nomes de local) mantendo-o dentro da linha costeira moderna e clique (a digitalização é sempre um compromisso entre precisão e funcionalidade; dependendo da qualidade do mapa original e da digitalização, para a maioria das aplicações históricas, precisão extrema não é necessária).
-   Uma janela de atributos aparecerá. Deixe o campo id em branco (no momento da escrita, QGIS criará dois campos id e este é desnecessário). No campo Settlement, digite 'Charlottetown'. No campo Year, digite 1764. Clique em OK. 
Vamos agora repetir as etapas que realizamos com Charlottetown para Montague, Summerside e Cavendish (novamente, você pode encontrar esses locais adicionando as camadas PEI_placenames). Encontre Montague no mapa, selecione o botão 3 dot feature e clique em Montague no mapa. Quando a janela Attributes aparecer, insira Montague e 1732 nos campos apropriados. Repita para Summerside (1876) e Cavendish (1790).

Agora vamos repetir os passos que tomamos com Charlottetown para Montague, Summerside e Cavendish (novamente, você pode encontrar esses locais adicionando as camadas PEI_placenames). Encontre Montague no mapa, selecione os 3 pontos na feição e clique em Montague no mapa. Quando a janela Atributos aparecer, insira Montague e 1732 nos campos apropriados. Repita para Summerside (1876) e Cavendish (1790).

{% include figure.html filename="pei11.png" caption="Figura 11" %}

Na janela Camadas, desmarque PEI_CumminsMap1927 e selecione PEI_HollandMap1798. Agora vamos identificar dois settlements  (Princetown & Havre-St-Pierre) que não existem mais.  

-  Para localizar Princetown, procure Richmond Bay e Cape Aylebsury (na costa norte a oeste de Cavendish), aqui você encontrará Princetown (sombreado) perto da fronteira entre o amarelo e o azul.

-  Se você olhar a [entrada da Wikipedia](https://en.wikipedia.org/wiki/Prince_Royalty,_Prince_Edward_Island) para a cidade, você notará que por causa de um porto raso, Princetown não se tornou um assentamento importante. Foi renomeado em 1947 e posteriormente rebaixado para uma aldeia. Por esse motivo, incluiremos 1947 como a data final para este acordo.

-   Com a mira do mouse (em formato de cruz), clique em Princetown. Na tabela Atributo que aparece, coloque Princetown no campo Settlement, coloque 1764 no campo Year e coloque 1947 no End_Year. Clique OK.

{% include figure.html filename="pei12.png" caption="Figura 12" %}

-   Clique no ícone Salvar edições na barra de menu (fica entre Toggle and Add Feature)

-   Clique duas vezes na camada de assentamentos na janela Camadas, escolha a guia Labels (rótulos) na parte superior da janela seguinte. Clique na caixa ao lado de Display labels. Em Campo contendo rótulo, selecione Year (se necessário), altere o tamanho da fonte para 18,0, altere Posicionamento para Acima à esquerda e clique em OK.

Na costa norte do lote 39, entre Britain's Pond and St. Peters Bay, colocaremos agora um ponto para a localização de uma aldeia há muito perdida chamada Havre-St-Pierre.

-   Havre-St-Pierre foi o primeiro assentamento Acadian da ilha, mas está desabitado desde a deportação Acadian em 1758.

-   Com o cursor do mouse (em formato de cruz), clique em Havre-St. Pierre. Na tabela de Atributos que aparece, coloque Havre-St-Pierre no campo Settlement, coloque 1720 no campo Year e coloque 1758 no End_Year. Clique OK.

{% include figure.html filename="pei13.png" caption="Figura 13" %}

Agora vamos criar outra camada vetorial - esta camada será um vetor linha. Clique em Layer -> New -> New Shapefile Layer. A janela New Vector Layer aparecerá (na categoria Type no topo, selecione Line).  

-   Clique no botão Especificar CRS e selecione NAD83 (CSRS98) / Prince Edward Isl. Estereográfico (EPSG: 2291) e clique em OK.
-   Em New attribute, no campo ao lado de Nome, digite 'Road_Name'.
-   Clique em  Add to attributes list.  

Crie um segundo atributo:

-   Em Novo atributo, no campo ao lado de Name, digite Year.
-   Mude o tipo para número inteiro.
-   Clique em Adicionar à lista de Atributos.
-   Para terminar de criar este ficheiro, clique em OK na parte inferior direita da janela New Vector Layer. Uma tela de 'salvar' aparece - chame-a de 'roads' e salve-a com seus outros ficheiros GIS. .

Vamos agora traçar as estradas do mapa de 1798 para que possamos compará-las com as estradas modernas. Certifique-se de ter o PEI_Holland1798 e as camadas de assentamentos verificadas na janela Camadas. Selecione a camada "road" na janela de camadas, selecione Toggle Editing na barra de ferramentas superior e selecione "Add Feature".

{% include figure.html filename="pei14.png" caption="Figura 14" %}

-   Primeiro trace a estrada de Charlottetown a Princetown. Clique em Charlottetown e depois clique repetidamente em pontos ao longo da estrada para Princetown e você verá a linha sendo criada. Repita até chegar a Princetown e clique com o botão direito. Na janela Atributos - estrada resultante, no campo Name, insira "to Princetown" e no campo Year insira 1798. Clique em OK

{% include figure.html filename="pei15.png" caption="Figura 15" %}

-   Repita esta etapa para mais 3 a 4 estradas encontradas no PEI_HollandMap1798.

-   Clique em Save Edits e, em seguida, clique em Toggle Editing para desligá-lo.

Desmarque PEI_HollandMap1798 na janela Camadas e selecione o mapa PEI_highway. Compare as estradas representadas no mapa PEI_highway (as linhas vermelhas pontilhadas) com as estradas que você acabou de traçar.

{% include figure.html filename="pei16.png" caption="Figura 16" %}

-   Podemos ver que algumas dessas estradas correspondem intimamente às estradas modernas, enquanto outras não correspondem de forma alguma. Seriam necessárias mais pesquisas históricas para determinar se isso ocorre simplesmente porque o mapa da Holanda não representa suficientemente as estradas na época, ou se as estradas mudaram consideravelmente desde então. 

Agora crie um terceiro tipo de camada vetorial: um vetor poligonal. Clique em Layer -> New -> New Shapefile Layer. A janela New Vector Layer aparecerá - na categoria Type no topo, selecione Polygon. 

-   Clique no botão " Specify CRS" e selecione NAD83 (CSRS98) / Prince Edward Isl. Estereográfico (EPSG: 2291) e clique em OK.
-  Em Novo Atributo, no campo ao lado de Name, digite 'lot_name' no campo ao lado de Year.
-  Clique em Add to attributes list.  

Crie um segundo atributo:  

-   Em Novo atributo, no campo ao lado de Name, digite Year.
-   Mude o tipo para Whole Number.
-   Clique em Adicionar à lista de Atributos.

{% include figure.html filename="pei7.png" caption="Figura 17" %}

Comece criando um polígono para o lote 66, que é o único lote retangular na ilha. 

-   Clique em Toggle Editing  na barra de ferramentas superior e, em seguida, clique em Add Feature.
-   Clique em todos os quatro cantos do lote 66 e você verá um polígono criado.
-   Clique com o botão direito no canto final e uma janela de atributos aparecerá. Adicione 66 ao campo lot_names e adicione 1764 (o ano em que esses lotes foram pesquisados) ao campo Year.

{% include figure.html filename="pei18.png" caption="Figura 18" %}

WAgora vamos rastrear o lote 38, que fica a oeste de Havre-St-Pierre. Certifique-se de que haja uma marca de seleção na caixa ao lado da camada PEI_HollandMap1798 na janela Camadas.  

Clique em Alternar Edição na barra de ferramentas superior e, em seguida, clique em Add Feature. 

Trace o contorno do Lote 38, que é mais difícil por causa da linha costeira, com a maior precisão possível. Para mostrar o recurso Snap, queremos que você trace ao longo da costa moderna (o snap é uma operação de edição automática que ajusta o recurso que você desenhou para coincidir ou alinhar exatamente com as coordenadas e forma de outro recurso próximo).  

-   Selecione Configurações-> Opções de Snapping

{% include figure.html filename="pei19.png" caption="Figura 19" %}

-   Uma janela de opções de snapping irá abrir: clique na caixa ao lado de coast_polygon, para a categoria Mode selecione "to vertex and segment", para Tolerance selecione 10.0, e para Units selecione 'pixels'. Clique OK.

{% include figure.html filename="pei20.png" caption="Figura 20" %}

Certifique-se de que a camada de lotes esteja selecionada na janela Camadas e selecione Adicionar feição na barra de ferramentas. 

-  Com o cursor, clique nos dois cantos inferiores do polígono, assim como fez com o lote 38. Na linha costeira, você notará que tem uma coleção de linhas para traçar ao redor do Porto Selvagem. É aqui que os recursos de encaixe se tornam úteis. Conforme você trabalha para traçar ao longo da costa moderna, sua precisão aumentará significativamente, encaixando os cliques diretamente no topo da linha existente. Quanto mais cliques você fizer, mais preciso será, mas tenha em mente que, para muitos fins de HGIS, obter extrema precisão às vezes produz retornos decrescentes.

{% include figure.html filename="pei21.png" caption="Figura 21" %}

Quando terminar de traçar e criar o polígono, selecione e desmarque as várias camadas que criou, comparando e vendo quais relações você pode deduzir.  
No Google Earth, havia limitações nos tipos de recursos, atributos e dados fornecidos pelo Google, e o Google Earth fez grande parte do trabalho para você. Isso é bom quando você está aprendendo ou deseja criar mapas rapidamente. A vantagem de usar o software QGIS para criar novas camadas vetoriais é que você tem bastante liberdade e controle sobre os tipos de dados que pode usar e os recursos e atributos que pode criar. Isso, por sua vez, significa que você pode criar mapas personalizados muito além do que pode ser alcançado no Google Earth ou no Google Maps Engine Lite. Você viu isso em primeira mão com as camadas de vetor de pontos, linhas e polígonos que aprendeu a criar nesta lição. Se encontrou dados em, por exemplo, registros de saúde pública no século 18, pode criar uma nova camada para trabalhar com o que você já criou, mostrando a distribuição de surtos de febre tifóide e ver se há correlações com estradas e assentamentos principais. Além disso, o software GIS permite não apenas representar e apresentar dados espacialmente de maneiras muito mais sofisticadas, mas também analisar e criar novos dados de maneiras que não seriam possíveis de outra forma. 

**Você aprendeu como criar camadas vetoriais. Certifique-se de salvar seu trabalho!**

*This lesson is part of the [Geospatial Historian][].*

  [Intro to Google Maps and Google Earth]: /lessons/googlemaps-googleearth
  [Installing QGIS 2.0 and Adding Layers]: /lessons/qgis-layers
  [PEI_Holland map]: /assets/PEI_HollandMap1798_compLZW.tif
  [Georeferencing in QGIS 2.0]: /lessons/georeferencing-qgis
  [Wikipedia entry]: http://en.wikipedia.org/wiki/Prince_Royalty,_Prince_Edward_Island
  [Geospatial Historian]: http://geospatialhistorian.wordpress.com/
