---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Recursão estrutural: naturais
urlcolor: Blue
license:
# TODO: completar 5 problemas
---

# Começando

@) Dê um exemplo de função em que um número natural de entrada deve ser visto como um dado composto e outro em que ele deve ser visto como um dado atômico.

@) Escreva o modelo de função para números naturais e explique a relação de cada caso do modelo com a definição de número natural.


# Praticando

<!-- Natural -->

@) Projete uma função que receba como parâmetro um número natural $n$ e um valor $v$ e crie uma nova lista com $n$ repetições do valor $v$.

@) Projete uma função que receba como entrada um número $a$ e um número natural $n$ e calcule o valor $a^n$.

@) Projete uma função que receba como parâmetro um número natural $n$ e calcule o produto dos números $1, 2, \cdots, n$.

@) Recursão indireta é quando duas ou mais funções chamam uma a outra. Defina duas funções `impar` e `par`, uma em termos da outra, isto é, a função `impar` deve chamar a função `par` e a função `par` deve chama a função `impar` (a recursão para no caso base).


# Resolvendo problemas

<!-- Natural -->

@) Em um determinado jogo de construção de itens, cada item tem uma classe que varia de 1 a 10. Os item de classe 1 surgem conforme o jogador explorar os baús. Um item de classe 2 ou superior precisa ser construídos unindo dois itens da classe anterior. Por exemplo, para construir um item de classe 2 é necessário unir dois item de classe 1. Para construir um item de classe 10 é necessário unir dois item de classe 9. Projete uma função que receba como entrada um número $n$ (de 1 a 10), e determine quantos itens de classe 1 são necessário para construir um item de classe $n$. Suponha que a únicas operações aritméticas disponíveis sejam a soma e a multiplicação.
