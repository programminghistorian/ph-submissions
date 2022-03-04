---
title: Palavras-chave em Contexto (Usando n-gramas) com Python
layout: lesson
slug: palavras-chave-contexto-usando-n-grams-python
date: 2012-07-17
translation_date: 2022-01-14
authors:
- William J. Turkel
- Adam Crymble
reviewers:
- Jim Clifford
- Frederik Elwert
editors:
- Miriam Posner
translator: 
- Felipe Lamarca
translation-editor:
- Jimmy Medeiros
translation-reviewer:
- 
difficulty: 2
review-ticket: 
activity: apresentar
topics: [python]
abstract: "Essa lição toma os pares de frequência criados na lição 'Contagem de Frequências' e os apresenta em um ficheiro HTML."
redirect_from: /licoes/palavras-chave-em-contexto-usando-n-grams
original: keywords-in-context-using-n-grams
avatar_alt: A figure dropping two bottles of alcohol
doi:
---

{% include toc.html %}

## Objetivos da Lição 

Como em [Saída de Dados como um Ficheiro HTML][], essa lição toma os pares de frequência criados na lição [Contagem de Frequências][] e os apresenta em um ficheiro HTML. Dessa vez o foco está nas palavras-chave em contexto, ou *keywords in context* (KWIC) no inglês, que criam n-gramas a partir do conteúdo do documento original - nesse caso, uma transcrição do julgamento do *Old Bailey Online*. Você pode usar seu programa para selecionar uma palavra-chave e o computador retornará todas as instâncias dessa palavra-chave, junto com as palavras à esquerda e da direita dela, tornando mais fácil visualizar rapidamente como a palavra-chave é usada.

Uma vez que as KWICs forem criadas, elas são envolvidas em HTML (isto é, passam pelo *HTML wrapper*) e enviadas ao navegador, onde podem ser visualizadas. Isso reforça o que foi aprendido em [Saída de Dados como um Ficheiro HTML][1], optando por uma saída ligeiramente diferente.

Ao final dessa lição, você será capaz de extrair todos os n-gramas possíveis de um texto. Na próxima lição, você aprenderá como gerar todos os n-gramas de uma determinada palavra-chave em um documento baixado da internet e a exibí-los claramente na janela do navegador.

## Ficheiros Necessários para esta Lição

- `obo.py`

Caso não possua esses ficheiros da lição anterior, você pode fazer o *download* do programming-historian-7, um [ficheiro zip da lição anterior][]. 

## De Texto para N-gramas e para KWIC

Agora que você já sabe como coletar o conteúdo textual de uma página *web* automaticamente com Python e começou a usar strings, listas e dicionários para processamento de texto, há muitas outras coisas que você pode fazer com texto além de contar frequências. Pessoas que estudam propriedades estatísticas da linguagem descobriram que estudar sequências lineares de unidades linguísticas pode nos dizer muito a respeito de um texto. Essas sequências lineares são conhecidas como bigramas (2 unidades), trigramas (3 unidades) e de forma geral como n-gramas.

Você provavelmente já viu n-gramas muitas vezes antes. Eles são comumente utilizados em páginas de resultados de pesquisa para oferecer uma prévia de onde sua palavra-chave aparece em um documento e qual é o texto ao redor da palavra-chave. Essa aplicação de n-gramas é conhecida como palavras-chave em contexto (*keywords in context*, às vezes abreviada como KWIC). Por exemplo, se a string em questão fosse "*it was the best of times it was the worst of times it was the age of wisdom it was the age of foolishness*", então o 7-grama para a palavra-chave "*wisdom*" seria:

```
the age of wisdom it was the
```

Um n-grama poderia conter qualquer tipo de unidade linguística que você desejasse. Para historiadores, é mais provável que você use caracteres como no bigrama "qu" ou palavras como no trigrama "*the dog barked*"; no entanto, você também poderia utilizar fonemas, sílabas, ou qualquer número de outras unidades dependendo da sua pergunta de investigação.

O que faremos a seguir é desenvolver a habilidade de exibir KWIC para qualquer palavra-chave em um corpo de texto, mostrando-a no contexto de um número fixo de palavras em cada um dos lados. Como antes, envolveremos a saída de modo que ela possa ser visualizada no Firefox e adicionada ao Zotero facilmente.

## De Texto para N-gramas

Uma vez que desejamos trabalhar com palavras ao invés de caracteres ou fonemas, será muito mais fácil criar um n-grama usando uma lista de palavras em vez de strings. Como você já sabe, o Python pode facilmente transformar strings em uma lista usando a operação `split`. Uma vez dividida, torna-se simples recuperar uma subsequência de palavras adjacentes na lista usando um `slice`, representado por dois índices separados por dois pontos. Isso foi introduzido ao trabalhar com strings em [Manipular strings com Python][]:

``` python
message9 = "Olá Mundo"
message9a = message9[1:8]
print(message9a)
-> lá Mund
```

No entanto, também podemos usar a técnica de obter um número pré-determinado de palavras vizinhas em uma lista com pouquíssimo esforço. Estude os exemplos a seguir, os quais você pode testar em um Python *shell*:

``` python
wordstring = 'it was the best of times it was the worst of times '
wordstring += 'it was the age of wisdom it was the age of foolishness'
wordlist = wordstring.split()

print(wordlist[0:4])
-> ['it', 'was', 'the', 'best']

print(wordlist[0:6])
-> ['it', 'was', 'the', 'best', 'of', 'times']

print(wordlist[6:10])
-> ['it', 'was', 'the', 'worst']

print(wordlist[0:12])
-> ['it', 'was', 'the', 'best', 'of', 'times', 'it', 'was', 'the', 'worst', 'of', 'times']

print(wordlist[:12])
-> ['it', 'was', 'the', 'best', 'of', 'times', 'it', 'was', 'the', 'worst', 'of', 'times']

print(wordlist[12:])
-> ['it', 'was', 'the', 'age', 'of', 'wisdom', 'it', 'was', 'the', 'age', 'of', 'foolishness']
```

Nesses exemplos usamos o método `slice` para retornar partes da nossa lista. Note que há dois lados para os dois pontos em um `slice`. Se o lado direito dos dois pontos for deixado em branco, como no último exemplo acima, o programa sabe que deve continuar até o final automaticamente - nesse caso, até o fim da lista. O penúltimo exemplo acima mostra que podemos começar no início deixando vazio o espaço antes dos dois pontos. Este é um atalho útil disponível para manter seu código mais curto.

Você também pode usar variáveis para representar a posição dos índices. Usado conjuntamente com um `for` *loop*, você poderia facilmente criar todos os n-gramas possíveis a partir da sua lista. O exemplo a seguir retorna todos os 5-gramas da nossa string do exemplo acima.

``` python
i = 0
for items in wordlist:
    print(wordlist[i: i+5])
    i += 1
```

Mantendo nossa abordagem modular, criaremos e armazenaremos no módulo `obo.py` uma função que será capaz de criar n-gramas para nós. Estude e digite ou copie o seguinte código:


``` python
# Dada uma lista de palavras e um número n, retorna uma lista de n-gramas

def getNGrams(wordlist, n):
    return [wordlist[i:i+n] for i in range(len(wordlist)-(n-1))]
```

Essa função pode parecer um pouco confusa, pois há muita coisa acontecendo aqui em pouco código. Ela usa uma *list comprehension* para manter o código compacto. O exemplo a seguir faz exatamente a mesma coisa:

``` python
def getNGrams(wordlist, n):
    ngrams = []
    for i in range(len(wordlist)-(n-1)):
        ngrams.append(wordlist[i:i+n])
    return ngrams
```

Use a que fizer mais sentido para você.

Um conceito que ainda pode ser confuso para você é a função de dois argumentos. Observe que nossa função possui dois nomes de variáveis entre parênteses depois do seu nome quando a declaramos: `wordlist`, `n`. Essas duas variáveis são os argumentos da função. Quando você chama (executa) a função, essas variáveis serão usadas pela função para sua solução. Sem esses argumentos não há informação suficiente para que os cálculos sejam feitos. Nesse caso, as duas informações são a lista de palavras que você deseja transformar em n-gramas (`wordlist`) e o número de palavras que você deseja em cada n-grama (`n`). Para a função funcionar ela precisa das duas informações, então você a chama da seguinte forma (armazene o código a seguir como `useGetNGrams.py` e execute-o):

``` python
#useGetNGrams.py

import obo

wordstring = 'it was the best of times it was the worst of times '
wordstring += 'it was the age of wisdom it was the age of foolishness'
allMyWords = wordstring.split()

print(obo.getNGrams(allMyWords, 5))
```

Observe que os argumentos que você inseriu não possuem os mesmos nomes dos argumentos nomeados na declaração da função. O Python sabe utilizar a variável `allMyWords` em todos os lugares da função que `wordlist` aparece, já que ela é dada como o primeiro argumento. Da mesma forma, todas as instâncias de `n` serão substituídas pelo inteiro 5 nesse caso. Tente mudar 5 para uma string, como "elefantes", e veja o que acontece quando você executa o programa. Note que, já que `n` está sendo usado como um inteiro, você precisa garantir que o argumento fornecido também é um inteiro. O mesmo vale para strings, pontos flutuantes ou qualquer outro tipo de variável fornecido como argumento.

Você também pode usar um Python *shell* para brincar com o código e entender melhor como ele funciona. Cole a declaração da função `getNGrams` (qualquer uma das duas funções acima) no seu Python *shell*:


``` python
test1 = 'here are four words'
test2 = 'this test sentence has eight words in it'

getNGrams(test1.split(), 5)
-> []

getNGrams(test2.split(), 5)
-> [['this', 'test', 'sentence', 'has', 'eight'],
['test', 'sentence', 'has', 'eight', 'words'],
['sentence', 'has', 'eight', 'words', 'in'],
['has', 'eight', 'words', 'in', 'it']]
```

Há dois conceitos que vemos nesse exemplo para os quais você precisa se atentar. Primeiro, como a nossa função espera uma lista de palavras ao invés de uma string, nós convertemos as strings em listas antes que a nossa função possa manipulá-las. Nós poderíamos ter feito isso adicionando outra linha de código acima da chamada da função, mas em vez disso usamos o método `split` diretamente no argumento da função como um atalho.

Em segundo lugar, por que o primeiro exemplo retornou uma lista vazia em vez dos n-gramas que estávamos procurando? Em `test1`, tentamos pedir um n-grama maior que o número de palavras em nossa lista. Isso resultou em uma lista em branco. Em `test2` nós não temos esse problema e recebemos todos os 5-gramas possíveis para a lista de palavras mais longa. Se desejasse, poderia adaptar sua função para exibir uma mensagem de aviso (*warning message*) ou para retornar a string completa em vez de uma lista vazia.

Agora temos uma maneira de extrair todos os n-gramas possíveis de um corpo textual. Na próxima lição, poderemos concentrar nossa atenção em isolar aqueles n-gramas que forem do nosso interesse.

## Sincronização de Código

Para acompanhar lições futuras, é importante ter os ficheiros e programas corretos no seu diretório “programming-historian”. Ao final de cada capítulo você pode fazer o *download* do ficheiro zip "programming-historian" para garantir que possui o código correto. Caso esteja acompanhando com a versão para Mac / Linux, você deve ter que abrir o ficheiro `obo.py` e mudar "file:///Users/username/Desktop/programming-historian/" para o caminho até o diretório no seu próprio computador.

-   [python-lessons8.py][zip sync]

  [Saída de Dados como um Ficheiro HTML]: /licoes/saida-de-dados-como-ficheiro-html
  [Contagem de Frequências]: /licoes/contagem-frequencias
  [1]: saida-de-dados-como-ficheiro-html
  [ficheiro zip da lição anterior]: https://programminghistorian.org/assets/python-lessons7.zip
  [Manipular strings com Python]: https://programminghistorian.org/pt/licoes/manipular-strings-python
  [zip sync]: https://programminghistorian.org/assets/python-lessons8.zip
