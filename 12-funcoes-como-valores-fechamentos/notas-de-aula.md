---
# vim: set spell spelllang=pt_br sw=4:
title: Funções como valores
subtitle: Fechamentos
# TODO: rever referências
---

Introdução
==========


## Introdução

No capítulo **Funções como valores: abstração** passamos como argumento funções que já existiam e tinham nome, como `int.negate`{.gleam} e `sinal`. \pause

Neste capítulo veremos como criar funções durante a execução do programa: \pause

- Funções que usam valores definidos localmente (fechamentos); \pause

- Funções sem nome (funções anônimas); \pause

- Funções que produzem funções.



Motivação
=========


## Exemplo: maiores strings

Projete uma função que receba como entrada uma lista de strings e devolva uma lista com as strings de tamanho máximo entre todas as strings da lista.


## Exemplo: maiores strings

\scriptsize

```gleam
/// Cria uma lista com as strings de *lst* que têm tamanho máximo entre todas
/// as strings de *lst*.
fn maiores_strings(lst: List(String)) -> List(String) {
  todo
}

check.eq(
  maiores_strings(["oi", "casa", "aba", "boi", "eita", "a", "cadê"]),
  ["casa", "eita", "cadê"]
)
```


\pause

\small

Podemos usar `map`, `filter` ou `fold_right` para implementar a função? \pause Parece complicado... \pause

Vamos separar a solução em duas etapas: encontrar o tamanho máximo e depois selecionar as strings com tamanho máximo.

## Exemplo: maiores strings

<div class="columns">
<div class="column" width="48%">

\scriptsize

```gleam
/// Devolve o tamanho máximo entre
/// todas as strings de *lst*.
fn tamanho_maximo(lst: List(String)) -> Int {
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

\ \

Podemos usar `map`, `filter` ou `fold_right` para implementar a função? \pause Sim, usando o `fold_right`, mas parece complicado... \pause

</div>
<div class="column" width="48%">

\small

A função para o `fold_right` teria que fazer duas coisas: determinar o tamanho de uma string e indicar qual é o máximo entre dois tamanhos. \pause

Podemos fazer em duas etapas: usamos o `map` para obter uma lista com os tamanhos e o `fold_right` para determinar o valor máximo. \pause

\scriptsize

\ \

```gleam
/// Devolve o tamanho máximo entre
/// todas as strings de *lst*.
fn tamanho_maximo(lst: List(String)) -> Int {
  list.fold_right(
    list.map(lst, string.length),
    0,
    int.max
  )
}
```


</div>
</div>


## Exemplo: maiores strings

<div class="columns">
<div class="column" width="48%">

\scriptsize

```gleam
fn maiores_strings(lst: List(String))
  -> List(String) {
  let max = tamanho_maximo(lst)
  // Como definimos a função
  // tem_tamanho_maximo?
  list.filter(lst, tem_tamanho_maximo)
}
```

\ \

\pause

```gleam
fn maiores_strings(lst: List(String))
  -> List(String) {
  let max = tamanho_maximo(lst)

  fn tem_tamanho_maximo(s: String) -> Bool {
    string.length(s) == max
  }

  list.filter(lst, tem_tamanho_maximo)
}
```

\pause

</div>
<div class="column" width="48%">

\small

O que a função `tem_tamanho_maximo` tem de diferente? \pause

- É declarada dentro de outra função; \pause

- Acessa uma variável (`max`) que não é um parâmetro, não é global e nem foi definida internamente na função.

\pause

Veremos a seguir que este tipo de função tem que ser tratado de forma diferente pelo compilador. \pause

Em Gleam, especificamente, a forma de definir funções desse tipo também é diferente. Por ora, vamos supor que a definição dessa maneira está correta.

</div>
</div>




Definições locais e fechamentos
===============================

## Definições locais e fechamentos

Uma **definição local** é aquela que não é feita no escopo global. \pause

Uma **variável livre** em relação a uma função é uma variável usada no corpo da função que não é global, não é um parâmetro da função nem foi definida dentro da função. \pause

Como uma função acessa um parâmetro ou uma variável local? \pause

Geralmente, consultando o **registro de ativação** (ou quadro) da sua chamada: a área de memória criada a cada chamada da função para guardar os parâmetros e as variáveis locais, e que é descartada quando a chamada termina. \pause

Como uma função acessa uma variável livre?


## Definições locais e fechamentos

<div class="columns">
<div class="column" width="48%">

\scriptsize

```gleam
fn maiores_strings(lst: List(String))
  -> List(String) {
  let max = tamanho_maximo(lst)

  fn tem_tamanho_maximo(s: String) -> Bool {
    string.length(s) == max
  }

  list.filter(lst, tem_tamanho_maximo)
}
```

</div>
<div class="column" width="48%">
\pause

\small

A variável `max` existe independentemente de a função `tem_tamanho_maximo` estar ativa (executando) ou não, logo ela não pode ser armazenada no registro de ativação de `tem_tamanho_maximo`. \pause

\ \

Então, como a variável livre `max` é acessada na função `tem_tamanho_maximo`? \pause

\ \

A função `tem_tamanho_maximo` deve "levar" junto com ela a variável livre `max`.

</div>
</div>


## Definições locais e fechamentos

\small

O **ambiente léxico** de uma função é uma tabela com referências para as variáveis livres da função, determinada pelo local do texto do programa em que a função foi criada (e não pelo local em que ela é chamada). \pause

Um **fechamento** (*closure* em inglês) é uma função junto com o seu ambiente léxico. \pause

\scriptsize

```gleam
fn maiores_strings(lst: List(String)) -> List(String) {
  let max = tamanho_maximo(lst)
  fn tem_tamanho_maximo(s: String) -> Bool {
    string.length(s) == max
  }
  list.filter(lst, tem_tamanho_maximo)
}
```

\small

Quando a função `tem_tamanho_maximo` é utilizada na chamada de `list.filter`{.gleam}, um fechamento é passado como argumento: o `list.filter`{.gleam} chama a função em um local em que `max` não existe, e mesmo assim ela usa o `max` de `maiores_strings`.


## Exemplo em Python

\small

Em Python, uma função com nome pode ser definida dentro de outra função e também é um fechamento: `tem_tamanho_maximo` usa a variável livre `tmax`.

\scriptsize

```python
def maiores_strings(lst: list[str]) -> list[str]:
    tmax = tamanho_maximo(lst)

    def tem_tamanho_maximo(s: str) -> bool:
        return len(s) == tmax

    return list(filter(tem_tamanho_maximo, lst))


def tamanho_maximo(lst: list[str]) -> int:
    # map devolve um iterador, que max consome
    return max(map(len, lst), default=0)
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

```gleam-repl
> // Função anônima
> fn(x: Int) -> Int { x + 1 }
//fn(a) { ... }
```

\pause

```gleam-repl
> // Chamada de função anônima
> fn(x: Int) -> Int { x + 1 }(3)
4
```

\pause

</div>
<div class="column" width="48%">
\footnotesize

```gleam-repl
> // Armazenando função em variável
> let soma1 = fn(x: Int) -> Int { x + 1 }
//fn(a) { ... }
```

\pause

```gleam-repl
> // Chamando a função armazenada
> soma1(3)
4
```

</div>
</div>


## Exemplo: maiores strings

<div class="columns">
<div class="column" width="45%">

\small

Por questões de simplicidade de projeto, em Gleam, apenas funções anônimas podem ser declaradas dentro de outras funções. \pause

\scriptsize

\ \

```gleam
fn maiores_strings(lst: List(String))
  -> List(String) {
  let max = tamanho_maximo(lst)

  // Declaração inválida
  fn tem_tamanho_maximo(s: String) -> Bool {
    string.length(s) == max
  }

  list.filter(lst, tem_tamanho_maximo)
}
```

\pause

</div>
<div class="column" width="51%">
\scriptsize

```gleam
fn maiores_strings(lst: List(String))
  -> List(String) {
  let max = tamanho_maximo(lst)
  let tem_tamanho_maximo = fn(s) {
    string.length(s) == max
  }
  list.filter(lst, tem_tamanho_maximo)
}
```
\pause

\small

\ \

Ou sem armazenar a função em uma variável:

\scriptsize

```gleam
fn maiores_strings(lst: List(String))
  -> List(String) {
  let max = tamanho_maximo(lst)
  list.filter(lst, fn(s) { string.length(s) == max })
}
```
</div>
</div>


## Funções anônimas

Em que situações devemos utilizar funções anônimas? \pause

Como argumento, quando a função for pequena e necessária apenas naquele local: \pause

\footnotesize

```gleam-repl
> list.map([3, 8, -6], fn(x) { x * 2 })
[6, 16, -12]
> list.filter([3, 20, -4, 48], fn(x) { x < 10 })
[3, -4]
```

\pause

Em Python:

```python
>>> list(map(lambda x: x * 2, [3, 8, -6]))
[6, 16, -12]
>>> list(filter(lambda x: x < 10, [3, 20, -4, 48]))
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
  reduz(lst, [], fn(acc, e) {
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
  reduz(lst, [], fn(acc, e) {
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

Em que situações devemos utilizar funções anônimas? \pause

- Como argumento, quando a função for pequena e necessária apenas naquele local. \pause

- Como resultado de funções. \pause

Uma função anônima não pode chamar a si mesma: dentro do corpo de `let f = fn(x) { ... }`{.gleam} o nome `f` ainda não existe. Funções recursivas precisam ser definidas no nível do módulo.



Funções como resultado
======================

## Motivação

A função `list.sort`{.gleam} recebe uma lista e uma função de comparação, isto é, uma função que recebe dois valores e devolve `order.Lt`{.gleam}, `order.Eq`{.gleam} ou `order.Gt`{.gleam}, como `int.compare`{.gleam}. \pause

Considere uma lista de pessoas, em que cada pessoa tem nome, idade e altura (em centímetros), e o código a seguir, que ordena as pessoas por idade e por altura:

\small

```gleam
list.sort(pessoas, fn(a, b) { int.compare(a.idade, b.idade) })
list.sort(pessoas, fn(a, b) { int.compare(a.altura, b.altura) })
```

\pause

\normalsize

As duas funções anônimas diferem apenas no campo usado. Como no capítulo **Funções como valores: abstração**, podemos parametrizar essa diferença, mas agora o resultado precisa ser uma função de comparação. Precisamos, portanto, de uma função que produz uma função.


## Funções como resultado

Uma função que produz uma função normalmente é usada para: \pause

- Fixar um valor que a função produzida usa (exemplo `soma`, a seguir); \pause

- Transformar uma função em outra (exemplos `nega` e `compara_por`, a seguir). \pause

Em geral, a função produzida é passada como argumento para outra função de alta ordem, como `list.map`{.gleam}, `list.filter`{.gleam} ou `list.sort`{.gleam}.


## Exemplo: somador

Defina uma função que receba um parâmetro $n$ e devolva uma função que soma o seu argumento a $n$.


## Exemplo: somador

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam-repl
> let soma1 = soma(1)
//fn(a) { ... }
> soma1(4)
5
> soma1(6)
7
```

\ \

\pause

```gleam-repl
> soma(1)(2)
3
```

\ \

\pause

```gleam-repl
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

\pause

</div>
</div>

\small

Na função devolvida, `n` é uma variável livre. O resultado de `soma(1)`{.gleam} é um fechamento que leva junto `n` com o valor `1`{.gleam} e continua existindo depois que a chamada de `soma` termina.


## Exemplo: negação

Defina uma função que receba como parâmetro um predicado (função de um parâmetro que produz booleano) e devolva uma função que produz a negação do resultado do predicado.


## Exemplo: negação

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam-repl
> nega(list.is_empty)([])
False
> nega(list.is_empty)([1, 2])
True
```

\ \

\pause

```gleam-repl
> list.filter([4, 1, 2, 0, 3], nega(int.is_odd))
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


## Exemplo: comparação

Voltando à ordenação de pessoas, defina uma função que receba como parâmetro uma função *chave*, que produz um inteiro, e devolva uma função de comparação que compara dois valores pelo resultado de *chave*.


## Exemplo: comparação

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam-repl
> compara_por(string.length)("casa", "oi")
Gt
```

\ \

\pause

```gleam-repl
> list.sort(["casa", "oi", "abc"],
            compara_por(string.length))
["oi", "abc", "casa"]
```

\pause

\ \

```gleam-repl
> list.sort([-5, 3, -1],
            compara_por(int.absolute_value))
[-1, 3, -5]
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve uma função de comparação que
/// compara dois valores pelo resultado
/// de *chave*.
pub fn compara_por(
  chave: fn(a) -> Int
) -> fn(a, a) -> Order {
  todo
}
```

\pause

\ \

```gleam
pub fn compara_por(
  chave: fn(a) -> Int
) -> fn(a, a) -> Order {
  fn(x, y) {
    int.compare(chave(x), chave(y))
  }
}
```

</div>
</div>


## Exemplo: comparação

Com `compara_por`{.gleam}, a ordenação de pessoas (com o tipo `Pessoa`{.gleam}) fica:

\small

```gleam
list.sort(pessoas, compara_por(fn(p: Pessoa) { p.idade }))
list.sort(pessoas, compara_por(fn(p: Pessoa) { p.altura }))
```

\pause

A anotação `p: Pessoa`{.gleam} é necessária: como `compara_por`{.gleam} aceita uma chave de qualquer tipo, o compilador não consegue descobrir o tipo de `p` para acessar o campo.


Revisão
=======


## Revisão

Como resolvemos `maiores_strings`, em que nenhuma das funções `map`, `filter` e `fold_right` servia diretamente? \pause

- Dividindo o problema em etapas que combinam as três: `map` e `fold_right` para encontrar o tamanho máximo e `filter` para selecionar as strings com esse tamanho. \pause

Por que uma função que usa uma variável livre precisa ser um fechamento? \pause

- Porque as variáveis livres não estão no registro de ativação da função e podem nem existir mais quando a função é chamada (como o `n` em `soma(n)`{.gleam}); por isso, a função precisa levar junto o ambiente léxico, com as referências para essas variáveis.


## Revisão

Em que situações usamos funções anônimas? \pause

- Como argumento, quando a função é pequena e usada apenas naquele local, e como resultado de funções que produzem funções (como `soma(n)`{.gleam} e `nega(pred)`{.gleam}). \pause

Como identificar que precisamos de uma função que produz uma função? \pause

- Quando escrevemos várias funções (em geral anônimas) que diferem apenas em um valor usado no corpo. Parametrizamos essa diferença, e o resultado é a função (como em `compara_por(chave)`{.gleam}).


Referências
===========

## Referências

Básicas

- Vídeos [Abstractions](https://www.youtube.com/playlist?list=PL6NenTZG6KroSmESv5ItvLft76ZR8q-Nd)

- Capítulos [16](https://htdp.org/2022-8-7/Book/part_three.html#%28part._ch~3a3use%29) (seção 16.2) e [17](https://htdp.org/2022-8-7/Book/part_three.html#%28part._ch~3a3lambda%29) do livro [HTDP](http://htdp.org)

Complementares

- Seção [1.3](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-12.html#%_sec_1.3) (1.3.2 e 1.3.4) do livro [SICP](https://mitpress.mit.edu/sicp/)
