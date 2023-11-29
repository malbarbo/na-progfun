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
;; Calcula um novo valor aumentando a porcentagem ao valor dado.
(examples
  (check-equal? (aumenta 100.0 3.0) 103.0)
  (check-equal? (aumenta 20.0 50.0) 30.0)
  (check-equal? (aumenta 10.0 80.0) 18.0))

(define (aumenta valor porcentagem)
  (* valor (+ 1 (/ porcentagem 100))))
