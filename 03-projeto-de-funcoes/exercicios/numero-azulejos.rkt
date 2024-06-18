#lang racket

(require examples)

; Análise
;
; Calcular o número de azulejos necessários para azulejar uma parede com
; determinado comprimento e altura, considerando que cada azulejo mede
; 0,2m x 0,2m e que nenhum azulejo é perdido e que recortes são descartados

; Tipos de dados
;
; A largura e a altura são dados em metros e representadas com números positivos


;; Número Número -> Natural
;;
;; Calcula o número de azulejos de 0,2mx0,2m necessários para azulejar uma
;; pare de tamanho comprimento x altura (em metros) considerando que
;; nenhum azulejo é perdido e que recortes são descartados.
(examples
  ; sem recortes
  ; 10 (/ 2.0 0.2) x 12 (/ 2.4 0.2)
  (check-equal? (numero-azulejos 2.0 2.4) 120)
  ; com recortes
  ; 8 (ceiling (/ 1.5 0.2)) x 12 (ceiling (/ 2.3 0.2))
  (check-equal? (numero-azulejos 1.5 2.3) 96)

  ; Situações particulares
  (check-equal? (numero-azulejos 0.2 0.2) 1)
  (check-equal? (numero-azulejos 0.3 0.2) 2)
  (check-equal? (numero-azulejos 0.3 0.3) 4)
  (check-equal? (numero-azulejos 0.4 0.4) 4))
(define (numero-azulejos comprimento altura)
  (inexact->exact (* (ceiling (/ comprimento 0.2))
                     (ceiling (/ altura 0.2)))))
