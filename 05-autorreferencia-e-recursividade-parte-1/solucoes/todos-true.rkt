#lang racket

(require examples)

;; ListaDeBool -> Bool
;;
;; Produz #t se todos elementos de lst são #t, produz #f caso contrário.
;; Produz #t se a lst é vazia.

(examples
  (check-equal? (todos-true empty) #t)
  (check-equal? (todos-true (cons #f empty)) #f)
  (check-equal? (todos-true (cons #t empty)) #t)
  (check-equal? (todos-true (cons #t (cons #f empty))) #f)
  (check-equal? (todos-true (cons #t (cons #t empty))) #t)
  (check-equal? (todos-true (cons #t (cons #t (cons #t empty)))) #t))

(define (todos-true lst)
  (cond
    [(empty? lst) #t]
    [else
      ; Simplificado
      ; (and (first lst) (todos-true (rest lst)))
      (if (first lst)
        (todos-true (rest lst))
        #f)]))
