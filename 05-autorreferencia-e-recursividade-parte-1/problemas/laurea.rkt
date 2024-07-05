#lang racket

(require examples)

; Análise
;
; Determinar se uma aluno receberá Láurea Acadêmica.
;
; - É necessário que 2/3 das notas sejam maiores que 9,0 para receber a Láurea

; Tipos de dados
;
; - Nota é representado por um número entre 0 e 10

;; Lista(Nota) -> Bool
;;
;; Produz #t se um aluno com as notas (parâmetro) deve receber a
;; Láurea Acadêmica, #f caso contrário.
;;
;; Para receber a Láurea pelo menos 2/3 das notas deve ser maior do 9,0.
;; Se notas for vazia, devolve #f.

(examples
  (check-equal? (laureado? empty) #f)
  (check-equal? (laureado? (list 9.2)) #t)
  (check-equal? (laureado? (list 8.2)) #f)
  (check-equal? (laureado? (list 7.5 9.2)) #f)
  (check-equal? (laureado? (list 9.0 10.0)) #t)
  (check-equal? (laureado? (list 9.0 8.0 9.4)) #t)
  (check-equal? (laureado? (list 9.0 8.0 8.9)) #f)
  (check-equal? (laureado? (list 9.0 8.0 8.9)) #f)
  (check-equal? (laureado? (list 9.0 9.1 8.0 8.9 10.0)) #f) ; 2/3 de 5 é 4...
  (check-equal? (laureado? (list 9.0 9.1 8.0 8.9 10.0 9.6)) #t)) ; 2/3 de 6 é 4.

(define (laureado? notas)
  (define (conta>=9 notas)
    (cond
      [(empty? notas) 0]
      [(>= (first notas) 9) (add1 (conta>=9 (rest notas)))]
      [else (conta>=9 (rest notas))]))
  ; Contar as notas >= 9 e depois verificar se é pelo menos 2/3 das notas
  (define num-notas (length notas))
  (define num>=9 (conta>=9 notas))
  (and (> num-notas 0) ; sem notas, sem Láurea
       (>= num>=9 (* num-notas 2/3))))
