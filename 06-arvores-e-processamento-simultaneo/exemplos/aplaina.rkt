#lang racket

(require examples)

;; ListaAninhadaDeNúmeros -> ListaDeNúmeros
;; Devolve uma versão não aninhada de ldn, isto é, uma lista com os mesmos
;; elementos de ldn, mas sem aninhamento.
(examples
 (check-equal? (aplaina empty) empty)
 (check-equal? (aplaina (list (list 4 5) 1 2))
               (list 4 5 1 2))
 (check-equal? (aplaina (list 1 3 (list 4 5)))
               (list 1 3 4 5))
 (check-equal? (aplaina (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               (list 1 3 4 5 4 6 7)))
(define (aplaina ldn)
  (cond
    [(empty? ldn) empty]
    [(list? (first ldn))
     (append (aplaina (first ldn))
             (aplaina (rest ldn)))]
    [(empty? ldn) empty]
    [else
     (cons (first ldn)
           (aplaina (rest ldn)))]))