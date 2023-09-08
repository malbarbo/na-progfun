#lang racket

(require examples)

;; ListaDeNúmeros ListaDeNúmeros -> ListaDeNúmeros
;; Faz a intercalação dos elementos de lsta e lstb.
;; Requer a lsta e lstb estejam em ordem não decrescente.
;;
;;                              lstb
;;                   +------------+--------------------------------------------+
;;                   |   empty    |                 (cons ...)                 |
;;      +------------+------------+--------------------------------------------+
;;      |   empty    |                          lstb                           |
;; lsta +------------+------------+--------------------------------------------+
;;      | (cons ...) |    lsta    | cons menor entre (first lsta) (first lstb) |
;;      |            |            |              recursão natural              |
;;      +------------+------------+--------------------------------------------+
;;
;; Observe que ao invés de juntar as celúlas na linha lsta empty, poderíamos
;; juntar as células da coluna lstb empty.
(examples
 (check-equal? (merge empty empty)
               empty)
 (check-equal? (merge (list 1 2 3) empty)
               (list 1 2 3))
 (check-equal? (merge empty (list 1 2 3))
               (list 1 2 3))
 (check-equal? (merge (list 4 10 20) (list 1 2 6 8))
               (list 1 2 4 6 8 10 20))
 (check-equal? (merge (list 1 2 6 8) (list 4 10 20))
               (list 1 2 4 6 8 10 20)))

(define (merge lsta lstb)
  (cond
    [(empty? lsta) lstb]
    [(empty? lstb) lsta]
    [(< (first lsta) (first lstb))
     (cons (first lsta)
           (merge (rest lsta) lstb))]
    [else
     (cons (first lstb)
           (merge lsta (rest lstb)))]))
