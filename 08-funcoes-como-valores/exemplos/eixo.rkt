#lang racket

(require examples)

(struct ponto (x y) #:transparent)
;; Ponto representa um ponto no plano cartesiano
;;   x : Número - a coordenada x
;;   y : Número - a coordenada y


;; Lista(Ponto) -> Lista(Ponto)
;;
;; Indica quais elementos de pontos estão sobre o
;; eixo x (coordenada y 0) ou eixo y (coordenado x 0).

(examples
  (check-equal? (seleciona-no-eixo
                  (list (ponto 3 0) (ponto 1 3) (ponto 2 0)
                        (ponto 0 2) (ponto 0 0) (ponto 4 7)))
                (list (ponto 3 0) (ponto 2 0) (ponto 0 2) (ponto 0 0))))

(define (seleciona-no-eixo pontos)
  ;; Ponto -> Bool
  ;; Devolve #t se p está sobre o eixo x ou y.
  ;; #f caso contrário.
  (define (no-eixo? p)
    (or (zero? (ponto-x p)) (zero? (ponto-y p))))
  (filter no-eixo? pontos))
