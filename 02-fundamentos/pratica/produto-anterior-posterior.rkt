#lang racket

;; O código desse arquivo utiliza o processo de projeto de funções que
;; veremos nas próximas aulas. Os exercícios pediam apenas a implementação das
;; funções e a execução manual dos exemplos.
;;
;; Para executar os exemplos é necessário instalar a biblioteca examples.
;; Para isso, selecione o menu File -> Install Package e cole a url
;; https://github.com/malbarbo/racket-test-examples

(require examples)

;; Inteiro -> Inteiro
;;
;; Calcula o produto de n, (+ n 1) e (- n 1).
(examples
  (check-equal? (produto-anterior-posterior 3) 24)
  (check-equal? (produto-anterior-posterior 1) 0)
  (check-equal? (produto-anterior-posterior -2) -6))

(define (produto-anterior-posterior n)
  ; ou (* n (add1 n) (sub1 n))
  (* n (+ n 1) (- n 1)))
