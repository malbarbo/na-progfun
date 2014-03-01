#lang racket

(require rackunit)
(require rackunit/text-ui)

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
(define soma-tests
  (test-suite
   "soma tests"
   (check-equal? (soma 0) 0)
   (check-equal? (soma 1) 1)
   (check-equal? (soma 3) 6))) ; (+ 3 2 1 0)

(define (soma n)
  (cond
    [(zero? n) 0]
    [else (+ n
             (soma (sub1 n)))]))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 4.2

;; Natural -> Lista
;; Devolve a lista (cons n (cons n-1 ... (cons 1 empty)...)).
(define cria-lista-tests
  (test-suite
   "cria-lista tests"
   (check-equal? (cria-lista 0) empty)
   (check-equal? (cria-lista 1) (cons 1 empty))
   (check-equal? (cria-lista 3) (cons 3
                                      (cons 2
                                            (cons 1 empty))))))

(define (cria-lista n)
  (cond
    [(zero? n) empty]
    [else (cons n
                (cria-lista (sub1 n)))]))

;;;;;;;;;;;;;;;;;;;;
;; Exemplo 4.3

;; Natural Inteiro>=1 -> Boolean
;; Devolve true se x tem divisor entre 2 (inclusive) e i (inclusive).
;; False caso contrário.
(define tem-divisor-entre-2-i?-tests
  (test-suite
   "tem-divisor-entre-2-i? tests"
   (check-equal? (tem-divisor-entre-2-i? 5 1) #f)
   (check-equal? (tem-divisor-entre-2-i? 2 2) #t)
   (check-equal? (tem-divisor-entre-2-i? 5 5) #t)
   (check-equal? (tem-divisor-entre-2-i? 10 5) #t)
   (check-equal? (tem-divisor-entre-2-i? 8 7) #t)
   (check-equal? (tem-divisor-entre-2-i? 9 2) #f)))

(define (tem-divisor-entre-2-i? x i)
  (cond
    [(<= i 1) false]
    [else
     (or (divisivel? x i)
         (tem-divisor-entre-2-i? x (sub1 i)))]))

;; Natural Natural -> Boolean
;; Devolve true se x é divisível por i. false caso contrário.
(define (divisivel? x i)
  (zero? (remainder x i)))

(define primo?-tests
  (test-suite
   "primo? tests"
   (check-equal? (primo? 2) true)
   (check-equal? (primo? 3) true)
   (check-equal? (primo? 4) false)
   (check-equal? (primo? 5) true)
   (check-equal? (primo? 6) false)
   (check-equal? (primo? 7) true)
   (check-equal? (primo? 8) false)
   (check-equal? (primo? 9) false)))

;; Natural -> Boolean
;; Devolve true se n é primo. false caso contrário.
(define (primo? n)
  (not (tem-divisor-entre-2-i? n (sub1 n))))

;;;;;;;;;;;;;;;;;;;;
;; Funções para auxiliar nos testes

;; Teste ... -> Void
;; Executa um conjunto de testes.
(define (executa-testes . testes)
  (run-tests (test-suite "Todos os testes" testes))
  (void))

;; Chama a função para executar os testes.
(executa-testes soma-tests
                cria-lista-tests
                tem-divisor-entre-2-i?-tests
                primo?-tests)
