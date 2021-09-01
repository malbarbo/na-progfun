#lang racket

(require examples)

;;;;;
;; Definição de tipos

;; Renda é um número positivo com duas casas decimais.
;; Imposto é um número positivo com duas casas decimais.

;; Número Número -> Número
;;
;; Devolve o maior valor entre a e b. Se os valores forem iguais, devolve a.
;; Veja a função pré-definida max.
(examples
 (check-equal? (maximo 2 3) 3)
 (check-equal? (maximo 5 3) 5)
 (check-equal? (maximo 4 4) 4))

(define (maximo a b)
  (if (>= a b) a b))


;; Número Número -> Número
;;
;; Calcula a soma dos quadrados dos dois maiores números entre a, b, e c.
(examples
 (check-equal? (soma-quadrado-maiores 3 4 5) 41)  ; 16 + 25
 (check-equal? (soma-quadrado-maiores 3 6 5) 61)  ; 36 + 25
 (check-equal? (soma-quadrado-maiores 6 5 4) 61)  ; 36 + 25
 (check-equal? (soma-quadrado-maiores 4 6 2) 52)  ; 16 + 36
 (check-equal? (soma-quadrado-maiores 6 2 4) 52)  ; 36 + 16
 (check-equal? (soma-quadrado-maiores 5 1 2) 29)) ; 25 + 4

(define (soma-quadrado-maiores a b c)
  (if (> a b)
      (+ (sqr a)
         (sqr (maximo b c)))
      (+ (sqr b)
         (sqr (maximo a c)))))

;; Renda -> Imposto
;;
;; Calcula o imposto que uma pessoa com a renda r deve pagar. O percentual do imposto é
;; determinado da seguinte forma
;; - Se r <= 100, 5% de 5
;; - Se 1000 < r <= 5000, 5% de 1000 e 10% do que passar de 1000
;; - Se 5000 < r, 5% de 1000, 10% de 4000 e 20% do que passar de 5000
(examples
 ; Até 1000 (inclusive)
 (check-equal? (calcula-imposto 900.0) 45.0) ; (* 900 0.05)
 (check-equal? (calcula-imposto 1000.0) 50.0) ; (* 1000 0.05)
 ; Entre 1000 e 5000 (inclusive)
 (check-equal? (calcula-imposto 3000.0) 250.0) ; (+ 50 (* (- 3000 1000) 0.1))
 (check-equal? (calcula-imposto 5000.0) 450.0) ; (+ 50 (* (- 5000 1000) 0.1))
 ; Mais do que 5000
 (check-equal? (calcula-imposto 10000.0) 1450.0)) ; (+ 450 (* (- 10000 5000) 0.2))

(define (calcula-imposto r)
  (cond [(<= r 1000) (* r 0.05)]
        [(<= r 5000) (+ 50 (* (- r 1000) 0.1))]
        [else (+ 450 (* (- r 5000) 0.2))]))
