![](https://lh3.googleusercontent.com/LNaddzmmCXhwqdtlBlEB8XyJS0wDuMHimS783W9UMwI7UxLToVRrAVczAHIS7mCdd_iahM5HRRhOl3FJZPsX9kMpFyG7sJjaNNQIWJcPE0kIr7leOIFEOpW8uh-dZ-uGJUPogf8m)

## Construindo um site estático com Jekyll e Páginas GitHub

![Ícone "Verificada pela comunidade"](https://lh5.googleusercontent.com/uWG8LwuPhmsGqqztzo9MzClozMFzT_mSEMDfIkEFpwL63sycKYBWz953fjhySKWUJt3eTkNQ8fm3MXU3U0PgaxatMltdCgDw9XIrTHKNH8fQzsWA9ltnXG32kcuQqcqxj1N6aVBC)

Amanda Visconti

Esta lição ajudará você a criar um site totalmente seguro, gratuito e de fácil manutenção e atualização. Você terá total controle, como um blog acadêmico, site de projeto ou portfólio online.
  

[Revisado por](https://github.com/programminghistorian/ph-submissions/issues/3) -  [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.en) -[Suporte PH](https://programminghistorian.org/en/individual)

Traduzido por  Vânia Rosa  e Joana Baptista  Revisado por 



**Esta lição é para você que** deseja um site totalmente  gratuito, seguro, de fácil de manutenção e atualização. Você terá o controle total do site, como um blog acadêmico, site de projeto ou portfólio online.

**No final desta aula**, você terá um site básico atualizado e poderá publicar conteúdos que outras pessoas podem visitar, ele será  [assim](https://amandavisconti.github.io/JekyllDemo/). E você terá também alguns recursos para explorar caso queira personalizar ainda mais o site.

**Requisitos:** Um computador (Mac/Windows/Linux estão todos bem, mas esta lição não abrange alguns aspectos do uso do Linux) com a capacidade de baixar e instalar software, uma conexão à internet que possa suportar o download de software. Os usuários relataram precisar de entre 1 a 3 horas para completar toda a lição.

   

## Conteúdo
-   [O que são sites estáticos, Jekyll, etc. e por que eu poderia me importar?](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#what-are-static-sites-jekyll-etc--why-might-i-care-)
    -   [Sites dinâmicos, sites estáticos e Jekyll](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#dynamic-websites-static-websites--jekyll-)
    -   [Páginas do GitHub & GitHub](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#github--github-pages-)
    -   [Quais são as razões para usar um site estático?](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#what-are-the-reasons-for-using-a-static-website-)
-   [Preparação para instalação](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#preparing-for-installation-)
    -   [Sistemas operacionais](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#operating-systems-)
    -   [Conta de usuário do GitHub](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#github-user-account-)
    -   [Aplicativo GitHub Desktop](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#github-desktop-app-)
    -   [Editor de texto](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#text-editor-)
    -   [Linha de comando](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#command-line-)
-   [Instalando dependências](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#installing-dependencies-)
    -   [Em um Mac](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#on-a-mac-)
    -   [Suíte de ferramentas de linha de comando](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#command-line-tools-suite-)
    -   [Homebrew](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#homebrew-)
    -   [Ruby & Ruby Gems](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#ruby--ruby-gems-)
    -   [Nodejs](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#nodejs-)
    -   [Jekyll](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#jekyll-)
    -   [No Windows](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#on-windows-)
-   [Configuração jekyll](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#setting-up-jekyll-)
-   [Executando um site localmente](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#running-a-website-locally-)
    -   [Mini planilha de trapaça](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#mini-cheatsheet-)
-   [Ajustando as configurações](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#tweaking-the-settings-)
    -   [Configurações básicas do site via _config.yml](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#basic-site-settings-via-_configyml-)
    -   [Onde (e o quê) está tudo?](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#where-and-what-is-everything-)
-   [Escrevendo páginas e postagens](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#writing-pages-and-posts-)
    -   [Autoria em Markdown](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#authoring-in-markdown-)
    -   [Páginas autorais](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#authoring-pages-)
    -   [Posts de autoria](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#authoring-posts-)
-   [Hospedagem em páginas do GitHub](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#hosting-on-github-pages-)
    -   [Mini planilha de trapaça](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#mini-cheatsheet--1)
-   [Ficando chique](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#getting-fancy-)
    -   [Design visual](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#visual-design-)
    -   [Funcionalidade](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#functionality-)
-   [Planilha de trapaça](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#cheatsheet-)
-   [Ajuda, créditos e mais leitura](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#help-credits--further-reading-)
    -   [Ajuda](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#help-)
    -   [Créditos](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#credits-)
    -   [Leitura suplementar](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#further-reading-)

## [O que são sites estáticos, Jekyll, etc. e por que eu poderia me importar?](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#what-are-static-sites-jekyll-etc--why-might-i-care-)

Este tutorial é construído sobre a [Documentação Oficial jekyll](https://jekyllrb.com/docs/home/) escrita pela comunidade Jekyll. Se você quiser conhecer ainda mais, confira abaixo na seção ["Leia mais"](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section9-3) e fique por dentro desses termos!

  

## [Sites dinâmicos, sites estáticos e Jekyll](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#dynamic-websites-static-websites--jekyll-)

Os Websites dinâmicos, tais como os criados e geridos por um sistema de gestão de conteúdos como Drupal, WordPress, e Omeka, retiram informações de uma base de dados para preencher o conteúdo de uma página Web. Quando procura um livro na Amazon.com, por exemplo, a página de resultados de pesquisa que é mostrada não existia já como uma página HTML completa; em vez disso, a Amazon.com tem um modelo para página de resultados de pesquisa que inclui coisas que todas as páginas de resultados partilham (como o menu principal e o logotipo da Amazon), mas consulta a base de dados para inserir os resultados dessa pesquisa que iniciou nesse modelo.

  

Os Websites estáticos, por outro lado, não usam um banco de dados para armazenar informações. Ao invés disso, todas as informações a serem exibidas em cada página da web já estão contidas em um arquivo HTML para essa página da web. As páginas HTML que compõem um site estático podem ser totalmente escritas à mão, ou você pode descarregar parte desse trabalho usando algo como Jekyll.

  

Jekyll é um software que ajuda você a "gerar" ou criar um site estático (você pode ver Jekyll descrito como um "gerador de local estático"). Jekyll leva modelos de página — aquelas coisas como menus principais e rodapés que você gostaria de compartilhar em todas as páginas da Web em seu site, onde escrever manualmente o HTML para incluí-los em todas as páginas da Web seria demorado. Esses modelos são combinados com outros arquivos com informações específicas (por exemplo, um arquivo para cada post no site) para gerar páginas HTML completas para os visitantes do site verem. A Jekyll não precisa fazer nada como consultar um banco de dados e criar uma nova página HTML (ou preencher uma parcial) quando você visitar uma página web; ele já tem as páginas HTML totalmente formadas, e ele apenas atualizá-los quando/se eles mudarem.

  

Note que, quando alguém se refere a um "site jekyll", eles realmente significam um site estático (HTML simples) que foi criado usando Jekyll. Jekyll é um software que cria sites. Jekyll não está realmente "executando" o site ao vivo; em vez disso, Jekyll é um "gerador de site estático": ele ajuda você a criar os arquivos estáticos do site, que você então hospeda como qualquer outro site HTML.


Como os sites estáticos são realmente apenas arquivos de texto (nenhum banco de dados para complicar as coisas), você pode facilmente criar um site estático — ou seja, usar uma ferramenta para acompanhar as diferentes versões do site ao longo do tempo, rastreando como os arquivos de texto que compõem o site foram alterados. A versão é especialmente útil quando você precisa mesclar dois arquivos (por exemplo, dois alunos estão escrevendo um post no blog juntos, e você quer combinar as duas versões), ou quando você quer comparar arquivos para procurar diferenças entre eles (por exemplo, "Como a página original sobre descreve este projeto?"). A versão é ótima quando se trabalha com uma equipe (por exemplo, ajuda você a combinar e acompanhar o trabalho de diferentes pessoas), mas também é útil ao escrever ou executar um site por conta própria.

  

Leia mais sobre [Jekyll aqui](https://jekyllrb.com/docs/home/) ou [geradores estáticos aqui](https://davidwalsh.name/introduction-static-site-generators).

  

## [Páginas do GitHub & GitHub GitHub](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#github--github-pages-)

[O GitHub Pages](https://pages.github.com/) é um lugar gratuito para armazenar os arquivos que executam um site e hospeda esse site para as pessoas visitarem (ele só funciona para determinados tipos de site, como sites HTML básicos ou sites Jekyll, e não hospeda bancos de dados).

  

[O GitHub](https://github.com/) é uma maneira amigável de usar [o git](https://git-scm.com/documentation), um sistema para catalogar: manter o controle de alterações em arquivos de computador (incluindo documentos de código e texto) ao longo do tempo (como explicado [acima](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section0-1)). Se você está curioso, veja esta [lição amigável para explorar o GitHub](https://guides.github.com/activities/hello-world/).

  

## [Quais são os motivos para usar um site estático?](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#what-are-the-reasons-for-using-a-static-website-)

Opções como [Drupal](https://www.drupal.com/), [Wordpress](https://wordpress.org/) e [Omeka](https://omeka.org/) são bons para a necessidade de sites complexos e interativos como a Amazon ou uma edição digital interativa de um romance. Mas para muitos blogs, sites de projetos e portfólios online, um site estático (como um site criado usando Jekyll ) pode fazer tudo o que você precisa enquanto oferece algumas vantagens:

  

-   **Manutenção**: Atualizações e manutenção são necessárias com muito menos frequência ( ao invés de semanalmente, ocorre uma vez por ano).
    
-  **Preservação** : Nenhum banco de dados significa que os arquivos de texto que compõem seu site são tudo o que você precisa salvar para preservar e replicar seu site. É fácil apoiar seu site ou submetê-lo a um repositório institucional.
    
-   **Aprendizado**: Como não há um banco de dados e não há um monte de arquivos de código que forneçam recursos que você pode nem precisar, há muito menos peças reais do seu site — é mais fácil passar por todos eles e realmente saber o que cada um faz, caso você esteja tão inclinado. Portanto, é muito mais fácil se tornar um usuário básico e avançado da Jekyll.
    
-   **Mais personalização possíve**l: Uma vez que aprender a dominar seu site é mais fácil, coisas que você definitivamente vai querer fazer, como mudar o visual (o "tema") de um site criado pela Jekyll, são muito mais fáceis do que alterar o visual de um site wordpress ou drupal.
    
-   **Hospedagem gratuita**: Embora muitas ferramentas de sites como Drupal, WordPress e Omeka sejam gratuitas, hospedá-las (pagando por alguém para servir os arquivos do seu site para visitantes do site) pode custar dinheiro.
    
-   **Versão**: Hospedagem no GitHub Pages significa que seu site está vinculado à interface visual do GitHub para versão de git, para que você possa rastrear alterações em seu site e sempre reverter para um estado anterior de qualquer post, página ou o próprio site, se necessário. Isso inclui arquivos carregados que você pode querer armazenar no site, como syllabi antigo e publicações. [(A versão é explicada com mais detalhes acima.](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section0-1))
    
-   **Segurança**: Não há banco de dados para proteger hackers.
    
-  **Velocidade**: Arquivos mínimos do site e nenhum banco de dados para consulta significam um tempo mais rápido de carregamento de página.
    

  

Criar um site estático usando o Jekyll oferece mais vantagens, além de todos os benefícios de um site estático HTML codificado à mão:

  

- **Aprendizado:** É mais fácil começar a personalizar seu site e escrever seu conteúdo, já que você não precisará aprender ou usar HTML.
    
-  **Construído para blogar:** Jekyll foi construído para apoiar as postagens de blog, por isso é fácil "blogar" (inserir conteúdo novo, classificado por data) e fazer tarefas relacionadas, como exibir um arquivo de todas as postagens do blog por mês, ou incluir um link para as três postagens mais recentes do blog na parte inferior de cada post.
    
-   **A modelagem automatiza tarefas repetidas:** A Jekyll facilita a automatização de tarefas repetidas do site através de seu sistema de “modelagem”. Você pode criar conteúdo que deve, por exemplo, aparecer no cabeçalho e no rodapé de cada página (por exemplo, imagem do logotipo, menu principal) ou seguir o título de cada post do blog (por exemplo, nome do autor e data de publicação). Essas informações modeladas serão repetidas automaticamente em todas as páginas apropriadas da Web, em vez de forçá-lo a reescrever manualmente essas informações onde você deseja que elas apareçam. Você não apenas poderá salvar, copiar e colar, se você quiser alterar algo que aparece em cada página do seu site, por exemplo, um novo logotipo do site ou um novo item no menu principal, poderá alterá-lo uma vez em um modelo e mudará em todos os lugares que ele aparecer em seu site.
    

  

## [Preparação para a instalação](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#preparing-for-installation-)

Estamos prontos para começar a trabalhar! No final da lição, teremos alguns programas instalados em seu computador. Usar a linha de comando para instalar algumas coisas que só podem ser instaladas dessa forma, olhar e personalizar uma versão privada do seu site e finalmente tornar seu site acessível publicamente na Web. Se você tiver problemas em algum momento desta aula, consulte a [seção de ajuda](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section9) para saber como fazer perguntas ou relatar problemas.

  

Nesta seção, vamos garantir que você tenha algumas coisas prontas em seu computador para quando precisarmos delas mais tarde na aula, cobrindo o sistema operacional que você pode usar (ou seja, Mac/Windows/Linux), criando uma conta do GitHub e instalando o aplicativo GitHub, por que você deve usar um programa de "editor de texto" para trabalhar em seu site e como usar a linha de comando.

  

Você precisará instalar uma ferramenta de desenvolvimento web padrão e confiável, por isso não é importante saber exatamente o que cada uma dessas coisas faz antes de instalá-la. Tentarei equilibrar mais informações sobre as coisas mais úteis para você entender completamente, fornecendo uma breve explicação para cada peça e também link para mais informações, caso queira saber mais sobre o que você está colocando em seu computador.

  

## [Sistemas operacionais](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#operating-systems-)

Este tutorial pode ser utilizado tanto pelos usuários do Mac quanto pelos usuários do Windows. Jekyll também pode trabalhar para o Linux. Este tutorial usa o software GitHub Desktop (somente Mac e Windows) para simplificar, mas em vez disso, os usuários de Linux precisarão usar *git* sobre a linha de comando (não coberta aqui).
 

Jekyll não é oficialmente compatível para windows, por isso que nenhuma documentação oficial de Jekyll (as páginas que guiam através da configuração jekyll e o que suas diferentes peças fazem, que você poderia consultar em vez ou além desta lição) aborda o uso do Windows. Usei as [instruções do Windows de David Burela](https://davidburela.wordpress.com/2015/11/28/easily-install-jekyll-on-windows-with-3-command-prompt-entries-and-chocolatey/) para observar os lugares na [seção "Instalando dependências"](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section2) quando os usuários do Windows devem fazer algo diferente; o resto da lição deve funcionar da mesma forma para usuários de Mac e Windows, embora note que as capturas de tela ao longo da aula são todas de um Mac (então a coisa pode parecer ligeiramente diferente para um usuário do Windows).

  

## [Conta de usuário do GitHub](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#github-user-account-)

Uma conta de usuário do GitHub permitirá que você hospede seu site (disponibilize-o para outros visitarem) gratuitamente no GitHub (vamos cobrir como em um passo posterior). Como bônus, ele também permitirá que você acompanhe as versões do site e sua escrita à medida que cresce ou muda com o tempo.

1.  Visite [GitHub.com](https://github.com/) e clique no botão "Inscreva-se" no canto superior direito. Escreva o nome de usuário desejado. Isso será visível para outros, identificá-lo no GitHub e também fazer parte da URL do seu site; por exemplo, o nome de usuário gitHub da autora é amandavisconti e a URL de seu site demo Jekyll é http://amandavisconti.github.io/JekyllDemo/. (Note que você também pode comprar seu próprio nome de domínio e usá-lo para este site, mas isso não será coberto neste tutorial). Escreva também o endereço de e-mail e senha desejados e clique em "Criar uma conta".
    
2.  Na página seguinte, clique no botão "Escolher" ao lado da opção de plano "Livre", ignore a caixa de seleção "Ajude-me a configurar uma organização a seguir" e clique em "Terminar de se inscrever".
    
3.  Opcional: Visite https://github.com/settings/profile para adicionar um nome completo (pode ser seu nome real, nome de usuário do GitHub ou outra coisa) e outras informações de perfil público, se desejar.
    

  

## [Aplicativo GitHub Desktop](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#github-desktop-app-)

O aplicativo GitHub Desktop facilitará a atualização do seu site ao vivo (que o configuramos). Ao invés de usar a linha de comando toda vez que você quiser atualizar seu site, você poderá usar uma ferramenta visual mais fácil para atualizar seu site.

  

1.  Visite o site do [GitHub Desktop](https://desktop.github.com/) e clique no botão "Baixar o GitHub Desktop" para baixar o software GitHub Desktop para o seu computador (somente Mac e Windows; Os usuários de Linux precisarão usar o git apenas através da linha de comando, que não está coberta nesta versão do tutorial).
    
2.  Uma vez que o arquivo tenha baixado completamente, clique duas vezes nele e use as seguintes instruções para instalar o GitHub Desktop.
    
3.  Digite o nome de usuário e senha para a conta GitHub.com que você criou usando as etapas acima. (Ignore o botão "Adicionar uma conta corporativa".) Clique em "Continuar".
    
4.  Digite o nome e o endereço de e-mail que deseja que o trabalho em seu site seja associado (provavelmente apenas seu nome público e endereço de e-mail de trabalho, mas cabe a você!).
    
5.  Na mesma página, clique no botão "Instalar ferramentas de linha de comando" e digite o nome de usuário e senha do seu computador se solicitado (em seguida, clique no botão "Instalar helper" no prompt). Depois de receber uma mensagem pop-up que todas as ferramentas da linha de comando instalaram com sucesso, clique em continuar.
    
6.  A última página perguntará "Quais repositórios você gostaria de usar?". Ignore isso e clique no botão "Feito".
    
7.  Opcional: Siga o passo a passo do aplicativo GitHub Desktop que aparecerá (isso não é necessário; cobriremos qualquer coisa que você precisa fazer com o GitHub nesta lição).
    

  

## [Editor de texto](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#text-editor-)

Você precisará baixar e instalar um programa de "editor de texto" em seu computador para fazer pequenas personalizações ao código do seu site Jekyll. Boas opções gratuitas incluem [TextWrangler](http://www.barebones.com/products/textwrangler/download.html) (Mac) ou [Bloco de Notas](https://notepad-plus-plus.org/)++ (Windows). Software voltado para processamento de palavras, como Microsoft Word ou Word Pad, não é uma boa escolha porque é fácil esquecer como formatar e salvar o arquivo, adicionando acidentalmente a formatação extra e/ou invisível e caracteres que quebrarão seu site. Você vai querer algo que especificamente pode salvar o que você escreve como texto simples (por exemplo.HTML, Markdown).

  

**Opcional:** Consulte a seção ["Authoring in Markdown" abaixo](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section5-2) para obter notas em um programa de edição específico do Markdown, que você também pode desejar instalar quando chegar ao ponto de autorizar páginas da Web e/ou postagens no blog.

  

## [Linha de comando](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#command-line-)

A linha de comando é uma maneira de interagir com o seu computador usando texto: permite digitar comandos para ações de coisas mais simples, como "mostre-me uma lista dos arquivos neste diretório" ou "alterar quem pode acessar esse arquivo", para um comportamento mais complexo. Às vezes, existem boas maneiras visuais de fazer as coisas no seu computador (por exemplo, o aplicativo GitHub Desktop que instalamos acima),e às vezes você precisará usar a linha de comando para digitar comandos para fazer com que seu computador faça coisas. O Historiador de Programação tem [uma lição aprofundada explorando a linha de comando escrita](https://programminghistorian.org/lessons/intro-to-bash) por Ian Milligan e James Baker, caso você queira mais informações do que as fornecidas aqui. Mas esta lição cobrirá tudo o que você precisa saber para completar a lição (e só usaremos a linha de comando quando for necessário ou muito mais fácil do que uma interface visual).

  

Onde a linha de comando usa comandos de texto, uma "interface gráfica do usuário" (também conhecida como GUI) é o que você provavelmente usa para trabalhar com seu computador: qualquer coisa onde os comandos são dados através de uma interface visual contendo ícones, imagens, cliques no mouse, etc. é uma GUI. Muitas vezes é mais simples e rápido digitar (ou cortar e colar de um tutorial) uma série de comandos através da linha de comando, do que fazer algo usando uma GUI. Às vezes há coisas que você vai querer fazer para as quais ninguém ainda criou uma GUI e você vai precisar fazê-las através da linha de comando.

  

O programa de linha de comando padrão é chamado de "Terminal" em Macs (localizado em aplicativos > Utilitários),e "Prompt de Comando", "Windows Power Shell" ou "Git Bash" no Windows (estas são três opções diferentes que cada uma difere no tipo de comandos que eles aceitam; vamos entrar em detalhes sobre as quais você deve usar mais tarde na aula).

  

Veja abaixo como é uma janela de linha de comando no Mac do autor (usando Terminal). Você verá algo como o Macbook-Air - DrJekyll$ abaixo na janela da sua linha de comando. Esse texto é chamado de "prompt" (está levando você a inserir comandos). Na captura de tela, Macbook-Air é o nome do meu computador, e DrJekyll é a conta de usuário atualmente logado (o prompt usará nomes diferentes para o seu computador e nome de usuário).

![](https://lh5.googleusercontent.com/vKNVZZI1EoZf8gjT2yy1JRMGjWwpfi-Rj5v0g7ju47jVdqpA4FkRaWx9VKvdYSnRIAttxIkK7zA6DImVvdH3J6WdI9913Ggotzi0TXSUvUv8Jkypo98SIPkqYuT-rjCulZ5SS8Ou)
						Como é o prompt de comando em um Mac

 Quando solicitado a abrir uma janela de linha de comando e digitar comandos nesta lição, tenha em mente o seguinte:

  1.  **Os comandos que você deve digitar (ou copiar/colar) na linha de comando são formatados assim**: Cada pedaço de código formatado deve ser copiado e colado na linha de comando, seguido por pressionar enter. example of code formatting  
      
    
2.  **Deixe os processos de instalação funcionarem completamente antes de inserir novos comandos.** Às vezes, digitar um comando e pressionar enter produz um resultado instantâneo. Às vezes, muito texto começa a encher a janela da linha de comando, ou a janela da linha de comando parece não estar fazendo nada (mas algo está realmente acontecendo nos bastidores, como baixar um arquivo). Quando você digitar um comando e apertar enter, você precisará esperar que esse comando termine completamente antes de digitar qualquer outra coisa, ou você pode parar um processo no meio, causando problemas. {0}. Você saberá que seu comando foi concluído quando a linha de comando cuspir o prompt novamente (por exemplo, Macbook-Air:- DrJekyll$ no computador do autor). Veja a captura de tela abaixo como um exemplo de entrada de um comando, seguido por algum texto mostrando o que estava acontecendo enquanto esse comando foi processado (e às vezes pedindo que você faça algo, como digitar sua senha). Finalmente o reaparecimento do prompt de comando para que você saiba que está tudo bem e digitar outra coisa.
    

  

![](https://lh3.googleusercontent.com/2g5bpqSYwNM30ovet3bASTNbAMrc2OnB0gei-SgTQ8Uej7iPQ6f3MsddykRiFOfQqhfzP19YCXtxYJYnm8pRgCHF2QkjeQZVFMtulJRLbaNRwZq_qPP4_zs9W9TGt8I23tKFTH8i)

Um exemplo de entrada de um comando, seguido por algum texto mostrando o que estava acontecendo enquanto esse comando era processado (e às vezes pedindo-lhe para fazer algo, como digitar sua senha), e finalmente o reaparecimento do prompt de comando para que você saiba que está tudo bem digitar outra coisa
  

Se você precisa fazer outra coisa na linha de comando e não quiser esperar, basta abrir uma janela de linha de comando separada (em um Mac, apertar o comando-N ou ir para Shell > Nova janela > Nova Janela com Configurações Básicas) e fazer as coisas lá enquanto espera o processo na outra janela da linha de comando para terminar.

  

1.  Digitar ou colar nos mesmos comandos muito, ou quer lembrar de algo que você digitou antes? Você pode digitar o ↑ (seta para cima) na linha de comando para percorrer comandos digitados recentemente. Basta pressionar “enter” depois que o que você deseja usar aparece.  
          

Começando pelo macOS Catalina, o zsh substituiu o bash como o shell padrão para Macs. Esta lição não foi testada na concha zsh. Se você deseja definir sua concha para bash para seguir este tutorial, confira as instruções [aqui](https://support.apple.com/en-us/HT208050).

  

## [Instalando dependências](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#installing-dependencies-)

Vamos instalar algumas dependências de software (ou seja, o código jekyll depende para ser capaz de trabalhar), usando a linha de comando porque não há uma interface visual para fazer isso. Esta seção é dividida com instruções para aquele que está usando  [ um Mac](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#sectionMac). Se você estiver usando um [Windows](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#sectionWindows), pule para as instruções sobre [Windows](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#sectionWindows).

  

## [Em um Mac](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#on-a-mac-)

Se você estiver usando um computador Mac, siga as instruções abaixo até que você acerte uma linha que diz que as instruções específicas do Windows estão começando.

Abra uma janela de linha de comando (Aplicativos > Utilities > Terminal) e digite o código mostrado nas etapas abaixo (código é formatado assim), mantendo [as dicas da linha de comando de cima](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section1-4) em mente.

### [Suíte de ferramentas de linha de comando](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#command-line-tools-suite-)

Você precisará primeiro instalar o conjunto mac "ferramentas de linha de comando" para poder usar [o Homebrew](https://brew.sh/) (que vamos instalar em seguida). O Homebrew permite baixar e instalar software de código aberto em Macs da linha de comando (é um "gerenciador de pacotes"), o que tornará a instalação do Ruby (o idioma em que Jekyll é construído) mais fácil.

1.  Em Terminal, cole o seguinte código e pressione enter:
    
		xcode-select --install

Você verá algo como o texto abaixo, seguido por um popup:

![After entering the code at the command prompt, you'll see a message stating 'install requested for command line developer tools'](https://lh4.googleusercontent.com/v5DC7mgtzIVS60i_JKUz519-4eQuMXvnuacVc1mIsVH8hPymeqie0xmUBudEeJuk7YupYSlO-vvzFQ4-i_yujyUMyrySBU-Iio5jDZf4oJ2ZII7iP9lKZbkw0k45g8WBWsha74ng)

	Depois de digitar o código no prompt de comando,você 
	verá uma mensagem informando 'instalar ferramentas
	 solicitadas para desenvolvedor de linhas de comando'

No *popup,* clique no botão "Instalar"(não no botão "Obter *Xcode*", que instalará código que você não precisa e pode levar horas para baixar):

![A popup appears with an install button](https://lh3.googleusercontent.com/iDInfeZsL02x7zUiYNsk3SDLEDazt6khg5XkwUhHhhm0EcOqnuXrxHuZochkRNUzJCH6c_bTBM61_Kl75O54kuTvSG3SLOZGRBoZLJk-csM0zE1QznWowU7DYFNWq5PySQ-iKsoW)

	Um pop-up aparece com um botão de instalação

Você verá uma mensagem de que "O *software* foi instalado" quando a instalação estiver concluída:

![Popup message stating the software was installed](https://lh4.googleusercontent.com/m70c7jTFxu6iyY2eOK4rDPtKmR5phZ0OzE9J2U20MVovVviCr_QixWlEkovEuyiPh73bPBfLXR3zpU9ctN_YSwkvfqSXVnTkq9mGCh-Ut2VLbaAPPCe_PMs2inCymLf5AZLgVSrw)

	Mensagem pop-up informando que o software foi instalado

### [Homebrew](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#homebrew-)

Depois que o conjunto de ferramentas da linha de comando estiver concluído a instalação, retorne à janela da linha de comando e digite o seguinte para instalar [o Homebrew:](https://brew.sh/)

	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Você precisará pressionar ”enter” quando solicitado e digitar a senha do seu computador quando solicitado. Veja abaixo a captura de tela do comando inserida na linha de comando do autor, seguida por todo o texto que apareceu (incluindo o prompt para pressionar enter, e digitar minha senha).

![](https://lh6.googleusercontent.com/yzjRuf2yRsbcwtudY3Y_bZVj9PkG5QWuaS29QwHZDwZtNVjUDAJrdUFXi2hnTx6xu0ZULbE1I-iCLxiJlIBnM0QQQhNk0YiVOJAE5PaDnNdBl7T-MUF6_Dv2M8hUfKTn-CKnqjhT)
O comando entrou na linha de comando do autor, seguido por todo o texto que apareceu (incluindo o *prompt* para pressionar enter,e digitar minha senha)

### [Ruby & Ruby Gems](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#ruby--ruby-gems-)

Jekyll é construído a partir da linguagem de [codificação Ruby.](https://en.wikipedia.org/wiki/Ruby_%28programming_language%29)  [Ruby Gems](https://rubygems.org/) facilita a configuração de software Ruby como jekyll (é um gerenciador de pacotes, assim como o Homebrew. Ao invés de facilitar a instalação em Macs, ele adiciona algumas coisas para tornar as instalações ruby mais simples).

	brew install ruby

Não se esqueça de esperar até que o prompt de comando apareça novamente para digitar o seguinte comando:

	gem install rubygems-update

Se você receber um erro de permissões neste momento, a configuração do diretório do usuário pode ajudar. Tente entrar:`GEM_HOME`

`echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc`  `echo 'export GEM_HOME=$HOME/gems' >> ~/.bashrc`  `echo 'export PATH=$HOME/gems/bin:$PATH' >> ~/.bashrc` seguido por .`source ~/.bashrc`

**Alguns usuários do macOS Catalina e do macOS Big Sur relataram ter encontrado dificuldades para instalar ruby & ruby gems. Esta lição antecede a liberação desses sistemas operacionais, mas o código fornecido aqui foi adaptado para oferecer uma possível solução.**

### [Nodejs](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#nodejs-)

[NodeJS](https://nodejs.org/en/) (ou Node.js) é uma plataforma de desenvolvimento (em particular, um "ambiente de tempo de execução") que faz coisas como o Javascript mas funciona mais rápido.
`brew install node`

### [Jekyll](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#jekyll-)

[Jekyll](https://jekyllrb.com/) é o código que cria seu site (ou seja, "geração de sites"), facilitando a realização de certas tarefas comuns, como usar o mesmo modelo (mesmo logotipo, menu, informações do autor...) em todas as páginas de postagem do seu blog. Há mais informações sobre [o que são Jekyll e sites estáticos](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section0-1), e sobre [por que você gostaria de usar Jekyll para fazer um site estático](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section0-3), acima.

`gem install jekyll`

Se você receber um erro de permissões neste momento, entrar em vez do comando acima pode ajudar.`usr/local/bin/gem install jekyll`

**Pule as etapas a seguir (que são apenas para usuários do Windows) e pule para configurar  [Jekyll](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section3).**  

### [No Windows](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#on-windows-)

As instruções para usuários do Windows diferem das dos usuários de Mac apenas nesta seção "Instalando dependências". Só faça o seguinte se estiver usando o Windows.

1.  Precisamos de uma ferramenta de linha de comando que reconheça os mesmos comandos que macs e computadores Linux fazem, ou seja, sistemas operacionais Unix. Acesse: [https://git-scm.com/downloads](https://git-scm.com/downloads) e clique no link "Windows" em "Downloads". Uma vez terminado o download, clique duas vezes no arquivo baixado e siga os passos para instalar o Git Bash (deixe todas as opções do jeito que já estão).
    
2.  Abra "Prompt de Comando" (abra o menu iniciar e procure por "Prompt de Comando" e um aplicativo que você pode abrir deve aparecer).
    
3.  Chocolatey é um "gerenciador de pacotes": código que permite baixar e instalar software de código aberto no Windows facilmente a partir da linha de comando. Agora vamos instalar a Chocolately (certifique-se de destacar e copiar todo o clube de texto abaixo juntos, não como linhas separadas). Digite o código mostrado nas etapas abaixo (_`o código é formatado assim`), mantendo [as dicas da linha de comando de cima](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section1-4) em mente:  
 
##### @powershell -NoProfile -ExecutionPolicy unrestricted -Command "(iex ((new-object net.webclient). DownloadString('https://chocolatey.org/install.ps1'))) >$null 2>&1" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin ##
 
 
4.  Feche o aplicativo "Prompt de Comando" e abra "Git Bash" (que você instalou recentemente).  **Agora você usará Git Bash sempre que a linha de comando for solicitada.**
    
5.  Jekyll é construído a partir da  [linguagem de codificação Ruby](https://en.wikipedia.org/wiki/Ruby_%28programming_language%29).  [Ruby Gems](https://rubygems.org/)  facilita a configuração de software Ruby como o Jekyll (é um gerenciador de pacotes, assim como o Homebrew — em vez de facilitar a instalação em Macs, ele adiciona algumas coisas para tornar as instalações ruby mais simples). Agora vamos instalar ruby (isso vai levar alguns minutos):
    
    `choco install ruby -y`
6.  Feche o programa de linha de comando e reinicie (Ruby não funcionará até que você tenha feito isso uma vez).
    
7. [Jekyll](https://jekyllrb.com/)  é o código que cria o seu site (ou seja, "geração de site"), facilitando a realização de certas tarefas comuns, como usar o mesmo modelo (mesmo logotipo, menu, informações do autor...) em todas as páginas de postagem do seu blog. Há mais informações sobre  [o que são Jekyll e sites estáticos](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section0-1), e  [sobre por que você gostaria de usar Jekyll para fazer um site estático](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section0-3), acima. Agora vamos instalar o Jekyll (se o Windows Security lhe der um popup de aviso, ignore-o):

`gem install jekyll`​
    

**A partir de agora, todas as instruções são para usuários de Mac e PC!**

## [Configuração jekyll](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#setting-up-jekyll-)

Você já instalou tudo o que é necessário para fazer o seu site. Nesta seção, usaremos a Jekyll para gerar uma nova pasta cheia de arquivos que constituem o seu site. Também salvaremos essa pasta em um lugar acessível ao aplicativo GitHub Desktop para que eles estejam no lugar certo quando quisermos publicá-las como um site público mais tarde na aula.

1.  Você precisará saber o caminho do arquivo para a pasta GitHub criada instalando o aplicativo GitHub Desktop (este é um texto que diz onde uma pasta ou arquivo específico está dentro da árvore de diretório em seu computador, por exemplo/Desktop/MyRecipes/Spaghetti.doc). Se você não conhece o caminho do arquivo da pasta Do GitHub, clique no ícone da lupa no canto superior direito da tela do computador (em um Mac) ou use o campo de pesquisa no Menu Iniciar (Windows).
    
  
![O ícone de lupa que permite pesquisar um computador Mac está no canto superior direito da tela do computador](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-5.png)

	O ícone de lupa que permite pesquisar um 
	computador Mac está no canto superior direito
	da tela do computador

Em Macs, uma caixa de pesquisa aparecerá no meio da tela; digite "GitHub", em seguida, clique duas vezes na opção "GitHub" que aparece em "Pastas" para revelar a pasta GitHub no Finder (isso pode parecer ligeiramente diferente no Windows, mas deve funcionar o mesmo).  
A pasta pode ser nomeada como o aplicativo ("Github Desktop").

Observe que, em alguns computadores, esta pasta é rotulada como "GitHub para Macs" e pode não aparecer em uma pesquisa. Se as etapas anteriores não localizaram uma pasta do GitHub para você, navegue até Library > Suporte ao aplicativo no Finder e verifique se uma pasta "GitHub for Mac" está localizada lá. Você pode, alternadamente, pressionar a tecla Opção ao clicar no menu Finder Go para ver a pasta "Biblioteca" para o seu nome de usuário.

![After searching for 'GitHub', a “GitHub” option appears under the 'Folders' heading; double-click 'GitHub' to reveal the GitHub folder in Finder](https://lh5.googleusercontent.com/ES-m-O5OGgAJs2EhOFZUbvHhNq4T2CXLI16DteXzC3TJF8wxC9OWAYK6iqNa1Y0NZNcZMR3KBdOOp4kfxJANu7gqaOsvsN3gh8aTFvJ1hSg2LocO9rcvdNv2TFuPdyQSgL2Y9KJO)
##### Depois de procurar por 'GitHub', uma opção "GitHub" aparece no título 'Pastas'; clique duas vezes no 'GitHub' para revelar a pasta GitHub no Finder 

Clique com o botão direito do mouse na pasta "GitHub" e escolha "Copiar 'GitHub'". O caminho do arquivo da pasta GitHub agora é copiado para a área de transferência.

1.  Na linha de comando, escreva , seguido de um espaço, seguido pelo caminho do arquivo para a pasta GitHub (digite-o se conhecido ou pressione Command-v para colar no caminho de arquivo que você copiou na etapa anterior). No computador do autor (logado como o usuário DrJekyll) este comando se parece com:cd
    

![The author's computer after entering cd, followed by a space, followed by the file path to their GitHub folder](https://lh6.googleusercontent.com/4xbJ2HJ0hCWwLYaKnPpe8RTROg7sy1cb5essJ-_scCxNQzUIPhwP_I9-kGQskXLrMKFkQWUp_Qi0DM4vzBw0pegxwmZ9R7AXQLfj1XUUbdu1zSSQCbpMiUKwXqUm9gdSvGh6lprN)
##### O computador do autor após a entrada do CD, seguido por um espaço, seguido pelo caminho do arquivo para sua pasta GitHub

O comando cd (change directory) diz ao seu computador para olhar a pasta específica do computador, pelo caminho digitado, neste caso, o caminho para a pasta GitHub criado pela instalação do aplicativo GitHub Desktop.

1.  Na linha de comando, digite o comando abaixo e pressione enter:  
    gem install jekyll bundler
    

Não esqueça de esperar até que o prompt de comando apareça novamente para passar para o próximo passo.

1.  A URL pública do seu site assumirá o formulário http://amandavisconti.github.io/JekyllDemo/, sendo amandavisconti o nome de usuário gitHub do autor e JekyllDemo o nome do site que inseri nesta etapa (uma opção para comprar e usar sua própria URL [personalizada](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section7-2) é possível, mas não está coberta nesta lição). Nomes de sites minúsculos e maiúsculos não apontam para o mesmo site automaticamente,então, ao contrário do meu exemplo jekyllDemo, você pode querer escolher um nome maiúsculo para garantir que as pessoas que ouvem sobre o site tendem a digitar sua URL corretamente.  
    Na linha de comando, digite o seguinte (mas substitua o JekyllDemo pelo que você quiser que seu site seja chamado):  
    jekyll new JekyllDemo  
    Este comando disse a Jekyll para criar um novo site instalando todos os arquivos necessários em uma pasta chamada JekyllDemo. A pasta criada nesta etapa (por exemplo, JekyllDemo) será referida como a "pasta do site" para o resto deste tutorial.
    
2.  Na linha de comando, digite o comando abaixo para navegar na pasta do seu site (através do resto desta lição, sempre substitua o JekyllDemo por qualquer nome que você escolheu para o seu site na etapa anterior):  
    cd JekyllDemo  
    Se você olhar na pasta GitHub > JekyllDemo no Finder, verá que um monte de novos arquivos foram instalados. Os arquivos que executarão seu site! Descreveremos [mais adiante na lição](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section4-2) o que cada um faz:
    

![In Finder, we can see that bunch of new files—the files that will run your website!—have been installed](https://lh3.googleusercontent.com/XVDJLiyP_k01EsfyoEDZdtX6Trga-8Co0ce3MfeGdQ_uTXNGEsfzSiX5wuSIEtATmGIYnbKDPXGHBSqXexolSNJED5kp1HAjU4t3-peHSHd6FwGCbDQ9r1zMkKkQDcVjCyVN1wtH)
##### No Finder, podemos ver que um monte de novos arquivos — os arquivos que executarão seu site!— foram instalados

O comando  _cd_  (**change**  **directory**) diz ao seu computador para olhar o lugar no sistema de pastas do computador especificado pelo caminho digitado após ele — neste caso, o caminho para a pasta GitHub criado pela instalação do aplicativo GitHub Desktop.

1.  Na linha de comando, digite o seguinte e pressione enter:
    
    `gem install jekyll bundler`
    

Não se esqueça de esperar até que o prompt de comando apareça novamente para passar para o próximo passo.

1.  A URL pública do seu site assumirá o formulário http://amandavisconti.github.io/JekyllDemo/, sendo  _amandavisconti_  o nome de usuário gitHub do autor e  _JekyllDemo_  o nome do site que inseri nesta etapa (_uma opção para comprar e usar sua própria  [URL personalizada](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section7-2)  é possível, mas não está coberta nesta lição_).  **Nomes de sites minúsculos e maiústos  _não_  apontam para o mesmo site automaticamente**, então, ao contrário do meu exemplo  _jekyllDemo_, você pode querer escolher um nome maiústo para garantir que as pessoas que ouvem sobre o site tendem a digitar sua URL corretamente.
    
    Na linha de comando, digite o seguinte (mas substitua  _o JekyllDemo_  pelo que você quiser que seu site seja chamado):
    
    `jekyll new JekyllDemo`
    
    Este comando disse  _a Jekyll_  para criar um  _novo_  site instalando todos os arquivos necessários em uma pasta chamada  _JekyllDemo_.  **A pasta criada nesta etapa (por exemplo,  _JekyllDemo_) será referida como a "pasta do site" para o resto deste tutorial.**
    
2.  Na linha de comando, digite o seguinte para navegar na pasta do seu site (através do resto desta lição, sempre substitua  _o JekyllDemo_  por qualquer nome que você escolheu para o seu site na etapa anterior):
    
    `cd JekyllDemo`
    
    Se você olhar na pasta  _GitHub > JekyllDemo_  no Finder, você verá que um monte de novos arquivos — os arquivos que executarão seu site!— foram instalados (descreveremos o que cada um faz  [mais adiante na lição](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section4-2)):
    

![No Finder, podemos ver que um monte de novos arquivos — os arquivos que executarão seu site!— foram instalados](https://programminghistorian.org/images/building-static-sites-with-jekyll-github-pages/building-static-sites-with-jekyll-github-pages-9.png)

##### No Finder, podemos ver que um monte de novos arquivos — os arquivos que executarão seu site!— foram instalados


## [Executando um site localmente](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#running-a-website-locally-)

Esta seção ensinará como executar o seu site  localmente, o que significa que você poderá ver como o seu site será em um navegador da Web apenas no seu computador (também conhecido como localmente), mas não em qualquer outro lugar. Trabalhar em uma versão "local" de um site significa que ele é privado para o seu computador; ninguém mais pode ver seu site ainda (seu site não é "ao vivo" ou "público": ninguém pode digitar a URL e vê-la em seu navegador).

Isso significa que você pode experimentar o quanto quiser, basta publicar seu site para o mundo ver quando ele estiver pronto. Ou, uma vez que você tenha feito seu site ao vivo, você pode continuar a experimentar localmente com novas escritas, design, etc. e só adicioná-los ao site público uma vez que você estiver feliz com a aparência deles no site local.

1- Na linha de comando, digite:

`bundle exec jekyll serve --watch`
    Este é o comando que você executará sempre que quiser ver seu site localmente:

_jekyll serve_ diz ao seu computador para executar Jekyll localmente.

_–assista_ junto com _o executivo do pacote_ diz à Jekyll para observar as alterações nos arquivos do site, como escrever e salvar uma nova postagem ou página do blog, e incluir essas alterações na atualização do seu navegador. **Uma exceção a isso** é o arquivo _config.yml, que discutirei com mais detalhes na próxima seção (quaisquer alterações feitas não _aparecerão_ até que você pare e reinicie Jekyll).
    
2.  Depois de digitar no comando na etapa anterior, você notará que o processo nunca termina. Lembra como na linha de comando, se você digitar alguma coisa enquanto o comando anterior ainda está sendo processado, você pode causar problemas? Jek
yll agora está sendo executado a partir desta janela de linha de comando, então você precisará abrir uma nova janela de linha de comando se quiser digitar outros comandos enquanto o site local ainda estiver acessível a você (veja [a seção no uso da linha de comando acima.](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section1-4))
    

![The command line after entering the command to start serving your Jekyll website](https://lh5.googleusercontent.com/1A8srnP6DBAvNZlx-eMk4WUwBdutp2eb2ETeQDSylUSez0z3DAfPGm6QLvgnqQ4i6eHzIwNj5hI3Q0nWDIk34dCRtbdo5ZMfkY41ReHep1v7FL9LGC92L29QZLykCQXd3rdKhm8E)

A linha de comando depois de entrar no comando para começar a servir o seu site Jekyll

Relatórios e mensagens de erro causadas por alterações que você faz nos arquivos da pasta do site aparecerão nesta janela da linha de comando, e são ótimos lugares para verificar se algo não está funcionando.

1.  Para parar de executar o site localmente, pressione  **control-c**  (isso libera a janela da linha de comando para uso novamente). Basta entrar novamente para começar a executar o site localmente novamente.`bundle exec jekyll serve --watch`
    
2.  Veja seu site local visitando  **o localhost:4000**. Você verá um site básico da Jekyll com texto de caldeira:
    

![A basic Jekyll website with boilerplate text](https://lh6.googleusercontent.com/Hcka5LkCD3Qr76w19jg-daqynieMgdgvvTV4Zxps0BwOI5DDFYNTUNIkts8FZfoSch1qDrXXI6ZSTdjg98SbKeI_TSEvZxFfrwcO7xdXv8kAqxbGRbbFBlBjXHYRJ7j02SJINqLe)
 ###### Um site básico da Jekyll com texto de caldeira

### [Mini planilha de trapaça](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#mini-cheatsheet-)

-   Digite na linha de comando para começar a executar seu site localmente. Você visitaria  **o localhost:4000**  em um navegador para ver o seu site local agora, mas na próxima seção estaremos mudando as coisas de tal forma que você precisará visitar  **localhost:4000/JekyllDemo/**  para ver o site a partir de então (preenchendo o nome da pasta do seu site para  _JekyllDemo_, e certificando-se de incluir a última barra).`bundle exec jekyll serve --watch`
    
-   Aperte  **o control-c**  na linha de comando para parar de rodar o site localmente.
    
-   Enquanto o site estiver sendo executado, depois de fazer alterações nos arquivos do site: salve os arquivos e atualize a página da Web para ver as alterações —  **exceto o arquivo _config.yml**, para o qual você deve parar de executar o site e reiniciar a execução do site para ver alterações.
    
-   Digitando ou colando em muita coisa? Em vez disso, você pode digitar o ↑ (seta para cima) na linha de comando para rolar através de comandos digitado recentemente; basta pressionar enter após o comando que você deseja usar aparece.`bundle exec jekyll serve --watch`
    

## [Ajustando as configurações](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#tweaking-the-settings-)

Agora você tem um site básico e privado acessível apenas no seu computador. Nesta seção, começaremos a personalizar seu site alterando o título do site e as informações do autor, e dando uma breve visão geral do que os diferentes arquivos do site fazem.

### [Configurações básicas do site via_config.yml](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#basic-site-settings-via-_configyml-)

1.  Navegue até a pasta do seu site no Finder (Macs) ou na pasta diretório (Windows. O site do autor em  _/Users/DrJekyll/GitHub/JekyllDemo_  (_DrJekyll_  é meu nome de usuário conectado, e  _JekyllDemo_  é o nome da minha pasta de site).  [Retorne à seção "Configuração jekyll"](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section3)  se precisar de ajuda para localizar a pasta do seu site.

Você notará que, ao gerar e executar seu site na seção anterior, adicionou uma nova pasta "site". É aqui que a Jekyll coloca os arquivos HTML que ele gera a partir dos outros arquivos da pasta do seu site. A Jekyll funciona pegando vários arquivos, como configurações de configuração do seu site (_config.yml) e arquivos que apenas contêm conteúdo de postagem ou página sem outras informações de página da Web (por exemplo, about.md), juntando tudo isso e cuspindo páginas HTML que um navegador da Web é capaz de ler e exibir para os visitantes do site.

![Locating the website folder on the author's computer](https://lh6.googleusercontent.com/TOy8UgWJO9HooNlZlVtdpX47MT-u-zp9SsAhrAC5Qw_VCjI1avoFMuCgbkBP0r4C_CkGO36CUxtmyyxcPVhV4IZmJFTZV_YDS2S97K1vUA-BOxFZmZLsQijVt4HtBS4gq3NhSF2V)
##### Localização da pasta do site no computador do autor

1.  Começaremos personalizando o arquivo de configurações principais, _config.yml. Você vai querer abrir este e quaisquer arquivos futuros do site usando seu editor de texto (por exemplo, TextWrangler em Macs ou Notepad++ no Windows).
    

![Opening the text editor program TextWrangler on the author's Mac](https://lh5.googleusercontent.com/Wgbw91PesVLUQj45zzH3ohkyWIJcby7nTYGiceVGro5vphyQuVczD-uigpjp-bAGmHMqTw38PSeAq4MiRM8ZeQl6oGRxyjdkEt1GqlFsCj5CiGNVsOQKcqoF30sT90oNMUXxWBHw)
##### Abrindo o programa de editor de texto TextWrangler no Mac do autor

![The new _config.yml file](https://lh4.googleusercontent.com/YaSKsucl3J_A1FbXH6zXYNi6Z57FxQIR1RvQE1pC2OBHm6_GXG9jJOfjodK0QMbXIifqSt31TUFvzpizPg-t8vjtzSUozwrUEJADcLuU_jjzK7Gm2LMzmbHmlMRqQqD9DWEsw6fU)
##### O novo arquivo_config.yml

O arquivo _config.yml é "destinado a configurações que afetam todo o seu blog. Espera-se que você digite os valores, configure uma vez e raramente precise editar depois disso (como diz dentro do arquivo!). _config.yml é o lugar onde você pode definir o título do seu site, compartilhar informações como seu endereço de e-mail que você deseja associar ao site ou adicionar outras informações do tipo "configurações básicas" que você deseja disponível em seu site.

O tipo de arquivo .yml refere-se à forma como o arquivo é escrito usando [YAML](https://en.wikipedia.org/wiki/YAML) (o acrônimo de "YAML Ain't Markup Language"). YAML é uma maneira de escrever dados que é fácil para os seres humanos escrever e ler e fácil para as máquinas interpretarem. Você não precisará aprender muito sobre o YAML, além de manter o _config.yml formatado da maneira como originalmente é, mesmo quando você personaliza o texto que ele contém, por exemplo, as informações do título estão em uma linha separada do seu e-mail.

1.  Você pode alterar o texto neste arquivo, salvar o arquivo e, em seguida, visitar o site local em um navegador para ver as alterações. Observe que as alterações em _config.yml, ao contrário do resto dos arquivos do seu site, não aparecerão se forem feitas enquanto o site já estiver em execução. Você precisa fazê-los enquanto o site não estiver sendo executado, ou depois de fazer alterações em _config.yml stop, em seguida, começar a executar o site, para ver as alterações feitas neste arquivo em particular. (Alterações no arquivo _config.yml foram deixadas de fora da capacidade de atualização porque este arquivo pode ser usado para declarar coisas como a estrutura de links do site, e alterá-los enquanto o site está em execução pode quebrar mal as coisas.)  
 
Fazer pequenas alterações nos arquivos do site (uma de cada vez para começar), salvar e, em seguida, atualizar para ver o efeito em seu site significa que se você estragar alguma coisa, ficará claro o que causou o problema e como desfazê-lo.

-   Observe que qualquer linha que comece com um sinal  **#**  é um  _comentário_: os comentários não são lidos como código e, em vez disso, servem como uma maneira de deixar notas sobre como fazer algo ou por que você fez uma alteração no código.
    
-   Comentários sempre podem ser excluídos sem efeito em seu site (por exemplo, você pode excluir as linhas comentadas 1-6 em  __config.yml_  se você não quiser sempre ver essas informações sobre o uso de Jekyll).
    

2.  Edite o arquivo _config.yml de acordo com as instruções abaixo:
    
-   **título**: O título do seu site, como você quer que ele apareça no cabeçalho da página web.
-   **e-mail**: Seu endereço de e-mail.
-   **descrição**: Uma descrição do seu site que será usada nos resultados do mecanismo de busca e no feed RSS do site.
-   **basileia**: Preencha as aspas com uma barra para a frente seguida pelo nome da pasta do seu site (por exemplo, "/JekyllDemo") para ajudar a localizar o site na URL correta.
-   **url**: Substitua "http://yourdomain.com" por "localhost:4000" para ajudar a localizar sua versão local do site na URL correta.
-   **twitter_username**: Seu nome de usuário do Twitter (não inclua @symbol).
-   **github_username**: Seu nome de usuário gitHub.

As alterações feitas nas linhas  _de baseurl_  e  _url_  permitirão que seu site seja executado a partir dos mesmos arquivos localmente no seu computador e ao vivo na Web, mas  **fazer isso mudou a URL onde você verá o seu site local a partir de agora**  (enquanto  [Jekyll está funcionando](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section3-1)) de localhost:4000 para  **localhost:4000/JekyllDemo/**  (substituir o nome da pasta do seu site para  _JekyllDemo_  e lembrar a última marca de barra).

Na captura de tela abaixo, excluí as linhas iniciais comentadas 1-9 e 12-15, bem como o texto comentado informando o que "descrição" faz (não é necessário, apenas para mostrar que você pode excluir comentários que você não se importa em ver!) e personalizou o resto do arquivo como instruído acima:
    

![The author's customized _config.yml file](https://lh4.googleusercontent.com/Ri6aYzX6xzdXR-YBi88l_DAq1burpTjGZLr9tcYY-XVhjMByu_n8cJUFMfV2FNeHc_zOpvNdfPDacWSQyNXjkmcBMUaeEEArqGkSa5Gr2NgB48ujIRr6S3ewNYZ_Yqd53dfK_Lz3)
#### O arquivo personalizado _config.yml do autor

1. Salve o arquivo e inicie (ou pare e reinicie se estiver sendo executado) no site e visite **localhost:4000/JekyllDemo/** (substituindo o nome da pasta do seu site por _JekyllDemo_ e lembrando a última marca de corte) para ver seu site local personalizado
    

![The author's customized local website](https://lh6.googleusercontent.com/YL2B7vnh4tBHlCm44x9EWqqRQFcC2Viq7thl-CQilvLkqIZA_Gd-m5koeJ8kLJB7N1gK9OvGkBlmqjYJp8Q28Xs25t7JlOLgwXYeZYH0PFdTzkBkLcPYNNHDF1ZdCFDtlIdmbBs5)
##### O site local personalizado do autor

### [Onde (e o quê) está tudo?](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#where-and-what-is-everything-)

Para ter uma noção de como seu site funciona e quais arquivos você experimentaria para fazer coisas mais avançadas, aqui estão algumas dicas sobre o que cada pasta ou arquivo em sua pasta de site atual faz. Lembre-se de sempre abrir e editar qualquer arquivo com um editor de texto (por exemplo, TextWrangler) e não um processador de texto (por exemplo, não o Microsoft Word ou qualquer coisa que permite adicionar formatação como itálico e negrito). Isso impede que personagens de formatação invisíveis sejam salvos no arquivo bagunçando o site. Se você só quiser começar a adicionar conteúdo ao seu site e torná-lo público, você pode [pular para a próxima seção](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section5).

![A Finder window showing the default files and folders in a Jekyll website folder](https://lh6.googleusercontent.com/SCi5Xkn2xwOGtGbu83BQsfTTKxjmCxf-dy4xpAEXn98Pk06Jf_ubaA7Bw3WaSi6JyMo-KLzkq4GpFbjjbEkw0GvjhN3T8GfC3wp2rpQaXhzsvsRPQdNxVxl-HnXoq8gBHqvhjSj_)
##### Uma janela Finder mostrando os arquivos e pastas padrão em uma pasta do site da Jekyll

-   _config.yml é discutido [acima;](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section4-1) ele fornece informações básicas sobre o seu site, como o título do site e possibilidades adicionais que não cobrimos aqui, como estruturar links para postagens, por exemplo, eles devem seguir o padrão. MySite.com/year/month/day/post-title?.
    
-   _includes esta pasta tem arquivos que são incluídos em todas ou certas páginas, por exemplo, código para fazer o cabeçalho conter o título do site e o menu principal em cada página do site.
    
-   _layouts esta pasta contém código que controla a aparência das páginas do seu site (padrão.html), bem como personalizações desse código para mais postagens de estilo (post.html) e páginas (página.html)
    
-   _posts a pasta que detém os arquivos individuais que cada um representa um post de blog em seu site. A adição de um novo post a esta pasta fará com que um novo post no blog apareça em seu site, em ordem cronológica inversa (post mais novo ao mais antigo). Vamos cobrir a adição de posts de blog na [próxima seção.](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section5-2)
    
-   _sass esta pasta possui arquivos SCSS que controlam o design visual do site
    
-   _site nesta pasta as páginas HTML que aparecem na web são geradas e armazenadas (por exemplo, você escreverá e salvará postagens como arquivos Markdown, mas Jekyll irá convertê-las em HTML para exibição em um navegador da Web)
    
-   index.md é um lugar para adicionar conteúdo que você quer que apareça em sua página inicial, como uma sinopse de biografia para aparecer acima da lista "Posts"
    
-   about.md é um exemplo de uma página de Jekyll. Ele já está ligado no cabeçalho do seu site, e você pode personalizar seu texto abrindo e escrevendo nesse arquivo. Vamos cobrir a adição de mais páginas do site na [próxima seção](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section5-3).
    
-   pasta css mantém CSS convertido do SCSS que controla o design visual do site
    
-   feed.xml permite que as pessoas sigam o feed RSS de suas postagens no blog
    
-   índice.html controla a estruturação de conteúdo na página inicial do seu site
    

## [Escrevendo páginas e postagens](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#writing-pages-and-posts-)

Esta seção mostrará como criar páginas e posts em seu site.

**Páginas** e **postagens** são apenas dois tipos de conteúdo escrito que é estilizado de forma diferente. Páginas são conteúdos (como uma página "Sobre") que não é organizado ou exibido cronologicamente, mas pode ser incluído no menu principal do seu site. As postagens devem ser usadas para organizar melhor o conteúdo até a data de publicação. As URLs (links) para páginas e postagens também são diferentes por padrão (embora você possa alterar isso): urls de página se parecem MySite.com/about/, enquanto urls de postagem parecem MySite.com/2016/02/29/my-post-title.html.

#### [Autoria em Markdown](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#authoring-in-markdown-)

Markdown é uma maneira de formatar sua escrita para leitura na web: é um conjunto de símbolos fáceis de lembrar que mostram onde a formatação de texto deve ser adicionada (por exemplo, um # na frente do texto significa formatá-lo como um título, enquanto um * na frente do texto significa formatá-lo como um item de lista com bala). Para Jekyll em particular, Markdown significa que você pode escrever páginas da web e postagens de blog de uma maneira que seja confortável para os autores (por exemplo, não há necessidade de olhar para cima/adicionar em tags HTML enquanto tenta escrever um ensaio), mas ter essa escrita aparecer bem formatada na web, ou seja, um conversor de texto para HTML.

Não vamos cobrir Markdown nesta lição. Se você não estiver familiarizado com ele, por enquanto você pode simplesmente criar postagens e páginas sem formatação, ou seja, sem negrito/itálico, sem cabeçalhos, sem listas com balas. Mas estes são fáceis de aprender a acrescentar: há uma [referência](http://kramdown.gettalong.org/quickref.html) útil de marcação, bem como [uma aula de Historiador de Programação por Sarah Simpkin sobre como e por que escrever com Markdown](https://programminghistorian.org/lessons/getting-started-with-markdown). Confira esses links se você quiser formatar texto (itálico, negrito, títulos, listas de bala/numeração) ou adicionar hiperlinks ou imagens incorporadas e outros arquivos.

Certifique-se de que todas as planilhas de trapaça do Markdown que você olhar são para o formato "[kramdown](http://kramdown.gettalong.org/quickref.html)" do Markdown, que é o que o GitHub Pages (onde estaremos hospedando nosso site) suporta. (  [Existem vários "formatos" de Markdown](https://github.com/jgm/CommonMark/wiki/Markdown-Flavors) que têm diferenças sutis no que vários símbolos fazem, mas na maioria das vezes símbolos usados com frequência como aqueles que criam formatação de títulos são os mesmos, então você provavelmente está bem usando uma planilha de trapaça que não especifica que é [kramdown,](http://kramdown.gettalong.org/quickref.html) mas se você está recebendo erros em seu site usando símbolos que não estão incluídos em [kramdown](http://kramdown.gettalong.org/quickref.html) pode ser o motivo).

Você pode estar interessado em softwares de "editor de marcação", como [Typora](https://www.typora.io/) (OS X e Windows; gratuito durante o período beta atual), que permitirá que você use atalhos populares de teclado para escrever Markdown (por exemplo, destacar texto e pressionar comando-B para torná-lo ousado) e/ou digitar em Markdown, mas tem que mostrar como ele vai olhar na web (ver títulos estilizados como títulos, em vez de como texto normal com um # na frente deles).

### [Páginas autorais](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#authoring-pages-)

1.  Para ver uma página existente em seu site, criada como parte padrão de um site da Jekyll, [quando você criou o resto dos arquivos do seu site),](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section3)navegue até a pasta do seu site e abra o arquivo about.md em um editor de texto (por exemplo, TextWrangler) ou em um editor de Markdown (por exemplo, Typora) para ver o arquivo que cria a página "Sobre". Clique também no link "Sobre" no canto superior direito da sua página web para ver como é a página da Web que o arquivo cria em um navegador.
    
2.  O material entre os traços é chamado de "matéria frontal" (observe que ao abrir o arquivo em um editor de Markdown, você pode fazer a matéria frontal aparecer em um fundo cinza em vez de entre traços). A matéria frontal informa ao seu site se deve formatar o conteúdo abaixo da matéria frontal como uma página ou postagem do blog, o título do post, a data e a hora que o post deve mostrar que foi publicado e qualquer categoria que você gostaria do post ou página listadas abaixo.  
      
   
1.  Você pode mudar as coisas na questão frontal de uma página:
    
    -   **layout:**  Mantenha isso como está (deve dizer página).
    -   **título:**  Altere isso para o título da página desejado (ao contrário das postagens, sem aspas em torno do título). Na captura de tela abaixo, adicionei uma página com o título "Retomar".
    -   **permalink:**  altere o texto entre as duas marcas de corte para a palavra (_ou frase — mas você precisará usar hífens e não espaços!_) que você deseja seguir a URL principal do seu site para chegar à página. Por exemplo,  **permalink: /about/**  locates a page at  **localhost:4000/yourwebsitefoldername/about/**
2.  O espaço abaixo do segundo da matéria frontal — traços (ou abaixo da caixa cinza da matéria frontal, se usar um editor do Markdown) é onde você escreve o conteúdo de sua página, usando  [a formatação Markdown descrita acima](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section5-1).
    
3.  Para criar uma nova página, além da página "Sobre" que já existe no site (e pode ser personalizada ou excluída), crie uma cópia do  _arquivo about.md_  na mesma pasta (a pasta principal do site) e altere seu nome de arquivo para o título desejado, usando hifenes em vez de espaços (por exemplo_, resume.md_  ou  _contact-me.md_). Altere também o título e o permalink na matéria frontal do arquivo e no conteúdo do arquivo. A nova página deve aparecer automaticamente no menu principal do cabeçalho do site:

![After adding a new page file to the website folder, the new page appears in the website's header menu](https://lh4.googleusercontent.com/rXlLqWIx-veFyQgDiB3pXnK3SLjBap491TvvPx2XmOm6ig_mMwSeTUzvYBhDvkhFiXIL8TfRoWDK8wcLfMkAlZi5_K0425bViFcw7SDHrxxUs7o54k3B29Rl3ceVOYHwprUSYFPb)
##### Depois de adicionar um novo arquivo de página à pasta do site, a nova página aparece no menu de cabeçalho do site

Para referência, você pode conferir [um exemplo de uma página](https://amandavisconti.github.io/JekyllDemo/resume/) no meu site de demonstração ou ver o arquivo que está por trás desta [página.](https://raw.githubusercontent.com/amandavisconti/JekyllDemo/gh-pages/resume.md)

### [Posts de autoria](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#authoring-posts-)

1.  No Finder, navegue até a pasta do seu site (por exemplo, _JekyllDemo_) e a pasta __posts_ dentro dela. Abra o arquivo dentro dele com um editor de texto (por exemplo, TextWrangler) ou um editor de Markdown (por exemplo, Typora). O arquivo será nomeado algo como _2016-02-28-welcome-to-jekyll.markdown_ (a data será igual quando você criou o site Jekyll).a opção Finder, navegue até a pasta do seu site, por exemplo, JekyllDemo, e a pasta _posts dentro dele. Abra o arquivo dentro dele com um editor de texto (por exemplo, TextWrangler) ou um editor de Markdown (por exemplo, Typora). O arquivo será nomeado algo como 2016-02-28-welcome-to-jekyll.markdown (a data será igual quando você criou o site Jekyll).
    

![An example Jekyll website blog post file opened in a text editor](https://lh4.googleusercontent.com/h_OH8EEMvOuut6dm4Rj7fNJUgdNRx4qHYtZIDzIP91IKXPdm9_TXorQygEKwoATGEr-o2CZWxyypydDFDdn66HhOw6LJoW6Lhx7ZnF4SYfq1ODfB-JLcrTUjuT-8278akrAsyXOw)
##### Um exemplo jekyll site post arquivo aberto em um editor de texto

Como nas páginas das postagens, o material entre as linhas é chamado de "matéria frontal" (observe que ao abrir o arquivo em um editor de Markdown você pode fazer com que a matéria frontal apareça em um fundo cinza em vez de entre traços). A matéria frontal informa ao seu site se deverá ou não formatar o conteúdo abaixo da matéria frontal como uma página ou postagem do blog, o título do post, a data e a hora que o post deve mostrar que foi publicado e quaisquer categorias que você gostaria do post ou página listadas abaixo.

1.  Vamos escrever um segundo post para que você possa ver como várias postagens ficam no seu site. Feche o arquivo 20xx-xx-welcome-to-jekyll.markdown que estava aberto, em seguida, clique com o botão direito do mouse no finder e escolha "Duplicar". Um segundo arquivo chamado 20xx-xx--welcome-to-jekyll copy.markdown aparecerá na pasta _sites.
    
2.  Clique uma vez no nome do arquivo 20xx-xx-welcome-to-jekyll copy.markdown para que você possa editar o nome do arquivo, em seguida, alterá-lo para mostrar a data de hoje e conter um título diferente, como 2016-02-29-a-post-about-my-research.markdown (use hífens entre as palavras, não espaços).
    
3.  Agora abra seu arquivo renomeado em seu texto ou editor de marcação e personalize o seguinte:
    
    -   **layout:**  Mantenha isso como está (deve dizer  _post_).
    -   **título:**  Mude "Bem-vindo a Jekyll!" para qualquer título que você gostaria para o seu novo post (mantendo as aspas em torno do título). É a norma fazer o título o mesmo que as palavras no nome do arquivo (exceto com espaços adicionados e capitalização). É assim que o título aparecerá na página do post).
    -   **data:**  Altere isso para quando você quiser que o post seja exibido como sua data e hora de publicação, certificando-se de corresponder à data que faz parte do nome do arquivo. (A data  _e_  a hora já deveriam ter ocorrido, para que seu post aparecesse.)
    -   **Categorias:**  Exclua as palavras "jekyll update" por enquanto e não adicione mais nada aqui — o tema atual não usa essas e elas bagunçam os URLs postais. (_Outros temas podem usar este campo para classificar posts de blog por categorias_.)
    -   **O espaço abaixo do segundo -- (ou abaixo da caixa cinza, se usar um editor de Markdown):**  É aqui que você escreve seu post no blog, usando  [a formatação Markdown descrita acima](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section5-1).
    
    Depois de salvar, agora você deve ser capaz de ver sua segunda publicação na primeira página do seu site, e clicar no link deve levá-lo para a página do post:

![The author's website, where the recently added blog post now appears on the front page](https://lh6.googleusercontent.com/xVPOG7Fx34hNGDnafhyHbv_iJ5gXdlwz7Wl5k6uPEONiYCxDyp3TauTyzUXaB8GiJh6OOb1-RhUAxf77ERvtEgNTLhk0CeZovL6c52ySSm-4apODDQ6IMbTdqLWK-KoYawWbpuqz)
##### O site do autor, onde o post de blog recentemente adicionado agora aparece na primeira página

![The webpage for the recently added blog post on the author's site](https://lh4.googleusercontent.com/26KJZo_IILRPR0mgaWVl9b01tPmnFxikBPS6vv8FWF7Cf4FH8XS6f_nXJgUOLea2xiVAHjOHyPc7iQBRB6FnWVhdUoxXNqguXyvcHYFaimDlyTWBnDOAfV6dtc-vvpr0dftL1im5)
##### A página da web para o post de blog recentemente adicionado no site do autor


Observe que  **a URL do post é a URL do**  site local (por exemplo_, localhost:4000/JekyllDemo/_) seguida pelo ano/mês/data de publicação, seguido pelo título escrito em seu nome de arquivo e terminando com .html (por exemplo_, localhost:4000/JekyllDemo/2016/02/29/a-post-about-my-research.html_). Jekyll está convertendo o arquivo Markdown que você escreveu na pasta _posts nesta página html.

**Excluindo um arquivo**  da pasta _posts remove-o do seu site (você pode tentar isso com o post de exemplo "Bem-vindo a Jekyll!!").

**Para criar mais postagens**, duplique um arquivo existente e lembre-se de alterar não apenas a matéria frontal e o conteúdo dentro do post conforme descrito acima, mas também o nome do arquivo (data e título) do novo arquivo.

Para referência, você pode conferir  [um exemplo de um post](https://amandavisconti.github.io/JekyllDemo/2016/11/12/a-post-about-my-research.html)  no meu site de demonstração, ou ver  [o código executando esse post](http://raw.githubusercontent.com/amandavisconti/JekyllDemo/gh-pages/_posts/2016-02-29-a-post-about-my-research.markdown).

## [Hospedagem nas páginas do GitHub](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#hosting-on-github-pages-)

 Agora você sabe como adicionar páginas de texto e postagens ao seu site. Nesta seção vamos mover seu site local ao vivo para que outros possam visitá-lo na Web. Neste ponto, estamos tornando uma versão do seu site publicamente visualizada (por exemplo, para os mecanismos de busca e para quem sabe ou acontece no link).

[No início da aula,](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section1-2) você instalou o aplicativo GitHub Desktop. Agora usaremos este aplicativo para mover facilmente seus arquivos do site para um lugar que servirá aos visitantes como páginas da web (Páginas do GitHub), onde o público pode visitá-los online. Desta primeira vez, vamos mover todos os arquivos do seu site para a Web, já que nenhum deles ainda está lá; no futuro, você usará este aplicativo sempre que ajustar os arquivos do site (conteúdo ou arquivos adicionados, editados ou excluídos) em sua versão local do site e está pronto para que as mesmas alterações apareçam no site público (há [uma planilha de trapaça no final desta seção](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section6-1) para isso).

1.  Abra o aplicativo GitHub Desktop. Clique no ícone + no canto superior esquerdo e clique na opção "Adicionar" ao longo da parte superior da caixa que aparece (se "Adicionar" ainda não estiver selecionado).
    
2.  Clique no "Escolha..." botão e escolha a pasta (JekyllDemo no meu exemplo) contendo seus arquivos do site (se em um Mac e incapaz de localizar esta pasta, sua pasta biblioteca pode estar oculta; [use essas direções](https://www.macobserver.com/tmo/article/mavericks-easily-make-user-library-folder-visible) para torná-lo visível para que o aplicativo GitHub Desktop possa olhar navegar dentro dele).
    
3.  Em seguida, clique no botão "Criar e Adicionar repositório" (Mac) ou no botão "Criar repositório" (Windows). Agora você verá uma lista dos arquivos para os quais você fez alterações (adições ou exclusões para e de arquivos) desde a última vez que você copiou o código do seu site do seu computador para o GitHub (neste caso, nós nunca copiamos o código para o GitHub antes, então todos os arquivos estão listados aqui como novos).
    
4.  No primeiro campo, digite uma breve descrição das alterações que você fez desde a última vez que mudou seu trabalho no site para o GitHub (o espaço é limitado). Neste primeiro caso, algo ao longo das linhas de "Meu primeiro compromisso!" é bom; no futuro, você pode querer ser mais descritivo para ajudá-lo a localizar quando fez uma determinada alteração — por exemplo, escrever "Adicionada nova página 'Fale comigo'".  
    Você poderá usar a área de texto maior, como a imagem abaixo, para escrever uma mensagem mais longa, se necessário (é opcional).
    

![Screenshot of the author's Jekyll website repository open in the GitHub app. On the left, we see our Jekyll website folder selected; in the middle, we see a list of files we've changed since the last time we changed the live website; and at the bottom we see fields for a short description of the changes you've made and for a longer description (if necessary)](https://lh3.googleusercontent.com/qwtlBgGPXbyZA_Uc-4iJ5duOjy2X3N9KuZjjEYcvWxKQBJVXgXvVetwqB2c1zcOVdJd2s8jkPr5apCfkDNlgMYCVLRd7as5UiNBhzbMUXvKcw-2H9DGAMNAyclWCTHztY800Sjcx)
##### Captura de tela do repositório do site jekyll do autor aberto no aplicativo GitHub. À esquerda, vemos nossa pasta do site jekyll selecionada; no meio, vemos uma lista de arquivos que mudamos desde a última vez que mudamos o site ao vivo; e na parte inferior vemos campos para uma breve descrição das mudanças que você fez e para uma descrição mais longa (se necessário)

1.  Na parte superior da janela do aplicativo, clique no terceiro ícone da esquerda (ele dirá "Adicionar um ramo" se você passar o mouse sobre ele). Digite gh-pages no campo "Nome" e clique no botão "Criar filial".
    

![Type gh-pages in the 'Name' field, then click the 'Create branch' button](https://lh5.googleusercontent.com/6j1OhGwJHaKwdDHdxjLmC_CY0Mn_zkQ6GK9dAweuVcorebek8DAUSP3zGPkWxhD_YAWqqopIaPRpI152LiHC3_5IyYg1qmndLciNm-2_WMVEjtyfa0zYeKQ6ldsQm_ciQwlXDwMS)
##### Digite páginas gh no campo 'Nome' e clique no botão 'Criar filial'

1.  Click on the “Commit to gh-pages” button near the bottom-left of the app window.
    

![The 'Commit to gh-pages' button near the bottom-left of the app window](https://lh4.googleusercontent.com/6vG4pcTc4-ft5N0lPJGc7WJ6hgOQXMb9mirwNzS9fziqkzFHm2IkHbdW3AuvxcU1i6ppTiR3WxW7TLODHVHBImXHxnV3Jcx71vnzjwwGYPc4ZAOQ63RTVu-ASSxHsrbsSO4eIDpo)
##### O botão 'Comprometer-se com gh-pages' perto da parte inferior esquerda da janela do aplicativo

1.  Clique no botão "Publicar" no canto superior direito.![Click on the “Publish” button in the top-right](https://lh5.googleusercontent.com/9IYKfd02vmA3gOXrd5Zvs5FvvzN6KIw2mc63PyRSiOwj7612MiBvYK7S6O4u8-4PNrQAXM2oBJpaUksw7ANPvsBwnpOUTt4DL-x9YzuJhaayWJCfE9jnYU1GU9-aYTZ1-9CIrwzR)
    ##### Clique no botão "Publicar" no canto superior direito. 

1- No popup, deixe tudo como está e clique no botão "Publicar repositório" no inferior-direito (_sua janela pode não mostrar as opções relacionadas a repositórios privados mostrados na captura de tela_).
    

![In the popup, leave everything as-is and click the 'Publish repository' button in the lower-right](https://lh3.googleusercontent.com/mHVZSFoAAhIDn-Dhtyw7KOb0GC1qQIgmXT4ZewFytL18N7bxg57IBwiKgMnbF7auykoFoR2g6YWgTGscOPaGWYu2l6PQ7rLtGwuREL6Pu6ODwcweTzRu1xWIdDeHDtY5L2hOiS8H)
##### No popup, deixe tudo como está e clique no botão 'Publicar repositório' no lado inferior direito

1.  Clique no botão "Sincronizar" no canto superior direito.
    ![Click the 'Sync' button in the upper-right](https://lh6.googleusercontent.com/1laNVW0trCgb6_tniHj1Dz57KJ9OGH1xvWuJRuLYq2GQMDTl9q-W3rQYjL4FsaYONt9PFdUD2w0jgXqyehEKIg7-dSkdCA7fb--Q6yp2CAdP3GeHDgo0J0oqJJdgmWH4lKhezLJB)
##### Clique no botão 'Sincronizar' no canto superior direito

1. Agora você pode visitar (e compartilhar o link para!) seu site ao vivo. A URL seguirá o padrão do  _seu nome de usuário GitHub DOT github.io nome SLASH do seu site SLASH_. (Por exemplo, a URL do autor é  [amandavisconti.github.io/JekyllDemo/](http://amandavisconti.github.io/JekyllDemo/).)
    

### [Mini planilha de trapaça](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#mini-cheatsheet--1)

No futuro, quando você quiser mover mudanças que você fez localmente para o seu site ao vivo, basta seguir estes passos:

1.  Abra o aplicativo GitHub Desktop e digite uma breve descrição de suas alterações e opcionalmente uma descrição mais longa na segunda caixa de texto.
    
2.  Clique no botão "cometer" abaixo da caixa de texto.
    
3.  Uma vez terminado o compromisso, clique no botão "Sincronizar" no canto superior direito.
    
4.  Dê ao GitHub um pouco de tempo para receber essas alterações (cerca de 10-90 segundos) antes de atualizar seu site ao vivo para ver suas mudanças lá.
    

## [Ficando chique](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#getting-fancy-)

Esta lição não cobrirá trabalhos avançados como mudar a aparência visual do seu site ou adicionar novas funcionalidades, mas aqui estão algumas informações para você começar por conta própria.

### [Design visual](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#visual-design-)

O design visual de um site é frequentemente referido como seu tema (mais apropriadamente, um tema é um conjunto de arquivos de código e imagem que, juntos, fazem uma grande mudança na aparência de um site).

Você pode personalizar o tema atual do seu site fazendo alterações nos arquivos nas pastas _sass e css (infelizmente, a versão mais recente do movimento de Jekyll para usar o SASS em vez de CSS simples torna o aprendizado para personalizar as coisas um pouco mais difícil para os não-designers).

Ou, você pode adicionar (e personalizar ainda mais, se desejar) um tema já criado por outra pessoa, procurando por "temas jekyll" ou experimentando um desses recursos:

-   [O tema "Ed" de Alex Gil para edições digitais mínimas](https://elotroalex.github.io/ed/) e [sua documentação](https://elotroalex.github.io/ed/documentation) (gratuita)
    
-   [O tema "Digital Edition" de Rebecca Sutton Koeser](https://github.com/emory-libraries-ecds/digitaledition-jekylltheme) (grátis)
    
-   O diretório [Jekyll Themes](http://jekyllthemes.org/) (gratuito)
    
-   [JekyllThemes.io](http://jekyllthemes.io/) (grátis e paga)
    

### [Funcionalidade](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#functionality-)
-   [Os plugins jekyll](http://jekyllrb.com/docs/plugins/)  permitem adicionar pequenos bits de código que adicionam funcionalidade ao seu site, como  [pesquisa de texto completo](https://github.com/PascalW/jekyll_indextank),  [suporte a emojis](https://github.com/yihangho/emoji-for-jekyll)  e  [nuvens de tag](https://gist.github.com/ilkka/710577).
    
    -   Se você quiser hospedar seu site no GitHub Pages como fizemos nesta aula, você só pode usar os plugins Jekyll já incluídos na gema gitHub Pages que instalamos (aqui está  [uma lista completa do que você instalou](https://pages.github.com/versions/)  ao adicionar a gema GitHub Pages ao seu Gemfile anteriormente).
        
    -   Se você optar por hospedar seu site jekyll em outro lugar que as páginas do GitHub, você pode usar qualquer plugin Jekyll (instruções para auto-host variam de acordo com o host da Web e não serão cobertas aqui, mas  [esta](http://jekyllrb.com/docs/plugins/)  é uma página sobre como instalar plugins depois de configurar seu site jekyll auto-hospedado). Você pode procurar por "Plugin Jekyll" mais a funcionalidade que você precisa para ver se um está disponível ou verificar a seção "Plugins disponíveis" perto da parte inferior  [desta página](http://jekyllrb.com/docs/plugins/)  para obter uma lista de plugins.

-   Você pode manter a hospedagem gratuita do GitHub Page no seu site jekyll, mas dar ao site um **nome de domínio personalizado** (nomes de domínio são comprados por uma taxa anual razoável — geralmente em torno de US$ 10 — de um "registrador de nomes de domínio", como [NearlyFreeSpeech.net).](https://www.nearlyfreespeech.net/services/domains) Por exemplo, o blog LiteratureGeek.com do autor é construído com Jekyll e hospedado no GitHub Pages assim como o site que você construiu com esta lição, mas ele usa um nome de domínio personalizado que eu comprei e configurei para apontar para o meu site. Instruções sobre a configuração de um nome de domínio personalizado podem ser [encontradas aqui](https://help.github.com/articles/using-a-custom-domain-with-github-pages/).
    
-   Você pode **migrar um blog existente** de muitos outros sistemas, incluindo WordPress, Blogger, Drupal e Tumblr seguindo os links do lado direito [desta página](https://import.jekyllrb.com/docs/home/). Ao migrar um site, certifique-se de fazer backup do seu site original, no caso de um par tentar obter postagens vivendo na mesma URL de antes (para que os resultados do mecanismo de pesquisa e os marcadores não quebrem).
    

## [Planilha de trapaça](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#cheatsheet-)

**Para testar as coisas localmente** (novo plugin, tema, como um novo post no blog parece):

-   Inicie o site local: Digite na linha de comando bundle exec jekyll serve --watch
    
-   Visite o site local: Open localhost:4000/yourwebfoldername/ em um navegador web (por exemplo, localhost:4000/JekyllDemo/). Não esqueça da barra de trilha!
    
-   Veja as alterações no site local durante a criação do site. Enquanto o site estiver sendo executado, depois de fazer alterações nos arquivos do site, salve os arquivos e atualize a página da Web para ver as alterações,exceto o arquivo _config.yml, para o qual você deve parar de executar o site e reiniciar a execução do site para ver as alterações.
    
-   Pare o site local: Aperte o control-c na linha de comando.
    

**Para mover alterações locais para o seu site ao vivo**  (novo post, ajustes de configurações, etc.):

-   Faça as alterações desejadas nos arquivos locais do seu site.
    
-   Abra o aplicativo GitHub Desktop, certifique-se de que seu site seja escolhido na lista de repositórios da barra lateral esquerda e escreva seu resumo de mensagem de compromisso (e descrição, se desejar).
    
-   Clique em "Comprometer-se com gh-pages" no inferior esquerdo.
    
-   Após o compromisso ter sido concluído, clique em "Sincronizar" no canto superior direito.
    
-   Permita de 10 a 90 segundos que suas alterações cheguem aos servidores web do GitHub e visite seu site e atualize a página para ver suas alterações ao vivo.
    

## [Ajuda, créditos e mais leitura](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#help-credits--further-reading-)

### Ajuda

Se você encontrar um problema, [Jekyll tem uma página sobre solução de problemas](https://jekyllrb.com/docs/troubleshooting/) que pode ajudar. Se você estiver trabalhando na linha de comando e receber uma mensagem de erro, não esqueça de tentar procurar essa mensagem de erro específica on-line. Além dos mecanismos de busca, [o site StackExchange](https://stackexchange.com/) é um bom lugar para encontrar perguntas e respostas de pessoas que se deparam pelo mesmo problema que você no passado.

### [Créditos](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#credits-)

Graças ao Editor de Programação Do Historiador  Fred Gibbs por editar, discutir e revisar esta lição; Paige Morgan e Jaime Howe por revisarem esta lição; Scott Weingart e alunos para testar a lição com o Windows; Tod Robbins e Matthew Lincoln para sugestões sobre o [DH Slack](https://tinyurl.com/DHSlack) sobre o que cobrir nesta lição; e Roxanne Shirazi para soluções para possíveis problemas de permissão e navegação.

O Conselho Editorial gostaria de agradecer [spswanz](https://github.com/spswanz) por apontar para um bug na seção [Ruby & Ruby Gems.](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#section2-3)

### [Leitura suplementar](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#further-reading-)  
Confira os links a seguir para documentação, inspiração e leitura posterior sobre Jekyll:
-   [Documentação Oficial jekyll](http://jekyllrb.com/docs/home/)
-   Jekyll links "extraoficialmente" para dois recursos Windows + Jekyll:  [http://jekyll-windows.juthilo.com/](http://jekyll-windows.juthilo.com/)  e  [https://davidburela.wordpress.com/2015/11/28/easily-install-jekyll-on-windows-with-3-command-prompt-entries-and-chocolatey/](https://davidburela.wordpress.com/2015/11/28/easily-install-jekyll-on-windows-with-3-command-prompt-entries-and-chocolatey/)
-   [https://help.github.com/articles/using-jekyll-with-pages/](https://help.github.com/articles/using-jekyll-with-pages/)
-   Amanda Visconti,  ["Introduzindo sites estáticos para projetos de humanidades digitais (por que e quais são Jekyll, GitHub, etc.?)"](http://literaturegeek.com/2015/12/08/WhyJekyllGitHub)
-   Alex Gil,  ["Como (e por quê) gerar um site estático usando Jekyll, Parte 1"](http://chronicle.com/blogs/profhacker/jekyll1/60913)
-   Eduardo Bouças,  ["Uma Introdução aos Geradores de Sítio Estático"](https://davidwalsh.name/introduction-static-site-generators)
-   [Guia de Estilo Jekyll](http://ben.balter.com/jekyll-style-guide/)
-   O editor  [de conteúdo prosa](http://prose.io/)  (construído em Jekyll)
-   [Inscreva-se no Digital Humanities Slack](http://tinyurl.com/DHslack)  (qualquer pessoa pode participar, mesmo que você não tenha experiência em DH) e confira o canal #publishing para discussões da Jekyll e de outras plataformas de publicação da DH.   

## SOBRE O AUTOR

Amanda Visconti é diretora executiva do Centro de DH lab da University of Virginia Scholars.

## CITAÇÃO SUGERIDA

Amanda Visconti, "Construindo um site estático com páginas de Jekyll e GitHub", The Programming Historian 5 (2016), https://doi.org/10.46430/phen0048.

## [Doe hoje!](https://programminghistorian.org/en/lessons/building-static-sites-with-jekyll-github-pages#donate-today)

Ótimos tutoriais de Acesso Aberto custam dinheiro para produzir. Junte-se ao crescente número de pessoas que apoiam o Historiador da Programação para que possamos continuar [compartilhando](https://www.patreon.com/theprogramminghistorian) conhecimento gratuitamente.
