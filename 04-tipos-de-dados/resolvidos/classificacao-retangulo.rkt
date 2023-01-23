#lang racket

(require examples)

;; Classificacao é um dos valores:
;; - "largo"
;; - "alto"
;; - "quadrado"

(struct retangulo (largura altura) #:transparent)
;; Representa um retangulo
;;   largura : Número - a largura do retangulo
;;   altura  : Número - a altura do retangulo

;; Retangulo -> Classificação
;; Classifica um retangulo em:
;;   largo    se largura > altura
;;   alto     se altura > largura
;;   quadrado se largura = altura
(examples
 (check-equal? (classifica-retangulo (retangulo 4 3)) "largo")
 (check-equal? (classifica-retangulo (retangulo 4 6)) "alto")
 (check-equal? (classifica-retangulo (retangulo 5 5)) "quadrado"))

(define (classifica-retangulo r)
  (cond
    [(> (retangulo-largura r) (retangulo-altura r)) "largo"]
    [(< (retangulo-largura r) (retangulo-altura r)) "alto"]
    [else "quadrado"]))
