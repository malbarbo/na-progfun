#lang racket

(require examples)

; Análise
;
; Determinar o ganho pela venda de sorvetes.
; - Cada sorvete é vendido por 10
; - São três sabores, cada um com um custo de produção
;   - manga (6)
;   - uva (7)
;   - morango (8)

; Tipos de dados
;
; O custo de produção e o ganho são representados por números positivos.
;
; O sabor do sorvete é representado por uma enumeração.
;
; Sabor é um dos valores
; - "manga"
; - "uva"
; - "morando"

; Constantes
(define PRECO_VENDA 10)
(define CUSTO_MANGA 6)
(define CUSTO_UVA 7)
(define CUSTO_MORANGO 8)

;; Lista(Sabores) -> Número
;;
;; Calcula o ganho pela venda dos sorvetes de lst, onde cada item de lst
;; é o sabor de um sorvete vendido.
(examples
  (check-equal? (ganho-venda-sorvetes empty) 0)
  (check-equal? (ganho-venda-sorvetes (list "manga")) 4) ; (+ 4 0)
  (check-equal? (ganho-venda-sorvetes (list "uva" "manga")) 7) ; (+ 3 4)
  (check-equal? (ganho-venda-sorvetes (list "morango" "uva" "manga")) 9) ; (+ 2 3 4)
  (check-equal? (ganho-venda-sorvetes (list "manga" "morango" "uva" "manga")) 13)) ; (+ 4 2 3 4))

(define (ganho-venda-sorvetes lst)
  ;; Sabor -> Número
  (define (ganho sabor)
    (cond
      [(equal? sabor "manga") (- PRECO_VENDA CUSTO_MANGA)]
      [(equal? sabor "uva") (- PRECO_VENDA CUSTO_UVA)]
      [(equal? sabor "morango") (- PRECO_VENDA CUSTO_MORANGO)]))
  (cond
    [(empty? lst) 0]
    [else
      (+ (ganho (first lst))
         (ganho-venda-sorvetes (rest lst)))]))
