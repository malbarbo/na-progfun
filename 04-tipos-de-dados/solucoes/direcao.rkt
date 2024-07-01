#lang racket

(require examples)

;; Direção é um dos valores
;; - "norte"
;; - "leste"
;; - "sul"
;; - "oeste"
;;
;; E representa os pontos cardiais de acordo com o esboço a seguir
;;
;;       Norte
;;         |
;; Oeste -   - Leste
;;         |
;;        Sul


;; Direcao -> Direcao
;;
;; Produz a direção oposta de d.

(examples
  (check-equal? (direcao-oposta "norte") "sul")
  (check-equal? (direcao-oposta "sul") "norte")
  (check-equal? (direcao-oposta "leste") "oeste")
  (check-equal? (direcao-oposta "oeste") "leste"))

(define (direcao-oposta d)
  (cond
    [(equal? d "norte") "sul"]
    [(equal? d "sul") "norte"]
    [(equal? d "leste") "oeste"]
    [(equal? d "oeste") "leste"]))


;; Direcao -> Direcao
;;
;; Devolve a direcao que está a 90 graus no sentido horario de d.

(examples
  (check-equal? (direcao-90-horario "norte") "leste")
  (check-equal? (direcao-90-horario "leste") "sul")
  (check-equal? (direcao-90-horario "sul") "oeste")
  (check-equal? (direcao-90-horario "oeste") "norte"))

(define (direcao-90-horario d)
  (cond
    [(equal? d "norte") "leste"]
    [(equal? d "leste") "sul"]
    [(equal? d "sul") "oeste"]
    [(equal? d "oeste") "norte"]))


;; Direcao -> Direcao
;;
;; Devolve a direcao que está a 90 graus no sentido anti-horario de d.

(examples
  (check-equal? (direcao-90-anti-horario "norte") "oeste")
  (check-equal? (direcao-90-anti-horario "leste") "norte")
  (check-equal? (direcao-90-anti-horario "sul") "leste")
  (check-equal? (direcao-90-anti-horario "oeste") "sul"))

(define (direcao-90-anti-horario d)
  (direcao-90-horario
    (direcao-90-horario
      (direcao-90-horario d))))
