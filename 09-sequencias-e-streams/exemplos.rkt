#lang racket

(require rackunit)
(require rackunit/text-ui)

;; Exemplo 8.1

;; Inteiro -> Stream(Inteiro)
;; Cria um stream com os inteiros a partir de n.
(define inteiros-tests
  (test-suite
   "inteiros tests"
   (check-equal? (stream-ref (inteiros 5) 0) 5)
   (check-equal? (stream-ref (inteiros 5) 1) 6)
   (check-equal? (stream-ref (inteiros 5) 2) 7)
   (check-equal? (stream-ref (inteiros 5) 3) 8)))

(define (inteiros n)
  (stream-cons n (inteiros (add1 n))))

;; Exemplo 8.2

;; Stream, Natural -> Stream
;; Cria um stream com os primeiro n elementos de s.
(define stream-take-tests
  (test-suite
   "stream-take tests"
   (check-equal? (stream->list
                  (stream-take (stream 1 2 3) 0))
                 empty)
   ;; testa a geração de erro
   (check-exn exn:fail? (thunk (stream->list
                                (stream-take (stream 1 2 3) 4))))
   (check-equal? (stream->list
                  (stream-take (stream 2 1 3 5 9 10) 5))
                 (list 2 1 3 5 9))))

(define (stream-take s n)
  (cond
    [(zero? n) empty-stream]
    [(stream-empty? s) (error "Índice maior que o tamanho do stream")]
    [else
     (stream-cons (stream-first s)
                  (stream-take (stream-rest s) (sub1 n)))]))

;; Exemplo 8.3

;; Stream(Número) Stream(Número) -> Stream(Número)
;; Devolve um stream em que cada elemento é soma dos elementos
;; na mesma posição de s1 e s2.
(define stream-soma-tests
  (test-suite
   "stream-soma tests"
   (check-equal? (stream->list
                  (stream-soma empty-stream
                               empty-stream))
                 empty)
   (check-equal? (stream->list
                  (stream-soma (stream 1 2 3)
                               (stream 4 5 6)))
                 (list 5 7 9))
   ;; testa a geração de erro
   (check-exn exn:fail? (thunk
                         (stream->list
                          (stream-soma (stream 1 2) (stream 2)))))))

(define (stream-soma s1 s2)
  (cond
    [(and (stream-empty? s1) (stream-empty? s2))
     empty-stream]
    [(or (stream-empty? s1) (stream-empty? s2))
     (error "Streams de tamanhos diferentes")]
    [else
     (stream-cons (+ (stream-first s1)
                     (stream-first s2))
                  (stream-soma (stream-rest s1)
                               (stream-rest s2)))]))


;; ---------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;
;; Funções para auxiliar nos testes

;; Teste ... -> Void
;; Executa um conjunto de testes.
(define (executa-testes . testes)
  (run-tests (test-suite "Todos os testes" testes))
  (void))

;; Chama a função para executar os testes.
(executa-testes inteiros-tests
                stream-take-tests
                stream-soma-tests)
