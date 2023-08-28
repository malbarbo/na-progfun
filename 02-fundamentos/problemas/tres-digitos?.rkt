#lang racket

;; O código desse arquivo utiliza o processo de projeto de funções que
;; veremos nas próximas aulas. Os exercícios pediam apenas a implementação das
;; funções e a execução manual dos exemplos.
;;
;; Para executar os testes é necessário instalar a biblioteca examples.
;; Para isso, selecione o menu File -> Install Package e cole a url
;; https://github.com/malbarbo/racket-test-examples

(require examples)

;; Natural -> Booleano
;;
;; Produz #t se n tem três digitos, #f caso contrário.
(examples
  (check-equal? (tres-digitos? 99) #f)
  (check-equal? (tres-digitos? 100) #t)
  (check-equal? (tres-digitos? 999) #t)
  (check-equal? (tres-digitos? 1000) #f))

(define (tres-digitos? n)
  (<= 100 n 999))
