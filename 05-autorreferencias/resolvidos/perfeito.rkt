#lang racket

(require examples)

;; Natural -> Boolean
;; Devolve #t se n é um número perfeito, #f caso contrário. Um número natural
;; é perfeito se a soma dos seus divisores (menos ele mesmo) é igual ao número.
(examples
 (check-equal? (perfeito? 1) #f)
 (check-equal? (perfeito? 2) #f)
 (check-equal? (perfeito? 3) #f)
 (check-equal? (perfeito? 4) #f)
 (check-equal? (perfeito? 5) #f)
 (check-equal? (perfeito? 6) #t) ; 6 = 1 + 2 + 3
 (check-equal? (perfeito? 27) #f)
 (check-equal? (perfeito? 28) #t); 28 = 1 + 2 + 4 + 7 + 14
 (check-equal? (perfeito? 29) #f))

(define (perfeito? n)
  (= n (soma-divisores n (sub1 n))))


;; Natural -> Natural
;; Soma os divisores de n no intervalo [1, d].
(examples
 (check-equal? (soma-divisores 7 1) 1)
 (check-equal? (soma-divisores 7 0) 0)
 (check-equal? (soma-divisores 4 4) 7)   ; 4 + 2 + 1
 (check-equal? (soma-divisores 10 9) 8)) ; 5 + 2 + 1

(define (soma-divisores n d)
  (cond
    [(zero? d) 0]
    [(divisivel? n d) (+ d (soma-divisores n (sub1 d)))]
    [else (soma-divisores n (sub1 d))]))

;; Natural Natural -> Boolean
;; Devolve #t se n é divisível por d, #f caso contrário.
(examples
  (check-equal? (divisivel? 10 2) #t)
  (check-equal? (divisivel? 10 3) #f)
  (check-equal? (divisivel? 5 5) #t))

(define (divisivel? n d)
  (= (remainder n d) 0))
