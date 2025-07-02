---
# vim: set spell spelllang=pt_br sw=4:
title: Funções como valores
# TODO: explicitar que existe uma "algebra" de funções (assim como uma algebra de número, strings, etc)
# TODO: rever referências
# TODO: falar de currying?
# TODO: mudar contem_5 para contem "a"?
# TODO: melhorar o agrupamento e os nomes das seções
# TODO: colocar uma função para fold que a saída tem tipo diferente dos elementos da entrada
# TODO: dividir em mais de um módulo?
---

Introdução
==========


## Introdução

As principais características que vimos até agora do paradigma funcional foram: \pause

- Ausência de efeitos colaterais; \pause

- Tipos algébricos e autorreferências; \pause

- Casamento de padrões; \pause

- Recursão como forma de especificar iteração. \pause

Veremos a seguir outra característica essencial do paradigma funcional: funções como valores.


## Introdução


Funções são **entidades de primeira classe** se: \pause

- Podem ser usadas, sem restrições, onde outros valores podem ser usados (passado como entrada, devolvido como resultado, armazenado em listas, etc); \pause

- Podem ser construídas, sem restrições, onde outros valores também podem (localmente, em expressões, etc); \pause

- Podem ser tipadas de forma similar a outro valores (existe um tipo associado com cada função e esse tipo pode ser usado para compor outro tipos). \pause

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

Vamos ver diversas pares de funções e identificar similaridades entre elas. \pause

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
/// Nega cada elemento de lst*.
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

\pause

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
/// Somas os elementos de *lst*.
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
/// Somas os elementos de *lst*.
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
/// Somas os elementos de *lst*.
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
/// Somas os elementos de *lst*.
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
/// Somas os elementos de *lst*.
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
/// Somas os elementos de *lst*.
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

Como resultado do exemplo anterior obtivemos a função `reduz`, que é pré-definida em Gleam como `list.fold_right`.

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
/// para neutros.
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
fn sinais(lst: List(Int)) -> List(Int) {
  list.map(lst, sinal)
}
```

</div>
</div>


## Exemplo: pontos nos eixos

Projete uma função que receba como entrada uma lista de pontos no plano cartesiano e indique quais estão sobre o eixo x ou eixo y.

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
/// Cria uma lista com os elementos de
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
    [p, ..r] -> f(fold_right(r, init, f), p))
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


## Exemplos: maiores strings

Projete uma função que receba como entrada uma lista de strings e devolva uma lista com as strings de tamanho máximo entre todas as strings da lista.


## Exemplos: maiores strings

\scriptsize

```gleam
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

Podemos fazer em duas etapas: usamos o `map` para obter uma lista com os tamanhos e o `fold_right` para determinar o valor máximo. \pause

\footnotesize

\ \

```gleam
/// Devolve o tamanho máximo entre
/// todos os elementos de *lst*.
fn tamanho_max(lst: List(String) -> Int {
  list.fold_rigth(
    list.map(lst, string.length),
    0,
    int.max
  )
}
```


</div>
</div>


## Exemplos: maiores strings

<div class="columns">
<div class="column" width="48%">

\footnotesize

```gleam
fn maiores_string(lst: List(String)) {
  let max = tamanho_maximo(lst)
  // Como definimos a função
  // tem_tamanho_maximo?
  list.filter(lst, tem_tamanho_maximo)
}
```

\pause

```gleam
fn maiores_string(lst: List(String)) {
  let max = tamanho_maximo(lst)

  fn tem_tamanho_max(s: String) -> Bool {
    string.length(s) == max
  }

  list.filter(lst, tem_tamanho_maximo)
}
```

\pause

</div>
<div class="column" width="48%">
O que a função `tem_tamanho_max` tem de diferente? \pause

- É declarada dentro de outra função; \pause

- Acessa uma variável (`max`) que não é um parâmetro, não é global e nem foi definida internamente na função.

\pause

Veremos a seguir que este tipo de função tem que ser tratada de forma diferente pelo compilador. \pause

Em Gleam, especificamente, a forma de definir funções desse tipo também é diferente. Por hora, vamos supor que a definição dessa maneira está correta.

</div>
</div>




Definições locais e fechamentos
===============================

## Definições locais e fechamentos

Uma **definição local** é aquela que não é feita no escopo global. \pause

Uma **variável livre** em relação a uma função é aquela que não é global, não é um parâmetro da função e nem foi declarada localmente dentro da função. \pause

Como uma função acessa um parâmetro ou uma variáveis local? \pause

Geralmente, consultando o registro de ativação, o quadro, da sua chamada. \pause

Como uma função acessa uma variável livre?


## Definições locais e fechamentos

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
fn maiores_string(lst: List(String)) {
  let max = tamanho_maximo(lst)

  fn tem_tamanho_max(s: String) -> Bool {
    string.length(s) == max
  }

  list.filter(lst, tem_tamanho_maximo)
}
```

</div>
<div class="column" width="48%">
\pause

A variável `max` existe independe da função `tem_tamanho_maximo` estar ativa (executando) ou não, logo ela não pode ser armazenada no registro de ativação de `tem_tamanho_maximo`. \pause

Então, como a variável livre `max` é acessada na função `tem_tamanho_maximo`? \pause

A função `tem_tamanho_maximo` deve "levar" junto com ela a variável livre `max`.

</div>
</div>


## Definições locais e fechamentos

O **ambiente léxico** é uma tabela com referências para as variáveis livres de uma função. \pause

Um **fechamento** (*closure* em inglês) é uma função junto com o seu ambiente léxico. \pause

\footnotesize

```gleam
fn maiores_string(lst: List(String)) -> List(String) {
  let max = tamanho_maximo(lst)
  fn tem_tamanho_max(s: String) -> Bool {
    string.length(s) == max
  }
  list.filter(lst, tem_tamanho_maximo)
}
```

\normalsize

Quando a função `tem_tamanho_maximo` é utilizada na chamada de `list.filter` um fechamento é passado como parâmetro.


## Exemplo em python

\footnotesize

```python

def maiores_strings(lst: list[str]) -> list[str]:
    tmax = tamanho_max(lst)

    def tem_tamanho_max(s: str) -> bool:
        return len(s) == tmax

    return list(filter(tem_tamanho_max, lst))


def tamanho_max(lst: list[str]) -> int:
    # max recebe um iterador
    return max(map(len, lst))
```


Funções anônimas
================

## Funções anônimas

Quando definimos uma função, estamos especificando duas coisas: **a função** e **o nome da função**. \pause

Da mesma forma que podemos utilizar expressões aritméticas sem precisar nomeá-las, também podemos utilizar funções (de maneira geral, expressões que resultam em funções) sem precisar nomeá-las. \pause

Uma função que não é nomeada é chamada de **função anônima**.


## Funções anônimas

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
> // Função anônima
> fn(x: Int) -> Int { x + 1 }
//fn(a) { ... }
```

\pause

```gleam
> // Chamada de função anônima
> fn(x: Int) -> Int { x + 1 }(3)
4
```

\pause

</div>
<div class="column" width="48%">
\footnotesize

```gleam
> // Armazenando função em variável
> let soma1 = fn(x: Int) -> Int { x + 1 }
//fn(a) { ... }
```

\pause

```gleam
> // Chamando a função armazenada
> soma1(3)
4
```

</div>
</div>


## Revisão maiores strings

<div class="columns">
<div class="column" width="48%">
Por questões de simplicidade de projeto, em Gleam, apenas funções anônimas podem ser declaradas dentro de outras funções. \pause

\footnotesize

\ \

```gleam
fn maiores_string(lst: List(String)) {
  let max = tamanho_maximo(lst)

  // Declaração inválida
  fn tem_tamanho_max(s: String) -> Bool {
    string.length(s) == max
  }

  list.filter(lst, tem_tamanho_maximo)
}
```

\pause

</div>
<div class="column" width="48%">
\footnotesize

```gleam
fn maiores_string(lst: List(String)) {
  let max = tamanho_maximo(lst)
  let tem_tamanho_max = fn(s: String) -> Bool {
    string.length(s) == max
  }
  list.filter(lst, tem_tamanho_maximo)
}
```
\pause

\normalsize

\ \

Ou sem armazenar a função em uma variável:

\ \

\footnotesize

```gleam
fn maiores_string(lst: List(String)) {
  let max = tamanho_maximo(lst)
  list.filter(fn(s) { string.length(s) == max })
}
```
</div>
</div>


## Funções anônimas

Em que situações devemos utilizar um funções anônimas? \pause

Como parâmetro, quando a função for pequena e necessária apenas naquele local: \pause

\footnotesize

```gleam
> list.map([3, 8, -6], fn(x) { x * 2 })
[6, 16, -12]
> list.filter([3, 20, -4, 48], fn(x) { x < 10 })
[3, -4]
```

\pause

Em Python

```python
>>> list(map(lambda x: x * 2, [3, 8, -6]))
[6, 16, -12]
>>> list(filter(lambda x: x < 10, [3, 20, -4, 48])
[3, -4]
```


## Funções anônimas

<div class="columns">
<div class="column" width="48%">
Defina a função `mapeia` em termos da função `reduz`.

\pause

\footnotesize

```gleam
fn mapeia(lst, f) {
  reduz(lst, fn(acc, e) {
    [f(e), ..acc]
  })
}
```

\pause

</div>
<div class="column" width="48%">

Defina a função `filtra` em termos da função `reduz`.

\pause

\footnotesize

```gleam
fn filtra(lst, pred) {
  reduz(lst, fn(acc, e) {
    case pred(e) {
      True -> [e, ..acc]
      False -> acc
    }
  })
}
```

</div>
</div>



## Funções anônimas

Em que situações devemos utilizar um funções anônimas? \pause

- Como parâmetro, quando a função for pequena e necessária apenas naquele local. \pause

- Como resultado de funções.



Funções que produzem funções
============================

## Funções que produzem funções

Como identificar a necessidade de criar e utilizar funções que produzem funções? \pause

- Parametrizar a criação de funções fixando alguns parâmetros; \pause

- Composição de funções; \pause

- ...


## Exemplo: somador

Defina uma função que receba um parâmetro $n$ e devolva uma função que soma o seu argumento a $n$.


## Exemplo: somador

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
> let soma1 = soma(1)
//fn(a) { ... }
> soma1(4)
5
> soma1(6)
7
```

\ \

\pause

```gleam
> soma(1)(2)
3
```

\ \

\pause

```gleam
> list.map([4, 1, 3], soma(5))
[9, 6, 8]
```

\pause
</div>
<div class="column" width="48%">

\scriptsize

```gleam
/// Devolve uma função que recebe um
/// parâmetro *x* e faz a soma de *n* e *x*.
pub fn soma(n: Int) -> fn(Int) -> Int {
  todo
}
```

\ \

\pause

```gleam
pub fn soma(n: Int) -> fn(Int) -> Int {
  fn(x: Int) -> Int { n + x }
}
```

\ \

\pause

```gleam
pub fn soma(n: Int) -> fn(Int) -> Int {
  fn(x) { n + x }
}
```

</div>
</div>


## Exemplo: negação

Defina uma função que receba como parâmetro um predicado (função de um parâmetro que produz booleano) e devolve uma função que devolve a negação do predicado.


## Exemplo: negação

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
> nega(list.is_empty)([])
False
> nega(list.is_empty)([1, 2])
True
```

\ \

\pause

```gleam
> filter([4, 1, 2, 0, 3], nega(int.is_odd))
[4, 2, 0]
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve uma função que é semelhante a
/// *pred*, mas que devolve a negação do
/// resultado de *pred*.
pub fn nega(
  pred: fn(a) -> Bool
) -> fn(a) -> Bool {
  todo
}
```

\pause

\ \

```gleam
pub fn nega(
  pred: fn(a) -> Bool
) -> fn(a) -> Bool {
  fn(x) { !pred(x) }
}
```

</div>
</div>


Açúcar sintático
================

## Açúcar sintático

Um **açúcar sintático** ([_syntatic sugar_](https://en.wikipedia.org/wiki/Syntactic_sugar)) é uma construção sintática de uma linguagens de programação que deixam o seu uso mais simples, ou doce, para os humanos. \pause

Vamos ver alguns açucares sintáticos do Gleam.


## Fechamento abreviado

O uso de fechamentos com um parâmetro é bastante comum, por isso, o Gleam oferece uma forma abreviada para criá-los. \pause

Um fechamento da forma `fn(x) { f(..., x, ...) }`{.gleam}, onde `f` é uma função qualquer e `...` são as variáveis livres do fechamento, pode ser escrito de forma abreviada como `f(..., _, ...)`{.gleam}, onde o marcador de posição `_` define o parâmetro para o fechamento. \pause

\centering

`f(..., _, ...)`{.gleam}

é a mesma coisa que

\centering

`fn(x) { f(..., x, ...) }`{.gleam}

\ \


## Fechamento abreviado

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
> // separa a string em ","
> let sep = ","
> let separa = fn(s) { string.split(s, sep) }
// fn(a) { ... }
> separa("12,2,-1")
["12", "2", "-1"]
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
> // forma abreviada
> let sep = ","
> let separa = string.split(_, sep)
// fn(a) { ... }
> separa("12,2,-1")
["12", "2", "-1"]
```
</div>
</div>

\ \
\pause

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
> // seleciona os elementos de a que estão em b
> let a = [1, 4, 2]
> let b = [3, 2, 7, 1]
> list.filter(a, fn(e) { list.contains(b, e) })
[1, 2]
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
> // de forma abreviada
> let a = [1, 4, 2]
> let b = [3, 2, 7, 1]
> list.filter(a, list.contains(b, _))
[1, 2]
```

</div>
</div>

\ \
\pause

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
> // soma 1 em cada elemento da lista
> list.map([3, 1, 4], fn(x) { x + 1 })
[4, 2, 5]
```

\pause

```gleam
> // em uma forma que pode ser abreviada
> list.map([3, 1, 4], fn(x) { int.add(x, 1) })
[4, 2, 5]
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
> // de forma abreviada
> list.map([3, 1, 4], int.add(_, 1))
[4, 2, 5]
```

</div>
</div>


## Cadeia de processamento

Um **cadeia de processamento**, ou _pipeline_, é uma sequência de operações onde a saída de uma operação é utilizada como entrada da próxima. \pause

A forma "comum" de chamar funções pode não ser adequada para uma cadeia de processamento com muitas etapas, isso porque a ordem de execução fica de "dentro para fora", o que dificulta a escrita e leitura do código. \pause

Gleam oferece o operador binário `|>` para facilitar as cadeias de processamento\pause

\centering

`a |> b(x, ..., z)`{.gleam}

é equivalente a

`b(a, x, ..., z)`{.gleam} ou `b(x, ..., z)(a)`{.gleam}

\ \


## Cadeia de processamento

\scriptsize

```gleam
fn tamanho_max(lst: List(String) -> Int {
  list.fold_rigth(list.map(lst, string.length), 0, int.max)
}
```

\pause

```gleam
fn tamanho_max(lst: List(String) -> Int {
  list.fold_rigth(
    list.map(lst, string.length),
    0,
    int.max,
  )
}
```

\pause

```gleam
fn tamanho_max(lst: List(String) -> Int {
  lst
  |> list.map(string.length)
  |> list.fold_right(0, int.max)
}
```


## Cadeia de processamento

\scriptsize

```gleam
// cria uma lista com todos os nomes que começam com a letra "a"
// enumerados em ordem alfabética.
> enumera_em_ordem_comeca_a(["pedro", "angela", "joao", "ana", "aline"])
["1. aline", "2. ana", "3. angela"]
```

\pause

```gleam
fn enumera_em_ordem_comeca_a(nomes: List(String)) -> List(String) {
  list.index_map(
    list.sort(list.filter(nomes, string.starts_with(_, "a")), string.compare),
    fn (nome, num) { int.to_string(num) <> ". " <> nome },
 )
}
```

\pause

```gleam
fn enumera_em_ordem_comeca_a(nomes: List(String)) -> List(String) {
  nomes
  |> list.filter(string.starts_with(_, "a"))
  |> list.sort(string.compare)
  |> list.index_map(fn (nome, num) { int.to_string(num) <> ". " <> nome })
}
```

</div>
</div>


## Use

As funções de alta ordem e o casamento de padrão são essenciais para a programação funcional. No entanto, em algumas situações, o uso dessas construções pode gerar indentação excessiva. \pause

Vamos rever um exemplo que vimos em tipos de dados.


## Use {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
fn soma(a: String, b: String)
  -> Result(Int, Nil) {
  case int.parse(a) {
    Ok(x) -> case int.parse(b) {
      Ok(y) -> Ok(x + y)
      Error(err) -> Error(err)
    }
    Error(err) -> Error(err)
  }
}
```

\ \

\pause

\small

Podemos melhorar? \pause

Existe um padrão recorrente no código: se o resultado for `Ok`{.gleam}, então, continue com outra operação, senão, pare e devolva o erro.

Podemos criar uma função de alta ordem `entao` para abstrair esse padrão. \pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
/// Excuta *fun* com o valor de *r* e
/// devolve seu resultado se *r* é Ok,
/// senão devolve o mesmo erro de *r*.
> entao(Ok(10), fn(x) { Ok(int.to_string(x)) })
Ok("10")
> entao(Error("a"), fn(x) { Ok(int.to_string(x)) })
Error("falhou")
> Ok("casa") |> entao(string.first)
Ok("c")

fn entao(
  r: Result(a, b),
  fun: fn(a) -> Result(c, b),
) -> Result(c, b) {
```

\pause

```gleam
  case r {
    Ok(value) -> fun(value)
    Error(error) -> Error(error)
  }
}
```

</div>
</div>


## Use {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
fn soma(a: String, b: String)
  -> Result(Int, Nil) {
  case int.parse(a) {
    Ok(x) -> case int.parse(b) {
      Ok(y) -> Ok(x + y)
      Error(err) -> Error(err)
    }
    Error(err) -> Error(err)
  }
}
```

\ \

\small

Podemos melhorar?

Existe um padrão recorrente no código: se o resultado for `Ok`{.gleam}, então, continue com outra operação, senão, pare e devolva o erro.

Podemos criar uma função de alta ordem `entao` para abstrair esse padrão.

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn soma(a: String, b: String) -> Result(Int, Nil) {
  entao(int.parse(a), fn(x) {
    entao(int.parse(b), fn(y) {
      Ok(x + y)
    })
  })
}
```

\pause

\small

\vspace{0.2cm}

A função `entao` está definida na biblioteca padrão como `result.then` e `result.try` (as duas funções fazem a mesma coisa).

\pause

\scriptsize

```gleam
fn soma(a: String, b: String) -> Result(Int, Nil) {
  result.try(int.parse(a), fn(x) {
    result.try(int.parse(b), fn(y) {
      Ok(x + y)
    })
  })
}
```

</div>
</div>


## Use {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
fn soma(a: String, b: String)
  -> Result(Int, Nil) {
  case int.parse(a) {
    Ok(x) -> case int.parse(b) {
      Ok(y) -> Ok(x + y)
      Error(err) -> Error(err)
    }
    Error(err) -> Error(err)
  }
}
```

\ \

```gleam
fn soma(a: String, b: String)
  -> Result(Int, Nil) {
  result.try(int.parse(a), fn(x) {
    result.try(int.parse(b), fn(y) {
      Ok(x + y)
    })
  })
}
```


</div>
<div class="column" width="48%">

\pause

\small

Podemos melhorar? \pause Sim! \pause

\scriptsize

\ \

```gleam
fn soma(a: String, b: String)
  -> Result(Int, Nil) {
  use x <- result.try(int.parse(a))
  use y <- result.try(int.parse(b))
  Ok(x + y)
}
```

\ \

\pause

\small

Apesar de parecem diferentes, as duas últimas definições da função `soma` são equivalentes! \pause

O `use`{.gleam} é apenas açúcar sintático para definir uma função anônima e passá-la como último parâmetro para uma chamada de função.

</div>
</div>


## Use {.t}

<div class="columns">
<div class="column" width="100%">

\small

O `use`{.gleam} permite utilizar funções anônimas como parâmetros sem aumentar a indentação do código. \pause

Uma chamada da forma

```gleam
funcao(a, b, ..., fn(x, y, ...) { corpo })
```

pode ser escrita como

```gleam
use x, y, ... <- funcao(a, b, ...)
corpo
```

\pause

A função que está sendo chamada pode receber qualquer quantidade de parâmetros, mas o último parâmetro precisa ser uma função. \pause

A função que está sendo passada como parâmetro também pode receber qualquer quantidade de parâmetros. \pause

No `use`{.gleam} os parâmetros para a função anônima ficam do lado esquerdo de `<-` e a função que está sendo chamada fica do lado direito. O corpo da função anônima inclui todo o código que está após o `use`, até fechar o bloco atual.

</div>
</div>


Outras funções de alta ordem
============================

## Outras funções de alta ordem

<div class="columns">
<div class="column" width="16%">
\scriptsize

```gleam
bool
  guard
  lazy_guard
```

\pause
</div>
<div class="column" width="16%">
\scriptsize

```gleam
option
  lazy_or
  lazy_unwrap
  map
  or
  then
```

\pause
</div>
<div class="column" width="16%">
\scriptsize

```gleam
result
  lazy_or
  lazy_unwrap
  map
  map_error
  then
  try
  try_recover
```

\pause
</div>
<div class="column" width="16%">
\scriptsize

```gleam
list
  all
  any
  drop_while
  filter_map
  find_map
  fold_until
  index_fold
  index_map
  map2
  map_fold
  sort
  split_while
  take_while
  try_fold
  try_map
```

\pause
</div>
<div class="column" width="16%">
\scriptsize

```gleam
dict
  filter
  fold
  map_values
```

\pause
</div>
<div class="column" width="16%">
\scriptsize

```gleam
set
  filter
  fold
  map
```
</div>
</div>


Referências
===========

## Referências

Básicas

- Vídeos [Abstractions](https://www.youtube.com/playlist?list=PL6NenTZG6KroSmESv5ItvLft76ZR8q-Nd)

- Capítulo [15](https://htdp.org/2022-8-7/Book/part_three.html#%28part._ch~3aabstract%29) do livro [HTDP](http://htdp.org)

- [Fechamento abreviado](https://tour.gleam.run/functions/function-captures/), [pipelines](https://tour.gleam.run/functions/pipelines/), [use](https://tour.gleam.run/advanced-features/use/) e [use sugar](https://tour.gleam.run/advanced-features/use-sugar/) do tour do Gleam.

Complementares

- Seções [1.3](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-12.html#%_sec_1.3) (1.3.1 e 1.3.2)   e [2.2.3](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.3) do livro [SICP](https://mitpress.mit.edu/sicp/)

- Seções [4.2](http://www.scheme.com/tspl4/binding.html#./binding:h2) e [5.5](http://www.scheme.com/tspl4/control.html#./control:h5) do livro [TSPL4](http://www.scheme.com/tspl4/)
