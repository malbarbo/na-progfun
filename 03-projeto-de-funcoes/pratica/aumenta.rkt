#lang racket

(require examples)

;; Número Número -> Número
;;
;; Calcula um novo valor aumentando a porcentagem ao valor dado.
(examples
  (check-equal? (aumenta 100.0 3.0) 103.0)
  (check-equal? (aumenta 20.0 50.0) 30.0)
  (check-equal? (aumenta 10.0 80.0) 18.0))

(define (aumenta valor porcentagem)
  (* valor (+ 1 (/ porcentagem 100))))
