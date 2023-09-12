#lang racket

(require examples)

;; ListaDeNúmeros -> ListaDeNúmeros
;;
;; Produz uma nova lista removendo os valores negativos de ldn.

(examples
 (check-equal? (remove-negativos empty) empty)
 (check-equal? (remove-negativos (cons -1 (cons 2 (cons -3 empty))))
               (cons 2 empty))
 (check-equal? (remove-negativos (cons 3 (cons 4 (cons -2 empty))))
               (cons 3 (cons 4 empty))))

(define (remove-negativos ldn)
  (cond
    [(empty? ldn) empty]
    [else
     (if (< (first ldn) 0)
         (remove-negativos (rest ldn))
         (cons (first ldn)
               (remove-negativos (rest ldn))))]))
