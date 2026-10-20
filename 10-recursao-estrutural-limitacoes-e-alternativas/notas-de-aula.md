---
# vim: set spell spelllang=pt_br sw=4:
title: Recursão estrutural
subtitle: Limitações e alternativas
---


Limitações
==========


## Limitações

Cada tipo com autorreferência tem um modelo de função que podemos usar como ponto de partida para implementar funções que processam esse tipo de dado. \pause

Embora o modelo seja um ponto de partida, em algumas situações ele pode não ser útil.


## Palíndromo

Considere o problema de verificar se uma lista de números é um palíndromo (a lista tem os mesmos elementos quando lida da direita para a esquerda e da esquerda para a direita). \pause

Para verificar se `[5, 4, 1, 4]`{.gleam} é um palíndromo, o modelo sugere verificar se `[4, 1, 4]`{.gleam} é um palíndromo. \pause

Como a verificação se `[4, 1, 4]`{.gleam} é um palíndromo pode nos ajudar a determinar se `[5, 4, 1, 4]`{.gleam} é um palíndromo? \pause Ou seja, a solução para o resto pode nos ajudar a compor o resultado para o todo? \pause Não pode...


## Número primo

Considere o problema de verificar se um número natural $n$ é primo (tem exatamente dois divisores distintos, $1$ e $n$). \pause

Para verificar se $n = 13$ é primo, o modelo sugere verificar se $12$ é primo. \pause

Como a verificação se $12$ é primo pode nos ajudar a determinar se $13$ é primo? \pause Não pode...


## Limitações

O problema nos dois casos é o mesmo: a solução do problema original não pode ser obtida a partir da solução do subproblema gerado pela decomposição estrutural do dado. \pause

Como proceder nesse caso? \pause Temos algumas opções: \pause

- Criamos um plano: dividimos o problema em etapas e projetamos uma função auxiliar (possivelmente com recursão estrutural) para cada etapa; \pause

- Generalizamos o problema: projetamos uma função auxiliar que resolve um problema mais geral, no qual a recursão estrutural funciona, e resolvemos o problema original usando essa função; \pause

- Decompomos o problema em subproblema(s) de maneira não estrutural e utilizamos a solução desse(s) subproblema(s) para construir a solução do problema original.


Alternativas
============


## Plano

Para o problema do palíndromo, em vez de pensarmos em decompor o problema em um subproblema da mesma natureza, podemos criar um plano, uma sequência de etapas que resolvem problemas intermediários e que, ao final, produzem o resultado esperado. \pause

Por exemplo, podemos, primeiramente, inverter a lista e depois verificar se a lista de entrada e a lista invertida são iguais. \pause

Note que, para este caso, precisaríamos projetar uma nova função, a que inverte a lista, e ela pode ser implementada com recursão estrutural. A comparação pode ser feita com `==`{.gleam}, que em Gleam compara as listas elemento a elemento.


## Palíndromo com plano

\scriptsize

```gleam
/// Produz True se *lst* é um palíndromo, isto é, tem os mesmos elementos quando lida
/// da direita para a esquerda e da esquerda para a direita. Produz False caso contrário.
fn palindromo(lst: List(Int)) -> Bool {
  lst == list.reverse(lst)
}

fn palindromo_examples() {
  check.eq(palindromo([]), True)
  check.eq(palindromo([7]), True)
  check.eq(palindromo([7, 3]), False)
  check.eq(palindromo([3, 3]), True)
  check.eq(palindromo([3, 7, 3]), True)
  check.eq(palindromo([3, 7, 3, 3]), False)
}
```

\pause

\small

Exercício: implemente a função `reverse`.


## Generalização do problema

Para o problema do número primo, podemos resolver um problema mais geral: dados dois números naturais $n$ e $a \le n$, determinar a quantidade de divisores de $n$ que são $\le a$. \pause

Se temos a quantidade de divisores de $n$ que são $\le a - 1$, como obtemos a quantidade de divisores de $n$ que são $\le a$? \pause Somando 1 se $a$ é divisor de $n$. \pause

Como podemos utilizar essa função para determinar se um número $n$ é primo? \pause Com a expressão `num_divisores(n, n) == 2`{.gleam}. \pause

Assim como no plano, `primo`{.gleam} é composta com uma função auxiliar. A diferença é que a auxiliar resolve um problema mais geral que o necessário: a quantidade de divisores de $n$ é o caso específico `num_divisores(n, n)`{.gleam}.


## Número primo

<div class="columns">
<div class="column" width="55%">
\scriptsize

```gleam
/// Produz True se *n* é um número primo,
/// isto é, tem exatamente dois divisores
/// positivos distintos (1 e *n*).
/// Produz False caso contrário.
fn primo(n: Int) -> Bool {
  num_divisores(n, n) == 2
}

/// Calcula o número de divisores positivos
/// de *n* que são menores ou iguais a *a*.
fn num_divisores(n: Int, a: Int) -> Int {
  case a {
    _ if a <= 0 -> 0
    _ if n % a == 0 -> 1 + num_divisores(n, a - 1)
    _ -> num_divisores(n, a - 1)
  }
}
```

</div>
<div class="column" width="40%">
\scriptsize

```gleam
fn primo_examples() {
  check.eq(primo(1), False)
  check.eq(primo(2), True)
  check.eq(primo(3), True)
  check.eq(primo(4), False)
  check.eq(primo(5), True)
  check.eq(primo(6), False)
  check.eq(primo(7), True)
  check.eq(primo(8), False)
}

fn num_divisores_examples() {
  check.eq(num_divisores(6, 0), 0)
  check.eq(num_divisores(6, 4), 3)
  check.eq(num_divisores(6, 5), 3)
  check.eq(num_divisores(6, 6), 4)
}
```
</div>
</div>


## Decomposição não estrutural

Também podemos resolver o problema do palíndromo decompondo a entrada de outra forma. Considere a entrada `[4, 1, 5, 1, 4]`{.gleam}.

Como podemos obter um subproblema da entrada de maneira que a resposta para o subproblema possa nos ajudar a compor a resposta para o problema original? \pause Removendo o primeiro e último elemento da lista. \pause

Se sabemos que uma lista `lst` sem o primeiro e o último elemento é um palíndromo, como determinar se `lst` é um palíndromo? \pause Verificando se o primeiro e o último elemento de `lst` são iguais.


## Palíndromo com decomposição não estrutural

\scriptsize

```gleam
/// Produz True se *lst* é um palíndromo, isto é, tem os mesmos elementos quando lida
/// da direita para a esquerda e da esquerda para a direita. Produz False caso contrário.
fn palindromo(lst: List(Int)) -> Bool {
  case lst {
    [] | [_] -> True
    [primeiro, ..] ->
      Ok(primeiro) == list.last(lst) && palindromo(sem_extremos(lst))
  }
}

fn palindromo_examples() {
  check.eq(palindromo([]), True)
  check.eq(palindromo([7]), True)
  check.eq(palindromo([7, 3]), False)
  check.eq(palindromo([3, 3]), True)
  check.eq(palindromo([3, 7, 3]), True)
  check.eq(palindromo([3, 7, 3, 3]), False)
}
```

\small

\pause

Exercício: implemente a função `sem_extremos`.


## Recursão estrutural e generativa

Funções recursivas que operam em subproblemas obtidos pela decomposição estrutural dos dados são chamadas de **funções recursivas estruturais**. \pause

Funções recursivas que operam em subproblemas arbitrários (não estruturais) são chamadas de **funções recursivas generativas**. \pause

O projeto de funções recursivas generativas pode requerer um "_insight_" e por isso tentamos primeiramente resolver os problemas com recursão estrutural.


Revisão
=======


## Revisão

O que é recursão estrutural? \pause

- É a recursão feita nas partes do dado que são autorreferências na definição do tipo, como o resto de uma lista ou `n - 1`{.gleam} para um número natural. \pause

Quando a recursão estrutural não resolve um problema diretamente? \pause

- Quando a solução do problema não pode ser obtida a partir da solução do subproblema estrutural, como no palíndromo e no número primo.


## Revisão

Quais alternativas podemos usar nesses casos? \pause

- Criar um plano, uma sequência de etapas resolvidas por funções auxiliares (inverter a lista e comparar); \pause
- Generalizar o problema, projetando uma função auxiliar que resolve um problema mais geral e usando essa função para resolver o problema original (quantidade de divisores até $a$ para o número primo); \pause
- Decompor o problema de forma não estrutural, com recursão generativa (palíndromo sem os extremos). \pause

Por que tentamos primeiro a recursão estrutural? \pause

- Porque o modelo guia a implementação, enquanto a recursão generativa pode exigir um _insight_.


Referências
===========

## Referências

Básicas

- Seções [11.2 a 11.4](https://htdp.org/2022-8-7/Book/part_two.html#%28part._sec~3acompounding2%29) do livro [HTDP](http://htdp.org)

Complementares

- Capítulos [25 e 26](https://htdp.org/2022-8-7/Book/part_five.html) do livro [HTDP](http://htdp.org) (em especial a seção [26.3](https://htdp.org/2022-8-7/Book/part_five.html#%28part._sec~3astruct-gen-rec%29), recursão estrutural × generativa)
