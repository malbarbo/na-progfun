#lang racket

(require examples)

;; ListaDeNúmeros -> Natural
;;
;; Devolve a quantidade de elementos de lst.

(examples
  (check-equal? (quantidade-elementos empty) 0)
  (check-equal? (quantidade-elementos (cons 2 empty)) 1)
  (check-equal? (quantidade-elementos (cons -3 (cons 2 empty))) 2)
  (check-equal? (quantidade-elementos (cons 0 (cons -3 (cons 2 empty)))) 3))

(define (quantidade-elementos lst)
  (cond
    [(empty? lst) 0]
    [else (+ 1 (quantidade-elementos (rest lst)))]))
