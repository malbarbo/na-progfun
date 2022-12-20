#lang racket

(require examples)

;;;;;;;
;; Tipos de dados

;; Salario é um número positivo com duas casas decimais.


;;;;;;;
;; Funções

;; Salario -> Salario

;; Calcula o novo salário a partir de um percetual de aumento determinado a partir de salario-atual
;; da seguinte forma:
;; - salario-atual <= 1200, percentual de aumento de 10%
;; - 1200 < salario-atual <= 3000, percentual de aumento de 7%
;; - 3000 < salario-atual <= 8000, percentual de aumento de 3%
;; - 8000 < salario-atual, sem aumento

(examples
 ; salario-atual <= 1200
 (check-equal? (novo-salario 1000.00) 1100.00) ; (* 1000.00 1.10)
 (check-equal? (novo-salario 1200.00) 1320.00)
 ; salario-atual <= 3000
 (check-equal? (novo-salario 2000.00) 2140.00) ; (* 2000.00 1.07)
 (check-equal? (novo-salario 3000.00) 3210.00)
 ; salario-atual <= 8000
 (check-equal? (novo-salario 5000.00) 5150.00) ; (* 5000.00 1.03)
 (check-equal? (novo-salario 8000.00) 8240.00)
 ; salario-atual > 8000
 (check-equal? (novo-salario 8000.01) 8000.01)); 8000.00

(define (novo-salario salario-atual)
  (cond
    [(<= salario-atual 1200) (* salario-atual 1.10)] ; 10% de aumento
    [(<= salario-atual 3000) (* salario-atual 1.07)] ; 7% de aumento
    [(<= salario-atual 8000) (* salario-atual 1.03)] ; 3% de aumento
    [else salario-atual]))                           ; sem aumento
