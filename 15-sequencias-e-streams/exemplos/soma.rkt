#lang racket

(require examples)

(examples
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
                        (stream-soma (stream 1 2) (stream 2))))))

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
