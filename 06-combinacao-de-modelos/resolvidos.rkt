#lang racket

(require examples)

;; Uma ListaDeNúmeros é um dos valores:
;; - empty
;; - (cons Número ListaDeNúmeros)
#; (define lst0 empty)
#; (define lst1 (cons 2 (cons 4 empty)))
#;
(define (fn-para-ldn ldn)
  (cond
    [(empty? ldn) ...]
    [else
     (... (first ldn)
          (fn-para-ldn (rest ldn)))]))


;; Natural Natural -> Boolean
;; Devolve true se a é maior que b, falso caso contrário.
;;
;;                             b
;;                +------------+------------------+
;;                |      0     |    (add1 ...)    |
;;   +------------+------------+------------------+
;;   |      0     |           #f                  |
;; a +------------+------------+------------------+
;;   | (add1 ...) |      #t    | recursão natural |
;;    +------------+------------+------------------+
(examples
 (check-equal? (>? 0 0) #f)
 (check-equal? (>? 0 2) #f)
 (check-equal? (>? 2 0) #t)
 (check-equal? (>? 2 3) #f)
 (check-equal? (>? 4 3) #t))

(define (>? a b)
  (cond
    [(zero? a) #f]
    [(zero? b) #t]
    [else (>? (sub1 a) (sub1 b))]))


;; ListaDeNúmeros Natural -> Lista
;; Devolve uma lista com os n primeiros elementos de lst.
;; Veja a função pré-definida take.
;;
;;                              n
;;                  +-----------+--------------------+
;;                  |     0     |     (add1 ...)     |
;;     +------------------------+--------------------+
;;     |   empty    |           |        erro        |
;; lst +------------+   empty   +--------------------+
;;     | (cons ...) |           | cons (first lst) + |
;;     |            |           |  recursão natural  |
;;     +------------+-----------+--------------------+

  (examples
   (check-equal? (mantem empty 0) empty)
   (check-equal? (mantem (list 1 2 3) 0) empty)
   (check-exn exn:fail? (thunk (mantem empty 1)))
   (check-equal? (mantem (list 4 2 3) 1) (list 4))
   (check-equal? (mantem (list 4 2 5) 3) (list 4 2 5))
   (check-exn exn:fail? (thunk (mantem (list 4 2 5) 4))))

(define (mantem lst n)
  (cond
    [(zero? n) empty]
    [(empty? lst) (error "Lista vazia")]
    [else (cons (first lst)
                (mantem (rest lst) (sub1 n)))]))


;; ListaDeNúmeros ListaDeNúmeros -> ListaDeNúmeros
;; Faz a intercalação dos elementos de lsta e lstb.
;; Requer a lsta e lstb estejam em ordem não decrescente.
;;
;;                              lstb
;;                   +------------+--------------------------------------------+
;;                   |   empty    |                 (cons ...)                 |
;;      +------------+------------+--------------------------------------------+
;;      |   empty    |                          lstb                           |
;; lsta +------------+------------+--------------------------------------------+
;;      | (cons ...) |    lsta    | cons menor entre (first lsta) (first lstb) |
;;      |            |            |              recursão natural              |
;;      +------------+------------+--------------------------------------------+
;;
;; Observe que ao invés de juntar as celúlas na linha lsta empty, poderíamos
;; juntar as células da coluna lstb empty.
(examples
 (check-equal? (merge empty empty)
               empty)
 (check-equal? (merge (list 1 2 3) empty)
               (list 1 2 3))
 (check-equal? (merge empty (list 1 2 3))
               (list 1 2 3))
 (check-equal? (merge (list 4 10 20) (list 1 2 6 8))
               (list 1 2 4 6 8 10 20))
 (check-equal? (merge (list 1 2 6 8) (list 4 10 20))
               (list 1 2 4 6 8 10 20)))

(define (merge lsta lstb)
  (cond
    [(empty? lsta) lstb]
    [(empty? lstb) lsta]
    [(< (first lsta) (first lstb))
     (cons (first lsta)
           (merge (rest lsta) lstb))]
    [else
     (cons (first lstb)
           (merge lsta (rest lstb)))]))


;; ListaDeNúmeros Natural -> Natural
;; Devolve a quantidade de formas diferentes que se pode dar troco de um valor
;; a partir de uma lista de valores de moedas

;;                        moedas
;;             +-------+--------------------+
;;             | empty |     (cons ...)     |
;;       +-----+-------+--------------------+
;;       |  0  |             1              |
;;       +-----+----------------------------+
;; valor | < 0 |             0              |
;;       +-----+----------------------------+
;;       | > 0 | erro  | soma das recursões |
;;       +-----+-------+--------------------+

(examples
 (check-equal? (conta-troco 4 (list 1 2)) 3)
 ;; 1+1+1+1, 1+1+2, 2+2
 (check-equal? (conta-troco 6 (list 2 3)) 2)
 ;; 2+2+2, 3+3
 (check-equal? (conta-troco 10 (list 2 3 4)) 5))
 ;; 2+2+2+2+2, 2+2+2+4, 2+2+3+3, 2+4+4, 3+3+4

(define (conta-troco valor moedas)
  (cond
    [(zero? valor) 1]
    [(negative? valor) 0]
    [(empty? moedas) 0]
    [else
     (+ (conta-troco (- valor (first moedas)) moedas)
        (conta-troco valor (rest moedas)))]))
