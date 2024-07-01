#lang racket

(require examples)

(struct retangulo (largura altura) #:transparent)
;; Representa um retângulo
;; - largura: natural - a largura do retângulo
;; - altura: natural - a largura do retângulo

(struct circulo (raio) #:transparent)
;; Representa um circulo
;; - raio: natural - o raio do círculo

;; Figura é um dos valores
;; - (retangulo natural natural)
;; - (ciculo natural)


(define PI 3.14)


;; Figura -> Real
;; Calcula a área de fig.

(examples
  (check-= (area (retangulo 3.0 4.0)) 12.0 0.0)
  (check-= (area (circulo 2.0)) 12.56 0.0))

(define (area fig)
  (cond
    [(retangulo? fig) (* (retangulo-altura fig)
                         (retangulo-largura fig))]
    [(circulo? fig) (* PI
                       (sqr (circulo-raio fig)))]))


;; Figura -> Boolean
;;
;; Produz #t se a figura a cabe dentro da figura b, #f caso contrário.
;;
;; A seguinte tabela mostra as condições para a figura a caber
;; dentro da figura b. da é a diagonal da figura a se a é um retângulo.
;;
;; fig a \ fig b     |   (retangulo lb ab)      | (circulo rb)
;; ------------------|--------------------------|---------------
;; (retangulo la aa) |  la <= lb e aa <= ab     |  da <= 2 * rb
;; (circulo ra)      |  2*ra <= lb e 2*ra <= ab |  ra <= rb

(examples
  ; retangulo x retangulo
  (check-equal? (figura-cabe? (retangulo 5 18)
                              (retangulo 10 20)) #t)
  (check-equal? (figura-cabe? (retangulo 10 20)
                              (retangulo 10 20)) #t)
  (check-equal? (figura-cabe? (retangulo 11 20) ; largura não cabe
                              (retangulo 10 20)) #f)
  (check-equal? (figura-cabe? (retangulo 10 21) ; altura não cabe
                              (retangulo 10 20)) #f)
  ; retangulo (diagonal 5) x circulo
  (check-equal? (figura-cabe? (retangulo 3 4)
                              (circulo 3)) #t)
  (check-equal? (figura-cabe? (retangulo 3 4)
                              (circulo 2.5)) #t)
  (check-equal? (figura-cabe? (retangulo 3 4)
                              (circulo 2.4)) #f)
  ; circulo x retangulo
  (check-equal? (figura-cabe? (circulo 2)
                              (retangulo 4 4)) #t)
  (check-equal? (figura-cabe? (circulo 2)
                              (retangulo 4 4)) #t)
  (check-equal? (figura-cabe? (circulo 2)
                              (retangulo 3 4)) #f) ; não cabe na largura
  (check-equal? (figura-cabe? (circulo 2)
                              (retangulo 4 3)) #f) ; não cabe na altura
  ; circulo x circulo
  (check-equal? (figura-cabe? (circulo 2)
                              (circulo 3)) #t)
  (check-equal? (figura-cabe? (circulo 3)
                              (circulo 3)) #t)
  (check-equal? (figura-cabe? (circulo 4)
                              (circulo 3)) #f))

(define (figura-cabe? a b)
  (cond
    [(and (retangulo? a) (retangulo? b))
     (and (<= (retangulo-largura a)
              (retangulo-largura b))
          (<= (retangulo-altura a)
              (retangulo-altura b)))]
    [(and (retangulo? a) (circulo? b))
     (define da (sqrt (+ (sqr (retangulo-largura a))
                         (sqr (retangulo-altura a)))))
     (<= da (* 2 (circulo-raio b)))]
    [(and (circulo? a) (retangulo? b))
     (define da (* 2 (circulo-raio a)))
     (and (<= da (retangulo-largura b))
          (<= da (retangulo-altura b)))]
    [(and (circulo? a) (circulo? b))
     (<= (circulo-raio a) (circulo-raio b))]))
