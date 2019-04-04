#lang racket

(require rackunit)
(require rackunit/text-ui)

;;;;;;;;;;;;;;;;;;;;
;; Exemplo 2.1

;; Número -> Número
;; Produz o dobro de n.
(define dobro-tests
  (test-suite
   "dobro tests"
   (check-equal? (dobro 0) 0)
   (check-equal? (dobro 4) 8)
   (check-equal? (dobro -2) -4)))

(define (dobro n)
  (* 2 n))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 2.2

;; Natural -> Boolean
;; Devolve #t se n é par, #f caso contrário.
;; Veja as funções pré-definidas even? e odd?
(define par?-tests
  (test-suite
   "par? tests"
   (check-equal? (par? 2) #t)
   (check-equal? (par? 8) #t)
   (check-equal? (par? 9) #f)))

(define (par? n)
  (= (remainder n 2) 0))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 2.3

;; String String -> String
;; Devolve a maior palavra entre a e b. Se a e b tem o mesmo tamanho,
;; devolve a.
(define maior-palavra-tests
  (test-suite
   "maior-palavra tests"
   (check-equal? (maior-palavra "sorte" "casa") "sorte")
   (check-equal? (maior-palavra "racket" "palavra") "palavra")
   (check-equal? (maior-palavra "racket" "coisas") "racket")))

(define (maior-palavra a b)
  (if (>= (string-length a)
          (string-length b))
      a
      b))

;;;;;;;;;;;;;;;;;;;;
;; Funções para auxiliar nos testes

;; Teste ... -> Void
;; Executa um conjunto de testes.
(define (executa-testes . testes)
  (run-tests (test-suite "Todos os testes" testes))
  (void))

;; Chama a função para executar os testes.
(executa-testes dobro-tests
                par?-tests
                maior-palavra-tests)
