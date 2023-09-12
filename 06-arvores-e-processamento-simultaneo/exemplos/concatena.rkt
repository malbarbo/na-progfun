#lang racket

(require examples)

;; ListaDeNúmero ListaDeNúmeros -> ListaDeNúmeros
;;
;; Produz uma nova lista com os elementos de lsta seguidos
;; dos elementos de lstb.

(examples
  (check-equal? (concatena empty (list 10 4 6))
                (list 10 4 6))
  (check-equal? (concatena (cons 3 empty) (list 10 4 6))
                (cons 3 (list 10 4 6)))
  (check-equal? (concatena (cons 7 (cons 3 empty)) (list 10 4 6))
                (cons 7 (cons 3 (list 10 4 6)))))

(define (concatena lsta lstb)
  (cond
    [(empty? lsta) lstb]
    [else
      (cons (first lsta)
            (concatena (rest lsta) lstb))]))
