#lang racket

(require examples)

;; ListaDeStrings -> ListaDeNúmero
;;
;; Cria uma nova lista com cada elemento de lst convertido para um número.
;; A conversão é feita com a função string->number.
;;
;; Requer que cada elemento de lst represente um número válido.

(examples
  (check-equal? (strings->numeros empty) empty)
  (check-equal? (strings->numeros (cons "10" empty))
                (cons 10 empty))
  (check-equal? (strings->numeros (cons "-1.2" (cons "10" empty)))
                (cons -1.2 (cons 10 empty)))
  (check-equal? (strings->numeros (cons "81" (cons "-1.2" (cons "10" empty))))
                (cons 81 (cons -1.2 (cons 10 empty)))))

(define (strings->numeros lst)
  (cond
    [(empty? lst)
     empty]
    [else
     (cons (string->number (first lst))
           (strings->numeros (rest lst)))]))
