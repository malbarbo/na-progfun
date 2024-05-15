---
# vim: set spell spelllang=pt_br sw=4:
title: Tipos de dados - Problemas
urlcolor: Black
# TODO: adicionar problema imposto de renda no Brasil, faixas, considerando os descontos, indicar mais vantasos simplificado ou completo
# TODO: revisar os problemas e tentar deixar apenas problemas interessantes (práticos)
# TODO: adicionar problema de cálculo de tarifa em pedágio (moto, carro, caminhão por eixo)
---

<!-- Enumeração -->

@. A nota final em um disciplina é calculada pela média simples de 4 avaliações que valem de 0 a 10. A partir da nota final os alunos ficam em um de três situações: Aprovado, alunos com nota final maior ou igual a 7. Reprovado, alunos com nota menor que 4. Exame, alunos com nota maior igual a 4 e menores que 7. Projete uma função que indique a situação de um aluno dado as 4 notas das suas avaliações.

@. O Brasil institui há algum tempo um sistema de bandeira tarifária para sinalizar aos consumidores os custos reais de geração de energia. Nesse sistema, a bandeira verde indica condições favoráveis de geração de energia e a tarifa não sofre acréscimo. Já a bandeira amarela indica condições menos favoráveis e por isso a tarifa sofre um acréscimo de R$ 0,01874 para cada quilowatt-hora. A bandeira vermelha - patamar 1 indica condições mais custosas de geração e o acréscimo na tarifa é de R$ 0,03971 para cada quilowatt-hora consumido. Por fim, a bandeira vermelha - patamar 2 indica condições ainda mais custosas e o acréscimo na tarifa é de R$ 0,09492 para cada quilowatt-hora consumido. Projete uma função que determine o valor final que o consumidor tem que pagar dado o seu consumo em quilowatt-hora, a tarifa básica do quilowatt-hora e a bandeira tarifária.

@. Jokenpô é um jogo recreativo bastante conhecido no Brasil. Nele dois participantes esticam a mão simultaneamente e formam um símbolo, que pode ser pedra, papel ou tesoura. A decisão de quem ganha é feita da seguinte forma: a pedra ganha da tesoura, a tesoura ganha do papel, e o papel ganha da pedra. Projete uma função que determine a partir do nome e símbolo feito por dois jogadores, quem ganhou no jogo.


<!-- Estrutura -->

@. O desempenho de um time de futebol em um determinado campeonato é dado pelo número de pontos, número de vitórias e saldo de gols (diferenças entre todos os gols marcados e sofridos). Cada jogo ganho pelo time dá 3 pontos e empate 1 ponto. Projete uma função que atualize o desempenho de um time a partir do resultado do seu último jogo (gols feitos e gols sofrido).

@. Em um determinado programa é necessário exibir para o usuário o tempo que uma operação demorou. Esse tempo está disponível em segundos, mas exibir essa informação em segundos para o usuário pode não ser interessante, afinal, ter uma noção razoável de tempo para 14678 segundos é difícil!

    a) Projete uma função que converta uma quantidade de segundos para uma quantidade de horas, minutos e segundos equivalentes.

    a) Projete uma função que converta uma quantidade de horas, minutos e segundos em uma string amigável para o usuário. A string não deve conter informações sobre tempo que são zeros (por exemplo, não deve informar 0 minutos).

@. Considere um jogo onde o personagem está em um tabuleiro (semelhante a um tabuleiro de jogo de xadrez). As linhas e colunas do tabuleiro são enumeradas de 1 a 10, dessa forma, é possível representar a posição (casa) do personagem pelo número da linha e da coluna que ele se encontra. O personagem fica virado para uma das direções: norte, sul, leste ou oeste. O jogador pode avançar o seu personagem qualquer número de casas na direção que ele está virado, mas é claro, não pode sair do tabuleiro. Projete uma função que indique a partir das informações do personagem, qual é o número máximo de casas que ele pode avançar na direção que ele está virado.

@. Segundo a Wikipédia, um pixel é o menor elemento de um dispositivo de exibição, como por exemplo, um monitor, ao qual é possível atribuir uma cor. Nos monitores atuais, os pixels são organizados em linhas e colunas, de maneira a formar a imagem exibida. Cada pixel pode ser referenciado por uma coordenada, que é o número da linha e coluna que ele aparece. Por exemplo, em um monitor de 1080 linhas por 1920 colunas, o pixel no canto superior esquerdo está na posição (0, 0), enquanto o pixel no canto inferior direito está na posição (1079, 1919).

    Em um ambiente gráfico com janelas, quando o usuário faz um clique com o mouse é necessário identificar em qual janela ocorreu o clique.

    a) Projete uma função que receba como parâmetros as informações sobre uma janela e um clique do mouse e determine se o clique aconteceu sobre a janela.

    a) (Desafio) Projete uma função que verifique se os espaços de duas janelas se sobrepõem.


<!-- União -->

@. Considere um jogo onde o personagem está em um tabuleiro (semelhante a um tabuleiro de jogo de xadrez). As linhas e colunas do tabuleiro são enumeradas de 1 a 10, dessa forma, é possível representar a posição (casa) do personagem pelo número da linha e da coluna que ele se encontra. O personagem fica virado para uma das direções: norte, sul, leste ou oeste. O jogador controla o personagem através de um dos seguintes comandos: virar a esquerda e virar a direita, que mudam a direção que o personagem está virado e avançar $n$ casas, que faz o personagem avançar até $n$ casas na direção que ele está virado.

    Projete uma função que receba como entrada o personagem do jogo e um comando e gere como saída o novo estado do personagem.

    Por exemplo, ao executar o comando para virar a direita, sendo que o personagem está na posição (1, 5) e virado para o norte, a função deve gerar como resultado o personagem na posição (1, 5) virado para o leste.

    Se o comando for para avançar duas casas, sendo que o personagem está na posição (7, 5) virado para o oeste, a função deve gerar como resultado o personagem na posição (7, 3) virado para o oeste.

    Dica: use papel e lápis para criar exemplos!

@. Em uma determinada loja uma compra pode ser paga de diversas formas. Se o pagamento for com PIX ou dinheiro, o cliente tem 10% de desconto. Se o pagamento for com boleto, 8% de desconto. Se o pagamento for parcelado no cartão em até 3 vezes, não tem desconto. Se o pagamento for parcelado em mais de 3 vezes (no máximo em 12 vezes), então existe uma acréscimo de 12%. Projete uma função que receba como entrada o valor de uma compra e a forma de pagamento e produza o valor final que será pago pela compra.

@. Uma encomenda do correio pode ser enviada em três tipos de embalagens: envelope, caixa ou rolo. Para uma embalagem ser válida, ela tem que atender as seguintes restrições:

    | Envelope         | Mínimo | Máximo |
    |------------------+-------:+-------:|
    | Comprimento (C)  |  16 cm | 60 cm  |
    | Largura (L)      |  11 cm | 60 cm  |
    | Soma (C + L)     |  27 cm | 120 cm |

    \newpage

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
