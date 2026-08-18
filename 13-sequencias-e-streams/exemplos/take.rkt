#lang racket

(require examples)

;; Stream, Natural -> Stream
;; Cria um stream com os primeiro n elementos de s.
(examples
 (check-equal? (stream->list
                (stream-take (stream 1 2 3) 0))
               empty)
 ;; testa a geração de erro
 (check-exn exn:fail? (thunk (stream->list
                              (stream-take (stream 1 2 3) 4))))
 (check-equal? (stream->list
                (stream-take (stream 2 1 3 5 9 10) 5))
               (list 2 1 3 5 9)))

(define (stream-take s n)
  (cond
    [(zero? n) empty-stream]
    [(stream-empty? s) (error "Índice maior que o tamanho do stream")]
    [else
     (stream-cons (stream-first s)
                  (stream-take (stream-rest s) (sub1 n)))]))
