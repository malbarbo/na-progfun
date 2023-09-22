#lang racket

(require examples)

;; Lista(String) -> Lista(String)
;;
;; Cria uma lista com os elementos de lst que têm tamanho máximo entre
;; todos os elementos de lst.

(examples
  (check-equal? (maiores (list "oi" "casa" "aba" "boi" "eita" "a" "cadê"))
                (list "casa" "eita" "cadê")))

(define (maiores lst)
  (define maximo (tamanho-maximo lst))
  (define (tamanho=maximo? s)
    (= (string-length s) maximo))
  (filter tamanho=maximo? lst))


;; Lista(String) -> Número
;;
;; Devolve o tamanho máximo entre todas as strings de lst.

(examples
  (check-equal? (tamanho-maximo (list "oi" "casa" "aba" "boi" "eita" "a" "cadê"))
                4))

(define (tamanho-maximo lst)
  (foldr max 0 (map string-length lst)))
