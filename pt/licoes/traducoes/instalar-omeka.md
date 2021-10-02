---
title: Instalar o Omeka
slug: instalar-omeka
layout: lesson
date: 2016-07-24
authors:
- Jonathan Reeve
reviewers:
- M. H. Beals
editors:
- Fred Gibbs
translator:
- Gabriela Kucuruza 
translation-editor:
- Daniel Alves
translation-reviewer:
- Danielle Sanches
- Joana Vieira Paulino
- Maria Guedes
difficulty: 2
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/377
activity: presenting
topics: [website]
abstract: "Esta lição irá ensiná-lo a instalar a sua própria cópia do Omeka."
avatar_alt: Uma figura trabalhando em uma máquina com diagramas de engrenagens
doi: A INDICAR
---

{% include toc.html %}




### Introdução
O Omeka.net, como descrito na lição [Introdução ao Omeka.net](https://programminghistorian.org/pt/licoes/introducao-omeka-net), é um serviço útil para iniciantes no uso do Omeka, mas existem algumas razões para que queira instalar a sua própria cópia do Omeka. Algumas das razões são:
* **Atualizações**. Através da instalação do Omeka, é possível usar a versão mais atualizada do Omeka assim que ela for disponibilizada, sem precisar de esperar que o Omeka.net atualize o seu sistema. 
* **Plugins e temas**. É possível instalar qualquer plugin ou tema, sem as restrições do Omeka.net.
* **Customização**. É possível comprar um nome de domínio próprio e customizar o seu código para atingir as funcionalidades desejadas. 
* **Controle**. É possível gerir os seus próprios backups, e atualizar o seu servidor para que a sua segurança esteja sempre atualizada. 
* **Preço**. Existem muitos Servidores Privados Virtuais (VPSs) de baixo custo, alguns custam apenas $5 por mês. 
* **Armazenamento**. Muitos provedores de hospedagem compartilhados oferecem agora espaço ilimitado de armazenamento. Isso é útil caso tenha uma grande biblioteca de mídia. 

Nesse tutorial, iremos escrever alguns códigos na linha de comandos. Este tutorial não pede nenhum conhecimento prévio sobre linhas de comando, mas caso queira um tutorial rápido, consulte a[ Introdução ao Bash do Programming Historian (em inglês)](/ "[[Introduction to the Bash Command Line | Programming Historian](https://programminghistorian.org/en/lessons/intro-to-bash) "). Existem outras formas de instalar o Omeka, é claro, algumas utilizando exclusivamente ferramentas [GUI](https://pt.wikipedia.org/wiki/Construtor_de_interface_gr%C3%A1fica). Alguns provedores de hospedagem até oferecem [instalações de um-clique](https://omeka.org/classic/docs/GettingStarted/Hosting_Suggestions/) através de painéis de controle. Muitos desses métodos, entretanto, instalarão versões antigas do Omeka que são mais difíceis de atualizar e manter. O método destacado abaixo pode não ser a maneira mais fácil de instalar o Omeka, mas é uma boa forma de praticar o uso da linha de comandos,  uma habilidade útil para atualizar manualmente instalações anteriores, ou instalar manualmente outras interfaces da web. (Por exemplo, esse método de instalação é bem similar a [Instalação do Wordpress](https://codex.wordpress.org/pt-br:Instalando_o_WordPress).) Há quatro passos nesse processo, e deve demorar aproximadamente uma hora. 

## Passo 1: Configure O Servidor (Host) 

Primeiro, crie uma conta num provedor de hospedagem com acesso SSH. Existem dois tipos de provedores de hospedagem: VPS e compartilhado. Uma hospedagem VPS dá acesso ao root, o que significa que se tem maior controle sobre o servidor, mas que o seu espaço de armazenamento é geralmente limitado. Para arquivos pequenos de 20GB ou menos, essa é a melhor solução, mas para arquivos maiores, planos de hospedagem compartilhada provavelmente serão mais adequados. [DigitalOcean ](https://www.digitalocean.com/) é uma hospedagem VPS fácil de usar e de baixo custo, [Serviços Web da Amazon (AWS)](https://aws.amazon.com/pt/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all) também hospedam servidores virtuais similares nas suas plataformas de Elastic Computing (EC2), direcionada para usuários mais avançados. Tanto o [HostGator](https://www.hostgator.com/) como o [DreamHost](https://www.dreamhost.com/) oferecem hospedagens compartilhadas económicas com armazenamento ilimitado. 

Se uma conta for aberta com um provedor VPS, primeiro deve-se criar um servidor virtual com a interface. (Se estiver usando hospedagem compartilhada, isso já estará feito). No caso do DigitalOcean, as instâncias de VPS são chamadas de "droplets" (gotas) e pode-se criar uma instância simplesmente fazendo o login e clicando em "Criar Droplet". No AWS EC2, o VPS é chamado de "instance" (instância) e é possível criar uma fazendo login no seu console (sua consola, em PT-PT) do EC2e clicando em "Launch Instance" (Lançar Instância). Em ambos os casos, **escolha um sistema Ubuntu** para instalar, uma vez que usaremos comandos para Ubuntu Linux abaixo. Para mais ajuda, veja o guia do Digital Ocean [Como criar o seu primeiro servidor virtual Droplet (em inglês) ](https://web.archive.org/web/20170608220025/https://www.digitalocean.com/community/tutorials/how-to-create-your-first-digitalocean-droplet-virtual-server)e o guia da Amazon [Tutorial: iniciação com Amazon EC2 Linux instâncias](https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/EC2_GetStarted.html#ec2-launch-instance). 

Agora que possui um servidor pronto, aceda através do protocolo SSH. Para isso basta abrir o terminal do computador e escrever ````sshroot@nomedoservidor````, onde ````nomedoservidor```` é o endereço do seu servidor. Consulte a documentação da sua hospedagem (Host) para instruções sobre como realizar login através do protocolo SSH. Aqui seguem alguns guias para hospedagens VPS: 

* [Digital Ocean:Como conectar droplets com SSH (em inglês)](https://docs.digitalocean.com/products/droplets/how-to/connect-with-ssh/) 
* [Serviços Web da Amazon: Conectando a sua instância Linuz usando SSH  (em inglês)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html)

E aqui seguem alguns manuais para hospedagens compartilhadas: 

*  [DreamHost Wiki: SSH  (em inglês)](https://help.dreamhost.com/hc/en-us/articles/216041267-SSH-overview)
* [HostGator: como eu consigo e uso o acesso SSH? (em inglês)](https://www.hostgator.com/help/article/how-do-i-get-and-use-ssh-access)

Depois de conectado/a deve aparecer um prompt com algo parecido com:

```` html 
user@host # 
````

Será aí onde escreveremos os comandos. 

## Passo 2: Instalar Servidor e Banco de Dados 

Os comandos são um pouco diferentes para VPS e para provedores de hospedagem compartilhada. Se tiver uma VPS, siga os passos 2A abaixo. Se tiver hospedagem compartilhada, salte para o passo 2B. 

### Passo 2A: para hospedagem VPS

Primeiramente, precisamos instalar o conjunto de softwares LAMP. LAMP significa Linux, Apache, MySQL e PHP e é o conjunto de softwares que operam o Omeka. Linux é o sistema operativo para o servidor, Apache é o software do servidor web, MySQL gere os bancos de dados, e PHP é a linguagem em que o Omeka está escrito. 

Primeiro, tenha a certeza de que está conectado como usuário root, o usuário root ou superusuário é um usuário de alto nível que tem permissão para fazer qualquer operação/comando no servidor. Se o seu usuário for o root, ao escrever ````whoami```` deve retornar ````root````, caso retorne algo diferente, mude usuários (````su````) para o usuário root com o comando ````su root```` ou ````sudo su root```` .   Se for requisitado, escreva a senha root que foi criada quando o seu VPS foi criado. 

Agora, vamos atualizar o sistema: 

```` html 
apt-get update && apt-get upgrade
````

Agora que o seu sistema está atualizado, vamos instalar o conjunto no servidor: 

```
apt-get install lamp-server^
```
Não se esqueça de incluir o acento circunflexo (````^````) no final.  Esse comando instalará um servidor LAMP, e irá pedir uma senha root do MySQL. Crie uma senha segura e não se esqueça dela, pois vamos precisar dela mais à frente. 

Nesse ponto da instalação, o servidor deve ter páginas da web hospedadas. Se conseguir abrir o seu endereço público de IP do VPS num navegador da web e ver uma página padrão do Apache2 Ubuntu, em que está escrito algo como "It works!" ("Funciona!") então tudo está correto. Se não, provavelmente será preciso dar alguns passos extras para assegurar que as portas estão a encaminhar corretamente. No caso da Amazon EC2, as portas não são automaticamente encaminhadas, então é preciso adicionar portas HTTP para o tráfego de entrada permitido pelo grupo de segurança atual. Para isso, vá em Rede & Segurança --> Grupos de Segurança, selecione o grupo de segurança que está usando, selecione a aba "Entrada" (Inbound), e clique em "Editar", adicionando, então, as portas de HTML. 

Agora, vamos habilitar o módulo ````mod_rewrite```` do Apache, que faz com que o Omeka permita a customizazação dos endereços da URL: 

```
a2enmod rewrite && service apache2 restart
```
Agora, vamos configurar a base de dados. Primeiramente, conecte-se ao programa de banco de dados do MySQL como usuário root (super usuário), através da entrada desse comando: 

```
mysql -u root -p
```
A sinalização ```-u``` permite que se especifique o usuário. Quando a sinalização ```-p``` não for seguida por uma senha, o prompt irá pedir a senha root. Escreva a senha MySQL que foi criada quando o servidor LAMP foi instalado. Agora, deve-se ver um prompt ```mysql>```. Vamos escrever um comando para criar o banco de dados. Aqui, irei chamar o meu banco de dados de ```nome_banco_de_dados```, mas chame o seu da forma que preferir. 

```
CREATE DATABASE nome_banco_de_dados_omeka CHARACTER SET utf8 COLLATE utf8_general_ci;
```

Nessa linha de comandos, ```CHARACTER SET utf8 COLLATE utf8_general_ci``` permite que se possa usar todos os caracteres do seu website e não apenas os caracteres em Latim, que são o padrão. Se o comando der certo, o MySQL deve retornar ```Query OK, 1 row affected (0.00 sec)``` (Consulta OK, 1 afetada). Para os próximos comandos, se tudo der certo, o MySQL deve retornar ```Query OK, 0 row affected (0.00 sec)``` (Consulta OK, 0 linhas afetadas). 

Em seguida, vamos criar a conta de usuário do banco de dados, para que o Omeka possa conversar com o banco de dados: 

```
CREATE USER 'nome_do_usuario'@'localhost' IDENTIFIED by 'senha';
```

Nessa linha, em ```nome_do_usuario``` deve-se colocar o nome da sua preferência, e em ```senha``` substituir por uma senha segura. Podemos, então, permitir que o nosso novo usuário acesse ao banco de dados criado através desse comando: 

```
GRANT ALL PRIVILEGES ON nome_banco_de_dados.* TO 'nome_do_usuario'@'localhost'; FLUSH PRIVILEGES;
```

Agora, o seu banco de dados deve estar configurado para ser usado pelo Omeka. Escreva ``` exit;``` ou aperte Control+C para sair do MySQL e retornar para a linha de comandos. 

### Passo 2B: para Hospedagem Compartilhada

Siga esse passo se estiver usando um provedor de hospedagem compartilhada. Se estiver usando o VPS, salte para o Passo 3. 

Conecte-se ao painel de controle do seu provedor de hospedagem e encontre um item chamado algo como "MySQL Databases" ou "MySQL Banco de Dados". Se o seu provedor de hospedagem estiver usando o cPanel, aparecerá algo semelhante a isso: 

{% include figure.html filename="omeka-install-new-db.png" caption="Instalar novo banco de dados " %}

Na caixa chamada "Criar Novo Banco de Dados", escreva o nome do banco de dados. Em provedores de hospedagem compartilhados, o prefixo irá geralmente ser o seu nome de usuário (no caso do exemplo, é ``` jonreeve``` ), e será escrito o resto. Nesse exemplo, escolheu-se chamar o banco de dados de ``` omeka``` , então o nome completo do banco de dados será ``` jonreeve_omeka``` . Clique, então, em "criar banco de dados.".

 Uma vez que isso foi feito, clique para voltar para a última tela. Abaixo da caixa "Criar novo banco de dados", há uma área para criar novos usuários de MySQL, que se parecerá com esta:

!{% include figure.html filename="omeka-install-new-user.png" caption="Criar novo usuário" %}

Na caixa chamada ```Username``` (nome de usuário), escreva a mesma coisa que foi escrita para o nome do seu banco de dados (isso é apenas uma convenção que te ajudará a manter tudo organizado). Eu colocarei ```omeka``` novamente, para que o nome de usuário completo seja ```jonreeve_omeka```. É uma boa ideia  que se clique em "gerar senha", já que isso gerará uma senha segura. Nesse ponto, guarde em algum lugar o nome do banco de dados (```jonreeve_omeka```), o nome do usuário (que deve ser o mesmo nome do banco de dados) e a senha gerada, já que precisaremos deles depois. 

{% include figure.html filename="omeka-install-password.png" caption="Gerar Senha" %}

Em seguida, adicione o usuário que acabou de ser criado ao banco de dados. Para isso, selecione o usuário e o banco de dados que foram criados nos menus suspensos e clique em "Add" ("adicionar") . 

{% include figure.html filename="omeka-install-add-to-db.png" caption="Adicionar Usuário ao Banco de Dados" %}

Agora, o seu banco de dados está configurado e podemos instalar o Omeka. 

## Passo 3: Fazer download e instalar Omeka. 

Agora, vamos baixar o Omeka diretamente para o servidor. Isso permitirá evitar o processo de fazer o download localmente, descompactando-o no servidor e depois enviando-o para o servidor, o que poupa muito tempo. Para fazer isso, primeiramente vá até ao diretório público de HTML. Usualmente, o caminho desse diretório é ````/var/www/html```` , mas também pode ser ```/var/www```, ou, em algumas hospedagens (host) compartilhadas, ```~/public_html```. Se não tiver a certeza, verifique com o seu serviço de hospedagem (Host) qual o caminho do diretório público HTML.  

```
cd/var/www/html
```
Caso encontre um erro de permissão no VPS, tenha certeza de que se está conectado/a como usuário root com ```su root```. Agora, vamos fazer o download o Omeka. O link para a última versão está disponível em http://omeka.org/download. Use-o com o comando ```wget``` da forma exemplificada abaixo: 

```
wget http://omeka.org/files/omeka-2.4.zip
```

Em seguida, vamos confirmar a instalação do comando ```unzip```:

```
apt-get install unzip
```

Agora, vamos descompactar o ficheiro do Omeka: 

```
unzip omeka-2.4.zip
```

(Se aparecer um erro aqui no VPS, provavelmente, teremos que instalar o comando ```unzip``` com ```apt-get install unzip``` primeiro. Isso descompactará o Omeka num subdiretório do seu website. Supondo que não quer que o website do Omeka tenha a URL ```http://your-domain.com/omeka-2.4/```, vamos mudar o nome do diretório: 

```
mv omeka-2.4 omeka
```

(Ao invés de ```omeka-2.4```, substitua pela versão que foi feito  download.) Agora há uma instalação do Omeka pronta para ser conectada ao banco de dados. 

## Passo 4: Configure o Omeka para usar o seu banco de dados 

Primeiro, vá ao diretório em que o seu programa de instalação do Omeka está, usando o comando ```cd```. No VPS, o caminho será provavelmente ```/var/www/html/omeka ``` e no caso da hospedagem compartilhada ```~/public_html/omeka ```.

```
cd /var/www/html/omeka
```
Se encontrar um erro de permissões no VPS, tenha a certeza de que está conectado/a como usuário root com ```su root```. Agora, vamos editar o arquivo ```db.ini```. A não ser que esteja já confortável com um editor como Vim, iremos usar o editor Nano: 

```
nano db.ini
```
Esse comando resultará em algo como a imagem abaixo:

{% include figure.html filename="omeka-install-db-ini-before.png" caption="Db.ini, antes" %}
 

Agora é possível editar o seu arquivo, mudando os valores ``XXXXXXXX`` pelos valores apropriados para o seu sistema, mas mantendo as aspas (`"`) intactas. O campo `host` deve ser `localhost`, uma vez que o banco de dados está no mesmo servidor. Para `username` e `dbname`, escreva o nome do usuário, a senha e o nome do banco de dados gerado no Passo 2. Para as configurações do exemplo, os valores são: 

-   `host = "localhost"`
-   `username = "jonreeve_omeka"`
-   `password = "%8)&2P^TFR2C"`
-   `dbname = "jonreeve_omeka"`

O arquivo aparecerá, mais ou menos, assim:

{% include figure.html filename="omeka-install-db-ini-after.png" caption="Db.ini, Depois" %} 

Saia (Control+X) e quando requisitado, salve as suas mudanças apertando em `Y`. Agora, vamos mudar o proprietário da sua instalação do Omeka, para que seja legível na Internet: 

```
chown -R www-data:www-data .
```
A partir de agora, temos uma instalação funcional do Omeka. É possível acessar/aceder ao seu script de instalação no link `http://seu-domínio/omeka/install/install.php` substituindo `seu-dominio` pelo nome do seu domínio ou pelo seu endereço de IP e `omeka` pelo nome que foi dado ao diretório acima. Preencha o formulário para completar a configuração da instalação do seu Omeka. Caso encontre qualquer problema no caminho, consulte o [Guia de Instalação do Omeka (em inglês)](https://omeka.org/codex/Installation) ou o [Guia de Problenas do Omeka (em inglês)](https://omeka.org/classic/docs/Installation/Installation/). 
