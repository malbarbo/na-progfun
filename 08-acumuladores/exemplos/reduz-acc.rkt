#lang racket

(require examples)

;; Usando a técnica para criar funções abstratas a partir de exemplos,
;; criamos a função reduz-acc baseado nas funções (com acumulador)
;; tamanho, soma e inverte.

;; (X Y -> Y) Y Lista(X) -> Y
;; (reduz-acc f base (list x1 x2 ... xn) devolve
;; (fn xn ... (f2 x2 (f x1 base)))
;; Veja a função pré-definida foldl.
(define (reduz-acc f base lst0)
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst)
                  (f (first lst) acc))]))
  (iter lst0 base))


;; Funções originais
#;
(define (tamanho lst0)
  ;; acc - a quantidade de elementos já vistos de lst0
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst) (add1 acc))]))
  (iter lst0 0))

#;
(define (soma lst0)
  ;; acc - a soma dos elementos já visitados de lst0
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else
       (iter (rest lst) (+ (first lst) acc))]))
  (iter lst0 0))

#;
(define (inverte lst0)
  ;; acc - os elementos já visitados de lst0 em ordem inversa.
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst)
                  (cons (first lst) acc))]))
  (iter lst0 empty))


;; Implementação das funções originais usando reduz-acc

(define (tamanho lst)
  (define (soma1-no-segundo a b)
    (add1 b))
  (reduz-acc soma1-no-segundo 0 lst))

(define (soma lst)
  (reduz-acc + 0 lst))

(define (inverte lst)
  (reduz-acc cons empty lst))


