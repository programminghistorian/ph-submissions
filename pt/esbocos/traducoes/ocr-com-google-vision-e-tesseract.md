---
title: "OCR com Google Vision API e Tesseract"
slug: ocr-com-google-vision-e-tesseract
original: ocr-with-google-vision-and-tesseract
collection: lessons
layout: lesson
date: 2023-03-31
translation_date: 2023-MM-DD
authors:
- Isabelle Gribomont
reviewers:
- Ryan Cordell
- Clemens Neudecker
editors:
- Liz Fischer
translator:
- Daniel da Silva de Araújo
translation-editor:
- Eric Brasil
translation-reviewer:
- Salete Farias
- A INDICAR
review-ticket: A INDICAR
difficulty: 2
activity: transforming
topics: [api, python, data-manipulation]
abstract: O Google Vision e o Tesseract são ambas populares e poderosas ferramentas de OCR, mas cada uma tem as suas limitações. Nesta lição, será explicado como combinar os dois para aproveitar ao máximo os seus pontos fortes individuais e obter resultados de OCR ainda mais precisos.
avatar_alt: Desenho de um aperto de mãos por cima de um livro aberto
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

# Introdução

Os historiadores que trabalham com métodos digitais e materiais baseados em texto frequentemente se deparam com ficheiros PDF que precisam ser convertidos em texto simples. Seja para análise de redes, reconhecimento de entidades nomeadas, linguística de corpus, reutilização de texto ou qualquer outro tipo de análise baseada em texto, um [Reconhecimento Ótico de Caracteres](https://pt.wikipedia.org/wiki/Reconhecimento_%C3%B3tico_de_caracteres) (OCR) de boa qualidade, que converte um PDF em um ficheiro de computador legível, será o primeiro passo. No entanto, o OCR se torna mais complicado ao lidar com fontes e caracteres históricos, manuscritos danificados ou digitalizações de baixa qualidade. Felizmente, ferramentas como [Tesseract](https://pt.wikipedia.org/wiki/Tesseract_(software)), [TRANSKRIBUS](https://app.transkribus.eu/pt), [OCR4all](https://perma.cc/W2V7-HFHF), [eScriptorium](https://perma.cc/99NE-78UV) e [OCR-D](https://cta.ifrs.edu.br/ferramentas-ocr-entenda-o-que-sao-como-funcionam-e-qual-sua-relacao-com-a-acessibilidade/) (entre outras) permitiram que estudiosos das humanidades trabalhassem com todo tipo de documento, desde cartas manuscritas do século XIX até manuscritos medievais.

Apesar dessas ótimas ferramentas, ainda pode ser difícil encontrar uma solução de OCR que se alinhe com o nosso conhecimento técnico, possa ser facilmente integrada a um fluxo de trabalho ou possa ser aplicada a um corpus multilíngue/diversificado sem exigir qualquer entrada extra do usuário. Esta lição oferece uma possível alternativa ao apresentar duas maneiras de combinar o reconhecimento de caracteres do Google Vision com a detecção de layout do Tesseract. O [Google Cloud Vision](https://cloud.google.com/vision?hl=pt-br) é uma das melhores ferramentas "prontas para uso" quando se trata de reconhecer caracteres individuais, mas, ao contrário do Tesseract, possui capacidades de reconhecimento de layout limitadas. A combinação dessas duas ferramentas cria um método "tamanho único" que gera saídas de OCR de alta qualidade para uma ampla gama de documentos.

O princípio da exploração de diferentes combinações de ferramentas para customizar fluxos de trabalho personalizados é amplamente aplicável em projetos de humanidades digitais, quando nem sempre temos ferramentas disponiveis para os nossos dados.

## Os Prós e Contras do Google Vision, Tesseract, e o poder deles combinados

### Google Vision

**Prós**

- Precisão na detecção de caracteres: Embora tenha suas limitações, o Google Vision tende a ser altamente preciso, mesmo em casos em que outras ferramentas podem ter dificuldades, como quando vários idiomas coexistem no mesmo texto. Ele está entre as melhores ferramentas "prontas para uso" quando se trata de reconhecer caracteres.
- Versatilidade: A ferramenta funciona bem em uma ampla variedade de documentos. Além disso, o Google Vision oferece outras funcionalidades, como [detecção de objetos](https://cloud.google.com/vision/docs/object-localizer?hl=pt-br) em imagens e [OCR para documentos/imagens manuscritas](https://perma.cc/2FKR-3G4N).
- Facilidade de uso: Uma vez concluída a configuração, o Google Vision é fácil de usar. Geralmente, não há necessidade de desenvolver e treinar o seu próprio modelo.
- Suporte a idiomas: No momento da escrita, o Google Vision oferece suporte completo a 60 idiomas. Além disso, 36 estão em desenvolvimento ativo e 133 estão mapeados para outro código de idioma ou para um reconhecedor de caracteres geral. Muitos idiomas indígenas, regionais e históricos estão entre os últimos. Pode ser consultada a lista completa de idiomas suportados na [documentação do Cloud Vision](https://cloud.google.com/vision?utm_source=google&utm_medium=cpc&utm_campaign=latam-BR-all-pt-dr-SKWS-all-all-trial-p-dr-1605194-LUAC0014876&utm_content=text-ad-none-any-DEV_c-CRE_547331812777-ADGP_Hybrid%20%7C%20SKWS%20-%20PHR%20%7C%20Txt%20~%20AI%20&%20ML_Vision-AI-KWID_43700066537017461-kwd-477699753821&utm_term=KW_cloud%20vision-ST_Cloud%20Vision&gclid=Cj0KCQjwmtGjBhDhARIsAEqfDEcAgn2Vrd2IAbfseJqPvQuSsGIls3IH2t1-HMzoNqoAR-n8I5aK1rwaAgFxEALw_wcB&gclsrc=aw.ds&hl=pt-br#section-6).

**Contras**

- Precisão na detecção de layout: Embora o Google Vision tenha um bom desempenho na detecção de caracteres, a detecção de layout muitas vezes é um problema.

- Endereço de email do Google e armazenamento na nuvem: Para acessar a Plataforma Google Cloud, é necessário ter um endereço de email do Google e os ficheiros PDF devem ser enviados para o Armazenamento na Nuvem do Google para serem processados.

- Sustentabilidade: O Google Cloud é conhecido por descontinuar ferramentas. Embora o Google agora tenha uma política que garante um aviso de um ano antes de descontinuar produtos, a potencial instabilidade da Plataforma Google Cloud pode ser observada.

- Custo: O serviço é gratuito para as primeiras 1000 páginas por mês. Após isso, custa US$ 1,50 por 1000 páginas. Os preços atuais em outras moedas estão disponíveis por meio dos [serviços da Plataforma Google Cloud](https://cloud.google.com/skus/). Além disso, para usar a funcionalidade de OCR do Google Vision, é necessário armazenar temporariamente seus documentos PDF no Google Storage. O armazenamento de 1GB por um mês custa US$ 0,02. Um GB representa milhares de páginas PDF. Como o custo é proporcional, se 1 GB for armazenado por 12 horas ao longo do mês, custará US$ 0,0003. Portanto, para evitar pagar, deve-se deletar os dados do Google Storage assim que o processo de OCR for concluído. Pode ser encontrado mais detalhes sobre o custo atual do Google Storage [em sua página de preços](https://cloud.google.com/storage/pricing). Embora isso não seja garantido, novas contas frequentemente vêm com créditos gratuitos.

### Tesseract

**Prós**

- Sustentabilidade: O Tesseract foi originalmente desenvolvido pela Hewlett-Packard, porém foi disponibilizado como código aberto em 2005. Desde então, uma comunidade ativa tem contribuído para o seu desenvolvimento. Ele também foi desenvolvido pela Google de 2006 a 2018.
- Custo: Gratuito.
- Precisão na detecção de layout: Em comparação com o Google Vision, o Tesseract possui um desempenho muito melhor na detecção de layout.
- Facilidade de uso: Ao contrário do Google Vision, o Tesseract não requer nenhuma configuração inicial além de baixar o software. Como é de código aberto, o Tesseract está integrado com muitas ferramentas e pode ser usado a partir da linha de comando.
- Suporte a idiomas: Atualmente, ele suporta mais de 110 idiomas, incluindo muitos idiomas e sistemas de escrita não indo-europeus.

**Contras**

- Precisão de detecção de caracteres: Em comparação ao Google Vision, Tesseract não tem uma performace tão boa com caracteres complexos (Por exemplo, caracteres históricos e ligaduras tipográficas)

### Combinando Google Vision e Tesseract

O Tesseract é uma ótima opção para texto limpo em que a tipografia não apresenta desafios específicos. O Google Vision produzirá resultados de alta qualidade em caracteres mais complexos, desde que o layout seja muito básico. Se o seu material incluir caracteres e layouts complexos (como colunas), a combinação do Google Vision e Tesseract será eficaz. Essa abordagem combina o melhor de ambos, isto é, o reconhecimento de - layout do Tesseract com o reconhecimento de caracteres do Google Vision - e tende a ter um desempenho melhor do que cada método separadamente.

#### Primeiro Método Combinado

O primeiro método para combinar as duas ferramentas OCR envolve a construção de um novo PDF a partir das imagens de cada região de texto identificada pelo Tesseract. Nesse novo PDF, as regiões de texto são empilhadas verticalmente. Isso significa que a incapacidade do Google Vision de identificar separadores de texto verticais não é mais um problema.

Este método geralmente funciona bem, mas ainda depende do Google Vision para detecção de layout. Embora o empilhamento vertical das regiões de texto reduza significativamente os erros, ainda é possível que ocorram erros, especialmente se tiver muitas regiões de texto pequenas em seus documentos. Uma desvantagem desse método é que qualquer mapeamento do facsimile/PDF de origem para o texto resultante é perdido.

#### Segundo Método Combinado

O segundo método combinado trabalha com o PDF original, mas em vez de usar a sequência de texto OCR fornecida pelo Google Vision para cada página, os ficheiros de saída em formato JSON são pesquisados em busca das palavras que estão dentro dos limites das regiões de texto identificadas pelo Tesseract. Isso é possível porque o Google Vision fornece coordenadas para cada palavra no documento.

Esse método tem a vantagem de não depender da detecção de layout do Google Vision. No entanto, a desvantagem é que quebras de linha que não foram identificadas inicialmente pelo Google Vision não podem ser facilmente reintroduzidas. Portanto, se for importante para o seu projeto que o texto OCR mantenha quebras de linha nos locais corretos, o primeiro método combinado será a melhor escolha.

Os três exemplos a seguir destacam os benefícios potenciais de usar o Google Vision, o Tesseract ou um dos métodos combinados. Cada imagem representa duas páginas do conjunto de dados que usaremos nesta lição. As saídas criadas para os trechos destacados em amarelo por cada um dos quatro métodos são detalhadas na tabela abaixo de cada imagem.

## Comparação de resultados

### Exemplo 1

{% include figure.html filename="ocr-with-google-vision-and-tesseract1.png" alt="Duas páginas escaneadas de um texto em inglês com fonte moderna e diacríticos ocasionais." caption="Figura 1: Primeiras duas páginas _A sepultura do Rei Henrique IV na Catedral de Canterbury_,
com quatro linhas destacadas indicando o texto utilizado nos resultados da OCR abaixo." %}

| Google Vision                                                          | Tesseract                                                             |
| ---------------------------------------------------------------------- | --------------------------------------------------------------------- |
| KING BENRY IV. IN THE CATHEDRAL OF CANTERBURY, AUGUST                  | KING HENRY IV. IN THE CATHEDRAL OF CANTERBURY, AUGUST                 |
| \*\* Clemens Maydestone, filius Thomæ Maydestone Armigeri, fuit        | \* \* Olemens Maydestone, filius Thoms Maydestone Armigeri, fuit      |
| Trinitatis de Howndeslow. vescendi causâ; et cum in prandio sermocina- | Trinitatis de Howndeslow vescendi eaus&; et cum in prandio sermocina- |
| quod cum a Westmonasteriâ corpus ejus versus Cantuariam in paiva       | quod eum a Westmonasterii corpus ejus versus Cantuariam in parva      |

| Método Combinado I                                                     | Método Combinado II                                                     |
| ---------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| KING HENRY IV. IN THE CATHEDRAL OF CANTERBURY, AUGUST                  | KING BENRY IV. IN THE CATHEDRAL OF CANTERBURY, AUGUST                   |
| \* "Clemens Maydestone, filius Thomæ Maydestone Armigeri, fuit         | \*\* Clemens Maydestone, filius Thomæ Maydestone Armigeri, fuit         |
| Trinitatis de Howndeslow vescendi causâ ; et cum in prandio sermocina- | Trinitatis de Howndeslow. vescendi causâ ; et cum in prandio sermocina- |
| quod cum a Westmonasteriâ corpus ejus versus Cantuariam in parva       | quod cum a Westmonasteriâ corpus ejus versus Cantuariam in paiva        |

Em ambos os exemplos, é observado que as palavras como "Thomæ" e "causâ" estão com a ortografia correta em todos os três métodos que envolvem o Google Vision, mas estão com a ortografia errada no Tesseract. Os dois métodos combinados têm um desempenho semelhante, mas o primeiro é o mais preciso, especialmente devido a uma melhoria na renderização da pontuação.

### Exemplo 2

{% include figure.html filename="ocr-with-google-vision-and-tesseract2.png" alt="Duas páginas escaneadas de um texto antigo em inglês com fundo amarelo. A primeira página é uma pequena página de título com texto em fonte gótica. A segunda página apresenta notas de rodapé dispostas em colunas." caption="Figure 2: Primeiras duas páginas de _Aelfric's Life of Saints_, com várias seções destacadas indicando o texto utilizado nos resultados de OCR abaixo." %}

| Google Vision                                                                                                                            | Tesseract                                                                                                               |
| ---------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| Aelfries Lives of Saints,                                                                                                                | Aelfrics Fives of Saints,                                                                                               |
| A Set of Sermons on Saints' Days formerly observed                                                                                       | A Set of Sermons on Saints’ Days formerly observey                                                                      |
| BY N. TRÜBNER & CO., 57 AND 59 LUDGATE HILL.                                                                                             | BY N. TRUBNER & CO., 57 AND 59 LUDGATE HILL.                                                                            |
| XXI. NATALE SANCTI SWYÐUNI, EPISCOPI.                                                                                                    | 440 XXI. NATALE SANCTI SWYDUNI, EPISCOPI.                                                                               |
| and eac da þe hrepodon þæs reafes ænigne dæl.                                                                                            | and eac Sa pe hrepodon pes reafes zenigne del .                                                                         |
| se wæs þryttig geara mid his wife on clænnysse .                                                                                         | se wes pryttig geara mid his\* wife on clennysse . 124                                                                  |
| 116. hále. <br/>119. bóc. 0. þæt (for þe). sette.<br/>117. miclum seo cyst. <br/> 1 Leaf 94, back.<br/> 2 Above the line.<br/>I do. béc. | 116. hale. 11g. béc. O. pt (for pe). sette.<br/>117. miclum seo cyst. 120. béc.<br/> 1 Leaf 94, back. ? Above the line. |

| Método Combinado I                                                                                                                   | Método Combinado II                                                                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| Aelfrie's Lives of Saints,                                                                                                           | Aelfries Lives of Saints,                                                                                                            |
| A Set of Sermons on Saints' Days formerly observed                                                                                   | A Set of Sermons on Saints' Days formerly observed                                                                                   |
| BY N. TRÜBNER & CO., 57 AND 59 LUDGATE HILL.                                                                                         | BY N. TRÜBNER & CO., 57 AND 59 LUDGATE HILL.                                                                                         |
| 440 XXI. NATALE SANCTI SWYĐUNI, EPISCOPI.                                                                                            | 440<br/>XXI. NATALE SANCTI SWYĐUNI, EPISCOPI.                                                                                        |
| and eac da þe hrepodon þæs reafes ænigne dæl.                                                                                        | and eac da þe hrepodon þæs reafes ænigne dæl.                                                                                        |
| se wæs þryttig geara mid his 2 wife on clænnysse .                                                                                   | se wæs þryttig geara mid his wife on clænnysse .                                                                                     |
| 116. hále.<br/>119. bóc. 0. þæt (for þe). sette.<br/>117. mielum seo cyst.<br/>I do. béc.<br/>1 Leaf 94, back.<br/>2 Above the line. | 116. hále.<br/>119. bóc. 0. þæt (for þe). sette.<br/>117. miclum seo cyst.<br/>I do. béc.<br/>1 Leaf 94, back.<br/>2 Above the line. |

O exemplo 2 revela a fraqueza do Google Vision em relação ao layout. Por exemplo, o Google Vision coloca a nota de rodapé 120 no final da página. No entanto, ambos os métodos combinados resolvem esse problema. Embora a saída fornecida pelo Google Vision seja de melhor qualidade geral, este exemplo também mostra que o Tesseract ocasionalmente tem um desempenho melhor do que o Google Vision no reconhecimento de caracteres. O número da nota de rodapé 120 se tornou "I do" em todas as três saídas do Google Vision.

### Exemplo 3

{% include figure.html filename="ocr-with-google-vision-and-tesseract3.png" alt="Duas páginas digitalizadas de texto em inglês com um fundo amarelado. O texto apresenta caracteres arcaicos, como o 's' longo. A primeira página é uma página de título e a segunda contém duas colunas de texto." caption="Figura 3: Duas páginas do _The Gentleman's Magazine - Volume XXVI_, com várias seções destacadas indicando o texto usado nos resultados do OCR abaixo." %}

| Google Vision                                                                                                                                                                                                                                                                                                                                                                    | Tesseract                                                                                                                                                                                                  |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| PRODESSE & DELICTARI<br/>E PLURIBUS UNUM.                                                                                                                                                                                                                                                                                                                                        | Propesse & DErEecTARE E Prvurrsavs UNUM.                                                                                                                                                                   |
| LONDON:<br/>Printed for D. Henry, and R. Cave, at St John's GATE.                                                                                                                                                                                                                                                                                                                | EON DO #:<br/>Printed for D. Hznry, and R. Cave, at St Joun’s GaTE.                                                                                                                                        |
| as negative virtue, and that abſolute in his exiſtence from the time of his re- <br/>dleneſs is impracticable. He who does formation froni evil courſes. The in- <br/>\[...\]Agreeable to this way of thinking, I Here is depoſited thi body of the ce- <br/> remember to have met with the epitaph lebrated Beau Tawdry, who wis born<br/>or an aged man four years old; dating | Acreeable to this way of thinking, I<br/> remember to have met with ehe epitaph<br/> oF an uged man tour years old 5 Gating<br/> his exiſtence from the time of his re- <br/> formation from evil courſes. |

| Método Combinado I                                                                                                                                                                                         | Método Combinado II II                                                                                                                                                                          |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| PRODESSE & DELICTARI<br/>E PLURIBUS UNUM.                                                                                                                                                                  | PRODESSE & DELICTARI<br/>E PLURIBUS UNUM.                                                                                                                                                       |
| L O N D ON:<br/>Printed for D. Henry, and R. Cave, at St John's Gate.                                                                                                                                      | LONDON:<br/>Printed for D. Henry, and R. Cave, at St John's GATE.                                                                                                                               |
| Agreeable to this way of thinking, I<br/> remember to have met with the epitapha<br/> or an aged mau four years old; dating<br/> his exiſtence from the time of his re- <br/> formation from evil courſes. | Agreeable to this way of thinking, I remember to have met with the epitaph or an aged man four years old; dating <br/>his exiſtence from the time of his re- <br/> formation froni evil courſes |

O exemplo 3 demonstra como as colunas resultam em uma saída completamente errônea do Google Vision. A ferramenta raramente leva em conta as separações verticais de texto e lê através das colunas. Ambos os métodos combinados permitem resolver esse problema.

A diferença entre as saídas produzidas pelos dois métodos combinados é mínima. No entanto, as quebras de linha no final das colunas esquerdas não estão presentes na saída do segundo método combinado. Esse método utiliza o PDF original e, como o Google Vision lê através das colunas, essas quebras de linha simplesmente não foram registradas.

# Preparação

## Pré-requisitos

Embora seja adequada para iniciantes, esta lição pressupõe alguma familiaridade com a linguagem de programação Python. Caso não conheça o Python 3 completamente, entenderá melhor o código usado aqui se seguir a [série de lições sobre Python](/pt/licoes/introducao-instalacao-python) primeiro. A série de lições sobre Python ensinará como instalar o Python 3 e baixar um editor de texto onde será escrito o seu código.

## Exemplo de Dataset

É possível seguir esta lição com qualquer documento em PDF disponível, sendo recomendado o uso de pelo menos dois documentos, pois a lição aborda a realização do OCR em vários ficheiros simultaneamente. Os documentos devem ser colocados em um diretório denominado `docs_to_OCR`, por exemplo.

Como alternativa, é possível utilizar o mesmo conjunto de três edições do século XIX de documentos medievais que serão usados como exemplos ao longo desta lição. Caso opte por isso, comece fazendo o [download do conjunto de ficheiros](/assets/ocr-with-google-vision-and-tesseract/ocr-with-google-vision-and-tesseract-data.zip). Descompacte-o e renomeie a pasta para `docs_to_OCR`.

Esses três documentos são de domínio público e estão disponíveis no [archive.org](https://archive.org/).

# OCR com Tesseract

O Tesseract aceita ficheiros de imagem como entrada. Se houver ficheiros PDF, é possível convertê-los em ficheiros .tiff usando qualquer ferramenta de edição de imagem, como o [ImageMagick](https://imagemagick.org/), por exemplo. O processo de conversão de PDFs para TIFFs usando o ImageMagick é detalhado na lição _Programming Historian_ [OCR and Machine Translation](/en/lessons/OCR-and-Machine-Translation#converting-pdfs-to-tiffs-with-imagemagick).

Alternativamente, pode-se usar o OCRmyPDF. Este software é baseado no Tesseract, mas funciona com ficheiros PDF. Mais informações podem ser encontradas na lição _Programming Historian_ [Working with batches of PDF files](/en/lessons/working-with-batches-of-pdf-files)

Tanto o ImageMagick quanto o OCRmyPDF podem ser operados pela linha de comando.

Se optar por usar o OCRmyPDF, execute os seguintes comandos após navegar até o diretório `docs_to_OCR`.

Primeiro comando:

```
ocrmypdf -l eng+lat --redo-ocr --sidecar
JHS_1872_HenryIVandQueenJoanCanterburyCathedral.txt
JHS_1872_HenryIVandQueenJoanCanterburyCathedral.pdf
JHS_1872_HenryIVandQueenJoanCanterburyCathedral_ocr.pdf
```

Segundo comando:

```
ocrmypdf -l eng+enm --redo-ocr --sidecar
Skeat_1881_StSwithunExhumation_MiddleEnglish.txt
Skeat_1881_StSwithunExhumation_MiddleEnglish.pdf
Skeat_1881_StSwithunExhumation_MiddleEnglish_ocr.pdf`
```

Terceiro comando:

```
ocrmypdf -l eng --redo-ocr --sidecar
Anon_1756_Epitaphs.txt
Anon_1756_Epitaphs.pdf
Anon_1756_Epitaphs_ocr.pdf
```

Com o Tesseract, é necessário especificar o(s) idioma(s) ou script(s) do texto usando a opção `-l`. Mais de um idioma ou script podem ser especificados usando o sinal de `+`. Pode-se encontrar a lista de códigos de idioma e mais informações sobre os modelos de idioma na [página do GitHub do Tesseract](https://perma.cc/HP8K-US5M). Dependendo do seu sistema operacional, talvez seja necessário instalar pacotes de idioma separadamente, conforme descrito na [página de documentação](https://perma.cc/G9JR-NXA3) do OCRmyPDF.

O OCRmyPDF cria um novo ficheiro PDF com uma sobreposição de OCR. uma sobreposição de OCR (presumivelmente insatisfatória), o argumento `redo-ocr` permite criar uma nova sobreposição. O argumento `sidecar` cria um ficheiro de texto que contém o texto OCR encontrado pelo OCRmyPDF. Uma alternativa ao argumento `sidecar` seria usar outro programa, como o [pdftotext](https://perma.cc/K9GT-NBGR), para extrair os textos incorporados dos novos ficheiros PDF criados.

# OCR com Google Vision

### Configuração da Google Cloud Platform

Para poder usar a API do Google Vision, o primeiro passo é configurar o seu projeto no [Google console](https://console.cloud.google.com/). As instruções para cada etapa estão vinculadas abaixo. Embora a documentação da Google Cloud possa parecer intimidadora se não estiver familiarizado com os serviços de API, o processo de criação de um projeto pessoal é relativamente simples e muitas das páginas de documentação da Google incluem instruções práticas passo a passo. Pode-se configurar o seu projeto tanto pela interface da console em seu navegador (recomendado para iniciantes) quanto com código, caso deseje integrar essas etapas diretamente em seu script.

1\. [Crie um novo projeto no Google Cloud](https://cloud.google.com/resource-manager/docs/creating-managing-projects?hl=pt-br#console)

Antes de utilizar qualquer um dos serviços da API do Google, é necessário criar um projeto. Cada projeto pode ter diferentes APIs habilitadas e estar vinculado a uma conta de faturamento diferente.

2\. [Vincule seu projeto a uma conta de faturamento.](https://cloud.google.com/billing/docs/how-to/manage-billing-account?hl=pt-br)

Para usar a API, é necessário vincular o projeto a uma conta de faturamento, mesmo que esteja planejando usar apenas a porção gratuita do serviço ou utilizar quaisquer créditos gratuitos que tenha recebido como novo usuário.

3\. [Habilite o Cloud Vision API](https://cloud.google.com/endpoints/docs/openapi/enable-api?hl=pt-br)

As APIs do Google precisam ser habilitadas antes de serem utilizadas. Para habilitar a Vision API, é necessário procurá-la na biblioteca de APIs do Google Cloud. Lá, é possível encontrar outras APIs oferecidas pelo Google, como a Cloud Natural Language API, que fornece tecnologias de compreensão de linguagem natural, e a Cloud Translation API, que permite integrar tradução em um fluxo de trabalho.

4\. [Crie uma conta de serviço no Google Cloud](https://cloud.google.com/iam/docs/service-accounts-create?hl=pt-br#creating)

Para fazer solicitações a uma API do Google, é necessário usar uma conta de serviço, que é diferente da conta de usuário do Google. Uma conta de serviço está associada a uma chave de conta de serviço (veja o próximo passo). Nesta etapa, é preciso criar uma conta de serviço e conceder a ela acesso ao um projeto. Selecione 'Owner' (Proprietário) no menu suspenso de função para conceder acesso total.

5\. [Faça download e salve a chave da conta de serviço](https://cloud.google.com/iam/docs/keys-create-delete?hl=pt-br#creating)

A chave da conta de serviço é um ficheiro JSON que pode ser criado e feito o download a partir do Console do Google Cloud. Ele é usado para identificar a conta de serviço da qual as solicitações da API estão sendo feitas. Para acessar a Vision API por meio do Python, é necessário incluir o caminho para esse ficheiro no seu código.

6\. [Crie um Google bucket](https://cloud.google.com/storage/docs/creating-buckets?hl=pt-br)

No Cloud Storage, os dados são armazenados em 'buckets' (recipientes). Embora seja possível fazer o upload de pastas ou ficheiros para buckets por meio do navegador, essa etapa está integrada no código fornecido abaixo.

### Configuração do Python

É sempre melhor criar um novo ambiente virtual quando inicia um projeto em Python. Isso significa que cada projeto pode ter suas próprias dependências, independentemente das dependências de outros projetos. Para fazer isso, pode-se usar o [conda](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) ou [venv](https://docs.python.org/3/library/venv.html), por exemplo.

Para este projeto, eu recomendaria instalar todas as bibliotecas e pacotes por meio do conda.

Instale as bibliotecas [Cloud Storage](https://cloud.google.com/python/docs/reference/storage/latest) e [Cloud Vision](https://cloud.google.com/python/docs/reference/vision/latest):

```
conda install -c conda-forge google-cloud-vision
conda install -c conda-forge google-cloud-storage
```

O código abaixo adapta o código fornecido na [documentação do Google Vision](https://cloud.google.com/vision/docs?hl=pt-br) para trabalhar com lotes de ficheiros em vez de ficheiros individuais e salvar as saídas de texto completo.

O Google Vision aceita apenas ficheiros individuais armazenados em _buckets_ (recepientes) do Cloud Storage como entrada. Portanto, o código itera por um diretório local para fazer upload do ficheiro no Cloud Storage, solicitar a anotação de texto completo do PDF, em seguida ler os ficheiros de saída [JSON](https://pt.wikipedia.org/wiki/JSON) armazenados no Cloud Storage e salvar as respostas de OCR de texto completo localmente.

Para começar, é necessário importar as bibliotecas (`google-cloud-storage` e `google-cloud-vision`) feito anteriormente, bem como as bibliotecas internas `os`, `json` e `glob`.

```
import os
import json
import glob
from google.cloud import vision
from google.cloud import storage
```

Em seguida, é necessário fornecer o nome do bucket do Google Cloud Storage e o caminho para a chave de conta de serviço JSON.

```
bucket_name='BUCKET-NAME'
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'PATH/TO/YOUR/ServiceAccountKey.json'
```

Então, é possível criar variáveis para os diferentes processos necessários no código:

```
# Instancie um cliente para as bibliotecas de cliente 'storage' e 'vision', e os serviços que deseja usar, ou seja, a DETECÇÃO_DE_TEXTO_DE_DOCUMENTO do serviço ImageAnnotator
storage_client = storage.Client()
vision_client = vision.ImageAnnotatorClient()
bucket = storage_client.get_bucket(bucket_name)
feature = vision.Feature(type_=vision.Feature.Type.DOCUMENT_TEXT_DETECTION)

#O formato de ficheiro utilizado (a alternativa é 'image/tiff' quando se trabalha com ficheiros de imagem .tiff em vez de PDFs).
mime_type = 'application/pdf'

#O número de páginas que serão agrupadas em cada ficheiro de resposta JSON
batch_size = 2
```

Quanto maior o tamanho do lote, mais rápido será o progresso. No entanto, um tamanho de lote muito grande pode fazer com que o Python "trave" se a memória do seu computador ficar sobrecarregada.

### Executando o Google Vision

A primeira etapa é criar uma função que faz o upload de um ficheiro para o seu bucket do Google Cloud Storage e solicita a anotação OCR com as informações especificadas acima. A solicitação criará ficheiros JSON contendo todas as informações de OCR, que também serão armazenados no seu bucket.

Esta função retorna o caminho remoto da pasta onde os ficheiros de resposta JSON estão armazenados para que possam ser facilmente recuperados na próxima etapa.

```
def JSON_OCR(input_dir, filename):
  # Cria um caminho remoto. A combinação de os.path.basename e os.path.normath extrai o nome do último diretório do caminho, ou seja, 'docs_to_OCR'. Usar o caminho completo criaria muitos diretórios aninhados desnecessários dentro do seu bucket.
  remote_subdir= os.path.basename(os.path.normpath(input_dir))
  rel_remote_path = os.path.join(remote_subdir, filename)

  # Carrega o ficheiro para o seu Google Cloud Bucket como um blob. O termo 'blob' significa 'Binary Large Object' e é usado para armazenar informações.
  blob = bucket.blob(rel_remote_path)
  blob.upload_from_filename(os.path.join(input_dir, filename))

  # Caminho remoto para o ficheiro.
  gcs_source_uri = os.path.join('gs://', bucket_name, rel_remote_path)

  # Origem de entrada e configuração de entrada.
  gcs_source = vision.GcsSource(uri=gcs_source_uri)
  input_config = vision.InputConfig(gcs_source=gcs_source, mime_type=mime_type)

  # Caminho para os ficheiros JSON de resposta no Google Cloud Storage. Neste caso, os ficheiros JSON serão salvos dentro de uma subpasta da versão em nuvem do input_dir chamada 'json_output'.
  gcs_destination_uri = os.path.join('gs://', bucket_name, remote_subdir, 'json_output', filename[:30]+'_')

  # Destino de saída e configuração de saída.
  gcs_destination = vision.GcsDestination(uri=gcs_destination_uri)
  output_config = vision.OutputConfig(gcs_destination=gcs_destination, batch_size=batch_size)

  # Instancia a solicitação de anotação OCR.
  sasync_request = vision.AsyncAnnotateFileRequest(
  features=[feature], input_config=input_config, output_config=output_config)

  # A variável timeout é usada para determinar quando um processo está demorando demais e deve ser interrompido. Se o processo OCR falhar devido ao tempo limite, pode tentar aumentar esse valor.
  operation = vision_client.async_batch_annotate_files(requests=[async_request])
  operation.result(timeout=180)

  return gcs_destination_uri
```

Agora que o processo de OCR está completo e os ficheiros de resposta estão armazenados no console, é possível criar uma lista ordenada contendo cada "blob" (Binary Large OBject - Objecto Binário Grande), garantindo que sejam lidos na ordem correta.

```
def l_blobs(gcs_destination_uri):

  # Identifica o 'prefixo' dos ficheiros JSON de resposta, ou seja, o caminho e o início de seus nomes de ficheiro.
  prefix='/'.join(gcs_destination_uri.split('//')[1].split('/')[1:])

  # Usa esse prefixo para extrair os ficheiros JSON de resposta corretos do seu bucket e armazená-los como 'blobs' em uma lista.
  blobs_list = list(bucket.list_blobs(prefix=prefix))

  # Ordena a lista por comprimento antes de classificá-la em ordem alfabética para que o texto apareça na ordem correta no ficheiro de saída (ou seja, para que os dois primeiros itens da lista sejam 'output-1-to-2.json' e 'output-2-to-3.json' em vez de 'output-1-to-2.json' e 'output-10-to-11.json', como produzido pela ordem alfabética padrão).
  blobs_list = sorted(blobs_list, key=lambda blob: len(blob.name))

  return blobs_list
```

Em seguida, podemos usar essa lista para extrair as anotações de texto completo de cada "blob", unificá-las para criar o texto completo e salvá-lo em um ficheiro local.

```
def local_file(blobs_list, filename, output_dir):

  # Se o diretório de saída não existir, crie-o.
  if not os.path.exists(output_dir):
        os.mkdir(output_dir)

  # Cria uma string vazia para armazenar o texto.
  output=''

  # Itera através da lista criada na função anterior e extrai o 'full_text_response' (ou seja, o texto OCR) para cada página e o anexa à string de saída.
  for blob in blobs_list:
        json_string = blob.download_as_string()
        response=json.loads(json_string)
        full_text_response = response['responses']

        for text in full_text_response:
            try:
                annotation=text['fullTextAnnotation']
                output+=annotation['text']
            except:
                pass


  # Cria o caminho e nome do ficheiro de saída.
  output_file=os.path.join(output_dir, filename.split('.')[0]+'.txt')

  # Cria um ficheiro e escreve a string de saída nele.
  f=open(output_file, 'x')
  f.write(output)
  f.close()
```

A função a seguir executa todo o fluxo de trabalho

```
def vision_method(input_dir, output_dir, filename):

  # Atribui o caminho remoto para os ficheiros JSON de resposta a uma variável.
  gcs_destination_uri=JSON_OCR(input_dir, filename)

  # Cria uma lista ordenada de blobs a partir desses ficheiros JSON remotos.
  blobs_list = l_blobs(gcs_destination_uri)

  # Lê esses blobs um por um para criar uma string de texto completo e escrevê-la em um ficheiro local.
  local_file(blobs_list, filename, output_dir)
```

Por fim, a última função executa o fluxo de trabalho para cada ficheiro PDF dentro de um diretório especifico.

```
def batch_vision_method(input_dir, output_dir):
    for filename in os.listdir(input_dir):
        if filename.endswith('.pdf'):
            print(filename)
            vision_method(input_dir, output_dir, filename)
```

Exemplo de uso:

```
#Diretório onde os ficheiros a serem OCRizados estão localizados.
input_dir='/PATH/TO/LOCAL/DIRECTORY/docs_to_OCR/'

#Diretório onde os ficheiros de texto de saída serão armazenados.
output_dir='/PATH/TO/LOCAL/DIRECTORY/vision_method_txt/'

batch_vision_method(input_dir, output_dir)
```

### Compreendendo saídas JSON

Como explicado anteriormente, a API de detecção de texto cria ficheiros JSON que contêm anotações de texto completo do ficheiro PDF de entrada. No código acima, essa anotação de texto completo é consultada a partir do ficheiro JSON e salva como um ficheiro `.txt` na sua pasta de saída local. Esses ficheiros JSON contêm informações adicionais e podem ser consultados ou baixados na subpasta`json_output` do seu bucket de armazenamento.

Para cada página, encontrará as seguintes informações:

- Idioma(s) detectado(s)
- Largura e altura
- Texto completo

Para cada bloco, parágrafo e palavra:

- Idioma(s) detectado(s)
- Coordenadas da caixa delimitadora que "enquadra" o texto relevante

Para cada caractere:

- Idioma detectado
- O "símbolo" detectado (ou seja, a própria letra ou sinal de pontuação)

A maioria dessas informações possui uma pontuação de confiança entre 0 e 1.

O trecho de código abaixo mostra as informações para a palavra "HENRY" no subtítulo do Exemplo 1.

```
{"property":
{"detectedLanguages":
    [{"languageCode": "en"}]},
"boundingBox":
{"normalizedVertices":
    [{"x": 0.435,
      "y": 0.25},
     {"x": 0.5325,
      "y": 0.25},
     {"x": 0.5325,
      "y": 0.2685185},
     {"x": 0.435,
      "y": 0.2685185}]},
"symbols":
[{"property":
     {"detectedLanguages":
            [{"languageCode": "en"}]},
        "text": "H",
        "confidence": 0.99},
    {"property":
        {"detectedLanguages":
            [{"languageCode": "en"}]},
        "text": "E",
        "confidence": 0.99},
    {"property":
        {"detectedLanguages":
            [{"languageCode": "en"}]},
        "text": "N",
        "confidence": 0.99},
    {"property":
        {"detectedLanguages":
            [{"languageCode": "en"}]},
        "text": "R",
        "confidence": 0.99},
    {"property":
        {"detectedLanguages":
            [{"languageCode": "en"}],
            "detectedBreak":
            {"type": "SPACE"}},
        "text": "Y",
        "confidence": 0.99}],
"confidence": 0.99}
```

Para aprender mais sobre JSON e como consultar dados JSON com a utilidade de linha de comando [jq](https://rpubs.com/guilhermeferreirajf/pmtc), consulte a lição do _Programming Historian_ [Reshaping JSON with jq](/en/lessons/json-and-jq).

Também é possível consultar ficheiros JSON armazenados na subpasta `json_output` do respectivo bucket com Python. Por exemplo, se desejar identificar palavras com pontuação de confiança baixa e o idioma detectado para essas palavras, pode-se tentar executar o seguinte código:

```
#Este código analisa apenas as duas primeiras páginas do ficheiro 'JHS_1872_HenryIVandQueenJoanCanterburyCathedral.pdf', mas pode iterar por todos os ficheiros JSON.
#Obtenha os dados do seu bucket como um objeto blob.
page_1_2 = bucket.get_blob('docs_to_OCR/json_output/JHS_1872_HenryIVandQueenJoanCa_output-1-to-2.json')
#Leia o conteúdo do objeto blob como bytes.
json_string = page_1_2.download_as_string()
#Converta os dados codificados em JSON em um objeto Python.
response=json.loads(json_string)

#Laços consecutivos para acessar os elementos profundamente aninhados desejados.
for page in response['responses']:
    for block in page['fullTextAnnotation']['pages'][0]['blocks']:
        for paragraph in block['paragraphs']:
            for word in paragraph['words']:
                #Condição:
                if word['confidence'] < 0.8:
                    #Como os dados JSON fornecem os caracteres um por um, é necessário uní-los para formar a palavra.
                    word_text = ''.join(symbol['text'] for symbol in word['symbols'])
                    #Descarte os caracteres não alfabéticos.
                    if word_text.isalpha():
                        #Nem todas as palavras têm o atributo 'detectedLanguages'. A estrutura 'try-except' permite que os leve em consideração.
                        try:
                            print(word_text, '\t', word['confidence'], '\tLanguage Code: ', word['property']['detectedLanguages'][0]['languageCode'])
                        except:
                            print(word_text, '\t', word['confidence'])
```

Resultado:

```
full     0.78   Language Code:  en
A    0.11   Language Code:  en
BRIEF    0.72   Language Code:  en
BENRY    0.7    Language Code:  en
IV   0.76   Language Code:  en
a    0.46   Language Code:  en
And      0.77   Language Code:  en
he   0.77   Language Code:  en
sancta   0.79   Language Code:  la
præ      0.71   Language Code:  la
more     0.79   Language Code:  l
```

Essas informações podem ajudar a corrigir o texto. Por exemplo, seria possível destacar em uma cor diferente todas as palavras cuja anotação OCR esteja abaixo de um determinado limite de confiança para verificação manual.

# Combinando Layout e Reconhecimento de Caracteres

Combinar as duas ferramentas não é tão simples como deveria ser, pois infelizmente o Google Vision não permite que o usuário defina uma área de detecção usando coordenadas antes do processo de OCR ocorrer. No entanto, existem (pelo menos) duas maneiras de lidar com isso.

- A primeira é criar um novo ficheiro PDF em que as regiões de texto são rearranjadas verticalmente, de modo que a incapacidade do Google Vision em detectar layouts complexos não seja mais um problema. Com esse método, ainda é possível utilizar a "anotação de texto completo" do ficheiro de resposta JSON.
- O segundo método é usar as coordenadas dos blocos de texto detectados pelo Tesseract para selecionar as palavras correspondentes detectadas pelo Google Vision. Nesse caso, é necessário recriar o texto, caractere por caractere, em vez de usar a "anotação de texto completo".

### Tesseract + Google Vision: Método Um

O primeiro método combinado converte um documento em uma lista de imagens (ou seja, cada página se torna uma imagem). Para cada nova imagem, a API do Tesseract é usada para identificar regiões de texto. Essas regiões de texto são então recortadas, preenchidas e organizadas verticalmente em uma nova imagem. Por exemplo, uma página com duas colunas se tornará uma imagem em que as duas colunas são empilhadas uma em cima da outra. A nova imagem terá aproximadamente metade da largura e o dobro da altura da original. As novas imagens são concatenadas e transformadas novamente em um único PDF. Esse PDF é então processado com a função `vision_method` definida acima.

Para criar esses novos PDFs sequenciados por regiões, são necessários três novos pacotes. Primeiro, o [pdf2image](https://perma.cc/MD5E-ZJ2W) converte PDFs em objetos de imagem PIL (Python Imaging Library). Segundo, o [tesserocr](https://perma.cc/SJ9L-AGPP) fornece as coordenadas das diferentes regiões de texto. Terceiro, o [pillow](https://acervolima.com/python-pillow-um-garfo-de-pil/) nos ajuda a reconstruir as imagens para cada página com as coordenadas fornecidas pelo tesserocr. Usar o [conda](https://technoteinc.blogspot.com/2019/03/o-que-e-conda.html) é a maneira mais simples de instalar os pacotes.

```
conda install -c conda-forge pdf2image
conda install -c conda-forge tesserocr
conda install -c anaconda pillow
```

Antes de recortar as regiões de texto para rearranjá-las verticalmente, é útil criar uma função que adiciona margem às imagens. A margem adiciona espaço entre as regiões de texto no novo documento PDF. Sem ela, a proximidade entre as regiões de texto pode levar a erros de OCR. É possível ajustar a margem para combinar com a cor de fundo, mas não achei que isso melhora significativamente os resultados. A função recebe três argumentos: a imagem, o número de pixels adicionados a cada lado da imagem e a cor da margem.

```
from pdf2image import convert_from_path
from tesserocr import PyTessBaseAPI
from PIL import Image

def add_padding(pil_img, n_pixels, colour):
    width, height = pil_img.size
    new_width = width + n_pixels * 2
    new_height = height + n_pixels * 2
    img_pad = Image.new(pil_img.mode, (new_width, new_height), colour)
    img_pad.paste(pil_img, (n_pixels, n_pixels))
    return img_pad
```

O próximo passo é criar uma função que recebe uma imagem de uma página como entrada, utiliza a API do Tesseract para identificar as diferentes regiões de texto e as armazena em uma lista chamada 'regions'. Cada elemento da lista será uma tupla contendo uma imagem de uma das regiões e um dicionário contendo as quatro coordenadas da região (as coordenadas 'x' e 'y' do canto superior esquerdo, bem como a altura e a largura). Para cada região, a imagem é acolchoada usando a função definida anteriormente e anexada a uma lista iniciada no início da função.

```
def list_regions(p):
    lim=[]
    with PyTessBaseAPI() as api:
        api.SetImage(p)
        regions = api.GetRegions()
        for (im, box) in regions:
            img_pad = add_padding(im, 5, "white")
            lim.append(img_pad)
    return lim
```

Com essa lista de imagens contendo as regiões de texto, podemos recriar a página arranjando as regiões verticalmente. A função itera pelas imagens e registra suas dimensões para calcular a dimensão da nova página a ser criada. Como as regiões de texto estão empilhadas verticalmente, a dimensão da nova imagem será a soma das alturas e a largura da região de texto mais larga. Uma vez que a imagem vazia é criada, cada imagem é colada nela, uma abaixo da outra.

```
def page(lim):

    total_height = 0
    max_width = 0

    for img_pad in lim:
        w, h = img_pad.size
        total_height += h
        if w > max_width:
            max_width = w

    page_im = Image.new('RGB', (max_width, total_height), color = "white")
    pre_w = 0
    pre_h = 0

    for img_pad in lim:
        page_im.paste(img_pad, (pre_w, pre_h, pre_w+img_pad.size[0], pre_h + img_pad.size[1]))
        pre_h += img_pad.size[1]


    return page_im
```

Estamos agora prontos para aplicar esse método a todas as páginas de um ficheiro PDF. A função seguinte converte cada página do PDF de entrada em uma nova imagem, armazena essas imagens em uma lista e as salva localmente como um novo PDF armazenado em um diretório novo.

```
def new_file_layout(filename, input_dir, store_dir):

    if not os.path.exists(store_dir):
        os.mkdir(store_dir)

    # Cria um caminho onde o ficheiro de saída será armazenado.
    new_filepath=os.path.join(store_dir, filename)

    # Converte o documento em uma lista de imagens.
    pages = convert_from_path(os.path.join(input_dir, filename))

    # Inicia uma lista vazia para armazenar a nova versão de cada página.
    lim_p=[]

    for p in pages:
        lim=list_regions(p)
        page_im=page(lim)
        lim_p.append(page_im)

    lim_p[0].save(new_filepath, "PDF" ,resolution=100.0, save_all=True, append_images=lim_p[1:])

```

A seguinte função executa o procedimento acima e faz a OCR do novo PDF utilizando o método `vision_method` definido [na seção anterior](#google-vision-2).

```
def combined_method_I(filename, input_dir, store_dir, output_dir):
    if not os.path.exists(output_dir):
        os.mkdir(output_dir)
    new_file_layout(filename, input_dir, store_dir)
    vision_method(store_dir, output_dir, filename)
```

Finalmente, executaremos o fluxo de trabalho para cada ficheiro PDF dentro de um diretório especificado.

```
def batch_combined_method_I(input_dir, store_dir, output_dir):
    for filename in os.listdir(input_dir):
        if filename.endswith('.pdf'):
            print(filename)

            combined_method_I(filename, input_dir, store_dir, output_dir)
```

Exemplo de uso:

```
# Diretório onde os ficheiros PDF a serem OCRizados estão localizados.
input_dir_cm1='PATH/TO/LOCAL/DIRECTORY/docs_to_OCR'

# Diretório onde os novos ficheiros PDF sequenciados serão armazenados.
store_dir_cm1= 'PATH/TO/LOCAL/DIRECTORY/combined_I_pdf/'

# Diretório onde os ficheiros de texto de saída serão armazenados.
output_dir_cm1='/PATH/LOCAL/DIRECTORY/TO/combined_I_txt/'

batch_combined_method_I(input_dir_cm1, store_dir_cm1, output_dir_cm1)

```

### Tesseract + Google Vision: Método 2

O segundo método combinado utiliza as coordenadas das regiões de texto fornecidas pelo Tesseract para criar a saída de texto. Estaremos extraindo todas as palavras que estão dentro das regiões definidas a partir dos ficheiros de resposta JSON gerados anteriormente usando a função `JSON_OCR`, conforme explicado na [seção do Google Vision](#google-vision-2).

Primeiro, iremos criar uma função que irá gerar um dicionário contendo as coordenadas de cada região de texto, bem como a altura e largura de cada página. A altura e largura são necessárias para converter as coordenadas em pixels fornecidas pelo Tesseract para as coordenadas normalizadas fornecidas pelo Google Vision.

```
def region_segmentation(input_dir, filename):

    # Inicialize um dicionário vazio.
    dict_pages={}

    # Converta o PDF em uma lista de imagens.
    pages = convert_from_path(os.path.join(input_dir, filename))

    # Inicialize a contagem de páginas.
    pn=0
    for p in pages:
        pn+=1
        with PyTessBaseAPI() as api:
            api.SetImage(p)

            # A variável "regions" é uma lista de tuplas. Cada tupla contém uma imagem de uma região de texto e um dicionário contendo as coordenadas da mesma região de texto.
            regions = api.GetRegions()

            # Atribua a uma variável a lista de dicionários contendo as coordenadas de cada região de texto da página.
            r=[region[1] for region in regions]

            # Adicione ao dicionário iniciado acima o número da página como chave e a lista de dicionários como valor.
            dict_pages[pn]=r

            # Adicione chaves e valores para a largura e altura da página.
            dict_pages[str(pn)+'_width'], dict_pages[str(pn)+'_height']=p.size

    return dict_pages
```

Em seguida, podemos criar uma função que usa os ficheiros de resposta JSON produzidos pelo Google Vision para extrair as palavras que estão dentro das regiões de texto definidas (cujas coordenadas estão armazenadas no dicionário criado pela função acima).

Essa função itera pelas páginas identificadas nos ficheiros JSON (se definir `batch_size = 2`, então duas páginas são processadas em cada ficheiro JSON). Para cada página, armazenamos a lista de blocos JSON em uma variável. Usando um contador de páginas iniciado no início da função, recuperamos as dimensões (largura e altura) da página, além das coordenadas das regiões de texto do dicionário criado anteriormente.

O Tesseract fornece quatro coordenadas de região em pixels: as coordenadas x e y do canto superior esquerdo, além da altura e comprimento da região de texto. Para cada região, as coordenadas do Tesseract precisam ser convertidas em coordenadas normalizadas, pois é isso que o Google Vision utiliza. As coordenadas normalizadas fornecem a posição relativa de um ponto e, portanto, são números entre 0 e 1. Para serem normalizadas, as coordenadas absolutas são divididas pela largura da página (para coordenadas x) ou pela altura (para coordenadas y).

O ficheiro JSON do Google Vision fornece as coordenadas normalizadas x e y para os quatro cantos de cada palavra. A ordem depende da orientação do texto. Usando os valores mínimos e máximos de x e y, garantimos que obtemos sistematicamente as coordenadas do canto superior esquerdo e inferior direito da caixa da palavra. Com as coordenadas normalizadas do canto superior esquerdo (x1, y1) e inferior direito (x2, y2) de uma região do Tesseract, obtemos a caixa na qual as palavras do ficheiro de resposta do Google Vision precisam "encaixar" para serem adicionadas à saída de texto para aquela região. Como estamos comparando coordenadas fornecidas por diferentes ferramentas e uma diferença de um pixel pode ser significativa, pode ser uma boa ideia reduzir ligeiramente o tamanho da caixa da palavra que precisa "encaixar" na caixa da região para que a palavra seja adicionada à saída de texto para aquela região. Observe que as "palavras" incluem os espaços, pontuações ou quebras de linha que as seguem.

Uma vez que essas coordenadas normalizadas da região são estabelecidas, podemos iterar por cada palavra em uma página no ficheiro JSON do Google Vision e verificar se ela faz parte de uma determinada região de texto. Esse processo é repetido para cada região de texto em cada página. O texto dentro de cada região é adicionado e gravado em um ficheiro quando todo o documento é processado.

```
def local_file_region(blobs_list, dict_pages, output_dir, filename):

    if not os.path.exists(output_dir):
        os.mkdir(output_dir)

    text=''

    # Inicia a contagem de páginas.
    n = 1

    # Para cada página de cada ficheiro JSON, armazene a lista de blocos de texto (segundo o Google Vision), a largura e altura da página e a lista de coordenadas das regiões de texto (segundo o Tesseract).
    for blob in blobs_list:
        json_string = blob.download_as_string()
        response=json.loads(json_string)

        for page in response['responses']:

            blocks=page['fullTextAnnotation']['pages'][0]['blocks']
            p_width = dict_pages[str(n)+'_width']
            p_height = dict_pages[str(n)+'_height']
            r= dict_pages[n]

            # Para cada região de texto, verificamos cada palavra da página correspondente no ficheiro JSON para ver se ela se encaixa nas coordenadas da região fornecidas pelo Tesseract.
            for reg in r:

                x1=reg['x']/p_width
                y1=reg['y']/p_height
                x2=(reg['x']+reg['w'])/p_width
                y2=(reg['y']+reg['h'])/p_height

                for block in blocks:

                    for paragraph in block['paragraphs']:
                        for word in paragraph['words']:
                            try:
                                # O "+ 0.01" e "-0.01" reduzem ligeiramente o tamanho da caixa de palavra que estamos comparando com a caixa de região. Se uma palavra estiver um pixel mais alta no Google Vision do que no Tesseract (potencialmente devido à conversão de PDF para imagem), essa precaução garante que a palavra ainda seja correspondida à região correta.
                                min_x=min(word['boundingBox']['normalizedVertices'][0]['x'], word['boundingBox']['normalizedVertices'][1]['x'], word['boundingBox']['normalizedVertices'][2]['x'], word['boundingBox']['normalizedVertices'][3]['x'])+0.01
                                max_x=max(word['boundingBox']['normalizedVertices'][0]['x'], word['boundingBox']['normalizedVertices'][1]['x'], word['boundingBox']['normalizedVertices'][2]['x'], word['boundingBox']['normalizedVertices'][3]['x'])-0.01
                                min_y=min(word['boundingBox']['normalizedVertices'][0]['y'], word['boundingBox']['normalizedVertices'][1]['y'], word['boundingBox']['normalizedVertices'][2]['y'], word['boundingBox']['normalizedVertices'][3]['y'])+0.01
                                max_y=max(word['boundingBox']['normalizedVertices'][0]['y'], word['boundingBox']['normalizedVertices'][1]['y'], word['boundingBox']['normalizedVertices'][2]['y'], word['boundingBox']['normalizedVertices'][3]['y'])-0.01
                                for symbol in word['symbols']:

                                # Se a palavra se encaixa, adicionamos o texto correspondente à string de saída.
                                    if(min_x >= x1 and max_x <= x2 and min_y >= y1 and max_y <= y2):
                                        text+=symbol['text']

                                        try:
                                            if(symbol['property']['detectedBreak']['type']=='SPACE'):
                                                text+=' '
                                            if(symbol['property']['detectedBreak']['type']=='HYPHEN'):
                                                text+='-\n'
                                            if(symbol['property']['detectedBreak']['type']=='LINE_BREAK' or symbol['property']['detectedBreak']['type']=='EOL_SURE_SPACE'):
                                                text+='\n'
                                        except:
                                            pass
                            except:
                                pass
            n+=1

    # Escreva a saída completa de texto em um ficheiro de texto local.
    output_file=os.path.join(output_dir, filename.split('.')[0]+'.txt')

    # Crie um ficheiro e escreva a string de saída.
    f=open(output_file, 'x')
    f.write(text)
    f.close()
```

Para esclarecer esse processo e a normalização das coordenadas, vamos nos concentrar novamente na palavra "HENRY" da legenda do primeiro documento de exemplo - Miscellania: Tomb of King Henry IV. in Canterbury Cathedral. O dicionário criado com a função `region_segmentation` fornece as seguintes informações para a primeira página desse documento:

```
1: [{'x': 294, 'y': 16, 'w': 479, 'h': 33},
  {'x': 293, 'y': 40, 'w': 481, 'h': 12},
  {'x': 545, 'y': 103, 'w': 52, 'h': 26},
  {'x': 442, 'y': 328, 'w': 264, 'h': 27},
  {'x': 503, 'y': 400, 'w': 143, 'h': 14},
  {'x': 216, 'y': 449, 'w': 731, 'h': 67},
  {'x': 170, 'y': 550, 'w': 821, 'h': 371},
  {'x': 794, 'y': 916, 'w': 162, 'h': 40},
  {'x': 180, 'y': 998, 'w': 811, 'h': 24},
  {'x': 210, 'y': 1035, 'w': 781, 'h': 53},
  {'x': 175, 'y': 1107, 'w': 821, 'h': 490}],
 '1_width': 1112,
 '1_height': 1800
```

Como podemos ver, o Tesseract identificou 11 regiões de texto e indicou que a primeira página tinha 1112 pixels de largura e 1800 pixels de altura.

As coordenadas dos cantos superior esquerdo e inferior direito da sexta região de texto da página (que contém a legenda do texto e a palavra "HENRY") são calculadas da seguinte forma pela função`local_file_region`:

```
x1 = 216/1112 = 0.1942
y1 = 449/1800 = 0.2494

x2 = (216+731)/1112 = 0.8516
y2 = (449+67)/1800 = 0.2867
```

Para processar essa região de texto, a nossa função itera por cada palavra que aparece no bloco JSON correspondente a essa página e verifica se ela "cabe" nessa região. Quando chega na palavra "HENRY", a função verifica as coordenadas da palavra, que, como vimos na seção JSON, são:

```
x: 0.435, y: 0.25
x: 0.5325, y: 0.25
x: 0.5325, y: 0.2685185
x: 0.435, y: 0.2685185
```

A função verifica que o canto superior esquerdo é (0.435, 0.25) e o canto inferior direito é (0.5325, 0.2685185). Com essas coordenadas, a função verifica se a palavra "HENRY" se encaixa na região de texto. Isso é feito verificando se as coordenadas x (0.435 e 0.5325) estão ambas entre 0.1942 e 0.8516, e as coordenadas y (0.25 e 0.2685185) estão ambas entre 0.2494 e 0.2867. Como isso é verdade, a palavra "HENRY" é adicionada à string de texto para essa região.

A seguinte função executa todo o fluxo de trabalho. Primeiro, ela gera uma lista ordenada de respostas JSON do Google Vision, assim como faria se estivéssemos usando apenas o Google Vision. Em seguida, ela gera o dicionário contendo as coordenadas Tesseract de todas as regiões de texto. Por fim, ela usa a função `local_file_region` definida acima para criar a saída de texto.

```
def combined_method_II(input_dir, output_dir, filename):
    gcs_destination_uri=JSON_OCR(input_dir, filename)
    blobs_list=l_blobs(gcs_destination_uri)
    dict_pages=region_segmentation(input_dir, filename)
    local_file_region(blobs_list, dict_pages, output_dir, filename)
```

A seguinte função executa o fluxo de trabalho para cada ficheiro PDF dentro de um diretório fornecido:

```
def batch_combined_method_II(input_dir, output_dir):
    for filename in os.listdir(input_dir):
        if filename.endswith('.pdf'):
            print(filename)
            combined_method_II(input_dir, output_dir, filename)
```

Exemplo de uso:

```
#Diretório onde estão localizados os ficheiros PDF para realizar a OCR.
input_dir_cm2='PATH/TO/LOCAL/DIRECTORY/docs_to_OCR'

#Diretório onde os ficheiros de texto de saída serão armazenados.
output_dir_cm2='/PATH/LOCAL/DIRECTORY/TO/combined_II_txt/'

batch_combined_method_II(input_dir_cm2, output_dir_cm2)
```

# Conclusão

Ao realizar projetos de pesquisa digital nas áreas de humanidades, e especialmente ao lidar com fontes históricas, é raro encontrar ferramentas que tenham sido projetadas tendo em mente o seu material. Portanto, muitas vezes é útil considerar se várias ferramentas diferentes são interoperáveis e como combiná-las pode oferecer soluções inovadoras.

Esta lição combina a ferramenta de reconhecimento de layout do Tesseract com a função de anotação de texto do Google Vision para criar um fluxo de trabalho de OCR que produzirá resultados melhores do que o Tesseract ou o Google Vision sozinhos. Se treinar o seu próprio modelo OCR ou pagar por uma ferramenta licenciada não for uma opção, essa solução versátil pode ser uma resposta econômica para os seus problemas de OCR.

<div class="alert alert-info">
Este fluxo de trabalho foi projetado no contexto do projeto financiado pelo UKRI "The Human Remains: Digital Library of Mortuary Science & Investigation", liderado pela Dra. Ruth Nugent na Universidade de Liverpool.
</div>
