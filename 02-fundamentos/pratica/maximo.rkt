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
;; Devolve o valor máximo entre a e b.
(examples
  (check-equal? (maximo 3 5) 5)
  (check-equal? (maximo 8 4) 8)
  (check-equal? (maximo 6 6) 6))

(define (maximo a b)
  (if (>= a b) a b)) ; veja a função pré-definida max


;; Número Número Número -> Número
;;
;; Devolve o valor máximo entre a, b e c.
(examples
  (check-equal? (maximo3 8 5 2) 8)
  (check-equal? (maximo3 4 6 1) 6)
  (check-equal? (maximo3 6 6 7) 7))

(define (maximo3 a b c)
  ; Você consegue escrever uma versão que usa o operador >= apenas duas vezes?
  ; Se sim, seja o primeiro a enviar para o professor e ganhe 0,1 na nota da prova!
  ; ou (maximo (maximo a b) c)
  (if (>= a b)
      (if (>= a c) a c)
      (if (>= b c) b c)))
