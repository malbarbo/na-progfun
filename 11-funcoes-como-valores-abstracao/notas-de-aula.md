---
# vim: set spell spelllang=pt_br sw=4:
title: Funções como valores
subtitle: Abstração
# TODO: explicitar que existe uma "algebra" de funções (assim como uma algebra de número, strings, etc)
# TODO: rever referências
# TODO: mudar contem_5 para contem "a"?
---

Introdução
==========


## Introdução

As principais características que vimos até agora do paradigma funcional foram: \pause

- Ausência de efeitos colaterais; \pause

- Tipos algébricos e autorreferências; \pause

- Casamento de padrões; \pause

- Funções recursivas para processar dados com autorreferências. \pause

Veremos a seguir outra característica essencial do paradigma funcional: \pause

- Funções como valores.


## Introdução


Funções são **entidades de primeira classe** se: \pause

- Podem ser usadas, sem restrições, onde outros valores podem ser usados (passadas como entrada, devolvidas como resultado, armazenadas em listas, etc); \pause

- Podem ser construídas, sem restrições, onde outros valores também podem (localmente, em expressões, etc); \pause

- Podem ser tipadas de forma similar a outros valores (existe um tipo associado com cada função e esse tipo pode ser usado para compor outros tipos). \pause

Veremos a seguir como as funções podem ser utilizadas como valores.


## Introdução

Uma **função de alta ordem** é aquela que:

- Recebe como entrada uma ou mais funções; e/ou

- Produz como saída uma ou mais funções.



Funções que recebem funções como parâmetro
==========================================


## Funções que recebem funções como parâmetro

Como identificar a necessidade de utilizar funções como parâmetro? \pause

Encontrando similaridades entre funções. \pause

Vamos ver diversos pares de funções e identificar similaridades entre elas. \pause

Por questões de espaço, no restante desse material, usamos `p` para `primeiro` e `r` para `resto` e colocamos os exemplos fora de funções `_examples`.


## Exemplo: `contem_3` e `contem_5`

Vamos começar com um exemplo simples. \pause

Vamos criar uma função que abstrai o comportamento das funções `contem_3` e `contem_5`.


## Exemplo: `contem_3` e `contem_5`

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve True se 3 está em *lst*,
/// False caso contrário.
fn contem_3(lst: List(Int)) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == 3 || contem_3(r)
  }
}
check.eq(contem_3([4, 3, 1]), True)
```

\ \

\pause

```gleam
/// Devolve True se 5 está em *lst*,
/// False caso contrário.
fn contem_5(lst: List(Int)) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == 5 || contem_5(r)
  }
}
check.eq(contem_5([4, 3, 1]), False)
```

</div>
<div class="column" width="48%">
\pause

\scriptsize

Vamos definir uma função que abstrai o comportamento de `contem_3` e `contem_5`. \pause

```gleam



fn contem(lst, n) {
  case lst {
    [] -> False
    [p, ..r] -> p == n || contem(r, n)
  }
}
```
</div>
</div>


## Exemplo: `contem_3` e `contem_5`

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve True se 3 está em *lst*,
/// False caso contrário.
fn contem_3(lst: List(Int)) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == 3 || contem_3(r)
  }
}
check.eq(contem_3([4, 3, 1]), True)
```

\ \

```gleam
/// Devolve True se 5 está em *lst*,
/// False caso contrário.
fn contem_5(lst: List(Int)) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == 5 || contem_5(r)
  }
}
check.eq(contem_5([4, 3, 1]), False)
```

</div>
<div class="column" width="48%">

\scriptsize

Vamos definir uma função que abstrai o comportamento de `contem_3` e `contem_5`.

```gleam



fn contem(lst, n) {
  case lst {
    [] -> False
    [p, ..r] -> p == n || contem(r, n)
  }
}

check.eq(contem([4, 3, 1], 3), True)
check.eq(contem([4, 3, 1], 5), False)
```
</div>
</div>


## Exemplo: `contem_3` e `contem_5`

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve True se 3 está em *lst*,
/// False caso contrário.
fn contem_3(lst: List(Int)) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == 3 || contem_3(r)
  }
}
check.eq(contem_3([4, 3, 1]), True)
```

\ \

```gleam
/// Devolve True se 5 está em *lst*,
/// False caso contrário.
fn contem_5(lst: List(Int)) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == 5 || contem_5(r)
  }
}
check.eq(contem_5([4, 3, 1]), False)
```

</div>
<div class="column" width="48%">

\scriptsize

Vamos definir uma função que abstrai o comportamento de `contem_3` e `contem_5`.

```gleam

/// Devolve True se *n* está em *lst*,
/// False caso contrário.
fn contem(lst, n) {
  case lst {
    [] -> False
    [p, ..r] -> p == n || contem(r, n)
  }
}

check.eq(contem([4, 3, 1], 3), True)
check.eq(contem([4, 3, 1], 5), False)
```
</div>
</div>


## Exemplo: `contem_3` e `contem_5`

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve True se 3 está em *lst*,
/// False caso contrário.
fn contem_3(lst: List(Int)) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == 3 || contem_3(r)
  }
}
check.eq(contem_3([4, 3, 1]), True)
```

\ \

```gleam
/// Devolve True se 5 está em *lst*,
/// False caso contrário.
fn contem_5(lst: List(Int)) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == 5 || contem_5(r)
  }
}
check.eq(contem_5([4, 3, 1]), False)
```

</div>
<div class="column" width="48%">

\scriptsize

Vamos definir uma função que abstrai o comportamento de `contem_3` e `contem_5`.

```gleam

/// Devolve True se *n* está em *lst*,
/// False caso contrário.
fn contem(lst: List(Int), n: Int) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == n || contem(r, n)
  }
}

check.eq(contem([4, 3, 1], 3), True)
check.eq(contem([4, 3, 1], 5), False)
```
</div>
</div>


## Exemplo: `contem_3` e `contem_5`

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve True se 3 está em *lst*,
/// False caso contrário.
fn contem_3(lst: List(Int)) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == 3 || contem_3(r)
  }
}
check.eq(contem_3([4, 3, 1]), True)
```

\ \

```gleam
/// Devolve True se 5 está em *lst*,
/// False caso contrário.
fn contem_5(lst: List(Int)) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == 5 || contem_5(r)
  }
}
check.eq(contem_5([4, 3, 1]), False)
```

</div>
<div class="column" width="48%">

\scriptsize

Vamos definir uma função que abstrai o comportamento de `contem_3` e `contem_5`.

```gleam

/// Devolve True se *n* está em *lst*,
/// False caso contrário.
fn contem(lst: List(a), n: a) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == n || contem(r, n)
  }
}

check.eq(contem([4, 3, 1], 3), True)
check.eq(contem([4, 3, 1], 5), False)
```
</div>
</div>


## Exemplo: `contem_3` e `contem_5`

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve True se 3 está em *lst*,
/// False caso contrário.
fn contem_3(lst: List(Int)) -> Bool {
  contem(lst, 3)
}



check.eq(contem_3([4, 3, 1]), True)
```

\ \

```gleam
/// Devolve True se 5 está em *lst*,
/// False caso contrário.
fn contem_5(lst: List(Int)) -> Bool {
  contem(lst, 5)
}



check.eq(contem_5([4, 3, 1]), False)
```

</div>
<div class="column" width="48%">

\scriptsize

Vamos definir uma função que abstrai o comportamento de `contem_3` e `contem_5`.

```gleam

/// Devolve True se *n* está em *lst*,
/// False caso contrário.
fn contem(lst: List(a), n: a) -> Bool {
  case lst {
    [] -> False
    [p, ..r] -> p == n || contem(r, n)
  }
}

check.eq(contem([4, 3, 1], 3), True)
check.eq(contem([4, 3, 1], 5), False)
```
</div>
</div>


## Receita para criar abstração a partir de exemplos

1. Identificar funções com corpo semelhante \pause
  - Identificar o que muda \pause
  - Criar parâmetros para o que muda \pause
  - Copiar o corpo e substituir o que muda pelos parâmetros criados \pause
2. Escrever os exemplos \pause
  - Reutilizar os exemplos das funções existentes \pause
3. Escrever o propósito \pause
4. Escrever a assinatura \pause
5. Reescrever o código das funções iniciais em termos da nova função


## Exemplo: `lista_nega` e `lista_string`

Vamos criar uma função que abstrai o comportamento das funções `lista_nega` e `lista_string`.


## Exemplo: `lista_nega` e `lista_string`

<div class="columns">
<div class="column" width="55%">
\scriptsize

```gleam
/// Nega cada elemento de *lst*.
fn lista_nega(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [p, ..r] ->
      [int.negate(p), ..lista_nega(r)]
  }
}
check.eq(lista_nega([4, 3]), [-4, -3])
```

\pause

\ \

```gleam
/// Transforma cada elemento de *lst* em string.
fn lista_string(lst: List(Float)) -> List(String) {
  case lst {
    [] -> []
    [p, ..r] ->
      [float.to_string(p), ..lista_string(r)]
  }
}
check.eq(lista_string([3.0, 7.0]), ["3.0", "7.0"])
```

</div>
<div class="column" width="40%">
\scriptsize

\pause

```gleam





fn mapeia(lst, f) {
  case lst {
    [] -> []
    [p, ..r] -> [f(p), ..mapeia(r, f)]
  }
}
```
</div>
</div>


## Exemplo: `lista_nega` e `lista_string`

<div class="columns">
<div class="column" width="55%">
\scriptsize

```gleam
/// Nega cada elemento de *lst*.
fn lista_nega(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [p, ..r] ->
      [int.negate(p), ..lista_nega(r)]
  }
}
check.eq(lista_nega([4, 3]), [-4, -3])
```

\ \

```gleam
/// Transforma cada elemento de *lst* em string.
fn lista_string(lst: List(Float)) -> List(String) {
  case lst {
    [] -> []
    [p, ..r] ->
      [float.to_string(p), ..lista_string(r)]
  }
}
check.eq(lista_string([3.0, 7.0]), ["3.0", "7.0"])
```

</div>
<div class="column" width="40%">
\scriptsize

```gleam





fn mapeia(lst, f) {
  case lst {
    [] -> []
    [p, ..r] -> [f(p), ..mapeia(r, f)]
  }
}

check.eq(
  mapeia([4, 3], int.negate),
  [-4, -3])
check.eq(
  mapeia([3.0, 7.0], float.to_string),
  ["3.0", "7.0"])
```
</div>
</div>


## Exemplo: `lista_nega` e `lista_string`

<div class="columns">
<div class="column" width="55%">
\scriptsize

```gleam
/// Nega cada elemento de *lst*.
fn lista_nega(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [p, ..r] ->
      [int.negate(p), ..lista_nega(r)]
  }
}
check.eq(lista_nega([4, 3]), [-4, -3])
```

\ \

```gleam
/// Transforma cada elemento de *lst* em string.
fn lista_string(lst: List(Float)) -> List(String) {
  case lst {
    [] -> []
    [p, ..r] ->
      [float.to_string(p), ..lista_string(r)]
  }
}
check.eq(lista_string([3.0, 7.0]), ["3.0", "7.0"])
```

</div>
<div class="column" width="40%">
\scriptsize

```gleam




/// Aplica *f* a cada elemento de *lst*.
fn mapeia(lst, f) {
  case lst {
    [] -> []
    [p, ..r] -> [f(p), ..mapeia(r, f)]
  }
}

check.eq(
  mapeia([4, 3], int.negate),
  [-4, -3])
check.eq(
  mapeia([3.0, 7.0], float.to_string),
  ["3.0", "7.0"])
```
</div>
</div>


## Exemplo: `lista_nega` e `lista_string`

<div class="columns">
<div class="column" width="55%">
\scriptsize

```gleam
/// Nega cada elemento de *lst*.
fn lista_nega(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [p, ..r] ->
      [int.negate(p), ..lista_nega(r)]
  }
}
check.eq(lista_nega([4, 3]), [-4, -3])
```

\ \

```gleam
/// Transforma cada elemento de *lst* em string.
fn lista_string(lst: List(Float)) -> List(String) {
  case lst {
    [] -> []
    [p, ..r] ->
      [float.to_string(p), ..lista_string(r)]
  }
}
check.eq(lista_string([3.0, 7.0]), ["3.0", "7.0"])
```

</div>
<div class="column" width="40%">
\scriptsize

```gleam

/// Aplica *f* a cada elemento de *lst*.
fn mapeia(
  lst: List(a),
  f: fn(a) -> b,
) -> List(b) {
  case lst {
    [] -> []
    [p, ..r] -> [f(p), ..mapeia(r, f)]
  }
}

check.eq(
  mapeia([4, 3], int.negate),
  [-4, -3])
check.eq(
  mapeia([3.0, 7.0], float.to_string),
  ["3.0", "7.0"])
```
</div>
</div>


## Exemplo: `lista_nega` e `lista_string`

<div class="columns">
<div class="column" width="55%">
\scriptsize

```gleam
/// Nega cada elemento de *lst*.
fn lista_nega(lst: List(Int)) -> List(Int) {
  mapeia(lst, int.negate)
}




check.eq(lista_nega([4, 3]), [-4, -3])
```

\ \

```gleam
/// Transforma cada elemento de *lst* em string.
fn lista_string(lst: List(Float)) -> List(String) {
  mapeia(lst, float.to_string)
}




check.eq(lista_string([3.0, 7.0]), ["3.0", "7.0"])
```

</div>
<div class="column" width="40%">
\scriptsize

```gleam

/// Aplica *f* a cada elemento de *lst*.
fn mapeia(
  lst: List(a),
  f: fn(a) -> b,
) -> List(b) {
  case lst {
    [] -> []
    [p, ..r] -> [f(p), ..mapeia(r, f)]
  }
}

check.eq(
  mapeia([4, 3], int.negate),
  [-4, -3])
check.eq(
  mapeia([3.0, 7.0], float.to_string),
  ["3.0", "7.0"])
```
</div>
</div>


map
===


## `map`

Como resultado do exemplo anterior obtivemos a função `mapeia`, que é pré-definida em Gleam como `list.map`{.gleam}.

\pause

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam-repl
> list.map([4, 1, 2], int.is_even)
```

\pause

```gleam
[True, False, True]
```

\ \

\pause

```gleam-repl
> list.map(["casa", "", "arroz"],
           string.first)
```

\pause

```gleam
[Ok("c"), Error(Nil), Ok("a")]
```

\ \

\pause


</div>
<div class="column" width="48%">

\footnotesize

```gleam-repl
> list.map([1.2, 3.1], list.wrap)
```

\pause

```gleam
[[1.2], [3.1]]
```

\ \

\pause

```gleam-repl
> list.map([[4], [1, 2]], list.length)
```

\pause

```gleam
[1, 2]
```

<!--
```gleam-repl
> list.map(
    list.map(["carlos ", " BIA"], string.trim),
    string.capitalise)
```

\pause

```gleam
["Carlos", "Bia"]
```

\ \

\pause

```gleam-repl
> ["carlos ", " BIA"]
  |> list.map(string.trim)
  |> list.map(string.capitalise)
```

\pause

```gleam
["Carlos", "Bia"]
```
-->

</div>
</div>


## Exemplo: `lista_pares` e `lista_nao_vazia`

Vamos criar uma função que abstrai o comportamento das funções `lista_pares` e `lista_nao_vazia`.

\pause

\footnotesize

```gleam
fn eh_nao_vazia(s: String) -> Bool {
  s != ""
}
```

## Exemplo: `lista_pares` e `lista_nao_vazia`

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Seleciona os valores pares de *lst*.
fn lista_pares(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [p, ..r] -> case int.is_even(p) {
      True -> [p, ..lista_pares(r)]
      False -> lista_pares(r)
}}}
check.eq(lista_pares([3, 2, 7]), [2])
```

\pause

```gleam
/// Seleciona as strings não vazias de *lst*.
fn lista_nao_vazia(lst: List(String))
                     -> List(String) {
  case lst {
    [] -> []
    [p, ..r] -> case eh_nao_vazia(p) {
      True -> [p, ..lista_nao_vazia(r)]
      False -> lista_nao_vazia(r)
}}}
check.eq(lista_nao_vazia(["a", "", "b"]),
         ["a", "b"])
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam






fn filtra(lst, pred) {
  case lst {
    [] -> []
    [p, ..r] -> case pred(p) {
      True -> [p, ..filtra(r, pred)]
      False -> filtra(r, pred)
    }
  }
}
```

</div>
</div>


## Exemplo: `lista_pares` e `lista_nao_vazia`

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Seleciona os valores pares de *lst*.
fn lista_pares(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [p, ..r] -> case int.is_even(p) {
      True -> [p, ..lista_pares(r)]
      False -> lista_pares(r)
}}}
check.eq(lista_pares([3, 2, 7]), [2])
```

```gleam
/// Seleciona as strings não vazias de *lst*.
fn lista_nao_vazia(lst: List(String))
                     -> List(String) {
  case lst {
    [] -> []
    [p, ..r] -> case eh_nao_vazia(p) {
      True -> [p, ..lista_nao_vazia(r)]
      False -> lista_nao_vazia(r)
}}}
check.eq(lista_nao_vazia(["a", "", "b"]),
         ["a", "b"])
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam






fn filtra(lst, pred) {
  case lst {
    [] -> []
    [p, ..r] -> case pred(p) {
      True -> [p, ..filtra(r, pred)]
      False -> filtra(r, pred)
    }
  }
}

check.eq(filtra([3, 2, 7], int.is_even), [2])
check.eq(filtra(["a", "", "b"], eh_nao_vazia),
         ["a", "b"])
```

</div>
</div>


## Exemplo: `lista_pares` e `lista_nao_vazia`

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Seleciona os valores pares de *lst*.
fn lista_pares(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [p, ..r] -> case int.is_even(p) {
      True -> [p, ..lista_pares(r)]
      False -> lista_pares(r)
}}}
check.eq(lista_pares([3, 2, 7]), [2])
```

```gleam
/// Seleciona as strings não vazias de *lst*.
fn lista_nao_vazia(lst: List(String))
                     -> List(String) {
  case lst {
    [] -> []
    [p, ..r] -> case eh_nao_vazia(p) {
      True -> [p, ..lista_nao_vazia(r)]
      False -> lista_nao_vazia(r)
}}}
check.eq(lista_nao_vazia(["a", "", "b"]),
         ["a", "b"])
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam




/// Seleciona os valores de *lst*
/// para os quais *pred* devolve True.
fn filtra(lst, pred) {
  case lst {
    [] -> []
    [p, ..r] -> case pred(p) {
      True -> [p, ..filtra(r, pred)]
      False -> filtra(r, pred)
    }
  }
}

check.eq(filtra([3, 2, 7], int.is_even), [2])
check.eq(filtra(["a", "", "b"], eh_nao_vazia),
         ["a", "b"])
```

</div>
</div>


## Exemplo: `lista_pares` e `lista_nao_vazia`

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Seleciona os valores pares de *lst*.
fn lista_pares(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [p, ..r] -> case int.is_even(p) {
      True -> [p, ..lista_pares(r)]
      False -> lista_pares(r)
}}}
check.eq(lista_pares([3, 2, 7]), [2])
```

```gleam
/// Seleciona as strings não vazias de *lst*.
fn lista_nao_vazia(lst: List(String))
                     -> List(String) {
  case lst {
    [] -> []
    [p, ..r] -> case eh_nao_vazia(p) {
      True -> [p, ..lista_nao_vazia(r)]
      False -> lista_nao_vazia(r)
}}}
check.eq(lista_nao_vazia(["a", "", "b"]),
         ["a", "b"])
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam

/// Seleciona os valores de *lst*
/// para os quais *pred* devolve True.
fn filtra(
  lst: List(a),
  pred: fn(a) -> Bool,
) -> List(a) {
  case lst {
    [] -> []
    [p, ..r] -> case pred(p) {
      True -> [p, ..filtra(r, pred)]
      False -> filtra(r, pred)
    }
  }
}

check.eq(filtra([3, 2, 7], int.is_even), [2])
check.eq(filtra(["a", "", "b"], eh_nao_vazia),
         ["a", "b"])
```

</div>
</div>


## Exemplo: `lista_pares` e `lista_nao_vazia`

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Seleciona os valores pares de *lst*.
fn lista_pares(lst: List(Int)) -> List(Int) {
  filtra(lst, int.is_even)
}




check.eq(lista_pares([3, 2, 7]), [2])
```

```gleam
/// Seleciona as strings não vazias de *lst*.
fn lista_nao_vazia(lst: List(String))
                     -> List(String) {
  filtra(lst, eh_nao_vazia)
}




check.eq(lista_nao_vazia(["a", "", "b"]),
         ["a", "b"])
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam

/// Seleciona os valores de *lst*
/// para os quais *pred* devolve True.
fn filtra(
  lst: List(a),
  pred: fn(a) -> Bool,
) -> List(a) {
  case lst {
    [] -> []
    [p, ..r] -> case pred(p) {
      True -> [p, ..filtra(r, pred)]
      False -> filtra(r, pred)
    }
  }
}

check.eq(filtra([3, 2, 7], int.is_even), [2])
check.eq(filtra(["a", "", "b"], eh_nao_vazia),
         ["a", "b"])
```

</div>
</div>


`filter`
======

## `filter`

Como resultado do exemplo anterior obtivemos a função `filtra`, que é pré-definida em Gleam como `list.filter`{.gleam}.

\pause

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
fn comeca_a(s: String) -> Bool {
  string.first(s) == Ok("a")
}
```

\ \

\pause

```gleam-repl
> list.filter(["ana", "pedro", "agua"],
              comeca_a)
```

\pause

```gleam
["ana", "agua"]
```

\pause

</div>
<div class="column" width="48%">
\footnotesize

```gleam
fn tamanho_1(lst: List(a)) -> Bool {
  case lst {
    [_] -> True
    _ -> False
  }
}
```

\pause

\ \

```gleam-repl
> list.filter([[0], [2, 6], [], [3]],
              tamanho_1)
```

\pause

```gleam
[[0], [3]]
```

</div>
</div>


## Exemplo: `soma` e `junta_r`

Vamos criar uma função que abstrai o comportamento das funções `soma` e `junta_r`.


## Exemplo: `soma` e `junta_r` {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Soma os elementos de *lst*.
fn soma(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [p, ..r] -> p + soma(r)
  }
}

check.eq(soma([4, 1, 2]), 7)
```

\ \

\pause

```gleam
/// Junta os itens de *lst* em ordem contrária.
fn junta_r(lst: List(String)) -> String {
  case lst {
    [] -> ""
    [p, ..r] -> junta_r(r) <> p
  }
}

check.eq(junta_r(["a", "", "c"]), "ca")
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam
```
</div>
</div>


## Exemplo: `soma` e `junta_r` {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Soma os elementos de *lst*.
fn soma(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [p, ..r] -> int.add(soma(r), p)
  }
}

check.eq(soma([4, 1, 2]), 7)
```

\ \

```gleam
/// Junta os itens de *lst* em ordem contrária.
fn junta_r(lst: List(String)) -> String {
  case lst {
    [] -> ""
    [p, ..r] -> string.append(junta_r(r), p)
  }
}

check.eq(junta_r(["a", "", "c"]), "ca")
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam








fn reduz(lst, init, f) {
  case lst {
    [] -> init
    [p, ..r] -> f(reduz(r, init, f), p)
  }
}
```
</div>
</div>


## Exemplo: `soma` e `junta_r` {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Soma os elementos de *lst*.
fn soma(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [p, ..r] -> int.add(soma(r), p)
  }
}

check.eq(soma([4, 1, 2]), 7)
```

\ \

```gleam
/// Junta os itens de *lst* em ordem contrária.
fn junta_r(lst: List(String)) -> String {
  case lst {
    [] -> ""
    [p, ..r] -> string.append(junta_r(r), p)
  }
}

check.eq(junta_r(["a", "", "c"]), "ca")
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam








fn reduz(lst, init, f) {
  case lst {
    [] -> init
    [p, ..r] -> f(reduz(r, init, f), p)
  }
}
check.eq(
  reduz([4, 1, 2], 0, int.add),
  7)
check.eq(
  reduz(["a", "", "c"], "", string.append),
  "ca")
```
</div>
</div>


## Exemplo: `soma` e `junta_r` {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Soma os elementos de *lst*.
fn soma(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [p, ..r] -> int.add(soma(r), p)
  }
}

check.eq(soma([4, 1, 2]), 7)
```

\ \

```gleam
/// Junta os itens de *lst* em ordem contrária.
fn junta_r(lst: List(String)) -> String {
  case lst {
    [] -> ""
    [p, ..r] -> string.append(junta_r(r), p)
  }
}

check.eq(junta_r(["a", "", "c"]), "ca")
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam




/// Reduz os elementos de *lst* em um acumulador
/// usando a função *f*. O acumulador começa com *init*
/// e é atualizado chamando *f(acc, e)* para cada
/// elemento *e* de *lst* da direita para a esquerda.
fn reduz(lst, init, f) {
  case lst {
    [] -> init
    [p, ..r] -> f(reduz(r, init, f), p)
  }
}
check.eq(
  reduz([4, 1, 2], 0, int.add),
  7)
check.eq(
  reduz(["a", "", "c"], "", string.append),
  "ca")
```
</div>
</div>


## Exemplo: `soma` e `junta_r` {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Soma os elementos de *lst*.
fn soma(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [p, ..r] -> int.add(soma(r), p)
  }
}

check.eq(soma([4, 1, 2]), 7)
```

\ \

```gleam
/// Junta os itens de *lst* em ordem contrária.
fn junta_r(lst: List(String)) -> String {
  case lst {
    [] -> ""
    [p, ..r] -> string.append(junta_r(r), p)
  }
}

check.eq(junta_r(["a", "", "c"]), "ca")
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam
/// Reduz os elementos de *lst* em um acumulador
/// usando a função *f*. O acumulador começa com *init*
/// e é atualizado chamando *f(acc, e)* para cada
/// elemento *e* de *lst* da direita para a esquerda.
fn reduz(
  lst: List(a),
  init: b,
  f: fn(b, a) -> b,
) -> b {
  case lst {
    [] -> init
    [p, ..r] -> f(reduz(r, init, f), p)
  }
}
check.eq(
  reduz([4, 1, 2], 0, int.add),
  7)
check.eq(
  reduz(["a", "", "c"], "", string.append),
  "ca")
```
</div>
</div>


## Exemplo: `soma` e `junta_r` {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Soma os elementos de *lst*.
fn soma(lst: List(Int)) -> Int {
  reduz(lst, 0, int.add)
}




check.eq(soma([4, 1, 2]), 7)
```

\ \

```gleam
/// Junta os itens de *lst* em ordem contrária.
fn junta_r(lst: List(String)) -> String {
  reduz(lst, "", string.append)
}




check.eq(junta_r(["a", "", "c"]), "ca")
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam
/// Reduz os elementos de *lst* em um acumulador
/// usando a função *f*. O acumulador começa com *init*
/// e é atualizado chamando *f(acc, e)* para cada
/// elemento *e* de *lst* da direita para a esquerda.
fn reduz(
  lst: List(a),
  init: b,
  f: fn(b, a) -> b,
) -> b {
  case lst {
    [] -> init
    [p, ..r] -> f(reduz(r, init, f), p)
  }
}
check.eq(
  reduz([4, 1, 2], 0, int.add),
  7)
check.eq(
  reduz(["a", "", "c"], "", string.append),
  "ca")
```
</div>
</div>



`fold_right`
=====

## `fold_right`

Como resultado do exemplo anterior obtivemos a função `reduz`, que é pré-definida em Gleam como `list.fold_right`.

\pause

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam-repl
> list.fold_right([4, 5, 2],
                  1, int.multiply)
```

\pause

```gleam
40
```

\ \

\pause

```gleam-repl
> list.fold_right([4, 1, 8], 0, int.max)
```

\pause

```gleam
8
```

\pause
</div>
<div class="column" width="48%">
\footnotesize

```gleam
fn soma_tamanho(acc: Int, s: String) -> Int {
  acc + string.length(s)
}
```

```gleam-repl
> list.fold_right(["casa", "a", "boi"],
                  0, soma_tamanho)
```

\pause

```gleam
8
```

\pause

\normalsize

Note que o acumulador (`Int`{.gleam}) não precisa ter o mesmo tipo dos elementos da lista (`String`{.gleam}).
</div>
</div>


## Funções `map`, `filter` e `fold_right`

Quando utilizar as funções `map`, `filter` e `fold_right`? \pause

- Quando a lista sempre é processada por inteiro. \pause

- `map`: quando queremos aplicar uma função a cada elemento de uma lista de forma independente. \pause

- `filter`: quando queremos selecionar os elementos de uma lista de acordo com um predicado. \pause

- `fold_right`: quando queremos calcular um resultado de forma incremental analisando cada elemento de uma lista. \pause

Na dúvida, faça o projeto da função recursiva e depois verifique se ela é um caso específico de `map`, `filter` ou `fold_right`.


## Exemplo: sinal

Projete uma função que receba como parâmetro uma lista de números e produza uma nova lista com o sinal (1, 0 ou -1) de cada número da lista.


## Exemplo: sinal

<div class="columns">
<div class="column" width="55%">
\footnotesize

```gleam
/// Produz uma lista com o sinal de cada
/// elemento de *lst*. O sinal é 1 para
/// positivos, -1 para negativos e 0
/// para zero.
fn sinais(lst: List(Int)) -> List(Int) {
  todo
}

check.eq(
  sinais([10, 0, 2, -4, -1, 0, 8]),
  [1, 0, 1, -1, -1, 0, 1],
)
```

\small

\pause

Podemos usar `map`, `filter` ou `fold_right` para implementar a função? \pause Sim, podemos usar o `map`. \pause

</div>
<div class="column" width="40%">

\footnotesize

```gleam
fn sinal(n: Int) -> Int {
  case n {
    _ if n > 0 -> 1
    _ if n == 0 -> 0
    _ -> -1
  }
}
```

\pause

\ \

```gleam
fn sinais(lst: List(Int)) -> List(Int) {
  list.map(lst, sinal)
}
```

</div>
</div>


## Exemplo: pontos nos eixos

Projete uma função que receba como entrada uma lista de pontos no plano cartesiano e selecione quais estão sobre o eixo x ou eixo y.

\pause

\footnotesize

```gleam
/// Representa um ponto no plano cartesiano.
pub type Ponto {
  Ponto(x: Int, y: Int)
}
```


## Exemplo: pontos nos eixos

<div class="columns">
<div class="column" width="55%">

\footnotesize

```gleam
/// Cria uma lista apenas com os elementos de
/// *pontos* que estão sobre o eixo x ou y.
fn seleciona_no_eixo(
  pontos: List(Ponto)
) -> List(Ponto) {
  todo
}
check.eq(
  seleciona_no_eixo([
    Ponto(3, 0), Ponto(1, 3),
    Ponto(0, 2), Ponto(0, 0),
  ]),
  [Ponto(3, 0), Ponto(0, 2), Ponto(0, 0)])
```

\small

\pause

Podemos usar `map`, `filter` ou `fold_right` para implementar a função? \pause Sim, podemos usar o `filter`. \pause

</div>
<div class="column" width="40%">

\footnotesize

```gleam
fn no_eixo(p: Ponto) -> Bool {
  p.x == 0 || p.y == 0
}
```

\pause

\ \

```gleam
fn seleciona_no_eixo(
  pontos: List(Ponto)
) -> List(Ponto) {
  list.filter(pontos, no_eixo)
}

```

</div>
</div>


## Exemplo: ordenação

Projete uma função que receba como entrada uma lista de números e devolva uma lista com os mesmos valores de entrada mas em ordem monotonicamente crescente.


## Exemplo: ordenação

<div class="columns">
<div class="column" width="48%">

\footnotesize

```gleam
/// Cria uma lista com os elementos de
/// *lst* em ordem monotonicamente crescente.
fn ordena(lst: List(Int)) -> List(Int) {
  todo
}

check.eq(ordena([5, -2, 3]), [-2, 3, 5])
```

\pause

\small

Podemos usar `map`, `filter` ou `fold_right` para implementar a função? \pause Não está claro... \pause Vamos fazer a implementação usando o modelo. \pause

\scriptsize

```gleam
fn ordena(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [p, ..r] -> insere_ordenado(ordena(r), p)
  }
}
```

\pause

</div>
<div class="column" width="48%">

\small

E então, podemos usar `map`, `filter` ou `fold_right` para implementar a função? \pause

\scriptsize

```gleam
fn fold_right(lst, init, f) {
  case lst {
    [] -> init
    [p, ..r] -> f(fold_right(r, init, f), p)
  }
}
```

\pause

\small

Sim! Podemos usar o `fold_right`. \pause

\scriptsize

```gleam
fn ordena(lst: List(Int)) -> List(Int) {
  list.fold_right(lst, [], insere_ordenado)
}
```

\small

\pause

Exercício: projete a função `insere_ordenado`.

</div>
</div>


Revisão
=======


## Revisão

Como identificamos a necessidade de uma função que recebe funções como parâmetro? \pause

- Quando encontramos funções com corpo semelhante em que o que muda é uma operação, que passa a ser um parâmetro da nova função (como `lista_nega` e `lista_string` gerando `mapeia`). \pause

Qual a diferença entre `map`, `filter` e `fold_right`? \pause

- `map` aplica uma função a cada elemento de forma independente e produz uma lista do mesmo tamanho; `filter` seleciona os elementos que satisfazem um predicado; `fold_right` combina os elementos, um a um, em um único resultado, que pode ser de qualquer tipo. Os três processam a lista inteira.


## Revisão

Quando nenhuma das três parece servir diretamente, o que podemos fazer? \pause

- Fazer o projeto com o modelo e depois verificar se a função é um caso de `fold_right` (como em `ordena`).


Referências
===========

## Referências

Básicas

- Vídeos [Abstractions](https://www.youtube.com/playlist?list=PL6NenTZG6KroSmESv5ItvLft76ZR8q-Nd)

- Capítulo [15](https://htdp.org/2022-8-7/Book/part_three.html#%28part._ch~3aabstract%29) do livro [HTDP](http://htdp.org)

Complementares

- Seções [1.3](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-12.html#%_sec_1.3) (1.3.1) e [2.2.3](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.3) do livro [SICP](https://mitpress.mit.edu/sicp/)

- Seção [5.5](http://www.scheme.com/tspl4/control.html#./control:h5) do livro [TSPL4](http://www.scheme.com/tspl4/)
