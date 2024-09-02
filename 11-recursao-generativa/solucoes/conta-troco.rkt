#lang racket

(require examples)

;; Natural Lista(Natural) -> Natural
;;
;; Devolve a quantidade de formas diferentes de
;; obter valor somando valores de moedas.

(examples
 (check-equal? (conta-troco 1 empty) 0)
 (check-equal? (conta-troco 0 (list 1 2)) 1)
 (check-equal? (conta-troco 3 (list 4)) 0)
 (check-equal? (conta-troco 4 (list 1 2)) 3)
 ; 1+1+1+1, 1+1+2, 2+2
 (check-equal? (conta-troco 6 (list 2 3)) 2)
 ; 2+2+2, 3+3
 (check-equal? (conta-troco 10 (list 2 3 4)) 5))
 ; 2+2+2+2+2, 2+2+2+4, 2+2+3+3, 2+4+4, 3+3+4

(define (conta-troco valor moedas)
  (cond
    [(empty? moedas)
     0]
    [(zero? valor)
     1]
    [(< valor (first moedas))
     (conta-troco valor (rest moedas))]
    [else
     (+ (conta-troco (- valor (first moedas)) moedas)
        (conta-troco valor (rest moedas)))]))
