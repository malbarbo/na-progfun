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

Considere o problema de verificar se um número natural $n$ é primo (tem exatamente dois divisores positivos distintos, $1$ e $n$). \pause

Para verificar se $n = 13$ é primo, o modelo sugere verificar se $12$ é primo. \pause

Como a verificação se $12$ é primo pode nos ajudar a determinar se $13$ é primo? \pause Não pode...


## Limitações

O problema nos dois casos é o mesmo: a solução do problema original não pode ser obtida a partir da solução do subproblema sugerido pelo modelo, isto é, a autorreferência do dado (o resto da lista, $n - 1$). \pause

Como proceder nesse caso?


## Limitações

Temos algumas opções: \pause

- Generalizamos o problema: projetamos uma função auxiliar que resolve um problema mais geral, no qual a recursão estrutural funciona, e resolvemos o problema original usando essa função; \pause

- Criamos um plano: dividimos o problema em etapas, cada uma resolvida por uma expressão, por uma função existente ou por uma nova função auxiliar (possivelmente com recursão estrutural); a função original combina essas etapas, sem ser recursiva; \pause

- Decompomos o problema em subproblemas da mesma natureza (decomposição generativa): geramos, a partir da entrada, um ou mais subproblemas (o mesmo problema para outras entradas) diferentes do sugerido pelo modelo, e a função chama a si mesma com eles para construir a solução do problema original.


Alternativas
============


## Generalização do problema

Para o problema do número primo, podemos resolver um problema mais geral: dados dois números naturais $n$ e $a \le n$, determinar a quantidade de divisores de $n$ que são $\le a$. \pause

Por exemplo, para $n = 6$ e $a = 4$, a resposta é $3$ (os divisores $1$, $2$ e $3$). Como $a$ é um número natural, o modelo sugere resolver o problema para $n = 6$ e $a = 3$. \pause

A resposta para $a = 3$ ajuda a determinar a resposta para $a = 4$? \pause Sim! Como $4$ não é divisor de $6$, a resposta é a mesma ($3$). Se $a$ fosse divisor de $n$, bastaria somar $1$. \pause

Em geral, se temos a quantidade de divisores de $n$ que são $\le a - 1$, obtemos a quantidade de divisores de $n$ que são $\le a$ somando 1 se $a$ é divisor de $n$.


## Generalização do problema

Como podemos utilizar essa função para determinar se um número $n$ é primo? \pause Com a expressão `num_divisores(n, n) == 2`{.gleam}. \pause

Note que `primo`{.gleam} não é recursiva: a recursão (estrutural) fica na função auxiliar, que resolve um problema mais geral que o necessário. A quantidade de divisores de $n$ é o caso específico `num_divisores(n, n)`{.gleam}.


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


## Plano

Para o problema do palíndromo, em vez de pensarmos em decompor o problema em um subproblema da mesma natureza, podemos criar um plano: uma sequência de etapas, cada uma produzindo um valor intermediário a partir da entrada ou de etapas anteriores, até chegar ao resultado. \pause

Plano para o palíndromo:

- `rev`: a lista `lst` com os elementos em ordem inversa (podemos usar `list.reverse`{.gleam} da biblioteca padrão, que poderíamos implementar com recursão estrutural); \pause
- `lst` é palíndromo se `lst` e `rev` são iguais (podemos usar `==`{.gleam}, que em Gleam compara as listas elemento a elemento). \pause

Assim como na generalização, `palindromo`{.gleam} não é recursiva: ela combina as etapas, e a recursão fica nas funções usadas. A diferença é que cada etapa resolve uma parte diferente do problema (inverter, comparar), e não uma versão mais geral do problema.


## Palíndromo com plano

\scriptsize

```gleam
/// Produz True se *lst* é um palíndromo, isto é, tem os mesmos elementos quando lida
/// da direita para a esquerda e da esquerda para a direita. Produz False caso contrário.
fn palindromo(lst: List(Int)) -> Bool {
  // lst com os elementos em ordem inversa
  let rev = list.reverse(lst)
  // lst é palíndromo se lst e rev são iguais
  lst == rev
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


## Decomposição generativa

Também podemos resolver o problema do palíndromo de forma recursiva, mas usando um subproblema diferente do sugerido pelo modelo (o resto da lista). Considere a entrada `[4, 1, 5, 1, 4]`{.gleam}. \pause

Que subproblema, da mesma natureza, pode nos ajudar a compor a resposta para o problema original? \pause Verificar se `[1, 5, 1]`{.gleam}, a lista sem o primeiro e o último elemento, é um palíndromo. \pause

Se sabemos que `[1, 5, 1]`{.gleam} é um palíndromo, como determinar se `[4, 1, 5, 1, 4]`{.gleam} é um palíndromo? \pause Verificando se o primeiro e o último elemento são iguais. \pause

Ou seja, `palindromo`{.gleam} chama a si mesma com a lista sem os extremos, e não com o resto da lista. \pause

Para obter o último elemento, usamos `list.last`{.gleam}, que produz `Ok`{.gleam} com o último elemento da lista, ou `Error(Nil)`{.gleam} se a lista é vazia. Para obter a lista sem os extremos, supomos que existe uma função `sem_extremos`{.gleam}.


## Palíndromo com decomposição generativa

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


## Plano × decomposição generativa

As duas soluções do palíndromo usam funções auxiliares, mas de maneiras diferentes. \pause

No plano, `palindromo`{.gleam} não chama a si mesma. O problema é dividido em etapas (inverter e comparar) e a recursão fica em `list.reverse`{.gleam}, que é estrutural. \pause

Na decomposição generativa, `palindromo`{.gleam} chama a si mesma com um subproblema da mesma natureza (verificar se outra lista é um palíndromo), mas que não é o resto da lista. As auxiliares (`list.last`{.gleam} e `sem_extremos`{.gleam}) não resolvem etapas do problema, apenas ajudam a construir o subproblema e a combinar o resultado.


## Recursão estrutural e generativa

Funções recursivas que chamam a si mesmas com as autorreferências do dado, isto é, com os subproblemas sugeridos pelo modelo, são chamadas de **funções recursivas estruturais**. \pause

Funções recursivas que usam uma decomposição generativa, isto é, chamam a si mesmas com subproblemas gerados a partir da entrada, como no palíndromo sem os extremos, são chamadas de **funções recursivas generativas**. \pause

O projeto de funções recursivas generativas pode requerer um "_insight_" e por isso tentamos primeiramente resolver os problemas com recursão estrutural. \pause

Apesar disso, o processo de projeto de funções que estamos usando também é útil para projetar funções com recursão generativa, com alguns ajustes. Vamos estudar a recursão generativa no capítulo **Recursão generativa**.


Revisão
=======


## Revisão

Quando a recursão estrutural não resolve um problema diretamente? \pause

- Quando a solução do problema não pode ser obtida a partir da solução do subproblema sugerido pelo modelo, como no palíndromo e no número primo. \pause

Quais alternativas podemos usar nesses casos? \pause

- Generalizar o problema, projetando uma função auxiliar que resolve um problema mais geral e usando essa função para resolver o problema original (quantidade de divisores até $a$ para o número primo); \pause
- Criar um plano, uma sequência de etapas resolvidas por expressões ou funções (a lista invertida e a comparação com a entrada); \pause
- Usar uma decomposição generativa (palíndromo sem os extremos).


## Revisão

O que é recursão generativa? \pause

- É a recursão em que a função chama a si mesma com subproblemas gerados a partir da entrada, diferentes dos sugeridos pelo modelo, como a lista sem os extremos no palíndromo. \pause

Por que tentamos primeiro a recursão estrutural? \pause

- Porque o modelo guia a implementação, enquanto a recursão generativa pode exigir um _insight_.


## Revisão

Qual a diferença entre resolver um problema com um plano e com uma decomposição generativa? \pause

- No plano, a função não é recursiva: o problema é dividido em etapas, cada uma resolvida por uma expressão ou função, e a função combina essas etapas. Na decomposição generativa, a função chama a si mesma com subproblemas da mesma natureza, gerados a partir da entrada, mas diferentes do sugerido pelo modelo.


Referências
===========

## Referências

Básicas

- Seções [11.2 a 11.4](https://htdp.org/2022-8-7/Book/part_two.html#%28part._sec~3acompounding2%29) do livro [HTDP](http://htdp.org)

- Seção [12.3](https://htdp.org/2022-8-7/Book/part_two.html#%28part._sec~3apermute-composition%29) do livro [HTDP](http://htdp.org) (projeto por composição)

Complementares

- Capítulos [25 e 26](https://htdp.org/2022-8-7/Book/part_five.html) do livro [HTDP](http://htdp.org) (em especial a seção [26.3](https://htdp.org/2022-8-7/Book/part_five.html#%28part._sec~3astruct-gen-rec%29), recursão estrutural × generativa)
