---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Funções totais
urlcolor: Blue
license:
# TODO: adicionar mais exercícios de result e option
---

# Começando

@) Quando o tipo `Option` é adequado e quando o tipo `Result` é mais adequado? Descreva uma situação para cada caso.

@) Por que devolver um valor especial (como -1) para indicar a ausência de um resultado é pior do que devolver um `Option`? Explique.

@) O que é um tipo opaco e qual problema ele resolve? Dê um exemplo de informação cuja representação se beneficia dessa técnica.


# Praticando

<!-- Option -->

@) Projete uma união para representar um espectador de uma sala de cinema, que pode ser uma criança, um jovem, um adulto ou um idoso. Um jovem pode opcionalmente apresentar sua carteirinha com um código numérico de estudante. Em seguida,

    a) Projete uma função que retorne o número da carteirinha de estudante, caso o espectador a tenha.

    b) Projete uma função que retorne um valor booleano indicando se o espectador tem direito ou não a um desconto no ingresso. Crianças e idosos sempre têm desconto. Um adulto não tem desconto. E um jovem só tem desconto se tiver uma carteirinha de estudante.


<!-- TAD -->

@) Projete um tipo opaco para representar uma data com dia, mês e ano, com uma função construtora que valide o valor e devolva um `Result`. Em seguida,

    a) Projete uma função que receba como entrada uma string que representa uma data no formato "dd/mm/aaaa" e a converta para a data equivalente. A validação inicial no construtor deve verificar apenas se as partes são números.

    b) Projete uma função que verifique se uma data corresponde ao último dia do ano.

    c) Projete uma função que receba duas datas e produza `True` se a primeira data ocorrer antes da segunda.

    d) (Desafio) Modifique o construtor de maneira que ele verifique se uma data é válida. Considere que, em anos bissextos, fevereiro tem 29 dias e que um ano é bissexto se for múltiplo de 400 ou se for múltiplo de 4, mas não de 100.


# Resolvendo problemas

@) Jokenpô é um jogo recreativo bastante conhecido no Brasil. Nele, dois participantes esticam a mão simultaneamente e formam um símbolo, que pode ser pedra, papel ou tesoura. A decisão de quem ganha é feita da seguinte forma: a pedra vence a tesoura, a tesoura vence o papel e o papel vence a pedra. Projete uma função que determine, a partir dos nomes e dos símbolos escolhidos pelos dois jogadores, quem venceu a rodada.
