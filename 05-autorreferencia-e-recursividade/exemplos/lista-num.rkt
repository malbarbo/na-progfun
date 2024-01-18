#lang racket

(require examples)

;; Natural -> Lista
;;
;; Cria uma lista com os valores 1 2 ... n-1 n.

(examples
 (check-equal? (lista-num 0) empty)
 (check-equal? (lista-num 1) (cons 1 empty))
 (check-equal? (lista-num 2) (cons 1 (cons 2 empty))))

(define (lista-num n)
  (cond
    [(zero? n) empty]
    [else
     (cons-fim n
               (lista-num (sub1 n)))]))


;; Número ListaDeNúmeros -> ListaDeNúmeros
;;
;; Adiciona n ao final de lst.

(examples
 (check-equal? (cons-fim 3 empty)
               (cons 3 empty))
 (check-equal? (cons-fim 1 (cons 3 (cons 4 empty)))
               (cons 3 (cons 4 (cons 1 empty)))))

(define (cons-fim n lst)
  (cond
    [(empty? lst) (cons n empty)]
    [else
     (cons (first lst)
           (cons-fim n (rest lst)))]))
