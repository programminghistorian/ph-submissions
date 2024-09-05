---
title: "Investigar a literatura lusófona através dos tempos usando a Literateca"
slug: investigar-literatura-lusofona-literateca
layout: lesson
collection: lessons
date: 2024-MM-DD
authors:
- Diana Santos
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/599
difficulty: 2
activity:
topics:
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Objetivos


## Introdução

Esta lição ensina a utilizar o [projeto Acesso a corpos / Disponibilização de corpos](https://www.linguateca.pt/ACDC/) (AC/DC), mais especificamente a Literateca, para investigar textos literários em português: por exemplo para estudar diferenças entre autores, escolas, e géneros literários ao longo do tempo. Além disso, ensina a apresentar os resultados da pesquisa com vários tipos de visualização utilizando a linguagem R. 

Para seguir a lição, tem de conhecer o que são folhas de registo (*dataframes*) em R, e estar familiarizado com as formas de produzir gráficos de barra (*bar plots*) e gráficos de caixa (*boxplots*) no R. Além de consultarem as [Noções básicas de R com dados tabulares](https://programminghistorian.org/pt/licoes/nocoes-basicas-R-dados-tabulares), podem também seguir o curso [Visualização básica de dados tabulares com R](https://programminghistorian.org/pt/licoes/visualizacao-basica-dados-tabulares-R).

Os casos específicos discutidos são:

* A roupa na literatura lusófona
* Diferenças entre a caracterização de personagens femininas e masculinas ao longo do tempo
* A localização na literatura portuguesa
* O helenismo na literatura brasileira

Depois de aprender esta lição, estará

* familiarizado com o AC/DC para estudos literários
* mais familiarizado com as ferramentas básicas de visualização do R


## Apresentação do AC/DC

O AC/DC é um projeto já antigo cujo objetivo era tornar disponíveis corpos para o português. Na presente lição vamos simplesmente usar o corpo [Literateca](https://www.linguateca.pt/acesso/corpus.php?corpus=LITERATECA), que contém mais de 900 obras escritas por mais de 280 escritores lusófonos.

Um corpo é um conjunto de textos (neste caso, obras literárias) compilado com um objetivo específico (neste caso o estudo da língua na literatura em português) e classificado (o que se chama geralmente metadata). Além disso, os corpos do AC/DC são anotados pelo analisador [PALAVRAS](https://edu.visl.dk/visl/pt/)[^1] e também são objeto de mais anotação semântica, como descrito em Santos (2014)[^2]. Vários exemplos de uso do AC/DC foram também descritos em Santos (2021)[^3].

A procura nos corpos é feita usando o sistema [Open CWB](https://cwb.sourceforge.io/)[^4], que é um sistema para gerir e interrogar grandes corpos anotados (contendo até dois biliões de palavras).

### A sintaxe de procura

Ao criar um corpo, define-se um conjunto de atributos que cada unidade (palavra, número ou sinal de pontuação) tem, e durante a anotação, preenchem-se os valores desses atributos, que depois entram nas pesquisas.

O primeiro atributo é a unidade em si, depois temos atributos morfosintáticos (por exemplo o lema, a categoria gramatical, o género morfológico), semânticos (o campo semântico a que pertence, o grupo a que pertence), e extralinguísticos (o autor, o sexo do autor, a data de publicação, a variedade do português).

Isso é exemplificado na tabela seguinte:

| word | lema | pos | temcagr |
| --------- | --------- | --------- | --------- |
| Estou | estar | V | PR_IND |
| sem | sem | PRP | 0 |
| pilhas | pilha | N | 0 |
| ! | ! | PU | 0 |

Tabela 1: Esta tabela contém um exemplo do texto "Estou sem pilhas!" no formato AC/DC, com quatro atributos (word, lema, pos, temcagr). Na realidade, a Literateca tem 27 atributos.

Um sistema de interrogação de corpos tem dois modos:

* a identificação do que se procura em contexto (que no AC/DC é em geral uma frase), e se chama uma concordância; 
* a distribuição quantitativa dos resultados do que se procurou

Assim, para a mesma procura eu posso escolher como resultado uma concordância, ou a distribuição segundo um dos muitos atributos.

{% include figure.html filename="pt-or-investigar-literatura-lusofona-literateca-01.png" alt="Pesquisa pedindo uma concordância" caption="Figura 1. Pesquisa pedindo uma concordância (apenas 4 dos 4889 resultados da pesquisa pela palavra 'cara')" %}

{% include figure.html filename="pt-or-investigar-literatura-lusofona-literateca-02.png" alt="Pesquisa pedindo a distribuição por categoria gramatical" caption="Figura 2. Pesquisa pedindo uma distribuição por categoria gramatical" %}

{% include figure.html filename="pt-or-investigar-literatura-lusofona-literateca-03.png" alt="Pesquisa pedindo a distribuição por autor" caption="Figura 3. Pesquisa pedindo uma distribuição por autor" %}

Assim, o AC/DC permite fazer buscas nos textos, e tanto identificar em contexto o resultado (para leitura próxima) como produzir um resumo quantitativo (a chamada leitura distante).

A sintaxe da procura é muito mais poderosa – não permite apenas procurar por palavras, é possível procurar em todos os atributos, e através de expressões regulares.

Alguns exemplos aqui:

* `[lema=".*ver" & pos="V.*"]` procurar casos de verbos acabados em *ver*
* `[pos="N"] [pos="ADJ.*" & word="re.*"]` procurar casos de substantivos imediatamente seguidos de adjetivos iniciados por *re*
* `[lema="de"] [pos="DET.*"] [pos="N" & pessnum="S"]` procurar casos da preposição *de* seguida por um determinante e por um ou mais adjetivos e um substantivo no singular
*  `[lema="gostar"] [pos!="[NV].*"]* [func="<PIV"] [func=">N"]* @[func="P<"]` procurar casos do verbo *gostar* até obter o núcleo do seu objeto de preposição

Para uma descrição mais completa da sintaxe do AC/DC, ver o texto Santos (2012)[^5], assim como os [exemplos](https://www.linguateca.pt/acesso/exemplos.html) e as [perguntas já respondidas](https://www.linguateca.pt/acesso/PJR.html) no sítio do AC/DC.

### O corpo Literateca

Enquanto a informação morfossintática e semântica é a mesma para todos os corpos do AC/DC, cada corpo contém uma informação extralinguística própria, que depende da informação que foi possível -- e pertinente -- obter sobre cada texto.

Para a Literateca, temos os seguintes atributos, identificados pelo pedido de distribuição na figura 4.

{% include figure.html filename="pt-or-investigar-literatura-lusofona-literateca-04.png" alt="Distribuições próprias da Literateca" caption="Figura 4. Quais as distribuições de atributos extralinguísticos possíveis na Literateca" %}

O género de texto (atributo classe) está dividido entre Teatro, Prosa e Poesia, e em relação à Prosa, pode ter um dos seguintes valores: romance, novela, contos (livro de contos), conto, ensaio, cronica, historia, viagens, memorias, sermao, narrativaBiblica, autobiografia e cartas.

Para saber as obras ou autores incluídos, e qual a forma de os procurar, consulte a página [lista de autores](https://www.linguateca.pt/acesso/lista_autores_literateca.html).

### Outras formas de pesquisa

Além da interface de pesquisa direta, existem outras formas de pedir informação de distribuição ao AC/DC, nomeadamente o [Comparador](https://www.linguateca.pt/comparador/) e o [Distribuidor](https://www.linguateca.pt/distribuidor/).

Enquanto o Comparador permite comparar duas distribuições com um único comando, o Distribuidor produz os resultados numa tabela que é facilmente utilizada em R.

Em primeiro lugar, é preciso escolher o corpo que se quer pesquisar. Neste caso,a Literateca.

Se, por exemplo, quisermos saber a quantidade de menções a roupa distribuídas pelas obras, autores e variante, basta pedir

```
?sema=/roupa/ obra autor variante
```

e, escolhendo a opção tsv para Tipo de resultado, obtém-se um ficheiro que pode ser lido depois diretamente pelo R. Chamamos-lhe [distribuicaoRoupa.tsv](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/visualizacao-basica-dados-tabulares-R/distribuicaoRoupa.tsv). Para mais informação sobre roupa, consulte o artigo Santos (2021).[^6]


Mostro aqui o princípio desse ficheiro:

|||||||
|-----------------|----|-----|--|----|-----|
| Os_Maias | 1341 | EcaQue | PT | 1341 | 100.00 |
| O_Primo_Basílio | 942 | EcaQue | PT | 942 | 100.00 |
|Gomes_Freire	|866	|RocMar	|PT	|866	|100.00 |
|A_Capital | 728 | EcaQue | PT | 728 | 100.00 |
|A_Relíquia | 703 | EcaQue | PT | 703 | 100.00 |
| Peregrinação | 677 | FerMPin | PT | 677 | 100.00 |
|A_Tragédia_da_Rua_das_Flores | 665 | EcaQue | PT | 665 | 100.00 |
|O_Crime_do_Padre_Amaro | 663 | EcaQue | PT | 663 | 100.00 |
|A_semana | 533 | MacAss | BR | 533 | 100.00 |


A primeira coluna indica o nome da obra, a segunda o número de vezes que uma palavra marcada como sendo do campo semântico da roupa foi encontrada nessa obra, depois vem a coluna com o nome do autor e com o nome da variante. As próximas colunas não são relevantes, visto que não há variação da obra em relação ao autor ou à variante (por exemplo, a obra *O primo Basílio* é totalmente escrita por Eça de Queirós, na variante de português de Portugal...).

Para ter informação extralinguística sobre todas as obras da Linguateca, basta pedir no Distribuidor essa informação, por exemplo:

```obra autor variante data decada```

e guardá-la num ficheiro com um nome apropriado. Escolhemos `distribuicaoObra.tsv`: [distribuicaoObra.tsv](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/visualizacao-basica-dados-tabulares-R/distribuicaoObra.tsv).

É importante esclarecer que algumas obras não têm data, apenas o século a que pertencem. Nesse caso, pode colocar-se uma data indicativa (como o ano 1650 para representar o século XVII) ou retirar-se essa obras do ficheiro, antes de invocar o R.

Convém também converter os ficheiros para UTF8.

## O uso da linguagem R

Para descrever e visualizar os resultados, podemos incluir os ficheiros produzidos pelo Distribuidor no ambiente de programação R.

### Roupa na literatura

Vamos primeiro observar quais os autores que têm mais menções a roupa.


```
roupa<-read.table("distribuicaoRoupa.tsv")
names(roupa)<-c("obra","roupa", "autor","variante", "lixo","lixo2")
obras<-read.table("distribuicaoObra.tsv")
names(obras)<-c("obra","tamanho", "autor","variante","data", "decada", "lixo","lixo2")
roupaObras<-merge(roupa, obras, by=c("obra","autor","variante"))
roupaObras$rouparel<-roupaObras$roupa/roupaObras$tamanho
roupaObrasOrdenada<-roupaObras[order(roupaObras$rouparel, decreasing=TRUE),]
```

Muito brevemente, as quatro primeiras linhas leem os ficheiros e dão o nome às colunas, a quinta junta a informação nas duas folhas de registo (dataframes) numa só, a sexta calcula a frequência relativa de roupa por número de unidades, criando uma coluna extra chamada `rouparel`, e a sétima obtém uma nova folha de registo ordenada pelo peso relativo do vestuário (que está na coluna `rouparel`).

Com os próximos comandos, podemos visualizar isso num gráfico de barras (Figura 5) e num diagrama de caixa (boxplot) (Figura 6), neste caso para dez autores que têm várias obras na Literateca.

```
par(mar=c(15,4,2,2)+0.1)
barplot(roupaObrasOrdenada$rouparel[1:25], names=paste(roupaObrasOrdenada$autor[1:25],"-",roupaObrasOrdenada$autor[1:25]),las=2)
par(mar=c(2,2,2,2)+0.1)
dezautores<-subset(roupaObras,roupaObras$autor=="JulDin"|roupaObras$autor=="EcaQue"|roupaObras$autor=="RauBra"|roupaObras$autor=="CoeNet"|roupaObras$autor=="MacAss"|roupaObras$autor=="CamCBra"|roupaObras$autor=="AMBB"|roupaObras$autor=="JosdAle"|roupaObras$autor=="AlmGar"|roupaObras$autor=="AluAze",)
dezautores$autor<-dezautores$autor[drop=TRUE]
boxplot(dezautores$rouparel~dezautores$autor, xlab="",ylab="",las=2)
```

{% include figure.html filename="pt-or-investigar-literatura-lusofona-literateca-05.png" alt="Gráfico de barras das vinte e cinco obras que falam mais de roupa na Literateca" caption="Figura 5. As vinte e cinco obras que falam mais de roupa na Literateca, num gráfico de barras" %}

{% include figure.html filename="pt-or-investigar-literatura-lusofona-literateca-06.png" alt="Gráfico de caixa do peso da roupa em dez autores da Literateca" caption="Figura 6. A distribuição de roupa por dez autores na Literateca, num gráfico de caixa" %}

Vemos pelas duas visualizações que, embora as obras com mais menção relativa a roupa fossem contos de Machado de Assis (Figura 5), ao ver o conjunto das suas obras (Figura 6) é Eça de Queirós quem dá mais importância a esse campo semântico.

Por outro lado, também podemos observar a menção ao campo semântico do vestuário ao longo do tempo, usando para isso a data ou a década a que cada obra pertence, na Figura 7.

```
boxplot(roupaObras$rouparel~roupaObras$decada,las=2,xlab="",ylab="")
```

{% include figure.html filename="pt-or-investigar-literatura-lusofona-literateca-07.png" alt="Gráfico de caixa da roupa por década" caption="Figura 7. A distribuição de roupa por década na Literateca, num gráfico de caixa" %}

### Diferenças entre as personagens femininas e masculinas

No AC/DC, marcamos todas as caracterizações como pertencendo a uma de quatro classes

* emoção
* carácter
* aparência
* social

Para explicação destas categorias e da forma de anotação, ver Freitas e Santos (2023)[^7].

Vamos agora ver que casos femininos e masculinos estão marcados com pred:aparencia, ao longo do tempo.

No distribuidor, pedimos a distribuição dos casos de aparência (no caso das obras literárias em prosa):

```
?sema=/pred:aparencia/ ?classe=/Prosa:.*/ decada gen
```

e dos casos de predicação, seja ela qual for, em que se descreve uma pessoa (também no caso das obras literárias em prosa):

```
?sema=/pred/ ?classe=/Prosa:.*/ decada gen
```

Relembrando que

* escolhemos o corpo Literateca
* escolhemos a opção tsv

e temos de guardar os ficheiros com nomes descritivos. No caso em questão, chamei-lhes `distribuicaoAparenciaDecadaGen.tsv` [distribuicaoAparenciaDecadaGen.tsv](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/visualizacao-basica-dados-tabulares-R/distribuicaoAparenciaDecadaGen.tsv) e `distribuicaoPredDecadaGen.tsv` [distribuicaoPredDecadaGen.tsv](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/visualizacao-basica-dados-tabulares-R/distribuicaoPredDecadaGen.tsv).

No R, juntamos as duas informações, calculamos o peso relativo da aparência e depois produzimos uma figura ao longo do tempo:

```
apargen<-read.table("distribuicaoAparenciaDecadaGen.tsv")
names(apargen)<-c("decada","aparencia","gen","tamapargen","lixo")
predgen<-read.table("distribuicaoPredDecadaGen.tsv")
names(predgen)<-c("decada","pred","gen","tampredgen","lixo")
aparencia<-merge(apargen,predgen,by=c("decada","gen"))
aparencia$genrel<-aparencia$tamapargen/aparencia$tampredgen
barplot(xtabs(aparencia$genrel~aparencia$gen+aparencia$decada),beside=TRUE,las=2,legend.text=c("F","M"))
```

{% include figure.html filename="pt-or-investigar-literatura-lusofona-literateca-08.png" alt="Gráfico de barras de caracterizações de aparência na Literateca" caption="Figura 8. Caracterização da aparência feminina e masculina por década, num gráfico de barras" %}

Vemos na Figura 8 que os homens têm quase sempre mais caracterização de aparência do que as mulheres, o que pode constituir uma surpresa. Para muito mais informação sobre isto e sobre a construção social do género, veja-se o artigo Freitas &amp; Santos (2023)[^7].


### A localização na literatura portuguesa

Também está em curso um projeto de anotação de lugares, que distingue palavras que podem ser locais em alguns contextos e não noutros, que indica, no caso dos locais, qual o seu tipo e granularidade (cidade, país, rio, etc.) e, no caso de essas localidades serem reais, as suas coordenadas geográficas. Veja-se [Viagem](https://www.linguateca.pt/Gramateca/Viagem.html), assim como Santos &amp; Bick (2021)[^8] para mais informações.

Dado isso, podemos identificar quais as cidades mais faladas na literatura portuguesa, usando simplesmente esta procura no AC/DC:

```
[sema="Local:cidade.*" & variante="PT"]
```

Assim como podemos investigar qual a cidade mais falada por obra, usando o Distribuidor e guardando o resultado por exemplo em [distribuicaoCidadesObra.tsv](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/visualizacao-basica-dados-tabulares-R/distribuicaoCidadesObra.tsv).

```
?variante=/PT/ sema=/Local:cidade/ obra lema
```

Podem fazer um gráfico de barras que represente este resultado. 
Aqui, vamos comparar o número de locais empregues por autores diferentes, em romances e novelas, usando mais uma vez o Distribuidor e guardando o resultado em [distribuicaoLocaisObra.tsv](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/visualizacao-basica-dados-tabulares-R/distribuicaoLocaisObra.tsv):

```
?variante=/PT/ ?classe=/Prosa:(romance|novela)/ ?sema=/Local:.*/ obra autor
```

Vamos visualizar isso através de um gráfico de caixa no R. De notar que reutilizaremos o [distribuicaoObra.tsv](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/visualizacao-basica-dados-tabulares-R/distribuicaoObra.tsv) que obtivemos anteriormente.

```
locais<-read.table("distribuicaoLocaisObra.tsv")
names(locais)<-c("tipo","lixo","obra","autor","num","lixo2")
obras<-read.table("distribuicaoObra.tsv")
names(obras)<-c("obra","tamanho", "autor","variante","data", "decada", "lixo","lixo2")
locaisObras<-merge(locais, obras, by=c("obra","autor"))
locaisObras$localrel<-locaisObras$num/locaisObras$tamanho
attach(locaisObras)
barplot(sort(tapply(localrel,obra,sum),decreasing=TRUE)[1:50],las=2)
```

As primeiras quatro linhas apenas leem e identificam as colunas das folhas de registo. A quinta junta ambas as informações, e a sexta calcula o número relativo de locais por número de palavras, para ser possível comparar obras de diferentes tamanhos.

A sétima linha apenas instrói o R para se considerar "dentro" da folha de registo `locaisObras`, para não ser preciso estar sempre a preceder o nome da coluna pelo nome da folha de registo. `Tapply` é um comando no R que aplica uma função repetidamente, e neste caso é a função `sum` (soma), porque queremos somar todos os locais, sem interessar o tipo.

Escolhi apresentar na Figura 9 o gráfico das cinquenta obras com mais locais relativos, calculado na oitava linha. (Depois de ordenar, pedi os casos de 1 a 50.)

{% include figure.html filename="pt-or-investigar-literatura-lusofona-literateca-09.png" alt="Gráfico de caixa do peso dos locais" caption="Figura 9. A distribuição de locais por obra (romances e novelas portuguesas) na Literateca, num gráfico de caixa" %}

É interessante constatar que são os romances históricos, e de ficção científica, os que mais dão nome a lugares.

Sugiro que façam também uma análise semelhante por autores, para ver (grandes) diferenças entre estes.

### O helenismo na literatura brasileira

Finalmente, apresento aqui um estudo feito no âmbito da tese de mestrado de Marcus Vinicius Sousa Correia[^9], que estudou o helenismo na literatura brasileira.

O trabalho dele é um bom exemplo de como simples tarefas de anotação, em colaboração com o AC/DC, são fáceis de executar e produzem resultados interessantes.

De facto, Marcus apenas mandou um conjunto de lexemas que, segundo ele, estavam associados à cultura grega, e anotámos o OBras, o principal corpo de literatura brasileira no AC/DC, com essa informação (a marcação `helen`). Assim tornou-se muito fácil medir o peso destas palavras num conjunto de autores brasileiros com obras no OBras.

O leitor é convidado a reproduzir as figuras da tese, visto que todos os comandos são apresentados num anexo.

## Observações finais

Nesta lição tentei apresentar o AC/DC, com duas formas de interação, a "Procura" e o "Distribuidor", e depois, a partir dos resultados, obter gráficos agregadores usando o R.

O objetivo foi demonstrar várias potencialidades do estudo da história da literatura lusófona, através da leitura distante, usando o AC/DC e em particular o corpo Literateca, que contém textos literários em português e está em constante expansão.


## Referências

[^1]: Bick, Eckhard."PALAVRAS, a Constraint Grammar-based Parsing System for Portuguese." In Tony Berber Sardinha & Thelma de Lurdes São Bento Ferreira (eds.), *Working with Portuguese Corpora*, London/New York: Bloomsbury Academic, 2014, pp. 279-302.

[^2]: Santos, Diana. "Corpora at Linguateca: Vision and roads taken", in Tony Berber Sardinha & Telma de Lurdes São Bento Ferreira (eds.), *Working with Portuguese Corpora*, Bloomsbury, 2014, pp. 219-236.

[^3]: Santos, Diana. "A Gramateca e a Literateca como macroscópios linguísticos". *Domínios da Linguagem* 16, 4, 2022, pp. 1242-1265.

[^4]: Evert, Stefan &amp Hardie, Andrew. "Twenty-first century Corpus Workbench: Updating a query architecture for the new millennium". In *Proceedings of the Corpus Linguistics 2011 conference*, University of Birmingham, UK, 2011. [pdf](http://www.birmingham.ac.uk/documents/college-artslaw/corpus/conference-archives/2011/Paper-153.pdf)

[^5]: Santos, Diana. "A sintaxe do AC/DC: apresentação do CWB e das opções tomadas", Outono de 2012, notas para a disciplina de POR2102. [pdf](https://www.linguateca.pt/Diana/download/instrACDC.pdf)

[^6]: Santos, Diana. "Explorando o vestuário na literatura em português". *TradTerm*, 37, 2, 2021, pp. 622-643. 

[^7]: Freitas, Cláudia &amp; Diana Santos. "Gender Depiction in Portuguese: Distant reading Brazilian and Portuguese literature". In *Journal of Computational Literary Studies*, 2023.

[^8]: Santos, Diana &amp; Eckhard Bick. "Distant reading places in Portuguese literature". *NorLit2021* (Trondheim, 14-16 June 2022). [pdf](https://www.linguateca.pt/Diana/download/SantosBickNorLit.pdf)

[^9]: Correia, Marcus Vinicius Sousa. "Helenismo nos trópicos: Análise da presença do Helenismo na literatura brasileira pelo viés da leitura distante". Tese de mestrado, Universidade Estadual do Maranhão: UEMA, São Luís, MA, 2023.
