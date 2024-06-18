#lang racket

(require examples)

; Análise
;
; Selecionar a(s) parte(s) de uma mensagem que deve(m) ser exibida(s) em um
; letreiro em um determinado momento.
; - A quantidade de caracteres que pode ser exibida no letreiro é menor
;   que a quantidade de caracteres da mensagem
; - O momento pode assumir os valores 0, 1, 2, ...
; - Supondo que s é uma string com infinitas repeticoes da mensagem
;   separadas por espaço, então no momento m é preciso exibir uma
;   string que é igual a substring de s que começa em m e a mesma
;   quantidade de caracteres do letreiro.
;

; Tipos de dados
; A mensagem é representada por uma string
; O momento por um número natural


;; Natural String Natural -> String
;;
;; Seleciona partes de msg para serem exibidas no momento m
;; em um letreiro que tem espaço para tam caracteres.
;;
;; Se consideramos s sendo uma string com infinitas repeticoes
;; de msg separadas por espaço, então essa função produz uma
;; resposta que é equivalente a substring de s que começa
;; na posição m e tem tam caracteres.
;;
;; Requer que a quantidade de caracteres de msg seja maior que tam.
(examples
  ; Exemplos simplificados
  (check-equal? (msg-letreiro 4 "Entrada" 0) "Entr")
  (check-equal? (msg-letreiro 4 "Entrada" 1) "ntra")
  (check-equal? (msg-letreiro 4 "Entrada" 2) "trad")
  (check-equal? (msg-letreiro 4 "Entrada" 3) "rada")
  (check-equal? (msg-letreiro 4 "Entrada" 4) "ada ")
  (check-equal? (msg-letreiro 4 "Entrada" 5) "da E")
  (check-equal? (msg-letreiro 4 "Entrada" 6) "a En")
  (check-equal? (msg-letreiro 4 "Entrada" 7) " Ent")
  (check-equal? (msg-letreiro 4 "Entrada" 8) "Entr")
  (check-equal? (msg-letreiro 4 "Entrada" 9) "ntra")

  ; Exemplos do caso de uso
  (check-equal? (msg-letreiro 20 "Promocao de sorvetes, pague 2 leve 3!" 0)
                "Promocao de sorvetes")
  (check-equal? (msg-letreiro 20 "Promocao de sorvetes, pague 2 leve 3!" 1)
                "romocao de sorvetes,")
  (check-equal? (msg-letreiro 20 "Promocao de sorvetes, pague 2 leve 3!" 2)
                "omocao de sorvetes, ")
  (check-equal? (msg-letreiro 20 "Promocao de sorvetes, pague 2 leve 3!" 17)
                "tes, pague 2 leve 3!")
  (check-equal? (msg-letreiro 20 "Promocao de sorvetes, pague 2 leve 3!" 18)
                "es, pague 2 leve 3! ")
  (check-equal? (msg-letreiro 20 "Promocao de sorvetes, pague 2 leve 3!" 19)
                "s, pague 2 leve 3! P")
  (check-equal? (msg-letreiro 20 "Promocao de sorvetes, pague 2 leve 3!" 37)
                " Promocao de sorvete"))
(define (msg-letreiro tam msg m)
  (define msg-dup (string-append msg " " msg))
  (define inicio (remainder m (add1 (string-length msg))))
  (define fim (+ inicio tam))
  (substring msg-dup inicio fim))
