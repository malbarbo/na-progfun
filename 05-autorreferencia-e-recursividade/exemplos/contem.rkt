#lang racket

(require examples)

;; ListaDeNúmeros Número -> Booleano
;;
;; Produz #t se v está em lst; #f caso contrário.

(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))

(define (contem? lst v)
  (cond
    [(empty? lst) #f]
    [else
     (or (= v (first lst))
         (contem? (rest lst) v))]))
