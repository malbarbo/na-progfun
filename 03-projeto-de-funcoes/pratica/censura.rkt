#lang racket

;; O código desse arquivo utiliza o processo de projeto de funções que
;; veremos nas próximas aulas. Os exercícios pediam apenas a implementação das
;; funções e a execução manual dos exemplos.
;;
;; Para executar os exemplos é necessário instalar a biblioteca examples.
;; Para isso, selecione o menu File -> Install Package e cole a url
;; https://github.com/malbarbo/racket-test-examples

(require examples)

;; String Natural -> String
;;
;; Produz uma nova string substituindo cada um dos primeiros n caracteres de
;; frase por "x".
;;
;; Pergunta: o que acontece se n for maior do que a quantidade de caracteres
;; de frase? Altere a função para que ela tenha um comportamento mais
;; adequado nesse caso e envie a sua solução para professor explicando o
;; comportamento esperado. O primeiro aluno a enviar uma soluç̃ão adequada
;; ganha 0,1 na nota da prova.
(examples
  (check-equal? (censura "droga de lanche!" 5) "xxxxx de lanche!")
  (check-equal? (censura "ferrou geral!" 6) "xxxxxx geral!"))

(define (censura frase n)
  (string-append (make-string n #\x)
                 (substring frase n)))
