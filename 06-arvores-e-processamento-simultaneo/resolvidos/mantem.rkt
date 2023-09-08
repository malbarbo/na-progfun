#lang racket

(require examples)

;; ListaDeNúmeros Natural -> Lista
;; Devolve uma lista com os n primeiros elementos de lst.
;; Veja a função pré-definida take.
;;
;;                              n
;;                  +-----------+--------------------+
;;                  |     0     |     (add1 ...)     |
;;     +------------------------+--------------------+
;;     |   empty    |           |        erro        |
;; lst +------------+   empty   +--------------------+
;;     | (cons ...) |           | cons (first lst) + |
;;     |            |           |  recursão natural  |
;;     +------------+-----------+--------------------+

(examples
 (check-equal? (mantem empty 0) empty)
 (check-equal? (mantem (list 1 2 3) 0) empty)
 (check-exn exn:fail? (thunk (mantem empty 1)))
 (check-equal? (mantem (list 4 2 3) 1) (list 4))
 (check-equal? (mantem (list 4 2 5) 3) (list 4 2 5))
 (check-exn exn:fail? (thunk (mantem (list 4 2 5) 4))))

(define (mantem lst n)
  (cond
    [(zero? n) empty]
    [(empty? lst) (error "Lista vazia")]
    [else (cons (first lst)
                (mantem (rest lst) (sub1 n)))]))
