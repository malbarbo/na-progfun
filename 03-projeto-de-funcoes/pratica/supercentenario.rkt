#lang racket

(require examples)

;; InteiroPositivo -> Boolean
;;
;; Produz #t se uma pessoa com a idade n é supercentenária,
;; isto é, tem 110 anos ou mais, #f caso contrário.

(examples
 (check-equal? (supercentenario 101) #f)
 (check-equal? (supercentenario 110) #t)
 (check-equal? (supercentenario 112) #t))

(define (supercentenario n)
  (>= n 110))
