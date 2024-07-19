#lang racket

(require examples)

;; ListaDeStrings -> Natural
;;
;; Devolve o tamanho máximo entre todas as strings de lst.
;;
;; Requer que lst seja não vazia.

(examples
  (check-equal? (tamanho-maximo (cons "da" empty)) 2)
  (check-equal? (tamanho-maximo (cons "casa" (cons "da" empty))) 4)
  (check-equal? (tamanho-maximo (cons "tal" (cons "casa" (cons "da" empty)))) 4)
  (check-equal? (tamanho-maximo (cons "outra" (cons "tal" (cons "casa" (cons "da" empty))))) 5))

(define (tamanho-maximo lst)
  (cond
    [(empty? (rest lst))
     (string-length (first lst))]
    [else
      (max (string-length (first lst))
           (tamanho-maximo (rest lst)))]))
