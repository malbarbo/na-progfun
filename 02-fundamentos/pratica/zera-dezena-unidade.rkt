#lang racket

;; O código desse arquivo utiliza o processo de projeto de funções que
;; veremos nas próximas aulas. Os exercícios pediam apenas a implementação das
;; funções e a execução manual dos exemplos.
;;
;; Para executar os exemplos é necessário instalar a biblioteca examples.
;; Para isso, selecione o menu File -> Install Package e cole a url
;; https://github.com/malbarbo/racket-test-examples

(require examples)

;; Natural -> Natural
;;
;; Produz um número substituindo a unidade e dezena de n por 0.
(examples
  (check-equal? (zera-dezena-unidade 19) 0)
  (check-equal? (zera-dezena-unidade 341) 300)
  (check-equal? (zera-dezena-unidade 5251) 5200))

(define (zera-dezena-unidade n)
  ; ou (- n (remainder n 100))
  (* 100 (quotient n 100)))
