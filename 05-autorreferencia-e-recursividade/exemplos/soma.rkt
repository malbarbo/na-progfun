#lang racket

(require examples)

(struct vazia () #:transparent)
(struct link (primeiro resto) #:transparent)

;; Uma ListaDeNúmeros é um dos valores:
;; - (vazia)
;; - (link Número ListaDeNúmeros)

#;(define ldn0 (vazia))
#;(define ldn1 (link 10 (vazia)))
#;(define ldn2 (link 5 (link 4 (vazia))))
#;(define ldn3 (link 20 ldn1))

#;
(define (fn-para-ldn ldn)
  (cond
    [(vazia? ldn) ...]
    [(link? ldn)
     (... (link-primeiro ldn)
          (fn-para-ldn (link-resto ldn)))]))

;; ListaDeNúmeros -> Número
;; Soma os valores de ldn.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))

(define (soma ldn)
  (cond
    [(vazia? ldn) 0]
    [else
     (+ (link-primeiro ldn)
        (soma (link-resto ldn)))]))