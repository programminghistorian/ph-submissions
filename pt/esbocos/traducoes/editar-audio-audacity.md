---
title: "Editar áudio com o Audacity"
slug: editar-audio-audacity
original: editing-audio-with-audacity
layout: lesson
collection: lessons
date: 2016-08-05
translation_date: 2023-MM-DD
authors:
- Brandon Walsh
reviewers:
- Joanna Swafford
editors:
- Jeri Wieringa
translator:
- Rodrigo César Costa Filgueira
translation-editor:
- A INDICAR
translation-reviewer:
- Salete Farias
- A INDICAR
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/574
difficulty: 2
activity: analyzing
topics: [network-analysis]
abstract: Nesta lição, vai aprender a usar o Audacity para carregar, gravar, editar, mixar e exportar ficheiros de áudio.
avatar_alt: Dois gramofones frente a frente
doi: XX.XXXXX/phen0000
---

{% include toc.html %}


## Objetivos do módulo
Para os interessados ​​em áudio, as habilidades básicas de edição de som são muito úteis. Ser capaz de manusear e manipular os materiais pode ajudá-lo a controlar o seu objeto de estudo: você pode ampliar e extrair momentos específicos para analisar, processar o áudio e enviar os materiais para um servidor para complementar uma postagem de blog sobre o assunto. Em um nível mais prático, essas habilidades também podem permitir que você grave e empacote gravações suas ou de outras pessoas para distribuição. Aquela palestra convidada acontecendo em seu departamento? Grave e edite você mesmo! Fazer isso é uma maneira leve de distribuir recursos entre várias instituições e também ajuda a tornar os materiais mais acessíveis para leitores e ouvintes com uma ampla variedade de necessidades de aprendizagem.

Nesta lição, você aprenderá como usar o [**Audacity**](http://audacityteam.org/) para carregar, gravar, editar, mixar e exportar ficheiros de áudio. As plataformas de edição de som costumam ser caras e oferecem recursos abrangentes que podem ser esmagadores para o usuário iniciante, mas o Audacity é uma alternativa gratuita e de código aberto que oferece recursos poderosos para edição de som com baixa barreira de entrada.

Para esta aula trabalharemos com dois ficheiros de áudio: uma gravação das [**Variações Goldberg de Bach**](/assets/editing-audio-with-audacity/bach-goldberg-variations.mp3) e outra gravação de sua própria voz que será feita no decorrer da aula.

Este tutorial usa o Audacity 2.1.2, lançado em janeiro de 2016.

## Trabalhando no Audacity
Primeiro, baixe os ficheiros necessários.

Você precisará do [**ficheiro mp3 das Variações Goldberg de Bach**](/assets/editing-audio-with-audacity/bach-goldberg-variations.mp3) . Para baixar, clique com o botão direito aqui e selecione 'Salvar link como' para baixar o ficheiro em seu computador como um MP3.

Em seguida, baixe e instale o Audacity, que está disponível no [**site do projeto**](http://audacityteam.org/). O Audacity pode ser usado em Mac OSX, Windows ou Linux.

Baixe o programa e clique duas vezes para instalar.

Para começar, abra a gravação de Bach que você acabou de baixar usando o menu ficheiro do Audacity.

A interface mudará para refletir os dados carregados:

{% include figure.html filename="editing-audio-with-audacity-1.png" alt="Imagem de onda Bach no Audaciry" caption="Forma de onda Bach no Audacity" %}
      

O Audacity converte o seu som em uma forma de onda, um modo normalmente usado para representar o som. O eixo x representa o tempo em segundos (ou minutos e segundos, dependendo da duração do clipe). O início do som ocorre na extrema esquerda da interface e o Audacity marca posições de tempo periódicas conforme a onda continua para a direita. Se clicarmos no botão play, o Audacity se moverá da esquerda para a direita sobre o som, com uma linha vertical representando o nosso ponto atual no clipe.

O eixo y representa a amplitude, o que experimentamos como sonoridade ou volume. Por padrão, o eixo y mede o volume em uma escala linear vertical de -1 a 1: os extremos -1 e 1 representam o som gravado mais alto possível sem distorção, enquanto 0 representa o silêncio. Assim, o silêncio começa como uma linha reta e o som se torna mais alto e profundo à medida que aumenta de intensidade. Para obter mais informações sobre por que alguns dos números são negativos, confira a breve [**tutorial de acústica**](http://web.archive.org/web/20161119231053/http://www.indiana.edu:80/~emusic/acoustics/amplitude.htm) (em inglês) de Jeffrey Hass.

A representação de tempo e amplitude do Audacity é o seu primeiro e mais fácil ponto de referência para edição de som, e a ferramenta oferece maneiras úteis de navegar por eles. Continuo chamando isso de onda, mas ainda não parece muito com uma. Vamos dar uma olhada mais de perto selecionando uma parte da trilha de áudio.

 - Clique em algum lugar na onda para começar a selecionar.

 - Arraste para destacar uma parte da onda (qualquer parte com som funcionará). Se estiver insatisfeito com a seleção, você pode arrastar as bordas da seleção para ajustar os limites.

 - Assim que tiver uma peça com a qual esteja satisfeito, selecione “Aumentar o zoom” no menu Exibir.

Se você aumentar o zoom seis ou sete vezes, começará a ver algo que pode se parecer mais com uma onda senoidal:

{% include figure.html filename="editing-audio-with-audacity-2.png" alt="Imagem de onda Bach ampliada no Audaciry" caption="Ampliado na visualização da forma de onda de Bach" %}

        
Observe como os incrementos de tempo no Audacity também foram ajustados à medida que você aumenta o zoom. As frequências de tom são medidas em ondas por segundo e o programa precisa juntar as coisas um pouco para fazer todo o clipe de som caber em uma janela viável. O resultado é a forma de onda que vemos quando reduzimos o zoom selecionando “Zoom Normal” no menu Exibir. Cada visão - a micro e a macro - tem seus próprios usos. Voltaremos a ambos.

{% include figure.html filename="editing-audio-with-audacity-3.png" alt="Imagem da Paleta de reprodução do Audacity" caption="Paleta de reprodução do Audacity" %}
         

Antes de prosseguir, vale também observar as diversas paletas que o Audacity oferece para suas funções mais comuns. A paleta de reprodução oferece símbolos que provavelmente são familiares: botões que permitem pausar, reproduzir, parar, avançar rapidamente para o início ou fim de um clipe e gravar.

{% include figure.html filename="editing-audio-with-audacity-4.png" alt="Imagem da Paleta de ferramenta do Audacity" caption="Paleta de ferramentas do Audacity" %}


A paleta de ferramentas, por outro lado, provavelmente parece nova. Não discutiremos todos os recursos que o Audacity oferece, portanto, alguns desses botões não serão usados. Mas tome nota: as ferramentas de “seleção” no canto superior esquerdo e as ferramentas de “mudança de tempo” no meio da parte inferior serão as duas que usaremos nesta lição. Por padrão, ao abrir o Audacity, você estará usando a ferramenta de seleção.

## Gravando áudio

Carregamos a música de introdução para o nosso podcast. Vamos continuar gravando a nossa própria voz.

- Por padrão, o Audacity irá reproduzir e regravar sua faixa original quando você tentar gravar uma nova. Para contornar isso, você pode silenciar temporariamente sua faixa de Bach enquanto grava sua voz. Para silenciar a faixa, clique no botão “Mute” à esquerda da forma de onda de Bach. A faixa de Bach ficará cinza para mostrar que não será tocada.
- Para começar a gravar no Audacity, pressione o grande círculo vermelho no canto superior esquerdo da janela do Audacity. Não se preocupe muito em obter a qualidade certa - trabalharemos na edição do ficheiro de som a seguir.
- Faça a sua melhor impressão NPR na direção do seu computador e aperte o quadrado para parar a gravação quando terminar.
Você será presenteado com algo parecido com isto:

{% include figure.html filename="editing-audio-with-audacity-5.png" alt="Imagem de duas faixas carregadas no Audacity" caption="Duas faixas carregadas no Audacity" %}
        

Nossa gravação original de Bach fica na parte superior da interface, enquanto nossa nova gravação é adicionada abaixo dela. Por padrão, o Audacity não substituirá sua gravação anterior. Em vez disso, ele isola ambos os fluxos de som, ou faixas, permitindo-nos manipular componentes separados antes de misturá-los em uma gravação final. Podemos fazer alterações em um sem afetar o outro. Observe como, em termos de tempo, a nova faixa por padrão foi gravada no início do projeto audacity. Por enquanto, Bach e as faixas vocais começam ao mesmo tempo. Existem potencialmente algumas outras imperfeições em sua gravação exclusiva, algumas das quais podemos corrigir.

Finalmente, observe como no meu exemplo existem duas formas de onda para a gravação de Bach, mas apenas uma para a gravação da minha própria voz. A gravação de Bach foi feita em estéreo, o que significa que havia duas alimentações de entrada, enquanto minha própria gravação foi feita em mono . O Audacity permite que você grave em ambos, e qualquer um funcionará para esta lição, então não se preocupe se sua gravação aparecer em estéreo. Você pode mudar de gravação mono para estéreo e vice-versa na barra de ferramentas 'Editar', acessível na parte 'Barras de ferramentas' do menu 'Visualizar'. Para obter mais informações sobre mono versus estéreo, confira esta [**leitura**](http://www.diffen.com/difference/Mono_vs_Stereo) (em inglês).

Um aparte: frequentemente pode ser útil transformar a saída de som do seu laptop em sua entrada, para que você possa gravar os sons reproduzidos em seu computador sem se preocupar com ruídos estranhos do mundo externo ou para regravar o áudio digital. Para obter informações sobre como realizar esse processo, consulte o [**Soundflower**](https://github.com/mattingalls/Soundflower) (em inglês).

## Edição de áudio

O tópico de engenharia de áudio é vasto e pode ser o tema de uma carreira longa e frutífera – não podemos esperar esgotar todos os tópicos potenciais aqui. Mas podemos oferecer apenas algumas técnicas básicas úteis para trabalhar com áudio digital. As suas experiências podem variar de acordo com o caráter único de sua própria gravação.

Para podermos utilizar a faixa gravada teremos que limpar um pouco, isolando e refinando as peças que queremos. Nosso primeiro passo será remover o silêncio indesejado criado no intervalo entre o início da gravação e o início da fala.

- Aumentar o zoom no início do clipe nos dará uma visão do silêncio e, clicando e arrastando sobre as seções da forma de onda, podemos eliminá-las pressionando a tecla delete.

{% include figure.html filename="editing-audio-with-audacity-6.png" alt="Imagem do Início da faixa vocal pronta para deletar" caption="Início da faixa vocal pronta para deletar" %}
        
{% include figure.html filename="editing-audio-with-audacity-7.png" alt="Imagem do Início da faixa após a exclusão" caption="Início da faixa após a exclusão" %}
         

Essas pequenas pausas podem ser praticamente imperceptíveis, mas são elementos importantes de qualquer faixa de áudio. E queremos que os limites da nova faixa de áudio vocal não contenham dados estranhos. Após a exclusão, você deve ter um clipe de áudio bom e compacto com apenas um fio de silêncio em cada extremidade.

Para garantir transições suaves entre as faixas, precisaremos introduzir fades ou transições graduais na amplitude. É uma boa ideia incluir um fade in muito pequeno no início de uma faixa e um fade out no final que o leve ao silêncio. Isso pode ajudar a evitar cliques e falhas, evitando que o som exploda repentinamente e desapareça.

- Aumente o zoom no início da faixa, destaque o início da onda, incluindo apenas um fio de cabelo do seu som alvo, e selecione “Fade in” no menu Effect.

Se você selecionou apenas uma parte muito pequena do áudio, talvez não consiga ver as alterações causadas pelos esmaecimentos. Essas capturas de tela com zoom ultra ajudarão:

{% include figure.html filename="editing-audio-with-audacity-8.png" alt="Imagem da Faixa antes do fade in" caption="Faixa antes do fade in" %}

{% include figure.html filename="editing-audio-with-audacity-9.png" alt="Imagem da Faixa após do fade in" caption="Faixa após fade in" %}

O fade in reduziu drasticamente a amplitude inicial e introduziu mudanças muito graduais na amplitude ao longo das seções destacadas da faixa, suavizando as coisas e criando a percepção de um aumento no volume.

- Repita isso no final do clipe, mas agora com um “Fade out”.
O seu clipe será configurado para ser inserido suavemente em qualquer ponto do ficheiro.

A eliminação do silêncio e do som indesejado preparou o clipe, mas ainda precisamos movê-lo para o timestamp que queremos. Queremos posicioná-lo na parte apropriada do podcast, depois que a música de introdução tocar um pouco. Para mover um clipe horizontalmente no eixo x da forma de onda e reatribuí-lo a uma nova posição no tempo, use a ferramenta de mudança de tempo. Com essa ferramenta selecionada, clicar em um clipe de som permite movê-lo horizontalmente no tempo em relação às outras faixas.       

- Mova o nosso clipe vocal para a direita, para que comece após a música de introdução tocar por alguns segundos.

{% include figure.html filename="editing-audio-with-audacity-10.png" alt="Imagem da Reposicionando o clipe de áudio no tempo" caption="Reposicionando o clipe de áudio no tempo" %}
         

Se o volume de sua voz em relação à música de introdução parecer desequilibrado, você pode reorganizá-los para que fiquem mais equilibrados. O volume geral de uma faixa específica pode ser ajustado usando o controle deslizante de volume da faixa à esquerda de cada painel de faixa. Parece uma pequena escala -/+:    

{% include figure.html filename="editing-audio-with-audacity-11.png" alt="Imagem do Controle deslizante de volume da faixa" caption="Controle deslizante de volume da faixa" %}

Mas, eventualmente, desejaremos fazer a transição do foco da faixa para longe da música de introdução e dar nova ênfase à gravação de nossa voz. Um crossfade como este é fácil de implementar no Audacity.

- Primeiro, apague tudo menos os primeiros cinco segundos da introdução de Bach. Coloque o cursor na faixa onde deseja começar a deletar e então pressione 'Shift K' ou selecione “Selecionar/Cursor para o Fim da Faixa” no Menu Editar. Isso selecionará tudo, desde a localização do cursor até o final da faixa.

- Alinhe o que resta com sua faixa vocal usando a ferramenta de mudança de tempo para que as duas faixas se sobreponham ligeiramente.

- Em seguida, use a ferramenta de seleção para clicar e arrastar para destacar a seção em que eles se sobrepõem, começando com a faixa superior e terminando na inferior. Ambas as faixas devem ser realçadas.  

{% include figure.html filename="editing-audio-with-audacity-12.png" alt="Imagem de FDestaque entre as faixas para crossfading" caption="Destaque entre as faixas para crossfading" %}
               

- Selecionar “Crossfade Tracks” no menu Effect dirá ao Audacity para fazer fade out na trilha superior enquanto desaparece na trilha inferior - o posicionamento das trilhas é importante neste caso.

O Audacity solicitará opções para o seu crossfade, mas por enquanto não há problema em usar a configuração padrão de “Ganho constante”. Essa configuração garante que ambas as faixas tenham fade in ou linearmente (para mais informações, confira a [**documentação**](http://manual.audacityteam.org/man/crossfade_tracks.html) (em inglês) do Audacity sobre crossfades)

{% include figure.html filename="editing-audio-with-audacity-13.png" alt="Imagem sobre a função crossfade" caption="Pós-crossfad" %}
        

Quando o produto final é misturado, o resultado será uma transição perfeita entre os dois elementos.

## Exportador

Por padrão, tudo o que você faz no Audacity é salvo no próprio tipo de ficheiro da ferramenta, .aup. Para concluir este projeto de bebê, precisaremos exportá-lo para um formulário que possa ser reproduzido pela maioria dos programas de áudio.

- Selecione “Exportar áudio” no menu de ficheiro.

Isso fará um mix das várias faixas em um único ficheiro de áudio e dará a você a oportunidade de fornecer metadados ao seu trabalho.

Há uma variedade de opções diferentes para você refinar o processo de exportação, mas a mais importante é “Tipo de ficheiro”. MP3 e Ogg são boas opções de áudio para exibição na web, pois ambos compactam os ficheiros para que sejam mais rápidos de carregar. Para obter melhores resultados, você pode realmente incluir ambos os formatos e exibir apenas aquele como substituto quando um não for compatível com o navegador da Web do usuário. Para obter mais informações, a NCH Software fornece uma boa [**análise técnica das diferentes opções**](http://www.nch.com.au/acm/formats.html) (em inglês), enquanto Jonathan Sterne fez [**um trabalho fascinante**](https://www.dukeupress.edu/MP3/) (em inglês) sobre as implicações culturais de tais decisões de formato. E o W3Schools oferece uma [**boa comparação**](http://www.w3schools.com/html/html5_audio.asp) (em inglês) desses formatos de ficheiro para uso no desenvolvimento web.

Parabéns! Você produziu com sucesso um podcast para bebês. Pode não parecer muito, mas frequentemente uso esse mesmo pacote de truques para apresentações, sites e divulgação de conhecimento. Esta lição de forma alguma começou a esgotar os muitos tópicos sob esse guarda-chuva. Mas deverá ter fornecido algumas ferramentas básicas úteis para trabalhar com som em projetos de humanidades digitais.
