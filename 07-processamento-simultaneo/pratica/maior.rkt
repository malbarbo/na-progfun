#lang racket

(require examples)

;; Natural Natural -> Boolean
;;
;; Devolve true se a é maior que b, falso caso contrário.
;;
;;                             b
;;                +------------+------------------+
;;                |      0     |    (add1 ...)    |
;;   +------------+------------+------------------+
;;   |      0     |           #f                  |
;; a +------------+------------+------------------+
;;   | (add1 ...) |      #t    | recursão natural |
;;   +------------+------------+------------------+

(examples
 (check-equal? (>? 0 0) #f)
 (check-equal? (>? 0 2) #f)
 (check-equal? (>? 2 0) #t)
 (check-equal? (>? 2 3) #f)
 (check-equal? (>? 4 3) #t))

(define (>? a b)
  (cond
    [(zero? a) #f]
    [(zero? b) #t]
    [else (>? (sub1 a) (sub1 b))]))
