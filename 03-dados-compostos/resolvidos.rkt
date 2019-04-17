#lang racket

(require rackunit)
(require rackunit/text-ui)

;;;;;;;;;;;;;;;;;;;;
;; Exercício 3.3

;; Qualquer Lista -> Lista
;; Devolve uma lista que é como lst mas com a no final.
;; Obs: Não é comum "inserir" no final de uma lista, mas é um bom exercício.
(define cons-fim-tests
  (test-suite
   "cons-fim tests"
   (check-equal? (cons-fim 3 empty) (list 3))
   (check-equal? (cons-fim 3 (list 5)) (list 5 3))
   (check-equal? (cons-fim 8 (list 2 5)) (list 2 5 8))))

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
(define inverte-tests
  (test-suite
   "inverte tests"
   (check-equal? (inverte empty) empty)
   (check-equal? (inverte (list 2)) (list 2))
   (check-equal? (inverte (list 2 8 9)) (list 9 8 2))))

(define (inverte lst)
  (cond
    [(empty? lst) empty]
    [else (append (inverte (rest lst))
                  (list (first lst)))]))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 3.5

;; Lista -> Boolean
;; Devolve verdadeiro se lst é palíndromo, isto é, lst é igual a lst invertida.
;; Devolve falso se lst não é palíndromo.
(define palindromo-tests
  (test-suite
   "palindromo tests"
   (check-equal? (palindromo empty) #t)
   (check-equal? (palindromo (list 2)) #t)
   (check-equal? (palindromo (list 1 2)) #f)
   (check-equal? (palindromo (list 1 2 1)) #t)
   (check-equal? (palindromo (list 5 2 2 5)) #t)
   (check-equal? (palindromo (list 5 2 1 5)) #f)))

(define (palindromo lst)
  (equal? lst (inverte lst)))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 3.6

;; Lista Número -> Lista
;; Devolve uma nova lista com n somado a cada elemento de lst.
(define lista-add-num-tests
  (test-suite
   "lista-add-num tests"
   (check-equal? (lista-add-num empty 3)
                 empty)
   (check-equal? (lista-add-num (list 2) 4)
                 (list 6))
   (check-equal? (lista-add-num (list 1 2) 5)
                 (list 6 7))
   (check-equal? (lista-add-num (list 5 -2 3) -2)
                 (list 3 -4 1))))

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

(define maximo-tests
  (test-suite
   "maximo tests"
   (check-exn exn:fail? (thunk (maximo empty)))
   (check-equal? (maximo (list 4)) 4)
   (check-equal? (maximo (list 2 4 8 3)) 8)
   (check-equal? (maximo (list 8 4 8 3)) 8)))

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
(define insere-ordenado-tests
  (test-suite
   "insere-ordenado tests"
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
                 (list 2 6 9 10))))

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
(define ordena-tests
  (test-suite
   "ordena tests"
   (check-equal? (ordena empty)
                 empty)
   (check-equal? (ordena (list 2))
                 (list 2))
   (check-equal? (ordena (list 3 2))
                 (list 2 3))
   (check-equal? (ordena (list 5 -2 3))
                 (list -2 3 5))
   (check-equal? (ordena (list 1 9 5 -2 8 3))
                 (list -2 1 3 5 8 9))))

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
(define avalia-tests
  (test-suite
   "avalia tests"
   (check-equal? (avalia 4)
                 4)
   (check-equal? (avalia '(+ 2 4))
                 6)
   (check-equal? (avalia '(+ (* 3 (- 4 5)) (/ 10 2)))
                 2)))

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
;; Funções para auxiliar nos testes

;; Teste ... -> Void
;; Executa um conjunto de testes.
(define (executa-testes . testes)
  (run-tests (test-suite "Todos os testes" testes))
  (void))

;; Chama a função para executar os testes.
(executa-testes cons-fim-tests
                inverte-tests
                palindromo-tests
                lista-add-num-tests
                maximo-tests
                insere-ordenado-tests
                ordena-tests
                avalia-tests)
