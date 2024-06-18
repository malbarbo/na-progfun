#lang racket

(require examples)

;; String -> String
;;
;; Adiciona um ponto final (".") em frase se ela ainda não terminar com um.
(examples
  (check-equal? (adiciona-ponto "Vou contar") "Vou contar.")
  (check-equal? (adiciona-ponto "Corri.") "Corri.")
  (check-equal? (adiciona-ponto "") "."))

(define (adiciona-ponto frase)
  (define tam (string-length frase))
  (if (and (> tam 0)
           (equal? "." (substring frase (sub1 tam))))
      frase
      (string-append frase ".")))
