#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;
;; Exercício 3.3

;; Qualquer Lista -> Lista
;; Devolve uma lista que é como lst mas com a no final.
;; Obs: Não é comum "inserir" no final de uma lista, mas é um bom exercício.
(examples
 (check-equal? (cons-fim 3 empty) (list 3))
 (check-equal? (cons-fim 3 (list 5)) (list 5 3))
 (check-equal? (cons-fim 8 (list 2 5)) (list 2 5 8)))

(define (cons-fim a lst)
  (cond
    [(empty? lst) (list a)]
    [else (cons (first lst)
                (cons-fim a (rest lst)))]))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 3.4

;; Lista -> Lista
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
    [else (append (inverte (rest lst))
                  (list (first lst)))]))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 3.5

;; Lista -> Boolean
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


;;;;;;;;;;;;;;;;;;;;
;; Exercício 3.6

;; Lista Número -> Lista
;; Devolve uma nova lista com n somado a cada elemento de lst.
(examples
 (check-equal? (lista-add-num empty 3)
               empty)
 (check-equal? (lista-add-num (list 2) 4)
               (list 6))
 (check-equal? (lista-add-num (list 1 2) 5)
               (list 6 7))
 (check-equal? (lista-add-num (list 5 -2 3) -2)
               (list 3 -4 1)))

(define (lista-add-num lst n)
  (cond
    [(empty? lst) empty]
    [else
     (cons (+ n (first lst))
           (lista-add-num (rest lst) n))]))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 3.9

;; Lista -> Número
;; Devolve o valor máximo de lst. Se a lista for vazia, gera um erro.

(examples
 (check-exn exn:fail? (thunk (maximo empty)))
 (check-equal? (maximo (list 4)) 4)
 (check-equal? (maximo (list 2 4 8 3)) 8)
 (check-equal? (maximo (list 8 4 8 3)) 8))

(define (maximo lst)
  (cond
    [(empty? lst) (error "Lista vazia")]
    [(empty? (rest lst)) (first lst)]
    [(max2 (first lst)
           (maximo (rest lst)))]))

;; Número Número -> Número
;; Devolve a se a >= b. Devolve b caso contrário.
;; Veja a função pré-definida max.
(define (max2 a b)
  (if (>= a b) a b))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 3.10

;; Número Lista -> Lista
;; Devolve uma nova lista como os mesmo elementos de lst e o n em ordem não
;; decrescente. Esta função supõe que lst está ordenada.
(examples
 (check-equal? (insere-ordenado 2 empty)
               (list 2))
 (check-equal? (insere-ordenado 1 (list 2))
               (list 1 2))
 (check-equal? (insere-ordenado 3 (list 2))
               (list 2 3))
 (check-equal? (insere-ordenado 1 (list 2 6 9))
               (list 1 2 6 9))
 (check-equal? (insere-ordenado 4 (list 2 6 9))
               (list 2 4 6 9))
 (check-equal? (insere-ordenado 7 (list 2 6 9))
               (list 2 6 7 9))
 (check-equal? (insere-ordenado 10 (list 2 6 9))
               (list 2 6 9 10)))

(define (insere-ordenado n lst)
  (cond
    [(empty? lst) (list n)]
    [(n . < . (first lst)) (cons n lst)]
    [else (cons (first lst)
                (insere-ordenado n (rest lst)))]))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 3.11

;; Lista -> Lista
;; Devolve uma nova lista com os mesmos elemento de lst em ordem não
;; decrescente.
(examples
 (check-equal? (ordena empty)
               empty)
 (check-equal? (ordena (list 2))
               (list 2))
 (check-equal? (ordena (list 3 2))
               (list 2 3))
 (check-equal? (ordena (list 5 -2 3))
               (list -2 3 5))
 (check-equal? (ordena (list 1 9 5 -2 8 3))
               (list -2 1 3 5 8 9)))

;; Usando o modelo de função para listas implementamos o insertion-sort.
(define (ordena lst)
  (cond
    [(empty? lst) empty]
    [else (insere-ordenado (first lst)
                           (ordena (rest lst)))]))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 3.14

;; Para fazer este exercício é necessário criar a definição de expressão. Uma
;; expressão aritmética é
;; - um número; ou
;; - (list op op1 op2), onde op é uma das operações +, -, *, /, e op1 e op2 são
;;   expressões
;;
;; Para escrever a função avalia, usamos a definição da expressão para
;; selecionar cada caso da expressão
;;
;; Expressão -> Número
;; Avalia uma expressão.
(examples
 (check-equal? (avalia 4)
               4)
 (check-equal? (avalia '(+ 2 4))
               6)
 (check-equal? (avalia '(+ (* 3 (- 4 5)) (/ 10 2)))
               2))

(define (avalia exp)
  (cond
    [(number? exp) exp]
    [(equal? '+ (first exp))
     (+ (avalia (second exp))
        (avalia (third exp)))]
    [(equal? '- (first exp))
     (- (avalia (second exp))
        (avalia (third exp)))]
    [(equal? '* (first exp))
     (* (avalia (second exp))
        (avalia (third exp)))]
    [(equal? '/ (first exp))
     (/ (avalia (second exp))
        (avalia (third exp)))]))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 4.3

;; Natural -> Boolean
;; Devolve #t se a é par, #f caso contrário.
;; Veja a função pré-defina even?
(examples
 (check-equal? (par? 0) #t)
 (check-equal? (par? 1) #f)
 (check-equal? (par? 2) #t)
 (check-equal? (par? 3) #f)
 (check-equal? (par? 4) #t))

(define (par? a)
  (if (zero? a)
      #t
      (impar? (sub1 a))))

;; Natural -> Boolean
;; Devolve #t se a é ímpar, #f caso contrário.
;; Veja a função pré-defina odd?
(examples
 (check-equal? (impar? 0) #f)
 (check-equal? (impar? 1) #t)
 (check-equal? (impar? 2) #f)
 (check-equal? (impar? 3) #t)
 (check-equal? (impar? 4) #f))

(define (impar? a)
  (if (zero? a)
      #f
      (par? (sub1 a))))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 4.4

;; Natural -> Boolean
;; Devolve #t se n é um número perfeito, #f caso contrário. Um número natural
;; é perfeito se a soma dos seus divisores (menos ele mesmo) é igual ao número.
(examples
 (check-equal? (perfeito? 1) #f)
 (check-equal? (perfeito? 2) #f)
 (check-equal? (perfeito? 3) #f)
 (check-equal? (perfeito? 4) #f)
 (check-equal? (perfeito? 5) #f)
 (check-equal? (perfeito? 6) #t) ; 6 = 1 + 2 + 3
 (check-equal? (perfeito? 27) #f)
 (check-equal? (perfeito? 28) #t); 28 = 1 + 2 + 4 + 7 + 14
 (check-equal? (perfeito? 29) #f))

(define (perfeito? n)
  (= n (soma-divisores n (sub1 n))))

;; Natural -> Natural
;; Soma os divisores de n no intervalo [1, d].
(examples
 (check-equal? (soma-divisores 7 1) 1)
 (check-equal? (soma-divisores 7 0) 0)
 (check-equal? (soma-divisores 4 4) 7)    ; 4 + 2 + 1
 (check-equal? (soma-divisores 10 9) 8)) ; 5 + 2 + 1

(define (soma-divisores n d)
  (cond
    [(zero? d) 0]
    [(divisivel? n d) (+ d (soma-divisores n (sub1 d)))]
    [else (soma-divisores n (sub1 d))]))

;; Natural Natural -> Boolean
;; Devolve #t se n é divisível por d, #f caso contrário.
(define (divisivel? n d)
  (= (remainder n d) 0))
