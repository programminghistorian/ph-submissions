---
title: Configurando um ambiente de desenvolvimento integrado para Python (Linux)
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
abstract: "Esta lição irá lhe auxiliar a configurar um ambiente de desenvolvimento integrado para o Python em um computador com o Sistema Operacional Linux."
redirect_from: /licoes/instalacao-linux
avatar_alt: Uma banda com três músicos
doi: 10.46430/phen0011
---

{% include toc.html %}



Obrigado a John Fink por fornecer as bases para essa seção. Estas 
instruções são para o Ubuntu 18.04 LTS mas devem funcionar com qualquer versão do Linux 
baseada em apt tal como o Debian ou Linux-Mint. Você também deve ter acesso ao comando sudo.

## Faça um backup do seu computador

É sempre importante garantir que você tenha backups regulares e recentes do seu computador. 
Este é um bom conselho que serve para a vida toda, e não se limita à pratica específica de programação.

## Instale o Python 3

1.  Abra um Terminal (Vá para Applicações, e então digite `Terminal`, e então clique no ícone Terminal).
2.  Agora digite: `sudo apt-get install python3`
3.  Entre com a sua senha, e em seguida tecle `S` para finalizar a instalação. 
    Note que você provavelmente já deve ter o Python 3 instalado, assim não estranhe se o Ubuntu informar 
    que o Python já está instalado.

## Crie um ficheiro

Você irá armazenar os seus programas Python nesse diretório. Ele pode estar em qualquer pasta que você quiser,
mas é melhor que você crie esta pasta em sua Home. Para criar o diretório de forma rápida, 
abra a janela do terminal e digite: 

```
cd ~
mkdir programming-historian
```

## Instale o Komodo Editor

O Komodo Editor

O Komodo Edit é um editor livre e de código aberto, mas você pode utilizar [outros editores][] se você preferir.
Você pode fazer o download do Komodo Edit no [site do Komodo Edit][]. Uma vez que você tenha feito o download, faça
a extração dele para a sua pasta pessoal e siga as instruções de instalação. Se você tiver seguido corretamente
as instruções, abra a sua pasta pessoal e acesse a pasta `Komodo-Edit-11/bin` e clique no arquivo `komodo`.

### Faça um comando “Run Python” no Komodo Edit

1.  Já no Editor, Se certifique que a barra lateral “Toolbox” está visível.
2.  Clique no ícone da engrenagem na barra de ferramentas e selecione
    `New Command`.
3.  No campo Type, digite “`Run Python File`”
4.  No campo Command, digite: `%(python3) %F`. 

Se a tela estiver mostrando algo como descrito na janela abaixo, clique no botão OK.

{% include figure.html caption="Adicione um novo comando no Komodo Edit" filename="komodo-edit-tools-linux.png" %}

## Passo 2 – “Olá Mundo” em Python
--------------------------------

É uma tradição para quem está começando a programar em uma nova linguagem que o 
primeiro programa a ser construído emite a frase "Olá Mundo". 

O Python é uma boa linguagem de programação para iniciantes porque ela é de alto-nível.
Isso quer dizer que é possível escrever pequenos programas que realizam muitas funcionalidades. 
Quanto menor o programa, mais provável que ele caiba em apenas uma tela e mais fácil será de 
manter o controle dele em sua mente.

O Python é uma lingugagem 'interpretada'. Isso significa que existe um programa especial 
(conhecido como Interpretador) que sabe como seguir as instruções da linguagem. Uma forma de utilizar 
o interpretador é guardar todas as suas instruções em um arquivo para, em seguida, 
solicitar ao interpretador que ele interprete o conteúdo deste arquivo.  

Um arquivo que contém instruções de linguagem de programação é conhecido como um programa. 
O interpretador irá executar cada uma das instruções que você incluiu no seu programa e ao final irá parar. 
Vamos experimentar como isso funciona.

No seu editor de texto, crie um novo arquivo e entre o seguinte programa de duas linhas e salve-o na pasta
 `programming-historian`:
 
`ola-mundo.py`

``` python
# ola-mundo.py
print('Olá Mundo')
```

O comando “*Run Python File*” permite que você execute o seu programa.
Se você escolheu um outro editor, este deve ter uma funcionalidade semelhante.
Se tudo correu bem, a tela deverá mostrar algo como isso (Clique na imagem para ver uma imagem maior):

{% include figure.html caption="Olá mundo no Komodo Edit no Linux" filename="komodo-edit-output-linux.png" %}

## Interagindo com o Shell do Python

Outra forma de interagir com o interpretador é utilizar o que é denominado shell.
Você pode digitar um comando e pressionar a tecla Enter e o shell irá responder ao seu comando.
Usar o Shell é um ótimo método para testar os comandos para se certificar que eles realmente 
fazem o que você está imaginando.

Você pode executar um shell do Python iniciando a aplicação "Terminal". No Mac, abra o Finder e
 dê duplo-clik on `Applications -> Utilities -> Terminal` e, em seguida, digite “`python3`” 
 na janela que abre sua tela. 

Ese comando irá abrir o prompt do Python, indicando assim que você já pode utilizar comandos Python no shell.
Agora digite:

``` python
print('Alô Mundo')
```

e pressione Enter. O computador irá responder com:

``` python
Alô Mundo
```

Quando nós quisermos representar uma interação no shell, nós utilizaremos o símbolo
`->` para indicar a resposta do shell para o nosso comando, tal como o exemplo abaixo:

``` python
print('Alô Mundo')
-> Alô Mundo
```

Na sua tela, você verá algo como:

{% include figure.html caption="Alô Mundo no Terminal do Linux" filename="terminal-output-linux.png" %}

Agora que você e o seu computador estão preparados, nós podemos seguir para 
tarefas mais interessantes. Se você está seguindo as lições do Python, 
nossa sugestão é que você tente a próxima aula ‘[Noções básicas de páginas web e HTML][]‘

  [outros editores]: https://wiki.python.org/moin/PythonEditors/
  [Web Site do Komodo Edit]: https://www.activestate.com/products/komodo-edit/
  [Noções básicas de páginas web e HTML]: /licoes/visualizando-arquivos-html
