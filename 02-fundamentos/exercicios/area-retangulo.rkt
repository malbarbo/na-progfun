#lang racket

;; O código desse arquivo utiliza o processo de projeto de funções que
;; veremos nas próximas aulas. Os exercícios pediam apenas a implementação das
;; funções e a execução manual dos exemplos.
;;
;; Para executar os exemplos é necessário instalar a biblioteca examples.
;; Para isso, selecione o menu File -> Install Package e cole a url
;; https://github.com/malbarbo/racket-test-examples

(require examples)

;; Número Número -> Número
;;
;; Calcula a área de um retângulo com dimensões largura x altura.
(examples
  (check-equal? (area-retangulo 3 5) 15)
  (check-equal? (area-retangulo 2.0 2.5) 5.0))

(define (area-retangulo largura altura)
  (* largura altura))
