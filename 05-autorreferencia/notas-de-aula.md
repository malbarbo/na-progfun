---
# vim: set spell spelllang=pt_br sw=4:
# TODO: renomear para autorreferências (no plural)
title: Autorreferência
---


Introdução
==========

## Introdução

- Por enquanto estamos trabalho com quantidades pré-determinada de dados

- Como representar e processar uma quantidade de dados arbitrária? \pause

    - Vamos criar dados com autorreferência, isto é, dados que são
      definidos em termos deles mesmos

    - Vamos usar funções recursivas para processar dados com
      autorreferência



Listas
======


## Listas

- O tipo de dado com autorreferência mais comum nas linguagens funcionais é a lista

- Vamos tentar criar uma definição para lista de números


## Listas

- A ideia é criar uma estrutura com dois campos. O primeiro campo representa um
  valor na lista e o segundo campo representa o restante da lista (que é uma
  lista) \pause

    ```scheme
    (struct lista (primeiro resto) #:transparent)
    ;; Representa uma lista de números
    ;;  primeiro: Número - é o primeiro elemento
    ;;                     da lista
    ;;  resto:    Lista  - é o restante da lista
    ```


## Listas

- Utilizando esta definição, vamos tentar representar uma lista com os valores
  4, 2 e 8

    ```scheme
    (define lst (lista 4 (lista 2 (lista 8 ???))))
    ```

\pause

- O problema com esta definição é que ela não tem fim. Uma lista é definida em
  termos de outra lista, que é definida em termos de outra lista, etc.


## Listas

- Precisamos de uma maneira de criar uma lista diretamente, que não seja em termos
  de outra lista. Que lista pode ser essa? \pause

    - A lista vazia.



## Listas

- Uma **ListaDeNúmeros** é um dos valores:

    - `(vazia)`; ou

    - `(link Número ListaDeNúmeros)`, onde link é uma estrutura com dois campos: `primeiro` e `resto`


## Listas

\small

```scheme
(struct vazia () #:transparent)

(struct link (primeiro resto) #:transparent)
;; Uma ListaDeNúmeros é um dos valores
;;   - (vazia); ou
;;   - (link Numero ListaDeNúmeros)
;;
;; Exemplos
#;
(define lst-vazia (vazia))
#;
(define lst1 (link 3 (vazia)))
#;
(define lst2 (link 10 (link 3 (vazia))))
#;
(define lst3 (link 1 lst2))
```


## Listas

```scheme
;; Modelo
#;
(define (fn-para-ldn ldn)
  (cond
    [(vazia? ldn) ...]
    [else
     (... (link-primeiro ldn)
          (fn-para-lista (link-resto ldn)))]))
```


## Listas

- Observe que o modelo foi escrito baseado na definição de `ListaDeNúmeros`

    - A definição tem dois casos, o modelo também

    - A autorreferência na definição do dado sugere uma chamada recursiva no modelo


## Listas

\small

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
  given: (void)
```


## Listas

\small

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


## Exemplo: soma

Defina uma função que some os valores de uma lista de números.


## Listas

- O Racket já vem com listas pré-definidas

    - `empty` ao invés de `(vazia)`

    - `cons` ao invés de `link`

    - `first` ao invés de `link-primeiro`

    - `rest` ao invés de `link-resto`

- Outras funções (os propósitos são aproximados)

    - `empty?` verifica se uma lista é vazia

    - `cons?` verifica se uma lista não é vazia

    - `list?` verifica se um valor é uma lista


## Listas

- Uma **ListaDeNúmeros** é um dos valores

    - `empty`; ou

    - `(cons Número ListaDeNúmeros)`


## Listas


```scheme
;; Modelo
#;
(define (fn-para-ldn ldn)
  (cond
    [(empty? ldn) ...]
    [else ... (first ldn)
          ... (fn-para-ldn (rest ldn)) ... ]))
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


## Exemplo: contém

Defina uma função que verifique se um dado valor está em uma lista de números.


## Exemplo: remove negativos

Defina uma função que remova todos os número negativos de uma lista de números.


## Exemplo: soma x

Defina uma função que soma um valor `x` em cada elemento de uma lista de números.



Números Naturais
================


## Introdução

- Um número natural é atômico ou composto? \pause

    - Atômico quando usado em operações aritméticas, comparações, etc

    - Composto quando uma iteração precisa ser feita baseado no valor do número

\pause

- Se um número natural pode ser visto como dado composto

    - Quais são as partes que compõe o número?

    - Como (de)compor um número?


## Definição

- Um número **Natural** é

    - $0$; ou

    - `(add1 n)` onde $n$ é um número **Natural**

\pause

- Baseado nesta definição, criamos um modelo para funções com números naturais

    ```scheme
    (define (fn-para-natural n)
      (cond
        [(zero? n) ...]
        [else
          (... n
               (fn-para-natural (sub1 n)))]))
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


## Exemplo: soma naturais

Dado um número natural $n$, defina uma função que some os números naturais
menores ou iguais a $n$.


## Exemplo: soma naturais

Passo 2: Assinatura, propósito e esboço

\small

```scheme
;; Natural -> Natural
;; Soma todos os números naturais de 0 até n
(define (soma-nat n) 0)










```


## Exemplo: soma naturais

Passo 3: Exemplos

\small

```scheme
;; Natural -> Natural
;; Soma todos os números naturais de 0 até n
(examples
 (check-equal? (soma-nat 0) 0)
 (check-equal? (soma-nat 1) 1)  ; (+ 1 0)
 (check-equal? (soma-nat 3) 6)) ; (+ 3 (+ 2 (+ 1 0)))
(define (soma-nat n) 0)






```


## Exemplo: soma naturais

Passo 4: Modelo

\small

```scheme
;; Natural -> Natural
;; Soma todos os números naturais de 0 até n
(examples
 (check-equal? (soma-nat 0) 0)
 (check-equal? (soma-nat 1) 1)  ; (+ 1 0)
 (check-equal? (soma-nat 3) 6)) ; (+ 3 (+ 2 (+ 1 0)))
(define (soma-nat n)
  (cond
    [(zero? n) ...]
    [else
      (... n
           (soma-nat (sub1 n)))]))
```


## Exemplo: soma naturais

Passo 5: Corpo

\small

```scheme
;; Natural -> Natural
;; Soma todos os números naturais de 0 até n
(examples
 (check-equal? (soma-nat 0) 0)
 (check-equal? (soma-nat 1) 1)  ; (+ 1 0)
 (check-equal? (soma-nat 3) 6)) ; (+ 3 (+ 2 (+ 1 0)))
(define (soma-nat n)
  (cond
    [(zero? n) 0]
    [else
      (... n
           (soma-nat (sub1 n)))]))
```

## Exemplo: soma naturais

Passo 5: Corpo

\small

```scheme
;; Natural -> Natural
;; Soma todos os números naturais de 0 até n
(examples
 (check-equal? (soma-nat 0) 0)
 (check-equal? (soma-nat 1) 1)  ; (+ 1 0)
 (check-equal? (soma-nat 3) 6)) ; (+ 3 (+ 2 (+ 1 0)))
(define (soma-nat n)
  (cond
    [(zero? n) 0]
    [else
      (+ n
         (soma-nat (sub1 n)))]))
```


## Exemplo: lista de números

Dado um número natural $n$, defina uma função que devolva a lista
`(list 1 2 ... n-1 n)`.



## Exemplo: lista de números

Passo 2: Assinatura, propósito e esboço

\small

```scheme
;; Natural -> ListaDeNúmeros
;; Cria uma lista com os valores 1 2 ... n-1 n
(define (lista-num n) empty)









```


## Exemplo: lista de números

Passo 3: Exemplos

\small

```scheme
;; Natural -> ListaDeNúmeros
;; Cria uma lista com os valores 1 2 ... n-1 n
(examples
  (check-equal? (lista-num 0) empty)
  (check-equal? (lista-num 1) (cons 1 empty))
  (check-equal? (lista-num 3) (cons 1 (cons 2 (cons 3 empty)))))
(define (lista-num n) empty)





```


## Exemplo: lista de números

Passo 4: Modelo

\small

```scheme
;; Natural -> ListaDeNúmeros
;; Cria uma lista com os valores 1 2 ... n-1 n
(examples
  (check-equal? (lista-num 0) empty)
  (check-equal? (lista-num 1) (cons 1 empty))
  (check-equal? (lista-num 3) (cons 1 (cons 2 (cons 3 empty)))))
(define (lista-num n)
  (cond
    [(zero? n) ...]
    [else
      (... n
           (lista-num (sub1 n)))]))
```


## Exemplo: lista de números

Passo 5: Corpo

\small

```scheme
;; Natural -> ListaDeNúmeros
;; Cria uma lista com os valores 1 2 ... n-1 n
(examples
  (check-equal? (lista-num 0) empty)
  (check-equal? (lista-num 1) (cons 1 empty))
  (check-equal? (lista-num 3) (cons 1 (cons 2 (cons 3 empty)))))
(define (lista-num n)
  (cond
    [(zero? n) empty]
    [else
      (... n
           (lista-num (sub1 n)))]))
```


## Exemplo: lista de números

Passo 5: Corpo

\small

```scheme
;; Natural -> ListaDeNúmeros
;; Cria uma lista com os valores 1 2 ... n-1 n
(examples
  (check-equal? (lista-num 0) empty)
  (check-equal? (lista-num 1) (cons 1 empty))
  (check-equal? (lista-num 3) (cons 1 (cons 2 (cons 3 empty)))))
(define (lista-num n)
  (cond
    [(zero? n) empty]
    [else
      (cons-fim n
                (lista-num (sub1 n)))]))
```


## Exemplo: adiciona no final da lista

Entrada na lista de pendência (ou lista de desejos)

\small

```scheme
;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Adiciona n ao final de lst.
(define (cons-fim n lst) lst)









```


## Exemplo: adiciona no final da lista

Passo 3: Exemplos

\small

```scheme
;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Adiciona n ao final de lst.
(examples
  (check-equal? (cons-fim 3 empty) (cons 3 empty))
  (check-equal? (cons-fim 1 (cons 3 (cons 4 empty)))
                (cons 3 (cons 4 (cons 1 empty)))))
(define (cons-fim n lst) lst)





```


## Exemplo: adiciona no final da lista

Passo 4: Modelo

\small

```scheme
;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Adiciona n ao final de lst.
(examples
  (check-equal? (cons-fim 3 empty) (cons 3 empty))
  (check-equal? (cons-fim 1 (cons 3 (cons 4 empty)))
                (cons 3 (cons 4 (cons 1 empty)))))
(define (cons-fim n ldn)
  (cond
    [(empty? ldn) ... n]
    [else
     (... (first ldn)
          (cons-fim n (rest ldn)))]))
```


## Exemplo: adiciona no final da lista

Passo 5: Corpo

\small

```scheme
;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Adiciona n ao final de lst.
(examples
  (check-equal? (cons-fim 3 empty) (cons 3 empty))
  (check-equal? (cons-fim 1 (cons 3 (cons 4 empty)))
                (cons 3 (cons 4 (cons 1 empty)))))
(define (cons-fim n ldn)
  (cond
    [(empty? ldn) (cons n empty)]
    [else
     (... (first ldn)
          (cons-fim n (rest ldn)))]))
```


## Exemplo: adiciona no final da lista

Passo 5: Corpo

\small

```scheme
;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Adiciona n ao final de lst.
(examples
  (check-equal? (cons-fim 3 empty) (cons 3 empty))
  (check-equal? (cons-fim 1 (cons 3 (cons 4 empty)))
                (cons 3 (cons 4 (cons 1 empty)))))
(define (cons-fim n ldn)
  (cond
    [(empty? ldn) (cons n empty)]
    [else
     (cons (first ldn)
           (cons-fim n (rest ldn)))]))
```



Inteiros
========


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
    (define (fn-para-inteiro>=a n)
      (cond
        [(<= n a) ...]
        [else
          (... n
               (fn-para-inteiro>=a (sub1 n)))]))
    ```



Árvores binárias
================


## Árvores binárias

- Como podemos definir uma árvore binária?

```
        3
      /   \
     4     7
    /     / \
   3     8   9
            /
           10
```


## Árvores binárias

- Uma **ÁrvoreBináriaDeNúmeros** é

    - `empty`; ou

    - `(no Número ÁrvoreBináriaDeNúmeros ÁrvoreBináriaDeNúmeros)`, onde `no`
      é uma estrutura com os campos `valor`, `esq` e `dir`

\pause

- Modelo

    ```scheme
    (define (fn-para-abdn t)
      (cond
        [(empty? t) ...]
        [else
          (... (no-valor t)
               (fn-para-abdn (no-esq t))
               (fn-para-abdn (no-dir t)))]))
    ```


## Exemplo: altura árvore

Defina uma função que calcule a altura de uma árvore binária. A altura de uma
árvore binária é a distância entre a raiz e o seu descendente mais afastado.
Uma árvore com um único nó tem altura 0.


## Exemplo: altura árvore

\scriptsize

```scheme
;;     t4  3
;;       /   \
;;  t3  4     7  t2
;;     /     / \
;;    3     8   9  t1
;;             /
;;        t0  10
;; ÁrvoreBináriaDeNúmeros -> Natural
(check-equal? (altura empty) ?)
(check-equal? (altura t0) 0)
(check-equal? (altura t1) 1)
(check-equal? (altura t2) 2)
(check-equal? (altura t3) 1)
(check-equal? (altura t4) 3)
(define (altura t)
  (cond
    [(empty? t) ...]
    [else
      (... (no-valor t)
           (altura (no-esq t))
           (altura (no-dir t)))]))
```


## Exemplo: altura árvore

\scriptsize

```scheme
;;     t4  3
;;       /   \
;;  t3  4     7  t2
;;     /     / \
;;    3     8   9  t1
;;             /
;;        t0  10
;; ÁrvoreBináriaDeNúmeros -> Natural
(check-equal? (altura empty) -1)
(check-equal? (altura t0) 0)
(check-equal? (altura t1) 1)
(check-equal? (altura t2) 2)
(check-equal? (altura t3) 1)
(check-equal? (altura t4) 3)
(define (altura t)
  (cond
    [(empty? t) -1]
    [else
      (add1 (max
             (altura (no-esq t))
             (altura (no-dir t))))]))
```



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

- Uma **ListaAninhadaDeNúmeros** é

    - `empty`; ou

    - `(cons ListaAninhadaDeNúmeros ListaAninhadaDeNúmeros)`

    - `(cons Número ListaAninhadaDeNúmeros)`


## Listas aninhadas

```scheme
;; Modelo
#;
(define (fn-para-ladn lst)
  (cond
    [(empty? lst) ...]
    [(list? (first lst))
     (... (fn-para-ladn (first lst))
          (fn-para-ladn (rest lst)))]
    [else
     (... (first lst)
          (fn-para-ladn (rest lst)))]))
```


## Exemplo: soma*

Defina uma função que some todos os números de uma lista aninhada de números.


## Exemplo: soma*

\scriptsize

```scheme
;; ListaAninhadaDeNúmeros -> Número
;; Devolve a soma de todos os elementos de lst.
(examples
 (check-equal? (soma* empty)
               0)
 (check-equal? (soma* (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               30))
(define (soma* lst)
  (cond
    [(empty? lst) ...]
    [(list? (first lst))
     (... (soma* (first lst))
          (soma* (rest lst)))]
    [else
     (... (first lst)
          (soma* (rest lst)))]))
```


## Exemplo: soma*

\scriptsize

```scheme
;; ListaAninhadaDeNúmeros -> Número
;; Devolve a soma de todos os elementos de lst.
(examples
 (check-equal? (soma* empty)
               0)
 (check-equal? (soma* (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               30))
(define (soma* lst)
  (cond
    [(empty? lst) 0]
    [(list? (first lst))
     (+ (soma* (first lst))
        (soma* (rest lst)))]
    [else
     (+ (first lst)
        (soma* (rest lst)))]))
```


## Exemplo: aplaina

Defina uma função que aplaine uma lista aninhada, isto é, transforme uma lista
aninhada em uma lista sem listas aninhadas com os mesmos elementos e na mesma
ordem da lista aninhada.


## Exemplo: aplaina

\scriptsize

```scheme
;; ListaAninhadaDeNúmeros -> ListaDeNúmeros
;; Devolve uma versão não aninhada de lst, isto é, uma lista com os mesmos
;; elementos de lst, mas sem aninhamento.
(examples
 (check-equal? (aplaina empty) empty)
 (check-equal? (aplaina (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               (list 1 3 4 5 4 6 7)))
(define (aplaina lst)
  (cond
    [(empty? lst) ...]
    [(list? (first lst))
     (... (aplaina (first lst))
          (aplaina (rest lst)))]
    [else
     (... (first lst)
          (aplaina (rest lst)))]))
```


## Exemplo: aplaina

\scriptsize

```scheme
;; ListaAninhadaDeNúmeros -> ListaDeNúmeros
;; Devolve uma versão não aninhada de lst, isto é, uma lista com os mesmos
;; elementos de lst, mas sem aninhamento.
(examples
 (check-equal? (aplaina empty) empty)
 (check-equal? (aplaina (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               (list 1 3 4 5 4 6 7)))
(define (aplaina lst)
  (cond
    [(empty? lst) empty]
    [(list? (first lst))
     (append (aplaina (first lst))
             (aplaina (rest lst)))]
    [else
     (cons (first lst)
           (aplaina (rest lst)))]))
```



Observações finais
==================


## Observações finais

- Usamos dados com autorreferências quando queremos representar dados de tamanhos arbitrários

- Usamos funções recursivas para processar dados com autorreferências \pause

- Para ser bem formada, uma definição com autorreferência deve ter: \pause

    - Pelo menos um caso base (sem autorreferência): \pause são utilizados para
      criar os valores iniciais \pause

    - Pelo menos um caso com autorreferência: \pause são utilizados para criar
      novos valores a partir de valores existentes \pause

- As vezes é interessante pensar em números inteiros e naturais como sendo compostos e definidos com autorreferência



Referências
===========

## Referências

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
