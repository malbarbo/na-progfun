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

Exponenciação e radiciação

```scheme
> (sqr 4) ; quadrado
16
> (sqrt 4) ; raiz quadrada
2
> (expt 2 10) ; exponenciação
1024
> (expt 27 1/3) ; raiz cúbica
3.0
```

Divisão inteira e resto da divisão

```scheme
> (quotient 15 6)
2
> (remainder 15 6)
3
```

Desigualdade

```scheme
> (> 3)
#t
> (> 3 5)
#f
> (>= 3 2 1) ; (and (>= 3 2) (>= 2 1))
#t
> (>= 3 2 3) ; (and (>= 3 2) (>= 2 3))
#f
> (<= 4)
#t
> (<= 4 5)
#t
>(< 10 20 40) ; (and (< 10 20) (< 20 40))
#t
```

Máximo e mínimo

```scheme
> (max 10)
10
> (max 5 6 2 4)
6
> (min 8)
8
> (min -1 -2.1)
-2.1
```

Conversão

```scheme
> (inexact->exact 4.0)
4
> (inexact->exact 2.5)
5/2
> (exact->inexact 3)
3.0
> (number->string 10)
"10"
> (number->string 9.3)
"9.3")
```

Teto, piso e arredondamento

```scheme
> ; teto - menor inteiro maior ou igual
> (ceiling 3.0)
3.0
> (ceiling 3.2)
4.0
> ; piso - menor inteiro menor ou igual
> (floor 3.0)
3.0
> (floor 3.7)
3.0
> (round 4.1)
4.0
> (round 4.5)
5.0
```


Outras funções

```scheme
> (add1 8)
9
> (sub1 7)
6
> (zero? 0)
#t
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
> (abs 4)
4
> (abs -12)
12
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

Maiúsculas e Minúsculas

```scheme
> (string-downcase "NÃO GRITA @2#1!")
"não grita @2#1!"
> (string-upcase "gol!")
"GOL!"
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

or

```scheme
> (or #t)
#t
> (or (= 5 1) #f (> 4 3))
#t
> (or #f (> 5 10) (= 4 1))
#f
```


## Igualdade

Números

```scheme
> ; Os valores são númericamente iguais?
> (= 2)
> (= 2 2.0)
#t
> (= 2 2.0 8/4)
#t
```

Outros objetos

```scheme
> ; Referenciam o mesmo objeto?
> (eq? (substring "banana" 1 4) (substring "cabana" 3 6))
#f
> ; O conteúdo dos objetos referenciados são iguais?
> (equal? (substring "banana" 1 4) (substring "cabana" 3 6))
#t
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

Seguem alguns exemplos

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


## Ajuste de texto

```scheme
#lang racket

(require examples)

;;;;;;;
;; Tipos de dados

;; Alinhamento é um dos valores
;; - "direita"
;; - "esquerda"
;; - "centro"


;; String Number Alinhamento -> String
;;
;; Produz uma nova string a partir de s que tem exatamente num-chars caracteres
;; e é alinhada de acordo com o alinhamento.
;;
;; Se s tem exatamente num-chars caracteres, então produz s.
;;
;; Se s tem mais do que num-chars caracteres, então s é truncada e ...
;; é adicionado ao final para sinalizar que a string foi abreviada.
;;
;; Se s tem menos do que num-chars caracteres, então espaços são
;; adicionados no início se alinhamento é "esquerda", no fim
;; se alinhamento é "direita", ou no ínicio e fim se alinhamento
;; e "centro". Nesse último caso, se a quantidade de espaços adicionados
;; for impar, então no fim será adicionado 1 espaço a mais do que no início.
(examples
 ; (= (string-length s) num-chars)
 (check-equal? (ajusta-string "casa" 4 "direita") "casa")
 (check-equal? (ajusta-string "casa" 4 "esquerda") "casa")
 (check-equal? (ajusta-string "casa" 4 "centro") "casa")

 ; (> (string-length s) num-chars)
 ; (string-append (substring "casa verde" 0 (- 7 3)) "...")
 (check-equal? (ajusta-string "casa verde" 7 "direita") "casa...")
 (check-equal? (ajusta-string "casa verde" 7 "esquarda") "casa...")
 (check-equal? (ajusta-string "casa verde" 7 "centro") "casa...")
 (check-equal? (ajusta-string "casa verde" 9 "direita") "casa v...")

 ; (<= (string-length s) num-chars)
 ; direita
 ; (string-append (make-string (- 9 (string-length "casa")) #\space)
 ;                             "casa")
 (check-equal? (ajusta-string "casa" 9 "direita") "     casa")

 ; esquerda
 ; (string-append (make-string "casa"
 ;                             (- 9 (string-length "casa")) #\space))
 (check-equal? (ajusta-string "casa" 9 "esquerda") "casa     ")

 ; centro
 ; (define num-espacos-inicio (quotient (- num-chars (string-length "casa)) 2)
 ; (define num-espacos-fim (- num-chars (string-length "casa)
 ;                            num-espacos-inicio)
 ; (string-append
 ;   (make-string num-espacos-inicio #\space))
 ;   "centro"
 ;   (make-string num-espacos-fim #\space))
 (check-equal? (ajusta-string "casa" 9 "centro") "  casa   ")
 (check-equal? (ajusta-string "casa" 10 "centro") "   casa   "))

(define (ajusta-string s num-chars alinhamento)
  (cond
    [(= (string-length s) num-chars)
     s]
    [(> (string-length s) num-chars)
     (string-append (substring s 0 (- num-chars 3)) "...")]
    [else
     (define num-espacos (- num-chars (string-length s)))
     (cond
       [(equal? alinhamento "direita")
        (string-append (make-string num-espacos #\space) s)]
       [(equal? alinhamento "esquerda")
        (string-append s (make-string num-espacos #\space))]
       [else
        (define num-espacos-inicio (quotient num-espacos 2))
        (define num-espacos-fim (- num-espacos num-espacos-inicio))
        (string-append
         (make-string num-espacos-inicio #\space)
         s
         (make-string num-espacos-fim #\space))])]))
```
