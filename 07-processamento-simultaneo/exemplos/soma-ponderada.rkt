#lang racket

(require examples)

;; ListaDeNúmeros ListaDeNúmeros -> Número
;;
;; Calcula a soma ponderada dos valores de lst cosiderando que cada
;; elemento de lst tem como peso o elemento correspondente em pesos.
;;
;; Requer que lst e pesos tenham o mesmo tamanho

(examples
  (check-equal? (soma-ponderada empty empty) 0)
  (check-equal? (soma-ponderada (list 4) (list 2)) 8); (+ 0 (* 4 2))
  (check-equal? (soma-ponderada (list 3 4) (list 5 2)) 23); (+ (* 3 5) (* 4 2))
  (check-equal? (soma-ponderada (list 5 3 4) (list 1 5 2)) 28)); (+ (* 5 1) (* 3 5) (* 4 2))

(define (soma-ponderada lst pesos)
  (cond
    [(empty? lst) 0]
    [else
      (+ (* (first lst) (first pesos))
         (soma-ponderada (rest lst) (rest pesos)))]))
