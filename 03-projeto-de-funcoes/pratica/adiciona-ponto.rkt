#lang racket

;; O código desse arquivo utiliza o processo de projeto de funções que
;; veremos nas próximas aulas. Os exercícios pediam apenas a implementação das
;; funções e a execução manual dos exemplos.
;;
;; Para executar os testes é necessário instalar a biblioteca examples.
;; Para isso, selecione o menu File -> Install Package e cole a url
;; https://github.com/malbarbo/racket-test-examples

(require examples)

;; String -> String
;;
;; Adiciona um ponto final (".") em frase se ela ainda não terminar com um.
(examples
  (check-equal? (adiciona-ponto "Vou contar") "Vou contar.")
  (check-equal? (adiciona-ponto "Corri") "Corri."))

(define (adiciona-ponto frase)
  (if (equal? (substring frase (sub1 (string-length frase)))
              ".")
      frase
      (string-append frase ".")))
