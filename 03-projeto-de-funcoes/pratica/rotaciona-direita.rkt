#lang racket

(require examples)

; Análise
;
; Rotacionar uma string a direita n caracteres, isto é, mover
; os últimos n caracteres para o início da string.
;
; Como chegamos nessa especificação a partir da análise?
; Se você tem interesse em saber, pergunte em sala!

;; String Inteiro -> Inteiro
;;
;; Produz uma string movendo os últimos n caracteres de s para o início de
;; s. Se n é maior do que a quantidade de caracteres de s ou é um valor
;; negativo, então rotaciona (modulo n (string-lenghth s)) caracteres.

(examples
  (check-equal? (rotaciona-direita "marcelio" 5) "celiomar")
  (check-equal? (rotaciona-direita "abc" 0) "abc")
  (check-equal? (rotaciona-direita "abc" 1) "cab")
  (check-equal? (rotaciona-direita "abc" 2) "bca")
  (check-equal? (rotaciona-direita "abc" 3) "abc")
  (check-equal? (rotaciona-direita "abc" -1) "bca")
  (check-equal? (rotaciona-direita "abc" -2) "cab")
  (check-equal? (rotaciona-direita "abc" -3) "abc"))

(define (rotaciona-direita s n)
    (define div (- (string-length s)
                   (modulo n (string-length s))))
    (string-append (substring s div)
                   (substring s 0 div)))
