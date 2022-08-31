---
title: Extrair Páginas Ilustradas de Bibliotecas Digitais com Python
slug: extrair-paginas-ilustradas-com-python
layout: lesson
date: 2019-01-14
translation_date: 2021-10-04
authors:
- Stephen Krewson
reviewers:
- Catherine DeRose
- Taylor Arnold
editors:
- Anandi Silva Knuppel
translator:
- João Pereira 
translation-editor:
- Eric Brasil
translation-reviewer:
- A INDICAR
- A INDICAR
review-ticket: A INDICAR
difficulty: 2
activity: acquiring
topics: [api]
abstract: A aprendizagem automática e as extensões de API do HathiTrust e do Internet Archive estão a tornar mais fácil a extração de regiões de página com interesse visual de volumes digitalizados. Esta lição mostra como extrair eficientemente essas regiões e, ao fazê-lo, como fomentar novas questões sobre a pesquisa visual.
avatar_alt: Instrumento Científico de Medição
original: extracting-illustrated-pages
doi: A INDICAR
---

{% include toc.html %}


# Visão Geral

E se apenas quiser ver as imagens num livro? Este é um pensamento que já ocorreu tanto a jovens crianças como a pesquisadores adultos. Se souber que o livro está disponível através duma biblioteca digital, seria útil fazer o *download* somente das páginas com imagens e ignorar o resto.

Aqui estão as miniaturas de página para um volume do HathiTrust com o identificador exclusivo `osu.32435078698222`. Após o processo descrito nesta lição, fez-se o *download* apenas das páginas com imagens (31 no total) como JPEGs para uma pasta.

{% include figure.html filename="file-explorer-example.png" caption="Visualização dum volume para o qual apenas se fez o *download* das páginas com imagens." %}

Para ver quantas páginas *não ilustradas* foram filtradas, compare com o [conjunto total de miniaturas](https://babel.hathitrust.org/cgi/pt?id=osu.32435078698222;view=thumb;seq=1) para todas as 148 páginas nesta edição revista de 1845 do livro infantil *bestseller* de Samuel Griswold Goodrich, *The Tales of Peter Parley About America* (1827).

{% include figure.html filename="parley-full-thumbnails.png" caption="Visualização das miniaturas do HathiTrust para todas as páginas." %}

Esta lição mostra como completar estas etapas de filtragem e de *download* para volumes de texto em domínio público disponibilizados pelo HathiTrust (HT) e pelo Internet Archive (IA), duas das maiores bibliotecas digitais no mundo. A lição será relevante para quem deseje criar coleções de imagens com o fim de aprender sobre a História da Ilustração e o *layout* (*mise en page*) dos livros. As abordagens visuais à bibliografia digital estão a tornar-se populares, seguindo os esforços pioneiros do [EBBA](https://ebba.english.ucsb.edu/) e do [AIDA](http://projectaida.org/). Projetos recentemente concluídos ou financiados exploram maneiras de [identificar notas de rodapé](https://web.archive.org/web/20190526050917/http://culturalanalytics.org/2018/12/detecting-footnotes-in-32-million-pages-of-ecco/) e [rastrear marginália](http://www.ccs.neu.edu/home/dasmith/ichneumon-proposal.pdf), para dar só dois [exemplos](https://www.neh.gov/divisions/odh/grant-news/announcing-new-2017-odh-grant-awards).

A minha própria pesquisa tenta esclarecer questões empíricas sobre alterações na frequência e modo de ilustração em textos médicos e educacionais do século XIX. Isto envolve agregar acervos de imagens por livro e tentar estimar que processo de impressão foi usado para fazer tais imagens. Um caso de uso mais direcionado para extrair páginas ilustradas pode ser a catalogação de ilustrações ao longo de [diferentes edições](https://www.cambridge.org/core/books/cambridge-companion-to-robinson-crusoe/iconic-crusoe-illustrations-and-images-of-robinson-crusoe/B83352C33FB1A9929A856FFA8E2D0CD0/core-reader) do mesmo livro. Trabalhos futuros poderão pesquisar com sucesso as características visuais e o *significado* das imagens extraídas: a sua cor, o seu tamanho, o seu tema, o seu género, o número de figuras e assim por diante.

Como obter informação *localizada* sobre regiões visuais de interesse está para além do âmbito desta lição, visto que o processo envolve bastante aprendizagem automática (*machine learning*). No entanto, a classificação sim/não de páginas com (ou sem) imagens é um primeiro passo prático para reduzir o volume de *todas* as páginas para cada livro numa coleção visada e, assim, tornar a localização de ilustrações possível. Para dar um ponto de referência, os textos médicos do século XIX contêm (em média) ilustrações em 1-3% das suas páginas. Se estiver a tentar estudar a ilustração no interior dum *corpus* duma biblioteca digital sobre o qual não tem qualquer informação preexistente, é, consequentemente, razoável assumir que 90+% das páginas nesse *corpus* NÃO estarão ilustradas.

O HT e o IA permitem que a questão imagens/nenhuma imagem seja respondida indiretamente através da análise dos dados gerados pelo *software* de *optical character recognition*, ou reconhecimento ótico de caracteres, em português (reconhecimento ótico de caracteres) (o OCR é aplicado após um volume físico ser digitalizado com o objetivo de gerar uma transcrição do texto muitas vezes desordenada). Aproveitar o resultado de OCR para encontrar páginas ilustradas foi proposto pela primeira vez por Kalev Leetaru numa [colaboração de 2014](https://blog.gdeltproject.org/500-years-of-the-images-of-the-worlds-books-now-on-flickr/) com o Internet Archive e o Flickr. Esta lição transfere a abordagem de Leetaru para o HathiTrust e tira proveito de bibliotecas de processamento de XML mais rápidas no Python, bem como da gama recentemente ampliada de formatos de ficheiro de imagem do IA.

Uma vez que o HT e o IA expõem a sua informação derivada de OCR de maneiras ligeiramente diferentes, eu irei apresentar os detalhes das "características visuais" de cada biblioteca em secções independentes.


# Objetivos

No final da lição, o leitor será capaz de:

- Configurar a distribuição do Python Anaconda na versão "mínima" (Miniconda) e criar um ambiente;
- Salvar e iterar sobre uma lista de IDs de volumes do HT ou do IA gerados por uma pesquisa;
- Aceder aos *application programming interfaces* (interfaces de programação de aplicações) (APIs) de dados do HT e do IA através das bibliotecas do Python;
- Encontrar características visuais ao nível da página;
- Fazer o *download* dos JPEGs de páginas programaticamente.

O grande objetivo é fortalecer as competências de coleta e exploração de dados criando um *corpus* de ilustração histórica. Combinar dados de imagens com metadados de volumes permite a formulação de questões de pesquisa promissoras sobre a mudança visual ao longo do tempo.


# Requisitos

Os requisitos de *software* desta lição são mínimos: o acesso a uma máquina executando um sistema operacional padrão e um navegador de internet. A Miniconda está disponível em versões de 32 e de 64 *bits* para Windows, macOS e Linux. O Python 3 é a versão estável atual da linguagem e será suportado indefinidamente[^instalarpython].

Este tutorial assume um conhecimento básico da linha de comando e da linguagem de programação Python. O leitor deve compreender as convenções para comentários e comandos num tutorial baseado num *shell*. Eu recomendo a [*Introduction to the Bash Command Line*](https://programminghistorian.org/en/lessons/intro-to-bash), de Ian Milligan e James Baker, para aprender ou para rever as suas competências com a linha de comando.


# Configuração

## Dependências

Leitores mais experientes podem querer simplesmente instalar as dependências e executar os *notebooks* no seu ambiente de escolha. Mais informações sobre a minha própria configuração da Miniconda (e algumas diferenças do Windows/*nix) são providenciadas.

Nota de tradução: Para instalar as dependências, altere o seu diretório de trabalho para a pasta onde se encontra o Python com o comando `cd` e, depois, execute o comando `pip install` ou `pip3 install` seguido de:

- `hathitrust-api` ou `hathitrust_api` ([Instalar documentos](https://github.com/rlmv/hathitrust-api));
- `internetarchive` ([Instalar documentos](https://archive.org/services/docs/api/internetarchive/));
- `jupyter` ([Instalar documentos](https://jupyter.org/install));
- `requests` ([Instalar documentos](https://requests.readthedocs.io/en/master/)) [o criador recomenda a instalação do`pipenv`; para a instalação do `pip`, ver [PyPI](https://pypi.org/project/requests2/)].

## Ficheiros da Lição

Faça o *download* desta [pasta comprimida](/assets/extracting-illustrated-pages/lesson-files.zip) que contém dois *Jupyter notebooks*, um para cada uma das bibliotecas digitais. A pasta também contém um ficheiro de metadados JSON de amostra descrevendo uma coleção do HathiTrust. Descomprima e confirme que os seguintes ficheiros estão presentes: `554050894-1535834127.json`, `hathitrust.ipynb` e `internetarchive.ipynb`.

<div class="alert alert-warning">
Todos os comandos subsequentes assumem que o seu atual diretório de trabalho é a pasta que contém os ficheiros da lição.
</div>


### Destino do *Download*

Aqui está o diretório padrão que será criado assim que todas as células em ambos os *notebooks* forem executadas (como providenciado). Depois de obter uma lista de quais páginas num volume contêm imagens, as funções de *download* do HT e do IA solicitam essas páginas como JPEGs (nomeadas pelo número de página) e arquivam-nas em subdiretórios (nomeados pelo ID do item). É claro que o leitor pode usar diferentes listas de volumes ou mudar o destino `out_dir` para algo que não `items`.

```
items/
├── hathitrust
│   ├── hvd.32044021161005
│   │   ├── 103.jpg
│   │   └── ...
│   └── osu.32435078698222
│       ├── 100.jpg
│       ├── ...
└── internetarchive
    └── talespeterparle00goodgoog
        ├── 103.jpg
        └── ...

5 diretórios, 113 ficheiros
```

As funções de *download* são lentas; se executar os *notebooks* novamente, com o diretório `items` similar ao que se apresenta em cima, qualquer item que já tem a sua própria subpasta será ignorado.


## Anaconda (opcional)

Anaconda é a principal distribuição científica do Python. O seu gestor de pacote `conda` permite-lhe instalar bibliotecas como a `numpy` e a `tensorflow` com facilidade. A versão "Miniconda" não é acompanhada por quaisquer pacotes supérfluos pré-instalados, o que o incentiva a manter o seu ambiente de base limpo e a instalar apenas o que o leitor necessita para um projeto dentro dum ambiente específico.

Faça o *download* e instale o [Miniconda](https://conda.io/miniconda.html). Escolha a versão estável mais recente do Python 3. Se tudo correr bem, o leitor conseguirá executar `which conda` (linux/macOS) ou `where conda` (Windows) no seu *shell* e ver a localização do programa executável no *output*.

Anaconda tem uma  [*cheat sheet*](http://web.archive.org/web/20190115051900/https://conda.io/docs/_downloads/conda-cheatsheet.pdf) útil para comandos de uso frequente.

### Criar um Ambiente

Os ambientes, entre outras coisas, ajudam a controlar a complexidade associada ao uso de múltiplos gestores de pacote em conjunto. Nem todas as bibliotecas do Python podem ser instaladas através do `conda`. Em alguns casos, nós recorreremos ao gestor de pacote padrão do Python, o `pip` (ou alterações planeadas, como o `pipenv`). No entanto, quando o fizermos, nós usaremos uma versão do `pip` instalada pelo `conda`. Isto mantém todos os pacotes que precisamos para o projeto no mesmo espaço virtual.

```bash
# o seu ambiente atual é precedido de um asterisco 
# (será "base" num novo shell)
conda env list

# verificar os pacotes instalados no ambiente atual 
conda list
```

Agora nós criamos um ambiente específico, configuramo-lo para usar Python 3, e ativamo-lo.

```bash
# observe a sinalização --name que recebe um argumento de string (e.g. "extract-pages") 
# e a sintaxe para especificar a versão do Python
conda create --name extract-pages python=3

# entrar no/ativar o novo ambiente (em macOS/Linux)
source activate extract-pages
```

```bash
# o comando do Windows para entra no/ativar o ambiente é um pouco diferente 
conda activate extract-pages
```

Para sair dum ambiente, execute `source deactivate` no macOS/Linux ou `deactivate` no Windows. Mas por agora certifique-se de permanecer no ambiente `extract-pages` durante a lição!

### Instalar os Pacotes da Conda

Nós podemos usar a `conda` para instalar os nossos primeiros pacotes. Todos os outros pacotes necessários (gzip, json, os, sys e time) fazem parte da [biblioteca padrão do Python](https://docs.python.org/3/library/). Note como nós precisamos de especificar um canal em alguns casos (canais são locais onde o navegador de internet e o `conda` procuram pacotes). O leitor pode pesquisar por pacotes na [Anaconda Cloud](https://anaconda.org/).


```bash
# para garantir que temos uma versão local do pip (veja a discussão abaixo)
conda install pip

conda install jupyter

conda install --channel anaconda requests
```

O Jupyter tem muitas dependências (outros pacotes dos quais depende), por isso esta etapa pode exigir alguns minutos. Recorde-se que quando o `conda` lhe pergunta se deseja continuar com a instalação (`Proceed ([y]/n)?`), o leitor deve digitar um `y` ou `yes` e, depois, pressionar *Enter* para aceitar a instalação do pacote.

<div class="alert alert-warning">
Nos bastidores, o <code>conda</code> está a trabalhar para certificar-se que todos os pacotes e dependências necessários serão instaladas numa maneira compatível.
</div>


### Instalar Pacotes do Pip

Se estiver a usar um ambiente `conda`, é melhor usar a versão local do `pip`. Confirme que os seguintes comandos dão como resultado um programa cujo caminho absoluto contém algo como `/Miniconda/envs/extract-pages/Scripts/pip`.

```bash
which pip
```

```bash
# o equivalente Windows do "which"
where pip
```

Se vir duas versões do `pip` no *output* acima, certifique-se de digitar o caminho absoluto para a versão *local* do ambiente ao instalar as bibliotecas *wrapper* do API:

```bash
pip install hathitrust-api
pip install internetarchive
```

```bash
# exemplo do Windows usando o caminho absoluto para o executável do pip *local* 
C:\Users\stephen-krewson\Miniconda\envs\extract-pages\Scripts\pip.exe install hathitrust-api internetarchive
# substitua "stephen-krewson" pelo nome do diretório onde instalou o Miniconda
```

## *Jupyter Notebooks*

O [*Text Mining in Python Through the HTRC Feature Reader*](https://programminghistorian.org/en/lessons/text-mining-with-extracted-features#start-a-notebook), de Peter Organisciak e Boris Capitanu, explica os benefícios dos *notebooks* para o desenvolvimento e a exploração de dados. Também contém informação útil sobre como executar eficazmente as células. Visto que nós instalámos a versão minimalista da Anaconda, nós precisamos de iniciar o Jupyter a partir da linha de comandos. No seu *shell* (a partir do interior da pasta contendo os ficheiros da lição; nota de tradução: use o comando `cd NOME-DA-PASTA` para ir para a pasta onde estão os ficheiros) execute `jupyter notebook`.

Isto executará o servidor do *notebook* no seu *shell* e iniciará o seu navegador de internet pré-definido com a página inicial do Jupyter[^comandojupyternotebook]. A página inicial mostra todos os ficheiros no diretório de trabalho atual.

{% include figure.html filename="jupyter-home.png" caption="A página inicial do Jupyter mostrando os ficheiros da lição." %}

<div class="alert alert-warning">
No seu shell, certifique-se que usou o comando <code>cd</code> para ir até ao diretório descomprimido <code>lesson-files</code>.
</div>

Clique nos *notebooks* `hathitrust.ipynb` e `internetarchive.ipynb` para abri-los em novos separadores do navegador de internet. A partir daqui, nós não precisamos de executar qualquer comando no *shell*. Os *notebooks* permitem-nos executar o código Python e ter acesso total ao sistema de pastas do computador. Quando o leitor tiver terminado, pode parar o servidor do *notebook* carregando em "*Quit*" na página inicial do Jupyter ou executando `ctrl+c` no *shell*.


# HathiTrust

## Acesso ao API

O leitor precisa de efetuar um registro no HathiTrust antes de usar o Data API. Dirija-se ao [portal de registro](https://babel.hathitrust.org/cgi/kgs/request) e preencha o seu nome, a sua organização, e o e-mail para requerer chaves de acesso. O leitor deverá receber uma resposta no e-mail dentro de cerca dum minuto  (nota de tradução: verifique também a caixa de Spam). Clique no link, que o trará a uma página temporária com ambas as chaves (*tokens*) exibidas.

No *notebook* `hathitrust.ipynb`, examine a primeira célula (mostrada em baixo). Preencha as suas chaves de API como indicado. Depois, execute a célula clicando em "*Run*" na barra de navegação do *notebook*.

```python
# Importe o wrapper da API dos dados do HT
from hathitrust_api import DataAPI

# Substitua as strings padrão com as suas credenciais do HT (deixando as aspas)
ht_access_key = "YOUR_ACCESS_KEY_HERE"
ht_secret_key = "YOUR_SECRET_KEY_HERE"

# Instancie  o objeto de conexão da API dos dados
data_api = DataAPI(ht_access_key, ht_secret_key)
```

<div class="alert alert-warning">
Cuidado! Não exponha as suas chaves de acesso através dum repositório público no GitHub (ou outro *host* de controlo de versões). Eles serão pesquisáveis por qualquer outra pessoa. Uma boa prática para um projeto Python é a de armazenar as suas chaves de acesso como variáveis de ambiente ou salvá-los num ficheiro que não é *versionado*.
</div>


## Criar uma Lista de Volumes

O HT permite a qualquer um fazer uma coleção de itens&mdash;o leitor nem sequer tem que estar na sua conta! No entanto, o leitor deveria registrar uma conta, se quiser salvar a sua lista de volumes. Siga as [instruções](https://babel.hathitrust.org/cgi/mb?colltype=updated) para fazer algumas pesquisas no texto completo e para, depois, adicionar resultados escolhidos a uma coleção. Atualmente, o HathiTrust não tem um API de pesquisa pública para adquirir volumes programaticamente; o leitor precisa de pesquisar a partir da sua *interface* de internet.

Ao atualizar uma coleção, o HT mantém o rastro dos metadados associados para cada item nela. Eu incluí nos ficheiros da lição os metadados para uma lição de amostra no formato JSON. Se quisesse usar o ficheiro da sua própria coleção do HT, o leitor navegaria até à página das suas coleções e colocaria o cursor do *mouse* sobre o link dos metadados à esquerda para revelar a opção de *download* como JSON, como observado na seguinte captura de tela.

{% include figure.html filename="download-ht-json.png" caption="Captura de tela de como fazer o *download* dos metadados de coleções no formato JSON." %}

Assim que o leitor tiver feito o *download* do ficheiro JSON, basta movê-lo para o diretório onde colocou os *Jupyter notebooks*. Substitua o nome do ficheiro JSON no *notebook* do HT com o nome do ficheiro da sua coleção.

O *notebook* mostra como usar uma 'compreensão de lista' para obter todas as *strings* `htitem_id` dentro do objeto `gathers` que contêm todas as informações da coleção.

```python
# Pode especificar o ficheiro de metadados da sua coleção aquimetadata_path = "554050894-1535834127.json"

with open(metadata_path, "r") as fp:
    data = json.load(fp)

# Uma lista de todas as ids exclusivas na coleção
vol_ids = [item['htitem_id'] for item in data['gathers']]
```

<div class="alert alert-warning">
Os tutoriais normalmente mostram-lhe como processar um item de exemplo (muitas vezes de tamanho ou complexidade trivial). Isto é pedagogicamente conveniente, mas significa que o leitor está menos equipado para aplicar esse código a múltiplos itens&mdash;de longe o caso de uso mais comum. Nos *notebooks*, o leitor verá como encapsular transformações aplicadas a um item em <i>funções</i> que podem ser usadas num *loop* sobre uma coleção de itens.
</div>

## Característica Visual: IMAGE_ON_PAGE

Dada uma lista de volumes, nós queremos explorar que características visuais eles têm ao nível de página. A [documentação mais recente](https://www.hathitrust.org/documents/hathitrust-data-api-v2_20150526.pdf) (2015) para o Data API descreve um objeto metadados chamado `htd:pfeat` nas páginas 9-10. `htd:pfeat` é a abreviação para "HathiTrust Data API: Page Features."

> * `htd:pfeat`­ - a chave de caracterização da página (se disponível):
>    - CHAPTER_START
>    - COPYRIGHT
>    - FIRST_CONTENT_CHAPTER_START
>    - FRONT_COVER
>    - INDEX
>    - REFERENCES
>    - TABLE_OF_CONTENTS
>    - TITLE

O que o *wrapper* `hathitrust-api` faz é disponibilizar os metadados completos para um volume do HT como um objeto Python. Dado o identificador dum volume, nós podemos pedir os seus metadados e, depois, fazer o *drill-down* através da *sequência* de páginas até à informação ao nível de página. A *lista* `htd:pfeat` está associada com cada página num volume e, em teoria, contém todas as características que se aplicam a essa página. Na prática, existem mais algumas *tags* de características além das oito listadas acima. Aquela com a qual nós iremos trabalhar chama-se `IMAGE_ON_PAGE` e é mais abstratamente visual que *tags* estruturais como `CHAPTER_START`.

Tom Burton-West, um bibliotecário pesquisador na biblioteca da *University of Michigan*, trabalha em estreita colaboração com o HathiTrust e o HTRC, o Centro de Pesquisa do HathiTrust. O Tom disse-me por e-mail que o HathiTrust recebe a informação `htd:pfeat` via o Google, com o qual trabalham proximamente desde a fundação do HT, em 2008. Um contacto no Google deu permissão ao Tom para partilhar o seguinte:

> Estas *tags* são derivadas duma combinação de Heurística, aprendizagem automática e anotação humana.

Um exemplo heurístico pode ser o facto do primeiro elemento na sequência de páginas do volume ser quase sempre a `FRONT_COVER`. A aprendizagem automática pode ser usada para treinar modelos a discriminar, digamos, entre dados de imagem que são mais típicos de linhas de prosa num texto ocidental ou de linhas numa gravura. A anotação humana é a atribuição manual de etiquetas a imagens. A habilidade de ver as ilustrações dum volume nos bancos de dados do EEBO e do ECCO é um exemplo de anotação humana.

O uso da "aprendizagem automática" pelo Google parece um pouco misterioso. Até o Google publicitar os seus métodos, é impossível saber todos os detalhes. No entanto, é provável que as *tags* `IMAGE_ON_PAGE` tenham sido propostas pela primeira vez detetando blocos de "Imagens" nos ficheiros de *output* de OCR (um processo discutido abaixo, na secção do Internet Archive). Mais filtragem pode, então, ser aplicada.


## Passo a Passo Para o Código

### Encontrar imagens

Nós vimos como criar uma lista de volumes e observámos que o Data API pode ser usado para obter objetos metadados contendo características experimentais ao nível da página. A principal função no *notebook* do HT tem a assinatura digital `ht_picture_download(item_id, out_dir=None)`. Dado um identificador exclusivo e um diretório de destino opcional, esta função obterá, primeiro, os metadados do volume do API e convertê-los-á num formato JSON. Depois, percorre a sequência da página e confirma que a *tag* `IMAGE_ON_PAGE` está na lista `htd:pfeat` (se existir).

```python
# Metadados da API no formato JSON (diferente da coleção de metadados do HT)
meta = json.loads(data_api.getmeta(item_id, json=True))

# A sequência dá-nos cada página do item digitalizado em ordem, com qualquer
# informação adicional que pode estar disponível para ela
sequence = meta['htd:seqmap'][0]['htd:seq']

# Lista de páginas com imagens (vazio para a iniciação)
img_pages = []

# O bloco try/except lida com situações onde nenhuma "pfeats" existe OU
# os números da sequência não são numéricos
for page in sequence:
    try:
        if 'IMAGE_ON_PAGE' in page['htd:pfeat']:
            img_pages.append(int(page['pseq']))
    except (KeyError, TypeError) as e:
        continue
```

Note que nós precisamos de fazer o *drill-down* por vários níveis até ao objeto do nível de topo para obter o objeto `htd:seq`, sobre o qual nós podemos iterar.

As duas opções que eu quero evitar são o `KeyError`, que ocorre quando a página não tem qualquer característica ao nível de página a si associadas, e o `TypeError`, que ocorre quando o campo `pseq` para a página é, por alguma razão, não numérico e, portanto, não pode ser destinado a um `int`. Se algo ocorrer de errado com uma página, nós simplesmente damos a instrução `continue` para a próxima. O plano é obter todos os dados bons que conseguimos. Não queremos limpar inconsistências ou falhas nos metadados do item.

### Fazer o *Download* de Imagens

Assim que `img_pages` contém a lista completa de páginas com a *tag* `IMAGE_ON_PAGE`, nós podemos fazer o download dessas páginas. Note que, se `out_dir`não for fornecido a `ht_picture_download()`, então a função simplesmente retorna a lista `img_pages` e NÃO faz o *download* do quer que seja.

A chamada do API `getpageimage()` retorna um JPEG por padrão. Nós simplesmente colocamos os bytes do JPEG num ficheiro na forma normal. Dentro da subpasta do volume (ela própria dentro do `out_dir`), as páginas serão nomeadas `1.jpg` para a página 1 e assim sucessivamente.

Uma coisa a considerar é a nossa taxa de uso do API. Nós não queremos abusar do nosso acesso ao fazer centenas de pedidos por minuto. Para estar a salvo, especialmente se quisermos executar grandes trabalhos, nós esperamos dois segundos antes de fazer cada pedido de página. Isto pode ser frustrante a curto prazo, mas ajuda a evitar o estrangulamento ou a proibição do API.


```python
for i, page in enumerate(img_pages):
    try:
	# Uma simples mensagem de estado
        print("[{}] Downloading page {} ({}/{})".format(item_id, page, i+1, total_pages))

        img = data_api.getpageimage(item_id, page)

        # N.B. o loop só executa se out_dir não é None
	img_out = os.path.join(out_dir, str(page) + ".jpg")

        # Coloque a imagem
        with open(img_out, 'wb') as fp:
            fp.write(img)

        # para evitar exceder o uso da API permitido
        time.sleep(2)

    except Exception as e:
        print("[{}] Error downloading page {}: {}".format(item_id, page,e))
```


# Internet Archive

## Acesso ao API

Nós conectamos à biblioteca API do Python usando uma conta do Archive.org com e-mail e palavra-chave ao invés das chaves de acesso do API. Isto é discutido no [Guia Quickstart](https://archive.org/services/docs/api/internetarchive/quickstart.html). Se não tiver uma conta, [registre-se](https://archive.org/account/login.createaccount.php) para o seu "Virtual Library Card".

Na primeira célula do *notebook* `internetarchive.ipynb`, introduza as suas credenciais como indicado. Execute a célula para autenticar-se perante a API.

## Criar uma Lista de Volumes

A biblioteca IA do Python permite-lhe submeter *query strings* e receber uma lista de pares chave-valor correspondentes na qual a palavra "*identifier*" é a chave e o verdadeiro identificador é o valor. A sintaxe para uma *query* é explicada na [página de Advanced Search](https://archive.org/advancedsearch.php) para o IA. O leitor pode especificar parâmetros ao usar uma palavra-chave como "*date*" ou "*mediatype*" seguida de dois pontos e o valor que quer designar para o parâmetro. Por exemplo, eu só quero resultados que são *textos* (em oposição a vídeos, *etc.*). Certifique-se que os parâmetros e as opções que está a tentar usar são suportadas pela funcionalidade de pesquisa do IA. Caso contrário, pode perder resultados ou obter resultados estranhos e não saber porquê.

No *notebook*, eu gero uma lista de ids do IA ids com o seguinte código:

```python
# Uma pesquisa de amostra (deve gerar dois resultados)
query = "peter parley date:[1825 TO 1830] mediatype:texts"
vol_ids = [result['identifier'] for result in ia.search_items(query)]
```

## Característica Visual: Blocos de Imagens

O Internet Archive não apresenta quaisquer características ao nível de página. Ao invés, disponibiliza um certo número de ficheiros brutos do processo de digitalização aos utilizadores. O mais importante destes para os nossos propósitos é o ficheiro XML Abbyy. Abbyy é uma empresa russa cujo *software* FineReader domina o mercado de OCR.

Todas as versões recentes do FineReader produzem um [documento XML](https://en.wikipedia.org/wiki/XML) que associa diferentes "blocos" com cada página no documento digitalizado. O tipo de bloco mais comum é `Text` mas também existem blocos `Picture` ("Imagem"). Aqui está um bloco de exemplo tirado dum ficheiro de XML Abbyy do IA. Os cantos superior esquerdo ("t" e "l") e inferior direito ("b" e "r") são suficientes para identificar a região de bloco retangular.


```xml
<block blockType="Picture" l="586" t="1428" r="768" b="1612">
	<region><rect l="586" t="1428" r="768" b="1612"></rect></region>
</block>
```

O equivalente no IA a ver as *tags* `IMAGE_ON_PAGE` no HT é a análise do ficheiro XML Abbyy e iterar sobre cada página. Se existir pelo menos um bloco `Picture` nessa página, a página é sinalizada como possivelmente contendo uma imagem.

Enquanto a característica `IMAGE_ON_PAGE` do HT não contém informação sobre a *localização* dessa imagem, os blocos `Picture` no ficheiro XML do IA estão associados a uma região retangular na página. No entanto, porque o FineReader se especializa no reconhecimento de letras de conjuntos de caracteres ocidentais, é muito menos preciso a identificar regiões de imagem. O projeto de Leetaru (ver Visão Geral) usou as coordenadas da região para cortar imagens, mas nesta lição nós iremos simplesmente fazer o *download* da página inteira.

Parte da diversão intelectual desta lição é usar um *dataset* (*tags* de bloco de OCR) por vezes confuso para um propósito largamente não intencional: identificar imagens e não palavras. A certo altura, tornar-se-á computacionalmente viável executar modelos de aprendizagem aprofundada em todas as páginas ilustradas brutas num volume e escolher o(s) tipo(s) de imagem(/ns) desejada(s). Mas, como a maior parte das páginas na maioria dos volumes são não ilustradas, esta é uma tarefa exigente. Por agora, faz mais sentido aproveitar os dados existentes que nós temos do processo de ingestão de OCR.

Para mais informações sobre como o próprio OCR funciona e interage com o processo de digitalização, por favor, veja a lição do PH de Mila Oiva [OCR With Tesseract and ScanTailor](https://programminghistorian.org/en/lessons/retired/OCR-with-Tesseract-and-ScanTailor). Erros podem surgir por causa de distorções, artefactos e muitos outros problemas. Estes erros acabam por afetar a confiabilidade e a precisão dos blocos "Picture". Em muitos casos, Abbyy estimará que páginas em branco ou descoloridas são, na realidade, imagens. Estas *tags* de bloco incorretos, ainda que indesejados, podem ser combatidas com o uso de redes neurais convolucionais retreinadas. Pense nas páginas com imagens cujo o download foi feito nesta lição como um primeiro passo num processo mais longo para obter um *dataset* limpo e útil de ilustrações históricas.


## Passo a Passo do Código

### Encontrar Imagens

Tal como com o HT, a função principal para o IA é `ia_picture_download(item_id, out_dir=None)`.

Visto que envolve o I/O dum ficheiro, o processo para obter a lista `img_pages` é mais complicado do que aquele para o HT. Usando a utilidade da linha de comando `ia` (que é instalada com a biblioteca), o leitor pode obter uma ideia dos ficheiros de metadados disponíveis para um volume. Com muitas poucas exceções, um ficheiro com o formato "Abbyy GZ" deveria estar disponível para volumes com o tipo de *media* `text` no Internet Archive.

Estes ficheiros, mesmo quando comprimidos, podem facilmente ter centenas de megabytes de tamanho! Se existir um ficheiro Abbyy para o volume, nós obtemos o seu nome e depois fazemos o *download*. A chamada `ia.download()` usa alguns parâmetros úteis para ignorar o pedido se o ficheiro já existe e, se não, fazer o seu *download* sem criar um diretório aninhado. Para salvar espaço, nós eliminamos o ficheiro Abbyy depois de o analisar.

```python
# Use o cliente da linha de comandos para ver os formatos de metadados disponíveis:
# `ia metadata formats VOLUME_ID`

# Para esta lição, só o ficheiro Abbyy é necessário
returned_files = list(ia.get_files(item_id, formats=["Abbyy GZ"]))

# Certifique-se de que algo é devolvido
if len(returned_files) > 0:
    abbyy_file = returned_files[0].name
else:
    print("[{}] Could not get Abbyy file".format(item_id))
    return None

# Faça o download do ficheiro Abbyy para o CWD
ia.download(item_id, formats=["Abbyy GZ"], ignore_existing=True, \
	destdir=os.getcwd(), no_directory=True)
```

Assim que nós tivermos o ficheiro, nós precisamos de analisar o XML usando a biblioteca padrão do Python. Nós tomamos vantagem do facto de que nós podemos abrir o ficheiro comprimido diretamente com a biblioteca `gzip`. Os ficheiros Abbyy são indexadas a partir do zero, por isso a primeira página na sequência digitalizada tem o índice de 0. No entanto, nós temos que filtrar 0 porque não pode ser exigido do IA. A exclusão do índice 0 por parte do IA não está documentada em qualquer lugar; em vez disso, eu descobri através de tentativa e erro. Se vir uma mensagem de erro de explicação difícil, tente rastrear a origem e não tenha medo em pedir ajuda, seja a alguém com experiência relevante, seja da própria organização.

```python
# Colecione as páginas com pelo menos um bloco de imagem
img_pages = []

with gzip.open(abbyy_file) as fp:
    tree = ET.parse(fp)
    document = tree.getroot()
    for i, page in enumerate(document):
        for block in page:
            try:
                if block.attrib['blockType'] == 'Picture':
                    img_pages.append(i)
                    break
            except KeyError:
                continue

# 0 não é uma página válida para a realização de pedidos GET ao IA, mas às vezes
# está no ficheiro Abbyy comprimido
img_pages = [page for page in img_pages if page > 0]

# Trilho para o relatório do progresso do download
total_pages = len(img_pages)

# Os ficheiros de OCR são pesados, por isso elimine assim que tivermos a lista de páginas
os.remove(abbyy_file)
```

### Fazer o *Download* de Imagens

O *wrapper* do IA incorporado no Python não providencia uma função de download de páginas únicas&mdash;apenas em massa. Isto significa que nós usaremos a RESTful API do IA para obter páginas específicas. Primeiro, nós construímos um URL para cada página de que nós precisamos. Depois, nós usamos a biblioteca `requests` para enviar um pedido de HTTP `GET` e, se tudo correr bem (*i.e.* o código 200 é enviado na resposta), nós escrevemos o conteúdo da resposta num ficheiro JPEG.

O IA tem estado a trabalhar numa [versão *alpha*](https://iiif.archivelab.org/iiif/documentation) duma API para o corte e redimensionamento de imagens que obedeça às exigências do International Image Interoperability Framework ([IIIF](https://iiif.io/)). O IIIF representa uma vasta melhoria face ao antigo método para *downloads* de páginas únicas que requeriam o *download* de ficheiros JP2, um formato de ficheiro largamente não suportado. Agora, é extremamente simples obter uma simples página como JPEG:

```python
# Veja: https://iiif.archivelab.org/iiif/documentation
urls = ["https://iiif.archivelab.org/iiif/{}${}/full/full/0/default.jpg".format(item_id, page)
    for page in img_pages]

# nenhum download de página direto a partir das bibliotecas do Python, construa um pedido GET
for i, page, url in zip(range(1,total_pages), img_pages, urls):

    rsp = requests.get(url, allow_redirects=True)

    if rsp.status_code == 200:
        print("[{}] Downloading page {} ({}/{})".format(item_id, \
			page, i+1, total_pages))

        with open(os.path.join(out_dir, str(page) + ".jpg"), "wb") as fp:
            fp.write(rsp.content)
```


# Próximos Passos

Assim que o leitor tiver entendido as principais funções e o código de *unpacking* dos dados nos *notebooks*, sinta-se livre para executar as células em sequência ou "*Run All*" e ver as páginas ilustradas a entrar. O leitor é encorajado a adaptar estes *scripts* e funções para as suas próprias questões de pesquisa.

[^instalarpython]: Nota de tradução: Aconselhamos o leitor a adicionar o Python ao PATH, processo que pode ser feito aquando da sua instalação. Isto irá suavizar a incorporação das dependências (ver Dependências).

[^comandojupyternotebook]: Nota de tradução: Inicialmente, aparece uma página de transição, a qual deverá remeter rapidamente para o Jupyter. Caso tal não aconteça, basta seguir as instruções nesta página.
