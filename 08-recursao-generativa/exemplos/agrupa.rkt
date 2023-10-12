#lang racket

(require examples)

;; (Lista Número) InteiroPositivo -> (Lista (Lista Número))
;;
;; Agrupa os elementos de lst em listas
;; com n elementos. Apenas a última lista
;; do resultado pode ficar com menos que n
;; elementos.
(examples
 (check-equal? (agrupa empty 2) empty)
 (check-equal? (agrupa (list 4 1 5) 1)
               (list (list 4) (list 1) (list 5)))
 (check-equal? (agrupa (list 4 1 5 7 8) 2)
               (list (list 4 1) (list 5 7) (list 8)))
 (check-equal? (agrupa (list 4 1 5 7 8) 3)
               (list (list 4 1 5) (list 7 8))))

(define (agrupa lst n)
  (cond
    [(empty? lst) empty]
    [(< (length lst) n) (list lst)]
    [else
     (cons (take lst n)
           (agrupa (drop lst n) n))]))