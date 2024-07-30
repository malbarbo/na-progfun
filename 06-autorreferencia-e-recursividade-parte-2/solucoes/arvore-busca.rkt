#lang racket

(require examples)

(struct no (valor esq dir) #:transparent)
;; Uma ÁrvoreBináriaDeNúmeros é um dos valores:
;;   - empty; ou
;;   - (no Número ÁrvoreBináriaDeNúmeros ÁrvoreBináriaDeNúmeros)


;; Estas árvores são usadas nos testes a seguir
;;
;;     t4  4
;;        / \
;;       /   \
;;  t3  3     8  t2
;;     /     / \
;;    1     7   10  t1
;;             /
;;        t0  9

(define t0 (no 9 empty empty))
(define t1 (no 10 t0 empty))
(define t2 (no 8 (no 7 empty empty) t1))
(define t3 (no 3 (no 1 empty empty) empty))
(define t4 (no 4 t3 t2))

;; ÁrvoreBináriaDeNúmeros -> Bool
;;
;; Produz #t se valor está em r, #f caso contrário.
;; Requer que r seja uma árvore binária de busca, isto é:
;; 1) A subárvore a esquerda contém valores nos nós menores que o valor no nó raiz.
;; 2) A subárvore a direita contém valores nos nós maiores que o valor no nó raiz.
;; 3) As subárvores a esquerda e a direita também são árvores binárias de busca.
(examples
 (check-equal? (contem empty 3) #f)
 (check-equal? (contem t4 4) #t)
 (check-equal? (contem t4 3) #t)
 (check-equal? (contem t4 8) #t)
 (check-equal? (contem t4 10) #t)
 (check-equal? (contem t4 6) #f)
 (check-equal? (contem t4 2) #f))

(define (contem r valor)
  (cond
    [(empty? r) #f]
    [(= valor (no-valor r)) #t]
    [(> valor (no-valor r)) (contem (no-dir r) valor)]
    [(< valor (no-valor r)) (contem (no-esq r) valor)]))
