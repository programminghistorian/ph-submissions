---
title: Trabalhando com arquivos de texto em Python
layout: lesson
date: 2012-07-17
authors:
- William J. Turkel
- Adam Crymble
reviewers:
- Jim Clifford
editors:
- Miriam Posner
difficulty: 2
exclude_from_check:
  - review-ticket
activity: transforming
topics: [python]
abstract: "Nesta lição, você aprenderá como manipular arquivos de texto usando Python."
next: code-reuse-and-modularity
previous: visualizando-arquivos-html
series_total: 15 lessons
sequence: 3
python_warning: false
redirect_from: /lessons/portuguese/manipulando-arquivos-texto
avatar_alt: Bespectacled man reading an alphabet book
doi: 10.46430/phen0020
---

{% include toc.html %}





## Objetivos da lição

Nesta lição, você aprenderá como manipular arquivos de texto usando Python.
Isso inclui abrir, fechar, ler e gravar arquivos em `.txt` usando programação.

As próximas lições desta série envolverão o download de uma página da web e a reorganização do seu conteúdo em blocos de informações úteis. Você fará a maior parte desse trabalho usando código Python escrito e executado no Komodo Edit.

## Trabalhando com arquivos de texto

Python facilita o trabalho com arquivos e texto. Vamos começar com arquivos.

## Criando e gravando um arquivo de texto

Vamos começar com uma breve discussão da terminologia. Em uma lição anterior (dependendo do seu sistema operacional: [Mac Installation][], [Windows Installation][], ou [Linux Installation][]), você viu como enviar informações para a janela de "Saída de Comando" do seu editor de texto usando o comando [print][] do Python.

``` python
print('hello world')
```

A linguagem de programação Python é *orientada a objetos*. Isso quer dizer que é construída em torno de um tipo especial de entidade, um *objeto*, que
contém *dados* e vários *métodos* para acessar e alterar esses dados. Depois que um objeto é criado, ele pode interagir com outros
objetos.

No exemplo acima, vemos um tipo de objeto, a *string* "hello world". A *string* é a sequência de caracteres entre aspas. Você pode escrever uma *string* de três maneiras:

```
message1 = 'hello world'
message2 = "hello world"
message3 = """hello
hello
hello world"""
```

O importante a notar é que nos primeiros dois exemplos você pode
usar aspas simples ou duplas / vírgulas invertidas, mas você não pode misturar as duas dentro de uma *string*.

Por exemplo, as seguintes estão todas erradas:

```
message1 = "hello world'
message2 = 'hello world"
message3 = 'I can't eat pickles'
```

Conte o número de aspas simples na *message3*. Para funcionar você
teria que *libertar* o apóstrofo:

``` python
message3 = 'I can\'t eat pickles'
```

Ou reescrever a frase como:

``` python
message3 = "I can't eat pickles"
```

No terceiro exemplo, as aspas triplas significam uma *string* que abrange
mais de uma linha.


`Print` é um comando que imprime objetos na forma textual. O
comando *print*, quando combinado com a *string*, produz uma *instrução*.

Você usará `print` assim nos casos em que deseja criar informações que precisam ser postas em prática imediatamente. Às vezes, no entanto, você criará informações que deseja salvar, enviar a outra pessoa ou usar como entrada para processamento posterior por outro programa ou conjunto de programas. Nestes casos, você desejará enviar informações para arquivos em seu disco rígido em vez de para a janela de "saída de comando". Insira o seguinte programa em seu editor de texto e salve-o como `file-output.py`.

``` python
# file-output.py
f = open('helloworld.txt','wb')
f.write('hello world')
f.close()
```

Em Python, qualquer linha que comece com uma marca de hash (\#) é conhecida como um
*comentário* e é ignorada pelo interpretador Python. Os comentários têm como objetivo permitir que os programadores se comuniquem uns com os outros (ou para se lembrarem do que seu código faz quando se sentam com ele alguns meses depois). Em um sentido mais amplo, os próprios programas são tipicamente escritos e formatados de modo que seja mais fácil para os programadores se comunicarem uns com os outros. Quando o código é mais próximo dos requisitos da máquina é conhecido como *baixo nível*, enquanto o que está mais próximo da linguagem natural é *alto nível*. Um dos benefícios de usar uma linguagem como Python é que ela é de nível muito alto, tornando mais fácil para nos comunicarmos com você (com algum custo em termos de eficiência computacional).

Neste programa *f* é um *objeto arquivo* (*file object*), e `open` (abrir), `write` (gravar) e `close` (fechar) são *métodos de arquivo* (*file
methods*). Em outras palavras, abrir, gravar e fechar fazem algo com o objeto *f* que, neste caso, é definido como um arquivo `.txt`. Este é provavelmente um uso diferente do termo "método" do que você poderia esperar e de vez em quando você descobrirá que as palavras usadas em um contexto de programação têm significados ligeiramente (ou completamente) diferentes do que na fala do dia a dia. Neste caso, lembre-se de que os métodos são bits de código que executam ações. Eles fazem algo a outra coisa e retornam um resultado. Você pode tentar pensar nisso usando um exemplo do mundo real, como dar comandos ao cachorro da família. O cão (o objeto) entende comandos (ou seja, tem "métodos") como "latir", "sentar", "fingir de morto" e assim por diante. Discutiremos e aprenderemos como usar muitos outros métodos à medida que avançamos.

*f* é um nome de variável escolhido por nós; você poderia chamá-lo de qualquer coisa que quisesse. No Python, os nomes das variáveis podem ser feitos de letras maiúsculas e
minúsculas, números e *underline*... mas você não pode usar os nomes dos comandos Python como variáveis. Se você tentasse nomear sua variável de arquivo com, por exemplo, 
"print", seu programa não funcionaria porque esta é uma [palavra reservada][] que faz parte da linguagem de programação.

Os nomes das variáveis Python também são *case-sensitive*, ou sejam, diferenciam letras maiúsculas de minúsculas, o que significa que
*foobar*, *Foobar* e *FOOBAR* seriam todas variáveis diferentes.

Quando você executa este programa, o método `open` (abrir) vai dizer ao seu computador para criar um novo arquivo de texto `helloworld.txt` na mesma pasta que você salvou o programa `file-output.py`. O *parâmetro wb* diz que você pretende gravar conteúdo neste novo arquivo usando Python.

Observe que, como o nome do arquivo e o parâmetro estão entre aspas simples, você sabe que ambos estão armazenados como *strings*; esquecer de incluir as aspas fará com que seu programa falhe.

Na próxima linha, seu programa grava a mensagem "hello world" (outra string) no arquivo e o fecha. (Para obter mais informações sobre essas instruções, consulte a seção em [File Objects][] na Referência da biblioteca Python.)

Clique duas vezes no botão "Executar Python" no Komodo Edit para executar o programa (ou o equivalente em qualquer editor de texto que você decidiu usar: por exemplo, clique em "\#!" E "Executar" no TextWrangler). Embora nada seja impresso no painel "Saída de Comando", você verá uma mensagem de status que diz algo como 

``` python
`/usr/bin/python file-output.py` returned 0.
```

em Mac ou Linux, ou

``` python
'C:\Python27\Python.exe file-output.py' returned 0.
```

no Windows.

Isso significa que seu programa foi executado com sucesso. Se você usar
*Arquivo -> Abrir -> Arquivo* em seu Komodo Edit, você pode abrir o arquivo
`helloworld.txt`. Ele deve conter sua mensagem de uma linha:

``` python
Hello World!
```

Como os arquivos de texto incluem uma quantidade mínima de informações de formatação,
eles tendem a ser pequenos, fáceis de trocar entre plataformas diferentes
(ou seja, do Windows para Linux ou Mac ou vice-versa) e fácil de enviar
de um programa de computador para outro. Eles geralmente também podem ser lidos por pessoas que usam um editor de texto como o Komodo Edit.

### Lendo de um arquivo de texto

Python também possui métodos que permitem obter informações de arquivos. Digite o seguinte programa em seu editor de texto e salve-o como
`file-input.py`. Ao clicar em "Executar" para executá-lo, será aberto o
arquivo de texto que você acabou de criar, leia a mensagem de uma linha dele e
imprima a mensagem no painel "Saída de Comando".

``` python
# file-input.py
f = open('helloworld.txt','r')
message = f.read()
print(message)
f.close()
```

Nesse caso, o parâmetro *r* é usado para indicar que você está abrindo um arquivo para ler (`read`) a partir dele. Os parâmetros permitem que você escolha entre os diferentes opções que um método específico permite. Voltando ao exemplo do cão da família, o cão pode ser treinado a latir uma vez quando faz um lanche com sabor de carne e duas vezes quando recebe um com sabor de frango. O sabor do lanche é um parâmetro. Cada método é diferente em termos de quais parâmetros aceitará. Você não pode, por exemplo, pedir a um cachorro que cante uma ópera italiana - a menos que seu cachorro seja particularmente talentoso. Você pode pesquisar os parâmetros possíveis para um método específico no site do Python ou, freqüentemente, pode encontrá-los digitando o método em um mecanismo de busca junto com "Python".

`Read` é outro método de arquivo. Os conteúdos do arquivo (a mensagem de uma linha) são copiados para *message*, que é como decidimos chamar esta *string*, e então o comando `print` é usado para enviar os conteúdos de *message* para o painel "Saída do Comando".

### Anexando a um arquivo de texto pré-existente

Uma terceira opção é abrir um arquivo pré-existente e adicionar mais a ele. Note que se você abrir (`open`) um arquivo e usar o método `write` (gravar), *o programa sobrescreverá tudo o que possa estar contido no arquivo*. Isso não é um problema quando você está criando um novo arquivo ou quando deseja sobrescrever os conteúdos de um arquivo existente, mas pode ser indesejável quando você está criando um registro de eventos ou compilando um grande conjunto de dados em um arquivo . Então, ao invés de `write` você vai querer usar o método `append`, designado por `a`.

Digite o seguinte programa em seu editor de texto e salve-o como`file-append.py`. Quando você executar este programa, ele abrirá o mesmoarquivo `helloworld.txt` criado anteriormente e anexará um segundo “hello world ” ao arquivo. O '\\n' significa nova linha.

``` python
# file-append.py
f = open('helloworld.txt','a')
f.write('\n' + 'hello world')
f.close()
```

Depois de executar o programa, abra o arquivo `helloworld.txt` e veja o que aconteceu. Feche o arquivo de texto e execute mais algumas vezes `file-append.py`. Quando você abrir `helloworld.txt` novamente, notará algumas mensagens extras 'hello world' esperando por você.

Na próxima seção, discutiremos a modularidade e a reutilização de código.

Leituras sugeridas
------------------

-   [Non-Programmer’s Tutorial for Python 2.6/Hello, World][]

  [Mac Installation]: /lessons/mac-installation
  [Windows Installation]: /lessons/windows-installation
  [Linux Installation]: /lessons/linux-installation
  [print]: https://docs.python.org/2/reference/simple_stmts.html#the-print-statement
  [palavra reservada]: http://docs.python.org/release/2.5.4/ref/keywords.html
  [File Objects]: https://docs.python.org/2/library/stdtypes.html#bltin-file-objects
  [Non-Programmer’s Tutorial for Python 2.6/Hello, World]: http://en.wikibooks.org/wiki/Non-Programmer%27s_Tutorial_for_Python_2.6/Hello,_World
