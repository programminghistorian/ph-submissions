---
title: Utilização de Dados Geoespaciais para a Pesquisa Histórica em R
collection: lessons
layout: lesson
slug: utilizacao-dados-geoespaciais-r
date: 2018-08-20
translation_date: 2021-07-28
authors:
  - Eric Weinberg
reviewers:
  - Lauren Tilton
  - Adam Crymble
  - Ryan Deschamps
editors:
  - Jessica Parr
translator:
  - Diana Rebelo Rodriguez
translation-editor:
  - Joana Vieira Paulino
translation-reviewer:
  - 
  - 
difficulty: 2
review-ticket: 
activity: analyzing
topics: [mapping]
abstract: "Nesta lição, usaremos a linguagem de programação R para analisar e mapear dados geoespaciais."
avatar_alt: Uma vista aérea dos quarteirões da cidade
doi: 
---

{% include toc.html %}

## Introdução
Um dos principais focos dos estudos históricos é explicar as complexas relações que influenciam a mudança no passado. Na maioria das vezes, os padrões de mudança são compreendidos e dependem de entendimentos geográficos - ou variações no espaço. A Grande Migração, o desenvolvimento precoce da economia europeia e o desenvolvimento do *American West* (a costa oeste dos Estados Unidos) são apenas alguns tópicos de natureza histórica e geográfica. A combinação do conhecimento tanto do espaço como do tempo pode proporcionar uma compreensão mais completa dos eventos e das transformações. Isto é ainda mais evidente quando somos capazes de discernir características sobre as pessoas/populações que fazem parte das transformações/eventos históricos.

Uma forma de fazer isso é através de uma série de mapas e visualizações que retratam as realidades geográficas. Há muito tempo que os historiadores usam mapas para explicar transformações históricas, tais como desenvolvimentos económicos e padrões de migração. Com o surgimento das tecnologias digitais, desenvolveram-se mapas mais complexos e os estudiosos integraram neles informações mais complexas, juntamente com novas visualizações geográficas.[^1]

A disponibilidade de Sistemas Históricos de Informação Geográfica expandiu isto ainda mais, fornecendo aos académicos oportunidades para analisar mais data points usando ferramentas digitais e estatísticas como o R. Com estas novas ferramentas, os pesquisadores conseguem estudar uma infinidade de características populacionais que podem ser visualizadas e analisadas através de regiões e períodos de tempo variáveis. Essencialmente, isto permitiu-lhes configurar dados geográficos em torno das suas áreas de investigação, acelerando o crescimento da "história espacial”. Com estes dados, os académicos podem indagar não apenas como a mudança histórica se relaciona com o lugar, mas também como ela se relaciona com uma infinidade de características populacionais, testando teorias de forma rápida. Havia uma possível ligação entre o desenvolvimento ferroviário e a mudança na composição de género das populações vizinhas? Existiam outras relações? O que isto diz sobre o desenvolvimento destas regiões? Estamos limitados apenas pelos dados disponíveis e pelas perguntas que escolhemos fazer. Estas técnicas oferecem aos pesquisadores a oportunidade de testar suposições e construir entendimentos que podem não ser facilmente compreendidos na pesquisa tradicional ou em técnicas de mapeamento.

Este tutorial apresentará aos estudiosos algumas destas técnicas de processamento de dados geoespaciais, focando na forma como os dados geoespaciais podem ser analisados estatisticamente, bem como visualizados. Vamos comparar regiões espaciais e alavancar a variabilidade das populações entre regiões espaciais definidas, tais como condados. Esta variabilidade pode fornecer ideias sobre uma ampla gama de movimentos sociais. Além disso, pode ser usada para avaliar variações significativas nas regiões usando alguns modelos estatísticos básicos. Utilizando estes métodos, assumimos que existe um nível de continuidade ou homogeneidade dentro das regiões definidas.[^2] Podemos aproveitar estes entendimentos para avaliar eventos e movimentos históricos. Por exemplo, se uma grande proporção de membros de um determinado grupo vier de um grupo de condados, as características desses condados podem fornecer uma ideia da natureza desse movimento;[^3] ou se um conjunto de eventos acontecer em determinados condados, podemos perguntar se têm algo de particular que possa estar ligado ao evento. Em alguns casos, a análise também pode revelar realidades ocultas sobre movimentos ou eventos sociais, com base na sua natureza geográfica. Por exemplo, se passarmos por características de uma área próxima a um evento espacial, poderemos descobrir uma característica desconhecida que nunca percebemos correlacionada com o evento em particular, levando a novas possibilidades de pesquisa. Espera-se descobrir tendências que possam ser surpreendentes ou algumas que não sejam tão fortes como se supõe.

Especificamente, este tutorial vai usar uma lista de associados de uma organização para-religiosa na América (PTL Ministries) - com endereços - e dados geográficos disponíveis para download, para avaliar as características da população que poderiam fornecer ideias sobre uma organização que é frequentemente vista como mais rural e menos rica, juntamente com uma série de outras características. Com este tutorial procuramos visualizar e analisar esses dados para avaliar possíveis perceções. Este processo fornecerá as ferramentas básicas e entendimentos que permitirão aos estudiosos avaliar outros eventos e organizações que tenham dados geográficos. A partir disso, deve-se ser capaz de descobrir ou desafiar a compreensão de eventos históricos usando a análise geoespacial.

## Pré-requisitos
O trabalho para esta lição será feito em R e RStudio, um pacote estatístico de código aberto utilizado por cientistas de dados, estatísticos e outros pesquisadores. Vamos utilisar o R, porque é uma ferramenta de código aberto amplamente utilizada que nos permitirá visualizar e analisar os nossos dados, usando uma multiplicidade de métodos que podem ser expandidos com bastante facilidade. Será útil ter algum conhecimento de fundo do software e de estatística. Para introdução ao R, recomendamos o tutorial [r-basics](/lessons/r-basics-with-tabular-data) (em inglês) e os métodos mais abrangentes de [Digital History Methods in R](http://lincolnmullen.com/projects/dh-r2/) (História Digital em R, em inglês) como pontos de partida. Há muitos outros serviços como este [MOOC](https://www.coursera.org/learn/r-programming)](https://www.coursera.org/learn/r-programming) e [DataCamp](https://www.datacamp.com/) que podem introduzir os iniciantes à funcionalidade mais ampla do R. A [[UCLA](http://www.ats.ucla.edu/stat/r/default.htm)](http://www.ats.ucla.edu/stat/r/default.htm) também tem uma boa introdução.[^4] Estes cursos são todos em inglês. Embora este tutorial tente passar por todo o processo em R, o seu conhecimento básico é necessário. O tutorial também assume que os usuários terão algum conhecimento sobre o evento que está a ser observado, o qual será usado mais tarde como meio para testar e contestar suposições.


## Objetivos da lição
* Fornecer conhecimentos básicos sobre como utilizar dados geográficos para analisar movimentos históricos, especialmente, movimentos onde temos conjuntos de dados ou listas que são de natureza geográfica
* Demonstrar como fundir pontos geográficos ou listas de associados com dados geoespaciais para análise posterior
* Demonstrar como visualizar estes dados geograficamente para análise usando coropletos
* Destacar algumas visualizações e modelos estatísticos que podem fornecer mais informações



## Como começar
Este tutorial assume que já se possui o [R ou o R studio](https://www.youtube.com/watch?v=Ohnk9hcxf9M) ou um [R studio para Mac](https://www.youtube.com/watch?v=ICGkG7Gg6j0). Uma vez configurado, deve-se abrir o programa. Recomendamos a criação de um novo projeto e a criação de um diretório de trabalho onde serão armazenadas todas as suas informações.


Os primeiros passos são carregar os pacotes necessários que permitirão ao R executar as funções geográficas utilizadas para este tipo de análise:

```r
install.packages("sf")  # ajuda a trabalhar com dados espaciais
## para requerimentos e instruções específicas ver https://github.com/r-spatial/sf
install.packages("tmap")  # ajuda a criar coropletos simples
install.packages("plotly")  # ajuda a criar gráficos de dispersão
library(sf)
library(tmap)
library(plotly)
```

## Os Dados
Estamos a usar duas fontes de dados neste tutorial: a nossa lista de endereços da organização e os dados geoespaciais que fizemos o download e que contêm os dados demográficos e geográficos que auxiliarão a nossa análise. Vamos começar com os dados geoespaciais. Estes dados são formatados como um [shapefile]([https://enterprise.arcgis.com/pt-br/portal/latest/use/shapefiles.htm](https://enterprise.arcgis.com/pt-br/portal/latest/use/shapefiles.htm)). Os shapefiles são ficheiros de dados que representam as regiões geográficas e que também podem conter características sobre essa região. O censo dos EUA contém um conjunto de informações em formato shapefile.

Mas, para obter estas informações dos censos históricos, vamos utilizar dados do [National Historical Geographic Information System](https://www.nhgis.org) (NHGIS ou Sistema Nacional de Informação Geográfica e Histórica), gerenciado pelo Centro de População de Minnesota, na Universidade de Minnesota. O NHGIS armazena dados dos censos históricos que cobrem toda a história dos Estados Unidos. Para utilizar os seus serviços, é necessário, primeiro, registrar-se e criar uma conta. Uma vez concluído este processo, pode-se usar um [banco de dados](https://data2.nhgis.org/main) (em inglês) próprio para selecionar o nível geográfico, o período de tempo e os dados que lhe interessam. Esta lição fornece instruções detalhadas sobre como usar este serviço para extrair informações do censo ao nível de região. No entanto, forneceremos os dados para download.

Se estiver à procura de dados para um nível nacional anterior a 1990, os dados por condado são, frequentemente, a sua melhor aposta, já que níveis geográficos mais precisos não haviam ainda sido padronizados. Para algumas regiões e cidades, entretanto, existem níveis mais precisos e, em alguns casos, menores do que os códigos postais. Para este tutorial, usaremos dados ao nível do condado a partir de um censo decenal adequado ao tempo. Em geral, é melhor usar a menor região geográfica possível, mas as pesquisas históricas muitas vezes acabam por ser feitas ao nível do condado. Os centros populacionais maiores costumam ter dados históricos mais detalhados, mas as áreas rurais não foram completamente cobertas até o censo de 1990. Para uma descrição mais detalhada das regiões do censo e um mapa interativo, veja a [discussão do NHGIS](https://www.nhgis.org/user-resources/data-availability#table-data) (em inglês).

## Leitura dos Dados
Começamos por carregar os dados selecionados. Pode fazer o download dos dados para este tutorial [aqui](/assets/geospatial-data-analysis/data.zip). Depois, coloque todos os ficheiros numa pasta de dados rotulada dentro do seu diretório de trabalho do R. Vamos criar uma variável e ler os dados de nosso diretório de variáveis nela. Uma vez executada, a variável `Dados_Agregados_Condados` conterá os dados e informações geográficas que analisaremos:

```r
Dados_Agregados_Condados  <-  st_read("Archive/data/County1990ussm/")
```
Agora devemos ter um objeto carregado com dados anexados:

![DataLoaded.png](/images/geospatial-data-analysis/DataLoaded.png "Dados carregados no R")

Se apenas estiver interessado em observar determinados estados, recomendamos filtrar os resultados para acelerar o processamento e a análise dos dados. Para isso, use os seguintes comandos:

```r
Dados_Agregados_Condados  <-  Dados_Agregados_Condados[which(Dados_Agregados_Condados$STATENAM  %in%  c("North Carolina","South Carolina")),]
```

De acordo com este comando, podemos observar a distribuição dos dados usando o comando `summary` (resumo) para garantir que os dados observados foram os que acabamos de filtrar:

```r
summary(Dados_Agregados_Condados)
```

Isto irá devolver-nos vários dados resumidos, mas o mais importante é mostrar que temos dados apenas para os estados filtrados:


![Data2.png](/images/geospatial-data-analysis/Data2.png "Dados carregados no R 2")

Opcionalmente, também é possível traçar os resultados para visualizar um mapa dos dados que fizemos o download. Isto pode levar algum tempo, especialmente se os dados não estiverem filtrados. Como mencionado acima, isto ajuda a confirmar que estamos a observar as áreas geográficas corretas, pois apenas as áreas filtradas devem ser desenhadas. Abaixo usaremos a função gráfica básica de R para fazê-lo:

```r
plot(Dados_Agregados_Condados$geometry,axes=TRUE)
```

![NCSC.png](/images/geospatial-data-analysis/NCSC.png "Primeiro mapa")

## Fusão de dados do Censo
Atualmente, nossa variável `Dados_Agregados_Condados` possui os limites geográficos necessários para a nossa análise (como o gráfico acima destacado), mas não as informações demográficas que nos permitirão avaliar as características de nossa lista de associados. Embora os dados demográficos tenham vindo juntamente no ficheiro com os dados geográficos, eles precisam de ser fundidos na nossa variável `Dados_Agregados_Condados`, que é um `DataFrameEspacial`. O próximo passo é começar a fundir `Dados_Agregados_Condados` com dados da tabela NHGIS no diretório de dados que fizemos o download.

Vamos ler os dados NHGIS e fundi-los no campo comum. Os parâmetros `by.x`e `by.y` indicam em que campos os dados vão ser unidos:

```r
Dados_Censo <-  read.csv("Archive/geospatial-data-analysis/County1990_Data/nhgis0027_ts_nominal_county.csv",  as.is=TRUE)
Dados_Agregados_Condados  <-  merge(Dados_Agregados_Condados,Dados_Censo,by.x="GISJOIN",  by.y="GISJOIN")
```
O número de variáveis em `Dados_Agregados_Condados` deve agora aumentar à medida que todos os dados da tabela foram trazidos para este único objeto. Agora temos um grande `DataFrameEspacial`, com todos os dados geográficos e estatísticos que fizemos o download. Poderíamos parar e analisar estes dados, mas são apenas os dados brutos do censo e ainda não estão conectados ao evento histórico ou aos dados que estamos a analisar.

## Fusão de dados externos
O próximo passo é fundir a nossa lista com nosso `DataFrameEspacial` para que possamos realizar a nossa análise. Quando utilizamos uma lista de associados, esta pode ser qualquer lista que seja de natureza geográfica. Por exemplo, pode-se ter uma lista de eventos que aconteceram durante um determinado período de tempo; ou uma lista de lugares que um indivíduo opta por visitar. Este tipo de dado virá em dois formatos básicos. O primeiro serão informações como locais, endereços ou locais de incidentes - que serão convertidos em coordenadas geográficas. O segundo será uma tabela que lista as mesmas informações ao lado do condado (ou região geográfica) onde ocorreu. Podemos tratar qualquer um dos dois.

## Geocodificação
No primeiro caso, temos os endereços dos membros de nossa organização, o que exigirá alguns passos adicionais. O endereço precisa de ser transformado em pontos geográficos num processo chamado [geocodificação]( https://www.cognatis.com.br/o-que-e-geocodificacao/). Isto criará pontos geográficos - de endereços - que podem ser ligados a regiões espaciais dos nossos dados do censo, para que possamos analisá-los e descobrirmos tendências relacionadas à localização geográfica desses endereços. O R pode fazer parte deste trabalho, mas se tiver um grande número de endereços, será necessário usar um serviço externo, porque os serviços gratuitos que R usa (como o Google) irão limitar quantos endereços podem ser geocodificados num único dia. Um serviço externo popular é hospedado pela [Texas A&M Geocoding Services](http://geoservices.tamu.edu/Services/Geocode/) e pode lidar com grandes lotes a um preço razoável. No final, o nosso endereço será transformado numa lista de latitudes e longitudes. Estes são os dados que o R precisa.

Se tiver menos de 2,500 endereços, podem ser tratados no R através do geocoder do Google. Em R, deve-se primeiro reunir o endereço a partir de qualquer conjunto de dados que se tenha e, depois, transformá-lo. No nosso exemplo, os dados já foram geocodificados, mas abaixo está um exemplo dos comandos usados ao processar uma lista de endereços e transformá-los numa lista de coordenadas geográficas:

```r
Endereços <-  data$Address
Coordenadas_Membros <-  geocode(Endereços)
```
No nosso exemplo, já possuímos uma lista de coordenadas geográficas. Mas ainda precisamos de fundi-la com nosso `DataFrameEspacial (Dados_Agregados_Condados)`. Para que possamos analisá-lo em relação aos dados geográficos e ao censo que fizemos do download. Uma vez que os nossos dados estejam geocodificados, usaremos o primeiro comando abaixo para puxar esses dados.

```r
endereços_geocodificados  <-  read.csv("Archive/geospatial-data-analysis/GeocodedAddresses.csv",  as.is=TRUE)
#ou
endereços_geocodificados  <-  Coordenadas_Membros  ##se este endereço acabou de ser geocodificado
```

Agora, precisamos de remover os registos com dados vazios que representam endereços que não puderam ser geocodificados:

```r
# Agora remova dados vazios ou linhas que não geocodificaram
endereços_geocodificados  <-  endereços_geocodificados[!is.na(endereços_geocodificados$Latitude)  &  !is.na(endereços_geocodificados$Longitude),]
```
Em seguida, convertemos os dados num ‘DataFrameEspacial’ para que possam ser fundidos [^5] com `Dados_Agregados_Condados` que contém os dados importados anteriormente. Podemos ver o processo abaixo:

```r
# Agora crie o dataframe com informações geográficas para os pontos de fusão
pontos <-  st_as_sf(endereços_geocodificados,  coords=  c("Longitude","Latitude"),crs  =  4326,  agr  =  "constant")

```
Antes de fazer a fusão propriamente dita, devemos garantir que ambos os objetos utilizam os mesmos sistemas de coordenadas. Caso contrário, os pontos e os condados não se igualarão. Para fazê-lo é preciso transformarmos os nossos dados do censo no nosso sistema atual.

```r
Dados_Agregados_Condados  <-  st_transform(Dados_Agregados_Condados,  st_crs(pontos))
```
Optamos por visualizar a distribuição dos dados dos pontos dentro do censo. Fizemo-lo por algumas razões: primeiro, para verificar se a fusão funcionará corretamente; segundo, para começar a olhar para a distribuição dos dados. Devemos ver uma lista de números onde cada lista representa os pontos que se cruzaram com um determinado condado. Muitas das possíveis ideias virão desta distribuição. Se os condados com características particulares apresentarem uma distribuição mais elevada, isso pode fornecer uma ideia sobre a nossa associação. Vamos analisá-lo mais a fundo à medida que prosseguirmos, mas estamos a começar a ver algumas informações aqui:

```r
st_intersects(Dados_Agregados_Condados,pontos)  # mostra em quais condados cada ponto cai
```
Também podemos colocar os data points no topo de nosso mapa para uma rápida visualização de nossos dados novamente usando o gráfico e [alguns parâmetros]([http://ecor.ib.usp.br/doku.php?id=02_tutoriais:tutorial5:start](http://ecor.ib.usp.br/doku.php?id=02_tutoriais:tutorial5:start)) para uma melhor visualização:

```r
plot(Dados_Agregados_Condados$geometry,axes=TRUE)
plot(pontos[which(pontos$State  %in%  c("NC","SC")),]$geometry,col  =  "green",  pch=20,cex=.5,  axes=TRUE,add=TRUE)
```
Agora podemos fazer a fusão. Esta é um pouco diferente da anterior, pois vamos criar um novo campo que representa o número de "acertos" dentro de um condado. Essencialmente, a variável `ContagemMembros` representará agora o número de membros num determinado condado que, como os dados de distribuição acima, nos permitirá começar a obter ideias a partir dos dados. Vamos usar o `st_intersects` com o `sapply` para calcular este valor. No fundo, estamos a transformar as nossas listas em dados de contagem para que possamos visualizar e analisar os dados:

```r
Dados_Agregados_Condados$ContagemMembros  <-  sapply(st_intersects(Dados_Agregados_Condados,pontos),  function(z)  if  (length(z)==0)  NA_integer_  else  length(z))
```
Agora temos um grande banco de dados chamado `Dados_Agregados_Condados` que tem os nossos dados de contagem e os nossos dados de censo por condado. O `ContagemMembros` agora contém a contagem dos membros dos seus respetivos condados. Mas também podemos querer fundir dados que não sejam um ponto geográfico, mas sim uma contagem de eventos/membros e condados associados. Essencialmente, estes dados que já são contados para as regiões geográficas nas quais estamos interessados. Para maior precisão, estes dados devem ser aproximadamente do mesmo período de tempo que os dados espaciais. No nosso exemplo, temos uma lista de igrejas por denominação, o que esperamos que nos proporcione uma visão adicional dos dados, pois podemos avaliar se os condados com um alto número de igrejas de uma denominação particular também tendem a ter muitos membros na nossa organização. Para fazer isso, precisamos de carregar a lista:

```r
religião <-  read.csv("Archive/geospatial-data-analysis/Religion/Churches.csv",  as.is=TRUE)
```
Dependendo do estado dos dados, pode ser preciso fazer algumas transformações para fundi-los com o dataframe. Para transformações complexas, veja tutoriais em R sobre como trabalhar com dados, tais como sobre [Gestão de Dados em R]( /en/lessons/data_wrangling_and_management_in_R) (em inglês) e sobre [transformação de dados](https://curso-r.github.io/ragmatic-book/transformacao-de-dados.html) (em inglês). No fundo, precisamos de ter um campo comum em ambos os conjuntos de dados para fundir. Muitas vezes, esta é uma identificação geográfica para o condado e o estado representado pela `GEOID`. Também poderia ser o Código FIPS exclusivo dado pelo Censo dos EUA. Abaixo usamos o `GEOID` estadual e municipal. Neste exemplo, estamos a converter os campos comuns de um dataframe em numéricos para que correspondam ao tipo de variável do outro dataframe:

```r
religião$estadoFP <- religião$STATE
religião$condadoFP <- religião$COUNTY
Dados_Agregados_Condados$estadoFP <- as.numeric(as.character(Dados_Agregados_Condados$STATEFP))
Dados_Agregados_Condados$condadoFP <- as.numeric(as.character(Dados_Agregados_Condados$COUNTYFP))
```
Em seguida, fundimos os dados com o `DataFrameEspacial`, onde as identidades do estado e dos condados coincidem. Este método é semelhante ao método de fusão usado anteriormente, mas agora estamos a juntar múltiplos campos. Para lidar com esta situação, estamos a usar um formato diferente:

```r
Dados_Agregados_Condados<-  merge(Dados_Agregados_Condados,religião,by=c("estadoFP","condadoFP"))
```
Isto irá trazer todos os campos adicionais para nosso `DataFrameEspacial`.

Agora temos um grande `DataFrameEspacial` chamado `Dados_Agregados_Condados` que tem os nossos dados de contagem geocodificados, de contagem externos e de censo por condado. Agora é a hora de começar a analisar a distribuição dos dados e avaliar se tudo parece correto e se está num formato que permitirá alguma visualização e análise dos dados. Temos alguma complexidade inerente aos nossos dados porque são considerados "dados de contagem". Como tal, devemos estar cientes de que esses dados não medem indivíduos diretamente, mas sim as relações entre os condados. Estamos a tentar descobrir se os condados com certas características levam a uma maior participação nos nossos conjuntos de dados. Estas realidades podem ajudar-nos a reunir algumas suposições sobre os indivíduos destas regiões.

## Visualização
Como estamos a analisar dados geoespaciais, muitas vezes é melhor começar com os visuais geográficos. Existem muitas opções, mas o mais fácil é começar com a função qtm do pacote TMAP, que cria [[mapas](https://pt.wikipedia.org/wiki/Mapa_coropl%C3%A9tico) coropletos](  https://pt.wikipedia.org/wiki/Mapa_coropl%C3%A9tico) de forma simples. Poderíamos também usar o [GGPlot2](  https://web.archive.org/web/20190922234254/http:/strimas.com/r/tidy-sf/), que deve ser instalado usando a versão em desenvolvimento.

Agora, vamos preparar o mapa e ver alguns dados do censo. Na nossa lista, primeiro devem constar os números de associados relativos à população (distribuição relativa dos associados). Uma das formas mais comuns e claras de exibir estas informações é pelo número de membros por 10,000 pessoas. Depois faremos as contas para criar uma variável relativa da população (número de membros por 10,000 pessoas). Fazemos isto porque temos que garantir que estamos a levar em conta a variabilidade das populações dentro das regiões do censo que estamos a analisar. Caso contrário, teremos uma visualização enganosa em condados densamente povoados que representam tendências gerais da população em vez de relações variáveis. Sem este passo, sem dúvida veríamos um mapa que destaca as áreas urbanas em vez das áreas onde a adesão é mais forte.

Para começar a olhar para estes dados, precisamos de encontrar a variável no nosso `DataFrameEspacial` que representa a população. Nas pastas de dados do censo que fizemos o download, há um livro de código que revela quais campos representam quais dados. Depois de procurar no livro de código, descobrimos que `AV0AA1990` é a população total do Censo a partir de 1990. Abaixo, pegamos nesta variável e transformámo-la numa variável que se ajusta às flutuações da população (número de membros por 10,000 pessoas):

```r
Dados_Agregados_Condados$RelativeTotal=  ((Dados_Agregados_Condados$AV0AA1990/10000)/Dados_Agregados_Condados$ContagemMembros)
```

Agora vamos criar o mapa. TMAP permite a criação rápida de mapas temáticos ou, mais especificamente, de coropleto. Também podemos variar o tamanho do texto com base noutra variável do censo. Aqui utilizamos a contagem de pessoas que vivem em áreas rurais `(A57AA1980)`, tornando o texto maior nos condados mais rurais. Agora posso começar a avaliar visualmente se os condados com maior distribuição de membros também tendem a ser mais rurais, como já foi descrito. Como os dados mostram, a filiação não é claramente tendenciosa para os condados rurais exclusivamente, o que nos dá a nossa primeira ideia:

```r
qtm(shp  =  Dados_Agregados_Condados,  fill  =  "RelativeTotal",text="NHGISNAM",text.size="A57AA1980")
```

![CH1.png](/images/geospatial-data-analysis/CH1.png "Coropleto dos dados normalizados")


Sinta-se à vontade para fazer testes com o coropleto. Em particular, tente trocar a variável `text.size` para ver se é possível descobrir padrões que possam parecer estar ligados à associação. Podemos detectar alguma tendência entre as cores do coropleto e o tamanho do texto? A variável renda seria outro teste que poderia ser executado para verificar se os condados com maior representação são mais ricos. Naturalmente, estas visualizações também são úteis como meio para apresentar informações.

Também é possível olhar para a distribuição não ajustada que mostra a distribuição bruta dos membros (sem ajuste para a distribuição da população local)[^6]:

```r
qtm(shp  =  Dados_Agregados_Condados,  fill  =  "ContagemMembros",text="NHGISNAM",text.size="A57AA1980")
```

## Visualização de Relações Entre Dados
Embora os coropletos e as suas múltiplas variações sejam uma maneira extremamente útil de visualizar os dados geoespaciais, existem outros métodos para o mesmo fim. Um método útil é o gráfico de dispersão, um meio visual para mostrar as relações entre duas variáveis. Em particular, permite avaliar se há correlações entre os nossos dados de eventos e outras características definidas pelos dados do censo. Por exemplo, vemos uma correlação entre os condados com baixa renda média e a filiação. Se assim for, isso pode indicar algo sobre a natureza do movimento ou organização. Poderíamos observar uma multiplicidade de fatores nesse sentido e os nossos dados censitários e o nosso livro de códigos têm muitos. [Embora as correlações não sejam as únicas que provam a causalidade]( ([http://blog.bravi.com.br/correlacao-e-causalidade/](http://blog.bravi.com.br/correlacao-e-causalidade/)), fornecem uma visão básica. Ao fazer estas comparações, precisamos novamente de garantir que estamos a levar em conta a variabilidade das populações dentro das regiões do censo que estamos a analisar. Caso contrário, obteremos correlações enganosas em condados densamente povoados. Para fazê-lo, precisamos de converter qualquer número de população em números por 10,000 pessoas.

Se, por exemplo, quiséssemos usar a variável `B18AA1990` pessoas-brancas, deveríamos convertê-la num número relativo:

```r
BrancosPor10K  <-  ((Dados_Agregados_Condados$B18AA1990/Dados_Agregados_Condados$TOTPOP)*10000)
```

Outros dados totais devem ter em conta também o tamanho regional. Por exemplo, se quiséssemos olhar para igrejas com uma denominação em particular, precisaríamos de convertê-lo também, porque os condados maiores seriam inerentemente mais propensos a ter igrejas de qualquer denominação em particular, apresentando correlações enganosas. Para verificar as igrejas Assembleias de Deus (*Assemblies of God churches*, em inglês), faríamos:

```r
Assembleias_de_Deus_Por10K  <-  ((Dados_Agregados_Condados$AOG.C/Dados_Agregados_Condados$CHTOTAL)*10000)
```
Poderíamos então plotar esta variável com a variável de membros para procurar correlações.

```r
plot(Assembleias_de_Deus_Por10K,Dados_Agregados_Condados$BD5AA1990)
```

Este comando resultará numa notável, mas pequena correlação, o que faz sentido, uma vez que a organização para-igreja estava afiliada à denominação de Assembleias de Deus. Na maioria das vezes, vamos comparar os data points com nossos dados históricos, mas também podemos inspecionar outras relações nos dados do censo geral que podem fornecer informações básicas sobre as áreas de investigação. Por exemplo, aqui está um gráfico de dispersão de raça e renda per capita nas Carolinas:

```r
plot(BrancosPor10K,Dados_Agregados_Condados$BD5AA1990)
```
Abaixo verificamos os resultados do código acima. Vemos o que é descrito como uma forte correlação positiva, o que é típico nos Estados Unidos, pois há fortes correlações entre raça e renda. Conforme a percentagem de pessoas brancas aumenta, a renda per capita aumenta em proporção. Os pontos no gráfico representam os pontos de atração destes dois valores. Podemos medir isto estatisticamente, mas também podemos observar visualmente.


![Plot.png](/images/geospatial-data-analysis/Plot.png "Gráfico de dispersão de pessoas brancas por renda per capita")

![](https://lh3.googleusercontent.com/7-L-9UCex9-ZQ-0bSVLD60iM2MLy70oBukZl-iolKZP4VxMGjjsiRy2JxlMkdRUbJONRzXXuat-tVCYSGwjStrIRIXPE9n7KjNNheA9vZ0nBC_WeorV2RUl2GXvwdA5LSirpI9Y)

Podemos ver isso com mais precisão acrescentando uma linha de melhor ajuste que representa um valor estimado com base nos dados apresentados. Também acrescentamos linhas vermelhas, representando a distância desta linha conhecida como residual. Em essência, isto mostra-nos uma correlação entre estas duas variáveis e que ela pode ser modelada com alguma precisão.

```r
x  <-  BrancosPor10K
y  <-  Dados_Agregados_Condados$BD5AA1990
mod1  <-  lm(x  ~  y)
plot(x  ~  y,xlab="Renda per capita no ano anterior",ylab="Pessoas brancas por 10k")
summary(mod1)
abline(mod1)
res  <-  signif(residuals(mod1),  5)
pre  <-  predict(mod1)  # distância entre os pontos e a linha de regressão
segments(y,  x,  y,  pre,  col="red")
```

Aqui vemos:

![](https://lh3.googleusercontent.com/qUgjGfz7Q56e0du5Xt_0bp-5Lys_eTNKiW5a2fikU9zS_Pq-aAE7063BVCqWRKoinWgHU9pvZl_4j4xbbVFFl2Y_WjRewy1y7Bp4i8ulZMv4xTxua_vTjh7hGr_BP2y5ipaft9E)

![Fit.png](/images/geospatial-data-analysis/Fit.png "Gráfico de dispersão com residuais”)

Abaixo, vamos criar uma variável para tentar olhar para algumas das variáveis para procurar possíveis correlações. A seguir, vamos criar uma variável que mede a distribuição das igrejas denominacionais de um condado, o que nos permitirá medir se os nossos membros estão correlacionados com uma determinada denominação:

```r
Assembleias_de_Deus_Por10K <-  ((Dados_Agregados_Condados$AOG.C/Dados_Agregados_Condados$CHTOTAL)*10000)
MembrosPor10K  <-  as.integer(((Dados_Agregados_Condados$ContagemMembros/Dados_Agregados_Condados$TOTPOP)*100000))
```
Agora vamos criar uma trama que mostra uma pequena, mas significativa correlação que faz sentido, já que nossa organização é afiliada a esta denominação. Também é possível medi-lo estatisticamente usando a [função lm](https://www.r-bloggers.com/r-tutorial-series-simple-linear-regression/), que não cobriremos:

```rplot(MembrosPor10K,Assembleias_de_Deus_Por10K)```

Fizemos um gráfico regular dos dados, mas é melhor ter em conta o facto de que se trata de dados de contagem. Correlações e gráficos de dispersão são ótimas maneiras de avaliar as relações, mas podem ser problemáticos com os dados de contagem, pois muitas vezes não são lineares ou normalmente distribuídos e os gráficos de dispersão funcionam melhor quando estas [duas condições são verdadeiras](  https://www.statisticssolutions.com/assumptions-of-linear-regression/) (em inglês). E os dados históricos são muitas vezes contagens de pessoas ou ocorrências. Devido a isso, recomendo que se verifique a distribuição dos dados de contagem para avaliar as relações. Para isso, vamos usar um [histograma](https://sosestatistica.com.br/como-fazer-e-analisar-um-histograma-no-r/), comumente elaborado para representar distribuições de dados:

```r
hist(Dados_Agregados_Condados$ContagemMembros,breaks  =  15)
```

![](https://lh5.googleusercontent.com/erZ2Zh3ffbZU3ZjMcJ6E2FFC4s3u7w9-buGQF7pT25irrul72KZf3J3l_RIuafHT-ARQ0XcMd-ypDpie5uu8cAvvAZZZWqEoo74qlp1pYlFKitseZQt-soAksuOIXA)

![NCSC.png](/images/geospatial-data-analysis/Bar.png "Gráfico de dispersão com histograma”)

Há um número significativo de valores baixos, típico deste tipo de informação, e alguns condados que são muito superiores a outros. [^7]

Uma maneira simples de lidar com isto é realizar uma transformação logarítmica de uma variável do gráfico de dispersão para inspecionar possíveis relações não lineares. Adicionamos 1 aos valores[^8] porque o log(0) não está definido. Também seria possível usar .5 como algumas pessoas fazem. A seguir, analisaremos se existe uma relação entre os números de membros e a contagem das igrejas nos condados observados, usando uma transformação de log. Às vezes, isto pode trazer correlações nos dados de contagem que podem não ter sido óbvias num gráfico de dispersão não ajustado:

```r
plot(MembrosPor10K,  log(Assembleias_de_Deus_Por10K+1))
```

## Conclusão
Através deste processo, reunimos e transformamos dados geoespaciais numa forma utilizável. Também criamos algumas imagens a partir destes dados, analisando as tendências na lista de associados de nossa organização. Este tutorial deve fornecer um modelo básico sobre como obter dados históricos e começar a usar a análise geoespacial para analisar fenómenos como o que cobrimos. No nosso caso, os resultados ilustraram que a filiação não estava altamente correlacionada com pessoas que vivem em condados rurais, sugerindo que as primeiras caracterizações deste movimento como rural podem não ser inteiramente verdadeiras. Não obstante, podemos ver um leve relacionamento entre as Assembleias de Deus e a filiação. Este é apenas o início de possíveis meios de investigação. Se continuássemos, poderíamos agora começar a criar coropletos e parcelas de dispersão com outras variáveis, procurando tendências. À medida que se for avançando, será possível utilizar outros métodos que podem melhorar a análise.


## Outros Modelos e Visualizações
Há muitos outros modelos e visualizações disponíveis, mas que também acrescentam alguma complexidade e que exigem um maior entendimento estatístico. Por exemplo, também é possível criar gráficos de dispersão mais complexos fornecendo mais informações. O [Plot.ly](https://plot.ly/r/) (em inglês) oferece gráficos de dispersão interativos que podem ser personalizados e compartilhados. [^9] Enquanto a modelagem estatística geralmente se concentra na visão preditiva de um determinado modelo, modelos bem ajustados também fornecem uma visão dos dados que eles representam. Em particular, a regressão de Poisson é frequentemente usada para criar [modelos de dados de contagem]  ([http://www.theanalysisfactor.com/regression-models-for-count-data/](http://www.theanalysisfactor.com/regression-models-for-count-data/)) (em inglês), que é como os dados populacionais são frequentemente representados. As [regressões ponderadas geograficamente](  (https://rstudio-pubs-static.s3.amazonaws.com/44975_0342ec49f925426fa16ebcdc28210118.html)(em inglês) também têm vantagens particulares com este tipo de dados. Mas avaliar o ajuste tem alguma complexidade. Árvores de decisão(http://web.tecnico.ulisboa.pt/ana.freitas/bioinformatics.ath.cx/bioinformatics.ath.cx/indexf23d.html?id/) (em inglês) também podem ser úteis para dados históricos porque dão uma representação gráfica compreensível dos principais fatores que causaram a inclusão num grupo ou lista. A análise de componentes principais, [análise de correspondência](  /en/lessons/correspondence-analysis-in-R) e outros métodos de agrupamento podem ser igualmente úteis, especialmente quando há um conhecimento ou uma visão limitada sobre o evento em análise, ainda que haja uma abundância de dados associados ao mesmo. Recomendamos uma leitura de fundo ou discussões com um cientista de dados ou estatístico para explorar algumas destas opções de modelagem, pois a compreensão da configuração e dos parâmetros dos modelos individuais é essencial para garantir que os resultados são confiáveis e significativos.

```r
library(plotly)
var  =  Dados_Agregados_Condados$A57AA1990
bins  =  unique(quantile(var,  seq(0,1,length.out=8)))
interv  =  findInterval(var,  bins)

p <- plot_ly(Dados_Agregados_Condados, type = "scatter", mode = "markers") %>%
  add_trace(x = ~(AV0AA1990/10000)/ContagemMembros,
            y = ~BD5AA1990,
            size = ~AV0AA1990,
            color = ~People_Urban,
            text = ~paste("AVG Incom: ",BD5AA1990 ,
                          '$<br>County:', COUNTY.y,
                          '$<br>State:', STATENAM,
                          '$<br>Members:', ContagemMembros),
            hoverinfo = "text") %>%
  layout(title = 'Membros e Renda, Size=Population',
         xaxis = list(title = 'Membros por 10k'),
         yaxis = list(title = 'Renda'),
         hoverlabel = list(font = list(size = 16)))
p
```

![PLOTLY.png](/images/geospatial-data-analysis/PLOTLY.png "Dispersão multi-deminsional com Plot.ly")


[^1]: Para uma discussão mais ampla sobre o papel da informação geográfica e do GIs nas ciências humanas, ver Placing History: How Maps, Spatial Data, and GIS Are Changing Historical Scholarship (Esri Press, 2008) e Harris, Trevor M., John Corrigan, and David J. Bodenhamer, The Spatial Humanities: GIS and the Future of Humanities Scholarship (Bloomington: Indiana University Press, 2010).

[^2]: Para uma discussão sobre os benefícios e desvantagens desta metodologia e suas suposições, ver [Spatializing health research](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3732658/) (Espacializando a pesquisa em saúde). Alguns estados, como o Kentucky, têm um número maior de condados (120), que frequentemente abrangem cidades inteiras, o que muitas vezes leva a uma maior homogeneidade dentro dessas regiões. Em contraste, um estado como Massachusetts tem apenas 14 condados, o que pode levar a uma maior variabilidade com as geografias dos condados produzindo, em alguns casos, resultados mais questionáveis.

[^3]: Isto é frequentemente alavancado no campo da saúde pública. Ver, por exemplo, [Spatial Analysis and Correlates of County-Level Diabetes Prevalence]([https://www.cdc.gov/pcd/issues/2015/14_0404.htm](https://www.cdc.gov/pcd/issues/2015/14_0404.htm)) (Análise Espacial e Correlatos da Prevalência de Diabetes a Nível do Condado). Outros campos como a justiça criminal também dependem de análises semelhantes, embora a justiça criminal possua uma tendência para olhar para áreas menores de censo dentro das regiões. Ver, por exemplo, `https://www.ncjrs.gov/pdffiles1/nij/grants/204432.pdf`

[^4]: Para uma visão geral do R no que diz respeito às humanidades, com um capítulo de dados geoespaciais, ver Arnold Taylor e Lauren Tilton, Humanities Data in R (Cham: Springer, 2015). Eles também têm um capítulo geoespacial que utiliza o pacote sp.

[^5]: Estamos a definir o Coordinate Reference System (CRS ou Sistema de Referência de Coordenadas) como EPSG 4326, que é o sistema de mapeamento mais comum usado nos EUA. Ele é usado pela Google, que é a origem dos nossos dados. O EPSG 3857 também é usado pela Google. Para mais informações sobre o CRS, ver [Coordinate Reference Systems & Spatial Projections](https://www.earthdatascience.org/courses/earth-analytics/spatial-data-r/intro-to-coordinate-reference-systems/) (Sistemas de Referência Coordenada e Projeções Espaciais). Ver também [coordinate systems reference in R](http://web.archive.org/web/20200225021219/https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/OverviewCoordinateReferenceSystems.pdf) (referência de sistemas de coordenadas em R).

[^6]: A variável `A57AA1980` deve ser convertida para uma variável populacional relativa, de modo a que seja responsável por quão rural é um condado e não por quantas pessoas vivem mesmo. Isto será coberto mais tarde, mas também deve ser feito aqui. Poderia ser convertida para uma percentagem via: `Dados_Agregados_Condados$Percent_Rural = (cntyNCG$A57AA1980/cntyNCG$AV0AA1990)`.

[^7]: Os dados de contagem normalmente têm grandes números de valor zero, o que pode acrescentar alguma complexidade que não será coberta aqui. Há maneiras mais complexas de minimizar isto, usando modelos de regressão mais complexos. Veja, por exemplo, [Regression Models with Count Data](https://stats.idre.ucla.edu/stata/seminars/regression-models-with-count-data/) (Modelos de Regressão com Dados de Contagem). Para uma descrição geral de quais as distribuições normais, que funcionam bem sem modificação, ver [[distribuições normais](http://www.statisticshowto.com/probability-and-statistics/normal-distributions/)](  (http://www.statisticshowto.com/probability-and-statistics/normal-distributions/) (em inglês).

[^8]: Existem diferentes estratégias para lidar com este tipo de dados. Ver, por exemplo, [The Excess-zero Problem in Soil Animal Count Data](http://www.sciencedirect.com/science/article/pii/S0031405608000073) ([O Problema do Excesso-zero em Dados de Contagem de Animais no Solo)](https://www.sciencedirect.com/science/article/pii/S0031405608000073) ou [Data Transformations]([http://www.biostathandbook.com/transformation.html](http://www.biostathandbook.com/transformation.html)) ([Transformações de Dados](http://www.biostathandbook.com/transformation.html)) (ambos em inglês).

[^9]: Estes gráficos são um pouco mais complexos e requerem um pacote extra, mas têm algumas vantagens. Funcionam bem com conjuntos de dados complexos, porque têm a capacidade de modelar mais de duas relações, alterando a cor ou o tamanho dos data points (fizemos isso anteriormente nos coros alterando o tamanho da fonte). Além disso, são interativos, o que permite explorar informações extra sobre os data points após a criação da trama, sem estragar a composição visual da mesma. Aqui está um exemplo que analisa a relação entre renda e filiação, mas também adiciona a categoria urbano ao visual usando cores. Também ajustamos o tamanho do ponto com base na população para que possamos analisar áreas mais populosas com os outros dados.
