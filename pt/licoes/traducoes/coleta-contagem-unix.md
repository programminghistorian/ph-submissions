---
title: Contagem e coleta de dados de investigação com Unix
layout: lesson
slug: dados-de-investigacao-com-unix
date: 2014-09-20
translation_date: 2021-12-17
authors:
- James Baker
- Ian Milligan
reviewers:
- M. H. Beals
- Allison Hegel
editors:
- Adam Crymble
translator:
- Felipe Lamarca
translation-editor:
- Jimmy Medeiros
translation-reviewer:
- 
difficulty: 2
review-ticket: 
activity: transformar
topics: [manipulacao-de-dados]
abstract: "Esta lição examinará como dados de investigação, quando organizados de maneira clara e previsível, podem ser contabilizados e minerados utilizando o Unix shell."
redirect_from: /lessons/research-data-with-unix
original: research-data-with-unix
avatar_alt: A diagram of a miner sorting ore into an apparatus
doi:
---

{% include toc.html %}

# Contagem e mineração de dados de investigação com Unix

## Introdução

Esta lição examinará como dados de investigação, quando organizados de maneira clara e previsível, podem ser contabilizados e minerados utilizando o Unix shell. Esta lição se baseia nas lições "[Preservar seus dados de investigação](https://programminghistorian.org/pt/licoes/preservar-os-seus-dados-de-investigacao)" e "[Introduction to the Bash Command Line](https://programminghistorian.org/en/lessons/intro-to-bash)". Dependendo do quão confiante estiver no uso do Unix shell, ela também pode ser usada como uma lição independente ou uma revisão.

Uma vez acumulados dados de investigação para um projeto, um historiador pode fazer diferentes perguntas aos mesmos dados durante um projeto subsequente. Caso estes dados estejam espalhados em vários ficheiros - uma série de dados tabulados, um conjunto de textos transcritos, uma coleção de imagens -, eles podem ser contabilizados e minerados utilizando comandos Unix simples.

O shell Unix oferece acesso a uma ampla gama de comandos que podem transformar o modo como você contabiliza e minera dados de investigação. Essa lição irá apresentá-lo a uma série de comandos que usam contagem e mineração de dados tabulados, embora eles apenas arranhem a superfície do que o shell Unix pode fazer. Ao aprender apenas alguns comandos simples, você será capaz de realizar tarefas que são impossíveis no Libre Office Calc, Microsoft Excel ou outros programas de planilha similares. Esses comandos podem facilmente ter seu uso estendido para dados não tabulados.

Essa lição também irá demonstrar que as opções disponíveis para manipulação, contagem e mineração de dados geralmente dependem na quantidade de metadados, ou texto descritivo, contidos nos nomes dos ficheiros dos dados que você estiver utilizando, tanto quanto da gama de comandos Unix que você aprendeu a utilizar. Portanto, ainda que não seja um pré-requisito do trabalho com o Unix shell, reservar um momento para estruturar seus dados de investigação e convenções de nomes de ficheiros de uma maneira consistente e previsível é certamente um passo significativo para aproveitar ao máximo os comandos Unix e ser capaz de contar e minerar seus dados de investigação. Para entender a importância de dedicar um tempo a tornar seus dados consistentes e previsíveis, além de questões de preservação, consulte:  "[Preservar seus dados de investigação](https://programminghistorian.org/pt/licoes/preservar-os-seus-dados-de-investigacao)".

_____

## Software e configuração

Usuários de Windows precisarão instalar o Git Bash. Ele pode ser instalado fazendo o download do instalador mais recente na [página web do git for windows](https://gitforwindows.org/). Instruções de instalação estão disponíveis no [Open Hatch](https://web.archive.org/web/20190318191709/https://openhatch.org/missions/windows-setup/install-git-bash).

Usuários de OS X e Linux deverão utilizar os próprios terminais para seguir esta lição, como foi discutido em "[Introduction to the Bash Command Line](https://programminghistorian.org/en/lessons/intro-to-bash)".

Esta lição foi escrita utilizando o Git Bash 1.9.0 e o sistema operacional Windows 7. Caminhos de ficheiro equivalentes para OS X/Linux foram incluídos sempre que possível. No entanto, como os comandos e sinalizadores podem mudar ligeiramente entre os sistemas operacionais OS X/Linux, sugere-se que os usuários verifiquem Deborah S. Ray e Eric J. Ray, "[*Unix and Linux: Visual Quickstart Guide*](https://www.worldcat.org/title/unix-and-linux/oclc/308171076&referer=brief_results)", 4ª edição, que cobre a interoperabilidade em maiores detalhes.

Os ficheiros utilizados nesta lição estão disponíveis em "[Figshare](https://doi.org/10.6084/m9.figshare.1172094)". Os dados contêm os metadados para artigos de periódicos categorizados em 'History' no banco de dados ESTAR da British Library. Os dados são compartilhados sob isenção dos direitos autorais CC0.

Faça o download dos ficheiros necessários, salve-os no seu computador e descompacte-os. Caso você não tenha um software padrão para lidar com ficheiros .zip, recomendamos [7-zip](http://www.7-zip.org/) para este propósito. No Windows, recomendamos descompactar a pasta em sua unidade c: para que os ficheiros estejam em `c:\proghist\`. No entanto, qualquer localização servirá, mas você precisará ajustar seus comandos à medida que for avançando na lição caso use uma localização diferente. No caso de OS X ou Linux, recomendamos de modo similar que você descompacte os ficheiros no seu diretório de usuário, de modo que eles apareçam em `/usuario/NOME-DE-USUARIO/proghist/`. Em ambos os casos, isso significa que, ao abrir uma nova janela de terminal, você pode simplesmente digitar `cd proghist` para mover para o diretório correto.

_____

## Contabilizando ficheiros

Você começará esta lição contabilizando os conteúdos dos ficheiros utilizando o Unix shell. O Unix shell pode ser usado para rapidamente gerar contagens de ficheiros, algo difícil de se conseguir usando interfaces gráficas de usuário (do inglês, *Graphical User Interfaces* - GUI) de suítes padrão de escritório.

No Unix, o comando `wc` é usado para contar os conteúdos de um ficheiro ou de uma série de ficheiros.

Abra o Unix shell e navegue até o diretório que contém nossos dados, o subdiretório `data` do diretório `proghist`. Lembre-se: caso você não tenha certeza de onde está na sua estrutura de diretórios, digite `pwd` e use o comando `cd` mara mover para onde precisa estar. A estrutura de diretórios é um pouco diferente entre OS X/Linux e Windows: no primeiro caso, o diretório está em um formato como `~/usuario/NOME-DE-USUARIO/proghist/data`, e no Windows o formato é do tipo `c:\proghist\data`.

Digite `ls` e pressione a tecla Enter. Isso imprime, ou exibe, uma lista que inclui dois ficheiros e um subdiretório.

Os ficheiros nesse diretório são a base de dados `2014-01_JA.csv`, que contém os metadados dos artigos de periódico, e um ficheiro contendo a documentação a respeito do `2014-01_JA.csv` chamado `2014-01_JA.txt`.

O subdiretório é nomeado como `derived_data`. Ele contém quatro ficheiros [.tsv](http://en.wikipedia.org/wiki/Tab-separated_values) derivados do `2014-01_JA.csv`. Cada um deles inclui todos os dados em que uma palavra-chave como `africa` ou `america` aparece no campo `Title` do `2014-01_JA.csv`. O diretório `derived_data` também inclui um subdiretório chamado `results`.

*Nota: Ficheiros [CSV](http://en.wikipedia.org/wiki/Comma-separated_values) são aqueles nos quais cada unidade de dado (ou células) são separados por vírgula (comma-separated-values) e ficheiros TSV são aqueles nos quais as unidades são separadas por tabulação. Ambos podem ser lidos em editores de texto simples ou em programas de planilha como Libre Office Calc ou Microsoft Excel.*

Antes de começar a trabalhar com esses ficheiros, você deve mover-se para dentro do diretório no qual eles estão armazenados. Navegue até `c:\proghist\data\derived_data` no Windows ou `~/usuario/NOME-DE-USUARIO/proghist/data/derived_data` no OS X/Linux.

Agora que você já está aqui, pode contabilizar o conteúdo dos ficheiros.

O comando Unix para contagem é `wc`. Digite `wc -w 2014-01-31_JA_africa.tsv` e pressione a tecla Enter. O sinalizador `-w` combinado com `wc` instrui o computador a imprimir no shell uma contagem de palavras e o nome do ficheiro que foi contabilizado.

Como foi visto no "[Introduction to the Bash Command Line](https://programminghistorian.org/en/lessons/intro-to-bash)", sinalizadores como `-w` são parte essencial para aproveitar ao máximo o Unix shell, uma vez que eles oferecem melhor controle sobre os comandos.

Se a sua investigação está mais interessada no número de entradas (ou linhas) do que no número de palavras, você pode utilizar o sinalizador de contagem de linhas. Digite `wc -l 2014-01-31_JA_africa.tsv` e pressione Enter. Combinado com o `wc`, o sinalizador `-l` imprime uma contagem de linhas e o nome do ficheiro que foi contabilizado.

Finalmente, digite `wc -c 2014-01-31_JA_africa.tsv` e pressione Enter. Isso usa o sinalizador `-c` combinado ao comando `wc` para imprimir uma contagem de caracteres do `2014-01-31_JA_africa.tsv`.

*Nota: Usuários de OS X e Linux devem substituir o sinalizador `-c` por `-m`.*

Com esses três sinalizadores, o uso mais simples que um historiador pode fazer do comando `wc` é comparar o formato das fontes no formato digital - por exemplo, a contagem do número de palavras por página de um livro, a distribuição de caracteres por página ao longo de uma coleção de jornais, o comprimento médio das linhas usadas pelos poetas. Você também pode utilizar `wc` com uma combinação de "curingas" (*wildcards*) e sinalizadores para construir consultas mais complexas. Digite `wc -l 2014-01-31_JA_a*.tsv` e pressione Enter. Isso imprime a contagem de linhas para `2014-01-31_JA_africa.tsv` e `2014-01-31_JA_america.tsv`, oferecendo uma maneira simples de comparar esses dois conjuntos de dados de investigação. Claro, pode ser mais rápido comparar a contagem de linhas desses dois documentos no Libre Office Calc, Microsoft Excel ou outro programa de planilhas similar. Mas quando desejar comparar a contagem de linhas de dezenas, centenas ou milhares de documentos, o shell Unix tem uma clara vantagem em velocidade.

Além disso, à medida que nossos conjuntos de dados aumentam de tamanho, você pode utilizar o Unix shell para fazer mais do que copiar essas contagens de linha manualmente, com *prints* de tela ou com métodos de cópia e cola. Ao utilizar o `>` operador de redirecionamento você pode exportar os resultados da sua consulta em um novo ficheiro. Digite `wc -l 2014-01-31_JA_a*.tsv > results/2014-01-31_JA_a_wc.txt` e pressione Enter. Isso executa a mesma consulta anterior, mas, ao invés de imprimir os resultados no Unix shell, ele salva os resultados como `2014-01-31_JA_a_wc.txt`. Ao preceder com `results/`, ele move o ficheiro .txt para o subdiretório `results`. Para checar isso, navegue até o subdiretório `results`, pressione Enter, digite `ls` e pressione Enter mais uma vez para ver este ficheiro listado em `c:\proghist\data\derived_data\results` no Windows ou `/usuario/NOME-DE-USUARIO/proghist/data/derived_data/results` no OS X/Linux.

## Minerando ficheiros

O Unix shell pode fazer muito mais do que contar palavras, caracteres e linhas de um ficheiro. O comando `grep` (que significa 'global regular expression print') é usado para buscar strings (cadeias de caracteres) específicas ao longo de múltiplos ficheiros. Ele é capaz de fazer isso muito mais rapidamente do que interfaces gráficas de busca oferecidas pela maioria dos sistemas operacionais ou suítes de escritório. Combinado ao operador `>`, o comando `grep` se torna uma ferramenta de investigação poderosa, que pode ser usada para minerar seus dados em busca de características ou grupos de palavras que aparecem ao longo de múltiplos ficheiros e então exportar esses dados para um novo ficheiro. As únicas limitações aqui são a sua imaginação, o formato dos seus dados e - quando trabalhando com milhares ou milhões de ficheiros - o poder de processamento a seu dispor.

Para começar a utilizar o `grep`, primeiro navegue até o diretório `derived_data` (`cd ..`). Aqui digite `grep 1999 *.tsv` e pressione Enter. Essa consulta busca em todos os ficheiros no diretório que se enquadram nos critérios fornecidos (os ficheiros .tsv) por instâncias da string, ou cluster de caracteres, '1999'. Em seguida, imprime no shell. 

*Nota: há uma grande quantidade de dados a serem imprimidos. Então, caso você fique entediado, pressione `ctrl+c` para cancelar a ação. Ctrl+c é utilizado para cancelar qualquer processo no Unix shell.*

Pressione a seta para cima uma vez para voltar à ação mais recente. Altere `grep 1999 *.tsv` para `grep -c 1999 *.tsv` e pressione Enter. O shell agora irá imprimir o número de vezes que a string 1999 apareceu em cada um dos ficheiros .tsv. Volte à linha anterior novamente, altere para `grep -c 1999 2014-01-31_JA_*.tsv > results/2014-01-31_JA_1999.txt` e pressione Enter. Essa consulta procura instâncias da string '1999' em todos os documentos que se adequam aos critérios e as salva em `2014-01-31_JA_1999.txt` no subdiretório `results`.

Strings não precisam ser números. `grep -c revolution 2014-01-31_JA_america.tsv 2014-02-02_JA_britain.tsv`, por exemplo, conta todas as instâncias da string `revolution` dentro dos ficheiros definidos e imprime essas contagens no shell. Execute esse comando e o altere para `grep -ci revolution 2014-01-31_JA_america.tsv 2014-02-02_JA_britain.tsv`. Isso repete a consulta, mas imprime um resultado que não diferencia maiúsculas de minúsculas (incluindo instâncias `revolution` e `Revolution`). Note que a contagem aumentou quase 30 vezes para os títulos de artigos de períodicos que contêm a palavra-chave `revolution`. Como antes, voltar ao comando anterior e adicionar `> results/`, seguido do nome do ficheiro (idealmente no formato .txt), armazenará os resultados em um ficheiro.

Você também pode utilizar o `grep` para criar subconjuntos de dados tabulados. Digite `grep -i revolution 2014-01-31_JA_america.tsv 2014-02-02_JA_britain.tsv > ANO-MES-DIA_JA_america_britain_i_revolution.tsv` (onde `ANO-MES-DIA` é a data em que você está completando esta lição) e pressione Enter. Este comando verifica ambos os ficheiros definidos e exporta todas as linhas contendo `revolution` (sem diferenciar maiúsculas de minúsculas) para o ficheiro .tsv especificado.

O dado não foi salvo ao diretório `results` porque ele não é estritamente um resultado; é um dado derivado. Dependendo do seu projeto de investigação, pode ser mais fácil armazenar isso em outro subdiretório. Por enquanto, dê uma olhada neste ficheiro para verificar seu conteúdo e, quando estiver satisfeito, delete-o usando o comando `rm`. *Nota: o comando `rm` é muito poderoso e deve ser usado com cautela. Por favor, verifique "[Introduction to the Bash Command Line](https://programminghistorian.org/en/lessons/intro-to-bash)" para instruções de como utilizar esse comando corretamente.*

Finalmente, você pode usar outro sinalizador, `-v`, para excluir elementos ao usar o comando `grep`. Digite `grep -iv revolution 2014*_JA_a*.tsv > 2014_JA_iv_revolution.csv` e pressione Enter. Essa consulta busca nos ficheiros definidos (três no total) e exporta todas as linhas que não contêm `revolution` ou `Revolution` ao `c:\proghist\data\derived_data\2014_JA_iv_revolution.csv`.

Note que você transformou os dados de um formato para outro - de .tsv para .csv. Frequentemente há uma perda de estrutura dos dados ao realizar essas transformações. Para observar isso, execute `grep -iv revolution 2014*_JA_a*.tsv > 2014_JA_iv_revolution.tsv` e abra os ficheiros .csv e .tsv no Libre Office Calc, Microsoft Excel, ou outro programa de planilhas similar. Observe as diferenças no delineamento da coluna entre os dois ficheiros. 

*Resumo*

Agora no Unix shell você pode:

- usar o comando `wc` com os sinalizadores `-w` e `-l` para contar as palavras e linhas de um ficheiro ou uma série de ficheiros.
- usar o redirecionador ou estrutura `subdiretório/nome-do-ficheiro` para armazenar os resultados em um subdiretório.
- usar o comando `grep` para buscar por instâncias de uma string.
- usar `grep` com o sinalizador `-c` para contar instâncias de uma string, o sinalizador `-i` para retornar buscas por strings ignorando diferenças entre maiúsculas e minúsculas, e o sinalizador `-v` para excluir uma string dos resultados.
- combinar esses comandos e sinalizadores para construir consultas complexas de uma forma que sugere o potencial de uso do Unix shell para contabilizar e minerar seus dados de investigação e projetos de investigação.

_____

#### Conclusão

Nessa lição você aprendeu a executar contagens básicas em ficheiros, realizar consultas em dados de investigação em busca de strings comuns e armazenar resultados e dados derivados. Ainda que essa lição seja restrita ao uso do Unix shell para contabilizar e minerar dados tabulados, os processos podem facilmente ser estendidos a textos livres. Para isso, recomendamos dois guias escritos por William Turkel:

- William Turkel, '[Basic Text Analysis with Command Line Tools in Linux](http://williamjturkel.net/2013/06/15/basic-text-analysis-with-command-line-tools-in-linux/)' (15 de junho de 2013)
- William Turkel, '[Pattern Matching and Permuted Term Indexing with Command Line Tools in Linux](http://williamjturkel.net/2013/06/20/pattern-matching-and-permuted-term-indexing-with-command-line-tools-in-linux/)' (20 de junho de 2013)

Como essas recomendações sugerem, a presente lição apenas arranha a superfície do que o ambiente do Unix shell é capaz de fazer. Espera-se, no entanto, que esta lição tenha oferecido uma prova suficiente para estimular uma investigação mais aprofundada e uma prática produtiva.

Para muitos historiadores, o potencial total dessas ferramentas deve surgir somente ao incorporar essas habilidades em um projeto de investição real. Uma vez que a sua investigação cresce, e, com isso, seus dados de investigação, ser capaz de manipular, contabilizar e minerar milhares de ficheiros será extremamente útil. Caso opte por trabalhar nesta lição e investigar o Unix shell mais a fundo, você descobrirá que mesmo uma grande coleção de ficheiros que não contêm quaisquer elementos de dados alfanuméricos, como ficheiros de imagem, podem ser facilmente classificados, selecionados e consultados em um Unix shell.


