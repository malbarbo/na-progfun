#lang racket

(require rackunit)
(require rackunit/text-ui)

;;;;;;;;;;;;;;;;;;;;
;; Definição de Ponto

(struct ponto (x y) #:transparent)
;; Ponto representa um ponto no plano cartesiano
;;   x : Número - a coordenada x
;;   y : Número - a coordenada y
;; Exemplos
#; (define p1 (ponto 3 4))
#; (define p2 (ponto 8 2))
;; Template
#;
(define (fun-for-ponto p)
  (... (ponto-x p)
       (ponto-y p)))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.1

;; Ponto -> Número
;; Calcula a distância de um ponto a origem
(define distancia-origem-tests
  (test-suite
   "distancia-origem tests"
   (check-equal? (distancia-origem (ponto 3 4)) 5)))

(define (distancia-origem p)
  (sqrt (+ (sqr (ponto-x p))
           (sqr (ponto-y p)))))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.2

(struct retangulo (largura altura) #:transparent)
;; Ponto representa um ponto no plano cartesiano
;;   largura : Número - a largura do retangulo
;;   largura : Número - a altura do retangulo
;; Exemplos
#; (define r1 (retangulo 3 4))
#; (define r2 (retangulo 1 2))
;; Template
#;
(define (fun-for-retangulo r)
  (... (retangulo-largura r)
       (retangulo-altura r)))

;; Retangulo -> String
;; Classifica um retangulo em
;;   largo    se largura > altura
;;   alto     se altura > largura
;;   quadrado se largura = altura
(define classifica-retangulo-tests
  (test-suite
   "classifica-retangulo tests"
   (check-equal? (classifica-retangulo (retangulo 4 3)) "largo")
   (check-equal? (classifica-retangulo (retangulo 4 6)) "alto")
   (check-equal? (classifica-retangulo (retangulo 5 5)) "quadrado")))

(define (classifica-retangulo r)
  (cond
    [(> (retangulo-largura r) (retangulo-altura r)) "largo"]
    [(< (retangulo-largura r) (retangulo-altura r)) "alto"]
    [else "quadrado"]))


;;;;;;;;;;;;;;;;;;;;
;; Definição de Lista

(define nil false)

(struct lista (first rest))
;; Uma Lista é
;;   - nil; ou
;;   - (lista first rest) onde first é o primeiro elemento da lista
;;     e rest é uma Lista com o restante dos elementos
;; Exemplos
#; (define lst-vazia nil)
#; (define lst1 (lista 3 nil))
#; (define lst2 (lista 10 (lista 3 nil)))
#; (define lst3 (lista 1 (lista 5 (lista 2 nil))))
;; Template
#;
(define (fun-for-lista lst)
  (cond
    [(equal? lst nil) ...]
    [else (... (lista-first lst)
               (fun-for-lista (lista-rest lst)))]))

;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.3

;; Lista -> Natural
;; Devolve a quantidade de elementos de lst

(define tamanho-tests
  (test-suite
   "tamanho tests"
   (check-equal? (tamanho nil) 0)
   (check-equal? (tamanho (lista 2 nil)) 1)
   (check-equal? (tamanho (lista 1 (lista 2 nil))) 2)
   (check-equal? (tamanho (lista 5 (lista 1 (lista 2 nil)))) 3)))

(define (tamanho lst)
  (cond
    [(equal? lst nil) 0]
    [else (add1 (tamanho (lista-rest lst)))]))

;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.4

;; Lista -> Natural
;; Devolve a soma dos elementos de lst

(define soma-tests
  (test-suite
   "soma tests"
   (check-equal? (soma empty) 0)
   (check-equal? (soma (cons 2 empty)) 2)
   (check-equal? (soma (cons 1 (cons 2 empty))) 3)
   (check-equal? (soma (cons 5 (cons 1 (cons 2 empty)))) 8)))

(define (soma lst)
  (cond
    [(empty? lst) 0]
    [else (+ (first lst)
             (soma (rest lst)))]))



;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.5

;; Lista Qualquer -> Lista
;; Devolve uma lista que é como lst mas sem a primeira ocorrência de a

(define remove-tests
  (test-suite
   "remove tests"
   (check-equal? (remove empty 4) empty)
   (check-equal? (remove (list 3 8 4 3) 4) (list 3 8 3))
   (check-equal? (remove (list 3 8 4 3) 3) (list 8 4 3))
   (check-equal? (remove (list 1 2 3) 4) (list 1 2 3))))

(define (remove lst a)
  (cond
    [(empty? lst) empty]
    [else
     (cond
       [(equal? (first lst) a) (rest lst)]
       [else (cons (first lst)
                   (remove (rest lst) a))])]))

;; Simplificação (opciconal) da função remove
;; As condições aninhadas foram colocadas no mesmo nível

(define remove-sim-tests
  (test-suite
   "removes-sim tests"
   (check-equal? (remove-sim empty 4) empty)
   (check-equal? (remove-sim (list 3 8 4 3) 4) (list 3 8 3))
   (check-equal? (remove-sim (list 3 8 4 3) 3) (list 8 4 3))
   (check-equal? (remove-sim (list 1 2 3) 4) (list 1 2 3))))

(define (remove-sim lst a)
  (cond
    [(empty? lst) empty]
    [(equal? (first lst) a) (rest lst)]
    [else (cons (first lst)
                (remove-sim (rest lst) a))]))

;; Continua ...

;;;;;;;;;;;;;;;;;;;;
;; Funções para auxiliar nos testes

;; Teste ... -> Void
;; Executa um conjunto de testes.
(define (executa-testes . testes)
  (run-tests (test-suite "Todos os testes" testes))
  (void))

;; Chama a função para executar os testes.
(executa-testes distancia-origem-tests
                classifica-retangulo-tests
                tamanho-tests
                soma-tests
                remove-tests
                remove-sim-tests)