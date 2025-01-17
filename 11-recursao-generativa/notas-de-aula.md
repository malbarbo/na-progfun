---
# vim: set spell spelllang=pt_br sw=4:
title: Recursão generativa
# TODO: mais exemplos
# TODO: colocar explicação quickosrt, término, elementos repetidos
---

Introdução
==========

## Introdução

Vimos anteriormente como explorar a forma como um dado com autorreferência é definido para implementar funções que processam esse tipo de dado: \pause

- Uma autorreferência na definição do tipo do dado sugere uma chamada recursiva na implementação da função \pause

Como nesses casos a chamada recursiva é feita em uma parte da estrutura do dado a recursão é chamada de **recursão estrutural**.


## Introdução

Também vimos anteriormente que a recursão estrutural tem limitações e nem todos os problemas podem ser resolvidos com ela. \pause

Discutimos rapidamente que para esses problemas precisamos utilizar outra abordagem: \pause

- Decompor o problema inicial em subproblemas
- Resolver os subproblemas
- Combinar as soluções dos subproblemas em uma solução para o problema inicial\pause

Se alguns dos subproblemas gerados são do mesmo tipo do problema inicial, podemos usar chamadas recursivas para resolver esses subproblemas, nesses casos, a recursão é chamada de **recursão generativa**.


## Introdução

A recursão generativa é mais poderosa que a recursão estrutural, \pause porém, \pause projetar funções que usam recursão generativa não é um processo tão direto quando funções que usam recursão estrutural. \pause A etapa principal é "gerar" os subproblemas, e isto pode requerer um momento "eureka". \pause

De qualquer forma, o processo de projeto de funções, com alguns ajustes, também serve para projetar funções com recursão generativa. \pause

Vamos ver alguns exemplos.



Projeto de funções generativas
==============================


## Exemplo: agrupamento

Dado uma lista de números e um número positivo $n$, projete uma função que agrupe os elementos da lista de entrada em grupos (listas) de $n$ elementos.


## Exemplo: agrupamento {.t}

\scriptsize

```gleam
/// Agrupa os elementos de *lst* em sublistas com *n* elementos. Apenas a
/// última sublista pode ter menos de *n* elementos.
fn agrupa(lst: List(a), n: Int) -> List(List(a)) {
  todo
}
fn agrupa_examples() {
  check.eq(agrupa([], 2), [])
  check.eq(agrupa([4, 1, 5], 1), [[4], [1], [5]])
  check.eq(agrupa([4, 1, 5, 7, 8], 2), [[4, 1], [5, 7], [8]])
  check.eq(agrupa([4, 1, 5, 7, 8], 3), [[4, 1, 5], [7, 8]])
}
```


## Exemplo: agrupamento {.t}

\scriptsize

```gleam
/// Agrupa os elementos de *lst* em sublistas com *n* elementos. Apenas a
/// última sublista pode ter menos de *n* elementos.
fn agrupa(lst: List(a), m: Int) -> List(List(a)) {
  case {
    [] -> todo
    _ -> {
      // decompor em um suproblema
      // resolver recursivamente
      // estender a solução recursiva
      todo
      agrupa(todo, m)
    }
  }
}
```

## Exemplo: agrupamento {.t}

\scriptsize

```gleam
/// Agrupa os elementos de *lst* em sublistas com *m* elementos. Apenas a
/// última sublista pode ter menos de *n* elementos.
fn agrupa(lst: List(a), m: Int) -> List(List(a)) {
  case {
    [] -> []
    _ -> {
      let #(prefixo, suffixo) = list.split(lst, m)
      [prefixo, ..agrupa(suffixo, m)]
    }
  }
}
```

\pause

\normalsize

Qual é a equação de recorrência que descreve o tempo de execução da função agrupa? \pause

$T(n) = T(n - m) + m$

\pause

Se $m = 1$, então $T(n) = T(n - 1) + 1 \pause = O(n)$ \pause

Se $m \ge n$, então $T(n) = T(0) + O(n) \pause = O(n)$


## Exemplo: quicksort

Defina uma função que ordene uma lista de números usando o algoritmo de ordenação _quicksort_. \pause

Qual é a ideia do _quicksort_? \pause

- Separar os elementos da entrada, se ela não for trivial, em duas listas: uma com os menores do que o primeiro e outra com os maiores do que o primeiro \pause

- Ordenar as duas listas recursivamente \pause

- Juntar a ordenação dos menores, com o primeiro e com a ordenação dos maiores.


## Exemplo: quicksort {.t}

\scriptsize

```gleam
/// Ordena *lst* em ordem não decrescente usando o algoritmo quicksort.
fn quicksort(lst: List(Int)) -> List(Int) {
  todo
}

fn quicksort_examples() {
  check.eq(quicksort([]), [])
  check.eq(quicksort([3]), [3])
  check.eq(quicksort([10, 3, -4, 5, 9]), [-4, 3, 5, 9, 10])
  check.eq(quicksort([3, 10, 0, 5, 9]), [0, 3, 5, 9, 10])
}
```


## Exemplo: quicksort {.t}

\scriptsize

```gleam
/// Ordena *lst* em ordem não decrescente usando o algoritmo quicksort.
fn quicksort(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [pivo, ..resto] -> {
      // decompor em subproblemas
      // resolver os subproblemas recursivamente
      // combinar as soluções recursivas
      todo
    }
  }
}
```


## Exemplo: quicksort {.t}

\scriptsize

```gleam
/// Ordena *lst* em ordem não decrescente usando o algoritmo quicksort.
fn quicksort(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [pivo, ..resto] -> {
      let maiores = list.filter(lst, fn(x) { x >= pivo })
      let menores = list.filter(lst, fn(x) { x < pivo })
      list.append(quicksort(menores), quicksort(maiores))
    }
  }
}
```

\pause

\normalsize

A funciona `quicksort` funciona corretamente para qualquer entrada? \pause Não. \pause Se todos os elementos forem iguais, a função será executada recursivamente para a lista de entrada e não terminará a execução.


## Exemplo: quicksort {.t}

\scriptsize

```gleam
/// Ordena *lst* em ordem não decrescente usando o algoritmo quicksort.
fn quicksort(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [pivo, ..resto] -> {
      let maiores = list.filter(resto, fn(x) { x >= pivo })
      let menores = list.filter(resto, fn(x) { x < pivo })
      list.append(quicksort(menores), [pivo, ..quicksort(maiores)])
    }
  }
}
```

\pause

\normalsize

Qual é a equação de recorrência que descreve o tempo de execução da função agrupa? \pause Depende de como a lista é particionada. \pause

<div class="columns">
<div class="column" width="48%">
No pior caso

$T(n) = T(n - 1) + T(0) + O(n) \pause = O(n^2)$ \pause

</div>
<div class="column" width="48%">

No melhor caso

$T(n) = 2T(n/2) + O(n) \pause = O(n\lg n)$

</div>
</div>


## Processo de projeto para funções recursivas generativas

O que precisamos ajustar no processo de projeto de funções? \pause

Na etapa de implementação temos que: \pause

- Definir como decompor o problema em subproblemas que são mais facilmente resolvidos do que o problema original \pause

- Definir como combinar as soluções dos subproblemas para resolver o problema inicial \pause

- Argumentar que a função termina para todas as entradas


## Referências

Básicas

- [Parte 5](https://htdp.org/2023-8-14/Book/part_five.html) do livro [HTDP](https://htdp.org/).
