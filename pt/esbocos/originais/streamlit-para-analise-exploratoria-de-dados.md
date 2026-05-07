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

Esta lição articula discussões já apresentadas no [*Programming Historian*](https://programminghistorian.org/pt/) sobre manipulação de dados com Python ([Manipular strings com Python](https://programminghistorian.org/pt/licoes/manipular-strings-python), [Reutilização de código e modularidade em Python](https://programminghistorian.org/pt/licoes/reutilizacao-codigo-modularidade-python)) com práticas de visualização de dados. Mais especificamente, abordaremos o processo geral de construção de aplicações web interativas com o *framework* *Streamlit*.

Para acompanhar, pressupõe-se conhecimento intermediário em Python, incluindo manipulação de *strings*, listas, dicionários, funções, arquivos e o uso básico de bibliotecas como `requests` e `pandas`. Ao final, seremos capazes de integrar manipulação, visualização e apresentação de dados em um fluxo de trabalho único, reprodutível e orientado à pesquisa.

## Introdução

Para executar o exemplo disponibilizado na lição: crie um ambiente virtual (`python -m venv .venv`), ative o ambiente (no Windows `source .venv/Scripts/activate`), instale os pacotes necessários (`pip install -r requirements`) e, por fim, execute a aplicação (`streamlit run app.py`). Com isso, a aplicação já estará pronta para uso. Vamos explorar como ela funciona nas próximas etapas.

## Modularização

De forma geral, uma aplicação de análise de dados (exploratória ou não) busca tornar inteligíveis os processos de extração, transformação e armazenamento (ETL, em inglês). A etapa de "extração", no entanto, nem sempre é simples: muitas vezes dependemos de dados secundários e nem sempre há APIs disponíveis, o que pode tornar esse processo mais trabalhoso. Para contornar essas dificuldades, esta lição utiliza dados abertos da Câmara dos Deputados do Brasil, que disponibiliza uma API pública acessível a qualquer pessoa [^1].

Além disso, é importante que a distinção conceitual entre as etapas do ETL se reflita na organização dos *scripts*. Em projetos maiores, isso costuma resultar em múltiplos diretórios e subdiretórios. Entretanto, trabalharemos apenas com três *scripts* principais: [`app.py`](https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/streamlit-para-analise-exploratoria-de-dados/app.py), [`extract.py`]((https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/streamlit-para-analise-exploratoria-de-dados/extract.py) e [`transform.py`]((https://github.com/programminghistorian/ph-submissions/tree/gh-pages/assets/streamlit-para-analise-exploratoria-de-dados/transform.py) [^2].

Essa divisão ajuda a organizar responsabilidades: o *app* concentra tanto a integração com o "backend" quanto a visualização; o *extract* realiza as requisições à API; e o `transform.py` organiza e prepara os dados no formato adequado para as visualizações no *Streamlit*. Essa separação também facilita a manutenção e a escalabilidade do projeto ao longo do tempo.

## Por onde começar? *Frontend* ou *Backend?*

Essa é uma ótima pergunta. A construção de um programa tende a ser um processo cíclico — sobretudo em projetos de [Ciência de Dados](https://miro.medium.com/1*_fR-2Yg-xaWXssnj08Zqeg.jpeg). Por um lado, só conseguimos avaliar o que realmente faz sentido na interface à medida que construímos e utilizamos o sistema (o planejamento prévio ajuda, mas não resolve completamente). Por outro, desenvolver a lógica do *backend* e explorar os dados brutos também gera bons *insights* sobre parâmetros, organização da interface, otimização dos *scripts*, integração com o *frontend*, entre outros aspectos. O risco, nesse segundo caso, é cair em [*over-engineering*](https://en.wikipedia.org/wiki/Overengineering), ou seja, planejar e implementar recursos desnecessários.

No fim das contas, não há uma resposta única [^3]. Em geral, busca-se algum nível de "*future-proofing*" (capacidade de adaptação a mudanças futuras). Por isso, aplicações maiores costumam se beneficiar de arquiteturas mais consolidadas, como [*Layers*, *SOA*](https://www.alura.com.br/artigos/padroes-arquiteturais-arquitetura-software-descomplicada), entre outras. Já em aplicações menores, [princípios de Programação Orientada a Objetos](https://www.alura.com.br/artigos/solid) costumam ser suficientes para garantir organização e legibilidade. De todo modo, os *scripts* desta lição não têm como foco aprofundar essas discussões de engenharia e desenvolvimento de software (*mas não se esqueça delas*).

Como trabalhamos com dois tipos de *scripts* (*frontend* e *backend*), a integração entre eles ocorre por meio de importações [^4]. Veja as importações de *app.py*:

```{python}
# Import
import json
import shutil
import pandas as pd
from time import sleep
import streamlit as st
from pathlib import Path
from extract import get_deputies, get_deputies_informations # <--
from transform import top_suppliers, total_expenses, expense_types, expenses_per_month # <--
```

Para atingir os objetivos da lição, começaremos do mais simples ao mais complexo. Primeiro, exploraremos o `extract.py` e, em seguida, `app.py` e `transform.py` serão apresentados conjuntamente.

## "Coletando" os dados

Como o objetivo é construir uma aplicação para análise exploratória de dados sobre deputados brasileiros, podemos identificar duas categorias principais de interesse: informações gerais de todos os deputados e informações específicas de indivíduos. Isso se traduz em duas funções distintas em `extract.py`: `get_deputies()` e `get_deputies_informations`, responsáveis pela coleta de dados gerais e de dados detalhados, respectivamente.

```{python}
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

A função `get_deputies()` é bastante direta: ela recebe como parâmetro a `api`, constrói a URL com `"/".join([api, "deputados"])` e realiza uma requisição com `requests.get`. Em seguida, extrai o conteúdo em JSON da resposta (`res.json()`) e o retorna.

Já `get_deputies_informations` apresenta maior complexidade. Para obter informações específicas de cada deputado, a função recebe a lista de nomes (`deputies_names`), um `DataFrame` com os dados a serem filtrados (`df`), a API (`api`) e os anos de interesse (`years`).

A partir disso, criamos um dicionário vazio (`data`) que armazenará os resultados. Depois, obtemos o *id* de cada deputado (primeiro laço `for`) e, para cada ano (segundo laço `for`), constrói-se a URL da requisição. Com isso, realiza-se a chamada à API, acumulando os dados retornados na lista `total_spent`.

Por último, os dados são organizados no dicionário `data`, em que cada chave corresponde ao nome do deputado (`data[depute]`) e contém suas respectivas informações de despesas [^5]. Caso o modo `debug` esteja ativado, a função também retorna as URLs utilizadas nas requisições; caso contrário, retorna apenas os dados coletados.

## Construção da interface

Para mais informações sobre os recursos disponibilizados pelo *Streamlit*, vale recorrer à [documentação oficial](https://streamlit.io/). Além disso, os tutoriais oferecidos pela equipe do *framework* ajudam a compreender a sintaxe de componentes básicos, como `st.button`.

De modo geral, há três formas principais de uso: `st.funcao(argumento)`, `with st.funcao(argumento):` e `if st.funcao(argumento):`. Por exemplo:

```{python}
# with st.funcao(argumento)
with st.expander("View all deputies", expanded=tad_expansion, width="stretch"):

            # st.funcao(argumento)
            st.write("Deputies")

# if st.funcao(argumento)
if st.button("Extract deputies", width="stretch"):

    st.write("Deputies")
```

A partir disso, podemos avançar. A forma mais simples de estruturar uma interface web com *Streamlit* é configurando a página e planejando suas duas regiões principais: a *sidebar* e a área principal (*"main"*).

```{python}
# Page configuration
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

            ### Por mês

            ### "Fornecedores"

            ### Tipos de gastos
```

Esse processo se aproxima bastante da construção de um algoritmo — ou de um [*pseudocódigo*](https://pt.wikipedia.org/wiki/Pseudoc%C3%B3digo) das funcionalidades principais [^6]. É importante destacar que essas funcionalidades e visualizações devem estar alinhadas ao objetivo geral do software e às possibilidades oferecidas pelos *endpoints* disponíveis (ou pelas variáveis que podem ser construídas na etapa de transformação dos dados). Em outras palavras, avaliar a viabilidade de cada parte do pseudocódigo ajuda a economizar tempo e esforço.

Outra vantagem desse planejamento é permitir a escolha mais adequada dos *widgets*, sempre com apoio da documentação do *Streamlit*. Por exemplo: qual a melhor forma de selecionar um período de tempo? Um *slider* ou uma seleção manual de anos? Como ambos os casos podem ser úteis, é possível oferecer as duas opções:

```{python}
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

Assim, `selected_years` passa a ser utilizado como argumento em `get_deputies_informations`:

```{python}
if st.button("'Get Deputies' Expenses", width="stretch"):

    st.session_state["selected_deputies"] = get_deputies_informations(
        st.session_state["names_list"], st.session_state["deputies"],
        api,
        selected_years, # <--
        False
    )
```

Na área principal, a interface pode ser organizada em abas (*tabs*, no *Streamlit*):

```{python}
tab_all_deputies, tab_selected_deputies = st.tabs(["All deputies (TAD)", "Selected deputies (TSD)"])

with tab_all_deputies:

    st.write("Deputies in general")

with tab_selected_deputies:

    st.write("Selected deputies")
```

Durante esse processo, é importante considerar algumas particularidades do *Streamlit*. A principal delas é que o script (geralmente `app.py`) é executado do início ao fim a cada interação do usuário. Isso pode gerar problemas com variáveis definidas condicionalmente. Por exemplo:

```{python}
import streamlit as st

with st.sidebar:
    if st.button("Clique aqui", width="stretch"):
        teste = "Texto de exemplo"

    opcao = st.selectbox("Escolha", ["Opção 1", "Opção 2"])

st.write(teste)
```

Nesse caso, a variável `teste` só existe quando o botão é acionado, e *deixa de existir* a cada interação com `st.selectbox`. Um `else` inicializando `teste` resolveria o problema? Parcialmente, pois ainda perdemos o valor `Texto de exemplo`. No contexto do *Streamlit*, a solução adequada é utilizar variáveis de sessão:

```{python}
import streamlit as st

if "teste" not in st.session_state:
    st.session_state["teste"] = None
    
with st.sidebar:
    if st.button("Clique aqui", width="stretch"):
        st.session_state["teste"] = "Texto de exemplo" # <--

    opcao = st.selectbox("Escolha", ["Opção 1", "Opção 2"])

st.write(st.session_state["teste"]) # <--
```

Dessa forma, o valor passa a persistir entre interações. Por isso, após as importações e configurações iniciais, é necessário inicializar as variáveis de `st.session_state`:

```{python}
# Import
import json
import shutil
import pandas as pd
from time import sleep
import streamlit as st
from pathlib import Path
from extract import get_deputies, get_deputies_informations
from transform import top_suppliers, total_spent, expense_types, expenses_per_month

# ...

# Checks
if "exists" not in st.session_state:
    st.session_state["exists"] = False

if "deputies" not in st.session_state:
    st.session_state["deputies"] = pd.DataFrame()

if "selected_deputies" not in st.session_state:
    st.session_state["selected_deputies"] = dict()

if "names_list" not in st.session_state:
    st.session_state["names_list"] = list()

if "poticial_party_column" not in st.session_state:
    st.session_state["poticial_party_column"] = None

if "geographic_region_column" not in st.session_state:
    st.session_state["geographic_region_column"] = None

if "ppc_view_mode" not in st.session_state:
    st.session_state["ppc_view_mode"] = "None"

if "grc_view_mode" not in st.session_state:
    st.session_state["grc_view_mode"] = "None"
```

No desenvolvimento de software, esse tipo de controle de estado (*state*, *cache*, etc.) é comum e frequentemente combinado com tratamentos de erro — como lidar com execuções fora de ordem, variáveis inexistentes ou valores inválidos. Em termos práticos, trata-se de um exercício contínuo de lógica de programação. Por exemplo, não faz sentido liberar certas funcionalidades se os dados ainda não foram carregados:

```{python}
# Reading deputies.json, if exists
if DEPUTIES_FILE.exists():

    with open(DEPUTIES_FILE, 'r', encoding="utf-8") as f:
        j = json.loads(f.read())
        st.session_state["deputies"] = pd.DataFrame.from_dict(j["dados"])

    st.session_state["exists"] = True

# Sidebar
with st.sidebar:

    api = st.text_input("Insert API", value=BASE_API, width="stretch", help="Please remove the last \"/\"!")

    if not st.session_state["exists"] or not st.session_state["deputies"].__len__() > 0:

        if st.button("Extract deputies", width="stretch"):

            deputies = get_deputies(api)

            with open(DEPUTIES_FILE, 'w', encoding="utf-8") as f:
                f.write(json.dumps(deputies, indent=4, ensure_ascii=False))

            st.success("Deputies extracted!")
```

Vejamos, então, como funciona `tab_all_deputies`:

```{python}
with tab_all_deputies:

    if st.session_state["exists"] and st.session_state["deputies"].__len__() > 0:

        with st.expander("Show all deputies", expanded=tad_expansion, width="stretch"):
            st.dataframe(st.session_state["deputies"])

        tad_col1, tad_col2 = st.columns(2)

        with tad_col1:

            st.session_state["poticial_party_column"] = st.selectbox(
                "Political Party Column",
                help="Click on \"x\" to clear your selection!",
                options=st.session_state["deputies"].keys(),
                width="stretch",
                index=None
            )

            if st.session_state["poticial_party_column"] is not None:

                counts_ppc = st.session_state["deputies"][st.session_state["poticial_party_column"]].value_counts().reset_index()
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
                            x=st.session_state["poticial_party_column"],
                            y="count",
                            width="stretch",
                            horizontal=True,
                            sort=False
                        )

                    elif st.session_state["ppc_view_mode"] == "Table (with %)":

                        st.write(counts_ppc)
```

Nesse trecho, inicialmente verificamos se existem dados carregados na sessão e se o conjunto de deputados não está vazio. Caso positivo, exibimos uma seção expansível (`st.expander`) contendo o *dataframe* com todos os deputados. Em seguida, a interface é dividida em duas colunas. Na primeira, o usuário seleciona qual coluna do `Dataframe` deseja analisar (por exemplo, partido político). Após essa escolha, calculamos a frequência de cada categoria (`.value_counts()`) e sua porcentagem em relação ao total. Os resultados podem ser exibidos como gráfico de barras (`st.bar_chart`) ou como tabela, incluindo valores absolutos e percentuais.

{% include figure.html filename="pt-or-streamlit-para-analise-exploratoria-de-dados-01.png" alt="Visual description of figure image" caption="Figura 1. Caption text to display" %}

Agora, na aba `tab_selected_deputies`:

```{python}
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

                        # ...
```

Nesse trecho, há duas operações principais: a construção do *layout* e a visualização dos dados. Após a verificação inicial, os deputados selecionados são organizados em pares para distribuição em duas colunas. Os dados são convertidos em uma lista de pares (`deputies_items`), e o laço `for i in range(0, len(deputies_items), 2)` percorre essa lista de dois em dois, representando cada “linha” da interface. Em seguida, o laço interno (`for j in range(2)`) preenche as colunas. A condição `if i + j >= len(deputies_items)` evita erros quando há um número ímpar de deputados, deixando a última célula vazia quando necessário.

Depois disso, são recuperadas informações como ID e URL da foto de cada deputado, compondo um “cartão” individual com imagem, nome e identificação. A partir desse ponto, entram as visualizações — que dependem de dados previamente tratados. Mas, *como já sabemos*, esse tratamento não deve ocorrer em `app.py`, mas sim em `transform.py`:

```{python}
# Functions
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

Essa separação mantém `app.py` mais alinhado ao princípio de responsabilidade única, além de facilitar a manutenção e compreensão do programa como um todo. Com os dados prontos, eles são exibidos em três seções expansíveis:

```{python}
monthly_expenses = expenses_per_month(expenses)

with st.expander("Expenses per month", expanded=tsd_expansion):

    st.line_chart(monthly_expenses)
    
    st.metric("Total expenses", total_expenses(
            monthly_expenses, format_brl
        )
    )
```

```{python}
with st.expander("Main suppliers", expanded=tsd_expansion):

    st.bar_chart(
        top_suppliers(expenses),
        width="stretch",
        horizontal=True,
        sort=False
    )
```

```{python}
with st.expander("Types of expenses", expanded=tsd_expansion):
                            
    st.bar_chart(
        expense_types(expenses),
        width="stretch",
        horizontal=True,
        sort=True
    )
```

{% include figure.html filename="pt-or-streamlit-para-analise-exploratoria-de-dados-02.png" alt="Visual description of figure image" caption="Figura 2. Caption text to display" %}

{% include figure.html filename="pt-or-streamlit-para-analise-exploratoria-de-dados-03.png" alt="Visual description of figure image" caption="Figura 3. Caption text to display" %}


Assim, temos: um gráfico de linha com a evolução dos gastos ao longo do tempo (acompanhado do total gasto), um gráfico com os principais fornecedores e outro com os tipos de despesas, ambos em formato de barras. Ou seja, a aplicação resulta em um painel com múltiplas visualizações organizadas, onde cada deputado selecionado possui um conjunto padronizado de visualizações, permitindo explorar diferentes dimensões de seus gastos.

## Considerações finais

Uma das recomendações mais úteis para quem desenvolve software é simples: *use a própria aplicação*. Ao utilizá-la na prática, tornam-se mais evidentes ajustes necessários, detalhes de funcionamento que podem ser aprimorados e escolhas de *design* que talvez não sejam tão intuitivas quanto pareciam inicialmente. Esse processo também ajuda a identificar onde faz sentido incluir mensagens de ajuda (argumento `help`) ou notificações mais claras ao usuário. Além disso, vale a pena testar recursos básicos de acessibilidade nas aplicações desenvolvidas.

Esta lição buscou demonstrar que aplicações relativamente simples já são suficientes para evidenciar o potencial do *Streamlit* em análises exploratórias. A ferramenta permite tanto a exploração inicial dos dados — favorecendo a formulação de perguntas de pesquisa — quanto sua aplicação em trabalhos mais estruturados, como em estudos que utilizam métodos computacionais para análise de dados complexos ([Visual and Narrative Patterns of Online Misogyny: A Computer Vision Analysis of Telegram Chats](https://doi.org/10.31235/osf.io/wvn9e_v1)).

## Notas de fim

[^1]: [Documentação da API](https://dadosabertos.camara.leg.br/swagger/api.html).
[^2]: Não trabalharemos com bancos de dados específicos, como SQL. Todos os dados são provenientes dos JSONs retornados pela API.
[^3]: Vale ressaltar que a boa delimitação do *software* é um exercício imprescindível e *anterior* a essas discussões (embora essa definição também possa evoluir conforme o desenvolvimento).
[^4]: "Abstratos" apenas por não estarem organizados em diretórios distintos.
[^5]: Há algumas vantagem de armazenar as informações dos deputados em um dicionário (`data[depute] = {"despesa": total_spent}`), como a padronização de acesso ao objeto (`data[nome][chave]`) e escalabilidade.
[^6]: O exemplo acima não é propriamente um pseudocódigo, pois não segue uma sintaxe formal ou próxima de uma linguagem de programação.
