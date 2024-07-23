#lang racket

(require examples)

;; ListaDeNúmeros -> ListaDeNúmeros
;;
;; Cria uma lista com os elementos de lst
;; em ordem não decrescente usando o
;; algoritmo de ordenação por inserção.

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
  (cond
    [(empty? lst) empty]
    [else
      (insere-ordenado (first lst) (ordena (rest lst)))]))


;; Número ListaDeNúmeros -> ListaDeNúmeros
;;
;; Devolve uma nova lista como os mesmo elementos
;; de lst junto com n em ordem não decrescente.
;;
;; Requer que lst esteja em ordem não decrescente.

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
    [(empty? lst)
     (cons n empty)]
    [(< n (first lst))
     (cons n lst)]
    [else
     (cons (first lst)
           (insere-ordenado n (rest lst)))]))
