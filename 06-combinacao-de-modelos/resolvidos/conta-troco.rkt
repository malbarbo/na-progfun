#lang racket

(require examples)

;; ListaDeNúmeros Natural -> Natural
;; Devolve a quantidade de formas diferentes que se pode dar troco de um valor
;; a partir de uma lista de valores de moedas

;;                        moedas
;;             +-------+--------------------+
;;             | empty |     (cons ...)     |
;;       +-----+-------+--------------------+
;;       |  0  |             1              |
;;       +-----+----------------------------+
;; valor | < 0 |             0              |
;;       +-----+----------------------------+
;;       | > 0 | erro  | soma das recursões |
;;       +-----+-------+--------------------+

(examples
 (check-equal? (conta-troco 4 (list 1 2)) 3)
 ;; 1+1+1+1, 1+1+2, 2+2
 (check-equal? (conta-troco 6 (list 2 3)) 2)
 ;; 2+2+2, 3+3
 (check-equal? (conta-troco 10 (list 2 3 4)) 5))
 ;; 2+2+2+2+2, 2+2+2+4, 2+2+3+3, 2+4+4, 3+3+4

(define (conta-troco valor moedas)
  (cond
    [(zero? valor) 1]
    [(negative? valor) 0]
    [(empty? moedas) 0]
    [else
     (+ (conta-troco (- valor (first moedas)) moedas)
        (conta-troco valor (rest moedas)))]))
