#lang racket

(require examples)

;; Maioria é um dos valores:
;; - "Positivo"
;; - "Negativo"
;; - "Nenhum"

;; ListaDeNúmeros -> Maioria
;;
;; Determina se em lst existem mais números negativos ou positivos.

(examples
  (check-equal? (maioria empty) "Nenhum")
  (check-equal? (maioria (cons 0 empty)) "Nenhum")
  (check-equal? (maioria (cons 10 empty)) "Positivo")
  (check-equal? (maioria (cons -2 empty)) "Negativo")
  (check-equal? (maioria (cons 2 (cons 10 empty))) "Positivo")
  (check-equal? (maioria (cons -1 (cons 10 empty))) "Nenhum")
  (check-equal? (maioria (cons -1 (cons -2 empty))) "Negativo")
  (check-equal? (maioria (cons 10 (cons -2 empty))) "Nenhum"))

(define (maioria lst)
  (define (num-positivos lst)
    (cond
      [(empty? lst) 0]
      [else (if (positive? (first lst))
              (+ 1 (num-positivos (rest lst)))
              (num-positivos (rest lst)))]))
  (define (num-negativos lst)
    (cond
      [(empty? lst) 0]
      [else (if (negative? (first lst))
              (+ 1 (num-negativos (rest lst)))
              (num-negativos (rest lst)))]))
  (define npositivos (num-positivos lst))
  (define nnegativos (num-negativos lst))
  (cond
    [(= npositivos nnegativos) "Nenhum"]
    [(> npositivos nnegativos) "Positivo"]
    [else "Negativo"]))
