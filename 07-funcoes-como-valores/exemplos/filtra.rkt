#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vamos criar uma função que abstrai o comportamento das funções
;; lista-positivos e lista-pares.

;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com os valores positivos de lst.
(examples
 (check-equal? (lista-positivos empty)
               empty)
 (check-equal? (lista-positivos (list -3 2 -7))
               (list 2))
 (check-equal? (lista-positivos (list 7 -2 9 20 -11))
               (list 7 9 20)))

;; Implementação inicial da função lista-positivos
#;
(define (lista-positivos lst)
  (cond
    [(empty? lst) empty]
    [(positive? (first lst))
     (cons (first lst) (lista-positivos (rest lst)))]
    [else
     (lista-positivos (rest lst))]))

;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com os valores positvos de lst.
(examples
 (check-equal? (lista-pares empty)
               empty)
 (check-equal? (lista-pares (list 3 2 7))
               (list 2))
 (check-equal? (lista-pares (list 7 2 9 20 11))
               (list 2 20)))

;; Implementação inicial da função lista-pares
#;
(define (lista-pares lst)
  (cond
    [(empty? lst) empty]
    [(even? (first lst))
     (cons (first lst) (lista-pares (rest lst)))]
    [else (lista-pares (rest lst))]))

;; Olhando para o corpo das funções lista-positivos e lista-pares observamos
;; que a única diferença é a ocorrência da função positive? e even?.
;;
;; Da mesma forma que fizemos anteriormente vamos abstrair estas duas funções e
;; criar a função filtra (a função filtra uma lista usando um predicado) que
;; além da lista, recebe como parâmetro pred, que será usado no lugar de
;; positive? (ou even?).
;;
;; Em seguida vamos definir as funções lista-positivos e lista-pares em termos
;; da função filtra.

;; (X -> Boolean) Lista(X) -> Lista(X)
;; Devolve uma lista com todos os elementos x de lst tal que (pred? x) é #t.
;; Veja a função pré-definida filter.
(examples
 (check-equal? (filtra even? empty)
               empty)
 (check-equal? (filtra positive? (list 3 -2 7))
               (list 3 7)))

(define (filtra pred? lst)
  (cond
    [(empty? lst) empty]
    [(pred? (first lst))
     (cons (first lst) (filtra pred? (rest lst)))]
    [else (filtra pred? (rest lst))]))

;; Função lista-positivos escrita em termos de filtra.
(define (lista-positivos lst)
  (filtra positive? lst))

;; Função lista-pares escrita em termos de filtra.
(define (lista-pares lst)
  (filtra even? lst))
