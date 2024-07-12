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

- Vamos criar tipos de dados com autorreferência, isto é, tipos de dados que são definidos em termos deles mesmos \pause

- Vamos usar funções recursivas para processar dados com autorreferência



Listas
======


## Listas

O tipo de dado com autorreferência mais comum nas linguagens funcionais é a lista. \pause

Vamos tentar criar uma definição para lista de números.


## Listas

A ideia é criar uma estrutura com dois campos. O primeiro campo representa o primeiro item na lista e o segundo campo representa o restante da lista (que é uma lista). \pause

```scheme
(struct lista (primeiro resto) #:transparent)
;; Representa uma lista de números
;;  primeiro: Número - primeiro elemento da lista
;;  resto:    Lista  - restante da lista
```


## Listas

Utilizando esta definição, vamos tentar representar uma lista com os valores  4, 2 e 8. \pause

```scheme
(define lst (lista 4 (lista 2 (lista 8 ???))))
```

\pause

O problema com esta definição é que ela não tem fim. Uma lista é definida em termos de outra lista, que é definida em termos de outra lista, etc.


## Listas

Precisamos de uma maneira de criar uma lista diretamente, que não seja em termos de outra lista. Que lista pode ser essa? \pause

A lista vazia.


## Listas

Uma **ListaDeNúmeros** é um dos valores: \pause

- `(vazia)`{.scheme}; ou \pause

- `(link Número ListaDeNúmeros)`{.scheme}, onde link é uma estrutura com dois campos: `primeiro`{.scheme} e `resto`{.scheme} \pause

Definição no Racket

```scheme
(struct vazia () #:transparent)
(struct link (primeiro resto) #:transparent)

;; Uma ListaDeNúmeros é um dos valores
;;   - (vazia); ou
;;   - (link Numero ListaDeNúmeros)
```


## Listas

\footnotesize

```scheme
> (define lst1 (link 3 (vazia)))          ; Lista com o 3
> (define lst2 (link 8 (link 7 (vazia)))) ; Lista com o 8 e 7
> lst1
(link 3 (vazia))
> lst2
(link 8 (link 7 (vazia)))
> (link-primeiro lst2)
8
> (link-resto lst2)
(link 7 (vazia))
> (link-resto lst1)
(vazia)
> (link-primeiro (link-resto lst1))
. . link-primeiro: contract violation
  expected: link?
  given: (vazia)
```


## Listas

\footnotesize

```scheme
;; Lista com os elementos 8 e 7
> (define lst2 (link 8 (link 7 (vazia))))
;; Define uma lista a partir de uma lista existente
> (define lst3 (link 4 lst2))
> lst3
(link 4 (link 8 (link 7 (vazia))))
> (link-primeiro lst3)
4
> (link-resto lst3)
(link 8 (link 7 (vazia)))
> (link-primeiro (link-resto lst3))
8
```


## Listas

Nós vimos anteriormente que a forma do dado de entrada de uma função sugere uma forma para o corpo da função. \pause

Qual é a forma para o corpo de uma função que o tipo da entrada ListaDeNúmeros sugere?


## Listas

<div class="columns">
<div class="column" width="45%">

Uma condicional com dois casos: \pause

- A lista é vazia \pause
- A lista é um link \pause

Em Racket \pause

```scheme
(define (fn-para-lst lst)
  (cond
    [(vazia? lst) ...]
    [else
     (... (link-primeiro lst)
          (link-resto lst))]))
```

\pause

</div>
<div class="column" width="52%">

Qual é o tipo do resultado de `(link-primeiro lst)`? \pause Um número, que é um valor atômico. \pause

Qual é o tipo do resultado de `(link-resto lst)`? \pause Uma lista, que é uma união. \pause

Um valor atômico pode ser processado diretamente, mas como processar uma lista? \pause Fazendo análise dos casos... \pause

Vamos fazer uma alteração no modelo `fn-para-lst` e adicionar uma chamada recursiva para processar `(link-resto lst)`. Essa alteração pode parecer meio "mágica" agora, mas ela vai ficar mais clara em breve.

</div>
</div>



## Listas

<div class="columns">
<div class="column" width="43%">

\small
Uma ListaDeNúmeros é um dos valores:

- `(vazia)`{.scheme}; ou

- `(link Número ListaDeNúmeros)`{.scheme}, onde link é uma estrutura com dois campos: `primeiro`{.scheme} e `resto`{.scheme} \pause
</div>
<div class="column" width="53%">

\small

Modelo para funções que a entrada é ListaDeNúmeros

```scheme
(define (fn-para-lst lst)
  (cond
    [(vazia? lst) ...]
    [else
     (... (link-primeiro lst)
          (fn-para-lst (link-resto lst)))]))
```
</div>
</div>

\pause

Quais são as relações entre a definição de `ListaDeNúmeros` e o modelo? \pause

- A definição tem dois casos, o modelo também \pause
- A autorreferência na definição do dado sugere uma chamada recursiva no modelo



## Exemplo: soma

Defina uma função que some os valores de uma lista de números.


## Exemplo: soma

Especificação

\small

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de lst.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8)) ; (+ 4 (+ 1 (+ 3 0)))

(define (soma lst) 0)
```

\pause

\normalsize

E agora, como escrevemos a implementação? \pause Vamos partir do modelo que criamos!

## Exemplo: soma

\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de lst.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8)) ; (+ 4 (+ 1 (+ 3 0)))
```

<div class="columns">
<div class="column" width="48%">

\footnotesize

```scheme
(define (fn-para-lst lst)
  (cond
    [(vazia? lst) ...]
    [else
     (... (link-primeiro lst)
          (fn-para-lst (link-resto lst)))]))
```
\pause
</div>
<div class="column" width="48%">

\small

O que fazemos agora? \pause

Mudamos o nome da função tanto na definição quanto na chamada recursiva.
</div>
</div>


## Exemplo: soma

\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de lst.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8)) ; (+ 4 (+ 1 (+ 3 0)))
```

<div class="columns">
<div class="column" width="48%">
\footnotesize

```scheme
(define (soma lst)
  (cond
    [(vazia? lst) ...]
    [else
     (... (link-primeiro lst)
          (soma (link-resto lst)))]))
```
\pause
</div>
<div class="column" width="48%">
\small
O que fazemos agora? \pause

Vamos preencher as lagunas. \pause Qual deve ser o resultado quando a lista é vazia? \pause 0.
</div>
</div>


## Exemplo: soma

\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de lst.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8)) ; (+ 4 (+ 1 (+ 3 0)))
```

<div class="columns">
<div class="column" width="48%">

\footnotesize

```scheme
(define (soma lst)
  (cond
    [(vazia? lst) 0]
    [else
     (... (link-primeiro lst)
          (soma (link-resto lst)))]))
```
\pause
</div>
<div class="column" width="48%">
\small

O que fazemos agora? \pause

Analisamos o caso em que a lista não é vazia. O modelo está sugerindo fazer a chamada recursiva para o resto da lista.

</div>
</div>


## Exemplo: soma

\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de lst.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8)) ; (+ 4 (+ 1 (+ 3 0)))
```

<div class="columns">
<div class="column" width="48%">

\footnotesize

```scheme
(define (soma lst)
  (cond
    [(vazia? lst) 0]
    [else
     (... (link-primeiro lst)
          (soma (link-resto lst)))]))
```

</div>
<div class="column" width="48%">
\small

Aqui vem o ponto crucial! Mesmo a função não estando completa, nós vamos **assumir** que ela produz a resposta correta para o resto da lista.

</div>
</div>


## Exemplo: soma

\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de lst.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8)) ; (+ 4 (+ 1 (+ 3 0)))
```

<div class="columns">
<div class="column" width="48%">

\footnotesize

```scheme
(define (soma lst)
  (cond
    [(vazia? lst) 0]
    [else
     (... (link-primeiro lst)
          (soma (link-resto lst)))]))
```
</div>
<div class="column" width="48%">
\small

No exemplo 2 queremos obter a soma de `(link 3 (vazia))`{.scheme} que é `3`{.scheme}. O que temos para compor o resultado? \pause

- `3`{.scheme}, que é `(link-primeiro lst)`{.scheme}
- `0`{.scheme}, que é `(soma (link-resto lst))`{.scheme}

\pause
Como obtemos o resultado que queremos? \pause `(+ 3 0)`{.scheme}

</div>
</div>

## Exemplo: soma

\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de lst.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8)) ; (+ 4 (+ 1 (+ 3 0)))
```

<div class="columns">
<div class="column" width="48%">

\footnotesize

```scheme
(define (soma lst)
  (cond
    [(vazia? lst) 0]
    [else
     (... (link-primeiro lst)
          (soma (link-resto lst)))]))
```
</div>
<div class="column" width="48%">
\small

No exemplo 3 queremos obter a soma de `(link 2 (link 5 (vazia)))`{.scheme} que é `7`{.scheme}. O que temos para compor o resultado? \pause

- `2`{.scheme}, que é `(link-primeiro lst)`{.scheme}
- `5`{.scheme}, que é `(soma (link-resto lst))`{.scheme}

\pause
Como obtemos o resultado que queremos? \pause `(+ 2 5)`{.scheme}

</div>
</div>

## Exemplo: soma

\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de lst.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8)) ; (+ 4 (+ 1 (+ 3 0)))
```

<div class="columns">
<div class="column" width="48%">

\footnotesize

```scheme
(define (soma lst)
  (cond
    [(vazia? lst) 0]
    [else
     (... (link-primeiro lst)
          (soma (link-resto lst)))]))
```
</div>
<div class="column" width="48%">
\small

No exemplo 4 queremos obter a soma de `(link 4 (link 1 (link 3 (vazia)))`{.scheme} que é `8`{.scheme}. O que temos para compor o resultado? \pause

- `4`{.scheme}, que é `(link-primeiro lst)`{.scheme}
- `4`{.scheme}, que é `(soma (link-resto lst))`{.scheme}

\pause
Como obtemos o resultado que queremos? \pause `(+ 4 4)`{.scheme}

</div>
</div>


## Exemplo: soma

Agora que compreendemos como o resultado é formado, podemos completar o corpo da função. \pause

\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de lst.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8)) ; (+ 4 (+ 1 (+ 3 0)))

(define (soma lst)
  (cond
    [(vazia? lst) 0]
    [else
     (+ (link-primeiro lst)
        (soma (link-resto lst)))]))
```


## Exemplo: soma

Verificação: Ok. \pause

Revisão: Ok.


## Listas

<div class="columns">
<div class="column" width="48%">

O Racket já vem com listas pré-definidas

- `empty`{.scheme} ao invés de `(vazia)`{.scheme}

- `cons`{.scheme} ao invés de `link`{.scheme}

- `first`{.scheme} ao invés de `link-primeiro`{.scheme}

- `rest`{.scheme} ao invés de `link-resto`{.scheme}

\pause
</div>
<div class="column" width="48%">

Outras funções pré-definidas (os propósitos são aproximados)

- `list?`{.scheme} verifica se um valor é uma lista

- `empty?`{.scheme} verifica se uma lista é vazia

- `cons?`{.scheme} verifica se uma lista não é vazia


</div>
</div>


## Listas

<div class="columns">
<div class="column" width="44%">

\small

Uma **ListaDeNúmeros** é um dos valores

- `empty`{.scheme}; ou

- `(cons Número ListaDeNúmeros)`{.scheme}

</div>
<div class="column" width="54%">

\small

```scheme
;; Modelo de funções para ListaDeNúmeros
(define (fn-para-lst lst)
  (cond
    [(empty? lst) ...]
    [else
      ... (first lst)
      ... (fn-para-lst (rest lst)) ... ]))
```

</div>
</div>


## Listas

\footnotesize

```scheme
> (define lst1 (cons 3 empty)) ; Lista com o elemento 3
> (define lst2 (cons 8 (cons 7 empty))) ; Lista com 8 e 7
> lst1
'(3)
> lst2
'(8 7)
> (first lst2)
8
> (rest lst2)
'(7)
> (rest (rest lst2))
'()
> (first (rest lst1))
. . first: contract violation
  expected: (and/c list? (not/c empty?))
    given: '()
```


## Listas

\footnotesize

```scheme
;; Lista com os elementos 8 e 7
> (define lst2 (cons 8 (cons 7 empty)))
;; Defini uma lista a partir de uma lista existente
> (define lst3 (cons 4 lst2))
> lst3
'(4 8 7)
> (first lst3)
4
> (rest lst3)
'(8 7)
> (first (rest lst3))
8
```


## Listas

O Racket oferece uma forma conveniente de criar listas \pause

```scheme
> (list 4 5 6 -2 20)
'(4 5 6 -2 20)
```

\pause

Em geral

```scheme
(list <a1> <a2> ... <an>)
```

é equivalente a

```scheme
(cons <a1>
      (cons <a2>
            (cons ...
                  (cons <an> empty) ...)))
```


## Exemplo: contém

Defina uma função que verifique se um dado valor está em uma lista de números.


## Exemplo: contém

\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em lst; #f caso contrário.
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))
```

<div class="columns">
<div class="column" width="48%">
\footnotesize

```scheme
(define (contem? lst v) #f)






```
</div>
<div class="column" width="48%">
\small
Iniciamos com a especificação.
</div>
</div>


## Exemplo: contém

\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em lst; #f caso contrário.
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))
```

<div class="columns">
<div class="column" width="48%">

\footnotesize

```scheme
(define (fn-para-lst lst)
  (cond
    [(empty? lst) ...]
    [else
      ... (first lst)
      ... (fn-para-lst (rest lst)) ... ]))

```
</div>
<div class="column" width="48%">
\small
Para implementação partimos do modelo.
</div>
</div>


## Exemplo: contém

\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em lst; #f caso contrário.
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))
```

<div class="columns">
<div class="column" width="48%">

\footnotesize

```scheme
(define (contem? lst v)
  (cond
    [(empty? lst) ... v]
    [else
      ... (first lst)
      ... v
      ... (contem? (rest lst) v) ... ]))
```
</div>
<div class="column" width="48%">
\small
Em seguida ajeitamos o nome da função e adicionamos o parâmetro `v` na definição, na chamada recursiva e como valor disponível nos dois casos.
</div>
</div>


## Exemplo: contém

\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em lst; #f caso contrário
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))
```

<div class="columns">
<div class="column" width="48%">

\footnotesize

```scheme
(define (contem? lst v)
  (cond
    [(empty? lst) #f]
    [else
      ... (first lst)
      ... v
      ... (contem? (rest lst) v) ... ]))
```
</div>
<div class="column" width="48%">
\small
Analisando os exemplos definimos o caso em que a lista é vazia.
</div>
</div>


## Exemplo: contém

\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em lst; #f caso contrário
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))
```

<div class="columns">
<div class="column" width="48%">

\footnotesize

```scheme
(define (contem? lst v)
  (cond
    [(empty? lst) #f]
    [else
      ... (first lst)
      ... v
      ... (contem? (rest lst) v) ... ]))
```
</div>
<div class="column" width="48%">
\small

Agora analisamos o caso em que a `lst` não é vazia. \pause Temos `(first lst)`{.scheme}, `v` e `(contem? (rest lst) v)`{.scheme} (se o resto de `lst` contém `v`). \pause Como combinar esses elementos para determinar `(contem? lst v)` (se `lst` contém `v`)?
</div>
</div>

## Exemplo: contém

\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em lst; #f caso contrário
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))
```

<div class="columns">
<div class="column" width="48%">

\footnotesize

```scheme
(define (contem? lst v)
  (cond
    [(empty? lst) #f]
    [else
     (if (= v (first lst))
         #t
         (contem? (rest lst) v))]))
```
</div>
<div class="column" width="48%">
\small

Quando `(first lst)` é igual a `v`, podemos gerar a resposta `#t`{.scheme} diretamente, independente da resposta da chamada recursiva. \pause Caso contrário, a resposta se `lst` contém `v` e a mesma se `(rest lst)` contém `v`, ou seja, a resposta para `(contem? lst v)`{.scheme} é a equivalente a `(contem? (rest lst) v)`.
</div>
</div>


## Exemplo: contém

\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em lst; #f caso contrário
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))
```

<div class="columns">
<div class="column" width="48%">
\footnotesize

```scheme
(define (contem? lst v)
  (cond
    [(empty? lst) #f]
    [else
     (or (= v (first lst))
         (contem? (rest lst) v))]))
```
</div>
<div class="column" width="48%">
Revisão.
</div>
</div>


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


## Exemplo: soma x

Verificação: Ok.

Revisão: Ok.


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

<div class="columns">
<div class="column" width="48%">
\scriptsize

```scheme
;; ListaDeStrings -> String
;; Se a lista é vazia, devolve "".
;; Se a lista tem apenas um elemento, devolve
;; esse elemento.
;; Senão, junta as strings de lst, separando-as
;; com ", ", com exceção da última string, que
;; é separada com " e ".
(examples
  (check-equal? (junta-virgula-e empty) "")
  (check-equal?
    (junta-virgula-e (list "maça")) "maça")
  (check-equal?
    (junta-virgula-e (list "mamão" "banana"
                           "maça"))
    "mamão, banana e maça")
  (check-equal?
    (junta-virgula-e (list "aveia" "mamão"
                           "banana" "maça"))
    "aveia, mamão, banana e maça"))
(define (junta-virgula-e lst) "")
```
</div>
<div class="column" width="48%">

\pause

Implementação

\pause

\scriptsize

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
