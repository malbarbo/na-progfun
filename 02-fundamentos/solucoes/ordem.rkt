#lang racket

;; O código desse arquivo utiliza o processo de projeto de funções que
;; veremos nas próximas aulas. Os exercícios pediam apenas a implementação das
;; funções e a execução manual dos exemplos.
;;
;; Para executar os testes é necessário instalar a biblioteca examples.
;; Para isso, selecione o menu File -> Install Package e cole a url
;; https://github.com/malbarbo/racket-test-examples

(require examples)

;; Número Número Número -> String
;;
;; Determina se a sequência a, b, c está em ordem "crescente",
;; "decrescente" ou "sem ordem".
(examples
  (check-equal? (ordem 3 8 12) "crescente")
  (check-equal? (ordem 3 1 4) "sem ordem")
  (check-equal? (ordem 3 1 0) "decrescente"))

(define (ordem a b c)
  (cond
    [(< a b c) "crescente"]
    [(< c b a) "decrescente"]
    [else "sem ordem"]))
