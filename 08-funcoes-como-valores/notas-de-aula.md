---
# vim: set spell spelllang=pt_br sw=4:
title: Funções como valores
# TODO: explicitar que existe uma "algebra" de funções (assim como uma algebra de número, strings, etc)
# TODO: rever referências
# TODO: remover seção de funções com número variado de parâmetros?
# TODO: mudar contem_5 para contem "a"?
# TODO: melhorar o agrupamento e os nomes das seções
# TODO: dividir em mais de um módulo?
---

Introdução
==========


## Introdução

As principais características que vimos até agora do paradigma funcional foram: \pause

- Ausência de efeitos colaterais; \pause

- Tipos algébricos e autorreferências; \pause

- Recursão como forma de especificar iteração. \pause

Veremos a seguir outra característica essencial do paradigma funcional: funções como valores.


## Introdução


Funções são **entidades de primeira classe** se: \pause

- Podem ser usadas, sem restrições, onde outros valores podem ser usados (passado como parâmetro, retornado, armazenado em listas, etc); \pause

- Podem ser construídas, sem restrições, onde outros valores também podem (localmente, em expressões, etc); \pause

- Podem ser tipadas de forma similar a outro valores (existe um tipo associado com cada função e esse tipo pode ser usado para compor outro tipos).


## Introdução

Uma **função de alta ordem** é aquela que:

- Recebe como entrada uma ou mais funções; e/ou

- Produz como saída uma ou mais função com resultado.



Funções que recebem funções como parâmetro
==========================================


## Funções que recebem funções como parâmetro

Como identificar a necessidade de utilizar funções como parâmetro? \pause

Encontrando similaridades entre funções. \pause

Vamos ver diversas funções e tentar identificar similaridades. \pause

Por questões de espaço, no restante desse material, usamos `p` para primeiro e `r` para `resto` e colocamos os exemplos fora de funções `_examples`.


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
5. Reescrever o código da funções iniciais em termos da nova função


## Exemplo: `lista_nega` e `lista_string`

Vamos criar uma função que abstrai o comportamento das funções `lista_nega` e `lista_string`.


## Exemplo: `lista_nega` e `lista_string`

<div class="columns">
<div class="column" width="55%">
\scriptsize

```gleam
/// Eleva cada elemento de *lst* ao quadrado.
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
    [p, ..r] -> [f(p), ..mapeia(r)]
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
/// Eleva cada elemento de *lst* ao quadrado.
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
    [p, ..r] -> [f(p), ..mapeia(r)]
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
/// Eleva cada elemento de *lst* ao quadrado.
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




/// Aplica *f* a cada elemento de *lst*
fn mapeia(lst, f) {
  case lst {
    [] -> []
    [p, ..r] -> [f(p), ..mapeia(r)]
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
/// Eleva cada elemento de *lst* ao quadrado.
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

/// Aplica *f* a cada elemento de *lst*
fn mapeia(
  lst: List(a),
  f: fn(a) -> b,
) -> List(b) {
  case lst {
    [] -> []
    [p, ..r] -> [f(p), ..mapeia(r)]
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
/// Eleva cada elemento de *lst* ao quadrado.
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

/// Aplica *f* a cada elemento de *lst*
fn mapeia(
  lst: List(a),
  f: fn(a) -> b,
) -> List(b) {
  case lst {
    [] -> []
    [p, ..r] -> [f(p), ..mapeia(r)]
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

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
> list.map([4, 1, 2], int.is_even)
```

\pause

```gleam
[True, False, True]
```

\ \

\pause

```gleam
> list.map(["casa", "", "arroz"],
           string.first)
```

\pause

```gleam
[Ok("c"), Error(Nil), Ok("a)]
```

\ \

\pause


</div>
<div class="column" width="48%">

\footnotesize

```gleam
> list.map([1.2, 3.1], list.wrap)
```

\pause

```gleam
[[1.2], [3.1]]
```

\ \

\pause

```gleam
> list.map([[4], [1, 2]], list.length)
```

\pause

```gleam
[1, 2]
```

<!--
```gleam
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

```gleam
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
/// Seleciona os valores positivos de *lst*.
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
/// Seleciona os valores positivos de *lst*.
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
/// Seleciona os valores positivos de *lst*.
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
/// Seleciona os valores positivos de *lst*.
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
/// Seleciona os valores positivos de *lst*.
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

```gleam
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

```gleam
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
/// Soma dos elementos de *lst*.
fn some(lst: List(Int)) -> Int {
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
/// Soma dos elementos de *lst*.
fn some(lst: List(Int)) -> Int {
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
/// Soma dos elementos de *lst*.
fn some(lst: List(Int)) -> Int {
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
/// Soma dos elementos de *lst*.
fn some(lst: List(Int)) -> Int {
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




// Reduz os elementos de *lst* em um acumulador
// usando a função *f*. O acumulador começa com *init*
// e é atualizado chamando *f(acc, e)* para cada
// elemento *e* de *lst* da direita para esquerda.
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
/// Soma dos elementos de *lst*.
fn some(lst: List(Int)) -> Int {
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
// Reduz os elementos de *lst* em um acumulador
// usando a função *f*. O acumulador começa com *init*
// e é atualizado chamando *f(acc, e)* para cada
// elemento *e* de *lst* da direita para esquerda.
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
/// Soma dos elementos de *lst*.
fn some(lst: List(Int)) -> Int {
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
// Reduz os elementos de *lst* em um acumulador
// usando a função *f*. O acumulador começa com *init*
// e é atualizado chamando *f(acc, e)* para cada
// elemento *e* de *lst* da direita para esquerda.
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

Como resultado do exemplo anterior obtivemos a função `reduz`, que é pré-definida em Gleam como `fold_right`.

\pause

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
> list.fold_right([4, 5, 2],
                  1, int.multiply)
```

\pause

```gleam
40
```

\ \

\pause

```gleam
> list.fold_right([4, 1, 8], 0, int.max)
8
```

\pause
</div>
<div class="column" width="48%">
\footnotesize

```gleam
fn soma_1_acc(acc: Int, _: Int) -> Int {
  acc + 1
}

> list.fold_right([4, 1, 8], 0, soma_1_acc)
```

\pause

```gleam
3
```
</div>
</div>


## Funções `map`, `filter` e `fold_right`

Quando utilizar as funções `map`, `filter` e `fold_right`? \pause

- Quando a lista sempre é processa por inteiro. \pause

- `map`: quando queremos aplicar uma função a cada elemento de uma lista de forma independente. \pause

- `filter`: quando queremos selecionar alguns elementos de uma lista. \pause

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
/// para neutros.
fn sinais(lst: List(Int)) -> List(int) {
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
fn sinal(n: Int) -> Sinal {
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
fn sinais(lst: List(Int)) -> List(int) {
  list.map(lst, sinal)
}
```

</div>
</div>


## Exemplo: pontos nos eixos

Projete uma função que receba como entrada uma lista de pontos no plano cartesiano e indique quais estão sobre o eixo x ou eixo y.

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
/// Cria uma lista com os elementos de
/// *pontos* estão sobre o eixo x ou y.
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

Projete uma função que receba como entrada uma lista de números e devolva uma lista com os mesmos valores de entrada mas em ordem não decrescente.


## Exemplo: ordenação

<div class="columns">
<div class="column" width="48%">

\footnotesize

```gleam
/// Cria uma lista com os elementos de
/// *lst* em ordem não decrescente.
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
    [p, ..r] -> insere_ordenado(ordena(r), p))
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
    [] -> []
    [p, ..r] ->
      f(fold_right(r, init, f), p))
  }
}
```

\pause

\small

Sim! Podemos usar o `fold_right`. \pause

\scriptsize

```gleam
fn ordena(lst) {
  list.fold_right(lst, [], insere_ordenado)
}
```

\small

\pause

Exercício: projete a função `insere_ordenado`.

</div>
</div>


## Exemplos: maiores strings

Projete uma função que receba como entrada uma lista de strings e devolva uma lista com as strings de tamanho máximo entre todas as strings da lista.


## Exemplos: maiores strings

\scriptsize

```scheme
/// Cria uma lista com as strings de *lst* que têm tamanho máximo entre todos
/// as strings de *lst*.
fn maiores_strings(lst: List(String)) -> List(String) {
  todo
}

check.eq(
  maiores_strings(["oi", "casa", "aba", "boi", "eita", "a", "cadê"]),
  ["casa", "eita", "cadê"]
)
```

\small

\pause

Podemos usar `map`, `filter` ou `fold_right` para implementar a função? \pause Parece complicado... \pause

Vamos separar a solução em duas etapas: encontrar o tamanho máximo e depois selecionar as strings com tamanho máximo.

## Exemplos: maiores strings

<div class="columns">
<div class="column" width="48%">

\footnotesize

```gleam
/// Devolve o tamanho máximo entre
/// todos os elementos de *lst*.
fn tamanho_max(lst: List(String) -> Int {
  todo
}

check.eq(
  tamanho_maximo(
    ["oi", "casa", "aba", "boi",
     "eita", "a", "cadê"]),
  4,
)
```

\pause

\small

Podemos usar `map`, `filter` ou `fold_right` para implementar a função? \pause Sim, usando o `fold_right`, mas parece complicado... \pause

</div>
<div class="column" width="48%">

\small

A função para o `fold_right` teria que fazer duas coisas, determinar o tamanho de uma string e indicar qual é o máximo entre dois tamanhos. \pause

Podemos separar as etapas de obter os tamanhos e encontrar o máximo, usamos o `map` para obter uma lista com os tamanhos e o `fold_right` para determinar o valor máximo. \pause

\footnotesize

```gleam
/// Devolve o tamanho máximo entre
/// todos os elementos de *lst*.
fn tamanho_max(lst: List(String) -> Int {
  list.fold_rigth(list.map(lst,
                           string.length),
                  0, int.max)
}
```

\pause

\small

Agora podemos implementar a função `maiores-strings`.

</div>
</div>

## Exemplos: maiores strings

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
fn maiores_string(lst: List(String)) {
  let max = tamanho_ma(lst)
  list.filter(lst, ?)
}
```

\pause

```gleam
fn maiores_string(lst: List(String)) {
  let max = tamanho_maximo(lst)

  let tem_tamanho_max = fn(s: String) {
    string.length(s) == max
  }

  list.filter(lst, tem_tamanho_maximo)
}
```


</div>
<div class="column" width="48%">
\pause

\footnotesize

```python

def maiores_strings(lst: list[str]) -> list[str]:
    tmax = tamanho_max(lst)
```

```python
    def tem_tamanho_max(s: str) -> bool:
        return len(s) == tmax
```

```python
    return list(filter(tem_tamanho_max, lst))
```

```python

def tamanho_max(lst: list[str]) -> int:
    # max recebe uma lista (iterator)
    return max(map(len, lst))
```

</div>
</div>


Definições locais e fechamentos
===============================

## Definições locais e fechamentos

Uma **declaração local** é aquela que não é feita no escopo global. \pause As declarações locais, como a de `tmax` e `tamanho-maximo?`, ajudam na escrita e leitura do código e melhoram o encapsulamento. \pause

Uma **variável livre** em relação a uma função é aquela que não é global, não é um parâmetro da função e nem foi declarada localmente dentro da função. \pause

Como uma função acessa um parâmetro ou uma variáveis local? \pause Geralmente, consultando o registro de ativação, o quadro, da sua chamada.


## Definições locais e fechamentos


<div class="columns">
<div class="column" width="48%">
\footnotesize

```scheme
;; Lista(String) -> Lista(String)
(define (maiores-strings lst)
  (define tmax (tamanho-maximo lst))

  ;; String -> Booleano
  ;; Devolve #t se o tamanho de
  ;; s é igual a tmax. #f caso contrário.
  (define (tamanho-maximo? s)
    (= (string-length s) tmax))

  (filter tamanho-maximo? lst))
```

</div>
<div class="column" width="48%">
\pause

Como `tamanho-maximo?` acessa a variável livre `tmax` já que ela não é armazenada no registro de ativação de `tamanho-maximo?`? \pause

A função `tamanho-maximo?` deve "levar" junto com ela a variável livre `tmax`.

</div>
</div>


## Definições locais e fechamentos

O **ambiente léxico** é uma tabela com referências para as variáveis livres. \pause

Um **fechamento** (*closure* em inglês) é uma função junto com o seu ambiente léxico. \pause

\footnotesize

```scheme
;; Lista(String) -> Lista(String)
(define (maiores-strings lst)
  (define tmax (tamanho-maximo lst))
  ;; String -> Booleano
  ;; Devolve #t se o tamanho de
  ;; s é igual a tmax. #f caso contrário.
  (define (tamanho-maximo? s)
    (= (string-length s) tmax))
  (filter tamanho-maximo? lst))
```

\normalsize

Quando `tamanho-maximo` é utilizada na chamada do `map` um fechamento é passado como parâmetro.


## Definições locais e fechamentos

Até agora, as definições locais que fizemos apareceram no início de uma função, mas as definições também podem aparecer em outros locais.


## Definições locais e fechamentos

Considere por exemplo esta função que remove os elementos consecutivos iguais

\small

```scheme
(define (remove-duplicados lst)
  (cond
    [(empty? lst) empty]
    [(empty? (rest lst)) lst]
    [else
     (if (equal? (first lst)
                 (first (remove-duplicados (rest lst))))
         (remove-duplicados (rest lst))
         (cons (first lst)
               (remove-duplicados (rest lst))))]))
```

As expressões `(first lst)` e `(remove-duplicados (rest lst))` são computadas duas vezes.


## Definições locais e fechamentos

Podemos utilizar definições locais para armazenar o resultado de expressões e evitar que elas sejam computadas repetidas vezes.

```scheme
(define (remove-duplicados lst)
  (cond
    [(empty? lst) empty]
    [(empty? (rest lst)) lst]
    [else
     (define p (first lst))
     (define r (remove-duplicados (rest lst)))
     (if (equal? p (first r))
         r
         (cons p r))]))
```


## Definições locais e fechamentos

O `define`{.scheme} não pode ser usado em alguns lugares, como por exemplo, no consequente ou alternativa do `if`{.scheme}.

Em geral utilizamos `define`{.scheme} apenas no início da função, em outros lugares utilizamos a forma especial `let`{.scheme}.


## Definições locais e fechamentos

A sintaxe do `let`{.scheme} é

```scheme
(let ([var1 exp1]
      [var2 exp2]
      ...
      [varn expn])
  corpo)
```

Os nomes `var1`, `var2`, ..., são locais ao `let`{.scheme}, ou seja, são visíveis apenas no corpo do `let`{.scheme}.

O resultado da avaliação do `corpo` é o resultado da expressão `let`{.scheme}.


## Definições locais e fechamentos

No `let`{.scheme} os nomes que estão sendo definidos não podem ser usados nas definições dos nomes seguintes, por exemplo, não é possível utilizar o nome `var1` na expressão de `var2`.

`let*`{.scheme} não tem essa limitação


## Definições locais e fechamentos

Definições internas com o `let`{.scheme}

```scheme
(define (remove-duplicados lst)
  (cond
    [(empty? lst) empty]
    [(empty? (rest lst)) lst]
    [else
     (let ([p (first lst)]
           [r (remove-duplicados (rest lst))])
       (if (equal? p (first r))
           r
           (cons p r)))]))
```


## Exemplo

Defina a função `mapeia` em termos da função `reduz`.


## `mapeia` em termos de `reduz`

```scheme
(define (mapeia f lst)
  (define (cons-f e lst)
    (cons (f e) lst))
  (reduz cons-f empty lst))
```


## Exemplo

Defina a função `filtra` em termos da função `reduz`.


## `filtra` em termos de `reduz`

```scheme
(define (filtra pred? lst)
  (define (cons-if e lst)
    (if (pred? e) (cons e lst) lst))
  (reduz cons-if empty lst))
```



Funções anônimas
================

## Funções anônimas

Da mesma forma que podemos utilizar expressões aritméticas sem precisar nomeá-las, também podemos utilizar expressões que resultam em funções sem precisar nomeá-las


## Funções anônimas

Quando fazemos um `define` de uma função, estamos especificando duas coisas: **a função** e **o nome da função**. \pause Quando escrevemos

```scheme
(define (quadrado x)
  (* x x))
```

\pause

O Racket interpreta como

```scheme
(define quadrado
  (lambda (x) (* x x)))
```

\pause

O que deixa claro a distinção entre criar a função e dar nome à função. Às vezes é útil definir uma função sem dar nome a ela.


## Funções anônimas

`lambda`{.scheme} é a palavra chave usada para especificar funções. A sintaxe do `lambda`{.scheme} é

```scheme
(lambda (parametros ...)
    corpo)
```

Em vez de utilizar a palavra `lambda`{.scheme}, podemos utilizar a letra $\lambda$ (ctrl + \textbackslash \ no DrRacket)


## Funções anônimas

Como e quando utilizar um funções anônimas? \pause

- Como parâmetro, quando a função for pequena e necessária apenas naquele local \pause

    ```scheme
    > (map (λ (x) (* x 2)) (list 3 8 -6))
    '(6 16 -12)
    > (filter (λ (x) (< x 10)) (list 3 20 -4 48))
    '(3 -4)
    ```

\pause

- Como resultado de função



Funções que produzem funções
============================

## Funções que produzem funções

Como identificar a necessidade de criar e utilizar funções que produzem funções? \pause

- Parametrizar a criação de funções fixando alguns parâmetros \pause

- Composição de funções \pause

- ... \pause

- Requer experiência


## Exemplo: somador

Defina uma função que receba um parâmetro $n$ e devolva uma função que soma o seu argumento a $n$.


## Exemplo: somador

```scheme
> (define soma1 (somador 1))
> (define soma5 (somador 5))
> (soma1 4)
5
> (soma5 9)
14
> (soma1 6)
7
> (soma5 3)
8
```


## Exemplo: somador

```scheme
;; Número -> (Número -> Número)
;; Devolve uma função que recebe um parâmetro x
;; e produz a soma de n e x.
(examples
 (check-equal? ((somador 4) 3) 7)
 (check-equal? ((somador -2) 8) 6))
(define (somador n) ...)
```

\pause

```scheme
;; Versão com função nomeada.
(define (somador n)
  (define (soma x)
    (+ n x))
  soma)
```


## Exemplo: somador

```scheme
;; Número -> (Número -> Número)
;; Devolve uma função que recebe um parâmetro x
;; e produz a soma de n e x.
(examples
 (check-equal? ((somador 4) 3) 7)
 (check-equal? ((somador -2) 8) 6))
(define (somador n) ...)
```

\pause

```scheme
;; Versão com função anônima.
(define (somador n)
  (λ (x) (+ n x)))
```


## Exemplo: negação

Defina uma função que receba como parâmetro um predicado (função que retorna booleano) e retorne uma função que retorna a negação do predicado.

- `negate` ([referência](https://docs.racket-lang.org/reference/procedures.html#%28def._%28%28lib._scheme%2Ffunction..rkt%29._negate%29%29))


## Exemplo: negação

```scheme
> ((nega positive?) 3)
#f
> ((nega positive?) -3)
#t
> ((nega even?) 4)
#f
> ((nega even?) 3)
#t
```


## Exemplo: negação

```scheme
;; (X -> Boolean) -> (X -> Boolean)
;; Devolve uma função que é semelhante a pred,
;; mas que devolve a  negação do resultado de pred.
;; Veja a função pré-definida negate.
(examples
 (check-equal? ((nega positive?) 3) #f)
 (check-equal? ((nega positive?) -3) #t)
 (check-equal? ((nega even?) 4) #f)
 (check-equal? ((nega even?) 3) #t))
```

\pause

```scheme
(define (nega pred?)
  (λ (x) (not (pred? x))))
```



Currying
========


## Currying

No cálculo lambda o currying permite definir funções que admitem múltiplos parâmetros. \pause

Aqui o currying permite a aplicação parcial das funções. \pause

Por exemplo, para uma função que admite dois argumentos, poderemos aplicá-la apenas ao primeiro argumento e mais tarde ao segundo argumento, resultando no valor esperado.


## Currying

```scheme
> (define f (λ (x) (λ (y) (* x y))))
> (define ((g x) y) (< x y))
> (map (f 2) (list 1 2 3 4))
'(2 4 6 8)
> (filter (g 2) (list 1 2 3 4))
'(3 4)
```


## `curry` e `curryr`

As funções pré-definidas `curry` e `curryr` são utilizadas para fixar argumentos de funções

- `curry` fixa os argumentos da esquerda para direita

- `curryr` fixa os argumentos da direita para esquerda


## `curry` e `curryr`

```scheme
> (define e-4? (curry = 4))
> (e-4? 4)
#t
> (e-4? 5)
#f
> (filter e-4? (list 3 4 7 4 6))
'(4 4)
> (filter (curry < 3) (list 4 3 2 5 7 1))
'(4 5 7)
> (filter (curryr < 3) (list 4 3 2 5 7 1))
'(2 1)
> (map (curry + 5) (list 3 6 2))
'(8 11 7)
```



Outras funções de alta ordem
============================

## Outras funções de alta ordem

`apply` ([referência](http://docs.racket-lang.org/reference/procedures.html?q=apply#%28def._%28%28lib._scheme%2Fprivate%2Fbase..rkt%29._apply%29%29))

    ```scheme
    > (apply < (list 4 5))
    #t
    > (apply + (list 4 5))
    9
    > (apply * (list 2 3 4))
    24
    ```

`andmap` ([referência](http://docs.racket-lang.org/reference/pairs.html#%28def._%28%28lib._scheme/private/map..rkt%29._andmap%29%29))

`ormap` ([referência](http://docs.racket-lang.org/reference/pairs.html#%28def._%28%28lib._scheme/private/map..rkt%29._ormap%29%29))

`build-list` ([referência](http://docs.racket-lang.org/reference/pairs.html#%28def._%28%28lib._scheme/private/list..rkt%29._build-list%29%29))



Funções com número variado de parâmetros
========================================

## Funções com número variado de parâmetros

Muitas funções pré-definidas aceitam um número variado de parâmetros. \pause Como criar funções com esta característica? \pause

Forma geral

```scheme
(define (nome obrigatorios . opcionais) corpo)
(define (nome . opcionais) corpo)
(λ (obrigatorios . opcionais) corpo)
(λ opcionais corpo)
```

Os parâmetros opcionais são agrupados em uma lista


## Funções com número variado de parâmetros

Exemplos

```scheme
> (define (f1 p1 p2 . outros) outros)
> (f1 4 5 7 -2 5)
'(7 -2 5)
> (f1 4 5)
'()
> (f1 4)
f1: arity mismatch;
 the expected number of arguments does not match the given number
  expected: at least 2
  given: 1
  arguments...:
   4
```



Referências
===========

## Referências

Básicas

- Vídeos [Abstractions](https://www.youtube.com/playlist?list=PL6NenTZG6KroSmESv5ItvLft76ZR8q-Nd)

- Texto "From Examples" do curso [Introduction to Systematic Program Design - Part 1](https://class.coursera.org/programdesign-002/wiki/view?page=UsingAbstractFunctions) (Necessário inscrever-se no curso)

- Capítulos [14](https://htdp.org/2022-8-7/Book/part_three.html#%28part._ch~3add-similarities%29) e [15](https://htdp.org/2022-8-7/Book/part_three.html#%28part._ch~3aabstract%29) do livro [HTDP](http://htdp.org)

- Seções [3.9](http://docs.racket-lang.org/reference/pairs.html) e [3.17](http://docs.racket-lang.org/reference/procedures.html) da [Referência Racket](http://docs.racket-lang.org/reference/)

Complementares

- Seções [1.3](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-12.html#%_sec_1.3) (1.3.1 e 1.3.2)   e [2.2.3](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.3) do livro [SICP](https://mitpress.mit.edu/sicp/)

- Seções [4.2](http://www.scheme.com/tspl4/binding.html#./binding:h2) e [5.5](http://www.scheme.com/tspl4/control.html#./control:h5) do livro [TSPL4](http://www.scheme.com/tspl4/)

-->
