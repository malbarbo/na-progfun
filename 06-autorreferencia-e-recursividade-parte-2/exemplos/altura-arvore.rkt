#lang racket

(require examples)

(struct no (valor esq dir) #:transparent)
;; Uma ÁrvoreBináriaDeNúmeros é um dos valores:
;;   - empty; ou
;;   - (no Número ÁrvoreBináriaDeNúmeros ÁrvoreBináriaDeNúmeros)

;; Estas árvores são usadas nos testes a seguir
;;
;;     t4  3
;;        / \
;;       /   \
;;  t3  4     7  t2
;;     /     / \
;;    3     8   9  t1
;;             /
;;        t0  10

(define t0 (no 10 empty empty))
(define t1 (no 9 t0 empty))
(define t2 (no 7 (no 8 empty empty) t1))
(define t3 (no 4 (no 3 empty empty) empty))
(define t4 (no 3 t3 t2))

;; ÁrvoreBináriaDeNúmeros -> Natural
;;
;; Devolve a altura da árvore binária. A altura de uma árvore binária é a
;; distância da raiz a seu descendente mais afastado. Uma árvore com um único
;; nó tem altura 0. Uma árvore vazia tem altura -1.

(examples
 (check-equal? (altura empty) -1)
 (check-equal? (altura t0) 0)
 (check-equal? (altura t1) 1)
 (check-equal? (altura t2) 2)
 (check-equal? (altura t3) 1)
 (check-equal? (altura t4) 3))

(define (altura t)
  (cond
    [(empty? t) -1]
    [else
     (add1 (max (altura (no-esq t))
                (altura (no-dir t))))]))
