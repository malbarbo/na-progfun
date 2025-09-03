---
# vim: set spell spelllang=pt_br sw=4:
# TODO: ver HTDP e separar a funções que geram listas
# TODO: mostrar funções de listas pré-definidas: length, append, member?
# TODO: colocar o processo de implementação como é feita em sala
title: Autorreferência e recursividade
subtitle: Parte I
---


Introdução
==========

## Introdução

Projete uma função que some uma sequência de números. \pause

Como representar e processar uma quantidade arbitrária de dados? \pause

- Vamos criar tipos de dados com autorreferência

- Vamos usar funções recursivas para processar dados com autorreferência

\pause

Um **tipo de dado com autorreferência** é aquele definido em termos de si mesmo, de forma direta ou indireta. \pause

Uma **função recursiva** é aquela que chama a si mesma, de forma direta ou indireta.


Listas
======


## Listas

O tipo de dado com autorreferência mais comum nas linguagens funcionais é a lista. \pause

Vamos tentar criar uma definição para lista de números.


## Listas

A ideia é criar uma estrutura com dois campos. O primeiro campo representa o primeiro item na lista e o segundo campo representa o restante da lista (que é uma lista). \pause

```gleam
pub type Lista {
  Lista(primeiro: Int, resto: Lista)
}
```

\pause

Observe a autorreferência!


## Listas

Utilizando esta definição, vamos tentar criar uma lista com os valores 4, 2 e 8. \pause

`let lst = Lista(4,`{.gleam} \pause `Lista(2, `{.gleam} \pause `Lista(8, `{.gleam} \pause `...)))`{.gleam}

\pause

O problema com esta definição é que as listas não têm fim. Uma lista tem uma parte que é uma lista, que tem uma parte que é uma lista, etc. Ou seja, a definição não é bem formada.


## Listas

Para ser **bem formada**, uma definição com autorreferência deve ter: \pause

- Pelo menos um caso base (sem autorreferência) \pause

- Pelo menos um caso com autorreferência \pause

Os casos base descrevem valores que podem ser criados diretamente. \pause

Os casos com autorreferência permitem a criação de novos valores a partir de valores existentes. \pause

O que está faltando na nossa definição de lista? \pause Um caso base, ou seja, uma forma de criar uma lista que não dependa de outra lista. \pause Que lista pode ser essa? \pause

A lista vazia.


## Listas

Uma **lista** é: \pause

- Vazia; \pause
- Ou não vazia, contendo o primeiro elemento e o resto, que é uma **lista**.

\pause

Em Gleam \pause

\small

```gleam
pub type Lista {
  Vazia
  NaoVazia(primeiro: Int, resto: Lista)
}
```


## Listas

\footnotesize

```gleam
> // lista vazia
> let lst0: Lista = Vazia
Vazia
```

\pause

```gleam
> // lista com o 3
> let lst1: Lista = NaoVazia(3, Vazia)
NaoVazia(primeiro: 3, resto: Vazia)
```

\pause

```gleam
> // Lista com o 8 e 7
> let lst2: Lista = NaoVazia(8, NaoVazia(7, Vazia))
NaoVazia(primeiro: 8, resto: NaoVazia(primeiro: 7, resto: Vazia))
```

\pause

```gleam
> // Nova lista com o 3 como primeiro, seguido de lst2
> NaoVazia(3, lst2)
NaoVazia(primeiro: 3, resto: NaoVazia(primeiro: 8, resto: NaoVazia(primeiro: 7, resto: Vazia)))
```



## Listas

Como consultar o primeiro elemento de uma lista? \pause

\footnotesize

```gleam
> lst1.primeiro
```

\pause

```
error: Unknown record field

1  │ lst1.primeiro
   │     ^^^^^^^^^ This field does not exist

The value being accessed has this type:
    Lista

It does not have any fields.

Note: The field you are trying to access might not be consistently present
or positioned across the custom type's variants, preventing reliable
access. Ensure the field exists in the same position and has the same type
in all variants to enable direct accessor syntax.
```


## Listas

\small

```gleam
> case lst1 {
    Vazia -> todo
    NaoVazia(primeiro, _) -> primeiro
  }
3
```


## Listas

Nós vimos anteriormente que o tipo de dado de entrada de uma função sugere uma forma para o corpo da função. \pause

- Qual é a forma do corpo da função que um tipo enumerado de entrada sugere? \pause Um `case`{.gleam} com um caso para cada valor da enumeração. \pause

- Qual é a forma do corpo da função que um tipo união de entrada sugere? \pause Um `case`{.gleam} com um caso para cada classe da união. \pause

Qual é a forma do corpo da função que o tipo de entrada `Lista`{.gleam} sugere?


## Listas

<div class="columns">
<div class="column" width="48%">

\small

Uma condicional com dois casos: \pause

- A lista é vazia \pause

- A lista não é vazia \pause

\ \

Em Gleam \pause

```gleam
pub fn fn_para_lista(lst: Lista) {
  case lst {
    Vazia -> todo
    NaoVazia(primeiro, resto) -> todo
  }
}
```

\pause

</div>
<div class="column" width="48%">

\small

Qual é o tipo de `primeiro`{.gleam}? \pause Um inteiro, que é um valor atômico. \pause

Qual é o tipo de `resto`{.gleam}? \pause Uma lista, que é uma união. \pause

Um valor atômico pode ser processado diretamente, mas como processar uma lista? \pause Fazendo a análise dos casos... \pause

Vamos fazer uma alteração no modelo `fn_para_lista`{.gleam} e adicionar uma chamada recursiva para processar `resto`{.gleam}. Essa alteração pode parecer meio "mágica" agora, mas ficará mais clara em breve.

</div>
</div>


## Listas

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
pub type Lista {
  Vazia
  NaoVazia(primeiro: Int, resto: Lista)
}
```

</div>
<div class="column" width="48%">

\footnotesize

Modelo para função para listas

```gleam
pub fn fn_para_lista(lst: Lista) {
  case lst {
    Vazia -> todo
    NaoVazia(primeiro, resto) -> {
      todo
      primeiro
      fn_para_lista(resto)
    }
  }
}
```
</div>
</div>

\ \

\pause

Quais são as relações entre a definição de `Lista`{.gleam} e `fn_para_lista`{.gleam}? \pause

- A definição tem dois casos, o modelo também; \pause
- Na definição, o `resto`{.gleam} é uma **autorreferência**; na função, a **recursão** é feita com o `resto`{.gleam}.


## Exemplo: soma

Defina uma função que some os valores de uma lista de números.


<!--
## Exemplo: soma

Rascunho

\pause

\small

`soma vazia` \pause $\rightarrow$ `?` \pause

`soma 4` \pause $\rightarrow$ `4` \pause

`soma 7 4` \pause $\rightarrow$ `13` \pause

`soma 2 7 4` \pause $\rightarrow$ `15` \pause

`soma 5 2 7 4` \pause $\rightarrow$ `20` \pause

\normalsize

O que você consegue observar sobre a forma que a resposta é computada?

-->


## Exemplo: soma - especificação {.t}

<div class="columns">
<div class="column" width="40%">
\footnotesize

```gleam
/// Soma os valores de *lst*
pub fn soma(lst: Lista) -> Int {
  todo
}
```

\pause
</div>
<div class="column" width="56%">
\footnotesize

```gleam
pub fn soma_examples() {
  check.eq(soma(Vazia), 0)
  check.eq(soma(NaoVazia(3, Vazia)), 3)
  check.eq(
    soma(NaoVazia(5, NaoVazia(3, Vazia))),
    8,
  )
  check.eq(
    soma(NaoVazia(2, NaoVazia(5, NaoVazia(3, Vazia)))),
    10,
  )
}
```

\pause
</div>
</div>

\ \

E agora, como escrever a implementação? \pause Vamos partir do modelo de função para listas.


## Exemplo: soma - implementação {.t}

<div class="columns">
<div class="column" width="40%">
\footnotesize

```gleam
/// Soma os valores de *lst*
pub fn soma(lst: Lista) -> Int {
  case lst {
    Vazia -> todo
    NaoVazia(primeiro, resto) -> {
      todo
      primeiro
      soma(resto)
    }
  }
}
```

</div>
<div class="column" width="56%">
\footnotesize

```gleam
pub fn soma_examples() {
  check.eq(soma(Vazia), 0)
  check.eq(soma(NaoVazia(3, Vazia)), 3)
  check.eq(
    soma(NaoVazia(5, NaoVazia(3, Vazia))),
    8,
  )
  check.eq(
    soma(NaoVazia(2, NaoVazia(5, NaoVazia(3, Vazia)))),
    10,
  )
}
```

</div>
</div>

\pause

\ \

\small

Agora precisamos preencher as lacunas. \pause Qual deve ser o resultado quando a lista é vazia? \pause 0.


## Exemplo: soma - implementação {.t}

<div class="columns">
<div class="column" width="40%">
\footnotesize

```gleam
/// Soma os valores de *lst*
pub fn soma(lst: Lista) -> Int {
  case lst {
    Vazia -> 0
    NaoVazia(primeiro, resto) -> {
      todo
      primeiro
      soma(resto)
    }
  }
}
```

</div>
<div class="column" width="56%">
\footnotesize

```gleam
pub fn soma_examples() {
  check.eq(soma(Vazia), 0)
  check.eq(soma(NaoVazia(3, Vazia)), 3)
  check.eq(
    soma(NaoVazia(5, NaoVazia(3, Vazia))),
    8,
  )
  check.eq(
    soma(NaoVazia(2, NaoVazia(5, NaoVazia(3, Vazia)))),
    10,
  )
}
```

</div>
</div>

\pause

\ \

\small

Agora precisamos analisar o caso em que a lista não é vazia. \pause O modelo está sugerindo fazer uma chamada recursiva para o resto da lista. \pause Aqui vem o ponto crucial!


## Exemplo: soma - implementação {.t}

<div class="columns">
<div class="column" width="40%">
\footnotesize

```gleam
/// Soma os valores de *lst*
pub fn soma(lst: Lista) -> Int {
  case lst {
    Vazia -> 0
    NaoVazia(primeiro, resto) -> {
      todo
      primeiro
      soma(resto)
    }
  }
}
```

</div>
<div class="column" width="56%">
\footnotesize

```gleam
pub fn soma_examples() {
  check.eq(soma(Vazia), 0)
  check.eq(soma(NaoVazia(3, Vazia)), 3)
  check.eq(
    soma(NaoVazia(5, NaoVazia(3, Vazia))),
    8,
  )
  check.eq(
    soma(NaoVazia(2, NaoVazia(5, NaoVazia(3, Vazia)))),
    10,
  )
}
```

</div>
</div>

\ \

\small

Mesmo que a função não esteja completa, nós vamos **assumir** que ela produz a resposta correta para o resto da lista. \pause Tendo a soma do resto e o primeiro, como obter a soma da lista? \pause Somando os dois.


## Exemplo: soma - implementação {.t}

<div class="columns">
<div class="column" width="40%">
\footnotesize

```gleam
/// Soma os valores de *lst*
pub fn soma(lst: Lista) -> Int {
  case lst {
    Vazia -> 0
    NaoVazia(primeiro, resto) ->
      primeiro + soma(resto)
  }
}
```

</div>
<div class="column" width="56%">
\footnotesize

```gleam
pub fn soma_examples() {
  check.eq(soma(Vazia), 0)
  check.eq(soma(NaoVazia(3, Vazia)), 3)
  check.eq(
    soma(NaoVazia(5, NaoVazia(3, Vazia))),
    8,
  )
  check.eq(
    soma(NaoVazia(2, NaoVazia(5, NaoVazia(3, Vazia)))),
    10,
  )
}
```

</div>
</div>

\pause

Verificação: \pause ok. \pause (Revisão) Podemos melhorar o código?


<!--
## Exemplo: soma em Python

<div class="columns">
<div class="column" width="48%">

\footnotesize

```python
@dataclass
class Link:
    primeiro: int
    resto: Lista

Lista = Link | None
```

\pause

Exemplos

```python
>>> # Lista com o valor 1
>>> lst = Link(1, None)
>>> # Lista com o valor 7 4 1
>>> lst = Link(7, Link(4, lst))
>>> lst.primeiro
7
>>> # segundo
>>> lst.resto.primeiro
4
```

\pause

</div>
<div class="column" width="48%">

\footnotesize

```python
def soma(lst: Lista) -> int:
    '''Soma os valores de *lst*.
    >>> soma(None)
    0
    >>> soma(Link(3, None))
    3
    >>> soma(Link(4, Link(3, None)))
    7
    >>> soma(Link(1, Link(4, Link(3, None))))
    8
    '''
    if lst is None:
        return 0
    else:
        return lst.primeiro + soma(lst.resto)

```
</div>
</div>

-->


## Listas

A linguagem Gleam já fornece o tipo `List`{.gleam} e uma notação amigável para criar e desestruturar listas. \pause

<div class="columns">
<div class="column" width="48%">

\footnotesize

```gleam
> // Lista vazia
> let lst0: List(Int) = []
[]
```

\pause

```gleam
> // Lista com 3 e 8
> let lst1: List(Int) = [3, 8]
[3, 8]
```

\pause

```gleam
> // Nova lista a partir de uma existente
> let lst2 = [7, ..lst1]
[7, 3, 8]
```

\pause

</div>
<div class="column" width="48%">

\footnotesize

```gleam
> // Desestruturação
> case lst2 {
    [] -> todo
    [primeiro, ..resto] -> primeiro
  }
7
```

\pause

```gleam
> case lst2 {
    [] -> todo
    [primeiro, ..resto] -> resto
  }
[3, 8]
```
</div>
</div>

\pause

`List`{.gleam} **tem a mesma estrutura da lista que definimos**; a diferença está apenas na sintaxe!


## Listas {.t}

<div class="columns">
<div class="column" width="48%">
\small

Uma `Lista`{.gleam} é:

- `Vazia`{.gleam};
- `NaoVazia(primeiro, resto)`{.gleam}, onde `resto` é uma `Lista`{.gleam}.

</div>
<div class="column" width="48%">
\small

Uma `List`{.gleam} é:

- `[]`{.gleam}; ou
- `[primeiro, ..resto]`{.gleam }, onde `resto` é uma `List`{.gleam}.

</div>
</div>

\pause

\ \

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
pub fn fn_para_lista(lst: Lista) {
  case lst {
    Vazia -> todo
    NaoVazia(primeiro, resto) -> {
      todo
      primeiro
      fn_para_lista(resto)
    }
  }
}
```

</div>
<div class="column" width="48%">
\footnotesize

```gleam
pub fn fn_para_list(lst: List(a)) {
  case lst {
    [] -> todo
    [primeiro, ..resto] -> {
      todo
      primeiro
      fn_para_list(resto)
    }
  }
}
```

</div>
</div>


## Listas {.t}

<div class="columns">
<div class="column" width="48%">
\small

Uma `Lista`{.gleam} é:

- `Vazia`{.gleam};
- `NaoVazia(primeiro, resto)`{.gleam}, onde `resto` é uma `Lista`{.gleam}.

</div>
<div class="column" width="48%">
\small

Uma `List`{.gleam} é:

- `[]`{.gleam}; ou
- `[primeiro, ..resto]`{.gleam }, onde `resto` é uma `List`{.gleam}.

</div>
</div>

\ \

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
pub fn soma(lst: Lista) {
  case lst {
    Vazia -> 0
    NaoVazia(primeiro, resto) ->
      primeiro + soma(resto)
  }
}
```

</div>
<div class="column" width="48%">
\footnotesize

```gleam
pub fn soma(lst: List(a)) {
  case lst {
    [] -> 0
    [primeiro, ..resto] ->
      primeiro + soma(resto)
  }
}
```

</div>
</div>


## Exemplo: contém

Defina uma função que verifique se um dado valor está em uma lista de números.


## Exemplo: contém - especificação {.t}

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
/// Devolve True se *v* está em *lst*,
/// False caso contrário.
pub fn contem(lst: List(Int), v: Int) -> Bool {
  todo
}
```

\pause

</div>
<div class="column" width="46%">

\footnotesize

```gleam
pub fn contem_examples() {
  check.eq(contem([], 3), False)
  check.eq(contem([3], 3), True)
  check.eq(contem([3], 4), False)
  check.eq(contem([4, 10, 3], 4), True)
  check.eq(contem([4, 10, 3], 10), True)
  check.eq(contem([4, 10, 3], 8), False)
}
```

</div>
</div>

\pause

Como começamos a implementação? \pause Com o modelo.


## Exemplo: contém - implementação {.t}

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
/// Devolve True se *v* está em *lst*,
/// False caso contrário.
pub fn contem(lst: List(Int), v: Int) -> Bool {
  case lst {
    [] -> { todo v }
    [primeiro, ..resto] -> {
      todo
      v
      primeiro
      contem(resto, v)
    }
  }
}
```


</div>
<div class="column" width="46%">

\footnotesize

```gleam
pub fn contem_examples() {
  check.eq(contem([], 3), False)
  check.eq(contem([3], 3), True)
  check.eq(contem([3], 4), False)
  check.eq(contem([4, 10, 3], 4), True)
  check.eq(contem([4, 10, 3], 10), True)
  check.eq(contem([4, 10, 3], 8), False)
}
```

</div>
</div>

\pause

O esboço para cada caso começa com um **inventário** dos valores disponíveis para implementar o caso em questão. \pause Por isso, adicionamos `v` em cada caso.


## Exemplo: contém - implementação {.t}

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
/// Devolve True se *v* está em *lst*,
/// False caso contrário.
pub fn contem(lst: List(Int), v: Int) -> Bool {
  case lst {
    [] -> { todo v }
    [primeiro, ..resto] -> {
      todo
      v
      primeiro
      contem(resto, v)
    }
  }
}
```


</div>
<div class="column" width="46%">

\footnotesize

```gleam
pub fn contem_examples() {
  check.eq(contem([], 3), False)
  check.eq(contem([3], 3), True)
  check.eq(contem([3], 4), False)
  check.eq(contem([4, 10, 3], 4), True)
  check.eq(contem([4, 10, 3], 10), True)
  check.eq(contem([4, 10, 3], 8), False)
}
```

</div>
</div>

O que fazemos agora? \pause Implementamos o caso base.


## Exemplo: contém - implementação {.t}

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
/// Devolve True se *v* está em *lst*,
/// False caso contrário.
pub fn contem(lst: List(Int), v: Int) -> Bool {
  case lst {
    [] -> False
    [primeiro, ..resto] -> {
      todo
      v
      primeiro
      contem(resto, v)
    }
  }
}
```


</div>
<div class="column" width="46%">

\footnotesize

```gleam
pub fn contem_examples() {
  check.eq(contem([], 3), False)
  check.eq(contem([3], 3), True)
  check.eq(contem([3], 4), False)
  check.eq(contem([4, 10, 3], 4), True)
  check.eq(contem([4, 10, 3], 10), True)
  check.eq(contem([4, 10, 3], 8), False)
}
```

</div>
</div>

\pause

**Assumindo** que a função produz a resposta correta para o resto (determina se `v` está no `resto`), como podemos determinar se `v` está em `lst`?


## Exemplo: contém - implementação {.t}

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
/// Devolve True se *v* está em *lst*,
/// False caso contrário.
pub fn contem(lst: List(Int), v: Int) -> Bool {
  case lst {
    [] -> False
    [primeiro, ..resto] ->
      case v == primeiro {
        True -> True
        False -> contem(resto, v)
      }
  }
}
```


</div>
<div class="column" width="46%">

\footnotesize

```gleam
pub fn contem_examples() {
  check.eq(contem([], 3), False)
  check.eq(contem([3], 3), True)
  check.eq(contem([3], 4), False)
  check.eq(contem([4, 10, 3], 4), True)
  check.eq(contem([4, 10, 3], 10), True)
  check.eq(contem([4, 10, 3], 8), False)
}
```

</div>
</div>

\pause

Verificação: \pause ok. \pause (Revisão) Podemos melhorar o código?


## Exemplo: contém - revisão {.t}

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
/// Devolve True se *v* está em *lst*,
/// False caso contrário.
pub fn contem(lst: List(Int), v: Int) -> Bool {
  case lst {
    [] -> False
    [primeiro, ..resto] ->
      v == primeiro || contem(resto, v)
  }
}
```


</div>
<div class="column" width="46%">

\footnotesize

```gleam
pub fn contem_examples() {
  check.eq(contem([], 3), False)
  check.eq(contem([3], 3), True)
  check.eq(contem([3], 4), False)
  check.eq(contem([4, 10, 3], 4), True)
  check.eq(contem([4, 10, 3], 10), True)
  check.eq(contem([4, 10, 3], 8), False)
}
```

</div>
</div>


## Exemplo: contém - revisão {.t}

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
/// Devolve True se *v* está em *lst*,
/// False caso contrário.
pub fn contem(lst: List(a), v: a) -> Bool {
  case lst {
    [] -> False
    [primeiro, ..resto] ->
      v == primeiro || contem(resto, v)
  }
}
```


</div>
<div class="column" width="46%">

\footnotesize

```gleam
pub fn contem_examples() {
  check.eq(contem([], 3), False)
  check.eq(contem([3], 3), True)
  check.eq(contem([3], 4), False)
  check.eq(contem([4, 10, 3], 4), True)
  check.eq(contem(["a", "b"], "b"), True)
  check.eq(contem(["a", "b"], "c"), False)
}
```

</div>
</div>

\pause

\ \

Estamos utilizando **polimorfismo paramétrico** para tornar a função `contem` genérica. \pause

A função `contem` é genérica em relação ao tipo `a`, que é um parâmetro que pode assumir (implicitamente) qualquer tipo. \pause

Note que o tipo dos elementos da lista deve ser o mesmo que o tipo de `v`.


## Exemplo: soma x

Defina uma função que some um valor `x` em cada elemento de uma lista de números.


## Exemplo: soma x - especificação {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Soma *x* a cada elemento de *lst*.
pub fn soma_x(
  lst: List(Int),
  x: Int
) -> List(Int) {
  todo
}
```

\pause
</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn soma_x_examples() {
  check.eq(soma_x([], 4), [])
  check.eq(soma_x([4, 2], 5), [9, 7])
  check.eq(soma_x([3, -1, 4], -2), [1, -3, 2])
}
```
</div>
</div>

\pause

Como começamos a implementação? \pause Com o modelo.


## Exemplo: soma x - implementação {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Soma *x* a cada elemento de *lst*.
pub fn soma_x(lst, x) -> List(Int) {
  case lst {
    [] -> { todo x }
    [primeiro, ..resto] -> {
      todo
      x
      primeiro
      soma_x(resto, x)
    }
  }
}
```

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn soma_x_examples() {
  check.eq(soma_x([], 4), [])
  check.eq(soma_x([4, 2], 5), [9, 7])
  check.eq(soma_x([3, -1, 4], -2), [1, -3, 2])
}
```
</div>
</div>

\pause

O que fazemos agora? \pause Implementamos o caso base.


## Exemplo: soma x - implementação {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Soma *x* a cada elemento de *lst*.
pub fn soma_x(lst, x) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> {
      todo
      x
      primeiro
      soma_x(resto, x)
    }
  }
}
```

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn soma_x_examples() {
  check.eq(soma_x([], 4), [])
  check.eq(soma_x([4, 2], 5), [9, 7])
  check.eq(soma_x([3, -1, 4], -2), [1, -3, 2])
}
```
</div>
</div>

\pause

**Assumindo** que a função produz a resposta correta para o resto (soma `x` em cada elemento do `resto`), como podemos criar uma lista somando `x` em cada elemento de `lst`?


## Exemplo: soma x - implementação {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Soma *x* a cada elemento de *lst*.
pub fn soma_x(lst, x) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] ->
      [x + primeiro, ..soma_x(resto, x)]
  }
}
```

</div>
<div class="column" width="48%">

\footnotesize

```gleam
pub fn soma_x_examples() {
  check.eq(soma_x([], 4), [])
  check.eq(soma_x([4, 2], 5), [9, 7])
  check.eq(soma_x([3, -1, 4], -2), [1, -3, 2])
}
```
</div>
</div>

\pause

Verificação: \pause Ok.


## Exemplo: remove negativos

Defina uma função que remova todos os números negativos de uma lista de números.


## Exemplo: remove negativos - especificação {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
// Cria uma nova lista sem
// os valores negativos de *lst*.
pub fn remove_negativos(
  lst: List(Int)
) -> List(Int) {
  todo
}
```

\pause
</div>
<div class="column" width="48%">
\footnotesize

```gleam
pub fn remove_negativos_examples() {
  check.eq(
    remove_negativos([]),
    [],
  )
  check.eq(
    remove_negativos([-1, 2, -3]),
    [2],
  )
  check.eq(
    remove_negativos([3, 4, -2]),
    [3, 4],
  )
}
```
</div>
</div>

\pause

Como começamos a implementação? \pause Com o modelo.


## Exemplo: remove negativos - implementação {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
// Cria uma nova lista sem
// os valores negativos de *lst*.
pub fn remove_negativos(lst) -> List(Int) {
  case lst {
    [] -> todo
    [primeiro, ..resto] -> {
      todo
      primeiro
      remove_negativos(resto)
    }
  }
}
```

</div>
<div class="column" width="48%">
\footnotesize

```gleam
pub fn remove_negativos_examples() {
  check.eq(
    remove_negativos([]),
    [],
  )
  check.eq(
    remove_negativos([-1, 2, -3]),
    [2],
  )
  check.eq(
    remove_negativos([3, 4, -2]),
    [3, 4],
  )
}
```
</div>
</div>

\pause

O que fazemos agora? \pause Implementamos o caso base.


## Exemplo: remove negativos - implementação {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
// Cria uma nova lista sem
// os valores negativos de *lst*.
pub fn remove_negativos(lst) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> {
      todo
      primeiro
      remove_negativos(resto)
    }
  }
}
```

</div>
<div class="column" width="48%">
\footnotesize

```gleam
pub fn remove_negativos_examples() {
  check.eq(
    remove_negativos([]),
    [],
  )
  check.eq(
    remove_negativos([-1, 2, -3]),
    [2],
  )
  check.eq(
    remove_negativos([3, 4, -2]),
    [3, 4],
  )
}
```
</div>
</div>

\pause

**Assumindo** que a função produz a resposta correta para o resto (remove os negativos de `resto`), como podemos remover os negativos de `lst`?


## Exemplo: remove negativos - implementação {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
// Cria uma nova lista sem
// os valores negativos de *lst*.
pub fn remove_negativos(lst) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] ->
      case primeiro < 0 {
        True -> remove_negativos(resto)
        False ->
          [primeiro,
           ..remove_negativos(resto)]
      }
  }
}
```

</div>
<div class="column" width="48%">
\footnotesize

```gleam
pub fn remove_negativos_examples() {
  check.eq(
    remove_negativos([]),
    [],
  )
  check.eq(
    remove_negativos([-1, 2, -3]),
    [2],
  )
  check.eq(
    remove_negativos([3, 4, -2]),
    [3, 4],
  )
}
```
</div>
</div>

\pause

Verificação: \pause ok. \pause (Revisão) Podemos melhorar o código?


## Exemplo: remove negativos - revisão {.t}

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
// Cria uma nova lista sem
// os valores negativos de *lst*.
pub fn remove_negativos(lst) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] if primeiro < 0 ->
      remove_negativos(resto)
    [primeiro, ..resto] ->
      [primeiro, ..remove_negativos(resto)]
  }
}
```

</div>
<div class="column" width="48%">
\footnotesize

```gleam
pub fn remove_negativos_examples() {
  check.eq(
    remove_negativos([]),
    [],
  )
  check.eq(
    remove_negativos([-1, 2, -3]),
    [2],
  )
  check.eq(
    remove_negativos([3, 4, -2]),
    [3, 4],
  )
}
```
</div>
</div>


## Exemplo: número de ocorrências

Um dicionário é um TAD que associa chaves com valores. Existem diversas formas de implementar um dicionário; a mais simples é utilizando uma **lista de associações** chave-valor. \pause Apesar de os tempos de inserção e busca serem lineares, na prática, para poucas chaves, a implementação é adequada. \pause

a) Defina um tipo de dado que represente uma associação entre uma string e um número.

a) Projete uma função que determine, a partir de uma lista de associações, qual é o valor associado a uma string.


## Exemplo: número de ocorrências - especificação

\footnotesize

```gleam
// Associação entre chave e valor.
type Par {
  Par(chave: String, valor: Int)
}
```

\pause

```gleam
/// Devolve o valor associado com *chave* em *lst* ou Error(Nil) se *chave* não
/// aparece em *lst*.
pub fn busca(lst: List(Par), chave: String) -> Result(Int, Nil) {
  todo
}
```

\pause

```gleam
pub fn busca_examples() {
  check.eq(busca([], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "nada"), Ok(3))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "outra"), Ok(2))
}
```


## Exemplo: número de ocorrências - implementação {.t}

\footnotesize

```gleam
pub fn busca_examples() {
  check.eq(busca([], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "nada"), Ok(3))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "outra"), Ok(2))
}

pub fn busca(lst: List(Par), chave: String) -> Result(Int, Nil) {
  case lst {
    [] -> { todo chave }
    [primeiro, ..resto] -> {
      todo chave
           primeiro
           busca(resto, chave)
    }
  }
}
```


## Exemplo: número de ocorrências - implementação {.t}

\footnotesize

```gleam
pub fn busca_examples() {
  check.eq(busca([], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "nada"), Ok(3))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "outra"), Ok(2))
}

pub fn busca(lst: List(Par), chave: String) -> Result(Int, Nil) {
  case lst {
    [] -> Error(Nil)
    [primeiro, ..resto] -> {
      todo chave
           primeiro
           busca(resto, chave)
    }
  }
}
```


## Exemplo: número de ocorrências - implementação {.t}

\footnotesize

```gleam
pub fn busca_examples() {
  check.eq(busca([], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "nada"), Ok(3))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "outra"), Ok(2))
}

pub fn busca(lst: List(Par), chave: String) -> Result(Int, Nil) {
  case lst {
    [] -> Error(Nil)
    [primeiro, ..resto] -> {
      case primeiro.chave == chave {
        True -> Ok(primeiro.valor)
        False -> busca(resto, chave)
    }
  }
}
```


## Exemplo: número de ocorrências - revisão {.t}

\footnotesize

```gleam
pub fn busca_examples() {
  check.eq(busca([], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "nada"), Ok(3))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "outra"), Ok(2))
}

pub fn busca(lst: List(Par), chave: String) -> Result(Int, Nil) {
  case lst {
    [] -> Error(Nil)
    [primeiro, ..] if primeiro.chave == chave -> Ok(primeiro.valor)
    [_, ..resto] -> busca(resto, chave)
  }
}
```


## Exemplo: número de ocorrências - revisão {.t}

Fazendo o dicionário genérico.

\footnotesize

```gleam
type Par(a, b) {
  Par(chave: a, valor: b)
}

pub fn busca_examples() {
  // ...
}

pub fn busca(lst: List(Par(a, b)), chave: a) -> Result(b, Nil) {
  case lst {
    [] -> Error(Nil)
    [primeiro, ..] if primeiro.chave == chave -> Ok(primeiro.valor)
    [_, ..resto] -> busca(resto, chave)
  }
}
```


## Exemplos: junta com "," e "e"

Projete uma função que junte todos os elementos de uma lista de strings (não vazias) separando-os com `", "`{.gleam} ou/e `" e "`{.gleam}, de acordo com a gramática do Português.


## Exemplos: junta com "," e "e"

\scriptsize

```gleam
/// Parece difícil escrever o propósito... Faremos os exemplos primeiro.
pub fn junta_virgula_e(lst: List(String)) -> String { todo }
```

\small
Exemplos

\scriptsize

\pause

`junta_virgula_e([])`{.gleam} \pause $\rightarrow$ `""`{.gleam} \pause

`junta_virgula_e(["maçã"])`{.gleam} \pause $\rightarrow$ `"maçã"`{.gleam} \pause

`junta_virgula_e(["banana", "maçã"])`{.gleam} \pause $\rightarrow$ `"banana e maçã"`{.gleam} \pause

`junta_virgula_e(["mamão", "banana", "maçã"])`{.gleam} \pause $\rightarrow$ `"mamão, banana e maçã"`{.gleam} \pause

`junta_virgula_e(["aveia", "mamão", "banana", "maçã"])`{.gleam} \pause $\rightarrow$ `"aveia, mamão, banana e maçã"`{.gleam} \pause

\small

Em todos os exemplos as respostas são calculadas da mesma forma? \pause Não! \pause Os três primeiros exemplos têm uma forma específica, que não é recursiva. \pause Então, precisamos criar três casos-base.


## Exemplos: junta com "," e "e"

\footnotesize

```gleam
/// Produz uma string juntando os elementos de *lst* da seguinte forma:
/// - Se *lst* é vazia, devolve "".
/// - Se *lst* tem apenas um elemento, devolve esse elemento.
/// - Senão, junta as strings de *lst*, separando-as com ", ", com exceção
///   da última string, que é separada com " e ".
pub fn junta_virgula_e(lst: List(String)) -> String {
  todo
}

pub fn junta_virgula_e_examples() {
  check.eq(junta_virgula_e([]), "")
  check.eq(junta_virgula_e(["maçã"]), "maçã")
  check.eq(junta_virgula_e(["mamão", "banana", "maçã"]), "mamão, banana e maçã")
  check.eq(junta_virgula_e(["aveia", "mamão", "banana", "maçã"]),
           "aveia, mamão, banana e maçã")
}
```


## Exemplos: junta com "," e "e"

\footnotesize

```gleam
pub fn junta_virgula_e(lst: List(String)) -> String {
  case lst {
    [] -> todo
    [primeiro] -> todo
    [primeiro, segundo] -> todo
    [primeiro, ..resto] -> todo
  }
}
```

## Exemplos: junta com "," e "e"

\footnotesize

```gleam
pub fn junta_virgula_e(lst: List(String)) -> String {
  case lst {
    [] -> ""
    [primeiro] -> primeiro
    [primeiro, segundo] -> primeiro <> " e " <> segundo
    [primeiro, ..resto] -> primeiro <> ", " <> junta_virgula_e(resto)
  }
}
```


## Exemplos: junta com "," e "e" em Python

\footnotesize

```python
def junta_virgula_e(lst: str) -> str:
    match lst:
        case []:
            return ''
        case [primeiro]:
            return primeiro
        case [primeiro, segundo]:
            return primeiro + ' e ' + segundo
        case _:
            return lst[0] + ', ' + junta_virgula_e(lst[1:])

```


Revisão
=======


## Revisão

Usamos tipos com autorreferência quando queremos representar dados de tamanhos arbitrários. \pause

- Usamos funções recursivas para processar dados de tipos com autorreferências. \pause

Para ser bem formada, uma definição com autorreferência deve ter: \pause

- Pelo menos um caso base (sem autorreferência): \pause são usados para criar os valores iniciais \pause

- Pelo menos um caso com autorreferência: \pause são usados para criar novos valores a partir de valores existentes

## Revisão

Uma lista é vazia ou tem um primeiro e um resto, que é uma lista.

O modelo de função para processar listas tem dois casos, um para lista vazia e outro para lista com primeiro e resto; no segundo caso, podemos fazer uma recursão para o resto.

\ \

<div class="columns">
<div class="column" width="48%">
\small

Uma `List`{.gleam} é:

- `[]`{.gleam}; ou
- `[primeiro, ..resto]`{.gleam }, onde `resto` é uma `List`{.gleam}.

</div>
<div class="column" width="48%">
\footnotesize

```gleam
pub fn fn_para_list(lst: List(a)) {
  case lst {
    [] -> todo
    [primeiro, ..resto] -> {
      todo
      primeiro
      fn_para_list(resto)
    }
  }
}
```
</div>
</div>


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
