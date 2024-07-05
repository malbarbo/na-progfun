#lang racket

(require examples)

;; Lista -> Booleano
;;
;; Produz #t se lst é palindromo, isto é, tem os mesmos elementos
;; quando lida da direita para esquerda e da esquerda para direita.
;; Produz #f caso contrário.

(examples
 (check-equal? (palindromo? empty) #t)
 (check-equal? (palindromo? (list 2)) #t)
 (check-equal? (palindromo? (list 1 2)) #f)
 (check-equal? (palindromo? (list 3 3)) #t)
 (check-equal? (palindromo? (list 3 7 3)) #t)
 (check-equal? (palindromo? (list 3 7 3 3)) #f))

(define (palindromo? lst)
  ;; Lista -> Lista
  ;; Devolve uma lista que é como lst mas sem o último elemento.
  ;; Requer que lst seja não vazia
  (define (sem-ultimo lst)
    (cond
     [(empty? (rest lst)) empty]
     [else
       (cons (first lst)
             (sem-ultimo (rest lst)))]))

  ;; Lista -> Lista
  ;; Devolve uma lista que é como lst mas sem o primero e último elemento.
  ;; Requer que lst tenha pelo menos dois elementos
  (define (sem-extremos lst)
    (rest (sem-ultimo lst)))

  (cond
    [(empty? lst) #t]
    [(empty? (rest lst)) #t]
    [else
      (and (equal? (first lst) (last lst))
           (palindromo? (sem-extremos lst)))]))


;; Lista -> Booleano
;;
;; Produz #t se lst é palindromo, isto é, tem os mesmos elementos
;; quando lida da direita para esquerda e da esquerda para direita.
;; Produz #f caso contrário.

(examples
 (check-equal? (palindromo2? empty) #t)
 (check-equal? (palindromo2? (list 2)) #t)
 (check-equal? (palindromo2? (list 1 2)) #f)
 (check-equal? (palindromo2? (list 3 3)) #t)
 (check-equal? (palindromo2? (list 3 7 3)) #t)
 (check-equal? (palindromo2? (list 3 7 3 3)) #f))

(define (palindromo2? lst)
  (equal? lst (reverse lst)))
