---
title: Manipulação e transformação de dados usando R
authors:
- Nabeel Siddiqui
date: 2017-08-01
reviewers:
- Lauren Tilton
- Ryan Deschamps
editors:
- Ian Milligan
difficulty: 2
collection: lessons
activity: transforming
topics: [data-manipulation, data-management, distant-reading]
abstract: "This tutorial explores how scholars can organize 'tidy' data, understand R packages to manipulate data, and conduct basic data analysis."
layout: lesson
review-ticket: 60
---

Premissas
===========

Esta lição considera premissas básicas acerca do seu conhecimento da linguagem R. Se você não completou a lição ["R Basics with Tabular
Data"](http://programminghistorian.org/lessons/r-basics-with-tabular-data), eu sugiro que complete-a primeiro. Ter experiência com outras linguagens de programação também pode ser útil. Se está buscando por onde começar, recomendo dar uma olhda nos excelentes tutoriais de Python do *Programming
Historian*.

Objetivos da lição
============

Ao fim desta lição, você vai:

1.  Saber manipular dados para organizá-los no formato "tidy" e entender porque isso é importante.
2.  Entender o uso do pacote dplyr e sua aplicação na manipulação e tranformação de dados.
3.  Se familiarizar com o operador pipe na linguagem R e obsevar como ele te auxiliará na criação de códigos mais legíveis.
4.  Aprender a trabalhar com exemplos básicos de manipulação de dados, a fim de gerar experiência com análise de dados exploratória.

Introdução
============

Os dados que você encontra "por aí" raramente estão em um formato preferível para serem analisados, e você precisará manipulá-los antes de explorar as perguntas de seu interesse. Isso pode tomar mais tempo que a própria análise dos dados! Neste tutorial, vamos aprender técnicas básicas para manipulação, controle e transformação dos nossos dados usando R. Especificamente, vamos nos debruçar sobre a filosofia do ["tidy
data"](https://www.jstatsoft.org/article/view/v059i10) da forma como foi articulada por Hadley Wickham.

De acordo com [Wickham](http://hadley.nz/), os dados estão em formato "tidy" quando satisfazem três critérios principais:

1.  Cada registro deve estar em uma linha.
2.  Cada variável deve estar em uma coluna.
3.  Cada valor deve ter sua própria célula.

Estar atento a esses critérios, nos permite reconhecer quando nossos dados estão organizados ou não. Também nos permite utilizar uma série de ferramentas padrões para a limpeza dos dados e solução dos problemas mais comuns encontrados em bases de dados "bagunçadas":

1.  Nomes das colunas como valores, não como nome de variável.
2.  Múltiplas variáveis em uma única coluna.
3.  Variáveis armazenadas em linhas e colunas, ao mesmo tempo.
4.  Vários registros de categorias diferentes armazenados na mesma tabela.
5.  Registros de mesma categoria amarzenados em múltiplas tabelas.

O mais importante: manter os dados nesse formato nos permite utilizar uma série de ferramentas do pacote ["tidyverse,"](http://tidyverse.org/), desenhadas especificamente para trabalhar com dados organizados, "tidy". Certificando-nos de que nossos inputs e outputs são "tidy", precisaremos utilizar somente um pequeno ferramental para solucionar um grande número de problema. Deste modo, podemos combinar, manipular e dividir bases de dados organizadas, conforme nossa necessidade.

Neste tutorial, vamos focar no pacote [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html), presente no tidyverse, mas é importante mencionar alguns outros que serão vistos nesta lição:

* [**magittr**](http://magrittr.tidyverse.org) -- Esse pacote nos garante acesso ao operador pipe, que torna nosso código mais legível.  
* [**ggplot2**](http://ggplot2.tidyverse.org/) -- Esse pacote utiliza a
["Gramática dos Gráficos"](http://www.springer.com/us/book/9780387245447), que fornece uma forma fácil de visualizar nossos dados.  
* [**tibble**](http://tibble.tidyverse.org/) -- Esse pacote nos apresenta uma releitura dos tradicionais "data frames", mais fácil de serem trabalhados e visualizados.

Você deve instalar, se ainda não instalou, e carregar o "tidyverse" antes de começarmos. Além disso, certifique-se que você possui instaladas a
[versão mais recente do R](https://cran.rstudio.com/) e a [versão mais recente do RStudio](https://www.rstudio.com/products/rstudio/download/), em suas respectivas plataformas.

Copie o código a seguir em seu RStudio. Para rodar, você precisa selecionar as linhas de código e pressionar Ctrl+Enter (Command+Enter no Mac OS):

    # Instala a biblioteca tidyverse e carrega
    # Não se preocupe, isso pode demorar um pouco...

    install.packages("tidyverse")
    library(tidyverse)

Um exemplo do dplyr em ação
=============================

Vamos observar um exemplo de como o dplyr pode nos auxiliar, como historiadores, importando indicadores socioeconômicos de países entre 1952 e 2007, utilizando o pacote "dados":

    # Instala e carrega as bibliotecas "remotes" e "dados"

    install.packages("remotes")
    library(remotes)

    remotes::install_github("cienciadedatos/dados")
    library(dados)

Para obter a base de dados que vamos utilizar, através do pacote "dados", basta executar o seguinte código:

    # Designa a base de dados "dados_gapminder" para o objeto "dados_paises_socioeconomicos"
    dados_paises_socioeconomicos <- dados_gapminder

Após importar a base, você vai notar que ela possui seis variáveis: uma para o nome do país, uma para o continente do país, uma para o ano, e mais outras três contendo indicadores socioeconômicos (expectativa de vida, população, PIB per capita). Essa base de dados já está organizada em formato "tidy", possibilitando uma variedade de opções para se explorar futuramente esses dados.

Neste exemplo, vamos visualizar o crescimento populacional de Brasil e Argentina, ao longo dos anos. Vamos utilizar o pacote dplyr para filtrar nossos dados, afim de analisar informações somente dos países de nosso interesse. Em seguida, usaremos o ggplot2 para visualizar a informação produzida. Este exercício nos proporciona apenas uma breve demonstração do poder do dplyr, portanto, não se preocupe se você não entender o código por enquanto.

    # Filtra a base de dados para conter apenas os países desejados (Brasil e Argentina)

    dados_brasil_argentina <- dados_paises_socioeconomicos %>%
      filter(pais %in% c("Brasil", "Argentina"))

    # Visualiza a população dos dois países

    ggplot(data = dados_brasil_argentina, aes(x = ano, y = populacao, color = pais)) +
      geom_line() +
      geom_point()

{% include figure.html filename="img/brasil_argentina_populacao.png" caption="Gráfico da população de Brasil e Argentina, ao longo dos anos" %}

Como podemos observar, a população absoluta do Brasil é consideravelmente maior em comparação com a população da Argentina. Embora isso pareça óbvio, devido ao tamanho do território brasileiro, o código nos fornece uma base sobre a qual podemos formular uma variedade de novos questionamentos. Por exemplo, com uma pequena mudança no código, podemos criar um gráfico similar, mas com dois países diferentes, como Portugal e Bélgica.


    # Filtra a base de dados para conter apenas os países desejados (Portugal e Bélgica)

    dados_portugal_belgica <- dados_paises_socioeconomicos %>%
      filter(pais %in% c("Portugal", "Bélgica"))

    # Visualiza a população dos dois países

    ggplot(data = dados_portugal_belgica, aes(x = ano, y = populacao, color = pais)) +
      geom_line() +
      geom_point()  

{% include figure.html filename="img/portugal_belgica_populacao" caption="Gráfico da população de Portugal e Bégica, ao longo dos anos" %}

Fazer rápidas mudanças em nosso código e analisar novamente nossos dados é uma das partes fundamentais da análise exploratória de dados (AED). Ao invés de tentar "provar" uma hipótese, a análise exploratória de dados nos auxilia a entender melhor nossos dados e levantar melhores questionamentos. Para historiadores, a AED fornece um meio para saber melhor quando se aprofundar em determinada temática e quando é preciso tomar distância. Nesse aspecto o R se sobressai.

Operador Pipe
=============

Antes de usarmos o dplyr, precisamos compreender o que é o operador pipe (%&gt;%) no R, uma vez que vamos utilizá-lo em muitos exemplos adiante. Como mencionado anteriormente, o operador pipe é parte da biblioteca [magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html), criada por [Stefan Milton Bache](http://stefanbache.dk/) e [Hadley Wickham](http://hadley.nz/), que faz parte do tidyverse. Seu nome é uma referência ao pintor surrealista, Rene Magritte, criador da obra "A Traição das Imagens", uma pintura de um cachimbo com a frase em francês: "isto não é um cachimbo".

O operador pipe (%&gt;%) te permite passar uma variável, à esquerda do operador, como o primeiro argumento de uma função específica, à direita do operador. Embora não pareça nada simples no começo, uma vez que você aprende a usar o pipe, seu código se torna muita mais legível, evitando as chamadas declarações aninhadas. Não se preocupe se tudo isso estiver confuso por agora. Ao observarmos os exemplos, isso se tornará mais claro.

Vamos admitir hipoteticamente que estamos interessados em obter a raiz quadrada de cada número de habitantes e, então, somar todas as raízes, afim de obter uma média. Obviamente, essa não é uma medida válida, mas demonstra como um código em R pode se tornar ilegível rapidamente. Normalmente, usaríamos declarações aninhadas, por exemplo:

    mean(sum(sqrt(dados_paises_socioeconomicos$populacao)))

    ## [1] 6328339

Como foi possível observar, a partir de um número de comandos, começa a se tornar difícil determinar o número de parênteses necessários, tornando o código difícil de ser entendido. Para mitigar esse efeito, alguns usuários podem decidir criar vetores temporários entre cada função chamada.

    # Raiz quadrada da população de todos os países

    raiz_populacao_vetor <- sqrt(dados_paises_socioeconomicos$populacao)

    # Soma de todas as raízes presentes na variável temporária

    soma_raiz_populacao_vetor <- sum(raiz_populacao_vetor)

    # Média dos valores da variável temporária

    media_soma_sqrt_populacao_vetor <- mean(soma_raiz_populacao_vetor)

    # Exibe a média

    media_soma_sqrt_populacao_vetor

    ## [1] 6328339

Embora você obtenha o mesmo resultado, este último código é muito mais legível. No entanto, pode rapidamente bagunçar seu espaço de trabalho, caso você esqueça de deletar os vetores temporários. O operador pipe faz esse trabalho por você. Aqui está o mesmo código, usando o operador pipe.  

    dados_paises_socioeconomicos$populacao %>% sqrt %>% sum %>% mean

    ## [1] 6328339

Esse código é muito mais legível que os anteriores e você pode torná-lo ainda mais limpo: escrevendo as declarações em linhas diferentes.

    # Certifique-se de colocar o operador ao final da linha

    dados_paises_socioeconomicos$populacao %>%
    sqrt %>%
    sum %>%
    mean

    ## [1] 6328339

Note que os vetores ou tabelas, criados pelo operador pipe, são descartados após o fim da operação. Se você quiser salvar o resultado da operação, você deve designar o resultado para uma nova variável:

    vetor_populacao_permanente <- dados_paises_socioeconomicos$populacao %>%
    sqrt %>%
    sum %>%
    mean

    vetor_populacao_permanente

    ## [1] 6328339

Agora que aprendemos a usar o operador pipe, estamos prontos para começarmos a analisar e manipular dados. Ao longo deste tutorial, vamos continuar trabalhando com os dados do [Gapminder](https://www.gapminder.org/), contendo informações dos avanços dos indicadores socioeconômicos, ao longo dos anos, de vários países. Vamos olhar mais uma vez nossos dados:

    # Certifique-se que o pacote "dados" está instalado e carregado antes de importar a base de dados

    dados_gapminder

    ## # A tibble: 1,704 x 6
    ##    pais        continente   ano expectativa_de_vida populacao pib_per_capita
    ##    <fct>       <fct>      <int>               <dbl>     <int>          <dbl>
    ##  1 Afeganistão Ásia        1952                28.8   8425333           779.
    ##  2 Afeganistão Ásia        1957                30.3   9240934           821.
    ##  3 Afeganistão Ásia        1962                32.0  10267083           853.
    ##  4 Afeganistão Ásia        1967                34.0  11537966           836.
    ##  5 Afeganistão Ásia        1972                36.1  13079460           740.
    ##  6 Afeganistão Ásia        1977                38.4  14880372           786.
    ##  7 Afeganistão Ásia        1982                39.9  12881816           978.
    ##  8 Afeganistão Ásia        1987                40.8  13867957           852.
    ##  9 Afeganistão Ásia        1992                41.7  16317921           649.
    ## 10 Afeganistão Ásia        1997                41.8  22227415           635.
    ## # … with 1,694 more rows

Como podemos observar, esta base de dados contém o nome do país, seu continente, o ano do registro e os indicadores de expectativa de vida, total da população e PIB per capita, nos determinados anos. Como vimos acima, antes de analisarmos os dados, é importante verificar se eles estão organizados e no formato tidy. Relembrando os três critérios discutidos, podemos determinar que esta base já encontra-se organizada e pronta para ser trabalhada, utilizando o pacote dplyr como ferramenta.  

O que é dplyr?
==============

[Dplyr](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html) é outro pacote presente no tidyverse, que fornece ferramentas para manipulação e tranformação de bases de dados "tidy". Uma vez que nossos dados já estão organizados, precisaremos apenas de uma pequena parte dessas ferramentas para explorar suas informações. Em comparação com o pacote básico do R, usando o dplyr, nosso código é geralmente mais rápido e há a certeza de produzir  sempre resultados também em formato tidy, uma vez que nossos dados de entrada também estavam organizados assim. Especialmente, o dplyr torna nosso código mais legível e utiliza "verbos" que são, no geral, intuitivos. Cada função do dplyr corresponde a um desses verbos, sendo cinco principais: filter, select, arrange, mutate e summarise (filtrar, selecionar, organizar, modificar e sumarizar). Vamos observar individualmente como cada um desses verbos funciona na prática.


### Select

Se olharmos para o banco de dados "dados_gapminder", vamos observar a presença de seis colunas, contendo diferentes informações. Podemos escolher, durante nossa análise, visualizar apenas algumas dessas colunas. A função select() do dplyr nos permite fazer isso. O primeiro argumento da função é sempre a base de dados que desejamos manipular e, em seguida, listamos os nomes das colunas que queremos manter na base de dados:

    # Remove as colunas da base original usando select()
    # Observe que você não precisa utilizar o $ ao fim do dados_gapminder para se referir ao nome da coluna
    # O dplyr automaticamente assume que a "," representa E

    select(dados_gapminder, pais, ano, expectativa_de_vida)

    ## # A tibble: 1,704 x 3
    ##    pais          ano expectativa_de_vida
    ##    <fct>       <int>               <dbl>
    ##  1 Afeganistão  1952                28.8
    ##  2 Afeganistão  1957                30.3
    ##  3 Afeganistão  1962                32.0
    ##  4 Afeganistão  1967                34.0
    ##  5 Afeganistão  1972                36.1
    ##  6 Afeganistão  1977                38.4
    ##  7 Afeganistão  1982                39.9
    ##  8 Afeganistão  1987                40.8
    ##  9 Afeganistão  1992                41.7
    ## 10 Afeganistão  1997                41.8
    ## # … with 1,694 more rows

Vamos seguir e ver como escrevemos o mesmo código utilizando o operador pipe (%&gt;%):

    dados_gapminder %>%
      select(pais, ano, expectativa_de_vida)

    ## # A tibble: 1,704 x 3
    ##    pais          ano expectativa_de_vida
    ##    <fct>       <int>               <dbl>
    ##  1 Afeganistão  1952                28.8
    ##  2 Afeganistão  1957                30.3
    ##  3 Afeganistão  1962                32.0
    ##  4 Afeganistão  1967                34.0
    ##  5 Afeganistão  1972                36.1
    ##  6 Afeganistão  1977                38.4
    ##  7 Afeganistão  1982                39.9
    ##  8 Afeganistão  1987                40.8
    ##  9 Afeganistão  1992                41.7
    ## 10 Afeganistão  1997                41.8
    ## # … with 1,694 more rows

Se referir a cada uma das colunas que desejamos manter, apenas para remover uma única coluna, não é muito eficiente. Pode utilizar, de outro modo, o símbolo de menos (-) para demonstrar que queremos remover uma coluna.

    dados_gapminder %>%
        select(-continente)

    ## # A tibble: 1,704 x 5
    ##    pais          ano expectativa_de_vida populacao pib_per_capita
    ##    <fct>       <int>               <dbl>     <int>          <dbl>
    ##  1 Afeganistão  1952                28.8   8425333           779.
    ##  2 Afeganistão  1957                30.3   9240934           821.
    ##  3 Afeganistão  1962                32.0  10267083           853.
    ##  4 Afeganistão  1967                34.0  11537966           836.
    ##  5 Afeganistão  1972                36.1  13079460           740.
    ##  6 Afeganistão  1977                38.4  14880372           786.
    ##  7 Afeganistão  1982                39.9  12881816           978.
    ##  8 Afeganistão  1987                40.8  13867957           852.
    ##  9 Afeganistão  1992                41.7  16317921           649.
    ## 10 Afeganistão  1997                41.8  22227415           635.
    ## # … with 1,694 more rows

### Filter

A função filter() realiza a mesma tarefa da função select(), mas ao invés de selecionar o nome da coluna, o filter() seleciona linhas da base de dados utilizando requisitos lógicos. Por exemplo, se quisermos selecionar somente os registros dos países em 2007.

    dados_gapminder %>%
        filter(ano == 2007)

    ## # A tibble: 142 x 6
    ##    pais        continente   ano expectativa_de_vida populacao pib_per_capita
    ##    <fct>       <fct>      <int>               <dbl>     <int>          <dbl>
    ##  1 Afeganistão Ásia        2007                43.8  31889923           975.
    ##  2 Albânia     Europa      2007                76.4   3600523          5937.
    ##  3 Argélia     África      2007                72.3  33333216          6223.
    ##  4 Angola      África      2007                42.7  12420476          4797.
    ##  5 Argentina   Américas    2007                75.3  40301927         12779.
    ##  6 Austrália   Oceania     2007                81.2  20434176         34435.
    ##  7 Áustria     Europa      2007                79.8   8199783         36126.
    ##  8 Bahrein     Ásia        2007                75.6    708573         29796.
    ##  9 Bangladesh  Ásia        2007                64.1 150448339          1391.
    ## 10 Bélgica     Europa      2007                79.4  10392226         33693.
    ## # … with 132 more rows

### Mutate

O comando mutate te permite adicionar colunas ao seu dataset ou alterar colunas já existentes. No momento, temos país e continente em duas colunas separadas. Podemos utilizar o comando paste() para combinar os dois textos, especificando um separador. Vamos agrupar as informações em uma única coluna chamada "localizacao".

    dados_gapminder %>%
      mutate(localizacao = paste(pais, continente, sep = ", "))

    ## # A tibble: 1,704 x 7
    ## pais        continente   ano expectativa_de_vida populacao pib_per_capita localizacao      
    ## <fct>       <fct>      <int>               <dbl>     <int>          <dbl> <chr>            
    ## 1 Afeganistão Ásia        1952                28.8   8425333           779. Afeganistão, Ásia
    ## 2 Afeganistão Ásia        1957                30.3   9240934           821. Afeganistão, Ásia
    ## 3 Afeganistão Ásia        1962                32.0  10267083           853. Afeganistão, Ásia
    ## 4 Afeganistão Ásia        1967                34.0  11537966           836. Afeganistão, Ásia
    ## 5 Afeganistão Ásia        1972                36.1  13079460           740. Afeganistão, Ásia
    ## 6 Afeganistão Ásia        1977                38.4  14880372           786. Afeganistão, Ásia
    ## 7 Afeganistão Ásia        1982                39.9  12881816           978. Afeganistão, Ásia
    ## 8 Afeganistão Ásia        1987                40.8  13867957           852. Afeganistão, Ásia
    ## 9 Afeganistão Ásia        1992                41.7  16317921           649. Afeganistão, Ásia
    ## 10 Afeganistão Ásia        1997                41.8  22227415           635. Afeganistão, Ásia
    ## # … with 1,694 more rows

Novamente, você precisa lembrar que o dplyr não salva os dados, nem transforma o original. Na verdade, ele cria uma base de dados temporária em cada etapa. Se você deseja manter o resultado, é necessário criar uma variável permanente.

    dados_gapminder_localizacao <- dados_gapminder %>%
      mutate(localizacao = paste(pais, continente, sep = ", "))

    # Visualiza o novo tibble criado com a localização adicionada
    dados_gapminder_localizacao

    ## # A tibble: 1,704 x 7
    ## pais        continente   ano expectativa_de_vida populacao pib_per_capita localizacao      
    ## <fct>       <fct>      <int>               <dbl>     <int>          <dbl> <chr>            
    ## 1 Afeganistão Ásia        1952                28.8   8425333           779. Afeganistão, Ásia
    ## 2 Afeganistão Ásia        1957                30.3   9240934           821. Afeganistão, Ásia
    ## 3 Afeganistão Ásia        1962                32.0  10267083           853. Afeganistão, Ásia
    ## 4 Afeganistão Ásia        1967                34.0  11537966           836. Afeganistão, Ásia
    ## 5 Afeganistão Ásia        1972                36.1  13079460           740. Afeganistão, Ásia
    ## 6 Afeganistão Ásia        1977                38.4  14880372           786. Afeganistão, Ásia
    ## 7 Afeganistão Ásia        1982                39.9  12881816           978. Afeganistão, Ásia
    ## 8 Afeganistão Ásia        1987                40.8  13867957           852. Afeganistão, Ásia
    ## 9 Afeganistão Ásia        1992                41.7  16317921           649. Afeganistão, Ásia
    ## 10 Afeganistão Ásia        1997                41.8  22227415           635. Afeganistão, Ásia
    ## # … with 1,694 more rows

### Arrange

A função arrange nos permite ordenar nossas colunas de novas formas. Atualmente, em nossa base de dados, os países estão organizados em ordem alfabética. Vamos ordená-los em ordem decrescente de acordo com o total da população.

    dados_gapminder %>%
      arrange(desc(populacao))

    ## # A tibble: 1,704 x 6
    ##    pais  continente   ano expectativa_de_vida  populacao pib_per_capita
    ##    <fct> <fct>      <int>               <dbl>      <int>          <dbl>
    ##  1 China Ásia        2007                73.0 1318683096          4959.
    ##  2 China Ásia        2002                72.0 1280400000          3119.
    ##  3 China Ásia        1997                70.4 1230075000          2289.
    ##  4 China Ásia        1992                68.7 1164970000          1656.
    ##  5 Índia Ásia        2007                64.7 1110396331          2452.
    ##  6 China Ásia        1987                67.3 1084035000          1379.
    ##  7 Índia Ásia        2002                62.9 1034172547          1747.
    ##  8 China Ásia        1982                65.5 1000281000           962.
    ##  9 Índia Ásia        1997                61.8  959000000          1459.
    ## 10 China Ásia        1977                64.0  943455000           741.
    ## # … with 1,694 more rows

### Summarise

A última função do dplyr que veremos é a summarise(). Ela utiliza operações e comandos, com o objetivo de criar uma nova tabela, contendo estatísticas sumarizadas, em formato adequeado para visualização. Vamos utilizar a função summarise para calcular a média da expectativa de vida, considerando toda nossa base.

    dados_gapminder %>%
      summarise(mean(expectativa_de_vida))

    ## # A tibble: 1 x 1
    ##   `mean(expectativa_de_vida)`
    ##                         <dbl>
    ## 1                        59.5

Juntando tudo o que vimos
=======================

Agora, após termos visto os cinco principais verbos do dplyr, podemos criar rapidamente uma visualização dos nossos dados. Vamos criar um gráfico de barras mostrando o número de países com expectativa de vida maior que 50 anos, em 2007.

    expectativa_vida_2007 <- dados_gapminder %>%
      filter(ano == 2007) %>%
      mutate(expectativa_2007 = ifelse(expectativa_de_vida >= 50, "Maior ou igual a 50 anos", "Menor que 50 anos"))

    ggplot(expectativa_vida_2007) +
      geom_bar(aes(x = expectativa_2007, fill = expectativa_2007)) +
      labs(x = "A expectativa de vida é maior que 50 anos?")

{% include figure.html filename="img/expectativa_vida_2007.png" caption="Expectativa de vida nos países em 2007" %}

Novamente, fazendo uma pequena mudança em nosso código, podemos ver também o número de países com expectativa de vida maior que 50 anos, em 1952.

    expectativa_vida_1952 <- dados_gapminder %>%
      filter(ano == 1952) %>%
      mutate(expectativa_1952 = ifelse(expectativa_de_vida >= 50, "Maior ou igual a 50 anos", "Menor que 50 anos"))

    ggplot(expectativa_vida_1952) +
      geom_bar(aes(x = expectativa_1952, fill = expectativa_1952)) +
      labs(x = "A expectativa de vida é maior que 50 anos?")

({% include figure.html filename="img/expectativa_vida_1952.png" caption="Expectativa de vida nos países em 1952" %}

Conclusão
==========

Este tutorial deve encaminhar seus conhecimentos em relação a como organizar e manipular dados usando R. Posteriormente, você provavelmente vai querer visualizar esses dados de alguma maneira, usando gráficos, como fizemos em partes desta lição. Recomendo que você comece a estudar o [ggplot2](http://www.ggplot2.org), pacote com uma coleção de ferramentas que funcionam bem em conjunto com o dplyr. No futuro, você deve buscar conhecer as outras funções do pacote dplyr, que não vimos aqui, para aprimorar suas habilidades de manipulação de dados. Por enquanto, esta lição deve proporcionar um bom ponto de partida, que cobre muitos dos principais problemas que você irá encontrar.
