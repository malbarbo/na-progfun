#lang racket

(require examples)

;; (A -> A) -> (A -> A)
;; Devolve um função que aplica f ao argumento e f a esse resultado.
(examples
  (check-equal? ((duas-vezes add1) 3) 5)
  (check-equal? ((duas-vezes (curry * 2)) 5) 20)
  (check-equal? (((duas-vezes (duas-vezes duas-vezes)) add1) 5) 21))
(define (duas-vezes f)
  (λ (x) (f (f x))))
