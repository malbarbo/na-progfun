#lang racket

(require examples)

;; ListaDeNúmeros Número -> ListaDeNúmeros
;;
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
