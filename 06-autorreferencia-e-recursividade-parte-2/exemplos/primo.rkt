#lang racket

(require examples)

;; Natural -> Boolean
;;
;; Produz #t se n é um número primo, isto é, tem exatamente dois divisores distintos (1 e n).
;; Produz #f caso contrário.

(examples
 (check-equal? (primo? 1) #f)
 (check-equal? (primo? 2) #t)
 (check-equal? (primo? 3) #t)
 (check-equal? (primo? 4) #f)
 (check-equal? (primo? 5) #t)
 (check-equal? (primo? 6) #f)
 (check-equal? (primo? 7) #t)
 (check-equal? (primo? 8) #f))

(define (primo? n)
  ;; Natural Natural -> Natural
  ;; Calcula o número de divirores de n que são <= a.
  (define (num-divisores n a)
    (cond
      [(zero? a) 0]
      [(= (remainder n a) 0) (add1 (num-divisores n (sub1 a)))]
      [else (num-divisores n (sub1 a))]))

  (= (num-divisores n n) 2))
