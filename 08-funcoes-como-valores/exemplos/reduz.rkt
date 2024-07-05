#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vamos criar uma função que abstrai o comportamento das funções soma e
;; produto.

;; Lista(Número) -> Número
;; Calula a soma dos números de lst.
(examples
 (check-equal? (soma empty) 0)
 (check-equal? (soma (list 3)) 3)
 (check-equal? (soma (list 3 5)) 8)
 (check-equal? (soma (list 3 5 -2)) 6))

;; Implementação inicial da função soma
#;
(define (soma lst)
  (cond
    [(empty? lst) 0]
    [else (+ (first lst)
             (soma (rest lst)))]))

;; Lista(Número) -> Número
;; Calcula o produto dos números de lst.
(examples
 (check-equal? (produto empty) 1)
 (check-equal? (produto (list 3)) 3)
 (check-equal? (produto (list 3 5)) 15)
 (check-equal? (produto (list 3 5 -2)) -30))

;; Implementação inicial da função produto
#;
(define (produto lst)
  (cond
    [(empty? lst) 1]
    [else (* (first lst)
             (produto (rest lst)))]))

;; Olhando para o corpo das funções soma e produto observamos que as únicas
;; diferenças são a ocorrência do valor 0 e 1 e da função + e *.
;;
;; Da mesma forma que fizemos com as funções contem-5? e contem-3? vamos
;; abstrair estas duas funções e criar a função reduz (a função reduz uma lista
;; a um valor) que além da lista, recebe como parâmetro f, que será usado no
;; lugar de + ou * e base que será usado no lugar de 0 ou 1.
;;
;; Em seguida vamos reescrever as funções soma e produto em termos de reduz.

;; (X Y -> Y) Y Lista(X) -> Y
;; (reduz f base (list x1 x2 ... xn) devolve
;; (f x1 (f x2 ... (f xn base)))
;; Veja a função pré-definida foldr.
(examples
 (check-equal? (reduz + 0 empty) 0)
 (check-equal? (reduz * 1 (list 3 5 -2)) -30))

(define (reduz f base lst)
  (cond
    [(empty? lst) base]
    [else (f (first lst)
             (reduz f base (rest lst)))]))

;; Função soma escrita em termos de reduz.
(define (soma lst)
  (reduz + 0 lst))

;; Função produto escrita em termos de reduz.
(define (produto lst)
  (reduz * 1 lst))

;; A função reduz é tão abstrata que pode ser usada para definir muitas outras
;; funções. Vamos definir a função concatena em termos da função reduz.

;; Lista Lista -> Lista
;; Cria uma nova lista com os elementos de lst1 antes de lst2.
(examples
 (check-equal? (concatena empty empty)
               empty)
 (check-equal? (concatena (list 4 7) empty)
               (list 4 7))
 (check-equal? (concatena empty (list 5 9))
               (list 5 9))
 (check-equal? (concatena (list 5 9) (list 7 9 20))
               (list 5 9 7 9 20)))

;; Implementação inicial da função concatena
#;
(define (concatena lst1 lst2)
  (cond
    [(empty? lst1) lst2]
    [else (cons (first lst1)
                (concatena (rest lst1) lst2))]))

;; Analisando o corpo das funções reduz e concatena, percebemos que o parâmetro
;; f deve ser cons e que o parâmetro base deve ser lst2. Desta forma,
;; definimos concatena em termos de reduz.
(define (concatena lst1 lst2)
  (reduz cons lst2 lst1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defina a função mapeia em termos da função reduz.

(define (mapeia f lst)
  (define (cons-f e lst) (cons (f e) lst))
  (reduz cons-f empty lst))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defina a função filtra em termos da função reduz.

(define (filtra pred? lst)
  (define (cons-if e lst)
    (if (pred? e) (cons e lst) lst))
  (reduz cons-if empty lst))
