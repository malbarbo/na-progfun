#lang racket

(require examples)

;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Devolve uma nova lista como os mesmo elementos de lst e o n em ordem não
;; decrescente. Esta função supõe que lst está ordenada.
(examples
 (check-equal? (insere-ordenado 2 empty)
               (list 2))
 (check-equal? (insere-ordenado 1 (list 2))
               (list 1 2))
 (check-equal? (insere-ordenado 3 (list 2))
               (list 2 3))
 (check-equal? (insere-ordenado 1 (list 2 6 9))
               (list 1 2 6 9))
 (check-equal? (insere-ordenado 4 (list 2 6 9))
               (list 2 4 6 9))
 (check-equal? (insere-ordenado 7 (list 2 6 9))
               (list 2 6 7 9))
 (check-equal? (insere-ordenado 10 (list 2 6 9))
               (list 2 6 9 10)))

(define (insere-ordenado n lst)
  (cond
    [(empty? lst) (list n)]
    [(< n (first lst)) (cons n lst)]
    [else (cons (first lst)
                (insere-ordenado n (rest lst)))]))


;; ListaDeNúmeros -> ListaDeNúmeros
;; Devolve uma nova lista com os mesmos elemento de lst em ordem não
;; decrescente.
(examples
 (check-equal? (ordena empty)
               empty)
 (check-equal? (ordena (list 2))
               (list 2))
 (check-equal? (ordena (list 3 2))
               (list 2 3))
 (check-equal? (ordena (list 5 -2 3))
               (list -2 3 5))
 (check-equal? (ordena (list 1 9 5 -2 8 3))
               (list -2 1 3 5 8 9)))

(define (ordena lst)
  (foldr insere-ordenado empty lst))
