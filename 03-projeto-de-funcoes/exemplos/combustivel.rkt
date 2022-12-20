#lang racket

(require examples)

;;;;;;;
;; Tipos de dados

;; Preco é um número positivo com três casas decimais.

;; Combustivel é um dos valores
;; - "Alcool"
;; - "Gasolina"

;;;;;;;
;; Funções

;; Preco Preco -> Combustivel
;;
;; Encontra o combustivel que deve ser utilizado no abastecimentos.
;; Produz "Alcool" se preco-alcool menor ou igual a 70% do preco-gasolina,
;; produz "Gasolina" caso contrário.
(examples
 ; (<= preco-alcool preco-gasolina)
 (check-equal? (seleciona-combustivel 3.000 4.000) "Gasolina")
 (check-equal? (seleciona-combustivel 2.900 4.200) "Alcool")
 ; (> preco-alcool preco-gasolina)
 (check-equal? (seleciona-combustivel 3.500 5.000) "Alcool"))

(define (seleciona-combustivel preco-alcool preco-gasolina)
  (if (<= preco-alcool (* 0.7 preco-gasolina))
      "Alcool"
      "Gasolina"))
