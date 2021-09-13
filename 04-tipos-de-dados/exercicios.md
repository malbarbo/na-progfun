---
# vim: set spell spelllang=pt_br sw=4:
# TODO: adicionar exercícios!
title: Tipos de dados
---

#.  Considere um jogo onde o personagem está em um tabuleiro (semelhante a um tabuleiro de jogo de xadrez). As linhas e colunas do tabuleiro são enumeradas de 1 a 10, dessa forma, é possível representar a posição (casa) do personagem pelo número da linha e da coluna que ele se encontra. O personagem fica virado para uma das direções: norte, sul, leste ou oeste. O jogador controla o personagem através de um dos seguintes comandos: virar a esquerda e virar a direita, que mudam a direção que o personagem está virado e avançar $n$ casas, que faz o personagem avançar até $n$ casas na direção que ele está virado.

    Projete uma função, incluindo os tipos de dados necessários, que receba como entrada o personagem do jogo, um comando e produz o novo estado do personagem.

    Alguns possível exemplos de funcionamento

    ```
    (executa-acao (personagem 1 5 "Norte") "VirarDireita") -> (personagem 1 5 "Leste")

    (executa-acao (personagem 7 5 "Oeste") (avancar 2)) -> (personagem 7 3 "Oeste")
    ```

    Dica: use papel e lápis para criar exemplos!
