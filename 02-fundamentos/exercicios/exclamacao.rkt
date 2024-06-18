#lang racket

;; O código desse arquivo utiliza o processo de projeto de funções que
;; veremos nas próximas aulas. Os exercícios pediam apenas a implementação das
;; funções e a execução manual dos exemplos.
;;
;; Para executar os exemplos é necessário instalar a biblioteca examples.
;; Para isso, selecione o menu File -> Install Package e cole a url
;; https://github.com/malbarbo/racket-test-examples

(require examples)

;; String Número -> String
;;
;; Devolve um string adicionando n pontos de exclamação (!) ao final de frase.
(examples
  (check-equal? (exclamacao "Nossa" 3) "Nossa!!!")
  (check-equal? (exclamacao "Que legal" 1) "Que legal!")
  (check-equal? (exclamacao "Nada" 0) "Nada"))

(define (exclamacao frase n)
  (string-append frase (make-string n #\!)))
