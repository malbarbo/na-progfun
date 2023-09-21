#lang racket

(require examples)

;; Sinal é um dos valores 1, 0, -1

;; Lista(Número) -> Lista(Sinal)
;;
;; Produz uma lista com o sinal de cada elemento de lst.
(examples
  (check-equal? (sinais (list 10 0 2 -4 -1 0 8))
                (list 1 0 1 -1 -1 0 1)))

(define (sinais lst)
  (define (sinal n)
    (cond
      [(> n 0) 1]
      [(= n 0) 0]
      [(< n 0) -1]))
  (map sinal lst))
