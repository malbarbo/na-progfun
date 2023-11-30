#lang racket

(require examples)

;; Número Número Número -> Número
;;
;; Devolve o valor máximo entre a, b e c.
(examples
  (check-equal? (maximo3 8 5 2) 8)
  (check-equal? (maximo3 4 6 1) 6)
  (check-equal? (maximo3 6 6 7) 7))

(define (maximo3 a b c)
  (if (>= a b)
      (if (>= a c) a c)
      (if (>= b c) b c)))
