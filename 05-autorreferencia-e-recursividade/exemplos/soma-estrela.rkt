#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Listas aninhadas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Um ListaAninhadaDeNúmeros é um dos valores:
;; - empty
;; - (cons ListaAninhadaDeNúmeros ListaAninhadaDeNúmeros)
;; - (cons Número ListaAninhadaDeNúmeros)
;; Exemplos
#;
(define ladn1 (cons 3 (cons (cons 2 (cons 4 empty)) (cons 2 empty)))) ; (list 3 (list (list 2 4) (list 2)))
;; Modelo
#;
(define (fn-para-ladn ldn)
  (cond
    [(empty? ldn) ...]
    [(list? (first ldn))
     (... (fn-para-ladn (first ldn))
          (fn-para-ladn (rest ldn)))]
    [else
     (... (first ldn)
          (fn-para-ladn (rest ldn)))]))


;; ListaAninhadaDeNúmeros -> Número
;; Devolve a soma de todos os elementos de ldn.
(examples
 (check-equal? (soma* empty)
               0)
 (check-equal? (soma* (list (list 4 5) 1 2))
               12)
 (check-equal? (soma* (list 1 3 (list 4 5)))
               13)
 (check-equal? (soma* (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               30))
(define (soma* ldn)
  (cond
    [(empty? ldn) 0]
    [(list? (first ldn))
     (+ (soma* (first ldn))
        (soma* (rest ldn)))]
    [else
     (+ (first ldn)
        (soma* (rest ldn)))]))
