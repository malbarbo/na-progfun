---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Funções como valores: abstração
urlcolor: Blue
license:
---

# Começando

@) O que significa dizer que funções são entidades de primeira classe?

@) O que é uma função de alta ordem?

@) O que é abstração? Dê um exemplo, diferente dos vistos em sala, de duas funções que podem ser abstraídas em uma única função que recebe uma função como parâmetro.

@) Quando podemos utilizar as funções `map`, `filter` e `fold_right`?

@) Qual estratégia foi discutida para projetar funções que recebem funções como parâmetro?


# Praticando

@) Analise os exemplos e exercícios de listas e redefina as funções (que forem possíveis) utilizando as funções `list.map`, `list.filter` e `list.fold_right` (diretamente ou com uma combinação dessas funções). As novas funções ficaram mais simples?

@) Veja a [documentação](https://hexdocs.pm/gleam_stdlib/gleam/list.html) das funções `list.map2`, `list.filter_map` e `list.fold_until` e faça uma implementação dessas funções.

@) Analise os exemplos e exercícios de números naturais e defina uma função `reduz_num` (semelhante à função `reduz` feita em sala) que abstraia o comportamento do modelo para funções com números naturais. Redefina as funções da lista de exercícios de números naturais (que for possível) em termos de `reduz_num`. As novas funções ficaram mais simples?


# Resolvendo problemas

Use as funções `list.map`, `list.filter` e `list.fold_right` (diretamente ou com uma combinação dessas funções) sempre que for apropriado.

@) Uma loja virtual mostra, na tela de finalização da compra, o valor total do carrinho. Cada item do carrinho tem o nome do produto, o preço unitário e a quantidade comprada. Projete uma função que calcule o valor total de um carrinho.

@) Ao final do semestre, a secretaria do curso precisa publicar a lista de alunos aprovados em uma disciplina. Um aluno é aprovado se a sua nota é maior ou igual a 6,0. Projete uma função que, a partir do nome e da nota de cada aluno da turma, produza a lista com o nome dos alunos aprovados.

@) Um aplicativo de banco mostra o saldo de uma conta a partir das movimentações do mês. Cada movimentação é um depósito ou um saque, com o respectivo valor. Projete uma função que calcule o saldo final de uma conta que começou o mês com saldo zero.
