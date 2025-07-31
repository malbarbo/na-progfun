---
# vim: set spell spelllang=pt_br sw=4:
title: Resumo da linguagem Gleam
urlcolor: Black
classoption:
- twocolumn
fontsize: 10pt
header-includes:
- \pagenumbering{gobble}
license:
---

# Tipos e operações primitivas

## Números inteiros (`Int`{.gleam})

```gleam
> 3 + 4
7
> 12 - 25
-13
> 10 * 3
30
> 14 / 3
4
> 14 % 3
2
> 4 < 2
False
> int.to_float(4)
4.0
> int.to_string(123)
"123"
> int.parse("432")
Ok(432)
> int.parse("a")
Error(Nil)
```

## Números de ponto flutuante (`Float`{.gleam})

```gleam
> 3.1 +. 2.0
6.2
> 12.4 -. 25.0
-12,6
> 10.0 *. 3.0
30.0
> 14.0 /. 3.0
4.666666666666667
> 3.0 >=. 2.0
True
> float.truncate(2.6)
2
> float.round(2.6)
3
> float.to_string(4.1)
"4.1"
> float.parse("10.1")
Ok(10.1)
> float.parse("10")
Error(Nil)
```

## Cadeia de caracteres (`String`{.gleam})

```gleam
> "casa" <> " verde"
"casa verde"
> string.length("outra")
5
> string.slice("palavra", 2, 3)
"lav"
> string.repeat("abc", 3)
"abcabcabc"
```


## Booleanos (`Bool`{.gleam})

```gleam
> !True // negação
False
> !False
True
> True && True // e lógico
True
> True && False
False
> True || False // ou lógico
True
> False || False
False
```


## Listas (`List`{.gleam})

```gleam
> [] // Lista vazia
[]
> let lst1 = [2, 3] // Literal
[2, 3]
> [4, ..lst1] // Construção
[4, 2, 3]
```


## Igualdade

```gleam
> 4 == 1 + 3
True
> 1.2 == 3.0
False
> [4, 1, 2] == [4, ..[1, 2]]
True
> "aaa" != string.repeat("a", 4)
True
```


# Sintaxe

## Importação

```gleam
import gleam/módulo
```

## Função

```gleam
// Definição de função
pub fn nome(nome: Tipo, …) -> Tipo {
  expressão
  ...
}

// Chamada de função
nome(expressão, ...)

// Seleção
case expressão, expressão, … {
  padrão, padrão, ... if cond -> expressão
  padrão, padrão, ... -> expressão
  padrão, _, ... -> expressão
  ...
  _, _, … -> expressão
}
```

## Enumeração

```gleam
pub type Nome {
  Valor
  ...
}
```

## Estrutura

```gleam
pub type Nome {
  Nome([campo:] Tipo, ...)
}

pub type Ponto {
  Ponto(x: Int, y: Int)
}

> let p1 = Ponto(10, 20)
Ponto(x: 10, y: 20)
> p1.x + p1.y
30
> let p2 = Ponto(..p1, x: 30)
Ponto(x: 30, y: 20)
```

## União

```gleam
pub type Nome {
  Caso1[([campo:] Tipo, ...)]
  Caso2[([campo:] Tipo, ...)]
  ...
}
```


# Testes

```gleam
import sgleam/check

pub fn nome_examples() {
  check.eq(nome(expressão, ...), valor)
  ...
}
```


# Modelo para listas

```gleam
pub fn fn_para_list(lst: List(a)) {
  case lst {
    [] -> todo
    [primeiro, ..resto] -> {
      todo primeiro fn_para_list(resto)
    }
  }
}
```

# Exemplos

## Soma 1

```gleam
/// Soma 1 ao valor de *a*.
pub fn soma1(a: Option(Int)) -> Option(Int) {
  case a {
    None -> None
    Some(x) -> Some(x + 1)
  }
}
```

## Soma string

```gleam
/// Devolve a soma de *a* e *b* se as strings
/// representam Int, senão devolve Error(Nil).
pub fn soma(
  a: String,
  b: String
) -> Result(String, Nil) {
  case int.parse(a), int.parse(b) {
    Ok(a), Ok(b) -> Ok(int.to_string(a + b))
    _, _ -> Error(Nil)
  }
}
```


## Soma lista

```gleam
/// Soma os elementos de *lst*.
pub fn soma(lst: List(a)) {
  case lst {
    [] -> 0
    [primeiro, ..resto] -> primeiro + soma(resto)
  }
}
```


## Funções de alta ordem

```gleam
> list.filter([7, 3, 6, 2, 9], int.is_odd) // é impar
[7, 3, 9]
> list.filter([-4, 1, 3, -2, 9], fn(x) { x > 0 })
[1, 3, 9]

> list.map([5, 1, 6, 8], int.to_string)
["5", "1", "6", "8"]
> list.map(["a", "b", ""], fn(s) { s <> "!" })
["a!", "b!", "!"]

> list.fold_right([5, 1, 2], 1, fn(acc, e) { acc * e})
10
> let lst = [1, 2, 3]
> list.fold_right(lst, [], fn(acc, e) { [e, ..acc] })
[1, 2, 3]
> list.fold(lst, [], fn(acc, e) { [e, ..acc] })
[3, 2, 1]
```


## Cadeia de processamento

```gleam
> [5, 1, 3, 2, 7]
  |> list.map(int.add(_, 1))
  |> list.filter(int.is_even) // é par
[6, 2, 4, 8]
```
