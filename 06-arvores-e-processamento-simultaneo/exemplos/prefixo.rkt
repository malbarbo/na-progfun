#lang racket

(require examples)

;; ListaDeNúmeros ListaDeNúmeros -> Boolean
;; Devolve #t se lsta é prefixo de lstb. #f caso contrário.
;;
;; É interessante deixar a tabela no código
;;
;;                              lstb
;;                   +-------------------------------+
;;                   |   empty    | (cons ...)       |
;;      +------------+-------------------------------+
;;      |   empty    |           #t                  |
;; lsta +------------+------------+------------------+
;;      | (cons ...) |      #f    | primeiros iguais |
;;      |            |            | recursão natural |
;;      +------------+------------+------------------+
(examples
 (check-equal? (prefixo? empty empty) #t)
 (check-equal? (prefixo? empty (list 3 4)) #t)
 (check-equal? (prefixo? (list 3 4) empty) #f)
 (check-equal? (prefixo? (list 3 4) (list 3 4)) #t)
 (check-equal? (prefixo? (list 3 4) (list 3 5)) #f)
 (check-equal? (prefixo? (list 3 4) (list 3 4 6 8)) #t)
 (check-equal? (prefixo? (list 3 5) (list 3 4 6 8)) #f)
 (check-equal? (prefixo? (list 3 4 5) (list 3 4)) #f))

(define (prefixo? lsta lstb)
  (cond
    [(empty? lsta) #t]
    [(empty? lstb) #f]
    [else
     (and (equal? (first lsta)
                  (first lstb))
          (prefixo? (rest lsta) (rest lstb)))]))


