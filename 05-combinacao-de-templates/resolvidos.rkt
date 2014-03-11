#lang racket

(require rackunit)
(require rackunit/text-ui)

;;;;;;;;;;;;;;;;;;;;
;; Exercício 5.1

;; Natural Natural -> Boolean
;; Devolve true se a é maior que b, falso caso contrário.
;;
;;                               b
;;                  |-------------------------
;;                  |      0     | (add1 ...)
;;     |------------|-------------------------
;;     |      0     |          false
;;  a  |------------|-------------------------
;;     | (add1 ...) |    true    | recursão natural
;;     |------------|------------|------------
(define >?-tests
  (test-suite
   ">? tests"
   (check-equal? (>? 0 0) #f)
   (check-equal? (>? 0 2) #f)
   (check-equal? (>? 2 0) #t)
   (check-equal? (>? 2 3) #f)
   (check-equal? (>? 4 3) #t)))

(define (>? a b)
  (cond
    [(zero? a) #f]
    [(zero? b) #t]
    [else (>? (sub1 a) (sub1 b))]))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 5.2

;; Lista Natural -> Lista
;; Devolve uma lista com os n primeiros elementos de lst.
;; Veja a função pré-definida take.
;;
;;                               n
;;                  |-------------------------
;;                  |      0     | (add1 ...)
;;     |------------|-------------------------
;;     |   empty    |            |  erro    
;; lst |------------|    empty   |------------
;;     | (cons ...) |            |  cons (first lst) + recursão natural
;;     |------------|------------|------------

(define take-tests
  (test-suite
   "take tests"
   (check-equal? (take empty 0) empty)
   (check-equal? (take (list 1 2 3) 0) empty)
   (check-exn exn:fail? (thunk (take empty 1)))
   (check-equal? (take (list 4 2 3) 1) (list 4))
   (check-equal? (take (list 4 2 5) 3) (list 4 2 5))
   (check-exn exn:fail? (thunk (take (list 4 2 5) 4)))))

(define (take lst n)
  (cond
    [(zero? n) empty]
    [(empty? lst) (error "Lista vazia")]
    [else (cons (first lst)
                (take (rest lst) (sub1 n)))]))
   

;;;;;;;;;;;;;;;;;;;;
;; Exercício 5.9

;; Lista Lista -> Lista
;; Faz a intercalação dos elementos de lsta e lstb.
;; Requer a ltsa e ltsb estejam em ordem não decrescente.
;;
;;                             lstb
;;                  |-------------------------
;;                  |   empty    | (cons ...)
;;     |------------|-------------------------
;;     |   empty    |           lstb
;;lsta |------------|-------------------------
;;     | (cons ...) |   ltsa     | cons menor entre (first ltsa) (first lstb)
;;     |            |            |      recursão natural
;;     |------------|------------|------------
;;
;; Observe que ao invés de juntar as celúlas na linha ltsa empty, poderíamos
;; juntar as células da coluna lstb empty.
(define merge-tests
  (test-suite
   "merge tests"
   (check-equal? (merge empty empty)
                 empty)
   (check-equal? (merge (list 1 2 3) empty)
                 (list 1 2 3))
   (check-equal? (merge empty (list 1 2 3))
                 (list 1 2 3))
   (check-equal? (merge (list 4 10 20) (list 1 2 6 8))
                 (list 1 2 4 6 8 10 20))
   (check-equal? (merge (list 1 2 6 8) (list 4 10 20))
                 (list 1 2 4 6 8 10 20))))

(define (merge lsta lstb)
  (cond
    [(empty? lsta) lstb]
    [(empty? lstb) lsta]
    [((first lsta) . < . (first lstb))
     (cons (first lsta)
           (merge (rest lsta) lstb))]
    [else
     (cons (first lstb)
           (merge lsta (rest lstb)))]))


;;;;;;;;;;;;;;;;;;;;
;; Funções para auxiliar nos testes

;; Teste ... -> Void
;; Executa um conjunto de testes.
(define (executa-testes . testes)
  (run-tests (test-suite "Todos os testes" testes))
  (void))

;; Chama a função para executar os testes.
(executa-testes >?-tests
                take-tests
                merge-tests)
