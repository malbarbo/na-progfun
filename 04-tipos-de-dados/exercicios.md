---
# vim: set spell spelllang=pt_br sw=4:
title: Tipos de dados - Exercícios
---

#. Defina uma estrutura para representar um retângulo. Em seguida defina uma função que classifique um retângulo em largo (largura maior que altura), alto (altura maior que largura) ou quadrado (altura igual a largura).

#. Considere um jogo onde o personagem está em um tabuleiro (semelhante a um tabuleiro de jogo de xadrez). As linhas e colunas do tabuleiro são enumeradas de 1 a 10, dessa forma, é possível representar a posição (casa) do personagem pelo número da linha e da coluna que ele se encontra. O personagem fica virado para uma das direções: norte, sul, leste ou oeste. O jogador controla o personagem através de um dos seguintes comandos: virar a esquerda e virar a direita, que mudam a direção que o personagem está virado e avançar $n$ casas, que faz o personagem avançar até $n$ casas na direção que ele está virado.

   Projete uma função, incluindo os tipos de dados necessários, que receba como entrada o personagem do jogo e um comando e gere como saída o novo estado do personagem.

   Por exemplo, ao executar o comando para virar a direita, sendo que o personagem está na posição (1, 5) e virado para o norte, a função deve gerar como resultado o personagem na posição (1, 5) virado para o leste.

   Se o comando for para avançar duas casas, sendo que o personagem está na posição (7, 5) virado para o oeste, a função deve gerar como resultado o personagem na posição (7, 3) virado para o oeste.

   Dica: use papel e lápis para criar exemplos!
