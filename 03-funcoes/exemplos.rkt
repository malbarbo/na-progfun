#lang racket

(require examples)

;; Número -> Número
;; Produz o dobro de n.
(examples
 (check-equal? (dobro 0) 0)
 (check-equal? (dobro 4) 8)
 (check-equal? (dobro -2) -4))

(define (dobro n)
  (* 2 n))


;; Natural -> Boolean
;; Devolve #t se n é par, #f caso contrário.
;; Veja as funções pré-definidas even? e odd?
(examples
 (check-equal? (par? 2) #t)
 (check-equal? (par? 8) #t)
 (check-equal? (par? 9) #f))

(define (par? n)
  (= (remainder n 2) 0))


;; String String -> String
;; Devolve a maior palavra entre a e b. Se a e b tem o mesmo tamanho,
;; devolve a.
(examples
 (check-equal? (maior-palavra "sorte" "casa") "sorte")
 (check-equal? (maior-palavra "racket" "palavra") "palavra")
 (check-equal? (maior-palavra "racket" "coisas") "racket"))

(define (maior-palavra a b)
  (if (>= (string-length a)
          (string-length b))
      a
      b))
