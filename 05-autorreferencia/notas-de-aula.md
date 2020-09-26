---
# vim: set spell spelllang=pt_br sw=4:
title: Autorreferência
---


Autorreferência
===============


## Introdução

- Por enquanto estamos trabalho com quantidades pré-determinada de dados

- Como representar e processar uma quantidade de dados indeterminada? \pause

    - Vamos criar estruturas com autorreferência, isto é, estruturas em que
      pelo menos um campo tem o mesmo tipo da estrutura sendo definida

    - Vamos usar funções recursivas para processar estruturas com
      autorreferência



Listas
======


## Listas

- A estrutura recursiva mais comum nas linguagens funcionais é a lista

- Vamos tentar criar uma definição para lista


## Listas

- A ideia é criar uma estrutura com dois campos. O primeiro campo representa um
  valor na lista e o segundo campo representa o restante da lista (que é uma
  lista) \pause

    ```scheme
    (struct lista (primeiro rest) #:transparent)
    ;; Representa uma lista
    ;;  primeiro: Qualquer - é o primeiro elemento
    ;;                       da lista
    ;;  rest:     Lista    - é o restante da lista
    ```


## Listas

- Utilizando esta definição, vamos tentar representar uma lista com os valores
  4, 2 e 8

    ```scheme
    (define lst (lista 4 (lista 2 (lista 8 ???))))
    ```

    \pause

- O problema com esta definição é que ela não tem fim. Uma lista é definida em
  termos de outra lista, que é definida em termos de outra lista, etc


## Listas

- Precisamos de uma maneira de representar uma lista vazia (sem elementos),
  desta forma podemos usar a lista vazia para terminar uma sequência de
  elementos. Em outras palavras, para terminar a definição recursiva,
  precisamos de uma caso base


## Listas

- Uma **Lista** é

    - `nil`; ou

    - `(no primeiro rest)` onde `primeiro` é o primeiro elemento da lista e
      `rest` é uma **Lista** com o restante dos elementos


## Listas

\small

```scheme
(define nil (void))

(struct no (primeiro rest) #:transparent)
;; Uma Lista é
;;   - nil; ou
;;   - (no primeiro rest) onde primeiro é o primeiro elemento
;;     da lista e rest é uma Lista com o restante dos elementos
;; Exemplos
#;
(define lst-vazia nil)
#;
(define lst1 (no 3 nil))
#;
(define lst2 (no 10 (no 3 nil)))
#;
(define lst3 (no 1 lst2))
```


## Listas

```scheme
;; Modelo
#;
(define (fun-for-lista lst)
  (cond
    [(equal? lst nil) ...]
    [else ... (no-primeiro lst)
          ... (fun-for-lista (no-rest lst)) ... ]))
```


## Listas

- Observe que o modelo foi escrito baseado na definição de Lista

    - A definição tem dois casos, o modelo também

    - A definição é recursiva, o modelo também


## Listas

\small

```scheme
> (define lst1 (no 3 nil))        ;Lista com o elemento 3
> (define lst2 (no 8 (no 7 nil))) ;Lista com os elementos 8 e 7
> lst1
(no 3 #<void>)
> lst2
(no 8 (no 7 #<void>))
> (no-primeiro lst2)
8
> (no-rest lst2)
(no 7 #<void>)
> (no-rest lst1)
#<void>
> (no-primeiro (no-rest lst1))
. . no-primeiro: contract violation
  expected: no?
  given: #<void>

;; Observe que o valor nil foi definido como #<void>, e por isso
;; na impressão aparece como #<void> e não nil
```


## Lista

\small

```scheme
;; Lista com os elementos 8 e 7
> (define lst2 (no 8 (no 7 nil)))
;; Defini uma lista a partir de uma lista existente
> (define lst3 (no 4 lst2))
> lst3
(no 4 (no 8 (no 7 #<void>)))
> (no-primeiro lst3)
4
> (no-rest lst3)
(no 8 (no 7 #<void>))
> (no-primeiro (no-rest lst3))
8
```


## Exemplo 3.3

Defina uma função que conte a quantidade de elementos de uma lista.


## Listas

- O Racket já vem com listas pré-definidas

    - `empty` ao invés de `nil`

    - `cons` ao invés de `no`

    - `first` ao invés de `no-primeiro`

    - `rest` ao invés de `no-rest`

- Outras funções

    - `empty?` verifica se uma lista é vazia

    - `list?` verifica se um valor é uma lista


## Listas

- Lista pré-definida em Racket

- Uma **Lista** é

    - `empty`; ou

    - `(cons first rest)` onde `first` é o primeiro elemento da lista e `rest`
      é uma **Lista** com o restante dos elementos


## Listas


```scheme
;; Modelo
#;
(define (fun-for-list lst)
  (cond
    [(empty? lst) ...]
    [else ... (first lst)
          ... (fun-for-list (rest lst)) ... ]))
```


## Listas

\small

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

\small

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

- O Racket oferece uma forma conveniente de criar listas

    ```scheme
    > (list 4 5 6 -2 20)
    '(4 5 6 -2 20)
    ```

- Em geral

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


## Exemplo 3.4

Defina uma função que some os valores de uma lista de números.


## Exemplo 3.5

Defina uma função que receba dois parâmetros, um valor $a$ e uma lista $lst$ e
crie uma nova lista a partir de $lst$ sem a primeira ocorrência de $a$.



Listas aninhadas
================


## Listas aninhadas

- Às vezes é necessário criar uma lista, que contenha outras listas, e estas
  listas contenham outras listas, etc

- Exemplo

    ```scheme
    > (list 1 4 (list 5 empty (list 2) 9) 10)
    '(1 4 (5 () (2) 9) 10)
    ```

- Chamamos este tipo de lista de lista aninhada

- Como podemos definir uma lista aninhada?


## Listas aninhadas

- Uma **Lista aninhada** é

    - `empty`; ou

    - `(cons lst1 lst2)`, onde `lst1` e `lst2` são **Listas aninhadas**; ou

    - `(cons a lst)`, onde `a` é um valor que não seja uma Lista aninhada
        e `lst` é uma **Lista aninhada**


## Listas aninhadas


```scheme
;; Modelo
#;
(define (fun-for-lista-aninhada lst)
  (cond
    [(empty? lst) ...]
    [(list? (first lst))
     ... (fun-for-lista-aninhada (first lst))
     ... (fun-for-lista-aninhada (rest lst)) ...]
    [else
     ... (first lst)
     ... (fun-for-lista-aninhada (rest lst)) ... ]))
```


## Exemplo 3.6

Defina uma função que some todos os números de uma lista aninhada de números.


## Exemplo 3.7

Defina uma função que aplaine uma lista aninhada, isto é, transforme uma lista
aninhada em uma lista sem listas aninhadas com os mesmos elementos e na mesma
ordem da lista aninhada.



Árvores binárias
================


## Árvores binárias

- Como podemos definir uma árvore binária?

\pause

- Uma **Árvore binária** é

    - `empty`; ou

    - `(arvore-bin v esq dir)`, onde `v` é o valor armazenado no nó e `esq`
      e `dir` são **Árvores binárias**


## Árvores binárias

```scheme
;; Modelo
#;
(define (fun-for-arvore-bin t)
  (cond
    [(empty? t) ...]
    [else
     ... (arvore-bin-v t)
     ... (fun-for-arvore-bin (arvore-bin-dir t))
     ... (fun-for-arvore-bin (arvore-bin-esq t)) ...]))
```


## Exemplo 3.8

Defina uma função que calcule a altura de uma árvore binária. A altura de uma
árvore binária é a distância entre a raiz e o seu descendente mais afastado.
Uma árvore com um único nó tem altura 0.




## Introdução

- Um número natural é atômico ou composto? \pause

    - Atômico quando usado em operações aritméticas

    - Composto quando uma iteração precisa ser feita baseado no valor do número

    \pause

- Se um número natural pode ser visto como dado composto

    - Quais são as partes que compõe o número?

    - Como (de)compor um número?



Definição
=========

## Definição

- Um número **Natural** é

    - $0$; ou

    - `(add1 n)` onde $n$ é um número **Natural**

\pause

- Baseado nesta definição, criamos um modelo para funções com números naturais

    ```scheme
    (define (fun-for-natural n)
      (cond
        [(zero? n) ...]
        [else ...
              n
              (fun-for-natural (sub1 n))]))
    ```


## Definição

\small

```scheme
;; as funções add1, sub1 e zero? são pré-definidas

;; compõe um novo natural a partir de um existente
;; semelhante ao cons
> (add1 8)
9
;; decompõe um natural
;; semelhante ao rest
> (sub1 8)
7
;; verifica se um natural é 0
;; semelhante ao empty?
> (zero? 8)
#f
> (zero? 0)
#t
```



Exemplos
========


## Exemplo 4.1

Dado um número natural $n$, defina uma função que some os números naturais
menores ou iguais a $n$.


##

Passo 1: Contrato, propósito e cabeçalho

```scheme
;; Natural -> Natural
;; Soma todos os números naturais de 0 até n
(define (soma n) 0)
```


##

Passo 2: Exemplos

```scheme
(check-equal? (soma 0) 0)
(check-equal? (soma 1) 1) ; (+ 1 0)
(check-equal? (soma 3) 6) ; (+ 3 (+ 2 (+ 1 0)))
```


##

Passo 3: Modelo

```scheme
(define (soma n)
  (cond
    [(zero? n) ...]
    [else ... n (soma (sub1 n))]))
```


##

Passo 4: Corpo (baseado nos exemplos, completamos o modelo)

\small

```scheme
;; Natural -> Natural
;; Soma todos os números naturais de 0 até n

(check-equal (soma 0) 0)
(check-equal (soma 1) 1) ; (+ 1 0)
(check-equal (soma 3) 6) ; (+ 3 (+ 2 (+ 1 0)))

(define (soma n)
  (cond
    [(zero? n) ...]
    [else ... n (soma (sub1 n))]))
```

\pause

```scheme
(define (soma n)
  (cond
    [(zero? n) 0]
    [else (+ n (soma (sub1 n)))]))
```


## Exemplo 4.2

Dado um número natural $n$, defina uma função que devolva a lista
`(list n n-1 n-2 ... 1)`.



Definição Inteiro
=================


## Definição

- Às vezes queremos utilizar um caso base diferente de $0$

- Podemos generalizar a definição de número natural para incluir um limite
  inferior diferente de $0$


## Definição Inteiro

- Um número **Inteiro>=a** é

    - $a$; ou

    - `(add1 n)` onde $n$ é um número **Inteiro>=a**

\pause

- Modelo

    ```scheme
    (define (fun-for-inteiro>=a n)
      (cond
        [(<= n a) ...]
        [else ...
              n
              (fun-for-inteiro>=a (sub1 n))]))
    ```


## Exemplo 4.3

[htdp 11.4.7] Escreva uma função `e-divisivel-por<=i?`, que receba como
parâmetros um número natural $n$ e um número Inteiro>=1 $i$, com $i < n$. Se
$n$ é divisível por algum número entre 1 (não incluindo o 1) e $i$ (incluindo
$i$), a função deve devolver verdadeiro, caso contrário falso. Utilizando
a função `e-divisivel-por<=i?`, defina uma função `primo?`, que verifica se um
número natural é primo. Um número natural é primo se ele tem exatamente dois
divisores distintos: 1 e ele mesmo.



Referências
===========

- [Vídeos Self-Reference](https://www.youtube.com/watch?v=tp44seRHLUQ&list=PL6NenTZG6KrptkOEMyLWDnF0ZjSpVTHAE)

- [Vídeos Naturals](https://www.youtube.com/playlist?list=PL6NenTZG6KroGNU9XgT5G5Dt2M6YGjZMF)

- Capítulos [8 a 12](https://htdp.org/2019-02-24/part_two.html) do livro
  [HTDP](http://htdp.org)

- Seções
    [2.3](http://docs.racket-lang.org/guide/Lists__Iteration__and_Recursion.html),
    [2.4](http://docs.racket-lang.org/guide/Pairs__Lists__and_Racket_Syntax.html) e
    [3.8](http://docs.racket-lang.org/guide/pairs.html) do
    [Guia Racket](http://docs.racket-lang.org/guide/)


## Referências complementares

- Seções
    [2.1](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1)
    (2.1.1 - 2.1.3) e
    [2.2](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2)
    (2.2.1) do livro [SICP](https://mitpress.mit.edu/sicp/)

- Seções
    [3.9](http://docs.racket-lang.org/reference/pairs.html) da
    [Referência Racket](http://docs.racket-lang.org/reference/)

- Seção
    [6.3](http://www.scheme.com/tspl4/objects.html#./objects:h3) do livro
    [TSPL4](http://www.scheme.com/tspl4/)

- Capítulo
  [9.3](https://htdp.org/2018-01-06/Book/part_two.html#%28part._sec~3anats%29)
  do livro [HTDP](http://htdp.org)
