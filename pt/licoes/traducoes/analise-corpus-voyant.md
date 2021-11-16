---
title: Análise de corpus com o Voyant Tools
authors: 
- Silvia Gutiérrez De la Torre
date: 2019-04-20 
reviewers:
- Daniela Ávido
- Jennifer Isasi 
editors:
- Jennifer Isasi
translator:
- Vânia Rosa
translation-editor:
- Jimmy Medeiros
translation-reviewer:
- Suemi Higuchi
- 
difficulty: Baixo
collection: lessons
activity: 
topics: []
abstract: "Neste tutorial você vai aprender a organizar e analizar un conjunto de textos con Voyant-Tools."
layout: lesson
review-ticket: 
---


##  Conteúdo
-   [Análise de Corpus com Ferramentas Voyant](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#an%C3%A1lisis-de-corpus-con-voyant-tools)
      -   [Análise de corpus](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#an%C3%A1lisis-de-corpus) 
      -    [O que você vai aprender neste tutorial](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#qu%C3%A9-aprender%C3%A1s-en-este-tutorial)  
    - [Criando um corpus em texto simples](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#creando-un-corpus-en-texto-plano)
	   -  [1. Procure textos](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#1-buscar-textos)
    
		-   [2. Copiar para editor de texto simples](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#2-copiar-en-editor-de-texto-plano)[Abrir opciones](https://lh4.googleusercontent.com/T61f-FWKlkVq_tTHqNXYGKmD3Amm4JOjZDA2-ZnNF43e02QLhXFZiMoZyLR2mgB_puXSYE5AmuSkpFVfPH3gImjZmlMouCTp5RXyuO4nDkZq3AQDyb7bEbBs9AWO2oW84RIqyWQp)

-   [3. Salvar arquivo](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#3-guardar-archivo)
    	-   [No Windows:](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#en-windows)
    	-   [No Mac:](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#en-mac)
    	-   [No Linux](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#en-linux)
    

-   [Carregue o corpus](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#cargar-el-corpus)
    
-   [Explorando o corpus](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#explorando-el-corpus)
    

	-   [Resumo dos documentos: características básicas do seu conjunto de textos](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#sumario-de-los-documentos-caracter%C3%ADsticas-b%C3%A1sicas-de-tu-conjunto-de-textos)
    
		-   [Número de textos, palavras e palavras únicas](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#n%C3%BAmero-de-textos-palabras-y-palabras-%C3%BAnicas)
    			-   [Atividade 1](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad)
    

		-   [Extensão de documentos](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#extensi%C3%B3n-de-documentos)
			    -   [Atividade 2](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-2)
    	-   [Densidade do vocabulário](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#densidad-del-vocabulario)
			    -   [Atividade 3](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-3)
    	-   [Palavras por frase ](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#palabras-por-oraci%C3%B3n)
			    -   [Atividade 4](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-4)
    
	-   [Cirrus e resumo: frequências e filtros de palavras vazias](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#cirrus-y-sumario-frecuencias-y-filtros-de-palabras-vac%C3%ADas)
    
		-   [Frequências não filtradas](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#frecuencias-sin-filtro)
			    -   [Atividade 5](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-5)
		   -   [Palavras vazias](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#palabras-vac%C3%ADas) 
					-   [Atividade 6](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-6)
		    -   [Frequências com palavras vazias filtradas](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#frecuencias-con-palabras-vac%C3%ADas-filtradas)
				    -   [Atividade 7](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-7)
    

	-   [Termos](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#t%C3%A9rminos)
	    -   [Frequência normalizada](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#frecuencia-normalizada)
    
		-   [Assimetria estatística](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#asimetr%C3%ADa-estad%C3%ADstica)
    
		-   [Palavras distintas](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#palabras-diferenciadas)
				    -   [Actividad 8](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-8)
    
	-   [Palavras em contexto](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#palabras-en-contexto)
			    -   [Actividad 9](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-9)    
			-   [Exportando as tabelas](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#exportando-las-tablas)
    

-   [Respostas às atividades](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#respuestas-a-las-actividades)
    -   [Atividade 1](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-1)
	   -   [Atividade 2](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-2-1)
    -   [Atividade 3](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-3-1)
    -   [Atividade 4](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-4-1)
    -   [Atividade 5](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-5-1)
    

-   [bibliografia](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#bibliograf%C3%ADa)
    
-   [Rodapé](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#notas-al-pie)
    
    
# Análise de Corpus com Ferramentas Voyant

Neste tutorial você aprenderá como organizar um conjunto de textos para pesquisa, ou seja, os passos básicos da criação de um corpus serão aprendidos. As principais métricas da análise quantitativa de texto também serão aprendidas. Para isso, pretendemos usar uma plataforma que não exija instalação (somente conexão à internet): [Voyant Tools](https://voyant-tools.org/?lang=es) (Sinclair e Rockwell, 2016). Este tutorial é o primeiro de uma série cada vez mais complexa de métodos linguísticos corpus. Nesse sentido, este texto pode ser considerado como uma das opções de análise de corpus que você pode encontrar em PH (ver por exemplo: "[Análise de Corpus com Antconc](https://programminghistorian.org/es/lecciones/analisis-de-corpus-con-antconc)").

  

## [Análise de corpus](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#an%C3%A1lisis-de-corpus)

A análise de Corpus é um tipo [de análise de conteúdo](http://vocabularios.caicyt.gov.ar/portal/index.php?task=fetchTerm&arg=26&v=42) que permite que comparações em larga escala sejam feitas em um conjunto de textos escritos ou registros orais.

Desde o início da ciência da computação, tanto linguistas computacionais quanto especialistas em [recuperação de informações](http://vocabularios.caicyt.gov.ar/portal/?task=fetchTerm&arg=178&v=42) criaram e usaram softwares para apreciar padrões que não são evidentes em uma leitura tradicional ou corroborar hipóteses que intuíram ao ler certos textos, mas que exigiam um forte trabalho, caro e mecânico. Por exemplo, para obter os padrões de uso e decadência de certos termos em um determinado momento era necessário contratar pessoas para revisar manualmente um texto e observar quantas vezes o termo pesquisado apareceu. Muito em breve, observando as capacidades de "contagem" dos computadores, esses especialistas logo escreveram programas que facilitaram a tarefa de criar listas de frequências ou tabelas de concordância (ou seja, tabelas com os contextos esquerdo e direito de um termo). O programa que você vai aprender a usar neste tutorial, está inscrito neste contexto.

## [O que você vai aprender neste tutorial](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#qu%C3%A9-aprender%C3%A1s-en-este-tutorial)

Voyant Tools é uma ferramenta baseada na Web que não requer a instalação de qualquer software especializado porque funciona em qualquer computador com conexão à Internet.

Como afirmado neste outro [tutorial,](https://programminghistorian.org/es/lecciones/analisis-de-corpus-con-antconc)esta ferramenta é uma boa porta de entrada para outros métodos mais complexos.

No final deste tutorial, você terá a capacidade de:

-   Montar um corpus em texto simples
    
-   Envie seu corpus para ferramentas Voyant
    
-   Compreenda e aplique diferentes técnicas de segmentação de corpus
    
-   Identifique características básicas do seu conjunto de textos:
    

-   Extensão de documentos enviados
    
-   Densidade léxica (chamada densidade de vocabulário na plataforma)
    
-   Palavras médias por frase
    

-   Leia e entenda diferentes estatísticas sobre as palavras: frequência absoluta, frequência normalizada, assimetria estatística e palavras diferenciadas
    
-   Pesquise palavras-chave no lugar e exporte os dados e visualizações em diferentes formatos (csv, png, html)
    

## [Criando um corpus em texto simples](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#creando-un-corpus-en-texto-plano)

Enquanto VoyantTools pode trabalhar com muitos tipos de formatação (HTML, XML, PDF, RTF e MS Word), neste tutorial usaremos texto simples (.txt). O texto simples tem três vantagens fundamentais: não possui nenhuma formatação adicional, não requer um programa especial e não requer conhecimento extra. Os passos para criar um simples corpo de texto são:

### [1. Procure textos](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#1-buscar-textos)

A primeira coisa que você deverá fazer é procurar as informações de seu interesse. Para este tutorial, [Riva Quiroga](https://twitter.com/rivaquiroga) e eu preparamos um corpus de discursos anuais de presidentes da Argentina, Chile, Colômbia, México e Peru.[1](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#fn:1) entre 2006 e 2010, ou seja, dois anos antes e depois da crise econômica de 2008. Este corpus foi lançado com uma licença [Creative Commons CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.es) e você pode usá-lo desde que cite a fonte usando o seguinte identificador: [![](https://lh3.googleusercontent.com/WsjoEcwHwnD2riYcn2ENHeOagzmtFeTR-5nXQCX-OHIGVFnCssEUXpndAhsI0kEiXGXdg7Qdtnle8IvAnl1WvvA6caUUFgmIJ1qWlfh58btI_qmNnQTwl6iUohoZvJN68nveMsGh)](https://zenodo.org/badge/143443132.svg)

### [2. Copiar para editor de texto simples](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#2-copiar-en-editor-de-texto-plano)

Uma vez que as informações estejam localizadas, o segundo passo é copiar o texto em que você está interessado desde a primeira até a última palavra e salvá-la em um simples editor de texto. por exemplo:

-   em janelas que poderia ser salvo em [bloco de notas](https://web.archive.org/web/20091013225307/http://windows.microsoft.com/en-us/windows-vista/Notepad-frequently-asked-questions)
    
-   em Mac, em [TextEdit](https://support.apple.com/es-mx/guide/textedit/welcome/mac);
    
-   e no Linux, no [Gedit.](https://wiki.gnome.org/Apps/Gedit)
    

### [3. Salvar arquivo](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#3-guardar-archivo)

Quando você salva o texto, você deve considerar três coisas essenciais:

A primeira coisa é salvar seus textos no UTF-8,que é um formato padrão de codificação para espanhol e outros idiomas.

O que é utf-8? Embora em nossa tela vemos que, ao digitar um "E" um "É" é espremido; para um computador "É" é uma série de zeros e aqueles que são interpretados e depende da imagem do "tradutor" ou "codificador" que está sendo usado. O codificador que contém códigos binários para todos os caracteres usados em espanhol é UTF-8. Continuando com o exemplo "11000011", é uma sequência de oito bits – ou seja, oito espaços de informação – que na UTF-8 são interpretados como "É".

#### [No Windows:](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#en-windows)

[![Guardar en UTF-8 en Windows: 1) Abrir Bloc de Notas, 2) Después de pegar o escribir el texto, dar clic en 'Guardar como' 3) En la ventana de 'codificiación' seleccionar 'UTF-8' 4) Elegir nombre de archivo y guardar como .txt (Torresblanca, 2014)](https://lh6.googleusercontent.com/79Zs5ARQMpmnhVFizNPOkLgxNp-mIgH7YBvgdMwyM0BskpfGuFuosd1Y3s8RjyubOBGZ4nJVaUOJErmvqqaJYa5aYUrKvW_HcnmTXj4GyvlB4DxROn09elSaRodAWfUOk0YXxZZg)](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#en-windows)

Salvar para UTF-8 no Windows: 1) Abra o bloco de notas, 2) Depois de colar ou digitar o texto, clique em 'Salvar como' 3) Na janela 'codificação' selecione 'UTF-8' 4) Escolha o nome do arquivo e salve como .txt (Torresblanca, 2014).

#### [No Mac:](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#en-mac)

[![Guardar en UTF-8 en Mac: 1) Abrir TextEdit 2) Pegar el texto que se desea guardar 3) Convertir a texto plano (opcin en el menú de 'Formato') 4) Al guardar, seleccionar el encoding 'UTF-8' (Creative Corner, 2016)](https://lh5.googleusercontent.com/D4aCJRqFHAKkMhwxuPE-GfQPtbZKa8k0QF4GQJyKw5b-2iqUxXuuyDducpJI9mrsKnHhmDs_AhT6OBVXTU0Lr0QEY54xltv-4fBcsTDL_awcilXVyI8JyeKBpCe12xZRaXigYUIh)](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#en-mac)

Salvar para UTF-8 no Mac: 1) Abra o TextEdit 2) Cole o texto que deseja salvar 3) Converta-se em texto simples (opção no menu 'Formato') 4) Ao salvar, selecione a codificação 'UTF-8' (Creative Corner, 2016)

#### [No Linux0,](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#en-linux)

[![Guardar en UTF-8 en Ubuntu: 1) Abrir Gedit 2) Después de pegar el texto, al guardar, seleccionar 'UTF-8' en la ventana de 'Codificación de caracteres'](https://lh5.googleusercontent.com/XgVinfIrzTrfLbHQubEiylF9i3TmKuOUKZuRuz_ju3ekcOvD3kW9fsFwazTTcEMv5O-rQUzerUOaxvl_0TMiJuDU1Vno8ESnhxRcsM37u5fYRysTiW1g0vDYRISPodG6GyWind1p)](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#en-linux)

Salvar para UTF-8 no Ubuntu:
	 1) Abra Gedit
	  2) Depois de colar o texto, ao salvar, selecione 'UTF-8' na janela 'Codificação de caracteres'

A segunda é que o nome do seu arquivo não deve ter sotaques ou espaços. Isso garantirá que ele possa ser aberto em outros sistemas operacionais.

Por que evitar sotaques e espaços em nomes de arquivos? Por razões semelhantes ao parágrafo anterior, um arquivo chamado Ébony.txt nem sempre será entendido corretamente por todos os sistemas operacionais porque vários têm por padrão outro codificador. Muitos usam ASCII, por exemplo, que tem apenas sete bits para que o último bit (1) de "1000011" seja interpretado como o início do próximo caractere e a interpretação não seja emoldurada.

A terceira é integrar metadados de contexto (por exemplo, data, gênero, autor, origem) no nome do arquivo que permite dividir seu corpus de acordo com diferentes critérios e também ler melhor os resultados. Para este tutorial, nomeamos os arquivos com o ano do discurso presidencial, o código do país[(ISO 3166-1 alfa-2)](https://es.wikipedia.org/wiki/ISO_3166-1#C%C3%B3digos_oficialmente_asignados)e o sobrenome da pessoa que fez o discurso.

[2007_mx_calderon.txt](https://github.com/corpusenespanol/discursos-presidenciales/blob/master/mexico/2007_mx_calderon.txt) tem o ano do discurso dividido com um hífen, o código de duas letras do país (México = mx) e o sobrenome do presidente que fez o discurso, Calderón, (sem sotaque ou eñes)

## [Carregue o corpus](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#cargar-el-corpus)

Na página de entrada do Voyant Tools, você encontrará quatro opções simples para carregar textos.[2](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#fn:2) As duas primeiras opções estão na caixa branca. Nesta caixa você pode colar diretamente um texto que você copiou de algum lugar; ou, colar endereços web – separados por vírgulas – dos sites onde os textos que você deseja analisar estão localizados. Uma terceira opção é clicar em "Abrir" e selecionar um dos dois corpus que Voyant pré-carregado (peças de Shakespeare ou romances de Austen: ambos em inglês).

Finalmente, a opção que usaremos neste tutorial. Você poderá carregar diretamente os documentos que tem para o seu computador. Neste caso, vamos carregar o [corpus completo](https://programminghistorian.org/assets/analisis-voyant-tools/corpus_presidentes.zip) de discursos presidenciais.

Para carregar os materiais, clique no ícone que diz "Upload", abra o explorador de arquivos e, deixando a tecla 'Shift' pressionada, selecione todos os arquivos que deseja analisar.

![Cargar documentos](https://lh3.googleusercontent.com/eIr4jH1eqDoxt-j-b5CZ98KnHTzkJKjl-_ewH6jLZjTylGscm9-2DhYuLqTi0Qy5q8FhFuQ65321u6lNoQEqtNkK3GrX58L3dnxgb8E2G0hcf7x4UuNyCK81ZRfzk7r_MhotalR0)

Enviar documentos

## [Explorando o corpus](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#explorando-el-corpus)

 Uma vez que todos os arquivos são carregados, você alcançará a 'interface' ('skin') que tem cinco ferramentas por padrão. Veja aqui uma breve explicação de cada uma dessas ferramentas:

-   Cirrus: nuvem de palavras mostrando os termos mais comuns
    

![Cirrus](https://lh4.googleusercontent.com/KHoX7NIqSjMp4FiJu0O9zSeYTGD71eXf_-WInBi9ZZxd_p76RslH-34qNy1hvbt7dPtpNYOoe_-DEpr9E8JQekL8BjX2u_owf1na7iUG5zhsy9vUrfCzaz-uaDgZv6EZpQ8OhRru)

cirro

Leitor: espaço para revisar e ler textos completos com um gráfico de barras que indica a quantidade de texto que cada documento tem

![Lector](https://lh5.googleusercontent.com/qi43elGxhGtA1KLqsAZNX_YLWHueayRfKlniibIR_rh10iBi-KmrSGIZb0CmrAME3PGT1E0fwxtsXS3TmRhPRKCDdWwt4tZC3705gQBn0Xh8mVRqCjaAwUU3FLKdrjY66CKwLvaF)
												Leitor


 -   Tendências: Um gráfico de distribuição que mostra os termos em todo o corpus (ou dentro de um documento quando apenas um é carregado)
    

![Tendencias](https://lh3.googleusercontent.com/6GOuBVZRFaY6lpg5SVZkVrVT-1kuakrKCvyfZi5mMiv70wWrVK_9d5v_wzgW-WjwW2LM1AZ5zkcSMA1cc6aVLRKS--2_ogBko8KWjprZCjg1PecIL2vPuJNSlIc9M0NmpTjUtemz)

								Tendências

-   Resumo: fornece uma visão geral de certas estatísticas textuais do corpus atual
    

![Sumario](https://lh5.googleusercontent.com/fSCH08hH9eJWnDVaoLjErvh79b2reTtBddtteLZKB3zBVS2QkUKxBLbdvVyVTf8nI6wA3iYnsXz8TaGFGLuaUHgeQUMHNMUIGv9LNazlFd6rLy3gpjfbQzaYxftQkcKJLuxLimLy)

Resumo

-   Contextos: Conteúdo que mostra cada ocorrência de uma palavra-chave com algum contexto circundante
    

![Contextos](https://lh5.googleusercontent.com/IVT2R2oUGvRDhtwEtHT-_48gkW25EcBjNoGGU3r9-pKoYSMebz_RBsXZ6ifXfNngZcrcT1k-0xJP9NKlo6Slj5dTfu9WFdojc13GnU6OS4DbGRor0fdBgekz409JtvYa3gfXoXaH)

Contextos

### [Resumo dos documentos: características básicas do seu conjunto de textos](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#sumario-de-los-documentos-caracter%C3%ADsticas-b%C3%A1sicas-de-tu-conjunto-de-textos)
Uma das janelas mais informativas de Voyant é o resumo. Aqui temos uma visão de olho de pássaro sobre algumas estatísticas do nosso corpus para que ele funcione como um bom ponto de partida. Nas seções a seguir, você terá uma explicação das diferentes medidas que aparecem nesta janela.

#### [Número de textos, palavras e palavras únicas](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#n%C3%BAmero-de-textos-palabras-y-palabras-%C3%BAnicas)

A primeira frase que lemos é mais ou menos assim:

Este corpus tem 25 documentos com 261.032 palavras totais e 18.550 formulários de palavra única. Criado há 8 horas [o texto é o produto de uma tradução semiautomática do inglês e é por isso que ele lê estranho.

Desde o início com essas informações sabemos exatamente quantos documentos diferentes foram carregados (25); quantas palavras existem no total (261.032); e quantas palavras únicas existem (18.550).

Nas linhas a seguir você encontrará nove atividades que podem ser resolvidas em grupos ou individualmente. Cinco deles têm respostas no final do texto para servir como guia. Os quatro últimos estão abertos à reflexão/discussão daqueles que os realizam

#### [Atividade 1](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad)

##### Se nosso corpus fosse composto de dois documentos, um diz: "Estou com fome" e outro diz: "Estou com sono", quais informações apareceriam na primeira linha do resumo?

##### Resposta: Este corpus tem _ documentos com um total de palavras de _ e _ palavras únicas.

#### [Extensão de documentos](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#extensi%C3%B3n-de-documentos)

A segunda coisa que veremos é a seção "extensão de documentos". Aparecerá o seguinte:

-   Mais longo: [2008_cl_bachelet](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (20702); [2007_ar_kircher](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (20390); [2006_ar_kircher](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (18619); [2010_cl_pinera](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (16982); [2007_cl_bachelet](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (15514)
    
-   Menor: [2006_pe_toledo](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (1289); [2006_mx_fox](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (2450); [2008_mx_calderon](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (3317); [2006_co_uribe](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (4709); [2009_co_uribe](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (5807)
    

##### [Atividade 2](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-2)

1.  O que podemos concluir sobre os textos mais longos e os mais curtos considerando os metadados no nome do arquivo (ano, país, presidente)?
    
2.  Qual é o ponto de saber a duração dos textos?
    

#### [Densidade do vocabulário](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#densidad-del-vocabulario)

A densidade do vocabulário é medida dividindo o número de palavras únicas pelo número de palavras totais. O mais próximo de um é o índice da densidade, que significa que o vocabulário tem uma maior variedade de palavras, ou seja, que é mais denso.

##### [Atividade 3](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-3)

1) Calcula a densidade das seguintes estrofes, compara e comenta:

-   Estrofe 1. De "Fool Men You Accuse" da Irmã Juana Inés de la Cruz  
    Que humor pode ser mais raro do que aquele que, sem conselhos, mancha o próprio espelho, e sente que não está claro?
    
-   Estrofe 2. De "Despacito" de Erika Ender, Luis Fonsi e Daddy Yankee  
    Passo a passo, de mansinho, de mansinho, vamos grudando aos poucos. Quando você me beija com aquela habilidade eu vejo que você é malícia com delicadeza
    

2) Leia os dados de densidade léxica dos documentos do nosso corpus, o que eles lhe dizem?

-   Maior: [2006_pe_toledo](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (0,404); [2006_co_uribe](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (0,340); [2009_co_uribe](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (0,336); [2008_co_uribe](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (0,334); [2006_mx_fox](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (0,328)
    
-   Menor: [2008_cl_bachelet](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (0,192); [2007_mx_calderon](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (0.192); [2007_ar_kircher](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (0,206); [2007_pe_garcia](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (0,214); [2010_ar_fernandez](https://voyant-tools.org/?corpus=b6f0e2c5ee1bc9b644ffda6b86a93740&panels=cirrus,reader,trends,summary,contexts#) (0.217)
    

3) Compará-los com as informações sobre sua extensão, quais notas?

#### [Palavras por oração](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#palabras-por-oraci%C3%B3n)

A forma como Voyant calcula o comprimento da sentença deve ser considerada muito aproximada, especialmente por causa da dificuldade de distinguir entre o fim de uma abreviação e a de uma frase ou outros usos de pontuação. Por exemplo, em alguns casos um ponto e vírgula marca o limite entre as frases. A análise das frases é realizada por um modelo com instruções ou "classe" da linguagem de programação Java que é chamada [breakIterator.](https://docs.oracle.com/javase/tutorial/i18n/text/about.html)

##### [Atividade 4](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-4)

1) Olhe para as estatísticas de palavra por frase (ppo) e responda: que padrão ou padrões você pode observar se considerar o índice "ppo" e os metadados do país, presidente e ano contidos no nome do documento?

2) Clique nos nomes de alguns documentos que lhe interessam pelo seu índice de "ppo". Olhe para a janela "Leitor" e leia algumas linhas. A leitura do texto original adiciona novas informações à sua leitura dos dados? Comente o porquê.

### [Cirrus e resumo: frequências e filtros de palavras vazias](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#cirrus-y-sumario-frecuencias-y-filtros-de-palabras-vac%C3%ADas)
Como temos uma ideia de algumas características globais de nossos documentos, é hora de começarmos com as características dos termos em nosso corpus. Um dos pontos de entrada mais comuns é entender o que significa analisar um texto de suas frequências.

#### [Frequências não filtradas](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#frecuencias-sin-filtro)

O primeiro aspecto que vamos trabalhar é com a frequência bruta e, para isso, usaremos a janela Cirrus.

##### [Atividade 5](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-5)

1) Quais palavras são as mais frequentes no corpus?

2) O que essas palavras do corpus nos dizem? Todas elas são significativas?

Dica: passe o mouse sobre as palavras para obter suas frequências direito

#### [Palavras vazias](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#palabras-vac%C3%ADas)

O importante não é o valor intrínseco. Sempre dependerá de nossos interesses, por isso que Voyant oferece a opção de filtrar certas palavras. Um procedimento comum para a obtenção de palavras relevantes é filtrar unidades lexicais gramaticais ou palavras vazias: artigos, preposições,interjeições, pronomes, etc. (Peña e Peña, 2015).

##### [Atividade 6](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-6)

1) Que palavras vazias estão na nuvem de palavras?

2) Quais você removeria e por quê?

Voyant já carregou uma lista de palavras de “pare” ou palavras vazias do espanhol; no entanto, podemos editá-lo da seguinte forma: 1) Coloque nosso cursor no canto superior direito da janela Cirrus e clique no ícone que parece um switch.

![Abrir opciones](https://lh4.googleusercontent.com/T61f-FWKlkVq_tTHqNXYGKmD3Amm4JOjZDA2-ZnNF43e02QLhXFZiMoZyLR2mgB_puXSYE5AmuSkpFVfPH3gImjZmlMouCTp5RXyuO4nDkZq3AQDyb7bEbBs9AWO2oW84RIqyWQp)

**Opções abertas**

2) Uma janela aparecerá com diferentes opções, selecionamos a primeira "lista editar"

![Editar lista](https://lh3.googleusercontent.com/h8vRYEX5DxVWk16gEdXaUVV_UPgbKXRc9Kyx0n0fzNyMGalDruxQJI-z9Ff6ZWZ6sg-RVTpgwHoitQNUpKNX4E1-cpQEaOiSH316nQwLU4zKi4CGsLLFpJOP9d76QHf8mz5IClhU)

3) Adicionamos as palavras "vazias", sempre separadas por uma quebra de linha (digite a tecla)‎

![Quitar palabras vacías](https://lh3.googleusercontent.com/TH4irhVP7evOn8vHUyp6u9RGg1UAejaDCeDGMyzijT3Om9hPxfxLY_ZfEqrUl1A2TsNwC_b0NhsBZ2qJStPxcDF7vzs53dUeL55J_w_ka6YMZrADDqxeJeM7BqEATUvkcfwh2vj8)

**Remova palavras vazias**

4) Uma vez que adicionamos as palavras que queremos filtrar, clicamos em "salvar" (sic).

Cuidado: por padrão, uma caixa que diz "Aplicar a tudo" é selecionada; se deixar selecionado, a filtragem de palavras afetará as métricas de todas as outras ferramentas. É muito importante que você documente suas decisões. Uma boa prática é salvar a lista de palavras vazias em um arquivo de texto (.txt) Para este tutorial criamos uma [lista de palavras para filtrar](https://programminghistorian.org/assets/analisis-voyant-tools/stopwords-es.txt) e você pode usá-la se quiser, basta lembrar que isso afetará seus resultados. Por exemplo: na lista de palavras filtradas que inclui "todos" e "todos", haverá pessoas para as quais essas palavras podem ser interessantes, pois mostram que "tudo" é muito mais usado do que "todos" e isso poderia nos dar pistas sobre o uso da linguagem inclusiva.

#### [Frequências com palavras vazias filtradas](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#frecuencias-con-palabras-vac%C3%ADas-filtradas)

Então vamos voltar para esta seção do resumo. Como dissemos na abertura anterior, as palavras filtradas afetam outros campos de Voyant. Neste caso, se você deixou a caixa "Aplicar a todos" selecionada, na lista que aparece abaixo da legenda: Palavra mais frequente no corpus, as palavras que mais se repetem serão exibidas sem contar as que foram filtradas. No meu caso, mostra:

[social](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (437); [nacional](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (427); [nosso](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (393); [investimento](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (376); [lei](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (369)

##### [Atividade 7](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-7)

1.  Reflita sobre essas palavras e quais informações elas fornecem e como essas informações são distinguidas do que você recebe ao visualizar a nuvem de palavras.
    
2.  Se você está em um grupo discuta as diferenças de seus resultados com os de outros.
    

### [Termos](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#t%C3%A9rminos)
Embora as frequências possam nos dizer algo sobre nossos textos, existem muitas variáveis que podem tornar esses números insignificantes. As seções a seguir explicarão diferentes estatísticas que podem ser obtidas na guia "Termos" ou na guia à esquerda do botão "Cirrus" no layout padrão voyant.

### [Frequência normalizada](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#frecuencia-normalizada)

Na seção anterior observamos a "frequência bruta" das palavras. No entanto, se tivéssemos um corpus de seis palavras e um corpus de 3.000 palavras, as frequências brutas não são intencionais. Três palavras em um corpus de seis palavras representam 50% do total. Três palavras em um corpus de 6.000 representam 0,1% do total. Para evitar a super-representação de um termo, os linguistas criaram outra medida chamada: "frequência relativa normalizada". Isso é calculado da seguinte forma: Frequência Bruta * 1.000.000 / Número total de palavras. Vamos olhar para um verso como um exemplo. Tome a frase, "mas meu coração diz não, diz não", que tem oito palavras no total. Se calcularmos sua frequência bruta e relativa, temos que:

palavra

frequência bruta

frequência normalizada

coração

1

1*1.000.000/8 = 125.000

Diz

2

2*1.000.000/8 = 111.000

Qual é a vantagem disso? Que se tivéssemos um corpus em que a palavra coração tivesse a mesma proporção, por exemplo, 1.000 ocorrências entre 8.000 palavras; embora a frequência bruta seja muito diferente, a frequência normalizada seria a mesma, pois 1.000 * 1.000.000/8.000 também é de 125.000.

Vamos ver como isso funciona em Voyant Tools:

1.  Na seção Cirrus, clicamos em 'Termos'. Isso abrirá uma tabela que por padrão tem três colunas: Termos (com a lista de palavras nos documentos, sem as filtradas), Contagem (com a 'frequência bruta ou líquida' de cada termo) e Tendência (com um enredo da distribuição de uma palavra levando sua frequência relativa). Para obter informações sobre a frequência relativa de um termo, na barra de nomes de coluna, à extrema direita, você clica no triângulo que oferece mais opções e em 'Colunas' você seleciona a opção 'Relativo' como mostrado na imagem abaixo:
    

![Frecuencia relativa](https://lh6.googleusercontent.com/jHA6v7lIkbsz6MXc2bfgMbF4Wof_p8P4xtgUCkQDL9WGIwuJTYhpL08GUa5ssY3QRAIOUffUObJX3hyVy6tGFsXnYBlwmbLoNods5Bm-xXTfVixIPBWXKGBFyifj5V3bS7aGMI27)

Frequência relativa

1.  Se você classificar as colunas em ordem descendente como faria em um programa de planilha, notará que a ordem da frequência bruta ('Contagem') e a frequência relativa ('Relativo') a ordem é a mesma. Então, qual é o ponto desta medida? No momento em que comparamos diferentes corpus. Um corpus é um conjunto de textos com algo em comum. Neste caso, Voyant está interpretando todos os discursos como um único corpus. Se quiséssemos que cada país fosse um corpus diferente, teríamos que salvar nosso texto em uma tabela, em HTML ou em XML, onde os metadados eram expressos em colunas (no caso da tabela) ou em tags (no caso de HTML ou XML).[3](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#fn:3)
    

#### [Assimetria estatística](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#asimetr%C3%ADa-estad%C3%ADstica)

Embora a frequência relativa não sirva para entender a distribuição do nosso corpus, existe uma medida que nos dá informações sobre o quão constante é um termo em nossos documentos: assimetria estatística.

Essa medida nos dá uma ideia da distribuição de probabilidades de uma variável sem ter que fazer sua representação gráfica. A forma como é calculado é observando os desvios de uma frequência da média, para obter se aqueles que ocorrem à direita da média (assimetria negativa) são maiores do que os da esquerda (assimetria positiva). Quanto mais perto de zero o grau de assimetria estatística, mais regular é a distribuição desse termo (ou seja, ocorre com uma média muito semelhante em todos os documentos). Algo que não é muito intuitivo é que se um termo tem uma assimetria estatística com números positivos eles significam que esse termo está abaixo da média, e quanto maior o número, mais assimétrico o termo é (ou seja, acontece muito em um documento, mas quase não ocorre no corpus). Números negativos, por outro lado, indicam que esse termo tende a ser acima da média.

![Asimetría estadística](https://lh5.googleusercontent.com/vJM81AWUgxNJk4yK1xLgmj4ykvZZwWCqicTM40OoyvU7YOxrLV_kEUBqdBOo8IjIYoY9k6uEjS6qEHiWqRhz3A8sYgM46LSC9BntyZ2FEJc0OVuPuiCuUTtXpiQ0oD_97kXU2K5O)

**Assimetria estatística**

Para obter esta medida em Voyant, temos que repetir os passos que fizemos para obter a relativa frequência, mas desta vez selecione "Skew". Essa medida permite observar, então, que a palavra "crise" por exemplo, apesar de ter uma alta frequência, não só não tem uma frequência constante em todo o corpus, mas que tende a ficar abaixo da média porque sua assimetria estatística é positiva (1,9).

#### [Palavras distintas](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#palabras-diferenciadas)

Como você já deve suspeitar, as informações mais interessantes geralmente não são encontradas dentro das palavras mais frequentes, pois estas tendem a ser as mais óbvias também. No campo da recuperação de informações, outras medidas foram inventadas que possibilitam localizar os termos que fazem um documento se destacar de outro. Uma das medidas mais utilizadas é a chamada tf-idf (frequência de termo – frequência de documentos inversos). Essa medida busca expressar numericamente o quão relevante é um documento em uma determinada coleta; ou seja, em uma coleção de textos sobre "maçãs" a palavra maçã pode ocorrer muitas vezes, mas elas não nos dizem nada de novo sobre a coleção, por isso não queremos saber a frequência bruta das palavras (frequência determo, frequência de termo),mas pesá-la sobre o quão única ou comum ela é na determinada coleção(frequência de documento inverso,frequência inversa do documento).

Em Voyant o tf-idf é calculado [da seguinte forma:](https://twitter.com/VoyantTools/status/1025458748574326784)

Frequência Bruta (tf) / Número de Palavras (N) * log10 ( Número de Documentos / Número de vezes que o termo aparece em documentos)

![Fórmula de TF-IDF](https://lh6.googleusercontent.com/4uSBwA2K0tcAYwBM71Z2_mWgHKHFpmV5oE6kOq6l8H8tLmUeTPkxBChdQdL4U2N07KLcM3WgHXLRNoW6CUnqU1nKnvF96hjR760UU5eXymF2rAVGa3jnsgO3cnQEobhr8E8Ks8_h)

Fórmula TF-IDF

##### [Atividade 8](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-8)

‎observe as ‎‎palavras distintas (em comparação com o resto do corpus)‎‎ em cada um dos documentos e note quais hipóteses você pode derivar delas‎

1.  [2006_ar_kircher](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [uruguai](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (12), [2004](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (13), [2005](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (31), [prata](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (7), [inclusão](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (16).
    
2.  [2006_cl_bachelet](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [inovação](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (15), [rodrigo](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (8), [alegremente](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (4), [barrios](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (9), [cobre](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (10).
    
3.  [2006_co_uribe](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [tutela](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5), [reeleição](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6), [royalties](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (7), [iva](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6), [publicação](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5).
    
4.  [2006_mx_fox](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [atenção](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5), [apego](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5), [federalismo](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (3), [intransigência](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (2), [fundação](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (3).
    
5.  [2006_pe_toledo](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [rendição](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5), [senhor](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (14), [senhora](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5), [amiga](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5), [tracemos](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (2).
    
6.  [2007_ar_kircher](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [2006](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (65), [Mercosul](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (12), [Uruguai](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (9), [províncias](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (16), [ano a ano](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5).
    
7.  [2007_cl_bachelet](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [macrozona](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (7), [devedores](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (12), [berço](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (9), [subsídio](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (10), [pessimismo](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (4).
    
8.  [2007_co_uribe:](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#)  [guerrilheiros](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (10), [sindicalistas](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (7), [paramilitares](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (8), [investidores](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (10) [e punts](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (7).
    
9.  [2007_mx_calderon](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [equalizar](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (9), [transformar](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (19), [tortilla](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (4), [aquíferos](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (4), [miséria](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (10).
    
10.  [2007_pe_garcia](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [huancavelica](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (9), [redistribuição](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (10), [callao](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (8), [407](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (4), [lima](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (7).
    
11.  [2008_ar_fernandez](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [endereçamento](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (17), [capítulo](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (12), [pressupostos](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5), [lesa](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (8), [articular](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5).
    
12.  [2008_cl_bachelet](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [desafio](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (18), [look](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (10), [pass](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6), [adulto](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6), [dez](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (11).
    
13.  [2008_co_uribe](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [ecopetrol](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6), [reavaliação](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (4), [jogos](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (4), [depreciação](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (3), [bilhões](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6).
    
14.  [2008_mx_calderon](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [cartel](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5), [noites](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (3), [mexicano](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6), [controlado](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (3), [federal](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6).
    
15.  [2008_pe_garcia](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [vilas](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (11), [quilômetros](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (52), [lima](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (11), [estradas](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (21), [mineiros](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (4).
    
16.  [2009_ar_fernandez](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [segurando](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (7), [liderança](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5), [coparticipação](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6), [catamarca](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (7), [pbi](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (9).
    
17.  [2009_cl_bachelet](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [selo](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5), [fortalecido](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5), [crise](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (48), [pessoas](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (24), [aplausos](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (4).
    
18.  [2009_co_uribe](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [colômbia](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (20), [estrada](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6), [contribuinte](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5), [deslocada](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6), [notificada](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (3).
    
19.  [2009_mx_calderon](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [federal](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (27), [organizado](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (10), [mudança](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (13), [proponho](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (8), [polícia](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (4).
    
20.  [2009_pe_garcia](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#): [cal](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (11), [1.500](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6), [tingo](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (4), [pampas](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (4), [desordem](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (6).
    

### [Palavras em contexto](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#palabras-en-contexto)

O projeto quel algumas histórias inauguram as Humanidades Digitais é o Índice Thomisticus, uma concordância do trabalho de Tomás de Aquino liderado pelo filólogo e religioso Roberto Busa (Hóquei, 2004), no qual dezenas de mulheres participaram da codificação (Terras, 2013). Este projeto, que levou anos para ser concluído, é uma função incorporada às Ferramentas Voyant: no canto inferior direito, na janela "Contextos", é possível consultar as concordâncias esquerda e direita de termos específicos.

A tabela que vemos tem as seguintes colunas padrão:

1.  **Documento**: Aqui está o nome do documento em que ocorre a palavra-chave de consulta
    
2.  **Esquerda**: contexto esquerdo da palavra-chave (isso pode ser modificado para cobrir mais palavras ou menos e se você clicar no celular, ele se expande para mostrar mais contexto)
    
3.  **Termos:** palavras-chave de consulta(s)
    
4.  **Direito:** contexto certo
    

Você pode adicionar a coluna Posição que indica o lugar no documento onde o termo consultado está localizado:

![Agregar columna de posición](https://lh6.googleusercontent.com/6lleoMGOBoOE588AdydTFzOsThuGQ7ov-Og0UYVi3K_Ei0BLWeD6YRMVZr6CMThL-7PZYOKB8BxF2DMb5C6SdwgJaWMQwEleMwHORLZ_zD9B54xVfC1DYBAT4QLwJPfYy-k1OXYH)

Adicionar coluna de posição

Consulta avançada Voyant permite o uso de curingas para procurar variações de uma palavra. Aqui estão algumas das combinações

-   famili*: esta consulta renderá todas as palavras que começam com o prefixo "famili" (famílias, parentes, família, família)
    
-   *tion: termos que terminam com o sufixo "tion" (poluição, militarização, fabricação)
    
-   pobreza, desigualdade: você pode procurar mais de um termo separando-os por vírgulas
    
-   "anti-pobreza":encontre a frase exata
    
-   "pobreza extrema"~ 5: procure os termos dentro das aspas, a ordem não importa, e pode haver até 5 palavras no meio (essa condição retornaria frases como "desigualdade extrema e pobreza" onde a palavra "pobreza" e "extrema" são encontradas.
    

##### [Actividad 9](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-9)

1.  Pesquise o uso de um termo que você acha interessante, use algumas das estratégias da consulta avançada.
    
2.  Classificar as linhas usando as diferentes colunas (Documento, Esquerda, Direita e Posição. Que conclusões você pode tirar sobre seus termos usando as informações nessas colunas?
    

Cuidado:a ordem da palavra na coluna "Esquerda" é inversa, ou seja, da direita para a esquerda a partir da palavra-chave.

#### [Exportando as tabelas](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#exportando-las-tablas)

Para exportar os dados, clique na caixa com seta que aparece quando você para o mouse sobre o canto direito de "Contextos". Em seguida, selecione a opção "Exportar dados atuais" e clique na última opção. Exporte todos os dados disponíveis como grade de valores separados da guia (text)grade.

Isso leva a uma página onde os campos são separados por uma guia:

![Exportar contextos](https://lh3.googleusercontent.com/7ue3ZM5iCJBTkNCs0U0jkxL1sVHqnKf2F2dTyH5l2cJAmqj9Yk_R_fl9HTQ9Ksu0I6AJSKb4Kb9uC5pKel66eLw2Irmt498CPvt6phxBRYuvOKjCOIbqaqrbKJJKFbEakBBXg5Wn)

**Contextos de Exportação**

Selecione todos os dados (Ctrl+A ou Ctrl+E);copie (Ctrl+C) e cole em uma planilha (Ctrl+V). Se isso não funcionar, salve os dados em um simples editor de texto como .txt (não se esqueça da codificação utf-8!). Em seguida importe os dados em sua planilha. No Excel isso é feito na guia "Dados" e, em seguida, "De um arquivo de texto".

![Importar datos desde un archivo de textos](https://lh5.googleusercontent.com/p2b8OLgToJAZPxdKTNyeavX6Wn6Y2tILrmAbdIxD2Mz7z2iFxw5j8hRBjsLVDxYAGUS-DgzTq7Y85zbfw2l8qMCCQshoaEFKpkj0AxGd-gqLlWvGER2tieOeL1uAGTjTV9ywN0Ym)

Importar dados de um arquivo de texto

## [Respostas às atividades](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#respuestas-a-las-actividades)

### [Actividad 1](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-1)

Este corpus tem 2 documentos com um total de 4 palavras e 3 palavras únicas (eu tenho, fome, sono)

### [Atividade 2](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-2-1)

1) Podemos observar, por exemplo, que os textos mais longos são de dois países: Chile e Argentina, e de três presidentes diferentes: Kirchner, Bachelet e Pinera. Nos mais curtos, vemos que, embora o mais curto seja do Peru, na realidade os que mais aparecem entre os curtos são os do México e da Colômbia.

2) Conhecer a duração de nossos textos nos permite compreender a homogeneidade ou disparidade do nosso corpus, bem como compreender certas tendências (por exemplo, em que os discursos tendiam a ser mais curtos, em que ponto o comprimento mudou, etc.)

### [Atividade 3](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-3-1)

1) A primeira estrofe tem 23 palavras e 20 são palavras únicas, então 20/23 equivale a uma densidade de vocabulário de 0,870; na verdade, 0,869, mas as Ferramentas Voyant completam esses números:  
[https://voyant-tools.org/?corpus=b6b17408eb605cb1477756ce412de78e](https://voyant-tools.org/?corpus=b6b17408eb605cb1477756ce412de78e).  
A segunda estrofe tem 24 palavras e 20 são palavras simples, então 20/24 equivale a uma densidade de vocabulário de 0,833:  
https://voyant-tools.org/?corpus=366630ce91f54ed3577a0873d601d714.

Como podemos ver a diferença entre um verso de Sor Juana Inés de la Cruz e outro composto por Érika Ender, Daddy Yankee e Luis Fonsi têm uma diferença de densidade de 0,037, o que não é muito alto. Devemos ter cuidado ao interpretar esses números porque eles são apenas um indicador quantitativo da riqueza do vocabulário e não incluem parâmetros como a complexidade da rima ou os termos.

Parece haver uma semelhança entre os discursos mais curtos e mais longos, isso é natural porque quanto mais curto for um texto, menos "oportunidade" há de se repetir. No entanto, isso também poderia nos dizer algo sobre os estilos de diferentes países ou presidentes. Quanto menos densidade eles são mais propensos a recorrer a recursos retóricos.

### [Atividade 4](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-4-1)

Esses resultados parecem indicar que o presidente Kirchner, além de ter os discursos mais longos, é quem faz as frases mais longas; no entanto, temos que ter cuidado com conclusões desse tipo, pois são discursos orais em que a pontuação depende de quem transcreve o texto.

### [Atividade 5](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#actividad-5-1)

1.  [a](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (5943); [mais](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (1946); [não](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (1694); [mil](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (1045); [milhões](https://voyant-tools.org/?corpus=77227f21c006f5ef083d820d77667627#) (971)
    
2.  A primeira palavra é uma preposição, a segunda um advérbio de comparação e a terceira um advérbio de negação. Essas palavras podem ser significativas se você estiver procurando entender o uso dos tipos de palavras funcionais. No entanto, se o que você está procurando são substantivos, você terá que fazer uma filtragem (ver seção: "Palavras mais frequentes")
    

## [bibliografia](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#bibliograf%C3%ADa)

Hóquei, Susan. 2004 "A História da Computação de Humanidades". Um Companheiro de Humanidades Digitais. Schreibman et al. (editores). Blackwell Publishing Ltd. doi:10.1002/9780470999875.ch1.

Peña, Gilberto Anguiano e Catalina Naumis Peña. 2015. «Extração de candidatos para mandatos a partir de um corpus da língua geral». Pesquisa da Biblioteca: Arquivos, Biblioteca e Informações 29 (67): 19-45.  
[https://doi.org/10.1016/j.ibbai.2016.02.035.](https://doi.org/10.1016/j.ibbai.2016.02.035)

Sinclair, Stéfan e Geoffrey Rockwell, 2016. Ferramentas Voyant. teia.  
[http://voyant-tools.org/.](http://voyant-tools.org/)

Terras, Melissa, 2013. "Para Ada Lovelace Day – Operações de Cartão de Soco Feminino do Padre Busa". Blog de Melissa Terras. teia.

[http://melissaterras.blogspot.com/2013/10/for-ada-lovelace-day-father-busas.html.](https://melissaterras.blogspot.com/2013/10/for-ada-lovelace-day-father-busas.html)

Este tutorial foi escrito graças ao apoio da Academia Britânica e preparado durante o Workshop de Escrita de Historiadores de Programação na Universidad de los Andes em Bogotá, Colômbia, de 31 de julho a 3 de agosto de 2018.

## [Rodapé](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#notas-al-pie)

1.  Os textos do Peru foram compilados por [Pamela Sertzen](https://twitter.com/madvivacious)  [↩](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#fnref:1)
    
2.  Existem maneiras mais complexas de carregar o corpus que [você pode consultar na documentação em inglês.](https://voyant-tools.org/docs/#!/guide/corpuscreator)  [↩](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#fnref:2)
    
3.  Para obter mais informações, consulte a documentação em inglês. [↩](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#fnref:3)
    

## SOBRE O AUTOR

Silvia Gutiérrez De la Torre é bibliotecária digital do El Colegio de México e co-fundadora da RLadiesCDMX (México). ![](https://lh6.googleusercontent.com/xYimONfXJ2wro2STgOhfgOlhWe8Ug7SVKPYTqzS66OVoAzC04hWQO9b3s9cCKM9TfNSpz8eqvmo9kGvOOo9240tKL9wKPPmllIKDCZChlSpriYhguhTMfSvEdPudwwyYtKv19oDH)

## CITAÇÃO SUGERIDA

Silvia Gutiérrez De la Torre, "Análisis de corpus con Voyant Tools", A Historiadora de Programação em Espanhol 3 (2019), https://doi.org/10.46430/phes0043.

## Faça uma doação!

## [fazer-a-doação](https://programminghistorian.org/es/lecciones/analisis-voyant-tools#haz-una-donaci%C3%B3n)

Produzir bons tutoriais de acesso aberto custa dinheiro. Junte-se ao crescente número de pessoas [que apoiam o Historiador da Programação](https://www.patreon.com/theprogramminghistorian) para que possamos continuar compartilhando conhecimento gratuitamente.
