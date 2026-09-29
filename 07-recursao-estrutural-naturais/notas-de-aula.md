---
# vim: set spell spelllang=pt_br sw=4:
title: Recursão estrutural
subtitle: Naturais
---


Números Naturais
================


## Introdução

Um número natural é atômico ou composto? \pause

- Atômico quando usado em operações aritméticas, comparações, etc; \pause

- Composto quando uma iteração precisa ser feita com base no valor do número.

\pause

Se um número natural pode ser visto como um dado composto \pause

- Quais são as partes que compõem o número? \pause

- Como (de)compor um número?


## Definição

<div class="columns">
<div class="column" width="48%">

Um número **natural** é \pause

- `0`{.gleam}; ou \pause

- `n + 1`{.gleam} onde $n$ é um número **natural**

\pause

\ \

Com base nesta definição, criamos um modelo para funções com números naturais.

</div>
<div class="column" width="48%">

\pause

\footnotesize

```gleam
fn fn_para_natural(n: Int) {
  case n {
    0 -> todo
    _ -> {
      todo
      n
      fn_para_natural(n - 1)
    }
  }
}
```

\pause

\normalsize

Qual o problema desse modelo? \pause Se `n` não é zero, ele pode ser negativo e a recursão não terminaria. \pause O problema é que o Gleam não possui números naturais.

</div>
</div>


## Definição

<div class="columns">
<div class="column" width="48%">

Um número **natural** é

- `0`{.gleam}; ou

- `n + 1`{.gleam} onde $n$ é um número **natural**


\ \

Com base nesta definição, criamos um modelo para funções com números naturais.

</div>
<div class="column" width="48%">

\footnotesize

```gleam
fn fn_para_natural(n: Int) {
  case n {
    // Necessário porque o Gleam
    // não possui números naturais
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
fn soma_nat(n: Int) -> Int {
  todo
}
```

\pause
</div>
<div class="column" width="48%">

\footnotesize

```gleam
fn soma_nat_examples() {
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
fn soma_nat(n: Int) -> Int {
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
fn soma_nat_examples() {
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
fn soma_nat(n: Int) -> Int {
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
fn soma_nat_examples() {
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
fn soma_nat(n: Int) -> Int {
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
fn soma_nat_examples() {
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
fn lista_num(n: Int) -> List(Int) {
  todo
}
```

\pause

</div>
<div class="column" width="48%">

\footnotesize

```gleam
fn lista_num_examples() {
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
fn lista_num(n: Int) -> List(Int) {
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
fn lista_num_examples() {
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
fn lista_num(n: Int) -> List(Int) {
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
fn lista_num_examples() {
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
fn lista_num(n: Int) -> List(Int) {
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
fn lista_num_examples() {
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
fn adiciona_fim(
  lst: List(Int),
  n: Int,
) -> List(Int) {
  todo
}
```

\pause

</div>
<div class="column" width="48%">

\footnotesize

```gleam
fn adiciona_fim_examples() {
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
fn adiciona_fim(
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
fn adiciona_fim_examples() {
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
fn adiciona_fim(
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
fn adiciona_fim_examples() {
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
fn adiciona_fim(
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
fn adiciona_fim_examples() {
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
fn adiciona_fim(
  lst: List(a),
  n: a,
) -> List(a) {
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
fn adiciona_fim_examples() {
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

Às vezes, queremos utilizar um caso base diferente de $0$. \pause

Podemos generalizar a definição de número natural para incluir um limite inferior diferente de $0$.


## Definição Inteiro

<div class="columns">
<div class="column" width="48%">
Um número **inteiro menor ou igual a x** é

- `x`{.gleam}; ou

- `n + 1`{.gleam} onde `n`{.gleam} é um número **inteiro menor ou igual a x**.

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


Revisão
=======


## Revisão

Quando um número natural deve ser visto como um dado composto? \pause

- Quando uma iteração precisa ser feita com base no valor do número. Nas operações aritméticas e nas comparações, ele é visto como atômico. \pause

Como um número natural é definido com autorreferência? \pause

- Um número natural é `0`{.gleam} ou `n + 1`{.gleam}, onde `n`{.gleam} é um número natural.


## Revisão

Qual é o modelo de função para números naturais? \pause

- Um `case`{.gleam} com um caso para `0`{.gleam} e outro caso em que a recursão é feita com `n - 1`{.gleam}. Como o Gleam não tem um tipo para números naturais, o modelo também tem um caso para os números negativos. \pause

Como processar números inteiros quando a recursão deve parar em um valor diferente de `0`{.gleam}? \pause

- Generalizando a definição de número natural para um limite inferior `x`{.gleam}: o caso base passa a ser `x`{.gleam} em vez de `0`{.gleam}.


Referências
===========

## Referências

Básicas

- [Vídeos Naturals](https://www.youtube.com/playlist?list=PL6NenTZG6KroGNU9XgT5G5Dt2M6YGjZMF)

- Seção [9.3](https://htdp.org/2022-8-7/Book/part_two.html) do livro [HTDP](http://htdp.org)
