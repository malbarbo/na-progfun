#lang racket

;; O código desse arquivo utiliza o processo de projeto de funções que
;; veremos nas próximas aulas. Os exercícios pediam apenas a implementação das
;; funções e a execução manual dos exemplos.
;;
;; Para executar os testes é necessário instalar a biblioteca examples.
;; Para isso, selecione o menu File -> Install Package e cole a url
;; https://github.com/malbarbo/racket-test-examples

(require examples)

;; String -> Booleano
;;
;; Produz #t se s tem um número ímpar de caracteres e o caracter do meio é "-",
;; #f caso contrário.
(examples
  (check-equal? (traco-meio? "lero-lero") #t)
  (check-equal? (traco-meio? "quase-meio") #f)
  (check-equal? (traco-meio? "-") #t))

(define (traco-meio? s)
  (define tam (string-length s))
  (define meio (quotient tam 2))
  (and (= (remainder tam 2) 1) ; veja a função pré-definida odd?
       (equal? (substring s meio (add1 meio)) "-")))
