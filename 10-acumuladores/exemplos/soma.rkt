#lang racket

(require examples)

;; Lista -> Natural
;; Devolve a quantidade de elementos de lst.
(examples
 (check-equal? (tamanho empty)
               0)
 (check-equal? (tamanho (list 4))
               1)
 (check-equal? (tamanho (list 4 7))
               2)
 (check-equal? (tamanho (list 4 8 -4))
               3))

;; Definição sem uso de acumulador
#;
(define (tamanho lst)
  (cond
    [(empty? lst) 0]
    [else (add1 (tamanho (rest lst)))]))

;; Definição com o uso de acumlador
(define (tamanho lst0)
  ;; acc - a quantidade de elementos já vistos de lst0
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst) (add1 acc))]))
  (iter lst0 0))
