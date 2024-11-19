---
# vim: set spell spelllang=pt_br sw=4:
title: Autorreferência e recursividade
subtitle: Parte II
# TODO: trocar o termo lista aninhada para árvores?
# TODO: ou colocar linhas aninhada antes de árvore binária?
# TODO: definir decomposição estrutural
---


Números Naturais
================


## Introdução

Um número natural é atômico ou composto? \pause

- Atômico quando usado em operações aritméticas, comparações, etc; \pause

- Composto quando uma iteração precisa ser feita baseado no valor do número.

\pause

Se um número natural pode ser visto como dado composto \pause

- Quais são as partes que compõe o número? \pause

- Como (de)compor um número?


## Definição

<div class="columns">
<div class="column" width="48%">

Um número **Natural** é \pause

- `0`{.gleam}; ou \pause

- `n + 1`{.gleam} onde $n$ é um número **Natural**

\pause

\ \

Baseado nesta definição, criamos um modelo para funções com números naturais.

</div>
<div class="column" width="48%">

\pause

\footnotesize

```gleam
fn fn_para_natural(n: Int) {
  case n {
    // Necessário porque gleam
    // não tem números naturais
    _ if n < 0 -> todo
    0 -> todo
    _ -> {
      todo
      n
      fn_para_natural(n - 1)
    }
  }
}
```

</div>
</div>


## Exemplo: soma naturais

Dado um número natural $n$, defina uma função que some os números naturais menores ou iguais a $n$.


## Exemplo: soma naturais {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Devolve a soma 1 + 2 + ... + n.
pub fn soma_nat(n: Int) -> Int {
  todo
}
```

\pause
</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn soma_nat_examples() {
  check.eq(soma_nat(-1), 0)
  check.eq(soma_nat(0), 0)
  check.eq(soma_nat(1), 1)
  check.eq(soma_nat(3), 6)
  check.eq(soma_nat(4), 10)
}
```
</div>
</div>


## Exemplo: soma naturais {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Devolve a soma 1 + 2 + ... + n.
pub fn soma_nat(n: Int) -> Int {
  case n {
    _ if n < 0 -> todo
    0 -> todo
    _ -> {
      todo
      n
      soma_nat(n - 1)
    }
  }
}
```

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn soma_nat_examples() {
  check.eq(soma_nat(-1), 0)
  check.eq(soma_nat(0), 0)
  check.eq(soma_nat(1), 1)
  check.eq(soma_nat(3), 6)
  check.eq(soma_nat(4), 10)
}
```
</div>
</div>


## Exemplo: soma naturais {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Devolve a soma 1 + 2 + ... + n.
pub fn soma_nat(n: Int) -> Int {
  case n {
    _ if n <= 0 -> 0
    _ -> {
      todo
      n
      soma_nat(n - 1)
    }
  }
}
```

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn soma_nat_examples() {
  check.eq(soma_nat(-1), 0)
  check.eq(soma_nat(0), 0)
  check.eq(soma_nat(1), 1)
  check.eq(soma_nat(3), 6)
  check.eq(soma_nat(4), 10)
}
```
</div>
</div>


## Exemplo: soma naturais {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Devolve a soma 1 + 2 + ... + n.
pub fn soma_nat(n: Int) -> Int {
  case n {
    _ if n <= 0 -> 0
    _ -> n + soma_nat(n - 1)
  }
}
```

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn soma_nat_examples() {
  check.eq(soma_nat(-1), 0)
  check.eq(soma_nat(0), 0)
  check.eq(soma_nat(1), 1)
  check.eq(soma_nat(3), 6)
  check.eq(soma_nat(4), 10)
}
```
</div>
</div>


## Exemplo: lista de números

Dado um número natural $n$, defina uma função que devolva `[1, 2, ..., n - 1, n]`{.gleam}.


## Exemplo: lista de números {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Cria uma lista com os valores
/// 1, 2, ..., n-1, n.
pub fn lista_num(n: Int) -> List(Int) {
  []
}
```

\pause

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn lista_num_examples() {
  check.eq(lista_num(-1), [])
  check.eq(lista_num(0), [])
  check.eq(lista_num(1), [1])
  check.eq(lista_num(2), [1, 2])
  check.eq(lista_num(3), [1, 2, 3])
}
```
</div>
</div>


## Exemplo: lista de números {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Cria uma lista com os valores
/// 1, 2, ..., n-1, n.
pub fn lista_num(n: Int) -> List(Int) {
  case n {
    _ if n < 0 -> todo
    0 -> todo
    _ -> {
      todo
      n
      lista_num(n - 1)
    }
  }
}
```

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn lista_num_examples() {
  check.eq(lista_num(-1), [])
  check.eq(lista_num(0), [])
  check.eq(lista_num(1), [1])
  check.eq(lista_num(2), [1, 2])
  check.eq(lista_num(3), [1, 2, 3])
}
```
</div>
</div>


## Exemplo: lista de números {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Cria uma lista com os valores
/// 1, 2, ..., n-1, n.
pub fn lista_num(n: Int) -> List(Int) {
  case n {
    _ if n <= 0 -> []
    _ -> {
      todo
      n
      lista_num(n - 1)
    }
  }
}
```

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn lista_num_examples() {
  check.eq(lista_num(-1), [])
  check.eq(lista_num(0), [])
  check.eq(lista_num(1), [1])
  check.eq(lista_num(2), [1, 2])
  check.eq(lista_num(3), [1, 2, 3])
}
```
</div>
</div>


## Exemplo: lista de números {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Cria uma lista com os valores
/// 1, 2, ..., n-1, n.
pub fn lista_num(n: Int) -> List(Int) {
  case n {
    _ if n <= 0 -> []
    _ -> adiciona_fim(lista_num(n - 1), n)
  }
}
```

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn lista_num_examples() {
  check.eq(lista_num(-1), [])
  check.eq(lista_num(0), [])
  check.eq(lista_num(1), [1])
  check.eq(lista_num(2), [1, 2])
  check.eq(lista_num(3), [1, 2, 3])
}
```
</div>
</div>


## Exemplo: adiciona fim {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Adiciona *n* ao final de *lst*.
pub fn adiciona_fim(
  lst: List(Int),
  n: Int,
) -> List(Int) {
  []
}
```

\pause

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn adiciona_fim_examples() {
  check.eq(adiciona_fim([], 3), [3])
  check.eq(adiciona_fim([3], 4), [3, 4])
  check.eq(adiciona_fim([3, 4], 1), [3, 4, 1])
}
```
</div>
</div>


## Exemplo: adiciona fim {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Adiciona *n* ao final de *lst*.
pub fn adiciona_fim(
  lst: List(Int),
  n: Int,
) -> List(Int) {
  case lst {
    [] -> { todo n }
    [primeiro, ..resto] -> {
      todo
      n
      primeiro
      adiciona_fim(resto, n)
    }
  }
}
```

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn adiciona_fim_examples() {
  check.eq(adiciona_fim([], 3), [3])
  check.eq(adiciona_fim([3], 4), [3, 4])
  check.eq(adiciona_fim([3, 4], 1), [3, 4, 1])
}
```
</div>
</div>


## Exemplo: adiciona fim {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Adiciona *n* ao final de *lst*.
pub fn adiciona_fim(
  lst: List(Int),
  n: Int,
) -> List(Int) {
  case lst {
    [] -> [n]
    [primeiro, ..resto] -> {
      todo
      n
      primeiro
      adiciona_fim(resto, n)
    }
  }
}
```

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn adiciona_fim_examples() {
  check.eq(adiciona_fim([], 3), [3])
  check.eq(adiciona_fim([3], 4), [3, 4])
  check.eq(adiciona_fim([3, 4], 1), [3, 4, 1])
}
```
</div>
</div>


## Exemplo: adiciona fim {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Adiciona *n* ao final de *lst*.
pub fn adiciona_fim(
  lst: List(Int),
  n: Int,
) -> List(Int) {
  case lst {
    [] -> [n]
    [primeiro, ..resto] ->
      [primeiro,
       ..adiciona_fim(resto, n)]
  }
}
```

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn adiciona_fim_examples() {
  check.eq(adiciona_fim([], 3), [3])
  check.eq(adiciona_fim([3], 4), [3, 4])
  check.eq(adiciona_fim([3, 4], 1), [3, 4, 1])
}
```
</div>
</div>


Inteiros
========


## Definição

Às vezes queremos utilizar um caso base diferente de $0$. \pause

Podemos generalizar a definição de número natural para incluir um limite inferior diferente de $0$.


## Definição Inteiro

<div class="columns">
<div class="column" width="48%">
Um número **Inteiro menor igual à x** é

- `x`{.gleam}; ou

- `n + 1`{.gleam} onde `n`{.gleam} é um número **Inteiro menor igual à x**.

\pause
</div>
<div class="column" width="48%">

\footnotesize

```gleam
fn fn_para_inteiro_lt_x(n: Int) {
  case n {
    _ if n < x -> todo
    _ if n == x -> todo
    _ -> {
      todo
      x
      fn_para_inteiro_lt_x(n - 1)
    }
  }
}
```

</div>
</div>


Árvores binárias
================


## Árvores binárias

Como podemos definir uma árvore binária?

```
        3
      /   \
     4     7
    /     / \
   3     8   9
            /
           10
```


## Árvores binárias

<div class="columns">
<div class="column" width="56%">

\small

Uma **Árvore binária** é \pause

- Vazia; ou \pause

- Um nó contendo um número e **árvores binárias** a esquerda e a direita.

\pause

\footnotesize

\ \

```gleam
type Arvore {
  Vazia
  No(valor: Int, esq: Arvore, dir: Arvore)
}
```

\pause

</div>
<div class="column" width="42%">

Modelo de função para árvores binárias

\footnotesize

```gleam
fn fn_para_ab(arv: Arvore) {
  case arv {
    Vazia -> todo
    No(valor, esq, dir) -> {
      todo
      valor
      fn_para_ab(esq)
      fn_para_ab(dir)
    }
  }
}
```

</div>
</div>


## Exemplo: nós folhas

Projete uma função que determine a quantidade de nós folhas em uma árvore.


## Exemplo: nós folhas {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Determina o número de nós folhas
/// de *avr*.
fn num_folhas(arv: Arvore) -> Int {
  0
}

```

\pause

</div>
<div class="column" width="48%">

\scriptsize

```gleam
pub fn num_folhas_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     / \   / \
  //    3   2 8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), No(2, Vazia, Vazia))
  let t4 = No(3, t3, t2)
  check.eq(num_folhas(Vazia), 0)
  check.eq(num_folhas(t0), 1)
  check.eq(num_folhas(t1), 1)
  check.eq(num_folhas(t2), 2)
  check.eq(num_folhas(t3), 2)
  check.eq(num_folhas(t4), 4)
}
```

</div>
</div>


## Exemplo: nós folhas {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Determina o número de nós folhas
/// de *avr*.
fn num_folhas(arv: Arvore) -> Int {
  case arv {
    Vazia -> todo
    No(valor, esq, dir) -> {
      todo
      valor
      num_folhas(esq)
      num_folhas(dir)
    }
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
pub fn num_folhas_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     / \   / \
  //    3   2 8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), No(2, Vazia, Vazia))
  let t4 = No(3, t3, t2)
  check.eq(num_folhas(Vazia), 0)
  check.eq(num_folhas(t0), 1)
  check.eq(num_folhas(t1), 1)
  check.eq(num_folhas(t2), 2)
  check.eq(num_folhas(t3), 2)
  check.eq(num_folhas(t4), 4)
}
```

</div>
</div>


## Exemplo: nós folhas {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Determina o número de nós folhas
/// de *avr*.
fn num_folhas(arv: Arvore) -> Int {
  case arv {
    Vazia -> 0
    No(valor, esq, dir) -> {
      todo
      valor
      num_folhas(esq)
      num_folhas(dir)
    }
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
pub fn num_folhas_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     / \   / \
  //    3   2 8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), No(2, Vazia, Vazia))
  let t4 = No(3, t3, t2)
  check.eq(num_folhas(Vazia), 0)
  check.eq(num_folhas(t0), 1)
  check.eq(num_folhas(t1), 1)
  check.eq(num_folhas(t2), 2)
  check.eq(num_folhas(t3), 2)
  check.eq(num_folhas(t4), 4)
}
```

</div>
</div>


## Exemplo: nós folhas {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Determina o número de nós folhas
/// de *avr*.
fn num_folhas(arv: Arvore) -> Int {
  case arv {
    Vazia -> 0
    No(_, esq, dir) ->
      case esq, dir {
        Vazia, Vazia -> 1
        _, _ ->
          num_folhas(esq) + num_folhas(dir)
      }
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
pub fn num_folhas_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     / \   / \
  //    3   2 8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), No(2, Vazia, Vazia))
  let t4 = No(3, t3, t2)
  check.eq(num_folhas(Vazia), 0)
  check.eq(num_folhas(t0), 1)
  check.eq(num_folhas(t1), 1)
  check.eq(num_folhas(t2), 2)
  check.eq(num_folhas(t3), 2)
  check.eq(num_folhas(t4), 4)
}
```

</div>
</div>


## Exemplo: nós folhas {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Determina o número de nós folhas
/// de *avr*.
fn num_folhas(arv: Arvore) -> Int {
  case arv {
    Vazia -> 0
    No(_, Vazia, Vazia) -> 1
    No(_, esq, dir) ->
      num_folhas(esq) + num_folhas(dir)
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
pub fn num_folhas_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     / \   / \
  //    3   2 8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), No(2, Vazia, Vazia))
  let t4 = No(3, t3, t2)
  check.eq(num_folhas(Vazia), 0)
  check.eq(num_folhas(t0), 1)
  check.eq(num_folhas(t1), 1)
  check.eq(num_folhas(t2), 2)
  check.eq(num_folhas(t3), 2)
  check.eq(num_folhas(t4), 4)
}
```

</div>
</div>



## Exemplo: altura árvore

Defina uma função que determina a altura de uma árvore binária. A altura de uma árvore binária é a distância entre a raiz e o seu descendente mais afastado. Uma árvore com um único nó tem altura 0.


## Exemplo: altura árvore {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve a altura de *avr*. A altura de uma
/// árvore binária é a distância da raiz a seu
/// descendente mais afastado. Uma árvore com
/// um único nó tem altura 0.
fn altura(arv: Arvore) -> Int {
  0
}

```

\pause

</div>
<div class="column" width="48%">

\scriptsize

```gleam
pub fn altura_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     /     / \
  //    3     8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), Vazia)
  let t4 = No(3, t3, t2)
  check.eq(altura(Vazia), todo)
  check.eq(altura(t0), 0)
  check.eq(altura(t1), 1)
  check.eq(altura(t2), 2)
  check.eq(altura(t3), 1)
  check.eq(altura(t4), 3)
}
```

</div>
</div>


## Exemplo: altura árvore {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve a altura de *avr*. A altura de uma
/// árvore binária é a distância da raiz a seu
/// descendente mais afastado. Uma árvore com
/// um único nó tem altura 0.
fn altura(arv: Arvore) -> Int {
  case arv {
    Vazia -> todo
    No(valor, esq, dir) -> {
      todo
      valor
      altura(esq)
      altura(dir)
    }
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
pub fn altura_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     /     / \
  //    3     8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), Vazia)
  let t4 = No(3, t3, t2)
  check.eq(altura(Vazia), todo)
  check.eq(altura(t0), 0)
  check.eq(altura(t1), 1)
  check.eq(altura(t2), 2)
  check.eq(altura(t3), 1)
  check.eq(altura(t4), 3)
}
```

</div>
</div>


## Exemplo: altura árvore {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve a altura de *avr*. A altura de uma
/// árvore binária é a distância da raiz a seu
/// descendente mais afastado. Uma árvore com
/// um único nó tem altura 0.
fn altura(arv: Arvore) -> Int {
  case arv {
    Vazia -> todo
    No(valor, esq, dir) ->
      1 + int.max(altura(esq), altura(dir))
    }
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
pub fn altura_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     /     / \
  //    3     8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), Vazia)
  let t4 = No(3, t3, t2)
  check.eq(altura(Vazia), todo)
  check.eq(altura(t0), 0)
  check.eq(altura(t1), 1)
  check.eq(altura(t2), 2)
  check.eq(altura(t3), 1)
  check.eq(altura(t4), 3)
}
```

</div>
</div>


## Exemplo: altura árvore {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve a altura de *avr*. A altura de uma
/// árvore binária é a distância da raiz a seu
/// descendente mais afastado. Uma árvore com
/// um único nó tem altura 0 e uma árvore vazia
/// tem altura -1.
fn altura(arv: Arvore) -> Int {
  case arv {
    Vazia -> -1
    No(valor, esq, dir) ->
      1 + int.max(altura(esq), altura(dir))
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
pub fn altura_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     /     / \
  //    3     8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), Vazia)
  let t4 = No(3, t3, t2)
  check.eq(altura(Vazia), -1)
  check.eq(altura(t0), 0)
  check.eq(altura(t1), 1)
  check.eq(altura(t2), 2)
  check.eq(altura(t3), 1)
  check.eq(altura(t4), 3)
}
```

</div>
</div>


Árvores
=======


## Árvores

<div class="columns">
<div class="column" width="45%">
Projete um tipo de dado para representar um diretório ou arquivo em um sistema de arquivos em seguida: \pause

a) Projete uma função para encontrar os caminhos para todos os arquivos txt. \pause

a) projeto uma função para existir um o conteúdo de um diretório em formato de árvore. \pause

</div>
<div class="column" width="45%">
\footnotesize

```
disciplinas/
+- 12026/
|  +- alunos.txt
|  +- trabs/
|     +- trab1.md
|     +- correcoes/
|     |  +- rascunho.txt
|     |  +- final.txt
|     +- trab2.md
+- 6879/
+- 6884/
+- anotacoes.txt
```

</div>
</div>


## Árvores {.t}

<div class="columns">
<div class="column" width="48%">

\small

Uma **entrada** no sistema de arquivos é: \pause

- Uma arquivo com um nome; ou \pause
- Um diretório com um nome é um **lista de entradas**.

\pause

\ \

Uma **lista de entradas** é: \pause

- Vazia; ou \pause
- Um par com o primeiro e o resto, onde o primeiro é uma **entrada** e o resto é uma **lista de entradas**.

\pause

</div>
<div class="column" width="48%">

\scriptsize

```gleam
type Entrada {
  Arq(String)
  Dir(String, List(Entrada))
}
```

</div>
</div>


## Árvores {.t}

<div class="columns">
<div class="column" width="48%">

\scriptsize

```
disciplinas/
+- 12026/
|  +- alunos.txt
|  +- trabs/
|     +- trab1.md
|     +- correcoes/
|     |  +- rascunho.txt
|     |  +- final.txt
|     +- trab2.md
+- 6879/
+- 6884/
+- anotacoes.txt
```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
Dir("disciplinas", [
  Dir("12026", [
    Arq("alunos.txt"),
    Dir("trabs", [
      Arq("trab1.md"),
      Dir("correcoes", [
        Arq("rascunho.txt"),
        Arq("final.txt")
      ]),
      Arq("trab2.md"),
    ]),
  ]),
  Dir("6879", []),
  Dir("6884", []),
  Arq("anotacoes.txt"),
])
```

</div>
</div>


## Árvores {.t}

<div class="columns">
<div class="column" width="48%">

\small

Uma **entrada** no sistema de arquivos é:

- Uma arquivo com um nome; ou
- Um diretório com um nome é um **lista de entradas**.

\ \

Uma **lista de entradas** é:

- Vazia; ou
- Um par com o primeiro e o resto, onde o primeiro é uma **entrada** e o resto é uma **lista de entradas**.

</div>
<div class="column" width="48%">

\scriptsize

```gleam
fn fn_para_entrada(ent: Entrada) {
  case ent {
    Arq(nome) -> { todo nome }
    Dir(nome, entradas) -> {
      todo nome
           fn_para_entradas(entradas)
    }
  }
}
```

```gleam

fn fn_para_entradas(entradas: List(Entrada)) {
  case entradas {
    [] -> todo
    [primeiro, ..resto] -> {
      todo fn_para_entrada(primeiro)
           fn_para_entradas(resto)
    }
  }
}
```

</div>
</div>


## Exemplo: arquivos txt

Projete uma função para encontrar os caminhos para todos os arquivos txt.


## Exemplo: arquivos txt {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```
disciplinas/
+- 12026/
|  +- alunos.txt
|  +- trabs/
|     +- trab1.md
|     +- correcoes/
|     |  +- rascunho.txt
|     |  +- final.txt
|     +- trab2.md
+- 6879/
+- 6884/
+- anotacoes.txt
```

\pause

\ \

```
disciplinas/12026/alunos.txt
disciplinas/12026/trabs/correcoes/rascunho.txt
disciplinas/12026/trabs/correcoes/final.txt
disciplinas/anotacoes.txt
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn encontra_txt(ent: Entrada) -> List(String) {
  []
}
```

</div>
</div>


## Exemplo: arquivos txt {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```
disciplinas/
+- 12026/
|  +- alunos.txt
|  +- trabs/
|     +- trab1.md
|     +- correcoes/
|     |  +- rascunho.txt
|     |  +- final.txt
|     +- trab2.md
+- 6879/
+- 6884/
+- anotacoes.txt
```

\ \

```
disciplinas/12026/alunos.txt
disciplinas/12026/trabs/correcoes/rascunho.txt
disciplinas/12026/trabs/correcoes/final.txt
disciplinas/anotacoes.txt
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn encontra_txt(ent: Entrada) -> List(String) {
  case ent {
    Arq(nome) -> { todo nome }
    Dir(nome, entradas) -> {
      todo nome
           encontra_txt_lista(entradas)
    }
  }
}
fn encontra_txt_lista(lst: Entrada) -> List(String) {
  case lst {
    [] -> todo
    [entrada, ..resto] -> {
      todo encontra_txt(entrada)
           encontra_txt_lista(entradas)
    }
  }
}
```

</div>
</div>


## Exemplo: arquivos txt {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```
disciplinas/
+- 12026/
|  +- alunos.txt
|  +- trabs/
|     +- trab1.md
|     +- correcoes/
|     |  +- rascunho.txt
|     |  +- final.txt
|     +- trab2.md
+- 6879/
+- 6884/
+- anotacoes.txt
```

\ \

```
disciplinas/12026/alunos.txt
disciplinas/12026/trabs/correcoes/rascunho.txt
disciplinas/12026/trabs/correcoes/final.txt
disciplinas/anotacoes.txt
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn encontra_txt(ent: Entrada) -> List(String) {
  case ent {
    Arq(nome) -> case string.ends_with(nome, ".txt") {
      False -> []
      True -> [nome] }
    Dir(nome, entradas) -> {
      adiciona_prefixo(nome,
                       encontra_txt_lista(entradas)) }
  }
}
fn encontra_txt_lista(lst: Entrada) -> List(String) {
  case lst {
    [] -> []
    [entrada, ..resto] -> {
      list.append(encontra_txt(entrada),
                  encontra_txt_lista(entradas))
    }
  }
}
```

</div>
</div>



Limitações
==========


## Limitações

Cada tipo com autorreferência tem um modelo de função que podemos usar como ponto de partida para implementar funções que processam o tipo de dado. \pause

Embora o modelo seja um ponto de partida, em algumas situações ele pode não ser útil.


## Palíndromo

Considere o problema de verificar se uma lista de números é palíndromo (a lista tem os mesmos elementos quando lida da direita para a esquerda e da esquerda para direita). \pause

Para verificar se `[5, 4, 1, 4]`{.gleam} é palíndromo, o modelo sugere verificar se `[4, 1, 4]`{.gleam} é palíndromo. \pause

Como a verificação se `[4, 1, 4]`{.gleam} é palíndromo pode nos ajudar a determinar se `[5, 4, 1, 4]`{.gleam} é palíndromo? \pause Ou seja, a solução para o resto pode nos ajustar a compor o resultado para o todo? \pause Não pode...


## Número primo

Considere o problema de verificar se um número natural $n$ é primo (tem exatamente dois divisores distintos, $1$ e $n$). \pause

Para verificar se $n = 13$ é primo, o modelo sugere verificar se $12$ é primo. \pause

Como a verificação se $12$ é primo pode nos ajudar a determinar se $13$ é primo? \pause Não pode...


## Limitações

O problema nos dois casos é o mesmo: a solução do problema original não pode ser obtida a partir da solução do subproblema gerado pela decomposição estrutural do dado. \pause

Como fazemos nesse caso? \pause Temos algumas opções: \pause

- Redefinimos o problema de forma que a solução para o subproblema estrutural possa ser usado na construção da solução do problema original; \pause

- Fazemos uma decomposição em subproblema(s) de maneira não estrutural e utilizamos a solução desse(s) subproblema(s) para construir a solução do problema original; \pause

- Criamos uma plano (sequência de etapas) para construir a solução sem necessariamente pensar na decomposição da entrada em subproblemas do mesmo tipo.


## Redefinição do problema

Para o problema do número primo, podemos reescrever o problema da seguinte forma: Dado dois números naturais $n$ e $a \le n$, projete uma função que determine a quantidade de divisores de $n$ que são $\le a$. \pause

Se temos a quantidade de divisores de $n$ que são $\le a - 1$, como obtemos a quantidade de divisores de $n$ que são $\le a$? \pause Somando 1 se $a$ é divisor de $n$. \pause

Como podemos utilizar essa função para determinar se um número $n$ é primo? \pause Com a expressão `num_divisores(n, n) == 2`{.gleam}


## Número primo

<div class="columns">
<div class="column" width="55%">
\footnotesize

```gleam
/// Produz True se *n* é um número primo,
/// isto é, tem exatamente dois divisores
/// positivos distintos (1 e *n*).
/// Produz False caso contrário.
pub fn primo(n: Int) -> Bool {
  num_divisors(n, n) == 2
}
/// Calcula o número de divisores positivos
/// de *n* que são menores ou iguais à *a*.
fn num_divisors(n: Int, a: Int) -> Int {
  case a {
    _ if a <= 0 -> 0
    _ if n % a == 0 -> 1 + num_divisors(n, a - 1)
    _ -> num_divisors(n, a - 1)
  }
}
```

</div>
<div class="column" width="40%">
\footnotesize

```gleam
pub fn primo_examples() {
  check.eq(primo(1), False)
  check.eq(primo(2), True)
  check.eq(primo(3), True)
  check.eq(primo(4), False)
  check.eq(primo(5), True)
  check.eq(primo(6), False)
  check.eq(primo(7), True)
  check.eq(primo(8), False)
}
```
</div>
</div>


## Decomposição não estrutural

Para o problema da lista palíndromo, vamos considerar a entrada `[4, 1, 5, 1, 4]`{.gleam}.

Como podemos obter um subproblema da entrada de maneira que a resposta para o subproblema possa nos ajudar a compor a resposta para o problema original? \pause Removendo o primeiro e último elemento da lista. \pause

Se sabemos que uma lista `lst` sem o primeiro e o último elemento é palíndromo, como determinar se `lst` é palíndromo? \pause Verificando se o primeiro e o último elemento de `lst` são iguais.


## Palíndromo 1

\scriptsize

```gleam
/// Produz True se *lst* é palíndromo, isto é, tem os mesmos elementos quando lida
/// da direita para esquerda e da esquerda para direita. Produz False caso contrário.
pub fn palindromo(lst: List(Int)) -> Bool {
  case lst {
    [] | [_] -> True
    [primeiro, ..] ->
      Ok(primeiro) == list.last(lst) && palindromo(sem_extremos(lst))
  }
}

pub fn palindromo_examples() {
  check.eq(palindromo([]), True)
  check.eq(palindromo([2]), True)
  check.eq(palindromo([1, 2]), False)
  check.eq(palindromo([3, 3]), True)
  check.eq(palindromo([3, 7, 3]), True)
  check.eq(palindromo([3, 7, 3, 3]), False)
}
```

\small

\pause

Exercício: implemente a função `sem_extremos`.


## Decomposição não estrutural

Funções recursivas que operam em subproblemas obtidos pela decomposição estrutural dos dados são chamadas de **funções recursivas estruturais**. \pause

Funções recursivas que operam em subproblemas arbitrários (não estruturais) são chamadas de **funções recursivas generativas**. \pause

O projeto de função recursivas generativas pode requerer um "_insight_" e por isso tentamos primeiramente resolver os problemas com recursão estrutural.


## Plano

Ainda para o problema da lista palíndromo, ao invés de pensarmos em decompor o problema em um subproblema da mesma natureza, podemos pensar em um plano, uma sequencia de etapas que resolva problemas intermediários mas que gerem o resultado que estamos esperando no final. \pause

Por exemplo, podemos primeiramente inverter a lista e depois verificar se a lista de entrada e a lista invertida são iguais. \pause

Note que para este caso precisaríamos projetar duas novas funções. Estas funções poderiam ser implementadas usando recursão estrutural.


## Palíndromo 2

\scriptsize

```gleam
/// Produz True se *lst* é palíndromo, isto é, tem os mesmos elementos quando lida
/// da direita para esquerda e da esquerda para direita. Produz False caso contrário.
pub fn palindromo(lst: List(Int)) -> Bool {
  lst == list.reverse(lst)
}

pub fn palindromo2_examples() {
  check.eq(palindromo([]), True)
  check.eq(palindromo([2]), True)
  check.eq(palindromo([1, 2]), False)
  check.eq(palindromo([3, 3]), True)
  check.eq(palindromo([3, 7, 3]), True)
  check.eq(palindromo([3, 7, 3, 3]), False)
}
```

\pause

\small

Exercício: implemente a função `reverse`.



Revisão
=======


## Revisão

Usamos tipos com autorreferências quando queremos representar dados de tamanhos arbitrários. \pause

- Usamos funções recursivas para processar dados de tipos com autorreferências. \pause

Para ser bem formada, uma definição com autorreferência deve ter: \pause

- Pelo menos um caso base (sem autorreferência): \pause são utilizados para criar os valores iniciais \pause

- Pelo menos um caso com autorreferência: \pause são utilizados para criar novos valores a partir de valores existentes \pause

As vezes é interessante pensar em números inteiros e naturais como sendo compostos e definidos com autorreferência.


## Revisão

Existem dois tipos de recursão: estrutural e generativa. \pause

- A recursão estrutural é aquela feita na decomposição natural do dado (para as partes que são autorreferências na definição do dado). \pause

- A recursão generativa é aquela que não é estrutural. \pause

A recursão estrutural só pode ser utilizada quando a solução do problema pode ser expressa em termos da solução do subproblema estrutural. Para os demais problemas podemos tentar três abordagem: \pause

- Alterar o problema e utilizar recursão estrutural; \pause

- Usar recursão generativa; \pause

- Usar um plano (sequência de etapas).


Referências
===========

## Referências

<div class="columns">
<div class="column" width="48%">
Básicas

- [Vídeos Self-Reference](https://www.youtube.com/watch?v=tp44seRHLUQ&list=PL6NenTZG6KrptkOEMyLWDnF0ZjSpVTHAE)

- [Vídeos Naturals](https://www.youtube.com/playlist?list=PL6NenTZG6KroGNU9XgT5G5Dt2M6YGjZMF)

- Capítulos [8 a 12](https://htdp.org/2022-8-7/Book/part_two.html) do livro
  [HTDP](http://htdp.org)

- Seções
    [2.3](http://docs.racket-lang.org/guide/Lists__Iteration__and_Recursion.html),
    [2.4](http://docs.racket-lang.org/guide/Pairs__Lists__and_Racket_Syntax.html) e
    [3.8](http://docs.racket-lang.org/guide/pairs.html) do
    [Guia Racket](http://docs.racket-lang.org/guide/)

</div>
<div class="column" width="48%">
Complementares

- Seções [2.1](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1) (2.1.1 - 2.1.3) e [2.2](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2) (2.2.1) do livro [SICP](https://mitpress.mit.edu/sicp/)

- Seções [3.9](http://docs.racket-lang.org/reference/pairs.html) da [Referência Racket](http://docs.racket-lang.org/reference/)

- Seção [6.3](http://www.scheme.com/tspl4/objects.html#./objects:h3) do livro [TSPL4](http://www.scheme.com/tspl4/)
</div>
</div>
