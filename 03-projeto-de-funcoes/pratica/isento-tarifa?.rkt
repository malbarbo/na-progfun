#lang racket

(require examples)

;; InteiroPositivo -> Boolean
;;
;; Produz #t se uma pessoa com idade id é isento da
;; tarifa de transporte público, isto é, tem menos
;; que 18 anos ou 65 ou mais. Produz #f caso contrário.

(examples
 (check-equal? (isento-tarifa? 17) #t)
 (check-equal? (isento-tarifa? 18) #f)
 (check-equal? (isento-tarifa? 50) #f)
 (check-equal? (isento-tarifa? 65) #t)
 (check-equal? (isento-tarifa? 70) #t))

(define (isento-tarifa? id)
  (or (< id 18) (>= id 65)))
