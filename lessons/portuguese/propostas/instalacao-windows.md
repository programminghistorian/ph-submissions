---
title: Setting Up an Integrated Development Environment for Python (Windows)
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
translator:
- Josir C. Gomes
difficulty: 1
exclude_from_check:
  - review-ticket
activity: transforming
topics: [get-ready, python]
abstract: "Esta lição irá lhe auxiliar a configurar um ambiente de desenvolvimento integrado para o Python em um computador com o Sistema Operacional Windows."
redirect_from: /licoes/instalacao-windows
avatar_alt: Uma banda com três músicos
doi: 10.46430/phen0019
---

{% include toc.html %}





## Faça um backup do seu computador

É sempre importante garantir que você tenha backups regulares e recentes do seu computador. Este é um bom conselho que serve para a vida toda, e não se limita à pratica específica de programação.

## Instale o Python 3

Faça o download da versão mais estável da linguagem de programação Python 
(Version 3.8 de Novembro de 2019) e instale o software a partir do [Site do Python][].

## Crie um ficheiro

Para que você se organize, o ideal é que você tenha um diretório (i.e., uma pasta) no seu computador onde você irá armazenar os seus programas em Python (por exemplo, `programming-historian`). Crie esse diretório em qualquer outra pasta do seu computador.

## Instale o Komodo Edit

O Komodo Edit é um editor livre e de código aberto, mas pode utilizar [outros editores][] se você preferir. Você pode fazer o download do Komodo Edit no [site do Komodo Edit][]..

## Inicie o Komodo Edit

Ao iniciar o Komodo Edit, você deve visualizar um ecrã como o apresentado de seguida:

{% include figure.html filename="komodo-edit11-windows-main.png" caption="Komodo Edit on Windows" %}

Se você não visualizar a barra de ferramentas (Toolbox) do lado direito, selecione a opção do menu `View -> Tabs -> Toolbox`. Não importa se o painel do seu projeto está aberto ou não. Invista algum tempo para se familiarizar com o layout do Komodo Editor. O arquivo de ajuda é bastante completo. 

### Configure o Komodo Edit

Agora você precisa configurar o seu editor para que ele possa executar programas em Python.

Selecione o menu `Edit -> Preferences -> Languages -> Python 3` e de seguida selecione `Browse`. Agora, selecione o ficheiro `C:\Users\YourUserName\AppData\Local\Programs\Python\Python38-32`)

Se o ecrã resultante for semelhante ao que se encontra abaixo, clique OK:

{% include figure.html caption="Set the Default Python Interpreter" filename="komodo-edit11-windows-interpreter.png" %}

O próximo passo é entrar na seção Preferences e escolher a opção *Internationalization*. Selecione *Python* no menu entitulado *Language-specific Default Encoding* e tenha verifique se [UTF-8][] está selecionado como o método padrão de codificação de caracteres.

{% include figure.html caption="Set the Language to UTF-8" filename="komodo-edit11-windows-utf-set.png" %}

De seguida, escolha `Toolbox->Add->New Command`. Esta opção irá abrir uma nova janela de diálogo. Renomeie o seu comando para `‘Run Python’` e no campo `‘Command’`, digite:

``` python
%(python3) %f
```

Se você esquecer este comando, o Python irá parar misteriosamente porque ele não estará recebendo um programa como entrada.

Já no campo `‘Start in’`, digite:

`%D`

Se o ecrã estiver mostrando algo como descrito na janela abaixo, clique no botão OK.

{% include figure.html filename="komodo-edit11-windows-python-command.png" caption="'Run Python' Command" %}
{% include figure.html filename="komodo-edit11-windows-python-start.png" caption="Configurando o comando 'Run Python Start'." %}

O seu novo comando "Run Python" deve aparecer no painel de ferramentas. Talvez seja necessário reiniciar sua máquina para que o Python possa funcionar no Komodo Edit.

## Passo 2 – “Olá Mundo” em Python
--------------------------------

É uma tradição para quem está começando a programar em uma nova linguagem que o primeiro programa a ser construído emita a frase "Olá Mundo". 

O Python é uma boa linguagem de programação para iniciantes porque ela é de alto-nível.
Isto quer dizer que é possível escrever pequenos programas que realizam muitas funcionalidades. 
Quanto menor o programa, mais provável que ele caiba em apenas um ecrã, e mais fácil será manter o controle dele em sua mente.

O Python é uma lingugagem 'interpretada'. Isto significa que existe um programa especial (conhecido como Interpretador) que sabe como seguir as instruções da linguagem. Uma forma de utilizar o interpretador é guardar todas as instruções a executar em um ficheiro para, em seguida, solicitar ao interpretador que ele interprete o conteúdo desse ficheiro.  

Um ficheiro que contém instruções de linguagem de programação é conhecido como um programa. O interpretador irá executar cada uma das instruções que você incluiu no seu programa e no final irá parar. Vamos experimentar como isto funciona.

No seu editor de texto, crie um novo ficheiro, entre o seguinte programa de duas linhas, e salve-o na pasta `programming-historian`:
 
`ola-mundo.py`

``` python
# ola-mundo.py
print('Olá Mundo')
```

O comando “*Run Python File*” permite que você execute o seu programa.
Se você escolheu um outro editor, este deve ter uma funcionalidade semelhante.
Se tudo correu bem, o ecrã deverá mostrar algo como indicado abaixo (Clique na imagem para ver uma imagem maior):

{% include figure.html filename="komodo-edit11-windows-hello.png" caption="'Hello World'" %}

## Interagindo com a linha de comandos do Python

Outra forma de interagir com o interpretador é utilizar o que é denominado por linha de comandos.
Você pode digitar um comando na linha de comandos e pressionar a tecla Enter, tendo depois a resposta ao seu comando.
Usar a linha de comandos é um ótimo método para testar os comandos, e para se certificar que eles realmente fazem o que você está imaginando.

Você pode executar a linha de comandos do Python dando um duplo-click no ficheiro python.exe.
Se você instalou a versão 3.8 (a mais recente até Novembro de 2019), esse ficheiro provavelmente estará localizado no diretório `C:\Users\YourUserName\AppData\Local\Programs\Python\Python38-32`. Na janela da linha de comandos que irá abrir, digite:

``` python
print('Olá MUndo')
```
e pressione Enter. O computador irá responder com:

``` python
Alô Mundo
```

Quando quisermos representar uma interação na linha de comandos, utilizaremos o símbolo `->` para indicar a resposta para o nosso comando, tal como no exemplo abaixo:

``` python
print('Alô Mundo')
-> Alô Mundo
```


No seu ecrã, você verá algo como:

{% include figure.html caption="Shell do Python no Windows" filename="windows-python3-cmd.png" %}

Agora que você e o seu computador estão preparados, podemos seguir para tarefas mais interessantes. Se você está seguindo as lições do Python, a nossa sugestão é que você tente a próxima aula ‘[Noções básicas de páginas web e HTML][]‘

  [Python website]: https://www.python.org/downloads/windows/
  [outros editores]: https://wiki.python.org/moin/PythonEditors/
  [Web Site do Komodo Edit]: https://www.activestate.com/products/komodo-edit/
  [UTF-8]: http://en.wikipedia.org/wiki/UTF-8
  [Understanding Web Pages and HTML]: /lessons/viewing-html-files
