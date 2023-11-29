---
# vim: set spell spelllang=pt_br sw=4:
title: Resumo da linguagem Racket
urlcolor: Black
toc: true
numbersections: true
license: 
---

# Tipos de dados e operações primitivas

A seguir apresentamos os tipos e operações primitivas.


## Números

Soma e subtração

```scheme
> (+ 2)
2
> (+ 6 1)
7
> (+ 2 3 4.0)
9.0
> (- 10)
-10
> (- 8 2.0 1)
5.0
```

Multiplicação e divisão

```scheme
> (* 6.0)
6.0
> (* 2 4)
8
> (* 4 2.0 3)
24.0
> (/ 2.0)
0.5
> (/ 42 2 3)
7
```

Divisão inteira e resto da divisão

```scheme
> (quotient 15 6)
2
> (remainder 15 6)
3
```

Conversão para string

```scheme
> (number->string 10)
"10"
> (number->string 9.3)
"9.3")
```

Outras funções

```scheme
> (add1 8)
9
> (sub1 7)
6
> (even? 10) ; par
#t
> (odd? 10) ; ímpar
#f
> (positive? 0)
#f
> (positive? 10)
#t
> (negative? -7.2)
#t
```


## Strings e caracteres

Quantidade de caracteres

```scheme
> (string-length "Racket")
6
> (string-length "")
0
```

Concatenação

```scheme
> (string-append "Olha o " "gol" "!!!")
"Olha o gol!!!"
> (string-append)
""
> (string-append "aa")
"aa"
```

Substring

```scheme
> (substring "cadeia de teste" 3 7)
"eia "
> (substring "cadeia de teste" 10)
"teste"
```

Repetição de caractere

```scheme
> (make-string 3 #\a)
"aaa"
> (make-string 5 #\space)
"     "
```

Conversão para número

```scheme
> (string->number "2.0")
2.0
> (string->number "71")
71
```


## Booleanos

Negação

```scheme
> (not #t)
#f
> (not #f)
#t
```

and

```scheme
> (and #t)
#t
> (and (> 4 3) #t (equal? "casa" "casa"))
#t
> (and (> 4 3) (= 5 1))
#f
```

ou

```scheme
> (or #t)
#t
> (or (= 5 1) #f (> 4 3))
#t
> (or #f (> 5 10) (= 4 1))
#f
```



# Definições e formas especiais

Na descrição a seguir `<id>` denota um nome (identificador) qualquer, `expr` uma expressão e `...` repetição da construção.

## Definição

A forma geral para definições é:

```scheme
(define <id> expr)
```

Exemplos

```scheme
> (define x 10)
> (define y (+ x 12))
> y
22
```


As formas gerais para definições de funções são:

```scheme
(define (<id> <id>...)
    expr)
```

Que é equivalente a:

```scheme
(define <id>
  (lambda (<id>...)
    expr)
```

Exemplos

```scheme
> (define (quadrado x)
    (* x x))
> (define soma-quadrados
    (lambda (a b)
      (+ (quadrado a) (quadrado b))))
> (soma-quadrados 3 4)
25
```


## `if`{.scheme}

A forma geral do `if`{.scheme} é:

```scheme
(if expr expr expr)
```

A primeira expressão é o predicado, a segunda o consequente e a terceira a alternativa.

Exemplos

```scheme
> (if (> 4 2) (+ 10 2) (* 7 3))
12
> (if (= 10 12) (+ 10 2) (* 7 3))
21
```


## `cond`{.scheme}

A forma geral do `cond`{.scheme} é

```scheme
(cond
  [expr expr]...
  [else expr])
```

Cada construção `[expr expr]` é chamada de cláusula. A primeira expressão da cláusula é o predicado e a segunda o consequente.

Exemplos

```scheme
> (cond
    [(> 4 2) 10]
    [(= 3 (+ 1 2)) 8]
    [#t 19]
    [else 5])
10
> (cond
    [(< 4 2) 10]
    [(= 3 (+ 1 2)) 8]
    [else 5])
8
> (cond
    [(< 4 2) 10]
    [else 5])
5
```


## `let`{.scheme}

TODO


# Definição de tipos de dados

## Estruturas

TODO

## Uniões

TODO



# Exemplos de programas

Segue alguns exemplos

## Preço combustível

```scheme
#lang racket

(require examples)

;;;;;;;
;; Tipos de dados

;; Preco é um número positivo.

;; Combustivel é um dos valores
;; - "Alcool"
;; - "Gasolina"

;;;;;;;
;; Funções

;; Preco Preco -> Combustivel
;;
;; Encontra o combustivel que deve ser utilizado no abastecimento.
;; Produz "Alcool" se preco-alcool menor ou igual a 70% do preco-gasolina,
;; produz "Gasolina" caso contrário.
(examples
 ; (<= preco-alcool preco-gasolina)
 (check-equal? (seleciona-combustivel 3.00 4.00) "Gasolina")
 (check-equal? (seleciona-combustivel 2.90 4.20) "Alcool")
 ; (> preco-alcool preco-gasolina)
 (check-equal? (seleciona-combustivel 3.50 5.00) "Alcool"))

(define (seleciona-combustivel preco-alcool preco-gasolina)
  (if (<= preco-alcool (* 0.7 preco-gasolina))
      "Alcool"
      "Gasolina"))
```
