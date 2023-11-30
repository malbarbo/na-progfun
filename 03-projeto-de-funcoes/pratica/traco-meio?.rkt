#lang racket

(require examples)

;; String -> Booleano
;;
;; Produz #t se s tem um número ímpar de caracteres e o caracter do meio é "-",
;; #f caso contrário.
(examples
  (check-equal? (traco-meio? "lero-lero") #t)
  (check-equal? (traco-meio? "quase-meio") #f)
  (check-equal? (traco-meio? "-") #t))

(define (traco-meio? s)
  (define tam (string-length s))
  (define meio (quotient tam 2))
  (and (odd? tam)
       (equal? (substring s meio (add1 meio)) "-")))
