#lang racket

(require examples)

;; Número Número -> Número
;;
;; Calcula a área de um retângulo com dimensões largura e altura.

(examples
  (check-equal? (area-retangulo 3 5) 15)
  (check-equal? (area-retangulo 2.0 2.5) 5.0))

(define (area-retangulo largura altura)
  (* largura altura))


;; Inteiro -> Inteiro
;;
;; Calcula o produto de n, (+ n 1) e (- n 1).

(examples
  (check-equal? (produto-anterior-posterior 3) 24)
  (check-equal? (produto-anterior-posterior 1) 0)
  (check-equal? (produto-anterior-posterior -2) -6))

(define (produto-anterior-posterior n)
  (* n (+ n 1) (- n 1))) ; ou (* n (add1 n) (sub1 n))


;; Número Número -> Número
;;
;; 
