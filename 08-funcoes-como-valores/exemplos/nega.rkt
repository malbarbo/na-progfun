#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defina uma função que recebe como parâmetro um predicado (função que retorna
;; booleano) e retorne uma função que retorna a negação do predicado.

;; (X -> Boolean) -> (X -> Boolean)
;; Devolve uma função que é semelhante a pred?, mas que devolve a negação do
;; resultado de pred?.
(examples
 (check-equal? ((nega positive?) 3) #f)
 (check-equal? ((nega positive?) -3) #t)
 (check-equal? ((nega even?) 4) #f)
 (check-equal? ((nega even?) 3) #t))

;; Veja a função pré-definida negate.
(define (nega pred?)
  (λ (x) (not (pred? x))))
