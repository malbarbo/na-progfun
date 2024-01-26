#lang racket

(require examples)

;; (A -> A) -> (A -> A)
;; Devolve um função que aplica f ao argumento e f a esse resultado.
(examples
  (check-equal? ((duas-vezes add1) 3) 5)
  (check-equal? (((duas-vezes (duas-vezes duas-vezes)) add1) 5) 21))
(define (duas-vezes f)
  (lambda (x) (f (f x))))
