---
title: "Organizar fontes visuais digitais com Tropy"
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

Pesquisadores que trabalham com fontes visuais digitalizadas frequentemente lidam com conjuntos documentais extensos, compostos por imagens, dados descritivos, notas de pesquisa e diferentes critérios de classificação. Nesses casos, o uso de pastas, editores de texto, planilhas ou programas voltados apenas ao armazenamento de ficheiros tende a limitar a organização sistemática das fontes, a criação de metadados eficientes e o desenvolvimento de formas mais complexas de análise documental.

O Tropy foi desenvolvido para responder a esse tipo de demanda. Criado por pesquisadores e para pesquisadores, o software permite organizar, descrever, classificar, anotar e agrupar fontes visuais digitalizadas em um mesmo ambiente de trabalho. Com isso, o tratamento das imagens deixa de ser apenas uma etapa de armazenamento e passa a integrar de modo mais direto o processo de construção do conhecimento histórico.

Nesta lição, apresento as principais funções do Tropy a partir de um estudo de caso: a pesquisa desenvolvida em minha dissertação de mestrado, defendida no Programa de Pós-Graduação em História da Universidade Federal Fluminense, intitulada *Cartazes da democracia: imagem, política e ação coletiva no Brasil republicano*. O corpus documental é composto por 121 cartazes de cunho político produzidos por movimentos sociais no contexto da Redemocratização do Brasil.

A lição dialoga com “[Gestionar fuentes primarias digitales con Tropy](https://programminghistorian.org/es/lecciones/gestionar-fuentes-primarias-digitales-con-tropy)”, de Douglas McRae, publicada no *Programming Historian* em espanhol, mas constitui uma proposta original ao mobilizar outro conjunto documental e outra experiência de pesquisa. Ao final, espera-se que o leitor seja capaz de criar um projeto no Tropy, importar imagens, trabalhar com metadados, etiquetas e notas, associar múltiplas imagens a um mesmo item, realizar backups e exportar dados para outros usos acadêmicos. Também serão apresentados recursos avançados, como a instalação de plugins e a integração com o Zotero, que permite aproveitar os metadados organizados no Tropy na gestão de referências bibliográficas e documentais.

## Descrição do Tropy

O Tropy é um software livre, gratuito e de código aberto voltado à organização, descrição e gestão de fontes primárias digitalizadas. Desenvolvido inicialmente no Roy Rosenzweig Center for History and New Media, da George Mason University, e posteriormente apoiado por outras instituições dedicadas à pesquisa digital, o programa foi concebido para atender às necessidades de pesquisadores que trabalham com fotografias de documentos, imagens de objetos, materiais de arquivo e coleções digitais. Sua principal proposta é oferecer um ambiente de trabalho capaz de reunir procedimentos de organização documental, descrição, classificação, anotação e recuperação de informações em um único projeto.

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-01.jpg" alt="Visual description of figure image" caption="Figura 1. Imagem da tela inicial do Tropy" %}

O software tem sido amplamente utilizado por pesquisadores das Humanidades, especialmente em investigações que envolvem grandes conjuntos de fontes visuais. Entre seus recursos estão a criação de metadados personalizados, o agrupamento de imagens, o registro de notas de pesquisa e a exportação estruturada dos dados produzidos. Além da aplicação, o projeto disponibiliza documentação técnica, materiais de formação, fórum de usuários e acesso público ao código-fonte. Mais informações podem ser encontradas no [site oficial do Tropy](https://tropy.org/).

## Conjunto de dados

Como mencionado anteriormente, a presente lição utilizará como exemplo um conjunto específico de cartazes. Esses documentos integram a coleção do Centro Pró-Memória da Constituinte (CPMC) [Coleção de cartazes do Centro Pró-Memória da Constituinte (CPMC)](https://atom-museurepublica.museus.gov.br/index.php/29bt-t3yb-gaxa), hoje sob a guarda do Museu da República, no Rio de Janeiro [Acervo digital do Museu da República (AtoM)](https://atom-museurepublica.museus.gov.br/). O acervo reúne materiais relacionados à Assembleia Nacional Constituinte e à participação da sociedade civil, incluindo cartazes de entidades e movimentos populares que atuaram nos debates em torno das Emendas Populares, da Constituinte e da Constituição de 1988. Nesta lição, esse conjunto foi escolhido por oferecer um caso especialmente fértil para demonstrar o uso do Tropy no tratamento de fontes digitais compostas por imagens, permitindo trabalhar com descrição, organização, classificação, notas e metadados em um corpus visual coeso e historicamente situado. Além disso, por se tratar de um conjunto documental já preservado institucionalmente, ele também favorece a discussão de questões metodológicas ligadas à pesquisa com coleções históricas, ao tratamento sistemático de fontes e à construção de procedimentos replicáveis em outros projetos.

## Instalando e configurando o projeto

Para acompanhar esta lição, não é necessário possuir conhecimentos de programação ou experiência prévia com o Tropy. Entretanto, recomenda-se que o leitor tenha familiaridade com operações básicas de informática, como instalar programas, organizar pastas e ficheiros, navegar na internet e transferir imagens para o computador. A lição foi estruturada de modo a permitir que usuários iniciantes conheçam as principais funcionalidades do software e desenvolvam progressivamente suas habilidades de organização e tratamento de fontes visuais digitais. Além dessas operações iniciais, serão apresentados procedimentos mais avançados, como a criação de modelos personalizados de metadados, a instalação de plugins e a integração com o Zotero, que podem ser explorados conforme as necessidades e os conhecimentos prévios de cada pesquisador.

### Instalação

Tropy é um aplicativo para desktop. Para instalá-lo, basta acessar o sítio principal [https://tropy.org/](https://tropy.org/) e clicar no botão "Baixar Tropy para \[nome do sistema detectado automaticamente]”. Em seguida, localize o instalador no seu disco rígido e siga as instruções para o seu sistema operacional (Mac, Windows ou Linux). Você sempre encontrará a versão mais recente, juntamente com versões anteriores e beta, no repositório do [GitHub](https://github.com/tropy) (procure pela tag "Latest").

### Tipo de projeto

Um projeto no Tropy é o ficheiro onde os elementos de bancos de imagens são armazenados, juntamente com seus dados e metadados.

Ao abrir o Tropy pela primeira vez, você precisará nomear e escolher o tipo de projeto. Recomenda-se abordar os projetos da maneira mais abrangente possível: como um manuscrito de livro, uma tese de doutorado ou um tema geral que possa englobar múltiplas possibilidades. Por exemplo, para este projeto, em vez de nomeá-lo com o nome do ficheiro ou repositório, você poderia escolher um nome que reflita um tema geral, como “Cartazes da Democracia”. Você poderá alterar o nome posteriormente dentro do projeto.

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-02.jpg" alt="Visual description of figure image" caption="Figura 2. Tela inicial do projeto novo do Tropy." %}

Você também precisará escolher entre um projeto padrão (.tropy) ou avançado (.tpy).

A diferença está em como o Tropy vincula as imagens ao ficheiro do projeto. Ao importar uma imagem, o Tropy estabelece um caminho entre o projeto e a imagem, exibindo-a na interface do projeto. Em um projeto padrão, o Tropy faz cópias das imagens importadas, salvando-as no diretório do projeto, usando esse local como caminho. Em um projeto avançado, o Tropy usa o local original da imagem como caminho entre ela e o projeto, sem fazer uma cópia.

Com um projeto padrão, realocá-lo é mais fácil: basta transferir a pasta completa do projeto, incluindo as imagens armazenadas. Com um projeto avançado, realocar o ficheiro exigirá restaurar o caminho entre as imagens e o projeto por meio de um processo de consolidação. Para consolidar uma imagem com um caminho corrompido (indicado por um ícone com um ponto de exclamação), basta clicar com o botão direito do mouse, selecionar "Consolidar Item" no menu de contexto e navegar até o novo local da imagem.

O Tropy geralmente solicitará que você vincule novamente outras imagens no mesmo diretório, caso mais imagens precisem ser consolidadas.

### Localizando o projeto

A localização do projeto dependerá do seu tamanho previsto. Se você escolheu um projeto padrão, precisará verificar se há espaço suficiente em seu computador, disco rígido ou pasta na nuvem para armazená-lo.

### Idioma

O Tropy oferece diversas opções de idioma. Você pode escolher seu idioma clicando nos três pontos no topo esquerdo, ao lado da logo do Tropy, indo em Editar > Preferências (ou Ctrl+shift+S no Windows) > Definições > Idioma; em Arquivo > Preferências (no Mac OS) selecionando sua preferência no menu.

## Importando imagens

O processo de importação é como o Tropy estabelece caminhos entre as imagens e o projeto para facilitar a descoberta ou localização das fontes. As imagens podem ser importadas nos seguintes formatos: JPG/JPEG, PNG, SVG, TIFF, GIF, PDF, JP2000, WEBP, HEIC e AVIF.

É possível importar catálogos inteiros em formato PDF. Antes de importar PDFs, é importante verificar a resolução em pixels (ppi) no menu Tropy > Editar > Preferências > Parâmetros. O valor padrão é 72 ppi, o que facilita a importação rápida de PDFs; no entanto, pode reduzir a qualidade da exibição. Se isso for insuficiente, recomenda-se aumentar o valor para 144–288 ppi.

### Importando da rede

O Tropy pode importar imagens estáticas da internet. Arraste a imagem escolhida da janela do seu navegador para a janela principal do Tropy (a visualização do projeto). Se você estiver trabalhando em um projeto padrão, o Tropy criará uma cópia da imagem. Se estiver trabalhando em um projeto avançado, o Tropy definirá um caminho contendo a URL da imagem estática.

No caso dos cartazes do Centro Pró-Memória da Constituinte (CPMC), realizei a digitalização e o registro fotográfico dos documentos durante a pesquisa presencial, armazenando as imagens em formato JPEG no disco rígido do meu computador. Embora reproduções desses cartazes também estejam disponíveis em um ficheiro PDF no catálogo digital do [Museu da República](https://atom-museurepublica.museus.gov.br/index.php/29bt-t3yb-gaxa), esse material não atendia plenamente às necessidades da investigação. Para compreender as condições de produção, circulação e utilização dos cartazes, era necessário examinar suas características materiais, como dimensões, técnicas de impressão e gramatura do papel, além de registrar detalhes específicos, como assinaturas de artistas, marcas de uso e outros vestígios presentes nos documentos. Também fotografei os versos dos cartazes, buscando identificar sinais de fixação em paredes ou murais e outras evidências de sua circulação. Essas informações, fundamentais para a análise histórica das fontes, somente puderam ser obtidas por meio do contato direto com os documentos originais.

### Arrastando imagens

Você pode arrastar imagens do seu computador ou de um dispositivo conectado (como um pen drive, um disco rígido externo ou uma pasta na nuvem) para um projeto do Tropy. Basta arrastar um ficheiro ou um conjunto de ficheiros para a interface principal (a visualização do projeto). O Tropy começará a importá-los para o projeto um por um.

Você também pode selecionar as imagens para importar clicando nos três pontos localizados no canto superior esquerdo da interface do Tropy e, em seguida, acessando Arquivo > Importar > Fotos (Ctrl+shift+I).

### Pastas

Também é possível importar uma pasta de imagens por meio do menu Arquivo > Importar > Pasta.

Crie, em seu computador, uma pasta contendo as imagens originais do projeto. Dessa forma, será possível importá-las para o Tropy e, ao mesmo tempo, manter essa pasta como fonte dos ficheiros. Ao configurar uma pasta monitorada, qualquer ficheiro compatível adicionado a ela será automaticamente importado para o projeto. Diferentemente da importação manual, na qual o usuário precisa selecionar as imagens que deseja acrescentar ao projeto, a pasta monitorada permite que novas imagens sejam incorporadas automaticamente, sem a necessidade de repetir o procedimento de importação. Esse recurso é especialmente útil em pesquisas nas quais novos documentos são digitalizados ou fotografados ao longo do tempo, permitindo atualizar continuamente o conjunto documental. Para realizar essa configuração, utilize o botão “Buscar” (figura 3) e selecione a pasta desejada.

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-03.jpg" alt="Visual description of figure image" caption="Figura 3. Na seção Projeto, dentro de Preferências, é possível designar uma pasta monitorada para facilitar a importação." %}

## Ações em massa

Após importar um conjunto de imagens, é sempre recomendável processá-las e adicionar metadados imediatamente. Esta seção do tutorial descreve algumas das ações em massa que você pode realizar após importar um grupo de imagens.

> NOTA: Ao importar ficheiros grandes para um projeto padrão, o Tropy cria cópias das imagens dentro da pasta do projeto. Caso seja necessário liberar espaço no computador, você pode excluir os ficheiros da pasta monitorada, desde que tenha confirmado que a importação foi concluída corretamente e que os documentos originais estão preservados em outro local, com cópias de segurança. Você pode visualizar as imagens importadas mais recentemente por meio da lista "Última Importação", localizada na barra lateral esquerda da visualização do projeto.

### Orientação

Assim como em muitos aplicativos de edição de imagens, você pode alterar a orientação das imagens. Clique com o botão direito do mouse (ou Control + clique esquerdo no Mac) em uma imagem e selecione Girar para a Direita ou Girar para a Esquerda no menu de contexto. Selecionando várias imagens com a opção Selecionar Tudo (Ctrl + A no Windows, Command + A no Mac), você pode girá-las simultaneamente, facilitando a leitura e a análise das fontes.

### Editando múltiplos campos de metadados

Metadados são, de forma simples, dados sobre outros dados: informações que descrevem, identificam, organizam e contextualizam um documento. No caso de fotografias utilizadas em pesquisa histórica, os metadados ajudam o pesquisador a saber o que a imagem mostra, quando foi produzida, quem a produziu, onde está preservada, em que fundo ou coleção se encontra, qual é sua referência de arquivo e quais temas ela mobiliza. Uma fotografia de uma manifestação política, por exemplo, pode ter como metadados o título atribuído pelo pesquisador, a data aproximada, o local do registro, o nome do fotógrafo ou da instituição responsável, a coleção de origem, a cota arquivística, palavras-chave como “protesto”, “movimento estudantil” ou “ditadura”, e ainda notas sobre elementos visíveis na cena, como faixas, cartazes ou personagens identificáveis. Em pesquisas históricas, esses dados são fundamentais porque permitem localizar a imagem com precisão, recuperar conjuntos documentais semelhantes, cruzar informações entre fontes e transformar um ficheiro de fotografias soltas em um corpus organizado e analiticamente utilizável. Resumindo: trata-se de uma ficha catalográfica digital universal da fonte histórica. Na lateral direita da visualização do projeto se encontra o modelo de metadados.

O modelo pré-configurado Tropy Generic contém um conjunto de propriedades padrão para descrever um objeto de arquivo — outros modelos incluídos no Tropy podem ser selecionados na caixa com o título "item", do lado superior direito da interface do aplicativo. Por exemplo, o modelo para documentos de correspondência — cartas, telegramas e similares — foi desenvolvido especificamente para esse fim. O Tropy também inclui um modelo baseado nos quinze elementos do [Dublin Core](https://pt.wikipedia.org/wiki/Dublin_Core) e outro destinado ao registro de metadados de ficheiros de imagens.

Para revisar e editar os campos de metadados de um objeto, clique em uma imagem e preencha todos os campos desejados. Para revisar e editar os campos de metadados de vários objetos simultaneamente, mantenha pressionada a tecla Ctrl (Windows/Linux) ou Command (Mac) enquanto clica nas imagens desejadas. Para selecionar todos os objetos do projeto ou da lista ativa, utilize Selecionar Tudo (Ctrl+A no Windows/Linux, Command+A no Mac). Você pode editar os campos presentes no modelo predefinido selecionado e as alterações serão aplicadas a todos os objetos selecionados. Da mesma forma, se você editar os campos de metadados de um objeto e, em seguida, selecioná-lo como parte de um conjunto, um símbolo de + aparecerá, indicando que há dados diferentes no mesmo campo para objetos diferentes. Se você modificar esse campo, os novos dados serão aplicados a todos os objetos selecionados.

Os cartazes da democracia não compartilham muitos campos de metadados comuns, mas isso pode ocorrer, dependendo do corpus de pesquisa. Outros campos, como Título, Criador e Data, podem variar de acordo com cada documento. Por isso, o preenchimento dos metadados pode combinar ações em massa, para informações compartilhadas, e descrições individuais, para características específicas de cada cartaz. O desenvolvimento de modelos de metadados personalizados para coleções específicas será explicado posteriormente. Campos adicionais podem ser adicionados a um objeto individual, clicando com o botão direito do mouse (Ctrl+clique no Mac) no modelo de metadados ativo e selecionando Novo Campo no menu. Em seguida, use a barra de pesquisa para encontrar a propriedade mais apropriada. O Tropy contém um grande número de vocabulários de metadados, que serão discutidos posteriormente.

### Combinando / expandindo

O Tropy permite mesclar imagens individuais em objetos com várias imagens. Mesclar imagens significa reunir dois ou mais registros visuais em um único item do projeto, permitindo que sejam consultados em conjunto e associados à mesma descrição documental. Esse procedimento é especialmente útil quando um documento possui diferentes páginas ou quando o pesquisador dispõe de fotografias da frente, do verso e de detalhes de uma mesma fonte histórica. Por exemplo, as diferentes páginas de uma carta ou de um manuscrito, fotografadas separadamente, podem ser reunidas em um único item, preservando sua sequência documental. Para mesclar, selecione as imagens no projeto, abra o menu de contexto (clique com o botão direito no Windows ou Ctrl+clique no Mac) e escolha “Combinar itens selecionados” — a primeira imagem selecionada se tornará a capa do novo objeto mesclado. Como alternativa, se você arrastar uma imagem sobre a outra, elas serão mescladas (com a segunda imagem se tornando a capa). Você pode reorganizar a ordem das imagens no painel abaixo do modelo de metadados, no lado direito da interface.

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-04.png" alt="Visual description of figure image" caption="Figura 4. Resultado da mesclagem de imagens." %}

No caso de um ficheiro PDF com várias páginas, as imagens serão importadas como um objeto mesclado. Em alguns casos, será necessário desconstruir esse objeto, o que pode ser feito selecionando-o e escolhendo “Expandir Item” no menu de contexto. O resultado será a separação das imagens individuais, preservando quaisquer metadados e anotações adicionados anteriormente.

Logo no início da pesquisa, ao acessar o catálogo digital disponibilizado pelo Museu da República, foi possível utilizar esse recurso para importar o ficheiro PDF que reúne os cartazes da coleção. Como o documento continha a reprodução integral do conjunto documental, suas páginas puderam ser desmembradas em entradas individuais no Tropy, permitindo que cada cartaz passasse a constituir um item próprio dentro do projeto.

A partir dessa organização inicial, cada cartaz passou a constituir um item individual no Tropy, criado com base nas reproduções disponíveis no catálogo digital do Museu da República. Essa estrutura permitiu inserir metadados, notas e descrições específicas para cada documento. Posteriormente, as fotografias realizadas durante a pesquisa presencial, incluindo registros do verso, de assinaturas e de outros detalhes materiais, foram incorporadas aos respectivos itens, sem a necessidade de criar novas entradas para cada imagem. Dessa forma, foi possível reunir diferentes registros visuais de uma mesma fonte histórica, mantendo suas informações descritivas e anotações vinculadas a um único item e ampliando as possibilidades de análise documental.

## Descrevendo as imagens

Uma das funções mais importantes do Tropy é descrever as fontes por meio de metadados e anotações. Os metadados permitem registrar informações estruturadas em campos específicos, como título, autoria, data e procedência do documento, enquanto as notas possibilitam acrescentar observações e interpretações do pesquisador em texto livre. Além disso, é possível organizar as imagens com um sistema de etiquetas e listas personalizadas. As etiquetas permitem identificar características ou temas compartilhados por diferentes documentos, enquanto as listas possibilitam agrupá-los segundo critérios definidos pelo pesquisador. Essas funcionalidades, ilustradas na Figura 8, complementam a descrição documental e facilitam a organização, a recuperação e a análise das fontes históricas.

Clicar duas vezes em um objeto (uma imagem individual ou imagens mescladas) alternará o projeto para a visualização de objeto (clique na seta no canto superior esquerdo para retornar à visualização de galeria). Nessa visualização, além de continuar a inserir metadados, você pode editar levemente as imagens do objeto e adicionar notas ou anotações.

O modelo de metadados aparece no lado esquerdo da interface na visualização de objeto.

Essa visualização facilita a análise da imagem e a adição de metadados individuais. É sempre recomendável inserir metadados de forma consistente. Por exemplo, se você inserir o nome do criador (autor) de um ficheiro usando o sobrenome seguido do nome, mantenha esse formato. Da mesma forma, recomenda-se usar o formato de data ISO no campo Data (AAAA-MM-DD); 1730-02-01 se tornará 1º de fevereiro de 1730. O Tropy renderizará a data em um formato legível para organizar as colunas cronologicamente.

### Personalizando metadados

O Tropy inclui um editor para facilitar a criação de modelos de metadados personalizados. Em Editar > Preferências > Modelos (ou Ctrl+shift+S > Modelos), você pode revisar todos os modelos incluídos na instalação, bem como criar um modelo de metadados do zero, conforme ilustrado na Figura 5.

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-05.jpg" alt="Visual description of figure image" caption="Figura 5. Construindo metadados personalizados." %}

Para criar um novo modelo do zero, certifique-se de que "Novo Modelo" apareça no menu suspenso e insira os metadados necessários para identificar o modelo: Nome, Tipo, Criador e Descrição (não é recomendável modificar o URI gerado pelo editor). Em seguida, clique em "Criar". Usando os botões ( + ) e ( - ), você pode adicionar ou remover propriedades do novo modelo. Essas propriedades podem fazer parte de qualquer vocabulário instalado no Tropy: elementos e termos do [Dublin Core](https://pt.wikipedia.org/wiki/Dublin_Core), [vocabulários RDF](https://pt.wikipedia.org/wiki/Resource_Description_Framework), [Modelo de Dados Europeu](https://pt.wikipedia.org/wiki/Europeana) e vocabulários relacionados. O Tropy oferece a flexibilidade de combinar diferentes vocabulários, bem como usar elementos exclusivos do Tropy.

Ao adicionar uma propriedade, você pode modificá-la para especificar o tipo de dados, atribuir um rótulo diferente do nome padrão, adicionar uma dica (por exemplo, "Sobrenome, Nome", para lembrar a ordem em que o nome do autor deve ser registrado) e também definir um valor predefinido. Este último pode ajudar no processamento da origem, por exemplo, ao aplicar um modelo pré-preenchido a uma coleção com várias imagens semelhantes.

No caso dos cartazes do Centro Pró-Memória da Constituinte (CPMC), é possível utilizar as informações disponíveis no catálogo digital do Museu da República como referência para a criação de um modelo de metadados personalizado no Tropy. Para isso, podem ser utilizadas propriedades como Descrição (dc:description), Extensão (dcterms:extent), para registrar as dimensões dos documentos, e Local de Criação (Iptc4xmpExt:LocationCreated), quando essa informação estiver disponível. Outras propriedades podem ser acrescentadas conforme as características do conjunto documental e as necessidades específicas da pesquisa.

Você pode criar um modelo personalizado com base em um modelo existente.

Escolha um modelo no menu suspenso e clique nos dois retângulos que aparecem à direita. O editor criará uma cópia, que você poderá salvar após revisar e confirmar os metadados — por exemplo, renomeando-a. O novo modelo conterá as mesmas propriedades do original, e você poderá adicionar ou remover quaisquer outras que precisar.

Na pesquisa com os cartazes da democracia, o uso de metadados personalizados constituiu um dos pontos cruciais da metodologia. Na primeira fase do trabalho, realizei uma análise detalhada de cada cartaz, levando em conta aspectos materiais e documentais como dimensões, tipo e gramatura do papel, tipo de impressão, instituição responsável por sua produção — neste caso, em grande medida, movimentos sociais de luta popular — e, quando foi possível identificar, também o artista ou fotógrafo responsável pela imagem. Além disso, registrei marcas físicas relevantes, como fitas adesivas, furos, sinais de fixação, dobras e indícios de envio pelo correio. Esse nível de organização tornou possível extrair informações que ultrapassavam o conteúdo visual mais imediato dos cartazes. A observação sistemática desses elementos permitiu levantar hipóteses sobre as condições de produção e circulação dos cartazes, inclusive sobre condições materiais dos grupos e formas de financiamento, a partir da qualidade material empregada, e sobre seus usos concretos, distinguindo, por exemplo, cartazes efetivamente expostos daqueles que permaneceram guardados. Em alguns casos, a presença de carimbos dos Correios confirmou que o envio postal também integrava o universo de circulação dos cartazes políticos, ampliando a compreensão de suas formas de difusão. A Figura 6 apresenta um exemplo dos metadados personalizados utilizados na pesquisa, demonstrando como essas informações foram organizadas no Tropy.

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-06.jpg" alt="Visual description of figure image" caption="Figura 6. Um exemplo de metadados personalizados." %}

### Campos obrigatórios e campos somente leitura

Em modelos pré-configurados, você sempre verá um ícone de sinalização ao lado do campo "Direitos”. Esse ícone serve como um lembrete para preencher o campo. Essa preferência aparece no editor de modelos. Você também pode definir um campo em um modelo personalizado como obrigatório ou somente leitura.

Todos esses parâmetros, juntamente com as dicas, podem ajudar a padronizar os metadados, lembrando quais elementos são mais importantes e como inseri-los para manter a consistência. Eles também podem ser úteis para outros usuários, caso decidam importar um modelo para seus próprios projetos.

### Vocabulários controlados

Na janela Preferências (Ctrl+shift+S), você pode revisar os vocabulários que acompanham o Tropy na opção “vocabulários”. Clique em qualquer esquema para visualizar seus elementos. Você pode adicionar outros vocabulários clicando com o botão esquerdo no botão + na parte inferior da janela. Os esquemas devem estar nos formatos `.n3` ou `.ttl`. Você pode visualizar uma lista extensa de esquemas de vocabulário controlado que podem ser facilmente importados para o Tropy no repositório de [Vocabulários Abertos Vinculados](https://vocabularyserver.com/vocabularies/) (LOV)[^1].

## Editar e anotar imagens

Na visualização de objetos, existem várias ferramentas para alterar a aparência e a legibilidade de uma imagem. Também é possível adicionar anotações tanto a imagens quanto a seleções.

### Edições para facilitar a leitura

Na parte superior da visualização do objeto, encontram-se diversas ferramentas para ajustar e rotacionar a imagem atual. No canto superior direito, está o botão "Editar Foto”, onde, utilizando controles deslizantes, é possível ajustar o brilho, o contraste, a tonalidade, a saturação e a nitidez — tudo com o objetivo de melhorar a legibilidade de documentos desfocados, seja devido ao seu estado ou à qualidade da imagem original. A Figura 7 apresenta as ferramentas de edição de imagens disponíveis no Tropy, permitindo visualizar os recursos mencionados.

Há também uma opção para inverter as cores, um recurso que facilita a leitura de microfilmes ou permite visualizar o negativo de uma fonte visual. 

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-07.jpg" alt="Visual description of figure image" caption="Figura 7. Opções de edição da imagem." %}

### Seleções

Uma das ferramentas mais importantes é a ferramenta de seleção. Clique no quadrado pontilhado na parte superior da visualização do objeto e use a ferramenta de seleção para selecionar uma área da imagem. Após alguns segundos, a seleção aparecerá.

Você pode revisar cada seleção clicando nela ou usando o painel de imagens à esquerda.

### Notas

No campo de notas, você pode adicionar qualquer anotação usando texto formatado. Esse texto também pode ser pesquisado usando a barra de pesquisa na visualização do projeto. Depois de adicionar uma anotação ao campo de notas, retorne à visualização do projeto e digite uma palavra ou frase que você escreveu no campo de notas (por exemplo, "alta gramatura"). Todos os objetos que contêm essa palavra ou frase (ou melhor, esse "valor"), seja no campo de notas ou no modelo de metadados, aparecerão na visualização do projeto. Para retornar à visualização com todos os objetos, limpe o valor digitado na barra de pesquisa. Usando esse recurso, você pode descobrir e agrupar vários objetos na visualização principal, facilitando a conexão entre documentos que mencionam os mesmos termos. É também uma maneira de localizar rapidamente um documento específico com base na transcrição do documento ou nas anotações que você fez.

Dependendo da sua preferência, você pode alterar o modo de exibição do campo de notas de horizontal para lado a lado. Você também pode inserir links no campo de notas. É possível adicionar anotações tanto a seleções quanto a imagens. Para começar, basta digitar no campo de notas; as anotações serão salvas automaticamente no banco de dados do projeto.

## Organizando imagens

Além dos metadados e das notas, o Tropy permite organizar as fontes por meio de listas e etiquetas. Essas ferramentas possibilitam agrupar documentos de acordo com diferentes critérios, como temas de investigação, características compartilhadas ou etapas do trabalho de pesquisa. A Figura 8 apresenta as funcionalidades de organização por listas e etiquetas disponíveis no Tropy.

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-08.jpg" alt="Visual description of figure image" caption="Figura 8. Criando listas e etiquetas de organização." %}

### Listas

As listas funcionam com uma lógica parecida de um diretório de ficheiros com subníveis e objetos. Sempre que você clicar em cima de uma lista específica, ela mostrará todos os seus elementos internos na tela do projeto. Para criar uma lista, clique com o botão direito do mouse (ou Ctrl+clique no Mac) na barra lateral esquerda. Selecione "Nova Lista" no menu de contexto e nomeie a pasta resultante (por exemplo, "Constituinte"). Em seguida, pressione Enter ou clique com o botão esquerdo do mouse. A Figura 8 apresenta um exemplo da organização de documentos por meio de listas no Tropy, permitindo visualizar a disposição dos itens na interface do programa.

Agora, você pode arrastar suas fontes da visualização do Projeto para a nova lista. Você pode adicionar uma fonte a várias listas, incluindo sublistas da lista principal. Para remover um item de uma lista, selecione esta opção no menu de contexto. Se você escolher "Excluir Item", o item será movido para a pasta "Itens Excluídos”. Para criar uma sublista dentro de uma lista, clique com o botão direito do mouse (ou Ctrl+clique no Mac) na lista e selecione "Nova Lista”. Você pode alterar a ordem de uma lista simplesmente arrastando-a para um local diferente dentro das listas; no entanto, seus nomes aparecem em ordem alfabética.

### Etiquetas e rótulos

As etiquetas permitem classificar as fontes a partir de critérios definidos pelo pesquisador, sem a necessidade de utilizar campos estruturados de metadados. Podem ser empregadas para identificar características temáticas relacionadas aos documentos, como “artístico”, “fotográfico” ou “constituinte”, ou ainda para acompanhar diferentes etapas do trabalho, por meio de etiquetas como “Transcrição ausente” e “Metadados completos”. Dessa forma, é possível estabelecer relações entre documentos que compartilham determinadas características, facilitando sua localização e análise.

Existem várias opções para se criar uma nova etiqueta. Selecione um ou mais objetos na visualização do projeto. No lado direito da visualização do projeto, clique no botão Etiquetas para abrir o editor de etiquetas. Clique em Adicionar etiqueta ao objeto X (sendo X o número de objetos selecionados) e digite um nome para a etiqueta. Um ponto aparecerá na barra de etiquetas e também ao lado do título (ou o título exibido na visualização da galeria). Usando o menu de contexto, você pode alterar ou configurar a cor da etiqueta.

## Realizando cópias de segurança do projeto

Durante a pesquisa, é recomendável realizar cópias de segurança periódicas para evitar a perda dos metadados, das notas e das imagens organizadas no Tropy. Para isso, feche o programa, localize o projeto no diretório em que foi salvo e copie seus ficheiros para outro dispositivo de armazenamento, como um disco rígido externo, ou para um serviço de armazenamento na nuvem.

O procedimento depende do tipo de projeto utilizado. Em projetos padrão (.tropy), é necessário copiar a pasta completa do projeto, incluindo as imagens armazenadas. Em projetos avançados (.tpy), além do ficheiro do projeto, é necessário preservar cópias das imagens originais, pois o Tropy mantém vínculos com os locais em que elas estão armazenadas. Caso você tenha criado modelos de metadados personalizados, também é recomendável exportá-los e guardar cópias de segurança.

É importante manter essas cópias atualizadas e verificar periodicamente sua integridade. Dessa forma, será possível preservar o trabalho de organização documental desenvolvido durante a pesquisa.

## Exportando imagens

Você pode exportar imagens individuais, objetos (com ou sem metadados e anotações) e seleções de imagens em vários formatos. Clique com o botão direito do mouse em um objeto na visualização do projeto e selecione “Exportar Item” no menu de contexto. No submenu, você pode escolher [JSON-LD](https://pt.wikipedia.org/wiki/JSON-LD) ou PDF (e, dentro do PDF, pode escolher a orientação retrato ou paisagem). A exportação em formato JSON-LD, com extensão ".json", transmitirá apenas os metadados e as anotações associadas às imagens selecionadas, a imagem em si não será incluída. Para exportar a imagem com os metadados e as anotações, você deve selecionar a opção PDF.

A exportação por este método é semelhante à impressão (Arquivo > Imprimir) em formato PDF. Os parâmetros para imagens exportadas para PDF se encontram em Editar > Preferências > Definições. É possível escolher entre incluir ou não imagens, metadados e notas, bem como ajustar a formatação: otimizar o tamanho e a qualidade das imagens, incluir apenas imagens com notas e permitir que o conteúdo ocupe mais de uma página. A Figura 9 apresenta a tela de preferências do Tropy, na qual é possível configurar os parâmetros de exportação de imagens e documentos em formato PDF.

{% include figure.html filename="pt-or-organizar-fontes-visuais-digitais-com-tropy-09.jpg" alt="Visual description of figure image" caption="Figura 9. Tela de preferências do Tropy." %}

Para exportar uma seleção, encontre o nome da seleção no painel "Fotos", abaixo do modelo de metadados. Clique com o botão direito do mouse (ou Control-clique no Mac) sobre o nome na lista e escolha Exportar Foto no menu de contexto. Você terá duas opções: exportar para um ficheiro ou para a área de transferência. A seleção será exportada em formato .jpg, sem metadados.

## Instalando programas adicionais (plugins)

Plugins, ou programas complementares, são extensões que você pode instalar para facilitar a importação e exportação de imagens e metadados. Os plugins oficiais estão localizados no repositório [GitHub](https://github.com/tropy) do Tropy. Você também pode acessá-los no site do Tropy, na parte inferior da página inicial. Para instalar um, navegue até o repositório e baixe o plugin desejado. Em seguida, na janela de Preferências da sua instalação do Tropy, você deve ativá-lo (veja os passos abaixo). Existem plugins disponíveis para integração com uma instalação do Omeka S, exportação de objetos para o [Zotero](https://www.zotero.org/) (CSL) e exportação em formatos como `.zip` e `.csv`. Além disso, é possível importar ficheiros [IIIF](https://pt.wikipedia.org/wiki/Estrutura_Internacional_para_Interoperabilidade_de_Imagens) e manifestos.

## Integração com o Zotero

O [Zotero](https://www.zotero.org/) é um software livre e gratuito de gerenciamento de referências bibliográficas, que permite organizar fontes de pesquisa, armazenar informações documentais e gerar citações e bibliografias durante a escrita acadêmica.

Em alguns casos, pode ser útil converter os metadados armazenados no Tropy em uma referência compatível com o Zotero. Isso pode auxiliar na organização das fontes e na conexão delas ao processo de escrita. É preciso deixar registrado que este é considerado um uso avançado do Tropy, adequado apenas para determinados usuários.

Antes de começar, vale a pena se perguntar se você realmente precisa importar do Tropy para o Zotero. Se o seu projeto contém documentos arquivados ou manuscritos com uma estrutura de metadados semelhante à de um item do Zotero, ou se o seu projeto contém uma série de objetos com nomes semelhantes que você cita consecutivamente (boletins informativos, jornais, etc.), a importação do Tropy para o Zotero pode ser útil. Em outros casos, pode ser mais fácil trabalhar diretamente com a fonte no Zotero (se for um PDF, você pode usar o leitor de PDF integrado) ou criar manualmente uma referência no Zotero para citá-la em seu trabalho. Os detalhes a seguir explicam como importar os metadados criados no Tropy a partir de um ficheiro para o Zotero.

### Instalando o plugin CSL

1. Baixe a versão mais recente do repositório de plugins do [GitHub](https://github.com/tropy), à direita em Releases (tropy-plugin-csl-vx.x.x.zip).
2. Na sua instalação do Tropy, abra a janela de Preferências (Tropy no Mac ou Editar > Preferências no Windows) e navegue até a seção Plugins. Selecione Instalar Plugin.
3. Selecione o ficheiro .zip baixado do repositório e clique em Ativar na janela Preferências quando ela aparecer.

### Que tipo de elemento você deseja importar para o Zotero?

1. Abra sua instalação do Zotero e crie um item de exemplo que represente uma das fontes utilizadas na pesquisa. No caso dos cartazes do Centro Pró-Memória da Constituinte, você pode selecionar Arquivo > Novo Item > Documento e preencher os campos com informações como o título do cartaz, a autoria, a data de produção e a instituição responsável por sua preservação, neste caso, o Museu da República.
2. No item de exemplo que você criou no Zotero, preencha com valores fictícios (por exemplo, "x") os campos que deseja importar posteriormente do Tropy para o Zotero. Essas propriedades devem ser as mais importantes para a construção de suas referências (Título, Data, Volume, etc.).
3. Clique com o botão direito do mouse no item de exemplo, selecione "Exportar item…" no menu de contexto e escolha o formato CSL JSON (.json) para realizar a exportação.
4. Abra o ficheiro `.json` exportado no seu navegador ou em outro aplicativo de sua preferência e identifique os termos CSL utilizados (em inglês) para cada campo preenchido no Zotero. Anote esses termos, pois serão utilizados na criação do modelo personalizado no Tropy, conforme explicado na próxima seção. Somente os campos preenchidos aparecerão no ficheiro exportado.
 exportado .json (ele será aberto no seu navegador ou outro aplicativo padrão) e anote os termos CSL usados (em inglês) para cada campo que você preencheu anteriormente. Você usará esses termos na etapa 4 da próxima seção. Somente as propriedades com valores em seus respectivos campos aparecerão no ficheiro .json.

### Criando um modelo personalizado no Tropy para importar objetos para o Zotero

1. Na sua instalação do Tropy, acesse a janela de Preferências (Tropy no Mac ou Editar > Preferências no Windows) e selecione Modelos. Escolha o modelo que você usará para os objetos que serão importados para o Zotero.
2. Crie uma cópia deste modelo de metadados.
3. Renomeie a cópia para diferenciá-la no menu Modelos. (Por exemplo: adicione "Zotero" ao nome original).
4. Renomeie os rótulos das propriedades no novo modelo usando os termos CSL identificados no ficheiro `.json` exportado do Zotero, conforme a etapa 4 da seção anterior. Use letras minúsculas e respeite os hífens dos identificadores.
* Para importar com sucesso para o Zotero, seu modelo deve incluir uma propriedade de metadados cujo rótulo seja `type`, com um valor válido do padrão CSL, como `book` (livro), `report` (relatório) ou `document` (documento). No caso dos cartazes do CPMC, pode ser utilizado o valor `document`, correspondente à categoria documental escolhida para o exemplo. Você pode preencher esse campo para cada objeto que pretende importar ou atribuí-lo como um valor predefinido no editor de modelos.
* Nem todos os metadados do Tropy serão importados para o Zotero no mesmo formato: por exemplo, valores de data ou a separação de sobrenomes e nomes. Para importar uma data, recomenda-se usar o termo CSL "issued".
* Se você alterar o idioma local no Tropy, precisará renomear seu modelo de importação do Zotero, substituindo as tags predefinidas pelas tags CSL (inglês).
* NOTA: Atualmente, não há como transferir o texto do campo "Notas" do Tropy para o Zotero. Como alternativa, você pode adicionar uma propriedade de metadados ao seu modelo de exportação com o identificador CSL "note" e, em seguida, copiar e colar manualmente as notas nesse campo. As notas aparecerão no Zotero no campo "Extras" incluído em todos os itens.
5. Aplique o novo modelo aos objetos que deseja importar para o Zotero. \* Pouca coisa deve mudar em termos de valores, pois você está mapeando novas tags em propriedades de metadados preexistentes.
EXPORTANDO OBJETOS TROPY COMO UM FICHEIRO JSON CSL (Para posterior importação no Zotero)
6. Em Editar > Preferências (Ctrl + shift + S), na seção Plugins, selecione CSL e, em seguida, Parâmetros.
7. Adicione uma nova instância do plugin e você poderá dar um nome a ela para diferenciá-la no menu de contexto.
8. Selecione o modelo que você acabou de criar.
9. Lembre-se de que você pode criar vários modelos e opções de exportação para diferentes elementos do Zotero.
10. Retorne à visualização do projeto e clique com o botão direito do mouse no objeto — ou em vários objetos — que você deseja exportar como um ficheiro .json.
11. Selecione Exportar objeto > \[nome da instância do plugin]
12. Dê um nome ao ficheiro .json e salve-o. Se você pretende criar uma nova coleção no Zotero, pode usar esse nome, ao importar, o Zotero gerará uma coleção com o nome do ficheiro.

### Importar para o Zotero

1. Na sua instalação do Zotero, selecione Arquivo > Importar e escolha um ficheiro.
2. Selecione o ficheiro .json exportado e clique em Continuar na caixa de diálogo de importação (você pode decidir se deseja criar uma nova coleção).
3. Clique em Concluído quando a importação estiver finalizada e verifique se os itens recém-importados incluem os campos de metadados desejados. (Caso contrário, retorne à etapa 4 da seção anterior.)
4. A partir daqui você pode gerenciar e citar essas referências por meio da sua instalação do Zotero.

## O Tropy e os Cartazes da democracia

No desenvolvimento da pesquisa sobre os Cartazes da democracia, o uso do Tropy produziu ganhos metodológicos importantes para a organização do corpus e para o tratamento documental das fontes. Ao reunir, ordenar e descrever sistematicamente os cartazes em um mesmo ambiente, o software permitiu transformar um conjunto extenso e heterogêneo de imagens em uma série documental comparável. A criação de metadados personalizados, o registro de notas analíticas, a classificação temática e a associação de múltiplas imagens a uma mesma entrada favoreceram uma leitura mais rigorosa dos documentos, especialmente no que se refere à sua materialidade, circulação e usos políticos.

Esse processo mostrou que o Tropy não serviu apenas para ordenar e recuperar documentos com mais eficiência. A estruturação dos dados tornou visíveis relações, recorrências, contrastes e ausências que dificilmente emergiriam de uma organização improvisada ou exclusivamente física. Desse modo, o tratamento digital das fontes visuais passou a integrar o próprio processo de interpretação histórica, contribuindo para a formulação de categorias analíticas mais precisas e para o amadurecimento das perguntas de pesquisa.

## Conclusão

## Conclusão

No percurso desta lição, foram apresentados os principais recursos do Tropy para importar, organizar, descrever e analisar fontes visuais digitalizadas. A criação de projetos, o uso de metadados personalizados, a associação de múltiplas imagens a um mesmo item e a utilização de notas, listas e etiquetas constituem procedimentos que podem contribuir para o tratamento sistemático de diferentes conjuntos documentais.

A experiência com os cartazes do Centro Pró-Memória da Constituinte (CPMC) demonstra como esses recursos podem ser incorporados à prática da pesquisa histórica, considerando as particularidades das fontes e as questões formuladas pelo pesquisador. Os procedimentos apresentados podem ser adaptados a outros acervos e problemas de investigação, permitindo que a organização digital dos documentos também contribua para a construção de novas possibilidades de análise e interpretação histórica.


### Notas de fim

[^1]: Vocabulários abertos vinculados (em inglês, Linked Open Vocabularies - LOV) são conjuntos de termos, conceitos e definições estruturados (como tesauros, taxonomias ou listas de autoridade) publicados de forma aberta e interligada na Web, utilizando padrões de dados vinculados (Linked Data). Eles são fundamentais na Web Semântica, pois permitem que máquinas, e não apenas humanos, compreendam o significado dos dados e os conectem com outras fontes de informação. Baseiam-se em tecnologias W3C, como RDF (Resource Description Framework) e SKOS (Simple Knowledge Organization System), permitindo que diferentes sistemas entendam os mesmos termos.

