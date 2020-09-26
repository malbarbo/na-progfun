#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;
;; Definição de Ponto

(struct ponto (x y) #:transparent)
;; Ponto representa um ponto no plano cartesiano
;;   x : Número - a coordenada x
;;   y : Número - a coordenada y
;; Exemplos
#; (define p1 (ponto 3 4))
#; (define p2 (ponto 8 2))
;; Modelo
#;
(define (fun-for-ponto p)
  (... (ponto-x p)
       (ponto-y p)))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.1

;; Ponto -> Número
;; Calcula a distância de um ponto a origem.
(examples
 (check-equal? (distancia-origem (ponto 3 4)) 5))

(define (distancia-origem p)
  (sqrt (+ (sqr (ponto-x p))
           (sqr (ponto-y p)))))


;;;;;;;;;;;;;;;;;;;;
;; Exemplo 3.2

(struct retangulo (largura altura) #:transparent)
;; Representa um retangulo
;;   largura : Número - a largura do retangulo
;;   altura  : Número - a altura do retangulo
;; Exemplos
#; (define r1 (retangulo 3 4))
#; (define r2 (retangulo 1 2))
;; Modelo
#;
(define (fun-for-retangulo r)
  (... (retangulo-largura r)
       (retangulo-altura r)))

;; Retangulo -> String
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
