#lang racket

(require examples)

;; ListaDeNúmeros -> ListaDeNúmeros
;; Devolva uma lista com os mesmos elementos de lst mas em ordem reversa.
;; Obs: Esta implementação não é eficiente... Nos módulos seguintes veremos
;; porque e como escrever uma versão mais eficiente.
;; Veja a função pré-definida reverse.
(examples
 (check-equal? (inverte empty) empty)
 (check-equal? (inverte (list 2)) (list 2))
 (check-equal? (inverte (list 2 8 9)) (list 9 8 2)))

(define (inverte lst)
  (cond
    [(empty? lst) empty]
    [else (cons-fim (first lst)
                    (inverte (rest lst)))]))


;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Adiciona n ao final de ldn.
(examples
 (check-equal? (cons-fim 3 empty) (cons 3 empty))
 (check-equal? (cons-fim 1 (cons 3 (cons 4 empty))) (cons 3 (cons 4 (cons 1 empty)))))
(define (cons-fim n ldn)
  (cond
    [(empty? ldn) (cons n empty)]
    [else
     (cons (first ldn)
           (cons-fim n (rest ldn)))]))


;; ListaDeNúmeros -> Boolean
;; Devolve #t se lst é palíndromo, isto é, lst é igual a lst invertida.
;; Devolve #f se lst não é palíndromo.
(examples
 (check-equal? (palindromo empty) #t)
 (check-equal? (palindromo (list 2)) #t)
 (check-equal? (palindromo (list 1 2)) #f)
 (check-equal? (palindromo (list 1 2 1)) #t)
 (check-equal? (palindromo (list 5 2 2 5)) #t)
 (check-equal? (palindromo (list 5 2 1 5)) #f))

(define (palindromo lst)
  (equal? lst (inverte lst)))

