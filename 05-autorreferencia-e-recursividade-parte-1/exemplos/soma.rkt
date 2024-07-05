#lang racket

(require examples)

(struct vazia () #:transparent)
(struct link (primeiro resto) #:transparent)

;; Uma ListaDeNúmeros é um dos valores:
;; - (vazia)
;; - (link Número ListaDeNúmeros)

;; Modelo
#;
(define (fn-para-lst lst)
  (cond
    [(vazia? lst) ...]
    [(link? lst)
     (... (link-primeiro lst)
          (fn-para-lst (link-resto lst)))]))


;; ListaDeNúmeros -> Número
;;
;; Soma os valores de lst.

(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))

(define (soma lst)
  (cond
    [(vazia? lst) 0]
    [else
     (+ (link-primeiro lst)
        (soma (link-resto lst)))]))
