#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vamos criar uma função que abstrai o comportamento das funções contem-5? e
;; contem-3?.

;; Lista(Número) -> Boolean
;; Devolve #t se 5 está em lst, #f caso contrário.
(examples
 (check-equal? (contem-5? empty) #f)
 (check-equal? (contem-5? (list 3)) #f)
 (check-equal? (contem-5? (list 5)) #t)
 (check-equal? (contem-5? (list 3 -4 5 9 10)) #t)
 (check-equal? (contem-5? (list 2 -5 -2)) #f))

;; Implementação inicial da função contem-5?
#;
(define (contem-5? lst)
  (cond
    [(empty? lst) #f]
    [(= 5 (first lst)) #t]
    [else (contem-5? (rest lst))]))

;; Lista(Número) -> Boolean
;; Devolve #t se 3 está em lst, #f caso contrário.
(examples
 (check-equal? (contem-3? empty) #f)
 (check-equal? (contem-3? (list 3)) #t)
 (check-equal? (contem-3? (list 5)) #f)
 (check-equal? (contem-3? (list 3 -4 5 9 10)) #t)
 (check-equal? (contem-3? (list 2 -5 -2)) #f))

;; Implementação inicial da função contem-3?
#;
(define (contem-3? lst)
  (cond
    [(empty? lst) #f]
    [(= 3 (first lst)) #t]
    [else (contem-3? (rest lst))]))

;; Olhando para o corpo das funções contem-5? e contem-3? observamos que a
;; única diferença é a ocorrência do valor 5 e 3.
;;
;; Vamos abstrair estas duas funções e criar a função contem? que além da
;; lista, recebe como parâmetro n, que será usado no lugar do 5 ou 3.
;;
;; Em seguida vamos reescrever as funções contem-5? e contem-3? em termos da
;; função contem?.

;; Número Lista(Número) -> Boolean
;; Devolve #t se n está em lst, #f caso contrário.
(examples
 (check-equal? (contem? 3 empty) #f)
 (check-equal? (contem? 3 (list 3)) #t)
 (check-equal? (contem? 8 (list 5)) #f)
 (check-equal? (contem? 5 (list 3 -4 5 9 10)) #t)
 (check-equal? (contem? 5 (list 2 -5 -2)) #f))

(define (contem? n lst)
  (cond
    [(empty? lst) #f]
    [(= n (first lst)) #t]
    [else (contem? n (rest lst))]))

;; Função contem-5? escrita em termos da função contem?
(define (contem-5? lst)
  (contem? 5 lst))

;; Função contem-3? escrita em termos da função contem?
(define (contem-3? lst)
  (contem? 3 lst))
