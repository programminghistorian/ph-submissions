---
title: Introdução aos Dados Abertos Vinculados
layout: lesson
date: 2013-08-05
translation_date: 2021-10-11
authors:
- Jonathan Blaney
reviewers:
- Terhi Nurmikko-Fuller
- Matthew Lincoln
editors:
- Adam Crymble
translator:
- Francisco Nabais
translation-editor:
- Joana Vieira Paulino
translation-reviewer:
- 
- 
difficulty: 1
review-ticket: 
activity: acquiring
topics: [lod]
abstract: "Este tutorial apresenta os principais conceitos de Linked Open Data, incluindo URIs, ontologias, formatos RDF e uma breve introdução à linguagem de consulta de gráficos SPARQL."
redirect_from: 
avatar_alt: Um homem velho com uma mulher em cada braço
doi: A INDICAR
---

{% include toc.html %}

Nota de Tradução: Alguns termos, por aparecerem constantemente e facilitarem a interpretação das imagens, apenas foram propositadamente traduzidos uma vez e serão colocados entre parênteses. Alertamos também para a existência de alguns exemplos que não foram propositadamente traduzidos para facilitar a sua introdução nos programas apresentados.


Introdução e Âmbito da lição
-----------------------------

Esta lição oferece uma breve e concisa introdução sobre [*Linked Open Data*](https://pt.wikipedia.org/wiki/Linked_data#The_Linking_Open_Data_Project) (LOD) (Dados Abertos Vinculados). Não é necessário nenhum conhecimento prévio para desenvolver este tutorial. Os leitores deverão obter uma compreensão clara dos conceitos por detrás de *Linked Open Data*, como são utilizados e como são criados. O tutorial está dividido em cinco partes, mais a leitura posterior:

1. *Linked Open Data*: o que é?
2. O papel do [*Uniform Resource Identifier*](https://pt.wikipedia.org/wiki/URI) (URI) (Identificador Uniforme de Recurso)
3. Como o LOD organiza o conhecimento: [Ontologias](https://pt.wikipedia.org/wiki/Ontologia_(ci%C3%AAncia_da_computa%C3%A7%C3%A3o))
4. O [*Resource Description Framework*](https://pt.wikipedia.org/wiki/Resource_Description_Framework) (RDF) (Quadro de Descrição de Recursos) e formatos de dados
5. Consulta de *Linked Open Data* com [SPARQL](https://pt.wikipedia.org/wiki/SPARQL)
6. Outras leituras e recursos

Este tutorial deverá levar algumas horas a completar e poderá ser útil reler algumas secções para solidificar a sua compreensão. Os termos técnicos foram ligados à sua página correspondente na Wikipedia e encoraja-se a fazer uma pausa e ler sobre termos que considere desafiantes. Depois de ter aprendido alguns dos princípios chave de LOD, a melhor maneira de melhorar e solidificar esse conhecimento é praticar. Este tutorial fornece oportunidades para o fazer. No final da lição, deverá compreender os princípios básicos de LOD, incluindo termos e conceitos chave.

Se precisar de aprender a explorar LOD usando a linguagem de consulta [SPARQL](https://pt.wikipedia.org/wiki/SPARQL), recomenda-se a lição de Matthew Lincoln ['*Using SPARQL to access Linked Open Data*'](/lessons/graph-databases-and-SPARQL) (em inglês), que segue praticamente a visão geral fornecida nesta lição.

Para proporcionar aos leitores uma base sólida dos princípios básicos de LOD, este tutorial não será capaz de oferecer uma cobertura abrangente de todos os seus conceitos. Estes **não** serão o foco desta lição:

1. [Web Semântica](https://pt.wikipedia.org/wiki/Web_sem%C3%A2ntica) e [raciocínio semântico](https://en.wikipedia.org/wiki/Semantic_reasoner) (em inglês) de [Datasets](https://pt.wikipedia.org/wiki/Conjunto_de_dados). Um raciocinador semântico deduziria que George VI é o irmão ou meio-irmão de Eduardo VIII, dado que: a) Eduardo VIII é o filho de Jorge V e b) Jorge VI é o filho de Jorge V. Este tutorial não se foca neste tipo de tarefa.
2. Criação e carregamento de *Linked Open Datasets* (Conjunto de Dados abertos Vinculados) ligados à [Nuvem de *Linked Data*](http://linkeddatacatalog.dws.informatik.uni-mannheim.de/state/) (em inglês). Partilhar LOD é um princípio importante, que é encorajado abaixo. Contudo, os aspetos práticos de contribuir com LOD para a nuvem de *Linked Data* estão para além do âmbito desta lição. Alguns recursos que podem ajudar a começar esta tarefa estão disponíveis no final deste tutorial.

## *Linked Open Data*: O que é isso?

LOD é informação estruturada num formato destinado a máquinas e, por isso, não é necessariamente um conceito de fácil definição. É importante não perder a motivação com esta informação, já que, ao compreender os princípios, pode formatar uma máquina para fazer a leitura por si.

Se todos os datasets fossem publicados abertamente e utilizassem o mesmo formato para estruturar a informação, seria possível interrogá-los todos de uma só vez. A análise de grandes volumes de dados é potencialmente muito mais poderosa do que qualquer pessoa que utilize os seus próprios datasets individuais espalhados pela web nos chamados [silos de informação](https://en.wikipedia.org/wiki/Information_silo) (em inglês). Estes datasets interoperáveis são aquilo para que os profissionais de LOD estão a trabalhar.

Para atingir este objetivo, ao trabalhar com LOD, é importante recordar três princípios:

1. **Utilizar um formato padrão de LOD reconhecido**. Para que o LOD funcione, os dados devem ser [estruturados](https://pt.wikipedia.org/wiki/Estrutura_de_dados) utilizando normas reconhecidas para que os computadores que interrogam os dados possam processá-los de forma consistente. Há vários formatos de LOD, alguns dos quais são discutidos abaixo.
2. **Referir uma entidade da mesma forma que outras pessoas o fazem**. Se existirem dados sobre a mesma pessoa/local/coisa em dois ou mais locais, certifique-se de que se refere à pessoa/local/coisa da mesma forma em todos os casos.
3. **Publicar os seus dados abertamente**. Qualquer pessoa deverá poder utilizar os seus dados sem pagar uma taxa e num formato que não exija [software proprietário](https://pt.wikipedia.org/wiki/Software_propriet%C3%A1rio).

Comecemos com um exemplo de dados sobre uma pessoa, utilizando uma abordagem comum [par atributo-valor](https://en.wikipedia.org/wiki/Attribute%E2%80%93value_pair) (em inglês,) típica em computação:

    pessoa=número

Neste caso, o 'atributo' é uma pessoa. E o valor - ou quem é essa pessoa - é representado por um número. O número pode ser atribuído aleatoriamente, ou pode ser utilizado um número que já esteja associado a essa pessoa. Esta última abordagem tem grandes vantagens: se todos os que criarem um dataset que menciona essa pessoa, utilizarem *exatamente o mesmo número, exactamente no mesmo formato*, então podemos encontrar esse indivíduo de forma fiável em qualquer dataset aderindo a essas regras. Vamos criar um exemplo usando Jack Straw: tanto o nome de um rebelde inglês do século XIV, como o de um ministro de gabinete britânico proeminente na administração de Tony Blair. É claramente útil ser capaz de diferenciar as duas pessoas que partilham um nome comum.


Utilizando o modelo acima, no qual cada pessoa é representada por um número único, vamos  atribuir ao ministro britânico Jack Straw o número `64183282`. O seu par atributo-valor ficaria então com este aspeto:

    pessoa=64183282

E vamos fazer com que Jack Straw seja descrito pelo *[Oxford Dictionary of National Biography](http://www.oxforddnb.com)* (em inglês) como 'o enigmático líder rebelde', número `33059614`, fazendo com que o seu par atributo-valor se pareça com isto:

    pessoa=33059614

Desde que todos os que fazem LOD utilizem estes dois números para se referirem aos respetivos Jack Straws, podemos agora procurar a pessoa `64183282` num *linked open dataset* e podemos estar confiantes de que estamos a obter a pessoa certa - neste caso, o ministro.

Os pares atributo-valor também podem armazenar informações sobre outros tipos de entidades: lugares, por exemplo. Jack Straw, o político moderno, era membro do Parlamento britânico, representando a sede de Blackburn. Há mais do que um lugar no Reino Unido chamado Blackburn, para não mencionar outros Blackburn em todo o mundo. Usando os mesmos princípios acima delineados, podemos desambiguar entre as vários Blackburns, atribuindo um identificador único ao lugar correto: Blackburn em Lancashire, Inglaterra.

	Lugar=2655524

Neste momento pode estar a pensar, "isso é o que um catálogo de biblioteca faz". É verdade que a ideia-chave aqui é a do [ficheiro de autoridade](https://en.wikipedia.org/wiki/Authority_control) (em inglês), central na ciência das bibliotecas (um ficheiro de autoridade é uma lista definitiva de termos que podem ser utilizados num contexto particular, por exemplo, quando se cataloga um livro). Nos dois exemplos acima descritos, utilizámos ficheiros de autoridade para atribuir números (os identificadores únicos) aos Jacks e ao Blackburn. Os números que utilizámos para os dois Jack Straws provêm do [Virtual International Authority File](https://viaf.org) (em inglês) (VIAF) (Arquivo Internacional de Autoridade Virtual), que é suportado por um consórcio de bibliotecas de todo o mundo, de modo a tentar resolver o problema da miríade de maneiras pelas quais a mesma pessoa pode ser referida. O identificador único que utilizámos para o círculo eleitoral de Blackburn provém de [GeoNames](http://www.geonames.org/) (em inglês), uma base de dados geográfica gratuita.

Vamos tentar ser mais precisos com o que queremos dizer com Blackburn neste caso. Jack Straw representou a constituição parlamentar (uma área representada por um único membro do parlamento) de Blackburn, que mudou os seus limites ao longo do tempo. O projeto "[*Digging Into Linked Parliamentary Data*](http://dilipad.history.ac.uk)" (Dilipad) (em inglês), no qual trabalhei, produziu identificadores únicos para as filiações partidárias e circunscrições eleitorais para cada membro do parlamento. Neste exemplo, Jack Straw representou o eleitorado conhecido como 'Blackburn' na sua encarnação pós-1955:

	blackburn1955-presente

Como o VIAF é um ficheiro de autoridade respeitado e desenvolvido por especialistas, fornece um conjunto óbvio de identificadores a utilizar para Jack Straw. Como a circunscrição representada por Straw estava perfeitamente coberta pelos ficheiros de autoridade criados pelo projeto Dilipad, também era um ficheiro de autoridade lógico a utilizar. Infelizmente, nem sempre é tão óbvio qual das listas publicadas online é a melhor para se usar. Uma pode ser mais utilizada do que outra, mas esta última pode ser mais abrangente para um determinado fim. O GeoNames funcionaria melhor do que os identificadores da Dilipad em alguns casos. Haverá também casos em que não se consegue encontrar um conjunto de dados com essa informação. Por exemplo, se quiser escrever pares atributo-valor sobre si próprio e as suas relações familiares imediatas, terá de inventar os seus próprios identificadores.

Esta falta de arquivos de autoridade coerentes é um dos maiores desafios que o LOD está a enfrentar neste momento. [Tim Berners-Lee](https://pt.wikipedia.org/wiki/Tim_Berners-Lee), inventou uma forma de ligar documentos em rede e criou assim a  World Wide Web, há muito um dos principais proponentes de LOD. Para encorajar uma maior utilização de LOD, sugeriu um "[sistema de classificação de cinco estrelas](https://www.w3.org/DesignIssues/LinkedData.html)" (em inglês) para que todos avançassem o mais longe possível em direção ao LOD. Essencialmente, Tim Verners-Lee apoia a publicação aberta de dados, especialmente, ao utilizar formatos abertos e normas públicas, mas o melhor é que o usuário se ligue também aos dados de outras pessoas.

Com os identificadores únicos atribuídos a todos os elementos, o próximo passo fundamental na criação de LOD é ter uma forma de *descrição* da relação entre Jack Straw (`64183282`) e Blackburn (`blackburn1955-presente`). Em LOD, as relações são expressas utilizando o que é conhecido como '[triplo](https://en.wikipedia.org/wiki/Semantic_triple)' (em inglês). Vamos fazer um triplo que represente a relação entre Jack Straw e o seu eleitorado:

    pessoa:64183282 papel:representadaNoParlamentoBritânico circunscrição eleitoral:"blackburn1955-current" .

A apresentação (ou [sintaxe](https://pt.wikipedia.org/wiki/Sintaxe)) dos triplos, incluindo a pontuação utilizada acima, será discutida mais tarde, na secção sobre RDF e formatos de dados. Por agora, vamos focar-nos na estrutura básica. O triplo, não surpreendentemente, tem três partes. Estas são convencionalmente referidas como assunto (*subject*), predicado (*predicate*) e objeto (*object*):

| o assunto     | o predicado             | o objeto              |
| --------------- | ------------------------- | ----------------------- |
| pessoa 64183282 | representadaNoParlamentoBritânico | "blackburn1955-presente" |

A forma tradicional de representar um triplo em forma esquemática é a seguinte (em inglês):

{% include figure.html filename="intro-to-linked-data-fig5.png" caption="A forma tradicional de representar um triplo" %}

Assim, o nosso triplo do Jack Straw, apresentado de forma mais legível para o ser humano, poderia assumir a seguinte forma (em inglês):

{% include figure.html filename="intro-to-linked-data-fig6.png" caption="Diagrama triplo que demonstra que Jack Straw representava Blackburn" %}

- O LOD deve estar aberto e disponível para qualquer pessoa na Internet (caso contrário, não está "aberto")
- Os defensores do LOD têm como objetivo normalizar as formas de referência a entidades únicas
- O LOD consiste em triplos que descrevem as relações entre entidades

## O papel do *Uniform Resource Identifier* (URI)

Uma parte essencial de LOD é o [*Uniform Resource Identifier*](https://pt.wikipedia.org/wiki/URI)(Identificador Uniforme de Recursos) ou URI. O URI é uma forma única e fiável de representar uma entidade (uma pessoa, um objeto, uma relação, etc.), de uma forma que é utilizável por todos no mundo.

Na secção anterior, utilizámos dois números diferentes para identificar os diferentes Jack Straws.

    pessoa="64183282"

    pessoa="33059614"

O problema é que em todo o mundo existem muitas bases de dados que contêm pessoas com estes números e são, provavelmente, todas pessoas diferentes. Fora do nosso contexto imediato, estes números não identificam indivíduos únicos. Vamos tentar resolver isso. Aqui estão estes mesmos identificadores, mas como URIs:

    http://viaf.org/viaf/64183282/

    http://viaf.org/viaf/33059614/

Tal como o número único desambiguou os nossos dois Jack Straws, o URI completo acima ajuda-nos a desambiguar entre todos os diferentes ficheiros de autoridade lá fora. Neste caso, é evidente que estamos a utilizar o VIAF como o nosso ficheiro de autoridade. Com certeza, já viu esta forma de desambiguação muitas vezes na web. Existem muitos websites em todo o mundo com páginas chamadas `/home` ou `/faq`. Mas não há confusão porque o [domínio](https://pt.wikipedia.org/wiki/Nome_de_dom%C3%ADnio) (a primeira parte do [*Uniform Resource Locator*](https://pt.wikipedia.org/wiki/URL) (URL) (Localizador Uniforme de Recursos) - eg. `bbc.co.uk`) é único, portanto, todas as páginas que fazem parte desse domínio são únicas de outras páginas `/faq` de outros sítios web. No endereço `http://www.bbc.co.uk/faqs` é a parte `bbc.co.uk` que torna as páginas subsequentes únicas. Isto é tão óbvio para as pessoas que utilizam a web a toda a hora que não pensam sobre isso. Provavelmente, também sabe que se quiser iniciar um website chamado `bbc.co.uk` não pode, porque esse nome já foi registado com a autoridade apropriada, que é o [*Domain Name System*](https://pt.wikipedia.org/wiki/Sistema_de_Nomes_de_Dom%C3%ADnio) (Sistema de Nomes de Domínio). O registo garante a singularidade. Os URIs também têm de ser únicos.

Embora os exemplos acima se pareçam com URLs, é também possível construir um URI que não se pareça nada com um URL. Temos muitas formas de identificar pessoas e coisas de forma única e raramente pensamos ou nos preocupamos com isso. Os códigos de barras, números de passaporte, até mesmo os códigos postais são concebidos para serem únicos. Os números de telemóvel são frequentemente colocados como sinais de loja precisamente porque são únicos. Todos eles podem ser utilizados como URIs.

Quando criámos URIs para as entidades descritas pelo projeto '[Tobias](http://www.history.ac.uk/projects/digital/tobias)' (em inglês), escolhemos uma estrutura do tipo URL e escolhemos utilizar o nosso espaço web institucional, pondo de lado `data.history.ac.uk/tobias-project/` como um lugar dedicado ao alojamento destas URIs. Ao colocá-lo em `data.history.ac.uk` em vez de `history.ac.uk`, houve uma separação clara entre URIs e as páginas do sítio web. Por exemplo, um dos URIs do projeto Tobias era 'http://data.history.ac.uk/tobias-project/person/15601'. Embora o formato dos URIs acima mencionados seja o mesmo que um URL, eles não se ligam a páginas web (tente colá-lo num navegador web). Muitas pessoas novas no LOD acham isto confuso. Todos os URLs são URIs, mas nem todos os URIs são URLs. Um URI pode descrever qualquer coisa, enquanto o URL descreve a localização de algo na web. Assim, um URL diz-lhe a localização de uma página web, de um ficheiro ou algo semelhante. Um URI faz apenas o trabalho de identificar algo. Tal como o International Standard Book Number (Número Internacional Padrão do Livro) ou [ISBN](https://www.iso.org/standard/36563.html) (em inglês), `978-0-1-873354-6` identifica exclusivamente uma edição de capa dura de _Baptism, Brotherhood and Belief in Reformation Germany_ de Kat Hill, mas não diz onde obter uma cópia. Para isso precisaria de algo como um [número de acesso](https://pt.wikipedia.org/wiki/N%C3%BAmero_de_acesso_(biblioteconomia)), que lhe dá uma localização exata de um livro, numa prateleira de uma biblioteca específica.

Há um pouco de jargão em torno de URIs. As pessoas falam sobre se são ou não [desreferenciáveis](https://pt.wikipedia.org/wiki/Refer%C3%AAncia_(ci%C3%AAncia_da_computa%C3%A7%C3%A3o)). Isso apenas significa *podemos transformar uma referência abstrata em algo diferente?* Por exemplo, se colar um URI na barra de endereços de um browser, será que ele encontra algo? O VIAF URI para o historiador Simon Schama é:

    http://viaf.org/viaf/46784579

Se colocar isso no browser, receberá de volta uma página web sobre Simon Schama que contém dados estruturados sobre ele e a sua história editorial. Isto é muito útil por um motivo. A partir da URI não é óbvio quem ou mesmo o que é que está a ser referido. Da mesma forma, se tratarmos um número de telemóvel (com código internacional) como o URI de uma pessoa, então deve ser desreferenciável. Alguém pode atender o telefone, e pode até ser Schama.

Mas isto não é essencial. Muitas URIs não são desreferenciáveis, como no exemplo acima do projeto Tobias. Não se pode encontrá-lo em lado nenhum; é uma convenção.

O exemplo VIAF leva-nos a outra coisa importante sobre os URIs: não os invente a não ser que tenha de o fazer. As pessoas e organizações têm feito esforços para construir boas listas URI e o LOD não vai funcionar eficazmente se as pessoas duplicarem esse trabalho criando novas URIs desnecessariamente. Por exemplo, a VIAF tem o apoio de muitas bibliotecas internacionais. Se quiser construir URIs para pessoas, VIAF é uma escolha muito boa. Se não conseguir encontrar algumas pessoas na VIAF, ou noutras listas de autoridade, só então poderá precisar de fazer a sua própria.

## Como é que o LOD organiza o conhecimento: Ontologias

Pode não ter sido óbvio a partir dos triplos individuais que analisámos na secção anterior, mas o LOD pode responder a perguntas complexas. Quando se juntam os triplos, estes formam um [gráfico](https://en.wikipedia.org/wiki/Conceptual_graph) (em inglês), devido à forma como os triplos se interligam. Suponhamos que queremos encontrar uma lista de todas as pessoas que foram alunos do compositor Franz Liszt. Se a informação estiver em triplos de dados interligados sobre pianistas e os seus professores, podemos descobrir o que procuramos com uma consulta (veremos esta linguagem de consulta, chamada SPARQL, na secção final).

Por exemplo, o pianista Charles Rosen foi aluno do pianista Moriz Rosenthal, que foi aluno de Franz Liszt. Vamos agora expressar isso em dois triplos (vamos cingir-nos às sequências de caracteres para os nomes em vez dos números de identificação, para tornar os exemplos mais legíveis):

    "Franz Liszt" ensinouPianoAo "Moriz Rosenthal" .
    "Moriz Rosenthal" ensinouPianoAo "Charles Rosen" .

Poderíamos igualmente ter criado os nossos triplos desta forma:

    "Charles Rosen" aprendeuPianoCom "Moriz Rosenthal" .
    "Moriz Rosenthal" aprendeuPianoCom "Franz Liszt" .

Estamos a inventar exemplos simplesmente para fins de ilustração, mas se quiser ligar os seus dados a outros conjuntos de dados na "nuvem de Linked Data" deve olhar para as convenções que são utilizadas nesses conjuntos de dados e fazer o mesmo. Na verdade, esta é uma das características mais úteis de LOD porque muito do trabalho já foi feito. As pessoas têm passado muito tempo a desenvolver formas de modelar a informação dentro de uma determinada área de estudo e a pensar como as relações dentro dessa área podem ser representadas. Estes modelos são geralmente conhecidos como ontologias. Uma ontologia é uma abstração que permite a representação de um conhecimento particular sobre o mundo. As ontologias, neste sentido, são bastante novas e foram concebidas para fazer o que uma [taxonomia](https://en.wikipedia.org/wiki/Taxonomy) (em inglês) hierárquica faz (pense na classificação das espécies no [sistema Linnaean](https://en.wikipedia.org/wiki/Linnaean_taxonomy) (em inglês)), mas de uma forma mais flexível.

Uma ontologia é mais flexível porque não é hierárquica. Visa representar a fluidez do mundo real, onde as coisas podem ser relacionadas umas com as outras de formas mais complexas do que quando são representadas por uma estrutura hierárquica em forma de árvore. Em vez disso, uma ontologia é mais parecida com uma teia de aranha.

O que quer que pretenda representar com LOD, sugerimos que encontre um vocabulário existente e o utilize, em vez de tentar escrever o seu próprio vocabulário. Esta página tem [uma lista de alguns dos vocabulários mais populares](http://semanticweb.org/wiki/Main_Page.html) (em inglês).

Uma vez que o nosso exemplo acima se concentra nos pianistas, seria uma boa ideia encontrar uma ontologia apropriada em vez de criar o nosso próprio sistema. De facto, existe [uma ontologia para música](http://web.archive.org/web/20170715094229/http://www.musicontology.com/) (em inglês). Para além de uma especificação bem desenvolvida, tem também alguns exemplos úteis da sua utilização. Pode dar uma vista de olhos nas [páginas de iniciação](http://web.archive.org/web/20170718143925/http://musicontology.com/docs/getting-started.html) (em inglês) para ter uma ideia de como se pode utilizar essa ontologia em particular.

Infelizmente, não conseguimos encontrar nada que descreva a relação entre um professor e um aluno na Ontologia da Música. Mas a ontologia é publicada abertamente, pelo que podemos utilizá-la para descrever outras características da música e, depois, criar a nossa própria extensão. Se então publicássemos a nossa extensão abertamente, outros poderiam utilizá-la se assim o desejassem e este ato pode tornar-se um padrão. Embora o projeto *Music Ontology* (Ontologia Musical) não tenha a relação que precisamos, o [projeto *Linked Jazz*](https://linkedjazz.org/) (em inglês) permite o uso de '*mentorOf*', o que parece funcionar bem no nosso caso. Embora esta não seja uma solução ideal, é uma solução que faz um esforço para utilizar o que já existe por aí.

Agora, se estivéssemos a estudar a história do pianismo, poderíamos querer identificar muitos pianistas que foram ensinados por alunos de Liszt, para estabelecer uma espécie de árvore genealógica e ver se estes 'netos' de Liszt têm algo em comum. Poderíamos pesquisar os alunos de Liszt, fazer uma grande lista deles, depois pesquisar cada um dos alunos e tentar fazer listas de quaisquer alunos que eles tivessem. Com LOD poderia (novamente, se os triplos existissem) escrever uma pergunta segundo as linhas de:

    Dá-me os nomes de todos os pianistas ensinados por x
	         onde x aprendeu piano com Liszt

Isto encontraria todas as pessoas do dataset que eram alunos de alunos de Liszt. Não nos entusiasmemos demasiado: esta pergunta não nos dará todos os alunos de todos os alunos de Liszt que viveram, porque essa informação provavelmente não existe e não existe dentro de nenhum conjunto de triplos existentes. Lidar com dados do mundo real mostra todo o tipo de omissões e inconsistências, que veremos quando olharmos para o maior conjunto de LOD, [DBpedia](https://pt.wikipedia.org/wiki/Estrutura_de_dados), na secção final.

Se tiver utilizado [bases de dados relacionais](https://pt.wikipedia.org/wiki/Banco_de_dados_relacional) poderá estar a pensar que podem desempenhar a mesma função. No nosso caso, Liszt, a informação sobre pianistas acima descrita pode estar organizada numa base de dados [tabela](https://pt.wikipedia.org/wiki/Tabela_(banco_de_dados)) denominada por algo como 'Pupilos'.

| IDpupilo | IDprofessor |
| ------- | --------- |
| 31      | 17        |
| 35      | 17        |
| 49      | 28        |
| 56      | 28        |
| 72      | 40        |

Se não estiver familiarizado com bases de dados, não se preocupe. Mas provavelmente ainda pode ver que alguns pianistas nesta tabela tinham o mesmo professor (números 17 e 28). Sem entrar em pormenores, se Liszt estiver nesta tabela de bases de dados, seria bastante fácil extrair os alunos de Liszt, ao utilizar um [*join*](https://pt.wikipedia.org/wiki/Join_(SQL)).

De facto, as bases de dados relacionais podem oferecer resultados semelhantes ao LOD. A grande diferença é que o LOD pode ir mais longe: pode ligar conjuntos de dados que foram criados sem intenção explícita de os ligar entre si. A utilização de [*Resource Description Framework*](https://pt.wikipedia.org/wiki/Resource_Description_Framework) (RDF) (Quadro de Descrição de Recursos) e URIs permite que isto aconteça.

## RDF e formatos de dados

LOD utiliza uma norma, definida pelo [*World Wide Web Consortium*](https://www.w3.org/) (em inglês) (Consórcio World Wide Web), ou W3C, chamada *[Resource Description Framework](https://pt.wikipedia.org/wiki/Resource_Description_Framework)*, ou apenas RDF. As normas são úteis desde que sejam amplamente adotadas - pense no metro ou nos tamanhos de parafuso padrão - mesmo que sejam essencialmente arbitrárias. O RDF tem sido amplamente adotado como a norma LOD.

Ouvirá frequentemente o LOD referido simplesmente como RDF. Atrasámos a conversa sobre o RDF até agora porque é bastante abstrato. RDF é um [modelo de dados](https://en.wikipedia.org/wiki/Data_model) (em inglês) que descreve como é que os dados são estruturados a um nível teórico. Assim, a insistência na utilização de triplos (em vez de quatro partes, ou duas ou nove, por exemplo) é uma regra no RDF. Mas quando se trata de questões mais práticas, há algumas escolhas quanto à implementação. Assim, o RDF diz-lhe o que tem de fazer mas não exatamente como tem de o fazer. Estas escolhas dividem-se em duas áreas: como se escrevem as coisas (serialização) e as relações que os seus triplos descrevem.

### Serialização

A [Serialização](https://pt.wikipedia.org/wiki/Serializa%C3%A7%C3%A3o) é o termo técnico para "como se escrevem as coisas". O chinês padrão (mandarim) pode ser escrito em caracteres tradicionais, caracteres simplificados ou romanização Pinyin e a língua em si não muda. Tal como o mandarim, o RDF pode ser escrito de várias formas. Aqui vamos olhar para duas (há outras, mas por uma questão de simplicidade, vamos concentrar-nos nestas):

1) [Turtle](https://en.wikipedia.org/wiki/Turtle_(syntax)) (em inglês)
2) [RDF/XML](https://pt.wikipedia.org/wiki/RDF/XML)

Reconhecer a serialização que está a utilizar significa que pode então escolher ferramentas apropriadas concebidas para esse formato. Por exemplo, o RDF pode vir serializado no formato [XML](https://pt.wikipedia.org/wiki/XML). Pode, então, utilizar uma ferramenta ou biblioteca de códigos concebida para analisar esse formato em particular, o que é útil se já souber como trabalhar com ele. O reconhecimento do formato também lhe dá as palavras-chave certas para procurar ajuda online. Muitos recursos oferecem as suas bases de dados LOD para descarregar e poderá escolher qual a serialização que deseja descarregar.

#### Turtle

'Turtle' é um jogo de palavras. 'Tur' é a abreviatura de 'terse' e 'tle' - é a abreviatura de '*triple language*' (linguagem tripla). Tartaruga é uma forma agradavelmente simples de escrever triplos.

O Turtle usa pseudónimos ou atalhos conhecidos como [prefixos](https://www.w3.org/TeamSubmission/turtle/#sec-tutorial) (em inglês), o que nos poupa ter de escrever URIs completas de cada vez. Voltemos ao URI que inventámos na secção anterior:

    http://data.history.ac.uk/tobias-project/person/15601

Não queremos escrever isto cada vez que nos referimos a esta pessoa (lembrar-se-á de Jack Straw). Por isso, só temos de anunciar o nosso atalho:

    @prefix toby: <http://data.history.ac.uk/tobias-project/person> .

Então Jack é `toby:15601`, que substitui o longo URI e é mais fácil à vista. Eu escolhi 'toby', mas poderia igualmente escolher qualquer sequência de letras.

Vamos agora passar de Jack Straw para William Shakespeare e utilizar Turtle para descrever algumas coisas sobre as suas obras. Vamos ter de decidir sobre os ficheiros de autoridade a utilizar, um processo que, como mencionado acima, é melhor ser realizado ao olhar para outros conjuntos de LOD. Aqui usaremos como um dos nossos prefixos [*Dublin Core*](https://pt.wikipedia.org/wiki/Dublin_Core), um padrão de [metadados](https://pt.wikipedia.org/wiki/Metadados) de bibliotecas, [*Library of Congress Control Number*](https://en.wikipedia.org/wiki/Library_of_Congress_Control_Number) (Número de controlo da Biblioteca do Congresso) para outro e, o último, (VIAF) deverá ser-lhe familiar. Juntos, estes três ficheiros de autoridade fornecem identificadores únicos para todas as entidades que tenciono utilizar neste exemplo:

    @prefix lccn: <http://id.loc.gov/authorities/names> .
    @prefix dc: <http://purl.org/dc/elements/1.1/> .
    @prefix viaf: <http://viaf.org/viaf> .

    lccn:n82011242 dc:creator viaf:96994048 .

Note o espaçamento do ponto final após a última linha. Esta é a forma de Turtle indicar o fim. Tecnicamente, não é necessário ter o espaço, mas facilita a leitura após uma longa sequência de caracteres.

No exemplo acima, lccn:n82011242 representa Macbeth; dc:creator liga Macbeth ao seu autor; viaf:96994048 representa William Shakespeare.

O Turtle também permite listar triplos sem se preocupar em repetir cada URI quando acabou de o usar. Acrescentemos a data em que os estudiosos pensam que Macbeth foi escrito, utilizando o par de valores do atributo Dublin Core: `dc:create 'YYYY'`:

    @prefix lccn: <http://id.loc.gov/authorities/names> .
    @prefix dc: <http://purl.org/dc/elements/1.1/> .
    @prefix viaf: <http://viaf.org/viaf> .

    lccn:n82011242 dc:creator viaf:96994048 ;
               dc:created "1606" .

Lembra-se da estrutura do triplo, discutida na secção 1? Aí demos este exemplo:

	1 pessoa 15601 (o assunto) 2 representadaNoParlamentoBritânico (o predicado) 3 "Blackburn" (o objeto)

O essencial é que o predicado liga o sujeito e o objeto. Ele descreve a relação entre eles. O assunto vem primeiro no triplo, mas isso é uma questão de escolha, como discutimos com o exemplo de pessoas que foram ensinadas a tocar piano por Liszt.

Pode-se usar um ponto e vírgula se o sujeito for o mesmo mas o predicado e o objeto forem diferentes, ou uma vírgula se o sujeito e o predicado forem o mesmo e apenas o objeto for diferente.

    lccn:no2010025398 dc:creator viaf:96994048 ,
                    viaf:12323361 .

Aqui estamos a dizer que Shakespeare (96994048) e John Fletcher (12323361) foram ambos os criadores da obra *The Two Noble Kinsmen*.

Quando analisámos as ontologias anteriormente mencionadas sugeri que analisasse a [*the Music Ontology*](http://web.archive.org/web/20170718143925/http://musicontology.com/docs/getting-started.html) (em inglês). Dê agora uma vista de olhos novamente. Isto ainda é complicado, mas será que agora faz mais sentido?

Uma das ontologias mais acessíveis é a '*Friend of a Friend*' (amigo de um amigo) ou [FOAF](https://en.wikipedia.org/wiki/FOAF_(ontology)). Esta é concebida para descrever pessoas e, talvez por essa razão, é bastante intuitiva. Se, por exemplo, quiser escrever-me para me dizer que este curso é a melhor coisa que já leu, aqui está o meu endereço de correio eletrónico expresso como triplos em FOAF:

    @prefix foaf: <http://xmlns.com/foaf/0.1/> .

    :"Jonathan Blaney" foaf:mbox <mailto:jonathan.blaney@sas.ac.uk> .

#### RDF/XML

Em contraste com o Turtle, o RDF/XML pode parecer um pouco pesado. Para começar, vamos apenas converter um triplo da Turtle acima, aquele que diz que Shakespeare foi o criador de *The Two Noble Kinsmen*:

    lccn:no2010025398 dc:creator viaf:96994048 .

Em RDF/XML, com os prefixos declarados dentro do bocadinho de XML, isto é:

``` xml
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:dc="http://purl.org/dc/terms/">
  <rdf:Description rdf:about="http://id.loc.gov/authorities/names/no2010025398">
    <dc:creator rdf:resource="http://viaf.org/viaf/96994048"/>
  </rdf:Description>
</rdf:RDF>
```

O formato RDF/XML tem a mesma informação básica que o formato Turtle, mas é escrito de forma muito diferente, baseando-se nos princípios das etiquetas XML aninhadas.

Passemos a um exemplo diferente para mostrar como o RDF/XML combina triplos e, ao mesmo tempo, introduz o [*Simple Knowledge Organization System*](https://pt.wikipedia.org/wiki/Simple_Knowledge_Organization_System) (SKOS) (Sistema Simples de Organização do Conhecimento), que foi concebido para codificar *thesauri* ou taxonomias.

     <skosConcept rdf:about="http://www.ihr-tobias.org/concepts/21250/Abdication">
        <skos:prefLabel>Abdication</skos:prefLabel>
      </skosConcept>

Aqui estamos a dizer que o conceito SKOS `21250`, abdication, tem um rótulo preferido de "*abdication*". A forma como funciona é que o elemento sujeito (incluindo a parte da '*abdication*', que é um valor atributo em termos de XML) tem o predicado e o objeto aninhado no seu interior. O elemento aninhado é o predicado e [o nó de folha](https://en.wikipedia.org/wiki/Tree_(data_structure)#Terminologia) (em inglês), é o objeto. Este exemplo é retirado de um projeto para publicar um [*thesaurus of British and Irish History*](http://www.history.ac.uk/projects/digital/tobias) (Tesaurua de História Britânica e Irlandesa) (em inglês).

Tal como com o Turtle, podemos acrescentar mais triplos.  Portanto, vamos declarar que o termo mais restrito na nossa hierarquia de assuntos, um abaixo de *Abdication*, vai ser *Abdication crisis (1936)*.

     <skosConcept rdf:about="http://www.ihr-tobias.org/concepts/21250/abdication">
        <skos:prefLabel>Abdication</skos:prefLabel>
      </skosConcept>

     <skosConcept rdf:about="http://www.ihr-tobias.org/concepts/21250/abdication">
        <skos:narrower rdf:resource="http://www.ihr-tobias.org/concepts/19838/abdication_crisis_1936"/>
      </skosConcept>

Lembra-se de como os predicados e os objetos são aninhados dentro do sujeito? Aqui já o fizemos duas vezes com o mesmo assunto, para que possamos tornar isto menos verboso, aninhando tanto conjuntos de predicados como objetos dentro do mesmo assunto:

     <skosConcept rdf:about="http://www.ihr-tobias.org/concepts/21250/abdication">
        <skos:prefLabel>Abdication</skos:prefLabel>
        <skos:narrower rdf:resource="http://www.ihr-tobias.org/concepts/19838/abdication_crisis_1936"/>
		</skosConcept>

Se estiver familiarizado com XML isto será fácil para si. Se não estiver, talvez prefira um formato como o Turtle. Mas a vantagem aqui é que ao criar o seu RDF/XML pode usar as ferramentas habituais disponíveis com XML, como editores e analisadores dedicados ao XML, para verificar se o seu RDF/XML está corretamente formatado. Se não for uma pessoa que use o XML recomendo o Turtle, podendo usar uma [ferramenta online](http://www.easyrdf.org/converter) (em inglês) para verificar se a sua sintaxe está correta.

## Consulta de RDF com SPARQL

Para esta secção final iremos interrogar algum LOD e ver o que poderá ser feito com ele.

A linguagem de consulta que usamos para LOD é chamada [SPARQL](https://pt.wikipedia.org/wiki/SPARQL). É uma daquelas siglas recursivas amadas pelos técnicos: *Protocolo SPARQL e Linguagem de Consulta*.

Como mencionado no início, o *Programming Historian* tem [uma lição completa](/lessons/graph-databases-and-SPARQL) (em inglês), de Matthew Lincoln, sobre a utilização do SPARQL. A secção final aqui presente é apenas uma visão geral dos conceitos básicos. Se o SPARQL despertar o seu interesse, pode obter uma fundamentação completa no tutorial de Lincoln.

Vamos realizar as nossas consultas SPARQL em [DBpedia](https://pt.wikipedia.org/wiki/SPARQL), que é um enorme conjunto de LOD derivado da Wikipedia. Além de estar cheio de informação que é muito difícil de encontrar através da habitual interface da Wikipédia, tem vários "pontos finais" SPARQL - interfaces onde se podem digitar as consultas SPARQL e obter resultados a partir dos triplos da DBpedia.

O ponto final de consulta SPARQL que é utilizado chama-se [snorql](http://dbpedia.org/snorql/) (em inglês). Estes pontos finais, ocasionalmente, parecem ficar offline. Por isso, se for este o seu caso, tente procurar por *dbpedia sparql* e deverá encontrar um substituto semelhante.

Se for ao URL snorql acima verá, no início, um número de prefixos que já foram declarados para nós, o que é útil. Agora também irá reconhecer alguns dos prefixos.

{% include figure.html filename="intro-to-linked-data-fig1.png" caption="Caixa de consulta padrão do snorql, com alguns prefixos declarados para si" %}

Na caixa de consulta abaixo das declarações de prefixo, deverá ver o seguinte:

    SELECT * WHERE {
    ...
    }

Se alguma vez escreveu uma consulta de bases de dados em *Structured Query Language*, [mais conhecida como SQL](https://pt.wikipedia.org/wiki/SQL), isto vai parecer-lhe bastante familiar e vai ajudá-lo a aprender SPARQL. Se não, não se preocupe. As palavras-chave aqui utilizadas, *SELECT* (SELECIONAR) e *WHERE* (ONDE) não são sensíveis a maiúsculas e minúsculas, mas algumas partes de uma consulta SPARQL podem ser (ver abaixo), por isso recomendo que se cinja ao caso dado ao longo das consultas neste curso.

Aqui `SELECT` significa "encontrar alguma coisa" e `*` significa "dá-me tudo". `WHERE` introduz uma condição, que é onde vamos colocar os detalhes de que tipo de coisas queremos que a consulta encontre.

Vamos começar com algo simples para ver como é que isto funciona. Cole (ou, melhor, escreva) isto na caixa de consulta:

    SELECT * WHERE {
    :Lyndal_Roper ?b ?c
    }

Carregue em '*go*' (ir). Se deixar a caixa pendente como '*browse*' (navegar) deverá obter duas colunas com os rótulos "b" e "c". (Note que aqui, ao procurar uma cadeia de caracteres, as maiúsculas/minúsculas importam: lyndal_roper não lhe dará resultados).


{% include figure.html filename="intro-to-linked-data-fig2.png" caption="Topo das listas de resultados de uma consulta com todos os triplos com 'Lyndal_Roper' como assunto" %}

Então o que é que acabou de acontecer? E como é que soubemos o que escrever?

Na verdade, não sabíamos. Esse é um dos problemas com os pontos finais do SPARQL. Quando se conhece um conjunto de dados, é preciso experimentar coisas e descobrir que termos são utilizados. Porque isto vem da *Wikipedia* e nós estávamos interessados sobre que informação sobre historiadores podíamos encontrar. Então vamos à página da *Wikipedia* da historiadora [Lyndal Roper](https://en.wikipedia.org/wiki/Lyndal_Roper) (em inglês).

A parte final do URL é `Lyndal_Roper` e concluímos então que é provável que esta cadeia de caracteres seja a forma como Roper é referida na DBpedia. Porque não sabemos o que mais poderia estar em triplos que mencionam Roper, nós utilizamos `?a` e `?b`: estes são apenas suportes de lugar. Poderia, igualmente, ter datilografado `?whatever` e `?you_like` e as colunas teriam esses cabeçalhos. Quando quiser ser mais preciso sobre o que se está a pesquisar, será importante etiquetar as colunas de forma significativa.

Experimente agora a sua própria consulta SPARQL: escolha uma página *Wikipedia* e copie a parte final do URL, após a barra final, e coloque-a no lugar de Lyndal_Roper. Depois clique em 'go'.

A partir da informação que se obtém destes resultados é possível gerar consultas mais precisas. Isto pode ser pouco fiável, por isso não se preocupe se alguns não funcionarem.

Vamos voltar aos resultados para a consulta que fizemos há momentos:

    SELECT * WHERE {
    :Lyndal_Roper ?b ?c
    }

Podemos ver uma longa lista na coluna etiquetada _c_. Estes são todos os atributos que Roper tem na *DBpedia* e que nos ajudarão a encontrar outras pessoas com estes atributos. Por exemplo, podemos ver ```http://dbpedia.org/class/yago/Historian110177150```. Poderemos utilizar isto para obter uma lista de historiadores? Vamos colocá-lo na nossa pergunta mas, em terceiro lugar, porque era onde estava quando a encontrei nos resultados da Lyndal Roper. A minha consulta tem este aspecto:

	SELECT * WHERE {
	?historian_name ?predicate <http://dbpedia.org/class/yago/Historian110177150>
	}

Fizemos uma pequena mudança aqui. Se esta consulta funcionar de todo, então esperemos que os nossos historiadores estejam na primeira coluna, porque 'historiador' não parece poder ser um predicado: não funciona como um verbo numa frase; por isso vamos chamar à primeira coluna de resultados 'historian_name' e à segunda (sobre a qual não sabemos nada) 'predicate' (predicado).

Execute a consulta. Deverá encontrar uma grande lista de historiadores.

{% include figure.html filename="intro-to-linked-data-fig3.png" caption="Historiadores de acordo com a DBpedia" %}

Assim, esta ferramenta funciona para criar listas, o que é útil, mas seria muito mais poderoso combinar listas, para obter intersecções de conjuntos. Encontrei mais algumas coisas que podem ser interessantes consultar nos atributos DBpedia de Lyndal Roper: <http://dbpedia.org/class/yago/WikicatBritishHistorians> e <http://dbpedia.org/class/yago/WikicatWomenHistorians>. É muito fácil combiná-los pedindo uma variável a ser devolvida (no nosso caso isto é `?name` (nome)) e, depois, utilizando-a em múltiplas linhas de uma consulta. Note também o espaço e o ponto completo no final da primeira linha que começa com `?name`:

	SELECT ?name
	WHERE {
	?name ?b <http://dbpedia.org/class/yago/WikicatBritishHistorians> .
	?name ?b <http://dbpedia.org/class/yago/WikicatWomenHistorians>
	}

Funciona! Devemos obter cinco resultados. Na altura em que escrevo, há cinco historiadoras britânicas na *DBpedia*...

{% include figure.html filename="intro-to-linked-data-fig4.png" caption="Historiadoras britânicas segundo a DBpedia" %}

Apenas cinco historiadoras britânicas? Claro que há, na realidade, muitas mais do que isso, como poderíamos facilmente mostrar substituindo o nome de, digamos, Alison Weir na nossa primeira consulta sobre Lyndal Roper. Isto leva-nos ao problema com a *Dbpedia* que mencionamos anteriormente: não é muito consistentemente marcado com informação estrutural do tipo *DBpedia* que utiliza. A nossa consulta pode listar algumas historiadoras britânicas, mas acontece que não podemos utilizá-la para gerar uma lista significativa de pessoas nesta categoria. Tudo o que encontrámos foram as pessoas nas entradas da *Wikipedia* que alguém decidiu classificar como "historiadora britânica" e "historiadora".

Com SPARQL na *DBpedia*, é preciso ter cuidado com as inconsistências do material proveniente de "multidões". Poderá usar o SPARQL exatamente da mesma forma num dataset mais protegido. Por exemplo, nos dados do governo britânico: https://data-gov.tw.rpi.edu//sparql (em inglês), esperando obter resultados mais robustos (há aqui um breve tutorial para este conjunto de dados: https://data-gov.tw.rpi.edu/wiki/A\_crash\_course\_in_SPARQL (em inglês)).

No entanto, apesar das suas inconsistências, *DBpedia* é um ótimo local para aprender SPARQL. Esta tem sido apenas uma breve introdução, mas há muito mais em [Usando SPARQL para aceder a Linked Open Data](/lessons/graph-databases-and-SPARQL) (em inglês).

## Leituras e recursos adicionais

* Dean Allemang e James Hendler, *Semantic Web for the Working Ontologist*, 2nd edn, Elsevier, 2011
* Tim Berners-Lee [*Linked Data*](https://www.w3.org/DesignIssues/LinkedData.html) (em inglês)
* Bob DuCharme, *Learning SPARQL*, O'Reilly, 2011
* [Blog de Bob DuCharme](http://www.snee.com/bobdc.blog/) (em inglês) também vale a pena ler
* Richard Gartner, *Metadata: Shaping Knowledge from Antiquity to the Semantic Web*, Springer, 2016
* Seth van Hooland and Ruben Verborgh, *Linked Data for Libraries, Archives and Museums*, 2015
* Ver também [*companion website*](http://freeyourmetadata.org/) (em inglês)
* Matthew Lincoln ['*Using SPARQL to access Linked Open Data*'](/lessons/graph-databases-and-SPARQL) (em inglês)
* [*Linked Data guides and tutorials*](http://linkeddata.org/guides-and-tutorials) (em inglês)
* Dominic Oldman, Martin Doerr e Stefan Gradmann, '*Zen and the Art of Linked Data: New Strategies for a Semantic Web of Humanist Knowledge*', em *A New Companion to Digital Humanities*, editado por Susan Schreibman et al.
* Max Schmachtenberg, Christian Bizer e Heiko Paulheim, [*State of the LOD Cloud 2017*](http://linkeddatacatalog.dws.informatik.uni-mannheim.de/state/) (em inglês)
* David Wood, Marsha Zaidman e Luke Ruth, *Linked Data: Structured data on the Web*, Manning, 2014

## Agradecimentos

Gostaria de agradecer aos meus dois colegas revisores, Matthew Lincoln e Terhi Nurmikko-Fuller e ao meu editor, Adam Crymble, por me ajudarem generosamente a melhorar esta lição com numerosas sugestões, esclarecimentos e correções. Este tutorial baseia-se num outro escrito como parte do '*Thesaurus of British and Irish History as SKOS*' [*(Tobias) project*](http://www.history.ac.uk/projects/digital/tobias) (em inglês), financiado pelo [AHRC](http://www.ahrc.ac.uk/) (em inglês). A lição foi revista para o projeto *Programming Historian*.
