---
title: Noções básicas de páginas web e HTML
layout: lesson
date: 2012-07-17
authors:
- William J. Turkel
- Adam Crymble
reviewers:
- Jim Clifford
- Amanda Morton
editors:
- Miriam Posner
difficulty: 2
exclude_from_check:
  - review-ticket
activity: presenting
topics: [python]
abstract: "Esta lição é uma introdução ao HTML e as páginas da web que ele estrutura."
next: manipulando-arquivos-texto
previous: introducao-e-instalacao
series_total: 15 lessons
sequence: 2
redirect_from: /lessons/portuguese/visualizando-arquivos-html
avatar_alt: A woman listening to a man through an ear trumpet
doi: 10.46430/phen0018
---

{% include toc.html %}





"Olá mundo" em HTML
---------------------

## Visualizando arquivos HTML

Quando você está trabalhando com fontes online, na maior parte do tempo você usa
arquivos que foram marcados com HTML (Hyper Text Markup Language). Seu navegador já
sabe como interpretar HTML, o que é útil para leitores humanos. A maioria dos navegadores
também permite que você veja o *código-fonte* do HTML de qualquer página que você visitar. 
As duas imagens abaixo mostram uma página web típica (do *Old Bailey Online*) e o código
HTML usado para gerar essa página, que você pode ver com a opção do menu do Firefox
`Abrir menu -> Desenvolvimento web -> Código-fonte da página`.

Quando você está trabalhando no navegador, normalmente não quer ou precisa
veja o código de uma página da web. Se você está escrevendo uma página própria,
no entanto, pode ser muito útil ver como outras pessoas realizaram um
determinado efeito. Você também vai querer estudar o código HTML enquanto escreve
programas para manipular páginas da web ou extrair automaticamente informações delas.

{% include figure.html filename="obo.png" caption="Captura de tela do Old Bailey Online" %}

{% include figure.html filename="obo-page-source.png" caption="Código HTML da página Old Bailey Online" %}

(Para aprender mais sobre HTML, você pode achar útil nesse momento usar o
[tutorial de HTML da W3 Schools][]. O conhecimento detalhado de HTML não é
necessário para continuar lendo, mas qualquer tempo que você passar aprendendo HTML
será amplamente recompensado em seu trabalho como historiador digital ou humanista digital.)

## "Olá mundo" em HTML

O HTML é conhecido como linguagem de *marcação*. Em outras palavras, HTML é o texto que foi
"marcado" com *tags* que fornecem informações para o interpretador (que geralmente é um navegador web). 
Suponha que você esteja formatando uma entrada bibliográfica e queira indicar o título de um trabalho
colocando-o em itálico. Em HTML, você usa tags `em` ("em" significa ênfase). Portanto, parte do seu arquivo
HTML pode ter a seguinte aparência

``` xml
... em <em>Digital History</em> de Cohen e Rosenzweig, por exemplo ...
```

O arquivo HTML mais simples consiste em *tags* que indicam o início e o fim de todo o documento, e *tags* que
identificam um `head` e um `body` dentro desse documento. As informações sobre o arquivo geralmente vão para
o cabeçalho, enquanto as informações que serão exibidas na tela geralmente vão para o corpo. 

``` xml
<html>
<head></head>
<body>Olá mundo!</body>
</html>
```


Você pode tentar criar algum código HTML. Em seu editor de texto, crie um novo arquivo. 
Copie o código abaixo no editor. A primeira linha diz ao navegador qual o tipo do arquivo. 
A *tag* `html` tem a direção do texto definido como `ltr` (da esquerda para a direita) e `lang` (idioma) definido como inglês americano. 
A *tag* `title` no cabeçalho do documento HTML contém informações que geralmente são exibidas na barra superior de uma janela quando a página está sendo visualizada e nas abas do Firefox.


``` xml
<!doctype html>
<html dir="ltr" lang="en-US">

<head>
    <title><!-- Insira seu título aqui --></title>
</head>

<body>
    <!-- Insira seu conteúdo aqui -->
</body>
</html>
```

Altere

``` xml
<!-- Insira seu título aqui -->
```

e

``` xml
<!-- Insira seu conteúdo aqui -->
```

para

``` xml
Olá mundo!
```

Salve o arquivo em seu diretório `programming-historian` como
`ola-mundo.html`. Agora vá para o Firefox e escolha `Abrir menu -> Abrir arquivo...` e
então escolha `ola-mundo.html`. Dependendo do seu editor de texto, você pode ter a opção 'visualizar página no navegador' ou 'abrir no navegador'. Depois de abrir o arquivo, sua mensagem deve aparecer no navegador. Observe a diferença entre abrir um arquivo HTML com um navegador como o Firefox (que o interpreta) e abrir o mesmo arquivo com seu editor de texto (que não faz o mesmo).

## Leituras sugeridas para aprender HTML

-   [W3 Schools HTML Tutorial][W3 Schools HTML tutorial]
-   [W3 Schools HTML5 Tutorial][]

  [W3 Schools HTML tutorial]: http://www.w3schools.com/html/default.asp
  [W3 Schools HTML5 Tutorial]: http://www.w3schools.com/html/html5_intro.asp
