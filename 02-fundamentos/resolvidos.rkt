#lang racket

(require rackunit)
(require rackunit/text-ui)

;;;;;;;;;;;;;;;;;;;;
;; Exercício 2.6

;; Número Número -> Número
;; Devolve o maior valor entre a e b. Se os valores forem iguais, devolve a.
;; Veja a função pré-definida max.
(define maximo-tests
  (test-suite
   "maximo tests"
   (check-equal? (maximo 2 3) 3)
   (check-equal? (maximo 5 3) 5)
   (check-equal? (maximo 4 4) 4)))
   
(define (maximo a b)
  (if (>= a b) a b))


;;;;;;;;;;;;;;;;;;;;
;; Exercício 2.7

;; Número Número -> Número
;; Calcula a soma dos quadrados dos dois maiores números entre a b c.
(define soma-quadrado-maiores-tests
  (test-suite
   "soma-quadrado-maiores tests"
   (check-equal? (soma-quadrado-maiores 3 4 5) 41)  ; 16 + 25
   (check-equal? (soma-quadrado-maiores 3 6 5) 61)  ; 36 + 25
   (check-equal? (soma-quadrado-maiores 6 5 4) 61)  ; 36 + 25
   (check-equal? (soma-quadrado-maiores 4 6 2) 52)  ; 16 + 36
   (check-equal? (soma-quadrado-maiores 6 2 4) 52)  ; 36 + 16
   (check-equal? (soma-quadrado-maiores 5 1 2) 29))); 25 + 4

(define (soma-quadrado-maiores a b c)
  (if (> a b)
      (+ (quadrado a)
         (quadrado (maximo b c)))
      (+ (quadrado b)
         (quadrado (maximo a c)))))

;; Veja a função pré-definida sqr.
(define (quadrado a)
  (* a a))


;;;;;;;;;;;;;;;;;;;;
;; Funções para auxiliar nos testes

;; Teste ... -> Void
;; Executa um conjunto de testes.
(define (executa-testes . testes)
  (run-tests (test-suite "Todos os testes" testes))
  (void))

;; Chama a função para executar os testes.
(executa-testes maximo-tests
                soma-quadrado-maiores-tests)
