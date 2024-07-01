#lang racket

(require examples)

;; TipoUsuario é um dos valores:
;; - "aluno"
;; - "servidor<=3" - servidor que recebe até 3 salários mínimos
;; - "servidor>3" - servidor que recebe acima de 3 salários mínimos
;; - "docente"
;; - "externo"

;; TipoUsuario InteiroPositivo -> NúmeroPositivo
;; Determina o custo de *quant* tíquetes para um usuário do tipo *tp*.
;; O custo de um tíquete é
;; - "aluno"        5,0
;; - "servidor<=3"  5,0
;; - "servidor>3"  10,0
;; - "docente"     10,0
;; - "externo"     19,0

(examples
  (check-equal? (custo-tiquetes "aluno"       3) 15.0)
  (check-equal? (custo-tiquetes "servidor<=3" 4) 20.0)
  (check-equal? (custo-tiquetes "servidor>3"  5) 50.0)
  (check-equal? (custo-tiquetes "docente"     2) 20.0)
  (check-equal? (custo-tiquetes "externo"     2) 38.0))
(define (custo-tiquetes tu quant)
  (cond
    [(or (equal? tu "aluno")
         (equal? tu "servidor<=3"))
      (* quant 5.0)]
    [(or (equal? tu "servidor>3")
         (equal? tu "docente"))
      (* quant 10.0)]
    [(equal? tu "externo")
     (* quant 19.0)]))
