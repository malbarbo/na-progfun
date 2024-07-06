#lang racket

(require examples)

;; ListaDeNúmeros -> Bool
;;
;; Produz #t se os elementos de lst estão em ordem não decrescente,
;; produz #f caso contrário.

(examples
  (check-equal? (ordenado? empty) #t)
  (check-equal? (ordenado? (cons 4 empty)) #t)
  (check-equal? (ordenado? (cons 3 (cons 4 empty))) #t)
  (check-equal? (ordenado? (cons 5 (cons 4 empty))) #f)
  (check-equal? (ordenado? (cons 3 (cons 3 (cons 4 empty)))) #t)
  (check-equal? (ordenado? (cons 3 (cons 5 (cons 4 empty)))) #f))

(define (ordenado? lst)
  (cond
    [(empty? lst) #t]
    [(empty? (rest lst)) #t]
    [else
      (and (<= (first lst) (second lst))
           (ordenado? (rest lst)))]))

