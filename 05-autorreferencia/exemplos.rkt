#lang racket

(require examples)

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
(examples
 (check-equal? (tamanho nil) 0)
 (check-equal? (tamanho (no 2 nil)) 1)
 (check-equal? (tamanho (no 1 (no 2 nil))) 2)
 (check-equal? (tamanho (no 5 (no 1 (no 2 nil)))) 3))

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
(examples
 (check-equal? (soma empty) 0)
 (check-equal? (soma (cons 2 empty)) 2)
 (check-equal? (soma (cons 1 (cons 2 empty))) 3)
 (check-equal? (soma (cons 5 (cons 1 (cons 2 empty)))) 8))

(define (soma lst)
  (cond
    [(empty? lst) 0]
    [else (+ (first lst)
             (soma (rest lst)))]))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.5

;; Lista Qualquer -> Lista
;; Devolve uma lista que é como lst mas sem a primeira ocorrência de a.
(examples
 (check-equal? (remove empty 4) empty)
 (check-equal? (remove (list 3 8 4 3) 4) (list 3 8 3))
 (check-equal? (remove (list 3 8 4 3) 3) (list 8 4 3))
 (check-equal? (remove (list 1 2 3) 4) (list 1 2 3)))

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
(examples
 (check-equal? (remove-sim empty 4) empty)
 (check-equal? (remove-sim (list 3 8 4 3) 4) (list 3 8 3))
 (check-equal? (remove-sim (list 3 8 4 3) 3) (list 8 4 3))
 (check-equal? (remove-sim (list 1 2 3) 4) (list 1 2 3)))

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
(examples
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
               30))

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
(examples
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
               (list 1 3 4 5 4 6 7)))

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
(examples
 (check-equal? (altura empty) -1)
 (check-equal? (altura t0) 0)
 (check-equal? (altura t1) 1)
 (check-equal? (altura t2) 2)
 (check-equal? (altura t3) 1)
 (check-equal? (altura t4) 3))

(define (altura t)
  (cond
    [(empty? t) -1]
    [else (add1 (max
                 (altura (arvore-bin-esq t))
                 (altura (arvore-bin-dir t))))]))


;;;;;;;;;;;;;;;;;;;;
;; Definição de número Natural

;; Um número Natural é:
;; - 0; ou
;; - (add1 n), onde n é um número Natural
;;
;; Template
#;
(define (fun-for-natural n)
  (cond
    [(zero? n) ...]
    [else ...
          n
          (fun-for-natural (sub1 n))]))


;;;;;;;;;;;;;;;;;;;;
;; Definição de número Inteiro>=a

;; Um número Inteiro>=a é:
;; - a; ou
;; - (add1 n), onde n é um número Inteiro>=a
;;
;; Template
#;
(define (fun-for-inteiro>=a n)
  (cond
    [(<= n a) ...]
    [else ...
          n
          (fun-for-inteiro>=a (sub1 n))]))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 4.1

;; Natural -> Natural
;; Devolve a soma 0 + 1 + 2 + ... + n.
(examples
 (check-equal? (soma-nat 0) 0)
 (check-equal? (soma-nat 1) 1)
 (check-equal? (soma-nat 3) 6)) ; (+ 3 2 1 0)

(define (soma-nat n)
  (cond
    [(zero? n) 0]
    [else (+ n
             (soma-nat (sub1 n)))]))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 4.2

;; Natural -> Lista
;; Devolve a lista (cons n (cons n-1 ... (cons 1 empty)...)).
(examples
 "cria-lista tests"
 (check-equal? (cria-lista 0) empty)
 (check-equal? (cria-lista 1) (cons 1 empty))
 (check-equal? (cria-lista 3) (cons 3
                                    (cons 2
                                          (cons 1 empty)))))

(define (cria-lista n)
  (cond
    [(zero? n) empty]
    [else (cons n
                (cria-lista (sub1 n)))]))

;;;;;;;;;;;;;;;;;;;;
;; Exemplo 4.3

;; Natural Inteiro>=1 -> Boolean
;; Devolve #t se x tem divisor entre 1 (inclusive) e i (inclusive).
;; #f caso contrário.
(examples
 (check-equal? (e-divisivel-por<=i? 5 1) #f)
 (check-equal? (e-divisivel-por<=i? 2 2) #t)
 (check-equal? (e-divisivel-por<=i? 5 5) #t)
 (check-equal? (e-divisivel-por<=i? 10 5) #t)
 (check-equal? (e-divisivel-por<=i? 8 7) #t)
 (check-equal? (e-divisivel-por<=i? 9 2) #f))

(define (e-divisivel-por<=i? n i)
  (cond
    [(<= i 1) #f]
    [else
     (or (divisivel? n i)
         (e-divisivel-por<=i? n (sub1 i)))]))

;; Natural Natural -> Boolean
;; Devolve #t se x é divisível por i, #f caso contrário.
(define (divisivel? n i)
  (zero? (remainder n i)))

(examples
 (check-equal? (primo? 2) #t)
 (check-equal? (primo? 3) #t)
 (check-equal? (primo? 4) #f)
 (check-equal? (primo? 5) #t)
 (check-equal? (primo? 6) #f)
 (check-equal? (primo? 7) #t)
 (check-equal? (primo? 8) #f)
 (check-equal? (primo? 9) #f))

;; Natural -> Boolean
;; Devolve true se n é primo. false caso contrário.
(define (primo? n)
  (not (e-divisivel-por<=i? n (sub1 n))))
