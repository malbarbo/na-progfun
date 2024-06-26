#lang racket

(require examples)

;;;;;;;
;; Tipos de dados

;; Comprimento é um número positivo dado em metros.

;; Massa é um número positivo dado em quilogramas.

;;;;;;;
;; Constantes

(define PI 3.14)
(define DENSIDADE-FERRO 7874) ; Em kg/m^2

;;;;;;;
;; Funções

;; Comprimento Comprimento Comprimento -> Massa

;; Calcula a massa de um tubo de ferro a partir da suas dimensões
;; Requer que (> diametro-externo diametro-interno)
(examples
 (check-= (massa-tubo-ferro 0.05 0.03 0.1) 0.9889744 0.00000001))

(define (massa-tubo-ferro diametro-externo diametro-interno altura)
  (define area-externa (* PI (sqr (/ diametro-externo 2))))
  (define area-interna (* PI (sqr (/ diametro-interno 2))))
  (define volume (* (- area-externa area-interna) altura))
  (* volume DENSIDADE-FERRO))
