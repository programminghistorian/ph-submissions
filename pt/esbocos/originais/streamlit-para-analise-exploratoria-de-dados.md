---
title: "Streamlit para análise exploratória de dados"
slug: streamlit-para-analise-exploratoria-de-dados
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Ruan Arthur Lima Santos
reviewers:
- Forename Surname
- Forename Surname
editors:
- Aracele Torres
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/690
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Objetivos da Lição

Esta lição articula discussões já apresentadas no [*Programming Historian*](https://programminghistorian.org/pt/) sobre manipulação de dados com Python ([Manipular strings com Python](https://programminghistorian.org/pt/licoes/manipular-strings-python), [Reutilização de código e modularidade em Python](https://programminghistorian.org/pt/licoes/reutilizacao-codigo-modularidade-python)) com práticas de visualização de dados. Mais especificamente, abordaremos o processo geral de construção de aplicações *web* interativas com o *framework* Streamlit. Para acompanhar a presente lição, além de [manipulação de *strings*](https://programminghistorian.org/pt/licoes/manipular-strings-python) e [modularização](https://programminghistorian.org/pt/licoes/reutilizacao-codigo-modularidade-python), pressupõe-se conhecimento intermediário em Python, incluindo:

- Manipulação de listas e dicionários
- Experiência com *loops* `for`
- Elaboração de funções (argumentos, tipagem e `return` condicional)
- Manipulação de arquivos (`with open()` e `pathlib`)
- Contato básico com `requests` (`.get()`), `pandas` (`pandas.DataFrame`) e `json` (`.loads()` e `.dumps()`)
- Noções de desenvolvimento de *software* ou, mais especificamente, separação e integração entre *front-end* (interface do usuário) e *back-end* (lógica por trás da interface, como o processamento de dados)

Fora os conhecimentos necessários de Python, é desejável experiência com algum terminal (*PowerShell*, *Git Bash*...), pois os comandos `cd` e `mkdir` serão úteis para reprodução da lição. Ao final desta, seremos capazes de integrar manipulação, visualização e apresentação de dados em um fluxo de trabalho único, reprodutível e voltado à construção de aplicações interativas para pesquisa em Humanidades Digitais. Compreenderemos, portanto, como diferentes etapas de pesquisa nessa área podem ser articuladas em aplicações *web* desenvolvidas com Streamlit.

## Introdução

É comum que visualizações de dados sejam realizadas em ferramentas prontas, como interfaces pré-configuradas ou plataformas *low-code*. Embora sejam alternativas úteis em muitos contextos, utilizar uma linguagem de programação para construir visualizações oferece vantagens importantes para pesquisas científicas, como maior controle (e conhecimento) das etapas da pesquisa (da coleta à visualização), possibilidade de personalização da interface conforme demanda ou objetivos, maior transparência e segurança na forma como os dados são manipulados, armazenados e apresentados.

É nesse contexto que *frameworks* [^1] se tornam relevantes. No caso do Streamlit, ele é um *framework* open-source que transforma *scripts* Python em aplicações *web* interativas (Basic concepts of Streamlit - Streamlit Docs, [S.d.]). Com ele, não precisamos configurar rotas de *Application Programming Interface* (API), desenvolver códigos JavaScript ou lidar com outros detalhes do desenvolvimento *web*, permitindo-nos focar apenas na lógica do *software*, no processamento de dados e na aplicação de componentes (*widgets*).

## Como reproduzir a lição

Para compreendermos o funcionamento do Streamlit e explorarmos parte de suas capacidades, a lição acompanha um exemplo de visualização baseado nas despesas de deputados federais brasileiros. Para reproduzir o exemplo apresentado, é necessário replicar a estrutura de pastas do projeto e realizar o *download* dos seguintes arquivos:

- [`app.py`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/streamlit-para-analise-exploratoria-de-dados/app.py) (*script* responsável pela interface);

- [`extract.py`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/streamlit-para-analise-exploratoria-de-dados/extract.py) (funções de extração de dados via API);

- [`transform.py`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/streamlit-para-analise-exploratoria-de-dados/transform.py) (funções de manipulação e preparação dos dados para uso no `app.py`);

- [`requirements.txt`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/streamlit-para-analise-exploratoria-de-dados/requirements.txt) (dependências dos demais *scripts*)

- [`deputies.json`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/streamlit-para-analise-exploratoria-de-dados/deputies.json) (dados utilizados na lição)

Com os arquivos em mãos, organize-os conforme o exemplo abaixo:

```bash
seu_diretorio/
└───app.py
└───extract.py
└───transform.py
└───requirements.txt
└───data/
    └───deputies.json
```

Depois, precisamos preparar o ambiente de desenvolvimento e executar a aplicação localmente [^2]. O processo de execução é semelhante em diferentes sistemas operacionais, mas vale sempre observar as particularidades do terminal utilizado (*PowerShell*, *Git Bash*, terminal nativo do Linux e entre outros).

Em geral, o maior problema se dá no caminho de arquivos entre sistemas operacionais ou terminais (Linux utiliza `diretorio/arquivo`, enquanto Windows `.\diretorio\arquivo`). Para lidar com isso, sugiro que use a tecla `Tab` para autocompletar diretórios e nomes de arquivos, reduzindo erros de digitação e ajustando caminhos automaticamente. Dito isso, o primeiro passo é abrir o terminal de sua preferência e navegar até o diretório no qual os arquivos da lição se encontram (como `C:\Users\Seu_Usuario\Documents\`) com o comando `cd`:

```bash
cd ~/Documents/ # Linux
cd 'C:\Users\Seu_Usuario\Documents\' # Windows
```

Em seguida, crie um ambiente virtual:

```bash
python -m venv .venv
```

Depois, ative o ambiente virtual:

```bash
source .venv/Scripts/activate # Linux
.venv\Scripts\activate # Windows
```

Com o ambiente ativado, instale as dependências do projeto:

```bash
pip install -r requirements.txt # Linux
pip install -r .\requirements.txt # Windows
```

Por fim, execute a aplicação:

```bash
streamlit run app.py # Linux
streamlit run .\app.py # Windows
```

Assim, o Streamlit iniciará um servidor local e a aplicação estará pronta para uso no navegador. Nas próximas etapas, exploraremos como cada parte da aplicação funciona e como elas se relacionam.

## Modularização

De forma geral, uma aplicação de análise de dados (exploratória ou não) dá inteligibilidade aos processos de extração, transformação e armazenamento (ETL, em inglês). A etapa de "extração", no entanto, nem sempre é simples: muitas vezes dependemos de dados secundários e nem sempre há APIs disponíveis, o que pode tornar esse processo mais trabalhoso. Para contornar essas dificuldades, esta lição utiliza dados abertos da Câmara dos Deputados do Brasil, que disponibiliza uma API pública [^3].

Além disso, é importante que a distinção conceitual entre as etapas do ETL se reflita na organização dos *scripts*. Em projetos maiores, isso costuma resultar em múltiplos diretórios e subdiretórios. Entretanto, trabalharemos apenas com três *scripts* principais: `app.py`, `extract.py` e `transform.py`. Embora simples, essa divisão ajuda a organizar responsabilidades: `app.py` concentra tanto a integração com o "*back-end*" quanto a visualização; `extract.py` realiza as requisições à API da Câmara, e `transform.py` organiza e prepara os dados no formato adequado para as visualizações no Streamlit. Essa separação também facilita a manutenção e a escalabilidade do projeto ao longo do tempo.

## Por onde começar? *Front-end* ou *Back-end?*

Essa é uma ótima pergunta. A construção de um programa tende a ser um processo cíclico — sobretudo em projetos de [Ciência de Dados](https://miro.medium.com/1*_fR-2Yg-xaWXssnj08Zqeg.jpeg). Por um lado, só conseguimos avaliar o que realmente faz sentido na interface à medida que construímos e utilizamos o sistema (algo que o planejamento prévio ajuda, mas não resolve completamente). Por outro, desenvolver a lógica do *back-end* e explorar os dados brutos também gera bons *insights* sobre parâmetros, organização da interface, otimização dos *scripts*, integração com o *front-end*, entre outros aspectos. O risco, nesse segundo caso, é cair em [*over-engineering*](https://en.wikipedia.org/wiki/Overengineering), ou seja, planejar e implementar recursos desnecessários.

No fim das contas, não há uma resposta única [^4]. Em geral, busca-se algum nível de ["*future-proofing*"](https://en.wikipedia.org/wiki/Future-proof) (capacidade de resistir e adaptar-se a mudanças futuras). Por isso, aplicações maiores costumam se beneficiar de arquiteturas mais consolidadas, como *Layers* [^5]. De todo modo, os *scripts* desta lição não têm como foco aprofundar essas discussões de engenharia e desenvolvimento de *software* (*mas não se esqueça delas*).

Como trabalhamos com dois tipos de *scripts* (*front-end* e *back-end*), a integração entre eles ocorre por meio de importações:

```python
# app.py
import json
import shutil
import pandas as pd
from time import sleep
import streamlit as st
from pathlib import Path
from extract import get_deputies, get_deputies_informations # <--
from transform import top_suppliers, total_expenses, expense_types, expenses_per_month # <--
```

Para atingir os objetivos da lição, começaremos do que julgo mais simples ao mais complexo. Isto é, exploraremos `extract.py` e, em seguida, `app.py` e `transform.py` serão apresentados conjuntamente.

## Coletando os dados

Como o objetivo é construir uma aplicação para análise exploratória de dados sobre deputados brasileiros, podemos identificar duas categorias principais de interesse: informações gerais de todos os deputados e informações de sujeitos específicos. Isso se traduz em duas funções distintas em `extract.py`: `get_deputies()` e `get_deputies_informations()`, responsáveis pela coleta de dados gerais e de dados específicos, respectivamente.

```python
# Import
import requests
import pandas as pd

# Functions
def get_deputies(api):

    res = requests.get("/".join([api, "deputados"]))
    deputies = res.json()

    return deputies

def get_deputies_informations(deputies_names: list, df: pd.DataFrame, api: str, years: list, debug: False):

    data = dict()

    for depute in deputies_names:

        depute_id = str(df.loc[df["nome"] == depute, "id"].values[0])

        total_expenses = []
        urls_debug = list()

        for y in years:
            url = f"{api}/deputados/{depute_id}/despesas?ano={y}&ordem=ASC&ordenarPor=ano"

            if debug:
                urls_debug.append(url)

            resp = requests.get(url).json()["dados"]
            total_expenses.extend(resp)

        data[depute] = {
            "expense": total_expenses
        }

    if debug:
        return data, urls_debug
    else:
        return data
```

A função `get_deputies()` é bastante direta: ela recebe como parâmetro a `api`, constrói a URL com `"/".join([api, "deputados"])` e realiza uma requisição com `requests.get()`. Em seguida, extrai o conteúdo em JSON da resposta (`res.json()`) e o retorna.

Já `get_deputies_informations()` apresenta maior complexidade. Para obter informações específicas de cada deputado, a função recebe uma lista de nomes (`deputies_names`), um `DataFrame` com os dados a serem filtrados (`df`), a API (`api`) e os anos de interesse (`years`).

A partir disso, iteramos sobre cada nome na lista de deputados selecionados para montarmos a *URL* da requisição. Para isso: 1) criamos um dicionário vazio (`data`), responsável por armazenar as despesas de todos os deputados; 2) obtemos o *id* de cada deputado (primeiro laço `for`); 3) para cada ano, constrói-se a *URL* (segundo laço `for`) e 4) realiza-se a chamada à API.

Em resumo, os dados são organizados no dicionário `data`, em que cada chave corresponde ao nome do deputado e contém suas respectivas informações de despesas [^6]. Caso o modo `debug` esteja ativado, a função também retorna as *URLs* utilizadas nas requisições; caso contrário, retorna apenas os dados coletados.

## Construção da interface

Para mais informações sobre os componentes disponibilizados pelo Streamlit, vale recorrer à [documentação oficial](https://streamlit.io/). Além disso, os tutoriais oferecidos pela equipe do próprio *framework* ajudam a compreender a sintaxe de componentes básicos, como `st.button()`. Mas, de modo geral, há três formas principais de uso: `st.funcao(argumento)`, `with st.funcao(argumento)` e `if st.funcao(argumento)`. Por exemplo:

```python
# with st.funcao(argumento)
with st.expander("View all deputies", expanded=tad_expansion, width="stretch"): # <-- Painel expansível

            # st.funcao(argumento)
            st.write("Deputies") # <-- Escreve um texto qualquer

# if st.funcao(argumento)
if st.button("Extract deputies", width="stretch"): # <-- Botão

    st.write("Deputies") # <-- Escreve um texto qualquer
```

Obviamente, há muitos *widgets* e funções a serem exploradas, então reforço a consulta à documentação. Dando seguimento: a forma mais simples de estruturar uma interface *web* com Streamlit é configurando a página (`st.set_page_config`) e planejando suas duas regiões centrais: a *sidebar* (`st.sidebar`) e a área principal (tudo que estiver fora de `st.sidebar`).

```python
# Configurando a página
st.set_page_config(
    page_title="Streamlit for Exploratory Analysis",
    initial_sidebar_state="expanded",
    layout="wide"
)

# Sidebar
# input da api
# botão para coletar dados (get_deputies)
# selecionar deputados
# selecionar período de tempo
# botão para coletar dados (get_deputies_informations)
# botão para deletar dados

# Main
    
    ## Primeira aba -> Todos os deputados
        
        ### Deputados por partido

        ### Deputados por "região"

    ## Segunda aba -> Deputados selecionados

        ### Despesas dos deputados

            ### Despesas por mês

            ### Principais fornecedores

            ### Tipos de despesas
```

A elaboração acima (em *Sidebar* e *Main*) se aproxima bastante da construção de um algoritmo das funcionalidades principais. É importante destacar que essas funcionalidades e visualizações devem estar alinhadas ao objetivo geral do *software* e às possibilidades oferecidas pelos *endpoints* (informações disponibilizadas pela API) — ou pelas variáveis que podem ser construídas na etapa de transformação dos dados. Em outras palavras, avaliar a viabilidade de cada parte do algoritmo (ou do [*pseudocódigo*](https://pt.wikipedia.org/wiki/Pseudoc%C3%B3digo) [^7]) ajuda a economizar tempo e esforço.

Outra vantagem desse planejamento é a escolha dos *widgets* mais adequados, sempre com apoio da documentação do *framework*. Por exemplo: qual a melhor forma de selecionar um período de tempo? Um *slider* ou uma seleção manual dos anos? Como ambos os casos podem ser úteis, oferecemos as duas opções:

```python
# Seleciona o tipo de período a ser usado
period_mode = st.radio(
                "Period mode",
                options=["slider", "multiselection"],
                width="stretch",
                index=0
            )                

            # Período slider
            if period_mode == "slider":

                selected_years_tuple = st.slider(
                    label="Select a period",
                    min_value=0,
                    max_value=26,
                    value=(0, 26),
                    help="\"0\" means 2000, as well \"26\" is 2026!"
                )

                selected_years = list(range(
                    2000 + selected_years_tuple[0],
                    2000 + selected_years_tuple[1] + 1
                ))

            # Período de múltipla seleção
            elif period_mode == "multiselection":

                selected_years = st.multiselect(
                    "Select years",
                    options=list(range(2000, 2027)),
                    accept_new_options=True,
                    width="stretch"
                )
```

Para retomar nossa integração de *scripts* via importações, observe que a lista `selected_years` é, precisamente, uma das informações exigidas por `get_deputies_informations()` (`years: list`). Logo, atente-se sempre aos tipos de dados que cada componente retorna e quais os tipos mais apropriados para cada função. Como `get_deputies_informations()` requer uma lista de anos, e tanto `st.radio()` quanto `st.multiselect()` retornam listas, tudo que devemos fazer é passar a variável como argumento da função:

```python
if st.button("'Get Deputies' Expenses", width="stretch"):

    st.session_state["selected_deputies"] = get_deputies_informations(
        st.session_state["names_list"], st.session_state["deputies"],
        api,
        selected_years, # <--
        False
    )
```

Essa é uma exposição geral da lógica que orienta a integração entre os componentes da interface e as demais etapas da aplicação. Em termos práticos, cada *widget* do Streamlit funciona como um ponto de entrada para informações que serão utilizadas pelas funções de extração, transformação ou visualização dos dados.

Por isso, além da construção visual da interface, é fundamental compreender como os valores retornados pelos componentes circulam entre os diferentes módulos do projeto, garantindo compatibilidade entre tipos de dados, organização do fluxo da aplicação e escalabilidade das funcionalidades futuras.

Durante esse processo, também é importante se atentar a algumas particularidades do Streamlit. A principal delas é que o *script* da aplicação (`app.py`) é executado do início ao fim a cada interação do usuário, o que pode gerar problemas com variáveis definidas condicionalmente:

```python
import streamlit as st

with st.sidebar:

    if st.button("Clique aqui", width="stretch"):

        teste = "Texto de exemplo"

    opcao = st.selectbox("Escolha", ["Opção 1", "Opção 2"])

st.write(teste)
```

Nesse caso, a variável `teste` só existe quando o botão é acionado, e *deixa de existir* a cada interação com `st.selectbox`. Um `else` inicializando `teste` resolveria o problema? Parcialmente, pois ainda perdemos o valor `"Texto de exemplo"`. No contexto do Streamlit, a solução adequada é utilizar variáveis de sessão (`st.session_state`):

```python
import streamlit as st

if "teste" not in st.session_state:

    st.session_state["teste"] = None
    
with st.sidebar:

    if st.button("Clique aqui", width="stretch"):

        st.session_state["teste"] = "Texto de exemplo" # <--

    opcao = st.selectbox("Escolha", ["Opção 1", "Opção 2"])

st.write(st.session_state["teste"]) # <--
```

Dessa forma, o valor passa a persistir entre interações. Por isso, após as importações e configurações iniciais, vale inicializar todas as variáveis de `st.session_state`:

```python
# Import
import json
import shutil
import pandas as pd
from time import sleep
import streamlit as st
from pathlib import Path
from extract import get_deputies, get_deputies_informations
from transform import top_suppliers, total_expenses, expense_types, expenses_per_month

# Page configuration
st.set_page_config(
    page_title="Streamlit for Exploratory Analysis",
    initial_sidebar_state="expanded",
    layout="wide"
)

# Constants
BASE_API = "https://dadosabertos.camara.leg.br/api/v2"
BASE_DIR = Path(__file__).resolve().parent
DATA_DIR = BASE_DIR / "data"
DEPUTIES_FILE = DATA_DIR / "deputies.json"

# Creating data directory
DATA_DIR.mkdir(parents=True, exist_ok=True)

# Checks
if "exists" not in st.session_state:
    st.session_state["exists"] = False

if "deputies" not in st.session_state:
    st.session_state["deputies"] = pd.DataFrame()

if "selected_deputies" not in st.session_state:
    st.session_state["selected_deputies"] = dict()

if "names_list" not in st.session_state:
    st.session_state["names_list"] = list()

if "political_party_column" not in st.session_state:
    st.session_state["political_party_column"] = None

if "geographic_region_column" not in st.session_state:
    st.session_state["geographic_region_column"] = None

if "ppc_view_mode" not in st.session_state:
    st.session_state["ppc_view_mode"] = "None"

if "grc_view_mode" not in st.session_state:
    st.session_state["grc_view_mode"] = "None"
```

No desenvolvimento de software, esse tipo de controle de estado (*state*, *cache*, etc.) é comum e frequentemente combinado com tratamentos de erro — como lidar com execuções fora de ordem, variáveis inexistentes ou valores inválidos. Em outras palavras, trata-se de um exercício contínuo de lógica de programação. Por exemplo, não faz sentido liberar certas funcionalidades se os dados ainda não foram carregados:

```python
if DEPUTIES_FILE.exists(): # Lê deputies.json, caso exista

    with open(DEPUTIES_FILE, 'r', encoding="utf-8") as f:
        j = json.loads(f.read())
        st.session_state["deputies"] = pd.DataFrame.from_dict(j["dados"]) # armazena deputies.json como pandas.DataFrame em uma variável de sessão

    st.session_state["exists"] = True

# Sidebar
with st.sidebar:

    api = st.text_input("Insert API", value=BASE_API, width="stretch", help="Please remove the last \"/\"!")

    if not st.session_state["exists"] or not st.session_state["deputies"].__len__() > 0: # Verifica se os dados não existem ou não são válidos

        if st.button("Extract deputies", width="stretch"):

            deputies = get_deputies(api) # Função de extract.py

            with open(DEPUTIES_FILE, 'w', encoding="utf-8") as f:
                f.write(json.dumps(deputies, indent=4, ensure_ascii=False)) # Escreve deputies.json

            st.success("Deputies extracted!") # Notificação ao usuário
```

Agora que vimos alguns dos componentes disponibilizados na *sidebar* e pontos de atenção, podemos explorar a área central da aplicação (separada em abas ou *tabs*, no Streamlit) e, especialmente, a aba `tab_all_deputies`:

```python
# Main tabs
tab_all_deputies, tab_selected_deputies = st.tabs(["All deputies (TAD)", "Selected deputies (TSD)"])

with tab_all_deputies:

    if st.session_state["exists"] and st.session_state["deputies"].__len__() > 0:

        with st.expander("View all deputies", expanded=tad_expansion, width="stretch"):
            st.dataframe(st.session_state["deputies"])

        tad_col1, tad_col2 = st.columns(2)

        with tad_col1:

            st.session_state["political_party_column"] = st.selectbox(
                "Political Party Column",
                help="Click on \"x\" to clear your selection!",
                options=st.session_state["deputies"].keys(),
                width="stretch",
                index=None
            )

            if st.session_state["political_party_column"] is not None:

                counts_ppc = st.session_state["deputies"][st.session_state["political_party_column"]].value_counts().reset_index()
                counts_ppc["percentage"] = counts_ppc["count"] / counts_ppc["count"].sum() * 100

                with st.container(border=True, width="stretch", horizontal_alignment="center", vertical_alignment="center"):

                    st.session_state["ppc_view_mode"] = st.radio(
                        "View mode",
                        ["Table (with %)", "Chart"],
                        width="stretch",
                        horizontal=True,
                        label_visibility="collapsed",
                        key="ppc_vm_button"
                    )

                    if st.session_state["ppc_view_mode"] == "Chart":

                        st.bar_chart(
                            counts_ppc,
                            x=st.session_state["political_party_column"],
                            y="count",
                            width="stretch",
                            horizontal=True,
                            sort=False
                        )

                    elif st.session_state["ppc_view_mode"] == "Table (with %)":

                        st.write(counts_ppc)

        with tad_col2:

            st.session_state["geographic_region_column"] = st.selectbox(
                "Geographic Region Column",
                help="Click on \"x\" to clear your selection!",
                options=st.session_state["deputies"].keys(),
                width="stretch",
                index=None
            )

            if st.session_state["geographic_region_column"] is not None:

                counts_grc = st.session_state["deputies"][st.session_state["geographic_region_column"]].value_counts().reset_index()
                counts_grc["percentage"] = counts_grc["count"] / counts_grc["count"].sum() * 100

                with st.container(border=True, width="stretch", horizontal_alignment="center", vertical_alignment="center"):

                    st.session_state["grc_view_mode"] = st.radio(
                        "View mode",
                        ["Table (with %)", "Chart"],
                        width="stretch",
                        horizontal=True,
                        label_visibility="collapsed",
                        key="grc_vm_button"
                    )

                    if st.session_state["grc_view_mode"] == "Chart":

                        st.bar_chart(
                            counts_grc,
                            x=st.session_state["geographic_region_column"],
                            y="count",
                            width="stretch",
                            horizontal=True,
                            sort=False
                        )
                    
                    elif st.session_state["grc_view_mode"] == "Table (with %)":

                        st.write(counts_grc)
```

Nesse trecho, além de criarmos as abas (o que melhora a visualização da aplicação, pois separamos informações genéricas das específicas), verificamos se existem dados carregados na sessão e se o conjunto de deputados não está vazio — ou seja, pequenos tratamentos de erros ou inconsistências. Se nenhum problema é detectado, exibimos uma seção expansível contendo o `pandas.DataFrame` com todos os deputados. A vantagem de utilizar `st.expander()` aqui é tornar a base de dados uma visualização retrátil, permitindo ao usuário maior controle das informações a serem vistas.

Em seguida, a interface é dividida em duas colunas. Na primeira, o usuário seleciona qual coluna do `pandas.DataFrame` deseja analisar. Após essa escolha, calculamos a frequência de cada categoria (`.value_counts()`) e sua porcentagem em relação ao total. Os resultados podem ser exibidos como gráfico de barras (`st.bar_chart`) ou como tabela, incluindo valores absolutos e percentuais. Veja, então, que podemos oferecer *widgets* com abordagens generalistas ou não (poderíamos limitar as colunas oferecidas ao usuário pelo tipo dado ou prefixo, por exemplo).

{% include figure.html filename="pt-or-streamlit-para-analise-exploratoria-de-dados-01.png" alt="Interface da aplicação com filtros para o período entre 2020 e 2026 e seleção dos deputados Nikolas Ferreira e Erika Hilton. A visualização principal apresenta dois gráficos sobre todos os deputados em deputies.json." caption="Figura 1. Interface da aplicação com seleção de deputados e filtros temporais" %}

Por fim, vejamos a aba `tab_selected_deputies`:

```python
with tab_selected_deputies:

    if st.session_state["exists"] and len(st.session_state["deputies"]) > 0:

        deputies_items = list(st.session_state["selected_deputies"].items())

        for i in range(0, len(deputies_items), 2):

            cols = st.columns(2)

            for j in range(2):

                if i + j >= len(deputies_items):
                    continue

                depute, info = deputies_items[i + j]

                depute_id = st.session_state["deputies"].loc[
                    st.session_state["deputies"]["nome"] == depute,
                    "id"
                ].values

                depute_id = depute_id[0] if len(depute_id) > 0 else None

                depute_photo = st.session_state["deputies"].loc[
                    st.session_state["deputies"]["nome"] == depute,
                    "urlFoto"
                ].values

                photo_url = depute_photo[0] if len(depute_photo) > 0 else None

                with cols[j]:

                    with st.container(border=True):

                        with st.container(horizontal_alignment="center"):
                            
                            st.image(
                                image=photo_url,
                                width=200,
                                output_format="PNG",
                                caption=f"Depute ID: {depute_id}",
                                link=photo_url
                            )

                            st.subheader(
                                depute,
                                text_alignment="center"
                            )

                        expenses = info.get("expense", [])

                        if not expenses:

                            st.write("No expense data")
                            continue

                        monthly_expenses = expenses_per_month(expenses)

                        with st.expander("Expenses per month", expanded=tsd_expansion):

                            st.line_chart(monthly_expenses)
                            
                            st.metric("Total expenses", total_expenses(
                                monthly_expenses, format_brl
                                )
                            )

                        with st.expander("Main suppliers", expanded=tsd_expansion):

                            st.bar_chart(
                                top_suppliers(expenses),
                                width="stretch",
                                horizontal=True,
                                sort=False
                            )

                        with st.expander("Types of expenses", expanded=tsd_expansion):
                            
                            st.bar_chart(
                                expense_types(expenses),
                                width="stretch",
                                horizontal=True,
                                sort=True
                            )
```

Nesse trecho, há duas operações principais: a construção dinâmica do *layout* e a visualização dos dados. Após a verificação inicial, os deputados selecionados são organizados em pares para distribuição em duas colunas (`st.columns`). Os dados são convertidos em uma lista de pares (`deputies_items`), e o laço `for i in range(0, len(deputies_items), 2)` percorre essa lista de dois em dois, representando cada “linha” da interface. Em seguida, o laço interno (`for j in range(2)`) preenche as colunas. A condição `if i + j >= len(deputies_items)` evita erros quando há um número ímpar de deputados, deixando a última célula vazia quando necessário. Esse dinamismo na construção da interface — que controla tanto a quantidade de deputados por linha quanto o espaço disponível aos gráficos, visto nossos aninhamentos de *widgets* de *layout* — é bastante proveitoso [^8].

Depois disso são recuperadas informações como *id* e *url* da foto de cada deputado, compondo um “cartão” individual com imagem, nome e identificação. É a partir desse momento que entram as visualizações, sendo elas dependentes de dados previamente tratados. Mas, *como já sabemos*, esse tratamento não deve ocorrer em `app.py`, mas em `transform.py`:

```python
def format_brl(value: float) -> str:
    return f'R$ {value:,.2f}'.replace(',', 'X').replace('.', ',').replace('X', '.')

def expenses_per_month(expenses: list) -> dict:
    result = {}

    for item in expenses:
        key = f'{item["ano"]}-{item["mes"]:02d}'
        value = item.get("valorLiquido", 0)

        result[key] = result.get(key, 0) + value
        data = dict(sorted(result.items()))

    return dict(sorted(result.items()))

def total_expenses(monthly_expenses: dict, format: bool) -> float:

    total = sum(monthly_expenses.values())

    if format:
        total = format_brl(total)

    return total

def top_suppliers(expenses: list, top_n: int = 10) -> dict:
    result = {}

    for item in expenses:
        supplier = item.get("nomeFornecedor", "Unknown")
        value = item.get("valorLiquido", 0)

        result[supplier] = result.get(supplier, 0) + value

    return dict(
        sorted(result.items(), key=lambda x: x[1], reverse=True)[:top_n]
    )

def expense_types(expenses: list) -> dict:
    result = {}

    for item in expenses:
        expense_type = item.get("tipoDespesa", "Other")
        value = item.get("valorLiquido", 0)

        result[expense_type] = result.get(expense_type, 0) + value

    return result
```

Essa separação mantém `app.py` mais alinhado ao princípio de responsabilidade única que estamos trabalhando, além de facilitar a manutenção e compreensão do programa como um todo. Logo, com os dados preparados, eles são exibidos em três seções expansíveis:

```python
monthly_expenses = expenses_per_month(expenses)

with st.expander("Expenses per month", expanded=tsd_expansion):
    
    st.line_chart(monthly_expenses)
    
    st.metric("Total expenses",
    total_expenses(
                monthly_expenses, format_brl
        )
    )
```

```python
with st.expander("Main suppliers", expanded=tsd_expansion):

    st.bar_chart(
        top_suppliers(expenses),
        width="stretch",
        horizontal=True,
        sort=False
    )
```

```python
with st.expander("Types of expenses", expanded=tsd_expansion):
                            
    st.bar_chart(
        expense_types(expenses),
        width="stretch",
        horizontal=True,
        sort=True
    )
```

{% include figure.html filename="pt-or-streamlit-para-analise-exploratoria-de-dados-02.png" alt="Interface da aplicação exibindo os deputados Nikolas Ferreira e Erika Hilton e visualizações expansíveis com despesas por mês, principais fornecedores e tipos de despesas." caption="Figura 2. Exemplo das visualizações disponíveis após a seleção de deputados (não expandidas)" %}

{% include figure.html filename="pt-or-streamlit-para-analise-exploratoria-de-dados-03.png" alt="Interface da aplicação com visualizações expandidas de despesas mensais, principais fornecedores e tipos de despesas dos deputados selecionados." caption="Figura 3. Exemplo das visualizações disponíveis após a seleção de deputados (expandidas)" %}

Dessa maneira, temos: um gráfico de linha com a evolução das despesas ao longo do tempo (acompanhado do total no período), um gráfico com os principais fornecedores e outro com os tipos de despesas, ambos em formato de barras. Ou seja, a aplicação resulta em um painel com múltiplas visualizações expansíveis e organizadas, onde cada deputado selecionado possui um conjunto padronizado de visualizações, permitindo explorar diferentes dimensões de suas despesas.

## Considerações finais

Esta lição buscou demonstrar que aplicações relativamente simples já são suficientes para evidenciar o potencial do Streamlit para pesquisas em Humanidades Digitais. A ferramenta permite tanto a exploração inicial dos dados — favorecendo a formulação de perguntas de pesquisa — quanto sua aplicação em investigações mais estruturadas, como estudos que utilizam métodos computacionais para análise de grandes volumes de dados ([Visual and Narrative Patterns of Online Misogyny: A Computer Vision Analysis of Telegram Chats](https://doi.org/10.31235/osf.io/wvn9e_v1)).

A partir dos indicadores aqui utilizados — e, claro, com os complementos necessários —, diferentes perguntas de pesquisa poderiam ser formuladas, sobretudo questões de caráter comparativo ("como se configuram as redes econômicas mobilizadas por parlamentares com perfis distintos", "de que maneira diferentes composições de capitais se relacionam aos padrões de mobilização dos recursos econômicos", "como trajetórias e carreiras se associam às formas de uso das verbas parlamentares" e entre outras).

Evidentemente, aplicações dessa natureza dependem da disponibilidade de dados. Logo, o pesquisador ou se investe na produção destes ou recorre a dados secundários. Neste último caso, o fundamental é adequar a pergunta e os objetivos de pesquisa às características do material disponível, além de se posicionar criticamente em relação às fontes utilizadas. No caso da aplicação apresentada, um exercício relevante consistiria, justamente, em investigar os aspectos sociais e políticos envolvidos na criação e manutenção dos Dados Abertos da Câmara dos Deputados.

Outra limitação refere-se ao próprio *framework*, visto que o Streamlit foi concebido para o desenvolvimento ágil e relativamente simplificado de aplicações interativas. Em razão disso, sua adequação tende a diminuir à medida que aumentam as exigências técnicas do projeto: cenários que envolvem grande volume de acessos simultâneos, bancos de dados mais robustos — sejam eles relacionais, não relacionais ou inseridos em contextos de *Big Data* —, demandas elevadas de segurança, estruturas sofisticadas de paginação ou sistemas avançados de gerenciamento de estados tendem a tornar outras tecnologias mais adequadas.

Por fim, deixo aqui uma das recomendações mais úteis (e simples) para quem desenvolve *software*: use sua própria aplicação. Dessa forma, tornam-se mais evidentes os ajustes necessários, como melhorias de lógica, reelaboração do *design* da interface, inclusão de mensagens de suporte (argumento `help`) ou notificações de *feedback* ao usuário [^9].

## Referências

BASIC CONCEPTS OF STREAMLIT - STREAMLIT DOCS. [S.d.]. Disponível em: https://docs.streamlit.io/. Acesso em: 12 maio 2026.

PROJETO DE ARQUITETURA. In: SOMMERVILLE, Ian. Engenharia de software. 9. ed. São Paulo: Addison Wesley, 3 ago. 2010. ed. 9. Disponível em: https://www.facom.ufu.br/~william/Disciplinas%202018-2/BSI-GSI030-EngenhariaSoftware/Livro/engenhariaSoftwareSommerville.pdf.

REÚSO DE SOFTWARE. In: SOMMERVILLE, Ian. Engenharia de software. 9. ed. São Paulo: Addison Wesley, 3 ago. 2010. ed. 9. Disponível em: https://www.facom.ufu.br/~william/Disciplinas%202018-2/BSI-GSI030-EngenhariaSoftware/Livro/engenhariaSoftwareSommerville.pdf.

## Notas de fim

[^1]: Estruturas genéricas que agregam classes, objetos, componentes e funções (Reúso de Software, 2010).

[^2]: Certifique-se de possuir o Python 3.14 ou superior instalado (a versão utilizada nesta lição foi a [3.14.4](https://www.python.org/downloads/release/python-3144/)).

[^3]: [Documentação da API](https://dadosabertos.camara.leg.br/swagger/api.html).

[^4]: Vale ressaltar que a boa delimitação do *software* é uma atividade importante e *anterior* a essas discussões (embora essa definição também possa evoluir conforme o desenvolvimento).

[^5]: Resumidamente, a arquitetura em camadas (*layers*) é uma organização cujas funcionalidades são divididas de forma que uma camada se relacione diretamente apenas às suas camadas antecedentes (Projeto de arquitetura, 2010). Isto é, se `camada A` vem antes de `camada B`, `B` "só depende dos recursos e serviços oferecidos pela camada imediatamente abaixo dela [`A`]" (Projeto de arquitetura, 2010, p. 109).

[^6]: Dentre as vantagens de armazenar as informações dos deputados em um dicionário, destaca-se a padronização e clareza "semântica" de acesso ao objeto (`data[nome_deputado][variável]`).

[^7]: O exemplo acima não é propriamente um pseudocódigo, pois não segue uma sintaxe formal ou próxima de uma linguagem de programação.

[^8]: Em uma aplicação de agrupamento de imagens, por exemplo, é interessante que o número de imagens por linha (que afeta a resolução) seja um parâmetro configurável.

[^9]: Além disso, vale testar recursos básicos de acessibilidade nas aplicações desenvolvidas.
