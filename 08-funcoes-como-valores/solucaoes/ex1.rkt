#lang racket

(require examples)

; As funções que podem parar antes de analisar todos os elementos da lista
; não são adequadas de serem implementadas com map, filter e foldr. Entre os
; exercícios temos o de verificar se todos são verdadeiros, se algum é
; verdadeiro e se a lista está em ordem não decrescente.
;
; A função para encontrar o último pode ser implementada com foldr, mas
; fica confusa. Com o foldl, que ainda vamos ver, fica bom.
;
; As demais funções podem ser implementadas com foldr, map e filter e ficam
; mais simples.

;; Lista(String) -> String
;; Concatena todos os elementos de lst.
(examples
  (check-equal? (concatena empty)
                "")
  (check-equal? (concatena (list "casa" " " "da " "sogra"))
                "casa da sogra"))
(define (concatena lst)
  (foldr string-append "" lst))


;; Lista(Número) -> Número
;; Calcula o produto dos elementos de lst
(examples
  (check-equal? (produto empty) 1)
  (check-equal? (produto (list 5 1 -4)) -20))
(define (produto lst)
  (foldr * 1 lst))


;; Lista(Número) -> Natural
;; Devolve a quantidade de elementos em lst.
(examples
  (check-equal? (quantidade-elementos empty) 0)
  (check-equal? (quantidade-elementos (list 6 1 8)) 3))
(define (quantidade-elementos lst)
  ; a função para foldr precisa de dois argumentos
  ; o elemento e o resultado parcial, só
  ; precisamos do resultado parcial.
  (foldr (lambda (_ tam) (add1 tam)) 0 lst))


;; Lista(String) -> Lista(Número)
;; Devolve lista com cada elemento de lst convertido para um Número.
;; Requer que cada elemento de lst represente um número válido
(examples
  (check-equal? (strings->numbers (list "10" "-1.2" "7.8"))
                (list 10 -1.2 7.8)))
(define (strings->numbers lst)
  (map string->number lst))


;; Lista(String) -> Lista(String)
;; Devolve uma lista que é como lst mas apenas com os elementos
;; que começam com "A".
(examples
  (check-equal? (seleciona-comeca-A (list "Apenas" "um" "teste" "," "viu" "Ana"))
                (list "Apenas" "Ana")))
(define (seleciona-comeca-A lst)
  (filter (lambda (s)
            (and (non-empty-string? s)
                 (equal? (substring s 0 1) "A")))
          lst))


;; Lista(Número) -> Número
;; Calcula a amplitude dos valores de lst, isto é,
;; a diferença entre o valor máximo e mínimo de lst.
;; Requer que lst não seja vazia
(examples
  (check-equal? (amplitude (list 10)) 0)
  (check-equal? (amplitude (list 2 -5 10 8 12 -1)) 17))
(define (amplitude lst)
  (define maximo (foldr max (first lst) (rest lst)))
  (define minimo (foldr min (first lst) (rest lst)))
  (- maximo minimo))
