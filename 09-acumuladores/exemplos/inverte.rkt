#lang racket

(require examples)

;; Lista -> Lista
;; Inverte a ordem dos elmentos de lst.
(examples
 (check-equal? (inverte empty) empty)
 (check-equal? (inverte (list 2)) (list 2))
 (check-equal? (inverte (list 2 8 9)) (list 9 8 2)))

;; Definição sem uso de acumulador
#;
(define (inverte lst)
  (cond
    [(empty? lst) empty]
    [else (append (inverte (rest lst))
                  (list (first lst)))]))

;; Definição com o uso de acumulador
(define (inverte lst0)
  ;; acc - os elementos já visitados de lst0 em ordem inversa.
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst)
                  (cons (first lst) acc))]))
  (iter lst0 empty))
