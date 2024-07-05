#lang racket

(require examples)

;; ListaDeNúmeros Natural -> Qualquer
;;
;; Devolve o elemento na posição k da lista.
;; O primeiro elemento está na posição 0.
;;
;;                               k
;;                  +------------+-------------------+
;;                  |      0     | (add1 ...)        |
;;     +------------+------------+-------------------+
;;     |   empty    |              erro              |
;; lst +------------+------------+-------------------+
;;     | (cons ...) |(first lst) |  recursão natural |
;;     +------------+------------+-------------------+

(examples
 (check-exn exn:fail? (thunk (lista-ref empty 0)))
 (check-exn exn:fail? (thunk (lista-ref empty 2)))
 (check-equal? (lista-ref (list 3 2 8) 0) 3)
 (check-equal? (lista-ref (list 3 2 8 10) 2) 8)
 (check-exn exn:fail? (thunk (lista-ref (list 3 2 8 10) 4))))

(define (lista-ref lst k)
  (cond
    [(empty? lst) (error "Lista vazia")]
    [(zero? k) (first lst)]
    [else (lista-ref (rest lst) (sub1 k))]))
