#lang racket

(require examples)

(struct resolucao (altura largura) #:transparent)
;; Representa a resolução de uma imagem ou tela
;;  - altura: natural - número de linhas de pixels
;;  - largura: natural - número de colunas de pixels

;; Aspecto é um dos valores
;; - "16:9"
;; - "3:4"
;; - "outro"
;; E representa o aspecto de uma resolução.


;; Resolucao -> Real
;;
;; Calcula a quantidade de pixels (em megapixels) de uma
;; imagem com resolucação r.

(examples
  (check-= (resolucao-em-megapixels (resolucao 360 640)) 0.2304 0.0)
  (check-= (resolucao-em-megapixels (resolucao 1024 768)) 0.786432 0.0))

(define (resolucao-em-megapixels r)
  (/ (* (resolucao-altura r) (resolucao-largura r))
     1000000))

;; Resolucao Resolucao -> Boolean
;;
;; Produz #t se a imagem com resolucao i pode ser exibida na tela
;; com resolucao t sem a necessidade de rotação ou redução de tamanho isso é,
;; se a altura da imagem é menor ou igual a altura da tela e a largura da imagem
;; é menor ou igual a largura da tela. Produz #f caso contrário.

(examples
  (check-equal? (imagem-cabe-na-tela? (resolucao 300 400)
                                      (resolucao 330 450)) #t)
  (check-equal? (imagem-cabe-na-tela? (resolucao 330 450)
                                      (resolucao 330 450)) #t)
  (check-equal? (imagem-cabe-na-tela? (resolucao 331 400) ; altura não cabe
                                      (resolucao 330 450)) #f)
  (check-equal? (imagem-cabe-na-tela? (resolucao 330 451) ; largura não cabe
                                      (resolucao 330 450)) #f))

(define (imagem-cabe-na-tela? i t)
  (and (<= (resolucao-altura i) (resolucao-altura t))
       (<= (resolucao-largura i) (resolucao-largura t))))


;; Resolucao -> Aspecto
;;
;; Determina o aspecto da resolucao r.
;; Uma resolução altura x largura tem aspecto x:y se altura * x = largura * y.
;; Os valores de x e y considerados são aqueles da definição do tipo Aspecto.

(examples
  (check-equal? (aspecto (resolucao 1024 768)) "3:4")
  (check-equal? (aspecto (resolucao 1080 1920)) "16:9")
  (check-equal? (aspecto (resolucao 600 600)) "outro"))

(define (aspecto r)
  (cond
    [(= (* (resolucao-altura r) 3)
        (* (resolucao-largura r) 4))
     "3:4"]
    [(= (* (resolucao-altura r) 16)
        (* (resolucao-largura r) 9))
     "16:9"]
    [else "outro"]))
