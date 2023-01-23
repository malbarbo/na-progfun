---
# vim: set spell spelllang=pt_br sw=4:
title: Tipos de dados
---

#. Defina uma estrutura para representar um retângulo. Em seguida defina uma função que classifique um retângulo em largo (largura maior que altura), alto (altura maior que largura) ou quadrado (altura igual a largura).

#. Defina uma função que converta uma quantidade de segundos para uma quantidade de horas, minutos e segundos equivalente. A quantidade de segundos e de minutos da resposta deve ser menor que 60.

#. Uma determinada sala de reunião pode ser usada das 8:00h às 18:00h. Cada interessado em utilizar a sala faz uma reserva indicando o intervalo de tempo que gostaria de utilizar a sala. Como parte de um sistema de reservas, você deve projetar uma função que verifique se duas reservas podem ser atendidas, ou seja, não têm conflito de horário.

#. A nota final em um disciplina é calculada pela média simples de 4 avaliações que valem de 0 a 10. A partir da nota final os alunos ficam em um de três situações: Aprovado, alunos com nota final maior ou igual a 7. Reprovado, alunos com nota menor que 4. Exame, alunos com nota maior igual a 4 e menores que 7. Projete uma função que indique a situação de um aluno dado as 4 notas das suas avaliações.

#. Em uma determinada loja uma compra pode ser paga de diversas formas. Se o pagamento for com PIX ou dinheiro, o cliente tem 10% de desconto. Se o pagamento for com boleto, 8% de desconto. Se o pagamento for parcelado no cartão em até 3 vezes, não tem desconto. Se o pagamento for parcelado em mais de 3 vezes (no máximo em 12 vezes), então existe uma acréscimo de 12%. Projete uma função que receba como entrada o valor de uma compra e a forma de pagamento e produza o valor final que será pago pela compra.

#. Considere um jogo onde o personagem está em um tabuleiro (semelhante a um tabuleiro de jogo de xadrez). As linhas e colunas do tabuleiro são enumeradas de 1 a 10, dessa forma, é possível representar a posição (casa) do personagem pelo número da linha e da coluna que ele se encontra. O personagem fica virado para uma das direções: norte, sul, leste ou oeste. O jogador controla o personagem através de um dos seguintes comandos: virar a esquerda e virar a direita, que mudam a direção que o personagem está virado e avançar $n$ casas, que faz o personagem avançar até $n$ casas na direção que ele está virado.

   Projete uma função, incluindo os tipos de dados necessários, que receba como entrada o personagem do jogo e um comando e gere como saída o novo estado do personagem.

   Por exemplo, ao executar o comando para virar a direita, sendo que o personagem está na posição (1, 5) e virado para o norte, a função deve gerar como resultado o personagem na posição (1, 5) virado para o leste.

   Se o comando for para avançar duas casas, sendo que o personagem está na posição (7, 5) virado para o oeste, a função deve gerar como resultado o personagem na posição (7, 3) virado para o oeste.

   Dica: use papel e lápis para criar exemplos!
