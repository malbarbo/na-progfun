#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defina uma função que implemente o algoritmo de ordenação quicksort.

;; Lista(Número) -> Lista(Número)
;; Ordena uma lista de números usando o quicksort.
(examples
 (check-equal? (quicksort empty)
               empty)
 (check-equal? (quicksort (list 3))
               (list 3))
 (check-equal? (quicksort (list 10 3 -4 5 9))
               (list -4 3 5 9 10))
 (check-equal? (quicksort (list 3 10 0 5 9))
               (list 0 3 5 9 10)))

(define (quicksort lst)
  (if (empty? lst)
      empty
      (let ([pivo (first lst)])
        (append (quicksort (filter (curryr < pivo) lst))
                (list pivo)
                (quicksort (filter (curryr > pivo) lst))))))
