#lang racket

(require examples)

(struct cartao (parcelas))
;; Representa o uso do cartão em um pagamento
;; parcelas: Número - o número de parcelas, deve estar entre 1 e 12

;; FormaPagamento é um dos valores
;; - "dinheiro"
;; - "pix"
;; - "boleto"
;; - (cartao parcelas)

;; Número FormaPagamento -> Número
;; Calcula o valor final da compra com o valor especificado considerando
;; a forma-pagamento da seguinte maneira:
;; - dinheiro ou pix, 10% de desconto
;; - boleto; 5% de desconto
;; - cartão em até 3 vezes (inclusive); sem desconto
;; - cartão em mais que 3 vezes; acréscimo de 15%
(examples
 (check-equal? (valor-final-compra 100.0 "dinheiro")
               (* 100.0 0.9))
 (check-equal? (valor-final-compra 200.0 "pix")
               (* 200.0 0.9))
 (check-equal? (valor-final-compra 300.0 "boleto")
               (* 300.0 0.95))
 (check-equal? (valor-final-compra 100.0 (cartao 1))
               100.0)
 (check-equal? (valor-final-compra 100.0 (cartao 3))
               100.0)
 (check-equal? (valor-final-compra 200.0 (cartao 4))
               (* 200.0 1.15)))

(define (valor-final-compra valor forma-pagamento)
  (cond
    ; o and não é necessário, está aqui apenas como recurso pedagógico
    ; dinheiro ou pix
    [(and (string? forma-pagamento)
          (or (equal? forma-pagamento "dinheiro")
              (equal? forma-pagamento "pix")))
     (* valor 0.9)] ; 10% de desconto
    ; boleto
    [(and (string? forma-pagamento)
          (equal? forma-pagamento "boleto"))
     (* valor 0.95)] ; 5% de desconto
    ; cartão mais que 3 parcelas
    [(and (cartao? forma-pagamento)
          (> (cartao-parcelas forma-pagamento) 3))
     (* valor 1.15)] ; 15% de acréscimo
    ; cartão até três parcelas (inclusive)
    [else valor]))
