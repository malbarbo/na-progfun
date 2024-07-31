#lang racket

(require examples)

;; ListaAninhada -> ListaDeNúmeros
;;
;; Devolve uma versão não aninhada de lst, isto é, uma lista com os mesmos
;; elementos de lst, mas sem aninhamento.

(examples
 (check-equal? (aplaina empty) empty)
 (check-equal? (aplaina (list (list 4 5) 1 2))
               (list 4 5 1 2))
 (check-equal? (aplaina (list 1 3 (list 4 5)))
               (list 1 3 4 5))
 (check-equal? (aplaina (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               (list 1 3 4 5 4 6 7)))

(define (aplaina lst)
  (cond
    [(empty? lst) empty]
    [(list? (first lst))
     (append (aplaina (first lst))
             (aplaina (rest lst)))]
    [(empty? lst) empty]
    [else
     (cons (first lst)
           (aplaina (rest lst)))]))
