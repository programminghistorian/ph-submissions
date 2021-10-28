---
title: "Da Hermenêutica aos Dados e às Redes: Extração de Dados e Visualização em Rede de Fontes Históricas"
layout: lesson
date: 2015-02-18
translation_date: 2021-10-15
authors:
- Marten Düring
reviewers:
- Ryan Cordell
- Justin Larsen
editors:
- Fred Gibbs
translator:
- Marcia Cavalcanti
translation-editor:
- Joana Vieira Paulino
translation-reviewer:
- 
- 
difficulty: 2
exclude_from_check:
review-ticket:
activity: transforming
topics: [network-analysis]
abstract: "As visualizações de rede podem ajudar os estudiosos das ciências humanas a revelar padrões e estruturas ocultas e complexas em fontes textuais. Este tutorial explica como extrair dados de rede (pessoas, instituições, lugares, etc) de fontes históricas por meio do uso de métodos não técnicos desenvolvidos em Análise de Dados Qualitativos (QDA) e Análise de Redes Sociais (SNA), e como visualizar esses dados com o Palladio, independente de plataforma e, particularmente, fácil de usar."
redirect_from: /lessons/creating-network-diagrams-from-historical-sources
avatar_alt: Diagrama da revolução da terra e da lua à volta do sol
doi: A INDICAR
---

{% include toc.html %}





Introdução
------------

As visualizações de rede podem ajudar os estudiosos das ciências humanas a revelar padrões e estruturas ocultas e complexas em fontes textuais. Este tutorial explica como extrair dados de rede (pessoas, instituições, lugares, etc.) de fontes históricas por meio do uso de métodos não técnicos desenvolvidos em Análise de Dados Qualitativos (QDA) e Análise de Redes Sociais (SNA), e como visualizar esses dados com o [*Palladio*](http://hdlab.stanford.edu/palladio/) independente de plataforma e, particularmente, fácil de usar.


{% include figure.html caption="Figura 1: Uma visualização de rede no Palladio e o que você poderá criar ao final deste tutorial" filename="image09.png" %}


O gráfico acima mostra um trecho da rede de Ralph Neumann, particularmente suas conexões com pessoas que ajudaram ele e sua irmã durante o período como clandestinos em Berlim, entre 1943-1945. Você poderia facilmente modificar o gráfico e perguntar: Quem ajudou de que maneira? Quem ajudou quando? Quem está conectado a quem?

Geralmente, a análise de rede fornece as ferramentas para explorar constelações altamente complexas de relações entre entidades. Pense em seus amigos: para você é fácil mapear quais são próximos e quais não se dão bem. Agora imagine que você teve que explicar esses vários relacionamentos para alguém que não conhece nenhum de seus amigos, ou que você quis incluir no relacionamento os amigos dos seus amigos. Em situações como essa, a linguagem e nossa capacidade de compreender as estruturas sociais atingem rapidamente seus limites. As visualizações de gráfico podem ser meios para comunicar e explorar efetivamente essas relações complexas. Geralmente, você pode pensar na Análise de Redes Sociais como um meio de transformar a complexidade de um problema em um objeto de pesquisa. Frequentemente, os nós em uma rede representam humanos conectados a outros humanos por todos os tipos imagináveis de relações sociais. Mas quase tudo pode ser entendido como nós/vértices: um filme, um lugar, um cargo, um ponto no tempo, um local. Da mesma forma, o conceito de laços/arestas entre os nós é muito flexível: dois cinemas podem ser conectados por um filme exibido em ambos, ou por copropriedade, proximidade geográfica ou estar no mesmo ano. Tudo isso depende de seus interesses de pesquisa e de como você os expressa na forma de nós/vértices e relações em uma rede.

Este tutorial não pode substituir nenhum dos muitos manuais mais genéricos de análise de rede existentes, como [*Análise de Rede Social de John Scott*](https://uk.sagepub.com/en-gb/eur/the-sage-handbook-of-social-network-analysis/book232753). Para uma ótima introdução geral ao campo e todas as suas armadilhas para os humanistas, eu recomendo [a série de postagens do blog de Scott Weingart “Networks Demystified”](http://www.scottbot.net/HIAL/?p=6279) (em inglês), bem como [o artigo de Claire Lemercier “Formal network methods in history: why and how?”](https://hal.archives-ouvertes.fr/docs/00/64/93/16/PDF/lemercier_A_zg.pdf) (em inglês). Você também pode explorar a bibliografia e o calendário de eventos em [Historical Network Research](http://historicalnetworkresearch.org/) (em inglês) para ter uma ideia de como os historiadores fizeram uso das redes em suas pesquisas. 

Este tutorial se concentrará na extração de dados em textos não estruturados e mostra uma maneira de visualizá-los usando o Palladio. É propositalmente projetado para ser o mais simples e robusto possível. Para o escopo limitado deste tutorial, será suficiente dizer que um ator se refere às pessoas, instituições, etc. que são o objeto de estudo e que estão conectadas por relações, e no contexto de uma visualização ou computação de rede (também chamada de gráfico) serão chamamos de nós/vértices, e chamamos as conexões de laços/arestas. Em todos os casos, é importante lembrar que nós e laços são modelos drasticamente simplificados usados para representar as complexidades de eventos passados e, por si só, nem sempre são suficientes para gerar *insights*. Mas é provável que o gráfico destaque aspectos interessantes, desafie suas hipóteses e/ou o leve a gerar novas. *Os diagramas de rede tornam-se significativos quando fazem parte de um diálogo com dados e outras fontes de informação.* 

Muitos projetos de análise de redes nas ciências sociais dependem de fontes de dados pré-existentes ou de dados que foram criados para este fim. Os exemplos incluem registros de e-mail, questionários ou relações comerciais que tornam relativamente fácil identificar quem está conectado a quem e como. É consideravelmente mais difícil extrair dados de rede de texto não estruturado. Isso nos força a casar de alguma forma as complexidades da hermenêutica com o rigor da análise formal de dados. O termo “amigo” pode servir de exemplo: dependendo do contexto, pode significar desde um insulto a uma expressão de amor. O conhecimento do contexto e a análise do texto o ajudarão a identificar o que ele representa em qualquer caso. Um sistema formal de categorias deve representar os diferentes significados, com os detalhes necessários para seus objetivos.

Em outras palavras, o desafio é sistematizar a interpretação do texto. As redes criadas a partir de conjuntos de dados pré-existentes precisam ser consideradas dentro do contexto em que foram criadas (por exemplo, formulação de perguntas em um questionário e grupos-alvo selecionados). Redes criadas a partir de texto não estruturado apresentam desafios além disso: as interpretações são altamente individuais e dependem de pontos de vista e conhecimento do contexto.


Sobre o estudo de caso
--------------------

O estudo de caso usado neste tutorial é uma narrativa em primeira pessoa de Ralph Neumann, um sobrevivente judeu do Holocausto. Você pode encontrar o texto [*online*](https://web.archive.org/web/20180422010025/http:/www.gdw-berlin.de/fileadmin/bilder/publ/publikationen_in_englischer_sprache/2006_Neuman_eng.pdf). O esquema de codificação que apresentarei a seguir é uma versão simplificada do que desenvolvi durante [*meu projeto de doutorado em redes de apoio secreto durante a Segunda Guerra Mundial*](http://martenduering.com/research/covert-networks-during-the-holocaust/). Minha pesquisa foi orientada por três questões: Até que ponto as relações sociais podem ajudar a explicar porque as pessoas comuns assumem os riscos associados à ajuda? Como essas relações permitiam que as pessoas prestassem esses atos de ajuda, visto que apenas recursos muito limitados estavam disponíveis para elas? Como as relações sociais ajudaram os refugiados judeus a sobreviver na clandestinidade?

Neste projeto, as visualizações de rede me ajudaram a descobrir os intermediários desses contatos até então esquecidos, mas altamente importantes; destacar a importância geral dos refugiados judeus como intermediários de contato; e, em geral, navegar por um total de cerca de 5.000 atos de ajuda que conectaram cerca de 1.400 pessoas entre 1942 e 1945.


Desenvolvendo um esquema de codificação
--------------------------

Ao visualizar os relacionamentos da rede, um dos primeiros e mais difíceis desafios é decidir quem deve fazer parte da rede e quais relações entre os atores selecionados devem ser codificadas. Provavelmente levará algum tempo para descobrir isso e provavelmente será um processo iterativo, pois precisará equilibrar seus interesses de pesquisa e hipóteses com a disponibilidade de informações em seus textos e representar ambos em um esquema de codificação rígido e necessariamente simplificador.

As principais questões durante este processo são: Quais aspectos das relações entre dois atores são relevantes? Quem faz parte da rede? Quem não é? Quais atributos importam? O que você pretende encontrar?

Encontrei as seguintes respostas para estas questões:

*O que define uma relação entre dois atores?*

Qualquer ação que tenha contribuído diretamente para a sobrevivência de pessoas perseguidas que estivessem escondidas. Isso incluiu, por exemplo, comunistas não judeus, mas excluiu espectadores que optaram por não denunciar refugiados ou meros conhecidos entre os atores (por falta de cobertura suficiente nas fontes). Os atores foram codificados como provedores ou recebedores de um ato de ajuda, independentemente de sua condição de refugiados. Não existe uma maneira simples e robusta de lidar com ambiguidades e dúvidas no momento, portanto, optei por coletar apenas dados verificáveis.

*Quem faz parte da rede? Quem não é?*

Qualquer pessoa citada como ajudante, envolvida em atividades de ajuda, envolvida em atividades que visem suprimir comportamentos de ajuda. Na verdade, algumas atividades de ajuda acabaram não tendo relação com meus estudos de caso, mas em outros casos essa abordagem revelou conexões cruzadas, até então inesperadas, entre redes.

*Que tipo de relacionamento você observa?*

Categorizações aproximadas de: forma de ajuda, intensidade dos relacionamentos, duração da ajuda, tempo de ajuda, tempo da primeira reunião (ambos codificados em etapas de 6 meses).

*Quais atributos são relevantes?*

Principalmente status racial, de acordo com a legislação nacional-socialista.

*O que pretende encontrar?*

Uma compreensão mais profunda de quem ajuda quem e como, e descoberta de padrões nos dados que correspondam à teoria das redes. Uma interação altamente produtiva entre minhas fontes e os dados visualizados me fez persistir nisso.

Observe que os esquemas de codificação em geral não são capazes de representar toda a complexidade das fontes em todas as suas sutilezas e ambivalência. O objetivo do esquema de codificação é desenvolver um modelo dos relacionamentos nos quais você está interessado. Como tal, os tipos de relações e os atributos são representações abstratas e categorizadas das complexidades transmitidas no(s) texto(s). Isso também significa que, em muitos casos, os dados e visualizações da rede só farão sentido depois de reunidos com seu contexto original, no meu caso, as fontes primárias das quais os extraí.

A tradução da interpretação do texto em coleta de dados tem suas raízes na Análise de Dados Qualitativos sociológicos. É importante que você e outras pessoas possam refazer seus passos e entender como define suas relações. É muito útil defini-las abstratamente e fornecer exemplos de suas fontes para ilustrar melhor suas escolhas. Quaisquer dados que você produz podem ser tão claros e coerentes quanto suas práticas de codificação. A clareza e a coerência aumentam durante o processo iterativo de criação de esquemas de codificação e testando-os em uma variedade de fontes diferentes até que se encaixem.

{% include figure.html caption="Figura 2: Uma primeira tentativa no esquema de codificação" filename="image03.png" %}


A Figura 2 mostra uma captura de tela com dados de amostra do esquema de codificação que usei durante meu projeto. Nesse caso, Alice ajuda Paul. Podemos expressar isso como uma relação entre os atores “Alice” e “Paul” que compartilham uma relação da categoria “Form of Help” (Forma de Ajuda). Dentro desta categoria encontramos a subcategoria “4. Food, Commodities” que descreve melhor a relação deles.

Todas as principais ferramentas de visualização de rede permitem que você especifique se uma rede é direcionada como esta ou não. Nas redes dirigidas, as relações descrevem uma troca de um ator para outro, no nosso caso é “ajuda”. Por convenção, os nós ativos são mencionados primeiro (neste caso, Alice) no conjunto de dados. Em uma visualização de uma rede direcionada você verá setas indo de um ator para outro. As relações também podem ser recíprocas, por exemplo, quando Alice ajuda Bob e Bob ajuda Alice.

Muitas vezes, no entanto, não faz sentido trabalhar com direcionalidade, por exemplo, quando dois atores são simplesmente parte da mesma organização. Nesse caso, a rede não deveria ser direcionada e seria representada por uma linha simples entre os dois atores.

Eu queria saber com que frequência os atores ajudaram e com que frequência receberam ajuda. Eu estava particularmente interessado no grau de autoajuda judaica, e é por isso que uma abordagem de rede direcionada e o papel de “Doador” e “Destinatário” fazem sentido. A terceira coluna no esquema de codificação é opcional e descreve melhor o tipo de relacionamento entre Alice e Paul. Escolhi como categoria “Forma de Ajuda” que reflete as formas mais comuns de prestação de apoio.

As categorias e subcategorias surgiram durante um longo processo de codificação de diferentes tipos de textos e diferentes tipos de redes de apoio. Durante esse processo aprendi, por exemplo, quais formas relevantes de ajuda raramente são descritas e, portanto, não rastreáveis, como o fornecimento de informações relacionadas ao suporte. Espere ter que adaptar seu esquema de codificação frequentemente no início e se preparar para recodificar seus dados algumas vezes até que correspondam consistentemente com suas fontes e interesses.

Tal como está, o esquema de codificação transmite a informação de que Alice forneceu comida ou outras mercadorias para Paul, conforme indicado pelo valor 4 que corresponde à subcategoria “4. Alimentos, Commodities” na categoria “Forma de Ajuda”. As relações humanas são, no entanto, significativamente mais complexas do que isso e caracterizadas por camadas de relações diferentes e em constante mudança. Até certo ponto, podemos representar parte dessa complexidade coletando múltiplos relacionamentos. Considere este exemplo de frase: *“Em setembro de 1944, Paul ficou na casa de sua amiga Alice; eles se conheceram na Páscoa do ano anterior.”*


{% include figure.html caption="Figura 3: uma representação da frase de amostra" filename="image11.png" %}

O esquema de codificação na Figura 3 descreve os relacionamentos entre ajudantes e destinatários de ajuda em mais detalhes. “Relação”, por exemplo, fornece uma categorização aproximada de quão bem dois atores se conheciam; “Duração” captura quanto tempo um ato de ajuda durou; “Data da Atividade” indica quando um ato de ajuda ocorreu; “Data da primeira reunião” deve seja autoexplicativo. O valor “99” aqui especifica “desconhecido”, uma vez que a frase de amostra não descreve a intensidade da relação entre Alice e Paul em maiores detalhes. Observe que este esquema se concentra exclusivamente em coletar atos de ajuda, não em capturar o desenvolvimento de relacionamentos entre as pessoas (que não foram abordados em minhas fontes). Escolhas explícitas como essa definem o valor dos dados durante a análise.

Também é possível coletar informações sobre os atores da rede; os chamados dados de atributo usam praticamente o mesmo formato. A Figura 4 mostra dados de amostra para Alice e Paul.

{% include figure.html caption="Figura 4: amostra de dados de atributos" filename="image06.png" %}


Se lermos as informações agora armazenadas no esquema de codificação, descobrimos que Alice providenciou acomodação para Paulo (“Form of Help” (Forma de Ajuda): 4), que não sabemos quão próximos eles eram (“Relation” (Relação): 99) ou quanto tempo ele ficou (“Duration” (Duração): 99). Sabemos, no entanto, que isto ocorreu algures no segundo semestre de 1944 (“Date of Activity” (Data da Atividade): 14) e que se encontraram pela primeira vez no primeiro semestre de 1943 (“Date of first Meeting” (Data do primeiro Encontro): 11) . A data do primeiro encontro pode ser inferida das palavras *“perto da Páscoa do ano anterior”*. Em caso de dúvida, sempre optei por inserir “99” representando “desconhecido”. 

Mas e se Alice também tivesse ajudado Paul com apoio emocional (outra subcategoria de (“Form of Help” (Forma de Ajuda)) enquanto ele estava com ela? Para reconhecer isso, codifiquei uma linha que descreve fornecer acomodação e uma segunda abaixo que descreve fornecer suporte emocional. Observe que nem todas as ferramentas de visualização de rede permitirão que você represente laços paralelos e ignorará o segundo ato de ajuda que ocorreu ou tentará fundir as duas relações. No entanto, tanto o NodeXL quanto o Palladio podem lidar com isso e há rumores de que uma versão futura do Gephi também o fará. Se você encontrar esse problema e nenhuma das duas ferramentas for uma opção, eu recomendaria configurar um banco de dados relacional e trabalhar com consultas específicas para cada visualização.

O processo de criação de tal esquema de codificação força você a se tornar explícito sobre suas suposições, interesses e os materiais à sua disposição, algo valioso além da análise de dados. Outro efeito colateral de extrair dados de rede do texto é que você conhecerá suas fontes muito bem: Frases que seguem o modelo de "A pessoa A está conectada às pessoas B, C e D por meio do tipo de relação X no momento Y" provavelmente serão raras. Em vez disso, será necessária uma leitura atenta, profundo conhecimento do contexto e interpretação para descobrir quem está conectado a quem de que maneira. Isso significa que codificar os dados dessa forma levantará muitas questões e forçará você a estudar suas fontes de maneira mais profunda e rigorosa do que se as tivesse trabalhado da maneira “tradicional”.


Visualize os dados da rede no Palladio
----------------------------------

Depois de criar um esquema de codificação e codificar suas fontes, estará pronto para visualizar os relacionamentos da rede. Primeiro, certifique-se de que todas as células vazias sejam preenchidas com um número representando um tipo de empate ou com “99” para “desconhecido”. Crie uma nova cópia de seu arquivo (“Save as” (Salvar como)...) e exclua os códigos para as diferentes categorias para que sua planilha se pareça com a Figura 5.

{% include figure.html caption="Figura 5: Dados de atributos de amostra prontos para serem exportados para visualização ou computação" filename="image00.png" %}


Todos os editores de planilhas permitem exportar tabelas como arquivos .csv (valores separados por vírgula) ou .txt. Esses arquivos podem ser importados para todas as ferramentas de visualização de rede comumente usadas (consulte a lista no final do tutorial). Para seus primeiros passos, no entanto, sugiro que experimente Palladio, uma ferramenta de visualização de dados muito fácil de usar e em desenvolvimento ativo pela Universidade de Stanford. Ele é executado em navegadores e, portanto, independente de plataforma. Observe que o Palladio, embora bastante versátil, é projetado mais para visualizações rápidas do que análise de rede sofisticada.

As etapas a seguir explicam como visualizar dados de rede no Palladio, mas também recomendo que dê uma olhada em seus próprios materiais de treinamento e explore seus dados de amostra. Aqui, entretanto, uso um *conjunto de dados de amostra ligeiramente modificado com base na* [tabela de dados do](/assets/creating-network-diagrams-from-historical-sources/network-example1-en.csv) *esquema de codificação* [1 - relações](/assets/creating-network-diagrams-from-historical-sources/network-example1-en.csv), [tabela de dados 2 - tabela de atributos](/assets/creating-network-diagrams-from-historical-sources/network-example2-en.csv), apresentada anteriormente (também pode fazer o download e usá-la para explorar outras ferramentas).

Passo a passo:

**1. Palladio.** Vá para [*http://hdlab.stanford.edu/palladio/*](http://hdlab.stanford.edu/palladio/)*.*

**2. Comece.** Em seu site, clique no botão “Start” (Iniciar).

**3. Carregue dados de atributos.** Da sua planilha de dados, copie a [tabela de dados de](/assets/creating-network-diagrams-from-historical-sources/network-example2-en.csv), amostra [2 - tabela de atributos](/assets/creating-network-diagrams-from-historical-sources/network-example2-en.csv) e cole na seção branca da página, agora clique em “Load” (Carregar)create.

{% include figure.html caption="Figura 6: Carregando dados de atributos no Palladio" filename="image13.png" %}


**4. Edite os atributos.** Altere o título da tabela para algo mais significativo, como “Pessoas”. Agora vê as colunas “Person” (Pessoa), “Race Status” (Situação da Raça) e “Sex” (Sexo) que correspondem às colunas nos dados de amostra. Em seguida, precisa se certificar de que o Palladio entende que há ações associadas às pessoas que acabou de inserir no banco de dados.

{% include figure.html caption="Figura 7: Visualização dos dados dos atributos no Palladio" filename="image14.png" %}


**5. Carregue dados relacionais.** Para fazer isso, clique em “Person” (Pessoa) e “Add a new table” (Adicionar uma nova tabela). Agora cole todos os [ddados da tabela 1 - relações](/assets/creating-network-diagrams-from-historical-sources/network-example1-en.csv), no campo apropriado. O Palladio espera que identificadores exclusivos vinculem as informações relacionais às informações de atributo do ator. Certifique-se de que as linhas estejam bem alinhadas e evite caracteres conflitantes, como “/”. O Palladio exibirá mensagens de erro se o fizer. Clique em “Load data” (Carregar Dados), feche a janela de sobreposição e volte para a visão geral dos dados principais. Deve ver algo assim:

{% include figure.html caption="Figura 8: Carregando dados relacionais" filename="image17.png" %}

**6. Atributos e relações do link.** Em seguida, precisamos vincular explicitamente as duas tabelas que criamos. Em nosso caso, o nome e o sobrenome das pessoas funcionam como IDs, portanto, precisamos conectá-los. Para fazer isso, clique nas ocorrências correspondentes na nova tabela. Nos arquivos de amostra, são “Giver” (Doador) e “Recipient” (Destinatário). Clique em “Extension” (Extensão) (na parte inferior) e selecione “People” (Pessoas), a tabela que contém todas as informações dos atributos de pessoas. Faça o mesmo para “Recipient” (Destinatário).

{% include figure.html caption="Figura 9: Ligando as pessoas às relações" filename="image08.png" %}

**7. Identifique os dados temporais.** O Palladio tem ótimos recursos de visualização de tempo. Pode usá-los se tiver pontos de início e de final para cada relação. Os dados de amostra contêm duas colunas com dados adequados. Clique em “Time Step Start” (Início da Etapa Temporal) e selecione o tipo de dado “Year or Date” (Ano ou Data). Faça o mesmo para “Time Step End” (Fim da Etapa Temporal) (Figura 10). A equipe do Palladio recomenda que seus dados estejam no formato AAAA-MM-DD, mas meus passos de tempo mais abstratos funcionaram bem. Se fosse carregar as coordenadas geográficas (não abordadas neste tutorial, mas aqui: [*Cenário de mapa simples do Palladio*](http://hdlab.stanford.edu/doc/scenario-simple-map.pdf)), selecionaria o tipo de dados “Coordinates”.

{% include figure.html caption="Figura 10: Alterando o tipo de dados para “Year or Date” (Ano ou Data)" filename="image05.png"%}


**8. Abra a ferramenta Graph.** Agora concluiu o carregamento dos dados. Clique em “Graph” para carregar a interface de visualização (Figura 11).

{% include figure.html caption="Figura 11: Carregar a ferramenta Graph" filename="image01.png"%}

**9. Especifique os nós de origem e destino.** Primeiro, o Palladio pede que especifique os nós “Source” e “Target” na rede (Figura 12). Vamos começar com “Doadores” e “Destinatários”. Agora verá o gráfico e poderá começar a estudá-lo com mais detalhes.

{% include figure.html caption="Figura 12: Selecione “Doador” como “Source” (Fonte) e “Destinatário” como “Target” (Destino)" filename="image07.png"%}

**10. Destaque os nós.** Continue marcando as caixas “Highlight” (Destacar). Isso lhe dará uma noção imediata de quem agiu como provedor de ajuda, de quem apenas recebeu ajuda e de quais atores deram e receberam ajuda.

**11. Facet filter.** NEm seguida, experimente o filtro facetado (Figura 13). Você reconhecerá as colunas que descrevem os diferentes atos de ajuda. Comece selecionando “3” na coluna “Form of Help” (Forma de Ajuda). Isso reduzirá o gráfico a apenas provisões de acomodação. Em seguida, selecione valores na coluna “Date of Activity” (Data de Atividade) para restringir ainda mais sua consulta. Isso mostrará quem forneceu acomodação e como isso muda com o tempo. Selecione novamente todos os valores em uma coluna clicando na caixa de seleção ao lado do nome da coluna. Aproveite o tempo para explorar o conjunto de dados - como ele muda com o tempo? Quando terminar, certifique-se de excluir o “Facet filter” usando a pequena lixeira vermelha.

As visualizações de rede podem ser incrivelmente sugestivas. Lembre-se de que tudo o que vê é uma representação diferente de sua codificação de dados (e das escolhas que fez ao longo do caminho) e que haverá erros que pode ter que corrigir. Qualquer um dos gráficos com que trabalhei teria uma aparência diferente se eu tivesse escolhido intervalos de tempo diferentes ou incluído pessoas que apenas se conheciam, mas não se engajaram em comportamentos de ajuda.

{% include figure.html caption="Figura 13: O filtro de Faceta no Palladio" filename="image15.png" %}

**12. Visualização de rede bipartida.** 12. Visualização de rede bipartida. Isso é legal. Mas há algo mais que torna o Palladio uma ótima ferramenta para começar com a visualização de rede: ele torna muito fácil produzir [*redes bipartidas ou de 2-modos*](https://en.wikipedia.org/wiki/Bipartite_graph#Examples). O que viu até agora é a chamada rede unipartida ou monomodo: ela representa as relações entre os nós de origem e de destino de um tipo (por exemplo, “people” (pessoas)) por meio de um ou mais tipos de relações, as Figuras 13 e 14 são exemplos deste tipo de gráfico.

A análise de rede, no entanto, dá muita liberdade para repensar o que são origem e destinos. As redes bipartidas têm dois tipos diferentes de nós, um exemplo poderia ser selecionar “people”/“pessoas” como o primeiro tipo de nó e “momento no tempo” como o segundo. A Figura 15 mostra uma rede bipartida e revela quais destinatários de ajuda estavam presentes na rede ao mesmo tempo. Compare este gráfico com a Figura 16, que mostra quais doadores de ajuda estiveram presentes ao mesmo tempo. Isso aponta para uma alta taxa de flutuação entre os ajudantes, uma observação que se aplica a todas as redes que estudei. Embora os humanos sejam muito bons no processamento de redes interpessoais, achamos mais difícil processar essas redes mais abstratas. Dê uma chance e experimente diferentes redes bipartidas: clique novamente em “Target” (Destino), mas desta vez selecione “Form of Help” (Forma de Ajuda) ou “Sex” (Sexo) ou qualquer outra categoria.

Observe que se quiser ver “Giver” (Doador) e “Recipients” (Destinatários) como um tipo de nó e “Date of Activity” (Data de Atividade) como o segundo, precisará criar uma coluna com todas as pessoas e uma segunda com os pontos no tempo durante os quais elas estavam presentes em seu editor de planilhas e importar esses dados para o Palladio. Além disso, nesta fase, o Palladio ainda não permite representar dados de atributos, por exemplo, colorindo os nós, mas todas as outras ferramentas têm essa funcionalidade.

{% include figure.html caption="Figura 14: Visualização de uma rede unipartida: doadores e destinatários da ajuda" filename="image02.png" %}


{% include figure.html caption="Figura 15: Visualização de uma rede bipartida: Destinatários e Data de Atividade" filename="image09.png" %}


{% include figure.html caption="Figura 16: Visualização de uma rede bipartida: doadores e data de atividade" filename="image16.png" %}


**13. Timeline.** TO recurso Linha do tempo fornece uma maneira relativamente fácil de visualizar as mudanças em sua rede. A Figura 17 mostra a distribuição de homens e mulheres na rede ao longo do tempo. A primeira coluna no eixo y corresponde ao campo “Dates” e representa os diferentes intervalos de tempo. As barras representam o atributo “Sex” (Sexo): desconhecido, o número de mulheres e homens é representado pela altura dos segmentos em uma barra (variando de cinza claro a preto). Passe o mouse sobre eles para ver o que é o quê. O segmento da barra inferior corresponde ao campo "Height shows" (Total) e aqui representa o número total de pessoas que muda entre os passos de tempo 13 e 14.

{% include figure.html caption="Figura 17: Distribuição de gênero na rede ao longo do tempo" filename="image04.png" %}


**14. Time Span.** Ainda mais interessante é a visualização “Time Span”, que atualiza a visualização da rede de forma dinâmica. Clique em “Time Span”. A Figura 18 ilustra o que deve ver agora. Use o mouse para destacar uma seção entre as etapas de tempo, que será então destacada em cinza. Agora pode arrastar a seção destacada pela linha do tempo e ver como o gráfico muda de uma etapa de tempo para outra.

{% include figure.html caption="Figura 18: Timeline. Visualização de etapas de tempo" filename="image12.png" %}


**15. Tamanho do nó.** O Palladio permite dimensionar seus nós com base nos atributos do ator. Observe que isso não faz sentido para os dados de amostra, visto que os valores numéricos representam categorias. Os tamanhos dos nós podem, entretanto, ser úteis se representar a soma dos atos de ajuda de uma pessoa, que neste caso corresponderia ao seu [*Grau Externo*](https://en.wikipedia.org/wiki/Directed_graph#Indegree_and_outdegree), com o número de relações de saída para um nó.

**16.Exporte suas visualizações.** O Palladio permite exportar sua rede como arquivos .svg, um formato de imagem baseado em vetor. Use o navegador de sua preferência para abri-los.

**17. Listas, mapas e galerias.** Deve ter notado que o Palladio possui uma variedade de formatos de visualização adicionais: “Lists” (Listas), “Maps” (Mapas), e “Galleries” (Galerias). Todos eles são tão intuitivos e bem projetados quanto a seção Graph. As galerias permitem que especifique certos atributos de seus atores e os apresentem em uma visualização de cartão. Ao adicionar valores de latitude/longitude aos atributos de ator, terá uma noção instantânea de onde sua rede acontece. Dê uma olhada em seus próprios arquivos de amostra para explorar isso.


O valor agregado das visualizações de rede
------------------------------------------------------

A extração cuidadosa de dados de rede de um texto é demorada e exaustiva, pois requer concentração total em cada etapa ao longo do caminho. Regularmente me perguntava se valia a pena - e no final se poderia ou não ter feito as mesmas observações sem o suporte de visualizações de rede. A resposta é sim, posso ter chegado às mesmas conclusões principais sem codificar todos esses dados e sim, valeu a pena. Inserir os dados relacionais logo se torna rápido e indolor no processo de leitura atenta.

Na minha experiência, a leitura e a interpretação atenta e orientada por perguntas de um lado e a codificação e visualização de dados do outro não são processos separados, mas entrelaçados e podem se complementar com muita eficácia. Brincar não é geralmente considerado algo muito acadêmico, mas especialmente com este tipo de dados é um valioso investimento de seu tempo: você não apenas brinca com seus dados, reorganiza e, portanto, repensa constantemente o que sabe sobre o seu tópico e o que *pode* saber sobre o seu tópico.

Cada laço que codifiquei representa a história de como alguém ajudou outra pessoa. As visualizações de rede me ajudaram a entender como essas cerca de 5.000 histórias e 1.400 indivíduos se relacionam. Eles frequentemente confirmavam o que eu sabia, mas regularmente também me surpreendiam e levantavam questões interessantes. Por exemplo, isso me levou a identificar Walter Heymann como a pessoa cuja corretora de contato iniciou duas grandes redes de suporte e, subsequentemente, permitiu que salvassem centenas de pessoas. As descrições de seus contatos com atores importantes em ambas as redes estavam espalhadas em diversos documentos nos quais eu havia trabalhado durante as diferentes fases do projeto. A visualização agregou todas essas relações e revelou essas conexões. Uma investigação mais aprofundada mostrou então que foi ele mesmo quem os reuniu.


{% include figure.html caption="Figura 19: Walter Heymann intermediou contatos que levaram ao surgimento de duas grandes redes de suporte" filename="image10.png" %}


Em outras ocasiões, as visualizações revelaram a existência de cadeias de contato de longo alcance em diferentes classes sociais que ajudaram os refugiados a criar laços de confiança com estranhos, elas também mostraram lacunas inesperadas entre os atores que eu esperava estar conectados, me levaram a identificar grupos em listas sobrepostas de nomes, observar fases de atividade e inatividade, ajudou-me a localizar pessoas que uniam diferentes grupos e, de modo geral, me levou a enfatizar a corretagem de contatos de vítimas judias de perseguição como um fator importante, até então esquecido, no surgimento de redes secretas.

É claro que as visualizações não são “provas” de nada, mas ferramentas para ajudar a compreender relações complexas; sua interpretação é baseada em um bom entendimento dos dados subjacentes e como eles foram visualizados. As visualizações de rede selecionadas também podem acompanhar o texto e ajudar seus leitores a entender melhor as relações complexas que discute, muito parecido com os mapas que às vezes encontra nas capas de livros antigos.

Alguns pontos práticos:

- Colete e armazene dados em uma planilha e use uma cópia para visualizações.
- Certifique-se de entender a lógica básica por trás de qualquer algoritmo de centralidade e layout que escolher, pois eles afetarão sua visualização de seus dados. A Wikipedia geralmente é uma boa fonte de informações abrangentes sobre eles.
- Não hesite em revisar e começar de novo se perceber que seu esquema de codificação não funciona conforme o esperado. Definitivamente valerá a pena.

Finalmente, qualquer uma das visualizações que possa criar com o pequeno conjunto de dados de amostra que forneço para este tutorial requer conhecimento do contexto para ser realmente significativo. A única maneira de descobrir se esse método faz sentido para sua pesquisa é começar a codificar seus próprios dados e usar seu próprio conhecimento de contexto para dar sentido às suas visualizações.

Boa sorte!

Outras ferramentas de visualização de rede a serem consideradas
---------------------------------------------

[*Nodegoat*](http://nodegoat.net/) – semelhante ao Palladio no sentido de que facilita a coleta de dados, o mapeamento e a visualização de gráficos. Permite fácil configuração de bancos de dados relacionais e permite que os usuários armazenem dados em seus servidores. [*Tutorial disponível aqui*](http://nodegoat.net/cms/UPLOAD/AsmallguidebyYanan11082014.pdf).

[*NodeXL*](http://nodexl.codeplex.com/) –  capaz de realizar muitas tarefas comuns em SNA, fácil de usar e de código aberto, mas requer Windows e MS Office 2007 ou mais recente. [*Tutorial 1*](https://www.youtube.com/watch?v=pwsImFyc0lE), [*Tutorial 2*](http://www.youtube.com/watch?v=xKhYGRpbwOc).

[*Gephi*](https://gephi.github.io/) – código aberto, plataforma independente. A ferramenta de visualização mais conhecida e versátil disponível, mas espere uma curva de aprendizado acentuada. Os desenvolvedores anunciam suporte para abas paralelas na versão 1.0. Tutoriais: por [*Clement Levallois*](http://www.clementlevallois.net/training.html) e [*Sebastien Heymann*](http://www.youtube.com/watch?v=L6hHv6y5GsQ).

[*VennMaker*](http://www.vennmaker.de) – é independente de plataforma e pode ser testado gratuitamente. O VennMaker inverte o processo de coleta de dados: os usuários começam com uma tela personalizável e desenham nós e relações autodefinidos nela. A ferramenta coleta os dados correspondentes em segundo plano.

As ferramentas mais comumente usadas para análises mais matemáticas são [*UCINET*](https://sites.google.com/site/ucinetsoftware/home) (licenciado, tutoriais disponíveis em seu site) e [*Pajek*](http://pajek.imfm.si/doku.php) (gratuito), para os quais existe um ótimo [*manual*](http://www.cambridge.org/us/academic/subjects/sociology/research-methods-sociology-and-criminology/exploratory-social-network-analysis-pajek-2nd-edition). Ambos foram desenvolvidos para Windows, mas funcionam bem em outros lugares usando o Wine.

Para usuários de Python, o pacote muito bem documentado [*Networkx*](https://networkx.github.io/) é um ótimo ponto de partida; outros pacotes existem para outras linguagens de programação.
