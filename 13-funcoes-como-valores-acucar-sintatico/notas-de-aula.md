---
# vim: set spell spelllang=pt_br sw=4:
title: Funções como valores
subtitle: Açúcar sintático
# TODO: rever referências
---

Introdução
==========

## Açúcar sintático

Um **açúcar sintático** ([_syntactic sugar_](https://en.wikipedia.org/wiki/Syntactic_sugar)) é uma construção sintática que deixa o código mais simples, ou doce, de ler e escrever, mas que não acrescenta nada ao que a linguagem pode expressar, pois pode ser traduzida para construções que já existem. \pause

Vamos ver alguns açúcares sintáticos do Gleam e a tradução de cada um.


Definição local
===============


## Definição local

No capítulo **Fundamentos** entendemos o `let`{.gleam} traduzindo a definição local para uma chamada de função auxiliar, que precisava ter um nome e receber como parâmetro tudo o que usava. \pause Com uma função anônima, que leva junto as suas variáveis livres, a tradução fica: \pause

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
fn custo_combustivel(
  distancia,
  preco_do_litro,
  rendimento,
) {
  let litros =
    distancia /. rendimento
  litros *. preco_do_litro
}
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn custo_combustivel(
  distancia,
  preco_do_litro,
  rendimento,
) {
  fn(litros) {
    litros *. preco_do_litro
  }(distancia /. rendimento)
}
```

</div>
</div>

\pause

Ou seja, o `let`{.gleam} é açúcar sintático para a definição de uma função anônima seguida da sua aplicação, e a versão com `let`{.gleam} é bem mais fácil de ler.


## Definição local

E quando temos uma sequência de definições locais? \pause Basta aninhar as funções anônimas: \pause

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
let a = expressão1
let b = expressão2
expressão3
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn(a) {
  fn(b) {
    expressão3
  }(expressão2)
}(expressão1)
```

</div>
</div>

\pause

Note que `expressão2`{.gleam} está dentro da função de `a`{.gleam} e fora da função de `b`{.gleam}, isto é, ela pode usar `a`{.gleam}, mas não `b`{.gleam}.


## Definição local

A tradução também explica o que acontece quando uma definição local usa um nome que já existe: \pause

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam-repl
> let x = 1
> let x = x + 10
> x
11
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn(x) {
  fn(x) { x }(x + 10)
}(1)
```

</div>
</div>

\pause

O segundo `let`{.gleam} não modifica o `x`{.gleam} anterior: ele define um novo nome, em uma função interna, que **esconde** o de fora — dizemos que o `x`{.gleam} de fora foi **sombreado**. \pause O `x + 10`{.gleam} está fora dessa função interna, por isso usa o `x`{.gleam} de fora.


Fechamento abreviado
====================


## Fechamento abreviado

O uso de fechamentos com um parâmetro é bastante comum; por isso, o Gleam oferece uma forma abreviada para criá-los (chamada de _function capture_ na documentação do Gleam). \pause

Um fechamento da forma `fn(x) { f(..., x, ...) }`{.gleam}, onde `f` é uma função qualquer e `...` são os demais argumentos (constantes, variáveis livres ou outras expressões), pode ser escrito de forma abreviada como `f(..., _, ...)`{.gleam}, onde o marcador de posição `_` define o parâmetro do fechamento. O `_` pode aparecer apenas uma vez e precisa ser diretamente um dos argumentos da chamada: `_ + 1`{.gleam} não é um fechamento abreviado, e em `f(g(_))`{.gleam} a função abreviada é só `g(_)`{.gleam}, isto é, `f(fn(x) { g(x) })`{.gleam}. \pause

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

```gleam-repl
> // separa a string em ","
> let sep = ","
> let separa = fn(s) { string.split(s, sep) }
//fn(a) { ... }
> separa("12,2,-1")
["12", "2", "-1"]
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam-repl
> // forma abreviada
> let sep = ","
> let separa = string.split(_, sep)
//fn(a) { ... }
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

```gleam-repl
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

```gleam-repl
> // forma abreviada
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

```gleam-repl
> // soma 1 em cada elemento da lista
> list.map([3, 1, 4], fn(x) { x + 1 })
[4, 2, 5]
```

\pause

```gleam-repl
> // em uma forma que pode ser abreviada
> list.map([3, 1, 4], fn(x) { int.add(x, 1) })
[4, 2, 5]
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam-repl
> // forma abreviada
> list.map([3, 1, 4], int.add(_, 1))
[4, 2, 5]
```

</div>
</div>


## Currying

Em algumas linguagens funcionais, como Haskell e OCaml, toda função recebe um parâmetro por vez: uma função de "dois parâmetros" é, na verdade, uma função que recebe o primeiro parâmetro e devolve uma função que recebe o segundo. Essa técnica é chamada de **currying**. \pause

Em Gleam, seria como se `int.add`{.gleam} fosse definida como a função `soma` que fizemos no capítulo **Funções como valores: fechamentos**:

\footnotesize

```gleam
fn add(a: Int) -> fn(Int) -> Int {
  fn(b) { a + b }
}
```

\small

\pause

Assim, a soma seria chamada como `add(1)(2)`{.gleam}, e `add(1)`{.gleam} sozinho seria uma função que soma 1. \pause

Em Gleam as funções recebem todos os parâmetros de uma vez, então `int.add(1)`{.gleam} é um erro. Para fixar um argumento, usamos o fechamento abreviado, como em `int.add(1, _)`{.gleam}, o que é chamado de **aplicação parcial**.


Cadeia de processamento
=======================


## Cadeia de processamento

Uma **cadeia de processamento**, ou _pipeline_, é uma sequência de operações em que a saída de uma operação é utilizada como entrada da próxima. \pause

A forma "comum" de chamar funções pode não ser adequada para uma cadeia de processamento com muitas etapas, porque a ordem de execução fica de "dentro para fora", o que dificulta a escrita e a leitura do código. \pause

Gleam oferece o operador binário `|>` para facilitar as cadeias de processamento: \pause

\centering

`a |> b(x, ..., z)`{.gleam} é equivalente a `b(a, x, ..., z)`{.gleam}

\raggedright

\pause

Isto é, o valor à esquerda é passado como **primeiro** argumento da função à direita. (Se `b(x, ..., z)`{.gleam} produzir uma função, o valor é passado para ela, como em `b(x, ..., z)(a)`{.gleam}.)


## Cadeia de processamento

Quando a função à direita não recebe outros argumentos, os parênteses podem ser omitidos: `a |> f`{.gleam} é equivalente a `f(a)`{.gleam}. \pause

Para passar o valor em outra posição, combinamos o `|>` com o fechamento abreviado: `a |> f(x, _)`{.gleam} é equivalente a `f(x, a)`{.gleam}. \pause

\small

```gleam-repl
> "  casa " |> string.trim |> string.length
4
> 10 |> int.subtract(2)
8
> 10 |> int.subtract(2, _)
-8
```


## Cadeia de processamento

\scriptsize

```gleam
fn tamanho_maximo(lst: List(String)) -> Int {
  list.fold_right(list.map(lst, string.length), 0, int.max)
}
```

\pause

```gleam
fn tamanho_maximo(lst: List(String)) -> Int {
  list.fold_right(
    list.map(lst, string.length),
    0,
    int.max,
  )
}
```

\pause

```gleam
fn tamanho_maximo(lst: List(String)) -> Int {
  lst
  |> list.map(string.length)
  |> list.fold_right(0, int.max)
}
```


## Cadeia de processamento

\scriptsize

```gleam-repl
> // cria uma lista com todos os nomes que começam com a letra "a"
> // enumerados em ordem alfabética.
> enumera_em_ordem_comeca_a(["pedro", "angela", "joao", "ana", "aline"])
["1. aline", "2. ana", "3. angela"]
```

\pause

```gleam
fn enumera_em_ordem_comeca_a(nomes: List(String)) -> List(String) {
  list.index_map(
    list.sort(list.filter(nomes, string.starts_with(_, "a")), string.compare),
    fn(nome, num) { int.to_string(num + 1) <> ". " <> nome },
  )
}
```

\pause

```gleam
fn enumera_em_ordem_comeca_a(nomes: List(String)) -> List(String) {
  nomes
  |> list.filter(string.starts_with(_, "a"))
  |> list.sort(string.compare)
  |> list.index_map(fn(nome, num) { int.to_string(num + 1) <> ". " <> nome })
}
```


Use
===


## Use

As funções de alta ordem e o casamento de padrões são essenciais para a programação funcional. No entanto, em algumas situações, o uso dessas construções pode gerar indentação excessiva. \pause

Vamos rever um exemplo que vimos no capítulo **Funções totais**.


## Use {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
fn soma(a: String, b: String)
  -> Result(String, Nil) {
  case int.parse(a) {
    Ok(x) -> case int.parse(b) {
      Ok(y) -> Ok(int.to_string(x + y))
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

Existe um padrão recorrente no código: se o resultado for `Ok`{.gleam}, então continue com outra operação; senão, pare e devolva o erro.

Podemos criar uma função de alta ordem `entao` para abstrair esse padrão. \pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
/// Executa *fun* com o valor de *r* e
/// devolve seu resultado se *r* é Ok,
/// senão devolve o mesmo erro de *r*.
```

```gleam-repl
> entao(Ok(10), fn(x) { Ok(int.to_string(x)) })
Ok("10")
> entao(Error("falhou"),
        fn(x) { Ok(int.to_string(x)) })
Error("falhou")
> Ok("casa") |> entao(string.first)
Ok("c")
```

```gleam
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
  -> Result(String, Nil) {
  case int.parse(a) {
    Ok(x) -> case int.parse(b) {
      Ok(y) -> Ok(int.to_string(x + y))
      Error(err) -> Error(err)
    }
    Error(err) -> Error(err)
  }
}
```

\ \

\small

Podemos melhorar?

Existe um padrão recorrente no código: se o resultado for `Ok`{.gleam}, então continue com outra operação; senão, pare e devolva o erro.

Podemos criar uma função de alta ordem `entao` para abstrair esse padrão.

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn soma(a: String, b: String)
  -> Result(String, Nil) {
  entao(int.parse(a), fn(x) {
    entao(int.parse(b), fn(y) {
      Ok(int.to_string(x + y))
    })
  })
}
```

\pause

\small

\vspace{0.2cm}

A função `entao` está definida na biblioteca padrão como `result.try`.

\pause

\scriptsize

```gleam
fn soma(a: String, b: String)
  -> Result(String, Nil) {
  result.try(int.parse(a), fn(x) {
    result.try(int.parse(b), fn(y) {
      Ok(int.to_string(x + y))
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
  -> Result(String, Nil) {
  case int.parse(a) {
    Ok(x) -> case int.parse(b) {
      Ok(y) -> Ok(int.to_string(x + y))
      Error(err) -> Error(err)
    }
    Error(err) -> Error(err)
  }
}
```

\ \

```gleam
fn soma(a: String, b: String)
  -> Result(String, Nil) {
  result.try(int.parse(a), fn(x) {
    result.try(int.parse(b), fn(y) {
      Ok(int.to_string(x + y))
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
  -> Result(String, Nil) {
  use x <- result.try(int.parse(a))
  use y <- result.try(int.parse(b))
  Ok(int.to_string(x + y))
}
```

\ \

\pause

\small

Apesar de parecerem diferentes, as duas últimas definições da função `soma` são equivalentes! \pause

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

No `use`{.gleam} os parâmetros para a função anônima ficam do lado esquerdo de `<-` e a função que está sendo chamada fica do lado direito. O corpo da função anônima inclui todo o código que está após o `use`{.gleam}, até fechar o bloco atual.

</div>
</div>


## Use {.t}

\small

A função anônima pode não ter parâmetros; nesse caso nada é escrito antes de `<-`. Um exemplo é a função `bool.guard(cond, valor, f)`{.gleam}, que devolve `valor` se `cond` é verdadeiro, senão devolve o resultado de `f()`{.gleam}. \pause

\scriptsize

<div class="columns">
<div class="column" width="48%">

```gleam
fn divide(a: Int, b: Int) -> Result(Int, Nil) {
  bool.guard(b == 0, Error(Nil), fn() {
    Ok(a / b)
  })
}
```

</div>
<div class="column" width="48%">

```gleam
fn divide(a: Int, b: Int) -> Result(Int, Nil) {
  use <- bool.guard(b == 0, Error(Nil))
  Ok(a / b)
}
```

</div>
</div>

\pause

\small

O `use`{.gleam} é adequado quando a função anônima é a continuação do cálculo, isto é, o resto do corpo da função, como em `result.try`{.gleam} e `bool.guard`{.gleam}.


Outras funções de alta ordem
============================

## Outras funções de alta ordem

A biblioteca padrão tem muitas outras funções de alta ordem além de `map`, `filter` e `fold_right`. \pause

\footnotesize

```gleam-repl
> list.all([2, 4, 5], int.is_even)             // para no primeiro False
False
> list.any([1, 3, 4], int.is_even)             // para no primeiro True
True
> list.find([1, 3, 4, 6], int.is_even)         // primeiro que satisfaz
Ok(4)
> list.take_while([2, 4, 5, 6], int.is_even)   // prefixo que satisfaz
[2, 4]
> list.filter_map(["1", "a", "3"], int.parse)  // mapeia e mantém os Ok
[1, 3]
```

\normalsize

\pause

Ao contrário de `map`, `filter` e `fold_right`, as funções `all`, `any`, `find` e `take_while` podem parar antes de processar a lista inteira.


## Outras funções de alta ordem

Algumas funções de alta ordem da biblioteca padrão (veja a documentação de cada módulo):

<div class="columns">
<div class="column" width="16%">
\scriptsize

[bool](https://hexdocs.pm/gleam_stdlib/gleam/bool.html)

```gleam
guard
lazy_guard
```

\pause
</div>
<div class="column" width="16%">
\scriptsize

[option](https://hexdocs.pm/gleam_stdlib/gleam/option.html)

```gleam
lazy_or
lazy_unwrap
map
then
```

\pause
</div>
<div class="column" width="16%">
\scriptsize

[result](https://hexdocs.pm/gleam_stdlib/gleam/result.html)

```gleam
lazy_or
lazy_unwrap
map
map_error
try
try_recover
```

\pause
</div>
<div class="column" width="16%">
\scriptsize

[list](https://hexdocs.pm/gleam_stdlib/gleam/list.html)

```gleam
all
any
drop_while
filter_map
find
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

[dict](https://hexdocs.pm/gleam_stdlib/gleam/dict.html)

```gleam
filter
fold
map_values
```

\pause
</div>
<div class="column" width="16%">
\scriptsize

[set](https://hexdocs.pm/gleam_stdlib/gleam/set.html)

```gleam
filter
fold
map
```
</div>
</div>

Revisão
=======


## Revisão

Quais açúcares sintáticos do Gleam vimos? Qual é a forma equivalente de cada um? \pause

- `let x = e`{.gleam} seguido de `corpo` é o mesmo que `fn(x) { corpo }(e)`{.gleam}; \pause

- `f(_, b)`{.gleam} é o mesmo que `fn(x) { f(x, b) }`{.gleam}; \pause

- `a |> f(b)`{.gleam} é o mesmo que `f(a, b)`{.gleam}; \pause

- `use x <- f(a)`{.gleam} seguido de `corpo` é o mesmo que `f(a, fn(x) { corpo })`{.gleam}.


## Revisão

Por que `let x = x + 10`{.gleam} não modifica o `x`{.gleam} que já existia? \pause

- Porque o `let`{.gleam} define um novo nome, parâmetro de uma função interna, que sombreia o anterior. A expressão `x + 10`{.gleam} fica fora dessa função e usa o `x`{.gleam} de fora. \pause

O que é currying? Como fixamos um argumento de uma função em Gleam? \pause

- No currying, toda função recebe um parâmetro por vez e devolve uma função que recebe o próximo. Em Gleam as funções recebem todos os parâmetros de uma vez, então usamos o fechamento abreviado, como em `int.add(1, _)`{.gleam}. \pause

Que padrão de código a função `result.try`{.gleam} abstrai? \pause

- Se o resultado é `Ok`{.gleam}, continua a computação com o valor; senão, para e devolve o mesmo erro.


Referências
===========

## Referências

Básicas

- [Fechamento abreviado](https://tour.gleam.run/functions/function-captures/), [pipelines](https://tour.gleam.run/functions/pipelines/) e [use](https://tour.gleam.run/advanced-features/use/) do tour do Gleam.

Complementares

- Seções [4.2](http://www.scheme.com/tspl4/binding.html#./binding:h2) (_Lambda_) e [4.4](http://www.scheme.com/tspl4/binding.html#./binding:h4) (_Local Binding_) do livro [TSPL4](http://www.scheme.com/tspl4/)

- Seção [1.3.2](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-12.html#%_sec_1.3.2) do livro [SICP](https://mitpress.mit.edu/sicp/)
