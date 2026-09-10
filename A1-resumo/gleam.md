---
# vim: set spell spelllang=pt_br sw=4:
title: Resumo da linguagem Gleam
author: Marco A L Barbosa \quad \href{https://malbarbo.pro.br}{malbarbo.pro.br}
urlcolor: Black
classoption:
- twocolumn
documentclass: extarticle
fontsize: 9pt
geometry:
- margin=1cm
- nofoot
- nohead
header-includes: |
    ```{=latex}
    \pagenumbering{gobble}
    \setlength{\parskip}{2.2pt plus 1pt minus 1pt}
    \setlength{\columnsep}{1.2em}
    \usepackage{titlesec}
    \titleformat*{\section}{\large\bfseries}
    \titlespacing*{\section}{0pt}{1.4ex plus .2ex}{0.6ex}
    \titlespacing*{\subsection}{0pt}{1.2ex plus .2ex}{0.4ex}
    \makeatletter
    \renewcommand{\@maketitle}{%
      \begin{center}
        {\LARGE\bfseries\@title}\quad\textbullet\quad\@author
      \end{center}
      \par\noindent\rule{0pt}{1.4em}}
    \makeatother
    ```
license:
---

# Importação

```gleam
// Forma geral
import gleam/módulo

// Módulos usados neste resumo
import gleam/float
import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string
import sgleam/check
```


# Números inteiros (`Int`{.gleam})

```gleam-repl
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
> int.max(3, 7)
7
> int.min(3, 7)
3
> int.to_float(4)
4.0
> int.to_string(123)
"123"
> int.parse("432")
Ok(432)
> int.parse("a")
Error(Nil)
```


# Números de ponto flutuante (`Float`{.gleam})

```gleam-repl
> 3.1 +. 2.0
5.1
> 12.4 -. 25.0
-12.6
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


# Cadeia de caracteres (`String`{.gleam})

```gleam-repl
> "casa" <> " verde"
"casa verde"
> string.length("outra")
5
> string.slice("palavra", 2, 3)
"lav"
> string.repeat("abc", 3)
"abcabcabc"
```


# Booleanos (`Bool`{.gleam})

```gleam-repl
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


# Listas (`List`{.gleam})

```gleam-repl
> [] // Lista vazia
[]
> let lst1 = [2, 3] // Literal
[2, 3]
> [4, ..lst1] // Construção
[4, 2, 3]
```


# Igualdade

```gleam-repl
> 4 == 1 + 3
True
> 1.2 == 3.0
False
> [4, 1, 2] == [4, ..[1, 2]]
True
> "aaa" != string.repeat("a", 4)
True
```


# Função

```gleam
// Definição de função
pub fn nome(parâmetro: Tipo, ...) -> Tipo {
  expressão
  ...
}
// Chamada de função
nome(expressão, ...)
nome(_, y)    // captura: fn(x) { nome(x, y) }
x |> nome(y)  // encadeamento: nome(x, y)
```


# Seleção

```gleam
case expressão, expressão, ... {
  padrão, padrão, ... if cond -> expressão
  padrão, padrão, ... -> expressão
  padrão, _, ... -> expressão
  ...
  _, _, ... -> expressão
}
```


# Definição de tipo

```gleam
[pub] [opaque] type Nome[(a, ...)] {
  Construtor[([campo:] Tipo, ...)]
  ...
}
```

- `pub`{.gleam}: o tipo pode ser usado em outros módulos.
- `opaque`{.gleam}: apenas o módulo que define o tipo tem
  acesso aos construtores e campos, o que permite
  criar um tipo abstrato de dado (TAD).
- `a`{.gleam}: parâmetro de tipo, pode ser instanciado
  com qualquer tipo.

Enumeração (construtores sem campos):

```gleam
pub type Combustivel {
  Alcool
  Gasolina
}
```

Estrutura (um único construtor):

```gleam
pub type Ponto {
  Ponto(x: Int, y: Int)
}
```

```gleam-repl
> let p1 = Ponto(10, 20)
Ponto(x: 10, y: 20)
> p1.x + p1.y
30
> let p2 = Ponto(..p1, x: 30)
Ponto(x: 30, y: 20)
```

União (vários construtores):

```gleam
pub type EstadoTarefa {
  Executando
  Sucesso(duracao: Int, msg: String)
  Erro(codigo: Int, msg: String)
}
```


# Option

Representa um valor que pode estar ausente.

```gleam
pub type Option(a) { // já em gleam/option
  None
  Some(a)
}
```

```gleam-repl
> Some(4)
Some(4)
> None
None
```


# Result

Representa o resultado de uma operação que pode
falhar. Em Gleam, toda função que pode falhar
devolve `Result`{.gleam}, e `Nil`{.gleam} é usado como erro
quando não há detalhe a dar sobre a falha.

```gleam
pub type Result(ok, error) { // já na linguagem
  Ok(ok)
  Error(error)
}
```

```gleam-repl
> int.divide(25, 3)
Ok(8)
> int.divide(12, 0)
Error(Nil)
> float.square_root(-1.0)
Error(Nil)
> string.first("casa")
Ok("c")
> string.first("")
Error(Nil)
```


# Testes

```gleam
pub fn nome_examples() {
  check.eq(nome(expressão, ...), valor)
  ...
}
```


# Modelo para listas

```gleam
pub fn fn_para_list(lst: List(a)) {
  case lst {
    [] -> todo // não escrito, falha se executado
    [primeiro, ..resto] -> {
      todo primeiro fn_para_list(resto)
    }
  }
}
```


# Exemplo - Soma 1

```gleam
/// Soma 1 ao valor de *a*.
pub fn soma1(a: Option(Int)) -> Option(Int) {
  case a {
    None -> None
    Some(x) -> Some(x + 1)
  }
}
```


# Exemplo - Soma string

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


# Exemplo - Soma lista

```gleam
/// Soma os elementos de *lst*.
pub fn soma(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [primeiro, ..resto] -> primeiro + soma(resto)
  }
}
```


# Exemplo - Tipo abstrato de dado

```gleam
/// O preço do litro do combustível.
pub opaque type Preco {
  Preco(valor: Float)
}

/// Devolve Ok(Preco) com o valor *v* se
/// v > 0, Error(Nil) caso contrário.
pub fn preco(v: Float) -> Result(Preco, Nil) {
  case v >. 0.0 {
    True -> Ok(Preco(v))
    False -> Error(Nil)
  }
}

/// Devolve o valor em *p*.
pub fn valor(p: Preco) -> Float {
  p.valor
}
```

```gleam-repl
> let assert Ok(p) = preco(4.2)
Ok(Preco(valor: 4.2))
> valor(p)
4.2
> preco(-1.0)
Error(Nil)
```


# Exemplo - Funções de alta ordem

```gleam-repl
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
[1, 2, 3]
> list.fold_right(lst, [], fn(acc, e) { [e, ..acc] })
[1, 2, 3]
> list.fold(lst, [], fn(acc, e) { [e, ..acc] })
[3, 2, 1]
```


# Exemplo - Cadeia de processamento

```gleam-repl
> [5, 1, 3, 2, 7]
  |> list.map(int.add(_, 1))
  |> list.filter(int.is_even) // é par
[6, 2, 4, 8]
```
