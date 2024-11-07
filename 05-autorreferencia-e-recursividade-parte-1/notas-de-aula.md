---
# vim: set spell spelllang=pt_br sw=4:
# TODO: apresentar os exemplos de forma mais abstrata, semelhante ao
#       juntar com ponto e vírgula. Os alunos têm dificuldades
#       para entender por causa da sintaxe do Racket...
# TODO: adicionar exemplos com lista de estruturas
# TODO: ver HTDP e separar a funções que geram listas
# TODO: mostrar funções de listas pré-definidas: length, append, member
title: Autorreferência e recursividade
subtitle: Parte I
---


Introdução
==========

## Introdução

Projete uma função que some uma sequência de números. \pause

Como representar e processar uma quantidade de dados arbitrária? \pause

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
type Lista {
  Lista(primeiro: Int, resto: Lista)
}
```

\pause

Observe a autorreferência!


## Listas

Utilizando esta definição, vamos tentar criar uma lista com os valores 4, 2 e 8. \pause

`let lst = Lista(4,`{.gleam} \pause `Lista(2, `{.gleam} \pause `Lista(8, `{.gleam} \pause `...)))`{.gleam}

\pause

O problema com esta definição é que as listas não tem fim. Uma lista tem uma parte que é uma lista, que tem uma parte que é uma lista, etc. Ou seja, a definição não é bem formada.


## Listas

Para ser **bem formada**, uma definição com autorreferência deve ter: \pause

- Pelo menos um caso base (sem autorreferência) \pause
- Pelo menos um caso com autorreferência \pause

O caso base descreve valores que podem ser criados diretamente, já o(s) caso(s) com autorreferência permite(m) a criação de novos valores a partir de valores existentes. \pause

O que está faltando na nossa definição de lista? \pause Um caso base, ou seja, uma forma de criar uma lista que não dependa de outra lista. \pause Que lista pode ser essa? \pause

A lista vazia.


## Listas

Uma **lista** é: \pause

- Vazia; \pause
- Ou não vazia, contendo o primeiro e o resto, que é uma **lista**.

\pause

Em Gleam \pause

\small

```gleam
type Lista {
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

Nós vimos anteriormente que o tipo de dado de entrada de uma função pode sugerir uma forma para o corpo da função. \pause

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
fn fn_para_lista(lst: Lista) {
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

Um valor atômico pode ser processado diretamente, mas como processar uma lista? \pause Fazendo análise dos casos... \pause

Vamos fazer uma alteração no modelo `fn_para_lista`{.gleam} e adicionar uma chamada recursiva para processar `resto`{.gleam}. Essa alteração pode parecer meio "mágica" agora, mas ela vai ficar mais clara em breve.

</div>
</div>


## Listas

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
type Lista {
  Vazia
  NaoVazia(primeiro: Int, resto: Lista)
}
```

</div>
<div class="column" width="48%">

\footnotesize

Modelo para função para listas

```gleam
fn fn_para_lista(lst: Lista) {
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

Quais são as relações entre a definição de `ListaDeNúmeros` e o modelo? \pause

- A definição tem dois casos, o modelo também \pause
- A **autorreferência na definição** do dado sugere uma **chamada recursiva** no modelo


## Exemplo: soma

Defina uma função que some os valores de uma lista de números.


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


## Exemplo: soma

Especificação

<div class="columns">
<div class="column" width="40%">
\footnotesize

```gleam
/// Soma os valores de *lst*
fn soma(lst: Lista) -> Int {
  0
}
```

\pause
</div>
<div class="column" width="56%">
\footnotesize

```gleam
fn soma_examples() {
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

E agora, como escrevemos a implementação? \pause Vamos partir do modelo que criamos!

\vfill


## Exemplo: soma

<div class="columns">
<div class="column" width="40%">
\footnotesize

```gleam
/// Soma os valores de *lst*
fn soma(lst: Lista) -> Int {
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
fn soma_examples() {
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

Agora precisamos preencher as lagunas. \pause Qual deve ser o resultado quando a lista é vazia? \pause 0.


## Exemplo: soma

<div class="columns">
<div class="column" width="40%">
\footnotesize

```gleam
/// Soma os valores de *lst*
fn soma(lst: Lista) -> Int {
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
fn soma_examples() {
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


## Exemplo: soma

<div class="columns">
<div class="column" width="40%">
\footnotesize

```gleam
/// Soma os valores de *lst*
fn soma(lst: Lista) -> Int {
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
fn soma_examples() {
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

Mesmo a função não estando completa, nós vamos **assumir** que ela produz a resposta correta para o resto da lista. \pause Tendo a soma do resto e o primeiro, como obtermos a soma da lista? \pause Somando os dois.


## Exemplo: soma

<div class="columns">
<div class="column" width="40%">
\footnotesize

```gleam
/// Soma os valores de *lst*
fn soma(lst: Lista) -> Int {
  case lst {
    Vazia -> 0
    NaoVazia(primeiro, resto) -> {
      primeiro + soma(resto)
    }
  }
}
```

</div>
<div class="column" width="56%">
\footnotesize

```gleam
fn soma_examples() {
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

\vfill



## Exemplo: soma

Verificação: Ok. \pause

Revisão: Ok.


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

O Gleam já tem embutido na linguagem um tipo `List`{.gleam} e fornece uma notação amigável para criar e desestruturar listas. \pause

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

\pause
```gleam
> case lst2 {
    [] -> todo
    [primeiro, ..resto] -> resto
  }
[7, 3, 8]
```
</div>
</div>

\pause

Note que `List`{.gleam} tem a mesma estrutura da lista que definimos, a diferença é apenas sintaxe!


## Listas

<div class="columns">
<div class="column" width="48%">
Modelo de funções para `List`{.gleam}

\pause

\footnotesize

```gleam
fn fn_para_list(lst: List(a)) {
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

\pause

</div>
<div class="column" width="48%">

Exemplo da função soma

\pause

\footnotesize

```gleam
fn soma(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [primero, ..resto] ->
      primeiro + soma(resto)
  }
}
```

</div>
</div>


## Exemplo: contém

Defina uma função que verifique se um dado valor está em uma lista de números.


## Exemplo: contém

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
/// Devolve True se *v* está em *lst*,
/// False caso contrário.
fn contem(lst: List(Int), v: Int) -> Bool {
  False
}
```

\pause

</div>
<div class="column" width="46%">

\footnotesize

```gleam
fn contem_examples() {
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

\vfill


## Exemplo: contém

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
/// Devolve True se *v* está em *lst*,
/// False caso contrário.
fn contem(lst: List(Int), v: Int) -> Bool {
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
fn contem_examples() {
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

\vfill


## Exemplo: contém

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
/// Devolve True se *v* está em *lst*,
/// False caso contrário.
fn contem(lst: List(Int), v: Int) -> Bool {
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
fn contem_examples() {
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

\vfill


## Exemplo: contém

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
/// Devolve True se *v* está em *lst*,
/// False caso contrário.
fn contem(lst: List(Int), v: Int) -> Bool {
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
fn contem_examples() {
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

\vfill


## Exemplo: contém

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
/// Devolve True se *v* está em *lst*,
/// False caso contrário.
fn contem(lst: List(Int), v: Int) -> Bool {
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
fn contem_examples() {
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

\vfill


## Exemplo: remove negativos

Defina uma função que remova todos os número negativos de uma lista de números.


## Exemplo: remove negativos

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros -> ListaDeNúmeros
;; Produz uma nova lista removendo os valores negativos de lst.
(examples
 (check-equal? (remove-negativos empty) empty)
 (check-equal? (remove-negativos (cons -1 (cons 2 (cons -3 empty))))
               (cons 2 empty))
 (check-equal? (remove-negativos (cons 3 (cons 4 (cons -2 empty))))
               (cons 3 (cons 4 empty))))

(define (remove-negativos lst) empty)







```
</div>
<div class="column" width="28%">
Iniciamos com a especificação.
</div>
</div>


## Exemplo: remove negativos

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros -> ListaDeNúmeros
;; Produz uma nova lista removendo os valores negativos de lst.
(examples
 (check-equal? (remove-negativos empty) empty)
 (check-equal? (remove-negativos (cons -1 (cons 2 (cons -3 empty))))
               (cons 2 empty))
 (check-equal? (remove-negativos (cons 3 (cons 4 (cons -2 empty))))
               (cons 3 (cons 4 empty))))

(define (remove-negativos lst)
  (cond
    [(empty? lst) ...]
    [else
      ... (first lst)
      ... (remove-negativos (rest lst)) ... ]))


```
</div>
<div class="column" width="28%">
Para implementação partimos do modelo e ajustamos o nome.
</div>
</div>


## Exemplo: remove negativos

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros -> ListaDeNúmeros
;; Produz uma nova lista removendo os valores negativos de lst.
(examples
 (check-equal? (remove-negativos empty) empty)
 (check-equal? (remove-negativos (cons -1 (cons 2 (cons -3 empty))))
               (cons 2 empty))
 (check-equal? (remove-negativos (cons 3 (cons 4 (cons -2 empty))))
               (cons 3 (cons 4 empty))))

(define (remove-negativos lst)
  (cond
    [(empty? lst) empty]
    [else
      ... (first lst)
      ... (remove-negativos (rest lst)) ... ]))


```
</div>
<div class="column" width="28%">
Analisando os exemplos definimos o caso em que a lista é vazia.
</div>
</div>


## Exemplo: remove negativos

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros -> ListaDeNúmeros
;; Produz uma nova lista removendo os valores negativos de lst.
(examples
 (check-equal? (remove-negativos empty) empty)
 (check-equal? (remove-negativos (cons -1 (cons 2 (cons -3 empty))))
               (cons 2 empty))
 (check-equal? (remove-negativos (cons 3 (cons 4 (cons -2 empty))))
               (cons 3 (cons 4 empty))))

(define (remove-negativos lst)
  (cond
    [(empty? lst) empty]
    [else
     (if (< (first lst) 0)
         (remove-negativos (rest lst))
         (cons (first lst)
               (remove-negativos (rest lst))))]))
```
</div>
<div class="column" width="28%">
Analisando os exemplos definimos o caso em que a lista não é vazia.
</div>
</div>


## Exemplo: remove negativos

Verificação: Ok.

Revisão: exercício.


## Exemplo: soma x

Defina uma função que soma um valor `x` em cada elemento de uma lista de números.


## Exemplo: soma x

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> ListaDeNúmeros
;; Produz uma nova lista somando x a cada elemento de lst.
(examples
 (check-equal? (soma-x empty 4)
               empty)
 (check-equal? (soma-x (cons 4 (cons 2 empty)) 5)
               (cons 9 (cons 7 empty)))
 (check-equal? (soma-x (cons 3 (cons -1 (cons 4 empty))) -2)
               (cons 1 (cons -3 (cons 2 empty)))))

(define (soma-x lst x) empty)






```
</div>
<div class="column" width="28%">
Iniciamos com a especificação.
</div>
</div>


## Exemplo: soma x

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> ListaDeNúmeros
;; Produz uma nova lista somando x a cada elemento de lst.
(examples
 (check-equal? (soma-x empty 4)
               empty)
 (check-equal? (soma-x (cons 4 (cons 2 empty)) 5)
               (cons 9 (cons 7 empty)))
 (check-equal? (soma-x (cons 3 (cons -1 (cons 4 empty))) -2)
               (cons 1 (cons -3 (cons 2 empty)))))

(define (soma-x lst x)
  (cond
    [(empty? lst) ... x]
    [else
      ... (first lst)
      ... x
      ... (soma-x (rest lst) x) ... ]))
```
</div>
<div class="column" width="28%">
Para implementação partimos do modelo e ajustamos o nome e adicionamos o parâmetro `x`.
</div>
</div>


## Exemplo: soma x

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> ListaDeNúmeros
;; Produz uma nova lista somando x a cada elemento de lst.
(examples
 (check-equal? (soma-x empty 4)
               empty)
 (check-equal? (soma-x (cons 4 (cons 2 empty)) 5)
               (cons 9 (cons 7 empty)))
 (check-equal? (soma-x (cons 3 (cons -1 (cons 4 empty))) -2)
               (cons 1 (cons -3 (cons 2 empty)))))

(define (soma-x lst x)
  (cond
    [(empty? lst) empty]
    [else
      ... (first lst)
      ... x
      ... (soma-x (rest lst) x) ... ]))
```
</div>
<div class="column" width="28%">
Analisando os exemplos definimos o caso em que a lista é vazia.
</div>
</div>


## Exemplo: soma x

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> ListaDeNúmeros
;; Produz uma nova lista somando x a cada elemento de lst.
(examples
 (check-equal? (soma-x empty 4)
               empty)
 (check-equal? (soma-x (cons 4 (cons 2 empty)) 5)
               (cons 9 (cons 7 empty)))
 (check-equal? (soma-x (cons 3 (cons -1 (cons 4 empty))) -2)
               (cons 1 (cons -3 (cons 2 empty)))))

(define (soma-x lst x)
  (cond
    [(empty? lst) empty]
    [else
     (cons (+ x (first lst))
           (soma-x (rest lst) x))]))

```
</div>
<div class="column" width="28%">
Analisando os exemplos definimos o caso em que a lista não é vazia.
</div>
</div>


## Exemplo: número de ocorrências

Um dicionário é um TAD que associa chaves com valores. Existem diversas formas de implementar um dicionário, a mais simples é utilizando **listas de associações** chave-valor. \pause Apesar dos tempos de inserção e buscar serem lineares, na prática, para poucas chaves, a implementação é adequada. Em um projeto foi decidido usar lista de associações para armazenar a quantidade de ocorrências de uma string em um texto. \pause

a) Defina um tipo de dado que represente uma associação entre uma string e um número.

a) Projete uma função que determine, a partir de uma lista de associações, qual é a quantidade de ocorrências de uma string.


## Exemplo: número de ocorrências

\footnotesize

```scheme
(struct par (chave valor) #:transparent)
;; Representa uma associação entre chave e valor.
;; chave: String
;; valor: Natural
```

\pause

```scheme
;; String Lista(par) -> Natural
;; Devolve o valor associado com *s* em *lst*.
;; Se *s* não aparece como chave em *lst*, devolve 0.
(define (busca s lst) 0)
```

\pause

`(busca "casa" empty)`{.scheme} \pause $\rightarrow$ `0`{.scheme} \pause

`(busca "casa" (list (par "nada" 3) (par "outra" 2)))`{.scheme} \pause $\rightarrow$ `0`{.scheme} \pause

`(busca "nada" (list (par "nada" 3) (par "outra" 2)))`{.scheme} \pause $\rightarrow$ `3`{.scheme} \pause

`(busca "outra" (list (par "nada" 3) (par "outra" 2)))`{.scheme} \pause $\rightarrow$ `2`{.scheme}


## Exemplo: número de ocorrências

<div class="columns">
<div class="column" width="48%">
\footnotesize

```scheme
; modelo
(define (busca s lst)
  (cond
    [(empty? lst) ... s]
    [else
     ... s
     ... (first lst)
         (busca s (rest lst))]))
```

\pause

```scheme
; decomposição de (first lst)
(define (busca s lst)
  (cond
    [(empty? lst) ... s]
    [else
     ... s
     ... (par-chave (first lst))
     ... (par-valor (first lst))
         (busca s (rest lst))]))
```

\pause

</div>
<div class="column" width="48%">
\footnotesize

```scheme
; implementação
(define (busca s lst)
  (cond
    [(empty? lst) 0]
    [else
     (if (equal? s (par-chave (first lst)))
         (par-valor (first lst))
         (busca s (rest lst)))]))
```

\pause

```scheme
; simplificação
(define (busca s lst)
  (cond
    [(empty? lst) 0]
    [(equal? s (par-chave (first lst)))
     (par-valor (first lst))]
    [else
     (busca s (rest lst))]))
```

</div>
</div>


## Exemplos: junta com "," e "e"

Projete uma função que junte todos os elementos de uma lista de strings (não vazias) separando-os com `", "`{.scheme} ou/e `" e "`{.scheme}, de acordo com a gramática do Português.


## Exemplos: junta com "," e "e"

\scriptsize

```scheme
;; ListaDeStrings -> String
;; Parece difícil escrever o propósito...
;; Vamos fazer os exemplos primeiro.
(define (junta-virgula-e lst) "")
```

Exemplos \pause

`(junta-virgula-e empty)`{.scheme} \pause $\rightarrow$ `""`{.scheme} \pause

`(junta-virgula-e (list "maça"))`{.scheme} \pause $\rightarrow$ `"maça"`{.scheme} \pause

`(junta-virgula-e (list "banana" "maça"))`{.scheme} \pause $\rightarrow$ `"banana e maça"`{.scheme} \pause

`(junta-virgula-e (list "mamão" "banana" "maça"))`{.scheme} \pause $\rightarrow$ `"mamão, banana e maça"`{.scheme} \pause

`(junta-virgula-e (list "aveia" "mamão" "banana" "maça"))`{.scheme} \pause $\rightarrow$ `"aveia, mamão, banana e maça"`{.scheme} \pause

\normalsize

Em todos os exemplos as respostas são calculadas da mesma forma? \pause Não! \pause Os três primeiros exemplos tem uma forma especifica, que não é recursiva. \pause

Então precisamos criar três casos base.


## Exemplos: junta com "," e "e"

\footnotesize

```scheme
;; ListaDeStrings -> String
;; Produz uma string juntando os elementos de lst da seguinte forma:
;; Se a lista é vazia, devolve "".
;; Se a lista tem apenas um elemento, devolve esse elemento.
;; Senão, junta as strings de lst, separando-as com ", ", com exceção da
;; última string, que é separada com " e ".
(examples
  (check-equal? (junta-virgula-e empty)
                "")
  (check-equal? (junta-virgula-e (list "maça"))
                "maça")
  (check-equal? (junta-virgula-e (list "mamão" "banana" "maça"))
                "mamão, banana e maça")
  (check-equal? (junta-virgula-e (list "aveia" "mamão" "banana" "maça"))
                "aveia, mamão, banana e maça"))
(define (junta-virgula-e lst) "")
```


## Exemplos: junta com "," e "e"

\footnotesize

```scheme
(define (junta-virgula-e lst)
  (cond
    [(empty? lst)
     ... ]
    [(empty? (rest lst))
     ... (first lst)]
    [(empty? (rest (rest lst)))
     ... (first lst)
         (second lst)]
    [else
     ... (first lst)
         (junta-virgula-e (rest lst))])
```


## Exemplos: junta com "," e "e"

\footnotesize

```scheme
(define (junta-virgula-e lst)
  (cond
    [(empty? lst)
     ""]
    [(empty? (rest lst))
     (first lst)]
    [(empty? (rest (rest lst)))
     (string-append (first lst)
                    " e "
                    (second lst))]
    [else
     (string-append (first lst)
                    ", "
                    (junta-virgula-e (rest lst)))]))
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

Usamos tipos com autorreferências quando queremos representar dados de tamanhos arbitrários. \pause

- Usamos funções recursivas para processar dados de tipos com autorreferências. \pause

Para ser bem formada, uma definição com autorreferência deve ter: \pause

- Pelo menos um caso base (sem autorreferência): \pause são utilizados para criar os valores iniciais \pause

- Pelo menos um caso com autorreferência: \pause são utilizados para criar novos valores a partir de valores existentes


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
