#lang racket

(require examples)

;; ListaDeNúmeros -> Número
;; Devolve o valor máximo de lst. Se a lista for vazia, gera um erro.
(examples
 (check-exn exn:fail? (thunk (maximo empty)))
 (check-equal? (maximo (list 4)) 4)
 (check-equal? (maximo (list 2 4 8 3)) 8)
 (check-equal? (maximo (list 8 4 8 3)) 8))

(define (maximo lst)
  (cond
    [(empty? lst) (error "Lista vazia")]
    [(empty? (rest lst)) (first lst)]
    [(max2 (first lst)
           (maximo (rest lst)))]))


;; Número Número -> Número
;; Devolve a se a >= b. Devolve b caso contrário.
;; Veja a função pré-definida max.
(examples
  (check-equal? (max2 40 50) 50)
  (check-equal? (max2 20 10) 20)
  (check-equal? (max2 3 3) 3))

(define (max2 a b)
  (if (>= a b) a b))
