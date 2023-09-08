---
# vim: set spell spelllang=pt_br sw=4:
# TODO: fazer o segundo exemplo passa a passo
# TODO: adicionar mais exemplos?
title: Árvores e processamento simultâneo
---


Árvores binárias
================


## Árvores binárias

Como podemos definir uma árvore binária?

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

<div class="columns">
<div class="column" width="48%">

Uma **ÁrvoreBinária** é \pause

\small

- `empty`{.scheme}; ou

- `(no Número ÁrvoreBinária ÁrvoreBinária)`, onde `no` é uma estrutura com os campos `valor`, `esq` e `dir`

\pause

</div>
<div class="column" width="48%">

\small

Modelo

```scheme
(define (fn-para-abdn t)
  (cond
    [(empty? t) ...]
    [else
      (... (no-valor t)
           (fn-para-abdn (no-esq t))
           (fn-para-abdn (no-dir t)))]))
```

</div>
</div>


## Exemplo: altura árvore

Defina uma função que calcule a altura de uma árvore binária. A altura de uma árvore binária é a distância entre a raiz e o seu descendente mais afastado. Uma árvore com um único nó tem altura 0.


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
    [else (... (no-valor t)
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
    [else (add1 (max
                 (altura (no-esq t))
                 (altura (no-dir t))))]))
```



Listas aninhadas
================


## Listas aninhadas

Às vezes é necessário criar uma lista, que contenha outras listas, e estas listas contenham outras listas, etc. \pause

```scheme
> (list 1 4 (list 5 empty (list 2) 9) 10)
'(1 4 (5 () (2) 9) 10)
```

\pause

Chamamos este tipo de lista de lista aninhada. \pause Como podemos definir uma lista aninhada?


## Listas aninhadas

<div class="columns">
<div class="column" width="52%">

Uma **ListaAninhada** é

\small

- `empty`{.scheme}; ou

- `(cons ListaAninhada ListaAninhada)`{.scheme}

- `(cons Número ListaAninhada)`{.scheme}

</div>
<div class="column" width="46%">
\pause

Modelo

\small

```scheme
(define (fn-para-ladn ldn)
  (cond
    [(empty? ldn) ...]
    [(list? (first ldn))
     (... (fn-para-ladn (first ldn))
          (fn-para-ladn (rest ldn)))]
    [else
     (... (first ldn)
          (fn-para-ladn (rest ldn)))]))
```

</div>
</div>


## Exemplo: soma*

Defina uma função que some todos os números de uma lista aninhada de números.


## Exemplo: soma*

\scriptsize

```scheme
;; ListaAninhadaDeNúmeros -> Número
;; Devolve a soma de todos os elementos de ldn.
(examples
 (check-equal? (soma* empty)
               0)
 (check-equal? (soma* (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               30))
(define (soma* ldn)
  (cond
    [(empty? ldn) ...]
    [(list? (first ldn))
     (... (soma* (first ldn))
          (soma* (rest ldn)))]
    [else
     (... (first ldn)
          (soma* (rest ldn)))]))
```


## Exemplo: soma*

\scriptsize

```scheme
;; ListaAninhadaDeNúmeros -> Número
;; Devolve a soma de todos os elementos de ldn.
(examples
 (check-equal? (soma* empty)
               0)
 (check-equal? (soma* (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               30))
(define (soma* ldn)
  (cond
    [(empty? ldn) 0]
    [(list? (first ldn))
     (+ (soma* (first ldn))
        (soma* (rest ldn)))]
    [else
     (+ (first ldn)
        (soma* (rest ldn)))]))
```


## Exemplo: aplaina

Defina uma função que aplaine uma lista aninhada, isto é, transforme uma lista aninhada em uma lista sem listas aninhadas com os mesmos elementos e na mesma ordem da lista aninhada.


## Exemplo: aplaina

\scriptsize

```scheme
;; ListaAninhadaDeNúmeros -> ListaDeNúmeros
;; Devolve uma versão não aninhada de ldn, isto é, uma lista com os mesmos
;; elementos de ldn, mas sem aninhamento.
(examples
 (check-equal? (aplaina empty) empty)
 (check-equal? (aplaina (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               (list 1 3 4 5 4 6 7)))
(define (aplaina ldn)
  (cond
    [(empty? ldn) ...]
    [(list? (first ldn))
     (... (aplaina (first ldn))
          (aplaina (rest ldn)))]
    [else
     (... (first ldn)
          (aplaina (rest ldn)))]))
```


## Exemplo: aplaina

\scriptsize

```scheme
;; ListaAninhadaDeNúmeros -> ListaDeNúmeros
;; Devolve uma versão não aninhada de ldn, isto é, uma lista com os mesmos
;; elementos de ldn, mas sem aninhamento.
(examples
 (check-equal? (aplaina empty) empty)
 (check-equal? (aplaina (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               (list 1 3 4 5 4 6 7)))
(define (aplaina ldn)
  (cond
    [(empty? ldn) empty]
    [(list? (first ldn))
     (append (aplaina (first ldn))
             (aplaina (rest ldn)))]
    [else
     (cons (first ldn)
           (aplaina (rest ldn)))]))
```


Introdução
==========

## Introdução

Qual modelo utilizar quando a função consome dois ou mais tipos de dados e pelo menos um é definido por mais de uma cláusula? \pause

- Se apenas um dado é definido por mais que uma cláusula (como por exemplo, uma lista), utilizamos o modelo correspondente \pause

- Se mais que dois dados de entrada são definidos por mais que uma cláusula, devemos fazer uma combinação dos modelos


Exemplos
========

## Exemplo: prefixo

Dados duas listas `lsta` e `lstb`, defina uma função que verifique se `lsta` é prefixo de `lstb`, isto é `lstb` começa com `lsta`.


## Exemplo: prefixo

Especificação

```scheme
;; Lista Lista -> Boolean
;; Devolve #t se lsta é prefixo de lstb, #f caso contrário.
(define (prefixo? lsta lstb) #f)
```


## Exemplo: prefixo

Exemplos \pause

- Temos que ter pelo menos um exemplo para cada combinação das definições dos dados de entrada \pause

- `lsta` pode ser `empty` ou um `cons` \pause

- `lstb` pode ser `empty` ou um `cons` \pause

- Como garantir que não vamos esquecer nenhum caso? \pause Fazendo uma tabela!


## Exemplo: prefixo

\footnotesize

```text
                             lstb
                  +------------+------------+
                  |   empty    | (cons ...) |
     +------------+------------+------------+
     |   empty    |            |            |
lsta +------------+------------+------------+
     | (cons ...) |            |            |
     +------------+------------+------------+
```


## Exemplo: prefixo

\footnotesize

```text
                             lstb
                  +------------+------------+
                  |   empty    | (cons ...) |
     +------------+------------+------------+
     |   empty    |     OK     |            |
lsta +------------+------------+------------+
     | (cons ...) |            |            |
     +------------+------------+------------+
```

```scheme
(check-equal? (prefixo? empty empty) #t)
```


## Exemplo: prefixo

\footnotesize

```text
                             lstb
                  +------------+------------+
                  |   empty    | (cons ...) |
     +------------+------------+------------+
     |   empty    |     OK     |     OK     |
lsta +------------+------------+------------+
     | (cons ...) |            |            |
     +------------+------------+------------+
```

```scheme
(check-equal? (prefixo? empty empty) #t)
(check-equal? (prefixo? empty (list 3 2 1)) #t)
```


## Exemplo: prefixo

\footnotesize

```text
                             lstb
                  +------------+------------+
                  |   empty    | (cons ...) |
     +------------+------------+------------+
     |   empty    |     OK     |     OK     |
lsta +------------+------------+------------+
     | (cons ...) |     OK     |            |
     +------------+------------+------------+
```

```scheme
(check-equal? (prefixo? empty empty) #t)
(check-equal? (prefixo? empty (list 3 2 1)) #t)
(check-equal? (prefixo? (list 3 2 1) empty) #f)
```


## Exemplo: prefixo

\footnotesize

```text
                             lstb
                  +------------+------------+
                  |   empty    | (cons ...) |
     +------------+------------+------------+
     |   empty    |     OK     |     OK     |
lsta +------------+------------+------------+
     | (cons ...) |     OK     |     OK     |
     +------------+------------+------------+
```

```scheme
(check-equal? (prefixo? empty empty) #t)
(check-equal? (prefixo? empty (list 3 2 1)) #t)
(check-equal? (prefixo? (list 3 2 1) empty) #f)
(check-equal? (prefixo? (list 3 4) (list 3 4)) #t)
(check-equal? (prefixo? (list 3 4) (list 3 5)) #f)
(check-equal? (prefixo? (list 3 4) (list 3 4 6 8)) #t)
(check-equal? (prefixo? (list 3 5) (list 3 4 6 8)) #f)
(check-equal? (prefixo? (list 3 4 5) (list 3 4)) #f)
```


## Exemplo: prefixo

Implementação \pause

Vamos começar criando um modelo com as quatro possibilidades

\pause

\small

```scheme
(define (prefixo? lsta lstb)
  (cond
    [(and (empty? lsta) (empty? lstb)) ...]
    [(and (empty? lsta) (cons? lstb)) ... lstb ...]
    [(and (cons? lsta) (empty? lstb)) ... lsba ...]
    [else ... lsta ... lstb ...]))
```

\normalsize

\pause

Este início é muito complicado... \pause

Baseado nos exemplos, vamos preencher a tabela e derivar um código mais simples


## Exemplo: prefixo

\scriptsize

```scheme
(check-equal? (prefixo? empty empty) #t)
(check-equal? (prefixo? empty (list 3 2 1)) #t)
(check-equal? (prefixo? (list 3 2 1) empty) #f)
(check-equal? (prefixo? (list 3 4) (list 3 4)) #t)
(check-equal? (prefixo? (list 3 4) (list 3 5)) #f)
(check-equal? (prefixo? (list 3 4) (list 3 4 6 8)) #t)
(check-equal? (prefixo? (list 3 5) (list 3 4 6 8)) #f)
(check-equal? (prefixo? (list 3 4 5) (list 3 4)) #f)
```

```text
                             lstb
                  +------------+--------------------+
                  |    empty   |     (cons ...)     |
     +------------+------------+--------------------+
     |   empty    |            |                    |
lsta +------------+------------+--------------------+
     | (cons ...) |            |                    |
     |            |            |                    |
     +------------+------------+--------------------+
```


## Exemplo: prefixo

\scriptsize

```scheme
(check-equal? (prefixo? empty empty) #t)
(check-equal? (prefixo? empty (list 3 2 1)) #t)
(check-equal? (prefixo? (list 3 2 1) empty) #f)
(check-equal? (prefixo? (list 3 4) (list 3 4)) #t)
(check-equal? (prefixo? (list 3 4) (list 3 5)) #f)
(check-equal? (prefixo? (list 3 4) (list 3 4 6 8)) #t)
(check-equal? (prefixo? (list 3 5) (list 3 4 6 8)) #f)
(check-equal? (prefixo? (list 3 4 5) (list 3 4)) #f)
```

```text
                             lstb
                  +------------+--------------------+
                  |    empty   |     (cons ...)     |
     +------------+------------+--------------------+
     |   empty    |     #t     |        #t          |
lsta +------------+------------+--------------------+
     | (cons ...) |     #f     |  primeiros iguais  |
     |            |            |     e recursão     |
     +------------+------------+--------------------+
```


## Exemplo: prefixo

\scriptsize

Simplificando ...

```text
                             lstb
                  +------------+--------------------+
                  |    empty   |     (cons ...)     |
     +------------+------------+--------------------+
     |   empty    |              #t                 |
lsta +------------+------------+--------------------+
     | (cons ...) |     #f     |  primeiros iguais  |
     |            |            | e recursão natural |
     +------------+------------+--------------------+
```


```scheme
(define (prefixo? lsta lstb)
  (cond
    [(empty? lsta) #t]    ;; os casos foram
    [(empty? lstb) #f]    ;; escolhidos por ordem
    [else                 ;; de simplicidade
      (... (first lsta)
           (first lstb)
           (prefixo? (rest lsta) (rest lstb)))]))
```


## Exemplo: prefixo

Agora completamos a implementação

```scheme
(define (prefixo? lsta lstb)
  (cond
    [(empty? lsta) #t]
    [(empty? lstb) #f]
    [else
      (and (equal? (first lsta) (first lstb))
           (prefixo? (rest lsta) (rest lstb)))]))
```


## Exemplo: $k$-ésimo

Defina uma função que encontre o $k$-ésimo elemento de uma lista.


## Exemplo: $k$-ésimo

Especificação

\pause

```scheme
;; ListaDeNúmeros Natural -> Número
;; Devolve o elemento na posição k da lst.
;; O primeiro elemento está na posição 0.
(define (lista-ref lst k) 0)
```


## Exemplo: $k$-ésimo

Exemplos \pause

\scriptsize

```scheme
;; ListaDeNúmeros Natural -> Número
;; Devolve o elemento na posição k da lst.
;; O primeiro elemento está na posição 0.
;;                               k
;;                  +------------+-------------------+
;;                  |      0     | (add1 ...)        |
;;     +------------+------------+-------------------+
;;     |   empty    |    OK      |       OK          |
;; lst +------------+------------+-------------------+
;;     | (cons ...) |    OK      |       OK          |
;;     +------------+------------+-------------------+
(check-exn exn:fail? (thunk (lista-ref empty 0)))
(check-exn exn:fail? (thunk (lista-ref empty 2)))
(check-equal? (lista-ref (list 3 2 8) 0) 3)
(check-equal? (lista-ref (list 3 2 8 10) 2) 8)
(check-exn exn:fail? (thunk (lista-ref (list 3 2 8 10) 4)))))
(define (lista-ref k lst) 0)
```


## Exemplo: $k$-ésimo

\scriptsize

```scheme
;; ListaDeNúmeros Natural -> Número
;; Devolve o elemento na posição k da lst.
;; O primeiro elemento está na posição 0.
;;                               k
;;                  +------------+-------------------+
;;                  |      0     | (add1 ...)        |
;;     +------------+------------+-------------------+
;;     |   empty    |          erro                  |
;; lst +------------+------------+-------------------+
;;     | (cons ...) | (first lst)|     recursão      |
;;     +------------+------------+-------------------+
(check-exn exn:fail? (thunk (lista-ref empty 0)))
(check-exn exn:fail? (thunk (lista-ref empty 2)))
(check-equal? (lista-ref (list 3 2 8) 0) 3)
(check-equal? (lista-ref (list 3 2 8 10) 2) 8)
(check-exn exn:fail? (thunk (lista-ref (list 3 2 8 10) 4)))))
(define (lista-ref k lst) 0)
```


## Exemplo: $k$-ésimo

\scriptsize

```scheme
;; ListaDeNúmeros Natural -> Número
;;                               k
;;                  +------------+-------------------+
;;                  |      0     | (add1 ...)        |
;;     +------------+------------+-------------------+
;;     |   empty    |          erro                  |
;; lst +------------+------------+-------------------+
;;     | (cons ...) | (first lst)|     recursão      |
;;     +------------+------------+-------------------+
(check-exn exn:fail? (thunk (lista-ref empty 0)))
(check-exn exn:fail? (thunk (lista-ref empty 2)))
(check-equal? (lista-ref (list 3 2 8) 0) 3)
(check-equal? (lista-ref (list 3 2 8 10) 2) 8)
(check-exn exn:fail? (thunk (lista-ref (list 3 2 8 10) 4)))))
(define (lista-ref k lst)
  (cond
    [(empty? lst) (error "Lista vazia")]
    [(zero? k) (first lst)]
    [else (lista-ref (rest lst) (sub1 k))]))
```


## Referências

Básicas

- [Vídeos 2 one-of](https://www.youtube.com/playlist?list=PL6NenTZG6KrqrfIGWPW9CCVtXyugDk_eQ)
