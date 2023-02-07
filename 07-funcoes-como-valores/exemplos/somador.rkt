#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defina uma função que recebe um parâmetro n e devolva uma função que soma o
;; seu parâmetro a n.

;; Número -> (Número -> Número)
;; Devolve uma função que recebe um parâmetro x e faz a soma de n e x.
(examples
 (check-equal? ((somador 4) 3) 7)
 (check-equal? ((somador -2) 8) 6))

#;
(define (somador n)
  (define (soma x)
    (+ n x))
  soma)

;; Versão com função anônima.
(define (somador n)
  (λ (x)(+ n x)))
