#lang racket

(require examples)

;; Número -> Número
;; Produz o dobro de n.
(examples
 (check-equal? (dobro 0) 0)
 (check-equal? (dobro 4) 8)
 (check-equal? (dobro -2) -4))

(define (dobro n)
  (* 2 n))


;; Natural -> Boolean
;; Devolve #t se n é par, #f caso contrário.
;; Veja as funções pré-definidas even? e odd?
(examples
 (check-equal? (par? 2) #t)
 (check-equal? (par? 8) #t)
 (check-equal? (par? 9) #f))

(define (par? n)
  (= (remainder n 2) 0))


;; String String -> String
;; Devolve a maior palavra entre a e b. Se a e b tem o mesmo tamanho,
;; devolve a.
(examples
 (check-equal? (maior-palavra "sorte" "casa") "sorte")
 (check-equal? (maior-palavra "racket" "palavra") "palavra")
 (check-equal? (maior-palavra "racket" "coisas") "racket"))

(define (maior-palavra a b)
  (if (>= (string-length a)
          (string-length b))
      a
      b))

; Cada cidadão de um país, cuja moeda chama dinheiro,
; tem que pagar imposto sobre a sua renda.
; Cidadãos que recebem até 1000 dinheiros pagam 5% de
; imposto. Cidadãos que recebem entre 1000 e 5000
; dinheiros pagam 5% de imposto sobre 1000 dinheiros e
; 10% sobre o que passar de 1000. Cidadãos que recebem
; mais do 5000 dinheiros pagam 5% de imposto sobre 1000
; dinheiros, 10% de imposto sobre 4000 dinheiros e 20%
; sobre o que passar de 5000. Projete uma função que
; calcule o imposto que um cidadão deve pagar dado a
; sua renda.

;; Número -> Número
;; Calcula o imposto que um pessoa com a renda r deve
;; pagar.
(examples
 ; Até 1000 (inclusive)
 (check-equal? (calcula-imposto 900.0) 45.0) ; (* 900 0.05)
 (check-equal? (calcula-imposto 1000.0) 50.0) ; (* 1000 0.05)
 ; Entre 1000 e 5000 (inclusive)
 (check-equal? (calcula-imposto 3000.0) 250.0) ; (+ 50 (* (- 3000 1000) 0.1))
 (check-equal? (calcula-imposto 5000.0) 450.0) ; (+ 50 (* (- 5000 1000) 0.1))
 ; Mais do que 5000
 (check-equal? (calcula-imposto 10000.0) 1450.0)) ; (+ 450 (* (- 10000 5000) 0.2))

; (define (calcula-imposto r) 0) ; esboço

(define (calcula-imposto r)
  (cond [(<= r 1000) (* r 0.05)]
        [(<= r 5000) (+ 50 (* (- r 1000) 0.1))]
        [else (+ 450 (* (- r 5000) 0.2))]))
