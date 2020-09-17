#lang racket

(require rackunit)
(require rackunit/text-ui)

;;;;;;;;;;;;;;;;;;;;
;; Exemplo 5.1

;; Lista Lista -> Boolean
;; Devolve #t se lsta é prefixo de lstb. #f caso contrário.
;;
;; É interessante deixar a tabela no código
;;
;;                              lstb
;;                   +-------------------------------+
;;                   |   empty    | (cons ...)       |
;;      +------------+-------------------------------+
;;      |   empty    |           #t                  |
;; lsta +------------+------------+------------------+
;;      | (cons ...) |      #f    | primeiros iguais |
;;      |            |            | recursão natural |
;;      +------------+------------+------------------+
(define prefixo?-tests
  (test-suite
   "prefixo? tests"
   (check-equal? (prefixo? empty empty) #t)
   (check-equal? (prefixo? empty (list 3 4)) #t)
   (check-equal? (prefixo? (list 3 4) empty) #f)
   (check-equal? (prefixo? (list 3 4) (list 3 4)) #t)
   (check-equal? (prefixo? (list 3 4) (list 3 5)) #f)
   (check-equal? (prefixo? (list 3 4) (list 3 4 6 8)) #t)
   (check-equal? (prefixo? (list 3 5) (list 3 4 6 8)) #f)
   (check-equal? (prefixo? (list 3 4 5) (list 3 4)) #f)))

(define (prefixo? lsta lstb)
  (cond
    [(empty? lsta) #t]
    [(empty? lstb) #f]
    [else
     (and (equal? (first lsta)
                  (first lstb))
          (prefixo? (rest lsta) (rest lstb)))]))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 5.2

;; Lista Natural -> Qualquer
;; Devolve o elemento na posição k da lista.
;; O primeiro elemento está na posição 0.
;;
;;                               k
;;                  +------------+-------------------+
;;                  |      0     | (add1 ...)        |
;;     +------------+------------+-------------------+
;;     |   empty    |              erro              |
;; lst +------------+------------+-------------------+
;;     | (cons ...) |(first lst) |  recursão natural |
;;     +------------+------------+-------------------+
(define lista-ref-tests
  (test-suite
   "lista-ref tests"
   (check-exn exn:fail? (thunk (lista-ref empty 0)))
   (check-exn exn:fail? (thunk (lista-ref empty 2)))
   (check-equal? (lista-ref (list 3 2 8) 0) 3)
   (check-equal? (lista-ref (list 3 2 8 10) 2) 8)
   (check-exn exn:fail? (thunk (lista-ref (list 3 2 8 10) 4)))))

(define (lista-ref lst k)
  (cond
    [(empty? lst) (error "Lista vazia")]
    [(zero? k) (first lst)]
    [else (lista-ref (rest lst) (sub1 k))]))


;;;;;;;;;;;;;;;;;;;;
;; Funções para auxiliar nos testes

;; Teste ... -> Void
;; Executa um conjunto de testes.
(define (executa-testes . testes)
  (run-tests (test-suite "Todos os testes" testes))
  (void))

;; Chama a função para executar os testes.
(executa-testes prefixo?-tests
                lista-ref-tests)
