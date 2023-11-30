#lang racket

(require examples)

;; Tamanho é um dos valores
;; - "curto"
;; - "médio"
;; - "longo"

;; String -> Tamanho
;;
;; Classifica nome de acordo com a quantidade de caracteres da seguinte forma
;; - "curto" para nomes com 4 ou menos caracteres
;; - "longo" para nomes com 10 ou mais caracteres
;; - "médio" para nomes que não são "curto" e nem "longo"

(examples
  (check-equal? (tamanho-nome "Zé") "curto")
  (check-equal? (tamanho-nome "José") "curto")
  (check-equal? (tamanho-nome "Maria") "médio")
  (check-equal? (tamanho-nome "Sebastiana") "médio")
  (check-equal? (tamanho-nome "Constantino") "longo"))

(define (tamanho-nome nome)
  (cond
    [(<= (string-length nome) 4) "curto"]
    [(<= (string-length nome) 10) "médio"]
    [else "longo"]))
