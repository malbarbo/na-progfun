#lang racket

(require rackunit)
(require rackunit/text-ui)

;;;;;;;;;;;;;;;;;;;;
;; Exercício 4.2

;; Natural -> Boolean
;; Devolve true se a é par, falso caso contrário.
;; Veja a função pré-defina even?
(define par?-tests
  (test-suite
   "par? tests"
   (check-true (par? 0))
   (check-false (par? 1))
   (check-true (par? 2))
   (check-false (par? 3))
   (check-true (par? 4))))

(define (par? a)
  (if (zero? a)
      #t
      (impar? (sub1 a))))

;; Natural -> Boolean
;; Devolve true se a é ímpar, false caso contrário.
; Veja a função pré-defina odd?
(define impar?-tests
  (test-suite
   "impar? tests"
   (check-false (impar? 0))
   (check-true (impar? 1))
   (check-false (impar? 2))
   (check-true (impar? 3))
   (check-false (impar? 4))))

(define (impar? a)
  (if (zero? a)
      #f
      (par? (sub1 a))))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 4.4

;; Natural -> Boolean
;; Devolve true se n é um número perfeito, falso caso contrário.  Um número
;; natural é perfeito se a soma dos seus divisores (menos ele mesmo) é igual ao
;; número.
(define perfeito?-tests
  (test-suite
   "perfeito? tests"
   (check-false (perfeito? 1))
   (check-false (perfeito? 2))
   (check-false (perfeito? 3))
   (check-false (perfeito? 4))
   (check-false (perfeito? 5))
   (check-true (perfeito? 6)) ; 6 = 1 + 2 + 3
   (check-false (perfeito? 27))
   (check-true (perfeito? 28)); 28 = 1 + 2 + 4 + 7 + 14
   (check-false (perfeito? 29))))

(define (perfeito? n)
  (= n (soma-divisores n (sub1 n))))

;; Natural -> Natural
;; Soma os divisores de n no intervalo [1, d].
(define soma-divisores-tests
  (test-suite
   "soma-divisores tests"
   (check-equal? (soma-divisores 7 1) 1)
   (check-equal? (soma-divisores 7 0) 0)
   (check-equal? (soma-divisores 4 4) 7)    ; 4 + 2 + 1
   (check-equal? (soma-divisores 10 9) 8))) ; 5 + 2 + 1

(define (soma-divisores n d)
  (cond
    [(zero? d) 0]
    [else
     (cond
       [(divisivel? n d) (+ d (soma-divisores n (sub1 d)))]
       [else (soma-divisores n (sub1 d))])]))

;; Natural Natural -> Boolean
;; Devolve true se n é divisível por d, false caso contrário.
(define (divisivel? n d)
  (= (remainder n d) 0))


;;;;;;;;;;;;;;;;;;;;
;; Funções para auxiliar nos testes

;; Teste ... -> Void
;; Executa um conjunto de testes.
(define (executa-testes . testes)
  (run-tests (test-suite "Todos os testes" testes))
  (void))

;; Chama a função para executar os testes.
(executa-testes par?-tests
                impar?-tests
                perfeito?-tests
                soma-divisores-tests)
