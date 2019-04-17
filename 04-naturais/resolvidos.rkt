#lang racket

(require rackunit)
(require rackunit/text-ui)

;;;;;;;;;;;;;;;;;;;;
;; Exercício 4.3

;; Natural -> Boolean
;; Devolve #t se a é par, #f caso contrário.
;; Veja a função pré-defina even?
(define par?-tests
  (test-suite
   "par? tests"
   (check-equal? (par? 0) #t)
   (check-equal? (par? 1) #f)
   (check-equal? (par? 2) #t)
   (check-equal? (par? 3) #f)
   (check-equal? (par? 4) #t)))

(define (par? a)
  (if (zero? a)
      #t
      (impar? (sub1 a))))

;; Natural -> Boolean
;; Devolve #t se a é ímpar, #f caso contrário.
;; Veja a função pré-defina odd?
(define impar?-tests
  (test-suite
   "impar? tests"
   (check-equal? (impar? 0) #f)
   (check-equal? (impar? 1) #t)
   (check-equal? (impar? 2) #f)
   (check-equal? (impar? 3) #t)
   (check-equal? (impar? 4) #f)))

(define (impar? a)
  (if (zero? a)
      #f
      (par? (sub1 a))))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 4.4

;; Natural -> Boolean
;; Devolve #t se n é um número perfeito, #f caso contrário. Um número natural
;; é perfeito se a soma dos seus divisores (menos ele mesmo) é igual ao número.
(define perfeito?-tests
  (test-suite
   "perfeito? tests"
   (check-equal? (perfeito? 1) #f)
   (check-equal? (perfeito? 2) #f)
   (check-equal? (perfeito? 3) #f)
   (check-equal? (perfeito? 4) #f)
   (check-equal? (perfeito? 5) #f)
   (check-equal? (perfeito? 6) #t) ; 6 = 1 + 2 + 3
   (check-equal? (perfeito? 27) #f)
   (check-equal? (perfeito? 28) #t); 28 = 1 + 2 + 4 + 7 + 14
   (check-equal? (perfeito? 29) #f)))

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
    [(divisivel? n d) (+ d (soma-divisores n (sub1 d)))]
    [else (soma-divisores n (sub1 d))]))

;; Natural Natural -> Boolean
;; Devolve #t se n é divisível por d, #f caso contrário.
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
