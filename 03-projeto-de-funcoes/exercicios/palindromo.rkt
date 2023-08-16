#lang racket

(require examples)

; Análise
;
; Determinar se um inteiro positivo de 4 dígitos é palíndromo.
;
; Quando estudarmos autorreferências vamos ver como
; determinar se um inteiro positivo qualquer é palíndromo.

;; InteiroPositivo -> Booleano
;;
;; Produz #t se n tem 4 dígitos e é palindromo, isto é,
;; tem os mesmos dígitos quando lido da direita para a
;; esquerda ou da esquerda para a direita. Produz #f
;; caso contrário.

(examples
 (check-equal? (palindromo? 11) #f)
 (check-equal? (palindromo? 222) #f)
 (check-equal? (palindromo? 9119) #t)
 (check-equal? (palindromo? 1221) #t)
 (check-equal? (palindromo? 21112) #f))

(define (palindromo? n)
  ; A operação (quotient n 1) não é necessária, mas
  ; foi coloca para ilustrar como o processo é
  ; generalizado para cada dígito.
  (define unidade (remainder (quotient n 1) 10))
  (define dezena (remainder (quotient n 10) 10))
  (define centena (remainder (quotient n 100) 10))
  (define milhar (remainder (quotient n 1000) 10))
  (and (= unidade milhar)
       (= dezena centena)))
