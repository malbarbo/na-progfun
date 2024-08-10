#lang racket

(require examples)

;; (Número -> Bool) Lista(Números) -> Natural
;; Conta a quantidade de elementos em lst
;; que satisfazem o predicado pred?.
(examples
  (check-equal? (conta positive? (list 1 -1 2 3 -2 5)) 4))
(define (conta pred? lst)
  (cond
    [(empty? lst) 0]
    [(pred? (first lst))
     (add1 (conta pred? (rest lst)))]
    [else
      (conta pred? (rest lst))]))
