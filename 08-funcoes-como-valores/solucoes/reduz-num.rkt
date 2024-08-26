#lang racket

(require examples)

;; As novas funções ficaram mais simples?
;; As funções soma-nat e lista-num ficaram mais simples.
;; Já as funções repete e potencia não ficaram mais simples,
;; talvez porque a função f esteja ignorando o primeiro argumento.

;; (Natural Y -> Y) Y Natural -> Y
;; A chamada
;; (reduz-num f base n) produz
;; (f n (f (sub1 n) ... (f 1 base)))
(examples
 ; exemplo soma-nat
 (check-equal? (reduz-num + 0 4) 10)
 ; exemplo lista-num
 (check-equal? (reduz-num cons-end empty 4)
               (list 1 2 3 4)))
(define (reduz-num f base n)
  (cond
    [(zero? n) base]
    [else (f n (reduz-num f base (sub1 n)))]))

(define (cons-end e lst)
  (append lst (list e)))


;; Número Natural -> List(Número)
;; Cria uma lista com n valores v.
(examples
 (check-equal? (repete 0 3) empty)
 (check-equal? (repete 3 10) (list 10 10 10)))
(define (repete n v)
  (reduz-num (λ (_ lst) (cons v lst))
             empty
             n))


;; Número Natural -> Número
;; Calcula o valor de a elevado a n (a^n).
;; Requer que a seja diferente de zero.
(examples
 (check-equal? (potencia 10.0 0) 1.0)
 (check-equal? (potencia 2.0 1) 2.0)
 (check-equal? (potencia 2.0 2) 4.0)
 (check-equal? (potencia 2.0 3) 8.0))
(define (potencia a n)
  (reduz-num (λ (_ e) (* a e))
             1.0
             n))
