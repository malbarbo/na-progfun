#lang racket

(require examples)

; O objetivo desse exercício é mostrar que as vezes é
; difícil determinar a partir do código qual é o
; propósito da função. Por isso precisamos da espeficação!

;; String -> InteiroPositivo
;;
;; Calcula um número decimal equivalente ao número binário representado por s.
;; s é uma string de "a"s e "b"s onde "a" corresponde a 0 e "b" corresponde a 1.
(examples
  (check-equal? (ab->number "a") 0)
  (check-equal? (ab->number "b") 1)
  (check-equal? (ab->number "ba") 2)
  (check-equal? (ab->number "bb") 3)
  (check-equal? (ab->number "bab") 5))

(define (ab->number s)
  (string->number
   (string-replace (string-replace s "a" "0" ) "b" "1")
   2))
