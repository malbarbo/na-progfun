#lang racket

(require examples)

;; ListaAninhada -> ListAninhada
;;
;; Devolve uma lista aninhada com a mesma estrutura de *lst*
;; mas com os elementos de trás para frente
(examples
 (check-equal? (reverse* (list (list 2 3) 8 (list 9 (list 10 11) 50) (list 10) 70))
               (list 70 (list 10) (list 50 (list 11 10) 9) 8 (list 3 2))))
(define (reverse* lst)
  (cond
    [(empty? lst) empty]
    [(list? (first lst))
     (append (reverse* (rest lst))
             (list (reverse* (first lst))))]
    [else
     (append (reverse* (rest lst))
             (list (first lst)))]))
