#lang racket

(require examples)

;; Lista(Número) -> Lista(Número)
;; Ordena lst em ordem não decrescente usando o algoritmo de ordenação por seleção
(examples
 (check-equal? (ordena-selecao empty) empty)
 (check-equal? (ordena-selecao (list 5)) (list 5))
 (check-equal? (ordena-selecao (list 5 2)) (list 2 5))
 (check-equal? (ordena-selecao (list 1 5 2)) (list 1 2 5))
 (check-equal? (ordena-selecao (list 7 1 5 2)) (list 1 2 5 7))
 (check-equal? (ordena-selecao (list 1 7 1 2 5 2 7 1 2)) (list 1 1 1 2 2 2 5 7 7)))
(define (ordena-selecao lst)
  (cond
    [(empty? lst) lst]
    [else
     (define m (apply min lst))
     (define mins (filter (curry = m) lst))
     (define outros (filter (negate (curry = m)) lst))
     (append mins (ordena-selecao outros))]))
