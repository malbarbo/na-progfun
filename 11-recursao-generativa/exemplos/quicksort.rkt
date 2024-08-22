#lang racket

(require examples)

;; Lista(Número) -> Lista(Número)
;; Ordena lst em ordem não decrescente usado o quicksort.
(examples
 (check-equal? (quicksort empty)
               empty)
 (check-equal? (quicksort (list 3))
               (list 3))
 (check-equal? (quicksort (list 3 3 3))
               (list 3 3 3))
 (check-equal? (quicksort (list 10 3 -4 5 9))
               (list -4 3 5 9 10))
 (check-equal? (quicksort (list 3 10 0 5 9))
               (list 0 3 5 9 10)))

(define (quicksort lst)
  (cond
    [(empty? lst) empty]
    [else
     (define pivo (first lst))
     (append (quicksort (filter (curry >= pivo) (rest lst)))
             (list pivo)
             (quicksort (filter (curry < pivo) (rest lst))))]))
