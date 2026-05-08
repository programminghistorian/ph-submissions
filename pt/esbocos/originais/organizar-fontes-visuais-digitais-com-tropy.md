---
title: "Organizar fontes visuais digitais com Tropy: os Cartazes da Democracia como estudo de caso"
slug: organizar-fontes-visuais-digitais-com-tropy
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Eric Maia
reviewers:
- Forename Surname
- Forename Surname
editors:
- Daniel Alves
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/689
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introdução

No decorrer do meu curso de mestrado, apresentei comunicações orais em diferentes simpósios temáticos com o objetivo de divulgar a importância do Tropy no tratamento de fontes visuais digitais em pesquisas acadêmicas com imagens. Essas apresentações partiram da minha própria experiência de pesquisa, em que surgiu a necessidade do uso de ferramentas mais adequadas à organização, descrição, classificação e análise de conjuntos documentais compostos por imagens.

Durante esse percurso, percebi que grande parte dos pesquisadores e pesquisadoras com quem dialoguei ainda não conhecia o Tropy. Em muitos casos, o tratamento das fontes era feito com softwares pouco adequados para esse tipo de trabalho, como pastas do navegador, editores de texto, planilhas genéricas ou programas destinados apenas ao armazenamento simples de arquivos. Esses recursos podem servir para guardar documentos e facilitar consultas pontuais, mas oferecem poucos caminhos e possibilidades metodológicas para a pesquisa com imagens. Também limitam a criação de metadados consistentes, a descrição sistemática dos itens, a organização temática do acervo, o registro de notas analíticas ligadas às fontes e a possibilidade de compartilhamento estruturado de dados com a comunidade acadêmica.

O Tropy responde de forma muito mais adequada a essas demandas porque foi desenvolvido por pesquisadores e para pesquisadores. Seu projeto nasceu de problemas concretos enfrentados por quem trabalha com fontes primárias digitalizadas e precisa lidar com volumes grandes de arquivos, múltiplas informações descritivas e diferentes formas de classificação. Por isso, o software oferece um ambiente de trabalho mais ajustado às rotinas da pesquisa histórica, permitindo reunir em um mesmo espaço procedimentos de organização documental, descrição das fontes, anotação, agrupamento e análise.

O uso do Tropy favorece maior controle sobre acervos compostos por imagens e amplia as possibilidades de sistematização dos dados produzidos no decorrer da investigação. Com isso, o tratamento das fontes deixa de ser uma etapa mais restrita aos pesquisadores, passando a assimilar as possibilidades de integrar de forma mais direta a construção do conhecimento histórico, de maneira mais coletiva e compartilhada. Nesta lição, proponho apresentar as principais funções do software Tropy para pesquisadores em História que trabalham com fontes visuais, tomando como estudo de caso a pesquisa desenvolvida em minha dissertação de mestrado. No desenvolver da lição, pretendo não limitá-la ao caráter de tutorial técnico, mostrando como o software pode ser incorporado à pesquisa histórica, assim como os desdobramentos das formas de seu uso acabam proporcionando, inexoravelmente, o surgimento de novas perguntas metodológicas. Estas novas questões podem acrescentar substância à análise documental digital, bem como expandir a pesquisa por caminhos que não seriam possíveis, caso o tratamento das imagens fosse feito de maneira física, ou ainda, utilizando softwares que não foram concebidos com o objetivo de tratar fontes visuais, como acontece na maioria dos casos.

E ainda assim, pretendo analisar os usos técnicos do Tropy, como uma ferramenta de organização, descrição, classificação e análise de acervos visuais, especialmente quando a investigação envolve conjuntos documentais extensos e heterogêneos.

O diferencial desta proposta está no estudo de caso que consiste na pesquisa que desenvolvi para produzir minha dissertação de Mestrado, no Programa de Pós Graduação em História da Universidade Federal Fluminense, que foi defendida em Março de 2026, com o título: "Cartazes da Democracia: imagem, política e ação coletiva no Brasil Republicano".

O corpus documental mobilizado possui 121 cartazes políticos produzidos por movimentos sociais no contexto da Redemocratização do Brasil, pertencentes à coleção do Centro Pró-Memória da Constituinte, hoje preservada pelo Museu da República, no Rio de Janeiro. Ao acompanhar o uso do Tropy sobre esse conjunto documental específico, a lição ensinará procedimentos operacionais do software e permitirá discutir problemas metodológicos que emergem no decorrer da própria pesquisa, como a definição de critérios de descrição, a criação de categorias de classificação e a construção de metadados originais, exclusivos e consistentes.

Esta lição dialoga diretamente com “Gestionar fuentes primarias digitales con Tropy”, de Douglas McRae, publicada no Programming Historian em espanhol, cuja estrutura didática e cujo percurso de apresentação do software serviram de referência para a elaboração deste novo texto. A presente proposta, contudo, constitui uma lição original, desenvolvida a partir de outro estudo de caso e de outra experiência de pesquisa. Em lugar do corpus utilizado na lição de McRae, este texto mobiliza os cartazes já mencionados anteriormente, documentos analisados em minha pesquisa de mestrado.

Nesse sentido, a proposta parte da compreensão de que ferramentas digitais extrapolam sua função instrumental, podendo produzir efeitos no modo como o pesquisador observa, agrupa, compara e interroga suas fontes. No caso desta lição, o uso do Tropy será apresentado como parte de um processo de tratamento documental que torna mais manejável um volume significativo de imagens, oferecendo ganhos práticos e também metodológicos, na medida em que amplia as possibilidades de leitura sistemática, cruzamento de informações e produção de conhecimento a partir de grandes conjuntos de dados visuais.

Ao concluir esta lição, espera-se que seja construído o aprendizado para que se seja capaz de utilizar o Tropy de forma autônoma. Isso inclui compreender a lógica geral de funcionamento do software, criar um projeto do zero e desenvolver um fluxo de trabalho adequado à organização e ao tratamento documental na pesquisa.

Espera-se também que se aprenda a trabalhar com os metadados oferecidos pelo Tropy, entendendo sua utilidade na descrição, identificação e recuperação das fontes, e que se consiga ir além dos modelos já disponíveis, criando séries originais de metadados ajustadas às necessidades específicas de qualquer corpus documental. Com isso, a lição pretende assimilar a ideia de que descrever documentos e tratar fontes não se restringe a um aspecto meramente técnico, constituindo parte fundamental da construção de critérios analíticos para a pesquisa.

Metadados são, de forma simples, dados sobre outros dados: informações que descrevem, identificam, organizam e contextualizam um documento. No caso de fotografias utilizadas em pesquisa histórica, os metadados ajudam o pesquisador a saber o que a imagem mostra, quando foi produzida, quem a produziu, onde está preservada, em que fundo ou coleção se encontra, qual é sua referência de arquivo e quais temas ela mobiliza. Uma fotografia de uma manifestação política, por exemplo, pode ter como metadados o título atribuído pelo pesquisador, a data aproximada, o local do registro, o nome do fotógrafo ou da instituição responsável, a coleção de origem, a cota arquivística, palavras-chave como “protesto”, “movimento estudantil” ou “ditadura”, e ainda notas sobre elementos visíveis na cena, como faixas, cartazes ou personagens identificáveis.

Em pesquisas históricas, esses dados são fundamentais porque permitem localizar a imagem com precisão, recuperar conjuntos documentais semelhantes, cruzar informações entre fontes e transformar um arquivo de fotografias soltas em um corpus organizado e analiticamente utilizável. Resumindo: trata-se de uma ficha catalográfica digital universal da fonte histórica.

Outro resultado esperado é o domínio das diferentes funções de catalogação e organização presentes no software. Ao final da lição, será possível classificar documentos, utilizar etiquetas, registrar notas, agrupar materiais segundo diferentes critérios e explorar a função que permite associar múltiplas imagens a uma mesma entrada de arquivo, algo particularmente útil em pesquisas com documentos compostos por várias páginas, partes ou vistas de um mesmo item.

Além disso, a lição busca instruir e capacitar para que seja possível a realização de procedimentos essenciais referentes à gestão do projeto, como construir backups, preservar com segurança o trabalho realizado e exportar coleções de documentos para outros usos e fluxos de pesquisa. Dessa forma, o aprendizado proposto envolve tanto o domínio técnico do Tropy quanto a incorporação de práticas de organização documental mais consistentes e adequadas ao trabalho acadêmico com imagens.

## Descrição Do Tropy

O Tropy é um software livre, gratuito e de código aberto concebido para a organização, a descrição e a exportação de imagens e materiais de pesquisa digitalizados.

Sua proposta atende de modo particular às demandas de pesquisadores que trabalham com fotografias de documentos, imagens de objetos e arquivos provenientes de repositórios digitais, sobretudo quando a investigação envolve conjuntos extensos de fontes visuais e exige procedimentos sistemáticos de gestão documental.

Lançado em 2016, o software foi desenvolvido inicialmente no [Roy Rosenzweig Center for History and New Media](https://rrchnm.org/), da George Mason University, nos Estados Unidos.

Em etapas posteriores, seu desenvolvimento contou com a colaboração de outras instituições voltadas à pesquisa digital, entre elas o [Luxembourg Centre for Contemporary and Digital History](https://www.uni.lu/c2dh-en/), da Universidade de Luxemburgo, e a organização [Digital Scholar](https://digitalscholar.org/), também responsável por ferramentas amplamente difundidas no meio acadêmico, como Omeka e [Zotero](https://www.zotero.org/).

Outro aspecto relevante do Tropy diz respeito ao conjunto de recursos disponibilizados para seus usuários. O site oficial reúne informações gerais sobre o programa e orientações para acesso à [documentação](https://docs.tropy.org/). O código-fonte se encontra disponível publicamente no [GitHub](https://github.com/tropy), o que evidencia a dimensão aberta e colaborativa do projeto. A isso se somam uma [documentação](https://docs.tropy.org/) extensa em língua inglesa, um [fórum comunitário](https://forums.tropy.org/) voltado a dúvidas e sugestões e um [canal no YouTube](https://www.youtube.com/tropy) que reúne tutoriais em diferentes idiomas, além de oficinas e apresentações produzidas por membros da comunidade usuária.

O uso do Tropy tem se mostrado especialmente profícuo para pesquisadores da História e das Humanidades Digitais, embora sua aplicação seja mais ampla.

Pesquisadores que atuam com arquivos, coleções digitais e conjuntos documentais compostos por imagens podem incorporar a ferramenta a seus fluxos de trabalho mesmo sem formação prévia em programação. Sua interface foi desenvolvida para responder a problemas concretos colocados pelo tratamento de fontes primárias digitalizadas e para tornar mais acessíveis tarefas como descrição, organização e recuperação documental.

Nesse contexto, cabe destacar a atuação de Anita Lucchesi na consolidação da presença pública do Tropy no meio acadêmico. Nos [créditos oficiais do projeto](%5Bhttps://tropy.org/%5D%28https://tropy.org/%29credits.html), Lucchesi aparece vinculada à função de coordenadora de difusão, posição relacionada às atividades de divulgação e interlocução com usuários. Informações institucionais também registram sua participação em ações de formação e difusão da ferramenta no Centro de História Contemporânea e Digital da Universidade de Luxemburgo. Em apresentação institucional do projeto, Lucchesi definiu o Tropy como uma espécie de sala de leitura de arquivo portátil, formulação que sintetiza de maneira precisa sua contribuição para o trabalho histórico com grandes volumes de fontes digitalizadas e para a abertura de novas possibilidades de investigação a partir desse tipo de ambiente digital.

## Conjunto De Dados

A presente lição utilizará como corpus documental um conjunto de 121 cartazes produzidos por movimentos sociais no contexto da Redemocratização do Brasil. Esses documentos integram a coleção do Centro Pró-Memória da Constituinte (CPMC), hoje sob a guarda do Museu da República, no Rio de Janeiro. O acervo reúne materiais relacionados à Assembleia Nacional Constituinte e à participação da sociedade civil, incluindo cartazes de entidades e movimentos populares que atuaram nos debates em torno das Emendas Populares, da Constituinte e da Constituição de 1988. Nesta lição, esse conjunto foi escolhido por oferecer um caso especialmente fértil para demonstrar o uso do Tropy no tratamento de fontes digitais compostas por imagens, permitindo trabalhar com descrição, organização, classificação, notas e metadados em um corpus visual coeso e historicamente situado. Além disso, por se tratar de um conjunto documental já preservado institucionalmente, ele também favorece a discussão de questões metodológicas ligadas à pesquisa com coleções históricas, ao tratamento sistemático de fontes e à construção de procedimentos replicáveis em outros projetos.

## Instalando E Configurando O Projeto

### Instalação

Tropy é um aplicativo para desktop. Para instalá-lo, basta acessar o sítio principal [https://tropy.org/](https://tropy.org/) e clicar no botão "Baixar Tropy para \[nome do sistema detectado automaticamente]”. Em seguida, localize o instalador no seu disco rígido e siga as instruções para o seu sistema operacional (Mac, Windows ou Linux). Você sempre encontrará a versão mais recente, juntamente com versões anteriores e beta, no repositório do [GitHub](https://github.com/tropy) (procure pela tag "Latest ").

### Tipo De Projeto

Um projeto no Tropy é o arquivo onde as fotos de banco de imagens são armazenadas juntamente com seus dados e metadados.

Ao abrir o Tropy pela primeira vez, você precisará nomear seu projeto e escolher o tipo. Recomenda-se abordar os projetos da maneira mais abrangente possível: como um manuscrito de livro, uma tese de doutorado ou um tema geral que possa englobar múltiplas possibilidades. Por exemplo, para este projeto, em vez de nomeá-lo com o nome do arquivo ou repositório, você poderia escolher um nome que reflita um tema geral, como “Cartazes da Democracia”. Você poderá alterar o nome posteriormente dentro do projeto. (inserir figura 1)

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-01.jpg" alt="Visual description of figure image" caption="Figura 1: Tela inicial do projeto novo do Tropy." %}

Você também precisará escolher entre um projeto padrão .tpy ou avançado .tropy.

A diferença está em como o Tropy vincula as fotos ao arquivo do projeto. Ao importar uma foto, o Tropy estabelece um caminho entre o projeto e a foto, exibindo a imagem na interface do projeto. Em um projeto padrão, o Tropy faz cópias das imagens importadas, salvando-as no diretório do projeto, usando esse local como caminho. Em um projeto avançado, o Tropy usa o local original da foto como caminho entre o projeto e a foto, sem fazer uma cópia.

Com um projeto padrão, realocá-lo é mais fácil: basta transferi-lo para outro computador ou compartilhá-lo com outro usuário. Com um projeto avançado, realocar o arquivo exigirá restaurar o caminho entre as imagens e o projeto por meio de um processo de consolidação. Para consolidar uma imagem com um caminho corrompido (indicado por um ícone com um ponto de exclamação), basta clicar com o botão direito do mouse, selecionar " Consolidar Item" no menu de contexto e navegar até o novo local da imagem.

O Tropy geralmente solicitará que você vincule novamente outras imagens no mesmo diretório, caso mais imagens precisem ser consolidadas.

### Localizando O Projeto

A localização do projeto dependerá do seu tamanho previsto. Se você escolheu um projeto padrão, precisará verificar se há espaço suficiente em seu computador, disco rígido ou pasta na nuvem para armazená-lo.

### Idioma

O Tropy oferece diversas opções de idioma. Você pode escolher seu idioma clicando nos três pontos no topo esquerdo, ao lado da logo do Tropy, indo em Editar > Preferências (ou Ctrl+shift+S no Windows) > Definições > Idioma; em Arquivo > Preferências (no Mac OS) selecionando sua preferência no menu suspenso.

## Importando Fotos

O processo de importação é como o Tropy estabelece caminhos entre as imagens e o projeto para facilitar a descoberta ou localização das fontes. As imagens podem ser importadas nos seguintes formatos: JPG/JPEG, PNG, SVG, TIFF, GIF, PDF, JP2000, WEBP, HEIC e AVIF.

É possível importar catálogos inteiros em formato PDF. Antes de importar PDFs, é importante verificar a resolução em pixels (ppi) no menu Tropy > Editar > Preferências > Parâmetros . O valor padrão é 72 ppi, o que facilita a importação rápida de PDFs; no entanto, pode reduzir a qualidade da exibição. Se isso for insuficiente, recomenda-se aumentar o valor para 144–288 ppi.

### Importando Da Web

O Tropy pode importar fotos estáticas da internet. Arraste a imagem escolhida da janela do seu navegador para a janela principal do Tropy (a visualização do projeto). Se você estiver trabalhando em um projeto padrão, o Tropy criará uma cópia da imagem. Se estiver trabalhando em um projeto avançado, o Tropy definirá um caminho contendo a URL da imagem estática.

No caso dos arquivos do Centro Pró Memória da Constituinte, os documentos foram digitalizados por mim, fotografados e salvos no disco rígido do meu computador pessoal, estão em formato JPEG. Por outro lado, estas imagens estão disponíveis na página do Museu da República em https://atom- museurepublica.museus.gov.br/index.php/29bt-t3yb-gaxa, em um arquivo PDF. Para os objetivos e efeitos da minha pesquisa, o documento PDF era insuficiente no tratamento das fontes, uma vez que eu precisava de informações como tamanho, tipo de impressão, gramatura do papel, fotografias de detalhes, como assinaturas de artistas, fotografias do verso, para saber se os cartazes já tinham sido colados em paredes ou murais, e várias outras informações que somente a análise presencial proporcionaria.

### Arrastando Imagens

Você pode arrastar imagens do seu computador ou de um dispositivo conectado (como um pen drive, um disco rígido externo ou uma pasta na nuvem) para um projeto do Tropy. Basta arrastar um arquivo ou um conjunto de arquivos para a interface principal (a visualização do projeto). O Tropy começará a importá-los para o projeto um por um.

Você também pode selecionar as imagens para importar em Arquivo > Importar > Fotos (Ctrl+shift+I).

### Pastas

Também é possível importar uma pasta de imagens por meio do menu Arquivo > Importar > Pasta.

Monte uma pasta com as imagens originais e poderá importar as imagens e manter a pasta como fonte de suas imagens, designando uma pasta monitorada, sempre que um arquivo de formato compatível com o Tropy for adicionado à pasta designada, ele será importado automaticamente para o projeto Tropy. Use o botão “Procurar” (figura 2) para vincular uma pasta.

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-02.jpg" alt="Visual description of figure image" caption="Figura 2. Na seção Projeto, dentro de Preferências, é possível designar uma pasta monitorada para facilitar a importação." %}

## Ações Em Massa

Após importar um conjunto de imagens, é sempre recomendável processá-las e adicionar metadados imediatamente. Esta seção do tutorial descreve algumas das ações

> NOTA: Se você baixar arquivos grandes para importar em um projeto padrão, considere excluir as imagens da pasta monitorada, pois o Tropy fará uma cópia dentro do arquivo do projeto. em massa que você pode realizar após importar um grupo de imagens. Observação: você pode visualizar as imagens importadas mais recentemente em um projeto por meio da lista "Última Importação", localizada na barra lateral esquerda da visualização do projeto.

### Orientação

Assim como em muitos aplicativos de edição de fotos, você pode alterar a orientação das imagens. Clique com o botão direito do mouse (ou Control + clique esquerdo no Mac) em uma imagem e selecione Girar para a Direita ou Girar para a Esquerda no menu de contexto. Selecionando várias imagens com a opção Selecionar Tudo (Ctrl + A no Windows, Command + A no Mac), você pode girá-las simultaneamente, facilitando a leitura e a análise das fontes.

### Editando Múltiplos Campos De Metadados

Na lateral direita da visualização do projeto se encontra o modelo de metadados.

O modelo pré-configurado Tropy Generic contém um conjunto de propriedades padrão para descrever um objeto de arquivo — outros modelos incluídos no Tropy podem ser selecionados no menu suspenso. Por exemplo, o modelo para documentos de correspondência — cartas, telegramas e similares — foi desenvolvido especificamente para esse fim. O Tropy também inclui um modelo com os quinze elementos Tropy de correspondência de metadados do [Dublin Core](https://en.wikipedia.org/wiki/Dublin_Core) e outro para registrar metadados de arquivos de fotos.

Para revisar e editar os campos de metadados de um objeto, clique em uma imagem e preencha todos os campos desejados. Para revisar e editar os campos de metadados de vários objetos simultaneamente, clique com o botão direito do mouse (Ctrl+clique no Mac) em cada imagem ou use Selecionar Tudo (Ctrl+A no Windows, Command+A no Mac) para selecionar todos os objetos no projeto ou na lista ativa. Você pode editar os campos presentes no modelo predefinido selecionado e as alterações serão aplicadas a todos os objetos selecionados. Da mesma forma, se você editar os campos de metadados de um objeto e, em seguida, selecioná-lo como parte de um conjunto, um símbolo de + aparecerá, indicando que há dados diferentes no mesmo campo para objetos diferentes. Se você modificar esse campo, os novos dados serão aplicados a todos os objetos selecionados.

Os Cartazes da Democracia não compartilham muitos campos de metadados comuns, mas isso pode ocorrer, dependendo do corpus de pesquisa. Outros campos podem variar dependendo do volume ou arquivo específico (Título, Criador, Data), portanto, os campos de metadados podem ser editados usando uma combinação de ações em massa e descrições individuais. O desenvolvimento de modelos de metadados personalizados para coleções específicas será explicado posteriormente. Campos adicionais podem ser adicionados a um objeto individual clicando com o botão direito do mouse ( Ctrl+clique no Mac) no modelo de metadados ativo e selecionando Novo Campo no menu de contexto. Em seguida, use a barra de pesquisa para encontrar a propriedade mais apropriada. O Tropy contém um grande número de vocabulários de metadados, que serão discutidos posteriormente.

### Combinando / Expandindo

O Tropy permite mesclar imagens individuais em objetos com várias fotos. Isso possibilita combinar uma sequência de fotos tiradas individualmente para reconstruir um documento do seu arquivo: uma carta, um relatório, um manuscrito, etc. Para mesclar, selecione as fotos no projeto, abra o menu de contexto (clique com o botão direito no Windows ou Ctrl+clique no Mac) e escolha “Combinar itens selecionados” — a primeira imagem selecionada se tornará a capa do novo objeto mesclado. Como alternativa, se você arrastar uma imagem sobre a outra, elas serão mescladas (com a segunda imagem se tornando a capa). Você pode reorganizar a ordem das fotos no painel abaixo do modelo de metadados, no lado direito da interface.

No caso de um documento PDF com várias páginas, as imagens serão importadas como um objeto mesclado. Em alguns casos, será necessário desconstruir esse objeto, o que pode ser feito selecionando-o e escolhendo “Expandir Item” no menu de contexto. O resultado será a separação das fotos ou imagens individuais, preservando quaisquer metadados e anotações adicionados anteriormente.

No arquivo PDF com os Cartazes da Democracia, mencionado anteriormente, disponibilizado pelo Museu da República, foi possível utilizar esse recurso. Ele apresentava um catálogo com a digitalização da coleção completa dos cartazes. Assim, foi possível desmembrar as imagens em novas entradas no Tropy, e a partir daí, criar todo um conjunto de informações concernentes a cada cartaz, as fotografias que tirei deles presencialmente foram acrescentadas a este catálogo inicial desmembrado, cuja imagem de capa era proveniente do PDF.

## Descrevendo As Imagens

Uma das funções mais importantes do Tropy é descrever as fontes por meio de metadados e anotações. Além disso, é possível organizar as imagens com um sistema de etiquetas e listas personalizadas. Essas descrições, adicionadas pelo pesquisador, ajudam a revelar informações presentes nas fontes e permitem a criação manual de referências às fontes primárias.

Clicar duas vezes em um objeto (uma imagem individual ou imagens mescladas) alternará o projeto para a visualização de objeto (clique na seta no canto superior esquerdo para retornar à visualização de galeria ). Nessa visualização, além de continuar a inserir metadados, você pode editar levemente as fotos do objeto e adicionar notas ou anotações.

O modelo de metadados aparece no lado esquerdo da interface na visualização de objeto.

Essa visualização facilita a análise da imagem e a adição de metadados individuais. É sempre recomendável inserir metadados de forma consistente. Por exemplo, se você inserir o nome do criador (autor) de um arquivo usando o sobrenome seguido do nome, mantenha esse formato. Da mesma forma, recomenda-se usar o formato de data ISO no campo Data (AAAA-MM-DD); 1730-02-01 se tornará 1º de fevereiro de 1730. O Tropy renderizará a data em um formato legível para organizar as colunas cronologicamente.

### Personalizando Metadados

O Tropy inclui um editor para facilitar a criação de modelos de metadados personalizados. Em Editar > Preferências > Modelos (ou Ctrl+shift+S > Modelos), onde você pode revisar todos os modelos incluídos na instalação, bem como criar um modelo de metadados do zero. 

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-03.jpg" alt="Visual description of figure image" caption="Figura 3: Construindo metadados personalizados." %}

Para criar um novo modelo do zero, certifique-se de que "Novo Modelo" apareça no menu suspenso e insira os metadados necessários para identificar o modelo: Nome, Tipo, Criador e Descrição (não é recomendável modificar o URI gerado pelo editor). Em seguida, clique em " Criar ". Usando os botões ( + ) e ( - ), você pode adicionar ou remover propriedades do novo modelo. Essas propriedades podem fazer parte de qualquer vocabulário instalado no Tropy: elementos e termos do [Dublin Core](https://en.wikipedia.org/wiki/Dublin_Core), [vocabulários RDF](https://en.wikipedia.org/wiki/RDF_Schema), [Modelo de Dados Europeu](https://pt.wikipedia.org/wiki/Europeana) e vocabulários relacionados. O Tropy oferece a flexibilidade de combinar diferentes vocabulários, bem como usar elementos exclusivos do Tropy.

Ao adicionar uma propriedade, você pode modificá-la para especificar o tipo de dados, atribuir um rótulo diferente do nome padrão, adicionar uma dica (por exemplo, 'Sobrenome, Nome', para lembrar a ordem em que o nome do autor deve ser registrado) e também definir um valor predefinido. Este último pode ajudar no processamento da origem, por exemplo, ao aplicar um modelo pré-preenchido a uma coleção com várias imagens semelhantes.

Para registros ANHV, você pode criar um modelo de metadados a partir do site, como Descrição ( dc:description), Escopo ( dcterms:extent)  e Local de Criação ( Iptc4xmpExt:LocationCreated). Outras propriedades dependerão do que você considerar relevante para descrever as fontes do projeto.

Você pode criar um modelo personalizado com base em um modelo existente.

Escolha um modelo no menu suspenso e clique nos dois retângulos que aparecem à direita. O editor criará uma cópia, que você poderá salvar após revisar e confirmar os metadados — por exemplo, renomeando-a. O novo modelo conterá as mesmas propriedades do original, e você poderá adicionar ou remover quaisquer outras que precisar.

Na pesquisa com os Cartazes da Democracia, o uso de metadados personalizados constituiu um dos pontos cruciais da metodologia. Na primeira fase do trabalho, realizei uma análise detalhada de cada cartaz, levando em conta aspectos materiais e documentais como dimensões, tipo e gramatura do papel, tipo de impressão, instituição responsável por sua produção — neste caso, em grande medida, movimentos sociais de luta popular — e, quando foi possível identificar, também o artista ou fotógrafo responsável pela imagem. Além disso, registrei marcas físicas relevantes, como fitas adesivas, furos, sinais de fixação, dobras e indícios de envio pelo correio. Esse nível de organização tornou possível extrair informações que ultrapassavam o conteúdo visual mais imediato dos cartazes. A observação sistemática desses elementos permitiu levantar hipóteses sobre as condições de produção e circulação dos cartazes, inclusive sobre condições materiais dos grupos e formas de financiamento, a partir da qualidade material empregada, e sobre seus usos concretos, distinguindo, por exemplo, cartazes efetivamente expostos daqueles que permaneceram guardados. Em alguns casos, a presença de carimbos dos Correios confirmou que o envio postal também integrava o universo de circulação dos cartazes políticos, ampliando a compreensão de suas formas de difusão. 

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-04.jpg" alt="Visual description of figure image" caption="Figura 4: Um exemplo de metadados personalizados." %}

### Campos Obrigatórios E Campos Somente Leitura

Em modelos pré-configurados, você sempre verá um ícone de sinalização ao lado do campo "Direitos”. Esse ícone serve como um lembrete para preencher o campo. Essa preferência aparece no editor de modelos. Você também pode definir um campo em um modelo personalizado como obrigatório ou somente leitura.

Todos esses parâmetros, juntamente com as dicas, podem ajudar a padronizar os metadados, lembrando quais elementos são mais importantes e como inseri-los para manter a consistência. Eles também podem ser úteis para outros usuários, caso decidam importar um modelo para seus próprios projetos.

### Vocabulários Controlados

Na janela Preferências (Ctrl+shift+S), você pode revisar os vocabulários que acompanham o Tropy na opção “vocabulários”. Clique em qualquer esquema para visualizar seus elementos. Você pode adicionar outros vocabulários clicando com o botão esquerdo no botão + na parte inferior da janela. Os esquemas devem estar no formato .n3 ou .txt. Você pode visualizar uma lista extensa de esquemas de vocabulário controlado que podem ser facilmente importados para o Tropy no repositório de [Vocabulários Abertos Vinculados](https://vocabularyserver.com/vocabularies/) (LOV)[^1].

## Editar E Anotar Fotos

Na visualização de objetos, existem várias ferramentas para alterar a aparência e a legibilidade de uma imagem. Também é possível adicionar anotações tanto a imagens quanto a seleções.

### Edições Para Facilitar A Leitura

Na parte superior da visualização do objeto, encontram-se diversas ferramentas para ajustar e rotacionar a imagem atual. No canto superior direito, está o botão "Editar Foto”, onde, utilizando controles deslizantes, é possível ajustar o brilho, o contraste, a tonalidade, a saturação e a nitidez — tudo com o objetivo de melhorar a legibilidade de documentos desfocados, seja devido ao seu estado ou à qualidade da fotografia original.

Há também uma opção para inverter as cores, um recurso que facilita a leitura de microfilmes ou permite visualizar o negativo de uma fonte visual. 

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-05.jpg" alt="Visual description of figure image" caption="Figura 5: Opções de edição da imagem." %}

### Seleções

Uma das ferramentas mais importantes é a ferramenta de seleção. Clique no quadrado pontilhado na parte superior da visualização do objeto e use a ferramenta de seleção para selecionar uma área da imagem. Após alguns segundos, a seleção aparecerá.

Você pode revisar cada seleção clicando nela ou usando o painel de fotos à esquerda.

### Notas

No campo de notas (Figura 5), você pode adicionar qualquer anotação usando texto formatado. Esse texto também pode ser pesquisado usando a barra de pesquisa na visualização do projeto. Depois de adicionar uma anotação ao campo de notas, retorne à visualização do projeto e digite uma palavra ou frase que você escreveu no campo de notas (por exemplo, da Figura 5: 'alta gramatura'). Todos os objetos que contêm essa palavra ou frase (ou melhor, esse 'valor'), seja no campo de notas ou no modelo de metadados, aparecerão na visualização do projeto. Para retornar à visualização com todos os objetos, limpe o valor digitado na barra de pesquisa. Usando esse recurso, você pode descobrir e agrupar vários objetos na visualização principal, facilitando a conexão entre documentos que mencionam os mesmos termos. É também uma maneira de localizar rapidamente um documento específico com base na transcrição do documento ou nas anotações que você fez.

Dependendo da sua preferência, você pode alterar o modo de exibição do campo de notas de horizontal para lado a lado. Você também pode inserir links no campo de notas. É possível adicionar anotações tanto a seleções quanto a fotos. Para começar, basta digitar no campo de notas; as anotações serão salvas automaticamente no banco de dados do projeto.

## Organizando Imagens

Além do modelo de metadados, você pode descrever suas fontes no Tropy usando metadados "não estruturados" — ou seja, metadados que não pertencem a nenhum esquema ou vocabulário formal. Exemplos desse tipo de metadado incluem descrições temáticas relacionadas ao documento ("artístico", "fotográfico", "constituinte"), descrições cronológicas ("1983") ou descrições relacionadas ao seu fluxo de trabalho ("Transcrição ausente", "Metadados completos"). Você pode adicionar esses tópicos usando a barra de etiquetas, no lado esquerdo da visualização do projeto (Figura 6).

As listas desempenham uma função semelhante: podem ser usadas para organizar as fontes em grupos e subgrupos. Trata-se de pastas que podem ser criadas com agrupamentos de imagens. Esses agrupamentos podem ser por tema ou refletir a organização de uma publicação planejada.

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-06.jpg" alt="Visual description of figure image" caption="Figura 6: Criando listas e etiquetas de organização." %}

Em resumo, essas funções ajudam a criar uma lógica organizacional para o seu projeto, seja por meio de uma série de listas que transmitem uma organização por capítulos e seções, seja por meio de etiquetas que destacam vínculos entre objetos que não estão representados nos metadados formais.

### Listas

As listas funcionam com uma lógica parecida de um diretório de arquivos com pastas e objetos. Sempre que você clicar em cima de uma lista específica, ela mostrará todos os seus elementos internos na tela do projeto. Para criar uma lista, clique com o botão direito do mouse (ou Ctrl+clique no Mac) na barra lateral esquerda. Selecione "Nova Lista" no menu de contexto e nomeie a pasta resultante (por exemplo, "Constituinte"). Em seguida, pressione Enter ou clique com o botão esquerdo do mouse.

Agora, você pode arrastar suas fontes da visualização do Projeto para a nova lista. Você pode adicionar uma fonte a várias listas, incluindo sublistas da lista principal. Para remover um item de uma lista, selecione esta opção no menu de contexto. Se você escolher "Excluir Item", o item será movido para a pasta "Itens Excluídos”. Para criar uma sublista dentro de uma lista, clique com o botão direito do mouse (ou Ctrl+clique no Mac) na lista e selecione "Nova Lista”. Você pode alterar a ordem de uma lista simplesmente arrastando-a para um local diferente dentro das listas; no entanto, seus nomes aparecem em ordem alfabética.

### Etiquetas E Rótulos

Existem várias opções para se criar uma nova etiqueta. Selecione um ou mais objetos na visualização do projeto. No lado direito da visualização do projeto, clique no botão Etiquetas para abrir o editor de etiquetas. Clique em Adicionar etiqueta ao objeto X (sendo X o número de objetos selecionados) e digite um nome para a etiqueta. Um ponto aparecerá na barra de etiquetas e também ao lado do título (ou o título exibido na visualização da galeria). Usando o menu de contexto, você pode alterar ou configurar a cor da etiqueta.

## Exportando Imagens

Você pode exportar imagens individuais, objetos (com ou sem metadados e anotações) e seleções de imagens em vários formatos. Clique com o botão direito do mouse em um objeto na visualização do projeto e selecione “Exportar Item” no menu de contexto. No submenu, você pode escolher [JSON-LD](https://en.wikipedia.org/wiki/JSON-LD) ou PDF (e, dentro do PDF, pode escolher a orientação retrato ou paisagem). A exportação em formato [JSON-LD](https://en.wikipedia.org/wiki/JSON-LD) .json exportará apenas os metadados e as anotações associadas às imagens selecionadas; a imagem em si não será incluída. Para exportar a imagem com os metadados e as anotações, você deve selecionar PDF.

A exportação por este método é semelhante à impressão (Arquivo > Imprimir) em formato PDF. Os parâmetros para imagens exportadas para PDF se encontram em Editar > Preferências > Definições. É possível escolher entre incluir ou não fotos, metadados e notas, bem como ajustar a formatação: otimizar o tamanho e a qualidade das fotos, incluir apenas fotos com notas e permitir que o conteúdo ocupe mais de uma página.

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-07.jpg" alt="Visual description of figure image" caption="Figura 7: Tela de preferências do Tropy." %}

Para exportar uma seleção, encontre o nome da seleção no painel Fotos, abaixo do modelo de metadados. Clique com o botão direito do mouse (ou Control-clique no Mac) sobre o nome na lista e escolha Exportar Foto no menu de contexto. Você terá duas opções: exportar para um arquivo ou pra área de transferência. A seleção será exportada em formato .jpg, sem metadados.

## Instalando Programas Adicionais (Plugins)

Plugins, ou programas complementares, são extensões que você pode instalar para facilitar a importação e exportação de imagens e metadados. Os plugins oficiais estão localizados no repositório [GitHub](https://github.com/tropy) do Tropy. Você também pode acessá-los no site do Tropy, na parte inferior da página inicial. Para instalar um, navegue até o repositório e baixe o plugin desejado. Em seguida, na janela de Preferências da sua instalação do Tropy, você deve ativá-lo (veja os passos abaixo). Existem plugins disponíveis para integração com uma instalação do Omeka S, exportação de objetos para o [Zotero](https://www.zotero.org/) (CSL) e exportação em vários formatos .zip. .csv. Além disso, é possível importar arquivos [IIIF](https://pt.wikipedia.org/wiki/Estrutura_Internacional_para_Interoperabilidade_de_Imagens) e manifestos.

## Integração Com O Zotero

Em alguns casos, pode ser útil converter os metadados armazenados no Tropy em uma referência compatível com o [Zotero](https://www.zotero.org/). Isso pode auxiliar na organização das fontes e na conexão delas ao processo de escrita. É preciso deixar registrado que este é considerado um uso avançado do Tropy, adequado apenas para determinados usuários.

Antes de começar, vale a pena se perguntar se você realmente precisa importar do Tropy para o [Zotero](https://www.zotero.org/). Se o seu projeto contém documentos arquivados ou manuscritos com uma estrutura de metadados semelhante à de um item do [Zotero](https://www.zotero.org/), ou se o seu projeto contém uma série de objetos com nomes semelhantes que você cita consecutivamente (boletins informativos, jornais, etc.), a importação do Tropy para o [Zotero](https://www.zotero.org/) pode ser útil. Em outros casos, pode ser mais fácil trabalhar diretamente com a fonte no [Zotero](https://www.zotero.org/) (se for um PDF, você pode usar o leitor de PDF integrado) ou criar manualmente uma referência no [Zotero](https://www.zotero.org/) para citá-la em seu trabalho. Os detalhes a seguir explicam como importar os metadados criados no Tropy a partir de um arquivo para o [Zotero](https://www.zotero.org/).

### Instalando O Plugin CSL

1. Baixe a versão mais recente do repositório de plugins do [GitHub](https://github.com/tropy) , à direita em Releases (tropy-plugin-csl-vx.x.x.zip).
2. Na sua instalação do Tropy, abra a janela de Preferências (Tropy no Mac ou Editar > Preferências no Windows) e navegue até a seção Plugins. Selecione Instalar Plugin.
3. Selecione o arquivo .zip baixado do repositório e clique em Ativar na janela Preferências quando ela aparecer.

### Que Tipo De Elemento Você Deseja Importar Para O Zotero?

1. Abra sua instalação do [Zotero](https://www.zotero.org/) e crie um item de exemplo que represente o objeto que você deseja importar do Tropy. Por exemplo, você pode fazer o seguinte: Arquivo > Novo Item > Livro ou Caso.
2. No elemento de exemplo que você criou, preencha os valores (por exemplo, x) para as propriedades que deseja importar de suas fontes para o Tropy. Essas propriedades devem ser as mais importantes para a construção de suas referências (Título, Data, Volume, etc.).
3. Clique com o botão direito do mouse no item de amostra e selecione Exportar item… no menu de contexto e exporte-o no .json  formato (CSL JSON).
4. Abra o arquivo exportado .json (ele será aberto no seu navegador ou outro aplicativo padrão) e anote os termos CSL usados (em inglês) para cada campo que você preencheu anteriormente. Você usará esses termos na etapa 4 da próxima seção. Somente as propriedades com valores em seus respectivos campos aparecerão no arquivo .json.

### Criando Um Modelo Personalizado No Tropy Para Importar Objetos Para O Zotero

1. Na sua instalação do Tropy, acesse a janela de Preferências (Tropy no Mac ou Editar > Preferências no Windows) e selecione Modelos . Escolha o modelo que você usará para os objetos que serão importados para o [Zotero](https://www.zotero.org/).
2. Crie uma cópia deste modelo de metadados.
3. Renomeie a cópia para diferenciá-la no menu suspenso Modelos. (Por exemplo: adicione '[Zotero](https://www.zotero.org/)' ao nome original).
4. Renomeie os rótulos das propriedades no novo modelo usando os termos CSL que apareceram no .json arquivo de item de exemplo copiado na etapa 4 da seção anterior. Use letras minúsculas e respeite os hífenes.
* Para importar com sucesso para o [Zotero](https://www.zotero.org/), seu modelo deve incluir uma propriedade de metadados chamada 'tipo' com um elemento válido do [Zotero](https://www.zotero.org/), como 'livro', 'relatório' ou 'artigo-periódico', no campo de metadados (consulte: [Tipos CSL](https://perma.cc/837L-8RRC) ). Você pode preencher esse campo para cada objeto que pretende importar ou atribuí-lo como um valor predefinido no editor de modelos.
* Nem todos os metadados do Tropy serão importados para o [Zotero](https://www.zotero.org/) no mesmo formato: por exemplo, valores de data ou a separação de sobrenomes e nomes. Para importar uma data, recomenda-se usar o termo CSL 'issued'.
* Se você alterar o idioma local no Tropy, precisará renomear seu modelo de importação do [Zotero](https://www.zotero.org/), substituindo as tags predefinidas pelas tags CSL (inglês).
* NOTA: Atualmente, não há como transferir o texto do campo "Notas" do Tropy para o [Zotero](https://www.zotero.org/). Como alternativa, você pode adicionar uma propriedade de metadados ao seu modelo de exportação com o termo CSL "nota" e, em seguida, copiar e colar manualmente as notas nesse campo. As notas aparecerão no [Zotero](https://www.zotero.org/) no campo "Extras" incluído em todos os itens.
5. Aplique o novo modelo aos objetos que deseja importar para o [Zotero](https://www.zotero.org/). \* Pouca coisa deve mudar em termos de valores, pois você está mapeando novas tags em propriedades de metadados preexistentes.
EXPORTANDO OBJETOS TROPY COMO UM ARQUIVO JSON CSL (Para posterior importação no [Zotero](https://www.zotero.org/))
6. Em Editar > Preferências (Ctrl + shift + S), na seção Plugins , selecione CSL e, em seguida, Parâmetros.
7. Adicione uma nova instância do plugin e você poderá dar um nome a ela para diferenciá-la no menu de contexto.
8. Selecione o modelo que você acabou de criar.
9. Lembre-se de que você pode criar vários modelos e opções de exportação para diferentes elementos do [Zotero](https://www.zotero.org/).
10. Retorne à visualização do projeto e clique com o botão direito do mouse no objeto — ou em vários objetos — que você deseja exportar como um arquivo .json.
11. Selecione Exportar objeto > \[nome da instância do plugin]
12. Dê um nome ao arquivo .json e salve-o. Se você pretende criar uma nova coleção no [Zotero](https://www.zotero.org/), pode usar esse nome; ao importar, o [Zotero](https://www.zotero.org/) gerará uma coleção com o nome do arquivo.

### Importar Para O Zotero

1. Na sua instalação do [Zotero](https://www.zotero.org/), selecione Arquivo > Importar e escolha um arquivo.
2. Selecione o .json arquivo exportado e clique em Continuar na caixa de diálogo de importação (você pode decidir se deseja criar uma nova coleção).
3. Clique em Concluído quando a importação estiver finalizada e verifique se os itens recém-importados incluem os campos de metadados desejados. (Caso contrário, retorne à etapa 4 da seção anterior.)
4. A partir daqui você pode gerenciar e citar essas referências por meio da sua instalação do [Zotero](https://www.zotero.org/).

## O Tropy E Os Cartazes Da Democracia

No desenvolvimento da pesquisa sobre os Cartazes da Democracia, o uso do Tropy produziu ganhos metodológicos decisivos para a organização do corpus, o tratamento documental e o amadurecimento das perguntas de pesquisa. Ao reunir, ordenar e descrever sistematicamente os cartazes em um mesmo ambiente, o software permitiu transformar um conjunto extenso e heterogêneo de imagens em uma série documental comparável e inteligível. A criação de metadados personalizados, o registro de notas analíticas, a classificação temática e a possibilidade de reunir múltiplas imagens em uma mesma entrada favoreceram uma leitura mais rigorosa da materialidade, da circulação e dos usos políticos dos cartazes, integrando a organização das fontes ao próprio processo de interpretação histórica.

Nesse sentido, o Tropy não serviu apenas para ordenar e recuperar documentos com mais eficiência. Seu uso incidiu diretamente na produção do conhecimento histórico, porque a estruturação dos dados tornou visíveis relações, recorrências, contrastes e ausências que dificilmente emergiriam em uma organização improvisada ou puramente física. Ao favorecer a rastreabilidade das fontes, a comparação entre documentos, a atenção à materialidade e a formulação de categorias analíticas mais precisas, o software ampliou a densidade interpretativa da pesquisa e mostrou que o tratamento digital de fontes visuais pode constituir uma etapa central da investigação histórica, e não apenas um apoio técnico ao trabalho do pesquisador.


## Conclusão

A reflexão desenvolvida no decorrer desta lição permite sustentar que o Tropy deve ser compreendido, no âmbito da pesquisa histórica com imagens, como um ambiente de mediação metodológica que incide diretamente sobre a constituição do corpus, sobre a inteligibilidade documental das fontes e sobre a própria formulação dos problemas de investigação. No caso dos Cartazes da Democracia, seu emprego não se limitou à racionalização de procedimentos técnicos de armazenamento e recuperação de arquivos, mas se integrou ao processo de produção do conhecimento ao tornar possível a descrição sistemática dos itens, a criação de metadados personalizados, a comparação relacional entre documentos, a construção de categorias analíticas mais precisas e o registro cumulativo de observações concernentes à materialidade, à circulação e aos usos políticos dos cartazes. Com isso, a organização documental deixou de ocupar um lugar subsidiário no percurso da pesquisa e passou a operar como dimensão constitutiva da interpretação histórica, na medida em que a própria estruturação dos dados tornou visíveis regularidades, ausências, recorrências temáticas e diferenças materiais que exigiram problematização histórica.



### Notas De Fim

[^1]: Vocabulários abertos vinculados (em inglês, Linked Open Vocabularies - LOV) são conjuntos de termos, conceitos e definições estruturados (como tesauros, taxonomias ou listas de autoridade) publicados de forma aberta e interligada na Web, utilizando padrões de dados vinculados (Linked Data). Eles são fundamentais na Web Semântica, pois permitem que máquinas, e não apenas humanos, compreendam o significado dos dados e os conectem com outras fontes de informação. Baseiam-se em tecnologias W3C, como RDF (Resource Description Framework) e SKOS (Simple Knowledge Organization System), permitindo que diferentes sistemas entendam os mesmos termos.

