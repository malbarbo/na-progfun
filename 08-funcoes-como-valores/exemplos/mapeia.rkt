#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vamos criar uma função que abstrai o comportamento das funções
;; lista-quadrado e lista-soma1.

;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com o quadrado de cada número de lst.
(examples
 (check-equal? (lista-quadrado empty)
               empty)
 (check-equal? (lista-quadrado (list 4))
               (list 16))
 (check-equal? (lista-quadrado (list 7 9 1))
               (list 49 81 1)))

;; Implementação inicial da função lista-quadrado
#;
(define (lista-quadrado lst)
  (cond
    [(empty? lst) empty]
    [else (cons (sqr (first lst))
                (lista-quadrado (rest lst)))]))

;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com cada número de lst somado de 1.
(examples
 (check-equal? (lista-soma1 empty)
               empty)
 (check-equal? (lista-soma1 (list 4))
               (list 5))
 (check-equal? (lista-soma1 (list 7 9 1))
               (list 8 10 2)))

;; Implementação inicial da função lista-soma1
#;
(define (lista-soma1 lst)
  (cond
    [(empty? lst) empty]
    [else (cons (add1 (first lst))
                (lista-soma1 (rest lst)))]))

;; Olhando para o corpo das funções lista-soma1 e lista-sqr observamos que a
;; única diferença é a ocorrência da função sqr e add1.
;;
;; Da mesma forma que fizemos anteriormente vamos abstrair estas duas funções e
;; criar a função mapeia (a função mapeia os elementos de uma lista usando uma
;; função) que além da lista, recebe como parâmetro f, que será usado no lugar
;; de sqr ou add1.
;;
;; Em seguida vamos definir as funções lista-soma1 e lista-sqr em termos da
;; função mapeia.

;; (X -> Y) Lista(X) -> Lista(Y)
;; Devolve uma lista aplicando f a cada elemento de lst, isto é
;; (mapeia f (lista x1 x2 ... xn)) devolve
;; (lista (f x1) (f x2) ... (f xn))
;; Veja a função pré-definida map.
(examples
 (check-equal? (mapeia add1 empty)
               empty)
 (check-equal? (mapeia positive? (list 4 -1 2))
               (list #t #f #t)))

(define (mapeia f lst)
  (cond
    [(empty? lst) empty]
    [else (cons (f (first lst))
                (mapeia f (rest lst)))]))

;; Função lista-quadrado escrita em termos de mapeia.
(define (lista-quadrado lst)
  (mapeia sqr lst))

;; Função lista-soma1 escrita em termos de mapeia.
(define (lista-soma1 lst)
  (mapeia add1 lst))
