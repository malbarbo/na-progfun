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
;; Modelo
#;
(define (fun-for-ponto p)
  (... (ponto-x p)
       (ponto-y p)))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.1

;; Ponto -> Número
;; Calcula a distância de um ponto a origem.
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
;; Representa um retangulo
;;   largura : Número - a largura do retangulo
;;   altura  : Número - a altura do retangulo
;; Exemplos
#; (define r1 (retangulo 3 4))
#; (define r2 (retangulo 1 2))
;; Modelo
#;
(define (fun-for-retangulo r)
  (... (retangulo-largura r)
       (retangulo-altura r)))

;; Retangulo -> String
;; Classifica um retangulo em:
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

(define nil (void))

(struct no (primeiro rest))
;; Uma Lista é
;;   - nil; ou
;;   - (no primeiro rest) onde first é o primeiro elemento da lista e rest é
;;     uma Lista com o restante dos elementos
;; Exemplos
#; (define lst-vazia nil)
#; (define lst1 (no 3 nil))
#; (define lst2 (no 10 (no 3 nil)))
#; (define lst3 (no 1 (no 5 (no 2 nil))))
;; Modelo
#;
(define (fun-for-lista lst)
  (cond
    [(equal? lst nil) ...]
    [else (... (no-first lst)
               (fun-for-lista (no-rest lst)))]))

;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.3

;; Lista -> Natural
;; Devolve a quantidade de elementos de lst.
(define tamanho-tests
  (test-suite
   "tamanho tests"
   (check-equal? (tamanho nil) 0)
   (check-equal? (tamanho (no 2 nil)) 1)
   (check-equal? (tamanho (no 1 (no 2 nil))) 2)
   (check-equal? (tamanho (no 5 (no 1 (no 2 nil)))) 3)))

(define (tamanho lst)
  (cond
    [(equal? lst nil) 0]
    [else (add1 (tamanho (no-rest lst)))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Nós próximos exemplos deixamos de lado a nossa definição
;; de lista para utilizar a lista pré definida em Racket.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.4

;; Lista -> Número
;; Devolve a soma dos elementos de lst.
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
;; Devolve uma lista que é como lst mas sem a primeira ocorrência de a.
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

;; Simplificação (opcional) da função remove.
;; As condições aninhadas foram colocadas no mesmo nível.
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


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.6

;; Lista Aninhada -> Número
;; Devolve a soma de todos os elementos de lst.
(define soma*-tests
  (test-suite
   "soma* tests"
   (check-equal? (soma* empty)
                 0)
   (check-equal? (soma* (list (list 4 5) 1 2))
                 12)
   (check-equal? (soma* (list 1 3 (list 4 5) ))
                 13)
   (check-equal? (soma* (list (list 1
                                    (list empty 3))
                              (list 4 5)
                              4
                              6
                              7))
                 30)))

(define (soma* lst)
  (cond
    [(empty? lst) 0]
    [(list? (first lst))
     (+ (soma* (first lst))
        (soma* (rest lst)))]
    [else
     (+ (first lst)
        (soma* (rest lst)))]))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.7

;; Lista Aninhada -> Lista
;; Devolve uma versão não aninhada de lst, isto é, uma lista com os mesmos
;; elementos de lst, mas sem aninhamento.
;; Veja a função pré-definida flatten.
(define aplaina-tests
  (test-suite
   "aplaina tests"
   (check-equal? (aplaina empty) empty)
   (check-equal? (aplaina (list (list 4 5) 1 2))
                 (list 4 5 1 2))
   (check-equal? (aplaina (list 1 3 (list 4 5)))
                 (list 1 3 4 5))
   (check-equal? (aplaina (list (list 1
                                      (list empty 3))
                                (list 4 5)
                                4
                                6
                                7))
                 (list 1 3 4 5 4 6 7))))

(define (aplaina lst)
  (cond
    [(empty? lst) empty]
    [(list? (first lst))
     (append (aplaina (first lst))
             (aplaina (rest lst)))]
    [else
     (cons (first lst)
           (aplaina (rest lst)))]))


;;;;;;;;;;;;;;;;;;;;
;; Definição de Árvore binária

(struct arvore-bin (v esq dir) #:transparent)
;; Uma Árvore binária é
;;   - empty; ou
;;   - (arvore-bin v esq dir)onde v e o valor armazenado no nó e esq e dir são
;;     Árvores binárias
;; Exemplos
#; (define arvore-vazia empty)
#; (define t1 (arvore-bin 3 empty empty))
#; (define t2 (arvore-bin 9 t1 (arvore-bin 7 empty empty)))
;; Modelo
#;
(define (fun-for-arvore-bin t)
  (cond
    [(empty? t) ...]
    [else ... (arvore-bin-v t)
          ... (fun-for-arvore-bin (arvore-bin-dir t))
          ... (fun-for-arvore-bin (arvore-bin-esq t)) ...]))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.8

;; Estas árvores são usadas nos testes a seguir
;;
;;     t4  3
;;        / \
;;       /   \
;;  t3  4     7  t2
;;     /     / \
;;    3     8   9  t1
;;             /
;;        t0  10

(define t0 (arvore-bin 10 empty empty))

(define t1 (arvore-bin 9
                       t0
                       empty))

(define t2 (arvore-bin 7
                       (arvore-bin 8 empty empty)
                       t1))

(define t3 (arvore-bin 4
                       (arvore-bin 3 empty empty)
                       empty))

(define t4 (arvore-bin 3
                       t2
                       t2))


;; Arvore-Binaria -> Natural
;; Devolve a altura da árvore binária. A altura de uma árvore binária é a
;; distância da raiz a seu descendente mais afastado. Uma árvore com um único
;; nó tem altura 0. Uma árvore vazia tem altura -1.
(define altura-tests
  (test-suite
   "altura tests"
   (check-equal? (altura empty) -1)
   (check-equal? (altura t0) 0)
   (check-equal? (altura t1) 1)
   (check-equal? (altura t2) 2)
   (check-equal? (altura t3) 1)
   (check-equal? (altura t4) 3)))

(define (altura t)
  (cond
    [(empty? t) -1]
    [else (add1 (max
                 (altura (arvore-bin-esq t))
                 (altura (arvore-bin-dir t))))]))


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
                remove-sim-tests
                soma*-tests
                aplaina-tests
                altura-tests)
