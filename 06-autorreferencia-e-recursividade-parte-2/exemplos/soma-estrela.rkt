#lang racket

(require examples)

;; Um ListaAninhada é um dos valores:
;; - empty
;; - (cons ListaAninhada ListaAninhada)
;; - (cons Número ListaAninhada)


;; ListaAninhada -> Número
;;
;; Devolve a soma de todos os elementos de lst.

(examples
 (check-equal? (soma* empty)
               0)
 (check-equal? (soma* (list (list 4 5) 1 2))
               12)
 (check-equal? (soma* (list 1 3 (list 4 5)))
               13)
 (check-equal? (soma* (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               30))

(define (soma* lst)
  (cond
    [(empty? lst) 0]
    [(list? (first lst))
     (+ (soma* (first lst))
        (soma* (rest lst)))]
    [else
     (+ (first lst)
        (soma* (rest lst)))]))
