#lang racket

(require examples)

;;;;;
;; Definição de tipos

;; Número Número -> Número
;;
;; Devolve o maior valor entre a e b. Se os valores forem iguais, devolve a.
;; Veja a função pré-definida max.
(examples
 ; (>= a b)
 (check-equal? (maximo 5 3) 5)
 (check-equal? (maximo 4 4) 4)
 ; (< a b)
 (check-equal? (maximo 2 3) 3))

(define (maximo a b)
  (if (>= a b) a b))


;; Número Número -> Número
;;
;; Calcula a soma dos quadrados dos dois maiores números entre a, b, e c.
(examples
 ; (>= a b)
 (check-equal? (soma-quadrado-maiores 6 5 4) 61)  ; (+ (sqr 6) (sqr (maximo 5 4)))
 (check-equal? (soma-quadrado-maiores 6 2 4) 52)
 (check-equal? (soma-quadrado-maiores 5 1 2) 29)
 ; (< a b)
 (check-equal? (soma-quadrado-maiores 3 4 5) 41)  ; (+ (sqr 4) (sqr (maximo 3 5)))
 (check-equal? (soma-quadrado-maiores 3 6 5) 61)
 (check-equal? (soma-quadrado-maiores 4 6 2) 52))

(define (soma-quadrado-maiores a b c)
  (if (>= a b)
      (+ (sqr a)
         (sqr (maximo b c)))
      (+ (sqr b)
         (sqr (maximo a c)))))
