---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Tipos de dados
urlcolor: Blue
license:
# TODO: mudar a terminologia para tipos de dados algébricos
# TODO: adicionar exercícios de result e option
# TODO: adicionar problema imposto de renda no Brasil, faixas, considerando os descontos, indicar qual é mais vantajoso: simplificado ou completo
# TODO: revisar os problemas e tentar deixar apenas problemas interessantes (práticos)
# TODO: adicionar problema de cálculo de tarifa em pedágio (moto, carro, caminhão por eixo)
---

# Começando

@) O que é um tipo de dado?

@) Qual é o propósito da etapa de definição de tipos de dados no processo de projeto de funções?

@) Quais são os princípios que podemos utilizar para determinar se um tipo de dado é adequado para representar uma informação?

@) Quando devemos utilizar estruturas para representar informações?

<!--
@) Como são chamadas as funções utilizadas para criar instâncias de estruturas?
-->

@) Como se modifica o valor de um campo de uma instância de uma estrutura? Explique.

@) Quando devemos utilizar enumerações para representar informações?

@) O que são tipos algébricos de dados?

@) De que forma as enumerações e uniões, quando usadas como entrada para funções, guiam a criação dos exemplos e a implementação da função?

@) Quando devemos utilizar uniões para representar informações?


# Praticando

<!--
Na implementação use apenas as funções presentes no material "Resumo da linguagem Racket". Não use funções de alta ordem.
-->

<!-- Enumerações -->

@) Projete uma enumeração para representar as direções norte, leste, sul e oeste. Em seguida,

    a) Projete uma função que indique a direção oposta de uma dada direção.

    b) Projete uma função que indique qual é a direção que está a 90 graus no sentido horário de outra direção.

    c) Projete uma função que indique qual é a direção que está a 90 graus no sentido anti-horário de outra direção. Use a função do item b para fazer a implementação (não use seleção).

    d) Projete uma função que receba como entrada duas direções e indique quantos graus uma pessoa que está virada para a primeira direção precisa virar no sentido horário para virar para a segunda direção.

@) Projete uma enumeração para representar a situação de um elevador que pode estar parado, subindo ou descendo. Em seguida,

    a) Sabendo que um elevador está parado e irá atender imediatamente uma solicitação, projete uma função que determine, a partir do andar atual e do andar solicitado, qual será a situação do elevador imediatamente após receber a solicitação.

    b) Sabendo que um elevador só pode começar a se movimentar se estiver parado, projete uma função que verifique se o elevador pode passar de um estado para outro. Faça uma tabela que mostre as nove possibilidades de entrada da função e a saída de cada possibilidade. Faça os exemplos a partir da tabela. Faça a implementação simplificada a partir da tabela.


<!-- Estruturas -->

@) Projete uma estrutura para representar resoluções (largura e altura em pixels) de telas e imagens. Em seguida,

    a) Projete uma função que determine quantos megapixels uma imagem tem, dada a sua resolução. O número de megapixels pode ser calculado multiplicando-se a altura e a largura e dividindo-se o resultado por 1 milhão.

    b) Projete uma função que indique se uma resolução tem aspecto (razão entre largura e altura) de 4:3, 16:9 ou outro (projete um tipo enumerado para representar o aspecto). Por exemplo, a resolução $1920 \times 1080$ tem aspecto 16:9, pois $1920 \times 9 = 1080 \times 16$.

    c) Projete uma função que receba duas resoluções, uma de uma imagem e outra de uma tela, e verifique se a imagem pode ser exibida completamente na tela sem a necessidade de rotação ou mudança de tamanho.


<!-- Uniões -->

@) Projete uma união para representar uma figura, que pode ser um retângulo (com largura e altura) ou um círculo (com raio). Em seguida,

    a) Projete uma função que determine a área de uma figura. A área de um retângulo é dada por ${largura} \times {altura}$, e a área de um círculo é dada por $3.14 \times {raio}^2$.

    b) Projete uma função que verifique se uma figura cabe dentro de outra. Faça uma tabela com as quatro possibilidades (retângulo-retângulo, retângulo-círculo, círculo-retângulo, círculo-círculo) e identifique as condições necessárias para a primeira figura caber na segunda (um retângulo cabe dentro de um círculo se a sua diagonal ($\sqrt{ {altura}^2 + {largura}^2}$) for menor que o diâmetro do círculo ($2 \times {raio}$)). Faça os exemplos e a implementação a partir da tabela.


<!-- Option -->

@) Projete uma união para representar um espectador de uma sala de cinema, que pode ser uma criança, um jovem, um adulto ou um idoso. Um jovem pode opcionalmente apresentar sua carteirinha com um código numérico de estudante. Em seguida,

    a) Projete uma função que retorne o número da carteirinha de estudante, caso o espectador a tenha.

    b) Projete uma função que retorne um valor booleano indicando se o espectador tem direito ou não a um desconto no ingresso. Crianças e idosos sempre têm desconto. Um adulto não tem desconto. E um jovem só tem desconto se tiver uma carteirinha de estudante.


<!-- TAD -->

@) Projete uma estrutura para representar uma data com dia, mês e ano. Em seguida,

    a) Projete uma função que receba como entrada uma string que representa uma data no formato "dd/mm/aaaa" e a converta para a data equivalente. A validação inicial no construtor deve verificar apenas se as partes são números.

    b) Projete uma função que verifique se uma data corresponde ao último dia do ano.

    c) Projete uma função que receba duas datas e produza `True` se a primeira data ocorrer antes da segunda.

    d) (Desafio) Modifique o construtor de maneira que ele verifique se uma data é válida. Considere que, em anos bissextos, fevereiro tem 29 dias e que um ano é bissexto se for múltiplo de 400 ou se for múltiplo de 4, mas não de 100.



# Resolvendo problemas

<!-- Enumeração -->

@) A nota final em uma disciplina é calculada pela média simples de 4 avaliações, que valem de 0 a 10. A partir da nota final, os alunos enquadram-se em uma de três situações: aprovado, para notas finais maiores ou iguais a 7; reprovado, para notas menores que 4; e exame, para notas maiores ou iguais a 4 e menores que 7. Projete uma função que indique a situação de um aluno, dadas as 4 notas de suas avaliações.

@) O Brasil instituiu, há algum tempo, um sistema de bandeiras tarifárias para sinalizar aos consumidores os custos reais da geração de energia. Nesse sistema, a bandeira verde indica condições favoráveis de geração, e a tarifa não sofre acréscimo. Já a bandeira amarela indica condições menos favoráveis, e, por isso, a tarifa sobre um acréscimo de R$ 0,01874 por quilowatt-hora (kWh) consumido. A bandeira vermelha - patamar 1 indica condições mais custosas de geração, e o acréscimo na tarifa é de R$ 0,03971 por kWh. Por fim, a bandeira vermelha - patamar 2 indica condições ainda mais custosas, e o acréscimo é de R$ 0,09492 por kWh. Projete uma função que determine o valor final que o consumidor deve pagar, dados o seu consumo em kWh, a tarifa básica do kWh e a bandeira tarifária.

@) Jokenpô é um jogo recreativo bastante conhecido no Brasil. Nele, dois participantes esticam a mão simultaneamente e formam um símbolo, que pode ser pedra, papel ou tesoura. A decisão de quem ganha é feita da seguinte forma: a pedra vence a tesoura, a tesoura vence o papel e o papel vence a pedra. Projete uma função que determine, a partir dos nomes e dos símbolos escolhidos pelos dois jogadores, quem venceu a rodada.


<!-- Estrutura -->

@) O desempenho de um time de futebol em um campeonato é medido pelo número de pontos, de vitórias e pelo saldo de gols (diferença entre todos os gols marcados e sofridos). Cada vitória vale 3 pontos, e cada empate, 1 ponto. Projete uma função que atualize o desempenho de um time com base no resultado do seu último jogo (gols marcados e gols sofridos).

@) Em um determinado programa, é necessário exibir para o usuário o tempo de duração de uma operação. Esse tempo está disponível em segundos, mas exibir essa informação em segundos pode não ser prático para o usuário — afinal, ter uma noção clara do que 14.678 segundos representam é difícil!

    a) Projete uma função que converta uma quantidade de segundos para o valor equivalente em horas, minutos e segundos.

    b) Projete uma função que converta uma quantidade de horas, minutos e segundos em uma string amigável para o usuário. A string não deve conter informações de tempo com valor zero (por exemplo, não deve exibir "0 minutos").

@) Considere um jogo em que o personagem está em um tabuleiro (semelhante a um tabuleiro de xadrez). As linhas e colunas do tabuleiro são numeradas de 1 a 10; dessa forma, é possível representar a posição (casa) do personagem pelo número da linha e da coluna em que ele se encontra. O personagem fica virado para uma das quatro direções: norte, sul, leste ou oeste. O jogador pode avançar seu personagem qualquer número de casas na direção em que ele está virado, mas, claro, sem sair do tabuleiro. Projete uma função que indique, a partir das informações do personagem, qual é o número máximo de casas que ele pode avançar na direção em que está virado.

@) Segundo a Wikipédia, um pixel é o menor elemento de um dispositivo de exibição (como um monitor, por exemplo) ao qual é possível atribuir uma cor. Nos monitores atuais, os pixels são organizados em linhas e colunas para formar a imagem exibida. Cada pixel pode ser referenciado por uma coordenada, que corresponde ao número da linha e da coluna em que ele aparece. Por exemplo, em um monitor de 1080 linhas por 1920 colunas, o pixel no canto superior esquerdo está na posição (0, 0), enquanto o pixel no canto inferior direito está na posição (1079, 1919).

    Em um ambiente gráfico com janelas, quando o usuário clica com o mouse, é necessário identificar em qual janela o clique ocorreu.

    a) Projete uma função que receba como parâmetros as informações sobre uma janela e um clique do mouse e determine se o clique ocorreu sobre a janela.

    b) (Desafio) Projete uma função que verifique se os espaços de duas janelas se sobrepõem.


<!-- União -->

@) Considere um jogo em que o personagem está em um tabuleiro (semelhante a um tabuleiro de xadrez). As linhas e colunas do tabuleiro são numeradas de 1 a 10; dessa forma, é possível representar a posição (casa) do personagem pelo número da linha e da coluna em que ele se encontra. O personagem fica virado para uma das quatro direções: norte, sul, leste ou oeste. O jogador controla o personagem por meio de um dos seguintes comandos: virar à esquerda e virar à direita, que mudam a direção para a qual o personagem está virado, e avançar $n$ casas, que o faz avançar até N casas na direção em que ele está virado.

    Projete uma função que receba como entrada o personagem do jogo e um comando e gere como saída o novo estado do personagem.

    Por exemplo, ao executar o comando para virar à direita, estando o personagem na posição (1, 5) e virado para o norte, a função deve gerar como resultado o personagem na posição (1, 5) e virado para o leste.

    Se o comando for para avançar duas casas, estando o personagem na posição (7, 5) e virado para o oeste, a função deve gerar como resultado o personagem na posição (7, 3) e virado para o oeste.

    Dica: use papel e lápis para criar os exemplos!

@) Em uma determinada loja, uma compra pode ser paga de diversas formas. Se o pagamento for com PIX ou dinheiro, o cliente tem 10% de desconto. Se for com boleto, o desconto é de 8%. Pagamentos com cartão de crédito em até 3 vezes não têm desconto. Para parcelamentos em mais de 3 vezes (até 12 vezes), há um acréscimo de 12%. Projete uma função que receba como entrada o valor de uma compra e a forma de pagamento e produza o valor final a ser pago.

@) Uma encomenda dos Correios pode ser enviada em três tipos de embalagem: envelope, caixa ou rolo. Para que uma embalagem seja considerada válida, ela deve atender às seguintes restrições:

    | Envelope         | Mínimo | Máximo |
    |------------------+-------:+-------:|
    | Comprimento (C)  |  16 cm | 60 cm  |
    | Largura (L)      |  11 cm | 60 cm  |
    | Soma (C + L)     |  27 cm | 120 cm |

    | Caixa            | Mínimo | Máximo |
    |------------------+-------:+-------:|
    | Comprimento (C)  |  15 cm | 100 cm |
    | Largura (L)      |  10 cm | 100 cm |
    | Altura (A)       |   1 cm | 100 cm |
    | Soma (C + L + A) |  26 cm | 200 cm |

    | Rolo             | Mínimo | Máximo |
    |------------------+-------:+-------:|
    | Comprimento (C)  | 18 cm  | 100 cm |
    | Diâmetro (D)     |  5 cm  |  91 cm |
    | Soma (C + 2D)    | 28 cm  | 200 cm |

    Projete uma função que verifique se uma embalagem é válida.
