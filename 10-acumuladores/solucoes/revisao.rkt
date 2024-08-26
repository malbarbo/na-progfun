#lang racket

(require examples)

;; Lista(String) -> String
;; Contatena todos os elementos de lst0.
(examples
 (check-equal? (concatena empty) "")
 (check-equal? (concatena (list "casa " "da" " sogra")) "casa da sogra"))
(define (concatena lst0)
  ; o uso de acumuladores evita o uso de memória extra para manter as chamdas das funções
  ; acc - concatenação dos elementos de lst0 já visitados
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst)
                  (string-append acc (first lst)))]))
  ; ou (foldl (λ (e acc) (string-append acc e)) "" lst0)
  (iter lst0 ""))


;; Lista(String) -> Natural
;; Determina o tamanho máximo entre todas as strings de lst0.
(examples
 (check-equal? (max-tam empty) 0)
 (check-equal? (max-tam (list "casa" "da" "sogra")) 5))
(define (max-tam lst0)
  ; o uso de acumuladores evita o uso de memória extra para manter as chamdas das funções
  ; acc - tamanho máximo das strings de lst0 já visitadas
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst)
                  (max (string-length (first lst)) acc))]))
  ; ou (foldl (λ (e acc) (max (string-length e) acc)) 0 lst0)
  (iter lst0 0))
