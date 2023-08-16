#lang racket

(require examples)

;; Inteiro -> Inteiro
;;
;; Conta a quantidade de dígitos de n.
;; Se n é 0, então devolve um.
;; Se n é menor que zero, então devolve a quantidade
;; de dígitos do valor absoluto de n

(examples
 (check-equal? (quantidade-digitos 121) 3)
 (check-equal? (quantidade-digitos 0) 1)
 (check-equal? (quantidade-digitos -1519) 4))

(define (quantidade-digitos n)
  (string-length (number->string (abs n))))
