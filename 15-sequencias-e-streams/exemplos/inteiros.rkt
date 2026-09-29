#lang racket

(require examples)

;; Inteiro -> Stream(Inteiro)
;; Cria um stream com os inteiros a partir de n.
(examples
 (check-equal? (stream-ref (inteiros 5) 0) 5)
 (check-equal? (stream-ref (inteiros 5) 1) 6)
 (check-equal? (stream-ref (inteiros 5) 2) 7)
 (check-equal? (stream-ref (inteiros 5) 3) 8))

(define (inteiros n)
  (stream-cons n (inteiros (add1 n))))
