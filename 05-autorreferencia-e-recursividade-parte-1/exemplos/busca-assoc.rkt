#lang racket

(require examples)

(struct par (chave valor) #:transparent)
;; Representa uma associação entre chave e valor.
;; chave: String
;; quant: Natural

;; String Lista(par) -> Natural
;; Devolve o valor quant associado com *s* em *lst*.
;; Se *s* não aparece como chave em *lst*, devolve 0.
(examples
 (check-equal? (busca "casa" empty)
               0)
 (check-equal? (busca "casa" (list (par "nada" 3) (par "outra" 2)))
               0)
 (check-equal? (busca "nada" (list (par "nada" 3) (par "outra" 2)))
               3)
 (check-equal? (busca "outra" (list (par "nada" 3) (par "outra" 2)))
               2))
(define (busca s lst)
  (cond
    [(empty? lst)
     0]
    [else
     (if (equal? s (par-chave (first lst)))
         (par-valor (first lst))
         (busca s (rest lst)))]))
