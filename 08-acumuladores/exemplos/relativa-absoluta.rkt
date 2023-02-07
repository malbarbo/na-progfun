#lang racket

(require examples)

;; Lista(Número) -> Lista(Número)
;; Converte uma lista de distâncias relaticas para uma lista de distâncias
;; absolutas. O primeito item da lista representa a distância da origem.

(examples
 (check-equal? (relativa->absoluta empty) empty)
 (check-equal? (relativa->absoluta (list 50 40 70 30 30))
               (list 50 90 160 190 220)))

;; Definição sem uso de acumulador
#;
(define (relativa->absoluta lst)
  (cond
    [(empty? lst) empty]
    [else
     (cons (first lst)
           (map (curry + (first lst))
                (relativa->absoluta (rest lst))))]))

;; Definição usando acumulador
(define (relativa->absoluta lst0)
  ;; acc-dist é a distância absoluta do item que estava antes do
  ;; primeiro elemento de lst.
  (define (iter lst acc-dist)
    (cond
      [(empty? lst) empty]
      [else
       (cons (+ (first lst) acc-dist)
             (iter (rest lst)
                   (+ (first lst) acc-dist)))]))
  (iter lst0 0))
