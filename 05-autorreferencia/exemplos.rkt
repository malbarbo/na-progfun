#lang racket

(require examples)

(struct vazia () #:transparent)
(struct link (primeiro resto) #:transparent)

;; Uma ListaDeNúmeros é um dos valores:
;; - (vazia)
;; - (link Número ListaDeNúmeros)

#;(define ldn0 (vazia))
#;(define ldn1 (link 10 (vazia)))
#;(define ldn2 (link 5 (link 4 (vazia))))
#;(define ldn3 (link 20 ldn1))

#;
(define (fn-para-ldn ldn)
  (cond [(vazia? ldn) ...]
        [(link? ldn)
         (... (link-primeiro ldn)
              (fn-para-ldn (link-resto ldn)))]))

;; ListaDeNúmeros -> Número
;; Soma os valores de ldn.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))

(define (soma ldn)
  (cond [(vazia? ldn) 0]
        [else
         (+ (link-primeiro ldn)
            (soma (link-resto ldn)))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Nós próximos exemplos deixamos de lado as estruturas vazia
;; e link e utilizados empty e cons já definidas em Racket.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Uma ListaDeNúmeros é um dos valores:
;; - empty
;; - (cons Número ListaDeNúmeros)
#; (define ldn0 empty)
#; (define ldn1 (cons 2 (cons 4 empty)))
#;
(define (fn-para-ldn ldn)
  (cond
    [(empty? ldn) ...]
    [else
     (... (first ldn)
          (fn-para-ldn (rest ldn)))]))


;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em ldn; #f caso contrário
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))
; (define (contem? ldn v) #f)

(define (contem? ldn v)
  (cond
    [(empty? ldn) #f]
    [else
     (or (= v (first ldn))
         (contem? (rest ldn) v))]))


;; ListaDeNúmeros -> ListaDeNúmeros
;; Produz uma nova lista removendo os valores negativos de ldn.
(examples
 (check-equal? (remove-negativos empty) empty)
 (check-equal? (remove-negativos (cons -1 (cons 2 (cons -3 empty))))
               (cons 2 empty))
 (check-equal? (remove-negativos (cons 3 (cons 4 (cons -2 empty))))
               (cons 3 (cons 4 empty))))
; (define (remove-negativos ldn) empty) ; esboço

(define (remove-negativos ldn)
  (cond
    [(empty? ldn) empty]
    [else
     (if (< (first ldn) 0)
         (remove-negativos (rest ldn))
         (cons (first ldn)
               (remove-negativos (rest ldn))))]))


;; Projete uma função que some um dado valor x a cada elemento de uma lista.

;; ListaDeNúmeros Número -> ListaDeNúmeros
;; Produz uma nova lista somando x a cada elemento de ldn.
(examples
 (check-equal? (soma-x empty 4)
               empty)
 (check-equal? (soma-x (cons 4 (cons 2 empty)) 5)
               (cons 9 (cons 7 empty)))
 (check-equal? (soma-x (cons 3 (cons -1 (cons 4 empty))) -2)
               (cons 1 (cons -3 (cons 2 empty)))))

; (define (soma-x ldn x) empty)

(define (soma-x ldn x)
  (cond
    [(empty? ldn) empty]
    [else
     (cons (+ x (first ldn))
           (soma-x (rest ldn) x))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Naturais e inteiros
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Um número Natural é:
;; - 0; ou
;; - (add1 n), onde n é um número Natural
;;
;; Modelo
#;
(define (fn-para-natural n)
  (cond
    [(zero? n) ...]
    [else
      (... n
           (fun-for-natural (sub1 n)))]))


;; Um número Inteiro>=a é:
;; - a; ou
;; - (add1 n), onde n é um número Inteiro>=a
;;
;; Modelo
#;
(define (fn-para-inteiro>=a n)
  (cond
    [(<= n a) ...]
    [else
      (... n
           (fn-para-inteiro>=a (sub1 n)))]))


;; Natural -> Natural
;; Devolve a soma 1 + 2 + ... + n.
(examples
 (check-equal? (soma-nat 0) 0)
 (check-equal? (soma-nat 1) 1)
 (check-equal? (soma-nat 3) 6)) ; (+ 3 2 1 0)

(define (soma-nat n)
  (cond
    [(zero? n) 0]
    [else
      (+ n
         (soma-nat (sub1 n)))]))

;; Natural -> Lista
;; Cria uma lista com os valores 1 2 ... n-1 n.
(examples
  (check-equal? (lista-num 0) empty)
  (check-equal? (lista-num 1) (cons 1 empty))
  (check-equal? (lista-num 2) (cons 1 (cons 2 empty))))
(define (lista-num n)
  (cond
    [(zero? n) empty]
    [else
      (cons-fim n
                (lista-num (sub1 n)))]))


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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Árvore binária
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(struct no (valor esq dir) #:transparent)
;; Uma ÁrvoreBináriaDeNúmeros é um dos valores:
;;   - empty; ou
;;   - (no Número ÁrvoreBináriaDeNúmeros ÁrvoreBináriaDeNúmeros)
;; Exemplos
#;
(define arvore-vazia empty)
#;
(define t1 (no 3 empty empty))
#;
(define t2 (no 9 t1 (no 7 empty empty)))
;; Modelo
#;
(define (fn-para-abdn t)
  (cond
    [(empty? t) ...]
    [else
      (... (no-valor t)
           (fn-para-abdn (no-esq t))
           (fn-para-abdn (no-dir t)))]))

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

(define t0 (no 10 empty empty))
(define t1 (no 9 t0 empty))
(define t2 (no 7 (no 8 empty empty) t1))
(define t3 (no 4 (no 3 empty empty) empty))
(define t4 (no 3 t2 t3))

;; ÁrvoreBináriaDeNúmeros -> Natural
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
    [else
      (add1 (max (altura (no-esq t))
                 (altura (no-dir t))))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Listas aninhadas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Um ListaAninhadaDeNúmeros é um dos valores:
;; - empty
;; - (cons ListaAninhadaDeNúmeros ListaAninhadaDeNúmeros)
;; - (cons Número ListaAninhadaDeNúmeros)
;; Exemplos
#;
(define ladn1 (cons 3 (cons (cons 2 (cons 4 empty)) (cons 2 empty)))) ; (list 3 (list (list 2 4) (list 2)))
;; Modelo
#;
(define (fn-para-ladn ldn)
  (cond
    [(empty? ldn) ...]
    [(list? (first ldn))
     (... (fn-para-ladn (first ldn))
          (fn-para-ladn (rest ldn)))]
    [else
     (... (first ldn)
          (fn-para-ladn (rest ldn)))]))


;; ListaAninhadaDeNúmeros -> Número
;; Devolve a soma de todos os elementos de ldn.
(examples
 (check-equal? (soma* empty)
               0)
 (check-equal? (soma* (list (list 4 5) 1 2))
               12)
 (check-equal? (soma* (list 1 3 (list 4 5)))
               13)
 (check-equal? (soma* (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               30))
(define (soma* ldn)
  (cond
    [(empty? ldn) 0]
    [(list? (first ldn))
     (+ (soma* (first ldn))
        (soma* (rest ldn)))]
    [else
     (+ (first ldn)
        (soma* (rest ldn)))]))


;; ListaAninhadaDeNúmeros -> ListaDeNúmeros
;; Devolve uma versão não aninhada de ldn, isto é, uma lista com os mesmos
;; elementos de ldn, mas sem aninhamento.
(examples
 (check-equal? (aplaina empty) empty)
 (check-equal? (aplaina (list (list 4 5) 1 2))
               (list 4 5 1 2))
 (check-equal? (aplaina (list 1 3 (list 4 5)))
               (list 1 3 4 5))
 (check-equal? (aplaina (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               (list 1 3 4 5 4 6 7)))
(define (aplaina ldn)
  (cond
    [(empty? ldn) empty]
    [(list? (first ldn))
     (append (aplaina (first ldn))
             (aplaina (rest ldn)))]
    [(empty? ldn) empty]
    [else
     (cons (first ldn)
           (aplaina (rest ldn)))]))
