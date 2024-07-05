#lang racket

(require examples)

;; Natural -> Boolean
;; Devolve #t se a é par, #f caso contrário.
;; Veja a função pré-defina even?
(examples
 (check-equal? (par? 0) #t)
 (check-equal? (par? 1) #f)
 (check-equal? (par? 2) #t)
 (check-equal? (par? 3) #f)
 (check-equal? (par? 4) #t))

(define (par? a)
  ;; FIXME: simplifique a função.
  (if (zero? a)
      #t
      (impar? (sub1 a))))

;; Natural -> Boolean
;; Devolve #t se a é ímpar, #f caso contrário.
;; Veja a função pré-defina odd?
(examples
 (check-equal? (impar? 0) #f)
 (check-equal? (impar? 1) #t)
 (check-equal? (impar? 2) #f)
 (check-equal? (impar? 3) #t)
 (check-equal? (impar? 4) #f))

(define (impar? a)
  ;; FIXME: simplifique a função.
  (if (zero? a)
      #f
      (par? (sub1 a))))
