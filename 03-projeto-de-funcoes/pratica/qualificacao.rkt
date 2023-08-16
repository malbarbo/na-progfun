#lang racket

(require examples)

; O objetivo desse exercício é mostrar que as vezes é
; difícil determinar a partir do código qual é o
; propósito da função. Por isso precisamos da espeficação!
;
; Segue uma *tentativa* de especificação.

;; Qualificacao é um dos valores
;; - "reprovado"
;; - "nota-tentativa"
;; - "aprovado"

;; InteiroPositivo InteiroPositivo RealPositivo -> Qualificacao
;;
;; Determina o resultado da qualificacao em uma prova de acordo
;; com o seguinte
;;
;; "reprovado"
;;    percentual de faltas maior que 25% ou
;;    o percentual de acertos for menor que 30%
;;
;; "nova-tentativa"
;;    percentual de faltas menor ou igual a 25% e
;;    aproveitamento maior ou igual que 30% e menor que 60%
;;
;; "aprovado"
;;    percentual de faltas menor ou igual a 25% e
;;    aproveitamento maior ou igual que 60%
;;
;; faltas representa a porcentagem de faltas no curso
;; e deve ser um valor entre 0 e 1 (inclusive).


(examples
  (check-equal? (qualificacao 10 2 0.1) "reprovado")
  (check-equal? (qualificacao 10 4 0.26) "reprovado")
  (check-equal? (qualificacao 10 5 0.26) "reprovado")
  (check-equal? (qualificacao 10 6 0.26) "reprovado")
  (check-equal? (qualificacao 10 4 0.25) "nova-tentativa")
  (check-equal? (qualificacao 10 5 0.20) "nova-tentativa")
  (check-equal? (qualificacao 10 6 0.1) "aprovado"))

(define (qualificacao num-questoes num-acertos faltas)
  (define aproveitamento (/ num-acertos num-questoes))
  (cond
    [(or (< aproveitamento 0.3) (> faltas 0.25)) "reprovado"]
    [(< aproveitamento 0.6) "nova-tentativa"]
    [else "aprovado"]))
