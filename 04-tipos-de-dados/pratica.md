---
# vim: set spell spelllang=pt_br sw=4:
title: Tipos de dados - Prática
urlcolor: Blue
# TODO: adicionar um exercícios simples de estrutura
# TODO: adicionar um exercícios simples de união
---

#. O desempenho de um time de futebol em um determinado campeonato é dado pelo número de pontos, número de vitórias e saldo de gols (diferenças entre todos os gols marcados e sofridos). Cada jogo ganho pelo time dá 3 pontos e empate 1 ponto. Projete uma função que atualize o desempenho de um time a partir do resultado do seu último jogo (gols feitos e gols sofrido).

#. Em um determinado programa é necessário exibir para o usuário o tempo que uma operação demorou. Esse tempo está disponível em segundos, mas exibir essa informação em segundos para o usuário pode não ser interessante, afinal, ter uma noção razoável de tempo para 14678 segundos é difícil!

    a) Projete uma função que converta uma quantidade de segundos para uma quantidade de horas, minutos e segundos equivalentes.

    b) Projete uma função que converta uma quantidade de horas, minutos e segundos em uma string amigável para o usuário. A string não deve conter informações sobre tempo que são zeros (por exemplo, não deve informar 0 minutos).

#. A nota final em um disciplina é calculada pela média simples de 4 avaliações que valem de 0 a 10. A partir da nota final os alunos ficam em um de três situações: Aprovado, alunos com nota final maior ou igual a 7. Reprovado, alunos com nota menor que 4. Exame, alunos com nota maior igual a 4 e menores que 7. Projete uma função que indique a situação de um aluno dado as 4 notas das suas avaliações.

#. Considere um jogo onde o personagem está em um tabuleiro (semelhante a um tabuleiro de jogo de xadrez). As linhas e colunas do tabuleiro são enumeradas de 1 a 10, dessa forma, é possível representar a posição (casa) do personagem pelo número da linha e da coluna que ele se encontra. O personagem fica virado para uma das direções: norte, sul, leste ou oeste. O jogador pode avançar o seu personagem qualquer número de casas na direção que ele está virado, mas é claro, não pode sair do tabuleiro. Projete uma função que indique a partir das informações do personagem, qual é o número máximo de casas que ele pode avançar na direção que ele está virado.

#. Uma determinada sala de reunião pode ser usada das 8:00h às 18:00h. Cada interessado em utilizar a sala faz uma reserva indicando o intervalo de tempo que gostaria de utilizar a sala. Como parte de um sistema de reservas, você deve projetar uma função que verifique se duas reservas podem ser atendidas, ou seja, não têm conflito de horário.

#. Segundo a Wikipédia, um pixel é o menor elemento de um dispositivo de exibição, como por exemplo, um monitor, ao qual é possível atribuir uma cor. Nos monitores atuais, os pixels são organizados em linhas e colunas, de maneira a formar a imagem exibida. Cada pixel pode ser referenciado por uma coordenada, que é o número da linha e coluna que ele aparece. Por exemplo, em um monitor de 1920 colunas por 1080 linhas, o pixel no canto superior esquerdo está na posição (0, 0), enquanto o pixel no canto inferior direito está na posição (1919, 1079).

   Em um ambiente gráfico com janelas, quando o usuário faz um clique com o mouse é necessário identificar em qual janela ocorreu o clique.

   a) Projete uma função que receba como parâmetros as informações sobre uma janela e um clique do mouse e determine se o clique aconteceu sobre a janela.

   b) (Desafio) Projete uma função que verifique se os espaços de duas janelas se sobrepõem.

#. Uma encomenda do correio pode ser enviada em três tipos de embalagens: envelope, caixa ou rolo. Para uma embalagem ser válida, ela tem que atender as seguintes restrições:

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

#. Em uma determinada loja uma compra pode ser paga de diversas formas. Se o pagamento for com PIX ou dinheiro, o cliente tem 10% de desconto. Se o pagamento for com boleto, 8% de desconto. Se o pagamento for parcelado no cartão em até 3 vezes, não tem desconto. Se o pagamento for parcelado em mais de 3 vezes (no máximo em 12 vezes), então existe uma acréscimo de 12%. Projete uma função que receba como entrada o valor de uma compra e a forma de pagamento e produza o valor final que será pago pela compra.
