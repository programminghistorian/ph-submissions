---
title: Geocodificando Dados Históricos com o QGIS
slug: geocodificando-qgis
original: geocoding-qgis
layout: lesson
collection: lessons
date: 2017-01-27
translation_date: YYYY-MM-DD
authors:
-  Justin Colson
reviewers:
- Adam Crymble
- Adam Dennett
- Léon Robichaud
editors:
- Adam Crymble
translator:
- Luanna Kaori
translation-editor:
- Joana Vieira Paulino
translation-reviewer:
- Ângela Pité
- Diogo Paiva
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/565
difficulty: 2
activity: transforming
topics: [mapping]
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}



## Objetivos da lição

Diversos tipos de fontes utilizadas por historiadores são inerentemente espaciais. Por exemplo:

- Censos, dados populacionais ou tributários
- Importações e exportações
- Rotas e itinerários

Com esse tutorial, você aprenderá a “geocodificar” dados históricos que contenham nomes de lugares (cidades, municípios, países, etc), e torná-los mapeáveis utilizando o QGIS [QGIS](https://www.qgis.org/pt_PT/site/), um software digital de mapeamento. Isso lhe permitirá:

- Expor os seus dados como um mapa (mesmo que esses dados estejam em uma lista, uma tabela ou em textos corridos)
- Analisar as distâncias entre os lugares em seus dados
- Ver e analisar a distribuição geográfica dos seus dados

Esse tutorial compõe parte da série Mapeamento e QGIS, do Programming Historian, e depende de competências aprendidas com os tutoriais anteriores, principalmente  [Installing QGIS 2.0 and Adding Layers](http://programminghistorian.org/en/lessons/qgis-layers) (em inglês). Ele presume que você conta com um conjunto de [shapefiles](https://pt.wikipedia.org/wiki/Shapefile) referentes à região que você pretende mapear, e dados que você gostaria de colocar nesses shapefiles para que possam ser visualizados e analisados.

## A geocodificação

Mapear esse tipo de dado envolve transformar informações espaciais, entendidas por pessoas (como o nome de cidades ou municípios) em um formato que pode ser compreendido pelo software [SIG](
https://pt.wikipedia.org/wiki/Sistema_de_informa%C3%A7%C3%A3o_geogr%C3%A1fica)  (mapeamento). Isso é limitado a uma espécie de geometria (um ponto, uma linha ou um polígono em um vetor representativo) relacionada às coordenadas deste lugar em um espaço bidimensional — como latitude e longitude expressas em graus, ou como é comum no Reino Unido, a partir das direções norte e leste da [British National Grid](https://www.ordnancesurvey.co.uk/resources/maps-and-geographic-resources/the-national-grid.html). A geocodificação sempre vai depender do uso de um [gazetter](https://pt.wikipedia.org/wiki/Gazetteer), ou de uma lista de lugares e coordenadas.

É comum existir uma confusão entre os processos de [geocodificação](https://en.wikipedia.org/wiki/Geocoding) e [georreferenciamento](https://pt.wikipedia.org/wiki/Georreferenciamento). 

- O georreferenciamento busca posicionar elementos visuais, geralmente imagens raster como fotografias de satélite, escaneamentos de mapas antigos, ou algum tipo de imagem vetorial como desenhos arquitetônicos ou arqueológicos, no espaço geográfico. Para tal, é utilizado coordenadas latitudinais e longitudinais, e escala.
- A geocodificação é o processo de determinar endereços (ou algum outro tipo de descrição espacial), que compõem um conjunto de dados, geometricamente em um mapa. Isso nos permite visualizar, analisar e investigar aquele conjunto de dados por um viés espacial.

Em suas muitas aplicações modernas, a geocodificação é feita automaticamente, geralmente utilizando ferramentas de mapeamento ou gazetteers perfeitamente oferecidos como parte do [Google Maps](https://www.google.co.uk/maps) ou o [OpenStreetMap](https://www.openstreetmap.org/). Quando trabalhamos com dados contemporâneos, ou dados de períodos relativamente recentes, dentro do contexto histórico da Europa Ocidental ou da América do Norte, isso nos basta. Se você trabalha com dados cujos lugares preservam seus nomes atualmente, você pode usar o plugin de geocodificação virtual do QGIS, explicado mais detalhadamente no postscript desse tutorial, ou o [Edinburgh Geoparser](https://programminghistorian.org/en/lessons/geoparsing-text-with-edinburgh).

Muitos historiadores estarão trabalhando em situações onde os lugares não mantiveram o mesmo nome até os dias atuais. Lembre-se que as ruas tendem a ter seus nomes trocados até que frequentemente, seja apenas sua ortografia ou uma mudança completa. Áreas administrativas também mudam tanto quanto frequentemente, e às vezes eram utilizadas de forma inconsistente em fontes históricas (por exemplo, Bristol ficava em Gloucestershire, Somerset, Cidade de Bristol, ou Avon?), e realmente, os lugares se deslocaram entre os países, e os países mudaram tanto seus nomes quanto seu tamanho. Até mesmo cidades tem seus nomes alterados ou sujeitos à ambiguidades linguísticas (por exemplo, Lynn Episcopi, Lynn do Bispo, Lynn, Lynn do Rei, Reis Lynn). Por esses motivos, é melhor evitar as ferramentas online de geocodificação automáticas, e criar um gazetteer adequado ao contexto histórico trabalhado. Os processos descritos nesse tutorial são manuais, e podem ser modificados e aplicados a quase todos os contextos histórico-geográficos. 

## Estrutura da lição

Essa lição é dividida em duas seções principais: 

- Parte 1: **Unindo tabelas**, um jeito simples de mapear dados sucintos simples, como médias e totais
- Parte 2: **Geocodificando conjuntos de dados completos**, o que atribui a cada item do conjunto uma localização, dando-lhes uma flexibilidade consideravelmente maior, uma análise espacial detalhada, e mapas mais interessantes

Terminado o tutorial, temos uma observação sobre como utilizar ferramentas automáticas de geocodificação, uma opção para trabalhar com endereços modernos. No entanto, essa seção não é tão pertinente a historiadores pesquisando períodos antes do fim do século XIX ou do século XX.

## Mãos à obra

Esse tutorial presume que você tenha instalado o QGIS versão 2, ou uma versão mais recente, seguindo o tutorial do *Programming Historian*, [Installing QGIS 2.0 and Adding Layers](http://programminghistorian.org/en/lessons/qgis-layers) (em inglês), de Jim Clifford, Josh MacFadyen e Daniel MacFarlane. Ou, pelo menos, que você seja familiarizado com o processo de adicionar camadas vetoriais no QGIS.

A tradução desse tutorial foi feita utilizando o QGIS 3.32 em uma máquina Windows. Os menus, as janelas e configurações podem variar levemente em plataformas ou versões diferentes, mas não deve ser difícil traduzir quaisquer disparidades. Em alguns momentos durante o tutorial, há referências a como essas técnicas podem ser aplicadas no [ArcGIS](https://www.arcgis.com/features/index.html), que é o aplicativo SIG comercial padrão da indústria, e é amplamente distribuído em universidades, mas que não é sempre superior ao QGIS.
 
Você também precisará utilizar uma base de dados atinentes, como Microsoft Access ou o [LibreOffice Base](https://www.libreoffice.org/get-help/install-howto/), ou então ter bastante experiência com planilhas. As instruções no tutorial são feitas tendo o LibreOffice Base em mente, que é um download gratuito como parte do pacote [LibreOffice](https://www.libreoffice.org/get-help/install-howto/). 

**Atenção:** O LibreOffice requere uma instalação completa de Java para utilizar o aplicativo Base. Isso é facilmente realizado baixando e instalando o Java 8 Development Kit para o seu sistema operacional pelo [Oracle](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html). O Java 8 Runtime Environment NÃO funciona com o LibreOffice no macOS 10.11. 

O tutorial irá mapear os dados extraídos do [*Alumni Oxonienses*](http://www.british-history.ac.uk/alumni-oxon/1500-1714), na lição do *Programming Historian*, [Using Gazetteers to Extract Sets of Keywords from Free-Flowing Texts](http://programminghistorian.org/en/lessons/extracting-keywords) (em inglês), utilizando mapas de condados históricos da Inglaterra e do País de Gales, mapas estes disponíveis publicamente. Completar esse tutorial primeiro te ajudará a compreender o cunho dos dados mapeados aqui. Esses dados são oferecidos tanto como um conjunto de dados completo, quanto como um aquivo à parte que reúne os nomes de ex-alunos de Oxford por seus condados de origem, criado a partir do primeiro arquivo utilizando uma PivotTable do Excel.

# Os dados

* [`The_Dataset-Alum-Oxon-Jas1-Placenames.csv`](https://programminghistorian.org/assets/geocoding-qgis/The_Dataset-Alum-Oxon-Jas1-Placenames.csv)
* [`AlumniCounties.csv`](https://programminghistorian.org/assets/geocoding-qgis/AlumniCounties.csv)

##  Parte 1: Unindo tabelas e mapas

A forma mais simples de mapear dados históricos é “unindo” (conectando) uma tabela de dados com os nomes dos lugares a uma camada de mapa com os mesmos nomes. Essa técnica é comumente usada por historiadores para criar mapas ilustrando um conjunto de estatísticas descritivas para um conjunto de dados. Por exemplo, o número de indivíduos dentro de um grupo advindo de cada condado, ou a proporção de habitantes de cada condado trabalhando em determinada indústria.

No entanto, unir tabelas a recursos do QGIS funciona somente em um nível individual (isto é, apenas relações individuais podem ser utilizadas para definir a aparência do mapa). Assim, cada feição do mapa pode ter apenas um parâmetro associado a cada um de seus atributos. Você pode dizer que existem 50 estudantes do condado de Essex em seus dados, e então conectar isso ao comando polígono em seu shapefile (Tabela 1). Mas você não pode armazenar os dados como 50 fileiras, cada uma representando um único estudante que direciona à feição Essex do seu shapefile (Tabela 2). Uma feição do shapefile, um parâmetro. Por esse motivo, uniões são mais adequadas para representar os resultados analisados de planilhas ou base de dados (por exemplo, quando você já tiver calculado a quantidade de pessoas de uma determinada área — ou qualquer que seja o aspecto a ser mapeado).

*Tabela 1: Essa tabela seria para “uniões”, já que cada shapefile possui um atributo calculado.*

| Shapefile | Número de alunos |
| --------- | --------- |
| Essex | 50 |
| Norfolk | 28 |
| Middlesex | 81 |

*Tabela 2: Essa tabela não funcionaria para uma “união”*

| Nome do aluno | Lugar de origem |
| --------- | --------- |
| Joe Smith | Essex |
| Tom Jones | Essex |
| Matthew Rogers | Essex |

Nesse breve tutorial, iremos mapear o número total de ex-alunos da Universidade de Oxford advindos de cada condado, no início da Era Moderna. O arquivo `AlumniCounties.csv` contém um apanhado do conjunto de dados completo, que foi previamente criado usando uma [PivotTable](https://en.wikipedia.org/wiki/Pivot_table) no Microsoft Excel. Consulte esse arquivo utilizando o seu software de planilhas para verificar o título das colunas e sobre o que se trata os dados nela contidos.

**Atenção:** O QGIS é bastante sensível ao corrigir arquivos CSV (Comma Separated Values), especialmente aqueles de interrupção de comando. Caso encontre dificuldades utilizando um arquivo CSV criado com o Microsoft Excel (principalmente o Excel 2007 ou 2011 para MacOS), tente salvar novamente o arquivo CSV utilizando o LibreOffice Calc ou o Excel 2016.


### Tutorial: Unindo tabelas e mapas

*	Abra o QGIS (em um computador Windows, talvez terão diversas opções na pasta do Menu Inicial do QGIS. Selecione a opção QGIS Desktop, não QGIS Navegador ou GRASS)
*	Crie um novo projeto no QGIS e o salve em seu lugar de preferência. (**Atenção:** O QGIS padroniza salvar caminhos relativos, ou seja, contanto que você salve todos os seus arquivos de projeto na mesma pasta, ou em suas subpastas, você pode movê-los para um local diferente, como um pen-drive, por exemplo. Você pode encontrar essa configuração pelo menu `Projeto>Propriedades` e pela aba lateral `Geral`).
*	É de extrema importância que o [Sistema de Referenciamento Coordenado](https://en.wikipedia.org/wiki/Spatial_reference_system) (SRC) esteja configurado de acordo com os dados a serem importados e com a região a ser mapeada. Vá ao menu `Projeto>Propriedades` e selecione a aba SRC na lateral. Use as caixas de filtro para encontrar e seleciona `OSGB 1936 / the British National Grid`, com a autoridade de ID `ESPG:27700`, debaixo do cabeçalho do Sistemas de Coordenadas Projetadas.

Existe uma diferença importante entre Sistemas de Coordenadas Geográficas, que meramente definem as unidades de medida e o datum, e Sistemas de Coordenadas Projetadas, que também definem a maneira com a qual o globo é “achatado” sobre um mapa. O [OSGB](https://en.wikipedia.org/wiki/Ordnance_Survey_National_Grid) está disponível em ambas variantes do QGIS, então escolha a versão “projetada” que lhe dará um mapa no qual o Reino Unido apareça da maneira esperada. Para mais detalhes sobre projeções em SIG, veja o [tutorial Working with Projections in QGIS.](http://www.qgistutorials.com/en/docs/working_with_projections.html) (em inglês). 

*	Baixe um shapefile contendo polígonos dos condados históricos da Inglaterra e do País de Gales em [http://www.county-borders.co.uk](http://www.county-borders.co.uk/)  (selecione o arquivo `Definition A: SHP OSGB36 Simplified`, que é uma versão das fronteiras entre os condados da Grã-Bretanha, pré-1843, projetada sobre o OSGB, sem porções destacadas dos condados). Extraia o conteúdo do arquivo ZIP para a mesma pasta do seu projeto
*  Clique no botão `Adicionar Camada Vetorialr` (remete a uma linha de gráfico), na barra de ferramentas Administrar Camadas, e então em `Explorar` para selecionar e adicionar o shapefile `UKDefinitionA.shp` da pasta extraída.


{% include figure.html filename="QGISFigureAddVector.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 1: A janela Adicionar Vetor do QGIS no Windows (O botão Adicionar Vetor está circulado na barra de ferramentas à esquerda)" %}

Deve ser possível visualizar um mapa base dos condados britânicos em uma cor aleatória. Se você clicar com o botão direito do mouse no título dessa camada no Painel de Camadas (no canto inferior esquerdo), você poderá selecionar `Abrir Tabela de Atributos` para visualizar as propriedades da base de dados associada a cada feição do mapa. Perceba que o nome de cada condado está nomeado de três maneiras diferentes, a mais completa estando na coluna intitulada `NAME`, bem como duas colunas de identificação. Agora precisamos juntar isso aos dados dos ex-alunos que queremos mapear, utilizando o fato de que os atributos na coluna `NAME` são os mesmos que aqueles em uma das colunas da nossa planilha (eles devem exatamente o mesmo para funcionar).

O arquivo `AlumniCounties.csv` contém um apanhado do conjunto de dados dos ex-alunos, criado com uma PivotTable no Microsoft Excel. Duas colunas nomeadas contêm os nomes dos condados (essa coluna é denominada `Row Labels`) e os totais simples de indivíduos advindos desses lugares.

*	No QGIS, selecione o botão `Adicionar Camada de Texto Delimitado`, na barra de ferramentas Camada Propriedades (se parece um uma vírgula). Explore para localizar o arquivo e selecione `CSV` como o formato de arquivo, e `Sem geometria (atributo apenas de tabela)` sob `Definição de geometria`. O nome das novas tabelas é especificado automaticamente no campo `Título da Camada` como o mesmo nome do arquivo importado (`AlumniCounties`)
*	No Painel de Camadas, dê um clique inverso na camada do mapa (denominada igual o shapefile adicionado: `UKDefinitionA`), e selecione `Propriedades`, e então selecione a aba `Joins` à esquerda. Use o botão `+` para criar uma união.
*	Na janela pop-up, selecione a nova tabela importada (`AlumniCounties`) como `Unir Camadas`, e em `Unir Campos` e `Campo Alvo` selecione as respectivas colunas contendo a mesma informação (o nome do condado). O `Unir Campos` é `Row Labels` nesse caso, e o `Campo Alvo` é o campo na camada do mapa da tabela de atributos, contendo a informação correspondente (nesse caso, `NAME`). 
*	É possível verificar que essa união funcionou dando um clique inverso na camada shapefile e selecionando `Abrir Tabela de Atributos`. Perceba que `AlumniCounties_Count Place of Origin` está disponível agora como uma das colunas na camada de formatos de condados, junto de diversos códigos e números de ID que fazem parte do shapefile baixado.

 {% include figure.html filename="QGISFigure1.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 2: Caixa de diálogo dos campos unidos e o vetor" %}

Esses dados agora podem ser visualizados como um [mapa coroplético](https://pt.wikipedia.org/wiki/Mapa_coropl%C3%A9tico) ao modificar as opções na aba `Simbologia`, tem Propriedades da Camada. O QGIS oferece uma vasta gama de estilos para expressar os dados associados a cada elemento do mapa de uma forma gráfica. O estilo `Graduado` te permite criar um mapa coroplético com um gradiente de cores representativo da variedade dos atributos numéricos em seus dados, enquanto `Categorizado` te permite atribuir cores, ou outros elementos visuais, a valores específicos ou textuais das tabelas. Para tais dados, com atributos diferentes dentro de um alcance lógico, o estilo `graduado` de representação é o adequado; se houvesse apenas um alcance limitado de potenciais atributos, esses poderiam ser expostos de maneira mais eficaz com a opção `categorizado`.

*	No Painel de Camadas, dê um clique inverso na camada do mapa (provavelmente nomeada como o shapefile adicionado: `UKDefinitionA`) e selecione Propriedades, e então selecione a aba Simbologia à esquerda.
* Das opções que aparecerem, selecione o estilo `Graduado`
*	Selecione a coluna `AlumniCounties_Count Place of Origin` na segunda caixa de pesquisa. Clique em `Classificar`  para que o QGIS analise os atributos dessa coluna e crie uma série de tons e gradientes que correspondam ao alcance dos dados. O padrão é que isso seja configurado à classificação `Intervalo Igual`, mas pode ser que você sinta vontade de experimentar com essa função e escolha um diferente número de classes, ou um método diferente, como o quantil. Ao clicar em OK, o seu mapa será colorido.

{% include figure.html filename="QGISFigure2.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="A aba Simbologia mostrando os valores classificados com base nos campos unidos da tabela, na camada vetorial" %}

Para mais informações sobre como escolher os métodos classificatórios adequados para os seus dados, você pode consultar esse artigo sobre [Classificações em SIG](http://wiki.gis.com/wiki/index.php/Classification). Inspecione os resultados no seu mapa e pense sobre o que está sendo, de fato, representado. O número bruto de ex-alunos, coloridos seguindo uma mesma classificação, porém para condados de tamanhos diversos, é útil? Mapas coropléticos devem, geralmente, ilustrar dados que tenham sido padronizados de alguma forma, como por exemplo, a densidade populacional ao invés do número bruto.

Talvez você queira explorar a caixa de diálogo Expressão (acessada por meio do símbolo &sum; próximo a `Valor` em `Propriedades>Simbologia`) para padronizar esses atributos utilizando outras colunas e atributos disponíveis. O ideal seria padronizar por população, mas na ausência desse dado, você pode testar utilizando a propriedade `$area`, wintrínseca à camada poligonal de SIG. O comando necessário para criar um mapa gradiente é bem simples (tenha em mente que, como o título do campo contém espaçamento entre as palavras, é necessário mantê-lo entre aspas):

```text
"AlumniCounties_Count of Place of Origin" /  $area  
```

Ao alterar qualquer uma dessas configurações contidas na página estilo graduado, é necessário clicar novamente em `Classificar` para atribuir cores novas ao gradiente numérico dos seus dados. Caso não seja feita essa reclassificação, a camada pode ficar invisível no mapa.

## Parte 2: Geocodificando dados históricos

A geocodificação é uma técnica para além de simplesmente unir tabelas, pois cada linha individual dos seus dados se mantém visível e passível de análise dentro do próprio software SIG, como pontos individuais no mapa (como na tabela 2). A princípio, o objetivo é atribuir a cada dado um par de coordenadas. A maior parte dos dados históricos não podem ser geocodificados automaticamente por meio de ferramentas onlines ou plugins do QGIS. O processo de geocodificação, portanto, deve ser realizado manualmente para combinar cada linha de dado a uma localização. Isso é uma tarefa operacional simples, unindo (combinando) os seus dados com um gazetteer (uma lista de lugares com suas coordenadas). Vários dicionários geográficos estão disponíveis, mas apenas alguns são pertinentes em relação a dados históricos. Por exemplo, para a Inglaterra:

- [Association of British Counties Gazetteer](http://www.gazetteer.org.uk/index.php) (dados disponíveis para a compra)
- [The Historical Gazetteer of England's Place Names](http://placenames.org.uk/index.php) te permite geocodificar as localizações individuais apenas online. Infelizmente, o API para acessar esses dados para geocodificação automática, conhecido como DEEP, parte do Unlock, não está mais disponível atualmente (final de 2016). Uma melhor interface de navegação está disponível para aqueles com logins ingleses de Ensino Superior, em [Survey of English Place-Names](https://epns.nottingham.ac.uk/browse)

Caso não tenha nenhum gazetteer pertinente à área ou ao período estudado, é possível facilmente criar o seu próprio através de um mapa vetorial, criando uma camada de ponto contendo a informação necessária dentro do QGIS (talvez ao mesclar as informações de camadas pré-existentes) e exportando o resultando com coordenadas XY. Para determinadas partes do mundo não existem nem dicionários geográficos históricos, nem mapas vetoriais adequados para certos períodos históricos. Nesses casos, você terá que se aventurar a criar seu próprio vetor e sua camada de ponto; consulte o tutorial [Criar novas camadas vetoriais com o QGIS 2.0](https://programminghistorian.org/pt/licoes/camadas-vetoriais-qgis).

### Tutorial: Criando um gazetteer personalizado e geocodificando uma base de dados relacional

Uma vez completa a primeira parte, pode-se avançar e seguir os passos abaixo no mesmo projeto. Caso contrário, ou caso deseje criar um novo projeto em branco, siga as instruções da primeira seção para:

*  Criar um novo arquivo de projeto no QGIS, e configurar o Sistema de Referência Coordenado para `OSGB 1936/the British National Grid` com a ID de autoridade `ESPG:27700` como um sistema de projeção coordenada usando `Projeto>Propriedades>SRC`
* Faça o download de um shapefile contendo polígonos dos condados históricos da Inglaterra e do País de Gales em [http://www.county-borders.co.uk/](http://www.county-borders.co.uk/) (selecione a definição A e o OSGB)

Em seu projeto pré-existente, você pode então começar a adicionar mais camadas para criar o seu gazetteer:

*  Com `Adicionar Camada Vetorial`, adicione uma nova cópia do shapefile ao seu projeto. (Softwares SIG permitem que você adicione ao seu projeto o mesmo shapefile quantas vezes desejar, e toda vez ele irá aparecer como uma camada separada)
* Inspecione os dados contidos no shapefile com um clique inverso no título do mapa no Painel de Camadas, selecionando `Abrir tabela de atributos`. Perceba que as colunas incluem vários códigos, os nomes dos condados, e abreviações, mas nenhuma coordenada. Um polígono é composto de sequências coordenadas que determinam suas fronteiras (nódulos), e portanto, elas são ocultadas.
* Como queremos atribuir um único par de coordenadas para cada linha dos nossos dados, precisamos gerar coordenadas adequadas dos nossos polígonos, procurando por seus pontos centrais (centróides). É fácil criar uma nova camada de pontos a partir dessa camada poligonal, que conta com um único par de coordenadas centróides para cada condado. Selecione `Vetor>Geometria>Centróides`. Renomeie o shapefile subsequente, como `CountiesCentroids` por exemplo, e selecione `Adicionar`

{% include figure.html filename="QGISFigure3.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 4: Caixa de diálogo Centróide dos polígonos e o seu resultado" %}

* Com um clique inverso na nova camada dos centróides, no painel de camadas, selecione `Exportar` para exportar e clique na primeira opção, `Guardar elementos como…` e selecione o formato CSV (Valores separados por vírgula). Nomeie o arquivo `CountiesXY.csv`, e o deixe na mesma pasta que o restante do projeto
* Certifique-se ter selecionado o mesmo CRS já utilizado no projeto, e tome nota dele.
* Embaixo de `Opções de camada`, na janela `Salvar Camada Vetorial como…` certifique-se de que a Geometria esteja configurada como `AS_XY` — isso irá adicionar colunas extras ao início da tabela contendo as coordenadas X e Y de cada ponto.

{% include figure.html filename="QGISFigure4.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 5: A caixa de diálogo Salvar Camada Vetorial Como configurada para exportar um gazetteer CSV" %}

Esses dados agora podem ser comparados aos seus dados pré-existentes para finalizar o processo de geocodificação

### Geocodificando a sua tabela de dados

Podemos, agora, criar uma Tabela Composta com esses locais e os dados da nossa tabela original. Isso se dá ao corresponder o nome do condado, no campo “Lugar” da tabela de ex-alunos, ao ponto correspondente no gazetteer novo, utilizando uma base de dados relacional.

Esse tutorial supõe que você conte com várias centenas ou milhares ou linhas de dados (como contamos nesse tutorial), sendo necessário um método automatizado. Caso você conte com apenas algumas linhas, ou caso tenha dificuldades para utilizar esses métodos, é possível fazê-lo manualmente — consulte “Geocodificando os seus próprios dados históricos” abaixo.

Em contextos mais simples (como este, onde iremos apenas combinar um único atributo de “lugar” — ou seja, apenas “condado”), é possível codificar os seus dados de acordo com um gazetteer com a função [PROCV](https://support.microsoft.com/pt-br/office/fun%C3%A7%C3%A3o-procv-0bbc8083-26fe-4963-8ab8-93a18ad188a1?ui=en-us&rs=en-us&ad=us) do Microsoft Excel (ou planilhas equivalentes), ou até mesmo com o plugin [MMQGIS](https://michaelminn.com/linux/mmqgis/) do QGIS. No entanto, na prática, geralmente será preciso combinar diversos atributos simultaneamente (por exemplo, cidade, condado e país — seria necessário distinguir entre Sudbury, em Suffolk, Inglaterra; Sudbury, em Derbyshire, Inglaterra; Sudbury, em Middlesex, Inglaterra; e Sudbury, em Ontario, Canadá). Isso pode ser realizado através de um método trabalhoso, com a função [ÍNDICE](https://support.microsoft.com/pt-br/office/%C3%ADndice-fun%C3%A7%C3%A3o-%C3%ADndice-a5dcf0dd-996d-40a4-a822-b56b061328bd?ui=en-us&rs=en-us&ad=us) do excel, que é mais prático, e extensível, em uma base de dados relacional, como Microsoft Access ou o LibreOffice Base.

Esse tutorial usa o LibreOffice, uma alternativa código aberto ao Microsoft Office, que é disponibilizada para Windows, macOS e todas as variações de Linux, etc (Atenção: o LibreOffice requer uma instalação Java completa). Ele inclui uma aplicação da base de dados relacional em todas as suas plataformas, diferentemente do Microsoft Access, que está disponível apenas na versão Windows do Office. Porém, ele tem uma funcionalidade um tanto quanto restritiva. Caso utilize o Microsoft Access, ou tenha extrema proficiência em planilhas, sinta-se livre para reproduzir o processo no software da sua escolha.

* Abra o LibreOffice Base e crie e salve um novo projeto de base de dados usando as configurações padrão.
* Os dados só podem ser importados para o Base ao abrir o LibreOffice Calc, copiando e colando a planilha inteira. Abra o LibreOffice Calc e carregue o arquivo CSV `CountiesXY.csv` (que é o produto final do tutorial “Utilizando gazetteers para Extrair Conjuntos de Palavras-chave de Textos Corridos”), e clique em `Copiar`
* Abra o LibreOffice Base e clique em `Colar`. Na caixa de diálogo que aparecer, crie uma tabela com um nome como `Ex-alunos` e selecione `Definição e dados` e `Utilize a primeira linha para nomes de coluna`, e então clique em `Criar`. 
* Será solicitado que você crie uma chave primária, isto é, um número de identidade único para cada fileira, o que deve ser aceito. Pode ser que você seja alertado sobre algum atributo longo demais em algum dos campos, o que pode ser aceito nesse contexto (mas tenha em mente que implica na possibilidade de alguns registros serem truncados).
* Repita o processo para o arquivo CSV contendo os dados históricos sobre os ex-alunos da Universidade de Oxford (`AlumniCounties.csv`)
* Inspecione cada um para refrescar sua memória acerca dos conteúdos das colunas.

 {% include figure.html filename="QGISFigure5.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 6: Copiando uma tabela para o LibreOffice Base" %}

* Vá até o painel `Consultas` e selecione `Criar uma consulta no editor…`, e então adicione ambas as planilhas para que uma pequena janela apareça com as listas dos nomes dos campos de cada tabela. Arraste e solte o campo “Lugar de origem”, na tabela de ex-alunos, sobre o campo `Name` da tabela de condados, vinculando-os.
* Com um clique-duplo em cada campo da tabela de ex-alunos, pode-se adicioná-los à lista de campos abaixo (que definem a estrutura da tabela final, obtida com a consulta).
* Adicione os campos `x` e `y` dos condados ao dar um clique-duplo neles. Essa consulta agora contém todos os dados necessários para o mapeamento.

{% include figure.html filename="QGISFigure6.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 7: O design da consulta finalizado, no LibreOffice Base, mostrando a relação entre as tabelas e a grade detalhando os campos que serão visíveis no produto final" %}

* Clique em `Salvar` e então em `Executar Consulta` (o ícone de três tabelas e um check). Quando estiver satisfeito com os resultados, feche a janela de consulta.
*  Exporte os resultados no formato CSV. No LibreOffice Base, isso é possível ao arrastar a própria consulta sobre a primeira célula de uma nova planilha no LibreOffice Calc. Em seguida, em `Salvar como`,  selecione o formato CSV na aba  `Tipo` na parte de baixo da janela Salvar, e clique em Salvar para criar o arquivo como `GeocodedAlumni.csv`.

*Atenção* Ainda que as consultas da base de dados relacionais como essas são muito boas para combinar múltiplos critérios simultaneamente, elas também podem apresentar resultados errôneos se não checados cuidadosamente. Consulte a seção **Solucionando Problemas com a Base de Dados das Uniões dos Gazetteers** no final desse tutorial para dicas de como inspecionar os resultados das uniões quando trabalhando com os seus próprios dados.


### Adicionando dados geocodificados ao QGIS

Agora, é possível retornar ao QGIS e adicionar os dados de volta no seu mapa, utilizando as novas colunas X e Y para mapear os dados.

*  Use o botão `Adicionar Camada de Texto Delimitado…`  (simbolizado por uma vírgula grande) para adicionar o seu novo arquivo CSV ao seu projeto SIG.
*  Perceba que, quando selecionado esse arquivo CSV, as opções `Primeiro registro tem nomes de campos` e `Definição de geometria: Coordenada de ponto` são ativadas automaticamente, e os campos `X` e `Y` são selecionados nos campos dropdown para as coordenadas X e Y.
*  Uma vez clicado OK, será solicitado que você selecione o SRC para essas coordenadas. Este deve ser o mesmo que aquele escolhido inicialmente ao criar o projeto e exportar a informação do gazetteer: `OSGB 1936 (EPSG:27700)`.
* Clique em OK e os seus dados devem ser mapeados no projeto instantaneamente.

Quando os dados que foram geocodificados como pontos são adicionados dessa maneira, apenas um ponto aparece para cada lugar, inicialmente. Já que cada fileira de dados foi geocodificada com as mesmas coordenadas, elas se sobrepõem e não é possível ver, de imediato, quantas existem.

Existem diversos jeitos de expor esses dados de maneiras mais significativas, e para tal, o QGIS conta com várias vantagens sobre o software comercial líder, o ArcGIS. O método mais básico para isso é o de criar uma nova camada de polígono, contendo uma nova coluna com uma contagem dos pontos contidos dentro de cada polígono (equivalente à função de união espacial do ArcGIS). O resultado desse método seria essencialmente igual ao de catalogar os dados externamente (em uma base de dados ou uma planilha) e então realizar uma união das tabelas.

*  Selecione a ferramenta `Vetor>Analisar>Contagem de pontos em polígono…`
*  Na janela Contagem de pontos em polígonos, selecione a sua camada dos condados (`UKDefinitionA`) como `Polígonos` e a camada geocodificada de ex-alunos importada (`GeocodedAlumni`) como `Pontos`. A caixa `Nome do campo de contagem` automaticamente é preenchida como “NUMPOINTS” — este é o nome da coluna extra a ser adicionada. A última caixa, `Contagem`, especifica o que fazer com o resultado dessa ação; deixando-a na configuração padrão irá criar uma camada nova e temporária (ou seja, que ainda não foi salva em algum arquivo), intitulada `Contagem`. É possível clicar em `...` para especificar o nome de um arquivo para salvá-la imediatamente.
*  Clique em `Executar` e uma nova camada será criada
*  No Painel de Camadas, dê um clique-duplo na nova camada (nomeada `Contagem` caso não tenha sido especificada) e selecione a aba `Simbologia` à esquerda. É, então, possível modificar o dropdown no topo, `Símbolo Simples`, para `Graduado`, a fim de exibir os resultados dos cálculos como uma escala de cores gradual, colorindo os polígonos.
*  Clique no dropdown seguinte, `Valor`, para selecionar a coluna nova `NUMPOINTS` como base.
*  Clique no botão `Classificar`, na parte de baixo, para criar um gradiente baseado na expansão dos números presentes. O padrão é que esse gradiente seja criado com intervalos iguais (baseados no número de classes especificadas à direita), mas você também pode testar mudar o dropdown `Modo` para outras configurações, como o `Desvio Padrão` — os resultados podem ser bem diferentes. Então, clique em OK para ver os resultados.

Uma maneira mais prática de exibir os dados geocodificados é possível utilizando as funções avançadas de exibição do QGIS, como o Mapa de calor ou o Deslocamento de ponto (essas funções são trabalhosas de se replicar no ArcGIS, e envolvem a criação de “representações” paralelas às camadas). Deslocamento de ponto é provavelmente o método mais adequado de se explorar esse tipo específico de dado. A vantagem em exibir os seus dados através de estilos — em vez de mapear um catálogo criado externamente em uma planilha através da união de tabelas (como na primeira parte deste tutorial), ou de seguir os passos anteriores para criar uma cópia dos polígonos contendo uma quantidade de pontos neles inseridos — é que a camada se mantém dinâmica.

*	No Painel de Camadas, novamente clique na camada `GeocodedAlumni` com o botão direito do mouse e selecione `Propriedades`, e então a aba `Simbologia`. No drop down de cima, selecione `Deslocamento de pontos` e clique em `Aplicar`
*  Ajuste as opções para criar uma imagem clara e legível. Trocar o `Método de localização: Anéis` para `Anéis Concêntricos` provavelmente o deixará mais claro. Lembre-se que os tamanhos se mantêm constantes independentemente da quantidade de zoom, então amplie a imagem para ver os resultados mais claramente.
*  O estilo Mapa de calor é outra maneira popular de se representar concentração de pontos. Volte para `Propriedades` e então à aba `Simbologia` da camada  `GeocodedAlumni`, e troque o drop down do topo para `Mapa de calor` e clique em `Aplicar`. 
*  É possível usar as opções para trocar o gradiente, enquanto a opção `Raio` controla o tamanho do "brilho" em torno de cada ponto — quando configurado em um número alto, os pontos concentrados em áreas próximas se fundem, criando um visual mais orgânico (no entanto, você deve considerar se isso representa fielmente os seus dados).
   

{% include figure.html filename="QGISFigure7.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 8: A aba Simbologia nas propriedades de camadas, exibindo o estilo Deslocamento de ponto, representando pontos que se sobrepõem na mesma localização" %}

Com isso, o processo de geocodificação está completo, permitindo-lhe a aproveitar as vantagens de poder analisar espacialmente um dado histórico que é intrinsecamente geográfico. Em uma situação real, você apenas geocodificaria dados mais precisos do que escalas em níveis provinciais, criando um potencial analítico maior e tornando os mapas elaborados mais significativos. Na presença de dados que possam ser geocodificados em nível de precisão alto — e crucialmente consistente —, é possível conduzir uma ampla variedade de análises geográficas, como a medição de aglomerações ou de distâncias.

Por exemplo, os registros mapeados são facilmente ajustáveis e refináveis ao mudar a definição da consulta nas propriedades da sua camada geocodificada (dê um clique-inverso em `GeocodedAlumni`, no Painel de Camadas, e selecione `Propriedades>Fonte>Filtragem de feição do provedor>Ferramenta de consulta`). Você pode usar os filtros “Acima de” e “Abaixo de” para definir os anos e conferir se as tendências mudaram no decorrer do tempo, ou usar o comando [SQL LIKE](https://www.w3schools.com/sql/sql_like.asp) para consultar a coluna “Detalhes” a fim de filtrar faculdades específicas — será que elas costumavam atrair estudantes de determinados condados? Essas consultas usam a linguagem SQL padrão, e podem ser combinadas com `AND`, `NOT` etc. Esse exemplo selecionaria apenas os alunos matriculados na Faculdade de Magdalen:

```
"Details" LIKE '%Magdalen Hall%'
```
Enquanto esse selecionaria apenas aqueles matriculados antes de 1612:

```
"Matriculation Year" < 1612
```

### Geocodificando seus próprios dados históricos

O processo aqui percorrido — o de combinar usando consultas externas — é aplicável a uma grande variedade de cenários, sempre que você possa adquirir ou criar um gazetteer adequado. Lembre-se que o seu sucesso vai depender da consistência e precisão dos seus dados. Certifique-se de que as mesmas convenções são seguidas tanto nos dados quanto no gazetteer, principalmente quanto à pontuação (veja: “Devon” ou “Devonshire”, “Hay-on-Wye”, ou “Hay on Wye”). Caso tenha a sorte de trabalhar com dados apresentados em um formato moderno (como países, ruas e até mesmo códigos postais modernos), é possível utilizar os processos mais simples de geocodificação automatizada. Consultas a seção abaixo.

Caso você possua apenas um pequeno número de fileiras em seus dados, ou caso tenha dificuldades em padronizar as informações de localização em um único campo para que sejam geocodificadas pelos métodos ensinados nesse tutorial, lembre-se que é possível realizar esse processo manualmente. Basta utilizar uma das diversas ferramentas online de geocodificação para encontrar as coordenadas X e Y para cada fileira de dados nas colunas X e Y da sua planilha ou base de dados manualmente. Mas lembre-se de anotar o sistema de coordenadas utilizado pela ferramenta utilizada para encontrar tais coordenadas (provavelmente, WGS1984)! Caso tenha dados geocodificados manualmente dessa forma, apenas siga as instruções acima a partir de “Adicionando Dados Geocodificados ao QGIS”.


### Solucionando problemas com a base de dados dos gazetteers unidos

Ainda que as consultas de base de dados relacionais são ferramentas extremamente úteis para a geocodificação personalizada, ao lhe permitirem combinar múltiplos critérios simultaneamente, elas também podem apresentar resultados enganosos se não revisados cuidadosamente. Geralmente, qualquer dado que não for combinado vai ser “silenciosamente” ignorado (ou seja, você não receberá um alerta de erro), portanto, é importante verificar se o número de fileiras nos resultados corresponde àquele dos dados originais.

Se existir muitos poucos resultados, quer dizer que alguns atributos não podem ser combinados. Nesta tabela, por exemplo,
 `Place of origin` inclui atributos como “Londres” e “Alemanha”, que não correspondem a nenhum lugar do gazetteer criado. Nesse caso, a baixa quantidade de resultados pode ser vista como aceitável, ou você pode tentar corrigi-la alterando os lugares de origem ou adicionando manualmente os lugares ao seu gazetteer. Trocar as propriedades da união entre as duas tabela, de `Inner Join` para `Right Join`, fará com que TODOS os registros da tabela de ex-alunos sejam devolvidos, com ou sem dados que correspondam à tabela `Condados`do gazetteer (presumindo que a tabela de ex-alunos esteja à direita). Esta é uma etapa diagnóstica bastante útil.
 
Caso existam muitos resultados, então cada fileira em uma tabela se associa a diversas fileiras de uma outra. Isso é um tanto quanto comum em dicionários geográficos, já que é comum existirem pontos duplicados com o mesmo nome, ou nomes bem semelhantes, em várias bases de dados. Isso se mostra ainda mais verdadeiro com dicionários geográficos de alta resolução, que podem conter vários bairros dentro de uma única cidade, mas é à coluna “Cidade” que você deseja associar os dados. Para evitar essas duplicatas avulsas, pode-se usar as funções da base de dados para garantir que apenas um resultado apareça do gazetteer. Caso encontre esse problema, deve-se primeiro criar uma consulta que use as funções `minimum` ou `maximum` (chamadas funções aditivas em Acesso) no campo de identificação do seu gazetteer, junto da função `agrupar por` no campo dos nomes do seu gazetteer, a fim de isolar uma única ocorrência de cada lugar. Pode-se considerar isso uma sub-consulta e adicioná-la à sua consulta preexistente, unindo o novo campo de identificação ao campo preexistente do gazetteer através do comando `Inner Join` para garantir que apenas um exemplo de cada lugar seja associado.

## Postscript: Geocodificando endereços modernos

Caso tenha dados contendo endereços atuais (como endereços postais que usem os nomes das ruas, os códigos postais ou ZIP contemporâneos, ou descrições de alto nível, como cidades ou condados cujos nomes seguem as convenções modernas), geocodificá-los é muito simples, utilizando apenas ferramentas onlines ou ferramentas que utilizam [APIs](https://pt.wikipedia.org/wiki/Interface_de_programa%C3%A7%C3%A3o_de_aplica%C3%A7%C3%B5es) online. Lembre-se que as chances de geocodificação online funcionar são poucas caso qualquer um desses elementos não forem consistentes com os endereços dos dias atuais.

Os grandes provedores de mapeamento online, como o Google, Bing e o OpenStreetMap, todos oferecem conexões API (Application Programming Interface) às suas ferramentas altamente sofisticadas de geocodificação. São essas ferramentas que operam as funções de busca nesses sites, então são eficazes em “adivinhar certo” endereços ambíguos ou incompletos. Vale ressaltar que, quando acessados por um API ao invés dos sites normais, é preciso fornecer o nome do país como parte do endereço.

- O Google fornece duas ferramentas online que permitem o uso direto das suas ferramentas de geocodificação, bem como de sua cartografia: [Google My Maps](https://www.google.com/maps/d/) e [Google Fusion Tables](https://support.google.com/fusiontables/answer/9551050?visit_id=638272018143131975-1148733702&rd=1). Ambas permitem o upload de planilhas com colunas de endereços, que são geocodificadas automaticamente.
- No QGIS, esses APIs são disponibilizados para geocodificar dados por meio de uma variedade de plugins dedicados. Atualmente (Fevereiro de 2017), o mais popular e apoiado destes é o MMQGIS.
*  Instale o MMQGIS utilizando a ferramenta Gerenciar e Instalar Plugins
*  Uma vez instalado, um novo menu do MMQGIS irá aparecer na barra de menu. `Geocoding` é uma das várias opções do seu menu, e `GeoCode CSV using Google Maps / Open Street Map` sendo uma opção dentro dela.
*  A caixa de diálogo `GeoCode CSV using Google Maps / Open Street Map` lhe permite fazer o upload de uma tabela de dados de um arquivo CSV e especificar quais colunas contêm endereços (ruas), cidade, estado e país. Estes são, então, processados através do serviço online escolhido. Os resultados obtidos são criados como pontos em uma camada nova (no shapefile especificado). As fileiras que não correspondiam ficam listadas em um novo arquivo CSV que é criado.

{% include figure.html filename="QGISFigure8.png" alt="DESCRIÇÃO VISUAL DA IMAGEM" caption="Figura 9: A caixa de diálogo Serviço Online de Geocodificação do plugin MMQGIS" %}
