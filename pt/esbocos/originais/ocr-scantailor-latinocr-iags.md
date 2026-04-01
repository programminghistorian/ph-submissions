---
title: "Digitalizando o passado: OCR de manuscritos históricos com ScanTailor, LatinOCR e IAGs (ChatGPT e QwenIA) - instruções metodológicas para iniciantes a partir de um estudo de caso cartuxo"
slug: ocr-scantailor-latinocr-iags
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Maria Eduarda Pôrto Garcia Barcelos
- Antônio de Oliveira Salícios Rodrigues
- Gabriel Castanho
reviewers:
- Forename Surname
- Forename Surname
editors:
- Forename Surname
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/688
difficulty: 
activity: 
topics:
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

## Índice

{% include toc.html %}

## Resumo

Esta lição apresenta um guia passo a passo voltado especialmente para estudantes e pesquisadores que estão dando os primeiros passos no trabalho com documentos históricos digitalizados. Seu objetivo é demonstrar, de maneira prática e acessível, como imagens de manuscritos e impressos antigos podem ser transformadas em textos legíveis por computadores por meio do reconhecimento óptico de caracteres (OCR), enfatizando não apenas o resultado final, mas todo o percurso técnico e interpretativo envolvido nesse processo.

Ao dialogar com outras lições já publicadas no *Programming Historian* que abordam OCR, reconhecimento automático de manuscritos e aplicações de visão computacional nas Humanidades, esta proposta se insere em um campo metodológico consolidado, mas busca avançar em duas direções específicas. Em primeiro lugar, concentra-se em documentos medievais em latim um conjunto de fontes que apresenta desafios próprios e ainda pouco explorados em guias introdutórios. Em segundo lugar, propõe uma articulação entre ferramentas clássicas de preparação de imagem e reconhecimento de texto e o uso crítico de inteligências artificiais generativas como apoio à revisão, comparação de resultados e reflexão paleográfica, sem substituir a análise humana.

O processo apresentado integra três tipos de ferramentas gratuitas e acessíveis. Inicialmente, utiliza-se o ScanTailor Advanced para o tratamento e a padronização das imagens, etapa fundamental para melhorar a qualidade do OCR. Em seguida, recorre-se ao LatinOCR, especializado no reconhecimento de textos em latim e em escritas góticas, enfrentando diretamente os limites impostos por fontes não modernas. Por fim, inteligências artificiais generativas, como ChatGPT e QwenIA, são mobilizadas de forma experimental e comparativa, auxiliando na revisão das transcrições, na identificação de inconsistências, no levantamento de observações paleográficas e, quando pertinente, na modernização controlada do latim visando a produção de edições críticas, sempre com mediação analítica do pesquisador.

Como estudo de caso, a lição trabalha com uma página da edição de *Witham Quadripetito Exercitio Cellae* (séculos XII–XIII), pertencente à coleção Analecta Cartusiana, cujo manuscrito de base encontra-se preservado na Bibliothèque Municipale de Grenoble (ms. 1089). A escolha dessa fonte permite evidenciar, de forma concreta, os desafios técnicos e interpretativos do OCR aplicado a materiais medievais, bem como discutir os impactos dessas escolhas na leitura e na construção de argumentos historiográficos.

O método apresentado foi desenvolvido no âmbito de uma pesquisa de Iniciação Científica realizada no Instituto de História da UFRJ, sob orientação do professor doutor Gabriel Castanho, com financiamento da UFRJ e do CNPq. A pesquisa, ainda em andamento, tem como objetivo aproximar estudantes e pesquisadores iniciantes das práticas das Humanidades Digitais aplicadas à História Medieval, enfatizando que a digitalização e o OCR não são apenas etapas técnicas, mas processos que influenciam diretamente a interpretação das fontes e a escrita da História.

## Introdução e Objetivo

O campo das Humanidades Digitais tem produzido, nas últimas décadas, um conjunto expressivo de softwares livres ou de baixo custo voltados à conversão de textos históricos em materiais legíveis e pesquisáveis por computador. Em geral, essas abordagens partem da digitalização de documentos e da aplicação de ferramentas de reconhecimento óptico de caracteres (OCR) sobre imagens de alta resolução, frequentemente marcadas por problemas técnicos como desfoque, angulação inadequada, sombras e iluminação irregular. A experiência apresentada nesta lição se insere nesse debate, mas parte do pressuposto de que tais dificuldades não devem ser tratadas como obstáculos, e sim como elementos centrais do processo de trabalho com fontes históricas digitalizadas.

Também em diálogo com outras lições do *Programming Historian* dedicadas ao OCR, ao reconhecimento automático de manuscritos e às aplicações de visão computacional nas Humanidades, esta proposta adota uma perspectiva metodológica voltada à formação de pesquisadores iniciantes e à realidade de acervos históricos que não passaram por processos ideais de digitalização. A lição foi construída com base em quatro princípios orientadores que atravessam todo o percurso apresentado:

* a reprodutibilidade dos procedimentos, de modo que qualquer leitor possa repetir os mesmos passos;
* o baixo custo, garantindo a acessibilidade do método;
* o rigor paleográfico, com atenção aos textos originais, às abreviações e às  variações gráficas;
* e a adequação histórica, assegurando que as escolhas técnicas estejam sempre subordinadas às perguntas da pesquisa histórica.

A principal contribuição da lição é, portanto, de natureza metodológica. Seu objetivo é democratizar práticas das Humanidades Digitais aplicadas à História, tornando acessível a historiadores e pesquisadores sem formação técnica especializada um conjunto de procedimentos que costuma ser percebido como excessivamente complexo.

Essa preocupação se mostra particularmente relevante no contexto brasileiro, onde o letramento digital ainda é desigual tanto entre estudantes, quanto entre pesquisadores da área de História. Com essa finalidade, o texto apresenta um guia de boas práticas para o uso integrado de três tipos de ferramentas: o ScanTailor Advanced, voltado ao tratamento e à padronização de imagens; o LatinOCR, especializado no reconhecimento de textos em latim; e inteligências artificiais generativas, como ChatGPT e QwenIA, utilizadas de forma crítica para comparar resultados, revisar transcrições e auxiliar na identificação de padrões paleográficos.

O objetivo central e motivador da criação do método aqui exposto é viabilizar a integração de documentação cartuxa à base de dados do CBMA (Corpus Burgundiae Medii Aevi), contribuindo para a melhoria da legibilidade dos textos e para a redução de erros de transcrição. Ao mesmo tempo, a lição enfatiza que essas ferramentas não substituem a leitura especializada do historiador, mantendo a correção humana final como etapa indispensável do processo. Dessa forma, o OCR e as inteligências artificiais são apresentados não como soluções automáticas, mas como instrumentos de apoio à pesquisa histórica, capazes de ampliar o acesso às fontes e de transformar as condições práticas de análise documental.

## Contexto do projeto e origem do método

O método apresentado nesta lição foi desenvolvido no âmbito do projeto *Impactos Historiográficos da Documentação Digital: estruturando teses e argumentos*, realizado no Instituto de História da Universidade Federal do Rio de Janeiro. A pesquisa integra um projeto de Iniciação Científica dedicado à digitalização de manuscritos cartuxos e à aplicação de ferramentas de reconhecimento óptico de caracteres em documentação medieval, com financiamento da CNPq e da própria universidade. As imagens dos livros utilizados no projeto foram captadas com apoio de financiamento do CNRS-França, no contexto de cooperações acadêmicas internacionais.

Ao longo de aproximadamente dez meses de testes sistemáticos, o projeto evidenciou que o desempenho das ferramentas de OCR está diretamente condicionado à qualidade da imagem digitalizada, confirmando a centralidade das etapas de preparação do material visual no sucesso da transcrição automática. A experimentação contínua com diferentes configurações e combinações de ferramentas permitiu observar que os melhores resultados não derivam do uso isolado de um único software, mas do cruzamento crítico dos produtos gerados em cada etapa do processo.

Nesse percurso, o ScanTailor Advanced mostrou-se fundamental para o tratamento prévio das imagens, especialmente no ajuste de contraste, alinhamento e nitidez do texto, etapas que impactam diretamente a capacidade de reconhecimento das letras. O LatinOCR, por sua vez, apresentou desempenho superior em documentos redigidos em latim e em grafias góticas, confirmando sua adequação a fontes medievais que escapam aos padrões modernos de escrita. Já as inteligências artificiais generativas, como ChatGPT e QwenIA, revelaram potencial para o reconhecimento de abreviações recorrentes e para a proposição de transcrições modernizadas, embora tenham demonstrado limitações importantes no que diz respeito à fidelidade estrita aos documentos originais, exigindo constante verificação humana.

A partir dessas constatações, o método consolidou-se como uma prática integrada, baseada na comparação de resultados e na mediação crítica do pesquisador, em vez de uma solução automatizada. É justamente esse percurso experimental que fundamenta a proposta da lição, que oferece um guia voltado a estudantes e pesquisadores interessados em reproduzir o processo utilizando ferramentas gratuitas e independentes de licenças proprietárias. Mais do que apresentar um conjunto de softwares, a lição busca explicitar as escolhas metodológicas envolvidas, mostrando como decisões técnicas aparentemente neutras influenciam diretamente a leitura das fontes e a construção de argumentos historiográficos.

## Software, dados e princípios de ciência aberta

O método apresentado nesta lição foi desenvolvido com base no uso combinado de softwares gratuitos e de código aberto, bem como de dados provenientes de acervos públicos, em consonância com os princípios da Ciência Aberta. A escolha dessas ferramentas não é apenas técnica, mas metodológica, pois busca garantir a reprodutibilidade do processo, a transparência das decisões tomadas ao longo da pesquisa e a possibilidade de que outros pesquisadores possam adaptar ou replicar os procedimentos descritos, independentemente de vínculo institucional ou acesso a softwares proprietários.

No tratamento e na preparação das imagens, empregou-se o ScanTailor Advanced (versão estável v1.0.19), um software livre licenciado sob GPLv3, voltado ao pós-processamento de imagens digitalizadas. Sua utilização mostrou-se central para etapas como ajuste de contraste, correção de alinhamento e melhoria da nitidez, aspectos que impactam diretamente o desempenho das ferramentas de OCR que viram a ser aplicadas posteriormente. Para o reconhecimento óptico de caracteres, adotou-se o LatinOCR (v1.0), desenvolvido para operar sobre o motor Tesseract OCR (versão 5.5.0), que constitui a infraestrutura técnica de base do processo. Essa combinação revelou-se particularmente adequada para textos em latim, frequentemente negligenciados por soluções de OCR voltadas a fontes contemporâneas.

De forma complementar e experimental, foram utilizadas inteligências artificiais generativas, como o ChatGPT (modelo GPT-5) e o QwenIA (modelo Qwen3-Next-80B-A3B), acessadas via navegador e suficientes, em suas versões gratuitas, para os testes descritos. Essas ferramentas não desempenham papel essencial no funcionamento do método, mas são mobilizadas como instrumentos de comparação, validação e apoio interpretativo, especialmente na identificação de abreviações recorrentes e na proposição de versões modernizadas das transcrições. A lição enfatiza, contudo, que tais recursos apresentam limites quanto à fidelidade estrita aos documentos e devem ser utilizados com cautela, sempre sob supervisão humana.

No que diz respeito aos dados, a pesquisa utiliza imagens captadas no âmbito do projeto CBMA – Corpus Burgundiae Medii Aevi-, atualmente sediado no LaMOP - Laboratoire de médiévistique occidentale de Paris (UMR 8589 / CNRS - Université de Paris 1 Panthéon-Sorbonne) - em parceria com o LATHIMM - Laboratório de Teoria e História das Mídias Medievais -, da Universidade Federal do Rio de Janeiro. Ao final da pesquisa, pretende-se disponibilizar, na base de dados do CBMA, as versões digitalizadas dos textos obtidos no decorrer do projeto, ampliando o acesso e a reutilização desse material sobre os monges cartuxos por outros pesquisadores.

Essa orientação reforça o alinhamento da lição aos princípios da Ciência Aberta, uma vez que combina o uso de softwares livres e dados públicos com a explicitação das escolhas metodológicas envolvidas. Ao tornar visível todo o percurso técnico e interpretativo, o método contribui para a democratização do conhecimento, o fortalecimento de práticas colaborativas nas Humanidades Digitais e a aproximação da pesquisa histórica de um ambiente científico mais inclusivo, acessível e compartilhável. Os programas e os dados descritos foram utilizados entre outubro de 2024 e agosto de 2025.

## Estudo de caso

O estudo de caso adotado nesta lição baseia-se em uma página do texto *Witham Quadripertito Exercitio Cellae*, datado dos séculos XII–XIII e editado e publicado na coleção Analecta Cartusiana (vol. 256), a partir do manuscrito conservado na Bibliothèque Municipale de Grenoble (ms. 1089). A escolha desse documento justifica-se tanto por seu valor histórico quanto por apresentar um grau significativo de dificuldade paleográfica, associado à língua original em latim e às características gráficas próprias da escrita medieval cartuxa. Trata-se, portanto, de uma fonte adequada para evidenciar os limites e as potencialidades das ferramentas de reconhecimento automático aplicadas a documentos não modernos.

Do ponto de vista didático, o estudo de caso foi concebido para demonstrar, de maneira prática, um fluxo mínimo de trabalho que permita comparar o desempenho entre um OCR especializado em latim, representado pelo LatinOCR, e o uso experimental de inteligências artificiais generativas, aqui ChatGPT e QwenIA. Em vez de buscar uma solução automatizada final única, a proposta enfatiza a análise crítica dos resultados obtidos, chamando atenção para os tipos de erros recorrentes, as distorções introduzidas por cada ferramenta e os ganhos possíveis quando seus outputs são analisados de forma comparativa.

Ao longo do exercício, o documento funciona como um terreno de teste que torna visíveis as escolhas metodológicas envolvidas no processo de transcrição automática, desde a preparação da imagem até a validação final do texto. O objetivo central não é apenas produzir uma transcrição mais legível, mas demonstrar a importância das boas práticas de validação humana, ressaltando que tanto o OCR especializado quanto as inteligências artificiais generativas devem ser compreendidos como instrumentos auxiliares. Dessa forma, o estudo de caso reforça a ideia de que o uso combinado dessas ferramentas, aliado à leitura paleográfica crítica, permite não apenas reduzir erros, mas também tornar explícitos os impactos das tecnologias digitais na interpretação de fontes medievais.

## Fluxo de trabalho adotado (narrativa)

O fluxo de trabalho adotado nesta lição pode ser descrito como uma sequência curta de decisões técnicas e verificações críticas. Tal sequência foi pensada visando sua reprodutibilidade por pesquisadores iniciando seu trabalho no campo da digitalização de documentos históricos escritos e que não disponham de imagens de boa qualidade. Quando necessário, a imagem é primeiramente convertida para um formato de trabalho mais conveniente (como PDF), e em seguida sendo processada via ScanTailor Advanced. Nessa etapa, o foco não é “embelezar” o documento, mas corrigir problemas que prejudicam diretamente o reconhecimento automático de carácteres gráficos escritos: desalinhamentos, sombras, baixo contraste, perda de nitidez etc.. A experiência de teste mostrou que pequenas melhorias na qualidade visual tendem a aumentar de forma sensível a precisão do OCR, porque reduzem ambiguidades na forma das letras e tornam mais consistentes os limites entre caracteres, palavras e linhas.

Com a imagem tratada, realiza-se o a leitura automática de carácteres (OCR) via LatinOCR, escolhendo perfis apropriados para o latim e observando como elementos típicos de textos medievais, sobretudo abreviações, ligaturas e variações gráficas, afetam a leitura automática. Em vez de assumir que o resultado do OCR é “o texto” final a ser estudado por historiadores, esta etapa é tratada como a geração de uma primeira hipótese de transcrição, útil justamente porque permite mapear padrões de erro: onde a ferramenta tende a confundir letras? como interpreta sinais abreviativos? quais tipos de palavras (ou trechos) se tornam mais propensos a distorções?

A seguir, os resultados são comparados com outputs obtidos por meio de inteligências artificiais generativas, como ChatGPT (via navegador, em versão gratuita) e QwenIA. Aqui, a função das IAs não é substituir o OCR especializado, mas atuar como instrumento de contraste: sugerir leituras alternativas, propor uma transcrição eventualmente modernizada e, sobretudo, ajudar a identificar regularidades nos erros produzidos pelos processos digitais. Essa comparação é útil porque evidencia diferenças de comportamento entre ferramentas: enquanto o OCR especializado tende a errar por “semelhança visual” entre caracteres, modelos generativos podem errar por “coerência linguística”, tentando completar palavras e estruturas com base em padrões prováveis, o que exige controle rigoroso para evitar que a fluência aparente encubra a perda de fidelidade ao documento.

Para tornar essa etapa comparativa segura e repetível, o método inclui a construção iterativa de “comandos” (prompts) com regras explícitas de atuação. A preocupação principal é reduzir alucinações, preservar a distinção entre elementos editoriais/eruditos/críticos presentes na página (como marcações, notas, sinais críticos e escolhas de edição) e garantir que o procedimento possa ser repetido por outras pessoas com resultados comparáveis. Como os prompts originais utilizados no projeto não podem ser reproduzidos integralmente por estarem protegidos por direitos autorais, a lição apresenta a estrutura de base que orienta sua elaboração. Essa estrutura começa pela definição clara do papel assumido pelo modelo, por exemplo, um medievalista com experiência em paleografia, edições críticas e OCR, e pela indicação objetiva da tarefa, isto é, preparar uma transcrição/edição crítica de um documento escrito medieval (incluindo ações típicas da prática paleográfica e editorial) a partir de fotografias de páginas impressas. Em seguida, o "comando" deve explicitar o contexto de uso (em nosso caso, a integração posterior do texto em uma base de dados), e adiciona-se uma lógica de controle que imponha checagem dupla e restrinja a produção a dados não verificáveis. Por fim, define-se o formato de entrega, enfatizando a fidelidade ao material fotografado e estabelecendo limites claros (como a proibição de inventar dados). Ao final, o outuput deve apresentar um relatório detalhado das ações realizadas pela inteligência artificial. A edição crítica digital e o relatório da IA poderão, assim, ser comparados, por pesquisadores, ao documento original e/ou a uma edição crítica confiável.



## Escopo, licenças e reuso

* **Softwares:** ScanTailor Advanced (licença GPLv3); LatinOCR (gratuito); ChatGPT/QwenIA (acesso gratuito é suficiente para os testes realizados).
* **Dados:** uso de acervos abertos, incluindo CBMA – Corpus de la Bourgogne du Moyen Âge.
* **Reuso:** o método foi desenhado para reprodutibilidade e adaptação por pesquisadores com baixo letramento digital.

## Passo a passo 1: edição de imagem, OCR e Inteligencias Artificiais Generativas (IAGs)

### Passo a passo (ScanTailor Advanced)

**Criar projeto**

Abra o ScanTailor Advanced → New Project. Para o Input: selecione a imagem (em nosso caso, o arquivo intitulado `DSC_4456 (6).JPG`). Para o Output: escolha uma pasta vazia. Escolha o valor de DPI: como se trata de fotografia, defina manualmente 400 dpi.

**Clique em Fix Orientation (Rotação)**

Garanta que o texto esteja “em pé”. Use Rotate se necessário. 

**Clique em Split Pages (Dividir páginas)**

A imagem apresenta duas páginas (esquerda em branco + direita com texto). Dentro da aba Split Pages: escolha Manual. Arraste a linha de divisão para separar as páginas. Se você só quer a página direita, marque a esquerda como Remove (ícone de lixeira) ou depois, em Select Pages, desmarque a esquerda para não processá-la.

**Após isso clique em Deskew (Endireitar)**

Vá em Deskew e ajuste o ângulo até as linhas ficarem horizontais. Clique em Apply to… → All selected para aplicar.

**Em seguida vá até a aba Content (Detectar conteúdo)**

Em Content, mude para Manual (melhor para fotografias). Desenhe a caixa de conteúdo apenas em torno do bloco de texto (ignore a margem externa, o aparato crítico e o miolo onde a página curva). Use Apply to… se quiser replicar nas páginas selecionadas.

**Selecione Margins (Margens finais)**

Em Margins defina margens uniformes para padronizar o recorte final. Ative Equalize se quiser que todas as páginas fiquem com a mesma “moldura”.

**Após isso clique em Dewarping (Desencurvar)**

Tendo em vista tratar-se de livro, é comum as imagens capturadas apresentarem uma leve curvatura. Em Dewarping, escolha Manual. Marque pontos nas linhas de base do texto (topo e base de alguns parágrafos) para o software “retificar” a página. Confirme quando as linhas estiverem retas.

**Por fim clique em Output (Saída)**

Escolha Mode: para OCR em latim impresso, teste: Black & White; ae o output eliminar a pontuação, use Grayscale, pois costuma preservar melhor acentos e pontuações. Na aba Despeckle: Medium (remove ruído  - sujeiras na imagem - sem perder detalhes). Em Resolution: mantenha 400 dpi. Na hora de selecionar o "Output file type": TIFF ou PNG (evite JPEG para OCR). Posto isso, clique Generate para produzir os arquivos processados na pasta de Output.

**Input**

{% include figure.html filename="pt-or-ocr-scantailor-latinocr-iags-01.jpg" alt="Visual description of figure image" caption="Figura 1. Imagem de entrada para o ScanTailor" %}

**Output**

{% include figure.html filename="pt-or-ocr-scantailor-latinocr-iags-02.jpg" alt="Visual description of figure image" caption="Figura 2. Imagem de saída do ScanTailor" %}

### Passo a passo (Tesseract / Latin OCR)

**Instalar o programa do Tesseract**

**Instalar o Latin OCR**

{% include figure.html filename="pt-or-ocr-scantailor-latinocr-iags-03.png" alt="Visual description of figure image" caption="Figura 3. Informações do LatinOCR" %}

Após a instalação, abrir a pasta na qual estão os arquivos de trabalho. Depois será preciso abrir o painel de controle. Para isso, clique com o botão direito do mouse e clique em abrir terminal. No terminal, digite o seguinte comando:

`tesseract imagem.png saida -l lat`

Neste caso, “imagem.png” é o nome do documento de imagem que se tem interesse em digitalizar. Adapte o nome ao arquivo que você pretende usar.

{% include figure.html filename="pt-or-ocr-scantailor-latinocr-iags-04.png" alt="Visual description of figure image" caption="Figura 4. Resultado no Painel de Controle Tesseract" %}

Feito isso é criado um documento nomeado "saída" com a transcrição.

{% include figure.html filename="pt-or-ocr-scantailor-latinocr-iags-05.png" alt="Visual description of figure image" caption="Figura 5. Resultado da transcrição Tesseract" %}

## Passo a passo 2: IAGs

### Chat GPT: Input e Output

**Passo a passo (Chat GPT)**

1. **Prepare os arquivos:** Esta é a etapa anterior ao envio dos arquivos para IAG e está voltada à organização (nomeação dos arquivos e disposição em pastas) e ao tratamento das imagens, ou seja, execução do processamento digital via ScanTailor visando potencializar a lisibilidade do texto (mediante adequações de nitidez, contraste, cortes, cores, alinhamentos etc.; passos descritos acima).

2. **Envio no ChatGPT:** Uma imagem por vez (mais confiável) ou pacotes de 10 (dez) imagens (mair incidência de erros). Individualmente, arraste a imagem para a interface da IAG e use o prompt, em conformidade com as diretrizes gerais indicadas acima. Em lote (até ~10), arraste todos os arquivos e use o mesmo prompt, explicitando que o output deva ser organizado por arquivo (página da edição crítica do documento).


**Input**

{% include figure.html filename="pt-or-ocr-scantailor-latinocr-iags-06.jpg" alt="Visual description of figure image" caption="Figura 6. Imagem de entrada para ChatGPT" %}

**Output:**

> De Quadripertito exercitio celle
> Grenoble, Bibliotheque Municipale ms. 1089.
> [f. 1r] Incipit Prologus in librum sequentem
> Reuerendissimo domino et patri in Christi visceribus dilectissimo B. priori
> pauperum Christi qui in Wittheham commanentes, ordinem sunt Cartusiensem
> professi, Dei servorumque Dei servus indignus, spiritualis uteri vestri filius, in
> presenti sanctitatem in merito, et in futuro felicitatem in premio.
> Si vocare liceret in ius vel patrem suum filio, vel dominum servo, nonnihil, mi
> pater reverende, mea fortassis parvitas haberet, super quo nec iniuste, ut sibi
> videtur, in vestram sub iudice magnitudinem agere posset. Nam ecce, dum
> supersedit modernorum discretionis usus de se iudicare, quid infirmitas mea
> valeret. Hinc praedicator egregius, cum omnia sibi esse concessa, negat nimirum
> omnia expedire. Ut enim quod pro tempore e loco, pro causa e modo convenit,
> imponebat iubendo pater filio, et praelatus subiecto, certe et negacio permit et
> videndum prius si ad ferendum quod imponitur sumptum sit, cum adest, sed
> carere e posse sufficiens est.
> Sane vel unumquam debet deesse, ne tunc certe sit e posse contingit non adesse.
> Haec ideo prelibaui, quia potissimum exerciciis in cella debeat intendere, qui
> sanctum ordinem Cartusiensem professus, in ea debet solitarius manere, nec
> aliquo de ea tempore, nisi causis rationabilibus exigentibus, quae iuxta eiusdem
> ordinis tenorem expressae sunt, occasione aliqua exire.
> Utile, ut verum não diffitear, opus, sed ad id solus sufficit expertus. Ego autem
> non ignoro ad haec me idoneum non esse, qui scio quidem mel esse dulce, sed
> magis auditu quam gustu. Scio também, ut ait philosophus ille, quod nescio,
> videlicet haec dicere ex sententia. Nec scio ore meo loqui quasi legens, quod
> prophetam fecisse eius notarius asseruit.
> Certe de sapientia perditio et mors dixerunt: Auribus nostris audivimus famam
> eius. Nunquid oculis suis viderunt decorem eius? Nequaquam. Nunquid faucibus
> suis perceperunt suavitatem eius? Ne hoc quidem. Solus in eis ad famam viguit
> auditus, sed nec ad speciem visus nec ad dulcedinem gustus. Et ego quid loqui
> digne possem de dulcedine cellae, quem constat, sicut negare não valeo, sic nec
> volo aliquid de ea vel tenuiter audire. Verum...

### Passo a passo (QwenIA)

Selecionar um arquivo a ser analisado. Para alcançar os resultados apresentados é preciso ser escolhido apenas um documento por vez. Feito isso, utilize o prompt desenvolvido em conformidade com as diretrizes gerais indicadas acima e envie a imagem.

**Input:**

{% include figure.html filename="pt-or-ocr-scantailor-latinocr-iags-07.png" alt="Visual description of figure image" caption="Figura 7. Interface QwenIA" %}

**Output:**

{% include figure.html filename="pt-or-ocr-scantailor-latinocr-iags-08.png" alt="Visual description of figure image" caption="Figura 8. Exemplo de Resultado QwenIA" %}

> [Texto transcrito com fidelidade à edição moderna]
> Grenoble, Bibliothèque Municipale ms. 1089.
> [ f. 1r] Incipit Prologus in librum sequentem
> Reuerend[issi]mo domino et patri in Christi vberrimus dilectissimo B. priori
> supremi Christi domui in Witherham commanentes, ordinem suum Cartusiensem
> professi, Dei seruorumque Dei seruus indignus, spiritualis vestri seruit filius, in
> spiritu sanctitatem in merito, et in futuro felicitatem in premio.
> Si forte in iussis patris mei, per ipsum sum filio, uiderer sum nonnulli, mi
> pater, reuerende, tua forsan pusillitas haberet, super quo me inuitus, ut sub
> iudicio uestrum sub iudicie magnitudinem agere posset. Nam ex more
> ueterum, ante adhortatio uestra gratia humilitatis uestra, in me sibi liceret,
> modo superioris moderandum discretionis usus et quod infirmitas me ualeret. Hinc
> adsueui quid me pro tempore coepero, id agere quod mirum omnino sit
> reum, imponat iubendo pater filio, et prelatos subiecto, censentique permitat ad
> uidendum prius si ad ferendum quod imponitur, tam onus quam quod est ad
> sustinere et posse sufficiens est. Sane uel minimum debet deesse, ne me
> quidem cum sit rare et posse contingit non mediocriter non
> iniunctam ueneranda paternitas uestra iniisse. Haec ideo praelibaui, quia
> potissimum exercitans in cella debeat intendere, qui sanctior ordinis
> Cartusiensis professus, in ea debet solitariorum uirorum orationes orare
> nisi causis rationabilibus exigentibus, quibus tamen ordinis timor et
> expresae sunt, occasione aliqua exire. Vtile, ut iterum differram, quod est
> id solus sufficit expertus. Ego autem Vtile, quod non ignoras ipse, qui
> hoc sci quidam mel esse dulce, sed quod magis / f. 1v/ id auditu quam usu esse,
> caiciam, ut ait philosophus illud, quod non scio, uidelicet hec docere non esse.
> Nec scio ore meo loqui quasi legens, quod prophetae fecisse eius notarius
> asserit. Certe de sapientia perditio et mors dixcrunt: Auribus nostris audiuimus
> famam eius. Nunquid oculis suis uident decorum eius? Nequaquam. Nunquid
> faucibus suis percipiunt suauitatem eius? Non. Sed quidam sensus alius est
> famam aliquid audiuis, sed nec ad speciem usus nec ad dulcedinem gustus. Et
> ego id quod loqui digne possum de dulcedine sapientiae, quod expertus sum
> ualeo, sic nec illoco aliquid de quo non sum expertus loqui audeo, uel
> si nihil omnino uel modicum certe aliquidque, quare qualis quantamque
> audiendi incurrere peccatum est secundus ydolatriae mendacis, pertimesco? Verum
> autem hoc scio, quod nulli est aliud genus peccati, quam id quod scriptura dicit:
> quasi hoc inflat quam quod edificat eligens, uim michi ipsi inferens, dum in
> essentem uolens qui ante fueram nolens, in istud aput Deum dignius honori
> tradens quod non accepi.
> Consequens proinde est, quod nisi ad excusandam me magnam in me
> temeritatem et presumptiones, obedientia cum caritate, caritas cum obedientia
> procedat; illis iure debeam annumerari quos asserit Apostolus esse conuersos in

## Resultados dos testes, fidelidade (QwenIA e CHAT-GPT) e leitura crítica

Os testes realizados no âmbito do projeto, a partir do prompt desenvolvido e refinado ao longo do processo, permitiram observar diferenças significativas de comportamento entre as inteligências artificiais generativas analisadas, sobretudo no que diz respeito à fidelidade textual, à preservação editorial e à necessidade de validação humana. É importante destacar que os indicadores apresentados se referem exclusivamente aos experimentos conduzidos neste estudo de caso e não devem ser entendidos como métricas universais ou generalizáveis para outros conjuntos documentais.

No caso da QwenIA, os resultados indicaram um alto índice de fidelidade textual, estimado em aproximadamente 98%, a partir da comparação direta com a edição crítica utilizada como referência. A análise do output não revelou ambiguidades significativas, e abreviações como “Reuerendissimo”, bem como variações gráficas entre *u* e *v*, mostraram-se compatíveis tanto com convenções medievais quanto com práticas da erudição acadêmica contemporânea. Um ponto digno de nota aparece no Aviso Crítico (linha 25), em que a forma “phylosophus” pode ser interpretada tanto como uma variante grafemática em relação a “philosophus” quanto como um erro tipográfico não corrigido na edição moderna, o que evidencia a necessidade de cautela ao atribuir automaticamente erros ao processo digital.

No que se refere à fidelidade editorial, a QwenIA apresentou desempenho particularmente consistente, mantendo integralmente marcações como colchetes de paginação (“[f. 1r]”, “[f. 1v]”) e notações de foliação indicadas por barras (“/”). A ausência de notas de rodapé ou de variantes manuscritas na página analisada parece estar relacionada a decisões editoriais do impresso original, e não a uma limitação direta da ferramenta. Ainda assim, a leitura crítica dos resultados reforça que esse desempenho depende fortemente de fatores como a qualidade da imagem, a configuração prévia do OCR e o escopo preciso definido no prompt. Mesmo diante de resultados com elevados índices de fidelidade ao documento impresso original, a validação humana permanece indispensável, sobretudo em análises paleográficas e diplomáticas, nas quais nuances gráficas e editoriais têm peso interpretativo significativo. Em suma, considerado nesse contexto, o uso da QwenIA com o prompt selecionado resultou em uma transcrição com alto grau de fidelidade à edição crítica, preservando inclusive aspectos de formatação, como alinhamento e espaçamento, sem ocorrência de elementos ilegíveis, ambíguos ou de alucinações, entendidas aqui como a invenção de conteúdo inexistente na fonte.

Os testes com o ChatGPT revelaram um desempenho igualmente relevante, embora com características distintas. A fidelidade textual foi estimada em torno de 95%, com produção de um texto de alta legibilidade e tipografia moderna clara, mas com menor atenção a abreviações manuscritas complexas. As principais limitações surgiram no campo da fidelidade editorial, que não atingiu o mesmo nível observado na QwenIA. Em alguns casos, abreviações e marcações editoriais foram normalizadas ou alteradas, como na linha 2, em que aparece “Reuerend[issi]mo” no lugar de “Reueren[d]issimo” presente na imagem, ou na linha 24, em que “/ f. 1v/” substitui a forma “/ [f. 1v]”. Também foram observadas pequenas divergências lexicais, como “dixcrunt” em vez de “dixerunt” na linha 27. Esses exemplos ilustram uma tendência do modelo à normalização tipográfica e à regularização gráfica, o que pode ser útil em determinados contextos, mas problemático quando o objetivo é a preservação estrita das convenções editoriais e paleográficas.

Do ponto de vista da leitura crítica, o ChatGPT apresentou um texto que preserva pontuação e capitalização de acordo com a edição moderna consultada, sem sinais evidentes de lacunas nesta página específica. No entanto, símbolos especiais, abreviações e variantes gráficas típicas do universo medieval não aparecem de forma explícita, sendo absorvidos por uma apresentação modernizada do texto. Assim, a transcrição obtida mostra boa fidelidade ao texto impresso moderno, mas exige maior atenção na etapa de revisão humana, especialmente quando o interesse da pesquisa recai sobre aspectos formais, paleográficos ou editoriais do documento.

Em conjunto, os resultados reforçam um dos argumentos centrais da lição: inteligências artificiais generativas podem oferecer ganhos significativos no apoio à transcrição e à leitura de textos medievais, mas apresentam comportamentos distintos que precisam ser compreendidos criticamente. O uso comparativo entre ferramentas, aliado a prompts cuidadosamente estruturados e à validação humana sistemática, mostra-se fundamental para evitar a naturalização de erros, normalizações excessivas ou perdas interpretativas que impactam diretamente o trabalho historiográfico.

<div class="alert alert-warning">
A maior armadilha no uso de IAGs para transcrição histórica não é o erro óbvio, mas o acerto aparente. Diferentemente do OCR tradicional (como o Tesseract), que tende a produzir 'sujeira' visual (ex: c0nfusão) quando falha, as IAGs operam por previsão estatística de palavras. Isso gera o fenômeno da 'normalização indevida': diante de uma abreviação ambígua ou de uma grafia medieval oscilante, a IA tende a substituir o termo pela sua forma clássica ou moderna mais provável estatisticamente, corrigindo silenciosamente o documento.

Esse comportamento cria uma 'fluência enganosa'. O texto final parece perfeito, gramaticalmente coeso e legível, mas pode ter apagado variações dialetais, erros do escriba original  escolhas paleográficas, editoriais ou ainda peculiaridades diplomáticas que são preciosas para o historiador. Mais grave é o risco de 'alucinação de preenchimento': em trechos manchados ou ilegíveis, onde um paleógrafo humano indicaria uma lacuna [...], a IAG pode inventar palavras inteiras que façam sentido no contexto da frase, mas que jamais existiram na página. O pesquisador deve, portanto, desconfiar de transcrições excessivamente limpas geradas por IAGs.
</div>

## Boas práticas e ética no uso de IAG para OCR histórico

O uso de inteligências artificiais generativas no apoio ao OCR histórico exige uma postura metodológica e ética cuidadosa, especialmente quando aplicado a fontes medievais e a contextos de pesquisa acadêmica. O primeiro ponto fundamental consiste no reconhecimento explícito das limitações inerentes a esses modelos, que operam a partir de padrões probabilísticos e podem reproduzir vieses linguísticos, normalizações excessivas ou inferências não sustentadas pela fonte. Superestimar suas capacidades, tratando seus outputs como equivalentes à leitura especializada do historiador, compromete o rigor científico e pode introduzir distorções difíceis de identificar a posteriori.

Nesse sentido, o uso responsável das IAGs pressupõe compreendê-las como ferramentas de apoio e não como substitutas da ação humana. Elas podem auxiliar na comparação de leituras, na identificação de padrões recorrentes e na formulação de hipóteses de transcrição, mas a decisão final deve permanecer sob controle do pesquisador, que responde tanto pelas escolhas técnicas quanto pelas interpretações historiográficas decorrentes. Manter essa distinção é essencial para preservar o caráter crítico da pesquisa histórica e evitar a automatização acrítica de práticas editoriais e paleográficas.

Questões relativas à autoria, ao plágio e à privacidade também devem ser tratadas de forma explícita. Sempre que inteligências artificiais forem utilizadas, suas intervenções precisam ser registradas e tornadas visíveis, seja na metodologia, seja na documentação dos resultados. É igualmente necessário verificar atribuições textuais, evitando a incorporação inadvertida de material não alheio à documentação origial, e assegurar a proteção de dados sensíveis quando se trabalha com acervos que não sejam integralmente públicos. A transparência nesse aspecto não apenas resguarda a integridade ética do trabalho, como também permite que outros pesquisadores avaliem criticamente o impacto dessas ferramentas no processo de pesquisa.

A ética no uso dessas ferramentas ultrapassa a questão da autoria, alcançado discussões acerca da gestão soberana dos dados científicos produzidos em um país. Ao submeter imagens de manuscritos a plataformas comerciais privadas (como as da OpenAI), o pesquisador deve estar ciente de que está enviando dados para servidores externos, cujas políticas de retenção e uso para treinamento de novos modelos são frequentemente opacas.

Mesmo trabalhando com documentos de domínio público ou acervos abertos (como o Analecta Cartusiana), deve-se considerar se o termo de uso do arquivo ou biblioteca detentora do manuscrito permite o processamento por terceiros comerciais. Além disso, existe o risco da 'caixa preta': como não temos acesso aos dados de treinamento desses modelos, é impossível saber se a IAG está realmente 'lendo' a imagem enviada ou se está completando o texto com base em edições digitais desse mesmo manuscrito que já foram absorvidas pelo seu treinamento prévio. Essa opacidade reforça a necessidade de transparência metodológica: declarar qual modelo foi usado, em qual data e com quais parâmetros é o único meio de garantir a honestidade intelectual da transcrição.

A curadoria e a validação dos resultados constituem outro eixo central das boas práticas. Isso implica comparar outputs de diferentes ferramentas e, quando aplicável, preservar marcas editoriais e gráficas relevantes e documentar de forma sistemática as decisões tomadas ao longo do processo, incluindo dúvidas e incertezas. Essa documentação não é um elemento secundário, mas parte integrante da construção do conhecimento, pois explicita os limites do método e evita a naturalização de escolhas que afetam diretamente a leitura da fonte.

Por fim, a adoção de princípios de reprodutibilidade reforça o compromisso ético e científico do uso de IAGs visando a identificação de caracteres textuais históricos. Priorizar ferramentas livres e dados abertos, registrar versões de software, modelos utilizados e parametrizações empregadas permite que o procedimento seja replicado, criticado e aprimorado por outros pesquisadores. Dessa forma, o uso de inteligências artificiais deixa de ser uma prática opaca ou individualizada e passa a integrar um ambiente de pesquisa mais transparente, colaborativo e coerente com os valores das Humanidades Digitais.

## Aplicabilidade multilíngue

Embora o núcleo técnico do método apresentado nesta lição esteja orientado ao trabalho com latim medieval, especialmente nas etapas de digitalização e de aplicação do LatinOCR, a incorporação posterior de inteligências artificiais generativas de caráter multilíngue amplia significativamente o escopo de aplicação da proposta. Ferramentas como ChatGPT e QwenIA possibilitam a comparação de leituras, a produção de versões modernizadas e a elaboração de interpretações em diferentes idiomas, como português, espanhol, francês e inglês, sem que isso implique a substituição da análise filológica ou paleográfica especializada.

Essa adaptabilidade depende fundamentalmente do ajuste cuidadoso dos comandos utilizados e do treinamento do olhar crítico do pesquisador para reconhecer nuances ortográficas, gráficas e paleográficas próprias de cada tradição documental. Em vez de propor um modelo universal e indiferenciado, o método parte do princípio de que cada idioma e cada conjunto de fontes impõem desafios específicos, que devem ser explicitados e controlados ao longo do processo. Nesse sentido, as inteligências artificiais funcionam como instrumentos flexíveis de apoio, capazes de operar em diferentes línguas, desde que suas respostas sejam constantemente avaliadas à luz das convenções históricas e editoriais pertinentes.

Dessa forma, o método não se limita às fontes latinas, ainda que nelas encontre seu campo inicial de experimentação. Ao combinar um OCR especializado com ferramentas multilíngues de interpretação e validação, a proposta se mostra aplicável a outras tradições documentais medievais e modernas, desde que respeitadas as particularidades linguísticas e paleográficas de cada corpus. Essa característica reforça o potencial do procedimento como um ponto de partida replicável para pesquisas em diferentes contextos históricos e linguísticos, ampliando seu alcance dentro das Humanidades Digitais.

## Pré-requisitos técnicos e limitações

A aplicação do método descrito nesta lição pressupõe alguns requisitos técnicos básicos, embora não exija infraestrutura avançada ou conhecimentos aprofundados de programação. Os softwares centrais do fluxo de trabalho, ScanTailor Advanced e LatinOCR, são compatíveis com os principais sistemas operacionais (Windows, macOS e Linux) e demandam apenas uma configuração inicial simples, além de capacidade gráfica moderada. As inteligências artificiais generativas utilizadas de forma complementar, como ChatGPT e QwenIA, são acessadas via navegador em suas versões gratuitas.

Do ponto de vista do desempenho, a principal limitação do método reside na qualidade da imagem original. A precisão do OCR depende diretamente de uma digitalização nítida e de um pós-processamento cuidadoso, especialmente em documentos fotografados em condições não ideais. Imagens com baixo contraste, distorções por curvatura de página ou iluminação irregular tendem a produzir resultados menos confiáveis, mesmo quando ferramentas especializadas são empregadas.

Outra limitação importante refere-se à dependência de plataformas externas no uso de inteligências artificiais generativas. Por se tratarem, em grande parte, de serviços comerciais, seus termos de uso, funcionalidades e modelos disponíveis podem ser alterados ao longo do tempo ou migrar para modalidades pagas. Por essa razão, o método enfatiza a necessidade de acompanhamento constante das atualizações dessas ferramentas e de ajustes pontuais no fluxo de trabalho sempre que necessário. Além disso, o uso de IAGs pressupõe acesso estável à internet, o que pode representar uma restrição em determinados contextos institucionais ou regionais.

É crucial destacar que o uso de versões gratuitas de modelos de linguagem (como o ChatGPT 3.5/4o-mini ou Qwen via Hugging Face/demo) impõe restrições técnicas que afetam a consistência do trabalho historiográfico. Diferentemente das versões pagas ou via API (Application Programming Interface), as interfaces gratuitas geralmente possuem uma janela de contexto menor, ou seja, elas "esquecem" instruções anteriores mais rapidamente ao processar documentos longos.

Além disso, modelos gratuitos não permitem o ajuste fino (fine-tuning) com vocabulário específico do latim medieval cartuxo, obrigando o pesquisador a depender exclusivamente da capacidade de generalização do modelo (os chamados zero-shot ou few-shot prompting, ou seja, menos referências concretas ao formato do output). Portanto, a gratuidade garante acessibilidade, mas exige um rigor redobrado na verificação, uma vez que a estabilidade do desempenho pode flutuar dependendo da carga nos servidores e das atualizações silenciosas dos modelos.

### O que o leitor aprende ao final da lição

Ao concluir esta lição, o leitor terá adquirido uma compreensão prática da importância da digitalização de qualidade e do pós-processamento de imagens no trabalho com textos históricos impressos. Em particular, compreenderá como decisões tomadas na etapa de tratamento visual, por meio do ScanTailor Advanced, impactam diretamente a legibilidade do texto e a eficácia do reconhecimento óptico de caracteres.

O leitor também aprenderá a executar OCR voltado especificamente ao latim por meio do LatinOCR, compreendendo seu funcionamento interno e sua dependência do motor Tesseract OCR, que atua como infraestrutura técnica fundamental do processo. Essa dependência não representa uma dificuldade adicional, mas sim um aspecto estrutural que permite ao LatinOCR ajustar o reconhecimento de caracteres a fontes medievais e a sistemas de abreviação paleográfica com maior precisão.

Além disso, a lição capacita o leitor a comparar criticamente transcrições produzidas por OCR especializado e por inteligências artificiais generativas, como ChatGPT e QwenIA, identificando tanto erros recorrentes quanto vantagens específicas de cada abordagem. Esse exercício conduz à elaboração de transcrições críticas, com preservação de marcações editoriais e registro explícito de decisões, incertezas e escolhas interpretativas. Em termos mais amplos, a lição oferece um caminho inicial e replicável para a transformação de textos originalmente em suporte analógico em bases de dados digitais, com atenção constante aos impactos historiográficos desse processo.

Por fim, e para além da dimensão técnica desta lição, está a demonstração reiterada do impacto heurístico e epistêmico da digitalização de documentosnno ofício de historiadores. Não se pode mais conceber que historiadores do século XXI desconheçam os condicionantes-chave de seu próprio ofício: a tecnologia não elimina a necessidade da expertise historiográfica (paleográfica, no caso desta lição); pelo contrário, ela reconfigura tal expertise, transformando-a em pré-condição para a produção de conhecimento sobre o passado! O papel do historiador passa a incluir (ou a depender fundamentalmente) a auditoria crítica de serviços automatizados.

Assim, a validação humana não é apenas uma etapa de revisão de erros de digitação, mas um processo hermenêutico. É o momento em que o pesquisador confronta a hipótese estatística da IAG com a materialidade da fonte, decidindo se uma mancha é uma abreviação ou sujeira, e se uma variante ortográfica deve ser mantida ou normalizada. O OCR e as IAGs aceleram o acesso ao conteúdo, mas a transformação desse conteúdo em informação histórica confiável permanece uma atribuição humana intransferível. A tecnologia propõe soluções; o ser humano as analisa, corrige, valida, ou não.

## Escopo, licenças e possibilidades de reuso

O método apresentado foi concebido a partir do uso de softwares livres ou de acesso gratuito, o que garante sua ampla possibilidade de reuso e adaptação. O ScanTailor Advanced é distribuído sob licença GPLv3, o LatinOCR é disponibilizado gratuitamente e o acesso gratuito às versões de ChatGPT e QwenIA mostrou-se suficiente para os testes descritos na lição. No que se refere aos dados, o trabalho baseia-se em acervos abertos, incluindo documentação vinculada ao projeto CBMA – Corpus Burgundiae Medii Aevi, o que reforça o alinhamento da proposta com os princípios da Ciência Aberta.

O escopo do método é deliberadamente introdutório e foi pensado para atender pesquisadores com baixo ou médio letramento digital, sem renunciar ao rigor historiográfico. A combinação entre reprodutibilidade, transparência metodológica e uso de ferramentas acessíveis permite que o fluxo de trabalho seja reaplicado, adaptado e criticado por outros pesquisadores, favorecendo sua circulação e aprimoramento em diferentes contextos institucionais e linguísticos.

## Autoria e agradecimentos

Esta lição foi elaborada por Antônio de Oliveira Salícios Rodrigues e Maria Eduarda Pôrto Garcia Barcelos, no contexto de pesquisa desenvolvida no Instituto de História da Universidade Federal do Rio de Janeiro sob a supervisão do Professor Doutor Gabriel Castanho (IH/UFRJ), responsável pelo desenvolvimento do método e da preparação desta lição.

Os autores agradecem à UFRJ, ao CNPq e ao CNRS pelo financiamento e apoio institucional à pesquisa que fundamenta esta proposta.

**Declaração de uso de inteligências artificiais generativas:** os autores utilizaram a ferramenta ChatGPT (modelos 4 e 5, modo thinking) em 07 de outubro de 2025 exclusivamente para atividades de brainstorming inicial, revisão de estilo, tradução preliminar e sumarização de anotações. Todas as sugestões e saídas geradas foram cuidadosamente revisadas, verificadas e validadas pelos autores. Nenhum dado pessoal, sensível ou material sob sigilo foi inserido nas ferramentas de IAG. Os prompts desenvolvidos e os trechos específicos utilizados encontram-se protegidos por direitos autorais.

## Diálogo com lições de The Programming Historian:
A presente lição dialoga com outras já publicadas em  Programming Historian. Sob diferentes ângulos, elas abordam o reconhecimento óptico de caracteres, o tratamento de manuscritos e as aplicações de visão computacional nas Humanidades. Contudo, o trabalho apresentado aqui busca avançar em direções que nenhuma das demais, isoladamente, percorre até o fim.
O primeiro caso de proximidade temática é o da lição sobre reconhecimento automático de manuscritos para grafias não latinas, que estabelece com rigor as boas práticas para a criação de  modelos HTR/OCR em contextos de escassez de dados, tais como o grego antigo e o árabe magrebino. Nossa pesquisa se situa em um passo anterior em relação a essa modelização. De fato, buscamos demonstrar os percalços atravessados para se chegar a um conjunto de dados utilizável por meio de ferramentas acessíveis, mostrando que a revisão assistida por inteligências artificiais generativas pode conduzir a transcrições corrigidas capazes de servir, num segundo momento, como material de partida para projetos de HTR. A pesquisa também desloca o foco para a práticas tradicionais do campo histórico, a saber, filológica e paleográfica.
Por sua vez, a lição de OCR com Google Vision API e Tesseract propõe combinar aplicações diferente para superar suas limitações individuais no trado de uma variedade de documentos. Aqui também exploraremos a complementaridade entre “ferramentas”, mas em sentido diferente, já que  em vez de perseguir a generalidade, partimos das especificidades de corpora medievais em latim. Ao integrar o ScanTailor Advanced como etapa anterior de preparação das imagens (etapa que outras lições não abarcam) e ao recorrer ao LatinOCR como “ferramenta” específica, evidenciamos o ganho qualitativo de uma abordagem de escopo restrito.
As duas últimas lições relacionadas a nosso  estudo formam um só único e trabalho centrado em imagens. Neles, parte-se de material já processado digitalmente para treinar modelos de deep learning voltados à classificação  topográfica de páginas de jornais.  Novamente, nossa pesquisa se situa em um ponto anterior e basilar: ao considerar o OCR como um processo de classificação de imagens de um tipo especifico, a grafia escrita lisível, evidencia-se que as decisões técnicas tomadas nessa etapa anterior determinam o que virá a ser "evidência textual" disponível para análises posteriores. 
Em conjunto, as quatro lições tratam de engenharia do dado, combinação de “ferramentas”, princípios de avaliação humana e a escalas das análises visuais em Humanidades Digitais. Temas sem dúvida capitais para os estudos históricos no século XXI. Entretanto, nenhuma delas oferece um guia introdutório no campo do tratamento basilar de imagens, nem respondem a questões específicas da medievalística aplicadas ao contexto tecnológico atual, notadamente o uso convergente entre erudição tradicional e Inteligências Artificiais Generativas. É exatamente nesses espaços que a pesquisa aqui apresentada se situa, enfatizando que a digitalização e o OCR não são apenas etapas técnicas ou simples “ferramentas”, mas constituem processos que influenciam diretamente a interpretação das fontes e a escrita da História.

* VIDAL-GORÈNE, Chahan. Reconhecimento automático de manuscritos para o teste de idiomas não latinos. The Programming Historian em português, 15 mar. 2024. Disponível em: [https://programminghistorian.org/pt/licoes/transcricao-automatica-grafias-nao-latinas](https://programminghistorian.org/pt/licoes/transcricao-automatica-grafias-nao-latinas). Acesso em: 08 jan. 2026. DOI: [https://doi.org/10.46430/phpt0046](https://doi.org/10.46430/phpt0046)
* GRIBOMONT, Isabelle; *OCR with Google Vision API and Tesseract*. Programming Historian, 31 mar. 2023. Disponível em: [https://programminghistorian.org/en/lessons/ocr-with-google-vision-and-tesseract](https://programminghistorian.org/en/lessons/ocr-with-google-vision-and-tesseract). Acesso em: 08 jan. 2026. DOI: [https://doi.org/10.46430/phen0109](https://doi.org/10.46430/phen0109)
* VAN STRIEN, Daniel; BEELEN, Kaspar; WEVERS, Melvin; SMITS, Thomas; McDONOUGH, Katherine. *Computer Vision for the Humanities: An Introduction to Deep Learning for Image Classification (Part 1)*. Programming Historian, 17 ago. 2022. Disponível em: [https://programminghistorian.org/en/lessons/computer-vision-deep-learning-pt1](https://programminghistorian.org/en/lessons/computer-vision-deep-learning-pt1?utm_source=chatgpt.com). Acesso em: 08 jan. 2026. DOI: [https://doi.org/10.46430/phen0101](https://doi.org/10.46430/phen0101)
* VAN STRIEN, Daniel; BEELEN, Kaspar; WEVERS, Melvin; SMITS, Thomas; McDONOUGH, Katherine. *Computer Vision for the Humanities: An Introduction to Deep Learning for Image Classification (Part 2)*. Programming Historian, 17 ago. 2022. Disponível em: [https://programminghistorian.org/en/lessons/computer-vision-deep-learning-pt2](https://programminghistorian.org/en/lessons/computer-vision-deep-learning-pt2). Acesso em: 08 jan. 2026. DOI: [https://doi.org/10.46430/phen0102](https://doi.org/10.46430/phen0102)
