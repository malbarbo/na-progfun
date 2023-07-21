#lang racket

(require examples)

;; InteiroPositivo -> Boolean
;;
;; Produz #t se uma pessoa com idade id é isento da
;; tarifa de transporte público, isto é, tem menos
;; que 18 anos ou 65 ou mais. Produz #f caso contrário.

(examples
 (check-equal? (insento-tarifa? 17) #t)
 (check-equal? (insento-tarifa? 18) #t)
 (check-equal? (insento-tarifa? 50) #f)
 (check-equal? (insento-tarifa? 65) #t)
 (check-equal? (insento-tarifa? 70) #t))

(define (insento-tarifa? id)
  #f)


;; Inteiro -> Inteiro
;;
;; Conta a quantidade de dígitos de n.
;; Se n é 0, então devolve zero.
;; Se n é menor que zero, então devolve a quantidade
;; de dígitos do valor absoluto de n

(examples
 (check-equal? (quantidade-digitos 121) 3)
 (check-equal? (quantidade-digitos 0) 1)
 (check-equal? (quantidade-digitos -1519) 4))

(define (quantidade-digitos n)
  0)


(define (qualifica num-questoes num-acertos faltas)
  (define aproveitamento (/ num-acertos num-questoes))
  (cond
    [(or (< aproveitamento 0.3) (> faltas 0.25)) "reprovado"]
    [(< aproveitamento 0.6) "nova-tentativa"]
    [else "aprovado"]))