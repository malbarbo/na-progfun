#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Natural
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Um número Natural é:
;; - 0; ou
;; - (add1 n), onde n é um número Natural
;;
;; Modelo
#;
(define (fn-para-natural n)
  (cond
    [(zero? n) ...]
    [else
     (... n
          (fun-for-natural (sub1 n)))]))


;; Natural -> Natural
;;
;; Devolve a soma 1 + 2 + ... + n.

(examples
 (check-equal? (soma-nat 0) 0)
 (check-equal? (soma-nat 1) 1)
 (check-equal? (soma-nat 3) 6)) ; (+ 3 2 1 0)

(define (soma-nat n)
  (cond
    [(zero? n) 0]
    [else
     (+ n
        (soma-nat (sub1 n)))]))