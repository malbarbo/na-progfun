#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Listas aninhadas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Um ListaAninhadaDeNúmeros é um dos valores:
;; - empty
;; - (cons ListaAninhadaDeNúmeros ListaAninhadaDeNúmeros)
;; - (cons Número ListaAninhadaDeNúmeros)

;; Modelo
#;
(define (fn-para-ladn lst)
  (cond
    [(empty? lst) ...]
    [(list? (first lst))
     (... (fn-para-ladn (first lst))
          (fn-para-ladn (rest lst)))]
    [else
     (... (first lst)
          (fn-para-ladn (rest lst)))]))


;; ListaAninhadaDeNúmeros -> Número
;;
;; Devolve a soma de todos os elementos de lst.

(examples
 (check-equal? (soma* empty)
               0)
 (check-equal? (soma* (list (list 4 5) 1 2))
               12)
 (check-equal? (soma* (list 1 3 (list 4 5)))
               13)
 (check-equal? (soma* (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               30))

(define (soma* lst)
  (cond
    [(empty? lst) 0]
    [(list? (first lst))
     (+ (soma* (first lst))
        (soma* (rest lst)))]
    [else
     (+ (first lst)
        (soma* (rest lst)))]))
