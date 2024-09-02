#lang racket

(require examples)

;; String -> String
;; Inverte os caracteres de s.
(examples
 (check-equal? (inverte "") "")
 (check-equal? (inverte "a") "a")
 (check-equal? (inverte "abc") "cba")
 (check-equal? (inverte "amor") "roma"))
(define (inverte s)
  (define slen (string-length s))
  (cond
    [(< slen 2)
     s]
    [else
     (define primeiro (substring s 0 1))
     (define ultimo (substring s (sub1 slen)))
     (string-append
      ultimo
      (inverte (substring s 1 (sub1 slen)))
      primeiro)]))
